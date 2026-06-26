Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C3CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3408910F50A;
	Fri, 26 Jun 2026 08:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jk5J/NCJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B242910F506;
 Fri, 26 Jun 2026 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463547; x=1813999547;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=D0LdyeWzDQLF+HajI/7TfsH28XeukccDIzQ0h6CkX2A=;
 b=Jk5J/NCJ/2XKSPv8UALd5cr219Jxs2o5wFAQ+g/Bc4rNUWh4womGS7rr
 8jaqzklmhghqgN7fiKuN1BFhCy03N9lC7/Ewf93Gjq5bxUB3J49lcedbz
 cDNndmqy2Qy9Lk94Y5Ovwver6RaClh6xeUFAakpQ1oD3aXqi0lnxk3Dgm
 5BPAFUU5qcwckoe8PXm6lnST1TPnW+AuH8EnothoElcQRPb7nRpYayMat
 /xeVf5tfgnQYrhikkop2dQk3+HCCBD1lrU2niYDp/alMOvFwZmQO4cwxN
 iqxCF0y8n/5yDeGp30BisMnwR4DK5cvajqjpar04AOQLkYvCzifTt09JF w==;
X-CSE-ConnectionGUID: MFuFgnEMQ8md9BJFe93EHw==
X-CSE-MsgGUID: wUXQiNMqQnCYLxl+A1WfTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83391776"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="83391776"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:45:45 -0700
X-CSE-ConnectionGUID: XAxzB+POTwG9TZ3pcSEkdA==
X-CSE-MsgGUID: a4qgNT5XSoWF0Jx8W7eUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="247311769"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:45:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:45:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:45:44 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWX4AtQDR2tEdr7LGg1LMxRKVM7zcLK1V5achf2JBvbHovbXIwX582dfCTBgKszIqisiYCcOOOdAxCUxtTltwZjx4hEzdaHgb9aQdioxDCRxkUKNelLp77EgOBjHkCmYuaYFANNKlPolijGjLx2gTLsO10Vu6dnc+qz2VlaEnKQH6TMuQJxNIOoihar5XWsUA1to0RB7t+TXtYGEETu6g/g2j9Xsk1wrEdWjZW5KT4FDyUQgBvKGYcXMpfDr7iZn60rBbAkKVy8q/HjyXeYCTfHS7pecZ3nvj0E3GDb2r1o/lNLQCpvKG70r3/Cc+ta8CbYIzIn71SqNqZZWkWZVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQGNiyp3n1xGiPTDyDp1PThKGNLit0GqR59WrhS0nlU=;
 b=KQHz4/XYPOmNhX+Q0qwr0F6OGoiT+nIplQHWI7LqVZf1yX06jiXkyiw4PaV5+wpAw4vCUNus6hSKMQm5jPB0wXbpzkR3ybmH/heCjlFzQcNmRdDclmPa8QMmSWeU/nbJ5N2RkVM/Wp4UcLLoLm/Tv2e4TSbdeoipIyhKnDiMgsIwp+t5i53NWG/MOAVdRukLDdj1+zICvDWAQH12YzycHVplPd4Rx1/MMdmGLhCMvLk7Q3NK20bL6LLVCsgA06vffVqEyM5sXS3iwP6I01BjN8JwJ5+fR8KaKXTO3R31NAtcD2EHXdSJnwYNQgU4JCrylFpSGi1+KbVL4pvcwHufwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Fri, 26 Jun 2026 08:45:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:45:34 +0000
Date: Fri, 26 Jun 2026 01:45:30 -0700
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
Subject: Re: [PATCH v3 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
Message-ID: <aj48KjDIZadzFVSZ@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-5-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618080902.1527255-5-honglei1.huang@amd.com>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ef3e69-6442-4c44-0b69-08ded35f4989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|4143699003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 8/NHcWOvltpj0P3SM2OiOVP1E2C8IcZsb8TRoMZqq7k2y8Peq1GhJOmWUxHFbtR9EiZAfpgmOQGI1no9mN9fptpcaL9mC86PTY1Ve/qFbF5BSZjCml15ZZXfGwqdssyemNQwa9yB5nNhSroive2G2w/JODQe5lBGbrLuMilEh6E0BhQiO2DbTO/2iXcJejRQ+jpPWI9ZAz2hq97SeDg8KfGwsHYZwzJZPnDM8M2JLbJSFRcQDCKjZv39uZMNLS8GHgeqNVr3keb0UTDUazc4P6GoqBnzCrAj6Ij4Q/MipkFsqN8CeHqTJcxmqvpou172IjAKrPwUfGPBDpH3OkTWMKNR4TQP8/gqqWx5Vwh6y2O4u5p69SZJUcPNBbzlXngBqd7uFxnb3ff5v89c2z8xVk96cDgVQGbEsdwkKKEo291EiFwEvRixjjzFO13eYUBgR0HNAioSywFAxkJUymKK87a5jV1B8QMOHyZVLBX3PuytGdh/yk32bN8eXSrL9ZvcZV73xOWH1ojSI/WSojuN4p+eeAuXAL1xgyck/iAE6jECv0RePlu5fcj64ZTojiylxPixOjKPDWNoATwiZJNehTHbpv4V92GYHf8+o9OZsW/vKBVAIIgN0MeBQ3+vP8zFO6gsXzVvdMSYzwEtlPLdGfyteRGjCAmvqyMXiuiu3H4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHAFGpeFZsfUdNXpT7PexIm7kM1cvz8N64YzWOx+zgOB/q7jdY6dalb8OHHe?=
 =?us-ascii?Q?qf0mvmEq2u/6aQp+0osIkA9F5hztsEuCDuUb0dAgQvy7/0uSzE+CBkaV/o3p?=
 =?us-ascii?Q?VXgCUoZsbbHwnVKWrpcg7VH7lqsWh5u9HbLRqWmDIZwcxUMVizMBvzk9iFdw?=
 =?us-ascii?Q?H+m6Msr0RYQH+xLya2Xk7caHNFblh0i4AdH0eYlhDADfZCi4DCVbUyqXlrwL?=
 =?us-ascii?Q?rjdfS2iRCPVpVVCoATCiZ5g3nlNAiWPtOTjoTGbXwpGX+kCJbLa8Ufu6MKUk?=
 =?us-ascii?Q?O2df2xlyyYUT4sSyW0M+9b8uLLnwmyEQ6oMx68S3N4zlaLVAToc4b4aMmCB9?=
 =?us-ascii?Q?4a32y4jsJRS9LQ4Cco74Ih/SHR87LMyFMz7HqBGK1A3600SAmBX/kyLfIZrm?=
 =?us-ascii?Q?fRt4LuJ2EvzcpraLdeJa1wlRxzCqAHBNbNNFE4qTIn9feTGGyrChTRSYN8Cs?=
 =?us-ascii?Q?RUlN+LyF6/Bb0OE77iBoqmxUtSCdGmpX4mExILuUi4uImIbGt089BJnmvY0v?=
 =?us-ascii?Q?Ndov502Zmd3+PDU+l50hXW2N8xlOsYVNP8O0qxcc9TLSgcCe3ZA+0d1no56e?=
 =?us-ascii?Q?HAdg3u0n5E3+ia+4vf+FupZ5ZLb6Izl78R5oUEseJ0ddPdHMfjf+NAIxXOSP?=
 =?us-ascii?Q?6rjP50yk74WKadRQYnCalXWRGnOpB+l0V85zk+voayBRnBHRuZiPuxQ7F1WY?=
 =?us-ascii?Q?K8yXwW1pS9psQYlPYMsI8aLKHhb6jkX9Z41lOGWpFIvCRYsvjNa11AolKWu1?=
 =?us-ascii?Q?sRrKpHibpnsGs480KNRCB96FZdPSkklddgQSqDWphylUWQuamkLRQusVyWsr?=
 =?us-ascii?Q?+HOuUeQJ191wpBJ7uyAsQxApzwZ20yVJGfL/6HoSJc1Qmnt4jLxkbpjklPx0?=
 =?us-ascii?Q?w7C3hvzucX2/sxyALrYa5G1Wry5qyEJkyow0nFRzuEpLOBRxS4n/JVGK7wK7?=
 =?us-ascii?Q?bogm/Rfe9faT9F5orf0STT7Yjm7YsUXZCuppSbseeSJim+SNwLw+SSdafCBs?=
 =?us-ascii?Q?3E+oNCXjRgLDmPim2eVdF5hRn0apiZFOfmGTgu0Xu9aWEUGwRUfJBBZ9MVG5?=
 =?us-ascii?Q?Gqqf7oXC4EqbSsrvPS9hXiahZmBgi/1KCu2LqPmFE/5fGfPqubQcyXMFgX2e?=
 =?us-ascii?Q?n8ku97/0y3yUITDdLOoSbJHIEbmKyjMVM+sOy/uiJr1hcRMlbidWDZUnqTlY?=
 =?us-ascii?Q?KKICq/wy/kjR7PYWOGdq0PLMesGxeSkq4J04JIMYN6aESLm+taO/rWG001pl?=
 =?us-ascii?Q?zjYl+Va/8wbvXfW1qUvqIjLTUtTRBqYJJqptFgsq5ZnF70CKr9Vf6qBTz5K9?=
 =?us-ascii?Q?nWAoTOZcFZ2bnU5Z2nUoR9UOdlUj9QG08yJKIIZ5AzPSAaPhUizESMQFnjdD?=
 =?us-ascii?Q?Z7fTW6vqRvIZBtKu9zA6d9DBhKlLrkIh3a2CbTfqK4FxWjPdGPFCPU+s5KUM?=
 =?us-ascii?Q?pTH7jiq2d8QjRkUN22iGDFr4NzvqtTJHOBdjrSdB1sgKN7w1o/DOl71+lMJX?=
 =?us-ascii?Q?XTjMR3ZQc5FvjJqlUYSnMYd8tV8DkT8T11Kqsopa3pVKaLY66uI5xhpNkYB0?=
 =?us-ascii?Q?G5rFI6RcDXmqX+yHQGp6pER6Z1vM/CnMZDGSiggSNACqZ4Wl5f4UQqrMAgzp?=
 =?us-ascii?Q?bZycAAqeNWvioP8kHZKXvemjNKeYG1z4pAJ5DNs7E47C4/FPZPoGM5fkTSr+?=
 =?us-ascii?Q?mF5pA6YiaPizGnFYhjy9q9/MjbcBP49wpUQGXMHas9JqM9LvgTtnmUpOXEt1?=
 =?us-ascii?Q?9jdC/39npQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ko3m8lje4WAKklazETidnW+yPvF3SLHCz2eIo/u/JzEIlQVftDgi80G8t0CpaLeMfTfUwRgy5j9Da4EkGgJdqzYX0ucGTEHvuzEIuKUR1/e44l+Q7Fwe7HzQRaqaSvZf1BETZZBM9aofgsgc9BVdM6WmHELFeCCSyxl9Ju8Y7NFtRGhp16B6U9PgAd51ovwOwJFWUqVaxXG4AsHyimDX6XRWIXGheAQk5Z/fdblE076Hfu4nnS58kiDfTFGZ1K6/P5lEzV3m84mHYtlOZB467OjXFYlTjVGd2I6tKtmwEYBsI/pLAK6RqGZ9o8fZWsEB2ozEr/84qUU7vvyitr/GeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef3e69-6442-4c44-0b69-08ded35f4989
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:45:34.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIIUJjD8cq489crbAxm2oN0lg+B2uTe5VjCoVWzC0wdbNgWCdQnA5ZyrYN0+eK+zpB7vAPqAqXtHxexWfWTblg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
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

On Thu, Jun 18, 2026 at 04:09:01PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Since the pages the physical pages and MM VA range has been abstractly
> separated. Unbinding a single form of physical page from the MM VA
> range, brings flexibility to the drm gpu SVM framework, transfer the
> way of management of MM and device physical pages to the driver layer.
> 
> framework's range embedded pages object and its range level wrappers
> have no users left. Remove the following:
> 
>   - Drop pages in drm_gpusvm_range.
>   - Drop drm_gpusvm_range_pages_valid(), drm_gpusvm_range_get_pages()
>     and drm_gpusvm_range_unmap_pages(); drivers should use the
>     drm_gpusvm_pages helpers (drm_gpusvm_pages_valid,
>     drm_gpusvm_get_pages, drm_gpusvm_unmap_pages) directly on a
>     pages object they own.
>   - Drop the notifier_seq seeding in drm_gpusvm_range_alloc();
>     drivers initialise notifier_seq on their own pages object.
> 
> Update the DOC: overview to match the new model: document struct
> drm_gpusvm_pages and the driver owned 1:1 / N:1 layouts, and rewrite the
> usage examples to operate on a driver embedded pages object by the
> drm_gpusvm_pages helpers instead of the removed range level wrappers.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 163 ++++++++++++++++++-----------------
>  include/drm/drm_gpusvm.h     |  13 ---
>  2 files changed, 84 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 85fbadc9716..842bfb37a36 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -48,6 +48,47 @@
>   *	event. As mentioned above, ranges are tracked in a notifier's Red-Black
>   *	tree.
>   *
> + * - Pages:
> + *	struct drm_gpusvm_pages holds the DMA mapping state for a range of
> + *	CPU virtual addresses: the DMA mapped device addresses,
> + *	the device private pagemap, the IOVA state, the per mapping
> + *	notifier sequence number, and the drm_device that owns the DMA
> + *	mappings.
> + *	A driver embeds one or more struct drm_gpusvm_pages alongside its
> + *	struct drm_gpusvm_range, choosing one of two layouts:
> + *
> + *	1:1 - one drm_gpusvm_pages per range (one drm_device). Simplest
> + *	layout; to mirror a VA range on several devices a driver uses a
> + *	separate range (and notifier) per device, so the HMM fault is taken
> + *	once per device.
> + *
> + *	N:1 - one drm_gpusvm_pages per drm_device, all sharing one range and
> + *	notifier; only the per-device DMA mapping differs. The instances must
> + *	sit in contiguous memory so a single drm_gpusvm_range_set_unmapped()
> + *	can mark them all. A driver can keep one instance inline for the single
> + *	device case and switch to a heap array only when more devices join,
> + *	e.g.:
> + *
> + *	.. code-block:: c
> + *
> + *		struct driver_range {
> + *			struct drm_gpusvm_range base;
> + *			unsigned int num_pages;	// 1: inline_pages, >1: pages[]
> + *			union {
> + *				struct drm_gpusvm_pages inline_pages;
> + *				struct drm_gpusvm_pages *pages;
> + *			};
> + *		};
> + *
> + *	In the N:1 case the driver allocates the pages array (e.g. with
> + *	kmalloc_array(num_pages, ...)), initialises each entry with

Sashiko suggests kcalloc here or drm_gpusvm_init_pages() zeros all fields.

I tend to lean towards alloc dynamic structs as zero and have init
functions set fields but either works for me. But the doc and
implementation should be consistent.

Matt

> + *	drm_gpusvm_init_pages(), and frees each entry with
> + *	drm_gpusvm_free_pages() plus the array itself, from its range free
> + *	callback. Each drm_gpusvm_pages is mapped independently by their own
> + *	drm_device.
> + *	Each drm_gpusvm_pages must be initialised with drm_gpusvm_init_pages()
> + *	and released with drm_gpusvm_free_pages() in driver range free callback.
> + *
>   * - Operations:
>   *	Define the interface for driver-specific GPU SVM operations such as
>   *	range allocation, notifier allocation, and invalidations.
> @@ -92,7 +133,7 @@
>   * range RB tree and list, as well as the range's DMA mappings and sequence
>   * number. GPU SVM manages all necessary locking and unlocking operations,
>   * except for the recheck range's pages being valid
> - * (drm_gpusvm_range_pages_valid) when the driver is committing GPU bindings.
> + * (drm_gpusvm_pages_valid) when the driver is committing GPU bindings.
>   * This lock corresponds to the ``driver->update`` lock mentioned in
>   * Documentation/mm/hmm.rst. Future revisions may transition from a GPU SVM
>   * global lock to a per-notifier lock if finer-grained locking is deemed
> @@ -140,15 +181,20 @@
>   *
>   * .. code-block:: c
>   *
> - *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct drm_gpusvm_range *range)
> + *	struct driver_range {
> + *		struct drm_gpusvm_range base;
> + *		struct drm_gpusvm_pages pages;
> + *	};
> + *
> + *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct driver_range *drange)
>   *	{
>   *		int err = 0;
>   *
> - *		driver_alloc_and_setup_memory_for_bind(gpusvm, range);
> + *		driver_alloc_and_setup_memory_for_bind(gpusvm, drange);
>   *
>   *		drm_gpusvm_notifier_lock(gpusvm);
> - *		if (drm_gpusvm_range_pages_valid(range))
> - *			driver_commit_bind(gpusvm, range);
> + *		if (drm_gpusvm_pages_valid(gpusvm, &drange->pages))
> + *			driver_commit_bind(gpusvm, drange);
>   *		else
>   *			err = -EAGAIN;
>   *		drm_gpusvm_notifier_unlock(gpusvm);
> @@ -160,6 +206,8 @@
>   *			     unsigned long gpuva_start, unsigned long gpuva_end)
>   *	{
>   *		struct drm_gpusvm_ctx ctx = {};
> + *		struct driver_range *drange;
> + *		struct drm_gpusvm_range *range;
>   *		int err;
>   *
>   *		driver_svm_lock();
> @@ -174,6 +222,7 @@
>   *			err = PTR_ERR(range);
>   *			goto unlock;
>   *		}
> + *		drange = container_of(range, struct driver_range, base);
>   *
>   *		if (driver_migration_policy(range)) {
>   *			err = drm_pagemap_populate_mm(driver_choose_drm_pagemap(),
> @@ -183,7 +232,10 @@
>   *				goto retry;
>   *		}
>   *
> - *		err = drm_gpusvm_range_get_pages(gpusvm, range, &ctx);
> + *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
> + *					   gpusvm->mm, &range->notifier->notifier,
> + *					   drm_gpusvm_range_start(range),
> + *					   drm_gpusvm_range_end(range), &ctx);
>   *		if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {	// CPU mappings changed
>   *			if (err == -EOPNOTSUPP)
>   *				drm_gpusvm_range_evict(gpusvm, range);
> @@ -192,7 +244,7 @@
>   *			goto unlock;
>   *		}
>   *
> - *		err = driver_bind_range(gpusvm, range);
> + *		err = driver_bind_range(gpusvm, drange);
>   *		if (err == -EAGAIN)	// CPU mappings changed
>   *			goto retry
>   *
> @@ -205,6 +257,22 @@
>   *
>   * .. code-block:: c
>   *
> + *	// The driver owns the drm_gpusvm_pages lifecycle. The natural place
> + *	// to release it is the ops->range_free callback, which the framework
> + *	// invokes when the range refcount drops to zero inside
> + *	// drm_gpusvm_range_remove(). drm_gpusvm_free_pages() unmaps any
> + *	// lingering DMA mapping and a no-op if already unmapped and frees the
> + *	// dma_addr array.
> + *	void driver_range_free(struct drm_gpusvm_range *range)
> + *	{
> + *		struct driver_range *drange =
> + *			container_of(range, struct driver_range, base);
> + *
> + *		drm_gpusvm_free_pages(range->gpusvm, &drange->pages,
> + *				      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
> + *		kfree(drange);
> + *	}
> + *
>   *	void __driver_garbage_collector(struct drm_gpusvm *gpusvm,
>   *					struct drm_gpusvm_range *range)
>   *	{
> @@ -215,6 +283,7 @@
>   *			drm_gpusvm_range_evict(gpusvm, range);
>   *
>   *		driver_unbind_range(range);
> + *		// Pages are released by driver_range_free() (ops->range_free).
>   *		drm_gpusvm_range_remove(gpusvm, range);
>   *	}
>   *
> @@ -236,17 +305,22 @@
>   *	{
>   *		struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
>   *		struct drm_gpusvm_range *range = NULL;
> + *		struct driver_range *drange;
>   *
>   *		driver_invalidate_device_pages(gpusvm, mmu_range->start, mmu_range->end);
>   *
>   *		drm_gpusvm_for_each_range(range, notifier, mmu_range->start,
>   *					  mmu_range->end) {
> - *			drm_gpusvm_range_unmap_pages(gpusvm, range, &ctx);
> + *			drange = container_of(range, struct driver_range, base);
> + *
> + *			drm_gpusvm_unmap_pages(gpusvm, &drange->pages,
> + *					       drm_gpusvm_range_size(range) >> PAGE_SHIFT,
> + *					       &ctx);
>   *
>   *			if (mmu_range->event != MMU_NOTIFY_UNMAP)
>   *				continue;
>   *
> - *			drm_gpusvm_range_set_unmapped(range, mmu_range);
> + *			drm_gpusvm_range_set_unmapped(range, &drange->pages, 1, mmu_range);
>   *			driver_garbage_collector_add(gpusvm, range);
>   *		}
>   *	}
> @@ -640,8 +714,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>  	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
>  	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>  	INIT_LIST_HEAD(&range->entry);
> -	range->pages.notifier_seq = LONG_MAX;
> -	range->pages.drm = gpusvm->drm;
>  	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>  
>  	return range;
> @@ -930,7 +1002,7 @@ drm_gpusvm_range_chunk_size(struct drm_gpusvm *gpusvm,
>  		 * mallocs 16k but the CPU VMA is ~128k which results in 64k SVM
>  		 * ranges. When migrating the SVM ranges, some processes fail in
>  		 * drm_pagemap_migrate_to_devmem with 'migrate.cpages != npages'
> -		 * and then upon drm_gpusvm_range_get_pages device pages from
> +		 * and then upon drm_gpusvm_get_pages device pages from
>  		 * other processes are collected + faulted in which creates all
>  		 * sorts of problems. Unsure exactly how this happening, also
>  		 * problem goes away if 'xe_exec_system_allocator --r
> @@ -1335,27 +1407,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  
> -/**
> - * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - *
> - * This function determines if a GPU SVM range pages are valid. Expected be
> - * called holding gpusvm->notifier_lock and as the last step before committing a
> - * GPU binding. This is akin to a notifier seqno check in the HMM documentation
> - * but due to wider notifiers (i.e., notifiers which span multiple ranges) this
> - * function is required for finer grained checking (i.e., per range) if pages
> - * are valid.
> - *
> - * Return: True if GPU SVM range has valid pages, False otherwise
> - */
> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range)
> -{
> -	return drm_gpusvm_pages_valid(gpusvm, &range->pages);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
> -
>  /**
>   * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1636,29 +1687,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
>  
> -/**
> - * drm_gpusvm_range_get_pages() - Get pages for a GPU SVM range
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - * @ctx: GPU SVM context
> - *
> - * This function gets pages for a GPU SVM range and ensures they are mapped for
> - * DMA access.
> - *
> - * Return: 0 on success, negative error code on failure.
> - */
> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
> -			       struct drm_gpusvm_range *range,
> -			       const struct drm_gpusvm_ctx *ctx)
> -{
> -	return drm_gpusvm_get_pages(gpusvm, &range->pages,
> -				    gpusvm->mm,
> -				    &range->notifier->notifier,
> -				    drm_gpusvm_range_start(range),
> -				    drm_gpusvm_range_end(range), ctx);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_get_pages);
> -
>  /**
>   * drm_gpusvm_unmap_pages() - Unmap GPU svm pages
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1689,29 +1717,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);
>  
> -/**
> - * drm_gpusvm_range_unmap_pages() - Unmap pages associated with a GPU SVM range
> - * @gpusvm: Pointer to the GPU SVM structure
> - * @range: Pointer to the GPU SVM range structure
> - * @ctx: GPU SVM context
> - *
> - * This function unmaps pages associated with a GPU SVM range. If @in_notifier
> - * is set, it is assumed that gpusvm->notifier_lock is held in write mode; if it
> - * is clear, it acquires gpusvm->notifier_lock in read mode. Must be called on
> - * each GPU SVM range attached to notifier in gpusvm->ops->invalidate for IOMMU
> - * security model.
> - */
> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range,
> -				  const struct drm_gpusvm_ctx *ctx)
> -{
> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
> -					       drm_gpusvm_range_end(range));
> -
> -	return drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages, ctx);
> -}
> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_unmap_pages);
> -
>  /**
>   * drm_gpusvm_range_evict() - Evict GPU SVM range
>   * @gpusvm: Pointer to the GPU SVM structure
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index e32d3bcb47b..5edfa7d0c36 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -177,7 +177,6 @@ struct drm_gpusvm_range_flags {
>   * @refcount: Reference count for the range
>   * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>   * @entry: List entry to fast interval tree traversal
> - * @pages: The pages for this range.
>   * @flags: Flags for range see &struct drm_gpusvm_range_flags
>   *
>   * This structure represents a GPU SVM range used for tracking memory ranges
> @@ -189,7 +188,6 @@ struct drm_gpusvm_range {
>  	struct kref refcount;
>  	struct interval_tree_node itree;
>  	struct list_head entry;
> -	struct drm_gpusvm_pages pages;
>  	struct drm_gpusvm_range_flags flags;
>  };
>  
> @@ -307,20 +305,9 @@ drm_gpusvm_range_get(struct drm_gpusvm_range *range);
>  
>  void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>  
> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range);
> -
>  bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>  			    struct drm_gpusvm_pages *svm_pages);
>  
> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
> -			       struct drm_gpusvm_range *range,
> -			       const struct drm_gpusvm_ctx *ctx);
> -
> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
> -				  struct drm_gpusvm_range *range,
> -				  const struct drm_gpusvm_ctx *ctx);
> -
>  bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
>  			    unsigned long end);
>  
> -- 
> 2.34.1
> 
