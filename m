Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A3C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D0A10F49F;
	Fri, 17 Jul 2026 09:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Svv5Q5V5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3C210F49F;
 Fri, 17 Jul 2026 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784278842; x=1815814842;
 h=date:from:to:cc:subject:message-id:reply-to:references:
 in-reply-to:mime-version;
 bh=myNxISk9McO9LH4cgMbgDP9j8f7knFgEaEAsz8cW+Bs=;
 b=Svv5Q5V5SIuwCeKN4O61dyY752det7bCG55lj8yvT8J9MpnRXa5f/ihh
 QdfMA9EvQ9YSODlp/wBPp8C2TMVjMIe99sJ3vgpBem8cBeuNi+7AL22vT
 er8eIkyab5ex2ZRvttvngE8mgmGypTubxXWiNXE1esg2WRnoY0rZt1hgB
 +1tBZGrypgGdhSFXshSMdFbLN2TrFozLjeC7OihBDVqQw1ZhJmZvYHupa
 P2Nd0RkwG23eiQvr4HyTDaP0KDIvat7LP+q2IXGAo6EG2taID89U7Apwe
 6UNdnoM+z0uaoIkuO45jUSO6tdw11TxSDwEVb+cckXM+pyISJbUfAXEk9 g==;
X-CSE-ConnectionGUID: CVN3JhwQTiyJDScn32FFvQ==
X-CSE-MsgGUID: HoWwsGx2TdOsrOXo6iOnzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="72482200"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="72482200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:00:42 -0700
X-CSE-ConnectionGUID: 87kYg0tNQmOiy9EZWTfvCA==
X-CSE-MsgGUID: /margtpTRRWeUhvbb3+QGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260555299"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:00:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:00:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 02:00:40 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaHRx6uPRNiu90/IjadVvFZ5f0RILJNEORaVsWExaTZ9eFTeaqmQXs63CnqPjrw9BaGcgOjzyov6iZtv7rVJEt3Hu8yvcam113pbfHqKitkJF+D3uJtPVTlK/w9A9NOYhi8nc8hrRYBPmlSgpTYuQtm3WLmmhuAvy+TuqpjP/CGRhb+RkD7IkXGlvBWH7IpbiFm7zbhnb7lGYVelELNREHoY1caF9c32Cwu5qT7KEfHVRRKScPwrvxm0sdL2TSBsU+l2wgkFt9kXajlvtSV7zh9ZDSGvBUGWv53lE2gS0S/kS2AXcVd8lAoZ4w4H/QSydGzx+B3Vq+iRRXBGY/jTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Mmdh2IqIolbANTZGAx0WIk9ZNaGXsBHCvnKkqKNRg=;
 b=vJkkwPGoeNNQEmoV6E9eQUN7IqlbUOL7XKe5sNwaL8EtHFdk1/TH6Hw+PHznY70XvbOJMKr2oiXFCW/m6x7J70sKXga2H2Pas9GPS509UKrk4sTo4Wp1wXVLT4I73CdRhbJ8/QEtU0H41AgZo2sFoKyZPOpuIkOqYot6pFxcIHlFWSyLKnrIPwgf5htR1i3xPLipUhgMP/BRxO2LxaYOP43Q73fqOGHgLpgHRS+NEoREuGTbnm06ZNZvTZTbQwHVLlNqFkqReb98340lBbn1IWLvjAXHOmVpaiC0oz7DkLXgg1C8M1kGX621onrd8mtLb8t1/uBw51vKrdTYZUrvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by CH3PR11MB8493.namprd11.prod.outlook.com (2603:10b6:610:1bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 17 Jul
 2026 09:00:36 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:00:30 +0000
Date: Fri, 17 Jul 2026 12:00:05 +0300
From: Imre Deak <imre.deak@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] drm/dp_tunnel: Add UHBR tunneling support
Message-ID: <alnvFb5cupP9YmgL@ideak-desk.lan>
References: <20260714152700.555527-1-imre.deak@intel.com>
 <20260714152700.555527-2-imre.deak@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714152700.555527-2-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GV3P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::11) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|CH3PR11MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7254a8-d038-4382-8370-08dee3e1da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: jegrDBxckWB8a7o34gKEH/Zd6DhJD64vf1Nspo5aqoTF63HcGTGPYyPqOKRRa/5G3TycQymcNBmceSwvZCsi7H/W2aSwxHVkyDoiidvwr+qWaiZqLGCVIpXdBqtGqBRnTE7wU9yGnQYOzZ7DQo2+90seVF4KupYv8W6mSUv6yvk0PKj2FAW8MB45Bny434wznUqBbJpv5/Zrrigme4nAOKFHz1RnPraQtcJfyKQY6ZpvNEveZktYDhhjK+D+J4lLnn1YKYlK8yyRhfUZ1Xa8rLx3vhZSyMpd9NyOR3DIEv/AA8PO9fJ9n0kyNbcQH2rj3m4kzya7NilTcUDgWg6S6dQWCHI+cnm1TS+fTKv4Adij/++HfbBzrD6E2pBQFH+GGyqRwvolpycgt7M5LzxgxZ7B/xYKgl1UkvJCY/HpIHBvoyvw1eHj323VBols14O2CFHeQtpYd56XpNzdrnsfQAgYiTpk4L92RG5U+W1cZCu9l3D/iEEoc40GS4WScWtdGkDlrsOMUMYuocD0cFmm0ty5zj9QEz0C0KHnPTZ/mwlc8wjN9ln2+0wO4iDe09ZUM55jwObzJPBT96fdcCmVHjLtqHxsdgAwr2A7Cdj9W3RZakhDb+hu3seDji8VlnDwLX4l/sBqE6b9UaPpU7B6jKc6IWZ1Z3Lb+duOMHIMShw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9273.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izyKMwoB3BKByDiQ2HKS7nQWG+UCij/sLA1BrRhJBZwFr4/8V3v/InzMXd5U?=
 =?us-ascii?Q?aMEyOK/mfRXAsZaPMBWQ4UsKBDx12yfEb8d+JG2+tTvkU0Frhx6m35tTlTuI?=
 =?us-ascii?Q?UQBp7B1IlloTsk9VRQjA0dVWJozDRYw+BQGLHxcze2tyLYoaVow/THKaspbd?=
 =?us-ascii?Q?DE08pru8ZA27kXCyOdc/ji/5Ms4ntOz1pt8sKCv/YN+ex1qyZ69HpA6zy/Jo?=
 =?us-ascii?Q?Afcc0hmqhJ5Z7KI4EvwKDQwkEjsGhZclAYMARjydvcWMI1f+UPyDbHQfY2KS?=
 =?us-ascii?Q?ypxvLNmkNeY9PfEJbXRkl8snpRMvEbQRMjO0FdjKBm5v04BcoOp9mlje24R4?=
 =?us-ascii?Q?Em9QotcwIvGBMOVmfzwHoHP5Wri4KL0U0sRJD62BMf1IO1WIToaYKktYxYbg?=
 =?us-ascii?Q?zdA5ukpN91vmoA2FSlh4HJqr/AjAGuEBpwmjRT0fU0Bph5m3b++lprQJDEGs?=
 =?us-ascii?Q?JQD9pnqaCS5XyoRc4v8gUrQiJpJJ3Q6VmikcG3TVXUn+1TGlYMmgE6OfBA2m?=
 =?us-ascii?Q?I3NataDxnkgxw4xCrxwfDFxtceoWI/Adu8uq+d4ygmC7yRTRtJeNHF7cYWps?=
 =?us-ascii?Q?168CwUq+JjbvYrdhR/OBsZQAWYALVbKubx8XPRy7xHhGE/8gLWKdEysQEzmG?=
 =?us-ascii?Q?ibyniDxvTjZuQ6xWIFfxAY2faRW6Qk5iA0Mj7cMyizuDmKCtQGJVyyvuXRer?=
 =?us-ascii?Q?RHmIdn/Lb1RGHFRdKatIummUk59lR1qhDk4KXAg792oJThlfW8CDow4A6c5f?=
 =?us-ascii?Q?V+iLtYjHfKDoO6nVRmGa6pKyZgpjEFxwtJBHjGpSXRe+bl+unZf5i5LSA9XO?=
 =?us-ascii?Q?I4pShuWh+lDtuzGEtAXNwQYvr0vB7V16KYN06I4wWg6uutpIMrtVAq8oH8o2?=
 =?us-ascii?Q?/DqWBVboOKdYgU5HhxNorihYMC158dClMl11yLjSdv7GL/El3WGKAh4OPjzR?=
 =?us-ascii?Q?6S+Lm/HKiB+FV1Bx8J2vaRv+V8ibyJz1JOyz4tmSLe9ZcC23aIAOAPmOE5nq?=
 =?us-ascii?Q?V68gZPSMOQD+PfWeA55id/Q1S0mnJenRjYVYI6cviOHrNBpZetTKBpIGRIqX?=
 =?us-ascii?Q?I1UkHjPMmo8Y/VGuGOnOSjMQxDEP0I2nmnlke+Wlnu9UtEVo/ApDoK61UMA8?=
 =?us-ascii?Q?64MV2TnWUQqO4F9o9N8kU3Sdg2D6ueiL5JhFALkBW/nK4H87k3/k7pcqRY99?=
 =?us-ascii?Q?8+xXT6W8j+zpZ2U+c9OXMULv94s6IAQeJOxv2hwhXr7bhEyqTMuNCuuAtn2S?=
 =?us-ascii?Q?2edu960zNDS0wMuT8uV0NOW0N3QPM7cgOf/2Yu8hpFIa2HU2zN4cetyjOu+z?=
 =?us-ascii?Q?/FgtVX+WPzWwhpCTc1AaXe8iZ+hhbWQ+nLbdghghNtuSnSV/Gy1incEeM7q6?=
 =?us-ascii?Q?2/yZbE2cntPhPx+9c6XNx075pp4Svtp6qU8CYjAlIxISNFL14rilBt+6fddf?=
 =?us-ascii?Q?1ly62xVeeaXzxENSHvVa02pCOqH/FLgqOG2lShGEXQ853uvwp2P7bJYPCNL6?=
 =?us-ascii?Q?SJt6STTpizWfApDrtmz1J+6L9SKiNLfBO5Da4d+Gi3AtmNBvkv55Fl4W1Jjk?=
 =?us-ascii?Q?3NUvQCe+5KSIBT9ocjlTGQTqKOjb5Am3ZYylGmp9vLn2/kKmgA4pl6PbNOa9?=
 =?us-ascii?Q?JQq7CJwEKlsk9xkSJe+c5EFTMz3joa/paUvM35DPFFK8lxuu0I6S8GU1cr6+?=
 =?us-ascii?Q?BMnlW1oNd3OcvsamtbBLPUM3eSk/uPkafCjk0UAWpm7rXd7/ndhq7aSajLWz?=
 =?us-ascii?Q?Jy19LbtLLA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Hfe+/riqhaO8dzlYnicvWNaL7E2aMnPsJ4Lm3JLj/Zkd+eqT3FuigdLuBRzMJK0y3ueD96hzJRHqS5XBzjC2xg1GUkxPu8ah/crcdiaq59VYenveLtKMlw6SMx/W+giGsgTmo360S41MSX23hePIH4HlYinN0amHcne9OJIj05PUJ7PiOy7S+cwb2zgZwQfeRXqPrrj1tTYJU8fiumm1wepLDDkiz1FbiTzanbTNtm537eQKU7eo/0sQwJMRPFS79FUdoouIRKDfqC9cjHMDCaQ6Y6fVltD6osOh9RPWuBqQ3zv/ZyyMg6RztezPK+QK3OBGe6eRQ8l9llik13kn1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7254a8-d038-4382-8370-08dee3e1da57
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:00:30.6999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqdMlq/9at4ASREeQYLkZK8OsL2hdQ8HO3GsH8nLrhno78DQXcZaOkeM3A23QgNxE9FiWLHvvp+dfSR1msfrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8493
X-OriginatorOrg: intel.com
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
Reply-To: imre.deak@intel.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Thomas, Maarten, Maxime,

could you please ack merging this patch via the Intel trees? It adds the
DP tunnel register definitions for UHBR link rates and reading/parsing
them, which are then used later in this patchset by the Intel driver.

Thanks,
Imre

On Tue, Jul 14, 2026 at 06:26:55PM +0300, Imre Deak wrote:
> Add the DPCD registers and detection required to support UHBR link rates
> over Thunderbolt tunnels.
> 
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/display/drm_dp_tunnel.c | 116 +++++++++++++++++++++++-
>  include/drm/display/drm_dp.h            |  12 +++
>  include/drm/display/drm_dp_tunnel.h     |  21 +++++
>  3 files changed, 148 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index 76c6bc84a806f..d29ad4116e641 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -111,6 +111,8 @@
>  	DPTUN_REG(DP_ALLOCATED_BW) | \
>  	DPTUN_REG(DP_TUNNELING_MAX_LINK_RATE) | \
>  	DPTUN_REG(DP_TUNNELING_MAX_LANE_COUNT) | \
> +	DPTUN_REG(DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) | \
> +	DPTUN_REG(DP_TUNNELING_128B132B_LINK_RATE) | \
>  	DPTUN_REG(DP_DPTX_BW_ALLOCATION_MODE_CONTROL))
>  
>  static const DECLARE_BITMAP(dptun_info_regs, 64) = {
> @@ -140,11 +142,14 @@ struct drm_dp_tunnel {
>  	int estimated_bw;
>  	int allocated_bw;
>  
> +	u8 dprx_128b132b_rates;
>  	int max_dprx_rate;
>  	u8 max_dprx_lane_count;
>  
>  	u8 adapter_id;
>  
> +	bool dprx_128b132b_support:1;
> +	bool dprx_128b132b_lane0_mapping_support:1;
>  	bool bw_alloc_supported:1;
>  	bool bw_alloc_enabled:1;
>  	bool has_io_error:1;
> @@ -260,9 +265,46 @@ static int tunnel_reg_bw_granularity(const struct drm_dp_tunnel_regs *regs)
>  	return (250000 << gr) / 8;
>  }
>  
> +static bool tunnel_reg_dprx_128b132b_support(const struct drm_dp_tunnel_regs *regs)
> +{
> +	return tunnel_reg(regs, DP_TUNNELING_MAIN_LINK_CHANNEL_CODING) & DP_128B132B_DP_SUPPORTED;
> +}
> +
> +static bool tunnel_reg_dprx_128b132b_lane0_mapping_support(const struct drm_dp_tunnel_regs *regs)
> +{
> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
> +	       DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT;
> +}
> +
> +static u8 tunnel_reg_dprx_128b132b_rates(const struct drm_dp_tunnel_regs *regs)
> +{
> +	if (!tunnel_reg_dprx_128b132b_support(regs))
> +		return 0;
> +
> +	return tunnel_reg(regs, DP_TUNNELING_128B132B_LINK_RATE) &
> +	       DP_TUNNELING_128B132B_LINK_RATE_MASK;
> +}
> +
> +static u8 max_128b132b_rate(u8 rates)
> +{
> +	if (rates & DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_20GBPS_PER_LANE_SUPPORT;
> +	else if (rates & DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT;
> +	else if (rates & DP_TUNNELING_10GBPS_PER_LANE_SUPPORT)
> +		return DP_TUNNELING_10GBPS_PER_LANE_SUPPORT;
> +
> +	WARN_ON(rates);
> +
> +	return 0;
> +}
> +
>  static int tunnel_reg_max_dprx_rate(const struct drm_dp_tunnel_regs *regs)
>  {
> -	u8 bw_code = tunnel_reg(regs, DP_TUNNELING_MAX_LINK_RATE);
> +	u8 bw_code = max_128b132b_rate(tunnel_reg_dprx_128b132b_rates(regs));
> +
> +	if (!bw_code)
> +		bw_code = tunnel_reg(regs, DP_TUNNELING_MAX_LINK_RATE);
>  
>  	return drm_dp_bw_code_to_link_rate(bw_code);
>  }
> @@ -706,6 +748,23 @@ static bool update_dprx_caps(struct drm_dp_tunnel *tunnel, const struct drm_dp_t
>  {
>  	bool changed = false;
>  
> +	if (tunnel_reg_dprx_128b132b_support(regs) != tunnel->dprx_128b132b_support) {
> +		tunnel->dprx_128b132b_support = tunnel_reg_dprx_128b132b_support(regs);
> +		changed = true;
> +	}
> +
> +	if (tunnel_reg_dprx_128b132b_lane0_mapping_support(regs) !=
> +	    tunnel->dprx_128b132b_lane0_mapping_support) {
> +		tunnel->dprx_128b132b_lane0_mapping_support =
> +			tunnel_reg_dprx_128b132b_lane0_mapping_support(regs);
> +		changed = true;
> +	}
> +
> +	if (tunnel_reg_dprx_128b132b_rates(regs) != tunnel->dprx_128b132b_rates) {
> +		tunnel->dprx_128b132b_rates = tunnel_reg_dprx_128b132b_rates(regs);
> +		changed = true;
> +	}
> +
>  	if (tunnel_reg_max_dprx_rate(regs) != tunnel->max_dprx_rate) {
>  		tunnel->max_dprx_rate = tunnel_reg_max_dprx_rate(regs);
>  		changed = true;
> @@ -1331,6 +1390,61 @@ int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_aux *a
>  }
>  EXPORT_SYMBOL(drm_dp_tunnel_handle_irq);
>  
> +/**
> + * drm_dp_tunnel_128b132b_supported - Query if 128b132b is supported by the tunnel's DPRX
> + * @tunnel: Tunnel object
> + *
> + * The function is used to query if 128b132b is supported by the DPRX connected
> + * to @tunnel.
> + *
> + * Returns %true if 128b132b is supported by the DPRX.
> + */
> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel)
> +{
> +	return tunnel->dprx_128b132b_support;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_supported);
> +
> +/**
> + * drm_dp_tunnel_128b132b_lane0_mapping_supported - Check 128b/132b lane 0 mapping support
> + * @tunnel: Tunnel object
> + *
> + * Check whether the DP-out adapter always maps lane 0 as expected by the
> + * DPRX on a tunneled 128b/132b link. If the function returns %true, one- and
> + * two-lane configurations with UHBR link rates can always be used. If it
> + * returns %false, using one or two lanes with UHBR link rates may cause a
> + * lane-count conversion failure in the DPRX, requiring corrective action by
> + * the source during link training. See DP Standard v2.1b, section
> + * 3.5.2.16.3, 128b/132b DPRX Lane Count Conversion Failure Indication and
> + * Corrective Action.
> + *
> + * A four-lane configuration can always be used, provided that the DPRX
> + * supports it, regardless of the function's return value.
> + *
> + * Returns %true if the DP-out adapter supports the 128b/132b lane 0 mapping.
> + */
> +bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel)
> +{
> +	return tunnel->dprx_128b132b_lane0_mapping_support;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_lane0_mapping_supported);
> +
> +/**
> + * drm_dp_tunnel_128b132b_dprx_rates - Query the supported 128b132b rates of the tunnel's DPRX
> + * @tunnel: Tunnel object
> + *
> + * The function is used to query the supported 128b132b rates of the DPRX connected
> + * to @tunnel. Note that the related DP_128B132B_SUPPROTED_LINK_RATES DPCD
> + * register will indicate no supported 128B132B rates for a tunneled DPRX.
> + *
> + * Returns the mask of supported 128b132b rates.
> + */
> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel)
> +{
> +	return tunnel->dprx_128b132b_rates;
> +}
> +EXPORT_SYMBOL(drm_dp_tunnel_128b132b_dprx_rates);
> +
>  /**
>   * drm_dp_tunnel_max_dprx_rate - Query the maximum rate of the tunnel's DPRX
>   * @tunnel: Tunnel object
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 7154216e0aff9..8b0ca36083dd1 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1506,6 +1506,18 @@
>  #define DP_TUNNELING_MAX_LANE_COUNT			0xe0029
>  #define  DP_TUNNELING_MAX_LANE_COUNT_MASK		0x1f
>  
> +#define DP_TUNNELING_MAIN_LINK_CHANNEL_CODING		0xe002b
> +#define  DP_128B132B_DP_SUPPORTED			(1 << 0)
> +
> +#define DP_TUNNELING_128B132B_LINK_RATE			0xe002c
> +#define  DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT		(1 << 2)
> +#define  DP_TUNNELING_20GBPS_PER_LANE_SUPPORT		(1 << 1)
> +#define  DP_TUNNELING_10GBPS_PER_LANE_SUPPORT		(1 << 0)
> +#define  DP_TUNNELING_128B132B_LINK_RATE_MASK		(DP_TUNNELING_10GBPS_PER_LANE_SUPPORT | \
> +							 DP_TUNNELING_13_5GBPS_PER_LANE_SUPPORT | \
> +							 DP_TUNNELING_20GBPS_PER_LANE_SUPPORT)
> +#define  DP_TUNNELING_128B132B_LL_LANE0_MAPPING_SUPPORT	(1 << 7)
> +
>  #define DP_DPTX_BW_ALLOCATION_MODE_CONTROL		0xe0030
>  #define  DP_DISPLAY_DRIVER_BW_ALLOCATION_MODE_ENABLE	(1 << 7)
>  #define  DP_UNMASK_BW_ALLOCATION_IRQ			(1 << 6)
> diff --git a/include/drm/display/drm_dp_tunnel.h b/include/drm/display/drm_dp_tunnel.h
> index 57f5e90ba8fda..b5e665560a47e 100644
> --- a/include/drm/display/drm_dp_tunnel.h
> +++ b/include/drm/display/drm_dp_tunnel.h
> @@ -63,6 +63,9 @@ void drm_dp_tunnel_set_io_error(struct drm_dp_tunnel *tunnel);
>  int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr,
>  			     struct drm_dp_aux *aux);
>  
> +bool drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel);
> +bool drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel);
> +u8 drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel);
>  int drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel);
>  int drm_dp_tunnel_max_dprx_lane_count(const struct drm_dp_tunnel *tunnel);
>  int drm_dp_tunnel_available_bw(const struct drm_dp_tunnel *tunnel);
> @@ -173,6 +176,24 @@ drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline bool
> +drm_dp_tunnel_128b132b_supported(const struct drm_dp_tunnel *tunnel)
> +{
> +	return false;
> +}
> +
> +static inline bool
> +drm_dp_tunnel_128b132b_lane0_mapping_supported(const struct drm_dp_tunnel *tunnel)
> +{
> +	return false;
> +}
> +
> +static inline u8
> +drm_dp_tunnel_128b132b_dprx_rates(const struct drm_dp_tunnel *tunnel)
> +{
> +	return 0;
> +}
> +
>  static inline int
>  drm_dp_tunnel_max_dprx_rate(const struct drm_dp_tunnel *tunnel)
>  {
> -- 
> 2.49.1
> 
