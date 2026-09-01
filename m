Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70A3C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF2010E3BD;
	Tue,  1 Sep 2026 09:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dNrm7UTf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9FB10E3B8;
 Tue,  1 Sep 2026 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788255176; x=1819791176;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eEun/E/O7tMfgHui1ztx9pMexwKJQFuz2w35NvBsBsY=;
 b=dNrm7UTfhGCHv3makkAZc0bACE0M0I78Q2Jbv9yhKNRwDdz/SCa4ZerR
 ft6eW2dbwD/Nkukv1/P7FLasgbDbhNF3BsHdF6F6h+uSxnJeWkPNkoeGV
 OVEKNpddP7iXoZN7S5xL7Mwluai/2v0bmuawmcLAX+NMbe4a6DjtrSFEG
 /2XHfZ+wfNFXoGHn7wLGjRtt3ItcaKlFUal0wYPD11tNYKF23h/jD2Y8J
 ZoIYQ9+mEi2bFZrjWovYyAelGvKlY2Y2w6qg6gIt0jhwVzdNmAYqlBNSt
 pv/Ir2hQ6r3MrGhiBvgsjlGXhOjJckXVEMSeDpaH8yQIBoFCQ4aWyyMYO w==;
X-CSE-ConnectionGUID: e10OkrH0Rjqj2kVTQWKuBw==
X-CSE-MsgGUID: Qdf/c8vbSFGTrSBA3iOeiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91193006"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="91193006"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:32:55 -0700
X-CSE-ConnectionGUID: SsgRl3UBSWOo59aO34GkmQ==
X-CSE-MsgGUID: pJ9hKzvnSnGthTnpYOTcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="272560641"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:32:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:32:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 02:32:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL8rZ63ozK4wiyniqmlUYF74OoE/HKi5vgVgaQf2EFEPQjnW1mFnhmsXSKsx60ePzEf3fJBRR1kvkS0mIXrHI3av8rgFjm2bPnvqzkrzTZqow+UXpXHaFmOZZU5fL4d88iUcZMlEEffGHON/+oOlSiCMd1dkM+u8hzX8lLLSm8Z5x1Mmd3ipoQvwwdC6SJppTo5nqXwi4md8mmLJ9+0nrA2L/hDlhIv6IRkC9xDI/9MMcdaz+Q3mYNZ9iQfFO35Gc6jO4u8KAZ2MCnvi+y0y/z8MOkVqtEukOWyv2l1IeyW1+5tsVpglwFgfYWLTzJottuiOFKrTE085hoSNmo1Ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPGrO0RdRr2Fd2zpW3LX3OKAgMxyN9O8X1DDjBf8HB0=;
 b=H7zgwmVKDZ9Nt0ddZwPohCVsnfiQGh1xt06HYO/ocUBYyQst9waAnQ/OUoEnS8Xn5LUww3BmZV4YYew8xmdoR+SXxjJ0xUZcDvG1l783jOLb1B1B8DOYAScTMLd4+OEir0NEv6wny5jPCWWkwcxBqDP6WHwEFOQ5qzRn0EWZJ5tjtYZYMfz3zz6RDhd0j6pFz1DMnl0SHiXKY1d+Qk5/ZojPR3D16ZBfl5JpGZvfFMdNNPyHlEnsQw4+BA1+5we+FgX5T+ViGgwP2xfnsCN3aRecj4slRiO0Jys03JMu+v0je7YcYISNJQleQIabQsXXAoG6AIqrSnxr4d994Z30Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:32:51 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:32:51 +0000
Message-ID: <e85bf658-ee41-46f9-b132-bc8c91c1c077@intel.com>
Date: Tue, 1 Sep 2026 15:02:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/xe/irq: Always free requested IRQs on uninstall
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-2-arvind.yadav@intel.com>
 <be78bbde-0cc7-4be2-ad69-1801a8d73d48@intel.com> <apXkdp7NevBnD572@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXkdp7NevBnD572@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::19) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f29e2f-c82d-4e77-f4de-08df080bfe21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GRIiFx2OOvDBeBgv6h+iQWcEgf8143yRZfqNdEM2grHQoHUguIR0F8cLIyP5mWRuLwcNSkOd1Mzsfwm/ZgrCLGj1Tt7Of37DEnz6DgsEV5J4JY9sLGBVsbv6Jm+QscURlq45yrk7jrE5vrDGQvXGLhl8Mk685LGupnErNO2gvM0stSRcnfZSLLO5hmXGkBRRzcdVf5nC0HZXNtOT5PbUcnfLzc2zN3IQ2m0a3iDqAshwSw3CjLdv/K/WNGLVxKyrIfwuFBUTO/vfiCLu4cuTajvMM3reF4KHDSZGZst5TuckeOnSrMEdOHNJhph5wGxvHSU5K/l4SQGW5LuhnG6hqtyCG4Zn7PryZithFUs85HkWiYg4Ui+tQRd8tjQv9J2tjcZkF5YrBX36d81MD58y2xQvAUP2fnjBrVJlwvxtj+LRRKzmkMi6TllLPLBg+Gj4mH5uFoHzoChTbc7f3AiCiQ0v6TpRCH9lau6qELfG+aVycr8wx1lKOoyzCmQQcIWY56ykfwy8QHJUJ2iWKx09z6lZNsOAAtvfELMqkupbkmFFCqM/8vM6E8uyPh/rndHw+A+2UAQSOnprQWDjx8a/K7MIbKYsqReGEg4tpq2TCUjT0hBMu1c/jfd9cHsgM2z+gvinNG3mMXoJDZiivX94+wa/03eFv+kf/KzGR9a7qEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RoaGpzNWd2RUxQSjI1S2I4cVV0SFgvUHFCdHJZT21yT29pTmRqYXVhRFJU?=
 =?utf-8?B?Q2k3V2lzbFJMZHRtYVoyVjJGbFBHcnk3ZkpuempKVGxQV3dra2FSZkZZUWQw?=
 =?utf-8?B?WTVtVmNZSDM4eXE0QXlUYW9zcHlZQ3pibDN3cGd1Nkd4ZFFWS3JnbGZFOVpS?=
 =?utf-8?B?T1RUQ3hyUlFRWUEyRHRRNER1dmJOTzJTaUducFlzZ0psWWc2WitrT2xZeEZt?=
 =?utf-8?B?WFYyQW4vbTdtNlNWcGNnOVNXUEhUTUp4NFBla0U1VHhGVzg5YWNQZis1ZFU5?=
 =?utf-8?B?NnRHQnJ1WTE4RGc3OE15L1ZtTFBpUzJYRWp2SUNoWVNOYmU1SndKU212MldT?=
 =?utf-8?B?Wm5TMExFSTBvYmFDZFJNejVLd2ZJdWJtNXQ1ZjVtcnEwZW1YaFVOQnpRbXNS?=
 =?utf-8?B?NWRlT1N5UTk4R1ExUFdNaEI5R2ZzRzdtYUthZmRNQldqamxVajNtaTFmTldn?=
 =?utf-8?B?ZUVmWU8raEdIaXNTNEVwN2ordzB2bVZNYThNVW1CcHYwRjFaaFczYTU3YVhq?=
 =?utf-8?B?RHB3djFaVTl3Rjcva3NLUk1NWWY5dGgzR1BqRmhhR0VyNE1IcTB6Vm5vc1JO?=
 =?utf-8?B?S1hCUTlFV2MvT3dCdU9scjFOWGJCNTVxYTBlRzJmSElDYjFQU1A5TXNYWDhY?=
 =?utf-8?B?UEhmR3pORDZ2cCtoN0hjRXVSOW9LZDRNSjNwdTBibiszN2lxUCtPRlp5czIw?=
 =?utf-8?B?SWdOZ2lHSUkvdFhHWjljWlE3MCtqU2FTMmJsa1kxenYxelhqT0prcFY3ZUdI?=
 =?utf-8?B?NUR4STRJTmhCb0RaZjBvWDd5YjlweVpqYzVOWGFlRWtyNjUvdDBuNzVTTVBK?=
 =?utf-8?B?QVQ0T1lIRXYzeEc2MHVzKzBPNnFRcm1RT21MTVQzcWRVU2wweG5qM0xuNWRp?=
 =?utf-8?B?UEpNVnVyVkxJT1d6dHUrWTZKMXhIb3piT09JK3FLcEt1aVh0Vk9rMEpEeit3?=
 =?utf-8?B?SFRhby8xNFVTVGk5bkhVUCtCTlV0MnNSOUV4b3FpL0NNVU9zUldpeC8wVjBn?=
 =?utf-8?B?SWpQZ2p6R0ZzL3JhSCtrRVhtNmloM0NncmgwcERpS0I4QTE1VXR3OGN1TCtq?=
 =?utf-8?B?N2ZHQUxoMS9ETXNGb3RjU1JxZlZHYnNCUkM2QXJ2aE5JTlJTY1ZiZ0NEQkpz?=
 =?utf-8?B?TkRxdVRwZkxsOHN0NGRBZ0NSZkVRRW1iRXhEOXI2cGpjRUVRa0NpSlFMZmdX?=
 =?utf-8?B?ODB1ZXhUSktKQWJEUUo3alF6L2tVd0lOaGZnbEdKNnRpVUxuTUhqLzd6OUFo?=
 =?utf-8?B?L2ZEOWV6aHEvdVYycGl1Mk5uNVR1SnM0N3B6eWlIMy82TEFxNjBDOGRLeDN5?=
 =?utf-8?B?MFB3MEsxZm5Qa1hiRWNHNk9jeUdjZnRCaHdzMHhLYkUybStxVklKZG5OMFVG?=
 =?utf-8?B?bXB1NXNrK3NqT05VbEtsMGE3ZXlBVTd3b2JIZWVCWUdYczFTUmwrNUFQNW11?=
 =?utf-8?B?VG9LRm9KRjJHdlRRRlViU05PZFlmN1ROZU5ZdU1OdGNXRkoyRFFLNTNvL2tx?=
 =?utf-8?B?NVEzNkozWmgwSGk2T0U5NHVGc1J6UFF5SWNNUGRYZmR3MWtCQm5IVmltVGQx?=
 =?utf-8?B?bldONmtBRnd0WEE2QkxIUE41azVmelZmM2FjR3dpczFFZDVVM0xPcHF1R1Nw?=
 =?utf-8?B?N1U5eTNXLzNDZktwNGszZHFPWE9XUnEzWVVIdFZ4WDE3ZGdKbDhZdW5WdDNF?=
 =?utf-8?B?WWZGakpBWUJ3c0VtTWpOalR3czU2KzBqZGtDQVpvK0srZ1d0S1ZWT0VMRWVl?=
 =?utf-8?B?NkFKZllQQlpxMnY5UnBEb0hKcmlpYVVoWk9OOEFOVVJQKzVkektiWncyc1pR?=
 =?utf-8?B?azNycXVVVTNZOTJkZU9SK2dOTzc3K3FJT2U1VDRKb0hUYzRyc3N2ODFnSnNZ?=
 =?utf-8?B?Qm5nTkplOEtBUFhtZUhXZjRWWUZYQkFJc09nN1Q5RWtjWEpHRmk5bE9IR3Bp?=
 =?utf-8?B?RDZ5YVJxSksvSG0vNDB4ZXc1WjllZjNsMk95TENMOXZRY0c0ODErbW5LVTgx?=
 =?utf-8?B?SFlTR3g4SEtpbXVpVkV6VG92bllJRGVpV2I2MnM5cFJrQWQ0WjVIcmNqUDdV?=
 =?utf-8?B?V0VndlFFeklneEpaRVAzUzFhSkdXY0V4MkpUbnR4NlRsM2VtbUM2K2xXVHdq?=
 =?utf-8?B?QjFERk5UbHlNUDlpVGN2T1VvVVNlVTBBNk91RlRQK0h2Smswc045emgvcTVM?=
 =?utf-8?B?SG5ERmxJNC9scWlxMXN1RkdnSnFscWZ5azY3ejFBQUJXYnA3TnNDVW90cmJx?=
 =?utf-8?B?V1pkQXl0ZGEwVjFIUlAzeFhGNjJlNEVmSmtIQU4wbzlXbS9pRFpSODl3WWdP?=
 =?utf-8?B?Z2Jzejh1eDVrM0RMalZpcFRVOTgwamxvY2xIQzJNcnAzcmJWaHhRdz09?=
X-Exchange-RoutingPolicyChecked: 5ts5cqLlRHJFuDx9bUrNcfkNQvAb05E9uiAeN/+SnRAXynHW6QB1tTK9i9xrV8QfWoZU2dSiFctC01Wk+/549TaOsu784bJbvCXzKHNunMLTBCCP/8evQAyq8HKcI4gugPXmx6ti+/tflckK03vNejXlFIM8cT+WTnRlnMAOmpoW7vmUzN7mnuu5jULISufwmTrKcO5qZFFXIlDUfgQ64b0gd9jfSOb77Nu1OK9qnxacW3vKkLP0hgnvXaFIRUp/PDC0KJsmXQFHf31leNQ1hGAY6X0W3GHzjs2ULU0ranpFM0D01V79CvJPdaIOf6aFWkcJszEe5+Y4xmU5BguR5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f29e2f-c82d-4e77-f4de-08df080bfe21
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:32:51.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ8g8W3lMJMJnDvG28OxM8/071wxyHyeBJxBlQxhZxRTDotFSKHoNjL6tFMK6fN+soCebDeWFYnwlsDJ7XNUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
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


On 01-09-2026 02:00, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 04:09:41PM +0530, Ghimiray, Himal Prasad wrote:
>>
>> On 27-08-2026 15:47, Arvind Yadav wrote:
>>> xe_irq_suspend() clears irq.enabled after disabling and synchronizing the
>>> interrupts. irq_uninstall() currently returns when that flag is clear, so
>>> a suspended device can skip free_irq() during teardown.
>>>
>>> The managed uninstall action is registered only after the IRQ request
>>> succeeds. Reset the interrupt registers only when interrupts are still
>>> enabled, but always free the requested IRQs.
>>>
>>> Fixes: 4d79a1266d4c ("drm/xe: Make irq enabled flag atomic")
>> Fixes seems incorrect, the early return was even before the change.
> right, apparently since the very beginning:
>
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>
> (I hate to use this initial as fixes nowadays, but it is the right one...)


Thanks for sharing the correct Fixes tag.

~Arvind

>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>> ---
>>>    drivers/gpu/drm/xe/xe_irq.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
>>> index 9e49e2241da4..d314993b14a1 100644
>>> --- a/drivers/gpu/drm/xe/xe_irq.c
>>> +++ b/drivers/gpu/drm/xe/xe_irq.c
>>> @@ -786,10 +786,8 @@ static void irq_uninstall(void *arg)
>>>    {
>>>    	struct xe_device *xe = arg;
>>> -	if (!atomic_xchg(&xe->irq.enabled, 0))
>>> -		return;
>>> -
>>> -	xe_irq_reset(xe);
>>> +	if (atomic_xchg(&xe->irq.enabled, 0))
>>> +		xe_irq_reset(xe);
>> Patch looks correct. With correct fixes-tag:
>>
>> Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>
>>
>>>    	if (xe_device_has_msix(xe))
>>>    		xe_irq_msix_free(xe);
