Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184FBCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFBA10E467;
	Thu,  1 Oct 2026 20:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GSDzvt8y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458BB10E463;
 Thu,  1 Oct 2026 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790887465; x=1822423465;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cP8XzuT1oEAH6pqBDTOCHr3XpFs1ilmDro5fzHtDes8=;
 b=GSDzvt8yXLHfzmSjGxnzWm8EJS5GBiENjpihnUAaVwD1g5UfZYWG1q7M
 rbQ127HVlUcfyOSi7+OPUHdbSw1kWQ0OUFogWWZAY1pPgJsjFwvemxXdU
 AqpPG6cxvtaP+F6CyYWKQNpRU9K1WNw+wzh/7mKsCXkHXQOxZGNUmPfFB
 +kEPJ2YDuD3NYfhLp4nsxmDrK9Akq5ruqWo/U4fewTXkiB8w5y5B63sPr
 +MtRsyZNNxWTggR+hOA+9Epv/hxu4yNTEvmwkbC6nlk9gLwEYJgCQaVx8
 9xs+1L7saCU8KYjM7T54NYvSVM6f53baCI9qOKwmYPU7rZPTA7bf2PBNm w==;
X-CSE-ConnectionGUID: 6h6FpdJAR26EQVYwemD4Yw==
X-CSE-MsgGUID: sjmn8tozSzmAUNdKQtg7yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94369891"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="94369891"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 13:44:25 -0700
X-CSE-ConnectionGUID: B0aLDyNbSlm/oy5/IOH9Ag==
X-CSE-MsgGUID: K4mRTUPrTl6E24aCOw8GMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="275638889"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 13:44:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:44:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:44:24 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tsu+OiqLSPxGQX5SRHrq8YiuvPb0uvfJFn0FKajAI+UVaJLkwybMY9YvPxcW5u3G3GwKWPNsvYk2fTQfOJJObXsy8Azs4A/S0lg9HZFZdRGzpJq07RCug35V2GaBxUWAtluZFuUIrrQw6lT/ESUd2OQqZczmVhEh6A99aBc/N5Yks7xKUXvAPTgd+zEHAHnckgS73fqTjVkAXsDTeJD67nBaBP21VcQ2iNZ4kz3/MnGlA5nmF/N0L/zbVYm4Ebl2/beLmoTL36GIp6IuHz09gEEmVszsLVo6xvDzlj4w1SLm348HOyPgIdQndu8VsFib9H3fg9Zn55wDunlWQfopww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXN+T15egAJ4EdFv1MsHOqCd9ZFgU69kkQAb0Vx09l4=;
 b=OXWljtFT6AGCKSffOwA4FMz1edFfzuZCbw2dWKkoH87W58oGYRv0MII8ThTGdAfdStu++6RetUMGEhE357seJZVBp79OcIKT/1NUVbBr+LCCSdKkr30AmFaQMlwL0qLH8C2o6hvejK7ZmWoY1KY7lJ71tWfhdwXEsDd+0i4Bif6d0pYwS57kiXyE5YlzR6irGvDCrV29dfKFfRKw4lp+gilCVAddUjhQrLgcZ5dx1qn58LEh/QyxfYXN1oLFvNuusA4CnOvMEu95+qUragqbm4+wf1atxaNtrZGELQ5o7T2kY7tMhVCjsxexaiz4JS4GfTtezgo1l6eg3WoYBi/agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 20:44:21 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 20:44:21 +0000
Date: Thu, 1 Oct 2026 16:44:04 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Aryan Sinha <sinha.aryan03@gmail.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: use resource_size() in xe_pagemap_create()
Message-ID: <ar7GFPJa3suzkPGl@intel.com>
References: <20261001163328.51556-1-sinha.aryan03@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001163328.51556-1-sinha.aryan03@gmail.com>
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 62932d2c-68b9-40c1-f740-08df1ffcc53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: blF5VMoLXABzQO+r8upRNfXdJSns/vrrPWfCriSSYzcfG/Kp/iGbq0E3azadhO1luq7F3OfaFSY4jM6Sp2VIGWoec1NN8ZAkW865HiHPrvNldLUDWwFc9C3aO31LIDE4FBwLqFkiPmrq5ayjqT663aFipfM4NVMOiMV8ZWu2Ytw0koS2sMK2cqABasPtGsB/NwhejJvVJk+wXzf4hV0NZB+rBLfbX9876cgHAqVzoB3B9uGwEvwkfzM+vvLNuY6fRv5nIwGnn4oSK7DW8ONx7AA/0JPapDdPRuCej1mf9jTx+OTOYgveGcu/iwcOGGxC36081MCH9JJAPs1DMJ6TCdU0Ep1LtnFDLHWMTJEooZOMMglOqck2FcFzvUoS7vEoifel9IDl0GI0WpDxWHSD5B+SMYDj3bJ40Pj0Px/x5NwQxv3DhuQdwcI9FMhQ7DOOkqpSWpSEb8r+OO9gXy6elWv/pnVTda6oKSSkV/LIFS1+Y2rxRVh2WuAoNsyVpwIRpwinr1nYDL71zouo+fMcnWu+QTFK00vop75Tu4OUig3/W2wLvT9GsiOYpETuwudrdUonNbNqPG2B/LmU/mOVUAJme5CdNT4LzV/gQFlJjRCh4vy6/tteyCIJGNOLRVGpZl75xV9H0UOtvo9AZgopMD4l1sbMgAaZ7wbEmF0x4JM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKKI/zcWnctGU5n+ayygAy5dubxFG1oa/m8AdK0QTzFobU+/+MgAWULvzhvv?=
 =?us-ascii?Q?kORH+AnECWjfCs8dUm/huJr4uQcpIehan2849mfq4+6m0Ikhfz1ctFWMEdUk?=
 =?us-ascii?Q?WgVnkRbVWKtjWmmpfS0F7sywVfyjQGL/mIIcJCrvIN2IiVmdzXWdEz6GDhKS?=
 =?us-ascii?Q?sJ9HpSlb+KSXDdg5GUszCR4KOGdhZ3nC9398y//CwYQU4CPXqqfDhr1CWHGg?=
 =?us-ascii?Q?J80W7NOX/kaGarV/N/mWylILdtooMbByJ4CyJqwVaxba12RAJ/ZMKktiCz0F?=
 =?us-ascii?Q?XsKvNJnzJzflWuYjxop/QlLMSRfbaItWHADMSpD8qv3X9JzCTCDA8kPCQWv0?=
 =?us-ascii?Q?7V4PFavpH6CNjl+oeBpsuaCe1nehjEs3+CLQAK/HoCoYgf4Yrma4nsEGwp4b?=
 =?us-ascii?Q?Rl1naNWTLRq16sgSbsf+ttO/sNFdoqtynLM7y+UCdnpdGTPAx2o6HCO/hohB?=
 =?us-ascii?Q?iqFoAwvcb2X81jmfk8LrPwxqGhvzU2hbXudU6OvnxozerVXJeHByeNpusYsF?=
 =?us-ascii?Q?MAk0u81PrgEtHOxLRiUGs7PZ43leT+963ah8f5+kIIvF5zj30gCN3tv9OHYW?=
 =?us-ascii?Q?dX9rsLNN/6QZlr1ITs6wxVIOpoZAqjAF+DVFg4/PpCXnhwGw+6iPOQoySr2w?=
 =?us-ascii?Q?q8BkMiW1WzYkv+CLZcHxrn3DbwocKOKKccc+prbh7xG2TLzgiBAYbrHLdVhH?=
 =?us-ascii?Q?GgJ/f5oD75M14+YWLf3pZnTRww+VWzypxQaMwhEjpJ+R3uSkdvKDUOtvBtGY?=
 =?us-ascii?Q?vXFvNXBIETLtXoSZUbfJN2jGPTAb5SQ8Je1Qkh4i0Xs0oq7dGp81fKq5CWKS?=
 =?us-ascii?Q?msMZNGcncQtDw9WrlGMHnFW/jrOGqyPZ5329g9gpDMQgK1kqhnIzeqsC88xd?=
 =?us-ascii?Q?+PX3dbFp7I88El7F7cX+3f1c4icz7knQKEhn22vCApOdeORxsHNwHMDJb8xk?=
 =?us-ascii?Q?RlUvhnJgl67Fj0NbhZ6C1WpbvaYcIkwWBsqK8FA5z7MbCIuJ2qJUHLp3hr0z?=
 =?us-ascii?Q?mFT9Opu5wtJLDBTxCoTWjuF9ihPN/N9s0MWlLyh9dmG+yHuAWNeUTOPa9N8W?=
 =?us-ascii?Q?C6JoZjQIpzNies0mn0y0Ng3WNW0RU95+JeHS+v8wiBR+EKfmARxLA2usZTZn?=
 =?us-ascii?Q?hKIMH3yR0bpHLxDusYqrO4weSwpOfKHEmL51TDQP+dLWOlUTbr4pfNPSSMuS?=
 =?us-ascii?Q?5GLffrmzZOUpwGcOEGvINaxfuTf4oc7Tzef7i64opUkPjdjMKI4XXx6bRtGZ?=
 =?us-ascii?Q?sE7qAOVgP2Gt+W3fjubETaxS6orxvTw1lmMiNcummmMI2iAvcXXirStUv5ih?=
 =?us-ascii?Q?+NoUbdF4bo9c2kurxAEWeZMsRgoSwfk4oKZ2DpwEva5NKom5JXw7o+qvGWUm?=
 =?us-ascii?Q?lIjZfjcOJAsWqwG047dXVluRBdfbwKzDfyl4LUHixeARwPgLNPh86gsnnzV5?=
 =?us-ascii?Q?3l3k/+Ti7J1OSXWvPvAVbxwhNMxGjxcNI19ly4vpf1KssS0o7OKMD+LpnCB3?=
 =?us-ascii?Q?3WxDORE0uCsv0nCk2shc2CCIhnKP4Bf5K9rDiHEOQS+MF9DAVBUMId7q6Gxz?=
 =?us-ascii?Q?wGOPKsRnqn9hh0YMZfheYq0o56q4IT5+za5Gsalh5NsWCbb1jirGf/hhSg3o?=
 =?us-ascii?Q?HpcRys+SCDXfdCR6CZPwEOggc+NkyyEnTog8E9IjckrD1iSxDyCyQlU01SiO?=
 =?us-ascii?Q?BIRLt2N56BNKS43oBXDiE3AtZAzenlMzNOP9JOb2Zw1g9V8zVLgaODi5zhTP?=
 =?us-ascii?Q?kzVX4RJoR9Mb+0dDXdBaOJKX9YP9RKk=3D?=
X-Exchange-RoutingPolicyChecked: u4SSEF4DwS4XqqWUMnxcsK1baPk/mp7dY9Lo0KGRqxerBG2pX+3eMv/8DM4UilgZL0jEx2rBnhEGvtT1l4+LS8q9wlIlC/WyyEHPU2EFlhXwFCN2cXuajS5+3js45lUx+SIGuoVB+TAM4CxacuRQ1EFx4Fq6aV3MFISrtS8evpgjbZXrWg88yETrKjR92aZG150NQEG5WYSk8aEKabx5gIpbxciMy9SBOK6DC0Cj9oNM/Wnr5tQq6vz7h7Peqqh79JDct0us57IPw7OGcTlNun0WSmgBT39U1lZFtCsouJufWAQSBgTF5CLlLAwayOf2U7daB3F2v0N0SDaQ5zI0dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62932d2c-68b9-40c1-f740-08df1ffcc53f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:44:21.5901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35iAf9g7hasFKETQJS34QtKHxNSITUqNDUuFyk5wpODY0XRCOQNzbHt4HW3O/kBz2wPLWC0LGjQ6lDvlJ0q25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
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

On Thu, Oct 01, 2026 at 10:03:22PM +0530, Aryan Sinha wrote:
> The open coded res->end - res->start + 1 is what resource_size() does.

nit: we should use imperative telling the change and why. this is just the why...

> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index b228a737c..e6ab5a5b3 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -1848,7 +1848,7 @@ static struct xe_pagemap *xe_pagemap_create(struct xe_device *xe, struct xe_vram
>  out_no_pages:
>  	drm_pagemap_release_owner(&xpagemap->peer);
>  out_no_owner:
> -	devm_release_mem_region(dev, res->start, res->end - res->start + 1);

I noticed we are not including the linux/ioport.h here.
We should do this explicit. I know, we should had done it already when using the
struct resource. But now it makes more important. Please add it.

Thanks for the contribution,
Rodrigo.

> +	devm_release_mem_region(dev, res->start, resource_size(res));
>  out_err:
>  	drm_pagemap_put(dpagemap);
>  	return ERR_PTR(err);
> -- 
> 2.46.0
> 
