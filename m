Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF3606CEC1
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SeOJnIQr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GTffxc5d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877D010F0D5;
	Mon,  2 Nov 2026 17:20:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374210F0E1
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:20:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2GZ4w23479993
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 17:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DPKvk8czbS6
 2fbcTmg1ZaSluRYceZvCPw56cZbEA6vs=; b=SeOJnIQrqDzYsLP6avWHcV/Rcf4
 8TuVu6a2mZujaoW3QTz2wxf9MS3xpFlegqU49GMlh6qfMzeTTMMgR3pxJdDObJPD
 BjBgIVyc0H75bdK2Y7E4rScr7hcVlw20JcZ7IcPcifSagSV2E5q0BXMeKwmFixoy
 WZFD6bXgxAwgC30AfAWDFXXvxo/sV6Y0ykk44+gZgF+7yEUM4N/OJcZe/JsRdnVy
 /30HutOk6W8KGMPMAUwwhQKOx+RdDpCVomoGG4ppOYdRP0u+45mHtzGUCTI8uyBb
 ZNoJQkqHYdJbMQReO1/wpywO4J4/yNmQVRMVjN3n3vo7eqJL83GJHDtnaKA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rk3e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:20:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso3878930a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793640012; x=1794244812;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPKvk8czbS62fbcTmg1ZaSluRYceZvCPw56cZbEA6vs=;
 b=GTffxc5dFgHTMjPQ/fBjRlMZRl2qTG5eMXt29u+yrzGyoJ/I0kksIyTKNWToL+27Zc
 G8xyX3oFVtqhYXSgixFs5ls8cUj9uMT63LAT+20ELM17pzo2r1Ybkqu1uTDIuWwg1NVm
 McacjlnVHN7rt5iYEBPJolkJTDm0Fe64b2g5A/GdPcFC96DakBL6FpubGM0gHckKZsS/
 nFQOFUjse4QDAR/e9SQIZ9G+8VsdBC2QNIw83Ejb8tF5h7VuJuyXTSS6ZnzuCkS/3hKr
 BDWtt6K/NQOX6D6UZb/TrdAatg4sERDHdn0LTKSWgGezrFJ9YOcI0A3h5BsHcs2aHS1G
 zh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640012; x=1794244812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DPKvk8czbS62fbcTmg1ZaSluRYceZvCPw56cZbEA6vs=;
 b=uES+MFcXtRJqJFnVwe7TUmAVT/maTxjnTE/7nXgj/+egI9zjCYTHAPHdrwmnsfwB5P
 3lVec2LSICAbEyjQQhrXoLQdEVj1wvj45TZdy5maFW4mg1fKLToHUNoPlc8zf0ju18sI
 oUGJjuNtQ0jZtFSLy34LyHc1QLM7rTnc9jbuEAxw5ZSqe+BvVAOonMFISBJ6P2SjCLqZ
 uOADha8uSJL/r/6/3JK22b2o7vfbPLSvjy5+WrpimSFsa+H/lcXkVRAMWOHgnLVXxV1b
 ObtuMD1mj55vzyjeMfXbjdy0Gwf/Ry7UgFXAfUnKNpQyZdVdxt0wo3g+uzrbZOFo9Ox4
 4bmw==
X-Gm-Message-State: APuU4Z+DLYc0DbMPrbl5ACN6J1hePHgob9C8o4WUOpn5Fxo01g5h/GXz
 fhRVcnN7Fd58T6fQsq8aiFFBjd9LumGeBmnDUH1r8uPmbkKZezw5D/LDjYmBebEwqDU8nRZjwgH
 0wIu/MPnNXIT0L4qIVwmmxbf0vhsRRTf8bCYTqUiq9xkjDcXgn/hLPqZWIbaYpPfqD7K9lqjs7J
 0BtmgAfw==
X-Gm-Gg: AYBFou3v5dxTfUs07toG2VnA3OhbLi+4/Q+Nx0xL+U3ObJfO3xXbmnggkwk550CXtXR
 Ao1iaEo0pUNzEdm4WLDms9RGq5Vj0b0KvIvr0kuxz7rS1gFTDipDWPschzl3/FLiuOzR6FK54lk
 Tm/3GEM1Te1a4I968pQaZMYKjktVT2H+BocFz/hX01TlF3eCuBUuguBvRq+YqQcVUZdo8DgUHfJ
 x+C1R/gXfz5LYRVaULG0cmE95jIvFmNgQWmVTdYJ0J9tp3APn8ff7wrixKylrw72mRhVQ2umFBH
 AS+KDV6Vv6q09A/AL2O5i+qrAZC8j+F+2QJUFAPf7P4ZoQ0Mczhxzbgh7nNqNwQD0raT12s1SnE
 /DXZbwC0iDOLuMeMD7EkhzdscB1tIe7o5zlTvniHj8ju0QYzYZXuO7i9Vc3FtyX4hToOktbRBBL
 oPBvCM8k8IjymPXl0lGz/sscI=
X-Received: by 2002:a17:90a:a68e:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3ae898166e0mr6719677a91.31.1793640011948; 
 Mon, 02 Nov 2026 09:20:11 -0800 (PST)
X-Received: by 2002:a17:90a:a68e:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3ae898166e0mr6719665a91.31.1793640011535; 
 Mon, 02 Nov 2026 09:20:11 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c7e087csm61637a91.4.2026.11.02.09.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:20:10 -0800 (PST)
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
Subject: [PATCH v3 4/4] drm/msm/gem: Clear nr_ops in lookup_ops() failure path
Date: Mon,  2 Nov 2026 09:20:00 -0800
Message-ID: <20261102172001.508440-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
References: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MqkzzcLUGGTugoYkh4H7AbIPk10Eo7_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfX/QEYAHedyJHH
 rHJM1vn2SlEC9L4sONcKp3h25aklWM95Jy0ZM0RTjPx70ChkP9QXS1R+ho1e2nZeFUcBLyxzRLg
 mXUqarBtT7Yn6OD0mXkleA39o/oHTcG3DX8RTaEsFmeteZzcKj7WWryNJ7nQkulZ7U9g5CvZ1qM
 2WvYuCmAY7XD2eLEQyxXylb/Yr6BI0QeVxHSAmfvVZF/8o34+w5b9bLJvvRtsIJJLI7SqfhjC8E
 pUh6jTzrf+GUMPs1lD0J20g20bPHEONHLfov7ZrHAh0FE2l8TnUu/GerDQLn3uwF9YgYiXofBqA
 cwI7ypllM/4suDUN9YZ2toGSh7Fah44n3GYCH89xgVcQmI5gD+4atOEIWSM3P7OSVJRTt1vMZfH
 IiEe+h5V/qQTeBMtpP6NJZR8aTyPWGEG+Tosb8SHLQC0fqhuzpvTyOisRhPEiy8St5sd3lMdAQC
 udKlky+SdUPjC62xs/g==
X-Proofpoint-GUID: MqkzzcLUGGTugoYkh4H7AbIPk10Eo7_x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfXxc1j2QrDhmv/
 pJ2QNLvo0eoUBKjP+vHgWCPWGWKyy0QqWoXEa3B69wyjkNcDUSpXI4kaLsdpwGPhrolPL27ONeV
 2gCF/tefDRJTbs5f28w8kxmM0NNFIBU=
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae8c64c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Q3LUg_9hO3srVFazYnoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020069
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

We've already dropped the references taken in the handle lookup loop, so
we don't want to drop them again in msm_vma_job_free().

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3177461d7ad0..8b702422030a 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1088,7 +1088,6 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 	}
 
 	if (ret) {
-		job->nr_ops = 0;
 		goto out;
 	}
 
@@ -1143,6 +1142,9 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		}
 	}
 out:
+	if (ret)
+		job->nr_ops = 0;
+
 	return ret;
 }
 
-- 
2.56.0

