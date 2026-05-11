Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3C7CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD12510E8B7;
	Mon, 11 May 2026 20:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XFcllWUa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gQRZ8kDx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C37110E8B6
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6sIP2804232
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=; b=XFcllWUay+9RdocR
 s0FI4YFR3bEBB2hQrvG5Jqm6twOHRpyg4YmErW6GeLCDH1j0rJsDAMTQ3XBf/Lj8
 CYirf48uZ3If66DyeyHdxAFQZ+U1m98gGpZbbtRm4XCG/Z560bozfPOrV+TMC3mR
 BjNtDWyM8iMlWSpyAY7phB6n3yn+M9BJZlIe40inyUgphNdPVCmog0W/JH/wVFLE
 uih/7WmDa/ixUjc3bvxdiktN/oNYgLYRv3en6VTKJ0C15kHlzbEvbJjhBTyA2jcf
 ULzHtOtcBVliv1VzfzSHGjNRQ+r6pRUQenXuAyymzfmYtdUNwNzHmWIN5Plm1o3Y
 VJOw0g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv3805k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3684cb22502so1734876a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778530058; x=1779134858;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
 b=gQRZ8kDx8BL954v7eJKut4ooDnx9GAV7B3Y7ZSkcfTSlSkhJji5m1ZXyUqTYaBDbEI
 5LA4F4T76U0l9Ni70dIlb4i0HR0B+o/wNW6XR45gJk7EFzh2M7c6fIQVAxkHYUajJYzb
 FWrd+g7xoHBwJSlYMse0MhHgg4Uqw3nOPvur8TcC1meOMeSvVoxTC8KUjiD/LT6+YBqh
 gAwaRo0iy8AMOzf33ags3ugLMkMKKIT2d9Tc/Fe4QVdlpwJh+pznw6Sb3eqIZFngIyK/
 wbiPq9oOxpds/L14eyrCvu6JfvR0ySSwToudc95ss/Di7mOaaI/fgWG2cU9BUoRN+0Oq
 OcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530058; x=1779134858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
 b=Vt04Fr4akm9EFZ7K4O5VmFKVC7kS9VJeS591C7ML11z2TZrGtscIKnNKKRkwiDarPt
 JPgrfsR0XlUbpgZ83S/cjbfZi3MPxR9nXdnEv/OH1md6A89Ub/E+iKALHf/Ce4cBE7Qc
 GY24o3rAs5bgh/F/y/yz7BV152WrPNjejbGkD9eXhY3UQY/wVwZGk+eeYM9sYDVOSQS9
 mLvTSXkmx4D25hRay/y457KTZ/TYW0jCFK2f8OS6sFKhTZR4JE+VI2+Rc87OMai13QxT
 W3WMuySDbOPXbu5PwIuwpKmTKMG7qSPZfWu9alyQqYLhlGVXIRjgbGTi9MUKjwELeGtI
 uHyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ978Z0c42S6O/UgLxFWE0sW4tdEjOuXgMy0KOxpWTsKOoMZAPRdzv35fGYSFB1l3sMtgt8TM0zXAKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFSX5Uj+mj7uKMm7d5iblL815YHoc/XMIXysHETrRmCAnALIil
 2jZci7kfoDUIwcN1e/Su42oPGDlxRcytryZRCzYyEOs12NTVrDt0gBUqExBvncrrpZhqRITtmgI
 OWczwWXeXpRzs1uako34iVC9Ra3FG3az0LGTufKWlf8i0qbO/xJUG19Bcxxv18MqVVV+qqZ4=
X-Gm-Gg: Acq92OHpAZwTLZeo/OPKlydUWbKvRhrP1YgQyjnd7IO614XbcAV9Ra+T6kQqVBeWur/
 kdnrI1pG+PK1Sp1HYC/icO6EmbrpwMYxNy8FIo2gFSfek6deWE5GL0f8262wXxh92XkNxEowAhq
 Ni52mgDZDiS3Sxa3Gccz9QPCDog7nwWEvIQXmIzHxDLzPLiLpcLr2DVS9BmYAKVVJSO8VzyIcd+
 A4GbTlhgO528DtXaSrF0XA9x0gS+B2NCt3Waq1Ie/xV0vzSKquqMQnV3t+I3GbedaecTN/DQx5s
 BdVFILUetSJYcsFZPKQFNvorIb6dmcI5fJ5IfChYWDv8h4km0E4lv04l/oZYCu71+xyijt2KaKf
 Dv+UdZhBeleGMb381XyCJZzfUtviD6BM7Okt/0t8MhTfnTg==
X-Received: by 2002:a17:90b:4c89:b0:366:159a:c1c6 with SMTP id
 98e67ed59e1d1-368b22ac929mr135506a91.2.1778530058225; 
 Mon, 11 May 2026 13:07:38 -0700 (PDT)
X-Received: by 2002:a17:90b:4c89:b0:366:159a:c1c6 with SMTP id
 98e67ed59e1d1-368b22ac929mr135487a91.2.1778530057776; 
 Mon, 11 May 2026 13:07:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b01ef884sm64911a91.5.2026.05.11.13.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:07:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 01:37:00 +0530
Subject: [PATCH v3 2/5] dt-bindings: display/msm: gpu: Document Adreno X2-185
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-glymur-gpu-dt-v3-2-84232dc21c03@oss.qualcomm.com>
References: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
In-Reply-To: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778530037; l=1607;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Mpr6Q33aJKvJH4hPu7N8/Msc5ivh6tKB28dTURNeqko=;
 b=ekTosnc5DQLaWUndNzB/IGlZkotn0XZ9ww9uCjL0bIlNAzL1p1kuTxGJDPkkZ05OtUKen42Yk
 kcGU2RyLwPPCOPKLZaEjrhtLZVKoRDA3OX3zfVRJl2MP8AQe2ZkATu8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIxMyBTYWx0ZWRfX/lxJw36j6wR7
 Mg9QeayuYJNIk2nlUpX8ve3FJ7Mm/OE+8mScJlVAnf2xXn+Pu44+M+T5CETmONaRJxWPb9ECGR7
 zsVbGXHTn26Xk+CgKE7sTCIfxF3SeNFB2hM5NMeOzNRd5ZC4qFK2i0HAOHYYHiJgK8Gv1lviMr3
 m53KC46L8e8WQa0CcePgiSy6wsK/QB7eqgwq0Z7K5uxaSbh8TGKc9FiUY/O+nyvteu3ymlm5eGk
 xHuL0HJjIkiVXsaCvUEgixpPmGrTeDo+78lDHg7/X3xobg0SF1HMURbz2WJIpxARWK+XSUI1dmT
 D82r2oIvP/1+cTDWK2ErnAhM4ZXavhrOARKk1BYE7sjntojmJ84SizAmi44mfOsWgXWJ1TGR1/m
 o9XQ5zHb+rpMKsl+DTj8LKbQWMj81g==
X-Authority-Analysis: v=2.4 cv=Kvp9H2WN c=1 sm=1 tr=0 ts=6a02370b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: rzfADtKJziZXQyymjmKNaMrd2Tov_4G-
X-Proofpoint-GUID: rzfADtKJziZXQyymjmKNaMrd2Tov_4G-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605050000 definitions=main-2605110213
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

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..e67cd708dda2 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -411,6 +411,22 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-44070001
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        reg-names:
+          items:
+            - const: kgsl_3d0_reg_memory
+            - const: cx_mem
+
   - if:
       properties:
         compatible:
@@ -434,6 +450,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

