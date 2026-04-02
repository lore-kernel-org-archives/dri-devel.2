Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D1ED39410
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E266A10E4BB;
	Thu,  2 Apr 2026 11:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5r57TnH";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1fs9GBD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AC210E4AB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:54:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632723Hl1424210
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s5/sP5nLpSm
 lFWIWb0dtTmTRZPj9KiV8hkWLXy5fgck=; b=C5r57TnHlVM+6H8LoMR9CbM+65C
 AHhHZ/ssT5/0TnD0jjIwbv2Q/zDnBnZzp6BHTnY0cIrSXFSd+szUycDWqQhoS3cu
 mKfK8MvyDKLo8yymF0FvPYB19xVqOv12no21LU0XZgCvwMgDMYU4PEPYvH7/FHq+
 BQtnrUFC0xh165aLr/g9Z8YqmZTmmvQiKEjkBH4nAg9+FK3keUrmynKcvm3eB9qg
 368QmW/aMtARwqQiEnH5cgT/vXQSsAJhitCCOuE6j02MykkRykC1xpbNUmLZIlc3
 Lq7gkzzB6/C4llbtImatV338EStkTuAcUREGdNsG9VzNnSz1tchDNLCBK1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9511cjxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:54:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so1773141cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130882; x=1775735682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5/sP5nLpSmlFWIWb0dtTmTRZPj9KiV8hkWLXy5fgck=;
 b=A1fs9GBDVrGrovt6nVDDhYzNKhNwOnSdKhKAoYEiMD/YLN6nmTatOIsB4YnLbPYxf7
 ApzRvc/SN9e4Q8PoQ7xlZ+bscpy5uffJBmt19v6pHVaRs6PrCyhDK4o4BjnOGigxEs+k
 8PqtAcHmfRBI023wcT5ds5lpv+sYYfcY99lEEMjaZWG7+tI9bPepRlliJrMANL/QIxSv
 LtzkEtB7rbhG/1sf2yQI4ZHn1dFpeFHrBkAFRmByftXkN9tBGYBoPw244oM8MuPgS9zG
 IrlE9Y8t8iSjtRAcz//vdG0mqeM2lAp32l+xYkBQ8sOuTdiS3kqiHBSoC9WWLevwENv+
 3JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130882; x=1775735682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s5/sP5nLpSmlFWIWb0dtTmTRZPj9KiV8hkWLXy5fgck=;
 b=rcrTuclb9YZ81sI68JIsHCR7Bv8JcCrGLS+DJ4V+VNEqWjr6j5nZwlrwNBm0gvq2D1
 RVS+QIP4HX8lCkhXhHY4Tc7Q8mk2H4DUTnMfunaJp9NV6/wwvCdyXulRWWceTCpOWGPL
 NrtoHWReeY4Ccy0iyzlgXN6gjznVpG0oB2h/wLsXntWPIyOcPkoK7BAme3fQxEMftwj+
 HtLMaKe8BQvX8ktvoSKlKQwspl9bcwb+XxpoFRezkIsbkohksq7JZ3FwULdMGyhFl+Dn
 0IZXbJPY3n8R4pN4k/AkjYOwuqdzI9ehJDLeaKOjJrBJa1uhEVrgIIY6AFoZBVWSbe9r
 vbZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQnyPTnYPXhL+xH/0EDk1WJn2SVnuwulGUirVzr/ltq7ZqRM10PCjXyUeWyLRy4sB3xNOhy1OlIW4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvTMeuUSL7ASW9+S+wQoy3DE+DzdFX6vGnvyOzTIf+G6H5Dowx
 HTKNSGE1FDamhJjMyRnYbR/La/rvctX18ZQFqNCTc0eTItEihK82GYltjjmyJ6Xy4AVMVqR95Rq
 hfveOMNMQofb2MZlykJHYvCXyH74uPsdrsdbrzuvwLRUXPMQFICOf8RAAxUu7/iELe+W2JbU=
X-Gm-Gg: ATEYQzww0ntVd7LZojeeopk+O72YmqjNORDtkwvOz7M9/2zBpLv+TCi5PY8c15YPVAP
 l7HsVoOYUPrN1iPC2DDU3/wKi9FeUTn6ybNL7AxKlKVdrQJEuQeAHHb6OMZ4aoKFRKivc0XV8T3
 IiO6+J1dXH0iKNlzyhDfs2NpGfUalXzQ9Bd77gk1YhuJAucJKX/jevq4VYm8cPSYZRF5njX52I4
 mJLxsYamTOEcKb86bg3UKxjpKdMd6ys+WXLoI+DqAyHErmh05pe8P6mFKtBgZ+EAJXJOsfUNB6u
 udH/DTV4NQSonGQ94oBwLBvmqEOQopydbgrOGOUjgixOkBD1YL0q/RPk1fDTVfgpjGlomqLwhGp
 /7Ox+53qPtvpQDaHzwWgktI8LDo+I73thUeq8
X-Received: by 2002:a05:622a:1243:b0:50b:4e60:93b7 with SMTP id
 d75a77b69052e-50d3bcd3797mr93570641cf.43.1775130881963; 
 Thu, 02 Apr 2026 04:54:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1243:b0:50b:4e60:93b7 with SMTP id
 d75a77b69052e-50d3bcd3797mr93570291cf.43.1775130881452; 
 Thu, 02 Apr 2026 04:54:41 -0700 (PDT)
Received: from quoll ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bc9dcsm111501545e9.6.2026.04.02.04.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:54:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 8/7] dt-bindings: display/msm: qcom,
 eliza-mdss: Correct DPU and DP ranges in example
Date: Thu,  2 Apr 2026 13:54:30 +0200
Message-ID: <20260402115429.100365-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=NEf+HxWDRsWfK9c9KQZCsERDb83KXrF9wLodgfVBeN4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlj1/WZN9obM8xHyJscHB07EsJnP15xwOD5rG
 p3ZNsns+u6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5Y9QAKCRDBN2bmhouD
 1wqZD/0QEB7FL+7msgmMtu27RNQw9D6QuBXN9x+EJBNV03f7D5y1Z00sDOmh7kILklCpfIVrjfU
 yNiFSJc0ULwCFZuK/cKq3ob8ElN6/8nKKgQyT99wvE4fvrvwOrer8dYtV3MEHnMQuKbYUYLIQJo
 ragbbWnUV9tKf86DGBAmbWQZfMljbKQVihuZFSkVwNhlbizLWrYloBiX+hXUqY+ESTBR+qaSHpP
 zACGMaoXk0xngVpLMCclRZpVLMwVPSVGjol7PGrB+uJwIS/U2Q32n1f8W1le4nmYb/rkDfbQ7hu
 6R988SxfsMI3m2LdUvM+AF0jm0DAUJQ87F+AfIb3nWffTkdmlad7sVQG/incSvU+xyHug4m9ooR
 JVe16dspxQ7dkIWlFJ1szkXbfYBO4EF7UAkC4boCM/mhfYv70tEBPS8ySjTQtTCfl1z8Etdh3aN
 IbdfG1tTGEdbhy3pXAlw2S9PFMfoDd83kgKk41P4iojiDO5go/K/5l+pz64LwD+WamihC53ZwuN
 8FTVgYbIQEtvwEz04hL00mTaC3U84KpSPU43hCYkPNQJgJcUlw7nu8y9PtU3QE1RWe+/Z/WdeBo
 irl4Kr4nf1t/9/05RYfOHkJuv3rYKKsYO2HQB0wWQxrEDnlKzXx2Lh33A95iwifS3sWaDBi0zOB
 hM/rFqfnW9ogUWQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNiBTYWx0ZWRfX83n/12oIe4f0
 PQheVMrWXPRXY0A4UbFrWWyeHnbN9RDIQWHG3Msb5L27NfB7rujOMw3fxeCMCN91q3Jf/QrH+eF
 HLWYGkeW5C0QL2GIpPhbGTU28Bgt1AyEEDQwYAsXRNeWEKSyr4m9FSyBJN7PWt9iJYemXR70q1o
 jGZVM9fJnARgTnLcn9UtjGH1EcIuZZW3ysJupxe+4AvhfHuRNw0jtqoJqrreTvC0oAPi0XBV5VU
 fgt8fjLbgBFlQPh8QP9ujTFnpbs9DDAfv2EbD3WuOrFxozHyp15MCI0Y1L8c0KfsmLDt+X1fatI
 3FQQpRw4jtSRN/HV9vVPX8B94Q9YzZhY6eqt3jgGLatMvcqgPNfTGph4gGK+Hj6FuUKe2PgqEv1
 PW0nf1//5zFDQs8ZW1EFjYPEI6q8JYxoa0gr1NdEwYDcmvQ/xhXSPb9aZ7WEGwBqOg9Ra72jxTD
 87RCdayKp6oMq7wNHHw==
X-Proofpoint-GUID: pVIl40Vnb-oVDNHu1TzpTiOM2yp5FaxD
X-Proofpoint-ORIG-GUID: pVIl40Vnb-oVDNHu1TzpTiOM2yp5FaxD
X-Authority-Analysis: v=2.4 cv=F8pat6hN c=1 sm=1 tr=0 ts=69ce5902 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=2E8fMljBJZ0eQ63lGZAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020106
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

VBIF register range is 0x3000 long.  DisplayPort block has few too short
ranges and misses four more address spaces.  Similarly first part of DSI
space should be 0x300 long.

No practical impact, except when existing code is being re-used in new
contributions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

I forgot about this one, so patch numbering is a bit odd 8/7 :)

 .../bindings/display/msm/qcom,eliza-mdss.yaml | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
index 47938d13d1ca..bd4ba91a171f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
@@ -119,7 +119,7 @@ examples:
         mdss_mdp: display-controller@ae01000 {
             compatible = "qcom,eliza-dpu";
             reg = <0x0ae01000 0x93000>,
-                  <0x0aeb0000 0x2008>;
+                  <0x0aeb0000 0x3000>;
             reg-names = "mdp",
                         "vbif";
 
@@ -304,7 +304,7 @@ examples:
         mdss_dsi0_phy: phy@ae95000 {
             compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
             reg = <0x0ae95000 0x200>,
-                  <0x0ae95200 0x280>,
+                  <0x0ae95200 0x300>,
                   <0x0ae95500 0x400>;
             reg-names = "dsi_phy",
                         "dsi_phy_lane",
@@ -388,7 +388,7 @@ examples:
         mdss_dsi1_phy: phy@ae97000 {
             compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
             reg = <0x0ae97000 0x200>,
-                  <0x0ae97200 0x280>,
+                  <0x0ae97200 0x300>,
                   <0x0ae97500 0x400>;
             reg-names = "dsi_phy",
                         "dsi_phy_lane",
@@ -407,11 +407,15 @@ examples:
 
         displayport-controller@af54000 {
             compatible = "qcom,eliza-dp", "qcom,sm8650-dp";
-            reg = <0xaf54000 0x104>,
-                  <0xaf54200 0xc0>,
-                  <0xaf55000 0x770>,
-                  <0xaf56000 0x9c>,
-                  <0xaf57000 0x9c>;
+            reg = <0x0af54000 0x200>,
+                  <0x0af54200 0x200>,
+                  <0x0af55000 0xc00>,
+                  <0x0af56000 0x400>,
+                  <0x0af57000 0x400>,
+                  <0x0af58000 0x400>,
+                  <0x0af59000 0x400>,
+                  <0x0af5a000 0x600>,
+                  <0x0af5b000 0x600>;
 
             interrupts-extended = <&mdss 12>;
 
-- 
2.51.0

