Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB99E1073C9E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 11:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322ED10E615;
	Wed,  8 Apr 2026 11:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N3/hjyt7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEE410E613;
 Wed,  8 Apr 2026 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775647895; x=1807183895;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=xL/AL+Kj/umos6d3t4nrmrqVVW02CrvQyMFF494tSGw=;
 b=N3/hjyt78ud493XxgfnZ+Soaq8IAFesCUnU79W/02lYQOAAk60I4J61i
 Ra6ElRNd1kFuiIwIOKoV4FfDs722/ZUTF24xZapzh4f1c7OWHVhcXk/LY
 F+3xWsMUmnUa2OrMT87TEtX0zUJjAi2SmYE3q6flV1kNJmnKH6iAR9f+j
 yxJ3U3/6odf0mNm1Ooo4WChrgj8N4/iqqeXW74ic/MEcsPp4tPt6SpI2w
 7kQqBVJEHM+QB0ZNeOYJNEnl/tpZADLRZPYn3xHq7pf3w8Bi2RPU/pQXT
 MgqRRDZgdWyYOZyWlazTYP1GZOcL/c/rIZWpYU56jUHwkn6L6s++tolku w==;
X-CSE-ConnectionGUID: tt3tGGBlR9ySYRyKR8iipQ==
X-CSE-MsgGUID: QeVtpK6DQziMOudOUJ8nrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99254066"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="99254066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 04:31:34 -0700
X-CSE-ConnectionGUID: 9HyUHBawS52QWVKuh34NXA==
X-CSE-MsgGUID: byw+BLBmTnWJtAdmdalcMQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 04:31:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 04:31:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 04:31:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 04:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRqn308jGHsK/UkyecM++BLuKYYcxfeWETfLW1gQqj6MlHfGJewTofWIkVhsfwPZFoja4iXz5w6Eve/l18QLFQRxZEG02jEqAcRJDHECbu8bV7p8P2yTUBcShd5VdtkxdfS83K4geO7V30trYn5SvL6VjZB+omHhyDypsOmEBkoqPP7gZdFT4BezZzMFhOUDZMCt0WKIeA6GQcSzwDvTMcrJi93+0uekJMvHD33ArdbzHyAylqVR9jj5WqHjsfPRBjwzYdh3cpUVi0zHVZvZ9gNFwweZPe6Q8jCmj7Mia7UkM5os/xzXEGYbvh/3WvpCXrJ2CdV9CK8lWB5i3EJQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpVfX04yuPdulUwnggDH4QagI72au313QtolHpqZaAY=;
 b=UBTT8hAejQj2aMSkYyEPBsfwhv0hpkAKXWrjeu+UybpICP9mjRNP0VIZH3u+bN+pEsQCmFhYf6uL4CagY9p1bnL9PuFraSl80ZIMdzMq/4E65UVEJiG17P2vh3rCOjQtciyKGU6crMkMHQCSxBnGZbW8fBIrqhNEDa0OqvxNcEhseLr0wWuUG1VfBEGGxaY2OoB0rDaW3rC+kM8SWO9oUT1SESrITbQykt86MJo+mj6Qk4ldBiysZztm6xOC6+NvWcIotvj+37RwKHkSQQIGE0TigPOfmyVY08P7sSYoJ7RVaTNGwIFmR1vLSwHVcxkXZAxO48BiXjdRUsiLt5vb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 11:31:22 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 11:31:21 +0000
Message-ID: <4dbec9ba-7d31-49d5-a4ee-bbb618dcb475@intel.com>
Date: Wed, 8 Apr 2026 17:01:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] drm/colorop: Add DRM_COLOROP_CSC_FF
Content-Language: en-GB
To: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-2-harry.wentland@amd.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260330153451.99472-2-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::15) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: c11b9feb-53a5-4081-b9af-08de95625bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: oIyq3IQv/lHHW5fa/Xuo7DcBUZxYUiLrU9Yt/vS9NvWUmjgA7YfJY3il4ARKig0xngig8QcZ++jjPJnRooGRPsEsOuF4uuHO//xv88eSTxLPb5s24WawrYWMVWagIWQ7cTgSUjEDhGF5gdssUd+mavUeiSmfqiAHwZSHvqts61qchqZH/k5kcDWZNrEPVHbgS9Dj3lkZvnun0scXIXje0cZBt4iMkqZqxfFcAd6DY/KMnx4aSan8sY23l04Om/ETZglVUo0tx+UtDzNCpdNYu0LtrxjmfmDlwdr6bRcqM9mf+pWD5ChvmLJsafDEK0OJ9Z6a2I9l7zwyTxP+sYvJsbIIjjDsXICSh7J+Sp9tgVksXstIMzP9HP5qoRlLP1Y8V+U4kV69WEEIUcFn5vpizTGR9hAwIElEaC1Nq52yUTf//YnsrdZSS5kK179WuImDu31evEi2lpUhCVuA07FtI35sMx112ki5nCIomGaVFMyN50aOgPachXNK/IzIyUe5/2nGGUVZ5wwtAr1EuikdD/G1nwXDMonHfCL9haHDANtSJVlxQ57Zzk+F9fC7p3h0yAojr2aA38b47ldgQEpmxjWipmd3pOHSOFRuO2/Ukqf7blhitE72Ob2xByUjK90KGB88bZ31Egis1NAjM9HS0qG5dgGag/vsFyOZl4zOlY+jsDbSkzzSqI3o1howX7xM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9DMTJUbjNvUG1SMkR5MTBaRW5HT2xIbjBJQjJ6ZTMrSkRlVGRYYmlLcFRN?=
 =?utf-8?B?L1A0ajJVeHd0akhNTzNsVW4xVkZSREtodTNkUURtRFZaY2hSdkxzeVl1RlFt?=
 =?utf-8?B?QUNmei9BcDFJSFNxaFg3ZjlSWHkrTUt1bGw3NkdXdTlFMUg4ZW5taDB3NStv?=
 =?utf-8?B?elBSR3VjQ2FxRGY2OTQzR0xlV0tvNm91NUl0VFhkajE0Yy8rY2pJNnFqT3ly?=
 =?utf-8?B?aEdENlB1WWZVY1k5czkyYUlLSEw5dXdxZ1pQTW5nTHZJalhVMldpTGorVm5j?=
 =?utf-8?B?R0dXR3FWcXJBeFA2ZEFPM2dRKzhIZHdZYWZ4d0xCeFJBQ1lBNkdqQlg2WmR6?=
 =?utf-8?B?MW5KVlZ5WklFV21abjV5bG1xNXdIV0JJYkZ6VHZPQkhsVVBIL3VlQjllZzd1?=
 =?utf-8?B?OW5MNUVLMnUrU1ZhUzZxS2ZFeGhGV3BacTlTWGdnWEc4QnZDK1NiVkg3Q2hI?=
 =?utf-8?B?aEZGbnRuY2lLTmNDRFZZaGdXVWxWdllJWWhpTDR6UkJLY2Fma0Qwc0UzODVI?=
 =?utf-8?B?VjFISEJhY0YrMG04TFJ1QnlOV3RSVmoxaHJKOFRMSlVheWdVWjU3S0M3Ymww?=
 =?utf-8?B?aEhSVzJqdEo1VUQ1OERiclZlZWRmTmZuYmpNS1FldnhpZ1VWUGVSWVJvc243?=
 =?utf-8?B?Y3RubmYrcTRYT2VDNHNWeFdzYWEzYUhBY2V0LzBDSU1LU1FSNnMwMjlXTmhq?=
 =?utf-8?B?K0pEK1pDT0dLOTlPNjRENmVueVFnWVFLVEtSdENkeFhDM0c5U0NiTWh2Slhy?=
 =?utf-8?B?S2pVdjN3OWdTckI5SzhsS0RIa1czRkI4OFdJUm9kTDgxdlIzMUZ5WDFZTUwx?=
 =?utf-8?B?ZkFmU09qRW5tdUdzdzVrVm9YVXRJY0ZSbUFnUTk1RGNjOFlRQVY0TXJQWXRs?=
 =?utf-8?B?QlVVVHdVazhUb2xMU0MrdW5YME9XQnY0L2RoSzlHVUF6dkl4b29nbDBUZmxq?=
 =?utf-8?B?WkRYMGxFUnFpblJoaS81YXJpRC84TndQZWFpczRuSmNmYlN4a0tLT0hLdFE5?=
 =?utf-8?B?djhTSXVBaXNxV0xqU0xkY2RwWjluNlZTM1ptOHNEK0lBUFFWUEZjZnJJN2pM?=
 =?utf-8?B?K1F1ZmRvOWd6N3BoYXlBeWJPWEROTGprQ2JGLzJtNzRXSWk2bFNNellzWXRl?=
 =?utf-8?B?TDQ1WmpsNmZiQzlYUUVlc0gxSnRCekV0bHN4WmFEUXlQQ2NjWGNwUDk2UFlz?=
 =?utf-8?B?VTAxU1ZKd3UrbmF6R0RwYXZiR0FmbUMrTC9JVTR2VjBmeXpnbnl5cFJzaTZW?=
 =?utf-8?B?V3o2b0Q4RFpFZHlwRnozZTcwYWNkUytySis2bWZtTWFxbnBINXd4R1BleXRk?=
 =?utf-8?B?dW9TekV1UVFuODlKa2dkcWQrL3FVT2dGL2V2WGFBQTRqUlVCNFNSTjVnN0U4?=
 =?utf-8?B?VDR3MTRZSnRCOUNrVUxRVm1KTVlPM2ZETkJMVFBKdUtlTE9wYmJIc1hWMFRu?=
 =?utf-8?B?NnpqMWlCemM0SGt3SURRQXlXRWdpUFVJY2hUOElPQ1hieHFrbkRiazdzVFgr?=
 =?utf-8?B?SXh1Yzh5ektINTFjZE5pMWtkZHAvdVFkMzk5VE9sQ3RocC9jSUxDNStnajlO?=
 =?utf-8?B?UnZDcTYvem1qNHBpRXF6bFMxYzFWRnVMKzkzRWV4UXl4MHk5NGFSNzgyUXJD?=
 =?utf-8?B?T3JlSkt1M0Jra2ZmZ0syckw2QkRLeFgyeUM1am5JdExyNDhlSHZUaUpqYVpV?=
 =?utf-8?B?dXhva24wQ3hUQWdURTRzMVpvRUN1WWgrSFB1b3JBQVlwN2dEaTAvUkp4SklM?=
 =?utf-8?B?YmZjRU5HRm1WdVVYQ1VyUUFFT2swZnlGMEx4UGRzc2xlSEF6UFNOVG1Yd21h?=
 =?utf-8?B?OGZkczRaSnI3RGJFVmxqTjRvMjBnTEZnTXNFeTczdkZrTmdaaS9tbGVMV0ZK?=
 =?utf-8?B?b25zTEVtdFNvMGtkS3NIdUdxNDhiSTlPYVVKUWRUTU1ZYms1YnBwMlVpMnl2?=
 =?utf-8?B?WkowNUIzTnB5OTFhVlluY0lIOHFPczRoV3dzZnFMc3NBVUNKY1NWT1ZaNnlK?=
 =?utf-8?B?TDYvVjk4ektvNlhzSU03WUlPMitmdUdRbGFyYzFmV1ZqMW1EKzdRMlMwQkZV?=
 =?utf-8?B?dGJwQUJRTXpydVJMSHlQVTA4bVExUG5ZWHNIUG95dDY3ajBJb3kyTkRjNDNp?=
 =?utf-8?B?eGdqelpRVXo5N2pOd1gzRk02Ly9sN1dQQlVMY2pKaGVBR2NRM2NrRlE4NCt2?=
 =?utf-8?B?U24zUnl6eC9RWUJUSEgzQ0VIb2ZlMXA5QjR2YmFoU3o3NmZkN1JIT3M4UjBk?=
 =?utf-8?B?ZWpQUTNzcm1GdkJuaXRGNnY5Skp6cFRJZGxneDN3ZTZ3ZUhKbTVjSXZ2Z3B6?=
 =?utf-8?B?K05vd3E0ekszOWQ2ZzFrQWYxQmdObUJ1RWdZTS9RR0x1OVlaL29yWmtjYk9X?=
 =?utf-8?Q?VEpq1BK5wujfqQ9b0PEZLIU9UiJfnOgRs4BNl?=
X-Exchange-RoutingPolicyChecked: R9m0VnGHJ5k1bla5roYCDPJ8lwQxTsoLZGoiB0M3Uxf9Z0Ve6+kau5B5jASti5i5me+WQ5JNU3Fk6MDFLX5F4UvdsoaH43XSMgiyDY8YBbTTqoo5Ne3+bNkpcxRqB3iOCAPozPxsrQ0ham0C2pySPnwfv6qk/pokhP5PTCeFX+sLrck2j+aEjMfJJxtNYvk8fPQcWadQOKxvjhSKZ2qvl74nKuqRj/MnALcQxucioGpbBPKbuFv+1+QkwWQXZWYQBZD3Qm9YFL12kymmdg2FRIN+ZtDe3in7mBQeNQar+vsoLmms7tcyuiwji07zWz6t9igAxz9m1H8ygSsywRH4+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c11b9feb-53a5-4081-b9af-08de95625bfd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:31:21.8723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP6ZfFV/u5nMyFv+hZyVF6FbIogEmBohWwXOHxbzirNMxYOcpC9Qh/Us1RKh6y7ha+UNvUb3mfnASa/zOqaXmsto/cBvQ7h0mWohfQPJgmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
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

Hello Harry,

On 3/30/2026 9:04 PM, Harry Wentland wrote:
> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> 
> Introduce DRM_COLOROP_CSC_FF, a new colorop type representing a
> fixed-function Color Space Conversion (CSC) block.
> 
> Unlike CTM-based colorops, this block does not expose programmable
> coefficients. Instead, userspace selects one of the predefined
> hardware modes via a new CSC_FF_TYPE enum property. Supported modes
> include common YUV->RGB and RGB709->RGB2020 conversions.
> 

Thank you for incorporating this into your series. I believe this 
approach should work for both Intel and AMD hardware. I've posted a 
v2[1] of the patch addressing Pekka's comments. Please let me know if it 
looks good.

==
Chaitanya

[1] https://patchwork.freedesktop.org/patch/716856/?series=162787&rev=2

> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> ---
>   drivers/gpu/drm/drm_atomic.c      |   4 ++
>   drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
>   drivers/gpu/drm/drm_colorop.c     | 105 ++++++++++++++++++++++++++++++
>   include/drm/drm_colorop.h         |  72 ++++++++++++++++++++
>   include/uapi/drm/drm_mode.h       |  13 ++++
>   5 files changed, 198 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 41c57063f3b4..5bff85576e6b 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -845,6 +845,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   			   drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
>   		drm_printf(p, "\tdata blob id=%d\n", state->data ? state->data->base.id : 0);
>   		break;
> +	case DRM_COLOROP_CSC_FF:
> +		drm_printf(p, "\tcsc_ff_type=%s\n",
> +			   drm_get_colorop_csc_ff_type_name(state->csc_ff_type));
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 5bd5bf6661df..39b0dd1ec348 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   	} else if (property == colorop->data_property) {
>   		return drm_atomic_color_set_data_property(colorop, state,
>   							  property, val);
> +	} else if (property == colorop->csc_ff_type_property) {
> +		state->csc_ff_type = val;
>   	} else {
>   		drm_dbg_atomic(colorop->dev,
>   			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
>   		*val = colorop->lut3d_interpolation;
>   	else if (property == colorop->data_property)
>   		*val = (state->data) ? state->data->base.id : 0;
> +	else if (property == colorop->csc_ff_type_property)
> +		*val = state->csc_ff_type;
>   	else
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 566816e3c6f0..6a345e2e8b15 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
>   	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>   	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>   	{ DRM_COLOROP_3D_LUT, "3D LUT"},
> +	{ DRM_COLOROP_CSC_FF, "CSC Fixed-Function"},
>   };
>   
>   static const char * const colorop_curve_1d_type_names[] = {
> @@ -90,6 +91,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>   	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>   };
>   
> +static const char * const colorop_csc_ff_type_names[] = {
> +	[DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
> +	[DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
> +	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
> +	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
> +};
> +
>   /* Init Helpers */
>   
>   static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
> @@ -455,6 +463,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>   }
>   EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
>   
> +/**
> + * drm_plane_colorop_csc_ff_init - Initialize a DRM_COLOROP_CSC_FF
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @funcs: control functions for the new colorop
> + * @supported_csc_ff: A bitfield of supported drm_plane_colorop_csc_ff_type enum values,
> + *                    created using BIT(csc_ff_type) and combined with the OR '|'
> + *                    operator.
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int drm_plane_colorop_csc_ff_init(struct drm_device *dev, struct drm_colorop *colorop,
> +				  struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
> +				  u64 supported_csc_ff, uint32_t flags)
> +{
> +	struct drm_prop_enum_list enum_list[DRM_COLOROP_CSC_FF_COUNT];
> +	int i, len;
> +
> +	struct drm_property *prop;
> +	int ret;
> +
> +	if (!supported_csc_ff) {
> +		drm_err(dev,
> +			"No supported CSC op for new CSC FF colorop on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((supported_csc_ff & -BIT(DRM_COLOROP_CSC_FF_COUNT)) != 0) {
> +		drm_err(dev, "Unknown CSC provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_CSC_FF, flags);
> +	if (ret)
> +		return ret;
> +
> +	len = 0;
> +	for (i = 0; i < DRM_COLOROP_CSC_FF_COUNT; i++) {
> +		if ((supported_csc_ff & BIT(i)) == 0)
> +			continue;
> +
> +		enum_list[len].type = i;
> +		enum_list[len].name = colorop_csc_ff_type_names[i];
> +		len++;
> +	}
> +
> +	if (WARN_ON(len <= 0))
> +		return -EINVAL;
> +
> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "CSC_FF_TYPE",
> +					enum_list, len);
> +
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	colorop->csc_ff_type_property = prop;
> +	/*
> +	 * Default to the first supported CSC mode as provided by the driver.
> +	 * Intuitively this should be something that keeps the colorop in pixel bypass
> +	 * mode but that is already handled via the standard colorop bypass
> +	 * property.
> +	 */
> +	drm_object_attach_property(&colorop->base, colorop->csc_ff_type_property,
> +				   enum_list[0].type);
> +	drm_colorop_reset(colorop);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_colorop_csc_ff_init);
> +
>   static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
>   							struct drm_colorop_state *state)
>   {
> @@ -521,6 +603,13 @@ static void __drm_colorop_state_reset(struct drm_colorop_state *colorop_state,
>   						      &val);
>   		colorop_state->curve_1d_type = val;
>   	}
> +
> +	if (colorop->csc_ff_type_property) {
> +		drm_object_property_get_default_value(&colorop->base,
> +						      colorop->csc_ff_type_property,
> +						      &val);
> +		colorop_state->csc_ff_type = val;
> +	}
>   }
>   
>   /**
> @@ -561,6 +650,7 @@ static const char * const colorop_type_name[] = {
>   	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
>   	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
>   	[DRM_COLOROP_3D_LUT] = "3D LUT",
> +	[DRM_COLOROP_CSC_FF] = "CSC Fixed-Function",
>   };
>   
>   static const char * const colorop_lu3d_interpolation_name[] = {
> @@ -617,6 +707,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
>   	return colorop_lu3d_interpolation_name[type];
>   }
>   
> +/**
> + * drm_get_colorop_csc_ff_type_name: return a string for interpolation type
> + * @type: csc ff type to compute name of
> + *
> + * In contrast to the other drm_get_*_name functions this one here returns a
> + * const pointer and hence is threadsafe.
> + */
> +const char *drm_get_colorop_csc_ff_type_name(enum drm_colorop_csc_ff_type type)
> +{
> +	if (WARN_ON(type >= ARRAY_SIZE(colorop_csc_ff_type_names)))
> +		return "unknown";
> +
> +	return colorop_csc_ff_type_names[type];
> +}
> +
>   /**
>    * drm_colorop_set_next_property - sets the next pointer
>    * @colorop: drm colorop
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index bd082854ca74..2cd8e0779c2a 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -134,6 +134,60 @@ enum drm_colorop_curve_1d_type {
>   	DRM_COLOROP_1D_CURVE_COUNT
>   };
>   
> +/**
> + * enum drm_colorop_csc_ff_type - type of CSC Fixed-Function
> + *
> + * Describes a CSC operation to be applied by the DRM_COLOROP_CSC_FF colorop.
> + */
> +enum drm_colorop_csc_ff_type {
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV601_RGB601
> +	 *
> +	 * enum string "YUV601 to RGB601"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts YUV
> +	 * (BT.601) colorimetry to RGB (BT.601).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV601_RGB601,
> +
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
> +	 *
> +	 * enum string "YUV709 to RGB709"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts YUV
> +	 * (BT.709) colorimetry to RGB (BT.709).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV709_RGB709,
> +
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
> +	 *
> +	 * enum string "YUV2020 to RGB2020"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts YUV
> +	 * (BT.2020) colorimetry to RGB (BT.2020).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
> +
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
> +	 *
> +	 * enum string "RGB709 to RGB2020"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts RGB
> +	 * (BT.709) colorimetry to RGB (BT.2020).
> +	 */
> +	DRM_COLOROP_CSC_FF_RGB709_RGB2020,
> +
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_COUNT:
> +	 *
> +	 * enum value denoting the size of the enum
> +	 */
> +	DRM_COLOROP_CSC_FF_COUNT
> +};
> +
>   /**
>    * struct drm_colorop_state - mutable colorop state
>    */
> @@ -183,6 +237,13 @@ struct drm_colorop_state {
>   	 */
>   	struct drm_property_blob *data;
>   
> +	/**
> +	 * @csc_ff_type:
> +	 *
> +	 * Type of Fixed function CSC.
> +	 */
> +	enum drm_colorop_csc_ff_type csc_ff_type;
> +
>   	/** @state: backpointer to global drm_atomic_state */
>   	struct drm_atomic_state *state;
>   };
> @@ -368,6 +429,13 @@ struct drm_colorop {
>   	 */
>   	struct drm_property *data_property;
>   
> +	/**
> +	 * @csc_ff_type_property:
> +	 *
> +	 * Sub-type for DRM_COLOROP_CSC_FF type.
> +	 */
> +	struct drm_property *csc_ff_type_property;
> +
>   	/**
>   	 * @next_property:
>   	 *
> @@ -424,6 +492,9 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>   				 uint32_t lut_size,
>   				 enum drm_colorop_lut3d_interpolation_type interpolation,
>   				 uint32_t flags);
> +int drm_plane_colorop_csc_ff_init(struct drm_device *dev, struct drm_colorop *colorop,
> +				  struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
> +				  u64 supported_csc_ff, uint32_t flags);
>   
>   struct drm_colorop_state *
>   drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop);
> @@ -480,6 +551,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
>   
>   const char *
>   drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
> +const char *drm_get_colorop_csc_ff_type_name(enum drm_colorop_csc_ff_type type);
>   
>   void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
>   
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index a4bdc4bd11bc..5d21f73c3d76 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -971,6 +971,19 @@ enum drm_colorop_type {
>   	 *         color = lut3d[index]
>   	 */
>   	DRM_COLOROP_3D_LUT,
> +
> +	/**
> +	 * @DRM_COLOROP_CSC_FF:
> +	 *
> +	 * enum string "CSC Fixed-Function"
> +	 *
> +	 * A fixed-function Color Space Conversion block where the coefficients
> +	 * are not programmable but selected from predefined hardware modes via
> +	 * the CSC_FF_TYPE enum property. The driver advertises the supported
> +	 * CSC modes through this property.
> +	 */
> +	DRM_COLOROP_CSC_FF,
> +
>   };
>   
>   /**

