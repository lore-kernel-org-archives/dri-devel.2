Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18D606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dNdeDNc8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAb9IVaO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D6D10F7B9;
	Tue, 20 Oct 2026 20:48:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEEE10F7C2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI8B8M1864766
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ocDu9x7a94S
 WPcpzxK16LgiMD4smeVd0t/ViadjFsRc=; b=dNdeDNc8GXRM7M8sFkBYIMZEaA+
 r9lhCv6xgWQLw9rIHRTR7V/RRVgjKVpC+HhXGMGqrSnyZCmtEb97623n+0Aohq7y
 evjAB8HNFK546Owob+djgpxi8Gvdoxsg8doOQx5981p2FlxK+7PdJ5sSI5z57UR9
 C722fXjG75szQaAmfyWT7soGrkF5ry2v5lnk4teksl5yj+Kg+hxbkdJW5IuQgF2o
 h+6FesyC6gqE3FmX1IGFCo2K47yzecuPSIxs4XB2OsgMZGSk1yZoMBYjQsc8id3m
 EoK5yQqqXWKN+H2+Ej2KTg5ik7j/vaYatCNz++QSXZcTq0FLTF2tGgcgH9Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0ghhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so90088a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529277; x=1793134077;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=iAb9IVaOJNtPe8DQELMc9PZDT/2Trnkqg4sPLWf9gdXdbj+yrlzb5rjsux0lYoa5vD
 VQXQfiQJuJUwsaQ0PpTvfaZdaDX47KC/YBdVnOneSyB6vUkpuNsvJd7SXGIxNbXrQFAc
 5ofi8CHXuMshbKJGbU1bAQWKszI0HV0Qs/UNo7JK7vVOsSJxYYV12Z+a9DYESsyuDoS1
 IEYQrWkdzgSBXn+flq5A45C9yKAsqoMH/QBbWU33raFfAs9pkJ3WQ8Xd6uYt1cxa0BIf
 vnY1P57g66oHPKO53auUTYNnoteDLdzsn5cBneJ5ao+GKD9R5e/waFNTIvX7Sg+po3hV
 xTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529277; x=1793134077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=zWdLmZWc1PyONxy98a8J+AT6KIwjA9BHVDKbFiJU8MrPJQgNufu46lkwInWRIo2cjk
 aqo5c8vhRSS8wphHoPJXRsPFrjt+DOCdTUSDf20v5F8mXL75/earu2pBeFRrvTmiqjrj
 U0iElrvcP6iySdRtiznENcm+QnayKIdX2dlOq3plPBa6kezLAUphVkYElXGFhUdIL8JS
 FzMi34RfpMm11+QWbDtvtMn8nKusPpEh7YATIwANF5BGApjs+gbmTzqoEihgvtsKLyxM
 gOrw3OmMqWMQSt7TFKCU2ymyneYkFe65xFn4EVKDkAvpQbdrYraXVyvb3VkBNEmM2Ef0
 F5oA==
X-Gm-Message-State: AFq9FYKgkxtBIR/6kBeci+iSoEC3kJ9Qtppq5h5nWq3VzpmoLWL2jTzJ
 /CAtTodrPWIbzNnt85IhtRXUVjpjojEmXKrpz4OAKlILWkHfmbBGD3Mgb+cS0Mabvd50RqULVSf
 QxBwfKi8t+Jcs8lCjbdhgs+hvlATmJ3PBwmzYT5EbvYhNB6qH/WOLHRRr2HCIkHZES0KhUaFBtQ
 uVG+g=
X-Gm-Gg: AYBFou2+yVbEFA4ctHCD8HldiP8LFm6yvqyFJ9UESEyv/vYNcC4S+Zb5zQfiGiT6lDN
 0BBY1B6boyK8/GAVjni9N6fhRYMH01kTLuY6LdbrxbHAFWv4FkrUq9LYLCX+ilpp7Y9EZ9Jzg21
 x0ABZl1VZcsJGHj09BqBvhH4JRThuTViHyZHvTPPv3t9jG+fPjgek0mnya0CQyF4otsUbH9/QdS
 7Gunox8t4v1IrTgfXTX7m1HkqBkObA6HdOcIbd/aMwcaisG/xqOodyQFTfGXMQfdIHTV3Q1l1rx
 OYmrRWDWI0/ITZbMVEAWDbaaiNUaTdXDwkXuIG/x839GpEw8T6zafgBdNL1DcM37gmKz3+LkPrx
 Fww3U1vYfGroZQr4MuNgZUp/GBHp7rYjyZzHqw1lsmThcwir7/w==
X-Received: by 2002:a17:90b:2250:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3ad86cf2bf0mr99487a91.26.1792529276785; 
 Tue, 20 Oct 2026 13:47:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3ad86cf2bf0mr99461a91.26.1792529276327; 
 Tue, 20 Oct 2026 13:47:56 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad80303567sm1036388a91.14.2026.10.20.13.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:55 -0700 (PDT)
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
Subject: [PATCH 07/12] drm/msm/adreno: add temporary __maybe_unused
Date: Tue, 20 Oct 2026 13:46:21 -0700
Message-ID: <20261020204728.28844-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfXxV6Z9o3fjAFf
 SB3OLHYEngPqKGwFx9tVgpfV1PmIDrEWRG/qO4GMdO5rQZsh7VfJUvoO6sSU7a6nV+12VRmnyob
 0qGxwYutjjloin9PGt1rGDSXEDJAIMyY+dLr/OtY6hg6xbaq/hVAUY+O+ZCuLqeUDYcLUOPydn+
 POd3qqpWcJZPXfE/Se4BE0CWKZpyT/4xBZtk74wXw+Ka8ZOGyTOCdCHEk+ik8sKON1UpRTUwFNI
 9121pwnW2PeB1PJ3+qaFNeYJ2mfeBOl6j85G7uCIu3xlVfmhmm3LzhjpLf7kJ2YSuthOKlF15LX
 /4UOAbO2Xc80hDDaTmM+U4HiprM7jixGsUmsZ9BnTPovWV/WykmiIIsOO9stO/r6+6NKTncQ1RL
 8UKy5LpYU9MwJyW9FjKA9n5SHFOaB1heipn1+mqzB27HYRfinal9Tb8SMiHA/Jm5/Qj4yczoVye
 oTVQm1wDFHHY6DQ9+og==
X-Proofpoint-ORIG-GUID: _J2j9jnHZbyoxBWLbo6j0wAR3aZ66Dbr
X-Proofpoint-GUID: _J2j9jnHZbyoxBWLbo6j0wAR3aZ66Dbr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX3G31Mje57Qs5
 qQico0NEb0Uuo4m4M8OcByt+rcx9DJC0DmjFc9oi7mftO/35ePN8xvzu0Pmf+78FJmjpEIgvRR5
 hEcMITvrebrL8bCw0WEm/eBy9VhLvu0=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad7d37d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200082
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6d6e4c7cf919..c43efb85fde7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

