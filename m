Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84F606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=e1U02Z80
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F8F10E909;
	Wed, 25 Nov 2026 16:02:53 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F25C10E909
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:02:47 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261125160245euoutp01643ec134cd0c29416f15b98b4c0d8cc6~rVTXAYGFq2394723947euoutp01V;
 Wed, 25 Nov 2026 16:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261125160245euoutp01643ec134cd0c29416f15b98b4c0d8cc6~rVTXAYGFq2394723947euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795622565;
 bh=ndbQ4zOYDp69YxH+vSmF4c25f0epkpIi0n8RI4ocFgM=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=e1U02Z80qtk/nwxit57Qm6MpSrKZqhLaXn1xXYc34Vn0Eip6382b1av0O6PBF68d/
 B+Dumn3anLrajMn3xyffUdgm+em8ubtrl2UA1YPq6TqsDRgnUrgdx/z+eBTbv/89Nr
 BFOGepG56xBXw0iJaV/CwLUtCghah3S95AlnkChA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261125160245eucas1p1beac30b8fac0db60d40e99f0990a67bf~rVTWtiIWT1277212772eucas1p1A;
 Wed, 25 Nov 2026 16:02:45 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261125160243eusmtip277776f891a27dfa466a595a92f06eb14~rVTVBDesA3197031970eusmtip2F;
 Wed, 25 Nov 2026 16:02:43 +0000 (GMT)
Message-ID: <f432f455-f393-49f6-94e1-48caf1e35565@samsung.com>
Date: Wed, 25 Nov 2026 17:02:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/18] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
To: Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Emil Renner
 Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Heiko
 Stuebner <heiko@sntech.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, Andy Yan
 <andyshrk@163.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Yakir Yang <kuankuan.y@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
 William Qiu <william.qiu@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>, Manivannan
 Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Byron Stanoszek <gandalf@winds.org>,
 Owen O'Hehir <oo.hehir@gmail.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <831aebd692fc5ddbbd1cf57f1aad3bcc0d3f30d2.camel@pengutronix.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261125160245eucas1p1beac30b8fac0db60d40e99f0990a67bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155429eucas1p1015c7cd9beec294fefdcd6900dd407f6
X-EPHeader: CA
X-CMS-RootMailID: 20261124155429eucas1p1015c7cd9beec294fefdcd6900dd407f6
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155429eucas1p1015c7cd9beec294fefdcd6900dd407f6@eucas1p1.samsung.com>
 <20261124-jh7110-clean-send-v8-16-de92635dd857@samsung.com>
 <831aebd692fc5ddbbd1cf57f1aad3bcc0d3f30d2.camel@pengutronix.de>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/26 17:50, Philipp Zabel wrote:
> On Di, 2026-11-24 at 16:52 +0100, Michal Wilczynski wrote:
>> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>>
> [...]
>>
>> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>> Tested-by: Byron Stanoszek <gandalf@winds.org>
>> Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig            |  11 ++
>>  drivers/gpu/drm/bridge/Makefile           |   1 +
>>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 297 ++++++++++++++++++++++++++++++
>>  3 files changed, 309 insertions(+)
>>
> [...]
>> diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a0283f83ddc93e3e6c9e9192b73dca9a63f9d9ab
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
>> @@ -0,0 +1,297 @@
> [...]
>> +
>> +struct stf_inno_hdmi_controller {
>> +	struct clk_bulk_data clks[CLK_CTRL_NUM];
>> +	struct reset_control *tx_rst;
> 
> tx_rst is never used outside of starfive_inno_hdmi_controller_probe(),
> it could be a local variable.

agree, thanks will fix in v9

> 
>> +	struct phy *phy;
>> +	bool enabled;
>> +};
>> +
> [...]
>> +static void stf_inno_hdmi_rst_assert(void *data)
>> +{
>> +	reset_control_assert(data);
>> +}
>> +
>> +static int starfive_inno_hdmi_controller_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	ctrl->tx_rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(ctrl->tx_rst))
>> +		return dev_err_probe(dev, PTR_ERR(ctrl->tx_rst), "failed to get tx reset\n");
>> +
> [...]
>> +
>> +	ret = reset_control_deassert(ctrl->tx_rst);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, stf_inno_hdmi_rst_assert,
>> +				       ctrl->tx_rst);
>> +	if (ret)
>> +		return ret;
> 
> This looks like it could be simplified with
> devm_reset_control_get_exclusive_deasserted().

Yes I think this can be simplified, thanks !

> 
> regards
> Philipp
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
