Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D255FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 21:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051B110EC82;
	Tue, 28 Apr 2026 21:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d3WBwY9W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3EE10EC82
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777410440; x=1808946440;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Nv8BB1JZpXAGZO/M9NIewsGUbCwJdMl2FJ3GdCb2CXY=;
 b=d3WBwY9WZ9EggrNf2j/E8xi63NGXgD2E8LWS+fKlyhiUfIHlmBS0M+Y0
 +tqsUARTYJwA0Hy6EgBs/ghYd2hljmmLQppsr8aWYnn7uavV1ndmBSD2b
 wWQZ+d5dZzG4wb2wPULp2GYvHc0y5Dzms14nIz5dbEALaE+VipjEMRGSz
 TPO96kC9sBanSxzlGSl1lN5nK+j2tjRaOESBkjQMJ3gSVKpejj3W6a+NU
 5Oa5iCynRPK6qEto5dkjNoj1eFp7StRnoMxt0whxLjEIewxkaKVazQ/t3
 N4CFEqriTqCW5rsMb+LshhvOfgQvcm57hYSs/SWdXhNVrZ8uk0eBAZ/dG w==;
X-CSE-ConnectionGUID: CojiXJR9RvSbmi/oAyVhvA==
X-CSE-MsgGUID: tTBlUXI8QmmIaHU/ogunVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95749174"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="95749174"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 14:07:19 -0700
X-CSE-ConnectionGUID: UksJGdJ9T9yaJy4Nlkr9lg==
X-CSE-MsgGUID: WGHS04yvSX6/HTYbuvp/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="235835289"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 14:07:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 14:07:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 14:07:18 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 14:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6dzxbW0jrPJRbUW8GfJ3tuKSJwwP/IfUxi6xP845WeMgcDTv7v0FATIA9B0q3BVtP3GO5DFiN2Kl1IGcR0u9c9S/UMOX577e4W43DeWc3kaWDyiINq+BsECGaZwQV5SlewabDb12eddzRrnB1ilKSwDBhbyZfM+h1YL7xQjGuesAdqW9JkVP091v6RilaqmAJNQtk2KZtWFXT/ffpWybe/iBXGMTMKLYkRyLQU7Zrat3kWyZg3mU9SYp/1firiqmMWC8gwOLvkxTXHZeUA/ptjqYLBVEm/0WqGoUa67vLOttZ/6XFQ6x74fiUC0rSIi+etZmBobRljUj9dMilI7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R0C4iC1uDq1hosmc5fh+ny29AsjhjOxIwuCzgRwtrk=;
 b=imnf+P6Nz7dDCWUZhX94XU8l9bycABUlzOFqovEdh9aKC4GX8hk3/RvkY5DtApfN0xHN7R5qZM7pwSw6/zycQXkDHxdUUHZymZNhO8IJiiqQkrUQGPrjgmKabr/mv1GWAfg6N+Ic6coxRb+fsvYTuuJtASY/CEJNADpEW9txzroy8YUXMkhK6t8sORA2ICUPDY8kVY5UitGF8na5JE2HVQYJ7N6Tyc95xKPxMD8nebmhjmMQtZMmgV8d9ek6XFohwKtoO9ydYcMUe2bS8oSihXMYdUJM7d6oanDiP59mYhewmQDQfBjhbrR9H/cKlHPB0VZuq30zEr4iWY3Leth7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Tue, 28 Apr 2026 21:07:15 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 21:07:14 +0000
Message-ID: <3ef1f9c0-be0d-45fb-9420-867188241989@intel.com>
Date: Tue, 28 Apr 2026 14:07:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: stuart hayes <stuart.w.hayes@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jocelyn Falempe <jfalempe@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
 <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
 <be1f1005-a7ed-4a5b-904b-35541b19658a@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <be1f1005-a7ed-4a5b-904b-35541b19658a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DS0PR11MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 91de7039-6880-4f96-3b24-08dea56a1f0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|20046099003|22082099003|18002099003|56012099003|14066099003;
X-Microsoft-Antispam-Message-Info: FkVgXA+a7/dWZFuHvtOdOLSUBJ252Qz7juX5Q+05AQyNPIqXMfcY3xrQd6BG0m76Qd8zoJoH1v0K+BzeiXdzO201NF7gNCw1KzJOI1edr8/6wOVMit5f87aY+vGL8ccmVESRGmoeZHdXQXp5/j3khoBJbm4+zhyRvLAiEJsrtxitmWY2hHBU3DWS12dBisBqlm0u9yTDElNSW7MADmr1ykVU59cmwAlOPYdXxUZ+Wnfug20yMgiHm07AT3hH6XgLySg6dqWjYUxWVCZyxzXLM4vPWh7fqlbl7JqFuXcS0db+SThH2BfsgXDb6tzvljamg5aKYeC5nKvFw4LoLFNHWCBvE2PO4P1fWRnW6u6m/s8f6MRnR4MRlFaMrMOgewPfBmH0SygAKjPJ7Dk3plT9mDCNHwgbfQtD2lSCePvgNS49xjHhT1mx7cTz0DXPkCKR59nCd5HZGLJzV5q2y5Hv4SM1Oh9+gRqH8QaPLrr912AdCMJxj9FaZ2UBcj7nZX6LI83yunqfOeJf8CWvLt9ytcThDhJUQMA0KCZh971mmQPf40F9aadvnEjdQr9IwGDUmqEU1OoGmCX1LppCFGHCKlSh5OwYn5AFaWua7Xn1LHJA7+VASlRF9DJzj3pnIc1E5WhRj8K1QAO7Sm8nfPzKgIq26hCskWtePL+vTVBeJFlStalio7eYEwj7MXwV/1O7oHiIUyPWs7IMaBtX5LpREvtzgAuxrQzhrKZWHCp4KtV+o/Mkbpgp+4Ydhh23Mri/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(20046099003)(22082099003)(18002099003)(56012099003)(14066099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzc0Qnl5bmluNi9MUzc4TVlxVlhSTlczcjk4SGx5SkRiVHUwTHB0SWNvTEM4?=
 =?utf-8?B?WDBBZytHblZKN2xUYk5HdW1OQlJ4OWdhdVM3bTJienRocjUwSDRjMXV6NXRL?=
 =?utf-8?B?SWg0cm05OUpDUzFlOVJYM0J1Rm1LUVBCMVVGNDVCNUZGTzVPcWdoK0Urc1JC?=
 =?utf-8?B?Z0EwaGZNR0NZN3U0NUZsRW51c2tGU01GSExpN2NUeXk4dmloZENZTENXZWRl?=
 =?utf-8?B?RU4xY3FMVkQzbWY5c05UaXRpUENVYUtINmk0aFVsVUtoSTRsQTI1bjFXZk9y?=
 =?utf-8?B?dXdpZm54TUZlTWpEbjAxb0FPZXNEUEp5Z044Vm1LVlJ6NnJtd1Mxem02MHRh?=
 =?utf-8?B?d3g0TERzdlgwUHRadHVqNU5YY0dHZ05UMFlsZ3h1dWtMVmFYZjk3Y2diQk5E?=
 =?utf-8?B?WENtTG01L1A2VDBBY3M1eTRmdzEyZVcxRiswcEh3dEs2NnRLN0ljVEdJTzFk?=
 =?utf-8?B?cTBqS2VGRXdiV2hzVERpWGFkcTRwOFNhUFRRQ3RNRVJYN2MvWnJsSk5iNSt5?=
 =?utf-8?B?VGFMNlFYaWFoSHR6eDFXZVlYWmo2WE1ZdlNVNDBLTXE4bnU5aUQ2K0I1TXFM?=
 =?utf-8?B?cWphd2M2WXlCU1IrMm9FMHJ3UndTdjVoK1ZIbFRRdFBKSGpCMTdla3FZNUJU?=
 =?utf-8?B?dEd1Ukk5Q3haUkE4TmhONE9rM2JSWnFjQ1QwMGpwN1RQTmM1WTdsbENpdCtw?=
 =?utf-8?B?QkszUi9paVdWazVURzY2VXhBSGV1Tm1DY01IWWlwcXZkdEtrSVFCOHlLME5l?=
 =?utf-8?B?SGlrQnAvNmEvbDdEU3loUVI0aTRzMldqbUliME5CNVpqRDhIOGRBS1BDS3RE?=
 =?utf-8?B?LzMyMC9qeW5mNjRxS0NiTmVEY2xIY0tISHFycmRnL3VXMklXelN4V0JlVURC?=
 =?utf-8?B?MURIc0R5M3c4WHlrRlpMYnVLMHR3YWFid0RUeXZuT1g1VCtCaWE5THJKNTda?=
 =?utf-8?B?T0ZiMlpaUmFGcGZpVWVLcGFPTEhVUkN5UzY3dHJNczBPUW1YeEtwdTZBQThk?=
 =?utf-8?B?UFJSU1oyZ2lQNHRHL293dFBvS3JERTV1MVlzL2cvQjhYMDg4ZjdWR3BPWHZB?=
 =?utf-8?B?bDd2S01HaTd3UEVFOGpKcUtXeVEzRW5PRHVWTUFkNjlIVDhsenE3d3ZiazdX?=
 =?utf-8?B?Sk9ZSjljUDFKU0dTOE0zQkF4S2wrdU1Ybkx6YUpxVjFMcU1XTnJVYU9ITUJn?=
 =?utf-8?B?SHhVcktLcTA1blJZZWo5Zk52dEFia2R2OWs1aUFBRlVaSTM2MXl0aGQ2OGhT?=
 =?utf-8?B?N2QyQzZmMnI3VVp0dmtYTW5INVkwMk5acW9RZ2tpUWdBd3BvYlo2ejc1dUtE?=
 =?utf-8?B?bEcyaEZpMVBJdm9hMzkzZWx2MEJSNHdiUDRlVHhPUU52a0szNG5KTmJydFRP?=
 =?utf-8?B?b1BuUllIVFhkSHBlOHdlM05lTkpLbVVBMGpuWUlkVXphazQ1MnBWTmpwQW1G?=
 =?utf-8?B?UGtuVHpMTlZXTGx0UzBzaUxOWVdnb3lwK1N4bVZuTTk5ejNrMWFZR3VFZ3Rm?=
 =?utf-8?B?cWlncWpuaHdydFFzLzFJUHRaejZSOXlaeVE4N1B6UjRJcll1QWNpL25Wamky?=
 =?utf-8?B?alRVcVNQNURXZjJiSnVZYTdOZmcxam9lcnlIVTdUKys0eEY4bnM4WDhrTTN0?=
 =?utf-8?B?UVdHUFgyS2MwbTVlaHNSNjVqaFNJUHFYa0Rrd3EvczVKcnVzMXlNMjdIWHpU?=
 =?utf-8?B?NUVnbXRNRW95RFFmbThESEh2OUdoejh1Q3JVUkNKMHg5S3d2NHovekMzWExX?=
 =?utf-8?B?Vmpua0taNVJsSFFGTFFZTkgrWm5JcktvM2g4dzEzRTZVbmdVQkd1K0huZkww?=
 =?utf-8?B?M3REUXUwWkJ5eGlqc3FuT0ZpZ3QxTGo0Z2o4dXFIK2lpWGwxK3NMN21pNWg1?=
 =?utf-8?B?Sm05b25KS0RPSk9qeXpIcHcwSytRR3NMYWZuSnJNMWF4bSs1OHIwSDdoNFJM?=
 =?utf-8?B?YkZRWFMwTlRiZkkzMWNEOU12YStHYVBqbTQ2Q2dmQ1ZSNk5xTk9NamZCQUIy?=
 =?utf-8?B?NCtIWXdnVlhYWnFTVlVzbzQ0WTZFREd1Y3ZpdVFndk9kV0JKeXlLcVRQK1Zl?=
 =?utf-8?B?dEhOeTE1ZE1Ybzc2NHM4c1BBQ1JLUzh6MFpEZGFiTlk0dnZjZytuS0U4T3JP?=
 =?utf-8?B?aFVYaGxDekMxUDhtUlhuY2pUbWQ4VGZ3dm1lZVhUbURuRjdEMkV5NkpZeXBo?=
 =?utf-8?B?b0hYT3B4TjFGSFZxRHYzQWVoRUJaRzluTjhhR0FYQ1A2a3BjYnlhRk8wN1NI?=
 =?utf-8?B?WDQzUW02R3BzTHZ5MmpQS3dHYkgzNTBKanVFRlJmM3N1djhjQ1NBSG12M2Jr?=
 =?utf-8?B?UFFMSW5uREtwR2hBcXBuazd5SGNaRVh6aC9lTDlNbENadUxoWlc3UT09?=
X-Exchange-RoutingPolicyChecked: ZLuAQe793Y/IKhIV4GlEmk7rv2nkjQYQe7KuWNiJb45o7Zg5zmZ9P+9BYtn8tPtmN090w1PwWDu/2i5ah+tevEOESg/AbkKAclN0B4NMFZG6eT/hzVkDLrwUyPLUTTsQEnRapo4cYBaCHk40U7cETnMNDoIcN2iqa3G/H1mZnDGFWBtIUiFK9FYgesMcV2zNGPVbe2T8oKcXU2svLBLpycLzSIJ2DvMhHpdSH1wGC6p7TqBEK02hGDeJE1HMZKMqE8HkXoo8a66p06qjvsn4H7NdQbCju+6qRRLKaOU5L0ZlBCIsdbB3uXYhnM1dwhKI0fQy7kMbcBObP+4U2RD0zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91de7039-6880-4f96-3b24-08dea56a1f0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 21:07:14.5425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdFfWH3ooluTjLtwyN1KLs1LNAz3oK5TUM27y8sFS7qTSi5yWIOHy7HX0GHy8AEbA+/nDvqy+fRilSfoUg0dXM5SZdQJ8A+EYvwuDENPgak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
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

On 4/28/2026 12:12 PM, stuart hayes wrote:
> On 4/27/2026 7:14 AM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 25.04.26 um 01:29 schrieb Jacob Keller:
>> [...]
>>>>
>>>> So I suggest to pick Manufacturer, Product, Version as key. I'd be
>>>> surprised if we find more than a hand full of systems with the
>>>> issue. If
>>>> we see a trend or common pattern, we can generalize later on.
>>>>
>>> I think this is the best solution. Keep it focused for now. I believe
>>> Intel has two major platforms that we care about with respect to this
>>> issue. I'll see if I can dig up the data. The systems install the MGA
>>> G200 for BMC use but don't seem to expose the VGA connection.
>>>
>>> For the specific system I have that was faulty, we have the following:
>>>
>>> $ for t in system-manufacturer system-product-name system-version ; \
>>>      do dmidecode -s ${t}; \
>>> done
>>> Dell Inc.
>>> PowerEdge XR8720t
>>> Not Specified
>>>
>>>
>>>
>>> I believe there was also some concern about HP systems which similarly
>>> use this chipset, but I don't have the DMI data for that one off hand.
>>> I've asked some colleagues to confirm the situation and obtain that
>>> data. I'll get back early next week if we think there are any other
>>> systems possibly affected.
>>>
>>> In the mean time, I'm happy to have our team test any patch to confirm
>>> that it behaves as expected and resolves the service interruptions.
>>
>> For now, I've modified the two places that have BMC support in the
>> driver. Could you please also tell me your system's exact Matrox
>> chipset or its PCI id?
>>
>> The patch is attached for your testing. It would work against drm-tip
>> or v7.1-rc1.
>>
>> I've also found the page at [1], which claims that there's a Mini-DP
>> port at the front. If so, I'd assume that there's also an extra
>> encoder chip to replace the VGA. If we ever get specs for that, we
>> could implement real support in the driver.
>>
>> In the meantime, the current fix should work. In the worst case, that
>> Mini-DP port would give a lower default resolution.
>>
>> [1] https://www.dell.com/en-us/shop/ipovw/poweredge-xr8720t?
>> hve=shop+now#techspecs_section
>>
>> Best regards
>> Thomas
>>
>>
> 
> So this patch disables DDC polling if the dmi_check_system() matches. If
> this was to happen on systems that _do_ have a physical VGA connector,
> will that port still be active, just with a resolution that may not be
> compatible with the monitor that's plugged in?
> 

That is my understanding, yes. At least as far as I can tell none of the
Dell PowerEdge systems with this chipset have a true VGA port, but it is
still unconfirmed if the mini DisplayPort is connected to the MGA G200
through some sort of encoder, and how it interacts with the polling
disabled.

What I can confirm so far is that the mini Display Port output does seem
to work despite the MGA G200 driver continuously complaining about
bad/faulty EDID checksums. I haven't had time again on the system to
check the patch or confirm what happens with mgag200 polling disabled yet.

> I don't see anyone say that the DDC polling doesn't cause too much
> latency for real time kernels on other systems that do have a VGA
> connector... did I miss that, or is there a chance that a lot of other
> systems that use this driver might also have issues with a real time
> kernel?
> 

There were 2 problems so far identified:

1) the DDC polling was causing issues due to spinning where it could
sleep. I fixed that a while ago with 0e0c8f4d16de ("drm/mgag200: fix
mgag200_bmc_stop_scanout()"). This was causing 300 millisecond delays
that impacted PTP functionality. This was affecting both RT and non-RT
systems (though both setups are timing sensitive only one was actually
using PREEMPT_RT). This issue, I believe, widely affects all systems
which use the MGA G200. It has been fixed.

2) the issue I reported here. This issue appears to be possibly due to
fault in the hadware, and does not happen on *every* Dell PowerEdge we
have access to.. but it seems that the driver fails to read data over
DDC when reading the EDID data for the connector. This results in it
continuously retrying. Because i2c bit algo uses udelays, this results
in enough spinning that it impacts my PTP setup.


I do not know how wide the impacts from (2) are. I also do not know if
the issue causes problems on systems that have a VGA port and which also
have the VGA port plugged in. Given my experience, it seems entirely
plausible. Here's a more detailed summary of the issue I saw:


On regular (not PREEMPT_RT) kernel, the udelay on a CPU appears to block
the interrupts from being fired on the CPU that is spinning. The polling
doesn't use WORKQEUEUE_UNBOUND, so it schedules on the specific CPU that
was executing the scheduling function. If this happens on the same CPU
as the one that is assigned the IRQ for the ice driver, it won't fire.
Since the polling thread ends up doing udelay for potentially a long
time, it results in delaying ~20-30 milliseconds which is enough to
impact the PTP functionality.

I suspect this also causes issues with PREEMPT_RT but they might be
different issues, due to the nature of PREEMPT_RT changing a lot of the
way various critical sections work.

I am fairly certain that other timing sensitive applications will have
issues caused by this issue. It is plausible that such issues are below
the radar for many deployments and its not ultimately causing a "real"
impact for everyone.. but its definitely causing problems and hiccups
for Intel as well as some of our partners and customers. The actual
failure symptom we get is somewhat inconsistent.

Even though it fails to read the EDID every second or 2, timestamps are
only impacted every few minutes. But that missed timestamp is considered
catastrophic failure for us. It results in ptp4l going to fault and
losing synchronization for several seconds. It also means such setups do
not pass various industry tests.

We have been recently recommending that users remove the mgag200 driver.
However this is a poor workaround as it results in inability to access
the video over BMC, which some customers rely on. I also plan to confirm
whether the mini DisplayPort is also affected by the driver removal. If
it is, then removal of the driver could also result in the output being
stopped. Some of our customers rely on the BMC to connect to the system,
and I suspect it is useful to have local video access when debugging if
something goes wrong with your remote access methods.

Thus, I am trying to find another solution that resolves the issues
we're having without needing to completely remove the driver.

Thanks,
Jake

> 
>>
>>
>>>
>>> Appreciate all the feedback on this thread.
>>>
>>> Thanks,
>>> Jake
>>
> 

