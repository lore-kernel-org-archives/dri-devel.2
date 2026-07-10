Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91647C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 17:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE19610E216;
	Fri, 10 Jul 2026 17:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LmfKMIhN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBD110E216
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:46:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E46743E26
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD41F0155E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783705561;
 bh=KvBYP+wl2IjCxMaSVmX25pjv+NEzDq5zeL7bHnenBoI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=LmfKMIhNNv8C44AEXf9A5oXKyj1wnekLNBpv0FC5tLO9CpVpSuE1tgvMo/TO/hXai
 PquOZ80oyklvhr1I+E1hL77bf4ojmyAQDZA11YRNl3GNTyOiJLKkfLD6zaIiL9al4W
 XARyciEe7S/6wvwE2dJNpLwkmlCUoNZLHo5ojOd5jVcEUwISzK8AdKpHtg7hTyn6OL
 /kDfFhxTVyW3lxSrrbU587UsqVVxMNGAflXZBDUmf70fca88msuudj54MpnWX3wygC
 wNg7SMGtoz/l85PSE9odvcmp5yDWdN56rAi2EuHOJXi1VWkZoc7F8BKQAG1EO/7KuU
 LQA4zNm9cHesg==
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b015b2d792so1312172e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:46:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5l3XN69LlZIpyHm62q/ZK90Akik3Ekx099Utgc3f51QeYDoPhzWUUfIaTmbos9mqr9YspS3iUs54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ2K5PlLUZrzMJfZika75Bxif5mXHHZI6TxZdeI4vMxLORja2b
 Nd/3IkWyV6FTFf2lBD+OsPVuS4g3yqwsTjeJl+oMHnISfuVoSK9JCHWyuI9aLfgyASMB2gxBVlY
 sjewfiGvfjzs3uoCAWdlj6nN+JAZbq+A=
X-Received: by 2002:a05:6512:688f:10b0:5b0:12d6:4c05 with SMTP id
 2adb3069b0e04-5b02369c6e8mr17375e87.36.1783705559836; Fri, 10 Jul 2026
 10:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-11-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260703193855.110619-11-mukesh.ojha@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 19:45:47 +0200
X-Gmail-Original-Message-ID: <CAD++jLnUf6j8jPJogpuo4w55EHqgt7LChOQX5JY5h4n2VOf5nQ@mail.gmail.com>
X-Gm-Features: AUfX_mz2mAY-nRqzEwN08-F9a7Mq7XiQwd_nI9Ppbf1sw-soYPlPLluIapY3fR0
Message-ID: <CAD++jLnUf6j8jPJogpuo4w55EHqgt7LChOQX5JY5h4n2VOf5nQ@mail.gmail.com>
Subject: Re: [PATCH 10/42] drm: pl111: Use devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Alexey Brodkin <abrodkin@synopsys.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Eddie James <eajames@linux.ibm.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
 Houlong Wei <houlong.wei@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joseph Liu <kwliu@nuvoton.com>, 
 Marvin Lin <kflin@nuvoton.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Srinivas Kandagatla <srini@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ge Gordon <gordon.ge@bst.ai>, 
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
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
 linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com, 
 linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 3, 2026 at 9:43=E2=80=AFPM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:

> Switch to devm_of_reserved_mem_device_init() so the reserved memory
> region is released automatically on probe failure or device removal.
> Remove the explicit of_reserved_mem_device_release() calls in the
> dev_put error path and pl111_amba_remove().
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Looks good to me:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
