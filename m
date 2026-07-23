Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42358C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B25410E613;
	Thu, 23 Jul 2026 23:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lrQ2O8YI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F394710E613
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784848316; x=1816384316;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=icZZ9FqLsahb7GHFCSI7DNu65EEYOtBQDZ3fsBhIQRA=;
 b=lrQ2O8YItdCfw+MyRP+R2NbPsG13v80pvCWMhQgCjRVSWUdrq2OKjIQe
 Rk6rETHskNib9FVF0XaR9ykMbt59ANiBFgKiU4ITXHV/dfRWYMl/Bs297
 3QglwFy2KYyBjg/6mqffJfhDVczpPnZasnimoJ8dPmbE4LmQpCxNLXPzV
 hs/+zqgZ3F5eUOptBZUMollvz7r0XGdLaCRr2UMi7gGHE68LpmqxpCUgC
 aGdLAi8GChizJN3O/fdBx7FP4vA/liAQLFExgujkvUPxPm+O7hmyVFxg5
 MKXMZ/mhFH7OzDckKIebobyX/54mfGMiLiFdMgUchnSyFsS0F05yU9+/u w==;
X-CSE-ConnectionGUID: 03VDMFQTRAeODbE15OmAiQ==
X-CSE-MsgGUID: OSl2h4EeQVOHpHOW1nyEew==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="103059018"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="103059018"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 16:11:55 -0700
X-CSE-ConnectionGUID: wj74OVQFQBC4TdtNSV2YeA==
X-CSE-MsgGUID: q3dQ3KQQQECQ121lzPuxgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="255906968"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 16:11:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 16:11:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 16:11:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 16:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqG2UqhpCr0+PbKX+mFaLYN+g4T37INwRjZ28SX5gt55ermqQEZ2bgNExoFJdFt0beTqBl35nl1ewwHSwZ/QDJRzj/u+tzf7o19qqiZzTWZIrCXh/0+SxYALnsGgmSIRp9f0KUm/m/dlHwzgNP1/MrkhQSCfSGgjMtf0m5PaPeTLGV4cqV9A7qusrvyb97u3r7zxa1AaemHvi3MrWNR6JW3DQsO5kmibuBOqoM9Qsyq/Y5nh7ac2pJJqY4ykS1oYzLdYVdzxO9Y4daGIObdZA0uTWaXma1tpRBHJm7HIYSlX8i8lV8S/dShqk/8grFCjhAF0zzJnYYy0pyVx6FIzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydJk2vn2JZufCtqE9oBhjzudniYMJ0nTgCMbVIhJuSo=;
 b=WUj41vJRLRu+hUPjVx+/2l8lSdhnYUTCAWK99Ypes+KiMlb3ST3a2lcEBAUx9AYgnIUw63VXcRz8l4myaNie9GGApdlCkieAnpnA6YQT0RHQpLm9x1NoRvk0VP4BI97rM0m7iJstZk8QFEVrPH5HzuD5rsqcHXzmm2H5ZPhY70QxJtBcI9Qi6Y+OQkiXR98cgFFEVxYHOuPxAmNWDSyX5hsWZXYA67q3ek+ICu+eAXr9f27iRN1jCStkaYw5cHHfgq3ZFhJniUImHdTC1ErLbS2SiGYPEhH1Y/1+FoGOPaipgiVnH5OvyHqaIbi9FH/lXvRgV5VXbQbkw0vsOtXqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA1PR11MB9875.namprd11.prod.outlook.com (2603:10b6:806:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 23:11:53 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 23:11:52 +0000
Date: Thu, 23 Jul 2026 16:11:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Nathan Chancellor <nathan@kernel.org>, Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Usama Arif
 <usama.arif@linux.dev>, <linux-mm@kvack.org>,
 <dri-devel@lists.freedesktop.org>, <linux-next@vger.kernel.org>
Subject: Re: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
Message-ID: <amKftG6NRZy0Ii2/@gsse-cloud1.jf.intel.com>
References: <20260722225605.GA1910198@ax162>
 <amFPJc1NQbuYWlSp@gsse-cloud1.jf.intel.com>
 <20260723212724.GA999236@ax162>
 <20260723160942.b58b065d771401aba117bc77@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723160942.b58b065d771401aba117bc77@linux-foundation.org>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA1PR11MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bcc7d4-e3d0-4577-e38e-08dee90fc837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|10067099003|18002099003|22082099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: WAoykKdQI1G3K/Vo6fKt47PZ35wmZXTnlqWW/JGp+vbiF/Syk4tyBRiFrMkn7ZlpYxkjiqBKMUTliaOpHZ5lXRn6fcL1Bh9EMfcacMl6AeGfp+79KJKdEbwDwyXceOjya7Grljee+FDwjSphp6GrirlO6meLMsheIipPbJmgrv+ju1OCA5FY46aU3rmofUdYLkY1NyGG469no+PKAObKrDhhkjAoMd4JVi3IXuZAE+QZnUuoB/B4yi0dJ126p6KUkFEHC6RCT6JXmIWQDTYnJJV8fYqBiT9rtsivqnHZRQkgZqJgQeKhjCYJUA++cRhnnql4VfcVp1q4kt+xQJTeRMb+OSUiYYKmhCgE6piK+vJqb2u8cACZ8dg3pShJ7IbFW18JhYyfVafXhTsH9sSIeNxyqdySTkilXDCZRVcBAq7Fi3L0QALxuDOoRjWdouzS/0rQ10+GEnUf5122slS8aNrjNcihFl53OzJPyo6mbPESJTxB4juv1a8W6Zy7l5uOcBRN6YEyJYG2XImHMJUm9dNMKwS3yiCfA41pzCIHeXAoby+igsoGjdAY6R144dKktuOjEOyOgvN/P8b787vqBmTYzI8Zw7aIMFtJaHI+7aTtwCuieEb2WUSKZg8Klt4BxKKSQUN6NizCM1GjoFF0StU7gPia7PJteqjuuV0sRpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiu6arO7//Ogzw4MYiNhDrgwrcdcNdq2GsPos1QK+MGiha5J4RD70c+cS2la?=
 =?us-ascii?Q?cSakHrAZBL0E4gjA6jvoB0Kfw9XoZTBdf5WHYB4nwpdgrbdPvm1fhDXSfSta?=
 =?us-ascii?Q?Jb96dK8tznHZzyHjFERTj/2Bpk97bNuauEhucV+Fg4EyGwJoPBWB5lGVoJwz?=
 =?us-ascii?Q?lAQAQ+otQ3cinXdFhQLTKmNhl5t1+YZYgwmHOp54tr/2TYNRL2C4NMHbqe+x?=
 =?us-ascii?Q?1eVmjtWtR2SoPwmv4+a2tdzE71ci9vp5x8O1z1az+ZAO+iecB1b7ld3vcyg4?=
 =?us-ascii?Q?PHDtYvxTCTcpnSwKqqIfNjk6qHY4kwcuqlVXZIn23BPRwp71BAKt/+AacPX+?=
 =?us-ascii?Q?6XBvdZFpo4kKETTTD3M/KU96LDQTIx5C7LKzbiLE1GNN++SDykPU53xLkoYa?=
 =?us-ascii?Q?F9pgr/Dm97oHQ9maEQHNq6OWy0Dn9c2DqJEUl02Lnw27nb2AhsGuhI+Bs7Us?=
 =?us-ascii?Q?hNyyd5Mg6drrzl2UzCtdls4gbNBGdq0sCrT8baIPVif4UBDKTMmygRgWXSPB?=
 =?us-ascii?Q?d/rekimcRdcAnuOTDubbW+UL1rqES6k0GrxLQoFxjZU/TgcO6Ch17aX+1pau?=
 =?us-ascii?Q?3bT+6049bQt/yOKGbCInafSQEdZnb/6H6W0AmbvRkdeUZVKyG92OWYNSsksu?=
 =?us-ascii?Q?nY3bLY2RbXKPs5y5spBFUQNBUE01urzQxcYmp+Ng/DCiz6aWLJNc4oTnjODg?=
 =?us-ascii?Q?Ea4u07k2Ejb+lSzEyN8guZzJ87wejvH2/Yq7eXlGF3Z4KB9MMcI0ReSIS1yK?=
 =?us-ascii?Q?Ocdl/UfOkK+W1m7KBnpn5pi3dOzE540MICEUtcV2hDe0UL6vJ8+LxnlYGg8U?=
 =?us-ascii?Q?M1yDd7ujyrIhwCbKDdQEObvVRFngMoaP1Vy71BoJeYsUBOPKNsGMSPf9rEr8?=
 =?us-ascii?Q?w3iRREbbn6jexfo2hPon8V+gWzIse98UjGA6a+twjHTC7mTAHv6UhtIJE+Mp?=
 =?us-ascii?Q?i399BjQi9jkZz26CeOy5B4JiG2woOzGH0678aJ6/QsXJV8kVCnYh3rE6qs3T?=
 =?us-ascii?Q?hEuh82Rt0LLGEb5EEHAwpRb8rfTQ/ldyaZvE8SYoks8rWhRE4iDSYZN+skEv?=
 =?us-ascii?Q?hGfmaKcrPR/eH9dKzUFrWr7uhjYyHfmcrS7lNfGskRmp44PkpJttHbDEvRHa?=
 =?us-ascii?Q?4huE9bOvaqvkNRP304SgDsX1SaxVLB8KK7CEj8BN0+theYHY3dtWrza7Rx2F?=
 =?us-ascii?Q?mIyyF6PKzuWuiQpInmAIIbC0+SI7svgl3uF3sukb/dRuWZf7Xvhzw0N8Og/M?=
 =?us-ascii?Q?H1rZ9TQRBbXk+q5F6KfDCmLdC1uZqZcqzFimYi8AW0Vi0muF3RF5daLfpgUL?=
 =?us-ascii?Q?U9s9DUisRP4UH/HLtO2p/q2a3rwNYaeOfnoWGF3H4SjlmlQ8BFjkONyNOduP?=
 =?us-ascii?Q?Ess39g3PK4RAuVv2f6ahYLQYxoEPhcO03evJREmLPhl7vQVNtA69BliawBs7?=
 =?us-ascii?Q?zX9XLf9/p0LnvPGLpLS7A+I2JrlUF7RB8Nsow1aW69mLrKV2azl3v2/YyTP3?=
 =?us-ascii?Q?+ULuL8/8tfc90hcIBNPBAk0NdwHtjPvHUgVXmO5TB55zBuOn2knh+pzQONop?=
 =?us-ascii?Q?02KcW3DWtHCJaSF/vDVdNVW5RE/BeeNj87JGBVPUcZqS2nCnmqUZJ8p/1oMQ?=
 =?us-ascii?Q?UTzK8DFokrlUB+UxegROXdTSlv+qo08O9uueTZ1+NxprwaDVPlcLZ7qQZbgi?=
 =?us-ascii?Q?cCVPl4CE+VaVFF47XIFHniVVFUYCXp4Ra/FtyXbEQQZDwupJwK07fSRyoN0o?=
 =?us-ascii?Q?ETSz9Cb0Kg=3D=3D?=
X-Exchange-RoutingPolicyChecked: HK8UL8fH0zgbzEOtNNGqWhl/YM8/I4inFXjAM2wYohGrCqK7XMYQ2lZjraqQq2PAIrWrAcokK93K6hZ1qGETxnZZIsRsiJv+sts4+FiCuDiEMGHHkr6c1DxLNLrSl10xUGBllLNoVtFV4petcQFYOg3Z/pqHBs1Uyu/p8vpaRR6Hwpt4Ga8M/avC6WPSBdaJqqj1oDeEpJXpiuhTDOjIU2BJzoPylT8xuGF0aFyC8ugXGGbqUiIwtLFfrYNCjkX3zQ1v2GpBrn3FzaAWTtH8FQ/vmc6zT/Y5ExMw8ad0Q795em0LOPSv/DoZXM1FV7XQ+YBiUIzM/w17yEYyw4GOmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bcc7d4-e3d0-4577-e38e-08dee90fc837
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 23:11:52.8041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zomlB26Lf6sRVzTY2tMJXq0vSg1doOuz/i2DNreXFLDT3Z+L6RHcegdqZL4w7VSTOy8O3AOGZ58NPTDQznkByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9875
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

On Thu, Jul 23, 2026 at 04:09:42PM -0700, Andrew Morton wrote:
> On Thu, 23 Jul 2026 14:27:24 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > > So the drm_pagemap.c code could be:
> > > 
> > > -#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> > > +#if IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
> > > #define DRM_PAGEMAP_PMD_ORDER        HPAGE_PMD_ORDER
> > > #else
> > > #define DRM_PAGEMAP_PMD_ORDER        (-1)
> > 
> > Ah yeah, I probably should have looked at the bigger picture there.
> > 
> > > This Kconfig has been around since 2024:
> > > git format-patch -1 b979db1611a63
> > > 
> > > Would it be better for everyone for me to change this in the DRM branches?
> > 
> > I believe that would render this conflict moot and seems like the
> > correct thing to do anyways but you could wait for input from the mm
> > folks.
> 
> I'm fine the drm people changing things ;)
> 

I'll jump make a DRM change so this is all worked out when it gets to
Linus.

Matt

> Otherwise I can disable "mm: rename ARCH_ENABLE_THP_MIGRATION to
> ARCH_HAS_PMD_SOFTLEAVES" for now and fix&reintroduce it into mm.git
> after drm-misc has merge into Linus.  Or something like that.
> 
