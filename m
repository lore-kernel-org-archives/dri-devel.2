Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14BBC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D5D10E14C;
	Mon, 10 Aug 2026 05:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AoHFh8hD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AD010E038;
 Mon, 10 Aug 2026 05:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786338947; x=1817874947;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FN0eLzFd7yB9YmauuSXINfHMj/Y4AdBZ6hJ4J50iHFk=;
 b=AoHFh8hDzN8hxqB3sWXcHWZfu/S670YKJDD3u/6FzM17UvMByxMF8Hqa
 ZfL+umtiwVLbdjIyW9N/mVJEkpTTZtlUXtzhnzsRAtlev77CVWJiNkyY4
 OGk15L0+C5CAp14hDyga7cLrjamwbnvvQfMn/2QiNCFEEMiE98934qCat
 yImQf96TAM7EinFn+V5NqHb4yNMOwxLTfOXKeoJlRoNZKY1FvxDfsIAkC
 4i18IqbrXNQnjurmlbz28zhK1g0ypbxa1PD8MLFUPvmkBxXjeiIm1El87
 G0CxOHVbJETU0V5KapTJtnGyPPF/MJkGdULrJwQl2350k6eKnaMbS67Re Q==;
X-CSE-ConnectionGUID: fIhbL3Q7TxOjNwKqz3SYjw==
X-CSE-MsgGUID: VIUpegHmR3CfRsF8beTzVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="104236885"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="104236885"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 22:15:41 -0700
X-CSE-ConnectionGUID: GCx68pmjRU6ndP27sz9Yng==
X-CSE-MsgGUID: Vt+1TYsFQWG3C8To2/pt6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="266789465"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 22:15:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 22:15:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 22:15:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 22:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX14Jl2gJtLxFnhGRw/wEj2TdFkic3hkVsrSFtGm8rQduhBaMY8oijd31MIGk+/FpF/Hl4uqxI9rUbEj4TqSH9NVF7BnUQdUWUfKEETyf39UjDw9eRbLffQ0fUTkNkgLymbF5mo8C8x5sXyK4v+bE0BwY6JO1jcCRer7d2iM3s2xXEEijp21QAE4M/diBTr4xBCA4/voZfHI28I1N6Gh0bMKXnOFzCmzxo69zfZ1wZycoT/h7/1MWDphSER/WFRvGNt/66wsVhan418Qfx61Gv9rkyGgxqqJvoJ+Q3oj/EpKCVR7gqyAcdqBQvDXWW0KSpLQanCS1kKb2sYVWwJKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee6O5Wp6A9WQTW7eJ93ZeAN0DSx4UseNvg+eguPkr+w=;
 b=SD4hsQEaLNWrHBr1/Cnfqxq58C3hgLCIdiaMuZDSilSIphoOBAt2BWQaHJE5D0In0XtQUmc/jxvg5Z/dqFR7jtnIFViqKdTDl/NoP4a0z37Cgo8XhEBYGh4+YnDwPdPTOV2v0EOtXyzXWeKTH4ZaqcRnYeRaopJcs7fQl5dr9vUilDWZunwXHa9c9AxPC23Ao9z+uej24r2dwvfK+J5Z1nXg9s5pZF5GkiMuBQc6hjAQqZBScrJ9PaAeg522EU8v4RcIMDzY9VacLoPMZm0aaJQka5qYjJNwr4h7CXQG9qyfsTPXkojCIIF2i/i4Bc2tSh2FeuIJVor5i6p+8nZ1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by PH7PR11MB7146.namprd11.prod.outlook.com
 (2603:10b6:510:1ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:15:37 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 05:15:36 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, "Nautiyal, Ankit K"
 <ankit.k.nautiyal@intel.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/1] drm/i915/display: Add quirk to force backlight
 type on some TUXEDO devices
Thread-Topic: [PATCH v4 1/1] drm/i915/display: Add quirk to force backlight
 type on some TUXEDO devices
Thread-Index: AQHdJqhlIZhAapHlg0OOGBbOOXMHEbaWwMYQ
Date: Mon, 10 Aug 2026 05:15:36 +0000
Message-ID: <DS4PPFE901A304F2015FECB30801D611C79E3DE2@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260807200709.464343-1-wse@tuxedocomputers.com>
 <20260807200709.464343-2-wse@tuxedocomputers.com>
In-Reply-To: <20260807200709.464343-2-wse@tuxedocomputers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: 84bc67aa-1278-4448-1840-08def69e6965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007|38070700021|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: qhBGCwC/k3DjQmlTaJdEpXSGuB8HQovfVMTYrgEkvCNt95j5Xa9KFHViVtuM+RTOJvomDzyzpJiTfg4tf63DZusVqyqwOt5Fsz5iDAcTn/INVnnUv10LBecBCrhXtHtapen1xc4DFw1zj7K+H7wokxyOBQXNUgCpSLzmYPF7hKEzBoMMtJJ2LehkawWWVda1AUjLKozxSAnQ/+WqPIERl3ltXJ4LU8BwEuOQ/4tez2HRk3jZpHj94TOf+wYWs4ZgZ6s8dY7LK3DH+JyoFo/5SqDcf8yKCu8zSCVNjBB2rV9eucrCOqrpAxtAGYtBQzJD7W+sojZNVXRev4CRmN0QDJoy5mqU5r1jOvw1JlE6ixWBOBFKNyGLRsjxsc48sYpmNwJMmd/1PefmcKQj1iMm00PdVFMZ4ddxJjdM+FFekLZBXfwXDB+5s4V0G1nk3+PnMakCKrz1bR+9EYHL8idKZn+MFqm9gq2zoBfHNEt05IaayAMhi+TIxJ7txLsOwNpTbFr+9wexdvbHey9Mx1uIGPxZRh41wpxuPfPzJLW3DEKueyBYdebcOiyCoDXG6iHxSWW4ubxz8c6z9FlbRh2wuBkRwRNj6eOxzd8ZsjeVYcZmZj6XySTF9JIPyzZWHe3TjWuIyWcoBYxF4MiIZfWlpfiPhaRrBXPVjXQNJKvho4Uak+YXPadk94IzU7i4rPJmaJuS6Ip7QGYYT2Xas3X9JU+XrsXN4wR0Fjq/d0f7M0aRGp6yWU/wMQgSsnTgFV60
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(38070700021)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uwaBnRxvJGdrcyU0SFWxTAWGLf2le1rQzvhkJDvyBSZLmglrJgKXwmRAodfB?=
 =?us-ascii?Q?PZ6fbKz6EUcMNb3IkjrZc2Dr6phOHXdcHTbnbuWJI3gZAW7WKmSM8yFXdOfv?=
 =?us-ascii?Q?oCPKoKOPkFow4idwITrAeDvkUbBHKfJxCG2QJVdquz+dSXWc8iWh2l0Agop4?=
 =?us-ascii?Q?QExVDngMNIF4JiNqXBlHKRTcnCOhUODMJAoKzzByG45Xaiu/HAS9dY/X2mhw?=
 =?us-ascii?Q?dtCl5ekbAS2FCkg7JOukozxyvhyh4hrqskN/KlSk45pcqwAkXB3LVTTh9TAd?=
 =?us-ascii?Q?BmBDpfrl10Kw7EKXo65VQXq0WsCCwsLsyE68Hus0+klzkprSQQ8sZiyf4tz+?=
 =?us-ascii?Q?/gaaW+ZMR848VFoDPm1MH3jiPU91zw5KYSuHLNaNjGkpaYKBD+Iea39i3EL1?=
 =?us-ascii?Q?B4bDNpJr7eUGA99RbPiJ4AAa9TUhf2nbQJdsdrEA0ft2FzeYIVzExc60hCiB?=
 =?us-ascii?Q?IIFHbKAPp5MNP3m3szI5rtxufkwHq7sdWgKhLDKQ+JHy3aPLl6s59zLxZMGD?=
 =?us-ascii?Q?ZSZJk8pyu4Z8VU94sZV2dbBux9l1hjikZ56c8emPPLIOC1zvdwzikIgh2zUK?=
 =?us-ascii?Q?VQMYwd4j0eVZHXBYjJ58VdvvVGWIFNoOsna/fL8J3ISFMjvY/U3qCFRswQ/H?=
 =?us-ascii?Q?7oYzgNbyw+tnL0t9N845XRmvH28Qc9i/AQf60r+igzS05G4Ne4K1aPEIUQPx?=
 =?us-ascii?Q?pT2cfZT04p3Gzrwzt6vWpjlkQtqI+T9GjdYwSIgOcjNGqgVx1XSABZurSkq1?=
 =?us-ascii?Q?+GZnwpxCkewPt63yNfpZoSYao5nIjBksBVNj7KVJ+4MGxhon4O2ffdsFJnuV?=
 =?us-ascii?Q?zqNGQkGV4MEr16KVE6XNwBmyhS/nqcMz3dv4zcQlH0Puwq65+eY4I/LzZUIA?=
 =?us-ascii?Q?37TdTtiCMcXLrEEpuK6JSxerukkf7bvxQZG9gY3aAkCYiGPpCXO6da2gH29/?=
 =?us-ascii?Q?HPJ746GvCCyncrMCcuyj0JI3ccs9GMeywAcaMY5Jk+BOeiC2Akq+GxEukmjg?=
 =?us-ascii?Q?2iwVDULwjTj6reS3TPPEompJl48361uBiiGutJ7Bxsrdd/dRILv1Jp/6NykQ?=
 =?us-ascii?Q?vV6NIr00M4OlH90F1QUPjxMaNlaYlprgQgaPxmXNJZxpx13/9nB76nX75NDB?=
 =?us-ascii?Q?LtA7zv+aGSpuhcikWo7YKV55rNENkqgsIBoDR7Y31ulf6+53WJOpnMTwhzHU?=
 =?us-ascii?Q?sBWkB4SO64CEMK9Nn+3JojCV/xFKS6hApkmHHh3DLamNCeGlCbuFD8MEM5h0?=
 =?us-ascii?Q?aTZ9UpADHtM6vsNYJOlC288nrmjqBBlcCRt9WHoVX/Fk1DpDScReWrf47uak?=
 =?us-ascii?Q?dOLpbLUXD8kpzK7fu1TZ03f5h4LUIQpbJJkJfgM+8l0efQDA3IUhRvXiBgVU?=
 =?us-ascii?Q?2F/phs1BgKZgOsWXxMwBhYTuImK3LHe9upM+j+it7VrqqtaZ6MfqjWFU1GOG?=
 =?us-ascii?Q?ntFSUyZ+3A7OBmhgzcEW1KuFEquS9bgl9XQqwgkO+8I2qurH+47CrheFOVO0?=
 =?us-ascii?Q?ERexhdnZ5rg5Hvy7FMS4pj+1BNWDiN5Es8ekjK94bXmfQIVAl6Retx/o/la5?=
 =?us-ascii?Q?val1G0q+sOmqDZZ/hMA8zlfEJ2E9kLqycSTdNfbVW/5+zeMoPV98dIHvsMz7?=
 =?us-ascii?Q?RoNVsEwXiOLpOPV/m8V1NlYFKNGEL/7R/McNbiEAW02PneQ5Nz43RZgHswqF?=
 =?us-ascii?Q?HXVdWxsxGWa0YEocdCOjk8wZEx28QesTxa5COe1KPRgJccCGifCn8GmfD7mx?=
 =?us-ascii?Q?65AsyEn7cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RDC3HjwSuF0LSs8fq7jymuS/uZMMcqc3qH8hKSmw50siqA9B/Vw4uzCjQByUprAJ2izFo+JL2kZrR88XCXOFYWXn0m0t+07CJ55xQpmSMaWs/BOG/FygdGp4PK36OpdQQ0/5UTTQW+Z9If/biZvME6tn4ujT51b9xcDkbzChZ+58UbBs8OjEXKhm/atI8Dsc5IyDZwQg6muRgEBqE0NClPi5lZo529vbC2Tq6ez4FMUoQXgtyaZku2zU2ITItntrctZyKkGEv3mBgeMnz+mpuPrL86A2zJJFo+n77od0Qeqp/iWE+SzbJszM81AqSwOePxw+ckFx4Y1h+QIioR8LZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bc67aa-1278-4448-1840-08def69e6965
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 05:15:36.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhsnCDyTanTl2bhscJOG9CVGszw770iQOE8jjrh0GXz2cAh0aSxaWyjGdMkynlEOAv2qgqrRBLuvjQSnE0E//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
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

> Subject: [PATCH v4 1/1] drm/i915/display: Add quirk to force backlight ty=
pe on
> some TUXEDO devices
>=20
> The display backlight on TUXEDO DX1708 and InsanityBook 15 v1 have a brok=
en
> VBT in the AUO 12701 and AUO 12701 panels, but not others. They are
> advertising INTEL_BACKLIGHT_DISPLAY_DDI, but are actually failing to use =
the
> Intel interface. Adding a fallback to the VESA interface gives these devi=
ces a
> working backlight for both the broken and non broken panel VBTs.
>=20
> Forcing the fallback can already be achieved via a module parameter, but =
this
> patch adds a quirk to apply this by default on the mentioned devices.
>=20
> This patch does not actually test for the exact panels as the ID that is =
used in

We don't refer to the current code as patch but as a commit because as soon=
 as it gets merged
It's a commit. No need to send the patch again this can be fixed while merg=
ing.

Other than that
LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> the intel_dpcd_quirks list is sadly zeroed on the devices, but afaik all =
these
> devices use try_intel_interface first anyway so all the quirk does is to =
add the
> fallback to try_vesa_interface, so the behaviour on the devices not needi=
ng the
> quirk and fallback should functionally stay the same.
>=20
> Fixes: f30fddb44023 ("Revert "drm/i915/backlight: Remove
> try_vesa_interface"")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  .../drm/i915/display/intel_dp_aux_backlight.c | 22 ++++++++++++++++-
>  drivers/gpu/drm/i915/display/intel_quirks.c   | 24 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
>  3 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 266e042e00237..d84def79c4bfb 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -41,6 +41,7 @@
>  #include "intel_display_types.h"
>  #include "intel_dp.h"
>  #include "intel_dp_aux_backlight.h"
> +#include "intel_quirks.h"
>=20
>  /*
>   * DP AUX registers for Intel's proprietary HDR backlight interface. We =
define
> @@ -687,11 +688,30 @@ int intel_dp_aux_init_backlight_funcs(struct
> intel_connector *connector)
>  	struct drm_device *dev =3D connector->base.dev;
>  	struct intel_panel *panel =3D &connector->panel;
>  	bool try_intel_interface =3D false, try_vesa_interface =3D false;
> +	int enable_dpcd_backlight;
> +
> +	/*
> +	 * Some devices have a broken VBT in some Panels, but not others,
> +	 * advertising INTEL_BACKLIGHT_DISPLAY_DDI, but actually failing to
> use
> +	 * the Intel interface. Adding a fallback to the Vesa interface gives
> +	 * these devices a working backlight for both the broken and non
> broken
> +	 * panel VBTs.
> +	 *
> +	 * This fallback can not be made the general default as this has broken
> +	 * other devices in the past whose VBT correctly reports
> +	 * INTEL_BACKLIGHT_DISPLAY_DDI and whose PWM path is the actual
> +	 * backlight control, but whose DPCD optimistically advertises
> +	 * DP_EDP_BACKLIGHT_AUX_ENABLE_CAP /
> _BRIGHTNESS_AUX_SET_CAP.
> +	 */
> +	enable_dpcd_backlight =3D display->params.enable_dpcd_backlight;
> +	if (enable_dpcd_backlight =3D=3D INTEL_DP_AUX_BACKLIGHT_AUTO &&
> +	    intel_has_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT))
> +		enable_dpcd_backlight =3D INTEL_DP_AUX_BACKLIGHT_ON;
>=20
>  	/* Check the VBT and user's module parameters to figure out which
>  	 * interfaces to probe
>  	 */
> -	switch (display->params.enable_dpcd_backlight) {
> +	switch (enable_dpcd_backlight) {
>  	case INTEL_DP_AUX_BACKLIGHT_OFF:
>  		return -ENODEV;
>  	case INTEL_DP_AUX_BACKLIGHT_AUTO:
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 33245f44c0d50..89d82364ae45d 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -100,6 +100,14 @@ static void quirk_disable_psr2(struct intel_display
> *display)
>  	drm_info(display->drm, "PSR2 support not currently available for this
> setup, applying disable PSR2 quirk\n");  }
>=20
> +static void quirk_enable_dpcd_backlight(struct intel_dp *intel_dp) {
> +	struct intel_display *display =3D to_intel_display(intel_dp);
> +
> +	intel_set_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT);
> +	drm_info(display->drm, "Applying Enable DPCD Backlight quirk\n"); }
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -286,6 +294,22 @@ static const struct intel_dpcd_quirk
> intel_dpcd_quirks[] =3D {
>  		.sink_oui =3D SINK_OUI(0x00, 0x22, 0xb9),
>  		.hook =3D quirk_disable_edp_panel_replay,
>  	},
> +	/* TUXEDO InsanityBook 15 v1 */
> +	{
> +		.device =3D 0x591b,
> +		.subsystem_vendor =3D 0x1558,
> +		.subsystem_device =3D 0x9501,
> +		.sink_oui =3D SINK_OUI(0x38, 0xec, 0x11),
> +		.hook =3D quirk_enable_dpcd_backlight,
> +	},
> +	/* TUXEDO DX1708 */
> +	{
> +		.device =3D 0x3e9b,
> +		.subsystem_vendor =3D 0x1558,
> +		.subsystem_device =3D 0x8500,
> +		.sink_oui =3D SINK_OUI(0x38, 0xec, 0x11),
> +		.hook =3D quirk_enable_dpcd_backlight,
> +	},
>  };
>=20
>  void intel_init_quirks(struct intel_display *display) diff --git
> a/drivers/gpu/drm/i915/display/intel_quirks.h
> b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52fafc..4996419ae76bd 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>  	QUIRK_EDP_LIMIT_RATE_HBR2,
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
> +	QUIRK_ENABLE_DPCD_BACKLIGHT,
>  };
>=20
>  void intel_init_quirks(struct intel_display *display);
> --
> 2.43.0

