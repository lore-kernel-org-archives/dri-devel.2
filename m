Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD7AC61DD6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384CD10E390;
	Fri, 28 Aug 2026 18:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ck0F12cU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5584710E647;
 Fri, 28 Aug 2026 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787940175; x=1819476175;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YtY+EQCKvQRr0ka7bfPgckd/Q8yFmTdza2OhLj9mczc=;
 b=ck0F12cUOgGzfv/9TpGEXl45D9jpDw4RsKInV2svJqrOjP+CITm2Nmh5
 UTIARlDz2ML8bcveuUdA8WGcP2wuTaRP0TH4rKSPp2VU/ekw38UQw5CYy
 /0dhS5UP1l3Uu3hENESV3NlpOrhDQsUpYX44zmUrWfU5LJJ6BkWYTK9ik
 F7KkoWZDAhZdfjoIYgjXhVPZMuOX33ohLma7mB6hStxDuK/+3gg7k+RfE
 PF5xoNCOsFMOhyxj3674xEENV2J+YU5Tn6w4AQkCHHxHhB2hd/Q/S00OV
 OEB8SD6GgGjv/wdATIv/hw3Kt2ZLlTkRSTx50unlm8yBzRXvXDSyzxX70 g==;
X-CSE-ConnectionGUID: citStvUmSzSSsdi3OtkV0w==
X-CSE-MsgGUID: 7pTHaQWcR12Oy6vHj0naiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88479001"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="88479001"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:02:54 -0700
X-CSE-ConnectionGUID: XjvdKwUyQ6OYIWQDIEhNrQ==
X-CSE-MsgGUID: Uuvl4OTQR5uIXB8Vri6l0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="266909788"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 11:02:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:02:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 11:02:53 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 11:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adjR51LDK2XCeIHIL+/+hzWJ7Sm/BxwK87g+8xwlHn9HIbvvR4S7XvOAeOwwNNmN0flnHY4qO6m2dsy+4n+rJdJvG0qJGQrnGV+tiuoLRfLQ8gjjk9rekfBrX12fenOpMjaYPdeEIMljtli3ClDsG+bwA6LuBtrRQA86y7x7zJpN+TsUqnSxpZ039es7Tg6I1NbkVrkg+CP6FybV8a6lj6C0VyfVMT4m2G0lW0AmVyp9ffZ2Sh5Y+GEFGcgkumU0KCvdLHprpdpV8llx23OpfkcVMR/wTODt0VCp0jgq4ZZhqoS/VSYYyOkd2B3wh7p2igkH4ewcV5uyFE5y168Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvNUIpIiY3bLGEA2goHfVp3wRjRUkvy9aIHmwDXNLKE=;
 b=pYOEe5a6HBWSbyzibnk8jk88dFhFiXKz+ROoTG1c00PAzD0AkmqYxizY9VjC2lV369bWpntmV61uYRd9aD0MmDyBrf5QKATYa7EdRnhL4FXzkP74K7K2JAQM6KDjOL7lxz52oM8F7LaBa0gwd7i8ftvSTomAShV3lvIyoWWk+QZuj0uHQY13aL0AH/rw/zJ7Uu/FTrwIXlkUHqhnhYNPD3OoQ9pRClwDVl2xDJxzQnjFW4xKNTdX2/UiZHyztT8pffxocs3/16VOJsX+RWUKbXChPp/6j79Pqv3/T+51xZU5moP44Kg85mrzIVBg0eHZXI1n7+fFFzbcg8hBv4D25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by PH3PPF1AF044E07.namprd11.prod.outlook.com (2603:10b6:518:1::d0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 18:02:51 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:02:51 +0000
Date: Fri, 28 Aug 2026 20:02:45 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 5/8] drm/i915/gt/selftests: Use drm_* prints in gt
 standalone tests
Message-ID: <apHIKXJPmWsw2KHR@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-6-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-6-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU2PR04CA0232.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::27) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|PH3PPF1AF044E07:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d8bb2f-10e5-4f26-69ca-08df052e93b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: sqC5fBvNz75oORQt7oN9HdxlEtrWBRjmDWxDUekejFgZnsnJo6o1f+4jhfHQTssCMmt6M2tOxpQ3wz8rmFBvHLJKP2SJS9Jn9ywTr6N/Sat/etquy8aJ2QuelEyCBRAEF9UhNCYR1Sxl4ztgws2sMBEqkWTDKiMDHbegpzyHLXuVt4/jvU/8CTSTMeEuAP7oRCnhLTTroHVvCML3Q2LUAhMkRtAJyRMkpTqcRQ2mMeAv4Idy89rK4U4Ew4HzzoypPWcxOgmxXq3J4ecMr4QXp6/sERoMoUw5jY6OcIj3tAMCHyB66qwhmZnDwJpqLuqEKKZodpOASIg41+/fo+9Gxz8RGN/UmNDR1CxyaVrO2qpxHMTCTZI3tJ23JFQ6UnMeIDRkLfAKtasPaswnAjtee5rSURuSnBHGHqBDZeFviMDys0h/xq7TdU7Ftfw8YQ7YsfZR2gQEpaMRP3nQeCWd/5bkqG3KCGrDO8jX0O8LdNNIRStyk5MfArrbZod8f6S0mjJQNLAwZNkueENuIw42lDl4reXePT8b/W5d9lsaulK1kbNlDB6H+ZEVhX7s+GmREj2jlxVKI0Y3iD2XJQS7ZBZRboxFN+j4mfOGmTcElqidmHPA5hU2pyqVuIMzviUehWMeyF3IGMMfWiLpARYMBgZ5JABeN3c+zO8ddDRun7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RJODh0eldHOVdvOEtuNytxSUV3VHVINENSSzVQWmx0VC8zQnBuQUFYTkJR?=
 =?utf-8?B?cW44Um9Gb2ZlWTVYWUFLZVM2UXNCY2hrV05LZU1PWHpuc0VNWXJzTEphaVlv?=
 =?utf-8?B?Wm5PQ2tVTmJkZE9iM3ZwSnlvV3dLTzkwbGJobm9VbThSU2czdUlGM0R0KzY2?=
 =?utf-8?B?Qm81K0I5d0w0ZnhpbDNkNnZJMkI1QXlmdDYycXl2L2dIN3dFaXhEbTRCdXIw?=
 =?utf-8?B?MEtOajZ3MDRtTTZnR0k5V1dESTZsbTNQaE5pVjI2VE1HM05tcmZRc2tBSGZv?=
 =?utf-8?B?eWlQNEFIaDJYTjJ6S0JHcVlLa2dVOUlocUd0Rm5McG5vV1k3emp2VDNnUEVQ?=
 =?utf-8?B?clpTTGJzMzZ6L3BicFhyUjd6Q1RWRzA5QWJjcXFzcXl0dWdIcGxFbFBkeFRw?=
 =?utf-8?B?aW4zbDg2T1MvR3ZuK2VVdlRxSmx3QVdXVFUyZll6NjJCZVRJUk5tamEyaXIz?=
 =?utf-8?B?RE1tMHhWTVp4UUFhYnFldjZEYTRyWm5zQTcxaERqM1J2RXpPeHBFa0NXL1Ja?=
 =?utf-8?B?ak9OM1VqZStFS21tazJlS2RSZVdtZGZRbzhKL25rcnhhSllJYXdPS0x0dy9Q?=
 =?utf-8?B?VFM2WE9hZ2I0ZW5oN3pLSzJMdm5CMVpVcmE1ZGlUVU5ySEQ4TDlSaWxiZ3VG?=
 =?utf-8?B?OTVTeVdsZDdBRFJxaDhXMVdzSFFjRXlqQXk3ZkNBcnpFUXlMaGhGNTR6anNk?=
 =?utf-8?B?Mlg5djErN3h5VzZodk1vdmdJRytxNEt3STQyeTNYdUhBVUd3eUFESW95NVd6?=
 =?utf-8?B?QWloYXZ2N2VXWEl2NzYzM081dzQwOFlmNGZXYWxVQ1JvZnZXZmo3eXVSU0t3?=
 =?utf-8?B?Y1czaVlYbVA4T0JzQmV3SlZJblhqaE9JTnFIMXpKQ3RmS250Q09oUlFFN0NU?=
 =?utf-8?B?YXp3VDRhMXZWNVg3RnV3NGtHZW1rdTFMNEVKSUFndmxWaXdGME9TVGZzWkZ3?=
 =?utf-8?B?R2xmc29SNXBqZU9VcklYTytRdkEzNWF3UEpEdk1mWUdnK3VGZHJ1WHNlN3Fx?=
 =?utf-8?B?RlFsR0NtNnYrazFCb0FaQ2xEWWhtOSt0TkN5WGFBd3JRZHhsTEZEcnpRVUQx?=
 =?utf-8?B?Ry8vTmF1L3BtTDRsdnZ3WUdXd2UzYWJQWlZLSXJpZkNmN09HL3lhVHV2dmcx?=
 =?utf-8?B?UlRIQjJjQmlucEdRT2treWRLeGRqbkZDWUw5RW1ZaGlwQW5PWmYvSUVHRmdp?=
 =?utf-8?B?dmJUbjFSN2VMSFpCMy9nbzBjOFR0d3IvZkR1VllSd2loaldyNEpsc1ErNjkr?=
 =?utf-8?B?aHpuSVNSa2picnJWZ0RJT3hrTVkwWkVaSzdsaVhmaFYxemhCMjRLKy81ZTQ1?=
 =?utf-8?B?RUhKMDEyeU82M0JZallYUXQrb1FSZGR4QnJMY0srcXRGVVhqc0lFenA1ZnpO?=
 =?utf-8?B?ZjZoZjhYcEd0RkFncnFzS21zZ01iRFBPZ1VPRHRhYS9IY3VacHVYd3NtY2ZU?=
 =?utf-8?B?UlVsTFRMZlJZdEhFRnhLTlZ4NTZKMUN1dGJOR1JKYXFpL2tkdmdGenMvRm1q?=
 =?utf-8?B?b0VtTDN3Y2xYWTFnWG5IZFdwZFJmT2pYL1lmS1NBZ3NQK0VhMXhWbUdkU0hK?=
 =?utf-8?B?QXNnNEJHRXR3d1I3VnpsY2dDdlJBNGRwUi9qU0lnSFZSdTJWTFFnclo0clgv?=
 =?utf-8?B?VVlJbE9icCtablFhWkJJS2x4ejJVQmpQY3JmaGdoUXBvekdpYzdWOGVtdWdS?=
 =?utf-8?B?UUQ0VjJ0b0ljdmRwQ0pzMDc5OWRpbTRMNWtQREtHQ3VtenlwRUlRUnBia0V3?=
 =?utf-8?B?aWtlM0ZiTGFXb2VvWE41K3JHSjE3Q1ZoVTBrK0g4L1BUOE5odVIyRjB4TG10?=
 =?utf-8?B?OGMrRll3TzNscFd6NERENG45OXlvWU9VQ0dtODlzdTE2by9KdjFrc3BKaXQ4?=
 =?utf-8?B?dUlkeEx6WWJLT2pNamh4K2laVGVTNDNDMy9qV3RxSU1zdlhMSmRyVWxCNlZB?=
 =?utf-8?B?VVFJSDNpYmVTQmZjSmtkQ3VtelZWdkNzUVVjSE1zZThkcnRuejNPQVBYT1JQ?=
 =?utf-8?B?RUJ4ODJWaGlqVnZIMys5ZHNLR3RnQWx0cnU3U0JQUGF0aUQrTnMzSmh5VFlE?=
 =?utf-8?B?VmVqcVFUSFdUV0NVSW9rVU81MmtsN3ZxNEgzVTNQYnZjb1RjNnpYM3RkTmpx?=
 =?utf-8?B?T1hvQzl3djBuWHlQc0R0OWtUaGxGUzNMdW5wQ3BvTEx4UlVQZCtoSTcvaVRB?=
 =?utf-8?B?czRFckFPM25SclpuVG5Bay9kNnNhc2N4WXExcHBSWGh3UEZVbFpyTEhOcFBj?=
 =?utf-8?B?dUNvOEVPb00zTnVtbitzNzJBUVVraHJBdUpWMjJidjRFbFFCb290SkdMb1Bk?=
 =?utf-8?B?dDdncGJYaXJFS2FxNXF3UmwrY09uN2x3QkhYdllpUnFLRjV0R21LL0RkRzBI?=
 =?utf-8?Q?XWD1vsKErh55FpL0=3D?=
X-Exchange-RoutingPolicyChecked: uXvVOvsH6x2gPtK06gp06Z6h+D/FAXCsZ7qtHGB7LD4NGF9GgzUw3BqFB9AOt6y/pawpwMH75MPeYSSxnl1YRA+ll7sW1PKUR90oLeiCqwnYXx6zv+r2UGS17vyGyfOVIUWtsUIlpGnm9XoJqf3VCaRMPWWHU1xT5O3qZpoz+V0gEldKZ6p7ACkim3ECtLKPD1wSA5n6L3+jXTbEuII9JJuINDUSy6QvZlhk/Sm3GVatEMqpHRQ5Y+RlUvfvvttBoQZhVd5qtuqe5HD87uEq0unYQlTNY2Dc7uPJxHN2SFeMiomefcryItqhNd0X9GLphcTGkUpY5h4VvwNIl7NZQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d8bb2f-10e5-4f26-69ca-08df052e93b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:02:51.6509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVpoN1DMwDXhjwV07LAeq8uWd01Xu+PXPj2CsjQfzrq2Tq844BgLKYoJ7+7MbRuiAUeyXNRgkkhzVyUQhcaqLFsL+NiNMLAQ5V9U8bF0teU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1AF044E07
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

Hi Krzysztof,

On 2026-08-28 at 10:03:36 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/selftest_rc6.c |  59 +++--
>  drivers/gpu/drm/i915/gt/selftest_rps.c | 297 ++++++++++++++-----------
>  2 files changed, 203 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_rc6.c b/drivers/gpu/drm/i915/gt/selftest_rc6.c
> index 68fb1830d411..c744579a942f 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_rc6.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_rc6.c
> @@ -14,6 +14,8 @@
>  #include "selftests/i915_random.h"
>  #include "selftests/librapl.h"
>  
> +#include <drm/drm_print.h>
> +

Nit for include

>  static u64 rc6_residency(struct intel_rc6 *rc6)
>  {
>  	u64 result;
> @@ -32,6 +34,7 @@ static u64 rc6_residency(struct intel_rc6 *rc6)
>  int live_rc6_manual(void *arg)
>  {
>  	struct intel_gt *gt = arg;
> +	struct drm_i915_private *i915 = gt->i915;
>  	struct intel_rc6 *rc6 = &gt->rc6;
>  	struct intel_rps *rps = &gt->rps;
>  	intel_wakeref_t wakeref;
> @@ -80,8 +83,9 @@ int live_rc6_manual(void *arg)
>  	res[1] = rc6_residency(rc6);
>  	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
>  	if ((res[1] - res[0]) >> 10) {
> -		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
> -		       (res[1] - res[0]) >> 10);
> +		drm_err(&i915->drm,
> +			"RC6 residency increased by %lldus while disabled for 1000ms!\n",
> +			(res[1] - res[0]) >> 10);

To drive the point home, this is another place where gt_err would be
better, since the test is concerned with a specific gt, and all kinds of
values can differ between different gts on the same multi-gt system.

I'm pretty sure the pr_err was written before multi-gt was a thing (last
two commits changing that line were 599b0d8ce6eda in 2024 that only
changed the string, and before that 730eaeb524261 was in 2019), so there
was no gt id to report. But now having the gt id stated in the error log
could be really valuable for debugging, so this series is a good chance
to improve the logging with gt_prints instead of drm_prints, unless it's
considered out of scope.

(In this case this specific test is always run on the gt with id 0, because
the file that runs it is not adapted for multi gt, but that's another
issue entirely and I hope you see my point)

Snipping the rest, looks okay to me.

Thanks
Krzysztof
