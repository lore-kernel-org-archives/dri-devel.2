Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C06C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBF410E378;
	Sat, 11 Jul 2026 13:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kuKf5MuJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9CC10E35B;
 Sat, 11 Jul 2026 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783777766; x=1815313766;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xBw8Wvi2cr/A64XQHrCQcIWWL3FnIJcGsP0dGSsoegA=;
 b=kuKf5MuJsVIicuHWYPdYAjtoQuajEPKZhpvIi4IPPjOUh+JqQ6sdeB/5
 brj3E6X1MhMxpfOzNaLAaTwutwjCBY3UjvGBN3ajSKY6X1n/mlcdMtnug
 x0mg+OujV5lLHN0ribRDwH4RJKiDXUJ9XqSPXDmcL0G8MJTQwn/EdK+WG
 TZf6LbdU3hUcmGp/ByjXOmpDnsw49s2nIFA36QWv5o1cUCcdjPfkKW4WS
 EVimgy6BfArfT3lkjmHJFg3PZL+6Ss/6RUGlDNjz/EDeNclF1+KGTWxZr
 kckcg2QSeJ83NOnPyfeIRZbU+597dpQj9Ag95y/lsExDs7Nt3e6OB2lfW A==;
X-CSE-ConnectionGUID: 0UunQTPFStuzGHmtjEDp7Q==
X-CSE-MsgGUID: zo/2z0qPTN2ZQogEFZ13fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71980739"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="71980739"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 06:49:25 -0700
X-CSE-ConnectionGUID: f8ODoE77Qh+2baDJUMvBbQ==
X-CSE-MsgGUID: IM380V/xQ1GnPiKmuKId1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254003342"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 06:49:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 06:49:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 06:49:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 06:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOI7BNAdf54ZcCwvZp+Pty7WFMzNc7c1eLpTqF04776/5Uq+H+v/uqsUPkFTcPaQXqpd2gXcuwYx32cdhMMpSVFTd7uaFB1Vt8s2iIi1QPK0SQi43i33UdMhZztkHe5qQ5+e841e2oAqQtJG+69SqxCr2M2BEqEyiruz1CCC86gYLBKccjFQjcLVZN5AWp4zNwJG6nFMh12hIa6bN5+/nGaFdH8/838q97+38She2DPm/6RKSXwiVF+Zi2fCnR1eMtt7LWZEzn/F9Aqgrv+xMYuLDNk38Pggz+h15a6rWRezRFz7eSdh4jG97apSBmJlW0Ie4aRC8q5EbfUtDQgjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBOrcf+isJUbTu2/pwxbXWRiptCZlWRbYjtUyDY2RkI=;
 b=kDUPINQcOkudq6tD2AWAskuEdispXa7Ml+QnbgRxwrxKy4k2KAS89NvmMAYm5B5OXjTfOy3qriaOyzaxL46Da/G7R0JY4i87ADAE6sPUDtH8LPon9Rsb2LzeqUUf4le8jjIDY+aiantUqo9YwveKDLFNW7idddmslvYXom0EFwwMqs5Awgxg/BNSUjYS9Gb+d8LFD7s1ZmneM1fw7Z4uo05q8+/60+wv4AtE+qu804LodsC+tWUJozJqkQEVkafqw2HQwGGc4Nl9cM/UoZJFrbnK8q0ZmyN7IDtU97gu5vWBljZvcTgOcbyydnnga89V9wZrYdfG1vLpQubR1h8fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 13:49:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 13:49:19 +0000
Date: Sat, 11 Jul 2026 06:49:16 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 "Huang Rui" <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2 00/33] drm/ttm, drm/xe: Minimize dma-resv hold times
 and defragment sub-optimally backed BOs
Message-ID: <alJJ3CensWXW+Wa7@gsse-cloud1.jf.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <971f7948-b241-46cc-980f-61df43af22bd@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <971f7948-b241-46cc-980f-61df43af22bd@amd.com>
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb0e994-410c-4009-c988-08dedf533485
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: zQ+JXAMDvf94z9HGzabDm+BnwC413ckNjleJU5EPLcpDrEm0d02hVKoYUdG42yqrRsJ25Sqx4YvVExZpyOmQ8/zrU7pLbVKHFQtkNPPedo3R9T2SN+Bnczn2Bwe3I6UnTG4rWqoZ0H6CRnDUbXnXcgIE7Ykv7nRGOMMmF0jEB0Gqcd/8N8de/RB/Xi/h/9cPWqWQyzUlJ/uA2VCwAwFSbVLKDkjOYv+iJQsr9ZtTMuOOWCcv9lI3FCI0SdnxFaIQ6b5oIsYM6XRVwh+kWxTdwe79B+dV7nKHbRMqfp1FCZeEPyGZkwnFiOAnKRL/FDh3E9MtE8SE217bWGW46aIsNpquUF3jxgUXGUrhip8e44yvF0WwDBo3LEG+RiBMGBT9HtpEBJTnVm4hoe3kkaiSG6x0VqIRTe3xld6Sa/OZAVU3z4C/G80EY9cPK9UtALYA0IjNdSyNResNuKWOOMxHOIGsWzLJriDiYLhJafl+x/uVp/kFxONU88RqKY37bNsG6HEpyG8ueNhAKJEDjgkT3wPb230B7aW1K4MNAm4U56WNbJqCvYI34pByFCB2vBodzlTxjQr5Z+GzOjmbZlBuT2SObGZ6NL/hfmGQviqbw2sAuPXLn3X0fMOoj9Z0tqGq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJxQmhJOTFoMUdrZ1M0aHl2SlhnYTdjbmFsN2phUlg5NzFFMUFxOTVsc05D?=
 =?utf-8?B?WkVtaE1yTWlWejZ6RldwUlYyQXcwYVRUbTlUQm1sT3NpZ0tCL0dvdFhuekho?=
 =?utf-8?B?NWFtb1k4ZXdEa1RrNnhKcEhhTE9QazlVWnFZV0VwVkh3NkVDUWV3Z2lhMzd2?=
 =?utf-8?B?Q1VNWU5YYmpETGNwQWU4aVNJT1VWbE9PTDRLY00vVVJZMHplcjJnenpVMVds?=
 =?utf-8?B?ZXJHUHVhbDI4QWVnYWhoS1J2a2pBKzRrK3RKM1NSakIvbjJhNVp0MitJR0NV?=
 =?utf-8?B?ZWxVRm5Cb2p2eVNTOU1jMFc5R2Zyblp3RDk3MlVoMS9uWGswNStwVVBqNFZV?=
 =?utf-8?B?Z2FTZzcyaFdYbGNRQmw1TjhjaVVwUHk1b1EzRSswRkFiMVA4VnFHVzQvNkhM?=
 =?utf-8?B?STJsQjJRLysrSHRXSE0zUkdYM0JwYVIrRzRJZFBVb2E0M3k4WGVIanVUMGRr?=
 =?utf-8?B?c092MlFaVEFRZUF4UWMwWU5ranpkUk43a2YxSUQrS0ZuVDFabFJ2L2RaNG9v?=
 =?utf-8?B?SDd5L1FHV29VMDB4bEpSNWp3VEZXTDM2WUNhQ0dCQWJ4b1EyNHdlTWlDbWxw?=
 =?utf-8?B?aUNtTDY1N0ZiejlXd1BuZFg0OGNxN0NkR3pmT3pEMTlMMEZ1TllYNGo0bHda?=
 =?utf-8?B?OE5kWlpvSk43YzU0KzlVMno4QSszSi9OS292Z2F1UWd3M2xFNCtKWjh1Q2Er?=
 =?utf-8?B?dEwrUURBUHNKR0UwRjBORGtGVVNIckJ2ZnNaUTRCVyt4ZlU3b0pIR3M3WTZC?=
 =?utf-8?B?TVloRDBSeXVFa1QremNaeHpJSVk2WmNsMlFTYVBkbVVpNVFTMGZnWmJ4WS9W?=
 =?utf-8?B?VUFyTm0xMWQ3U0tmRDZYeG1mdllTVVpYb2RFUEV6b01vb2haVUlPQ3l0SUJQ?=
 =?utf-8?B?TVlhdXFHZ3BCWjE4WnllWlBqSlhvZlluR0MyTjJCMVhHQmlIbFp6T1RaUWp6?=
 =?utf-8?B?MUswOWVoWUF1cExObVNOYnE5ejFkUkRYOFJCbUo3RkMyZ0tJeGdJSnpkWFVa?=
 =?utf-8?B?NWpqUjNPVmQwTDlVU2p1bzZFcnlPNlZuUFVUNzRwbDFqelJONDJQTk9hdU4z?=
 =?utf-8?B?SmFxZGNGenI1L2pLRjNoTVQ2ZjVKWEt1WVZVbVFmdHZwQW5qcHZhZEprL3Nz?=
 =?utf-8?B?WE5aOUJWRlh0dGhnZHRiaDJhN1U1VVRxblltSTduSEhKMXRoaFRtSmxSOVAy?=
 =?utf-8?B?M1JhTnBsL3RseElZSEJYY1BKdmhUbUk5amJxVTBuaEtoOUkvRVV1YjJCZGda?=
 =?utf-8?B?Z0lVUUZyKzlLblZQOU54b2o3UFFxdGZRSEFvV3R3RUpMclBmYUhnYk9NeU5E?=
 =?utf-8?B?aWVDOWhVekNpejlaRVduT3dsTTJaUVAxN2RGNGx5SDRxUjVBNXFya0grUFAx?=
 =?utf-8?B?NWdDRWZUQnBCN0s0cmpwTVBPbTdDTm9xUTNTQnQyK2JXcEg5NVRaR2tPa1d5?=
 =?utf-8?B?Rm95NVd6Mkk3dUhwTXZ0ZWNSd09Ubk5YZlRsRTF2U1dFMmZjTDI0bmx6djhE?=
 =?utf-8?B?QndTUnk2R241YVJMYzF4TzdRZ2NEVUl6SHRqMnVyTGt3dHpyNzVYd2hWU3lT?=
 =?utf-8?B?MC9KZUpTOGppcHJpeStJam1pNkJUWEJBdmlPbUZod3ZQeHZaT1NlTVNSS3lB?=
 =?utf-8?B?T3QyMG5va2M0RmtEdUhHUE8wSXFpZTRXemtHek5YdWkxdnVJU3NTVjBpNWxW?=
 =?utf-8?B?M0JYNE0xaDdSbU1xemxRQTVieHYyc0kxRWdWQngrUjl2OEt6ODhJYzRRWEo3?=
 =?utf-8?B?YXdYVG1iYXZNY0JQekVWeTExdEdXY1gvY0hHdzZHT1NMYUtRS3ZOb0lJZVVC?=
 =?utf-8?B?SDU1TUdUazB0RUMycHBGRXk3bU5oemhVVUVqY093VmQ3b0pFSkFmb0tWSGlv?=
 =?utf-8?B?L3lzdTJNZktQMzlkWlNpcXUzSnJGanVqM0xCZjZWY1F5bDIyaEkwajJrV3lF?=
 =?utf-8?B?cEJVeXlPeEgwMDlTTkNURXZqT21zWENSY0pFTDRLdVMwVzNVZmd2UStpTEtu?=
 =?utf-8?B?dzBlWm8xYU5UNnpISTVaZVBKMHRCUnZKRmZMZDBMVTlsejlIWVBueDVvanlX?=
 =?utf-8?B?ZnhjVnE3UUdLLzlGVFNUTnVod0lEekRkVXZTZGlTdEtxQnZCRExNTTJGKzlv?=
 =?utf-8?B?NXo1MDFDeFd3UHZ5ZzRYMWxhL2N6eHZndzdKRG50b2hNY0JsMzBoR0pXQ3NJ?=
 =?utf-8?B?dUsxek1KSEdJUTQvYUkrQWZGMGdrcjQ0NHBQV2ZwVUlIQlhCZG5TUzFmRE8v?=
 =?utf-8?B?RmF4TVN0c2M2Qm1ZNVVjU2YzbGYyNHVUSTBOYjkwM0pmRFV6WE1SVzhGZnpu?=
 =?utf-8?B?cFNOT0ZVclJxQ2YvRzk4SWx5TTBsQlJwWVF2MGlnQVlhVkpKSUsxdz09?=
X-Exchange-RoutingPolicyChecked: n7dSWTrxxjJvmRjCW6yx5ZinaybCcRRTPoC5DYpugOXG3y0fjHn3iWmHkcXAr1VI3IgBvENZIGezNan0x5+uYX3oqb+d6FWTJb1AhkgMKU5zOt+7yoDW+79BmXheviZ7FKxaVRZI3cX9Ke3aQRlR7Rpx0/kVXcZ+NSI0Sv3F559tC5ViQFqJ094eNrbG36gcGeUuricp+uMzBnzx5/Y5Oq4eNp34xdrDa4AdN0nKRPRWQG5Or+Th5Y2y5rVWw1Q/kpSz766rYhtgy+Wm0PSzF/s8cWTHhvivY94KHBm/uuQ5LGFTfNEnBUDTP5RYE8aupEQLeRfqY7BFulTSLmRO0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0e994-410c-4009-c988-08dedf533485
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 13:49:19.0854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yq2qgeRbTAiFFC2JQLBYtR5GuxznA1Rn7NfUjOo4AC77gInEXv0aA6+ZwyiT5RB7r1u37VuZ9RU7FVyxQTodFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
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

On Sat, Jul 11, 2026 at 12:33:20PM +0200, Christian König wrote:
> On 7/10/26 23:54, Matthew Brost wrote:
> > The overarching goal of this series is to keep user-facing IOCTLs snappy
> > by holding the BO dma-resv lock for the shortest possible time, and to
> > push the expensive, best-effort work - page (re)allocation, DMA mapping
> > and placement fixups - into the background or out of the locked critical
> > section entirely.
> > 
> > Two related mechanisms fall out of that goal:
> > 
> >  - Out-of-lock backing. Page allocation and DMA mapping are the dominant
> >    cost of gem_create and of BO moves, and doing them under the dma-resv
> >    lock serializes otherwise-independent clients.
> 
> Saying that doesn't make sense.
> 
> The DMA-resv lock is either per BO or per VM and so the clients are not even remotely independent of that lock.
> 

s/clients/threads:

Same VM:

Thread A - allocate memory under VM's dma-resv, takes a very long time
Thread B - tries to submit, blocks on Thread A

> >    This series preallocates
> >    the backing pages (and, where applicable, builds the DMA/IOVA mapping)
> >    outside the lock, then transfers the result into the BO under a brief
> >    lock hold. The user gets a fast IOCTL return; the heavy lifting happens
> >    without contending the reservation.
> 
> Ok, that sounds like a really bad idea.
> 
> Why in the world would you do this? The dma_resv lock is exactly what is used to prevent something like that.
> 

Allocating pages from the core MM subsystem does not really have anything to do
with dma_resv. Moving pages attached to a BO, however, is related to dma_resv,
and that is where TTM comes into play.

The TL;DR is that a defragmenter does not work well when page allocations are
performed while holding the dma_resv lock. During the v1 implementation, I
quickly noticed that the dma_resv lock could be held for up to 100 ms in the
worst case, and more typically for 5–10 ms. When the frame budget at 60 Hz is
only 16 ms, this is obviously a problem, and it becomes even more problematic at
higher refresh rates.

After quite a bit of work, the common-case lock hold time is now below 100 µs,
while the worst case is under 1 ms. At that point, a defragmenter becomes much
more viable.

I'm applying the same defragmentation logic to IOCTLs. Why hold the lock any
longer than necessary and introduce additional pipeline stalls?

> > 
> >  - Page defragmentation. A BO allocated under memory pressure keeps its
> >    scattered, sub-optimally-ordered backing for its entire lifetime,
> >    costing TLB efficiency forever. TTM grows the plumbing to track
> >    order-failure and to re-back a populated BO in place at the beneficial
> >    order, and Xe wires up a background delayed worker that promotes such
> >    BOs on the GPU once memory is available again - again, off the hot
> >    path and without stalling the submitting thread.
> 
> That could be quite beneficial, but so far falling back to low order allocation was only seen as last resort to avoid OOM.
> 

Right now, the situation is effectively "once placed badly, forever placed
badly."

Matt

> Regards,
> Christian.
> 
> > 
> > Since v1 [1] the series has grown considerably. The bulk of the new
> > material is a direct result of profiling: once the defragmenter was in
> > place, the remaining dma-resv hold times and the per-BO
> > allocation/mapping costs showed up clearly, which motivated the
> > out-of-lock preallocation, the IOVA-based mapping path, and the amdgpu
> > counterpart. Rather than land the defragmenter alone, v2 folds in these
> > optimizations since they share the same infrastructure and the same
> > "hold dma-resv briefly, fix up in the background" architecture.
> > 
> > The series is organized in sections rather than described patch by patch:
> > 
> >  - Patches 1-10 (drm/ttm): core TTM preparation - order-failure tracking,
> >    the defragmentation move, reclaim backoff, and out-of-lock page
> >    preallocation plumbing.
> >  - Patches 11-14: other dependent drm/gpusvm and drm/xe patches this
> >    series builds on (DMA-mapping accounting, per-order DMA stats, async
> >    L2 flush, and a VM-teardown ordering fix).
> >  - Patches 15-23 (drm/xe): the page defragmenter itself - BO tracking,
> >    the on-GPU defrag copy, xe_bo_move() handling, and the background
> >    worker with its stats and configuration.
> >  - Patches 24-25 (drm/xe): out-of-lock system BO backing preallocation
> >    in gem_create, moving page allocation out of the dma-resv lock.
> >  - Patches 26-32 (drm/xe): IOVA-based DMA mapping optimizations, building
> >    and finalizing the mapping outside the lock.
> >  - Patch 33 (drm/amdgpu): the equivalent out-of-lock system BO
> >    preallocation for amdgpu, exercising the shared TTM plumbing.
> > 
> > Testing
> > =======
> > 
> >  - 3D benchmarks on Ubuntu and on Android, with memory intentionally
> >    fragmented by a separate program at launch (plus beneficial-order
> >    error injection). BOs are initially backed at a sub-optimal order and
> >    scores start lower; the background defrag worker then promotes the
> >    backing to the beneficial order and scores climb back in line with the
> >    unfragmented baseline.
> >  - IGT:
> >    https://patchwork.freedesktop.org/patch/739052/?series=170046&rev=2
> > 
> > Matt
> > 
> > [1] https://patchwork.freedesktop.org/series/169053/
> > 
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> > 
> > 
> > Matthew Brost (31):
> >   drm/ttm/pool: Allow backing off reclaim at the beneficial order
> >   drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
> >   drm/ttm: Record sub-optimal page order allocations in ttm_tt
> >   drm/ttm: Introduce ttm_pool_alloc_iter for __ttm_pool_alloc()
> >   drm/ttm: Support defragmentation moves
> >   drm/ttm: Add fault injection for beneficial-order allocation failures
> >   drm/ttm: Harvest beneficial-order pages on defragmentation moves
> >   drm/ttm: Bound page (re)allocation per defragmentation move
> >   drm/ttm: Preallocate beneficial-order defrag pages outside the lock
> >   drm/ttm: Add full out-of-lock preallocation for ttm_pool_alloc()
> >   drm/xe: Flush L2 asynchronously in xe_bo_trigger_rebind()
> >   drm/xe: Destroy page tables after unlinking all VMAs on VM close
> >   drm/xe: Track BOs backed at a sub-optimal page order
> >   drm/xe: Back off beneficial-order reclaim under defrag pressure
> >   drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies
> >   drm/xe: Handle defrag moves in xe_bo_move()
> >   drm/xe: Skip self-copies for borrowed pages on defrag moves
> >   drm/xe: Add a page defragmentation worker
> >   drm/xe: Add defrag GT stats
> >   drm/xe: Add Kconfig.profile options for BO defrag configuration
> >   drm/xe: Defrag using out-of-lock page preallocation
> >   drm/xe: Add defrag profiling tracepoints
> >   drm/xe: Preallocate system BO backing outside the dma-resv lock
> >   drm/xe: Add tracepoint for xe_gem_create_ioctl
> >   drm/xe: Add IOVA-based xe_res_cursor variant
> >   drm/xe: Use IOVA-based DMA mapping for eligible tt BOs
> >   drm/xe: Add per-device dependency scheduler for IOVA defrag finalize
> >   drm/xe: Add packed copy-step IOVA mapping for defrag
> >   drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies
> >   drm/xe: Finalize defrag-IOVA moves with post-copy job
> >   drm/amdgpu: Preallocate system BO pages outside the reservation lock
> > 
> > Thomas Hellström (2):
> >   drm/gpusvm: Add a DMA-mapping accounting callback
> >   drm/xe: Add debugfs stats for DMA-mapped pages per order
> > 
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   45 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |    5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    4 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   39 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    3 +
> >  drivers/gpu/drm/drm_gpusvm.c                  |   17 +-
> >  drivers/gpu/drm/ttm/ttm_bo.c                  |  101 +-
> >  drivers/gpu/drm/ttm/ttm_bo_util.c             |   21 +-
> >  drivers/gpu/drm/ttm/ttm_pool.c                |  931 +++++++++-
> >  drivers/gpu/drm/ttm/ttm_tt.c                  |   67 +
> >  drivers/gpu/drm/xe/Kconfig.profile            |   40 +
> >  drivers/gpu/drm/xe/tests/xe_bo.c              |    8 +-
> >  drivers/gpu/drm/xe/tests/xe_dma_buf.c         |    2 +-
> >  drivers/gpu/drm/xe/tests/xe_migrate.c         |   12 +-
> >  drivers/gpu/drm/xe/xe_bo.c                    | 1632 ++++++++++++++++-
> >  drivers/gpu/drm/xe/xe_bo.h                    |   15 +-
> >  drivers/gpu/drm/xe/xe_bo_types.h              |    6 +
> >  drivers/gpu/drm/xe/xe_debugfs.c               |   26 +
> >  drivers/gpu/drm/xe/xe_device.c                |   35 +
> >  drivers/gpu/drm/xe/xe_device_types.h          |   57 +
> >  drivers/gpu/drm/xe/xe_dma_buf.c               |    2 +-
> >  drivers/gpu/drm/xe/xe_ggtt.c                  |    2 +-
> >  drivers/gpu/drm/xe/xe_gt_stats.c              |    5 +
> >  drivers/gpu/drm/xe/xe_gt_stats_types.h        |   17 +
> >  drivers/gpu/drm/xe/xe_migrate.c               |  531 +++++-
> >  drivers/gpu/drm/xe/xe_migrate.h               |   17 +
> >  drivers/gpu/drm/xe/xe_pt.c                    |    2 +-
> >  drivers/gpu/drm/xe/xe_res_cursor.h            |   56 +-
> >  drivers/gpu/drm/xe/xe_svm.c                   |   36 +-
> >  drivers/gpu/drm/xe/xe_svm.h                   |    3 +-
> >  drivers/gpu/drm/xe/xe_trace_bo.h              |   90 +
> >  drivers/gpu/drm/xe/xe_userptr.c               |   55 +
> >  drivers/gpu/drm/xe/xe_userptr.h               |    1 +
> >  drivers/gpu/drm/xe/xe_vm.c                    |  149 +-
> >  drivers/gpu/drm/xe/xe_vm.h                    |    5 +
> >  include/drm/drm_gpusvm.h                      |   19 +
> >  include/drm/ttm/ttm_bo.h                      |   64 +
> >  include/drm/ttm/ttm_pool.h                    |   46 +
> >  include/drm/ttm/ttm_tt.h                      |   43 +-
> >  42 files changed, 4029 insertions(+), 189 deletions(-)
> > 
> 
