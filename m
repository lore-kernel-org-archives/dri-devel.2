Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A12C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BE010E56E;
	Wed,  8 Jul 2026 06:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dmnooxcb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ED810E56E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:30:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D755439F8;
 Wed,  8 Jul 2026 06:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607CD1F000E9;
 Wed,  8 Jul 2026 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783492201;
 bh=tzYhtSLmEPwRP9qUvDSutK+XXAvMPy/QIsKwJ6Rx5Ac=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DmnooxcbrD0/CvptO+IC0wEyggVC7FSIYfoAfGOOvgUT2z7JpegFVTr4ElK5yQ66m
 iY+YhCMHlX66Jd6+/j2+Q/EBas6VGIjr4bbOhiGEcxZPAnYw1A1W8ItJ1EmI8Dbm3R
 HEsWWWnR0IeuHgx9DXTFBSe5TK6Qc4lgGbBaicE8hLT2SkfrdIXNHFwFTcqZwrweyo
 5htAxZpyxN0Np613ViteuYuuiVun/vqrNkEJPn8GN7qbNWBGDrc/QX+ZHz4f4aTGK4
 hADaa0vUPLRNcHiyKr9CQHgsfxDp/2DLSJ+2a1LElP7rxjouq58EF0CaNvSXoRmeIc
 2EhtTNkZHtpSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before
 IP discovery header cast
To: "Pavitra Jha" <jhapavitra98@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708061835.111986-1-jhapavitra98@gmail.com>
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
 <20260708061835.111986-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 06:30:00 +0000
Message-Id: <20260708063001.607CD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] Misapplied patch hunk causes compilation errors.

Pre-existing issues:
- [High] The intended security fix is completely missing from `amdgpu_disco=
very_get_table_info`, leaving out-of-bounds reads unpatched.
- [High] The newly added offset validation only checks the start offset, fa=
iling to verify that the structure fits within the buffer.
- [High] Missing validation for downstream table sizes and internal offsets=
 causes out-of-bounds reads during parsing and checksum verification.
- [High] Direct array access for IP_DISCOVERY table offsets breaks for vers=
ion 2 binaries.
--

--- Patch [1]: [PATCH v2] drm/amdgpu/discovery: validate table offset befor=
e IP discovery header cast ---
commit 9aac939f5a3fe8366dddb94f326456646c35f228
Author: Pavitra Jha <jhapavitra98@gmail.com>

drm/amdgpu/discovery: validate table offset before IP discovery header cast

The commit intends to validate the firmware-controlled table offset before
casting it to the IP discovery header to prevent out-of-bounds reads. It
aims to add offset checks in both the common parsing path and direct access
sites.

> Fix by validating the table offset in amdgpu_discovery_get_table_info(),
> which is the common path used by all callers except
> amdgpu_discovery_read_harvest_bit_per_ip() (which reads

[Severity: High]
This isn't a bug introduced by this patch, but the commit message states the
fix is added to amdgpu_discovery_get_table_info(), while the diff actually
applies the validation hunk to amdgpu_discovery_verify_npsinfo() instead.=20

Since amdgpu_discovery_get_table_info() remains unpatched, doesn't this lea=
ve
the shared table parsing paths vulnerable to out-of-bounds reads when parsi=
ng
firmware data?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a015d55aa158e..07544bcfaf2ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -531,6 +531,12 @@ static int amdgpu_discovery_verify_npsinfo(struct am=
dgpu_device *adev,
>  		return -EINVAL;
>  	}
> =20
> +	if (le16_to_cpu((*info)->offset) >=3D adev->discovery.size) {
> +		dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
> +			le16_to_cpu((*info)->offset), table_id);
> +		return -EINVAL;
> +	}
> +

[Severity: Low]
Does this compile?=20

In amdgpu_discovery_verify_npsinfo(), info is a single pointer of type stru=
ct
table_info *info, making (*info)->offset invalid C syntax. Additionally,
table_id is undeclared in this function. It appears this hunk was intended
for amdgpu_discovery_get_table_info() but was misapplied here.

[ ... ]
> @@ -803,6 +809,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip=
(struct amdgpu_device *adev,
>  	int i, j;
> =20
>  	bhdr =3D (struct binary_header *)discovery_bin;

[Severity: High]
This is a pre-existing issue, but does unconditionally casting to
struct binary_header * work for version 2 binaries?=20

Since version 2 binaries (struct binary_header_v2) insert num_tables and
padding before the table_list array, wouldn't accessing
bhdr->table_list[IP_DISCOVERY].offset read from those fields instead,
leading to incorrect offset calculations and out-of-bounds accesses?

> +
> +	if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=3D
> +	    adev->discovery.size) {

[Severity: High]
This is a pre-existing issue, but does this check adequately prevent
out-of-bounds reads?=20

The check only verifies that the start offset is within the buffer bounds. =
If
an offset is placed at the very end of the buffer, wouldn't the subsequent
read of ihdr->num_dies access memory beyond the buffer since the structure
size is not validated?

> +		dev_err(adev->dev, "invalid IP_DISCOVERY table offset %u\n",
> +			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
> +		return;
> +	}
> +
>  	ihdr =3D (struct ip_discovery_header
>  			*)(discovery_bin +
>  			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));

[Severity: High]
This is a pre-existing issue, but are downstream table sizes and internal
offsets validated to prevent out-of-bounds reads?

For example, in amdgpu_discovery_read_harvest_bit_per_ip(), ip_offset is
declared as a uint16_t:

	ip_offset +=3D struct_size(ip, base_address,
				 ip->num_base_address);

Could a struct_size() overflow result in SIZE_MAX being truncated to a
smaller value by uint16_t, thereby defeating built-in overflow protections?

Additionally, in amdgpu_discovery_init(), is it possible for the size
calculation to underflow?

	size =3D le16_to_cpu(bhdr->binary_size) - offset;

If binary_size is less than offset, this underflow could lead to a large
out-of-bounds read in the checksum verification loop.=20

Similarly, in amdgpu_discovery_table_check(), table_size is read from heade=
rs
and passed directly to amdgpu_discovery_verify_checksum(). Is there a check
to ensure it fits within the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708061835.1119=
86-1-jhapavitra98@gmail.com?part=3D1
