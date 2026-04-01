Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E43D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D4810ECB3;
	Wed,  1 Apr 2026 07:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSZQPCB+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mi/j10wY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3068210ECB3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317ErXP4106751
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hjls8RjbbsnzsfTsTlRRKkryE1WArQ13EkY6T6bLBfg=; b=eSZQPCB+ldxbDP8o
 bon6ca95+fJaWT6S75LeONfMaUS+38/IC5ze3W3mhzJ9GDWkeLeYsBl5hD8hcq0V
 jitQPn6EBf3wpXnByrYv0eFjSh7VIHypjQ52f+0bEUIawqNd8l0ckDs1N3/+39UG
 LGXVEWEeoFhQIdK14FfEQL0eB9YuwY2txSAoDhnbrY/ibCB96nBt51w2bdqLib16
 INlAS/SqKjLLCudG9TcI/53yky3+NduDUfDWxFm3IFSFfxTqCwj9vlRy5ACHBi59
 0THuXyWYBMa1/oE9UYjYaGaHtqs+fESxtJvDMVec6KoFmCmiPB8n8Fmdb14B7kQW
 FSvKLg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt901m4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50917996cfaso82315911cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028404; x=1775633204;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hjls8RjbbsnzsfTsTlRRKkryE1WArQ13EkY6T6bLBfg=;
 b=Mi/j10wY+VE/Eq4WgvRvUjUYxwjXwfR6guCTlekcs/ezNJl+idWTgy4u37jXJB55MD
 lXnGq9QBfZUoTnq/ZbdikNOIqh9pV+GqgV1PSi8PzaAZEaH6brs47ctB33F6IkVo8av5
 MOHK/TKi34DRR/D8Mb94xyQOGzVjOIYXV/xkFZX2okjXzoIf026sAU9X2NvaPfErvmM1
 r/JkX/IfSNl6niJPTBI8hVojQksmbWK3pSLeafmP8buM+0Sc3fE3gKWLLAVgxlPy8SoW
 9MXizEY3ONTTjeXCTVMYZFQZyWEbA/dTcHWIoG8D7/CZD1FMQPLNSG94zgMzwaGfoQ5z
 BjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028404; x=1775633204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hjls8RjbbsnzsfTsTlRRKkryE1WArQ13EkY6T6bLBfg=;
 b=PGRgXvs2L4fyFUvMK0sC1uIIo6cCi+qxyYSuMgKj2lTQ8Dtj9eMyyxypT9JRDABuzm
 Qxev5sjV859HUIuRPYbUh6WkRotGq6/A6Mi5gqqX8vRinhM39SZUxQXyjNth6JxeoVDZ
 nk560HnK7bt2I0R7R9MCv2fy1SAUvUDEERRzpHbt25nQvVHCrCWoHiUzS/YKFkl/i4UP
 9Y5On19w2hqio6QNwieT/aFb4/DK3cOKcHUTW71MjM8TLZnVebsHL0TEc8rk4r3ieTcv
 +VxTdWIOxXnix3iYwtErzBtwptG1FyczbQMFcmiSYMdMYmhVyg9Hg+DvtHI5+Y5HmZtW
 gaWw==
X-Gm-Message-State: AOJu0YxxchCj4Hj1YiJGIQ8AFTTeOqYkH20/nPmbUOfPpUtf8MPaskjR
 BqIQAKqI6xTDw8+sVqE/DEQVT1dphAuFfg2d0fqEEqrxHD/3EMDFVnpGht6L3we2PFglMVOJLO5
 yuTh7zNFZecEiwoAghwoOAQa4rkxjKqMeHp/FqH7MbN1cg5kuJU6H5lY+4vix0iEvbv/EVfg=
X-Gm-Gg: ATEYQzyQ6EqsI08SnuvbBfbspTaBoxkBFt0CwuthgdBjaM37ObxVtfp/Z6EdvtaOIDX
 Z2cITKdLphrkNnzgaFp1xMNNu5C2c8FffgaLAWh5i62PyyU1O8PxzRRu32O1Mig7C8bq7mrgVK/
 w/q1zF8pnX66Tf/WDNZS9wXuxc9HHbFSo+ZYlh0ViK0zDvEr0m/oAZANREPdthKcXHxVMIubDLy
 uQTtDFfGqYzKzm1R+nA7IFB1khBmv03tsfY71wbNxZxC0+jWTQA8ymCTQNRTML62fEvSIu1d1TQ
 BvBrH/WoFOJKhU3/KO9qzA60kL93lC8ACcFd6lh/05FNZLnB9JgZ4hbg2VyHGwPf2QlHHZnsypJ
 ulW44N6cdQvecDqAcfsPFjU/xEQWtRXqzha5lfyI6ojFZNY0nPKVOkcp9eOCM3tO2+NOOKFersU
 O6tFNzyY0aXxMN/UF9popIbT3FsdP4gkMk6kg=
X-Received: by 2002:a05:622a:c2:b0:50b:2eef:c8fb with SMTP id
 d75a77b69052e-50d3bcfd9bfmr34828911cf.56.1775028404541; 
 Wed, 01 Apr 2026 00:26:44 -0700 (PDT)
X-Received: by 2002:a05:622a:c2:b0:50b:2eef:c8fb with SMTP id
 d75a77b69052e-50d3bcfd9bfmr34828571cf.56.1775028404106; 
 Wed, 01 Apr 2026 00:26:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:21 +0300
Subject: [PATCH 02/19] dt-bindings: display/panel: himax,hx8394: describe
 Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-2-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cdQkofKqonQVRCR3RPQmg5mh1tVwYR3iPvbv5tdQJRo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMirgQzsB0hpFKG2u7zhkET+Vy0O6KHFG8fbF
 iO7pCCEydSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1edtB/44paXo5P+bFEHj/5QakEC1uvtLwqTP0aX3ugpdP+Xf++7DfgKwkEIGDSKu2w5E/EYi4FG
 1cRLgD0IlDdRln2uLWMGTsJrsc93RvpKKs+0LCD3vbkrWzQ5LhrcRlFuOJNWqM71JtydHKZnZdq
 gUkOBUXePUi25xaSC245oM5BdW09tJnT8YU230/eDG2klTnsm0/s92Al63wQkDCeWErIC1e7+a2
 /+U40yuD08geMdp7QWR2z0vKWl1xYas17bj+RmKvmDOdlwUz6wVgpoqzOzdiU0ZR7GgyCFSX3Bv
 +AZtCruYNJFYFgX7HbvVLMSJGzadtAxfuWPOXWNjaFzbvtTt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: i3Z2MFiHCfH72f27ZqT8erQmYq-uZ-wJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX6sNZQV123C3Y
 eqVDL742m1sVlBJUVbNd/u14D1Z2arhXFbI/0TNeZFIKzBqJpP3GVd20XP6Hc69v+A9eO5YuU3g
 Q3ouRa+7Om/WIlxL4y5q4DP5O7cb1yPuyxhA/5Jfi2e7q0h3EVAflgZBPR/V7TngrFREAHmxb03
 FwPuuDQgu70k5NUwGfKL8pxZN6XL/BDTqcYZkWudujUu1a1VoB/TCAUtPaI+hjnozveomGTKb01
 /zseh8gOqBETSrea78Rnck9UbhO/Wv4vLokAX5TsjlwfBtw36qfO9eH19xRdJ7zAMNoPgqxwPo/
 QNUe0avRzc3WQmyObcrSdu8Ib488T6HcMkQwc5c9wkFMEHJJJe0mQ8O5bjoCMoFbvSjyjbGRdwB
 l13IOEDyH3kx1LtRfEPabsgDXkPnrS0KyqQJH375SM9fNHbSwu2lYYy04mvVA/iqzUG47PlqOmc
 mKAk38GZuWhthzp9N+w==
X-Proofpoint-ORIG-GUID: i3Z2MFiHCfH72f27ZqT8erQmYq-uZ-wJ
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69ccc8b5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0AHfZW8JlnlOAyLNbMwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010064
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

Describe Waveshare 5" and 5" DSI panels which use HX9365-E as a panel
controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 84e840e0224f..83c343b02835 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -23,6 +23,8 @@ properties:
               - hannstar,hsd060bhw4
               - microchip,ac40t08a-mipi-panel
               - powkiddy,x55-panel
+              - waveshare,5.0-dsi-touch-a
+              - waveshare,5.5-dsi-touch-a
           - const: himax,hx8394
       - items:
           - enum:

-- 
2.47.3

