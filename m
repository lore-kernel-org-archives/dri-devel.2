Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44373CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C97410E28E;
	Thu,  7 May 2026 13:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fz62j9/r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A062C10E22C;
 Thu,  7 May 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778161834; x=1809697834;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ngl9T3FV0mserKENw5HsjFHJ3wiLg4V+YO1bd0l4a90=;
 b=fz62j9/rLiFSg9WEn60xuUUtsHsxh8IJolBVDQRVzHkbfTS/3hN37DTq
 fhE+mjddSa9zNSGDajUC+sb6b8XyEKSOPjUjxIdhwEFWdv22uW3lcXYLJ
 oxEvktxHEGVV2fq3dLeAosEeZpCMMgUpKCHkXisvp/zPwHnnnYNNeT8+/
 485Zj3axDKV6rMHuYV3Gz6jD7WFbUp1TSDVEhsrKl+fczzKhpfVY0eIZ2
 Kfq1uwSfOG3fmGuIL3NQl3MPllRtaFPE3UCx0W3Ik8Vd1+i+TSI3KDZmU
 2YuiJfGubJDOyl/kraXO41sLEgzChuy8CiVde0zp8KmHt2XCkbHDJhxBd Q==;
X-CSE-ConnectionGUID: aNNHZGRSSWKNXKO2vrrybw==
X-CSE-MsgGUID: KushWt1UQSmPUAMzKLZwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78962221"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="78962221"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:50:33 -0700
X-CSE-ConnectionGUID: mcCpvfd8SXGFOrA1AOh7gw==
X-CSE-MsgGUID: 8L/GUIDbQaWfFK2duw2C4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233396357"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:50:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:50:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:50:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXpCdmSU2/7gnbyUAV2Do4Ebz+chsMs0pMaWcXUZSRPSBji/VnTorDCkxHVcd8hRrNdzo9m7hqDJXwH/rXD92KUJ0SGQyz1uBOPQ1Ykb4FgWrAAkSp9bO1nC7yiAY0/AVaeRpKPLq73YTG4cou4OJXEiiuF58VfhKWWt/E7KaVW8ljTd0aZ7JyChU+ccuvSJhmym6jaDHtE7QlCFTXB/FvLR+Vdne6OMnMAHXHrrdWJp1J279IME/gwgSkLpGcoWYlcPVRphmp68y5kCl8+CQCI2oPoL2i8PfRnSgm1I0cMfoFAsK8Hrtqb3v3j2scVWUP/XVyieNP6wNVyiYoQZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYr54DXWKSCxciJiFS4LHyp4OUqHXnH/svLfM5wCHEU=;
 b=XnCQ3DLJz5R7C0PBvKzbtToge1noMezUe5fk9IlV9+hbfNhbHwfY93R/8VJksj0oOam5Cq8E+lgTBJTMKAGUyxdFbbckVuCLzUa3G27/rJyPJb+aSIPa8BfbqVFCGVZbjo7kEGFxZTL/RSWdmsuKd7iTs/N/FynUlY2qNI8frx7r4RpOcvgdngRlCBJq33tf9fX6xUHFUAjw9BKwyXdMeJ9PbuFmSp/qX1HnoF/0lW3JnfN/lLtbqcROK5gmef+SUl/2XsBq2EzsPwBdFQTRV677xeBx/pcGESQNKpeFd76DAsgmsHRtdwwUYPq+30RD466I4WV7vhs1HRDlc1O/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:50:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 13:50:30 +0000
Date: Thu, 7 May 2026 06:50:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Francois Dugast <francois.dugast@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm: Drop HPAGE_PMD_SIZE dependency in
 dma_iova_try_alloc calls
Message-ID: <afyYo8Ow7xDQvEHM@gsse-cloud1.jf.intel.com>
References: <20260507091606.1067973-1-francois.dugast@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507091606.1067973-1-francois.dugast@intel.com>
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: d751ec7c-1594-4a35-b909-08deac3f99ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5YoKR4wk3KomMS6s5WdXkBKWeHzCsrnWQ6Ufv2buzhU1OWeExzO4KyN6l1JmoEKBgqA5k/0SJh7TPK5RTt9CMcwhtvFWdT25ssq01Wmc5ZILr0iFMBA6zfk/5tK8abe4HhbteH2auBr3OCB5A7nWOzwslStGUy8G2ZEOOVzsptuyGM5Z9ShWRU8ErA77W5mHK2H8CoBoF3qb6U+cihKlM4XMqSzTKZcUwvCSREQimIq96t50IO7Jo8IBgZdoJzpp/lXnkyCuknJ8DkZKLZEOCmPi4obAzjILH+3CKZZxuWlRdMK6qnwj9do3HOh6bUzIOKwgdNY1USaBewQeBmtnGMVoYR3JL7I+GrEmpp7VDywAhzJK1XtuzlXizzuVVt3hbiFERHACJdIGoBBSor/FOc2LY3vECwcdMInZU8n9cu4NKdAqTkzWIMQtDgRDIVrZeWFB1dibTHqxPZAomp7GUzdIrDGlYCwaL5S5KyLunSZNbl3rbPDAj0+8hejHmEXBOo/CcEJZ7ce69ebLNUIlT489zF/6DOFq/OHqJ6ADewQy9RtaSKhLa3iH06fV/HrblwBX0/PAxNYWa1aCWZbNB0nbCXZXI0B3tR6FFhVGIbEORYzIXeWlWmZoWHmX8ZNrE2qC8l/0ZcrR8EUI9GCJGeLIIDosEecSOJvZgZKioB+96nUmw8EZ2uk5+rNHBZI90pte+wX9Fsy1rdJoOLnQig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNuZCtEbVNOQUJ4ODd0ZjBVWk9CTVp2UmZPMWVlaS8rZ0pDcXRQdUQraXNS?=
 =?utf-8?B?ekdsMUlGN3FGNE42TjROYm50a2JYdWdTOWIvMTdERHExWGp3NGtPKzVqTy9E?=
 =?utf-8?B?V04vVTVPR3RXN25lMDVxY2U3QkpIemlEUlZjTzhYRHlybXlnYmlrbTJhQ3Yy?=
 =?utf-8?B?bXNOV1JnaHBrMkwrMHJLSWVDWkZzdGZtd3FPaVJIZVhnTVBkZHVEaFdaSmh0?=
 =?utf-8?B?ZldrTnFITVNiTlRlMERlSmEybml2c01OaUN1UVNSKy9LV1JUMWhIb3VrWjNO?=
 =?utf-8?B?Q2UvUFBmNHQ0RDQ3NVhNTTV6ekxXMFZhdmYzcUtSc3hRNGcyQVN5L21RVTF2?=
 =?utf-8?B?NmEwTU1NM0xYdnliS1djclcxaHNYd09ZdTk5WWFmWFBLRWlTZVlHNXNvZFpU?=
 =?utf-8?B?dThPVWNkZGgwRjc2bUpENXptcTI4SkF2L2xqQ0tPUEdQYjZaQllEbEhncDMy?=
 =?utf-8?B?dnFoUzJRUHJCL1crSmU3aktOT0htMXlHTDRjdUcwUHJITE5lNUpRTDMvbVVC?=
 =?utf-8?B?eHp4akQ2ZDFHd0JXTm00aFNkV01yV0dONjkvMkxoS1BQS0ZGaXdkNm1WVklV?=
 =?utf-8?B?Ymd1akN1UVo1R204WlM0Wk1MMkxPOFJrTzlFU1hqNWYzdUxvWmI2NzdWSzhk?=
 =?utf-8?B?WnBUaW1LSk5nS2hXOUt3dHVmZEtjUlQ0TXd3TFZjM0FOU24zUGZMcXJBSU5p?=
 =?utf-8?B?QkhRdUthVnZhdktwMnF5RGxNTzQzQlBzL1d6bzk3SDBQVnUvcXNDa3c0eWlw?=
 =?utf-8?B?MS82cHNLUVVUR3RsZ29Vd2JmTjlqTHoxbnNML2Y4cGRzSUQvU0RXRnhGdE93?=
 =?utf-8?B?cXdueWs5V0xzRzh4SlJsN1grWlFCZ3hFTkZQdzMyRDdNaDZZM0VKMHVucEk0?=
 =?utf-8?B?Q3RkRDFMRldYZHk5ak9hTUVwNFMxSFo5M3JiTGF5cUZDMTA3cHFHazdmWTdw?=
 =?utf-8?B?NmFDbHFxVUo2a0szRkp6dmJyVDdyYlFmOEgyMWhUbnlPdTZ1eENOc29GQ0ZM?=
 =?utf-8?B?NXB0Y0QzUVRMa1JhdHJiaEdZR1lYZDJaeStkdWlQd3hhL1dsRWVlTEZNK1Nr?=
 =?utf-8?B?NTFGcUR1WXcyVTh0UkVaKzg2RUtOY0UwekErRWtDWUpuTUpLUld6M2xoUmh6?=
 =?utf-8?B?TUJld2U2VmJHMTZobjE3eHlObEoxQ0hOV1ZPYmNMRTBLblVZWDN6TnhJaUdo?=
 =?utf-8?B?MUNxM1g3cmZQSElPUGtRNWJhejkzTGVQd0toOFhleGR6eHJlbUVmZUVnV0NH?=
 =?utf-8?B?NDdZWEZvaFI5Tnl0VFpOWFNiUDZjejNrUDFoZ09jd1U5OHRQRkhOM0x5dUd2?=
 =?utf-8?B?aXpIVzJFYkJKZUU1alBzcXVIZFd1bWo4aWtXdjlNb3JHMStUelhhMGZLQjFR?=
 =?utf-8?B?N3BjNlJtcXdtWDRFVmtOcDgyYU9zSWh2OGdxNTlzZzdqdFgwekZ4NU9pT2dv?=
 =?utf-8?B?VS9FdGJ0Z0hwSEl0SDgxYytwR1JVb01pZy9HU1JzUnEvSGdiVHp6ekhJYjV0?=
 =?utf-8?B?Y0N3QzgvZDBQWHhIN2JmWVVKbzZheEJiVDJ3Umk3TElEL21TOU5GdDkxY3Fq?=
 =?utf-8?B?cUxqY3NlUWRaZzlZd0l5UmxGeUJlUkVCVU5NRzg2UVZCQ3YzamZ1QmZGTlFK?=
 =?utf-8?B?VDNDcnZNZks3d1F2bm1KS2JKa1FnTWdUZWFjT0dUSXN3YUYrODhzbS9Qcjd0?=
 =?utf-8?B?WmsvS0tiOVp0WU96Y0RoNVd1NTdQdDRuMzh5TzU0WkhFSGNieVhOMVpGWDQr?=
 =?utf-8?B?a3lRNTRCNGpYV3ZrR3BCeHQ2NjNJMDBVY2NGNm9pN0F1b1VNc0FPTTFXSWNS?=
 =?utf-8?B?U0VGdE9kdTk1MXFlclNGcCt6S0NaQnlSODNTNlpxRjdrSkNoMVFWdDRFYzV4?=
 =?utf-8?B?Rit5c0hhamFndUNMaTEvRmFiVzFsL0tJdUt3ckRHem1YT2FhVXZLUWZYVTlB?=
 =?utf-8?B?ajdablYrS2ZiajhTY2lPZWgrZFplbDhuNW1idytDcDAvNW9mUTd5V244SWJm?=
 =?utf-8?B?Tnd4QUVtd0FxR1ZhV05MNENxcmVucFc3cThoV1B5VGdxV0ZDbmd0UFJTWklC?=
 =?utf-8?B?T2xrRlNVUEUzZ0Y5c2V4ODhQWHg3cjhVR3d3SlNJUnE5cHhGMXJielVxYkRr?=
 =?utf-8?B?OHRYMEN0dGNpMTVNSW4yUmNhckFpN0IvY1lIclVVU0FFeGVqU2JZT01VOXVR?=
 =?utf-8?B?MHNFS2ViV3FBSjVnZVhXblF6c2MzSTQ5Tk1FVklLYUJweUxKREd5eVU3NTMw?=
 =?utf-8?B?OTNySWZuR0RyMUNMR3k2MVZhb3RRMUxpQ2FydFlBaWc2WlJ1TEIrNlJJZytn?=
 =?utf-8?B?d2c5UEtuVTl6Mk8wUDNCcU0yeXp5OERsVnEzSExtQmdabklhSFZEWWp2bU5F?=
 =?utf-8?Q?wNu3kAvRs8nQftDU=3D?=
X-Exchange-RoutingPolicyChecked: Y16RFNdkjUh+9n94fZ/bxVj/ekSyRzMsNkF3d6X9qC34E/koHQD5D03elfx6skVz7QY0Tk0xTQFsrBXuB4gmZBq4j3L2/U03gnHVFsMSIZJ1LeibDQchSv6o41OGUSQ2EaH3iPt4cp3YLF+svup+RVCE7a8bSu6NzFSKsLhmpesqNfsp5L6SW11ky+GNzUWTqXeKEBhM6Yq8Cc376pat5iL4Bi7L+RJLfEVveVzpkM3qPxicZNpt5wRRCK7vvVONrHr3tgAPW/LSwglztp7syICf2sX2VR5Ub5pgswZOApPRgGZstfK9/vMe4YLWODKuo2jIkRtU82uOfWaLC6nsRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d751ec7c-1594-4a35-b909-08deac3f99ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:50:30.0265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7/A9Ok+qyWWobPKe7PGyYTvyvLbpIH0XtNqrovOtFeSg7bRfzHfNjxVOFd3729kHtO6xpm1HGTgHmB7D6QU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
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

On Thu, May 07, 2026 at 11:16:06AM +0200, Francois Dugast wrote:
> The phys argument to dma_iova_try_alloc() is used only to compute
> the sub-granule offset (phys & (granule - 1)). Since HPAGE_PMD_SIZE
> is a power of two larger than any IOMMU granule, this expression
> always evaluates to zero.

I looks like I screwed up how this interface is supposed to be used. I
thought the phys argument to dma_iova_try_alloc was really the
alignment, but it looks I was mistaken. I believe the above analysis is
correct.

> 
> Replace the ternary expressions with a plain 0, which is what the
> API documentation recommends for callers doing PAGE_SIZE-aligned
> transfers. This also removes the dependency on HPAGE_PMD_SIZE and
> thus on CONFIG_PGTABLE_HAS_HUGE_LEAVES / HAVE_ARCH_TRANSPARENT_HUGEPAGE,
> fixing build failures on architectures such as arm32 that lack that
> config.
> 

Fixes tag so this gets in drm-misc-fixes cycle?

> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6 # Documentation
> Link: https://lore.kernel.org/intel-xe/c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org/
> ---
>  drivers/gpu/drm/drm_gpusvm.c  | 5 +----
>  drivers/gpu/drm/drm_pagemap.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 365a9c0b522a..958cb605aedd 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1556,10 +1556,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  			if (!i)
>  				dma_iova_try_alloc(gpusvm->drm->dev, state,
> -						   npages * PAGE_SIZE >=
> -						   HPAGE_PMD_SIZE ?
> -						   HPAGE_PMD_SIZE : 0,
> -						   npages * PAGE_SIZE);
> +						   0, npages * PAGE_SIZE);

One thing to do would be to confirm via a printk that, when npages ==
512 on Xe, the IOVA is 2M-aligned. If not, we likely need to tweak the
dma_iova_try_alloc interface—but that would be out of scope here, I
think. From my quick read of dma_iova_try_alloc, npages == 512 should
produce a 2M-aligned IOVA.

Anyways with a Fixes tag:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

>  
>  			if (dma_use_iova(state)) {
>  				err = dma_iova_link(gpusvm->drm->dev, state,
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index d82ea7ccb8da..15c78eca180b 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -347,10 +347,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>  
>  		if (!try_alloc) {
>  			dma_iova_try_alloc(dev, &state->dma_state,
> -					   (npages - i) * PAGE_SIZE >=
> -					   HPAGE_PMD_SIZE ?
> -					   HPAGE_PMD_SIZE : 0,
> -					   npages * PAGE_SIZE);
> +					   0, npages * PAGE_SIZE);
>  			try_alloc = true;
>  		}
>  
> -- 
> 2.43.0
> 
