Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E99C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D149610E3C4;
	Tue, 21 Jul 2026 19:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GPP5wbal";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CB510E3C4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784661337; x=1816197337;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Sb9kqorlC9DUFqogrtN7suxMj9ZqOvij9sF/S3m7fH4=;
 b=GPP5wbalxsbyHeOUmweA3KOdLvLCr6bSBHOJXX6ovlMr2bgo4yWOyCXo
 UACEXvhv5LmsFo0MVs2GuZnUM8Z95kvIpnlhYpihIgX25jQGHS0UTWa0H
 F0L1FkCqyYNENj1ATGhuIu5xL6/GGtY0Wrpb/wWWoXfZW9IxEJf0GMX6x
 GkjwNCAbEfyfAx80TmC7qPDqKQUOyTsFJrRl0t31MHJRUVjzatypcIMc3
 RLM3K/+csk797VZ2qBKqtaLoCFAIaIAfHCcB/ySyvTjxgtGjgTHnLwALt
 Jv9EFS25ZB2zuSonMPySDxEmbHdfOemX0ZWC0tM+bJ82QNtpxqpEanM/F g==;
X-CSE-ConnectionGUID: M28bumEPTGqDSIVT5qJnpQ==
X-CSE-MsgGUID: kld+DvpYS/6naz/ZKTnx5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95639412"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="95639412"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 12:15:36 -0700
X-CSE-ConnectionGUID: Stbg8KIySRGhGNh5gffYLQ==
X-CSE-MsgGUID: FP0JNE7HSqaq369RRBsvDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="281134311"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 12:15:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:15:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 12:15:35 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.50)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdiGykceNWeeqVpcBU+dutEQ3531IeVKx3iFYosfP6RaKwCNHfAua7q2qIEQmfIxnT0Q6gb+HRrjylXvS2awA7NH9G/quyTqZV5ze0MSaYGMcWOWmjxkTQxKUcImLPt6f602XB9qcqR2ova2471o3BV4PvyNTv22ZcYntlRAttHzIOJ1m1WIcXXA5UiPH5w2FmtjvGroWQrGJC+zXn++Bxlul3DXGcn/08GyaWTogWTS+mpGfLBJO33/bwtK6Ortyim30CyRxW7LPWxvBlZI0y8iWqzWIhDh3rOzSw9erwqgQpmtUKJJVzDdZ7DEMAiGB1VI1xhirWR1OxQt4Pi1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hhA2ogUaEFjA0q/vbL8BtOJE+PdI3u1cY1hPWBNMrE=;
 b=DFr7cHSAm00K4BNV4QIqg3H1y1u+YLP/cadn5DpJueNFcWjxIHOK+gCUOjW0oaaHDIrDMKFKioS3oEqPotaO6uIIIH/3vWPgx2wgdXi1bPGATltTQSvtAnhePuR7ORQLA3r+Cyb6DiJSOTZnbIHXm/qnXjxn0XeQqJV/MssZaZ16/rcq1r94G9wz/RMFnMI2PxF+TmVhhIPSruPPH11BAifcALCWXtR+f194KhufxhXjNwfIfZKH1VlqHHeYyw9v/PbHDWWJ4zIs21tb6PHa8SZVp39FihBxQbB/v3teCnrb6307Zb4PSEajPz136eYsEvYl8fKdXjlRE6MZVGR82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:15:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 19:15:31 +0000
Date: Tue, 21 Jul 2026 12:15:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jan Stancek <jstancek@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
Message-ID: <al/FUZ78S7efgAp5@gsse-cloud1.jf.intel.com>
References: <202607201914.LpAGsbXs-lkp@intel.com>
 <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
 <al/EgTw/D2mC42pT@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <al/EgTw/D2mC42pT@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c8cca0-21e2-4489-27ea-08dee75c6ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 69VdM6OPJuucBfyzmjPPfSv5uimlVHd8BfaxlS5L3dsuTsnchz0NjoqEaOR0bOmk2k7h4YDBxnRSF3AhNEBf4Y7kexD/UbFaL5ebsYy5u5uWBHFVtUaeA5eBAOzyOEwWDtoCAX57UcpPQJiOj1SondR/ZsTw9B32ApEeZ2g/d0tlUYdE6iw7QRvxSv15YJyiokSf8GNS3tMbnCWPUCk/V5j7KIM47L1lZ+PCaFfRkGzN6Vo+l8Jikc89sJIbT1N7hMcpQn1BSx33l8y5NqV8tgBpTL30rVf3JphGBY6+M7kyFcXEcM+vxQVsOhSScws0aMBYJu0xTFDZyNCwjNuQfuS0UubPoQvfDOwJYNFx51R+FmTXMjU2D1AVCvT8SqzO81zuT/qraKJa25QCeJ8z8x7ScU2Gxiz2Dm/RQxr2OxfcmDusZ5VYw6iVmAcakVoathxMdk82l69Ey/8ks5F7NSEB1kE7z5ia4aFfw3ZbpxfeKnzkU+NVjTCdGKfWMfncDGoVr1Co6IfoMUdGLDmy1GupIkVfSnwl62CaIj0rFEgAH3gkQXl1SFYl2wdvwN1znEUvZwvZqJaKeL+UpcSzh8MZTLmfR38HLcLiahzBenD/fDp98JX0NKXS12MFIr/BbX2ElwouA0gTF8R4Kw19QrAEwDOTgzuC48/Q/TjEwfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHhwy9H8vMjUwRL86vkhY4vJ23CmdfHzz5WLTi57jYtBfTlkujWi1QEZCj5X?=
 =?us-ascii?Q?F3Yn4G1awqnP6XwEmVjrIPmJ+ooU2fLJbDLc0xQyXZz10gmwDiWcEzpt9WoC?=
 =?us-ascii?Q?AtqL1ZT1yu2RRBtDHT6j6Yd3TnATK6DY0FXIraScLYAwLGyOgkYdQluzK/qX?=
 =?us-ascii?Q?GkS0cMlRU3aKVTMS6shReHNTF2Ntb88qMkCawEILnPnFDmOGAHUNjeaLZSSz?=
 =?us-ascii?Q?3jO1x5Tf+7zXDxklhRha7O6bcaMYMUjfhp/SXMTe/Zfc+5aW0Jc6j8wWC8He?=
 =?us-ascii?Q?7ubITY2cn3AgNgOziFuDIC2Xr4cc5Wa4Lnnlzzd5QIO1xXWi3/Yg34B/lt5w?=
 =?us-ascii?Q?Km5SYA6GPXli6zEZ3pOHQad+zFrpqZSCWDf/IsA4bUL7heTU5Zf7ZOOCPNJC?=
 =?us-ascii?Q?n0dW+Ke66ieXh6ciBG5HZ8oEBi17gv6SNVhpqlBifdpRkImNPkC+Mu0+c2DI?=
 =?us-ascii?Q?VpSuS9FRvFgm1rM5Pyyp2jg5pMMdxd3ezmnlnXgTxqo94Q96OoKgUfdew1jx?=
 =?us-ascii?Q?hrNfOd2P0xvbVLMLI3QbMg6ZY7fOpv7kCi8bu+mx3KMB+XM+yjRXW8ileuZi?=
 =?us-ascii?Q?g+Nj64AXT3SAAKLYIm6qxOTECRg4iELdNkfUYB0cjTiCUtEGYgBwtV2rqMEZ?=
 =?us-ascii?Q?TBid+s3Der7vch5KkSnYTS+d/n0sv0eGYkCs4KUct2r6FSB0sDGmxLnbIl1R?=
 =?us-ascii?Q?mHnFPgsocVDrw1bqsmMO8CglB187E/mh3feljr1v+7XFSWAnZVA1qPDMrVPA?=
 =?us-ascii?Q?BL5UFTkt+yd9EE4vCPU2JQWFK57mnnA3KYiBUcV+wd9Yon/HI6+F5WOOhQkE?=
 =?us-ascii?Q?L+zeg5J50yDmmCYFZwAKTlo04Q4Odh+I1xFCroFwDxm3QfA/1ohRMiQDFPlk?=
 =?us-ascii?Q?a89+9eQy1FGrW76ekpk+qGQRh5zpHWO1HpylAlyINOpDj+vqIwSs2ZSUOcVw?=
 =?us-ascii?Q?AMoLJT78v21CcizP3uyYuDJmons+LF15OWN7HZEMjWGd2YrHVIksAFVzhrKk?=
 =?us-ascii?Q?c1MvXxrJsR5ZS59QCZMOW3+s7O0IK0Dx1jbglimpuEtf6GhcdlWbr8xySE+3?=
 =?us-ascii?Q?JvfF59dPVO6wG/sJDU2eJfjPV1m0tBYmMRLXKUW5vHYyPEwEH7LoV3mp/Tf0?=
 =?us-ascii?Q?PG20MgDja1nHW7UjHKbMxl36y+ylrzKmiM8bxNsvJkHCzjTwL+gx15iMG5Ko?=
 =?us-ascii?Q?z/e3yLRhsgCNBwY5TIxsFKyzv3OPtVtQ/e09n5o9JQXpRard3/gawZUa4R5L?=
 =?us-ascii?Q?Lu2DOQLu95ptSDMbZ4USsKdcbbwKAnUtUMsCSMVz6ZBKvOETTIxPJhj7lyKl?=
 =?us-ascii?Q?C/ooVo1gmw1JkNxJEoX8+0wuf9MYuy4f3uZi0R5ddTnKEzGVBNSZz0GZpHTX?=
 =?us-ascii?Q?2vCBg5N4d9xnyT0dwDc+JViWNPxEoLae4W2+SubmdRVr1hbIwfaRR2CKD4+R?=
 =?us-ascii?Q?v1Oo7MYQWA8vJWaRq3m+os4NoodBT5soAtv9BF13SEO5Ml47Env31v27GYcb?=
 =?us-ascii?Q?+pMprN7ecnr34vVKN+Ohq3kuHmp75j24Mf/4TKsEu3J+rIPa1ftuWqwCym6L?=
 =?us-ascii?Q?lNbgZX0lksYr2vnAPDk135b7IrRDVtuHchRRSc4iUrW6V6S/dtbHQxNfsj3b?=
 =?us-ascii?Q?pPYSX/2iRWQy4sFg1K5UoV32MjdRcf8zlBogAstAzIgNw+JTu6gRHoEGoCVI?=
 =?us-ascii?Q?z9KyHrW5nWwvpZ7b0zNuZAXaT3rQgmb9dBgpWPtiWPK9T6sVDGRYlAQa6Y13?=
 =?us-ascii?Q?xGbq5FnqsCSqCRdqYMHZXZBgXH0FUJo=3D?=
X-Exchange-RoutingPolicyChecked: krfpYZgqVzOJj02WCmkkY6NkVSynGSOnt/bMpjAliFVGUxs4et3u/ZHZKtZaunFPLRrEX84VDTuF5GOpfvnG5V66kdanoWYmImI4Be00/K2sDSPUurKBwKBpNAE++g6zofhLkSkbkXZbJjiGbz6P3y+ZIBnMXbixhfPhbHKg9QwwJW7pPD2luihtuLVLjqA2GZd6GKgMpVE0/jB+4Yn/2AH4L+qNZ1wuZixdT9va9wDiFsVY6kPcq9XP8zPg70n12u8Jv0W9YT4vfCgrxWl0gnJADnM4lytdykkqPCXNtZJbUGOYXcPEt7zvgjmKNJCCuK8QxA4qZBbVN9a+Kjal4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c8cca0-21e2-4489-27ea-08dee75c6ee2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:15:31.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXUKYv9rs0JYCD1tP1UZvqeyn4AraDoGlWpZFhLKQxUXScUr/rvJYLEGDeaGPNvbDTx3PLsagn6Y4ojZY7kWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
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

On Tue, Jul 21, 2026 at 12:12:01PM -0700, Matthew Brost wrote:
> On Tue, Jul 21, 2026 at 12:40:38PM +0200, Jan Stancek wrote:
> > HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
> > and CONFIG_HUGETLB_PAGE are disabled:
> > 
> >  drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_assert_458'
> >  declared with 'error' attribute: BUILD_BUG failed
> >    480 |                         order = HPAGE_PMD_ORDER;
> >        |                                 ^
> >  include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORDER'
> >    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> >        |                          ^
> >  include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
> >    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> > 
> > Guard the two HPAGE_PMD_ORDER uses with CONFIG_ARCH_ENABLE_THP_MIGRATION,
> > matching the pattern used in migrate_device.c.
> > 
> > Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate_vma_setup")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_pagemap.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index 15c78eca180b..53a78752c8be 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -578,10 +578,13 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
> >  			folio = page_folio(page);
> >  			order = folio_order(folio);
> >  			cpages += NR_PAGES(order);
> > -		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> > +		}
> > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > +		else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> >  			order = HPAGE_PMD_ORDER;
> 
> Would it be do something like this at the top of the file...
> 
> #ifdef HPAGE_PMD_ORDER
> #define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
> #else
> #define DRM_PAGEMAP_PMD_ORDER	(-1)
> #endif
> 

Opps screwed my snippet up - HPAGE_PMD_ORDER seems to be always defined...

So actually...

#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
#define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
#else
define DRM_PAGEMAP_PMD_ORDER	(-1)
#endif

Matt

> Then in common code s/HPAGE_PMD_ORDER/DRM_PAGEMAP_PMD_ORDER/
> 
> I think this works as we can never get to the MIGRATE_PFN_COMPOUND code
> paths without CONFIG_ARCH_ENABLE_THP_MIGRATION enabled (see
> mm/migrate_device.c).
> 
> Also btw fixing the unrelated bug Sashiko flagged in this patch.
> 
> Matt
> 
> >  			cpages += NR_PAGES(order);
> >  		}
> > +#endif
> >  
> >  		i += NR_PAGES(order);
> >  	}
> > @@ -733,7 +736,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  	own_pages = 0;
> >  
> >  	for (i = 0; i < npages;) {
> > -		unsigned long j;
> >  		struct page *page = pfn_to_page(migrate.dst[i]);
> >  		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
> >  		unsigned int order = 0;
> > @@ -763,7 +765,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  		}
> >  		migrate.dst[i] = migrate_pfn(migrate.dst[i]);
> >  
> > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >  		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
> > +			unsigned long j;
> > +
> >  			drm_WARN_ONCE(dpagemap->drm, src_page &&
> >  				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
> >  				      "Unexpected folio order\n");
> > @@ -774,6 +779,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)
> >  				migrate.dst[i + j] = 0;
> >  		}
> > +#endif
> >  
> >  		drm_pagemap_get_devmem_page(page, order, zdd);
> >  
> > -- 
> > 2.52.0
> > 
