Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E37C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023EA10F11E;
	Thu, 20 Aug 2026 17:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bk8v5E4S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B186110F10D;
 Thu, 20 Aug 2026 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787245425; x=1818781425;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lLLsRxIJUnha2ZimKaN37ZUsih96ZNZLb6IF5sbaGag=;
 b=Bk8v5E4SDkbJv5QLtH60DKZUDGMfaPHEAxRQ6zu6CLXFgh4/k22+Al9C
 aw+Rj1xhnC/o4D50DfXsnspbhtzMgvN2JYYxps1UfdM9bzIe2iJ3CSHzR
 1hdfVj5UKSOnMRug600LeTR3ubh+WeAMLWYbc9UDyim8V6fYOgJKXqmr5
 zWFHJfxKP0rulE6SZBlyFLN9ArMqyZXfyGbSVGq02JeBAQ2xx/DCp7JBd
 dOtYK1CYqFKDlsSmAkVjxwjzmrTCLhlWeFKr6c5eS4hsSG7oP2zzp5KJp
 LMLuyWEK+FXEn7HWoqKEGQE2Efbpaj+qBUf88TQV0TrIVpeSra/X+Isva Q==;
X-CSE-ConnectionGUID: Ygqjogj2Q8a9XYhO35KnYw==
X-CSE-MsgGUID: PxiO94RiTo+sGy6P/Ndlyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87992452"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87992452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 10:03:45 -0700
X-CSE-ConnectionGUID: Jc9HSMfBR7yNDnYLdk6apw==
X-CSE-MsgGUID: BsY46v/eSYuyZwrpLJsSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="270337169"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 10:03:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 10:03:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 10:03:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 10:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWq/8t7wF9BC1hwYSYQ9jgQEqTq5BpSvMIsiik8o5rI7CsFUwcXex4rg/C52esl8xjeX0wJ2e9x3xK7+XO2UiJWL7lxP5PXXEgolQa9gLg4HfWp6klq3KegIP6mpd5DWN7HLjBkwxKdmJAmcR8srxOPIRnBWBQO3OSkbPtUFe4N7gDPWdX9UdWFoNyqjBo93w4xST4Jue+8jAQMHtr8/vswheQiOq9ZgjIO8LaIr8JpxWKqnfTVzN/uEHBhL2pp2XkhRoX+V/heD4P7GJRSEQBGugSiJmmDjBvdUtNslIvvChjSrvBsNQ3OFORaZRd3GK0IeUN7JMq4CE/lO8wmxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RQjLohIXXIV9ih8YqqCnJ8WVCgx0XX+U4lPAFvAcj0=;
 b=RokXtZ7ZJl2XSLZG+SYSjXEDkUtC+SbiqezbiRcAleOi8b5VjJPiTrtsEyjY4zQWDz1HlBtkQLz0exiagYagvb73aK+o5kwhS30x/1V/QzqD23iatjhLVtcKPJntvj6WY2AwaooWzWAHOQOoqXktCEuuXsUM4Ar54DmfJ0/ExI5x7mAN4NGUkvXYZjLe6RP9CvVdadOILu9ENbFWRZAD3xlTKeKXO4K07Dbw6zbJPUxgjrjQmb2zcDUTw5lhfBdcbkhVOa8hgFSUySYMvzutwZRZIibB+jAu5qLUDLZfvhFGaSa/Ufq9Tkx3IbDRYxXwAFt+82BVEuJ3AFogyX0iSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CYYPR11MB8359.namprd11.prod.outlook.com (2603:10b6:930:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 17:03:39 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 17:03:39 +0000
Date: Thu, 20 Aug 2026 10:03:36 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Nathan Bourgeois <iridescentrosesfall@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
Message-ID: <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CYYPR11MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 94722138-8879-4e09-49b8-08defedcfb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: GtXdGcdddL+SU8WS+s8apgxmaRKjOzCTSWiZWsSbbtJpKmzxe1nqAHrXrZSEpw+bnWKQmPiU9CpYEbPEmBgYPpv7ZHn+kT3FKdMEOU+A3SxLfeGlqkCYWqK8/cLcEDyt0c4jX3enxw5TR+L5NpzG3X/YF6WpH58cVtppq0oXduVMMV+aWTwLt9Vyq6aGDlpyDwawyiZia55CuBcsm0d+miaNCfVb9Ztxd8Dh1dVfIb+2Yi4IZpPGbDDyn6zZGDYsua+4q128uFYxis7G+7qJMLRMU8FYlIF6ZG2BDZ4RvRiVbpdIVISBMspzUwAnJRcFA485sKI9olmFC9z0Umc4nIrJ5XA+dG2tT1jrvpADFFA9DhdVZ6ETru7jigagRpKhdsCh3cPY+f/7R3+4PWQo/nhbYZSW8TxjhmwPhEEHQxiZyXQ7ary4F7dXST6sPewW9NWvIgjfVAOcaiXcM7po9jyqY8950tH1fxGSr82KItPxlAiRgoYebhnAeU0NtdAehiHgG8ySBqXAh+xWxlj9mCQ4g8T9BGlbsku5D0clPYVqkcgfzTrXcxfvOJ9uPJ9Cw5T7zzgXODwv+azP3uVxEatxz7wnTVtI5cqWULnb9m8f99+3Vdydz+3nTrUwEiTw4Sl38ENh+w57n33GM6bhh4o2m6lbjkSXYM1krRqj2b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4HDjF1t/qRX9mRc9jCp9KfQmhYVHT3OLrs4czDF72abEn4EQqiL9gTQs62Jv?=
 =?us-ascii?Q?Ct94zwcw4ZbSMZi1cFYyyxyhsydjwDhcejdBpPG99VtP7by+GwB3IHooTjBA?=
 =?us-ascii?Q?gNk22yBIR85bbupZUd9KoF+WOo76y6qdVKfIT+wMNBKYB0EUjWmgqsq+SC3q?=
 =?us-ascii?Q?IelIxhvgJsMDnVDmSL87jrytOzjJ/8lxAX/aiU4ukl8ENwdR3Dqx26YiAZqn?=
 =?us-ascii?Q?D/WsVg3t0yoUaEjq81nommVWBjZsoKFpe6L3Q6f0WmDDTJ66Epe6f68tIuD7?=
 =?us-ascii?Q?nqHpTZfY8n67tkKsRCAXI/p7ka9pYe6AozydBFvCvIxBTa3OCr+9F84V8Q7U?=
 =?us-ascii?Q?Iz+7VZfMP9na7d6DJe1ryOY0X5dZ9caaJTFB1TdIw8ui03UoDNk6SVHR/b6c?=
 =?us-ascii?Q?6qnV/CSOpnIXhZPOesUIE9dxmnl62R1cabudOcu7YeO6Ww/2yRnFwicOZtyb?=
 =?us-ascii?Q?QDokc/VKULHF1M/+4wQIca95lCp7eQyyawJPdIOPy6wz0PxtW66J7PmquILl?=
 =?us-ascii?Q?XvnGTAaDJHpU3VU4AGk5bG0iNNcIxP752Mu5QiShvk6EiHYpzt/8T0JPmfn+?=
 =?us-ascii?Q?3pkpBa6d9pzdYTAflIf40sv0QpgDbs1H3Tc8zai/vciIfBws38BW61+3E1B+?=
 =?us-ascii?Q?pAEgd4leRX8DWm8pWW6H2+lr5H+GncAWBm72+exm8KGjcNDioCEaUCVJ3y/4?=
 =?us-ascii?Q?6LttNuGTUFhj7CvCnPSBvU+XfoLzm10/po/NLHP6SVKRtuj24DMAVYuSw0lI?=
 =?us-ascii?Q?vcHUuCg5753J14bEiax5bUifPKRCH/YhMhAEJjNw6cajuSkc3Ep7aKkAW7LA?=
 =?us-ascii?Q?5Wze60tYUW0hTVod4zwjN8oQlLnHOGt1vBkS6Y3Ni3iNj41NnBzCkW765b1d?=
 =?us-ascii?Q?c2hWE59gOh6QtPXUV/TgP4gjjNEszMh4jjILLBzkfOYNWMjwWeBT1/setxgt?=
 =?us-ascii?Q?hSsLqZuQPqm9GtDhMkX2/DtLQO/qyR+KfWToqAiUEn8akKR03IE7AdvPh0yO?=
 =?us-ascii?Q?aDpy4xLU9DIERfuASLE9pqIZX48wCnclzYhJFKF9YPv5p5/QZhat7k9c4pKz?=
 =?us-ascii?Q?6T0bnMSc41EnHG62+C3pOXr4neRiwMztXdZmjcaRHG16DtQ9OFA7euJ8g69d?=
 =?us-ascii?Q?r9fKUYOX0wKYlGpxO7CIlKaxN37qsUBTjieZToi6uEmxnSmardjeCX7Sa4Od?=
 =?us-ascii?Q?OqLwYM9Cp1ATeuTJr2CxVXBYy57C29/SAUBs28O1VWxr0bcxVQaOpy/jEJaL?=
 =?us-ascii?Q?cyo6swKhwIjpq73kZSfHimf9HZ4QuH1TtbOqw7z4sC3G61CjfI91zViSEF3V?=
 =?us-ascii?Q?DEiBHMis/nmJbP+Vku/mUQyeSyWxipZSFVnkuqi3gKN6VhKq+Bb3yWiBXi85?=
 =?us-ascii?Q?IA0hD0XrpYz6xzSSgsDPTMYIQWlNumrPz6Vw9wmDT8Q1Gy48yXX7BOYdvyCI?=
 =?us-ascii?Q?/MuxubdEH4BD7VAUlLSaQlLrBQXl8aAflh4J+aNJ6GHg71Ny2CLox7cSeJrM?=
 =?us-ascii?Q?BZcZM0iVhzs5CXekZWZ5SBSAay5KeUQEJoubPBlAnjuYUM6uQfvy9BN+fsKv?=
 =?us-ascii?Q?HmodB8PQGZSkUcoyDn+tg1NFTlSwjKBJtqYqdiO5NEY8XxqnaxIVXwtwL2Oe?=
 =?us-ascii?Q?n5ofcRs+0MW/0AQJcSMEUhU0ydw8+V71DQjvSUhrc6qY3RzPTg2+JXw0p5Qi?=
 =?us-ascii?Q?73QLclkHjTj1IQdDkTNQzhm/yhwYNA/9G7u3kdzXYV7H9TE3CVo0qzczvprY?=
 =?us-ascii?Q?xsv5MUaDbPDovI68X38xbi+X+cx+naM=3D?=
X-Exchange-RoutingPolicyChecked: stjwSemRYUhr2whD8oLDuM4AEymeNEy2d877l63wmsrB5iOOFCKrthvZXg2oIrnTckfft4d6hDVD7DRZ9gc/Im3izTYnULfQ+qqjRv+VAw5xzaiNoJEsK9a33HBnWrrSt47ZhtlDOXag2m7wv/chglvnrWEFKTQtnwwz9ukobtDbrg5ozsV8VagoHdkca/pGj8VeV0RoPLG4gJ/wtM+1b6H9yKUnBTHvzSBioOlQzmf+t4LheGG12k+910IhWp8D6HdTE52mnE65s3DcNKKX/Izud0z4iI0LByDtUOVNJJVfnxwJdgBXRVOSMW6nQbuZh1vQkhF9mAEWCyiMuwNbJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94722138-8879-4e09-49b8-08defedcfb2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:03:39.5009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoWA/0UXQJhbtq8UmeurScUIxpQQBnih5jcb9pq1BITd/FgYlfEtetmbXaKXv0z+TLdcBwx9MlO9t6TnAyt1dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8359
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

On Wed, Aug 19, 2026 at 11:19:01PM -0400, Nathan Bourgeois wrote:

Thanks the patch.

> When a buffer object (BO) has a created but unpopulated ttm_tt and is
> exported, the default behavior populates the ttm_tt, even if the manager
> does not require a TT. This unnecessary host-side population reduces
> host memory available to the user.
> 
> This occurs when a BO is created with XE_BO_FLAG_DEFER_BACKING and
> migration places the BO into a resource whose manager does not use the
> TT backing. The retained ttm_tt is not authoritative for storage, yet
> the default ttm_bo_setup_export() treats the existence of the ttm_tt as
> requiring population.
> 

Thanks for explaining this, I see the problem.

> The issue was reproduced with vLLM 0.27.1 loading
> 0xSer0/DeepSeek-V4-Flash-180B (d3c704b) on a system with 128 GB of RAM
> and six Intel Arc Pro B70 GPUs providing 192 GB of VRAM. Loading the
> weights (100.61 GB) triggered host-memory exhaustion and OOM events on
> the baseline kernel.
> 
> On Ubuntu 24.04 with 7.0-12-generic, the vLLM service cgroup grew by
> 115.84 GB on the instrumented baseline and by 15.34 GB with this change,
> a reduction of 100.50 GB. Diagnostic instrumentation counting cumulative
> TT pages across all six GPUs recorded 109.22 GB on baseline and 8.72 GB
> with this change. The reduction is 0.11 GB less than the model weight
> size.
> 
> The change creates an Xe-local export setup helper which skips
> ttm_bo_populate() when the BO has a current resource manager and if that
> manager has use_tt == false. If the manager does not use TT, then
> population is skipped, while an absent manager conservatively calls
> ttm_bo_populate(). Behavior for a manager which requires a TT backing
> remains unchanged. Keep this policy local to Xe so other TTM drivers
> retain their existing export behavior.
> 

Reading the commit which added ttm_bo_setup_export, to me this looks
like a bug in ttm_bo_setup_export() or in general TTM.

git format-patch -1 50243079865ae

'This only applies currently to TTM_PL_SYSTEM objects, because
GTT objects get populated on first validate, and VRAM doesn't
use TT.'

I'd probably move this fix into ttm_bo_setup_export() and post it for
discussion.

It may also be the case that the ttm_tt preallocated with
XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to VRAM, as
that dangling ttm_tt could cause other issues. I'll need to take a
closer look at that angle.

> The regression test creates both the control case and the VRAM migration
> case. The control case creates the deferred BO in system RAM and leaves
> it there, which requires a TT and population when xe_gem_prime_export() is
> called. The VRAM migration case creates the deferred BO in system RAM
> and then migrates it to VRAM, which does not require a TT and thus, when
> xe_gem_prime_export() is called, no population occurs.
>

This part looks good as different patch from what I'm assuming will be a
TTM fix.

Matt

> Fixes: 91494dee1091 ("xe: populate buffers before exporting them.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Nathan Bourgeois <iridescentrosesfall@gmail.com>
> ---
> Newer Testing:
> - Built and booted b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6 plus this patch on EPYC 7352 with six Intel Arc Pro B70.
> - KUnit xe_live_test: xe_dma_buf_kunit: pass:6 fail:0 skip:0 total:6 PASS
> - vLLM 0.27.1 loading DeepSeek-V4-Flash-0731 (full model compared to REAP) on six Intel Arc Pro B70 GPUs: No OOM error, 17.82 GB delta.
>  drivers/gpu/drm/xe/tests/xe_dma_buf.c | 105 ++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_dma_buf.c       |  28 ++++++-
>  2 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> index 0be8440b3976..bff803ab7a57 100644
> --- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> @@ -260,12 +260,117 @@ static const struct dma_buf_test_params test_params[] = {
>  	{}
>  };
>  
> +static void xe_test_dmabuf_export_deferred(struct xe_device *xe, u32 bo_flags,
> +					   u32 mem_type, bool expect_populated)
> +{
> +	struct drm_exec *exec = XE_VALIDATION_OPT_OUT;
> +	struct kunit *test = kunit_get_current_test();
> +	struct ttm_resource_manager *man;
> +	struct dma_buf *dmabuf;
> +	struct xe_bo *bo;
> +	size_t size = PAGE_SIZE;
> +	int err;
> +
> +	/* No VRAM on device? */
> +	if (!ttm_manager_type(&xe->ttm, mem_type))
> +		return;
> +
> +	if (mem_type == XE_PL_VRAM0 &&
> +	    xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
> +		size = SZ_64K;
> +
> +	/*
> +	 * DEFER_BACKING places the BO in SYSTEM and creates a ttm_tt which
> +	 * is unpopulated. In the case of VRAM, migrating leaves the ttm_tt
> +	 * retained and unpopulated while VRAM becomes the real backing.
> +	 */
> +	bo = xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_WC,
> +			       bo_flags | XE_BO_FLAG_DEFER_BACKING, NULL);
> +	if (IS_ERR(bo)) {
> +		KUNIT_FAIL(test, "BO creation failed: %pe\n", bo);
> +		return;
> +	}
> +
> +	err = xe_bo_lock(bo, false);
> +	if (err) {
> +		KUNIT_FAIL(test, "BO lock failed: %d\n", err);
> +		goto out_put_bo;
> +	}
> +
> +	if (bo->ttm.resource->mem_type != mem_type)
> +		err = xe_bo_migrate(bo, mem_type, NULL, exec);
> +	if (err) {
> +		KUNIT_FAIL(test, "BO migration to %u failed: %d\n", mem_type,
> +			   err);
> +		goto out_unlock;
> +	}
> +
> +	man = ttm_manager_type(bo->ttm.bdev, bo->ttm.resource->mem_type);
> +	if (!man || !bo->ttm.ttm) {
> +		KUNIT_FAIL(test, "Expected a retained unpopulated TT\n");
> +		goto out_unlock;
> +	}
> +
> +	/* Precondition: ttm_tt starts unpopulated after migration */
> +	KUNIT_EXPECT_EQ(test, man->use_tt, expect_populated);
> +	KUNIT_EXPECT_FALSE(test, ttm_tt_is_populated(bo->ttm.ttm));
> +
> +	xe_bo_unlock(bo);
> +
> +	dmabuf = xe_gem_prime_export(&bo->ttm.base, 0);
> +	if (IS_ERR(dmabuf)) {
> +		KUNIT_FAIL(test, "dma-buf export failed: %pe\n", dmabuf);
> +		goto out_put_bo;
> +	}
> +
> +	err = xe_bo_lock(bo, false);
> +	if (err) {
> +		KUNIT_FAIL(test, "post-export BO lock failed: %d\n", err);
> +		goto out_put_dmabuf;
> +	}
> +
> +	/* Postcondition: if VRAM, ttm_tt remains unpopulated, if SYSTEM ttm_tt is populated */
> +	KUNIT_EXPECT_EQ(test, bo->ttm.resource->mem_type, mem_type);
> +	KUNIT_EXPECT_NOT_NULL(test, bo->ttm.ttm);
> +	if (bo->ttm.ttm)
> +		KUNIT_EXPECT_EQ(test, ttm_tt_is_populated(bo->ttm.ttm),
> +				expect_populated);
> +
> +	xe_bo_unlock(bo);
> +	dma_buf_put(dmabuf);
> +	drm_gem_object_put(&bo->ttm.base);
> +	return;
> +
> +out_unlock:
> +	xe_bo_unlock(bo);
> +	goto out_put_bo;
> +out_put_dmabuf:
> +	dma_buf_put(dmabuf);
> +out_put_bo:
> +	drm_gem_object_put(&bo->ttm.base);
> +}
> +
>  static int dma_buf_run_device(struct xe_device *xe)
>  {
>  	const struct dma_buf_test_params *params;
>  	struct kunit *test = kunit_get_current_test();
>  
>  	guard(xe_pm_runtime)(xe);
> +
> +	/*
> +	 * A retained TT must not be populated when VRAM is the backing
> +	 * resource.
> +	 */
> +	xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_VRAM0, XE_PL_VRAM0,
> +				       false);
> +
> +	/*
> +	 * Control case: deferred SYSTEM backing must still be populated
> +	 * before export.
> +	 */
> +	xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_SYSTEM, XE_PL_SYSTEM,
> +				       true);
> +
>  	for (params = test_params; params->mem_mask; ++params) {
>  		struct dma_buf_test_params p = *params;
>  
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index bf0728838ead..0c4e4e2e1a81 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -219,6 +219,32 @@ static const struct dma_buf_ops xe_dmabuf_ops = {
>  	.vunmap = drm_gem_dmabuf_vunmap,
>  };
>  
> +static int xe_dma_bo_setup_export(struct ttm_buffer_object *tbo,
> +				  struct ttm_operation_ctx *ctx)
> +{
> +	struct ttm_resource_manager *man = NULL;
> +	int ret;
> +
> +	ret = ttm_bo_reserve(tbo, false, false, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (tbo->resource)
> +		man = ttm_manager_type(tbo->bdev, tbo->resource->mem_type);
> +
> +	/*
> +	 * Do not populate BO-sized system pages when backed by a non-TT resource.
> +	 * This is Xe-specific; the generic ttm_bo_setup_export() always populates.
> +	 */
> +	if (man && !man->use_tt)
> +		ret = 0;
> +	else
> +		ret = ttm_bo_populate(tbo, ctx);
> +
> +	ttm_bo_unreserve(tbo);
> +	return ret;
> +}
> +
>  struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
>  {
>  	struct xe_bo *bo = gem_to_xe_bo(obj);
> @@ -257,7 +283,7 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
>  	xe_bo_willneed_get_locked(bo);
>  	xe_bo_unlock(bo);
>  
> -	ret = ttm_bo_setup_export(&bo->ttm, &ctx);
> +	ret = xe_dma_bo_setup_export(&bo->ttm, &ctx);
>  	if (ret)
>  		goto out_put;
>  
> 
> base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
> -- 
> 2.55.0
> 
