Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B632606D807
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ImCYb3Bx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9404B10E0F7;
	Thu,  5 Nov 2026 02:49:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5121810E0F7;
 Thu,  5 Nov 2026 02:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793846959; x=1825382959;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9sCC2joNasExCCiZfNuMs42A4zrADRxEbu4X+EFLN2Q=;
 b=ImCYb3BxTiOAQ/hGuHhrznpy1JV48OodFb+SUulstQfPweqKMvGwjiaA
 pHijjFLkwFna2L+Kv34FFDWW2ezXheruanAKsEHYrpBLr9ukbThqjXf2z
 j0Sg8yGwnVgnAEm//zvs45gKI2ZdMkAFeCFt249MNd7g4/uigobXRSruL
 vdYoG/pu1usBdnved8WJeNAEvmzdfnUJ3epg51jR8zQ5534CNrKS6P194
 VhjV6nNPjK7OE2hb+AYpbqkHHcL1WSZ0JrsQ5uzNzxIyGC4IpJwVjEatp
 DivyDAQusZSvXeJ4AhYEyp/g5DfozVV4+ASdjdjs9/OhScPlVyYxx4snT A==;
X-CSE-ConnectionGUID: 3kT/L33GR3yTt+3uvaZebg==
X-CSE-MsgGUID: X5F/UTPUQYqmK9RhXmgH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2626746"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2626746"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 18:49:19 -0800
X-CSE-ConnectionGUID: 1a5KaxCLSMuZb2h2JC05Lg==
X-CSE-MsgGUID: qVR5rrTHSHivm+ZJOy9k8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8742979"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 18:49:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 18:49:17 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 18:49:17 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 18:49:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTce/y9Fy5+8aJcu1nLr7DkZhzBV6IrDIf73JtPAGiRQf/XBhFBogOtnrIHtMklZaOlUPyz9CgU0Tbu9j841SkfBtOeRBLYVmKRf2YyH6s0gyySenb9KHIpqeXDJBRJi6H5pqclWsFPkTnfjkTXd4hcGYqRwlnGJW8gN55CEIkgfxElZeD8nGduDi5Aitjs9xtsaA8vNRMu2g/qjArTlxA+do2MdcAgs7fNFRCUqfVwHhkFRzUKm2lAUBr/QMSa7Up0KanDc3y09SxmdL4hYMfpuXeSHBDGcMLEfFETa3yqfWbsUMiA1cxMv/kfvO+y4P24iSu7X5BCa2J7/QwwVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29+hELvaAfCnefaHLFjWMU5icJ1IfTRGsivMqRLJQ/w=;
 b=NdfRrP/Zil2Yk+/CwMMfUrByOn32TlhWZ99TSKs59o24RG4In12ZTZCp9vELOLLzZ3Cbq0XbI9g7JJhfRuiv1JxBkY23vQ250hPDTivb6Ujp3BI9vgNiuUOH7mPs6WjVh93U9DmR60TVtLBgMdSr6RDU5EYSs3pveIEmRuScidaKk8jQJHoGWQsu6dfaLhRta50u/wfyTCJq9lsyQr6vMfwZNWlHJXNFDzSERyIZlwewQxG7kYwsKtSuOcEjK2Kx5NpHYpa9HXSgfYuKdyBXDYmNY6JpogMMs4qtF0o6e7ZgkV91rbbg+g9jdPMQIYYe21uEcNJxEbcPlnidq05xrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 02:49:14 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:49:14 +0000
Date: Wed, 4 Nov 2026 18:49:12 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
Message-ID: <auvuqP4O68IfuBek@gsse-cloud1.jf.intel.com>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <20261104215228.1533692-2-matthew.brost@intel.com>
 <auvY60zG8V-Yq1Kx@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auvY60zG8V-Yq1Kx@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA1PR11MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d5a34d-282e-4f74-a647-08df3ae7607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261021123027099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261028144727099003|261009221227099003|261022075727099003|260925021311599003|261102130727099003|261022105027099003|261026140227099003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: oZ0ukz2WFBtEemug/pCM9+YKfZo5+2H8c7LgzjBnA/XlqzOYkvxYTuwMyCnDj1OClBPGobwmgN/RZhgxo/lwDmB8ZepSyXiCYZWoPL2GQmA4XZ6Gf7jXe2N2W85oLnLH4y5+HqgqLpJpThO8XlYtAP2ZtAmDokO64/74UehoKQiFqgeDi3AuZdEzcpfS9F5WqgWx6c6N3Y789cY3BKNJwuGNVgsVxncgbhZTmPUU5P4wC7Du+CIXMLIZTGcaMFiZe97/GNSGHfe3Zjzwl+oEfOOFIhxEKNPZSI4EfOFpwIaDn2qpGMS8kW7fiRMaIoMb2ir+ecVRi7U7FHwWp+zUKDaMR1qI4ONII8w4NmeF2b+wa8B625cHCwzgTFZlWKF9WKB0SR5G6IUriVbcnhEI5nUSX30R3rTP1WOT/bXvJUiZzE3oGO7lSo3Bd9h8eYFcduJgU7EOQBNs9+HtjH4XITPxPAgn7uRwl3i9k5/UoM4XVtBrJXnGM8mf70feZWcKgAdHAjRHWL5nQpEpoxFAymArbxR72p6Ra9oSf4hKqhGJlht9oFptsedYiBFSTSPu+ggBXM+yc7e01MqTNvZP0EGz/A2G9dSoqihLNkomTl95C0PL/N1Cfw/b9lwnJowsAB0AjxJWVDBQEJmxnfspYh4kljcJSmTRa6b9L7GqjMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261028144727099003)(261009221227099003)(261022075727099003)(260925021311599003)(261102130727099003)(261022105027099003)(261026140227099003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aR1RV/Xcla/n2YPbcebY/Kr4QSEXJNork+k7U+HauTPqrg4CMNzGm7Quvr?=
 =?iso-8859-1?Q?x6qAncivKY/fxalUF5Fra1TQAyNiactZbz57yyViPKa5N0Lm71XkOw0xks?=
 =?iso-8859-1?Q?X5dycKVaHB1L5gt5hFiVgsX7RHNVjroVZVUjo54S/qXPkyouZt/J+NMXDh?=
 =?iso-8859-1?Q?q9XjJa6H7KtwprB3Rdg6CSPp6b2ShKVjIT0oOfoBiD4W2hhnRyC9in73Aa?=
 =?iso-8859-1?Q?gr8GO7C8h8f2aou0ptCmoQmth/7eDSnpeVE6T6CgxJUKic6L2FJswuUZgp?=
 =?iso-8859-1?Q?UT9WGMfYMKxTSfpL/l8M8FOIdhRT1H6y7tiAbtM/mg7PKMSCdzL2jBqn5b?=
 =?iso-8859-1?Q?t15WzucNhpBjMXv07YZVqnmd5EDudwvdvtOiqjO9b4TD88oRZEB/l1/n58?=
 =?iso-8859-1?Q?ECkQIqZRfxmePOSSmOrg4ugyijPOE56+zQqIcaT2N0ir1DbiJrynTr0CAv?=
 =?iso-8859-1?Q?ud9e//LkE/NTCntT50efDo2qY32ytVAzOQJtGMMLyecLNAembXlgTXLlH7?=
 =?iso-8859-1?Q?4jSRabRvRsttsEZIRMABZm2O3R/+2cvrcIpmOZ5QS1rqnYb4RhX20CAlKm?=
 =?iso-8859-1?Q?cZadUNUu+OJ0A+t2qIM4nZ1RPncxDhU/Yv1Ui6Tmo1DzSsJEIOTIl+N/ZX?=
 =?iso-8859-1?Q?Y+lu9+ooT7JdIhcwzOPCy0OvmIRcXnbKowL/EYNlus0zBzyNu8NbOeRXth?=
 =?iso-8859-1?Q?QcU5xA1FTKViUnoBPrU7k3lCp+CWP9/hwMVPZeAXxcP4xsv8K958WlhX35?=
 =?iso-8859-1?Q?1XM5ji1qd/CrUDaE/DwVLqaAmRkjklH4ul9aurB19baRLtmUn4MZST0f/U?=
 =?iso-8859-1?Q?x557Mo9rFfJ/OwOIrVC0QKarZDvil81cbx4iidrZDYjZsMzno1nsR0Jc1v?=
 =?iso-8859-1?Q?Dhvp/4D1rT90XjbqqR1qHPUkfrBaspG0LoatP45kD4+ogZQTa+vbqTidZ8?=
 =?iso-8859-1?Q?6/i0YKweS4jIEr85jdHX7H4eQYZ1L0mGWKdkKyN7PSj+uCeX45e7Qw1cCx?=
 =?iso-8859-1?Q?dvABACtR1S6gVLOJ0BROV9DasCyG62RLX/0golHn492RRShg/RVBtiomFQ?=
 =?iso-8859-1?Q?td0v2ZHYCM7uMyLoDEjRiad/z/bzJZsqzU8ywdRHupUIoXQrMbY2ayTM9C?=
 =?iso-8859-1?Q?4e79+cz3uUa/TpcHAiyemQKCA8ccLb/MzV7IrckLNEmnyvLM9NjC1SIOB0?=
 =?iso-8859-1?Q?CDr/snb3GBatphRdI21J8mRJFjaMoypJ+dxqI0zZYuIU4mopq9x7UzVgoG?=
 =?iso-8859-1?Q?jajdgo6v8Z32NtogfhmjU22mPgTXMC/uHNGq/rLVMrxFjYjDZb+p3ylFvs?=
 =?iso-8859-1?Q?oiOOlFBDn1iREbJRf43O99weX59vWru+gLZUeKlbLvI7jjXPYbNAD9DaUR?=
 =?iso-8859-1?Q?Y6Hk3PKa1IoOu5Y7VNg6qIHOwBvKp1ng+/oIBmygsxbmNFTMu8iOIE0Fj2?=
 =?iso-8859-1?Q?4lHAWiFk08o55F5MaAh1A25ASiIzu2nrc3BEAucGU4XX+dQPSvqPaNSbBU?=
 =?iso-8859-1?Q?ThI9DNFMUdn238d758YikeEx9vjm3DGPubVKDC9ipvtMsAli3yMlHT0y2b?=
 =?iso-8859-1?Q?0qhO556VzFfpq+7Rag99po0L1JJ6UVHls+nRYRLRzkMDPvUEeSFLMDCdim?=
 =?iso-8859-1?Q?Ct9zdW9YQ7cZehsvxF5LM2UHPzvcXE7GIku9hD1fJ6yFkeoJLzjUr/tDQn?=
 =?iso-8859-1?Q?oFTvAYXXV6yqLAsVsk0cpYDX1oowiQxfnMHsCeh6so95Eyd+j8xrZjJ+E5?=
 =?iso-8859-1?Q?TDpxCbbSUssvaOaQ31Di5xuBvkyhBgdM8dREKh42ZG0DPu4PlQMaxf2kXh?=
 =?iso-8859-1?Q?S7yv7us/qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 29zNAJ60WcXa62Be0PMhG6VJEAYEAtzzFyaD8Ql6SC7uryHLQEGiMF1c5RyVXMIYVcduclSuiIhIEz7RycC88Y9C0pHWPEsecpbphXcDhb3J74XfDbKcjczYUw+VU0XaYCRN9UKv1iqaGgrHs49sFnf+Dg42O6nEeq5LZhoCZdNi83yaNDZSGXrb9/7vbkweHOdHQiZsxWm+mgU6b5ZW7HF2mBjEl+tl4k0c3Dei/7jzyD9D/qnRFC+mDtCbW1Zql562LvUreS3nNlDOwxCBzvFpK74FmPHwY0LddVcXUHKeQsMPQbc8/Iovp2aCAL4mOh3rzWQcNjEqRq65S9Q57A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d5a34d-282e-4f74-a647-08df3ae7607a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:49:14.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVJIipQTt2ej9xu1OvxYsG3By7QOd9JC7t48RjFNXGWDLCeYGcNDjB57NAlCgY2deAOsgJKJ022h2ZjOS2Netg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 05:16:27PM -0800, Niranjana Vishwanathapura wrote:
> On Wed, Nov 04, 2026 at 01:52:28PM -0800, Matthew Brost wrote:
> > From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> > Expose per-page-order DMA mapping counts for the system memory that the
> > xe driver maps for GPU access, split into two categories: TTM buffer
> > objects, and the GPU SVM / userptr ranges (which share a single
> > drm_gpusvm instance per VM).
> > 
> > The stats are visible at:
> > 
> >  <debugfs>/dri/<N>/dma_mapped_pages
> > 
> > and are broken out into two rows (bo, svm/userptr), one column per page
> > order, mirroring the layout of the TTM pool page_pool stat.
> > 
> > For TTM BOs the per-order counts are derived from the DMA scatter-gather
> > table: each mapped segment is physically contiguous, so its page count is
> > split into the largest power-of-two runs (a segment of N pages contributes
> > a 2^k chunk for the largest k with 2^k <= N, repeated for the remainder).
> > Driving the accounting off the sg table rather than the pages[] array keeps
> > it correct even when pages[] entries are cleared while still DMA-mapped,
> > as happens on the defrag page-borrowing path. Dma-buf BOs are not
> > accounted for in dma_mapped_pages stats.
> > 
> > For the SVM and userptr ranges the accounting is driven by the
> > drm_gpusvm @dma_map_account callback, which fires once per dma_addr[]
> > entry at the exact point the entry is DMA-mapped and unmapped. This
> > makes the accounting symmetric by construction and avoids driver-side
> > walks that could drift across migration, partial unmaps and the iova vs
> > non-iova paths. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps
> > and counted; device interconnect (VRAM, P2P) entries are skipped, so the
> > counter reflects only system pages actually mapped through the DMA layer.
> > 
> > The callback is shared between the full SVM instance (fault mode) and the
> > core drm_gpusvm_pages-only instance used for userptr, so userptr
> > mappings are accounted in both the CONFIG_DRM_XE_GPUSVM=y and =n (but
> > CONFIG_DRM_GPUSVM=y) configurations, into the same svm/userptr counter.
> > 
> > Since the counts are only ever consumed through debugfs, gate the counter
> > storage and all accounting on CONFIG_DEBUG_FS so that builds without
> > debugfs carry no extra atomic traffic or device state; the drm_gpusvm
> > callback is simply left unregistered in that case.
> > 
> > On device teardown assert that every counter has returned to zero, to
> > catch any unbalanced accounting (a leaked DMA mapping) during testing.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_bo.c           | 53 ++++++++++++++++++++---
> > drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
> > drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
> > drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
> > drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
> > drivers/gpu/drm/xe/xe_svm.h          |  4 +-
> > drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
> > drivers/gpu/drm/xe/xe_userptr.h      |  1 +
> > 8 files changed, 230 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 42a6aa1a2e4a..a8031cb9c74f 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -396,6 +396,50 @@ struct xe_ttm_tt {
> > 	bool purgeable;
> > };
> > 
> > +/*
> > + * xe_tt_account_dma_pages - account DMA-mapped tt pages per order
> > + * @xe: the xe device
> > + * @xe_tt: the xe_ttm_tt whose sg table to walk
> > + * @sign: +1 to add, -1 to subtract
> > + *
> > + * Walk the tt's DMA scatter-gather table and split each (physically
> > + * contiguous) segment into the largest power-of-two page runs: a segment of N
> > + * pages contributes a 2^k chunk for the largest k with 2^k <= N, repeated for
> > + * the remainder. Accumulate the count of 2^k pages into
> > + * xe->mem.dma_mapped_pages[k]. Driving this off the sg table rather than
> > + * tt->pages keeps the accounting correct even when pages[] entries are cleared
> > + * while still DMA-mapped (e.g. the defrag page-borrowing path).
> > + */
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
> > +				    struct xe_ttm_tt *xe_tt, int sign)
> > +{
> > +	struct scatterlist *sg;
> > +	unsigned int i;
> > +
> > +	for_each_sgtable_sg(xe_tt->sg, sg, i) {
> > +		unsigned long nr_pages = sg->length >> PAGE_SHIFT;
> > +
> > +		while (nr_pages) {
> > +			unsigned int order = min_t(unsigned int,
> > +						   __fls(nr_pages),
> > +						   MAX_PAGE_ORDER);
> > +			unsigned long chunk = 1UL << order;
> > +
> > +			atomic_long_add((long)chunk * sign,
> > +					&xe->mem.dma_mapped_pages[order]);
> > +
> 
> Here both array index and array value is clamped.
> But in the svm case below, only the array index is clamped, but not the value.
> I guess here we don't expect huge pages? If so, should we be clamping here
> or asserting if order is bigger than MAX_PAGE_ORDER?
> 

What? I'm not following this at all.

The SVM case we clamp the index to the highest order + add the actual order.

Here we decompose a segment to into individual orders, clamping at the
highest order.

> > +			nr_pages -= chunk;
> > +		}
> > +	}
> > +}
> > +#else
> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
> > +				    struct xe_ttm_tt *xe_tt, int sign)
> > +{
> > +}
> > +#endif
> > +
> > static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > {
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > @@ -425,6 +469,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > 		return ret;
> > 	}
> > 
> > +	xe_tt_account_dma_pages(xe, xe_tt, 1);
> > 	return 0;
> > }
> > 
> > @@ -433,6 +478,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > 
> > 	if (xe_tt->sg) {
> > +		xe_tt_account_dma_pages(xe, xe_tt, -1);
> > 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
> > 				  DMA_BIDIRECTIONAL, 0);
> > 		sg_free_table(xe_tt->sg);
> > @@ -1800,11 +1846,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
> > 			ttm_bo->sg = NULL;
> > 			xe_tt->sg = NULL;
> > 		} else if (xe_tt->sg) {
> > -			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
> > -					  xe_tt->sg,
> > -					  DMA_BIDIRECTIONAL, 0);
> > -			sg_free_table(xe_tt->sg);
> > -			xe_tt->sg = NULL;
> > +			xe_tt_unmap_sg(ttm_to_xe_device(ttm_bo->bdev),
> > +				       &xe_tt->ttm);
> > 		}
> > 	}
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> > index e59d4964d811..1a306b6523e7 100644
> > --- a/drivers/gpu/drm/xe/xe_debugfs.c
> > +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> > @@ -7,6 +7,7 @@
> > 
> > #include <linux/bits.h>
> > #include <linux/debugfs.h>
> > +#include <linux/mmzone.h>
> > #include <linux/fault-inject.h>
> > #include <linux/string_helpers.h>
> > 
> > @@ -345,6 +346,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
> > 	return 0;
> > }
> > 
> > +static int dma_mapped_pages_show(struct seq_file *m, void *data)
> > +{
> > +	struct xe_device *xe = m->private;
> > +	unsigned int i;
> > +
> > +	seq_printf(m, "%-11s ", "");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " ---%2u---", i);
> > +	seq_printf(m, "\n%-11s:", "bo");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " %8lu",
> > +			   atomic_long_read(&xe->mem.dma_mapped_pages[i]));
> > +	seq_printf(m, "\n%-11s:", "svm/userptr");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " %8lu",
> > +			   atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
> 
> The array values are signed long, but printed as unsigned.
> Should we use '%8l' instead of '%8lu'?
> 

If we ever underflow that is problem, I guess %8l would have that clear.

> Also, under each order column, we are not printing the number of pages
> of that order, but instead the 4kb page count mapped in that order.
> Is that intended?

Yes.

> As we are counting huge pages in the highest order bucket, counting the
> 4kb page count seems necessary here. But perhaps needs to be documented.
> 

A segment can be larger NR_PAGE_ORDERS, thus we clamp large segments
into the highest order. I don't we really need much an explaination, the
debugfs clearly shows if we getting higher order pages, which is the
information we are looking for during debug of perf problems on iGPU.

> Niranjana
> 
> > +	seq_puts(m, "\n");
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
> > +
> > static const struct drm_info_list debugfs_list[] = {
> > 	{"info", info, 0},
> > 	{ .name = "sriov_info", .show = sriov_info, },
> > @@ -765,6 +788,9 @@ void xe_debugfs_register(struct xe_device *xe)
> > 
> > 	xe_ttm_vram_debugfs_init(xe, root);
> > 
> > +	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
> > +			    &dma_mapped_pages_fops);
> > +
> > 	for_each_tile(tile, xe, tile_id)
> > 		xe_tile_debugfs_register(tile);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > index 273e2c45fea9..c40bb8f7c697 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
> > /* Number of allocated struct xe_device */
> > static atomic_t xe_device_count;
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
> > +{
> > +	unsigned int i;
> > +
> > +	/*
> > +	 * All BOs, userptr VMAs and SVM ranges must have been torn down by the
> > +	 * time the device is destroyed, so every DMA-mapped-pages counter must
> > +	 * have returned to zero. A non-zero value indicates unbalanced
> > +	 * accounting, i.e. a missing unmap-side decrement.
> > +	 */
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++) {
> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages[i]));
> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
> > +	}
> 
> xe_assert() is only valid with CONFIG_DRM_XE_DEBUG.
> So, it is kind of tied to CONFIG_DRM_XE_DEBUG. So, it goes back to original
> comment as to if we should make it xe debug specific and only make the
> debugfs interface part CONFIG_DEBUG_FS specific?
> I am fine either way.
> 
> > +}
> > +#else
> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
> > +{
> > +}
> > +#endif
> > +
> > static void xe_device_destroy(struct drm_device *dev, void *dummy)
> > {
> > 	struct xe_device *xe = to_xe_device(dev);
> > 
> > 	xe_bo_dev_fini(&xe->bo_device);
> > 
> > +	/*
> > +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
> > +	 * has flushed the async BO-free worker: BOs pending async free still
> > +	 * hold their DMA mappings (and counts) until the worker runs, so
> > +	 * asserting before the flush could trip a false positive.
> > +	 */
> > +	xe_device_assert_dma_pages_zero(xe);
> > +
> > 	if (xe->preempt_fence_wq)
> > 		destroy_workqueue(xe->preempt_fence_wq);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > index d99881c6e1d5..e816db751da4 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -6,6 +6,7 @@
> > #ifndef _XE_DEVICE_TYPES_H_
> > #define _XE_DEVICE_TYPES_H_
> > 
> > +#include <linux/mmzone.h>
> > #include <linux/pci.h>
> > 
> > #include <drm/drm_device.h>
> > @@ -302,6 +303,22 @@ struct xe_device {
> > 		struct xe_shrinker *shrinker;
> > 		/** @mem.stolen_mgr: stolen memory manager. */
> > 		struct xe_ttm_stolen_mgr *stolen_mgr;
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +		/**
> > +		 * @mem.dma_mapped_pages: number of DMA-mapped pages per page
> > +		 * order currently live for this device, for TTM BOs. Only
> > +		 * accounted when CONFIG_DEBUG_FS is enabled, since it is solely
> > +		 * exposed through debugfs.
> > +		 */
> > +		atomic_long_t dma_mapped_pages[NR_PAGE_ORDERS];
> > +		/**
> > +		 * @mem.dma_mapped_pages_svm: number of DMA-mapped pages per
> > +		 * page order currently live for this device, for SVM ranges
> > +		 * and userptr VMAs (both share a single drm_gpusvm instance).
> > +		 * Only accounted when CONFIG_DEBUG_FS is enabled.
> > +		 */
> > +		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
> > +#endif
> > 	} mem;
> > 
> > 	/** @sriov: device level virtualization data */
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > index 909a602d091e..7a4988289749 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
> > }
> > #endif
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Maintain per-order counts of the system-memory pages that the full SVM
> > + * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
> > + * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				   const struct drm_pagemap_addr *addr,
> > +				   int sign)
> > +{
> > +	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&xe->mem.dma_mapped_pages_svm[order]);
> > +}
> 
> This seems identical to xe_userptr_dma_map_account() except that there
> gpusvm_to_vm() helper is not there, hence needs to be expanded.
> Can we combine these two helpers into one?
> 

I guess one of files can export it and they can share code.

Matt

> > +#endif
> > +
> > static const struct drm_gpusvm_ops gpusvm_ops = {
> > 	.range_alloc = xe_svm_range_alloc,
> > 	.range_free = xe_svm_range_free,
> > 	.invalidate = xe_svm_invalidate,
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	.dma_map_account = xe_svm_dma_map_account,
> > +#endif
> > };
> > 
> > static const unsigned long fault_chunk_sizes[] = {
> > @@ -946,8 +986,8 @@ int xe_svm_init(struct xe_vm *vm)
> > 		}
> > 	} else {
> > 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> > -				      NULL, 0, 0, 0, NULL,
> > -				      NULL, 0);
> > +				      NULL, 0, 0, 0,
> > +				      xe_userptr_gpusvm_ops_get(), NULL, 0);
> > 		if (err)
> > 			goto out_err;
> > 	}
> > diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> > index ffc1cc808102..f8b908a74ba9 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.h
> > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > @@ -249,6 +249,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
> > 
> > #else
> > #include <linux/interval_tree.h>
> > +#include "xe_userptr.h"
> > #include "xe_vm.h"
> > 
> > struct drm_pagemap_addr;
> > @@ -296,7 +297,8 @@ int xe_svm_init(struct xe_vm *vm)
> > {
> > #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> > 	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> > -			       NULL, 0, 0, 0, NULL, NULL, 0);
> > +			       NULL, 0, 0, 0,
> > +			       xe_userptr_gpusvm_ops_get(), NULL, 0);
> > #else
> > 	return 0;
> > #endif
> > diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> > index 9c1dac0fce6f..40f97bd4751d 100644
> > --- a/drivers/gpu/drm/xe/xe_userptr.c
> > +++ b/drivers/gpu/drm/xe/xe_userptr.c
> > @@ -8,9 +8,72 @@
> > 
> > #include <linux/mm.h>
> > 
> > +#include <drm/drm_pagemap.h>
> > +
> > #include "xe_tlb_inval.h"
> > #include "xe_trace_bo.h"
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Account, per page order, the system-memory pages DMA-mapped for GPU access
> > + * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
> > + * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				       const struct drm_pagemap_addr *addr,
> > +				       int sign)
> > +{
> > +	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&vm->xe->mem.dma_mapped_pages_svm[order]);
> > +}
> > +
> > +static const struct drm_gpusvm_ops xe_userptr_gpusvm_ops = {
> > +	.dma_map_account = xe_userptr_dma_map_account,
> > +};
> > +#endif
> > +
> > +/**
> > + * xe_userptr_gpusvm_ops_get() - Accounting ops for the simple gpusvm instance
> > + *
> > + * The core drm_gpusvm_pages-only instance used for userptr (and, in fault
> > + * mode, shared with SVM) is initialised with these ops so that DMA-mapped
> > + * system pages are accounted and exposed through debugfs. Returns NULL when
> > + * CONFIG_DEBUG_FS is disabled, in which case no accounting is kept and the
> > + * instance is initialised without ops.
> > + *
> > + * Return: Pointer to the restricted &drm_gpusvm_ops, or NULL.
> > + */
> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void)
> > +{
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	return &xe_userptr_gpusvm_ops;
> > +#else
> > +	return NULL;
> > +#endif
> > +}
> > +
> > static void xe_userptr_assert_in_notifier(struct xe_vm *vm)
> > {
> > 	lockdep_assert(lockdep_is_held_type(&vm->svm.gpusvm.notifier_lock, 0) ||
> > diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
> > index 2a3cd1b5efbb..1e9601be5713 100644
> > --- a/drivers/gpu/drm/xe/xe_userptr.h
> > +++ b/drivers/gpu/drm/xe/xe_userptr.h
> > @@ -108,6 +108,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
> > int xe_vm_userptr_check_repin(struct xe_vm *vm);
> > int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma);
> > int xe_vma_userptr_check_repin(struct xe_userptr_vma *uvma);
> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void);
> > #else
> > static inline void xe_userptr_remove(struct xe_userptr_vma *uvma) {}
> > 
> > -- 
> > 2.34.1
> > 
