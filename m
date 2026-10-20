Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CAzZ6UPh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2341C10EBCC;
	Tue, 20 Oct 2026 13:36:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9E010E603
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792503359; x=1824039359;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6qWo2F10HhVMvfUzIyPn7/toa1n2oqFSQ3ce/+DtY8E=;
 b=CAzZ6UPhuo7Ix+bZcHsyNa12GPZ6EBjw0ugQqkj10WUR+6LY70sbzeuV
 fokIe2fPcObKEl/tD3ttpU7FiS2P0BVSz9V76h6sDYSNu08WOw66dOukw
 fa/RLWu9yRuWan4RqOH+wIMfZPma9iEVvTUoVCO3Fhn4NEVam7x3zVJhD
 DW6IAAoVeRRjKBdzoM5ry0YDHynKL07FM/12OY2d345VfUl552DuFITGN
 +Q6r2H3PvL+CT2wRObTJWiQa2LTF5oXxuuphE1ZoxYFn5TsrZquZPQTIE
 JwIr4lUoeccagpWZ6yCfK0JQQxJ/z8lzyqGzq3Ho+L8oWY/lNMbHSoi1n w==;
X-CSE-ConnectionGUID: +QrM1yj3S+WnOTmWZQdmIA==
X-CSE-MsgGUID: ZXf+qkxvSRWiYLaw8vybng==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1215005"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1215005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:35:58 -0700
X-CSE-ConnectionGUID: WgSavq7TQZamdMzmFLSKDA==
X-CSE-MsgGUID: rbINB85kSbazDvBFcYCw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2780727"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:35:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:35:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 06:35:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:35:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+IVx00nICYbKUleRRhBEO7bYcreYOEsXvVySfXs3rY5f/w0ztjW2E9L8o2GKT/u/Q+HOsFHoW4v4JQCiP+cqqAD3ivY9NczwXPVZxVl5s7s4j0+9nXet6SBpBB7Pd+zBa70//MZ8KZwDNCXBgGIQr9HqBPgXOt8JbpuBhKeGgKIPtGv2Mvb3eCVg2weA7Rw8yf1EZMMxu3qorDRu5Z5QKlHk1+Aw6+dZnkbDP6uvLcX8O4WOu/gEIs5Rnal8A95NDZLWJi/SVVqOtBFCiLYeB1zcmACdheg/NPVp3VGcDf8nf+LqmY8vY8yT7SizNJjeH/jqEAxjZBb6jw641U4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW2hXLzWGH6bk2AjMAajuuwQYWNgmJxSrV6qRVZvMes=;
 b=iLItAVB3pvc/ir7hZGSL5dgtx5KW8KlJix/+qE4fMdJbxqXjLnvRNQoz3xg63DUSgDifXJLYFfNykrjvq5skt5kKJLnk7sL4uLXU0KXCYO/ntsnbjFagDJElqNVfJh0FuM/0HkRvD9obsEg0W8jXLctqn8CRW2/F2axTOQyA3xNMzGaHyUIzWlb+Q87LDSh7HKoJJlftdeBFFkSfonIVdkOwWAa0ZtmyUuGTBaDYIC01ymSe2ianNBWHIDIMYnbExIkfBxTDy+VLpg8X7/jqgZYclL/4mzhvK7VxPKyVM9VOq+rAxkVYqPsb751o+v+Euucc7AwUihTTAnccCd/07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:33:46 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:33:45 +0000
Date: Tue, 20 Oct 2026 09:33:42 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Raag Jadav <raag.jadav@intel.com>, <dri-devel@lists.freedesktop.org>,
 <riana.tauro@intel.com>, <mallesh.koujalagi@intel.com>,
 <matthew.brost@intel.com>, <andrealmeid@igalia.com>
Subject: Re: [PATCH v2] drm: Log recovery method with wedged event
Message-ID: <atdttlqZ__N9Q6Nf@intel.com>
References: <20261020022117.199831-1-raag.jadav@intel.com>
 <ff80ede1-d0be-46cc-9929-f53ecd961d82@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff80ede1-d0be-46cc-9929-f53ecd961d82@amd.com>
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e78c26-3daf-45d6-4a2c-08df2eaec3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 6cgOGJbK+GKZVMXH4ODZxOeNV2Gs1y7onQCqh+ID3QpiR6l+L9EuavVTbRFlcd2iCOK+unadhHw09o0mv7erDZe5WknQViwSf8B5z75Zn0Vrr/qYRxZvHf3RYdxb0SHdP8gnoARkLlnsZCZ6iWE05PonsjgRguyYN6dMc4+qrnJsFMbAVvwoxVdDTUb1YIN/Hk6eAtUBCN+e+rKk5Pz0Aq+zk0PW+89K35rpr2LNI4PLI4yKG1GJSzEQ7oocdasPWVsHEBvotSU65kb/de/N9cGpNKkK/Cfyp7A1FGHu2KNHx5Uepg3WbrnJhkGbN1sdQrHSXN4NmfCdDKoIIHHy2A3dOSiHSIw5AVbxOi+l7X+P64D05ENXPuaxtt/4nSF+zGkub8qKEoN+jYZr1KpNwI3Nmkza/i2pQ4qcn0WX7soujYWawHaEqLAxO0GCSveyfboE6k4fpJmZjIiMbww0NiCVxPY5BsVDx5DKDeejwY27WdHMyFAQMplTkKPxPNKt4m/9l8tOHN20TG1wl+7RTkCUuYeHXlKi839pD4l/zIfE0LbMtQrbXc2TccXykXHy3sbnSegiUHtHbapVwFztSnVUkCbMpzPzinUrMNhujM7r124CnvMW02sWHbvOvwLlpiRhfZw1NJamHpaIA/PykVp4/wM5nhBhWDjxkOQqWyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?S+pPDxokWT2DG4iiksR8l/aEOIkQQU/4je3S+7j+xueC3dnXnUmIKUgIVg?=
 =?iso-8859-1?Q?A7wpq68NHA6ThHRemreciNZwa/YZvnMYtNcVivALClw61MhIqc2SlUZMgE?=
 =?iso-8859-1?Q?y2mMpymAHfg3kcv2pS9xvI4ct2y8b0H5bi/79Kc8nBuajIJnRpaHsu6o2C?=
 =?iso-8859-1?Q?IWpkr/omwVGXhAYohQJXBO99ogseU7B96lV88YV3yhC84uhd1Ok1vxtyLs?=
 =?iso-8859-1?Q?tgAk9zDVNS8YkWQClsId1bpdnL5LH2heTayvEyDA+nejKGIw6MpmMfRvct?=
 =?iso-8859-1?Q?6BDgqLFxKfNkbRBZVFVWSn1nfnYuBRdfYF7K/ZEDFpuEsmIrGYRHMjuEff?=
 =?iso-8859-1?Q?xk+bDzP+fWfJR7sGU8NdsKX5rMmmxRcjyMlpwwq5gZUrchGDQABzM7wZJj?=
 =?iso-8859-1?Q?mjEVD73OycZicrEYgBPiu2HUSjygskd3n/R2hBi32fWcm1SduXoCSFaIph?=
 =?iso-8859-1?Q?jM0ELhC05jDB0nq8S/AH5E5ojGTFEkJr3Q19txTkwCTmEYip9b9RrsFX8N?=
 =?iso-8859-1?Q?Zulycg7dbYoVFWOfCTDnO2dahV5Ilp2kFjTXQz/s9OG4gmfTwYcaHntM7I?=
 =?iso-8859-1?Q?zVSKQduj7Du2IncXS2GKBO846dMFM+BauTDa4FxnGVPLjqrciA+V46isAg?=
 =?iso-8859-1?Q?DVnaoeAv8idsAd6Qj6CbfaT+9xShp1er6eJASMT0CzJlD+prHCon9Dxomo?=
 =?iso-8859-1?Q?zzwDBZtCKgW0sBrqVOeMa5CbLwoHFzT7URA9XgXhUplSOkQFUR+Irq23H2?=
 =?iso-8859-1?Q?s6Tt626biFr+ALjZmwvDNQH3JwGL888Bp81jDlguEuRn+pmghScVD8zgss?=
 =?iso-8859-1?Q?EQGbayv11B2e1fyzW6HHnm2mZH6/v8Q3DpDv9uH2QxboYWq6A1BUAWk1N9?=
 =?iso-8859-1?Q?HeZzGfWiSPXGtJfEvxNNxGMuetAFAoX8HxaFZLqZbFEnJ0h0jezVgav8G8?=
 =?iso-8859-1?Q?16ULlnIV/eUdRDMyunUxQmaH+de88HHYR0qo27cSZOs2c9Y8+tdVV7GKqP?=
 =?iso-8859-1?Q?N2VpOU7NU73llH6Cs724LzSaI9IvBjqxLCn4WuIsZEpBPe65ELusFwKs02?=
 =?iso-8859-1?Q?LGOsjiui7tbduhmjBy+gEg8gFYfyhXe/P1BAcCovnF4/cp1wJ1Qy7kUzwu?=
 =?iso-8859-1?Q?gd8+RXQhDAfavbJPOtlIvcl4+BySkqht8cBpbFGTYhvIafspM8eEKgLkwf?=
 =?iso-8859-1?Q?Mt2OxhQ7xMF1yqagwLvas6Ku6sGswPIbwU+9hp6ZFfFaSQXzORVujkEiTg?=
 =?iso-8859-1?Q?iGgtIITVPS0e270DMrxHxafossPkH1ZWnEC3ievDZFILaR81EGFydzoFTr?=
 =?iso-8859-1?Q?Lp6L855UOWPWukVUrGPvN2W8B9oEUGq8VjzY7L71ZJLa6nazwccZCXhzBP?=
 =?iso-8859-1?Q?HZcls6Rccn1vRmb5voIeKOO0iKWbAWaDXv9f5yvQWCPvh7MG+qhBPx2EHn?=
 =?iso-8859-1?Q?XpIZuZfjmLuc7FUUygiqYKNIePxQM0hxL2codrBG/fWMuXMoMKE0pNGHyK?=
 =?iso-8859-1?Q?mwKyQGB1KOHyRu7z+9/icPuZ7BY6qQkoMvDoHPQ6Uh6lJ7YGa204eSiwwF?=
 =?iso-8859-1?Q?NnbwmTiSNLnDdA6bCSFZPzbeGQ70/9ttx6q0dwop+fRFc/eoLFKfD8Cy5L?=
 =?iso-8859-1?Q?xN7VKssSiXPq/L0A6qPdeP1xYJMqPUFkt8bHpRBSuKYxh9va4OVSA9PoKA?=
 =?iso-8859-1?Q?h1DXZjQS1RPJPSg1EO1fuxxrR++Zsq2ls+v/nkh/lOZbYnPKPcT5hrEGCa?=
 =?iso-8859-1?Q?oVxBvrQhCLw0Hkip68jm9hi/1mvXTv69ChnR9NUGH/9ENU4TimjDcPkyVE?=
 =?iso-8859-1?Q?tzTgflRCTA=3D=3D?=
X-Exchange-RoutingPolicyChecked: CP2rumizNplr5EdK7bON7lsrfkULBt4HNU6xMLzsWkp8wMF6m6YfWzYqPg4MEQjT4vfdV9kfYrNYdjh12uwGf5Y+JvWn2bK74YQdF0D9TaQMr3uzFu/0M3HXe7VZgLUAUBmrnr83a75osUDCikd5x+d9W2i5j6fXwo0vAfv0GpxF/WTDhh54ydC9O545BO98kZh5Do/bRrcDOYCG8HRFP77IMPKABuW74QeEI/2h95Bxw+ij02+Plm7fpbK9oYCMSFp0kI3D4DxBnPaq/Rx4OBQqBRKjRM4oMdHBNgU5+aWnDNMQVTHA5fhPHqOlqpc7KYICiMgv0FUaf7OJqJotZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e78c26-3daf-45d6-4a2c-08df2eaec3cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:33:45.7971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl8OpQq4N67CbuSEFukTdnWVqcuyCaRT14J+U551URV5xbaQXkUJfgWZu9LEuND79fSRhbueCmykII4X4qM2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:13:50PM +0200, Christian König wrote:
> On 10/20/26 04:21, Raag Jadav wrote:
> > Currently, drm_dev_wedged_event() logs a basic message of device being
> > wedged, but doesn't print the recovery method used by the caller. Log it
> > for easier bug report analysis.
> > 
> > While at it, as device wedging is a catastrophic event for the cases that
> > do need recovery, distinguish them and raise their log level to drm_warn().
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > v2: Distinguish between recovery and no recovery cases (Christian, Rodrigo)
> > ---
> >  drivers/gpu/drm/drm_drv.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index cb53baa70995..7f8abb72f548 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -598,8 +598,10 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
> >  		/* Caller is unsure about recovery, do the best we can at this point. */
> >  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
> >  
> > -	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> > -		 "but no recovery needed" : "needs recovery");
> > +	if (method == DRM_WEDGE_RECOVERY_NONE)
> > +		drm_info(dev, "device wedged, but no recovery needed\n");
> > +	else
> > +		drm_warn(dev, "device wedged with method %#lx, needs recovery\n", method);
> 
> That is still not ok.

what I had in mind was a explicit option so the drivers can select if it is
okay or not.

> 
> Again device wedging is a perfectly normal part of operation and clearly doesn't deserves a warning.

sometimes it is not, but I understand your point.

Perhaps we just skip this and in the case where it is not an info + a custom
driver warn is okay since everything will be stopped anyway in this cathastropic
case.

> 
> As far as I can see userspace can spam the log with warnings by just submitting shaders with an endless loop in it.
> 
> Regards,
> Christian.
> 
> >  
> >  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
> >  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
> 
