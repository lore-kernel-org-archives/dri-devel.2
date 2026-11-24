Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934B606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UkmcHyr5;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Gqt05yNn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5716210F2AD;
	Tue, 24 Nov 2026 00:48:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0890010F2AD;
 Tue, 24 Nov 2026 00:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795481315; x=1827017315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HHdTtEB0SBOvr+nUqlNujp64hW+KAMwPWzB6zkFhS9Y=;
 b=UkmcHyr5rbb2I6mOlzNBJx0PsrpDccB6qcAofXrB0U9aZcIkYjdB+BkS
 Gr3+sihK36x8o1Isqv4ZwmRQq/xZsZDD5qKo5KQOnZRYFwP/HysZDQQCO
 +v0B3AFpsDkQNO42nJdHcnTjMiaNARrwGn1N1kjEpXDfcUyfU/zDa+Nul
 4cT1ruyDLN2cAodXdhj0m9WmvEMsk3D6fFJJ2nUXDgX2ZI/FQTBaR6uRj
 ohvK9FKlvFRPf1L5NuS64tfZ/o5fUQp/W5Zy/tow35BXOkBvjerbGMWbg
 qQQP/vTqFCdDngPNhgdqpqWx+XSuKNSgrhT1GW340oS31iYwWWYuA2lki w==;
X-CSE-ConnectionGUID: snIaQ1hjTq2/gNyhz0LnFQ==
X-CSE-MsgGUID: tNSrtTIuRnGikvqkUd7S+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4148348"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4148348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:48:35 -0800
X-CSE-ConnectionGUID: nbYASaaETBiR2YbCQCznQg==
X-CSE-MsgGUID: gc1luvdMTZ6UUjQ94K3/rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11606696"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 16:48:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 16:48:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 16:48:34 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 16:48:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofSj5l13z81Dkv8NS4eLtyhAYLW20Ly56qVvkdopl9mIVcMBvDw3fNmnCLIBuw+y1uJ7jFOPpqu9iQIoqNDLgOJbCRdUU56UVdO3mT5cf+kCsHqs9idtxc5oY8P0DcbNIIPiHQkFHs/KtkLRf+oqKUUJnaKnGY7ygVU0R3Dp23NAO6XaZ1N4qQcdjXBH7ihmHy6AQJ9JGNx4+cShnsFPvPC+MMwx+Bm1NqeDwKoXe40zaOnPbCt7S7xLnttMFts0NBBZ3lUkv66UFrTOgAE8hVH5ty1o1TZ0AhHfoFZD0A6uOUfxCp6hjESXpS1A4/Xqk3JdIc1EZhOzDAY/fbd0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj4BCdSI2EXOvcl/pDJTHpbyLoYgzKyi75asK8+vlns=;
 b=y9ic8Qmn+eAIcMH00wU1dkaHkF+XcD9zUf3FmWYPmpL+R7qIwFpV5i5zJpSyPVUzG7G4w/C9Wsl17pAPQq8j9DT0ZDthVhukH63AyORVAWw5aIEsWb9ikSpuKrKRquJz7JntrCFcum9kBRydqmE0ff6rNCqxY6O8h60awlROpXOdFAeV/AcNibvz6E20+jsw0t0+Q/LX2mczUMehVE3inGgfkVlxlNMemB5V8/b+xl7V80fyxIsaSA2K6eq1iNd+XgrdXppAGpr+jRLUNbz5tOGQbH9Ebs/thUxb2lpBe3lAjUhtZ+Qo/ZZEuKac0Xw/mD0+aSdryRYpL5HMfzH6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4BCdSI2EXOvcl/pDJTHpbyLoYgzKyi75asK8+vlns=;
 b=Gqt05yNnjtev1SH5h9X6kBGO0wydECgmWERPdvwCCur930FqvCNuBbXbCx8F+q+CGf1cXJpwtN/Fht1sfu11v+IbogfZTYvIMkuch+AAhrYY/NipYZsIBfDR10J7Cr509gN747F/BWTAf9sR7PtLy2R9kgG5EcVQFtqdPOj7SqM=
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 (2603:10b6:610:367::19) by DM6PR11MB4723.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 00:48:31 +0000
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823]) by CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 00:48:31 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi, 
 Rodrigo" <rodrigo.vivi@intel.com>
Subject: RE: [PATCH 2/3] drm/ras: Do not fail an error-counter dump on a
 skipped last ID
Thread-Topic: [PATCH 2/3] drm/ras: Do not fail an error-counter dump on a
 skipped last ID
Thread-Index: AQHde6M23FfjR/r5kE+n1nMa06RQVrc8Y7Ww
Date: Tue, 24 Nov 2026 00:48:31 +0000
Message-ID: <CH3PR11MB0461495A780C5BE7A0809BDA71C1442@CH3PR11MB046149.namprd11.prod.outlook.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
 <20261123233326.2882114-7-rodrigo.vivi@intel.com>
In-Reply-To: <20261123233326.2882114-7-rodrigo.vivi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB046149:EE_|DM6PR11MB4723:EE_
x-ms-office365-filtering-correlation-id: c7f65d90-46ca-4525-8e6a-08df49c4a9a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|4143699003|261021121427099003|38070700021|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: I03x4yV0hD3xhFDuoh2HwSkSRXIlMCco7oFINnW66MwcFV3pZmru6DYjVD4V4mBdq55MSEllsfBfjCtKxwwoQQWUM5k/iRFpq5Z5IJGFAmdd23frD1B+AjiULXAqAF4xY7pDXRmUQ/86miA0U9yMqLYIMC+KIIfFUJRndgpnOEDJ1To6eaAoaME/IYXnyX1TEI9CLriAhUy65kk6qgAkeUxPPvmaFCWaC180qNIBYSDJXVzerEPGSWlOiVGtyFFp9xo17hBw4DNKInLgdCRJTVr4wydJCeplGVspvp+0rKtk87RXFXawwklyMDcxOhH5ZyqqUevojMAiccPGfqJZQzoR3MFWiwAdxQp1nbwONjFrt1aIph5j+BSn3CAEb4d/yJjzwmoyn9dfLdtyehSdhw0E4xXdpN8H23kKIOBbyiNPNfygdHtz+S2Y5d/FjPQgahhpH9qAAosi0cI25rO4AX1U2Zy7fnbf76WaziopJM61gavjkBsa/z8gZoOkctFpPSCvQxofgmywieSb20SVJU+x12ytX4Vmsc4PSVyMWOqv+MevuF1H5/WYubc+sipVSvjuI9o1LvYUvYe/vBjy3tg1aOQLIRwV+mp3yexvZaBk8jPrhJGQ64PMKoo9czUSEsypEG1whYS4hJ9ZIqBn0cCw/3zUJQaFbFMkPFCrlr9NphPy2inFtfrBwkdd2PojweFhCTAukCNPS7LZrtmZPUJKBgkaRfOAdUUzK7Yr85U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB046149.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(4143699003)(261021121427099003)(38070700021)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYPWa35RUPiQxccSY1SwqHbylS4V0jicOrhIF6oV8FPuimyK0PnQi3/6TlBJ?=
 =?us-ascii?Q?SsDriQqGMDdE+VIVBtSzLfJbE6DDSVJrUFlAK0a4B/1PBUFDXFdaYCegEFY4?=
 =?us-ascii?Q?dCdCce4ZYAu/6/dTzA37io+229iwJyDvs5K5Q9yloBVX0mRqqYZp4e+MOIwe?=
 =?us-ascii?Q?s6Q20k8gWEFnZZtkJCgZqUYsiK2JjqRVjelXmIttzr890lDtnV7n3Tb7atRL?=
 =?us-ascii?Q?ZaYZkkAXXtGPaLnu559u+6kwtmGA6xsMmjFgayFAo11tGU7/jnq13MpbmNyq?=
 =?us-ascii?Q?ElP5zUUNIyEORyvFXlEmm2Z90ieVQPPbtbVosSI97e/MkDyqJma8nO369qQb?=
 =?us-ascii?Q?mB2bXAuzxQ8Xo+9tCRF5B/qwS2hM7tB2OMMcFWHgnZXhjsU29cHHGZwxENl5?=
 =?us-ascii?Q?IYN8W07//DsEuRtbtnePkdYncWR6pN9DJHHh5iAXNBD0YuuJOz/vcEfkTMeF?=
 =?us-ascii?Q?PdhLVKw3QN7CmeMnZsErO0z1JNRmBZY1jxy+trWPuvMkD+oG1S+/zUSSadA9?=
 =?us-ascii?Q?rym0u6SnJjaEi7ODTdQW1gvRhPmnb/fg2FWslFDk0AeWaaqB8Y7uEr70ZpNX?=
 =?us-ascii?Q?W+sU5kCVQux76/PcAC7PBce0Ipj66dbgvqeAv0i7a8oyNZHhparmbLgr3bn3?=
 =?us-ascii?Q?bUJWCuviZsLOKyZ9ylunOWTijEzc/wdWJj4yne4/4pEzNFxnkfXpDFeBdA/O?=
 =?us-ascii?Q?nXTFQpLICYoi0yzEAV7eQFTJ3CDb81hIEF1J0QCAsoFe73cd/hXoVShcVDyQ?=
 =?us-ascii?Q?RAqS6ZuSPljlKMeeSLh1e8DXiym7JdXBXNbn62v/Xhg5abyt7lUwk1xug/NP?=
 =?us-ascii?Q?9UNjioNFLsUCjOOgSF2OevRTUEVmz5vDD6/WKCjcUHEKjzH9o5eqk0ibEDpO?=
 =?us-ascii?Q?YYTzQF18Q9FCH9qVwJ51YD/ohu83isDJI2OX2r3zYtAwhYIQsqsH/JvFVGcu?=
 =?us-ascii?Q?p4Ip9rTeSlECi4Tb11nijYj9f/FpXkxxFRwrHn1JW5ocHbGujCPx4O9iKIyR?=
 =?us-ascii?Q?IYN3HmHS0kglWe9Lp5JnSeaHQoJQJzLNz1oI5R2sApF+slVomsEAA77uKvUg?=
 =?us-ascii?Q?MIV1tu9fC59Y3EqWg7DUXQgrG1qTPhJYroRWRJJkVa4sMsYKfnsqGmp3elt9?=
 =?us-ascii?Q?NGh3NJ/FY3FFU5xtmnI5NmaJ6wvVn4JziqpM40Frk3kHdQ3SB74ZJMFgh03x?=
 =?us-ascii?Q?1BjvCt9nlpBS1wXM+rB9toDeeRafr1MPL22MeXrp+bF5+NCb+EgeRneNlgMQ?=
 =?us-ascii?Q?pNk4WSUZ6IpDv+/FoFjwpChH9RvYW3aioijHLHBUiV/fPjcIw+DCdYwJW1sQ?=
 =?us-ascii?Q?VbZp6SBwrBw/JYaAgwYRcGLp+sNHMLrvQPlBPlC0LWxGkytALZn/YmqeelUe?=
 =?us-ascii?Q?qg+bEmb302WHqleRvc0OC8vdInFd0+CAfnOH6h8+Uu5XgMc5qjv4PP4vc5iS?=
 =?us-ascii?Q?7mc7gTANlcu56bx6/+2/EK2/gRVLd1tFc2NmlmooZFXrG2GQlyIsCgXl8L0l?=
 =?us-ascii?Q?+xax7zz6DEQq1lyICCqFdv3an6DKCI2RwWgAbJuBdzGtB4m7l12DNYSMbysa?=
 =?us-ascii?Q?v6EQDs0/jhCidIXkSSTTjTpu5LSfDW+X5wjbI5w4eH88qQ+Qo6a6BiekU8te?=
 =?us-ascii?Q?mm3Rc9e4zRM0P1+5y8H9BgBnwFQbvzN7uq+DK/Cuj60ktAiFe1ba3p20p5Ut?=
 =?us-ascii?Q?aMxKhKNpL+f32XDRnV8wya1IVDlVTFnouJwPXU19O2JoEH0Tl3G2Cj/u1wpg?=
 =?us-ascii?Q?t5NcFdMBqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f26ohAvaMddb4+AF9aRkOLiejHBwDCtcgea0e+0BPaOno2OJCFJ81STemZElGcA8k8WFhe1slzU5r6dBeSwQhGi8ttSuiVbdAflCoNuBH2A19/OOBHl6k2pSov4M4/kZjEXFTHZ+rAwpWMCtkvuAosUB8g+PZ13KnRU+nJHuyBuCk1qgzHeNkPM70uLcu5aM49widIGQsdymd94d5LBTIZMsbN/K8EFIfKBWm5fHnboCiPJgiOcXAw27XwAiQ+noF99vowfi5aBWJGsGMSrbiVW0s7+oo7aIBNe2zmqd65xhyzAwB6lbGWmXxC4X0/h2EcHKwb76LaQ9hv5j04Ee+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB046149.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f65d90-46ca-4525-8e6a-08df49c4a9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 00:48:31.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wewYhfVZHotkEDrYnBJhScE3yMiuVNJw0PUP342l/YfUO4hnQaQSTZ5qVKDM/4mKlgViOk6Bnpa3y9RaY9rdjfOrmH08RYYSxDCnOG45Lig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



>-----Original Message-----
>From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Rodri=
go
>Vivi
>Sent: Monday, November 23, 2026 6:33 PM
>To: dri-devel@lists.freedesktop.org
>Cc: intel-xe@lists.freedesktop.org; Vivi, Rodrigo <rodrigo.vivi@intel.com>
>Subject: [PATCH 2/3] drm/ras: Do not fail an error-counter dump on a skipp=
ed
>last ID
>
>drm_ras_nl_get_error_counter_dumpit() skips the IDs the driver reports
>as -ENOENT, but keeps that value in ret. If the last ID of the range is
>skipped, a complete dump then fails with -ENOENT.
>
>Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over
>generic netlink")
>Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>---
> drivers/gpu/drm/drm_ras.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>index 4f4777060a4e..f561604e7e96 100644
>--- a/drivers/gpu/drm/drm_ras.c
>+++ b/drivers/gpu/drm/drm_ras.c
>@@ -475,8 +475,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct
>sk_buff *skb,
> 		 * For non-contiguous range, driver return -ENOENT as
>indication
> 		 * to skip this ID when listing all errors.
> 		 */
>-		if (ret =3D=3D -ENOENT)
>+		if (ret =3D=3D -ENOENT) {
>+			ret =3D 0;
> 			continue;
>+		}

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

> 		if (ret)
> 			return ret;
>
>--
>2.56.0

