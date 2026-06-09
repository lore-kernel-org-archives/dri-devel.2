Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D04CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E04410E3DC;
	Tue,  9 Jun 2026 16:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="coY6IFiQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5788F10E325;
 Tue,  9 Jun 2026 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781022655; x=1812558655;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wzU2J5OglJ/yXWlZmAZcWALBdGD2EXlxHc2+u/rl6lo=;
 b=coY6IFiQUlaJplbXsWVb+GCvRtu66BNB9imqYYijn5k+uONiP8oNnBqi
 WZ3uK44o4Ry1/t1BODo0Gkb67F4GbzKCtOSp7vWWrk867G7nTmvF8Kw5T
 s/CBc9NJwkhBeg371jKGz4rBWHnX1ME9eO7la7xPuQAAgHACPs9hKtj9R
 Nixc1d/FXxp0XQ41G5uTm3ZVcya3InqupZIs0E6uvE7oPtRPT3jGzzB9i
 MY6MkoWDHn+Rfi73RxtSHDLZeqdTO63peeoz9G1OKGCVG8XsDhMKRgfq8
 imTSl4DvCdVNwfxS0H00pCZge3LMIp3rWW4uEgkIIBCKsJwRGaZNZgBBK Q==;
X-CSE-ConnectionGUID: Ch+MTTvLRFKla2DA7CqmcQ==
X-CSE-MsgGUID: P7WeGeYgTWWW8aBlg/ae0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81979260"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81979260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:30:55 -0700
X-CSE-ConnectionGUID: CvbuAQ/sQsCo7TYg6iPQiQ==
X-CSE-MsgGUID: xlh+cLLcTBOZ3yIJyNqLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="241764326"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:30:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:30:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 09:30:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVrrbQBlI64sT+cq5XmWDPu4u0ntxeCkcumLwJn1kH8zx7JlYvZ9X9uJ83k7GUq60hkEd9NFHuztC7C/D0xSnqKULdSuLwfyTOrcd2B2LbRH4NYCMH9qeHs5pFQHdrjpK0WPeG66WgOzHssDiLRxmMjxzOPEi6S7uBN5i8LhZEmozcKd1vN5pwENb9mSZq72XcL0lRwgmntlpTC1/ODqsvqbivCQEAq0ATeLMunpoioNOvJqnokxrfvRWQqWzvRuT0K18/UkXMg243Kn4KcfEbEAfWabjIqwNAZHvJY+B6yJZEHYlRaGTew/lhmjfRKxcRod3LAV8jObAwz9mmynwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O3KL8PDrdiG7vtLSrj1R/iVWe5xuSlPiJgWRdcUAzk=;
 b=bUcaq8Jxs6ut0QzRKkC3zYFiwczsL4S5aIyiObk1StHpfth0+pLEvtk/no1eNCCXLpe1n6Tpq/VGQjQtYRh8zkrhX2Ij3pNbb/bRs//sunzpDUy9HiHdo/GWgumYxHyyXn2CB55s+b3DbietUQ1uYc+rUhQMl0CvemW7DGFhIFiTNXAhxWss60tFkVJBPiiYAgpHG6JV8TbwBWcW/sfq6DBeUYBlgBSlEoieUpen4q98E1CNNBjRqo5aj31vmMqqpOsOH9LuNroqdh3cu9pl6Jb81D5krJZxNggm96o5paAylBqqmALUajqzwmCPnvhQyuRTh/plCYgbdIzibp93tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 16:30:48 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:30:48 +0000
Date: Tue, 9 Jun 2026 09:30:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <aig/tZU1lL/Zo69y@gsse-cloud1.jf.intel.com>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 178de3ff-3b23-44f6-16e8-08dec6447659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4s6uR/Gkhc2+STaDBWcpi+duvVXnEPrU231e9SqRWfIQErb09WInVg+4CvJS5ELlcZ1qBF/XBHNtdB1UA5H5KtLjECSMHvAk+YLb3c1BZq+rjAR+qqM2aAlLJ1mFHw3y46b2FY7LuDZwFp1ToqHnjDEOEJtZwq0o90C1I/hCRFg67l3D6t4F+Tkfol5fvKAx1jDDXfluRI+Yuakk5sAzhxrW3HRsetkIY9PKP7fCeTeuR8visEHyWE3+OKqMd2GQC41+hpL3zoaTOi2asmulGxAPHUVlJnIWwmGuRUGQdLcrjPeD96DQM8Ptqwyen5EOI/40RdORuGVFsyXCherDOsMXqzOa0JqOSCGT7d29K28V7BsfXwByWCOvNINOdhX8TGNkvue0uOjLXlDVjQDb31j8xlCHcy4IgYacN6hJaiuakjCuMykEwDjfgiSWuBNoZL3WqaQPxaC1EkkY+VmOXE7Y6Skss8zQSQdmhGPRz+mJ5ZkUrtoTun1tnOyGPvG+LP6ERXrIz16FAsUIdr1WOY2Z16AcQH4734AB8eQTaL1UATsEe461OZ5QlIsFRf+b783Zv+A/Ev2E3uBR04G+wAz5OjFHlS2rjardoUZKf/C4vLPVoldjunsKi/qRRc6+6f6ItbWJ29R+zaPv14XWuwGwo9wgoL/yJ/aqBFC7rVFg9pUMCumy+4ZosAk4H+e7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzIzSkEwellpT2pBeHM4K29oR0tLdTlGOFpHK2Q0YUxwN3FwOEJGT0NIYm12?=
 =?utf-8?B?NTN1YVdYVGJ0UmFUUE1pdVdRZVRGNkQvUzVoNi9WTkRLcXdmaDdzOXVNdlQ0?=
 =?utf-8?B?OUIxR2FzQ3QvZGFQZGFzZXpyRXNQdlhBZmZCTzBGQjdBbjZIdkpmNngrakdT?=
 =?utf-8?B?WElhMUhwNzlhb3hTRUE2YXZsc0tGZ1ZiUVVRemJwd1ZKYThwYW54clRzTlRj?=
 =?utf-8?B?eWhqZXoyL0laQzNFTXNEa0FhOGp0V3QxSTlybDgxZnU5aDI0NWpBTE1BMjgy?=
 =?utf-8?B?M3VDOVFhVEUvSDJhRW8rWXZoL3BRR0NDQTJLN0FDbm90c3BtbFVZNXVua3o0?=
 =?utf-8?B?SXNIR0FVK3hGUGhId0tOVHhvdU1jZFRpeGxpc3g5WElkS0N3aGE0ZUlIMWdZ?=
 =?utf-8?B?dEpqdTF0SHlRRmNoSjUrbkIvR0Uzck5DZHFyK01hZ0pXSUxsdDFQNEpNSmtK?=
 =?utf-8?B?djFvdHI4d1pPZHl0cXpIMDlsUFlaaUo5eWRrUXBiZFNueU9USzJVM0tOYU1O?=
 =?utf-8?B?R0RSdmFSb2IrZ1pVcFRnUFB0V3l0VzBxb1JBbDM2K2l6ZWJ2SnZlYnNkNTRw?=
 =?utf-8?B?U0dhN0c3Tkx6aTlyYjQ4WkV0eVp3M1ErVTJlTnl5RmNLWmdxN3gveEJDMVZm?=
 =?utf-8?B?b0R2b2xWMVJCYkI4S3k5Uy9xTHN1QncydG85U3dZZGQvNEJxZmhtb29YOFRK?=
 =?utf-8?B?a0VHRkRwL1JNdm9XM2NZK3dRTmZrNWlWL0JMKzlubHZXTVkrSWp0eE1pRThE?=
 =?utf-8?B?VkFxMDNXQ1FUZHJiSHlncld5czN4U0xyYS9OZGtKdUl3c1BMTVJlVUhIdXJR?=
 =?utf-8?B?VU81a09EVzIySVRXMEpCMmx1aktGakEvZGkxSmJPc2RDbDBmWFNIc3BGbmln?=
 =?utf-8?B?dmxhQVVxVDZrTUdjbjVaWWlUMEtMTTdLeHUrZGkySytLa0NtN3lDSjhpYm9B?=
 =?utf-8?B?akd3eFpGbkIwYm5zR2JFbWJGTlVpM3hoNzlrU0RIUzNteUc0c1A4Vmxncnp3?=
 =?utf-8?B?R2ZQb3BYb29jenFLblZCVkpRai9RMkNxRmZxaFkxWU9EZ3FYMUt4VFZ0OGsr?=
 =?utf-8?B?WHo0MjhobU1CNXR5c0VJSThncnBCYmVqcE9aNkUxRlI1Wm9kOEdER052MzF1?=
 =?utf-8?B?cFJ1V2tPWGFjRzdpSE8xZ3loVnZmTnJlbWNvMHhtVnZEWTBTVVB1MGlpdXRC?=
 =?utf-8?B?emlmNUlnNDZjRlkzUFYrOTVyQW9DcXpML3BnbGdMZVd3aGJieUF3YTdoMDhh?=
 =?utf-8?B?NSt1OStGT0Y4S205dUxQV3FyQUxLOHlhK1Z3WUtFdTFGQm8rb2p1d2cva082?=
 =?utf-8?B?anVQOHdCZUJ5VFBYTG1HNS8xbmN3WDhLOUJBNERpSk0rMlcwaHh6VmtmYk01?=
 =?utf-8?B?YTcrcVFIcFZhZGo2d0RpTFJPNVNScHRkQlNna28zb1c2cXFnbXp1cjZZZDBv?=
 =?utf-8?B?SHM1ajJQbm9FQnUvbHBjczVOYWEvdnNYMytrbXFpQm8zYnNuWXFCMS9IcTdJ?=
 =?utf-8?B?aXdvMWNoZC9qRHdHZGtqeEQxLzE5dnFFRzhiS3prZm13WWpTYXpGdEFFM3FX?=
 =?utf-8?B?ODhMSzZBTllDUWl5bGNZek5aWmJJUG9RVlc5T2dtQWlTQ0pJWWY0SmpLOXZI?=
 =?utf-8?B?VUJpT2NFK3FUdUNvVXVjdzBWUUIySlU4RlVVM2VZVlZDMjR1YldnUzVHUWdM?=
 =?utf-8?B?dG90RXRIOFV4aElWZ0NxNjR5bGpYYmdQL1plYXF6SDlUalkvOW42bTlJZWIy?=
 =?utf-8?B?ZGZnNGVHUm1JVGhYR1VIaGVkVmpxTHRNajBhTUFNa21lVkltbW9Qbkc2cDM5?=
 =?utf-8?B?dkFiL0RhVDY2VzdMTDBQV3VqVkd0MXpFeTdRY292dmVJL3ZsZnF5OWJjblJ3?=
 =?utf-8?B?Ylc5QlRscmF4a0VSTzdCMm1UckNCSmMwbm9weFFpY0dQdHNyaHdBZkh1clpJ?=
 =?utf-8?B?K3ovZ3ZzcGdBUGJKck1DYlpsQU1QKzlXRWZXUkdKcEF3L2tPYXBybFVxK0x5?=
 =?utf-8?B?WkZMWFdNbUJCTlpqckFaSllRVng4YlZ2NTNWQXNwVGlFYzJ6ZFBMWm12ZW8y?=
 =?utf-8?B?amxjYXgxVSt1Vk5NQTl0Q2swQ29PTlc5Z0VyTnNySkpZdWZJY29uMExtZTdM?=
 =?utf-8?B?dW1NR2NEYVl0V3U5elZnV3JuUmhucXJObWx3ZWpkSDZlN25QejJtUFVIeWwy?=
 =?utf-8?B?MXBpVVE2K3lUM0J2aFBhaVAwNDVHQU1qaTBQNWZyMmoxNkhUQ2t2eFRIeFlk?=
 =?utf-8?B?WkpDc0VmNFhaTXkyUHIvZXVYTXNlR1FUd1hULzN0c3NCR3k1SGpKRTJ0OE1Q?=
 =?utf-8?B?UEEwUWxuMWZNZTJlMWVYZ3JueGdtcDNPSTliRnNsOVZzR0p2N0dKUT09?=
X-Exchange-RoutingPolicyChecked: jMzJLa/uZDAwyXRujVmI0h/00OSjVmRyLR7xue7U5lStzmjl39Q4MOGWPgxdbYSU5K9E8EvpW+5iXBTxBoUqyw4uN4NYfBmCkD/0enR3MUid3WCGEYJOdmfTNIkIyrnL/s2/DH5XygEMIzeUkByTlNsdgdtBcgNXIqsF1G4AdKmFmLJ6aF6wozwm/vkUmSVj8O5kHWU4JKV+EJcLGPTHOZ3EajbZkYwqtgoEeHg6Yal4y4D3C4vYOKo1qcBRLWKczo2ptF6xby+YN+9LUJZTNBsxF51YRN9bOOZsE2NwYm6g9KFKztq0QOzDOPS9A7uudoDD9kZpC0pwa2Vto0z1rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 178de3ff-3b23-44f6-16e8-08dec6447659
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:30:48.0570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZGMAUzDai49xc3cxPksQeoL1gw0YE5Yk/XM/7bAT2OLzc3/YY3ZRaL6OcrswLesU5vypTebyMiWxjNYG54U3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
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

On Sat, May 23, 2026 at 07:48:49AM -0700, Linus Torvalds wrote:
> On Sat, May 23, 2026 at 1:29 AM Maarten Lankhorst <dev@lankhorst.se> wrote:
> >
> > Does it happen more frequently when loading VRAM intensive programs?
> 
> Well, "more frequently" is hard to say since it's happened twice, but
> this time it certainly happened when launching a new program.
> 
> This time it was a markdown viewer.
> 
> I wouldn't expect that to be particularly VRAM-intensive, but hey,
> since I run with two 6k monitors, I suspect *anything* with big
> windows will chew up a few hundred megs of VRAM just for the frame
> buffer side.
> 
> It's a B50 Pro, so it's a discrete card with 16GB on card.
> 
> I have no memory of what it might have been back a few months ago. But
> I would expect it to be all the usual stuff - ten terminals, a web
> browser with a dozen tabs, and whatever gnome and wayland do, and then
> the occasional random other thing.
> 
>              Linus

I’ve also intermittently seen kernel job timeouts during my development
over the last several months. It truly seems random—on some Linux builds
it happens somewhat frequently when running internal tests, while on
others it disappears, only to show up again in a different build.

I’ve also seen cases where a kernel timed-out job loops indefinitely,
though I haven’t investigated fixing that part. However, Rodrigo just
posted a series that should at least address that issue, allowing us to
focus on root-causing why kernel jobs are timing out in the first place.

Matt
