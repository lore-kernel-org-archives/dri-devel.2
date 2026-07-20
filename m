Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9ACC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6E910E163;
	Mon, 20 Jul 2026 09:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HFfHYf18";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BEA10E14C;
 Mon, 20 Jul 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784538934; x=1816074934;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HdRh+ymOJ0ac4vm8ZMK/iaHoBQMnrskWK1UlTljR5X4=;
 b=HFfHYf18orM7AygbhXRF1neZ/bFrmzjbcDjtqmGcOnU57N+F9GuhSxvk
 AgUChgtgQWkvMak9Ug62usUEFWgm2RPr0v3Fn7G4CRnZopzUiR2zQbOsU
 6sjjfHrfDwSfmQKsfHcsi9uV45Ef50MydAplpho+lhtX3jUtkOsoG7xgs
 KVCzcV9PIEczw4n73Fyrqpa94qzer54iGH4ZQ1ZgT8RMlScExW/T0EQaX
 ggBe6si5jtR+Kxam9XbB+yi6BkbRznw8Rj2jbUtCq4RCmPUgAhD+kPfT9
 wGdjF7ToviMBQmGNmPH72Bb61QyNOFBD1GZq/8bRPO9S/BQSRi6Ep328u Q==;
X-CSE-ConnectionGUID: 9WLTFHmGQBuPYB5mN2zfZw==
X-CSE-MsgGUID: RnKpT7QgTE2CCoE13kU67Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84969805"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="84969805"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:15:33 -0700
X-CSE-ConnectionGUID: 0AIwnnlTQpi59DN88CWYXg==
X-CSE-MsgGUID: Nq0Frpv2S8OS2iZmwbtEVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="256831076"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.165])
 ([10.245.244.165])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:15:31 -0700
Message-ID: <4fd8cf87-3c70-4a8f-afbd-8c1a67122ab7@linux.intel.com>
Date: Mon, 20 Jul 2026 11:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/dp_tunnel: Add UHBR tunneling support
To: imre.deak@intel.com, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20260714152700.555527-1-imre.deak@intel.com>
 <20260714152700.555527-2-imre.deak@intel.com>
 <alnvFb5cupP9YmgL@ideak-desk.lan>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <alnvFb5cupP9YmgL@ideak-desk.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On 7/17/26 11:00, Imre Deak wrote:
> Hi Thomas, Maarten, Maxime,
> 
> could you please ack merging this patch via the Intel trees? It adds the
> DP tunnel register definitions for UHBR link rates and reading/parsing
> them, which are then used later in this patchset by the Intel driver.
> 
> Thanks,
> Imre
> 
> On Tue, Jul 14, 2026 at 06:26:55PM +0300, Imre Deak wrote:
>> Add the DPCD registers and detection required to support UHBR link rates
>> over Thunderbolt tunnels.
>>
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Imre Deak <imre.deak@intel.com>
>> ---
>>  drivers/gpu/drm/display/drm_dp_tunnel.c | 116 +++++++++++++++++++++++-
>>  include/drm/display/drm_dp.h            |  12 +++
>>  include/drm/display/drm_dp_tunnel.h     |  21 +++++
>>  3 files changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
>> index 76c6bc84a806f..d29ad4116e641 100644
>> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
>> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
>> @@ -111,6 +111,8 @@
>>  	DPTUN_REG(DP_ALLOCATED_BW) | \
>>  	DPTUN_REG(DP_TUNNELING_MAX_LINK_RATE) | \
>>  	DPTUN_REG(DP_TUNNELING_MAX_LANE_COUNT) | \
>> +	DPTUN_REG(DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) | \
>> +	DPTUN_REG(DP_TUNNELING_128B132B_LINK_RATE) | \
>>  	DPTUN_REG(DP_DPTX_BW_ALLOCATION_MODE_CONTROL))
>>  
>>  static const DECLARE_BITMAP(dptun_info_regs, 64) = {
>> @@ -140,11 +142,14 @@ struct drm_dp_tunnel {
>>  	int estimated_bw;
>>  	int allocated_bw;
>>  
>> +	u8 dprx_128b132b_rates;
>>  	int max_dprx_rate;
>>  	u8 max_dprx_lane_count;
>>  
>>  	u8 adapter_id;
>>  
>> +	bool dprx_128b132b_support:1;
>> +	bool dprx_128b132b_lane0_mapping_support:1;
>>  	bool bw_alloc_supported:1;
>>  	bool bw_alloc_enabled:1;
>>  	bool has_io_error:1;
>> @@ -260,9 +265,46 @@ static int tunnel_reg_bw_granularity(const struct drm_dp_tunnel_regs *regs)
>>  	return (250000 << gr) / 8;
>>  }
>>  
>> +static bool tunnel_reg_dprx_128b132b_support(const struct drm_dp_tunnel_regs *regs)
>> +{
>> +	return tunnel_reg(regs, DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) & DP_128B132B_DP_SUPPORTED;
>> +}
>> +
>> +static bool tunnel_reg_dprx_128b132b_lane0_mapping_support(const struct drm_dp_tunnel_regs *regs)
>> +{
>> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
>> +	       DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT;
>> +}
>> +
>> +static u8 tunnel_reg_dprx_128b132b_rates(const struct drm_dp_tunnel_regs *regs)
>> +{
>> +	if (!tunnel_reg_dprx_128b132b_support(regs))
>> +		return 0;
>> +
>> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
>> +	       DP_TUNNELING_128B132B_LINK_RATE_MASK;
>> +}
>> +
>> +static u8 max_128b132b_rate(u8 rates)
>> +{
>> +	if (rates & DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
>> +		return DP_TUNNELING_20GBPS_PER_LANE_SUPPORT;
>> +	else if (rates & DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT)
>> +		return DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT;
>> +	else if (rates & DP_TUNNELING_10GBPS_PER_LANE_SUPPORT)
>> +		return DP_TUNNELING_10GBPS_PER_LANE_SUPPORT;
>> +
>> +	WARN_ON(rates);
>> +
>> +	return 0;
>> +}
>> +
>>  static int tunnel_reg_max_dprx_rate(const struct drm_dp_tunnel_regs *regs)
>>  {
>> -	u8 bw_code = tunnel_reg(regs, DP_TUNNELING_MAX_LINK_RATE);
>> +	u8 bw_code = max_128b132b_rate(tunnel_reg_dprx_128b132b_rates(regs));
>> +
>> +	if (!bw_code)
>> +		bw_code = tunnel_reg(regs, DP_TUNNELING_MAX_LINK_RATE);
>>  
>>  	return drm_dp_bw_code_to_link_rate(bw_code);
>>  }
>> @@ -706,6 +748,23 @@ static bool update_dprx_caps(struct drm_dp_tunnel *tunnel, const struct drm_dp_t
>>  {
>>  	bool changed = false;
>>  
>> +	if (tunnel_reg_dprx_128b132b_support(regs) != tunnel->dprx_128b132b_support) {
>> +		tunnel->dprx_128b132b_support = tunnel_reg_dprx_128b132b_support(regs);
>> +		changed = true;
>> +	}
>> +
>> +	if (tunnel_reg_dprx_128b132b_lane0_mapping_support(regs) !=
>> +	    tunnel->dprx_128b132b_lane0_mapping_support) {
>> +		tunnel->dprx_128b132b_lane0_mapping_support =
>> +			tunnel_reg_dprx_128b132b_lane0_mapping_support(regs);
>> +		changed = true;
>> +	}
>> +
>> +	if (tunnel_reg_dprx_128b132b_rates(regs) != tunnel->dprx_128b132b_rates) {
>> +		tunnel->dprx_128b132b_rates = tunnel_reg_dprx_128b132b_rates(regs);
>> +		changed = true;
>> +	}
>> +
>>  	if (tunnel_reg_max_dprx_rate(regs) != tunnel->max_dprx_rate) {
>>  		tunnel->max_dprx_rate = tunnel_reg_max_dprx_rate(regs);
>>  		changed = true;
>> @@ -1331,6 +1390,61 @@ int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_aux *a
>>  }
>>  EXPORT_SYMBOL(drm_dp_tunnel_handle_irq);
>>  
>> +/**
>> + * drm_dp_tunnel_128b132b_supported - Query if 128b132b is supported by the tunnel's DPRX
>> + * @tunnel: Tunnel object
>> + *
>> + * The function is used to query if 128b132b is supported by the DPRX connected
>> + * to @tunnel.
>> + *
>> + * Returns %true if 128b132b is supported by the DPRX.
>> + */
>> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return tunnel->dprx_128b132b_support;
>> +}
>> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_supported);
>> +
>> +/**
>> + * drm_dp_tunnel_128b132b_lane0_mapping_supported - Check 128b/132b lane 0 mapping support
>> + * @tunnel: Tunnel object
>> + *
>> + * Check whether the DP-out adapter always maps lane 0 as expected by the
>> + * DPRX on a tunneled 128b/132b link. If the function returns %true, one- and
>> + * two-lane configurations with UHBR link rates can always be used. If it
>> + * returns %false, using one or two lanes with UHBR link rates may cause a
>> + * lane-count conversion failure in the DPRX, requiring corrective action by
>> + * the source during link training. See DP Standard v2.1b, section
>> + * 3.5.2.16.3, 128b/132b DPRX Lane Count Conversion Failure Indication and
>> + * Corrective Action.
>> + *
>> + * A four-lane configuration can always be used, provided that the DPRX
>> + * supports it, regardless of the function's return value.
>> + *
>> + * Returns %true if the DP-out adapter supports the 128b/132b lane 0 mapping.
>> + */
>> +bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return tunnel->dprx_128b132b_lane0_mapping_support;
>> +}
>> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_lane0_mapping_supported);
>> +
>> +/**
>> + * drm_dp_tunnel_128b132b_dprx_rates - Query the supported 128b132b rates of the tunnel's DPRX
>> + * @tunnel: Tunnel object
>> + *
>> + * The function is used to query the supported 128b132b rates of the DPRX connected
>> + * to @tunnel. Note that the related DP_128B132B_SUPPROTED_LINK_RATES DPCD
>> + * register will indicate no supported 128B132B rates for a tunneled DPRX.
>> + *
>> + * Returns the mask of supported 128b132b rates.
>> + */
>> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return tunnel->dprx_128b132b_rates;
>> +}
>> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_dprx_rates);
>> +
>>  /**
>>   * drm_dp_tunnel_max_dprx_rate - Query the maximum rate of the tunnel's DPRX
>>   * @tunnel: Tunnel object
>> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
>> index 7154216e0aff9..8b0ca36083dd1 100644
>> --- a/include/drm/display/drm_dp.h
>> +++ b/include/drm/display/drm_dp.h
>> @@ -1506,6 +1506,18 @@
>>  #define DP_TUNNELING_MAX_LANE_COUNT			0xe0029
>>  #define  DP_TUNNELING_MAX_LANE_COUNT_MASK		0x1f
>>  
>> +#define DP_TUNNELING_MAIN_LINK_CHANNEL_CODING		0xe002b
>> +#define  DP_128B132B_DP_SUPPORTED			(1 << 0)
>> +
>> +#define DP_TUNNELING_128B132B_LINK_RATE			0xe002c
>> +#define  DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT		(1 << 2)
>> +#define  DP_TUNNELING_20GBPS_PER_LANE_SUPPORT		(1 << 1)
>> +#define  DP_TUNNELING_10GBPS_PER_LANE_SUPPORT		(1 << 0)
>> +#define  DP_TUNNELING_128B132B_LINK_RATE_MASK		(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT | \
>> +							 DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT | \
>> +							 DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
>> +#define  DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT	(1 << 7)
>> +
>>  #define DP_DPTX_BW_ALLOCATION_MODE_CONTROL		0xe0030
>>  #define  DP_DISPLAY_DRIVER_BW_ALLOCATION_MODE_ENABLE	(1 << 7)
>>  #define  DP_UNMASK_BW_ALLOCATION_IRQ			(1 << 6)
>> diff --git a/include/drm/display/drm_dp_tunnel.h b/include/drm/display/drm_dp_tunnel.h
>> index 57f5e90ba8fda..b5e665560a47e 100644
>> --- a/include/drm/display/drm_dp_tunnel.h
>> +++ b/include/drm/display/drm_dp_tunnel.h
>> @@ -63,6 +63,9 @@ void drm_dp_tunnel_set_io_error(struct drm_dp_tunnel *tunnel);
>>  int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr,
>>  			     struct drm_dp_aux *aux);
>>  
>> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel);
>> +bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel);
>> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel);
>>  int drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel);
>>  int drm_dp_tunnel_max_dprx_lane_count(const struct drm_dp_tunnel *tunnel);
>>  int drm_dp_tunnel_available_bw(const struct drm_dp_tunnel *tunnel);
>> @@ -173,6 +176,24 @@ drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr,
>>  	return -EOPNOTSUPP;
>>  }
>>  
>> +static inline bool
>> +drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool
>> +drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline u8
>> +drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int
>>  drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel)
>>  {
>> -- 
>> 2.49.1
>>

