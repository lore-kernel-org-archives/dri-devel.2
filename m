Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC75C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9660710E7C0;
	Mon, 20 Jul 2026 07:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P8y1O3OM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4326D10E7AF;
 Mon, 20 Jul 2026 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784533621; x=1816069621;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/W7FzbT+hn+9wnLY4gqhxRsog29XEekZvm/eE08oV8E=;
 b=P8y1O3OMr3ipsTMVD+KeqksAA0ibZfHaGa1pLSF3e0ixJ+gE6k39vrkO
 4ghKVU2Bzi6Zks414vIshTIQ3CzwN1xqixYFF6LEMB10oP4koRGWV1S3K
 BNhkE8fuMkRu6z2vRBKF9mtDCKP4Uk25jJi03IqDOGrbpVJOf2fvwblDU
 r/L6ejx62NXPPLgPQ1y6y/OlJI9Kseow32XpTT+kVm3ACFY+QmLXt+S8F
 NB8M8E1naXpnoOm3w/eVecOtSovUl7k2QVQMoEucIjjiXHOB3kIjMR+Bt
 /QvGkJnWEcaUkFmeoJdfmfGbB/iQelSiOH6SZ4/FKp0lr7mjyl8mjNJeR g==;
X-CSE-ConnectionGUID: L6+B0h8NTe2g3SippQlpSw==
X-CSE-MsgGUID: wBbc2OrDQOCepbsMIB1ABw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84231502"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="84231502"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:47:01 -0700
X-CSE-ConnectionGUID: CQT796KvSuWLFju8qzaDSg==
X-CSE-MsgGUID: WP1zSBVdQMSLhPS9kozQgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="251040360"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:47:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:47:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:47:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0b3ywum7oKAeFPzZ1UyoGXLYciDsMeCNPWP4/30jOJCB4Ivoe07fQ1+gox09MBKQzyZlA7WlzvoHPQZBhZSSfElHu1Zg0haVzuZ6ij48Wlas1inDFfLtH5jbRsF84P5P9+sFf4lW/QcUd9J9J/cRXmkl8ZV3EgcTRGGy+bSGayQwVTqQOYvJc5z27mtAbXQRAczq1L+0l3kwdwDk1g/WLNQtdLljW1LfPqEAS0pmnNikE/IO1Ang28leZbl6YFi+g6Oj/K9qoPUhTLUVW264mBUPeyxUJ48EXz2NSeL+XFmDpVs8t5eds13a7gkIrTpfasJ7HP2+i94dVKARdUPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mumfo8rmVo6zs+janiZK58QNNg9BvpbJufKlZicHs0=;
 b=fGA+aluwleHfYJRv/WLNEjY8YrOuWqRJZi7zKUV9aUKEMX/m/RuLmoat7ZH+4Im1IK0GeWpn2/xoMATCmiPJdUibeQhDLeCZxHq/FYXEoz3pWFHYR7khxSwM7XrdRPMA/3SoWOBn9Pc+JeUITPhwaCWOuizOOUpFe1pfB3nqxHK5jzCwfMszHb49j0HeSsgve2DWVNZrRhRvKseNDZVJsFSAiGMRHntFA/31eEeJib99sJFq5Sd90Sxs77BkenvG9d5YeKwVjVYm8LaG02ES5hdK2RNtYZ8OTFVu2wNf9MCBnEFDKA196u6z8ngIrFH9/SMx2obfFGg3R4qCyMD7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SJ5PPF57F27BA08.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:46:52 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 07:46:52 +0000
Date: Mon, 20 Jul 2026 07:46:41 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, =?utf-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 2/5] iommu/dma: Catch scatterlist length overflows
Message-ID: <4nqoxr2shgvpd6ury7ko5amnkap6nimds353ahho2jggdkk2f3@uniz2nufegkm>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-3-krzysztof.karas@intel.com>
 <0e5120ea-8851-41e2-b3b0-021fb35f61b7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <0e5120ea-8851-41e2-b3b0-021fb35f61b7@arm.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SJ5PPF57F27BA08:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c2d150-7588-425b-f91b-08dee6331058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 2KZgud6+C4EzhbgircElgPrDkfUKAPx8Je4Tml6uhQ2Jq1I7pAUjfoiANcKtlj6lWu4C/RgJU663R4L5kP1wVzJndNKMVvrES15nZ//DtQ4cusmQ6zSPbtUR0SPTabSwP3VaVxYEnAlSsFG8ob4ydNvi9h/0KfC5Y4WxyBCT899OeTP9AMb3d+5OhojZYGv8krAXwJmjHLLAGYB2eFDyxxW6VSKkYAMPrzbP2R5rVoEtg3L4LVpKpPj2hx8Zh0j/aSIH9e5xKlVWQubz7bqiT6I27SBpDdbPS6USBkKoVJbG2/d8Uu0lmidd773ScLkquW8FQ/KUuu56PpUi8GpibsYtAmTVSwcnIufwc3bP98EPtIFlggUr9Zr/K88OHESul/c0kyqrl4XH6KhufaJNVCOg35Ma0vux+fCBIGaSJTUUevqgbP+B4URxrmpt17NFA4txkiGq0J2HGsUABMobs7eKqEnbO0p9tNvGzgg9CDB3q657dWnGHKce9g6sfFvACgltffiTJZUcEcRxnjlAFVkWxdBC2gt1MdUchYmY/aF8o1gjrvcr2/sXm3AjD2AmIVMtkiZcVdXALIYVUnQ7mJmbfh7RuZfOYpUgs8gKcd5ToywI7VeT79zQoJz8HaK3uWwUfgJWZC3zakTN78/yQHB+O+v3b8EWmBWn6boRxxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VVRk5KQTFQeTgwSlRkd2xXMVB3bXhpZjFXQlh3MFdwSVcyTG5XWEE5dGV3?=
 =?utf-8?B?eTB6SkZ3QTRwbW9YUXJxRGNjdHMvRDhaZmYxWVowMjR4OTFCQ3c2WjE5TmhV?=
 =?utf-8?B?L0Z1eTBVSGQrbDFtU244QmVjUTBiYUFuR0tSdlp2dDI2L1NvZUR5MzlwcCty?=
 =?utf-8?B?RklOOW1DeWdZWjd6Y2UrengvNnJVRTlneXJCazllUHdsbXlFWTRQZXM1NGl4?=
 =?utf-8?B?dXhDbFYybE1NVG9SVmlRVXo3YUhTcXFsd0RIczZkVjB5SjZOSFl5eDlDUCt0?=
 =?utf-8?B?b2RMc09CK25MbEJyclJrZW93alduV29GeXpQNXY1blZRamNzZEZ0R0RES3Er?=
 =?utf-8?B?QUNpRWhaU3RlRE43ZkgrM1UyakVIcGEwZUpCVkpUeTQzeWFkNjFXZDVoV010?=
 =?utf-8?B?eG1ycFB5UndWZk5lMG1HWFhPc3ZYWGphUVkrUEowRE96YStyNVJrRWNUSFZt?=
 =?utf-8?B?U1RYRmtGR2pIQlJ4cjBJWDFTMzNrWVk0SjdoYit3S3RRSk1RTEhnbTVYZUFZ?=
 =?utf-8?B?bzVFdGg3TUFmM20vdWhudjUrMU9DcjcvQWFBMEVVUHJ4YVM4Y0cvbTRMbmw4?=
 =?utf-8?B?cXlXcm4rY2F2VThWT2lUWTRTVkVrZUE4ZURnZW85RHFQMnlDYUlqSkpvb2t4?=
 =?utf-8?B?TGdwZWV5S1Y5UHU2VmJGOWkrLzNNMHMzenVLRTVVRU9MenlTV3B6ZVlJdEhI?=
 =?utf-8?B?WDNiOWpaZXYwT2xDRnRsVEdrL0JhbDhHendQRzlxczZQVVBwWkZXMEFUQ1J0?=
 =?utf-8?B?cHNvN1MrKzBRaElEaVNPK1p3MldXVWhMNHBvdVd6S1JJRGcxdTZmQ1gyNkl2?=
 =?utf-8?B?M0g4TEdPdmdiMmJ3YWRsVktTcHFwUi9CUEoxUlpLZnlVZnpOVVFLaTFSQ0oy?=
 =?utf-8?B?aTE4V0tkRFQvZlIzazdlb3NKVWFQeng4dGdkeUJjMlJsMm1pYmFaNjdVeWYv?=
 =?utf-8?B?YXRyaHhOcU5HTFpYSEd6cXpndHU4T1JBMEZFT2o3a3BFT3pqYWhzNmkxbmlR?=
 =?utf-8?B?bFl0eEJiRVIwdTZzaW1iQ2RLckR2TzFoVjlRSjJiZU5ra2JhNU15NmxZbmxt?=
 =?utf-8?B?K3l3WmYwR21iVVpSTzIwVEcwRnE2QTJtR3lWUDEzYXFqNW13akNLYjhZYWRs?=
 =?utf-8?B?K0FPUW42RlNub3UrWDUvT3praTIvdkdOMDJVeXA3ak9vYndpS0hXTnVEQmJk?=
 =?utf-8?B?cVZIdWE0ZnZuQmNVY3phQXZDeVl6R0U0SzF2L0V3WHIxSDAzVnhTelRjSGNn?=
 =?utf-8?B?djNNWnFPdENEU3pJbTluTEFpbE8rYjlZM1VoelpaYkhpeWtoNVJsRm5BZE5P?=
 =?utf-8?B?b1VJVE9SU2Y4akVBM3lQeDY4SWszQ2hCb1YweFk0L1lSN2ZCdE9lOG9keTla?=
 =?utf-8?B?c1l3RW1ESDAvVCs5N3p5dm9IWWFmY0IzTE1zQjVrMHZOR2lHNkk0ZFdYYWhH?=
 =?utf-8?B?Q3BkK3I3VGpKekdWSVgzcTh3S0wrczhzbDhVRkdIV2pTWjVjRStPL0xKMVhP?=
 =?utf-8?B?WnhFa0dHVzJYQ3A4a2k3bkovbERIVkZiU3dVbFJpYXczNDdtVERSWUI3aWpC?=
 =?utf-8?B?OG5KbTNKRmFnQVYrYnBCUEJQb0NEelhucjRKOWpIMHV6cmJGNy8xc3FGaVJJ?=
 =?utf-8?B?cDlFOTdHZnRqOTd3M3JLWGYva05pay9QYTVTZVNoL3NFWW5VbWF1RWNIZStY?=
 =?utf-8?B?cTNqaWQwUDJ3dnJqaE8zUTdmOHlWVTAweUE0SXdZdTBSQmFTN0cwU244c2Vo?=
 =?utf-8?B?cld5Wm9XZmV4RUlrRnVaWHQ0SVBScjNON3E0NCtwSzQvNDdBMEpPVmRLc0hI?=
 =?utf-8?B?ZE8xNnNHZkRzTXZ0K0pHS2ZvaHpCY3Izd1JsZ2l1KzRaTTlkaEdzNjFMQ0oz?=
 =?utf-8?B?MGVKbGJkdHMreGtVcE9lT2c5R3dkSERPaDhjanU2WUhrdDN1UG52WjZ5LzhP?=
 =?utf-8?B?blR4V2trVE5KR25yQ1VQTUEvcEEycTMvTFRjUEFsSGZ2OVE3Y1Q0bXg3aGdy?=
 =?utf-8?B?ay9sV3JPM0RkV09XK3lNMk55N2cyNm93cGk0VVlWK3JCS1IyL1ZaZGUxL0pj?=
 =?utf-8?B?aWlkQUxlY0ZPTldNeDMwK3EvanNJbTVuUVdhUzh6WGtBSnZxaWhneWlRRjVy?=
 =?utf-8?B?NTBMMHY1YXJpaHlyTmZuRlo2cUtKSnZrOEZKN29uNlYwUmVuNE9DRFc5SWs1?=
 =?utf-8?B?SnJoc2VDMVlkcnp4SFhlNm1QOGo0NHVXSCtXeEdWU0V0M3BkOTI5ajIzbFVJ?=
 =?utf-8?B?cFRhSGRBY2pJcDlhajFZcm53cmxYVjBKdFlZMi9Mc1Y3dlRkUlh2OVZZU2Rs?=
 =?utf-8?B?L1hKSW5ZSVpUTG1yRVlXSXQzSlpvbXphb0UwaWkvNW5hRVBTeVBpUUhMeUNF?=
 =?utf-8?Q?zC1VuCCWv17GjV3w=3D?=
X-Exchange-RoutingPolicyChecked: Mmn5yRn9tYScFzcy8V3/7CdIjL79Ubru5ilHbQHjNllnpRavBSD+h71r3TmkiVBhPwm0Wst9dj4V4Pq5NMJT/J8v7VQ8OeUb/+FsBHQuDbU2lQD07kZ5Dzpm6lYATCXKMb0eVasqCCgPLjrbvUC6QwPtvcZB++UCBYvMZaU08qF34afZprLKHnFT6X60MUuv9bTu16cU+qUz+82TgFSCST6k8FGj8tOE4HeI1EeiarNZqjf6tDGrOf0/bE3uYDCLdtyk7IG8RqVXeOvJqNqMCsoIcdg1Ph7pnvoU5qO733kJ5UECfwWbuS/PySwvbHsvedZdZ5JjOrblgyjIer5gAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2d150-7588-425b-f91b-08dee6331058
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:46:52.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaVu9Dxo0VmKjlKeXy1KFWkZINL9BOOPmX8qHx79+wW9AOOwfs77RZPhKOkDaxssa901g+hQnjnEWmQFn/5hlhF8Dqsl1+twBjxdn4Aqj5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF57F27BA08
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

Hi Robin,

On 2026-07-16 at 14:48:25 +0100, Robin Murphy wrote:
> On 13/07/2026 10:58 am, Krzysztof Karas wrote:
> > It is possible, when a very large mapping uses only one
> > scatterlist, that padding overflows scatterlist's length field.
> > This results in:
> >   1) silently wrapping the value
> >   2) smaller than desired mappings produced by iommu_map_sg
> >   3) leaving mapped bytes in memory (no iommu_unmap)
> > 
> > Address this issue by adding overflow detection for scatterlist
> > length field.
> > 
> > Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> > v3:
> >   * Used check_add_overflow suggested by Jason.
> > 
> > I decided not to include previous r-bs due to the change in the
> > core of this patch: overflows_type -> check_add_overflow and I
> > obvserved some folks have heavy preference for one or the other.
> > 
> >   drivers/iommu/dma-iommu.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 381b60d9e7ce..1a36fd9bf10b 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1493,7 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >   		 *   time through here (i.e. before it has a meaningful value).
> >   		 */
> 
> Sorry to be a pain,
Don't be! I'm glad you got some time to look at this again and
being a pain is what gives us quality code.

> but since we *have* now spent the time reasoning through
> the details, for completeness I think it would be worth also explicitly
> checking "s_length & UINT_MAX != 0" (or equivalent) after the the prior
> iova_align() - since that's only rounding up an unsigned int value to a
> power of 2 it can't arbitrarily overflow like the addition below, but it
> could still wrap to zero in the assignment to s->length, or indeed in the
> size_t itself on 32-bit.
> 
> >   		if (pad_len && pad_len < s_length - 1) {
> > -			prev->length += pad_len;
> > +			unsigned int new_pad_len;
> 
> Super-nit: "pad_len" is the amount of potential padding from the end of the
> previous segment up to the next segment boundary; the value we're
> calculating here is the updated *total* segment length, so "new_prev_len"
> would be more accurate and a bit clearer - the logic here is fiddly enough
> as it is, so every little helps :)
Both suggestions sound reasonable, I'll include them in the next
version then.
> 
> With those tweaks (since it sounds like there's still another respin or two
> to go for the rest of the series anyway),
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Thanks!

-- 
Best Regards,
Krzysztof
