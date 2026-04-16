Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56385F43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66B110E832;
	Thu, 16 Apr 2026 07:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mZTjDO5j";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C5B10E832
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:42:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DDA6AC5C3C4;
 Thu, 16 Apr 2026 07:43:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F3AD95FDEB;
 Thu, 16 Apr 2026 07:42:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0693B1045A122; 
 Thu, 16 Apr 2026 09:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776325367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=j8Wp/jqyh5j465Gz+UXRQepTgQA8Js6dDXYwA99h2OA=;
 b=mZTjDO5jaVAHtGOjrOauwDY7nkFF4RBqHKvj8/UWdsXgWkJFUj5c082sjiXYLMpQiNG/2X
 wzAsqw0c3qzI4ugGgbGGO2BjVdJl8q4JbHLo/lpK6y/JhAmq6yhjqWv8ZYlxJ930IEwr4F
 yMI8gASd81ijJADfg12IELWenNRIbsoNdfGz/GFOXU0DJswudB/ulKgfK5k+oUgiOZQwxB
 pkNzbaj0J+M3+msPKm3M2VC/kNJvBqQkLV8lKGEKTPmjWtgRH++BwOSQLP+ffOY0j5NY2g
 JT+CouXiUPLhIh3ZEHNjqzH619VMPxiyzyTTzhkVM11eEUZk0w/+urTwfPvwmQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
References: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
Subject: Re: [PATCH v5 0/7] drm/bridge: protect encoder bridge chain with a
 mutex
Message-Id: <177632536210.4038639.13267610689254857496.b4-ty@b4>
Date: Thu, 16 Apr 2026 09:42:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Tue, 24 Mar 2026 09:58:07 +0100, Luca Ceresoli wrote:
> This series ensures that the bridge chain of the encoder will not be
> modified while some other concurrent code flows are iterating over it.
> 
> Some patches are already Reviewed-by: Maxime Ripard, some are unreviewed.
> 
> == Series description
> 
> [...]

Applied, thanks!

[1/7] drm/encoder: add mutex to protect the bridge chain
      commit: 01b92f0d18214660d9978f0c4dd9507ee8d27d06
[2/7] drm/encoder: drm_encoder_cleanup: lock the encoder chain mutex during removal
      commit: f6d20e06f42ad42e926f94661aebcde78f67ba4d
[3/7] drm/bridge: drm_bridge_attach: lock the encoder chain mutex during insertion
      commit: 6dc294c4d3666525ee80dc6a4c9e123c36ca773c
[4/7] drm/bridge: lock the encoder chain in scoped for_each loops
      commit: 46c1213a1b854eb4465c90a2da001310b72cc389
[5/7] drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      commit: f776e9b8c290bab534b2699e6397456147c5a5a4
[6/7] drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      commit: 82ce979b9be52fdc533c9e9aed965216e088200a
[7/7] drm/bridge: prevent encoder chain changes in pre_enable/post_disable
      commit: 901ed976068fb34d605cbdec41f58cecba4d520a

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

