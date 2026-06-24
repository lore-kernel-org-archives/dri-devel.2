Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6790DCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEDB10E0E0;
	Wed, 24 Jun 2026 18:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gc8cLCcG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B2A10E0E0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:44:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2257B44027;
 Wed, 24 Jun 2026 18:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A401F000E9;
 Wed, 24 Jun 2026 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782326685;
 bh=I83lEEuSSG9fHjB/6EPyVi+wPEDVRyxkoGzAm+6SAU0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gc8cLCcGDqgAiwa6Sww/4q91fvWTQRnksoU7iGdXD1g13t8kev+Y+AwdN8dANh3Rg
 /WpgGrMBOwY+M1lnys8Jhs2QAwsryHYPG80bPehzKHaPcFeJ4G7tXw51p/9mq2niSS
 cA66fnalQPh6iP4wBKecsUhMMAj/MQEBzFhxeGS9ZZp6Aj8PigPQwIFOHQ+KM3CSX4
 finIk2TL8LzZT5CaN38BayhbvBomtepjhb0IVc3Via632v3ESzkM1/y9fqxeGaZuba
 mjLkHB4Yyw93OAt7GS5ozzQL5hOZ5UEy0eWXTnpLEa4Xx5vYwfkSD9C/kCRA3EfR3Y
 KeCmX1aHM4HqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/discovery: fix OOB read via unchecked
 die_offset in IP discovery parsing
To: "Pavitra Jha" <jhapavitra98@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624183409.1079288-1-jhapavitra98@gmail.com>
References: <20260624183409.1079288-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 18:44:44 +0000
Message-Id: <20260624184444.D4A401F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch identifies but fails to fix out-of-bounds reads caused b=
y unbounded ip_offset advancement.
- [High] Missing bounds check for firmware-controlled num_dies before acces=
sing the die_info array.
- [High] Missing bounds checks for basic header offsets in the discovery bi=
nary parser.
--

commit 9d6788c99594a0d1857e6cde0b70c40338a5e49f
Author: Pavitra Jha <jhapavitra98@gmail.com>

drm/amdgpu/discovery: fix OOB read via unchecked die_offset in IP discovery=
 parsing

This commit adds bounds checking for die_offset against adev->discovery.size
in three IP discovery parsing functions. It aims to prevent out-of-bounds
reads when processing firmware-controlled die_offset values.

> The ip_offset advancement inside the inner loop also uses
> struct_size(ip, base_address, ip->num_base_address) where
> num_base_address is firmware-controlled, enabling unbounded advancement
> past the allocation on each iteration.

[Severity: High]
This is a pre-existing issue, but the commit message identifies this unboun=
ded
advancement as a root cause, yet the patch doesn't seem to include a bounds
check for it in the loop.

Should there be a check against adev->discovery.size for ip_offset inside t=
he
inner loop as well, to prevent reading past the end of the allocation when
dereferencing the advanced ip_offset?


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index be5069642a907..41ca01e2bb6fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -774,6 +774,11 @@ static void amdgpu_discovery_read_harvest_bit_per_ip=
(struct amdgpu_device *adev,
>  	/* scan harvest bit of all IP data structures */

[Severity: High]
This is a pre-existing issue, but does the construction of the ihdr pointer
lack bounds checking?

In amdgpu_discovery_read_harvest_bit_per_ip(), ihdr is constructed using an
unchecked offset:

ihdr =3D (struct ip_discovery_header *)(discovery_bin +
             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));

Could an invalid firmware-provided offset cause an out-of-bounds read when
ihdr is later dereferenced?

>  	for (i =3D 0; i < num_dies; i++) {
>  		die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);

[Severity: High]
This is a pre-existing issue, but is it possible for num_dies to exceed the
fixed array size of 16 for die_info?

Since num_dies is firmware-controlled, could an unchecked value cause an
out-of-bounds read when accessing ihdr->die_info[i]?

> +		if (die_offset + sizeof(*dhdr) > adev->discovery.size) {
> +			dev_err(adev->dev, "invalid die_offset %u in harvest table\n",
> +				die_offset);
> +			return;
> +		}
>  		dhdr =3D (struct die_header *)(discovery_bin + die_offset);
>  		num_ips =3D le16_to_cpu(dhdr->num_ips);
>  		ip_offset =3D die_offset + sizeof(*dhdr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624183409.1079=
288-1-jhapavitra98@gmail.com?part=3D1
