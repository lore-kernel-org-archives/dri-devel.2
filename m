Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705D606A332
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KP+35F22;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMXGHckv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E64010E31F;
	Thu,  5 Nov 2026 16:42:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B119C10E302
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EPslo2081295
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4WiKxk7FBKJ
 GDyVAt5L76xpX5rI7VNgOJo3nrJ4+COQ=; b=KP+35F22f3H+NrnpEZ1Wc3CTglY
 tt+8r2EyzyG8kgWUSnr36HWvL1o5DGfvTAN2U6V5Wd/1Z/zhCe1EES4VvQ6zgtyN
 W0ldRUaQkzzdcl7v0EPl3Ddo8Q/APlwuILMYPSh/+k7noiG323XEkLZyBp0GcXCr
 6oYZaNbQAbIa9wLEt6sWj2i2y50JvLJ2Ww2cZlcvM7xMKrQSW6wDYtD6Db08ZdPa
 T+yh01c7PQPGA0h9aGytNxoby/kDDXeLgiC7aEZ1m8ozkIO5r3XbmEmLDmLjAVZq
 izUgIM4O7QzqmV5hcfn+4U9GnVPwH4IoDF3iq1ZCp5ibmgg03L7J6p5E9Ww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraashhx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-89f84753b43so1995662b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896924; x=1794501724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4WiKxk7FBKJGDyVAt5L76xpX5rI7VNgOJo3nrJ4+COQ=;
 b=aMXGHckvvLnA8ZzklhSZoqq4Uw289tMaKoyqPfU/7rQ6ZTivN5yn7+N6FGXqU665Bu
 jPEo2S51iCGHYuAP8Im6iUfKBwMtDjfqkBF93KheoX/gZdKt755CY62WNL0UWTq2F/5v
 sWfiINXl+DxotNFxtoipaw/UMhFjH+9UxIDFw1Xa//SzNDFC9juFvXZaud3NBDUh/tGu
 wo7jzwn34l1I/VAJ3kwG5WqgkvSX/7k0gxX/TgWKm16xxPXqWNLPKgS0bxjvd7CO5+L/
 ltaER1NlWPBR4++gMXcMvhwfGv9dhX9QoE39NBvYpA5TjoWPdcbs/YJx7Fa/2iQlolmg
 im4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896924; x=1794501724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4WiKxk7FBKJGDyVAt5L76xpX5rI7VNgOJo3nrJ4+COQ=;
 b=k0a2FnIS49ker3PGCNGSmLdwFhn/mWm0U0VL4wkotrqm4/wbjgpjwkOEueO7jGHU9A
 Qgt14z8f0eTn+Z4IMXz69rppmrRf3xkS25kl2Jj9sp/0gGnSdghhmwivKLq72sdgIdf5
 vNaJAxPbOuozc9LWQxWOjN5kctERx0Cv4x/w5j7ybp6xI1reHItARhj0ZLeP6lRGG74T
 Hk2QHzAVLq9ydB1U7H629vN6RpdHoAHI3OQAt2VfeDh5NeKGAXiPOP6LCfkM4TaOw2Af
 17Be3droEVyClak3ueKvKM6aSc/cff++8aJBz0cCCE1d56Eli0NNGIcyYUDu38PW7LSX
 lmQg==
X-Gm-Message-State: APuU4Z90qPBmVH6GH/ej3x7fcO7rk8lhgIIGJNpBILIC+gQOLIrEZ+54
 lMrZSGcKc9XmNLemp+HzqRIz401iXdgfxn1pcHsRHwbDI1ZcGSIGk2TGIZQRRM27/P5e63Zzkd2
 3OiUOZlyBnApwknr5IvL0f/kP9hChEiRSETx4XXsSEvq7vBWG392J/S9w0VkAwQN/MbEzzLkbIG
 FsqG5dkw==
X-Gm-Gg: AYBFou0kRPkrApgZ9WRpqO/wYWX+2ogtTW53FBLofkI+SFQcOGlquwQBzmSeXYSnoaC
 Lto7vasH6cXRsFy2875fJpMiHznQaIBZMs9qNpS4nFlRrdgZNhwDNOeFbnh2V9pNEGfdfaljQMJ
 hsLELfc5BfbxV5XlgOTFj8SuvcrX1mlLEk9xMI2PLodTrpt6xffY7EKSEUYYdg/e81G1LcrCteC
 myVsvLaSHS01FzT8e8NpVO8CSg8oWxMSIc6gGiWb4hv6/w/iNXTgztCH0wpqbJu8+5CuTc1gEvD
 0+WVgrLeefzZmt+EC6Cwnp02/dee1CTmAZbqCE1ra4GiN1oEaIlorWdQXEQNeN5UQDjVidakI21
 7NqGUfTWacv1xmyPnMS8hn/bnMoxGCHsP1J1eQnqDcQy0Yh/5iD0S/qbAbiCf0HFG42XaHLlymH
 z7nfc692a/7QpGnC5UyY1iO7YrVquGGl7L1f7+zrggX9KcnwcZHawV3XbMRxNs
X-Received: by 2002:a05:6a00:3990:b0:89e:db8c:7a39 with SMTP id
 d2e1a72fcca58-8a9bd6d8c91mr16175006b3a.30.1793896924475; 
 Thu, 05 Nov 2026 08:42:04 -0800 (PST)
X-Received: by 2002:a05:6a00:3990:b0:89e:db8c:7a39 with SMTP id
 d2e1a72fcca58-8a9bd6d8c91mr16174992b3a.30.1793896924026; 
 Thu, 05 Nov 2026 08:42:04 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09af918d8sm2233004b3a.22.2026.11.05.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:03 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/6] drm/msm: Hold runpm ref in set_sysprof()
Date: Thu,  5 Nov 2026 08:41:48 -0800
Message-ID: <20261105164158.23263-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX7V5+mTvTe7OH
 SY5qvSzn0PTMaabDT0fSjV8SPOR3VJvr5K3S/qywTeek3vOJhjAe71n8dmtF2vwtyLdyRuzIYfU
 P7TcfpvnwjorBCvnC58yE++sz7idMJs=
X-Proofpoint-ORIG-GUID: sBMZEFh0AbbTiaCVFJeNz_YT0K_woWhz
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aecb1dd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=TtZx0lvJKI4lzRINSrcA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX+wnYJYQYW/ok
 WVolYeBrHKky29dFeP1gB+Lr6l7r5Hutr+ugVrYOWHz/7qZcdQsY1E7CKUNfMtiJ56OZCA5Il/N
 LvVpfVSdZQaknJ9R3tJwQgoNOlLNCkVzQh8bbGkj6MlmOKZfKX6vJK8y9aJty3JTz/4vievzyAx
 1njKdlzOM4IN0iISTEcwrMaMt6M+8kdLKphbC8Y+uGfhzHPhvrCxxNRda4/vZxYCun7wsqutF6x
 Vlr2DnaVAXuVBk3vE/QkqeSGR7abOaUiMyKmjkeFGZ4v25EFoyaxmFmHgyMNy0P/lmWZNjoPsUK
 teZyeeXY9WA9YltNGef9BQaPLFVp7g5LufktFplocEjGNdikInhNA1jpNhjIUlNAkWoblDtxcpb
 zcF+0G8B0lsqiIpGofgRJJFPVgpMyzCUu5JAq0A0amwGkWCgoVggWqwYa7DygVetaz7U7zvhNLJ
 +AVNKvGQdPBuK6DqzZw==
X-Proofpoint-GUID: sBMZEFh0AbbTiaCVFJeNz_YT0K_woWhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050066
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

We should be holding a runpm ref when we try to set/clear GMU OOB
requests.  Apparently we'd been getting autosuspend lucky before.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c         | 2 +-
 drivers/gpu/drm/msm/msm_submitqueue.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index dc89573881c4..cd59daa02bf9 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -377,7 +377,7 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 	 * It is not possible to set sysprof param to non-zero if gpu
 	 * is not initialized:
 	 */
-	if (priv->gpu)
+	if (priv->gpu && ctx->sysprof)
 		msm_context_set_sysprof(ctx, priv->gpu, 0);
 
 	context_close(ctx);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 8d550d281704..4d744604f436 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,6 +9,7 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
+	guard(pm_runtime_active)(&gpu->pdev->dev);
 	guard(rwsem_write)(&ctx->ctxlock);
 
 	/*
@@ -21,7 +22,7 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 	default:
 		return UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
 	case 2:
-		pm_runtime_get_sync(&gpu->pdev->dev);
+		pm_runtime_get(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
 		refcount_inc(&gpu->sysprof_active);
-- 
2.56.0

