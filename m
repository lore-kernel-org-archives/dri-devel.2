Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D883606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Itf0w8UQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7041B10E071;
	Mon,  9 Nov 2026 22:34:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B8410E071
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794263656; x=1825799656;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SqidAtjaWxG9LV27uD7dcIUHFkTGXnyzlLCdHsEDOK4=;
 b=Itf0w8UQVwDdmUxBIov0T4FqChRjiyCeA7EmW7ZTkDMy2Htevhgon43k
 hZYgkfEfUlDZCdafDLMQHqhwMSQXRhX8UxJOcVHql2FZXUEN6n+VejA0I
 jsg1J8QkGYhaNYXiBk3TYqW4ZHhqSfLT7gryM1FWYD4w8JE/LHjLI2blm
 ppujKCY/YAApUyFiDiUvXfuoFlsuj7g5AYL0A/JCKsF2yqlt8BFyt+BtB
 WJL1BLuwxVZ5sZfiUHB1qSD2Ad0cA5SREfyhwqeCggZRsgzEpUIMAbOT0
 vupZddB6zBnv+Xk8ZTSoxmD8X56zctQHs1zOnB+XdfgNLNF8vinfRSlcg g==;
X-CSE-ConnectionGUID: XARTFSdyQbiEBZFeAI36Cw==
X-CSE-MsgGUID: zTXPTbqET/qW8glWrocweQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2916196"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2916196"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 14:34:15 -0800
X-CSE-ConnectionGUID: w3MKUt60RGiBwT7UnqVl3A==
X-CSE-MsgGUID: NVOBXRuYSUiMUr9tdoszbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8294993"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 14:34:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:34:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 14:34:14 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX8MWPFbuMHvGjgp0MuknXE7w14JrBeqFTQVq5er08cieggUjr9Env6igOlLUQ33qdsRFWz+sC9HeXC6mbeHLN6Bk+5p5Cg1c/4NxUd1706m1ImYsB3zQNiDrlCUaoRjBRzc/Hu8Gw//xn8vEyPfR6BOwWn0ff6vlp7gyOj5gxvGAKBLrzDxbVCpq351qpAp4nJqoNi9CX0sMk5HhT3c6o2RYtlSkzup5yPfmoafUNZ6uZgaonYUFFFGzf1TCYvPEBWxFCqv1jyU/FFubOYhZdbu6X0boiS+Uq2ihFuxzQIaKzMJDL6A1iHIPhJQFo+Cu+ccolRtbiXE23Bu1xBaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZv1v3CLSQEW/CI9+mqq+SpQtM/sqWPDDyh4oaKjSRE=;
 b=hPRdi75wRO1JGNLw/avWu2sAg92tOKFHdWaYBFYSAyRAprrAPM9LJWhH+NaPNBCcM8/ICxjQescZGMH41PoD7ZalJJuXsLMFffxZygYpzdYKaLFxSe8EnRt8fPoUx+fP3WyuafeFxp1MNp9ZOa7VLAZCBehnLXfhkC0j/5aR359b6aRMWzKmFWdb4u2evjwNHFDq/berz0cvs/5o34j6xqo08bha4bnqDu7bgnGv7MfYqtRlsBWId1WrJuQkdbh/S5bVPyfEf5RiHIH7WBj6rFKYvyz4mRVhyeflppbI4O80ow+62k4OvAGcF6czXJOEx7K4RKDz25/Ri9gQUEMKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 22:34:11 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:34:11 +0000
Date: Mon, 9 Nov 2026 14:34:08 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <honghuan@amd.com>, <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
Subject: Re: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and
 retry helpers
Message-ID: <avJKYLGpfjPGGRsb@gsse-cloud1.jf.intel.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106184217.2720718-1-lizhi.hou@amd.com>
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afbc527-282b-45ef-6c76-08df3eb1931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|261102130727099003|11063799006|261021121427099003|261021123027099003|261009223027099003|261022105027099003|56012099006|261009221227099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: vHUU21XgGMWVTfFm95rEKDSasU1K+7Ve2ZGB2nhUlyYHw6pI9ztpNQQtgwG5mXAo+onCFZdPmO5/Q1gQcYHOAJ7nTMf/iNQCcSD4EpxePTWa/v1rEXu6Hi3t8leQxvJytEE+qS1Smm02t1eMxveyW+ozVKOw4FKzrXSys1cbViqDy5Cm0W+DWcRv1PH8a4VeH5BjT7LvB3zOndnkVKHpPEdlcAVNULqE7owBtS0IgfdzsqG5bgdUCAU6sHJ4iCHQf+0WAI1Gp8REu5NcViDAHbSWeT7Xoz6qTiOWsEk78lUX1gJmuVFUyPYUnbAh03iLUqoiO1a9HFyG9E1wwbzMRr6p5/uHWhi4eJr4yaHBMbpoMupAfkA69H2V1+5AhDNFZS9H7IelvPaqDW/0IgqVlHaBN8hZczFGP0JI02QiaFf/8ye3Y4cdPnsn5ejmvmh+pajl9IuUvxzqe1avQCtiigxgbLCVTYyci66ScFsSI+mOz1v8C/hUF0gt9T4NWOuTZM2GQMiw+0/ai67OU47W+s5QjUXjb7PHln8ePcc1jsxvmJpuvcMLFpH9e8ppUSoTRcinVPd4wYABoIw2NDKvMcMErwV6M/PtyCr3FiM2h0DZ7AbTwUeQ8vVMWXj5FTUNRTat5EEN+nvgEgatDLtma3P3udMfqOafm9Y4gXkcxak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(261102130727099003)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(56012099006)(261009221227099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H60XcL/jHUKxW+kTitse5CQB7Ql4AAC37rHl2gtb5i9dojTMrQiRl5xyLlLf?=
 =?us-ascii?Q?3opip7EhpAWvc6H8iExRHeFkwNAkuiTMOH6k6l+0xUXr13YWlRE0fghV+D3f?=
 =?us-ascii?Q?pdcGrY95giGrUWOCq6eugh1TCYE+r1lgpwRHEP9rel0teZD2I1sJbUWdDsB8?=
 =?us-ascii?Q?TkPkFyFc//bqoStxA96Oh0sC8faJQqUmyGJY+lBnYiXwQei6vpg+Nh20/jTH?=
 =?us-ascii?Q?AUBZqxk7cEOoxOgzfPSctNjiWqjXXBZ7dzqAbgIFSz0xPgVMsK3UoqzH26hi?=
 =?us-ascii?Q?E/IovHbKVL360N/OKGw8i8gWv7NJCk7DfSlDugWKvPe4nHizU5Ga8QgXg0rO?=
 =?us-ascii?Q?NwmxGckRMRayKtJgb4L/i+PnmCawXLo9Pkt3qQx88SXtUhpcqIUhPgNN3hks?=
 =?us-ascii?Q?D2EOV8IDLaAdhRpd1jR6Xgj3NQ6BZtiSBuw/0vuSLgrJIQy2i7la/Ef+VkcN?=
 =?us-ascii?Q?PjJ9/CoPHrinz+NXPB4Dj8DaqKMHxvPWdZiCWRJQetDbQQV+32CcfG1phLVl?=
 =?us-ascii?Q?arBrhi+KlpuMCEEtxLXWA5nVHZ60GdL+oTtQA0aCEoIyYTGLEHUNNKRLjQx0?=
 =?us-ascii?Q?SDnuHjyr2vLkG66c4DTxjXKF8943jDLfCVEfQbbU47sCWZjtqmWcVEK9fgIg?=
 =?us-ascii?Q?tIVEuz4pOfT2bf7fgFXY6HaU3VyHZlgmiYYilUr9tyQDnRQPfAnuBmxMLuAI?=
 =?us-ascii?Q?kQ6CRTIbDXZyHiYKk7aAWfHU1hP4eFcYOvDVqJcCKUvdlhbQQm5Nm18U5MFC?=
 =?us-ascii?Q?iRTSmHznBwov6GwOo6Ai3pOM8VD6bS9yiuHou/QHkdg13gOquL11opXROJB8?=
 =?us-ascii?Q?SiTjgmGOChh5rhr1YNXaJNanCqI5LFAZJ44Nt/scbzN8biQwrkib+93h2mjP?=
 =?us-ascii?Q?sjkSMUQ9HJ8Ajk3Qx/uFWrku/t0G917NvKpCxKaBnWsBhgr0V6Ge6hdB+AoA?=
 =?us-ascii?Q?TUr8evyNv+7sC0L7cpPNDcOW8/uZYt3C1ssNBriAiwS90/vIAq4M6manPRdu?=
 =?us-ascii?Q?g9CIJgDETt3JCPTeK0eFQmUUrbPOmFQp1ntS3CzQ1O4SJ2IHwWrLEaDKWusY?=
 =?us-ascii?Q?fiT/AUNdyni7OrDp+kKHVUMex2xOB6MJbuyt+ngrqLUPMIXaGb4s1x9vieI5?=
 =?us-ascii?Q?cMJudjCOoP6MawRFwFO3JOyhEV/23s+rvqVvKZLus60iTQGy8u2fyvJq6S5k?=
 =?us-ascii?Q?/o7u/gLvbk/2jMsBvWxgy3fY8SfvjPuy3IYy3/GAHX288xK7fQcDwWzMqYfq?=
 =?us-ascii?Q?HbaRMK6tRc7SNaayX2VPkGFr2nZTKAgbO0k5sQx8z6qjbcXD9szwcwUDECmk?=
 =?us-ascii?Q?nPYNWOANFokG8q3TmbAv7gdeknrjH1txWpWWZhbfBv7BX31isngii+WsP6BE?=
 =?us-ascii?Q?qkC8zR1E9y1lSrIKViSKNCQPvIz/xAsZ2ftopxdmPb/9bswfxERxwHwhFm7T?=
 =?us-ascii?Q?ZslkCtzw4hxBGac8ZN2Ej54uXsykOdd5FlXxQThT61ZanwWJcWj9kuvR7NA7?=
 =?us-ascii?Q?9/DFhhI4QrIIF6D4m2t7UPB+Lyc+R9TLKIDdLeZCFkMwjRMv32J54rKwYRy8?=
 =?us-ascii?Q?yabebuhWBeWAo699I46pU8R6ykl18KDwZDiAftPGGFF7z+UaYWcaRS1RYCwz?=
 =?us-ascii?Q?eCWmPOSQTwWeDh5pITHRCIzrOCxPgX1p418yATZw6rxYZTR0CHTAcvIl0+Qb?=
 =?us-ascii?Q?uqxLuAlQdYdc6dxa16rXUikH6Dm2wSfmLfDQEQxEtWkdFkdVsGyB5OHqQR5t?=
 =?us-ascii?Q?eHITQPIUDQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tYpyuq0RQb0ylBnaqqxORnn5n2TNks9JBbcMhggJpjSV/NsyqFV2l4bcMHOfH8eDksYe1Qdrh6BkbhNni/yidllfuNTbAXZ0WnYc8Iob7xz/MzTBLiX9Ov1yYjZTYe6gwX4f4fKdsOoOF7L1d/aAC2oQUihMkiI9stOzPzN0J9cbZEy7fs8p2cKghXkb4/zPW9UsWhdKSI4PSfCualM2h76Py0pj+LoslTZ1LkGXsk+iYWOpTU8s85RDqpQTE/CBdy6IEG1qwVDbttM/l5mQ9+IxyqeI2zb1u3wzYtKfKuXn4GvHnOCVmGRzePJd5d6Pzj8hvziMAoSo92EyTBY5NQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afbc527-282b-45ef-6c76-08df3eb1931c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 22:34:10.9529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/pPLdX/PFI4mQUrfqfCodvtE1DWxLJ0QQUvPySe7JTM/Ij8vKT6qN04lP866+MlgmIs7X46ijuT1tHwIig45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
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

On Fri, Nov 06, 2026 at 10:42:16AM -0800, Lizhi Hou wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 
> Drivers which only use the drm_gpusvm_pages API (no drm_gpusvm_range)
> have no way to mark pages unmapped from their MMU notifier, as
> drm_gpusvm_range_set_unmapped() requires a range. They also have to open
> code the mmu_interval_read_retry() check on the recorded notifier_seq
> to commit pages faulted with &drm_gpusvm_ctx.no_dma_map.
> 
> Split the pages part of drm_gpusvm_range_set_unmapped() into
> drm_gpusvm_pages_set_unmapped(), and add drm_gpusvm_pages_read_retry()
> which performs the commit side check with a lockdep assert on the
> notifier lock.
> 
> Assisted-by: LLM
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/drm_gpusvm.c | 49 +++++++++++++++++++++++++-----------
>  include/drm/drm_gpusvm.h     | 29 +++++++++++++++++++++
>  2 files changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 03dbe304e4b8f..63a26919f59db 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1761,9 +1761,8 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>   *
>   * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
>   * drm_gpusvm_pages_valid() never returns true and success is only a snapshot:
> - * the caller must recheck mmu_interval_read_retry() against the recorded
> - * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it until
> - * its work is visible to invalidation.
> + * the caller must recheck drm_gpusvm_pages_read_retry() under the notifier
> + * lock, and hold it until its work is visible to invalidation.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -2021,6 +2020,38 @@ bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
>  
> +/**
> + * drm_gpusvm_pages_set_unmapped() - Mark GPU SVM pages as unmapped
> + * @gpusvm: Pointer to the GPU SVM structure.
> + * @pages: Pointer to the GPU SVM pages structure(s).
> + * @pages_count: Number of GPU SVM pages structure(s) passed in.
> + *
> + * Mark @pages as unmapped, after which drm_gpusvm_get_pages() fails with
> + * -EFAULT for them. Intended to be called from the driver's MMU notifier on
> + * MMU_NOTIFY_UNMAP, and usable without a &drm_gpusvm_range by drivers that
> + * only use the drm_gpusvm_pages API. The caller must hold the notifier lock
> + * in write mode.
> + */
> +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
> +				   struct drm_gpusvm_pages *pages,
> +				   unsigned int pages_count)
> +{
> +	unsigned int i;
> +
> +	lockdep_assert_held_write(&gpusvm->notifier_lock);
> +
> +	for (i = 0; i < pages_count; ++i) {
> +		struct drm_gpusvm_pages_flags flags = {
> +			.__flags = pages[i].flags.__flags,
> +		};
> +
> +		flags.unmapped = true;
> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> +		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_set_unmapped);
> +
>  /**
>   * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
>   * @range: Pointer to the GPU SVM range structure.
> @@ -2039,20 +2070,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  	struct drm_gpusvm_range_flags range_flags = {
>  		.__flags = range->flags.__flags,
>  	};
> -	unsigned int i;
>  
> -	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
> +	drm_gpusvm_pages_set_unmapped(range->gpusvm, pages, pages_count);
>  
>  	range_flags.unmapped = true;
> -	for (i = 0; i < pages_count; ++i) {
> -		struct drm_gpusvm_pages_flags flags = {
> -			.__flags = pages[i].flags.__flags,
> -		};
> -
> -		flags.unmapped = true;
> -		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> -		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> -	}
>  	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>  	    drm_gpusvm_range_end(range) > mmu_range->end)
>  		range_flags.partial_unmap = true;
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 4d31c6bba7455..b43432af56377 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -349,6 +349,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  				   unsigned int pages_count,
>  				   const struct mmu_notifier_range *mmu_range);
>  
> +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
> +				   struct drm_gpusvm_pages *pages,
> +				   unsigned int pages_count);
> +
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
>  			 unsigned int num_pages,
> @@ -383,6 +387,31 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>  	svm_pages->notifier_seq = LONG_MAX;
>  }
>  
> +/**
> + * drm_gpusvm_pages_read_retry() - Check whether GPU SVM pages went stale
> + * @gpusvm: Pointer to the GPU SVM structure.
> + * @svm_pages: Pointer to the drm_gpusvm_pages.
> + * @notifier: The notifier passed to drm_gpusvm_get_pages() for @svm_pages.
> + *
> + * Check whether @notifier was invalidated since the last successful
> + * drm_gpusvm_get_pages() for @svm_pages. This is the commit side check for
> + * pages faulted with &drm_gpusvm_ctx.no_dma_map, where no mapping state is
> + * tracked. Pages that were never faulted always report as stale. The caller
> + * must hold the notifier lock and keep holding it until its use of the pages
> + * is visible to the invalidation path.
> + *
> + * Return: True if the pages must be faulted again, false otherwise.
> + */
> +static inline bool
> +drm_gpusvm_pages_read_retry(struct drm_gpusvm *gpusvm,
> +			    struct drm_gpusvm_pages *svm_pages,
> +			    struct mmu_interval_notifier *notifier)
> +{
> +	lockdep_assert_held(&gpusvm->notifier_lock);
> +
> +	return mmu_interval_read_retry(notifier, svm_pages->notifier_seq);
> +}
> +
>  /**
>   * drm_gpusvm_pages_first_dma() - Resolve the device address array
>   * @svm_pages: Pointer to the drm_gpusvm_pages.
> 
> base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
> -- 
> 2.34.1
> 
