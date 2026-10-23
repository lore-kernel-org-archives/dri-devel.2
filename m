Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D9606A320
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W4iKzqSM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SBMCWt4K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B48510E6A7;
	Fri, 23 Oct 2026 15:32:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C946D10E66F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6JgF3557712
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=; b=W4iKzqSMqHx6B+lv
 BBgeJIjHNZNzLnkJ8AbQAoEDTWTWFjcpj5GMBaJrV4zGinr7ype6ZcJg/CzOzEaI
 FAh+nOAM7/dL89wxj3d8pQn0Lg9mDWHNG6z+0f8XXPHw4LgDQmQFo8S5KcPVTugB
 FwA0XUwKGzmvbbWajzS8feYGGXqceO5wrCKsZjzy26WjEMvpqIjGUcp6LB0Fp0k1
 L5xdUseQiVlpv+vin7tZanMXuiIHVCSmokI8YyeuITeiz0MCzBjTsRMG19my1UNn
 vTS0MuQuCDj1ALYaRpnX9jPE9aX4z6kBiq8d6Wv0pQDgW3sJ8aH8oK3/SQ7ys0Ef
 rHYfOg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjcbjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:47 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99082f450bfso873292241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769507; x=1793374307;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=;
 b=SBMCWt4K/oV0ODpCVtNDY+9IOkTC/U8BBmUx12sdoknyY/D+2MTRtV2oVqaMQgXqpP
 VlCn6ZzsHuSbULhh3dMw051tTKV9pWtCCxPL79iXLid8jzsN0KbJA2sUWVpBx5kLi6PX
 /2Zn/Rd24gJkoNVQlG/MFd9o70c1d+uPRwiv3d40PgveGyRLkwCfJrLIf4kG4B28uvXD
 SDLmQdtq6oFWJsT7k5aUtdFn/DJoiB8oIfvQubtsOgOxJ7ffvPOU9tuCoVrUxyl6/TGn
 dd3Sp7+zXRYHOZubkrv5e0kqXTOQtTbXk35iGuNaZBTJu9R4SQJKuaxWKz3wso7EIp0w
 U6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769507; x=1793374307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PImYCQgikueColtwmltOpJlwc8bGmhUG6ZJmVEsXAFg=;
 b=AC0BV/amuNV6kF9+hOU5RihXi+UBDUir0i74qAB639Lyv7YtNM418WqE3WnlwxsiI8
 Xmle+OxOfdwZyaQgtn9Buqz/an42mEbGj5STn2iCO7buTxmVkhwPe8gtptQfVYGr2eDp
 1qPiCZqaDjSLjkIKC4xPMvMRPMH6/MQxmcQV3d33k1nU0zXcbyltd3bV99euJE2PubIm
 qFjxbtXR/rFPmvhEyl5c6MaO8AX3HBd/ZARJ8UAvr1nnfYArv/ZHTWsIowk37sAbYpD9
 RNO9sPdL+iFx5owXm2Tripl1f/RKmKpmao59rpvrllh2BcqjdGTOXFsTu6vMwEpJ6oAq
 lDiw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBAlO4h43Vxjd4fywyhFCKrXTDFizPWAQrcbvpfVASNaoi26483Fu/QOfdjJyrtRG8M80OUs4DowQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK05urAaWaSqgd5hGhousi5ES1c60DyGxCIikWVN/KUxcqQPGAq
 +U8fGWOTZlnmYgTAGPaUfOpYPpSkhVJYEQNB30FxKcrdX0UuB9EuJKvlttSeHtY21iIHKmHGeA+
 8hmayEhp4AOMoozsGMZr5nAgooFEpazFUXUA11sy7rv3IuZKsc4MtGCkprEC5kL814N6lCXw=
X-Gm-Gg: AYBFou2gPKQCnLJUgskhaKZMY/JR9B7uttwK+q6m+fTjYhLx/O/9KqpzOGhmcc8kczG
 1PX1SHaIdqGthFgVm/ZXCQylJEZtAsCdrJkf9kOZJM8QcsH+q2enyFGcKq+SQnbfee9H+NBe5zv
 6xqx++G33sruIuDqLDCX03qcK/ioLVr5ktMn0i1s/h4geArtajRYulriptu6KWK399XnFuRHsX9
 UK9+GUBswOOnaAPhoUDgDo8uhZ2YTdVWV3y71i2/h6Zl9RJn0gSNr9eEOV0YzziXXaP0AAQL3Pc
 MPdZaZ+0qYhXoamCoILPfLlKyMjb9R02TaJGexDUqkvF7PEOHr29VI+4qrgNt6iD22ev+rpkC1Q
 1BNi13427hExIRGo2OiF5c9nZ3A66p20cX5ywbaQThIF60CrREiXI4mY0KZWa8zO46k+WYrbIhn
 UWQjlrpdhMbGTU
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:f062 with SMTP id
 ada2fe7eead31-7ccc32e6f1emr955172137.17.1792769506972; 
 Fri, 23 Oct 2026 08:31:46 -0700 (PDT)
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:f062 with SMTP id
 ada2fe7eead31-7ccc32e6f1emr955155137.17.1792769506521; 
 Fri, 23 Oct 2026 08:31:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:17 +0300
Subject: [PATCH v2 02/14] drm/msm/mdp5: forget the hardware blocks of a
 previous bind
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-2-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8zzii9JdhRdB7nBZfP+Qff9ThpfwQO2kWqv8U5qv/u0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233QvLsI0SSlFav7kR/7r5wVbXfXkQvPgCevQ
 6zBaDsxECCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt90AAKCRCLPIo+Aiko
 1fVsB/4uE6zB+ZCeEPSsh2+l0rlt5kzuzPpCdeocaGaRJoRySeT3WIGe02Se4qOsnW90nIpKjec
 E7CInyhY8fDDp5M28T1qqijTDyeoqPGCaagDwxy6FDPjpOXH1WVJfrL5PdaYGIHWIqzwxVxNcf2
 0FPBahxSKBnsbx+uafnSQo6HqfAS3Lp3eGaVK97nijrQclB66p+4d57GGuIr7/FeNcCupib2GGT
 oDK5sNDV36ylSApCzpiSDonphao2FIAwyaUzQhY09+Qm+RhRx8lZOOkR/v8JRSPFtuQQI8BvdQf
 2Cls4LaGRNMnm6cXZrQ2vcioRccLaV12rOvwTkfD94eMoDBC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: c9sMzQnKv8rT6MrLC91olLBtq30A-j1y
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7de3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=X8-H6Saci9yJdrauny8A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXwX63OEuJnpur
 bd883qXFOsYQ5PB97oU7/f3FRXwKE9Nme249d161OHh3firWTvOci5I/Wi03fuazdO1yHkDxFcV
 udROTRV4Pspl+csw1GEPP+UrdyLmd0o=
X-Proofpoint-ORIG-GUID: c9sMzQnKv8rT6MrLC91olLBtq30A-j1y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX+YHqFgz3zFeY
 BpQyanxFZU46tKvUxWOAXdxdr7L/jpGgUDidAHsA8pYURn7GlYHuVXFkSypD197cq3SN/XP0Kd5
 IlUnmN5wgOOWXwTBrTNueiSKXwz/ZqeprMqlU613HYfhoC9kyln7a93wGQeHtTilyKQ5X140KET
 m9thk9ct42lTYPy2ozjxRKfhOEk5mVplJb/5njNmNXT0GM/uYkxyfNCTzy25R+JL0ZiBiHVmGWK
 fBL2DEwik6tAsseFP3Gy/q3PgteDw+hXaKaC/BrsYA+zrazNSmb9iaQzbNqny5PbfWQ8PbtVqcY
 8WU4Nos9fORbHQ7QUQQo7jWJatf6nKUN2z1RTlvs15SHIDjYTboeiPV62p8oMvRSaC9jU47kkgB
 LdceTJSbmFwWnSsm7nZz+q5xgGeOpA8MTC82imB+yQPAB2Mj8pXDXzYbj9WQ94pCrgw3PP+EoKc
 Bn62S61KIhNksetyFYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

Binding the MDP5 driver again, after an unbind or after a failed bind,
corrupts struct mdp5_kms. On DB820c, binding it after a failed bind
oopses in hwmixer_init():

  Unable to handle kernel paging request at virtual address ffff0004d411f9d8
  pc : mdp5_kms_init+0x264/0x7f8

Since mdp5_kms is allocated in mdp5_dev_probe(), it outlives the bind,
but hwpipe_init(), hwmixer_init() and interface_init() still run on
each bind and append to the hwpipes[], hwmixers[] and intfs[] arrays
without resetting their counts. The second bind writes past the end of
hwpipes[] into the fields which follow it.

Reset the counts when the hardware blocks are torn down. The blocks
themselves are devm-allocated on the MDP5 device on each bind and are
only freed when it is unbound; that leak is left for a separate change.

Fixes: 1f50db2f3e1e ("drm/msm/mdp5: move resource allocation to the _probe function")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..085c23820f46 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -570,6 +570,10 @@ static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 		pm_runtime_disable(&mdp5_kms->pdev->dev);
 
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
+
+	mdp5_kms->num_hwpipes = 0;
+	mdp5_kms->num_hwmixers = 0;
+	mdp5_kms->num_intfs = 0;
 }
 
 static int construct_pipes(struct mdp5_kms *mdp5_kms, int cnt,

-- 
2.47.3

