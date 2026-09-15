Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58636C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99FC10F934;
	Tue, 15 Sep 2026 04:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VTrZiR9H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBA810F910;
 Tue, 15 Sep 2026 04:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789446265; x=1820982265;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e/OSN6JzPgs53XWPxJOd/KzagRDb49J4pF2grMHh+Mc=;
 b=VTrZiR9HKWc+FzDwpKl+RVoh1sYUn6hz6BeOJ46BuMD25T42lrdLrDy2
 N7EW3EWIYjggl+erH/L1hPlB0xXUOpDk+2cLgMIlajQSLqcuzYCWsWDlE
 PqmeMDmLGnpajeS3MFTMQHLgjBA01cws9qy66P7tAWKT6NWvGIkP06hQH
 p0SPPEIajFU9AmARHMoTny86qTbCasAc7twXghJkpcoE3WS/rJZ/MGAxf
 RS6dSaJJ8solLkjoBtaheauonThohGGzYkidLFimB2bmk0Qnv5JD56ffX
 zy7Tqj3KwjJo4q+cyK+YjzkWlZhs+wI6eDZk6/l0vduVb4c8yyXXLfoFR A==;
X-CSE-ConnectionGUID: FAuUnOTFT0225r/ijhs4OA==
X-CSE-MsgGUID: lVE2dCtLQtiMvAlrwVfrYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100956198"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100956198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:24:23 -0700
X-CSE-ConnectionGUID: UiYxafF5QkyXD7ASzgJSvg==
X-CSE-MsgGUID: T4zKPvryRSKKPYmWKovDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276976463"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:24:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:24:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 21:24:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7EbexltZSyO2j4rsUqHUYy8FD+OjkYoozTmWvQWjM+M83ZW4hFGSO6UGCMrk8KcbRWNXNYG2e9PO/QXAU6w0H6ac+qPChRESdbkTYmhSqSUMGkXkGwtGJRVIJmTuEH6LTWPEuQ12qcgx9D/8lFqPrwZC/Q2+aXi4ActIrRp1/2EUs018qUPRics1mIXvVIeLARoai1HSfORJIkSkeRCscfkL62OuZMLNUyM3vd0D9O30ZpYKbA/qrw2dWhNgGRqi0d9FhP5PMuMX2VdeLKh02LRnE7NlKl8Zw59zZZsAbogQB8EkTCE37tRnbwmpyfCkP+lU79G3g4FZbdqct4Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcJq20WRwOOcktImTXyZ1dXR0uZlYfFQ8xgWxazgGyQ=;
 b=Uhr233ACWwwZQVmPmnUNULNEOrT6UzGaD5x3Y4IBaOu41tQqezvo6BZOQruE6MKRVnah6nCemEzBpmwzx+C8JJagjc0RAbVS5y3yGupoH9TaS6RO1YwxKbSAN+kc+muTT7h1mQizm0/XSKhSkQUM3V1A/w9kHfYypq7rO2CeWL65BbhVarHMCixyTO4C2X78X91wp/FpQTLam8IME96m+RgxehTH/pkqjr3VpPBG2K7qGDedVyJWqUASs1OSHH1u/C+UFjjGsoBVrIbbVO00xGxLtBqpPkWoTwqeBw10/RWKOdD4w7gp8MPFBvJNSg6T26OfLQ1DBx9Mn+Cb/JJtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 04:24:14 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:24:14 +0000
Message-ID: <fab42213-49f4-420c-b6ef-0382ca99db5c@intel.com>
Date: Tue, 15 Sep 2026 09:54:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] drm/xe: Isolate wedged devices from hardware access
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <rodrigo.vivi@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <5c1b30dcb4342bd0ee43815434f8df4912709b8a.camel@linux.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <5c1b30dcb4342bd0ee43815434f8df4912709b8a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::15) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b049fa-6612-422d-1f26-08df12e132d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pG+eLQRGWeNL6FJ3QjxQPbzQMZXXa5S3IUCJLFN8lP1YGRyRFnYTrkCTQ22oBqijs0Ig+pl/EjzpPNt6IEh8TRpgxwOUOxhph6pAytYkPTy++JEiWooTBHsOOqP8b1/Ehh/ygzhm28x1vAycoYkum/7FS2uhsKEPNqme1RnlMcyaI267IcyA90lO4Jq2ulgKp4kbGHBmzWE/i9EWQnNCVC24M6C4GhAxSE/qTJqB/1BNRJGQXOheVdZeq5t+RuD/hB1IXsrtOFmhbEo7A8TMxxUYFSStW37YIuNLnkd7gmgK2+n0f80vtP9ysCFzsvIOV0PrBmuz2R4q7Pg0e2hteuzuUT4qONyBuoiMDykl3lF+dZsWJs27XS2WsMrTK51c0WDAdE7mlJ8DU6QN4qyIVXM3N9VL0tpuWM2Ib6f2S7EVP6hMBAsaE9Cprht9UnPcHl0QoPpwhSBhPyO/pBIcLGCMlfYO1iUBvcD6ntUjrGxnho9/5/a6s0UrH0OYbjvPIjLsJUdq/w3CjJ1s9LTxQoQV3KiM7n+vuRA0RGAefRMrD0mtSs8mgz8miCRjjLKYilRDQdd2FBMO/NZwEHM2nEKUM4SNT1g7wsY+4+ql7bfm60jJOxWObeoB+TX+09Md
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0h6endRVjVEYmpPTWNVWkMzT2JUMUViSzBOTnd0blhCdjB6bGQ1SldWWko2?=
 =?utf-8?B?NDBsaHo1enVvOXkwRFlpZURYaUdsR1hyR05LZVBZUGp3aFUyaGpnYWFuRjY1?=
 =?utf-8?B?TmRzSTBSc1BuWDkvV3NiRmY1MnFDenNJblQ5OVg5TnM5bG8ydXIyakNremQ1?=
 =?utf-8?B?VVdJcmhNQWZyTTJ6bWc4SkgzeEF2eDcwNTJjemtCNWk5RVpNRkFmY3VxaG41?=
 =?utf-8?B?ei9NL21meis2L2Rnd0FUemZobE9iZUI2djBtN1VTejVKNU5sRVltRUlMTTgz?=
 =?utf-8?B?MmlSclRzWkRybG40QWJqcDlBNTRVWVdtZGJBWHRUK3NGZmJja2VtdTFMejEv?=
 =?utf-8?B?aGdBZzlEMGV4MnRNMFN3ZXQwNHl6d0RGRmpDVWxuRm9UY2JyN2RQMnNocGZj?=
 =?utf-8?B?TldrQTkwYTFDcjN2eW55SVV1VDZkSXB4aFd0aG5zaFVJQklHL3RLR0R3dnBF?=
 =?utf-8?B?MFBVRHZsTjRvSG1HNnhZcHVZSnY5SkRHdlUyanhNaXA2aVZJTlgxN2RyWHVI?=
 =?utf-8?B?VEVLckdSMjFMVlZQRWU5SWc0WWUydi8rcW5iS2tRVlova3o1N1UrRlhJVTl3?=
 =?utf-8?B?UGdycSt3VS8zUjBUakdpYjVKSERHVHVPYkE3ZHlBb09vMDNRd3BGK3F4UkVl?=
 =?utf-8?B?b3pPdi84RmRnVlRvbkMySFkwSnplYUZkTkJQZXNwQksxbW8vdHNuSU5MUzlk?=
 =?utf-8?B?d3B6VlFwMWNraHdxT2l6UTAwK3FGZVZOLzc1MC9zVXV6UERZU0NIbG5saDhX?=
 =?utf-8?B?alk0Q2JTUGpUY0oyRlJKU25Jb1c4a2pNc1JhMVdFZjVJcElvOVVHTDRodFFI?=
 =?utf-8?B?Z0RXV3VqWUdKNlVnaDZBVXprTWlwM1RnWThmS3B3bW5QZGlmdkdaMGVmaDJG?=
 =?utf-8?B?YTRZSGRPV1FWL2grSkcvdVhqWU5kdUpYTy92NUJUa2xyK2ZRS3BnTnQrR29z?=
 =?utf-8?B?bWtGV3UveWpmcEtKdCs4NFRHVFJnVnBDM2pLQXJKWUhTbDRoQjlqSkJEd0d6?=
 =?utf-8?B?b2NqSWRxRGR1RTJmTithK1Z5NkUxQVIvKzhQdmtzNnlIL0NzVzY4b2NjWVN6?=
 =?utf-8?B?c0tpWVRCVm1tckkxeUxtVkVaRmdrSkZ6MCtxODQrVWlvd3NRM1JlL1Q2SUZa?=
 =?utf-8?B?NFpFWjV6R3BqNER5aTFCeEUrdWxxeDYybERGYklhZlA2aEdFUU9yOUJtc290?=
 =?utf-8?B?TXBXaWdWdVdIeTR6QXF4bGRYcmdsbElkbTBRSzFjN2JidEdOa3Y0OFIzM0ps?=
 =?utf-8?B?THNselhpTjh2bkoyNCtualN2bjBqOXg1RkJEczBNbXJoZ0djamZjV0lIMmtr?=
 =?utf-8?B?cHJKeDdrZHBVZFpFdGJYMHVYZ2lVTTN4aitQcGJmdGhDMWhwTUpraEE4WmIr?=
 =?utf-8?B?M2JVWlhDQkttZ1RRSXpROXE3NSt0NDJPTXF4d0tQL285RXgydHVLQjdCRWZS?=
 =?utf-8?B?dDFBNWo2RTNRb1E3WEp4YTFEZ1BXK09NdlExOXlIWnBxeFQrbTJXQlA5NXdt?=
 =?utf-8?B?MjZhTGdjdVA2cDMwOWVDUzlmbVg5WXduWUJ5dXRzd0syMVh4bnFDdldrN2ZG?=
 =?utf-8?B?b3ZCWWMxVktYQXNCOGk5WWdiWnZhdjMxY0VqUmQ0dFd0djExV2hEUXZyUnIx?=
 =?utf-8?B?WEZhdlBGQ3BDSFhKbFBRcVJoejRzVXBkNjRiMkNlQjJsUi9kVFoxSWlBUEU0?=
 =?utf-8?B?LzVTOFIyVk1KL1RvT1RmY2x1Ky9lVFRTa1IvZkxGTHo1Ny9CQmJkbForTmRD?=
 =?utf-8?B?N0xSOU9JSzM1Zjd0NWpaZHl0Q0t3SlMzVndFenVoME9FeldhNkMyYWNPb3NU?=
 =?utf-8?B?cEtja1FMKzhkaENYRVM0VEJUVEdUcjZnWjZWZGhaam1pUGtNU0ZKSGIxMGxw?=
 =?utf-8?B?YWsxakJTamhLeEdQNzk0SElJSzF3SGxRRGFpdWJSTzVJbGpBVnpLN0FrYjhu?=
 =?utf-8?B?V1g2clpUNytpRkZDSC9zVXRqeDlwaE1NUTJmTThPTElzdVl6c0w4aDl2dUpD?=
 =?utf-8?B?RC9sWGJZUnZid2ZvL0VIZHFYWU82cFB1dk5KL1Rvelg3L0Rtd1daanNVSFc0?=
 =?utf-8?B?UkFDVllHNS9ZUlArajI2ZjA2OUJQcjByOEFaVjVIQlFDZ2ZwdWYzMWpTNVk3?=
 =?utf-8?B?UVVjNVR0SjVBTTViK21sOE55dXRTeUlRQUZwLzRpWGtqbzh0R1FFczgydnc0?=
 =?utf-8?B?V0g1TWJOYU1KWDNtU083OXVFTERDTll1QlQzN1ZvZlRPRFNqU2tjallqZXhF?=
 =?utf-8?B?SXhscjhDRmhUTVprU28zVVdKd2thVUdtNnpobExsTEQ5N1hhVEhMQnpBcm5s?=
 =?utf-8?B?MG10aVN5SE1OSGRyWWd1WUxvdm4vQ3g4U0piWUgwL2lOTmlkcjd3Zz09?=
X-Exchange-RoutingPolicyChecked: D8iC9o/6xDu5FvaDW3gMjnn7hZkcTX0xPAUTXULc5dNtQTxTx7ymSZsb0oCDb3rY7q28zRJw6lrIGK41Jxdf2AwaCpk+42hyDVumIvA7IZCasmIcqEMZGdkrCirAcUBXI0MpfUY4u3iLbS0gwnOUTPEfuGdR794GSrF8qW2oe7wQuR+p+PtvO2ii9CMLVRmiK3zfb2YWs8QcBKs3vFDwJ7OLy7EIJAli2rnVixzd4+WOWSJ99g21jB8Q64umIzTjtp+r1KOkiiUYBvo0Hj5LIvlpx5Xl4F0ILpKHWQgR/9K9d/8KBTDSmEpoTu82yN6euLmEBFSUsH5i0UH4Yj+ReQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b049fa-6612-422d-1f26-08df12e132d7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:24:14.1033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd5kce+hA2BT7zQnVBdzztfnljeWD060xd2RcTT9k0W5ftbBSv/ZnMKp2CQL6tMd9mu69UgNqQzPVe/8PfSfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
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


On 10-09-2026 16:15, Thomas Hellström wrote:
> On Thu, 2026-08-27 at 15:47 +0530, Arvind Yadav wrote:
>> A permanently wedged device can still access hardware through pending
>> work,
>> existing VRAM mappings and background driver paths. This can cause
>> unwanted
>> DMA or MMIO access while userspace is preparing device recovery.
>>
>> This series separates temporary PCI error recovery from permanent
>> wedging and
>> introduces a common device-I/O-blocked state.
>>
>> After a permanent wedge, the driver:
>> - stops queued VM, SVM and GuC work.
>> - shuts down the display.
>> - invalidates existing CPU mappings to VRAM.
>> - maps later CPU faults to a per-BO dummy page.
>> - stops interrupts and clears PCI bus mastering.
>> - rejects new VRAM allocations.
>> - notifies userspace only after isolation completes.
>> - drops queued page faults and stops VM, SVM and GuC work.
>>
>> System suspend waits for wedge isolation to complete before skipping
>> the
>> normal suspend path. The worker cannot reach synchronize_srcu() until
>> all
>> GTs have been declared wedged and their pending fences have been
>> signalled.
>>
>> The device remains isolated until userspace performs the advertised
>> recovery,
>> such as driver rebind or bus reset.
>>
>> The series also fixes IRQ uninstall so requested handlers are freed
>> after
>> interrupts have already been suspended.
>>
>> Arvind Yadav (13):
>>    drm/xe/irq: Always free requested IRQs on uninstall
>>    drm/xe: Separate AER reset state from device wedging
>>    drm/xe: Drop queued page faults when device I/O is blocked
>>    drm/xe: Stop VM work when device I/O is blocked
>>    drm/xe: Send wedged notification from a worker
>>    drm/xe: Reuse one dummy page per BO after wedge
>>    drm/xe: Invalidate existing VRAM mappings on wedge
>>    drm/xe/irq: Serialize IRQ suspend and resume
>>    drm/xe: Isolate a wedged device before notifying userspace
>>    drm/xe/ttm: Reject VRAM allocations on wedged devices
>>    drm/xe/guc: Skip timeout recovery on a wedged device
>>    drm/xe: Skip PM notifier preparation for wedged devices
>>    drm/xe: Block BO VM access when device I/O is unavailable
>>
>>   drivers/gpu/drm/xe/display/xe_display.c |  18 +++-
>>   drivers/gpu/drm/xe/xe_bo.c              | 101 +++++++++++++++++++-
>>   drivers/gpu/drm/xe/xe_bo.h              |   1 +
>>   drivers/gpu/drm/xe/xe_bo_types.h        |   4 +
>>   drivers/gpu/drm/xe/xe_device.c          | 118 ++++++++++++++++++++--
>> --
>>   drivers/gpu/drm/xe/xe_device.h          |  12 +++
>>   drivers/gpu/drm/xe/xe_device_types.h    |  26 ++++++
>>   drivers/gpu/drm/xe/xe_guc_ct.c          |   4 +-
>>   drivers/gpu/drm/xe/xe_guc_pc.c          |  10 +-
>>   drivers/gpu/drm/xe/xe_guc_rc.c          |   4 +-
>>   drivers/gpu/drm/xe/xe_guc_submit.c      |  13 ++-
>>   drivers/gpu/drm/xe/xe_guc_tlb_inval.c   |   8 +-
>>   drivers/gpu/drm/xe/xe_irq.c             |  32 +++++--
>>   drivers/gpu/drm/xe/xe_pagefault.c       |  40 ++++++++
>>   drivers/gpu/drm/xe/xe_pci.c             |  23 ++++-
>>   drivers/gpu/drm/xe/xe_pci_error.c       |  22 ++---
>>   drivers/gpu/drm/xe/xe_pm.c              |  27 ++++++
>>   drivers/gpu/drm/xe/xe_sriov_pf.c        |   2 +-
>>   drivers/gpu/drm/xe/xe_svm.c             |  21 ++++-
>>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c    |   4 +
>>   drivers/gpu/drm/xe/xe_vm.c              |  16 ++++
>>   21 files changed, 446 insertions(+), 60 deletions(-)
> Hi, Arvind.
>
> I think this series lacks context to some extent. Much of the code is
> also inheritly racy [1]. because current hardware accesses aren't
> drained before reset or wedging. What I think is needed here is a
> design detailing
>
> 1) What type of user-space accesses and workqueues are completely
> blocked (for example sharing the newly introduced vram_userfault.srcu)
> This can perhaps also be combined with the drm SRCU since I figure
> there might be multiple places where we ensure hardware is present
> using drm_dev_enter / drm_dev_exit and also want to check whether it's
> wedged or not.
>
> See an example in
> https://gitlab.freedesktop.org/thomash/kernel/-/commits/wedge?ref_type=heads
> (Note that this is just an example, not fully adapted to the intentions
> in this series).


Thanks Thomas. I will document all userspace and worker paths that need 
protection and rework them around one common synchronization domain.
I will also check whether it can share the DRM SRCU.

>
> 2) How is user-space supposed to respond to a recoverable PCIe reset?
> Currently? If a change is planned, In the future? Is it the case that
> currently we flag "In reset" and then force the user to close its drm
> connection and re-discover a recovered device? Is this about to change
> and hence the distinction between PCIe reset and permanent wedging?
>
> It looks like AMD might have an rwsem that just blocks callers over a
> reset and perhaps notifies them that, for example VRAM is lost. In any
> case, in addition to locking out new callers we need to drain old
> callers:
>
> [1]
> Thread A                   Thread B
>
> is_io_allowed()
> 			    disable_io()
>
> access_hardware()	    reset()
>
> Bang!


Thanks Thomas. Agreed that the current xe_device_io_blocked checks only 
block new work. They do not drain a caller that already passed the check.
As per your suggestion I will rework on this series.

Thanks,
Arvind


>
> Thanks,
> Thomas
