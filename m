Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1520C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6AD210F288;
	Fri, 28 Aug 2026 07:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fHJoGF8i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E8D10F281;
 Fri, 28 Aug 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787901436; x=1819437436;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vnncwcmWTG3vRagBXAkwrTPKuGM0uTtRa8t8EMJyxZU=;
 b=fHJoGF8iMl0EYrqB22Y8cFvjG752P3XVydq+r8vcW7KwHv1Ipuxnk59L
 s3CbAmurXIoBtTO/leG2dQyy+THUoLKp6UPYjhLE4NpuiCpAKQL9a69eL
 Ot8CgWncSlVyxZ3JkRlPxAli8VBoRZRjCldTO3cob1nlzvMmjfasBWL6/
 vzaf8nsdUURJmBlNDwXD9UXi/LyvVpFLElF4SabuOW28LSxi2AsHNo2VK
 rWGrQ4j7e8mFP4PjD0baqSpn8kiJiisbI6kemdaZ973Ai0/lO9cIrQjXY
 ISxeCThsrebmnfFyH1Q2dl0fv0FF8J4NEw3kkILId5ANW3d2KSohse9iX w==;
X-CSE-ConnectionGUID: 0gPpSYH3Qiq3Suq/23gC8A==
X-CSE-MsgGUID: 9kmpoG2GTGOSYP0UaBYhAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92221314"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="92221314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 00:17:15 -0700
X-CSE-ConnectionGUID: 21eW1KzHQZKDQ9IicCYIEQ==
X-CSE-MsgGUID: aoMB3FA1Q7CF1tbSonJozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="266777570"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 00:17:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 00:17:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 00:17:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 00:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHMmri3B7WUufgw5c6kHqeWC1NZzfkV2K7TjWdcjUJDpcx/PK2ztoUGhQM5KM87GBw4uCD0sGZbVwN8vBtNqJEExxvzB2bpStu1TJC8F4lhboB0tt+2RioCeu/Z02otcE3/IpJfzjrv9xDydVNAha+CBa9qNJKUev0zrUY4gyjG24epSFkUAoOTHqlfvOJb+sXXUs0N7+QHBTfKoh1jkImkKqFdqq/qV8WtGfJjPx6ZWgHH59zwaqayzzvce3oyAkx1rkkzEF71hxDBXnFsPfQiXr0rJpydR8QFJcdrxzB9QFsLKAxyWr/Hh4UXcE9ZoZcBa3UBgxUjMB4vsUvv2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lsb0PpWSt44nvYAlCO/GAPRTAUeqwx4Y6eFMB+rdTA=;
 b=K1J+7hfGI7V5jrVTu2pPbv3sZwpb1uqQG82Xr4xTwuM1JDNGCOxomKemXwhMq+t0MBnQi6OSKCtfCS93swVyUZDBPx2gy8by0D0W1qwVMtdGm9C0I0/+DRbb0x9N87FHTknig4TGXciQ3HnQTQrMRUFBTuaspGcN3m4EWtIKyWOtgTisopDr7fTCnIhg+zaZPXwp42frSd2patHB2ucuyAcaMnsVrKcTOCV9Q/OwpfxvXuo3LNnGCz+eXl//ILHpvb3Ht/Sj4sSbA9+g+J/iXBJR9kK8blihh25hUTv6bqapzg9C0/RbjV5U13W2nUk8bNfeQq3nydhTXq4uVRSfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 07:17:07 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 07:17:07 +0000
Date: Fri, 28 Aug 2026 00:17:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] drm: Add common drm_user_fence helper
Message-ID: <apE17lJZmTD4+5jR@gsse-cloud1.jf.intel.com>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
 <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b99e098-25cc-48f3-ed60-08df04d45e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: OKge/HJVcUHLqYnYexRjJMmIbPS9vpqymBnV2R+nSBTchTwlAPlPz++onp6lWTMj2AVIWvbH9KgZTW2E+wVmqazzVVu1X2Hzpm2dlVwq6lnk6lJQhIOnBMoH0CwB0skWYkGd+4nRC3aGGrD5zihyNT5PsTrsjxQ3NSAJfF1h6ixEJaGIk8k5lirRbHR2z/yENRYuYU6sSmo8jOgh7s4MVPWE2nbyyMo1umdfoTfsc9HwAeuGKeLnXW/J7rkHRrWSl61e+iGiwfdOHY6pmTviTSvOB3kvO2GS1qGTd+Fv9T+Fpy7zie+Si4Df1o/KPIjGiMzW3eOMkamNkk+7yA1mNZFIAqcBlgfJh9tCRBOGWacnDypjv3nGlyQacl+DjZSRCymwtKinZIZKRbrX6cOr3Qg1RRejIMbQ95/38uBgxZRsI5zQnbpgcJlmpIL36tC/v7+JkuLT1jBpqqVYJUZCUGlBGMDk7HMyEL8IqAkU2nYOdfVecRsij2nbSr3jqVwbqbbmdghdVm1EQdWOMrbGOzDlrsBhhDqQ6Lt9hTdB0e2L9pIZVWkRxnFTnZNcsD91/Ygsk0X8xNjJ/lA557DYxNKDWN5WXR/MWjMu2f5E5mddr+V8LeMEa8j4PiwN68O0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RFY1ArWE1mRFZ1U3ZZSStRZDN2NytpaG11TlBPQUlsQ3VRRUh4Slo4aTlZ?=
 =?utf-8?B?Z3p4SkJNZUVqeFNiU08rSXgxTzhyOHBiODU3ZkFlMGVWRGRrRGtSamtCYmlB?=
 =?utf-8?B?OEpoMUZ1alFIK0pvU1IrMzNJY2dYRi9jQ1FZYS83ZDVmdlBwRko3TjdOTXdF?=
 =?utf-8?B?cmgyc09HaTg0SWd4Z2M3amIyR1lybkZLWTZSa3U3cks0Q1o5T0hQSFYycmxN?=
 =?utf-8?B?UHlwOEhmbmp2NE04R2t1OFhNdnp3NnppYW1UY0NOQmZEYmFhbUZsU2YrNlgy?=
 =?utf-8?B?dXROVGVmM1lPUVR3VFVLS1JSekpNVUJwZzU2dHh0VUwyYTB3WmEzZml2TEhp?=
 =?utf-8?B?UmFmSldMT2hMUHlFb2k5NENGK3UwUldod01QQ29rV1E0QUNuQzM0TDF1TEVV?=
 =?utf-8?B?WXc1WVJWY3dNTzhCOHY5QTlhdVdUV2JES2x5TlhJaERvMEYxVzBCNjZhWFdE?=
 =?utf-8?B?SmpSajUramVrN0hLUS9VWENPUjNhMktqZ2xISlg3N1hKUGpzT0lNejIxR2xP?=
 =?utf-8?B?dG95Mm9Cd0NmNHk4N2orQk1aL05oWjJzRW1Rcis3UnZFakIwbHh4eEp4M3NG?=
 =?utf-8?B?RnMxVWE4OTZCZW10QzcxSlZtcDNVT0hJWGx1azRUSE1mcGd6aFlYeUlGVFFC?=
 =?utf-8?B?dHRyK0FGYWdFMlhOL0NkWnNXSzB5SGRuSTZpM1NmaWc4TWo1TXNqUXo5SGlH?=
 =?utf-8?B?Sk5wMENCVmJKUE1YVndSaUpPS3UrRm4wNXo5bnRpWXdKODJaQlRGTWlEQ3VW?=
 =?utf-8?B?WGVjWWk0Y1dGVk51WC9wZUMrUUsreVU2MGdzS0ZlOWRNL29BaHI2MGpHUyty?=
 =?utf-8?B?ZC84SjNHeGNXb3RJUVNrYlNJZEh4Y2hoSmdWTklkWXdyQzRob3Buc2E1SkRS?=
 =?utf-8?B?ekVMc0lQUlZhQUpXODFNTm1Mazk2VXNLcXVhUkc4UGhZbHJnTFRTNGJka0lJ?=
 =?utf-8?B?Q3NYNG5IRlFlZEFuS3NQbFI4TUgxZUhnNWxzVG5xVk5nbktSbTZrWEJLRkdT?=
 =?utf-8?B?WGVOblJRWnoxNVVwcHlKa0JwU3VGZ3Y2VEpCYlhyMEJzdGVza2V0WVFXWlBC?=
 =?utf-8?B?VkdNdGkzM3d2NFMycXA1Q0tQMFV5dnhNK0N5Mzc3OURPNjNPOUZkM1gwN00v?=
 =?utf-8?B?ejJqYUE2blBxYUFON3pJNURiVWZhWi9yNEFGNEFKa016MERqSkRkekVXZUln?=
 =?utf-8?B?ZjAvOTFKcUM3TEQwdlpmKzVjd25FSGp4RzRiY0tvcm0rbzRwSktacGlxTEU5?=
 =?utf-8?B?REU4VEZGQ1V6V3kxb2ZqZVk5ZU5zYVhjOTRuMU5sZ3JQUVRkeEw5azQycFlM?=
 =?utf-8?B?Z0cyVUJBNWl2cEJ0S25YUUhObW0xeGlsRG9DUkorVk5pVGl0TTQwZWNJaTM3?=
 =?utf-8?B?RkowZjU0V0ZKN0hkQlhTS3pWSXREa2RaZ1BrWDFmcW81NGdsV1YvdzdqNDU5?=
 =?utf-8?B?WHQxRWhESTZrdEhuTURSK3pZOFQ3cEExeWgzZXFJVEM1aXFxbkdkR2ZpbFVx?=
 =?utf-8?B?eE15ZHVraWZrZ2UxOXY2ZUoyTXpJdlAzOENNS3pJdGtYSmdJWDFvdk1ZWUpU?=
 =?utf-8?B?Zk1OdzFOVXFXSmVOWnVzN0JSVW5vNW13WHpWSTdRdkRQd1A5dmlWNm4zV3Fs?=
 =?utf-8?B?dldsMEJmZ0JEOXNjQTA4djk4NFN4WnhOaEZSWm5sOEc1WU5kdHpUSXFHN2tj?=
 =?utf-8?B?WkxMWHRIeFZJUGxvVFdoTkFyQkVLalgzOFE1RDVDWityUTFaYUlONTR0VnhC?=
 =?utf-8?B?bUpkckZIS2F0SFNpNmc0Tm5iV2FYWWJoQ1hCclp6ZFQ4SmNKM0VnK2cwcVdk?=
 =?utf-8?B?NWpHenpPazRNMS9UNGRlRi9JTjV6Vit1Q0E3MmNjbFI5NFc2RGg4WVZUN0hw?=
 =?utf-8?B?MzRqN0xVcVFXQ2ZZei9pTlNWU2RTL3FqOVJXTW5Wcms5amZ4bW80SUYzY0cz?=
 =?utf-8?B?MWsrZmhwdmRrWUZPcy9lZjBPWldhTUc4d1lvMjVUM0tIM3Y3K2pZdUpSNUlX?=
 =?utf-8?B?enQ4NVZ2RnMyME9nak12d2RPZ3RFV0F5R2Z5VFhHR1ArcitPSk5MeGhqK0Ra?=
 =?utf-8?B?MkJnUzRIemxuSm00MFdNVjdSUVFNSms2cUl0NjUrRmJvNzRoWEJJK1VCbGEw?=
 =?utf-8?B?UUNzbDNXVk1FdjM1bWZvVjRNWlFjbUhFNkY3a3NYalhoSC93RVBRa1ZFR01N?=
 =?utf-8?B?bTNIUmo0aFJSSEpwM09QOGdweVJiTmlDS3RzaThUdElnRnJ2QjkyYnFiQko3?=
 =?utf-8?B?QU1seGc5cVM2RFZVdDR3UDd2ai9TL2hra0JmR25kRE5yU2hIK0wvMnNzQ20v?=
 =?utf-8?B?UnRaQ1JtNXkzUkdkb3Z6U3c2YWVBeXVkN2RSWkVNdUpHNXJDWHpkVHlLL2VO?=
 =?utf-8?Q?68pmiutkiLg12rsI=3D?=
X-Exchange-RoutingPolicyChecked: EKHJtyn8fYsOhLeSNb7IDu0fix6ynDvEXqtgZMGfed8nU/iptDCmo+dtX+F0n5c19sp3Jv7bK1LE3py9rJoX/9tROU7OQVLCZm2AEpU4H5B3GahkI2Q2ZZeWsfiTT7ihqqUTrtbmd79XfFoirbq6j8qCTbEYnQpCmLmwn1YwAv+UVY8cvrR+0LMajpXA1r/VqK29mWznl+wyvTvkJn1ev6PaRZ96egb0Tu4rW1adl+n1JkPIU2I7n1f5y0KuaqBJl6sp3rxV6rJ+9mYP//BpEkYcqPS7t1bxQSygjlMCivINVeoCLUX1hCnRYSwQe7I42q99QT/mzPt6vPULLztRDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b99e098-25cc-48f3-ed60-08df04d45e14
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:17:07.1279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+zkfGe5X+mcB9+am4CKIL7nFM+MpDRKVvBkzu4s8rcp46lN9sqSE3KQSuKqSePCCPi6Ud8DS6lXoGwxkasGNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
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

On Fri, Aug 28, 2026 at 12:01:02PM +0530, Srinivasan Shanmugam wrote:
> Introduce a common DRM user fence helper providing the kref-managed,
> MM-borrowing dma-fence-callback-to-workqueue pattern used by drivers
> that must access userspace memory from a kthread context when a GPU
> fence signals.
> 
> XE uses this pattern (xe_sync.c) to write a fence completion value
> to a userspace VA. AMDGPU will use the same pattern to signal a
> per-queue eventfd from a user-queue EOP fence callback.
> 
> The helper provides:
>  - struct drm_user_fence: embeddable base structure
>  - struct drm_user_fence_ops: worker/destroy callbacks
>  - drm_user_fence_init(): initialize and grab the process MM
>  - drm_user_fence_get/put(): reference counting
>  - drm_user_fence_add_callback(): attach to a dma-fence
> 
> The worker callback receives a bool indicating whether the process
> MM was successfully obtained, allowing drivers to handle the
> unavailable-MM case (log, skip the userspace write, etc.) without
> duplicating the mmget/kthread_use_mm/mmput boilerplate.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Matthew Brost <matthew.brost@intel.com>

First off, I'm supportive of the idea of a common DRM layer for user
fences and updating Xe accordingly.

This isn't a complete review, but here's a quick initial suggestion.

Also, by the way, you're still fighting our CI [1]. Feel free to keep
hammering on it, as that's what it's there for. iirc if kunit fails as
in this case, nothing else will run. Ask AI and should be able to get
instructions on how to build our kunit + run it (it doesn't require
Intel hardware in a lot of cases).

[1] https://patchwork.freedesktop.org/series/172930/

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-kernel@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v4:
>  - Check cancel_work_sync() return value in drm_user_fence_cancel_sync()
>    and call drm_user_fence_put() if work was dequeued, fixing a memory
>    leak of the drm_user_fence, mm_struct and stored dma_fence when a
>    pending work item is cancelled. (Sashiko review)
> 
>  drivers/gpu/drm/Makefile         |   1 +
>  drivers/gpu/drm/drm_user_fence.c | 223 +++++++++++++++++++++++++++++++
>  include/drm/drm_user_fence.h     |  76 +++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_user_fence.c
>  create mode 100644 include/drm/drm_user_fence.h
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..52de1f474535 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -69,6 +69,7 @@ drm-y := \
>  	drm_syncobj.o \
>  	drm_sysfs.o \
>  	drm_trace_points.o \
> +	drm_user_fence.o \
>  	drm_vblank.o \
>  	drm_vblank_work.o \
>  	drm_vma_manager.o \
> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
> new file mode 100644
> index 000000000000..cdc47d092cbb
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2024 The Linux Foundation
> + *
> + * Common DRM user fence helper.
> + *
> + * When a GPU dma-fence signals, drivers often need to write a value to a
> + * userspace VA or notify userspace via an eventfd. Both operations require
> + * a valid process MM, which is not available in IRQ context.
> + *
> + * This helper queues a work item on fence signal. The work item borrows the
> + * process MM via kthread_use_mm() and calls ops->worker(), which the driver
> + * implements to perform the actual userspace access.
> + */
> +
> +#include <linux/kthread.h>
> +#include <linux/sched/mm.h>
> +#include <linux/workqueue.h>
> +
> +#include <drm/drm_user_fence.h>
> +
> +static void drm_user_fence_destroy(struct kref *kref)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(kref, struct drm_user_fence, refcount);
> +
> +	/* Release the extra reference stored for cancel() */
> +	if (ufence->fence)
> +		dma_fence_put(ufence->fence);
> +
> +	mmdrop(ufence->mm);
> +	ufence->ops->destroy(ufence);
> +}
> +
> +/**
> + * drm_user_fence_get - Acquire a reference to a user fence
> + * @ufence: user fence
> + */
> +void drm_user_fence_get(struct drm_user_fence *ufence)
> +{
> +	kref_get(&ufence->refcount);
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_get);
> +
> +/**
> + * drm_user_fence_put - Release a reference to a user fence
> + * @ufence: user fence
> + */
> +void drm_user_fence_put(struct drm_user_fence *ufence)
> +{
> +	kref_put(&ufence->refcount, drm_user_fence_destroy);
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_put);
> +
> +static void drm_user_fence_work(struct work_struct *w)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(w, struct drm_user_fence, work);
> +	bool mm_ok = false;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		kthread_use_mm(ufence->mm);
> +		mm_ok = true;
> +	}
> +
> +	ufence->ops->worker(ufence, mm_ok);
> +
> +	if (mm_ok) {
> +		kthread_unuse_mm(ufence->mm);
> +		mmput(ufence->mm);
> +	}
> +
> +	drm_user_fence_put(ufence);
> +}
> +
> +static void drm_user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(cb, struct drm_user_fence, cb);
> +
> +	queue_work(ufence->wq, &ufence->work);
> +	/*
> +	 * Put the transferred reference from add_callback. The stored
> +	 * reference in ufence->fence is released in drm_user_fence_destroy().
> +	 */
> +	dma_fence_put(fence);
> +}
> +
> +/**
> + * drm_user_fence_init - Initialize a user fence
> + * @ufence: user fence to initialize
> + * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
> + * @ops: driver operations
> + *
> + * Must be called from process context with a valid current->mm.
> + * Grabs a reference to current->mm via mmgrab().
> + */
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops)
> +{
> +	kref_init(&ufence->refcount);
> +	ufence->mm = current->mm;
> +	mmgrab(ufence->mm);
> +	ufence->wq = wq;
> +	ufence->ops = ops;
> +	ufence->fence = NULL;
> +	INIT_WORK(&ufence->work, drm_user_fence_work);
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_init);
> +
> +/**
> + * drm_user_fence_add_callback - Attach a user fence to a dma-fence
> + * @ufence: user fence
> + * @fence: dma-fence to watch; ownership of this reference is transferred
> + *         to the callback — caller must NOT put it afterward.
> + *
> + * When @fence signals, a work item is queued that calls ops->worker() with
> + * the process MM active. If @fence has already signaled the work item is
> + * queued immediately.
> + *
> + * An additional reference to @fence is stored internally in @ufence to
> + * allow drm_user_fence_cancel() to be called safely without the caller
> + * needing to hold a separate fence reference.
> + *
> + * On any return value the caller's fence reference is consumed.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int drm_user_fence_add_callback(struct drm_user_fence *ufence,
> +				struct dma_fence *fence)
> +{
> +	int err;
> +
> +	drm_user_fence_get(ufence);
> +
> +	/* Extra ref stored for cancel() — lives until drm_user_fence_destroy() */
> +	ufence->fence = dma_fence_get(fence);
> +
> +	err = dma_fence_add_callback(fence, &ufence->cb, drm_user_fence_cb);
> +	if (err == -ENOENT) {
> +		/* fence already signaled — queue work and release transferred ref */
> +		queue_work(ufence->wq, &ufence->work);
> +		dma_fence_put(fence);
> +		err = 0;
> +	} else if (err) {
> +		dma_fence_put(ufence->fence);
> +		ufence->fence = NULL;
> +		drm_user_fence_put(ufence);
> +		dma_fence_put(fence);
> +	}
> +	/* on success: transferred ref goes to drm_user_fence_cb */
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_add_callback);
> +
> +/**
> + * drm_user_fence_cancel - Cancel a pending user fence callback
> + * @ufence: user fence
> + *
> + * Attempts to remove the pending callback before driver context teardown.
> + * Must be called before the driver tears down its workqueue or ops.
> + * The caller must hold a reference to @ufence across this call.
> + *
> + * If the callback has already fired this returns false and no additional
> + * action is needed — the callback handles its own reference.
> + *
> + * If removal succeeds the callback reference is released internally.
> + * The caller must still release its own separate reference via
> + * drm_user_fence_put() when done with the object.
> + *
> + * This function is safe to call from atomic context as it only acquires
> + * the dma-fence spinlock internally. If the caller also needs to wait
> + * for the worker to finish, use drm_user_fence_cancel_sync() instead,
> + * which may sleep.
> + *
> + * Return: true if callback was removed, false if it had already fired.
> + */
> +bool drm_user_fence_cancel(struct drm_user_fence *ufence)
> +{
> +	struct dma_fence *fence = ufence->fence;
> +
> +	if (!fence)
> +		return false;
> +
> +	if (dma_fence_remove_callback(fence, &ufence->cb)) {
> +		/*
> +		 * Callback will not fire — release the transferred reference
> +		 * that would have been put by drm_user_fence_cb(). The stored
> +		 * reference in ufence->fence is released in destroy().
> +		 */
> +		dma_fence_put(fence);
> +		drm_user_fence_put(ufence);
> +		return true;
> +	}
> +
> +	/* Callback already fired — it handled its own cleanup */
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_cancel);
> +
> +/**
> + * drm_user_fence_cancel_sync - Cancel callback and wait for worker to finish
> + * @ufence: user fence
> + *
> + * Calls drm_user_fence_cancel() then cancel_work_sync() to guarantee
> + * the worker has fully completed before returning.
> + *
> + * This function may sleep. Must not be called from atomic or interrupt
> + * context. Use drm_user_fence_cancel() instead when sleeping is not
> + * allowed.
> + *
> + * Drivers must call this during teardown before freeing any resources
> + * accessed by ops->worker().
> + */
> +void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
> +{
> +	drm_user_fence_cancel(ufence);
> +	if (cancel_work_sync(&ufence->work))
> +		drm_user_fence_put(ufence);
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_cancel_sync);
> diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
> new file mode 100644
> index 000000000000..02a02266ab93
> --- /dev/null
> +++ b/include/drm/drm_user_fence.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2024 The Linux Foundation
> + */
> +
> +#ifndef __DRM_USER_FENCE_H__
> +#define __DRM_USER_FENCE_H__
> +
> +#include <linux/dma-fence.h>
> +#include <linux/kref.h>
> +#include <linux/workqueue.h>
> +
> +struct drm_user_fence;
> +
> +/**
> + * struct drm_user_fence_ops - driver callbacks for a DRM user fence
> + */
> +struct drm_user_fence_ops {
> +	/**
> +	 * @worker: Called from workqueue context.
> +	 *
> +	 * If @mm_ok is true, kthread_use_mm() is active and userspace memory
> +	 * (copy_to_user, eventfd_signal, etc.) may be accessed safely.
> +	 * If @mm_ok is false, the process MM was already gone; the driver
> +	 * should log a warning and skip the userspace write.
> +	 *
> +	 * wake_up() or other post-signal housekeeping should also happen here.
> +	 */
> +	void (*worker)(struct drm_user_fence *ufence, bool mm_ok);
> +
> +	/**
> +	 * @destroy: Called when the last reference is dropped.
> +	 * Free the containing structure here.
> +	 */
> +	void (*destroy)(struct drm_user_fence *ufence);
> +};
> +
> +/**
> + * struct drm_user_fence - embeddable DRM user fence
> + *
> + * Drivers embed this in their own structure and implement
> + * &drm_user_fence_ops. Call drm_user_fence_init() at creation and
> + * drm_user_fence_add_callback() to arm on a dma-fence.
> + * Call drm_user_fence_cancel_sync() before driver teardown.
> + */
> +struct drm_user_fence {

Should this common layer be split into two distinct concepts?

- drm_work_fence: 90% of what is here, minus the kthread_use_mm() and
  mm-related code.
- drm_user_fence: a subclass of drm_work_fence that adds the
  kthread_use_mm() and mm-related code.

I suggest this because I was thinking about it the other day (I forget
the exact context) and reconsidered a pattern where a fence signals and
then I need a worker because some work must be done outside of IRQ
context. A user fence is one example, since copy_to_user() can fault,
which is not allowed in IRQ context. At various times in Xe we've had
multiple patterns like this, although at the moment user fences are
probably the only case that requires it. If we looked across DRM as a
whole, I suspect we'd find this pattern open-coded in a number of
places.

Yes, drm_user_fence would be a very thin layer on top of drm_work_fence,
but I still see value in the split.
 
Matt

> +	/** @refcount: Reference count. */
> +	struct kref refcount;
> +	/** @mm: Process MM grabbed at init time. */
> +	struct mm_struct *mm;
> +	/** @work: Work item queued when the dma-fence signals. */
> +	struct work_struct work;
> +	/** @cb: dma-fence callback. */
> +	struct dma_fence_cb cb;
> +	/**
> +	 * @fence: Extra reference held for safe cancel(). Set during
> +	 * add_callback, released in destroy().
> +	 */
> +	struct dma_fence *fence;
> +	/** @wq: Workqueue to run @work on. */
> +	struct workqueue_struct *wq;
> +	/** @ops: Driver operations. */
> +	const struct drm_user_fence_ops *ops;
> +};
> +
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops);
> +void drm_user_fence_get(struct drm_user_fence *ufence);
> +void drm_user_fence_put(struct drm_user_fence *ufence);
> +int drm_user_fence_add_callback(struct drm_user_fence *ufence,
> +				struct dma_fence *fence);
> +bool drm_user_fence_cancel(struct drm_user_fence *ufence);
> +void drm_user_fence_cancel_sync(struct drm_user_fence *ufence);
> +
> +#endif /* __DRM_USER_FENCE_H__ */
> -- 
> 2.34.1
> 
