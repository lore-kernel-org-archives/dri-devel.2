Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3264AC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3DB10E073;
	Sat,  8 Aug 2026 20:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPhDc+ta";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJeTojBO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFD610E073
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:23:39 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678JxPSQ460469
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t3NG/0TSBU0DmDJU75ZDdFzCQshXmBj+SMFGbmVKo7U=; b=JPhDc+taFYk2XWsr
 WuTFFJFZ/Yl39ynf6sdZptUDQhCqnuTzxhmplOksHOP1VCqzMBrpQSPxO5mAsw8c
 gMROHy+q3eUydtAwnqUzTUHtZwsA4gnmcr9naOGcrAEGQdZupbikzTP/08Meiu89
 DpUoXe0KQh/HK20fg1CvNYbmscbB+4E+Iu3E8VeYvRoNHLB+DQbRy1WheZJaL47f
 z6nqBf6bpEtM7mC8+8o4YSXQMOCoo+/rC1XV1bhFmG3aFTvnq0Dq+1LvQQkwmwFL
 urOP68hdur+oaCoPHUl2e27N2YIrKIKcAGBjLj9cpRrjz7UbrWG32WGw+cPO4atp
 Ky30Qg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvu8hmdw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so217624a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220617; x=1786825417;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t3NG/0TSBU0DmDJU75ZDdFzCQshXmBj+SMFGbmVKo7U=;
 b=RJeTojBOl5/ajagxDGbMBJZW0YzLUOmw0FI+cMkyYYTZ/LoK9eCm9/NZg6Lo/pSWgy
 YcW0q/vJAVuXuMOO3mD6RJI8OSFqXnOcLA/SGkpEQo3l8Q7A9bK7N/dYYy1DURxWQbR9
 O76F6cZjrLLKj3Bcp5xsHYDJ+QQdk/QhDR6FEFRQYNIlsi+h4HyyTO+kJSxZjwUrhNI0
 5ukZ6yG6nohw6FeHjg3pt3hXVQIfXf0qVdV9Hv/1ok3YZJLEEK0xVkwS2k3HQUczAw7L
 pbqaQZeizBtnVX5s2+GORAcW9jvJsXeE47E0i7RPVJZOP2EuN30rT5MZJlBk8urs9mxO
 Zvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220617; x=1786825417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t3NG/0TSBU0DmDJU75ZDdFzCQshXmBj+SMFGbmVKo7U=;
 b=DV1fRLDRTsdtFP87dLluOPYFsBwB2088eWlgwdEp6uhby9+pAYLv/6yCKRvVwQUdLN
 hKWNfnzanbb/aP+9/jp3BBu02POB7szvNeU5wHfWmQdTUhJkQ42IvE6hM+8oJ72h97eh
 jXzpRIOixFdBjxPHsOnj25+0nYJRrfLjdNdGVWQ0et3qsofMA9EvFpBr/oJQX0M0w5+u
 K3QWx9/gR65e4lSIjxgV1rErwcEiyL7LE1pZ6vhedsUKdSpDyWNBpkylLPsViT1mEYwZ
 /MfeEe0HSGnypn7iGMhpQk/OyfRwO8I/eFBcG+iSUqiDsLc+BhLKBGSBrfhAh1J1/P/c
 30kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgJ/oPQKR0bEBvivuYHHmL2N8P55eP9xwpC0+u4U/FmCUVy558b75bdSoJkPNvgFh9RDPiSkjfEVE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzCq1ydzqRFO2wMdswkU8ut00wnw+NM5smjD0ieY4IhzsEeqk8
 X04PKZUiv0m0gruQIy/sDBKRvcUqE1+RA0AVWeXavhGfVDfH/0inNMRRZ9+YexGlNtvCoZ+UV4g
 OQZNkiUpOT7xJVK1P6YfyG98t6LmrH85x7mlR5x55UoDFtXeIWvoTzq43ZpD8dKpS2BROHCc=
X-Gm-Gg: AR+sD12nlejvgh4w+Q0xqzBHdFXEKMNJjDstQ+mvn44d0LcLfhXOw0nPvbnK19t0P35
 wZqmlDE15LulPp53obyakDcUE7VoMfFHNKACl7CiVhXIpBOmOUmOK0mPmWW0i9qO7OK0rzSvByr
 2TFfGIiyPzn4sYgtySj3L+DgEzAhawmBzJ6mTG/ZXqCnK/FYLO48pkDpKI+Gb2uOei04pD8P0ID
 Su0hprTK7ULGIT7HexdteSPZxTxzcUBWAA/s36zAbAnga17CGWjYCX3TlD5G1JnxI9kj17y27sx
 PIullqX0/63TGPUft0oltetfV4bHFfZ3xajZUQTurc+7v5Pon29syhnLE/m9nv/QHRS048gjn7n
 GsEi+v8LTAPFGHoib8zcyjuSI
X-Received: by 2002:a17:90b:498b:b0:38e:7268:220d with SMTP id
 98e67ed59e1d1-3903c628176mr35483067a91.20.1786220617452; 
 Sat, 08 Aug 2026 13:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:498b:b0:38e:7268:220d with SMTP id
 98e67ed59e1d1-3903c628176mr35483027a91.20.1786220617000; 
 Sat, 08 Aug 2026 13:23:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:09 +0530
Subject: [PATCH 2/6] dt-bindings: display/msm: Document Adreno 830 GPU/GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-pakala-gpu-v1-2-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=1936;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OsqXLb6DBAwwiK0M3PH5HtArLEFAOG7FO/WRCQ/j990=;
 b=WsOxEWLB8urgkOTr2myVNTvNfCf0TdxIL78Mb5G/oOX6ieWmoeLK0xXvFLwVvI/0aTrQ+4FUK
 BZBIJ/0BwnTAhQcEMpg+qiS6DnogVQGuiExn1U7fuX5UXd3zuHU+VRt
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: p8j62Dy8QvASO5t0lWkyqofc-M7aiLQy
X-Authority-Analysis: v=2.4 cv=M8p97Sws c=1 sm=1 tr=0 ts=6a77904a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kd7_WHXXByo44f3drYgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: p8j62Dy8QvASO5t0lWkyqofc-M7aiLQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX8YG+k7W+kfXL
 0Xo9sDwTgtp+EB0ZMZdKNTNPCUnjQ0u4BwfPfcqVAtKT73SsbFMjx1CF9mTkNjlUbOwvXhFbuk0
 MTYOM6FGLyMO/nLQ6ZBOxLLyFI6Q588tCJ947zp7r1qHfY+Rovqb6pugs3QzGzBzKyULHF2D9Qc
 Axq17qdF+xz3MJ3Hy/3eVhIYIBk8/wvrN53ZFaeMPuxxdv6ajqD9XBJxd5fjs8NUDyushNSDnOl
 cwyovxUDyrrKPxPMdQL7T8GXJVNAs8T+anMihJ0u/YMS2PIDXWRcEnTHkwhLfDZ1qXI++dpV1f0
 szDvNBrB+y+IfgvyfFTaGz9d+aNKZkJgbYxNWbT8diU6g1FhSGiOT5KohSQulFbv+oEjheqUVqy
 NlD0unKgfep2CH66wzIZWaWjQtRgJ9eTmKNU9lFS8aEQ/v9JseeSHWORj02L6hVg6eKVG5RgKWR
 zo0bV7DrEkkhCle5Qow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX5c8sIB3jSRDt
 eyzL0svVwjCk5a6+WAkfRveS/OBt72uHm5azuDui+AfWZqyxx7Kr6+ewg3EawS/87lZsglhy3ND
 yrEEIaFptyamCQJIUgkNO3tKyBjNccc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080176
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Adreno 830 GPU present in SM8750 chipset belongs to the A8x family of
Adreno GPU. It is similar to Adreno 840 GPU with some meaningful
differences like GMEM , register file size etc.

Document Adreno 830 GPU and GMU present in the SM8750 chipset.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 4 +++-
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 9e459f12ce3f..f1e609b7e1c7 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -305,7 +305,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-810.0
+            enum:
+              - qcom,adreno-gmu-810.0
+              - qcom,adreno-gmu-830.1
     then:
       properties:
         reg:
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index e5efe2d35ddc..1c4a6f17c1bf 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -414,6 +414,7 @@ allOf:
           contains:
             enum:
               - qcom,adreno-44010000
+              - qcom,adreno-44050001
               - qcom,adreno-44050a01
               - qcom,adreno-44070001
     then:
@@ -451,6 +452,7 @@ allOf:
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
               - qcom,adreno-44010000
+              - qcom,adreno-44050001
               - qcom,adreno-44050a01
               - qcom,adreno-44070001
 

-- 
2.54.0

