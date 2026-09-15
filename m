Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498B4C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 05:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFEC10F2FD;
	Tue, 15 Sep 2026 05:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bTPdiffz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35EF10F2E9;
 Tue, 15 Sep 2026 05:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789451593; x=1820987593;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Hn9S4y7JiNC3Ss7TgFoVwmk/DMjKRv2obxj0RaKL9xg=;
 b=bTPdiffzdc8tr/Twa2+R/ckAxsvi3y9eQ4mmZ/HtWjjrDmnqs5A4qozQ
 H/4NbA2xuyuliLOHSf75P4K+nfaczwf9kni/MzbRi9JHLqm+DpCjVzKXM
 1CA+8hm6plhl3JVxLftOBNBOo9liKCS9sauLyM2bXxDagZaIA1USQk/2G
 P0paeNkNEbmhBJJfk1EEL0hkN+vKyd0tuEUkobT2fXkHEzbWH0a57Q94k
 /uw6LDEu40Z7LrQIkPlNtkGaEyUJpoSt6baMPWJZnwN4HhN8admzlhuho
 OyiwUGIdF/zeNjAZZkATUFwWv8cv0zDwpWF3K0zLPo6xViGFfs8ympMBg A==;
X-CSE-ConnectionGUID: pmtM0vVUTHibZ+yqxdP3HA==
X-CSE-MsgGUID: fYejLmWtTDyG9ia6A7xUiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88943421"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88943421"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 22:53:12 -0700
X-CSE-ConnectionGUID: iu4OcfTxSSan/oe/7up+jg==
X-CSE-MsgGUID: /n8Tx1LsTaKUv/Xaqsj79Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1060058"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 22:53:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:53:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 22:53:12 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 22:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ2FNUA8t5xwV8fpV059ml8WwSjojyaXacdCBLCZMHJkXkaAn6tEYZ/03Xxzm1EE7tOiKK3LdDtKVtZ/n+RJV2NIBNbT3sKh1T+f4f+/ZmvQRUUQodySYJJh9FqhAGsmsmkyBSYmiVrwO6ufGudclGh3GKyvlkCgUsAUt6ExL1ziLVHebsejTb8VpKf/CqIqFZL8IgQTG54b4P0FS4QLShPezmcir5ogiXl3g5uUJg+qNipHRr+LSMgeczPVrOcTnnWb+I/TvbqCWafkODgG24rDS/3ghqJWSfVUQWQZaksImQWQI0VdMbnoTYOK3RWxsWDyQIkqfduRiVU2pqHScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxLeXtkGH1WD+1sbk0rHVmy+GSUt4vuwZRjNx3paYV4=;
 b=Js+85Nrj7OUsFqcGP9zsD8YAuiO8E6Gubpz/nOxnXbiuUkprZfypBzRipn3KsbHayMIGOmYb+mNQ50s+L7AtAIF40yx5z4uzTdlnW8008MuR4spMmLb26Ng1uJHXMCtObyFbY4jQtEGQJHpJu36SwissoM1E5qxYp0/ykC/lucNe9fltJF60ikaA12zfnMLSVFIWrzWMhO0GVWpLvRT36vqCABXMLA8Ngh2/mtQCtyHtAMTVupAZBh9ruhu0b/MWgvJyKZPsPyndOD9aR947AePTB0fk+c68+1Se732dAOjvVCm79forv9KItV0o3W0zJ+UjOghQ1FFa/UgBCis8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by DM4PR11MB6549.namprd11.prod.outlook.com
 (2603:10b6:8:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 05:53:03 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 05:53:03 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/display: Fix DPLL reserve and release references
 in kernel-doc
Thread-Topic: [PATCH] drm/i915/display: Fix DPLL reserve and release
 references in kernel-doc
Thread-Index: AQHdQoiFfXTokIF4w0yYPscp+8kVcrbPJs1A
Date: Tue, 15 Sep 2026 05:53:03 +0000
Message-ID: <DS4PPFE901A304FBE5B427A9F07DEFFB035E3BA2@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260912072946.50769-1-kmehltretter@gmail.com>
In-Reply-To: <20260912072946.50769-1-kmehltretter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|DM4PR11MB6549:EE_
x-ms-office365-filtering-correlation-id: d93bfaa3-615a-4bbc-4b19-08df12ed9b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: yQQkwFFOvEyZQxvp+3ualOQtRiAIVrb0iup2bFJd+8VZGcoJMbe2ebHnDnZKYO769Qab6WyKbykDp4e+xElCaKpbhqJdTlKtrnWYmMlwfwLSWR1R++8B72OdLhamr3sZpohhGUNxINqjg3KMiNsIDNkBexSA13yh6uZSXIPjMt20lJikZaIE/9CrnKtdvc71FTZBTtg7OZQJSQT0lPDJyAgs3zfhi7m4up/bkqIGUXMaao28QA+vU6ODZXvDDXqHWXquAMYXy3oFFuxU8oyZrRuG2cn+MtD/439l6vTDtm2sWIHokhRGCWLfmvvqIzCbfhfha56XKt9vpsrxU/f+Dr1dldOuOJ+atnSt8xcxX0cLPxSQOKJNaT4ksy+oV8lw4vHYtWLcQvKf3eAO5EA46dRc8PIJ5ZpEtPd3uFm34RjyT0lKSnAX9tCITVV7H8Lb1QMos/ds3RXKT8gpmTiQKyc4N4/0dV+CG+3N6nslPMG8Z3kk5FTXlkjcJiypCbR+/9KSL73heGA4dyuxkK6O5cjrgpSogLgiBeuXyYuPvM9i+PKFEiioWmp4GGoTPlyDnVccQXHNpT78zCpnFzmUYyw9Ad2DmMUcDMSBXyVWMMQORisKhhAAU4e9pWArypiOcsMWqoKYcoCX6zUCezAWAHUzESCs4b9CFzGuRoJxng3+QRPkssNKfveafudco+MizVtJc6b4+N5zjLCdXvTQO2GidWqDfhT6hXSjvkdH2gI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aijg6Bn31R8L6Pnk9I5cg95LC1nfCD2zgYr+53fo6UL/uRRbsQGriSvL9Q3J?=
 =?us-ascii?Q?m+0YTlG9Pc6nvbG8bM2srkKo7J7/tjOpfsVqKqL5EMphS9OtYNPmvv0WISo3?=
 =?us-ascii?Q?jO7v0989qzs0CZIK4ocaAadOImdqnxtRasg33tHtKdOaLnLWE+OqDfnlJpI9?=
 =?us-ascii?Q?jVf7m4m1uvQJ7OvoHY7XdvKwy6iUh4zrfAJ85QtlMpfsrbEUvP3v9BrBRSrn?=
 =?us-ascii?Q?3XiyqhpjSjN9m+26ecKuDNevgfzt5eVskrqAmbAab4E6cCZF8iUAwjVjsC0q?=
 =?us-ascii?Q?Qp2jhXIpQrOpSh8B6pR4S6HYOAbz1/xzMlbdtxAO85jZKTfiY4WcEIpHqF8f?=
 =?us-ascii?Q?RTyJduMoNDeqhoa1uCXzmgvmxBWRSJLsgkp9LsYoq00u31cKSHLzfk9Bn/AH?=
 =?us-ascii?Q?/BKA5qh99ZCe0p5wuVmD7ejtupBb/x8G1jpywOGfMTUlAM8NQeJhbZHIfw4M?=
 =?us-ascii?Q?fncekItBXD2zQ8IuXFGd7GKqvGOFIvcPSwoJLaaqwNqJJTPpVHHuaMW15iVT?=
 =?us-ascii?Q?Wsl1EGndblfi0oSW3aAA/7ZHBqZyhnSDGXERzirYRguuWIMKD7yrWUKVPf2b?=
 =?us-ascii?Q?L3xdmHk+20zTnypKxyq3WNKZoKMqY8C8uTuqW+eG/0nESE9ZIsNmHFf8iyHq?=
 =?us-ascii?Q?oSaV7I/05FfI4hZQoWJ719jem9gWPr6JIlYzIDvUrj8R0NizQpDdIjHGUo69?=
 =?us-ascii?Q?Nui+TedwDEjpaWwScGy0lcbOKIzubmguZ9mZ8uQXA0ZGcVIw22sGaqzDwpKw?=
 =?us-ascii?Q?q6O6CVL0ONsUUgb9UlMT7IcNodZ7Wto6e2+H1pw6yJuryw3+n4x1IbIL5STR?=
 =?us-ascii?Q?svu41Ui6vmoJpQkAHBg0biTyCDJb4dw+4y1yH31d9ZzTT/8JKwNnbH1z9yGw?=
 =?us-ascii?Q?UtOSFdU2xj1PlPeVn0slntxBi4/cNGcU3ad8ejIgDukY6GUbrqtDWFQgBsPS?=
 =?us-ascii?Q?F03NziZ8HoEC22nmsp+BIRTe69xBTm9remKgW5YqXns7dceqhDpjKLd7a275?=
 =?us-ascii?Q?4D2e7DdyRsKzEyRoaqMeawk07mKk4cu3KEjuk6ZSlkJgsVQMNwEH5Y9wvHYy?=
 =?us-ascii?Q?VViobb8vhHKFTF9mz3szGTktTh6RaYdzYPgqO/jkNu/1mWKlIx1xLQ/ex6TL?=
 =?us-ascii?Q?qnadEi9x2k6q6lwFbXiWds1p3AKO+Bv54SDKaDZawBXDpWrNnSehqvA3PjgU?=
 =?us-ascii?Q?7Wxd5OL+A+FRukeQLCQiRVkeKNWUznhPoXHtuAii9LjEwIVAaPLED7jikPY9?=
 =?us-ascii?Q?vXIhWtScw2AdfMScnwVGaljsGxmUdFMGQkdQYBL3VvJU4oQbnzspDXi7FsH2?=
 =?us-ascii?Q?eqyMPkQWVGydeqcQ7ci/FlQ+UXLCYqRnBMxDq3JR/X+8UNauVOu3sHaEK8Ze?=
 =?us-ascii?Q?zCBBQaYh83+ksBmQR9NTLtkVr5Hz6H/4WBE+5J6O2c/daVo22ixFl58FgF7y?=
 =?us-ascii?Q?zPx+zwk0spGVod8wH3VYww6Aqh7rmp7kmWnWtxjfP/3zfQQyX5K844A6hXSL?=
 =?us-ascii?Q?S/ju6R80VJUMpQ2OnnhWuJWykvDxejxlhj8LcKNHf//9sVtrsTL7VTD5Zt1c?=
 =?us-ascii?Q?o4INXE04nvf2cTNAw8mJDlBUxC1nPEqsYaxip2630DNutQqM3cEpqMF4vkkR?=
 =?us-ascii?Q?O65NHSe02iY1pt7wnNUgj64IlLQdIfyUhuTaX1tqk/zkJbzmZBsVaDkiLQlh?=
 =?us-ascii?Q?RzTaxavXy+B8dUVtXCsJIxupuXYgcZo2rrdf+MIp2cLWGwCEdiCXuuqgxxZ4?=
 =?us-ascii?Q?v4xqbGH1ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FVzKz4+el+9as3lDcFsIkpsVPex/eholvgOoupuOsQCHDYMU6j+ISMYurP1BvJLpcMr/DlNsio1GcTRS0icPjsvf/4JwqrW1Xygs+E9Jw1wPO+6uvtL8K4nFXH+XKX/XvAQfEn0BS+uI/rKxkjERZjRQ98mkQQ2oPTTtqLGli4h8W5kjvRoB8G4kL+oexIVGsnGhf3C3OlygPLS0PWr2qkWefHUBcP0o+61wrWrAaU91+crzCzsmEnThm6aRKCAzLYnqO55aSz1hQTAtkc74PdqfpLPCIva47tbLG3fKZHsI91wv2VhcuBkfcHpkE2c5rC/yr/yD+oC0gh6grgwBNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93bfaa3-615a-4bbc-4b19-08df12ed9b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 05:53:03.1514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yd+uRUz9joN4t3P/Ks+eYS0rs7Sm9C7MhxPypjjmHcslKwYy9vWr5SrmJpi11TEcXbS3Weibn7g2hPit7Tc55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
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


> Subject: [PATCH] drm/i915/display: Fix DPLL reserve and release reference=
s in
> kernel-doc
>=20
> The intel_dpll_state documentation still uses the former reservation and
> release helper names. Update the references to intel_dpll_reserve() and
> intel_dpll_release().
>=20
> Fixes: 2b3b9a8faf56 ("drm/i915/dpll: Move away from using shared dpll")

Idt this requires a fixes tag only for comment update

> Assisted-by: LLM

Please use the correct format check other commits
Should look like=20
Assisted-by: GitHub-Copilot:claude-opus-4.8
Or=20
Assisted-by: Claude:claude-opus-5

Rest LGTM
With above fixed
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>


> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
> b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
> index
> d408ccf6f9025667177e411e5c2cef72cc30aae9..cec6208fa7535ba77c203999bc
> 75b3c077a94a5d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
> @@ -302,7 +302,7 @@ struct intel_dpll_hw_state {
>   * future state which would be applied by an atomic mode set (stored in
>   * a struct &intel_atomic_state).
>   *
> - * See also intel_reserve_shared_dplls() and intel_release_shared_dplls(=
).
> + * See also intel_dpll_reserve() and intel_dpll_release().
>   */
>  struct intel_dpll_state {
>  	/**
> --
> 2.39.5 (Apple Git-154)

