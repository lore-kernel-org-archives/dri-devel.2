Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF25606A334
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=vAWBsD/e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CDA10EA56;
	Thu, 19 Nov 2026 16:30:00 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299AE10EA56
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:29:54 +0000 (UTC)
Message-ID: <8652ae36-7506-4fc2-b8ff-0b05a61dec63@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795105792;
 bh=McqmrGGoBsWtFO9rSLDSWUOXL2yC9fScta0oWrJ5HFE=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=vAWBsD/ePEqL301DdsswEq/IJ55Q9aS6ABXHAzDCh/3C+pvw0XpvcS29dDjLwcplb
 hd+k7v1hm1gr9jRkQZ++5bJzAtYbEpgtsEhf/4A2PhL0xMr3fnz9iT7fogwUm0eIvh
 cD2c1SFpljoYu0Acms8xnIjDxltOhLszWv3MK2j8=
Date: Thu, 19 Nov 2026 17:29:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH 04/10] phy: amlogic: Add Meson HDMI TX PHY driver
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-4-9e0ac931381c@aliel.fr>
 <sashiko-outbox-219538@kernel.org>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219538@kernel.org>
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

On 11/17/26 20:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] phy: amlogic: broken rate and submode check in
>   meson_hdmi_phy_validate()
> --
> 
> commit 0bf49ea77c864cdcf7af96e59e1ffba5194d9636
> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> phy: amlogic: Add Meson HDMI TX PHY driver
> 
> This commit adds a generic PHY driver for the HDMI TX PHY on Amlogic GXBB,
> GXL, GXM, and G12A SoCs, along with a legacy helper for device trees
> lacking a "phys" property.
> 
>> diff --git a/drivers/phy/amlogic/phy-meson-hdmi-tx.c b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
>> new file mode 100644
>> index 0000000000000..69833a080dc35
>> --- /dev/null
>> +++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
> [ ... ]
>> +/* GXBB */
>> +static const struct meson_hdmi_phy_rate gxbb_rates[] = {
>> +	/* 5.94Gbps, 3.7125Gbps */
>> +	{ 371250000, 0x33353245, 0x2100115b },
>> +	/* 2.97Gbps */
>> +	{ 297000000, 0x33634283, 0xb000115b },
>> +	/* 1.485Gbps, and below */
>> +	{ 0,         0x33632122, 0x2000115b },
>> +};
> [ ... ]
>> +static const struct meson_hdmi_phy_rate *
>> +meson_hdmi_phy_find_rate(const struct meson_hdmi_phy_data *data, u64 rate)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < data->num_rates; i++)
>> +		if (rate >= data->rates[i].min_rate)
>> +			return &data->rates[i];
>> +
>> +	return NULL;
>> +}
> [ ... ]
>> +static int meson_hdmi_phy_validate(struct phy *phy, enum phy_mode mode,
>> +				   int submode, union phy_configure_opts *opts)
>> +{
>> +	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
>> +
>> +	if (mode != PHY_MODE_HDMI)
>> +		return -EINVAL;
>> +
>> +	if (opts->hdmi.bpc != 8)
>> +		return -EINVAL;
>> +
>> +	if (!meson_hdmi_phy_find_rate(priv->data, opts->hdmi.tmds_char_rate))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Can meson_hdmi_phy_find_rate() ever return NULL here?
> 
> Every per-SoC rate table ends with an entry where min_rate is 0, and rate
> is an unsigned u64, so rate >= data->rates[i].min_rate is always true on
> the final entry.  That makes the NULL return and the callers' NULL checks
> in meson_hdmi_phy_validate() and meson_hdmi_phy_configure() dead code, and
> meson_hdmi_phy_validate() accepts any tmds_char_rate value (including 0 Hz
> or rates above the 594 MHz hardware limit).
> 
> In addition, meson_hdmi_phy_validate() does not check that submode is
> PHY_HDMI_MODE_TMDS before reading opts->hdmi.tmds_char_rate, which shares
> an anonymous union with opts->hdmi.frl when submode is PHY_HDMI_MODE_FRL.
> 

I will add min_rate 25175000 in table end and a check on max_rate 600MHz
in v2.

-- 
Best regards,
Ronald
