Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD47CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9AB10E42D;
	Wed, 10 Jun 2026 04:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ybac3d9L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0673210E42D;
 Wed, 10 Jun 2026 04:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781065072; x=1812601072;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Fgz/TgvUCPL5RFC+YX0VbOxwbVFkoCOTNk/IV5S2cBA=;
 b=Ybac3d9LSEom+4HHUzEwNaT8DFvdiuGAcEU5ww5D3GLHuWt6zEWy5PSR
 AbuYmaOg0uaIGtDPH29sZ5SYl9xVpRU7LCFMOjAdl2iE8wechRPrxmC1f
 f3tZ6f4w8y1NJ64uljfptF4NTZ6+CHYLS6Cy7Mb+fVviuMj0N8bOvRwOy
 rVdNmdzVvDed3Jzn6DzoTqQZAXmh60av1lrLixfOpMeSnW2EGTQIC+QUN
 XfqO5wc1t6Kx3U/OPeC7dKECtwTTtiOQYeJLW57ZUp8Gydy/Nx6oSGc3J
 h+ccx9FWi9jru0VpFF04rJQKZ4rWSPVQdJqVMNBQG+w0CuOSRAFiMBrbF g==;
X-CSE-ConnectionGUID: FkttX3LzTeKc/JLfRyS67w==
X-CSE-MsgGUID: QrJsrmzgQoic++8ivx9uiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92522233"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="92522233"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:17:51 -0700
X-CSE-ConnectionGUID: TW/Rb4adQMmodVkMx0y44w==
X-CSE-MsgGUID: 9NeTGoELSai9xMUvZydDnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="244914025"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:17:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:17:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 21:17:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7J9KGDXyh6ZWYxlYqHl0Yk5W0VSs7AHzjTqFB3b4CY65FA/27ys/B5fpoImXfShZvh0tCX4qwHsxgxmc44aAAHJoB8av6z/rmKZHGp2wDrLqtFIAoplp+WAOGLprlilIz4D8pM4PRl/OU7J6nmo4e+iz16tpEw/7uESFsa4YPxeDy8qzj3jfzzg4Ch907xtWuSWZh6rGj87ZumX1dtA601WKnrYakFVa1KruR44FeUBR3EpN/UM/J1bDzeLQ6okbvlBWUbrI/lAKf02is/8SzookI5qb+LxTHEOdyCaxAJ4sSZT3VmUnKp+kRIVWBuZbT4CJQ/aFCd6qgc5bWtxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4QSPovkshEd5bdoxw/aMyCPJTo1iLrqZUz5rjZFDVU=;
 b=p2VENesuyc/pZ+JRDudv0wfui3WVh5qOjfxUIya8JNvwEijLMv8WNRdUKnXOm5Cx25Wx//IHz2sRdryqc3NXqfPAqdJUeTU4EX85cdmoXl5VhZzh5lc+LOGfiT6rV94347G281/vQKRmuOHwxKeM+7yYeZoEkdJRywWtN7wqj2lLaBaHgUnz0FcYorg9BHTd6N1DFf28aDyogC1TpMrBrT2shpJuVid3+mC9HiTLveJp46QeHBbn2rfRCHR9dczGDGAjHaVAsFsWMrgfDgDhWKwlOGmqqMSBE+6p7eBgnM9uyotGYcAhwURI+qetgn00FuBvaTbIEJYVXZ4ySnDwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SAVPR11MB9576.namprd11.prod.outlook.com (2603:10b6:806:4e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 04:17:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 04:17:42 +0000
Date: Tue, 9 Jun 2026 21:17:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of struct
 drm_gpusvm_range
Message-ID: <aijlYhfsvhxNUxja@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-5-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603065620.2555316-5-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SAVPR11MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce3b02e-c6ef-4a3e-b361-08dec6a73716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5qJlkNVPbWOI7eO7xP0YRbyDrD9mFNGUd5lV6FBhxUStS1MQrOz5l8zGXPDtWFjFBKt3MWZIGfGAIOfmVrvQ5Qescw1Vp9/TVmtH82If6pQgMvWtOuGzKjqsnFEt9nHngV6We/F5cohQpvoLPlPSiIF2K95QjgqHlTM2qpF/wPhyzshY+8nubaM+E4IZAly9xqsA+FyNf5ra2NGypbl/DLHGKMQ6KP+UUpEotWYga7A0wmBzFgrGzfVeZMc1kMPFFriQTmgvihDrJEycp/NTud2aZjrsaJqSssgc+kC8+GYaOJuA1bZh5ebMklHETEeywE5Kbmr5cKoXmRlxqBK3l3MxDr06Pf8bE038iCX5djhs6i8ISmKNKnnH6o9s5K15fgkBO3sk1rtVHZ8XA+JGToBzXTFGmUdPSySGLabxd5AF16OwvWpya2GL5BQkgFYx99KEQwDQMt9hvepV+yneIwobzGfrGBccSZC/N4IdGfZbElsJALOsFx/l1ePib68sjh2hT1t6+n16zMik90Km8pf615cEoLRl2Xj9mKuj+4if/TIPPfpzNoOs3xCcc3cZEVcD66GG45Yqyrjy/lcj+nzGfh3Gld7L1k/mpGLt24mApxcjD8BITSDeoFr1cpRRxybyiU2qUgkQoEs6yprNFp5KmnwXa1MrqGvKBJRTmjJeF5ft1ycuCI8JGqg4vCSA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hnNDlSMm5RSHY3OUYxUGtaVTFoVXNqUUljSjJ5dE9uTXRvUzJQWTdVeWo1?=
 =?utf-8?B?TkpBbXBxSjNWOTNGMEdGRWhYRGF2RURaelp0ZzUwYVpGVU1LblgzTDBJTEhU?=
 =?utf-8?B?R1hoa0M3cXZxbFI1ME9uU3lQV3VuT3FQZWk5aVdYdHc1RUpIS25nT1hGNnN0?=
 =?utf-8?B?NHpwTk9VOXp5NDhRNEV1alA1NnVVbkxkNks2ZXVNeHN1SHNsSmdIVUNPT1U1?=
 =?utf-8?B?dkM1OHp5ZTlBdko2aHBqS2RVZC9haXJLUmdQbHdsRzNZTWZyb2l4WFBGL1V2?=
 =?utf-8?B?Tng3M0JUN1QwMGg5YkpGaHhtR0tLVmhQTEIvc0M4bnQ4TnBFUDNaSWhyRDNs?=
 =?utf-8?B?bTZPcU9YRXM5L3RML28rd3NmaENPdkg5YVAvZ3dLQU9JblZHZS9wVW1HMkZy?=
 =?utf-8?B?UGNaL0tXU2dEemVnRFhQK3M4YmpqSFd1SWlhME5ab1VLeWxpNUM1WUdNTjli?=
 =?utf-8?B?eDVtci94UTB3eEQxTVBWTkROUzdWdG93QUVlZVpvdTRBdFZGNFdsV3FzeXlm?=
 =?utf-8?B?S0dBbzZTdHY3dWU5d1VNczBCVHZGMExXTGRTbEo0bEpZcTB5NmhwRm44VHE3?=
 =?utf-8?B?TjhtbVRmYS8yaHNZSFVLNTBUNnRFK0E3TDlIRjN2UTVyZzJVaG1WT1VOR0x6?=
 =?utf-8?B?OTJwWWhWaU1TelZsUmtLT3NVT0dmc0s4N1dtSmRZNzJnRS9SOGhOZk5wQWJV?=
 =?utf-8?B?cm9PTGllV1Bza3AxdGlYQlZLdWtiVDdyQmNlK0xkTHh5VjZnSG5FeHJoZkU0?=
 =?utf-8?B?WXdlajZFUS9zUjA1NEpQdDVwUURUUUorNUpJalhYVWp5TlBMU3FuM2pWUi9O?=
 =?utf-8?B?MUwrQktZNno0QVdMKzZ1TGljY1RobEF2bk1pSzJHay9YaTMzb25hVHg1VStW?=
 =?utf-8?B?NXFZVHhYWjZhUmhVMjArM016aFlmU0hnV0lWWGxxcHU1Z3FrelQwUFArTmpV?=
 =?utf-8?B?alFzS0pJbGR2cmFpbmRhUmhReEVBMG5waUM2WTgyK2Y5SVYxWXV0SXRCTWsz?=
 =?utf-8?B?WmlOQzcwa0ljS3ZCQXUwRWZ3MDJHYUdkNkcrcm5KWkdnTC92NTNkWHFtL3Yv?=
 =?utf-8?B?TFBoRzlIbUkzcWZhbHQvalUrUm10Kys2c01Wa2tuNFZqbWFLTjd1RlExR0xS?=
 =?utf-8?B?c0FlLy9LVnE1T1BlMkZLWjc4TjBVMXdWMkh3SW9CSFVPb0VJZnJXTk1la1hP?=
 =?utf-8?B?UUtoVWZpSEZPTTAxQmlUdndER0JGelZsTlh2RkZZeFVPOG1RTEFIUEJSSXRF?=
 =?utf-8?B?c25mTTFVVEJNd2NwUks0ZUNlbVFFUHBIVUd1c2ltRnU4S3FPa3ozeFNFdjRG?=
 =?utf-8?B?MUVxZnhyd1FDdGRyUjBmdkQvZ3ZRWU5BVGZwWXNoRVpLMGVrQzFjWWVVQVZ4?=
 =?utf-8?B?YW1RMFRSaU52U1FSNHRrQXZLZjVaejB0dG45aVdBYkJ4aGRnYmNKblJUbnFj?=
 =?utf-8?B?YThINVg1cGl0alBsenpoV1NJT01GeGZkWHNIQjN1Nm9EUUttMm00c21mdC9L?=
 =?utf-8?B?VU1aUVB5MHZqSlJjN2VjV0V2QWdNRC9xWFVOcEFNUHc2RlhpYVNXMU9nRDNy?=
 =?utf-8?B?Y3F2TldTK2U2SmlqS05hcUlMMXIxQmdKcW00NGxyenNiMzdaR09CUzBYSExt?=
 =?utf-8?B?OSt3NTZlSGw0cFAzelBSaDlHeFNEY2pGSkNZcVBoL1BQQVpZTW1maHJOMm03?=
 =?utf-8?B?S3VmLzEwUDl2dm5VRmpzeGZDbnRkT2xFSTFZNVpvVEFPY2grMERyalEyRTdw?=
 =?utf-8?B?OWVXN1cxclRxc0l2VFUxZVJJVk53VXlkeXhkNHFLK3AzRjBZSkFnYTNoVS9y?=
 =?utf-8?B?YVRMcjhSMklUeXE2S091amQzTXRpWmd0LzI2ekNpR1owa0JCcGx6S2RZalVa?=
 =?utf-8?B?WWNnYU1aaHRwa09BRGxnbkdkSjJpTDFLdHRIcENFUWhNS3VUaUV2UitCNHBG?=
 =?utf-8?B?UDk3Q1lBR0pOTlAzK2l2dnBVRlJCYk5rTTFXbjVLdk5Tb09hWWJtc2UxbnRn?=
 =?utf-8?B?MFVTZSt4M1BQRFRsNUpLOFVFZUNCdWhLVWRNbHUvWWZFT1JXTWNBUDN1cklw?=
 =?utf-8?B?VTl1S0NkOXJYWXoxMzBjdUNKYWsvdE4zUHRmdDgzZEEvbVAyMEdmOWxKVzNB?=
 =?utf-8?B?cVFlMmJBUVc0b0d3TXNWaUJoS2w1a3U3aytjRjlQSHlDakl2ZTR4bFBhY0Mr?=
 =?utf-8?B?RDA0VWR2bzAzdzd5dDgvaks2aGZvWXhwMkVoT3Iva0dYM1ZmZjlmVnM4ZW5Z?=
 =?utf-8?B?dkUwK2pFU2M0L2U2K2hiU1AzZVhWbkovbC90OVhjdURkSWZFZzE3YUlGUVM5?=
 =?utf-8?B?Q1BVdHVXUlN1ZmYvYnpIRitEbjdrUmR5c1VPQVdsVGt0RWpKK3l3dz09?=
X-Exchange-RoutingPolicyChecked: WW9in2l+8bXPpUej+R2QGuobt6cDlg/mZdAnM2K5KACByWmGVJK0zHHelKleKOBK88EkHffV1Ol4wSbFCju4xm4QNBTxBlLOUqDjFBwg9/dhG6NrzV0dtFJvezJnxl18g7nwL3xyZV4BuvlACX2G4CYTkeV9cjjF2ks9bX6GXjxro1zQSg0YM6/UfImQiREo4KlwoY1bAhupYEAkdQ5wyA9aixGqZSB2+fbFsiTSKR1Q5Y3YUyXC/e9bD+R1ELhnA7cRFcNCL4Ip7g1FrYRB1C7O4/GaY1n8c6KYMhZ/W2/gkuhXXnI3yIV9Vk8AiP9aixmQtjkBLSFJAt9ZyMCVbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce3b02e-c6ef-4a3e-b361-08dec6a73716
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:17:42.0499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZRTqE7qQ2BE2CE6tPi0I92hR50OU/RhUh7L/NRN0jnZaBujnD/mowbDeOC17eLAQypATz3FFN15weoz9PkLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9576
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

On Wed, Jun 03, 2026 at 02:56:19PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Since the pages the physical pages and MM VA range has been abstractly
> separated. Unbinding a single form of physical page from the MM VA
> range, brings flexibility to the drm gpu SVM framework, transfer the
> way of management of MM and device physical pages to the driver layer.
> 
> framework's range embedded pages object and its range level wrappers
> have no users left. Remove the following:
> 
>   - Drop pages in drm_gpusvm_range.
>   - Drop drm_gpusvm_range_pages_valid(), drm_gpusvm_range_get_pages()
>     and drm_gpusvm_range_unmap_pages(); drivers should use the
>     drm_gpusvm_pages helpers (drm_gpusvm_pages_valid,
>     drm_gpusvm_get_pages, drm_gpusvm_unmap_pages) directly on a
>     pages object they own.
>   - Drop the notifier_seq seeding in drm_gpusvm_range_alloc();
>     drivers initialise notifier_seq on their own pages object.
> 

The patch looks good, but I think the kernel documentation at the top of
drm_gpusvm.c should be updated—particularly the examples. It may also be
worth updating the section explaining how pages are embedded in
driver-side ranges, including the options for one-to-one or many-to-one
mappings and the implications of each choice.

Matt 

> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 68 ------------------------------------
>  include/drm/drm_gpusvm.h     | 13 -------
>  2 files changed, 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index a4b56cefeb2..55515390c53 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -640,7 +640,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>  	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
>  	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>  	INIT_LIST_HEAD(&range->entry);
> -	range->pages.notifier_seq = LONG_MAX;
>  	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>  
>  	return range;
> @@ -1329,27 +1328,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  
> -/**
> - * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - *
> - * This function determines if a GPU SVM range pages are valid. Expected be
> - * called holding gpusvm->notifier_lock and as the last step before committing a
> - * GPU binding. This is akin to a notifier seqno check in the HMM documentation
> - * but due to wider notifiers (i.e., notifiers which span multiple ranges) this
> - * function is required for finer grained checking (i.e., per range) if pages
> - * are valid.
> - *
> - * Return: True if GPU SVM range has valid pages, False otherwise
> - */
> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range)
> -{
> -	return drm_gpusvm_pages_valid(gpusvm, &range->pages);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
> -
>  /**
>   * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1633,29 +1611,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
>  
> -/**
> - * drm_gpusvm_range_get_pages() - Get pages for a GPU SVM range
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - * @ctx: GPU SVM context
> - *
> - * This function gets pages for a GPU SVM range and ensures they are mapped for
> - * DMA access.
> - *
> - * Return: 0 on success, negative error code on failure.
> - */
> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
> -			       struct drm_gpusvm_range *range,
> -			       const struct drm_gpusvm_ctx *ctx)
> -{
> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->drm,
> -				    gpusvm->mm,
> -				    &range->notifier->notifier,
> -				    drm_gpusvm_range_start(range),
> -				    drm_gpusvm_range_end(range), ctx);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_get_pages);
> -
>  /**
>   * drm_gpusvm_unmap_pages() - Unmap GPU svm pages
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1686,29 +1641,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);
>  
> -/**
> - * drm_gpusvm_range_unmap_pages() - Unmap pages associated with a GPU SVM range
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - * @ctx: GPU SVM context
> - *
> - * This function unmaps pages associated with a GPU SVM range. If @in_notifier
> - * is set, it is assumed that gpusvm->notifier_lock is held in write mode; if it
> - * is clear, it acquires gpusvm->notifier_lock in read mode. Must be called on
> - * each GPU SVM range attached to notifier in gpusvm->ops->invalidate for IOMMU
> - * security model.
> - */
> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range,
> -				  const struct drm_gpusvm_ctx *ctx)
> -{
> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
> -					       drm_gpusvm_range_end(range));
> -
> -	return drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages, ctx);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_unmap_pages);
> -
>  /**
>   * drm_gpusvm_range_evict() - Evict GPU SVM range
>   * @gpusvm: Pointer to the GPU SVM structure
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 21baf91ec7e..250c59f0930 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -173,7 +173,6 @@ struct drm_gpusvm_range_flags {
>   * @refcount: Reference count for the range
>   * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>   * @entry: List entry to fast interval tree traversal
> - * @pages: The pages for this range.
>   * @flags: Flags for range see &struct drm_gpusvm_range_flags
>   *
>   * This structure represents a GPU SVM range used for tracking memory ranges
> @@ -185,7 +184,6 @@ struct drm_gpusvm_range {
>  	struct kref refcount;
>  	struct interval_tree_node itree;
>  	struct list_head entry;
> -	struct drm_gpusvm_pages pages;
>  	struct drm_gpusvm_range_flags flags;
>  };
>  
> @@ -303,20 +301,9 @@ drm_gpusvm_range_get(struct drm_gpusvm_range *range);
>  
>  void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>  
> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range);
> -
>  bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>  			    struct drm_gpusvm_pages *svm_pages);
>  
> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
> -			       struct drm_gpusvm_range *range,
> -			       const struct drm_gpusvm_ctx *ctx);
> -
> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range,
> -				  const struct drm_gpusvm_ctx *ctx);
> -
>  bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
>  			    unsigned long end);
>  
> -- 
> 2.34.1
> 
