Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4E4F94CC1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 04:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D91310E262;
	Wed, 22 Apr 2026 04:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aJ4XUswj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0508D10E261;
 Wed, 22 Apr 2026 04:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776831171; x=1808367171;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=PIEmcel9vRtWbR21X5Jo458J4le8u/k9Simkk95yrio=;
 b=aJ4XUswjnn1pkK9kG4RPoi5UF0zoxuG+TGnRv9njM1Ty3jQwy6F5BZyT
 1dsZb2OqeZk4SIzUJ+xuuuVxz1FWOPHnAckjfUi6+xZIGokPe48d5xsvG
 Y5XszznfkXFagR1ME3PRL9oe2kNM0GkW9+V7U7qr08rdiTzY66fX5tN0s
 bw95vGwA3dwbOs8op7Ifm8Y9rJf9rfIfcsGjLTXp9oUumrFNVn3zeNej8
 P1rFrQ8ZtQKHkGVjNqz3opLafOF0qk4GiVGQ6niM7NhaPUfQtGrlNMIJZ
 g8eZEtZANuYoZ1CnhinAKrD+HsX1LJFEVMAalB+8SFk34mqBY913EIZFp Q==;
X-CSE-ConnectionGUID: 6jq8MjopQA+G7WyiwCpOrQ==
X-CSE-MsgGUID: NSWDhg2cSL2rV4Kknvk1BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81644309"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="81644309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 21:12:50 -0700
X-CSE-ConnectionGUID: 2w+RFvt3RFazGgRego78fQ==
X-CSE-MsgGUID: B/QB1CQ3SBO4dKX++4BvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="236242409"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 21:12:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 21:12:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 21:12:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 21:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFEAiyS9nT6WK6KN0ppQ3IaMyFvDqh7zwwxPiZbiQZHECKXdeHpeXzLvqRuSTj5ecNIikDiZLG1iV3pA7EltF0Rouu14f75HPIzwzhAbOjBXxG6hzIrlooE5HO+WWQ+m0OMKpwgzVE70VxX25e11XuAD2vFbvlM6URH/GR8bnBRt8OeFT4OFgGo70sjkOFQII6tEXLBGJp/QqTf8J3ElCZI8yGEN8y3Aj3nS3+zo87ZmKopkN4x7qY5dwqS5yJei9OAtM83VfCk5kfgSRqfY+WyuQVGlo1QiaqXT7cJW9kJYf3QJNrBVVMq64tdvysTlLuxcmgvEL2m2JpbQPJg21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWvTbfPIjS6xufCFYr9t5YsybkOVTP7xIgQyV9o2mCM=;
 b=dYpq93crmEa7wnbb6czlUWUiSUke447GPFEokERidKpVSViS8hHE1nMZyR03fHI7UnUFYBuNwpmyuNyZLvLvu1U/uL6FkEorwoDNKBQWm8QGohD4bhBQX5wEiA6+63ElLaVdQJNMmZqOQgsqCxobrk3c0ZE48gf8XFMCPlo7he01ofp+SCNLF+k3moUaKg5NldAf4fL/qzmJFkld0ohcvw19PRm2t/POcd+OvIz8M8Sy2EXSiIwVZFaPUNGBJa4Ts6f7Vs25ivk+F7QtqB+nWmfv/5Pubz2160zRpIf0c+Ci510GIxjPp5ruSLw1GUO0sJ5h+Z8eF5yWT0BRxO8lPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 04:12:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 04:12:45 +0000
Date: Tue, 21 Apr 2026 21:12:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
Message-ID: <aehKusO6Sc1Qn+Wi@gsse-cloud1.jf.intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <aecef1f3-5625-48b2-9117-b14cb1b61e50@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aecef1f3-5625-48b2-9117-b14cb1b61e50@amd.com>
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b233fc-07e4-4852-48ed-08dea0256810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gGRfWKHfljqNPWuO6lE6vTUPfy36y8YVc9kS1ZWYZ1BuOyEVRvaR0CvMUTIsZFe+rL/PvEpEF6pga0/NtQXWF6/zXzzJDE5drNRSMrd92G7woziVicTv7d19Brly3MTp5f3UASTtM7WsUkwq8mqX2OTB2hCoH1l45UjU/YZWMTxs0DPrU+gpCxREVefZOHl5QF4anZ6dcJUlYNUj+yu27IR/G4GoaWl9kr6oGEe0zXidcFTwwrlYiPojhN5FC5Nk1rPBUNSWbk0rxbLxxyJOlFlR8uDSuvHwVaZOjIrFx10B+pNAuv0+aIYDcxO+jGBsZlnJ+ae7tZvTEPdyclmEoWNXjQUgEzfEDoTA9frhUHSCbOD5v6hnD+82SDSn4CXSysN3hh3WLOTuBf4ezIzYClPtay9xjvX+h/VCZq/G4coelIeX1M7N6vAFcoypW/OXaGPo/QJxMQzIp8U/1I62SvMBx0Tfff4Kz4pr04khIhBI5HUrhtEl79JebuoxawG8P6VGMUfgjmvnFT3aGkhrT0wISS5TPCngU3WvK3Ak6qUR3M8XgQaEGPJJV0J6LlhwT3P1bpPMmnt5CKCCdpz4gg9clm+fxBucsnZ2pv6R5s6SyBG4pIS49SGzax8DzVASKOtQAE3JqOWKCGu/rddAVzmI1rgixYGl+ZDmUj0dBSR8eSiKhpRLPLB7oQ/Xls0i7lh+l+Kc5O5dSOGISn9cDlbQlivYMtqupZl5jB9aLgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cCb6fUrbe+bEkQ0KLaLhqGZPjOICG/fcDyHlxZHVTH73KqdZBMK5X8/QqG?=
 =?iso-8859-1?Q?YaSdgbxI9Aciwtr0xv2i//8Vh+2uguRY6DqBX0Rzd44yj6TF2r5bqaEHUn?=
 =?iso-8859-1?Q?/AsTeW+Bo99YeEouE3dTOh3ZPELiPsBas7Bg4vlZibz6K3F9IUFxI2qxPn?=
 =?iso-8859-1?Q?CMWzfI94KkVmv3xsQ0T1Vt2TjCX2/dkdE43AFuRuLmZo4hn2voIDgPFjWQ?=
 =?iso-8859-1?Q?67qCDycnC5Ho/yq2m+vdReMM5T9u9KQDuzoUF3j7KsFang04Z8SO5h5zN+?=
 =?iso-8859-1?Q?xkpNZCRnMESAo7ktjI/AoCM1WrH7KibusndXuK+HgesIfT218qela9470P?=
 =?iso-8859-1?Q?Ul8ntYQ/NCZKRqge5YMYNFtNppcZ3IywW+7pTj/cuLsc3JT9fh2mnWjS3Q?=
 =?iso-8859-1?Q?QqY3yEseuthDL0T01DRtWXE7MuL5KsJaFBmnpQgaXWm9YvxabMFjTaKvsj?=
 =?iso-8859-1?Q?CFl9MOQTeEoXqq4nFxlws4XIBKcg1+AaOpUq6MzD8fOlhZSqoAtBpdpD+s?=
 =?iso-8859-1?Q?fXFN43XpzheyHM3cwpjg2Vrw0RxNIRFWzOFaVk0hT7JhJHhJ5ZqK2/CY1E?=
 =?iso-8859-1?Q?+pK9rVfQuv1t8FCfx5NOCsi5X8aLXcFyNlg7bCkOOF4t53OrGibc7FVIzY?=
 =?iso-8859-1?Q?WdCKsvlegtW10cjAHEeieQSaw+XUpHzUTGkvxzjZnTjx6ccaIKXbIpQ0tj?=
 =?iso-8859-1?Q?rI62MZLiy+oPOTrVRiNLofpmYiGvmSVyPPQ/RIKhV2epCjTIoGCoy4PU5p?=
 =?iso-8859-1?Q?cNByGxPd1C1p6uKHgyz8qVmTuYGd4MoscclM/tUrdbG/lshjGDknGbbR/c?=
 =?iso-8859-1?Q?+LHq+kbbBAqvbGAe47zGpFdKKli+MawzikzaDHXy+dCpmqpLkseGVYGQPa?=
 =?iso-8859-1?Q?kXyPbcRkePtrDI34s/w5d554CtuNORmZpsDV9yVeELl+yictY14pQzf7Em?=
 =?iso-8859-1?Q?2JLH0q7q+F8wgdbrYi6Vuurh94dGQkzaFMyODbpDu0wzF5Bq66yGUHlEy/?=
 =?iso-8859-1?Q?Zz4YDy5/m3hSmzxrLkjAwqXuYxeW5xcR9WxBNwTf48Ga+ASeEWHmZmvoPy?=
 =?iso-8859-1?Q?efY2CUiep6mVkcCQ9zpivTBVDOhPjLHtTcQNKRJVD/DtTM/ZbkEx/GCpnY?=
 =?iso-8859-1?Q?GS88fkuK5DmGeZuuL2OYKFIG8zL+XZyoAz3NKowD7s1VCuAT8PdDeXraAp?=
 =?iso-8859-1?Q?Sv9loymQHzVNTVtbV9QDW24M7OvB8u7u8ItIvubHLqmyVXBX2/vX5Pz5Ez?=
 =?iso-8859-1?Q?y7Tgo9K8jU7EkYYoXcbLnk/j09fB5gEFFU7LYxklr2VwKN9TS3tzN3cIMp?=
 =?iso-8859-1?Q?kcLvx3vfwe+/TGOWiZctIL+xntb9t8+Ey8/5Sy+PC2H0+Tbyp8wXF/FwHS?=
 =?iso-8859-1?Q?fLE8mlxOvRrK+cZHM1BhE3sWEkxt2YD4ttW6F7VYFXGIW0CBMzdZlixC/A?=
 =?iso-8859-1?Q?l3hs0OmZs2AINqVOBWjlwm3EPrNTrGQLEaxYxpwM3mO3YSX1w2xShrsdaD?=
 =?iso-8859-1?Q?dOBuHKL2ow5kVEH0ccqT9XXh+oPcqM+V6Oie/9oPzfmaqaxFzP2u2mj8ca?=
 =?iso-8859-1?Q?WZg+1Jyzpj/MDn8yYD3rzCCJaJgqVi8M/DiUO5PQ+XDOum1n7So/pSQ2/o?=
 =?iso-8859-1?Q?dkhoIgCK6imu49gPsuo//CG0gw4dfIxKC12ojxBXrUQeO/4ezLqLOn1/OH?=
 =?iso-8859-1?Q?c8GQUQYOi0D0GPMn9LxYoc3S5ock/UJxkqXMTEcYZkzS2V5D5I4QtyLo2Y?=
 =?iso-8859-1?Q?bBMPfF6gFBiqR87GOrsRyrsJz0FGAGoXBjrM4qUjuk9Y43dcLbOFkGzbMc?=
 =?iso-8859-1?Q?gQQ5sXpphD/nk+w1sL1Kz+WRClIMMmI=3D?=
X-Exchange-RoutingPolicyChecked: i74PVAzURBr/kBW5NQg2gREV8FE4PYtiakraBkdaOLITNwqNC7EYMCFYcldcxxP/hh13Te8QBAV3QaJCQWZB0yJQia/HVQCNKYrwcWnapv+Rlvgbp3W5eB6DRCArKc40zbMZAL1ZXHTksIJ6kQofYnAvhcGmFDZsMJ/CXhZTTd31199eTsSL35vCSQGKE9oT9SvNSaGI9t5+uhynLSIm+POVwBKK7RDpkIjKQQONHUmxx5nXvXoB0jxDxj4PevVCR5RQHMHsv6HsQ/S7ib094HoSiutbqox9zVmQFjE+mdWOllgKZI+umJlFv3vqSkXNu9FgK9QATAq8wk2gIm+DEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b233fc-07e4-4852-48ed-08dea0256810
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 04:12:45.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ANtPDkNezgdJOjuuAHCXBVOAKiV8c2M3khXu5HkIYOri5dBpcfC+K2GldFfuOp/HdrvAEiUhTwXLwOs/cSOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
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

On Tue, Apr 21, 2026 at 08:11:17AM +0200, Christian König wrote:
> On 4/21/26 03:26, Matthew Brost wrote:
> > Triggering kswap at an order higher than beneficial_order makes little
> > sense, as the driver has already indicated the optimal order at which
> > reclaim is effective. Similarly, issuing direct reclaim or triggering
> > kswap at a lower order than beneficial_order is ineffective, since the
> > driver does not benefit from reclaiming lower-order pages.
> > 
> > As a result, direct reclaim should only be issued with __GFP_NORETRY at
> > exactly beneficial_order, or as a fallback, direct reclaim without
> > __GFP_NORETRY at order 0 when failure is not an option.
> > 
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > CC: dri-devel@lists.freedesktop.org
> > Cc: Daniel Colascione <dancol@dancol.org>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 

Thanks! I'm going to merge this patch to independently to drm-misc-next
unless you object - the Xe side heuristics of the shrinker will take a
bit longer to land on an agreed upon design.

Matt

> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 26a3689e5fd9..8425dbcc6c68 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >  	 * Do not add latency to the allocation path for allocations orders
> >  	 * device tolds us do not bring them additional performance gains.
> >  	 */
> > -	if (beneficial_order && order > beneficial_order)
> > -		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> > +	if (order && beneficial_order && order != beneficial_order)
> > +		gfp_flags &= ~__GFP_RECLAIM;
> >  
> >  	if (!ttm_pool_uses_dma_alloc(pool)) {
> >  		p = alloc_pages_node(pool->nid, gfp_flags, order);
> 
