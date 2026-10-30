Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GefX9Obh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEBC10E2C7;
	Fri, 30 Oct 2026 23:12:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A094110E284;
 Fri, 30 Oct 2026 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793401966; x=1824937966;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=LV1tPLpC9tSoLajzi7+me/vRIDhafcUssEhQfJdFOxw=;
 b=GefX9ObhQrL4iRt7SG9AtYdiFr7aYM6ErSE3h0LuPjCz7y+7U4SdYg0j
 rOizmOSyqkuItiYM2que11Y9f5X3Wht2Hv/jbc/15gSKxBtSYscojnWo1
 MX+fEI7MkkFwWD2ptISoI1ibIA0AsmUrDjzmN2oAKbxm4Lk6by5bcSTgN
 +db8FK4JCleGA86v1Q1ckVquhUvDbc75N77N1o+T1bqYbvG0KxBfI4nOa
 chiBlpXDgZ8vBJJxdCtwDDnFxk0EBZwxJjAZLLQUxy8fakAsfLw+h3lbh
 QEA1UOXzwxb6aN93SbjOEfQJWk7wt41UJTFGgm23eyAtN/GcctoV1fSvM Q==;
X-CSE-ConnectionGUID: IcWpvW3WTGur+mActJBLqA==
X-CSE-MsgGUID: YOysiht2Q2KVFGHD34l77A==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2065259"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2065259"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 16:12:46 -0700
X-CSE-ConnectionGUID: sy4km3fkScea30gZlFz/3Q==
X-CSE-MsgGUID: lEfbWdkjTAO8WaTiSU9q1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7377708"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 16:12:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 16:12:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 16:12:46 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 16:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvTormDrj7vvatb5+BvwhGKeegl8IXPa7Gnc7TEcwo/VrBLoM6GelO5vN18AdxhQ+Yk0vbBbmf/FzYJ4amzgS0kMsvr53jAlvBSMEZDeSxT0Q0jA3e9VMgcI+7LjKvJCLe1VR/cSCxv8ZG0BGd7g9RhO5KwNEuRnv4S8yvfwntbgzFKd/motU4h7zqpZVR8aw+N1S8lUJL8JTyIi5/hq1Mv55sJH6MhJrGiWdrmR4AAHIqqhMER/iBIwrUsgaXTHt2dGgjrQ430D644Z1g88aj4asB53ackNR/qbhDSRLVV+G4Fuck1JbLFJfRIhCBnPzWfLC473/BowOI+/TOyARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SeFFmeQT8yqh5aCA1PRz2H9//N2j+jNhegN4+i6scU=;
 b=yqzcHt+h/IYa6LusEh1hmcepE4XqLjijvKiYW3LpdjLFbIaENa4szS3pdoi3gAcFDPeBsacWXECPbS9WdsKk/WthMRdv63d3dBSKbJsCfrePvDLQaZ4jYc8z4SPl/izhq3LzfoMvMJL2ZKPedAtvhCI6B1F2wQ0N3B/aHIwr27VeZlCjHQWsKA7AQqUPGuEjUgJaWuNEeNXAULH3HHyBMdz8niFTipQWHijexSS7m0cnZ+e/nLOTcuQmkK2rOM6Hb1I+9t8gWF3MSFfEJ0dlERFefJV5f2xUmEb3PLxlBcKU5Oz8SUslu6pWlLUNy+9tE2iodW40q8j47uXxM1Xlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DS4PR11MB131308.namprd11.prod.outlook.com (2603:10b6:8:502::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 23:12:44 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 23:12:44 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <dri-devel@lists.freedesktop.org>, Daniele Ceraolo Spurio
 <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/1] drm/xe: Add support for WA 14028250015
In-Reply-To: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
References: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
Date: Fri, 30 Oct 2026 20:12:39 -0300
Message-ID: <874ie2u6jc.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DS4PR11MB131308:EE_
X-MS-Office365-Filtering-Correlation-Id: ed841fda-da1d-4f4e-17e3-08df36db4d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|261021121427099003|261022113327099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|10067099003|261009220027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: 2rXu0xw3qKM2v9h7ZEUq+9IFECSO7hgkSs+8gil4say8lckNY9x0LM5S6L6kl5bS3r0yMRtOO4iBV2oI2vaHwVc6jECkh+SLPJPFk4PUvCXWWTBb8eDhdlVMoVmWz9mn5gEZQx9A8rP7+ImZ8ak9yHcrJiTEKyyPw57o91WP0EuNZJ66MpBVBmbBBAAj3D/3RVzM5zLmxFK+EqOVlqSt3QcVQ2hz5OKoDDCgTc89CqU8gJ9+2Uiz40G7P/KiC6F6C7oxNMUoJz7dsNC22vKuwy4tdCSquuxir3f90i0LC2gB6n/ttqbXVVZnLN0pUY5nCY/iN6yX6ahYeZ5HcNYIyyhr70zRwcy3NqRIt9D9xiUJ89Y0ihT7t1Ht7XmGLIr44TdJd/wnEjiQMr1drte51EcKD7QdBCU6kdV3iuwbHF9mp8X2zeKuMwK0LpO4D5y1tWPIXMFiNtW/RsjVDcFrMel02UxUQefBvnPBLVYYy83T+DnO7LsrB3IWR7OHlkFkOF+HV0/6mvv4UGoJbll5i9E2ovPIuIYgLPnih06CozGinVcmearfNh29IbZTXkB/sAzsBkeT/obGkdbHoBBeeUCxkJUL8YytROYpcoGvJbzM3Q/XeEPjq7gzsCPeavWWrMERcx5qXGnrEmvmCvDh3Jw9N5NKTKPZ63jr9gGcUSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5095.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261022113327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(10067099003)(261009220027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSx0mH8eWqaYpwnFP6k9YOyaF1l3feNH8RzKONP1fCwJso3L2etkyfUHDPBl?=
 =?us-ascii?Q?fsMmr93jELbYq+UnIQA5js1KS6LCdZIiJIMAvriiVg0SOPm7MY+3UiGnpxbm?=
 =?us-ascii?Q?tbEZgCAbrRuySPrKk/a9fCIw77b3ncUu9n0U0X94yG3DN9/YyrVvx4Zrw//G?=
 =?us-ascii?Q?48hFCMPbUf2+81ZCId8HdzHWvAcHuZe+wusnPe7Oy8YtUB+udGWdLdlKJThD?=
 =?us-ascii?Q?HZ3VQbCrGE7ltweqXSRDwI3F5j2R7HbR/Oj1Aw80+E0ABf9JiUBFjZWmoGiI?=
 =?us-ascii?Q?U0RbLfcpCWbhRU9PtNwskwlcWdhafWtjwZVyOKCRdGwiDGk307cX2hoMHUSF?=
 =?us-ascii?Q?jYY9ufK/LEpdi/oevqFlBeAJ3ficy3Qv2lloTpnnktQRiai0TzsYgFT/E3nF?=
 =?us-ascii?Q?+jcQx1ukmUo52sGOFc82mF/IaNTdZsGWgou0M8+mOXAWMpBtTayn9hPbztn/?=
 =?us-ascii?Q?8NW8uZt0iU4TWgbcXSWCw6rd7yvFN+gd7VNwIJx3LpiArQ8anqWDInEDLSD+?=
 =?us-ascii?Q?CttCGQT1fMo1Aya0+c3TivTseaCUfVY6rFKBqnbjPAS3tHQxf8XxO27bRr13?=
 =?us-ascii?Q?RP0EdezAlqCuEJ9AdHK88Xjkxc3VVUSgwfp7TJbOrJntxOaei0JDbJJxVzwN?=
 =?us-ascii?Q?NLndYpTGBekQNODdZJmjSvCADD8/341F/Z0ox2g9xqJ5MohAwzyRg4u6KIRo?=
 =?us-ascii?Q?FkhW+HPzfO3M1im1yR/NNtblZFX8yNOfQkGfKm7ijyAG6q8NRxl9GX0+1DC9?=
 =?us-ascii?Q?axL3Ntho2rJ/2j+Rd5E/3iDbpVX2MTsez+DRy9MiBXgAZUwRGTOVKhkb+ok7?=
 =?us-ascii?Q?BNO7iA/PH1yr0F7EGYboGKBPLVPBC2xH3OVfMnVoeHxEerDPpB8s/Ud/2dZT?=
 =?us-ascii?Q?+3FqsdjqUn023Ub7OsGCgBDcp/d7gniP35oPc4b+yJOFqWvgcDJuatDcSA2f?=
 =?us-ascii?Q?PzV07S0DzanYjITCTweiZo5zhKeCBpu5vxUXQlRybY30LGfsyn6liuXLzLsZ?=
 =?us-ascii?Q?kiGWgrOgMbRNIZIZ4LUAQLiLIIEsSaMl0gzhFWcQod/FuWQF72U8UvTiKnYn?=
 =?us-ascii?Q?SB63q7SOLlYUDB2U+b7Pvspc4P4HqvGb2rVbJtywQ/9LjxDw8ImxjNxFPY1V?=
 =?us-ascii?Q?kdKQspIKuZuQjeEEvGtvwBTHckob4zdpzfwDkDB/g1djLN3a2lxNNZ05Z1j8?=
 =?us-ascii?Q?MEBjJ5NhmJto0n3P3NTcyhJm70OKcDDEyKSVT06OD4Xtpf4mFE8Jzr4hpyKs?=
 =?us-ascii?Q?TiYgRKeMq4n8uMS6e7Grf7YykCC3ljpwyqhn/Gu900D4KcZBlbZ4Du5T/4sk?=
 =?us-ascii?Q?q5QV+RMtGDOP8+QGBfFOtJHVT3EVuxUSgv5um3phWJ2+XcpX0CZSqnF/BNx0?=
 =?us-ascii?Q?Uy7OCbBQaJ0ZlhWKOiQnFMBDzolvETQCdknhCm9xapNPH2cQzrNJU25TRNfN?=
 =?us-ascii?Q?QAu02YSMVjajslTw+qo27Kpx57vjEmmxRdDBNzJakPZo01HP0cO9/a+h0Tob?=
 =?us-ascii?Q?6iICmO5k4VaD0e2Qfa/x118IYBZAHWUreByUC1FmckLKRFWz4bEX47IVeNJw?=
 =?us-ascii?Q?pkX/kwNwQ0mSMqTXtQCEvToRRN3GsxL3D/BKSDUDHMeB4Iq9Bt3Vk2l8wCSI?=
 =?us-ascii?Q?0YnNTq3AdikO70eHY7Fm8i53lnKDu08DsWEP2UJjAOuKwbxiua32kS+br+a6?=
 =?us-ascii?Q?wA2XjeOqT0pgEVVAfieZ1M4YGI17Z7J3EtDjA3NakI+Ns4oQFvxfiElLLOGz?=
 =?us-ascii?Q?+T2u9MFG1w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4S/K5vqQUDFgW217BjfOc7NAu8hjZxTU1WfA11sEvXVTC2oDr+EXfXr8pb8302f9RiFnBmnTyMK+TZg6umUSRedmyyHdQcM63zAI3GoSxL7lrJ3ozSNMnQF2fJaqT7rwfQs/04SlTneZWtvn/TOkXQ89mESLbjRLJ43lp4g+cG0NCBY+4ZYJUBcEhFA2jAm/FsH0tiHrygXn4AQLff5Nb2Amp2joNm+9smkuPKY4k1E/jeSTJ0gaqn9UZrP8If9nQGLCDXX67kLHZzmB4eETeNgibZzIHC2vtxL8QL+4mTklhpWfNnUTwtIEQXaDGYMcbI67hAbYxVC7y5nNXeUhmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed841fda-da1d-4f4e-17e3-08df36db4d41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 23:12:44.1602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyVjY9gz/vCTgj7gY5PsTkm1qwE5YiF8XIj2+S7E8grbUQDUHwXx9Mhwrm1ciwy8pMh72XRFrYd59ojnA3dlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB131308
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alan Previn <alan.previn.teres.alexis@intel.com> writes:

> The WA is implemented by the GuC, so we just need to enable it via the
> dedicated KLV. It makes the GuC complete page reclaim requests that
> end in an error, instead of leaving them pending. It is only needed
> when the page reclaim HW assist is in use. This WA only applies to
> Nova Lake (graphics version 3510).

Since this is a workaround for the graphics IP, I think we should avoid
saying it is for Nova Lake.

Also, on the subject, I would prefer that we stick to the notation
Wa_14028250015.

>
> Assisted-by: LLM
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> ---
>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
>  drivers/gpu/drm/xe/xe_guc_ads.c       | 6 ++++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> index 4bcdc1a96785..9357bb925f11 100644
> --- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> @@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
>  	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>  	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>  	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
> +	GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION					= 0x9012,

Probably better to use the same name as defined by GuC here?

>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index 43a2951a66d6..7d7b44293a08 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -389,6 +389,12 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
>  		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
>  				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
>  
> +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
> +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78) &&
> +	    gt_to_xe(gt)->info.has_page_reclaim_hw_assist)

Should we really gate this by the has_page_reclaim_hw_assist feature
flag?  This flag can be changed at runtime via debugfs.  I would assume
that GuC would do the right thing if PRL is not supported on the IP it
is running.

--
Gustavo Sousa

> +		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
> +				 GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION);
> +
>  	/*
>  	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
>  	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index 96132c6e3340..c73694aa40ca 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -77,3 +77,4 @@
>  14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
>  		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
>  16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
> +14028250015	GRAPHICS_VERSION(3510)
>
> base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
> -- 
> 2.43.0
