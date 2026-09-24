Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160C3C9831F
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C20C10F7B1;
	Thu, 24 Sep 2026 21:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TeLasT1w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1483410F7A3;
 Thu, 24 Sep 2026 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790283669; x=1821819669;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2QJDGvcMuXjYhTfj39SZ6GJwFwrs5CUphNb5Jwuru2Y=;
 b=TeLasT1w1Q1hTFnYf18JGT/TXw280RZo4AvlAa6jZOdFVylraSqXOKPT
 5QYPIFBeMvdI6SyReEe2RccAXkZTdJrMNxV2vHLEfJyUIJPaFA7srM9xG
 OwH0WX08947e5dWVP1JgN2RQRJq4lWWahnWSksA071KnyIhL/3B23cLJr
 /wrr+NxVUEh16Y9XnaTfZEJY4E4oGuvSF3n5bQglbeqyFc3GOW/W0IMGK
 6lGFftH14Pp+5eOaSwVhB5ahserNzkS9oCneoJsoAYqeMZEfuJtTiv7Zk
 T7tXRy5H0vh5xZgsorhI//VMawEonk4R0gH9GWwObrSYcHvsFjyboVULN g==;
X-CSE-ConnectionGUID: nzDT6T8KQ6etLfiQJmQplw==
X-CSE-MsgGUID: ceJROL3OSayGIi2SDpysqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91175176"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="91175176"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 14:01:08 -0700
X-CSE-ConnectionGUID: PGfWjULBRxWSOQFZVb862w==
X-CSE-MsgGUID: Z1VdF13RSGyLTC5GrNvrcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="273704601"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 14:01:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 14:01:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 14:01:07 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 14:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsT6V03kLjxc0De0ylRaqGZeB+tsUzFmiYjxHa7nQd9rnbdZJJKOiZdIu9Cn5GAHrsHc/kxcoAPIdDBobvCfBMZYhVvT1tYuTucFfGBn2AIHv9o3Gjb39kTSAxetq8ryjkGBCn+6JYB3TiZA6k35uS35aSFkGtQVMf7QKhpZT2O88f2jxZHJWepi3aHk2AoH5PgxAdPFx/hvAo7QHYSHTsltmETCTVf6Z8hSy9rcRlyx1KE7i7PmehS4ZkuPtP16DCtlfXXnaQG504yXP89R9Hn3+TxwtQgaeygJ+zNbHS2EVnwyMZhsIRNxlYqO2FBEpmQrRlKpHYcVIEStAb0Bkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnFpNvG/M51xVukhIf7HXwR60ucYWe4JTrr1GADBlDs=;
 b=W0l64HWbebzF3p/dwCPXwd//ZMLbR4XWcTOQEm37aI2UpltJDTDrmGnZTwc2Jkx/hSLbAp9Ts2gIsOsAxHiZaGtF2fXXqdeMOVZFmXtzQY6qbVR6FlaElsPLdUZ5YAalH3dkFm9NumKEONmJiobUHGXIUKZFE81mrRxZwnUK2VdC4N/9fiADt1mWEqAW9Ia+r9uJm3ttQEYgV3gpiInQ6RQhrKeLnhVzZqcg114WlnxtAHaygdtonTUAA1r8INXkBP8wvTsQG4bCwwFz9h0DVhyjrZNIED/jlzdqIx9YXDV1MjS63d03aNXYsW/SdUMbV97+sX1OttaXn2yVQSaPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 21:01:02 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 21:01:02 +0000
Date: Thu, 24 Sep 2026 14:00:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/3] drm/xe: Don't unload the driver until all drm
 devices are freed
Message-ID: <arWPi/VCCBUkpGQ3@gsse-cloud1.jf.intel.com>
References: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
 <20260924080455.25458-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924080455.25458-3-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: PH8PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::27) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: b145212f-3ca9-4194-de0d-08df1a7ef0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dxIMTzLZyr52/pg9brZbfxH7wvEl3A+mQpmg24Ag9BUBPDhPhVIhswhxmn947HAwz0ob7aOyRfen9iMZ3KGOrIrMiaXyFr5kMRtZJtjrZO0KIunVIsV/uN4kQ02mjd63mRgPuAVW9EvC9ThWJHg9mlJU9Y3wCa0OMbO+KmLGjBlhV8UEAqqTFgpXvj1JN2ddR3jCi9FI//LAIxBvcw/ni2iJ56pHIPZYDiB24Xkv1MPqn/zwxfusnpD8fZlC3gNWrQ/HGjiJgrGzx0ZYx+MLXnojXQJYv4cZOiwzes3rlkpMtSclO/4N+wmTdqn3OJYAjnLYscA/ll82U8Tmijrj5uZ3rd+NzAjJ4juEoFKc0fT8KHlxCU7hyVMonR/UV0xEk5hMeZJTbN+m6ej87VVDgZpTjiiWgwatqlueQ7njwIKr12ociBrbN+OiRC9Q4eYpTRsYds7wU75KUpZOMpFoPR7F4DfN3LS4WRbD0HcidrlkprPqZwT4BUgvHLgCdyZxbDhvYb4pXXo0teGzJBydD7iAH9vqvzoEjZq9EvYJAQg5xmfunc361Y8TQIDPhzLPJPwu9LVlkC1OADh2Zwqg5aojy6mTR0WmRsMRp5NMdmlP36fSAgCLU3eZ9xphSjRikvUs3IVDgsiKq1c4nXa2fpHFiEAiNLmfSHr//s5q+NM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NMWxg0JGcwq5lkY1G7Jt1t9u5SWZByefzQ55h6RsruNRAhHJT1Y1rcdLtG?=
 =?iso-8859-1?Q?L+DKJSw5MYOD4Kj0pTF2MddVZPpkCFiJ+3+JqwzppE7Vcw6pOgOAF2TIkX?=
 =?iso-8859-1?Q?w8Zjx9wYJHuBi2DX1G204Ke6lmsdAurBYt5vki7HfA4ASvKaoxJv8puWI5?=
 =?iso-8859-1?Q?EoDyhndQLAgteqj3SfNr8e+QWK56xn2Pii1GtpTy0B8BRTebWG1NiSH+aA?=
 =?iso-8859-1?Q?4bdBPbHqjOEnyoXcVfAo4eLyMuK/ggRJMBHxBuLM7KfN7Hajlng3S/twAt?=
 =?iso-8859-1?Q?xWhZ2gNcbLxliw/Rxdt1A/9lIPRyiA1nzrq9JVp8n8ebxx8xK/hNKmbbfB?=
 =?iso-8859-1?Q?GnTCBYoP4Vu1Z3sRrejDk3qoKMqB3Ef0W8DHUfv0OXSGiz1PWKcKm4TnIi?=
 =?iso-8859-1?Q?AhZ+67oMW8ZMLJS7oY/zmd3U/7dCMYeyoimitO7tpWcglBZ31B5u5VHKjo?=
 =?iso-8859-1?Q?YeSv8cUr80/kjVwQp89IVLJ4DZrX0INE4eCvnv6KNh7ZNL1s09b3bnaFin?=
 =?iso-8859-1?Q?vyzX2+cQ09PyhU2zv93wzMKjfqBqogjKQkf3J+748vJcVoxS1D2XEerJi+?=
 =?iso-8859-1?Q?ker/PmdxYH4pqzUS5n6cBCAkHnkEpggU6cKVRCgK6BqoYzGTzmrbBCElBC?=
 =?iso-8859-1?Q?+8970uqNTUNBPW6qrH5hu2i02mALr+jHTxn5Muqk4dhElEp1I5h9Hdy25H?=
 =?iso-8859-1?Q?cimNUeuTvTTWBUlW4GNZEg3D5fpLJxeo3zIFBuxO4zKIFQL8eenNcKynSY?=
 =?iso-8859-1?Q?ho6j4BP15ZM0xQCJRv8+xrG3mY719Jz/nIe9aInAM2r1UUEHqI134+QVws?=
 =?iso-8859-1?Q?qBUm76nkF64KDJv/T/hRKmMhD1/6DEhr1dIJS8oymT8IgOsKoGjjloGc34?=
 =?iso-8859-1?Q?rGKJ6OlN3KVCdzfO6paV0VwG2LqpfweQfFvnB8aZNNo4gL/G+g/qkPLmfh?=
 =?iso-8859-1?Q?qdSQis/BL0kXeWNeZ59BsMIpnK1amdlmMqlaSDAZUApIkZ0gyHE4YDpt1x?=
 =?iso-8859-1?Q?uGp+eGltUDXDemdPjUrYiQ927M1ShZ85CO3go1z4UCGOcC/pG5HsBXOaC+?=
 =?iso-8859-1?Q?kXI5zuI6BdamEPNpaefs8E+DTauaSbic56p33A/z/OiozA93WbjslYx8ff?=
 =?iso-8859-1?Q?ZAUDws8D9X0A3vCFfBlIuJMaper0Aw/qS8QsqBlovh055HDGhEbfF2JNLw?=
 =?iso-8859-1?Q?WRPQEix/MHhQjIVOv80Rl+d5tDTOXBqbPPtACUIAjM3me/9tREfsfOqNBt?=
 =?iso-8859-1?Q?bwuBXBo4Mf+9jS8ehfiS/q4nV/BeHIVAvHug2wORvIRJ0aUhPkaoRn9u0L?=
 =?iso-8859-1?Q?MbCIbXDk8lqQCGPeLgo/eI60IYPdB4WCS0QVQ953HVoUV0OvFEeJPAwjPu?=
 =?iso-8859-1?Q?SYhJcHXlOEHJ3Nqu+10uqm8ZQe9iRGBcD5rCe4jdlmgobnvzg2acpVXCe9?=
 =?iso-8859-1?Q?bsGM55ek5RtrM2ECf7xlaSTShvJL2HD7kT13NSx28SKtUoDJJHHbdBJFYD?=
 =?iso-8859-1?Q?WrNyVEn86sDrnEzU3ROjNXtQaZqRCqDBBpU34YzCfygoUiQ4DYgRtbKbTp?=
 =?iso-8859-1?Q?QWVfUpuhiUZwZRDSdfOpdJUSuB/KubMqYYnALDyKVOt3jxpcgNDXePlVUZ?=
 =?iso-8859-1?Q?JUUckQtN4Ls2vbxyXvt9dIZKlsmiKCgc2aq7nY4oZ+tFpJ5umnDH1mussU?=
 =?iso-8859-1?Q?7CINkVllhtetNjpvJWuXYreHLiub1eyvCQqFXxCp3pW2Ga/Mv/eJn+6Ns6?=
 =?iso-8859-1?Q?iXur7eoEDKvBmwRUk9LSVARUnnl2TYTobuq+Gt7Ff8AOK9+zxp7ckObtAs?=
 =?iso-8859-1?Q?9X0X/3qvAEEFkqRALuoDzghENUYnxdI=3D?=
X-Exchange-RoutingPolicyChecked: scjfBDWRE6+vwudE+LovXeeDOhPe6Iqa/vSe65VVSvAi5/D+JnNlmwKi2PCu7zRsS1ecj2kvkXUj/KiKH3JNRBTy8ROA22WyJgsOjigl3LEmQFd+YEBq+u1TdiFKQEDT8xGtUnHh09qHp+K6QoXb82xBdI/w+V41IiVwI/+WqG96Fk2R6g0r929hNPaz4qAlo9lYtc5BfHXhNHxHD6gb/XEcNOMaabXME9ZMGK0PGLpWoXkOqWckTfZ8Kht3rcH1YiQL15vNf+03HiBxUablm15LcpWWeYNpaxYmx1xURXfC12l9k7oKnZTN+c/Kg+W+u188Y9OuW/S4j1/GGaQ6HQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b145212f-3ca9-4194-de0d-08df1a7ef0f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:01:02.1957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+KPVexPDXE5ZxbMxf58eLkyr8EXFbBlcyr0imxDfgV7yFY9fq2OXERZMWqD2IbwCgurS1j8C5yQn21rrMxgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
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

On Thu, Sep 24, 2026 at 10:04:54AM +0200, Thomas Hellström wrote:
> xe, and shared helpers it uses such as drm_gpuvm, already take bare
> drm_device references (drm_dev_get()) from several contexts, for
> example GuC submission fence workers, EU stall, OA and PMU sampling
> code, and drm_gpuvm's own vm object lifetime, without pairing them
> with a module reference. Since xe_exit() is only invoked after the
> module's own refcount has dropped to zero, none of these references
> currently prevent `rmmod xe` from proceeding while they, or the
> underlying xe_device release path they can trigger, are still
> outstanding, i.e. driver code belonging to a module whose text is
> being freed could still end up executing.
> 
> Close this gap by keeping a device-count and waiting for it to reach
> zero at module unload, then waiting for any release callback that has
> started executing to finish, using the drm_dev_release_barrier()
> infrastructure introduced in the previous commit.
> 
> The wait for the device-count to reach zero at module unload is
> unbounded and non-interruptible. Rather than blocking silently forever
> if a reference is ever leaked, use wait_var_event_timeout() with a 20s
> timeout, well above the typical maximum dma_fence signalling time, and
> warn once if devices still remain by then, before falling back to an
> unbounded wait_var_event() so a stuck rmmod is at least observable
> instead of an indefinite, silent hang.
> 
> Note that if a reference genuinely leaks, this still ends up as an
> indefinite uninterruptible sleep, which may eventually trip the
> kernel's hung-task watchdog. The alternative would be for these bare
> drm_device references to also take a module reference, which would
> instead make the module unable to be unloaded unless all its devices are
> manually unbound first. The wait-based approach is chosen here since it
> keeps rmmod usable in the common case.
> 
> Register a driver-private SRCU domain via the new
> &drm_driver.release_srcu field on both xe drm_driver instances, and
> pass the driver to drm_dev_release_barrier(). This keeps xe's wait for
> its own release callbacks to complete from blocking on unrelated
> drivers' release paths.
> 
> xe_device_exit() is added as a new module exit hook. Its entry in the
> init_funcs[] table is placed between xe_destroy_wq_module_init and
> xe_register_pci_driver, so that (exit functions run in reverse array
> order) it executes after xe_unregister_pci_driver() has forced all
> devices to unbind, but before xe_destroy_wq_module_exit() tears down
> the module-lifetime xe_destroy_wq. This preserves xe_destroy_wq's
> existing teardown ordering relative to xe_sched_job_module_exit() and
> xe_hw_fence_module_exit(), which destroy kmem_caches that work drained
> from xe_destroy_wq relies on, while ensuring xe_destroy_wq itself is
> only torn down once xe_device_exit() has confirmed no more work can be
> queued onto it.
> 
> v2:
> - Updated commit message to describe the actual implementation (a
>   single 20s wait_var_event_timeout() followed by one pr_warn() and an
>   unbounded wait_var_event(), rather than a loop retrying with a
>   diagnostic every 10s) and its uninterruptible-sleep tradeoff
>   (sashiko)
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/xe/xe_device.c | 42 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_device.h |  2 ++
>  drivers/gpu/drm/xe/xe_module.c | 18 ++++++++++++++-
>  3 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 205cb4e7f9e8..bfb1b482d83d 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -8,6 +8,7 @@
>  #include <linux/aperture.h>
>  #include <linux/delay.h>
>  #include <linux/fault-inject.h>
> +#include <linux/srcu.h>
>  #include <linux/units.h>
>  
>  #include <drm/drm_client.h>
> @@ -311,6 +312,13 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> +/*
> + * Driver-owned SRCU domain used to synchronize completion of driver release
> + * callbacks with drm_dev_release_barrier(), so that xe_device_exit() doesn't
> + * have to wait on unrelated drivers' release paths.
> + */
> +DEFINE_STATIC_SRCU(xe_dev_release_srcu);
> +
>  static const struct drm_driver regular_driver = {
>  	.driver_features =
>  	    XE_DISPLAY_DRIVER_FEATURES |
> @@ -335,6 +343,7 @@ static const struct drm_driver regular_driver = {
>  	.major = DRIVER_MAJOR,
>  	.minor = DRIVER_MINOR,
>  	.patchlevel = DRIVER_PATCHLEVEL,
> +	.release_srcu = &xe_dev_release_srcu,
>  	XE_DISPLAY_DRIVER_OPS,
>  };
>  
> @@ -357,6 +366,7 @@ static const struct drm_driver admin_only_driver = {
>  	.major = DRIVER_MAJOR,
>  	.minor = DRIVER_MINOR,
>  	.patchlevel = DRIVER_PATCHLEVEL,
> +	.release_srcu = &xe_dev_release_srcu,
>  };

I think everything above here will get moved to a DRM gloval srcu per
Christian's feedback?

Assuming the just dropped in favor of globlal
drm_dev_release_barrier(void), everything LGTM.

So feel free to carry this is in the next rev:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

>  
>  /**
> @@ -372,6 +382,9 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
>  }
>  #endif
>  
> +/* Number of allocated struct xe_device */
> +static atomic_t xe_device_count;
> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -391,6 +404,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  		destroy_workqueue(xe->destroy_wq);
>  
>  	ttm_device_fini(&xe->ttm);
> +
> +	if (atomic_dec_and_test(&xe_device_count))
> +		wake_up_var(&xe_device_count);
>  }
>  
>  /**
> @@ -461,6 +477,7 @@ int xe_device_init_early(struct xe_device *xe)
>  		return err;
>  
>  	xe_bo_dev_init(&xe->bo_device);
> +	atomic_inc(&xe_device_count);
>  	err = drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
>  	if (err)
>  		return err;
> @@ -1501,3 +1518,28 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_device *xe, u32 asid)
>  
>  	return vm;
>  }
> +
> +/**
> + * xe_device_exit() - Device subsystem exit function.
> + *
> + * Exit function to be called at module unload time.
> + */
> +void xe_device_exit(void)
> +{
> +	/*
> +	 * Wait for all devices to be freed. 20s is well above the typical
> +	 * maximum dma_fence signalling time, so warn and keep waiting if
> +	 * we're still not done by then, since it may indicate a leaked
> +	 * xe_device reference is stalling module unload.
> +	 */
> +	if (!wait_var_event_timeout(&xe_device_count,
> +				    !atomic_read(&xe_device_count),
> +				    HZ * 20)) {
> +		pr_warn("%s: Waiting for %d xe device(s) to be freed before unloading.\n",
> +			DRIVER_NAME, atomic_read(&xe_device_count));
> +		wait_var_event(&xe_device_count, !atomic_read(&xe_device_count));
> +	}
> +
> +	/* Wait for any driver release callbacks to complete */
> +	drm_dev_release_barrier(&regular_driver);
> +}
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index 6d3d6d5eba29..83d6dafab53c 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -283,6 +283,8 @@ static inline bool xe_device_is_admin_only(const struct xe_device *xe)
>  }
>  #endif
>  
> +void xe_device_exit(void);
> +
>  /*
>   * Occasionally it is seen that the G2H worker starts running after a delay of more than
>   * a second even after being queued and activated by the Linux workqueue subsystem. This
> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> index 4bc28dfc1992..c61bd33546f2 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -12,7 +12,7 @@
>  #include <drm/drm_module.h>
>  
>  #include "xe_defaults.h"
> -#include "xe_device_types.h"
> +#include "xe_device.h"
>  #include "xe_drv.h"
>  #include "xe_configfs.h"
>  #include "xe_hw_fence.h"
> @@ -162,6 +162,22 @@ static const struct init_funcs init_funcs[] = {
>  		.init = xe_destroy_wq_module_init,
>  		.exit = xe_destroy_wq_module_exit,
>  	},
> +	/*
> +	 * xe_destroy_wq_module_exit() must run after xe_device_exit()
> +	 * (below), since freeing a device can still queue work on
> +	 * xe_destroy_wq that must be drained before the module can safely
> +	 * unload. At the same time, xe_device_exit() must run after
> +	 * xe_unregister_pci_driver() (below), and xe_destroy_wq_module_exit()
> +	 * must run before xe_sched_job_module_exit() and
> +	 * xe_hw_fence_module_exit() (above), whose kmem_caches are still used
> +	 * by work drained from xe_destroy_wq. Exit functions run in reverse
> +	 * array order, so this entry must sit between the
> +	 * xe_destroy_wq_module_init entry above and the xe_register_pci_driver
> +	 * entry below.
> +	 */
> +	{
> +		.exit = xe_device_exit,
> +	},
>  	{
>  		.init = xe_register_pci_driver,
>  		.exit = xe_unregister_pci_driver,
> -- 
> 2.55.0
> 
