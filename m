Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE401C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A7810E043;
	Tue,  7 Jul 2026 06:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fPwUAqaJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6BE10E043
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 06:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783404998; x=1814940998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RE0U6nobkHMu3O83SifHjuXzuIPQEIfRIEzzJ8VLtH0=;
 b=fPwUAqaJCRg/Xl7cps5yC0kXFILhvCfVJpNlUYsVMKDeLmoDtFi//hB9
 cByRMODy2i4gpk/DRt0gAyzEsgfaYu/YMAaEsDHte9i4FLTY23Cfvx39C
 6ZktK1FYu674JwsFinZYsvZrklpIRHhY/W3RIHPLToSn213UKwvrTnfQ6
 awtDTOtFbMSYepsDf2mDBtlZlz64ZpNSB96hwiHZ4+m/zPHlsk+FKK3D0
 HeLGQSRV6kjD9v+W2tdRvC3t6xjNELIGW2U+r53YFauoSp8uFQx8NnAvl
 hmmgwm8PDVZe/BAZS9+3tHxKSjz33AOmdFKo1IMyeRRecMNLc0rii4qxj Q==;
X-CSE-ConnectionGUID: 0ARsjziSSOCReyCYexqvlg==
X-CSE-MsgGUID: BF2nVZSHS269VaZOLWqhHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84135328"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84135328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 23:16:37 -0700
X-CSE-ConnectionGUID: /+Fg5i0ATG678neXAQr4dw==
X-CSE-MsgGUID: ZDRw+IPCSX6NsqHUz4Dc4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="252160977"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 23:16:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:16:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 23:16:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpZXQbWXXAdZaDXSlL6QTF9/q+uJCrtvTYo8gGKpMF2lWlm2YkF6WUL+bpbTRH78o+0CUomokOkRtDUPZhGpEyCYR4cjKwMEiIUqLYFZfTZ9AdrL4KViePBfkVqe0mmcxdoiPsTXGKbnGrkFPGWVeqS6Pz4CXCEtthPi8L4rnfnYFmBf4zU3aSBt65L2K5h7XNhNj2Em9QVXRXkN8KOyN4oq1fWJ2QR9y+TUrxLo8KL3USZvrvNFJDFQLYrkoXbfomtkPi90hPgeahMaFiKzCcjJQBc1KQCokMsBBiNSNHJonsTlWjhr17/lbH+GMKUVCNp0mufEoeucXuII0rouOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE0U6nobkHMu3O83SifHjuXzuIPQEIfRIEzzJ8VLtH0=;
 b=fu8Zd7XNowgbyUw2Y4U/tM7nqg0EIm6NltVascd4nOqpTID2k0ILb6w6Xb87rzYZu77v8X2OsbF17sXAGwxGh0nV48Zv6BqsxguzNeB7mnGBbfGF+AtBnJ3KEn4Y6So8KBQIjGMQxGf/5OjV7QpCs41sprVQ61y3jxuxgkiU9RTpvSjEgKz+R98tkZnvgVrH8KwwI/WYekiox+SnZTVX5wIXvvQFNOx+LTsJOsTm+t4XGx+UPOyQ+eSpi0ao/+63eyVtGQq5+tPtKAjEBaNZLKws6Fjh+zvSxHjZ8089a8wVzmwu47oQ5KlikDNxxkQeVf7tPC03dIJE7BhtVi0P6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DSWPR11MB9740.namprd11.prod.outlook.com (2603:10b6:8:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:16:29 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 06:16:28 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <christian.koenig@amd.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
Thread-Topic: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
Thread-Index: AQHdBiPkMKsKSbqE3kGKFxz4AuYPGrZSPxQAgAMg2QCAAA5PgIAAAo4AgAZHdACABVWQsA==
Date: Tue, 7 Jul 2026 06:16:28 +0000
Message-ID: <IA0PR11MB71853CC1CC0D0C778DAC154BF8F02@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
 <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
 <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
 <0a444d8c-6107-4577-bed3-0039333a5244@collabora.com>
 <9fa5e38c-0200-4724-b5db-739ea67c1181@collabora.com>
In-Reply-To: <9fa5e38c-0200-4724-b5db-739ea67c1181@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DSWPR11MB9740:EE_
x-ms-office365-filtering-correlation-id: 3182f2a1-d6eb-4aff-4326-08dedbef4834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|11063799006|56012099006|4143699003|5023799004;
x-microsoft-antispam-message-info: hk4gZTUIvHUkipyUIUT1JVdK4N0U7sehTaNUKWHXqQSFNfYsKi4FBJuksAsKchNwEqeFjp4ZhMkSv7QQccBqWERBrxw+Y4Sj4vjVtTfZgJsKvVckqITMLzor7AeeuZOwlnvuxayJGDFb1y8YQHDHKTheQK1A+qT8sl6eBLUcVt5Vc0llkpYQacKD2Sjxt/mKxKlwt4oikQ1V7Pvhz+dpdlXNvuS9tcbi1i3CW6sqb1X8pKGkyjLQmVFr0tgQPNjtKMjmTUO0q5nL1u3GF/YLgDigGRMYDLoAiIOMtjK0ij3c5Vbw2hVLH278noFbCD9mqmKhvlPvufzI73D25O/WanOFjx1Vtd1qcALwKPtj6wNKHBXLGY3qdqOZpcS1RpbaOcRRXns8aDJAIVf+2kp2G2JZGf3eM1Cx1qi1y/oIRaNlFNcYNMvFwdDrIPzvVSTt10DTFyf9AzI/FkB2Kixg0ifrPyyr6wZHAb/VHccr6mlPq7WHxdgevLauZV89TjYy254wrg6RdJDTC+d+nv83HuIsR+4Z8/oIA7Z9jgZYUyskzGOvs2CWMOF7sUoWuji71nnrOW3SnLgNlMQMnmr4mjJ2hOrCMfNKLoXU+5szxHu9KIs3ay90AL85kwcgoXDKGRWlQKqc88xOf4gTqaO8D6oQvZDEvi2rcPTIsKpzTPz3Y7YAV1W8btzpj9/gU2VAgqNCvm18FuL4pZWWHE58BrXWU9bAKe2ywbHskFF6rFk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjl1TG5RVytGTG9BYnliWURZRGN5cEdPdDh5eThqUW5lOW5laHRGTEY4NGdZ?=
 =?utf-8?B?bjQyMzdhcXRiYURaa3ZLVUlFd0ZXeXU5VVB2MHdoQkIwWEJOeVRLZG80eHZ0?=
 =?utf-8?B?S3Y1RGtNRk9aR1d6cXJiSmFFc0hCSnpNTU4vbEtBSHNlS3JuNEdPV3BFd0U5?=
 =?utf-8?B?cXJ4YXovNDdKZXNDMFV2OTlZbktadVhQMjRDOUQwSjIyc09Zak5iVDhOaDcv?=
 =?utf-8?B?NzRDbU0wMVlsNDVGeWJvU2ZkYWxrajdDY09jcVFuQ3p6bVRrblpGZ25WK1lR?=
 =?utf-8?B?QWRZQU5DVDhnRFJjK1dsQmhuTzVmamRrdnFSdXVGUWRDMW1JMDdQSWhvY3hJ?=
 =?utf-8?B?TnZMOGk5Mlc3WjRvOHBlbkl1WUFGV1ZsYzV4ellCS3ZaWTZtZ1MzQ0FVc3dV?=
 =?utf-8?B?ZGVvOUh6TnV1TmRUTE9vM1lLYVdtMFVtYUw1LzRmcE83NFRtUkI0a2Q3Ymkv?=
 =?utf-8?B?TTBLTEdGSGM3bndwV05GUDh1ZndiUXBZa2tESlkrTVBzbFN3OG1HSlpUSDk2?=
 =?utf-8?B?dG1VZVh1bTVJQllIQXRvdHlONkJibFIwMHNhbGZVb1NlV1ZhbDc0UjhYbXZk?=
 =?utf-8?B?U0xzbEZRdjF1eUxsYm4za2VtM3Exd2prOHhTMXFOcjN5R284c05IWEUxNmFv?=
 =?utf-8?B?c0hIcEFyWW5oOWM2RVozVUkvNlNOZUNOclZVMk9EMUZzTlV5VVJUZmR1VDJl?=
 =?utf-8?B?aWIvMzdzNS9jdFh4ZTlUWk5ObnA5RFVkZVNlU0FXa1NKdmhHMEtSRndzVU9L?=
 =?utf-8?B?Z0tmM3FwK1p5SStSZlBVRVJpZjNjZGI4Z2x4N3hWNCtGejJoZytVT1Z1cEg3?=
 =?utf-8?B?V2E0VnFDcGZYcmVGL3JIbjVoYWc5L1I2ci8zUGlnY1doc1BDeFVHL1VQM0hY?=
 =?utf-8?B?QldkSURYMHRmQU5aSnZscXFsNTNTVzVJc21jOWxPMzcxZFdtak9QVFBERDNK?=
 =?utf-8?B?aTEyak5pdXZpMVU0YmF2NHhZcTlQbVAyOUZuSzRTQ2JUNmtZd3hhd3Fvb01o?=
 =?utf-8?B?QzhTSllPU3BCWHBYR0lNcGU3d0djREhiU3dIekQybG1Od1FLVGxiR0oyczAv?=
 =?utf-8?B?dzUvK1lKMCtzZ3FaOXV1bWVadlZBbDJCVFFTdzlMeGliV0ZvckZJNDloNUo2?=
 =?utf-8?B?S2IvRFYrK1d6bnlOT1pib1lFdTI3c1hObWZaQmxBaUwxZE5aUnIySjJSOEdj?=
 =?utf-8?B?UlJneFU2eFNVT1hxcnY3bzh1a0xNaXkrWHU2NWFSSzV1bzJCejZUaGV4d2hH?=
 =?utf-8?B?U2lmRlJYSjZKZWxscUt5S3I3V3ZhTml1WW1HQkt5bE92dnB3T1NyKzZNK2VB?=
 =?utf-8?B?QllHN0p5SVRodkpMak00MVdLZ1hSNmRCcnh2cWxEaTg2MnJ6YWxIU25Bak9X?=
 =?utf-8?B?YlovczhpSVM2RStWZzJvYmRURHl5Rmtlb3p4ZGxKRWhLUXZpTE5VRFZDWEZx?=
 =?utf-8?B?U0k5SEtvb3g1Z0wyVHFPQkY4NzB5UXo2c29lQTRBd2dKM2xCVlRXUUZnRUZo?=
 =?utf-8?B?MklzY3FZTUxFM2xwcSszN2FoSGFUc20xODZpQXQ1dXp3NE9QaUFTUjNhNlpm?=
 =?utf-8?B?VlZPb0hpYmRkSFZ5Sm0yRmNTRUREelZyN3k5aUNBM04wVGtqcU5HSzlvd0NW?=
 =?utf-8?B?RFU0UmFuWmE4OUZzeksyZFRVR2VOYVZPWEM5elBrUHdXVElVbXRhNlBXb0c4?=
 =?utf-8?B?YTB3ZHBzR2g0OVJRVmNRU0F0T2tpQy80L1lpcFNrUXRuZ1crTy9CRUNQdjFh?=
 =?utf-8?B?L25zVzd6bXdpcERuV0s3bWxoemJubjdZUlc3d3psOHV5OEhQVjcwUGVMd2lW?=
 =?utf-8?B?NEJXSkxidThUREFrUVZTMDZDMExzNGFRai80ZkMrbmNrTVh2NlRHQzRuT2h1?=
 =?utf-8?B?THBlb29jNHI0NlZ6V1dsOHg2dUM3TjI2aUxidnB3THV2cDlRcFc4b3ZRT09X?=
 =?utf-8?B?dVZHSHZJY2JySDhiU0RQWGxUL1RoNUY5Z01HTXhnVFRiN3ZHM2tocXNoTWcx?=
 =?utf-8?B?ZExYUHdvb2UrYXkzM0JtQk5wOC9XRFJPamVQZGRIZ0hWWUd3Tjl6b2l0QnVv?=
 =?utf-8?B?b0VmTTYrQVdLT3VUZ0M1dXI4REwrNjl4OXUvQzY5SEVGc1Q3ZEM2QS9ENkdZ?=
 =?utf-8?B?OUYyZmh5TkM2M00zSXNCbmxrQ0QxaVJtUXg0QXNjWU9OT0w1NWxNK3ZFOXpE?=
 =?utf-8?B?ejFCeG1GTHB5RnZhZmQrU0Mvb2UzQW5zZlIxNWVsUHE2cDZ4T3l5OFJXYVpW?=
 =?utf-8?B?QytqRkhGWGFWVDNVQzdZYVg0N0dXTklNc01sVFVHRFJXVXdSdDN6OG13VXhU?=
 =?utf-8?B?dDhQTkU1NE1hcFd3UUFmRDhDQ3g0Y3F3OWp1TTgzZ0pxSEJ4bkthQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dp/lAEPFL662+uClROQkhzDU81UuSt5+pqsc1JoVVpZpXiE1eqxheMOgTkoq5O9ddBYhE6J3+dW1MVQfJBb1l5CLNYLorgIH70ED69RizToEEpujySU8CC0zY54oVObfiR7XR3++f8rYXbUSex3q1N3sxFWXyIjbiI/QoaXOtm3D872JYR6GAwD79cdsHogzNyhAoUCxbODHc9xd90uRPwtJbS9WXemyKYi86/9WUsnWOjYo+4AzNR0uBqjCgnsvX+g+yeROzbR+ZYwK7OFiUgx1ktryLth0A5JkrxluuX5iCZTx7HX8eAgsszI0J6z/js8D2ey+cEQ12ty9zsUKhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182f2a1-d6eb-4aff-4326-08dedbef4834
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:16:28.7822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ruxme7zYrkcEAhx3uku+XWlXpjzOS9OhNFO99zpadZGoHwwDDsu4gbInrZB9dD235XA3d+3xHKJLdP02aI+NMku8qjLLPetTgf8RpkcRzak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9740
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSB1ZG1hYnVmOiBFbnN1cmUgdG8gcGVyZm9ybSBjYWNo
ZQ0KPiBzeW5jaHJvbmlzYXRpb24gaW4gYmVnaW5fY3B1X3VkbWFidWYoKQ0KPiANCj4gSGksIHNv
cnJ5IGZvciB0aGUgbm9pc2UgLSBhZGRpbmcgbW9yZSB1ZG1hYnVmIG1haW50YWluZXJzIGluIGNh
c2UgVml2ZWsNCj4gZG9lc24ndCBoYXZlIHRpbWUgdG8gbG9vayBpbnRvIGl0IGF0bSwganVzdCB0
byBlbnN1cmUgcGVvcGxlIGFyZSBhd2FyZS4NCj4gDQo+IEdlcmQsIFN1bWl0LCBDaHJpc3RpYW46
IHRoaXMgaXMgYSBzaW1wbGUgZml4IGZvciBhIG1pbm9yIHJlZ3Jlc3Npb24gaW4NCj4gdGhlIHVw
Y29taW5nIDcuMiByZWxlYXNlIC0gaXQgd291bGQgdGhlcmVmb3IgYmUgZ3JlYXQgaWYgYW55b25l
IGNvdWxkDQo+IHBpY2sgaXQgdG8gdGhlIGZpeGVzIGJyYW5jaCA6KQ0KSGkgUm9iZXJ0LA0KDQpZ
b3VyIHBhdGNoIExHVE0uIElmIG5vIG9uZSBlbHNlIHBpY2tzIGl0IHVwIHNvb24sIEknbGwgcHVz
aCBpdCB0byBkcm0tbWlzYy1maXhlcyBpbiB0aGUNCm5leHQgZmV3IGRheXMuDQoNClRoYW5rcywN
ClZpdmVrDQoNCj4gDQo+IFRoYW5rcyBhbmQgYmVzdCByZWdhcmRzLA0KPiANCj4gUm9iZXJ0DQo+
IA0KPiBPbiAyOS4wNi4yNiAxMzo1OCwgUm9iZXJ0IE1hZGVyIHdyb3RlOg0KPiA+IE9uIDI5LjA2
LjI2IDEzOjQ4LCBNaWtoYWlsIEdhdnJpbG92IHdyb3RlOg0KPiA+PiBPbiBNb24sIEp1biAyOSwg
MjAyNiBhdCAzOjU34oCvUE0gUm9iZXJ0IE1hZGVyDQo+ID4+IDxyb2JlcnQubWFkZXJAY29sbGFi
b3JhLmNvbT4gd3JvdGU6DQo+ID4+PiBIaSBNaWtoYWlsLA0KPiA+Pj4NCj4gPj4+IHRoYW5rcyBm
b3IgdGhlIHF1aWNrIHJldmlldyEgQW5kIG5vIHdvcnJpZXMsIEkgd2FzIHZlcnkgaGFwcHkgYWJv
dXQNCj4gPj4+IHlvdXINCj4gPj4+IHBhdGNoLCB3aGljaCBpcyB3aHkgSSBsb29rZWQgZGVlcGVy
IGludG8gaXQgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiA+Pj4NCj4gPj4+IEdpdmVuIHRoZSBwYXRj
aCBmaXhlcyBhIG5ld2x5IGludHJvZHVjZWQgcmVncmVzc2lvbiAoYW5kIGlzIHZlcnkNCj4gPj4+
IHNpbXBsZSksIGRvIHlvdSB0aGluayB0aGVyZSdzIGEgY2hhbmNlIHRvIHN0aWxsIGdldCBpdCBp
bnRvIDcuMSAtIG9yDQo+ID4+PiB3b3VsZCBpdCBuZWVkIHRvIGdvIHZpYSB0aGUgdXN1YWwgNy4y
LzcuMyByZWxlYXNlIHNjaGVkdWxlICsNCj4gYmFja3BvcnQ/DQo+ID4+IEhpIFJvYmVydCwNCj4g
Pj4NCj4gPj4gVGhlIHRpbWluZyBkZXBlbmRzIG9uIFZpdmVrIGFuZCB0aGUgZHJtLW1pc2MgbWFp
bnRhaW5lcnMsIG5vdCBtZSwNCj4gPj4gYnV0IGhlcmUncyB0aGUgc2l0dWF0aW9uIGFzIEkgdW5k
ZXJzdGFuZCBpdDoNCj4gPj4NCj4gPj4gVGhlIG9yaWdpbmFsIGNvbW1pdCA1MDRlMmI0YWI5N2Eg
b25seSBsYW5kZWQgaW4gNy4yIChpdCB3ZW50IGludG8NCj4gPj4gZHJtLW1pc2MtbmV4dCwgbm90
IGRybS1taXNjLWZpeGVzKS4gU28gNy4xIHdhcyBuZXZlciBhZmZlY3RlZCBieQ0KPiA+PiB0aGUg
cmVncmVzc2lvbiAtLSB0aGVyZSdzIG5vdGhpbmcgdG8gZml4IHRoZXJlLg0KPiA+Pg0KPiA+PiBG
b3IgNy4yOiBzaW5jZSB5b3VyIHBhdGNoIGZpeGVzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGlu
IHRoZSBzYW1lDQo+ID4+IGN5Y2xlLCBpdCB3b3VsZCBpZGVhbGx5IGdvIHRocm91Z2ggZHJtLW1p
c2MtZml4ZXMgdG8gbGFuZCBpbiA3LjINCj4gPj4gYmVmb3JlIHJlbGVhc2UsIGF2b2lkaW5nIGEg
YnJva2VuIGNvbW1pdCBpbiB0aGUgZmluYWwgdHJlZS4gVGhhdCdzDQo+ID4+IHRoZSBjbGVhbmVz
dCBvdXRjb21lLg0KPiA+Pg0KPiA+PiBBZGRpbmcgVml2ZWsgLS0gaGUgcHVzaGVkIHRoZSBvcmln
aW5hbCBwYXRjaCBhbmQgd291bGQga25vdw0KPiB3aGV0aGVyDQo+ID4+IGRybS1taXNjLWZpeGVz
IGlzIHRoZSByaWdodCByb3V0ZSBhdCB0aGlzIHBvaW50IGluIHRoZSBjeWNsZS4NCj4gPiBIaSBN
aWtoYWlsLCBJIG9mIGNvdXJzZSBtZWFudCA3LjIsIG5vdCA3LjEsIHNvcnJ5ISBBbmQgYWdyZWVk
LCB0aGF0DQo+ID4gd291bGQgYmUgaWRlYWwgLyBwZXJmZWN0Lg0KPiA+DQo+IC0tDQo+IFJvYmVy
dCBNYWRlcg0KPiBDb25zdWx0YW50IFNvZnR3YXJlIERldmVsb3Blcg0KPiANCj4gQ29sbGFib3Jh
IEx0ZC4NCj4gUGxhdGludW0gQnVpbGRpbmcsIFN0IEpvaG4ncyBJbm5vdmF0aW9uIFBhcmssIENh
bWJyaWRnZSBDQjQgMERTLCBVSw0KPiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcywgbm8u
IDU1MTM3MTgNCg0K
