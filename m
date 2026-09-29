Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA7CA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0DD10ECC3;
	Tue, 29 Sep 2026 04:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKt9raKT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FORXIQrI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CF310ECC1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T476a1318105
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PCLBU4VkRPFhZ9rgabFpRlPORMDBRpimMrnN9bVDHCY=; b=BKt9raKTwei6g/lR
 tFP99Lf0nwv7CrMpS143/pO+DQ+PAxIHTV/Uc2U6FO4HvmRYtUrGVUAUEJLbstGo
 v9FCvPmuPUHZYTPdEg8U695jolVQt9VFJSWDnHtjUxBVa0xAnv5jv1mo37oZCDHq
 yTz0PXPl4Uc4Ndm8gbIv8M+gZdl5jo5xqtWy1w+EEsmViwrlafRirpyjYiH+oEX/
 cmF1e2PZo6NEt33Bjs3pDVAuc4BZqk6Hzz8etuaoy3qvEelmzH2y5d+PGW1Iiwqh
 IZltkw2BZf/wErnxbFTspKPJosk10jWKGV/lzfoKI2tJuKWaCfq3O7DjrChkcJar
 ajiGBw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03j48t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9175cbd3beaso29163076d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656124; x=1791260924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCLBU4VkRPFhZ9rgabFpRlPORMDBRpimMrnN9bVDHCY=;
 b=FORXIQrIxeG90czW7uxFsBdpfHIG42CyhqSa7c/MWtWZ1vUafrocX+0up4mx5FHcqB
 yQo4ZJWg88p2FdQqZykpuJdxPjv/ufmTx3AjxiDEdaGHfZjauJqln5bJyRhKNSuO7H42
 ZLd41+bA08oAgAOUWmvvG37UjmuigU0g7fWj+iT1uRou0ZUNOvabAvnAIascKlQWyvRX
 mi3pAXQ6YfJtMD3fZJqLC6ydOmY/a+zaWodb7QZCR7bwI11NrSy1kvnRaFDSqKnhHe04
 uHF2kufQTj67UV/Nfg74C0677UNa77cb3APgjPdh1lnU8Q696HYVtR/ENun2kct9vWIN
 jBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656124; x=1791260924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCLBU4VkRPFhZ9rgabFpRlPORMDBRpimMrnN9bVDHCY=;
 b=eKZG7kDgukSYDJ80u5cSMveO3v5Ep8rHTQ8KbJK3SI9xZpEzHHLtEklAoi5YdhpCJD
 9tI6mTAoyCbb4LF0Tq/J4OepTCkM//AL5fx2iZ6THkyRrQDzIo517Y75kutv5vz0R7NF
 0xjJ23RXG2vVet/NXa9KIERPvFgsUuamTqBWHdDpJ5TXqlfBXLbXTbp3pcvsoGK0lXwi
 rd6887GByFDdAwVTKvvJ0ekoygghW4zwhuLz/naElNP5Z6Kij9jdTlRbhnDx7b5NNhA2
 5CbF6NoGsMBwaBCRS+4veWP4e3BzrSG0FzQi6KTIxDVL/1mg7Ske1Gt0eYgureSfxCEg
 mvxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTaoA37el1AohcmUrkNdB1ZgCCKj1KQb8LkEJk9nJSjBUTd4O0iKSZFc06bC90ZPvtqXrfgVrC8IE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJpb+bFiNsbek8zO1/4ZVLmMiNxJowsYWcXYkWW3JAEeWNNLkk
 k/7nvB/kStewPKdS85bfB6NJaOU5DudHGXVYCfYpsEdDPh+/pJSSXom2m3jyNvG0853UYWXZ1TQ
 ovmGyMVSmc2vW8G7T2UUxzqGYyersPlmFZ48BhRfvYCljdViPrvkw5t/OYxYqLr3Cnb0HtOw=
X-Gm-Gg: AYBFou096j1WP37ktgSBePaJreuSVM5YnKvL55FV9py6WeoDJO7I4l9++mIvry0A/uG
 zQyD15hKFvSA4uJOj8eXR6+EWdLJEJJ3j0QFXQbaHQIaDDv8UWuxko43lUbu7Ll8xQ6JWDkiOgZ
 SoSuBlAGb7iEO0kbxncTSakoxi3UPGaBGaG27+hNkc0NMx29a5CEIo071SqYguelnWL6m1/yNcL
 +PJL5kQ7YO4WdKwO6qnD0lfSBy7QPGgQsBft+tD5ifdxEIJOvSBDePogla++DyInTly8CKNjEn+
 mVIsh8LnW79ulQD+MyxBsA+obV+GDM77SwtsclFGFsfDVDDjIq1BvScTm0AmdN6DAnNPwEU3cet
 KT6hQVcp6MdvHxqOrvXVUKTvvzHHwmyZVFFxxKpl5SEZQ/lQXgNlvDmTB+tqwEus=
X-Received: by 2002:a05:6214:4281:b0:912:d9b:aa2a with SMTP id
 6a1803df08f44-9142f8ac3e9mr252107316d6.25.1790656123904; 
 Mon, 28 Sep 2026 21:28:43 -0700 (PDT)
X-Received: by 2002:a05:6214:4281:b0:912:d9b:aa2a with SMTP id
 6a1803df08f44-9142f8ac3e9mr252107206d6.25.1790656123486; 
 Mon, 28 Sep 2026 21:28:43 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:43 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:53 +0800
Subject: [PATCH v7 29/35] drm/msm/dp: mark the SST bridge disconnected when
 mst is active
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-29-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=1108;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=+026P7+prh4NS9j6xdmzfYv32FGxKTxrN6W2/TiN1eY=;
 b=dB6YcfyoNpRTMSE7Bm1AdeuK5NYSg3GwxdnE+13qGKwLZIKqZVwIFcyWDZrq7aPsPrwF2OR+N
 AndXn8vwxlBAiXhLZmqActN0p0D5jYLtTCCmx53jTLFptIBzD1DRcEo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX3YA57Ub4c8Fq
 FTx+W/KmkCfAcmUM8JXV5szx+H57paAk0WXLf3+LaoCxA6ULKdEvMCTS9Sj0jKcRhZf3AU2JsAE
 s3iOxsr0AYbYgo9+Q8ohvVTNChpEDbE=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abb3e7c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/dg5Qj+fyVS9
 f7dRYod3a9wRumDqhLjxv/4UCPKtSaEM0wq4QdTERZGs6pojjDW52mOw1DAgqFZIgkybFX6b4Mp
 FAjYshx9ltiWccZqxLzTU3FPVLudmALlG1bnDOiShYMVoVg1AfTY+j80m111xhCqXBxxTk1OV5w
 fEx0n1iMZGgJCSHWUfdWOQhjhnMNLJk8oAzET/CXbHyOBH9+ax05Y1L1pW9v37LjSdOovh3opC1
 eCljJpF8DqCYBVQoztHceUU1ho95d17YvPeY26oj0yUauJ90Dbsooya6dE488KP1WoE0H960/cw
 RwOkd/O55njOT0EfRIaVNHvS8KzJDiYuNV2ZnKv48TvQPC0B/LeToeZweu2EpJ8nUry76VMqCZJ
 iS7CgmbMQqKF3TnMv51pwtT4RJ6/iI4MbfEiaxq6aaqtzXiTXI3IWpm4M6uBzaOy+/Hg6LGPa1R
 BY/QE4sMwh+FvtZCxfA==
X-Proofpoint-GUID: wKdAEsXp4Ru_9JpzboovvPq-0HZFMjCV
X-Proofpoint-ORIG-GUID: wKdAEsXp4Ru_9JpzboovvPq-0HZFMjCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skip detection for the
SST bridge when MST is active, matching the behavior of other DP MST
implementations.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 71c5e6bef02f..21dadc2e6cdc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -971,6 +971,10 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	guard(mutex)(&priv->plugged_lock);
+
+	if (dp->mst_active)
+		return status;
+
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.43.0

