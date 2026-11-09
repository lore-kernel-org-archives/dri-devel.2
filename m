Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6B606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PEvvZ7EP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D84E10E2B0;
	Mon,  9 Nov 2026 15:38:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE2E10E228;
 Mon,  9 Nov 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794238693; x=1825774693;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=eEWtW5HindTaXWIbvPsZ6I3LoFcwFBpaNMoxqc84MXE=;
 b=PEvvZ7EPrPdOlgQrkJrtoRakRTX2v0k51CQCIjH8W6CBalrxA+mjq0Qo
 2Zo1ZiDBj54Df3dXb9TjoLJ0rV3OKZPaJcxPB44FXJlMzE9mKInSmsKSF
 RvKkeIdqQXMyf8HryXFxzC7u4EOn/ygaFQjtv3XTJht0Ag1Hz1SgqUDA8
 SWAnHQW7TM5mmo8mV6hEgKbLgny/xZZ6ApidyuDA0f+dVU1Mar0FhbDrh
 lDtsfc/fwsjPv5c9OL4d/PlV3bNOJkOSdHOYydRB5lhPeQI9tA3IfOIIo
 QsyuwALH7rerN1elXp8ba2RLXWKfwKqJf2kZRp7pQChTCZnj0P9FYVj3u g==;
X-CSE-ConnectionGUID: LOBxHgORQeav5RsGu7DPBA==
X-CSE-MsgGUID: 3Evx3yG4TOi2cgp0ZWkViQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2860930"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2860930"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:38:12 -0800
X-CSE-ConnectionGUID: gK4wLdG0RQ+zky/S1SZSPw==
X-CSE-MsgGUID: ROhsayDVT0CGg7G07G94Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7760361"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:38:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:38:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 07:38:11 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 07:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY4VOoMEvi1INZGBBPkTLUiS0HuiZFPTZoLsNBsw4LhcpoZJOJzG77Dy+JaT/KJYnQaSUePun/5tR60JFk4kB4aClGd/iuR4lfWQA6JgM3UEjpeaHdVlYN+0dzDBL+xk2PSF0Hz+jupk3y8ApCrbTrZ7hNfwibzkQ3cOR5z1A0w3AesHNO3p5PspOaSE3+oFe9kDGyOzngAFHzDzsrZHyL+rxHvkQ1x3i6kfYq++3crY+4YTtRsbBkJCKgT774RjzOtAJ/vFQ7RaYc8iYcGywdM/SFU/D+xNQ6WFGX0eEYnocISW9cV8roC2xntAfldTzj4KtqHDfPnt4FfZpRyEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpnxHvO7lWDBXHS59g5MDypm0MyOV4eVnD6tnYN6Ixc=;
 b=kZDT1+Hrm0q1RKr6ja2rNy85wkuUg9K+sbHB6/TRIQ7Ozh58NmhwyIkH9jvenF0x6EjzGCjCvmcnlae2i+0JFMGrPGnBdE5eRnzIFIEGD+jlmS0AbN6FeXJtx6SwE3tXIuuUD89utUznQr4ZmM4siHrZW7avJZ9+5UlZQFWDa82yLf3s43SEWvM6ebltyDDm0tmOIlAm8Rb0s/HyjsSfD9cLXH+IgpyP9RysKhYrYjUyVU8+clO1EHnvuSRfU3VVpfEJEPR9DLaITrBWfI0S25N2RAqytmDJ8Mn/u7zd9VbuSwHuSiAVs2K5YR0MXLRChQfR1/sAwZsZJh8BaxbzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:38:09 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::770b:7229:68c0:5ded%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:38:09 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <dri-devel@lists.freedesktop.org>, Daniele Ceraolo Spurio
 <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/1] drm/xe: Add support for Wa_14028250015
In-Reply-To: <87tslxpivm.fsf@intel.com>
References: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
 <87tslxpivm.fsf@intel.com>
Date: Mon, 9 Nov 2026 12:38:04 -0300
Message-ID: <877bim2exv.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: db039356-d6fc-481c-88c5-08df3e77748c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|260925022911599003|260925021311599003|260925021911599003|11063799006|4143699003|56012099006|261021121427099003|261022113327099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w6aLZDoLjww8WJ3izFs78Q9fgW4UQSLUuyAfG2ldJwB7w8DbDNFCVTW/eBabGkGfeizZ/4QEXW1yOo5cceKKZi/hMtPqMwfokkSOOPHbsLU88geChmnlbt9/T3mCm8GpADBQXCBHqA6mWkViF/EF8kldO9/jXror3zuk8Ehfmyulzc1tcAAI8NtPytrPz96D4YNsRbOKj2G+Ux6w8oOwMp1dT6VdiFAHWUrJpHOTp/uQ+AosI+DrJ8dhRtMLWu3TcPk4Ad+I3vBgaagA+jn/eg2F+T8lX6WBaYKS+TkC8aFYUpVZkKaXWx4gH127rcCLgxCyZGDYmgBCPnamNVSlMMZVwFSoA6Nk/lf2JZ9TCJiDWC2/Yem1ez4RGzJHHLWeiPAYCQL6mbw+NDjwYPC9ufE0qPSDoFxXji1giBfriBlXHwMpZlH9VioNkIXFKxcUtake/wsMI4QWokn4UZWXPHSm1QOzWUDVMl7K/OGBLj4Fz827mQdswt+5RJOj6rj2P1Y9NDvSLlztWpVDalBifkOdqiNFAasZ3ELNVkxenJKs7XR53OnOXgN/RRhuoptx6bm1tY+XCeT+x/hiKbKIinhKqwT8AEseWLu35pbt2VFygMu2k7sS1D49yZzus7QQnKD5zd80ZjjZ46rGViHti/KkH68mvg81I0KXShITBfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5095.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5P1NsJRJIjA75TsO7pdmdDphIKHChkA/ogwIj/FD3bBEDnErdadgIZ/2tKvC?=
 =?us-ascii?Q?IMuA98ThKPbfSwEGOEx0O1ITo2RqzIPBVh7u+rsmzEUehCcgZ4V0ByeKzqwg?=
 =?us-ascii?Q?pSzNG3bsYXfa9kf7Y/8pqznZLvXtTK/TcOCPFL0dPJ6q5jWzBDWVZ10N/kky?=
 =?us-ascii?Q?UDAmXSEAAC8OPDIoNjeRFMwiP/3aW7E3b7GSbd+P2kTVO4VGduZl/QkFOpXy?=
 =?us-ascii?Q?Z3rppiaBVm7Bh6NFOTJu12OUuopMOcs0/f7LzKIQJNuWQxXibRnZQCB18/1V?=
 =?us-ascii?Q?bMIrLDIOvqcUBu5TZFiJa9h1CuMs9s83xo8CM3PYR7bNgNO4zwkcen1cCtwb?=
 =?us-ascii?Q?9VUOlZLUQYVbD/Ohdp5Z35wnTfk0VV8V+lNvHdVuzz4tFe/chm4wYMDa56YJ?=
 =?us-ascii?Q?JFu0ZWMewhOIA8tWZv99UrMMfKqwdq5qoHK1zkCnFOhxrUiq9v712qtpH7R4?=
 =?us-ascii?Q?1TAPYWxBV83MEnLntiOrfz8MTHYh32HsPz18ys3khCl/UliPm00GDCg+2Xqh?=
 =?us-ascii?Q?zbd3h9iPnekTt7zrl660YQFiaRpeAjvn/+WC5ZQBcY/rL2mo9DzofVhoxkCS?=
 =?us-ascii?Q?35k2jYOurgeJPNImGhe6IBpt5dq+jgs+F8UbZpxNx2bGN0wh9CeEEwPaDLxC?=
 =?us-ascii?Q?IFQV5WS5xHDYEuLBTKEuldprvHsvOpIj1m2UFeOy8xKusyvWVLbjxHKnRXP0?=
 =?us-ascii?Q?eZlBjvQggK8b4Q7ndkIkoIUlKXTPJEFVVFb2h/2NPi2wVsIOpeJvqdTyL927?=
 =?us-ascii?Q?ySuAcHQu/aRdMFMDq+WT+M8+e23n7oU6A8A8gDvTiNgQFP3YyRFa4Dinl1gz?=
 =?us-ascii?Q?cUWkpumuMKAwmfe/dmjp8VxpLZVopqR4gjIEL5n3fFrayYuC0mrwF+nbpHoH?=
 =?us-ascii?Q?YpdiEtMtiR+2/vWDjTHC+TVkIbifKo7e9Tplklq4ikEpENsC0B0vjrYY0SAb?=
 =?us-ascii?Q?fJ3Pmb5DenJv7VCzfr7bLN+Rb7unimP87VcrV7YhFXOaPalBXvy9ZCML7W+P?=
 =?us-ascii?Q?sk6QrS/i/hbpzhpRKR7RTlzY18Qe0607h1FtgOtrkiW5cFHeSeu14+FpP9eV?=
 =?us-ascii?Q?4X9THlYzGPZD/4I78rNWU3/5VYjBXD1Yousn9P2PAIAgLCRibrnz1oeVcCz0?=
 =?us-ascii?Q?2gPYZhhh5GzPG9rNcroy2v37OgP+pV/NY4e+rUcnH19WCiqhZFoT46eUT1qj?=
 =?us-ascii?Q?vO+Ra7dKOVcPk/lcfeJ6fuGtzDbNyExDIvvizDyqFZmu0T0cU99lfBCkKuoS?=
 =?us-ascii?Q?vDnVyxOVIZpC4/0XOTC7WzQvrZN+c5ptxn8xMpNjK69R5+gXPXsglkBAIeHn?=
 =?us-ascii?Q?T+QdS+HdjA26j3KKXZzaFE195aDybWRrukz65qNIr54PS05aVOVS/o3vAAxA?=
 =?us-ascii?Q?i4KzmNa8CWraNoVPvyaZVJ33yzMctiA315jZ6ej28hWg4gTLJgkzZSz9jY6V?=
 =?us-ascii?Q?ixvIeATqNik8LV+YA/n0t3tBYNi7WfBCZWfLsVj8Rn/S8y4DQ6RvpYm1o949?=
 =?us-ascii?Q?M0PFGT/Z8TAg4ToV+X9idti7DhIjTqVdtfMaCKgXi4Cq5c8labZL4IX0CVI9?=
 =?us-ascii?Q?vRg7BW23zyl7NBXobkVw1nlYH4Oi3cgbo9GLSjno6uYCJ8fI2inwYkcTRtOU?=
 =?us-ascii?Q?Sv+DZK2vUZ0Izata8BoWrLcvtIvm1Y7qMCL8ao783ULw869pEH0CQDBpSk0Q?=
 =?us-ascii?Q?hlPZLj62pfvNvw2hKBiN+XfOs0mOMp/kNwYrLRsPl1AwgiTfZ/6nzOb0xiyP?=
 =?us-ascii?Q?ywDxZffgZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: upU8ea7haZW6Bq+yL1VTXQbgw4cJDpL1scdF8VE6agUvKFBetTR/6vhh3SuEg2KKtrjBEsMbX2fNFpZuzbPaOIoz4rGZmt3M5KgrgpmbCwig2ihaMioyTKtclIC984AO0vPsPsledFK9K8xxI6JGO07GNpqBh2tH4DpvCKKDDHWS9ZiPVQNTrOzt0ndfcCJhT5XutRS+lWy89qYrYXHR0r4dNRkRVE426mdaMRrb2bU7emO3Jk4FPv7G8nCJ7IGxfP6AaWkhggvDICueZi3y/dSlnfIlrcf+ZwFBrX4AG8i8nf3/jBQc4GrTnj2sgREu5Sz19VRl3hT7M0cgZVHozQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: db039356-d6fc-481c-88c5-08df3e77748c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:38:08.9844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDncL4xultr6gEvLAlgVGqv1Zhjw7S7j+1E1GIo+iFq1OG2/IXiFOIxEqJQpJ6NcLkh7BH9z0l0LHpBsECIn8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
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

Gustavo Sousa <gustavo.sousa@intel.com> writes:

> Alan Previn <alan.previn.teres.alexis@intel.com> writes:
>
>> The WA is implemented by the GuC, so we just need to enable it via the
>> dedicated KLV. It makes the GuC complete page reclaim requests that
>> end in an error, instead of leaving them pending. It is only needed
>> when the page reclaim HW assist is in use. This WA only applies to
>> graphics version 3510.
>>
>> v2: Update "Wa" tag to align with others. Don't gate against value of
>>     has_page_reclaim_hw_assist. Change the #define name to match GuC
>>     specs. (Gustavo).
>>
>> Assisted-by: LLM
>> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
>> ---
>>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
>>  drivers/gpu/drm/xe/xe_guc_ads.c       | 5 +++++
>>  drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
>>  3 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
>> index 4bcdc1a96785..4103de0b1c97 100644
>> --- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
>> +++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
>> @@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
>>  	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>>  	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>>  	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
>> +	GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT					= 0x9012,
>>  };
>>  
>>  /**
>> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
>> index c3ce3c8c905a..1927b595ad67 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>> @@ -389,6 +389,11 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
>>  		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
>>  				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
>>  
>> +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
>
> I would drop this comment. Either way,
>
> Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>

Applied to drm-xe-next. Thanks for the patch!

--
Gustavo Sousa

>
>> +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78))
>> +		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
>> +				 GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT);
>> +
>>  	/*
>>  	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
>>  	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
>> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
>> index 61aa50a63764..fde91192bd46 100644
>> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
>> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
>> @@ -78,3 +78,4 @@
>>  		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
>>  16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
>>  14028709524	GRAPHICS_VERSION(3510)
>> +14028250015	GRAPHICS_VERSION(3510)
>>
>> base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2
>> -- 
>> 2.43.0
