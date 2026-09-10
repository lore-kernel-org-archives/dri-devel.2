Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37EDC79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970C610EA1B;
	Thu, 10 Sep 2026 02:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VSm3An5d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DBC10E5A2;
 Thu, 10 Sep 2026 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789006947; x=1820542947;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zx9er8pLeZahgby8p5tREXfFTWZ+Nv7zerIxd0JK2CA=;
 b=VSm3An5dNHK8vRRkPxJC6rEBBeRilCstkyaBMa8clW+D6b8QFNRuazXn
 TWETrnc8Tg1MmlJaYuyRXAmtywwdTQgOab5B4sZxjCCkbqIfyYc5rWaOd
 VNWaVGZdt3/b+AVw3tAULInVIkL/tBXmk73URkbIAwIVdGY7Wp4SMYMKG
 Tp9oM3s1dMlSmkWA4lrWK/P8k3rl6AAhI2Ak9gcSPwrYOyEUt1qMmaEXT
 LUsVQb28pSP8gWevWXRcFgms6xl+kvCuPo5d5qNYads7PojaglBFLy3VH
 LUI6iqHcQan4XeT4aGhVDBVZCqrUrVyWfU/QXvPgXz971IgJobvW1NGi1 Q==;
X-CSE-ConnectionGUID: MCHVvIdhSauumtlS5rOyHg==
X-CSE-MsgGUID: NO9AbC7vRxis5XZaKj2OUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89487447"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="89487447"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 19:22:27 -0700
X-CSE-ConnectionGUID: XlHKncoeQGaASNSbqYUBeg==
X-CSE-MsgGUID: 4yFIaNZPSvW0PP2pgjCkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="275006056"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 19:22:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 19:22:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 19:22:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 19:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G98u4vdLEyyvnh7QI+j02/zsl2SmHPvvddNDqRhZ0mLa6r6WQF7nPIHcHmOliHYAAVxs3xHSQLOBF+zBUcHj+CgXunKna3il+PMH5qomp9y7lcq/hP1uIh6zrNYOQkTWCa629KJoGZFUPaVwWyvGrudYsdMxKVINo6oCAZNc3ciDNCZjLeLesBuR1VwGfsO+KH3ofSlw/XbbOjp+sZQu1tYQTMFxEyQiNqiF0A7Jfrh9VnH77aK94PjcFhESsGZcQ5+u6Te2UzdXPQl/XlDF8zTDgf73WVM6rKMLfyUQ4tU1WBUoJfTXdqx+6uHlv0/g9ZJwu1dR9qlSO32vF25AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4EVhhCoGvoLkCtNuI04hwFU3WbAUUSv0oLaNZi1AG0=;
 b=vqJ80QCFqaL5BlTXRpwhdjIqiAV0T9ZohcWhhm4ZaE35VA7gPJaRPBKEZK4dWhSsZizzBbpOmQI946ufd87/sPZ2M0AMEqlZerVVRh1LDZPWiz2W42PrEZUweP3hilUWNETWg/t/zVth9CJfgDC5EsqqU1lX2fPbRugnlmUbN/pgzxUAAwc/XduyM/xUUvXShOIyJx3A+Ur66ZGsplLUpz+L+HInqtVbgA6PWFsZzs6c5IFrikWBEY/McOyWvElHaMYzbadmc6MklFV56PcWxBGe9ZXbQ+dQ/j/KnIoUx8/SVZ/4dxsBSQXq/DFszoAkfmdviJF/rIE4FbFMaPzVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA1PR11MB8788.namprd11.prod.outlook.com (2603:10b6:208:597::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Thu, 10 Sep
 2026 02:22:21 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 02:22:21 +0000
Date: Wed, 9 Sep 2026 19:22:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <christian.koenig@amd.com>
CC: <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 07/11] drm/xe: Use dma_resv_alloc for lockdep annotation
Message-ID: <aqIUW5i6jGMMd1Es@gsse-cloud1.jf.intel.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
 <20260903134408.105317-8-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903134408.105317-8-christian.koenig@amd.com>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA1PR11MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: fe829b5c-a61e-4db0-55e4-08df0ee25830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|56012099006|4143699003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: cN/OSjAowES6hNgoHWApw+Zs/9rzgBZ/q4HsgxM/TnyNGWKWCYSDxAYf2NSloYvGnEK6+4l/V4fKv2I0t9O8qpBfnsRbdAWz+Fwh14OwMfR+Qd8sLZn03PqYKRKB167zC10zm/tYeenmAEtemVBFQ2AEGZLK/RMtd8iFSl3OUlyI8yDt5A/uE8Gnv4d0Tg3jH+NFA6WFfgtbAPrCzQVnDyZCrWChq3u4S7IeF4Tm6eRK7HhWaZCzaiUgXEkrQIqB8j63sYcFJIK+otkOhuTierLbsflHhUnCqs4/viH6oUQyulZtPWbnhx2w1PlyuBrauk4K0Ckz9ChdBI0XXOPGVwVElI0EqeYrWhdBqSuZGHFWQ8qiZh13yleU9I0NzEkvnzGYeXjIRe/le1wKRI75dwGh54hVFn77CNiMbG/+1pXdM8GSzBbP7rvPvPcs4VCu9FytX0WmMRyJsphAU2/5A4n54D/xrk8vD6kwkF5StI6+8yYXbNymRmlV9RpGsof7AQLrJvVWsNd5myTjcVU+7txDFfy5UB4UOhQQ07LxMOLaI9XLu7X2vIbn38yJA3ygzkmetgfVP9VsKaDMNzIZhiriNbY3WxlVtOBAuAM+dCiQQwEM9Mwbfi95KgtaTkkcerhmBxdda8IqovgkFh3i4JD79ZZw9uMu/VppsGOTUPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(4143699003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8ojUG1K4UzyeHOuGla3BCUwGQJW36RE2rgs1yK5n+xVM+uafNGVgiDjes3?=
 =?iso-8859-1?Q?CjmrrT9M6KgSA+s9TYq0wJNBPr/hgBQRmK8zA+lq6tnRK/raRaqe7rSLFg?=
 =?iso-8859-1?Q?zRMgMjujAg9h6ZNuT1g6xue9YqDbSmhFzA6ep3NhRnGy1zPi4RIRAyaLhO?=
 =?iso-8859-1?Q?yeJoPyK9HsHnatYz0JJeNN1GfRUFHBRUWNx1Gz8bVh2qUOiTcDESfKdTTx?=
 =?iso-8859-1?Q?026mqheDZLQ+vjloWZ9CuvEIAmoiBc7Zdu3BPedBNeIb4+Qnir4/65A5b+?=
 =?iso-8859-1?Q?ikow5L025z1TnpFJU1cZlHOwf/RcCC2SXIge+9YNc/CGm2CII211VpPn2l?=
 =?iso-8859-1?Q?tbH0uXrgKvCcQxszH1dYkKHxgRf8hZCOWYnFjVhX2FJqIlWOt3zzbeBpTU?=
 =?iso-8859-1?Q?XfKEhPvlYITmTCTL0EfwbId9eKqCskZBumUaKUBddcIoYYW68N07uyp2ls?=
 =?iso-8859-1?Q?Ne4ED3qGyIsTc88IhPbW1f+6IFu27N0eWoj0cyY1cRZWnahwEAGnDXKQzQ?=
 =?iso-8859-1?Q?Hy5h7+dLFUEjf+gaHp+IIHd80UhiQhWfZHpj5X164lprA9XpxRXxejlgnO?=
 =?iso-8859-1?Q?Ffct8+ilMjFRtJBkObHtuIjE693ilhn3onCw1mWLMXyQgQaXefp/F97jf6?=
 =?iso-8859-1?Q?tRmMUJRhBjLNT7A/DnY8c5DjYdn8ORGZS1zUzFpdJZJZmH7lyre3WIYmD1?=
 =?iso-8859-1?Q?/1jpoSGTc3MlvA0wHob1BmjGcfcp1ZqjKn2DI/qd0hSxtOjz5oY91uK2Br?=
 =?iso-8859-1?Q?I6YzsU6xdUEywvCPQjY1Br94hAPQvuslI3VdpHJh8ehj4iH6PaWlymmPR4?=
 =?iso-8859-1?Q?k3AtwOuKwviPA/G94yIp6kygV0apxAaCW4s73rmzzK4NHCSxbkPZSBqN4j?=
 =?iso-8859-1?Q?GY0a+35IEj1tJVX69kIYcLLlrqFBkNshmjcMCer8k5/4uONsb03IOAjN3u?=
 =?iso-8859-1?Q?b4tiZ1LHZIDbu/Ym08RIsBV2i5DIOIgtSjPyWe+Ac9JZKsv+PP/PqyHX1R?=
 =?iso-8859-1?Q?6xfOvvkL240eAyvWCm6r3uiIKO9yMOu48MONPZOBi2b392Mk0U6++V7svv?=
 =?iso-8859-1?Q?CHJioX/Aq/XcJbhn7GOpU3HwooO3IhA32nZahySUPAdoFCNKxalVbUKxfM?=
 =?iso-8859-1?Q?VEHDTjZ+ZHyAaGzQF3ikGH0Ha8XnNx48hxLglT3aRMz3R1evGMPOJlxYft?=
 =?iso-8859-1?Q?XaVbmV2miG8HP7qsD+Rz0W7eY5Qwb0I/5QtsKsM+mXD5R8KJYi3UCvaaDk?=
 =?iso-8859-1?Q?Wn0v4DlOln/hB3Cm7UmAG5yMxXdiZkBhrDajbTZNM4FN3IXx8kNHd7XsdQ?=
 =?iso-8859-1?Q?6Hnwn6JADQkUd1tfqbm4t+iAN9/m9zK+gZ2tOh5xhYxpGFgjVR8/Fs31s7?=
 =?iso-8859-1?Q?COfp1Q79B/M451f2uuy9aUQyozXIX5TQHmG2pKVibZ480Fw3qyo3M1G9mS?=
 =?iso-8859-1?Q?zwa3SKGGob7EtYKXFUdJDl1DuZyDZcYCnaQH0Qckqkoh0WmAkaOP0Ishn5?=
 =?iso-8859-1?Q?GYWsU7xzJaTxMPNJdVikmAajtbICIM+1+hNUqDqQtszF7fcMl+A7Ueyxzz?=
 =?iso-8859-1?Q?O8wSULOjB54lhvXyc3DnY3fHj4ffyFfhGGzZxKGJrlpXIAHxpiUNpELZZs?=
 =?iso-8859-1?Q?jQviz83sjQ6lZSfmHujB+dOZlOgfHJj/EpLPfyLsHUvo8CMrFUeNnDheoB?=
 =?iso-8859-1?Q?x+ozNiyX9nKH1p+nb0nF9jumqft2saOIaZNA8tONwdStRlUO9sPBHO8xN5?=
 =?iso-8859-1?Q?V3Kw9CVMhSAO9R154YPEjgHEUygzMomVekW2DkLdd54si19GkhWplZHoMl?=
 =?iso-8859-1?Q?Q6wy4/va8INQvZEWa4II+jpnuu8YJ0E=3D?=
X-Exchange-RoutingPolicyChecked: qrSuLy9HcQW2qnhofvHUXFs7C6VOEPqEMDiyNaMCyoZwQIBzAC3+ZhAEAsTKERRUpW6a2hwXbKDIkZ36xJvvjlmCf7V2SFPIzivSqpSRPNfojTvh3VM3+LJnROmWDLQ95L3kubjNw5S4YWFgNoQc7Z5DqypueCiXg/9Bep8bo9kopGqT65+V79f15w9RNp+MisHpYKqU8IdU8mU0FccmbjTOGQ2v5GhBEj0P04EhvjWwx1HxQQDdk84H/Mdzg43fbPBCY4/Rq1bnGaTcAltAmdQjmEKraMPhiqAqyZvz1TecDHKf7c8VD5nMbDF0XH9nIRDfb7IwPLf0abWp3wjZIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe829b5c-a61e-4db0-55e4-08df0ee25830
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 02:22:21.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qjt25YUvQUiOM3iJMEiK6RCRw7Kw6uMnlvdnW/NmxX9Xb5YhYG9ubWtvTFCIYCMY7pd6v3EQs/HTEnvSDfCqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8788
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

On Thu, Sep 03, 2026 at 03:28:02PM +0200, Christian König wrote:
> Replace the stack-allocated dma_resv in xe_pm_runtime_lockdep_prime()
> with a dynamically allocated one using dma_resv_alloc(). This aligns
> with the move away from embedded dma_resv structures and towards
> reference-counted dynamic allocation.
> 
> The lockdep priming function is used to establish lock ordering
> dependencies between runtime PM and dma_resv locks. The resv is only
> used temporarily for lockdep annotation and is immediately freed after
> use with dma_resv_put().
> 
> If allocation fails, we silently return since this is optional lockdep
> annotation that only affects dependency checking, not functional
> behavior.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Assisted-by: Claude:Sonnet 4
> ---
>  drivers/gpu/drm/xe/xe_pm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 99562f691080..33b19bcb6f71 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -762,15 +762,20 @@ static void xe_rpm_might_enter_cb(const struct xe_device *xe)
>   */
>  static void xe_pm_runtime_lockdep_prime(void)
>  {
> -	struct dma_resv lockdep_resv;
> +	struct dma_resv *lockdep_resv;
> +
> +	lockdep_resv = dma_resv_alloc();
> +	if (!lockdep_resv)
> +		return;
>  
> -	dma_resv_init(&lockdep_resv);
>  	lock_map_acquire(&xe_pm_runtime_d3cold_map);
>  	/* D3Cold takes the dma_resv locks to evict bos */
> -	dma_resv_lock(&lockdep_resv, NULL);
> -	dma_resv_unlock(&lockdep_resv);
> +	dma_resv_lock(lockdep_resv, NULL);
> +	dma_resv_unlock(lockdep_resv);
>  	lock_map_release(&xe_pm_runtime_d3cold_map);
>  
> +	dma_resv_put(lockdep_resv);
> +
>  	/* Shrinkers might like to wake up the device under reclaim. */
>  	fs_reclaim_acquire(GFP_KERNEL);
>  	lock_map_acquire(&xe_pm_runtime_nod3cold_map);
> -- 
> 2.43.0
> 
