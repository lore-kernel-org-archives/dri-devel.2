Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DC9C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB3610F444;
	Fri, 28 Aug 2026 17:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XEPgCX8u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511810E04D;
 Fri, 28 Aug 2026 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787938837; x=1819474837;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=L4CRWpKcVURX5Z4kXljmTM3ji7hMGZ2vNvZL8oIChC0=;
 b=XEPgCX8uDCxp0d7vvt43y8S0ZunAEhK1WlD/XgHnPS0gAppIOnIAKen6
 WpFtGHlPrNKM8XHGmTEQvxMTV5+QivAYTAHF3snSOKyuc1Jt8M6TybQpA
 +UbfR1I+qntVkTUP5rL6IuBI5hIfbVg5R1iYUwtd8BSDZAjmXVhOofEX4
 sxgRsvj4uP/Ju72aiZV070rfD3yeINcc6LarWfsMXLgz0xoyMjzIjOxDX
 MfVQe74JZAjFi1vPdT1g1bRMJLKxbMoBteSXE1Zomn2uD/jciNbVanz/S
 GGBA1khD82HOD1sgjzFQrC3+l31T4szxTqug7DPk2jACa98JWvadsEd6f g==;
X-CSE-ConnectionGUID: zbU3RVfLSN25n9lfWNDD/A==
X-CSE-MsgGUID: phYTAmTwQ1CVXyH8pShCxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88503633"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="88503633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 10:40:36 -0700
X-CSE-ConnectionGUID: hgSYTkTEQtKDBEer8GjOyQ==
X-CSE-MsgGUID: aRKEkzwoTFiRE4hjBzZU1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="306432155"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 10:40:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 10:40:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 10:40:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 10:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT+87S0A71dHA7fpnuhKhUmmJ1NPP4gXG4kvGVeP4CUJ04+bRTIF5Z2OuzWkDgxGyxZZf3s0vQSxWRgYcx2k+shPjsHGiu2ChkZY9fiLKnMhpz+OkclvDxAWwIzwu7BJ5FjWoiiNC1j5DFNS0pVUlVAxPCiY9P891X9Xes1PZtttf5Or/yLlwNHjTNowAUcF5xpLRhKROo6Qb3rp9nTkxcKI5zACyRuWIkZ9ruH94lSu+y5KktJxo9YLn1MXkFiV6f0Xnoj+j4lgcbwYRm8uOusL+DtO4xlQNkZcIJkxfn0kDD0y1Sn658N3FLLbG47tFkerRQTitG7Nf4nfRGC7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tau3eojVYKXEo5JXlVcbTfSl9toW6XwZ3jLL2lZZyAY=;
 b=Ie21KR8mnAmp8mtEyrjYxR/J65XHoedh8dRAiGTVpmvyW3DEU66zppl1A2rdnujWpDaqgMP0774b5oDKzRNeikA+D6ww2f92jXPqzDglxXzG3/shju1np9QMYsCXo86ON6DmLt/4pSrprB3Osg1Yl6AiDG35dMkNQLdtIEtFoFOs2nOo8z2FnCW8jzL9G3g0BVfRyHjqQPf+rleGBD7SK7b2UL5LJlzdNw77HaWLX3JE5e2bSEfRcg/D7MQPH674y7pr8zgESwmSqIiSMXX9ImZRjeT32s109r/a620kEHMoGj4nVdSzYOCx6iAjMAw4P89Uhi1ehOrujUfuC1vOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by CO1PR11MB4850.namprd11.prod.outlook.com (2603:10b6:303:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:40:33 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:40:33 +0000
Date: Fri, 28 Aug 2026 19:40:20 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v3 4/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
Message-ID: <apG8ETM6SpUlPZOJ@kniemiec-mobl1>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828100339.72304-5-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU2PR04CA0171.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::26) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|CO1PR11MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: bcac35bf-020b-450c-545a-08df052b75b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tRJteqR+1wt+ZvcXfeFK254zsJKWfS5pPJ9f59JOJoKYAsdBN8A5hKKqlRUrha1NOPRp0UsrCXWaC24rZT4XBxpvr6kc38uy+S1uxktvnzUO85Wwsn3LxLnaKB/HC142Z9ACjJ1LvA+pZYSvsHFvSShmiYYsxf/AphL7OSpB59f0uZOFAvbs4+SknQSTbN7NFG9FY4rD9OrNALacw5/KkAnDmBdv0NPH2Fz1W7hB6H0NG9mBSXuERLM3vS+0T4BExTT4IXawp9oROF8D0VNbdKBble1u2yeXmjQNkKcRPzemdY0yDmxyfGbFBjvKt1qgIJlwE44a1U90IeP2hoNjcr35WngMo7NaJTpudkXfNtbidQQleAgU6YwCipk1wbKZFOIQ6q18OYUlj/4+XQE8qF+xgs0u0x5GEr9xCtnDhyk7gQUZObhOLJ4jMTaqjCtrEnWPOVrWCI/T+L0Cids40eFnm2c2szMZrL8BsWqGG0eXr5pumwbGSv/uCWqBYsAWh4aFjCSRf3q3L63XsP05i0Bgd3GuJn90KXgElUtQ0ufzJke17yuCiRL9EJikYsnvlBbMZQaVWrs2bpnrGaTei9A3u3bU6eVKrAZ1BnoTXDT2Raq3UTLpYjbcpGwIMiwe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhNeVZOQ0IzVW44ZTB4UHcwbkZqOWx4alEzdDVPcEtraisyL2M4UmR5b2hK?=
 =?utf-8?B?UTlmcy9TMU43M1l4UEhVaEpzTWNCZUd5MFJRenlxYitma2xEbThLTURkVGU4?=
 =?utf-8?B?d05Mc3VOa1Jpdk9xUWpybFpJZ1o4ZWpDalhTQzBFWHh1YzJrYkVBNzlLVlJa?=
 =?utf-8?B?dGdSQmZyT3RkSExDSFNGRGUrbm14Z3hGMUY5a3RwMlBEbGtXY0M2VGxiajAz?=
 =?utf-8?B?NTNwQUpTOFZmODVWVVZCeXhIc0RNbXVMNytmSVlGS3V5bkVocnhSR1FoenVv?=
 =?utf-8?B?bjVCYitiZGZHcUpFYURGY0lkM1J4cHpVUDJiUTVYYkZpaVhkWFF0d3djbSty?=
 =?utf-8?B?UWN0WjJYcmJtMnF0OXdGeTUyNUpFYzlPV1Jrbi84UjJMM3lUZGVzQzN4WkJW?=
 =?utf-8?B?Zkd4ejE1R0U2bzFIUTJpRmhLTkxiUDBYRDEwZENBay9Td0hMekxxc3A3cWt0?=
 =?utf-8?B?VW9URjNuQzJIdk1DY3RRZ2pYeGpESTFYUXV5K21UNDE5YVNyMys0WGV5YjVj?=
 =?utf-8?B?THArWUNyWW5icGwrN2lLV29yQ3dON2QyNk1oQXlYbGVhbzBDdTBaYkV2c3Zl?=
 =?utf-8?B?MTFhVU96aysyNWpENWgraURSRk84RHMrNCtOWGx5VE1aR0tiOEZiY2RlOHBh?=
 =?utf-8?B?SEdpbXlyNENLVGJPK29RVjFDejdsMmg1dDNBMWkwcWpLcXhxc2w2QUNRcnMw?=
 =?utf-8?B?U2Jxd255bGpkc1gzL1ZmM1h1bGZkSEoyRHNMQlpwNUhpWk5ZM2xHK2grd2k1?=
 =?utf-8?B?TDBBSW9OUVI5dWVvSklLLzJsR2piTStyVWI4QzRreUhyS05DbzE0K2ZTMUc4?=
 =?utf-8?B?dm5memZpSEkwUGd1b1JVbkVxbTVIc3B3UGF3U0l0UlVEOVlqVE9vSUg5emdh?=
 =?utf-8?B?aXljNmFIajNOUU1SQW5pd2lDazBHZ2laZWVaR2pwdWpERHNlb29yYUtPa0hX?=
 =?utf-8?B?c3N2akRUWDd5SnRWQ3pNVFhsaGMwUzdhUXZmcERzMlM2bEdMRDBuNlpqSldI?=
 =?utf-8?B?S2NWbkhyVk8wajJrSXl2enZkRUZtSVNhSE5rUUE3MjV2N0NMZENuS1htb0xD?=
 =?utf-8?B?OXhKUjBuZWQvT2hOaklOWGN5SDZZNHFwSEN2ZGlTTks5dFJRN1FQV3dHYlV6?=
 =?utf-8?B?bUlITXZ4ZjMyalpsWVJLY2pxR000dDIwTklmaFlmYTdWL08rSlR0azJPL3g5?=
 =?utf-8?B?eXJGUDVHNG9jK05BSU9mditBZVY0TVY1WnY5VGJDU1FZT2xiMWY3UDhoei93?=
 =?utf-8?B?SXpOQUhKeG9HRFg0d3ZCMDNONWQ0VDBhRThwdEZVWjgrM0hBcWxrZTAreXkv?=
 =?utf-8?B?d1pWbU1VdWh1dDdHdFZjOVFiWmZ0c0ZWd3pVQ29EaEovY0NRS3ArT01uVUpC?=
 =?utf-8?B?T0J1NkI5MnYyUEh0Y2Q0WWFxMW5xQ2g5M2xVM2thMEZuMlhncmtYeWYwNVNM?=
 =?utf-8?B?SkRRb0U0UGlIRDdSUGt6WTJhT1VKS3pCYnhaUG1PUWhINENGektRaVU5Zkl3?=
 =?utf-8?B?NHo4ZHoyVncvWmp2dVpTQkE4T01IV1YrakFaRmRKNFVQZGcvamFNbTh1Zk1Q?=
 =?utf-8?B?UWtsQnQzRnYrdmlURjI1Yi8ybWE1UmVQTVVvbEtxMlYvVGROM0pGRERZM0Rr?=
 =?utf-8?B?T2xKS0lmd2tnRW02VHR4WTFsMXNUM0lKZzhLaHhSZWMyTWQ4STFSOXNvakpN?=
 =?utf-8?B?Y3pHeUJtUGNLQjJjejFJbGxkc1pLbXZiSy9OSW9lVDZKVko5QU9kTERTN2FX?=
 =?utf-8?B?Y215QkEvV0d4WGdwSE9LOXk3OXlSYjN4NHhiMi9CTzR1dWo0d3hWVjNKQ0RY?=
 =?utf-8?B?OGFjUVp0dE83ZGJXdjBsYktvYTFHcy9mRXBQK1E0bUpvWnRqMldIUkc1bGZa?=
 =?utf-8?B?ZFU0WE9vZ05Zb1BxQmRTUFBNN21wV3dsTFdIaVhkYkkvcDlTMGVGUGlQS1Vp?=
 =?utf-8?B?RnZhZStGVW5xdzd3cllRUE4rUXJ3RVhwc2prcElyclpzVHV3dytrVVB3eEZJ?=
 =?utf-8?B?ak1veXBqSml4SlV3Y2NHSU1qVG0zNmtGYkdlbE9GMFlFeXUwbTNBVk5xWUFr?=
 =?utf-8?B?OENQNktWMlRpcnowR3pZNlYzeURTeXN4NXRRWmZ2YjFUTS9mU1FxNkIrWDQz?=
 =?utf-8?B?RWcyRHlVRmFVZngzeFlRZ2J3R2dyVlJXMkx6Q2tCOFB4T29HVDFVa0ZUSW82?=
 =?utf-8?B?bzQrVjNSaTNqcFA1VXdjbUdZUGtLdExWMDhCMzRyVVNJK2JUN1RKRExNdUt0?=
 =?utf-8?B?dURXWUFvbjZpT2VCaE9aS0puQWxLMEFhTjV2MXlKRE45d2xOSjBuVmNkR1Vr?=
 =?utf-8?B?Ynl2dWQvUFJxUzJVWjFrWTJtNGN5bWZ6QWhOK1hZZGZqWmdDZG9nMG9YOEJZ?=
 =?utf-8?Q?7dDvnTHYOokxQIVc=3D?=
X-Exchange-RoutingPolicyChecked: shn4mmKwrCSPhC8M8atp4o1EjnPtY00RY21yGqjpkNn2xXiFfNPd9OqX+Mr7XJ8DhHow90/Zh/O0kHeCpvN4Ka1ES3uX7dI4Z8QDfuni33bWqoYAHWr7WygZn7Zgm9W4s/+AadPUbYpJif8z6o9endjszS8JNXayV5Gmy55rc8PN4owzb841S6gIVjKf50sLYhMQ+5FHG9SHa4jAwjefs4hkCJ9P5UcLBHR85GVu4O1aP7uQn1VADpSqIvR+ucxD58k+5ntI5W6WzF8D4bPxS5lWYswFHSC+6fFrf1TyrGzVLxsgUTw0IAI4NDQYB6QaLm6PHV4/EjYA3VZogTBqNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcac35bf-020b-450c-545a-08df052b75b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:40:32.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll/TLweoR/R+64yi8LAi0lGfDyXz/vz6Wsdz71NpMMk8ueIEYZl3BCsTUxetEFDpt9Hvs4SRX3aV3UP4ZmaS/9hoz5BK/HmhdvK6XWFWrDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4850
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

On 2026-08-28 at 10:03:35 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/selftest_context.c    |  33 +-
>  drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   8 +-
>  drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  58 +--
>  drivers/gpu/drm/i915/gt/selftest_execlists.c  | 353 +++++++++++-------
>  drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  32 +-
>  drivers/gpu/drm/i915/gt/selftest_migrate.c    |  65 ++--
>  drivers/gpu/drm/i915/gt/selftest_mocs.c       |  12 +-
>  drivers/gpu/drm/i915/gt/selftest_reset.c      |  28 +-
>  drivers/gpu/drm/i915/gt/selftest_slpc.c       | 103 +++--
>  drivers/gpu/drm/i915/gt/selftest_tlb.c        |  39 +-
>  .../gpu/drm/i915/gt/selftest_workarounds.c    | 104 ++++--
>  11 files changed, 513 insertions(+), 322 deletions(-)
> 

<snip>

> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> index 21e5ed9f72a3..97dc44cf615f 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -72,6 +72,8 @@ static int wait_for_reset(struct intel_engine_cs *engine,
>  			  struct i915_request *rq,
>  			  unsigned long timeout)
>  {
> +	struct drm_i915_private *i915 = engine->i915;
> +
>  	timeout += jiffies;
>  
>  	do {
> @@ -89,20 +91,18 @@ static int wait_for_reset(struct intel_engine_cs *engine,
>  	} while (time_before(jiffies, timeout));
>  
>  	if (rq->fence.error != -EIO) {
> -		pr_err("%s: hanging request %llx:%lld not reset\n",
> -		       engine->name,
> -		       rq->fence.context,
> -		       rq->fence.seqno);
> +		drm_err(&i915->drm,
> +			"%s: hanging request %llx:%lld not reset\n",
> +			engine->name, rq->fence.context, rq->fence.seqno);
>  		return -EINVAL;
>  	}
>  
>  	/* Give the request a jiffy to complete after flushing the worker */
>  	if (i915_request_wait(rq, 0,
>  			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
> -		pr_err("%s: hanging request %llx:%lld did not complete\n",
> -		       engine->name,
> -		       rq->fence.context,
> -		       rq->fence.seqno);
> +		drm_err(&i915->drm,
> +			"%s: hanging request %llx:%lld did not complete\n",
> +			engine->name, rq->fence.context, rq->fence.seqno);
>  		return -ETIME;
>  	}
>  
> @@ -328,6 +328,7 @@ static int live_unlite_preempt(void *arg)
>  static int live_unlite_ring(void *arg)
>  {
>  	struct intel_gt *gt = arg;
> +	struct drm_i915_private *i915 = gt->i915;
>  	struct intel_engine_cs *engine;
>  	struct igt_spinner spin;
>  	enum intel_engine_id id;
> @@ -419,12 +420,10 @@ static int live_unlite_ring(void *arg)
>  			n++;
>  		}
>  		intel_engine_flush_submission(engine);
> -		pr_debug("%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
> -			 engine->name, n,
> -			 ce[0]->ring->size,
> -			 ce[0]->ring->tail,
> -			 ce[0]->ring->emit,
> -			 rq->tail);
> +		drm_dbg(&i915->drm,
> +			"%s: Filled ring with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
> +			engine->name, n, ce[0]->ring->size, ce[0]->ring->tail,
> +			ce[0]->ring->emit, rq->tail);
>  		GEM_BUG_ON(intel_ring_direction(ce[0]->ring,
>  						rq->tail,
>  						ce[0]->ring->tail) <= 0);

Here...

> @@ -444,15 +443,16 @@ static int live_unlite_ring(void *arg)
>  		err = wait_for_submit(engine, rq, HZ / 2);
>  		i915_request_put(rq);
>  		if (err) {
> -			pr_err("%s: preemption request was not submitted\n",
> -			       engine->name);
> +			drm_err(&i915->drm,
> +				"%s: preemption request was not submitted\n",
> +				engine->name);
>  			err = -ETIME;
>  		}
>  
> -		pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
> -			 engine->name,
> -			 ce[0]->ring->tail, ce[0]->ring->emit,
> -			 ce[1]->ring->tail, ce[1]->ring->emit);
> +		drm_dbg(&i915->drm,
> +			"%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
> +			engine->name, ce[0]->ring->tail, ce[0]->ring->emit,
> +			ce[1]->ring->tail, ce[1]->ring->emit);
>  

here...
<snip within same file>

>  
> @@ -2800,6 +2854,7 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
>  			       struct igt_spinner *spin,
>  			       int queue_sz, int ring_sz)
>  {
> +	struct drm_i915_private *i915 = engine->i915;
>  	struct intel_context *ce[2] = {};
>  	struct i915_request *rq;
>  	struct igt_live_test t;
> @@ -2867,12 +2922,10 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
>  		n++;
>  	}
>  	intel_engine_flush_submission(engine);
> -	pr_debug("%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
> -		 engine->name, queue_sz, n,
> -		 ce[0]->ring->size,
> -		 ce[0]->ring->tail,
> -		 ce[0]->ring->emit,
> -		 rq->tail);
> +	drm_dbg(&i915->drm,
> +		"%s: Filled %d with %d nop tails {size:%x, tail:%x, emit:%x, rq.tail:%x}\n",
> +		engine->name, queue_sz, n, ce[0]->ring->size, ce[0]->ring->tail,
> +		ce[0]->ring->emit, rq->tail);

and here..

>  	i915_request_put(rq);
>  
>  	/* Create a second request to preempt the first ring */
> @@ -2889,15 +2942,16 @@ static int __live_preempt_ring(struct intel_engine_cs *engine,
>  	err = wait_for_submit(engine, rq, HZ / 2);
>  	i915_request_put(rq);
>  	if (err) {
> -		pr_err("%s: preemption request was not submitted\n",
> -		       engine->name);
> +		drm_err(&i915->drm,
> +			"%s: preemption request was not submitted\n",
> +			engine->name);
>  		err = -ETIME;
>  	}
>  
> -	pr_debug("%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
> -		 engine->name,
> -		 ce[0]->ring->tail, ce[0]->ring->emit,
> -		 ce[1]->ring->tail, ce[1]->ring->emit);
> +	drm_dbg(&i915->drm,
> +		"%s: ring[0]:{ tail:%x, emit:%x }, ring[1]:{ tail:%x, emit:%x }\n",
> +		engine->name, ce[0]->ring->tail, ce[0]->ring->emit,
> +		ce[1]->ring->tail, ce[1]->ring->emit);
>  

and here.

Maybe it's worth keeping the arguments in these snippets stacked like
they were stacked before for readability? You greedily rearrange arguments
all over your series, which I don't think matters that much, but here it
is particularly easy on the eyes before your patch, and kind of lost that
quality. Giga nit though so don't address this if you don't feel like it


> diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
> index d73e438fb85f..770516c6c7da 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
> @@ -13,6 +13,8 @@
>  #include "selftests/igt_spinner.h"
>  #include "selftests/intel_scheduler_helpers.h"
>  
> +#include <drm/drm_print.h>
> +

Same nit with drm includes as before

> diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
> index 2cfc23c58e90..938218e0d5bc 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_reset.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
> @@ -14,11 +14,14 @@
>  #include "selftests/igt_atomic.h"
>  #include "selftests/igt_spinner.h"
>  
> +#include <drm/drm_print.h>
> +

Include nit again

> diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
> index c3c918248989..531dbc08c8c3 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
> @@ -3,6 +3,10 @@
>   * Copyright © 2021 Intel Corporation
>   */
>  
> +#include <drm/drm_print.h>
> +
> +#include "uc/intel_guc.h"
> +
>  #define NUM_STEPS 5
>  #define H2G_DELAY 50000
>  #define delay_for_h2g() usleep_range(H2G_DELAY, H2G_DELAY + 10000)
> @@ -23,13 +27,22 @@ struct slpc_thread {
>  	int result;
>  };
>  
> +static struct intel_gt *selftest_slpc_to_gt(struct intel_guc_slpc *slpc)
> +{
> +	struct intel_guc *guc = container_of(slpc, struct intel_guc, slpc);
> +
> +	return guc_to_gt(guc);
> +}
> +
>  static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
>  {
> +	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
>  	int ret;
>  
>  	ret = intel_guc_slpc_set_min_freq(slpc, freq);
>  	if (ret)
> -		pr_err("Could not set min frequency to [%u]\n", freq);
> +		drm_err(&gt->i915->drm, "Could not set min frequency to [%u]\n",
> +			freq);
>  	else /* Delay to ensure h2g completes */
>  		delay_for_h2g();
>  
> @@ -38,12 +51,13 @@ static int slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 freq)
>  
>  static int slpc_set_max_freq(struct intel_guc_slpc *slpc, u32 freq)
>  {
> +	struct intel_gt *gt = selftest_slpc_to_gt(slpc);
>  	int ret;
>  
>  	ret = intel_guc_slpc_set_max_freq(slpc, freq);
>  	if (ret)
> -		pr_err("Could not set maximum frequency [%u]\n",
> -		       freq);
> +		drm_err(&gt->i915->drm,
> +			"Could not set maximum frequency [%u]\n", freq);

Here you could use just directly

	gt_err(gt, "Could not set...

Since gt_err is just [1]

#define gt_err(_gt, _fmt, ...) \
	drm_err(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id, ##__VA_ARGS__)

and it seems like there's a decently accessible reference to gt all over
this file, so I'd consider converting the drm_prints to gt_prints all
over too.

[1] https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/i915/gt/intel_gt_print.h#L13-L14

>  	else /* Delay to ensure h2g completes */
>  		delay_for_h2g();
>  
> @@ -52,18 +66,19 @@ static int slpc_set_max_freq(struct intel_guc_slpc *slpc, u32 freq)
>  
>  static int slpc_set_freq(struct intel_gt *gt, u32 freq)
>  {
> +	struct drm_i915_private *i915 = gt->i915;
>  	int err;
>  	struct intel_guc_slpc *slpc = &gt_to_guc(gt)->slpc;
>  
>  	err = slpc_set_max_freq(slpc, freq);
>  	if (err) {
> -		pr_err("Unable to update max freq");
> +		drm_err(&i915->drm, "Unable to update max freq");

Like here for example, you could get rid of the i915 struct entirely and
just do 'gt_err(gt, "Unable to...', since at this point you're rewriting
the macro by hand anyway.

The gt_prints give even more context for the error (in the form of the GT
id) compared to drm_prints, so I think they are be preferable for that
reason in places where we can access the GT ref. So I'd look for other
places where you could use gt prints too.

>  		return err;
>  	}
>  
>  	err = slpc_set_min_freq(slpc, freq);
>  	if (err) {
> -		pr_err("Unable to update min freq");
> +		drm_err(&i915->drm, "Unable to update min freq");
>  		return err;
>  	}
>  

> diff --git a/drivers/gpu/drm/i915/gt/selftest_tlb.c b/drivers/gpu/drm/i915/gt/selftest_tlb.c
> index a5184f09d1de..89420f07f681 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_tlb.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_tlb.c
> @@ -20,6 +20,8 @@
>  #include "selftests/igt_flush_test.h"
>  #include "selftests/i915_random.h"
>  
> +#include <drm/drm_print.h>
> +

Nit for include

> diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> index 4e4c420ae67f..8b74d62e7ca5 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> @@ -16,6 +16,8 @@
>  #include "selftests/intel_scheduler_helpers.h"
>  #include "selftests/mock_drm.h"
>  
> +#include <drm/drm_print.h>
> +

Nit for include

>  #include "gem/selftests/igt_gem_utils.h"
>  #include "gem/selftests/mock_context.h"
>  

Thanks
Krzysztof
