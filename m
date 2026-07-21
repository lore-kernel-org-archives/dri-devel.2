Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C72C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EFD10E277;
	Tue, 21 Jul 2026 15:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/rsg45j";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9124810E277
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:22:52 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38e347638adso6575038a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784647372; x=1785252172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9eXHmL2FrSSPACEJW/ZdN2+RZSdHtJBbjO91JeCFP0A=;
 b=T/rsg45jBr9a96KcszzuSou+H8pp+XhS+9BfkJmJ7AxDzG+ebXvjycQGbpmOtKaKdK
 xoFU2vFiV6KHMPLzowoKfh1MO9dCJgndk6zJDj/bc5F6ES/q8x9c0EXvjfA1z5Wg6Jo+
 LXuywKQR8JIqVckAu9jm9YJDbdw+DJduW9J/sW15CNN0pLN36nzogSAB6A1URAjhxIlG
 /E9CLESuwqc0weIJbBqncTdmSFJAWwlGiizvDHxGB3LkOmvSNUn+TNHSgSaL4/PrpfzK
 RS4HV58LlRs6YJbftCnU6H0z5eCJAhBV2L/7pODIyTtw7BXTkGdf4He/f69eo5bYv1r6
 g3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647372; x=1785252172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9eXHmL2FrSSPACEJW/ZdN2+RZSdHtJBbjO91JeCFP0A=;
 b=p1T87EP3zALJNclNkvZ5SH8SIcouHQA4wJG953toOHd55Bv5zeQHRRIfwPV234IWGX
 IFt06/HAXUGqY6Z54ZL/lOc4q3its7kycLXZwG3fqIY9SyEy/KrSLAtGtWOPOBnfuzTf
 RNCZ7hYpa9unO4iPlueawEyAbrlvy9qatsyxzmgeFB7WcchOmsHDI7Mzeepc2E9bpstl
 eYThJPWxzxbdfOkClz0J75TrzyGH/5Lf5kw3u5A+JZ4ZwEVGkYA3VlXnkikV7ZVHSQMb
 kGiYA8lP+f/pLWwS9xrE6OzHzI4Y75BO+QPnq44qpoEU8hcaCVSjjYeZaU+zlhFs53PO
 XSow==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKHgJHHjW744lWVSFAcPCYPbV6l2n7+dWx/kKMDxXIW8UQAG+X0QnZpSOF5WGhvl/Eao4Sgo5S93U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2LTpsZNfqaPSIH18LPU45xdji02M6bwL0jUYxRc1AB3Ze3KDP
 Thf4eupnpzQu8Im/uzDF1dSNcqkgEyPgVyIgNbdlL7AlPiS449xBs8M=
X-Gm-Gg: AR+sD11jfFpGW46gPgFHgvU3lOlZZ4BYZJuQ+3G8CRdaDJJDHMjSAhkuIahHP5Y36pj
 b/5kTHxZFKR2o2ZAc4FFgo9HBvoOdZlU/XGZT1CMj6ePmLaOEj/mpjzq8Q/zP3gzvDGmNsj8Siv
 fDyl3lXDnGG5K1UPREjvTj9KAZYbMtgv45VLayg2YefSBqkzIxdyXtcOC04/A0ePQwZB3cg76Yx
 mC8Ax5xvqE7m4qd6RXtgAjxqJP+uMj3LLgc05x15xUef3mpgjlPHwAvVJ9CX0DaXVUYVB+zk7Uj
 PBIu4Ds+yjbEE5MQMAw7a+CPwRjMNDPn6jV6si+WLONQsNWOuY4qjYAi4nDG06R6Zkwe4Mueki/
 cE75YHZ/netAiHj0f1yK77FuwFB9UE9VWk9nMuZICyTTuqej3mrb/PjBPNbQ/aGKFLLfObEheC0
 eMzDtfO7ELDC9ROyX7pcdOg8vGl9SXVOC08WBijx0J+XQmJo3R8kVien2mAV6q8R3pEW95nvn9Z
 mZ0IcYlUz+gErEMDTQz593rBSfgyUHjeoVRP0HW
X-Received: by 2002:a17:90b:1c02:b0:38e:2aa8:60d0 with SMTP id
 98e67ed59e1d1-38e4b586067mr20371153a91.37.1784647371935; 
 Tue, 21 Jul 2026 08:22:51 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e60cc2ad5sm1402904a91.4.2026.07.21.08.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 08:22:51 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/mediatek: ovl_adaptor: balance component registrations
Date: Wed, 22 Jul 2026 00:22:42 +0900
Message-Id: <20260721152242.47138-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

The OVL adaptor registers both an aggregate driver for its child devices
and a component for the main DRM aggregate. Probe currently ignores an
error from registering the child aggregate and leaves that aggregate
registered if registering the DRM component fails. The remove callback
also leaves the DRM component registered.

These imbalances can leave component framework entries referring to a
device whose probe failed or whose driver has been detached. The aggregate
unbind callback also fails to undo component_bind_all(), leaving its child
components marked as bound when the aggregate is removed.

Check the aggregate registration result, unwind it when the component
registration fails, and unregister the component before the aggregate on
remove. Keep runtime PM enabled until both framework registrations have
been removed, and unbind all child components from the aggregate unbind
callback.

Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Cc: stable@vger.kernel.org # 6.4+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index c0af3e3b5..6a259872b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -625,6 +625,7 @@ static void mtk_disp_ovl_adaptor_master_unbind(struct device *dev)
 	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
 
 	priv->children_bound = false;
+	component_unbind_all(dev, priv->mmsys_dev);
 }
 
 static const struct component_master_ops mtk_disp_ovl_adaptor_master_ops = {
@@ -651,12 +652,15 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 
 	priv->mmsys_dev = pdev->dev.platform_data;
 
-	component_master_add_with_match(dev, &mtk_disp_ovl_adaptor_master_ops, match);
+	ret = component_master_add_with_match(dev, &mtk_disp_ovl_adaptor_master_ops, match);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component master\n");
 
 	pm_runtime_enable(dev);
 
 	ret = component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
 	if (ret != 0) {
+		component_master_del(dev, &mtk_disp_ovl_adaptor_master_ops);
 		pm_runtime_disable(dev);
 		return dev_err_probe(dev, ret, "Failed to add component\n");
 	}
@@ -666,6 +670,7 @@ static int mtk_disp_ovl_adaptor_probe(struct platform_device *pdev)
 
 static void mtk_disp_ovl_adaptor_remove(struct platform_device *pdev)
 {
+	component_del(&pdev->dev, &mtk_disp_ovl_adaptor_comp_ops);
 	component_master_del(&pdev->dev, &mtk_disp_ovl_adaptor_master_ops);
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.51.0
