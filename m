Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C1CC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5521310F8D3;
	Fri,  3 Jul 2026 19:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvyBZCsm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bC061lKx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF37410F8D3
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:50:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HjCiC686578
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=71ffIbujQRJ
 pACfwswiC++PljuSs1fWY5AHxmQ6jcq4=; b=TvyBZCsmUFb6XP0nyeMDmZUr0d6
 QfdM5q7XKtRLmhSCsR87R7n24zAgPbqwXHbQbpbBrAfJN/3BoE2r95vk71p3+CBB
 ObOCk69OylcINhIYVL4FrfDARu/c4LAUFcKEv/9v6uWS8ukaPAWQuL8QDl4PNDO6
 WjFZPBHuitcjlSddKO9eskwZfTMHVM8nPVQ4qxvV0m/4929WyXvRmCnqcdLKEtVF
 BRpK7IT2oKjC1GZwOGyeLt9zFZnQ6XcJ6WQmmdDcXj7k39CKJTR5ZgMjHxxCKGYB
 3+KiUYnJ/K88oHwqwdihUAZhPh+yEQ4A7N5sgC8Y0wHfiGLi9JI0wWQhoHA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bswj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:50:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37e1f96b248so1509079a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783108244; x=1783713044;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71ffIbujQRJpACfwswiC++PljuSs1fWY5AHxmQ6jcq4=;
 b=bC061lKx3RFKGSAXe/Lg2EFi0ApmaYqQPX4iuHcBIL3K26/kxwV79VMqgDaEewFHjA
 XGvj9kZeINAaiPgSyuEjPxEO6iwLhnvOKt2AMBhlI2pJs/EyyX0wT+OPJ0qmCSNQMXgv
 w+YNE1+5SeJg4Z6ltF0wD0isCZeIIePdd/GUpRgSyatMCO5O1Z3An2ktcw4dc4vhdNsw
 PW8Ix0DwrOcuGul6IF6cE9io1TmhE56PPA7lMqES2mJInQbCbGg6cLDY96A4NXQMq+EV
 /z/vX9jef3PPcJ8v0ok3DmXjxO5WsaOjC/1uKjHqOVhjv3H/FOodclVx5psLeXRrDCFK
 xT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783108244; x=1783713044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71ffIbujQRJpACfwswiC++PljuSs1fWY5AHxmQ6jcq4=;
 b=JgiTH03xEQAzzR90Fl/zOZCF7DcXkVzLWGRu6nQm6wfp9bkhnC8TD9kqh8nX1adm5x
 VZbGRHJ5rSyGZtQrD682IMNmOMvsekHBNBSW5L+fUF/o7NCC5UyAAGVy+mCRl/5ZjKTm
 p/C7L+vlXVu3Y7Gcga3/yuVLN8LZSV+yWqNnmUDgAreSn6Zv1/QqU22tF17M6X3VboaO
 YDxGXkbiiwirCMT1EvWQu95srC0MYKFjjgsrpPRwAWqK3xa4/0Zwk5hAVyrLNqyb80M3
 bPd9K/7GgQTzC15eiN0zB/9OJNyOU4CLc+tDMreZXjXJZPGTbqSnYYXQmpbu2mD9F0kM
 3rRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWsfJ5NXVdZFuqPhH6AbvgDVwg+ENAs+MuPXfEJJjeTS6/I6kZuOHdWmFG3hnBj/QYgluCmPm6C/w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi7FyWCDBqYitzz8CcjzDBmWhbUsHyfthPoiXqnJFoi94+5F1T
 f4nzkAVB+Vd9tmgkAYBn6+diN6M36v7bDStkCDqtyYbzpiBTmIlps2E7MI7H0cHaXUOLCHpaFII
 gAitQMunoyg9k8sKjLUYC9gZ2BLiZG5eGKLeclQ31l6ldSX1B7usYxpbDXcvigx1r1PpH9sA=
X-Gm-Gg: AfdE7cl9e1AJ9/jJTwsvbts3Wr/E/hTnLygTjZ2YnMa7E5aETfliNsbJMK+LfWE32WU
 nyCRiOtrZSTyOVMKb98g0Mmx+vhMmTODIcqAvD6gzHuhRnbUzEua6YNnvW04bIR3oxbwAlAdR0M
 dBYZwmh4HFPwaJOWD0aNVI/A7M99tlc+5HVkI0mpyIlZ2ExqLnP54tDPWZPd3iCf9Xch7rzRmVv
 sMs4Z83ecksu5xXkJGsKz0hKMDShf6OwnS8TEu6O5eluManD6FZj8Fibrt8U8xzGI7Tw1F8ggfD
 7bndH682aUsbuegnSlf/175GB1YINZ+7bLVy4PKpp/IBcMiDFuRZ9uD1KlGu/MPSI2CsuaBQAsT
 hlDcwV3VfNE2NwabJLOMBuptozhgDnTe0u/QsvA==
X-Received: by 2002:a17:90b:1dd0:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-38293b9946cmr729504a91.20.1783108243299; 
 Fri, 03 Jul 2026 12:50:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd0:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-38293b9946cmr729426a91.20.1783108242651; 
 Fri, 03 Jul 2026 12:50:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:50:42 -0700 (PDT)
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
Subject: [PATCH 28/42] ASoC: mediatek: mt8189: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:41 +0530
Message-ID: <20260703193855.110619-29-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX5ph4RxUrIvcf
 ho1BAdULf7TA3n9GIpXWntbJAUnV1aoz3sGtLohWUz7WxKogOD9rwcf15cyVK+GC04CsLVdk93O
 9oRstUo3fzAg9CB97jpbGBbjvYV91aI=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a481294 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=vpwXisbvDR7QvT6TCt8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 0OHx1opNvYYmL_ThS7wEudhF2Pa6Qto3
X-Proofpoint-GUID: 0OHx1opNvYYmL_ThS7wEudhF2Pa6Qto3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX6FS7lhvhk/Fr
 FskkOh/Ijn6ufGq84gSftWwrom/m/1pY1EqGICR+FekmbLiAUpNGI1BpHxvulVrKQknr59e1ldR
 mWTZotsLKH0qX1gfXXjC4iEZwClSOPF9U0nDkaTziYf3ZJR9mzbXD8C5oPcddiWd6chllqUr18w
 oXLQ+By0SjLsxT8mM6mpFyyg7PM9llbpEgQsZZKs5tIr9HNg8mdJb2hkOo6XlMXry5+JvnvaY9u
 GdJKPLP2z37Y0LtaQ3gEYvY9apx30yw7CQpcDEulQ+d533Uoel/Ew19+nogSbd9O4o7o7cXdiLY
 K/amQ3sp2mHY4sUgFmov9JmULtmjZUvW5NQKAHkiKiIeV//P9OxEAbjRC68NKhQ/hArL3ziGTW4
 r3ogiGXShYgU7p3DXY+8ru/GzfV4nsfH0bmjjWR5PkPEj0QMM+y6WWuUuowrwm1Xxh/6qcpGhE7
 5izu7uxL5jIQgNeCjaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030200
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

Replace the hand-rolled devm wrapper (mt8189_afe_release_reserved_mem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource manager
handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c b/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
index 77cf2b604f6c..04baf7d9132a 100644
--- a/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
+++ b/sound/soc/mediatek/mt8189/mt8189-afe-pcm.c
@@ -2421,11 +2421,6 @@ static const struct reg_sequence mt8189_cg_patch[] = {
 	{ AUDIO_TOP_CON4, 0x361c },
 };
 
-static void mt8189_afe_release_reserved_mem(void *data)
-{
-	of_reserved_mem_device_release(data);
-}
-
 static int mt8189_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -2439,16 +2434,9 @@ static int mt8189_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "failed to assign memory region: %d\n", ret);
-	} else {
-		ret = devm_add_action_or_reset(dev,
-					       mt8189_afe_release_reserved_mem,
-					       dev);
-		if (ret)
-			return ret;
-	}
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
-- 
2.53.0

