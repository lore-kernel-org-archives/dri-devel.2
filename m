Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F94606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cnE+5kp2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gxd/dxSO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160C410F7D9;
	Tue, 20 Oct 2026 20:48:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F2110F7DB
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtkdF2278767
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QK2V0ULW7LP
 9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=; b=cnE+5kp2GlB9jWYZjlh4paoeraF
 j4etdh//n0v3cMi6jQx+qLrLTaERvglpUBh/mIkpKbcHPXtGSktQ+7kuZInamF0t
 lWBpA47PNfV3QuGrQBr6Cr/HADzXd+GcrCQlki54n9bEGjCz9wV3sLFGjbNJ10VI
 JLBbk5IpsFZw6k3trXQcAhrJUvJvMuQBwqYCWbBSVFUtnuBjitXmClDemyoVXpXz
 jB2sdjG5+vh0z47cDoqV0tq4+hd0kFTkmPn3lLWIdb1wygbOlBzpkpiFm8POxpbu
 ccLUpVe9UaBBRDOW5MHdGjCHxBv0bljs+Z7yt2YVsTCAeeac8GlYd2En0fw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2a3wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:48:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so159628a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529305; x=1793134105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=Gxd/dxSOaL8Bca2NApHOUYhDDRCCvRljiUn8/OPWNq/vqElr1LuNiZCmuHeNYhNkTy
 +ogvPtUFkwP+vjHPhJdsbVddgRmuM+Hr5AK1fjgHG6WzKO5eEpPqNkmEklBcTbR6pDph
 q3jedrKcjm8FYnTvfgF6kB17M4qQbvYI+cMUEvDVkrSGS95Le5PlweE2m3IsiJQnwZxb
 fuEnislR62uuV466882g1h+RAjXti7R7RLrBYvXAm3GvYWoYaONBR/wCTaIP03omXjED
 N9J/+EPoCY2nEnaREUjo6T1CVNuLYxP5hr0vxH6cTies6U0NnTMWQBxda4+E2R5cUW5O
 7wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529305; x=1793134105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=WUFlbBGJW2KUI4OaRoWCnbuhH8FNiWtUI4KRHm9rjouuuXPCZ5vhvWJmnKmu+HZgdm
 uWJTWezF125KvveAfqZ8DV/a86b4CqcsLlINq+OUlQxCvaZAFSjwdjyj7zFnFelK40H5
 MFGYA3NHxXxd9w2KdCs72h+hcqeokQyyHu92cMDvp05KR1PO8kFxjL2wWzORt9zLIL6y
 A7pWgn/teAJ4WEFVzxMcyqJPOQWIlZJVBrbkANBznHrVyQ12E+lxTC5ucNfXPVLyxmmH
 Ezaw2HUmBmzk9HR1FDPdqp2QpBVtQBm51ux8fdZDSflLWi1uTIOoXfekXgMqVgV3XSGL
 NuXQ==
X-Gm-Message-State: AFq9FYLlifcSIF8DhdczT3iKvBokZwDMO73e4ShTjeLmdHQrGz0NdzUz
 pi9s0mFdTEWxKcyTJx1G7wLfm0v65pr4dISNczvMTt7ARZd4cF693kQlJwo1HRtpSXC+fhqPZA6
 YhbS8Uqv8iwrmjk6uJALC9YkO6re9ZGkRC/ZbNmM7URAxY8WWtM/wb/XJR9p9MuA3oEDbMnT+mi
 0i0EA=
X-Gm-Gg: AYBFou3hyW2QrGNNXjZ5whN6s5i9wApQvZ6fZyjeLZwt9sGBtoEA3/p8Ms8DtF7f1Fs
 HZjdgxzIlW/0oCupF1huyQHZxStK6F67c/L6cZESXz0CbDDZAsLiZB26rBNrFd6S1GJJna9Y5EP
 0GiekX0vh5hu1/LOxry49IW3s+bMl2bV5OmuThPMk2ChHmAIfhvOPSZCE2/wS6Hkj73wjrRDyi3
 vW2/dh5t7HMIkVNyYu8a01P3wTOqCs3vw2HtJOQQYYuI7tYerX7Q0slwXCkWKFbA1w7zUDtC/1I
 29tvoQEN4oTAhZWfhE2qR5zVlJAt/k8pN1fztQWN2jZxFy9fSytWSg955LqvoHcwzcIcTBh2kNv
 DhhfCkIFxD2KpjXvNYSx5CGUM5CJjl3PrEKYiD7UZkyC6jeEU
X-Received: by 2002:a17:90b:17c5:b0:3ac:adce:60be with SMTP id
 98e67ed59e1d1-3ad86f44ed6mr69633a91.21.1792529305165; 
 Tue, 20 Oct 2026 13:48:25 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:3ac:adce:60be with SMTP id
 98e67ed59e1d1-3ad86f44ed6mr69611a91.21.1792529304739; 
 Tue, 20 Oct 2026 13:48:24 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad80303302sm1045860a91.11.2026.10.20.13.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:48:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/12] drm/msm/adreno: Remove temporary __maybe_unused
Date: Tue, 20 Oct 2026 13:46:26 -0700
Message-ID: <20261020204728.28844-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2XxLs2uWdbQNOMEo3IKwicGrivZnGWFX
X-Proofpoint-ORIG-GUID: 2XxLs2uWdbQNOMEo3IKwicGrivZnGWFX
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7d399 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX/5xP0QSgonCd
 subXupqOgcdmR8Y0ShHf+SxD02AaTB63w0yMt65YdWJvc+E1AlqJ3Nos3brSwEUDn0QWgM7G+Qo
 +63LNTVOhwnonFvf14dCLyXFu1sFwoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfXwQku5zW1ARSl
 AVEdVGsVGyUPDJZ2Vs9gMwUAfQz1RUlSRMTlUDZkMW3SN09Nw0TM9wYrAhmIKhC4ZxpZbQDv2I2
 vQC+Ud0+njxkImlimFsAjPMxd07uD1zgEUW4Wtd3juFZQwzkyi2veGLR/9GysaF73SZPKw16IXF
 GtZxTxVGuWe3HVwb+dWnkx4vd3GsAYU9zCWHVklz1oEd/oA4AIjuL/4vi3dARVjYwyVItE/bCqY
 xVakMbKSqA0EFVxmUYC08U6iqugQkHw2IEmO01qYZ1631YLk7JAUStaQmE7uq/Ntk/L+V4RjlYa
 q9DPr8GR9gHrvOQ+kmzEO779is2srT/0nrKkZqXpe+pfT2GryTuCWPRhd75752faqsla9YIo7xt
 ORdmTYFmu9sAf8grvOB1uLe6byxh+zAypSGr7T5TGE8jOII9t1Z28QBmj45KJuPyvvbkPKoQUxJ
 13nw0lJ9GlOlLwfHn6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200082
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that is unneeded.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ed83dd927b54..3ef3ac2d86f9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

