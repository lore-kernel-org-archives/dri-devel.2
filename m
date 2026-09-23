Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632A3C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C780710E092;
	Wed, 23 Sep 2026 10:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTqYTwaa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYuGABX4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F9D10E092
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA3KXv3566269
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KfXoc3zywC545EGvmiJ11HJfhJTtfASiASk8KbvKnIo=; b=kTqYTwaaHvHCRQGt
 /fmGtTwhbXNV+ma7qkgkx0tfxmSralV3ZhoUyjoYLbKk1ub1yxXo7tWg6ucGSJKA
 +a4gYNA1BypvYQFNdICyF8fTq0LwpkVFu3xUAbwvWJnG35Bki1rmekr4K5wr1aBZ
 GSjzIzgn2aPmWrbgXrHg7bYelhUYfbRJ9N4seJUXBxbqto8YQylMRVtjpJ1k4KjD
 vHaKYfez46ydfjUkAN9UucRPAREKK/dmZh46M+KI6P7aUwF0qxzECL5cgN3UFe6B
 s9Ve7ciYFCN+eYr6MUXIH+5LJGpER59vGjZCBQAuYqCt6yK9kNH1Nu56Ml5W/12v
 ArrS7g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux7xuvhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-142f4306744so2030437c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159186; x=1790763986;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KfXoc3zywC545EGvmiJ11HJfhJTtfASiASk8KbvKnIo=;
 b=HYuGABX47bd45X/vX+xAZVI/x8i5pQMk/tksFv/Dh4XVYMO3LNHyAQG8tL8qkryX2Q
 YN14uW7XXuLhQcG5lpRKDG+92zkZwleI5L3ZrSMwngwML+HdnpNQBNv7EXiRC/aDhyLh
 KrEEqUfiSOQ+8x4H2Y/Tf2EnvUiYUkDaEKycIWQQWcD0AwyZqelgNqfN+JKXwXpHQHgB
 avnAFUdQDEwTMbZi9/HapJThyk1TJGSLHpASJ7bzJsOE9NoBtRjAFqLEF8UGla1oHgNZ
 rvgk0Z49XzUOb0/aZzlIxBzPVZTNn+DABdoeQC8gRP/zon2+oha4Spwrz6tVP2pk+/U3
 GNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159186; x=1790763986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KfXoc3zywC545EGvmiJ11HJfhJTtfASiASk8KbvKnIo=;
 b=WsLkJee0oelou7hnMwOrHsRzITFpIAfkAe6KdNRh1fl7zBG+B/wpJSOF+I2P/OGhsV
 DieoOdMpo/hveOTGbjFhxzNfsW1O9qY2KmiA3DH2xqf5foxZ/Z6pY/JlkCLi1WZ68kn4
 zEwz4dU451O+A2CTZqYOhijSUR7UmXyHFqdFgnM9J20e+D6FdIxBu7pQJHlj6irW/CUm
 nbx1r7giHj1TytToDtuT7dIZEYVMB7yAoLeY+HDH2hwk1kbGjZp3LWa7L5JrCY2Psr9R
 dm6Lgd+xYS3H9iXzppoRk9VDTacUE8NYG5OIIaXk2g1+PM88M9pD+vnk7ZbuCYlVVQRH
 3oQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqzN6rwa0py/W4J16qNpJcalGyNIUK6QKSicVc5Ff+xxkit/+fuqdDbw+RkIDzMyHps4LS+LF2isU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kWXV9miaJaC0n7DGX+wQ35D9b6rFsStQVddEACyycWCuov1tTk
 MnxihYhOw8skP0kBSwja2Z4HhZ6Z/9HnpWqdOyEw4DhkJSr+34rLhoiXmYUmfwK/qec6oz3FQlC
 NvKm0t3KBiuU36GRPmIQrq7c80K7nX3LG1F8pJnXb0y50URI5lfKtYtQATA75usK+hgGJSwM=
X-Gm-Gg: AYBFou1/2QmBbwDqrAcwx2sXi5EKXn648dZakxny0Geiwu2MKkug5YnmMv1qeAIGXr3
 XKlPomKUDYk9TPV9rJzbMibCoJBUkPh4hBlJPn8l4Bg/FCF+mypJERprl9F/WgwB1CiTFAwH0ZM
 0iwdj6mZL0b88zsFy7NbZtmtv+ZLy+5CrfNqkNhGTyQ++RY/9AOJ3phh7z5LnxQiaw73PfDfZyM
 WSiKL2YmBwkmDKRFSFGr1kFLECSiByIwsUmqgoISO9NNt3xHFmdQRxuLJ2iMBhuYw8+h+fA7n3l
 qNCZEsvzUxNQcj3oyIHzGPyDhLqn2M9CQKa5YO1d0w+j+FFqM12GoAPG5m9MYTC9T8FWSuZ8foh
 YX3XMDmpHJNUZpweVg1NT738=
X-Received: by 2002:a05:7022:7f0b:b0:13f:c02f:60b8 with SMTP id
 a92af1059eb24-144f9166ab0mr2194585c88.6.1790159186373; 
 Wed, 23 Sep 2026 03:26:26 -0700 (PDT)
X-Received: by 2002:a05:7022:7f0b:b0:13f:c02f:60b8 with SMTP id
 a92af1059eb24-144f9166ab0mr2194543c88.6.1790159185820; 
 Wed, 23 Sep 2026 03:26:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:42 +0530
Subject: [PATCH 02/15] drm/msm/a6xx: Fix secondary rail vote in ARC votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-2-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=1328;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AdlzOXzfWps8eRCoOYaMQ/l7uvyFxG2Tx0xeFEPHfFk=;
 b=693AYB6XLlB5c/XlIXQsn4I8z1hx/Fde8dopx5AR6kyh+CLc53YeZ4IOWJhVIw1DcpU8qUYVE
 VpO0wOoGjt+BExCh+kqDZEZMmMlzfiDkfjAEPFo1zjUt/+GtZvBjL6Y
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: e4_UpjkxfVyj4xHnWLDZVpYA5JxvvJ4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX5JrMkJ77UIFl
 Yudu1TIu1Uye6HDsg0g/Gd7Zi9kt04mGGKlmQpJr8BRwlqzoggnsYlcxDZwAxZi59ywxI3gNVaW
 +kvonGFudZpZUwM4rsDk/cPFDpN3j+AVlPcRrOqbLQx0pEcDZcDEZnURPZFCszxe9cBKYyiqzC4
 3fmXnZXAYYvwlooWo+GQfaFt0ivmj0s41UPOboZRgS0Psr9ug96enXcfhAYH8Csi039NCMjQiSr
 rwljnq0zOi/Mlrj43gPMQ1ZOjBNdtRK3DhE0LdUuPW9/xp3AjLpedZWl+/NBVEZXlxYIUuQ90DZ
 1oVyklgh1qKC/LLy2bRHwehcxVZlRJq7LBIuxSDxVYsVB8AMG2m2SlX/fZzBMamJQQPa+2JfQC/
 6jvHN/Ngxp4PsGv8bCaO7IXNGYrjcdz9riuIpqiadhboDPMS4H9OPn7gMiK8dJdb1Z+seZJCr5l
 ALjfsmsjjXzkHfSsFjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX+RP1bzs5jz15
 WV1njWv9pPXTIBVONV48f+BlpRMvr/kJ43fcoDVyXUljCxhrvogYyvTupsmqO/9NAa7t+Pkhydu
 6w82rDccieVyiuCZZ+SJ9xly/AVlX+U=
X-Authority-Analysis: v=2.4 cv=QsDLTlyd c=1 sm=1 tr=0 ts=6ab3a953 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vapu2bkIsq-odsm9enMA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: e4_UpjkxfVyj4xHnWLDZVpYA5JxvvJ4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

Using the requested level can pick a secondary corner lower than the one
required to support the chosen primary corner, under-voting the
dependent rail. To fix this, match against the selected primary voltage
instead.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index baf77a620572..d072646093a1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1765,10 +1765,14 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		/*
 		 * Look for a level in in the secondary list that matches. If
 		 * nothing fits, use the maximum non zero vote
+		 *
+		 * The secondary rail depends on the primary rail, so match it
+		 * against the quantized primary voltage (which is >= the
+		 * requested level), not the requested level itself.
 		 */
 
 		for (j = 0; j < sec_count; j++) {
-			if (sec[j] >= level) {
+			if (sec[j] >= pri[pindex]) {
 				sindex = j;
 				break;
 			} else if (sec[j]) {

-- 
2.55.0

