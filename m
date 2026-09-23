Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B349AC9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7524B10F18E;
	Wed, 23 Sep 2026 20:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CzIA2X8I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D5A10E998;
 Wed, 23 Sep 2026 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790195405; x=1821731405;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6cuNmYJ/ehFDZZtAzTW3NLCKf2IUGS1yldiMyii5eZo=;
 b=CzIA2X8IVzFT4TmZ8In1qMdshv18j81bOXWV8S7UgaqSQi4Z9cSmwzMu
 LwCC+8GwLXhkukNuR49+VZSFstIY1pvvzD9pk/frRmXlLBlEKtqOuTGPZ
 lf25tMouQBQ91u+HIp3tAzkq4wUr7mTVg9HW4XCzgCM98WJJqcPVzdNlz
 2ISH+LzHWnAvKkCuKEwsEmO42fiLFimtoBxVK5GwXtLwYOzpvL5eb7N82
 iEDHks0f+zaYuBrQhS6z17Et0upO6AtB7hQwg87w50M6cGXqsPIUsfCHC
 Sjc5D6W5yej9tqW2VIBYLUPBnwgrTnfEped0Ip7XxwyRFF3+yAgf9i6nx Q==;
X-CSE-ConnectionGUID: 3CeaGECZSgmOH5FzhXJd3g==
X-CSE-MsgGUID: eAeTS/BcTiKSa8V9qq2PsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93435706"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="93435706"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:30:04 -0700
X-CSE-ConnectionGUID: HL7wyfr4Rgq24wTZ65qv1A==
X-CSE-MsgGUID: IB3Xb0oDQ1aIPH4Efy6TtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="281849671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 13:30:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:30:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 13:30:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 13:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuVxqIbHmVuJhIMbNGH2mbSBAqa9PgNhsTSvJuXtsHzBcd2VnPjJO7RgYvNU5SYLbSy+EBnnstk3HQWjLlXRhh+1Y0oGZ8jfQnoxQnnqEyr90LxYxfMDK4wrITI+bcrZgAT31Jf1Svp8/nllFQEsvHORFjVSOLwIV6uG0BLRBivj4WWslZH4Nv5BEUCk4oSu7WJFQeTwD0qGcFA9VYntyaFKDoSkXxYVr6rWm1o24pdbBuvkLH2BeSw5BRmJLaM9th2por7JHluouM22jI2yxrEbJPqrFoDQQ93tqi0aTXuYJsYGSakp3sd94OZRe1jBFrnta/yMNbSPFeTIRzG1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUsm6BfdiUZfKWuxO1mzHzYEMPGzXgMa54srrV/ZqG8=;
 b=zFxrcl49XLs7HoMjl6FX0UMNp86rqilHpy5XWWJ3N44gD9epK/Tpz2xOwKUJZYe0xU+Io9GLc/978RhYl97QJNSm2VmMx5ZUuAMDMYqbpaRaRmPC7UrenEzgYFz6x1zK8FwqyDp0rKyL570IvAFBAGfOIBlY1f+3oJf7jtu63Moebc2q9dDnoMJf50aOv8KjTkj9G3lsWaKu7Sz3m/N1B8CtaPd9A4F+I96Yr0p7bLTnd6djZ8Guflk/Z1I5Zb9MGp3ZX68TLkDHMtXj6Ucc+lGEaCbwkdFCbu0hXC2kFyJUZ+vyEtgHJdnf8VxNejMAwN/lqZWnZdRjE/oirpG55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 20:29:55 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 20:29:54 +0000
Date: Wed, 23 Sep 2026 13:29:52 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: "Yao, Jia" <jia.yao@intel.com>
CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Message-ID: <20260923202952.GA730830@mdroper-desk1.amr.corp.intel.com>
References: <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
 <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179018246485.152778.2589066724213973485@jlahtine-mobl>
 <6e40b68c-bbfa-47b6-81e9-5076738d0abd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e40b68c-bbfa-47b6-81e9-5076738d0abd@intel.com>
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f00474e-293d-4e50-627e-08df19b16d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Z+WweF/tXzoNGGAW+aG+/eid3iJOu9ACUoFfGlSCxq49u7v5lC/jwGWHkn1hb50QjbFoXPZ0MaQJFTGnvOtMt2hQYim/wqkGF3UdeW/mrRfgjSazFazJvWtPNFd78mGcmY/+sje9aPXJy8yoL5bVqsAjmbeByiCSLQytafzOCK30QLo/+xywkmaz5I08yJQPGsskL6y4thBLphMkmb09ppvxxcIGrHP9owC5hXJP8LSWLC+iJ2IanxERbJJ14NaL5RmXIXP75uPs7nf5nxGc1pzUd5wJHaBo6Pj1mv+GCc/Vsr2UTOqBf4A12MhBt8z0nkdb7RnsXOzXyFqpLhffUDs+fS5fn5TLImbEIv5G/GIFDdoGRAKkqewX6goBaVO6gUxojyNS/FOXEBxTLSjNZntllXbey+dD38OjQVG07x/Q5udbos3oE7gBw/YB9/pKIwGZzGQi5m69AdP43kW5XirGCIB9S7QQmsn3c8XLL5wfPKJl1cldiLy1P7ovYf7lH7/aqp3bZDe7OooaOjBKvpqOt+s86rvv6dy2i3TZLCnW05hu5oFUEE+gce9c1B+VlAivrKGti2vDWpeGDKO6vlwJeHHt2bx5M/q6+GHeC8mTq31tgyaPs9LBLix46LcE8W1rnRtnv7fLQ2FHeuYEQfIA7OOuwu+UIef1bx6IJ/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IqA/MrBanbkw0xzYyur5CyrxTaqeNlPLW6h2ROzDEtllNV1gM6ATwqro9vD?=
 =?us-ascii?Q?tdvzHJZj+bVyM9io46TX45DribKf9JyAHSB9gokhHZQObVq+B/QD7LeFwuQW?=
 =?us-ascii?Q?8BLNSPiYgjvfieYSWdhpq6HnJOadcG/ex8YjDh6JrXbOi/SMo2wjTXNAyriX?=
 =?us-ascii?Q?nPaubQpHD2FCCzCxORwswVrrC9lQZ3UqmvmzMxsS4wsZWyzsFgO48CUpCx8n?=
 =?us-ascii?Q?EYiTz7W4tlYsK6XV8fE/Vu63rNsLRyUo/AhRkj78T233f+gcmak2pFR/06uM?=
 =?us-ascii?Q?nIRmIfcDMWMt93/KdEmneYbutU7ErPEhacFCzsbwyFOfqDDYJUjZd/YkSGul?=
 =?us-ascii?Q?twxniCe3mByA3PUFnLoYmNG+sbPQlsTqyeZnaACaBDozvPrfzGk53S/Cm3e0?=
 =?us-ascii?Q?FlHwuh6+xkPW8kJWa1CxVP3s61Fn2rwN7+JNGz+7nT7LXw++kRHIgJl/rdOU?=
 =?us-ascii?Q?/Mbabeb5GInkbf3dz76cldhwdf7jnsnaeFG0To0kvDzls7EKHwxpmeygi+ud?=
 =?us-ascii?Q?OJx6vSRO+BFj+o1FhT0+2G6YHR6xUIE1A9/3VZgDmszWbNkX8uqGn1Coh5DF?=
 =?us-ascii?Q?Ki/B1z9cKTLfAsqmtERVTFsw1FxRF7mx/Vlaur0iE9joPvq6ejcQBplv6fbt?=
 =?us-ascii?Q?jBp4ZKbvxLMrdK6oQD1p1+wW03OTUWA4WnaKvl95xrY9BJxB7bk/mJqGcCj0?=
 =?us-ascii?Q?pcJMHsxrkzYJWedy66BKuiL2G1VEoEdr7Z42yp1M8tz0V7gv57IAaF490ywk?=
 =?us-ascii?Q?+lKU3a02GvGY82Ncy2oJF+AE+zx7fiiq9ANHxd52HokKimf+Wio0ZZKJLq0t?=
 =?us-ascii?Q?IIx2LopBg8EVwZq8OnFGxkVZ4P26KTMSO0Ep10fC5v8aISJ+hGwP8CDfzUZR?=
 =?us-ascii?Q?BQKccd24QNzbuc8vkJdV0Eo7BwSjTKVsysiPxnLjqQIVgZ3yqZwVE7aYq0NL?=
 =?us-ascii?Q?Ha00PiY3bE2dY7ihJeK5hqeJt10/fqvtGSieS08ik2n+h+jbelB10i88vKM5?=
 =?us-ascii?Q?WZ3KcT6nuS/7ZLccUa2iGWF30pw8PomNke6SiJpvYgG6M51XygLbG9p1eCXa?=
 =?us-ascii?Q?JjQXRYfEGibupKGD7jjKMHC52GoOFTkeiAWe+dh6T79IXGbAoG/Zk1Ta3U20?=
 =?us-ascii?Q?4egbYSsA5xlAbPPixQLHdVJ5WXkv7O2U6ls8KRJVgaYbv1zv5LQxdPiz8bDc?=
 =?us-ascii?Q?pqcTrt/ge5WFgcK6dd9imyAsiIpupEexjV5NLJgU+4LOSYsVWLuKV6rP5JKm?=
 =?us-ascii?Q?4JhHTP8aFADCxSCXtVMW4GI551MVVvXHKmkdtgNyNVgcNDNidogWbStnnAR0?=
 =?us-ascii?Q?Hd3mbkh1hqHsfuGaEVeACk630aGS9pS/1CcoIq8ASCVdfkHJBf2vlmtQLyQH?=
 =?us-ascii?Q?YnDjz/Dbs4E88t+fw9kgBqEQX1vJcdKo9UJDEcfAy9zI4yubfsI1YfVg735K?=
 =?us-ascii?Q?cMRXkcoLWOrmrcJha33OJFq2pPFoRkW8+0xvR63k+qqRX8Nvrm9tXrfbS+Kv?=
 =?us-ascii?Q?xgt72fSS9VfsWJUogmiY5fjcs2sI0K1UXrTLNNkWzbNVkmYlKQIWz42v5Xzx?=
 =?us-ascii?Q?VhU1oSAb6y2QRIVQVts4zBZV7v2wiuZIPQIkjHScQ5xSEEG+3xugzv1UiG0C?=
 =?us-ascii?Q?3XCUjWtkW3CF6o3kCf8mMC6QKbnngRbTiwOVH6gB4Yj4ZM14fDhpRnOqIAHr?=
 =?us-ascii?Q?7F0A6tjWM3gO1x7vUuiYounqPpwZW+nMFadBfoKpuIksffEPZ883icNgmAAX?=
 =?us-ascii?Q?oMTsZdaYWqmS3bbV0bDOFVvtgJp9FtQ=3D?=
X-Exchange-RoutingPolicyChecked: lHaqjySh4T85fcaciOWzTNr/vX95HbsHA+BbB1Tiy8C82URDQq5TfYissU6If0OTL/xNuI93pWo5I2U+8B78Mw0Y0OBl9LWa+2+U5Jkwsnw5uAuZ4C7FYMqXyXc/f6ICMeh8mcMznrAOwQwhfoXdrfkMoKhHdzNx1aD4Q0iDlCCLYIvLf+lgGEy6UeMlB76GQzm7kmTBX2B2lNZ6JueCj5vKDVYqGp5RN8RtNgMqpW5WBOFaA4awOyrn+ZpIRuUJAws1982cSRfD5tjWGIyhTPfwejpgTbR853ejJKkklh2HMHOrjwNXZR9laORiOTmaBYBMS1DD9SxcHEXZRaDr1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f00474e-293d-4e50-627e-08df19b16d2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:29:54.3623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3V/TQQauvErrpTQKOuW/gmwh2mRXMfgI5VkwrbMMkvbpFlGHP/+Jnl2bIDZXEi74c7jabKvHz3iIhH7xY1obei/NZa33HA8dZwHwqrn5Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
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

On Wed, Sep 23, 2026 at 11:06:56AM -0700, Yao, Jia wrote:
> 
> On 9/23/2026 9:54 AM, Joonas Lahtinen wrote:
> > Quoting Yao, Jia (2026-09-23 19:01:32)
> > > Hi @Joonas Lahtinen,
> > > 
> > > When shifting from WA option #2 to option #1,    removing a global setting ->   adding a per-context setting.  We thought it was a per-context operation.  However, due to the "weakest link" effect, this remains a global operation.
> > > Thus, making it per-client has no effect either.  Containers will interfere with each other.
> > They would not. On the impacted SKU, the RCS and CCS at any given time
> > can only run workloads with matching address space. Those workloads must
> > originate from the same DRM client as there is no address space sharing
> > across DRM clients implemented in i915.
> > 
> > It's only when multi-CCS SKU would need the same W/A, we would need
> > further scheduling decision to ensure 2 CCS workloads are not competing
> > for the global setting.
> > 
> > With per DRM client enforcement, both RCS and CCS should be able to
> > write the global setting without a conflict. And when a context from new
> > DRM client is scheduled it, it should be able to program the global
> > value to its liking as the same address space limitation guarantees the
> > other workloads are not in the HW anymore.
> > 
> > Regards, Joonas
> 
> I understand the benefit of address-space isolation.
> 
> However, The bit 15 appears to be a global register rather than an
> address-space-specific state.

That's why we're doing the special dance with INDIRECT_CTX --- by
re-writing the register on every context switch, we've somewhat turned a
global register into a per-context register.

If it were possible for two completely unrelated contexts to be running
at the same time (e.g., one on RCS and one on CCS), then we'd wind up
with a case where:

 * LRC A switches in on engine X and sets the register the way it wants
 * LRC B switches in on engine Y and changes the register to the other
   setting, even though LRC A is still running in parallel

But fortunately that's not possible on DG2-G11.  On that platform
there's only a single CCS engine (so no possibility for conflicts
between, for example, CCS0 and CCS1).  And there's also another
workaround (implemented in the GuC's scheduler) that ensures that the
RCS and CCS engines are only allowed to run concurrently for LRCs that
have the same address space.  If you try to run two unrelated contexts
at the same on the RCS and CCS, then they'll run sequentially rather
than in parallel.


Matt

> 
> If the register itself is not address-space isolated,
> 
> I'm struggling to see how address-space isolation alone resolves the
> concern.
> 
> Thanks,
> 
> Jia
> 
> > > Thanks,
> > > Jia
> > > > -----Original Message-----
> > > > From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > > Sent: Tuesday, September 22, 2026 11:52 PM
> > > > To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> > > > reviews@lists.linux.dev
> > > > Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; Roper,
> > > > Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
> > > > <tursulin@ursulin.net>
> > > > Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> > > > Wa_22013059131
> > > > 
> > > > Quoting Yao, Jia (2026-09-22 17:34:08)
> > > > > Hi @Joonas Lahtinen,
> > > > > 
> > > > > For RCS -> UNSET
> > > > > For CCS
> > > > > 1. Old compute runtime -> UNSET
> > > > > 2. New compute runtime -> USER
> > > > > 
> > > > > If we take there's only one compute runtime version, and priority USER >
> > > > UNSET?  Where's the conflict come from?
> > > > 
> > > > See below.
> > > > 
> > > > > But if we take there's more than one compute runtime version, and their
> > > > priority is equal,  UNSET can cover USER,  USER can cover UNSET,  even with
> > > > two clients they could cover each other.
> > > > 
> > > > I didn't follow this part. How does the priority come into play?
> > > > 
> > > > We have to keep switching the mode as the DRM clients come and go.
> > > > 
> > > > > We should take it easy.
> > > > > Once we reached USER, set by new compute, we should latch it, for the WA
> > > > has been implemented by USER.
> > > > 
> > > > That won't work. If you are running two different containers, you may have
> > > > different compute runtime versions. Also, Mesa can be submitting to CCS too
> > > > for async compute, AFAIK.
> > > > 
> > > > To properly cover things, we should make it into per DRM-client setting and
> > > > switch the mode accordingly when different DRM client is run.
> > > > 
> > > > And for the given SKU with only one CCS, as explained earlier, it should be
> > > > already guaranteed that two different DRM clients are not active on the
> > > > hardware at the same time due to the address space mathing requirement
> > > > between RCS and CCS.
> > > > 
> > > > If this needs to be extended to multi CCS SKUs, then it'd be a bigger
> > > > implementation effort.
> > > > 
> > > > Regards, Joonas
> > > > 
> > > > > Thanks,
> > > > > Jia
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > > > > Sent: Monday, September 21, 2026 11:47 PM
> > > > > > To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> > > > > > reviews@lists.linux.dev
> > > > > > Cc: dri-devel@lists.freedesktop.org;
> > > > > > intel-gfx@lists.freedesktop.org; Roper, Matthew D
> > > > > > <matthew.d.roper@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>
> > > > > > Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> > > > > > Wa_22013059131
> > > > > > 
> > > > > > Quoting Yao, Jia (2026-09-21 20:33:03)
> > > > > > > Hi @Lahtinen, Joonas,
> > > > > > > 
> > > > > > > The key is LSC_CHICKEN_BIT_0 is a global register.
> > > > > > > 
> > > > > > > Even we use per-client,  we should consider the following cases:
> > > > > > > 
> > > > > > > 1. Should conflicting configurations within a client be rejected?
> > > > > > > I recommend the first setting should be latched.
> > > > > >  From uAPI perspective it would be simpler to set this at the DRM
> > > > > > client level at once. However we don't seem to have such uAPI in
> > > > > > active use currently (all
> > > > > > drm_noop) so you'd have to compare the complexity between indirectly
> > > > > > setting it at DRM client level by first created context or adding
> > > > > > such an uAPI to set it explicitly per client.
> > > > > > 
> > > > > > > 2. Should conflicting configurations across different clients be rejected?
> > > > > > > I think the latter setting can cover previous one.
> > > > > > DRM clients need to be indepenent from the driver perspective, we
> > > > > > can't do that.
> > > > > > 
> > > > > > The whole point of making it per DRM client is that given the
> > > > > > impacted SKU only has 1 CCS engine. We have the address space
> > > > > > matching requirement between CCS and RCS, so when both CCS and RCS
> > > > > > are running, we know they belong to the same DRM client and thus
> > > > > > they will not conflict with the WA mode. And if only one of them is
> > > > > > running, there can be no conflict either as it's just one context.
> > > > > > 
> > > > > > > Even like this, still can't cover all the race condition.
> > > > > > Which race conditions do you think would remain? We definitely have
> > > > > > to eliminate any race conditions to land this.
> > > > > > 
> > > > > > Regards, Joonas

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
