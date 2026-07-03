Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39618C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617FF10F8BE;
	Fri,  3 Jul 2026 19:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g0ZwbQ4F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XRMYmO6U";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF1E10F8CA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:43:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiIHv683668
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qmmZAG95RTp
 /pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=; b=g0ZwbQ4Fxp8RSCKppF0JkCpG46m
 IZL9lgpKtB2MG98fMp2Eetk6x/jUKWM9B4iLr2cyr0TggLUR42uycgR+HH6LVl1q
 qYaTOQFAA2HFvhnn09kA6DLClNJHb0JXw09KSUoMXJMm+0bW1nLBMzPxA86Vo40d
 IgZgqc0zloikkecM4YZLO9hc/3NBCSgblYtyVpg9UiwAyDqhm5Ayk0BIEVQXJ7vL
 wiXAZLl3svEFwMdtZXugflcoEO4rEJtFXd8dSRtQXTMK6SSN8GIzUnCNLmi4KNg2
 1PW6qN7usOBiMmNv3KbgswGU0zdTnq7gADJCvnJBxW710nhoN1OmKi1P0Ew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bs4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:43:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c890bac374eso1439402a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107831; x=1783712631;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qmmZAG95RTp/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=;
 b=XRMYmO6U2yaydfbYUMl0b6h7ALk0zYBY5O4ZTi8fGa0r18SHVLsGfbpsg09pCANF7U
 F7LEInR9VIiFXzU1u5LLvZAyMlNmFyyKYd6v5vNnPx47bIpPWi9ZU9wJRF/WV9JKBhX5
 2itak4uhRPaGf3PHVHAjRj0aX7lnUPFMTf48pBSMQNNjcDvcoQC0y5oXo2dOueS24c+F
 xiF13rY6SauXpP54RzMjuJM/7vfgmV8hLX9r/AzHYrjRPJZPUJrJyKhFo/S1U0RdAfcV
 1hVtOIUHZl24xHH4pyNo5SfJ9a4EUGUP8yK4b/oe7e/iq2B2a5typmoOs8r7RKqSifDY
 x6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107831; x=1783712631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qmmZAG95RTp/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=;
 b=pitXwFjnO71UA4jhuAghe4FdgSgZRfe0eeotP1rZzB0/hiXwLLQys3UKjBfIthtum4
 Nl2SYxDsDKA25ABfDMzA5Kw5KLMMk6S2DLlfPYdf12J/gxJLzXqXq91MhAEdEDFc2krB
 Bz68/2YzvRohyDdp2DTVA+dTCrVkdGF6NkPzt/Lsx15BRpz7iwQ2bzwZQaqjy6+kZV3D
 cUlmz6X8cZQskUPearlRBH5dvkqpRtWXWeYg19JuoQ05AuL+2eJPzGqUf9VWnlUiRsDz
 Hi6A3/eHoGIGs6mmMERh3pY3YKfiJubax4f4jiOsBX69DqhL/AOjkYYFh0PskyDF0RcT
 Jn6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+adV33BIsjY0MCz96zR9btweVuMMLZPBD47eYwI13QrJx/Z8d9tHnBWcPoqFXoZz0yG5iNlv3Uy3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsrW4W3dkSmTErnYH2NboDVSYvCNEFSMlgLLl1KwILpuwqBldm
 b7JQ48WLNOc534I1ivL9yidUcREAJsvwpeiEL5qWF7ZQ+w/pbK2AZg1UHakfas/u59YkAMnVhNa
 tz45MxZGsxEPb+NXlr4kiV5kcKa2DeLAKWO/1u43q7szEgnkhPZ6W8T2gVT1CXl4sNnj/z3o=
X-Gm-Gg: AfdE7cm/AgU76Wmb2fDpYbMyi1iau34W98F9dc4e8OG8RjC+lw4rUB53dvfc7SLtSWH
 lwcz5+Qv5BSPu/mjg8CFBPgjhqdZoIWSq8sOjGWir7tDSX16U9/84bkvZkEFvUTmwsHedAGzduZ
 7P+BgRS17vE140nigrfX0R7Pykyl3XHr35FEeqJ3xL6ATWnse3eGu4Ej5tSAzdKMCK3TdEO+p6V
 sO8fW2ToBG6nnIM2bXYJkj+3t+Vs0OXG61sU7IEP8z9/Uetu5WUDbvSxVkgV48kfuVmMUw3qzqe
 lQXA7e6WFl8iOWcszhnc2rMPuQ8u5U+jjDlnmckfGPK45yjkXHDcwOfCCOPAgO5TlJIh1GH1Ljh
 P+dXCKoTxUXNkmRe9SmBnM1O6MapiyDIoC9KtKQ==
X-Received: by 2002:a05:6a20:244d:b0:3b4:8717:1c21 with SMTP id
 adf61e73a8af0-3c03e4e09d3mr691189637.35.1783107830609; 
 Fri, 03 Jul 2026 12:43:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3b4:8717:1c21 with SMTP id
 adf61e73a8af0-3c03e4e09d3mr691085637.35.1783107829862; 
 Fri, 03 Jul 2026 12:43:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:43:49 -0700 (PDT)
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
Subject: [PATCH 11/42] remoteproc: mtk_scp: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:24 +0530
Message-ID: <20260703193855.110619-12-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX78NwNspr7fWN
 EU5yIJrnpNdspoSgOlC2O5VB8UiYh5hfrl4kn0vPULBEzWLmSarBkcYMjcNDnHs7ECKt36eXpg3
 AiSgDkbVTU4crmj072F3eKxxuW9ZGx8=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4810f7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PC9_zsTzMDnykp_yU_MA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: z8hSkjbgzeTERg0ymWz7rV7T5MClPVQF
X-Proofpoint-GUID: z8hSkjbgzeTERg0ymWz7rV7T5MClPVQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX4/IgS9/COdYA
 x09Os4sZ0rUtWxdo5LoeUe86wq6E0qXpyLWXmfJhN03Lc5Moh94V2kzZmikql9YARrsaAGq01bm
 yxlp9AwemYvNBUa7H+6eb6WdpK1kXMc5iPbPhtyBaSZaAq2j4Y0M6WSmqXKvglNxBSGUBhBoPn4
 uoGcEvt5cpgKTyvuN6A6weJn2Y9+Z5cH/8JaAFs8HROnmKeM8k8aLFOYS+4E+xV8Zx5YIkqOmWU
 17q3mys/CvTVgBEL8azj73sEhmeJC9Xx+EG7L2nZfAwJrjXVEesywBNvp2TimKD8azteiq+WTDs
 6nG5Jnjq6QR0JrauaiAdNii4QS7xiQxO30h+m4MBn6zEe/OBfUhAF3ZSl2HG0FAQY8Er/j1pdTa
 YHzptGD4KyAgjHEOchZmhS092x+Bmqt4ARoc3kTWey1xwd060VRTldmJgqHuNHIPFcUOeEeKtLa
 peIyV5TzmrbolWpb07Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030199
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
region is released automatically when the device is unbound. Remove
the explicit of_reserved_mem_device_release() call from
scp_unmap_memory_region(). The DMA coherent buffer is still freed
explicitly there before devres releases the reserved memory region,
preserving the correct teardown order.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/mtk_scp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 85a74c9ec521..a4387649ad7f 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1027,7 +1027,7 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	int ret;
 	const struct mtk_scp_sizes_data *scp_sizes;
 
-	ret = of_reserved_mem_device_init(scp->dev);
+	ret = devm_of_reserved_mem_device_init(scp->dev);
 
 	/* reserved memory is optional. */
 	if (ret == -ENODEV) {
@@ -1060,7 +1060,6 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
 
 	dma_free_coherent(scp->dev, scp_sizes->max_dram_size, scp->cpu_addr,
 			  scp->dma_addr);
-	of_reserved_mem_device_release(scp->dev);
 }
 
 static int scp_register_ipi(struct platform_device *pdev, u32 id,
-- 
2.53.0

