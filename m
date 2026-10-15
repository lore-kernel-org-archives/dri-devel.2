Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7108FCC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E129E1124C2;
	Thu, 15 Oct 2026 21:29:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7335D1124BE;
 Thu, 15 Oct 2026 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792099743; x=1823635743;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R3ihhgSKB9q5YuNaJhRfBEWLtjQBiuLwO/7nsQFhtHE=;
 b=UtT3uLzHNBC9sVYGIkV26S+5+IxXi+DSJyBNIgfm9ZzC7F8XaqK1Lhot
 Q1nlTQWUVCceJTLSdZGkhVE6BJtkuT5SvdKQC+hsoJujCVldtuVWU2T0N
 nJYNGgM0THhabZGG+4VDwj4txsjxH8sdNr3vHNMisn5OYyOqJEa2+eDpV
 prMTOOIzdqO3Lasy2irF4j6qzjcy7UfjR/J77QRqOLDnXw/QXUtv1WmPR
 He/uWmpt5eqtAOZMgQi2fx5Th6lxjXwEMpw57w2L/auv6dKhKkQgpzvfa
 3x63wFTxr5UTOcDxLH1Gsf85i2njEpKA/TcnFGlbPQiUdPqFe2upb5ffW g==;
X-CSE-ConnectionGUID: BlVPz14vT7KyvtKHHj9e9A==
X-CSE-MsgGUID: OwHsSB4kQq+cUiKPaY1iew==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="915591"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="915591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 14:29:02 -0700
X-CSE-ConnectionGUID: DE/opiE6SVmSGDUluUzYhw==
X-CSE-MsgGUID: H04mwPeGQsy7YW6NAy9B+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1884641"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 14:29:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 14:29:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 14:29:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 14:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7I8G+EWUtuft0uGzit5+/Fz/UfzUK9EGMqSWM+V+m9VfUQHlp7i8OG8wYvk1uRknuwpPfe8kD92sY0JZZhMoplrcEDlIMBvTcR5PU0nMbP2S96xjoKDYWPK7ExaXYqvmaHKZe4+05Wd/L13rnoC9cLQNGSUqD7rHgsMhswn8FU7DV+I34jeXJZm71PhALOgQ1UA2SzmU15CTlb1FWLccBw4BwSulK8mqiT2NrpI5K/7FUW+HOShmaGM6xJQgOazgWBb2HdhSaAsqXcJqF0232M+eADQNIAxy54f8NIqCcCP5STkouSyX8IjRzuWwYikc7Ycdr/X58wm9eCBMa5dyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/+/ih4wcRxM1NkxwFKRlZH4Y3rpSoLiiEPj7Ajt/Z4=;
 b=QPmI2wyaeSca6+n0nKp8AWaQQDeIGxu+HWwf+EVCpdmd+99fmF8nNA5lmygfw9wShzgZuGLSNuW8d94GDzLHd6irvUp+wnNWOM9NTRUJpWwLqrIvWTGapnq9twMW7gj/yhep3U3Axt7wtasTHUCV3pX1cC7ozQstH0SlZX5H64drOU/nNs+YhONZMs81yO1zSYbYWDZ5jWesJOcuDGpyZBCQkNESohXdqioTS+tlErIy5jZRLiYojNDOCNZpW2ortx/Fqg63k1HO9lJ2WISYkLI3bQ2lf2Ec8Vt/VwJfZsgqN4r3QWsr48fo7Qk6CFJrjW8Ynj4QwBImUZUcF+9G/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 21:28:57 +0000
Received: from CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4]) by CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 21:28:57 +0000
Date: Thu, 15 Oct 2026 14:28:54 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Jia Yao <jia.yao@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Shuicheng Lin <shuicheng.lin@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v12] drm/i915/dg2: Add per-client control for
 Wa_22013059131
Message-ID: <20261015212854.GD578251@mdroper-desk1>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260930171334.3636-1-jia.yao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930171334.3636-1-jia.yao@intel.com>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To CH3PR11MB8185.namprd11.prod.outlook.com
 (2603:10b6:610:159::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8185:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: ecabbc2a-3da2-4fe8-00c3-08df2b0351e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: TnungVPrM0OGMVEwewmRtgAMRmz4zmq2Ypm2aimaEusyFytEmS+D7Xuf9ngoqKEdaCs1lELALuYBRmicLAfWUwCHKb8iBqVN7pk/umaq3fGKXAHg2bgLHYOn/wdAcdeKd8FXR8WjdL7ZfsDEsyENZeiHjubdkIL85wTpel4kfgpch7HHmQ0OdLxipCf9lDedGIkX1qsUYtsCzpjk+kHXJGsJwABvQJx2qTrHUHiXZx4/dqWpz1oU6yich5CXuPkEBmSlgrcxme2THLMStdmtBhcAlcES0SRW/Kyxl+wi7c0kZcbblrWdrQwU1TTXeGb//xCquu1xA9mLulY0w4Ai1UVT4gUDyuSp/A1WC3UjpsQMMI0bYXiTWtZV4iadW/So/ceD4MlLgqpxJaFPgvDjnv5QUZwFHrKaEm5OcSj5mJZ+PmjiHnCIqGybt7aQ9+jPCvkUTOP87Xoe1ktkr4jFrr7rIzZUYfSGI/1/nh9K3zrhrid62xKxYHFWsB3r/PxZt7j/iXda7aXQn1Rt5+gR6yjfdTVnNB3kykNp2bsuhzj2x7AanF+Fa/QUGZbV/U6lZ5ihPmFiWLT47XO2i1XFd5+T8Y9QPiGx9MMsAWOv/YzHAuQZHJVlM35nMySNAaiXQSFgaqaisN3gWO1vBEV867rz+I0P2CshCiVDrzR/vew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcoKA5UiJg+Eo11BxoxJN9uL2YIhVYQGqhx2n89T1iI3BlbF7vZb3PtQAeoN?=
 =?us-ascii?Q?WPMOMyJ/uAVzvpzHaTfOawEFrem0aog8TS+en03kas4Lqn74yLfor1P3QwA5?=
 =?us-ascii?Q?ELn2zNrIsgTn/vMGDJoEKW9Tsi8Cxvx3LAYY+xBRJPJjWZQzDgWOYaWU4B7z?=
 =?us-ascii?Q?FHLBz/eoCoEBFJ1PSxhz+y8g/cmKYq6TBHbSVQezAZCKaH1dBjbrTN928x0E?=
 =?us-ascii?Q?4no/8yiAqQivv2AywQ/GnuXHskFvkut5H5c+vUatZIeU2TfnWFbYP+xt88L+?=
 =?us-ascii?Q?g2c69r1RSj/Ix0HWjAj14mLmHJvxWv30J9zS8iM4GzfPdIBUsO5nOtbQMZQj?=
 =?us-ascii?Q?l1wFMdKW5ulcF4Toeto0kzTjLC9x3fajycddQo6ZJwa6mryYanjH2xrur9d9?=
 =?us-ascii?Q?6rBOythBqO/VqrNUTVkecUOsH3CulWaS/EIdrQ6LV21AlpFAcMSWs3tzBmN5?=
 =?us-ascii?Q?WIMfynPjDi5BYiEUg5gcJG35gWuATqD31PhFIp0P11Il0fXwgWznJthnVEoQ?=
 =?us-ascii?Q?1LaxapLxl7gFECXgsaCo+t1kexYp+seGOIQBKOj8FZcgAtXEaczMsb6nclMb?=
 =?us-ascii?Q?ro429b0zz3NdmR06iKPbTM4Rs6hbpNKUFsZJw2dHTZ8ZyhiG4HmU4zwF80qB?=
 =?us-ascii?Q?9wVP/7TcI8oA7eLSwu/BIjpVWUnoqIxptZ5EAqKZsJlXgAHxV2Kj3zCfL4M2?=
 =?us-ascii?Q?MOAsgfWV5sHZyRtybXQWJ5PGExG5PQ373CWxZ/j02vdxJ7EWKK9ZuftC0uy0?=
 =?us-ascii?Q?goIw8sPUQvgjmFFLzeNv1VoHDb3HBAXcBTFZtu01iPsSIxhm86WJ1Q0A/HoA?=
 =?us-ascii?Q?/mwjmkxBbglPY+DI8ZPjX9NaM0RjZyryM11IAdSBVykxKySW4dVtu7Y/rqwt?=
 =?us-ascii?Q?WMaP68lMgOHichLjIaSIsWTHh4yqBpUMbPqCJcjUdoT0xptPLCqxPNtes/Es?=
 =?us-ascii?Q?gEyYSoQKntiuZkiQ+cfb1LYk4RCvyWx/F1ajgLMSOywuycmwFGxieUkOHwb/?=
 =?us-ascii?Q?Mc/3hNT9KrJVJXwuzsHcOq1volLgUkQ4Q9Bl4YFFkdNaGlhCi/q0ylP9L/wr?=
 =?us-ascii?Q?iBAeYxrjXFQnzWRKQ1ufX22LrTWj2cJGF0F6aPK8oXrm6W2RqGIQEd2Dbk7L?=
 =?us-ascii?Q?IGpfBMnYnKpwU5a3VPEMB0NNadrswNvHXmnYwFwM+Y2oxWgXOnDFW69AjQDO?=
 =?us-ascii?Q?VrbGTjGxkAhU4rDgJ5HjwXWdXqpwlzS2I/N5rl4mETGER7JJqKhzQvZQI2Y2?=
 =?us-ascii?Q?rJp2Fx2XA9xervK95JgHLOt85F7yfYiEKW16ufjLvqYzwqkBD/M3LDkRZ2u1?=
 =?us-ascii?Q?s4nyXn3v3O2Urm4WyMj+CdEMdcH1F7+o4bt4xnevFHr4GSMps0OzdwTmdrsG?=
 =?us-ascii?Q?epkF5aKNf/xczwd6edjy6zQZ5fTqHergj5LbJNVpY3Tc4X6rwI1Gsy75IAnh?=
 =?us-ascii?Q?e4w1lc14eUW4tAYjRUh7SkVRdUurFO8dfslv4pGtfj/z6qdSxmQlGeCTs2/q?=
 =?us-ascii?Q?uHaQy/S7ojJ6eFX7yfp/F56nIRVL7Tluvuv0tixc+kJuqw3ixEpgWxgNrjFo?=
 =?us-ascii?Q?GiMAhmVPZWI0q/QndEXEgYfwgFzf6l+oyj7R5MHQkW3z6Mooaa2QXfx4iJnJ?=
 =?us-ascii?Q?BVvt21T6SCbDurSlp+66QoZi0DCWgcXLTU4OU0hp+MCbuyhGjJqGjZc53O4T?=
 =?us-ascii?Q?Gy2q5xePCd73S6dYDcUXEKGgBOX9m+ojjoxQgexGf/Su6bn+H++GOBkg4GHp?=
 =?us-ascii?Q?N1j2JNSTG39EVOXOx1mSi3TMsaWF7G8=3D?=
X-Exchange-RoutingPolicyChecked: JCpLSjcHav6D27muuMbxRrIgY/UmHuL7/xNqVjamDHL6xbWsYtQcd32WTwc7Ww51+cusLkKgpwj70k8qS1f9jj7Zxd2A7NrM5wThtaiijVFjue0T9IX1a6Gy1dX0Jm+SixeeAXQ42yDeRTsjfcqpKXRnf4RZXL2inqE2qlBwv/cyulwyvf+q4bcIh/sD15oxuyEOtl5/Yqch0ZZfsEql59v/9v4f6eaKNCtfBjcLKiHIwIRN77ZhGwwWIr7sen8Jnq5bCugK7oJrMVfSxrAWwujgKSuWyTCUVI/Zm1LfUFN7wDcCOFJ63+8L1N3umZJHsT4Sf0DNPufVdkfyd3kY+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecabbc2a-3da2-4fe8-00c3-08df2b0351e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:28:57.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLfJ/Gmc9XSnh1c0X8JfFkIWpNgvmnKK3dleknXDLLex7kAEUcDfjpYSpkPosvSktenMlRkxWUPmAMCGx3MBczSD+2LjBqil5T+N6YGkXFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
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

On Wed, Sep 30, 2026 at 05:13:34PM +0000, Jia Yao wrote:
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
> GEM_CONTEXT_SETPARAM and the first context of the client being
> submitted, and a later request for the opposite value gets -EINVAL; this
> covers the default context (id 0) and needs no new ioctl. The client is
> the unit of consistency, not the register's true isolation boundary:
> unrelated clients can still override each other on RCS and CCS, which is
> unchanged from current behaviour.
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
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c   | 51 ++++++++++++++++
>  drivers/gpu/drm/i915/gt/intel_context.c       |  2 +
>  drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
>  drivers/gpu/drm/i915/gt/intel_lrc.c           | 59 ++++++++++++++++++-
>  drivers/gpu/drm/i915/gt/intel_lrc.h           |  3 +
>  drivers/gpu/drm/i915/gt/intel_workarounds.c   | 10 ++--
>  drivers/gpu/drm/i915/i915_drm_client.h        | 57 ++++++++++++++++++
>  include/uapi/drm/i915_drm.h                   | 24 ++++++++
>  8 files changed, 201 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 6ac0f23570f3..ed6bccf13f16 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -874,6 +874,29 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
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
> +	int want = value ? I915_WA_22013059131_USERSPACE :
> +			   I915_WA_22013059131_KERNEL;

The uapi says "Default 0 ... Set to 1 to ..."  As the officially
advertised uapi, that means we should reject any attempt to set a value
that isn't 0/1.  In the [unlikely] case that we need to come back and
extend this workaround with more options in the future, that allows us
to give explicit meaning to other values for the parameter rather
potentially breaking compatibility if some unknown lazy userspace
developed an assumption that anything non-zero would be treated as
I915_WA_22013059131_USERSPACE.

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
> @@ -911,6 +934,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
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
> @@ -2243,6 +2275,15 @@ static int ctx_setparam(struct drm_i915_file_private *fpriv,
>  		ret = set_context_image(ctx, args);
>  		break;
>  
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (args->size)
> +			ret = -EINVAL;
> +		else if (!IS_DG2_G11(ctx->i915))
> +			ret = -ENODEV;
> +		else
> +			ret = set_client_wa_22013059131(fpriv, args->value);
> +		break;

Do we even need to support setting this parameter via the "after the
fact" setparam ioctl?  The compute runtime's PR shows them only setting
this at context creation time via CONTEXT_CREATE_EXT_SETPARAM and never
using this ioctl to try to adjust the value for an already extant
context ID.  So I think it would be fine to just return -EINVAL
unconditionally in this function so that this parameter can only be set
during context create.  Trying to change the value after creation
doesn't appear to be needed.

> +
>  	case I915_CONTEXT_PARAM_PROTECTED_CONTENT:it 
>  	case I915_CONTEXT_PARAM_NO_ZEROMAP:
>  	case I915_CONTEXT_PARAM_BAN_PERIOD:
> @@ -2583,6 +2624,16 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
>  		ret = get_protected(ctx, args);
>  		break;
>  
> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (!IS_DG2_G11(ctx->i915)) {
> +			ret = -ENODEV;
> +		} else {
> +			args->size = 0;
> +			args->value = atomic_read(&file_priv->client->wa_22013059131_owner) ==
> +				      I915_WA_22013059131_USERSPACE;
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
> index 147d22907960..abfce839570d 100644
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
> +	owner = I915_WA_22013059131_KERNEL;
> +	if (ctx->client)
> +		owner = i915_drm_client_latch_wa_22013059131(ctx->client, owner);
> +
> +	if (owner != I915_WA_22013059131_USERSPACE)
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
> index 2e7a50d16a88..8f10ee244d32 100644
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
> + * I915_WA_22013059131_UNSET must be 0 as the client is zero-initialised.
> + */
> +#define I915_WA_22013059131_UNSET	0
> +#define I915_WA_22013059131_KERNEL	1
> +#define I915_WA_22013059131_USERSPACE	2

Minor nitpick:  It might be nice to include the word "CLIENT" in the
names here, just so that it's easier to distinguish these from the
context flag and such.


Matt

> +
> +/**
> + * i915_drm_client_latch_wa_22013059131 - Latch Wa_22013059131 ownership
> + * @client: the DRM client
> + * @want: I915_WA_22013059131_KERNEL or I915_WA_22013059131_USERSPACE
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
> + * Returns: the owner in effect for @client, never I915_WA_22013059131_UNSET.
> + */
> +static inline int
> +i915_drm_client_latch_wa_22013059131(struct i915_drm_client *client, int want)
> +{
> +	int owner;
> +
> +	owner = atomic_cmpxchg(&client->wa_22013059131_owner,
> +			       I915_WA_22013059131_UNSET, want);
> +
> +	return owner == I915_WA_22013059131_UNSET ? want : owner;
> +}
> +
>  static inline struct i915_drm_client *
>  i915_drm_client_get(struct i915_drm_client *client)
>  {
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 535cb68fdb5c..a9821e2cc3a2 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -2172,6 +2172,30 @@ struct drm_i915_gem_context_param {
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
> + * not needed.
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
