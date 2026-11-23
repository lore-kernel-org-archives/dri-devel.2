Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=ooeUU0hC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E864210E18C;
	Mon, 23 Nov 2026 11:34:27 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F4210E3A4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:34:21 +0000 (UTC)
Message-ID: <ceda6a5e-f314-441f-b596-21a60b48486b@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795433659;
 bh=DyzVVA4BHQY1L7A1w9MoxMVnpEeVU9iMkGr1NRy0wTM=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=ooeUU0hCpiBSpZnhoubWSJjGhz8XJVTlm1zKpLsrdNqn8bP4KrBVGhduHnCKW+ZFx
 chNU/CpFE7x4QPJnCUo1x32lhLS6yUx2buXH9T89JTGjvcH1lu4NFAOgMXzz6/i/CS
 Mra7PQ2bd3b2mcV22l/V8FGFOE5Kzk/LaAF5gIKo=
Date: Mon, 23 Nov 2026 12:34:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v3 08/11] drm/meson: dw-hdmi: Use the generic PHY
 framework for the HDMI TX PHY
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
 <20261121-meson-drm-create-hdmitx-phy-v3-8-f8f471788076@aliel.fr>
 <sashiko-outbox-227314@kernel.org>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-227314@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 20:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] drm/meson: dw-hdmi: invalid phy_destroy() in
>   meson_dw_hdmi_bind() error path
> - [Medium] drm/meson: dw-hdmi: stateless device link leaked in
>   meson_dw_hdmi_unbind()
> - [Medium] drm/meson: dw-hdmi: meson_venc_init() clobbers PHY CNTL0 on
>   system resume
> --
> 
> commit 60b745dc55898638b05c8fcafed9d3683b30dff0
> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY
> 
> This commit converts the Meson DW-HDMI glue driver to manage the HDMI TX
> PHY through the generic PHY framework, with a legacy fallback when the
> device tree lacks a "phys" property, and adds a stateless device link
> between the VPU master and HDMI-TX device.
> 
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index 20a821936b3af..8fdb997c28b40 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> 
> [ ... ]
> 
>> @@ -746,7 +663,26 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>  		return ret;
>>  	}
>>  
>> -	meson_dw_hdmi_init(meson_dw_hdmi);
>> +	meson_dw_hdmi->phy = devm_phy_optional_get(dev, NULL);
>> +	if (IS_ERR(meson_dw_hdmi->phy))
>> +		return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->phy),
>> +				     "failed to get HDMI PHY\n");
>> +
>> +	if (!meson_dw_hdmi->phy) {
>> +		/* DEPRECATED: DT without "phys" */
>> +		dev_warn(dev, "missing \"phys\", using legacy HDMI PHY\n");
>> +		meson_dw_hdmi->phy = meson_hdmi_phy_create_legacy(dev, priv->hhi,
>> +						meson_dw_hdmi->data->phy_soc);
>> +		if (IS_ERR(meson_dw_hdmi->phy))
>> +			return dev_err_probe(dev, PTR_ERR(meson_dw_hdmi->phy),
>> +					     "failed to create legacy HDMI PHY\n");
>> +
>> +		meson_dw_hdmi->legacy_phy = true;
>> +	}
>> +
>> +	ret = meson_dw_hdmi_init(meson_dw_hdmi);
>> +	if (ret)
>> +		return ret;
>>  
>>  	/* Bridge / Connector */
>>  
>> @@ -767,14 +703,26 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>  	platform_set_drvdata(pdev, meson_dw_hdmi);
>>  
>>  	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev, &meson_dw_hdmi->dw_plat_data);
>> -	if (IS_ERR(meson_dw_hdmi->hdmi))
>> -		return PTR_ERR(meson_dw_hdmi->hdmi);
>> +	if (IS_ERR(meson_dw_hdmi->hdmi)) {
>> +		ret = PTR_ERR(meson_dw_hdmi->hdmi);
>> +		goto err_hdmi_probe;
>> +	}
>>  
>>  	meson_dw_hdmi->bridge = of_drm_find_and_get_bridge(pdev->dev.of_node);
>>  
>> +	link = device_link_add(master, dev, DL_FLAG_STATELESS);
>> +	if (!link)
>> +		dev_warn(dev, "failed to link HDMI (supplier) to DRM master (consumer)\n");
>> +
>>  	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
>>  
>>  	return 0;
>> +
>> +err_hdmi_probe:
>> +	phy_exit(meson_dw_hdmi->phy);
>> +	phy_destroy(meson_dw_hdmi->phy);
>> +
>> +	return ret;
>>  }
> 
> [Severity: High]
> Does calling phy_destroy(meson_dw_hdmi->phy) in err_hdmi_probe cause a
> double free or destroy the external provider's PHY when dw_hdmi_probe()
> fails (for example with -EPROBE_DEFER)?
> 
> Both devm_phy_optional_get() and meson_hdmi_phy_create_legacy() (which
> uses devm_phy_create()) are devres-managed in the component devres group
> that component_bind() releases on bind failure.  When legacy_phy is
> false, meson_dw_hdmi is only a consumer, so phy_destroy() unregisters
> the external PHY provider's device while the provider remains bound.
> When legacy_phy is true, component_bind() immediately runs
> devm_phy_consume() -> phy_destroy() a second time on the already-freed
> phy.
> 
> Dropping phy_destroy() from err_hdmi_probe and leaving the cleanup to
> component_bind()'s devres release avoids both issues.
> 

I will drop it.

>>  
>>  static void meson_dw_hdmi_unbind(struct device *dev, struct device *master,
>> @@ -786,6 +734,10 @@ static void meson_dw_hdmi_unbind(struct device *dev, struct device *master,
>>  
>>  	devm_free_irq(dev, irq, meson_dw_hdmi);
>>  	dw_hdmi_unbind(meson_dw_hdmi->hdmi);
>> +
>> +	phy_exit(meson_dw_hdmi->phy);
>> +	if (meson_dw_hdmi->legacy_phy)
>> +		devm_phy_destroy(dev, meson_dw_hdmi->phy);
>>  	drm_bridge_put(meson_dw_hdmi->bridge);
>>  }
> 
> [Severity: Medium]
> Does meson_dw_hdmi_unbind() leak the DL_FLAG_STATELESS device link
> created in meson_dw_hdmi_bind()?  Stateless device links are not removed
> automatically by the driver core on unbind and require an explicit
> device_link_remove(master, dev) or device_link_del().
> 

I forgot it, thanks for the reminder, I will add the device_link_remove().

>> @@ -801,6 +753,8 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(struct device *dev)
>>  	if (!meson_dw_hdmi)
>>  		return 0;
>>  
>> +	phy_exit(meson_dw_hdmi->phy);
>> +
>>  	/* Reset TOP */
>>  	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
>>  				       HDMITX_TOP_SW_RESET, 0);
>> @@ -811,11 +765,14 @@ static int __maybe_unused meson_dw_hdmi_pm_suspend(struct device *dev)
>>  static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
>>  {
>>  	struct meson_dw_hdmi *meson_dw_hdmi = dev_get_drvdata(dev);
>> +	int ret;
>>  
>>  	if (!meson_dw_hdmi)
>>  		return 0;
>>  
>> -	meson_dw_hdmi_init(meson_dw_hdmi);
>> +	ret = meson_dw_hdmi_init(meson_dw_hdmi);
>> +	if (ret)
>> +		return ret;
>>  
>>  	dw_hdmi_resume(meson_dw_hdmi->hdmi);
> 
> [Severity: Medium]
> With the new device link ordering dev (supplier) to resume before master
> (consumer), will meson_drv_pm_resume() -> meson_venc_init() clobber
> HHI_HDMI_PHY_CNTL0 after meson_dw_hdmi_pm_resume() has initialized the
> PHY?
> 
> drivers/gpu/drm/meson/meson_venc.c:meson_venc_init() {
> 	...
> 	/* Disable HDMI PHY */
> 	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
> 	...
> }
> 
> meson_dw_hdmi_init() calls phy_init(), which programs HHI_HDMI_PHY_CNTL0
> to cntl0_init (0x000b4242 on G12A for the bandgap).  When the consumer
> meson_drv_pm_resume() runs next, meson_venc_init() overwrites
> HHI_HDMI_PHY_CNTL0 with 0, leaving the G12A bandgap disabled whenever no
> HDMI mode is active across suspend and resume.
> 

I will change the link order to the oposite, and use prepare/complete
for the drm_mode_config_helper suspend/resume.

-- 
Best regards,
Ronald
