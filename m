Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA72DC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5AE10E337;
	Tue, 21 Jul 2026 12:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="j1Gsjxor";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC3810E332
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:52:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A6D3D4E40EA1;
 Tue, 21 Jul 2026 12:52:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7C50B60368;
 Tue, 21 Jul 2026 12:52:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D75211BD21D1; 
 Tue, 21 Jul 2026 14:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784638361; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=70EOmKR/DfuK46SMVknKIG7a4COz4wFvYJ2h5KS4mt0=;
 b=j1GsjxorgK1SrL3Ntr49PnfZ+LsjsHq8BUAqb9bPj1HmvpSfwnhdJTv9PrppZSjWDsQw5E
 KesfaJZ3GZghbKt8BfRfuzslAR8GGE15VvUOBkIaV48MiV6V+r+OonQwgQFWI1LEB0qo1a
 KExRPCPiZFMQorhzfn7FmGitVGDymKx7ywDkvK06GKMXHX/wW7ehFc4YtKwqgehfzHDAJq
 AcaHUBZsex0mu0qKyAhu135f712dY+YYSdmPKNKe9rGT8RxFu0BNYSu3Ycbmmrxp3bv+UN
 EjSFPiD+3l+R97MEtTfVaxJ51hSmfPG/GINFeRrc4pOAAAM7ihEnzg1y5J1QrA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 14:52:30 +0200
Message-Id: <DK49HW1DYV6O.1BIH133U1PAUF@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/2] drm/bridge: tc358764: use devm for bridge
 registration and DSI attach
X-Mailer: aerc 0.21.0
References: <20260521215228.188615-1-osama.abdelkader@gmail.com>
 <20260521215228.188615-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260521215228.188615-2-osama.abdelkader@gmail.com>
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

On Thu May 21, 2026 at 11:52 PM CEST, Osama Abdelkader wrote:
> Replace manual drm_bridge_remove()/mipi_dsi_detach() in remove with
> devm_drm_bridge_add() and devm_mipi_dsi_attach() in probe. Also check
> the return value from bridge registration.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
