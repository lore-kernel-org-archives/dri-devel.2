Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A15C10D14B0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFF210E7AC;
	Mon, 30 Mar 2026 13:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lriG9LOj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJCQsKFI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C4510E7A7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UBZYNS4013479
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q0lmJHLyCa2gJV6punxS+PEpzIl5sA/7C1F38pdskqA=; b=lriG9LOj2pSHjjLS
 oR+ZkH32xd2+mtNd/87Ke7f6fOPESWEsSLkGwx6PrrKdUsboa/Wsio3+R6PvfxMt
 EFwkYqCrnesqLKMuIXT2Xsyg2CU91NYXY1Y58zGcR0ir2/OFHK66s62QKYKfzmwF
 zL9W69WiU7LFa52JVg8dXYY5Blf+mAdSSCTNSA5481GsFwILPzJvgYkTc8iuBiJb
 Hcd8kilW7O7ZYF/Dyfz2lzDv+ma0xFBlxdW601j/yh9JwombQgWNpG31bAkTrZOB
 KAW4JXSb1OvPNwOERWJz5N+ZwFZBcM+/EijTEtBVDDsR+l+KB7E97GqZHodmhFk5
 nzIM6w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regre73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:26:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-509219f94b0so11211831cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774877161; x=1775481961;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q0lmJHLyCa2gJV6punxS+PEpzIl5sA/7C1F38pdskqA=;
 b=IJCQsKFIcpkGE6AoFGeanDOrTTQQA40hUdgcgl2BNvMNtPwCVVvYu14e9Kb1ZMWUl5
 t0C1M2tJnXGzPpU+qEKJYlN4X8f6BWod1vKMM9A+N6PnUjnWPcXPp5KG53nCgi+A0v5v
 ijz3+CJwci3LlcoTmY5qEUezSTQudztcABPgvQLoKTsYwYYi0galO3fxdmKDcuyMwV78
 f+G+ugh1RDbClJItskoARt7dgJxsl2LQcNfBWsdzDCdXmeBZSDBSzkoTqcus0D0VWc2J
 mNdebSlyLv6IcAMP7ARTi75aVWZ0gxoKtUZAkazFXGaRpM8Hk3K6Xd6G3/I1/aZATENz
 Ygew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877161; x=1775481961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q0lmJHLyCa2gJV6punxS+PEpzIl5sA/7C1F38pdskqA=;
 b=I+3wdE7KsNS+JRACiCUaiaFpBBS6XFalIgPWVfRTLkjCN5pmDO60RXA8WtqOV6B1B/
 cHYS85u8rRWBxHx1BZjXQCvTQA3yOqKt0ZzkpZ0UkZSfJgYWW0hBCyz7wTQVSJw6ZFRg
 23G3KX/O73OH7YTHoJaiRo07JPrKH5M8ACSCcCUqdnTvA33lx6VjmkovxKsiBT16hRTf
 vmEkwjApUWvD0W/Swv/+s/Rv5z4YkYMA97d4fRZsWVBoVlj8aKmMlnL5E3l4iSvF8mwx
 nW9/DRJdP/sRebRUqIefk4V7r9zGepyIx0BkLmkyiQ+1k2E+WkSDGj7I4ZU2UZlmZyvp
 nFWg==
X-Gm-Message-State: AOJu0YxwRizdLpujqWtYerzk64QEVwryscKV4363mqXMOclmHoZtDC4d
 PooaCboBeCaM6H9CoQoo3WXTsK0YdXgIzVMjivmLzjVotbPvgYlrWVuaZvlsHx6fY9zILRdQQDe
 iGw2DbYYkL6t/ZDha0H5+7yhdI+VLwBm2RXa3K/VTLJzeYKGIKYEXWXm4HAvAWm45OB0EGouliE
 KNzX4=
X-Gm-Gg: ATEYQzxvrUM/YVX1WmrGxL8QQJOOE7QeikujsL2250tpGBSezW4M0K+lHUNEFfkS7oy
 qxGwyya82Y+u4aeEL0EV8FYhqZawvZg5OzE6filhZ2CF9leCs9mPSABMBsbIw600PPqUmiziLrn
 mUArGjPOPjBptUcekRPm9zl8oWOo2VfqJqrIVdH63DA+/o4q3uWf2XWTUUMKpS+fGy8NKvuz8mw
 89jVHCNpV6JQT22H/9nbfjWXJ3XMqnvK/LrBJl1zlTOGRwByE1bk7rBo1rxm3Dr8V+y/37eSQ2H
 y1VEgdS+xcmWjZGdFMOjeuIvIM03Ri7o/hiWmpUYdmrmzyEYR97yAcScmnmBZ+ELacuvlIjf7bP
 yqifW78YrAT2HLdJ0KS/U6d5bJy7NWiRTJkEFPDhFAc+Ni2cQYM1xqXP5/Qub0z0xRSQ29dV2ak
 KuhemUrscMSGkZK091pbf3Q3uWOTmRcWwxhI0=
X-Received: by 2002:a05:622a:7c8b:b0:50d:2828:1a98 with SMTP id
 d75a77b69052e-50d28283268mr5460511cf.0.1774877161363; 
 Mon, 30 Mar 2026 06:26:01 -0700 (PDT)
X-Received: by 2002:a05:622a:7c8b:b0:50d:2828:1a98 with SMTP id
 d75a77b69052e-50d28283268mr5460091cf.0.1774877160845; 
 Mon, 30 Mar 2026 06:26:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd035sm1698928e87.18.2026.03.30.06.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:25:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 16:25:52 +0300
Subject: [PATCH 3/4] dt-bindings: display: panel: add Waveshare LCD panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ws-lcd-v1-3-309834a435c0@oss.qualcomm.com>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
In-Reply-To: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=t7oE/LGtGM9qY3XFIxd2mxPEpMiWlH0VxyF/hJPnMIc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpynnhG/fUKFsTXCxI/uYzrhnAcFTn1guihhEuN
 vm4wNy2rruJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacp54QAKCRCLPIo+Aiko
 1fz8B/wPUb9mHiKuVWEnm0YCxclyhve3NULVUNG7gTr2MpnLa26VaOdTnPLD44BYJTocDThmt2R
 QtgAVanyYNaJztf9Jwa2jxKaX12/UkgYjNJPWetk+SIRwPAoeOyWm9lFOBrLmPRDOZYSiUg8bo+
 uN+ROhs1LLRtRIMCzliEv0fjQkiygykoBeGsDaGig6RFXd5jtGm6AnA/BBsnESRgGhDA3PzeedC
 2Gt0WQTHcv6tVaxNwJxmfzUUr/1BYrwppetZQ9JWfFMZB85WpQST95k29a6bZlOIl26nN+fKfVk
 7uRJ1n64MsSr9WFhiFQu2/egH3oDqri2D1anBCH9mgToUtSk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69ca79ea cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ovjr5O5YrjmXieTAoP0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNSBTYWx0ZWRfXw7yGkHw3Orf8
 JMc9QHkTGxkIkMI20N3Ab84M0r8iqy7mcbUFvsiVB0gkysvqhM9CcSXUCrjsxR8NUsac27tUQj7
 429JUbLFxYbtpVu/H9skdLKsAkI9rD9Vvb6smRWFMJYAHLrMn6d0B3C/o3f7Zneu+mTb8qkpvZJ
 1T322HFpFHYAh29M4GvcNtSh69oqlwWMJCT11QpoiGS9l5IQo4Uh/ydY0aMx6tsxH8kbIF4ISex
 ApFXVZAmeGV6T4IUpoMAswlyPE7J8oOKAmXgZF9mVZOk5jf84nccIk3nKipiuNEedVtH1H6k2Bl
 bUCESpmrQMVeR+cA4bDUUuvrJfiqYzy0KHs3sW7KOemW88f+vRFUjL+cKqGA8cPzS2NqynHlMI+
 twlYmq4od2/ZfzFQzL8mKhXBXhx7nnp6gbU30gJYyAPJcvSrbdHZzJxQKMnD3QThgXISf6GCri+
 OnHp6oa8/Y576wgl1xA==
X-Proofpoint-ORIG-GUID: Yu3bNVz1mgRN0p2HNm8aPw4MjoDj7yHp
X-Proofpoint-GUID: Yu3bNVz1mgRN0p2HNm8aPw4MjoDj7yHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300105
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

Waveshare has a family of LVDS / DPI panels bundled with the DSI2DPI or
DSI2LVDS bridge. The bridge and the rest of the logic are covered by the
waveshare,dsi2dpi compatible. The bindings already include several
entries for the panels from this series (waveshare,13.3inch-panel,
waveshare,7.0inch-c-panel). Define compatible strings for the rest of
the panels from that series.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/panel/panel-simple.yaml       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 9b8fa03f7cbc..c9ac59e04118 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -343,10 +343,38 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # Waveshare 10.1" WXGA (1280x800) LCD panel
+      - waveshare,10.1inch-c-panel
+        # Waveshare 11.9" (320x1480) LCD panel
+      - waveshare,11.9inch-panel
         # Waveshare 13.3" FHD (1920x1080) LCD panel
       - waveshare,13.3inch-panel
+        # Waveshare 2.8" VGA (480x640) LCD panel
+      - waveshare,2.8inch-panel
+        # Waveshare 3.4" (800x800) LCD panel
+      - waveshare,3.4inch-c-panel
+        # Waveshare 4.0" WVGA (480x800) LCD panel
+      - waveshare,4.0inch-panel
+        # Waveshare 4.0" (720x720) LCD panel
+      - waveshare,4.0inch-c-panel
+        # Waveshare 5.0" WSVGA (1024x600) LCD panel
+      - waveshare,5.0inch-c-panel
+        # Waveshare 5.0" HD 720p (720x1280) LCD panel
+      - waveshare,5.0inch-d-panel
+        # Waveshare 6.25" (720x1560) LCD panel
+      - waveshare,6.25inch-panel
         # Waveshare 7.0" WSVGA (1024x600) LCD panel
       - waveshare,7.0inch-c-panel
+        # Waveshare 7.0" WXGA (1280x800) LCD panel
+      - waveshare,7.0inch-e-panel
+        # Waveshare 7.0" HD 720p (720x1280) LCD panel
+      - waveshare,7.0inch-h-panel
+        # Waveshare 7.9" (400x1280) LCD panel
+      - waveshare,7.9inch-panel
+        # Waveshare 8.0" WXGA (1280x800) LCD panel
+      - waveshare,8.0inch-c-panel
+        # Waveshare 8.8" (480x1920) LCD panel
+      - waveshare,8.8inch-panel
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
       - winstar,wf35ltiacd
         # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel

-- 
2.47.3

