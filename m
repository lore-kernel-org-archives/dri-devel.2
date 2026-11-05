Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFA606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ckzXCekG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWcuQk83
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCF610E33F;
	Thu,  5 Nov 2026 16:42:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A8810E33F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQI9n494685
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ze3u3lgW/Uh
 u08HGG7LLB4H8V5Md7DfsDjlp1gfGKWk=; b=ckzXCekGh2W61R2QFB1LVxLQMJH
 yW2kRQ5LF44B4c5a3TLhDUJWEixm5N0xixypY7dwtmoVTat9NotuKel9bJ5ha8eN
 CuEbTjic1eBAPQUr66pW5qcD221M1yJZSINJrt0jYiKAgncaJxOKofKA9/R6wMbl
 VmKSsN5/Wj2QYIB3gG2xWcs4FWyzjAwP2AM5BC8/OcLsgNVnslicjyr+mEzAwSEy
 o9C7CYmeeYQ4b8fry18ReVX7NQhWxVLll5fNNwwPgys7VQnHP+uf8m7f8b2hUQTF
 zFjGk885vtGtPzF4dCte6wymLbLg9ES+OQDcRF5eSv7XCMmVMS24Yk8FhRw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhksqv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd65285537aso950429a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896927; x=1794501727;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ze3u3lgW/Uhu08HGG7LLB4H8V5Md7DfsDjlp1gfGKWk=;
 b=hWcuQk83XP8WjjhxNaJPo8H/wlN+SQbnALsWJxA2Gqx3w6aoMoZyz7itlymyC1Uv5X
 LQvf8SK7Vfwob7cJC0kBAetTBlKLOu6VbTtnEVLJDpQK8bwOrMWclz+1A7+4ZP38cJW6
 LX3QkrjdJvL9HcwnF3oK8Dy6ZeFTPN/YUXofdbVdUFF8M9lUKCBUQo3xrf+C6BWrOtfF
 SvBWQycRvRo4UWG2MbfAp2ELbNLFJhsEfu6jpj31CbjHFTCeQI5QD0+C5nczfc0F/Dov
 9c6eHRl2OsfSG+rsMS5fYQr5+pvJWl6jwgOMyExLWMzDaUNKi594T4BOlfXjgOLAqkAe
 z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896927; x=1794501727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ze3u3lgW/Uhu08HGG7LLB4H8V5Md7DfsDjlp1gfGKWk=;
 b=mhPe6LuKGWnosGhj0y+EDCQ4J0sX2PCaHq/pm/FYxlet+1FwPCET2X3nF+E3oBeoBF
 +y+nLJotA3jacN6r+SvwlRXi8kBBGD3/e8SK8r699tNVFrjnJSpgPpN1XDuDk6sOs+xB
 DmWiicYX8QDGY41hiFXWbWSjbnWNHD02IiegCOZV3WD8xzMZQ2t7+smOE6qECC+lZMQL
 a1F41vrRVO7LgoZeHf68AB97gYAXfawF1MCivO+kOd7TarvndguV40aZUX6upvgxrd6W
 jCI2ipofMjMih6ONXpZh2zERV/9dMvmG6tNBDIXpBlXogJylsH25LmMmPkkXV0UHCoQ9
 GLlg==
X-Gm-Message-State: APuU4Z8Scoru3YcXBSV7Q5SCC6bX7QI4Np1H5oPYg6Pe3RzlQ3rudsW5
 fkGC+jXhouM2XDPL1VirpK1DVcA012Olq7Av6LfwGDc09QJFzbI1OuJBMDBzHS8ztRvopUnORUG
 E3kZXmhxslow6iZsT8OIXtrS4XaXMJ+OqpfwXlN02rIhatInk5X6QNNQoLTunP1RCzDWqvsAKCX
 yMEy0=
X-Gm-Gg: AYBFou06KYopZoZKKVAOI7xoi//OeyuwzKbp7GImY09hiixKTJ9OjoGG73CUZoIMEUX
 Z0bsKGAjBvF5Ak4pnuhLF8VZ7dKolTb6jnU2seQJ7hkyLLjsPN5naXLccMhAMufWI6lk1C5FROv
 iLkiTAv0zX7b6kWolnI53Z3EU1K7re+z+dXrQS65fTEGRzfAwoOTXzjJyMGazDtcQyfqyB0D2iq
 gP45Mad7MkeRuPssih5lDrsw2RslSa2KBn5Em7wxb4l75MptijwngUlpiqrk5721Ua3LYPhA8P0
 nFxGZEPEniXgF1L2m1EFNrfBORxlNd2ub/05hEkIZ5Ce6Xa9Yi2nFSVWmTOXMbm11pO3KWhpLtp
 WmMiHcc0zgBF4P/2e+uWMRxXYzVzCwK7/BWm/jFfhsAULz5BI0amN58OMnYSZyHResECFQqvwqQ
 cM2muGddBciOVNtz8QD6xs5+tNnVRlC7sjkdN5rM7+gs9LvCKWO6rdpTefjl+h
X-Received: by 2002:a17:90b:180d:b0:3a4:8c41:fab6 with SMTP id
 98e67ed59e1d1-3ae8983f058mr16924437a91.46.1793896926687; 
 Thu, 05 Nov 2026 08:42:06 -0800 (PST)
X-Received: by 2002:a17:90b:180d:b0:3a4:8c41:fab6 with SMTP id
 98e67ed59e1d1-3ae8983f058mr16924400a91.46.1793896926095; 
 Thu, 05 Nov 2026 08:42:06 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b90def97sm4175495a91.7.2026.11.05.08.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:05 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/6] drm/msm: Resume perfcntrs after hw_init
Date: Thu,  5 Nov 2026 08:41:49 -0800
Message-ID: <20261105164158.23263-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX+2ZFG+3dlGme
 r5ttJe65U7o3Le72x03D4QzSEfUO4PotVz1Th3W+4BTAuhfSdNHK67xcbvsEuK/XYZ+zo9i7ZIO
 PKyEHlRYboWG5nQg7nRxJKhJG8PfK9pFX5D3TQ3Fp4CRsS3OZYp0z8kWRRGrQJOYH1DySVpneB5
 /9qvHoFzVFKyirV44w0sXyB79N2JDkNE5gnASg00QAH+Icp/3mFpCWrbKKJQ7ADhhvQ4GmIva44
 i9djJBK7PusnGXtVcIAHYTM0Ua5UFoOKYxYR4pfU/309ZoHxEktArF99H/pnqag1JB1byjPmTB3
 ARttZeaL11A/T/CQyvUsGJYwStQEkaOMJiPeiszKF5XD72ZGfIBb/C9UDSEIo5Sf6P9jcyDeva/
 ZQa2LG0lz/0llUcAPpElQcwBmQ9oooWkZWFtyTHHxgaLzRjjqMEwlljehCxT5ZgFvUiwecqGeil
 VyWU2q8A1MhubM3ofgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX6cDZb3Jjbo5V
 mFLzQfcbH5WoBu5VizMri48/p/oHYJc2ZK8KTecbkLc1S+xLZt7RnH7VwhUhEoQeHqtk2eZwQjD
 dsOYVx+/axAc8mRVeoSDjjnULsXq4SU=
X-Proofpoint-ORIG-GUID: qRNVmPeUVar4Wchv6FgzjBUBWoH3ii0P
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecb1df cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=QD1EvTAd08FZB_lsx5gA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: qRNVmPeUVar4Wchv6FgzjBUBWoH3ii0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050066
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

It isn't really useful to start sampling counters before hw_init().  And
the next commit will require IFPC OOB request to come after hw_init().

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  5 +----
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  1 -
 drivers/gpu/drm/msm/msm_gpu.c              |  4 +++-
 drivers/gpu/drm/msm/msm_perfcntr.c         | 10 +++++++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7066be3b8e15..a3b2440a1a27 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -315,10 +315,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static int adreno_runtime_resume(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
-	int ret = gpu->funcs->pm_resume(gpu);
-	if (!ret)
-		ret = msm_perfcntr_resume(gpu);
-	return ret;
+	return gpu->funcs->pm_resume(gpu);
 }
 
 static int adreno_runtime_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 54f337475231..f9a546a2cfb0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -722,7 +722,6 @@ void adreno_recover(struct msm_gpu *gpu)
 	msm_perfcntr_suspend(gpu);
 	gpu->funcs->pm_suspend(gpu);
 	gpu->funcs->pm_resume(gpu);
-	msm_perfcntr_resume(gpu);
 
 	ret = msm_gpu_hw_init(gpu);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index ab04a442ca9d..44e5da9d6ab9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -168,8 +168,10 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 
 	disable_irq(gpu->irq);
 	ret = gpu->funcs->hw_init(gpu);
-	if (!ret)
+	if (!ret) {
+		msm_perfcntr_resume(gpu);
 		gpu->needs_hw_init = false;
+	}
 	enable_irq(gpu->irq);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index 7fa2e858bd08..189be6cc23f1 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -199,14 +199,22 @@ sel_worker(struct work_struct *w)
 		return;
 
 	scoped_guard (mutex, &gpu->lock) {
+		/*
+		 * If gpu still needs hw_init, bail.  We'll be rescheduled
+		 * after hw_init, and there is no point to collect counters
+		 * beforehand
+		 */
+		if (gpu->needs_hw_init)
+			goto out;
+
 		guard(mutex)(&gpu->perfcntr_lock);
 
 		if (stream == gpu->perfcntrs->stream) {
-			msm_gpu_hw_init(gpu);
 			gpu->funcs->perfcntr_configure(gpu, ring, stream);
 		}
 	}
 
+out:
 	pm_runtime_put_autosuspend(&gpu->pdev->dev);
 }
 
-- 
2.56.0

