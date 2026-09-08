Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9FAC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F3B10EA12;
	Tue,  8 Sep 2026 04:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H3Brcddv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF0210EA0A;
 Tue,  8 Sep 2026 04:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788843304; x=1820379304;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SDZRo7PTM0ALr33hj+0qtOZ/hmF0bKvLnjbsAWIjLfE=;
 b=H3BrcddvLWd7eLIXZaCu2NN9t3Nb2xXkERT36of4R8wOGe8S/YGsCD0a
 xg2jB9VwIVT/+2lhqdni1tPJo+Ng9OL5BX6ezKfjsryrswclkab57VX56
 /oOfW9tzfKB+LhxqKN9hPEjNH4h+GoxzOopJYcBgPYhio0EuvIrFvuMBS
 LSwAeoFEYaU7zv/BFhAIWZF8qDXHvTqzqEQJGuHrxGiDhsxKqsMWlIkxy
 LKY9FkYraPti3Zx5meaXcmkLnrC7kLqtAB/ZjByLNoqmEHYTC+MfoLEVu
 RBdfg9ymWO23lsMTPbSmabCXpqmUJKGjpUrI7BCH2pbP/+93KmSVydV4R w==;
X-CSE-ConnectionGUID: /heW/XArRzySjSwWU6ZsDw==
X-CSE-MsgGUID: VTZrRy1sTd2Z7LOhptI9cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88171423"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88171423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:55:03 -0700
X-CSE-ConnectionGUID: G9i/2ffERO6h8zW/wfo6pQ==
X-CSE-MsgGUID: ouqXU4fBRhGmBU585UE2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269556115"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 21:55:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 21:55:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 21:55:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 21:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUGcIQz8MMrcw0MyxSv/8YdhfUKDr1a0FkMI4gufucux/uQoCsBs+oWo5PbJZpp2z6wfOcOzWZtI0I2iqp6EfWdiP4yalrXZDehF2fUu7fS6HvAxGUQsfVhfjc+1ZAz5nRZd/OvY8NAq7c8LaI9ZB42MrzZ6QujRfViMRIDL5PdIoUzpSM5+yyNaomxCW1JuTlYZAqRlFxyjV7qiqOl1w8DyiRKcASkOFnbAqLu6EeHUzetsfPf3241Z7Hf2J5LURB7RFPcFCDrVNMqzVRl6oNCe511z0D5WJ12CbnVa4VypnqhqrRodBeoTTXzHFvhnOzFjXEBQf0SsuvRJAGkkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG8H0jWNSzf9n8dtqt2cwvFS3DNcXndvX/WnUrzgsC0=;
 b=d/AFI2IXahmW3y3WLLwJxA+Y5U1fq6ZkqkPOexEeLbCB2dCBciBfaIZQP+UlTCd6T45AFwnSPdYY9jXSiz5+ySsRPSwDywhDPUhC1LwEB82Cxosi+nXyzGdrU9p0BRkgCcx0qLJASLAcg/oJLFN5RUhoxbFHtzlbKSuahuv6ukyfxVnTN2AbY/QrBxY5MnIb7z2iJxnwqXPYm89JHN0vHn8VUOkhNAlYKAS/An4Ze45lUkOCTgBd76FIL3moyGdeXSmAMGQ5/yeCHkTyZ6dL4aJp2TQvEf37HlTHTSoR/080IatdjbojAn9IFLP4L6Wt41nJHu0SKiIhLUybo2ZGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 04:54:59 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 04:54:58 +0000
Date: Mon, 7 Sep 2026 21:54:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v7 2/4] drm: Add drm_user_fence helper
Message-ID: <ap+VIDl99BTDQpqO@gsse-cloud1.jf.intel.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902152049.183685-2-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd69004-2061-496f-de2c-08df0d65557b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: RNyfO52O1u5NI24J8++amanyC/zyc9dCr52irbskT3+fCevep8x5C0/quZqLKWBN0bsXF83c8LVkjSHm1uoxjAN1QVrnTuOJjade2fMh3hvQhbufmHdAMNA7I+gczHhxnw8JCBnFPyxfEOQRzaBWUFFXNXMwOjTPo7CPpMbwKH5KUogw7IgB7CXTpJkmSBtPbvCtsbW0FKzluBXSriJjZM6RMsAfLSBfTIbsnbkE6+YJxssaER83PHc++hCb8rZlb7MeZU41snV5veJJlrASdd0YxJBw2pKZ0VolvhS+HGCHol4sTb1eunpAyFyHQfzfzwHyVu8tSpJbTSnFudX2l1HxqXFXFVcGthsCUAhWOcdqz3oUgfrP4YSI816cYUjiDsSp6/nyAzOzH/MSVyQ/0EZ/XF1XT1D1Rp6vWJIAEOtylA2YPkf3IhoIJJME/3wYDuwQ+nf4r7Sd1NOBrDF8oZ+Qzy9uKh7VkS9v7hY9rFZcuvIDutAP2VRFoiqj3o/unfjLMb1H8QhYwbFRoAM88ogmenDQWOl640/SNAqd0gZEn7qYZBR7I6CjAbvEGcUrkTOh4KP4HCTrvGhOUQlUYeKXVDpcdQJ29uKxsLFomteAnzMuMD6vOpT4X8DpoMxp0DiXGWBiXOk6P6+q/9gFtvcU1ZXh6ZPsQI1ay8gbuTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXk5UStlUFZJczlmTjhCUEFXQ2d2L2l4c0h5TW9QYWhkRC94UDhUb1hWV3pC?=
 =?utf-8?B?aUtPKzllWU9jVjBzYVNnVXNYNGJuc0psMXJ2OExobmtWakVuYjJlWGl6YnpG?=
 =?utf-8?B?UmZZWVZaWFJFSStaMXdoZUxEMXUwVlMzRFpjTGhNVWdqdGIvYUlWQ043WjZJ?=
 =?utf-8?B?REJZbDRFTWlsbnMwdmFrY2hGQ3lVdmU0MzZZOWZtNXFwZnY5SFdUK0R0U1ly?=
 =?utf-8?B?eEc0U1ZqYlFiSC9KZHhXRUM1V3hkbDQ2eVhTbko3bmE4djFBN2R4R1NXWStt?=
 =?utf-8?B?VEVTWk5sTHFvVEVhck5HZmJ2b2hVTmRCQVE5TzNnS3owS21tNllqUzFJVjRL?=
 =?utf-8?B?ME5jU2tCQjZMSy96TC90MVZLRUpDYkdYODRPeFNNdGczOG9raWRjcWRjeC9z?=
 =?utf-8?B?U1ZVSG1UNGhQRFlOcGJ1eU14enZhcXFkeEV1c085YjJsWWR0OExHbm5XNEJr?=
 =?utf-8?B?SEFkMkNtbCtNc1k5aHFMNGlia25YMkJOdlV5RUtHUGxiS04rTEp6dDNMcEV3?=
 =?utf-8?B?SEttTnlHWHJMRHo5WHRuZmFEZEVDd0VzVEZyQTBibzBxS2dOZmJ5OXNCejF0?=
 =?utf-8?B?V21DYUlWQWVwaEtad3VJa05JTEoxcmlTWURsU1JKc3VKYmtLczBFVmRCTWZO?=
 =?utf-8?B?WXVoNEVVL1NGS0drQWp4S2Q4em9sdkZGMzc1aVNuaDlET2lha0kvdXNZWkZN?=
 =?utf-8?B?dFZNN0R4V1Q2dE15V2ZoM2tVOEZDbGtDNHQ5TGw3VS9jWGdRbkJyK3JnUnYz?=
 =?utf-8?B?eUNKZU1WUHJCUVdCWUwrNzg2T0ptNjM4SnZFc0pzelRlb3dnUnhId3h6RWlh?=
 =?utf-8?B?aWRmYjJHTHdhR1ViNDZXTTZ5NmVjNjY1a1lDZUFGaGc0YjZncnlkRUtPZlhN?=
 =?utf-8?B?OFIwUUVsMytuQWV6dkNuYnIrTmM1Sk4vU1l3VEgyN2dwaW4ycVdHSWQ4MTF1?=
 =?utf-8?B?N2V6MGJGVHZuWlI5Slo3VFh5MG1taUpuYW9Ed3hvSTRFcno5TVpVQW5Oa0h1?=
 =?utf-8?B?OUlURFIyM2d4NytVMDQ0aHFhM2hVUURNL3hnSjNOQk1uNURYcXprR0R4eTVs?=
 =?utf-8?B?cGd2WE9XT1g4dlNaemFvVzJWMkZJblQxUDlWeS9LS3NSUkZFYjY1dEVjSm03?=
 =?utf-8?B?STE0WkxhMzcrSGZSdzk3WDkzcEZ2Y0xPV1Q3d3E0ZVAvMmNqbldDVjhocVJW?=
 =?utf-8?B?M3gwcEhFNU1PMmRuMmtyS0lVQUF0a0tXelZxbkhCOEJhdnJUVWZKbm1TQ3l0?=
 =?utf-8?B?TGtnak5kV0lkcG5SUXhHR09ITUUwLzZOdnV2OTRvNlVRMENLK1h0UnpQSVR1?=
 =?utf-8?B?cjI5Mjg2WHlMZWRwT1RuR2kwSnJLeXAvM0xZTCtDOFVyZ1pNZVI3YTF2ZXRS?=
 =?utf-8?B?a1JHNzVwRUdrT0tDc0ZjcFpaNW1uRlM1MitzeWhRMFhJNEhZcnQ5ZWFHNVAx?=
 =?utf-8?B?clp0N3BZeVREVHhhYWRxZXROTzZ4L09abWVDdkRBZGEyaHh4Y2FYQldnZHhx?=
 =?utf-8?B?NDUzSTJQYVArdEgwc3dyclBlQ1g3K3Z2RVZtVXBwelpqNDFBU0NrbU5XRUZE?=
 =?utf-8?B?aFQ1dVYycHdBSHoyNjRQUlRVZVF5aWlOVzl2VnY1RXZUNEkvNWhLd3BxcmM3?=
 =?utf-8?B?N3VTRmhEU3NnbmlLYWVTcFJyVitqeFNVeGxnZlRVeFhDeWZQRFFwSUtLd0Q2?=
 =?utf-8?B?V3dlODVwZFFlR3hIMy9CNlF1VTVBeWRiaUplV1FtSFZQNVJKZDMwWVNDSkFS?=
 =?utf-8?B?MGE1Z0N1NURqTXMzYkxxejZ5enAxTXl4Vk1OdGF2TFpKWXhwUlhxZGx2TTlk?=
 =?utf-8?B?RmNRMXRhUUlENlFJNVJ0bUE5SnRlSE5yZ0RWMG9HZjBIeHBjU3NqVWlzYThh?=
 =?utf-8?B?MlFJV1JSRnB5SExhRnIwYlNBbUJFVDBVdUhYVEQzUm44RzJFdDBZZ3BMZXBD?=
 =?utf-8?B?dGhSYk5ldjBUVkcwTkIxWVpSeUJTOUhFeDE3WkRhbnpxQ1VnYTBEOTZCN0Np?=
 =?utf-8?B?bVBrU2ZCa1dWZ2RIQzhyd1BLNEwySnJaMjhUaFdaL2pGL1l6ZjFURytVTmtQ?=
 =?utf-8?B?dlJkT25va1FxTUdySDM2VDJJN1VGWi9GaXBrWFhzM1Y1SUg1d1ZZMVBRTmdn?=
 =?utf-8?B?dWhER3BwOEJkKzhtcUgwUEFBMXUzbXdsNWVIYnJxbmIwMFYrZnViNmErRjBR?=
 =?utf-8?B?dmF2bUlseGg0UWIzdk0yRjIwelhCSFYwN2VIeDhCTmpwakJVNUZNSU1UMHZE?=
 =?utf-8?B?RnUrQWRlZ0ZyV3RzT3VUM0hXRHZUU2l4MytRRWxqUjdOd1pOT3F2SEJIaDh6?=
 =?utf-8?B?SCtSdjNHcng2ZWNGRmVpd0NyYzgxMlZ4dXBvRHE5alhHNHBWRm9RelRFZFM0?=
 =?utf-8?Q?gLQ6YkqPIsckoxwU=3D?=
X-Exchange-RoutingPolicyChecked: qkyk7xQ1W/2DiPI5yAwFMAVVRgoQF6EKycpD3vTRXk+KJ7xvt2ld9YIvBhmaRJGHTQjEFroLNV2nbeuD2pDC9XwueYsyUsOL4oiFI71AZXCfvVCA35AgfFYw6BJnh2PeuBeZc3BID6tQaXS50hVkT9PJ5Yk6/2Ni0mDHy/dh6aPw1sqZhlxQfRHekG1G7BDl9wrWqhbSwBj0CsItQsc7sA4bog6w4kYwibbBn/UVrkkJfkvr/TPFk7xy0aPH3SXfbfVqHi80MwK5ulzUMKu+uAEBJM1yi6mR8Oj5s0W49L2LNfT0eGKvAULsrOeJ2n0x0NV51kr7prhXu3V0LJeQ1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd69004-2061-496f-de2c-08df0d65557b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:54:58.8286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ6oEBkEEy1TxWKnrhQQty23bzV2U3QlA6P4U2VwYNaNsrke4f2WTRdNKyD85E3ixxLYNqgol1klITy4B4DVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
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

On Wed, Sep 02, 2026 at 08:50:47PM +0530, Srinivasan Shanmugam wrote:
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
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I09da42c688392326ed78235b302fba893e570eff
> ---
>  drivers/gpu/drm/Makefile         |   1 +
>  drivers/gpu/drm/drm_user_fence.c |  70 ++++++++++++++++++
>  include/drm/drm_user_fence.h     | 122 +++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_user_fence.c
>  create mode 100644 include/drm/drm_user_fence.h
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index c5be8e80d0c8..ddb770738992 100644
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
> index 000000000000..0f229b7210a9
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2024 The Linux Foundation

Same comment as previous patch about odd license.

> + *
> + * DRM user fence — extends drm_work_fence with kthread_use_mm() support.
> + *
> + * Use this when a GPU fence signals and work needs to access userspace
> + * memory (copy_to_user, fault-able operations) from a kthread context.
> + * For work that does not require userspace memory access, use
> + * drm_work_fence directly.
> + */
> +
> +#include <linux/kthread.h>
> +#include <linux/sched/mm.h>
> +
> +#include <drm/drm_user_fence.h>
> +
> +static void drm_user_fence_do_destroy(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(wfence, struct drm_user_fence, base);
> +	struct mm_struct *mm = ufence->mm;
> +
> +	ufence->ops->destroy(ufence);
> +	mmdrop(mm);
> +}
> +
> +static void drm_user_fence_do_work(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(wfence, struct drm_user_fence, base);
> +	struct mm_struct *mm = NULL;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		mm = ufence->mm;
> +		kthread_use_mm(mm);
> +	}
> +
> +	ufence->ops->worker(ufence, !!mm);

I think you inverted the naming vfuncs for drm_work_fence vs drm_user_fence.

I'd expect drm_work_fence.worker and drm_user_fence.writeback.

> +
> +	if (mm) {
> +		kthread_unuse_mm(mm);
> +		mmput_async(mm);
> +	}
> +}
> +
> +static const struct drm_work_fence_ops drm_user_fence_wfence_ops = {
> +	.writeback = drm_user_fence_do_work,
> +	.destroy   = drm_user_fence_do_destroy,
> +};
> +
> +/**
> + * drm_user_fence_init - Initialize a user fence
> + * @ufence: user fence to initialize
> + * @wq: workqueue on which to run the worker
> + * @ops: driver operations
> + *
> + * Must be called from process context with a valid current->mm.
> + * Grabs a reference to current->mm via mmgrab().
> + */
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops)
> +{
> +	drm_work_fence_init(&ufence->base, wq, &drm_user_fence_wfence_ops);
> +	ufence->mm = current->mm;
> +	mmgrab(ufence->mm);
> +	ufence->ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_init);

Same comment as previous patch about EXPORT_SYMBOL vs EXPORT_SYMBOL_GPL.

Matt

> diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
> new file mode 100644
> index 000000000000..d35438eaa9e2
> --- /dev/null
> +++ b/include/drm/drm_user_fence.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2024 The Linux Foundation
> + */
> +
> +#ifndef __DRM_USER_FENCE_H__
> +#define __DRM_USER_FENCE_H__
> +
> +#include <linux/dma-fence.h>
> +
> +#include <drm/drm_work_fence.h>
> +
> +struct drm_user_fence;
> +
> +/**
> + * struct drm_user_fence_ops - driver callbacks for a DRM user fence
> + */
> +struct drm_user_fence_ops {
> +	/**
> +	 * @worker: Called from workqueue context with the process MM active.
> +	 *
> +	 * If @mm_ok is true, kthread_use_mm() is active and userspace memory
> +	 * (copy_to_user, etc.) may be accessed safely.
> +	 * If @mm_ok is false, the process MM was already gone; skip the
> +	 * userspace write.
> +	 *
> +	 * wake_up() or other post-signal housekeeping should also happen here.
> +	 *
> +	 * WARNING: Fault-able operations such as copy_to_user() may block
> +	 * indefinitely if userspace registers the target address with
> +	 * userfaultfd or backs it with a FUSE mount. Drivers that cannot
> +	 * tolerate blocking should use copy_to_user_nofault() instead.
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
> + * struct drm_user_fence - DRM user fence with MM borrowing
> + *
> + * Extends drm_work_fence with kthread_use_mm() support for drivers
> + * that need to access userspace memory when a GPU fence signals.
> + *
> + * Call drm_user_fence_init() at creation and drm_user_fence_add_callback()
> + * to arm on a dma-fence. Call drm_user_fence_cancel_sync() before teardown.
> + */
> +struct drm_user_fence {
> +	/** @base: Base work fence. Must be first. */
> +	struct drm_work_fence base;
> +	/** @mm: Process MM grabbed at init time. */
> +	struct mm_struct *mm;
> +	/** @ops: Driver operations. */
> +	const struct drm_user_fence_ops *ops;
> +};
> +
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops);
> +
> +/**
> + * drm_user_fence_get - Acquire a reference to a user fence
> + * @ufence: user fence
> + */
> +static inline void drm_user_fence_get(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_get(&ufence->base);
> +}
> +
> +/**
> + * drm_user_fence_put - Release a reference to a user fence
> + * @ufence: user fence
> + */
> +static inline void drm_user_fence_put(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_put(&ufence->base);
> +}
> +
> +/**
> + * drm_user_fence_add_callback - Attach a user fence to a dma-fence
> + * @ufence: user fence; caller retains their reference and must release
> + *          it via drm_user_fence_put() when no longer needed
> + * @fence: dma-fence to watch; one reference is consumed on any return value
> + *
> + * When @fence signals, ops->worker() is called from workqueue context.
> + * If @fence has already signaled, the worker is queued immediately.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static inline int drm_user_fence_add_callback(struct drm_user_fence *ufence,
> +					      struct dma_fence *fence)
> +{
> +	return drm_work_fence_add_callback(&ufence->base, fence);
> +}
> +
> +/**
> + * drm_user_fence_cancel - Cancel a pending user fence callback
> + * @ufence: user fence
> + *
> + * Return: true if callback was removed, false if it had already fired.
> + */
> +static inline bool drm_user_fence_cancel(struct drm_user_fence *ufence)
> +{
> +	return drm_work_fence_cancel(&ufence->base);
> +}
> +
> +/**
> + * drm_user_fence_cancel_sync - Cancel callback and wait for worker to finish
> + * @ufence: user fence
> + *
> + * Must be called during teardown before freeing resources. May sleep.
> + */
> +static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_cancel_sync(&ufence->base);
> +}
> +
> +#endif /* __DRM_USER_FENCE_H__ */
> -- 
> 2.34.1
> 
