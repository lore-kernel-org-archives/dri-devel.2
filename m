Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EBCC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9617B10E322;
	Tue, 15 Sep 2026 13:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1xhRbVli";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2366610E2A5
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 13:01:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7EC4E1A0827;
 Tue, 15 Sep 2026 13:01:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4ECB860498;
 Tue, 15 Sep 2026 13:01:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B79B311C7AFE9; 
 Tue, 15 Sep 2026 15:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789477291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Gm/3e9UjKl5QyiWjyjBfCYBN5w2b9wu+1Jhq9Oqdu/E=;
 b=1xhRbVli6u57wYGElEqFmqQA0BT75q9nwKXJCrIHMRefXtLuM9lOUVccY188+rjNpRfhHd
 Vc9tGeaAi8/hKFaOi7OCdVSpD9rTEEYTd1LFtv7BoRUEt+910XZrWB3WJa0+Xnv4YP4k0N
 HujSkX7BU2dckCG0utovqqYwKxIyFEyvJt1z8mwUhJA5C6DFY57dBdf4MFhEsXn0sBWB1U
 2bXaL0ilZSKUiAvJXs3BEXGGZ2nmSXntB9I6QmjghE9hoNVzDdLzpoMueAw7EJlNO3xo5J
 +ojV/u26omB1EEjBFYroMJxpxRiYaWDahR+gaPyFxTc2T5YMHk4TKU6eqUhZvQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 15:01:14 +0200
Message-Id: <DLFWR377PSNH.3253TRHVTTGMQ@bootlin.com>
Subject: Re: [PATCH v15 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
To: <mohit.dsor@oss.qualcomm.com>, "Sunyun Yang" <syyang@lontium.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
 <20260915-lt9611c-v7-v15-2-88f9e9387eab@oss.qualcomm.com>
In-Reply-To: <20260915-lt9611c-v7-v15-2-88f9e9387eab@oss.qualcomm.com>
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

Hello Mohit,

On Tue Sep 15, 2026 at 2:33 PM CEST, mohit.dsor wrote:
> From: Sunyun Yang <syyang@lontium.com>
>
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

You are carrying this Reviewed-by Dmitry since v11, but the patch has
changed a lot since then. You should drop that R-by line, unless you got an
explicit consent to keeping it for specific agreed changes.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
