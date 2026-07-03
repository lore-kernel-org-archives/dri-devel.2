Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED51C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FF710F8AD;
	Fri,  3 Jul 2026 19:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBbUqtax";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UVzAuMxt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F241010F8A7
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 19:41:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Hj3Y7676960
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 19:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wgBn60HnIhK
 vMMWvsxdr4oIopDbFr3Yf9yX31PDu3/0=; b=RBbUqtax0OnhW8ww+r+abiXC7bl
 aoj2BEWb6XNcMTtnbQ/eZQQJxadf53YUYpMb9HDQFPKsAxYE+WHfUJzjV5P7b4sn
 +Z3ANHcjpYktEAFM1C4CV1k8NP88eUtR7krkUEhWjX0o5ZqGk+Yvz3NJ/D7Kg5gZ
 iLxwHLhK6rE6HW9etExXvSejbzzbzhvlqP05WbAXXc3gJ7C0dwK72SOv94lYCmOv
 5FQ0R2Vsu2aQgsQFeztF5gpUm7zEWsntIJWZB6Bx1yTiQ1unY38c+NcNI6Nd5Sl0
 RQ7JIvskzNJuclWDN805IAwFDfDq911B4kqC6csAGjbvgwL75Gns/PO/jfQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj1gnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 19:41:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so1024004a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783107711; x=1783712511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgBn60HnIhKvMMWvsxdr4oIopDbFr3Yf9yX31PDu3/0=;
 b=UVzAuMxtejiSxmohM+twyp3VmMzvaTMnIFyBf9J0q2AD28Ehf3r3NW+lt2Fgy26673
 S5p9J3H3XQ3lFLofNRUzkQhggecMoVLPIgP+3e+SLxuBqB1lbSjl8mDWF/W01dv81g3a
 lBJLyQ9Ju0BATCV1Kw8QCScIpXMgS8l73kEWgn0dUGzc/hxeJTF6q4e8kJMfbXFzQZTs
 upN5dNuKRo3GgiUpTUlitLPffyl/bTFkwpEdIOr752SNaUr2JyJGtC524gnsuiHx+sSB
 BnpVe+4aEIN34jZPN5cPWxY4OKpchsHzpVuOFsgUwmjL/to+/ZkGqeVUDr/6Rzh9rbhF
 HRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783107711; x=1783712511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgBn60HnIhKvMMWvsxdr4oIopDbFr3Yf9yX31PDu3/0=;
 b=fTyKAup7LYS73Tu+HNPJRZF44QgvFO+6fJ95qeLyU8tZkdLXcPnFHs/AmuvvhGZg+4
 Ti1pC8Xp2z38AkMslh0MV1JbAMM7tqWTEQgqdfkxbY+6UVgK8ljEq4KQaCcme44GILVm
 47n1L43zyEXEk8j5o3RY1B6bGiAEaEZqf0Y5dMyk+sNYlt6C34USXR/jQ3zlQ1kAD5A+
 xiESz/B8eaXyGfwQs/IvnUKmXbINqKlm23NwsrgGxRz579y8KE5uZRyGwoSXeXa7albU
 qepqgJWTLS5rymloSV5nsDhvkmXiyBU6/S+kZR/1vtiNXwkXXTcnW2EQmv3XxH7nz4F1
 pfvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/47YdI0/rpOqPrtP2y9HlnwzjNPk7d4MpEPoy51y2K6U27eXAnI9J7G3S7lQEU/Y6/HBRwPeNYlgo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiA6lCIm04Nhvus4PaeRu6r272osRxzzvrmIkozZRXor9DjqYB
 aORJhMwVkqQo8bC/E4EgfKkvLnSlSGRCZXxhVYnUv7CpHMCPv2aHZMBMLw6lXPmKLGRYDHlUG+E
 D2AFIdVTnnwvKZ+HAWspH3nBWYF7OUkjFwnmySZdqbtdaygh437LLwueOPm+F0pCISaQFSvc=
X-Gm-Gg: AfdE7ckLirba635Qa3Zr+Y7tpE/VrzIBCe42Yzww/G/kHUAaKR2pxMW5MCmJLKQiQvr
 9V4XKY4Vl8u1h4Pqvfe+qQn0en6lOLom00lwKasFZBw4eewe7hICpUhtWcx3X/1X4FYqVbOiz4S
 I9D6M0stKFmpXVGGVAMoRXus9hLLy7G2a4Z7yrEV6eQM+rWB/nGk1DrZSVjN1AsePPHRoKLW64b
 iS0SsuEYS0DDBm3x3tvUosOrXUwhXpYHr4snfhDYL5a+GcMx6sSCjla+WSCEvjiRwYtRFfuTyZL
 uhL7tgzWhwCFSUifjwwLC3Lmf9EVQtT3/Ki0nHG50xyo/4+1WIVL2V1z+VpEuRMkkplxV8DhWcN
 lVw2J8NPn7/yWy74U+3EtO5aox1qltcG3PZ3tww==
X-Received: by 2002:a05:6a20:734e:b0:3b3:6db1:5986 with SMTP id
 adf61e73a8af0-3c01cb9a275mr5809399637.30.1783107710438; 
 Fri, 03 Jul 2026 12:41:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:3b3:6db1:5986 with SMTP id
 adf61e73a8af0-3c01cb9a275mr5809352637.30.1783107709738; 
 Fri, 03 Jul 2026 12:41:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:41:49 -0700 (PDT)
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
Subject: [PATCH 06/42] media: synopsys: hdmirx: Use
 devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:19 +0530
Message-ID: <20260703193855.110619-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfX+ehrQwRRrb/C
 VkYa2aR/1zF4HvBbZHmXQZ3cxwtcKXRh24IJ8M9PrZvUPWv57ErwlzrRrDQQrge0bjnFMj83GtP
 EQOLmfCCyvEUNfu9nY9EH8JJyvlhqyc=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a48107f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=wxxTr_YEz1i4iFEBgi8A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ZpCfrkjLROq6g06gBIhX87UgKWadL102
X-Proofpoint-GUID: ZpCfrkjLROq6g06gBIhX87UgKWadL102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OCBTYWx0ZWRfXyQ0JXevdMbME
 04EXJ1DpmTXvI5trSX6pqo1IYA/Jo9RQeYNIjQAzUB8MwU41XFqAv/pK0KiIxaU5Ie/jb4+oBQQ
 sxIJUdo6w0BimZF3zCIhFAbtv8FBfDZtV0oCoYUNiJhXQ0WEVFNweAWB//JUl3vS3N/ilVAJXJa
 50nZ+NABvKf5WgCHYf3Ku//fDtHq1apZ4mMwiT9x79/r98tekLUGHMenmivEiFkWSOtI81AvSal
 Ps9Hd4P4e31DcRN16w47cU7qhyLbuaNIhmoPNndDhhCKv04j+edHyC3wImTyh+arXidaOz3tTro
 PTJrNQ9EL8G0btvoBgJkaJRMAEqAZZvhLRjK3ZUPJEi7JsRZL3wpIknK5/J2LbltxYlXps7HFcK
 Kq6x5lfshDgiY5rcOvzCfb/STJOd+K+VOwDxS+wQXw2/ukIUlfPuhUpatGdPXExhVZeJiLda9uj
 RCdboYW3frx81fSg/Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
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

Replace the hand-rolled devm_hdmirx_of_reserved_mem_device_release()
devres action with devm_of_reserved_mem_device_init(), which handles the
cleanup automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 .../media/platform/synopsys/hdmirx/snps_hdmirx.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 25f8ca0d6d94..7c6acc6d7e88 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -2265,11 +2265,6 @@ static const struct hdmirx_cec_ops hdmirx_cec_ops = {
 	.read = hdmirx_readl,
 };
 
-static void devm_hdmirx_of_reserved_mem_device_release(void *dev)
-{
-	of_reserved_mem_device_release(dev);
-}
-
 static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
 {
 	struct device *dev = hdmirx_dev->dev;
@@ -2316,16 +2311,9 @@ static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
 	if (!device_property_read_bool(dev, "hpd-is-active-low"))
 		hdmirx_dev->hpd_trigger_level_high = true;
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "no reserved memory for HDMIRX, use default CMA\n");
-	} else {
-		ret = devm_add_action_or_reset(dev,
-					       devm_hdmirx_of_reserved_mem_device_release,
-					       dev);
-		if (ret)
-			return ret;
-	}
 
 	return 0;
 }
-- 
2.53.0

