Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0363ECDB466
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 07:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F4310E318;
	Sun, 21 Jun 2026 07:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eJjn0RRq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAFD10E318
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 07:05:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E1F943F2E;
 Sun, 21 Jun 2026 07:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF091F000E9;
 Sun, 21 Jun 2026 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782025555;
 bh=+3R0G4GRoJdbQOqyZvllYaJObfxVMz+5rYAEq0IlrgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eJjn0RRqeqrlgvq5J+yAE2ZczQhvsI6icTBPk815pjnWyc6ktsiLQGJ4tD4yV7D6o
 7vWm9t/LX+A4DsISA/lwIpmSo1nMHUaKz3wElYRoPY6xlQxWKZe6hvYMeW7v92jS7g
 N04tQFS+tQoSfbQI7rypTh4Ct3+wbt2OsODYWcahwNtLLPFJ9o7ZoUIP/h9LxhRBZ4
 Ny7/XI/IdqNnYSWc+N5DzXzZ4oYq3pVtN+WMw2YhWjaa+cc1PEmH9V2CgMY24T+kUX
 IE/TetpOxTDEsYqNuCVP4dhseI3NSmqiUE5npnD+7FJBlzOSldjcUFumMwrMkBhDi4
 aBpsp8mz4hQGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/umsch: free UMSCH resources on debug BO
 allocation failure
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260621065257.3780075-1-haoxiang_li2024@163.com>
References: <20260621065257.3780075-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 07:05:54 +0000
Message-Id: <20260621070555.2AF091F000E9@smtp.kernel.org>
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
- [High] Unvalidated header_size allows out-of-bounds read in debugfs node.
- [Medium] Resource leak on IP block initialization failure paths.
--

commit a513c879c542eea03995c30cb8fc3fe49117d147
Author: Haoxiang Li <haoxiang_li2024@163.com>

drm/amdgpu/umsch: free UMSCH resources on debug BO allocation failure

The commit adds resource cleanup for cmd_buf_obj and wb_index in=20
umsch_mm_init(). It fixes a resource leak that occurs if the debug BO=20
allocation fails.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_umsch_mm.c
> index cd707d70a0bf8..622cc7320fa83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -300,6 +300,10 @@ static int umsch_mm_init(struct amdgpu_device *adev)
>  				    &adev->umsch_mm.log_cpu_addr);
>  	if (r) {
>  		dev_err(adev->dev, "(%d) failed to allocate umsch debug bo\n", r);
> +		amdgpu_bo_free_kernel(&adev->umsch_mm.cmd_buf_obj,
> +			      &adev->umsch_mm.cmd_buf_gpu_addr,
> +			      (void **)&adev->umsch_mm.cmd_buf_ptr);
> +		amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
>  		return r;
>  	}

[Severity: Medium]
This is a pre-existing issue, but does umsch_mm_sw_init() also leak=20
resources if umsch_mm_ring_init() fails?

drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:umsch_mm_sw_init() {
	...
	r =3D umsch_mm_ring_init(&adev->umsch_mm);
	if (r)
		return r;
	...
}

In the IP block framework, if the sw_init callback fails, the framework ski=
ps
calling the corresponding sw_fini teardown function. Returning directly from
umsch_mm_sw_init() without unwinding seems to permanently leak the resource=
s=20
allocated by umsch_mm_init().=20

Does a similar issue exist in umsch_mm_hw_init()?

drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:umsch_mm_hw_init() {
	...
	r =3D umsch_mm_set_hw_resources(&adev->umsch_mm);
	if (r)
		return r;
	...
}

If umsch_mm_set_hw_resources() fails, the function returns directly, which
appears to leak the firmware objects previously allocated in=20
umsch_mm_load_microcode().

[Severity: High]
This isn't a bug introduced by this patch, but could=20
amdgpu_debugfs_umsch_fwlog_read() allow out-of-bounds memory access due to=
=20
unvalidated plog->header_size?

drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:amdgpu_debugfs_umsch_fwlog_rea=
d() {
	...
		available =3D read_num[0] + write_pos - plog->header_size;
	...
			if (read_pos =3D=3D AMDGPU_UMSCHFW_LOG_SIZE)
				read_pos =3D plog->header_size;
	...
}

Because plog->header_size is read directly from volatile memory, could a=20
modified value cause an integer underflow when calculating available and=20
read_num?=20

When read_pos wraps, it is updated to this unvalidated header_size, which=20
might cause the subsequent copy_to_user() to copy out-of-bounds kernel or I=
/O=20
memory.=20

Additionally, it appears the error handling for copy_to_user() might=20
be masking partial faults by using if (read_num[i] =3D=3D copy_to_user(...)=
).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621065257.3780=
075-1-haoxiang_li2024@163.com?part=3D1
