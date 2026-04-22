Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8329FA1FFA
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DAC10E2C2;
	Wed, 22 Apr 2026 20:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mXday7/M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E66710E242;
 Wed, 22 Apr 2026 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776890506; x=1808426506;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cFMj5AXS7EOCC7ylkBJbUZufO1fPk4KPhoc9U+Cqaq8=;
 b=mXday7/MOCt/HDO1628pDEIUe3bDqbAGd3BwYW0PkwUyoUJxiiwJREIj
 XNoQ6Iwkf6qUIqG1Slc3/Q4EaJnuvKbt2jFL4c59wSjG9lw6ZgI1VZShi
 tfMgg2Fr+LxAXKAN1Y2m0h3s5Y5q2nSjbkiJq5HODXInW+TbcTAlLUokH
 aEbQ4on6GJvu0SkFUXhmO9uCVG7lnz+eUv4142Un9eZqUZb2FLD81GQ5b
 4xrd4hw9/Uy174eUk0lpp5jZ6kwwp5Ng0jKg/z3oXjYYgcA4X84ulGSjE
 8p+QbpjE0cHbUScKqUi2eCNO2+UmGBILTRKQf+HM/YuouaQCZFEMHs1no A==;
X-CSE-ConnectionGUID: sR9P/kGLRT66tszo4WEjyQ==
X-CSE-MsgGUID: HY36ax0fRj2c9jZIeT/UuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77836298"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="77836298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 13:41:45 -0700
X-CSE-ConnectionGUID: 1vDGRpVASOyfwGwdABAGeQ==
X-CSE-MsgGUID: zbxOdyh7TKOjDqIvwawPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="225943427"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 13:41:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 13:41:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 13:41:43 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 13:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3GAdYhjLb1IQEH4rHirkXRPIPoDdSSJr7z5389u9Fs79F9TDh61nBBCiUZnurVwIYmdQh3V9YR7VqUg7n1LStMfZ2ckk91Gr8dAn+MHkYFhiB7ytFTVkJURNUc5ITTlYaI0K/TXghP0jYw7Ojr1QpOcrQuhuvfR0JuQqaVBhvHNqMOiBFusPUdfdQKnWGAEFDVOQxpyu2sCiveqZlPJ/T/PyRB/Z6MZANe3fKWIMhDiApRrP5dh4YHJhu6wXTVFAIOlTh0WpNE/9XK2KINM9KNfgBHhX/ILJ96KT104NBB2kM6XUZ7przVTrBT5i7eVxg7Opkc1+MJ5Biz98DMMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzhiqtxdBPz79v+YyCDusoCK9fM+2yDJTcCAh4MtCVs=;
 b=YOqlfvmwLTeqaZzINN5COsc5sdwgvkp0JcFIaI3eM4umtXmANlW577yLW3SVsF7m3m5Iw0sTWPyIfWfVHfrX9YyNe0ymwc0yfOcIcs7M5ArtheAT2VubyHADwt3LagPr7uPYt+CqFmNK10g+C4UWN/S54V3OsNx0Pk9ECaI2s6iJZWRuzXj1OvMKRw5KD11ZH/wcF/V+oi6HnAAkT2CQR4DLHxEKQ51HAiZUwklLQ9CiqYNApNfqIHIoXikeVnaUbeJsPPImEsGo7G0MA5KvSZ23pyAuos5wxG8CtsHiIpBGHexO2Xfhd95yIC+o3vyqiVYCGJs+b8gfDsu0dFyDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 20:41:40 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:41:40 +0000
Date: Wed, 22 Apr 2026 13:41:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Carlos Santa <carlos.santa@intel.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Colascione
 <dancol@dancol.org>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
Message-ID: <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH2PR11MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 14052e39-20cf-4c66-0d5a-08dea0af8e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Zd/OnoiSvCaM0xcM2wXlM2JV6bKBw7pFybNRQ089iXmCuLHby1D/DDC607Esmqmg+3ToTk1rn5uCvmMAD1eTtfuuODzi7omi1igo3G1RWG1Ep5boSlXo8+ypGKH/LbjmSHVZBX7zfrt9VUi37JmPBEp3grDj+odTgZBES+DE+Z+1XeTqvScSU/jw0MZmRz7LSm9veBKqq3zrgw16voNDvdFr9t0rwFIUs6b/eaW8w9k6ddU2dl0tEOY4nq/UA2ODJb2LXZSDkjJTikaY9g6AljsRcwLv0PgZxhBXZ40mA0bIQcrhaKBG9WIqW48wmj2VdYuYac7YbIbzD8g00+VcMuAFPs955LRxYGVYifZLhkvUqRFZzj49XIYyFIJ9/8pxeher9ib44o+EoSb/GIS6TCxZU3hjz0n2RXXjGpGW0i/YeqIMqi3KJr75KXc0ObhtgrmA0ubeaQHayOXwMB0uZGFp3BryU3x8DSuZfv2qTNYW9Rr8HGoCdNwS6WsgchGF2UIU/8Yu47M9rCmL1+XcScrHGzfhS8GXbMqU5IlMI3xtJCrikMZfvlVO4KQmFCItLbXgf1NqWcmlJpFvYIB+LBkWhz2nAoaVvtiXX/nXGuQ+XQwRpaLqK425svnx6rMuhufpeLk3K7YD0gqY805p9whzny6KHVEwt4+BzLHm5ZpQBg20KoVuZR4Hmc00gEPe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FpERoli7lraqow8aIhPI77+X8F9WLv6JwZRO7rSJQ40pLl5nD/zbO0LP82?=
 =?iso-8859-1?Q?ChFGMd2CvNhIr+LGpNtT1w1G0rIJDygcyd6QHr7zrvYSrr/8i17oud1o8v?=
 =?iso-8859-1?Q?Khx+E5HQi2G0sR/XKntpRtXHQMTbwgkHh7Y2/XKl6QLOPf2pmPegck24gA?=
 =?iso-8859-1?Q?us6JNaCLWyfi6/s8mCTafWa+UlJgD5QaGqGesefb6GZQwAcAxeK4EcH6Uc?=
 =?iso-8859-1?Q?hw7qBVdBcfC1JnD6a6+W9kKmnx1qT6g5jK+zyAOc9tLTjItXIEppUoBO+o?=
 =?iso-8859-1?Q?vcXX0Q7m0SU6c0HYC7pCzB3IqJgtzeQ1U8n0+ltRSlLTAS10xuciM6VgBA?=
 =?iso-8859-1?Q?/2bJXBwwbs9q38Rh1h84XHEb7FbNEtQKp6XbDz6h4uCaARvOYCfUPtSD3u?=
 =?iso-8859-1?Q?UHSDeqJK5xPT0/ZGNc/Ge0+HkoLcHszc+h9EwGjzjaLSu6zjTzj1K0kTtJ?=
 =?iso-8859-1?Q?IppKTryYKmnf4919oeprlBFsCmjzpxD0XYPylp89FncRHODlKZpkpvQZki?=
 =?iso-8859-1?Q?QisMZ90ZIRQi9TbSyCPm4YJwWSrx6aQ5U3rS9qPNnFrlMt53cv1ENP/Idb?=
 =?iso-8859-1?Q?npOu/8bdQ9qXnFwPjUfbzWi2Sl8hj1SU41R/cAcR3LxL2bNokgJsDVpcCh?=
 =?iso-8859-1?Q?GIcGJLtfEBjQCVHM7D8DPdsOIHg7gewArafOa3D082EgqID/ojajCelhSF?=
 =?iso-8859-1?Q?ix+1f1x0YReLfJn4flvZxVRqSw+puo9sab7QsI7KMY2V1daKxTheu99NFz?=
 =?iso-8859-1?Q?e0ea+l+JRCS+edO5vCz9dAuFBeGveu0w4fRZIHg9pWhqWyXsqAlBcqK0/o?=
 =?iso-8859-1?Q?vXvzPp66Ts5Aqd97Ie5FbOAxPL66erx1OU2v0MIN9aKsJAKTLsKvbQTTzC?=
 =?iso-8859-1?Q?mzIc0TXE2gj2jMQNFBtsUoS3L/8dSGffCtn0BcABB7dBAUebb5vThcvz/F?=
 =?iso-8859-1?Q?+gObLSvvqUhcO5Hp9m023CHBLDC2CAcG+lYlbH1TKqD7MUfNv5ljNuAJJR?=
 =?iso-8859-1?Q?DnQ69NQEaIABArw0y/K69v76Hhe2DqJTpURJOFtcasoM2I15SDiatEjhsW?=
 =?iso-8859-1?Q?Hym3Y4KbH3ccbmLM/0ibUp9R+L7C9BeGX0fiM+2BrUOl7qLABw83P2twa+?=
 =?iso-8859-1?Q?5BkGEc3PNnVRDkZeEf4sy61Q7h+1RLxQGV2+qVgfPjwRgJG8fGrzxdW+90?=
 =?iso-8859-1?Q?hqGCgfSUgwbqDo7HpQNSwaWr7NZqSuRo4eXJE70DLE90/qDEo7mG9/4u77?=
 =?iso-8859-1?Q?qxnVO6OWGEHqjcmPNFbAUX9np7SJOZSqUIIBciGnjDH7jJGk10WEkG6JI+?=
 =?iso-8859-1?Q?O19e6WL/cRPoqUMMARs3wQ62OzGI2sgsTaeIf34Tn1tTBtUBmd4KORjuV0?=
 =?iso-8859-1?Q?nDUOBvbJ1ZdsUJQXmBeSz0do4KKpSzPmgodfDNmdwtArZay5gfltCvABE3?=
 =?iso-8859-1?Q?WrtsE3pW/xu9AeDKFmnDErT8pPlMnUoL0au6qsFC7KGa9yXO0cLJfcljyt?=
 =?iso-8859-1?Q?39PTuu/DiO+aRrrYJPN98q3J4QGyqHU2QYs2XIdviYNcbOS8S7sUolEVze?=
 =?iso-8859-1?Q?kv1kYi6+sq8UaA5DjJf5/Q07sTQ7eEXgNITSLfaJWIWoOCk2glk1eqm2Dn?=
 =?iso-8859-1?Q?HwYkHdYp/JoTjrDCE6uyThBwN6PzCdkKOyfTXScjrCwo2mjnYUSEOl6OUr?=
 =?iso-8859-1?Q?Nt+mNTLWPcXpAry4yw0snh5LHNpTCzuQl+uV+V71aaWcRktmfrz2RcBO+W?=
 =?iso-8859-1?Q?LvKDtJb+iywzlfv7qxrKLR9/JL45NAGIYvmcESwyFhmCjnNOL4lQWPE6tZ?=
 =?iso-8859-1?Q?Q0ZFeL2R8g0I2Lv0tzeHKuU7mD1/eIc=3D?=
X-Exchange-RoutingPolicyChecked: jgVEcIJg+fegu2BvdIxqN1g9aMpw61z1C1revImSEQK/knpPCyUNwgPGdUN6Vpfj5RaZEk88eK+uWRlwfjD1PrF3e0gA4vbt9p3QQksMqsrqIieAIAcu6125iGWT3f0w3j1Y60Zqqf+9BTrNpKnSbsAGNrBm+v5pnHE7m4kIJJnN4WXQbtttRcPtuv9/m1o9aV+7851Lkw6yjyaIcFdjBmnwT2chUNNhj/Y7GOOOvbM+/FDitbgsQ5CL5jQ7P/dFqb1ITRpd/FVQmao/nKH/C8H0gdrQB7Uee4p70ODJlD0S9OoWzpiTheAEz8L+ntZbskA1wIwfsgvu2dJ9twBXdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14052e39-20cf-4c66-0d5a-08dea0af8e4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:41:40.2100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC4nB+7t1Ug/7V1gqu22RV3N5Xl+E3NO6G4Jby9gkDjnmJHPP425neVoWUO45JqDt2va1QvSbVaAK36tISWTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
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

On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
> On 4/22/26 09:32, Tvrtko Ursulin wrote:
> > 
> > On 21/04/2026 02:26, Matthew Brost wrote:
> >> Triggering kswap at an order higher than beneficial_order makes little
> >> sense, as the driver has already indicated the optimal order at which
> >> reclaim is effective. Similarly, issuing direct reclaim or triggering
> >> kswap at a lower order than beneficial_order is ineffective, since the
> >> driver does not benefit from reclaiming lower-order pages.
> >>
> >> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> >> exactly beneficial_order, or as a fallback, direct reclaim without
> >> __GFP_NORETRY at order 0 when failure is not an option.
> >>
> >> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> >> Cc: Carlos Santa <carlos.santa@intel.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Cc: Huang Rui <ray.huang@amd.com>
> >> Cc: Matthew Auld <matthew.auld@intel.com>
> >> Cc: Matthew Brost <matthew.brost@intel.com>
> >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> Cc: Maxime Ripard <mripard@kernel.org>
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> CC: dri-devel@lists.freedesktop.org
> >> Cc: Daniel Colascione <dancol@dancol.org>
> >> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >> ---
> >>   drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> >> index 26a3689e5fd9..8425dbcc6c68 100644
> >> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> >> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> >> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >>        * Do not add latency to the allocation path for allocations orders
> >>        * device tolds us do not bring them additional performance gains.
> >>        */
> >> -    if (beneficial_order && order > beneficial_order)
> >> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> >> +    if (order && beneficial_order && order != beneficial_order)
> >> +        gfp_flags &= ~__GFP_RECLAIM;
> >>         if (!ttm_pool_uses_dma_alloc(pool)) {
> >>           p = alloc_pages_node(pool->nid, gfp_flags, order);
> > 
> > I missed this conversation so don't know if this was discussed -

I meant to CC you here, but missed including you.

> > having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.
> 
> At least for AMD GPUs 64k doesn't matter at all.
> 

Same on Intel GPUs for system memory mappings - it is either 4k or 2M
GPU pages. VRAM can we 64k pages but that isn't involved here.

> There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.
> 
> I have no idea how we ended up with that in the first place.
> 
> It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.
> 

Or we move to a table config if we find drivers have multiple
beneficial_orders.

> > Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?
> 
> Oh good point, most likely not.
>

Without completely reverse engineering the core MM, I'm not sure here.

I just read the kernel doc for __GFP_KSWAPD_RECLAIM [1] and this to
indicate if this is clear compaction won't be entered.

Matt

[1] https://elixir.bootlin.com/linux/v7.0/source/include/linux/gfp_types.h#L198
 
> Regards,
> Christian.
> 
> > 
> > Regards,
> > 
> > Tvrtko
> > 
> 
