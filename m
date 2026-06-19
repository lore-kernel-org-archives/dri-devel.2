Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605D6CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B162310F4F7;
	Fri, 19 Jun 2026 10:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cMOeuO5I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39910F4F7
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781863784; x=1813399784;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=lNlJSx8tVuI8uh8USFwacl/iB39VB2+kLj98yDB7oIo=;
 b=cMOeuO5IA5K4h5YwQCpzgCjEHIf5MHcuwoGlkZAQbpJN9xb52/bD0d8+
 DbeRcevODMIiP8CYPxy479Ojpji4+wEweVzZej2kHJUoXQKxEKKz2xzsm
 YWS7TvMw9n3ddGd4XjMg6s/l5LJTAgnoKg6yomifABLm/OFtv9LXlH7C/
 JuLjzUCIKoxBGK4hPvteWCGrW/Xg2ug3c1JM5B4ZvMW3R7gfH3H61Me6u
 2YemorkrSym8krLLRjQVV1IwB9/8Q3B34DV+6slVZpHnzzhK7j/IKnCP3
 hdonKEeiBt2+35yYMC/TUfJApxhQm9Kr3XfKRg53aWChhRQPqLaMwxPiv Q==;
X-CSE-ConnectionGUID: 1ta6uvQOQCmz92JfcCYJug==
X-CSE-MsgGUID: R+u8p5s1TW62/EFSnxsugg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82805948"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="82805948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 03:09:43 -0700
X-CSE-ConnectionGUID: XZMStZWPQb+jHYVxgphX1w==
X-CSE-MsgGUID: MM1wO2VzQGCRJrtgGpKPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="248669221"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 03:09:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 03:09:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 03:09:42 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 03:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3ySNffejuz2VfbJda4Ts7zUH0bp9LeEV2IQY1kPHL0lFRNpJZcMgE/FDJVIyz1jPt1EhIzNIi8SvVHv2JpVad+xGt2hsm504rKfMcoqeUOIQpxsZv6PnPtQXVflgklQvfEQ0A4ok+54V+4fox6wyI7nBLlyWx4t4sv3bBwS35Iv3g/b8TbWljOSR8Qfna/uiQKdluMjBMqQO3WOg2tlZsxFmJZO9xcec4M+A4MDRql2pIdZXhn9YLToJ3EaytYVWDNvLJzkPL95aKbEKiUBSrohJkr8nUMDxV+fp6Mp/juDjr0fkWJtiMKYqXEZvRQpGAt8PpeE5c8XAUcBrFmk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNlJSx8tVuI8uh8USFwacl/iB39VB2+kLj98yDB7oIo=;
 b=LwirMLX7AV4qUksRYP3xqJSaUieYEGeTovax/4OTZIuf42P9nVf7bfSa5T22HmQPK4OPUHKX9maEOSDwMeYAF6fA+opWRgRoo4u5PlBN2qByRO9xX7/R5v0F4rBFSHDo4JhZOpqqBX3Ys/JFymysRPUScZAoW+vMatLt3+tHqMGesszOKamuvkRYWFzGcWfjsIhn1vJWZmTwTdfJQcyaQNl1Daf4S+NDPWSA19UW/tn7MsW9wKMse8n7eAZbjP3LAIEfvr81tNn3AcPAa6J8rGE//+r6WVGfzTeps+5JlZARKtzKyYLcfgylNDhTnTjJD3BDzX4h1Uubp+6wgHlE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4SPRMB0067.namprd11.prod.outlook.com (2603:10b6:303:221::22)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Fri, 19 Jun 2026 10:09:35 +0000
Received: from MW4SPRMB0067.namprd11.prod.outlook.com
 ([fe80::3605:4f97:fbe7:2c4a]) by MW4SPRMB0067.namprd11.prod.outlook.com
 ([fe80::3605:4f97:fbe7:2c4a%3]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 10:09:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Jun 2026 12:09:58 +0200
Message-ID: <DJCY007UJ52C.3G2MFQ6DMZ5VB@intel.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 1/2] gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-2-krzysztof.niemiec@intel.com>
In-Reply-To: <20260618152331.36763-2-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DU7P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::31) To MW4SPRMB0067.namprd11.prod.outlook.com
 (2603:10b6:303:221::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4SPRMB0067:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6a7986-c49c-47cb-08f6-08decdeadd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z5tuFDcAK714Pgu4EgVho52XB6AAgYppQim8CjbCqlz8RcvdxknRH+RpdbTp4Fz7kKAFx+3iT/gjcgClc5M4puTgfuwe1lQ0JqHrgAESGYILGnjb84Oe8dgKegHySu55mH9rFzMGJuShWrVesCcJxJPjfSFMWi6xOgCVPGkc2kD9PTR1zS35hmFDx7Ku53YE2pgpJwOC1Ev/1GpkhFojxClsN0mzOJSe5lXR9jpg8sGORn7PKDSkfdNYaiZWmvHcWj/YLJD8PeCd4cjwl/ygM+/kzSdviEIK6CT6TvuS3PLgQORGiLKPyRmAUqaBeny++Kaj+lzpRACFjisM6Lm8wUudMFXfW5m6yo7V6mkbDf5BaHO2R+zxt5w960B56vITTRIMwFPNaTVNPw6dTSfXyVAgn9HzcqmjFSbbniOSIvelYcYuRLyLx2CZuALClm9oqXSL6mon85olY2tZqjOMZpNvK+DpNzTTMOvNrOIEZ6YAnltlNES9WsOzcNMQlqtIkKdP0AoTAT8dMgAfk2Bv0EycoTrpMhf0maDkoLv1XtOJYWrdWFXmCa71a8xU/hbbtL9otJFX7x4PGcf+qdN06H/+EGGGm1Q35BbEeV58w8JZszigoid938upITYl+kgStlsDhjF8DnaT+GZfQO+HtfwpmDgdHKZCnRAeqn7DMZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0067.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRKbG9HUWFYSHNMR05MTXMzczViU3NFc3o4R1krb0Q5Z1JtM1FMblhPWU03?=
 =?utf-8?B?bjZZMkpiYTdMWEsvbjhxd1lYNEFkT1JiV25zcTZHSzI1SFpOaVY2WVZ0Nith?=
 =?utf-8?B?N0dIRVFXZ3RmRExuNXI4VkxzbGtZT1lEWTB0ZW1zWUp4YzhxNlFFb0RaN3hj?=
 =?utf-8?B?WWwwYldlL3NZTjhyaHA0Z0RWNmY2d1hlaTNVR3B3QVhIYU5IYUQ1ZEZBRWpE?=
 =?utf-8?B?WllFN3RCYzJ1S2RHYzhNVEY2RVZPYXpjdlZ4REJMTWpmMGplTmZMNFI3ajQ4?=
 =?utf-8?B?eEQ2eHByZmtoNm85YmRrYUJpUzY2NEx5ZlJqWTBGK3JQTVRzeSt1NE9yTng3?=
 =?utf-8?B?VDZIQlhNVnpUR293SFFBa1B2Unh3R2lodnczUGVYZnB1ZlQwc2VkUnMxYmJV?=
 =?utf-8?B?bWw4ZWVDa0RjN280VzBFUXV5VGx1cFBucTlqUkNpTjZ2Q0hlTUdaSzBrUDNU?=
 =?utf-8?B?T2lDWTJlaXYvY2ZrTkpHNUpLTlh4dmNRQzVwK2VQZkU4clJSQWJkbytmYXR4?=
 =?utf-8?B?cDdGSXB2bWp0R2YxUXUyTEdJbkN1ZmVMdjQvZzZKaWdHTnJDWUYvU01PMXdN?=
 =?utf-8?B?Z1c0TllMbkljZ1RLN2p5ZTMzUE52aDJ0RzlOKy9ub09wWXRPck9xK0xoMmpN?=
 =?utf-8?B?bnFyMlpRL3ZnQ3RVZFl5MnEzZ0VwK29CUWVocWs2QTJVOE9vQzBPT0hhTzdu?=
 =?utf-8?B?ajVRMFFRL2l2Qm0vZVFEQWdmUEdGdFgyMmI4bWZVd0IxU3dSYmlsTEZEckJO?=
 =?utf-8?B?aVA3TjJXY012Y3ZhdWdWMFF2U1ZMOE1MTEtMQ1ZWWTRmUEhxUVVUSlBJQkpR?=
 =?utf-8?B?RUNCY0pmK3RRT1NDVW40Umxveng1eFBiOS9XckJ4eXBVN0g2Q09TUjdHTk5R?=
 =?utf-8?B?YXZ1dFdmbm5jczkyU0RYYkR4THk5L0VPL0IvMjBuS3ErZ0tRQjI4ZXpYV1Yv?=
 =?utf-8?B?WWVBT3RRR0ZvRWlycFVrWVlLRzVCcDdDcEkyZ2d1dklETC9tdWVlL25HR2Vr?=
 =?utf-8?B?Vnh6NlFUTk9NRGdsZ1MxaGNHQVdpc2dqaFRrWFI0N3gwQ3ZkQzhLY0lyUWtu?=
 =?utf-8?B?cHV1Y0lCVDRXbGRyUm5DL3M2YS9rU2hlK2UvQjFyZ2RyZ2ZUTnRoL1R5S1I0?=
 =?utf-8?B?VHZXcDZrOFlCVVRPU3FsRElkaGJsRDZUbWdpeGtDMmt6Y2pzL1FhVWcyQlBV?=
 =?utf-8?B?cFRHZWZsNlY1ZExOU1F2Tk5LQnpyeFhoWllzOXZnSGovajdyTG1vRDI3N0w3?=
 =?utf-8?B?c1hwdjcrd2VyYmZVSmtHUkVPU0xhcUZZTUY4eCtjUTAxNVR2R1BsM2lhazNC?=
 =?utf-8?B?R3grUVVzeXltNm9JVHlmWUZSMWpJZVFNM2RiMXIzaEY5Wm1lMjlqQmR5RC9F?=
 =?utf-8?B?Tm9mdGcrWW1TT01Id0J6elNoUUlnTk1kaytGWERwSEs5WnlzTTdwRExJam9F?=
 =?utf-8?B?VktiYTAxMUpwQlRJeXc5UlBLOGg2OGhta1lOLzFJeWljVXFkMW5hMmszb1Iy?=
 =?utf-8?B?aTVSaHRtT0xCcklEWDM1b3JYSmtMY2F3YTZkWVhna1pqemQ0RDVQSlk2SDVt?=
 =?utf-8?B?STQ2S293SW1UV2V3WHpzelJaeHMrT1RXalZoNVI0Z0ZRNkh2QmIvalptZTJX?=
 =?utf-8?B?NzBMby9kbU95L3ZGZmRpNGMzeE9sOFRjNUhueTNFaU9VVFkxcDhwQjZNemVK?=
 =?utf-8?B?NFZEaGhaYklRZlBNSW1ESTQyQm1JbXdiWEVtL2xKYXZvRHduNVkzY1dwd3c4?=
 =?utf-8?B?RURuR0tqWlRwUHBBUEltY0gwZU9kbEhWczdDL21Xb0M1YnQzUHgzY1ovdlNU?=
 =?utf-8?B?eFlkWnhWNEVhU00yL3drYm5mQldNdzVjRWtoQytLNjFST3RSVUlYSkRIZHNu?=
 =?utf-8?B?NE9PcWNRZzhWcTc2WWlEeHI0aXJLY3FoOTZuQkFQS3hhL0F6V25rdmNBZzQw?=
 =?utf-8?B?cGZ4Q1RKT05OazA3b29JRmpIelZKWGR3ZUV4Nm1jeG9ac2hCR0dhUTM4V2x1?=
 =?utf-8?B?ZC9RZ1Q2cit5ckRSQlB4c3NRUmQwS1dYMHpKa2xNQnJGN21QL2NCajhhYWU3?=
 =?utf-8?B?VUlhSTBNZ3EvK2pNRnVhbmxYUW9zK2pxR3VzL0NLeENpQXltWGVZc1RnM2hq?=
 =?utf-8?B?b3plNENIVm9Nc2FhbzMzbC9sRW5yMW5NZDZjUHlyNEVSb2VXbnFvb0FxVGE0?=
 =?utf-8?B?ZkNIUFliSE03N0Y4M2FuQUQ0MnhaY1Q5YStxOWRtdTBqT2FiUGhrZk81M2tO?=
 =?utf-8?B?VThsQ1ozZzkvQmFaT0J5b0dxTnkrRDFwZWNHN3BIaHg0aThxclo2ZWpncE56?=
 =?utf-8?B?aTlCNGJ0c1d6MjJiM0FQU0VGN3M4MmdMeXZFUXJJQmdnNlRjMkpZSVdsY2hx?=
 =?utf-8?Q?JQHQZXvpApbfNc8E=3D?=
X-Exchange-RoutingPolicyChecked: mx1h4K33ppipV1+SPfWpaVq23U7LOnoG2mg+3reRmDAgMqnzFRwZuHJYVOkIHULbzm1Z3mCRWKKF5jLVQFTWlXetXGPBmB6658zQtoWr9iCavJpZ8oysBdY0b60EiqBm7twWez5BPrYbJ2CU79SlVfqOzSg9SqpUoCqwRnW6RmO93fAnzCt5zVrZG/q4jb1JmIjzLCZPXeSi0oXaJMYT/RE0EWjcHicu3I96OK4BQK1WfrbwoR3h7Ioxolp2M7w8QEfMMo+tncDykjsmBoLG8peFDtlb6Gp+djIBP/5oT+2CKolXAgDV/8L7fL4B/9EGk0O0IckqgPPJMCXhYFAG4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a7986-c49c-47cb-08f6-08decdeadd4c
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0067.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:09:35.2669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUwYMwlUfrul6zvPw5E7wPo6XA1I3Z9ICK8Dyi7hu1uhA/hCVDPYfqdlx66lfbWkTObAwtKsFPkcXzZQs5clUl3SaADGKDHfEi7s3zxiCJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
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

On Thu Jun 18, 2026 at 5:23 PM CEST, Krzysztof Niemiec wrote:
> CONFIG_GPU_BUDDY is currently not selectable by the user, mirroring
> how CONFIG_DRM_BUDDY does it - the idea is for a driver that makes use
> of it to include a "select GPU_BUDDY" line in its kconfig.
> CONFIG_DRM_BUDDY is also selected when building with
> CONFIG_DRM_KUNIT_TEST, as it can be thought of as building a mock
> "driver" running the tests, that makes use of the buddy functionality.
>
> CONFIG_GPU_BUDDY_KUNIT_TEST doesn't follow that logic, requiring
> GPU_BUDDY to be selected already instead of selecting it itself. This
> requires building the test kernel with another driver that uses
> DRM_BUDDY, as this is currently the only kconfig option that selects
> GPU_BUDDY. That shouldn't be required to run unit tests for a module
> now completely independent from DRM, let alone any specific driver.
>
> Fix the dependency declaration in CONFIG_GPU_BUDDY_KUNIT_TEST to make it
> work as intended, mirroring the setup in CONFIG_DRM_KUNIT_TEST.
>
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

