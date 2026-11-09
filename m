Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B473606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vre4xxGy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEEA10E665;
	Mon,  9 Nov 2026 01:10:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC80D10E65F;
 Mon,  9 Nov 2026 01:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794186640; x=1825722640;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=PkejXVc2S2X9x6VtlQrtSYmlGS0nKqw9/OSrcXS+idI=;
 b=Vre4xxGyfCvZ5WDax2cpluRh2BoUczVYiJGWZW8z+csSWLWL8szssBNJ
 /73+70hlqXDYMIr/O/LW6zLP0NiI/tBJbZp2SrNaz8BRfaDfkBmb/owMA
 RSvEiSQQ3Gra0FkLCI+Yq0K6WHssV4CPXei41vCsmDSkT73JqFDTTgVGE
 PFEs1KBV/FZ5FWAYuM1o9/8Ne51Wtsh7mFUlgJ3otHGLyY3BUVOe6DySF
 4C/vzAWinD5xDPriGckyNUnAMWhIhr6N6temO3Jd9EKQuKnAnpVU+iMS0
 1TvTIdqPfPfDyLs1OLMBevRiJN7bqUFHsxKWHw93dlMM12ngEQeXnEa8f w==;
X-CSE-ConnectionGUID: 7Bruv/yXQea/wrWfnW4Dig==
X-CSE-MsgGUID: cyvMBnSMRBWBu58nusH/Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3001467"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="3001467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 17:10:39 -0800
X-CSE-ConnectionGUID: tXH2Qjy0R6Svq4wmMaXEwA==
X-CSE-MsgGUID: sje0JRucRuWSJt+ka5UmYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7904692"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 17:10:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 17:10:38 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 8 Nov 2026 17:10:38 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 17:10:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh1leGr7oj3FGoq2G4xxgT3pmuCcdk77w2lVP7zq6Niw74sLpF2O0mfMh7tLUrx12Pmu0GrZrwmlTDftnv+Pj5KeU9AmBDvBrActiITr+FKQxqtu4qTPZJDwPMo7ymHCNugS9qWcF3tLg8182nBge500PaAPH4iwQSoe/6g1XnSXbH/QefslEKKfahHoGZ4zx6gcZB6xgnjturQ/m/9KyZgHIWcXvHIIW9HtWTBcVO+D2zk6nbiBTcD3El4x1ztSOu+g6+RfeBeVXKqeN+e3lYPObJu/VTTt6pgYWrFV0Egb5s9jqMbZ5KP+a2bOo6bkCnkgHJ7B+jdB61ovmycV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sywS7AucIIJmJQntNNIpaWE5A9RovJl5UBDkla3Q0d0=;
 b=kr30m9jBvU1SyjvgJ8wa+bFOdHQysLTchtKuYTce6OyjQaP/R01ae6W+YT4EibiFCT2hQDkmnidE0Otow9kvEXyL0w22Nq9fF1o2bk5FPT7oUeg+JPkotVkXsiEwDpRRBhik67CRfBE8Sid+3O541kTmnmmO+zQE9yU/Ri2VepNUFhnSS3G1SrSttvhj320J1VeuHRftDzG9VnbKax1tJ470Z37hbnVfL3OASy+ekG5Hn6Kkb610SkMUiGpUIz6IEg6wZKocN67t26ZZfm/1UAZTxUPshq+4xYyZIWumQ/DbjxiicevZ1iscXDctuuUM+hkLCCBc8sWCYsXCgHiH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 01:10:34 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 01:10:33 +0000
Date: Sun, 8 Nov 2026 17:10:30 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 21/33] drm/xe: Add defrag GT stats
Message-ID: <avEdhk66ta4lHZlj@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-22-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-22-matthew.brost@intel.com>
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be67222-9526-46a8-fb76-08df3dfe40fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|261009223027099003|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: W9+NZhwfYk3yozZG/FKWTyDwuuYv3wYwpFpJjhAuIpENc4NizAtqnOsNOD0VA2s4amMTXxw5TIojFtxw+6Eg2CI/tO2kLmAN+OmM3jRm6N2VvueAH4Mvf4oifoQByePD13Ofl475HMIzf0B2KVxd2XSxPlndoAoe6ewuLx+HR1jBlsF+VnqccaiGb2dqgqVf4SfRxF/b4YopQeo+GTDKxtve6ma9Gz7/lb+U1DY1l8VIWf9jXtRfotpm1cgUigyKW5j41mhIcHAhBOx60VAQlU5MOILt6LYDh9eziO3CmgDG5Ql9wQqxovzQO+BzKJ2QwqG2zFTjBAWRCvq41Acp9ahEMGo8v4tXDKFEPgVSd3BeF+3kNKT3YQ6SDTi39gQJ/u6fh6AvwsSK6qsUOaE4UzUyx4zQfPVGUSukQWwRtsCQ2zuV90wI6erPue79YEyVAS/e/59biJK1lt90+6F3fIFp/3J5SrlBdFCIoCLXb9/0ujPJBdpZKrTQiWcVH0Bqe5Mfb2QeJ8/my+04x58DE9pxYRrN2FnSEozjW06fuFdu5fElFlOtsOhgB1v5XOvfLYFyzg65twq1qRcMVLiiqAC4OhVQ8yt/8OeHqpPaKMxB00QYkULZqA7w/JQ8WELsFgll7uIw+/lZGFP4K3X14gIkVzeLwJWZV4IH2UPT5aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fOAnTtO+mIWm9yJPrs10c08NmdvLB30ZyCdy6JNtFGfrIlb9rYdWRKmatr?=
 =?iso-8859-1?Q?dWsI6gRuh2RDB3Hy6Y2a9wrtqXWl1wnNQzY2RFmOHRtRynCY0Mk/fSCIu9?=
 =?iso-8859-1?Q?qQrzOOiXBwUZhba2Ok03diE5t24W/9CxYhhtRgxVQygYfUBuRmCYOoJFGC?=
 =?iso-8859-1?Q?fxEk33WS461sArza/gI3MTP6RScVfveoaW58i/rp402IwkwwQjkyg8bK6I?=
 =?iso-8859-1?Q?vAi4+/6LCpzGfEO/ZT+Faj9A8yq+1fUYKuT86TzdqWSP401tqeTgX5d7Ad?=
 =?iso-8859-1?Q?Va2N3CGqjqNTz/z+QsU1oL8CL2vGrCHIo/8LM6y/x1FuvbngEzgEc3mUnw?=
 =?iso-8859-1?Q?HKb6SanQx7yxkDt2IGdupY+spHSx3XOawlkmF8R3R5Pdisofbfrf0dCWX2?=
 =?iso-8859-1?Q?YdVgcnrP3PadYE/fKQaNZKg+dCJI62qVZ2gSbLJYF4kPVvwLmYWebFC4+M?=
 =?iso-8859-1?Q?y1IT0sve+mf5RVefSY9pbKtsea2eHuSQbKFhcbbkzG1UX7WIMVPbBlg5zP?=
 =?iso-8859-1?Q?JApTvBKDGLIDQR8ELZkj43jL9bN/40g5aSgpDXC3BMW5ZMOOP7BQYzyu4K?=
 =?iso-8859-1?Q?Jmqdy5kFuknaqaWbvZIUduPMtkbxqocyQ+taF3MbB4DZkFtR3wz276cIlW?=
 =?iso-8859-1?Q?b31YWAD1u6gd+gGGwnQbYFKvciLI7ZilrM5aYve9dYwpmTzIjS3SoJZmrN?=
 =?iso-8859-1?Q?eg8Lvm2PjVAsr0snl0cGXawoZFq1uiK+UEykz/fEQuBjH46dHA8p8XGmlv?=
 =?iso-8859-1?Q?m6wuzx2SYY4b5qW1+7/8/t/s+6S7Zw4Z4huFIOVczPJeRallF15omwQyK0?=
 =?iso-8859-1?Q?3M0qRvzHfP2NlGKtSTOn23/kc+IXWpH6g8aHjnbSPelsanIyLXryevUhQn?=
 =?iso-8859-1?Q?j++nF8QNutNwVXGpmz+2uGaRmU1bQ6boldSjxU5001ylYtawq1q/703LF4?=
 =?iso-8859-1?Q?SD3Hu2WzdQFtUozbLNaWZcXfZ2v5cHKVfxpziQZXdQUJmJEuPX91oNiGCG?=
 =?iso-8859-1?Q?hOlpnLV1TCbTTtc9Rqpag0gWFs1QGmEUz1VGXwLzeZ/zpbuO5jIB5EdCdU?=
 =?iso-8859-1?Q?AceMTqhhbLOGbZmFRYFmH7M2/slHSibagsOP/0MamCwlN5Vrxx5569Yv+3?=
 =?iso-8859-1?Q?APbPbQ119LZwjhDcAD9y/m2wY28TD77gZadHyjRlzA2UUg1hA6Ys6orFo2?=
 =?iso-8859-1?Q?QRoWwSHrYagoEpmUQ1gRUmIq11F9uWlFDUwxUydTjFLtFpbKZeyO7W4PeK?=
 =?iso-8859-1?Q?IaxG+pDZ2IBOMYe4q0maIJV5Cr6RqCHVR+68yaqTDDWgn3XXu+w5SlhWoK?=
 =?iso-8859-1?Q?qicHU0dSc4kXs4Dhep3U5k9bT4qewUIU0ImFScsLnr1QGAuApmFT5fw+Tp?=
 =?iso-8859-1?Q?/xPRmKrxl+XILnfmWJrgZek+U2d5za12UHxbVGps82VcbDs1hujFKTpSr0?=
 =?iso-8859-1?Q?sunphZ4xqMLfNZAB3ctErKr6qdp4ooqSDbMK+HAYoEy7wsKR2jqJVfFBDC?=
 =?iso-8859-1?Q?Z3J0kj+ua66mcZQEHtePhWhG8P6aItC9VHKQ5f1ZAj6cIVRtCLyKwm8OT+?=
 =?iso-8859-1?Q?GK3LGu0XUIAi/MNyY/olafHqezt8K+dofz1X0Tjvl5sjjg6zEoDEIkatUC?=
 =?iso-8859-1?Q?5ui6vmIWLPAJg3Iw1+ohBImXClE+q580yx01Elv+WgrdXy224zam7YGDJD?=
 =?iso-8859-1?Q?tq7qiTLdWjWl65HqsNwLNR8mETJqHt6IeYuSXHw3MtQ+Qn9j150IJNiLRQ?=
 =?iso-8859-1?Q?9p6R8BLqM9LgGj/slhBobVFGQMd+fVVNosROFPTbnYdFkaAk0hjfeQ8oZS?=
 =?iso-8859-1?Q?cLej69P26Qxm97LvlxBHz9e/iIXq5k6tj1ppnWgOvPoKy3QFdGRK?=
X-Exchange-RoutingPolicyChecked: fAT7FghNUhxAKwuK4BqWZmAaCZpMEsXbju9tEi51j7Au/ev2fxowHvGtNB9X+JLkOgUioocE8S2TZEmwtToBUsf2s5/JDJ7f8sYW3rMUtT8B9RDhWEvRcggdOZw/r5Rf1JIknLXt9WoyLvHsW/NXnZ1zF6daqEIAuLxXGYerkMgoUsYBoglj0ibVIjZeXa2S5S0uMOwh4h0OzPFj6U4Ga5agQVVzQxdMupwt54cTUE1hGmRziAr5q8JiKJhUTmXFanlhC2jihxcx7VmI6XssaN5tMpRhFDnE7u9fR1nTWmPSdQHU3IkI0ufqVVZ3OtLOMjK4jU49F8W593m75CDWWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be67222-9526-46a8-fb76-08df3dfe40fd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 01:10:33.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSQgC6ryEz0Af5X+3IGYhpSmPvrXyOrEH9+L8HJuf9Yonfhh4I9wQ8lw4OfYMivdi/aIJGWBcRl/si/GdqirtqnUMQinXJ2ZZBeMOIv/pW0Feayn6OOeSPSgbpM29GLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:56:07PM -0700, Matthew Brost wrote:
>Add observability for the page defragmentation worker.
>
>Introduce four primary-GT statistics counters: defrag_added_count
>(BOs queued onto the defrag list after being backed at a sub-optimal
>page order), defrag_success_count (BOs fully re-backed at the beneficial
>order), defrag_partial_success_count (BOs only partially re-backed at the
>beneficial order) defrag_failed_count (attempts that failed and left the
>BO on its original backing) and defrag_mb_moved. The
>ineligible/already-removed fast path is intentionally not counted as
>either success or failure.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c             | 18 +++++++++++++++++-
> drivers/gpu/drm/xe/xe_gt_stats.c       |  5 +++++
> drivers/gpu/drm/xe/xe_gt_stats_types.h | 17 +++++++++++++++++
> 3 files changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 907cfa57481f..073d926ef9ac 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -26,6 +26,7 @@
> #include "xe_dma_buf.h"
> #include "xe_drm_client.h"
> #include "xe_ggtt.h"
>+#include "xe_gt_stats.h"
> #include "xe_map.h"
> #include "xe_migrate.h"
> #include "xe_pat.h"
>@@ -1160,6 +1161,8 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
> 				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
> 			atomic_inc(&xe->mem.defrag.count);
>+			xe_gt_stats_incr(xe_root_mmio_gt(xe),
>+					 XE_GT_STATS_ID_DEFRAG_ADDED_COUNT, 1);

Assisted-by: LLM

I am not sure if ADDED_COUNT is much helpful here. But BOs added here can get silently
dropped. Also, a silently dropped BO can get re-added.

Perhaps a better count would be a 'defrag_pending byte guage'? Also, probably make it
not-resettable so that it gives the current state of fragmentation.

> 		}
> 	}
>
>@@ -1274,8 +1277,21 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> 	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
> 	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
>
>-	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
>+	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {
> 		*needs_more = true;
>+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
>+				 XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
>+				 1);
>+	} else {
>+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
>+				 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
>+				       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
>+	}
>+
>+	if (!ret)
>+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
>+				 XE_GT_STATS_ID_DEFRAG_MB_MOVED,
>+				 *consumed >> 20);

This will truncate the size which can accumulate over multiple BOs and the size
here will be significantly off from real size that is moved.

>
> unlock:
> 	xe_bo_unlock(bo);
>diff --git a/drivers/gpu/drm/xe/xe_gt_stats.c b/drivers/gpu/drm/xe/xe_gt_stats.c
>index 789397514f3e..68e60d9500c8 100644
>--- a/drivers/gpu/drm/xe/xe_gt_stats.c
>+++ b/drivers/gpu/drm/xe/xe_gt_stats.c
>@@ -154,6 +154,11 @@ static const char *const stat_description[__XE_GT_STATS_NUM_IDS] = {
> 	DEF_STAT_STR(PRL_2M_ENTRY_COUNT, "prl_2m_entry_count"),
> 	DEF_STAT_STR(PRL_ISSUED_COUNT, "prl_issued_count"),
> 	DEF_STAT_STR(PRL_ABORTED_COUNT, "prl_aborted_count"),
>+	DEF_STAT_STR(DEFRAG_ADDED_COUNT, "defrag_added_count"),
>+	DEF_STAT_STR(DEFRAG_SUCCESS_COUNT, "defrag_success_count"),
>+	DEF_STAT_STR(DEFRAG_PARTIAL_SUCCESS_COUNT, "defrag_partial_success_count"),
>+	DEF_STAT_STR(DEFRAG_FAILED_COUNT, "defrag_failed_count"),
>+	DEF_STAT_STR(DEFRAG_MB_MOVED, "defrag_mb_moved"),
> };
>
> /**
>diff --git a/drivers/gpu/drm/xe/xe_gt_stats_types.h b/drivers/gpu/drm/xe/xe_gt_stats_types.h
>index 425491bed6c4..c42b494390f8 100644
>--- a/drivers/gpu/drm/xe/xe_gt_stats_types.h
>+++ b/drivers/gpu/drm/xe/xe_gt_stats_types.h
>@@ -122,6 +122,18 @@
>  * @XE_GT_STATS_ID_PRL_ABORTED_COUNT: Times the page reclaim process was
>  *   aborted.
>  *
>+ * @XE_GT_STATS_ID_DEFRAG_ADDED_COUNT: Times a buffer object was added to the
>+ *   page defragmentation list after being backed at a sub-optimal page order.
>+ * @XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT: Times the defrag worker successfully
>+ *   re-backed a buffer object at the beneficial page order.
>+ * @XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT: Times the defrag worker
>+ *   partially re-backed a buffer object at the beneficial page order.
>+ * @XE_GT_STATS_ID_DEFRAG_FAILED_COUNT: Times the defrag worker failed to
>+ *   re-back a buffer object at the beneficial page order.
>+ * @XE_GT_STATS_ID_DEFRAG_MB_MOVED: Data (MiB) actually (re)allocated while
>+ *   re-backing buffer objects at the beneficial page order. Chunks borrowed
>+ *   from the old backing for free are not counted.
>+ *

NIT...all GTs applied to root GT, which is fine, but probably update stats documentation?

>  * @__XE_GT_STATS_NUM_IDS: Number of valid IDs; not a real counter.
>  *
>  * See Documentation/gpu/xe/xe_gt_stats.rst.
>@@ -181,6 +193,11 @@ enum xe_gt_stats_id {
> 	XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT,
> 	XE_GT_STATS_ID_PRL_ISSUED_COUNT,
> 	XE_GT_STATS_ID_PRL_ABORTED_COUNT,
>+	XE_GT_STATS_ID_DEFRAG_ADDED_COUNT,
>+	XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT,
>+	XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
>+	XE_GT_STATS_ID_DEFRAG_FAILED_COUNT,
>+	XE_GT_STATS_ID_DEFRAG_MB_MOVED,

NIT...Few other counts that might be helpful are,
- defrag failure reason (DEFRAG_FAILED_BUSY/ENOMEM)
- time cost of defrag (DEFRAG_US)
- 'removed_without_defrag' so that 'MB_MOVED + removed_without_defrag + defrag_pending'
   is the total suboptimal size added to defrag list.

Niranjana

> 	/* must be the last entry */
> 	__XE_GT_STATS_NUM_IDS,
> };
>-- 
>2.34.1
>
