Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567DC624D3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37AD10E536;
	Thu,  3 Sep 2026 03:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S9jOPrTG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyLUbby/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F5F10E536
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:34:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xgnY358247
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 03:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LpLw0Zeq9QHYUh5WFZl+iJsyGiCuxAh1isv86OZyLC8=; b=S9jOPrTG8btAAWgt
 dgvhIo01manQLgAHCuqvidawVFjNmUIgKmpkBfhxkcTq7yWdPUCxfMznsGnFP5VT
 Nrv1IGmfm72Pzz0j+iAs1Vjs00ft4YhZgsexmSZOUmCSW0pomtJNmDb+rkAQQc9N
 ZMxTwkayyV/QpGSoh6tr4gjNfkEeXcpRJ71RXj4RtZILMOjBVoNbHqny6OpM+4tZ
 SJGtMHwrHS0FjgSnCAi+AV8TAR5jyDHWyTzBR1cPLnGJWEPTsQItUnfKNmmlFxRg
 mr1VmEnqiYvGu02jbCcOUcpr9/n4vxq/T+rQVf9AE2etOKrgIEyz4PHzRD+PIagt
 HOrCcA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnk2qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:34:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2dae61cac1dso3457035ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788406479; x=1789011279;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpLw0Zeq9QHYUh5WFZl+iJsyGiCuxAh1isv86OZyLC8=;
 b=GyLUbby/aL6tNhVkn7JmyA13jPUenczKR5IssVyJ6o2UYe6BGKFFGaBqi8NWDidJr3
 hAMDZFOmqAuF6kqcXex9h5AgHVrRcSl3n5AyUrHkCBrRk49XBX6A9yWop1u3TmL4ayTY
 FmGG/ZJbsmDyruNeaYeDv9fqzRQbKeLTOTlUXcvPBcyRyw5fg1AMPUek5Xb3vGlFBfTj
 KLxhCRCfuSg/KFZyDZ8FPfgPpVa5VQKI2N+V1UgKh9fFAFkLYq34p+E/1+rwZZO4wFPl
 +bWJFmi5vJa8cv5xGgqR4c74bsPhG+LI+COt4YHHOddMVMxUyS5GWlqCeou1r7PoLdwE
 KPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406479; x=1789011279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LpLw0Zeq9QHYUh5WFZl+iJsyGiCuxAh1isv86OZyLC8=;
 b=iYK/va5iottex2IBUFTVwumzuIbQmIn0TeigOLb4opHtb52h8ajI//pDXkkJtcEAnH
 JDLRS1DzxrUJrHQvILphPz74PXLrKT4yldqu7sT+PGJBm0YEftc72+e6bcCTdIVIfL82
 bD5iFVBCx4hGCDNkce6D0X2rbGvTbl1Q1bglkiUx88DAi21cGV7uZQBMkHa/VW0gcktP
 8buSw3wolGm1QWaf/57Hre/WE8E1ZIrAfALFAG7ibBeNZ5UgjqMup9j8VLCKhBYK/uI6
 mc1DvdYjomU/c+O/4ThMhadkkP1ngII1kARFH7/alFmUVFR7SZ7ITROWIbqPG5VhkQ/Q
 2ArA==
X-Gm-Message-State: AFuF++m4V73Y2JbmnIJPTWTaQy6FWnjAIcElp8b5oBRPSCrLQ+QLzqAu
 Ta+Q+eiBeHbKDwjl7oMMuQznZZx1CX9/OjUl5IKR9aPXtD9dvP8YZlpRcqbkrzPRoJ5F3J+0xz5
 U4q+WlBcvFRe45uDI0rQnEu3n5bXM8b6bEPrXz2hGF1ZSllXBQ1rX4kR6Es1Zo3BTbVewBTwEnY
 1iZkk=
X-Gm-Gg: AYBFou0SR8JG76cX0+XlfY5UwSYn1hx3V/oKqzs49wfWpJilYpNrBUcytJAJjA/05DY
 xi1bBlyCjunkILjjNrdl+HsE7ZbyNL7a3UV0L3mZocmtn0QOjvg9tZ2EZ40xZX7FmVpln1fpCoX
 U1sC2zGHpmR7qW22SQH2Psjlhzdyzubw5GB/CGN5M43uF21LQPXyxxEI3VzQwRxs4GXT9orpcm3
 FUoF21I03L6K4wqNrDQwFQxkxHAfuWQb8CH/4mYrXJrHlIrrpLa0y/Pv8OQWgQH/udgiNmDyZf2
 oL2NS/E1kWszICYBrmMb6Y0XdkLeEGKTraw4ynBiQL3DFVi+00yOXNyG+92r20vpuIrq/WJIMtd
 UW5NTGWn/aD3Pk7+HOlifQx01vP7vlnpzy0WT32yCs85v2bsk5ZsgGj5/Pe/BF4rbyXAcFovuqP
 Xp4IoTcOeWM4ImO9S5dazt
X-Received: by 2002:a17:90b:4c05:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39aedc2cf4fmr8675686a91.0.1788406478610; 
 Wed, 02 Sep 2026 20:34:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39aedc2cf4fmr8675656a91.0.1788406478217; 
 Wed, 02 Sep 2026 20:34:38 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33253672941sm2375624eec.3.2026.09.02.20.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:34:37 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:04:17 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: simple: Add boe,dv215fhm-r01
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-lvds-panel-doc-v4-1-861738a0d5de@oss.qualcomm.com>
References: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
In-Reply-To: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788406464; l=1266;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=aIoghjXx6AVRZdTStyBOvDyftPf8mmSjjyNh+gwUU94=;
 b=GdA0yOy9sZkqisuLMxVOuPRs6wPmQZKY8asVdqr22N2zcboT7iHqBiojcfFNsdkg1N2SoeM1Y
 K82GwYW0ilfBBE9i9anGR8wj9A5GWHiIW2bDqH7H0cL28eH6M9pPU4c
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: goXh2yU9fy4ShdM9XjhDeRAG8SSLAd_9
X-Proofpoint-ORIG-GUID: goXh2yU9fy4ShdM9XjhDeRAG8SSLAd_9
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a98eacf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=fMfOcokNL7symIEKlBMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX2a1j2Ply855f
 8cy7BoJWUS27ulgQ20xJP1puPAQk/KuBCETaKv/gb74fmVQ8gIwuTELbX9DpgV72X+U5u+G1a93
 Zb76gCWks2bm3gXm04rPG3NtNy7/mmYOkul3EZ0jF5l11CN5njIn6AJLPDoBzZp9/9lhYX6+NJi
 MgfT5lxKrypGp4o0tU8+GVk19pWC5dDh/hxIZ5wKhtCLFxX+Zkj5a7uvCFDFmqFxEtAzHkl8aCp
 uZ7i37MLPD3JhIJbfI416O7ZvA7+P9kkpE3I0kI8kyxBYCCPUQ3kbNeGyCkc7H3a9MBAMz60bkT
 PLFc/OxC6xcUyd1KJ0k1GF+O8N6ftXFCZbblyJ+3Q/nEC7JT0H9ztZNW9ps88UxEsQQ9CPxsUYe
 hyZF0okjmDNVu3eExGkC7Bbir9JccxYcoDEM3TOmlw60YBnzl+RewEeNa5MaJJfhu184NtUv1uO
 XNqEEow48l8VRfNWC8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfXxh7r/fjx/KE0
 P+78+bJNls4tZRTRdtmB/RR843e/mcxVyTFdZGQCJUSt3BjvznuKubD2sWykQm4jRv0w7f5MayU
 MdIFRb1NKEdb3L/1b1svL0Cq55LMoJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030027
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

Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
compatible string to the panel-simple-lvds-dual-ports binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
index 8a2f6feafd37..68beb476fb48 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
@@ -44,6 +44,8 @@ properties:
       - auo,t215hvn01
         # BOE AV123Z7M-N17 12.3" (1920x720) LVDS TFT LCD panel
       - boe,av123z7m-n17
+        # BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
+      - boe,dv215fhm-r01
         # InnoLux 15.6" FHD (1920x1080) TFT LCD panel
       - innolux,g156hce-l01
         # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel

-- 
2.34.1

