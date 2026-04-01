Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F610F931D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 03:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B25110E2F0;
	Wed,  1 Apr 2026 03:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ECIIFQxH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D72E10E2F0;
 Wed,  1 Apr 2026 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775015557; x=1806551557;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=P32sX9gMbqlg8yI/PGy1zx7OmxLibo5IUumVI6uM9Xc=;
 b=ECIIFQxH1B8hm3pH1b1Sy6UOG26D7r+QnnlOFAcs+jBzJQxCY0M4ovWV
 jwbDNQ7qKOLUD2J1XsItkcOrA06ac8hccGgQp5tWoWL9e7lf/Y2ga2bod
 wqf84wbyJhGwuNQcLbaReBJspTm0eQdGTM3D8Kb2q7/lB8rMZQ6QJJm0O
 MNBEO3O+B9JSIfha8HASw97Pste0htHIlH5uskCETfHgdT8In1e+5dT7z
 g3pds48C6PYFMVM1Z6cFpj/6cxzgJZVI0TTSnkm9qcZl2aR9lbnzbbgMa
 jqHWbGqG+qimd6/2uGjxj0CwOJ/zL/aCZg9OHSsQYqRWr8zuQGs3hua9F g==;
X-CSE-ConnectionGUID: NF5te5zXTROqR3cnOfg+Pw==
X-CSE-MsgGUID: 8XmuQO2ZRMWqZsJt7L/Pcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86740088"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="86740088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 20:52:37 -0700
X-CSE-ConnectionGUID: J2VeBgJLSzOaL9nPDabNRQ==
X-CSE-MsgGUID: 6Ry4nh/4Td+7yI19jmMEXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="219899799"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 20:52:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:52:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 20:52:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 20:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKm7Zoy3cnBeA8JNKtN9gugt2D44RovO7BQIiWt7+q0rJKYeUApUijh/hZ9NJuBZliREt+C1U+l1+ziDWkKkQiYPDydPFFHy2ZfI+Qg01JkYS/ijtSpmsOt6Mr3eHgeAGOMKuUm3eypmtpwRMF/qvaK2AyGyYyRO3ItKKvG2Qya5F6Tn7XEYIwuCL4XRnPMPfquIj7APpO3+PL8iJJD3fT6PwgBwE3JzkCjUcsD+TMBNjRnkKCnDz8Ov2aJx4EfH4zzufkLuOzDTVnll9CgsdFp4CBGUWGp9MbwUTHJycU/PrxSezZF2KmupshvCfYJBGu229ol9BTXdATLfzisYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+zUvyq3NFvVQACCko5E276zyJjkI4CRR3cShbo9h1g=;
 b=iHT/XRh4BKbvqXhB8ThE7Evvqc3mDRmZijwcJWlFdhpeLMA3LeXwb2NUIjhLipWU3XFtuBRGDxxTFZGTSEuevebF+YttmhZdtZ63bQ7AuRymkSuibb2wcBw+QLnlBGGZWLAuH8sdpAmMMEbviT7Sauj/P+5P9yWdk1+GrMKaOfMwTdtP8+oJci2gmm4gnmJBPrfF33MaVNSa3JxHjwZeYGkxde0nLefk0M0oZ59hvYj9IjeDVaE2on9WY65VLXPIzfwYge23POmPbMoKlfLXC68LK6MvDjcM1uM7DHmHdusoRd+HWi1FfevMMcv4ZEDTVyLtr0b+YedL2fbqCO1zIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 03:52:28 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 03:52:28 +0000
Date: Tue, 31 Mar 2026 20:52:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Yuri Martins <yurimartins2004@hotmail.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Matthew Auld <matthew.auld@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/bo: Cache vram_region_gpu_offset in struct xe_bo
Message-ID: <acyWeZ+n2D8wE1cd@gsse-cloud1.jf.intel.com>
References: <CP9P284MB3908AC9B3875FD63E955D139A055A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
 <10289571cccff20ba52f224080754705c606ccfe.camel@linux.intel.com>
 <CP9P284MB3908EA888D29440A8129DD62A050A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CP9P284MB3908EA888D29440A8129DD62A050A@CP9P284MB3908.BRAP284.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 140116c3-75f0-41ee-ed5f-08de8fa217bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8CRjHqz4W+MKJGwTHKQzFw0X5HyUAwwB3ZbL4+L6Vg4x06iQTy5M1O46JTJL+YH7FxSNuIxJ2GwI/2Nd0JhCTUGrUhj+dcVgxLM3zkUeBc5DSdANRyeurEVvbqqBwjnxH4stH8tE0r612rK1ww3zmKceim2k5Kocwef/nQTFv2zOmf36l4VyeRpT7nfGrH8iUblccsuUNfgQLjuFNfh92fvwNez4e84O5tjXYwJiIpLqCCV63RhzKpVa07UKnr2HIo9Y3FxlUIiLg6XHkZBXoEdOez1TomI8PifLtL1u3JKpqghjBj20I/eKN5cUiCf4l7e+PtH/mnG6+Psl45kIE0UBj9ZSaXiUmDLhztS66cJVMNhcuWAa7kSJntf2BrILVj+/Iquw1qn65unNgKD/fogM/vOWM4Ahmso/h9S5VMs+MqsNH5zGl4i5QaxBTY0zGxmdsJ+xXkZJxhbuotVdCB0qgUqfHgVWITjCQyqWqcJ6dw/gHBToOvlI+Q+GfGxkdnFZaEXIir6v7bBc+Fbsvimbh1K7kLBm4620fYSnGZXP0mRUmTHwTgf3rWz9MNt5gHqtxRhHhZRQnSs2Ce4Cb+HDBHRccHqg0OdWroydQHgqqikG7OV57rPGm30091jv+QJXdgbJx/nFTtpjjS0iwWguWrNTwfH+geGnVl0CwJYdOx1EqIVF6EhHhXMvSIN1YRVWZpSEEaxDhcDtvUax0SOolLftAZHztRr5HEhysUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVljcUtoQkVXbEtoOW5EVStNWlkyZ0luOWhRT0RacC80MVVuQzQvWmE5QThG?=
 =?utf-8?B?ZHlMSWpLNXVBdUM3amNpVVZyMWhqbXRueEcxNXhyckxVTWpKSENPUWovNWlv?=
 =?utf-8?B?Zlh6aWtZRnlYMjNvMnlpdEdlRkRPMDlKWTM5VjZIdlRCRDNseXFNS2dCVEk0?=
 =?utf-8?B?dzZ2WDU3NlVSYVl5RzBlaVk3RUZKcUdOdGVWMWNScjBhOU0yQ1JkTGZJWTI4?=
 =?utf-8?B?UjB3bFVWOHNPQ3ZHMkxucW1xNUJuNVhnWS8wRkR2U0ZNa0NRYk81RmtOM0R0?=
 =?utf-8?B?YUFma3VmTWZqcWRnZXFYVnJYcHE1c3d2TGZJR0tMYTdVNzkwZFcwTG9oWGt4?=
 =?utf-8?B?MmtYUEszWUJCcFhFeXI4bzdYUmZWN3ZpYmpvZkJkS3hUZ05KUWFna2o2ZkJu?=
 =?utf-8?B?UzhjYmRVM2k0MjJVcnBiT2VTWTZDckpJZ2I5ZVBLOG5lZS9xWFdmOHFXY3VW?=
 =?utf-8?B?c3NxekhIOXRhTzdiSzVVL2FwVFNFY2RsMW9YaE90eVFNRkwwSTV1cVpMNW9E?=
 =?utf-8?B?dFZrazU1L1grcTVLd0FOd3NaV1BKTXJBcmdmVFdZcmlQV1d1WmtjaXRIbGZV?=
 =?utf-8?B?S2JRUmE3ZzZiTlJtc3JUcFcvbHlzdm03RXNpVTlnSGQrcUxPUDR4U1BWVkhy?=
 =?utf-8?B?M21ieUVUUFBRM1pzQlFtbTNwaEtwVFJRVzVoOVAzcmdHemxFeEorTXRvdlht?=
 =?utf-8?B?Mk9XYU0waU1EVERhUnMyQWFvdDVyRi9uUGR6Q3FFSHlhNzl4bmowMHVGL0ZU?=
 =?utf-8?B?ZEZCK1RSS2xreWVGcHY2TzA1ZHhOQno5bUF5WnhqYVY1dCtsNEpQTERIZS9O?=
 =?utf-8?B?Q1FmOVVLajF4bC95NkUzZVIyMTQ3MWJFK1IxTnVBNnRxbzNMQitiRjBtRWRs?=
 =?utf-8?B?NVdIRGIyTzhEdzJjMDdyY1doaFNvc1dCU2R0OHRiM3ZhazlEb0RWdG1QQXNs?=
 =?utf-8?B?WU1RTEZIbDBIb3UzcjlmcWNSRGp2OWwxbVFoanp0ZTZwMUpnT1BpUGdUc3hh?=
 =?utf-8?B?Z0Y1L3Y2ZFUvMHJPb1RwTTdIcGN2ZkRWUHBEK2Z0QTd2S0F4MVJ5MGdJK3Rq?=
 =?utf-8?B?SDEvRGcvZ0c5VnBUdVo1ZFBiNGNzdGZlbjVzREJwMWhGNndzRmpweWFUR2Rh?=
 =?utf-8?B?bHNJcGZjVGFuc09JT05aWTJ2VXhNM1JkMzNlOExJT1BwajNBYmVqbkt4Unl6?=
 =?utf-8?B?MURmWGJvb1lmc2x1T1ZiUjQrNjJGMjlxL1UyZCs4L0JOUWVYOThTSU4zcVNC?=
 =?utf-8?B?Z1pBYkp0eWhLaGc5VnQ2Sy9oYW1GTUFpUkhXY2FNckpMa09DQ3ZwdGducitV?=
 =?utf-8?B?UDdHU2ZjNWZweHlFZEZGQ3JsRVp1dXBOWjd6bFgyZFVVVGE2UFZxWXBzS3A3?=
 =?utf-8?B?YkNZajQ1Vml4Q2dWUUVyUnFIM1c4djNReVQrMmZteGFxTFRBZ0hVVkljYUp5?=
 =?utf-8?B?UDRhbUpNRDBYcU1zRlFrTExZNUUwTmhyR1AvRlJPdHJzWm5DRjVUc0hnZnFU?=
 =?utf-8?B?RE8vQ3FneFVkeEhaVUdPZnV6cTFOc05hbE56d3FWUWN2MTNIMStvU2JXN21X?=
 =?utf-8?B?RXZhd2V2enZRTEFQWUJGekRucUlrODVCaUh5MFZOd2NRSGQzcmQxbC82V3NY?=
 =?utf-8?B?STJMZ3luOStrcWx2ck9WblBPa3ZRN253VGlqZ3dMYmpkb2JlYWJlUU03N1pZ?=
 =?utf-8?B?aDlCdDREMjNFayswT0laMWxuU0dna2xPQVgwSlZwODMzbW5DeVc3NUxuMU1p?=
 =?utf-8?B?VUJTekV5a3p0KzRRcmNDRU1qVG1oT3A2WExod1ZXQ1VRcFRJNGRCc3RlOExm?=
 =?utf-8?B?V0VVY2lFdU5ENmlPUDFwU0Z0NzBwcnEvYndiSmpsajRiZ1hFbURpQUZBc0ta?=
 =?utf-8?B?VXZhc0xIS2RaWjRtTXZSdFZQRGE0RFc4K2w5NGhNS0hrVXdWbDJFamxNckRF?=
 =?utf-8?B?QllXcGIwUlpYVkhZYm5lUDFMM0Q4ekptemNMUnhLeGNUbVc1TmRxd2ZBTVlG?=
 =?utf-8?B?TDIzV3k2TXJRSnNYWWs4bThKNTYrTHFSRm9xNEo1dm0zK0R0WDJ4ekxIUlJB?=
 =?utf-8?B?Tm5SRVBOQ3BESjVDdlB6YnNKMzN4SEtSZ2p6TGozQmUvcmpJMy9ITWJxU3Zs?=
 =?utf-8?B?L3pOS1hjeml6MFpMNmVKRGxiS0szdDE2TDREMXRTK3Nla1FjdGlQV1Y3Y2Qz?=
 =?utf-8?B?Q0R3akpFZFRVQi9kUTE1WEFyOFdCeVQrWFBRa2pxVGdkYURWMFY3YmdnclRV?=
 =?utf-8?B?V0pSMmJSYjhkRmdhbkRjK2pCY0xSbGxKMldmeDgzVlRwam5Bc0ZYOCtrUkVl?=
 =?utf-8?B?QVI2T0FZVG0rZlR3aFo5dDlwZExrbXlxMHl4RjIwUUpsQzdyakJ2SGZjMEdn?=
 =?utf-8?Q?J3sUnX3bbYRdgKbA=3D?=
X-Exchange-RoutingPolicyChecked: I7Xmf/AfDb0gpqvWnRftn8TEoZbn19kl3jvDcQ9gv+jn7OzMYJSFvyMgAP5mV42rgJRfxkHBmLNKoDgm6vTEtGdsw86TiUYHonOMDTtz/WuGJyPmtKM++kIO8CvglwnGP0/Jee44XH5tHHqFwB/LbgmTQGjaJlxqh6vMvOUgpMpc/7tydL62gq+mIJXjUJxRKj3X+LE02xOYFghkPktKlwxCBet08fArR5uc34PN1b4U79sAIVmFIzEvTpLq7b7AVLlINyJMndnRZKgJOj40b2P+x6ncE05q6Dx2g9Dky/ZX484Lto/ScaNanoylRCOpxdWnD1L/KWolNqezsGxx1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 140116c3-75f0-41ee-ed5f-08de8fa217bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 03:52:28.2060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqqs/MaXGirp8MwgVXb64nZcSc5zINV1kGWqFxtAxMre2Cn8cavrSd2jbgLxWXvABf9VcUlaLjkbwvMgOld1ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
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

On Wed, Apr 01, 2026 at 02:53:17AM +0000, Yuri Martins wrote:
> Hi Thomas,
> 
> Thanks for the review and the detailed feedback on the move_notify pattern.
> 
> You're right to ask for performance data, I don't have any. My hardware
> (Core Ultra 7 258V) is integrated-only, so vram_region_gpu_offset() returns
> 0 and the path this targets was never exercised. I should have realized
> that before submitting.

All good — we should probably just delete this XXX, as it was an early
comment from me back when I still had the i915 micro-optimization
mindset. I agree with Thomas that a change like this has little to no
impact, given that binds (where this code is typically used) are orders
of magnitude slower than clearing or moving memory. Plus, binds really
only end up in the critical path during page faults — and even there,
we’re usually moving memory first, so a little pointer chasing isn’t
going to show up.

As someone who has done quite a bit of perf work, here are the areas we
should focus on cleaning up:

- Time-complexity reduction (e.g., if we can go from O(N²) to O(N log N),
  etc.)
- Reduce unnecessary context switches (e.g., don’t call queue_work()
  blindly when it has nothing to do)
- Memory placement improvements (e.g., move CPU-read buffers to system
  memory; move GPU-read buffers to VRAM)
- Use the hardware correctly (e.g., reduce GPU context switches for
  common kernel operations, etc.)

Matt

> 
> Withdrawing this patch.
> 
> Thanks,
> Yuri
