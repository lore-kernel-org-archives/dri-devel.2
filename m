Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YR74AgYj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C89010F5A4;
	Tue, 24 Nov 2026 13:26:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CC110F59F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:26:36 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8D26BE1;
 Tue, 24 Nov 2026 14:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795526642;
 bh=4zgO1tsCPv3lTeuSWUIVUU7l4/jy9kzv20xBvyFs6r0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YR74AgYjMd1qAx00VNjbkbNEH4b/WnMEZB9a5PJTYuY6274GXdaC7cE7lx3RF5wEH
 T4CDz1GRPobahmbyEqQ6/hL1jofFkES+NcDdXWiEWWAv8ONKjl9E0XQjDiZoY63cRX
 8nSfyfE85KNClBI7nxhu95FP3sbMM3/1qC59JBkM=
Message-ID: <df69d165-3750-4b64-b458-a2be7a3ca0e1@ideasonboard.com>
Date: Tue, 24 Nov 2026 15:26:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Power on/off the PHY in
 probe/remove
To: Benjamin Robin <benjamin.robin@bootlin.com>,
 Abhash Kumar Jha <a-kumar2@ti.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, s-jain1@ti.com, y-d@ti.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 devarsht@ti.com, u-kumar1@ti.com, sjakhade@cadence.com
References: <20261124101747.2432344-1-a-kumar2@ti.com>
 <0a42d03c-f6cb-4d61-be9d-53b89b29753d@ideasonboard.com>
 <GrHOVCfQTneYbXFLczyyAA@bootlin.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <GrHOVCfQTneYbXFLczyyAA@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 24/11/2026 15:00, Benjamin Robin wrote:
> On Tuesday, November 24, 2026 at 1:53 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 24/11/2026 12:17, Abhash Kumar Jha wrote:
>>> The driver currently calls phy_init()/phy_exit() but never
>>> phy_power_on()/phy_power_off().
>>>
>>> Follow the PHY API guide's recommendation to call phy_power_on and
>>> phy_power_off along with phy_init and phy_exit respectively to be
>>> compatible with different PHYs.
>>>
>>> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
>>> ---
>>>    drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> index f47717bd10798..86e850a4752dc 100644
>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>> @@ -2369,6 +2369,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>>>    		goto plat_fini;
>>>    	}
>>>    
>>> +	ret = phy_power_on(mhdp->phy);
>>> +	if (ret < 0) {
>>> +		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
>>> +		goto phy_exit;
>>> +	}
>>> +
>>>    	/* Initialize the work for modeset in case of link train failure */
>>>    	INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
>>>    	INIT_WORK(&mhdp->hpd_work, cdns_mhdp_hpd_work);
>>> @@ -2378,7 +2384,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>>>    
>>>    	ret = cdns_mhdp_load_firmware(mhdp);
>>>    	if (ret)
>>> -		goto phy_exit;
>>> +		goto power_off;
>>>    
>>>    	if (mhdp->hdcp_supported)
>>>    		cdns_mhdp_hdcp_init(mhdp);
>>> @@ -2387,6 +2393,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>>>    
>>>    	return 0;
>>>    
>>> +power_off:
>>> +	phy_power_off(mhdp->phy);
>>>    phy_exit:
>>>    	phy_exit(mhdp->phy);
>>>    plat_fini:
>>> @@ -2424,6 +2432,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
>>>    				ERR_PTR(ret));
>>>    	}
>>>    
>>> +	phy_power_off(mhdp->phy);
>>>    	phy_exit(mhdp->phy);
>>>    
>>>    	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
>>
>> I think this one is fine, so:
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>
>> However, I fear there's something wrong with the torrent driver itself.
>> I didn't study it carefully, but looks like it supports bootloader
>> enabled PHY, and it then sets 'already_configured' field. When that's
>> set, all these calls, and dp_configuration() are ignored. And that field
>> is only cleared on system suspend hook. So it looks quite broken, if the
>> PHY is enabled when the torrent driver probes, the DP driver can't
>> configure it at all. Blanking the display or even unloading/loading the
>> DP driver does not affect it.
> 
> Hello Abhash,

It wasn't Abhash.

> I am currently rewriting the torrent driver in order to fix various issues.
> But I am not sure to fully understand what you mean by
> 
>> if the PHY is enabled when the torrent driver probes
> 
> This is not possible. The DP PHY is only available at the end of the probe
> of the torrent PHY. So maybe I am missing something, could you clarify by
> what you mean by that. But yes this flag 'already_configured' is quite
> dangerous since it assume that all the registers are properly configured
> by the bootloader.

I meant that if the DP PHY hardware is enabled (so was enabled by the 
bootloader) when the torrent driver probes, 'already_configured' will be 
set by the driver, and then when the MHDP driver later probes, MHDP 
driver won't be able to configure the PHY at all.

But all I did was a quick read, feel free to correct me =).

  Tomi

