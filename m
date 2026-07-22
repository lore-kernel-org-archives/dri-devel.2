Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4680C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCA110EC63;
	Wed, 22 Jul 2026 06:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="islnYv1w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vzf5n+6H";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CA510EC59
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M548GB4027826
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8f3pTQWb1DUH/SMD1hqL4uhPClug+lZg6FGrEkFBbg=; b=islnYv1w0yq2w6d0
 2ninNRob4gjDNO995Owp67Jp9+wDIHuCd1/kEX+UWRKwKlqOfXmYd1g0nIHK7ouY
 I8S6NBY/PZDr8eI6eBqYJyQu1vS5NKjgF48fllkYQe/yy9zNJC6WHPKkGi4++x4L
 Wes6+Wtb5dAo2hqLBqVWmpu90baFBycXMB4aCKeaxjsw0MjgmrtYiGxYmHP+2mhE
 Jd99Hpgi9Gs/DBZFXCfr675pRuKK6h4nNcv1QGoEXTbpwkVy+cLB6W8Y+/mC9K4q
 gJZ38hbJLimlxAMwO0WwJE7ZC49/5+zJB119betri8Nim1KP1gOJPpuos35MYCDs
 1tOysA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbvht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so213000871cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702208; x=1785307008;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8f3pTQWb1DUH/SMD1hqL4uhPClug+lZg6FGrEkFBbg=;
 b=Vzf5n+6HjqARDCVf1OXmUVZ+DDIOFyyRpyvHq6ToxmniIQLNLORGu71uadt/NClvgC
 40HSr3AdMRLABPI9DlfK1tqGZUYki7gEUGErFlftfG2amgNNsxvtBLkhLt1De7FJg1dV
 1Vei1vmL3jGo++FKVe9SJT0uU3EE9i7Ye0Q9BU6/NWeALI0IjA8UsglZxjciCyjCqfIA
 6U8vEuQAjPtyKC1HXse5VGt+zWrO8ehQiWJhIs0+TGoNsABDiP9vSlX7+wV2tnLCHPVd
 FhZiYavBogZPQATGrUIbUy713ZzuA9Yb5NoVr9S04SjGgsdyo0UI8Zo1OrbfSjkVnRhn
 L1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702208; x=1785307008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8f3pTQWb1DUH/SMD1hqL4uhPClug+lZg6FGrEkFBbg=;
 b=CYi1jEGrPlKYxCGKhiHs4EWXRGbX3SfQ+JtAvCmm5kY71NjG0/x6Rs85iVF2DKa/lk
 o0pnz28Stw6VXOckV6DRDwr7yf9OFvvFGCuW9LFKVbov9xg8I18wJi6YcI92v53XHa0G
 060QaDKtlliQcs5hq2zDq6UoB+x/IyuZDzbg9vhiZSrg1KYE3jqLUJ7SLY83SIwkOeDx
 nMhd6JkPLwRb5xmNcN1KMlkYFYZcjZdGbQR5xWOhruPaASSZEXJJiA/fnVBkj+72XjJc
 2abvfT6hbuVl3vi0ZB8DnW5VdyXcpccURZUJBhpNyWRt+pBY0LOFGoYCzFa2QHu1oFxM
 vTDg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro206gx3JGLvhbFEY6qVS7uwiTFie8eAW1PwvUTFiJOUK/JejHk5zxb/63rE5TLpaG8z4XV5Fvy4vc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+M/PxnopuPnc22Ib257fzENqunZy7F9qhfgHaC+NUxBD4bSUm
 JEu9vIMn++JVbbrEHKcw9PTETJW+ACrbiQA3WT25n83kWOyn4/bfpbiuUc6oMvTywFx9Lk2M6fr
 1CihGtrUv8OwaQ+CsUkmvI9e8Rh9x4Gp36tf3TWF1CIc3og0kKpLC7IC7HnlfwG9sRiGRsYE=
X-Gm-Gg: AR+sD12/6ewazJeYL4u9XtRmx2ynAUmsdP4wzzZ2dSG2bUupyCSjSXt+dVOtFkvgmYW
 7xCNM/2SYklxfIlHtZp8Z8jI9aw0HOcIdlR0uUTUQieCs6humS2Sk8CU/oeU3CO7MovauiWmsWy
 51d89RjflQn7/TJ/Ie+Evq2j+3bV6s4qiheMe9ll7hN8cOy5ioT/jpo3TmGRuc2f4QIv+uQy7UN
 gqoBf1+7d6YnFc5zNkFy9Dl6pjF4OcdKwVl4gHvr2Luqi8I1Vxt094A19qXBKyxyszyRN/mQD3Y
 UgeqaWztpVBLLkjJdVy6rPfGxqp0+bAY0Bq5/6voVc2by8lLl1h1YN+pQi47lVXtKCQ6/xfeWVG
 Ogp7rgkL4sCAAmUcH6Sw7+13yGy0x/imIYE9JvTbPZUn3ktBK52pLLLEyG77OZX3h1l955Oki7b
 DfdJ3kEjG8n8p/eQ==
X-Received: by 2002:ac8:58cd:0:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-5213c2015femr202516381cf.25.1784702208010; 
 Tue, 21 Jul 2026 23:36:48 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-5213c2015femr202516161cf.25.1784702207520; 
 Tue, 21 Jul 2026 23:36:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:21 +0300
Subject: [PATCH 06/24] drm/msm/hdmi: capture the HDMI registers in the
 display snapshot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-6-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wHwe7eJuJTYqmz/TsunqqWhXimzjZh7z7oauF1VXkeg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1ZCyvOUHD6riAeqFdIfzqzVm8yjksD7+YKAgwt37+Wtb
 z2Wu27pZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBETiux/y9gvzFFd+oKnocH
 133fZByUtqF8QWnR6b9PpPqib93XZ88NTBRYHFim9mB5R7IYY9PRqUtbLI92bLMWWja74NGFhq3
 HvzB5aawW+ZF4zWylhNIKwSyfW9LLQhNT6qL3yk87J+dgKa4Vcr+t4rLy5Ud7duwW/LmmxG3fiX
 9/JDI8/dMPvZW8/sFM+5Wk02ZP7kMnX842VFBqNXitskJ7fZ9pQ19bvk/sMt7fJf/eT2zSVue4m
 HY5cprcDMPkome7hf7Z6eh2f8ti3pZ3v2qy0M+PiyQFz6VOTRIzl9R9ZPjXKq/XmLNXvDU24uof
 EW3z0zrJC8pyX4cl6VYwW6oLeu/516RY6S8eUbkmLXshAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: L05cp_wKJjFNwTXGHAg1kwZs6PU5trWm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX8jPogGQ1B/Rv
 6r9+KdTwMvdh7oSQczgzULFCyaGZVAAGNC9LZhM8vviFEC7y+IQrTiF9rm7Tvy/tTWeEsctMdEy
 Gm8B6kMNGCcBW3rmxs8izHvZ3BrLdSldQ4afJVazZMb1gExFsJOVbJ1Z+ie9tEwB3/RxC8+z8XE
 8H9Cgwqz4skruENF58Lo1VYNhw/4rNQZLWKmz1SgeA2KnSC7C9vnnjfYnEnaUgIp08bzinGlg47
 bL+CPjK85aKbp3VsoIYib+XXbObL9v8CC/QW5Bsx74c26hwyczGzX+D/qUFaSXR8b/iGuLN7aRC
 /OLuHk+MWEVurkBFWgjWDfYZ0MgOO6+dE2OnDOlgEVEyOND2yPqEu/ocmppTTq9OBUyMwSlkdWU
 CNEGwQJKvKOgm7zUf+HTFuPUCt268MjWxhoJR5IlmgAhJwCXlflHzGTAbmoiFklCuWnIDRB3VZq
 jRpXGMSUc+MCRqFQGrw==
X-Proofpoint-GUID: L05cp_wKJjFNwTXGHAg1kwZs6PU5trWm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX6PrjP0waiYAu
 mkgwmZKYjLcj2/f6HHO6jnKmXNceHCaj6tcx8fbI7W07oEXPlOWYAwBqPW8m1xQNNPi8q4o3qM/
 Bw6V7PTNcX6GrwT7iCFeBVBwo55/5Bg=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a606501 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kDeXkUw5qkRwNzW-y3oA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

The HDMI block was never included in the display snapshot, so its
register state is missing when a snapshot is captured for debugging.

Fill in the previously empty HDMI snapshot callback to dump the HDMI core
register block. The size of the block is now obtained via
msm_ioremap_size() at probe time and stored in the hdmi structure. As
with DP, the registers are only accessed while the block is powered on,
to avoid an unclocked access.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 14 +++++++++++++-
 drivers/gpu/drm/msm/hdmi/hdmi.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 350867ada0cf..72ab2e92964e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -17,6 +17,7 @@
 
 #include "msm_kms.h"
 #include "hdmi.h"
+#include "disp/msm_disp_snapshot.h"
 
 void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
 {
@@ -214,6 +215,17 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 static void msm_hdmi_snapshot(struct msm_display *display,
 			      struct msm_disp_state *disp_state)
 {
+	struct hdmi *hdmi = container_of(display, struct hdmi, display);
+
+	/*
+	 * Accessing the HDMI registers requires the clocks to be running,
+	 * which is only guaranteed while the block is powered on.
+	 */
+	if (!hdmi->power_on)
+		return;
+
+	msm_disp_snapshot_add_block(disp_state, hdmi->mmio_size,
+				    hdmi->mmio, "hdmi");
 }
 
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
@@ -310,7 +322,7 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 		hdmi->next_bridge = NULL;
 	}
 
-	hdmi->mmio = msm_ioremap(pdev, "core_physical");
+	hdmi->mmio = msm_ioremap_size(pdev, "core_physical", &hdmi->mmio_size);
 	if (IS_ERR(hdmi->mmio)) {
 		ret = PTR_ERR(hdmi->mmio);
 		goto err_put_bridge;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index f24444610fe1..869f55d4704a 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -48,6 +48,7 @@ struct hdmi {
 	unsigned long pixclock;
 
 	void __iomem *mmio;
+	phys_addr_t mmio_size;
 	void __iomem *qfprom_mmio;
 	phys_addr_t mmio_phy_addr;
 

-- 
2.47.3

