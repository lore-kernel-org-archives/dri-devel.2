Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73D5C61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1702410E25A;
	Mon, 31 Aug 2026 05:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzqOKUwn";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACB510E25A;
 Mon, 31 Aug 2026 05:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9ZQBEZkfjuPc24MpEIXKXa9WNg1XcRtrAYifDUPmPVev3+mxNsx/FlNxR1VtMu52s6KjpQ7QDOR4V+Br3maOYrg0sMkwDUPi4SWA4PV6aiV2DhIy+YQlpdjtfUz2VVb5hUqdfJyofZUUmtX2rQgqEen3DwKOKnmWo6uaxEX1bHYCKUHMPm4vW6fUZMli302KQVuPMa2cZ0pNKpx1inzT2CexOjQxHXsCi4X+sEoqVjtFZUVCIDhTE0UG8A4SS6quUeSIenaj0teeJ8GHg/k75GZwEAn5o3+sB2c9cERP9dSJDAoVoOmLahfV4cieUFm3fgoYJJ2atIdlIBOQlrXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JX8FrspF9mz5JgNzfe3Zbxj2lHZg73TVdeckQ+msU8=;
 b=DWM86mQjwlkpuK4bvlgN/cVKCZSbRpALHW4SlAs2FhWV52pHEn5JqJuOxqk1pNJvKXGrkHOYE5QDOHL3JF/DJCBp8OrTS0OYnxkzfsXul3JY+SsxC8Q1Jw/91rMf8CaQEIFhsJkxq2P/Y5G4QnMBcAod1193qpgun8BPmG/RC3eo6v7bEuOJ0XwDiJ8J49tpETqfIH/ybQE2iwLD4NcqfkB2LLwBladVxLPdOsLznFxSNyMbvxkXQqs5LM9a4wfl+jSXt+RF9y27EpIzYgJAoNzl7hogH4dOTgECyqUn6CGKXKO8UP2GC2F9+mYqMHv+My2h2lz4PssK0Iyy1Pxd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JX8FrspF9mz5JgNzfe3Zbxj2lHZg73TVdeckQ+msU8=;
 b=FzqOKUwnRVvRD1FaNZOIDT0ua6yPjLOTNyt8+uOJ+a6pwIwVz9ZLkEmxLK2bNI4r1GlMvE024EZvRpgbzqluGwOcOgEoj23a1cqBPzjXQfwqA7eDqeGM4gch4km+W/4sYfAv5KWrUROhw0piZdGreduFRRHzQNfQgAgwjDMN/hU=
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:58:20 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:510:34b:cafe::86) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:58:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:58:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:58:19 -0500
Received: from junhua-PC (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:58:15 -0500
Date: Mon, 31 Aug 2026 13:58:15 +0800
From: Junhua Shen <Junhua.Shen@amd.com>
To: Francois Dugast <francois.dugast@intel.com>
CC: <dri-devel@lists.freedesktop.org>, Matt Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Yiru Ma <Yiru.Ma@amd.com>
Subject: Re: [PATCH] drm/pagemap: centralize migrate src base-page counting
Message-ID: <20260831055815.ixwjr32n7lprwpqw@junhua-PC>
References: <20260828083652.40855-1-Junhua.Shen@amd.com>
 <apFY3QDowfV30Xoc@fdugast-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <apFY3QDowfV30Xoc@fdugast-desk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6a6915-7bf3-4f0b-234f-08df0724dbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ohbxFUwGpxf2bRd7p/rS9Sz77STYUaRcvvjcygVlHJqrZdC9A5fhGcXLeh8FhsaJ4/q6JONIsEJmxJIdCcnVqCtL72ZAbjNqWzhePH/trM5w+ckphsZhFDZ2cPjM8AneV7DbGxnFDAdZknv9+DZvsGvHNNnJAIRx1xKaRG35G9CHDuQi1y3t8Qann//07b9AjVFRnrdekvs9MbW3bl8rq/Ikf5CS2rh5lFe3P3E33PqypFMY+p0B35RH5O+zXOliVFZsDPsrAokxCtADzxf9QLwKUW1yr5pdOaag3sk0198GaxZ52oQyapDfdEKz7/zw/tv5jUNlUVLlBtydV6CelX+xYt4/aIgAeK+fMN0G+5GFTkw8YXvdt0bFlKSLvSyYKRMXnT8Q87pGtzM50WktvjbL6wslM6+TgwEGB5MRiCSJfm3zW+eTeh+ZANKVihmoQWkays/3ksNhrFsMG3pf1S23DVhhIUC6ic/+hJbd3h94pJrz+DJG9A+5xkLCTO9Su2pV/6pJCrRIAJaqL4YcgSYmVz9NR7n+tOJK3eGTlaM0h964IkLBp7v1bCrOKME1WEyQ5t4OmVkPKnUQ/xLEgqwJhqZaSeL3Idha1tnFQM/ORSUjq4DJsaoNdo0qEKWOlg10GhDv+vvrubwJB/PrCWKkLoT5wrHapeYQdR9avSpk0xMAHC4V/zy77TORWM9le5GbkVOi3aBCoF0OkPgpOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: biDTzMlFtMdwN0VMzIDsz5CcmE3Zy/O0X5XcB2TgXCmPSCdtBmCCui2FwqbnjIfjn1QCJC8titeposPkqwA2xwndbI2JUbNevPICGpVZQJ+tBqiVNekMQdn9XVzPiFyoDoY5zkOOSS7vll/vH5N5+aKc1dzMpgkh3UsowpNQjng72H2YCdS0oTB71dFWGon2Wq1hm8wHQW67Twu2nllApijeOaytsU4Rz3EKydLZSY4In+1YkMyooNMWir6nXMtX0tWKwtEzTJLAt+uZh2fNlPpjV39BhtGoptwXXiQkYBDllMzRK9FbzcSoXbBV9dnt0IEge3+Q3oLP1WPBXR7ZzPsg0kFIti1OZU4NavM4+2IpU5JIZ/mOullhIRVZwiXFsI+B2d18ZyIX9rkUp7yLjcSxDdNNEAKjeYc3P/2q/Qjme+gVcGgFQE8rQhiwRZJe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:58:19.6530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6a6915-7bf3-4f0b-234f-08df0724dbc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

On Fri, Aug 28, 2026 at 11:46:05AM +0200, Francois Dugast wrote:
> Hi,
> 
> On Fri, Aug 28, 2026 at 04:36:52PM +0800, Junhua Shen wrote:
> > 
> > The base-page count for a migrate.src[] entry was open-coded in several
> > places along the migration path, and these variants handled
> > MIGRATE_PFN_COMPOUND entries inconsistently.
> 
> Nit: not just inconsistently, I would mention the existing undercount issue
> this patch fixes when VALID=0 && COMPOUND=1.
>
> > 
> > Factor it out into drm_pagemap_src_pfn_nr_pages() and use it in
> > drm_pagemap_cpages() and both accounting loops of
> > drm_pagemap_migrate_to_devmem(), so every site agrees on the base-page
> > count and iteration stride.
> > 
> > Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
> 
> Consequently, we need a "Fixes" tag here.
> 
Agreed. In v2 I'll lead with the bug (VALID=0 && COMPOUND=1 undercounted as
1 instead of HPAGE_PMD_NR, risking a spurious -EBUSY) and add a Fixes tag.

Thanks!
Junhua

> With that, the change itself LGTM:
> 
>     Reviewed-by: Francois Dugast <francois.dugast@intel.com>
> 
> Francois
> 
> > ---
> >  drivers/gpu/drm/drm_pagemap.c | 60 +++++++++++++++++++++++++----------
> >  1 file changed, 43 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index 892b325fa99b..a31cc4f0af68 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -554,6 +554,37 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
> >  	return ret;
> >  }
> >  
> > +/**
> > + * drm_pagemap_src_pfn_nr_pages() - Decode src entry and return base-page count
> > + * @src_pfn: Source migrate entry
> > + * @src_page: Optional decoded source page when MIGRATE_PFN_VALID is set
> > + *
> > + * Decode @src_pfn to compute how many base pages it represents: use folio
> > + * page count for valid entries, HPAGE_PMD_NR for COMPOUND-only entries,
> > + * otherwise 1.
> > + *
> > + * Return: Number of base pages represented by @src_pfn.
> > + */
> > +static unsigned long drm_pagemap_src_pfn_nr_pages(unsigned long src_pfn,
> > +						   struct page **src_page)
> > +{
> > +	struct page *page = NULL;
> > +	unsigned long nr_pages = 1;
> > +
> > +	if (src_pfn & MIGRATE_PFN_VALID) {
> > +		page = migrate_pfn_to_page(src_pfn);
> > +		if (page)
> > +			nr_pages = NR_PAGES(folio_order(page_folio(page)));
> > +	} else if (src_pfn & MIGRATE_PFN_COMPOUND) {
> > +		nr_pages = HPAGE_PMD_NR;
> > +	}
> > +
> > +	if (src_page)
> > +		*src_page = page;
> > +
> > +	return nr_pages;
> > +}
> > +
> >  /**
> >   * drm_pagemap_cpages() - Count collected pages
> >   * @migrate_pfn: Array of migrate_pfn entries to account
> > @@ -570,20 +601,14 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
> >  	unsigned long i, cpages = 0;
> >  
> >  	for (i = 0; i < npages;) {
> > -		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
> > -		struct folio *folio;
> > -		unsigned int order = 0;
> > +		unsigned long src_pfn = migrate_pfn[i];
> > +		struct page *page;
> > +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &page);
> >  
> > -		if (page) {
> > -			folio = page_folio(page);
> > -			order = folio_order(folio);
> > -			cpages += NR_PAGES(order);
> > -		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> > -			order = HPAGE_PMD_ORDER;
> > -			cpages += NR_PAGES(order);
> > -		}
> > +		if (page || (src_pfn & MIGRATE_PFN_COMPOUND))
> > +			cpages += nr_pages;
> >  
> > -		i += NR_PAGES(order);
> > +		i += nr_pages;
> >  	}
> >  
> >  	return cpages;
> > @@ -703,8 +728,9 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  
> >  	/* Count device-private pages to migrate */
> >  	for (i = 0; i < npages;) {
> > -		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
> > -		unsigned long nr_pages = src_page ? NR_PAGES(folio_order(page_folio(src_page))) : 1;
> > +		unsigned long src_pfn = migrate.src[i];
> > +		struct page *src_page;
> > +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &src_page);
> >  
> >  		if (src_page && is_zone_device_page(src_page)) {
> >  			if (page_pgmap(src_page) == pagemap)
> > @@ -818,10 +844,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  	migrate_vma_pages(&migrate);
> >  
> >  	for (i = 0; !err && i < npages;) {
> > -		struct page *page = migrate_pfn_to_page(migrate.src[i]);
> > -		unsigned long nr_pages = page ? NR_PAGES(folio_order(page_folio(page))) : 1;
> > +		unsigned long src_pfn = migrate.src[i];
> > +		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, NULL);
> >  
> > -		if (migrate.src[i] & MIGRATE_PFN_MIGRATE)
> > +		if (src_pfn & MIGRATE_PFN_MIGRATE)
> >  			migrated_pages += nr_pages;
> >  
> >  		i += nr_pages;
> > -- 
> > 2.34.1
> > 
