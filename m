Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ED7C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A62310F42D;
	Fri, 28 Aug 2026 16:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YKNeIU1w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34E710F42C;
 Fri, 28 Aug 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787935291; x=1819471291;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GSk/keA0D1v6PwIq6yUPrcwZu4qr3E1vkc5Ms7GbD2s=;
 b=YKNeIU1wH81q9uaViHpzqHJxlZyZPf/oAhUkX3YYp6zDLjH8e6iMnDtF
 901jQSl5kzE5jg8mWoFMRebxxkqKUw6AItUBU/W4maNy35Nh8zfFh+Fc1
 dMitogp/ZCNKR5XNbKxGdRIOWi/IExUoqJhiYFIsrhaLcjJ+fgWRpnfEx
 2Hh518Y+0cPn6Ob63p4F6Vf/VoGNgjdza/sC3i6wfrWvsfc2c6vRPUa57
 KHDCLqQt9mKH5kFaB26fq9v6MZoxz+Ezmqa0AVTipQbuu/bG33Tqqb3pQ
 8UJXhqoYKg+sH7bi4DDqDt2ABCfo1MsZAXepE6mlK+xr1cxznFM1b94NO A==;
X-CSE-ConnectionGUID: b2mwRZtVRIeY9s3Rz+ZIsg==
X-CSE-MsgGUID: FHYskx22Tv+qOsCNXcgCjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88653651"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88653651"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:41:31 -0700
X-CSE-ConnectionGUID: WlqSZexsQyei2EOuxBkzaw==
X-CSE-MsgGUID: gxL0VSZUSqi30/M4FlmVMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="268759303"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 09:41:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:41:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 09:41:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr0EmNoWJtZni56dQ+KlZXuiX8ubdnK06rbBdxaH/+olvmmcsTtPqJOEn4QvtRNPGca5q5CY7s7WW+u/rNSRnqdEJ/QEesJevtuCs9W44a3wGMt/T9mavkdkcaKJxk4qnf/lt1kHkXVVcnc03pH0mJDsK5uQucQXA7yKfZ4+f8biiRjRK7TM3KKwkS4HwXQA+H4gDk1553dIifnyn5dVY2oMpGFSLUFjF2JUzZ2qi2EuZO4T5Go7jiFB0dZRMpZVcuiEnBKHq6QtgkNi0nhgfUfC68/N/7gqy8Z3tDI9gI+Jy7r8HbFjfG5rwe+Z7V/EU93nbn2CHtItp8SLRd9Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qixJtKgBpFv+QRptRjhKE80ci6Pn3TxcJRX1lAid9uo=;
 b=xv7ElJOC5b6dAxoO7xh1Nhkl0RBLSFmgV0WgGdU+TOHvhigy2kAXYFD3Tz+w7wlZJg752ZS3hJr/fu5FWTTyqJNWblHYCPKc5jDJEFe5RIdSLlOgpbydWZFFyrc3GUF2kapiU37ri/9ZIC+Ftiw1r3BaSono1NBc/QOQyHdzAlj1TF3IpQIYLLUvv16WmCFcd7uVyNgiIAxqJAuDGn3C9DO48TY7PrC0Q4Y1rTwLPsq/Nxb5XNCKiey+lG8i1jyjVNk9hoFtyIgh+uwvZxhmc6j+2d0QSXNBB/MrA1ca/GCPQwMU1Dewhx3PIzBeFlPC73t3hT5UdKFLCS6yQoZfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by PH8PR11MB9976.namprd11.prod.outlook.com (2603:10b6:510:3d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:41:27 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 16:41:27 +0000
Date: Fri, 28 Aug 2026 18:41:18 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 2/8] drm/i915/selftests: Use drm_* prints in live
 selftests
Message-ID: <apGtyDcru1fptbcX@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-3-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU6P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::28) To SA3PR11MB8022.namprd11.prod.outlook.com
 (2603:10b6:806:2fe::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|PH8PR11MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d570f5-0c02-4529-6dac-08df052333d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9Dez5zDvB2RfVjmVmkHrPi04s6B4d20LTscZ2jYJa70Qqz1K/oPl6clqkoaGiCAehVw5uZzfzDfYyaLi+dppHsFbUPCYv/LLyr3BAIYelX31YK0Sqry7k8RmR7Sz8YExZE6CznXNL9TdX+Hl/rQYq4tcbtSX98/d4+MrxZk0cOZ+Y8qSzBOLhECjWYb9jkNhL2hZ4vi+vSmktRQpNlaIeOJQ1IjApPSeYrmSndhtKGR1CsZBpDIwkt63r846tcpMJ6T/WjuwLYyC/msIrBVAsmNQEPFqJcJm0tqZXSEJmGK6uQ3cmWBeu2sKmkqlg9+u3+LN7xvw1rcgL8xXEGq5wYw186m3CtsD6vBidtOSYYG/tBVNmVWvRxTnVHFp7jwSbdQCOLmcBj0ygCNRHel4D9S0Vfp1wLwbuOrEL0Ds5RfWrlhJhWYG67sXErrc/fa34cM4Q7On2y6i7lM5af9yRS1Tp/7Lm2wmSSi/7JsfG5y79YLXUfNZM1df81Og6aRI0+jOJeMJdcnyPPzvTBFn4CtShhML9fYfopTZ/Pnk8WcB17i9VpImkA3zGhubpEpEHylMXInuh881RksEdEZ+krc/ZUjLk34UOA2IPjoZ2J+Delmr/g2jrZIjoQdrSYWae3/CwyGx5zE8MRdxlTfwcEBqV0vcIZz66iL5ft40CuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VERPNEtqRVRoSkRUQWRsdlpmdVVUOGRHd1pWSlZkd0dGOE4vNDhITnMyQXlQ?=
 =?utf-8?B?d0s2ZFBjdnEvRTJmYkRxcTlVa2g0SWNCZDdVeHRZVUltZmh4SG1CR0JnK3Bm?=
 =?utf-8?B?L3pPRWlzZGpmOVVGL3FXNUVJd1JSOGU1dTRQU1JtWFkrMEt1bmIxWS9HeVlX?=
 =?utf-8?B?V2t2SDdwYnl2c05WTlhJT2E2VUxKbm1TSzJMMG5tamMwSlpzY3lncGxBY0VN?=
 =?utf-8?B?a2F4WENkaE5ydzViTzZzMkhyRHRYcGxXWmRDdFFGVHVmVDA1YkJFaWtRdlNP?=
 =?utf-8?B?by85TUR5eERxQ3ZONVZEdGpmVDBoTlBodERiOWtDbE0ySHhpRC8yeDR5ZnFp?=
 =?utf-8?B?TS9IWGRsbGV5Y2Zwa1BnMDk4eEIxNG00aVQyVFlCN25nbG9PYzA2TVFuSGNj?=
 =?utf-8?B?ZmJtMHRldGZBYkdrbmNFdjdhUEYvMHF1cUZYRWpOSDRsWkY0SUJ5OTJaN29X?=
 =?utf-8?B?amdFcFUycFJvVmFlSDFsYTZpKytOVDhZcVFNdjF3NWYwcXlHMzBqMjRodlp2?=
 =?utf-8?B?alBSU2MzeVU4N2pNMTgzSVFFRE1vMXJ2eWlHc2VaUVBVMVZQeGhMQ3hBU1Ez?=
 =?utf-8?B?WjRqbWQ5a3lncy9vdnYzQ2ZxdFlETERFWWExTTF6WDlMZ1BDUGdWb2FLRmNL?=
 =?utf-8?B?ekpvNitFRm9lSHNxSFZPdGdlcnhiSkNsblFOK0VBSmVXUmhySkxUU0xkUERE?=
 =?utf-8?B?dGNjdmg1YUd3M2xwdEt5RVhDRTBmemZneEVLSWxkYVNObE5HZDUzME1yWUh1?=
 =?utf-8?B?MnJkMWR4VVltaTBJa2c0RjB5TU1nRG8zVklhRkNSelM3V2VmOXRaMTBNcXNo?=
 =?utf-8?B?cXJub056Y29JOXhEKzc4bzdGSWliNStlcXg4WlFhQjZEVXZUMzNwc2c2NHNQ?=
 =?utf-8?B?eHliVkNkSWtDY1Q4eEhQS2VYbHJ3YU5jNlg5NW05bVZjL3N3Q2w2WmJ3TXY3?=
 =?utf-8?B?WW5iRlJOOTRXS0s1LytFc0FJUklQUXpEb1BHblVLbTZQRUdjL09uOG9PMlFO?=
 =?utf-8?B?a1dQWHpiUEhCdlE0cDVrbFh2WStodm5YZ0MxbUlkTjNlT2t4TE8xM1JsRlNX?=
 =?utf-8?B?SkpscVNENkdDbnl6WFNoRkhrNGRvVXdHZlBTeGNPZDVPS3pWcy9zckJmNmE0?=
 =?utf-8?B?WXdrR01qYjdTUFpNeVNlbDBkU0liTlB5d2VLbG51akNSNFpha1RRRmhIQ1JZ?=
 =?utf-8?B?dk9qUXdiVldzWjJYeTBEYVhBeTcrYXMyeFJuSFNUa0tWaklNNHU3MkJabVFq?=
 =?utf-8?B?M0lYRlZCbWZpbHhUOXk1ME5RTW9hcHRXa2F2Z2hxd3BvWDNxRlVyNVViY3h6?=
 =?utf-8?B?SFVCVU51WXlLMzR1enlBdTFoZU1tbWR5TWRRaXh0SnAzWDVzbDBOMjlFMTRH?=
 =?utf-8?B?dTVnS28rUU1VK2VBUCtkaWNMdEZ4VFVydURoS1U1eDN6Um5mekVtM05hZGFH?=
 =?utf-8?B?a2lBNWFBdmpIT3lYZFZhVHZvcUFkZVdWUk9iUmtIeUdjb1pnRXlMS3pmUU52?=
 =?utf-8?B?R0pUZzhGMzlOWjdOdTNVK2k2L3BFdnlVbUxJSW0rdmVsUUNZU3JVVU12V3VZ?=
 =?utf-8?B?NU1WYU5TaEdtaFd2VGpKaEN4TTJyajlQc2UxczNOL0lkYTYwNXZ6ZDBGMzVt?=
 =?utf-8?B?cG5FbG1BZ3BwVjN5L090KytRTjVLcnY1N0xzRTI2cUhmR3lYd1JCeW1aQ2tS?=
 =?utf-8?B?cnAvOE16emszWVY2MERKQ1ZmWGhMVytFMExpYWtnM0pvOTR1NHdGVVlXK2ZL?=
 =?utf-8?B?cUREenFwbXZQWXVrYXhubE50YUxLNVhuaWcwUUNoMG9BcUJOMWR1OTUvaTFa?=
 =?utf-8?B?eEpZdTZwNXhINWw4OHVwbElBTTd4VVcrQVZxampVRzh5cFZwV2NvVDZZZUR2?=
 =?utf-8?B?WVVqRFF0YTU2bXZFQjVDNXRMY0FlUmliT3MraHIvYkNGdmdDRWowRSt5ckgv?=
 =?utf-8?B?MFpnYnVoSW1IRzQrZGlBYmtjTFAwbmpveXcxZzd3N3N0WXZMK3VtVzJFcncy?=
 =?utf-8?B?V2lJK1JVaEJFeUxBWWh0QzhSVUg2Z0JsMDBpVXRUVFl1cHEwOTFrTURoaEdP?=
 =?utf-8?B?ZEh3QlgwL2M2T1hrS1ZjR1dKRThBbittRitRUkZ0dzR6Vi9IOVUxanlBcWpi?=
 =?utf-8?B?bHVWcENidW0vaWdYUDVRdDZLNFhCWEJGMXQ1ZXZHNU5LRElRTE5wTFBXcUo3?=
 =?utf-8?B?bmh5T0R6TTNpaDQvNGM3eCtiN0l1c2RRakN3VkdocXZ2TDVoUy9OMUdkVUZu?=
 =?utf-8?B?K1EyUE5lbzZ0eGVHSENjK0VYbHBsSGtPZWM1TDY3WER2NGdVWE9BWXI3UXJR?=
 =?utf-8?B?b1JtdHhIcmVHS2x1cVAyb0JOQy9yR0lmSm1VemR2eW1kbjJnbXFuVE1FNWUz?=
 =?utf-8?Q?8t+zNqVXfYf2ACvA=3D?=
X-Exchange-RoutingPolicyChecked: FarLmMEIrphsW3N0ifWD2V8HeAmTH559zReTE7sCMOpGXy6qjxQrhqvhuhkFa8Qd++Jza/9FBe6IVnp/aocTR0e5YsQzzk9TTEIjtX/9dZgeqQxKClqymWiGXz5y5oNKUdjWrh50Skzs+Gmd1/SCYeEZ9oMM2MopmIFNaMZDCfOVmudQpRSSBbA5hv41SYsq+BRDhZwmHno/11H+itc7MUw8doPGl0zRijyCZkbZ9TAASjv3jaz3OKs9gCDDSsxaA9MQE7mcaW51Ub09MFMmzep3NDlSCm/di37gktts8+7uY0W2QQ+pyA5jFXktF5Uxsk8DuhiqtMZ+lVE+wNZYPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d570f5-0c02-4529-6dac-08df052333d0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8022.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:41:26.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aDojvsY5QsISUyJfd3WbUt/EvxkbnRblzTU4nYkHyOop9yFGDc231NpEfquirL3ruXLj/kCtjyg61J6ZQv5uompqAr650gn68R+4TIXVYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9976
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

On 2026-08-28 at 10:03:33 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  75 +++--
>  			i915_request_put(last);

<snip>

> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> index e6bd06774816..0c855f00c3ae 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> @@ -25,6 +25,8 @@
>  #include <linux/list_sort.h>
>  #include <linux/prime_numbers.h>
>  
> +#include <drm/drm_print.h>
> +
>  #include "gem/i915_gem_context.h"
>  #include "gem/i915_gem_internal.h"
>  #include "gem/i915_gem_lmem.h"
> @@ -34,6 +36,7 @@
>  #include "gt/intel_gpu_commands.h"
>  #include "gt/intel_gtt.h"
>  
> +#include "../i915_drv.h"

Is the ../ really necessary here? It builds for me if i just switch to
#include "i915_drv.h", other includes treat driver/gpu/drm/i915 as the
working dir. I've seen both styles used in the selftests but it just
looks a bit out of place here.

<snip>

> diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
> index e9469e27f42a..d2a1a901d47b 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_perf.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
> @@ -14,6 +14,8 @@
>  #include "igt_flush_test.h"
>  #include "lib_sw_fence.h"
>  
> +#include <drm/drm_print.h>
> +

Giga nit, but should this be before the "" includes?

<snip>

> diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> index 514d2200751b..1f58024150fa 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> @@ -26,9 +26,12 @@
>  
>  #include "gt/intel_gt.h"
>  
> +#include <drm/drm_print.h>
> +

Should this be before the "" includes?

<not snipping here, same file below>

>  static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>  				unsigned int num_ranges,
> -				bool is_watertight)
> +				bool is_watertight,
> +				const struct drm_device *drm)
>  {
>  	unsigned int i;
>  	s32 prev;
> @@ -36,22 +39,22 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>  	for (i = 0, prev = -1; i < num_ranges; i++, ranges++) {
>  		/* Check that the table is watertight */
>  		if (is_watertight && (prev + 1) != (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
>  
>  		/* Check that the table never goes backwards */
>  		if (prev >= (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
>  
>  		/* Check that the entry is valid */
>  		if (ranges->start >= ranges->end) {
> -			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
> -			       __func__, i, ranges->start, ranges->end);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) has negative length\n",
> +				__func__, i, ranges->start, ranges->end);
>  			return -EINVAL;
>  		}
>  
> @@ -126,7 +129,8 @@ int intel_uncore_mock_selftests(void)
>  	for (i = 0; i < ARRAY_SIZE(fw); i++) {
>  		err = intel_fw_table_check(fw[i].ranges,
>  					   fw[i].num_ranges,
> -					   fw[i].is_watertight);
> +					   fw[i].is_watertight,
> +					   NULL);

I'll join Andi here in that this looks a bit weird. Especially since the
next function in the file intel_shadow_table_check() keeps using
pr_err(). Either convert that too or don't do either.

<snippnig the rest>

Thanks
Krzysztof
