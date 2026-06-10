Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D3CCD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C7210E6F3;
	Wed, 10 Jun 2026 04:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JcYAnK7h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5719710E6F2;
 Wed, 10 Jun 2026 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781065159; x=1812601159;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0lJ9Q8TVwzbvKJ6CRxYyBioJht4rFPd8jjl/nMVVycA=;
 b=JcYAnK7hn2/Wnu6o8mDSiccaEel1pNq5YID5S/iqxQu0Lxc3DlA5z2dW
 IwWxZCzPSknTnif60jlcbWwJwL9Wu7GSQ7P+RUBIeavaiWheoDTspRbuo
 mHWZS/qY1+hB4LYbR5A3IcfdN+MNbqMcLcADKzf8OSQFfE6diSP9sU6Fj
 OnrGWdJWeL/1Cs3Za5o+2poQ341yqGFdYbcgljeGNXWl1F0p6z6lCMPg0
 nbYR0h6ytDfZZAIn7bQFsrWOJyLwTnYWkoEwag/0CaAcRjF8gKH3lJ7Ly
 HfhmNrAzegbFWLlFA5ICoKQk9zvBiZMcx4AdkRnhhbIlIwLpli0fzEKaK g==;
X-CSE-ConnectionGUID: LEMUI3WwQL+pOZTp5EErdA==
X-CSE-MsgGUID: uvtyTUmUTQWutK7itkMdRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84417095"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="84417095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:19:19 -0700
X-CSE-ConnectionGUID: O4ModquLQOWHJaec/QzawQ==
X-CSE-MsgGUID: o9Btnv2yQmyw37D143p0tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="243086186"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:19:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:19:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 21:19:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l54lLFVDqFLCm2N10h9IY1RALVIRMz25Ay4NXneLRYcMHkyusGUeidqBFeJlICRr5H8ACseDHd73F9xrjh3GxqUPB6AzjzdpIKE6A/1gdxdIQX6r/lq6ut4f1ICtR5VUhRPEpu0OYW9MYR+sHD/rMn+AUGuvsTHZMhOu00wEG4/KgwMMScuV0SvTkvP1F8wO4kTMz3FWoesqP25CZfQJlQWJKYOC050IRtKNJ93FaBDk6kno5c3bEcg/Q77K4j/re/H4JXoLh9bFvK0ur93WsEyM3t52JLUJlwxI0hoHetQegJa8vc4DI4Rh5ddA7Xiqgbztjc4Lltwmof8u08FShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD/mPcZCoFcoEcNNZtEDpJ0M8llyBFc0g8sgj4bbkII=;
 b=MUqtv6fr/rbsFRQBDbIaNixz4QlOroHj4d2/GgO3RjUlaICFC+hoHED7dImZK9DI1GAIL1JROHtgFYU31PYQqGWyXq1e5TtsRCMeIrzhEkCwPTt1Fp+163A32ZXTOYeTO1SjxOhw5AIbOEzOkVxwRkSZE+dYzPqQI5lGznN7ASfRXNRLt9+jZuGkDEyiPHZa5I0deM1R/+/V9oF2B3Jg00fuRopEPVxGUXcdG0rJSIM4TVGYDY/R3cB2SfKySTWkHmcCCgiT9tzEuF2b/3CF7rqXYA15MSKBD13KrU1JJ9/Xi852jpqLBZ0DeDQET6MsPHfGWekVOfUHYawRHwmmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SAVPR11MB9576.namprd11.prod.outlook.com (2603:10b6:806:4e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 04:19:15 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 04:19:15 +0000
Date: Tue, 9 Jun 2026 21:19:11 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 5/5] drm/gpusvm: let the drm_gpusvm core context purely MM
 level
Message-ID: <aijlvyqblELUBAJi@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-6-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603065620.2555316-6-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SAVPR11MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 52417d74-c59d-44f4-8332-08dec6a76e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TUQdluWd5ObjqJHg9/05GAFDZnh60XLZfVjdCjntlpaiKaES0wWnio4klqsRuB8QTDhEVi8S9yMBIi1G6SBK2pD+to+IBIqLL8qdOkgfTFQRPlg59vhZpCa7wajMt3Okdcvj3FnmRBy2B2Sj5fA4xN5AomtWf31n8WMaWsBGY71J9KxhQc7A+UIetn6kg+WXtIzDHr7ntdX8ibFy4NTXrCBAp5d7ocVsoc3Jwa8PZ66+Y7l+SRkJqNXZ3xMVUD7JRo8qeZYe1CvM9rS/AcMsN520tlXyDSBL0lzSkhersz6vMhfDSpil5b0/GH+VoPSdkJAeLK/t6hyjnjUevLHlFzC9NMM82kLMTpJAt9UAWZmlC50R8rmjSgxHQbR+5PLzJr1lqAq/6ksQx3BN+z9qmzrkRqOumK/lhLuSgFE/rh+BrBXnUeo9g3ScfgppzIqZcr3j8U191PmsH1cfNeOGtjsq+OfbONHIb80ILIGV+q66drt6Q9vMTRHoFgkILrkO2bTci6qa0GNOsQfpXU+J4AViRQoTQh3UBTlBviouoWYhYUy1ayQmsqopR0OXOF54OvcpsZuTNNqUPmxiRj6HxuomfPXxapxMvf4VXB0FdEFFsoR3vVSKdKP/XkzrJuMkVPr7jV2QZFRqoQSRWrNODW3L0Bi1yMDzfMDx6APCwvZ5j7lwXBRwyUZoVY7N28g/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05VfpJnqQHnuyRkPPU9NV0P0K7AmPyBR3QAl/Rbe+k8DTf37S+bQUPSE4LPw?=
 =?us-ascii?Q?Gek5LKFHHaBOY9k1c+2iExXz9JMZ8Gxax1B+8hpK+WnVqmRfXtoXxiqQgzca?=
 =?us-ascii?Q?uPmkmNHk+8Ov2G+PgM0yAJ/YyKTmjLXyNIAVqTM9BqUctH1vaGlvK7YkBfbG?=
 =?us-ascii?Q?ep0yU+Qj0bznenAyvdgBBdZ3zRDgpUA28EqXvD02nIPXhHVR/TTX7GFsVhlx?=
 =?us-ascii?Q?V6PEWJfLjbJ1VO+4cyD1iG60Q0u8hN7Ws4n1TSt1kwEAeXqBSftKT0GOj7xb?=
 =?us-ascii?Q?YTG895oT6dThrz3Q/39gqju3if0Iaei0K/O/EQRlqwruvrKwXSGoAI1J6G9N?=
 =?us-ascii?Q?lF9d3kgeTq1LuVkuXYtYZy6lr+I/yqB7KJN+OYnMoFLZ3xWoFYS7/+7rLsga?=
 =?us-ascii?Q?+VWWOuviRucTxPLduWhuP9130uZ7R765Ua+1FvEyAUd7DyopdcArVEMZ7aKc?=
 =?us-ascii?Q?KSfky4iW96o6aneQEkeqfwtnID2rk4RMzKsv6CEZK3Izs6QZtPQBSiYWhdyq?=
 =?us-ascii?Q?vRvXcajjnSV6LtQyd8QBsC/6Ldw/PQ9fll+bP5BxkQ9YdRVoozoyCvrl9msP?=
 =?us-ascii?Q?oX8rYnfcxbkgT5rUfIMM+4llniL3pqJ8+cSM2yGe4RhF2CT5VxBuvv+x+42r?=
 =?us-ascii?Q?eS5jwizKe8wsD1KmqciZKQaVm6AMDQb3sHkmscGRnLBiidypasMDJ/ipMgIq?=
 =?us-ascii?Q?VO718BNYmBMRGPTdW4MuqxPi2EQ2gEh7YBZfxlGeDhm580qV7ZCuTPOk4KRi?=
 =?us-ascii?Q?Wvw0q5ShFOjrXcQ9OmBSnCuaS4WwbwzkKaYZKIiYV77lQm8MxEuZmDXrFHm7?=
 =?us-ascii?Q?+erdwgjNwpVTeFAEGVm1XHbtrskxEACy/VF9HXfjb6BvEowYt0yz7p23/ToC?=
 =?us-ascii?Q?03UbpTxpCtdaibojCtN9ZG7gY7cuStEJgjU4PLZh57BsDZ9gBszjk1SK/TN5?=
 =?us-ascii?Q?+Qh+0nnDNT8p8eQ+3SuOksIbLDcFhKM3sNSvQEkCzmi1MsMI4Hcl8Z9rfTS4?=
 =?us-ascii?Q?DgTzgEFdTUizUQlXuPkbV6CcSVbsuWJmWHbmJjCeZnkRNtyFrGDlMmQ9qsyZ?=
 =?us-ascii?Q?r2JQiZUck5XImFXzQZH5SVAi/59AWt6MbaAb2jK40WS/Uhp++9+Wd3KjqjR6?=
 =?us-ascii?Q?l9kROCq5+024ii1RxNFz1E9WwA+yn6wIhLRjEzZpfTUozuREUmHhI6d/zeRs?=
 =?us-ascii?Q?j2qvQgNvIRbA+Zqr8bkqBQCBfN2UKgiclJfqxHuBD0OJRwwhASu1IoqOsswK?=
 =?us-ascii?Q?bEtzYWsmvYa/nWzhWLQw5G9xTfP3bRPjerP0XpV9WnToh6cgJUROFA6oKOeK?=
 =?us-ascii?Q?LW+rGu/rC6IATuey9+v5LUAERyoGs2MKouHzxBt53kWdUFEV5ij8xlQkSzcD?=
 =?us-ascii?Q?I7Ht7UEr0NGBvdQn9oufLatT8te17WvCnI5WRlv9pGHk/JdcbE7k4AgGgVhe?=
 =?us-ascii?Q?yCbhFkutGMbP4B4XdWs8tnXO34hCHH2Hhw1M5cjuOUxQP0igO29IWOZ0XfUv?=
 =?us-ascii?Q?sJIIZ/GE7/W7IjfWyhcVnOGAWNfNVxyEn/19T+a4YPj5bdGK6NQh4ZoQC/Qo?=
 =?us-ascii?Q?L9wX6MABydmRHwgAsP+lJTKNKkBONG7Qssan0krPC6lKndz/KbcF5opTVjan?=
 =?us-ascii?Q?Z7fwSl8QA6l3sVZZRzNvEcugYdSbok5VCh0f9KHDtk1sOfyOL5bHvJBFU0RR?=
 =?us-ascii?Q?j6mPz2I2rjRyENLqoFzWRcJtiUxKIKN0rKwfYxESMnsgvJtkIRiOKGI4xv78?=
 =?us-ascii?Q?Rt5B3R22mLaygL6wQWINnlhTukrP9/8=3D?=
X-Exchange-RoutingPolicyChecked: kWavPtI3boqfy7HRa7r+UvGBy7SvfOIoE6cjuIwrRf8DDPZSGQh2EoLqYHWuofw8Ld9M9jwOEstc8yPubNt/S/FFzwK5M83QThDk7zpTeQx0w9Rg3WB1nQFb+wNhkJiXHqmVTH/puyuHThnfbsyhhAaa/U558SWz9weAfO6y3dvDqjBrxZlp9qL31MUuekEhNFp2hilBBwJlZO5y8/4W+/yHMKYqA7VWsvt9Xx4ijb3HRt7rsclUh0TkyZjfeRU6zzAjaZvKDArZD/e6+zBxTol90gR+vIhscCVG6mqD99zlio77pIUPS9agsmuP4D3UaVC6HwnjL1BCoTH6Ale+gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52417d74-c59d-44f4-8332-08dec6a76e87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:19:15.0820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx3pJX2Y3Kj9Au1xctZ0Yj2hJHYHPapsFYWz4LWLW6VlLuw9n164U+d8Zo5bOUzOqv+A/v0+C9H/JRFwElju8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9576
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

On Wed, Jun 03, 2026 at 02:56:20PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> The core mechanism of drm_gpusvm is HMM, which is fundamentally an
> MM side subsystem. A drm_device, enters the picture on the device side at
> DMA mapping / GPU bind.
> 
> So drop struct drm_device from struct drm_gpusvm. Let drm_gpusvm keep
> its core neutral and leave device side decisions to the driver.
> Make drm_gpusvm a pure MM level object.
> 
>   - Drop the drm  from struct drm_gpusvm
>   - Drop the drm parameter from drm_gpusvm_init()
>   - Update the xe call sites in xe_svm_init() and other callers.
> 

I'd mention somewhere that drm_device is now stored in the pages.

Otherwise LGTM.

Matt

> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 7 +++----
>  drivers/gpu/drm/xe/xe_svm.c  | 4 ++--
>  drivers/gpu/drm/xe/xe_svm.h  | 2 +-
>  include/drm/drm_gpusvm.h     | 4 +---
>  4 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 55515390c53..5cade46234c 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -359,7 +359,6 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * drm_gpusvm_init() - Initialize the GPU SVM.
>   * @gpusvm: Pointer to the GPU SVM structure.
>   * @name: Name of the GPU SVM.
> - * @drm: Pointer to the DRM device structure.
>   * @mm: Pointer to the mm_struct for the address space.
>   * @mm_start: Start address of GPU SVM.
>   * @mm_range: Range of the GPU SVM.
> @@ -373,7 +372,8 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * This function initializes the GPU SVM.
>   *
>   * Note: If only using the simple drm_gpusvm_pages API (get/unmap/free),
> - * then only @gpusvm, @name, and @drm are expected. However, the same base
> + * then only @gpusvm and @name are expected. The struct @drm for dma
> + * mappings is now required in drm_gpusvm_get_pages(). However, the same base
>   * @gpusvm can also be used with both modes together in which case the full
>   * setup is needed, where the core drm_gpusvm_pages API will simply never use
>   * the other fields.
> @@ -381,7 +381,7 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * Return: 0 on success, a negative error code on failure.
>   */
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> -		    const char *name, struct drm_device *drm,
> +		    const char *name,
>  		    struct mm_struct *mm,
>  		    unsigned long mm_start, unsigned long mm_range,
>  		    unsigned long notifier_size,
> @@ -399,7 +399,6 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>  	}
>  
>  	gpusvm->name = name;
> -	gpusvm->drm = drm;
>  	gpusvm->mm = mm;
>  	gpusvm->mm_start = mm_start;
>  	gpusvm->mm_range = mm_range;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 33c26df5111..b0b737234ee 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -905,7 +905,7 @@ int xe_svm_init(struct xe_vm *vm)
>  			return err;
>  		}
>  
> -		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM", &vm->xe->drm,
> +		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM",
>  				      current->mm, 0, vm->size,
>  				      xe_modparam.svm_notifier_size * SZ_1M,
>  				      &gpusvm_ops, fault_chunk_sizes,
> @@ -919,7 +919,7 @@ int xe_svm_init(struct xe_vm *vm)
>  		}
>  	} else {
>  		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> -				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
> +				      NULL, 0, 0, 0, NULL,
>  				      NULL, 0);
>  	}
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index ea73241d3d9..1c5195f5495 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -238,7 +238,7 @@ static inline
>  int xe_svm_init(struct xe_vm *vm)
>  {
>  #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> -	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
> +	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>  			       NULL, 0, 0, 0, NULL, NULL, 0);
>  #else
>  	return 0;
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 250c59f0930..2bea47ee171 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -191,7 +191,6 @@ struct drm_gpusvm_range {
>   * struct drm_gpusvm - GPU SVM structure
>   *
>   * @name: Name of the GPU SVM
> - * @drm: Pointer to the DRM device structure
>   * @mm: Pointer to the mm_struct for the address space
>   * @mm_start: Start address of GPU SVM
>   * @mm_range: Range of the GPU SVM
> @@ -215,7 +214,6 @@ struct drm_gpusvm_range {
>   */
>  struct drm_gpusvm {
>  	const char *name;
> -	struct drm_device *drm;
>  	struct mm_struct *mm;
>  	unsigned long mm_start;
>  	unsigned long mm_range;
> @@ -267,7 +265,7 @@ struct drm_gpusvm_ctx {
>  };
>  
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> -		    const char *name, struct drm_device *drm,
> +		    const char *name,
>  		    struct mm_struct *mm,
>  		    unsigned long mm_start, unsigned long mm_range,
>  		    unsigned long notifier_size,
> -- 
> 2.34.1
> 
