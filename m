Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B730AC44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B6E10E7E8;
	Mon, 20 Jul 2026 08:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cAeafCTb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FAFE10E7E4;
 Mon, 20 Jul 2026 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784534900; x=1816070900;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=M4pREyriJuVRTFUdMoJd1rrthIdwixR+w30rf0H0GFQ=;
 b=cAeafCTb+fbjR3/Mp5jDuxx+XwSrYjxhtADF9MtfwwRcKwXn04oJDpJd
 lACE6DEjABxjZ8jP8SGn535jgXywPZD34gfaeZ3XdCIJrSlSnRFeLS2We
 iHP3brItB653EMMlbW4vIUGgN69IWwwckiL0QzLAIbr1y/S9ha8rK/dcu
 ePo2b27S9Hm4BhGuSWWCKeTfrLzk6obk63Ad9cgwtXg/1CN6R0QNUNLee
 ltzvNnqr/PNWKDFI9oxduCoG28Rc9JV/zE09gNVXtigQcTX571205+uUE
 XlKFmDh6SCCLtQJj9fuwp7k1Nowjqsw3deS5g88ny4wxHKd3dUGGmIAVN Q==;
X-CSE-ConnectionGUID: FzLFAWyZQu2G76wm/yO/Jg==
X-CSE-MsgGUID: zfv4+7RrTGazLeSLtWqFcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85058756"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85058756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:08:20 -0700
X-CSE-ConnectionGUID: nmdn0gNbS0+n0fIiN4ibbQ==
X-CSE-MsgGUID: 5GJdIM1fSEygm9iHJNtxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258031848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:08:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:08:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 01:08:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 01:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TU3Nj1DYH6/S4o78JK+J6/A06xNUUscpk3GMJ1kH8eL7uY5b+GrCq8Cugq/ezhSi95yyphpXmH9b2okNWyDo2eZTxriz17uEtJG5QkwI3IaOsvIgD/FdaKh8takJ4vNxVSohe/HuQ5g3h7BcShvfAD6s6G6MT5gKCjpR4hbAgXh0khoML85Y1Bby9/ktnydIvEQvXWPGSwPUR44y41Vc79VhYEqfFoBS3rpsh0sV1zwK2cZxfq84VxXzjnvlzJ3aQwZ5ZoAI7/F6pKQ4SvdC28jP4VoNvo4iUqUSxnQVwIkt3cvwMieLWNt5LWRn9QN20TXtCCE+VrFUcLyZ29pRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/NrbtAll5vuX0eU0i4RMk41SOUEFz8Akc9zCdrdMcU=;
 b=mhxYUfTX4INjZiY2r0jt8L7BWPwGjHi6yFeaGCkcKb3xrCH4xXjmyAyxFi3Ucrz3NDXNc1gLwN+fbS089ArNWDlExNixbyxgbml78vRM94CbtfpXH8+CHpAsvfnH0Zg3R/tEFc5xjwGbR0oiBgnChOscgplMXboWuBBuo1i9PqAA7X0RkxKAbbRIHxdBb0CVyOZK4G+yxLZZjJQPayFOi5alhYXCG6Qbn/M23rbysD3oz3lzSOKLrn9g8+0r406g5DL7TnMowDYxYyvN3rlRQgACLzBdHAMj+ou9XGYhoCUXwOgYroYqt3CtMtb2pYc+zUIAnKA/Zsggt+iB2sEG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:08:15 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 08:08:15 +0000
Date: Mon, 20 Jul 2026 08:08:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, "Sebastian
 Brzezinka" <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 1/5] drm/i915/gem: Count mapped pages in a folio
Message-ID: <slxno62woefuum3o3q3ojc77jrea24ubzdtf6irpwozmufnkwe@4vse6wjwwsom>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-2-krzysztof.karas@intel.com>
 <18bc657539f1eeacf116e9d7a2b3c823017b953f.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18bc657539f1eeacf116e9d7a2b3c823017b953f.camel@linux.intel.com>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA1PR11MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ff5644-8e0b-423c-b894-08dee6360cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: PsuKp6H0fzRvpkJK9r7DCnvc3EdIu/nZzHcXiztVXjzes84mngZE5PRg6JtrT0Ori9aNdb7hB/TkSEMpSzfr2HrwD4Z2J3yI31vmtRMpNKu0bJuBEkdIwKcvUTGUwSKFYi/jmjcY5c5b5+QkOglqYqU5jYvv72CQKczO/4k3ws1CFoln35nOB6EmR6bqTqbE9g2XRACBgxoWxY69x7VabL5rJUsFQf6Lic/BY5saFfNXh4IL6uOV52vM/ZLrKpHloTESP1lfCGL0Hg5VXZZv64WesUw5kKka78UFqUhKTWrnNUAehZa7Yz8FNwSUcxGRAzVX5WzmWAFK52L6+fykp/2gwxOGAp/PBlUc9m9nQ7MWWsomarXBBTQj0IqRs2TiOSFUQBcbsaWjKKP4R8kVTtJyewVcK1zjTw5qHJKTKGbIhRjlyLVeZmeQSjpZiKitgTgEZPNH3xz57dswFruSKDGit0VO+v4f2RYMxnR26ayI/EVL6GQprAkBif/MNEaS/lxwAkx+ryGzYJC4W0Tu+ssCv9qS/iUC8L2UrcU2r8wnGhfULr5KWBNHNBiujr+XVgXWxuCd83eVIrAFaoSt4MYabX0ZMb9T/RjyRJvkB0uYV2aiJq5SAll58iCPz3Rg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDMwZXcvWURpc3djWStUKzFUelpoREVKQnZjLzlpTTJzVGxWQVJkNkZoRmwy?=
 =?utf-8?B?R2txaFBSOTc4TFM5MHpZa21yNjhWZEpCeDJTbEtnZ1JHTFBrSVU2S2pvUU1U?=
 =?utf-8?B?Wmx0amd0ZGxRZzUwaFg1RVJkSkc1M2ZKTHBpQVY3MzU2Z1l6V2hSZmJ0eXpi?=
 =?utf-8?B?emhRa2VRL2duUEk5OGtaUXdxKzVSTEFPemt3ajhvdkdlNkFxaEZMaTRxVm41?=
 =?utf-8?B?Y1BUQmwyZWQ4NGtZMHkrUzhrdXZ3UFdJbEZpaU00SmI5b3JpQllEdTl4Tk5K?=
 =?utf-8?B?VmpjdVlNQzVjdlBiYmtkS0VOUldNRHpXL2JHS3BQWHFmR3cvbnArQ0pUQm5r?=
 =?utf-8?B?THBObkxoMXdWazd3ZGthdU5oM3RMT3JkSGVISVVFRTkwSDVzOS9TT0RwSXZT?=
 =?utf-8?B?QU5zdlo2OWpoUzFlVW1hK295dmxmSHpFamFOUWVTaEVkdldpRS9jSEkyajlk?=
 =?utf-8?B?K3BLWUdjRS9DR2Y4VjRvNkYrVXE0R1ZLWFp0cUJDY01JRHIzdmFIck9YZTNY?=
 =?utf-8?B?d3crY3VoYkMyYnhwaWo1c3ByZHZUM1JaYkdVTmtqYXVmZW1xNzJuMHptbHVn?=
 =?utf-8?B?TW1BMjVyNzRUZHlyWWlIMFl2K1B1anpCTU9XU1pqZU8zL3dYbjlqUVhRT1dP?=
 =?utf-8?B?ZkwvbTBUSjBDT1VFaTRobHVRQkdLb29aOTZmQkZMT3oyUmdSRGhhbytXK0ZO?=
 =?utf-8?B?b0tyQ01ma3dBUWg2UEcySXI5RENZU0FXeHEyaGk2cGMyeWRtYnRKbVhXNzBF?=
 =?utf-8?B?aTFaT2R1WEJ6Zk5GbWtpMDlsZ3J6dURuRzV0STUwaHVoTzk1WW1qUTF2YXc0?=
 =?utf-8?B?MU85SWJHejBhNWlGdUowK0xBMnVLR3M3TVJMVldBdFBiaWZqR2RzUkh1ZnAy?=
 =?utf-8?B?T1h0M1gxa0hlRmNCRHlDOEt1am5tVXQzWW1pRi9KVzRjL3VOMzJPNTBoeUtF?=
 =?utf-8?B?blIwQlFkWFE0T2ZpWjNDMWxZQzRvVEhjME55WGp2dWU2ajFLdWx0K0hOc3Bj?=
 =?utf-8?B?Q1pVN0I3QStSZ21wRE5OWmZ1UUtUNzdMV2lOVnJxcVFFZ0drV1JVS2c5YitF?=
 =?utf-8?B?TmRlRXZOSGhUaVBINS80SGwvNG5RUHkrWDRNVjNaRXRrTHVDL2pNeDJFbTZu?=
 =?utf-8?B?bktWN0d3VVB5WW5KbmtBU2FvQWtWOGpVeHc1eWQrdFNyZkZRTVJVUGw0eXBF?=
 =?utf-8?B?RkxxdUpFZWNXSjVTUG9keFNaL1I4NXZTdGs1OFdjSFAvS3Z2bFJ1dmtFRnND?=
 =?utf-8?B?R3Z1QzlDK2QveWs2ODByaE9JQkJueE5OWUNKRDZDSVFjM1krR0lkM3RvREMr?=
 =?utf-8?B?Sy9NMTYvL2tWalg1czR6dGtYVFNENzZrYTJsc1ZNdU1DWGsweGxXMGo0QmVU?=
 =?utf-8?B?ZmVpY3RINnJFU1NDakR6Ylk0K2dSTndpbEdEcXZYdlVDeGZKN0hrTzhTWk40?=
 =?utf-8?B?ODlGTUZXYzQ1OGdzTkxyU0RreFVsVktsRkN1SEsxU1dieTZNbUh6c0gzcmxF?=
 =?utf-8?B?OXpmT09ES3pwZUpmU2xwZXVGMk81Uzgzcm9tSnFRNWpoRzRGdXZMNVhQV2p5?=
 =?utf-8?B?Y2FZYlBJU1hicG1STXFZMzZuMWtvOWRjamFYVUI3eVA0bUFneUNLKzBJdUlh?=
 =?utf-8?B?ZUI3VHYzR244SVF1K3g1TUxzdDkyZzFlUDRWOWdSU09lRll6TFU3dDVWRUY2?=
 =?utf-8?B?cnBoWHRKK0xsQVZuZE80ZHlreXFtY3BFSi9qV25EZ2hLYllYQjQrZXV5STFT?=
 =?utf-8?B?TlVVS2QzWDNlTW9Vd05aWm9rZ1kwQ3haK0loNHE5MkRCZUFBU0VaQjJnVkg3?=
 =?utf-8?B?UnFnY3BFSXZKd2JPblZFSFkxcExnVlU4WTRJODI4dENwR3B6c3Vka1pQa2Jw?=
 =?utf-8?B?TU5pSFZXUlI4aXJUaUVqMW1sYVltNzY1bXdmZG5VMG5aNjlTVUtCZ1ppbm1L?=
 =?utf-8?B?bnloOWhlWjFGOTh5ZkhzbmU2YXJhcjd4WDdoVjkvTlNLcy9hSFNUL3hYZHNW?=
 =?utf-8?B?WTJHZGNzTThlUUtpV2pXelNqbzhiNm4yRC8vWDRJMXVrekY3Qkt4UmJwc0Ft?=
 =?utf-8?B?anhJMlJndWtCMjBWTEhXOVY3K04rUk4vU0k0Q01RSGl3UlJkL3NIMHBRYTk3?=
 =?utf-8?B?UVc2ay9PLzZOa2cxKzg0VmIvdWk0RVpOUFRTTEg1U3pRaW8rU29zTEdrSGJM?=
 =?utf-8?B?dTh5WWM1T1J3UVhFSU4rbEdXd2xmdzlxVXdDS2ZmSWozRElsL29UcWNIMFB3?=
 =?utf-8?B?ejJWZ2Q1YXdxT2ZIdm9DSEw2L0doazY4czN1QWFoeFN0QzdOdmZkdGtUMzJj?=
 =?utf-8?B?YmtlNDQ0RzVKL2kwUWNFamRaSkxlTERKbE5nNGVKQ1k1QWQrSDZWQ1ZhN2RP?=
 =?utf-8?Q?0tlU3wD5FTTDXrMA=3D?=
X-Exchange-RoutingPolicyChecked: gmj8SC52X8xZDXAKEIvPiwNNGMy1mPpMvAAXKuAwMVEBbNvT7OZdsxRzeXVvGG0tw5A0OadgT/iQGEYI82oO1wMevxf0gIYNAUrGv95p2UXTqDiuDxjWIkgzPXDeN6YKgEI8aFgKgtFBnNFgZt00pI36SoHiIi0BbGUtN+1recSXUPaMPWwr+DUh0e0101VjhYntQVj8vdL3/Q2ajlDlJ2W1i8XXqUVMJjD3k6kvbhFUFvukes92HDzrjFgDPDB7fWS5ufplVNZrjUOrOeleAd3EMprteFzYfP1lwRBvJ3Nt03kJ3jGnTNTEp/xIxJ5++uhHTZMLBn2O/YET/Z5sZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ff5644-8e0b-423c-b894-08dee6360cae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:08:14.9884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPgttQV/3FqqBJ2EmkQ54H4/rdfFgOB9PVc9OOe90N33bOfMJz6jhRG2KOyMdUCc/QbEGP+mRVPFwkYss/ekGDw5SzDPucBpK8QUYuhigh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6193
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

On 2026-07-15 at 13:18:21 +0200, Janusz Krzysztofik wrote:
> Hi Krzysztof,
> 
> Since reading your commit description I was not really able to understand
> what the issue you were trying to fix was about, I'm providing some 
> comments based on my understanding of the issue.
> 
> On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > With addition of commit 029ae067431a
> > ("drm/i915: Fix potential overflow of shmem scatterlist length")
> > max_segment size was included in calculating a number of pages
> > for the scatterlist. This meant that segment sizes considerably
> > smaller than number of pages in a folio (see shmem_get_pages(),
> > rebuild_st label for context), 
> 
> Two values of max_segment only could and still can be expected, either 
> maximum capacity of a scatterlist, or PAGE_SIZE.  Before the blamed 
> commit, that argument was mostly (unintentionally?) not respected when 
> allocating pages from a folio to a scatterlist.  IOW, complete folios were 
> always allocated, possibly overloading the scatterlist capacity,  
> virtually never limited to PAGE_SIZE when requested via max_segment.
> 
> The blamed commit took care of scatterlist overloading, and
> unintentionally also of respecting the max_segment == PAGE_SIZE case, by 
> limiting the number of folio pages allocated to a single scatterlist not
> to exceed max_segment, but failed to take care of correctly allocating 
> remaining pages from folios larger than max_segment.  That's what this 
> commit description should tell us about, I believe.
> 
> > were not enough to jump to the
> > next folio, which has never been a problem before folios have
> > been intoduced. In result, sg_set_folio() was called multiple
> > times with nr_pages smaller than folio size, using multitude of
> > scatterlists, 
> 
> I don't think it matters how many times sg_set_folio() was called or how 
> many scatterlists were used, since we may expect them to be huge when 
> shmem_sg_alloc_table() is called  with max_segment == PAGE_SIZE.
> 
> > all pointing to the beginning pages of the folio
> > and never fully covering its range of pages.
> 
> Yeah, that's the real issue.  An offset within a folio should be tracked
> and used when allocating pages still left in the folio.
> 
> > Track how many pages have already been counted in a folio
> 
> ... and use that number as an offset on consecutive allocations from the 
> same folio ...
Hmm, very well, sounds reasonable.

> 
> > to ensure it is fully covered before reading next folio.
> 
> > Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---

[...]

> > +		folio_page_index = i - folio_start;
> > +		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> > +			ret = -EINVAL;
> > +			folio_put(folio);
> > +			goto err_sg;
> > +		}
> >  
> >  		nr_pages = min_array(((unsigned long[]) {
> > -					folio_nr_pages(folio),
> > +					folio_nr_pages(folio) - folio_page_index,
> >  					page_count - i,
> > -					max_segment / PAGE_SIZE,
> > +					max_t(unsigned int, 1, max_segment / PAGE_SIZE),
> 
> Why?  This function is never called with max_segment less than PAGE_SIZE, 
> then max_segment / PAGE_SIZE can't drop to 0.  If you want to address the 
> unexpected 0 case then I think we should just validate max_segment before 
> using it.
I do not recall why exactly I added that check here. I think
validating max_segment earlier is more visible, so I'll do as
you suggest.

> 
> >  				      }), 3);
> >  
> >  		if (!i ||
> >  		    sg->length >= max_segment ||
> > -		    folio_pfn(folio) != next_pfn) {
> > +		    folio_pfn(folio) + folio_page_index != next_pfn) {
> >  			if (i)
> >  				sg = sg_next(sg);
> >  
> >  			st->nents++;
> > -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> > +			sg_set_page(sg, folio_page(folio, folio_page_index),
> > +				    nr_pages * PAGE_SIZE, 0);
> >  		} else {
> >  			nr_pages = min_t(unsigned long, nr_pages,
> > -					 (max_segment - sg->length) / PAGE_SIZE);
> > +					 max_t(unsigned long, 1,
> > +					       (max_segment - sg->length) / PAGE_SIZE));
> 
> The same as above, we may exepect max_segment not less than PAGE_SIZE.
Yup, got it.

> 
> >  
> >  			sg->length += nr_pages * PAGE_SIZE;
> 
> The only case for appending more pages to a not yet full scatterlist I can 
> imagine is when first page of next folio is next to the last page of a 
> previous folio assigned here before so contiguity of pages can be 
> preserved.  Then, I think the above if conditions should better reflect 
> that only case for clarity.
I think what we are missing here is the assumption that folios
are placed one after another, on which we base next_pfn
calculations. If that assumption is wrong and next_pfn is not
the address of the next folio, then we land in the "if" instead
of "else" block.

In any case, I'll add this info in the next version, either via
modifying the if conditions or adding a comment here.

Thansk for looking at this!

-- 
Best Regards,
Krzysztof
