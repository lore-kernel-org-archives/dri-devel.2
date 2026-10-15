Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38138CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF5010FFED;
	Thu, 15 Oct 2026 13:54:56 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6563110EC06
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:54:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 395031A1245;
 Thu, 15 Oct 2026 13:54:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0C23160360;
 Thu, 15 Oct 2026 13:54:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E3C1F10328B9A; 
 Thu, 15 Oct 2026 15:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792072479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PNJz8ouroGE3ea20TFTt2wyGuS5FQqDGBVRKx+Y5FJs=;
 b=s2TDUo6WeQN2uneIDXfzvvO2BfIo+tqTpF9uf1g4ngUhG3xbLqdO5xexnZlB8XfBZG683F
 /3Qv6j/We/t06U4y5PLFV8eX428ui9wvnEGtHrkCayREpX2/d4pK1JHJifXPgjMOvL6ZE4
 I8fNh6t8NO0NvL0w0Jf1BNZ70iImeWk+QHsn1+Cx+cXfy/h1YOG3tbJaMMrcgfizlmTNiF
 lh7IB5FkwENp4pAO0RYMqiHvNzpyBaqAVMwtYsR0vQB8LFGMc61oc0sVCGshOE/iTHk2Fe
 NzRHw1sGOJjWoOYPbq4ImYmzR4muk1myaaRsINXgJ/TcCegYMzKIzvCiJykZbQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND v4 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI
 horizontal sync timing
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, Frank.Li@oss.nxp.com
In-Reply-To: <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
Date: Thu, 15 Oct 2026 15:54:18 +0200
Message-Id: <179207245898.1117464.4430806907649454372.b4-review@b4>
X-Mailer: b4 0.16.0
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

Hello Robert, Oliver, Frank, all,

> The NWL MIPI Host controller registers specifies the horizontal front
> porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
> not in pixel clocks).
>
> The calculation for this is (mostly) described in section 13.6.3.5.1.2 of
> the i.MX 8M Dual/8M QuadLite/8M Quad Applications Processors Reference
> Manual (rev. 3.1). The formula shown there does not take packet header size
> into account though.
>
> The formula implemented here converts the hfp, hsa, and hbp to DSI packet
> bytes and then subtracts the number of packet header bytes.
>
> It is worth noting that these values only needs to match approximately,
> according to the reference manual.
>
> Based on commit in NXP vendor tree
> commit f2a61699749d ("LF-7981-4: drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing")
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>

It would be great to have this reviewed by someone at NXP.

@Frank, do you think you can help with this?

On my side I don't know the hardware and didn't check the maths
implemented. Still LGTM:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

