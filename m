Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A883FED3F7
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6448A10F67C;
	Fri, 24 Apr 2026 17:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="tzA9EOQn";
	dkim-atps=neutral
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com
 [115.124.28.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB5C10F434
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1777020611; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ecfHlwbhziqCnj0RyxvgFELOclmn9GpLOgHDwwYNFXo=;
 b=tzA9EOQn+ko42OyB6eqMUJDEQJkIYVnPB+kY2WtsPZ9YVtRSs0nfIE2u24eSBSHdb9k5LjFU7kMq9XsJtmYWdnVEwKId3rS+EEylGeINdgpaSfC/IxnNbJUpBD2Bma8efpdwjAkI0k6/cIg3oUf7PObN0vz3l0fmouQrfCb9ITr/BS1B8ll7ijcEo1RlLAZVTzjLUTTARPlSfrMQOR/HEOtEaZm0gM0S0UjgYyBYzkfWW9q5L4Hc6UA4sRv7r1vcEkPR7BWfOD+Og4Tg64Sp4EGt4237BB/y2IzUzLDWN9mxrQlgfnB13q+KSr1t0B0gV7tE5bxlEu7P02pdIkbhXw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1011229|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0257291-0.00697652-0.967294;
 FP=310979370624404713|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037071049;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=20; RT=20; SR=0;
 TI=SMTPD_---.hJOs6zM_1777020609; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hJOs6zM_1777020609 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 24 Apr 2026 16:50:10 +0800
From: Sunyun Yang <syyang@lontium.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, Sunyun Yang <syyang@lontium.com>
Subject: [PATCH] drm/bridge: Fix the interrupt clearing error in LT9611
Date: Fri, 24 Apr 2026 16:50:07 +0800
Message-Id: <20260424085007.3239969-1-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:30:16 +0000
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

Incorrect clearing of the LT9611 interrupt register causes subsequent
interrupts to not be recognized.

Signed-off-by: Sunyun Yang <syyang@lontium.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 4517aee83332..f30a2875000f 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -398,6 +398,7 @@ static irqreturn_t lt9611_irq_thread_handler(int irq, void *dev_id)
 		dev_info(lt9611->dev, "hdmi cable disconnected\n");
 
 		regmap_write(lt9611->regmap, 0x8207, 0xbf);
+		regmap_write(lt9611->regmap, 0x8207, 0xff);
 		regmap_write(lt9611->regmap, 0x8207, 0x3f);
 	}
 
@@ -406,6 +407,7 @@ static irqreturn_t lt9611_irq_thread_handler(int irq, void *dev_id)
 		dev_info(lt9611->dev, "hdmi cable connected\n");
 
 		regmap_write(lt9611->regmap, 0x8207, 0x7f);
+		regmap_write(lt9611->regmap, 0x8207, 0xff);
 		regmap_write(lt9611->regmap, 0x8207, 0x3f);
 	}
 
-- 
2.34.1

