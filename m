Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B26CC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC99810F8C8;
	Fri,  3 Jul 2026 19:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fscb3jby";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ftfB4vdG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F07D10F8C8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:47:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiX1R675368
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XCVg1Q659eH
 nqGdg2uBsHFKkAe+klQJjKZQEFOh/ZPY=; b=Fscb3jbyODRMP+LYFIFJPrbKW9j
 T7wz8PRC7scdBXFhD+ON7mjQ4uJAAYX+dl+COgx1dk9PHFteC9Oom23fyWpv4Tv2
 faD22dG57wKf0XAZBp4MmlExqTGeqybkUdTWUKEmMh9sTp0lRLkkAwYSfllngB79
 Fm7q2qvKn6tFDy4yuommj035Hc23xZgjZqav+jb4ZX8a2fUwTfo/8dYjPzaXd2gq
 xGcAxz4IYt2RxUoXKTu97fNE9L/YSHwH1wX3qDLrOYLJbdKAQA37AL15B7ldtQc4
 5OwXQoxeM58coao0hEc5yVFAK+/31GfbEZmpTdRT9RqL4g4fRuIG022A0rw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1hda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:47:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so1713549a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783108050; x=1783712850;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCVg1Q659eHnqGdg2uBsHFKkAe+klQJjKZQEFOh/ZPY=;
 b=ftfB4vdGDMVOHYdqkx6zPa3yHmrnQuI+jOq0l5s+tKgSuJbkTnSzQJ4jaCLly98xgI
 aZpgrHGs4j+mHO6L75ceB9rgnGuyuzHK1UjToFiLYnCv63PXVsY0Dd6r3KoqPdaNUnLO
 5oDhE83VjtbCiegWulU2GVXs4VI+YhDxCxy5lUSUCN1LsHm+2uxJOJBJGa2NXYB0MEI8
 ziIayjsVcjmgzPjSNWEjI+le2lzMlkcxNz+bJgUjoOuUqTh+XpuZfoIkzIP1SQpH+0Xz
 N6p4UzHIf7Lo2kTF8LOBQZDw3Qy3iHMT+oqF6b3XFF+dqwTG5Ha+idZB9Z5lJ2RxcmEd
 YUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783108050; x=1783712850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCVg1Q659eHnqGdg2uBsHFKkAe+klQJjKZQEFOh/ZPY=;
 b=aLW5Ug4RQjYqHasU/Q/H0vXWDGAjlB63pHxpweumT+C44+l6ODJS5v+crmoORFcK07
 48PRIyrfgoSW3LJTahTPa/Qnfx5eJkXz0eivgwG7QkUNJ88TmlR+/5Ln1lPHkSJfJtDH
 KQf6jQ7vIuEGmQw/0PExYI7wI5ZXwrxx9WspoWKqmSejPLnGpcQIoA7uuVhm7oFMwvpp
 jbs3FCEzsB4b4HSI50REaWrMkddeGZyAt3sEDt77Oky5B2sjoKd3zth2svboTM4LUl4b
 YG8xfU3GdJeBmOWQ7sRNcRyjsvDAwEB0C8XkjtGZIycg6Ec2m6BaL0xp8gKI0BqilQVQ
 /cDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK4kiwXb6UOAKHAtAS+/4GYtmUxWtc5Bw7vVXCrI0YdBXK6rVRT6DcBux0miemqtcuXO3N8QhDvCk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2HegcLbykGpCjyy1yLc6Hb3WR3A07WxdFtW5m2rJ1p/QgWUjm
 l7g0CUoigblPvE9AOVM0EL0PS4qsbTcT1TX/WKnkpKRrMgFbZKmWNxW7mUGyIduXiLSxc1JmTXm
 Wl97lkQk/jHgMYMbfXSwGxb2SbYlOpdVKIeHKr6yu/J3ERTCH7rQjkyYMLGxehRfs7kQKMQo=
X-Gm-Gg: AfdE7cmmQhcqZ3CAGo8CtERLhM8xNzXT1yr+e65aco58w2RPmoON7M2jD+DChynTptT
 31tEmvVOBq80A/8MCLUiicG0S3Y4VXqC5xW9aDDsxANrNpeuRMh7nA4TZQB6PucMDRwOoeimBL5
 GeyY6MAj7vCfkdNbc4CMXr2N6GAu6oEH95Tohngt8UKSRnSuVTxjICnxl8HZhxumXcV5Yp5N14C
 AeYgs2trCTgrIPzT7kAyjbHZy3W8+nmvHv7yV5Bo5u34oxUQfAJjqLYiFUj088xIQ74dPEaGsQR
 SczrqMbAnrngulloS6r2Mqt9hCd0KHeQL1U4xgFFRRRVv4MFhV+ss1QgtSmxExYtYwE+Sq/PVGs
 tZSd1JBcqcrLibVfb2SPUHDO7knlH70eREV8jmQ==
X-Received: by 2002:a17:90b:4d0f:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-3829f4e8432mr810907a91.24.1783108049772; 
 Fri, 03 Jul 2026 12:47:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0f:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-3829f4e8432mr810815a91.24.1783108049130; 
 Fri, 03 Jul 2026 12:47:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:47:28 -0700 (PDT)
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
Subject: [PATCH 20/42] drm: xlnx: zynqmp_dpsub: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:33 +0530
Message-ID: <20260703193855.110619-21-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX7oust4INgm4c
 TNHVPSsP0uYkCCbCArZPw+4p+J3bipG9OLjP/M3F5n67H4h0Kxw3GGK0uzkpELT15G6lNDXq7jb
 yQrZRAv6vSKmX0mEA8IDtFlv/oG2ioU=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a4811d3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=QbF1duAvIEq2M5YqX_oA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: WBo-eIzEXcV1wR-m3EFHLXzpGtatMALK
X-Proofpoint-GUID: WBo-eIzEXcV1wR-m3EFHLXzpGtatMALK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX5gM/LjQmQv7+
 cBIgUqPeD8mI9Iu6Jk5oDYkbL8v/4uFnNDga3/Ilk/9UtzTDtzPAf7sC9qXdScEcg82Gp33Imr9
 OFPx2IbPpzG58gYIPqGrHNWiuDxSaUAS0C8Xijr4iyvz+soZMZe5G25QJBqDhPec6B9xgmxKkn2
 BWwD1G1fWfo4GLOx4B9DGsqCafRIXeak1uo+pdv3SbLadYJ1ofsK8dm6QsRp/PRxxBdLzwNoqbi
 o/5jULai8eHU/jKevR+ociw4hH5VBfQhonM2mgGnXj+cDJDJB7+FUX2ktL31LiJhP03vLGSiwvA
 k3FQTWZeQHvcuNbY0U4NbP6TNlTfRw3wPGYHnLCb0oqeKWctZ6dfvmVqJarOaZNt9O7wRvml9v0
 uQW+L+ZymkvcXzcn1sRpMJGRR5QyLxj7sHuLW1FDpIAYR1HZsR2UoX4Gehj2aNcAyNXt9Xt0D52
 LOX5F8x18kCm+bNw9iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199
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

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 53ab1a2a5aaf..e93a7a299b52 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	/* Try the reserved memory. Proceed if there's none. */
-	of_reserved_mem_device_init(&pdev->dev);
+	devm_of_reserved_mem_device_init(&pdev->dev);
 
 	ret = zynqmp_dpsub_init_clocks(dpsub);
 	if (ret < 0)
@@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
 err_mem:
-	of_reserved_mem_device_release(&pdev->dev);
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
 	return ret;
@@ -276,7 +275,6 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dpsub->apb_clk);
-	of_reserved_mem_device_release(&pdev->dev);
 
 	if (!dpsub->drm)
 		zynqmp_dpsub_release(dpsub);
-- 
2.53.0

