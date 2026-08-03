Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B3C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74D089125;
	Mon,  3 Aug 2026 18:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jn7gnQOm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D8810E77A;
 Mon,  3 Aug 2026 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785782891; x=1817318891;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=FEvsqek4MqSIT7wmQFOBw2R0Pt+rFIRmPU4JcWGC8WE=;
 b=Jn7gnQOmr3w0Re3/lDbbJgenUYSHkGHchhdCyXZ03cGclV61IMiUKLUu
 5aMrik/r5g0L+n5+Oo2GpLhO/JTOTuZCpYYyd2FMWQtiJDDTcNELp/in8
 KwY5YGJmHIln50+K7O3hWRpXxFTak0QZrt1R8X1eiOVmhJlZRpZIVuc6v
 Ij9BwMXioEBHV9RBF0pD4pTiAQs2tvA0nJZ/QR1kL6VYv1Auxy5oZ2JmW
 KWgzknlUWL7lq6EuGOPJfE6Ib/t4/1PJ491d/4NefHcsiexTu20OiPJyl
 eMNUfsXv4FgV6c/0r/ifNhDTR6iev7n9Jry36JMHe/OJMxYlOxs62BTOg w==;
X-CSE-ConnectionGUID: TLs+4WS/S3KoncIkVkv2pg==
X-CSE-MsgGUID: 0/Mp61vZSJKrrAqYQMt2bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103731554"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="103731554"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 11:48:11 -0700
X-CSE-ConnectionGUID: n/t/EYyEQ+K68gK08mZjbg==
X-CSE-MsgGUID: LdHhuF2LQV+jYu4vOgYQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="299519656"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 11:48:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:48:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 11:48:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqKQKogDPFX4YoHQbENtiSi9yyvryoMVlSdXu3iqe2YbhaqcekH5JSC7NfULE51Pr/yoKu4oC8ismAQxKLK2yAjj5eLDGBOmTazVktaUtZitxfn5Kd3CUfM9mfUZWiqVlou8ncQVV21xtzyqjDnSy4CRbVIWkRiZ8F2VQVgFHCAfdX2i+kHiRGmBiYysv2OzRgxrgkGQ5QwF6azZnJCdjuXbA9kRmb62z1aVezNYtD/pIreX4Z+0V2EFpQsimg5tc1PVk8aP9HqSVklc7Le0PKFfgpWrZ6Ek9s8QdRvAy8s8lnS+nw9DlYrQtkbO9r/inA+6oh2Oi84pD3EAqo59ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyZIpUi1IHRWDfgL+54cSMIw2XB1pJ2ujLim5OuOzhc=;
 b=bYMDvXnp2mBQvyuFZvIh/AjXDeR9d10woqIpbrGielEaiGs7CE0qlQbJyMFef82wec6W+lIv/0e9dMN/uMR138D6hxGDbrcAbBiGxaETjugWAsyaQy9GbHeU17BVSL9YNxyVEHyG1kh7hlN4q+I85+VBy1pWI7uiZoGk9p2S/ra0Q5DKoTh/rdOuDBLqNMLeb656DqWXQhLbcOfYnHeyrlp+B10uvpa+H1+AtpwUTrCRpIoFgtA4tLBCTPwkVj8Gok/9qhdiPhqSaSL9pdHKeTVdExeXXgppaQasE8s8hkNL//2vK8fx/uQgt66ihszRoh8WgNHhn6mPE8clZdXc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 18:48:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:48:03 +0000
Date: Mon, 3 Aug 2026 11:47:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R.
 Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Dave Airlie <airlied@redhat.com>, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH 3/3] drm/ttm: allocate pool pages as compound (__GFP_COMP)
Message-ID: <anDiX4L3Oz8fKJCW@gsse-cloud1.jf.intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <20260722044220.1110278-3-matthew.brost@intel.com>
 <80fdf249-6f24-4cc7-bc9a-91bf23293497@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80fdf249-6f24-4cc7-bc9a-91bf23293497@amd.com>
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf27c39-3ef9-4014-a222-08def18fbf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: q4GmUfpsSmBTfMgfDCQpzj8HfwY8ZP+gOfSMmCmFejyIcnqa9g778j47gPrHuApW/EZ0LzIsgZO3xw5f6ZxLvrztouUZdmmyq7jRAwMaBF64hKMKUynevFIJidm8KPY6POP+GbENsMUMMvWAp1Gd9ASqitCZdHQt1E2HNrsgvyFS9MZkOYLnCuGvBy3Grmw4uYf6SerpF1QgoaYAFkvdmjkPaNXtUhpfJazyh5D7kajttnrfOb+wtsa8Nbqt4jVIJGz/mhTdn38gBnsJ1urHsdYPazr5f3hgczCez4w2JiYvpouNbI/y/nzAe8jkVQYn2lIau4zLRP5By6BAM8E2EV++H22EzfJXDJM0DdjP1jml05u7pspHF+ACMkT8oD1FwGcHGCl641+rF62b7VsynstnidcRx3MwrUyR5N6t56QxVac88nwovxxgGoDnsMUcsQAxSHWlExbbh1COLSf+a1bqJIT0UXo6cpJGAiNWpaaB4DiZ4K3/NVHs/C0cUIuV2Xk2A0mIZtZtRgBwsHqkn9HDqbVbIpL3q7LNkP7kBYr9sTh4vX/yxS+tssBdq5ePfQhyunyYFbuc72mtaH3HeMaeEAcqB/FRb2a2b4T3RDU0MpZalFCV9EppNEK8Vt6oEN4/ae2ISgC9sAgcrJFyr2UPj1RuIYlsKv5Z+G+EZLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yvb2IOYcte7duJ+YkFbcxfzIQk+FixE3wM/1NDTgWEjMwCZ7myRJBkNBPH?=
 =?iso-8859-1?Q?7QWK159CP2IkzA+kvdbIbQE9aG5guzndETZ485/wVrJfu9gNIVWJs8xz7E?=
 =?iso-8859-1?Q?LO4OlsBJnHTeQVXDMWmCyBcnHkJ7Z3nOMbhuIwvkeOSBNhuLS80ks78/As?=
 =?iso-8859-1?Q?a8MEPL2M/TxuZbZiOYbohkDhunf+xyN1YpxodrYik6Uj3aqRtReOUmZgMJ?=
 =?iso-8859-1?Q?dC2MYkNI3xn+178hXOi41FAQgVVU55O2NAqwbu9QVFTCT6oKx7V+tK3vC/?=
 =?iso-8859-1?Q?xs/KfIw2dcVrrI9N14/u7/B5vNdfYOEqUODt+n6kU7z/CBc9xsm6dk9LMx?=
 =?iso-8859-1?Q?MEKxuIWHqcyYoLz0T3WaGZtWc27eqfHDMAouLpST5PdG4G0oJ3IggYL67k?=
 =?iso-8859-1?Q?HJEXGr23CdfbB+J4ZZFBnif2NfFDmrk9PgZnXuf6YWzebIz+erZdkFEG9d?=
 =?iso-8859-1?Q?s/D0SaScQLNB3m/CEqLuTxIFmggaqNK/wS9l5c8ZsXEUgKFVeYDR8DMxBG?=
 =?iso-8859-1?Q?EFXqJ6lq0Dd28jtabp+TJVhC6QDXm7zbKkwdw+zLy3ee6RG7OpkbM5NjJT?=
 =?iso-8859-1?Q?fSJ7Q6mIaktFYpK0OnrLv+SLgUByabwqLLPUCBkpBOCbTbAidEIsC9d47T?=
 =?iso-8859-1?Q?5EMT+5IEAKayHO8YH6xNZJBaQldc23gFSju7jrOQXZMr5C9graHb3Q0SxG?=
 =?iso-8859-1?Q?63vjquT1NNSCjMMZbwiDT7K3smxn64o+VAxEqaxP/bWjWnk9d9raPyDHxk?=
 =?iso-8859-1?Q?v2/ZBOjK+1x1LYf97i75O1GoLA18ScIbkIro4KiRD6Pxuv1yl/AIOo8OBi?=
 =?iso-8859-1?Q?KeU5YPWFWk9RIqF1umYryC9k+ZLUmkjKkzI2xueqh4wkDprL1Ha7IlGwRB?=
 =?iso-8859-1?Q?R0ctWiUaERaiKr9HFA796UojG8ae/L4LWo3leaZyFVehUWY/0MfAX3Q4Z5?=
 =?iso-8859-1?Q?GtoTT5oZLG/ruLkCjMm5NZRW7o+NJfemiZlL4VYNTHUYtxkhhROaQ9FD9f?=
 =?iso-8859-1?Q?dqrufAl8ogyivSTIx8XxI2sU25HxwJXBoCSxHND1g1MWpbEVVcrR7sI8j4?=
 =?iso-8859-1?Q?p7nJKX8jrDZBZ89Ayebt7ieDienvDxU1D8ngAi6TWpQpGF3wEVWa7P15ar?=
 =?iso-8859-1?Q?lhB/ZiQR2Un1eniv1qmI3ijSayTqHKIi2DOZx3l9I92HDd6/fbBv9vOIGM?=
 =?iso-8859-1?Q?5nTDgX/UGdgHiORMjPHg97jg2jujAMBGk71VfRI7F/1vAjGvOU1NgM5+rS?=
 =?iso-8859-1?Q?tbIMGoRM9WglW5Hp0Ag0EWNjFm00gvW9NFjETuT3hjsKc3c8n7kFprc/u5?=
 =?iso-8859-1?Q?qvV91Vjx7mYVtec8FKN1KcOJN9F6KVtPXv2wcEK2L3uzmKQqu5b45/aejP?=
 =?iso-8859-1?Q?ffavsxiCpp7G6FIZJ1BDaEbMa6b1G6r0WW+mln8rlWkQhnWbbzZAwWyclB?=
 =?iso-8859-1?Q?edKBFsp9Lrpjn5yNrfzAmNMWe+l77Dw4yDjc56qAOnbHK5zMWwn9FyukQs?=
 =?iso-8859-1?Q?W/IaA3QWhRztczCGzuYz8j7Hp12v20uhS8CYUKOA3+AuLcaA/2fyq3TjRZ?=
 =?iso-8859-1?Q?NswXCrakSjrGWKd9sB7gLYWLBOYz/c2Z3/4f0DceG5cEGlZ/b0G+ArDBWx?=
 =?iso-8859-1?Q?sM/syD2MG2w4Wkz979dkr3t6tvmCosFsHifsYjDrxMEw5QLS3Oqx0x0/gz?=
 =?iso-8859-1?Q?A/yF7WysXgR/KXhn/oPbW6EfmtEkMG5+Rwk8rFzHKeyqRMatkVCwKBx3BZ?=
 =?iso-8859-1?Q?hC+vg0b+KqjwO0O7KLecxjg//4pCKDQ5q4xRxoU8qURGXKjboRMGysrC6B?=
 =?iso-8859-1?Q?NBjPa81Ngw=3D=3D?=
X-Exchange-RoutingPolicyChecked: QoNI5YSH6ke9EfMNcr3slYzTj9rs2xuBSGWSyiqOs7h2RL8O06L+sSuyQbMFqIqVShTHfPjLlrU/eIeGuosZ3VrUaSGRQlZZIq4aZLRFeIYNom1otBxpVXg7DO+MCtGLvrxljbRfkwMXLd4u2RRbD+/SeFpiDFeWXw3oZZ0XuUFPtTKbD5cwevqKsm3J3Yty6ljQ8Gfms22ki3bENAqovEYXdWWMSk/ntRyg+DpI2l6ExOs5vKNoUG4PIWgCThmgtHHGg7ZBvR/d2UfdIcf0aigxTtt874TyGRJFgHDd8NxldvmNVJi0Yha8I+M0OFO35yXcSI1/MnWNWVgrBHLmTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf27c39-3ef9-4014-a222-08def18fbf93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:48:03.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzeqzX02C5F1a6wjhX0LVrZYXLVsQve5mf43u+BNJUt4GGumDen12KJO18IHtqzzPBb/jTYVUx92KQyuaD3NKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
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

On Mon, Aug 03, 2026 at 03:54:27PM +0200, Christian König wrote:
> On 7/22/26 06:42, Matthew Brost wrote:
> > Historically ttm_pool_alloc_page() deliberately avoided __GFP_COMP for
> > higher-order allocations and instead stashed the allocation order in
> > page->private. The stated reason was that mapping a TTM page into a
> > userspace process and having that process call put_page() on it would be
> > illegal on a compound page, because the stray reference would fold into
> > the compound head and could free the whole block behind TTM's back.
> > 
> > That hazard no longer applies to the non-DMA path. TTM faults its pages
> > into userspace via VM_PFNMAP (see ttm_bo_vm_fault_reserved() /
> > vmf_insert_pfn_prot()), so the core mm never takes a struct page
> > reference on them and GUP rejects the range; a stray userspace put_page()
> > cannot reach these pages at all.
> 
> Yeah unfortunately I clearly have to reject that.
> 
> This is exactly what we have thought before but that doesn't hold true. Especially KVM completely broke our neck here.
>

I haven't tried KVM, but it's entirely possible that KVM or another part
of the kernel breaks TTM usage here.

It didn't take me long to put this together after it was brought up in
the other thread. It makes TTM a bit clearer and also simplifies my
defrag series quite a bit, since that series included several extra
steps because there's currently no reliable way to determine whether a
page is the head page without native compound-page support or
reinventing this in TTM.

Xe appeared to work correctly with these changes, which is why I decided
to post them.

> But let's continue the discussion on the other thread.
> 

+1, I saw your response there. Hopefully we can figure it out, as I'd
very much consider this a nice-to-have cleanup.

Matt

> Regards,
> Christian.
> 
> 
> > 
> > Convert the !ttm_pool_uses_dma_alloc() path to allocate compound pages
> > with __GFP_COMP and recover the order via folio_order() instead of
> > page->private:
> > 
> >   - ttm_pool_alloc_page(): add __GFP_COMP, drop the page->private write.
> >   - ttm_pool_page_order() / ttm_pool_unmap_and_free(): read the order
> >     from folio_order() for the non-DMA case.
> >   - ttm_pool_split_for_swap(): for compound folios, split via the new
> >     folio_split_driver_managed() helper rather than split_page(), which
> >     rejects compound pages. Each resulting order-0 folio is then freed
> >     individually as it is backed up.
> >   - Drop the now-dead page->private = 0 clears on the purge and
> >     full-backup free paths.
> > 
> > The DMA path is intentionally left unchanged: dma_alloc_attrs() does not
> > produce compound pages, so it keeps split_page() and the page->private
> > order stash.
> > 
> > folio_split_driver_managed() lives in the THP split machinery
> > (mm/huge_memory.c), which only builds when CONFIG_TRANSPARENT_HUGEPAGE
> > is enabled. Drivers that drive the TTM shrinker and therefore reach the
> > split path must select TRANSPARENT_HUGEPAGE.
> > 
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: "Liam R. Howlett" <liam@infradead.org>
> > Cc: Nico Pache <npache@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Dev Jain <dev.jain@arm.com>
> > Cc: Barry Song <baohua@kernel.org>
> > Cc: Lance Yang <lance.yang@linux.dev>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Assisted-by: GitHub-Copilot:claude-opus-4.8
> > ---
> >  drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 23 +++++++++---
> >  drivers/gpu/drm/ttm/ttm_backup.c          |  8 ++--
> >  drivers/gpu/drm/ttm/ttm_pool.c            | 46 +++++++++++++++--------
> >  3 files changed, 53 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> > index be75c8abf388..771ed257778c 100644
> > --- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> > +++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
> > @@ -169,7 +169,14 @@ static void ttm_pool_alloc_basic(struct kunit *test)
> >  			KUNIT_ASSERT_NOT_NULL(test, (void *)fst_page->private);
> >  			KUNIT_ASSERT_NOT_NULL(test, (void *)last_page->private);
> >  		} else {
> > -			KUNIT_ASSERT_EQ(test, fst_page->private, params->order);
> > +			/*
> > +			 * The non-DMA path allocates compound pages, so the
> > +			 * order is recovered from the folio rather than from
> > +			 * page->private.
> > +			 */
> > +			KUNIT_ASSERT_EQ(test,
> > +					folio_order(page_folio(fst_page)),
> > +					params->order);
> >  		}
> >  	} else {
> >  		if (ttm_pool_uses_dma_alloc(pool)) {
> > @@ -177,13 +184,19 @@ static void ttm_pool_alloc_basic(struct kunit *test)
> >  			KUNIT_ASSERT_NULL(test, (void *)last_page->private);
> >  		} else {
> >  			/*
> > -			 * We expect to alloc one big block, followed by
> > -			 * order 0 blocks
> > +			 * We expect to alloc one or more max-order compound
> > +			 * blocks. page_folio() on any subpage resolves to the
> > +			 * compound head, so both the first and last pages
> > +			 * report the max block order.
> >  			 */
> > -			KUNIT_ASSERT_EQ(test, fst_page->private,
> > +			KUNIT_ASSERT_EQ(test,
> > +					folio_order(page_folio(fst_page)),
> > +					min_t(unsigned int, MAX_PAGE_ORDER,
> > +					      params->order));
> > +			KUNIT_ASSERT_EQ(test,
> > +					folio_order(page_folio(last_page)),
> >  					min_t(unsigned int, MAX_PAGE_ORDER,
> >  					      params->order));
> > -			KUNIT_ASSERT_EQ(test, last_page->private, 0);
> >  		}
> >  	}
> >  
> > diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
> > index 3c067aadc52d..9194747a1dff 100644
> > --- a/drivers/gpu/drm/ttm/ttm_backup.c
> > +++ b/drivers/gpu/drm/ttm/ttm_backup.c
> > @@ -72,9 +72,11 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
> >   * ttm_backup_backup_folio() - Backup a folio
> >   * @backup: The struct backup pointer to use.
> >   * @folio: The folio to back up.
> > - * @order: The allocation order of @folio.  Since TTM allocates higher-order
> > - *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
> > - *         return 1; the caller must pass the true order explicitly.
> > + * @order: The allocation order of @folio, passed explicitly. For the DMA
> > + *         path TTM allocates higher-order pages without __GFP_COMP, so
> > + *         folio_order(@folio) would return 0 rather than the true order;
> > + *         the caller therefore passes the order explicitly. (The non-DMA
> > + *         path allocates compound pages, for which the two agree.)
> >   * @writeback: Whether to perform immediate writeback of the folio's pages.
> >   * This may have performance implications.
> >   * @idx: A unique integer for the first page of the folio and each struct backup.
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 1bf37023fed6..364cc7ec7469 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -168,9 +168,11 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >  	struct page *p;
> >  	void *vaddr;
> >  
> > -	/* Don't set the __GFP_COMP flag for higher order allocations.
> > -	 * Mapping pages directly into an userspace process and calling
> > -	 * put_page() on a TTM allocated page is illegal.
> > +	/*
> > +	 * For higher-order allocations be a good citizen: don't dip into
> > +	 * memory reserves, don't retry hard, don't warn on failure and stay
> > +	 * on the local node. The non-DMA path additionally sets __GFP_COMP
> > +	 * below; the DMA path allocates via dma_alloc_attrs().
> >  	 */
> >  	if (order)
> >  		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
> > @@ -189,11 +191,9 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >  	}
> >  
> >  	if (!ttm_pool_uses_dma_alloc(pool)) {
> > -		p = alloc_pages_node(pool->nid, gfp_flags, order);
> > -		if (p) {
> > -			p->private = order;
> > +		p = alloc_pages_node(pool->nid, gfp_flags | __GFP_COMP, order);
> > +		if (p)
> >  			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1 << order);
> > -		}
> >  		return p;
> >  	}
> >  
> > @@ -482,7 +482,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> >  		return dma->vaddr & ~PAGE_MASK;
> >  	}
> >  
> > -	return p->private;
> > +	return folio_order(page_folio(p));
> >  }
> >  
> >  /*
> > @@ -493,15 +493,31 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> >  static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *p)
> >  {
> >  	unsigned int order = ttm_pool_page_order(pool, p);
> > -	pgoff_t nr;
> >  
> >  	if (!order)
> >  		return;
> >  
> > -	split_page(p, order);
> > -	nr = 1UL << order;
> > -	while (nr--)
> > -		(p++)->private = 0;
> > +	if (ttm_pool_uses_dma_alloc(pool)) {
> > +		pgoff_t nr;
> > +
> > +		/*
> > +		 * DMA-alloc pages are not compound; split the plain
> > +		 * higher-order allocation and clear the per-page private
> > +		 * (which held the order for the non-compound case).
> > +		 */
> > +		split_page(p, order);
> > +		nr = 1UL << order;
> > +		while (nr--)
> > +			(p++)->private = 0;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * The non-DMA path allocates compound folios (__GFP_COMP). Split the
> > +	 * driver-owned, off-LRU, unmapped folio into order-0 folios so each
> > +	 * page can be freed as soon as it has been backed up.
> > +	 */
> > +	folio_split_driver_managed(page_folio(p), 0);
> >  }
> >  
> >  /**
> > @@ -548,7 +564,7 @@ static pgoff_t ttm_pool_unmap_and_free(struct ttm_pool *pool, struct page *page,
> >  
> >  		pt = ttm_pool_select_type(pool, caching, order);
> >  	} else {
> > -		order = page->private;
> > +		order = folio_order(page_folio(page));
> >  		nr = (1UL << order);
> >  	}
> >  
> > @@ -1124,7 +1140,6 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
> >  					       num_pages);
> >  			if (flags->purge) {
> >  				shrunken += num_pages;
> > -				page->private = 0;
> >  				__free_pages_gpu_account(page, order, false);
> >  				memset(tt->pages + i, 0,
> >  				       num_pages * sizeof(*tt->pages));
> > @@ -1214,7 +1229,6 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
> >  		}
> >  
> >  		/* Fully backed up: free at native order. */
> > -		page->private = 0;
> >  		__free_pages_gpu_account(page, order, false);
> >  	}
> >  
> 
