Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34EACCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2525B10E39B;
	Fri, 16 Oct 2026 19:30:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAF910E382;
 Fri, 16 Oct 2026 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792179044; x=1823715044;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=shtPXpTswSJTWy0NEg01xgjajrvLTBb4glHyX9il0dE=;
 b=iQs+ZJkS+4QHt9Iw/yRPwCyJAhdJ+1MQ2IIkgPuhkEiCowSta4crknPH
 /vUVbVV5NGU5K1+OBTSkNbi5plOFCwA9q78oVI9iWk0klkknUzmL/cQoH
 cOB2qKhW8BpJIgdjCuCaGGMMBcJWnLgA03fckdFTQrB/w9uxc6mxho04e
 lUGXNiZxcEN8MS/yzW1+7Z71LBCIuKgP6bzHHtGErj4GBk7fq3m+bOtuf
 5dNSSTmQzubVQ1oqNMShBG6UC7D5SmaPUz/bxy5QtsoipVjt1dCgBKtKz
 fDaaf3zMio6EHj5mXlYKcfl+Bn7plo4Pf3kwqaDEEFwpzkfNInW0fEl0C A==;
X-CSE-ConnectionGUID: 7EAUZ5ClQMyKrRabaZFtOg==
X-CSE-MsgGUID: Mzxwx5UDRjSCQfAx9ofaIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="981883"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="981883"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 12:30:43 -0700
X-CSE-ConnectionGUID: BzrOWnFCQHqdOQzWuV8c2A==
X-CSE-MsgGUID: cB2wK0oCQPunGOj4d6WJJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2270634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 12:30:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:30:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 12:30:41 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 12:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQPpW9msSrU2v3NCs2XPSfufe9LfaYMudbUzAv8F1Ps5YXDNeLLq0B9eqLgVWi9tNL8AeLYCnVVoIV1gpeIZ+p/GSGJT+JHwFJHHHrLbAMrFjnGCGRd8sZrwb6wRfk5l9fPiY+fjtZyPkHoLZJiECswJ8JmCkujTUTBZO//EX5i46MYlHPXo/wQy0GVOX7pDCMRuZ8WHnVptNEZiO90CzrZ4JEtz0hCkD+QZpfyeWQTD5Gc1eSwJWMIfCkVp2kTXU8EgdpdawIvzgtXPecF0yq35XwTya4huu43OI8cSsNHC7pkkdFOZUOAxPOkm8Rcs2oSF5BC+B0WyLNrsCUFXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh6GmTDcvfOcYUdsGHZQfbe1463Fa3OVRD1aveQEvrE=;
 b=SlIZfg/hE1o+xl+5QdDxhWcuO/MwZrrmLBy061vJLUZ1dUFlKboZQ5zLVv/8uiGfNlw9FdfbduCch2DIF2bMa57x4ZjCcUf90036Z+7xbHuA0CEO5O1jSflVPCRupioo6zkJIFUFMv1KlIpJP0wVRegpj/Sxs5wV5nm/aNl8AzDF4sFdvoxXJiDs016lWx/p7BCehHvMUr3Oui8hBAThzuAqkyCAs1l2oso1wgp5b4mD3EjwC5ZGIyJX7++Bcuc8EmdeEJSta/m4TDOA0RSxN+xomibeJ/RIXURKCJkdusCOVDEnrxIUmfs1H9LwIfS6oYY7JCVUyFX8sLIz8Tgfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by CYYPR11MB8306.namprd11.prod.outlook.com (2603:10b6:930:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:30:32 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 19:30:32 +0000
Date: Fri, 16 Oct 2026 12:30:29 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Jia Yao <jia.yao@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Shuicheng Lin <shuicheng.lin@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v13] drm/i915/dg2: Add per-client control for
 Wa_22013059131
Message-ID: <20261016193029.GI578251@mdroper-desk1>
References: <20261016033102.529239-1-jia.yao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016033102.529239-1-jia.yao@intel.com>
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|CYYPR11MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b7b98a-2cb0-4b16-82eb-08df2bbbf173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: OlkpupM/9P4oerQqpEl+8ohbl1YZMXZGnQWqcfWEfRfI8I5hLCVSQG4SlpfUF1iBEjOT1VuI8YzDlSF8p0c/z9CUc+XNUscjyvgXSUawNL8A0yAhwi5utuOHheqlG7fm0wfNsdF54i5aL5OsehgbFbc8kJVYqIV9V5JN78d0PXN8jHoK/tH/PCg4UXODRY1qD424OhwEqTNPOX4nVUwYOpJ5qIn0KyUMCVHV5GJ7ACqoTpKz5/Zs4gxPnTbTo7zVq0qnHd9UobL0e+xS13LXf1Dv1JmcUMmIUlMgeQlHIUGbbrY/UBpuM1odZD0q7J1qURscndJE4BoXK8FWiDYY611+L4Z3k6caMmRA8N0bp3AIs7+CwowR5FLJGizFG31UXj6xhX0vYs7+VVGwP2P6hLXd61nIW2N1CjFribmNLhT3Y8JEgoCzPmpw+R7xvnxwLQKRRmBbILFDzONY6WkzD+znimz1OkYASBsPZj/wIkkZgKTljKa/zUUTXcMabT9Oi/eABieDDPk6RYLyAMDtQ2vgLdIVVxXHpDGdCKc9tQMUWy51NyLyX8NIV7zok6qynh0DC/+ax/6Ue0taDslAEptuSq3oXh4kinwelML+Qqrcbz8WQOo+thtqDQicJ5FmHLBUOP+Ff5szlSeF+mrvVG/mHpx3crqIsxr5aObGJVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUGlddg8mnXGGxR7EzZODlzxRmjKhjZ2Fw50AWh0Cuzx6u9W0y5J8/jyP87d?=
 =?us-ascii?Q?3TlYSuUfPkO6p1lbWqvcSAIM08E/jkzt8xIZ7sTJpbyzI/zarkk6PHVy/Zal?=
 =?us-ascii?Q?/EKcI50BeDLLIFLhOGgBVV4cLmDCuNQlVIPAhMs2VuyaQXva7rUuYZOmce9T?=
 =?us-ascii?Q?OQpk+gT5a8Z5zVtjEYlOSLDTySN5EKmWf09gMo1UQkfiGRvUw6J7y+dLqwJi?=
 =?us-ascii?Q?7k+ilvtAYpIvrxrHH48AL6lq7oGnxFYTY3oFYXbn3koVoCMYjGQXdPzFQxGD?=
 =?us-ascii?Q?XX/WXLm1NJkXQVm6jPaOWLPpi/tHTCeE2qF1NC7ux07tHqPZ+/vzbZHyxb50?=
 =?us-ascii?Q?ZJB5htpY1E6x6ODCB8HISHMsUjgE3U+IiCEhTfoq0LfwWpwJzMjes9mY4hRh?=
 =?us-ascii?Q?KUOjDAEb8gp7hoJlV1um469ZoO/w+xAQZcErd6OXa6Tib3cv5sSYFl0cQS91?=
 =?us-ascii?Q?ByF/U0msciab5wElxJVfGLEW0grOewY1TBa+JvHPscnEO+epZLPRlRRMKuCJ?=
 =?us-ascii?Q?Y9Jo+XLkhgfIVLzi9lWBdO2JtkklgHTfTGobyL19JxQexScSjKRW/fhET9hx?=
 =?us-ascii?Q?PJm7O3EBl0got9N/iQrVPomU0lTa3GkN+LdymHvZSN+klAUMtGlU8ynjPKNE?=
 =?us-ascii?Q?eOC84rgQcZROAOBEmeUGCei2mvUYDGJ+klGyohAFr9AskRr97Uy84rJSs8q6?=
 =?us-ascii?Q?gUgsk1kRCzRoQLn/6HsvPm0K7PxhjSMj1xJN6Xy2DOvuwpD80eS5ungxtdxc?=
 =?us-ascii?Q?dn6L9OOyj2nhZWjTk3gBqoJDfVxCwPQrVCDFu70b/+OEVlMBiHqS9B3EiHbl?=
 =?us-ascii?Q?N163tqGmN3SB+k8GX7jNpMIcodtTMI89A6eFs/3YbMP6wReF4blluUm1sETc?=
 =?us-ascii?Q?YTRzhJnYT51zN+0lk/uy37jVsv7B59LcrA1rBiEtaEwqbWeYZ7Rjds6Jd+Mk?=
 =?us-ascii?Q?QHaxIRfNZBxrCLUAfl9tlXdYIm7pH2R3xQ61FX6ZVDbsbbVHfKvk1L1qHEwi?=
 =?us-ascii?Q?l2jvcCeAGDm2Et/rHpFIJbrGTjdJ7WD46CWvfVjTgd1x+JNqlY/+dovXtDvT?=
 =?us-ascii?Q?Jn5JW+Gwlm5tQOM0UtcrBoyaF3pFm6Yt9Nw5DDhEwzRnwx348xcha/kXRm/M?=
 =?us-ascii?Q?6rEDnoX9euyQB69ObKKdGEuqX7gss0qkE57m8v6u1rJ/ZEGym+6anw14gM/c?=
 =?us-ascii?Q?lmbg59Wg3vH79SDSqskdXr++K7PErCujvt3a6qNn+Npm91YJ9ouPKZk/pV11?=
 =?us-ascii?Q?hA1+gQppGQVfNGXlhbndHTxTgZFudveK694nKX1XTvyavsx+89M3AzUHcupm?=
 =?us-ascii?Q?MMR1fmIZlkGaUJowj3RWAycQmUD2PHUtVaCwUEGBDXUesmGnCGVtq7CS80xv?=
 =?us-ascii?Q?GzH3J7EBqUTcqr7DWnyIEKR3CU4XC/j1So4aONoTZbh80LOhtZafWIofGRHh?=
 =?us-ascii?Q?ZeMJFLL+LtFawP9XA5p1+lzhqPwBKdREH6wy/f6Ysk6BfKnABlsMtQYniiIo?=
 =?us-ascii?Q?5d5OYDcilitzcMunyuwAR6L2WLSedKS3R/ket6sw9M4KzU5NsgolgNXZ1v6z?=
 =?us-ascii?Q?YnaRVysHdKFc0Kg3a3ZV0NuLZw7L7QP/0nCdygYJ+cIRmAn0Z63W3IqLK5Yt?=
 =?us-ascii?Q?OvJoD06ES1tEtoRKr7i4jCJc0EQ5YpoD15QMC+F5B5vo1NgPf02/Fwq1Qwar?=
 =?us-ascii?Q?E25mi11PP2sTUAJu9ugXfgobbayJMXv5HTR2cwVvpdQR4TdbJkMqqw+szpKS?=
 =?us-ascii?Q?BY0m42MjQtc4BH4yCkoCEj4BgwLpxIQ=3D?=
X-Exchange-RoutingPolicyChecked: KLmyM9D3Ddboq6MZo756EjLiFcvDrIcHEzLiiOn2vSREpIHQs8PXXk/Oi9woDV+IfftwGUeao+viuED74ZagiIiYQylbxgr6yTy65CcGYS2Ubco7gzekz8qp4OLFz+3jSkt4+SVevN6mxQwnhrjNkCoogXYVJBWyPpLZddGX7O/si8TTT7L7QT3/SvEqisY3Yye4vi83WHXKfSEHzBSlq+KmkZjXuaqLKvc5F9PxJvP2cEpPS/AiXkpIrJXuHf6bZ+kBxxq6SIXZ2t07igmKoBNdgbk/e39r4wB8sDLKY+EXXor3oZhxCb+sA45HaIjvigH5LYedEDMoC4/SaeggkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b7b98a-2cb0-4b16-82eb-08df2bbbf173
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:30:32.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5UbXUFCqmh/EIJbF08wsMKQzw5aOC+aJpcCw+9LYyytKWONw7MIEHpyCckp3oAMYN8GzQ80m988c82YCwPHA2TgXRRSNgsf5U7nS8ap5fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8306
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

On Fri, Oct 16, 2026 at 03:31:02AM +0000, Jia Yao wrote:
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed. The register is not
> context-saved by hardware, so the value is programmed on context switch
> via the indirect context batchbuffer, and the old unconditional write in
> intel_workarounds.c is removed.
> 
> LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines, not per-context
> state, and GuC only runs RCS and CCS concurrently when they share an
> address space, i.e. belong to the same DRM client. Tracking the opt-out
> per client is therefore both necessary and sufficient to avoid the race.
> The value is latched once, by whichever comes first between an explicit
> CONTEXT_CREATE_EXT_SETPARAM and the first context of the client being
> submitted, and a later request for the opposite value gets -EINVAL; this
> covers the default context (id 0) and needs no new ioctl. The client is
> the unit of consistency, not the register's true isolation boundary:
> unrelated clients can still override each other on RCS and CCS, which is
> unchanged from current behaviour.
> 
> v13:
> - Reject any value other than 0 or 1 with -EINVAL, instead of silently
>   treating any non-zero value the same as 1, so other values remain
>   available to give explicit meaning to in the future (Matt)
> - Drop the v11 ctx_setparam() support for
>   I915_CONTEXT_PARAM_WA_22013059131 added by Sashiko for context 0
>   coverage. The parameter is creation-time only and current
>   compute-runtime usage relies solely on CONTEXT_CREATE_EXT_SETPARAM.
>   Retain getparam() support. (Matt)
> - Rename I915_WA_22013059131_{UNSET,KERNEL,USERSPACE} to
>   I915_WA_22013059131_CLIENT_{UNSET,KERNEL,USERSPACE} to distinguish them
>   from the CONTEXT_WA_22013059131_APPLY context flag (Matt)
> 
> v12:
> - Don't dereference ce->gem_context / ctx->client from lrc_update_regs(),
>   which also runs from reset paths (guc_reset_state(), lrc_reset()) where
>   the ctx lifetime is not guaranteed by the caller. Latch the decision
>   once into CONTEXT_WA_22013059131_APPLY from
>   intel_context_alloc_state(), where the pinner holds a ctx reference,
>   and only sample that bit afterwards (Sashiko)
> 
> v11:
> - Add the missing I915_CONTEXT_PARAM_WA_22013059131 cases to
>   ctx_setparam() and i915_gem_context_getparam_ioctl(), so the
>   parameter can also be set on an already-finalized context (e.g. the
>   default context, id 0) and queried back, not just set at proto-context
>   creation time (Sashiko)
> 
> v10:
> - Move the opt-out from intel_context to i915_drm_client, latched once
>   per client (by explicit setparam or first LRC init) instead of tracked
>   per intel_context, so all contexts of a client - including the
>   default context - always agree and conflicting requests get -EINVAL
>   (Joonas, Sashiko, Matt)
> - Note that GuC's requirement for RCS/CCS contexts to share an address
>   space before running concurrently is what makes client-wide latching
>   sufficient to prevent the race (Matt)
> - Document that this requirement applies to the whole fd, so userspace
>   sharing an fd across an interop boundary must coordinate ordering
>   itself
> 
> v9:
> - Restrict Wa_22013059131 to compute engine only in
>   gen12_emit_indirect_ctx_xcs() (Sashiko)
> 
> v8:
> - Clarify in the uAPI comment that setting this parameter only opts out
>   of LSC_CHICKEN_BIT_0 bit 15 (FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
>   LSC_CHICKEN_BIT_0_UDW MAXREQS_PER_BANK remains unconditionally
>   programmed by the kernel as the other part of Wa_22013059131
> 
> v7:
> - Reject ioctl with -ENODEV on non-DG2-G11 platforms
> 
> v6:
> - Remove excessive blank lines
> 
> v5:
> - Remove fix and stable
> 
> v4:
> - Add a link of the userspace using this API
> 
> v3:
> - Kernel-internal context will not change workaround settings
> 
> Bspec: 54833
> Link: https://github.com/intel/compute-runtime/pull/919
> Cc: dri-devel@lists.freedesktop.org
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Maciej Plewka <maciej.plewka@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>

It's been a couple years since I worked closely with the i915 code, but
the changes here look okay to me.

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>


Matt

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c   | 53 +++++++++++++++++
>  drivers/gpu/drm/i915/gt/intel_context.c       |  2 +
>  drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
>  drivers/gpu/drm/i915/gt/intel_lrc.c           | 59 ++++++++++++++++++-
>  drivers/gpu/drm/i915/gt/intel_lrc.h           |  3 +
>  drivers/gpu/drm/i915/gt/intel_workarounds.c   | 10 ++--
>  drivers/gpu/drm/i915/i915_drm_client.h        | 57 ++++++++++++++++++
>  include/uapi/drm/i915_drm.h                   | 25 ++++++++
>  8 files changed, 204 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 6ac0f23570f3..c2d70fbde7d3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -874,6 +874,39 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>  	return 0;
>  }
>  
> +/*
> + * Wa_22013059131:dg2 - Latch who owns LSC_CHICKEN_BIT_0 bit 15 for every
> + * context of @fpriv.  The register is shared by the RCS and CCS engines, so
> + * the first context to express a preference decides for the whole client
> + * and any later context asking for the opposite is rejected, rather than
> + * letting the two race over the register at context-switch time.
> + *
> + * The owner is also latched, to the kernel, the first time a context of
> + * the client is pinned (see lrc_latch_wa_22013059131()), so opting out is
> + * only possible while none of the client's RCS/CCS contexts has run yet.
> + */
> +static int set_client_wa_22013059131(struct drm_i915_file_private *fpriv,
> +				     u64 value)
> +{
> +	int want;
> +
> +	/*
> +	 * Only 0 and 1 are currently defined; reject anything else now so
> +	 * that other values remain available to give explicit meaning to in
> +	 * the future, rather than silently treating them as 1 today.
> +	 */
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	want = value ? I915_WA_22013059131_CLIENT_USERSPACE :
> +		      I915_WA_22013059131_CLIENT_KERNEL;
> +
> +	if (i915_drm_client_latch_wa_22013059131(fpriv->client, want) != want)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>  			       struct i915_gem_proto_context *pc,
>  			       struct drm_i915_gem_context_param *args)
> @@ -911,6 +944,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
>  			ret = -EINVAL;
>  		break;
>  
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (args->size)
> +			ret = -EINVAL;
> +		else if (!IS_DG2_G11(i915))
> +			ret = -ENODEV;
> +		else
> +			ret = set_client_wa_22013059131(fpriv, args->value);
> +		break;
> +
>  	case I915_CONTEXT_PARAM_RECOVERABLE:
>  		if (args->size)
>  			ret = -EINVAL;
> @@ -2249,6 +2291,7 @@ static int ctx_setparam(struct drm_i915_file_private *fpriv,
>  	case I915_CONTEXT_PARAM_RINGSIZE:
>  	case I915_CONTEXT_PARAM_VM:
>  	case I915_CONTEXT_PARAM_ENGINES:
> +	case I915_CONTEXT_PARAM_WA_22013059131: /* creation-time only */
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -2583,6 +2626,16 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
>  		ret = get_protected(ctx, args);
>  		break;
>  
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (!IS_DG2_G11(ctx->i915)) {
> +			ret = -ENODEV;
> +		} else {
> +			args->size = 0;
> +			args->value = atomic_read(&file_priv->client->wa_22013059131_owner) ==
> +				      I915_WA_22013059131_CLIENT_USERSPACE;
> +		}
> +		break;
> +
>  	case I915_CONTEXT_PARAM_NO_ZEROMAP:
>  	case I915_CONTEXT_PARAM_BAN_PERIOD:
>  	case I915_CONTEXT_PARAM_ENGINES:
> diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
> index b1b8695ba7c9..dc1b69631046 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context.c
> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
> @@ -13,6 +13,7 @@
>  #include "intel_context.h"
>  #include "intel_engine.h"
>  #include "intel_engine_pm.h"
> +#include "intel_lrc.h"
>  #include "intel_ring.h"
>  
>  static struct kmem_cache *slab_ce;
> @@ -80,6 +81,7 @@ int intel_context_alloc_state(struct intel_context *ce)
>  			if (ctx->client)
>  				i915_drm_client_add_context_objects(ctx->client,
>  								    ce);
> +			lrc_latch_wa_22013059131(ce, ctx);
>  			i915_gem_context_put(ctx);
>  		}
>  	}
> diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
> index 10070ee4d74c..928eab48f38d 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context_types.h
> +++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
> @@ -133,6 +133,7 @@ struct intel_context {
>  #define CONTEXT_EXITING			13
>  #define CONTEXT_LOW_LATENCY		14
>  #define CONTEXT_OWN_STATE		15
> +#define CONTEXT_WA_22013059131_APPLY	16 /* see lrc_latch_wa_22013059131() */
>  
>  	struct {
>  		u64 timeout_us;
> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
> index 147d22907960..c94b7e3d3980 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
> @@ -5,9 +5,11 @@
>  
>  #include <drm/drm_print.h>
>  
> +#include "gem/i915_gem_context.h"
>  #include "gem/i915_gem_lmem.h"
>  
>  #include "gen8_engine_cs.h"
> +#include "i915_drm_client.h"
>  #include "i915_drv.h"
>  #include "i915_perf.h"
>  #include "i915_reg.h"
> @@ -1348,6 +1350,50 @@ gen12_invalidate_state_cache(u32 *cs)
>  	return cs;
>  }
>  
> +/* Latched on first pin while the pinner holds a ctx ref; see intel_context_alloc_state(). */
> +void lrc_latch_wa_22013059131(struct intel_context *ce,
> +			      struct i915_gem_context *ctx)
> +{
> +	int owner;
> +
> +	if (!IS_DG2_G11(ce->engine->i915))
> +		return;
> +
> +	/* Only RCS and CCS ever emit this workaround; don't latch for others. */
> +	if (ce->engine->class != RENDER_CLASS && ce->engine->class != COMPUTE_CLASS)
> +		return;
> +
> +	owner = I915_WA_22013059131_CLIENT_KERNEL;
> +	if (ctx->client)
> +		owner = i915_drm_client_latch_wa_22013059131(ctx->client, owner);
> +
> +	if (owner != I915_WA_22013059131_CLIENT_USERSPACE)
> +		set_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags);
> +}
> +
> +static u32 *
> +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
> +{
> +	/*
> +	 * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
> +	 * other bits of the register will also get overwritten.  The
> +	 * hardware default for all other bits is 0, but any workarounds
> +	 * that adjust the other bits in the lower dword of the register
> +	 * also need to be re-applied here.  At the moment that's just
> +	 * Wa_22014226127, which is always set for DG2-G11 platforms.
> +	 */
> +	u32 val = DISABLE_D8_D16_COASLESCE;
> +
> +	if (test_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags))
> +		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
> +
> +	*cs++ = MI_LOAD_REGISTER_IMM(1);
> +	*cs++ = i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
> +	*cs++ = val;
> +
> +	return cs;
> +}
> +
>  static u32 *
>  gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
>  {
> @@ -1371,6 +1417,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
>  	    IS_DG2(ce->engine->i915))
>  		cs = dg2_emit_draw_watermark_setting(cs);
>  
> +	/* Wa_22013059131:dg2 */
> +	if (IS_DG2_G11(ce->engine->i915))
> +		cs = dg2_g11_emit_wa_22013059131(ce, cs);
> +
>  	return cs;
>  }
>  
> @@ -1387,7 +1437,14 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
>  						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
>  						    0);
>  
> -	return gen12_emit_aux_table_inv(ce->engine, cs);
> +	cs = gen12_emit_aux_table_inv(ce->engine, cs);
> +
> +	/* Wa_22013059131:dg2 */
> +	if (IS_DG2_G11(ce->engine->i915))
> +		if (ce->engine->class == COMPUTE_CLASS)
> +			cs = dg2_g11_emit_wa_22013059131(ce, cs);
> +
> +	return cs;
>  }
>  
>  static u32 *xehp_emit_fastcolor_blt_wabb(const struct intel_context *ce, u32 *cs)
> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.h b/drivers/gpu/drm/i915/gt/intel_lrc.h
> index 7111bae759f3..cc204ac2d7bf 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.h
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.h
> @@ -14,6 +14,7 @@
>  #include "intel_context.h"
>  
>  struct drm_i915_gem_object;
> +struct i915_gem_context;
>  struct i915_gem_ww_ctx;
>  struct intel_engine_cs;
>  struct intel_ring;
> @@ -35,6 +36,8 @@ void lrc_fini_wa_ctx(struct intel_engine_cs *engine);
>  
>  int lrc_alloc(struct intel_context *ce,
>  	      struct intel_engine_cs *engine);
> +void lrc_latch_wa_22013059131(struct intel_context *ce,
> +			      struct i915_gem_context *ctx);
>  void lrc_reset(struct intel_context *ce);
>  void lrc_fini(struct intel_context *ce);
>  void lrc_destroy(struct kref *kref);
> diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> index 24ea5d8d529c..ef6eea3ab597 100644
> --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> @@ -2840,7 +2840,11 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
>  	if (IS_GFX_GT_IP_STEP(gt, IP_VER(12, 70), STEP_A0, STEP_B0) ||
>  	    IS_GFX_GT_IP_STEP(gt, IP_VER(12, 71), STEP_A0, STEP_B0) ||
>  	    IS_DG2(i915)) {
> -		/* Wa_22014226127 */
> +		/*
> +		 * Wa_22014226127: Note that this workaround also needs to be
> +		 * re-applied in intel_lrc.c when LSC_CHICKEN_BIT_0 is
> +		 * re-written for Wa_22013059131.
> +		 */
>  		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0, DISABLE_D8_D16_COASLESCE);
>  	}
>  
> @@ -2867,10 +2871,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
>  				     MAXREQS_PER_BANK,
>  				     REG_FIELD_PREP(MAXREQS_PER_BANK, 2));
>  
> -		/* Wa_22013059131:dg2 */
> -		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0,
> -				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
> -
>  		/*
>  		 * Wa_22012654132
>  		 *
> diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
> index 2e7a50d16a88..684a66bcd71f 100644
> --- a/drivers/gpu/drm/i915/i915_drm_client.h
> +++ b/drivers/gpu/drm/i915/i915_drm_client.h
> @@ -45,8 +45,65 @@ struct i915_drm_client {
>  	 * @past_runtime: Accumulation of pphwsp runtimes from closed contexts.
>  	 */
>  	atomic64_t past_runtime[I915_LAST_UABI_ENGINE_CLASS + 1];
> +
> +	/**
> +	 * @wa_22013059131_owner: Who programs Wa_22013059131 for this client.
> +	 *
> +	 * One of the I915_WA_22013059131_* values below.  Latched once, on
> +	 * the first of either I915_CONTEXT_PARAM_WA_22013059131 being set or
> +	 * a context of this client being pinned for the first time
> +	 * (intel_context_alloc_state(), which holds ce->pin_mutex and a
> +	 * reference on the context), and read-only afterwards.  See
> +	 * i915_drm_client_latch_wa_22013059131().
> +	 */
> +	atomic_t wa_22013059131_owner;
>  };
>  
> +/*
> + * Wa_22013059131:dg2 - who programs LSC_CHICKEN_BIT_0's
> + * FORCE_1_SUB_MESSAGE_PER_FRAGMENT bit for the contexts of a client.
> + *
> + * LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines rather than being
> + * part of the saved context image, so it cannot be tracked per context.
> + * GuC only lets RCS and CCS run concurrently when their contexts share an
> + * address space, so tracking this per DRM client (which forces every
> + * address space of that client to agree) is sufficient to avoid contexts
> + * that could actually run at the same time racing over the register.
> + *
> + * I915_WA_22013059131_CLIENT_UNSET must be 0 as the client is zero-initialised.
> + */
> +#define I915_WA_22013059131_CLIENT_UNSET	0
> +#define I915_WA_22013059131_CLIENT_KERNEL	1
> +#define I915_WA_22013059131_CLIENT_USERSPACE	2
> +
> +/**
> + * i915_drm_client_latch_wa_22013059131 - Latch Wa_22013059131 ownership
> + * @client: the DRM client
> + * @want: I915_WA_22013059131_CLIENT_KERNEL or I915_WA_22013059131_CLIENT_USERSPACE
> + *
> + * Claim @want as the owner of Wa_22013059131 for @client, unless an owner
> + * has already been latched.  Callers that must not change the owner pass
> + * the value they rely on and compare it against the return value.
> + *
> + * The value is latched with a single cmpxchg so that no extra locking is
> + * needed.  This matters because the callers run with different locks held:
> + * GEM_CONTEXT_CREATE_EXT_SETPARAM does not hold &proto_context_lock, while
> + * GEM_CONTEXT_SETPARAM does, and intel_context_alloc_state() holds
> + * ce->pin_mutex instead.
> + *
> + * Returns: the owner in effect for @client, never I915_WA_22013059131_CLIENT_UNSET.
> + */
> +static inline int
> +i915_drm_client_latch_wa_22013059131(struct i915_drm_client *client, int want)
> +{
> +	int owner;
> +
> +	owner = atomic_cmpxchg(&client->wa_22013059131_owner,
> +			       I915_WA_22013059131_CLIENT_UNSET, want);
> +
> +	return owner == I915_WA_22013059131_CLIENT_UNSET ? want : owner;
> +}
> +
>  static inline struct i915_drm_client *
>  i915_drm_client_get(struct i915_drm_client *client)
>  {
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 535cb68fdb5c..94553daec4a2 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -2172,6 +2172,31 @@ struct drm_i915_gem_context_param {
>   * Note that this is a debug API not available on production kernel builds.
>   */
>  #define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
> +
> +/*
> + * I915_CONTEXT_PARAM_WA_22013059131:
> + *
> + * Default value 0 means the kernel sets LSC_CHICKEN_BIT_0 bit 15
> + * (FORCE_1_SUB_MESSAGE_PER_FRAGMENT) as part of Wa_22013059131.  Set to 1
> + * to inform the kernel that userspace is handling the SLM contention
> + * workaround itself (e.g. by limiting SLM size), so bit 15 programming is
> + * not needed.  Only 0 and 1 are valid; any other value is rejected with
> + * -EINVAL.
> + *
> + * LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines, so this setting
> + * takes effect for every context of the calling DRM client (the whole file
> + * descriptor), not just the context the ioctl is issued on.  It is latched
> + * once, by whichever comes first: an explicit call to this parameter, or
> + * any context of the client being submitted for the first time.  A later
> + * request for the opposite value fails with -EINVAL.  Userspace that wants
> + * to opt out must therefore do so before submitting any work on this fd,
> + * including via the default context (id 0) created on open().
> + *
> + * Note: LSC_CHICKEN_BIT_0_UDW MAXREQS_PER_BANK (bits 39:37) is the
> + * other part of Wa_22013059131 and remains unconditionally programmed
> + * by the kernel regardless of this setting.  DG2-G11 only.
> + */
> +#define I915_CONTEXT_PARAM_WA_22013059131	0x10
>  /* Must be kept compact -- no holes and well documented */
>  
>  	/** @value: Context parameter value to be set or queried */
> -- 
> 2.43.0
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
