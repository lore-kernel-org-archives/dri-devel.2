Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC446606B785
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HahJ10wK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGUr7p6r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8DD1129EF;
	Fri, 30 Oct 2026 21:19:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1431129E8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAXL63473046
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=B6OmBv37eHb
 oEi7BArbQsLv/q5WNK4DK8SqPKmeY4Mg=; b=HahJ10wKlItNwwuJIt5NekUdnHN
 uj+XDyqH9QgYUL8A3feLWL/Ne3O7n8XNhuvfSy0bJrYh98gQZ38AnNQh+Y7MUVKr
 wd91fTETjHWu0J53Q9EV+6Ib+4od6p6AfwUCMJUZJoD/XDfG7fXN5hELfNIwNP9n
 egzMbRneqD3+A++AwJiiOqItrD5qHRckcgFz6IdK1BsbMSRgJqHVh4nlz3TtCtb8
 tVitXvvP0i6lWHsOIZProSj99iV89WJeITMe0cjbo+hKyH/kUV0J+b1fB5ZO9jrX
 Ffdm9Y00EbLDaNgevhIQIFdHvCgBVf566bPA1+BNUE6iP2bkufvPkSmFgvA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g0qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdacb64970bso584262a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395180; x=1793999980;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B6OmBv37eHboEi7BArbQsLv/q5WNK4DK8SqPKmeY4Mg=;
 b=YGUr7p6rM9uidP3ktSQ29XM4juAfgdM8yjPx14x9b9eureMpTwNkdhN+WraqsiybMU
 GXAKKyRT8Sd58wgkXGOuy/PKeUvKJKcnb08hMr+Sl5HfSxs8q5j/Awa4bLuq6ORMKt2t
 GBA9B+y61bR2LMdIUeFhULbEWEfyjWuashkr5B8KufjuNL12cbZTq9oNVsjyREMl3Lk8
 ugv7aePCkn8IShyI9ZZMzeiTn9rGkE5KcHShlKv4uePF2cVmHcoWMySjOMoAc3RSZJqq
 3JOZf7lAJOz1YX79BIxf9noXowkU9mmYOF9NaFuZ24LmtkHrWkjRFLMe+EwPhCImgq+a
 Doag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395180; x=1793999980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B6OmBv37eHboEi7BArbQsLv/q5WNK4DK8SqPKmeY4Mg=;
 b=w49j4VgzAw4CYzxlENE7EbMpEluldHaqZCjy5Y3s69U9Wef/MM1kcBSRPLmcukgtTE
 2M/5lt010mkVNZHPZ6pZd+6lt+0kzogBkDKeG/eUFQOfm6Zgsoio8yLRpvo10bt2x8EF
 5Rd3mV3ZYKhnpdNy7nfPqnJjkZACgq2Sk6gL3cjpGQss2kyPW23QNUbAsu0MvRkVqLW/
 idwyotuosgpe2pydVOskB9bARhK1njI7iGic+OPiTXig91zdLGcWeBhJBevN8meMOExm
 HnkhSRhdc7SnbnV6KasoX2c5KwKpMQC1kyvUZe4O6wqc4sEmL7HbDYh7mxjX/YIW+5nB
 FjSQ==
X-Gm-Message-State: AFq9FYIASAVB2VVGUrfzGtbI2ccDhCMFkRi97ESJG9OzaWBx2c4laG4c
 P0Tg+WUro0J7GJfRKrG27+a8F4VBFWAhulpm3/cVB6UQKveppNrJvPt+w8XJjMpCJzILtjQltSL
 wiK8xAW9q91CDlYME5W44E2g7mG6emDcMgTpqKk+MKd1Kc6toIfAUOzMr/e3cv4OZBrfsW27hiW
 sPmQo=
X-Gm-Gg: AYBFou3WXm6F/TLge6utam2n/mZhOjdK6ai8V+RX/mP6USVBka/FetpPd7Zmp51pK66
 Phhgxg12g6BeuaakRGM9ComEhZvk8Hpkav2GsZE6k9j8xYwaUPquFG7wp/S8Eh6+Ov/49BMGhj9
 2rMNx1+mcObVlLdGrmsvmpUgVHP/Wnvhfc/q7jKQTcyLrLfg7AYlrdAwv1heoYUu7UQcvWY6hbp
 dEq7a0mGDaj4/EJxibOKPUZ54aOleoQHESu9UyxEsIyd/WWswAxXKgmjW5SOQCZ3yZAnDTTtukA
 JrUQWiviJoVpeax0m2BVMiuuMJ1Oc0oozXTETscttqbR5gUmSIJP/5ZTQWcZN0rI+D4RuMQThnZ
 X1Rw2XcKxnS8HXDEMSxACHT9rIBotTw847Px1MxYKvt62zEJmgTx9ZSSDKi6ltgXT20X/lbx5+h
 LX57dyaXr2DW13EIXKdtKSJpY=
X-Received: by 2002:a17:90b:1d0a:b0:3ac:d39d:ee4f with SMTP id
 98e67ed59e1d1-3ae897f6e87mr2762599a91.44.1793395179989; 
 Fri, 30 Oct 2026 14:19:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1d0a:b0:3ac:d39d:ee4f with SMTP id
 98e67ed59e1d1-3ae897f6e87mr2762574a91.44.1793395179529; 
 Fri, 30 Oct 2026 14:19:39 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845ecaf5sm5291016a91.16.2026.10.30.14.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:39 -0700 (PDT)
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
Subject: [PATCH v4 02/19] drm/msm/a8xx: Export aperture helpers
Date: Fri, 30 Oct 2026 14:18:04 -0700
Message-ID: <20261030211928.45761-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX/c3qSG8iVmsi
 WWIJKA9e/DZlB6Y6gfmQ+exCZOYgYZQrP9S7XjJZqS+V4r214wDXxbnd7nZRhdovZsnCemBtkmp
 J7We9EI094/31zYeivqb49/cCbvTzBLD9JdVqQiwFUgXKEiBQuWh5Um3SYhaFznj0Vaw8ZP4zxq
 evhyCaXiLtbY8xQ/I6Ll4mc/vMkiJo3vLrW19vv8DuHIttigBO+lDzGB/FgwJ3zUuYWNzgpf4UZ
 /NRqbZmDf6XKlYqjRBSrwt9TdRRnqjhF4JJIZZ0mmPMToaSfulFodyIFJF6lTqrSjcXfB+Fdz8p
 44Z2+ONcREVEw/AIySTfyOjIj++3ZCuAOhDCMzC4L+P6ozRExsG5/RI9O7QJeFqHsRTlsv/mYVG
 7/eiry65DSOurN7IUi8U3lbXhWp4oRH24VEvB5V3X+lafZPggyHOg3LwDs03fmyqSINT15+EGx5
 GgDQhWt2sRF/d4OehuQ==
X-Proofpoint-ORIG-GUID: EbL84Cx_fHqfjVSWCpFMYd8ljx_vsAL3
X-Proofpoint-GUID: EbL84Cx_fHqfjVSWCpFMYd8ljx_vsAL3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX2NrjYBx8G/ic
 71U0FiiSCyTvgQXDAskzyef5vdyP7fj5oWB+kmKjsrT8ZqLZEU0bnE1Nm4CgZWsW9APYczLJCoH
 gl42ZFgM3FTp2AWFa+OXvOgXY4d31fs=
X-Authority-Analysis: v=2.4 cv=Arx7T+9P c=1 sm=1 tr=0 ts=6ae509ec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300084
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

We'll need these from gen8 gpu state snapshot code as well.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 81d21acccea1..fb000b79fe2f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -348,6 +348,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
+void a8xx_aperture_clear(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e7d04c865968..a14379e26fbe 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -32,7 +32,7 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -42,7 +42,7 @@ static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, un
 	a8xx_aperture_slice_set(gpu, pipe, 0);
 }
 
-static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -50,7 +50,7 @@ static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 }
 
-static void a8xx_aperture_clear(struct msm_gpu *gpu)
+void a8xx_aperture_clear(struct msm_gpu *gpu)
 {
 	unsigned long flags;
 
-- 
2.56.0

