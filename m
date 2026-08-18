Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F8EC5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E065310EA76;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="S7Gh3X+W";
	dkim-atps=neutral
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2767110E2BB
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1787059087; bh=2hMu9OlmmtjRiRbZJu7fRfLqMPwN1YlZmtEFvcpUaPY=;
 h=From:Subject:To:Date;
 b=S7Gh3X+WSaWASWls34n/rNJSxC48ScwkZ1PF0UwsWucN53Ve8N/cpHgKB8iQu/5Hp
 w2ueD48LpMVqAoXt3J3wmfIfmgnQFT+MDv7bs2heEsWw/fQV+0sLxCNIfpvhaMfHOz
 nA/qw0dMqubNsJ63N9hlFqx1tWbksx6VVLoOGPYk=
Received: from [127.0.1.1] ([5.195.0.150])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058995t9fe7z17i
Message-ID: <tencent_90AF2A01EBA98B24211F74B39C3200FD7F09@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoegitSSTWVpOdQ42lvbogggrXlyrwQIIJyZRLgcs4BqMknKIxoNR
 SFAcYKzz8Y8212TOxMKyHA9Y6yF1D9lJmyMJRRWLs+x71L5qcxrJG3hQQpyj1bmLYRmQiqwtrN05
 bNATp1HI4J52JM/5ZdPS9m+aiu7qjpqeeqSmkLWRaO0LgatBzGTpRK3Q2uAsWP8d53v/w1OHHthg
 4sUgH7GIcmZUfbYZk0wxrDzN1g+nkauwI+qX+4v+Fhn+Vwi1K4bEfBqjG2A+b+C7WOBwtgP04Gea
 iN9jGsPEgYh6H2wjp344E40khF7XWmip4Slf3geiBETCy+/58Aq9EDLRdTFDZQn0Mlq7hrKErjdn
 oZyoISmfFfnnZAfD34DSbiQzrm7Fx+RUz7J5ep97ZBBZNUPutLPDlRy3Pq/cubOM0vw2mC7kGoNI
 KhIlMc70oiSeNM9NI4U1RlQ2eQh6fpg8ptEahbntAH0RaokZcphdOf5YmD5NlW7C2rQuahGz4pBw
 PfpkcnK4kTBPnD2BZMHCiOlvoxVKQLYYUgtXZlw8e7jWlcvdnBTZGar0O6Wh25qx2mGcb0GV+aIi
 ifKP2fB8FjYNeckJ7cuziZbJ1PqSu7vsmlo/TK/Jn95Hfut3u93PKTm2Hc5CL48w652ze6szoBwx
 H0VHght4iVrFu0HA36z0UZBfGUN0NcZWen/iwpCs65+7uXQnaPa6RDVvgAubyQ/HVHRhNOntFnF6
 963nmaWZbDalHX/bigvU12yDKK6ZBTKHxuTAdXytDUeBo79Jr0uirjcHFf9yELp8hEDeWZM836an
 cW6vHGaABAnzuT98gvwBBObJ0Zq+wLa61Dk0QTzTiFfHNlgIJwc+VwQfymZb8AUMDcL7iOYwCY5H
 56z5oRXejIMH+EhmWKYPONImdLY3X5l1vOS04G5MURGBRCwJEvwaZA7/WGP+I/I2D6hZlgKtzko2
 uSUSxt+cQq+dDrEjPA6DytSx6inHM1KKSdeqiv/GI4u3arrtXSpNcQN9EFUdsY3V1RN1WPXd3EZA
 WQQYFJTlBvB1ZZCedUgmmhFnBLblYdUX+rLroDvTz6u2RX9Dwhm+ihK+g7B/c=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] gpu: ipu-pre: handle clock enable failures
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:18:05 +0400
X-OQ-MSGID: <178705908535.291840.3174452527939975091@qq.com>
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Check clock-enable failures after a manually managed allocation.

Release the earlier allocation and return the original clock error when
probe cannot enable the clock.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -311,6 +311,7 @@
 {
 	struct device *dev = &pdev->dev;
 	struct ipu_pre *pre;
+	int ret;
 
 	pre = devm_kzalloc(dev, sizeof(*pre), GFP_KERNEL);
 	if (!pre)
@@ -339,7 +340,12 @@
 	if (!pre->buffer_virt)
 		return -ENOMEM;
 
-	clk_prepare_enable(pre->clk_axi);
+	ret = clk_prepare_enable(pre->clk_axi);
+	if (ret) {
+		gen_pool_free(pre->iram, (unsigned long)pre->buffer_virt,
+			      IPU_PRE_MAX_WIDTH * IPU_PRE_NUM_SCANLINES * 4);
+		return ret;
+	}
 
 	pre->dev = dev;
 	platform_set_drvdata(pdev, pre);

