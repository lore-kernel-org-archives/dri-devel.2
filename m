Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF4DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4C810F911;
	Tue, 15 Sep 2026 04:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WtltT9qv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F113410F90D;
 Tue, 15 Sep 2026 04:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789445098; x=1820981098;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FTV7Af81hHvQ6Ci4AC4sW0j5+G6NIHrge2bdjbr2qns=;
 b=WtltT9qvpzDID7kgYtI/ocXMizZLQMkY1V/w9gEz4aIQFZfjaA8xSRfJ
 VP/I1AoDxEzwTSdktOKEL2PrqHb1LE0Yha5G+KrstZUqZqMukzXQ0ma1z
 v0WycIRLmEejdxM2w+2awcN2z2LwiLnNVU1+PuEd97kvoxjefkZTepcS+
 hMoQ/zbnDtkt2Dw5d82rD4v49r92c18O5VPsHkBKB4pbQJi0Q1DnZp3pL
 l2L4vINw9umIjcbBLOLbT87p3vxD4tWOU1cGckGfk3Z9vb485vrxLCmbF
 MGDpHPQxbaBvR8dk69wR2VsfcDVSkAebjlHLs3v7m3A0b1cof4/+AELr/ A==;
X-CSE-ConnectionGUID: tXLZr1AHRQyJ8iT4QGovNA==
X-CSE-MsgGUID: PwJml+bOTwWVJRnaKKCDWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89843099"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89843099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:04:50 -0700
X-CSE-ConnectionGUID: +7HS7IrvRHmoV/OBsaej2w==
X-CSE-MsgGUID: e36caxKhRXiw8pZov/xpOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273352647"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 21:04:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:04:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 21:04:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 21:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/SV3XjdIZcAim1RjoOU3oOQisLTva7P/Pb7hLhxATg0tFJlIFOxPPhPnoFATNQ3H6i2BGjgZrp0Kc044ccGDuRRK/jQW+LxtppEOq8KwNmz9vFqchbM5e3H9iwhzGphG8hfZs/5MVnuruZzgA9QIYvKAjD1PLm9mO24JM2qI0IBWeIT4QX2TN7lJqMhvsCQ9PaDIMTNerpSiBscLA5Qtclr3lmSvxMG/zta12X7sNqxvi48TOs0tB0Hct2PIJDeQacLNsFVb2/jok5jTYrXVUJOIq/fSORZX0KGfIBetsWYKq87MPT7JIFVnIVTREHkNQBpKUWGKyl4FohCRNO6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iD93WDhh5WG0A6lOGbcj85yD1U44KgodqB1Ccf9y/c=;
 b=YJYKjyhuQeUO+nl4wxhzfd7+3Mr5hR7tVZhPhy0VvkJoLiUgYVeC1KMzfvYP6vmwbjyKUL0e3KhMNgPihtCe62SSCeNHA8dnSCbGQGClJ4sDcN2idg1Hxapstnnm92fdt4DqDbiV2riZl5rRI1/N/tkV8e1DQWBQJdkwZXaZLTad5qCcCZWHjdqhieZnUBgZ3Bf881mdzY4YOJJlv9XB5iHDVgs6nWhGSy4F/uheN+fvjsJtuAV5LpeteHENO0sqlPOIsoLMHIRWGJPciH8JbtY9cML/WZDoWhJjE6kq6MNNEQYeQBFrCAlCtc5/NApaSR6hWX6Q/01f/w3s05tb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 04:04:45 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:04:45 +0000
Message-ID: <6b104c92-d9c9-4b76-ba60-f3ced2cf7e6b@intel.com>
Date: Tue, 15 Sep 2026 09:34:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
To: Matthew Brost <matthew.brost@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-4-arvind.yadav@intel.com>
 <apXnb3_WmpYhPeUo@intel.com> <ec7667c6-edc8-497c-97f5-872ba5d63bc3@intel.com>
 <ape0gZng5JWbd+Sa@gsse-cloud1.jf.intel.com>
 <ape1I1UFDGD2r5Fv@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <ape1I1UFDGD2r5Fv@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3702c5-fa4b-4b1a-eee4-08df12de7a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OoDaOFVl4akIhapQl0fET1YcRCDw8s1CpZQ8wp3Hd0nBBPN9HzBxy5sBIzXPWDmi6CRUa0AFbTVPIsSBs4Zr1DxhOGbbtpZoPayzXgLrzjlXc0xi/pIHjTRVd+FcQd4NssHBmUxVABt+J32t/ZoHwZrdwI4XyVVOf8IIOIJ9uZWCIkc5hWrKG68D+o2k3Elzhe1lF0JRitf3zw+lVQs7xWErGkURmgbk/Y6XsTxaUK+51bC+qwsvHFKzPN9sr5PwoWDfbYICyt1/W1YydBVkvm/LJuCyyBNG+SZDYZLuQZ0MLhx3Og6L2wmpUPvgome17jcM3nMb+YmhLchApppuJcpiehoaC9Y2r0s67LKlLqBYKlTCPdF32nDdHyenzXwXFM7oWct1OwMidjRMMEdMo9meEw9DfDjoFt2gN21HaUlm7mhCuGdn5ACQuV7H4RjzYUOUgsQZkfss0e42FgR7RC6Gr2BNFhSUzOFpaO78JZpJRKIQgQfmMBc0E8MLdiJ67k1VLBoq2vpGU+Y76NlNpmGwK/I/afFfHfCOD6golqOyylIeUjAlqWa04MskBpKrxYtDY3nOF+Mt8qrXYRsk9xMQkqw4WGIHXBIO8barT1cRHprb3HIyOSYspDVVQ+jl7/mPv+jAdG8s217R8EffC8uV2k0okLdetG8FhAbsLqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdHUVMveVRyUXFKYWtqWW9LKy9EU2IxbVdCaDlFSjExYzlrQlRTUFA1ZUVD?=
 =?utf-8?B?aFBiTG1xNENwL0Mzb1RadEpHdTlmK094T3ZnbUY3ZGQ1Y3RISGVFbStycXFS?=
 =?utf-8?B?RjVNOElaQVJ6aTdwdytsNk1rd1pJMC9ZZ0JQTXRQcnoyVFMrSVVSTmtjcVJU?=
 =?utf-8?B?S2NaWTVQNGpFbmtRWTZhSWVrcFM1Tm1FNmNOc2JUSGRBL3VxRG1Da2FxOGJI?=
 =?utf-8?B?WWFhY21xRm5NM29Eb3QwTHNmb2w1VXE2UmlpcUJ2Nkw3MFNSYjZ3UHJ0Mk0v?=
 =?utf-8?B?S3JvNU1pQnludksydW45WE5aMkxieXh1NXNUMk5TdU9FNVpQUnpDQkl0Qm1z?=
 =?utf-8?B?NlFJRTBjejFLY2cvY0JXV25Yc29qWjdVUWw2V3FEa09RbWlqWmhXVFJBSU5v?=
 =?utf-8?B?YUxYbVQ0NFNEMU52VnhLUzBUVEM3WXJBcFlSWXJhRkE1cExMMFUyWnF1UUZM?=
 =?utf-8?B?SlNZVzM1Nkd2YnV0N0E4TTV6eitiMXREMm0vUGNrL3hRd2NDandDWEI4ck94?=
 =?utf-8?B?OGl4THlMd0l1YU9mUm0xUmdGeVVQWFVjZVBEMFlOajkvV3JsNXcvN2dUV3B6?=
 =?utf-8?B?SGF5V3JhVW5MSHpNdGxMUXpzazFUSUFwQVZWaHNjd1lUK0RHcjlhVG1XeHZy?=
 =?utf-8?B?c0dISkk4Y0VBeFV1QmFyOHd0bW81enRIU2p4dUZrcEJ2QkY1MnJBNUhNbmRm?=
 =?utf-8?B?eUVIaURrTFlFaTZFaG01WHpCRHRkOTFCZWJvcmFBUXhDTW5UMENXeFRBbGZB?=
 =?utf-8?B?anJORWJwUGFrREtSUVR5MUtWNW11QnY0VVpKcWM5TXVWRURCUjJkdmNHNUdv?=
 =?utf-8?B?Sk8rU3NJVHZySzNOTnlUcUVYdzJNbG5KbTVya1JQZTFDYzh2UlpvTmRLMWhm?=
 =?utf-8?B?MFZWWTh5Wk1nWkU0dEpQc3dUZCtRUENsZitDQnFVYnFiK2FtVFdCK2xUbG5I?=
 =?utf-8?B?dHJoVEVBcU43WFpiNDFtSUVVeHRMY1lSdExyai9seHV6bGMxRmIxb1VTOWUr?=
 =?utf-8?B?OUMyMDBVWUIrQ0JpWm1LRlJtWkNBTkllT3FvUDFLUjlEdUZZc3RUT1owSTNl?=
 =?utf-8?B?eDUva2lvdGZBYzIrQklQMGZ1Mm4yMEdacStSMlJVSlBDZ3FSanE5Y2hKNGdZ?=
 =?utf-8?B?a21FdFFnOWwvQll1cTVSREZWRVQ2bUtpL3J3LzFTdFNDUGdsU2ZKQTJTaHlo?=
 =?utf-8?B?VFhKRnoxbTRtZ3h0Nlo1SlVwMlNsMFNXRkYxam5pTjQ0Wmd0NUJVaytKeXNs?=
 =?utf-8?B?amEyZ0pBMWVCTnR5Q1k4U2EreEZWTityRklHdSt6K2FrY0VZT2plMWVJOGVP?=
 =?utf-8?B?ZFVQREJEV2RhL0wzbzYwdEtuNnJTL3l6UEk4UEU2R2tnSzE4MlRMbWFrK3Vp?=
 =?utf-8?B?bEpKVnBmOFRtc3NoRllPeTNSUC9sM2xmYisxNmNlUHROYXZUbml5MFdLaFRr?=
 =?utf-8?B?WmQrcXYwZkdWNVVnNWJxdC9mWVpwNGRTN2Q2OVF2L2UrL0Z6Wmt3eWJoNXJW?=
 =?utf-8?B?UFV0L0NmdGxaM3cxbHMybFBTV0pMVjBUaXJZQVBac2FJV1dtSEFIb09OMURr?=
 =?utf-8?B?QW1VUFllem5RUXdsWUZlSS82TjFIRGh6Y2FGMUhhSUx0dmxpV04xckpzdEE2?=
 =?utf-8?B?blowQ09HV3BpVXhGY3QzUXRNdzl6VXdLMC9WbFZYTXpqYTZVY3NoeDdncUpw?=
 =?utf-8?B?TkZGUllLUE5NTXNpQTE2WERuam85TGFKUlF5Z1RhZlF5Y0RVc3k0K1hTaW1l?=
 =?utf-8?B?Qnpvb2dPQWQyR2pGbHUrcnBRTnh0NmFSNXg4N0oyN0M4QVF3Zkx3MklIZExL?=
 =?utf-8?B?VDljemE2MTJMTnJjU3pqdERuSmNwbVFJTVV0UlM5Uy95c1luNU91blNiWldh?=
 =?utf-8?B?b2tRalR2eTRkOU5HNWhwM1hmVE5kTHZuWjE3SXFyVWdPbjY5YlpzYlJSVGdM?=
 =?utf-8?B?U1RkSnVGVnQ5Q0R1NUU4dFk1UUFGNjg4bkw2NXg4dklLU3dYeUVBSFI2U2hq?=
 =?utf-8?B?dzkwK296bklQdmRUSzBKOFdrd0p1YzI1SmVjL2VZNnJhZG1tYXlFSmlTeFFI?=
 =?utf-8?B?bVpiWWNaQUFockdCZktaaE94ZVBxc1I2c1YvWCtSd1dKVmRncXNVbFNFbEMz?=
 =?utf-8?B?SXZIcXlOazcwZTAvMlpjY251Q05LVHE5ME1ianhldHFRUDBRV2lSRTdTOW5I?=
 =?utf-8?B?Y09BVGQreWs0TDRqR3lpOHZidjgxRm9wOUlkSGRKcXE0RHBzMjIrOUloRy8v?=
 =?utf-8?B?VmhkS2FtbHlUKy9mbjZoTzAxb2Y4M1BmNndob0ZOSEVFUWNNK3ZmWXRBSER3?=
 =?utf-8?B?Vkt4ekVOWEU3NHprTzVaOFRWSWNkQWRhaCtyckZKRXp3a25xbmpaZz09?=
X-Exchange-RoutingPolicyChecked: Zj0ffLbHbqcbdBwAYXIwRTNvFW9YwiRNWP4XWU51sobBNh9VkCTSb4pLWJqQTfkjRb0c5GAyQgkvpbW2xp0k697jzudk9eQSCV0tdk/hYX6OeQFvigS5+xaJ12qJFBi4nyV0z361oTRpDp8gZ+S7IRLZY5C5KyLLO3HDUdbFjR5vn4+Ev9UQmiiVKzMhcSivfYmsiJnxX42nEFDrn/rS6IPbl5AXoh2mnumMOSY9Z25C5tqSX8ajZEJMQ7wy24ndjkTBT0qV1tgim/+aAnITD7qSJ4NFKS6a2IFOXhJF2bqxbW1PRs0Wf55nwdxfJmEsJuoiOLB8Y7Q1+npndJJ2pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3702c5-fa4b-4b1a-eee4-08df12de7a3c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:04:45.6729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK7NO8Yoj+wYlbSomiVRxZSiFiWhwcFn3kVXU5xj5sZr0yliNI6M2OnuwCRGZ8nvtQuNa7ZjAUpDIOkZQnn7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
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


On 02-09-2026 11:03, Matthew Brost wrote:
> On Tue, Sep 01, 2026 at 10:30:41PM -0700, Matthew Brost wrote:
>> On Wed, Sep 02, 2026 at 10:19:22AM +0530, Yadav, Arvind wrote:
>>> On 01-09-2026 02:13, Rodrigo Vivi wrote:
>>>> On Thu, Aug 27, 2026 at 03:47:51PM +0530, Arvind Yadav wrote:
>>>>> Page-fault work may still be queued when PCI error recovery starts or
>>>>> the device becomes permanently wedged. Servicing these faults can migrate
>>>>> memory or update page tables after device I/O has been blocked.
>>>>>
>>>>> Check the device state before and after fault servicing to cover a reset
>>>>> racing with the worker. Drop the active fault and its chained faults
>>>>> without sending a hardware response, and invalidate the cached fault
>>>>> state.
>>>>>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>>> Assisted-by: Claude:claude-opus-4-8
>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>>>> ---
>>>>>    drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
>>>>>    1 file changed, 40 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
>>>>> index 2e415995f067..f486165f2323 100644
>>>>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>>>>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>>>>> @@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
>>>>>    	xe_vm_put(vm);
>>>>>    }
>>>>> +static bool
>>>>> +xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
>>>>> +			     struct xe_pagefault_work *pf_work,
>>>>> +			     struct xe_pagefault *pf,
>>>>> +			     u64 *cache_start)
>>>>> +{
>>>>> +	struct xe_pagefault *next;
>>>>> +
>>>>> +	if (!xe_device_io_blocked(pf_work->xe))
>>>>> +		return false;
>>>>> +
>>>>> +	/*
>>>>> +	 * cache_start is private to this worker invocation. pf_work->cache is
>>>>> +	 * shared with fault producers and must be invalidated under the queue
>>>>> +	 * lock.
>>>>> +	 */
>>>>> +	xe_pagefault_cache_start_invalidate(*cache_start);
>>>>> +
>>>>> +	guard(spinlock_irq)(&pf_queue->lock);
>>>>> +
>>>>> +	xe_pagefault_cache_invalidate(pf_queue, pf_work);
>>>>> +
>>>>> +	while (pf) {
>>>>> +		next = pf->consumer.next;
>>>>> +		pf->consumer.next = NULL;
>>>>> +		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
>>>>> +		pf = next;
>>>> is there some helper we could re-use? I know we cannot use the pop directly,
>>>> because it would deadlock, but perhaps we can unify some code here...
>> Why would it deadlock... xe_device_io_blocked is just an couple of
>> atomics, right?
>>
>> So why wouldn't this work to squash all faults.

You are right, this does not deadlock  as per you suggestion I will move 
the check after the QUEUED state check.


>> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
>> index 2e415995f067..1c9e5539b90d 100644
>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>> @@ -477,6 +477,12 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
>>                  lpf = xe_pagefault_queue_tail_fault(pf_queue);
>>                  xe_pagefault_queue_advance(pf_queue);
>>
>> +               if (xe_device_io_blocked(xe)) {
>> +                       lpf->consumer.alloc_state =
>> +                               XE_PAGEFAULT_ALLOC_STATE_FREE;
>> +                       continue;
>> +               }
>> +
> ^^^ This should actually go after the XE_PAGEFAULT_ALLOC_STATE_QUEUED check.


Noted,

Arvind

>
> Matt
>
>>                  if (lpf->consumer.alloc_state !=
>>                      XE_PAGEFAULT_ALLOC_STATE_QUEUED)
>>                          continue;
>>
>>
>>>
>>> Noted,
>>>
>>>>> +	}
>>>>> +
>>>>> +	return true;
>>>>> +}
>>>>> +
>>>>>    static void xe_pagefault_queue_work(struct work_struct *w)
>>>>>    {
>>>>>    	struct xe_pagefault_work *pf_work =
>>>>> @@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>>>>>    		int err = 0;
>>>>>    		bool invalidated = false;
>>>>> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
>>>>> +						 &cache_start))
>>>>> +			continue;
>>>> do we really need to loop inside the loop or only check and let this main loop goes?
>>>
>>> Yes, The inner walk is needed. Chained faults have already been removed from
>>> the queue and linked through consumer.next. The outer pop loop will not see
>>> them.
>>>
>>>>> +
>>>>>    		/* Last fault same address, ack immediately */
>>>>>    		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
>>>>>    			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
>>>>> @@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>>>>>    		err = xe_pagefault_service(pf);
>>>>> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
>>>>> +						 &cache_start))
>>>> do we really need to check after?
>>>
>>> Yes. The device can enter reset or become wedged while
>>> xe_pagefault_service() is running. The first check alone does not cover that
>>> race.
>>>
>> But this is still toctou - really everything in patch is as immediately
>> after either check the state can change. I can't say I'm a fan of any
>> weak checks in this code...
>>
>> But just for thought: after this point all we do is CT which should be
>> down and we'd drop it there before touching the hardware.
>>
>> Matt
>>
>>>>> +			continue;
>>>>> +
>>>>>    		if (err) {
>>>> now this err far from where it is collected is pretty bad...
>>>
>>> Agreed. i will keeps err next to its use.
>>>
>>> Thanks,
>>> Arvind
>>>
>>>>>    			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
>>>>>    				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
>>>>> -- 
>>>>> 2.43.0
>>>>>
