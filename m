Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A7C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9E210F8CB;
	Fri,  3 Jul 2026 19:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4lGk2E5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPr5jSvf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48FD10F8BD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:45:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HjATN685978
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wV2jvG58Lj5
 Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=; b=I4lGk2E5mZ7Li8Ro5GPM2C07N9d
 b+pOUkiWJ+kt9dhiSiaU2EHDkbsvQyYnnmoK13NsOVmKzOUfpseFpxEEZMgop1sf
 V4Us6vaVFq4s2wpZA40NshGb0oPMAvVKkWnl+29Iw4tnYF6iVledRkC4P6hYTIWJ
 aIU87KPTR3fAYuK3eRfa+Jysa7aefGL/V7kSoHfrq7ZA5YmkgmN3YgJtDbXU04e5
 XDiArJTWpNNC4h/1ik6zSYXTca60q5JuJiycl0z2+a6YO2+ERe+AcUdLChE29gz3
 UssOdQ8699J8ukEPuMOk83jonBFYC42ozd39SRdIY6OCsowsNfKJ65bCjNw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qckf2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:45:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380ddac2b02so1246535a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107904; x=1783712704;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wV2jvG58Lj5Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=;
 b=FPr5jSvfxdbdnt2D1HxRrhDaZYgvPosSh7b0iDju9CBqrviIZfJRohpxg4g9wO8MiV
 l0IeMBZQYxAzAcIDaDkl5hLKe9QLLptquPafLho6V2xSbMgzrY7y8MwAFefPVaz0Q+TT
 gP0dxfjiVFayATVpoFMeXQqhlRo7uXZLuUmTSHPFc5+p64zcnnroYI4miKZCi/BIJfYR
 XblA0P2rnZwndpaQD0liRXGFf5qVrqO0XEtByFIDRNJZESi2VvewNHRs0TaY3eyhLotd
 Gvz1k1+sR6nBeVRmS0EeILYazB8BPV0r/F8kR6qUoyzmIXvzANSlgMleTOwhoClYHvz5
 e0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107904; x=1783712704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wV2jvG58Lj5Bs1ZlVjSXOSGXHXpRQv1KBOONp4Qs7fI=;
 b=MgV12Ys50TVmPwbnRLe6PeHGaKYZnWZAWCJbhvynnyq3htnEjTc+1HTTSK7MnTxNLw
 k8CxbczX/dwx56JBlS7Ea50jDxrFTnAtb8+OTXuc9D2OBCOEiERGAch2fMz3e4/7CUkd
 o0zmXxImyBX5wE5TX4+lFonnRxVlyAOSGXBcNen93r54KjOxKZIbku4ecBNNgNkmzNaE
 x5/vqXjmXPH66/n1IKjQQyMJXTeJSIqYS07Ct86tS8dwAghMxgb/jGPhCFitJP1oS7fY
 d3w0aJE8Gn/8HpYhQecIn6hzBS2yzu6BgVo3DbXQvXRG/nxvPdytES1DXfEOiR3lm/8A
 WT6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPiTmv1IiH6JTcYsYA/tnSEbAo3LldH5M8LOMLVO1vXaCu5kokHN/u1+FIMZZ5ciQSUj75Za8BYIU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJXdQkKCpX5P3g2uMA2oJ/OU5JUi3thNvw+OYtezi5ijSmVC8E
 cxiPnI/BrSOg3DY6g+PVLUcgCV4nauo41Gd9xyLvu9pPwiAVvgaTpHfdadAz23Kx2B/TREj7FKE
 wwszw5wAoh8JaVG19xr62wglGgBqr9ZqAKKQYAC8y+KLAEg5T0TNLwNfnGfYPoPZg+Uf92tw=
X-Gm-Gg: AfdE7cn+Rx7mK+/EAm1eYJtENivr77wh8mDCKzEYuQywSrBfRQzdiD6kABgKuV6uMjZ
 1q8ZncpcLZLTwqFwUtKgL43Uhxadx5zccVJ4t2ofLOF9ORU5EopT3Bt/+A7lomoxnr+w7kZflIn
 kPmmujSVGuwrEsRQoDg71nHkf0tLrdhXZfaNxPyT2IXZkeMyTVbMUxjd/csu2N6iY8XkDvlKzVJ
 qVY8NUL9kk8ycO5h45TPhUs+j63jWN38E5Aeq7nJX3eRInDeOgIAGVitdKQE6i8eIsFHOFnWHtG
 3hlWHVEDxFvDyoD4q2qdwjYM76wx4FQX8VZagLE7eW/7gEKJ9/vZiuCvKYSWu2y7EYKJIlnwzqc
 Uocog3yhEwgv1xLZMZcOW4bH4OBKnvI4BM4hnfg==
X-Received: by 2002:a17:90b:1d51:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3835a16be4bmr383592a91.16.1783107903392; 
 Fri, 03 Jul 2026 12:45:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1d51:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3835a16be4bmr383511a91.16.1783107902725; 
 Fri, 03 Jul 2026 12:45:02 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:45:02 -0700 (PDT)
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
Subject: [PATCH 14/42] memory: tegra210-emc: Use
 devm_of_reserved_mem_device_init_by_name()
Date: Sat,  4 Jul 2026 01:08:27 +0530
Message-ID: <20260703193855.110619-15-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VlFeRihy7uoHL2TjYNcedMlolUFaUpH2
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a481140 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0pCqoRa_c3HA8O-7yLQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: VlFeRihy7uoHL2TjYNcedMlolUFaUpH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX33OP2288IKfs
 yAprdW4eDOLwzxGgiCZQ1STytVZkA+P1yOcyPurlq6kdbLciOVOLkHwPgrWJbLiKdtBt0jsDmbu
 mSt9wd4PFqlhStyQuEs3KOBil7VFiv1kNE/uio/YuVyDjwj5GkKVgY7sg1nhQR9Obl+T/SHTNIV
 rmvHKGQlUgPLRTWv9k9ncofcNbtUtXQQMh55LMNYVTifHwaNiTTpo4tN+QSacB6ZusgCxtwlpQ+
 nO+Fu3Mhh/xuJdVBzF0LNKMr+4pW2JfG7nd5tdkxEGZJFcael598Q0lm23VV07zAnrH38HpeVLk
 DQ35IepWdSTCNgH7QLT1yFPq8K8o7E1oRPFc2nJcq62X/+aakKKyDNafhSrGB7Y15a4l7HeseW+
 OCQ5Eg8R7JFcPCGcTavn7wQOWdRxzCkYBOvL5spm1u/WA02leqqsW19A9N9Vp98oHiPFngHhXYO
 U6HlFnwgPBWSuu2bTdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX2YLCx+zUMzAc
 GSVk+CDBUEFLBH/cNNPky+/CCZ7/PBVZ9sSpSpJkYY/bmtjbZhDl/453fgBkDxORgYYIKJzBfIC
 pcbBPk3oBjL3ITeR/SrJmm9Xgee9lr4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
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

Switch to the new devm_of_reserved_mem_device_init_by_name() for both
the nominal and derated reserved memory regions so they are released
automatically on probe failure or device removal.

All six goto release paths in the probe function precede clock attach
and debugfs initialization, so they become plain return statements.
The release: label and its explicit of_reserved_mem_device_release()
calls in both the probe error path and tegra210_emc_remove() are
removed.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/memory/tegra/tegra210-emc-core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index e8d4cd8fdec2..07c7654dac63 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -1847,16 +1847,16 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 
 	/* attach to the nominal and (optional) derated tables */
-	err = of_reserved_mem_device_init_by_name(emc->dev, np, "nominal");
+	err = devm_of_reserved_mem_device_init_by_name(emc->dev, np, "nominal");
 	if (err < 0) {
 		dev_err(emc->dev, "failed to get nominal EMC table: %d\n", err);
 		return err;
 	}
 
-	err = of_reserved_mem_device_init_by_name(emc->dev, np, "derated");
+	err = devm_of_reserved_mem_device_init_by_name(emc->dev, np, "derated");
 	if (err < 0 && err != -ENODEV) {
 		dev_err(emc->dev, "failed to get derated EMC table: %d\n", err);
-		goto release;
+		return err;
 	}
 
 	/* validate the tables */
@@ -1864,14 +1864,14 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		err = tegra210_emc_validate_timings(emc, emc->nominal,
 						    emc->num_timings);
 		if (err < 0)
-			goto release;
+			return err;
 	}
 
 	if (emc->derated) {
 		err = tegra210_emc_validate_timings(emc, emc->derated,
 						    emc->num_timings);
 		if (err < 0)
-			goto release;
+			return err;
 	}
 
 	/* default to the nominal table */
@@ -1891,7 +1891,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		dev_err(emc->dev, "no EMC table entry found for %lu kHz\n",
 			current_rate);
 		err = -ENOENT;
-		goto release;
+		return err;
 	}
 
 	/* pick a compatible clock change sequence for the EMC table */
@@ -1909,7 +1909,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "sequence %u not supported\n",
 			emc->timings[0].revision);
 		err = -ENOTSUPP;
-		goto release;
+		return err;
 	}
 
 	emc->offsets = &tegra210_emc_table_register_offsets;
@@ -1924,7 +1924,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 	if (!emc->provider.configs) {
 		err = -ENOMEM;
-		goto release;
+		return err;
 	}
 
 	emc->provider.num_configs = emc->num_timings;
@@ -1949,7 +1949,7 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 	err = tegra210_clk_emc_attach(emc->clk, &emc->provider);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to attach to EMC clock: %d\n", err);
-		goto release;
+		return err;
 	}
 
 	emc->clkchange_delay = 100;
@@ -1979,8 +1979,6 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 detach:
 	debugfs_remove_recursive(emc->debugfs.root);
 	tegra210_clk_emc_detach(emc->clk);
-release:
-	of_reserved_mem_device_release(emc->dev);
 
 	return err;
 }
@@ -1991,7 +1989,6 @@ static void tegra210_emc_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(emc->debugfs.root);
 	tegra210_clk_emc_detach(emc->clk);
-	of_reserved_mem_device_release(emc->dev);
 }
 
 static int __maybe_unused tegra210_emc_suspend(struct device *dev)
-- 
2.53.0

