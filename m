Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D6DC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D855610E26C;
	Wed,  5 Aug 2026 22:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dIHHUsYM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DDF10E26C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 22:06:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9308C43BA5;
 Wed,  5 Aug 2026 22:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B661F000E9;
 Wed,  5 Aug 2026 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785967589;
 bh=jyWqumjJY8AT0e439NCGgASVSRImJkwp5TVE7Ae/QXY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dIHHUsYMoy6f4BRgX2PZ4bPDSD/nM9V6iGc0ic/I4nvMbPRQyjYmeXYrKb4DUKDH2
 msK1mn2GF+cczTRvYlm0krRMiIS55G1hm/11Kc1F78JdJMcWKlcMcBBdhWXT4n/ky8
 mveSzZPQHhUzuN+cpL/JGGlVnNJX+Q7d3ycAEHEh4bnfVxlkb2v3KVOhZkXQGgXGrw
 f9ZODGYSikiuFEh0M4JupxlciC8AYvKIW++JcmAXrnP2qSWPTLFZEH87psXB+Cprue
 DqTzCiiI/D0vj7SsjEFLzmKecraEp1AemYFu2+3bQ1t8uFm51kpG0QbSSFewzKULbj
 mdbvV/Wd/blog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] gpu: nova-core: gsp: map the WPR meta for streaming
 DMA
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260805-dma-streaming-v1-3-03974c86b141@mailbox.org>
References: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
 <20260805-dma-streaming-v1-3-03974c86b141@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 22:06:28 +0000
Message-Id: <20260805220629.28B661F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary memory and DMA mapping leak on early failure paths i=
n `hal.boot()`.
--

--- Patch [3]: [PATCH 3/3] gpu: nova-core: gsp: map the WPR meta for stream=
ing DMA ---
commit 3c4ae11167b244d18dae6296df30ee5e35af6eb1
Author: Maurice Hieronymus <mhi@mailbox.org>

gpu: nova-core: gsp: map the WPR meta for streaming DMA

This commit changes the WPR metadata mapping from a coherent allocation
to a streaming DMA transfer. It intentionally drops the mapping in flight
without completing it if the boot sequence fails, to prevent a device-side
use-after-free.

> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 8afb62d689cb4..300ebf4e843d6 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
[ ... ]
> @@ -131,6 +139,14 @@ pub(crate) fn boot(
>              sec2_falcon,
>          )?;
> =20
> +        // The chipset-specific boot sequence only succeeds once the dev=
ice is done reading the
> +        // WPR metadata: on Tu102 the Booter-load falcon has halted, on =
GH100 GSP-FMC has released
> +        // the lockdown. If it fails instead, `wpr_meta` drops in flight=
 and leaks, as the falcon
> +        // may still be reading the buffer.
> +        //
> +        // SAFETY: Per the above, the device has finished accessing the =
buffer.
> +        let _ =3D unsafe { wpr_meta.complete() };

[Severity: Medium]
The patch intentionally drops wpr_meta in flight if hal.boot() returns an
error to avoid a device-side use-after-free. However, does this uncondition=
ally
leak the memory and DMA mapping even on early failures where hardware access
is structurally impossible?

For example, looking at Gh100::boot() in drivers/gpu/nova-core/gsp/hal/gh10=
0.rs,
an error can occur early:

Gh100::boot() {
    ...
    let fsp_fw =3D FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
    ...
}

This happens before the device is given the DMA handle.

Similarly in drivers/gpu/nova-core/gsp/hal/tu102.rs:

Tu102::boot() {
    ...
    let bios =3D Vbios::new(dev, bar)?;
    ...
}

This also happens before the hardware is given the DMA handle via
BooterFirmware::run().

Because hal.boot() only borrows wpr_meta by reference, Gsp::boot() cannot
distinguish whether the error occurred before or after the DMA address was
handed to the hardware. Consequently, it leaks the buffer on any error.

Could the design be adjusted to only leak the buffer if the error happens
after the hardware actually receives the DMA handle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-dma-stream=
ing-v1-0-03974c86b141@mailbox.org?part=3D3
