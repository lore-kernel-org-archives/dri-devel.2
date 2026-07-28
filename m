Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FADAC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DD510E5B7;
	Tue, 28 Jul 2026 16:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hwpBY0P6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C10410E5B4;
 Tue, 28 Jul 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785254435; x=1816790435;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xM+IGEl5BTCuDzo842dlHPdMHzgs+952kXMnLChCjBw=;
 b=hwpBY0P6G8GxbFdw82kcsdt6ors4IOzMRL0QEQGZGbea3+mhmL59o6EU
 oVTIqTfxUweBTzOC/kUo6U/9OZLaXHN2pziTwbePJLtTB1UeOLAM96ZWf
 EV+Y1h8wNVuyuwyl9P1VIo+D2JUsuVj3Ht+zJbwXcPSfYru5R8/t+I+R7
 yvpGn31sH6LZ4ZKXGidKcsojeNLFZKbzosaEVp2vgrDv+WbDGVNchvse4
 pK8ZXJtSKy6l/4JTjsNuM3tKeT/yefbniaynAogYMdIrNDjo4fimhWVlx
 PYdMq9+2eJpoER4wQeDRESybASmqkWROft80U74t44hXtlSKF3ZI5qMFu Q==;
X-CSE-ConnectionGUID: pzPgn7IVSbyADenE6D+JrQ==
X-CSE-MsgGUID: zihT+ABvSwCdWVTaJHcJ7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89664746"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="89664746"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 09:00:35 -0700
X-CSE-ConnectionGUID: l7L6HXoARYay0X7PpuFQIA==
X-CSE-MsgGUID: SjhtdsSURZKrD1cBCQMtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="283080888"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 09:00:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 09:00:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 09:00:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 09:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNYsWiuJ3laCAzkNBpGxXLRJMj4ItaPhpBIKL+tmu4ketODPhoUkXjrPKcKcQUb6Q6Kw0/5aN5Tp2G1Mv5TQsGXCYDHjtARW3TM40DKIpNCqo7vsyXrcnYMjDq+VC87ampCGefnTapZeLG2c368Vq/nBrFikeqt3iyfgK+ofok8RlXG35kPtxoXVuqleUk3D/EKdtYx3g3lBDyopviHaHgI6EQ2Lj/iX+DRfKj0FMDhOPinpNDVI2VAdlVoe5NbriF3wiXOROEC/JghCsmAyOqakvo4PxrHZgdN3FdeEKVtHzHOTUC5M8+wE3zJIGAdYsYOUCYCy/Tn1bX/y9Wi+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awBZD28AQpYWhN9EsU4rifMQz2byWDfTLJSlw2IovXw=;
 b=P7+QeS9xgCIXEnpejmrNGcLTgJvgmur6h5i0YF/3874rk+qRzG9HCnyiE/fVnKzdpfA2CJqeix1DwydsRxHXbiKdVT2uKi20/6UIiL18m+d9QE3A5hYq9gFYvvOeEyxfl2nOBYcDa7nELBG26HNq/HtdRSG49pdLNXunwNQzZEeiXyAkMvGKQx7sHqwSXEciWWhnzFRbUuNFPRmMLw0C4SD/0XFRddb0gun6NMh5Ong0slvUsyI9fSsLzRzgJ5LMx2rWMwfM77B4gXqGL8y673weDKGCsrUN6vM/xAGwdsCE0gmDfwwbn4O2X0DKluAbAXk84ZAJuT30rUk7aizdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:00:26 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 16:00:22 +0000
Message-ID: <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
Date: Tue, 28 Jul 2026 21:30:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Robert Mader <robert.mader@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: Melissa Wen <mwen@igalia.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0249.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::15) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ba105b-2168-40e1-6dfc-08deecc15450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ga5JsKpqLaPq3YyJ788+aCdZbbU5G3nee1UCu8YmLlIAGKrX365GLRDmkFNppHLHRCJHKd6xEKf6RUqEAjX3+Q98g5CC5iNuAMOqByFJfkwF09EvPBIIZ85awl9MwYVJ1EVAqBrfy/9NXfj74F90SFv0BjQNdCZ5s9hhMmZb7R6+qCFp23bKGG4H8uNtzoruaOSkAUdVJa+CMOEFFn3CBH/0Zpj6vr+ea5ldgJgLseUpaPsuUl7YU5NTfBS6ZIDjvR5A3zOTeLdcBjH6Gy+Oq9PhqBsOX60540tGrzF+PzNSmaZjrDgawYwES6rRoxfaLa0FfBmz/jUFMfy4tsYlEBd5LF4EGX95iQRqj+sDkb+BI0RGE7dHiWN9qoslCzGyNThgON7y/By6WgcDQ04JMwUe2PWV+PqxT0U6zdUvIG9ZmWByHZjCtenH+z/F3QL9+DGasnnpDI8+6XaaBwJuVpBtSWGUV/mijGfv+UIz1jA/F5NitQWnM6k0IiS0LmAE22AdY2a9wr0I+r0C/ii+L+SMNbwKHtGD91Fu5aeTB6oGY6hIC+9rgqJlWAK85Q03MK0ErRKoiQ7vcpyzlNZsvkjrsaEiclG/gc8HVWRfCA5D1ndAUFbwTEXlz3s4drsDIzHDJhj8fpRICTRmTiQR8mDTQsOQ+395+2fj/vx0YYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VBaGU0aVA5VzJNVTNFT251NmEzc0JQN3BHdHZ2YXl4aXpZSnZrODI4NHkv?=
 =?utf-8?B?U1lJenJDOHJzdXdRUUs5SXhhVHN5c01ZK2hEZ1VxMFZaZHYrMGhITEt4ZG1G?=
 =?utf-8?B?LzUxNk9rTzUzU2tVRHVja1EvL1phN2JsWXVTMVZwcGtrUXB0eHVNbXFsSUho?=
 =?utf-8?B?MkZuTUx3SmdpTEZ3OVZsN2xSR2lrYVQwWkk2Q2ZvQkJ4OEVqa3I3QUNTZXFR?=
 =?utf-8?B?NXB2cnhtbG8ySVg0c0dhWmtJYXRQK2JkeUN5ZHdmVytlTlV6S0pmNy9NSkV6?=
 =?utf-8?B?OUkybHhaNWd0cW1JWXdsS2xvMEFsVWdIZ2dQa3ZPcngrSTh3Mkd4SU5heDQ0?=
 =?utf-8?B?SS85bzZwUDJ1WitUbEs0dHFVOUVURDNVUER2dW1RQW94a1ZmbTBJZFVaL21L?=
 =?utf-8?B?VHVtcVpsM2cralNuTXZ0aDR1NU9KT0VmMjI3YmRVTDJteE5zbEk1Z0p2M2Ji?=
 =?utf-8?B?cFJnMURSb1RER2M4dUFmcHpISC92VUV6NTJsb0U5NVF4UHFVdUNZM3dpc0E1?=
 =?utf-8?B?ZytBOEp2UndINm11ZGxQSTVDOWZ2VHhlUUlJUE5IczFjbDFVZGtIVjUyWkN5?=
 =?utf-8?B?M1NaNVJqNzlrVDJDeWlReHZUb2lWUFZaUkpkWU5qS041VWpEcUF1T3h4aVJR?=
 =?utf-8?B?ZDdFNTF0OFRqU3VSdWhMQkE4dU80MGR2UUl3ZFU4M2c0dkZFQkFESjJhTldD?=
 =?utf-8?B?cFBJR2xPTEhza2JlYXhFYkkyRUNBUlcwWnVWVG9JSTB1R21tMVVudWNVTHNP?=
 =?utf-8?B?WkVibCs0dzVEdTk1cGNhWEVzNEpzeWtpRDRJTUVtV0Q5T3ZwRFlaV2VmeXNh?=
 =?utf-8?B?STBva1JmV3RVU2hOUDlaNm5hV1dtYzl6ODJhQVphT3FaRDhIMmJEYjkxRml4?=
 =?utf-8?B?eVgwWDQzS2JVeVV4TE1pYnZkcDJ3ZmRjRE8zanB2RE1XZkREM1NoVGwyMWhy?=
 =?utf-8?B?eVFHMTBUeWdGZExaQkNWcnF3UnRVRGZ3SlJ0c1owVjVzZ2xKSVd4WHgyL0JF?=
 =?utf-8?B?U2t4SkhEVTRadmhuNGdaUWttUUVLaWt6UEJ3Yi9acGM0QnAya1JGSGR2SERC?=
 =?utf-8?B?ek1lQkFneDZLUmhhT1FrcStQSkdyUHlOS045ME9HSWlWdThuaDNGUmVqbmp1?=
 =?utf-8?B?dWdVMHRyaVE5VEFkRll4MWUwSm5NaUtZbFJFVmN1WWYzUnZIb05LdFluaGtR?=
 =?utf-8?B?VStRWFVuSDVkUGVYekM1d0hQbE1ZVmFtbkZUNjNVbFd5c2JmRktaTldlV0lu?=
 =?utf-8?B?VFJ1a2w1d2FXN0Fab09oR1ozSm5JM3k1aVgzSms4cmRWeEo5aFkyZHh3cWdQ?=
 =?utf-8?B?emF4NTVIbm1VSHR1OUl0YURyVnpuMHJuMThQNWVwRGhUZ2c1NlB4MEdIRG1h?=
 =?utf-8?B?Z1FmaGtOclpvN0NqWktCT0pDeTFrZUF3QXhzaEt2Mmt5R2JkUFBKODFPUHRa?=
 =?utf-8?B?Z2JHYkg1ZTRFZ0NpZFlVeEdXM0pOS2RnOW5ObnZlSkxDRFVUd3JxVWpmSTl0?=
 =?utf-8?B?UjRKaHVISisyTWx0ci9CR0RORTlrcm0xL043R3dsc3Q0V3Q2ek03MWg4ZW1J?=
 =?utf-8?B?UUxVWWZHYTNhWXlEUjRQZ1BPMFFHejkxakttZ20zQjhIeWVEcnVReVZJbWdK?=
 =?utf-8?B?MXZhTExyNGx0TWtuNTljU3d6emEzdUtnTUpPUnZISnlqSkMrcVVvYy9ZT0VU?=
 =?utf-8?B?dDRCYjFuc25zTHVVOW9maHllTU9SQmpqVGJFUkFtTFFwU3oxdlRZbTJLcEV1?=
 =?utf-8?B?Qlp0SmRVZXdMT3hyTm5PNXBqWVdxWDdLc1BBUEs1RXh2Z1ZkNW1uR1B1VDla?=
 =?utf-8?B?RHQ5N202QVFoaW5KL1FpbDRtRnRaR1Q2L0EySHNWbmVVbklwR3VlMVRZNVpJ?=
 =?utf-8?B?LzJqUVBoVjl3RVlZeVpCOXlLbElNN1ZKTm13R01XNWc0ZVcvZXZUdlk0VDhl?=
 =?utf-8?B?MFBlSWpvV0RuOU5ucGp0ZWp3OVZnWFozbVlpOVJiYnRzcm5IMDBhdTl1VDVq?=
 =?utf-8?B?ZXpid3Q5VGNnTTIrSThJWmJGSDQwOWFOSnhNRHVuRWdnbS9USXc3S2FvL1Qv?=
 =?utf-8?B?VysvTTlKd1pXbFRobk5oQk9aVkFpNXpVK0RqTlZoYkNDY3d1bGhleXYxeUEv?=
 =?utf-8?B?aTIyTFUxVllpbWhDUlN5VUtSUW1RYnFzdWc0VFBvOE1DeWt0eEVhdXpGNkVu?=
 =?utf-8?B?UXE3NnRPNERJUE53WkRVOTc3dVJ0OFJ5b2NlNDNNeU50UEJISmdtS3VWdzdq?=
 =?utf-8?B?NmdEa2kxMDBPS2V5RkJzNi8rL0IvbGozdkMxQXV3N21QZWhlZjcvV0NDSlpm?=
 =?utf-8?B?WWVIUE5zcGJBaS9uclg0em53S2lOOTM1cWo3akhNRzZRU2lqY1V1K2xhZ211?=
 =?utf-8?Q?AKtzIbaGPiOn1HBCfpapTodBAvgalt0mJ8bdP?=
X-Exchange-RoutingPolicyChecked: O6zmcH/rE5EkodkKmprqtK0mk2dVTbLGsms5G3ZWvrVS+AZftRw4i5fbcUgh4PrWslDK/GQJmo0/nAARWNvYangmm/FB/mGCu9YLn17YEXCh3P5SWwoEl7v6WGEMCi465ew0l257BHKzR9jHa2uQx8cACinJswjzD5RLckOjZeSlSX5CPcrQ4+Rb+Bmy1cs0EgEumVAAHgiNjGE8kHV8ttDVrDryfkrl2hyh82t6xhVX9RfjSrY8dgCMpLmJvIrHlCtMjzonp1XVAmTKzAmAmSMzge+BaBkAoDUzyheInjXGokWM7LZ3WPuya1Ncxj5tEVVh+FTZv3kXGQC/PllQqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ba105b-2168-40e1-6dfc-08deecc15450
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:00:22.3592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXId4yVjQi+2PmWMnJyFkEgAr5/PMlUzzvUw4N0IQXtUANUeXhfTm720pOySGw8OZ5d9ytK0erRng8Vv11+GPknUInRULLUjjj4GtBTtDSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
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

Hello Rober,

On 7/28/2026 8:32 PM, Robert Mader wrote:
> Hi,
> 
> On 22.07.26 15:45, Harry Wentland wrote:
>> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>
>> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
>> hardware that performs a fixed matrix operation.
>>
>> Unlike CTM-based colorops, this block does not expose programmable
>> coefficients. Instead, userspace selects one of the predefined
>> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
>> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>>
>> v4:
>>   - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>>   - Document matrix values (Pekka)
>>   - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>>   - Fix confusing "CSC preset" doc (Pekka)
>>
>> v2:
>>   - Naming changes (Pekka)
>>
>> v3:
>>   - Fix NC matrix enum name and string (Melissa)
>>   - Rebase
>>
>> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Reviewed-by: Robert Mader <robert.mader@collabora.com>
>> ---
>>   drivers/gpu/drm/drm_atomic.c      |   4 +
>>   drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>>   drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>>   include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>>   include/uapi/drm/drm_mode.h       |  12 +++
>>   5 files changed, 291 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index e5c8ef06caed..45df6376f408 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct 
>> drm_printer *p,
>>                     drm_get_colorop_lut3d_interpolation_name(state- 
>> >lut3d_interpolation));
>>           drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? 
>> state->data->base.id : 0);
>>           break;
>> +    case DRM_COLOROP_FIXED_MATRIX:
>> +        drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
>> +                  drm_get_colorop_fixed_matrix_type_name(state- 
>> >fixed_matrix_type));
>> +        break;
>>       default:
>>           break;
>>       }
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/ 
>> drm_atomic_uapi.c
>> index 1050dddadb17..d52504d823bc 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -786,6 +786,11 @@ static int drm_atomic_colorop_set_property(struct 
>> drm_colorop *colorop,
>>           return drm_atomic_color_set_data_property(colorop, state,
>>                                 property, val,
>>                                 replaced);
>> +    } else if (property == colorop->fixed_matrix_type_property) {
>> +        if (state->fixed_matrix_type != val) {
>> +            state->fixed_matrix_type = val;
>> +            *replaced = true;
>> +        }
>>       } else {
>>           drm_dbg_atomic(colorop->dev,
>>                      "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
>> @@ -818,6 +823,8 @@ drm_atomic_colorop_get_property(struct drm_colorop 
>> *colorop,
>>           *val = state->lut3d_interpolation;
>>       else if (property == colorop->data_property)
>>           *val = (state->data) ? state->data->base.id : 0;
>> +    else if (property == colorop->fixed_matrix_type_property)
>> +        *val = state->fixed_matrix_type;
>>       else
>>           return -EINVAL;
>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/ 
>> drm_colorop.c
>> index 682fcc651525..e7ccf7d053b8 100644
>> --- a/drivers/gpu/drm/drm_colorop.c
>> +++ b/drivers/gpu/drm/drm_colorop.c
>> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list 
>> drm_colorop_type_enum_list[] = {
>>       { DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>>       { DRM_COLOROP_MULTIPLIER, "Multiplier"},
>>       { DRM_COLOROP_3D_LUT, "3D LUT"},
>> +    { DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>>   };
>>   static const char * const colorop_curve_1d_type_names[] = {
>> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list 
>> drm_colorop_lut3d_interpolation_list[] =
>>       { DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>>   };
>> +static const char * const colorop_fixed_matrix_type_names[] = {
>> +    [DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
>> +    [DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
>> +    [DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
>> +    [DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
>> +    [DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to 
>> RGB",
>> +    [DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC 
>> Limited to RGB",
>> +    [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>> +    [DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
> 
> I'm still a bit unsure how useful the later two values are,

You can see them being used in [1] and tested by [2]. We split out the 
"YCbCr limited to full" block because some Intel planes have a 1DLUT 
between it and the "YCbCr XXX Full to RGB" block. This keeps the color 
pipeline consistent with the actual HW.

Based on your experience implementing the colorop in weston, do you 
foresee any challenges in supporting limited-range framebuffers using 
the "YCbCr Limited-to-Full" fixed matrix block?

As for the "RGB709 to RGB2020" block, I can see it being useful for 
converting SDR Rec.709 content into the Rec.2020 color space before 
blending it with an HDR plane.

==
Chaitanya


[1] 
https://lore.kernel.org/dri-devel/20260720045131.971650-1-chaitanya.kumar.borah@intel.com/
[2] 
https://lore.kernel.org/igt-dev/20260727185531.4046807-1-swati2.sharma@intel.com/

especially
> as they are not implemented in this series - IMO they should be left out 
> and be part of the corresponding Intel series.
> 
> Anyway, still R-B
> 
>> +};
>> +
>>   /* Init Helpers */
>>   static int drm_plane_colorop_init(struct drm_device *dev, struct 
>> drm_colorop *colorop,
>> @@ -453,6 +465,80 @@ int drm_plane_colorop_3dlut_init(struct 
>> drm_device *dev, struct drm_colorop *col
>>   }
>>   EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
>> +/**
>> + * drm_plane_colorop_fixed_matrix_init - Initialize a 
>> DRM_COLOROP_FIXED_MATRIX
>> + *
>> + * @dev: DRM device
>> + * @colorop: The drm_colorop object to initialize
>> + * @plane: The associated drm_plane
>> + * @funcs: control functions for the new colorop
>> + * @supported_fm: A bitfield of supported 
>> drm_colorop_fixed_matrix_type enum values,
>> + *               created using BIT(fixed_matrix_type) and combined 
>> with the OR '|'
>> + *               operator.
>> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
>> + * @return zero on success, -E value on failure
>> + */
>> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, 
>> struct drm_colorop *colorop,
>> +                    struct drm_plane *plane,
>> +                    const struct drm_colorop_funcs *funcs,
>> +                    u64 supported_fm, uint32_t flags)
>> +{
>> +    struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
>> +    int i, len;
>> +    struct drm_property *prop;
>> +    int ret;
>> +
>> +    if (!supported_fm) {
>> +        drm_err(dev,
>> +            "No supported FM type op for new Fixed Matrix colorop on 
>> [PLANE:%d:%s]\n",
>> +            plane->base.id, plane->name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) != 0) {
>> +        drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
>> +            plane->base.id, plane->name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = drm_plane_colorop_init(dev, colorop, plane, funcs, 
>> DRM_COLOROP_FIXED_MATRIX, flags);
>> +    if (ret)
>> +        return ret;
>> +
>> +    len = 0;
>> +    for (i = 0; i < DRM_COLOROP_FM_COUNT; i++) {
>> +        if ((supported_fm & BIT(i)) == 0)
>> +            continue;
>> +
>> +        enum_list[len].type = i;
>> +        enum_list[len].name = colorop_fixed_matrix_type_names[i];
>> +        len++;
>> +    }
>> +
>> +    if (WARN_ON(len <= 0))
>> +        return -EINVAL;
>> +
>> +    prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, 
>> "FIXED_MATRIX_TYPE",
>> +                    enum_list, len);
>> +
>> +    if (!prop)
>> +        return -ENOMEM;
>> +
>> +    colorop->fixed_matrix_type_property = prop;
>> +    /*
>> +     * Default to the first supported CSC mode as provided by the 
>> driver.
>> +     * Intuitively this should be something that keeps the colorop in 
>> pixel bypass
>> +     * mode but that is already handled via the standard colorop bypass
>> +     * property.
>> +     */
>> +    drm_object_attach_property(&colorop->base, colorop- 
>> >fixed_matrix_type_property,
>> +                   enum_list[0].type);
>> +    drm_colorop_reset(colorop);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
>> +
>>   static void __drm_atomic_helper_colorop_duplicate_state(struct 
>> drm_colorop *colorop,
>>                               struct drm_colorop_state *state)
>>   {
>> @@ -533,6 +619,13 @@ static void __drm_colorop_state_init(struct 
>> drm_colorop_state *colorop_state,
>>                                  &val))
>>               colorop_state->lut3d_interpolation = val;
>>       }
>> +
>> +    if (colorop->fixed_matrix_type_property) {
>> +        if (!drm_object_property_get_default_value(&colorop->base,
>> +                               colorop->fixed_matrix_type_property,
>> +                               &val))
>> +            colorop_state->fixed_matrix_type = val;
>> +    }
>>   }
>>   /**
>> @@ -596,6 +689,7 @@ static const char * const colorop_type_name[] = {
>>       [DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
>>       [DRM_COLOROP_MULTIPLIER] = "Multiplier",
>>       [DRM_COLOROP_3D_LUT] = "3D LUT",
>> +    [DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
>>   };
>>   static const char * const colorop_lu3d_interpolation_name[] = {
>> @@ -652,6 +746,21 @@ const char 
>> *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
>>       return colorop_lu3d_interpolation_name[type];
>>   }
>> +/**
>> + * drm_get_colorop_fixed_matrix_type_name: return a string for fixed 
>> matrix type
>> + * @type: fixed matrix type to compute name of
>> + *
>> + * In contrast to the other drm_get_*_name functions this one here 
>> returns a
>> + * const pointer and hence is threadsafe.
>> + */
>> +const char *drm_get_colorop_fixed_matrix_type_name(enum 
>> drm_colorop_fixed_matrix_type type)
>> +{
>> +    if (WARN_ON(type >= ARRAY_SIZE(colorop_fixed_matrix_type_names)))
>> +        return "unknown";
>> +
>> +    return colorop_fixed_matrix_type_names[type];
>> +}
>> +
>>   /**
>>    * drm_colorop_set_next_property - sets the next pointer
>>    * @colorop: drm colorop
>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>> index 224fae40ed2b..92eb6463c39f 100644
>> --- a/include/drm/drm_colorop.h
>> +++ b/include/drm/drm_colorop.h
>> @@ -134,6 +134,146 @@ enum drm_colorop_curve_1d_type {
>>       DRM_COLOROP_1D_CURVE_COUNT
>>   };
>> +/**
>> + * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
>> + *
>> + * Describes a Fixed Matrix operation to be applied by the 
>> DRM_COLOROP_FIXED_MATRIX
>> + */
>> +enum drm_colorop_fixed_matrix_type {
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
>> +     *
>> +     * enum string "YCbCr 601 Full to RGB"
>> +     *
>> +     * Converts full-range YCbCr into full-range RGB using the BT.601
>> +     * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>> +     * at 0 (the nominal 0.5 offset removed) before the matrix::
>> +     *
>> +     *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
>> +     *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
>> +     *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR601_FULL_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
>> +     *
>> +     * enum string "YCbCr 601 Limited to RGB"
>> +     *
>> +     * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +     * the BT.601 coefficients. Before the matrix Y is offset by 16/255
>> +     * and Cb, Cr are centered at 0, following the studio-range
>> +     * convention of ITU-R BT.601::
>> +     *
>> +     *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
>> +     *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
>> +     *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
>> +     *
>> +     * enum string "YCbCr 709 Full to RGB"
>> +     *
>> +     * Converts full-range YCbCr into full-range RGB using the BT.709
>> +     * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>> +     * at 0 (the nominal 0.5 offset removed) before the matrix::
>> +     *
>> +     *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
>> +     *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
>> +     *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR709_FULL_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
>> +     *
>> +     * enum string "YCbCr 709 Limited to RGB"
>> +     *
>> +     * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +     * the BT.709 coefficients. Before the matrix Y is offset by 16/255
>> +     * and Cb, Cr are centered at 0, following the studio-range
>> +     * convention of ITU-R BT.709::
>> +     *
>> +     *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
>> +     *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
>> +     *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
>> +     *
>> +     * enum string "YCbCr 2020 NC Full to RGB"
>> +     *
>> +     * Converts full-range YCbCr into full-range RGB using the BT.2020
>> +     * non-constant luminance coefficients. Y is normalized to [0, 1]
>> +     * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
>> +     * before the matrix::
>> +     *
>> +     *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
>> +     *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
>> +     *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
>> +     *
>> +     * enum string "YCbCr 2020 NC Limited to RGB"
>> +     *
>> +     * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +     * the BT.2020 non-constant luminance coefficients. Before the 
>> matrix
>> +     * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
>> +     * studio-range convention of ITU-R BT.2020::
>> +     *
>> +     *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
>> +     *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
>> +     *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
>> +     *
>> +     * enum string "YCbCr limited to full"
>> +     *
>> +     * Converts limited- (narrow-) range YCbCr into full-range YCbCr.
>> +     * Though not strictly a matrix operation it can be represented as
>> +     * one. Luma is expanded by 255/219 and chroma by 255/224, keeping
>> +     * the black level (16/255) and chroma neutral point (0.5) fixed::
>> +     *
>> +     *   | Y'      |   | 1.164384  0.000000  0.000000 |   | Y - 16/255 |
>> +     *   | Cb'-0.5 | = | 0.000000  1.138393  0.000000 | x | Cb - 0.5   |
>> +     *   | Cr'-0.5 |   | 0.000000  0.000000  1.138393 |   | Cr - 0.5   |
>> +     */
>> +    DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_RGB709_RGB2020:
>> +     *
>> +     * enum string "RGB709 to RGB2020"
>> +     *
>> +     * Selects the matrix that converts full-range RGB with BT.709
>> +     * primaries to full-range RGB with BT.2020 primaries. The
>> +     * coefficients match the RGB-to-RGB conversion defined in
>> +     * ITU-R BT.2087::
>> +     *
>> +     *   | R2020 |   | 0.6274  0.3293  0.0433 |   | R709 |
>> +     *   | G2020 | = | 0.0691  0.9195  0.0114 | x | G709 |
>> +     *   | B2020 |   | 0.0164  0.0880  0.8956 |   | B709 |
>> +     */
>> +    DRM_COLOROP_FM_RGB709_RGB2020,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FM_COUNT:
>> +     *
>> +     * enum value denoting the size of the enum
>> +     */
>> +    DRM_COLOROP_FM_COUNT
>> +};
>> +
>>   /**
>>    * struct drm_colorop_state - mutable colorop state
>>    */
>> @@ -197,6 +337,13 @@ struct drm_colorop_state {
>>        */
>>       enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
>> +    /**
>> +     * @fixed_matrix_type:
>> +     *
>> +     * Type of Fixed Matrix operation.
>> +     */
>> +    enum drm_colorop_fixed_matrix_type fixed_matrix_type;
>> +
>>       /** @state: backpointer to global drm_atomic_commit */
>>       struct drm_atomic_commit *state;
>>   };
>> @@ -366,6 +513,13 @@ struct drm_colorop {
>>        */
>>       struct drm_property *data_property;
>> +    /**
>> +     * @fixed_matrix_type_property:
>> +     *
>> +     * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
>> +     */
>> +    struct drm_property *fixed_matrix_type_property;
>> +
>>       /**
>>        * @next_property:
>>        *
>> @@ -422,6 +576,10 @@ int drm_plane_colorop_3dlut_init(struct 
>> drm_device *dev, struct drm_colorop *col
>>                    uint32_t lut_size,
>>                    enum drm_colorop_lut3d_interpolation_type 
>> interpolation,
>>                    uint32_t flags);
>> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, 
>> struct drm_colorop *colorop,
>> +                    struct drm_plane *plane,
>> +                    const struct drm_colorop_funcs *funcs,
>> +                    u64 supported_fm, uint32_t flags);
>>   struct drm_colorop_state *
>>   drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
>> @@ -480,6 +638,7 @@ drm_get_colorop_lut1d_interpolation_name(enum 
>> drm_colorop_lut1d_interpolation_ty
>>   const char *
>>   drm_get_colorop_lut3d_interpolation_name(enum 
>> drm_colorop_lut3d_interpolation_type type);
>> +const char *drm_get_colorop_fixed_matrix_type_name(enum 
>> drm_colorop_fixed_matrix_type type);
>>   void drm_colorop_set_next_property(struct drm_colorop *colorop, 
>> struct drm_colorop *next);
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index bd435effdcee..ed1a660a3dfd 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -955,6 +955,18 @@ enum drm_colorop_type {
>>        *         color = lut3d[index]
>>        */
>>       DRM_COLOROP_3D_LUT,
>> +
>> +    /**
>> +     * @DRM_COLOROP_FIXED_MATRIX:
>> +     *
>> +     * enum string "Fixed Matrix"
>> +     *
>> +     * A Colorop block that performs a pre-defined matrix operation 
>> selected
>> +     * via the FIXED_MATRIX_TYPE enum property. The driver advertises 
>> the supported
>> +     * operations through this property.
>> +     */
>> +    DRM_COLOROP_FIXED_MATRIX,
>> +
>>   };
>>   /**
> 

