Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C04C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627C910E66F;
	Wed,  8 Jul 2026 20:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6sRGFjP";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38B710E66F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:23:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so1707025e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783542193; x=1784146993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGPWKT+T/Sc4FxhkqkRyahjTyPdMRSTRlzX+JKb5mbQ=;
 b=j6sRGFjPIkOOdKrk9cF/rYTfpe7vxnEnUcdMjHUXMhGcoatSzZ47kiUQqxXTQTo/kK
 tFBgCM6ot8H+vWnh4xnxVs/BPZGptoRr2g3rj3OAisjUs6PKWFBxWI7B9FD98pLjdMBt
 +clDA9uGyXDverdrz/dhRIAggrCMFdZpJQbkecxVl4etJMJZSSJr12N2F4SUuBQ1DeI9
 l8YK/FTjAHC2u4u3smREysB3bohNV23Slqs8yhIJxTZJigltmIEsoRU48dtv0hzqyUKR
 IbGzg9wzRG4Hc8ouDuPFp1RfWAfl2uDRU0N7Semp7L0ACTkikOM5e5hCLwbixS4bS7oJ
 JYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783542193; x=1784146993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGPWKT+T/Sc4FxhkqkRyahjTyPdMRSTRlzX+JKb5mbQ=;
 b=HfpdiH71u3A9CdLZM1/GBpywrKA+a3kWcQ3GBA/p5QBVk0uVOdnKrqJMBkwLRg0l4Y
 KMthcmGdRNEl+8niT+eoxhhBg7oZwrkqcpT8BIyMACGyA4Vjf0Woh563jMMS4Bhv869Z
 AY5dEkT73OFusbI8yItNUSmw7x7ck2Q7oCyhrRGPYTPgPDaeaKGejlpuCn2k771OFlJ2
 6gcAayadYzF0s+g4qLm4oXancEMuhBVBWRDFh8g4RGtXwihztct3ZBu2ZQ27E2UN1agK
 bOwZGUdsfwrXk4Z2yR8oAp/Y+Pv8hjUeCkFaHdAWQiOqk59tLXGmZxGMzqfqZTa3YbLY
 RbRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCvmeCaRIG0uCke2IrDEVsuzn5acpbfvZXDSN6xedU7cEGnV21a2kkxuGNseDni9BSBK+caXROQto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIT3l0im8taJPTFLcIjbLFThagsdAqJnAM5IFFuqUWNLphArYz
 uKwJaKOBYU9Q65ekqoTsvKqmQXgzP/+XfUNTMvp3hS/w7Tu0fIHktYEtpQKKsF/EKps=
X-Gm-Gg: AfdE7clkzesMCFkNpuPhzcyzOAe3PSB6//gqiVE+3FZd/YhbCFUrrYjvn2xtZJOYZta
 OfjZRRVdkg/1sGRQRlYTIVC57wILScUSj/m9CFgbP1XmqbTlxe3Kpkz5HA+lXGIXXY7kv4gg4+w
 ObYYz96oY6kBFRDpbH9tgtM86GnzkodHmOgpLYfNPEuy/Pm6kJ0AVVA8BYiegppwbeJkTyGp/jG
 eMjTsBNDyA4h2s+0XifsxRlmvHm9fkVqHDfKpORMuIgCnDTWpM/3JYsUQdJkreY/iMCicvtI74O
 rjuahyr7T5QczVda1Ao1XtECzVbU0WIM/crfVSP6J70hZ6L+EpaoKf7hQMwk6GKOGWSTn8dzgJF
 3eQsA+5O35mVl7WicrEjpF35CUl9Huovj3JDrc9m/IN7F7pgVIQFUXqcLmVQYdGpjZDGZlEYzK0
 upmgnXG9+XPhew8mhFQx9Ywqfqk62Ul3INmosLkIVsVkd01ZlTFg==
X-Received: by 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id
 5b1f17b1804b1-493e68f03damr41743525e9.32.1783542193163; 
 Wed, 08 Jul 2026 13:23:13 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:2b86:7192:b44e:9f03])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a5d174sm101663785e9.2.2026.07.08.13.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 13:23:12 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/imx: check parallel-display drm_bridge_attach
Date: Wed,  8 Jul 2026 22:23:09 +0200
Message-ID: <20260708202310.12971-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706142732.49397-1-osama.abdelkader@gmail.com>
References: <20260706142732.49397-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

imx_pd_bind() ignored the return value of drm_bridge_attach(), so a
failed attach could still proceed to drm_bridge_connector_init().

Check the return value, as imx-ldb and dw_hdmi-imx already do.

Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- add Fixes and Cc tags
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index eb75827394f8..fd48845877cc 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -210,7 +210,9 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret)
+		return ret;
 
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector))
-- 
2.43.0

