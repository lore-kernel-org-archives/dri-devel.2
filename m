Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451DC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA42510E3AE;
	Tue, 21 Jul 2026 19:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lPFQuX90";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BAC10E3AA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784661136; x=1816197136;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Lc4oAFzHuSgs1kW6hwZmcDHY40smwiqVdPy5OqrHcQw=;
 b=lPFQuX90QYYCewet43N5zHzh+zM4/TDt0tiaP1NmoPO+T5FMocQWTfRB
 fYCbtSOGA8MAK7RNMMiMoBqx1eWxanvmEAqD/IaFYEwVqoqfNwqY5qe4l
 jBQE97XuUiWneIGGMBjoFJ9rNzIsQLj7OGlc2BohhhfT26OUQosOByV/N
 5XXWFlTtjeUHpmdC622JMoyljInE17wDjGdEetQbxRYNDv+olYt0tU+QM
 rpCuW8hn+bOYWcUVrbhS/I+5nM4/6CLk+JnGqxjUV9jYEvMuqTGQUpd1w
 gfwLSSIOt5vNU1v/tP6FQZCRVjy6Nu6v1bhxnrIx0vJkAX2iFqtt/4+Y8 g==;
X-CSE-ConnectionGUID: E2u+MxxrTVGizlmJ1OLRpw==
X-CSE-MsgGUID: /iDoT7psQ7eKVycycX3AAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="87808971"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="87808971"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 12:12:15 -0700
X-CSE-ConnectionGUID: 3x/35f6kTFqYx2F/6ShzEQ==
X-CSE-MsgGUID: p7XH7yHaSCaYdwXQ3SVnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254428695"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 12:12:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:12:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 12:12:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWdbEGymzZxorJGh3zq0sbvfK3BDjsMnaU2syhRB+iHJDdzbznBbUylc2Dxi4+r22tAUXFVQ1vX07cE32nui28jOYTV7t/lNEEm4EFKJaYbUtVDeZWiLoMG2T67nUdaGfFahe9YVw3p9MqPhhl5TtQm2Bv2KWFQWH/yer8JchC6UEdOsTeLOW3dwc8r3aoWyG1kMlt+uGFDtrFqcerh7uxg4ckFMQr5zU+CGSvVkXs2aUK5gRPkrENQJPRSbF4Dvq5xufc3evMe1YPM+kQKdRitkhnZKZ/8IMJ4/omf3YlPXCrPoyCiMfRDrZvtG+ynBXev8qVQhbH2wG7TNAfMLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf8krg51x+32tfe8z35Kxlos0R7ER/VcjAeSHYgm3Zg=;
 b=qAmYJSpc/iCP2PuYFi2OCArbi1SolPr1XltB/Sohgf6fh88snn92xzJ/mmseHNNZ8kGKQi30X7XmUNcLUchKiCpp8g5XbxZdLrPp4PB6cyPytBFtmmnkKMebpXJF/x3GLeC6CoQjiycLf0v5idacggVK8ZY9D5x+DIrJW9kHvgHJmoqcQB1i/skwL7LgWHprzID1NCPFHWJ1bVNlWLno8H+EKI9VH1j94KpzcrVwfsrxd/aBu+iv5x4iGQ9bKLrQfNz58U8nCcjmdP1dTfTbZXNhHlUP7VsfwMW2v6PoVmtOmkz8+lGfIEUekAqq0LcaCPtJw+V3zBL5DtJ3KdWalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:12:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 19:12:05 +0000
Date: Tue, 21 Jul 2026 12:12:01 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jan Stancek <jstancek@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
Message-ID: <al/EgTw/D2mC42pT@gsse-cloud1.jf.intel.com>
References: <202607201914.LpAGsbXs-lkp@intel.com>
 <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84a35e16f72330d6e7b2d6e969040f36959e2dad.1784630290.git.jstancek@redhat.com>
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: b1479710-5c67-44bb-c11e-08dee75bf396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 2kshGSwnPDoyI3Ldx5+BZFiBT12b56K7TJ5CLo7NqELXnPeO7G2e7dQnbYMKUQIiWiUj9RG4Fxz1Q442P8ft/J28d3aq5c18YO6JB1Rtxb1xVFh5hlrHMdghEmKJ8UL7pOi4GT5Q2gj/O5pwyWBJy3QswKhptOQDz2J5DKRcYufqhT+B4vsA4g9i0WSqyR2Mp9zfZeWqs79J/4trLaF3GgbPOZuyBzMf1rVduZ6BQ7a4uKXtEtL1Vv1KKhpAdtBBDoDkEFPTpoKxKI8fYK1vcjkfvheJaQxcgikVLADAJrYukrCPUaMqeeEGpfnFJiD23RvU+s35Z9fALUSI5EpOUlWDZfxw2/RIvgy8L9BGUHowXTNONuarSHmeJspYMusKeJx99isMpVhaXtR9H/lmYvoZl9f0MSr0p1UXYbm0cJtwve/VOj7pEH8XLXyIO2naUwBZinWXMJmx51V8LAV99GfwkfDS+4qKXZWmKjSaVzhG9Bj14IBLrqqTZ01shPIgSsLs4Fc/14kCfqeyzNhmJ5gDJdLTteFdoV+cU3fFhyonMcNPaqwBy+6sOa37R0Lv5yVUatxeRgWm7vandlshhkra8snxvJP4l+6n3rrwZY04gdYevJT0XTcxFhPYx/hnrIQK8qeUAM6i2d14ywlYT8EjUzZPWTHTkuIOy5xwnwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5bOSwnWG4LwHcBgzLAnNk5KqW6qRo82CWuo9WsvYHbOMmRw+zbC8feczPvN?=
 =?us-ascii?Q?28X7Pe91G/XGozhQCv4vEqZD5nKpA+SC+y3OU2L1HYaNQwVEUKukvtfQP76p?=
 =?us-ascii?Q?6s22LAvpZq1H2FTzhR2a+Ai+vfvRC1IEvLo5lOAqN/zMwPBmjJd6Dx2pkOhL?=
 =?us-ascii?Q?RNzyPxjg4+BvKxZqN+RQldSsWvFzidIRugJ16E/Cs1Qm+YZqToxBuqXCljbl?=
 =?us-ascii?Q?Ottp6vqDTKFrtr60fVulOcQIl+EaH/FH9GutP7Rjnq3xVpTfm+Ywdo81H9CA?=
 =?us-ascii?Q?HkRVrrSlMAE4sB2JvESHv60/ZRNUZRwUuAvTNcyjy4kd83+LSqH5l4RpkWKb?=
 =?us-ascii?Q?+DxmNDcDE0399Jep5OboPB7+JmInRgy86w0Gy9eW3qm7fU18CK1gBHSbBg1g?=
 =?us-ascii?Q?6CDxPtxgJmOEWkgUoFFMuo8ZX6VhIBLhE4Twd1U4zWF96rnUPbbTWrVbFy3n?=
 =?us-ascii?Q?SnFK/QDjwNM8Ds/XzXTr/tQ8P+JQXKLz42p/TRrsTdfBwDznDCZBupNdT79f?=
 =?us-ascii?Q?Vc3YOPCjXJ9FlosSdu9F6XOoIV4ESTYtsSs2ActKvrUfWo6rMl0lxqmKVqOP?=
 =?us-ascii?Q?tw7sc+M1wjLFlW1MBeOt89f7+InP8mv8OYa2NieWSX+m5ThpJmtzPL9K9SXc?=
 =?us-ascii?Q?l9A0T+8r7oX6M4+8CgQ5HHXluNQzwSIgyF210oUduQSDpeHWSKu8U32iB9xq?=
 =?us-ascii?Q?GT0mmMoCNq4rCwcp/Li+HEXrXkFqhLVvUsSqTYip+0wRAf+DS/e0mb0Dm7B3?=
 =?us-ascii?Q?KUQFIOdXYy4iIFnYUcAt4MPZmU6t6/i2X42J0HO7HlZwNXUi3IXbHrVIJ4RX?=
 =?us-ascii?Q?4WjppGtespC9QuHTar43a3STVzEQY4pje6FiXJM9yCWFAt9DzaHBg0eZS8Kz?=
 =?us-ascii?Q?eNucLHRw9rlHims+NR04CEKe8U8opfxVXU9E6HS+ENs2wHbsWeg26/Mza3oR?=
 =?us-ascii?Q?olh1+h9t57SIuJ+EINPu8Y6eg5S1Ei1Yw9i5Z+gwniDytCSKM/1h+FItHap/?=
 =?us-ascii?Q?zsrt34IfiYRc/aupnUf9e7wZUnYBU137RZYRrSiZ/fFjHoqpvKNDQpfNxVmG?=
 =?us-ascii?Q?Y7nH5N8tGi6ThGCoQvQAhYm4qRs5YDBqMK0tnVd11O98GEx0hQTGPs8sdUoi?=
 =?us-ascii?Q?gCMK3VJ6Dq+n/0HYkbkDw0xIJrbFfFRmQM2Gfi77vuC5kpD47YfYkXtmj+kv?=
 =?us-ascii?Q?YKhCW6jw/NF+7jX9Ul5e2CwwHEQOvh4ub/ThNO3n6Qc7U907/pPcPagBY77Y?=
 =?us-ascii?Q?tiIE7zqLTjjGKVcJxhQEdN0nxzeNJdsW8Xu9J34c9XxSPuE/5yVEEnTHq/sO?=
 =?us-ascii?Q?xOlhrT9AzSea96xa18sE4mwD/a7c7dtzbDFaeFYVMJXoGeP+l+xkDZ4BfA6c?=
 =?us-ascii?Q?9Dkw08nufRlLVmMbPqDWc0RmDtX0TgEmANzbrwLPQiVAunWEkxsmM5SQl17X?=
 =?us-ascii?Q?pC9Jo/5RLMPIdCOWdM3PfY6z82+Zg069wbNroPnl69JicdLZUyUKbtsC0i0n?=
 =?us-ascii?Q?yBB3mctUYpj5ZHxHv7ThSDgxXTAfPMyGipfyoLrbHpW6gi2AYl7oL7vZxZ2d?=
 =?us-ascii?Q?VTddKJb0hPXeGz5wiEQXv1w5rSdpF65zAtIk7yzJj38EP8H3E0e17IZ1xPhT?=
 =?us-ascii?Q?TAXkzeR/AjcNm9Mpxk6Te0UM9/cLTktDVAKkv2MhbUVvXXFgmwUerfAd0ZDG?=
 =?us-ascii?Q?KWzQJdXdxHQCe45crNgWpuTNkj6vHAhDTmRgAILpWTitrz0I//+kKAoQuHci?=
 =?us-ascii?Q?l1MRNDdJxw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oGisN1Md8hXUvK+komJqUT6oUuoKJUG1QGK3yKqqWCM+CHniydPGKYt6iV0zheYughDDO8qoNWkc91lMurwRZkMmSIk9cNnFWpBMZDRMOB+77T3z5mppe/h8c5ug1gridB8HivrYjTClahP7jqlTnizjN/iv7zXmNveijy5DYrR0KhvXSG3NQ3iyantApRc7u9Ig7LNN60/NCXPewJXqXOGKsQpHTIlhglqKzZQidt40XNQ8Nn6WxtuOf7oRNdy7sLxLV/unl0Kzych2xPUq7tYaxJxhIRO9q4ihOaUQQqtm0bHxhKrrihgIuDKVet70el8YkFhNufCI9oO5Gx8cCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1479710-5c67-44bb-c11e-08dee75bf396
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:12:05.0286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr1fm5on9BKo1Bw/DrY3tsKPSQzxnUszoc6WUxTBrrDGCTnwNTURUtntfGCCfpvc6JbG76Im4WOJEPIw6yo9+Q==
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

On Tue, Jul 21, 2026 at 12:40:38PM +0200, Jan Stancek wrote:
> HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_LEAVES
> is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
> and CONFIG_HUGETLB_PAGE are disabled:
> 
>  drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_assert_458'
>  declared with 'error' attribute: BUILD_BUG failed
>    480 |                         order = HPAGE_PMD_ORDER;
>        |                                 ^
>  include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORDER'
>    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>        |                          ^
>  include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
>    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> 
> Guard the two HPAGE_PMD_ORDER uses with CONFIG_ARCH_ENABLE_THP_MIGRATION,
> matching the pattern used in migrate_device.c.
> 
> Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate_vma_setup")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b..53a78752c8be 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -578,10 +578,13 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
>  			folio = page_folio(page);
>  			order = folio_order(folio);
>  			cpages += NR_PAGES(order);
> -		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> +		}
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +		else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
>  			order = HPAGE_PMD_ORDER;

Would it be do something like this at the top of the file...

#ifdef HPAGE_PMD_ORDER
#define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
#else
#define DRM_PAGEMAP_PMD_ORDER	(-1)
#endif

Then in common code s/HPAGE_PMD_ORDER/DRM_PAGEMAP_PMD_ORDER/

I think this works as we can never get to the MIGRATE_PFN_COMPOUND code
paths without CONFIG_ARCH_ENABLE_THP_MIGRATION enabled (see
mm/migrate_device.c).

Also btw fixing the unrelated bug Sashiko flagged in this patch.

Matt

>  			cpages += NR_PAGES(order);
>  		}
> +#endif
>  
>  		i += NR_PAGES(order);
>  	}
> @@ -733,7 +736,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  	own_pages = 0;
>  
>  	for (i = 0; i < npages;) {
> -		unsigned long j;
>  		struct page *page = pfn_to_page(migrate.dst[i]);
>  		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
>  		unsigned int order = 0;
> @@ -763,7 +765,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  		}
>  		migrate.dst[i] = migrate_pfn(migrate.dst[i]);
>  
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
> +			unsigned long j;
> +
>  			drm_WARN_ONCE(dpagemap->drm, src_page &&
>  				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
>  				      "Unexpected folio order\n");
> @@ -774,6 +779,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)
>  				migrate.dst[i + j] = 0;
>  		}
> +#endif
>  
>  		drm_pagemap_get_devmem_page(page, order, zdd);
>  
> -- 
> 2.52.0
> 
