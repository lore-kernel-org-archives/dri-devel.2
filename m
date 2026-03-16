Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93D3F46452
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDCC10E3B9;
	Mon, 16 Mar 2026 11:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yQc/dk0+";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84DE10E3B9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:22:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7413D1A2DFB;
 Mon, 16 Mar 2026 11:22:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3C30A5FC4A;
 Mon, 16 Mar 2026 11:22:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4286D10368682; Mon, 16 Mar 2026 12:22:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773660151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Vq342JcV2FeiEZGDKh1ajgkGt8udEwhu3JEGM5ZjURY=;
 b=yQc/dk0+Fu7bj8MfrlBwp/h6g+7/hV5V3WXjYAWG03UjSveuXfsS8tABdGLhOQPc8ZX6Go
 vlty2OFtxCGIX12PpXxv5eZrDFKMJ7ImgfILM7HHfeXZxFPtzSuXE3CK3CzesgaHGS67PR
 aH71cQ/JHIK4N+6TzQRkoIBwpViQ9o8vxy+wKG8i1Mx0K5TJTH5AqF8JEX62bDl3u49JBO
 dne0FH1JNaCJ8mg8kmCQP4IWckTuf20v9ZhCoU2pMDp+xy9+GtVkypkdxbpgJ8sMpOzfGj
 H32RLx2aeURiL73s1r5auIw8l1pprDegurU3ynzLKHCFyebXKShKzUMLT3cKLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 12:22:23 +0100
Message-Id: <DH461P9VAQXP.19TV6E01YQMS9@bootlin.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Clear HPD IRQ before powering on
 device during resume()
Cc: "Biju Das" <biju.das.jz@bp.renesas.com>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Tommaso Merciai"
 <tommaso.merciai.xr@bp.renesas.com>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Douglas Anderson" <dianders@chromium.org>, "Jesse Van Gavere"
 <jesseevg@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Prabhakar Mahadev Lad"
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <linux-renesas-soc@vger.kernel.org>
To: "Biju" <biju.das.au@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20251219104659.114032-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251219104659.114032-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri Dec 19, 2025 at 11:46 AM CET, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On RZ/G3E SMARC EVK using PSCI, s2ram powers down the SoC. Testing ADV753=
5
> IRQ configured as edge-triggered interrupt on RZ/G3E SMARC EVK shows that
> it is missing HPD IRQ during system resume, as the status change occurs
> before the IRQ/pincontrol resume. Once the status bit is set, there won't
> be any further IRQ unless the status bit is cleared.
>
> Clear any pending HPD IRQs before powering on the ADV7535 device to
> deliver HPD interrupts after resume().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
