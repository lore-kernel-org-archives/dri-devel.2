Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F249EC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9CE10EAE0;
	Tue, 30 Jun 2026 06:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QRAZsje3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE45D10E19A;
 Tue, 30 Jun 2026 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782800800; x=1814336800;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XKAeDVovabBX7yoykvxHTUB//jK4K/EWc8BHkA9q5LA=;
 b=QRAZsje33TvwklKpciE8wxb9DdzqYN6sE9WGDpD3q6Ppr9hpA12l/nif
 qTN3NVZvNo43pjKkcqVcUD/EDvVeYIwjDbax6oj4nTRT6KhSrz9AUQ++K
 0onwsH6WhQZqKUevEFReTn/e0Ie0lrDYb9tddAogbwrU1lgxVEMHn373l
 nVp78XnMJo6tWhXJHTzuddvjqP90+pEDG0/+k0Ta0h6gOodWUZz2mkB/t
 5yS1BBTNNo7/ZHAkRJsU3JKZ9zpzB0IpRAqnMF5Ngk/os4QOrj0imOjMR
 DCYp3RTrCQDtVXfwAeGXPVxw1QSpUuAYl0Dfc/EQ85ayjzwMks3BkZAhq w==;
X-CSE-ConnectionGUID: Lf+8q0AARlKmGrbozIPLFA==
X-CSE-MsgGUID: KiJKQ3wCTPStRS8Y2fmgLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94887804"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94887804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 23:26:39 -0700
X-CSE-ConnectionGUID: rbs4/AhIRwaQU13TMwo8FQ==
X-CSE-MsgGUID: z48sOQsyQ0mzCbZna1g32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="256107773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 23:26:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 23:26:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 23:26:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 23:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYUkd3kCEIgy/QEXK1ceNO7xPOTx2hEaV9fcocPQebUFZbKgwiWXv3zxQ0LUDrh2fjDzQyQkrWagZssesfhXRw2H1MIzQ/4uvo776gd0Sl/eqjvBKf5wF6mYV8ghjDQzpMJ3OtFKM6a29IJfM/ymTDOiC/Qx/Hy2B57/2iPbor2GR9CTq58q6FHu7cPLXdplq+HxEJm3zt9w0PRNsj1zZx8P4r3WhFjzXfGgASF/zFeJoaAGJQF3ftARrIsvC41JsCTDNqCxVwSITbrgjFWNLmoBOvGQwY4/dln2hPm8STK/odEB7XDAfECCsnBjZrqrYQ5Y4ZpHOXQIwqcUObJ/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxHfuFlyTkWfkmZK14vlZhKlFpAvSnLCQ+iAtdmZ0o0=;
 b=sq+7FRUYAIlnSwCI3YRaSOxWVdSWhuWxSiwrw4o2ReJuVMHkvq68itK9+8iAxOj99fn8dy8wrHaS5hJlkLPjWWHACFtkGifKIKshH5cKHGIbOxMVN5OnxNr3vv2ZpLfVDTD7VuuzUa3CXWWxW46rPEZHrYlCUDfd4H3O7+wd8wG2yU3yuF5X3cCDwW07/41ETQjE6XcSwc2zZUXF0T/QV7Yvwa4mZhnbLfzTCjsi7P12zdDr9Dr12LOIWGSiC5AtwUF84+2jLKS0NinJgHFziPDhPRhk6ACpeeIY4f8PTJJlgtRGW8an6fL9I+mCCE/RQnKz3GJ6iBRVee22t82bCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CHAPR11MB9680.namprd11.prod.outlook.com (2603:10b6:610:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:26:36 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 06:26:36 +0000
Message-ID: <75557566-b1c8-42e6-a88d-a35bd5c63ce5@intel.com>
Date: Tue, 30 Jun 2026 11:56:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/xe/xe_ras: Add error-event support for CRI
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-8-riana.tauro@intel.com>
 <akNSDXcXa0mtwR5r@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <akNSDXcXa0mtwR5r@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CHAPR11MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: cb72caa4-691c-4342-27b6-08ded6708915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ilz3uuUUUbnrKChYQ6XtpibjjKScpyKTzzKZOzfAx7s4/deM+GHOKVc1nl40E4qGSJo8br0UitIxJ8U75tVuU1wwvjS2+GavEKduXEHpQ8xQ8+BPZ8gfuTkbGN8p7VOrUKwHsGoaPdP4pnWSFV+ULUMHBvv0RhXdMg4UJafEey5T134Bvqf4iOwnoUbSH2bw4NAUjLP8XvuLtmO+9QnkMAarRbHQHezP0Fy8aHiK+2YfY8C5uUvTDRu/HIQJRTsh/Y44U2AZ7Az7BUYj+Qv40s4/WcZ8GBCKbnQXbCkohzdziL6t4l+5uyGXDt96qZYtr7HAVFXdmHVr4sSuNRoj74pe4+Q2a8eCKCeqzt16Qf94pXTT0HDR0xdIGAunsq3BJx42bYMkeAjKOvyrfbQtel9l6pX3zYY24cU1oZSf/P2tu2R4oNLjvRPyoYyjSdCKxEyk0D0zhYRgg6RTB168EnvDvIXgmtQGUAvFppLXM9wUCZDFwU96ruHKy5aslilhgfzqQzR8XQsfFmsP2U/fis7DkQpYgxo1UMHhTrZJMb0xsHc7cCDXD5BcvbeR5ItWNQN4J6sAPH4wqAsl5dtUyeryD6nfyo29MZjRgAjWiR9uk0VFSYn/lXS1QOSfc/jiB4LBj83JhjVcyAV0X7QRmIaifAx0LDn873jpcjgHH+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZCNCtmK0t5NERvbExUbW9JSlMzNmF3ZlhDcUJia0dmSTZKR1VMWkw0L2pi?=
 =?utf-8?B?blZCZWxkeTZuUCt2WHBVWXpINlJpSExWaTQzNDdIdDM3YmFXcUpvcHlPaFBC?=
 =?utf-8?B?dlRxbEFWR1dwd1NGWUhBdWI0c09ubHBzYnFIK2ZPZ202MkV4S29YTERvQVVn?=
 =?utf-8?B?d3hISTRmSjRuK2d2M0dRZ0kzTHZLVG1QeUEwZFlMTFU2WXVCcUFrVXFyR3NR?=
 =?utf-8?B?RTc5bHRQU1hzL3RpcWZCVlhkQ0VRNG1VL1dPY1owR0F1VzNOVkFaTTl0Y2k4?=
 =?utf-8?B?K0lzMm1lZytPL293dWFrNUdGRG5jYXg0d1hBOTdMVjE4R0g2blFLaWU2ai8w?=
 =?utf-8?B?NUNEVFVZQkhKTmdOQnBEUHF3YkhaalY2c0k0NWFxdWY4Y01yblhGY2hvRmVN?=
 =?utf-8?B?c2NnUVdiU0NvWEdqZHpqR1FiYjNDMWZ5V2ZtVDZpY3Z2RTF6N01veWhBcVlr?=
 =?utf-8?B?bDllN3UrdzZBQUozZGJGUmZnYWhTVkh2eHpRVWw2bHJnQVp3dzlvdlpJMDF0?=
 =?utf-8?B?RzB1V0pNN2V0R1h1QTVIMU8rYUo0elBuWEpzQ2pnQndtN2dqNzhxcm1aemtX?=
 =?utf-8?B?cEYrOHRYbE45NTl1SkVpQzNiUndnaGd6eVpoaXpyZ1lhc0NoUkh5TmRidnlp?=
 =?utf-8?B?bjhKdkFLc0lubFZQUHJraitya1JFOEdzWGtneHBPTEVITGpURTdWNHdtMUpu?=
 =?utf-8?B?RDFNRHBxbjJ1aTM2UTZSUHU4VVJrMUN1U0xoMU1zWmE2THd0WUFuZWpQYkdK?=
 =?utf-8?B?d3F4a0xacTFyVmNpZ0V6elB0WFI1M3NZb3lRZG9MNzVER2daakZEVlVlYTZH?=
 =?utf-8?B?dy9vL0M5aCtWNEFJbDhhWmxqWlVvOXlYM2w2bEcyb3crN2NEcTgrODVzTFNu?=
 =?utf-8?B?QVJ3UlVmTkZ5Y29rRTNKcnB6QkhIUENkeGZMemFWcWUwdThXNlo4cGIwQ1JP?=
 =?utf-8?B?UGdFSFQ0b3d1OWx2aU1VWHM0Q0xKZTErNWRxbkJzTlpjemdMRHI0dzBPTFAw?=
 =?utf-8?B?K1BJc1lUVkJsMFh4UE9iakZrNzV2Wk05RmlTaXFFck1XS3BBRmxnS0czclNw?=
 =?utf-8?B?QVJpZU4zY0xncEV4eTFJVXBxMGlmUjBHdnBEakJORi9HbWZ0RWI5akpvTFhN?=
 =?utf-8?B?NS91V0wwOFdzcnpRcTNDOHEwRUhuSkhnZzFuZ2g5UWM2QWhzNThMZmo3MzN6?=
 =?utf-8?B?UlM3QWtuYmtnQjZwekNtWld0R1lQZFBvTUpJaDhUb3lhQ2VlZ3pabTNmZzky?=
 =?utf-8?B?RUtOYUVDNDF1NkRHMGZmRDZpVWs4ZXYrZHJBSVMzV1dwOUtMZ090OXl6QU5j?=
 =?utf-8?B?aXhHaEtQaVk2djc5cytKRlVueDU5b1JJZXZSWkRhMy9nbHJHMno2U0RWMHJC?=
 =?utf-8?B?L2lPRytQc0xQTFE1Y05yNTl3ZGc1eUI5cmgxZDhzUUdDQUtYcUtUTkFGS0NQ?=
 =?utf-8?B?cEduMXltRDdCbVR3K1h5T2ppdHo1cjk2WDNka1VaMzVMS2tTT3lCWkxkTnNH?=
 =?utf-8?B?Y0xDRUxka29XQ216TnQ4MHd5RDR6RE1CcXgybVErNWlaU2RDVm54U1FldmhH?=
 =?utf-8?B?aElVRmNhQXVaZGpIdFE5ZHhQUzJmdEVMNkxneW01MHBxR1pDOUsvUFEySEtS?=
 =?utf-8?B?NnRPQ01XbzZwaFM1d3F1RW1EWG4rekxkaWNTczFKaksvN2xGVmFoLy83eFcr?=
 =?utf-8?B?WWJEQWEyR1VzTWN3aHNkd1Qxam5sdXBGd0ozU01RemFINXk5ZmFvMmtMWElX?=
 =?utf-8?B?STBrNzIzYVkxb3Q5UGsrVGxCNHZFZ0VVb2Z2OTloTU5yUzRnbk9YM0d4dmo4?=
 =?utf-8?B?OTRtUUZVWUpESExHVTlOSEwwZllNSGVhVXA4QTFuY2F6L1NuVDMyekFOcGo2?=
 =?utf-8?B?L1JhNkRzWnVYR3VOdm1GSS8wMCt3RGpNdTRxaU1yY3R6bVBjMC9YbVg2MDAv?=
 =?utf-8?B?TjN1emRSLzRCbVhoMU5qMXBGM0drdVBpV0tDUE5lZHFIYnBvR0N0dVI1akc1?=
 =?utf-8?B?b2RBUzY5YzNoQWJUZ3pPSm1WU2kxY1RjeG9mbVFTbGN6bnBnWHE4OFFuNVMr?=
 =?utf-8?B?SkZrWldNQjZkbVY4ZE1JdElhaEVnRmVKV2lGZjZXRFNkVU5LY0tEUXVGVTJY?=
 =?utf-8?B?Q2ZnOC9zTk5mbVJxV1hmTy9SQms0amV0L2hkTGtRN1ZDamRTNUVNdFdFRHpx?=
 =?utf-8?B?bFFEdERRQzRhVnQ1Y1EvWkIyTUVPWlZ5Wkozckw4WFlkTDdRdVcvb204bmg3?=
 =?utf-8?B?ZXVSNWJKTGdkaVM5aXVFUzRBZlpxYXBRTzdSM3dOcEtzSHVYQnhySHlFYWhF?=
 =?utf-8?B?NUxIZVJiczA1L1BuQ1V0WWpmUjIwOXNzNUdyYVRONi9HdTYxdFpDQT09?=
X-Exchange-RoutingPolicyChecked: Fl/zhdX6Pj/eRYd31jlc2ugGYuCqlwSeJ0dTOO3ur8RPAfE6dnEQbNvJWvJFPni+0Capsg+bwVtWBhSfUMG6T212JA/m3CUg+1meelhZOnGxkVWIZzuwnw9LBD41C92jKkWo0z+pNGbhi0otEkEKiISmrTvVO7lxUnxoCkVuIaeo0mzpVA4URHLH+1ByxGZUiguEwbaXanICH+F/W5iug/vmVJ+28evdgyfIFoXzktYZS16rqc2uLtMw6jiT9/hV1Do+uaW8dBuoUIpPhcYHUsy4CTb2zoCIzKoVDfaX1UOpYnVM+3zuSJIh6WC/GYcX2M2EXHcrmJiUU6cI19CAYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb72caa4-691c-4342-27b6-08ded6708915
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:26:36.1486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OH1lZsJa6KilaKFMwYkNR+wKRYYRuHGItCfpm45oEzuN1U86TgfTyy10lTHoy7ys2ZBSHhYkn1lK9tzabKp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9680
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


On 30-06-2026 10:50, Raag Jadav wrote:
> On Mon, Jun 22, 2026 at 03:47:20PM +0530, Riana Tauro wrote:
>> Add error-event support for Correctable errors in CRI.
>> error-event is reported to  userspace for all errors that crossed
>> threshold on receiving an interrupt for correctable errors.
> ...
>
>> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
>> +{
>> +	u8 drm_severity, drm_component;
>> +	u32 value;
>> +	int ret;
>> +
>> +	drm_severity = xe_to_drm_ras_severity(severity);
>> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX)
>> +		return;
>> +
>> +	drm_component = xe_to_drm_ras_component(component);
>> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX)
>> +		return;
>> +
>> +	ret = xe_ras_get_counter(xe, severity, component, &value);
>> +	if (ret)
>> +		return;
>> +
>> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
>> +}
>> +
>>   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   				      struct xe_sysctrl_event_response *response)
>>   {
>> @@ -152,6 +203,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>>   		severity = errors[id].common.severity;
>>   		component = errors[id].common.component;
>>   
>> +		ras_send_error_event(xe, severity, component);
> We already have error-value as part of the event, so this looks like
> a lot of redundant duplicate events if threshold is set high enough.

Yeah makes sense based on testing. Will add it once per error type.

Thanks
Riana

> I'm wondering if we use a local variable as a bitmap for components
> (which we set here) and only send event for_each_set_bit() after the
> loop?
>
> Raag
>
>>   		xe_warn(xe, "[RAS]: %s %s detected\n",
>>   			comp_to_str(component), sev_to_str(severity));
>>   	}
>> -- 
>> 2.47.1
>>
