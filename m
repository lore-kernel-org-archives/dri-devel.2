Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B591606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GS3H17X+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9070C10EF83;
	Tue, 10 Nov 2026 10:32:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B7210E2CD;
 Tue, 10 Nov 2026 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794306732; x=1825842732;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=PAXuR44202q7QBSahOoMxffAlEZULkfRIi/zTWP0SSY=;
 b=GS3H17X+pWAlNFG/a5EUBdhK3JlJtOOMrav64hdOMHCmyx3fp9u5pbR/
 AEt3rgdAbBu1ikBq3y481pQq339xVQZnd2By6bgr6Z8Yvpq1+hnSXgw3E
 IeGMawQDvnAf/xlcDETo2LZRjEDe5jfXufeqbqfrvf/+Y/jkMVV11IpV2
 sw9Ks6pzWZPrKBVNHb7gedJLzgfQVH9iUKuWfol/iS7TApwGgotEbUUpl
 /S5e1BJ4652/rEsYuWb8I5BQ8iDRZqknB11+LPVAN1N4mZuUk0T9Wep2v
 JpWzVHw2xwzL1aWZ7RuTlpdNtrtxAXEjiR3uZYk9IMyz/qislcO+vF4UF w==;
X-CSE-ConnectionGUID: yCQET7XCQJqtSk9j5M/Pmg==
X-CSE-MsgGUID: hMhvZ9jZQy6NfJvz5xhxWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3062458"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3062458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:32:12 -0800
X-CSE-ConnectionGUID: xFVrsEP3T/CiuQ0Qo/gYFQ==
X-CSE-MsgGUID: +AUexf/8SZSu2yzHLwi2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8441999"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:32:11 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:32:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 02:32:10 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl2hFces0MzyTYErBfF/oZIl2TOyEVR7aFo+wehxhxfQ+1MYmBhzDBkw2W56vtOWRzhgGJ+Tw47+fByOjbwKe/1j1d24kAmWxonHd2+qkR9LBJZplmg1Xta+6NCJQRYD2upO7Y6yo/IuS2oA6Iq8kXMsVhZq4MbSnHPiAdZDQoW9r/YJLxi3vR6Jg1q8f9nGAevlHdd+ya/1UpqqEFG5Py4NXIFCKM7sqJ5Taso2FhxMrM6JVnzTX9+9gpB86yzovdLJiDZNRgNC9GmyOS1zFWPuFS4LC9Apemg3vi80WjH5isvQhpbZgTRAFwW4S5XKC8wEK5tMFF6+zIvIqIKDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPapcCvt+ZS8/Mpor2+cAlbtr2B0PEt5r3BNHiE4zuk=;
 b=PccJwv48f6JaTfuxt4Oo81IZF52AWheqVGTjeyzhG4ktYNdMBqqNOxyYd/Qy9dECSau6FgLxfbrUxJKTGOY3otpNPLipR5cuh2tjGIuebB2a7SGgyCd2kO8LFDzlqikMljLUHVu5ddx6suXxUaeAXfC6cXKlqzpyV3XJFySSdWxgoj+FU6ftdMTe+rleZ4i4boK5MSMoEuhDrnagoF8M042swYg46CcNNwjf6GYGuVioSippBt3IRqpIv93Icqox+7JO3KAmzCP48GX43dFGR2bLGsJ74DE77d0cDNvf6tBDH7+hJSw7Bv3w/CUvDG8mNPBVRwLnFBf41ZUKt4BEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 10:32:08 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 10:32:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2026 11:32:08 +0100
Message-ID: <DMRGNFDLB3ZA.299FJI2NDXLOL@intel.com>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2] drm/i915/gt: Adjust usage of SFC_DONE registers on
 Gen 12
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261105071426.1159739-1-krzysztof.karas@intel.com>
In-Reply-To: <20261105071426.1159739-1-krzysztof.karas@intel.com>
X-ClientProxiedBy: WA1PEPF00005B95.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::632) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc0eda9-a23e-469e-7368-08df3f15def5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ni18xaSawg+X3evnhQ1JTwRiLGCRW1j1FaABvFUHCoYXh11Car12STMyd0eITYoMZXd3YP1MQkARjI8pVLsoyb7Wu5Q11I6FF8q0EcH8naXZ2C/KGBT4kfnybjHKDslBWeWR8Eg/blZfzrW8EBfEeb5EAKTHoajANpOPETy68wSnymCXs6qh+hUjDrP0eOS/klAWF3XTtN1tKzIIutloIdEIuUcMhNJvagwfNSUKAYi8TXaRrctIcSC3CRcqsWoULXGN5MJaujLBBNBKtyCHIA6zkGxpj+prf3vPY4JypfSNLR4UEn9KEEb+0qVHuBLUjdHvDeWhRoulSsBpam7uYFCcLzBAEAuvK8G/rh2RyYMcOl84Q2aUkAMfx+XRVAB16nbo7H2b4eQO2Bj9q8XCHEzDTY2/Mizs5Wzb+xHQ/dHC+Y224PxRBn+9bkQHtoe5JdINt9fYMqfKmEgdGkZQTx6nO/6kDu7kAg0wmKnXiqQmb7hADTpACmQhdXzCosC2aQYPGA43fncZ/93Q35OPm1qyArtocsl91dsRLOd/Vk1tyCYefR7HzP2d+HZS514GTYKSQdCAnim5I7yiqXoEIylwgXm6yyFb34sbrUPsO2uDvywMhcnqoaeVdrViDV70
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlYvMnhwemtHYVV0Yzk2WGFmV3R5VkhnWmo1a2ZTUmdjY2RUZXZYWGxtbUZz?=
 =?utf-8?B?ajVFekNpUG5FZnY4cjA1RkxZY2JBQ0tpUWQ2NjhyQ2tKK2VranVyWWNHWVVO?=
 =?utf-8?B?b2xmMGlxd00vVWRyNkJjcUJSRkI2dmhTUFBYdWFyMk5tdUY4TnFLaUhaVkhG?=
 =?utf-8?B?OCtwTUFDNERRWE5lMzF4bm1XaUJ0a0JOMUFZQkIrM0h6bFJiWlhpbnJPSGk5?=
 =?utf-8?B?RjYrOERISjN4aXZtMm1PSzZuTm9oclBiWWVsMHVpMk9vb1l3Tk4vN0dlUWJM?=
 =?utf-8?B?TW51OFRrTldrN1ZXTDc1Y1F2bnVPNW5pTHIrOElvRzRBWmMwREVoTitEY3li?=
 =?utf-8?B?WXkrNDdPZklPU0t4Q3gyV05Scm9ZdTA2RFRUMFdoaThtS1RtaGkvZW12MEpo?=
 =?utf-8?B?TFBxT0tJaGoySUhTdnlzREdrTFY3Wm13L010MklPSmcySk1OZDNMbWpwT1hD?=
 =?utf-8?B?REhzUHBXaFQ0dVZMQTg1S2s2cjhhM2huT2dST0lVc0J1LzdzK1VYK2lkWldt?=
 =?utf-8?B?Q2l3QkdzdnBNWkJyRUFFQ1RCcFNQOFVYeGwzcVVOZnB5N0liTFJDSjFjaFJ6?=
 =?utf-8?B?dnBSV1Z6K0NxWWFBbHRWTWViNWVUQXBNbVl5QlgvSDBMRzM3cnNnSHdxeEti?=
 =?utf-8?B?UHRFQVJEMUFWU2NjdllQbFQvekZuYlVKNW9KL3Q4b01QM2ZpVGw4NE12alFt?=
 =?utf-8?B?TzUva0NuU2V2bTZqdHJNNSs4S3NRRUNPY1RqU0F1VjJMNWxxMDQ1T05BeVZ5?=
 =?utf-8?B?NFQ0Y05WME5nZ3l2M3NJTG5SbjcyVnJXcU54QzV4OFpGSDFYczJaVG9KaWF4?=
 =?utf-8?B?SnNWbmROUFMwUDBITTZwS0VEc0VJb3hxZFN0V2Z3NDhseUt3cmJxWFl1Wm1u?=
 =?utf-8?B?RTlnNWZ1R1RQYUtrMUxJM3BFekE5Q043bjlaRG1ZcjU2bXVyeE5rSTRmUDFT?=
 =?utf-8?B?am5BSnFIVTF0MTlJRmdsNXZURldOWnFsYmdqa0cyOXdINTRFOHd5TUsvYmlD?=
 =?utf-8?B?aVJCdVptZnF0YlpJdk1yWE1sVVpFUmZ6aG9nVldrQVBvN2hQOGtZcWNVdDJx?=
 =?utf-8?B?RU9TMFZHZ1M0R3RpaHJxb205c2laSGYxTmFhOFFRVXNCZHFuN0xNRGo2T1E0?=
 =?utf-8?B?ejIxdWh1SFd5eHM0YzE0V0VnVy8zZ1pNNExXT2ZtUEFmOUNIbzdwRW9QL3Jt?=
 =?utf-8?B?N2RBWDhibHdNVWYweGNiczhDQWNBSkNlc0RrbXo1MDQrVmtPekQ3SzdTMXlr?=
 =?utf-8?B?UFJNUWNlK0FwVHVhOGNhM3preXR1Z1NnZURtRzY0TnM4VUR3VTZpQm44ZUZN?=
 =?utf-8?B?S3JOeTNVSTdVcmkwK3pZZzFJYXdQUHFQMzAxWjBldTZQSFc4V3JXdlF4UEdv?=
 =?utf-8?B?MjV1OU1JMkFkM0Nod29qRFN6eUVCcE9IRkt5K2EraGkvM2I3NEFRMUZMT3dK?=
 =?utf-8?B?RWNXcjVvR2N3bHV4OFlsSldEbm03UUtwWWdiZWc2MVE4NVNZWWZObVNSNG16?=
 =?utf-8?B?c0pLb1Zhc1pnbzl1L2xzY3VtczM0VGY4SDRrbmQvY29teEVESzMvWDZYbmwx?=
 =?utf-8?B?S2VyYUpiQk8zWjZreFhpMlZaWjBKdzRaMkhxZEk5ZzlvRlpaT0V6VHg5SnVZ?=
 =?utf-8?B?MnZYTFMxcVdXUFA2MXBxbDhDYzdPUGVWZm5pSFp2aFRQMThULzlIaDN0d3RL?=
 =?utf-8?B?ZVBFdUVaUnFEdkNrN09rb1ZhUHVlUmtleGlhYlkrZnoyME90OXNxRThBMWlS?=
 =?utf-8?B?QTFmTFVWc0hGSWF1dEh2ZlVsejE0ckwreXNCQTBXL2pZWmpVdi9aUFQ1ejhx?=
 =?utf-8?B?cHZKbjhvWWxCZytaWTNMcVBjR0pndmxQM3ZONmZNTGpvYVFmaGxFTHlZRXVM?=
 =?utf-8?B?aWtpU2tTZ2Z3VVl0TFEyQ0NzSFQ1RGxhRlMvM3VReFdPYll5RnB1bFNka1po?=
 =?utf-8?B?bTMzQVFGdlduRExFam5Xd3RpMDVzOFRrY0N3OXYvcEpDWW5uMUtkUnRJVWZK?=
 =?utf-8?B?cmtGNnVOQy9hVXZiTkJVTHBiQm5COGFEOGFXMnNoZ24yVTFnM0xNb1hKRUZO?=
 =?utf-8?B?NmFuNzl5MEVLamRSK3BzYTdRRFh4Zi9wUlpYYnFCVzZQdi9hOXdYRDU4LytZ?=
 =?utf-8?B?aTRhNzdLWFNQbHlCcXJ2eG1aUElWSjFmQ3BFdkUwZTN5TjkwUVpiVWMwQTRH?=
 =?utf-8?B?Q2RIaWtqSTdzU3ZzY1RnamIwMjJSU2FPNGNtU0ZKL05RSUd0bCs3RFdhSEUx?=
 =?utf-8?B?RHJtam9pQktDUHpnT0JyVmVCTTdOS3lRU3hzVzB4L2h1UkJMWmdBODIrc0xX?=
 =?utf-8?B?UElOK2hEUTJCTkJac0lLeUNRZFoxYU1aZTVHSFVVVnAvcmpSZis1NzdIUzgv?=
 =?utf-8?Q?78WmcxLkE7OrkHww=3D?=
X-Exchange-RoutingPolicyChecked: 5DC3Qms8B5EDTtEDt2v44f/kNq+117SITajtaTCyk8vFjvys0rJyDmJwk8lJkONA6ex2KrM5Frna3sxR581dOWzyFc4JT4Im+GbeA2w1YdAkxMlvg+YLX8ZTVnJPxqKwqmXJ5tUaI3avB/8RfjDeHFuDCLDg3spUsd63oWGTe6oExUrZEh0BIUjJLdRovAkK5w7+pe+u3ovN7JvvzFk6AQo1MxXQMaP6CRbHzeylg54UdKZVFdiuHFdUV4p4QLMsdWFp8t4+GK7TC3MpkOT9NO/d1GL5hzTkOc370DtRxa7LAmbRUZ5eeNO9j2tqB5jesFnXZOY1oVs+u07rzHPKcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc0eda9-a23e-469e-7368-08df3f15def5
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:32:07.8502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGKiqb4VHe0i06PBzXp91i8fEVK6Tu27BTq3STqWxBZAwCLVqJuGN3tcHWZQSYG7r6M+MOWlw6U1kMLZw3s6GnD9jG/sAllLOqWHBqqpvxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu Nov 5, 2026 at 8:14 AM CET, Krzysztof Karas wrote:
> Initial, empty XE_LPD register list for Video-Enhance class was
> introduced in [1] until [2] filled it out with debug SFC_DONE
> entries, but it was never explained in any of those commits why
> using those registers for VECS class specifically was chosen.
> Furthermore, currently, it is seen as a regression [3].
>
> Currently, gem_exec_capture@capture@vecs0-smem runs report
> partial captures on DG1, DG2 and MTL [4].
> SFC_DONE resides in the VD forcewake domain and is available
> only when the corresponding VCS engine is present (explanation
> from [5]), but XE_LP capture table currently associates these
> registers with VIDEOENHANCE.
>
> Furthermore, GuC firmware supports SFC_DONE registers in error
> capture only for MTL platforms, DG1/DG2 are not included, which
> was confirmed with experimentation and offline discussion with
> GuC side.
>
> Make a new list of register lists for MTL and use SFC_DONE
> entries only when that platform is detected. For DG1/DG2 pass
> an empty list for VECS class.
>
> [1] commit 24492514ccbd
>     ("drm/i915/guc: Update GuC ADS size for error capture lists")
> [2] commit 8b72c21618de
>     ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
> [3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
> [4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=3Digt@=
gem_exec_capture@capture@vecs0-smem
> [5] commit 24d032e2359e
>     ("drm/i915: Only access SFC_DONE when media domain is not fused off")
>
> Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC er=
ror capture.")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v2:
>  * Changed commit title (was "drm/i915/gt: Use VCS instead of
>    VECS for GuC error capture on Gen 12") and commit
>    description;
>  * Enabled SFC_DONE on MTL's VCS engines and disabled these
>    registers on DG1/DG2;
>  * Added a new list for MTL;
>  * Renamed relevant objects vec -> vc.
>
> I could not verify when exactly the issue started happening,
> because:
> A) all recent reports are red on DG1, DG2 and MTL,
> B) checking for "partial-capture" in IGT [6] was introduced way
>    later than the driver code asking for SFC_DONE registers.
> I assume it has been present for at least a few months, if not
> from the very beginning.
>
> [6] commit 93d3b0e28d7d
>     ("tests/intel/gem_exec_capture: Check for partial register captures")
> ---
>  .../gpu/drm/i915/gt/uc/intel_guc_capture.c    | 33 +++++++++++++++----
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu=
/drm/i915/gt/uc/intel_guc_capture.c
> index 865b61057566..88e6d706210c 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
> @@ -88,7 +88,7 @@
>  	{ GEN12_SC_INSTDONE_EXTRA,  0,      0, "GEN12_SC_INSTDONE_EXTRA" }, \
>  	{ GEN12_SC_INSTDONE_EXTRA2, 0,      0, "GEN12_SC_INSTDONE_EXTRA2" }
> =20
> -#define COMMON_GEN12BASE_VEC \
> +#define COMMON_GEN12BASE_VC \
s/VC/VD/ ?

and if
#define GEN12_SFC_DONE(n) _MMIO(0x1cc000 + (n) * 0x1000)
- SFC_DONE(0) =3D 0x1cc000
- SFC_DONE(1) =3D 0x1cd000
- SFC_DONE(2) =3D 0x1ce000
- SFC_DONE(3) =3D 0x1cf000

>  	{ GEN12_SFC_DONE(0),        0,      0, "SFC_DONE[0]" }, \
>  	{ GEN12_SFC_DONE(1),        0,      0, "SFC_DONE[1]" }, \
>  	{ GEN12_SFC_DONE(2),        0,      0, "SFC_DONE[2]" }, \
mtl_lists captures SFC_DONE(0..3) always. On the MTL media GT,
__xelpmp_fw_ranges (intel_uncore.c) has this entry:
------------------------------------------------------------
GEN_FW_RANGE(0x1cc000, 0x1cffff, FORCEWAKE_MEDIA_VDBOX0)
0x1cc000 - 0x1cdfff: VD0
0x1ce000 - 0x1cffff: reserved
------------------------------------------------------------

So only SFC_DONE(0) and (1) are in the documented range.  SFC_DONE(2)
and (3) (0x1ce000, 0x1cf000) are marked reserved.

I don't know how GuC handles reserved registers. Could you please either
trim the list to (0) and (1), or explain why reading (2) and (3) is fine.


> @@ -117,9 +117,9 @@ static const struct __guc_mmio_reg_descr gen8_vd_inst=
_regs[] =3D {
>  	COMMON_BASE_ENGINE_INSTANCE,
>  };
> =20
> -/* XE_LP Video Enhancement Per-Class */
> -static const struct __guc_mmio_reg_descr xe_lp_vec_class_regs[] =3D {
> -	COMMON_GEN12BASE_VEC,
> +/* XE_LP Video Per-Class */
> +static const struct __guc_mmio_reg_descr xe_lp_vc_class_regs[] =3D {
> +	COMMON_GEN12BASE_VC,
>  };
> =20
>  /* GEN8+ Video Enhancement Per-Engine-Instance */
> @@ -189,7 +189,22 @@ static const struct __guc_mmio_reg_descr_group xe_lp=
_lists[] =3D {
>  	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
>  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEO),
>  	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
> -	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_C=
LASS_VIDEOENHANCE),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEOENHANCE),
> +	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_VIDEOENHANCE),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
BLITTER),
> +	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_BLITTER),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
GSC_OTHER),
> +	MAKE_REGLIST(xe_lp_gsc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST=
_CLASS_GSC_OTHER),
> +	{}
> +};
> +
> +static const struct __guc_mmio_reg_descr_group mtl_lists[] =3D {
> +	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
> +	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_RENDER_COMPUTE),
> +	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_RENDER_COMPUTE),
> +	MAKE_REGLIST(xe_lp_vc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CL=
ASS_VIDEO),
a
Convention for CLASS_VIDEO is vd(e.g. gen8_vd_inst_regs).

> +	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_C=
LASS_VIDEO),
> +	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
VIDEOENHANCE),
>  	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_VIDEOENHANCE),
>  	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_=
BLITTER),
>  	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_=
CLASS_BLITTER),
> @@ -354,7 +369,13 @@ guc_capture_get_device_reglist(struct intel_guc *guc=
)
>  	struct drm_i915_private *i915 =3D guc_to_i915(guc);
>  	const struct __guc_mmio_reg_descr_group *lists;
> =20
> -	if (GRAPHICS_VER(i915) >=3D 12)
> +	if (IS_METEORLAKE(i915))
> +		/**
Those are kernrl doc comments style.

> +		 * MTL is the only member of Gen 12 with SFC_DONE registers supported =
by
> +		 * error capture in GuC firmware, so use a separate list of registers =
there.
> +		 */
> +		lists =3D mtl_lists;
> +	else if (GRAPHICS_VER(i915) >=3D 12)
>  		lists =3D xe_lp_lists;
You never mention other gen12 platforms (TGL, RKL, ADL, PVC), and this
change is gonna affect them as well.

>  	else
>  		lists =3D gen8_lists;





--=20
Best regards,
Sebastian

