Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C671DC61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 08:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBBE10E0D4;
	Sat, 29 Aug 2026 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TvvNno0x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148AC10E0CE
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:23:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1329060055;
 Sat, 29 Aug 2026 08:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AEA1F000E9;
 Sat, 29 Aug 2026 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787991814;
 bh=jfmhjt2N5noH17yVGXRZjporBqzhKkykzIJYbvMs3dE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TvvNno0xkig9UjEdzvcpZWF+l/es/TKbQa8PTiI+uX7xY4kPt5syuVLe7SCG4OT6B
 ofMjAetDxWvwkbxMWIE6s34JcyAiqdap6zCpG1LgOGJnjm5wEgvG0j+w7aif3Yovep
 5oo2NGA2K5/P45FYjYdxG55OKw/qXhmO8PZVbUQphj9UISMY6dWXTMmhKlx+y6rrsa
 YrJjEgLz7Hj8CashpDAw3xOP0rKnGHyL9wu6RIR1WcDiCjhWM+/CRO/bxzIE4b/am1
 DrOyKxNcwDe6vBMhTIQEvCPnt5ZdtTPNp/PjH0TkLq4qvWue07cFA8nboRDP7vnzP5
 yKVY/0c9xdS+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: fix NULL deref and GEM object leak in
 error paths
To: "Deniz Aydogan" <denizaydogan1902@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829080016.10002-1-denizaydogan1902@gmail.com>
References: <20260829080016.10002-1-denizaydogan1902@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 08:23:34 +0000
Message-Id: <20260829082334.93AEA1F000E9@smtp.kernel.org>
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
- [High] Incomplete fix for NULL pointer dereference of `job->cmd_bo` durin=
g internal driver command cleanup.
--

commit 85570ac4a3fda867670c08161dee7f7bfee5d853
Author: Deniz Aydogan <denizaydogan1902@gmail.com>

accel/amdxdna: fix NULL deref and GEM object leak in error paths

amdxdna_cmd_submit() does not set job->cmd_bo for internal driver
commands that pass AMDXDNA_INVALID_BO_HANDLE. If arg BO lookup fails
after that, the cmd_put cleanup calls amdxdna_gem_put_obj(NULL) which
dereferences a NULL pointer.

Separately, amdxdna_cmd_set_error() acquires a GEM reference via
amdxdna_gem_get_obj() when handling a chained command, but leaks it
when the subsequent amdxdna_gem_vmap() returns NULL.

Add a NULL check in the submit cleanup path and release the GEM
reference on vmap failure.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 31a414c3f0d96..c0444454afe6a 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -676,7 +678,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>  put_bos:
>  	amdxdna_arg_bos_put(job);
>  cmd_put:
> -	amdxdna_gem_put_obj(job->cmd_bo);
> +	if (job->cmd_bo)
> +		amdxdna_gem_put_obj(job->cmd_bo);

[Severity: High]
This isn't a bug introduced by this patch, but does the same unconditional =
NULL
pointer dereference occur in the normal job completion cleanup path?

If userspace issues a configuration IOCTL (such as DRM_AMDXDNA_HWCTX_ASSIGN=
_DBG_BUF)
that submits an internal driver command, job->cmd_bo is deliberately left as
NULL during submission.

When the job completes, the DRM scheduler invokes aie2_sched_job_free() ->
aie2_job_release() -> amdxdna_sched_job_cleanup(), which unconditionally
calls amdxdna_gem_put_obj():

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_sched_job_cleanup() {
    ...
    amdxdna_pm_suspend_put(job->hwctx->client->xdna);
    amdxdna_arg_bos_put(job);
    amdxdna_gem_put_obj(job->cmd_bo);
    dma_fence_put(job->fence);
    ...
}

Will this cause a kernel panic if job->cmd_bo is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829080016.1000=
2-1-denizaydogan1902@gmail.com?part=3D1
