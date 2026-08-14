Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1089BC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBAC10E25D;
	Fri, 14 Aug 2026 00:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cXRW1gSq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383DC10E25D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:21:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6505408E2;
 Fri, 14 Aug 2026 00:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F7D1F000E9;
 Fri, 14 Aug 2026 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786666878;
 bh=yRRTpjuZs9HB42i4b+pyMh/yJH3A58wKhsJuQ8pQBTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cXRW1gSqpddJ2zIV4N160wEYokf7NpnA9GaCkT4KVawJ1/32LEZzk07uHVuI1OYMk
 EGnnAR8n5X7vexguwrTj8TAbONt/bQuhrjry439vVahby7XYUmUo1S2d0bARzppE2a
 RDn6oRWCjNcuWcUq1sLMlDhNx4Q6os/jmXrNxYP5K8Oc0MsYSCZ9J3QahUw4fJ++9q
 /aUz88NPrsSwaE+VOF1dXuLURTcSxtjs/6u8yfxbJZQ5C2UPqWG6oL9VfC/8MvPuck
 gbsqE64QUt402i4NlvCMaSV41qV0sDuUWvfIXNfXaOONzaTYg5g45qzEvbDSarXCdW
 KfU6yXHHAhZsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260414-fix-vbios-v2-4-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-4-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:21:18 +0000
Message-Id: <20260814002118.80F7D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unchecked slice indexing using a firmware-derived offset can panic=
 and crash the kernel.
- [High] Unchecked subtraction on untrusted firmware data can underflow and=
 panic.
--

--- Patch [4]: [PATCH v2 04/11] gpu: nova-core: vbios: use checked access i=
n `FwSecBiosImage::header` ---
commit 90813931dc3fe4cfc37444ced769050fbff9b8d3
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: vbios: use checked access in FwSecBiosImage::header

This patch safely handles firmware-derived values in FwSecBiosImage::header
by using checked access .get() instead of direct slice indexing.

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 632c8a90ea765..bc752d135cbfd 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
[ ... ]

drivers/gpu/nova-core/vbios.rs:FwSecBiosBuilder::setup_falcon_data() {
    ...
        if pmu_in_first_fwsec {
            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
                &self.base.dev,
                &first_fwsec.base.data[offset..],
            )?);
        } else {
            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
                &self.base.dev,
                &self.base.data[offset..],
            )?);
        }
    ...
}

[Severity: High]
This is a pre-existing issue, but since this patch addresses unchecked
firmware accesses, I noticed these slice operations might lack upper bounds
checks. If a malformed firmware provides a large, out-of-bounds pointer,
could the offset exceed the length of the vector and cause a panic?


drivers/gpu/nova-core/vbios.rs:FwSecBiosBuilder::setup_falcon_data() {
    ...
            Ok(entry) =3D> {
                let mut ucode_offset =3D usize::from_safe_cast(entry.data);
                ucode_offset -=3D pci_at_image.base.data.len();
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for this
subtraction on untrusted firmware data to underflow? If entry.data is
smaller than the PCI-AT image length, could this cause a panic or lead to
out-of-bounds accesses later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-fix-vbios-=
v2-0-705d30d16bba@nvidia.com?part=3D4
