Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A301C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BF110EF5A;
	Mon, 14 Sep 2026 15:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hisloxd5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3898010EF58;
 Mon, 14 Sep 2026 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789398299; x=1820934299;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VBQnksiuhVGaac5lcIsh5FucOYFtFvjEz1pPKsnF0a8=;
 b=Hisloxd5x5ap7Qtbe0KyIMDkx+H9Vx7H7DLp1FdU6eTXpATjUzWSUyVr
 rNpwJSE8/kPZ7bI4FIaTCmd9ZtsGl2iayw14HHPYiqNnEDCb/KBLJ0i3W
 vD1NShFNYwpC9ZnKw+GLM5qe++hk3rl+YB+zJShJaG2V3l4YeFz/0walB
 raytHzm7FEBp7ksr5VFBkelNUnVvrtvDVfKFxvaNnnwT6XuiUXNOTe0J7
 GpHumYZ8WH9v33bYlWgrMJifrxIFCU3whUcRFMrzJmAhBPRMgCiE0bSGe
 oYMj6JyZ9DlFIDi6O16WcCfrWHsotEUVqdj+ubYg/qo51b/4m+P74zCl3 g==;
X-CSE-ConnectionGUID: WIYZZQi5QaCwoDJwD7v2jA==
X-CSE-MsgGUID: WkkaKJm1Sri7DC47+e5nYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89514489"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89514489"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 08:04:54 -0700
X-CSE-ConnectionGUID: lJm1itC+SZeQKFaGiFf67A==
X-CSE-MsgGUID: EmT7nQLKRI2SaWx//tKO6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272623693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 08:04:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 08:04:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 08:04:53 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 08:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSA1JCB1CTZnAeB/3i9s6qvltwFgiV9C9Y3+KYN21ZaUVlyj6KLY9BTnAj5g+EvalAhetXXbREKYcu6fsxd2i5hfGje/vvlaVr4I75QmzgNid7OycUnZvJuJAmTyIc7GDT0HDaNXFeChKurJH/eJxi0MYE8SvVY0h8EueDqPA0PVBzBBS6mGy48sENWgw9c3IhORNdavDlZZh1TojSLRmp5J0ydGYkMgkbk08kAlkWbXDryoqZt6Cp9Y6wtDVUOaL8MmpaMYYJk10ZEax7f3WnmuLGDycfU45xT1AfRlMfhgYgnfJik3XaUx72RgEtxeMF8FMS7DbK4SGqKIXllCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI2kYoZCXAZ4nYBvqHsTncGUCbnIxAJX7lbl8nNzPzE=;
 b=m3haKzPW1Y0hFwSbvaK5egpgsICU7u9WMHeYG+q4aQPHZBXlPJeaELZjRdlHiXiMLe2ElDRj/IOVrctPG1vy4EAhPCSEQJKkD7bm3H8z5kwuIv2apcZtv1uvX4JMwN5Azv+xP+08T6uQeLr7eLZP+AIu9QLqwnrynkNzAhHW/LayrYN5j/+v4KBwZghjOLC2LIJfNSGyAFsM4J2OT9Pv6kPWa29HwyIf1h3+C+apbfA7SA73C7x3IajSRpU/plH8IaPv5hhgQv256BmjRfbb9eVY4Y3yWe6JboljgzHbnUdddlqUu0gwzexxogExjnml7vNpsCuh2CRLlQRpPBdUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:04:50 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:04:50 +0000
Date: Mon, 14 Sep 2026 11:04:45 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/nvm: add system controller region
Message-ID: <aqgNDRN1q6sSI46x@intel.com>
References: <20260914-nvm_add_sysctl_region-v1-1-75d710daf5d0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914-nvm_add_sysctl_region-v1-1-75d710daf5d0@intel.com>
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8b3b5d-0525-498e-8140-08df12718603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5XRvehnrZa4qFBEMX7dNx3cEcErK24pt0cyd2GoXndLZi7wId1Ruqn56jgMzRW/qM/GznNGXqPONxiM82U7GgxdUWxahNVA61GHxAgynNn6DIYjTbsmDBSnT2i5kRdjbVroLmYaXW1bcQ13RV0+uHEHhS/irkz5/cRmRKvJZIvL8NhjLYVK3JiYMDhYkDzyaDf06wC0Ld/wx6BA5f2shovNkfkd0lttDZmpZJZsssDSI3YJaaIXcPkGNQ2U/YqWv0cD61BtdO0xvsKC3SVNNpiyCGRTjVk4JBk5sYPsi4KoFs3G2Mv/vhs9rzht4DKhKcgCnmqpuVnAyMmRngDXDyOe3PnalWRHIDgbW847lqV92O7EAQ956AVD4XseXU99TofeGigyIc6qWmepZwvd+qV/e9lGgDbZNwutyvm+o6DiBybGFelGgbPDMR8wxrrTKVDFpi/lgw+ig7bJ25dEpCeUVaiGlWu05j2WRJSefLggQFTyBhch0xdyvvyarwgY203Ii2UeOcvkq69vP1AdmqVkVPbMZUw4DUr4xWD0CcK0yKkuuKWCROGaX5QKITs+rKXLLOnEA/ZqLVfSyYBxfyS0KYWqMMC5Nqk2SzFPnFjjecwKIOMIYa73PCBsi7uwpVc8ZRrgKk+z9mW/rFPit/LQdr4/rwXJWQT5iRmtUMXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+pPvG75Nwd3gBzynE57hoC0nbBy9JdGkSxt9F0O+tsrllLSaj3R0ljrfNlAm?=
 =?us-ascii?Q?ekcQpdB//RPz+fJSQ7dN2l5UXWjegogVL7l41LTt9s+GUu/XOtbt5TpgMk4E?=
 =?us-ascii?Q?NuJI1Pjn/lxVeVkEoGd2cj05Rit9EMjDMooHbkiInBNHJlgItetdiIkFrgaS?=
 =?us-ascii?Q?wF6I5X2HLOKLl3H5kPEYo/SFH8Yvy40S8Wch/VOF8vaftoAcgeLrz9OEVvj/?=
 =?us-ascii?Q?zgknNtk/UVD7zRJGjvwffRrL1faOEGPLCylIJmAtddHLQa80Qha6DnPvsLlI?=
 =?us-ascii?Q?0dj7l91/yEuuVwNbNpXVJHwX/rZ9Em9j/wroeIYGMQsENYiBLfwW2TQShtI0?=
 =?us-ascii?Q?YyJVpNuKnWNnbF1As+BOtrzg/VE09jxaO7feE4/1m5zGsDvsbhGBeHVr/Esa?=
 =?us-ascii?Q?rp6w1x/U/pujbN1iwLztNDWBbcoNBFgvFaM1y8bFFKYPq51HaWTtMdf/7Cm/?=
 =?us-ascii?Q?F1Z4Jki2C7Wh/cN8qsas6fY8BF+rvWTWVmWO8v6aFrTPNPlE8NV4fEaPKxRk?=
 =?us-ascii?Q?dcky5HbvHJuiT+iWw236gOqB6Hip+PpKJhP+Kcr5uI/gLukeQiY19Mv9m5ct?=
 =?us-ascii?Q?hkbovsF0TtAEqYwLdaLzO4NC6c03QNi8MbxZGoLc3oB0JI58pCHXlT9TMFP1?=
 =?us-ascii?Q?Js8S2bvk/Hgxi5fEWZSK2sgTqekToqppFnvGvWpgLkxBX2YZ56g3bAPy8hrU?=
 =?us-ascii?Q?D3tGnOHDKdeo+T1rx5Bz+sHbBI3IgozaGsbm5rM+1xeKQwG1W95+QeIL1ZUd?=
 =?us-ascii?Q?pryQcbejE49pf/aHiGtDpHGDcsMafGsN7Uy9aZwyoVs2japvWNvquHUcxuza?=
 =?us-ascii?Q?pQXXaAmJ+DB8HJWXT5LfwhN6e68QWm1nBUW92B8Y1tisFqYqLPM5hMn0sFuH?=
 =?us-ascii?Q?jFX8UCF62pWSqB1kMwoGiIND3TZWVDsqNkCZcTYsyLp1nBxnZp6c9LTU73Td?=
 =?us-ascii?Q?NA1H/Ku0fl+0R4BjuyjmwvXggOrm5WgtXpHtC0vy45Aei+tHr/JixL9F7Hvw?=
 =?us-ascii?Q?IrfE3atpEIdRXcEJZM2o29SJN1HBeLFatUae5qiZgXM7UtBep1hfcat37n3l?=
 =?us-ascii?Q?R3MEnCtQLsFyyEy2vy09je9ZS+h/y0QL8dGDCawh1UAOgFyDHZwyUZDEL3Ha?=
 =?us-ascii?Q?Eo/rLaeqCg5QukjvPRhXDsPL4u6dn9LFNkX6wejHBYRNM53YRHAz9XCUOnUG?=
 =?us-ascii?Q?difPF+m5IWRSFQvab2GMfcwWrduQ5Ckh26uVuNu5a4EQWCkwUzhIyJLlRYuq?=
 =?us-ascii?Q?fwvXX16qcNKoVrdNCX/Zm5co+5hLmee6qxLeD2VKECnmPs8JBBk23z1BYKob?=
 =?us-ascii?Q?VeTAnnzQl0X7q87m+SP519pqQdjCDxgY8T7CsGBMbXUELQPt7nwBnZQp6tIz?=
 =?us-ascii?Q?GRNJ/n5nF3iTc2xWrYPlHUTRfttE0lSx6euOs9RZFKJYKm5CmND98oi5jNeL?=
 =?us-ascii?Q?1GpaSQtca0MPEfTQPxgDJzR6ZTeYWKka4GJJmZA0mvUUwrbR1SYUpRiGeIOz?=
 =?us-ascii?Q?4w2RUPmDUx7Fqbx6zyDcAuubKPHOjCHYfrKADV7WHNFo1GVdhIb6t+pl/7uU?=
 =?us-ascii?Q?5eo/tcF88Ckf+0QeWYbjWNyRa9JcD+sjNROaP7/UM5JqKkgsskV9SSLP5v8N?=
 =?us-ascii?Q?27ZVmFFJ1IhxvZHFHLP6qUZASfkAIRnhirGvRkVH6eGKITtAZPqVubwuz66r?=
 =?us-ascii?Q?Hz1XQLW5FFl5De6PgwNVUMz/rrkYgrABxF0sXDuRlMymBwh7CaYR2VqrjUY9?=
 =?us-ascii?Q?nKrNjiTsaA=3D=3D?=
X-Exchange-RoutingPolicyChecked: qvneNcMyLESeyM++d4/+LcvpmsLjHpUMefxHveD3wSB/tq8A/Bx2aztVV0UTHwV/6S10kTUVKG/AnOmw4DKGqL9PzZ71Wo1lSgWr7z/UbRWVRePFGjPHIBBM5AmjZRCDNmM68Bjc5llUtBLgDQz4fyqMLhV/mEGflu1vvjMbKCiAiqZIPbJHk33e+t8jE58RsgGyoxcmXX0sfft4jg+plv1szkRMOVRsS9WLMcwnQYWuUczHNUVtZvsND8WJ7iavuwnl2avO6DjlZ/XxDBRRjfad/xhInYb/z62Qls3c9+V5MwQzKtTcQgz1q5ciLT7zKoBCNhwLnRI0XatfJqp4jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8b3b5d-0525-498e-8140-08df12718603
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:04:50.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPumUVdbJwnZeTOBZPGMuIGF1sKh/hpJ7g4g+AMi6RyQLHrF4nXKEFE4RhomZ278Bx73gtO3jv9vUB2r0kr73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
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

On Mon, Sep 14, 2026 at 04:18:02PM +0300, Alexander Usyskin wrote:
> Add region 5 (System Controller) to the list of regions
> available on device.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_nvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
> index 1ea67eaeae24..51a1a431ad85 100644
> --- a/drivers/gpu/drm/xe/xe_nvm.c
> +++ b/drivers/gpu/drm/xe/xe_nvm.c
> @@ -28,6 +28,7 @@
>  static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
>  	[0] = { .name = "DESCRIPTOR", },
>  	[2] = { .name = "GSC", },
> +	[5] = { .name = "SYSCTL", },
>  	[9] = { .name = "PADDING", },
>  	[11] = { .name = "OptionROM", },
>  	[12] = { .name = "DAM", },
> 
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260914-nvm_add_sysctl_region-6582a8b86602
> 
> Best regards,
> -- 
> Alexander Usyskin <alexander.usyskin@intel.com>
> 
