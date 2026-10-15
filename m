Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D203CCA460
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD7710FFA5;
	Thu, 15 Oct 2026 13:51:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D1910F32A;
 Thu, 15 Oct 2026 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792072276; x=1823608276;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KT2YXZpsZ/S8Uell0OfaG020LJyHsxOpR/z1VXYBER4=;
 b=ZtObuh1nfdjOA28x4GTsDbnSbLA3h+gY0Cas5RI0lSq3xIHvIsadkTeD
 37ZJjjHrxZk0GwNIg3r3hq7dst5KpkPxyDAnen12is6V+jhtTHM99cBIU
 tOaJzWDbGilg1b02qEyASIb9Ti0xlyVOzyjazJV/7QDTL6J7avk/WDOgj
 sFeTUk06DqTa4sRHaawa+yc0pyUMqdHQ2rlM6eWA6RQEx5Ut9O8QLauYv
 Fjo55dR4puuNgKewwNI7wSC9Xyb1juFQjjIG5J0VDdEwAd0Xog6YDBMCR
 HUaJ3JWkKtSbkRAi1OVl4O0UeHR2sRpxID5ODYwrgWA4Vgie9NQReIViJ g==;
X-CSE-ConnectionGUID: 4kdzm5MhR9mB9kRKTlpeJA==
X-CSE-MsgGUID: sQwrUcS0T+igAgIjToLekQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="851926"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="851926"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:51:15 -0700
X-CSE-ConnectionGUID: IXUdW586R6iylH+8hdy1/Q==
X-CSE-MsgGUID: PCBNKQYgSneflugYhRbfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3450177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 06:51:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:51:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 06:51:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 06:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GumwYwvJ8lZ5twxotsLJVxI+NnPnb68cTy2gsvCwVDTVbE77pgC6f2N65+zZ9Vu/evcAwC9qwl+PQ0GUfok+/FoptdbbGr9fIJBjTwuUYHRTeSXS5H4SE55Kt4VAL83+VFCPxX0HXoepGTzaVXZl+KGo0ePL2v9DhYOR3ms8LTm8qBnzkNwgKBRdb7WufG8JtDTiqzkw3iXnuTsfyuUd4hpVD//zmNUy59agItX/e2S3A+C35bbVgTAbZSuYlDLKBASxCqWUFlYIu1X2ZcLFd7JFIMxpM8tlx9m40grIgy6Vu3i+JsrWq/VCkB4XAG+ETjPk1q6SE4sV/q/Z2/yRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV2dDYMf9enMfUsEFsf80O6oA/mHb5Wz+v39yVdsRmw=;
 b=RzikdvdB9Pn7R2W0inMfAImbBQh6u7DCnCap3aWhH2zwDB/Db3mIgm8FLXuSvLgrmyRiqbZ7fdxZuYmHNtBhBLMOkmTQKtfT4/593GwurSrVeOf5uPSLXwTcggi9W4+A6VOnKtDqFjrX0iNpssyMzDMEqDKXGvWdl4WathBGpPlr5zFQ7+nr1BXY7wZ6mrJH1Lg0jwOmayVdNIPY/xk/WCp85ZxhqQt9UW3L4kmO/oqS2N5rXoy1/UKqoFKxd0gA4x3O5Skr6BcvYMpujZJuGm50+AYJYMgB5067LR17MuUPlfHk7OJtGzvAXOrxarQX7e/qsNmOvoQQ2wMrrwFnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:51:12 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:51:09 +0000
Date: Thu, 15 Oct 2026 06:51:07 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Subject: Re: [PATCH 1/2] RFC: drm/xe: Fix pinned list UAF panic
Message-ID: <atDaS9XDmNGa63JR@gsse-cloud1.jf.intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bf848b-8203-4923-3fc6-08df2ac35dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: OkxMEePnT43gsrav54gCJeKqHJh+4J8jNvnY1sNDCP6ffrTusnKFSboVHGInHTMHszlQEBXtTXBpXuoZyRD8PMb2G0wa4aozWcIg6Nx2Mi8XrgQzBJKJaSBZa+u6bt+yx1h6+WsLSvxjL1p1UfvSBmi6OQnmigvxi3UWOmv3sX18hm058kK1YLZ3S6AdzxXnKAEzzhv8HxRSf2zCmI94eAtOOhjzWclgMNYImaerB5oGl3IYGpW/qD0TyNcNVvDzqHAUffERPIG4cojHBozGhMK0OOsZZYt+NfUGDkegc1NSyd1jC1ACVeUyPSzdoI0tLAfFlBBoe0gq1PIRqyr0efNQ699z12taSpTZaSKCYOO9O4X2GkBCVFllFFL+D7XkPcSIFrLF/mOdw61xnpJzuFdhOnhdajJej10aZ66/iNaO4fzcd+djiQKmgkoJxmRbLFvy6u5EdVDc6+z/GTjlziKcQa9V9Jiq/YAyQx3OfxyEB2ljaGBuvHQsmJxdaoJ/Ti7nCkZ3LuxpeOrA7PMUHlMmgqGCWcNKDn5Ic8FS+pdSY/3yn88Vz3t+6eCpmhV+s+1hhEeloQqCbzGWIwAN6YGc711HPkpMYaQdTV+yCa2ONOVoIUFDTCylAS0YRwmyG9YRGFvv58z9VXtlQneecnqqrcKKOmBpsxEflBwcwGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVNRHV5RFhEM3hEWWdsbGh6R0NHSWZ1VnRxOS9LaHFMVmlFbTMxZGZwZVE2?=
 =?utf-8?B?eS9YaHU2elgvVDNjQlhoOVVhVlc4alhlOGdzaXdOVUFGQnNYNHhRTlYzck82?=
 =?utf-8?B?R1A1cE8yUlNiMGowMDNyQVlTYTBxQ2VXNE5Ga0RxSWhNTzhWbFFUd1VEV0hZ?=
 =?utf-8?B?bmtjcDNCS21KQVpyRFZxV0MwamFuU0gyMEp0bkkzQVd4NDVucEJVVUZtRG4y?=
 =?utf-8?B?SmNENW9zTTBrUjVGazVqakV6TG5UY1BhUitNREpBc2o5enpTTUtOdmk0V0tu?=
 =?utf-8?B?OFF1WVdEWC9UZ1AxdHBhVHFOZm1KMmt3QjAxRktqL3RZMHFQbnE0MTh5NkMw?=
 =?utf-8?B?MDllNEdXMnZuK0hONnJIYUdiN21qeTdQSHpoNCtITVgyV3dPT0lVZWZUdERp?=
 =?utf-8?B?ZmpJVlNHdzFzUjkzNTlTUWVPckhDdE1MU0llSVF1NkM5aEh6eDR2eDBLNDNN?=
 =?utf-8?B?MzFjRzJyUXZYN2JVUGdEam12VFVSeGtvcUdRRS85NFRBUDk3VGlNVU1RemU5?=
 =?utf-8?B?aE44OE0zeE5tNWlCV1hGSGJ2ajRuaTQybzlDNnhTa3RtanRnZ2JMZXk0VVpt?=
 =?utf-8?B?MGJjUFQ1VjAza0I4SDJqblVqQkhvREhWMnNkdURROWl6YWljbjFNYVBXNi9m?=
 =?utf-8?B?SnR0Z1pkUzQ0a3lTOGZNWEdXZTNsQlVsVis1UnNJMXYxU2ZEeWVvcFNqdUcv?=
 =?utf-8?B?RW9hYjhPMytnelVHcEVUVFlQM3BkcTdrbGgyd01YM2c1cUp2azYvOGhKYUV0?=
 =?utf-8?B?MlJ0Q0FMdTdRQitwNEh1K0hnWHZCMllBWndVbnJ5RTR5ODNxcGxlN1hRcUhy?=
 =?utf-8?B?RE96djlkSFVRcHhBZWpUS0k5RWZFYUlENkRmUWdTam1UY0x2K1NDMUUySnhj?=
 =?utf-8?B?bldUbDFpdDYyM242M2M3a3hMK1ZFQXpPNVFiVFQ2bVhXT2laMk9HcG9RTUg5?=
 =?utf-8?B?V3JXckhWYUVrRS9ieURwdUpjeGFmQVVBbm9MTG9aQXlCQjN3SzRDL2ZSQmt5?=
 =?utf-8?B?VzQzTE5nWnJxeFNDVWZYOFV2REJYWW1rajl6UWp4MlRvUTg1aXRlTlV0SVlR?=
 =?utf-8?B?NDJsa0lRMkJnNHVSZk0zTktiYTMrNUI2eG0yNktidWJQQVkvWi9VWEdYMGMy?=
 =?utf-8?B?N1ZKcVlQQWdJaVU2aFdhWWowQXovV1hUN2s1ZXd1NFo1N3Z2ZmZacXplOEFp?=
 =?utf-8?B?RXBHVnMxRVJ6RzdJakk0LytSZ3lIOXgrUk1aSEl2Ukcwc3NWS1RlcWFTNzhI?=
 =?utf-8?B?cVExZlRnT2MwcHVST0dHMVpGWk1wUko2VzJVb2tnNWdlWThmZUFPS3JWd3pC?=
 =?utf-8?B?dm9XRVU5QVdvY0l1WWt6Ry9NbXBHenJxV0RqNzJNbEZhUmwzKzFzVVBtZlZF?=
 =?utf-8?B?MWJpVUdSK1pITGVLcmlZdlBzSWNxT1RYUGM0WHBxaDVFd0k0ZXl1TEZzZkdM?=
 =?utf-8?B?MHBDTkRabHRUaUdsYlNpLzlxdDNlRVNFNmNZams2TDIzOVdaTjNZMFQ5SXJu?=
 =?utf-8?B?NUcvUGdoVG1XeDYxWHRvVi9rMkdSS3YzZzcxRG9zM0NhbHBnNitDZEJTRWs1?=
 =?utf-8?B?WlJwMEx6ZEtlSXJ6NmNGYTFWRjJURlB3VGhtSVBhRCs3Y0plaGNDMUluczlq?=
 =?utf-8?B?RmFRMlNkVEFteEVrMXArMlBZazNOZGJaTHQ4bnRoQnBURTRaby9oQ1V3ZkVv?=
 =?utf-8?B?ZnAxbXZTYjRVeDllT0dpcWY0MlAxWXBKRUlwWHVlZVA5SncvZWh0MUtvLzRm?=
 =?utf-8?B?eEQ3VG1hN2pySUQyaGU1SkdHVnVGRUhqci9QK28xaFJOdnNXcU44aHJrMG94?=
 =?utf-8?B?eDU5blo3MU9wbVFkejhGU0UxaTJpMFhkZ2dWWDQ1ck52RThjNDl4S3hqTDEv?=
 =?utf-8?B?dFRiQmFsa3RFVHlDd21FTThLS1dzQWg2K0Ruc2JjelliL084TXR4bXM3d2tt?=
 =?utf-8?B?TU5Rckd5OUJuejI4Z3JKS2o0MjErTTlicGhMaG9GeG9nNEJTU0JhRVJmWG5a?=
 =?utf-8?B?NU51bzlYMGxCTHhCWUttYitReStlMDVOL1JKZXVOSnI3QWlwM0FLRVhkeS9R?=
 =?utf-8?B?VXh1NmdBSEQwM0RzTWJyOE5sOE9NOUxXZXJnZzB1aU1sdTZKdzdieEllTzFT?=
 =?utf-8?B?cVQ4Sk9ETFg5Q1B1cWJYenJNZHVPMDBWODdtcGZLOXBOZmgzKzJWZlFUd0Zo?=
 =?utf-8?B?V3VBMlZnaFhEbm4wRW5lSEtuVkdReU1nNVJpWnBnbXN4eTJPd1AvMU53Wi93?=
 =?utf-8?B?K3BPNTRxcnVFWllIcmpDUFFjVzlOQUFTWU9oWnhSNCtBRElTODZXbDBVaGd3?=
 =?utf-8?B?TGdvd2hJUzdpRnVSY21hZWRDWDVicURxY3QwRWdqMWdMWlJKVzRGZz09?=
X-Exchange-RoutingPolicyChecked: m4bg6NFs1UWzlhep+h/6CJQFlluREQ2Q9p0pMYJCm9wUMj40dO7xVaI6Ip5Ev84ufsohDBKd+nfnDJ4ngtCMvO9g42Imp2JVEprnqSDlAIOxpYhy9BDs443S70/ntYkTjSfz9YjwmzwEQ6vAsXCTX3eXhBRWTR2IViUd6r4Lh9RIvM7NaFCP1HqcVvph5/mNG46yJP0YgiwFfUhWv3Knw7vWD6NZolTTHqFYpZFg0OldKI6T8XSCkg7557HegaimJIodzZsVXKv1kQ7AkQz/6Tip3YI/auqz1uQMpNvi0ipy7YRy7aqpRs/B36oS9npG3+Sd/K5J4kkWtEKes7508A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bf848b-8203-4923-3fc6-08df2ac35dfd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:51:09.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar3vmCLMmESUvyRWze9zZhLBYllT081ANuJiljrwvSiE8N564z7c6rC7h9Q22shhtFUAMcutOV+UBu12UW783w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
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

On Tue, Oct 06, 2026 at 10:57:40AM -0700, FNU VISHWANATHA wrote:
> From: Kornel Dulęba <korneld@google.com>
> 
> A kernel panic caused by a list corruption was observed when the IPU6
> driver is running under heavy load. The panic would reproduce
> consistently within a few minutes of the test suite running, though
> never during the same test. The corruption would always happen in
> list_add_tail called from xe_bo_pin_external:
> 
> list_add corruption. prev->next should be next (ffff8bb9862912c8), but was ffff8bb9e811e2a8. (prev=ffff8bb9e811e2a8)
> 
> Having prev->next == prev, suggests that node was re-initialized without
> being removed from the list first. This indicates that the BO might have
> been destroyed while it was still pinned.

This is a bug if true.

> Looking into xe_ttm_bo_destroy and its caller ttm_bo_release, reveals
> that the latter supports a case where bo->pin_count > 0, albeit with a
> WARN_ON_ONCE. Since ttm_bo_release sets bo->pin_count to 0 in that case,
> add a complementary change to also remove bo->pinned_link from the list.
> With this applied, the test progresses much further, with the newly
> added warning seen in dmesg.
> 
> Test: atest CtsCameraTestCases
>

I don't doubt the test case but this an investigation for a proper fix.
 
> Signed-off-by: Kornel Dulęba <korneld@google.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index f2634d048cd4..c5989db950f7 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1688,6 +1688,11 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
>  	if (bo->parent_obj)
>  		xe_bo_put(bo->parent_obj);
>  
> +	spin_lock(&xe->pinned.lock);
> +	if (WARN_ON_ONCE(!list_empty(&bo->pinned_link)))
> +		list_del_init(&bo->pinned_link);
> +	spin_unlock(&xe->pinned.lock);
> +

It shouldn't be possible to get here with a BO on the pinned list, so
this is papering over a bug some where else in the driver.

I'd prefer 'xe_assert(xe, !list_empty(&bo->pinned_link));' be added to
the code to assert this and if this pops, we case down the root cause.

Can you please file a gitlab issue with the details of this failure so
we assist debugging and get a proper fix?

Matt

>  	mutex_lock(&xe->mem_access.vram_userfault.lock);
>  	if (!list_empty(&bo->vram_userfault_link))
>  		list_del(&bo->vram_userfault_link);
> -- 
> 2.34.1
> 
