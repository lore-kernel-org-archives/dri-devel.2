Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E97AC9831F
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD6010F792;
	Thu, 24 Sep 2026 20:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MFcnxfag";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8A110F792;
 Thu, 24 Sep 2026 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790283364; x=1821819364;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=F1mOs73IugjwVkzLIEuim1dn+aEOxQ0d0jPVt3VYlCY=;
 b=MFcnxfagoIEJSi3cbSysFn91ZMHW++c3q1tJPUWSYXLdTFmF6XaflVLb
 u4wVfb/uCmMKr7O1psIRXign1WpcwOuyanLX32Tf5CokfipDjAp+GMc0c
 c+pMwA0HPbdDDROO6B+0L3tLqiy6SetpztZ9UJ7tHv9ATNF6O4Q9JpqDc
 6ofgbJGW0yG9ZLZvc5lBe28y5glUIAhXr4rX2gwmuac/ypo+nTY+pupVr
 tNw4TwmKDwyoIJ66CxY//XTsAs5Kpf3wZgmjfGqwn0DmJxO1UuDAFpNwh
 0bDbjWLUAISvtiXKCVT4ZGhLKpXr6Mlm5VTQ4cuUGbLVOqzDeIbV7evS8 g==;
X-CSE-ConnectionGUID: UTYyIQxaSiCcqIuA2BfdCA==
X-CSE-MsgGUID: LBwcjMbSSimPVePZB5iCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93568041"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="93568041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 13:56:04 -0700
X-CSE-ConnectionGUID: Zfpd1R2+QKupxfCVh0Ms3A==
X-CSE-MsgGUID: P7vvyXBhR1qeadl+82qcIw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 13:56:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 13:56:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 13:56:03 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 13:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQI+1JasIiWMsLu2XreIhUecmPYTql/XxWjtTiqQEGMEB7c4yjzrr5/jjvuZvxzRVbAQg24zR6gTUNN5iR+GJQKOrVKFC1laJe38Upbry+ylUm9LDTLIyLMQjZXO4Adwr/AxrPk2f5ERSDg7oaCraWCLqQmuEPdJUdIV0A/l1NHYduETUohPKWBbmrHdVVsscsVYCfkt3dA1yOQ9BBmbLNDpGGL3S/1Nf+XTtXEnIrhXzCuIRc9CkJ0UwhrXOLVE99hzeLGwGeRDzhg0nWb8KcPOcQ7Rc09mHrBkdSubXamJA2kwEaFvVo0vtShxn1OxtMczMovq/n0lEREitlmwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FePavYkvkr6dbWdkrMZFQA59KCMSRJQUcTkOs0hPpCg=;
 b=FoR08mVTIQ4OkAI1H/AQ0VIhhxLeoIPty4YDWfA62Dik+/u9RIBAVombWZ9kdZ6ehcKiPx3kh8RHe0G4eE97zngtP6p7HyDVUMUWptfaGSHZucymJJtOJB589/F0HATczzoeHa1jFiQEsfsrfcAmmCduv9GtyOPoYLX2SgyMs1JjBhSrcRKJQU1AwzIpSOrbbIk39j9TyPkCUnZ4zWTnx5JhmiA3DpsIY15vTuefqDXZLQJW3fSCYlo1jXdXnlaKdhotqHO7epAf5xT4C5iqSNObmyvvm3ozXToawji/fXQvyrLvYE3SXbuxu6ZXsmkJ8YmtAtxkAxq7rItEQ4jncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 20:55:59 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 20:55:59 +0000
Date: Thu, 24 Sep 2026 13:55:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v2 3/3] drm/xe: Route deferred xe_vma/xe_vm teardown off
 system_dfl_wq
Message-ID: <arWOXbXLwc3/xjWg@gsse-cloud1.jf.intel.com>
References: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
 <20260924080455.25458-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924080455.25458-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: f92b4a84-44a9-412b-6a23-08df1a7e3c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: /1GHWgeRryE4ovwRbOZdAaDp0drwh3i632Wx20fXnhBShHunNO7QAMT5CFyPPbZBp9f429WpxBgi3aGRG18PeIcPNgn4lqQ01u1jPW/+TnirpZWBN084rB37fvAuh90B/nlS3n/tRfJEiF8Zu3FjsiOZPQgSBFvIgwR9HnQtg1FBPuaPnfPCY71Vd81UG4O4BXYOM8HRsP3/h9PKemA7vwoBRj9ddB6fIlu22+G+r3le2Shk11i538Ou8yYuYY2I7F4RGX8X6cVM6W15W9FY1Z7zu67/DM7KnykXFC1NVex9QuQTwbtqXqsoSnO5ugsIzMT9M2IOSLOlKJQLNmyIgzbkwjri/GdGmpZCL8DxrSGjs+54BcfsjUIZ+IKBEk6Y4cPOuEJd0zrVnDphExwTXMJ8l7xasZCIPZbK+Cz6FFT6juDljbvFNc4fxqPEeAJPghbd0+uolLalfztohlS21ebCPynLNon8b9y2cMmXQgOkKEElvfZIe9w+zlsuVat7neofItPLgqjD+BGd0kqhPhx4j6w4MidKM/EUQh5BPVApmQqTifqc07liI1nSW6TSPVnt/qfXs9e3K5zIq0ZUPlK8tvDj0n7mMvfrpZnfFysWnG6vLvHNOL3zU8aE+dxiuIc77doj93aWXSDhTqOXV6AN1JS7IEBChAdQpyb5mBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?X0s0kG/aBnw/PvMiNerVYvN/WryjCa/7u6kwfsN8SAGHHmwBJI6I/KgcnB?=
 =?iso-8859-1?Q?QQykhaE3zu3Tg/Z3c05MvBUcUMNtnA3Dx8BkyZt3gbd+QV2v/N6QqaZDUN?=
 =?iso-8859-1?Q?nCR4WY9sx6qEe9pBklUFgz16QzCqNlVDEmT8210+VLbZzylQHcQMMwc7bZ?=
 =?iso-8859-1?Q?JiF5uRc8+Ecvm89EB9ye+ISRu8M9rGHzakzt3NhJAXbIi5YT6AR4SjR2Eg?=
 =?iso-8859-1?Q?KUsFjcxLUm/FGGVkxfEvWjoJuBXpQYm0hrHxvRiFTK2OrAGm/VI5nEWT78?=
 =?iso-8859-1?Q?EfZBYEa7dF3IPuvdOR4zWvUFHYrDbn+tuhVRfEpYSD1/fDE7vXa5oetxrS?=
 =?iso-8859-1?Q?Q07TPLwMj3eh0aehXESQkaWaMnwZ7q7UWXvEuuQEv3G5ptqy89WQ9Zv/kZ?=
 =?iso-8859-1?Q?iCPtUSjPnOeNM2JRWq5aRGwnbNVsl86YETtZGHKLbf+fQFtbXxjrh5E2Nb?=
 =?iso-8859-1?Q?eCSSvbGQynySBGdV04VqE5IVKIp0EzoVfUwFFhMwjVU0dn2BdMox9yOqQz?=
 =?iso-8859-1?Q?4h+075/fzIiSOarhk1NaI6k+XFpZtQ4EUsuwxQ4hTxzRc9WL2OwWaajRTe?=
 =?iso-8859-1?Q?rGVziIpQjXpP/tRxEl380xKHpnQspeIoO8zWdA+NdwsackKWc/8TFHBpa3?=
 =?iso-8859-1?Q?SaDcWPTRurkEag0F48u5Zl7NQ4G6UTAtzePO29UOxyyxlsa8Ug50kTnOBm?=
 =?iso-8859-1?Q?zsQJhxj0o7WhZRB2PXt/qlJSQ6sI3D7Q8t7h9C5gagvaBkHr8UNgPxSQUU?=
 =?iso-8859-1?Q?wcwrfZML51jBAQ1q8COld4N2FIksy0iVEaMledF3r8mK1IdWTPqa5b43Om?=
 =?iso-8859-1?Q?xQMZ+EbxQkM+WNfZ50gu8TKk7vaNoMYyzY32fcTJeV5Mc1wv2geAwz9iym?=
 =?iso-8859-1?Q?k66/S0QDc3H8Oz3VNAJeYeQ4j2FMuVezrov4xOaJRGyOyEhw69Pb7Tp/AC?=
 =?iso-8859-1?Q?wib1WxfAkjHzXYKpmmnuMO1IxqvBvOXnd28uI4JI1FoYD8UBOc5DaH5Y2x?=
 =?iso-8859-1?Q?nCGBwJu0xqEjP8ZB928lRY2de/02h4QOr8vEpj+7L742nhgEyczWyA0C+I?=
 =?iso-8859-1?Q?ckwNGMLWkZTd2R4E708SdgpLQ06tMpbA078xzXYiVYiqUVKvEHWS01E0ls?=
 =?iso-8859-1?Q?VW0ZOBYTkcXtUY+R+/GqNcFCkRkb0cHr5rmrtKoSqGj/VX2cSOnKyOIanr?=
 =?iso-8859-1?Q?IgUznsbP4HMy8oEc1jrGH6MuQEsNJ1/HojBTG9ZoZW1vktU/lq9C2G6Bpj?=
 =?iso-8859-1?Q?hR2ECqFnfzxZ5UE4kQohb5d0EFflBHI3qPNVSX9RNZlMD0yj4oLDFBuNEX?=
 =?iso-8859-1?Q?AhNTDHH6LhVACrEVabuKm/EnMY4s++sbFZdc1V/Ixb1moWiiB39QNdfgP7?=
 =?iso-8859-1?Q?/qQZbNt37dIC1Wnr4Eamn04GZ4RRRQVOv5SEL7iXN2EBTQeEdgY3rucjyL?=
 =?iso-8859-1?Q?ntbFOaOHR2D8TwgHYdEHuVeNsazOMN7KisFfRSf4PBfUG95yFO5g2uUSIk?=
 =?iso-8859-1?Q?KgERRet89GPvALNPujmR16gpKpSiRlhMuPsQRrrCI9jPzvyEykJIyty6j+?=
 =?iso-8859-1?Q?3gNjD0QW5AqvHEr8+w/5O5wKqgRe3zW0k1QiqCg5+qwpD+3gnv46zqb82a?=
 =?iso-8859-1?Q?dZW44SD3Sh0D78SJPBubY2oB/1egjDmRNYbffIKikA6e/kcbFPPXwPrPKh?=
 =?iso-8859-1?Q?m/h3zORTCPDaN5i5jaQk5t80LxzYMzZcr4G+4MaqZ0eJVBrvGLKxq8MlYh?=
 =?iso-8859-1?Q?noJ2RZfX1MrvJY3/FGq8ccJsP3cLgiM1UHo5SOdpFUhERLFe8iXCXW2IQT?=
 =?iso-8859-1?Q?/w0jVmTXTg04+1zQb5n3qBWS69jw6qw=3D?=
X-Exchange-RoutingPolicyChecked: 0HavyMVZmzUwPyWov+OCb3hB4qd+kMT3FVDHloxvEH/rTc4rECUVp+jMMlvaVNxKL9djd7+WuQQorGui+4R6nKiRZAR2ey2Z4nBo7ipj6oypiM8mwGr3tykXVika3Tl4lhWjnIoVIShjg6f5InM01Xnn++z948QczKt+Pt9QcNgEfuCG/PRV3NE2QSF8zWHvcq8qqmbZUhHL3uN6MglCw4iOMz7qe6SALcbL4vZ9qPla95kIqh39K5vzLo+moS6IuA6FMvfdahnCi5yKsQ+INmAhUenFmSA5W4vLiR/iLxT3uF7N1y8YkhBblq6W+CcD0zsDdyHzKjbwEFcfK8zhDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b4a84-44a9-412b-6a23-08df1a7e3c99
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 20:55:59.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ki/83Sz/ANsBpxc7InwyhYrxAckEd6gH8NfYgcDaaHBzwvTrdZR8Wts4N2XKTqNXjd6WxHLHwQ/nkZ/fHelYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
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

On Thu, Sep 24, 2026 at 10:04:55AM +0200, Thomas Hellström wrote:
> xe_vma_destroy() can defer the final teardown of a struct xe_vma to a
> dma_fence completion callback (vma_destroy_cb()), and xe_vm_free() (the
> drm_gpuvm_ops.vm_free callback) always defers struct xe_vm teardown to
> a work item, since destroying a VM needs to sleep. Both used to queue
> their work on system_dfl_wq, a global, kernel-wide workqueue that xe
> has no control over and never waits on during module unload.
> 
> drm_gpuvm_free() drops its drm_device reference immediately after
> calling xe_vm_free(), without waiting for the deferred work to run.
> The same applies one level down: whichever xe_vma or xe_vm reference
> happens to be the last one can trigger this chain from a dma_fence
> callback that may fire at an arbitrary time, including after the
> owning file has already been closed and its own module reference
> dropped. Since nothing tracks or waits for work queued on
> system_dfl_wq, `rmmod xe` could succeed and free the module's text
> while vma_destroy_work_func() or vm_destroy_work_func() is still
> queued or running on it, jumping into freed code.
> 
> Fix this by queueing this work on xe_destroy_wq instead, the existing
> module-lifetime workqueue already used for GuC exec queue teardown.
> Unlike a per-device workqueue, this requires no dereference of a
> struct xe_device that may already be gone by the time a deferred
> callback fires, and unlike system_dfl_wq it is guaranteed to be
> drained by xe_destroy_wq_module_exit() before the module is unloaded,
> following the drm_pagemap_dev_hold()/unhold_work precedent of using a
> workqueue that is waited on at module unload rather than a bare module
> reference. The previous commit's reordering of xe_destroy_wq_exit()
> to run after xe_device_exit() guarantees that xe_destroy_wq is only
> torn down once the device-count has reached zero, i.e. after any
> xe_vma or xe_vm whose teardown queues work here has already dropped
> its drm_device reference and thus already queued that work.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Assisted-by: LLM
> ---
>  drivers/gpu/drm/xe/xe_module.c | 6 ++++--
>  drivers/gpu/drm/xe/xe_vm.c     | 5 +++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> index c61bd33546f2..897724cb5cfb 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -114,8 +114,10 @@ static void xe_destroy_wq_module_exit(void)
>   * xe_destroy_wq_queue() - Queue work on the destroy workqueue
>   * @work: work item to queue
>   *
> - * The destroy workqueue has module lifetime and is used for GuC exec queue
> - * teardown that can outlive a single xe_device. SVM pagemap destroy uses the
> + * The destroy workqueue has module lifetime, and is guaranteed to outlive
> + * any xe_device, and to be drained before the module is unloaded. It is used
> + * for GuC exec queue and xe_vm/xe_vma teardown that can be deferred past the
> + * lifetime of the xe_device that triggered it. SVM pagemap destroy uses the
>   * per-device xe->destroy_wq instead.
>   *
>   * Return: %true if @work was queued, %false if it was already pending.
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 390da884c727..ee369e6c3b28 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -29,6 +29,7 @@
>  #include "xe_exec_queue.h"
>  #include "xe_gt.h"
>  #include "xe_migrate.h"
> +#include "xe_module.h"
>  #include "xe_pagefault.h"
>  #include "xe_pat.h"
>  #include "xe_pm.h"
> @@ -1249,7 +1250,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
>  	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
>  
>  	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
> -	queue_work(system_dfl_wq, &vma->destroy_work);
> +	xe_destroy_wq_queue(&vma->destroy_work);
>  }
>  
>  static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
> @@ -2059,7 +2060,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
>  	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
>  
>  	/* To destroy the VM we need to be able to sleep */
> -	queue_work(system_dfl_wq, &vm->destroy_work);
> +	xe_destroy_wq_queue(&vm->destroy_work);
>  }
>  
>  struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
> -- 
> 2.55.0
> 
