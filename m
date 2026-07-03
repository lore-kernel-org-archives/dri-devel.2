Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A523CC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 23:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E821110F9C4;
	Fri,  3 Jul 2026 23:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MwuefZpS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZF1hK3E7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059010F9C4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 23:12:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPaKJ1019673
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 23:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ptvjiVFY55mHuzyR7IOPZN3q
 jRdO4GwgfZdidGQ+xdk=; b=MwuefZpSFTvuNgJyrkHy6OEbxdQIh4zwoxkeV0v1
 SeNT+DdlpzYtM/NzLKO5cRhFyyJnebuIF5IKibnQH9YpiTNtspV6uDvHww+LUUZw
 Z26z8Ghqy1Bdy97MgjMlCybQAcNvxhH7AanAObFO0nN5IPodyrTpWh3DwjILH5JS
 lGZlFabkn+OlzqLPqxZPmZYtMum9AdRVSTRs/wP4GOzKS3Aj0HWCmra/f6MkDSMw
 qYaBJCD0DDY6/4P6Rd9xzPP5E3hUq7S5beve23YXYe29Mo8LO5BMBx2bJeVN/Pjr
 eFrVkDRH+FB3sjLbh5P/z/JAV4UUnzJ+/KZJdzBA5COZEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj20jr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 23:12:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0c46bfb6dso16198086d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783120363; x=1783725163;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
 b=ZF1hK3E74R2KW/tu6F7Z35McwvVdgqYmLBBv3Yp3CVlnApdNQqvSUvE2FJOFnhQdvy
 Fr3NQsNwX1yYAI55f0HLqKE57oimyB5YcKGl0XYqG/muQzuobuK0ZLunT6J40DBgHPvx
 05c3c3UVUH9kXhWTWPQIj0IBUj2nCsoVyhDgJzYxAJ1IxXpvO7onlmje6kKuyd95+hTy
 6JXGQpz6MOiZa1dk+Hw/TghijXV3E4jxX8fU5dcs/XlqwfxsZY4XKKpzQhcMzKwWFYRF
 BCC+0fk/crbtzNdJ6ayeA/IrnTBY7+MuuyW6BQMC9t5zymiBUUM4hk8V0ZNp9LteJAL4
 BOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783120363; x=1783725163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
 b=U3DWs9tPUnM//Af/N4sTR0eWaKTSjxFYlpXpFHXGsFnKOmZLHcOLbAy23Fhuw9ctIo
 a4tbgluHyOA0METgIl9b35eVFEpM+SK2jjlJCevhL8tNHwpggmorubaPzcdc7nUjd01l
 K5j7vq0bYZl9Odx2LxsP0+uWwB+/k8z0FppQCbaE8VU6JLdECq2dXioleC+Qw4hFWEA8
 h5f28lmb+7s5eQX/wEx2rPD6Tx6qwxpULqYGv1ufoWh1v99aIMfa4aZH5vpqzhmhdAAP
 5JWz0GhCT+Hl+IiokcufyuGEO3/XL+hHIw7bhtz3TiP1do9ywFK1H8tCEevhS8KspAR6
 xX7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5q4uoXOnhyv5nRYvyyO5Ace2W3MFXZJSjrZCp0EBrQTZ0+47A5eWWcej7IHVbZBmkGewmzZYvJos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBI+iuVY/y48l2sZDZ4+NAMF02DMtyJ5+uNp9duVs+I7GetvFp
 PS3dmjXipwV5BfhXqxb8wK2s/etwt4BDVHOMzPYlrXbaQ1HVZ4lrbfYmipE7gyISY9H53JC/JQW
 Sa9dZatiRDfvwZLrgO0QU/6uOV6tB5buMWn7R4svrkzqrZSIo2jl2az+xxiBtUNQFXVI4atk=
X-Gm-Gg: AfdE7cmWNWepHst9lRSgaoiJWPTQ4VmhmHKxuZ20tFiINU9TUo1rqVGGAFU3Nsd4Z7K
 kRVOcH4qdfP/auk7NbFqRAMv/SQ1qFDCC/XZzm8L7chMscQn/vewfqr/FqHziDNgXHPL/9TpdIk
 dvFPvlUGjMuQMpEIs6DLI3LKCkAFTybFfeTPYw4ZmhWmx7EgtGZ6zOY/N6Zep3Iz9hIGJ6OlsUU
 9oD72G7gstnvx8x9vg1xs+PchwN5f+eT62TVn6s+7ahFZCAgUW0E9dT7Diy2N24ofl0D/+RH/n3
 JB5qjdrtsfhGI1A/F0BT5tRUd96i695Euy8xDLfOUcqoeW9gru7uNCrLEh0wXXcYyP9DL/ASINH
 dqqQdPRK9A649al8Tfv+/GVnkOXtNtCOZsjcm8qh3MZRSRLw+GCs+NBDTJsKcfni3tUsLc/S9pA
 Yv6vFCL8pKRwpe10uHrMj8k+UK
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id
 6a1803df08f44-8f74c0a468cmr20755596d6.38.1783120363152; 
 Fri, 03 Jul 2026 16:12:43 -0700 (PDT)
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id
 6a1803df08f44-8f74c0a468cmr20754586d6.38.1783120362600; 
 Fri, 03 Jul 2026 16:12:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c3a0asm815528e87.71.2026.07.03.16.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 16:12:40 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:12:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
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
 imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 03/42] firmware: qcom: scm: Use
 devm_of_reserved_mem_device_init()
Message-ID: <6ejxrh43bkhryudrxk3lkzf2knlgv3mxtfgzhrzujw7km4n5bq@4bd2ahopzs4j>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfX9ZOzxCYaj8uD
 8dlCIrLpn7nmQ6xglLWiLq4WHO0A1lYEQpYBIIOw6SiPlfpQdOYmZ4kWBf5l1uJuJpLpiTUmpNm
 druPsONNLU2wpZ7OSqhHGQDYoopMbwc=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a4841eb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Dn8qeLIeI0d_esIdenwA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: X2D2PAbRtohPsfK1--7U8jBSNgwEUHPe
X-Proofpoint-GUID: X2D2PAbRtohPsfK1--7U8jBSNgwEUHPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfXyWNr6Dt8O0Uq
 OM2YvXcpl8wpF4e9RsWADkI9K/bO60ShaXt3DKi7VyXR6067npaU5Cj/if24f/ZkkTMri73jAkJ
 o+aKOuXm/Cf3T/iTsKQ6kcohyzEs4h5OrPwv2Tsml4j2GtgALETmKsNCyZBYv1D44imfFmMpOOP
 fA+UW7DncToQ4nZvObQiSY42RD3hSK3j7A4Mi/MG246FXo5Sq0JibNxxHeYyCkQTInZGUzcuvF/
 Th/T0U99izZsAOsMHvnFm8xc+NKzGAWZPksuGTqu2haKuRy/luJmZbSZvNaSETHJxYNEtQRvadN
 YZcfZZNAufyWTE3PJNUF0GoCdjvA7WV5C2qOqLiA8+bx/MjamF4KAPfQSL4AAd2Zfr5yaoTN4LU
 Pa6+n88zrvz7dvc/nFT5XZxOsosV/7XTykFB2uM+CQ9wUS1cdSpdmqjKJePznmltlh89tmYzxCs
 OjIbrxgZ+bW/syZgBtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030233
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

On Sat, Jul 04, 2026 at 01:08:16AM +0530, Mukesh Ojha wrote:
> Switch from of_reserved_mem_device_init() to the new resource managed
> devm_of_reserved_mem_device_init() so that the reserved memory region
> is released automatically on probe failure or device unbind. This
> eliminates the err_rmem cleanup label and the need to call
> of_reserved_mem_device_release() explicitly on error paths.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
