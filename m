Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AF606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GkwNMp1J;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OjtqlLqY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DDD10E00D;
	Tue, 24 Nov 2026 23:13:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD7810E00D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaYL41654121
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cjiR/MdBLxo+zRp2BRTcZc
 jEQ/mSe6WUU93dr4HBkCo=; b=GkwNMp1JXdF9NWfFlmXBLS4CFCYjyslZ/OMhQC
 ghduQAh4xtyXzrB6PbaWrD1ERa5bQyqcppdnxY5fr4bCmGMNSGY9UZmOTqpPVGtb
 NhgXlXZvBiuwntGXdKcSPiJNVXOdN3Iw3uQB77pPo6+lrXAb1iQLUXQw/A/8o/xU
 OFro0ndfBBVipMkVL9xyCkEhBzDkDf1Wz1jmoU3TYIO7HswUBYzuHt9Z2kkWS9Yk
 BwJkKsYw5YIZ33sN1mhqO0LRCqSHSezY/Q7XNW7k0MCcU6bf6Uowq/GG+8D4ejNg
 gWKKo4yzHd+G31F+c+vdn+ik4UapXXgYdXuMJv1jGBSdv3yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd993t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so930139485a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562005; x=1796166805;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cjiR/MdBLxo+zRp2BRTcZcjEQ/mSe6WUU93dr4HBkCo=;
 b=OjtqlLqYyVfk8ZkolR3jj2CdGqATqBhDxw/cU8IaAIvul8hWfL6rEKybSf6ZZ8Kf3T
 338fBYO5dyywJ3kd5UKK64MTQM2YZAM1/WHK2dARi4oBQ9AGV7otQxVoq3liiNo80GOQ
 gnlbIeGpn1R2d+ZgmtYqjyeTL/18oOPUB/Gep+mBk24b+lxfwi07U7h+kETgFg3VKVfX
 VAd3JOo975XByO0ewZRVrtOOxK4rcP5MpfomCfbqEfF5YeMRMKbr/pDEioUyJYMPyogL
 jvB3fSuD0ImZtxp27cZupa9poKmT1DdGcmRSjhhdVmNgrCWZMIVh9DpBP7JBWBDZoMiX
 pg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562005; x=1796166805;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjiR/MdBLxo+zRp2BRTcZcjEQ/mSe6WUU93dr4HBkCo=;
 b=eq4+vdCEzRqUXPYfkhToR70mncxEk1Vbb9chezPeiHormlCnF1RI6azR3TxMZS/Cz+
 HPz3FBuiXq/8S2yJq04qld5OLNtYa6l5WtwxH2bYrGV/bSHMiMgGRNX2It/+uuiSFwXa
 rgThZ5PP2MPwOCTMl7EcCxj5XkDyl/gx+bli5m9CfSpCGq20qVgzDaDn2si71BwWIMUC
 NWmytA0ZicjkN7kvspKnxIGUnYGk/tBj4WQYfX8JJbAO1m5b7rBmB8ubEBRsAADKs1w+
 BTOMuuvkMY6igI+7YXWGV7WlLw0pzS6sZg6r1xMRkulZUnw4cF2OVLpP0Y6cJV7pzmv5
 i9SA==
X-Gm-Message-State: APuU4Z+J2pwKWsAh1Pn3aBahC1/ZlYaHA8Gb1GoXryIanHTTN6m+W2Dx
 f7nPA0z1NTsM5TLUc8j4/I2B1Kz2d1uEq75hj93Qf6jdALdzTfsNqwqdr0v0dFK0f4HOB+eZ80J
 XwV/BSDwqvhOd4eLkgOqyHHF5thM5poM0u6iK9M01751lUTxZSr8PwVrGme9ljOJwqKBoYuA=
X-Gm-Gg: AZFdTZfH2NtVw4bDBhJaLIr3tzvc+BQyHf3oNz6tyU0PsovO4wctc0KsmT9pC/gSanB
 utbBbjE4JKyJPvDd2tkdI2ho5WM7Mea+EzarLI/D5oYul/SOQKlnjTC9/DaAKI5vN8LnnylRQGt
 C2zdQLxTOX1ay2hibLuHqpv21fieV8oUUvVGUY5t40j7mEp55/sbIjmyqPvJ/5ur7avtOzPlXtg
 4Mpw6C3rOH8frWHGHEh4XJt2lDIkQFphTeAwH0S4XHXNJZ+nhNslmJCnIWPAb0uyZkc5Lb8hSvn
 hDTqGMMbkqdEH8eUtzX7k13t4hwK9qo/np683DRnxUK3TKfOEhrGX7IOmAwHgxgMWh83BL8avJd
 jAjDDUY44Zh5GzPCLVJ8JRZsuZHW1WmKyA/hUMbDJMFAx2XJOugHOTsScSTvyu05hMc4hBbpu8j
 upgdamiB4pUEYk3h9i7vc4lH3aMs+pL7JEMdUAL/IPBzzoDer16zq57PIfjHmZ+g==
X-Received: by 2002:a05:620a:260a:b0:949:7502:6a0 with SMTP id
 af79cd13be357-949bac8117amr2408147785a.77.1795562004783; 
 Tue, 24 Nov 2026 15:13:24 -0800 (PST)
X-Received: by 2002:a05:620a:260a:b0:949:7502:6a0 with SMTP id
 af79cd13be357-949bac8117amr2408143385a.77.1795562004264; 
 Tue, 24 Nov 2026 15:13:24 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8056b207sm43708401fa.37.2026.11.24.15.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:13:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/bridge: lt9611uxc: fix firmware update
 verification
Date: Wed, 25 Nov 2026 01:13:14 +0200
Message-Id: <20261125-b4-lt9611uxc-fw-verify-v1-0-7aed8dec8018@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAoaBmsC/yWMyw6CMBAAf4XsmU3oykP5FcLBlq2uMUBaQAzh3
 1nlNnOY2SByEI5QJxsEXiTK0KuYNAH3vPcPRunUgTIqjaECbY7v6aY8rw79Bxft/ReJ2F/thbO
 8cqDxGNjL+h837elxti920+8G+34AOjWm2HoAAAA=
X-Change-ID: 20261125-b4-lt9611uxc-fw-verify-22ef8b3e047c
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+T/MOVlT5oZ3ZJe9Oe4wZLBaImuh0MwfsiiB5kqiBbM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrBhoMLGUmIPl50SxT+LpImTbqXaO4zEvNT9c+5
 fERrLBS+rGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawYaDAAKCRCLPIo+Aiko
 1YWTB/wKcopixoLFY2rRSb4/Yl5oxmPIqc6C7I/i0LgO0oS3OQnoxsdM1dwuxdBFMh0fKkE0Rjv
 8IWFwAjt5gl/gjKoRSVRIBIHJWNsyzf6IMcl2p+Y4Ft/g55OgbkNdRskV9Yzm/d0/5nvTIjwhCE
 fTqB9RWZlXE2yrJximpvlFLqLyhB1VfG/QHXq2UdTlgILqUPOzVjYctoCywRO3Zxv3nEjRl8Sj2
 tlIlITbyAoi6C7uZNKumFl3d/ZntamBKcUxaBgoNN0SU9m6euEO1ynQM1p/V1lnNLcj3QiBQb6V
 OkAjZp9F7nE8FG33TfO51t40d74WyLqDRiJgVbaO9CwxBp4Y
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX0rc8ymtNrtfk
 DQ/EKqHp+UhP6Uj6TkWW/RkQdTtj7ijn5pipzy273d/cQVMb+JQ+8HTIqzamQGVQOM1ZErXrk0T
 qNc4KE18uy2aahCmzuPkpRqCHks/bR4=
X-Proofpoint-ORIG-GUID: 6144SVGSJTBik4m9OpXLmcGAMODcDFW2
X-Proofpoint-GUID: 6144SVGSJTBik4m9OpXLmcGAMODcDFW2
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b061a15 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=lFySJRcj7EoOnToY0NAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX7g+hqEvZnIx+
 sBFf3hKQwHhNLbRR07rzNDW4Ze6zJwSb5hHs9DfXPkVVchAwMsrsoTjAUuolARY0F2ZdC1aF9nv
 NhORXAt9jHVPm41kXwU2jD9e0rP8HtsRZlW0KOrbDwFymG+vaFMcoq8Q9pRi9vElQ31+fqlDues
 bfgHHqPzhkEQ3uzqA1awT/9lrY99P72sk8vhRGZpprh2OTd0RmdwGwVX5bz0VKVfpbB8a8TMFWG
 r/6ZDBARJKT2CD0iu243Jl9wYP3yHhDDuiibLjqLn9r/kAKsJeSnZkU/V0MP8ckfUflh4pnfl6b
 moxK1EelOW/Ys6CcKA8tAwnd9UzcN9FP68N+FW9Lh7Be6fjieTMopa3Xu3phqorx4ViVrzbXXgn
 wB3suwvhB4UgGiZPwYQFWI0PkdoxcMznsFFu5fIruSROg8LqCgMqHQsFJQySQKOoYJDu4ZSThQ5
 XnnQNyhsiWycIIbxNgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The firmware update verifies the flash backwards: it reports a failure
when the read-back matches the image and success when it does not. The
read-back itself is also broken, as it never switches the flash into
read mode. Updating an SM8350-HDK bridge from firmware 0x41 to 0x43
printed "updates successfully" even though the comparison had failed.

Fix both.

---
Dmitry Baryshkov (2):
      drm/bridge: lt9611uxc: read the flash back in read mode
      drm/bridge: lt9611uxc: report a failed firmware update as a failure

 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261125-b4-lt9611uxc-fw-verify-22ef8b3e047c

Best regards,
--  
With best wishes
Dmitry

