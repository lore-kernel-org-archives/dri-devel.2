Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1634AF54AD2
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EC210E755;
	Tue, 24 Mar 2026 16:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ia0iv1pW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C2810E755;
 Tue, 24 Mar 2026 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774368375; x=1805904375;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N9fp3Ta7AWNrrsUx1LyoQk50HxkSzHTgEjPpJJ61kXg=;
 b=ia0iv1pWViQp92D5c4b1CU+6gbiwScl5nOM4pyREo1p1p0WuS47vnAuZ
 5vennwdnynf5esL0S882eA7iZgKRAOJ3It7HoE4qO4tyJsOONB56QqC6F
 OmoSxfOdw3ZMURWaobtvSYwfpnd0lI/e1xPPGs8TJLaEBwNSKh64V433B
 jiJG0Mv8J7XEC/LKkdokgYXZD0o4iprToHY7ABvAsbQHwXAuBh48gq0E9
 VjVLqmRM0TQNKfWRLVogDvK1iWffUkmhTN1MyYHAIUytFtr0a+WZB2Lz0
 8QYq2f5zXrbtvWfaC/Qf8jPKAHH7e2CmVkIp2nqLGRAnUYtBQAhCoGj3Z g==;
X-CSE-ConnectionGUID: LGOV1s+MRIusnUli7Ly2hA==
X-CSE-MsgGUID: P076+n2RRdqvWJOvqjCDvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86765739"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="86765739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:06:15 -0700
X-CSE-ConnectionGUID: PzOa/B8mRJutbs0QW9P6Fg==
X-CSE-MsgGUID: fLQ9S20vS+u3N/RKnLpKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219960553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:06:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:06:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 09:06:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxebNGawo35gUn6SYJFcATpNfGdUOARJuk27x5wfd73bjKWX8ZQfRc9h3hrPbkvOu6h+VG15z2FNW80IgDZ6V2mtomhAoLAXZy5KdRuRr7cK3tic9poVsxO+/3opCCFWz8fH/bJbBoYEk1/rgqZc3OcFdTPkbaF6W+87SR/LjyE6rbH5DPgFLBPZG2TaA/M4CypbPUiO0FuN42ugpy/OIFcQwUl0GqU4jFiaLrw4AG55mQwIIfOlA15fIFXjBEhIIhnm/WaHD0C7PLxI4Q2X8++wj1jofyAf+fPPIwnLMcEk5FHv8eE1SwwZ48jZs15ay6jYHxq9Zgg208diMR97Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef0GvJt9rI84C+epxPFY5EaBNk8BSg2VexSR0O8XA9Q=;
 b=ensWycpwXoUJFAl7niksk86n9R2t9Htqtfp2Tyt5X6ZLse7y/OaXT7EpD/p/KmFuYDBe6w87YI8HCkv8n/We54vWM0NqqrWRu0QJmFoqKE3iOHAzQfzYUlYU0JoxnzTjKip7hQPMfgYSDxj7eoRGC9JlSr8MboazCMzEnOO8ZjG4vZwNYTzi8uH61CKCsHusEFaAgLsQvd1INedHhFqC1u8s9Ekq6T8MZ3oO/Z5+Tc2oMCiYVJgZkBgrjACJ/ywgAPeOdS93osUUL4Ftvt6tDBG/sNBanR3BjnYPhMtCxMPNMUAQ4xGQkkKrbsWUzNLlckFzMtnIkhJSql4RqX9GMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ2PR11MB7503.namprd11.prod.outlook.com (2603:10b6:a03:4cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 16:06:08 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:06:07 +0000
Date: Tue, 24 Mar 2026 09:06:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acK2apOn5DMJFb1+@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
 <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
 <acGIjjLXuxUzv3aI@lstrano-desk.jf.intel.com>
 <20260324102345.17742bef@fedora>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324102345.17742bef@fedora>
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ2PR11MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f10242-ba9a-46ab-d5aa-08de89bf4238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vDOjS0/cCJmjURldCkaUFvEJoTWL9nMIIDFmoa3FoBajOn9nh27VRS65K5K2DediSRik6VGVXXdzcZwvoN/cW3Fc4PhbfvIqXjyyLMUYa/vRqOjZAFunxaSoU8EzXLgpo+9yj+WyjXnC1LqQ36zxdnl0m1EeHc0qE12QRtn9p9P07ioeCaa2KOiva806GRGW6UuuAy54Ej72I1/ChONePHCa7ed0jrhDuW+pF80csmj0x2lT2Zcvxr+MdpaWXXTxqirMrd+zg/UfrWCW5WTb9VOjI+Xw9/GtzTNSPWKuMJ2HrofVTmDgyauSWnLcbq7cRQPHrsXnwBwuiCTJRLEsfRbMPYeyRPT/6N4AG+9TKgPMteF9lav7Ybi1e104WFxWCcv+ae4nq3NRecyYV43ROE998y4OJ3WsO3RWVnYbuzzWwhC4nLb+EpsBBAMkmX+Jvk5AUX7zFrttJSL7V6fQVjqWveg27Hy6j6jGwT59ZXu1qvBwKgE8jSdEhU/OtYmZilsQEXb8PbJe4/edZbAl55j+0j75JR57K4qWZ/aVj9uwg3EjK2oHPuBrMmdZM3YvF0x42e4mr6H36ifw46/3JU1XBaJlMeFgaWHz/StSf76OWsb1ZnAmtZyBn/rouQd+EJOopwhczVgkJ9yZE52F5h0Jb71Kx2oi7QCg6ULxQ4P8I7wudYzYtI7BEP4VbVHt7UIFZIYGLKFCb060V2D9wKhfjN6pDAp2I8ZmYRxE2zY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaJef9cc/fsScaMFqTaQ5lSSwxssTJHiHtl9/K5mDvGcdajHDz5Oa8Jcpdfw?=
 =?us-ascii?Q?+JxHaJd/OCUXk+v3qmxlCJ5p2EThm1yJE8hZxaxn+ifjOaEwkKM3tzcoRSci?=
 =?us-ascii?Q?85nK/hUota481dG08+rfOOVjxuIhMUzWs4cQNIki8G1mfacRDWTPxicT0/t/?=
 =?us-ascii?Q?s92plNapB8cjTu2IMbB2Ulmm0Fu/2VTaF9qkVe8OydYEpLgWNx6rI9pibNYi?=
 =?us-ascii?Q?QEKklznesUIwxbb0jDpQIIbLxyHGLqSv0vhwIgphKLtvppa21/nM4/5E20qL?=
 =?us-ascii?Q?3jLwu9sjWcnWTZMcXBuawnX1f/a6Kfejveriyxre5NXrAgNpAG1NHXicIr1x?=
 =?us-ascii?Q?Uu2iNh34IvdDrRrLnPJa6fpBH5XbnK89bhp0aaXdY+ZZBCSLkcaTzXzstdJj?=
 =?us-ascii?Q?ptGOCCRheDKS3nWxrWAUBPrR1krOnt96VwUKKz/ZqtUJYuacJT+x3oUQpxDj?=
 =?us-ascii?Q?DUnfSCgHqggO/4nKfUz9g7D6iiIAXc+CbR7L/JK57MrWArB03yDUGR+oXkeS?=
 =?us-ascii?Q?MbklzFV/mrcUAMcVDGslaLonDFkfMoS5MAZ358C5eGrQ00s9Ud3m/G8vRTGU?=
 =?us-ascii?Q?wD20EVNBblNbEFfejpoYBlJLADBxuJeVK5AlyiRvknrmn68vLZUOFQrMWHwX?=
 =?us-ascii?Q?NizRy8CgTLE1wC9UuIaanop9XyuctsTKP5kZnnv306lXqWMXMTUGkeQ2YJfX?=
 =?us-ascii?Q?Q+gmrYxmIHojmO8OXcH94GuwoImsk9Zs/SXELTuxd+TcKLSot/56+vZQjqLR?=
 =?us-ascii?Q?c71YufXVK0v00LiAStf1HmmrinaGHHVw69rglarAnIrCWbFO4e4eenFU9Hfx?=
 =?us-ascii?Q?7Q7kYtasgLG9QHIjTU3iEmEgOiOeUyGIp4QvNzhMcPP+IqiKIgZbqfxn4Nsg?=
 =?us-ascii?Q?OqJXH5q4WK9NnY6xWDfnvPETbZj0N4mrk/9kJJ2GLBQCHanYlilXixwLNKTd?=
 =?us-ascii?Q?UpFwoy1HsdNCe/tVge6mA4zeQcsF6KwLB9a5IhcZIQpHof+6gSg7h8734Bq9?=
 =?us-ascii?Q?HcZRa6ThP9L4JBziImDradZC7kq+tP7xK0QY2tUNF1HIKqCoGAfRltPUi3Tx?=
 =?us-ascii?Q?BD03c7nKDV4y+wwV6DVxixhPAwAiR3T/nV1dSxRKX8vWc1qSfc5kEQLBUxON?=
 =?us-ascii?Q?uFKd3uvibNcg29Cf55rj7jTq/PCGPY5ev2M1mtNZJoeGWI/7MkS/CEaAI/XX?=
 =?us-ascii?Q?ewCpmWT5Nbaq6muhXBOwyGWNDWkX84gs1ABatSbgN9RXLIdTytmSOT8hSote?=
 =?us-ascii?Q?oDoz+yjvY+yRXH50FASdQdpYIY0/FGB0CzPhLBsOgNVcK6V3+EK7pAizd0lt?=
 =?us-ascii?Q?MjVKXXHkY1vq9Q4szo7Le7TiNM/v4ib5fM8GghwsQK3GIdoeM0ixGQ9k+sks?=
 =?us-ascii?Q?3gR7ZFndvu/eGKBpcveY+delZSEOMl65gbQ5m9fRpLL9mwVFoJYZZdbqhbG4?=
 =?us-ascii?Q?KYA34TB2DDZM3JU/xr3MpDkQSBFBSEXpMJSlmN/IKqAdFskAdPX0B/R7hjC4?=
 =?us-ascii?Q?/RiVfBkWmf0DooT/Y/4IK81tgKSY6cUKUqbqPoztcNBOJ1JHQ6g1qYKBjnIB?=
 =?us-ascii?Q?hmQxYyRxWu+fWpBxLLwdDejIs/TmFGHli6/Hm0kK5aSRjS8b8LEn1ctllUoW?=
 =?us-ascii?Q?e84xzttEku9ij5yy9miBxEpsxEvdsHVCrygzsrPDhuSxWW4o+6bIx5wxNWgh?=
 =?us-ascii?Q?taLTgZ9ca2mKRC8Fd6f/0UsEDYSzSSVmmlUk5ACSlDo8g6iuypF2iqDPBAzF?=
 =?us-ascii?Q?NFtR/0aVkB7utxSr6XBGY0bzVdpkdP0=3D?=
X-Exchange-RoutingPolicyChecked: Oj1FifviYIgxDYx7LztRRuvoQ6f8CyCJHX4WEP/IQE6ojenN1/mBF1NOXUwIxWCkRzk5pIZzzdWsxHZB29wJYID37Vg06O5ffal0LUJ4ZHVMBWihnVrpFC9w87doex1yIOUM5hsEi8quHdE+0UwY1SweUlUN8NqHxU7d+0hH7tTOBS11QfGfjKQ/8o/P/0zcCuNMG0s6D5d356b+jnt2p8GGJ8fn8OfEXT+SEKUVi7y0pVkYntCv3CEqVK/x6XgkdiHNB+d4w4JQ7bPi8/WaxCyArR6z/cVEk8+r3nTH3G8Z7Iri8AQ7LEMNQKwlwfJyJu/x0KVK2IgU5ZzwLSPNtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f10242-ba9a-46ab-d5aa-08de89bf4238
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:06:07.8562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIbclVxdpp1y+Fj0xuqnYEzX2OOyZa8ZNEK6jyFbPtWDacdwajp+v1IYuC47cK80Z3T0+VDRCUPhV3Zwo1KxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7503
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

On Tue, Mar 24, 2026 at 10:23:45AM +0100, Boris Brezillon wrote:
> On Mon, 23 Mar 2026 11:38:06 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > 
> > Ok, getting stats is easier than I thought...
> > 
> > ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions /home/mbrost/xe/source/drivers.gpu.i915.igt-gpu-tools/build/tests/xe_exec_threads --r threads-basic
> > 
> > This test creates one thread per engine instance (7 instances this BMG
> > device) and submits 1k exec IOCTLs per thread, each performing a DW
> > write. Each exec IOCTL typically does not have unsignaled input dependencies.
> > 
> > With IRQ putting of jobs off + no bypass (drm_dep_queue_flags = 0):
> > 
> >              8,449      context-switches
> >                412      cpu-migrations
> >           2,531.43 msec task-clock
> >      1,847,846,588      cpu_atom/cycles/
> >      1,847,856,947      cpu_core/cycles/
> >    <not supported>      cpu_atom/instructions/
> >        460,744,020      cpu_core/instructions/
> > 
> > With IRQ putting of jobs off + bypass (drm_dep_queue_flags =
> > DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED):
> > 
> >              8,655      context-switches
> >                229      cpu-migrations
> >           2,571.33 msec task-clock
> >        855,900,607      cpu_atom/cycles/
> >        855,900,272      cpu_core/cycles/
> >    <not supported>      cpu_atom/instructions/
> >        403,651,469      cpu_core/instructions/
> > 
> > With IRQ putting of jobs on + bypass (drm_dep_queue_flags =
> > DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED |
> > DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE):
> > 
> >              5,361      context-switches
> >                169      cpu-migrations
> >           2,577.44 msec task-clock
> >        685,769,153      cpu_atom/cycles/
> >        685,768,407      cpu_core/cycles/
> >    <not supported>      cpu_atom/instructions/
> >        321,336,297      cpu_core/instructions/
> 
> Thanks for sharing those numbers. For completeness, can you also add the
> "With IRQ putting of jobs on + no bypass" case?
> 

Yes, I also will share a DRM sched baseline too + I figured out power
can be measured too - initial results confirm what I expected too - less
power.

I'm putting together a doc based on running glxgears and another
benchmark on top Ubuntu 24.10 + Wayland which has explicit sync
(linux-drm-syncobj, behaves like surfface flinger when rendering flag to
not pass in fences to draw jobs).

Almost have all the data. Will share here once I have it.

> I'm a bit surprised by the difference in number of context switches
> given I'd expect the local-CPU to be picked in priority, and so queuing
> work items on the same wq from another work item to be almost free in
> term on scheduling. But I guess there's some load-balancing happening
> when you execute jobs at such a high rate.
> 
> Also, I don't know if that's just noise or if it's reproducible, but
> task-clock seems to be ~40usec lower with the deferred cleanup and
> no-bypass (higher throughput because you're not blocking the dequeuing
> of the next job on the cleanup of the previous one, I suspect).

I think that is just noise of what the test is doing in user space -
that bounces around a bit.

Matt

> 
