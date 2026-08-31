Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2361C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0854210E2D7;
	Mon, 31 Aug 2026 16:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SijA2f49";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1CA10E2D7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:16:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA4A760120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6291F000E9;
 Mon, 31 Aug 2026 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788192982;
 bh=D9zZ204YHlicZLGl88HMBG9nFrN3fXymZHQGXS3Cz6U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SijA2f49MDWI4ZjcJErlKqI0xNFW5Py6kw0DtjkO8WwFNi0Pz3N72dtLhOUTWGHyn
 H04jGinAtRQ16/iSZ/ybIgTQAfs+kTqBVlr5UFcFPcDNyW0xTteK1zkqBtmltnJUPi
 uLT6Pu5rJXYP7/7j5Jb0yAJyGLt6CsO5SNXk1UE+AGWyJeslAKhsI8rIiQQ3/+VeLe
 1CbIxjiiOXyaK87JbmkzRxKOyHuansBlA7MVtl5lbGMx+TQWLVLBiOmCaXD36u2tZV
 E9WajHpLdx3Lybehm+pDt/F/4TaE2aICX2Su4Wl4Z6ZYZh1g/6bGzc3nrcQCnn9SZl
 K7oPBGfpHrvGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdgpu: fix buffer overflow during
 vBIOS update
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-406-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-406-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:16:21 +0000
Message-Id: <20260831161622.0C6291F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect accumulation of vbflash_image_size allows out-of-bounds =
reads and uninitialized memory disclosure.
- [High] Missing mutex locking during vbflash_tmp_buf allocation, access, a=
nd freeing leads to Use-After-Free, double frees, and memory leaks.
- [High] TOCTOU race condition on vbflash_image_size leads to an out-of-bou=
nds write into VRAM.
- [Medium] Unhandled cleanup of vbflash_tmp_buf causes a 16MB memory leak o=
n driver teardown.
--

commit 8e4215e84ef10c9caba9352b46954259d8b626c5
Author: Shiwu Zhang <shiwu.zhang@amd.com>

drm/amdgpu: fix buffer overflow during vBIOS update

This commit clamps the buffer position for writing by setting the bin
attribute to the maximum buffer size. This allows the VFS layer to block
out-of-bounds access.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4272,7 +4272,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file =
*filp, struct kobject *kobj,
>   */
>  static const struct bin_attribute psp_vbflash_bin_attr =3D {
>  	.attr =3D {.name =3D "psp_vbflash", .mode =3D 0660},
> -	.size =3D 0,
> +	.size =3D AMD_VBIOS_FILE_MAX_SIZE_B,
>  	.write =3D amdgpu_psp_vbflash_write,
>  	.read =3D amdgpu_psp_vbflash_read,
>  };

While reviewing this fix, I noticed a few pre-existing issues in the functi=
ons
referenced by this sysfs attribute.

[Severity: High]
This isn't a bug introduced by this patch, but does amdgpu_psp_vbflash_writ=
e()
incorrectly accumulate the byte count instead of tracking a high-water mark?

If a user with access to the sysfs node writes 16MB twice at pos 0, the fir=
st
write passes the VFS checks and sets the size to 16MB. The second write also
passes because 16MB > 16MB is false, setting the accumulated size to 32MB:

amdgpu_psp_vbflash_write() {
        ...
        memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
        adev->psp.vbflash_image_size +=3D count;
        ...
}

Later, when reading, it uses this oversized vbflash_image_size:

amdgpu_psp_vbflash_read() {
        ...
        memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf,
                    adev->psp.vbflash_image_size);
        ...
}

Could this result in a heap out-of-bounds read that copies sensitive kernel
data into the VRAM buffer?

[Severity: High]
This is a pre-existing issue, but is there a missing mutex around the buffer
allocation, access, and freeing?

Sysfs write and read functions can execute concurrently. In
amdgpu_psp_vbflash_write(), the buffer is allocated and freed outside of
adev->psp.mutex:

amdgpu_psp_vbflash_write() {
        if (pos >=3D AMD_VBIOS_FILE_MAX_SIZE_B) {
                kvfree(adev->psp.vbflash_tmp_buf);
                ...
        }
        ...
        if (!adev->psp.vbflash_tmp_buf) {
                adev->psp.vbflash_tmp_buf =3D kvmalloc(...);
        ...
}

Meanwhile, concurrent threads might be executing memcpy in write or
memcpy_toio in read. Could one thread trigger a size-limit error and free t=
he
buffer while another is actively copying to or from it, leading to a
use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but is there a TOCTOU race
condition on vbflash_image_size in amdgpu_psp_vbflash_read()?

The function performs lockless reads of vbflash_image_size. First it sizes
the VRAM buffer:

amdgpu_psp_vbflash_read() {
        ...
        ret =3D amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
                                      ... &fw_pri_cpu_addr);
        ...
}

And then it uses vbflash_image_size again for the copy:

amdgpu_psp_vbflash_read() {
        ...
        memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf,
                    adev->psp.vbflash_image_size);
        ...
}

If a concurrent sysfs write increments vbflash_image_size between these two
reads, will memcpy_toio copy more bytes than the BO can hold and write past
the end of the allocated VRAM buffer?

[Severity: Medium]
This is a pre-existing issue, but does this code leak the 16MB buffer on
driver teardown?

If a user stages a firmware update by writing to the sysfs node but never
triggers the read, the buffer remains allocated. When the driver is unbound,
teardown functions like psp_sw_fini() do not appear to check for or free
vbflash_tmp_buf:

psp_sw_fini() {
        ...
        /* missing kvfree(adev->psp.vbflash_tmp_buf) here? */
        ...
}

Can this result in a memory leak every time the device is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-406-sashal@kernel.org?part=3D1
