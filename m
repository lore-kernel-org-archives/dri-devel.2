Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E7C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B38F10EACE;
	Mon,  6 Jul 2026 21:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZ8j/Qwk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frKLSu8Q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4008B10EACE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:21 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqiQ1664526
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=; b=FZ8j/Qwk9OdN6zki
 9ictFYTUl26CmsJYocIGqx+ILtabVxrVN4pGZTTBfkHVczbK30QYv1weMMzUgYo7
 jTvI15GrM1ZEeAKXZsWDSdG/v0AqxDI/Z1LOAL3S+tIvqFmjQddC0zSqrTZXrgk3
 MXvTtfINgtJVdUPKKTpJwB5X3aaEscjc1Dey6kaJH36Ejtmi6XyxullbdYrT6U4p
 HJhLF3n9kQmTMnjM8RzJBvmFfZIxZ4IgVvTJITr22wml8oU1r+X14PwhJAny0D02
 rmO0CfyqzN9iium7+AW3oW/jQHFlpy0SpfcZ37eGJnznIs1O2UN3W0TX8jAPQbZ/
 DUTOVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtwjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso15170515ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371920; x=1783976720;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=frKLSu8Q4XiEcrNRmJFNTn0sLvdbxuY6iJE3zKD58p7eipVfyvQzRd62HLrSe+BY/N
 eHQueO+ph3rvZHInuFsWOPu2mMGDdmpQ7VjBKWzBUgv79h3GSZF2uYCA2HwV1MG3BcnE
 wR5uqMKdQhOhqyoONI0EN8tmbPa29LKg/YgD9kQbDWyEqIAPIBcAQsbOnN1RPF2+w9pg
 x9ota1q8wE67Eg4Ze6w2W+siudex/wTDDyPbexuWZHhZ1i+lIcllP0mgnhMDKNKkou/x
 fj8NdzGe4HohjWT91RyEhdJoShgT0PXyV5yrnN3m8t3fzGex/Wz3u+/TsRxPP7dTdP1Z
 /cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371920; x=1783976720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=exxwhZMTU/he8IZUkUT7QVw1F7W+mPM7cjzl+8AkNbk=;
 b=F9z6VFMyy7MY33QB+wMy0baVZOSXjmJnR89/u+keI5gvJce0HIJ02xOgBGJwCzoSK/
 jsPc111Pg0PMpw/xe8DovL345OiXda6YKieun8b/QishmT7Xp18TAZUkjz7wzVxz87FE
 zwZQaYMo97M6rza74LjHZfxLGMI5Zoz0GimuMXCXvqdIblNGl3at/qKOBisxjQ576QmD
 SQsxjd2pPIZKD6q0q4rvOiRcv0KnVzijIHe7teJu2T2yM41d6UAop8ukv5pyaXWp9TxK
 fizKd8ezCwVzewXEC9ZlpcmT9TKShhkun6v7S5ffoRmrkA2kjTxNON6m9ZboBUgtLylv
 D8BA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rovlrl2ekNvwpD0dkI6mj7wMmMKdKRBMT+a2NNRsM4zOtUTql0aDJR+JhwrlyuKV81jAC2A0wJXSN4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBTtIVKMNcUItmaTGEJGEhKHX6cuy0VC3TiKv3v+xt4nEsD90U
 k0DM0MO0kI3rIbSp69Jai/CVw4N4oM6xGHUDGvN4u31otltkG0TVLgQjpHk+wuaoA2jHcs1oTpu
 lVcmzf8XSIdOKPKaikmBfOfFqoPKa4IRzyDx0ZxMjojoSkDQTCZlBLiSS0VPRsaKNRScae1U=
X-Gm-Gg: AfdE7cn0NYgfWBzb12qr2Has9QceolbTZpajvJYuFtolyxO/xnu8KPJnjqo8dhLPjv9
 6AMN00hF6KvIJp3IYW4nsooD+6KpBZhqJ5TTcYAFIei6pM7nXhrBI93QOhmo9J5SXnrq8nZBvkU
 Xs27Iu1W7M8xAdhUrYOzyyHjN3iiRYQtYUkGg6ynkurcUHXjMwgPoMaxtcl1nv6qKU+CxILzrJW
 P7ddMvJ05yWdLrjBis/zwCqm9b1bvNu1n2+JnwtZ25Tds8LNPJzQwe4JjQrkrKZJzk3ZWpnPbUH
 9r8L5Uxdcgvsx06+s5uL1GdqpLFvIsOom9Ag+mPv8/R41qxrgicvpXbA+xeyxFmk/J6nhe8Syh0
 CnuNNKHDb4GTc2N1iKg9Ef2AQqhEu1OHPZ0A=
X-Received: by 2002:a17:902:d4cb:b0:2cc:9473:9799 with SMTP id
 d9443c01a7336-2ccbe71f6abmr23766075ad.17.1783371919839; 
 Mon, 06 Jul 2026 14:05:19 -0700 (PDT)
X-Received: by 2002:a17:902:d4cb:b0:2cc:9473:9799 with SMTP id
 d9443c01a7336-2ccbe71f6abmr23764605ad.17.1783371918261; 
 Mon, 06 Jul 2026 14:05:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:34 +0530
Subject: [PATCH v5 2/7] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-2-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=e0reXjU4841qQsB76OT4bfKmGmY/z//RRWVRYHDWGzM=;
 b=vX6elNuOWQ/4xTG/AIha28ryHCrqCz3yvhkLfw4vwe9YMkegmgcm19fBeyeVORd5TxSW+WwUC
 /8wVZA0zXpkD5agy1gfq/6ZA/4fyK4Fhy6L2Kfebx+YnGBJfWNznNZy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: DsMjhKAnHVoCn4iE3dmqXj2hv1VbT7XX
X-Proofpoint-ORIG-GUID: DsMjhKAnHVoCn4iE3dmqXj2hv1VbT7XX
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c1890 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfXwc6AOOs7blF/
 NrMdXpCiDVU+EPCXiEqhVXVkr1WAwY4HmBXnqI8uPb2KiuipIhINj66WY+MpcypOIPrc/VQuPyK
 FRcgXQ5yMevAKJ/1vwWZJWExbMUe1jdRCQaGoeC8rkicfc7PxZVOd0iAIh9GLfQZF9O54pT/Nju
 eoPIX9muCNujEJYvlahDiQsr9fwk7Y/VSVpM2bn1APXGMEMJ4dEckIbCghCKNen0eUgYhJy/azI
 h+0BpOBj6K3w6jqkQpG14+ELsGstmj+Wx9Ju11JRgl9dfy8BDDMXJLLC1ugJ3obn8cX1YhCN/f8
 IzbuxDD8J4lj58CIqYSce0y1vaI+uxvKSRAMk7dh15bQTYKz7Mt86vG8DqA1ZY8mUnM0N/Yky9W
 TD8BF+VbE/UJv8J69RlLctova8zdou+j+G+Ne793VhzlRsRTKwUYC7TiGRTW5PMvCBS8tdEzcLS
 4Ct6daKS3O5e53hURqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX9H1Mf4iKuHQN
 9vpBj8XPBvOr96x2dzYFAVRvLjECh5i+Qxj9IMuVWKEltvWMzhBC2tMtyNzzMHWI5tTmO9LHggF
 01LEm+x7Y1cnaEkPqSLA7MrDjji3Ldo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.54.0

