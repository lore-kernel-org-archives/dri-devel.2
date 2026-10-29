Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D7606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V51woe7Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egiutS21
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089A210E758;
	Thu, 29 Oct 2026 00:16:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C10D10E758
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 00:16:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA1L21512904
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 00:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FVZmdezsYb51EkZEyzeJ8dV+ufA7UJom5J2
 D4y7zwYc=; b=V51woe7Yjxtg51tV2f7EwvVl8gQP9G92ub519Y9jQgk/3dtUUo3
 WaDTGRw4AmwJ4KQCq2p+7k+xEF99QAH1VDjpYIAW9tGRtZ/UIBsKKBI6Xv7qGO56
 xV+8y5Yr+6S1qOl/XXT+LWOkIMjkmK2FP03/QniLUtKBJYL3qoWKaBXWhGEbxgMf
 CZZVe0bsyiLIKdhHFejLKxJf0kOOHPn8voahVimlNEEqpJ0c0Mk7CETJd0FgFVhB
 5LANraUAHEaVRMmSxivwe9KReohpfk1m8UuGHel0PI4o7SK1M5cm393bT/wqzB8s
 fEae5zTQK1AkTqtZGHGXPgfQF+pWHbYLloA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb29fsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 00:16:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a05b68f851so164259b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232967; x=1793837767;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FVZmdezsYb51EkZEyzeJ8dV+ufA7UJom5J2D4y7zwYc=;
 b=egiutS21n3H586nkD9DMCAJeZC/DJs5hJyMWoadnRkBiXJOUqRyvqG8yFU4vRn3ncm
 DZt59M6r6X1IOwPMjTod+F3eMT6TGc0W2ZdLpINs+mCT+yESauZr8Ye82XGb5BuVfnlB
 aXB8d1oWSG90WhB5TbyuAwP1/iq2S2tH4oj83iHvro59Qcf2/tkz30IXAhrVbPhYdNuo
 g0sMmyjBG7RqUFUZhh/lK9M0b2r1J/aVYwIoe8oAWCCuMBduw2i/Y74WknZiKkdYfOfB
 m3rk6dUpLPwXjylDvN860xMwYBGV+aRhRfia6PFPWyMSWGRWIS03t7v8P9DdgSHqmYhI
 Ii7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232967; x=1793837767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVZmdezsYb51EkZEyzeJ8dV+ufA7UJom5J2D4y7zwYc=;
 b=GqlmkSTMrWXEjM2Zg+C88B7COhqtMQ7//0I74JqYgWEp7SN2aszBdC3id5/lKh2EUq
 cMyxEiTyrr4MifdYShJ3ddzDKZz1G7MtHJP2fHAqoBBqkrHhe2QmKeJDBqRyfPxR4L/S
 XJZl200zXlJNg4B52YdaWYDsUOTvsCCZwbemuJlTp3xyuSbsRWTPRlPIjF4CrETcDfjj
 bVDQJNPUQjWtExDCDmIWJ9XTqXEUvlNHHDU12r3Od3Uv+Jg+RyWRlhTpao68Mo55s7+v
 3pT5hEE7YnTmagq7H2XcATpy/ZXNMsSrwDyvA0SeLvlynpzrhqcDfnKI2H9etTJZ6M2F
 v0Wg==
X-Gm-Message-State: AFq9FYJHvHEn7CiKXidclZGYZb8bB2ol/y4KX5KS3Ri2TmTtozq0gFVx
 N5X19KSVe16NHOcIFrzlu/bNueCRnO+Ue7jfSnyC+tobaZEynrfJat8eTGRojEBghpiv17ccIEN
 0Ts0Pz5z7ZznCUDIfppQFiuTbtsqtukLIW/f32811mOhbqL+j3e42sbeD2McFxpnNTJ6/MK17uJ
 dn5A0=
X-Gm-Gg: AYBFou3HC6O9BVIo72ES0VLfWT7YJkCZiwYsLfP4GA7H8ROYka4ZkEIVPsBjnYWRp80
 in2+mu/F0URy4zIFaoUBqPsFcXFTPpp8jyvp5+1EAqUml9GbbPwYFnr8dtK1Cxbygl40AzhKq8h
 bPIETiUKHp4wPg+W76HSu0emzpUl0YZT7D3fd1Wj4noM8CURGzIQluxgGaX5um03KQ1qBDompuB
 K9fuBtIEJKI5+ibajOjrbC2RyP8JCumqIaQKZaqosep3bql1CtsLWmjqVcqrq0zyeZ5+u/VPFNr
 tUiy1LdsTc4pbMMYknySCOwNFc7IVzO+yanTyA1M3B4Rr5VTW3L4Aiv/K73VMrZVbnfFh2a8AhF
 wxXDWuGPAWEFT6GrIG0fuijwjlnTy5zEKwQMov/6GoKF6eyA9I7ZOEd73PDVSyTU6qsMaXoiBw5
 pPhz6D19WQkAPOj2TqZDds5rI=
X-Received: by 2002:a05:6a21:4383:b0:3e2:157f:681a with SMTP id
 adf61e73a8af0-3e913bc2b3cmr636193637.30.1793232967097; 
 Wed, 28 Oct 2026 17:16:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:4383:b0:3e2:157f:681a with SMTP id
 adf61e73a8af0-3e913bc2b3cmr636154637.30.1793232966222; 
 Wed, 28 Oct 2026 17:16:06 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc90d74sm4508324a12.20.2026.10.28.17.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 17:16:04 -0700 (PDT)
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
Subject: [PATCH] drm/msm/adreno: Soften no-firmware message
Date: Wed, 28 Oct 2026 17:16:00 -0700
Message-ID: <20261029001601.82269-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae29047 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=3K5eXpJ1Jj6lJJV-ZGAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: L54OVTGo446JduwaIpmFYTTzzYD13GqC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX5khb3QZyzftO
 BP5BaCiHTQOStGOi2WekUxpV3XNze30JNa1pqHN8CPr8JaVQkKcJbRluiJyItabm+AKpPWWL2/8
 CgEn4LPM/u/VzJwqg/SI3O0pCpMHeF4=
X-Proofpoint-GUID: L54OVTGo446JduwaIpmFYTTzzYD13GqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfXx7IhEv40P07A
 xR19dqN/5GWie71O9e60tO1o6ODOlHCqcQXqwlFl1Bv6Xisl/LyrkuHkz+Tod/PhKNII26YJQIZ
 qVyysLhmzl3JDO68G3Df6/JbpoPiVZvtZ3K6YC2xrwD+ArHh7yIPgFruC51M/nWtcc4SAuPRTCL
 l5BdNLPMdPnLHrjdn53EjIK42tLB3m0yGhfoI5u43DLSYqp0DMTy+lVNklWfvgt4WymkxH1eXtl
 eA/eqGlAy7YqdEagsiX0RkDjB35/qafQlTfEKF+uTV0cZwSMooq4wcsvHUY/2FpV7XJWntBqRmt
 FxS6p6c02oRmy9qfcYgdvIEET5fFUFYy3nn4shiSc1GG9iEhBk0Zw8HNf2n3yKDURbnt4enKfVf
 I1FAcl0IaDSw/r2E2tsHtytgv0i50YsKng25tatbSRU8/85iAdhfkz32lW6egelSdq7rUf7mTAd
 EAnhJ0jn7xukDxevjEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290000
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

It isn't _necessarily_ an error, the driver will try again each time the
device file is opened.  But if you don't have GPU fw in the initrd, you
end up seeing this error message at least once.  Which seems to confuse
users.  So try to re-word it slightly.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..6db6cb7eb287 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -558,7 +558,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			adreno_gpu->fwloc = FW_LOCATION_NEW;
 			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
-			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
+			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
 				newname, ret);
 			fw = ERR_PTR(ret);
 			goto out;
@@ -578,7 +578,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
 			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
-			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
+			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
 				fwname, ret);
 			fw = ERR_PTR(ret);
 			goto out;
@@ -599,14 +599,14 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 			adreno_gpu->fwloc = FW_LOCATION_HELPER;
 			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
-			DRM_DEV_ERROR(drm->dev, "failed to load %s: %d\n",
+			DRM_DEV_INFO(drm->dev, "failed to load %s: %d (will try again later)\n",
 				newname, ret);
 			fw = ERR_PTR(ret);
 			goto out;
 		}
 	}
 
-	DRM_DEV_ERROR(drm->dev, "failed to load %s\n", fwname);
+	DRM_DEV_INFO(drm->dev, "failed to load %s (will try again later)\n", fwname);
 	fw = ERR_PTR(-ENOENT);
 out:
 	kfree(newname);
-- 
2.56.0

