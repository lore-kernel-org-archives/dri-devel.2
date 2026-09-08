Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73EBC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0740410EC9D;
	Tue,  8 Sep 2026 15:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiBmo2ht";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dbC/x5YJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DBC10EC9A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1LLv273448
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=; b=hiBmo2ht9/ogEfOm
 RWSCAFEKEtqiCWJdaZUQQQgm4vE4G6NlWPNpfLArLFzhSabrZSTg0hXdV76BdsHD
 pRR6YZ97X5FOklpoL/waKzVxWjS7P2Psxnu1xYDts0L4HlNvmo9I2A/vQyXsO7k/
 YjlEe8A6R58HZGJFcMZu7OryG5sPmOblo6fgIq0t07Ep0ULXOaM/VGfTPcV5SFcX
 gXt0SHK+KgGqgLbGnwtONKK/6fT9FS5AEOItw6XpKT0k9H7wtfhuAmG1i/4TBIWN
 EtXkzgc0NbWmBqEtTi06VKSDjjT/eU1SS4eN+1BlPyEZV8Cn5FPUpasUhuEkhjLc
 3ISQVg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0paqw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:27 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980882ce555so371770241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881066; x=1789485866;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=dbC/x5YJHyFKjjn4M47RIUUQion6Ncpy3hIH3rIvN0+cbQLCLg8BOkFZoGHFG1leA8
 ymFRom2s+Teoc1VVFNswmeECDl06HboWYv33NQ5VQNufkn75ciEGOOrn9wOsp3LsfyHM
 oKgP4L+kFl1KL27HEhRhWCRL8gbFDMTQIAcptubdxh5AVja6ORY8JLhG4XZbesXvSgnI
 sLwwlXbkeBsP/IDZvcGdT3HbfrTN/Ee+aAxzpRiD1zbkhmNvSaIgd6bRqiUw0noIy/iK
 5gfandc9teGVQ9ze8F11rXprTfAYwoGeC9xjCJ6Lfyw8L1nCgT2Mhti6V1+JOUcliiPm
 4cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881066; x=1789485866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=MQWaRgIVSRikkiB8+CYzcwc7UI+q3VKjNOoRboynQz6NEBDnjdX6lgOOOegy4JD3+3
 gckmCVv3F/4svYZFJIw7Nx03RSmK4GkVN6yjvHtoXNlhwlgJ7gh6KefSi3dEYuziIzeB
 3ZD+ZPltCoOt9tbxIqcQXxVGrvBqVTNCxulLnijr6r1fsebLkYWeHfdliBe+3qN5eB1T
 cDJUmzX6XkPvX4nGZH5URPySYiEKVzTfcFnYlryvS0gnto+hYHVICwLnGoGarZbj8O3F
 BVSXjsyiVDBZ/vNOOBo0aK/NKGqjBce6B193Viagv56rFMbSBldi2clemQ5YYO3UKY2p
 xb2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRe7qzlB95M7zeQA/P4annuBLVM3uwsRaXuGBNkeDbi284M8oHarvwdrhjHdTA/7bU6dJfurSV2mE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8idJqZAi2qGfdBG00GPSmcAaXRcFijRRpoozvS5Df9JvlBe/x
 iMpBJzGYwZyMcyHidb26bgTEhknRK5CZcYgwEqiNIfTritc4TmT5+n8xJBBuiWM7+XcaJBNMJzm
 cCUNKWg63gtIytz+r4igTmMuDmjVH0PddebJyRqodSjmqO/AyWepUDFfh8340U+YPLUnZ8nk=
X-Gm-Gg: AYBFou3ohYFO06b1f4DtX/dO5JdnX4n+rjwKnoOAWj9pj1sp2e35UXAd34I4Yd3RJuB
 yrLDf9X006qCJ6hocTGGJLjgI9iQBmOUtpZJRV05/zBz00BQg0iJ0RdaOcFurgEyXfyVT99iqnz
 3rCPmhU7thHsjGOsrqhgy+GViDytR1HzVcQJTJM0v/2snubGYNHP+umgmRoFwQR8DjXgaf8Gp9o
 o57l2TYH+kXnaS0q5VhRIqAL4NNybIfy5hOlFxWphy3CdBlKaDTswiALlqtc1/fAe67LKFoltrs
 RkwI8bra4YkagNd+WyuAGtcQZ0gOQwUMMA/VRTcq0bLTekZAKyOGykwaTGBVJlBFfsk/U13mLSf
 klX+gBRznJ6XGM/NhC0UoMeQKh6PDR96VGC9Mu04ca32MHp9fCQ7GaLHpgV+DCIM0x0XPavfXU0
 47KQqRfkmQVMXC
X-Received: by 2002:a05:6102:4486:b0:782:df51:aaa8 with SMTP id
 ada2fe7eead31-78f7423f9cbmr14190137.6.1788881065145; 
 Tue, 08 Sep 2026 08:24:25 -0700 (PDT)
X-Received: by 2002:a05:6102:4486:b0:782:df51:aaa8 with SMTP id
 ada2fe7eead31-78f7423f9cbmr14162137.6.1788881064611; 
 Tue, 08 Sep 2026 08:24:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:14 +0300
Subject: [PATCH v2 6/6] drm/ci: mark pixel-format tests as passing on
 SC7180
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-6-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b0Cqqqr5RXysOo/IlbQaAaOsD61faw7dj63ogkvFqxI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCib6Y5Pj7I8tllYLOX/kLmn67Beb5i/WqL5t
 cBNeZzNayeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomwAKCRCLPIo+Aiko
 1fAUCACtazS1FGVD/8UxL8J6pmSEvyvjL6Iu2JeX3qFMXLwKH8qc9KO0dvBoC1hlU17CsRksxy4
 V3jOzlqx1wAp7t/aSKKw2PUA1kUdYadfv06Gi8hC9tTyUckEgN6XwhMyf4Z6Op2BvYorKfrOovH
 0sEzp20XF2rcu2p3mMRrcf7Dyn+rJ7S4SQrjiO3Zs/jMG8ARjuZCtq4LoGLTlRg8wQfYaqx19j1
 6RFK54kVyyeUz4+94hyoEtdTq/dB0MCeuFdSr29zpKs3PM7ujV8rY/wwu3Dp1Gpc0YVfNaBK4MW
 a9y5H6yvL6TUXKH3oe2Ij1Hk0x/WYihYtdM41qc6Yh/IgyWw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 9bfmZA-0n81kSJ9XPB_CMB-lh7N25wR2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfXyv6f62R1xidP
 A7J6EwQb1OuxyDZJxSk2GVuyKZjgrygJNqAHSl98yMGIeMXQDekfXp0OHAG/DLvGhJpQbF6ZgIH
 rLC53So1O2gL9xixK6GN8rEvuGl5Wjo=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6aa028ab cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_1_hEmUK9n4M9CbZuSUA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 9bfmZA-0n81kSJ9XPB_CMB-lh7N25wR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX7087BA69d01J
 gFix6xcQHtiZJOohN2t8HgU7BFNoGehBOj7CenxepgE9F5FyWbPJlUuLASXU1GdJpRXfcuDFNck
 hnqXtxKIFvSW24/FP4wAfPaS/ZNaaak4ykd+MvG4y/o85XrWbu9zj4JjZ0kPZGKcMcsX86GZXpz
 eKzZBi+qwY8Mz42PpKbqKEcRD38jAXHVbH7x6qRAohpGyqAtKtWChYDBm8MJeN2hLhEm07kQBYm
 FVGf58QWv9se9eJUDUwRqlw1g2pbqBHHLnxOtHvrSOAxc6heeb9yVrse02EqRClJwGz3FjtsUM1
 iZj0ERbAlyP0FM/7rtey8Yjo5OpKspZmZCG56fXEREKfqAAr1BrfORhPkb3kqcFFwG8HT4u+SU4
 FD7okZ4XL4OXWB7QrpXZCd1b/UYa060VwF4tMBNxwwNFftEJ/D3/mzewjWMWFvQdymITVnYe6/t
 BJucisuhphNl5jqGxcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080166
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

kms_plane@pixel-format and kms_plane@pixel-format-source-clamping timed out
waiting for the first CRC once the test had set a legacy gamma LUT.  They
pass since "drm/msm/dpu: only reassign resources when the encoder is
reprogrammed", so drop them from the expected failures.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt     | 2 --
 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
index 2daf4ab879a9..ea3013faa37c 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
@@ -18,5 +18,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
 kms_plane_alpha_blend@coverage-7efc,Fail
 kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
index 2daf4ab879a9..ea3013faa37c 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
@@ -18,5 +18,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
 kms_plane_alpha_blend@coverage-7efc,Fail
 kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail

-- 
2.47.3

