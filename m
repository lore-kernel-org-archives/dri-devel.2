Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F9C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22BA10E905;
	Mon, 31 Aug 2026 14:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RN7MErBy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D348910E93C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:00:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57CE360200
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6F1F00A3E;
 Mon, 31 Aug 2026 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788184815;
 bh=7+vlZba+9ekvD+ukcQW/DydVJvBMQ09f9a2Ry4CBdRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RN7MErBySC6eDFMQ4I+f4Twdp+b5u+LqZxNdwmJMZf3nOf2hCvGgqkoaOlVRr3hTc
 RJfMf3mk1agE/blXgVvWADlylIXV4/5ghqfBFl0qSHm8h7OOCKHHtXxTD8u1g4BWRo
 nGSRmN93AKa6XEcwjQjPUBSl0kxHrZDOIVt00C+6Hqc09KOCo7S/O7bf19JXzD9Z+n
 oledHqpHn7vzh7+xIi7L2YITkER+8QKeVkbrmVEuQ0D53+PvYUrv5YFHBqRkGgaY0J
 /MwLUgvNIxoZJ4e4LeyVWB4bkjsU2OjYdWsCUoYzXkQJNuqNir8ZU3yKRQBkVSnTpN
 L1+tGjaO0YD+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] drm/amdgpu: validate and share PSP
 fw_pri_buf copies via psp_copy_fw
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-38-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-38-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:00:14 +0000
Message-Id: <20260831140014.DEE6F1F00A3E@smtp.kernel.org>
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
- [Critical] Unvalidated `pos` parameter in `amdgpu_psp_vbflash_write` allo=
ws out-of-bounds heap write.
- [High] Concurrent sysfs read and write operations on `psp_vbflash` can ca=
use a Use-After-Free on `vbflash_tmp_buf`.
- [High] Uninitialized kernel heap memory can be leaked to SPI ROM due to l=
ack of buffer zeroing.
--

commit 0f415f32d1c8f6a02dd5dfbd6b22a7a6a71cda35
Author: Candice Li <candice.li@amd.com>
Subject: drm/amdgpu: validate and share PSP fw_pri_buf copies via psp_copy_=
fw

Change psp_copy_fw from void to int: return -ENODEV when drm_dev_enter
fails, and -EINVAL when the image size is zero or larger than the
1 MiB PSP private buffer. Replace open-coded memset/memcpy into fw_pri_buf
with psp_copy_fw.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
[ ... ]

While reviewing the changes in this file, I noticed a few pre-existing issu=
es
in the psp_vbflash sysfs handlers that might need attention:

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:amdgpu_psp_vbflash_write() {
	...
	if (!adev->psp.vbflash_tmp_buf) {
		adev->psp.vbflash_tmp_buf =3D kvmalloc(AMD_VBIOS_FILE_MAX_SIZE_B,
						     GFP_KERNEL);
		if (!adev->psp.vbflash_tmp_buf)
			return -ENOMEM;
	}

	mutex_lock(&adev->psp.mutex);
	memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
	...
}

[Severity: Critical]
This is a pre-existing issue, but does this code overflow vbflash_tmp_buf?

Because the size is set to 0 in psp_vbflash_bin_attr, the sysfs core does
not restrict the pos offset. The function checks if vbflash_image_size
exceeds the maximum size, but it does not validate if pos + count is larger
than AMD_VBIOS_FILE_MAX_SIZE_B.

If userspace calls pwrite on the psp_vbflash sysfs file with a large pos,
could this write arbitrarily far past the allocated heap buffer?


drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:amdgpu_psp_vbflash_read() {
	...
rel_buf:
	kvfree(adev->psp.vbflash_tmp_buf);
	adev->psp.vbflash_tmp_buf =3D NULL;
	...
}

[Severity: High]
This is a pre-existing issue, but could this cause a use-after-free on
vbflash_tmp_buf?

The sysfs handlers amdgpu_psp_vbflash_read() and amdgpu_psp_vbflash_write()
can be called concurrently. In both amdgpu_psp_vbflash_read() and the error
path of amdgpu_psp_vbflash_write(), kvfree() is called without holding
adev->psp.mutex.

If a concurrent write is executing memcpy() to the buffer while holding the
mutex, and another thread frees it outside the lock here, could this result
in memory corruption?


drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:amdgpu_psp_vbflash_write() {
	...
	if (!adev->psp.vbflash_tmp_buf) {
		adev->psp.vbflash_tmp_buf =3D kvmalloc(AMD_VBIOS_FILE_MAX_SIZE_B,
						     GFP_KERNEL);
	...
}

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:amdgpu_psp_vbflash_read() {
	...
	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf,
		    adev->psp.vbflash_image_size);
	...
}

[Severity: High]
This is a pre-existing issue, but does this leak uninitialized kernel memor=
y?

In amdgpu_psp_vbflash_write(), the buffer is allocated using kvmalloc()
which does not zero the memory. If userspace writes a small amount of data
at a non-zero offset, the beginning of the buffer remains uninitialized.

When amdgpu_psp_vbflash_read() later copies vbflash_image_size bytes from
the start of this buffer to the GPU VRAM via memcpy_toio(), could this
expose uninitialized kernel heap data to the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-38-sashal@kernel.org?part=3D1
