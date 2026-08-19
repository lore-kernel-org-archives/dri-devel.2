Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6329C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B5A10E465;
	Wed, 19 Aug 2026 10:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UxAtvfBq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2173010E465;
 Wed, 19 Aug 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787135805; x=1818671805;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QxC/gHI45Fjqmlv0OymqaGve7kH3lfd8e+uc79AhZKM=;
 b=UxAtvfBqLPDf/vMOU9GwoEk121OLAc5AFQfJTlWwtPm5erynDtzcYlCv
 NeE1uLPtpDg78ACQXg2Q5Juh+Fo5qh9/kGwWWw+6O40I/LeBpirL1n/Ps
 pZt4dyICJ/yKfrYIRzqAoWWVtjFAPXoUA4RL7dzNNkqGXpbwOmYmVCRFA
 yDYm9O4OTdVjlP2AukUI5oOlyVoRymM6PeN99wIs5j725yXcSYLyc0RTE
 SdPbGClM5LrPzNgArNOAykvCBTEeVY2hCzF43bEmJEmbHB6/kiJXdUWL9
 Cs2WrKq8gSy2NiMEcwXZBOntllKhdghaxqdryYRl7EfzaFQ8FNaUFZyx9 Q==;
X-CSE-ConnectionGUID: CaRnG4srRfi2nP+w4y6uNw==
X-CSE-MsgGUID: aitL0enmSJazDFeqQ/PLeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87407510"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87407510"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:36:44 -0700
X-CSE-ConnectionGUID: sWvfbLG+QpG8G/21KlVIRA==
X-CSE-MsgGUID: EFeMzrHeQJiVIiJiwF5oew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269009799"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:36:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:36:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 03:36:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbvCZQsyeA3KMHly9wPic8fm8V4Wi+EBZI3Su7WWkDA4w4CAKAuHCTJ6E+6WGLnCiRGc3arERJXZaOj93HqRhJ62QD5sOBt/aZTQ4Lv2PAQxLObxfSplKTd/TuZAgZFgZYNfxBGVjiVWkik+EG81IubZ2hFo8ZUmDYDA7UaUKVf6enn/dt2PT5HkhPk0yTFLd/Y7zJap/Ab/g9nGxOxEBrNeoycNy1iz0tplCvhyLYEjlsjIGhyXPjO1olAurhP1P4sZIUWvmqiCALjlj2PXBwqx5dYyl52hHg6x08ZhHFdUQIQtBtgekkYIWRM6pf2f/Q3EFfHZwv7NSJ/47uU2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms99zeiYshG513gmm+0L2zbYgci6M/eyUdA4huBdUhE=;
 b=tNMjVwSesKTA679iPeV1Wg3z2ZA3lz++lr1n3vVhgeRXrITRTZEFEq4t88nONiSxQNZgCWP/QbLo1X1JZHZwzce1Ehnd+EygQUYS5noqUv1bdqzf3Xl/2b1pbEARc4V9Yl4mTwCNzvwadO9p9JY6iAq7wgZnVagMu79Mqu+U04OGFgSBlAV2a9WE1k5g3l+97C2cxxMrN6q222+UKbasway56RHz6gMmN+WVxJ9Ve8XfNkQoVPjlKo+k7NVuLhO81koSJejKhU2LXz1GNpOYgFm/Q+TAqudS+Soci9RRvuG7KFgep51br77jbEYkzAErsPCMQXhzxHpP6FCIPih2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 10:36:35 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:36:28 +0000
Date: Wed, 19 Aug 2026 03:36:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <aoWHKmz17HQo2uy5@gsse-cloud1.jf.intel.com>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ5PPF8622363CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fd6f40-a247-4dd6-ca12-08defdddba31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rDyp0CR4+FUjezorX72UVVR9Z2bk2ytIHJA5EY4F5XDi2nw+xLsGqFn6UZ+zcQr5Oz1oU77JYJYYJbpsBZOhIr1ItDsjjuwJ6FbMDFEz7CORg5CMgBJTG1aOm0BlEveaYn4hIVrqVDvWEZZzPI4v03WK06MbmDQuxo7oRo5vJmSO8cX2jrZEqGl+zwX++Lw9VnT89FkgyCN2Jd8VrBbZY4QVuhffZKErZeG+4lww9yf/KkIlrHWFqTVHa77+LeY2MMggx+3zcLrCTBf8OcYdJRvF009OkyEH4vPKlbAcGWQfY/PLeanXDRt+38VAJTQzn6JgW0C6HaCFfM+p6K18PugXlKsoqZpVKYIs3ipXC09lDK9+KGbglDY8xl4IrMglBU7OLhmuvRxN2YwT9e663vhzwjhKCFOh0DyPUUEhqy3KJMrL0QqFIpuwnoqdZNV56p5rx900hAaT/i9r97hqRwS49ohr7E1PXli5IgG+Oj3F+Giei3MdV/U5164cei3p+I6mWmmlEk5dLc1yIfdsjPpibR0yimQxtRjzdndU0mnLV5XIacgfZ0u95AHK7d5mE9EDxF98SWbTufPX3/C1dzYvf1pDe8KzdnPqP6Ej3VUiFxxPgFrt8roYKz0SYUf+7xH1C7yuPRoHsKp4STFIzFL+FNiNssGQNc7R6EPV4zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGvDjE/WRI7AOTBc8MWkIiRNxWxzOgwwe4Gu7pNm91RW1aiRtdl3798JI42f?=
 =?us-ascii?Q?RTaGiu9TOx88xjeAoAWTPmMJrvnT/c2IhLvg6IiYBtQDn4gcf96dmaJeOqgR?=
 =?us-ascii?Q?90/8XsNhlbsRPniZgCSpvxolZsF6xNa8du1+z+uMV92XfNY4Gh+aunwVcG8j?=
 =?us-ascii?Q?41KGuyfIA5kEcFZTPMzvrtLOuhnKNPSbpB4VLqvxZOSiHIlG4Ycn7aBH9DgE?=
 =?us-ascii?Q?D4rJZ0hpAMsevwj+kRDE6XxbrK1nhs4ES9E46Fh99kOu831e3TMAT+9enWTg?=
 =?us-ascii?Q?9NAVSxkqHbVNRs/4yv9D4JtmrUlKTBqpzeB2nwAsl2GXbamtzB7eN26GemCH?=
 =?us-ascii?Q?NnxCJCFCHKfyCdsAuKJ2pEcSEkGxmP9dchPmB3mhO2qZmNm5jm5FFclIILbN?=
 =?us-ascii?Q?uilA87KozT6du/xOZfjyPwfUREoHeIUnDQ0Ggb9+H07Iednw6y1a2H4Wji3Y?=
 =?us-ascii?Q?i3eJOM4+ml4JsK3XyUFwoMunPlQe0iBATI4GppiD1BXvu1aYqw5E3rzXXx8q?=
 =?us-ascii?Q?jKdSdRTThO8QsHgQyHaUF2w8OR+I2Eqtz4TJYRhWxt2XKYPWTqLFJ79AOy7Y?=
 =?us-ascii?Q?+LkUz5eG6Fy3LYvX/hU3VaVqiBJ60udxNFsnJWsYi72VNcXXEfCpeCTzFvk+?=
 =?us-ascii?Q?hfzZ7LLzeBfrJDif5/50E2j/dnnNGdJZsQ885E5d5pAsEPgaM1ntJ7TgWaZd?=
 =?us-ascii?Q?xH+sHwrlf0Pq6gRKDu8rgXFJkmNxAZpR3qhH0BaqMNKsRIAjsYKoY4YoE80q?=
 =?us-ascii?Q?gfhUncfBGO0wSIdAWD2+tpOQIA2nTXnGkUkjrliBqEDFUT4I9Yevy5xDKlnd?=
 =?us-ascii?Q?OcKT7RwGOxQxWEC58iMzirE04lV7qBg2kcN0bB7GE8GP5ddFEm7s5z8vJyZi?=
 =?us-ascii?Q?EOLEOgwJEfrkZYrCTURGHX8O79t88rZI62/SVMENFC+q6BaxBQ61UxoQk2yL?=
 =?us-ascii?Q?YMbT93GqjXAA8QConz9a2kIk4a5wtzq52cOpkEuM05tGbZ9l/5M674ypRk1A?=
 =?us-ascii?Q?3gSougwlAPAMkF9+7e4lDrAD5sn2x0UnNFlqZO+ckv8ZSfeXq2284mJeSbT9?=
 =?us-ascii?Q?iGQdf94zlvnlpaoDDDoeG++GRiS8Iq8gUW6gXN/RgwMeZHsY6YQjDCiIXnN+?=
 =?us-ascii?Q?IOQdELyg2UQZRXrPcyOZ/+67JNtaPmr4XoM+miy3ODWTPt5mLjqGflZ9jHmR?=
 =?us-ascii?Q?QUeI5VDEzZECixcXLd45sP+M5Plt5b/hkCwVCpYGbp3Mms2916/Pt+lr4k8J?=
 =?us-ascii?Q?1MWWJFQQqs8EHd+nnxv8lAdL6gbGqdAv3sARzpSdifomLdVPtTuYtdUZCARM?=
 =?us-ascii?Q?jfuK702uMKx+g/Qw6ZeZkzibzTaZ2Qog5qFWSYG92bO15yixSyplFB1Q6gZG?=
 =?us-ascii?Q?QHwoe068B3f4WqtPJNydtN0cD2QEBcxJONQrPbbGcrzr6O/+GMS44p7jTKT5?=
 =?us-ascii?Q?4XrzO0CZ9ZJtdHG3AioUWCRNUsEbxRLK+MzPgjrAwykhfzQM4ujXpGNqFamn?=
 =?us-ascii?Q?g3x0mHa+sBGqQpomaxUrcLKpo2ZJuglxwCt48g6hfA1e83RJWr+uAlcySGKA?=
 =?us-ascii?Q?AA4T/kHYAis+VzheNigM0BRknFHvL02K4taFeizwn5gwXYhS5W/Psumx8U42?=
 =?us-ascii?Q?twjyq6BlPHBhIw8FnCYoijbr9uRznHYqvF32Q5W5pLgWDS1WrkoDSlOPgFoP?=
 =?us-ascii?Q?gkTAytD/7He+tTfRVrRC5Ig8yRORpL3jR3rt3zMly9fwsHn6Fxjr/ifQMmx7?=
 =?us-ascii?Q?Lw7FGebMVYUghJJrc4jgT/7oCiEh36A=3D?=
X-Exchange-RoutingPolicyChecked: g4dBOXpQ++Q/1V9TwYi0QfaGrYokJun+yyd2achKeT3+aJG8w3r/YSnv4iaBFqamv9B7m1e+iwdI3It42V9byQW+wRsikBlRtbcWQy2Yt67cDI0w8x5r5YzbNNRkT0ffZlDCl3unqLuu0NDSXdQpsddS7Mc8y144eUyz4F9vv2Z2KuMbutDMKjZyi0pOegY8ZNsjvOM3U1IRIydK/fh3O1lyqcUjLmaUH/wPXR9dBZwIpJBe8uDzc1UlafiQ6OtJWNODHwUS+jlgOv/ikio8nQ5HKWvIPI/KU8eYv5zzuVB0fTGMqOnHrqVZJmjVIBH5tfjDUHC4vQL56+W1tR5ZPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fd6f40-a247-4dd6-ca12-08defdddba31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:36:28.8537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To2BCGxLV56pIoprowxJ6Suf/+xW/u//i6LqxJVBLfOXow1kkdMCr3Q+p2NPIcAmhtIgwLWs+PcXbciz7jApog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
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

On Tue, Aug 18, 2026 at 11:55:46PM -0700, Linus Torvalds wrote:
> On Fri, 7 Aug 2026 at 10:46, Matthew Brost <matthew.brost@intel.com> wrote:
> >
> > I think we may have found one. I haven't been able to reproduce any
> > kernel job timeouts on drm-tip with this patch applied [1].
> >
> > If you're still seeing the issue on your end, it's probably worth
> > pulling it in.
> >
> > Hopefully this fix will make it into your tree soon enough too.
> 
> Well, that Xe fix made it into my tree as commit 9f83c94469ff
> ("drm/xe: Order ring writes before ring tail updates"), but it turns
> out that now I can generate those drm job timedout issues at will.
> 

This is probably an unfortunate coincidence of timing and most likely
unrelated.

What is the kernel verison here? Is it trying to integrate all the PRs
for 7.3 into an RC release? Or is this the released 7.2?

If you have branch we can pull, that might be helpful.

> [  +1.222075] xe 0000:4b:00.0: [drm] Tile0: GT0: Engine reset:
> engine_class=rcs, logical_mask: 0x1, guc_id=12, state=0x3
> [  +0.000041] xe 0000:4b:00.0: [drm] Tile0: GT0: Timedout job:
> seqno=4294967171, lrc_seqno=4294967171, guc_id=12, flags=0x0 in
> systemd-logind [2068]
> [  +0.048338] xe 0000:4b:00.0: [drm] Xe device coredump has been created
> [  +0.000001] xe 0000:4b:00.0: [drm] Check your
> /sys/class/drm/card0/device/devcoredump/data


Did you change anything in userspace, or did you just update the kernel
version? This is a userspace job, which can generally hang if userspace
does something wrong.

Also, are you running a stock distro? It might also be helpful if we can
boot something similar.

> 
> But at least this time I have ssh into the machine, so now I have that
> devcoredump data file.
> 
> I will send that separately off-list, because  it's 2.4MB in size.
> 

I'm looking into it now, and based on the dmesg output, it seems to hang
fairly after boot, so something is going wrong very quickly. I'll
analyze the devcoredump and see if the problem is obvious.

Matt

>                 Linus
