Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762CBCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A614310FE84;
	Wed,  3 Jun 2026 13:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WggmU1pJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF8210FE84;
 Wed,  3 Jun 2026 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780494740; x=1812030740;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eYqEkee1ncGPjnHgQX2rUnQcMj/QI+pr/Lp5Y3zQS7E=;
 b=WggmU1pJgPtWVtfyJ1L8iDgrWsktO0zy28KwWhUu4sVVRyyjRyrsiWLY
 VcLDwBrDtkFEN+9PcNogRp4ygp04QvEKUqhR/nvgeux2QWjY3KlVIKPhO
 nChIaIjo6LhN5Sn+PTl+m+Ckb2LenB7BwLwVfs9e8qpRFHilnc7EKdjWo
 qynWR77j+VhjFwtyxX6nYpidqd2pNB3xfjPYw8hXAbVzOmpeyjNrFzBmu
 FYyDUG5S7xpn6rXgvIs8H5bqKo2bm+lb0tOBYarVVURzmpi5RNnZyX0/C
 lHWCtkUlmtP0N3km+KDyjKAtn52jGTrvyfhUkulxzEhhczcvX+zWe/84z Q==;
X-CSE-ConnectionGUID: N/4Igz8pTTyJd5c+D028lw==
X-CSE-MsgGUID: wG/U26TBTPWRRS0DCVwzow==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81335073"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="81335073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 06:52:19 -0700
X-CSE-ConnectionGUID: iMMvaW5fQCii3qMg+bfFsw==
X-CSE-MsgGUID: R0YQzwuzQJKqHrbNMYF6/A==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 06:52:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:52:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:52:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu1T19hRO14m/E/vQn4MgORdm5rjG0CeEBj7MoQRaPcrMfIx3hsxYUZSkZMUB1rZoAEhp0kzpDeZhnlgec691M9I/gHHFbATtuQOZDsukgOuaK1sOg32LBUd+X4Z7dmkWpsKsBumOAvDQ0TUOLJh307ry40p8jvw03W49HSzlUBsR8dHSPvggqsePHPj70gsmvu0HddiAQns7pUiyGkfmkOlV2fk7LxZWyz678DwVAmaUi8vp768kD6pCdzXnCkjS1sx2YWDckT8NK64BgsIitR1aGtmM/0gpkRJ7ql/mb4FBysLaMcrkYs68kGlumDs1HwrF+zAPcS0Bzd8G6ebxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVxQ1NBmAbY2BMQ0Xogdzeb1ArpopBgeuew1MZZAlUA=;
 b=lJLOnUnmeGdYkYHoYEmAbkWvKmNSlCDG7RPPgJkTmWhVh6iAoD1AlFXkO6oRevVjKljh8WWbB1DhngfcFQuJ39l0hPtuhuf2Fm6+JonJ+XY9SjYkMXTEvaWTyrZBaiKZD1XuGRZjbKjpqPapoi6cKuwD0a14OmhVFKgqM4BhppjLcE7x9tqOoXzCxGBT0Y0YxmJiBO1Cj3S8DjcSNmTmZPyDK3Gx5whQ8LTmVZEjbmL8QoXL/rcaUjFIO5aZwt8S7G4WIIiPoo9fzwMgCJp58OkNMW4W+bVFiGMpzib4U2L4hG9HDEZnScefq06Yz10KIDzEQ2OZ899RP4TBMaZKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH0PR11MB9611.namprd11.prod.outlook.com (2603:10b6:510:3b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 3 Jun 2026
 13:52:17 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:52:17 +0000
Date: Wed, 3 Jun 2026 09:52:10 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <nirmoy.das@intel.com>, <umesh.nerlige.ramappa@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <matthew.brost@intel.com>,
 <niranjana.vishwanathapura@intel.com>, <thomas.hellstrom@intel.com>,
 <fei.yang@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <matthew.d.roper@intel.com>, <maarten.lankhorst@intel.com>,
 <joonas.lahtinen@intel.com>
Subject: Re: [RFC PATCH 1/3] drm/xe: skip banning kernel migration queue on
 TDR timeout
Message-ID: <aiAxiiYO8nkE2gvl@intel.com>
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
 <5634e7fc-6931-465f-ba3d-4068b4fe53ba@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5634e7fc-6931-465f-ba3d-4068b4fe53ba@intel.com>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH0PR11MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f5620f-1a7e-40a8-1b01-08dec1775275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q8VpCgKlka28W3rDdYGvdnCfldf4119WE8EU0cV9OG7DP1Fd33Mv+afbqZUZVh8V2Nwwu1SH4RZkmnovIzOpTNeGYKLYZQWhwNVT4hiCO32Et5U7TEpPxJgQEb+8gL3VT+C2S7pUcsNGLRLP+WH+oL4/2tvPaEUYfZ+oIw6gKp6H5/pZXF75dKj9WBfbQoGNtkwSzzVFS6MIHpk1r/6xwHoMh36XQsqQk7fro4TPqwThaFPAOXO6sCxhMvFZF5mE6ZpUQW83YTO4+pFrQ0EdFqnurZHCiio78YQMl99VS6UymB6uL42cHCk+KPz7lCgchmxbhXlKHgb+ERvHzFJteQUoQwKmFcHvrOQ8I9cHJE01lKD8n1CNkg1tkwU+9rt+2Ne7JMUYZRSGnY2vR5h60wHqKyRthNIiKaTp1Pm0l3UPSvbzbNEuQl1uCHAzg9662Vqy9/xDIHS6dzwf4uajcFa/FMzI7TjMaQGBFIpH04RixTJfo6tQeqGGNEPN9yEMFgsMrtEoTjMzZAQB/aj8FN9SJj8IsiChEk1hMQIsjbb8kHVG2NV4APtF9VKCMEpUZZPAUGPN/YHRNC2L/BxpqH6AXfRafLpSprNgVFfF8RmG079D/Y2DYbdmX7GizkMN0uZKnAXihNuYejA/tpLR0GgdHAMX/Wf9KV+eWJF5BcpNhFekNAXRR/Hk108o/Vc7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlRa2FUdEJPZ2RDcnpWZzRhbWhjaHdjeVU4ODV3L0hjZnlFOU1hVFBxNk51?=
 =?utf-8?B?eVNVcHJ0cnVjQWRuSHRYMFYwTlNJTXkwUU5QcW1WaU5GWEIyUDRGcmMzOHE4?=
 =?utf-8?B?cmI4MUgxbGZWamo3YWN1dU4vdVpzb1F2b3ZJc05VZGRGUEZWanE0M0Rmcnpo?=
 =?utf-8?B?RTlNdkJQRDM4NGxRZHpqMjM2SGVsbHF0SzZNY0FjTjB5b0x6dkEyTlNIMERD?=
 =?utf-8?B?WVIzaEhyK0ZZMkQ3OHBDSFVrd215c3c3T3R3VVZuUTgzT0RDaTFqV09DaXNv?=
 =?utf-8?B?Y2xDMXc4b3IwV2lDcHFmUW5yeWV2ckhmenZRSDdac0RuY3pnd2NRT0Y2UC81?=
 =?utf-8?B?NVBzNjAvS2xRNHljZWJhTHBBak9FV2ZlSHV0bVExcjQzMSs0MGtIZ2JwYWt3?=
 =?utf-8?B?bFhpcUlKankrOFRXdzE4aDZkSEpXZjM3MGdvbmh3aWM5eVFEbSs4VjZMUVR2?=
 =?utf-8?B?RDJMMTkvREwzSHg5UVI2TkRmMzJkWUtUcFI5L0xFR0NLSmhTSGlnaFdpVlZp?=
 =?utf-8?B?ZXBOakxsN1RUSityWGJBbnA2YnQ5SXhpV0M2STNlUUdaMEMwMzlOVHhHM2Jk?=
 =?utf-8?B?R1ZRcDdGclRLWHJRVnNOOVZoMFpoRlZ2bElVOGtjdzloMG9MZEdJNUVJam9O?=
 =?utf-8?B?dzlIZWJkcDVBdVBpWHUwL2sxcEFSTVFIa3U2V2NUVmN0eXNmVnArVS9RWE80?=
 =?utf-8?B?MnR0Rm85c3dPWE1LamlXZm0xc0IwQnlHQTdmZS9RdWpyWmNhSHFvMS9PTkZJ?=
 =?utf-8?B?VHhxOUdtK1hBeXNjTVdFdEJFeHFscngvbmZnSWtFbnhybTVLbU44dGIyZDQ4?=
 =?utf-8?B?OW1USzgrbk5UTlpkZDlLbFlscDdCSVRYZ3FjcHZ4bEdPVTZFZmhjUEhRN0No?=
 =?utf-8?B?Q09BRlJUSi91SWdmaExzbGhwRHVsVWJjZXEwbHJreWREanJjMFlNTGVmeFdu?=
 =?utf-8?B?MVJIb0xlNFd4M2lyd1drOUE0VHA5dzNlSmFHSVZKQno5cXFpSjI3NTBXT1k5?=
 =?utf-8?B?bTRlNjRFb29OZXBySXQzaEdaUnhDWmxFNTRmd3NnSlBIclBMYzhUaGlSTWd2?=
 =?utf-8?B?M3VObjB1TXJqQUtHVVdIQzVaL09PLzB6ZE5qbDEwVmV4TzVzZnBoQnZEdDlm?=
 =?utf-8?B?dlJRaGFhTFhVQ2YvMWV4M1ZJdjdpN29TeXZHZkRMdzBrak1nSUk5NEl0aENn?=
 =?utf-8?B?OEdUZDJ3WSthUW1FR3pvdTJ0ODN2a0VDY1d5S0F6bmVQWndidURjQWN2blg4?=
 =?utf-8?B?aXNGMi9rMUQvdy9qWVgrQlRwT0Q5M0k4MHhIWW1jTWxSQTREQVpEVlVGczBK?=
 =?utf-8?B?U25wcFdKSGF2L3ZsRlZseWZ3TVpSYStqcUtvb2lXYUk0RFZWdkk2ZGppUjRk?=
 =?utf-8?B?T0RWU3dRSGt2eGdVeXN4YVhvSUZ1alNTTnlNYk1sVFB4cHNiL1VJMHZzOFBO?=
 =?utf-8?B?amdqWmlXQ056WGt6dUNVcGl5SStsaUpYeDBnMExTMjFHMElJL0VWWTRhd2VX?=
 =?utf-8?B?Z3p4UjIvQ1VHeVd3Y3Y4UUlqejBmcWtSdEhrM3F5SUN4Y043TUtsUklNeStx?=
 =?utf-8?B?TWpGOWNzc2xpRHpMYkthSmtMNDIrbVl2WG1WckxLc0U2a0VXbituRU5KUUZj?=
 =?utf-8?B?eGcvTFNsREp1dlc0YUVBcE0zUE1wY1FoMUFvbUlDb0ZCQWRuTWg2d3Yyc3Nr?=
 =?utf-8?B?L2srY0V5SmV6NHRiUlN0VFgvV2MxMVdxNlRSOU1MS1QvelRwWWVpMldNeGZO?=
 =?utf-8?B?d2tSQ3YvNUx3NndFUUlhRFFJRVRuUzdqZlRtbmV1VWxZajFoQnRHQzl2TUVv?=
 =?utf-8?B?Wm9qM0pxSTdKTkpWelJjUGhUblJIdmNQUWFsYlUxcVUwQUdZUUtUbEtxU2lp?=
 =?utf-8?B?Kyt2LzA3elczbXJJWWVxTFk1dXVITmN6THZUNU9sTEVJM0VzeGNyaTh4N2t6?=
 =?utf-8?B?OFF4VFBGcjRJRmp4V3FXOFhOMEE5VFhtcVo5MXljbmN0b2Y3TlFCMEFOYXRr?=
 =?utf-8?B?eXNEU2hNR3hZb0lKclE3KzkwNTFLeEJXbmQrMWltM0tNb1U0OHVHVnE3SjZE?=
 =?utf-8?B?dEtocS9tbzVwZnowR2FGaWN0bXRpeC9sSVgycDlSOTZKYjc2R1gyZmx6VTAr?=
 =?utf-8?B?UE15WG5xeCtQNHhSSTFGTVBTWmh3bnhJZHZ1ZUNyVGlDQklvMFY5WTBPaUNO?=
 =?utf-8?B?VWlnRnRSQlBaUUJCMzNNYU1UemR3YVg2QXpHc29sNGxNT3NGY1M3N0ZjTXhs?=
 =?utf-8?B?M0VsaFhTSDNsSnVFVDg3K1VvSEJyRWp0ZVpiUVUvbXlpMWxGdmhFWUJ4dnBD?=
 =?utf-8?B?NUc0ajliQXRQR0MrZUM5d2hmZHJ0MFBaRjBkVTJIRjNjczBlaU9Ydz09?=
X-Exchange-RoutingPolicyChecked: UhAmOCWS3hicpgPzBp/mce8XbL5+38KeOh+ymiOK904zC5T8ADoGGMkU7n3d9XI+VVRk6qznpJYEUAVoqMBv1ivOkxQHPqE9Vgp03VBvC0KEOH9tx1g0VIXLSV5wCauUPtBdL0pzFTS6EA9bNUvjA5mlD8kwhD59JYCSr6WGWbc6OiogzG+405jRtx5Qt6/uO5fr5/eyF9U4mnXVQB4i1KxIlOFO4LbaggXxADIgWpRyi2U4oP1gDB0msCr8OgDHkBM5jVqGqUTP3HhWveNIjfsoUszwIQxiiOySyvm2r9jWW6tz+xqvAZ/3WksIDoj1U0weKhokm/z65i5P0yKInQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f5620f-1a7e-40a8-1b01-08dec1775275
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:52:16.9031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRLTcR3rYPhJIfv9EbNiOs6GLXHNGwGCLlu6Vx6W5iOQH3mYXRD7BqK7+tKl2KinWRD0YUpQeGxeSlqvfVrNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9611
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

On Wed, Jun 03, 2026 at 01:42:25PM +0100, Matthew Auld wrote:
> On 03/06/2026 13:06, Sanjay Yadav wrote:
> > guc_exec_queue_timedout_job() unconditionally bans the queue once a
> > job times out. For the kernel migration queue this is fatal — once
> > banned, no page table migrations can complete and the GPU is
> > effectively dead until driver reload.
> > 
> > The submission is already stopped and the timed-out job is erred out,
> > so banning is not needed for correctness. GT reset handles the actual
> > hardware recovery. Skip banning for kernel queues so they remain
> > available after reset.
> 
> Is wedging/reload not the more correct thing here? Kernel job is usually
> performing critical and potentially security sensitive work, like memory
> clearing, migrations, binding etc. If something goes wrong in one of those
> jobs, how should we go about recovering from that? Is driver reload/wedge
> not the more appropriate thing here, or least would need a more elaborate
> recovery?
> 
> For example, memclear get nuked, what stops the user from accessing
> uncleared memory later? Or a migration/copy/save/restore/ job gets nuked,
> from correctness pov how do we recover from that?

I agree with Matt here something is off. we cannot blindly skip these
kernel submission cases... (This and the other patch in this series)

> 
> > 
> > Fixes: bb63e7257e63 ("drm/xe: Avoid toggling schedule state to check LRC timestamp in TDR")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Suggested-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_guc_submit.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index ab501513d806..e6ad57cbbf0e 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -1543,7 +1543,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
> >   	if (!exec_queue_killed(q))
> >   		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
> > -	set_exec_queue_banned(q);
> > +	if (!(q->flags & EXEC_QUEUE_FLAG_KERNEL))
> > +		set_exec_queue_banned(q);
> >   	/* Kick job / queue off hardware */
> >   	if (!wedged && (exec_queue_enabled(primary) ||
> 
