Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D10F45A19
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 09:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CF610E098;
	Sat, 11 Apr 2026 09:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vxi020oh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72FC10E023;
 Sat, 11 Apr 2026 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775898419; x=1807434419;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=loW/TM23UI+2IjVQqBhjoXcBz+qkbYFQoIhL9LjEq1M=;
 b=Vxi020ohTKdAPoCazSY36qQNXDprbpMRG6N3i9xreOl1tJIawPf/04I8
 mWZ07sqocDkYj1FGHooWeW2Wn1/4+nk+FGQXRPtMexsPeCMaLAjtSe7BY
 5xqFpiClre+W/B1f4ufLm2Fv3PvQvTYzGKlf3l/5ZcQ0Hxo13nly98JAG
 +MwvRSl4nccnnepCVW11/tdGTPmm4831CRptJvt4HgAOPmfdXADj8KzHX
 qv2Ha9TOA5/VQaiNrSBUi8VuJysB3srBt62BkDbkuYteMEJdYwmCbvvbb
 OE6Z5YJw8ldlDizob3H+3UItOw1T65PPsWItFeJkdDMEB9ngykluCQf/O Q==;
X-CSE-ConnectionGUID: 7+foDTx5ShG6in32S9RruQ==
X-CSE-MsgGUID: wz771jK6S428OJtlFa9caw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="102365034"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; d="scan'208";a="102365034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2026 02:06:57 -0700
X-CSE-ConnectionGUID: OyjVuDwWR5yI5XaiOrvm5w==
X-CSE-MsgGUID: wxnAXljMQaWCNHRzruKKJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; d="scan'208";a="233711102"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2026 02:06:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 02:06:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 11 Apr 2026 02:06:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 02:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1NqLPhGYln0034nt05n1cg4p4dee2TIprTLVG0fGnTo9G1Lv0gdv4X0zVKGx5Nl7Lv5RZqfKNG+xYFbnqz516I06QD4il6k6Wa7AzNg812wos9f1/cReO1qXgKbvMY/5iALtR4vGITMYXSU0Fz8+tj0mxzfau/H9QBgMzLP102jKGLZoWixnoR49rsqPdN0eHaXfoiIAdlqGPmTPETf6GNIGWRkWTIBDsbmIM1rOxicQotl0eHLqvgx9axyZT0iB7oMpe2m5P/mLG17aBI33L6sb02SXxacO0n0uL9X7TgkHsb86shaJnDbXLLb5+yrX4XHiZQr9Ew+JInBwvtj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QFlIswooOieXAgRQOiEU/npqx8BPDGj1/oGQP1wicY=;
 b=GRSHsBZRkwBngmjbym0jj4VjuNzyDQnVW8cFL4oRn/oiTiMopBpfdMQuXvkHW794FbFvZLJuoooUOhU9PpRdHbLTc4itL9k5IzdL6cLv7MST4Vk973doRTbR712lvBCXUzWVHAzlEqXABOL90nxLtdrT4JMu6vMwSeS3kAQBwJVH7TVHQGJ3gd7qfAclHGQTQWqWPl6CtriYspyXob6T3+DVdMdiLt0xwLJfUE57zWBZfCWLhEJlBxTYcKuQN2vD2FsykcSqLb5c4hVEmHm43WZVHNNiE/t85aN+eYoR+zyp87xVca6bhnadNHum97yRMtZfIPzY8U4DhKBAejMHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Sat, 11 Apr
 2026 09:06:48 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 09:06:47 +0000
Date: Sat, 11 Apr 2026 11:06:09 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/gpusvm,pagemap: Do not assume DRM pagemap owns
 device pages
Message-ID: <adoPARbAlhd3CbFS@fdugast-desk>
References: <20260409015512.3670302-1-matthew.brost@intel.com>
 <adjxPkmE94e1dybe@fdugast-desk>
 <adlXOEreUjrofIhc@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adlXOEreUjrofIhc@gsse-cloud1.jf.intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0343.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::23) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 61715c8e-2cdc-472d-e299-08de97a9a920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: EsuGpcf/RDhrSgIpvV4mwr3EwPD2GodXKt1Jg6Sf7TVcaKpc+Vx/At1bQ0QuZ9WM9M1FrdoBHGXbClwsikAXnBSsPICEGxHRvgZeR1saNKAg2ox2oz/P2T1mJ/PD/dgQg9SMt7EnIWbTOAUTd5/TRf2363XaQVsfRwenpshWUKJshsFh6Sxpdu3PDUuxCUjEWmXqquzT3hFarNfW//oY0eDqmvUK/Cij0ZRJcbiMzbA3j8/JyBHpaappwQfocjwi8ynu0J7epbdlXY14GBsNT8qV1y7yuwYLXa413rrE1tucw/hSl9U4NyBeTAdqa3Xs03gpwMxm4Ptbu6h+rdSnIFRB6D0Ss97otAW+CszSs3ApnfA2vqO7zml8xbeJV+kxSI3Bay4V1enOmRuFXXmptaFtcQfsqp79Od+RKFpWbE6mGPIBq20RifNSYqCKa++IeeDKD46YHZpcCD5AOIor7zW6jqaJzqARlFenwoxZBSKsNfCTO3XNIObANHZorI25igBEbIG/YSx8aXJ+jmdUdU33+LWlF+oVahCcCIT5UwA08XBhcjXWLLQM+Q8iZmBPVZBJywT/ECNLIveybbA+e2+WUZ3wHyiwO46bkYIS9+7kMBmeoJVxW6f2QAFWAIScGDuaCghhMwJHANMWhX4+QnxueEkKnjStZqGEmiDGtMbU0+ds/UytFnJOPuLjuYM3jQOp3frtsY5V4/fbCy+ytQMOkMJhto5BCzjKP3/LpDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIDajYf0iOp8HqpH5LbFWyRjw+dvVnu7EUFmDR5aVaZdKHnapU6swlCTxpdq?=
 =?us-ascii?Q?KDj9kOu4uszYI5sotUEXFOpnBZqQT1Cta138RvfNwud9scfLTxdju4MUaPjm?=
 =?us-ascii?Q?DI7cCTQd/6ALJlniBLsmnQDVsVh/2fcC009euNMgpHTg86i4BVGW02pmNatB?=
 =?us-ascii?Q?bj/0QvCuUbzuXigRbe1axmc7kX1XZ76Gnj+KiJDt9KqpFoDwtI6PzA7eV0Z4?=
 =?us-ascii?Q?kw1XVD7Yj7P0sW/2odksTgbVwrCBKZNGyy1nvI6PsvWyyJJcXOM8AeOfx5W8?=
 =?us-ascii?Q?obY7wmPmg3CDsImSm7alvRdfgpiPolj41k1R2La9+9Kv/ippJuW2XPcrjOlX?=
 =?us-ascii?Q?7Pox0Rm3wRrxLWeuXuyjTBohQD77F9EbaVNgurPb7xBaeIcP2l9+EobbLjyY?=
 =?us-ascii?Q?zAx1NVvVRf0R0Ut+eulmbHm3uV6A9feu7znSP/vOurQzj/oY99mjqZX67hB5?=
 =?us-ascii?Q?D7o7vJfNMLoforhtda4PDe4dhuZ5lj3ArExFY/29yoSnUqIb7NowKolu/Qvs?=
 =?us-ascii?Q?q3900v+Ow4XyHcnPiMo75PAa8qFCaNs0ANV33BCOa+k7dq4HBTTjO7Hldjub?=
 =?us-ascii?Q?1Gsnaw+XVHsZqV8aFvNn5k3wl+miYpHL/mDch4n9Y583J9KDBmMBLsg8jOhu?=
 =?us-ascii?Q?ZKzGMMx5nVQ4EqwkFB50DVX8vmUexZrDbFP0W6Kia/iSam+M8iWOI9Oc0wMo?=
 =?us-ascii?Q?9fq9hfu9f7oV+LGB/hCFFC16fSFqSFdMcweqy7peN47zSH1O8LZgTuEQKJ0q?=
 =?us-ascii?Q?/TJPBa7C7NZKbK10YEj7qIp10Luyz+uSngo8lKtuJBiPsT2sn8KZKNIQyqLZ?=
 =?us-ascii?Q?ByMANjK1f3lyfWgJGOPoc+ufrVPZTf9RPo+WOg00DS4vMecDycphWFO0Ft9h?=
 =?us-ascii?Q?WCmBXWM73BuFE0eTgf1JCNuyUWE+eDWDcbsk5VlfK+ZFr2nm1N60jVVU5rPD?=
 =?us-ascii?Q?5xVp3RujM7EX18HKIwgovCalwN5gchKQIzXTibmo2Gbe3GXYcWg8rm0oxlxT?=
 =?us-ascii?Q?Gr3yd/hXQ/rIDpOs0bmyeZ7Yvvjyu5eLynHqFnpXWsIrrNUGE6pNtRGkAO88?=
 =?us-ascii?Q?0LgqL7E+Joko7zvUb7dBMX2xEmHiCFhbw1AFPJdJwfHq8ePFKKEeaVOAjyhX?=
 =?us-ascii?Q?Lc8VTCZQITfzBijkpoqfyVSRHndp+zU3p55i/wm7WNc/Pps0MWj4V1ngIglE?=
 =?us-ascii?Q?fGI5oQ5pIZMJ8mlvuyq6O1CmtNt58l6Me1bVXWiWKaJFYLk9u9dLnu4lsOyn?=
 =?us-ascii?Q?340MJpxhNojsXkkOobL1LY4whbVAkEqdj26/IcaaNa5L70hyENj2tUIManPv?=
 =?us-ascii?Q?WrVgVpHQbFAHLzjzLEzLFp9RNuLvadcewDSMK5BEQCM1+iah9ays4byqJnmW?=
 =?us-ascii?Q?MSu4jn1wXcg6LIbOL1N4MH6Oq3E00/QaxgxqtUnEpQ9Wc35GjkaaE/MP/Msk?=
 =?us-ascii?Q?MeQGZbZ3OvXALRvDwCJVnETsFWK8qTjTlC4FkG9J1EydmZPStTqSNZ1fiN+g?=
 =?us-ascii?Q?u0tGalFg9kHExZewbCZGAM1ecMQCKQgQZK4ER77kz1G4AReWHVDg0CAEEQYV?=
 =?us-ascii?Q?ErAcBjbiOyFWl72dC/6/HxZTSA1jOZKNJNxfPjinq3Nq6F1owuuQPzVHDuq/?=
 =?us-ascii?Q?VYY4JEDRrGRGUSZH1b2WrOjAjQqO3QMMtoE5LpAz9ajH6Koixm1kysrvQteO?=
 =?us-ascii?Q?L9lPcyMFeRn2trHWiN5SdekIp3qh3VJEyIDhix1Cjwwxj5BhXevEF1AITVYI?=
 =?us-ascii?Q?Sd7LeQU4gb4IujMHuGXQ4GqqHVnqR14=3D?=
X-Exchange-RoutingPolicyChecked: CPNsCZBwPYds6NoJCyJJ1B8SpTsFG28xn/PUZYqVhNQBXOeQhV0mprtMPNLrutFt+nUlFN4E96/U/Z6TVu+hwRPKxvU224VkTA63oIYV71KsSj4a7samHaREI31PVvvdAdVT03KXFufTxgefMoJAaaWlQqJdChHZuSWBXcCT6bTMkG74Cr0CHo6G+1c0rGAWXVsXEOG+QOrTmUNIUY/ciSVXbCb9oA2fcujUgWrTOXsLNb3ORs3eG3AlEY9mBei7Fj9eJmpaBjB+FKweJD5SfL2lo2a4XRrnNdhcl1h6IAh/7ajvTqwSF8yVd70eqkHGZm/LDrgqRYprLVinvEKsiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61715c8e-2cdc-472d-e299-08de97a9a920
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 09:06:47.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLUfJd6QnvuHo3jvUc9upMPbIXDjiSRM6MuMwI3Y4Fbl+1oLkv8XYjASzmlpsc8HHzUb8r1OAOIyTke4rxRwLF427hwhYCO0OchYo6mYVp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
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

On Fri, Apr 10, 2026 at 01:02:00PM -0700, Matthew Brost wrote:
> On Fri, Apr 10, 2026 at 02:46:54PM +0200, Francois Dugast wrote:
> > On Wed, Apr 08, 2026 at 06:55:12PM -0700, Matthew Brost wrote:
> > > Update drm_pagemap_page_zone_device_data() to derive the pgmap ops from
> > > the page and compare them against the DRM pagemap ops. If the ops do not
> > > match, return NULL.
> > > 
> > > Also harden two risky call sites by checking for NULL after
> > > hmm_range_fault() or migrate_vma_setup() when migrating to device
> > > memory, as it is possible to encounter device pages that are not owned
> > > by DRM pagemap.
> > 
> > Shouldn't we also harden other calls to drm_pagemap_page_zone_device_data() in
> > 
> >     drm_pagemap_migrate_map_device_private_pages()
> >     drm_pagemap_migrate_unmap_pages()
> 
> We sanitize prior to this in drm_pagemap_migrate_to_devmem or are
> operating on pages handed back via populate_devmem_pfn.
> 
> >     drm_pagemap_migrate_populate_ram_pfn()
> 
> Operating on page handed back via populate_devmem_pfn. Also wouldn't
> NULL ptr reference.
> 
> >     __drm_pagemap_migrate_to_ram()
> >     drm_pagemap_folio_free()
> >     drm_pagemap_migrate_to_ram()
> 
> These are in the vops path of pagemap we check against.
> 
> >     drm_pagemap_page_to_dpagemap()
> 
> We sanitize prior to this in drm_gpusvm_get_pages.
> 
> Thus all the above sites I figure a warn is enough as it would indicate
> a fairly serious bug in drm gpusvm/pagemap/calling driver which this
> code completely controls.
> 
> The case where I do sanitize - after collection via hmm_range_fault,
> migrate_vma_setup, I think it could be possible an outside driver has
> moved pages to private (very unlikely) and this driver also tries to
> move, so abort rather NULL ptr dereference.

Indeed, thanks for pointing it out and for the explanation.

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> 
> So basically mitagated the 2 risky places with sanitization. Ofc we
> could check this everywhere...
> 
> Matt
> 
> > 
> > Francois
> > 
> > > 
> > > Suggested-by: sashiko.dev
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > >  drivers/gpu/drm/drm_gpusvm.c  |  5 +++++
> > >  drivers/gpu/drm/drm_pagemap.c | 14 ++++++++++----
> > >  include/drm/drm_pagemap.h     |  5 ++++-
> > >  3 files changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > > index 365a9c0b522a..b3cccd047a21 100644
> > > --- a/drivers/gpu/drm/drm_gpusvm.c
> > > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > > @@ -1506,6 +1506,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> > >  			struct drm_pagemap_zdd *__zdd =
> > >  				drm_pagemap_page_zone_device_data(page);
> > >  
> > > +			if (!__zdd) {
> > > +				err = -EINVAL;
> > > +				goto err_unmap;
> > > +			}
> > > +
> > >  			if (!ctx->allow_mixed &&
> > >  			    zdd != __zdd && i > 0) {
> > >  				err = -EOPNOTSUPP;
> > > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > > index d82ea7ccb8da..95c951c5b569 100644
> > > --- a/drivers/gpu/drm/drm_pagemap.c
> > > +++ b/drivers/gpu/drm/drm_pagemap.c
> > > @@ -753,10 +753,16 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> > >  				own_pages++;
> > >  				goto next;
> > >  			}
> > > -			cur.dpagemap = src_zdd->dpagemap;
> > > -			cur.ops = src_zdd->devmem_allocation->ops;
> > > -			cur.device = cur.dpagemap->drm->dev;
> > > -			pages[i] = src_page;
> > > +			if (src_zdd) {
> > > +				cur.dpagemap = src_zdd->dpagemap;
> > > +				cur.ops = src_zdd->devmem_allocation->ops;
> > > +				cur.device = cur.dpagemap->drm->dev;
> > > +				pages[i] = src_page;
> > > +			} else {
> > > +				npages = i;
> > > +				err = -EINVAL;
> > > +				goto err_finalize;
> > > +			}
> > >  		}
> > >  		if (!pages[i]) {
> > >  			cur.dpagemap = NULL;
> > > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > > index 95eb4b66b057..9b7c50932db5 100644
> > > --- a/include/drm/drm_pagemap.h
> > > +++ b/include/drm/drm_pagemap.h
> > > @@ -367,12 +367,15 @@ int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> > >   * drm_pagemap_page_zone_device_data() - Page to zone_device_data
> > >   * @page: Pointer to the page
> > >   *
> > > - * Return: Page's zone_device_data
> > > + * Return: Page's zone_device_data if owned by DRM pagemap, NULL otherwise
> > >   */
> > >  static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
> > >  {
> > >  	struct folio *folio = page_folio(page);
> > >  
> > > +	if (WARN_ON_ONCE(page_pgmap(page)->ops != drm_pagemap_pagemap_ops_get()))
> > > +		return NULL;
> > > +
> > >  	return folio_zone_device_data(folio);
> > >  }
> > >  
> > > -- 
> > > 2.34.1
> > > 
