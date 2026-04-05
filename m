Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CE3E63FE8
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 12:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8F410E227;
	Sun,  5 Apr 2026 12:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l12VHwmY";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCAC10E227
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 12:40:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso45424905e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775392809; x=1775997609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WpsAyL92FDCh5oOjRcERYi2Aj196fNE0wI66u8b/Ojs=;
 b=l12VHwmYdQvGzgtFIsIdC/Hp0cm8uM6sz+z8wzegjYGiOKZBJPfVSwVCAm/8VH1UpF
 aIodZiUaXygQMQe6w+Mbq0htYIIPgN5C/lrjNshF648/j9BYRg6EP31kEgtXa/2LKeev
 akLHdzOeR+p0IIKed2E+dt2sXrLuqr9jjX7bYR8iCQGZqtMVJ4Mb16GrVpiLzFLCaXvK
 tYhWGSgeuOneYeXVCFcNqky6AO+XWEASo7eQXIbWq+txCCKp8Pil4SYKg57s146wAKIy
 TofmVKHH1IBH3BI0ONtZxAISmiM7xEBbox+NFC7yS0ozkxq2Ebtb5/P49IPL0eZUmLgW
 UeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775392809; x=1775997609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpsAyL92FDCh5oOjRcERYi2Aj196fNE0wI66u8b/Ojs=;
 b=VEcuFTIJYl4/bNP2k9GAsxILp1kKDoTzZLRIY+CFEso252SVXN5rIV62/c4fwxVJj0
 cXR35YXWmmhzAaW295VP1N1r8Tx4/ie6fh4d2Uhr1pm0CJSBPyXB8ewtNWt19vmJks1I
 rwQkzo5VXMnupD6CQDldSwhKANM3lVfMhybbSahuDOoO5e/YixbM2vPTevLWhx6xQAml
 69HfwZ9GnaAnk2ipXlFYQO90HFEotR8mT8gsUnD8rIvpzJolqmKkjWTn2TeRAcuczZ5N
 TNNh8CRDNTuh7QveRp2ig/GbsdFHnCgPVfxQj033EWa7kl6R1wZkJszohW0+EBHzHKke
 xeyA==
X-Gm-Message-State: AOJu0YxFqnFm/8HSLZ5HxS+qcSv560DgZGIFVLeSl3cHCvzaOdzXGe4K
 1FWjjlkX8DBFYP0Rx43RPSsgJHD43ZgKxY2iHjwULYrMM2qj5JTInF4l
X-Gm-Gg: AeBDiesfH2+4SlssNyO0xDXmEYza3ATc/RdJJ7Na5lDvG94xdOXatPzTpRu2TecAgT3
 ijX6mZSzItQR8fTV9n+RxWM8XFO2ox1O2KNq1F3NT3Z7u1YvlyQf7k2XCpBZWkO4tsdjzshh0bJ
 wKnanQ/MY89953bgubSmy0DvFWGg5LL5pdxZGUld9a1omX65FFgsCQSE2pROuoKj6hO8qpr9WJB
 HHNWRG19W18P3ZKiJSxCb14vFbtDehiLPpFqERsMt/ZVK/Ifs46Dz+g4Y3GQrIXS8sWpRkKvhV+
 68jsC2K5aiqM6iElb/3CyeMjcKtgnlbzmmFTSk8daY7NpNuk6VpP3uQz7YUndLBU1XX7rme29K2
 24flTWsUXlo89FpcBrWLdAvoL0kcstM68E+2/EbgraPFs9vgayxhEh/YedPzMMux3UUcTmkgFne
 V9xAkWUPoVBFE6PFcRzUmvItAD7U+nrFV2B7HZ+aUGftvZsAfbeluF4+DgTnqeGaWJ7uZ9Y1CDU
 /rwDbnaM+Wm1KAUxC8=
X-Received: by 2002:a05:600c:354b:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-4889947fd78mr131309805e9.7.1775392808871; 
 Sun, 05 Apr 2026 05:40:08 -0700 (PDT)
Received: from Arch-Spectre.home (host-2-101-228-96.as13285.net.
 [2.101.228.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm529333055e9.3.2026.04.05.05.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 05:40:08 -0700 (PDT)
From: Yicong Hui <yiconghui@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm/msm/dpu: Fix kernel-doc warning for
 dpu_core_perf_adjusted_mode_clk
Date: Sun,  5 Apr 2026 13:40:06 +0100
Message-ID: <20260405124006.2688556-1-yiconghui@gmail.com>
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

Fix the following W=1 kernel-doc warning by correctly renaming the
parameter crtc_clk_rate to mode_clk_rate in the kernel-doc and using the
correct separator of : instead of -

Warning: drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:41 function parameter 'mode_clk_rate' not described in 'dpu_core_perf_adjusted_mode_clk'

Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 13cc658065c5..4616b0f381c6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -34,7 +34,7 @@ enum dpu_perf_mode {
 /**
  * dpu_core_perf_adjusted_mode_clk - Adjust given mode clock rate according to
  *   the perf clock factor.
- * @crtc_clk_rate - Unadjusted mode clock rate
+ * @mode_clk_rate: Unadjusted mode clock rate
  * @perf_cfg: performance configuration
  */
 u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
-- 
2.53.0

