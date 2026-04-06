Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CB5F46C66
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4957E10E28F;
	Mon,  6 Apr 2026 18:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f1jZTypX";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E2610E28F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 18:00:17 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso23979375e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775498416; x=1776103216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JuaHqZA6dNQtvLkTpFq0gKo8sR5f3PLoD26I4i7/L2M=;
 b=f1jZTypX+izGmnGrOPmFnAz2MNs36/5p8ukvgszQPf40mxFrl/eSL7FW3LKD5SovsV
 hZu0WjK3hsiQdxLKeAAvYYCiYXgr2IjI93is2W2rr8UAbrUhQQSr1PG5/Pg9FVCsQ0jK
 Ma1cufI83aitZU86weu28S9w0pk56WLfcrlkZrnGdgpKybkhXYr5No2DkzzJrIMLK9vo
 LqlXo6Ri1T8vA1VstbTFKJoHW2/10dBQOn1ARApeHR8ndzdodyYnE0OOdNp3HsZAHq08
 ftEeuyr+ANud+a/P+VW8V9fxGFTxSM5kYfxey+z3+nc3BFztxbkN+Pn2P8waw87CTrtv
 9Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775498416; x=1776103216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuaHqZA6dNQtvLkTpFq0gKo8sR5f3PLoD26I4i7/L2M=;
 b=pJJrR0t2AjKBWvBOue7SUlPH+fs9mY4lCzsIFjYhFUNPbu530vQOKxR4sH5iDqGfE7
 QrnwDqkG8iciNcEGmweP3n017GhIPul1PuiidJxCGmqham8T1MlhBgARZ3k6ov07+sXb
 8eBbCsmxouPQ2/y1wuKuCEgLjbShOYv1iq0U1LA/0o8PrSh4G17CBIaDXTENGVAu+Y/Y
 h8S9vi1xQpkt9P2ApmqaOp3PPC8A9rPjFVT6aNXvnC6gHLMc70/ZoyacxS3+aF7DWPH9
 960bTcHn7HqfPT7yzj8YPdLw7OzGQpUUcEn+T7II15XXt0Wo1UjDjzY02C/zEF4rDqJu
 i5Ig==
X-Gm-Message-State: AOJu0YwIRkrUdkzv182nDp5x2LMDmEvqNMe4yjr3dvhNlexnFyzrJsb0
 pMhcJ9vzkdCz8DhoHeACI9cLxBfD2yFoKuQuW7VYUSlkFzjwnvS5yxvf
X-Gm-Gg: AeBDiev6/bx7ARRihHKP7LCAgDXSINOwC4t6lmcC3WTzh4QeuFjLvaLwXpxeImdKfNZ
 vq2U6TqfYb5EwK9qc7xmyidPXTb0dll46t6I9sCiAx1lAWlkrSPoaokQT1iLN1S4o6s9iEOQTWL
 kzgk8rSftCy/Nche/tKSafXIKCICDKC60CaQ9pZ24bjiimwj0d8JjsK5uuTUISuP18/b6c1AFpR
 22RRw34zZ4HSqgzT87CHX9wBU1zOLYAKPz5mm3fIPsKHuh1fZe+vCYG9EZvJiKTM/pGi/xx0ZVu
 fg5PNO23d43P8LY5pS3mYSSuSe/0zdUcXBhX+6q5P2+fDUAPcCZ1sVBhBBUsF1SKNlmFMGOE2jd
 BYz0/wqGJ0NLH4mBtdCRuoViZXPctlSp+4LBL4a964J9d/Zd8yfSuK9PWv8hE7rw0nGNsTQ5Mpw
 HKmmOQXQlZhMC0f3mUEN99H9W6l8ihkx8+8WF4vTz8s6rObhsh0y377/AkC6eZlG7wsQQnL/VEx
 fToYegnRYADzVko0Gw=
X-Received: by 2002:a05:600c:a11:b0:488:8185:e672 with SMTP id
 5b1f17b1804b1-488998f8562mr176298535e9.30.1775498415418; 
 Mon, 06 Apr 2026 11:00:15 -0700 (PDT)
Received: from Arch-Spectre.home (host-2-101-228-96.as13285.net.
 [2.101.228.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a952a03asm170205575e9.0.2026.04.06.11.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:00:15 -0700 (PDT)
From: Yicong Hui <yiconghui@gmail.com>
To: laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm/imx: Fix three kernel-doc warnings in dcss-scaler.c
Date: Mon,  6 Apr 2026 19:00:13 +0100
Message-ID: <20260406180013.2442096-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix the following W=1 kerneldoc warnings by adding the missing parameter
descriptions for @phase0_identity and @nn_interpolation in
dcss_scaler_filter_design() and @phase0_identity in
dcss_scaler_gaussian_filter()

Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:173 function parameter 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'phase0_identity' not described in 'dcss_scaler_filter_design'
Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'nn_interpolation' not described in 'dcss_scaler_filter_design'

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
index 32c3f46b21da..5c7f8d952ec1 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
@@ -166,6 +166,7 @@ static int exp_approx_q(int x)
  * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
  * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
  * @use_5_taps: indicates whether to use 5 taps or 7 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output filter coefficients
  */
 static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
@@ -262,7 +263,9 @@ static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
  * @src_length: length of input
  * @dst_length: length of output
  * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
+ * @phase0_identity: whether to override phase 0 coefficients with identity filter
  * @coef: output coefficients
+ * @nn_interpolation: whether to use nearest neighbor instead of gaussian filter
  */
 static void dcss_scaler_filter_design(int src_length, int dst_length,
 				      bool use_5_taps, bool phase0_identity,
-- 
2.53.0

