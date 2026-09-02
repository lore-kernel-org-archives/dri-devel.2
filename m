Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806E3C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB6610E395;
	Wed,  2 Sep 2026 10:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XzCnpXaO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A78C10E395;
 Wed,  2 Sep 2026 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788345692; x=1819881692;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ayCm+rRXA44/f6Ng8Mc6eMXHj/tFSXn20sOBOnXzBYY=;
 b=XzCnpXaOBa9/u9i1jFe/RTrP3jvXXo453pr/krdm6jgjRcvdhUDKacI0
 tYXZlFZyWpGsde5j+JQLpAjoTUxM8IEMbwv8euxfHKmFJGpasj2dmy06Q
 Qaklu42rvWGtC4FZzuj4tXYWpunenOxpSPZy6jQag3cOc/dhqVYmCYshb
 QSYYQP3Q7+5soaSI8pyA3C1KNnEghPqdC85EU3n7RmM7FUGrjY3jDDDrD
 rreNV0ORKp3s+1rVHs1EN2/vH46wSELm15OI+62czqzu8tGtoQyrly9fJ
 RRuCTs7kKE9hXoMMNyl32OBWxpz9oHF8bi2YCypAYWYQmuTeGBEiC1enJ w==;
X-CSE-ConnectionGUID: OGcQboUxSkSyM7daxXPxQQ==
X-CSE-MsgGUID: b/mKdWc0SP62IrUgEKBnwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100154681"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="100154681"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:41:31 -0700
X-CSE-ConnectionGUID: bDvthPujR7S+CZ2PGf6gcw==
X-CSE-MsgGUID: fcKux4BFSxW2OAtt6ywJ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="267612533"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:41:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 03:41:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 03:41:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 03:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC+HoB4LAuUB0609UuXlZqWJ6IKSf7HWtasAajD9MyNXbNo3BKmz+hCuUWJAaAw50Hu+okGO0tkBF0LYI6VI2aKAmmlrE0+JtJ6FdwyF0z59+UvAjQsctslHJlKKl7SrXrjMkePx2SbkNiqygKOzS70aDfrFeNbQuTBpeN3Xf6j6HAWs9NKcRGPuShR/w2tXhD1PNaTda7eYcLIJhSTPhN9cmvIfk3dnv7wVr2Xrs63nt4R4lPtRo8DgxuA3PmrgWZpD3UQcBLC0pBdWQ09INNgy3Hd+3qTrMwVHtBvTgY8eMOsuWRaImC6E+Hp6oI2idybOo84yrH0bGS9pAB+FpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTysAYcsT8rPOPBIqcgE+KyTnPkw2CpyUl38yFjWzdo=;
 b=PPdBUosXZufVwQI1LF8uY+UK7YUsJ0L7CcGnJOl7KPuULWIGqURTy7i8s2gB+VcK6yxe198KsdvaZOEIzpblTyUTsDTtd9GIUlix6/pJuisAnFOgg9z6u0EovB+Aeh5kF8xbB/kfVovTJ32BLclb5b7ScFyQdvhFVecikmtmiVRpbMkV1+rH1pO4qUWX9JgS3HwgHGHTrZ12MZu5yKLbDEXsjVA6LETc88SxpXzsP/qkLcdnWN4D1dWmM82ycTT+2XzwW+V7jjbqejKrFaFAjIn+7qt5Zp7jS7roTrVrvbvdOasqlyuvmjhjHZHbFezV0xG+xF/2/FdvgDWVUE61Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by CY8PR11MB7900.namprd11.prod.outlook.com (2603:10b6:930:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:41:27 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 10:41:27 +0000
Date: Wed, 2 Sep 2026 12:41:20 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm: Unwind drm device registration upon error
Message-ID: <apf2bCiuKcmcRHUT@kniemiec-mobl1>
References: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
 <20260827143447.99553-2-krzysztof.niemiec@intel.com>
 <apC_eePJyeGnVQTG@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <apC_eePJyeGnVQTG@zenone.zhora.eu>
X-ClientProxiedBy: DUZPR01CA0308.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::19) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|CY8PR11MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e930f2c-c66f-43d2-6f9a-08df08debdf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CoEDcY+baO/bxaEKwXm6Zh9EHGtGKYKUPLoVsI5ni/mA02gdSUgCSIFiDUdQwaoE6d5KJTP72drOhl1+lH3h0Tg+BxIeN/CXTR6B2nC2ufEQ+ZQZi0A8zvR0kVIvgKvHIIbpNXb2p+JccKfS7A7Jk7dCqrnwzadW7O6jbClkqjXk6J2m8CDMdiyzbWduqIi1HZp+8Qe37hoYQ5uW3tAeSGbWXplse/376gY6/gXvFcoL4zXqdGr41jltX3ZgQBrbxp3Zmv3kYGx+cj5hKFxofQU9dUD7sKIhK/E2xG5mISKuT0bksyydLqs8j1B61nSRzNJe+77gc878S3hEB/0c9oKORzHySeg1QHXv3wwHziaCN6QQ37ecnuIJ17jj9PSbo+mZ1kNl/6fE0hoLi6vKKlN9HQaw2gQrW8y9TMzZiVQXCHimPC7zi9nD02EthY5n49DKOEAsNT12Xa9LPhP+e0vWZgCpm4tzMhzbZMfN90NiUhaLduvqN8XP9uNdSK7bxtFYNR0u+qjDqBQ+YYOKXuwEZEm+mie6GeXfkt1lcDMYycXD3XK7dIvlG5RbB8zVQsS7sTOw1TuTIfoZpZD204cjGsduULCyffbt+LuqWmAPhOLdjsyZYduOpf14QJXGNkbChMgA0WOF6A2EzBAUKntS3pu3c3KFmwFbRinQTlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snk3U2haTGdRcmdQZkNkUWZtbU1HYkFvT0phR202SkpLMGVjazNaZDBCcGo3?=
 =?utf-8?B?MG0wbDBiNGZYM2NmM2VUU2pDeEFaSncydkxiQ3RFR2VoQStsUTlNMzJEZ1M3?=
 =?utf-8?B?SXJjQXJDOFJ6VmJkend3Yk9oMkdBNGhQU0JMNkRnaTRsRFFlQ29pMVNMK0ky?=
 =?utf-8?B?VjZVb082b3RkcnJVTjFlTkhVa1lTcGR4TTRkaEg2ODlzWHc0UDdSSkxoTHdO?=
 =?utf-8?B?YjZWNEtnL1VVU25NVW1VZHNML0lLcUpoMzFKNjNiL2l4Zno2NXI1N0JoZHZI?=
 =?utf-8?B?NXl3WWV6Z2YyRE5ZNXNmL1pocG8rNmFaV1ZzNTJudnMzQmFtVHFtKzRXWFMz?=
 =?utf-8?B?TkwvREgrU0FiWXRiWnNWbkZrc29tUVRBMWNXbFE4anM2OHlRa3VkVjVhZ1N6?=
 =?utf-8?B?RWdHL0plemNxaHErU1JOQ0FyZTVjZVJxTUp5Q1RIVHl2Zm9iNm40emR0Ylgz?=
 =?utf-8?B?cjQwT0JURDVyYmEybTI3TGYwUmhnUHdienlRWllJNUYyTjdXbEZ5bUJhc0xv?=
 =?utf-8?B?NytRVkt4cGZjcnJUU3QyWUNLRnoyUWhzKzFFcnNBOVNQMDlnd0VVcXlwNkNh?=
 =?utf-8?B?YUVyV1ZuWStONklUY216cGdEUDlmdTllbTFMV0lObFNlUllZZ0ZVVFkrRUpZ?=
 =?utf-8?B?bHZEUUovV1BiQ0xSYmhoRlVqaDViUkZNdnl4bWVMZEVOdWUwa2t0c29MVFg1?=
 =?utf-8?B?N29UK2RqT3p2YXNzTlg5QXZsL0E3cTdzK0tsa0pSWEhDOFZxZHlTTVkzRVlt?=
 =?utf-8?B?N1oxbnQ4bW9sRGdJeVpTaFphWlo1bDBoclZnTVpMc1JxbEVlQThVb1pEcVIw?=
 =?utf-8?B?SDl5SGs0Slh6TFpEWHluK09kNndrWGovcEpDQldybVBIVXdqR0JCVzlJZTlB?=
 =?utf-8?B?YlI3VnVBOFpNbE5vYlFrUUdNb1JZV2JIRG5waXlKUU52MkJ4Q2lqbk1jS3Rw?=
 =?utf-8?B?NVd0N0pDYy9xRFdPS1pRWGk4b3N6RFVyYUFsNm5LRnphbTVNQmRRTkoyTmZG?=
 =?utf-8?B?YU9QTm1MakpGNWdBRUErUHVkWXVLUklWcUhOTHZCcVFsbFpNYXdUcnIrbVNr?=
 =?utf-8?B?MXo2a21PdUdjMndGcXBqT2tYTzZCNm5LWVlwbE1Sdm91TWxxTlZBOXJxaHFK?=
 =?utf-8?B?dUxuRktCTHNvK0lORDN2Z2dtS0NFMS9PWFRFWmFiN2txRFAwYzAySW5FVStT?=
 =?utf-8?B?QlY5Vm9nZ2JNSjNsMmhqSVJ1RFV1YTZSRHBzZkJRUzZGazNUaGRJdEd4aE1a?=
 =?utf-8?B?Lzg3Kzg5MGNJZ20yWTBPcERidnNoYUx0MUI0K1ZCLzR2RFQrTVQvSXhhVXhH?=
 =?utf-8?B?L05oV0NtcUFoL0NnQVg2NHVlengrYVpkTjQzZGdvNWhIL2h1R251NkVQaWIr?=
 =?utf-8?B?TnhKUTBuL3lsbG42WmNPWENyeUFJMm1YekxwV3RVZXFsYlR6RHM3MzhwdU5a?=
 =?utf-8?B?bXQ2QnJpL1pnbXVwczcwR3p0R2lEUnhmWW1vcEVEbkhENFRxNU5lMGk2MC84?=
 =?utf-8?B?YUhaSG96OEdtemFUNXpCRmJFNzRtZ0NPcW41Snk3RFQvMVRPWVNnd3NONnBF?=
 =?utf-8?B?RjZCMXVSRjRWZnRVaE9VWHJ4aGxpbVhyV3JaOGhrcXV3TUpId1AzdlphanF1?=
 =?utf-8?B?LzhPVFRrWnVaNG1sTTMxdlNJRStsVlVvM2dPRGtPNVhTSFBSZnNFMCtlL3V3?=
 =?utf-8?B?dWZGeUc0dU1NVnVSQ00vbU9CV2s1UTFncGxtL0gwWFN4STAvY3hydG1Vdi9Y?=
 =?utf-8?B?UnZBdTM1c0ZMbWhMalA5YmxvOXhzL0pDTkZHTjJMcVMyMVlzWXVyZGs4b3M1?=
 =?utf-8?B?TVVHRmQzTFg3RC91amVWQTlqZUVXQ012cExjcG0wYVlMRnFTNjRvZkhuRkJ2?=
 =?utf-8?B?OVdaZWYvQkM1QkRHK2JRVjUxTXVuNm90dURzdlNnNlNaZlFRKzJWSHBaV0VP?=
 =?utf-8?B?bFNhZ1pMZEsrZXUvNlRCUUxnS2tQS3J2TkVGbzhjMTBxR3hDSUZsenc5b2gr?=
 =?utf-8?B?bDBFeHRManNxeUthYVhJUmZyOGdXc1JlYTJVU0pHUHd5Y1gyRUY3YjZ3Y2Vn?=
 =?utf-8?B?Sm1ZbUFSbFdzL3VzZW9IOGdlczJGTzUxb0FBeVBhekN6MXBxSHBaWi9NODlp?=
 =?utf-8?B?UUJVMVpWNmtpbldBSVNjT1dOK0VkS1VQZWI0bU9BM0ZxM0ZWemFIYjMyQ2tH?=
 =?utf-8?B?eE5MU1g4QVVkU3VIY2NCMEVNUm1oVzNhcVlVTUUvMUowZ1h0YUxXbjI4VERm?=
 =?utf-8?B?WEZHbjlLS3B4YUhodDhtb3ptTkZpdmxMMVVDODRUOHlaZlFaVjAxTTdtRmI4?=
 =?utf-8?B?UmN1Uzh3engvekw3Sk4zTEJWTXQ5cm85TDZ5NlZTYkVFRzhuVUticVA1eU9x?=
 =?utf-8?Q?WRpuy8qpK0s+uimY=3D?=
X-Exchange-RoutingPolicyChecked: g82z2itplcpzmeNxLhB09IClC2azVN5w1RdwQDiD5A9ppNwJme8YCq19EEplYmBBbzkznouOu8wdaWUgKAVgGUmhJtvOLBlz7Uay7oEwiDyFxE26C3gbdS1Rp9bMHB4OIL6C3qFRFo79/zqiPQLnNGEl0vItgDnEMLkI9UMOUFusf9C2L6k0XoxFfUHsra7WNLdIhiFrUotzDuAR6juFvIhecG7NsYHgZN6I5Y92SDw1wwSCV+CV7Yr+ODcCqCCHT8pE2hRzh9D4VRNFV3y98dCNw7C5oCMmGGIhCdha9dhVC9qwKtJxIV2scHPRn7H9/9/SCTqXFe3+x2hQxpMe2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e930f2c-c66f-43d2-6f9a-08df08debdf8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:41:27.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGpgjqrpAEdZW/hlEpJNyvWfC9ghrvpfYEiFUAqO6wnFRxlSbPC217LBQ+YjPdgBopuCkP9am385I5Xgt7ZqacCx7DM4tFlpEF5OFGHVIv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7900
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

On 2026-08-28 at 01:14:57 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> ...
> 
> > Amend the problem by removing debugfs entries and marking
> > registered flag as false upon error in drm_dev_register().
> > 
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > Co-developed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> > Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> 
> I think the right order should be:
> 
> Co-developed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> 
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index e51ed959da89..b98e8af6f1c1 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -1140,6 +1140,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
> >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
> >  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
> > +	drm_debugfs_dev_fini(dev);
> 
> I think sashiko is right here, this should be removed.
> 
> > +	dev->registered = false;
> 
> dev->registered = false should be set at the very beginning,
> maybe something like this:

Why? Is .unload() supposed to expect dev->registered = false? I've seen
that moving the flag around might(?) make a bit of a mess (e0f32f78e51b),
and before this patch .unload() is being called with registered = true.
So changing it at the beginning of the unwind might mess up drivers that
rely on it, but it will make no difference for drivers that don't, so
I'd rather keep it this way. Unless we make explicit guarantees that
.unload() will be called with ->registered = false, in the middle of the
call to drm_dev_register().

> 
> err_unload:
> 	dev->registered = false;
> 	if (dev->driver->unload)
> 		dev->driver->unload(dev);
> 	goto err_cleanup;
> err_minors:
> 	dev->registered = false;
> err_clenup:
> 	...
> 
> Thanks,
> Andi
