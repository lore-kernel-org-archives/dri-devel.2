Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3649CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1236110EFED;
	Wed, 20 May 2026 10:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T2wWvasz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE9410EFEB;
 Wed, 20 May 2026 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272540; x=1810808540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YyIbdRrI0oO6q6fUCG4rz9EMsjGVGTOURdKNCz2wAjc=;
 b=T2wWvaszWWsDyuw748R8jMrrPSKRN1ylrtlhnWDfp+bC2ZcVgZAEzave
 mnTuz3UX7k0krgSaiA/1MmzmrVmagccWREWGVdh4cGd73SFrp5sTjm1ma
 aEUHg7snKScx0hlngcbC4IoCFT83Cigrf/fFRKpaLE4oWpfvX6YvUVhZw
 SAxom+yp7axzCPwkzkakJ5JMo/vCgl2OY6xo3GZOf25W8cjyBpHIN0LdJ
 GQUjtt9C40FppHXALvgoR5Wt28LzzSNpVseut2GEvpI1Rw6MSspcR2Z3H
 SLMzv5+7dmQpH6Nku2GgXHtG4guq7CjuyhstVlcn/H7LUHTCIOb5L5hXP A==;
X-CSE-ConnectionGUID: 8qbtJ5M4SL2LrQH3cJm1lQ==
X-CSE-MsgGUID: UgbbKYDnQmOK7iAm5RmnbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82744673"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="82744673"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:22:20 -0700
X-CSE-ConnectionGUID: ZYudiVzJS7epKoL1mqhJzg==
X-CSE-MsgGUID: NiJ2uJrXR0uT3Z54/9TgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="263636699"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:22:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:22:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 03:22:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGTU4xnoNeushYJYpTruqEgvv2zV9bZnTdbY/edNbMOVmfG9+y/2KTJKNn1k99SQsfLZjulCLTGEF3Rn+DqBXQTFMOjkfUN9qczYvpa4tMrROeLyTPSGYlP5Lu4fkRp2xwkqvDhJe9XWhpZCFRlTzI/lR+HdsOICh7JcRPEbPSxjXPHiLtqO7e+txnJjI85QGgmUR8crKV51i8a5aemSkebevoN5v/EuAHvdz1QH5ZngoxgRqpUUsjXYUCQZwCnvHWEgztBu8OPW007CEh0IewnT5CTdDSlpcVbJYo7yF4ZC3rxPVG8BaQig96TECjVyHPGQ8aINLeA5LmQtceWRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyIbdRrI0oO6q6fUCG4rz9EMsjGVGTOURdKNCz2wAjc=;
 b=WbM3eYXyO1+MdLxUugzdUbH+vS3cbOBuiOQQXwJ1UMMUQ0zHGiOdg6O6M2LifA3qocKWWW8H7LHGtcmkXm4mbRLmdkAcM6//4LRsNu28Q2EKVCvYRicH13Pbtd328/WkprV6d4fd2yxoF3tEcvv+6AL1HofyTpE8YLi6R99dClnJXCFaHEKI7liykOdK63XhT0g8f7oOj4Q+92yZWDeZtkzAvyODeepzc8jDYFnwuc3VD1yswAiFJUwJhnWFt/Xa8gs0mGCe9BjZ5cB0q9amAVS6bRmvN9zaXrfRO6L+auxpm9Oo8Fm5uJY2wRqaz+VbZm6F+UEyWFOEhg6peE67WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6149.namprd11.prod.outlook.com (2603:10b6:8:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:22:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:22:16 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Auld, Matthew" <matthew.auld@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Topic: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Index: AQHc54sVkWg3vZ8iC0KRpDwXur9Kf7YWnVkAgAAYUlA=
Date: Wed, 20 May 2026 10:22:15 +0000
Message-ID: <DS0PR11MB871852B659D0736A9582D23081012@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
 <20260519122817.45770-15-tejas.upadhyay@intel.com>
 <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
In-Reply-To: <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|DS7PR11MB6149:EE_
x-ms-office365-filtering-correlation-id: be187acd-5884-4aac-dfc6-08deb659aa59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003|4143699003|11063799006;
x-microsoft-antispam-message-info: wVcxQ58Yrh8E3POnXZcZl+wP2ftnKh6m3EHyDmRvHxOHNXp8bzWmg+zyeS6jV6IrZg+bdMRJviR36szcwWrrFEb3RCOCZX4jCFAh6uYmcnGHeO4+v/1bpkwK/W5BYvUF/GPHGuQZuu6C4V82J8/KkHcJu4QcTLs1ZhVyiH0yxWkta10EIi2MA2MtU3qP8RttFl22k3sG3/H36nLxB9Em69zPXnAQf1Ox1nesay1Qlg+Lhc6JXNb8chu2ZzoAfsFDue4uNaWITmfZBz5+CbJzNKsz5OAPAZ6aNULT1R6V+MmIZO1T5MXQm8R7xG/N4BwyjpIRlAFWYwNED0ok4KhaL6xnNbsk8TduSFK4mkeN6IVciQFCAGXFTpJpUHcqjrtDMmUgvPvM/3s3wRvvLgZJP8WtyiwAPQJKvSBsIHZNpUPjzBCZQ/4YT0EA3o8GUHQT5ayiY+DqhtIFvh1PufdEXu1de3Co8Zo7tgsNTRgE1gp3fPduzEHwudZSFMDjJeifLK0VaanqmGajXQ3a7YNJ6iUfG42eC3XWT+S/vdzzPKAcsPFWHqwDqUvKE6y0siN/sfv38oUMAEe6flJE/nMne0EKKtVpTsLMB4Y2cPLvkNL2VI7s/ZYxev4uIBbzecjpsvZZDxYtyO+mu/s8UDpGvla5xEEhQid3FSYjK9OPA4uNEtXkzqS3cutHjDvvrH6npdFxOeoIUpwv8kvRf41xiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVUbzRmL1U1dkk1M1ByazRySWMvR3gzakM2aHpzQU1DaXUrZFNtK3pKR2Y5?=
 =?utf-8?B?ck1oVGh4SWhrcDh4VHYvMThXNVRNTVlKb05MRWxMbkI3S2pPdG9iMnlHdXJH?=
 =?utf-8?B?WVBSNjNWYkkzMEpsVG5JVTBUbmMwZUM5NkdEaHVxRmtXd2NITUp4NmdKMFRi?=
 =?utf-8?B?S2lqVitQN2QxbEM1OTgyc01xM3dCTTlpRm9rZjBvVzRwOThsV2Fib0lRTElC?=
 =?utf-8?B?MDlTVXo0dFBNczIyaXUvSGg1ZWFSSlU3eGVWbVhMU3d6dVVvM2ZWY3ltVU1m?=
 =?utf-8?B?M2RwWTZBRS9PNU5XM1hqaHQ0eTJSVFYyaFl1L2I3L0lxNm1ncGpsRWdlcjhh?=
 =?utf-8?B?ZTZGb0ZlT1pjTGN4dXR1VTJJajZRc29PeGxoRVF1VG9UdVE4NjFUSW1YbXBn?=
 =?utf-8?B?Vk1wR1JIVFJvK3hJRkV2R3UvRlhUcFJTY2J3cTJCYkRYamtYVklGT1dsMmRB?=
 =?utf-8?B?RTJVcXdsYzRZSWFLbmViWE9FY2JXdzhPODdyZVFQaG1JMFE2OE81K3pBN1Rx?=
 =?utf-8?B?L1psUDJtakxQRWlCeDVJTXFDVU0xS1hQQWJiaExCNzBmVlVjWCt4QkYwdUpK?=
 =?utf-8?B?czBVMkxwV3YxNDhldU50Vm0xb1crOHRyc2JVUVBlTStSL2VLWGFJV3YyaTd1?=
 =?utf-8?B?UzNRSWs0NUIrOXcxRkN0cExBMXNKdXhQWEJDRUJVTUQxNENxeFZBcUdUMlQv?=
 =?utf-8?B?UUR2bmttVW5vU0UwL3RMejdxcFhaZDN6NHZvNGFXM3g5eWhWNHZPNjVLNDNO?=
 =?utf-8?B?M21TOEtRejd4U2x4ZjJ3WTlTZFZON1NnVUJmMzd2UHdPTmY0RENoZ3RIdVNq?=
 =?utf-8?B?SFZ1NWNPNGdpMCtxTmZVOHdHRWcvS0k5N1dtbWNFWnUza2EzR1hHY0ZhRzNl?=
 =?utf-8?B?RXdabFhPU0o0aWZSWXVNb1lLVnJmUVNnbzBFdjFBTWVvSGdPc3pnRHRnK25w?=
 =?utf-8?B?OHBmdlp1V0dNclRKMGFqTUtxR3NlQ1hsU203MFJsSGhrYWdLcGhxalpsNUNM?=
 =?utf-8?B?aVhUb2hveVZUeUhLS2p1WXpGMWRJNGxnWnRPc2RIeTJiTTlrN3E1eXl2R25V?=
 =?utf-8?B?SVFoakdnYXpCanh0MUVYQncwT29IdmJVWk51WnpmZ1lTWCtoaXRvbko4TVN4?=
 =?utf-8?B?c2FnWHRpd3N5THFXR29NenllWlQwUlVHZFE2SjdONHRHSzUxRUlmdmVvQ1d6?=
 =?utf-8?B?QkZJbjlxT25sMjNjQnRFbDNhQVpBQ2c5Wkh2Z2VjbURHR2JPNm8yaGozTzhn?=
 =?utf-8?B?ek54R2JJQkVZdE1hTmRReGhsKytaWmw5RzhWc3h0OGVhbmNWNS8yME55ZGRI?=
 =?utf-8?B?VXVxbmJDR3VDYUs0U1N1dDJtdDJ4THd3UUVXOEJmOXlLNUwzZ3oySVZVYTlR?=
 =?utf-8?B?eFdqUWF3c0NKM3R2OUNTUmJ0cmNJU2lBLy9qQmR4TUdRakx5UWptY3FpTlgz?=
 =?utf-8?B?SmhNQS9LSnFDbFBTa2JoeGtDRWVJdXR5WEtFVkxzMEJQMS9sOHJZYVhRMW5X?=
 =?utf-8?B?ZWFKTWlDeWhzdEsyQXV3ZjFUajJRZ2lRV3JQUm9LeHF1YWFYaklRNEdrampO?=
 =?utf-8?B?RDVBK1lqUEFxQjBLZmgvWWRQbFYzSWdJTnBkS1ZIVjhXenllNVpyN3V6RUpl?=
 =?utf-8?B?Smc0aTFDaCt0dEJmTjladVYzNVFCL2tpeG91TUpJcWxkMnE0TUFrNm1kdXlF?=
 =?utf-8?B?V0o2Wm93c2xCTXQ4cXNSVnoyNzhCVnlpVkRrRGlLWFJMZlFreGQvUmhJMGM5?=
 =?utf-8?B?dGxLakg4dEl3QzVEYkQxQy9lSmpGbE9Ya1ErZllUS085MmdnSWt1c3Q0amYz?=
 =?utf-8?B?QlZZZldIV2FBaTYya2pyWjVMZ2c2MXJJV1JLdzNFMGx1aVVLZ1czeFVUOGZE?=
 =?utf-8?B?UmlrRVZqQXphUE0vK2VtTjhLTlFNVWo3d2ZsNXFxQThQNlRSS3JWcCtKZERF?=
 =?utf-8?B?Nkg4b0gxcWpPVUhXRFcwWHA4TlR2V01IMFZ5VCtDdEZ2aEV0L2F4T0l2dXhp?=
 =?utf-8?B?ZlVnZ1U1eng5LzhKVnJnVWNhUzB6dk1MeXEzeTZlTzZaZDhneUdub1hSb0Vm?=
 =?utf-8?B?MlB0elFCMW9YUU5FRnBQdGl4RGpsa0FteUpTSXFFWTBUK1UxSmFvNXljRHp2?=
 =?utf-8?B?bWdUcE42dXpmeElxQnJUbXc5eXYxaURZeC9ET1gyZ1pwN21GS01MSnNXWDkr?=
 =?utf-8?B?a1JFVk1KcXlVaEZQZkd3UWIvR0M2YTRQWDAvN0EzNnFod2J0VHJQZjVkNzRH?=
 =?utf-8?B?NDFaaW9EZklpQVM5R3Z3ako0K2xFdWJnbUoxci9OcnBacStmcjFaWG1nejdx?=
 =?utf-8?B?RGhKL2U2dFpmN0ViSldPOUlIbzJhSkVVamZyc3pGRm0yNHV1clRvaGxnWXpG?=
 =?utf-8?Q?yhqb1Ip2oxxVymmyUzf7XMgyQjAUAZVg1RCx0oCTQtQhd?=
x-ms-exchange-antispam-messagedata-1: WlP3cdzzf5h+HQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F5rt5kQPQ8HaeiIga9V+uRcGcmhBMp4jC/62UgZqF1iM9rxKOZlk+J+mz+flP3YBlIxZoUMhAMXqcyYvquujuD5Gg5JnsN8jUA0Tkcj8M8Mm1bYhs1XLKzdMXKm7NYfeFJ6vghIfOVc33nAwfWvuvjsJ1hnoouOahjngh7HjbGXFAUsHpg/l1+C5WP281P05FV8z5H3XI7kwP7yjGydzubc6lHGo/8Eczuzx824R+XJSVuUGrfEcIT3rWg+TcSmxh2Y+V8mwMN3bzP5s6NPcVrv/EG7Lcbs//9T2OPOwMWDD/JJtydJKCG8vtV9wTvUmA9+7GB4c6+MXXQ23D0Ojng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be187acd-5884-4aac-dfc6-08deb659aa59
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 10:22:15.9501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGH6PzSCPg7kd+n7WsaTFNSfVKR/bOqKs51UR8z06pOg1zIkOjBOhYikYkDsx9AoQI/RciVYw39dzH5j83x0kGUl21ztk2y9argFf6x609o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6149
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ1bnByYXZpbiBQYW5l
ZXIgU2VsdmFtIDxhcnVucHJhdmluLnBhbmVlcnNlbHZhbUBhbWQuY29tPg0KPiBTZW50OiAyMCBN
YXkgMjAyNiAxNDoyNA0KPiBUbzogVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFkaHlheUBpbnRl
bC5jb20+OyBpbnRlbC0NCj4geGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBBdWxkLCBN
YXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPjsgQnJvc3QsIE1hdHRoZXcNCj4gPG1hdHRo
ZXcuYnJvc3RAaW50ZWwuY29tPjsgdGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb207IEdo
aW1pcmF5LA0KPiBIaW1hbCBQcmFzYWQgPGhpbWFsLnByYXNhZC5naGltaXJheUBpbnRlbC5jb20+
OyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIFYxMCAwMy8xMF0gZHJtL2dwdTogQWRkDQo+IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90
b19ibG9jayBoZWxwZXINCj4gDQo+IA0KPiANCj4gT24gNS8xOS8yMDI2IDU6NTggUE0sIFRlamFz
IFVwYWRoeWF5IHdyb3RlOg0KPiA+IEFkZCBoZWxwZXIgd2l0aCBwcmltYXJ5IHB1cnBvc2UgaXMg
dG8gZWZmaWNpZW50bHkgdHJhY2UgYSBzcGVjaWZpYw0KPiA+IHBoeXNpY2FsIG1lbW9yeSBhZGRy
ZXNzIGJhY2sgdG8gaXRzIGNvcnJlc3BvbmRpbmcgVFRNIGJ1ZmZlciBvYmplY3QuDQo+ID4NCj4g
PiB2MjoNCj4gPiAtDQo+ICVzL2dwdV9idWRkeV9hZGRyX3RvX2Jsb2NrL2dwdV9idWRkeV9hbGxv
Y2F0ZWRfYWRkcl90b19ibG9jayhNYXR0QSkNCj4gPiAtIHJlbW92ZSBjbGVhci0+YXZhaWwgYW5k
IHNwbGl0IG5vZGVzIGNoZWNrKE1hdHRBKQ0KPiA+IC0gQWRhcHQgbG9ja2RlcChNYXR0QikNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRlamFzIFVwYWRoeWF5IDx0ZWphcy51cGFkaHlheUBpbnRl
bC5jb20+DQo+ID4gQ2M6IEFydW5wcmF2aW4gUGFuZWVyIFNlbHZhbSA8YXJ1bnByYXZpbi5wYW5l
ZXJzZWx2YW1AYW1kLmNvbT4NCj4gPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvYnVkZHkuYyAgICAgICB8IDUzDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9n
cHVfYnVkZHkuaCB8ICAyICsrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9idWRkeS5jIGIvZHJpdmVycy9n
cHUvYnVkZHkuYyBpbmRleA0KPiA+IGViMTQ1NzM3NjMwNy4uOWRlOTg3MjI5NGE2IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2J1ZGR5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9idWRk
eS5jDQo+ID4gQEAgLTU5NCw2ICs1OTQsNTkgQEAgdm9pZCBncHVfYnVkZHlfZnJlZV9ibG9jayhz
dHJ1Y3QgZ3B1X2J1ZGR5DQo+ICptbSwNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0woZ3B1
X2J1ZGR5X2ZyZWVfYmxvY2spOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBncHVfYnVkZHlfYWxs
b2NhdGVkX2FkZHJfdG9fYmxvY2sgLSBnaXZlbiByZWxhdGl2ZSBhZGRyZXNzIGZpbmQNCj4gPiAr
dGhlIGFsbG9jYXRlZCBibG9jaw0KPiA+ICsgKg0KPiA+ICsgKiBAbW06IEdQVSBidWRkeSBtYW5h
Z2VyDQo+ID4gKyAqIEBhZGRyOiBSZWxhdGl2ZSBhZGRyZXNzDQo+ID4gKyAqDQo+ID4gKyAqIFJl
dHVybnM6DQo+ID4gKyAqIGdwdV9idWRkeV9ibG9jayBvbiBzdWNjZXNzLCBOVUxMIG9yIGVycm9y
IGNvZGUgb24gZmFpbHVyZSAgKi8NCj4gPiArc3RydWN0IGdwdV9idWRkeV9ibG9jayAqZ3B1X2J1
ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKHN0cnVjdA0KPiA+ICtncHVfYnVkZHkgKm1tLCB1
NjQgYWRkcikgew0KPiA+ICsJc3RydWN0IGdwdV9idWRkeV9ibG9jayAqYmxvY2s7DQo+ID4gKwlM
SVNUX0hFQUQoZGZzKTsNCj4gPiArCXU2NCBlbmQ7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4g
KwlncHVfYnVkZHlfZHJpdmVyX2xvY2tfaGVsZChtbSk7DQo+ID4gKw0KPiA+ICsJZW5kID0gYWRk
ciArIFNaXzRLIC0gMTsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBtbS0+bl9yb290czsgKytpKQ0K
PiA+ICsJCWxpc3RfYWRkX3RhaWwoJm1tLT5yb290c1tpXS0+dG1wX2xpbmssICZkZnMpOw0KPiA+
ICsNCj4gPiArCWRvIHsNCj4gPiArCQl1NjQgYmxvY2tfc3RhcnQ7DQo+ID4gKwkJdTY0IGJsb2Nr
X2VuZDsNCj4gPiArDQo+ID4gKwkJYmxvY2sgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJmRm
cywNCj4gPiArCQkJCQkJIHN0cnVjdCBncHVfYnVkZHlfYmxvY2ssDQo+ID4gKwkJCQkJCSB0bXBf
bGluayk7DQo+ID4gKwkJaWYgKCFibG9jaykNCj4gPiArCQkJYnJlYWs7DQo+ID4gKw0KPiA+ICsJ
CWxpc3RfZGVsKCZibG9jay0+dG1wX2xpbmspOw0KPiA+ICsNCj4gPiArCQlibG9ja19zdGFydCA9
IGdwdV9idWRkeV9ibG9ja19vZmZzZXQoYmxvY2spOw0KPiA+ICsJCWJsb2NrX2VuZCA9IGJsb2Nr
X3N0YXJ0ICsgZ3B1X2J1ZGR5X2Jsb2NrX3NpemUobW0sIGJsb2NrKSAtDQo+IDE7DQo+ID4gKw0K
PiA+ICsJCWlmICghb3ZlcmxhcHMoYWRkciwgZW5kLCBibG9ja19zdGFydCwgYmxvY2tfZW5kKSkN
Cj4gPiArCQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCWlmIChncHVfYnVkZHlfYmxvY2tfaXNf
YWxsb2NhdGVkKGJsb2NrKSkNCj4gPiArCQkJcmV0dXJuIGJsb2NrOw0KPiA+ICsJCWVsc2UgaWYg
KGdwdV9idWRkeV9ibG9ja19pc19mcmVlKGJsb2NrKSkNCj4gPiArCQkJcmV0dXJuIE5VTEw7DQo+
ID4gKw0KPiA+ICsJCWxpc3RfYWRkKCZibG9jay0+cmlnaHQtPnRtcF9saW5rLCAmZGZzKTsNCj4g
PiArCQlsaXN0X2FkZCgmYmxvY2stPmxlZnQtPnRtcF9saW5rLCAmZGZzKTsNCj4gPiArCX0gd2hp
bGUgKDEpOw0KPiA+ICsNCj4gPiArCXJldHVybiBFUlJfUFRSKC1FTlhJTyk7DQo+ID4gK30NCj4g
PiArRVhQT1JUX1NZTUJPTChncHVfYnVkZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2spOw0KPiA+
ICsNCj4gPiAgIHN0YXRpYyB2b2lkIF9fZ3B1X2J1ZGR5X2ZyZWVfbGlzdChzdHJ1Y3QgZ3B1X2J1
ZGR5ICptbSwNCj4gPiAgIAkJCQkgIHN0cnVjdCBsaXN0X2hlYWQgKm9iamVjdHMsDQo+ID4gICAJ
CQkJICBib29sIG1hcmtfY2xlYXIsDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZ3B1
X2J1ZGR5LmggYi9pbmNsdWRlL2xpbnV4L2dwdV9idWRkeS5oDQo+ID4gaW5kZXggNzE5NDFhMDM5
NjQ4Li5lN2UyMmZhMDVlZTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9ncHVfYnVk
ZHkuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZ3B1X2J1ZGR5LmgNCj4gPiBAQCAtMjcyLDYg
KzI3Miw4IEBAIHZvaWQgZ3B1X2J1ZGR5X3Jlc2V0X2NsZWFyKHN0cnVjdCBncHVfYnVkZHkNCj4g
Km1tLA0KPiA+IGJvb2wgaXNfY2xlYXIpOw0KPiA+DQo+ID4gICB2b2lkIGdwdV9idWRkeV9mcmVl
X2Jsb2NrKHN0cnVjdCBncHVfYnVkZHkgKm1tLCBzdHJ1Y3QNCj4gPiBncHVfYnVkZHlfYmxvY2sg
KmJsb2NrKTsNCj4gPg0KPiA+ICtzdHJ1Y3QgZ3B1X2J1ZGR5X2Jsb2NrICpncHVfYnVkZHlfYWxs
b2NhdGVkX2FkZHJfdG9fYmxvY2soc3RydWN0DQo+ID4gK2dwdV9idWRkeSAqbW0sIHU2NCBhZGRy
KTsNCj4gQ291bGQgeW91IHBsZWFzZSBjbGFyaWZ5IHdoZXJlIHdlIHBsYW4gdG8gdXNlIHRoaXMg
aGVscGVyIGZ1bmN0aW9uIGluIHRoZSBjb2RlDQo+IHBhdGg/IEkgZG8gbm90IHNlZSBhbnkgY2Fs
bGVycyBhZGRlZCBpbiB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXMuDQoNClN1cmUsIGl0IGlzIGdl
dHRpbmcgY2FsbGVkIGluIEFQSSB4ZV90dG1fdnJhbV9yZXNlcnZlX3BhZ2VfYXRfYWRkcigpIGF0
IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC83MjYyNTIvP3Nlcmllcz0x
NjE0NzMmcmV2PTEwDQoNClRlamFzDQo+IA0KPiBSZWdhcmRzLA0KPiBBcnVuLg0KPiA+ICsNCj4g
PiAgIHZvaWQgZ3B1X2J1ZGR5X2ZyZWVfbGlzdChzdHJ1Y3QgZ3B1X2J1ZGR5ICptbSwNCj4gPiAg
IAkJCSBzdHJ1Y3QgbGlzdF9oZWFkICpvYmplY3RzLA0KPiA+ICAgCQkJIHVuc2lnbmVkIGludCBm
bGFncyk7DQoNCg==
