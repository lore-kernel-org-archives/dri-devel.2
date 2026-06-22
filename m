Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11D3CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AED510E5BB;
	Mon, 22 Jun 2026 09:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fsYyFLzN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F198E10E5BB
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:39:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FF746008A;
 Mon, 22 Jun 2026 09:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC1C1F000E9;
 Mon, 22 Jun 2026 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782121170;
 bh=ecr7P2/muGWxlPHtk5oikchz6DTJUBDbk+xLSp4dW1g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fsYyFLzNnhTlhoXpSEbN/Wf1iddNGi1bObUV9naP6VSCRVN+OHeqkY1PT/VAY/4Rf
 OoY3X9YQd00fMnjz8sYwKNPvlR5KtHRXtV7bPzVXXKN96wVllKXpcTKvF9X8oD6A5m
 VTTcuF3XRRSlfxeF5tWhXXnfFlHsXJPc+l8Ce/HfrKeGgfusjjwd/q3XGHurJ+D1HI
 mOW6ZVqOSiFRJPRNT22HofWNlsm6DPGYVPwWs4ikUUBUXCGJupZb/BbLyw85DHLYVi
 BNuB91UOpj1BroqNGhjRPygG6cOSU1EPJvWgkhSKZTPQWumfyTegmGhj9Hcjdzo2Ik
 /Ed0BeOZNjp6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/amdgpu: move debug_vm handling to
 amdgpu_cs_parser_fini
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:39:29 +0000
Message-Id: <20260622093929.EEC1C1F000E9@smtp.kernel.org>
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
- [High] Moving `amdgpu_vm_bo_invalidate()` to `amdgpu_cs_parser_fini()` ac=
cesses BO structures without holding their `dma_resv` reservation locks, le=
ading to data races, potential use-after-free vulnerabilities, and lockdep =
assertions.
--

commit 130b94ccdb3ef241f2576b6d31544c37bb57192b
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

The commit restarts the CS if the validation is still in progress, but when
debug_vm is enabled, all BOs are invalidated, causing an infinite loop. This
patch moves the BO invalidation to amdgpu_cs_parser_fini to avoid that.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index d63fbc7c568de..7e75c536dab3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c

[ ... ]

> @@ -1382,6 +1369,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
>  /* Cleanup the parser structure */
>  static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>  {
> +	struct amdgpu_device *adev =3D parser->adev;
> +	struct amdgpu_bo_list_entry *e;
>  	unsigned int i;
> =20
>  	amdgpu_sync_free(&parser->sync);

[ ... ]

> @@ -1397,8 +1386,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs=
_parser *parser)
> =20
>  	if (parser->ctx)
>  		amdgpu_ctx_put(parser->ctx);
> -	if (parser->bo_list)
> +	if (parser->bo_list) {
> +		if (adev->debug_vm) {
> +			/* Invalidate all BOs to test for userspace bugs */
> +			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
> +				struct amdgpu_bo *bo =3D e->bo;
> +
> +				/* ignore duplicates */
> +				if (!bo)
> +					continue;
> +
> +				amdgpu_vm_bo_invalidate(bo, false);

[Severity: High]
Does moving this invalidation here result in accessing the BO structures
without their reservation locks?

Earlier in amdgpu_cs_parser_fini(), drm_exec_fini() is called to drop
all dma_resv locks acquired during parsing:

amdgpu_cs_parser_fini() {
...
    amdgpu_sync_free(&parser->sync);
    drm_exec_fini(&parser->exec);
...

Since amdgpu_vm_bo_invalidate() iterates over the bo->vm_bo list, which
is protected by the BO's reservation lock, could this unlocked access
lead to a data race or a use-after-free if it races with concurrent
mapping operations like amdgpu_vm_bo_del()?

Additionally, if any of the BOs are always-valid, this will eventually call
amdgpu_vm_bo_moved(), which triggers an amdgpu_vm_assert_locked(vm) lockdep
assertion since the root PD lock was already dropped.

> +			}
> +		}
>  		amdgpu_bo_list_put(parser->bo_list);
> +	}
> =20
>  	for (i =3D 0; i < parser->nchunks; i++)
>  		kvfree(parser->chunks[i].kdata);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622092859.3600=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D1
