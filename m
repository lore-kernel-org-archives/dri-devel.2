Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557DEC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4977610E27A;
	Mon, 31 Aug 2026 10:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dP/7Z/+7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9652510E277;
 Mon, 31 Aug 2026 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788173900; x=1819709900;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rMLtwkUg+rvoP3Xos2Km2pzjJC7PnPsNaHTe/4/XQlU=;
 b=dP/7Z/+7stVlOvZ0WEl3DntQEMMcISj0TAQKHVRapORXyOEe6u1Sqow9
 r0gVj1/LNhX+cUoCBFfxYWkqQokUf/H6GwmzCh8BKGoak4VWw6VXOX6KE
 MRVWR9HzPbXQKBSQXNAP20s331bwJmGMn9FE3fNnuNgnr2TfAp+23jAXm
 NOm28UHQWsuGALZ7MdFfMmXnvvRGmMsSJxkbOYdFz4SWWrCOiuSgyUQmG
 6UsliWxmB32r28m6Jn85P9EtlnfXDluSJBzCFu9XXweujGyMIlhqNIgH1
 kFCbada2303GWJgcFadDM9Aln8wFxmVM7AXh5EN+S8MwfA14fQjK5f27z w==;
X-CSE-ConnectionGUID: zkOKY1BUT7G0imbqT5nIzw==
X-CSE-MsgGUID: KnmGVSroS16XCR24zGqw/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="105953653"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="105953653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:58:20 -0700
X-CSE-ConnectionGUID: CVFiaIU7Q96qQP1/u0G7XA==
X-CSE-MsgGUID: 5zooxKbLT4ugIdskvcArqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="266185035"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:58:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 03:58:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 03:58:18 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 03:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKfkFcsGNKewsWdWdddwGPs7NStPhbXpy0hvXyGSpa1JaBT4DWuhxO4d/PPbYctwlu6zmIwYHJiK1fIjT+tLRg7NUstztjaIgQoipd6NrECbNc2Wrl6wj8EI03mdhy0xW8PINYvU1bUDbbv2Xc3BJqca8gNmzZZjo5aiBBOX9GFJqopdi0rZJ0bR8tzV5meybiVd04k71mjSYK44GBetJkORaQJ8RWG1sDomf3bZ4KKNhaTDPTufzQfAI2yy2hr6g4YkWWVhFdA36e7pgWgDeLYckYkGzn0BpgTB8rpjU4I7oOfMr2fX5nqiVEpeV42z6rp40TwnE5iyYn/iUMSGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQD3C4qHdzuBANJ0PtZJbtJqTirY0kmuEM9ZznTMi/g=;
 b=pF8+CPaXdn5Xz4vr19kc1R0rP6oi9dFxCYQkm0p10i/UA4KMK1C0Z/SRIbY2WLKsiVz9jMloNdmYOH/a+5Y6ZpVcCIghVsddwCu2Q8SUuBRVWnlnOegh7SR5KrvUGvOZ6rShZu4ZycBGuU8gRs4paGMM99/bAd+TvAIpVB27IHnHql26RPGvc1VR0WRFn3Bm/2L4EV+BUGd7+ae79RTDEw44d8Bd8CbWhjRWwM3NCuAuPdyPtssgnzxLvKemvcK/ZdhDBaGf42SxrI8Q/YneTA4hbnXeMXLiGmNB4ABLNuY5+OnSbiG/rMtqi41EtHQIcMB07sbUL+PiIHYNuAcIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by MN2PR11MB4693.namprd11.prod.outlook.com (2603:10b6:208:261::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 10:58:13 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:58:13 +0000
Date: Mon, 31 Aug 2026 10:58:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
Message-ID: <t5cgmjiaofeady463oknoxpkjhivtbgfc4i7yvy6gcbpvxncqj@37oqcxl6oa4l>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-2-krzysztof.karas@intel.com>
 <ddc172c331091e326e1d913cc2a5147efd4d8173.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc172c331091e326e1d913cc2a5147efd4d8173.camel@linux.intel.com>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|MN2PR11MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2fed3e-f88d-4b78-e548-08df074ec0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ntiNyIjMwiXn3m0FiK57Fe7FT9RY5xEuaSPJWogrgSH5r2Bqbc9Cw2tr1zHSapnQMsstZ/KKauH+eNbO6wPIahEYiVk8AurTqAqnO7NQIs4CTClOqpF/Zik5xP/CyCqtx+gqohMvzmoT7pHA/uObFuH9ytw/16z6mvooEvTeZGPL4TKuu8hsWhvBdYtX3y5XxE4RTSWXpHyP3v/t6zfyUhD8CuFgWSm3q+BYN1EUguKxr+wpRRY6/gZsazsoQnAFJPOZWsSaqmm5vZSG6E2I70zW5D4OXNgGkJGmEzde6Rrq1u0RHf/OLMYNWzNbzzzMPYmMILL+ywlSXgivfQgeZJnfO7exosnilJOxh/vg7Ti4xQ+3pP9KFC7CARpVcP0jJwe48emD0ztnpkriMod5nADRM7l1H6C5MZbre7xIdT1nsH+Ckqdxzrm3hCP6YGVP+PmIWhXj4UORhKuaD4UrvW6TM0qW8TYIywguszNMyPsoa5GxFy8KQy4VYtOF2K2XRUEoxsDf10YR5x7/TKLlWraFTtvPVfzJUZVAjIULud94/3yjg4bcRZ+zyzKMpActCGUfx/MTL650/S0CGwtMX6jRDr0U8YqtCC4aAV79X524UoyvyXm0ct6IzWtwAn77n6ouMmhKdDVGpJf+IeT28eh+uFRsdpjCahpHxIOdlas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZwWkJ2RG83RmhTYlM4S29RYk1qM1JIYzVFZnlTQ3hTNjBTYWNTVXdLMy9z?=
 =?utf-8?B?RzlmZVZKUENXVkROYVlobHlWRWU2aDNBMlZaNjVXei9MNktmRVo2RitsSUF1?=
 =?utf-8?B?S1dQTEhSWFFCU21vcVNwZCttMDBBZW9mbzZYZXdoQy9EUjNyQkhKRVMrbE9j?=
 =?utf-8?B?eE4zaWVXT3FXQWt0bkl6ejkrOFNibkgxLzJUNXdpOUhlYlFhanVpN0NwZ2No?=
 =?utf-8?B?QTNoUFBRb29ucnlEUFI0QVBxcHU3Y0lPbzB3cFErejBibFFUS1hTRnkzZ2hT?=
 =?utf-8?B?blFCME56Zk5BZFpGLzlTZWZIazJpNm56cEZkRnQ2VjRhcUdTamhHM00zSGlO?=
 =?utf-8?B?R0RVbWZpUStxQ1ZUTytPQUoyS1luNUpRaThRcWJ1aWQ4dmRUTmE4Q21NNXFZ?=
 =?utf-8?B?RjRlMXg1bjdBMzI4TExoQkhCdTc2SlJnRVhYRjlDRHF5b1ZqMCt5a1J2UU5a?=
 =?utf-8?B?bzFTdUY1K0VsZTJLY0VNQkxHbUd3UTF0ZEFTZFJqNXlIcmFpL2xnWlZBbFMy?=
 =?utf-8?B?UkdjcWRRWlZnNndnMVVWbWVQSkRKUUhieWpBeHViNXliMDlCUVVWdDB6Wm1u?=
 =?utf-8?B?K3FZUzQ4OFo4V0dtb29YcWFWQWlUUDZVbDRKT1YwUkQwS05kUkkvU3dvVUEv?=
 =?utf-8?B?YWJndnZDZkZYWmV3czBFaCtkRVM2ZjREUVp2VDA3WTI2cWczYmYvejRnbURX?=
 =?utf-8?B?ZEg5TGtvQ1U1bDRDZGE4ZCtjcUVqcm4xWjVvVUtNZU9US0dHR3U0c3lSU1Fn?=
 =?utf-8?B?b0dmbnVCNDRPenhCaHNKZ1YxWGpmdWgvejNEK2F1VlZ1TVN5aFQ2T3FiZzQw?=
 =?utf-8?B?ZEd4TjFsNVRqUjRoZkZrbFNsZFhrc1R1emRHV2NtTHdaL21jZ24yL0p4WFEr?=
 =?utf-8?B?ZnFNd0VKMXZMUTdJWmlDZDlvZXVFeHJ6WElnYUtyT1VlTHNORlFpTnVFdVdG?=
 =?utf-8?B?SjBBWVlrbmNHanJ6OGQ1UlErdk9uWm84dndzeWFTb0NaZmw1aXdjM092VU13?=
 =?utf-8?B?NFcvMjh6QmNpMjdFMlNKUENlYitzYVU4WXNDQWJEN3pTNXY3SXRjSVVVTTBy?=
 =?utf-8?B?SkNPUEhhNVF3MCsrWEozZTdYUnB5dE0wTzdPdlJENXkzQmh5WW05Mi9Kc3dO?=
 =?utf-8?B?M0dTazZuUzhKR2lnUHE0YW9PU2x3TUg4d1VCRU9DQUtBT2swajRiejYvZkVI?=
 =?utf-8?B?SitrOHM3VzJKUHlaMmkvakx2Q0M2VVlVSnFlcUZxa3l1d3BDcnlEMWRaYVhH?=
 =?utf-8?B?OUw3V0M5aUpBWGdSZFJSVXZaTjZUZm14elIrcXJIQXlQRkhWLy9ScjdBbFZu?=
 =?utf-8?B?ZHZvWjJXRS9YVzB4Y0IwbzhQVXlBVG1JRFNJRHlPdmdmWlJYTWN2bFRyT0dY?=
 =?utf-8?B?clpaK1BuRkFaRDYxbGdoRjZkcDNYdi9EdU42U04vbmNpYUs3RlNBc0k4OE01?=
 =?utf-8?B?d3R4OTRjSzZoNXo4ZzRSUGFldWZZR0JzNmFUa3ZBU01FeUlWRTlaMUhhdkJ1?=
 =?utf-8?B?SHArbWtnc3FpTWVxaGU5ZWZDVXZ3OXZNdmY3dEhITkR2YzIxZ0NZa2dKWFFM?=
 =?utf-8?B?Z1ZvdkJBT3QxUHk3dWZiOG5XSGxJTlFqL1BpY3dVMEUxUXNKb1VWdjl2UXRO?=
 =?utf-8?B?bDA3RFhKSTgzSjZnY0pjOWl0K2d2YkZEWE9EZUZGZ1BJblVnUjc5azVhUWpZ?=
 =?utf-8?B?T1loRVJrYWpWUlYxV0pwek9JZE04dnNtY1JZMXFYTnlNRXc5THl4U1NyWTZZ?=
 =?utf-8?B?OWNEdVRUbU5HZEltWkp2QjgvUENyemoxK1RIU0NGS0lXNUN0RnIrV3Q4QTBv?=
 =?utf-8?B?RUpwUFhWV1EvZC9EaWxnL3VmQXdIR2ZWdFlmNjBMUnNqa3E1cjF0MHFGbWky?=
 =?utf-8?B?bnc1dFkwRmlXYk51SFF6b0p5RFpVZ2owZHhzaW5zSEVKTlQwY3VEWWREdDZa?=
 =?utf-8?B?Ui9qYzF3WXRybWQ0dVh6Sm84TWpBTVNUTnZqZU5RSWZBZ3lYeUxyZXY3ZWxt?=
 =?utf-8?B?SFJDdVBUU00yNUJJVk5HbmpQSGZBZGkwZHlvTG95WVhTY3dMRmVpWmg5UExq?=
 =?utf-8?B?N0tVYWM3dnRqa24wN2c4RzZaVmd4KzFpVTBFcnJoeDdtMjVZU0dwM3hsRnRq?=
 =?utf-8?B?TGZrQUt4bXV6V1k1R0RVa3o3dFBLVzN3dDVMZCtROWwrK3dLWFZsMXdRN2NN?=
 =?utf-8?B?VXhtQzlKTVBmQ29YWkdEUHRJTTRoV2d5d3JwS2ZBWFByV3FMcDlHM3hIeGpj?=
 =?utf-8?B?eENrSHdOZkdhZXgwd00zS2toeGs1a2ZKSDNiRlV4WGZTZHpaRCtncytIK0VH?=
 =?utf-8?B?MkdMclNTc2JOeE51Tkw2dFc3bjBQUmxqT3dIU3V0TE92cjRXcEpVWlBJc2dn?=
 =?utf-8?Q?lt6H0PY0aKgwgOSo=3D?=
X-Exchange-RoutingPolicyChecked: qG2Ew5RTOPYNY8ykEKytZU7rp6wTCLfuwcZWdwIsdtad0nDWrr6Fsr3PVCCVHA17RjjyWzNo8MeZhfF6XTeQXELzZ6fWShIPvEwDQwOi8w69oFjXcSmJc3O+z6WgRXtuSgfoN5z+ICiW6skAhm1ar24x83zcS/0L/MEpR7+i6/LXkjkQTmQe+/LD9gh8nGTKFJgClzvmt/zQ3JWk1PwVbGl1nQADXq0DQmeBnmgQ4ezVGzx3uv/wlehxrj+t0Op/C/6JeLrehvuosnhQQUZqTD3Ge4PbgTz79ELxXO3PWbPMFn4O+IbMRDz8g2Wfkw96p9oqO7gSFCMmKGcL9jzOoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2fed3e-f88d-4b78-e548-08df074ec0fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:58:13.7729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pa7Hzv5X6/398ZjG+8p/mqf/Y7yr+rzRC/A5e0gMYws8j3+wotg7RaZGsc5DIYptg/TlwO1vz9CumnT+GOxyDI2mh1fObjPDotgFPQdaqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4693
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

Hi Janusz,

[...]

> >  
> > -		do {
> > -			cond_resched();
> > -			folio = shmem_read_folio_gfp(mapping, i, gfp);
> > -			if (!IS_ERR(folio))
> > -				break;
> > +		/* Grab the next folio if we exhausted the current one. */
> 
> I think that even with folio_start < i < folio_end, 
> shmem_read_folio_gfp(..., i, ...) should always return the right folio, so 
> we shouldn't worry about getting the same folio again in a relatively rare 
> case of the folio size exceeding a scatterlist capacity, we only need to 
> take care of tracking an offset within that folio.  Then, ...
> 
> > +		if (!i || i > folio_end) {
> > +			do {
> > +				cond_resched();
> > +				folio = shmem_read_folio_gfp(mapping, i, gfp);
> > +				if (!IS_ERR(folio))
> > +					break;
> >  
> > -			if (!*s) {
> > -				ret = PTR_ERR(folio);
> > -				goto err_sg;
> > -			}
> > +				if (!*s) {
> > +					ret = PTR_ERR(folio);
> > +					goto err_sg;
> > +				}
> >  
> > -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> > -
> > -			/*
> > -			 * We've tried hard to allocate the memory by reaping
> > -			 * our own buffer, now let the real VM do its job and
> > -			 * go down in flames if truly OOM.
> > -			 *
> > -			 * However, since graphics tend to be disposable,
> > -			 * defer the oom here by reporting the ENOMEM back
> > -			 * to userspace.
> > -			 */
> > -			if (!*s) {
> > -				/* reclaim and warn, but no oom */
> > -				gfp = mapping_gfp_mask(mapping);
> > +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> >  
> >  				/*
> > -				 * Our bo are always dirty and so we require
> > -				 * kswapd to reclaim our pages (direct reclaim
> > -				 * does not effectively begin pageout of our
> > -				 * buffers on its own). However, direct reclaim
> > -				 * only waits for kswapd when under allocation
> > -				 * congestion. So as a result __GFP_RECLAIM is
> > -				 * unreliable and fails to actually reclaim our
> > -				 * dirty pages -- unless you try over and over
> > -				 * again with !__GFP_NORETRY. However, we still
> > -				 * want to fail this allocation rather than
> > -				 * trigger the out-of-memory killer and for
> > -				 * this we want __GFP_RETRY_MAYFAIL.
> > +				 * We've tried hard to allocate the memory by reaping
> > +				 * our own buffer, now let the real VM do its job and
> > +				 * go down in flames if truly OOM.
> > +				 *
> > +				 * However, since graphics tend to be disposable,
> > +				 * defer the oom here by reporting the ENOMEM back
> > +				 * to userspace.
> >  				 */
> > -				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> > -			}
> > -		} while (1);
> > +				if (!*s) {
> > +					/* reclaim and warn, but no oom */
> > +					gfp = mapping_gfp_mask(mapping);
> > +
> > +					/*
> > +					 * Our bo are always dirty and so we require
> > +					 * kswapd to reclaim our pages (direct reclaim
> > +					 * does not effectively begin pageout of our
> > +					 * buffers on its own). However, direct reclaim
> > +					 * only waits for kswapd when under allocation
> > +					 * congestion. So as a result __GFP_RECLAIM is
> > +					 * unreliable and fails to actually reclaim our
> > +					 * dirty pages -- unless you try over and over
> > +					 * again with !__GFP_NORETRY. However, we still
> > +					 * want to fail this allocation rather than
> > +					 * trigger the out-of-memory killer and for
> > +					 * this we want __GFP_RETRY_MAYFAIL.
> > +					 */
> > +					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> > +				}
> > +			} while (1);
> > +
> > +			folio_start = folio_pgoff(folio);
> > +			folio_end = folio_start + folio_nr_pages(folio) - 1;
> > +		}
> > +
> > +		folio_page_index = i - folio_start;
> > +		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> > +			ret = -EINVAL;
> > +			folio_put(folio);
> > +			goto err_sg;
> > +		}
> 
> ... the existing code above, including the existing 'do' loop, may be left 
> untouched, I believe, an your folio_page_index can easily be calculated 
> from an already maintained next_pfn as:
> 
> +		folio_page_index = next_pfn - folio_pfn(folio);
> +		if (folio_page_index < 0 || folio_page_index >= folio_nr_pages(folio))
> +			folio_page_index = 0;
> 
> IOW, we need to calculate and apply an offset within the folio only if 
> next_pfn is still within the folio's PFN range, otherwise that must be a 
> new folio and the offset we apply must be 0.
> 
> Then, unless I'm missing something, I believe the patch could be much more 
> compact while still correct with my approach.  However, if other reviewers 
> are more OK with your proposed changes rather than what I suggest then I 
> won't oppose.
Leaving the current do/while loop as is means we get multiple
references to a folio per folio with shmem_read_folio_gfp(), but
only one put in i915_gem_object_put_pages_shmem().

Looking at this again, it should be addressed explicitly in
commit message.

> 
> >  
> >  		nr_pages = min_array(((unsigned long[]) {
> > -					folio_nr_pages(folio),
> > +					folio_nr_pages(folio) - folio_page_index,
> >  					page_count - i,
> >  					max_segment / PAGE_SIZE,
> >  				      }), 3);
> >  
> >  		if (!i ||
> >  		    sg->length >= max_segment ||
> > -		    folio_pfn(folio) != next_pfn) {
> > +		    folio_pfn(folio) + folio_page_index != next_pfn) {
> 
> I think the existing condition was correct, and still applicable even when 
> tracking potential offsets within folios: when there is still some room in 
> the current scatterlist, enter the else part that fills up the scatterlist 
> with more data only if we've got a new folio that starts exactly where 
> the previous one ended to have contiguity of pages preserved, otherwise 
> switch to a new scatterlist.
You are right.

> 
> >  			if (i)
> >  				sg = sg_next(sg);
> >  
> >  			st->nents++;
> > -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> > +			sg_set_page(sg, folio_page(folio, folio_page_index),
> > +				    nr_pages * PAGE_SIZE, 0);
> >  		} else {
> > +			/*
> > +			 * If our prediction about folio placement is true and
> > +			 * scatterlist still has space left for more pages,
> > +			 * then we land here.
> > +			 */
> >  			nr_pages = min_t(unsigned long, nr_pages,
> >  					 (max_segment - sg->length) / PAGE_SIZE);
> >  
> >  			sg->length += nr_pages * PAGE_SIZE;
> >  		}
> > -		next_pfn = folio_pfn(folio) + nr_pages;
> > +
> > +		/*
> > +		 * We assume folios are placed one after the other in memory
> > +		 * and predict where the next folio begins.
> > +		 */
> > +		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
> 
> 
> >  		i += nr_pages - 1;
> >  
> >  		/* Check that the i965g/gm workaround works. */
> > @@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
> >  	i915_sg_trim(st);
> >  
> >  	return 0;
> > +
> 
> Not related, I wouldn't mix it in, unless you have a good justification.
Yes, Andi also mentioned this in his review, so I'll remove this
diff.

Thank you for looking at this!
> 
> Thanks,
> Janusz
> 
> >  err_sg:
> >  	sg_mark_end(sg);
> >  	if (sg != st->sgl) {

-- 
Best Regards,
Krzysztof
