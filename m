Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VVcSLKgx;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dpY4d/7A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C594A10E10F;
	Mon, 23 Nov 2026 12:17:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C9210E10F;
 Mon, 23 Nov 2026 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795436260; x=1826972260;
 h=date:from:to:subject:message-id:reply-to:references:
 in-reply-to:mime-version;
 bh=3yesYpOBvj+1JvU0BLW5eYfvPf0YFFYjsURhSIbY94E=;
 b=VVcSLKgxH13vHbJ2SiDHjraOzRsEKuWtd7EqD6sPKfTVvnAd0YQ7qv5c
 k8zOKM6e77Eh3uDEk7n4RtgRkRFtU+HfXvGrhtYTZWpA0upemKduKZ/OT
 koBiaMp8S5aTEqokM+yreLFzf0+XUX0weF9tJnH5aEN/+qGhmIyh1JXTI
 Unv46psEr0D+B19OId/HaqKOJyI49lHpkSZJDhncoswlVjCrUhUOb/I0X
 oUt7P3ucNzyoNwatCF1I+9BOumejrOtcX8By+XHWwAOrSvxl8h/8ZVdC6
 Z5wV6EXNPDsNIOQyD2AYUPW5561C8uOyQBaxIhckFnTMksQNuTBJLwX6s w==;
X-CSE-ConnectionGUID: r7SEuE63TZ2QJ+QHKfbBYQ==
X-CSE-MsgGUID: WashCc/iTxu3/vQDTJlznA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4113882"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4113882"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:17:39 -0800
X-CSE-ConnectionGUID: vdE2l600R3mNopcd+mIDaA==
X-CSE-MsgGUID: XlOpD+YcQrCTh9dymZA0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11067343"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:17:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 04:17:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 04:17:38 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 04:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhaPYBTr7OFdUSyAmADE9TtHlHvoZVp9N+yLBOZHo1Y1kR0ngnHF2EUQmWqd/zG59LCLL1PSIUXoTyTrvIm8N3K1OnSi+RtrkMTPKgPiCkwlEKc2zIEBAX5AmJ8YqSVh5fcFpS77uxI7cxLsC5f+NxeWGqMXddBvGLeHYeu1Iqlpmf1egBA80DdZ5z301NaJrPK8g3KSJYZRqcebnqRQbtLpCOnXosDF5YnQKMuw8SxpJULwUT/exLq+Amrzt5f8GIm2HLDFl1AiPgAEdR4Th7HlMPRS7XJQsZXAMFaNEgc+9uwUi2lYNeFltJXhEuY8SaKnUsg4Th6AhbDikSQj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkTKamSocEzIqhyHMedV5N3LOGQx5epo987MaZ1dcAg=;
 b=FtofULDFuoHAcmn+jqMeB80KIJQ3ybcE/LJAx9xvOu0KXcc+2CPDmULLMAQelh6uEV06IfKBJ8syrzjbETKjahf7RIo5Cy57B8sig70PMcDjTLsExR82I4epe5EnYQYLKUl6YdW4cCxtrnoDoYvBV5S/ogDamUp0zoG16Jm7PdxgpQQULJMRVIsKnzrtNaff1pZc79AP3AsLVhXgx5x15laRKwKy7q/kTvRbh5NHAvV/Ycmj58EKPQ4ZTvaRfASj7uCr0J+rgekVMs98RBSfdXAiD/ijtJz3KZcFn3Qo3Xz4TVogB/fwXumsyiTjkwhKXQboOXBP3D3xGMLAa5Qihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkTKamSocEzIqhyHMedV5N3LOGQx5epo987MaZ1dcAg=;
 b=dpY4d/7Aixc4vMmJAO6GojnS4aeYofjcjoHh2FhMTW+C8Kfeh/d9lsuFd0sUIdp4vxMPd8JGbR04uUIRljD8rcKIulGrXW8YCeQWRl2O0g2bd9CiM5Wq5F692ZzX1sWq8fdjtTVqFBlW0e/SRMu+kZYGHwmeuuIqB2EuZtCb7ew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DS4PR11MB9602.namprd11.prod.outlook.com (2603:10b6:8:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 12:17:31 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 12:17:31 +0000
Date: Mon, 23 Nov 2026 14:16:43 +0200
From: Imre Deak <imre.deak@intel.com>
To: Frederik Schwan <frederik@tty42.de>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <regressions@lists.linux.dev>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "Dave
 Airlie" <airlied@redhat.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
Message-ID: <awQuqw8dBZ3UPLA_@ideak-desk.lan>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de> <avsSK1OE97meC40e@ideak-desk.lan>
 <avtDzWO1sOXYvxZ2@mail.tty42.de> <awQg61Q0leUUP3yH@ideak-desk.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awQg61Q0leUUP3yH@ideak-desk.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GV3PEPF0001DDA0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c7) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DS4PR11MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 6600a1d5-6773-4fe4-e2b4-08df495bbf56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|11063799006|261021123027099003|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: rsjO4KRj4It7FpRqLEL7hPZuuFH7vPHomiFWnigF70e8q73LCNzr1t6ZREd5myHsl/TzqmHsLhY6qmnbrBiRInlGnFeyMPw/I0LigmzrOKFTi3wqpPTkt52m3fg423xOEVv7vr7gAaozbaO7Y5QWr3R5v3oGeG3pSq8qMBCUw1Bsy31NsDMjhA8X9scBu4VsIS4ND2A3Jh0mEMXEfcdOdWZpju7SjZ2AOVyUTdN7GOF/Dpi3k0RLXzpkMoWrkxYEnTxLFjyKphiFskRG+ZCI8wajmqU7UeWyyz5KzzCKKCPTq79UL0wd7EumEXMAHIrpkNt4p+P6KOxpZUZ35HwrQXYXmk8Enasf+Ctw+4jF4PCZ0FLYNUWbAjaUparE+eLXqph2nnobZ9hmJHUB2Em3CZT9jJni49tsAR5wyNIAq39U0gqSfmv6FvAM51FcEYft+PbD/fvXXXUBFzkH60KNBm5SPHTo6P/YclXIXomjCIexkK+MyguHD8lCHvSFNRzI+EcqzX7YuUygaPDkjUepcXsSIw0TdIyqgWGtOB+uZ9lHVuY2IUYNVhimlxKrCeYmQl1NGzm1ycyhm2TLg+PCgvj68JHMzHKJuszmkPt+xBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9273.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(261021123027099003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9a2DTOGb8n6QArG/oUIuHj20sfhOnqhpTBZgNcxY84ULX49/JT/gG+z2PFFC?=
 =?us-ascii?Q?TijAux7BLIt8mrfKcmCvJzB63Y94JwFM+k2QVe30Eif3sgmPTAiabke9wyar?=
 =?us-ascii?Q?2I7FuF676/8oXIVQotve8YIO2HS591su8b1WxqS8id2TbtiHpV0kf9iK7u4Q?=
 =?us-ascii?Q?nKqwlMpvpVXHRAplNO7QRq7+limlKHjt/1sVrQQWb0oqMUOEDoKaGfNA5aon?=
 =?us-ascii?Q?Q6GeWpDrtO1u+Z4OC6wPiYFXHT/PhNuLHUqzx/K60U55jT3nKmovtxhAQIUE?=
 =?us-ascii?Q?0yZ+Qw3L/luCX6zIXUQ7+IsvKivE+NaGJpO53IC41lGmJL3va3uy0Ht+eBPY?=
 =?us-ascii?Q?7xbWnDVBfSVTfnsbP0BorexVBkMY4zXCWiYUbA7KuqN5JXQSJ/ZN7Hq4GgOF?=
 =?us-ascii?Q?4A8+Md6m7nyX3+M/jOZoL4v85tcr4W3+HtP9K3lKDskdkF93ZnZq0c55z0Bk?=
 =?us-ascii?Q?jkx4r5BXRgWlUprvW9uMvEbtDfwGDGwf8MlFcZpJwzoGBElQiUNp8Jg+eM1B?=
 =?us-ascii?Q?0RWGWmXVmyPLVeKCgiT15cB16Zp4CYQZABUjJ8w9EfJKOAmXaAfi0YZSQJVe?=
 =?us-ascii?Q?9P/246Yv6knzgvU3+2nG1w0qVRcEiSyWmPTbyWCBVVDlsxy9K8fm2B0OgK6+?=
 =?us-ascii?Q?gYtqXiL0MzCf/Niu8SlDVcM+V6QLjpahwxZso3xgZsOQkKmdoahXXIRh+BIn?=
 =?us-ascii?Q?KJ13qtnzfPBG12wG8iDM9SYQabDCnisrCGHf2AYmtD3rQQrcdHCvrXIbUVBL?=
 =?us-ascii?Q?n66g7aq+1/323dKpT+6EuY8vUNi4Wm7ecUdjolTKvFte6IttOrSMQGRwnZYW?=
 =?us-ascii?Q?dYUix2wz5LRbe6MTYLhuZfKx/E7HxpZdB3aco6mIlq2MnpAsU0PXjUb8hEpW?=
 =?us-ascii?Q?VfWI2EeifPtMeztEieEpLJ6VjV4tlI7WrFXh5xV+lwThvk5JLZcQaF1eZicu?=
 =?us-ascii?Q?NLIPVYWmbqIQwe+6404hFbFCvQpziWgxRUpj1P39xxaE+iCyjgrkW9Iw0Glp?=
 =?us-ascii?Q?93s3w+/9QNz42Eo/at1HZk0Vao6qkB604wdB6WKjpemPcmBI2+/Psdm/0vAF?=
 =?us-ascii?Q?nbzD7mAcs1HzQ9TY4XF7KAV7ULRlPrhMoaVbF5yJfTQRgM6Jfiy3vNL7rOKa?=
 =?us-ascii?Q?98jjnnRLnLGojTZdtnKaqwReeAKqJV6eA04hR5JbgvzPtwdLHmy0an0UK1Lk?=
 =?us-ascii?Q?ToPW6Tex1nqtKWdze1hkvNayjjiBrsZzo6BtTghepyAZMQP6fwOLFImBtg67?=
 =?us-ascii?Q?OJBIWyG67klds/0RBnueV8ASUyMo3zsAoyQmwmOSKndW0t9LK+kQb15+eOLW?=
 =?us-ascii?Q?Ql9mhyJmbsBoo5dJR7mZacygTjS4aP20dQznwryjQBIBW8QsjSofBGZzPjey?=
 =?us-ascii?Q?BwPB/s/j6OqhPsEJVIykikERB4V8tPy08XP1JKg6vKOQvpw53F6GyjiFw2Oi?=
 =?us-ascii?Q?RnC8Xst504NyMQUo+MVEYdcnT4LdsbBKULhQMzSThi1zvw5icTO6QixADw0G?=
 =?us-ascii?Q?damjqL9QzGLT0sfUrPGH9Aecmg8j0bWJW7dDaiTfuRQZhlS2tPGaq1hC1bpN?=
 =?us-ascii?Q?qzDwz4L77DKlMMwDXNRqxJ+WBifwllb23klJl0vugRmpgxXJyjpi0z+5lO/c?=
 =?us-ascii?Q?xr9yVUYfYtdPtSLS275nWDEK7jgEe9QRSM3+ctZTbCO3Rg2MuzEDBARrpP8X?=
 =?us-ascii?Q?3TguTmGTCVMP9LI0rDyiIWebd79vgmuxVnIQhQ/kmO5JqnRXxSFoeTq0xUiT?=
 =?us-ascii?Q?HHXCKo+w8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: Tm6EeDGuBM6HlzkGS9MhpYsjT87dKnYEFRlziBF+dYDh3AGiyE5+D2SJY2XRHBJ1XIU/R8JKQiuCA9RcKEIZITn07uuVYqCNljPwZ+5FUKZ/elfyXP+xVSM/8ilmpdZEPg+Bov9yF6SFJh6UDuxd8y0tXbHyZEzupo1cdGuz0N55sfTnkVM679iBoyUmB05kWzat9EnRq5TUuxVCVDP9w74ff2svqVcthWu2nhHaH31cnoygOKsRpTZh4dWQsLbGbht993+zFM6KNH2+Dacl+hCdLY2Z+b5TOmVBXWlj235GK0K+JQEkk1SKTuZ9SMBpQeLGg8dn+op2/J7O7PzVlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6600a1d5-6773-4fe4-e2b4-08df495bbf56
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:17:31.3279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x7rpdUm6Xek2tJIMhhpZPA2CRVCadMnAnjY8pU7sO2c1pKZAexDQTvSKKWuFm/Ve1faD8qyBx0iUWxkJntSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9602
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
Reply-To: imre.deak@intel.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 01:18:03PM +0200, Imre Deak wrote:
> On Mon, Nov 16, 2026 at 07:08:02PM +0100, Frederik Schwan wrote:
> 
> [...]
> 
> > From 55a68a5e094557572b278fa3193d36c147f63612 Mon Sep 17 00:00:00 2001
> > From: Frederik Schwan <freswa@archlinux.org>
> > Date: Mon, 16 Nov 2026 15:38:15 +0100
> > Subject: [PATCH v2] drm/i915/dp: Fix source PHY updates for UHBR links with LTTPRs
> 
> Could you resend only this patch, using the above Subject line for the
> email and making sure it's sent both to the
> intel-gfx@lists.freedesktop.org and the intel-xe@lists.freedesktop.org
> mailing lists. That ensures that we get CI test coverage for both
> drivers.

Did the above now, so no need to resend it:
https://lore.kernel.org/all/20261123120954.1115838-1-imre.deak@intel.com

> Thanks.
> 
> > 
> > 128b/132b links use LTTPR-transparent training even when LTTPRs are
> > present. The DPRX is trained directly in a single phase, without first
> > training each LTTPR PHY separately. The source must therefore program
> > its FFE parameters during this DPRX training phase.
> > 
> > The source signal-level update is currently guarded by
> > intel_dp_phy_is_downstream_of_source(). With LTTPRs present, this only
> > accepts the source-adjacent LTTPR PHY and rejects DP_PHY_DPRX. That is
> > appropriate for non-transparent 8b/10b training, but skips the source
> > FFE update during 128b/132b training. This affects legacy and DP-alt
> > port modes; in TBT-alt mode the Thunderbolt subsystem owns and programs
> > the source PHY.
> > 
> > Program the source signal levels for UHBR regardless of the detected
> > LTTPRs. Also make the per-lane capability check used by
> > intel_dp_get_lane_adjust_tx_ffe_preset() use the source PHY's capability
> > for UHBR, rather than treating the DPRX as a separately trained
> > receiver behind an LTTPR. Preserve the existing 8b/10b behavior.
> > 
> > Enabling UHBR tunneling exposed this older bug on a ThinkPad P1 Gen 8
> > with a ThinkPad Thunderbolt 5 Smart Dock 7500. Updating the source FFE
> > presets restores four-lane UHBR20 training and both DP displays.
> > 
> > Fixes: a421d8a99216 ("drm/i915/dp: rewrite DP 2.0 128b/132b link training based on errata")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/regressions/40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com/
> > Assisted-by: Codex:gpt-6
> > Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> > ---
> > Changes in v2:
> > - Explain transparent UHBR training and legacy/DP-alt versus TBT-alt modes.
> > - Correct the FFE preset-selection path to use source per-lane capability.
> > - Point Fixes at the DPRX-only UHBR training rewrite, not tunnel support.
> > 
> >  .../drm/i915/display/intel_dp_link_training.c    | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > index ac1aff6edf05..1efc78b329a6 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > @@ -773,11 +773,14 @@ static u8 intel_dp_phy_preemph_max(struct intel_dp *intel_dp,
> >  }
> >  
> >  static bool has_per_lane_signal_levels(struct intel_dp *intel_dp,
> > +				       const struct intel_crtc_state *crtc_state,
> >  				       enum drm_dp_phy dp_phy)
> >  {
> >  	struct intel_display *display = to_intel_display(intel_dp);
> >  
> > -	return !intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) ||
> > +	/* UHBR training always adjusts the source PHY, even with LTTPRs. */
> > +	return (!intel_dp_is_uhbr(crtc_state) &&
> > +		!intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy)) ||
> >  		DISPLAY_VER(display) >= 10 || display->platform.broxton;
> >  }
> >  
> > @@ -790,7 +793,7 @@ static u8 intel_dp_get_lane_adjust_tx_ffe_preset(struct intel_dp *intel_dp,
> >  {
> >  	u8 tx_ffe = 0;
> >  
> > -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> > +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
> >  		lane = min(lane, crtc_state->lane_count - 1);
> >  		tx_ffe = drm_dp_get_adjust_tx_ffe_preset(link_status, lane);
> >  	} else {
> > @@ -813,7 +816,7 @@ static u8 intel_dp_get_lane_adjust_vswing_preemph(struct intel_dp *intel_dp,
> >  	u8 voltage_max;
> >  	u8 preemph_max;
> >  
> > -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> > +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
> >  		lane = min(lane, crtc_state->lane_count - 1);
> >  
> >  		v = drm_dp_get_adjust_request_voltage(link_status, lane);
> > @@ -1021,7 +1024,12 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
> >  		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
> >  	}
> >  
> > -	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> > +	/*
> > +	 * UHBR links use transparent training, so the source PHY must be
> > +	 * programmed during the DPRX training phase even with LTTPRs present.
> > +	 */
> > +	if (intel_dp_is_uhbr(crtc_state) ||
> > +	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> >  		encoder->set_signal_levels(encoder, crtc_state);
> >  }
> >  
> > 
> > base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> > -- 
> > 2.56.1
> > 
> 
> 
> 
