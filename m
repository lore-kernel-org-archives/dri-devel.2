Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F2C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A1C10EF6B;
	Thu, 30 Jul 2026 14:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hAGXC6NU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC0310E17F;
 Thu, 30 Jul 2026 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785422727; x=1816958727;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mVk2fpBMlInhkzCO8W6IONX8Wd7B3/OWXUhD+Xt6SaM=;
 b=hAGXC6NUvvBK3kNqm2fu6u6ib0Bq/1wnthJKEkHB7w4k55AkjLh/wnTo
 3LWYqMJNdQGjfNpk+87EqMmFwQkoKt8v5Q6RULULfB/FUN7CcaAO6MQae
 CFagf625yIfzszfH76VFB+zF8Bxw6gZYVgBfqPky8wamD9PufDXpvsfib
 y9I36HoXrfl+3UbObayOPic8/CLIY9FQAOZnS5yUnC/vrxjmizI0lvZXv
 K7+7/hrgGob0tDi8Cq15oRV6O35CPCxuxKBGnDz5nxMvyv7CwqgV+6JMq
 d6N4rUiKybUh/QVKvMD/ArJs07EikyHpBL7P3TfdD421K6zrjSvvr7y/b Q==;
X-CSE-ConnectionGUID: nt9WfBeZTgeCfE9FM7nIyw==
X-CSE-MsgGUID: 47ezuXz9RBCSz1QIeeQzcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96401290"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="96401290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:45:27 -0700
X-CSE-ConnectionGUID: cWhw3+FGReuLiTqEcsE04Q==
X-CSE-MsgGUID: 56ZzCgFcSS2pp3SDCDKgsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264112614"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 07:45:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:45:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 07:45:26 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 07:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjOJcF2VVX37B5BWE8G144udZ5LuKUTxXjO+UA9mWYnoPvzDJ0NcWFVNE7nwfGqwoiZMx07NcRnr92nVW1JU0ctkUD/SGPWQRQ2E8EiiAylpMFXr0+Agkq5XuJvBplxAFDCvgb8kEtj03iomxjIncC5a2j4jsjRq1vEQ8FgDNi/8GV2nW0anrT/sMsc54HaS2K73twjROcsyilp7Xg5QmqKvf0qLyzueGkgGKC6MDZCHnPWHv5R3QPh7/AReZ56oKLsoOoFg5eZgJXXp+XnhZb0Dp4t3CTIykh03qJLEp4hl6m92/KnlrdqaNSviLjWfUQSo/wmghreQAeu2KtTHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdmMiR+o7/7xo9kjC+vo7/Fk3VDw46fWiynU8VpW1f0=;
 b=i/eomDn7+38lBVoI1Vc6k15KSjYbOLH2ImYVEaU1kVXCigPILs2JySJbIi1M7meSV5/oLioDv0f48n078EZ7CROcCv2jGEgHwUnha5fXrM8GOHPSLblwaMajm3lM6wsghD14150aS9/hIXtjjCOLMMRR+TOeRvm7Z6t8IyBK+Teiy9ySPJ6XXShV/3CPF28J+8WmfRTprDnI7STtf489W0jDCzkHJyd9vXz0JBPJ9/V4riOzcpBHYvu4TyIyJhZJPRl82uIs1MP5z+HKYJlsXk/vagrGUpHEOtYMm3Hj/A8Vp8j4kqg0w4XNhm2Z0ucElJ2pL5QkLe2JP9pC2Qg/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 14:45:22 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 14:45:19 +0000
Message-ID: <2147165e-9dc9-4bd5-892b-8b5019ad9c56@intel.com>
Date: Thu, 30 Jul 2026 20:15:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Pekka Paalanen <pekka.paalanen@collabora.com>
CC: Robert Mader <robert.mader@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
 <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
 <20260730172758.0c65485f@fluorite>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260730172758.0c65485f@fluorite>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e6b5d0-572d-401c-8e04-08deee492d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DhvLhVptjKUvCoaSnGp4vGEkstkC5oWKjeaXL9RXcvi3RIvgD6/OemMICt2di6lQbYd4rwXct0waZw04N3ZGo30VyWXRbPJfKBN67C3EkfYZc36t/yHyLopxkpqs7JdWoBA3aXGLn88//ba2FiWYK7bc9dSnXImthYUJ+yy3P1SDqsetBWE75JaNwodJc2TxTKlKYcx/nVZbV+iF+MQ8kyZd5P8jySiq+2Jh+0UVeSyyH2E3a81fHqDsTjAG9NzHsU+2F2kj7kr4IxcU8m6u6FPV218azibC1A52MoB/KfZvu3kdiNB5SvFaV3XxKM4AhV1ba8+fR93mz+xwG6TDSqGNAltGE5je68TM5r9s8AeDWEdCLDx/pIvogb84eGvt7qlOB161T0/Fkk9G0zptW7AjQ+BIepOoIV3enHXkF/ALl3oW+MSrzQFMOxUwYGAIi9I6Hwl7/PZ8FpVOX4SZ8IXaRSkUt4Wd/hD39EF38t9atBYm/dmYZcTyL/148LqbfA66Drq5f6nTA38uWpliGPfKg7UnEm86+v9VZMvUi37ItKtrnBirNSnva77rxbk4QfCT3AjG2NsToXxcLRxCQ1tWZOxLiMvQA/oX8Hib997VM5J4E9sm+iu3Wy56htDiaOE+mVedKqb2M1/flyBXQcZlj4IoDqPY3BP6evniyTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJsNGthN29DWVArQWV5Ly9TaldLaUhKdnFpRzQwaVAwWUcwOVlxNnNuZTNs?=
 =?utf-8?B?QU5Ka3AwRGovYVErTWJ0VWpaNlExNGVmdmhQcDZhTWVHOVllTW9GVnRzQWpL?=
 =?utf-8?B?dzIweDRoeGxDcU4yYVJ4SFFOTnM1MnpaRUZ4bFNsaUttY0pkZ2pacExTbUVH?=
 =?utf-8?B?aGx2clBOOUVFbWdVVjM3TGZmKzg4WG1yVkI1dlJIVU93QnRrMEZZUXIrSHZC?=
 =?utf-8?B?eHB3YVQ3a0RJR0cvVjNUb2FCTStTMmYwV0VWRGM5WGNNK0pkTlhzQmVNbmtQ?=
 =?utf-8?B?S0t1aHlTSVdIM3YyZnMrd1VVeEdwbm91RTQ3THBkUWtwY2tOUnlWNkN4Wkll?=
 =?utf-8?B?TGJXY2MxSktBbWVWaXNHTHFhZXl1cnhqZU5Gd29XSU9DdzlBaFJVTlB4dU5j?=
 =?utf-8?B?UUh0K0tMOXNWUUNsaDQyZW5ZdWVtV0hQVHJVMkpnWDNYVVZOVXpQUUJaM2k0?=
 =?utf-8?B?R2toZzBjeHFmRmR3SituRStsajNPMU1ORzNyM0o5K0t4SWdmOEorM0J6RVZQ?=
 =?utf-8?B?YWlobklReE05TUlLcUlNNmJLVEtkRVhnUFhTbzgzS1pvSEkyUE53QUxDZGE0?=
 =?utf-8?B?VUd6MS9oWEV5ZHNZTHp1RGRWZmk3RUpaZjNTUmNBR2lnSHVIbVpIQzhqR2dE?=
 =?utf-8?B?K1NDMWJnditzVUp6bVJ2ZFNVOXpGM1l4aVRvWFRrdDVFK3F3dVNmQWx4dHJn?=
 =?utf-8?B?VDMzb2lWY01NOVdUTDNXcndYajJwbDA2UWpQOWFpK3hMZ2JiMGYxMlV4ejN5?=
 =?utf-8?B?V2hzaUpCNzdiS2p1ZnlocG9lOVo3NzlweDdqTlNtalZkVU1sS1VMMHZUTTlY?=
 =?utf-8?B?bGhHbWlJcVh1dCtyajFHNmVwUTdmcHUwSVUvM20rUENqU1Q0cTFieXZMclhi?=
 =?utf-8?B?SEZDWWVUa2lydExNdllqbkRVdWFQanBwaE9VREdZUjVaamIvaDZFdHpHRDNQ?=
 =?utf-8?B?ajZHMGpER3dLZzFkTjUvcDVXeTJBRU54aUl6dVB1Z3dobHhtelBRMFhBV1Z1?=
 =?utf-8?B?OEd4RGI4ZzB3Vk1IVnZZazNoSmlqWHZsUWd2Q2lzSW5yRUZnb2xlR1htNU5o?=
 =?utf-8?B?WnZQUU83cW5yWVA0RHJDVVNlOW50clhGVmRodVlFTFhsVTJBT3d4MEVldlNQ?=
 =?utf-8?B?VHkwZWo5TVdSNmZtaXhiZEdmRU4vbFpmV0JSTmo2SjJ0U3FzKytFcG9tMkNQ?=
 =?utf-8?B?dXVMYzNPTk8rMDVUbTh1aDhNTGxXMjJuMnhPUWVnWHlqQjdiSWtodU5waUVU?=
 =?utf-8?B?dWdZN29ieHlUWUV5U1o3M3ZKUktkSGR5U0N0RGFEU1lHalh6YTdCSmJPRzZJ?=
 =?utf-8?B?M3h2WklZR2IrRU4vbHkzQzFuUzBLMDF6THJvTUVTQmZ1dW01WUZpSUUrOGpH?=
 =?utf-8?B?ZVJkRHJGcUlMazZEbWhIeG5OTzVTU1VsN0VIRGQ0YkZtZUxBcUFxOW4wK2I3?=
 =?utf-8?B?RlJUWk1VejRwcStVQXY1RDVaTWJQQkJBb243M0pTM0N4TEZHL09aSXhjeGZS?=
 =?utf-8?B?alBxVVNLU2dhWkRXcHRRT2hESCtHaGRPZEtjdWFpbnBRbS91UDcvUDRLbmxr?=
 =?utf-8?B?VFhQbE8xUk5UMWVCTHYxNWttYmlZcDhIdUhkdWhELzliMXg3UXR1NnY2azBP?=
 =?utf-8?B?WnBsWTR0eFMwcDVZTzBsRG8zR1h2dVEwSS9vRUlEN3VpdDdsT2Jjc3RCTHJK?=
 =?utf-8?B?ZVMyS2h5ZXBvRVl6cHRnNWhBbSs5Z0lFNjlmcFdlTUZyM3NJdXphdkhoTnRI?=
 =?utf-8?B?STdwQlBQNTBXMTB3ZWlIUzVvbFdZREhsWVNWM1VUTGdhUkJtV1huVzFWZi8y?=
 =?utf-8?B?UElrUDQvb3JzSlhwR09xTDZqaVZKVUo3enNueSt4bUVTeHREb25oeGdKcEhD?=
 =?utf-8?B?ajFSQ1M3OExMdVhjLy9lTXZkU0VhTjZjUW5uZGVnbGU5T1U1WGhaMnFFWDBv?=
 =?utf-8?B?VHZTYTVxVENKcm5IWWZDdE85SGNvRTZ3c3pjSWFhUFExbzAvVDdCMVNtL0Z2?=
 =?utf-8?B?R3MrWU56dEsvRzlpc0VuTjNxaTB5Q1BmYk9Cd3RsUXhvQWpLeXdPWENOd2F3?=
 =?utf-8?B?VDFRN3k5eXlUd1hJY2FER2xHRXprb0h0K3lkL2dqcVcwSUpjUjdtVEdzcXln?=
 =?utf-8?B?b0t6RVBIcFFBOTY4clJxZTRuSWUyc2psSmhsTlNpTHIyaCthcTRlNzgxdzc1?=
 =?utf-8?B?V3BsTk9nelRBRkJOSEo3L3J0RUFyU0N3Z3VVeVdPcGpjUytXOEoxUVJOR2Q0?=
 =?utf-8?B?dTlSb3Z2SVBwMnlORWN2cWlJSXpMUEVPQnloY1FwbGRqVlRwejBoQXZ5TFRj?=
 =?utf-8?B?NW5NYUg2L3YrTzlMUkUrdWJtVHNJbjBEZWlWRm9senBZZ0U0RkphR3BSZkln?=
 =?utf-8?Q?CYNUt1PDXIHdyeOiQ3R1PY7mzaqvwo9/NMU1Q?=
X-Exchange-RoutingPolicyChecked: mQtMS+a7RWQtSiP9BiV0IirH5hAvXU4NzYqzxcYWPPtuiHbN2BRGWNIfxu6ybhv7eLxkE0+4Gn4MYSEPiD5S0Wan8DSOh4eL1q6lNylox2R2wOu49eZTaNy17J3IGjXeKzHusRCgIh/rtS1j4jA3fHzfQeXzia2J70u0bNyY8Hm7eB09SI2uoaC/OaHHYlL7CUHh17RwJxuZH09KKlLkQTiiFagEc6WR8E0qm1sZ279UafnLp1YU4bplxf7OM7hxs31Q0eoCj08US4I9G+G049WoF6rIBms+dv++68qOjb9xisyOLVqQHxP9ed7E8DlePMri4hhaZ33WQvmDQ/clhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6b5d0-572d-401c-8e04-08deee492d58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:45:19.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nc1ZqcvbpEJHpzl6elngcg5R/M+LQhUffVkIWCwfgPxNwipca2KSJ3g4jzJbovM48Nbythc3xRzOd989r3XZg4SuqLzHArH5fPaDn6o7o0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
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

Hi Pekka,

On 7/30/2026 7:57 PM, Pekka Paalanen wrote:
> On Tue, 28 Jul 2026 21:30:14 +0530
> "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> wrote:
> 
>> Hello Rober,
>>
>> On 7/28/2026 8:32 PM, Robert Mader wrote:
>>> Hi,
>>>
>>> On 22.07.26 15:45, Harry Wentland wrote:
>>>> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>>
>>>> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
>>>> hardware that performs a fixed matrix operation.
>>>>
>>>> Unlike CTM-based colorops, this block does not expose programmable
>>>> coefficients. Instead, userspace selects one of the predefined
>>>> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
>>>> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>>>>
>>>> v4:
>>>>    - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>>>>    - Document matrix values (Pekka)
>>>>    - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>>>>    - Fix confusing "CSC preset" doc (Pekka)
>>>>
>>>> v2:
>>>>    - Naming changes (Pekka)
>>>>
>>>> v3:
>>>>    - Fix NC matrix enum name and string (Melissa)
>>>>    - Rebase
>>>>
>>>> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
>>>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>>> Reviewed-by: Robert Mader <robert.mader@collabora.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_atomic.c      |   4 +
>>>>    drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>>>>    drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>>>>    include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>>>>    include/uapi/drm/drm_mode.h       |  12 +++
>>>>    5 files changed, 291 insertions(+)
>>>>
> 
>>>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/
>>>> drm_colorop.c
>>>> index 682fcc651525..e7ccf7d053b8 100644
>>>> --- a/drivers/gpu/drm/drm_colorop.c
>>>> +++ b/drivers/gpu/drm/drm_colorop.c
>>>> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list
>>>> drm_colorop_type_enum_list[] = {
>>>>        { DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>>>>        { DRM_COLOROP_MULTIPLIER, "Multiplier"},
>>>>        { DRM_COLOROP_3D_LUT, "3D LUT"},
>>>> +    { DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>>>>    };
>>>>    static const char * const colorop_curve_1d_type_names[] = {
>>>> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list
>>>> drm_colorop_lut3d_interpolation_list[] =
>>>>        { DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>>>>    };
>>>> +static const char * const colorop_fixed_matrix_type_names[] = {
>>>> +    [DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to
>>>> RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC
>>>> Limited to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>>>> +    [DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>>>
>>> I'm still a bit unsure how useful the later two values are,
>>
>> You can see them being used in [1] and tested by [2]. We split out the
>> "YCbCr limited to full" block because some Intel planes have a 1DLUT
>> between it and the "YCbCr XXX Full to RGB" block. This keeps the color
>> pipeline consistent with the actual HW.
> 
> Hi Chaitanya,
> 
> it would be nice for VKMS to be able to have such a color
> pipeline only. Then userspace authors can test it.
> 

Sure! I will float something soon.

> That gives me the idea, that perhaps there should be a library of color
> pipelines for VKMS that replicates actual hardware pipelines. Maybe it
> would be in the kernel, or maybe it would be in some userspace project
> if VKMS pipelines can be crafted through configfs or something else.
> 

Sounds like a good idea. Worth exploring.

I'll give it some thought, but no promises ;)

>> Based on your experience implementing the colorop in weston, do you
>> foresee any challenges in supporting limited-range framebuffers using
>> the "YCbCr Limited-to-Full" fixed matrix block?
> 
> I cannot imagine a big problem, but it is yet another configuration
> that userspace must be explicitly prepared for.
> 

Thank you for clearing it up. We will check if we can extend Robert's 
implementation to support this.

==
Chaitanya

> 
> Thanks,
> pq
> 
> 
>> As for the "RGB709 to RGB2020" block, I can see it being useful for
>> converting SDR Rec.709 content into the Rec.2020 color space before
>> blending it with an HDR plane.
>>
>> ==
>> Chaitanya
>>
>>
>> [1]
>> https://lore.kernel.org/dri-devel/20260720045131.971650-1-chaitanya.kumar.borah@intel.com/
>> [2]
>> https://lore.kernel.org/igt-dev/20260727185531.4046807-1-swati2.sharma@intel.com/
>>
>> especially
>>> as they are not implemented in this series - IMO they should be left out
>>> and be part of the corresponding Intel series.
>>>
>>> Anyway, still R-B
>>>    

