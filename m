Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E84C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0444510E704;
	Sat, 12 Sep 2026 12:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="agBy3CGY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+4yKoVU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF7C10E70F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdWUZ3272561
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=; b=agBy3CGYWFJ5DI4x
 eTq4qneUlnWTOtXb8bDHuABNK3AZxKJ0yLcBzvNsDbChUWZ7g477OBfwbQ9b9dJl
 lz/4ubWfYJvkkH/w9wGTdjpylkuY1iZn9x/xPqFOWneAzd95COlxTk7TStdW/6St
 84YpiPFgifrG/ZOjYe6ZWxn82GA5Gmyqr2o1gND/PQFuNoO8SfwamMu9//eDAD7h
 FyPeJcWgrhjQD/kMBxF5S6aH6AEDGzPqq0B2unkytcVga/wvsj8L7P0fal4rMSO7
 DmFocjphE/SITiiLtSjr41dydFZPavOJ1BXG5ebdbh+83Rb3h4VhdnEITAEu8HFD
 oaK0/A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgytj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:40 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c683ca769dso683218e0c.2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217320; x=1789822120;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=I+4yKoVUOYxPwSRsTvouuXWbIZkR4VQCyteJ2969XKQYXiXOwoh0lSuk+2+f9XQPwT
 mWDW1Mcgdmbaq6aGSXBCxKqOhb0EEfpUwj2IA+/RnDYDZD+bBiPSdySe7nfcLRZn9KXX
 5SS77vkIUw9thNqgSn3Gl0Cur3/aguV4gQJQsQo+CT6q+8Drtmb1cUUqEpzQIrIb8n4g
 QbYVa9pneSInkCSLyOqYaj6v7cM4TOG5HuQ2yhkM5p6UiHwMzJ+iOklHZvG/7Y25WMib
 gPyh5WAmUNNRv2hbqQYoZUQNmMD9UOnnnZgZlegNoR99d0jqfWjsRJkCOsVRkOIyXc5/
 h0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217320; x=1789822120;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=Wtn3/Ok6ZmBS2V1xtFfEw2tARmWB0Y8N3QrIBQFiMweEX4yJEnuIWobx5YckqHgupK
 C6VxnnvAqK/hKZl7gYqJJqhQL0XNJS6tTy7gbVFinY5GxU2YkLGb6j3x3Kuu7nWS3QWZ
 fbOmvvQpKPlx1n5zwVLo1t048EbpTovbqWi8UNJvXr2sstbCCNjbdvC+IgjZsqsZCClL
 yVutFdq/T++L2Oh3lBVhDRAh6RTaJDFc/ayMmz+OB4nIgpuajGzgGg+QPeUdPw/9p3+N
 YxMcCFYvlxqQjovuvZpw/4fdxtOtSfonApqVdH4K8BD7kZmP+Sn1hniUFy7jFgffP8XP
 ReSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkbHAoZ/bLExbtL2dUN/p5fnqowp2Tam9EYZpl25xRqtERaszdRhrWHQ4dS4ltSF8IuQwAoWiYPLk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfLqR2ye/sxYJkZYOxAPPSDW2Z3ZUaMXCNmvvXYIsIqi+I/1/Y
 oOKsFclCIWJ0WGZ5m3LlKVf/p1QY06lIkHALV4lTjD0w0djDWiv0JGjwXCm9A0vBTzdTQEgcclc
 EBqPrhynI8A0e85pL8cg7/y/PW41eA47Ep9Mq2eEwfUEe78yIdw/RHr7RVGrmjxVjSMjxMFI=
X-Gm-Gg: AYBFou0YAOxqUWxHXHHTynH73/nGg5gbHoMOArDpzy62gWmjnYBVgB5Qk+d+P7pKq2D
 10V4QYI/5bNhbduoWsmNEBmXQFoXMPIm2zmEz8W972BqQd4965hmh+DzgKcSAkW+6wIr5Ln9x0V
 77EiZNTwbatnF74kSYQaa36IPIS3/xQVOpGnn6w8jjFgDo6QenzTW8xGLYa2sfQeNJm9V7o7bKf
 WuZg045aE/Gtgg6lWfNeotXEJOwh2ilsIp1yLmZPTFRjKJX0i8ji3ZQmG3mtarAPxnJQageJZlV
 EaK97iaYXOp2fEgbeeI42SKSSOoHhwmk1bnLa5W35kUn3Ip8gCqhIv+LCxOvJVAHY+jG83nCbdY
 IPCvEJfp0V8fRaLehRl7l/6nOJfmQ9V4cbyn93cAtZJj7rqaI2eRyBj59lKPpZyAscIxjjnBwuc
 dSTz1/UZBc5xxy
X-Received: by 2002:a05:6102:390b:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-795a0ea85cdmr1722630137.0.1789217319828; 
 Sat, 12 Sep 2026 05:48:39 -0700 (PDT)
X-Received: by 2002:a05:6102:390b:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-795a0ea85cdmr1722614137.0.1789217319453; 
 Sat, 12 Sep 2026 05:48:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:28 +0300
Subject: [PATCH v3 8/8] drm/ci: mark pixel-format tests as passing on
 SC7180
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-8-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoX05zXcOAfkFqrJSW34pjmtrAN5/+czbqJT
 E1f17mbnJmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1Z58B/4r2dJLvpGdfeJ2mE2IkR4JV4FYoW5wZOTXRVl4nIfbVoDce6hkOP/+xHDWzJH2r5DsTU1
 ++CAFw1FgE5GjA2pfBne8NG4Rv2N0tsuIJNfcw9WHPAK+n0UWD8WngN0CASzx/8zQ7mhz/ltPx7
 JD9hnynNn3gd4duwzUfyLB7ar5xpS7T6qeFPnWn3qt/IsflzBzGd2JiR4L+IQkzZn3ODhWybqGu
 Q+4yRseusadrwzDOl9UDU6FFZtvLRKX7Rh9BruzLQbOkqVtBRBgXPH4DygGz5dEF+Vvl9MTWE9u
 f0YQ3zN0PyJeFu9eeXYiYBaus7Vc2BIS66ncbEl2g4OLri6v
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX8Gc0g7RdvFBP
 Mq16Zhkjc62v5O3PpcxqXIc/SbgUkIVRABx/v/wr9LRXlJqZJEltoQcVVyxEvajeUjtH9jvw/rt
 TvtyfsVPvZrGi9wUEat1FqWc1xbtcdV8XDvjviJ5kBrjtTaenQNCS5zuzUI9hLBUfp8fFdx9Qbk
 JIqtVCy9QVoqlTbwJ17CezkNUwr4WsZjkN/z9hCEqA/TT45n4kklxARGngqdjNJbqqHhJZ+hODj
 g+dGBQK0zuTEQR8tlntgNMLP1wiPSST3dxTVzSrcfXGyDffHkQmHubVEh5Yn6BKfN3v+eFWWV0A
 0setuNjO1cbHOWiC9UU3n3smRkxMZhtOcuVC6QvABMAeo4b3VRFFr7CxtO6qzyErgAlmNUcZwl6
 81uvzWW0KDucOm4TOWlY+yZOkKearwRG88pgw9baUCiWlW+TbgWSNp35WlbJqJolyIdNjKHM/N4
 uQ6RNvpd+ezth+D4JIg==
X-Proofpoint-ORIG-GUID: PMN3qaFjlB8UDIXrmyHMscx-wWPsoz5X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX1E0PuEC5796/
 SiEdK+tFwxQSgOoaqdE8/NPziTQ7sXJ1iJwQ4fkEyjqAy/+DrhEKKqAeBiV6vMQsonzny89CzdK
 UvuhyRWK7AKI8E4+oj0uAhpTBCbJtXY=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa54a28 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=_1_hEmUK9n4M9CbZuSUA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: PMN3qaFjlB8UDIXrmyHMscx-wWPsoz5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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

