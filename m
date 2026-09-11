Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC58C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF7210F01D;
	Fri, 11 Sep 2026 10:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3ZhNICD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPPeg561";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DDE10F00C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kwRL3514011
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t5bFar5H27cJqwd2WNphcoVppq++/ChGc+WspNucP9M=; b=K3ZhNICDVGGt3Ja4
 3PifMTjl3NR1UemPKIR1cwfgJ28JuWrRTLjE7qBPv2d/vZPTtvJI0zXX1MA7gfAR
 HaEXXKvOrNBp/XSKVEiiM0LkNubr2u2YwyZ2kaHDfX9hNvLIR4eij++P2f2e4t4A
 0kWvZ2PAzmO3ipSVHWMZVUGP5zqg9RKNLasi4KIrHCqhdenLcrGX309HBczozJaO
 bROvySyf7VMj9wPFOnbgKgVDKd2Cxtq56PoJbUwdOONC4msWlZpKJct3H9iTBJ6b
 H5Z2wnzqRTnEyIW1BOYuHLRSuggbNjqQI0+yyx4lmpmVgYfmPpYUA008iIGnn/nS
 2AD6uQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd5164e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:30:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93771aa0379so126099685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122610; x=1789727410;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5bFar5H27cJqwd2WNphcoVppq++/ChGc+WspNucP9M=;
 b=BPPeg561+gjnErPiToXLGFAvVRE71Vi/wjOtY2hR8i3xUNSyjLD2mcrTHGjfNrPXCy
 hGaETxPyYthqGUGYPx93VLcbFtztXowt5xbq3EozzIk30CQDRkqDKJ9lWW1PT3w+u8r+
 0iHl3va+hygpWksMoulvrKHf8cg0EYg8uXUtbI0wjewbKANHu9VoEo1X6SjhZMT18ztt
 hae4dEpEXIov3D/uYmkn0ceHPuB5XE9v7yo73fx8WMRlG6HOXI5cWsJ5PZ+rn25epgq4
 jfN4/9BgeWaD1CFgMKLWz+ni6vI7R1KXPWImjSbL57fU0Q1FWlMMy42TzHANbMxEjEAA
 mqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122610; x=1789727410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t5bFar5H27cJqwd2WNphcoVppq++/ChGc+WspNucP9M=;
 b=m2gaIQYObyKqx/SBi5n1Gwa+5S2RyUK0QHWgo4DWfHrKKVQ7PFyR5hbTR+4caw3N8l
 4Wsb+2jyzs0Ca4EPqvlQB1I54cnL84vuVkhRuBqku7ZfDAKBLM7fIFtYbz/O8eWwaIM+
 dvSaULB/7Ll7k1/MNVJherfXVGb41eVMzWRWG7F21SiLzNTJi4jt4QNLCRkZo84dNy5s
 AnVf9uY7JvcT0F16diDIBs73H7cYGaoXevFHPcRYdn8qjfZh0763Yf205rbPY1f7nnFm
 MCnN72R0+FnOAexuBnn+9YDpSp5FJREMqXwmB7Dq8JzF3mhNdP+bpsgipcc3kyBWbZiX
 qI1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYRZ5lIY3ld+G3eanycqneYBvR90+kSgkOBKOiy1DYR7fF9ZmaDAEkYqkpE8czvbCtKAjY+NVPnOU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMFB9tCGq1H8LW/gg/rEZA8Nh2PUkJV+DSWpgQnlF5m6TbDfrU
 LBvLHdNuB91PHJwQIFaprPZHy64GHGGD2EbF8x3yOZj//mnVemWsA9CSY6FKQpG5+Ua8xiI91cJ
 rlOatidS2dAlOL9QVlLLriwj5eF9H2Ba5amiV5AhVMo+kCDW1YUTTaoL0C5jcAwGv5F2Afes=
X-Gm-Gg: AYBFou2SCWg/aD/6IPzxrT28GBdnrh7qqvTZRmzvSyUZWLRmjzbK8VDSusfZAidKgGT
 WUTDZpOhQBWPEinvtwhZTezFIkiunZJF9i4+XH7OhvZsaHZRQq0fJqBMatR96WxTUCcm29NKAIE
 FY8fU2Dz9UkRnmmtIGDlZxDQVOB/W56W8TUHP03vFjboX4aqz6HWpdxYQ2r5aTc963FnFIono/1
 7RuAJtUdoHMTqnLq0yivHi4vOjhtVIp/MOqwHL3AGbcHQOkRgWRkMsVtIdJFGCSCdo71BsJbkt9
 961mQa/OrRmIGNPes77Vitp7kpKC7sMP4EOL/la02rUPOxJO57za5s1Qu2Qf6AXmEyB2xWrIWm4
 25dj/+amct7lU1T7y+8UmGWk=
X-Received: by 2002:a05:620a:288b:b0:939:6de6:9517 with SMTP id
 af79cd13be357-939ea2bf754mr384623385a.46.1789122604982; 
 Fri, 11 Sep 2026 03:30:04 -0700 (PDT)
X-Received: by 2002:a05:620a:288b:b0:939:6de6:9517 with SMTP id
 af79cd13be357-939ea2bf754mr384617385a.46.1789122604515; 
 Fri, 11 Sep 2026 03:30:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:30:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:40 +0200
Subject: [PATCH v4 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-7-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OkF3pqNY5sBAsIguyZS7ydBERaknMe6JM23521127sE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gVrcZu/TMDuP1i7PORWJEkHVwIonipCvxhL
 qXzj3ig7OWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYFQAKCRDBN2bmhouD
 15DsD/oC+uEKgZ7M5J4X4LpAk/JlszlMZ2civ+kPChZIYdG2ZJ9RYC5bHey27wDiMIrv7YSLK38
 u4C9MfRPd9xqE6nuH5qayj/jAjOfUVqttQkyzZFqAVtU0vXFY8DatvN/oYC1OiIga0wRc3yzw8c
 KeypBp3vOhR7QiSQDpqCnEZJE8T/G01setUm1hmNMZoVahF++feF233o4tKWGPqppFdC7vufVEh
 a78a4ytiNRAh3h9FkC7Io3M1FM7gqZfIWykCIW0RrKHkAAZ/+OnsmCGgW+9701J99atgPBwuxPf
 dBEjN8cvEnVghDl5nLpoR+4s9GGS8jYF4BVPpJEBxYRN2F8xAtA4NmwxONUahJLMO2Qggb0d5Ah
 ZZxCRoQ4Oi3uH0FbcViqkHJ7nbLOMPmlvKhgQE5YclDTV4rCfPkpOh7ej3V6LhU0iWtUpGPU57z
 Wh/i3zYgt6HAFC13buF5fu2bK1IeUXsQeX0klMXEbCrYlOQBKmU/r0cQhVDFWmd7r+npJmKii9V
 wcgpfBjCtWr6x2GrRE66WTujzwBUBSnBfxv++aJqeWB81Amu955ZP3lWdkYwRnzLIrmRMGqZBlO
 ljhkeeX+ggqnEyAl7gcZMa+JRgjZJIaJOqb1y6yIZiHHegNp7pYYp9Rp1Pbsd/98Yb24Vo7Ckeh
 NVptqF+TywOqi3w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: aKrc70h3Cd_Sp4rVe4a0a0VeZLYCtqAS
X-Proofpoint-ORIG-GUID: aKrc70h3Cd_Sp4rVe4a0a0VeZLYCtqAS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX3UKiAmjwSx2S
 DTBvAQ1EkissdjQeLp8e0zVD5R0GTF+lVOunvFXLUKYjKKgyPtbghHJSHKWZsN5fmGqhhHn0asW
 KTrKMLImI/AD+6c6FA3zQXp4AxO09Uk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX9kBJJ4AWpHhT
 aFlKk4xlgcU34CMfgjrWJ/IT69HmePRAtUeWD1UpamcEQJRoh0c5gqjnJJGJxxRz7+WoxA2oKVt
 QLA2EpMj4fIQgjgDN6uco7GORULW8VU449zbWvBg3zoQskKxNZ7KMc1oAn+lEbnAS5JlPqdLOIy
 8111AEfCbd/5/ACgHbdZYJzNb5iqdbb9hB+H+wys9HVzsgy7cm4V8TCT592h/wnrJmpS5hsAFlS
 fuzh/FLVJC79iScZJwoI1HOpiGiouvk72vzBCb8N0Rt6KTDviG+3T43eUeXEhJSwxYTg/t4xyi8
 wcdBHr7x8G+Cd6HwPkJjs7YkEfL0zNXSuF6WuZJNpVn6quo5tX0SoVil2oVX6TWlRFmATBbTm0I
 h15wpg7pmYOPJgquNWDSKf1+ikNVnlKyxw16hOwsL7Coyn3sKlBw4gMoM/nf25h+QyZbQkzTwn4
 xVmcUug3OAjm7qVo7Lg==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3d832 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=LSMMCDwwRte7x3nqQVUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146
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

There are no properties in DTS or Linux drivers called
"core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
wanted "-supply" properties instead (which are defined in the top-level
properties of the binding).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/hdmi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
index dfec6c3480f3..02d27ccad024 100644
--- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
@@ -113,7 +113,7 @@ allOf:
             - const: core
             - const: master_iface
             - const: slave_iface
-        core-vcc-supplies: false
+        core-vcc-supply: false
 
   - if:
       properties:
@@ -136,7 +136,7 @@ allOf:
             - const: core
             - const: alt_iface
             - const: extp
-        hdmi-mux-supplies: false
+        hdmi-mux-supply: false
 
   - if:
       properties:

-- 
2.53.0

