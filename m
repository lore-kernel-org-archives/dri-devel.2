Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC80C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0655810E4CE;
	Thu,  2 Jul 2026 17:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ddzc6MFg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E58910E4CE
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 17:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 006FA41B06;
 Thu,  2 Jul 2026 17:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7481F000E9;
 Thu,  2 Jul 2026 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783012012;
 bh=v+s8J6qBl0tr0zYR9XW8bFC4iyd5nl8iVHUhP0GFeDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ddzc6MFg1r/voIlwbWjWEeELismUTkA1hZ5C8YL9Jvc+xMmrONInmnz31j25BGq0b
 LrNTC3cShB1wWE1QcIWs+xtPAwA45Xz+Zbj2BVhqi7P3NRx2WLujyY17ltgR9M9NCM
 szMCxw6RnnO4tbDCvRg3Z8aQMnKC0TPDTMwMYCLhf1Env4LWmRE/xBJ8py/Wnvn1YV
 d2HzG30tzovtIfWJVW9P0pfuMWvRMtbLe0AU6aIGSeom/+O1UGvrM8uQmlhLNt2VMn
 pIXgYMlnjRw+Kwz5NItYDpIoYEouTUrve/EVzxqzpPT5cN6JxATaCrvxHyvyUWnhCa
 yJ7FcKydjesKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info
To: =?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <982728e51afbb9d400372e98676ad76335a56410.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
 <982728e51afbb9d400372e98676ad76335a56410.1783009338.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:06:52 +0000
Message-Id: <20260702170652.AB7481F000E9@smtp.kernel.org>
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
- [Medium] Missing newline in debugfs output for buffer objects without fen=
ces.
--

commit 642a225a01d32a7d60ac3ca80f3eb6f52693b3f4
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info

This commit aims to avoid printing extra newlines in the amdgpu_gem_info
debugfs output. It does this by moving the newline into the lock failure
path when attempting to dump buffer object fences.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1696,8 +1696,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *=
bo, struct seq_file *m)
>  	if (dma_resv_trylock(bo->tbo.base.resv)) {
>  		dma_resv_describe(bo->tbo.base.resv, m);
>  		dma_resv_unlock(bo->tbo.base.resv);
> +	} else {
> +		seq_puts(m, "\n");
>  	}
> -	seq_puts(m, "\n");
> =20
>  	return size;
>  }

[Severity: Medium]
Will this cause garbled debugfs output for buffer objects that do not have
any fences attached?

When dma_resv_trylock() succeeds, amdgpu_bo_print_info() calls
dma_resv_describe(). Looking at dma_resv_describe() in
drivers/dma-buf/dma-resv.c:

void dma_resv_describe(struct dma_resv *obj, struct seq_file *seq)
{
	...
	dma_resv_for_each_fence(&cursor, obj, DMA_RESV_USAGE_READ, fence) {
		seq_printf(seq, "\t%s fence:", ...);
		dma_fence_describe(fence, seq);
	}
}

If there are no fences, dma_resv_describe() iterates zero times and prints
nothing. Because the unconditional newline was moved to the lock-failure
branch, the success path for a fenceless buffer object now prints nothing
at all.

This means the next item dumped in the debugfs file will be concatenated on=
to
the same line, breaking readability and parsing tools. Should a newline sti=
ll
be printed when the lock succeeds but no fences are present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783009338.gi=
t.mirq-linux@rere.qmqm.pl?part=3D5
