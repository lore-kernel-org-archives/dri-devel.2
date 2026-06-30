Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DFFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C51410ECC5;
	Tue, 30 Jun 2026 16:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaRmRkNM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95110ECBF
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:15:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2373C600BB;
 Tue, 30 Jun 2026 16:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B181F000E9;
 Tue, 30 Jun 2026 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782836106;
 bh=CHjwnecqoO3vJpRCs/gnrFnXhM7TYwx/uD7z9BtnrbI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CaRmRkNMillvb7kvX5utvqR77bUzG3UbVuJl/7oumajicLDBVOp+PoLNfWJtsMY0u
 XK01YEs9J77RtS2J82rZRuUABQMAe1FJtUGPTl9cAWc7NJHGvYYJtxvbvna3bN2mog
 oRQda29K+IC1sVrrMhxrRMpELni3m84dIpyiG0ihF5XCp0yrH/g9V8LfM/OZzuZneo
 HUXe6YqzOygfn27Ew8cPzBKZ25/z+p7Dp6nErWbvNgKnTb5Y8mXVLDmB+DMbToFnkd
 cUBUmoXGtb/dtWvC+mrp2JAGB/f+DkBb05PakhxFPAdAE55CXH95BJa4mqzVnKwfGl
 WMK833kULImgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma_buf: change unsigned int and int types into size_t
To: "Shahyan Soltani" <shahyan.soltani@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630160401.67544-1-shahyan.soltani@amd.com>
References: <20260630160401.67544-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 16:15:06 +0000
Message-Id: <20260630161506.A3B181F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] dma_fence_dedup_array() incorrectly returns 1 when called with=
 an empty array (num_fences =3D=3D 0), causing callers to read uninitialize=
d memory.
--

commit 49edb87cad117674d9feb38e78cfaf85af7320cb
Author: Shahyan Soltani <shahyan.soltani@amd.com>

dma_buf: change unsigned int and int types into size_t

This commit changes the integer types of variables in dma_fence_dedup_array=
()
and __dma_fence_unwrap_merge() to size_t to resolve inconsistencies. It also
updates the return type of dma_fence_dedup_array() accordingly.

> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fen=
ce-unwrap.c
> index 53bb40e70b277..65e87d263c3ac 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -93,9 +93,9 @@ static int fence_cmp(const void *_a, const void *_b)
>   *
>   * Return: Number of unique fences remaining in the array.
>   */
> -int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
> +size_t dma_fence_dedup_array(struct dma_fence **fences, size_t num_fence=
s)
>  {
> -	int i, j;
> +	size_t i, j;

[Severity: Critical]
This is a pre-existing issue, but does dma_fence_dedup_array() return the
wrong value when called with an empty array?

If num_fences is 0, the loop condition (i < num_fences) is false and skippe=
d.
The function then unconditionally returns ++j, which evaluates to 1 instead
of 0:

drivers/dma-buf/dma-fence-unwrap.c:dma_fence_dedup_array() {
	...
	j =3D 0;
	for (i =3D 1; i < num_fences; i++) {
		if (fences[i]->context =3D=3D fences[j]->context)
			dma_fence_put(fences[i]);
		else
			fences[++j] =3D fences[i];
	}

	return ++j;
}

Could this lead to an uninitialized memory dereference in callers?

For example, in amdgpu_userq_wait_return_fence_info(), if=20
wait_info->num_fences is 1 but zero handles are provided, it can pass a
1-element uninitialized fences array with num_fences =3D 0.

The caller relies on the return value of dma_fence_dedup_array() to know how
many fences to process:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_wait_return_fe=
nce_info() {
	...
	num_fences =3D dma_fence_dedup_array(fences, num_fences);
	...
	for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
		userq_fence =3D to_amdgpu_userq_fence(fences[i]);
		...
}

If dma_fence_dedup_array() returns 1 when passed 0, the caller will iterate
and dereference the uninitialized kmalloc memory at fences[0], which could
trigger a kernel panic.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630160401.6754=
4-1-shahyan.soltani@amd.com?part=3D1
