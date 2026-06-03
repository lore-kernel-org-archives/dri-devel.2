Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD99CD6E6A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD7E10FAE2;
	Wed,  3 Jun 2026 08:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hl7c6ihm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A177B10FAA9;
 Wed,  3 Jun 2026 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780476793; x=1812012793;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ALx7D1ebDBCen3tAhVOQg8vn6+pGo+Xg+QCes5oToIw=;
 b=Hl7c6ihmiy5U3d+hmrLW6k7q8GIQ7Fn8rdfhNPeNK/F3hm1uAUP1mV/V
 4Lcej9fBfN7eZ+6eKMnfxDJONL7NgwTni9xsuzhu4ceMMYJ49m0d2Tq1x
 bgGVaBKikTBCM9HMOwFUHX0vf76oto/bf9itXg4dL2dUcHHaCpPva+RRu
 hhYbeGq2tk8oXbnd7TH1jjXOf0YWvNY9QrL7IvkhjheepvOko/d8KIq5H
 2BBcnsiVPraefbZ1pgKug55S4wXR2W/oX/+akVkjRoo9g64iE0HGQG/eW
 9wfbnAWkZr0etdzkHeIXTjucRVB09YIFE/5MRWEK+KU/YzNfnRMrDxWQQ Q==;
X-CSE-ConnectionGUID: jI6wlzk6QzKBiXAo9lbl+Q==
X-CSE-MsgGUID: mvCcVThxTuiAN3E5E+BUKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80420347"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="80420347"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:53:12 -0700
X-CSE-ConnectionGUID: Z8/BI2yFRuiWLa0Ux1qcJA==
X-CSE-MsgGUID: /cvbxVwTT5Ca7kJc47dxPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="282276238"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:53:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:53:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 01:53:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGtNh4w5/Ec/CH4PhqlxOTOvhf40KTgrN3x4vavx2jD0q52vNOVNy1LrKA7giSXWP3vPQxmrD2ocseynz77jjm2bFreJKMfs69KWiYElLcqr9Iodwbie+gxgdujkxGKy/yp/caoezH9lIq1huOCPQxVEzXnUXC++4DhPUSPFGIaYXNrmQQPY6KrxjVBsLiUPYaJN/Fv4GSYDdhyX21FYjxNGaaboSeELVfFecUss0ar96GI7AapKf5uqJ7FDF3DUgItwVzyHgbSZ34i/mH5/fgAXxgRQyoYLOHe0aFocsRJNgQsnq9D/ADFjhYVvqV5qtZAtDmfWSnqAaIaIBLy5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALx7D1ebDBCen3tAhVOQg8vn6+pGo+Xg+QCes5oToIw=;
 b=PL0XwNRwDAkZfS781miUSn/CyIbpNa2jBYIDGypkjixJ8G+4/cU+zsD62XysoAGJCFjHz8gxE9MVRokmv8BIzf3/Rty9+8ZTkKhs3SW7XFpckHXmEq82niD8iZu+gJ82u+BKwVWoeE5jEKNBb/wEluoqqZfZdxVuBC4nsxrczIfggg5RYwPguQDvKbZ01mzkgS+T0QPa/07lIcU/E/UwOEw3mYCsGpIggqjHxXX3DzGDuDjBvCUQ7TIzi9IuJUNhJjdLqh095v4FE87t4LLaLVOm64JQ33Ancx9gBgGEPLbIu7OTqxclqLNaV7I+6x8/Z8kjHj0sNHux3yNeNCMLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPFAB4263235.namprd11.prod.outlook.com
 (2603:10b6:518:1::d41) by DS0PR11MB6376.namprd11.prod.outlook.com
 (2603:10b6:8:c8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:53:07 +0000
Received: from PH3PPFAB4263235.namprd11.prod.outlook.com
 ([fe80::62cf:3d13:b91:6a5b]) by PH3PPFAB4263235.namprd11.prod.outlook.com
 ([fe80::62cf:3d13:b91:6a5b%5]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 08:53:07 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "rajat.gupta@oss.qualcomm.com"
 <rajat.gupta@oss.qualcomm.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: RE: [PATCH] drm/dumb-buffer: Drop buffer-size limits for now
Thread-Topic: [PATCH] drm/dumb-buffer: Drop buffer-size limits for now
Thread-Index: AQHc8oMEwBttFMLuRkelqWL17k27UbYsh4xg
Date: Wed, 3 Jun 2026 08:53:07 +0000
Message-ID: <PH3PPFAB4263235439621410606A36927D6E0132@PH3PPFAB4263235.namprd11.prod.outlook.com>
References: <20260602112842.252279-1-tzimmermann@suse.de>
In-Reply-To: <20260602112842.252279-1-tzimmermann@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPFAB4263235:EE_|DS0PR11MB6376:EE_
x-ms-office365-filtering-correlation-id: cce5d18e-c1eb-483a-5d13-08dec14d881b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099006|11063799006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info: dyVnuXoo8M83tovDO5+lBABDV02P7kUouAK1o54RUNpjsDGzHn5SPR5KzPFLLRPJqXcOwBGZGrSEx7D1+WCK70Rt0KuRqxRuYh2Imxbc/qPdl9SiuclSabzMvVsB4x90P2wb7gU1UYQ8fhmU+KpEa/s/D0n9e2qlywFOxL3OjT6Y1ppFxbtupYhTyPVdteuwwKsGuCMd3ivmeNNx3W7jTYKup1ZELc5P609EYkAsNnbtJhPSKwzijRQVxrXOkncPu28ynGHQA1/oEq4W1KI3SsusG/2hCqGhh+LNbkcPMVgK9n694P+kqTlpIjx6BR/pOV9QWnn6uvoiZMaB0iJaQHoDSk0laTrLYRveDROHZGNmPBezRp17k41ztkT0D3+kpRyj8r+npHymmNG+f7gEbVzzcQfmuRmL97rjnYRQDfrjOQtqdbg+CEdFRp2gbB8Ptv/0gvYvPBAAP/uaKr4YEdUUkG9v/KPXPtSgX+I2uqsFhMrXcJf+WR1d0Rl9EwFqXYrVp07dEycR9uD5CLlx1Og+K4vvJLtbLSk9jSltFli5nUVOlrnUn5aNBA9xHG/y1/anAzjcQCElszMaJi+sRJeEjrj7GTkWVj1aFXncF8fDZKJwY3vAR4GoS1LEktY9Q/iZiHTUiSr7XwSGarhsOW0ZkTiqv3FlODAZsQZd5rWxADoktO86hM8L+qREhVjXwOKxZ9e+ypzJgj2uZKCb3/CK6gZXSAoF7CiMneq7RhPnPLllBushggMFbo9KI56/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFAB4263235.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2tyQVJyZzVJSHhDb3pITXhvb3JCZWVyVTdOcE9CbG5heSsybFpIMzJhdmdZ?=
 =?utf-8?B?d2hWcWIvbW80OTN2d0RhcUlnQzVteU4vVm42MGFkRUxYcDRHVVBxQzFLcCtV?=
 =?utf-8?B?Vlg2RHNkK0gwS1B1cUlKNVZ2Umx4UFVQN0FySitoLzF1ZnYzV2tiL0VqZk9N?=
 =?utf-8?B?cStSUjZYMWJmQmg1NVd5UUUyVjFGWDJ6cGdpV2o3WmY5c254Q29tNTVHVDRJ?=
 =?utf-8?B?aTJtN3F3eDNjbTFKd3NQSUdlRExCekNDbXJhVVBiUmdiSE1jcHZ3WjhVRnd0?=
 =?utf-8?B?ckpaTHhPdlFlQkVSaERZd0IvWVBheTdFblVRckt1ZDVpZUFwNFJJWlJtK2NH?=
 =?utf-8?B?cHBKblRvNC9saVdRTm5zZXI0cUhNMDFSNzQveTJwMWlqc1JaOGs0aE5SdkIw?=
 =?utf-8?B?ZWt4MlFFekN6bWw0dytDU3FPZjlEOVFvSTZZOWFUMjU5RE44U3k0MXVldGNw?=
 =?utf-8?B?S1pBR2g2Vkx2UzVDVWVXd1lrQ0tBN2UwV1hWRytTYk1NcjhhSC9ESm9nbW1z?=
 =?utf-8?B?OElva0FiZXh0b2Z4Q3Z3dkJmQkRRd0RLWldya2FtYkVjWEpJRkJjUmUxTWNy?=
 =?utf-8?B?RkhhNlZ1QTU3a2ZnelVhc1NQYVlXRFQ3Mms3am0ycXR6OU9RVFlySFUzNzYz?=
 =?utf-8?B?aW1HeGh6THBzTVQ4UzE3cElhMGVuV1Z4aURoWmY4WlYvM3J4dVZjRkNoR0hW?=
 =?utf-8?B?MmVqVXZDcmZtL21UbE91aitjckdrRHBKTGI5NmZPQVhXdThSVG5mVWVFUnZp?=
 =?utf-8?B?M1V4QjNnSkMxUHRmVWFZV1dneUQyZzQrazdKTkcrWE9XaHFiN08vQlFaRVln?=
 =?utf-8?B?bWFyT090d0FZWkJwMWRhaUFzdGw3dUZFSVl4b1NaODhTK1RSSXhabnpMZ1pG?=
 =?utf-8?B?aWFGRWZNM1VoNndvMEcwVWUyVytobm1jcnM3cTB6MmVjZk9RdlJwVFNPNnpF?=
 =?utf-8?B?QURiQ2QwUy9JZnUzNEYwZm1pVzhtSVRxWTF6STVYeFNNdU4waXZhT0hja1Ji?=
 =?utf-8?B?MlFmNEV6OTRnTDdXSnZSOEthbTl3R3JyQ2o0QkIyZWcycnIwV29BbUxtMi93?=
 =?utf-8?B?TFM1cC9FbEZlWGFnZ2RTY3FlVUo1ZnNOSXNNMjFWTUNiMEZ5VE9SODJVWnpM?=
 =?utf-8?B?YjFLQnhpemc3ZEp5YXgwTEp5ZlJhRWdlMjFJQlc0V1V0M01OVk5JS3MrNjNO?=
 =?utf-8?B?dzNLYVlDZjcvNXllYWJ1MmxRdUZQTkw3Z2pKcFNyQUdtNm93ei8xWFFvOSs1?=
 =?utf-8?B?UjdNN2xrWW5vdHN2anY5ajJUeEZVTTFpNFkvUXJOWWdrNXAyZEw1MitxbFZa?=
 =?utf-8?B?THJrSTRwTFdhRGNocHJUWmVPREZFV0VTU1M3bDVrRTRGSUc4ODkyd3Izc09N?=
 =?utf-8?B?ZVpGNkdjSnpVdUIrM2Y3VTBkdkRBTjB1UFJKSUNkTUNNaGFjZzVCa0lGNkRV?=
 =?utf-8?B?SDFrYkpRUlVsazR5SXZRVzczWVlOYlhVUGpjZGFGMTgrVDB3R0J6SlJPZFhQ?=
 =?utf-8?B?a1BweUh3a1RodDJmTTBTSlhxY3hCektudjBYZnBnNWx4NlZMTVZiVU81TjB4?=
 =?utf-8?B?bkVqTkpMckE5WENNR0xPTUErMERMS3JDcjlRQVI5UTVETzhlZU1yMVpVbnNY?=
 =?utf-8?B?M2paZkRJdW0xTzZzQTRhc29RVHk4bzRBakJhZjBSWFVMdit2VlZMS0dKZjhM?=
 =?utf-8?B?dVA4Yi9ncnZRZG9remFHMHdvTnVpRGpRSVNhU010S1Qrck9PcDBTeUhkSzRY?=
 =?utf-8?B?c0VwZ1M4SGF1Q01QZzJnNkw4OWZ0cC9qQUkxRm14R0o1SlFabHN6UmwzZzZL?=
 =?utf-8?B?Yk4wNHNHTEZNMGRDUGoxMWFJYnYwaHdJZ2FoQ3piZG1Lb3RndTJnSkd4NXMv?=
 =?utf-8?B?T1BqWU50azdsa1ZINUFTS0NKMGIwd2RqelNjRGRPVGpxVCtNanFnMGhHaXYy?=
 =?utf-8?B?MnFiZnN0Zm10cENUTDE3QTZ4SVNQSkpMSHozeTFFM3ZjVUdkekpsWTNDTyta?=
 =?utf-8?B?RXZFbU0rWVdlSDdYTXpINEdiMkg4Z2I0VzJYblRUVENkVnVISXVnd1JwbzB3?=
 =?utf-8?B?MHR6NlJORW05cVZ4RWlmRTRPZTQzZ04wclNrWGlEM1V3cWdVQ1dDVk0rOWla?=
 =?utf-8?B?OWx3VUdIV3FTZG5lQVF2MnF2ZVFoc0VWbUdvaHBGOERya0xGbFRQZzlpSDhh?=
 =?utf-8?B?VWVEY1JvZHIxVWVjZVdTR3puTnZnVHR4RnJmUnlPdHNPWXRQcGlXYmFpaVpI?=
 =?utf-8?B?eHZBMm1ENk9xbGJuYkNSTDREK2gvK3JDamptWXlMQXZqU3AreCsrczVBeWJP?=
 =?utf-8?B?VzNGdWRXWXdDaEkzbGw2TlhoVkx3VWlXTS9qOGwzYXhrTmdiaStDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UQ7wu8+25LCWDYqNmIkIQG/mg4q0ki8G7NqR2nh3zKhuuXLCAmmEVsV0qVjR6Z8XDqpahDkXUIe26wrvfoWmtlFtf3oo0R0wjBIKgRmlGg6eqXyElLrxNrJ9aVWGN4jPMGlGXRhE+ubtNWZIqi+/shxCc6Y8dfn+2WNYnTrdRyrPcQKwUxQ/7/CouZfxrW8ZsC+GmqpXyoxtypw2RPpPB74xXJF6ScCQF29xROYAp1neR36D37u7WgxiP1pelw+IyxPpR3P8B3+sNArLzR8z/AnH5Aaf+IDCWPsDeZdvG4Uf1PiwRZaB0XXtZnthRS320QDYj9PSQ3avnp22QBfQYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFAB4263235.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce5d18e-c1eb-483a-5d13-08dec14d881b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:53:07.3205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8U2vN09Mu9L7yoA4GwLXnoec4T/3r3RPOjMR+16tQ8ZVnyIuH1STpgn9LYzKVtR+HBEgH2Z2/kavdwnIwtAUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6376
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

SGksIA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgWmltbWVy
bWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gU2VudDogVHVlc2RheSwgMiBKdW5lIDIwMjYg
MTQuMjQNCj4gVG86IHJhamF0Lmd1cHRhQG9zcy5xdWFsY29tbS5jb207IGphbmkubmlrdWxhQGxp
bnV4LmludGVsLmNvbTsgU2FhcmluZW4sDQo+IEphbmkgPGphbmkuc2FhcmluZW5AaW50ZWwuY29t
Pjsgc2ltb25hQGZmd2xsLmNoOyBhaXJsaWVkQGdtYWlsLmNvbTsNCj4gbXJpcGFyZEBrZXJuZWwu
b3JnOyBtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGlu
dGVsLQ0KPiB4ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFRob21hcyBaaW1tZXJtYW5uIDx0emlt
bWVybWFubkBzdXNlLmRlPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9kdW1iLWJ1ZmZlcjogRHJv
cCBidWZmZXItc2l6ZSBsaW1pdHMgZm9yIG5vdw0KPiANCj4gVGhlIHNpemUgbGltaXRzIGJyZWFr
IHNvbWUgb2YgdGhlIENJIHRlc3RzLiBTbyBkcm9wIHRoZW0gZm9yIG5vdy4gS2VlcCB0aGUNCj4g
b3RoZXIgb3ZlcmZsb3cgdGVzdHMgZnJvbSBjb21taXQgNWFiNjJkZDM2ODdiICgiZHJtOiBwcmV2
ZW50IGludGVnZXINCj4gb3ZlcmZsb3dzIGluIGR1bWIgYnVmZmVyIGNyZWF0aW9uIGhlbHBlcnMi
KSBpbiBwbGFjZS4NCj4gDQo+IFRoZXJlIGlzIHN0aWxsIGEgcHJlLWV4aXN0aW5nIG92ZXJmbG93
IGNoZWNrIGZvciAzMi1iaXQgdHlwZSBsaW1pdHMgaW4NCj4gZHJtX21vZGVfY3JlYXRlX2R1bWIo
KSB0aGF0IHdpbGwgY2F0Y2ggdGhlIHJlYWxseSBhYnN1cmQgc2l6ZSByZXF1ZXN0cy4NCj4gRHJp
dmVycyB0aGF0IHN0aWxsIGRvIG5vdCB1c2UgZHJtX21vZGVfc2l6ZV9kdW1iKCkgc2hvdWxkIGJl
IHVwZGF0ZWQuIFRoZQ0KPiBoZWxwZXIgY2FsY3VsYXRlcyBkdW1iLWJ1ZmZlciBnZW9tZXRyeSB3
aXRoIG92ZXJmbG93IGNoZWNrcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJt
YW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBGaXhlczogNWFiNjJkZDM2ODdiICgiZHJtOiBw
cmV2ZW50IGludGVnZXIgb3ZlcmZsb3dzIGluIGR1bWIgYnVmZmVyDQo+IGNyZWF0aW9uIGhlbHBl
cnMiKQ0KPiBSZXBvcnRlZC1ieTogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVs
LmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktDQo+IGRldmVsL2Rk
ZjAyMzNlNTAwNDQwNTljODUyNzlmOTI4NjYxNTYzZWY2YTU1YmZAaW50ZWwuY29tLw0KPiBDYzog
UmFqYXQgR3VwdGEgPHJhamF0Lmd1cHRhQG9zcy5xdWFsY29tbS5jb20+DQo+IENjOiBUaG9tYXMg
WmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0
IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBNYXhpbWUgUmlwYXJk
IDxtcmlwYXJkQGtlcm5lbC5vcmc+DQpTZWVtcyB0byBzYXRpc2Z5IENJIDoNCmh0dHBzOi8vaW50
ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvUGF0Y2h3b3JrXzE2NzczNnYxL2luZGV4Lmh0
bWw/dGVzdGZpbHRlcj12Z2VtJTdDa21zX2JpZy4qbGluZQ0KDQpCciwNCkphbmkNCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2R1bWJfYnVmZmVycy5jIHwgNyAtLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2R1bWJfYnVmZmVycy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2RybV9kdW1iX2J1
ZmZlcnMuYw0KPiBpbmRleCBlNjAxMzBiMmJiMGMuLjhlOWZmMTc1MzhlNyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2RybV9kdW1iX2J1ZmZlcnMuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vZHJtX2R1bWJfYnVmZmVycy5jDQo+IEBAIC0yMDEsMTMgKzIwMSw2IEBAIGludCBkcm1f
bW9kZV9jcmVhdGVfZHVtYihzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZGV2LA0KPiAgCWlmICghYXJn
cy0+d2lkdGggfHwgIWFyZ3MtPmhlaWdodCB8fCAhYXJncy0+YnBwKQ0KPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gDQo+IC0JLyogUmVqZWN0IHVucmVhc29uYWJsZSBpbnB1dHMgZWFybHkuICBEdW1i
IGJ1ZmZlcnMgYXJlIGZvciBzb2Z0d2FyZQ0KPiAtCSAqIHJlbmRlcmluZzsgbm90aGluZyBsZWdp
dGltYXRlIG5lZWRzIG1vcmUgdGhhbiA4MTkyeDgxOTIgYXQNCj4gMzJicHAuDQo+IC0JICogVGhp
cyBwcmV2ZW50cyBvdmVyZmxvd3MgaW4gZG93bnN0cmVhbSBhbGlnbm1lbnQgaGVscGVycy4NCj4g
LQkgKi8NCj4gLQlpZiAoYXJncy0+d2lkdGggPj0gODE5MiB8fCBhcmdzLT5oZWlnaHQgPj0gODE5
MiB8fCBhcmdzLT5icHAgPiAzMikNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gIAkvKiBv
dmVyZmxvdyBjaGVja3MgZm9yIDMyYml0IHNpemUgY2FsY3VsYXRpb25zICovDQo+ICAJaWYgKGFy
Z3MtPmJwcCA+IFUzMl9NQVggLSA4KQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGJhc2Ut
Y29tbWl0OiBhOTgwMTk2NjU1NDc3YThmNTA2NzExMjk0NjQwMWZlNTJlNTEwNjY0DQo+IC0tDQo+
IDIuNTQuMA0KDQo=
