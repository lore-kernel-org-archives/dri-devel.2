Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D58DC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E9910F1D9;
	Wed,  2 Sep 2026 13:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UDA4/Lso";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7AD10F1D9;
 Wed,  2 Sep 2026 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788355360; x=1819891360;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Xxd85coYt2mBxrdmNoJMJlI4jTINpfih4i2lB+Hh3Hk=;
 b=UDA4/Lso7EhBeGVilBEn672g9s9Vv4NJ7/tXQWPFptvjykPPX4ALl5J7
 eVANgTxw9z2wjF/E2n/VhhPKr93pWDyh10+m+yp4uKAESWDmB0en+0zuv
 EzZ02fW7JDos70D7jGg63Tr5yaVFX1jxEJhB76VvPtOo7O+eO+9TBsN8B
 vv6ARdhRgm4tXURlCs4Y8JtVbn+gCdza2xsSN8g7vgz+WDPF03QRY9e64
 uuPh3vxNPwKzKc743S299FtD7CP6voLb0EkVdUobgQvj0Ydt6duuu8Gnu
 Lya13TiI0S/hce3R5Ukh5eAOCntaF8nnZo1FnnKwci/YjH/hR4Hq3SkBN A==;
X-CSE-ConnectionGUID: Df/Tb7I7QiOrH5prhWKKYw==
X-CSE-MsgGUID: PFNFSjc2QJSonalnUzPapg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99975096"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="99975096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 06:22:40 -0700
X-CSE-ConnectionGUID: NneAtBdmSP+orD/+m2oCKg==
X-CSE-MsgGUID: HcKuhgmlQByuuJ73x2LgZg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 06:22:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:22:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:22:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzB/NCcN6wefw+zMmSFeHmqg1pFRJu3e8loDTmJoPwDM83nTT0ntzY82Jcr4Do83/valhnVZYyMzb5WNn+jGyndN8zHAzLzqGZqfM3hIOO/LvVGVyKnKPC5kNqejdsWSUXPS4171F+Ujn45ZaxJtdJlpfWm/Npl+Ut8xW2tYmEmbiuSok5/bQAjkZrJP5amtlN1nP6ycuMcY7p+VCPHutgdZBqblmGUZL340HSHLQ7Liwg6fLKRr0VEmRYTXAgXwZUjC4c0kg/yFoszZ/sAFJNLfC2unxtKdjzmjGLTrb9z9Y659hrt9z+89GvKtJ9hEnY9z/7reCwOjSRuMl05WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CALGTPC/j4tj+wxLKp++1dFjPaNK4LSDI+W9Xy7K2k8=;
 b=FxCHd+80G+17Ul77+pPhGDtIMaU2dFwikAax7dCjwsBUtzLAKQKxgxnOwGf/KJxQLmw/6yuOb82iPNTqESNxYQL3dL57fpB+B5ZaNLJfqqNdZFpPxS6n2gJCXqp7xZsRmAtIi3gmqDqfk3xn/Pr28KYcPCa3Ma+C1WjU9z6P258r3CxJMenjPP8XWqc6VHSMaRUFm7o3BuXVvnuM1L2dNVS49bA8Dz+ugZ56YgrIcV+SuUyQ1WmuR5Laih6cwzEpZshvF/uHbkhQLd7XPmGszLUqOp181P2e776aze7MeEabONqtPgUQUUMZATJEbAE4eXvxIZ2WIpgs0DWtpBLNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:22:34 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:22:32 +0000
Date: Wed, 2 Sep 2026 09:22:28 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "j@metarealtyinc.ca" <j@metarealtyinc.ca>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Kahola, Mika" <mika.kahola@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/psr: clear the Panel Replay error status
 register
Message-ID: <apgjEwl47mLM4vPJ@intel.com>
References: <20260901203633.92628-1-j@metarealtyinc.ca>
 <20260901205956.130779-1-j@metarealtyinc.ca>
 <7840f6ad7fd6621d33d2651618acb2b23b5b9b8b.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7840f6ad7fd6621d33d2651618acb2b23b5b9b8b.camel@intel.com>
X-ClientProxiedBy: SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::12) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA1PR11MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 7403e1a1-bcb5-4548-0f60-08df08f53ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ml+D3M1Wt5aTmqPFHAKuY0z3ZlauIZVAiZee5D4H4QYwZuJLSig9cLSWw3TbSTILW+cf/6jVJ/hXFAUgVfyC4N76FH1QEHo8HsskpWwW/oZPR7g42Y7f7fkENiPkrHS9WQur0KC3E4aN3Kmx4/My/6zBx7nH7wOXRc8CsTNHBi1lM6e+58FWIJ2HGgwnFqIao86NwB3YFLaAXGqNAVy8iXtke3nNMB4GhE4W/86049iJL3A8Nd6uSklUX575iWYvNt1crA+S8scjmjcqiOi5amjfHvTuJLU7gsLUEMD/FN+BlgKSOmjmk0wvqHXDthBTkZ9gc0+3CB+tSeojfnvnATVBCvZnkXWtqxuO7GZPkW7GNAFFSa9j0eGqzfJ28Vg1hVOTaHPmdjF806SQ/fmMxVeTqWamjy4B3A4vkzwEygDndHwDunaPChsPN32ZQJsc2Urh1GCNBAZnEcnrnBQMR/wuXK7vwZfGXIvYQ+NAuD/xjzluEPU9S9LfCivEZKUuUKJaVTQy+ecQ+3zC0p70mw8L9s1+J10cXm0j0sQrjhbIs9FfAPt2oTeb81WcWVSlCn1NJ8CSJz8pIVNETwgE5Mq5rmtbhnAdZR3PLoFB0K5OBYjVMDnb6WbOHK4uhRH87Xr07Up/JK+ssuwgaQtJXJd3OoG7taRQ+8wZWFJ19Eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7cBwFI9PB2vaiBXEyJU1BZuMkQXh2aFkxnvTNwc7FCVgn0z0q9wMSzV0oH?=
 =?iso-8859-1?Q?pXC3GcX/ARr0f5kSp0MU8HxGhkVkwCvLvSUGbZxq8Swc84Wq/iTcJDG5Pw?=
 =?iso-8859-1?Q?em/QNHtM9PNg/vx02JQGjE5ihlkEfFkPYZtJKVPEaIBFsobbX6GOjpf/rd?=
 =?iso-8859-1?Q?tgenoJxAs66pwZXLMSllVyK7nK1LmGRtk0efRMkcrQniGTYwmTMEV/pXt/?=
 =?iso-8859-1?Q?WYXeHz82PcQmdjTqTA3c+MEDzAfk+YCh92HrBdOZozeqnL68yWjBqzdqvz?=
 =?iso-8859-1?Q?dLmVWk/q9RRhSCq+qPeO6+95AhyEC6RceoS0FOUykatQUjdKz90LKwo2aj?=
 =?iso-8859-1?Q?0NBtFddeioFkLz7tzfLafO9qDGH5WcM9VUpfG3qG2b0eMLI0mIgg6OIFVS?=
 =?iso-8859-1?Q?ocTFbpFzpLSVzecySjBhwAUJT+aL1HPi/418wIWuaSgfeNW+v1z397rN/a?=
 =?iso-8859-1?Q?9VvoxVwgGC2QJ3paYO0mGvOmWEmF//MzcsQo4dJdi8WC1qJrS7hmUq+2B7?=
 =?iso-8859-1?Q?TWtzCkzzLnb4sSBkMEcAo5+hiOi8hANQKj99FebjPCfoIQVhL+tDIWTDiM?=
 =?iso-8859-1?Q?kw9NiDlMfAQHL5zuRZM3wdUIQkQNU/loe7P8yU/PdDUD78EEIxtsn41B9v?=
 =?iso-8859-1?Q?NY6dpX9Rm5LbYjRlMtGnNd5GdqmaUXb8vbzcgluhRzteWXIF/yZXBZz5+j?=
 =?iso-8859-1?Q?YifnOXWpGIe9E2377qKo50PB7hj8gUjixgs+GNtshSxsAEnmEyPMyj2E+y?=
 =?iso-8859-1?Q?RLavPfWELPDk2EdzKjonTTnBC7Kdos8HKWSeGFCJOlfSfzQBKkUD2nlHqs?=
 =?iso-8859-1?Q?4/wH9QljZN/tuBUlEvgfVxKlyNaTc2ACh9nDZEgWnJTcHN9HsYHtLZXixu?=
 =?iso-8859-1?Q?ClIQs1f3tEhKUCC3H1FrjLcsYd2K2IAioaRlbsoXNpnHECmuV1uw7T0JB+?=
 =?iso-8859-1?Q?O3ioPXNbgjrIX9WuU8ahafKKgS0P+P03+epaR72ktACSmeGUKBhVmnw2uY?=
 =?iso-8859-1?Q?4rql6XMeRMMS2B24nGnN51sS/p+pq7RzrZts1xF0SPYePc9wePPXUk3FTg?=
 =?iso-8859-1?Q?CBDx+dkt5wiedu/JAalVl3pdLeKAckMOCX+4exxAkrU/SW0q/Rkl2Y5Bws?=
 =?iso-8859-1?Q?sXT4+VfqeHlKJFX/gR759NaCEPgz/JGiYfWbKrjw6C+OjkIaA0dndaUvWy?=
 =?iso-8859-1?Q?Ia+CxBlUydSpRRtI0YJzxukWA5Ixtkf1QAlZGkkF1sZ6b/D426dZrT2Eyi?=
 =?iso-8859-1?Q?43WyRs6vscmqyPX5ZM4d45XOJp7qS/QdzWKDXyr9J1YmpR4GIAhc5SwMx5?=
 =?iso-8859-1?Q?q0lnq6mYJRbs2X6JaEdu2EUssdYzKboJ7+WDK5vonsMkc8bcZyXZ64rqw4?=
 =?iso-8859-1?Q?yhhRVVlM1Z0sPNhCMlQ/j2fwVz/98lWMzfgegK/01n0H9RaCn5j9nNLTVI?=
 =?iso-8859-1?Q?arzhnmwAJFhG2IP5u1Rmr38tFzm3MPrMiZF/VNRr/5mumAVyDK+tOJw/h5?=
 =?iso-8859-1?Q?A+hFp2ZESvKX7/FcSf0/mOVoZoVm1L6yDFX8iQ7Llr/bBzu6zf/ZXQQruG?=
 =?iso-8859-1?Q?4NIhfRHa5OTWRaQFCB8VDr2PHaKN7d9Q0xl8CktJdZB+dYe/5Qzl7qeD/+?=
 =?iso-8859-1?Q?o7CKF31okMJUSMwLjSs/tG5BpMCqEZZITAnrKmF1x9A3cn//iPOMkwSI5c?=
 =?iso-8859-1?Q?b6YqjV8NnW4yT1JbW3HegoijmXiF10WtbK3FO7w3bAKbqyf/2xnBVCYjrm?=
 =?iso-8859-1?Q?A1UYawLKqeVILfWwsMPnAtyqLjENQl/Ldsjx8etlekNFSFyJtzYFuX4tPv?=
 =?iso-8859-1?Q?CSI9Pc3Ubw=3D=3D?=
X-Exchange-RoutingPolicyChecked: OPUoYAKWZpd+DlN4vmNL7w0Qeq4bTeMmROyPCRw+Tb4GdTo/9zrwj0o51FburI4FLOdW98NtUgg8I5XcdcUBUTyLLhORN7QSsoTrIeam2zDk7Y3E0nIlqRaS9rA3GVwvICCaGjdoEyT5JOAch5nXiJsvJaquAJaC3XdWEgHXyGK2A5l1c2UVLnoRZxOfdBxTOqScQvNEsGl8o2fASIc3O4w3iwtpz2cqPG8KwiRDuVe542DwUsx31YdAnBuKZDH8Q8oGt9dT0VGCYC9vxXd9dFa8E9CUlmrwePMiPhuTZGcdkmQPTlGQ7JSkBBdcBWghIjNLWsMqgO3MEy6RfU7Okg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7403e1a1-bcb5-4548-0f60-08df08f53ebf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:22:32.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6pM7a2jc8YCc+3meEEOkdPIxGTdy4r37h/B0d5e5BwzNKhQiTTvU5IhJ4zbWykmLtFGWJICyfoFNG2mPeF8Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 02, 2026 at 05:05:32AM +0000, Hogander, Jouni wrote:
> On Tue, 2026-09-01 at 16:59 -0400, Jake Steinman wrote:
> > psr_get_status_and_error_status() selects the DPCD offset to read the
> > error
> > status from based on whether Panel Replay is enabled:
> > 
> > 	offset = intel_dp->psr.panel_replay_enabled ?
> > 		 DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS;
> > 
> > but intel_psr_short_pulse() acknowledges it unconditionally to the
> > PSR
> > register. Under Panel Replay the error is therefore read from
> > DP_PANEL_REPLAY_ERROR_STATUS (0x2020) and the acknowledgement written
> > to
> > DP_PSR_ERROR_STATUS (0x2006). DP_PANEL_REPLAY_ERROR_STATUS is never
> > written
> > anywhere in the tree; it appears only in the read above and in its
> > own #define.
> > 
> > The sink's Panel Replay error latch can consequently never be
> > cleared. Once it
> > latches, every subsequent short pulse re-reads the same errors, so
> > PSR is
> > disabled with sink_not_reliable set permanently, and until a short
> > pulse
> > arrives the driver keeps Panel Replay enabled while the sink is
> > reporting
> > errors it cannot see.
> > 
> > Observed on a Dell XPS 16 DA16260 (Panther Lake, Arc B390, display
> > version
> > 30.00) with the eDP Panel Replay quirk from commit cb8d155b0806
> > removed
> > locally so the feature could be exercised. The sink reports a
> > persistently
> > latched error:
> > 
> > 	Sink PANEL-REPLAY status: 0x2 [active, display from RFB]
> > 	Sink PANEL-REPLAY error status: 0x1:
> > 		PANEL-REPLAY Link CRC error
> > 
> > which survives across reads indefinitely, while dmesg stays silent
> > and Panel
> > Replay Selective Update remains enabled.
> > 
> > Use the same conditional offset when clearing. psr-
> > >panel_replay_enabled
> > cannot be used at that point because intel_psr_disable_locked()
> > clears it
> > earlier in the same function whenever an error was detected, which is
> > exactly
> > the case that needs the Panel Replay offset, so save it beforehand.
> > 
> > v2: use a copy of panel_replay_enabled taken before
> >     intel_psr_disable_locked() clears it. In v1 the condition was
> > evaluated
> >     after the disable, so it selected DP_PSR_ERROR_STATUS in the
> > error path
> >     and the patch was a no-op there. Caught by Sashiko AI review.
> > 
> > Signed-off-by: Jake Steinman <j@metarealtyinc.ca>
> 
> Reviewed-by: Jouni Högander <jouni.hogander@intel.com>

I made small adjustments in the commit message to make checkpatch happy
then I pushed to drm-intel-next.

Thanks for the patch and review.

> 
> > ---
> >  drivers/gpu/drm/i915/display/intel_psr.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > --- a/drivers/gpu/drm/i915/display/intel_psr.c
> > +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> > @@ -3840,6 +3840,7 @@
> >  	struct intel_display *display = to_intel_display(intel_dp);
> >  	struct intel_psr *psr = &intel_dp->psr;
> >  	u8 status, error_status;
> > +	bool panel_replay_enabled;
> >  	const u8 errors = DP_PSR_RFB_STORAGE_ERROR |
> >  			  DP_PSR_VSC_SDP_UNCORRECTABLE_ERROR |
> >  			  DP_PSR_LINK_CRC_ERROR;
> > @@ -3860,6 +3861,12 @@
> >  		goto exit;
> >  	}
> >  
> > +	/*
> > +	 * Save this before intel_psr_disable_locked() clears it;
> > the error
> > +	 * status is acknowledged to a different DPCD address
> > depending on it.
> > +	 */
> > +	panel_replay_enabled = psr->panel_replay_enabled;
> > +
> >  	if ((!psr->panel_replay_enabled && status ==
> > DP_PSR_SINK_INTERNAL_ERROR) ||
> >  	    (error_status & errors)) {
> >  		intel_psr_disable_locked(intel_dp);
> > @@ -3885,7 +3892,10 @@
> >  			"PSR_ERROR_STATUS unhandled errors %x\n",
> >  			error_status & ~errors);
> >  	/* clear status register */
> > -	drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_ERROR_STATUS,
> > error_status);
> > +	drm_dp_dpcd_writeb(&intel_dp->aux,
> > +			   panel_replay_enabled ?
> > +			   DP_PANEL_REPLAY_ERROR_STATUS :
> > DP_PSR_ERROR_STATUS,
> > +			   error_status);
> >  
> >  	if (!psr->panel_replay_enabled) {
> >  		psr_alpm_check(intel_dp);
> 
