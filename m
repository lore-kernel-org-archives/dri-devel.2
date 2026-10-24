Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E3606A330
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ2tZ4Gd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gGcNfCeR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357CC10E7D9;
	Sat, 24 Oct 2026 10:30:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758C810E7E4
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8o39Q1166345
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=; b=UQ2tZ4GdoWKQKtiT
 q+FZTNWFJNKLrrMOpwfg+zqTxl5U5pp107+K7cMGpZX8tnoz7m7YLu1flC5Gy/7c
 CP7YFWUmn4B/LFS1f7xo5wyECNEjQAjcm+NQz2Q2ZtR0hM3Gz3dKS82uahOA2aja
 KLPPObQYxkPKQKqfFX24DjEMwP2QR6tsE4HCYZCt7xW0k0q/aS1UJFcWQFt48gF6
 S1Ndk8KM0655S538UgpfnuQzJDsw0gpFG0jJNIeHBSKhxlvh95khEPk/A7nSuXdP
 U+RAA9f2iP/rqtnukJTSQvoJqBfmFwaPYk5JJY8LVefkBAB9t24G5K3DTcjH22kG
 J2AjsQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gqc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-193b5eb133eso2207822c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837837; x=1793442637;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=;
 b=gGcNfCeR0+cnV9YiDl2LkpTNKhrOosqYxz4idcrQaizpEad17KDNultbFGhxI2+uWJ
 Bv8J8rMNcizAxE7OGS1Vlt1KlulCTKhLbegpOZHRmN5e875VXEAPszQLKEa67pAPrD4p
 WKVZRP1/G04gMG2P2eh+CFW84OigfZmx8I6rBbKp3jzYjsqCO9ryQCXXJfFkv9DuNwLr
 aOG6Pi8awwnsiihWh/9vfG6K503cGlpBUIiBFL+rmGPeulV+jYqTTSduCijC2wyr+Yvg
 2ae0RA/VwiCIk8E6T3YO+TdPk0PGWwFPqKJ0j7azL9ysqQa2o3KncrFBfyFuOJKZd5xW
 +NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837837; x=1793442637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V5NtsJrgMbZa3kkzwniyhCS3GJ4Nc1QusU2jPyKMY3Y=;
 b=t4odOdKWArncHUoP01EFTl+y53fWZYgZ/UHAjNyndAEEPCQaPIIYH3CL+87cNjYnCJ
 /eS3MIZ2O+HTNu2ugB8P8GHRWU3R+jvcSutOc9xjO/fKoZRkJhbfiC51OPXhqT7UAaHh
 5B4Iheh1BGaRHe9hKTWM+IYKTMCp2aLVjyz4wS0Z/UX7WvbH/UENEBGOEysYhe8uK8Bp
 VnSI+eh5PXt+GzSi3yeG5t56cgy/+7kTrrkksVQNRCbZhCwi1vYS76R7sWxjFTToJwRy
 G412+xfOFcZWRmHp3ozrEg14e5QK+VDJa/6H1hClqoZPY9dcTl9gesY1+k9mqt7RE22m
 nRwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz63/JJ7CfU5M4DgKrs56Ao0ab54WDuTb91fcVqgDyUBCUSCpZTyP6UeIRDvwWyxjKeuIvnOvtpeM8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7XFXiKUq4S1/OBjG3A75w0T0TILne2hOMUeG3k/mpdt62CjRt
 Sqns85NFE9/F//dDOyjKt6ji+MHso1RvczyHN1CUfB1X5sdl3+v49Ntrf1OTTegzTOQ88fOMIT+
 Yrg6WL8Ge6D/hM3va4tsCnV1VbT47Se7jQpx47VzL+WJ7mEVWktRel3WyG1FjAQx2fN7wT0I=
X-Gm-Gg: AYBFou12KCN6tikPtxnLIHo2eesOaP10KgO6mzNfSyHBrye1N/jxblfg4cwBOZDo6M7
 bftBnU7m4ahihU8fq5SiAuSeNjlw//Zq+0P1bYlT1HNYwxXpY1HQrn/0BTVpmvT098MAx0Fyy5A
 gaU/0TTy94Fkgo3cejARRKOFr3GGq6EPIIXbM4O1oQkguyzazBCY3A006TUlks41p40V9RF0DaM
 q7wdoG+1ScuAfFowlhxmb6yJl0lR3DU8dThsV8Noja4kjdtEKpHyoM+SebBswaoQjfBtQccNdiV
 NFFxgOEbaximu70qY8OsVORULUfeXrjuaqukszTqxIBy05WYtz3KlN9LN8oZIVlTd/KPjfFiWv+
 gHKUP+zadqYrIpspdaQiCqQg=
X-Received: by 2002:a05:7022:5f0c:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-19935437c7amr1906333c88.17.1792837837166; 
 Sat, 24 Oct 2026 03:30:37 -0700 (PDT)
X-Received: by 2002:a05:7022:5f0c:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-19935437c7amr1906294c88.17.1792837836569; 
 Sat, 24 Oct 2026 03:30:36 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:36 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:08 +0530
Subject: [PATCH 2/8] drm/msm/a6xx: Fix GMU shutdown idle check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=2051;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Ow0o4P+y/rXq/ok/jal9ZHL3oAONSo1ouiNN7Pv7Xiw=;
 b=juC5HV09ueBy7MXDLOeymT2cZOTCtGhYie/nkZhJXoUX2FN0NqE+U875EE+/PI+VSWr+VgsGM
 81kh3FlHmyIAM1CL2QC2acFv0jT+TZEM8mvP1lwKI2yVxveA0Vn4kaT
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: Mycyttsa3TgC0jWIy0fKMQLuEvbMEk0K
X-Proofpoint-ORIG-GUID: Mycyttsa3TgC0jWIy0fKMQLuEvbMEk0K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX7/Sd9P4dI4Rv
 JikVTStQdqXxTvxDVAHhTX2NK9es+fChq3lHB5qofoMlwis+xqGDiYkbGAMey/6P5yUS0XjxYMA
 CYSXhduemauqskzNr2ZHJ36tpluq/SE=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc88ce cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=l4a7mcJWk0S3Zsek6REA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX1FF5vBWg8vC4
 mpSZ+2SyNpnbDPXe5wUL42Set9upcu/ShiUyvJ5+0RiSX7P0EDLAM9qxt/6KP9bAcbdshjHMwqD
 LOnNfjuoRgv/MsO7Zwe+X4Wg/jdTpBWJNDAGfKcZjAFptwL1dp7Aqvvw6eKtEu2hbPIXQEUAOX7
 3O6H2FNNm9bhV18CTlJ9sH07cY2C8jN/PoN9K0fKxv3XxVwr0+SsfJbFdSSTCxcBEWA83ktcAt3
 tKiCHk5pvl3ItocRzEgJrUsz+x7MEWJkM0IEYV/V0c8ySl9HQgebT7PHLT0WKS4mynKZ+4yX5WV
 KX0ilQiJfj/6DO8lZiv2ECjzwimW6fAfBsJAe/ahLZfcTxht88gK7xulKrwYnobLILsD3l5N2zo
 b/IuX+DZpQG2/PWJeSGqOQfCG9yZp9k6U6e+6b9hXrCZU/ZJcwu487PE4GvGo4smJmIGEx567TI
 aVVG3aOvoxy9XuG8zQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

GPUBUSYIGNAHB only indicates GPU hardware busy status and does not cover
the whole GPU subsystem. Use CXGXCPUBUSYIGNAHB instead so GMU shutdown
waits until CX/GX/CPU busy activity is cleared.

Also, increase the timeout to 100ms to match the downstream driver.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 4 ++--
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9e02d6f939af..7e80670736a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1461,8 +1461,8 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 
 	ret = gmu_poll_timeout(gmu,
 		REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
-		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_GPUBUSYIGNAHB),
-		100, 10000);
+		!(val & A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS_CXGXCPUBUSYIGNAHB),
+		100, 100000);
 
 	/*
 	 * Let the user know we failed to slumber but don't worry too
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index b3082738c99d..786fd7d2f674 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -224,6 +224,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x23b0b" name="GPU_GMU_AO_GMU_CGC_HYST_CNTL"/>
 	<reg32 offset="0x23b0c" name="GPU_GMU_AO_GPU_CX_BUSY_STATUS">
 		<bitfield name = "GPUBUSYIGNAHB" pos="23" type="boolean"/>
+		<bitfield name = "CXGXCPUBUSYIGNAHB" pos="30" type="boolean"/>
 	</reg32>
 	<reg32 offset="0x23b0d" name="GPU_GMU_AO_GPU_CX_BUSY_STATUS2"/>
 	<reg32 offset="0x23b0e" name="GPU_GMU_AO_GPU_CX_BUSY_MASK"/>

-- 
2.55.0

