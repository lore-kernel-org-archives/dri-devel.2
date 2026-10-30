Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AB606A323
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POEHrrX+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B2910E8AA;
	Fri, 30 Oct 2026 11:44:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D89010E8AA;
 Fri, 30 Oct 2026 11:44:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC548608FB;
 Fri, 30 Oct 2026 11:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4AD1F0093A;
 Fri, 30 Oct 2026 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793360671;
 bh=u22L97/jeI13IB20ysbQZcY423yThcHnEYQlKHEzxLc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=POEHrrX+sPBo41n1mG2oZ7jZsPptJNOYuklpaJCho15lUx/hky0vAto0IGN9wUGU6
 ND1CBDe5rZnFil1HZM1tjiLOFUAleLd3OoRXz2gYSIc3S0vbxzEcjwCfDh4zVMpSsf
 EQlNPouP+PVpC+k2CwhIb/KtciGpEkUOTO8XdOVMGJFbCRhD4vWJqa17k4GdbY1Vlc
 +22QWJSEiJS+ic6dfb3qVSAJmBMrYs3nndjOrrxn5UsvH0+zvXfwafKrObb+dlFg75
 QjOl3vEY9Q5kPpMymCryWXA4Z8a6csZvMkbqWCkAqIOAa8OUIZNXAetDK6xKKo0Mfo
 yZ+wl5iCt+jdg==
Date: Fri, 30 Oct 2026 12:44:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, Frank Li <Frank.Li@nxp.com>,
 Vinod Koul <vkoul@kernel.org>, 
 Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Eric Anholt <eric@anholt.net>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Peng Fan <peng.fan@nxp.com>, Aakarsh Jain <aakarsh.jain@samsung.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 freedreno@lists.freedesktop.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <20261030-musical-modest-butterfly-e7734f@quoll>
References: <20261028120216.2657397-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

I just git grepped kernel sources and weirdly no one made a typo in
"clocks" of forgetting the second letter. We became way too polite :).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

