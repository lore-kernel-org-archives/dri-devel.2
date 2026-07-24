Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA86C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8703910E002;
	Fri, 24 Jul 2026 07:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O2Taiv8N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C63910E002
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:16:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B445600AA;
 Fri, 24 Jul 2026 07:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A31F000E9;
 Fri, 24 Jul 2026 07:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784877367;
 bh=QzCOElfkN2lrjlgqSiSvtMtMB9vg70biI9vGX0w/2v0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O2Taiv8NZhVBYX9FVlSh8GPICOgr86n45XlMbIy6QnouYDnESldquSyu+QnVdMFD5
 RruzEvQILH/oi7D1qIOlO1N4s4FbGBwMqI5iJjNnefxc/6XXbuOXzfYb1thfEBPAAT
 wbtx5Jd6IG5DUjrDp/2Q27MbHcSv7Yi8vQapEPTL/FlZgk0j2JiPT2mHAh8QR68Ale
 Tw3nliChw6yDgBHGpDa1kXBpoFX4eEt709QQhZgw50v+Wf0DbUVWNIZCnPmZ7uvRbe
 3TAjC1bh3U0KpnVSZnpnet3h3uyT7vdqKXqdF7HLhWUKb0euleAuv/AYL6v7TB75iY
 7f9cPRIVnrbGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 07:16:06 +0000
Message-Id: <20260724071607.6A8A31F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Brittle Logic / Incorrect Condition for 2MiB alignment

Pre-existing issues:
- [Critical] Architecture/Memory Layout Mismatch
--

--- Patch [1]: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset ca=
lculation ---
commit 281515add8e49de6b8ca823d190ac6318796ffcf
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: correct FRTS vidmem offset calculation

The commit updates how the FRTS vidmem offset is calculated for the FSP Cha=
in
of Trust message. It calculates this offset using a new per-architecture
reserved size at the end of the framebuffer, plus the PMU reserved size.

> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 1475485bded32..30e53df81aa2f 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -134,20 +134,31 @@ struct FspCotMessage {
>  }
> =20
>  impl FspCotMessage {
> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. =
It is measured from the end
> +    /// of the framebuffer.
> +    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -=
> Result<u64> {
> +        let mut offset =3D u64::from(hal.fb_end_reserved_size());
> +

[Severity: Critical]
This is a pre-existing issue, but by updating frts_vidmem_offset() to use
hal.fb_end_reserved_size() + pmu_reserved_size, there is now a mismatch with
how FbLayout::new() calculates the FRTS base address.

FbLayout::new() calculates frts_base by subtracting frts_size directly from
vga_workspace.start:

drivers/gpu/nova-core/fb.rs:FbLayout::new() {
    let frts =3D {
        ...
        let frts_size: u64 =3D hal.frts_size();
        let frts_base =3D vga_workspace.start.align_down(FRTS_DOWN_ALIGN) -=
 frts_size;
        ...
    }
}

This completely omits the PMU reserved memory space. For architectures like
GB202, FbLayout places FRTS ~2MiB from the end of the framebuffer, while the
FSP is told it is located ~28MiB from the end.

Could this discrepancy cause a regression where the host driver loads the G=
SP
firmware into physical memory locations that contradict the FSP's memory
protection firewall?

> +        if fb_layout.pmu_reserved_size !=3D 0 {
> +            offset =3D (offset + u64::from(fb_layout.pmu_reserved_size))
> +                // The 2 MiB alignment is r570-specific.
> +                .align_up(Alignment::new::<SZ_2M>())
> +                .ok_or(EINVAL)?;
> +        }

[Severity: Medium]
Is it brittle to gate the 2MiB alignment behind fb_layout.pmu_reserved_size=
 !=3D 0?

The comment notes this alignment is r570-specific. Using the presence of a =
PMU
reservation as a proxy for checking if the firmware is r570 (or CoT version=
 >=3D 2)
could cause a regression if a future architecture or firmware requires the
alignment but lacks a PMU reservation.

Could this proxy logic fail if an architecture has no PMU reservation but u=
ses
r570-compatible firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-blackwell-=
fixes-v3-0-01aa6a54e3fd@nvidia.com?part=3D1
