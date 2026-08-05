Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303AEC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E572B10ECE4;
	Wed,  5 Aug 2026 06:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zqz+RNqX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E77810ECE2;
 Wed,  5 Aug 2026 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785910355; x=1817446355;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RXpXpjo3bctOLmYKOG4tyqX7N1w3CtR6t4T9J7FiaS4=;
 b=Zqz+RNqXN+nO3Qe1gu92i9uty+gxhBucQL3yxETwWB8tQdFrLOA6UhYr
 74e0siWDjyPoQSr2xz0lDdSK/zhUFeHqsUig8eYiX3SsKfacBYtvzQ/pe
 hX1WVUmYCJENAYL49/omvVTnBLWJwmW5x3dW4ZQYxyUanTbT8ChcvZygU
 Z1/u+0agg4az+Tjuk4nRSDckE3LGQpJM+NqXZWjSzcxMbF5VqfaImd6rz
 RTtbL+6bMlOD3bdRPjSm7uPw88ulfkOmGbnRQWruWdMBhBW5Tmf/pimyO
 YxPlCogl44vI8f5R7pPP9y7vvIj6c9DvGOzE/Znpr95/lHykyTkYw9FY6 w==;
X-CSE-ConnectionGUID: YQRLcaQzQ0y5YZhiil+rPQ==
X-CSE-MsgGUID: ucx1zjvZSeKWEpihJBKuNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86334732"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86334732"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 23:12:35 -0700
X-CSE-ConnectionGUID: oc+K6irDS4q9jcdZS026eg==
X-CSE-MsgGUID: k67Ye48+TQG0vP0+faui+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="259960754"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 23:12:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 23:12:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 23:12:34 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 23:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHoQQgquoaK963gyosZBHgyGjaWKMkG39khoMmGBVcbqKGJZe4dGykLnLlO7D5i1HiAC0bZojnWLDMCw7YgiuIy/AxrBz4zJNOrtfCwqmmQDyAVo/7sgJqepjNInjJTj2TMe0XNtSFM0m7CPs43/qXkWtk2Ngsqm0FCLHWO581ql3SBLTTizOLUuRlyVSqvZ0qsKBBGHXb6pe2F7bJfTEc4ZyyLxTO07J09dlJrcbqSnqlqa/dlaTEIR/+dx8HBOFIcBi+tOU+Hu0ScKtUwv8zpSfdVDv8/07iAkf1XMSRsJNMrtv7xtUX6WNFgtuAGE6GpPZ2cta2sl27+HSUwHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d03t6K2UqBaVJhKsf00hJldpkJ8ScHSLvW3c543Jy64=;
 b=xzwHdZD+PT112zekRPgAZXX1SHEGj4tXL/0uiS61zvj4FLITrYVHP1EUcFc0XnJ+LFWtGLLXJWXSNqW2iVwQPJSP0H49Z/xdz0rg2zn9Q3TKHMjDFZHnLSTuQDIf+R/x+1o+N0I0vjNi0GWrKRa1TDm6XGmdMCo8UFFvuFiky0tp9pKW3B4+Yh76GP47Gunh6w/Ws1xVshhjUxIuaMRi05eKfXjxuvg2VyemHG/Rod43zq/Os1Z4Pq5YvhFzMRPFgwA42oEGuxbcaQnAV/WovNXL50u2bjnuLCiStsPkeupBfp1MnMY0vlmljDi7P10sejvNNFN4186e5x+HyQ3JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:12:31 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 06:12:30 +0000
Date: Wed, 5 Aug 2026 06:12:19 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Kees Cook
 <kees@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/i915/userptr: Fix user pages leak on get_pages
 failure
Message-ID: <7zkpubrkbuxbygwwdd6a4db6swbckoaaujwjppsalhzoqvvl5r@4uk2j3xgvzym>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260728054152.140524-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260728054152.140524-1-zhaojinming@uniontech.com>
X-ClientProxiedBy: DUZPR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::23) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: dec60c17-46e3-4655-e3a7-08def2b8881a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Um9pLKoTsvxtZ9DgJhRw5jsO+EdxxnNIjwR2ZR8bKfQ14OYpSJXwNoEbV8Q/RhBe1eVu8/EXHbbV9V+PHzz23k2V/VU0xyWnBBuWE5Ko3Z4gTHXLiGilivYUSeViBGUyVJzxLb8ArZGV7dFQs63V0C2CXbQ1hnlH6RMfu6BlnekVFTCWELZYpvLV786bHSQpLZxG3eaGtax8KcMqnnA08jc0EHojmXI6ZuhC1ddIqz2r4po9WqbZ5eOZjhsiv1+q6eQz3v0FlAPdcQhMNfkdANARZ5mRhv+T8xXNBEvdFMVoCRWFpeqr9ePobp6z8o+peQveJ5CpND0nIeylug5qhwDCpUp1SoAYmseiFpYCxiJINrKDPrzb1qTV+DDRkBezzGaeXea9FzXMO90uX1pMIj1wuRwVScOqzMmQmV8Mh37W7r8KuRnOSF5aIqDnpzrkPWh0GWNUzFlS8LtIxE+43m3HOrqk68D1EfRs/HfVUxbo6M2UGirHrRCNjwY/cwiD0SdjMRNqLVnvbHYwNNRUbcoE57vHyC5L2qAiXd1C8PGRuYmEt1OgpHZJIb4cCAL7xYGva1QiURQTxPK4e5hAf+nAFhtVkyZM079tgFuBpS14MDZBHTq6um3Vr3p51u7cq7QuIXr6SJChlxZW8/g39ExGx7oV1Onl34NWatZkbOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZhYXArcHJMVGRpeTEvemwyREE4dXFDRUFGVmZ3anZvK3IwYzV2aXRpSDNo?=
 =?utf-8?B?ZDNSTUdJQjQrM1R2dnEyMXAvQzdSM3kxVDdyTWFsTEFSejFDS0xZT045UTNH?=
 =?utf-8?B?Zi9QcUpzOERNVmNPbnBqVlBHYXArT052bS9OQjZFdnhWVjBRM0hMUTB1ZGR1?=
 =?utf-8?B?UlEzNVdCRFphRzUxOXczTGg2NDNINXJvYk1vQkdyekZKUXNyOHRjOTBKZnJP?=
 =?utf-8?B?R1VkTHBpcndtR2hRcG1TTmJQUEExNWsyVmUwcmRralIyZ1o2UHNsb0hkNk1y?=
 =?utf-8?B?c3VwUjNZaThjcm5hcVF5TzhzajNJTVp2bktHb0ZGdno4NkxwQUtBY0ZXdCs3?=
 =?utf-8?B?bHJVVWtkZ0k3SHBXcUN0UkFrT21jaFJYUCtnb0IyL1FxT2NCc0JEeE5CWFNF?=
 =?utf-8?B?QUhpd0cxdU16clNnaElDTUdJVUJMQXZabEhtMjdCOTJoNHFQeUExU1BrSnAx?=
 =?utf-8?B?aStuR2FZakh5TmcyYVFqaUJ5NC9hWnRJTk4yODZFMkVNMjUxZ0RIZmtlWEkr?=
 =?utf-8?B?dkR6dDR2aEZoZ2tUNkdiTEZkUGgyOUV0Ni9xNlhwazhyL0NrWjArUW5TOGJx?=
 =?utf-8?B?VVQrSHZZS3grVUlQakR1UHl6K3ZKUUcrVWhEQTh3SHV0b29abkFpYlpNUFdz?=
 =?utf-8?B?U2ErdVdvT0xadjdBZUtadzhNNlFxMXVkblNjUFUrUmxUQXloUWxOdmpobzMx?=
 =?utf-8?B?N2loTHd5LzFoSVoxaGxRN1B3M3h2S0pQQlZxRWg1TnVYSG1VUzZrTnhaVW1K?=
 =?utf-8?B?TFdDTVBlN3lmMzhnOHlLaVBIeUZpbW41QUxTMTROZENLT3U0NVVvY0p4N0dU?=
 =?utf-8?B?SnR1OTFISkNIL1ZsUjJIQS9Bd2FxazV6NjFZclZ1U3Z2ZGozWVNhbklpaTIy?=
 =?utf-8?B?VjJpNjBrTDZ2b1JxUzVsWm5ndjFvd29UVlBqYWpnT2xFSlR0MjlPZW5uUzR6?=
 =?utf-8?B?SnhUOTVsSHkvTjlKUmtaeDFOc1VCQUFFTFVPRDVkTlp5UXAxTW9JbmlpdmxF?=
 =?utf-8?B?SjJFdFNnWmZiM29QNTJGV3BWZ2h2MmljcVUrSk9maDhlQmRGdWJQa1BoZ211?=
 =?utf-8?B?b290OXl2dTk4SE9yMmtwSmwyTFFSVlVpTE8zUmxzNG1mMGFWdkw4TGtSeFVH?=
 =?utf-8?B?QyswS0wwaDlvNkUwYkNUWEQ2SE1Fb2hCUHhwbzdWQnUyK0Y3VnlDZTU3QnFD?=
 =?utf-8?B?b1JFMCtBZVR5RSs3OTk5K0pUaUt5Z2prYWNwQ0E3TzJwMUZKRFBxVjN6cEFv?=
 =?utf-8?B?a05SOEIwV0pIYmhCVWpJd2NDYUl2RE5ocFhZcEdEZWpSRGdvaTljSG1hY2pp?=
 =?utf-8?B?akhDMnlrUjZUczk4VS9aSnI0endwVHlsNlU4THZ6UE1DSXYwK1VPblhuT25M?=
 =?utf-8?B?ejgrV2Z0Z0xYL3VIZ3J3WXJVd0ZYdndSa2hHMGhpMDhMdU16ekVWSlRBcnIv?=
 =?utf-8?B?eXRmSVIvdEoyclJUamxEL05jOVZIT0c0RGlSNkt0eDBaM0ExclhadG1FUGdn?=
 =?utf-8?B?bUtyblBYWm4rUnVURm9nR1RaRXR3WWlTVGdkNUdjUG1yTDZIaWVYaGtVQWx4?=
 =?utf-8?B?ZTlqMUcvOWFac05vdVNpd0VRM3pieExGUW1teEZ2YWhoQVdGcUI4NldkZVZP?=
 =?utf-8?B?ajFWUDVqZElGY0trRmdxR1d6cGtWU2FEd0J1VE53L0MvV2N2Z3pDS2h3ZkNh?=
 =?utf-8?B?M0JMRTlNRmFmY2dZOUZOSWZGYjJoVjVVa3BhQUJmWUV0ajY5Vm01UFp2NndB?=
 =?utf-8?B?eXZTdFhaMmRydlQzcW0vbWkwVk1SbHU0QWFsR25XK1d2SlMxcWx6VVhaZFJv?=
 =?utf-8?B?WnZPaTNvWkQwYWRmSnN0Q2JmblB6T2toeXZobXBTK1RiZVFSMGRuTWgvQUtJ?=
 =?utf-8?B?WVk1M1hCL0Z5YmxlTktSWFNkWmpJR1Zhd1BSUE9ocndPS2RpQXRBQ3B4dHNJ?=
 =?utf-8?B?a1MvLzY1V1dKeGNad0VPQTJVNWN2TmFYdWZmNXRaTnIyMUJFSklraVJMOGpG?=
 =?utf-8?B?OWJHKysxMmxxa3E0empsRjViOWRNYm4zaTBqOVJLTEc1SzUrM0hTU1c4VzR3?=
 =?utf-8?B?cUFmNE1oUU1FRUxUZGk5L0pNUjkvSGR4ZVY3U014R1hhcjBBVWp2TTFESVB1?=
 =?utf-8?B?aHJjL0Y1SVY5MFJoUTB3Q2JUMitjTGpQQ05Td2lxZXZSTk5PV3VZR252WlRa?=
 =?utf-8?B?eE9vSjEyR1VUb0VJbjgvSjZaeU1veHNmRnBkK3BYbmRWUmJKOEQ3ZXJNMElE?=
 =?utf-8?B?dEhYb0t2RzJkcm0rcGhGQnA2SUVrS25ZTWNtdmlBbndGcjQwQTVLZEJHYmpk?=
 =?utf-8?B?L0N6aDFBeTdncFJxVXRhVHhRTWhOSGVHTmJDWmtsNE50cFhQeWRSYWI2dDMr?=
 =?utf-8?Q?4VZMRZP2wBAOh9eM=3D?=
X-Exchange-RoutingPolicyChecked: Z7DwlvECsQNsjEbTHxCjtFnEuC8eCKnoa2TrS+2o4RK1TzGh7RAUONI11pnd7aDMWSAEJ086MALDXez00OKpp7dkWyvrDrpWd8KMAoK3kJpcYJzlgN+cVyGdqEoWWznidOPrpfUO+z4wPahPbHqXlUf0JEbioteUotWTOHMkK3dKkLdlIyaVAap+RCS3gZ+xNv+TIvljor2/74nxAEs0p/UEYGWZmuYJZSi5CwyTLcRzlp6DpqblVZDnlvZW8MqGOLiCNoFr6pNbfClSV/rbPUz0lK2Kgc1XyiBGPqeEKYmbuxqwFNeGOU3eS4Hai7Yo8AQydDnS6aEMeowvslVQ0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: dec60c17-46e3-4655-e3a7-08def2b8881a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:12:30.5860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbTKAi/55iDP+A5T8ENCIrI8n/G2sjDtiKeUyk8JF2otXLCET4ZifE71Dy23ZtBIg+nqCxRrUUjb5bIakUkOLwRHAeKDWENNkMBKXRIn3Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
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

Hi ZhaoJinming,

On 2026-07-28 at 13:41:52 +0800, ZhaoJinming wrote:
> When ____i915_gem_object_get_pages() fails inside
> i915_gem_object_userptr_submit_init(), the pvec containing pages
> pinned by pin_user_pages_fast() was never freed:
> 
> 1. obj->userptr.pvec was set to the pinned pages
> 2. The local pvec variable was NULLed
> 3. ____i915_gem_object_get_pages() failed, but its internal
>    i915_gem_object_userptr_drop_ref() only decremented page_ref
>    from 2 to 1, not triggering the pvec cleanup
> 4. The unconditional obj->userptr.page_ref-- brought page_ref
>    to 0, but the pinned pages remained referenced only by
>    obj->userptr.pvec with no path to reclaim them
> 
> Additionally, the cache hit path could return success on a
> subsequent call despite page_ref being 0, leading to a
> GEM_BUG_ON(obj->userptr.page_ref < 0) crash in drop_ref when
> the pages were eventually invalidated.
> 
> Fix by calling i915_gem_object_userptr_drop_ref() on the
> get_pages failure path, which properly decrements page_ref
> from 1 to 0, triggering the pvec cleanup. Make the page_ref--
> after the if block conditional on success, since drop_ref
> already handles the refcount on failure.
Huh, so there was no cleanup on failure of
____i915_gem_object_get_pages, but the page_ref still got
decremented. I think the changes below should be enough to
resolve that issue, but we still need to run this through CI.

> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 043095f93ac6..7d2750528485 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -292,9 +292,12 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
>  		obj->userptr.notifier_seq = notifier_seq;
>  		pvec = NULL;
>  		ret = ____i915_gem_object_get_pages(obj);
> +		if (ret)
> +			i915_gem_object_userptr_drop_ref(obj);
>  	}
>  
> -	obj->userptr.page_ref--;
> +	if (!ret)
> +		obj->userptr.page_ref--;
>  
>  out_unlock:
>  	i915_gem_object_unlock(obj);
> -- 
> 2.20.1
> 

-- 
Best Regards,
Krzysztof
