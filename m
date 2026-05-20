Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97555CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFA010F0A3;
	Wed, 20 May 2026 14:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hNBtJOwX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCF710F0A0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7doYKg7uNXVfPcHfcWD2JJnnh8uBK1RxSsGyXu0nvLQ=;
 b=hNBtJOwXgOzEoqpTYMi8xCFqlZrgNJFbGghP+IgLiTYMyrn8MF26rxUOB1zoIBojyNy/ja
 0buRvzNsHJ4yIQWRLFsCofnVUXsiWS6KpYr2BMSpTat1OpkB/5dqR5OpoX0PVR5HkXMTLr
 G8w/a4MVQPWNdrpfU/3JZ03GLXhsXwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-PVruGua0PSys1EutL9mJfQ-1; Wed, 20 May 2026 10:44:47 -0400
X-MC-Unique: PVruGua0PSys1EutL9mJfQ-1
X-Mimecast-MFC-AGG-ID: PVruGua0PSys1EutL9mJfQ_1779288286
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d127eb013so22406485e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288286; x=1779893086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7doYKg7uNXVfPcHfcWD2JJnnh8uBK1RxSsGyXu0nvLQ=;
 b=Nn7NPpOO0xNOi1W8tFlYqwsUfRYHVD/Q12UoD/9ONo3QIwPw5fU/dRuWIWIkINoSAM
 GcV0Unmo3QThbZHSJubQ5BN/MHTkveuQIf8fnwYw8KaPkFDiMHi/8r8+quhgnD+0Y4mQ
 9p8yHQB2JzVW9jZcW4H4FdNvT9bqDeEbDF54MoDRtthSLclFcAcQ2338hz8Y/Rp4nTuO
 mc74ZcipC+uVvDqwWuA+Sa2X2rYWSYviu6v6Z+cpqZnX3P1U0Ms55NziHvGY0yJj8x14
 R2BdKa4Fg8M0vtR2E3Nscu5LabP0Cs1jGsI9EMx5/Dg8KlCVLz1JyvOKAWcNklM5Kenz
 DXQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90FKmwL9dWl0lHrjHC+ax+vG7hGasg0GhiMShEC1rPeVic5oEBVIpPlhFp6qQvFqxsQXYHHC3rdzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwzGBX9VRCfDuXZj3CaptsXvVUwf4xPszOnLPUtbJHrjvPNKSA
 8HIluDIZ0IiARhVaEmAzBxlINTNwWlDl+mdFXNrlRi+gB7rWsNON6a5M3fQHz0avM+YanjOmcsv
 yQjiMh9QEF4SgBGZ7gKyt8qpwwvdmitDKEsUBVok1Owro9aFxzbf/HbF74rkqnHkQSEThkg==
X-Gm-Gg: Acq92OHx4HpzoHP0fS3KqaaszJVbKjSM1ui5Y2CfYXmalm+a+SOW24tsr047Z1tyYMm
 gdFov+aDx0pvfFwXjLFCcI0KHFb5F9BhtELJVSgdmQg7n6M9wxdbaSUp7PFRPH0toqXM77F7QpQ
 /9VJr3tst9i1kjalgXwnqyXENJfjVqy/bZOe0yEpOzDFC4CMyguLUWOPtA+BGmnXIOA8cD9oprv
 EEhUI+FtgM1gsQHZPaMaGZe5X9W3yvfbIElk8Ghm2jqQxul6ALxU1dXPteIUqy14+52WRgsMYPx
 Vf58rB2lJELmwXS5AdM4KSp7ofhxjFZKV4ZelYeZpUyiBJttzU69wiXvkYkWjCDnUjbU8tpS3hu
 11YHfR/6JFn43JY0Sfl2NTvnBRAy7yRfZ7id2LOaPQudbp5zerPlyClKQOA==
X-Received: by 2002:a05:600c:c10b:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fe60d55c4mr267397275e9.9.1779288285867; 
 Wed, 20 May 2026 07:44:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fe60d55c4mr267396555e9.9.1779288285203; 
 Wed, 20 May 2026 07:44:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4862209sm398446965e9.0.2026.05.20.07.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:44 -0700 (PDT)
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
Subject: [PATCH v2 7/8] drm/msm/hdmi: Use the common TMDS char rate constants
 in 8996 PHY
Date: Wed, 20 May 2026 16:43:43 +0200
Message-ID: <20260520144424.1633354-8-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 18y8bgo_eFnKn5uORQBBdwCwPm8TFiLOChjW48C0Kts_1779288286
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

 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index 36e928b0fd5a..71da20322b3d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -11,9 +11,6 @@
 #define HDMI_VCO_MAX_FREQ			12000000000UL
 #define HDMI_VCO_MIN_FREQ			8000000000UL
 
-#define HDMI_PCLK_MAX_FREQ			600000000
-#define HDMI_PCLK_MIN_FREQ			25000000
-
 #define HDMI_HIGH_FREQ_BIT_CLK_THRESHOLD	3400000000UL
 #define HDMI_DIG_FREQ_BIT_CLK_THRESHOLD		1500000000UL
 #define HDMI_MID_FREQ_BIT_CLK_THRESHOLD		750000000UL
@@ -632,7 +629,8 @@ static int hdmi_8996_pll_prepare(struct clk_hw *hw)
 static int hdmi_8996_pll_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
-	req->rate = clamp_t(unsigned long, req->rate, HDMI_PCLK_MIN_FREQ, HDMI_PCLK_MAX_FREQ);
+	req->rate = clamp_t(unsigned long, req->rate, HDMI_TMDS_CHAR_RATE_MIN_HZ,
+			    HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ);
 
 	return 0;
 }
-- 
2.54.0

