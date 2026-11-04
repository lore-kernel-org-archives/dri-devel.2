Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E36606A32E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YH0owmrt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D671410FDEA;
	Wed,  4 Nov 2026 18:40:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D9A10FDEA
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:40:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D689A60609;
 Wed,  4 Nov 2026 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962011F000C1;
 Wed,  4 Nov 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793817623;
 bh=50rGR9cXkJVQg5CMtsd6DUV43765lQnsvly1XxdMTMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YH0owmrtK0BSOY0x3Udi9bIcHuJ5NxapbuTyxP+I4SQv3U/IqGFPZfunwyQHccvbC
 8Injk0sgWFwIYXNaH3xgJ4T/UtI/pjC6BMRogOAvegaVXG1Ruiv2aK1o9yzCpQylvJ
 /JELR22lVcTufOn255egMd3KW7pbt2pmeEvXNFOGfEMkKFqEe+Lu3QMzMNIc2B7phe
 XkutnkQQSYtdvzRpwMq4jLxMb1QJgBVeAm7LfBMBK+bE7zpOsdWSEz8X6BJL15buFv
 IzS3amhkb7hmfVgn+zB7hnroZpF7YW3wdR9TXovqhzgNm2CNBdYn94DslCSlNm4ouF
 DJU1y1fIa6mGg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 6/6] backlight: qcom-wled: Avoid AB-BA deadlock in
 wled_module_enable()
Date: Wed,  4 Nov 2026 18:39:07 +0000
Message-ID: <20261104183935.1214630-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When disabling the WLED module (for example from wled_update_status() or
wled_short_irq_handler()), the caller holds wled->lock and invokes
wled_module_enable(wled, false), which calls disable_irq(wled->ovp_irq)
and blocks waiting for any executing OVP threaded interrupt handler to
complete.

If wled_ovp_irq_handler() is concurrently executing, it attempts to
acquire wled->lock before running wled_auto_string_detection(),
resulting in an AB-BA deadlock between wled->lock and IRQ completion.

Use disable_irq_nosync() instead of disable_irq() in
wled_module_enable() so that the OVP interrupt is masked without
synchronously waiting for the threaded handler while holding wled->lock.
Because wled_ovp_irq_handler() may already be waiting on wled->lock when
the module is disabled, verify under wled->lock that the module is still
enabled and not disabled by a short before running
wled_auto_string_detection().

Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Closes: https://sashiko.dev/#/bug/linux-3afa151c-7b8f-432c-8f85-8c43a83b964a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Heidelberg <david@ixit.cz>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

 drivers/video/backlight/qcom-wled.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 06300d403f8f..6c0f631cc975 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -367,7 +367,7 @@ static int wled_module_enable(struct wled *wled, int val)
 			schedule_delayed_work(&wled->ovp_work, HZ / 100);
 		} else {
 			if (!cancel_delayed_work_sync(&wled->ovp_work))
-				disable_irq(wled->ovp_irq);
+				disable_irq_nosync(wled->ovp_irq);
 		}
 	}
 
@@ -919,8 +919,15 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
 		if (wled->wled_auto_detection_required &&
 		    wled->wled_auto_detection_required(wled)) {
+			u32 val;
+
 			mutex_lock(&wled->lock);
-			wled_auto_string_detection(wled);
+			if (!wled->disabled_by_short) {
+				rc = regmap_read(wled->regmap, wled->ctrl_addr +
+						 WLED3_CTRL_REG_MOD_EN, &val);
+				if (!rc && (val & WLED3_CTRL_REG_MOD_EN_MASK))
+					wled_auto_string_detection(wled);
+			}
 			mutex_unlock(&wled->lock);
 		}
 	}
-- 
2.56.0.385.gac671c819a-goog

