Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E678CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAD510ED44;
	Tue, 19 May 2026 14:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZJeioMyM";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4758710ED5E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePBiuXBOAJ8Za5EC9PfbU980/aL/8IJLEdhXnj55n9g=;
 b=ZJeioMyMJHJapX8HeFG/xSx+e2m20pgA9p43AfuZ8tI2CFnPt8J0C/yW4fvl0KP7Ombq9r
 RZxaL1KjbDzraWquwz85OjPBJgO/HsqcrzTmSmVGistl8UZcC5cjjxMwjN/U4iBnUpk01F
 QwEVvqLPGx1H3hkRN4Z1vpm0MaeJPRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-s8FNrNqUMpKfzZ7FZmWamQ-1; Tue, 19 May 2026 10:47:40 -0400
X-MC-Unique: s8FNrNqUMpKfzZ7FZmWamQ-1
X-Mimecast-MFC-AGG-ID: s8FNrNqUMpKfzZ7FZmWamQ_1779202059
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d3eec9bcso27129095e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202059; x=1779806859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ePBiuXBOAJ8Za5EC9PfbU980/aL/8IJLEdhXnj55n9g=;
 b=GpLSZa36eGJ+Lc9kafgvEGOCEvVDE+uFGO9ewZnqjXsucEgMf5TZEck/1CqpH/WBTL
 hhPXrj/prZXKZkO7ANcRui/wl0f8bLJ9qwyjkW9RCddIKvOB0FNUEXs0wlocOMx0bCgH
 TneAG94JXQ9XOicXGkeSmus+6P99gThqLADWpo4K7UOKUJMuHfExNacOUif4Fvewyb+D
 8W0FURGww9MgakKpxO6J+aROt2aNM6Xjxbj+pPzcgUwL0GkrnzQl/RDEbLHVXEkwW6At
 Q2MzTFoGMqjJh3E8yOFu8eZOeu0qJqHX1ta4DUvJIzOZTmKIiOhpxvpYjQoFBqXeAGFO
 aLhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N8UiCEFdA/1a7E4tdmZ1RB/w8zQ/Ldy0XJhACWvRmW0sHE+FskfL8NhGHZyc7UovuCmAzTruRozs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0R1xXJqArlM1bJNEppauX0G11uxSrLgsM/rFM7ZQ/0YnhgbR4
 wBk12pWL2JRYuVXiVuN4Y/vLrXNl4WI10m3TxNrsvP/cVFp2nqlR0+TkpDNQvJ2QUaPzWoj+JXY
 0Hrli/c4FVcaiQmqra2QkyfzpANVgyziuh7CsVT6ocHjY/ehGvn6i4TKc3iAjeOYEWSYcg7yjtG
 m6/g==
X-Gm-Gg: Acq92OFSCPlrz1MJgsEFnOaEfazTlLUwP29fUME2FfMBhpiAMUgStjhQw7ckhlniz1P
 noD2QKH6fIKnDwT0e0d6ZsAnCUHpNtPkEQ9otA9xIm/74sNMLRSJToyYFT05kFnLGyeCgcgf5Ut
 2T1tHBFLENAd2IxuD75temrm42BKXcPXJhA2HNgvSb+ENLMYexCu6Fde9uuOHc73OSmlZ4F/OQ0
 sOXkYwShojnk+hiFEBQm+RD5MWwn3F5SHjBrpodyfJLNGrHIQtg4Xs91cZTV66sjO94M18HiNK3
 8zpUTlY8WLBkG3M10djd3YKehs6DwLHei3Z9RtQrJ9aSl/BNBV7WjR5xqR4Cuv/0OP5dcaYsREo
 5Hv1ALzmruPteYOYvrOfI4xatb7GQwu6Xy+1sATdFDpYw4ro=
X-Received: by 2002:a05:600c:c087:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48fe60e1444mr223519645e9.2.1779202058884; 
 Tue, 19 May 2026 07:47:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48fe60e1444mr223519425e9.2.1779202058487; 
 Tue, 19 May 2026 07:47:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ffed68baesm99701235e9.0.2026.05.19.07.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Brian Masney <bmasney@redhat.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 7/8] drm/msm/hdmi: Use the common TMDS char rate constants in
 8996 PHY
Date: Tue, 19 May 2026 16:47:03 +0200
Message-ID: <20260519144712.1418302-8-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YREmr_Keg_ROJ_vg7mRZ-HIO3b9An0ks23hWA2gNYjY_1779202059
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

Replace the driver local defines, for the minimum and maximum TMDS char
rates, with shared constants defined in <drm/display/drm_hdmi_helper.h>.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index 36e928b0fd5a..a2eb84358b01 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -6,14 +6,13 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 
+#include <drm/display/drm_hdmi_helper.h>
+
 #include "hdmi.h"
 
 #define HDMI_VCO_MAX_FREQ			12000000000UL
 #define HDMI_VCO_MIN_FREQ			8000000000UL
 
-#define HDMI_PCLK_MAX_FREQ			600000000
-#define HDMI_PCLK_MIN_FREQ			25000000
-
 #define HDMI_HIGH_FREQ_BIT_CLK_THRESHOLD	3400000000UL
 #define HDMI_DIG_FREQ_BIT_CLK_THRESHOLD		1500000000UL
 #define HDMI_MID_FREQ_BIT_CLK_THRESHOLD		750000000UL
@@ -632,7 +631,9 @@ static int hdmi_8996_pll_prepare(struct clk_hw *hw)
 static int hdmi_8996_pll_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
-	req->rate = clamp_t(unsigned long, req->rate, HDMI_PCLK_MIN_FREQ, HDMI_PCLK_MAX_FREQ);
+	req->rate = clamp_t(unsigned long, req->rate,
+			    DRM_HDMI_TMDS_CHAR_RATE_MIN,
+			    DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0);
 
 	return 0;
 }
-- 
2.54.0

