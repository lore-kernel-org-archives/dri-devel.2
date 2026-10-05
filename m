Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B0CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1607C10E848;
	Mon,  5 Oct 2026 07:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JioyAYkJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhtZ8HaL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2888E10E848
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:24:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xubp291094
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0KMvSzLsthB7rRatilMFr5VvRODHVlblv8W8R1UUWk=; b=JioyAYkJQdu3jO2e
 i3S+TJExvCGVTrWISwvMO8aSYfvJbLzsGS73dADHsghN0AdzYLh8gCZrNb5XprIr
 FfNDI0ZDYDimD9ODAZBczR93hvrx61q40HhudbbWMDzt3VBsjTVTghHB69hRiNpg
 ag9fy41DQIEccS/Y729yG8pv9NDaupgE0C8Hb75svA1O4EmGBgz2PFZoZRxDXC5A
 yl66QHz7jYYglTj7gjNgUf/n/6nx6VueevDTaTQGwJSDT6l9TJEg1mOyBWZC2NUP
 ESauN2L6YU8CWBMoM54PqJ13LC2j5n5NXWvOBXTOKPRlptz+FGwJlGlrBPhdeJrA
 tPWG2Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs13ep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:24:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so2454516a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185086; x=1791789886;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0KMvSzLsthB7rRatilMFr5VvRODHVlblv8W8R1UUWk=;
 b=dhtZ8HaLZ+FM7TppsMtfTepWcGc7kQmA1b3NjC3XSVus5KsgTuNTSscInGtmO5mrAj
 niyM2MmHoxkLu3CwStLlEYWygrXFcdZLf1YszUA0SOGOYwszi6Kou8HKofrTORve3Vkj
 czy1YJi7l61DvSaXtD78/fvJXwBiD/RKQByb4xsIx14PKQbxHOTb8HPje0VdrYVS1r6F
 27vvUrXa7DN2N4Ve4Wx2ZSGPaTfOW0ZMtvgxZZrMkKRkgR2Bvf6xhQvCDlQ1qqNGM+10
 KLFyveQrgsbbQvNOqnGo/pd+OtrMeIB/rkm0Hc0y7gnf3JbYUw15vXdw2wtPzZZPFTu1
 rtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185086; x=1791789886;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V0KMvSzLsthB7rRatilMFr5VvRODHVlblv8W8R1UUWk=;
 b=r2eQJzKh4OT5wCRCW0q8Fw+XaZJBDbocfZmzS/+rhrRVDXcKRaXQjax6z7GVGA+lT7
 nOAXivlrLKPU+s91NWZhojtOmj4L/1OpUpdJP+lw347OeDy3773VCxCORNdeqFXcgJ3V
 aP32QCEyuRVLvfjhSVi5kXXcQb7BukLrWtlgBgFk79jij03TwuEV+4sL+OaIxMYVdLAO
 vxLXA5cRt+eE8DefNAmZ8YaGQNAtlX/q0VwvaelPKCiovSwnpsMxoUX0VZRyWe75Mmtn
 WGXZyfAws+2q6Pastsp7ZLEfDOi0wQZdkDFVOHYrCkJ0b0vgEwImC8ykM5p0JWpQI85w
 FsoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/E4CP8py3B7kZgWSwAbJvt0y0Pp13qdMNLiWxh1OtTPX5EpvfKwyg4pi5Nyia2ZTkWKQKUHHFFGw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIM8xXJsYgAGK24vmMyQaXydErP644pAm7jjUHujxgo4MwI5ycT
 Z99tYMRnDIl7sn+pkTcjZE578BhIPsOmHyAbdeRrN7Syu3WMrKXCUcfCuoqJKGWCejHOTE3bxee
 Tl0lZ59IzJuKpg6FvKDnSQnW+Gs5J8Qc9qBqmi9h1eTp/17kfxUd9cQKLRwga837bg2YJpMwCTi
 83B3s=
X-Gm-Gg: AYBFou0nu1VVG/vhCMqJgw/5ypl18Mi4W+CoV0C4BwJFkooO97vuUlHcqU9ua0OR72S
 L+KItruB0fPHnOxJnEkZ6ZMpFCY+HR0X1PnspiJm70m88q0oRhV6YcXAyILbbszv7EdYj14qP4z
 drjh1o5hanusf1fNN/5uFx27ZiK1Y/BAxxvfPo5hnAfm6zqG4BUFCXmYdTetwarkkpQ/AQVrrPu
 /1vLuHqFP4cUkqucYlHE+VYYLARHT/ROAOzI389vdGBQRYeQUEv0uzMPMJrDqxVg/UHqb9b3trL
 u/D93XNRWH12jSFNBcX3gVM05BiIQDVY/irKFLtZfF77J5j1GUdRzW34VEdeTIJJFZEYv7UErZ5
 1b9mmS8ApacTGcV/Hc3nkt0DGnxU8l1fZZ9g=
X-Received: by 2002:a17:90a:1506:b0:3a7:9adb:2a18 with SMTP id
 98e67ed59e1d1-3a79adb329fmr3032554a91.62.1791185086139; 
 Mon, 05 Oct 2026 00:24:46 -0700 (PDT)
X-Received: by 2002:a17:90a:1506:b0:3a7:9adb:2a18 with SMTP id
 98e67ed59e1d1-3a79adb329fmr3032532a91.62.1791185085659; 
 Mon, 05 Oct 2026 00:24:45 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:24:45 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:54:26 +0530
Subject: [PATCH 1/5] dt-bindings: display/msm: dp-controller: Add Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kaanapali_dp-v1-1-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=1609;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=GzWzFpAa/mVkpqK2itZgfHllvdg0sj9Od9l5xCjY1dQ=;
 b=F0QT1yp2Viq4LAlgWRSHhvhMjTJ+g+n3oKrwjm2SXdjNKzrBNl3f8R+7CveNVgDKY0NfKM5TN
 ay9pTrDY/mWD7mYUoOARSEkseOF2JgxbJ0Q5VwMw7wAMtANqLf8nO1i
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-ORIG-GUID: WlO3lWBJWhj9_xdePSgytlfhaKtmRWhg
X-Proofpoint-GUID: WlO3lWBJWhj9_xdePSgytlfhaKtmRWhg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX9mpHiKbkdVAp
 i61gkNQxAI1oCZS8aFLvdNaMcySmWkelXEtTSIZPa4zi9K7Gs88fy5L2llMBmaKZS212Vzs4AFA
 /z7y5KojkFGmJwzi+m4YIz7ELBlWm+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX9W7lMzbrTNEL
 DCa9rBlyJPe/FoJzl6VstTnJgwmW9iwJHjByPTPbnPDRMGK7yBILCnU7r+YfeXLnsUimRY0ErI3
 qWZMXjIR1UFJRlwGrVardQ738I3JVhgM4kBEu3EO6Ena9Mha3+5DqKQsJ+cvTXkUuCRbNsWXWCe
 3a/V4Umh3xxVOWlYl2efnFASCy1XkgEjR3ArX8HLstE7GxOXewaEXTfRy8OxOfoQ9AFnrElfCwE
 My15AK1/hjFkK75C32FZrOBj7w1AzpggLVPn3P3XC3dsiytMULN3OCmBS9HZgcIle2LDudDm8CI
 5A4cCYETPbn0dAQNiZpXFOhyl9hrLdekBddbix+0imAu4hWuDHQjARL+4havkibKbO3irqmCeIq
 inxcBMqPIglfbHK6FpfDgNg/JPZ2xjcSH83DWe0N4LlXU/8WuxNG+O70kunAs2qzK52y0HVU3jD
 FMHHV5KTrYenOdK2S6A==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac350bf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=H-7iiLwglXPwSBWBkKcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
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

Add DisplayPort controller for Qualcomm Kaanapali SoC which so far looks
fully compatible with earlier SM8650 variant.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml    | 1 +
 .../devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..8bb0f6e15942 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp
+          - qcom,kaanapali-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..83e3596ba0ed 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -48,6 +48,12 @@ patternProperties:
       compatible:
         const: qcom,kaanapali-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,kaanapali-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     additionalProperties: true

-- 
2.34.1

