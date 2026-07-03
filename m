Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F04E10F8BA;
	Fri,  3 Jul 2026 19:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iY4Qnsy8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIkQBWEQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC9610F8BA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:44:41 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiQ54530602
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Lv1Bj12YhLZ
 GN3CgybKSi/9TGsT3eAHwNaLR1ZhFDGs=; b=iY4Qnsy8abrOAIAfFH+8FxIw6mq
 Qv62w0poHuMw3XeKHTxiiEV2i9vgpiWUQnAMxg15qwpuMbCD5LHMmPAbxups9U6+
 8Kxg3VkqFs14Nvi5hRkCGUDPNnOZSfE9BVxjERFNOsf8El+epCrhEeCuyT5bWuEx
 xVZiMuzcNy/l+EOoJk0aX1Nx3Nv9PBByY67N2PgW8n4JUwsFXE0n25h4bFlL+ioR
 1v/6f5QLgOyzaQa8dDpqtELNoL7m4lg79GgByHgwIpYh0c/MZ5ZJFB7t/TSt75zB
 Hq0jvgAaxsGIXA6rrVFftF0Whkpojf4qBmtL0jrhsU2GaWU1Wh0ht1sDqrg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n3s7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:44:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fc0aaa94cso1431199a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107879; x=1783712679;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lv1Bj12YhLZGN3CgybKSi/9TGsT3eAHwNaLR1ZhFDGs=;
 b=EIkQBWEQ0PH8TIYI8tWWjPEoBfaIpG2RWxE1vxIMNPJI2X/tr12RIWHLQJU0ZVKdkR
 NDYPDL/2v20MZiFO3fthb0gnSHw7t3zctog7NlB6Bfv1KN74Db5+i9DWn04knz73DvJi
 zWe7IIMZOO4bVDRG+0gxcIgIhVu4Gpu+TCr1NCQVYoRYq2vT9n8gfXzSe8WRWkU8sniz
 UQ1Q0edtDfET4kxgcPuvBAcbzftiJKBd0AO1cp9p1ZZXH1OQDfAT/uTrWjFHybjXB2J6
 rhzp697+DVCpD0xUGr6/RqGkKzehpCM7+DoGxErmZy+TFayKLxOxaMoYDs2XJ3pWVpbJ
 fCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107879; x=1783712679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lv1Bj12YhLZGN3CgybKSi/9TGsT3eAHwNaLR1ZhFDGs=;
 b=ovtq6tB08KCxv6d3QK3eh+0nUTq5WUPLqfq1ymd0vP3NwoHm7B4vIDFsxEvObvfRoO
 lRpYz7EwAjJ1ZNOxl2DM8L4ayOPH+W6IlXoddPGEuLPfxo2TEv2WXfcZOQwt7CVhWfci
 FdzjXH3UBfszn/bPc/HgGu9bUGgvFa/A4cT1d1ACergZjiHyQTibsi7kf/1kh/gITIuJ
 O3YCD751K1QPC61IfJawagq2+8aGRnL1GjJhRYffthKFCT6WeUwgRopa6201CoQdJ+vP
 Z0Klyp7uw12DWYYdDVY+loplQhDi/dMCaRmfghJFTeh0Hp0e6J9XnBBEDISWzM1+ZpNH
 Nbwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDpG7dgOhg5CKTBHGVGFxYhvOdjgBh6yV6yo6JgvSCwU1RVUlIlGdW+on+xkbf2zCYYthqoooCsZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykHtKM7V5DjOvDfAPOVwLSEdvUSp/S60roMyWThIqSvSPuWcfc
 ZHunavyE64YQfdrxVpr+dFt8Pz7sbfYXdAjAgsvTwqDen77YhSceovVVhmncWx7E/+eu1LTbg+w
 zRUMnpfYrQxdNuuWvcZAU98nUWMObR6QEpQOrzFGFRg1kjmy5cxA2Rv7zW47ysXWHYZ8n0Kc=
X-Gm-Gg: AfdE7clfl4RI5mL7KdyW1KR6s0rbyYDD3+zYlUhQwbZTV4Z1IoNkq40NkWZhi+rVCAd
 66l/k397cEXjw1hkH94LhNM9zsYID76DIqDGd4nLWJS66PQNnzoMko+BurWRhWkAzm0M3fskw5s
 iP6Ii5tJg4AC6gFcGQPDZoTNxeSvc9eF64KoN0fKSUIa0phWjDuUuTEQFciZjBbf0FSVlPeyDFK
 Fo+lE0tkitz9h11S8tc+kD7aY80cVFzvCYfNxr96vQtngmyLval8+Bn33Mb4DBRVEvnD7xHrMJl
 lvSEvBQOkfCcZqLUaFRSFr2ECCSgQiUnhsUXsWl8HXn7fZtRf3wO5du+fv7eZKge0ZYXqyhOGlF
 rRt7qAAOm2agVprEdEbg5bWs7GwIWxKwEfrw4cw==
X-Received: by 2002:a17:90b:2886:b0:368:d839:28d5 with SMTP id
 98e67ed59e1d1-3829f0074b6mr775673a91.18.1783107878952; 
 Fri, 03 Jul 2026 12:44:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2886:b0:368:d839:28d5 with SMTP id
 98e67ed59e1d1-3829f0074b6mr775603a91.18.1783107878394; 
 Fri, 03 Jul 2026 12:44:38 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:44:37 -0700 (PDT)
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
Subject: [PATCH 13/42] media: nuvoton: npcm-video: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:26 +0530
Message-ID: <20260703193855.110619-14-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX5WqE+2aRQaq5
 yg3AqSMFIsheBYTYlGridxLTgCPlmhSV+gklEIddP8iWStL+gZbH0rgVvaOqWJsVYxwYTIyCf0l
 c2Euke1WBp7y9nXcreSnXHPp9rnJ8+w=
X-Proofpoint-ORIG-GUID: yi7j2aDkStQHbiqTbP4rXLoemoWt2XPh
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a481128 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=iFm4xv_JmjgOdRhw77YA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: yi7j2aDkStQHbiqTbP4rXLoemoWt2XPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX41ksEjpegTIA
 KKlbh53MCdjmq66l7p/QgKY6bOJUKEUWB9oZkPHxsXIYqho4QiKLXeUgw71FHm5qpEl/vEWiTv8
 I4fF3IhRb9rY0ahNBWTxH2rbuSnh/BFdqhcLTjs2eBl/7ata6ettQxsQOSw9G4z3x6lFSySF1HE
 DTwC0txPKv+aZb4/TcQAsNW/PmzC6o5790a5pdP0gAE1byzeDshafBm2K1mJ/4ryery+Y5nNFql
 fpVlssQX6Ei/ZrpuebzT9YyHOEXk14lGW3wQN1SKLQggAfxjdhdmZBl4Q9+yvxdu25c6QbPV/C4
 zim0RBHkp99Nly/G87p3+yl9obanwxGKyCwNIaJOxCZEBePpuxRCRy/hYzrOw8SD8YBc0RHmiiV
 /qtGy7jES3U4o0l+SH+gWxw6W6jq8nHRo1sLrCv3J/z5s3LVHw/jB4+s/iu6arR5TK4OKZmtHC/
 YRqAiG0wCZSZu5GU89Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
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
Remove the four explicit of_reserved_mem_device_release() calls and
collapse the now-empty err_release_mem label into err_free.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/nuvoton/npcm-video.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 52505af35c08..6786736c8f07 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1715,17 +1715,15 @@ static int npcm_video_init(struct npcm_video *video)
 		return rc;
 	}
 
-	of_reserved_mem_device_init(dev);
+	devm_of_reserved_mem_device_init(dev);
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		of_reserved_mem_device_release(dev);
 		return rc;
 	}
 
 	rc = npcm_video_ece_init(video);
 	if (rc) {
-		of_reserved_mem_device_release(dev);
 		dev_err(dev, "Failed to initialize ECE\n");
 		return rc;
 	}
@@ -1789,13 +1787,11 @@ static int npcm_video_probe(struct platform_device *pdev)
 
 	rc = npcm_video_setup_video(video);
 	if (rc)
-		goto err_release_mem;
+		goto err_free;
 
 	dev_info(video->dev, "NPCM video driver probed\n");
 	return 0;
 
-err_release_mem:
-	of_reserved_mem_device_release(&pdev->dev);
 err_free:
 	kfree(video);
 	return rc;
@@ -1814,7 +1810,6 @@ static void npcm_video_remove(struct platform_device *pdev)
 	if (video->ece.enable)
 		npcm_video_ece_stop(video);
 	kfree(video);
-	of_reserved_mem_device_release(dev);
 }
 
 static const struct of_device_id npcm_video_match[] = {
-- 
2.53.0

