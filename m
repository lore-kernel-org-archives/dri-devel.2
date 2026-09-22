Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3D8C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FBB10E332;
	Tue, 22 Sep 2026 05:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OkmS6u0R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CA110E332
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790054356; x=1821590356;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zdl7LTbrE6Odor9mhv+R0GnHXjJy0viZprZ3P8Knk54=;
 b=OkmS6u0RCvIK1o2W2iM20xHuCAHfQ8f6DQ+hum+ibJNSP1N4Ry382MaY
 7HAa40cAVpZbC/Dbuw2k6x3XDH74Qq3j8bsDKpW014WHCgvDM3vBPWcfH
 oCIyNW1ozia7PiYXy/0RRaw+xBSG67FraCmOKU2657KzeqN9ccKxfJOns
 x9f4xnQ4dMioJgirpr3rGI12VW0QLeMqz56xz0p2gujBcql09JnhSTxym
 9C+du9Yvb0GcRrSkne9OPRSLRq/9xpSdUGFgvcXYT3XuLEIe19j6AysSs
 st9lyb3p0swHU0WiegKFQ5vtSiaV8ereEo+u2haHiUwSsRPS5vmBfz7/V A==;
X-CSE-ConnectionGUID: qH6e9OBJTq69ywbKIQ9UlA==
X-CSE-MsgGUID: bqGPBje9RUig14sLuAgMDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89547151"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="89547151"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 22:19:15 -0700
X-CSE-ConnectionGUID: BeFMwsghQcm9EzuX/h8h2g==
X-CSE-MsgGUID: SGPMMS8ZS8K9/TioZrnv1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="4281544"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 22:19:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:19:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 22:19:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYEpbUlUX2Yjs57b+1ps6spNbni7qeK3rktbVGu7v0cmX6DRW6oMFZvdW+YxTVDZ6DHCXirjdTBDQbqGd8MZP5UXMmq7UsC5h7Alg4KXybfJGBfwM9Vs10bUFIi8caWY90cDmUo6T2M46keZTk9BU+/I8UsK0wsJCJaa3BXoNNCPcnK5rSWZmsP2HCmMTJ4bkdMal8wlFeyAh5Or9hV+dgBd6vNSo9VVTQJSfAj0s8joUOYLMfKCB5myYgr4jf/IZ7l9f63+Skc/fF7BFcOOKtjxDAeUXj6Eri9M2Tnz+/vOd35kLEV++sDcqDCaJZPAK4SDvesao8r1WF1DegKUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDcNGFXYqosfno2KTrSWi/y1xdmbpQ41FG8lvFENg8I=;
 b=SWG/cKMRZDSdpGR4J62B0kQLVApgyTlRJQLmv6LH6l25OEm4hM/wIxR8KXi3c9ppFVFgHqDtNnUsyNnDIVDrlIyUWSF3qHPKFoa7saDxMlXYxTbHYQRazkBz0OVgz+tDM5Ae0XylVzmrXLuOJ7NgNBXYg9T82n77hFelccH3u+1gMFsiPoBpy6ZwvxJYGi+QpySGlqJoByrqngNxP9S+nWY2r+aSWy2M5uOARQftB1fevxOeLAHzQF8CWnbHZZEkQ+EPTiEsgtrxEdnkZSCBaRZPA6AY33s0bPY0DamQ+9q/7NQuOlneIiYODUJEPNDdrbXKDE604RkxUeE60iwieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:19:13 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:19:12 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Robert Mader
 <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
Subject: RE: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
Thread-Topic: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
Thread-Index: AQHdOQ5nSG/fDnCEd0CaxK5EtQ1eDbbYvOWAgAC+lWA=
Date: Tue, 22 Sep 2026 05:19:11 +0000
Message-ID: <IA0PR11MB718502111B354D893D71FA0CF8832@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
 <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
In-Reply-To: <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA0PR11MB8302:EE_
x-ms-office365-filtering-correlation-id: e3450c87-43fa-47c7-bcda-08df1869097d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: N4d2A8+A2b1QfCmroyDxEjfy2n34vQmyNTNo1BLjeM9lNlefOJCoMNe/sTcn6eqehyqUkcQxWUW724HK5YmvR/h1FwkRNQWOw1vS2LJgBESvZ5v9P5uxMDk/QQWaYP8gnOfZfKKnQ9V5T1sDVVl3kHFgG1kOuYBN8sJ/v0hqELJ4wce/uNrBSk2hInHOvJr45eWEtA8WbR68UMl3bD80ot+kYQkhxvmPUiqDW/GrG+/cMdwAi8nzbVPG+1QIUs4m7nP282cYFTqkthsXdfMSU5UeYSLJhf053w9OMZfoExEr4vS1Ar1XZQP2G9/1lNTk2sF4heu7LsQxGD3RYlJdlxQO20pDB0zWrN42/eEwWk++HMLZkHNUxKCmzWky/UofKODN9CHpoPivqnyAS6lVj5tApS+4QVeRV0zWMrpgfLnToikiQ0vs8T2r79EDuyEqPTY9IwI6Bf7F6kNcf0BAoQ8qjyDC6xr9EWbShW7B+rHM4diNfCrX76BGPGKVLCEi+cuxCdx5ETLu6d1PK/Q2VBYBgB2LwRzajE6BAqrjxW88jxKREc/66exyF3fcqO4Eeljy6Kjp5otDrvLlxJmDxVgkhtrr3191D8zdaqAOm219ZGTE8CXE2kxaKYXg3rLg+oLg8tHXdmtqavC16LTW6XG+ruGwrBCZhmkIYu22jo50LRimQ3InjdrKhN8/Zjaktm8hoFkRIeVduaCXnywXUHoIhQJHTxTvAqjsEoGj3jY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TL/b93pfgnyUjcXC33aVmwms5UGASohw/silmRnPpxhzpv4BYhR8/tRbXd?=
 =?iso-8859-1?Q?U0y0UjaDzU7rBfAmzhihXHsspZGm4sUQg6zFSXIDt4KYrkTIX97Cs7Rrhv?=
 =?iso-8859-1?Q?mvNLRymdtAOqRg8lM41X6zB7FkMdz0p0fMpdWNyKkA0Dk/PQgMO70a4mQZ?=
 =?iso-8859-1?Q?ePvSnnKL/fN/UyEleLHWCnnNnzU/uvedrXf7jvQ+vvLSpN7/BLC896jd4C?=
 =?iso-8859-1?Q?OQTOUFVO2cEtTC4GcbRjjSJp5hNEm5n34oYWwtlNT7ueZTGniKm2onfifB?=
 =?iso-8859-1?Q?2s8HIEKEioPALSivILmwMei3jB/a9D3YU5qLhezGjb0c7T9gYswC7gf5RR?=
 =?iso-8859-1?Q?ulAk01gwcFEyL68HX1Q+xoPnkBMfHiazs2hwrlMCwWhndCya6IWlkMrAmu?=
 =?iso-8859-1?Q?Ot8IVSIr8cHTKD94AIhQwJEfV8BvXmiQicK1lqO1wzc57z7t5NF0ynygNG?=
 =?iso-8859-1?Q?O9ETpG1cK9A0Bv4ZaXxqYHJN6aWyqfH9G+Ti3TiV8rm8wg+wuR1MuVCpub?=
 =?iso-8859-1?Q?m4hBejAAMN3ys5EtNKBn+TE3mpy78AlrzDKz+zcwxKZS+OAb2u59z0MOWG?=
 =?iso-8859-1?Q?kSGnyIh5N+c8LfzQponNBZ54U+32+4uCPn2fu7ocQd9c0xsMyKtB72rzN3?=
 =?iso-8859-1?Q?PcQcTssD8IMJtDV48JLv9H1pFx2dOFjIrnkM14xmRIdPbAf4dr5kpqz/vd?=
 =?iso-8859-1?Q?T5v1sipY0jLafLGbD5yuwCIdx9gBBzXoG/x7Q7CV0CqDTuGovAY8Ags147?=
 =?iso-8859-1?Q?AYuHsri6K6l1UVdcUSTk6WhWHypaUVA11ByQ+CwCTLX5afFhpVxH4pI4eq?=
 =?iso-8859-1?Q?K6ukb2BMztUaYqSc61lvS75X4YL0d98aqyNgyk3HLE6zXUzU7/bqCjrjOK?=
 =?iso-8859-1?Q?kRnR+cQhOPQ6eSrdsSOAOxo2KF43xb0teVHglFWzFFpQEn62n1PwME5LK3?=
 =?iso-8859-1?Q?CbxgGHch1gKu9kUF2/XfVB/OOWO2LqQzyiqKoYSag9l83PCwuSlDmv9bgL?=
 =?iso-8859-1?Q?p1MCZdbZBXh3D0g4Nxkz9GKBFvD4G8MN0QBsy9JyXKfLirqAVv2+/fUn26?=
 =?iso-8859-1?Q?rBQhRCMc1YcIGiIJKkOGiwYnWV0ygLD72XnN+MBe7/xpR6JeUK50LWRQ1Q?=
 =?iso-8859-1?Q?RRd/AeycYl3W+8YMIw0Fjb4WUMvI3Tu5rkTxXROXAg9A+Ni0O4po1BLYwg?=
 =?iso-8859-1?Q?bSzm30s8EPp5qwvruJUg3THV+RYKLwwxb2wJlj500t3smbI5BLKfM3+IEI?=
 =?iso-8859-1?Q?yzRnFCb6b2ezCJgFeIZjJCnsK1SHqyLtLaZxzL3+QaOm3b9O7avs1bMD63?=
 =?iso-8859-1?Q?K5A85pPpSLP4fph+0Y5tMKVVZ0+G4pg6Id0v1K2JTaYec+AQ+sLcuTxJoi?=
 =?iso-8859-1?Q?apuuBzpOvE0ap3VWnSJ+eR3CNaKY1MXjUC2dHiyk1aZIic0WJw5zC7R6oO?=
 =?iso-8859-1?Q?ex4/fug/AtaySzPBxf7QBBbHVDE76rmzCHSzpdMWiJCGZlsN457zLHdWmt?=
 =?iso-8859-1?Q?LNzfo/BX7miFTg1kzV5pA/RQwQ/UCfCBAz7Lmq/32fD3QALOvU/ACuBu62?=
 =?iso-8859-1?Q?kVy2nl9Dplc4J5LtKoq+RkjuEsaTFjlgmHwp5AO5acDo/Xakhm/lKQ6tJr?=
 =?iso-8859-1?Q?FF5bOSrDB89GB8jCRDfMjCLV4C39Pdroc3Hyjmp6RcP6YAp0O7l+ak+8bo?=
 =?iso-8859-1?Q?gF2ZCBm/3ODPyRVPiFHhXvarXqudyak+UmMGZrUrHuBGydSkqQyl4i+D85?=
 =?iso-8859-1?Q?0PXRqC8X1SjuoFyqM7chhM53euPgE89riw+yIPeLc7AG17ROaK+Ws1VmNA?=
 =?iso-8859-1?Q?VqjEGGARMw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eDuNedft4wLBdhW9PKyTxTPkhkaur2s4t467I3APSnsjSBisa4/pQ9IO1tsHv+OTruYvrwmJvAnTzZq3qtGPGZwW9RJRKG2oDBcrv/WRaqBpH9HpLhReuAG6Xiau4EHCy3flhopCydC1HhICP/sBJ77tL5Ih5XHxPQKqHY58PIhvRD/E8y1JUXYLMliwyO5WqN2ktK3Oxw0MeqLHXHe+CC8bOT+vINjUbohiORUAYWt32CqH2dEWCy42lYefyVopNBFYjc4kmgeN/Nbp6PCI825iKtTeZ8oR2NCBvGVYjE9sJwNcGi/W4D+uM08Aea/IAszzC4Wn9Tv1QS3fM02LYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3450c87-43fa-47c7-bcda-08df1869097d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:19:11.9133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNCSLqzMFtrSJnkog5SlqA4zHU8AkumyqpJUxipKjRpg/r7QiZOYy+EnJ+WOy9n6+6p/U4PsOI6LWYp/U1Y0fI78YmIUGBoh5oJP7flTqXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
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

Hi Christian,

> Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for
> udmabuf pages/folios
>=20
> On 8/31/26 08:00, Vivek Kasireddy wrote:
> > Since udmabuf allows users to pin pages in memory, which is a vital
> > resource, we need to ensure that unprivileged users cannot abuse
> > this feature to exhaust system memory. To address this, introduce
> > mlock accounting for udmabuf pages/folios. This change ensures that
> > the number of pages/folios pinned by udmabuf is tracked and limited
> > based on the user's mlock limits.
> >
> > If an unprivileged user/process exceeds their mlock limit, no pages
> > are pinned and EPERM is returned to the user. Note that, privileged
> > users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
> > allowing them to pin pages without any restriction.
> >
> > Earlier, there was a 64 MB default limit on the size of udmabuf
> > allocations, but it was removed in commit 44e9eb5a7621
> > ("dma-buf/udmabuf: Disable the size limit by default") which left
> > open the possibility that unpriviledged users could pin unbounded
> > amount of memory. This change makes the limit dynamic, by invoking
> > user_shm_lock() to check the mlock limit for unprivileged users.
>=20
> That makes no sense at all and would create a massive problems.
>=20
> The mlock limit is per process, but udmabuf is represented by a file
> descriptor which can move between processes.
>=20
> So this here can be trivially abused to account the allocation to one
> process while accounting the free to another process and overflowing
> the mlock housekeeping.
The goal is to have the mlock accounting be tied to the exporters since the=
y
are the ones that pin the pages/folios. As Sashiko identified, this patch d=
oesn't
quite do that but once fixed, both alloc and free accounting would be attri=
buted
to the exporter. Would this idea not work?

Thanks,
Vivek

>=20
> What could potentially work is to grab a reference to the cred structure
> of the allocating task, but that is also not the nicest thing to do.
>=20
> Regards,
> Christian.
>=20
> >
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> > Cc: Robert Mader <robert.mader@collabora.com>
> > Cc: Xaver Hugl <xaver.hugl@kde.org>
> > Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default")
> > ---
> >  drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index 7c4339130eff..e78947f01656 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -203,9 +203,10 @@ static __always_inline int
> init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
> >  	return 0;
> >  }
> >
> > -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
> > +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf,
> pgoff_t pgcnt)
> >  {
> >  	unpin_all_folios(ubuf);
> > +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
> >  	kvfree(ubuf->pages);
> >  }
> >
> > @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf
> *buf)
> >  	if (ubuf->sg)
> >  		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
> >
> > -	deinit_udmabuf(ubuf);
> > +	deinit_udmabuf(ubuf, ubuf->pagecount);
> >  	kfree(ubuf);
> >  }
> >
> > @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice
> *device,
> >  	if (!pgcnt)
> >  		goto err_noinit;
> >
> > +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
> > +		pr_warn_once("%s: User not permitted to pin more than
> %lu KB "
> > +			     "of memory, either increase ulimits -l, or "
> > +			     "obtain CAP_IPC_LOCK capability\n", current-
> >comm,
> > +			     rlimit(RLIMIT_MEMLOCK) >> 10);
> > +		ret =3D -EPERM;
> > +		goto err_noinit;
> > +	}
> > +
> >  	ret =3D init_udmabuf(ubuf, pgcnt);
> >  	if (ret)
> >  		goto err;
> > @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice
> *device,
> >  	return ret;
> >
> >  err:
> > -	deinit_udmabuf(ubuf);
> > +	deinit_udmabuf(ubuf, pgcnt);
> >  err_noinit:
> >  	kfree(ubuf);
> >  	kvfree(folios);

