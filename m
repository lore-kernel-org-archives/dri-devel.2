Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF7C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C84910F0CF;
	Wed,  2 Sep 2026 08:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fkqELIcg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E153310E48E;
 Wed,  2 Sep 2026 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788339537; x=1819875537;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LcT6g86pBvMKv1XomiCCKA0wZcW3L0hslOwL7+2+5M4=;
 b=fkqELIcgaiEjd5LOggHdGoxxdJ/eKKJkZ7MlnqrgwCb6NwxyErYSOmTD
 Ch7WEM4e8txCx0/NKp/DlVFw6w1AEHwKbol4VGjBjmtmK8L4WZ5TGqGZs
 U4pbEWshHmzR+Ae9Y7nn2AnC+johP3Y6yNPPjs3hJgkABvzRFtaFJZji1
 noGGtAknuAq+MnrPnNhfOyzfa5nhBiHGxTOmOdRGwJ7cNk/ap2ZdCAhYG
 w6yhXLjkowCkbDb+AM+93J17vbbFTjVXZMFGQERwU+caGLiLu/qC+yVMk
 +rUOwcnxKnQhyQJsByjy3C5noAj1KtZFWSq92Vl3aMKy9RFA8ZdfwZ+cp g==;
X-CSE-ConnectionGUID: cc7EEmsCQFKlR4PBe5od7A==
X-CSE-MsgGUID: LNqiFPBrQ4KXnz5/YDfb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92490950"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92490950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:58:57 -0700
X-CSE-ConnectionGUID: PrWfdeW9SFizHltD4Yi3ew==
X-CSE-MsgGUID: YtTncGkmS5ukhvjc1HA1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="266109532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:58:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:58:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:58:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLmUQ/k1T6M68T0hU1G5Mler8krCm41l+qf9mCYzWtrPoLTEWIeZybnGUGTpo1Hk+awaXPFeBhmzX1uZe4aqVL/3v9AP4F9V+narUh/CUD7RncIt2Ct23ISus3LMSWlvB1bhaUPj/RmRwOkJpy+ovQvuvwQUzlXQ+NJfynPJasTqHXQNjvcBz4uYmFEzqHnGzJy6Cs8JKwB+EIn6+JIE82WJ2Y9+5cfZjF7fmTSz1+Ug8ghYXv4EB8J2fo5XOVtHj36x6C7SRn2wGtQvghuNrIqTB/AtPLpjLmCOSatqBSWZnYYtETe8tXXJXUSaIUW09OhUn+8Htg9aluBpqCyssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKp2CWi8rn0QAKDT/q++YYUB/haIt4Vj8yyYtk69+cw=;
 b=uSaK4WwYuz4yOSnqWrI0V+zFLTvhVoZxo8L0MXxahZbEr5otz+KNlsTh52fj5h6ypwD7WRbQGVDhUaGVmqp35qLX8ShdoPgMLKK4otN71eTymka1BGVMbmdtW55GqGhjWni0jsPvtU1a10XQYfHode32fz1bOt+Rl/pl+idQTq4diFlen6A24UngrpakVi3qGMZNN9TQYE/yCqyrFYb7eWPA6s3mgvZZMbRzyKsIw4tb3GU/Y4AwawI5FWFwhNmHC6vqLxeCjUhkehhkMYeUjNgFSDSsiTVnajCyvX/973yabXROABKqAThBOT7Q8u+93iMWU1gKbZiOG7pVRAe9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM6PR11MB4690.namprd11.prod.outlook.com (2603:10b6:5:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:58:48 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:58:48 +0000
Date: Wed, 2 Sep 2026 01:58:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>
CC: Nathan Bourgeois <iridescentrosesfall@gmail.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
Message-ID: <apflRScB/NTEiEzU@gsse-cloud1.jf.intel.com>
References: <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
 <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
 <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
 <CAPM=9tw9dtxN+tZLrb4fvPGndUT+He7Y=o39ByMEva8wWyq56g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9tw9dtxN+tZLrb4fvPGndUT+He7Y=o39ByMEva8wWyq56g@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM6PR11MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af0faf5-9630-4f56-3204-08df08d066ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: LLdpg6wou536UA28ESdC7HlJouyL19oOG+jlQYT/Xl5uvEW3abez8wYLOFhfVV0AK9Y1tvfFDDVRaE2D8e14go0p1Qnjfngxi5Fbh4+ZzUW5GB62ukdysbojv0V4xPylCYOuhdVg6ndvMsHFPWFcXZzPFVl/8GrFVco68GJvpiJlBA4RG4SgoM0dGZDC9eutZqNc0leaaug/1RG8+Cf3iMtRY8sGrNkB5t80ftpdvPxq5NmB4p5vRRVUju4o083HrGuo5cvbUmqAd32L9yjCxg1CsMyDGJeONr0ZNbk11+FkHju+EfNnN/sq7QXzoQnLapZTByIPu5y6h9j0iN7lsjSZEWtuRSSyr7gZrPEPGqpSJTJossyg0WpXDhiNEu13+4swBMeIkdi+0mlvCPKnibZFsxHL+8DMf868dWLt92+bAptW4UPz7c1Iftxze+ZNRuTqbBYifj72crAlRfa4m/8CxXXKZvSMiC+5BC+IYO3Zg3lMN8sgh0aCqYVEU8QRAhQyP4RzEWBVWY5RRZl1Pd6DIMU3QMMc9vfwDpFzNshjNOCvhiI3rAIX0Ht8emIW8WEJYVdYKVbjs4wZMcplI2N1UGw9mboS4HX6z8TOTgt3fwRHbOtsv4SB4oy7l4/AVRR9WMcUB4rgzF0uNLzJ2XHNzR+2GtHbHFnSSv4hLco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdyOVZ2elJpMENHK1ExWTdndHNvdGVWRVNsR29XcXRMQytTVEJZaXhVU3ZN?=
 =?utf-8?B?eVhhNTNXT1VQM1o2MG5vRXUrcHRqU1djcjIvZHdYWUZJSm9TaHFySE0zRndu?=
 =?utf-8?B?cjV2Wk9STm1FQXNneVpnWGl5aXF1a2dqMEdYM1dVR0drdk5YNWxuYjhGbkJD?=
 =?utf-8?B?Y1Y3ZVB1T3gwMGNLK0l0WEQrRkJMaUJhNnVlTUpRazFOUFJkamhZMXdwWTBL?=
 =?utf-8?B?azdMc2srcXFoNmxiQVVKYVVkZkRySmk0enNhZWttaHBCQ2lLSlY4c2xKNHF2?=
 =?utf-8?B?eENrUTFFZWhtdjNVdFNhV0JYbkdjRnIwODVzVGhwbExPZXUyU0dVbFlMZVpt?=
 =?utf-8?B?aTJNZ2ZmYWFhRmxKZThWaVFaeW9MVTIySmJHdDlWRE1RMW5mUkZqVzZPamlh?=
 =?utf-8?B?RVZ0bDhmNU9kenJnSUEzOTY3ZFNodGt3ZzVYZVBPbWp0UWFBY1RzaFRqNlBJ?=
 =?utf-8?B?ZUdaVHpxNnA0b3RJYWhKRkxhaFZOQWZtOVo4MUl2bUxGdjdnMFlhZXpkTkRt?=
 =?utf-8?B?UGhWa0J0dnpLMnBTdldJc0xjQTQ3T2l0b0F4U3UzZCtEeTYva1RpTDI1cndW?=
 =?utf-8?B?K2k5MDkyRkVOZDJCMEEvV1hRNURGdlhCZDFJV29MVzJCSXdhVVllOEszOWho?=
 =?utf-8?B?aUkxbzVRRytkWHY4RkNEdFVEUU8yWWw0dzNrTnBYZTdpQitjVWJEaWN1VjdD?=
 =?utf-8?B?Mms5cWtpL3lxbkMrWUxYQWRubWQzeU9hY1RJNW12VlhLZ213NVMyRGh2b1hC?=
 =?utf-8?B?aFo0YWticGh4dkhHbTRnUXhBc3BHdHROdHpGZlRIRkJyN1VWM3FoTTdJaTZK?=
 =?utf-8?B?UERuSWs3V0VkTW5wVnduYVhsYWljUHJDNHRwWGNRR1dCR0FaUmpja2dNK2xH?=
 =?utf-8?B?SEwrOHRzZFZnM0dEU0xGcVMzRnNKcU53UkFDMjBLTVYrMFdVYkJDeEFua3Zp?=
 =?utf-8?B?UkJ5b3NtdHZLbU02d2hteUtucFJqaHRlZmx0S0s3clU5V2UzMDN2R1FPQTVU?=
 =?utf-8?B?VldLYjlieDRmazh1MS9mWEZ3RUFXNW1GcjdXbGQyNkhubGVkYmFoZnlSV1ZP?=
 =?utf-8?B?STN5TWtkbElUNTVoOW1PMmhubW85VVdEMEZZTlI0K0xabFgyNmxHTGQ1dUFj?=
 =?utf-8?B?bWI5N0RvUlI4NmRVL3VLR2VsMXMvRTN3QmJSZ2d0alZrS0tON25RVlhFSjJp?=
 =?utf-8?B?YTNXemxob1gwUi9DeTc5ZUlORVhNUC9BR3hlbSt6bzkrMWRDejZReEM4dTVD?=
 =?utf-8?B?akxoSElabTJ1bDB5RVR0cnNFcFJxeEwyMXd3RzVYTGVycTM3OGlvYXVuQkNM?=
 =?utf-8?B?VDVVMHJvVVZFc3NPcmg1VHM4K1JPcS9IWVhZUnI4TktDYmZVSythZ1BLeWxW?=
 =?utf-8?B?STlTeE05OGJrUUlGSnk0WHdtaWJzelhQRFdvTXZnYUJqaFE2MERoYmswRHVE?=
 =?utf-8?B?OVAyTWlGbW9VL0FzS1RBampuOGw0c1FnQ3crOXYrNm9pbm9JMnErU0RXeE5G?=
 =?utf-8?B?UW1Ub1VBNUpUYVBmazAxZFdmeFZncDYvR0ZMYWdQVExrdXJSd0ZRb01KUlR4?=
 =?utf-8?B?RkJMcjVxMWxlK0o4K1hmOU9SS0dzMnVkdFBiUEhhSDdxTUVURy9OZHNRb2JW?=
 =?utf-8?B?M2RDd3J4cjUwRDJtek5jNE8zMzFUWlZWYktNckFLY2I4eVBXVWlzaHNuWVFy?=
 =?utf-8?B?ZVJBbFNuSTVUWFY2OWtBTWh5ZmsxenFHYlNOTlJUWTl3WUlTTHJDQ2lkb3B1?=
 =?utf-8?B?Z21PUEtOcmxBYzd5ZFY5dExURVRCTWZaUlkvRTRuYXdyYXl2MFFZdm5mOGZi?=
 =?utf-8?B?VlJlV3k5dVhTekJEN2FLT3ZDSFJ6VURFSXBnOEVVTEh2SWVid2kvMmFNUDEr?=
 =?utf-8?B?eXZDQWg3NXZqUlNpQXovYWQ5Q2NUdW5OS09DQ01xMGszVEhuMy9lSHdTOW1l?=
 =?utf-8?B?QldLQ25vYzc4bzRlRGdSbVF4VFFKV1gvMFpTTlBCZXRMYm00UVUraGkxeENI?=
 =?utf-8?B?WDlmb0Y4Zmcrcllyd3ZiakdzMXU2ZmFtL3RMcGVReHJxT0lGOVVFK3J3WnBn?=
 =?utf-8?B?YkpLMlBIWnZtNUo4Wmdieml4MG5oakJmS0JjRVh0OGhPT0VPcFR2R3JVSzUr?=
 =?utf-8?B?NFFrbSt2Q0YwWmFzSnY0TXpLY2pCNGlkdFdQVG5SWXI3RzZKRWQyRVBBMFpj?=
 =?utf-8?B?NUs4bmxCRkdOZFlyYkNOdSt0bXRxZ0t2VzU3UVpyT2xsUlNOTUFEL3U2VDhB?=
 =?utf-8?B?c3JlK2RIbVN0YmRMMDlzRzdEQkdxajdjczh3Y2NTSk02WUlnT0M5a1d0Q1Ns?=
 =?utf-8?B?UkpVSW5lSVl1cC9QcHpMby8rbENxYTlyU29WeU1maURWWlUwUGRSdHg3cW1D?=
 =?utf-8?Q?rwVOuo8ajhGcmtic=3D?=
X-Exchange-RoutingPolicyChecked: m/2XTPv5atbkd1Pf0XfwmyVOy6HTfdtmcRxPOL6Xfe5Cpp9+abJSkhZoeieNCpn08LEwW55nLbObPhx/8+9b8iswyxPkVh/4irZEwNqozC5j3BgWFvte42nM//oWzyN3v2UIWskIJb682+K9Ks7gYnZowkzwtOt+e6cF42FIIcGQNH/wyCK01Ok8S+c0uJIY41jfCIXlfP2APUQgjGAcSIIIqhOsY6mj5JWwWZ+pGjj8SXGyoY2Es85K2mEx5grGC7kQLI+2mE5B3e7Su/yiEyJJio14f4pnU+THdgU1w64px32tCyg2Q0zYn/ri6pdra1bvrHIaneLBEV/4xLjN8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af0faf5-9630-4f56-3204-08df08d066ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:58:48.2229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFCxGRyH7/xRvIZDSq/Md8wdmens/xbkach2jfdCKOXdPHwkzFX2LfMQZI1M0BwcySU4P5Y2eJRaAWTCaHUkGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
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

On Wed, Sep 02, 2026 at 06:54:55PM +1000, Dave Airlie wrote:
> On Wed, 2 Sept 2026 at 18:08, Matthew Brost <matthew.brost@intel.com> wrote:
> >
> > On Wed, Aug 26, 2026 at 07:01:21PM -0700, Matthew Brost wrote:
> >
> > Dave ping. Question below.
> >
> > > On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
> > > > > Shouldn't we just be calling xe_bo_validate() here instead of
> > > > > ttm_tt_populate? (With the correct xe_validation_guard() wrapping).
> > > >
> > > > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > > > completely unnecessary.
> > > >
> > > > If ttm_bo_setup_export() is unnecessary, I'm happy to change the patch
> > > > or make a new patch. I will attempt to implement and test this locally.
> > > >
> > > > > This part looks good as different patch from what I'm assuming will be a
> > > > > TTM fix.
> > > >
> > > > Regarding this, what do you recommend I do, assuming the patch
> > > > remains local to drm/xe? I'm still learning the ropes of contributing.
> > > >
> > >
> > >
> > > For Xe I believe Thomas and I aligned a xe_bo_validate with a correct
> > > xe_validation_guard is the Xe preferred solution in the existing
> > > design... But a question to Dave below before I commit to anything.
> > >
> > > > Nathan
> > > >
> > > > On Thu, Aug 20, 2026 at 9:08 PM Dave Airlie <airlied@gmail.com> wrote:
> > > > >
> > > > > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > > > > completely unnecessary.
> > > > > >
> > > > > > It's also a bit odd that, in flows where we don't have backing storage
> > > > > > on export, we populate with pages and charge the system memory cgroup,
> > > > > > only to move the data to VRAM when the import attach is triggered,
> > > > > > resulting in a copy and a change in cgroup charging.
> > > > > >
> > > > > > I guess the question is why was ttm_bo_setup_export() introduced over
> > > > > > just a validation at export?
> > > > > >
> > > > >
> > > > > I'd like to think I had an answer for that, but I don't. Likely
> > > > > because I wasn't thinking about VRAM charging at all, and just
> > > > > worrying about making sure we had populated some pages for system
> > > > > memory ones, so the other side couldn't DoS us.
> > > > >
> > >
> > > Dave:
> > >
> > > We don't charge any cgroups yet, right? This would only come into play
> > > once a version of [1] merges, correct?
> > >
> > > What would prevent the pages populated for a TTM BO from being
> > > immediately reclaimed and discarded? I'm fairly certain Xe's shrinker
> > > could do exactly that, since we don't pin those pages. This seems to
> > > imply that we'd need to store the cgroup associated with the TTM BO at
> > > creation time and charge allocations to that cgroup, regardless of which
> > > task ultimately triggers the page allocation.
> 
> This was actually to fix a non-cgroup bug with a possible priority
> inversion problems.
> 
> i.e. a client could allocate a BO export it to a compositor, and then
> the compositor would populate it for the first time and get ENOMEM.
> 
> This was to avoid that case by making sure a client had tried to
> allocate all the pages for the BO before exporting it, so it would get
> the failure at that time.
> 

Ah, this makes more sense.

> I don't believe xe should just be reclaiming and discarding these
> pages without swapping them to shmem first?

Yes, the pages would be in shmem if swapped.

> 
> Validating is probably fine as well.
> 

Nathan - the conclusion is validate in Xe.

Matt

> Dave.
