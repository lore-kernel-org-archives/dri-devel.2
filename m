Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D010ED661
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C64210EE93;
	Fri, 27 Mar 2026 13:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hgflz617";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2ED10EE94;
 Fri, 27 Mar 2026 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774618387; x=1806154387;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nE4S7V2S0L6Prnaj/EY/lfqmSIvtIi630kIwo8qich8=;
 b=Hgflz617Bz/WLNrBKv9U19PB3OfmyOT1O+RC9n9jLVo6sBqzXp+MsOx3
 fKZ1AEp1YxBjscoKcVJ+ddYMtnZ++mWUPrsEdrQmVxMS2dtkFGZvlD45I
 HJ0j51ujHm9dUcuBbSWcA85fJEN3vtLqfeffCvBiX5/G/5y8+w5laiXhp
 rma1rk+H4HM1hDVfQVep2bgPGkL/BhofZAZQ2lbXMTc6PUR/xzf5g9oue
 1OUx88DTgPoTw78zDEMNMcImUX+mGadLwQ1stSwVR6q8wKpMZmCNeK52N
 y8rrdkJQlkQK88aLMrA0IqjC1H86ypd0f4Pu18N3OWDvP6qX6m0641o95 w==;
X-CSE-ConnectionGUID: biU8lQzpSUyWwlrY899qiQ==
X-CSE-MsgGUID: wTkiQhvSScKBA5oPz0xD+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74872719"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="74872719"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:33:07 -0700
X-CSE-ConnectionGUID: iOBDpS/MQMq8SV9dNVOPSQ==
X-CSE-MsgGUID: 2idj0BQ9ROGxpfXgK8Wp/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="230085316"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:33:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:33:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 06:33:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzA7RUkOjTI9GT2ybfqjsL0dDBee29aMVq4z23h4OhZK5XRnz2Mf+xLrqEveOZaw+NaLScoHY3ffL/eBybF3qAyRBOdwdMk45/labz3dQwjTDJnL4wv62C7o+CX6vhOCr4nKMxlQcY0W9pK77lC9F4BO0R2oz7WcdcpXKFHpQwLSmjQHZjYGDUtyq0TobEb9917gDAeH4eZyzUF8oyNc0Mo9/KYID6Cgi+TWNEzW8mRpgNxkGYCqrPCP3E8lS/kCl/IP87Ugtb6xGxYgZ3E3yvo/6iiA4YCxdYEJrc7jVYOmQ7MD+GQsAH4KD+BaRBeBoSV0TWqZg54uNAP6AWRfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/KkimWh71U3z23HwcKfgCe61xuChjabDQcAjB0JGPU=;
 b=NWK8ZIPFCNmqXVMjgqCIoB38Gj1ZPqQ6AiHTM9AP81f3a4IE8jG9thsqkiJwbsqfo9kV8xF0ZGBt1Hb49+yIedphmhgrCuloY8EgoZA1pOHF66L19uy4kKLEVYTB4mTpKONY0/h8pjJC162DrEX8XMn0Zw6k/K7CLKmq/kFnC+MoOfBpB1KySUdD5rLaZc8I7gDkW9tyr5N6T9FE8uIQPIKyIJsj2B8OoTiEPSWnGarLya50r1pUJhTtpSHVCOWa5KwSfKNdicpVffa85uhQSyiqgbKC/073Xe5Z0A1qaameh+ltLC8RgBG9nk5Xwa3Ep2XdaonrwbaqX76oRA+b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH8PR11MB9807.namprd11.prod.outlook.com (2603:10b6:510:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 13:33:03 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.011; Fri, 27 Mar 2026
 13:33:02 +0000
Date: Fri, 27 Mar 2026 09:32:58 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
CC: <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe/xe_vm: Convert comma to semicolon
Message-ID: <acaHCvc1G0g6jHY4@intel.com>
References: <20260327032923.649869-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327032923.649869-1-nichen@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|PH8PR11MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f1ef4e-0f79-41f5-b4a8-08de8c055eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: oQobdvynm00eNEGCTkrDgC+bfT7WAOPVWgKjNZl2J7vzg3mql/Soiu2JVyjpsX6n+7TJTaFulihux651k94UEp6jPshfF9ADkq/lx9a/vBdQclJ65SLvjylyEo/FRTr1i6s5mb/gH+NXblVl/nlsxc58bgSC30Hu5YkGxto8RZucoaUbyOZWdSdxH1YmTR2DPJLH0bX0CvR92veAXb0Lkf6+Ius+anMYesyHfwj1ol8vucdM4kBtER19JFvna2zJfeUl0KlRntZcOIgeDCzUh4PWIRqIGYioqe62bHL/uEKF/4BxGHQcGAR2klyZ7ACh4iD3qSAr4KbKprLEALsI9ERBhpeIs+01HI5zafMOshnwRaRjtTfKjPgh1SNW9fM/0j1By+rA73VdgPxC414yujKpomk8ZDR90SGdX9m5AVxT4D3JyNZJ5n1DXjv9YRRem/ki1rZOtu28XqAmmIXAWz5JiY/dU9BkVH4Z4obmA5TEsl0Y5xyHW7KISEfHKKLA27bwIp9pRkbehzQb5ARS6YioeEEBhrWwt2d3hYruudKI7AzqS7XGkRY6pR6Fn4bYVV75PZMkt7fiP+90DrXJvbjrAwxanPpkLX5OqMKbBX1HITzqHqLOh95t5GwQO3m57qFNxJMUECgDRRenKQJAp91Su5/6TtjTDcCNAzt234ypmZrpRMRj09r68P1QUSPAguMwGUas9pzCbgFzWWkb6IdnUkk1h2WdYYecDYMFfbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zu8cHw+FtTNF4V3aoLnRm8dhUeewt6LnejhwpyQ1BfTIBGddMT2IEo0UNP/E?=
 =?us-ascii?Q?zuIMBCyo4FcFIzzrnIZRd0FgolNpJVfnQgfLAUPHiWkvc7DAF0IVrct9uzdL?=
 =?us-ascii?Q?/4Bn3K6Uw+TusLXmoDi0cRG8FOU1N9jdw5b3a1S8/sJsajRTN4KiXZVAEg+U?=
 =?us-ascii?Q?uH9wRWzo81TRw4EWgJcaYzk0t8jPsSht2YUaiZTEd2UAoMooJzh4RSBezqKm?=
 =?us-ascii?Q?LrIVQbwXwhvzJWpWg3WD9O+3wej13/R3dcrkJzCIjg0ArytBAV8xfFpfbwOb?=
 =?us-ascii?Q?rjIZ1QYaqhaT1KpLwuUFXRiJ1Y7+Qf/wPZ1meUmRtWeBPM+5YzOkH7o3LsVD?=
 =?us-ascii?Q?m+zwHyAPJpCJ2ssioCYDmcHpo61jTJqgtpscKXtQybjfE924DrTHSET3ZNa8?=
 =?us-ascii?Q?suggxY4RgW2njiqeKZHnRfC9njRhj4pLHqmh7LxxF86VXGezoI2hhR3Ziqhw?=
 =?us-ascii?Q?+KehwP1WQHmjrMdZBPERJqlSZ8a0yRWbKfKCW5SPDsD6Vi6dfBdyRw7cP0yV?=
 =?us-ascii?Q?TUAAaOmoj9UVfvfit39ze+aeH6KMf+dQatTFUQeikz1ykH1oUR5fTA478nvl?=
 =?us-ascii?Q?+x95QGmGw/c9ShII8SSuUIxJW2+5GnSyT+Pj13lSfrBe1zjbLiNAQzhcHVk+?=
 =?us-ascii?Q?0bODgpNqzuR8dIpu/ND+umLbO2G2nJkcNFl8owPohn2wpuVMAuXmzHB6LYWp?=
 =?us-ascii?Q?0nVA3WJoz1c1vjrb2RGNmRqoC0L8tLT6FcUZX1sMte6ljpEZ96aOdwS9nWSk?=
 =?us-ascii?Q?VUjnoHqKpPyRbmWSVAmiopycUEGDkkuYnDHkbc1RdcGluQsmSYZuuDWYTPul?=
 =?us-ascii?Q?3S4znLEsAC57LSuXSqori6NrX5BmtBY9BzGTDcy6IjceU4c5PIat5So60Dw0?=
 =?us-ascii?Q?1dEbABD2kzz12VHaL/1MfuT2ynnG0XFufVkl8g3Yo6v4/ZloIeFtbZkCMmNC?=
 =?us-ascii?Q?f4ijeNM7Hn2p44Z9B9QznLcr/IaLUYPoHaF9jMJzDXIWLGKDr/El0qwBS6CG?=
 =?us-ascii?Q?xEiuYmt4hj+gAQSijLnuopEQmtpVajQ5MMNCC4Zh/e/mUs43FhnCWYJIQNnG?=
 =?us-ascii?Q?zoni3Dx+3btTCuom+oJC9CB4aDLzi9rvIH5c2zlISnrF014HPQSKyDqMUiGd?=
 =?us-ascii?Q?Up22aHUCkvKEXP9811kiTQ7WQedjE0rnWcQtLXSA97063of8WJBkGOq9UBVR?=
 =?us-ascii?Q?hlLxHFGmKtHa7G1aqUje/3EuwJbEMMEj/YMcktv6TJ5Q6s9HdtqFhVn8yOx3?=
 =?us-ascii?Q?QAwGz8vHz9kZjSspRsrtoXznlR0GmAzXfitTxztDM18fpD+yZQ5nvezFUTWq?=
 =?us-ascii?Q?TQXkViNNJWoziLI4nmkRACf1833kzLWZhdJbM2kTE33t17k6zv6V2+wNE8pY?=
 =?us-ascii?Q?QaRLa4KSoJMzVGq2Ci+OZYrM1FBTkZxPFefc3Qs6fJ55LGFVHO0jxvko2Tsb?=
 =?us-ascii?Q?/XxnNmHY2LSEHvWKjGmuvVaQ2HXfKC1FXXQucFOhhYbM3J+uWyiGREH/xCuF?=
 =?us-ascii?Q?rny0Scr51xgUnNEB9vvd9at29KATpHajykhsH6Igrk3BwZI3xRg6qkRWIE7n?=
 =?us-ascii?Q?on5A6jeHF6EJmDf8wxQIEtvIp00kvdQuS0/3qcHKK9nDuHMTJ/GrCkGzDNLm?=
 =?us-ascii?Q?g4QaSbOk4vYvM0j0B2VmF9LL23fg6fB6tTkrdC2rooHNC+dhbLplMorrVtPA?=
 =?us-ascii?Q?hAg3IP1CGdb/pKuc/Om+JhMdH3GON3l4kmC82kYPuJEEejl7TXBZ203CUmYw?=
 =?us-ascii?Q?RAHuoNckZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: IJkZa5WZvnaNDBoLS0fy1nzU6ZsUVa9SKFNmkjQ0sRyZCE8Eb28mAHPBR5XnTg8K3U5iA0XbSJnaQdB+k0fsQc2xB+3BnwAYIR/w5szm2i/arVBYToiQVtv0QixQnUTkIyG9+Hu3DMW+J4PuxhubhBeST69D3bLa/RAD2bf2MnWKSeapzvbl7Y3cnoRD94A9Lv+p+72jh2cZVt8M8v2aFX3+x1Jg2tcd6++/mRmlpjn946h5kEouv7R3QwCnpCm2sKcUso5gq2defs3nIQ6pZp263Ayvv5T8bIozEF3w2AScQcBsns8fFcO2N98aN0S/E/M6L2gqbQVTjbuQqZObHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1ef4e-0f79-41f5-b4a8-08de8c055eba
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:33:02.8091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /24BoxJe6w8INfBKkeAXJDNSftagA/kRfnOyMeYqsQqCnX9HiXAHjAQvuaiKnvdNWMzqEqTEAl6OWJ/y0v70Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9807
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

On Fri, Mar 27, 2026 at 11:29:23AM +0800, Chen Ni wrote:
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index d96e0a0c5605..21844217dccd 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -626,9 +626,9 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm, struct xe_pagefault *pf)
>  	e->address_precision = SZ_4K;
>  	e->access_type = pf->consumer.access_type;
>  	e->fault_type = FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
> -				  pf->consumer.fault_type_level),
> +				  pf->consumer.fault_type_level);
>  	e->fault_level = FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
> -				   pf->consumer.fault_type_level),
> +				   pf->consumer.fault_type_level);

This code is not present in our tree.

In the xe_pagefault.c where this FIELD_GET commands are actually implemented,
the comma is the right way.


>  
>  	list_add_tail(&e->list, &vm->faults.list);
>  	vm->faults.len++;
> -- 
> 2.25.1
> 
