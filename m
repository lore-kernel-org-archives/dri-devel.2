Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36571076370
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD3810ED98;
	Wed,  1 Apr 2026 05:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kXNlbUAf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6D010ED68;
 Wed,  1 Apr 2026 05:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775022325; x=1806558325;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=34pwvAiMGN9PbMbhBQc2d03mzcUde1QBXDG1PtaQ64Y=;
 b=kXNlbUAf7F+ofEUf+3C0SL7/vjlvTgF5/00MVzVS6THYRdUYo9UhU3EL
 1FZhmuKt2V7Iu6a0Dz/eCVs2VtstkNiDx4eFhmvrR+o3yzyFtYOakTfjv
 ELYvhXuheHI9xn34NWRsBEe8935o+T4TsoM0bPuyJovDzds0/rOTbJtgz
 /2y/7iVdz7ovzgzAmWWzr6Huu1lO1WuZUwUUVk4KFTzoRP2PgWTWs8Svz
 LxqtD0GvsEdGJrXGBcdCMyIW4mW/U5ZRywzKL8dBOsTU1Bhgy9yd4Cpbg
 MAyhgr7I7rMXnmpf6OTypky7uHPHETC+rQmDSOnsBxm1dM5DMYAi7993D A==;
X-CSE-ConnectionGUID: SjwO8tFTT0mzaBWGLWIsHg==
X-CSE-MsgGUID: RVL1KHs4R+qqVRxb0pUhWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87442749"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="87442749"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 22:45:24 -0700
X-CSE-ConnectionGUID: 8lOWKKEdSSySYwqglbDAtg==
X-CSE-MsgGUID: qQ5wQTOdQfOVU34U0DU2qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="226818999"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 22:45:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:45:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:45:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxigHQnfuUhalcFH8FBaj7VCKHG0CRI6TlL82izDSaknXtv97G35MkKA/VkmID2YWlbtVch4kbDJ/DRk+Ww7t1xJhMVXTroyNTu/N26wEnszEbcrcdTW4D3bbhYIH2BqIseFFYb0d5H1QNkFpT/9KSkYDDzv7i5c6LfrdAoHYpL3FI4R19UGGQnGfbJ/+jp2YV7d5uhfSI6qs2JLvQuyp6dX/iHDZNCIk6wHMQ8lyBLdFw8YLDZrmfr1yaxS4xoRrz5kGIuSALApyx9EGOLgdUW2FKlo1ojESbTB0Wjk6o3tKYs2iraEp6moHNL6TzGQHywy5m2npLvoBDHsst1GwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riOJrj/KPXFnR8LdJbC39ESNWvFK/5ujB+Vg9VIQsVo=;
 b=RFI3A6GWnSpvEnsOvCR5uETf6fDyKBuAaBSQttQQrYWyK39QhFtNBXvA3KycFJlQ7ztj3B0TN2S/K8m1eKDcA8fe3VE3G0TPhp816XyFcDz6KzdfjOkBPLTm4iZ32gzuwGLeGDyxJlZl+HUbufiIYOaHoZemKzy0myZB3ik4EesOAbGRpD0FpG9/Emn05dP/jtbVCSgLmK6RGcyJc7E8JhcYEDgiD62aCvT38RDGqYQ/yUYPvU/uNGcTK9x0iNk8OwK6Dc3qxkpsmoiXf/sR9I1a+OMAKWVyuPc5LJdmvZ4oxlmcY7KnTvSqc/iYIvYbm4ekAt6jvg2SQad/xR2QQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by PH8PR11MB6778.namprd11.prod.outlook.com
 (2603:10b6:510:1c9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 05:45:19 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::7d7d:9999:506a:6b14]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::7d7d:9999:506a:6b14%5]) with mapi id 15.20.9587.017; Wed, 1 Apr 2026
 05:45:19 +0000
Message-ID: <df870f67-6bf8-4448-a830-092a75c9f9a6@intel.com>
Date: Wed, 1 Apr 2026 11:15:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpusvm: Reject VMAs with VM_IO or VM_PFNMAP when
 creating SVM ranges
To: Matthew Brost <matthew.brost@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>
References: <20260325231608.25581-1-matthew.brost@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260325231608.25581-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::17) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|PH8PR11MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dec54cc-8d01-43b6-69d8-08de8fb1db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 4dy0kQJ7zSPA1R1cOc9rL1H3merGWGPrJhbveR9GB7Vwl1phgWlA+OwxeIeoTu5Kdqh4JBdX0dFWUKvJJAS9O+SJtugK8xgnRFYz0ILVuneDX6GOL0sAkpxQwXBtOLw/rLmqVxE08N2mz4F96ohiaXy7epEe6YSnghktJ40I2BNraAENOEm8NHb5tPiIiUr2fwD9EBL7R6cfRs/xTtzN7grQ38IejRSYTJjLo1Y5xwLFEe1gYmdJSlA3a4WU0PLVYLmJx6evuKuHOnQYmp2zJEAhU0bypv2wFyFKXYNp8hzSHMWLpOx9W3mxgPO9Le/jUDd51wWTQkUY4hSVv3X6gqrwOPq3kQM3+u3WA1+HWJugV0nKDUdhX++7vjBtxNL5jmuAuBrsGESabCAAp8xZjfzehKafS5ZFF50rLIL+HNFFU8qP30oXQUjNeGRm9VrA8HZw4/XzW3RwSJNig6EYnRIfn4yYQVUGd7lhADZ2WGyPA6mmIR9yQnNXy7D16FhL8hOUmflfH+mLolztIzLvPGwqvxMIQp97EG1pFr1gLCaK5eQbGBDAHKl2Wy1m/m1Y0X36GM7RV1yQo0J0vPHMpQMxWmxRUJGpo1BMuLCXEmAcmb+EVrABtVl6YZalnDWdvl583hr7iYufuKTArXSSjUxSNPG3QjfRCnCc/bL7Srj1Xv4cTfn8Ad/xqVD8fDGzPAtO+OLt7LQ/9m3pFBfDwDsnDo4mOGGwuCUiGDybN0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF691668CDD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUk2bmtGcFpZQkxhZUJBSzltQjBPTnpLTTdnT1ZNSjVUdFN0MmU1aHpNSi9L?=
 =?utf-8?B?UEs4RUZxeXlnb1pZeVdjU1JHSWlHbUlkUFNtQ2pmYnBlNVoyWXNPNS9weWg5?=
 =?utf-8?B?Y3doTkFHbWNOaWhMczFMTW9oNFNlMmNUelpqSU1mRnB6WGVKWlIzSC92VWNi?=
 =?utf-8?B?TDJ6bkswTjBSdTRsTHZ6ZlFKZUlJUGJTTjVWTzlVNFJSNnIreitWcmp3S1JK?=
 =?utf-8?B?OTBuR3hDdW5qMU5HMHdvOFJvM0hmQ1FlWjNnQUYxa2lGN3JNOWhwN0VxM0hx?=
 =?utf-8?B?Wndncnl6OE9BcWNOMUo3ajF3U2pDT1lTb0RFN3FJNXllNlgxMWl5bU1sK1ZU?=
 =?utf-8?B?UkR0bGl6eHRnMDNycVd4aEtaTGdReGNSbWpjYjZpTEhWWjNkazFPVlRpRkUz?=
 =?utf-8?B?N2I4NllielBHREplTC82ckk4N3FhRWExQlp1bmJOT3NKZmVJMnNZbEtmL0Jz?=
 =?utf-8?B?U3NwV3REZ1VFZE90bFJNeDBPK0Q2a3JiYmJUVGdjZjBBbWJzNUU3NWhHMWpr?=
 =?utf-8?B?Y3d4eURZV2pZdFRyTmZnNkZUMkhWOFVuRmk4Z3laMTVDNDZVSlNpUjlxYWpp?=
 =?utf-8?B?ZUcwTFZpNlIrNlJHWlBWSFVEaGxqdmRzbkpCYnJqUnRGL1JlYkhoT2M2dHZx?=
 =?utf-8?B?UU5lUGhkNlBYOU5hMGxsQ2lwRWdaR3NpSWNVTjcxWlZpcFlUOUJ4TDBicWYr?=
 =?utf-8?B?eU9RL1RsRHd6akNxMTNkbzV2UWFBcWF4MXNGZDRzbnFiYjh6K2xITUJKYWdi?=
 =?utf-8?B?dEtjUzErc1gra2huVjhHQ2cwZUNYZ2lRenQ4Unhrb2swdWdTSVNxMUJyV1JM?=
 =?utf-8?B?dVM1cUw2SDBrZ2dVeDJyUmVKUE1jQmREWU13dUNuRlBhSkMvdXdjaG1zYlIv?=
 =?utf-8?B?aDllR05rV01DUUFoQWFHMUR3R1FTR01TTENGT29yM0hWblpSUW01WGZod3pq?=
 =?utf-8?B?MlhXVGZOelh4bFdmQU9pN3FjZWdreXVjUjJSR01lK2pYOWY3c3JGSHZmRllK?=
 =?utf-8?B?TWtkQ25peFVrMzJ1REE4WllDU0w4dFpTdWYxL1lPTzF2WjJ2Vkg3VDdrSVFm?=
 =?utf-8?B?OGdnVmg1WUpSOUx3ZFpvSXFrTXJLaDZ1RW45SUY5TXg3OXk3QlFSVXh6STlH?=
 =?utf-8?B?SHpqUXFhQWp5d3BRUWNqWE1CazNJUFNKaHpHczVEdkJwdkZBUER2b015UUtE?=
 =?utf-8?B?c1FQMjUzTFBROXZnWG9TQzhTTkV3N3N1d3d1amxWUDI3aE1Vb1BGU1FMUjdD?=
 =?utf-8?B?N25UWVNHTTFFcVU0eXB4ZTRFYW5iUkZaNzhOTDBNcURrWE5CaXlXVWMxREx4?=
 =?utf-8?B?RjdKV2NPK1FNd3JLSEN0Ky9ObFJqL2NOZk1vNFdKQTdjeEhwRGM4NHFlYWta?=
 =?utf-8?B?bGtBUlZqekZSWk42cDJVM0EwNlNrNDN1eTdxMGZodnI5U3hEMzVCcEtwNzVS?=
 =?utf-8?B?dXFreWpiZWhnQ1lHUFlIWHhWNEVFdEVaWnU2ZTBjeXEwb1JERHZOTzUyU1hs?=
 =?utf-8?B?WFdXL0Y3clQvUlBlSWJHQ1hMT1dId2hYVmd2OEorWmlVUjFIMnpzM296bnhn?=
 =?utf-8?B?MUNuSitxeUxuZG81dlc5bVJicUo5UEZ2SWhFN1BoUUtiaWJZSVRva3JjZEJL?=
 =?utf-8?B?S0dsM2NjODZKeGNyZVNFUlROQjk1NDRHMHhGdm1JMXJxYWU1NEp2YmJPelAv?=
 =?utf-8?B?ZU95NmRhc1dSbTB0UXZIMmdHQkE2WWZxeFV5ZzRKNlNtTmhoNHZ2aTRHczZN?=
 =?utf-8?B?V3JtMVhhV09jVEUzVWMxZmpNVzh3emN5M2dDSWtTbTNzakNtM3l3YWU4N0Nq?=
 =?utf-8?B?UTJvWFl0TXNXQ2VEd21hYnlxeGE0cTdBdmlmV0hyaHZiekVpNDZXNXErRlFp?=
 =?utf-8?B?RmtUYzgyZ3daWnA2akR5Nk53UzJ5c2tnNnAyVXBJS0JzOHU2ek9tT09sRTRy?=
 =?utf-8?B?bEhQN3lZVy9LSC9JZlZFOWdXU3h5NGJSbklFZ29PUU1EL0oyYklXUUdEQlBH?=
 =?utf-8?B?QmRIVGRCTXN0dnJzaWJvSmUrSTM3TmlRZnZOeGIvSWU5eVJ2czMvYTN4ZStC?=
 =?utf-8?B?eUxsKzhrUVZWNFhiOG5vOHMrRktiM1B5ZXZSb2ExY0Y0UThIaDdSN3JRMXo1?=
 =?utf-8?B?S1Y4Tm85QWUrOXd0eVl5VVdnNDliOGpkOEVCUWVtZlcwSG1FR25xcGkzUXNk?=
 =?utf-8?B?QTVmU1FmM0w1ME9ycTVIbmY4Y3pGVVlzMkh4bmJxdXd4VzJtQWxXaVppMW1u?=
 =?utf-8?B?cS9JVGlObWdxUU1KSHdpdUJPeHRsMHRCZ0E0Q041UnRVN1NQektrSVRvL0sz?=
 =?utf-8?B?eHpGV2JJb2xOM29Ma3RGbFY3UFp5QkNhU3hjQ1BjUDZEUVpIbFZ3b2JnQTRa?=
 =?utf-8?Q?eA9CrTKYOlyoZr58=3D?=
X-Exchange-RoutingPolicyChecked: eNHNj75+Iqnf0R4MFjU/dTMtHfLWSFG12TNVbHHnoDvpH2RT8W4oEpk0tepJHcLWDdKB5Lu1Q4X8VxFXYsJ2hKK8Nm/7tBEEGShF9bncPnRY3FeyLJqvs/xK29sfJtmlHfG/vyDWvI5YI1PkS85pa+DFvYzpWuSZqLQpWcvwKTMEo7bM7HgUy7xW8dqXpvflWR2aAfNty6RdJAx5Uzw11n8d04skFlw6F2hz2HqK87UNZH5AhirtW7uTuyjVqVukbIjprK4XPjPU+96ExDaGjqr9mA6ByMPT5xwoVmFXCn3zuIlSdBk+kklSSY1SkT2v6WC+TvOoaBAvLNInBPQNaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dec54cc-8d01-43b6-69d8-08de8fb1db99
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:45:19.3260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8FdKOAeO0t4cMhGaOwPf4yfdp2Mt6cJIun083DzcamYudhACt/TjWEmrvaVNSNlMqWb4khGspsNX9Ip9im5bwuToeYPoKcoJyJadCPD1r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6778
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



On 26-03-2026 04:46, Matthew Brost wrote:
> VMAs marked with VM_IO or VM_PFNMAP are not backed by struct page
> objects, which GPUSVM requires in order to operate correctly. In
> particular, get_pages() relies on hmm_range_fault() to resolve struct
> pages for the target range.
> 
> Attempting to create an SVM range on such VMAs results in repeated
> get_pages() failures and can lead to an infinite loop inside a driver’s
> page‑fault handler. Prevent this by rejecting ranges on VM_IO or
> VM_PFNMAP VMAs and returning -EIO.
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

LGTM.
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

> ---
>   drivers/gpu/drm/drm_gpusvm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 4b928fda5b12..7993e85c0566 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1065,6 +1065,11 @@ drm_gpusvm_range_find_or_insert(struct drm_gpusvm *gpusvm,
>   		goto err_notifier_remove;
>   	}
>   
> +	if (vas->vm_flags & (VM_IO | VM_PFNMAP)) {
> +		err = -EIO;
> +		goto err_notifier_remove;
> +	}
> +
>   	range = drm_gpusvm_range_find(notifier, fault_addr, fault_addr + 1);
>   	if (range)
>   		goto out_mmunlock;

