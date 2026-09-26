Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25D4C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB3910E110;
	Sat, 26 Sep 2026 23:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CX1rw+2t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zt1R0ky9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB4A10E197
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH0Hmi246682
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=; b=CX1rw+2twDjn+4VA
 HMb8y/B21mJoCrLzPHMocGYhIEebF2oRflUlWza2j7hKvw1zbHfWewAwpboddIwA
 4HJlYdW+YgI9kkUDhBBhpfflM4Xn1D1iZzbCqf9ess0lhvLxurxyILAtBx3nRP4k
 V7FNZuMcae+8m2BPDRxUPUDVaB1/PqX6WD2koZ5a62KMdFSBk5UNdSIY2CwR+D3K
 gMpIsOMadIyV6rT1AR/WnvnfhserKuuRFmqEAsbSL3hVtob+Y3WfLVfwICNK5ZYB
 Hl8uQEShMKggDX4dSh82EUEbkK015UyNmO5zaa5TBiKOMJWJvvNAmcde8iP8ojy/
 4OqM/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp27wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53333acddb5so1477161cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790464817; x=1791069617;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=;
 b=Zt1R0ky9CNX6w2qgu1g5UiPsYAEY0G8Tw9UK5bvh2cp6yuBA2SW0ZHBYcV3vVLWTmm
 g6o/1SuLsR+dwsVQyER6cePOmfYwKB79JmAZzTwB+fW9K6ONRBtoiGTYOfADH6eASjFI
 bIJSlCP4ss5G9Q7H9k8UZxWXIop/hlk2pHfeJybL875mEV634VRX7GbB/1KxcrXs4S1N
 CcDUPVEA2EMY9q+CLR1ciUc822MCH/ppek7mjcN5OeN97aPNkXqopgaJwCwVLVyT+b44
 W2gb4Yxwy5/U0NAeN2WXgtLw8BCeCHjv5f3fFyV5t2OmMdGuxc6s4yuY4/e1klz3YW9w
 XwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790464817; x=1791069617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vn8HrnSp9wF2lXt9UhWS6MvVRq28DGOOCapdNx+WUc=;
 b=2CIoqnND5DK0nDLgb5aYvJLBaa+ObvM2nvTOXiaZVT3Ap89khEJNVPZ7ELMhTfTOPX
 2ISSuG+hGCpsM7zKfD10rQqz/KfCRDHZKGie3+9B9AYtFN+x7xJnXbtBIhwoA0vgi35R
 pmSyGSeAW82OzHJPq/+OEI3ycXlK8RQFiLyqn9Ni+FUx6+gx/MIq64ys78B1pmHJKfW/
 gRmyEorARv3PvA+ItEpCxYTCxgRhbrMrBM4BdME6/e4QWa78difgqfS0HpUOVtyt//9I
 Qn+SANiMrJfoe/8e4McYS88kUlA3wzSgbxBVApI1Whl1azlPv91MnkTuBQBj8M3hasv/
 nIfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz97ojvUpCOfYsDUPYbAp2R2cKC7UcMVSk6lQYUGgSTUwr9Tpbuaj0xfgveLiRw1KhW8ci4iflTNwQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1iQExpP0IIQm0cxHAqKfKdobHx7vQ+Ra1jOX1cL/gW3aG7e3Y
 TC2S5kKM9/0eqglAO7oH6DAPaOWHN4Rx3+51Yt9iI8Nea9WUREDnz5nD7/RpxF3DS4BqSdbgXjg
 cwwk22Cy9Ciop9u8chtzYgb385oe3bS8RGOXXgpGJ6IxXK3PcWbv9nxV9J6wlW04rNZWvA3A=
X-Gm-Gg: AYBFou1/ACc8n4w2Nl2nkYL/tyXJq6eeBHiSAtPFeAn+zBnLe0+LOSVzn9rQMLcGLjw
 37MNIJq9x2a9avy6flLwNd7zSsNXFSHq9xduHuHYymBdLlNcUj9Bj5z4VQcy2zjY2+nIAvSrb7f
 yIl5Dauf6cl/kmc2GlNyFXrC/GaRwoCX51cWLGnFeZXFzKnYco9Rz0NNf0FtNga3K4c92Fkb+Zr
 jP6/dSBLXs6G74Jzw561xWkXvSN9nkPIZrVm1I4BTyrAcJYJjucPh+P7H7ponejnsQbXEE/aG/t
 f9OJCkuGCF8Y0O+MnvARlzIAON8RSJ2OIuiJTb/lKT2kLHrCe96tTNeAdDta0+cc8rkeJ/WxRDm
 I1xFcUhlWmD4/0jWrX0jNuul7pLeuK+xbkYkvkyvs75Cso/puvMbWEkb0b6ry0IVpxbYkP7KaA/
 iQfkJyhdv9W7Z5
X-Received: by 2002:ac8:598e:0:b0:530:f7aa:d424 with SMTP id
 d75a77b69052e-5330b5be659mr130434091cf.20.1790464817289; 
 Sat, 26 Sep 2026 16:20:17 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:530:f7aa:d424 with SMTP id
 d75a77b69052e-5330b5be659mr130433741cf.20.1790464816848; 
 Sat, 26 Sep 2026 16:20:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c3274fdsm17676311fa.38.2026.09.26.16.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:20:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 02:20:07 +0300
Subject: [PATCH 1/2] drm/msm/a3xx: Add hangcheck progress detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-adreno-progress-v1-1-f0bbbd6a4ac7@oss.qualcomm.com>
References: <20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com>
In-Reply-To: <20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cvRrPOLxLPbCTpWLiVr6CL+JUOrTZCa+HknyxlPt9Xc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBquFMqymWBj5VCzId8GXSUAKRod0HeSa8C0cGnh
 1Wm/y7w7DWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCarhTKgAKCRCLPIo+Aiko
 1V1vB/4oYrU3pM0H1C4dBRlLIyf6TFEAJspyzf88AAtdev90tVgY/e7pl1BI+dviaRKVORWO08K
 4y+NvmwGnJwPZtPxSoYrbKESZD/wHhwkwkauvXy87SmNQlBho7XB7qQRif3+g246e+ssWD+IAV0
 06CKYGpG5/A99aWD2aPNRvWVbpzy+x67j8ToUePGFRgsbeH4bz0W8IP7T7KPxJIjlJY2fVq3khO
 iHf7aSqOguQTiqR3vLMHIYTeSAK3aTzsmJHz5BFNTA/COg+Qdi865yPxYJRy6bFvaRTNlE0+t1W
 yhT7M2zu4mBh0MxAsRoaKUiWlxZQ+oYjPPSmOf5jYC7of4qt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfX5hK4iOETnLQO
 8cWV4uEtNi7gHCt+HVauc5d3EkYHKeZihsUqGRppkrTwQb9LQGAg7OS+hqwKeo4Ad13qrLHiNyZ
 /wP4ECfNM+uUsTOPyAMnXcSXH+R1zlrcO6rDI8vEmqQZVfJjajA8dVdytt1b92qR+oEmepo/VZB
 fOLXsVVi4QUJN0eHT6F7vM72pbOij7/Il/MKkstkKy2bdXm87/3gdpK5aJWD1d9UDHLY8rXlDQN
 irAZrhK+x1cYrpTfUO5RjMOSiVHLaPoJofLRorQGiPaD6AZ0PyOtB/0dgfXHyLXOtUwPcNJRWHN
 05GOsNXdx87mOp8mYddrgPuuzG7HhR25Mvv/7WBNvG1CwnJglnLA3ATwW/COG1K7exnwX5ibNGq
 4tG0MrbC1VRd/G8KnhAQ4neYxIato8TFwS1YOIGLj0ngGWp1O6FZIu37CsWPw8KYuSzlAmJq6Wk
 Momrfg+Zx7E0M2zcBpw==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab85331 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hoswt1gEA0YReVsPuVoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: vyvk-cUYm3PAtQhPzclFCWzlRdAk38vo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfX5nZeNoWhYUHf
 U1VoSPPRrZFDE3vm25u8dG5LSDEPvp0pgn095vKbRi77KBaSxT1FOanCPGo4PwlWW2zKqrH8kHQ
 OUwPjXGCrj/7cEgpz9mM+qe2Wpur02s=
X-Proofpoint-ORIG-GUID: vyvk-cUYm3PAtQhPzclFCWzlRdAk38vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260093
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

A3xx has no progress callback, so the hangcheck declares a lockup as soon
as a submit is still running when the timer expires, no matter whether
the CP is advancing. On A306 a piglit tex-miplevel-selection run is a
single submit of about 58k draws that takes 1.2-1.3 s to complete, and it
gets reset partway through on every run. With the hangcheck period raised
to 10 s the same runs pass without a hang.

Compare the CP IB1/IB2 base and remaining size between timer expirations,
like a6xx does. On A306 these move on every 20 ms sample while such a
submit executes and read zero when idle. The prefetch queues are small
(32 and 64 for IB1 and IB2), so buffered data does not hide progress for
long.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 0259e60b8011..c95bbb4bcf47 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -536,6 +536,23 @@ static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
+static bool a3xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read(gpu, REG_AXXX_CP_IB1_BASE),
+		.ib2_base = gpu_read(gpu, REG_AXXX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_AXXX_CP_IB1_BUFSZ),
+		.ib2_rem  = gpu_read(gpu, REG_AXXX_CP_IB2_BUFSZ),
+	};
+	bool progress;
+
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state));
+
+	ring->last_cp_state = cp_state;
+
+	return progress;
+}
+
 static struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 {
 	struct a3xx_gpu *a3xx_gpu = NULL;
@@ -630,6 +647,7 @@ const struct adreno_gpu_funcs a3xx_gpu_funcs = {
 		.gpu_state_put = adreno_gpu_state_put,
 		.create_vm = adreno_create_vm,
 		.get_rptr = a3xx_get_rptr,
+		.progress = a3xx_progress,
 	},
 	.init = a3xx_gpu_init,
 };

-- 
2.47.3

