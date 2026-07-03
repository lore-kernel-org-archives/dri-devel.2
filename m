Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11978C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0096E10F8BC;
	Fri,  3 Jul 2026 19:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5ePMugh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S32m4VAW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7360510F8BA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:44:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HjBGu546854
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kb1iTkUxuam
 8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=; b=S5ePMughZWi7SvoZxYwP0onh31h
 eU4cwfBRx3ahw1LCRcXlkaJIXcfIMfCLwR7z/4iUWQKtrflPoO+2yG9bbv2cGOaI
 eUNir+DbQs4W6XkGR/ALtoBJhumLuXvMRvK0mYA6QVyCAnLjKHYfbljJLKY5PKxa
 tajy4e6gizpYUJdNjXNdCBgeIrKnfYLrf4vI3VCgDRtFCFh7PKsQ/HI/9bT++lwS
 r1cCfbVyFKrL3qO0imObXuw8ZZKequ0xSPmvOeGpkhmMbSWbkgyFk8Oy3q7PR/Kz
 4ENgssi0FTweX0znGsCWiiajLsQk1YuBOQeQNyxOeVbk+7xzCdP0FWyGR5A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682btr4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:44:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso768395a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107855; x=1783712655;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb1iTkUxuam8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=;
 b=S32m4VAWKVT/9ns7I0bzEuo7lyQIQQGkEEZxUdRh9fZd94AtOYz86vMX6TNqU8rOdT
 3ugZLA5n4adfCKzcqRHjVyGHAAmhrkZrSxG36N9Uvz2M279L22EQkxIoamx+nK+K3FYK
 y5Gn3QLAkFBbe1H2iYJV6aObDrEg1yOYB2USMmXj839hyfvKVjaGlf0z+ORrORE3Q+so
 2Ulk4j8a9xxua7dRTaGHBR4e2hcr98pDsRcp+dzS4j4zOAsDC00ttncZeDXhiM2zQ4fe
 QDlQJQH+wlNveF9/s72GU/ZzlSpC68vz2ompbvxYXbDiKzpfNwGLWwHkx9/ygGCWQwlf
 vs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107855; x=1783712655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kb1iTkUxuam8tAkzwKjCMRd26ZQOwOz+Yg5JpRpyt18=;
 b=SS0zCRl8eN98zr71Wv1U0dhAIZtaOqEfY7Hd6vXnUeqi01VczUbeYlee36/4BP3gPc
 CKrhxwT5FQWJUaypDKjuD3qA4rPjbwzOqp/2iPIfE4zXHH1Qxj2KVly7yhxIwbbgiou5
 9dQO3/eSozLnUQzNITeqEzwJogHjFKQzcSswoBMa2EcSMZ54ugvyMsde/EfReWvJmvr8
 4b36i8L7V/VwWq/gbOY5vFivQtTaQlV438GqZZd0accrZ7HKT9gfBoqx/idOLOqTR6GR
 PvPcocoX8zbyuEGJL1GFO302LAwa6+WquNQrW0f8u6nd7rS9s466iBLbkehN3g+pli4+
 FgIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEV/MkZRr6wolyLN10Fmgnk+JhOKHVib0TgOQnCWdkTqbze7Ncl+ErLMNnl3UdkI/tCsdXIp6R3fU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznj+vCddx+Y/T/Yh4N/JIUPLOZboAYUwMW0hc45rDgdtcKBu/i
 bZj4g0q2yeklyCdv7aQuBIsQv5LxKOLMA3pSIYVY9Qpxejzl1OHJcn9pMMn4oiKcaDduGklydDV
 OUAlRTDOggXdXhfUN+n/RByIyEsFc973l4wIT1RT5B+lQbWiuYx8kUgJN98Rp0DcNfv7e8WM=
X-Gm-Gg: AfdE7clZOZgZNkaTWlHktAaKw1y2C6/9OkWITH2Fc80SAYZQYhlTiAFs4Kq4Q2NgfRz
 EssxmZYKultVluPPSz7aHYl/wy351PtPzAlD6UONI0bqfFCjz0WPq3F1+PoerfUzfpssKQGNQkS
 2thyyRSZleQ3E0WZ4I4MIjK1W/fYakACsT1txpXSbo+5M3av6b+tesQq7WKg8p9AWg6YCTgixvn
 275E8PSko1Ylkzx/uWuQ5WXDeR45SRyM8n4bMx2EwW4F9zqry9m6SHsQ0PZ5OCXjKVTh2dMKV/N
 c+j6mLMWA3RKGvlfoTxh4mHFhmVs7GtUSKJvzwFQrCZXmKJhMIqJyvDmLR6Eq57oCOfPmdWW0Ea
 MHOfu6lPRHV/0KGy5B/LHfZPX2gqRDGRGEVLynw==
X-Received: by 2002:a17:90b:5550:b0:380:540:d49a with SMTP id
 98e67ed59e1d1-382802bcb77mr736193a91.7.1783107854543; 
 Fri, 03 Jul 2026 12:44:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5550:b0:380:540:d49a with SMTP id
 98e67ed59e1d1-382802bcb77mr736159a91.7.1783107853911; 
 Fri, 03 Jul 2026 12:44:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:44:13 -0700 (PDT)
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
Subject: [PATCH 12/42] media: aspeed: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:25 +0530
Message-ID: <20260703193855.110619-13-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfXwFi9GoJN9j/d
 gBDII5SZwSevSZXD05phIft6QlBs1+FaJq8Y0UFKdC0D2iNJ+jY1InlSIsc1NUHV8A+8gl5UQG/
 JO9lovk4YieKXelEYUSY0yC6AmP4SI6J0gVVpASEkJEg2bOKT0GIpPFlPDABzXs2JN2gvdxU/8D
 lakLA3SvqJO2cxUd+jImjNxoNFto0mJQGBZiDJFbaRwR4yOajLDNh3DtluiS95E8HF4G4SFMElt
 qBy4CJ2REGX3sC039eYbRFkyX35lo9VuCGq/LaHh1aDvLuSJljHPItygWVpS0VAZ48yO4u64b7J
 t02WIHfl9fla0pBfvIOOGC2YNiR+MX5dp0y7Br06kx4Sh+T3apT/kvaY0Q6sk+P5n2fmmzlyJZN
 2xkD1Jliipf9G7pXYSEb6e4/qgoevTi6jLO5CAhNlDvQI3Sw/oxLmjbERScY3oquyxFDlG3ZBES
 4dMubfY9Nk/PGSKKcRw==
X-Proofpoint-ORIG-GUID: 9YYsX8HDN5aifck2hrHaq82RBMth2uGi
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a48110f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=gFEuJ_os7HuwQwkCt6UA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX5oF3UiDFbfZO
 XHHcPcBiDbzF/fRmVU5JxRkaXn3y/nH073VLO+zuor+T3WRQM11DgpkpKmzts2zlkRDIoJezB6C
 LOgftUBbJo0LlWmva9aHWMr0bl6ibFc=
X-Proofpoint-GUID: 9YYsX8HDN5aifck2hrHaq82RBMth2uGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
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

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the three explicit of_reserved_mem_device_release() calls and
rename the error label from err_release_reserved_mem to
err_unprepare_vclk to reflect that it now only unwinds clock state.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index a292275f6b7b..7ba9314fdbd2 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2267,19 +2267,19 @@ static int aspeed_video_init(struct aspeed_video *video)
 	if (rc)
 		goto err_unprepare_eclk;
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 
 	if (!aspeed_video_alloc_buf(video, &video->jpeg,
 				    VE_JPEG_HEADER_SIZE)) {
 		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
 		rc = -ENOMEM;
-		goto err_release_reserved_mem;
+		goto err_unprepare_vclk;
 	}
 	dev_info(video->dev, "alloc mem size(%d) at %pad for jpeg header\n",
 		 VE_JPEG_HEADER_SIZE, &video->jpeg.dma);
@@ -2288,8 +2288,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 
 	return 0;
 
-err_release_reserved_mem:
-	of_reserved_mem_device_release(dev);
+err_unprepare_vclk:
 	clk_unprepare(video->vclk);
 err_unprepare_eclk:
 	clk_unprepare(video->eclk);
@@ -2343,7 +2342,6 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
-		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
@@ -2374,8 +2372,6 @@ static void aspeed_video_remove(struct platform_device *pdev)
 	v4l2_device_unregister(v4l2_dev);
 
 	aspeed_video_free_buf(video, &video->jpeg);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static struct platform_driver aspeed_video_driver = {
-- 
2.53.0

