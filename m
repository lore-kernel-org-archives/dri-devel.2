Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA8C79FB9
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60D310F11D;
	Wed,  9 Sep 2026 12:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LHz+P7kS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1446110F11D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:42:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27F5E6022F;
 Wed,  9 Sep 2026 12:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84301F00A3A;
 Wed,  9 Sep 2026 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788957769;
 bh=t0+xHLoL46Y6z0W/1xFeGEFxDN0+twr4aZYZ7qYjdq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LHz+P7kSipB2FnoirgedhBRngGtZT3oVneQXtQhiygyl8ZyE3Kz/8Svr3xWvoy1WF
 J8jj/ad1GEXQi+1JHuP5ITWRMNMiYf49R+jbCijkOjDoCWxb64TTV596ykjYYhPDF0
 I+Wo6YSYbIci9yhm/uMzuiaT5bOAhPy/fu/h2LnEFVixQbotpmUkXTw59mC6P3MM2r
 mMlvIOj8SKmU4xGtxczhBwlIEYge1CLMmbFxf9PvFTS34gVGVYIHS+A2BDlyLdfZX+
 vMJZMttRy7nBRsRtgA4TeC6u2nOp0CJXaos0l04MoYyWVu4IcN1aibEHQVldGl1osv
 FpGobzGAhZrWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] eventfd: Add scope-based cleanup capability
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-efd-autofree-v1-1-c6c3c19cc702@arm.com>
References: <20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com>
 <20260909-efd-autofree-v1-1-c6c3c19cc702@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:42:49 +0000
Message-Id: <20260909124249.A84301F00A3A@smtp.kernel.org>
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
- [High] The DEFINE_FREE wrapper for eventfd lacks an IS_ERR_OR_NULL check.=
 When used with eventfd_ctx_fdget() or eventfd_ctx_fileget() (which return =
ERR_PTR on failure), the cleanup routine will pass the error pointer to eve=
ntfd_ctx_put(), bypassing its NULL check and causing a kernel panic when de=
referenced.
--

commit f893599e482de1bd276a121a5c34c8f30a6546ce
Author: Bence Csokas <bence.csokas@arm.com>

eventfd: Add scope-based cleanup capability

This commit introduces a scope-based cleanup capability for eventfd context=
s,
allowing eventfd_ctx_put() to be used with the RAII-inspired __free() API.

> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 9d33a02757d52..24111a16284f1 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -102,6 +102,9 @@ static void eventfd_free(struct kref *kref)
>   */
>  void eventfd_ctx_put(struct eventfd_ctx *ctx)
>  {
> +	if (!ctx)
> +		return;
> +
>  	kref_put(&ctx->kref, eventfd_free);

[Severity: High]
Does this release function adequately protect against error pointers?

It appears to only guard against NULL, so if the __free wrapper invokes this
function with an ERR_PTR, it seems like it will bypass this check and
cause a kernel panic when dereferencing ctx->kref.

>  }
>  EXPORT_SYMBOL_GPL(eventfd_ctx_put);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index e32bee4345fb9..689358c2b0ae7 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
[ ... ]
> @@ -89,5 +90,7 @@ static inline void eventfd_signal(struct eventfd_ctx *c=
tx)
>  	eventfd_signal_mask(ctx, 0);
>  }
> =20
> +DEFINE_FREE(eventfd, struct eventfd_ctx *, eventfd_ctx_put(_T))

[Severity: High]
Is this cleanup wrapper safe to use with functions like eventfd_ctx_fdget()
or eventfd_ctx_fileget() that return ERR_PTR on failure?

Because this wrapper lacks an IS_ERR_OR_NULL check, if a getter fails and
returns an ERR_PTR, the early return path will pass the error pointer to
eventfd_ctx_put(), bypassing its NULL check. This seems to violate the
cleanup function compatibility guidelines and could lead to a crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-efd-autofr=
ee-v1-0-c6c3c19cc702@arm.com?part=3D1
