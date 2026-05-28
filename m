Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AFCCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBEC10E5D4;
	Thu, 28 May 2026 20:08:25 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54310F54D
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 18:41:58 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-914a8522bc6so839287685a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779993717; x=1780598517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvVca0XD9acOcTvdc3tCZ7i39eBcRq3fOov78xnCMd8=;
 b=bCtFbd0Vgq4haOg39KlH/Wkch4sPS0D5BDvXFLEyww7gpK+I2L081E4+YG5ixRPmIq
 2y5NggNVpsjHBaLpbxIju017XrJKFmUafHF3WCcrfPxx4zwDB4uKypvHengKCw3dFidU
 KSikoYa0Su+1d28watLyZQYBuMcXROU5JZ46h/y1fGVkHF+VSsLQZURVtgY9s6lPfb++
 zEr0S744zY6AT9l2jXOQIX5SqvjbXLMIuqR584X8VdcFJ9MOeUQqMiyAdrH/BQgPxBJy
 RtNXWIAv+tO3bg5Dk7SUJaURt1kTiLsCw20sZb9TO0os5Ok7PAbFquL26yvJqbtsFJh7
 nT6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KLU6ON1rz7b7VpQWpi9cfYPe+JtaUB2AMC3sDjH0CHEBGc5LzEFjF/qinkEfAWugpk1JDiajdwU4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLIEN7Dirq94VOX3smv3KV5iMnsexh27h63S0xOlOdHsRDutjp
 k5C81XId1Lf1MffFebEkeXvu6Ql+yv6xfN71HrhLOTK+XcNmETAnASYI
X-Gm-Gg: Acq92OGwcedwR/2dJ+Iz/8aJ+ukMoJYgBX1hCIB5htFoBNUuCqArYj5ZZDF6GVNfRPB
 ABDWq2Ma7y1e3hkE/U+cjRR7neZFK4S4wDHK8Uizy9/RMVbtNkLMZOYvaeqgBPt2iWUxlX83qlV
 jRCD4KlWHn2/IL1YqcTMy6iOQuPwJL2huS/EU4iT8/xJfPT9FzjwdirBOg8Wyf528dPuxYch/QC
 4Zy+zHA7mFq5+SuvW0zzqQxyliuu9cDOjmJHfcrTzOKMnLdj7tw4rlU6Yuoqzln6FJkzEfb8udf
 gp+DsaJLt7iUHnxde+xGKm2uRXDrRYfAsH8d+xxVbFlW15aAl5hBnKrchMyzSOJJZ6a1oIJRsKT
 zOPUTVUlBFNscpdrKDhgJyE1yy82rDr55s+B5cZwRwhvJSVP3RaQtaAD42SCzm5M1zB7H9QXZd+
 AtAC+5DaacWz6ZrmsEAHpQHev31/GBmLgGVEcglgbISuh4YZj5wMbicCN6b3AOVYC39fQKhh9N7
 qD272i4ISCB7pluJw==
X-Received: by 2002:a05:620a:f15:b0:910:b13f:ac81 with SMTP id
 af79cd13be357-9152cf2147bmr32429885a.52.1779993717517; 
 Thu, 28 May 2026 11:41:57 -0700 (PDT)
Received: from 96364762d92a.hsd1.ct.comcast.net ([73.219.118.68])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87d1a27sm904579085a.28.2026.05.28.11.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:41:57 -0700 (PDT)
From: Dominique Belhachemi <domibel@debian.org>
To: Andy Yan <andy.yan@rock-chips.com>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/bridge: inno-hdmi: reset DDC segment pointer per I2C
 transfer
Date: Thu, 28 May 2026 18:41:45 +0000
Message-ID: <20260528184145.384114-1-domibel@debian.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 20:08:24 +0000
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

The segment_addr and ddc_addr fields need to be reset per I2C transfer
to avoid stale values. The reset wasn't required on simple displays with
only one segment, but modern displays with two or more segments end up
with corrupt EDIDs.

This was found on a StarFive VisionFive 2 SBC.

Signed-off-by: Dominique Belhachemi <domibel@debian.org>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 5fa533a4eb342..297be02bbd58d 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -989,6 +989,10 @@ static int inno_hdmi_i2c_xfer(struct i2c_adapter *adap,
 
 	mutex_lock(&i2c->lock);
 
+	/* Reset segment_addr and ddc_addr at the start of every I2C transfer */
+	i2c->ddc_addr = 0;
+	i2c->segment_addr = 0;
+
 	/* Clear the EDID interrupt flag and unmute the interrupt */
 	hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, m_INT_EDID_READY);
 	hdmi_writeb(hdmi, HDMI_INTERRUPT_STATUS1, m_INT_EDID_READY);
-- 
2.53.0

