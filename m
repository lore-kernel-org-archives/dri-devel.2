Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FD1C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C5210E2A5;
	Mon, 31 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Um5YuA6x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043F610E2A5
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3267436EF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B701F000E9;
 Mon, 31 Aug 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186272;
 bh=bitNRGXd5XudoKar5XvUjrbISkJJO6GDvfAPq8Qubww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Um5YuA6xRrVFUohT/Cdzy7W+6G00HE0lVsdHTOMPx+erh3qq8Pr/wWUOzkRptrfTR
 oDjRav4n6GIWrTnGBAdwf42s7au1oJbuX7lpRyKRpAmIRXy4inETF9O7mUf+QFBOps
 fPSAmWqSSY63a6lVpkmes/higsy7lW/OPAsebjcGjytQo7dt3x+USDvFvlFEdW04Bm
 iHzwW9aauBt7FxasjEO5GBuYFDOFnfZcdKE/ldPUbXGm8/eTF4OPZ6msp+fPHYdJGR
 m4eK+kJratWYPWnfl6jZ2umednns1iVcdixepC4MAizECBnN4bZtSCT5SCD9Vpzeg2
 q+I9dojmF+hPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amd/ras: Fix CPER ring debugfs read
 overflow
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-100-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-100-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:24:32 +0000
Message-Id: <20260831142432.A0B701F000E9@smtp.kernel.org>
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

New issues:
- [Medium] start_dw calculation truncates loff_t offset to u32.

Pre-existing issues:
- [High] Return of large positive value on put_user() failure due to u32 ca=
st.
- [High] Out-of-bounds read and logic failure in CPER header parsing due to=
 strcmp on non-null-terminated string.
--

commit d9222ea52dbe9a1b917e7fed4e52fd495f722397
Author: Xiang Liu <xiang.liu@amd.com>

drm/amd/ras: Fix CPER ring debugfs read overflow

The legacy CPER debugfs reader can reach the payload path without a valid
pointer snapshot, and treats user byte count as ring occupancy in dwords.
This commit fixes the overflow by taking the CPER lock before sampling
pointers, properly bounding the payload copy, and advancing the file positi=
on.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 5ec5c3ff22bb0..f3a891124250a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c

[ ... ]

> @@ -546,13 +547,24 @@ static ssize_t amdgpu_debugfs_ring_read(struct file=
 *f, char __user *buf,
>  			*pos +=3D 4;
>  		}
>  	} else {
> +		early[0] =3D amdgpu_ring_get_rptr(ring) & ring->buf_mask;
> +		early[1] =3D amdgpu_ring_get_wptr(ring) & ring->buf_mask;
> +
>  		p =3D early[0];
>  		if (early[0] <=3D early[1])
> -			size =3D (early[1] - early[0]);
> +			avail_dw =3D early[1] - early[0];
>  		else
> -			size =3D ring->ring_size - (early[0] - early[1]);
> +			avail_dw =3D ring->buf_mask + 1 - (early[0] - early[1]);
> =20
> -		while (size) {
> +		start_dw =3D (*pos > 12) ? ((*pos - 12) >> 2) : 0;
> +		if (start_dw >=3D avail_dw)
> +			goto out;

[Severity: Medium]
Does this code truncate the 64-bit file position into a 32-bit variable?

When start_dw is calculated, pos is a pointer to loff_t, but the offset is
assigned to a u32 variable. If a user calls pread() on the debugfs file
with an offset exceeding ~17GB (0x400000000 bytes), start_dw could
overflow. This would lead to incorrect EOF evaluation, wrapping around and
returning cyclic data instead of returning 0 for EOF.

> +
> +		p =3D (p + start_dw) & ring->ptr_mask;
> +		avail_dw -=3D start_dw;
> +		read_dw =3D min_t(u32, avail_dw, size >> 2);
> +
> +		while (read_dw) {
>  			if (p =3D=3D early[1])
>  				goto out;
> =20
> @@ -565,9 +577,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file =
*f, char __user *buf,
> =20
>  			buf +=3D 4;
>  			result +=3D 4;
> -			size--;
> +			read_dw--;
>  			p++;
>  			p &=3D ring->ptr_mask;
> +			*pos +=3D 4;
>  		}

[Severity: High]
This is a pre-existing issue, but can a put_user() failure result in a large
positive return value being sent to userspace here?

Looking at the unquoted code just above this in amdgpu_debugfs_ring_read():

    r =3D put_user(value, (uint32_t *)buf);
    if (r) {
        result =3D r;
        goto out;
    }

Because result is declared as a u32 variable, assigning a negative error
code (like -EFAULT) casts it to a huge positive integer. When this is
returned as ssize_t to userspace, it hides the actual error and breaks
the read() syscall contract by falsely reporting ~4GB of data read.

[Severity: High]
This is another pre-existing issue, but does the CPER header parsing have an
out-of-bounds read and logic failure?

Looking at amdgpu_cper_ring_get_ent_sz() and amdgpu_cper_is_hdr() in
drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c, they both use strcmp() on a 4-byte
non-null-terminated character array:

amdgpu_cper.c:amdgpu_cper_ring_get_ent_sz() {
    ...
    if (!strcmp(chdr->signature, "CPER")) {
        rec_len =3D chdr->record_length;
    ...
}

amdgpu_cper.c:amdgpu_cper_is_hdr() {
    ...
    return strcmp(chdr->signature, "CPER") ? false : true;
}

Because the signature field is only 4 bytes and the 5th byte in the struct
is the non-zero revision field, strcmp() will always return non-zero,
breaking CPER header detection entirely. This also causes an out-of-bounds
read that could cross a page boundary at the end of the ring buffer
allocation.

Additionally, if pos is near the end of the buffer mask, accessing
chdr->record_length also reads 20 bytes past the end of the ring buffer
allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-100-sashal@kernel.org?part=3D1
