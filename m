Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CBEF99C86
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 15:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A9C10E2F8;
	Sat, 18 Apr 2026 15:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdgBPamb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkQ4zhwd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39110E095
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:08:54 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4VnrK3443547
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7RKGiZUqwXHwZlcK3riA8O7YRYr98W6ip9N
 WAR5j7yc=; b=cdgBPambaGImn9rgHx07MsxuvMGmN+FB0slXy+XK/gn5TPAfKP2
 QIQbNrirfJz7BHLn41K9m5uSewx9JVb7lrhQUmVo2ZmKb5d2tVO6d7LsvFfpWBYk
 aoZQLW1VHGieEKGTaingE9TLqZ3pD3wtn0QuffyEW1njgjzTywYqwL0gn1FA/gDz
 Pki5igp6knt4dU7+V+jvpAj0rr70nDJkogh12+CvR0MG6QJ1nXka5Oz+zP9Tzy72
 jaHSyxpTVJSiZZNlOq81xrcKtS0ONGwgnxE/EVRMkW7Mj8XQK8V2erd2E3iYV1XT
 M/aDXX1dDS2SHAjvKxYe/bFVQH4UMTIwwCA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyne995y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:08:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso1834437a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776524932; x=1777129732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7RKGiZUqwXHwZlcK3riA8O7YRYr98W6ip9NWAR5j7yc=;
 b=FkQ4zhwd0dkCDLhcnWtqH1H9iqLZdnHBwRvjY/DBwmt6rbI31UIYkyUiQPSFQ6jPXh
 tQB6E1Q/IVPI5zKNjazgr+JcDxz20LQOJhWeq/Sc6EZIpwszd+DTzhyCmirlVDLZkbnM
 WGGmbOA4Wo5Uqr12VqH7EDZ8FTRe+JWaVYlNvH8/77Hi6PVEmCjNPog/f+XW6857fTA0
 fczUUL5dPy+rFuJwwsvR5Zn0LjAy/ddAHf/y4ez4xnHjarRkB3jboQmaBk9TTEkoDszp
 6IWVDEN1lvG0Ba3HZT1P+nV21trcAMHsrZYmtJSlYHHaAd7Nh9owB94x9Akbrn48ThKc
 Zetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776524932; x=1777129732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RKGiZUqwXHwZlcK3riA8O7YRYr98W6ip9NWAR5j7yc=;
 b=qQKByRGCS7hDbSN26qrbNVjQPLVkkjuJqZb4sONoVbvYLO3Ztl48CfswA/JqxXDTqW
 LHgZP/50DCEHH+GGvkjfBbvblNbIbYx82PUwgEaXd5I6kh6NgohhUADK5pKFsfOUOMEF
 SUJNAnze2zMKX2N5KMk5ZPiXqAyKpIpMqLPLsiENNEqYVEOcSUZqYM9N2p9iAODxmFSG
 zycuLYANeSYvRpQsga6HLPqu+3o0IV/60oIsa6MnVdy1CMYWTXEOmiSshcU+u0zZ45Fx
 DnE3k4AIPdCD3G1huWBnNsCI+n9lMWO6wHZN+Owb+qMpeWGM000JS7fSiJQIOaCermSb
 53qg==
X-Gm-Message-State: AOJu0Yy2+lzhqK47GH3gbcthKr13AAUo10NCxtxzTX0X8ZTHrCyxsY0I
 SWW8boP+yDR0ZAD881m34cGZQ1fGrDw+2TYwjnbvGAViVL/NBtwkveje1oJtzXK2QHvAta4Vwpv
 X6KXU8GcqeCxdKtuzN9rykjC9dYiefAPi6J0WOMy0f2O7J1Hr0c7hv/p+5K6YZZhbfAK+R0R659
 CQNWw=
X-Gm-Gg: AeBDiet9q25JJoqtkDHRfRU0FmBG2Ts41xdPvkjj0azhxiZA5+IEXHVVd+tZrqvNgLe
 rvOGi9X7t3/MHH4RU+CKDE40U2w/GINn2OflyPJ5aHir+7onIf7mSf/we39xijYqDd4mnR/jBEC
 yEoHY0EuEFfVVqM2VuIbM37uTF6oHRmt73Ix7SfkQI68a9SOk1mGMY7fLBv9FqQ2IEc0UYbPHEi
 F9CKozzfP+1HB0bzuL7uHrpt3DYCR8AXDiAvjNWlIWKVq2uoT4cn1Nay/lLxTpP0fJhp2oKW6xa
 tsxYaR+y3S8TTOiRHE3Zcr8QFSFvN2Iutfv6eDW9kh6tH44NnhqxI1+KXSP8NUrHP6D2v1PdERC
 lEW7z2antEqaTMs47OGyQSXI0rtiXu6oSjGeDqBjORF0=
X-Received: by 2002:a17:90b:3b89:b0:35f:b1f3:ac12 with SMTP id
 98e67ed59e1d1-361403cb172mr7163557a91.4.1776524932473; 
 Sat, 18 Apr 2026 08:08:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3b89:b0:35f:b1f3:ac12 with SMTP id
 98e67ed59e1d1-361403cb172mr7163528a91.4.1776524931993; 
 Sat, 18 Apr 2026 08:08:51 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36143b0dc2fsm4882353a91.3.2026.04.18.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 08:08:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Correct modparam description
Date: Sat, 18 Apr 2026 08:08:47 -0700
Message-ID: <20260418150847.157246-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbokiCE8 c=1 sm=1 tr=0 ts=69e39e85 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=J8kFTu22RRC7rXhO3X0A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 4JLL978RNflnYS_kHwXK-T3QSXXia68i
X-Proofpoint-ORIG-GUID: 4JLL978RNflnYS_kHwXK-T3QSXXia68i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE1MCBTYWx0ZWRfXzC6FsUFtBpCZ
 d5z9r+BxnzsiPNzvkj1Jih3d39D9C2v0ShuJpUEkPGMFzQS2Rd8XYASLNPW7dT1QO4hkvgCmLZt
 bbIkjgobS3iv0E5CFSdxb+6MJ/bBSLP7SU9xRsm871RTmiGajmxU31qF8eVkILFgolFJ9jXhJN8
 QeYdv7SYU94z60NaN3MLZoEM7XD6Hj6JbvPtt466vqK40HaIjC7lKRNOXZFP7HuFLw9YclKRhyL
 Mbfmuo142vQ0Rt5Yd5txKd/dxS5vlIaXF/8+GVI7G8OpNnCDHSEDMHFqzqjSDuACjtUBnnFIzk6
 o55AuMt13kcopPQ/ogtUhdW4g0Un5ceKceWdBGWIJfIpshOmhpU57SZx6ys4N3B37r/4LHI3/Qg
 //p9cD/Rpd7O/d7lIedadS7qrOOIyAHvRhuLemINXKeND6gRMnvjVLVb30P+RrInWpNCeX0f2sN
 eFpM4if+xFILC99CnUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180150
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

Preemption is enabled for gen8 as well.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 770078904182..7f20320ef66a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -17,7 +17,7 @@ MODULE_PARM_DESC(snapshot_debugbus, "Include debugbus sections in GPU devcoredum
 module_param_named(snapshot_debugbus, snapshot_debugbus, bool, 0600);
 
 int enable_preemption = -1;
-MODULE_PARM_DESC(enable_preemption, "Enable preemption (A7xx only) (1=on , 0=disable, -1=auto (default))");
+MODULE_PARM_DESC(enable_preemption, "Enable preemption (A7xx+ only) (1=on , 0=disable, -1=auto (default))");
 module_param(enable_preemption, int, 0600);
 
 bool disable_acd;
-- 
2.53.0

