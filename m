Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38D606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=SkcOpWzM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C8810ECD1;
	Mon, 23 Nov 2026 11:27:29 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A6B10ECD1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:27:23 +0000 (UTC)
Message-ID: <e782f0e1-18d2-4772-b04b-61a35eae7a7e@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795433241;
 bh=DTMDp6j55x9LK3mtG0j2x1ChCBgW5h+Qm9y64YKtGGY=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=SkcOpWzM9F+nFBgEs90cNbVOSjOzBKhViwU9loGM7ID2CWoNMCJYxWumby4A0uIhm
 udronjmxzPgDL6+dDc16wzv41g+VqjNMVB3V7sezj4tsTjL6rOPgartbl0hxBt+UiD
 JFd+Me2B5CEAn0XbQd4Pn0QE2Kq+e1VJfjs7c4js=
Date: Mon, 23 Nov 2026 12:27:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v3 04/11] phy: amlogic: Add Meson HDMI TX PHY driver
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
 <20261121-meson-drm-create-hdmitx-phy-v3-4-f8f471788076@aliel.fr>
 <sashiko-outbox-227322@kernel.org>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-227322@kernel.org>
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

On 11/21/26 20:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] phy: amlogic: phy-meson-hdmi-tx: min_rate 25175000 rejects
>   valid DMT modes
> --
> 
> commit c8d7adccab22985446c5dd65967a17a727629973
> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> phy: amlogic: Add Meson HDMI TX PHY driver
> 
> This commit adds a generic PHY driver for the Amlogic Meson HDMI TX PHY on
> GXBB, GXL, GXM, and G12A SoCs, along with a legacy creation helper for
> device trees without a phys property.
> 
>> diff --git a/drivers/phy/amlogic/phy-meson-hdmi-tx.c b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
>> new file mode 100644
>> index 0000000000000..872d244de8fb7
>> --- /dev/null
>> +++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
> [ ... ]
>> +/* GXBB */
>> +static const struct meson_hdmi_phy_rate gxbb_rates[] = {
>> +	/* 5.94Gbps, 3.7125Gbps */
>> +	{ 371250000, 0x33353245, 0x2100115b },
>> +	/* 2.97Gbps */
>> +	{ 297000000, 0x33634283, 0xb000115b },
>> +	/* 1.485Gbps, down to 251.75Mbps */
>> +	{ 25175000,  0x33632122, 0x2000115b },
>> +};
>> +
>> +/* GXL / GXM */
>> +static const struct meson_hdmi_phy_rate gxl_rates[] = {
>> +	/* 5.94Gbps, 3.7125Gbps */
>> +	{ 371250000, 0x333d3282, 0x2136315b },
>> +	/* 2.97Gbps */
>> +	{ 297000000, 0x33303382, 0x2036315b },
>> +	/* 1.485Gbps */
>> +	{ 148500000, 0x33303362, 0x2016315b },
>> +	/* 742.5Mbps, down to 251.75Mbps */
>> +	{ 25175000,  0x33604142, 0x0016315b },
>> +};
>> +
>> +/* G12A */
>> +static const struct meson_hdmi_phy_rate g12a_rates[] = {
>> +	/* 5.94Gbps, 3.7125Gbps */
>> +	{ 371250000, 0x37eb65c4, 0x2ab0ff3b, 0x0000080b },
>> +	/* 2.97Gbps */
>> +	{ 297000000, 0x33eb6262, 0x2ab0ff3b, 0x00000003 },
>> +	/* 1.485Gbps, down to 251.75Mbps */
>> +	{ 25175000,  0x33eb4242, 0x2ab0ff3b, 0x00000003 },
>> +};
> [ ... ]
>> +static const struct meson_hdmi_phy_rate *
>> +meson_hdmi_phy_find_rate(const struct meson_hdmi_phy_data *data, u64 rate)
>> +{
>> +	unsigned int i;
>> +
>> +	if (rate > data->max_rate)
>> +		return NULL;
>> +
>> +	for (i = 0; i < data->num_rates; i++)
>> +		if (rate >= data->rates[i].min_rate)
>> +			return &data->rates[i];
>> +
>> +	return NULL;
>> +}
> 
> [Severity: Medium]
> Does setting min_rate to 25175000 in the lowest entries of gxbb_rates[],
> gxl_rates[], and g12a_rates[] cause a regression for valid display modes
> below 25.175 MHz?
> 
> In drivers/gpu/drm/meson/meson_dw_hdmi.c, meson_hdmi_phy_setup_mode() used
> an unconditional else branch with no lower frequency bound for the lowest
> band ("742.5Mbps, and below" on GXL/GXM, and "1.485Gbps, and below" on GXBB
> and G12A).  Meanwhile, meson_encoder_hdmi_mode_valid() accepts non-VIC DMT
> modes down to 15.9 MHz via meson_vclk_dmt_supported_freq() without calling
> phy_validate().  Any mode between 15.9 MHz and 25.174 MHz (such as
> 640x480@60Hz CVT reduced-blanking at 23.75 MHz, or a 640x480 EDID detailed
> timing descriptor whose 10 kHz step encodes 25.175 MHz as 25170 kHz) passes
> mode validation and atomic_check, then fails with -EINVAL in
> dw_hdmi_phy_init() -> phy_configure() during atomic_enable, aborting HDMI
> PHY power-on.
> 

I've tested 15.9 MHz ok on a small screen with EDID. I will change the
minimal value accordingly.

-- 
Best regards,
Ronald
