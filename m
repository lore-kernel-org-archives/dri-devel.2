Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F41CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565FC10F4DA;
	Fri, 26 Jun 2026 08:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DLvYLRjq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A38610E321;
 Fri, 26 Jun 2026 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782461771; x=1813997771;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0boCUVsowAz6SpacuDTfLS/2et0Xh+2pEAlEAG8L4mA=;
 b=DLvYLRjqm+StNn+cIaOEYMWru6cRgysqF94IV362tc/PvnSeZ75V81SM
 T0cyyBj5z6Ue4BNkDDYp7vuUdOOKkU7LbwEcYXvE7PVgDedLJleK67trv
 qEJMPZjP2JgCl9xwRevJYbGc5Rr9mAsoXXldUKtYgPFUhhKJLGkkb/epa
 DKvj2FrpyADSnv4bZHh8qExQFn+675QUAVY7TWKtFtaNJIVbESvrMsViz
 GpOUo4xaEMSCJl8ToAhzWm/WlqGcgs3p19XhSOio6uuaX9o65p084dHlP
 dyz4Ap6VW2R4lxHnzDon9srXKbgrMJ03zrn33wKdXgbM32LlRQWDk771L w==;
X-CSE-ConnectionGUID: cRqMGWTcROGMheMdeFWAUQ==
X-CSE-MsgGUID: 0bqDkrocRK64v1ghzzHpUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93606895"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93606895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:16:10 -0700
X-CSE-ConnectionGUID: tEzhBRc+RcaItNtGxW02VA==
X-CSE-MsgGUID: jQvW7utnQp6kD5yhgqzcLQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:16:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:16:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:16:10 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoQq9tmWndLJEXKU+8Rl2ZiHg1rchm6DNJnCrCOYptNElROTW1u4o5J0f8vynPxDBn8CK6KE3xPHuSPXdioyP4fcSdZowlJtOJqL54a5NKx3iWK0ooBUO0u0h3mGx83GSjPpxAeK9rWfSyR5uJpD0aZrHOyIobvxETzbj7WAsR0Targ2rD02ERAs6EINmO/6j4DoqLyuyWzpz2/8xoNb92rE1X21rVSIpibpiK98BjnLXufihv1Ob+NSMxdzeoLU4b95LUnxfyzTbniwHOB3zO7+P3q35i8ZTZkazkXFvwm5VqNMEC7T/aT+YqcsW7WcCPpMohYrZSUpfjxszkxiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRTcGbrSiKkaYADYqBRbIC0VxJPAvywF//RRpp39inM=;
 b=xrV2hiiQORxXpwKmjixHZpXEChieUbwXAmLE9F9vKLlkl+2MtWjKlzBOCoARQYaLmjfmY/ib0MNERNcWnnAI4qXPK8I69JCWCrYg4NbGWdb9ZKtjhDG+pUf9TpPCa1ZZGFiKND6nNxcwls+h+69SZC92S+Qa4t3leNcLe4fwbJ7RWTuswiu6ggiY5+Maqmr4eLsM8v4l59bWFsDKJbEWB0etJlBPe3SMVaoIjv3cVbYlkjeFYQE/yDo7uIp9ZM6OWr+3EAhBJCKucqBpwe3gSgAy68FPpUWK8c4fD2N0Seywot4yjIZvH2V8CklHi/2sYSJvFxe2AUNJpbQ8Sg88Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:16:02 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:16:02 +0000
Date: Fri, 26 Jun 2026 01:15:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: Re: [PATCH v3 3/5] drm/xe: have xe_svm_range embed one
 drm_gpusvm_pages
Message-ID: <aj41P1ItqGO8zbwr@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-4-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618080902.1527255-4-honglei1.huang@amd.com>
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc61f28-b68d-448b-a742-08ded35b296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 6fEzxT17+Hc4dJ38QwFEQ7P9NNGwan9aLH7+Iy2g9GOE0Y2O0CQrlXYYqZLZTUGLn5cG7iDNaUT9orPev5Fu2LbH8enMqtQ2o4TDVlGeKbf+MipUx51ZwhQ7itoam9pr+z2j8Us0XLp8jRT3pk5F4U9+LeIBN6Ap40wLctcMQBdNEPOow+26KOEjC0cc6btIIZZ7ddDT0T1KdcKO3dkVAl3UNQ+GNSeoFQxYjHasVeHjJTVQH11YTBbWlqBzQznUKCSqnJyc/pH2WgtI8BUyY3LO/0ygVfTKdYTZrXNHTW73QzX19az1NTuyiPxVjTMUkVlEAWmbERIg21ioNr8GRENjfcNelw9PSG3h0QHBAS9dS8DIKPd3thxu09XqR+a9Sd2dLUbyfwKIMlvGzbraqATX7JvUYFDfNNQs2wDWjRq5Hn92rmGDwFy3Nk+I6c85EFUuWH1GKQZm2VwcdCG5kqjx003Qg3miJ/YjUuRKNe9I1HpRIsHasyJ/pVVdZjmCbalYa7JUBsgY6RQzKsf1nNrgwaVtWdjlAB+BGC9FZQVChslgH5MLsxJnIFN/GS1GUG7tEoLHKnAkNwYHmKnGN4L+Jm/aiZiryIZcpHtiO9eiAQiOotZUoR2FDCNGwUN3s9K5ow4m3he58sSjkRONhRd3BapqF4X3ichIQ4ZxgRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMUkxHwNYi8kz09xqxJDFfK7Y/Yv/D3cRbO1ptf0OIYIExRy+5DxBg99PXfg?=
 =?us-ascii?Q?FBCkbixkEsW0rYPAOehtt6T5a9EehqFWvumOCg/UGZz8LtyPXWV0nppmCk3S?=
 =?us-ascii?Q?3BcM0dSs8FP2YYevbB7X6gDhhLxnClrTP1kyHn9oZzezggjlLHvag+tO6bJt?=
 =?us-ascii?Q?Tx1Mo6MFWVqXFzlwlsPqMjtVN9FfrQ9808hL//BDTc9bPpRH0x1WgS/wZeY3?=
 =?us-ascii?Q?9eoTEts4eL0kvghnJA/yEsc8bKA9kwTFiffkBBT8xlrYJJP483EOgmOZvd6o?=
 =?us-ascii?Q?KJLGRA+j5WxbF8qsvl6evn+qDaUUWTmbVQV27VWc32kFqxEGgs+srPp/lcV8?=
 =?us-ascii?Q?s6CUehaZ7nVKFuQjYAl7eXhl0l/x1sbYPqqj5otk4FhAP4dEHllENDaEBnKa?=
 =?us-ascii?Q?SMN96RllchVG+TtXYqAkxIrWA0navgh0048JigK9OF47DgRzRazSdVVPh9bu?=
 =?us-ascii?Q?5CzRIqvn0DZkqBUwb+nXITq3BKLZCTMH/AMwJkHP1is36z1FiD66pL+9QKLO?=
 =?us-ascii?Q?DiuItzks4jLGJbQgtXFbY4+LS06EtoPIQVQ3BCqhtHf2wIBQEnbxPPE5cG0u?=
 =?us-ascii?Q?MiiTOzhK5PWKf6nS8c694mw3Cb7EoN1YtH/nlpMLFnY/SGdpoQsufAAd5/rN?=
 =?us-ascii?Q?7FsoqtO0QyzgsuMJ+w03IPUdyAPeoCts3IZbyXdrKJWS1q4kOotN0ZpvcNQX?=
 =?us-ascii?Q?FvTv0yN4QgnB1ozpr+Gzixp3MO4iq2SnEEjfjimBlg+KWh8xIBtkP9pmiSPi?=
 =?us-ascii?Q?eer1iPZTJo9pPmOA2XhPhu9CboBeiLjkEFuRr6p7UnHt5A0u5E/wHs23PAQi?=
 =?us-ascii?Q?WlVckBLZ4F/usndoqrIP8a+T3lUoONUGBMf7bRNNbCz0DfeY4zg0Crj9GBgz?=
 =?us-ascii?Q?GrNFbP+vDTVf6OTrnrO6uPWZDPLzdCFi3r8965/X+sRWdHS+4THYDK2jNkgM?=
 =?us-ascii?Q?7eZZ4h9WOfAIkEWXHZkvbJDT1isTsnTsY8DDb+nzhobvZX5gbWENuH19coa1?=
 =?us-ascii?Q?QmoABvow3XoXSUaZm30+YjsNE1ubgzi3lsiR+kBrn7yYOdp5ttw4rv1yeLYf?=
 =?us-ascii?Q?pzss5T/LALtVNb59wmzizT+9qEMQkODAiW20xS4N6TyRYyPD0UI19tbsAYBu?=
 =?us-ascii?Q?caLWvBKuE6YpQIbN2XHnS0Q0RHagRSyOXJtIlwr1TXSkM39VFr93UJ1nGL8G?=
 =?us-ascii?Q?MicYOVCMKjhX5JSm4DOF7btg4nKDPYrH43LSe6ckOyTIMBTiULd9l2zmyJU6?=
 =?us-ascii?Q?Ybzlu9hM2roSRWHdlu1caHaQGv2fqZAIt6vXqnt6zcdFYB091VjgGMvsvaXe?=
 =?us-ascii?Q?5KzbAyW2gJ2cSkJ/0w45inQIKWpvV+x0W4ZjPosq1pAJNgQ3DmSPUtf/k122?=
 =?us-ascii?Q?IX79qdVnbKY+fcRH2PnnbO8d8bw2uvlQbPmZwPWnTjckMVXkwTXgPMXK8gJy?=
 =?us-ascii?Q?NchWfVF/YbgRMWS6AfTGkLHyo/ZuRxIl4zJuZpgRtomTMCxGYHBas7F8Ei9C?=
 =?us-ascii?Q?/uXzJWp3ka5OA60rJK8qth0Agy+3yjPU91OKDy3uMEItlyiQO0PR7zaIzAwp?=
 =?us-ascii?Q?lBNuUvcMQvidOzrwhHuWsCV71eP1vJeeu49PNvrq2SFjzrQiZfipncl4xdth?=
 =?us-ascii?Q?v6g7IDXuBa++7qGfIEOaOHob4aby7184THNPbHMyREZl+pdCA8XxJkOnrPeP?=
 =?us-ascii?Q?7vzx2j0hwxuylv7gx42n/1hQaTmnQd+fkx8QuLsmjtWO6qGvh4Zz6o3q8Okn?=
 =?us-ascii?Q?D7eRZxlBbA=3D=3D?=
X-Exchange-RoutingPolicyChecked: dbUwvQGfTrs+4pqcp1RoRyPAHT99LhxOZShCN1yLCCnTudn+fvMKFnWN62qSa2fzPoRwBUVapww6+pIyCcJdgvQw1Zn4mvjv4wjijprYtHOIPP70J8oOTPIgIQMSOellItCGPf1BSIMi6ZJisRLUNks1Gm+QIsg6LdBfXRSKSygYXdNAY0aE1yw82Vjz9D/vqezk9GwqJtQobJv9Emr3VYdgj8EIA0x4rsPmHOlS+Fw0CB2r2oa1dyfBK99jJJof+kS0R2tHkcN7IXLShyXhOl/tZK8T9dWNSMg1gYLVEq0Vs33QNK2Q/7/AM4CEWIzN9Yn1/nLXosBuxTHr4Vgacg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc61f28-b68d-448b-a742-08ded35b296b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:16:02.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbXqN8uuAcDShzk39r/FdqecPAJcUo8gHhQueo8AgfCzkcbunfC4c3KwG8AqSrGu+Mangw/dlZcUTbKUUDvrcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
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

On Thu, Jun 18, 2026 at 04:09:00PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> With drm_gpusvm_pages now self contained, make xe stop relying
> on the drm_gpusvm_range pages and take responsibility for the page
> lifecycle on the driver side.
> 
> Driver side (xe):
> 
>   - Embed struct drm_gpusvm_pages in xe_svm_range and route all
>     xe accesses through it instead of range->base.pages.
>   - Initialise the embedded pages via drm_gpusvm_init_pages(), which
>     binds the owning &xe->drm up front, and take over the page
>     lifecycle: xe_svm_range_get_pages() calls drm_gpusvm_get_pages()
>     directly; the notifier event_end and xe_svm_range_free() paths
>     drive unmap/free on the embedded pages object.
>   - Convert the open-coded userptr pages init in xe_userptr_setup()
>     to the same drm_gpusvm_init_pages() helper.
>   - Switch xe_svm_range_pages_valid() to drm_gpusvm_pages_valid().
> 
> Framework side (drm_gpusvm):
> 
>   - Add a small inline drm_gpusvm_init_pages() helper that records the
>     owning drm_device and initialises the per-pages state, giving
>     drivers a single hook to extend.
>   - Export drm_gpusvm_pages_valid() to let driver owned pages
>     can query mapping state without going through a range.
>   - Lifecycle change: drm_gpusvm_range_remove() no longer *triggers*
>     unmap/free of the embedded pages. The unmap/free logic itself stays
>     in the framework -- drm_gpusvm_free_pages() still performs the DMA
>     unmap (as an idempotent backstop) and frees the dma_addr array --
>     but the driver now owns *when* it runs, since the driver owns the
>     drm_gpusvm_pages object.
> 
> Side effect / contract: a driver that owns a drm_gpusvm_pages is now
> responsible for its lifecycle: drm_gpusvm_init_pages() before first
> use, and drm_gpusvm_free_pages() when the owner goes away. Xe does the
> latter from its ops->range_free callback, which the framework invokes
> once the range refcount drops to zero in drm_gpusvm_range_remove().
> The timely DMA unmap for the IOMMU security model still happens in the
> notifier invalidate path via drm_gpusvm_unmap_pages(); the unmap inside
> drm_gpusvm_free_pages() is only a backstop for pages that were never
> invalidated.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c    | 14 ++++++++------
>  drivers/gpu/drm/xe/xe_pt.c      |  2 +-
>  drivers/gpu/drm/xe/xe_svm.c     | 24 ++++++++++++++++--------
>  drivers/gpu/drm/xe/xe_svm.h     |  6 ++++--
>  drivers/gpu/drm/xe/xe_userptr.c |  5 ++---
>  include/drm/drm_gpusvm.h        | 19 +++++++++++++++++++
>  6 files changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 155e3c2e703..85fbadc9716 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1228,12 +1228,15 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
>   * This function removes the specified GPU SVM range and also removes the parent
>   * GPU SVM notifier if no more ranges remain in the notifier. The caller must
>   * hold a lock to protect range and notifier removal.
> + *
> + * This function does not unmap or free the drm_gpusvm_pages; the driver owns
> + * that lifecycle and is expected to release them from its
> + * &drm_gpusvm_ops.range_free callback (invoked once the range refcount drops
> + * to zero via drm_gpusvm_range_put() below).
>   */
>  void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>  			     struct drm_gpusvm_range *range)
>  {
> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
> -					       drm_gpusvm_range_end(range));
>  	struct drm_gpusvm_notifier *notifier;
>  
>  	drm_gpusvm_driver_lock_held(gpusvm);
> @@ -1245,8 +1248,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>  		return;
>  
>  	drm_gpusvm_notifier_lock(gpusvm);
> -	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
> -	__drm_gpusvm_free_pages(gpusvm, &range->pages);
>  	__drm_gpusvm_range_remove(notifier, range);
>  	drm_gpusvm_notifier_unlock(gpusvm);
>  
> @@ -1325,13 +1326,14 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_range_put);
>   *
>   * Return: True if GPU SVM range has valid pages, False otherwise
>   */
> -static bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> -				   struct drm_gpusvm_pages *svm_pages)
> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> +			    struct drm_gpusvm_pages *svm_pages)
>  {
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
>  	return svm_pages->flags.has_devmem_pages || svm_pages->flags.has_dma_mapping;
>  }
> +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  
>  /**
>   * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 0959e0e88a1..4a8af0e934c 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -758,7 +758,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(range->base.pages.dma_addr, 0,
> +			xe_res_first_dma(range->pages.dma_addr, 0,
>  					 xe_svm_range_size(range),
>  					 &curs);
>  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 63da149f3b7..77af0a8de63 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -66,7 +66,7 @@ static bool xe_svm_range_in_vram(struct xe_svm_range *range)
>  
>  	struct drm_gpusvm_pages_flags flags = {
>  		/* Pairs with WRITE_ONCE in drm_gpusvm.c */
> -		.__flags = READ_ONCE(range->base.pages.flags.__flags),
> +		.__flags = READ_ONCE(range->pages.flags.__flags),
>  	};
>  
>  	return flags.has_devmem_pages;
> @@ -96,7 +96,7 @@ static struct xe_vm *range_to_vm(struct drm_gpusvm_range *r)
>  	       (r__)->base.gpusvm,					\
>  	       xe_svm_range_in_vram((r__)) ? 1 : 0,			\
>  	       xe_svm_range_has_vram_binding((r__)) ? 1 : 0,		\
> -	       (r__)->base.pages.notifier_seq,				\
> +	       (r__)->pages.notifier_seq,				\
>  	       xe_svm_range_start((r__)), xe_svm_range_end((r__)),	\
>  	       xe_svm_range_size((r__)))
>  
> @@ -115,6 +115,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&range->garbage_collector_link);
> +	drm_gpusvm_init_pages(&range->pages, &gpusvm_to_vm(gpusvm)->xe->drm);
>  	xe_vm_get(gpusvm_to_vm(gpusvm));
>  
>  	return &range->base;
> @@ -122,8 +123,10 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>  
>  static void xe_svm_range_free(struct drm_gpusvm_range *range)
>  {
> +	drm_gpusvm_free_pages(range->gpusvm, &(to_xe_range(range)->pages),
> +			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
>  	xe_vm_put(range_to_vm(range));
> -	kfree(range);
> +	kfree(to_xe_range(range));
>  }
>  
>  static void
> @@ -134,7 +137,7 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
>  
>  	range_debug(range, "GARBAGE COLLECTOR ADD");
>  
> -	drm_gpusvm_range_set_unmapped(&range->base, &range->base.pages, 1,
> +	drm_gpusvm_range_set_unmapped(&range->base, &range->pages, 1,
>  				      mmu_range);
>  
>  	spin_lock(&vm->svm.garbage_collector.lock);
> @@ -209,7 +212,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
>  
>  	xe_svm_assert_in_notifier(vm);
>  
> -	drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, r, &ctx);
> +	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
> +			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
>  	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
>  		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>  						   mmu_range);
> @@ -953,7 +957,7 @@ void xe_svm_fini(struct xe_vm *vm)
>  static bool xe_svm_range_has_pagemap_locked(const struct xe_svm_range *range,
>  					    const struct drm_pagemap *dpagemap)
>  {
> -	return range->base.pages.dpagemap == dpagemap;
> +	return range->pages.dpagemap == dpagemap;
>  }
>  
>  static bool xe_svm_range_has_pagemap(struct xe_svm_range *range,
> @@ -1018,7 +1022,7 @@ bool xe_svm_range_validate(struct xe_vm *vm,
>  	if (dpagemap)
>  		ret = ret && xe_svm_range_has_pagemap_locked(range, dpagemap);
>  	else
> -		ret = ret && !range->base.pages.dpagemap;
> +		ret = ret && !range->pages.dpagemap;
>  
>  	xe_svm_notifier_unlock(vm);
>  
> @@ -1508,7 +1512,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>  {
>  	int err = 0;
>  
> -	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
> +				   vm->svm.gpusvm.mm,
> +				   &range->base.notifier->notifier,
> +				   drm_gpusvm_range_start(&range->base),
> +				   drm_gpusvm_range_end(&range->base), ctx);
>  	if (err == -EOPNOTSUPP) {
>  		range_debug(range, "PAGE FAULT - EVICT PAGES");
>  		drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index b7b8eeacf19..1423ab2f1d6 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -31,6 +31,8 @@ struct xe_vram_region;
>  struct xe_svm_range {
>  	/** @base: base drm_gpusvm_range */
>  	struct drm_gpusvm_range base;
> +	/** @pages: Page/DMA mapping state for this range (single drm_device). */
> +	struct drm_gpusvm_pages pages;
>  	/**
>  	 * @garbage_collector_link: Link into VM's garbage collect SVM range
>  	 * list. Protected by VM's garbage collect lock.
> @@ -74,7 +76,7 @@ struct xe_pagemap {
>   */
>  static inline bool xe_svm_range_pages_valid(struct xe_svm_range *range)
>  {
> -	return drm_gpusvm_range_pages_valid(range->base.gpusvm, &range->base);
> +	return drm_gpusvm_pages_valid(range->base.gpusvm, &range->pages);
>  }
>  
>  int xe_devm_add(struct xe_tile *tile, struct xe_vram_region *vr);
> @@ -132,7 +134,7 @@ void *xe_svm_private_page_owner(struct xe_vm *vm, bool force_smem);
>  static inline bool xe_svm_range_has_dma_mapping(struct xe_svm_range *range)
>  {
>  	lockdep_assert_held(&range->base.gpusvm->notifier_lock);
> -	return range->base.pages.flags.has_dma_mapping;
> +	return range->pages.flags.has_dma_mapping;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 1b540e62af6..06da9725a4a 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -396,15 +396,14 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>  	INIT_LIST_HEAD(&userptr->invalidate_link);
>  	INIT_LIST_HEAD(&userptr->repin_link);
>  
> +	drm_gpusvm_init_pages(&userptr->pages, &vm->xe->drm);
> +
>  	err = mmu_interval_notifier_insert(&userptr->notifier, current->mm,
>  					   start, range,
>  					   &vma_userptr_notifier_ops);
>  	if (err)
>  		return err;
>  
> -	userptr->pages.notifier_seq = LONG_MAX;
> -	userptr->pages.drm = &vm->xe->drm;
> -
>  	return 0;
>  }
>  
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 842353afb27..e32d3bcb47b 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -310,6 +310,9 @@ void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>  bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>  				  struct drm_gpusvm_range *range);
>  
> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> +			    struct drm_gpusvm_pages *svm_pages);
> +
>  int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>  			       struct drm_gpusvm_range *range,
>  			       const struct drm_gpusvm_ctx *ctx);
> @@ -350,6 +353,22 @@ void drm_gpusvm_free_pages(struct drm_gpusvm *gpusvm,
>  			   struct drm_gpusvm_pages *svm_pages,
>  			   unsigned long npages);
>  
> +/**
> + * drm_gpusvm_init_pages() - Initialize a freshly allocated drm_gpusvm_pages
> + * @svm_pages: Pointer to the drm_gpusvm_pages to initialize.
> + * @drm: The DRM device that will own DMA mappings for this pages object.
> + *
> + * Drivers that embed one or more drm_gpusvm_pages in their own range
> + * structure must call this once on each pages instance after allocation,
> + * before the first drm_gpusvm_get_pages() / unmap / free.
> + */
> +static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
> +					 struct drm_device *drm)
> +{
> +	svm_pages->drm = drm;
> +	svm_pages->notifier_seq = LONG_MAX;
> +}
> +
>  /**
>   * enum drm_gpusvm_scan_result - Scan result from the drm_gpusvm_scan_mm() function.
>   * @DRM_GPUSVM_SCAN_UNPOPULATED: At least one page was not present or inaccessible.
> -- 
> 2.34.1
> 
