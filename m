Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42408CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDB910E408;
	Thu,  4 Jun 2026 08:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERoNTu5L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Spp+7nkf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C94110E412
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:08:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543b0lr3233931
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 08:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Bak3RMKRzTj9voPp4pKGVaY2AZdnbVcrr/s+bfnjyM=; b=ERoNTu5LcAXuWGaQ
 z/dBc7EUqRw7qXb93tbnoeymbVDD+njvEeb4S5IKvaQ+b+SLZ3Jnx1Vz1belDaqy
 wLQzWYGBUxs4XZbqkbHxW4cuZFDIrtFR0rYLpOvwjw9T76w1AUjFqyUoI/0ffnTz
 DybwXA5wNw7KfMoY1M80+LK5zTgeXfdOo9b3Vsuh7VJnqs6RBGH0oU/jqZ+idZR4
 04NPkQRJxKx5cCxp3KzaEmjzXl3NCyEb9pOWkPyohFmvAyBZp2Ol8aMTYRbutc8B
 gdlWQUp8+ZiH/yUTYlOJpVhomBET+MS0bS0dTA6VXHVN4w4RV4134D6Es0ngt0Ma
 yGqYqw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s2p17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 08:08:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91550f68e7cso11718785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780560483; x=1781165283;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Bak3RMKRzTj9voPp4pKGVaY2AZdnbVcrr/s+bfnjyM=;
 b=Spp+7nkf2Ms9ioR5RjRLUIqqSem2LaTnWoN7KJU3I8eAnwwJZgJvt8fXRqmAhDvb3R
 qm/KiZBGvnKOq78TbVMk0qOvjAIzFtXSnBmPZezHUOpu8QHvCoGQloa3iTMSi9HUgeh6
 XH7XumiO9pQN8uoLlqJMUYmZOAX55WwDAp7Easw1Vp0MzuKihNTd5lstdopdcQAyzQMk
 9w7gz+8e0+BkVVE37DBdZmS3l2daKDGHyKPIMVvMRYPwlQyB7tEcwJvJ/A+P9eDGYLpt
 ydTdrDgNeoJmCk4MOdOMJQQVTTbKaHDcdyIrquFaq47Vg7h3DWB/eG1mT9fxCnJgfEtG
 GNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780560483; x=1781165283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Bak3RMKRzTj9voPp4pKGVaY2AZdnbVcrr/s+bfnjyM=;
 b=EbEiEXp6PlwabArhyiy9qpr8LXy8YcNb0vIAfOBDgoh2tLaa/Cfyae+QMUeAujpvnU
 VbEPV/cPnsrgrOsHIojdt4u2hPXRrFZ0L1cC6Yp0rjzfEw/FNBOP5+yiIkx/V492/3mr
 W2CNQkfzJK6655pYxvsI8N7NRu8SF1I6Xm5F9eVyB2/ip2pZ7jLlZLWcayjdAbceC1OV
 HnaBDm8kGd6ED24ry774+1+3XBOIzCi6yMf4B9eFdQDtwbKbNNxSbiYlSppVjzQQwlyp
 y6heA0Fz+BG6jqBjYj+Cxh0yGw7tw7T4LTmJ1ccpEIVWVpCFRj5rMa/+kqvUrZsozRAo
 zzuw==
X-Gm-Message-State: AOJu0Yz9soKa8I1yGk/dzmKIbY6AmcHjBG8SWfspjJj52V77MzoFNztD
 GVvMvZBbuwwSujMdQ0el+ksGVrSn342vvWPiARXuFSQbIfYWEuSOnxT3tHS822Nb8Xe/oYQQ+vR
 kHMFo1xG21QZqDvaHLbEdInKdc7cCjcKFIDdkztOzJXtmqOxTK2odEgluy5PEC2utyH6LhjI=
X-Gm-Gg: Acq92OHiH7zHg+M/i/3+vdfQMd+Y04ks/HjyYaV+PmG9OF0yZMCHIgyKhP8EwD08L6A
 Wtw5HErcu3iHnH8dlbwVbsHVi8BNtH0ntr2BV7or04Ch9n3KabFc/cykNJo8u+2Ftp6rDR2CADP
 Xd/yvvyo58A6whWzNhfIr6RWYQ3SdXWWqB9hc06FF7ywqLna1GoqP2thkAr6rgpyzHLbmJkattu
 fMBupg31L8oMRZ7KPJTSvKWFjT/vFdedWXY2kBW6sCvW87aw39ZXsZONT9N5oLOaNI3qgF3Zmet
 pwok+NmcKaXcsSWgMFpJk1wYIgtbrYVtxpmo5EQYcSslRJecf+gyXIE3X8hFmHPKJUf+CEB4O+i
 wXjg/mQwxQmXqimM3fLdrlDiK6h2hs65nvZiS/VZsZkRSwnvNGT75xnUNeLehu9q55Ccv/4+l18
 Zw8liTHX0W
X-Received: by 2002:a05:620a:4729:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-9159e1a7f22mr134385885a.3.1780560482823; 
 Thu, 04 Jun 2026 01:08:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4729:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-9159e1a7f22mr134384285a.3.1780560482408; 
 Thu, 04 Jun 2026 01:08:02 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com (public.toolboxoffice.it.
 [213.215.163.27]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm272304366b.26.2026.06.04.01.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 01:08:01 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 10:06:55 +0200
Subject: [PATCH 2/4] dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-topic-yoga_submission-v1-2-57c70c23d0d6@oss.qualcomm.com>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
In-Reply-To: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780560429; l=1067;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=ZYq+Pc60R69TOKAA320tMHZs+shxB2cVaC/aoEkJNNk=;
 b=VPdHvg+wneaknitT1z5agc9YR2rykzv00/GbM6pzictaN2OjNy/bpSBXAekG5Km8/6Jqvp2HT
 bOpP6WayS0CD4vU39jUVjJmBd0KgZhH876krR1HMRCfa1A99ENtRT0V
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Proofpoint-ORIG-GUID: HUyHEbaMte1GVk7D5dV61FPLYEGt1UNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA3OCBTYWx0ZWRfXwAAzcYcMnY5T
 0XZ4Z/T2+dyEwRsOgBALNZ8t41wPYV5bP935DifXoYSWU4ZfHQvOgdgvxk/irpNF0p75pYAG1PO
 EcufY5UnPBq+8r7QlKB8txmp+Bbha7GpftTl0UVUB+/McPKot8x54aoFkWcdxnjUtly7YurKHwx
 BaRQc3TAm7aiWwi+R4lV2/PD2LJz0nSMShEgKJq1wsjnkE+hK1+9U/l0V2fkSl0eA4iJYGez9TX
 05XRNAfEsBBCedzX82try6vcPAuSPIeaQI4pyUh7d4ngoYtshgOHHLhqj/m6lz/abo5jII403kT
 8N3/qNIOfrAKntViQ/ZewnxW0o6OHdoH8gYhmd5omB58SBpIWubqqa8YsADIrC71qt8wLF3e/RL
 sgLZJ4FKaQ8lW5JGNESfR6f59CrpC7OnjaBhdKJasA+pENMtBMCm4EBrLhSPjQAr2OvEZPwosKX
 cfxseIEJ5QPSYOlZX6Q==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a213263 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8k6WQxmsAAAA:8 a=EUspDBNiAAAA:8 a=4FSBBunRfCg7zhCRoTwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: HUyHEbaMte1GVk7D5dV61FPLYEGt1UNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040078
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

The Yoga Slim 7x Gen11 is a Snapdragon X2 Elite-based 14" laptop from
Lenovo, featuring an OLED touch panel. Add a compatible for it.

According to the spec page [1], there  also exist other variations
(based on the Mahua SoC and/or with a different type of display panel),
but those are to be described separately

[1] https://psref.lenovo.com/Product/Yoga_Slim_7_14Q8Y11?tab=spec
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 50cc18a6ec5eddaf48542b85387c2d430cd4721a..fca3d180489d4cd3eb2726a722f15febe44f03ad 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -68,6 +68,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,yoga-slim7x-gen11
               - qcom,glymur-crd
           - const: qcom,glymur
 

-- 
2.54.0

