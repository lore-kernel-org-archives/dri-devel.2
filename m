Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FECD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2B210F09B;
	Wed, 20 May 2026 14:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cGZdDXqT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0FC10F08A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzTvpH43hpdC78r5E1lFxVLsz0tO9A+WLlws2ErA588=;
 b=cGZdDXqTCBnAomE19Oja8/pYnHpS5FV22JHLlkAwgDVvtd0Nq7tKft8zaYmcH+mcEk0/3Y
 n6z/B9HIeaxJcX0bEcTijav3SHFCW5tZ7RiLw/tWbmctgpeYUJLS80GLBg6hVw413IdfC9
 j37RjA8Cjt8iYum5LKGM3Wok4FvY6Iw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-R4OfAQyvMuGU0yoOaPcJ_A-1; Wed, 20 May 2026 10:44:40 -0400
X-MC-Unique: R4OfAQyvMuGU0yoOaPcJ_A-1
X-Mimecast-MFC-AGG-ID: R4OfAQyvMuGU0yoOaPcJ_A_1779288279
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a589c7879so39085865e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288279; x=1779893079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DzTvpH43hpdC78r5E1lFxVLsz0tO9A+WLlws2ErA588=;
 b=L+PRuD1yH+d1sTeuCKkHGXNveuoiZ9nBgtZ9kfTsyu3EDSp6cBuLptIn9uW7Q3Uua3
 HkYHY2XlQ8kALqjWAFjIFmicyitPlDNp1+NkdhMlvxNaPo37Wbq2guwa1KmExnYWBNJR
 BKxWTW9I7vWf0JkCso09M0K7N3D421SUXev4DFHw7tbWcgV59sF8lNC05zsc2S5dnYT0
 mWySVrXpGfWsgGQKokd+Lh4IVhZy5XAxKjLLfZdRJNTg2z+6d5Z4MABqJ/IQR/ZxpkVS
 DcoWk3XVla1+Qzhx7amscQ8FFLs/hY2gWiH/joyrZKMc+r6DpEOdXTHqzq6AwPaICY8P
 U39Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Fwd71d/tS44+PcIxpNfXcpuqLKLy7V6lRkPU7Yip7RWJiv3YWqiaQ21dsVElEDV0GY5OeGoRxJbY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM52Mu6A1J0830FP1vXxrwm2CV5b3QSlFnyPP/PLU24SOx0wRj
 msg0sO3HCn845mdu18z1SBE4ko8PZkn5ZEgDFf1se1ZO5LWMMsDijQC9Z94fEeCPz3dYsUuX+kG
 CB6xeCeMAhsdhtTUusE/lnqByMLvCyDvHiVJZsJ20WU7/n22keaQznWT91mekfnqlsJYZeA==
X-Gm-Gg: Acq92OHvxtZlnMen61nj3BCee/5Hozkm+teZfO4d4Icwu1VL5Blo+NcRrHhDQCQZcXX
 QonCakQFDTeh0NcWu+ZJSNl3HA7BTX50v7gLZntUg5QOXs3x62hAvzVJ5+domyaggCV/Z1rId2V
 Ksz8Pc4y5fRICfnzN9kXZAJg/likwdMLSXny3W4Ky5Th+jeL6wH0EebcHjNFPqa5rVN7ZObUewL
 /g22XS9OFgk5ESNtxq5sxM1s4EUzIKpg7dR1cHGSyNrMDvGaSPEXhzyZHNivDrrflzji3+4vO2K
 MyYg1j+pdp/JOyAUdmBV1zzJjkfZYQnTl3Qa8QUbwhQDcT+PUvwTau2WyapclnF+5VcQmxyjIFl
 G0QxnaT/TB/1wc4kCUGwnH5i2XC0em67leXVNWcQ1JH9vz2k=
X-Received: by 2002:a05:600c:3222:b0:48a:5236:7f38 with SMTP id
 5b1f17b1804b1-48fd6367eb8mr270547715e9.14.1779288278842; 
 Wed, 20 May 2026 07:44:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3222:b0:48a:5236:7f38 with SMTP id
 5b1f17b1804b1-48fd6367eb8mr270547505e9.14.1779288278432; 
 Wed, 20 May 2026 07:44:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm55177883f8f.8.2026.05.20.07.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/8] drm/bridge: inno-hdmi: Use the common TMDS char rate
 constant
Date: Wed, 20 May 2026 16:43:40 +0200
Message-ID: <20260520144424.1633354-5-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2o9tdDNFmktSZ2LThI0-Cd8r6RuaMjjGL3BJnI5QjBE_1779288279
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace the driver local INNO_HDMI_MIN_TMDS_CLOCK define with the shared
constant defined in the <linux/hdmi.h> header.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

(no changes since v1)

 drivers/gpu/drm/bridge/inno-hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 1091af29ad8f..5fa533a4eb34 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -31,8 +31,6 @@
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
-#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
-
 #define DDC_SEGMENT_ADDR		0x30
 
 #define HDMI_SCL_RATE			(100 * 1000)
@@ -820,7 +818,7 @@ static enum drm_mode_status inno_hdmi_bridge_mode_valid(struct drm_bridge *bridg
 
 	mpixelclk = mode->clock * 1000;
 
-	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
+	if (mpixelclk < HDMI_TMDS_CHAR_RATE_MIN_HZ)
 		return MODE_CLOCK_LOW;
 
 	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
-- 
2.54.0

