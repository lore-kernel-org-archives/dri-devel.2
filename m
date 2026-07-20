Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3960EC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9189C10E031;
	Mon, 20 Jul 2026 18:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f6bhFSny";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAD310E031;
 Mon, 20 Jul 2026 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784572952; x=1816108952;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IKf8sMI8RhYxJXwxJAUETkwzFhR+B0Ksl4MuJesgPJA=;
 b=f6bhFSnyXIB5JJc0T6SbDYTkW33jQ6HyFUx8qiAKT1kiKfnl/ljSeVTV
 ZSyQsousul/8iZkKdQuvx7O3r8ct5IGT7C6XOZw5KUfOkxFPbqqC6tqNt
 pi4dS8iUnnFgEtDSJvyaNSYd97nJqZKAdXaZuXy4VMguP/iHUesC4RICx
 5T8tGLkaAELZqJJ6ZBOa2EMU5lzCVTzRblGj981AL+y6ysxwMjxwFcQEC
 uoWGET+idN0CfZ21s+DwRZvEGM7aj0xbATNSK/xMLlrCKJSr7Zy/la7Dv
 4HshJUT91epA0CZ9u0V15sodilQ7wc69bSo9gLGId+/jCu4wWYMpdDgdI g==;
X-CSE-ConnectionGUID: bugxIt9yReWvif/RA+FnuQ==
X-CSE-MsgGUID: B+KTo9JNSiiHrBNfqF+iSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85021337"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="85021337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 11:42:31 -0700
X-CSE-ConnectionGUID: +WE7EQTDQ9+Nzp//m7CD4w==
X-CSE-MsgGUID: G2VqlrDPTfeUhf0xzkVQ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="261099822"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 11:42:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:42:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 11:42:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsD9n4RN95Wh471r+Nm2BfLwsosjwr8tQB9YauVd3oS/6K6jyq4Oc8mWtW7JYiiRLR3XnRlT/BRwOUeXHCwd838+PNq0OWe6poc191KUn7xPukQQ2e1G+NJCcPWIRTNF3a7FSzQ3UVwxw97C5qF8z6RiadFi7DUju/WsU6c6z9N0qtUf4hUPQBw0xSxUBDMWk04nmFYP0hFJuA7ME8mKNwrlY3jVj7/3JYv7mMQysA3kfBTmq8ZQ3FluVhHQ1LSAQnub9Vc59BO/Yr5jdqBWNjI6BAl3tDyHWrRRICjADeFpMTHMdRxtafQSf5wYMi9TAMkdojQHP0tfX8ISzJfwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ8EYgSgXprG6F8trgKZ1Het7LGL+/H/5FRL2EcSq5A=;
 b=TiodYEetajvb8JunAIZh+t8ihyr3SOChsM/5PSYEwEL6R9SDKaoM5fE9LuFsC+Fpo/H7ObyCgs+cywxKZRy/WEUgEgvBJiUOhZvGfDmHfGdcxscXy9DB51SQtFyovmWyd09PVvEnhn73RZTyAKWNoOFItXIbg1zocc2lLutObZYUD5PE6f0u7pGGq3u2LH5BaTCDhycCJW54X6TAqtz80PIxMkLuXnlSmnK/G7JfPA49ZvrXRmZLg6ma4A/PYaYTcrXLUdzM594fxToMEtCXP40UE42qAoWarHfvLQBXe7d7B+U9gcQbqeOKDDYgWDogrv95S3YVQVZg3JBWfjw2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:42:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:42:22 +0000
Date: Mon, 20 Jul 2026 11:42:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/gpusvm: Fix mm reference leak in range eviction
Message-ID: <al5sC3iUUDq9X/Ku@gsse-cloud1.jf.intel.com>
References: <178406551216.1092539.5238081578161393168.stgit@skinsburskii>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178406551216.1092539.5238081578161393168.stgit@skinsburskii>
X-ClientProxiedBy: MW4PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:303:6a::22) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ1PR11MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0f104c-5fef-4c1c-2059-08dee68ea2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ctxJg0nIb+UGudW8wobcAXplJncnvLk8C5Vo+2QUFf/VSk4AkVkUwk+adyukYax+Fr5ANxx7loKeO8m2/oPoxqYXdSBMQ92vWkMe03HtTzccF6Rkh95flM2cBp52PEsKFLnH9LkD2IdjhrUGpqhyf6HDieLc7OXMCbfdcau5lnUVNxA7Ig43JYvfaXtruqIfl7DyVTzpWFJLkjVmLk/+NixpUBgGB08v0NSgF9brdhtvjr+cd1Z8cUc1xhcE0aldeHS5TjWL9J+aKJZIPtPye1K7yDS328vOOjCWlH6oIAw6xdFvPWri1DWHuKbkav22VNqdTRcoz0ogKOT266ohsFi/7fc4STQ82Y48tDslB2RAM+MgFfm6nwctSkdSVpcFionNIBOY9fT/YXI6kxOIEJskbb7Te+dv5ZPw7VoGkzd2AxRrJevOI1obZTvIr7+HcKnjk+lWo34gyUtf4xr+4NeUKSH3Q/mKbnksv8NpdD7oP2CYg1GJEvcwPd7/lBBZMto7HotpA3rmx6XRDX6IgPvpn70Lx84Jl3bKrFUmoNFIjU//Xsx5ZamUCLt1W81YBNU6g1mSwfDr3kOKgTzSwSKlicUwEyu9vzxhuTYMzF4Ggn8S/rfwXEfLrw/DZ+ar
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbNRAVb/PJW8kGnCco+x9Kp4mxU3SyXO9BcnvSUL7QNlTMrkZdSxhwE7uoqH?=
 =?us-ascii?Q?FelTVbQpfAymxKsSbjR3WdB5g38ZTvXZy2fNozEbffRRXdG/I4+mmfvBInpd?=
 =?us-ascii?Q?3NVdx1A6EZ6qcL7DPpOk8Q2PYO2nsMVQU5s1sPCShfW+/H/0tACYTwylrqMF?=
 =?us-ascii?Q?/PfMaKGRNnavAZ82l40NIsE7InBVxIdbVtrAFfBFzIUIbx8Ik1VJVSfyl+Ec?=
 =?us-ascii?Q?cboRrh37snol/xEuEYbnXbkUFYPx22XAtxxZBdQVUvTHkvodHKutSdAnf70Z?=
 =?us-ascii?Q?ELHZyDZDPtUkQvXGcDii7PTw05diMtnETTfXNp4OHx5GS2JY8BsW9UI36jF4?=
 =?us-ascii?Q?CZEP6kwUheln/aNr25BJlxZpM+t4T2DeSxH5hjwtML5eiVfYJog2LwSzzamk?=
 =?us-ascii?Q?PDndhJFxurCNPSKtz9mGyre/SUwHPVZ0zYhDPBKYGH14yZGEfKj8hgljRhas?=
 =?us-ascii?Q?usPsEWKBehs0F7YOhkzYbbXlclAdBLjQZDYNmwj5xKfffM/ewUw7bcMS4orz?=
 =?us-ascii?Q?HnFnYIkC+5R5eYw67hYsmslLsJxp3RnLu6EjhPt/SOOUcPkRh+zjRMAlt8So?=
 =?us-ascii?Q?Zcgpt6mpfwIihVvby9tKcrnaOHTkszHqvxtoDr0eJQQghw1KifnqKLeR6ZUE?=
 =?us-ascii?Q?OuVle4w2btFt/pU3Em5zfyx2uWq+1q0/1utHhTSFIxIXsq7uuP10AQPMLEdb?=
 =?us-ascii?Q?horv8QrzDVUAOBqOcpy96zsSNddn6r6oeCr7ye9TaDVfzESC/iWeo/esIBn1?=
 =?us-ascii?Q?qZ7coUZFG6LQW/w4GMuyEdPNIf4/D91py4ktUIWzomDT5aVkhB8oAOIlByxf?=
 =?us-ascii?Q?TSLQ51nrHF58qcxazt9jPnH/cKz5jLbIZks4Fpxlt0HcuKX17jF4I1h8xrmr?=
 =?us-ascii?Q?jRZBxk+Ms5NV3NYJmPuAfz1Mt5iFUpEVUgtvHLNpxBECoMKEghUZ+6DBo+k4?=
 =?us-ascii?Q?ST9i0ioFdmg+J09OVawGvJAh4oQJv7NFV/OZQNgRg6CnQHIsi43yEG1j2nji?=
 =?us-ascii?Q?AbvMs6Q4EX+hv4WdaUBZsQDA5jqA0xzSFdh4/VqouP/4Y37auhHWM7EoLfJW?=
 =?us-ascii?Q?qu/RfX20Y5DgPWpkKoySuUBraviyy9eoRzIqAGxMq8ZpYBOH+9r5xdR7w/qM?=
 =?us-ascii?Q?f4cc/lKpCZyAf1oT6/eRBDGoquf67cHzKb+g2wlkGPEfkOLpJtwdn/2qHGL6?=
 =?us-ascii?Q?vzf5btjvQTTcpd3rukjQzEHfiVaRIEaA6ZKuEMW50xJHuX7wWg3Kofrgg7/N?=
 =?us-ascii?Q?Y6JU8Ijcnj3925YrJDh/vqzqxdYQzlzR8TfAb3iqEEpvIIZ8ArnFK/Ul2BZB?=
 =?us-ascii?Q?wSljNQzAkK5XDLA2jZa/51iHIuJuzO1JH4Z6e88lJKmdEPcjRYx9bgLjCunj?=
 =?us-ascii?Q?MHKtOZ+Gufg9b8YrMNWzByhQ/qO7CXY6zqbPVS6xopUp3QELCepbnjD3ZacD?=
 =?us-ascii?Q?9ULfYwMzeKVj/xBIW6YLnOtQXCtOzYaaZxo4+M/PtBcY8n8RxCPj+Rp5t6Vn?=
 =?us-ascii?Q?CQs2clpTRmZjhfocwSDwHTXzwgQFHyb8TYUZ2ANmSagJAiQW8OyqyD2EUvX9?=
 =?us-ascii?Q?geYq2cDpi8U0Zo8QKLslSepkUQHfxN57GFk4QrwxU6dh14k70StVNEISaCjD?=
 =?us-ascii?Q?jnqfr+kPrWpn3JFOiKrfZoH/RslceMlnAULd4//uClkNGBUmCtL8zD7vJVF+?=
 =?us-ascii?Q?070nYykKBIWNe3u34JYtRAfIkwMTdSw2tHuUlyQVTeKT7uxlfMoklxGSbkyv?=
 =?us-ascii?Q?Ma8M44X48YmPvt0/MgA9sQQts0ye+CM=3D?=
X-Exchange-RoutingPolicyChecked: O9t0eTu/+op2Wbf5yn3I5WcI1DXPf+pIJqPPIPlC7dBlgCsvF9KYJOc1efppxE89UtP2rdrnU6HVEbFhwcnW0WXj+rGhQsEfIhomoVNLvVTN0Ar2zEktmQHtMhcvYYtGj/KsjVgL4nGfw6m36JGZzXcD8qGvarEwmNX1gIN0949+so5TtPSt2kAFuTqdD0PhHLYtJ3WIfLt1U3ncjJVVhAN8tcXbg4lePLmDHTjg8GjH+Wu2Ljgnaby+uIL2fcDV7xu+jgVYWBOMFIP8IgOKqUwgHOERqVN/oBXUno/trWl44nVPjHHhjDsg/sH9raWlbldh1q93psWXe1+iKOIF9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0f104c-5fef-4c1c-2059-08dee68ea2c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:42:22.5587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNCvG4isElIWKoj3mEsvebLt1ZJFy1n943MWlKPqmhwdsklLZFQLob/ALVVo2emjXmuauRc2tsF+QWl0yl1ZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
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

On Tue, Jul 14, 2026 at 02:45:14PM -0700, Stanislav Kinsburskii wrote:
> drm_gpusvm_range_evict() pins gpusvm->mm with mmget_not_zero() before
> allocating the temporary HMM PFN array. If that allocation fails, the
> function returns -ENOMEM directly and leaks the mm reference.
> 
> Route the allocation failure through the common mmput() path after
> initializing err to -ENOMEM. This preserves the returned error while
> balancing the mm reference acquired by mmget_not_zero().
> 
> Fixes: 99624bdff8670 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>

Yes, this is a bug... I also have pending patch to fix this here:

https://patchwork.freedesktop.org/patch/740193/?series=170433&rev=1

I think I prefer mine.

Matt

> ---
>  drivers/gpu/drm/drm_gpusvm.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 76e8a0028c7f..1a8bb83bd28d 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1715,7 +1715,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
>  	unsigned long *pfns;
>  	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
>  					       drm_gpusvm_range_end(range));
> -	int err = 0;
> +	int err = -ENOMEM;
>  	struct mm_struct *mm = gpusvm->mm;
>  
>  	if (!mmget_not_zero(mm))
> @@ -1723,12 +1723,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (!pfns)
> -		return -ENOMEM;
> +		goto put_mm;
>  
>  	hmm_range.hmm_pfns = pfns;
>  	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
>  
>  	kvfree(pfns);
> +put_mm:
>  	mmput(mm);
>  
>  	return err == -EBUSY ? -ETIME : err;
> 
> 
