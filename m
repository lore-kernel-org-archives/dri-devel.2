Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4A110D14B0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C1810E7A7;
	Mon, 30 Mar 2026 13:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="njZ/rAto";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dx3/Y6JL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C008B10E7A7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UD862L364830
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nCwpBauu3iYoI3hicaYioIEnW8HRt8RtZyYBQWtLKM8=; b=njZ/rAtoKtoEmdsd
 lX6WFMhFx0aLY9LJSG3DcrPlo/+uUsTvn1PT50KYM3yLkwl20g7TO51NFXGpwB9F
 r6D//vPAOrAw3zquP0CVDovenWEdGtClQhZxVm+Hs2m9zZAuLEEaJ7CDshzs1Sro
 ysD2IENVPOW9pXBl0+thgswXIktlKkSdCnhMIC4zg5EMkFmC2MDQom/lrQwLpEzp
 KZY6EBzD96QD/tp+Y88MHd4yHE5dWanDbiXtnE4feLemEIQqk9yjBkweW+Ba44hX
 DnjrRu1qj6LjkZiQl7ZceHfMJdbi3alqvtomCjYqVWYxrYhSC7TUWkxvA+lwgESJ
 pNgC2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqem8yy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:25:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4fe4ff7bso182396921cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774877158; x=1775481958;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nCwpBauu3iYoI3hicaYioIEnW8HRt8RtZyYBQWtLKM8=;
 b=dx3/Y6JLXMUeDWu7F+IRLhJM67xDAw7awIGYPEwSFHgJ6jz9Ic8nUDNjo30m7F2gdT
 QJxr8QgeYhy38vIdVZi3WTsLg73pCTvpxqYloNasQHfrKRVqYTZiaIAvrMqwZ63HYqy+
 GoGb7oyhlOaYxg1w47w10NtU1Ov9Y/qmyygl7Wmxfr3zo1aTqbCyokx7QSfB+qnGyLKe
 52hO2PLg0babO3O67zdJHTFmt5hct114zVpQ1JxB0nykhhCaGgn2jVXrXvNpKGoD33Lv
 oXRX/UX8uUZUB3jo1CUPJsH7X9xGZAy8O9Pj31ellN3D7laH/VrnrTBxPzZWsq1YKHXg
 ngag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774877158; x=1775481958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nCwpBauu3iYoI3hicaYioIEnW8HRt8RtZyYBQWtLKM8=;
 b=Ic12tWA5/rFxTzfVmYsWjVXN0X2lz3saoT0Lbke/Wyak3jiDJw8vdbzO+siUPwX6c1
 XxHUu+hpk306QOe2Rg0/RwThnWKropgT0UJSEY+ecwL8qZ7oLcTwPk4Uwm7yGV7oMyC3
 I2t7usORJR4o5ve47Nr1Db0mFD1M4Oj69n0qJEufEMOe56jrdYPeRN7wgzL3lvGXMQ+v
 1uiT4rHRWhFIW/97W+E5T8awcdM4IQsQjF8mWfKWFh0kzhRHHfDvtWq/0+G3ARTzfgcF
 6qkOYp09oKAQ72lE9P+IhbBm0hxKFcserj9Wws74wZZ42DCcblWCP8uhX6sCFpeIqpag
 vjSw==
X-Gm-Message-State: AOJu0Ywrbe/+uMIksr8Isbo5wE7WXuHOXOoMakZXtNDMd12YEdqkJlsj
 F5YKsM9AztyYhhjPHpJsy9E6AAtl6Z1Ix7cJKZcbzFhh9IHXr0z6P5SpFo3FfFTEJc1UUM91mff
 DLJEZIQPSkZUWRAn7JFhA1NSoY4/wr7O5LuN2woBNIjys0d13xX4VobktMJfqdGpH2YQaKmZlXu
 6WBw0=
X-Gm-Gg: ATEYQzxuqtMUByoEgkX7eq3TJVQ1XxMU0MGxAJyvE+fjAUUN+hA8+v9AUGhuFlpoKRZ
 LDSzHzjWV3qNKjO8Sdg0CqU61e/lw5yhrM1H18JNsLi/qiF2Hxk3YxBaKcaTf8LYnBEtk6OADJw
 jwOpIYZQ+GfOLL0hzisBcRoRc2dgrs7t0W11PjbQGb5RovaMM26AbKWbITVZCj6bDTMhzJvOb4u
 vV5PJcw5/GWObt43X9xTBoQ1+IZuqymX+fz+YWvONSvT+8n8slvx81xlBySWiXIyzYRDbdpS1gA
 msYMKgBxPohvRq2cUWVSfplleCQe4Bh2BDZUpOcAsV3YL6mRR6qnlaG1+TbVKAGD6lAyZRJxNPG
 P4tmkP4XfvrdCzqc1nwpQ2DfDWkQXiCqceldUzKIkvUlejmhaPNB/qY6cpG/HE+Uf27za80pBaj
 gKS9fENaArOWJmVN02tqJYzKhtf+3DskyIkxA=
X-Received: by 2002:a05:622a:312:b0:50b:3ef9:7985 with SMTP id
 d75a77b69052e-50b994a4a8dmr180553011cf.26.1774877157491; 
 Mon, 30 Mar 2026 06:25:57 -0700 (PDT)
X-Received: by 2002:a05:622a:312:b0:50b:3ef9:7985 with SMTP id
 d75a77b69052e-50b994a4a8dmr180552391cf.26.1774877156917; 
 Mon, 30 Mar 2026 06:25:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd035sm1698928e87.18.2026.03.30.06.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:25:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 16:25:50 +0300
Subject: [PATCH 1/4] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-ws-lcd-v1-1-309834a435c0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ouDXFaaUjJn1+iIsGngHc0ypDFwzp6Hrso9rgz86XKE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpynnhLg6kfY8szxuKJe4l2Xaet8UnW56+BYex0
 dJGKcTBG/2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacp54QAKCRCLPIo+Aiko
 1cJ4CACNcmBd3PEHCCr/tDaa+U39r/NnefMNdubzsUHVh3fKAWbckV5aPO915redoOYqXqZ0L9g
 LlZX/TsY8BEY+mFsvOfsMqMDek84Ip6kBPvyCZJcYScLgt60iOC/l96n1HdbZzjxOb34VqIey+g
 FndNdvGOJvUzWdkGOVVFKMW/OriuKeiGZFmnyd7KuQOPzQMeqcdEzuN3pE1zRe9rzb1UFWO3H0x
 WBZRfXJbCwKwgVtVZ2p+fkxst5rxe4gSpupEcoZpOqScpajsAkIKnx3iLqPOAIP6I00AIM0cikU
 9HtM/5+VAYBGP5DFZAOF2PIKY+s2Dpe57jIzJmLcyKBjpQ5+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca79e7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7qgZ0iPFU4Zeudp_5JAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: WYO0r4v8j4T3VzejxKtYI3R_arryvdKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNSBTYWx0ZWRfX85dfcOs75NT1
 ADIAXeTe8k5xVk72EqUEiv26byfdxxu7ahiiLSM6dNsWBeXpIqfuVxa51NVHdVJ8edJ8yxFvNJ8
 OtFIrJkTWqLtq5QRBwZnW+ThR7lzs7sgfdENoVd4cXC2dSrUYl/eM4WOibQBoHNRmX29UQITwLI
 tJ6PRcuYBxnmPkaGaUIeaWop0SBdLomMYoLLCXxyVKbH0NaacQr02VMHNaxzqJPwGrcXEFGoZDT
 xw/pcB1yKS/os3NvXcdGt/Z1fFjFKo8OIcVa1R05ohZDL0zNLBBwR1b1jH8e7XockJE884KsJm1
 XWcJxJZP6s18MUBw8UAM3fmIhb8WoDafVfcEhZhgx57B1G85KTzoffLaEMkU/3djQWdOrVRruv6
 VaLvgWrlWSTgAK0c/ySW2R7F1MjBp5hWMx57XNfEyJZz2w0EA3BOwDn4A1I7wb5pOp/wxV9xSfB
 ZgufyVy8/6POeM16oIw==
X-Proofpoint-ORIG-GUID: WYO0r4v8j4T3VzejxKtYI3R_arryvdKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
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

Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
together with the LVDS panels. Define new compatible for the on-kit
bridge setup (it is not defailed and it uses Waveshare prefix since the
rest of the integration details are not known).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
index 3820dd7e11af..0d9372fd2ff9 100644
--- a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
@@ -14,7 +14,9 @@ description:
 
 properties:
   compatible:
-    const: waveshare,dsi2dpi
+    enum:
+      - waveshare,dsi2dpi
+      - waveshare,dsi2lvds
 
   reg:
     maxItems: 1

-- 
2.47.3

