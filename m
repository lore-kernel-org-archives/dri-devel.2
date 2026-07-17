Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AAEC44521
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E254510F600;
	Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEVnMuB7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b2PWrox4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F4510F5F5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtih72780733
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ss8T08lcQRu
 h4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=; b=hEVnMuB7JH37W5cfKsOLBno8Ef+
 94Q/ZxE9MwpMWvrnzYCxagCyucP5XO9OyUb5dA+IT9jl78roqA4Vwj/Rz6x7R0ni
 XFAXvdztczHynVLnsFP9QuluXxaPv8xhQEBXsex3BZCNVMltbrBZuGSvNL/age65
 iJhAn1fbiLHFnnMW+h6s2xe4ogrfxM0c19CXNfNAtgEeROW1Q5u5k4uTEw6eeUWT
 2p7T8P+0lMVetpGHFruP3wsfcEk0+qi7XHPG7RtxRgRwz1RLSUHedV9mm+8ZodK/
 ZPNqfevnPGMDNCkZNwvQ5gpAoGVz5J5KUjBjiFFHijNBiMMYjnYqnILd7Gg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gua53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so7961978a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321335; x=1784926135;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ss8T08lcQRuh4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=;
 b=b2PWrox4kF3lLb7c7uXqxt4UXbxzNFQSVwkfC3xhPVaYMoKgModRFYbiK6dfgRPNOM
 33qyyHbOmy2NLVd4+rFSxSPmyQOgVyGLGM+mnh73baxZAWuN6qVmV5FHu/b3/0Lg7OH3
 IRFSai4CYgV7SbBsXadfjDNRmCVyphGyL3OEsyfpiNszyJrBgL+/nWDPrnpKNmGKHBxf
 +VV9UGqexQT3s5E+/oPUbOLXzznqmZr09cVqPJ75lxTgmv1kwewpljaKRgjVBYceYvx9
 0K0P1KXY9dQLjUP0GHuOK6+H1iFFcL5ny007o6M5arev5AGw6nqyYQVw/nQSRR34B6U7
 fGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321335; x=1784926135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ss8T08lcQRuh4LT8qU7cdiXED4Y+cvXcR0q697Hi17o=;
 b=jM2ts6JWf+MzZ7UZFRFk+Zr38KPz4bnqzsV64F2I+yOUZ/YB0CLk+slvvDju+SFNUW
 HXoQvIjuYHEYmQK5MJYocM6eOMcQ5CqOtn8lY9Kr6kNAuYq6I6dzCGTk569Xnzz34ycv
 dfQxZw9VTAtrOf5KBYqEWunmW0DV2lCNtHmhu4Tp9cBpoQCu6nPJRPRlMZa1QD+sB3TW
 bZPC8EDWI5MjMgXHqKQv/y3Lwjh+gz2HFhwrmAeJYcLuje0V/w2XoijQIH8tfKyVPCbq
 nfcKongppR/r0RwHqk9ZmpAzuXg/JZn6ElKOhRMVq1IaMH2TWWZslU2kOe+faYbEJYV5
 dbCw==
X-Gm-Message-State: AOJu0YxR31aSkxdb2XWgx115NixU0ZKzW7zzcbDM56yX1haBLgqVpfpI
 meRo/PM5WAl3dU04hPhDjfiZS3KEHDYKpdtq9FMZqPV81e1nQ1JoK0QsbyW2K6z5xdp3E8wPqdu
 7zW/Ad0WazLQxC+7cRX6xkR9Q5XEbJ9KYzj8JKOfx5C5ZMVP0k4TAWDM7gG2xmBh8s3pP8xjvTX
 bNHCE=
X-Gm-Gg: AfdE7cllu+PW3l2tHmqhFaU8FKMczXpsm1SWcbhXsAp0lhIJ1J8JtWYjSUAmcKO+fe5
 gN0LP5yaeFjSW9QrwNiG45GJy+nSCHTst80N8Z9NWDip9t7T0ngR/CRm5ZhzXoj4jL4N0myl15M
 lO8BhxAupOvGPdR7oolGmZ/YD9QKprni/udkp35wvclZIdZ9Vy/so3FuHyoTusO7ZVlbEyJA40e
 LngogAG239tGfltj6inheOQuF5/7JccaYk6leVMa3XYgYRV0eXfzQub0SSCqQpfZZTARdicke53
 kFHfU5xVxY0dUBp6VPJdjB8Eg9UPwmV7eLous0dRAhP/EaRZ/g13GR+L5m7pMwZToIWv2mDBHHn
 hkkF1nfnTlYXX6HeaL8tlqckZOtskKL594eo7KsWMVPTBDMQ=
X-Received: by 2002:a05:6a00:1950:b0:845:eadb:821 with SMTP id
 d2e1a72fcca58-84c29271366mr4815795b3a.14.1784321335563; 
 Fri, 17 Jul 2026 13:48:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1950:b0:845:eadb:821 with SMTP id
 d2e1a72fcca58-84c29271366mr4815769b3a.14.1784321335169; 
 Fri, 17 Jul 2026 13:48:55 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2adcd3dcsm1743863b3a.24.2026.07.17.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 04/16] drm/msm: Synchronize set_sysprof on ctxlock
Date: Fri, 17 Jul 2026 13:48:20 -0700
Message-ID: <20260717204841.26120-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXw2fsAlsgN7ia
 tccraRUd8XJlPiQKTKszKDjwmv5zaZGeurmFzrYHSroN0nt8xkhdoEbmZ0Oowbq0JDJYZabiIxL
 /wd/NfAf/CQvBb9XLXKnNhwZqP5WVaA=
X-Proofpoint-ORIG-GUID: EIKGEcHipTcE_sCNpFDoQpU9UqOaCJOh
X-Proofpoint-GUID: EIKGEcHipTcE_sCNpFDoQpU9UqOaCJOh
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a9538 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=A-0ye_aN_Dr-yZQka4YA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXyRp+CWcvBhvZ
 lHJMsHkNorn3/AEIOgPH0GDwB5wecITq9SGlILOHgi9FzpCoY4KEMRpbrLkdUHOERCJwDo3Zvo1
 MZ7c4vP07Pw7QSx0gK1A6qRaR7DsZVsusoF2aabUNwP/ti9uME3XN4pRnOzfFY64VcF3C6/GOHg
 BFGyoNEzCHonv6Yc2Nr/18SP8fjzxvoZNH8XxiLN0dLRZbp/Q09MlrBQ9wPNIKzUCjAkF8fbwLZ
 oq/SXgklh8DHd/Hua1HbLvH+LJqexS4pQHksvW9JUeXmzhl91/0lfEeYgsn01l4SAeIkJ4iq5ig
 OBDfp5hxtGJ9mvNLYawLITPqEmOqfeilK67brFAyUDhzy9fB6wjzHouFvq0hRDPXAdDHs4vGHU5
 /n2JgjijbDhHTKkHbMLTKyPzwSkVASsNJ3J35HQqOKFdryWW5wxzDlcI8sOs7hmM7nVLNCjT4ge
 X1c8SCmnXoh+00BatMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

A user that was perfmon_capable() could try to race setting SYSPROF
param on multiple threads to trigger a reference leak.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_submitqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 8b5980d5a6a7..233c4f35ab12 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,6 +9,8 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
+	guard(rwsem_write)(&ctx->ctxlock);
+
 	/*
 	 * Since pm_runtime and sysprof_active are both refcounts, we
 	 * call apply the new value first, and then unwind the previous
-- 
2.55.0

