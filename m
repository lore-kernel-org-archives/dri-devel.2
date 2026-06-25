Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E255DCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48910E034;
	Thu, 25 Jun 2026 08:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mJLYZoiP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E8910E1D8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0874D444FC;
 Thu, 25 Jun 2026 08:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B861A1F000E9;
 Thu, 25 Jun 2026 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782376796;
 bh=82fk+/jQSvU5slAMo+rTXSiluV32IYwPoP3FqbDRX6M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mJLYZoiPyn9KnwpnjkiXSfXcUY10D3P3F8OULju1hWOOPhdBO1/ISNGlkHSn0rcEZ
 Lb2GirzBk+MZNnZ57PJqu0kZNTE/yRaxnZsxj/ZlpHqPbPLA05M5xfUibfjGHx0lsv
 ai3ZefheodKmsPwpG1XGlJ7lHW8b2/PyF9EPFdnCVhfwPztobZ2iyLd3s009nyNwc7
 hnur2tcgCEeuNlnkIQ5a7ZtMu6lb9epd6GRseLJDsj1lZgnn5IGX/KFzBZ/lASIkaq
 8FizlBhg5cngim64uqI/JBMDUKheKaA3T1XlIuu0phK7ANiqVokZdwyM35G6rnnPms
 c2lgwPub0BRmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] gpu/drm: bridge: tc358768: Add delay after PLL
 setup
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625082507.57703-2-clamor95@gmail.com>
References: <20260625082507.57703-1-clamor95@gmail.com>
 <20260625082507.57703-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:39:56 +0000
Message-Id: <20260625083956.B861A1F000E9@smtp.kernel.org>
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
- [High] Preexisting calls to sleeping functions in atomic context callback=
 paths.
--

commit e9444612d599575c476a8af0ea940cddf9416e28
Author: Svyatoslav Ryhel <clamor95@gmail.com>

gpu/drm: bridge: tc358768: Add delay after PLL setup

This commit adds a 20ms delay after tc358768_setup_pll() in
tc358768_bridge_atomic_pre_enable() to allow the PLL to settle, fixing an
issue where the bridge claims PLL lock but produces no DSI video output.

> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 0f2820b373029..ea358c8da0e99 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -824,6 +824,9 @@ static void tc358768_bridge_atomic_pre_enable(struct =
drm_bridge *bridge,
>  		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does calling
tc358768_setup_pll() and tc358768_hw_enable() from the atomic pre_enable
callback risk sleeping in atomic context?

Looking at tc358768_setup_pll() in drivers/gpu/drm/bridge/tc358768.c, it
calls usleep_range():

tc358768_setup_pll()
    /* wait for lock */
    usleep_range(1000, 2000);

Additionally, earlier in tc358768_bridge_atomic_pre_enable(), there is a
call to tc358768_hw_enable() which also contains sleeping functions:

tc358768_hw_enable()
    gpiod_set_value_cansleep(priv->reset_gpio, 0);

    /* wait for encoder clocks to stabilize */
    usleep_range(1000, 2000);

A similar issue exists in tc358768_bridge_atomic_disable(), which directly
calls msleep(50):

tc358768_bridge_atomic_disable()
    /* wait at least for one frame */
    msleep(50);

Since the drm bridge atomic pre_enable and disable callbacks run in atomic
context during non-blocking commits, can these sleeping calls cause kernel
warnings or deadlocks?

> =20
> +	/* Allow the PLL to settle */
> +	mdelay(20);
> +
>  	drm_display_mode_to_videomode(mode, &vm);
> =20
>  	dsiclk =3D priv->dsiclk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082507.5770=
3-2-clamor95@gmail.com?part=3D1
