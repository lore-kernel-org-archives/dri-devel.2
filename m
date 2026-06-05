Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F84CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95F811A64E;
	Fri,  5 Jun 2026 09:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jB+Qa5Q2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337D711A64E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 09:31:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7831E601E3;
 Fri,  5 Jun 2026 09:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75A1F00893;
 Fri,  5 Jun 2026 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780651913;
 bh=bft1VtHxPr1uzTroZzkxG3mIw3DDy/k/ALDXN0pvO0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jB+Qa5Q2nCANDr5yuE5h0v1+1Df3IWj7HmKO9Cao8u0dOByKKe5Nh5W2/2hdEp9jm
 vTSsK/1tca+ze1Oq/Tx5x+mFJ78ZuUSXsTkKyZi/8PXKqlZ/m44y0TL+2U+9rkGTNn
 ZqTVPcMy/ejCFFgLfJ5OwyuKZFikiQYLHi7NR4da1qzqb/lgNvru63fdwFHFe6hXBB
 XBUSP/eyj2WUvMeidO18hShcL/7f4QBcOPJE2/YvvQEQDH2vHYel2CjyqnUNYMG01L
 ouf5HHYx0Gv+kpz7l7ELvk6phEXF10SZnJXsQdOnleeSNe+WJ3GYEbCT+FnYh54pFp
 gOrTCGXND4mMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix fence reference leak in
 amdgpu_gfx_run_cleaner_shader_job
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605091803.6018-1-vulab@iscas.ac.cn>
References: <20260605091803.6018-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:31:52 +0000
Message-Id: <20260605093153.0F75A1F00893@smtp.kernel.org>
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
- [Critical] The indirect buffer (IB) allocation size is hardcoded to 64 by=
tes, but the initialization loop writes up to 1024 bytes based on the ring'=
s alignment mask, leading to a severe out-of-bounds write.
- [High] The error handling branch for `dma_fence_wait` is dead code becaus=
e uninterruptible waits with infinite timeouts do not return errors, result=
ing in silently ignored hardware failures.
--

commit 154fe15a3810311348d132047ef742f38daab7b7
Author: Wentao Liang <vulab@iscas.ac.cn>
drm/amdgpu: fix fence reference leak in amdgpu_gfx_run_cleaner_shader_job

This commit addresses a potential fence reference leak in the error path of
amdgpu_gfx_run_cleaner_shader_job(). It adds a dma_fence_put() before jumpi=
ng
to the error label when dma_fence_wait() fails.

>     However, if dma_fence_wait() fails (e.g., due to a signal interruptio=
n),
>     the code jumps to the error label without calling dma_fence_put(),
>     resulting in a reference leak.

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
dma_fence_wait() to fail due to a signal interruption here?

Since dma_fence_wait(f, false) calls dma_fence_wait_timeout() with
intr =3D false and an infinite timeout, it seems it cannot be interrupted by
signals or timeout, and will always return 0.

[Severity: Critical]
This is a pre-existing issue, but can the initialization loop write past the
end of the allocation?

Looking earlier in amdgpu_gfx_run_cleaner_shader_job():

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:amdgpu_gfx_run_cleaner_shader_job()=
 {
	...
	r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
				     64, 0, &job,
				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
	...
	ib =3D &job->ibs[0];
	for (i =3D 0; i <=3D ring->funcs->align_mask; ++i)
		ib->ptr[i] =3D ring->funcs->nop;
	...
}

The indirect buffer is allocated with a hardcoded size of 64 bytes, but the
loop writes up to ring->funcs->align_mask + 1 dwords.

If the alignment mask is 0xff (255) for modern GFX compute rings, this would
write 256 dwords (1024 bytes), which exceeds the 64 byte allocation and may
corrupt subsequent blocks in the memory pool.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9e..2784306400a81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1729,8 +1729,10 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>  	f =3D amdgpu_job_submit(job);
> =20
>  	r =3D dma_fence_wait(f, false);
> -	if (r)
> +	if (r) {
> +		dma_fence_put(f);
>  		goto err;
> +	}
        ^^^^

[Severity: High]
This is a pre-existing issue, but does this make the error handling branch
dead code?

If dma_fence_wait() always returns 0, the newly added dma_fence_put() would
be unreachable.

Additionally, if the cleaner shader job hangs and the fence completes with =
an
error, would the failure be silently ignored since f->error is not checked?

> =20
>  	dma_fence_put(f);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605091803.6018=
-1-vulab@iscas.ac.cn?part=3D1
