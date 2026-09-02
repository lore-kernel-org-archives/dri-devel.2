Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F944C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117E810E438;
	Wed,  2 Sep 2026 04:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZiIF5rMQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB13710E432;
 Wed,  2 Sep 2026 04:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788324577; x=1819860577;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rfsQBBeWf0BVEmXO04ba0u1M2TTMYRZl/GJK90zO3qE=;
 b=ZiIF5rMQgcdaxrehMeBrNfPk93QqmbV6erKOAoE7yFSt0z3gX0Jc80IS
 AnufO6M8TcExHfSr3XWrD6J/bhUzYmMbcvjsYLYRFsye5YcQt6hYh2CFi
 G/vCLKZHrqS8acd+QVGRgePCJd7ZRfTUfFGe4pPAIB+GNlijJZWASp7ZE
 mx/8X49Yh+RYy2sO1DDO4U0SUydBQbnmv/oUzKxB/d2TGGNZemVOmWCbd
 plMD+PGXYI+UQqZoJY7WVUyTUfQriQgeg/iuBh6ZaGfOStzm+2bLDEgQ8
 ciI+fTviLQStYJHC09mMG9h9SeZLGKwyk2CgO0+hDtRy6U8v3/aWlc7MR Q==;
X-CSE-ConnectionGUID: 4sLIH/m2Q9+AdNJmjp9Ggw==
X-CSE-MsgGUID: bkbE8piNQAaimVuM0F8rhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99368991"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="99368991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 21:49:36 -0700
X-CSE-ConnectionGUID: Eq01Xxv2QAypsWcpm1FIEg==
X-CSE-MsgGUID: 9CbQB5NpTBWYerBSWPWFEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="267527299"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 21:49:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 21:49:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 21:49:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 21:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV1i52t6A1azYsHGDT1PwDGR2OdGT9ig7L1S4qUHThAMT84Q9SrbvGil3Qu9cByZj/HzRDXKw+h/lD9hFwu3CZV5eQ1ssI8qN+zA3FjGhvHbUulLONEz7oKVF7R2iVgFF+P7ozgXy6nZtItf6+ELX0DeA5w/Iz1opK2St1U4hkrnGWNoOqy26oVlBGO5tC2skxVl5r0vo9fmB0nFGHvu+btGWArywRoEa1OSAj/2rO02C/2EMovnAakh1As/q2E0Zg5oYOyKxucRe78wA8JMoL5SJqTPQ/9VfNz2M2M6XA/kuVB9THJahvoWpQ5Wy6wG7Rj84OR0STmnQe/sks5WKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Oyvo5kDIZFYg/jZcjIOIuoKtQOm00GZNpUd8L9bRA=;
 b=tNaxtv5Oeg8GDQmtDm0KrtukUQ4NU/DTOGA6s2ovT5PzC9IQpif84VPqAUyEkk1bQhmialrvSmNtdDdoQhI/rAjZDqRug8R/rqEhu70uhNqNt1ix7gQ/LWqoxZLhVhO3vaet/yf+TyecqEHo22fswftiCJGuiOpT9GvaeLcszMDrcPjJlmW48JeNfnR055U+if66G/oHFRbw6YcsR+gTj71F86e26cMoxqJbpcbC/0mZVccAE3XRKjHxtcpOdWt0XXgmyzDnn4M2snwX940s9fCJ/a+B1dpTpoMqtRbsEaQbTtUJlkaaeJYK8Yy8ip+oeczSDQNolH4E7cAxC8v0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 04:49:32 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 04:49:32 +0000
Message-ID: <ec7667c6-edc8-497c-97f5-872ba5d63bc3@intel.com>
Date: Wed, 2 Sep 2026 10:19:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-4-arvind.yadav@intel.com>
 <apXnb3_WmpYhPeUo@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXnb3_WmpYhPeUo@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0175.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::6) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 846a0ce9-5a44-4c7f-410f-08df08ad9438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gwX2iurM42+YdnpmaDsvnrWlzjcLCqy/0MlSYeKG6Hf4bGUyM6xs3F0scHF6H7BcdxKxXaIFFTAB53rS4fTFFicKb0CPwtvALWYuzV3Idul+SImwDEWohkbQTKhPlpc+FScZg3c0V0PwrR14qVBqLcLfnLyTRWFHqXWRKiFD+ypNHl1F8S64tNWkrogCs+kFD7O5DJbqfGwhZijvI4elNivENIRcouJojYBrHiw4J5pjm68KGj9nApZnZ6xmceqXw8xDJO8VOeSVev+bgMIW+65I0exDNWOJwOEJSFtjgjMNJOsskHgrkS9+/9aURsMMMK6JJNPuQuAvuS47FD7nPC4FIatVGYbm6TtM2HEFOfWH95o58wNMj7pqeHNIhH+yJHl6Sc6SsL21koN3TLXVNos29aqbCZaHweVZvWY0LSGuh57CJ/FAa2JQoo6f7CLZmyjHC5rIR5AtYw/thkGZJWosF3Yu407+I7Av69Ac0GNdMuEdMFTHuC7NcvxN2Fmov7/vs5uS5JPfOnQNruhujGsKju+P5QRiDknmMw19P+vPitBCxGUc0IN9dphKjlXuYhesr37ULYOvYooLK4Qy4U3IPlMkFmIQRK5/7NrSithEIzxfEEeNOVDBaDoe3gJ+f2coo9r9kwL0LPdaHLC8ePNLos2Qx0DjFdYcpc5BYSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG85ZElzMDRBeEpLMTU5dTBDYkRTSFJXdEpUUlorQnNTUTFvNHBNWk0rU0Y3?=
 =?utf-8?B?bGxyaVVBRjJvZDNrV3N1VW55bWtFK3hTSTZpck10MFpUekVVa0U4N0krY1JH?=
 =?utf-8?B?Ykc4OUhla2NRbTB3NzR5bGdRdkhKWkI3STJLRUw4SDN1S1c2TkNlTVFuc01E?=
 =?utf-8?B?cFpINE96S2Z2ejBLbGJUamJqZmVDdG1LSm8vNkVZU0pFVTlvUnZPbjdlUGpp?=
 =?utf-8?B?Ri8zekRITDhZUkJUM2M5c1JzTGRBQWsyK3VLa3loblpYNkhicjZPNTNjVEVt?=
 =?utf-8?B?NVNIOWovR2xuTThFYWJES242b3J0UWkxUHhlaTZ4NFhtajJnUDl5bm9ySzcv?=
 =?utf-8?B?RWx3RUIvbnhzYkRTM2Y3aGVtRjVwV3RYaFVLK1FWYnFMYzM1eTNKcExRZDA1?=
 =?utf-8?B?UDF4dDBHUFptOW9RRk5yak1WSE1mMTJMMHVwRWdSUWhBbUpxK3YwUVBubER5?=
 =?utf-8?B?bzlXRFR5aytYbVEraW1QZHYwQVVoeWpCVDN0VVJ0WG9nWEczZjZoM3c4Qmkx?=
 =?utf-8?B?KytvNHpqVHNMRE9qL3lROHd3aXF1eFBPVDlnVTNteG1FbTE3TWo5ODdmVldp?=
 =?utf-8?B?VzZyNUpTbkxWM21SbFlaekVCVnA1UWdXdmdvYWpPazh1NU42VjArcWo5azRy?=
 =?utf-8?B?Ui9oblUra2l6SFRyWkQxV3EyYytNaFkyZndLYVNPSUFHRlJaZHJaNThIbVhT?=
 =?utf-8?B?ZlVJcFE5S1ZvdXdiaTVlV2VMT1pkZHBGY2RWUHBIczE5aDBPSGtVS01kaUxY?=
 =?utf-8?B?MGFtcUZoZE9ncktTZGdKQlJRL1BhbFFub3VTeFJ0bHBTZWJLbFpUaW51WWlw?=
 =?utf-8?B?RitibWptTjZRcWJaWi9kR1l2dVBnQWxnOEs1Wjl2ZlFNanh3Y2JUY3JZeG0r?=
 =?utf-8?B?dE9SR3dHRXFNKzNBczM1dHhzZDB2UXRyTDI1S2JnbFZseGdvRzFLZWFxZEsv?=
 =?utf-8?B?R2ZwMFBUbDdKcnk0OEdvajJBdHBQRlVWM29FaVFHNXZnOHlmSVo2Smg0dWwx?=
 =?utf-8?B?UEY0S1FiL2lWejdLVmFLenhsNVJyamhBWGYwMmFaTEVRWkl3ajZMTGZCOWIx?=
 =?utf-8?B?TkZFRElOb1crZHRpT1JDVWdPaWJEY2RpdkhLSG9BdHNXbEo2UmJYK2lRNDdQ?=
 =?utf-8?B?VWhKU2lHWTJUQXRhTjNIVUlyMUFKRmxXOXdQT01vTElOK3c1T2dnR3NZWWw4?=
 =?utf-8?B?M3lXdU9Wc1pBbWhtZzhHQWk0QzdXeXZTelAxOFBqNGsvb3NQNG0yUkxUQ0o1?=
 =?utf-8?B?ZnY1b0dRdktuY1RmellaVEp2cEFoZjdsR2N5Zm9USnlnWjZ6eWRiWVNOYWpO?=
 =?utf-8?B?emZiSG1FZjJjekU4Szl4RmFCemhvRGU4L3FNWGlPU1JXcjA4R2NtWmJkekZP?=
 =?utf-8?B?Wi9xWC9JMXNRQlF6ZkE0U0ZqM214UjlRaUIrdStSWGlLOUlxMks4ZzIxcmJm?=
 =?utf-8?B?QStzeWJ1Z3BDYnJHR1JMU1hHN1JQdVJzcEJpNWlTZncvdmtCRUw2NDIwSDly?=
 =?utf-8?B?aUw2MUR3bEJGVUtOaytKMnRXaXF5MHlhTG1mSks2RHBaU0I1SlE3ZGtOTTRW?=
 =?utf-8?B?YUhSN1dhNnQzZUN4WlBtNzR0OWZqaFYzcUlNRlIzSFB3cUphRE12M01NNFJM?=
 =?utf-8?B?NjI3L2dDNjljMDBNNkhBeDhkd3IwUnhmLzZndEFMcFowRHdCUkxab1Z3Yk0r?=
 =?utf-8?B?T3FsWkI1Zkc1WW9xMUVVWFV5eEh3YWN0aTF4Vm83ZWxCR2ZWb0xYSkZIOW9r?=
 =?utf-8?B?Z0IvUWdxbkpzK0dScmI4eW5TRytqcndhVStVZkllR0h5M0Zuck5mcWlidFVE?=
 =?utf-8?B?bTd1eHh1WndsN1ZBS1ZMOE5DNloxZTFPSk5LZE1iSjJJUVNjby9INDRJUWtu?=
 =?utf-8?B?N3JlVG5WRjNFZ3MzWFZVbkJuRDRaSXlhSnpLOVFRRXQ5YVpDVzJ6WHk5Tzcy?=
 =?utf-8?B?c1IzeFljRUw0WTFsVmp2QlN3cWZ3dlVRWXJkL2ozVHdWS1dNdFU3UTVqeHVD?=
 =?utf-8?B?d1o5TjNSa0JTUXdoeDhaa1FQcWhMRytiWmRqbnlkNFZYLytCQXhZZjEydkww?=
 =?utf-8?B?THBTaDFVbm9QWi81K0lYT2NsQktwRTZWaXNLcGtGb1FqQjczSCtQaHlsUjdF?=
 =?utf-8?B?Uld6cUc0ZXdlT2UzSHdCR1ZMUFZpbG1WSnQ1MHZjc083TENYTjV3MWlOb1R4?=
 =?utf-8?B?YUZHdjV6WUFNcWxCREcyUEZMQWtKRmFaMkE1Slo5d3BPRkNQTHRjVEFEMWFI?=
 =?utf-8?B?OU5GT1ZyMjZESStzMVVHcG1iL0kxd09uaHhOUE53TEMzU09MZ3FBaWl2RXJ3?=
 =?utf-8?B?OVJsVSt5OHBZdzFEQU1VcUM1Qkd0TFdITWhvMVRvb092VXk3clVHQT09?=
X-Exchange-RoutingPolicyChecked: tU7P+yiaokJd3ypChGbWQqICsRYqG5JhJc2YR4KBezBUCeLl0/nFQUiGWGFsXattlet288MYKY7Bx5Wjrn4x2Z7JGetJYowcw9H5zHDCttBipoif0of/0sps9Jd/LrmTPmFGOgbskSiuOV1s4s1CbKWDTlK6C1e3xLsn73J0hQ3OCxqJYFkaVTJitvYn3/fr22OfJpBX+pYFoCTQE+hUBsToePuIRlzWgAHrT97l1WML0tXfIzxYcSuaYsSNUJuReOsf0bdUQ1oJOiQmuXYJf81N6orPUpt5qQ8BcZavDGmao4w+JoNfn4XZNt75qU5GaKN0cbUrJkq8LoSASFTY3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 846a0ce9-5a44-4c7f-410f-08df08ad9438
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 04:49:32.4582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwE3M6oR78ru4ZU/ySvk577S2J8s+IRiM+fm/xu7zKZNwzBpGo+UEN7eDx8cNMPdk8ktUUDxVWBsEFrpa9Mvyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
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


On 01-09-2026 02:13, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 03:47:51PM +0530, Arvind Yadav wrote:
>> Page-fault work may still be queued when PCI error recovery starts or
>> the device becomes permanently wedged. Servicing these faults can migrate
>> memory or update page tables after device I/O has been blocked.
>>
>> Check the device state before and after fault servicing to cover a reset
>> racing with the worker. Drop the active fault and its chained faults
>> without sending a hardware response, and invalidate the cached fault
>> state.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
>> index 2e415995f067..f486165f2323 100644
>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>> @@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
>>   	xe_vm_put(vm);
>>   }
>>   
>> +static bool
>> +xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
>> +			     struct xe_pagefault_work *pf_work,
>> +			     struct xe_pagefault *pf,
>> +			     u64 *cache_start)
>> +{
>> +	struct xe_pagefault *next;
>> +
>> +	if (!xe_device_io_blocked(pf_work->xe))
>> +		return false;
>> +
>> +	/*
>> +	 * cache_start is private to this worker invocation. pf_work->cache is
>> +	 * shared with fault producers and must be invalidated under the queue
>> +	 * lock.
>> +	 */
>> +	xe_pagefault_cache_start_invalidate(*cache_start);
>> +
>> +	guard(spinlock_irq)(&pf_queue->lock);
>> +
>> +	xe_pagefault_cache_invalidate(pf_queue, pf_work);
>> +
>> +	while (pf) {
>> +		next = pf->consumer.next;
>> +		pf->consumer.next = NULL;
>> +		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
>> +		pf = next;
> is there some helper we could re-use? I know we cannot use the pop directly,
> because it would deadlock, but perhaps we can unify some code here...


Noted,

>
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>   static void xe_pagefault_queue_work(struct work_struct *w)
>>   {
>>   	struct xe_pagefault_work *pf_work =
>> @@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>>   		int err = 0;
>>   		bool invalidated = false;
>>   
>> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
>> +						 &cache_start))
>> +			continue;
> do we really need to loop inside the loop or only check and let this main loop goes?


Yes, The inner walk is needed. Chained faults have already been removed 
from the queue and linked through consumer.next. The outer pop loop will 
not see them.

>
>> +
>>   		/* Last fault same address, ack immediately */
>>   		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
>>   			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
>> @@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
>>   
>>   		err = xe_pagefault_service(pf);
>>   
>> +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
>> +						 &cache_start))
> do we really need to check after?


Yes. The device can enter reset or become wedged while 
xe_pagefault_service() is running. The first check alone does not cover 
that race.

>
>> +			continue;
>> +
>>   		if (err) {
> now this err far from where it is collected is pretty bad...


Agreed. i will keeps err next to its use.

Thanks,
Arvind

>
>>   			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
>>   				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
>> -- 
>> 2.43.0
>>
