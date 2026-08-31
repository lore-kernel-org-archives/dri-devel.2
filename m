Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A0C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745EF10E240;
	Mon, 31 Aug 2026 12:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JJsBccD3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2232B10E2BF
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:31:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD6D243B87;
 Mon, 31 Aug 2026 12:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF71F00A3D;
 Mon, 31 Aug 2026 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788179463;
 bh=hwDK5Pmg+mRcTcHFYoeK5ij7OUg+pIqlkRaPLDCxMGI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JJsBccD3abuRxBpcQiufulXnAegtixGWDNsc1FHKT8f/Jj3wfKfCkXUu3HMJM1tkO
 OffubK79ZOVT2XhX7i1Dp29vx0zxJ+jMPpYxaCU+BXeG/5C0b/V2jC305jQkoX4gW2
 NhPrxx+c/t5FeIj55wGb06qDk+UmH9f9gci1gTZ/Y7BffovJ2yiOgcB2wsZDZJ2dgr
 QMqxY1t441HW5a8BLoJmV0UhtGI3BzsXnRi0hVvoxohy13cdlgg50SZj4mBdb42+8b
 4gGu1vNfgxWxtexwPpkB4ZcDT/4cF4BGmgNSeSV7X50UlkdN8DUECNTd1CKdK43fzn
 NmwLm18QAraQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
 <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 12:31:03 +0000
Message-Id: <20260831123103.70EF71F00A3D@smtp.kernel.org>
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
- [High] Missing `cancel_work_sync` for `reset_work` leads to a use-after-f=
ree on driver unbind.
--

commit 47920da4c643294656a651a954618ec33114a7d9
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

The commit reintroduces a non-zero return value from sn65dsi83_reset_pipe()
on error to prevent erroneous IRQ re-enabling during failures. It also
updates sn65dsi83_reset_work() to properly exit the DRM bridge critical
section by always calling drm_bridge_exit().

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..9f530cd05d2f3 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
[ ... ]
> @@ -419,11 +419,13 @@ static void sn65dsi83_reset_work(struct work_struct=
 *ws)
>  	ret =3D sn65dsi83_reset_pipe(ctx);
>  	if (ret) {
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> +		goto bridge_exit;
>  	}
> +
>  	if (ctx->irq)
>  		enable_irq(ctx->irq);
> =20
> +bridge_exit:
>  	drm_bridge_exit(idx);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free related to the reset_work structure that is being modified h=
ere.

During driver unbind (e.g., via sysfs), sn65dsi83_remove() unplugs the brid=
ge
but does not explicitly call cancel_work_sync(&ctx->reset_work). After
sn65dsi83_remove() returns, devres automatically frees the IRQ and the ctx
structure.

If an interrupt had previously scheduled the work, the work item might rema=
in
in the queue and eventually execute sn65dsi83_reset_work(), which will atte=
mpt
to access the freed ctx pointer (e.g., when calling
drm_bridge_enter(&ctx->bridge, &idx)).

Should sn65dsi83_remove() be updated to include a call to
cancel_work_sync(&ctx->reset_work) to ensure the work is fully cancelled
before devres tears down the allocated memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-ti-sn65dsi=
83-fixes-v5-0-e712765d6c4f@geanix.com?part=3D1
