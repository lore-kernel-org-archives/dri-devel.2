Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0028DD3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E46D10ED6F;
	Wed,  1 Apr 2026 07:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0dPc8JQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6u+rQQJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378C110ED6F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:48 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316CP0l639236
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TNv+a5JUOkvD13PQtmo1wRsoE/3FPaE2XhBNcETttd4=; b=G0dPc8JQ/45NbXvB
 GoGCDjbCFHHc9lsHFrhnaAAI0TMkLT28BdeC9sndHsG+HSxhrF33RkgMdi4vaOm6
 ROVHMkmiNG4hmP+20mEZHow1vMVwWA8memHpAzni9TInX5v9YnVRBTdetEcKQUXF
 LOkhYCdMmT/ccWBHwmsNst069vd8JnsYyVHrZYwclBt8Ktz7ZzeJzcRbB3erWqgZ
 4mo0oWcrqpzdSnskAVFBnejSI5dkQotrZtGRkgEqJXl9HxEItjEF8KJWyePxxtHD
 7sYeWc4p7L0L8FCR7QoqzTb7CI7mWigrRpV29vDrKgyGnjniSc5acrwhsZUuY9KW
 vzOQjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso197020591cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028407; x=1775633207;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TNv+a5JUOkvD13PQtmo1wRsoE/3FPaE2XhBNcETttd4=;
 b=W6u+rQQJOGjjHNJshBRGe6DDAHzLEfvto4Sl3idfdLLZgUddA2IrCunyYjqyehHPWr
 ybaouql2pl1uf6c4M7WwyqvwSPcsRTurdxaKuvTEVa5BJjFiN0Bh9htaVKEZU4G9QX4d
 rC5KyuitI7zbs+xi64c7Bz7C9BEkosD+Hlcmn3dgNbCQHnnPuSBlbX6m7ErCu+lOxQhS
 epRGvbd658up/qWJDW3ZGP5CMSwvndCbQEgZyjI7AHK73hT8zRz7VRMGJH6N/CEOzQCh
 A0TwR2HH7hW7QRyWjttVqruGuCwsCftp8Rd3cQvESZdG0+oVHfJlxjfNhGZPgRxsw99D
 S2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028407; x=1775633207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TNv+a5JUOkvD13PQtmo1wRsoE/3FPaE2XhBNcETttd4=;
 b=InGtBFwHv7CW7HpYoNNens9ROUojNXL8icwTKCJkSjtjBtacJptvtMJm9T2BBndEWS
 nb9eTkFZdnvmmbCJmhtpZmTNQUu3UHla4c5bfAjPaHjI04cPP67sely0yVYGl7Gd3R1X
 BbgyW/2IL3aBwLqY1/aBZ5x0i3ph2Mnu6m0GuKwfeB766tOAGqcw0oBDcM4OrFiR1y+0
 wmrRGl5iYf4XUSTXC1mo//irpe+yuwTB+9eWrzM5Ga8y5B2IizyU7l+X+4vE6cgxyMBO
 rGAFQ2nG26ayH+Ik9paWg9irGpo5524TqInESrvsH0vgsHYXOfj4W9b+2/1XJYhevF2B
 clfQ==
X-Gm-Message-State: AOJu0YyAJ8dEF4OpfhZk4PxZNbFBnZEOM7Kpcn0LUfEiNQAycw+LUt2U
 cQM8i4ZVjxeW3X3USao1xwoGwWIFwr3suFRkGnnVYIzTBb/RjaIyaKNi7fRHV1h1/+us8OePVM5
 kaYzG7WYzsryFjuVQLQsKDYa6lyrOx2e+CaEabV5UpJqs1Yw9Jl+ybEkWd2/+nnzgjMIj4xs=
X-Gm-Gg: ATEYQzwzBab3GYbrS23/6HTETxDCrM9T897pG74roV64aN4g7a4ej9BYSGk9pH9dPcp
 rlqvydS/Gu/Ff31aLj39P31fdF1TI46Rh3VWdbycLNmYGuMHRxnU4DOd2v1ViCQ6IWyNrMwZKcH
 XPTbBb/VyU2C7DqH8tLlGfcBTx0eeCalC3GfINTgmYOqSMWzgViUmPBuZe1nKElrpAbqAhh+6PL
 lRxiqTxF0v83VZ3/+S0HaV5s7NrokQtKAujTspxpg5Aw/1bAOZ9DWapHwDRPOMLCYi06CljhPT3
 i+dp8CgCy6SgA96ocEEKsIjWeqFvMTJDDzVln9KmLhu+bES20IVqcF1mbdgdPZLmkYXunVFzrVH
 emLiwCpBjzvmL4UztdHvvv/6AezVrgyn4SOM1ggMvMPcRyaatOmUqLSMTAXeIKKb4u92HlS0T3S
 Ugt/2ZpxeF8RCrlNHwlPandaCPlHwygZpei70=
X-Received: by 2002:a05:622a:1190:b0:50b:3895:c22f with SMTP id
 d75a77b69052e-50d3bbe4931mr32293371cf.26.1775028406738; 
 Wed, 01 Apr 2026 00:26:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1190:b0:50b:3895:c22f with SMTP id
 d75a77b69052e-50d3bbe4931mr32293141cf.26.1775028406296; 
 Wed, 01 Apr 2026 00:26:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:22 +0300
Subject: [PATCH 03/19] dt-bindings: display/panel: jadard,jd9365da-h3:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-3-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yhP4V2QbDZyJf1WM2vX7tIqhltacQlU0i2WT1b2Nhzk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMirbFLb6Baak8sFkzHlNdA4IIkaehp7V4znF
 gWdYY8j+seJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1espB/9PREhQL7BJDveKAw5tO27VKyrw5BHFLVpBB4WXTy2SgPayno+Uz6Aqpp/LxuYUg/v45PR
 7zdCuTavjnDDTILojt76Fj7jn9VByeHKOToCqKFB554AwNx5rq+3iG6SKEL4FcImZix4DJTf+lk
 UXwLIME3Zknt8jwiEw6m/ve2pq9UWWfVN10cY3bld9+GT1gfw70avMmCRpbe30qZytYeICB3ED6
 8jSUqaTHBRn+iPFduDiK5b9XpW6+FVcfVSUNiADxOZaZNRJUGxD9bhxxmfdkLruF7REkgTHzN8f
 Xgo3UGueIUwF/HhW3FNu9Jksy7i+9N1mJXi4UtKbnU5f+m70
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX4TkvZC3M8gGk
 HmulTVdjG6x7UtL89YzEoT+6BvCF2j0GJvADx/I4k/dW7FHoTkH44NFPCfjK/0NW/GVi6i8xjTG
 egDgHBm9dMLgqWyI3vWTV//eDSN6fY+MFo2TE2UnBHATVC6MyPIbUS1jNXqkSe/VhFspSOabWh/
 EAEvRR679IlC286Bp2xTdZOuS4yrYM0CdJV+ExLlUxB8rQG6QeabJXEDop24Vz+05dEceVYEAt9
 z8vKkUtS1JCXSyGmdPk7YeoFOBCt0XKz2VY+J5QfJmMscwfLX0Ch5DjOeI7XMdp67qNRssKTnd8
 jMlpksClLY63UNZzSqEbOxSQbAJvC/SkL+YKLmbFiV+N/f+LMIgQWFKPvoIQnRpn+rABMxYYhCz
 DzNDlCeeMavXCJATiBVMRN/ZN0NpAVeMjnFh49L4x04VTr98jX15oEbusH7iDjjwHypeMU7F7cH
 PZi8/FlzmybRwBtSVkw==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8b7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3ozaZGYpt45I3yT0zMEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: aGqHXM514vbBVf8lPL0OveoXdi4QztJB
X-Proofpoint-ORIG-GUID: aGqHXM514vbBVf8lPL0OveoXdi4QztJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

Describe Waveshare DSI panels which use JD9365 as a panel controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index e39efb44ed42..4eae802de9fd 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -24,6 +24,12 @@ properties:
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
           - taiguanck,xti05101-01a
+          - waveshare,3.4-dsi-touch-c
+          - waveshare,4.0-dsi-touch-c
+          - waveshare,8.0-dsi-touch-a
+          - waveshare,9.0-dsi-touch-b
+          - waveshare,10.1-dsi-touch-a
+          - waveshare,10.1-dsi-touch-b
       - const: jadard,jd9365da-h3
 
   reg:

-- 
2.47.3

