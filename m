Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F2BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF5510F8B1;
	Fri,  3 Jul 2026 19:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKWf2GSY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IACRSxFa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C4B10F8B1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:42:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Hj6Ep679223
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BM7jtgPz5pu
 XtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=; b=jKWf2GSYBWt0WCeSTarF/ZyxiwK
 ySviO6bqYuR7hXocJXWdOzctBTkhr9x7EBJtne4ZOFmY2TQnOa/Gh839O06jG1Z7
 dooiFHxttTiabG9BCsQjg42O4/YG3Njl/KqjnIDTpKtWlrEa7Oz6uExs+CjZECUi
 xjJD6IMEajr2OkDLA3WKBxxOfzl0dQqBxjqVSPjOoU9RaH/p2EFT7u56Y4OH0mzN
 ZRdyYM3r4dJMbR3VmiLwRyPjjK7ZwaTZ5+BWp14AX1vqD6b0N/1+keNALbhSW6GJ
 73bXzhYTiDhE7iSf9SrCIj4lzRwnt5YUmTfWTl/y5PQ/BXjK1zfMPAEFh9Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u32jj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:42:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3810960140eso1447910a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107759; x=1783712559;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM7jtgPz5puXtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=;
 b=IACRSxFavU2OINgkv9MUNM+KQRuMXetMxzC9gqzf4uL5X08RU8MJS+aJjOFT0S/pU8
 e4LPH3U0F8VU2kPzZZzVrmoMZ2BdI3A8vfUOSFd6QS7aQQNzEOiVqltkpsnA0e3iU4Lh
 s3jzFGXxeiBIOHTHaaI0TGuLwgkhSLs/Ps1GAQT62imzxB3yTOKajhdHl7Q9DxLAvrc8
 BBgyfYU5eu88OO5Us8N+AGPx1L0pJmmR5tlObMPiH7Hd5Xnyh1PgznFIcwomKqh/Ugfc
 KCFVz+/Ws/oZbJUf1/SbIfzkzO1Ox/sbzmSGJW4GXVPdE+hKoyMWPcJfFCYuyToiDjr0
 a1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107759; x=1783712559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BM7jtgPz5puXtMgobfAPTx0DKFPGBIZQqDVHqsjFOZI=;
 b=ZEpjqVH+fAgXgMkqbfpXLWWncFxvOWgo5aqnjIn3F1segB4NphTFT7yRP4/FcXD4o9
 k637nl5jYFbIzubmj/lOquzgi9pLlV69JVxN89EQbM5NBOXnX6BOA/42z9+xO2NbiqK4
 FGgl5z98TSSjWF/SusDvXvfV9YjglBDGtHoa9zjXKjQSt9hScvV9UNMhf2kqBujme4tk
 53ykcTzd91UGnVxdeXWaTLf+WLTFFiUGZKvJjgNrqglTRmGKu6Y2Mx/L2MgiWoNIiwje
 Rk+RNuAFz+SZDTRmH6SGfnWaXPeTILrzzNntNoz8nn2SVsjCN9TAabzD5N/NDVy84L36
 g4Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrILTbEFJ1fHV8nv+cnYN7xYjAqjVUAEblvGgUg/9RxqMWPhjz9QUMGUvScYxkWsPnR85iSe19Dp8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBeQSeD+G/+VMioM6AswBUX37QmQeSAR5yGgWPSy40t5B6C60n
 Htt/iAr90xyAyPdWNBdUjWHQWTEuCkGHZDrd98ZpH72Mywv61azkzhbS7k5WCGF8To4Nl4qrNVK
 5UCZful8RGwf6znbCVE24C6H/u+hrGv7OrzAsgYNTVR7LVRPIgHNXgsDHMVAz1QbcPIp2LNs=
X-Gm-Gg: AfdE7ckAjy6Dj3+kPPuwKNPPhRF13Ho3IRhgcTHoGedGZL+ubSW5vl/uXPpF8HkWM5/
 5TSzPcZXKzeJpgUtQXFmiuepkaW9KpojYL+zOfniyDtnNgS5dOkaKIvBBDZyenM+FPrU77NPmQR
 D2vFknGOODw6lGz9wm1BO2C6Fmt+/qh7ChNMA5WIKd5oL/bMmRz3d1INB/PEiRotmhvVojHLVK/
 pup12H7c01OVz3gof5Hdi7cDiDodFSMMRacpzC5t+gsIV16UxLE1j2uYnn0P9MAtX/M4Ks44wc9
 q6EV0PLR79iB7PAyvMaWV3dvuMLSfB9CL3BejJTeQY2I06CuvEbtjOS1tLH7DMa2jKhw1bP/2pP
 nEpxbueoepBEOuGLkpSwvJTreCO1GZcBxJplSFQ==
X-Received: by 2002:a17:90a:e708:b0:37e:a09:2640 with SMTP id
 98e67ed59e1d1-382807ae330mr703154a91.7.1783107758442; 
 Fri, 03 Jul 2026 12:42:38 -0700 (PDT)
X-Received: by 2002:a17:90a:e708:b0:37e:a09:2640 with SMTP id
 98e67ed59e1d1-382807ae330mr703088a91.7.1783107757826; 
 Fri, 03 Jul 2026 12:42:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:42:37 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Eddie James <eajames@linux.ibm.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Houlong Wei <houlong.wei@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, linux-tegra@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 08/42] drm: logicvc: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:21 +0530
Message-ID: <20260703193855.110619-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O8maOzxA08CbgtVRX0qWaWYoJG02syYZ
X-Proofpoint-ORIG-GUID: O8maOzxA08CbgtVRX0qWaWYoJG02syYZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX5Hu29jMzK57B
 6/sONLjOqkKrl9inB5BihUbk+oUgH3JeYN9bF/AdnfR57pNPPhsohvwreMmcJcIF6Q5vtO4Z0om
 E7FPMpHAjA/bX0QmhOXT2foQUxLq7Qo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX5/du02/0Q4EQ
 1xlLyXCb1IB7Ih+LmUbMdBlFZuc3vbosf9bv+ThbVUa3HJ1jWEtAn4B92t5glCJHrOq/pOa/GDu
 Dllqx7S4hqiTgsWvvkUXAtKT2lJeBRytvAZn+sZPAbMDyEDP5Diml3T4w1hJ+y7LTYvlruyyP8m
 JmG8CIQgcRt8mUdN+KUdvY6tC/Rh+jVqDwWmhA45RHRqbdiIOxuhMP5LdWWeHfzr4Z/ZJgwvHqs
 ogrImUUp797jGdoiku/XjVgDf54HcPA8mZDxQXRCfk1T7QqM9MWnx6WtHb5pNmaXvRkVxns6RZp
 j4DDmWxoZoy33HO5QSuoXTQ9mJGjf/G0rQgLRMFuCVhLTUoDZUtAeIamgu7DaZf0FxgeKMcwpiC
 2j8SjvWITDp0VIq7HzXCm+OtIQ7zv7/c1oIcvJZsuew4cBmxj/d6al6Z32xIQADAx1zm4pLH5lE
 t+IVllmVCa41lL493Xg==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a4810af cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ReI0EElcLHst8dYcsfAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030198
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

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Replace all error paths that jumped to error_reserved_mem: with
error_early: since the manual cleanup label is no longer needed, and
remove the explicit of_reserved_mem_device_release() call in the remove
function.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..d6dbe52ff0a9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -306,7 +306,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Failed to init memory region\n");
 		goto error_early;
@@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		ret = of_address_to_resource(of_node, 0, &res);
 		if (ret) {
 			dev_err(dev, "Failed to get resource from address\n");
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		base = devm_ioremap_resource(dev, &res);
 		if (IS_ERR(base)) {
 			dev_err(dev, "Failed to map I/O base\n");
 			ret = PTR_ERR(base);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		logicvc_drm_regmap_config.max_register = resource_size(&res) -
@@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		if (IS_ERR(regmap)) {
 			dev_err(dev, "Failed to create regmap for I/O\n");
 			ret = PTR_ERR(regmap);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc = devm_drm_dev_alloc(dev, &logicvc_drm_driver,
 				     struct logicvc_drm, drm_dev);
 	if (IS_ERR(logicvc)) {
 		ret = PTR_ERR(logicvc);
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	platform_set_drvdata(pdev, logicvc);
@@ -371,7 +371,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	caps = logicvc_drm_caps_match(logicvc);
 	if (!caps) {
 		ret = -EINVAL;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc->caps = caps;
@@ -382,7 +382,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	ret = logicvc_clocks_prepare(logicvc);
 	if (ret) {
 		drm_err(drm_dev, "Failed to prepare clocks\n");
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
@@ -450,9 +450,6 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 error_clocks:
 	logicvc_clocks_unprepare(logicvc);
 
-error_reserved_mem:
-	of_reserved_mem_device_release(dev);
-
 error_early:
 	return ret;
 }
@@ -469,8 +466,6 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	logicvc_mode_fini(logicvc);
 
 	logicvc_clocks_unprepare(logicvc);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static void logicvc_drm_shutdown(struct platform_device *pdev)
-- 
2.53.0

