Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F6AC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6531B10E471;
	Tue, 18 Aug 2026 21:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ij8h/iKU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F21E10E471;
 Tue, 18 Aug 2026 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787089471; x=1818625471;
 h=date:from:to:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=t5PEPz6DUja58dOyxB796e++GdVvif70CXg38IwSmr0=;
 b=Ij8h/iKUNF8XzqgaaQK42oS0tMscJP8mYd9sp1qlTx+SSV+Fp9ZygsZM
 A30ZzB1+Lhp8q7AiQElcNYpRPglbxVXxSaLQ5zbHZRzvKKSpyApyjR0Nd
 cdXXIz4mn2mr/mfXm7p/nqVG2+9MPjglGOQYh9GyB8UAm6EqZxEjyRcO7
 hhys0GiHztkBIvWXtGmvAXqv2SodopBUsa85UmzmXTsK+uavM77nISEjV
 fUHM6eYY1u1eq/p3rh0iIkw9GylldUwUznqQu3cPqmn3Lqjnz5dvXnuZo
 Wbt8e3FnAdK/dMPw3kHw1/fxwcI5wGD2lVDpCi828pMme3Nu0gvjLyUAP A==;
X-CSE-ConnectionGUID: ijmA2gGXRiWHQavsdw/QSg==
X-CSE-MsgGUID: 1ugIYqHOQjmZyaT93mR2PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98955558"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98955558"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 14:44:30 -0700
X-CSE-ConnectionGUID: 03fERMcwQtyZvIX5GwHwCA==
X-CSE-MsgGUID: +4Q4k4+iQim0IDjh5rkf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="262070878"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 14:44:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 14:44:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 14:44:29 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 14:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mptc5OKrncQfuqWXD7DpTRmn+pQ4moQoWB2G7k4t7iyEpvGjcnxoX2azOxyWD3OmEZnJasHIH8ipnyw7irKmQ/oA9kG7i/paLrQ8eT1DmMcaLGBtCXUTa8U0vka3fkKA8PJEs/Ml5bux6inxWxVXUicGzxg8Yj//uUux4fKFxyqOQT/gFi1XXouWwx7dpzbpKrmGrtbdtJDEnt/tblg9Ofl81BkDc/UJE/YXNf2Xd0csDGc04mxcEAMvhGG5foqX7RdLuCi98lhGbO2ou+A4R+f23JiWol74UbN2zuFuwWgAC7LNmgKHmEu6uRQB/4IncFcf23RurVDb7GQ+UeJFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDDavt6zde0vOds4lajStcw+Y/dFLh/ysPM+Tz/qAqI=;
 b=JnKH9OvKWBKZHgknUTn78nj9LrCpUy3RefIkA7VSe61nzHApDkh0kedD8fqn/nSS0zVnZGhgG7N/xmWxAnm3PyifFYeRCrOTRX5pPxyJSJKenMSqH4vlNNcZ10YMZmbDqGFtLmV28CWmCmN8DlnuW1IQEcBwN+p//mbsDeuLlQZl27s30dU6+c5b/AwbBlQbisGtASnhChp/eHKb3vNb64JS6a0t5a+FC34Yz1Sv7U4bw1gPq+jX/GEj/CZjyi5r1PaRKjhHj7aD71FrKwqQTmcM8mWzW98wNkhyldRsyAPxukJ3DHuyJ7X7aPvWZcWhwjMsHMGMSfk6EGaoOoqcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 21:44:27 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 21:44:27 +0000
Date: Tue, 18 Aug 2026 14:44:24 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 0/3] drm/gpuvm: two pass locking for exec
Message-ID: <aoTSOFlA8WNizj3j@gsse-cloud1.jf.intel.com>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <c87a906a82dcce2c52352a2796e21cc9037c71b3.camel@linux.intel.com>
 <an+Mzd5xuu0KHxhE@gsse-cloud1.jf.intel.com>
 <09b2029f7942c997c9355508b1f757f8731a9ad5.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09b2029f7942c997c9355508b1f757f8731a9ad5.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2387f21c-c671-429a-6c5f-08defd71e05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fT+8wVL+/0+8e53H5UrMojmj3U1X44jNBtKABuLNIIACwreyRA9B8YEJ8kWW/hTAQVlayxh9y9AHoR369OCkGSNXfNWyOeuFmf0Ke5BpTnlK39+yGK0SuYpH8cpI0+8ZdTMTLZut4MBC5FDfXbuHQoPF+isWe7dZmLfsNm4rc10ddjqzGa7/wlXjakvm6cssMD3zUgyTsuIvJE3AUXDay5lakjasQpV7vZPGT2BKNARDtKGlCWz15lsOMWgS/NbZk4FOVj2yYNBUKCY/h7LqSeTGoGb1dZm2av7tY+lvTrrJ5Kbf8bUyr3brSi1sSGDR39xUxJBuwv3II+kHl69VPCB4E4QoHG3luQ/mlYwi5KSFt4mWLeMc5ugw1pj8zplwT1ys2zShrvnF9wkK1F9Y8WzQBKowfvCrSb6zDrGnXM6rR4Fu6Q8dCAhNAwkeE428NHTLB5IP4TfoUiKxNK2rYtL69eG/pWslGB4Pjkdo8AmtKtySCcUMt4kMqJ4g1jx8Z3MgaDcyKfKgMuNrGX1b58YL0+Oue4ZPmTLfaPNwKg0aG6dCckRTgVm2geaPZhg0BJuxQ1MONrXDw25T955ET1TciThmxLWaIdZUjSe58I/MkLv9lXf5cYQeapuddGwH57kBoUTzBAEU2/kt6ez0WqIGraberOGoT7czSZ93/SQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXo5bnlNZi9jSDJLQXVqeWt6QkFQblNwZGk0c2s2YnpzeTVvVXV3V2xzaDU0?=
 =?utf-8?B?OXZXNi9hb3RBbEp4WEVVc2JRT2dlQXBlbVJWdU9KWjlHMTl4eExIT2diOWwx?=
 =?utf-8?B?eWV0QkE4WUxOSXBHcCtEeGJSb0d2eUR3ZmJBQi9hOTB2azZBMXUxc3JBRnRs?=
 =?utf-8?B?Z296ZzdCTy9nNDFYRkRGcTBqMk9iL3Y3N0pTUUNLRXIwV3ZXNXQ2TmVTejlq?=
 =?utf-8?B?K3JEQ2EyQzVtZWp1VFA0bGh0SzV1aDBRNzlpZFNjVHpoeTZNUnZ5bmhhNlpY?=
 =?utf-8?B?c1Rrb0loeENYV2M5Qy9NdUN2YjhPMy9lTkRhck5lZTdaOHdYdkRsZGttQ3lD?=
 =?utf-8?B?Yi9IYTdOWit1RWxVaVFoWHhRdGtJRXB5MGEwT2RnK0pMb1p3dEMwT1hKQXZq?=
 =?utf-8?B?SjdTaEx2bGF3b1luMVcwMWRUbzFxTXhKQWhEVk1JRWVkT3ZYd05RYU9JTHNz?=
 =?utf-8?B?TjBrSUJsQ3FYeVN2aXRBbGxFeGRYVWdIU0d1amFnY3JOZ1lQaXQyUUhxVjU1?=
 =?utf-8?B?RmRlSkpPYzBmdUZJMWtxNE1mTDhIZHdDWU04aXNhcjd6dzBhcWNJREFXV0gz?=
 =?utf-8?B?bDl3RVp4akx6UEZMVzJ6NWNrYTlWYUdYMnBsSFI2RGpYeDkrcGJXVmdkaDFN?=
 =?utf-8?B?N2VKNlh5UWNBZ3pJMHlDckk4dW83eU9RU0ZDOUJLaFFaazVwYmo3azJQQWxK?=
 =?utf-8?B?RUJpQVlqdUlFb1NINXMxWEhLZS90L0pqOUdDUWNLTklNV0Via2E4bnNnTUhr?=
 =?utf-8?B?UU5xcjFPaStHbExQcTlCR0ROQ3FOeE4rek9BQ3VMeFk1SzhnNlEwZXhVNDJC?=
 =?utf-8?B?bW55a0N0cmFPSHFGTGVOa1FVYWR6ZVFMaWg5RlNraE5tYlVxNUNlazlENmlE?=
 =?utf-8?B?bzFCbkpNTVdKNGZwenVrZEdGeElYVlhVQi85ajF2R25DNHRaR3hBUi91Nlo5?=
 =?utf-8?B?MXMrZGsxcTU1MVZ0UTZIYUg3VTVsTWVVWllraUFKdWp4YkxITzhjd21pL3hI?=
 =?utf-8?B?eE80SGJWenRwZWFmdXFXSUppQzg3eVd0ekVzSWVIOVdManV0eXpvK1VXRFFm?=
 =?utf-8?B?WEJBeHh0a29KbjNKSkwzVFBxSmc2by9SNXllanJmc09ZTm1Da0ZHYWFFb0sr?=
 =?utf-8?B?eUxXRVVzYnd5d3dDZ0hjQ3lzbTZxZFg2TkZncm92N3RndXhJbmE3TDJNVnNC?=
 =?utf-8?B?b0czZDZGWFF6dzhYck1xSDluVGNHSWJiTFQrR0QzcmtOaG0vcG50K3NGeGQ0?=
 =?utf-8?B?Wi9oRUJNUGZjQms3TFRtcElmTWhKUmgvQmhtTUNvUVh3QzFsSWl1KzBHRTM2?=
 =?utf-8?B?QlZscFlMd1RvNkhvcnhLL2dOZXR1b1cwNUR1bUdHVWVWT3R4Z3padUI3WC9m?=
 =?utf-8?B?MUU3TEkvZldJTERDdGV5Um1vODJKaC9OSkRvQkV6NXp4T1NzYndEbm9sZjI3?=
 =?utf-8?B?c2JjM3o3eFJ0Y0hFL1NjMHlsb2ZWQUhjd3o2UzNHVlVSREY3RzR6bXVhZzlY?=
 =?utf-8?B?VWFvQWhpVUFxdmp2VXd1eFAxYU94NFFmbmlHQUJjaVIwTFQwQ0xUUlpDNkp1?=
 =?utf-8?B?YytGMjdqU2hPalk0UTA5WkhtNytUejdCSWQ5eEx4bjVRa0lsTjkzRjRCNWhF?=
 =?utf-8?B?aFRWUW9ueU92R0tPbGVkeENCbWNhOTU1UnhBTmxOTlJRWERYdkFxMHU3ZkJY?=
 =?utf-8?B?ZjMraXNSUml1R09NQ1drWjk5SWpDMmxnU2Nkc25NbnFhZnBNdXZiVm00VmpR?=
 =?utf-8?B?RnJBaGRxYlF2UEJDeEoxZlFsTG5UY3gvdFo1cHFMeFpjNnNiRkRUZkVvOWRW?=
 =?utf-8?B?azdFNG5LandRRjRUSU4zMzhJNGJWeStlTmVRckR5YnhXclkyNnMxZFIxdC9Q?=
 =?utf-8?B?eFFoNGZrNFYrd0l3YTI5WFREZHE3ckxzUUpQNWZZU2gwdnZFK2JROEEzYmZq?=
 =?utf-8?B?T21YZlc3V1RSazVSZUErU0pmT3RuVEc3TUVIQTNKK243aDBPTG03bzJJa2pF?=
 =?utf-8?B?MS9EaEVFTWNibkMrYzNSRG12QXFFQkMwckdOZlBic2I4LzBpZzA4eE81cjk0?=
 =?utf-8?B?bW56bUxHVDQyanptL3A2dkw0U1dFYzd6cTNnbHBZTVpncWtpMUZ0QXd3UGxZ?=
 =?utf-8?B?Yjg1VEJ0ZGpZUm41UDRNZTdRc0VqdWFHSGZGMCtqNFduRjZkRDBQeFppR0Jh?=
 =?utf-8?B?UnhjZXpDUWRRT1Zod21aSUhCM1pFTjlVWEhvL285eHFETGZWVEkxSldWV0kx?=
 =?utf-8?B?cXJKUHVNbVZqdmZXelBRUmo1WmdCazZDVXVIekdKeWptM3Y0aEQxYmZScUtQ?=
 =?utf-8?B?WVBsWVd0ay9zcFZxbzdyVUJiUk9sQnBGWkRNRzh1MkkvR1JkejJvVnV4eGlq?=
 =?utf-8?Q?mpX9S7ipLNPZwK1Q=3D?=
X-Exchange-RoutingPolicyChecked: HKpaNhysI7QP9n/sDkwjuMPC3+J3Ik7vffRKhNhwR1BGuFXKCvuCYgytY7GvsJlxw5WDIE76nrE4rK7qk2AC+VlDAgTB4MmujBrp/UwZwv5zqG+xgkSND6je6qfPtxvzWeSRiwYwZQ6eim1kQSKQgpO8n/HaUfF5NOF5mMH1Mu9GAuuKYVA1vCSxsmdEoiPTPirYwhatt9VVnuasHq39qVuwTL4QRSRAFkO2fuZBZanSbouB1R6Mcj1H7MhmptYsaZBUoAhNB7TD4DkXefLZh+kB/saGC7GLqgreOlz46F8UQ8rFYOmL+wfbhQiaMrLjt5EmdiZknVZ5THXh/HyYwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2387f21c-c671-429a-6c5f-08defd71e05d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 21:44:27.1968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EH9Uv7lU0bp7p21xy+jOPLPQEORt9m0CETpQf36iTaGC067nymkFHpT7Sqt1Fv/y+QUcj2znUe9vzJ5z4hyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
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

On Tue, Aug 18, 2026 at 01:26:13PM +0200, Thomas Hellström wrote:

+ Adding public lists back, these were unintentionally droppped.

> On Fri, 2026-08-14 at 14:46 -0700, Matthew Brost wrote:
> > On Fri, Aug 14, 2026 at 12:34:01PM +0200, Thomas Hellström wrote:
> > > On Fri, 2026-08-14 at 00:32 -0700, Matthew Brost wrote:
> > > > Two processes share a set of buffers, and each has buffers of its
> > > > own
> > > > which the other never sees. Say process A has mapped
> > > > 
> > > >   S        the shared buffers, also mapped by B
> > > >   P        buffers private to A
> > > > 
> > > > and B has mapped S plus private buffers of its own. The overlap
> > > > is
> > > > exactly S, and the work each process wants to do on its own
> > > > buffers
> > > > is
> > > > independent of the other.
> > > > 
> > > > A submits. Its exec locks the dma-resv of everything it has
> > > > mapped, S
> > > > and P both, then finds something in P has been evicted and
> > > > migrates
> > > > it
> > > > back in. B submits, and blocks on S for as long as that migration
> > > > takes,
> > > > even though the migration is of a buffer belonging to A which B
> > > > has
> > > > never seen.
> > > > 
> > > > So the stall does not come from the overlapping set. The buffers
> > > > in S
> > > > are resident, and neither exec has anything to do to them beyond
> > > > attaching a fence. They are held only because an exec locks
> > > > everything
> > > > it has mapped in one go, and they stay held until the slowest
> > > > unrelated
> > > > thing in that transaction is done.
> > > > 
> > > > Which buffers get evicted is a separate matter, and one which
> > > > already
> > > > has answers: eviction heuristics which leave shared buffers
> > > > alone, or
> > > > one process' allocations outranking another's. This is what is
> > > > left
> > > > once
> > > > those work.
> > > > 
> > > > Where this tends to show up is compositors and presentation,
> > > > which is
> > > > also where userspace has worked hardest to avoid it. Wayland
> > > > explicit
> > > > sync exists so that a compositor is not latched onto its clients'
> > > > rendering, waiting on fences it never asked for. The locking
> > > > above
> > > > reintroduces that coupling anyway, in the kernel, and does it
> > > > under
> > > > memory pressure, which is where a missed frame is least welcome
> > > > and
> > > > the
> > > > cause is hardest to see.
> > > > 
> > > > The fix is to stop coupling "lock the VM" to "validate it".
> > > > Instead
> > > > of
> > > > locking everything and then validating, lock the private buffers
> > > > and
> > > > the
> > > > evicted external ones, validate those, and only then lock the
> > > > rest,
> > > > all
> > > > within the same drm_exec transaction.
> > > 
> > > This sounds like the tradeoff becomes "WW transaction rollbacks
> > > potentially become substantially more expensive": If we validate
> > > before
> > > the full locking transaction completes, the validation work *might*
> > > be
> > > in vain.
> > > 
> > 
> > Yes, indeed, if a WW transaction rolls back and unlocks everything,
> > it is
> > possible that validation from the first pass becomes immediately
> > undone
> > due to memory pressure. It is probably an acceptable tradeoff if we
> > really want to prioritize presentation at all costs.
> 
> Yes, I agree. Also worth noting that when we hit sleeping WW locks
> during eviction we already have the same problem: The whole transaction
> may roll back.
> 

Ah yes, if we get -ENOMEM we'd rollback or if we get TTM eviction to
part of the WW transaction, we'd also could rollback on lock contention
alone. 

> >  We could also use
> > an Xe-side heuristic to always perform a single pass when running at
> > a
> > privileged level in the exec IOCTL.
> >  
> > This would help with SurfaceFlinger compositors, which I know run at
> > the
> > highest privilege level. I'm unsure whether Wayland does this as
> > well,
> > though; I'd have to double-check. But also I think the ultimate goal
> > is
> > never have anything evicted in a compositor VM by ultizing priorities
> > or perhaps a pinning uAPI once we get cgroups. If we get here, then
> > single pass vs two for compositor is a moot point as single pass
> > always
> > taken if nothing is evicted.
> > 
> > I also noticed another potential issue in Xe. xe_vm_is_validating()
> > only elides eviction for the matching task, leaving a hole for kswapd
> > or
> > a foreign process. We may want to consider also eliding eviction from
> > kswapd when vm->validation.validating != NULL and the current context
> > is
> > kswapd, or perhaps simply using a blanket vm->validation.validating
> > !=
> > NULL check.
> 
> IIRC xe_vm_is_validating() is actually task state and an ugly
> workaround I introduced for avoiding passing the drm_exec down the full

I thought it was an ugly workaround so VM bind on particular BO wouldn't
evict any other BO bound in the VM. 'git format-patch -1 9d5558649f68e'.
I think happens to also do what we want here but perhaps we shouldn't
extend this further.

> call chain in the VM code (and the TTM code as well for that matter). I
> don't think we should extend its usage to foreign / peer processes.
> 
> Doesn't kswapd skip on the shrinker bo trylock? So that as soon as a VM
> has locked the vm resv, all its local bos are protected from shrinking?
> 

Yes, the shrinker does look to be trylock so we are good there. 

> >  
> > It may also be worth widening the xe_vm_is_validating() guard and
> > acquiring it immediately after obtaining the VM's private dma-resv
> > lock.
> > We would need some additional support in gpuvm for this, though.
> > 
> > > Accordingly, I think a follow-up to this might be to consider
> > > switching
> > > the dma-resv WW locks over from the Wait-Die algorithm to Wound-
> > > Wait
> > > which is considerably less prone to rollbacks.
> > 
> > I believe you are the expert here, and while I have only done a
> > little                                                               
> >                                                  ┃
> > research, I think this is a good suggestion. The numbers in
> > 08295b3b5bee                                                         
> >                                                      ┃
> > seem to support it, and now that this series moves expensive work
> > to                                                                   
> >                                                ┃
> > earlier parts of the WW transaction, before all locks are
> > fully                                                                
> >                                                        ┃
> > acquired, fewer rollbacks would hopefully prevent that work from
> > being                                                                
> >                                                 ┃
> > redone.  
> >  
> > Is my understanding correct?
> 
> Yes. If a lot of work is needed in a transaction for each locked
> object, then Wound-Wait tends to be the algorithm of choice rather than
> Wait-Die which works best when all locks are taken upfront.
> 

So I think this should discussed in a standalone follow up as this is
global choice for dma-resv.

Matt

> Thanks,
> Thomas
> 
> 
> > 
> > Matt
> > 
> > > 
> > > Thanks,
> > > Thomas
> > > 
> > > 
> > > 
> > > > 
> > > > Patch 1 lets a driver split the locking of an exec that way,
> > > > patches
> > > > 2
> > > > and 3 use it in Xe and Panthor, whose panthor_vm_bo_validate()
> > > > swaps
> > > > pages back in under those same shared locks. It is opt-in, and
> > > > drivers
> > > > which do not ask for it are unaffected.
> > > > 
> > > > Matt
> > > > 
> > > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: Steven Price <steven.price@arm.com>
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > Assisted-by: GitHub_Copilot:claude-opus-5
> > > > 
> > > > Matthew Brost (3):
> > > >   drm/gpuvm: allow locking external objects in two passes
> > > >   drm/xe: lock the resident BOs of an exec last
> > > >   drm/panthor: lock the resident BOs of a submit last
> > > > 
> > > >  Documentation/gpu/drm-mm.rst          |   6 +
> > > >  drivers/gpu/drm/drm_gpuvm.c           | 480
> > > > +++++++++++++++++++++++++-
> > > >  drivers/gpu/drm/panthor/panthor_mmu.c |  53 ++-
> > > >  drivers/gpu/drm/xe/xe_exec.c          |  23 +-
> > > >  drivers/gpu/drm/xe/xe_vm.c            |  43 ++-
> > > >  drivers/gpu/drm/xe/xe_vm.h            |   3 +-
> > > >  include/drm/drm_gpuvm.h               | 133 ++++++-
> > > >  7 files changed, 709 insertions(+), 32 deletions(-)
