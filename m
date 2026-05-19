Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A76CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1331310ED60;
	Tue, 19 May 2026 14:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HSenv9zJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A08110ED60
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6r8iDBFlPBC89fVvBoaRrCLk0Thq/XCfLs2Px8PTdkk=;
 b=HSenv9zJ6JBeV5mMX6XfqyzaeNrrpoMDmsqfwnpsGUnJ6UlnaV7WZoKMrfRvA0MgnkRjno
 CzaRwzk7STr+Je0dYQLP2+fdvrAL+D5GSkEwHCvx0S1oOr0grZNTKMS2yXBdE50CNW/wgA
 3rPJp8Vaua9fHhxf0ZSCDqUxjUB9kqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-IrOl5z34ObefRfREwKrmwg-1; Tue, 19 May 2026 10:47:42 -0400
X-MC-Unique: IrOl5z34ObefRfREwKrmwg-1
X-Mimecast-MFC-AGG-ID: IrOl5z34ObefRfREwKrmwg_1779202061
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fdacff6d2so28782745e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202061; x=1779806861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6r8iDBFlPBC89fVvBoaRrCLk0Thq/XCfLs2Px8PTdkk=;
 b=p89vyJRMbfm7JVR+uxJIJmlw9it0/DoQzDTJRRrPqEG/AOzucbJH7IrHc5WBBWWZ9c
 /A02UZmxgUTJt0Ovt9UoAKiH7qCjIwJ6HtB8FvHczEwpkk20+I5bp4g3c2tnDQN6DoPr
 TB5MwLiPOOFoWZOyNPI9DHzhm58ZBgiGMcfijWVDN5oy+CX5A/JWM9V277RFKP4NQ3dv
 xwSn2tkpeNoNJnGipEoxRyG0V/xI9f+9bAIoKFUjHgjLQ5/xYVDigU/qZybGFohabYK2
 26U7Rh2tUmZ7qy5DEr2sdV6Iykrx9lXX9huf/WlSPZdGLJfQnCF+btgxKtkDNYKVyuNZ
 tqjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VTFx5vrc2th8sqs5YppqVatLsp60hVE4XL8A0GUN6r9XPFKpMrQutjSLnqfPXZkrg4u3ycYATewA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLpLaysBHOtiSYkDWkXYV3VVutmpLqs5SJtC4yKLJZJjOQZ7wY
 oU9jCat6gCsmzwvQXWWSWdflnXdBegB94Oil45ymzpubzI9alMGSZJFhZp3y0rIsoqa/M3jRNf1
 G/FbSLjdNXwqW0NQKiEGR2RjgM6HvFN6en6DYAavtQ9tiD+S+itxla7A17J4o5oUSkEOBwg==
X-Gm-Gg: Acq92OEmlKFb7Hb9KTn5ovPu303wG8INIcZIPaFz6JrN1S7fKK6eT4E33FdlJ5dwmqq
 vKzm+nKIuIKnWyIpyn9+MGSvrP/4RAVkManF65u/OplbGaq5AHU7/9u5AjdvuXvJTMSDsn6TWeY
 D8h5pcCvlcJwitH00DFeBgE82NvwHtbg7sACuQcRRKsN7Wu+s3stBWLlRzP3m2QEUPGSeg9yP4T
 9zVBQfz9yXomS9Ic+DkItM3qYNx1rO+IPF6l9OFFnEPsLEoGX6nXd1VG9GxEbboFXIefkPyi+68
 GqBthYskbqdbxhPnLlx/lJcGtaZw4cARUKGmCNDayt8m5V8Wf+82H/1H7orOEfLdpVHKxjU3Zlw
 mpyF42Xpkqk4E/qBhgP5t1xZqZ5oYmf4Tb0kwg44VEcRPVcA=
X-Received: by 2002:a05:600c:858c:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-48fe60e54d6mr245200585e9.3.1779202060688; 
 Tue, 19 May 2026 07:47:40 -0700 (PDT)
X-Received: by 2002:a05:600c:858c:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-48fe60e54d6mr245200135e9.3.1779202060303; 
 Tue, 19 May 2026 07:47:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49008c047absm67922045e9.0.2026.05.19.07.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:39 -0700 (PDT)
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
Subject: [PATCH 8/8] drm/msm/hdmi: Use the common TMDS char rate constants in
 8998 PHY
Date: Tue, 19 May 2026 16:47:04 +0200
Message-ID: <20260519144712.1418302-9-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5oaUgB3SUqkyujflLVQkkMymVAvhoS66ZmHuUgEZ-c_1779202061
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

 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index a86ff3706369..3d2c1de975da 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -7,14 +7,13 @@
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
@@ -649,7 +648,9 @@ static int hdmi_8998_pll_prepare(struct clk_hw *hw)
 static int hdmi_8998_pll_determine_rate(struct clk_hw *hw,
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

