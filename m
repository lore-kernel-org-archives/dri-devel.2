Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DBAC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21C710E48D;
	Mon, 27 Jul 2026 16:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MtktxJSD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B77F610E48D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785169022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QW8PobFLl9VuSJ+iyJKGdmgP3JvFIctsAQhl5gtsCFo=;
 b=MtktxJSDWSwFH61moeuZyZHDsHqxY7cgULDF0MTJCWmwmF+KDAzh9M76Mt5aiMWgqAJ4fM
 vZFsO0KsFfbxPW+aoUQZpUEyy+OunTaDUSsJVLq4BGbZFHqM4NxfyH0CV8dGavaqiEjtQM
 IsPuGnTDfUgAhCcpI4eadS3rBwjk5uY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-FEaTV4T5P266mC6vPnPBmA-1; Mon, 27 Jul 2026 12:17:01 -0400
X-MC-Unique: FEaTV4T5P266mC6vPnPBmA-1
X-Mimecast-MFC-AGG-ID: FEaTV4T5P266mC6vPnPBmA_1785169021
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec91dc265so255921385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169021; x=1785773821;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QW8PobFLl9VuSJ+iyJKGdmgP3JvFIctsAQhl5gtsCFo=;
 b=ZCyzUtLS/H+0Wd1zsMBmqCmAMNVUOT+fIv4uvecgkf6WK3PaNEvIsxa/qrWjWOCIm3
 Eia8cEw62p+6QHx/PRR/EK9UEjOy00F+TQXZWh9f3s78SeOw+GJUof8eJyVFRn9JvY+y
 yv1Y6xvrbv+GV7fGSu/fBRzGLktp9zv5ATIZl6Ibaex5bysm6EyjmPnknfdaVemQ1uZD
 AyUU6j2krIP6pEF+9/4KsDDdWGfywYGJO6cmup+TgeHZzNfTtbRaTx9ecEts/RgOE4Hb
 FEd/inVK+r5qt/Zgqj6Awm2cn/RcxJIwk+oDgChNNv0b3DfoBNjfnHwDs4yom93jVy0L
 am9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP1n1tjMRRFj4U9zyA7QLhyoeFq66qG5MZqqZJ2oGFdRziok5V5VI4Kfd3Jwg2aJukRDkg2Y62LE0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxult6BVJyG+cYyPxvBQwwjgOafyUCZjwnKFsKQZtGTrqkagdw+
 CWmi6Z8/g0dL1QYVrVBw3/6sZxFAV52pUY97Lziqx/EwUeHfOiJKeCjqukgj7eQ6GFNMb7t7UYE
 3IJ34uSwv3AQFnnnaeisLZh8tUD30xTzAcx4dZH1KXczNYGSFen4RhmXrMBOhAkP4AMKLlw==
X-Gm-Gg: AR+sD13YRtE32Q/ssH0g85CH9uk4Jfd8FNO56l43GOXE1V29iU9cdQuReFA0pNnZFVU
 jLAW9XMyweBb3xNK0hQoiwWay4KrOem5Wwqh0RAcFuwLKLgRlQcDRLk60UwlQKmVbqwgm0Nyl7m
 U0t12LyTaz+OtT43Ky+t5JfU4eQNgpifyPESMEzOMdF+UD4ieDxCsGPyG7hS5qw87kh8vvKN7+M
 gmzgn12v4foxIAqD6dAShHjtxD3w+APzKLl8MFu1qeGPdJmWM1rFVnqQRDuZWBA1uMupFPSEQ7p
 gd6A7QbEK0qyd6NTsnFlsWhglWc8WNMCVEft70xEiR/jdOk0SYIdAkPd3BFTIAzXqMa3aPgzJPX
 CKUB2fFI2V6//tFFCXywBTrYAI5VpSHCH9q8=
X-Received: by 2002:a05:620a:2691:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-932df627547mr956642985a.5.1785169020661; 
 Mon, 27 Jul 2026 09:17:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2691:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-932df627547mr956637785a.5.1785169020166; 
 Mon, 27 Jul 2026 09:17:00 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de6724a4sm641575585a.43.2026.07.27.09.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:16:58 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:16:55 -0400
From: Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 YoungJoon Lee <getfeus@gmail.com>
Subject: Re: [PATCH v3 2/5] clk: mediatek: Add mt8173-mfgtop driver
Message-ID: <ameEd76Flq7_eUMy@redhat.com>
References: <20260727091555.1023910-1-wenst@chromium.org>
 <20260727091555.1023910-3-wenst@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20260727091555.1023910-3-wenst@chromium.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I0arhJuwf03MvXbIZ_UfxzLKhDKdV9Nl-iNMFYsx4EE_1785169021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Chen-Yu,

On Mon, Jul 27, 2026 at 05:15:51PM +0800, Chen-Yu Tsai wrote:
> The MFG (GPU) block on the MT8173 has a small glue layer, named MFG_TOP
> in the datasheet, that contains clock gates, some power sequence signal
> delays, and other unknown registers that get toggled when the GPU is
> powered on.
> 
> The clock gates are exposed as clocks provided by a clock controller,
> while the power sequencing bits are exposed as one singular power domain.
> 
> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
>   - Needed since the driver implements PM domains using the generic PM
>     domain library, which also depends on PM
>   - Fixes build breakage (kernel test robot)
> - Fixed "RST_DELAY_CNT" name (Brian)
> - Dropped unused mfg_desc (Brian)
> - Added check of clk_prepare_enable()'s return value in
>   clk_mt8173_mfgtop_power_on() (Brian)
> - Saved error value for return in IS_ERR(data->clk_26m) branch
>   (Dan Carpenter / kernel test robot w/ smatch)
> ---

[snip]

> +static int clk_mt8173_mfgtop_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct mt8173_mfgtop_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->clk_data = mtk_devm_alloc_clk_data(dev, ARRAY_SIZE(mfg_clks));
> +	if (!data->clk_data)
> +		return -ENOMEM;
> +
> +	/* MTK clock gates also uses regmap */
> +	data->regmap = device_node_to_regmap(node);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "Failed to get regmap\n");
> +
> +	data->child_pd.np = node;
> +	data->child_pd.args_count = 0;
> +	ret = of_parse_phandle_with_args(node, "power-domains", "#power-domain-cells", 0,
> +					 &data->parent_pd);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to parse power domain\n");
> +
> +	devm_pm_runtime_enable(dev);
> +	/*
> +	 * Do a pm_runtime_resume_and_get() to workaround a possible
> +	 * deadlock between clk_register() and the genpd framework.
> +	 */
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to runtime resume device\n");
> +		goto put_of_node;
> +	}
> +
> +	ret = mtk_clk_register_gates(dev, node, mfg_clks, ARRAY_SIZE(mfg_clks),
> +				     data->clk_data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register clock gates\n");
> +		goto put_pm_runtime;
> +	}
> +
> +	data->clk_26m = clk_hw_get_clk(data->clk_data->hws[CLK_MFG_26M], "26m");
> +	if (IS_ERR(data->clk_26m)) {
> +		ret = dev_err_probe(dev, PTR_ERR(data->clk_26m), "Failed to get 26 MHz clock\n");
> +		goto unregister_clks;
> +	}
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data->clk_data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add clk OF provider\n");
> +		goto put_26m_clk;
> +	}
> +
> +	data->genpd.name = "mfg-top";
> +	data->genpd.power_on = clk_mt8173_mfgtop_power_on;
> +	data->genpd.power_off = clk_mt8173_mfgtop_power_off;
> +	ret = pm_genpd_init(&data->genpd, NULL, true);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add power domain\n");
> +		goto del_clk_provider;
> +	}
> +
> +	ret = of_genpd_add_provider_simple(node, &data->genpd);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add power domain OF provider\n");
> +		goto remove_pd;
> +	}
> +
> +	ret = of_genpd_add_subdomain(&data->parent_pd, &data->child_pd);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to link PM domains\n");
> +		goto del_pd_provider;
> +	}
> +
> +	pm_runtime_put(dev);
> +	return 0;
> +
> +del_pd_provider:
> +	of_genpd_del_provider(node);
> +remove_pd:
> +	pm_genpd_remove(&data->genpd);
> +del_clk_provider:
> +	of_clk_del_provider(node);
> +put_26m_clk:
> +	clk_put(data->clk_26m);
> +unregister_clks:
> +	mtk_clk_unregister_gates(mfg_clks, ARRAY_SIZE(mfg_clks), data->clk_data);
> +put_pm_runtime:
> +	pm_runtime_put(dev);
> +put_of_node:
> +	of_node_put(data->parent_pd.np);
> +	return ret;
> +}
> +
> +static void clk_mt8173_mfgtop_remove(struct platform_device *pdev)
> +{
> +	struct mt8173_mfgtop_data *data = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	of_genpd_remove_subdomain(&data->parent_pd, &data->child_pd);
> +	of_genpd_del_provider(node);
> +	pm_genpd_remove(&data->genpd);
> +	of_clk_del_provider(node);
> +	clk_put(data->clk_26m);
> +	mtk_clk_unregister_gates(mfg_clks, ARRAY_SIZE(mfg_clks), data->clk_data);

Looking at the error labels in the probe, does the remove also need:

    of_node_put(data->parent_pd.np);

Otherwise this looks good. With that fixed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

