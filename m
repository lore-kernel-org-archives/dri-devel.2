Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97752C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA8E10EBE6;
	Tue,  1 Sep 2026 08:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mV3BK0Z6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6FE899D4;
 Tue,  1 Sep 2026 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788250803; x=1819786803;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xZim1E1MZkCWaYNjV0dUC1rNoYf+WRESnXVVCPkk+8s=;
 b=mV3BK0Z68EY7q8NjJmVGJ+I+nFsWmMoggkKOab4T2abI98WhowHRlmGP
 monhKpsgnF5lPAKHgCYNPQaBisPl2RxvAiixQKPn2JxwX3lKi8LLeOokA
 w8KV9mM5b8UMRAqNG7LXy+PVx4/xHTgWjcqIUhpVGgLgS+oJKH7IiRE2Z
 3WFXoQjMxK0X5A8vN42YKdk4hdTE5kwubbUGJJk6j79J5lqOI7eumdk3r
 CboEFSjpboUHVs88jBDFEA1i+bBRpqddqhQJ1Qw4Ll/qk4PHIy7TyBwk3
 H0e4fjrnHaoMVBWH+KL1FzwhFyX+tq6E8wyVhv2hs/BIcqCZZ3zwJPSQ/ Q==;
X-CSE-ConnectionGUID: JFackJA/QiqagH7K0NEvxw==
X-CSE-MsgGUID: Y3fGHMAzQqqtsV1ejRtPGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99831471"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="99831471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:20:01 -0700
X-CSE-ConnectionGUID: ihvcF4uuReGIqE+bnT6oxA==
X-CSE-MsgGUID: uqlbrQMRSZejiT8XfCiqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="264744369"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:20:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 01:20:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 01:20:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 01:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9ymEC6MewS0DS4Pod0E4gkIRBrjhX/ANU2JyM/gcEMfLIlrjGfU8cYiRI3COX+2JwTndFqwNbruD69Pci9aaIUE9FzmfVmJdF//mW5HZ7joM5PcgM+aXifI/lzVFSXRp6ENO+hXM5U1dNAm8ymhwLF/si1mWw/RdhEmOHjatRkFPcYMUtG8hc2O7YARvHqW/e74hiNM4TYsUimRezJOVSpGNYhjnmaBRDNsderRAooOIxh0JIIu5b0XkrL2S4uHq8lzAhWU597FgZXtyLHLjzi9VPCk5i8zfpsO6du/SAJgX++IZKbl1Y9i2KSxhO24105d7e+dDuDH2WKzUNXVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f4bYmE4kfAxt8IsF3dHgAW+uoKcjcOKNPrrTUCpj1U=;
 b=wKwJFZmf7HpTXvBnX48RjkaAjgK3F3PG5X2+bASfvyh91476FSeDtaEGyOdBAmRZEQo4L9WRvKaRMeHh7UARt+NP01I+MDO3ZkVwXgFOz+CrYNRxjlxDGv7rBJZoDZQKsviKUOHQHg4q06Z4TPD5d1wgxQLCV35GO+if2GltYyUEcor3elxTCkC7ETmCTeV6TDppArGpZVT+g/o2I7y/vDZpR7WdqhJDwahcKiuf2biPjxA5/NKh1oYgLDrRzctHFIWj1BdXO4QDnYvwPxJO6EvrctzLD1TKJGqR5cqGVJgsa9KVWU95YE+vbWRXmYoAimVOpDI0Cx+X/qUZwuIGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:19:47 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:19:46 +0000
Message-ID: <00f9364a-f908-43b6-9f84-5ae45e982575@intel.com>
Date: Tue, 1 Sep 2026 13:49:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] drm/xe/ttm: Reject VRAM allocations on wedged
 devices
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-11-arvind.yadav@intel.com>
 <apXsOmtkE6Za_8ML@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXsOmtkE6Za_8ML@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0303.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::14) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|CH3PR11MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cb5978-f042-4b9b-c3e8-08df0801c821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J4ynb1TP7a7X/QUQ9KCqYG6da1xPO8XRygGlT/I/Bb6YqQ+V7FjxrC8lwaMvIqaYPq853SiLW0qL9WQP1Zf1eIC+tcOA7yShFWBc89LMnbdC+mRQmwojKGMqGe0FrqlxXOJVwFQDqEzeYuLl6GrJqxX61C9jF4b3OREO+uM4X+khMg6HWoY6bjiq9EDghuW9psXXw3zPlV6zIH1uYNL522wVeBH9DzEZzFQ3U4zmlpXS9Tl3DK/ngEcqZN7w6BL24n60+N+hLIqvcIJD4DmaX6m4NaqSvWhNQT//HwjNZ3y/KgfZ/n+gucJlE9H3rJ4+SMzqgtqE9ZiniOqPXXC9jmM3dFsPmz5ehL4SGM0vSiyv7upmd1msm8gI6nP8brRM+WpD6x4PJPDw/w824wNtz0Ss0XY7sOeOWaEN+j+1nNJ50EDAPKtzkKyy7gLB/wrOUZzUSErqvme3m46PPwPDLa67dfTC/7/C1jzi0I9N+e/hxfPg+v56mZ7JIOiWa6A38qZnuU5ITvFeITESPEWA9aJvs7kb16wvLZtk3Xtq2G9/jGNE24bTHOkEExGF8gF5emKGuwBLXPWj38VfIevDTRbQ/jV7KDLEZEz2ynfqjUhJ1o1HEK9Ds7vUpZAMXLMQmWz/niHpVF3JoB11P+gDco0wcCgy1UScMxWn6olPg9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVcwRS9sRkwyeHNMYnMxYXdNV1gxUWRpWWVuTXhlSHI2RDF0VFkrWFI5MjJK?=
 =?utf-8?B?VzhQbkVEQld0eERGcGJ3U24vNG1HazZsaTd4YWFKV1ZZTzVGcEprMVdJOUJn?=
 =?utf-8?B?NzdoTnJNUm5ISjltZ3g3UWJ1SGt1MjlKekd5Q0ZwZUNHU3hCelVLTnNqb3JB?=
 =?utf-8?B?ZUQvei9GU3JTNk45MHRjZ2pSUmlOdXFBcDBVQ3FHdGo4RnB1U29naUdHMGZP?=
 =?utf-8?B?Qk1JeHZiTExpQlVTT2gwWWNIVFhmbWFwK1h6QVR2emVoZEpRZ3RlYmkrby9m?=
 =?utf-8?B?MVdyNy9KQzVQRmFKR05OdDV6YkhDY3JESVR4Y0NkM0E5Zi9wOFJNRmNnNzR0?=
 =?utf-8?B?RkVMMTdqS2JldmVKYjYrQVh4K0t5YWtaUGI0YXoxcVN6SmRDUytxNEROWW1C?=
 =?utf-8?B?S2Q2MzU4MWVRQml4MHFNR2c5MlVQeU5aRXhYYTlMOWwxTUM1eGhiVXE1Y2ww?=
 =?utf-8?B?SWJ6VVVhUTRHTm9JYXloZnl6b0RUdXVLSWlYVXlEYmNGQlVyRjgyZ1lTRmlS?=
 =?utf-8?B?UVBKbzFvbGVNdlNSeWpxOTYwb3ByajRETnlDWkw1dlFpQXFjbnd1M09lTlIy?=
 =?utf-8?B?K3ozOWZySHU2TjNCdTNIeVpWSkZTZDF4U2k3S1ZyY3pTb0l5R0ZMNmoydHNH?=
 =?utf-8?B?MDJ3S0dJeXJCNVQxZmRVeDR4RUVIQWtaZmsyVFh6TWRRNjBDTWh1cno3WXhr?=
 =?utf-8?B?ZEJTTW84YnUycVFXcDZzMDFYbnpPR3pkRjVZTU0xeHhSUC9pM1prT1I2bnhV?=
 =?utf-8?B?dHU0dmFQcEZRY2VMWVpCRnQvMjNiaDVrdlE2d052dkp0V0c4MHlML09WM3Zt?=
 =?utf-8?B?Y0d2ZUZORXY1QmUyUWUzcjJOWW04VVBLTHcrYURmeWcyV1l3SjkyR2lLQ2xx?=
 =?utf-8?B?NTJkY3pkbFh6c3ZwWDRWRVpVYmM1c1ZkcWhyRHptQXhpQUJHM0xvc2ZUWFVk?=
 =?utf-8?B?cUpjOTlsZE90dmY1OWxzWHhLS0h3MlFjT1NLN2Z5T0dRQzBPS3BBVW9kSFVo?=
 =?utf-8?B?UTB5R3A1c2lkZDA4TWhmN01iaWJGbHlrWWlkVjczSVprbU8xczBRdENyaUhL?=
 =?utf-8?B?aklsYWI4a0dKYm5OWXpPOFNpRDlqS0dDVjVsNlhUMkFKY3hkdTVmdzlRUit6?=
 =?utf-8?B?ZUdYNTBVQWlEOHQxbEY4MGx1YTN0bEFMOTJvMlo4d3lZTHprSGdydE9FWGYw?=
 =?utf-8?B?dTE4amlES3hOKzF4ZndsT1ByTHJyWWx2clFFRmNYRTZ0L1pZWTFGODJWV01x?=
 =?utf-8?B?ZW1qNWd6WDB1REE5WmdpOVBLUWJrQ2hLT1ByNnV5L3ZSTXV2WHNacnpucjdL?=
 =?utf-8?B?aVFUb0tMZ05XOUprSWNsVmVVRHZTN2Fxb1M5UmZiOXIzaDlTMDRneXd3bWxu?=
 =?utf-8?B?YmhvQWtTT1NCYXVxYmRaek1iVmJoaFk4cFBPQmpUVHdabXJ1RmhZTlpkeGJB?=
 =?utf-8?B?TTR3Nlkvc1ZYUGpqU1hSZ3VMSGlIejUxZjl3ZjRvSkhvOThNMFVCVHR1am1S?=
 =?utf-8?B?VjRaTG1NS0FYT1JOcjNjVGZlcWJNZTFxZVJKVnhsSmZZbGhPSm9lMEpJUldQ?=
 =?utf-8?B?cUcwV0JKaGhIcHo1MUlyVVN0SDdDRFFidVhpdEc5WngzcEpMQnN5Unk4TCt3?=
 =?utf-8?B?cVBxVHRGd3MxbkJ4ZHRMVUV5NnR2M1JoVVNEcXBlck5GeStLRjczS05na0RE?=
 =?utf-8?B?UnR6R2RpZ05jN0FqT2t3Z2VndmhQUXFqcGFZQjRTK3VBVkYwWFM4YlEwRXo3?=
 =?utf-8?B?MXRRV2pFSGZjb3ZGMmsxVmdqcUdXVUZ4K1ZDSlhBTk9WWmR0NE42Wk5RdDEy?=
 =?utf-8?B?TGFPU04xMEY0bVlUOEFXSUg3U3lQakltanNGRkVuY3FsS251Tzl2ZDMwL0tm?=
 =?utf-8?B?NWxaMDYvNnJiNjExQ0I4OWtCc2JYemQzREkwQkNyYWdOczh2cTUzOU9ZcFND?=
 =?utf-8?B?VE9SS3M3RGJ3bkwxblBHYkxGL3I1RnJtNE9pY0E0YlNiRk02Rm9PVmdsMlpx?=
 =?utf-8?B?cVpKUnByZjZKazJHTkdseEw3SFl0YWRrYUJyeGJRQWJuYm9Tb01CN0lEWlJ1?=
 =?utf-8?B?V3lOUTlya3ZTQWdLcnJ3b0VEbnZsNm5nVFlFZlhrSVlXVE9Va1lCSE83SE9N?=
 =?utf-8?B?d1hlcE5JenkxYkVIUHU4Vi8xbndtaURoejJwSXVmOUlNM3pqZkZzOG5tMlhX?=
 =?utf-8?B?aXhscDNvUjRTRzFaWFg1VWl3NXZEUkZtbnhqRC83dXhYQWtCQTRsY1VlNG94?=
 =?utf-8?B?TE5INUtOQlcxQzYyQ0pJVC9aUld5TEY5Z0M4L0FvOGxrS2MvQ0JrUzRWYUov?=
 =?utf-8?B?N3RMOE0wb0xqdFBBK1BkVkpqSG83bE43NlRMUWxkU1NqZ3ZIeXZRdz09?=
X-Exchange-RoutingPolicyChecked: k6YxRvZXhx25R5+BIhQ+m6XNHoCeQwEfSt2SVT8MDzWMvVMHvWlDGAx0USMFe3WFYIBqxH8sPe9Jvc9YhdaL5G6/UXP6zw8xN+XZp1i1aAr4Tf5nAHsMMGFiFgr53QV1yvZtbCkPhWyRSierGyA48FFbqTh8kNaWxu9yjBQaDI49kzd1/g7UbPeNIf70BZB8CHue+UFHHjgEKzLrsbjsrxgevM6CWLaFu01OkqXi/USyfjsHo+VDZ2xrRAxgXJysCW+ije2+ZEH/Abujz/Rg9ldQARuQdohLfbZ7A7TqYX8MhF01piJGJOpVX/4vB+PbLaiHD/49Z3gnbmRCTOI/Sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cb5978-f042-4b9b-c3e8-08df0801c821
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:19:46.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 431hWURDAPnWwuMVvc1XbrwUoSZcAAb+ZJ8h0txvx29bQuqJcvhPIEJsGVnjd5q/sv42P/KJcn6mH6eCvmE0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
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


On 01-09-2026 02:33, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 03:47:58PM +0530, Arvind Yadav wrote:
>> VRAM is no longer usable after the device is wedged. Reject new VRAM
>> allocations with -ENOSPC so TTM can try another placement, such as TT.
>>
>> An allocation racing with the wedge may still complete. The wedged fault
>> path prevents new VRAM CPU mappings, and device teardown releases the
>> resource.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> index 05911904c1f9..d0b266672010 100644
>> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>> @@ -54,6 +54,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
>>   			       const struct ttm_place *place,
>>   			       struct ttm_resource **res)
>>   {
>> +	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
>>   	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
>>   	struct xe_ttm_vram_mgr_resource *vres;
>>   	struct gpu_buddy *mm = &mgr->mm;
>> @@ -61,6 +62,9 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
>>   	unsigned long lpfn;
>>   	int err;
>>   
>> +	if (xe_device_wedged(xe))
>> +		return -ENOSPC;
> is -ENOSPC the right return here? -EIO? -ENOENT? -ENODEV? -ENXIO? -EPIPE?


Thanks for the review.
I used -ENOSPC so TTM could try another placement such as TT.
I guess there is no need to try another placement after a permanent 
wedge because the device cannot process new work.

I will change it to -ENODEV so TTM returns a terminal error.

Thanks,
Arvind

>
>> +
>>   	lpfn = place->lpfn;
>>   	if (!lpfn || lpfn > man->size >> PAGE_SHIFT)
>>   		lpfn = man->size >> PAGE_SHIFT;
>> -- 
>> 2.43.0
>>
