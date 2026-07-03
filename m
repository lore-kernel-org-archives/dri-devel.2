Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DDEC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC4110F8A6;
	Fri,  3 Jul 2026 19:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J8ZGLy0x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="guOU+hzh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A4F10E673
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:40:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiFOa546492
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zR9XRPc5AVu
 codt4jcddD2QULOfOq2FWZnJr+n7Dti8=; b=J8ZGLy0xXXuEjWJGW3BRjxYS6bM
 3+dbuT5zbOpIDAwUtNGrTXtoVnVWOwNUo6eIEA3DECCTEOtiBQ1DMFD0phWfoFf2
 dZFkiD8S7fenOGLkh0uuwz0ZkVjPa2JedzgOBGqFoBe+xMf5ZHKUOiSR5XFIcwzg
 mhGkObWbnIWinotY2TsclIJMO3qilpuGC9sJY+SB7NtO+LXzC21V17p4igcMbF62
 pjaIAo6TLB7y0l6+cDM1nurvPxHtA5vcKRXylW6Y4a/iQr5UqazN6A1IsYRX+Vhz
 /sKeBg0qQU3hsuEMTB5UiS1sB1Gi2oxTql7R/jI1L9tJWier4ElBv2IRhgQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j02vcc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:40:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381250979d5so911779a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107639; x=1783712439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR9XRPc5AVucodt4jcddD2QULOfOq2FWZnJr+n7Dti8=;
 b=guOU+hzhMeHtToMw+TU3zvX2wyNrgdF2cT7Q3DJlaivv9IL+X8wZsokTD4gm1CXmt1
 v2739ODCY0zf5fYAW88NtmWv9Dvpzmzei0qWVazbqbEW8deQWZIXNmp1Xr41GRa3Bihr
 hpxRC5MjmO8XAHPuKq6727lpdgsORivsW1KUXGjHIXNXp9MgKE0gOnJUR1V+BOykc9dG
 0zP6COnY2tZoiV2+2d8OsfNdmRgbJlz8qHSQgn8iI/1LO1GDz11fNEfro9k5HbSnHjUw
 VnFGB3GicO9QoRp9J12mI43npAnekp2WjOab0RbbJg7kb2uyLsyVx1AhYttgC29cu5CJ
 VPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107639; x=1783712439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zR9XRPc5AVucodt4jcddD2QULOfOq2FWZnJr+n7Dti8=;
 b=P+CZ61Xkf2FFBUp7Na24OYskptxmJgkYWuQmuAqr971so2L8Ft/3jZporqdE/BNJlC
 wtXm33Xxloku/ClZdf/6QxqxEyXbsOJtXhWTt6GTVEWbQCC0eEg0Cx5Lzi+0kqJNwYb0
 RxkbQYzQVw3BvzFbSkata+KSoksoR3MzrnBccdK9OfV1ivOrBCv+zhdiJZfOJ+UkJXbb
 mrnNW0p7bBOn6ZD7Oy8urpZ/8D+33nVFtE3ZtCuIMFtUFbgLZ65cTidn/e1Ske6ft147
 xnqTPFrRgQ0Xpln76tvYaAZ5DP9sux5YEU62OZlnFKD1ZBKAcUVzFzjCVThjICjBekhF
 nd8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RolMNHa3Tho28xRpT/r7aCXn6ilzNgz3qSaMREokCZ82sgDj0Cx53f9/0rUHHPr82HIgiYrCG2chkI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8w50/6w5wfnigT2IYD9kqQz7eNqEF1j7VvW3m0tmY62DuuGH3
 Kc5CBsLiR5jfatkgTVOvpsx7GqJpPG2fMtiDwWEKrnOvGOzBG+G18NRTRz+w9c87ORDNAqANy8K
 B9IGGsrNzcIIDau5rIJA91QyTjbG1Qvyasf332PNAdLRYfES0ow/YZ7pgXLtze4brXqKpfso=
X-Gm-Gg: AfdE7cn1pwvLgDVL3YkOnq2g0SUCiG3rd+bh+m5pRjPe7KbFX1ZCrDR6eQKiB6rL9xG
 tPNhwu6DHTD0ByA1cs6S8/2vFJ7YLCDoOyU9aE2MVca0uV+lkPkwQ+Gef2MBp5YtZB1JmJZLWJT
 F8LMT6f2bb9OA6pCYGCE8vz0b2x1ieS73S0vFZfdC/VywXSk4z/hQI+hozXhzLSOMu1cJX8JQtz
 /vbn4iXsj9I6RQD61hspcCEH51H3XXppvRIcg3V4ruQOJytledVavfFdy2SGTfs4ujGdyyj03pF
 rsC8kZwLVYqxdOL8H9JZlHOFWKNCgPORn5KX2TpEbuPvd1aPTeFZu/9z0hK2kTmDYAIwuo80JpR
 g6aVV3oWYrwPzdTDzGnoRNfkzAaxAn2VLkw9/Gg==
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id
 98e67ed59e1d1-3829effb428mr834287a91.24.1783107638332; 
 Fri, 03 Jul 2026 12:40:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id
 98e67ed59e1d1-3829effb428mr834169a91.24.1783107637623; 
 Fri, 03 Jul 2026 12:40:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:40:37 -0700 (PDT)
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
Subject: [PATCH 03/42] firmware: qcom: scm: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:16 +0530
Message-ID: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HOY9vC1JhOm1JaTYIZOBYw667Ake2qh3
X-Proofpoint-ORIG-GUID: HOY9vC1JhOm1JaTYIZOBYw667Ake2qh3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX9DCU2vqLcGWd
 up/4Dud4BiJACzZczfxiuAddeTpynfbd7NH431d686HicBvFyQAaqX5byYaYWB/3ZU36zNfnCQ5
 g/1Bd7ya+oviroviZaH6vj+Z5P5cM2Q=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a481037 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-SVse2xkFbf2KMwQCVkA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX6NyA1cxtJiKF
 GTeEaDrV84LctWtKrO/57Is6cUEZ4/RknMv6HhbS+pAE6GziNqFpZjZAAVYl2nFe/aQ7e9HdYZB
 J1AOzPi5fS74FRBIJaWy1A1M0LRN3SpBujZ9+AfL74BhBEvm621xjTgO/pKLi9Bh7fu4PPDpHuP
 3hw6zY/iOkvkLPHVa+BVuB+wWOgEZPYPan6tFYyu7M4fzrRRAWaj/ZU439zU8aW53wyBV5CeKog
 RtT5JaTGlYJ5Hcjt/OXoxoRDFao0opIkv154BXzeyvZitgeIQ4++5U28DOl44kHuycE7QhEFXOi
 aP5yNV9afhJbXT8bnenkSDZs4QyGyjTBTxCdIHiIUGqOeEwIWlWB7TUn359tFAUHrm0TWrVN4Q1
 T2/RGXRkCm/mW/lqNzjoFJc15edaDKWL0r+Rq/2nW6DdWTMAXwHE4i+rjNoFMQxlckAgeJcjZBU
 5j4JijeApK9oolZvcIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030198
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

Switch from of_reserved_mem_device_init() to the new resource managed
devm_of_reserved_mem_device_init() so that the reserved memory region
is released automatically on probe failure or device unbind. This
eliminates the err_rmem cleanup label and the need to call
of_reserved_mem_device_release() explicitly on error paths.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26bf87247afa..0f9559b9cc53 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2779,17 +2779,15 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_reserved_mem_device_init(scm->dev);
+	ret = devm_of_reserved_mem_device_init(scm->dev);
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(scm->dev, ret,
 				     "Failed to setup the reserved memory region for TZ mem\n");
 
 	ret = qcom_tzmem_enable(scm->dev);
-	if (ret) {
-		ret = dev_err_probe(scm->dev, ret,
-				    "Failed to enable the TrustZone memory allocator\n");
-		goto err_rmem;
-	}
+	if (ret)
+		return dev_err_probe(scm->dev, ret,
+				     "Failed to enable the TrustZone memory allocator\n");
 
 	memset(&pool_config, 0, sizeof(pool_config));
 	pool_config.initial_size = 0;
@@ -2797,11 +2795,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	pool_config.max_size = SZ_256K;
 
 	scm->mempool = devm_qcom_tzmem_pool_new(scm->dev, &pool_config);
-	if (IS_ERR(scm->mempool)) {
-		ret = dev_err_probe(scm->dev, PTR_ERR(scm->mempool),
-				    "Failed to create the SCM memory pool\n");
-		goto err_rmem;
-	}
+	if (IS_ERR(scm->mempool))
+		return dev_err_probe(scm->dev, PTR_ERR(scm->mempool),
+				     "Failed to create the SCM memory pool\n");
 
 	ret = qcom_scm_query_waitq_count(scm);
 	scm->wq_cnt = ret < 0 ? QCOM_SCM_DEFAULT_WAITQ_COUNT : ret;
@@ -2872,10 +2868,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	qcom_scm_gunyah_wdt_init(scm);
 
 	return 0;
-
-err_rmem:
-	of_reserved_mem_device_release(scm->dev);
-	return ret;
 }
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
-- 
2.53.0

