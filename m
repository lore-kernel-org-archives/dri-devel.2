Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA31606D807
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U2fHYhvc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gf2WzqHi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BE510F258;
	Mon,  2 Nov 2026 22:04:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8430810F25E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K5xij3292407
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/dQrmyfLIGU
 6IqlJ99P0Tuit4U9aGRac+caYuZRRsOI=; b=U2fHYhvclVNQar4mvs4zZRqghFT
 3GhGctauPZQ9dCu+i9xuGKD4D2V1FgOa3ZwFPFjKMWc1n2x8tIMp0i8qM9zgtNVm
 +isJpKFWcb+FtQ5AUhPm0jQ8XW/ECpVmYNUiWFazbb1PZRaJu0xTtCd8hlOxlHEP
 Jvcc22jslMROjoLM1zm8x8nUnLkXVEvpcP2HZysoFc1XAs8+E4fCu8SQ9+Tpe/88
 0wcWb1wir6BijXUnmzuQz6CJU3cY3EUu3AaU2P7d0fKKz/ZrGZpAtBeZnKNLROa2
 RSQYkk2+On/QqjeNuCTe1JoaQbLMw+lqwRCIWZLs60+46P/3Mc234Q1iF/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07egp5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae19907a31so78770a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657068; x=1794261868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dQrmyfLIGU6IqlJ99P0Tuit4U9aGRac+caYuZRRsOI=;
 b=Gf2WzqHiRceqBU8/meRg7BvXSHs+Z/AJZRaxB3iaTbg9NoRPeu/Q7+OI3OIX3AGQJE
 GSxxkFouZkWhX1go7oBQEYGAyxbPZIeTqJouOie0jIgIN2QRmK76d1R3VN3c5kJKY/Ae
 KhyVzocPTOJSkBffIULSiOfuVV0vS3kh4e2N28VqGflzRLxp3LXON1x+lFlsgywDamur
 L7M73XmecyXbltFiAezS0uYBQudXmCvoJGB/u1A52y6U9RVvcMKPjeyKWYXjlQN5Sozj
 kkrji54v4lVm0lRGGNf2DpU9jC9nw7slBQCfdkOoUObbwWHuAmRbaBhpq+oxhI/1WJ58
 FVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657068; x=1794261868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dQrmyfLIGU6IqlJ99P0Tuit4U9aGRac+caYuZRRsOI=;
 b=Ktiz74qwuNhk3UgoXdjaAlyi/VIz+sMuaVtU8t1Brmqsfp0tafGZjNmIQOvGRpG28w
 GVwjMJ0DrhcUVpx2ScN5Tf1fCiJgXhDkZt051LMRAxLqmMSnrM9pY4A785l3pAK6k6dc
 Tc+MGN5YAW1f6kF9eS7muPXMml6CHKKfvR5qLzVbOBXkUoPTxbfSVNmYD7KHMIWkNY/G
 Mie6WKRJ1v88/qnLRtoQrZJwQ6S7Qn8MCypulcV1kOAoOEH/bxX9AbTx/Lj86GE4rrls
 s++T5hPNfRSsePDm4Z+hLsQMfATvqWWXvHAfwKhcPWsx+uNonkJg2tPxrnq56FEn1zzy
 N8+A==
X-Gm-Message-State: APuU4Z9SNyFOL2bYbe5Sa0mEqUan2uPY3kUwB0amTZKeHydu5jf6GLGZ
 pCPxKNNvK9Wu+c9HXTW0gnr5Lhq6/OvmPt90NUsUHQn2+QDbESabj2itweHZ5fvZSiRGx92q5Lp
 2EhJWbp+tgGVMIv+pSff8nMpx236LNv/eyVM5+MLZp2CEM9fiyUiW5RUSQ5XYkPMMMFOMrZKx4I
 vquBPOwA==
X-Gm-Gg: AYBFou1MVAiIPqGqtY3IHl8aD4cI52biQ5sWN/rWW6RoN4q0PE0+HDYai5HghOv62rT
 hvmy2EgCl9IcfvcFEtwgMVbUd7svVWvpAni7Gbc3XEumNy2nmpqSmYBDQEDSipbihVZAXsaxzGt
 veGz7uIynVC2qNIqrxp7BmMT2ro1eDcMWBRyXtKpaJYDc61GmWsfQDilhyaTm1DnG7Mi8usjKyJ
 C1wwPu/7WdqnBoimMKJ9CRmPx0ju47wzPYL9kR/cstACpcjpU0/32i9a92LMCapkDwT1rkVDsIy
 T3qNVPWt4WkHtwLtTLh5lttJnv8aCAyfu8k6+9cchO1E1YxFPXikFJ8qybOFNZNkQyabYwgeLo5
 951cYy+5YAcLFFefC2IQERMroGoDMJGmb7/sGRjz4RF2WYA2W6zVpcvHR9MlcciALrA/E7iBS8s
 KDDCd2/cYJMkfOm0pUMuOI1yQ=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3ae89776936mr6169530a91.28.1793657068130; 
 Mon, 02 Nov 2026 14:04:28 -0800 (PST)
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3ae89776936mr6169501a91.28.1793657067652; 
 Mon, 02 Nov 2026 14:04:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c6b3493sm1039311a91.13.2026.11.02.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:27 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/15] drm/msm/a8xx: Export slice helper
Date: Mon,  2 Nov 2026 14:02:48 -0800
Message-ID: <20261102220405.30730-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX451p3og3dQAm
 FOFDN9cl6uPFSNkZhYg5wvqaZt3sDa3RluSnIwNNJ8Z+kgr+hhIcSUnchvJtwOuC0+NYvZXxLnG
 jqFVYwEwzTCuhwYbX2mELf7fFyVMEb2w+D3uuoq0j94zs5HMFW8yOq7g4fcntkvEBUy3u00RU15
 9d/A6pNO+Iy4i9avmxkWno7HcTK2QKUxW23TfT2wldk8UBM2f8aYRcI6+LMX4OC6cPVwK7mREuO
 8uHh45KB3T94YKOmmfOASmUQpz1s9XohV12CZgEmSj3jCrrGuN7AXLdk/N4clGLdm2tE7ISi8l8
 K0IuvyRS+ex6smjP282eTRlJ54WJznIaIFs940BW+PFwyJJQesMiVPvlFHlcGyXA31A8hmGMkYF
 b1ULzT7Lm11BC6LKnvgx3wWe3E8de8YeadOMG9OCMQkp27G65eOfkM03NXBiEMvJLRUTZbU/Dpl
 UzKWYb1kzlhpU5k/1Gw==
X-Proofpoint-ORIG-GUID: l2v_yT9FbUgoGSNVI43Cv5Y-v9k-tVdw
X-Proofpoint-GUID: l2v_yT9FbUgoGSNVI43Cv5Y-v9k-tVdw
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae908ec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=eauOX4bcPKZCCnkqRxoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX1l6OnOpTJPQW
 A9axYT8/Mp6M20mJZiYt4XLnQl15gjQQPX+cdUX17PCC1FzvXaM7kI79OYPVPfCtBCx0NaZp1rR
 4V5KQyYNjBXGdxd8+0svkXxsxChAu8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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

Something we'll need from the gpu snapshot code.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 83c0fe39a44e..f8b9ceb588dd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -360,6 +360,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f2b635497811..6b299bf1000f 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -127,7 +127,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

