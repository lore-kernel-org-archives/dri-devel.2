Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F86FED3E2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660E110F609;
	Fri, 24 Apr 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JRJN+Mqd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fYqI+0A+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CC610E101
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OAPLcj2972299
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KywJ9hcCP0V
 e4Q/2h24NGhAJMgZTF4FNw76RvtNMYhk=; b=JRJN+MqddyEDO5gYUdhUGuwzto/
 PpfCNdi9dD7KhQUWOgRuBWVZd+GWjYZItIGWRSmi8WbD2oxwye/wYAex6ciW6FQV
 0MuCI5GebYWW9bpM2/E4xPPW2NPVfhaYzGw/ACW97+vuSMGKTsGgrTksuHPGv7XZ
 DZOeOEkF6cPaFh3de1KNCQ2t1MKKALOob6vgavBRfMG6DVi3vyILaFhoqBFRkDCr
 trkNjLosenQjGUrFfcBRpo52xBdfzYmV9XRKdWACKJTBt90RvNOxd3eyVWrrPAiY
 ByLLhKs7vdedJSumfXFYlgo3AyE5ySoBa5RCTZ/fyKrGk4lkvPMszxbHGPw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr6rk94cu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2d83e7461so135883445ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043543; x=1777648343;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KywJ9hcCP0Ve4Q/2h24NGhAJMgZTF4FNw76RvtNMYhk=;
 b=fYqI+0A+cUwRrKTyZ0fnmIeV6r31Ebj8XKVr5Fmz2KjcB1NIgaVpfqrXPnJlsvwF4x
 j6CLCohlLI8roogvrjBUDPQu1Q06+qIuBmKUbAKX+Ky7/rYA5jD/1UV1NZTT/wwaERQt
 LF4DfMtqKQhECfU4f6cLUN0XQ9GPov72iBnuDWlVA8LLXWT99JtXFgRAAReSzSJb25LL
 lzBUOrOtD1D5QtIUOB4ACoh/wlXzCTJuI5/TDfeTGTyqDv29gF2cfYFj+mT/Mn7YMJSQ
 t+qHnAiGWsPWVJ2Hmby9y1NEeXWW6lUH08daFr4wWnGaF42mX8OJ8vxF9cQZApBa9nbT
 VfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043543; x=1777648343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KywJ9hcCP0Ve4Q/2h24NGhAJMgZTF4FNw76RvtNMYhk=;
 b=FdRalAXeZEmpFOUafC3IG6lwEAdAOPf+2rlt6WXgDfu3imp+AM6MmFdN/G5PgrDWNp
 uuFfQGHZ9wKnyWvBMhwgntTbyNJWFoKP1CjGJzYKzVQhe0Z2DI8PrBGNh+hHU7AL+5pI
 I3CwDDj5PfnCc8cg2GHvoN/cVqsuTHBKUKE6ZeHjjpcYpL5hZJOKm9uGg2gTzEcX9uBJ
 A5W3/SBcWNEsAFvHpmAVL2OIBGg4Lqz/K2w3AuGbpG28sShA110iIy+cUv3QBRP48Km0
 9PQsbW8X63mdWG+WTdOcSf3Z8Dq3LXK2BXrOMfAL/waqPDKVYjyT3+qT73cOPGNIVMY2
 /Y0w==
X-Gm-Message-State: AOJu0YyZNlR5XxNLLRq4+ZXhAntP2XJqEBJzaisbDJxJgSlxib9UgL0W
 RGN2HBkad7EX6TWxGZSb476SuTSSbrzjuxNNQ/V/HsBf72SS31RQG8fvrP57gH1VnG5tLxPGl39
 yQmkWvPaw/FjDlLOq7xuDP0X+8FWXjJay+4RU52G2hjXg1razcjLDBXwMrgMfZI6K15+dF5BirL
 wRaZI=
X-Gm-Gg: AeBDieu3jxLvDgL15zWBO91ZhkDXrsluIb/BHSiqM00Xg2Dk4/0wsqZWTV9TmkB0sU3
 IX5s3hW1QH3MwbHe7ByzOohQ8w3ZDo0TYZ5sU0qiErtvskIGr8xTX/6jYc8A4zkU4px/1N5kJnW
 uJ3qIslGLerHoMz115OkJ0Lu/nLfjwBsI1JzpiWz3iKU1EVxnd2sYk4NshukRaW3xorntpfKOPf
 brjajli4/5jhn4iYjUm+zbbEJbC6LUMegP+ckyHcTcIVq6bIuf0XSEIjtdiA4mGJ8MXVX3Db2pu
 +M393Zo9MBsDpIhtU3YaM3KXzQ6PMUaCNEIZ0duS61kBbLbUFpsWC6PLQzj+Qo519JiBxRPJc4k
 sG2dOcIZjaAejGb3+DUQMIx//j8etoGqH+QAQYr26Bps=
X-Received: by 2002:a17:902:f70e:b0:2b5:ef7f:a47b with SMTP id
 d9443c01a7336-2b5f9f4e150mr365609175ad.21.1777043543502; 
 Fri, 24 Apr 2026 08:12:23 -0700 (PDT)
X-Received: by 2002:a17:902:f70e:b0:2b5:ef7f:a47b with SMTP id
 d9443c01a7336-2b5f9f4e150mr365608555ad.21.1777043542633; 
 Fri, 24 Apr 2026 08:12:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab4049bsm209805085ad.77.2026.04.24.08.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:22 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Fri, 24 Apr 2026 08:10:49 -0700
Message-ID: <20260424151140.104093-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AfWB2XXG c=1 sm=1 tr=0 ts=69eb8858 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=8lTVeMJbxB4f0FvlbnAA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: cczfNofvVXX9v-dFQpjHDivsQ2d_4kC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX5JyVy+njgxcv
 UPZ02BICKQ12GnHsZpWSj3rO9Sqls6ZvByapEbbPFfVcC/2PE/WbE/dSHviEftjfmzTDngwJk6c
 yen2pQVBJnVTu4X7I3AKeHB/LF7dp+/bCzwW783x2Oxnw/lzbEGO91YUS4SYVZzsiqHcoowHx0A
 fXCWav7i3LcSWpXCAIcfECWOC/BEbXqajIBpE6lqLdEzeAvMY6IyoUMkc6TNRhCc0q+dDEkDfGw
 4z3/9bLrgNgOnem8jM2sNGgBYOYvOmcghb4U0vYEm9GZPtGHsYEREzeyb7yqG/+NQZ0/L95rabf
 KmTnffavYblqqOLGSimoYI+xE4D0xRsUq/AJvFCYt15TAnbqRt7r8aRFkvK23C13MB16KEXo7Gz
 6xNP9STWEAnFOBCfExYlICdCX+mC7fLc3DuUuwQIBErV9pSgJq8Xa68av8fJAeoxZHhZEcyE/rz
 t6lqq23Jcr9F6kVJe5A==
X-Proofpoint-GUID: cczfNofvVXX9v-dFQpjHDivsQ2d_4kC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6d0f8dcbe9b4..04a6335ac5f4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.53.0

