Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F73CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DAD10E40B;
	Tue,  5 May 2026 14:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iZUdRDG0";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7561010EB09
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:57:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DF114C5D73D;
 Tue,  5 May 2026 14:57:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E34336053C;
 Tue,  5 May 2026 14:57:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 172B511AD0286; 
 Tue,  5 May 2026 16:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777993026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3ykqrj8TMl/CACkCKsorqSvBm2kVfs95MQdBQxVzySg=;
 b=iZUdRDG0VkCisPZi3M/wzFLahpfFDlDBIQR6KmTPBz8U9mYcpOpfp7k1EFVh4nA4ICl3Uv
 UXZeoU7CNw+ZPbDQ3Q8KP16FGpSsW/cUy2KshCbJGQD3wBxTFJE3dMBdQI+WmawhIIyuWU
 jN/Gl4gTDT1uXsf7j+7CyWDNmIPLN0RM6rDkkMYGO2aA+kEEM2MDZblCQvDcUcP2Gm9qiH
 5NR2bMB1H7/uQHQjBIqDW+YMHfBvGdo9UyzRFWzrPw+gsAjvdGxxXVZBqPodp/PSVbd2Af
 0t00igisIjIb/II2YaC7NaM/xKpCr2Jc8XgnnGBXv3G8jHNR3w12Y1M4FmxJGg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Subject: Re: (subset) [PATCH v3 1/3] drm/sti: remove bridge when sti_hda
 component_add fails
Message-Id: <177799302281.1269303.8720982379934816219.b4-ty@b4>
Date: Tue, 05 May 2026 16:57:02 +0200
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


On Thu, 23 Apr 2026 22:06:19 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().

Applied, thanks!

[2/3] drm/exynos: remove bridge when component_add fails
      commit: 26f6654a9a60eb4d241f42a0ec85412e8821480b

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

