Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1D4C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 03:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D6310EE25;
	Wed, 12 Aug 2026 03:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NyK9hGnb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1827610EE1C;
 Wed, 12 Aug 2026 03:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786506949; x=1818042949;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XUkYw5S4kgmzRcU6HyWaSZWoS6BMee8Gv+VyaHGuWc4=;
 b=NyK9hGnbtOTGvlhXPz77TbLa94Qt2zE7/Drl4jK5XOKbcGqC9ZJYfXOI
 hvLHwu3M3F2V9B1fdcNjyRG/grPoWFpF+20bXTns1CAAJerz5lq2xRlJg
 NJXoN4hSUyIoqQozIFQzXEHJ9SxFT+3T5bsz3w+kiM+CSx/a/A8DD+/RD
 oHMIAfpPs/h8igJqhE2TdfOd+//DmZo0aGotApdCQQkfOPujNDmEVKSzL
 sBj+79KtjtsXWkmiXla2JAeTMN1aHols0dkW7V/WVPB8CO4DbkcRAX8Wi
 91C4ZoHfBVG+SRVuIU4Dd+A3HZIzpTdp4DdoUM/5lsPjbfHcURBBtojDZ g==;
X-CSE-ConnectionGUID: MSBdhI1eQFKfSkLn4mTOIQ==
X-CSE-MsgGUID: NetCKOP8RYSDryh2MPoXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98408525"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="98408525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 20:55:48 -0700
X-CSE-ConnectionGUID: lRTTqxrbQiit3Qqej0uQcg==
X-CSE-MsgGUID: tS++upbySAe2Mdwqwya0pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="257327365"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 20:55:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 20:55:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 20:55:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 20:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRao2jh7sVzW7ny9mxXb9kqQrM5KNxT91DGSvitp0Bas7dnYn8qu4EbGKreZpZfmjNnbQqK7mvBXmjELDbGMwS8Um+49S05FOpXKr85aW3XmPYZH5/2/P/PqMcvgk7QNofxl//YmXpUA0S8tv/nFoaiOXb/eXFcRb7ffu9UcyL/dZZMCIV7e9F6akvQf+uGgaalfwwPH6DNo/qKpOtK/WCzIvCqrjyhmQWoJXgL6nyN4zeS/+m6kpKTpWEHk+C1owI0jBJZeNdYLxhdo4e0nxI2+omueReZVt2jSsKU4rUGibIaAFp1+cbAXyCK96hKvcljeilV0HWvWuVdTs/VjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtjswVrUDFv0gKbrSNwYnF8kHh4eJEt65NfyEfUoIWA=;
 b=nj09kV7izadQs1XsTEEJmrdAusieUlrpTSZgWZZJ9x2VClYOelGUKB1PPUmyJY/uEzCU49LDwOGu4TFNuuYsAIkWHT5hHAnBNAwTDJQu0X8EIJKzi5mZ9q37CMh6Lqw99HMbucy8hw3PcxdrbqVMK9kxqAYpYnpSZ2I4MbmuLurZiHEQNxvrVbZdtqeachS0JVsEigi3+/5F7o9vDxTH42FOR/VAhN4d9FlQS/4skhMHJDQJOLNANZhY/mI0U1hfbc5Hn23V2agL+YjgeceM1TgSWbrfCoeMH3jz69NfpfBx7ElRfJdtuBrL0wiQwKZKtkUXYj4kCz8tlyQx8WOvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 03:55:36 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 03:55:36 +0000
Message-ID: <c784f78d-2cb3-498a-a8a5-c1ea317999d1@intel.com>
Date: Wed, 12 Aug 2026 09:25:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/dp: Add EDP_20 rev definition
To: Suraj Kandpal <suraj.kandpal@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>
CC: <jani.nikula@intel.com>
References: <20260804054806.1110078-1-suraj.kandpal@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260804054806.1110078-1-suraj.kandpal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0311.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::6) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2aaea2-ed68-4b23-0743-08def82590f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +/ndUkGivkUFJfZtoLoRt5+1nLia5jziMlRt7Kr93QVIij/QI4ZtZrquEMeOTfM7R6YL5mAYRTqhxnQNwtBHoUrZq+EY2vwZzs+/gy24P3pu6fhAR//H0DDktZVsUiMtqINhXM0+2jr51PJxKb2dTb0CapG1mdNSkmjtJNtVV+H8Xiyv3xE+RTofF/qR7Xlo1R4z/iNGQcsgdnxWIAFeSXYdyz/zh7xL43u+enq9Mp6c6Y5oqoNtZRTqJJeSwQLGHCnGYvLe0sfzqlz8jK1ZngHmjFeZBG4VnvNt7qy6rwlNMGSc/GYnp6H3EjtQMvU5kFGUt9uPY5wxYsOECQR3jN1b65FrFcom0h2F7Ee/F7prpXL+ZBKV7alJjwsTkdyRpXPRe/3JkiJnRHzHImhWtU3K3grUlfToYP6LcE4A8LdhQceBhrhMRzMJNMgGR2fFFmZ1/9Um9WqtokxLFKHlDLNbaHYefFJGRW6yWKcEkFEIGeex1lR1wk+sM9CDLU6QqSDoP42ML0PEXs9rBEntNqDzx6UE7kmwTyR+5n46XptoXjrnMCc3Q7kWL6o8mv+1QVwlelhPpebijatQGNL4rWAXx+4ke/z3aZmKFgz3WXsY9uSEogjqAzRHyYrKORfniAvRHhfE4+snEyyrPDmUFWOff1EQmd1HREe0W9bo/Ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB7554.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTROQlVzREpnSm1VNGh2WHlsUk5mUm1ub0pMcGhTTXhHMzhaTzJVeTlSbHlO?=
 =?utf-8?B?bFIydk56dzhBV00wMWU3WXdUcE9XTitRMnhaQUVBYXl2eW1xT2QyZm91Und6?=
 =?utf-8?B?VWc2aklQT0V1VE4vUVJwMXcxSFFpRSs5NDYrUzFOVHJndk1MQ2VLQys1eXdV?=
 =?utf-8?B?TTFYRGtzb0V1dE9JcDlJa1ZpbXJuMmVNbTJNRWJiM01rankwTUpOQnFIcTlD?=
 =?utf-8?B?TTkybTFNcUJDVGVmL1RROGFoclprNFdQYmlvZTlLU29PK1Y0NUd5SnkzRE5Y?=
 =?utf-8?B?eXBuUkFzVFp1cUhqY05xbjU2UXpFa0ZWcGdNRHczQ0hlRXZma3JGSUlZVGdq?=
 =?utf-8?B?V2VraUFJNWRmakU3Z2xKT0htcEpzTGNLUEZNYUpnR09yMFRqQ0xTUW1wTjhS?=
 =?utf-8?B?TkdKTjhEbWs3RlMrN1Vndzg1TlJub2pmRHBEWTBZVEhjVXhEY0lYWTlVWmdo?=
 =?utf-8?B?OUJUaVRZSEd6Tzd3S2hWVkFsYjZWYjVUV0hXM3RWdmh5UUdhNTk2bWR3ZkJC?=
 =?utf-8?B?a3lTZEJyYVhEZzZFQ1QyTGRUM1p5QnBWVkNNZUVLR2tYNWhaZmJqSXJpWGtJ?=
 =?utf-8?B?WDJQOHJHSkZsTUtJQnBLVTdzMU5xYm9CYlhEemN2cTJoOXM0UUxPa1pZUk1L?=
 =?utf-8?B?RitSeEN2V0lNZ0Q1OFZVWk1RbUlPbHFIMFNwNEMxZm8xTGE4UDVtZURWN2tp?=
 =?utf-8?B?T1lqc1R6TXZET0d2ak5xVWdOTWZrYVFwZFdKeW9sWnA2RzFCTHhyREVZbFZa?=
 =?utf-8?B?by9QbHcvT0VoaVdDTFBqU0I0czBRbFYxOHpJMG9NTzQ5Wnp5czRJNytneDI5?=
 =?utf-8?B?R3lCRUw1WVV5aklmYjVEbHdBQ1RMWDZUcUhjZmUzNEN0UUwyeFZacnc4MVNS?=
 =?utf-8?B?WkZVYlFSREI2NnIyWExhcHorWTZrY0RhaFR4TjJNMTB5SWo1SXgyb1U4R09y?=
 =?utf-8?B?WnRLcmhJOVVuVUpZZXFzMlcwd3NDM2pIZjlZWlMxMlZMRGlaZmQxY3BmbHNM?=
 =?utf-8?B?S0ZmOXowUWdSS096N3grRXc0RUpzckgxRHZvNFBvUUorTTU0R2JEazg4a3Rt?=
 =?utf-8?B?SkY0SFpBWWl3aThsNkNTNFFNOFB2bWx2SkdIWkVvMTdycGhIamFkcnhYZnc0?=
 =?utf-8?B?bWR4dUIzVzh4cVAvZ0dER013b3NKbXdGd2dOZHdlWW5YMjl4UXFySCt4VFZ2?=
 =?utf-8?B?aEgwdXZwcEc4ZUgrbWNTY3RxUkJwbnBKbklQbmlxbXY0WWVDdVZZNTdJdUYv?=
 =?utf-8?B?WW1qM3pZQ0hiOHNSVWhrNWUyVTRpRm5VTEFoRVhhU2p2cTBGOFA2NVJKNnJF?=
 =?utf-8?B?RjhIQ3JHSkFEcnN5SG1KQmNSNEtNbU1sZmNoVWg2cHIySUY0SkRCKzVLbHVl?=
 =?utf-8?B?cjQyVDdScWFJNVVqTGhBbERldkJ3Yk1DQWxXWWNIbmk0UTBHMnhGZmIrV3FO?=
 =?utf-8?B?eVU1bjhSVktMaGNtOWl6ZGVONkM1c1d0U2JidnRKdThwMG5lbXFPS2xidk9w?=
 =?utf-8?B?SFM4MjJIR3Y4S0tXdDVLZXNvcnFXY2diQStpbjg4M0xIR21WUmNLRUt6SkU0?=
 =?utf-8?B?Nys5R2lSMUZMR29nQlU1ek45NTdZc0Q5MEdBVmRycERjekR3NzJQL3NBWklI?=
 =?utf-8?B?anJUckxpSzU4Q2RtRnV2a01WbW94MWVjeXRNLzVvYXduOE1rU2JXbkJwNm1Y?=
 =?utf-8?B?ZUV5YXprektDeWRJM2RLWkhQeTZOb2Y2NndnYW4wZ0srRjZidlNMajU5WVVl?=
 =?utf-8?B?NERHTmkwR3RKeU1SYnVTTXM4bkMwV2dIejhzVEpqVTBtZEQzRzY0RDhreVZP?=
 =?utf-8?B?UmNZTFZHYVcvMHJqeGNRcWdvWE9mWE1qTmFGaEdNd1h2bXdKdVpWaHZBbGsx?=
 =?utf-8?B?UHc1cXZIVVY0S0JWOFFsaktYNXZEWDN5dUhVUWc2OWo4aitZaVVIR3hzWWxr?=
 =?utf-8?B?dnhHK2ErNFlwMXV0b0lIYVVqOHdVclVIa1dMdDR0WnZ3OTBKVE9qODRRUHVj?=
 =?utf-8?B?RjBibm9NR1Y4Y0hHVloxUWNDdW5pWk1YS0VSNzA4U1loNXp6aXcyTXlFekdn?=
 =?utf-8?B?YXZEYWZ5WGhqZHVuOWpRK2ZQWmZSV3hCTUxETGl4VndScVZHS211L20xekVu?=
 =?utf-8?B?YVo1eVZBcDZjbUxzUUJxTm4zVEdTOXR4UHprK0QyMk1CZHpmcTRINmF0eGwz?=
 =?utf-8?B?eTZyVUswV2pQSG1LOUdyUmdSY1VSbEhhWDZLYUl0b25kM29jUU1ZZmtJMnR4?=
 =?utf-8?B?d0ZYa0NBZllIdG4rOEw2RE8yRm1xalR4TllCT3gwb2lQVDlxT0hxT0Y3VnAx?=
 =?utf-8?B?MmpsYm5BWEJidk9LZmtyY2RHVXJUYlhJUEN1MlVaL0h1UGtjWUtndmJjdGlV?=
 =?utf-8?Q?ohkWxIL766UzEXi8=3D?=
X-Exchange-RoutingPolicyChecked: cHCRz+mr4K/+iXFt29P773uc5YiqHt0HpncVOWb79R9PrN/P1NQcnQaxX8tb736AVJ+ITZljgw2zW5w8f99nIz6MzzC8NZ26AGOkxzzwAExWzeTDBeU+bndHbq/X3/GpUqMi4T8a1nR3nrOymqrIwDwYzY6CqyNjl+n4pwMSnTqYsFwrBxwu6JK1MH51Gsroyc+mP2vYhoxfUnaS1B4S9Q99/3XXbWibuzvLgZAPo1NOj0cWhOAq3GGrVDtaGseJKCj1gErlB7MsqTRIc+tDy2lPv2VIGccp3S8dCy1GzGWC5KbnEjh1qDTn7svg5s51aRKN+dAVloyMwGOmMAPDGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2aaea2-ed68-4b23-0743-08def82590f0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 03:55:36.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn0ZKtU9grPm2CWxIt2lngjQMgOLQFskD6KXW7/xNKu7VlwqgaevnjtRqplqsS8s/vp1OVTQ7dLTq8e1oWuoTV+IxEFVWLN8aeLIfV5RG+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
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


On 8/4/2026 11:18 AM, Suraj Kandpal wrote:
> Add EDP_20 DPCD revision definition.
>
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>   include/drm/display/drm_dp.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 8b0ca36083dd..e63c7f075f54 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1035,6 +1035,7 @@
>   # define DP_EDP_14a                         0x04    /* eDP 1.4a */
>   # define DP_EDP_14b                         0x05    /* eDP 1.4b */
>   # define DP_EDP_15			    0x06    /* eDP 1.5 */
> +# define DP_EDP_20			    0x07    /* eDP 2.0 */


Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

>   
>   #define DP_EDP_GENERAL_CAP_1		    0x701
>   # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
