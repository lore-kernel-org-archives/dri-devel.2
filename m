Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F667CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0592110F0A6;
	Wed, 20 May 2026 14:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f+rOP3SH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28E110F0A5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kn/KwXlRjqhIt+wQ6tJp71uiYnDltrIKBv46ZENJaNM=;
 b=f+rOP3SHCaTDiAQEcQ9fLOIQzr0QtXrHJm06S6XDcvl2QE4vsAxzRMsmrRQXISvH9F0K1/
 HkIA4SOTEuvVY7zKrxTcK+qaNL4Hg055fcHNwqezziChKGlH49bOX/JXwNfv0KcwGf9ZJy
 wZ9P43tomDcgtwGoEWJ/PyTsYbxaoVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-5rm-7fV_MLaRH6a-8u7bAA-1; Wed, 20 May 2026 10:44:49 -0400
X-MC-Unique: 5rm-7fV_MLaRH6a-8u7bAA-1
X-Mimecast-MFC-AGG-ID: 5rm-7fV_MLaRH6a-8u7bAA_1779288288
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso41511945e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288288; x=1779893088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kn/KwXlRjqhIt+wQ6tJp71uiYnDltrIKBv46ZENJaNM=;
 b=epxtOzOFlRccQ/usYO9DSSekDG5zqHfDjD6MP9Op4syxN35bKYQIVTwWGugNQ4dSGz
 ICKd00Mf/ew+hkPP1uPEa8B6kDK0pEBoImn7g1fmNKqleFa0tTL0wuY9C9/OQE3kZTD/
 LsMXoN2r+8yQTGMCR/VxGM+9YwEXmdykcZHB0PzIZq4qxSOYspASWL6jOfps4wuGe2R1
 3mvt7nmaPAvQPNBbzyJknA8PtbavDTmg6D4zgZtvgb2byfkjvcH2w6Gw5X7VhLEUDcSj
 HR6TGxp4UBacmNflZe3agDWX5buN5XtmO33FyX6dhC37A/Asu3KGmlCFzHLAxWpLEWTQ
 97Zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N80Evb5VK2MYMNHzUwJpdlH8KiIVmlrg2L3uj/rg4fjqgyqYYDLv+FcfrMp5AIJNOjEdwF9vMbEc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJPDwdlFpztLIh6az7dn6CMjv7nhm6wVqlIYGkJ2OBeXeeNWeG
 kkqt8uXZbLqmMJKK19Dy+jo7bpwxXwII0Q0axcLvTQg8M5pywkEBbCylsT9UR4TgbdlOt1cHjTk
 ZRPcOdR/Qe369j+tjH6BAhZWZbJwcQe6L8lXHPdTH+/azVUeLAi/IoIWUJHanHBHHF6R/dA==
X-Gm-Gg: Acq92OEH24YbHLxH6bl9HB2rtlDYWTCD/AubQnIHi5RiK0J7xpIzuq/icxqTAwW3rXW
 e4wcrUuc2ME+tnAwrVwnaPCG03yy6+95qAQeW0p6/amw7FuALeD5dgukO7RmxQ4Xw/Q3dWGPwip
 sptGEw/CoM+E08+b82HfvIBXksM2VLq5tYAtvvRz9l7qcJnL3or2xeAqyAKuOitgSn2v0EucS09
 cSKJVy5V+ifeL5kSf1sl2CBuchcPOAsSWFjevGtFRLL9ld+Gqob9tfyAVXP9Crf6z5uyA4torl7
 UIMOkQa9iXkg62gZtE8lqHAg5mp5R4xwEKb/vq6f0VviHHj39qfWdOl4qdgWbLCqzky4I2qJ+Mp
 UUP5WsVuNEX25TAH/ZLY0mPguYFw5OPkAIOUGNJnzybaMyfbhAKsZXJy0lQ==
X-Received: by 2002:a05:600d:8496:10b0:48f:eb8b:997e with SMTP id
 5b1f17b1804b1-48feb8b9ab1mr239050535e9.26.1779288287904; 
 Wed, 20 May 2026 07:44:47 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:10b0:48f:eb8b:997e with SMTP id
 5b1f17b1804b1-48feb8b9ab1mr239050115e9.26.1779288287373; 
 Wed, 20 May 2026 07:44:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm394075225e9.4.2026.05.20.07.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Brian Masney <bmasney@redhat.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 8/8] drm/msm/hdmi: Use the common TMDS char rate constants
 in 8998 PHY
Date: Wed, 20 May 2026 16:43:44 +0200
Message-ID: <20260520144424.1633354-9-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yezqKGXz_qNe0HOhS8EjqMrjPUSEB49JkcZ4PAfEYS8_1779288288
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

Replace the driver local defines with the shared constants defined in the
<linux/hdmi.h> header for the minimum and maximum TMDS character rates.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index a86ff3706369..05c3ffad858d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -12,9 +12,6 @@
 #define HDMI_VCO_MAX_FREQ			12000000000UL
 #define HDMI_VCO_MIN_FREQ			8000000000UL
 
-#define HDMI_PCLK_MAX_FREQ			600000000
-#define HDMI_PCLK_MIN_FREQ			25000000
-
 #define HDMI_HIGH_FREQ_BIT_CLK_THRESHOLD	3400000000UL
 #define HDMI_DIG_FREQ_BIT_CLK_THRESHOLD		1500000000UL
 #define HDMI_MID_FREQ_BIT_CLK_THRESHOLD		750000000UL
@@ -649,7 +646,8 @@ static int hdmi_8998_pll_prepare(struct clk_hw *hw)
 static int hdmi_8998_pll_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
-	req->rate = clamp_t(unsigned long, req->rate, HDMI_PCLK_MIN_FREQ, HDMI_PCLK_MAX_FREQ);
+	req->rate = clamp_t(unsigned long, req->rate, HDMI_TMDS_CHAR_RATE_MIN_HZ,
+			    HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ);
 
 	return 0;
 }
-- 
2.54.0

