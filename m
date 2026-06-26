Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6882C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E74F10F69D;
	Fri, 26 Jun 2026 15:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQA+32EA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE53210F69D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:13:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0E0140499;
 Fri, 26 Jun 2026 15:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737B51F000E9;
 Fri, 26 Jun 2026 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486796;
 bh=DzPEYZTmcCBqX3fJpwhIeP0yzFBmIkqfa8s1nJT+plg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQA+32EACLBYWObpI8/hPSrAM4zKsZ1vF/O6F/UG9JdmAIG7ul3664kzu5aPoSACy
 6Dt/rNhqB7EV/Mbojl7xG233R0vb0yXmQ5hCrsR8kT6pMwxCjJhdFGqKvkB3VwyziL
 IQPrBjmmvJbuXgg/4Uq2HQvxnlqmnC8lyJ3CpSerzwH+/bSzG6x6lnKsCDG0TCmxMw
 Ii1KyTUXxqraefxTeKFi8E2I99KcVNQRwz3T+YvMjMbfV6t9OHduNtmfhjg2pISG+o
 fTPmM+XBaEC7YTvSMmflpfdX/sUsl1IP5fQEzFcKcvl0+JH4rAk62LyK2/Yz7kwqu9
 XhbhS8gH4O+UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/vmwgfx: ttm_base_object_init: fix tfile
 reference leak on error   paths
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626145946.49620-1-vulab@iscas.ac.cn>
References: <20260626145946.49620-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:13:16 +0000
Message-Id: <20260626151316.737B51F000E9@smtp.kernel.org>
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
- [High] Premature exposure of the object to the IDR in `ttm_base_object_in=
it` allows concurrent threads to acquire a reference before initialization =
completes, leading to a Use-After-Free if initialization fails.
--

commit 2a16041f7a57ed8c7355b93de9b4469d336c4166
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/vmwgfx: ttm_base_object_init: fix tfile reference leak on error pa=
ths

This commit fixes a tfile reference leak on error paths in
ttm_base_object_init by ensuring ttm_object_file_unref is called when
idr_alloc or ttm_ref_object_add fails.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functi=
onality to the vmwgfx driver")

> diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx=
/ttm_object.c
> index 2421b0dd057c0..93ae5a07d70ab 100644
> --- a/drivers/gpu/drm/vmwgfx/ttm_object.c
> +++ b/drivers/gpu/drm/vmwgfx/ttm_object.c

[ ... ]

> @@ -218,6 +218,10 @@ int ttm_base_object_init(struct ttm_object_file *tfi=
le,
>  	spin_lock(&tdev->object_lock);
>  	idr_remove(&tdev->idr, base->handle);
>  	spin_unlock(&tdev->object_lock);

[Severity: High]
This is a pre-existing issue, but does returning an error here after
briefly exposing the object in the IDR lead to a use-after-free?

In ttm_base_object_init(), idr_alloc() makes the object globally
visible before initialization completes. If ttm_ref_object_add() then
fails, this error path removes the object from the IDR and returns the
error to the caller, which will typically free the object's memory.

Could a concurrent thread grab a reference to this object from the IDR
between the idr_alloc() and this idr_remove()? For example, a thread
could guess the handle and use an ioctl to fetch the object via
ttm_base_object_lookup_for_ref().=20

If that concurrent thread successfully increments the reference count
during this window, and the original thread returns an error that causes
the caller to forcefully free the memory, wouldn't the concurrent thread
be left holding a dangling pointer to freed memory?

> +	ttm_object_file_unref(&base->tfile);
> +	return ret;
> +err_unref_tfile:
> +	ttm_object_file_unref(&base->tfile);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626145946.4962=
0-1-vulab@iscas.ac.cn?part=3D1
