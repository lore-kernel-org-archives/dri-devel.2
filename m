Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFDBC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E36810E7B1;
	Mon,  7 Sep 2026 11:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZOtZjP7P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF6910E7B1
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:38:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34938439BC;
 Mon,  7 Sep 2026 11:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF55F1F00A3E;
 Mon,  7 Sep 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788781139;
 bh=QmiW+eQvdz5TqNE+2Ipc4MGm/VbHaJMLZxnFoCl+qTE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZOtZjP7POJPnqQ4Z735CXzuYytLl8i9BzmsfDSmgPBOKuMWTIGweWYWtkWLEuEsVl
 CRGVnpWXGEKMbMw49k5pcFXhGRgwsLKS4LUdin4YOwvLcvxR9awy9JvAsN3eTxvmsx
 bZE4Khqxzc0FAAoX9YEHTAE1HT3LNR0S38I99OjX6+adrRzyDjhYXtkH8ntIqC5jIa
 Deo6tWK8LHRcX1nQmSSk9rgkh1rMw6SIC+GpVqSAvTPt6ehsxHmAxQ4sVDNPHfziVI
 r8faRJaiVqNWYA24O7h5/mMf1Z5zjeMxQHm4pu8A+2mrWUYVL1yG/K61NgCfD8pck5
 FTw+TUKtdqOJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] drm/bridge: tc358762: Move tc358762_init()
 into tc358762_enable()
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-tc358762-fixes-v4-10-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
 <20260907-tc358762-fixes-v4-10-e3fc3ab5cd83@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:38:58 +0000
Message-Id: <20260907113858.DF55F1F00A3E@smtp.kernel.org>
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
- [High] Sticky error state from post_disable infects subsequent enable seq=
uence.
--

commit f76c8643501a53ed324e8fe4854b3ed95f3e36b5
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: tc358762: Move tc358762_init() into tc358762_enable()

The only thing tc358762_enable() does is call tc358762_init(). Inline
the tc358762_init() into tc358762_enable(), for simplicity and to make
it easier to improve the tc358762_enable() in the following commits. No
functional change.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index 3a2e6a97feb87..ff79134417522 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -138,9 +138,56 @@ static inline struct tc358762 *bridge_to_tc358762(st=
ruct drm_bridge *bridge)
[ ... ]
> +static void tc358762_post_disable(struct drm_bridge *bridge,
> +				  struct drm_atomic_commit *state)
> +{
[ ... ]
> +	ctx->pre_enabled =3D false;
> +
> +	/* Turn off the DPI output */
> +	tc358762_write(ctx, LCDCTRL, 0);

[Severity: High]
This isn't a bug introduced by this patch, but if this write fails, it sets
ctx->error which does not appear to be cleared at the end of
tc358762_post_disable(). Could this leak the error state?

> +
> +	if (ctx->reset_gpio)
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
[ ... ]
> +static void tc358762_enable(struct drm_bridge *bridge,
> +			    struct drm_atomic_commit *state)
> +{
> +	struct tc358762 *ctx =3D bridge_to_tc358762(bridge);
>  	u32 lcdctrl;
> +	int ret;
> =20
>  	/*
>  	 * DPIENABLE has reset default of 1. Make sure we don't output on

[Severity: High]
This is a pre-existing issue, but does a leftover ctx->error from a prior
tc358762_post_disable() cause all subsequent initialization writes in
tc358762_enable() to be silently skipped?

If so, would this cause the display to permanently fail on subsequent enabl=
es,
such as after suspend and resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-tc358762-f=
ixes-v4-0-e3fc3ab5cd83@ideasonboard.com?part=3D10
