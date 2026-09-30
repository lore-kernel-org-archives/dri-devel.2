Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C585C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FE110E9E5;
	Wed, 30 Sep 2026 05:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K9mijcP/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C0810E7A0;
 Wed, 30 Sep 2026 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790747852; x=1822283852;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J2u6ttlT7vyZSC8Z0WV7OxitEODX0143kJIEf5ULLzo=;
 b=K9mijcP/88dbkVXtsQ7gNLq1m3zBcFlHU5it85aMfKpO1TARln2P4qvW
 ChXaKred5R0E/sJxUTyeUii8THHZ3dYDUwb+RwRua7/YfgebS4MBIHfgH
 f1vvR0JT3+ciex51E3uOeBWO4af0cdd9kIvWRpOcuqigYBNH5NReBPEsQ
 yrNiRkSxdmMi4cpyrvaxxRVrojQpHfYrtx1mFmZHQJ/1jwbWg6yByNU2E
 bg8vfhF3BEirDLHs9IE5QnflN2wJM8JQwpYkGQb82Cy/bPGRVoxQdLPsB
 becK6N7qps2ED6k2UDlfCb1DfXg2Jjw78FDGYdyFUuOhWJrzZAxHAO3E4 Q==;
X-CSE-ConnectionGUID: 5x71ujGAS6KYLhkE4VzD8w==
X-CSE-MsgGUID: 4srz472dQk2S/8la8L7ysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95288415"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="95288415"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 22:57:32 -0700
X-CSE-ConnectionGUID: BWSx4Wi0T/yQxMHYSvxIHQ==
X-CSE-MsgGUID: rLU2hcRgRv+qsG+VlhhaKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="305102410"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 22:57:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 22:57:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 22:57:30 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 22:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnIjZm5Y7DZ9/WsYPL2rEopo3zmI/ysDDXnEJ/UwzBATlnGvHqZuPBZrpn+tKi90nIZWWLeOs4BI3Y/9EgtrlaQsyxFvbhEBHd0laHuRV9MnKeB6pZqggJmQad8wOjL53asL9XYmF6qXVNwKfUqXsBlZlhH4LrzTAtGdsgICEazwcEq25fB18whtT1EO9A4SEmkwPvG8VV5e5vdLwnY5vDyXQOyDXUflC8jJkLhexvN2LvwCZWgmIpH2f5sVTrevJypHks5ikf3FBqVvCZ2kd/X5IBnF6fz6r01xYxAjeFooWfGwsirLfeHjQsR31n5Ukpme93VhzPqfz5HkeGeUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHwuNbhpRV5z+VbqSyeM5vj5x76rZkpoA+UbXLl38vk=;
 b=wOARgv1iDWasZqaUGtxJrHhfBJB95Yd14r9iEBUecDhqOV8MdW9sYdlSnXwMiP0hezEagMq9Mu/PmsQktHne8Q4kUYtlRs3/PK0O6GuWKY3WsJjOal+DoQX5xkeLmgu5JxFbRZeEeqn/kxOjE76fl9qDlGxkBBpjSMnsR38x93Hl0Z3kwJp4KXmOHeUo6UibzJV5yXAUv2yg6cVKYVXdMfZ2/oW2W1S+q9oJSABlcsds5tHhOm+EVA+/68pOipYslW+dp7WnNYlh+UYStw+xiO8DPLKkIjxTH7UL8mShaxS/jbQJBRyCYFDd++nR9+BAVDgjz2Dw0pBWlkGWGOsJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 05:57:28 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 05:57:28 +0000
Date: Wed, 30 Sep 2026 05:57:16 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/gem: Prevent overstepping exec array boundary
Message-ID: <5jt6zlrd7fagie3of4n72oahegwdoslaznsg273qkvsqigtids@uwgpmmrc44ox>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260911061145.3535489-1-krzysztof.karas@intel.com>
 <arxdlg12dVFOAI2P@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <arxdlg12dVFOAI2P@zenone.zhora.eu>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: c19f8840-a3c6-4aef-c0b8-08df1eb7b566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dGfpmwcZhmgD0eR9oiYGkfqzUua7eAp28BCciks3M4RnysCkrJPzP6YEqjDmWWRikx2RiSVXug4YsP9xj7qUXXoqX8M0iMc6Nb2KkHB1X/uAAWUpiwWykuTAaTioHGSRWejcWS6CbtiAlTJANA/h4qKcJazS8gMyoM/ATbopGStcswxZWB0mcj1DiAP7qc7SfZrsUe6G6qBf2MVjmRO49MvvvDW80rqCwo2Pj4iq7kY6eoXwh6QJMwujUW4rwauCUW+qzs3bxtniZ7ixiGKk6Ypu7wU6NX8rvTmgDBNIZRuKJI0BzVhwYY/SvErrGhZxhQn0eCdtaL1ITPDClRJUSDGkDVBAar5XYb3jNcBeDSCnOSAXTrtqNZn0vjNSCpGlI/GqwQHTkaRLq7g2O68rtqv93XJ3Zb5KY82/7XDTNSTGt6HHZratRqId1/gvie6ihZRnkgh5htVZ7VjTXG0NgzKkmIToNO8r1HWVQcCk8K8CEKSWeEkFZ4YgejDr4E155FlG2HWWXS2kcfnJ0fesnoHbfXTkj1GiPDLKFszTJqY+47M5McIQk2XFWsrHSeJXRckDbmlrwQGF+F3+qmv+tFcGoc11nQwRPCMBBHriPR2Xue5Vu2A1q963ZVMeGnn9y1elHBZ7YbQNPOiVo4bPTwYAvHn/FPVA3autyo0DGaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTV2WWJGUVNxOVdSblFkVW5IWjJ5UHNtQXA1Vmk1VVJTU0tvdUJQdHNyNng1?=
 =?utf-8?B?Sk9iT0k5NHkwTkIrQ0M2ZzNzd1FrRHhpUUxJeE5MeEhqMzZMNEFPdGNZeUpM?=
 =?utf-8?B?cmRoUFZHZzREMlN4ZGUyUHh2VXRwNHVmMkNuUzhlZ1pwcVJCbkU1T1pPa2c2?=
 =?utf-8?B?VjF1ejlud3JVRFNiYjg3eXBtRWxYUERlV0VDRCtRWTVnMCs1cWxVTENBYkxm?=
 =?utf-8?B?UjFXV0pxcVl0WWNKaFVyTGRETEEzRU1XZE5vbkVBalFIRldjUkRwb1FMNkUz?=
 =?utf-8?B?aEJUSFZLUmdPaFJkSTZFa1JPcGM0QjV1cVdremVIUzFlbzRFV21ZV2tzdEZj?=
 =?utf-8?B?L0pmSjVGOFk2cHdBM2VNQjZ1R3o2M2dPSlNzRllBNVJDbnBwN1ZPN0JHZWhX?=
 =?utf-8?B?NGRCa2RSWkRTWTVvY2Z4UDl4N1phbzBkVFRYYXBIVklxMy9JNEhCVVlQUHQ3?=
 =?utf-8?B?emg4aEZYT2s4NWUwbklaQjBOQlc3M0g3S25PbjY2WFJoSG9LdnFnZUpJUXRt?=
 =?utf-8?B?VEhxUWZEWm5KVFN1NjJjamVDYVg5aWt4VjhmS3ZwdjUzb1ZqU0twSGpZdVNV?=
 =?utf-8?B?V1dwK1BnY0FlM2lUNFM0MXVKWmtkbUVxMWlGeUFFZ2pHSGdNbjdpYldPNFQr?=
 =?utf-8?B?OEhQRnZDb1JxZWpLdU1KYjl2UXVBU2puNm1MbXdlZHRZS1Jrd0l4UWtnK29M?=
 =?utf-8?B?WjZjekJKMEVxRXRSazdYNUVObU9rOGJWTThCcE81Z0pKT082eHZyTmlYWDZ3?=
 =?utf-8?B?NElmbkVoNmZ3amhPT09rOStJOFl2QjJyV0g5MUYzSnRFSmZMdDJKaXpHdFdK?=
 =?utf-8?B?dkV4QVhqVWpidHJPTGVaeTU3K0RGMk1FRmlmUkRLNThGUDN0TDlKMnpkVEFm?=
 =?utf-8?B?dG8zRGR1VDIzZ3YxZWtSbElVUkxZSTFWbVEyM0tlcVo3UDJJN1ArbUI0TnN0?=
 =?utf-8?B?SE9WMjFhRktEZjdSd0VLYW9DSFMyT1VVS09LZUY4dGNXZXNOR2p4SVpUWFdu?=
 =?utf-8?B?QldOY3JlV1F0SnFIOHlyNkpLNER6RVJreTJoMlA3RXRzV1hjUU0ycmpIaUZw?=
 =?utf-8?B?aEVlRHpxSERaWmM0cXNzMFpsZmJKL04ydlpyT1VUZE1WVVgxVjIzQzhOMzVI?=
 =?utf-8?B?cS9ZSmNYRlJjVXRMSHlrMGNUZEJoYmpLMFlpb3VjNDQ2bTc2L0FEejJFSnJC?=
 =?utf-8?B?Vmxub0R5TUNUaXBDcWJ4cHFPQ1VSQ0lrbm5uTUtWNHR2cWRKOVhRbHBXSVpz?=
 =?utf-8?B?a2lSRjdIcGR2amcyU29zajFOTUN5OW85b3hsR0tEYXhLcW5BMjAyODF5TzRj?=
 =?utf-8?B?SnpuN0JRWkpISUVKb2F1Y0pWTmhxWml0ZzRyU2VvMnVkVTVZMFdSS1IwanNo?=
 =?utf-8?B?ck9JcFlFMjR4eEY5UTZZSjVlN3dJbjV1MXpnRDFKN3phOWlJSGpTWWFvbU03?=
 =?utf-8?B?SG1DVE92ZWphblNHQzV4ZXNDNnNoRnhEdk9qcS9RYXlPeHVPbnIza0trTXhG?=
 =?utf-8?B?WHBaQ0pSeXBqRTV1YlRndDZOaW4xaHFoaW9leU90blc1YnBDdG5ZdmdXYmJQ?=
 =?utf-8?B?OGRTZ2QxUGtFaHZxY0l0bGNGd0kyV2g3bXdSNEQzVUFZVUlwU281YmNQZ3Ji?=
 =?utf-8?B?a1FwY0hwaW15Sngxa3k5TGJFNTh3c3BRRFcvcjRPbXRoLzhSTlpMUkl2aEpy?=
 =?utf-8?B?RWptS3NTQ0tqc2hJZ2xBLy9KU0VhK3NGMEVPM0FFaHZYejVHK2pEbkYrb1NT?=
 =?utf-8?B?U3M0RE9rcFoxWFd4bDRjQlRqSmhvKy9KRkpjZkEwMGN3VE9RVGxpYVB6WW04?=
 =?utf-8?B?dktTNENVNWNncnRMYjlaaXo3MldBM3UyRVd2Y1Y2YmdxRzJxL0JFQ0Ivbk1m?=
 =?utf-8?B?ZjZYQ3BXSDg3LzhrWVY4SXR2bG9adktvMi9MQ3FhbjZ4SzR5RG1sREU5MHZU?=
 =?utf-8?B?VmZzbm1wY0tzU05SellIZW4wTHR6RlI3WVJJVTRMU2tOYXdhRW9pQ2tNM1hr?=
 =?utf-8?B?aGNNUG5KY1lBTGF6bmNadEZtRlRUNEZZR3o3NytoRHRwOUpIZUNzeFdBT2Ez?=
 =?utf-8?B?aTFqbjI0OUhJZmpkRG03VGVCVGsvbkJqLzQ0OEFUSU1GSUd2OVJYK2lKVDh1?=
 =?utf-8?B?SmNxWHlXMTJjUmw0U0ZMdDZnc2lCL1F0RC9Ib3pvVTlncHhFYVhINlgra1Y5?=
 =?utf-8?B?dDA0dURhenlYZUxGUjdqQkxqY0E4SzhzMkRyL1JvdkUycUE3TjBZdEE0V1VH?=
 =?utf-8?B?TW5zS3pnZEZXTzdaKzVWTVQ4Q0V6Tld0R0FKMmRLWUM2d3dsL1FPU0JPWTND?=
 =?utf-8?B?QVE2QnM5WmpZdldZYlIramR0SU1wRUI5MUUwV2N1eGl6aDlJQ3V2MEV0SVFK?=
 =?utf-8?Q?JqDyWHLhVJkdOOMA=3D?=
X-Exchange-RoutingPolicyChecked: rvleNGseI9v+VZgCVJ7gnLNzoB9ItNABgHSEgEbYjs07EUgxJBHK/PWFQ1PT1xdLtpXl0X9c/q26IV6WHj7UdVc9M999gR1Z4oU5DplkUrxt3czUi9JoGnI31gHERoEXQzMdfBfPEGnokKBtkmUvL8qYH06hVPdEDiw1WveVSkitveS7Uzv1tdDKuf4EEy3cbzofPUAXQw2Tme9vScPpCtHaiWqkATTgDVFuKbcD87gXYuulMrMypeLwCfgtbDwRq924s4ZDMdS+FFu/CSar9Ko20z32QiA+wcCIqU9zW6CQqoweMjdUM9Or3mjb31f9c4IfhtaW5RO+GkaHPDNPiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f8840-a3c6-4aef-c0b8-08df1eb7b566
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 05:57:28.3607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBPuvWWp0G7xqoCvDimBA5HPEOgI7DDehNvGS5WlkEef1k7OxAaTd8S9V8qcvvMAz6Xs0I0a50XgQY1hpgCEvcDGRvjEtpmAvRye0k5xLDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
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

Hi Andi,

On 2026-09-30 at 02:54:02 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Fri, Sep 11, 2026 at 06:11:45AM +0000, Krzysztof Karas wrote:
> > It is possible for eb_relocate_parse_slow() to call kvfree() on
> > entries outside the original exec array during following
> > scenario inside eb_relocate_parse_slow():
> > 
> > 1) eb_copy_relocations() allocates as many as eb->buffer_count
> >    copies for exec entries;
> > 2) eb_parse() appends up to two VMAs, right after incrementing
> >    eb->buffer_count;
> > 3) cleanup under "out" label uses this incremented buffer_count
> >    to release relocation pointers from exec array via kvfree(),
> >    not from VMA array.
> > 
> > To amend this problem, ensure that relocation cleanup uses the
> > original exec object count, excluding the VMAs appended by the
> > command parser.
> > 
> > Fixes: 8e4ba491b0ba ("drm/i915: Parse command buffer earlier in eb_relocate(slow)")
> > Cc: stable@vger.kernel.org # 5.10+
> > Assisted-by: GitHub-Copilot:gpt-6-astra
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> 
> pushed to drm-intel-gt-next.
Thanks!

> 
> Thanks,
> Andi

-- 
Best Regards,
Krzysztof
