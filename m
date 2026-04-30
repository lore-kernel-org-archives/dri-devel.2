Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F6FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AB510F2C8;
	Thu, 30 Apr 2026 09:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="alr7LRpN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6916D10F2C3;
 Thu, 30 Apr 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777541657; x=1809077657;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=inVyCOWiU/spsfddpaUa7e7yGR77kYytllZfiB0cKhc=;
 b=alr7LRpNinZYe/fn+d3U0TGKkFBUKuuXeCo+Tf6O2e8Z+/NX8Zdi+t8E
 e+zE0US6e4PouVXNa/0PzbSODESY/LvJUbKprydmiga5oXY3nM13ESWtr
 vjlg20O5UxHGLjRcutDbEtmk+6w5x4wHLx4fvRDNW3WpZn5Dpy9ikEt2B
 zcRbqwatT5MugPK/qC0fhCUHZ+rkBM3XNiDmsvBVNdYre5VOT2dKOvefJ
 BD5qk6PxJI3O3fIdai2cdVG8WT4ru5ofrIfyvxn62DsyMANXmossstSyQ
 jUlnIw1xP+TR0X12hIedBo2W/mvZcDdRQGmYEK8c/fkF+nnidd3h3OC+P w==;
X-CSE-ConnectionGUID: LKdQihi/TgO2UCg8z90R+w==
X-CSE-MsgGUID: Kvr8wCmwSEyiNS73r0Gelg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82352819"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82352819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:34:16 -0700
X-CSE-ConnectionGUID: vE4mYuCzSL6Qs9l/Noj5jA==
X-CSE-MsgGUID: J+8ElXgxSOChVDvC5y2Hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234422610"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:34:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 02:34:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 02:34:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 02:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQacBXUC84UgF9C+E1IjMbXU3JdvNSiaQRZoQ1e1o7Y43KcKbFbdugVFwM7Gc/m3QjjxIDCblmjpUaVUyvuf87fpupglmtc37jDQ09Fzdy9lQT4OqT3uhIhh/sX3OmfXkDaIZIRmTP3xwFskVByZWMeaRnSIHZpw+lENTXDPneUwhnblD7FVzrH1eGDpbce6qI7EH/znmH97e+FrmYBovoLZwuvU0eiXIob4cSXVvOuiLFAwEB53T/EsbO9fBZgxPK0bsHyabhCBs0l5UyGFkXdRxhTu0bAXDmd5nfJ3eRGbroRxmrRvi84ZF/F31Z3GcfJpcx+m+h562D1SLGe6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inVyCOWiU/spsfddpaUa7e7yGR77kYytllZfiB0cKhc=;
 b=UsBshJqnlN9BdvBDDzDQ+kV8al3aFa2u9cWW+vwgFn3ng6Gg9YdZP070Gv86YOSqMtOlRP1UxYWmVi5M6y+7X3ihnNR6W7XtmcMEIz89LQtBzlXuB6mVWwqV53LlnlJ6c/uTUNJHKlkEcsq+eziLF6Xuwe9xOBfBNpe2/j8CKrEIjIDhmgdwQw5n+5Tnru7Brut/CkUOVVWaQZmsskksB+P08IcpbLZ9rIhBDjXSTXXVDTRmYkeb5BTVqCRLtf1R6jGmtwKHbEKpl8XkslMdRb+952K5QOBMV8+/NQaOF3oIYcnpDXsBVoMBKn9G5UE+WXfnQJMldV9MjrgVMx97gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3232.namprd11.prod.outlook.com (2603:10b6:805:be::14)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:34:13 +0000
Received: from SN6PR11MB3232.namprd11.prod.outlook.com
 ([fe80::bf74:5777:8849:5c00]) by SN6PR11MB3232.namprd11.prod.outlook.com
 ([fe80::bf74:5777:8849:5c00%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 09:34:13 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Auld, Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
CC: "Arunpravin.PaneerSelvam@amd.com" <Arunpravin.PaneerSelvam@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
Thread-Topic: [PATCH] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
Thread-Index: AQHc19UBxAjbdwjIT0+T5iBjAqiAT7X3U+WAgAAFTeA=
Date: Thu, 30 Apr 2026 09:34:12 +0000
Message-ID: <SN6PR11MB3232A411D711701F1E7EFB3181352@SN6PR11MB3232.namprd11.prod.outlook.com>
References: <20260429123714.3913374-2-tejas.upadhyay@intel.com>
 <4dea1e78-da81-4c5b-ab8d-62d6f99e4889@intel.com>
In-Reply-To: <4dea1e78-da81-4c5b-ab8d-62d6f99e4889@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3232:EE_|SA1PR11MB6808:EE_
x-ms-office365-filtering-correlation-id: 8a5e77db-cdd0-4f35-a097-08dea69ba3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: aiDm4FEUCg+UMKPiCrNUQ52mHSrFxR3DTMaSI+XWLN0HTGgGA731Bi1q9aJ53nuoULNxWVkbr1tOqykLoxThCjfBA5LlxJ4h4A5R9owGXjv8eOr7CKgVOwoDzNC0VrVdGOPlPXKO2omxSGIyIn1omehBfAH0yFU2LnPEhbxh0uDsnNaANmesLPiVApKCAZR534AB9XUkBGpSbssZd4lyhUuNrjMvJPcRH+fkmInsQFoKB/78ZbjcwrR+XmXofRfKbXAJfFnTeX474xZBM4jV2Uil+/6AMBIk6t4e2FhEKalvkxZzEdNqnNgvmr5aBLy3wlDrts3aQ0M/JcaxnpH/o6jJJ0fN9Id9TXvQVzp2q6zsimP8LJ/PttaebTcWVFjLhHFTuyap4L0ZLdvQEH82RAKYINeftVSpYOKANJZdzWji8T/Um5Kw0ukciqByEDRzb+wvVlZGnWXZcPFRD8otexOQNnCoK0mJV/cGTZFt3ya0Bhwxjxp+Gnm0dl9i+bCZEzIxiP+qYzQNswJ03/Wl9UXiaLYpIdCli03FQ23nyFKU4g+fJjS0U7LrbepShyYwhXzoHT53+SF4wJibWVzVinQIOfnQtBnxruQZefgp3f6493eC/Q3FG7rOATPGonOeWHAjc5P95mFEe1k3XgqevtZzyDcc/DdGoIDyHNZxlHp7j0YFmBcgEI3vG6SES225WZcAKPF7iC8N34SQJFLSsPUEajmw6rLhCOFrNeD2hRCAJHO2EhDPRjXXSIfp6fEqJemxm2Syfs5/PhH1jK+tRA1LgJNwoc6VtLFiYpBl0kM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB3232.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFRBQzFqQW9IeERua0h0cmlTWFFUNDI4ZW96SVNTSUNZbVdjdTZFenVJaERz?=
 =?utf-8?B?RjdMM3BsMHNpVXhubWFneUpKZHRzYS9YL0VmelFsZFNzdmg4c3lKMGlFRDdL?=
 =?utf-8?B?K2Y2SGNSY2FuNGRTL2dMRkxiMHl0a2ErMnNRS1lBSjdCaTRhR04yU0hwTG1x?=
 =?utf-8?B?NFM5RHR1U1ZJYzEvNFVRbW81ZkhwR0Njc0lPRjlCZmNzTmZzclJ6UmJiYVBv?=
 =?utf-8?B?bUgxU3d2ZlRkbnZUU3oyUTFzOW01NmNvUU9CU3lmbU1nM041YjRKRHVFbHMr?=
 =?utf-8?B?T3c2cGlyWGRpZ25PYjF3cTNlMEt4Y0hWY0xvbStkUVlRMzEvK25LM25JNk0z?=
 =?utf-8?B?Z2kxQW1xU0t6aFJGYVNSNUVnZ3VPTFJTZVlHZ3k5VlhNL1JhZkEzMHl5TitQ?=
 =?utf-8?B?QUcrRnJCZlVMakczZkhJbXNSa0xQRFc4OWdBczFHZ3NySlN2YmVLZmJSaE5x?=
 =?utf-8?B?ZnJKVjRFbVVDa2kxK0xMRDRQdXpYcmNrUHlqaENTUmlFM0JTU29HOTRrRGRB?=
 =?utf-8?B?WW5jMFlvQWR4TXF0V0RnQUdHNVFwRm9FZHRqNUdvbHFUUTRQQUhyTGI3VTJp?=
 =?utf-8?B?cXc1bWRxN1YzTlVMdG5NMjYyLzNIM2Jib3Zlek8vd2xhd1lVTmRHNDVBMXor?=
 =?utf-8?B?WmZnYW1XY0RwUFo3Z0Qwcy9FVktNSHBIWjJQMWxLRGJJZ1pFNzM4UWNJNjgw?=
 =?utf-8?B?UVNVbVBZYzU0VVZscklJTGovby9CSi94SXVJNkF1YnBxMkhSZXlCMFFVMUMy?=
 =?utf-8?B?VStOaUVneDhibks4WWNsTlJOUW5DQS9jODlDVkoxeTRFVW9mSkFKcWwvR1p1?=
 =?utf-8?B?MlFENXN5bTJHZmpTdzhaaythM3ovNVZqWkMwTmlnMit3d2RTa2dpRHJKdkhv?=
 =?utf-8?B?ZThKcm91eC9DTGszRmVRaFNQVkdiRzE1U2MxUldXQzFNQ0Z3RkY3YzFDTlF6?=
 =?utf-8?B?S0F5RTRvM0JER28va2JUMnBJUm1uVkh4M2xjYVhwL0pUdURIYzNJYjNYa00w?=
 =?utf-8?B?UkJpdDBZaDhCanE5U01WS045cGF3Q2xFZ1RuWEU0MUMzQXZGL0QzNHFJYTFi?=
 =?utf-8?B?eEhaQnRadTB2SkZqQ25tQnVNMGZROGp4VEYvczBWcTQvSHc1dXIwT1lSeDZK?=
 =?utf-8?B?ZEhLUUNCb09pSStZZFNQZ1BwSTd4NEJ3a1hTcWtvYmZEZlFubmVCUzVVbGZr?=
 =?utf-8?B?L2pySExZVnRsdTVXV3hYakQrdUY3c2tMTzgvV0gwQjJ1a0FWSFFtNjlzVmgw?=
 =?utf-8?B?T01uNkRBU0JkT0txbEt6QVc0NmxVd051MDcyNG52c2lJaGtrWlNZNXJMTWR1?=
 =?utf-8?B?YWtDdnJvYTEzL3BYSVllR3BvdE90anBYOXpzYTg4dzFQNzZBTUpjbTU2MFps?=
 =?utf-8?B?WEhiSkNxY2sxK1poWFNuL3hQcW9GRVE3ampYdm5FVmpuL2RYWUZHd2dFMEZt?=
 =?utf-8?B?R0xZTXRCZW9jbVlvYjlGWUFYVWhTVnZNN05icnRjSHVUNi91RWsvN1BobGVz?=
 =?utf-8?B?cTNWYVE1eklJUURoOFoxQlhtYk1lVXh2b0VCcVZ1R0ZiQWZ6SXBkcDJKMURn?=
 =?utf-8?B?YVJ2ZitTbzBrUEo1bkJiaXlqS0ZUZmsveG9IbTY0Z3RMQm1NWVl5TVNGNThx?=
 =?utf-8?B?Mk1vWEU2NUx4Yy9ySHVmRXZIdGRXR29QWktNU01vamhHTUJ6cElVakpkQzVi?=
 =?utf-8?B?bmNLYU5wLzNHMUN5SzA3cU9oekYrWVZrbDJRdHRJMWltWFpsb3ppS20xNHJm?=
 =?utf-8?B?djhmYURZTXJMOEpHQ2E0ZGhRTU0rT2Fuczl3NjBCYk9Sakw5bHhQNDZSRGZr?=
 =?utf-8?B?ODR1TEpqTWorY2xWdzE2MFRGUHUyRmpZSndDZXp4ejVSYUFWNjEyRStxczlM?=
 =?utf-8?B?dnBaUDJoSjVJdW5qb2pJemc2ZURlTGd1emNUL25CeXAzZk9uZ3Y5LyswOVpH?=
 =?utf-8?B?NUVWRmhIT25BdC9hU2J2OC9WYXcvUGxCV3V4OVRwV0RqZ0V5SGgzS3FVendH?=
 =?utf-8?B?dDgrTFp4eWs1WU9OKytxazdrVE5YWGs5Rjd4MmxFZzg0Nm9pYklWMnp0WFRy?=
 =?utf-8?B?UlUxRWJkWTIreWhDeXdwZDZUazVEd1QyV2xjdjJPWENwRGYrc0VuVDkwRWJ1?=
 =?utf-8?B?UWZSVStxYkJHT3czNlpZTnh3SE9IV3NUSloxSDJSeVRaWW1mc3VYOE5XeUpn?=
 =?utf-8?B?VjJ3Y3haK2tFbTBBWGRDQjFnTmhjbytvOTNwM1hiSTRaOUppRmx3Y01zbld1?=
 =?utf-8?B?bDlWSDh3RGFXeDd3elB4eGdaazM2Rk9rVWh5QjRFZFM5OU1OU1R0bm1pWFJS?=
 =?utf-8?B?T1VIY0RKTmNKUGh0TkVkaGlZQzZFQlhqY1RkVmRqazR6QndJRGRyS1JxRU1v?=
 =?utf-8?Q?0z8JdIIiYJ7ceCuUT+rL7SkwD44+g8ZMGFh37gnDNKmFh?=
x-ms-exchange-antispam-messagedata-1: 0TmynLd6PRflLg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Iu82S81XsmIeZMStJT06Ml0kVEOTEyZ8n/A1nTxRSISVffurSKNR93uXY2Gb5xGEfhBRKwHkNtICoLFTDtyxcpI8PvwA5zoogtH5g5U1CSNmH8YSxpLnAmN3cEQqXZb3l4KFmKV6W3vhoP/odiljKy72qXl3EdqGntN8Sio8lzRgYDg8uO2ECqrIxVYtwmEcq/u6XsOSgdffm1aO/ygl8fy1qQcrQzphsppIaP05kkoadnkjMdiR/9zRZvLU6sSld8OK1RjgPSFewX+0+L+d7ZBnKYaXZc+RqEOO0J9nwLblz5MoUmFAzkkp9VzlDP+SiddNu0uyAYxaIa33sPCS8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5e77db-cdd0-4f35-a097-08dea69ba3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 09:34:12.9605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAcXV3xmyC1Bvyh8/yop1tGwTYCzKEPtyACBNv/x+iCYjLR28T04Qe5eJcPJdJ5bxpqDgl4iUecKEugjPYL228BKpE+i759x6EphktgaNE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXVsZCwgTWF0dGhldyA8
bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2VudDogMzAgQXByaWwgMjAyNiAxNDo0NQ0KPiBU
bzogVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFkaHlheUBpbnRlbC5jb20+OyBpbnRlbC0NCj4g
eGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBBcnVucHJhdmluLlBhbmVlclNlbHZhbUBh
bWQuY29tOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYnVkZHk6IEludGVn
cmF0ZSBsb2NrZGVwIGFubm90YXRpb25zIGZvciBncHUNCj4gYnVkZHkgbWFuYWdlcg0KPiANCj4g
T24gMjkvMDQvMjAyNiAxMzozNywgVGVqYXMgVXBhZGh5YXkgd3JvdGU6DQo+ID4gZ3B1X2J1ZGR5
IEFQSXMgYXJlIGV4cGVjdGVkIHRvIGJlIGNhbGxlZCB3aXRoIHRoZSBkcml2ZXItcHJvdmlkZWQg
bG9jaw0KPiA+IGhlbGQsIGJ1dCB0aGVyZSBpcyBubyBydW50aW1lIGVuZm9yY2VtZW50IG9mIHRo
aXMgY29udHJhY3QuIEFkZA0KPiA+IGxvY2tkZXAgYW5ub3RhdGlvbnMgdG8gY2F0Y2ggbG9ja2lu
ZyB2aW9sYXRpb25zIGVhcmx5Lg0KPiA+DQo+ID4gSW50cm9kdWNlIGdwdV9idWRkeV9kcml2ZXJf
c2V0X2xvY2soKSBmb3IgdGhlIGRyaXZlciB0byByZWdpc3RlciB0aGUNCj4gPiBsb2NrIHRoYXQg
cHJvdGVjdHMgdGhlIGJ1ZGR5IG1hbmFnZXIuIEFkZCBncHVfYnVkZHlfZHJpdmVyX2xvY2tfaGVs
ZCgpDQo+ID4gYXNzZXJ0aW9ucyB0byBhbGwgZXhwb3J0ZWQgZ3B1X2J1ZGR5IGFuZCBkcm1fYnVk
ZHkgQVBJcyB0aGF0DQo+ID4gYWNjZXNzL21vZGlmeSB0aGUgbWFuYWdlciBzdGF0ZS4gVGhlIGxv
Y2tfZGVwX21hcCBmaWVsZCBpcyBvbmx5DQo+ID4gY29tcGlsZWQgaW4gd2hlbiBDT05GSUdfTE9D
S0RFUCBpcyBlbmFibGVkLCBhZGRpbmcgemVybyBvdmVyaGVhZCB0bw0KPiA+IHByb2R1Y3Rpb24g
YnVpbGRzLg0KPiA+DQo+ID4gV2lyZSB1cCB4ZV90dG1fdnJhbV9tZ3IgdG8gcmVnaXN0ZXIgaXRz
IG11dGV4IHdpdGggdGhlIGJ1ZGR5IG1hbmFnZXINCj4gPiBhZnRlciBpbml0aWFsaXphdGlvbi4N
Cj4gPg0KPiA+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC42DQo+IA0KPiBJIHRo
aW5rIGFkZDoNCj4gDQo+IFN1Z2dlc3RlZC1ieTogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9z
dEBpbnRlbC5jb20+DQoNClN1cmUgdGhhbmtzIGZvciByZXZpZXcsIHdpbGwgYWRkLg0KDQpUZWph
cw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlA
aW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxk
QGludGVsLmNvbT4NCg==
