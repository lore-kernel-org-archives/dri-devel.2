Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E1CD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866BA112084;
	Fri, 29 May 2026 15:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TBH+8zTz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE252112084
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780067234; x=1811603234;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ncn9/t8wo+g9UqfzZ83Qwz95gObSvEaRuQF1vZb9xa0=;
 b=TBH+8zTzUdXyGOfITA1tGBkLWt4fYPzasLUAlKSAFxS4ICfkaNLd3+OE
 LUCiABsGFQLzm1oszWw52oqXnx8N+sTZIxw/zDAKZuzg3wKMX2o6kKafn
 aWHHjmccC8PlQfS4o7yHsUeuoOIBseyhkOjGUFx768U491W+Tf+o5O2U0
 woYLz+JKd+NXuRFT9Lw1/lMQUn/Rz+Lg4GIYN2A1QjHUt1JDnBGyR5LOq
 +LOFFlyKIilrVtVAsDdzzZ+teUaxPJ9xfbijm5lWqse8f9D5Hdbz/qUXu
 KOzi/Gtvri/qtEzpyZjJml8j73PuMfuU+70gupisX/lLFjfYwyXUlxckR A==;
X-CSE-ConnectionGUID: ebnWbbiuSqKnnTh1WriDDw==
X-CSE-MsgGUID: qCQN9bgfQbycnVPCaNektg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91605042"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91605042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:07:13 -0700
X-CSE-ConnectionGUID: fN624Y3yRm+C8XwxImS19w==
X-CSE-MsgGUID: uXw5P+GcRr6Y944vI8EKFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="273185626"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:07:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:07:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 08:07:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFhqbfDytjueAfNglb0KOkvF24a2ZEO+2E+ybPdUy40lYM36CkJsRFmuKxWuxfaANNxQ+J9QpfNG/Gq0ECqcnPtZWLL6D4y+0iP9GtUK0ZFw6kYDX4xwsDSJQ43OcQ95XJcz2fupRnLOdMmQpxPQfqnUc3hclGByIBStdE5Nkttw+Figd8uZ9hHDp2CcdAwNlPGqPlLtxmL1I5YcPcJ2SBAXjgwP9fjIfXSi9Dc23IDFN3/mWIZTbKK4HIhA4LPz8sDGNtsOYnurpYZbojeq0Lr4MP7ns17xikrFdkoKADnJq5AYuTQxL9JUkgGSNVLE8CP/HMqaLxUjnIe+XXN4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxD79VvVTxuazBp19AHuPWl7CzdYQ7C0o/EL8vzEtGg=;
 b=FDnt1/szOY2cgtS7cx2nMb9OQ4ZvgNJc18e80g2anTiYmimwxB7VzpnRGMrGVHFyoTChT3I7+KhD0sen/sZ+74XctyunFpKgfEJ4xBK4qdx7oIMkoJnQMMQQIelk4EmvrDPvYP+kE0QtNeVwzx1hfR2vww7HR9OTpaoE3u9qt6+0hcKInh1FpFywP+eRNNPkOvt1nGuOg2rLhf9ilqiyRxsRAk9TFSyNI8oiJk85oS6hn4WdTh6P0BJy6k3PPWtHueMumg9hWixVr8mEKjeNZJPwINxJsWObMDhLj0Vj4Hsnz57uwkBRwx142YuIMh+Uq03ht5A7td+Wg1oFhkGyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 15:07:08 +0000
Received: from PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a]) by PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 15:07:08 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>
Subject: RE: [PATCH] drm/xe/rtp: Check hwe before calling match_func
In-Reply-To: <SN6PR11MB2717B102CEDA7B2203A66DFEE5162@SN6PR11MB2717.namprd11.prod.outlook.com>
References: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
 <87mrxj5frt.fsf@intel.com>
 <SN6PR11MB2717B102CEDA7B2203A66DFEE5162@SN6PR11MB2717.namprd11.prod.outlook.com>
Date: Fri, 29 May 2026 12:07:04 -0300
Message-ID: <87a4tis19j.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To PH8PR11MB8287.namprd11.prod.outlook.com
 (2603:10b6:510:1c7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8287:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5827201e-e619-4bb1-4f68-08debd93f3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iGUF6rdjDoMhuv3hJADL29d33Aw3BUDPuJMn/PpehPNwKjV3I5tMPi63Vv1EiRStQlJuFU3G7R/KiQ3tlBCZnvNYShfMfvDOh34jJto6msb+9nLdtRfhl2VxgZgesyOcA2phy0tS8QXXoa/Chasv9xZKWxYQD6R7bK6zAfywNTGPEjUxpD/qArv3lbYF2ktd3z6DQdnJfC/ahaiZdyRDT7T5CPXIhQeUUxz7ZuuxLK0nfseocBdn87kNXM5yCXYZXxAIVvK62iQ5O3yXVkZgb7UMF2GUgHB6HbWOcFrKuPNSM5BUAzQxCDp2DJiXCZgw4QSdIQ4mE+L/zxoEWMYD2DnCGdTOaoBPs/fAduCP/1suWzSWSpZRumFH9KLp6OSzUpZJW7D+CASzxUjbnor+PrKNEpnC6+R3qn+RlN1TBZQ1tvpd88u2MAHbqU3CApqZMX6OQhmWmvq6NsKa05zv4rDVnh65e+EKVYzdWlhiB+mcRLdsgDSfCYmg1ubITI33wiDDASGWm7xkovM0ICwZ+Geh2B0N8a6p+zCDtuuSkKTWXBx2bPwooHWlDtULe3BG7eRsZbdRSqtwCAfOKSOHecnmW8k/CZcmKzBK3ayaqojlfG0A7FfjCgROvo2jB/30D6z1w/859BB/cJCfpxiyJVISTsN4D71WhNbnAugyJI3xRxpiRkUosYJLDdiOWQ5oXtJaNjNptfHvzZ7Ws5eACg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8287.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bT8Qc4Q6NMmw/pVNnSrpU42Az6HTjZQs+FSLAHiDACZ3jEHN1bxWRlXqs+r?=
 =?us-ascii?Q?oTzPvJdYl+g4PR0q8+7HUSBVrF9lJRRZSyh/90rWfDgxGuuhexkxmAhO7xtA?=
 =?us-ascii?Q?7Is8KNN3o+GxZ8Q+BbirUvkaX05c4+dVLBhi1sarC1DnYh0RMq7fIIrHCtvN?=
 =?us-ascii?Q?FGN4wAv+K6WLkPNpIbAKJqhrxlb4s4+VE+68oOsBGCrpr18KNGNnPvqCr2k+?=
 =?us-ascii?Q?i/q6uk7L2+5QlcIsCiyk9WdG29QNqAPwosU+PM95Q7FdtzoHVlV/GUEuKj4J?=
 =?us-ascii?Q?5lgGVZa+iyK52D8h9G1yiS58jT5C8qtxgTRz0YAhcDO+Q8okPEnduQevBjpi?=
 =?us-ascii?Q?ZlZPz03Sg8a1GIkqqVXtCbvBYkOatn7ob+es65nD0arfGn4rgqBJt2u6f685?=
 =?us-ascii?Q?urm1K0GW0S8OEmBmBMBpdi1ECLFbzGWLcEjzED9L4TEaqZext4+sWKw4tyXZ?=
 =?us-ascii?Q?d7zyLJzVqHHZOW4XE9upRTM0qjbbg9n+Hnr5HCSN8INhH74xmpzmb2qfoYc+?=
 =?us-ascii?Q?jlKxj01p1eK/LCJ7tgG9OkBLPxuLOMDRKyWA2ExXyz2TkhQBYJRrcnblzwxI?=
 =?us-ascii?Q?8vuq57jLytEecTUg7Oayefqleb6BSUxIdGQrMp+Ok4+EDsvMuYVvvDPFpaQH?=
 =?us-ascii?Q?HJFiFwhTDv5F4xiedTSlls9nzDFU4tlbUZrZupQ22mlbn0kzLbzobQTAcxfS?=
 =?us-ascii?Q?+mq1kl0xp9UDoH8ceFE3xxbNRuJyriAmMPEGJbYclubfuMXDgJlvRN8oqNSJ?=
 =?us-ascii?Q?WCK5vzKk+xaqxM54tdNgmeTd4C1Hk/TtD7zjmBbi9icZYMCCU3RgA2swU2rv?=
 =?us-ascii?Q?3L4A5IdVhwpry8EGxieiaTBW2OeGeepBCkqzAI7w3vzZKIDKwDUmTSxGIIOn?=
 =?us-ascii?Q?BnmJWXUVJCAEhIMdkfMzp/RYweZIduwztqNWs06JJuMFV3ZMRJ6ZN/50ujgK?=
 =?us-ascii?Q?z+DHva4rsTi8BJEHRs5bnX5BCvD/gZigXmBH9nJuXNfX5e4BYiUxfbck6xs8?=
 =?us-ascii?Q?IiFSUmv4HYGhKUYsCwBC9PSoyQEoOEjXtquH+Fp8tFLhWcK9sY9dnsQmnHeW?=
 =?us-ascii?Q?F8VV/NyM0WuEm2SbDelOC7DsbN7+OzS9q4V0ug9JJLM/zAt3kNxb7a+/c1xV?=
 =?us-ascii?Q?AFfUBWrGWyOaEbrBjOZfu/lKmD2456kCYyun6V6CoKY8NjZgN4SpTjWp0h/Q?=
 =?us-ascii?Q?BuDKxcDg4BIYk9j73aJAqj0jRPyZaj7aFO6+i5Fsm9X1DkmI1SnghPM5gpRl?=
 =?us-ascii?Q?24VxV6fNC/2B0ollDFdLVRrr3ao4itjzLJ4ht8/vojOyu8fATRfA1ROnkNC3?=
 =?us-ascii?Q?Of+XsK3bldKZovfqJ42W9CoS+wzbB/EQ7Hvg/mVk5pw26aHu4s1aaomo8wod?=
 =?us-ascii?Q?2b8gTXnrPVW+PZHE8Eo6BmRaqHleBd06dgjEFT2V2jsEbnwOfXCnUASo3e+r?=
 =?us-ascii?Q?+qXHcvnZ0H3/gEjhhV8NjA1eqjXr0jXImybwcJYmaA1OZgnaxPqTOfSDxHpJ?=
 =?us-ascii?Q?QyOuZH/I67QxSCmWnql6drFMfcslBEcNqqojCX+Z75wCeZvWmv2gz4W7dWp+?=
 =?us-ascii?Q?cryB1dkKzStqm/7fZNqNIrHrj4EyH1Rev0IoJDqlkOlQzUSlOD5h7QqMpMZT?=
 =?us-ascii?Q?xSiOWVNVrqPtJImsWF/31KIKx2VTVcaVkeeP26m18qHVaDP5TOT3MyrOI4xQ?=
 =?us-ascii?Q?XTGHH8vd/HNPC8obrS1Qwby5xSp7qVuubIrBYhiYdAaVZ12QbKCGCCzmq8Ag?=
 =?us-ascii?Q?S1jibUw/pQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: W9o4XAkBDIm8sVa6Ru4diyw+lr9UJ2Lvx4+cvkIE5tu+P+oOdRg6ew25PDh5eB4mTeLfbusNjOOtDchAEIjZidefpZHwtvGd0o7AAXdH8ONRs/nKhb0DbCTWseGqFScvkIXYmJV9+CceypBc4Dhp9SjpYOKkhRTiTTgjvCCt61f5FINK4n4+BWC6kFG5tozfgMD56OxXMtlvziBbWKOxiwMrXAmOiJ+Cmbmqm2w52kQMccg8Ptl8BdWdAkI78DUllJMQEuHSnvDh6lMCb4W6aRmc3sXSzQ545L6F6fsOOmen4JtevO2pIBQ4MZ9CMi52TW52fCPt0uDchG/QgCN+QA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5827201e-e619-4bb1-4f68-08debd93f3e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8287.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:07:08.4210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCbSh4nfzFNU6cTZgaEjMekjtS69Kn1IVVqzZSZKmoqLb381U4aF7IDvSoV4Ogf0WcB3k0irTfqZ56gIK+FehQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
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

"Cavitt, Jonathan" <jonathan.cavitt@intel.com> writes:

> -----Original Message-----
> From: Sousa, Gustavo <gustavo.sousa@intel.com> 
> Sent: Thursday, May 28, 2026 3:30 PM
> To: Cavitt, Jonathan <jonathan.cavitt@intel.com>; dri-devel@lists.freedesktop.org
> Cc: Gupta, Saurabhg <saurabhg.gupta@intel.com>; Zuo, Alex <alex.zuo@intel.com>; Cavitt, Jonathan <jonathan.cavitt@intel.com>
> Subject: Re: [PATCH] drm/xe/rtp: Check hwe before calling match_func
>> 
>> Jonathan Cavitt <jonathan.cavitt@intel.com> writes:
>> 
>> > XE_RTP_MATCH_FUNC may attempt to dereference the target xe_hw_engine.
>> > Ensure the hwe is not NULL before calling the function, matching
>> > XE_RTP_MATCH_ENGINE_CLASS, for example.
>> >
>> > This covers a static analysis issue.
>> >
>> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>> > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
>> > ---
>> >  drivers/gpu/drm/xe/xe_rtp.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
>> > index dec9d94e6fb0..2cd26db113d9 100644
>> > --- a/drivers/gpu/drm/xe/xe_rtp.c
>> > +++ b/drivers/gpu/drm/xe/xe_rtp.c
>> > @@ -129,6 +129,9 @@ static bool rule_match_item(struct rule_match_ctx *match_ctx)
>> >  
>> >  		return hwe->class != r->engine_class;
>> >  	case XE_RTP_MATCH_FUNC:
>> > +		if (drm_WARN_ON(&xe->drm, !hwe))
>> > +			return false;
>> 
>> There are several functions passed via XE_RTP_MATCH_FUNC() (i.e. MATCH()
>> in definitions of RTP rules) that are meant to be used to do checks that
>> do not depend on hwe.  Returning false here is wrong as it will cause
>> those checks to be skipped.
>> 
>> The developer is responsible for not passing a function that uses hwe in
>> a context where it is NULL.
>
> Understood, though quick question: is this also the case for GT?

Yep. Some examples:

  * match_has_mert
  * xe_rtp_match_not_sriov_vf
  * xe_rtp_match_has_flat_ccs

--
Gustavo Sousa

> -Jonathan Cavitt
>
>> 
>> --
>> Gustavo Sousa
>> 
>> > +
>> >  		return r->match_func(xe, gt, hwe);
>> >  	default:
>> >  		drm_warn(&xe->drm, "Invalid RTP match %u\n",
>> > -- 
>> > 2.53.0
>> 
