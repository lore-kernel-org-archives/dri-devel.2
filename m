Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8A8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B6C10E673;
	Fri,  3 Jul 2026 19:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GDm5wsiL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U03HyEQG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBA110E673
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:41:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiLF5695171
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iMva+1PZ1+K
 dQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=; b=GDm5wsiLQ2TMvz973C+7bjcmlR+
 KGiJp336Y4oOTICwBdUWMVqI146VpcWF6oH7l76OWtFhwQr/KC5Zs9E8CvG9J7Kv
 ghE5vT6lPIQaV3lb9//L6Y16OAJRpWdlXWygrH0x16FdDhVXJ6kE44kz/Z1ZCaPJ
 hhl03lmmTzIpMfqywvxTc/MkGVPxMgdFzcQsj9e+Ow4Q19hKKQpCdYr4vstuLfN5
 nFuUJpQSD/qPK2d7c2OTxO/zefd1KvlVaVXKOCYcganHPsX8mha4UUsMTkmcYIvJ
 oWbjPlo3Oz2VXqGEBrs0OQWWevT4vm0EG6eaNXNQU4rdU4R44hcOITOVEqg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a58s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:41:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8894570b58so643382a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107687; x=1783712487;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMva+1PZ1+KdQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=;
 b=U03HyEQGf9EHyZ12X6GZBodNj1JAJDUvGWEPXRT1n7F1mCBYVdKP551chh4bFnEGqQ
 3wkL1H73UQ0A+KYLzaOC0Oh4t+nqRXLaMhGCAPVuRfdbHEIkQRE/PPpY/U0FnYO+NrUj
 CulGxiRQj36JGMFz5NhOTHYJD4stdoqIniv5oc5HZGH6FxKj7gaxSZTP/nNBLUM1tv4U
 epV4rVb52LPIuK4+zD9B5TbVXfoj6K5mYZcb0z/Qv6PjywyZWLFEV4v9ktu8Ug9evDjJ
 ukBv4bFbB5WFnWNon24JZnhj1x+gGPjWcJHWHr0nxKQQlpM+u2Y7+Bekupycu3D+2MNb
 ZNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107687; x=1783712487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iMva+1PZ1+KdQNeTwrqYOxfRk7+6bOU700RhvaCTUnI=;
 b=G8b4Cvwy/spfQbtnBbb4Yx+gf6ScgMrdGFTEZNSkfmKxCg4+c2qaPB4Tn2TsuCfkuY
 8mcB4vhsVmuWlbWD2Xg0SDIY5yeAdsneryMAmFhDOBcUWUNMkp22XbIUXixgIvbVKWX8
 /bjm5cOtbl27k4xVjYEz3mh85qt9YzQLCjrEEOz0iH8ET+GQ3kB9KbaV/Sgqe2lqROX/
 HiaPEnnCK0XIdIbDn+vfus8ikNFucxMoSEiWRJ7+BSh+HVbaqMZlk1nNUYhfmcEW1i6r
 LMLZoP6km6ihHWzc5R3qUD/XurGddRS1+ANznn3KVG3ObjVjLiNEaoLB5AFAG/6FiYXD
 azXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dIpiShBJ2aMIQ2WoR7PA/3QMd11sKpYcrCjBK1/0TBbgxanuDtTeeayFNoRpOrSKsZk+NekiBs+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPwFyFCOBjbWIpHo6MJWv/8hfGk3VJNZenw6tnWPYM34NUIeIm
 GHJhKxpoTUduBHf1LRIjzy2x7AXSv1b22HH/svQxrGM79vnKBagS1pqeexjQGNGwDihY8SXr4Nd
 qvFfR20BbH6r1HePPiKGGV1gPjX5+lAAWAUPa7sD5WCiDH/NShRjN/1TZI9bnd89sBDcs+Fc=
X-Gm-Gg: AfdE7clzGNwFy4mlQ9quAB6UwMwaa55TPwQH1J3UMDuRv1GuJuRARtycTsWam/5BHEO
 Qz4trxN8ry9EviQaSHYUae6EiloPM5OTqhVOg6KmhVfNBhPmsHl3iL/XJU/HCOTKPh+xoGWOuqL
 lLuEp8iFIxcwE4om0rFj8tyHw8Dvre6EBoh26yev4KFBEULYq33ZxHlOQh25OeVnmMXPBntB7zw
 PGGsjSM1vISg3sqWCY8HcaeaRWaxfs+gtJeZCym1cmfHAeRmFxirgQIEzkwebPjJAFCZw1zuvnC
 GB8qxzAHg6olJflLgai88JrO+9W1TbuaCIDQgt0K2U68vjVh+m2VHKTo83bAyw0TssKA2Qqgey8
 zXU4sPBmm9pP3obpqAq48OqZcra+IGeXIk1jiQw==
X-Received: by 2002:a05:6a21:10e:b0:3bf:bc9a:db16 with SMTP id
 adf61e73a8af0-3c03e1ff210mr802288637.11.1783107686239; 
 Fri, 03 Jul 2026 12:41:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:10e:b0:3bf:bc9a:db16 with SMTP id
 adf61e73a8af0-3c03e1ff210mr802255637.11.1783107685626; 
 Fri, 03 Jul 2026 12:41:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:41:25 -0700 (PDT)
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
Subject: [PATCH 05/42] remoteproc: keystone: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:18 +0530
Message-ID: <20260703193855.110619-6-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yHjAZuNbZEu7ryo2Pkfi-4vvOXFrsvfQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX1G4BdZIHR3HN
 h++OOBnDE7nKsT8a8bnBrt+wPudim3Tmx6sUztxxp6QJ3NV//zUBvQz7TYZ04DKBHYJnmhwqDqm
 p4NXn0BzkkVhVnkT58h+vX1By78r3vk=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a481067 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=eZD8004roD30yaJJyL0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX7ijjEqgyhLWf
 c9vuT9ggxNeDS+TMGvMbVSICe5DWmpz/6MUiwKHS8BltBIa24d5ins+K1pwqsKHa+pORMgRfWfj
 pLCpyjlzTSa34AiL7RXgyzDA9ONqtVYJwHEkNZNMtm0xXhfIMcWjGDVqGi7W7SsGFci2bUvq1f5
 ik+5nVJEkRFwAJDjwqRJ4HCe+mk2SL+EdeR8euLm4F08VYqTevx/FHY9Q3qEI5do0suphJccqis
 JyuDg8+Jpa+gzeBC28wFoiDjMWak8e7v3EYrEdDkuq3NL45Wsn0bKDMB7qS8QUsVB9vEEgspQU7
 qaraVmTbW6suhnMSO0RicxLZNYl5l3BAMOjyE7euEiFKDDXGmBXbuh/Q2mewQYpTm+NeeOAsiRx
 vRqZDTs3iZ/oXR/INHGEjiGWP/EM7D8Y1TxI93QT22314AKxM/mE8AIPzuCixwTQxKj8D0+QOKU
 gYzLUek8Tg8wGKUKrkQ==
X-Proofpoint-ORIG-GUID: yHjAZuNbZEu7ryo2Pkfi-4vvOXFrsvfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
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

Replace the hand-rolled keystone_rproc_mem_release() devres action with
devm_of_reserved_mem_device_init(), which handles the cleanup
automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/keystone_remoteproc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 83763d640c4e..7834a50da209 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -330,13 +330,6 @@ static int keystone_rproc_of_get_dev_syscon(struct platform_device *pdev,
 	return 0;
 }
 
-static void keystone_rproc_mem_release(void *data)
-{
-	struct device *dev = data;
-
-	of_reserved_mem_device_release(dev);
-}
-
 static void keystone_rproc_pm_runtime_put(void *data)
 {
 	struct device *dev = data;
@@ -426,14 +419,9 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get gpio for virtio kicks\n");
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "device does not have specific CMA pool\n");
-	} else {
-		ret = devm_add_action_or_reset(dev, keystone_rproc_mem_release, dev);
-		if (ret)
-			return ret;
-	}
 
 	/* ensure the DSP is in reset before loading firmware */
 	ret = reset_control_status(ksproc->reset);
-- 
2.53.0

