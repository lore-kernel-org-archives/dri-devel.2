Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF66606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FOzB82NU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106B210E045;
	Sat,  7 Nov 2026 04:49:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEF110E045;
 Sat,  7 Nov 2026 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794026966; x=1825562966;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=R6gVv2CfjpyJvk891KiaQ8HfpJzO4MA04QJmz6vdyZ8=;
 b=FOzB82NU9+er00nwaRbhLUwlTMwcRVzqf7bhwfcVrscOVNNS64gxuKx0
 9//WGUTknAj4v2gX98/FAiMIZLmHoVxZ3Wba3pSUgTc8xRhUgCHgHGOoA
 j2wpX3+b+gu8vCH5ltDWKqQKlnYNK5ciFT+qx8BK2mCnkdeWo31AYoRPD
 4Qe4kciKhK5yA/sXJUaGaHqqLrjspDBWCud527nGV2VEVO9WyTbtBMxcc
 l6RxjNWP1f09O8SMy9ko1N9r72/2GTYE1XFKWHlAfqEBthGobjHnwzS5b
 wjVLjK1rRHewPAqqKjnaZyI0vFOGh9VLFCJck+wWQHj2cUMYLnWmvfVwt A==;
X-CSE-ConnectionGUID: k77HG1phSLCVnrwL+Ud76w==
X-CSE-MsgGUID: wPnIk9KnRbmhzjCbIhIRIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2739591"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2739591"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:49:25 -0800
X-CSE-ConnectionGUID: hqD14jSmSbyZdtymmgYrPg==
X-CSE-MsgGUID: 2ljgKIZLTjW4stsgjKg2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9184703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 20:49:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:49:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:49:24 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:49:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcbjHsRqFDB6GQ/tk/I+HoE25g/QjMDZOuO9rihLm/r894vy3GBvfMvUZWynAL5RT1rTqgvqZuwuhMwrAoP/DiOIQYTkCk3ncX/ASnH0j9VxAiaKUYJ95sOZ5qsu3PwFVX5UbatqyoHBSMZUTELxNITOCTm8mDsOZNwAPSDBI+nJbDVx+5Zqdupl1K/7CQ4JGuWpl2H+ZhqVVSOwHvks/IyhAT+XweflesdvuTjKYzeHAerUs4+mOuSjfLr1dm89b1aqhC3F6iBntO4IId9PWOwZQySlPQ01QsJMZKoLZBA6mjjmKJ/thrdq03MQnBc5mb2gcQH9CZyq6SbWAhYJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCoEGNz8occjMrHdxyMHd7bP2tgVJZzqrbov5mCouHA=;
 b=SwPneZZ0vOWexXq9FHJVOhXh5IdxwWV71IB07C/cX8QrXhDQGowmezgxe8gwQAYc/7Zg/XlV+i6G5xGnBC31xo0POUeCBP1GvOFmoafXq8lHG0Nnz1oPpUtzjgJ2LS8OxGxw8yfJ4Wdpo7jlom0CUWDll6lCOdoUNVQuRDj0V7MK0Y7CMHpiNoowmaW2+MKKjuKwuLK9gaOsB1CO7/BL1WaImcqIgBUV8muPl9UKhTsH9DEtGIH4HdtR5Y0nWJ9Rc2lz/opXjMD/0+WJ0uAUR61AY9DhRPubS1hNJkgP9aFZGGunMVEnAtZ8KwLPyOOoSvyQw2fwDXUN/FwzN4QwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DS4PR11MB308671.namprd11.prod.outlook.com (2603:10b6:8:50c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:49:21 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 04:49:21 +0000
Date: Fri, 6 Nov 2026 20:49:18 -0800
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
Subject: Re: [PATCH v3 15/33] drm/xe: Track BOs backed at a sub-optimal page
 order
Message-ID: <au6tzuytWiqiqRUM@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-16-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-16-matthew.brost@intel.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DS4PR11MB308671:EE_
X-MS-Office365-Filtering-Correlation-Id: 194b1b4c-cf22-4b1d-4e17-08df3c8a7d28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: CwuWP7QnFmRwCAZa8Gf3jcc2GosGIcK/rXIVxAoj82HNfnYoVum7dOzuY6IEYfIYuyVeBQTbWk8YUb3kr7o5+2zIoZXXKLl2OhoD7a2Td6coy+MpEWZlEvCnQVo1xjHSY2FlFzFwgHrygFzL3jQa+S6L2gNrsoxN1RQMzAtvIYnmU5TPyVaO//YhJ4YtGV/Di9RNdAKW1favvD/AnYKMlm6AIrMv/IOM3Sjql1dQwlQiE/O7/kpYLxBhqUMHpTnFPqm8S/ZRPaERMorPQ2w0u6ITKD/yHx52xmEhg35YI+kac1JmEKmiQZ1AhwqGcJtnCeewgXUmaWGaWF72pKJ/03+2kvvZhrJBXOtQ3AqSlI8P+dZoj+ION5Sn+HvN75riOcvEJ+0v8Rc8GtgI4jJjj/vWrCDRCY3jfipS0UspU2DGf53u2NeZU6Jc6WACxXK0qJ6y6HJzpM6+W471cWT8bfjJ0jrxGokNoM544SOURUGw8y8hQyMrMh1nG7lB4+UPCoXsIo0VT0rqy3Rv3dJLZuM7qGhKhakPNuqtsM1qka240A7XnHSHAhvKX3loDbgQQByR3hhX4DddSoMEQb9qNYHbApq8WDK29LtC7z6q87iH7/FO0tMaI8FQyalnm1G//K3ZfdaGBtn3AVXmKR0LwgBOEwXKUImg9JbcKaibSMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qFjY3W8xH5UTar06AkSdUaPcoJtKx/aIzf2sb80viW/sUD6AwXSZbpSRbP?=
 =?iso-8859-1?Q?VEPaS93PDlFzkO6qx7kW+RgJFfl4xUrBj/MkBTODORHYW3uGMY738HbrNr?=
 =?iso-8859-1?Q?htDUI9+sxQH2FF8tA9cSUIIvahA98w4sqqCs2101r6MdCxMO+Rd0Tj4TMM?=
 =?iso-8859-1?Q?n8RLf/85WMOw8rWOoSlALVLv7n8k0SPiIBl8NC9DM0RyoVW5bFKBfK1gJo?=
 =?iso-8859-1?Q?Fd5VI1JvEUvNuY0kCp87fxDAm7KowLnz0BgqdGBKFGludEPNX6uj5d/TYd?=
 =?iso-8859-1?Q?6KxlCMnfCykHCfmmT8VlH5glXzLV8sOySxWhJP8JhbeaPoxc/xCs7ScnS6?=
 =?iso-8859-1?Q?JfHO9T1Jwa1gpmzAIo0QFzZfFuas8TFPpo8+0YC2rCsvVY4+kB5JAaLsdn?=
 =?iso-8859-1?Q?loKIQQ8sbRfj3acRhci+gIQNqLCD9E+k9zNMK57uZP3AmkUB8ve+rt0NV0?=
 =?iso-8859-1?Q?XBwZN9SeZxDLt5X+t3io+fZXNkfWP04/iJJ1uxr9g0shDmGvBfxmoh3iG2?=
 =?iso-8859-1?Q?f8YKFd4g6g3G9O1Fs+vu11VR/vVkVqpXOBTqMgthVgN/KvSULaFixWHkTV?=
 =?iso-8859-1?Q?l+OD3m9x7z6ngOLUajRwc+ugXK3rL/HA6/mYQrmROThOB6xvl0XXOD3M6N?=
 =?iso-8859-1?Q?E/qNIizTjGc84Y0O13RAnko9+GLQovOrxdT7nhXgWI3d1844BARgdp8Xan?=
 =?iso-8859-1?Q?b5IDavzXdOE/kQwT8Fib/kbV9a531Iv9yINhLn2rPMXsuk10hJRb+/uoZs?=
 =?iso-8859-1?Q?9V7vpVTVciOTaooZsfLypp0Ke8aZa2jZ2PE7GzLMyPVAfCC29STRyOsv56?=
 =?iso-8859-1?Q?YU+l1yDAmBoE0sVG419Z5+vqw2FzmTpFqn9G/T+5CFEaWVQMt853jQ+A8u?=
 =?iso-8859-1?Q?tdiwWttaibzuxSsgQ5M2Q+tdqn83OWSTsOz5jiLYgLJH3R0eyfKsbqJlU7?=
 =?iso-8859-1?Q?VvWoBc16RNfKvJz3laf0td9teoMMCTaRCdAdB5KM7vBKLTsyjV7yk8p1kw?=
 =?iso-8859-1?Q?u3aKfruWMb98SDFeecsQbvIbeWYfiNVbU6NKlUH76ehOQmjCFNdxAtPp3I?=
 =?iso-8859-1?Q?SgpqTzfLAV/f6hjT+A2nZSlkdKe+f855SGVMi2jKssnt60DwaJ82+Af5ir?=
 =?iso-8859-1?Q?PuL6EgIyiORLbLBsrBDdVxoP6kVL165hH7kM9JiwvuAQa2HJQlZknpQojq?=
 =?iso-8859-1?Q?22ftJy0JMThYvgqMKjWwuyHwYmAXtLOfwW2nmSnNj8hMvMIe9IQy+1jHPv?=
 =?iso-8859-1?Q?ldVj+Qciv0DcKDXg63x4Cd/XEEWzJmDH46iCObSB8X4omxuPZG+GcpcFPI?=
 =?iso-8859-1?Q?VKtbdwPf4jjBwWqjXRuFGW65ZGEpO43BiS0ChAe8GNjoA/4CdX4KH6tGoc?=
 =?iso-8859-1?Q?gorikgmS8gaPfQmNZwHPzTrj6OCZ+W7irBEI2CKjO83yq4AOJi6Vdqn3Fk?=
 =?iso-8859-1?Q?YiHGYdT7K8e9AQ3lxHXSF/ZuqteD9OelhUanFD6OKUSkPv+0tXIAdd/yUj?=
 =?iso-8859-1?Q?PqaOVw7jfrS0OMgnWVP6cnf1g9LhZowWOuxI6bZod/fpkg8Op8+nFcU1mt?=
 =?iso-8859-1?Q?Wtyhio7tRKlR15v0uxkH8adY9nwnF2PZifUW3KjD7OgkdS+s++WT/l2QRE?=
 =?iso-8859-1?Q?xWLhmtJeUzgbhBZ1pZBIv9pvTsZNsScbF96yhNtrM1B78LoOrlfbNbiYjf?=
 =?iso-8859-1?Q?ppriDgy75FJ0eGkp65fRnG8ThkJicFcQr1lRt0rn5q7HstRpDyqzEWlq4g?=
 =?iso-8859-1?Q?hY1ffTjh9sMUzhQmlmxmmwEfBcJADp2Y2HTgYr4yrQIA0gRU5HKY2HeLyK?=
 =?iso-8859-1?Q?oNtttHi3+gTAi3NgIu5ffC0TLoNMPwPei4TEiyt6h+q05OlXKBxU?=
X-Exchange-RoutingPolicyChecked: ABp+dh8LoCuf5GjDbJZFTaPGm1VVqh4EUPst36uzxDaNGalG1FflKfwb2ktaanrg5SaL4fQDAfkheEOS1wm9T+g9YcTXSq2YBFAdJ8DZGFJGdB//0BorX+CJyW1ECNkMCgpyxBYPBwQ1n0EIKY7XEarr/fUsXhoI1rGE3wECgmaPhfJJFsw/MQ+Y0+dUR//a92nQfgzGUhBPxct6Bkd4+PyROVFp7S9UKnK6RcUgEZdLXQQXx8QU3hVBJAl/sNOqkM+do21n6FBmoxX8UZh5mFsJGmN1v3C34FG7Vhvt6eGvFuDjWa3EGxzQObcdYMTF7tBpUlbDt5oTE3s/VL5viA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 194b1b4c-cf22-4b1d-4e17-08df3c8a7d28
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 04:49:21.6250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+B7QYjMjpw9pzdE1ewC06zFwkRhvl96B/tJnLqfty/cwicrAwcHr6SdELxS8SpEdNcQDR3DbfFD/JJ/j6aN0fuvAJetUI98K0Ae8pQ0v2NYq3Z6bGsfhBJpIr98EUfo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB308671
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

On Fri, Jul 10, 2026 at 07:56:01PM -0700, Matthew Brost wrote:
>Add per-device tracking of BOs whose backing TT pages were allocated
>below the pool's beneficial order, as reported by the
>TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (read via
>ttm_tt_is_beneficial_order_failed()). These BOs are future candidates for
>a defragmentation pass that reallocates their pages at the beneficial
>order.
>
>Add a mem.defrag sub-struct (lock, list, atomic count) to struct
>xe_device and a defrag_link to struct xe_bo, initialised at BO create
>and device init. Membership is updated from xe_bo_move() via
>xe_bo_defrag_update(): a BO is added when it is a populated, needed,
>non-pinned ttm_bo_type_device object flagged
>TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED, and removed otherwise. BOs are also
>removed on pin, on purge, moved to dontneed, and at destroy.
>
>Only ttm_bo_type_device BOs are tracked.
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
> drivers/gpu/drm/xe/xe_bo.c           | 115 +++++++++++++++++++++++++++
> drivers/gpu/drm/xe/xe_bo.h           |   1 +
> drivers/gpu/drm/xe/xe_bo_types.h     |   6 ++
> drivers/gpu/drm/xe/xe_device.c       |   2 +
> drivers/gpu/drm/xe/xe_device_types.h |  19 +++++
> 5 files changed, 143 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 4ee48cdc02ac..ff324caab6da 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -926,6 +926,9 @@ static void xe_bo_set_purgeable_shrinker(struct xe_bo *bo,
> 	}
> }
>
>+static void xe_bo_defrag_update(struct xe_bo *bo);
>+static void xe_bo_defrag_remove(struct xe_bo *bo);
>+
> /**
>  * xe_bo_set_purgeable_state() - Set BO purgeable state with validation
>  * @bo: Buffer object
>@@ -954,6 +957,7 @@ void xe_bo_set_purgeable_state(struct xe_bo *bo,
>
> 	bo->purgeable.state = new_state;
> 	xe_bo_set_purgeable_shrinker(bo, new_state);
>+	xe_bo_defrag_update(bo);
> }
>
> /**
>@@ -1003,9 +1007,100 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
> 	/* Commit the state transition only once invalidation was queued */
> 	xe_bo_set_purgeable_state(bo, XE_MADV_PURGEABLE_PURGED);
>
>+	/*
>+	 * The backing store is gone, so the BO no longer needs defrag. Drop it
>+	 * from the defrag list here so the count stays accurate even for purge
>+	 * paths that don't pass through xe_bo_move() (e.g. swap_notify).
>+	 */
>+	xe_bo_defrag_remove(bo);
>+
> 	return 0;
> }
>
>+/**
>+ * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
>+ * @xe: The xe device
>+ *
>+ * Initialize the list, lock and count used to track BOs whose backing TT
>+ * pages were allocated at a sub-optimal order.
>+ */
>+void xe_bo_defrag_init_early(struct xe_device *xe)
>+{
>+	spin_lock_init(&xe->mem.defrag.lock);
>+	INIT_LIST_HEAD(&xe->mem.defrag.list);
>+	atomic_set(&xe->mem.defrag.count, 0);
>+}
>+
>+static bool xe_bo_needs_defrag(struct xe_bo *bo)
>+{
>+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
>+	struct ttm_tt *tt = ttm_bo->ttm;
>+
>+	xe_bo_assert_held(bo);
>+
>+	return ttm_bo->type == ttm_bo_type_device && tt &&
>+		!xe_bo_madv_is_dontneed(bo) &&
>+		ttm_tt_is_populated(tt) &&
>+		ttm_tt_is_beneficial_order_failed(tt) &&
>+		ttm_bo->resource && ttm_bo->resource->mem_type == XE_PL_TT &&
>+		!xe_bo_is_pinned(bo);
>+}
>+
>+static void xe_bo_defrag_add(struct xe_bo *bo)
>+{
>+	struct xe_device *xe = xe_bo_device(bo);
>+
>+	xe_bo_assert_held(bo);
>+	xe_assert(xe, xe_bo_needs_defrag(bo));
>+
>+	scoped_guard(spinlock, &xe->mem.defrag.lock) {
>+		if (list_empty(&bo->defrag_link)) {
>+			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
>+			atomic_inc(&xe->mem.defrag.count);
>+		}
>+	}
>+}
>+
>+static void __xe_bo_defrag_remove(struct xe_bo *bo)
>+{
>+	struct xe_device *xe = xe_bo_device(bo);
>+
>+	guard(spinlock)(&xe->mem.defrag.lock);
>+	if (!list_empty(&bo->defrag_link)) {
>+		list_del_init(&bo->defrag_link);
>+		atomic_dec(&xe->mem.defrag.count);
>+	}
>+}

Assisted-by: LLM

NIT...probably worth adding a comment saying this version
can be called without holding bo dma-resv lock?

>+
>+static void xe_bo_defrag_remove(struct xe_bo *bo)
>+{
>+	xe_bo_assert_held(bo);
>+
>+	if (list_empty(&bo->defrag_link))
>+		return;
>+
>+	__xe_bo_defrag_remove(bo);
>+}
>+
>+/**
>+ * xe_bo_defrag_update() - Update defrag list membership for a BO
>+ * @bo: The buffer object
>+ *
>+ * Add @bo to the device defrag list when it is a ttm_bo_type_device BO resident
>+ * in XE_PL_TT with a populated TT whose pages were allocated at a sub-optimal
>+ * order (ttm_tt_is_beneficial_order_failed()) and it isn't pinned. Otherwise
>+ * ensure it is removed from the list.
>+ */
>+static void xe_bo_defrag_update(struct xe_bo *bo)
>+{
>+	xe_bo_assert_held(bo);
>+
>+	if (xe_bo_needs_defrag(bo))
>+		xe_bo_defrag_add(bo);
>+	else
>+		xe_bo_defrag_remove(bo);
>+}
>+
> static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 		      struct ttm_operation_ctx *ctx,
> 		      struct ttm_resource *new_mem,
>@@ -1231,6 +1326,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 		xe_tt_unmap_sg(xe, ttm_bo->ttm);
> 	}
>
>+	xe_bo_defrag_update(bo);
>+
> 	return ret;
> }
>
>@@ -1267,6 +1364,15 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> 	if (lret > 0) {
> 		xe_ttm_tt_account_subtract(xe, bo->ttm);
> 		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
>+
>+		/*
>+		 * The pages are gone, so a tracked BO no longer needs defrag.
>+		 * This shrinker purge path frees pages without going through
>+		 * xe_bo_move(), so drop any stale defrag list entry here. Ghost
>+		 * bos are never tracked, so guard for real xe bos.
>+		 */
>+		if (xe_bo_is_xe_bo(bo))
>+			xe_bo_defrag_remove(ttm_to_xe_bo(bo));
> 	}
>
> 	return lret;
>@@ -1909,6 +2015,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
> 		list_del(&bo->vram_userfault_link);
> 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
>
>+	__xe_bo_defrag_remove(bo);
>+
> 	kfree(bo);
> }
>
>@@ -2414,6 +2522,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
> 	bo->ttm.base.funcs = &xe_gem_object_funcs;
> 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
> 	INIT_LIST_HEAD(&bo->pinned_link);
>+	INIT_LIST_HEAD(&bo->defrag_link);
> #ifdef CONFIG_PROC_FS
> 	INIT_LIST_HEAD(&bo->client_link);
> #endif
>@@ -3020,6 +3129,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
> 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
>
>+	xe_bo_defrag_remove(bo);
>+
> 	/*
> 	 * FIXME: If we always use the reserve / unreserve functions for locking
> 	 * we do not need this.
>@@ -3078,6 +3189,8 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
> 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> 		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
>
>+	xe_bo_defrag_remove(bo);
>+
> 	/*
> 	 * FIXME: If we always use the reserve / unreserve functions for locking
> 	 * we do not need this.
>@@ -3113,6 +3226,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
> 	ttm_bo_unpin(&bo->ttm);
> 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
>+	xe_bo_defrag_update(bo);
>
> 	/*
> 	 * FIXME: If we always use the reserve / unreserve functions for locking
>@@ -3145,6 +3259,7 @@ void xe_bo_unpin(struct xe_bo *bo)
> 	ttm_bo_unpin(&bo->ttm);
> 	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
>+	xe_bo_defrag_update(bo);
> }

Looks like list update needs to be called from 2 other places,

1. ttm_bo_populate() getting called from CPU fault path and from TTM fault
    never calls xe_bo_defrag_update().
2. In xe_bo_shrink() if ttm_bo_shrink() returns >0 value. This will inflate
    the defrag.count value.

>
> /**
>diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>index 6340317f7d2e..4186cb51af87 100644
>--- a/drivers/gpu/drm/xe/xe_bo.h
>+++ b/drivers/gpu/drm/xe/xe_bo.h
>@@ -224,6 +224,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
> int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
> void xe_bo_unpin_external(struct xe_bo *bo);
> void xe_bo_unpin(struct xe_bo *bo);
>+void xe_bo_defrag_init_early(struct xe_device *xe);
> int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
> 		   struct drm_exec *exec);
>
>diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
>index fcc63ae3f455..9eea9ab380e5 100644
>--- a/drivers/gpu/drm/xe/xe_bo_types.h
>+++ b/drivers/gpu/drm/xe/xe_bo_types.h
>@@ -54,6 +54,12 @@ struct xe_bo {
> 	struct ttm_bo_kmap_obj kmap;
> 	/** @pinned_link: link to present / evicted list of pinned BO */
> 	struct list_head pinned_link;
>+	/**
>+	 * @defrag_link: link into @xe_device.mem.defrag.list for BOs whose
>+	 * backing TT pages were allocated at a sub-optimal order. Protected by
>+	 * @xe_device.mem.defrag.lock.
>+	 */
>+	struct list_head defrag_link;
> #ifdef CONFIG_PROC_FS
> 	/**
> 	 * @client: @xe_drm_client which created the bo
>diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>index 97cc2d185e45..bb93425a5c70 100644
>--- a/drivers/gpu/drm/xe/xe_device.c
>+++ b/drivers/gpu/drm/xe/xe_device.c
>@@ -607,6 +607,8 @@ int xe_device_init_early(struct xe_device *xe)
> 	if (err)
> 		return err;
>
>+	xe_bo_defrag_init_early(xe);
>+
> 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
> 						       WQ_MEM_RECLAIM);
> 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
>diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>index 95e7cea91cbf..9e6244d8f41b 100644
>--- a/drivers/gpu/drm/xe/xe_device_types.h
>+++ b/drivers/gpu/drm/xe/xe_device_types.h
>@@ -296,6 +296,25 @@ struct xe_device {
> 		 */
> 		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
> #endif
>+		/**
>+		 * @mem.defrag: Tracking of BOs whose backing TT pages were
>+		 * allocated at a sub-optimal (smaller than beneficial) order.
>+		 *
>+		 * Such BOs are candidates for a future defragmentation pass that
>+		 * tries to reallocate their pages at the device's beneficial
>+		 * order. Only ttm_bo_type_device BOs are tracked.
>+		 */
>+		struct {
>+			/** @mem.defrag.lock: Protects @mem.defrag.list. */
>+			spinlock_t lock;
>+			/** @mem.defrag.list: List of struct xe_bo defrag_link. */
>+			struct list_head list;
>+			/**
>+			 * @mem.defrag.count: Number of BOs currently on
>+			 * @mem.defrag.list.
>+			 */
>+			atomic_t count;

NIT...Not sure if we need it to be atomic. Count is only used in patch 16 and
usage is approximation anyhow (doesn't guarantee anything as list lenght can
be changing).

Niranjana

>+		} defrag;
> 	} mem;
>
> 	/** @sriov: device level virtualization data */
>-- 
>2.34.1
>
