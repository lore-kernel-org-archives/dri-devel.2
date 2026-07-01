Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0214FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9B110EEC6;
	Wed,  1 Jul 2026 16:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aRoOH5ea";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C44610EEC6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:16:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8C2B21A0D48;
 Wed,  1 Jul 2026 16:16:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5E2B85FD9D;
 Wed,  1 Jul 2026 16:16:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9022C104C967E; 
 Wed,  1 Jul 2026 18:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782922608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5xUzCUMwudjcrjeuf4Ro11z6f8Fck9gPbmbBrXhR1wA=;
 b=aRoOH5eadpS+BCrG7A8ye9YbrBoID1TN75pWnAM16WkIiXHVspl92Oa0waIVUXIx/U45A7
 5EltMrnorTYoSGX2Jtu8nGGs0Kd+Yr1rWmMREsx5rqitmbbIcNav5tPDcPbeed0XWZYwFY
 Q10yaROBQdcqdgLF/l4V0SoKlMq/fgBT1N4P+K4tkiWanIaSUOT8DNcNGqkcV3N34BBZ0H
 CDX2u1gz0aF9rDtlLHklW65qdpAv1GSlJOWulYNu5ynqLTXQGTMTMP38r5m+wJlHf+dzLr
 lEGzXJGuCd5V5SMcWfiyzNhTLCrIA6AstEAR03CWVm25ngQYRoe7VK42Q8NxJw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drm/bridge: sii902x: validate I2S data lane values
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <2026063007056160.5-ccfa108-0046-drm-bridge-sii902x-validate-pengpeng@iscas.ac.cn>
References: <2026063007056160.5-ccfa108-0046-drm-bridge-sii902x-validate-pengpeng@iscas.ac.cn>
Date: Wed, 01 Jul 2026 18:16:38 +0200
Message-Id: <178292259841.3242678.14628738606093717332.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Tue, 30 Jun 2026 14:58:34 +0800, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

Hello Pengpeng,

>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index f575b2dbe32b..1d0649611f53 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -890,9 +890,16 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  	}
>  	codec_data.max_i2s_channels = 2 * num_lanes;
>  
> -	for (i = 0; i < num_lanes; i++)
> +	for (i = 0; i < num_lanes; i++) {
> +		if (lanes[i] >= ARRAY_SIZE(i2s_lane_id)) {
> +			dev_err(dev, "%s: invalid i2s data lane %u\n",
> +				__func__, lanes[i]);
> +			return -EINVAL;
> +		}

Looks generally good, but please use dev_err_probe().

Also, even though it's done elsewhere in this file, I don't think printing
the function name would be very useful. Instead the incorrect property name
would be very useful, pointing to where the issue is, so I'd rather
suggest:

      if (...)
      	 return dev_err_probe(dev, -EINVAL, "invalid sil,i2s-data-lanes value %u\n", lanes[i]);

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

