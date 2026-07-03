Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F118BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3269710E67E;
	Fri,  3 Jul 2026 19:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0HtX2hL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdpnmdFe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E7310E67E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:51:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiLgv546530
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u+7rJ5pi7vc
 jWlKDY8Vdn8sewCr1uk0qSBX0f/87mts=; b=H0HtX2hLDru8JMoQArzbaE5LOfw
 0PmOhP+7x9PpJ44C1wYElB/pEE/AadwSvdrwi0uIzZkJk/QMUX5DyU6x0o7BkRFk
 8BJpVSuejk9iXVULoRbC2X6gud1gTQ4xHn1YSU9/IQtx4Ky+EWzSsQmcA3xp/pC6
 +MnOGJzMV0nL+VUgoZbFhVvPmVMOotmHWORnNZhy7/1ZGREbb1EnOprFlXUDAVlN
 RfTVoap57G0Zs7pQbe0oOXHWnxLSOibADzoCmaPEwP9yIk12i6WygXVRdg04GFoO
 P7I/gd52Ko2ce8DjPb84hpH1LvMNhQUKCGrtABkrlazO6G9itCuO6l0h60A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02wgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:51:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7cfa17fe6so14439365ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783108291; x=1783713091;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+7rJ5pi7vcjWlKDY8Vdn8sewCr1uk0qSBX0f/87mts=;
 b=LdpnmdFeXCrgzA4+tnLYOe1iVPdEK0sZhz4UAckrOHrecVaiERQepIEg/bluHjiYct
 J8f7BDhoH6DQ3AUR6CCdR1dL2y8bnUbDUYblqCnupSmLrx2JiHqKSoMnQG7TEjT9fXk5
 llFTOJ6Yz/f+DVXov1FeoAGZkAC0MHvcsazDW12DVRcgmUBH8q0DhZO/HOsBl2lmk9Cv
 7hsHM2UyUV6xErwrmLgRr+vMkrmsGJrCavwoBr51acVzvhRVLdamhRxM6C/YbYSaXLUb
 w0qlBnd8ri5/UiKpBp7KkVUGkS870Fu/MFIF0+wn6en3opWTreMEHAlr0zgdk0W14fLQ
 4Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783108291; x=1783713091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u+7rJ5pi7vcjWlKDY8Vdn8sewCr1uk0qSBX0f/87mts=;
 b=fMfHj6mmskQXtBVJ435lZQf+yLlh3Gcd0KC+EMXEtjhZsrst2HxednT+Nf/4KzhmPh
 lG+sKVCBhdNE2ui5+T5vOcYxa2m+p9AHJe63RyELefnR+AGiO3/SSSM5NIgdwWs9y159
 BuAW4McpKqjyTwGD9NO953rymRAuROqm1n11aqfCP+AWdM4JMlH+TFM6Ur7I0VcX9Bm4
 5BXaAEv0szHNM3bug7Sg1snEnjJ2cJE/IX6GXBcJNlXZGYNvmQ4/M8g1tRf6ptyBg5gJ
 FL/sojYAbzri28pZa8g5lrPUKXvlPevx9bPSCASKUIkgik+O1iTJqR7vtmgHbyQef7aD
 S3Rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHpOMwDfRB65Gyvof8QTykGHu6t26wgrZRvKqH9iMsrq3SvCp4GitBvIj8MhXeP1Rk/y2qIhnfq9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWwCGWZqe2Om3jchbp9K+nnqtRnOMqj6lebrDOy0TFpakN50mL
 9ii+upzX+/5SjPXmrn1EwLE3gX9I/hC4y5nZ2iV7u8t1Xbo7Bk9hSWfiLCXXnGR6FYiVQFpYOkJ
 PQu/vpO8gCuetTye5WAt91LWC9n/p63sr3winqZzedBkmIrB+5vIfgW9p7yNvFwrrlCslCq4=
X-Gm-Gg: AfdE7clHkpLq4AfSfnkzElXJIlFwIpYDRIIkhEBzOqibjl8WG8/7JEzfn6u9ymfrJIJ
 FwrYsC7036sOTC5r5f+wGEEhB2FzDtJqtodtyGCKpaf8br9THz7d8RSmpkqHQuQc0d9UnG35yFE
 n7TMEPrbNQR/usALJJMtQvVOyr0MfAhHkt6IYq2OnT8NuJVxP1zvh/WWqAmG5b4KHcPfbCPLmo2
 NFt0FMvxAyuB9qEdMl3Ja+km1LMgRIAwfROW48m3nCNK8pNZOVqobYwqDx5mUTowzZHIZoHXl/n
 cSRdnyoZOgI0Ur9Q22rpLNU5I2XrMY9ibuLnt9Kz+zefIrjsQT0xMidaWot0XBkgRb1/RtLq15/
 fMpD10+zdSVeqi5N/rFUYBfXb68ux+Yx3xxnRSA==
X-Received: by 2002:a17:90b:1845:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-38280d98d29mr843500a91.11.1783108291258; 
 Fri, 03 Jul 2026 12:51:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-38280d98d29mr843393a91.11.1783108290587; 
 Fri, 03 Jul 2026 12:51:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:51:30 -0700 (PDT)
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
Subject: [PATCH 30/42] staging: media: cedrus: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:43 +0530
Message-ID: <20260703193855.110619-31-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vDnmohxgej__zCa1d-dTUUYaMSjiedHz
X-Proofpoint-ORIG-GUID: vDnmohxgej__zCa1d-dTUUYaMSjiedHz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX9H5e3vWtYU8L
 09usVXI6F/tlmTK5+lyXYiHw3wAGM7Oeeluk1bn5EHbb/GDScY+wkK5XK0dDf7Xf+7ZDlBowYCJ
 zN0ITddqnl6hSrVZEhTn3Y0i2SkQ8So=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a4812c4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=BsJah_a05XtIl1EiQYAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfXy7SwyuhYIEmP
 eLtyGvakrFtwHHSf47SgI7xSk+BjTfqpbx/2ro9dDIoJ169A0nPf1b/xeWEbInw4s2x9X7virin
 Hy+TCP50b/LGLVwX1B92zCgjSE8u/rhbcRTnxU3CwBEWCmZr76r5qdB1KSokaXCAB5EbD97z6Ne
 W+mKq4iWlPq0zMMih0GNR656jIXpg54smMKK7Ym9/Hou62aUU+f5WpsgaFV0upqifH9ENPFdESk
 ncz+zZyQba3U3FCKUiHJ+YH4DDntTjnF5PdsLXiBAd01tpijSlFAIcHq35PAbe/quW7h050Mm3n
 JdA+k7YUDAceE/enq3tbS5V5e9HBFepM269c2sfJPu1Dnf/QY7PqX/PUEzaa0sNlerHcOXf2fVZ
 gGIOi3yooIvnoz4r/mCAXb+1QhPVGJP/hvrZ4kfpQPaBdCPPkBKMv1mIaOZkNgJRsM7ynhv+AaA
 9WJsqwxdEOSbacdu+UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200
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
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 444fb53878d1..7b5aa94064a1 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -266,7 +266,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 		return ret;
 	}
 
-	ret = of_reserved_mem_device_init(dev->dev);
+	ret = devm_of_reserved_mem_device_init(dev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev->dev, "Failed to reserve memory\n");
 
@@ -341,8 +341,6 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 err_sram:
 	sunxi_sram_release(dev->dev);
 err_mem:
-	of_reserved_mem_device_release(dev->dev);
-
 	return ret;
 }
 
@@ -353,6 +351,4 @@ void cedrus_hw_remove(struct cedrus_dev *dev)
 		cedrus_hw_suspend(dev->dev);
 
 	sunxi_sram_release(dev->dev);
-
-	of_reserved_mem_device_release(dev->dev);
 }
-- 
2.53.0

