Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AFBCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 09:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95FE10E09C;
	Thu, 14 May 2026 09:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DzDdMT2o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B0510E09C;
 Thu, 14 May 2026 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778749945; x=1810285945;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OjLkU9Vl1e08ngt2nn0oLyFtx2LWHLs5PEyoM8pR6O8=;
 b=DzDdMT2ogRGosCkCBPrqvUkP0KlQhEcI7KB4takABeHeUeqWZw8w1rSl
 3fhr+Ck1IYcxWGl+/gJkwpWUpS4l5CurV5wW76YZ0GrY+4epiuJE01z8e
 kjrCwWfBbu2HInRjdTIrmHgSCzw9Av7djAa1L1rSm5UA6JNKZBsvMlImc
 BgC3lvdTJpn/8RvNz5jM8MD1P56PS9gy2c3KoqBJKQhK2u8yEQvqF1u+8
 PQiQQ+QHEZOA/Cf78g1hpSJc4tIeZ10+tL7K0Ra7iIUT3tYKhN1ueDgPh
 jO13EqhVVEhKWBp+BpNe3dre0gKjRE6jv2G37IxWrqRD3vTeo/O3IICqd g==;
X-CSE-ConnectionGUID: 5xEaMZwMRqykrE823YLeWw==
X-CSE-MsgGUID: hSg333FeTJqneQNvurrnpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79720597"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79720597"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:12:25 -0700
X-CSE-ConnectionGUID: 6p9jBpIHT4ycCBEqoynwBw==
X-CSE-MsgGUID: XwY6JnXgRO6kgrTE0Qzs3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242331884"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:12:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:12:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 02:12:24 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH9R8EzQgVdkhe/ESOWvWD+O9ZGHVkVjstA+RmufoHl/3J/KNOkKwY8LYb8n+IOELYBCM28yxUGh6Ofk6Dk8oceQHjdScFgbJaWTCuqNEzqP9o6QJcGhcSk00X0AZ+X+4j+2FYU4zWPk1FgoDebX4/anVs6ExLMKJ8LBe1OrIKAk98mcdTPDOKTmm8MyTdbM4tJbOZXzl6j1NA8D2WAsc9XRNAyiaIY/XsgZGYLuVvsr9KQxKFi9AI8j+YHJSaYW0fjqereMbA8QxhZF7O6GQ76vlk5a0mT659/B54lUjejd+Hi518GQ2MkWYa3xP1691f0Zi6nV1AxZe7VmzcIVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVW48SPfO0We1QKDyulRmEXNuT22FQN0E4qspZP17kM=;
 b=QOW+waIJN7D2KGx74c0Z0Bv+cd5408ECSTDvbIuxvGQDwWAjUbAVRk6Lo88CA9ws6v5nhFQfUWqFKB8tQMnuyI58mUTg6r5zJUerqoDs6VYwFlgCsrkbFoNZu0Z21+3ymsuEEWODQzMqraqNGyLgLGBipRmMP18RRQXjiT4rKl0TyBby15JGwnlIpNnPAp3iL4u3J4naN0JCMSiKOcg2JiW+cuUYYHmF+QbwJysr1qw7yJ36+cl74ie7jNBNdenllTVsjkRNJQtiWSeA1iQ+bDC0P2JNiCA6ZX2fGBqGUxpnH48BrFNUCzzJ7tlsmpzOFt8XLoHNNHfSUL5SiETtPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:12:21 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:12:20 +0000
Message-ID: <81f5401c-6821-47e5-9fd8-40df2b3f8920@intel.com>
Date: Thu, 14 May 2026 14:42:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-9-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512132614.1793083-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ0PR11MB4845:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5d2f1f-64fe-4cfe-355d-08deb198e715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: xg0rbfijdxR1B4EYyJzmYku2CbA0AYtw0OGSZ4WRgDmaax3Ez4C7zBVdlYEGdwNMO1dc+VbYcygtupqUPg7B9BUStVs8337l+2R7U2V/gX0nQaYcdbymOHqXywWJ4UNdLsP98XGt2EwgiaPJyHCZI8mu3bFrKgmz8BEW+YsI+44KTVBWWD3UZisBr0I935ydZXma6T/rfxg71tPJrFfGlKO1j6tCPTBaMxKS1AL/fJfUIrodyN2IqzeLuKAijcvV6eeACofFVYJZnK7GTH/N2U5thkN9Pfw0XFs2TNsUnbx6ZRo3927cic0wekKnsHnAH98QN9nAV9O9kLw/waMDMXMKB/I2G16tnXUB0OyiQ5STda8zp+oeigudEY25//IZ311d/xZJiFvSHwOEBeBxL2gFJdHRF+u0bhfC8cAsSnMPW/kMWEYPtop4ycMEx+gaU+XpdsQov1kzccvACSCY1HYDp2Gyt1+t73xMyxMC3o6orq2Sn9Zd4qs9/C79EYTxd9RQv0njdpiw+y+decs4RhSCafZP/BBgfT5iedxGZbfpoWJfWzO61/8CB3DbcvzpJR9YTssM9seOmDPAaRWO7++UeCvqgECiPOW8RWxm4/XN7E0dcwYZ6GGHN1gJoLEdqP2VTBhJT6pcZJNEpscvdIf44niM58VxDymocLkEnaYxh/+LLOoTXDtbY4q9+y5z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25sUmtYUVJOd2ZzUzlzbGowNVlvbTVlVTRtaGJVZCsySGV0MkNkQ0Y2TWZ1?=
 =?utf-8?B?QTNCWXFHTXJrZHYvalRsOUdvZDRKOG90YUJaZ3RPUWlmTXg3QmoxcXNWcGFw?=
 =?utf-8?B?WW1hMnZla1l4ci93MzBaK21ML1ZSTUdLYU5CTVZaVGgvZWNLVDFWSmtuTmM4?=
 =?utf-8?B?VVZYb09UME9mOHVNMW1pRWdTemlRdU1LWnZUemFCcDltTEl5TXRkTlBSRHE2?=
 =?utf-8?B?QzZ1S0xLRlEybEhJM0dHWUUyaVFBa1F0V05DMzJjRmp6M1JYdHF2TFhTSnRW?=
 =?utf-8?B?ZnNsQXVSWmlrN1EzY1J6WkdweE9ocmFJZlRtaVp5NXArc3o4enV6OXVWN1h2?=
 =?utf-8?B?b3NJeUQwNU0zekhYdmlnSURkWUJITDljRWt2RHNIMWRoZ3lWOEJDcUJKUlNC?=
 =?utf-8?B?QXRvSlFNMGtHdWxTdmV4R2V4eU5hS3hiUm53UndaTFJiaEFMTi9pT0cvQ2hr?=
 =?utf-8?B?MW83SlBoSHcrOVZ6N2JrSklTRzZTdU83RnVkTmpPVm4rOWhGNlkwTjMyemV1?=
 =?utf-8?B?Nkluc0pHSW5RQ0JiQnE0VWZyYnF5T3RzMWFPdlJ2SWFoQXRVU2RLZTdsWkp5?=
 =?utf-8?B?bmlJTWlnS2xPb2NoTDhYakJyeGFwS2w3VE9Jb0JYM05ranlmcytsc0ZkbUVi?=
 =?utf-8?B?VWwvMjhFVWNPWHBzaUc0dHdmUUcyZmh1aXFaQ0dxNTFqK1l6OUNRS1hERVQv?=
 =?utf-8?B?dUxibW1qcDJaWndPOXJ5MDNHWi9jRXBGenhOTzhQUGxwUlV0c2QvMUNaOHIy?=
 =?utf-8?B?bHRCMG8wNmpMdURKc3NIUnpsQlFKV1FMQnNzV1dqRloramorQkJpbmFDd1Fr?=
 =?utf-8?B?bDBjR0lzdXlZMVhYUjRKWm42TjBGRHUwTk5WNk9yenRmRkt1MHVwR2lxUUhI?=
 =?utf-8?B?cFRCaGFTVW5iclNQNU5rdnA4UUlMSVdCUDBDYkZFZE9wVjlFaFg0amxjVmVE?=
 =?utf-8?B?RG45NUdZaU1EU2lpd1o4K0FvWGJiQ1V5eXhIRk5JK2M3V0VLbkxVMklCTzZT?=
 =?utf-8?B?SGUyaW9XQ21iV21Da01QZ3ZYSVgxdDFtblRRaW0xYWFpR1JIaXQ5UmJrZVJj?=
 =?utf-8?B?Q2ZWZG1mVEhCSGVCRkY3cW85VjVlaTU5SGtoaS9uMDkwd2o0ZkhpQmhhR01I?=
 =?utf-8?B?bTFRSXZVUDhHZDdhK1V5L2J5d1grWEZQak9VKzIvZGp6SHFEYXNzNlhEcGp3?=
 =?utf-8?B?RFZCWXpiTVVRUm1KUDdLODJKcU42NHVIeEdDcDA1UXRXK2FweXd3OEs2YkI5?=
 =?utf-8?B?WFlHcmZHaW1QcTlHTExFNTlManNpQ3I5T2tFNHlrZlRSOU5qSklQay9DcklZ?=
 =?utf-8?B?TU0rN1hvVHZqb1gxK2dXYlFGKzhOUFh5NkhVcWpxOHhLSmJUTnNRQXVya3Mz?=
 =?utf-8?B?Tk0ySEl4VlFhNE54TVI3UkdycnUySHQwYXMwV1NvdFRSYkZYMHpWNzlYdjlI?=
 =?utf-8?B?SEx2Qjl6UmNNTVVSR1Z5VUY5VTBhbEUzOXBtM21UaXQrd0RtNzluQnNhWGxW?=
 =?utf-8?B?cTlGb1d5VW9kbDA5OXlYT0NsU3J4VmdtMEZ6RUZmbkJqbnJXUWZmRlpZY0I5?=
 =?utf-8?B?Y3kzZFRvQTFJcW1Vd0JSOTZJUlFhWTdJd01IZnJ1aG9oR0RWYnpNbGE2Rldr?=
 =?utf-8?B?T0RsbVFuN2QybzlRU3NmbUszY2hTdGNzMlVURXdDVmYyMW9mUEQ3VWxHTm04?=
 =?utf-8?B?d2VVdGd5cDZTYTZtQzF5aWlKVFhLYmNFdUpzZ1ZscGZVbm95bUFIUGd5S0JB?=
 =?utf-8?B?TVNEc3pJbVUvbzl2UllyTDhTR3VyalQrTWNrdVN2Q1pCeE5vbmhOSnBLeGxa?=
 =?utf-8?B?T1ZXN2k1Z2ZJeWZQTEMyNDliZWtHbXBFNUw2MjBHbXB3dlRpVHNYR1NlTzl6?=
 =?utf-8?B?UUF6azRBRCtoL1QwbE1MSmc5U3YxRmhqbFkvZ3orWVp3STJKeXd5Vm4zSmlp?=
 =?utf-8?B?S3B5UlhNakhNb1BCLzVQYVhITnc4anVuYTBwZzFNMERmekJVaDVCRFVSVVBM?=
 =?utf-8?B?SnVFeXAzSHZWWXhENm9TSWRKTWVkRTJqSyt4Q0xOYkFLRGFTK0krYTZ1RmhD?=
 =?utf-8?B?Q0xzUTZxcjM4dHNXS2xyRU50Q21iRktPVUY0V1hzdUxxS3dTdW1YcGNyTkV0?=
 =?utf-8?B?b0JQdzN3U0ZJLzNSNDBCSzIzVlhPTFNGeVdxRGgvamhZV3BoOC90TEs5bzNR?=
 =?utf-8?B?anJLWEM0S0RiMHRLSFhjK2k5MFk1OWZsd0N1YlBqcHJVV3dUVkZxaENBV3Za?=
 =?utf-8?B?WVl0UWF0UWMyODlvREVVSlVRU1FzRHpnUXkrVENzeU10TVAwYkFuNzZsS3Q4?=
 =?utf-8?B?b1JMSWFkTVdTWlJDb0NkNHdXZTk1Z1RUYklLUElxSTBnUStCNWUzQT09?=
X-Exchange-RoutingPolicyChecked: r2GQvlhNMFL6Axs+0TwpqfgSHCElcTGV7bEnyRo6kYhO0J/cfcxbyI8e9CVp4JJqioIrCVE+0E9Ys0Bqv75+I36/lqN6EpdoMpyM2mEFHHBH0IxD1YbDMQfXRcTK0/giSwDxPxpgFhBHedHFPcx0BFRFLZfVPnUibASotHr3wNsfBgf8X+89ZR2Z0s3jCndvHoJCToN4jQtap4EMWa4WczunasQtavpdk1t6cptAG1Hk+5v/qPG1Qo6UV3OiLI0eypZkogivrQxjnzVH7TvvpCheGRJ/I+3Pc0FUPASG9v5/q2w1RjexASoo6xpEikPv8G0b3nhIIoYANluDHWd7xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5d2f1f-64fe-4cfe-355d-08deb198e715
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:12:20.6788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE8hTAHuR2ZfNpAiCQy54ItLtcPH9iMCzk9mhQFqbNCRgF2iOyPYvKiBPmjJeLeK47A9q+2LWoQrHycYgdNYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
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


On 5/12/2026 6:56 PM, Mallesh Koujalagi wrote:
> Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
> scenarios requiring device power cycle.
>
> This method addresses cases where other recovery mechanisms
> (driver reload, PCIe reset, etc.) are insufficient to restore device
> functionality. When set, it indicates to userspace that only device power
> cycle can recover the device from its current error state. The cold reset
> method serves as a last resort when all other recovery options have been
> exhausted.

The last statement is not necessary.  This could mean that all recovery 
options must
be tried before attempting cold reset.

Thanks
Riana

>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v3:
> - Update any scenario that requires cold-reset. (Riana)
>
> v4:
> - Rename cold reset to power cyclce. (Raag)
>
> v5:
> - Make it consistent with consumer expectations. (Raag)
> ---
>   drivers/gpu/drm/drm_drv.c | 2 ++
>   include/drm/drm_device.h  | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..8c0236e2e6a6 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -535,6 +535,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>   		return "bus-reset";
>   	case DRM_WEDGE_RECOVERY_VENDOR:
>   		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";
>   	default:
>   		return NULL;
>   	}
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index bc78fb77cc27..d41f26f4dd45 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -37,6 +37,7 @@ struct pci_controller;
>   #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
>   #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
>   #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery method */
> +#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* remove device + slot power cycle + rescan */
>   
>   /**
>    * struct drm_wedge_task_info - information about the guilty task of a wedge dev
