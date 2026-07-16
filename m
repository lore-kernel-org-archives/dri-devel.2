Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1525C44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC83C10E33F;
	Thu, 16 Jul 2026 12:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRgQrzqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4dhgcqu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC6D10F2E0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBjBqX2506801
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qpH00IOQaI/bqw5+PSR/7ymija6RdUIbqHVAIBnnA5M=; b=CRgQrzqkesW4oIVV
 7F5rRIcYbXHguAE155t4EsEGyed4PIJd7wvNTKx3WyzV42NKUI+fjrqNFoz2hi8s
 DeoZ0QWzERUbfaSebfpdqIVUcP64kxGyhlM2qYur2YTaPPC+zuBh/FFWi5pdp5uw
 f/S8jHKypi+wYU8alsaEQabyyZOK68kOd6csdaJYkY6PAT8Ll0yovJDve+kojGHZ
 GBRNGxfNto/c6Wy9Zz8SzbCi45LG4qcf/vUKUlx4RJSoBcWeBgrZSVBHx2Fh2Eaq
 b/CsYkB1nNhg9LPoe+jXg+OM7uPL/av1dl1g3dmn7zBMX8VpbjiayLBD5RbDS51i
 5uhETA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvbsdr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso61045491cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205126; x=1784809926;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qpH00IOQaI/bqw5+PSR/7ymija6RdUIbqHVAIBnnA5M=;
 b=j4dhgcqu4TIM0/ftrgbM2AnNPKUQCw3Z246jIxbFdFe1jZgaaJ+hRKdh2RbZPakV/V
 17w4NXbMs6hfdjFzbRfde/6gGJV22QRB4KbdHxXEOSFDU5x5MbaF/QHovu/ZnK/Ls9aR
 m5LVmwE9VW6W24bxrBbi1iKXWN1ZAm8RRmUGFuqNGxqNIFGGdLwbLM6iiJG7LJw1IHQi
 LdeFo7GJ0xlt6znP8eCX91/yObY9SEKZUor3kRfOloBSnneoiMBnf7hpYcAZ2pbTkBRN
 rbMglFnNkd9t+mA9ykpG3MaPcUXE4kXwFEYPi+nl/a9ed4KxacVkNfVRCljSYdOwqCoF
 KnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205126; x=1784809926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpH00IOQaI/bqw5+PSR/7ymija6RdUIbqHVAIBnnA5M=;
 b=feV6seYC/sgSSVCiGfD5Q08jGGhysBngstDp6Nj3qAmx8kTTvPXgkjBiLXXTvHPAjH
 2XD0W16L4793mDwb6xxJzRAAWsMd/qj8aFiQ43pkK2/+HNb6tV9kM0uYt70MrQse/XQF
 nazSLDGKBT7NEuM4hTW18BRoRWYmp41xVkTmpjEnFY8iYpD0lLkPM2sC03Xo69xtYwYZ
 mLIIiSAneqLaZ+ziyXblcoBwu7Zj9eewUukl3NbKXgaHq4zflDcsh0PjqW/JeQXiEbzS
 Fg/RPtP8PzLlXTtmpgdRhfucc44KwntwtKQfESMwJxdafN82nnvyPq1xkxo3LX8oEKDQ
 /yGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM/2IIdYX/ENrPX8vOOk9T4dvjcYK8ZQjRSXXy4k3Zqd1GXlyxr1biJyhEVX6/8AuiJ+hfNixRc70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzBt4Ge2MP3KeWzEBUnei4FFzwTCmYZb1uM4kn//NyAq022LYd
 +SlYjwngkBXrsPjWMi6XZ/oSiWWjq6ghAI8ov6PL1inCeLPgy3iR3Ug84HAc/D5BNfBCausnO1R
 IBuAo81THllKHmmHO7QbOuto/xcbZLw70iYZRN1DiEI7+jdiTwKNbL1dTEtW8cZmPOEYfp9I=
X-Gm-Gg: AfdE7clnvUH0ixJbJ2UAB15odWokegR0t8EF9qFqC5Xex6odt+VNusBNVXlWZ3z/oUI
 B3KbIOqqn57/kmLuyCjsowaDGhlH/C7YRp6Pz5JzUt9g963w/NOhRNK6yV/ISNiKJRshwYsagul
 xCDSf0bQbB1AUp5fsWpn+n9Edco0f4Arhqrd9tUdR2/5TFfrkmP0ZNf9p0uEmmZLBFFhbvnq9cK
 /k3F7syvsgWWNgNELTcxkiOr/a9sYGRUJLcEI2X91oaOD1k2dxY43jCaKn1vZT/nhTsnhUFBu0O
 UFTR3f+XciEdqBDbGU4uuLmH9v5xInexzv2jVMkS4haEJvRMuLlY2NxLmXwbXYdGg25PbJfrC77
 3Bobdikxa7AbzJynYDGznBTJGYB4=
X-Received: by 2002:a05:622a:3c6:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51cbf34e7d3mr215997841cf.79.1784205126298; 
 Thu, 16 Jul 2026 05:32:06 -0700 (PDT)
X-Received: by 2002:a05:622a:3c6:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51cbf34e7d3mr215997071cf.79.1784205125413; 
 Thu, 16 Jul 2026 05:32:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23766635f8f.33.2026.07.16.05.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:32:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:31:39 +0200
Subject: [PATCH v8 4/5] driver core: platform: unify release path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-swnode-remove-on-dev-unreg-v8-4-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: brgl@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6y0x3dVDg6MbsMReImz9V4/sAZmwhZnLqrvpq5yaKmA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWM855KGpNaO9QL7bwoMnsMLTBpi+7XZHEziTV
 So+EpZSkbWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaljPOQAKCRAFnS7L/zaE
 w2swD/4+XMquiqrTLlEE5V+DkOFKbQJCB6v3BWln231RiWMUELuGlSJRmxQilk6NjMIEn5Tfi+T
 6M5dx4/ydhrlr7funY+g6Mezl9vYxe5vGVcd9Yk7xCQUufFcK/sWmNhX316m51czITDSwp/Paiw
 WowWE0ebhKwNwQyI5FvAXUn7k5atTt7TBqqhQnXZzlXW5AVW8tGEAsTvaHxaKRKeWCwW4r2Z4Qa
 HZ6eOlJJJkw9DCkrhZKH1vGK6thNPPJp+xKVOCmWL8kD6UEP1zlZrxr4qQXJMkZQ+fUvxDezaTG
 4DyHdpUpOnntHks9d7tM6Tdm3dDc5J6nh4jzJ7Ww5CeKORy9gykBuR6vY7kegnMyqXdMyLic18T
 59NoLcv+7VjkaaQ4kQTSojULBGu5XiGKwpf2tIbWTWfUd4BlSmR1lErbq1FcsbgmiCcC31mSWN0
 wU6/shhVs6OHOr33p9XcPSu5e1C19taokpKDjoxftJcewYCA/7t9BEeF0eOwvEXgGWwSUMDIs07
 YgMJyPe7z5uP5Ckdak9ydbrCvn3A6rwhDThcLp8MA3mezzW3IuH7boUILU+GylTrOZTVpgKdSDG
 g3RL2zMQyWvV2xQJ++dNNd6I4mhYzWYqfgLYJ5fV/Q0aBcT2TJ30ytxbx3rWMzrj0N95kQbcthb
 S5QmZDNmeMuwchA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a58cf47 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=djyy7gggcHwf4V7r8BUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXz3yL5hsOwPvJ
 AH6mo/dQn4y2tHJoy5YXk+8SojYyJ5rS6F1zxJhQGUL3TtpYlob2RqR3WNfYWZX190ERERomu5N
 tkLzYGBFp5D2Pb7COhomCtLbc9VhCioBWCJoe1BRMluFnaA9xjlW0Se51hsGmA3jUbuGbDA3Cdd
 MTkiRFmzM0qwghBFZODRsZA57kpXYZAmuu/BKhVhlF5RmCFnLkWCiGBh/ke9xx543gq1uDyIkR+
 V0R5/a754kuPdaXIwqrts/iux6avsJSIiMBCju1T4Rt3D6WBKIEOwRxDbKM1xmHtQV3MSaCZeTC
 bEDbxJvs3cobLfBVrY/ZSMcQxG7kMkyXcZgFu0TQMOY+3upxXqU0ci4KN/5qEy01ZZE7IBr9tds
 r6SAeXar66vKw7cvb7scsxJ6rfuXeTVfsKAO5GhsTvHT4v+se1QmF0uN82QxhZaGPP+MLdc1k2n
 cXpPXBsR/1ggKm02klA==
X-Proofpoint-GUID: xr7KO-aeJKQyD0t6f8BsIXkBLBhUnikV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX/1uEiQdKClFc
 rpNU03PR5gksh55qMVDSW1m33TqvN69kDMgiybjYo4oRuYz3OW9Z83X1e0FB540RgQPiO+AiS+d
 D8wUaMHnuQ2mM5f3cg/+Pc3hy7AWX6o=
X-Proofpoint-ORIG-GUID: xr7KO-aeJKQyD0t6f8BsIXkBLBhUnikV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
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

With no drivers that manually assign software nodes to platform devices
created with platform_device_alloc(), we can now unify the release path
and remove platform_device_release_full().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb57d487a6c2aba799b4ca5ccd089006cf2d8bf6..66f9ec73d47e90cecac9217ff6e0f051fea5b057 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -599,19 +599,19 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	fwnode_handle_put(pa->pdev.dev.fwnode);
+	device_remove_software_node(dev);
+	/*
+	 * If the primary firmware node is a software node, its reference count
+	 * was already decreased by the call to device_remove_software_node().
+	 */
+	if (!is_software_node(dev_fwnode(dev)))
+		fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
 	kfree(pa);
 }
 
-static void platform_device_release_full(struct device *dev)
-{
-	device_remove_software_node(dev);
-	platform_device_release(dev);
-}
-
 /**
  * platform_device_alloc - create a platform device
  * @name: base name of the device we're adding
@@ -960,8 +960,6 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		ret = device_add_software_node(&pdev->dev, pdevinfo->swnode);
 		if (ret)
 			goto err;
-
-		pdev->dev.release = platform_device_release_full;
 	} else if (pdevinfo->properties) {
 		ret = device_create_managed_software_node(&pdev->dev,
 							  pdevinfo->properties, NULL);

-- 
2.47.3

