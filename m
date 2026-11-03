Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FF606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=apHV7GSR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F80E10E65D;
	Tue,  3 Nov 2026 23:58:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC5010E13D;
 Tue,  3 Nov 2026 23:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793750326; x=1825286326;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=xIqJfhMD0yDZD2iBLjsGBosMeTd5dJnNLuYn/sfQz3s=;
 b=apHV7GSR1yRYlFmY3WkwU+zAmOCaYHHwtDHbSBALnifadmW3wIi3Qr0v
 Bc2eQhAlpMZ5Schy+StNeos8M0/3ko4pGGPl7ZrY9uj+PDTMfZGz6k/TU
 uSRTikSmJpWFSgzOMSgcaKOSIiro4dpeI7J0eLjBs1DKizVeMwwYhqaE+
 /GVsMn5p1eTzy6EdueNbSIVS+5DPGDzmV+I0uA20aJSTgZ8I1gAV4/4G+
 CxIo+VWL6PYyQ6v3y/t0Fnuy81TneeXFmyFKZolSvGETn6V+8eVU3XyZ0
 VB/8I9TU6DSDm0mggsSgA0rFTbUpky2m6hX6og0sEQT45gDf61lhgh6j+ w==;
X-CSE-ConnectionGUID: OPVdr2lPT3+w2WDjPLg7pA==
X-CSE-MsgGUID: E9y5ojmVQxiT07FKWBnZpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2371618"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2371618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 15:58:45 -0800
X-CSE-ConnectionGUID: xHm0s1wtSIWJiubBBUtKtw==
X-CSE-MsgGUID: 3AjDriqRRyanpMx1GQwCpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6476345"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 15:58:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 15:58:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 15:58:44 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 15:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uae4xj0mvS4zIoUVmB/R2wxLVxwLtiWW4+lVT3a5ntW26wAodqHmVGRgLOnn1rBNl707Gy3FXowt1Q/ehXSsJq0nVnEfqnoQ5M6W63wdhu7pFZWv+rL0pqUEY7fhfZ8za1QvBSvljU5FmDC6K5HXY7UwKoKnlVd370b2PqeNlnz7NCJqDA/P32ci9qjdJ7spgwY0ISoFkKg+tYHRzHNMkF5u+npBRPmRIecztYSqZa0VkDsBOLS4ZhMYWfUyiVAQx09K60j8PvLH3C8meS6FlNZzUvrfNw+40J4hggUZpBTRcoAYlATikoxOzQm7IORxy0zoKSLag+EqhAQ0wdEbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ESYWmgOtY8GNWIbskEMl0KrVjXnvQNAVzGM7JyOKWs=;
 b=llALQuD47jDUdXkwiUTB9sC8Y7uhA0VoR7qmmeM8gaMnVjfdDU2yNkdjq3PY4UXwTbFDcJCsJ1hJYNyiYt3zBmuFjZsa3i+vBFxMkDWWhR1JOhfTbAxRS1BpbpckMNF1JfEtijIYjHzMs8ErdAgWvaxEhoKW2K3uHE9j79UCSplk9RBC2GEjqUcRLwgq7Ygk9Amqko9Kt/wRH6ZGtW1Q8gjvvX2+a0rtduvBb9t4bxHLyO8NX9KskX2TOTPpJ8uo0Ts1QSag3pYUT4A1c/aTfQGpM6B6dS1dtOwQqcOuj0x/ZANamN1oJtvFBYgCpbhtFrH6O07Dh+sjY/rSdnaHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:58:42 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:58:41 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <dri-devel@lists.freedesktop.org>, Daniele Ceraolo Spurio
 <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/1] drm/xe: Add support for Wa_14028250015
In-Reply-To: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
References: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
Date: Tue, 3 Nov 2026 20:58:37 -0300
Message-ID: <87tslxpivm.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM6PR11MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f9daf6-c0aa-4b4b-5e78-08df3a066300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|260925021911599003|260925021311599003|260925022911599003|11063799006|261022113327099003|261022105027099003|56012099006|261009223027099003|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dlmCGLkdfuMxi7Dzh8wbbFlFA6jKTyYDslwSbIVIAFAIqVPaDi4eql3iXBC8IEvt5W6j7EhCttRmHwTYx/cSC23+Im9a+YugdQWIe+//MzDCa11RqBT3cPgBN/Xo1JDUAoHAFDonY3qtZsGa5lwtedIpMbaFcz9f3CraC3y9BmJuLMEiQw16ti2rb6DWvgnrlmcZygXu0IDXOT4XwvpPx2bdq5VuN9SNHMVS7nA9BEt3OqzyxYGbKPTWyTV8uX0Z22Jqp4vuhZBxh6iOzUZj9rpbRHMUufio6QV3dyI+2GkLP1T1SjCHEq/gxTBMxx69NIwk5Vy+UyXPGgve9HtStDO6kXu1Ad6zq0VXYGKj0Z3PFGXqzK9IfGSybMB8jZd8Idx21NTe2nxmI0IljhKx0r77lf6CN2aNoR+ATRZVSXH5PKEUkUTed8JLEnmBmZ1tcLlv00eLTZVJ6RJOu7cxWLT/2Uyj0WSoQP3PIsV1t70tANp7VbPH1ucsuhZBVsXRiMRZvbCWoqEw4SPeds4nNBUcpJEdoUZemjX6JRBjMA9A9XPnvGcVBdKp+L3aY4/x4kOCacM7DPlHbAOPvloqpqTDwgMp8k4VsJY82rjxwmDAbkKMPegOvEPdJqjwj2ybWMzn0STARDZVVIGEkB0dn/mP3/IhHD0pbxMsfYJdDfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5095.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(261022113327099003)(261022105027099003)(56012099006)(261009223027099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fF9yXs/H3ZbG0Y/9/QCRUYylgwKnPFKECbiNxboXtdnD5Kn6rjavXujC/s8T?=
 =?us-ascii?Q?KpyZLc26Pytwd4X6GLm/4VxddQiZsdeGAONFKP1CA/IuCLnfB8kPZc3QNxu1?=
 =?us-ascii?Q?MK+spIb3F6HL6ShJs6hYiC3SsD4p2iY83rYrwXHYWgahjogz7Lctds6zujsv?=
 =?us-ascii?Q?ky1oJnaPXbZSZx/wl6XAVZYTfTppzKzr+Ma0ETu6BlLxjaeISui5h5ZiImWi?=
 =?us-ascii?Q?n8jFwJukxFQojbXJPsIv7RNpgOMjdDOC0CQSu9HEAnvYYCeTTR32sWgKlKCG?=
 =?us-ascii?Q?hGHALJOBTJDMJAt6fp9V/APwNpEuSNZNElq+wSJIz7cFxn6YaQLskCoRy3SI?=
 =?us-ascii?Q?AbLzpgHSpLlcIaDshtOw4ay175tIuGbq0W+Fzv4pS/VmpO+Y8EwavYhrFgyX?=
 =?us-ascii?Q?QDkt7/Szoyy/Ch+9Frydb0rqcNCX6H+rFzvqG71ArTXCK2TwNUBSzs4aJ9EC?=
 =?us-ascii?Q?YDlvnYJttPS2X8EmqK5dxuaE21vcXgyGDkV3r6h4BowBTQ/3HJXcE+ypK2Vd?=
 =?us-ascii?Q?JStGSuTfW5S6qc9iF0PxmBgKhm9BwGm+0MJFuTSwFzi7AfJ73ama/Xqan1ML?=
 =?us-ascii?Q?0YujeuqJB/Z5P533AspvHo2b/2Pr2qTn1Cwr6voNOnMHlAhOpcIpghTSn0Oq?=
 =?us-ascii?Q?tAXEtJpuRCl8xUPY0D5f2EW6hijBTZ7M/QC/OrVWv5R+6h1s3gzEUrVdOSHW?=
 =?us-ascii?Q?rHQWyCM+fCwCAbLTqEVnPvji2zWyl1efAwsP74OkRTRAQj+Fo0qPV2gVUzAD?=
 =?us-ascii?Q?1MPWfEQexqmWAdhx+bnlY9Ad5xJEnunYV4/aq6XlESg1OwqrkIngG/AsDo74?=
 =?us-ascii?Q?3jjKN0qEheHox0u9iEzvScKcVqzGakdMJT1JSVOn7wgxtw5hoTARK8PYTXo3?=
 =?us-ascii?Q?xEI1zo/1JU1MqthEpIBHUkcZ+pLFdOg3nM9GXHcNRStJu2EaT3sR0P2rB/9j?=
 =?us-ascii?Q?QEr6iCuHkjeIpI5WHtCRoSbHxtQCbO4X+/YSMOirLt52Ko3ZnCtLArJcFm/N?=
 =?us-ascii?Q?wF7B/yMU3k8Lzaf81D3+Ew00cWXLJf7J8AsE7Z2fJ945GiouyTZvNmrDfdCi?=
 =?us-ascii?Q?gpkdkRyoS5nGyg1+5jEmM1dGMAAll33EqWAZvsAiDaldpJibZBrDI9rqnUyW?=
 =?us-ascii?Q?xOB5m0Mf5auwIC7VSBpaXpvTSpi6FTEpy6exCPM+HaGmBL3LHdJTUyqrBdiR?=
 =?us-ascii?Q?u+3idCv3fDxMd3/jUg9XipP3eJCHHDm7BQLNH57Sa9Se9QjjC3JvT2lNHisx?=
 =?us-ascii?Q?e5PCxOgMkwJpalSfquLJ5IzBBv1y2/lL39knEfM5kO8OaIkQkuUstXxmOSNh?=
 =?us-ascii?Q?27viO1KMl+GD87jKFdmYv9xnwqyp3r3Oj90KN2ClDijjsF7/gdoL/bdDXsgf?=
 =?us-ascii?Q?TL+Qgt03Vi2rX6F7arHGc3QBeOIYhkz4OTjmR9mykdLWDI9bBzQ6FQqpzohM?=
 =?us-ascii?Q?fxKO7ndQpdMTCJP2KHepdYl+YITRnnp1Piwr4eIfCEc+FWQeGlkUMUAp11ci?=
 =?us-ascii?Q?4lEVwD9OtgHb0LQjkw7Mh4lAj4/piiM1qfCvockI296DeS0y3kGoaDr7kXZw?=
 =?us-ascii?Q?lRfjtDBXsC3g0iqMcUkAvo9Iy/wigEUFwoUNxalJr2mZ8aUjLQFAkwCBuyJM?=
 =?us-ascii?Q?3/umiKeKFYQIr8FjbotNgCm6f8CBX4enNnArGm0FfzyFjUnNmnvN5+SR9jZR?=
 =?us-ascii?Q?+SN/TjL9Fx8W/lKc5RYvGcgKB4+xmddUj0VB10eITc6ig+zkB06f4GhY1x2Q?=
 =?us-ascii?Q?Zwl/EzwiaA=3D=3D?=
X-Exchange-RoutingPolicyChecked: b+DhxKZqOKEfqYwdtO2gALJyhhMq1z6tOoirj2BhTfxFgto3YP5YAMdoFu/U42QJxHV0oNo4mg/C6cnYrHlc6wer3wKNND90d5J+AXx43PiqtlLcK3nkeSdjSv3I5HcjTFiyJ4F7JHAa7lUsol0RvEa1tAVQMiQPP72D4rTcELjTOixmdRjMV86WcsSZe8WvZvcvV7HDiZWSEGUiUDzuJpbGrILvsfuQBqDWaAJ2CzEFaUuq4wpBMm5zd4UQcIMzTZywp9WQVnwVwst4mh9ze9pmre60DPlAIyPw7SzRo7iL1wEh9iVsl3unAeSZXWSIxIO7H5/SX5SiElCUWV2FTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f9daf6-c0aa-4b4b-5e78-08df3a066300
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:58:41.9032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XB0DFZTqgTpLiI7FgQgNTX4Y+Y4zHZS8TGNiU6W4rdOanYlTzEq88C7ASzNaN1z2TohPIIdhQh2LeWFmwsU+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
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
> graphics version 3510.
>
> v2: Update "Wa" tag to align with others. Don't gate against value of
>     has_page_reclaim_hw_assist. Change the #define name to match GuC
>     specs. (Gustavo).
>
> Assisted-by: LLM
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> ---
>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
>  drivers/gpu/drm/xe/xe_guc_ads.c       | 5 +++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> index 4bcdc1a96785..4103de0b1c97 100644
> --- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> @@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
>  	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>  	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>  	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
> +	GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT					= 0x9012,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index c3ce3c8c905a..1927b595ad67 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -389,6 +389,11 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
>  		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
>  				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
>  
> +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */

I would drop this comment. Either way,

Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>

> +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78))
> +		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
> +				 GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT);
> +
>  	/*
>  	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
>  	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index 61aa50a63764..fde91192bd46 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -78,3 +78,4 @@
>  		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
>  16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
>  14028709524	GRAPHICS_VERSION(3510)
> +14028250015	GRAPHICS_VERSION(3510)
>
> base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2
> -- 
> 2.43.0
