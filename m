Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4201C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A04810E997;
	Mon,  6 Jul 2026 13:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxURCHyC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJdsRQui";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F6910E997
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:16:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxLt6174947
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 13:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Vz86zd3go04za6BKCrEOJJ5A
 QbsnL3kIqNm4xRq1ahk=; b=gxURCHyC5Uby2DEF/Sz+/5yNg3sVS5RYamD/XHiq
 Oeg+y1LJwkhEFbOaeUT/NQGKPdVK2zZ8VlG3hv6H4S/me/nezIWTxoEm9In3Bs8g
 ZvdBIq0+/gprmciBEXPztT6Da/pNCqKAPXP77qtywx46VRNq9dIbfHagzvAaAEIl
 E6hG0pwACBSPp2ODRqZ5jgVnHaYTwWXW8Uuan0qZj5WO8InmLPD6We8EBKixryDx
 iPil71OMzHER33szNYpl62CNRKnWkJ2P7UpjNxjXjQ3Ou5rCnNsvVYC1bhpBPa1w
 4pcAqdWpoDmeLyJqbgihNBYMa0DBssjFzMUnNnE2Yj0Udg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxsdx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 13:16:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380a638fb5bso3061803a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783343815; x=1783948615;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vz86zd3go04za6BKCrEOJJ5AQbsnL3kIqNm4xRq1ahk=;
 b=aJdsRQuiCFF5WACYwDOv4J6QpqAn036t/G2+WdnNS7fOYHA7JhHpIYZuKnwkR7q7b6
 6IMeNDUI+eHkD33VaFYzxewF4MDE5GbVcSMEEXzkYW7poKwe7OHMf+Doj0f2NuOLMlQh
 WxWwJfO48KNYHUWP9qH5P64kJzm38LEdi+U4ynhjmsVUl8KyyXs3CltHeB7Xb/COpd6U
 D6kP0wVoEvEbL42uExmlRUVjTM4dRSyzyja432YcjakfbulC7m3ll+RyrrKQIJH3wLMK
 QWYgbNlgKUBfhRsLcI6Mo0X7ba6Es7MdftfGdxvYqLqqXo9vRQbPNX6i+8z3tah//S2Z
 dirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783343815; x=1783948615;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vz86zd3go04za6BKCrEOJJ5AQbsnL3kIqNm4xRq1ahk=;
 b=rdql3aYW4/HFCWlnRTzlV15rT9JuQNafh7RVZhhJxgpcg3x6joh8EG73lvJVPjLQ6B
 +B+Tykt2XHbrhuZyMek+Og9XB5q69S+Nm9NHxglYaSM+o94iUg/QIC0g5s+OzaDChUm9
 zzuZLe6kOpr7x4IQ/lUHXa6K2oWIUzQZl6aswpY1lSkMQwJLzK0z57I/+8IzxSd06vwi
 jJcE3oDjc1LZJVfWChKkA4pDrmHO3J/e7xlTwhKROifADK9laEB61rMQUvqH9/k80Zq2
 hCBt+vmhSQwh/sLmKJoWv0Ja0CFb06t2L3sDWGkesh309nH2nkDoZ6SD7RoDT4ecLLZK
 5G0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH7JA7Ukqin9GMNTJJUQUAHFkiXV1vvQltJ8VuJWMTLb/uUoAiidKg5yFy/OBZyEeT/gsjUiczbDc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNYa/0GUEf8WS6boEIUm01O7m60uEfS1GmYtiTYW6j6l76AnLm
 WOnsljZxfINg9YwIxZSF1JAaJmQV7r7x559KkpwbCI8R2uLdpdbJvXttudMTea/HDFTEM9mBXuj
 KV9pDs+9nbDgO8Q4rl4d9DcpJuiCW9xzYo2Sl0CkrhR7Xv5+iRXMug3GNHwRmfzwnRbYAXdI=
X-Gm-Gg: AfdE7cl0sgdJeyhLZsoKaxGXgFMw7hcnnDEUhR+Qu+NZf5X4dO1gLC0jUUjshHRjGF2
 kn7BlRPtEdiRGyS3X0nrDvM7cV+yBUZVdMohvlvd8A5mZgTm0t8yy3j7zr1k5dufwl07sLs0AGb
 Zf5O4PJ0iCj4jE+y/bTpAYjTU0cZOMTS1hM6axL0xqNjYYX7MFJUDah+pq/KRuVepJWtFCKI7el
 CMqsQZxe7N3xeI4QGP4+Fkq9B55hXelqm7euRu7bVEPT4JfNTJAxiymquQSg3HrOquTTgwYzD7G
 pOlVqNMeAR1sBBTqfQEk5fCdx2VEuXRUO1OmxlKZ38hLJ++6df1o2TdLcubXO5kyiVtxPQjLL4c
 8yE0wXiwHckIM1/TZobfRZG6BW0++/WBQCTXMog==
X-Received: by 2002:a17:90b:4ccc:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-38755769514mr376378a91.11.1783343814423; 
 Mon, 06 Jul 2026 06:16:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4ccc:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-38755769514mr376272a91.11.1783343813871; 
 Mon, 06 Jul 2026 06:16:53 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311561dd3a1sm16176449eec.22.2026.07.06.06.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:16:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:46:25 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
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
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
Subject: Re: [PATCH 00/42] of: reserved_mem: Introduce devres helpers and
 convert drivers
Message-ID: <20260706131625.nygqmu2usgifmias@hu-mojha-hyd.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <ceeca378-3c76-4b2c-81b4-0ff1bb1e99be@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceeca378-3c76-4b2c-81b4-0ff1bb1e99be@sirena.org.uk>
X-Proofpoint-ORIG-GUID: PPGF4kgvHjHUIBw380g56EHTw1ZfkP8d
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4baac7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1XWaLZrsAAAA:8 a=sOACTKiIrrgCOb8DNPwA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNSBTYWx0ZWRfX31Bm/yAJ5Tu6
 YhFV09R6UaSTkMgV/zAqo4rFWJJUUgOTyyKct+f/iY4kf0ycmBQpdSx6KsrI5JOXz/hvX3Ldwa8
 de1yp52dzgckzNHR9RNI/AOr6pruRGM=
X-Proofpoint-GUID: PPGF4kgvHjHUIBw380g56EHTw1ZfkP8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNSBTYWx0ZWRfX2wJdFi7QnlW6
 A6eHmX98VbZm4LrnBDtdsT0r8Q88ide3sTX3TCt25/wG8I7CkPt86v2pyJUEWLbBVEqdnHUzU5U
 ehQwvsBGYI5reu5cGziPIzaCLI4cvoFeHpvJS2Lub2uA3J9x08qDy870uiUslwNL5x2qAvc139I
 vP7XAv9UUCTyF5D5rsiZkITA+VWOkMQtYMtz654D7eNIzteI6bdTneYCUl+22s9O6dOI8ShCZlf
 ak8Q/cwxd1gauTOWEjIZDaJpKr0FSiErlBj/XqnonGjbkv5KqQYcwsIHxXRPs6Y4KLrtF5tJrrf
 +LeeRpKGX20BZyyHv3M/pUQY6us5pzgl7vo0bj6JS0kfL6k+1PEkQ7jqYSaqRUpInyDKn1Ntjlb
 ErKOhgtPUORVg3Dx+ZhbTAPhkUXKOjd0zXmRiKXGAbCDDj3iM6IarGwVjCZ0cjuya/UhzzaKzyv
 Js5pe74Z3+PfEqQsYwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060135
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

On Mon, Jul 06, 2026 at 01:14:13PM +0100, Mark Brown wrote:
> On Sat, Jul 04, 2026 at 01:08:13AM +0530, Mukesh Ojha wrote:
> > Drivers using of_reserved_mem_device_init() and its variants must
> > manually call of_reserved_mem_device_release() in their remove and
> > error-unwind paths. This is repetitive boilerplate that is easy to
> > get wrong, and several drivers have open-coded the teardown
> > inconsistently or skipped it entirely, leading to dangling reserved
> > memory references.
> 
> Just as a general thing, rather than sending a huge cross subsystem
> series for something like this it's probably better to just send a
> couple of examples, then once the new API is introduced and either has a
> pullable tag or has made it to mainline go and do the conversion.  This
> avoids clogging everyone's inbox with very big serieses.

Apologies for this; this is my first series touching these many
subsystems, and I also learned the hard way when the entire
series was not sent in one shot due to the daily sending limit
via git send-email[1], and I had to cut many cc lists for patches
33/42 to 42/42.

[1]
4.5.3 Your message has too many recipients. For more information regarding
  4.5.3 Google's sending limits, go to
  4.5.3  https://support.google.com/mail/?p=TooManyRecipientsError 5a478bee46e88-30f0bbd2362sm49597158eec.20 - gsmtp


Thanks for the suggestion; point noted.

-- 
-Mukesh Ojha
