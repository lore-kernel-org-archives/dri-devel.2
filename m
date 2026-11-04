Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585C606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GlEEstUP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A36F10E139;
	Wed,  4 Nov 2026 13:37:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A537310E139;
 Wed,  4 Nov 2026 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793799461; x=1825335461;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ju42YckGMBBu1rlWVDHVhRVnybmXY5hutJ7+cPRsW1Q=;
 b=GlEEstUPsM3rN9D1dL8bSqdQUwgCrH7UuiTDBkTQxTP4UaBQZ6ZoWXZe
 CA1h0Ax9crO0SWUUKSSDZIfIGxXswZIkh+OSbC8s7rff06G1GcCeK96Pe
 dk7+Uov9ZLatmA4GFMvinqTcgnRpm5yBj4XVLWodtiVFZf0FPNanNxJpa
 kxgxnf8Cf39S20/gqBQnLxzd02PpACGYRIWR7q1Iy8pb5cxs68iTknlYn
 BaKHS+/qIDYr4xIUxnlxiKMPWJQSEzPblKVbLoU4A9CuGAi9pM2wfyxN2
 0fhycUEPfiGpmi525SJ/2YVGTM184jD+m8lIC6sxhLe14B4KOIOww1GRj w==;
X-CSE-ConnectionGUID: /5Qyfs8ERaiNNPMXVG8fPQ==
X-CSE-MsgGUID: NhW3sNX/S62AHbz1Rs2zew==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2547108"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2547108"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 05:37:39 -0800
X-CSE-ConnectionGUID: Ml0SUn+xS5WzSTd0YJTRQg==
X-CSE-MsgGUID: ET9vxPE8S66Ih4XZPrhzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6769124"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 05:37:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:37:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 05:37:38 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 05:37:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo16KiEkz8O7rX1cv6bUJORLwmv8Ht59UJZJ0ctvXgJL8V8lYa6YN/MO9EYmWHOT+GPSWUuj49TXr/rm6hLb2oRnH4R61GTUoZm9Kpn05XOboZGcUfyL6vH4qnGquf3bf0DFdcJWidJjaBP7B0gqeg2hyKX9mcXWR1JcqEBJ02tkrayoJe2q6FHzHVEQ7Fy1SfivdU5l2qk7Jv81LgvXQz220IbxNijgRgbpeUG93Rv81Q7wVaKlur+jNiV58QkKJ1tJt3EBkwLGeODdR9ftE33ArF3nbCHZTu1/ERdac41VdGy7o9QyFmcakf7jLa91ciCS+V62ybWcSONXlzDc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuKqFBGf9oMTlULiMRvvlMhOKN/DcjLFmPrOnyo4VMk=;
 b=ZoSQKM4TLEHJWgY9vDYEMHYQ87K4CpsB6/SdT0+6ZuRYPkwOKb36juSbuo1ptdE7/BoRYFHLHsXP39oes4oDlwSSjtmj0zxNJUj+jGyZS8OVOsN3IGYI9I1MeuDDtTMIqk1tC5FMOKcziKRkWTCJbinHBLvui2lbEmtZBl7+vfr+p0p3muBre7LcNQBkWQ3wQcpbhWZGl0A2rc9IkEhIoREyuu8+gLzBttdInqs3vG3w6k17Yb2tmHEeEYrAyf1MM8S4LIg8Zl128UOa1f/T9GYJXefqRWgEXo0gi6eRUPEHs9RA9sw0DjsCmp12xJEhU+znQBwR03HMDlTS03iL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 13:37:36 +0000
Received: from PH7PR11MB6796.namprd11.prod.outlook.com
 ([fe80::60ca:3168:fb41:7ae7]) by PH7PR11MB6796.namprd11.prod.outlook.com
 ([fe80::60ca:3168:fb41:7ae7%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 13:37:36 +0000
From: "S, Sowmiya" <sowmiya.s@intel.com>
To: atipre <tipreaditya@gmail.com>, "igt-dev@lists.freedesktop.org"
 <igt-dev@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>
Subject: RE: [PATCH i-g-t] tests/kms_writeback: Check CRC capture survives
 writeback
Thread-Topic: [PATCH i-g-t] tests/kms_writeback: Check CRC capture survives
 writeback
Thread-Index: AQHdZSgWPJowqyDfok+LODOkX55xg7cd7ZXg
Date: Wed, 4 Nov 2026 13:37:35 +0000
Message-ID: <PH7PR11MB6796FA8DDA56651E65E018D2E5682@PH7PR11MB6796.namprd11.prod.outlook.com>
References: <20261025182420.52258-1-tipreaditya@gmail.com>
In-Reply-To: <20261025182420.52258-1-tipreaditya@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tipreaditya@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6796:EE_|DS0PR11MB8082:EE_
x-ms-office365-filtering-correlation-id: 2d54997c-243d-4760-3bf2-08df3a78c976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|38070700021|261022105027099003|11063799006|261102123227099003|56012099006|261026140227099003|261022075727099003|261028144727099003|261026121527099003|5023799004|261009223027099003|261021121427099003;
x-microsoft-antispam-message-info: 0qBlTJabaL7Uv8PqQNrfQzz9apr7+woued0mE64VVwC5k81wNnYMufwuOkhg02maUwtABAy7/9plu6L/nM+V78riksNscRcIx9xQIx5hzgYw/GKGjsqy2A4lftTrSj5xu7yyQI4iiD9ugEZNWEgoWKkx6rhj8zzZXNyGFbCtZ/Z0rHbo9jM3nwwT1OBtawwJXjmHCMSo5nawPJYTteSlg19AbH/J2jqDEIKXcAARRcoqvFSR91cY4WZZbshWCI+5xBoMG41w4tK4+3Eh/B0B0F7xmNqXZreWyw+TUo29rBpGisaAXUV7zOxnqJPUl9rDqINriAp2zIoUkLNn/ODcKDc2BJdNqg3/YlmEreRqnY7M4IEewCTPUxWloIE8/Z1g4TiryfpCCC9uBHB5TIhQyEl6H2PftpVVIyw0I6R5qGdeBevJUL8dnVOkvMTl4lRF8VSMo1NX+7M7KwYCJRjqsl1c88d6moeanfk+j3RQ0368DLejNi+g+8UCTAG673OAqfmv7ueA02Psz07o+nf+aIukKhnOaU9tfa0XhAotQM4WOEirUdwNP5Z95G2CP/sHbutmwX1KCXT2levZwkVTn1/V6dVpLuBiyJ9NAz+E0MW8FqdnI9i8Xg6sZKwqmHWXrWNs7/UL2aUbxndOAnIyEnPjarLFDgp4TIu4l+UZ5Li1Mg/rU2KOSgYeq3HIt+BkU02j0vMo0yGa/HaAyzmY50b1tW5lrz5ymO+HxaREicg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6796.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(261022105027099003)(11063799006)(261102123227099003)(56012099006)(261026140227099003)(261022075727099003)(261028144727099003)(261026121527099003)(5023799004)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yLGUd7LZOZ8HCzrBqRgZ7abTNw4jsgxo75TQCm29unVT1xkGrt+sGXgHkrl3?=
 =?us-ascii?Q?NuttPXBlUNsJCpb1QL8uwy/QovnhxJhkbcKV54Es3ZXm4LZ8E8HR60Gw/JNS?=
 =?us-ascii?Q?48L3uOlg04np/SWlsaQkizsIGlqHZNNq5BjWy5KATs+nmeDnG6eeymG+tdUT?=
 =?us-ascii?Q?FC4sP0mqBvweo6ytsO24U1+/T5xgWEeNvxSGAdFK2DxZn0+xfRR0tPH/pkfw?=
 =?us-ascii?Q?7RWueO0mXkfk94vBMDfIQzvEG2ldIxC5EXIZSYSCg3rE1mWtoiTnZARIOwlm?=
 =?us-ascii?Q?f4onlBmS14FeQMeH31KPeh1h9ggJWaSrNP9ob8c5vl2kYQ+uX3xms0oRxcJ3?=
 =?us-ascii?Q?1em80gLZcFSPw0Vi4RSxgfOnUEyAv3JWDWYY4aiOrziZdMRp8UGE9xyV6NvY?=
 =?us-ascii?Q?8AjyRjfrmmBV9ciSX6WkrU3dy4zc2QZRGpZyqJojfMcENQ/HGKISZnyjJ0n/?=
 =?us-ascii?Q?/u4/eWLnAdfe4Fiq7esJIKZHLR1/fvXhXqVQH+nQIgiek1/H9WCNswOTkjH3?=
 =?us-ascii?Q?veL2enPPTOH433S8MOBVvkpYcuOK5Jpm8ZBVDnTNDByi+9x5EvzhLCKsfHFx?=
 =?us-ascii?Q?V+aVYKpYJY2+plGHfUqvnaxXFeUSwpY25rBq7gXDRkRpj2rcvga5/ZyW6HfS?=
 =?us-ascii?Q?z+8KbHCGx+ne39jhi8Qrn3Ur/aaq09VKebfTsh3vyFTIcQ/5Rd42/sqAUnFZ?=
 =?us-ascii?Q?/WCK5+Pkd0U0w2sDHA30qnNizUowXfbrFCRjmcmWySOXbcbiiYStfUSH/pjD?=
 =?us-ascii?Q?XPmlCT4aDqaLIcd6jO0Fq1Q8Ilgv4scMbCRqUakDW6+QbTMD6MM60hyW8iYl?=
 =?us-ascii?Q?mpatep1P5LSott+s1Qq7yxojSay5RiM2cbRCXigT1BYfMT15j4l1cQb5Ncg9?=
 =?us-ascii?Q?cqeYIPCmVgyBz1/4RoBi2z6muHigjylcHPJ0enyCFvtbFG63bE4zB/aFn8Pl?=
 =?us-ascii?Q?WtoXJtZBILFJyV+yDs0iV75cxrxJCl901jJ5v3Hu5hJnGOJEmUzbi/lqQrLM?=
 =?us-ascii?Q?HseOdrPNf4zL8EsWoKY9eWKsFPQmUkzqTIUOKKc5ssu8HTTzC91t3Xz8FtcI?=
 =?us-ascii?Q?j4Th21NQPAf9ZGouwJaFLbi/g9x0Buwf7yt28WZnaTAbg3thY8IlpAj4Yke6?=
 =?us-ascii?Q?jIBTtC3596hLOZ7Cu5YioCSTrGJfufI5Ooo2IwgDGg1xgRwPEIXNMO0FIBgM?=
 =?us-ascii?Q?kz15kNB+wgkJpcIfyIQvmzwIPrebdzVJdhMkHKf5RUgzM0kwIkTBTUWNg/9N?=
 =?us-ascii?Q?Ull7VCF0AupLG5IBgo/1lm2G42wdlfjIpcfphdkExUMLFmGZD0yfzjHoevqK?=
 =?us-ascii?Q?ovkK4w1PNZQSRBFUl9+TJ7uoM3zkm7hFgaXsTaodeYwJ2OtoX5xxPEnLurQK?=
 =?us-ascii?Q?M/FspkP8ELJGdKGHKoD1q7Znpu1/puKYlCSWrKiNTrGR4rmv+XwCFZUK1w/H?=
 =?us-ascii?Q?MtYIyN6hbtdc28z/ono43iAexqUBE+CO6G5eJ5wlWdcWiZZ2hTbk//n8q0Ql?=
 =?us-ascii?Q?u8QlH9pELZ0o353Q207TdfiFT2gSwuJk676LvmMh3xRAuN9/MjyUGuNj4YBm?=
 =?us-ascii?Q?mnk3ZyEWI5qdIOnp1yRBU+Aue3Qy3UbgrUDcAU6iz+VP+8Zi42LWYo2oQzqT?=
 =?us-ascii?Q?jzj2N6+3vfn6ApHOsJ6wEDjm8i6wX8NyxOAXQ/jNw7BldRV+p5dIwFaeZyhx?=
 =?us-ascii?Q?z9URXmL4i5K2PF0SfkBPMXEpVL3nzlNuVR32KLF19DviSCN2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WGAsTefLYl1Ql6t6SFntNldjf4u4uEvgw6G219+u32mH3lsula6TxuDALxy7wPjWTAuqsj8l6MJLmrDY6ztBrTZhAIHLb+83Jv+jC1zuAx2gAuyQbuQOGEWZvJ39gpEZrB3h22O67hjoKsNUx+R8RGnwzbAKPuFX3O4L8dvQddOUJPo+y2Sc9yIP8GlXIN5+h4SAltVt28Xa4Spls92zAaQfnLu2sfDnolMJ3T82I7zuAr+LvbAER2O86yDYRfGln6MnP/fXkrbMx1Zxlywnqeuo9HugQlsNXZhSNAL9vGurljOSqy715ko0QZNrz9qRhrhpWZen6iS9zU5krS1SjQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6796.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d54997c-243d-4760-3bf2-08df3a78c976
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 13:37:35.9697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x55BYnT8fA1MGSwENHyoNDvXEj2lonlv3XVhZfaa7UijHt5IVtgk8WNsYy//yJaGJmqkbjXgey/PNQo9Of9EiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi @atipre,

> -----Original Message-----
> From: igt-dev <igt-dev-bounces@lists.freedesktop.org> On Behalf Of atipre
> Sent: 25 October 2026 23:54
> To: igt-dev@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; louis.chauvet@bootlin.com
> Subject: [PATCH i-g-t] tests/kms_writeback: Check CRC capture survives
> writeback
>=20
> The existing writeback tests validate captured framebuffer contents, but =
do not
> keep pipe CRC capture active across writeback completion. This misses the
> VKMS bug where writeback cleanup disables the composer while CRC capture
> still needs it, leaving subsequent CRC reads waiting for samples that nev=
er
> arrive.
>=20
> Add writeback-preserves-crc. Complete the initial modeset before starting
> capture and establish reference CRCs for separate red and blue input
> framebuffers. Keep capture open across four alternating writebacks, wait =
for
> each output fence, and compare three fresh CRC samples with the
> corresponding reference after each writeback. Use atomic updates without
> ALLOW_MODESET once capture starts, and release capture from the final
> fixture so a failed subtest also closes it.
>=20
> Check output fence status in the shared wait helper so a signalled error =
fence
> cannot be treated as a successful writeback.
>=20
> On ARM64 QEMU with one and two CPUs, the new subtest fails on unmodified
> mainline and passes with the local VKMS composer-user lifetime fix. Four
> existing applicable writeback subtests pass on both kernels; the two
> XRGB2101010 subtests skip because the format probe rejects them.
>=20
> Signed-off-by: atipre <tipreaditya@gmail.com>
> ---
>  tests/kms_writeback.c | 62
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/tests/kms_writeback.c b/tests/kms_writeback.c index
> 7c30e8e..71317cf 100644
> --- a/tests/kms_writeback.c
> +++ b/tests/kms_writeback.c
> @@ -64,6 +64,10 @@
>   *
>   * SUBTEST: writeback-pixel-formats
>   * Description: Check the writeback format
> + *
> + * SUBTEST: writeback-preserves-crc
> + * Description: CRC capture remains active across completed writebacks
> + * Driver requirement: i915, xe, vkms
Xe doesn't support writeback. We can't test it now. In future, we can. I ho=
pe you didn't tested it on xe.
>   */
>=20
>  IGT_TEST_DESCRIPTION(
> @@ -317,6 +321,7 @@ static void get_and_wait_out_fence(igt_output_t
> *output)
>=20
>  	ret =3D sync_fence_wait(output->writeback_out_fence_fd, 1000);
>  	igt_assert_f(ret =3D=3D 0, "sync_fence_wait failed: %s\n", strerror(-re=
t));
> +	igt_assert_eq(sync_fence_status(output->writeback_out_fence_fd), 1);
>  	close(output->writeback_out_fence_fd);
>  	output->writeback_out_fence_fd =3D -1;
>  }
> @@ -537,6 +542,7 @@ int igt_main_args("b:c:f:dl", long_options, help_str,
> opt_handler, NULL)
>  	igt_output_t *output;
>  	igt_plane_t *plane;
>  	igt_fb_t input_fb, input_fb_10bit;
> +	static igt_pipe_crc_t *pipe_crc;
>  	drmModeModeInfo mode;
>  	unsigned int fb_id;
>  	int ret;
> @@ -709,7 +715,63 @@ int igt_main_args("b:c:f:dl", long_options, help_str=
,
> opt_handler, NULL)
>  		igt_remove_fb(display.drm_fd, &output_fb);
>  	}
>=20
> +	igt_describe("CRC capture remains active across completed
> writebacks");
> +	igt_subtest("writeback-preserves-crc") {
> +		igt_fb_t blue_fb, output_fb;
> +		igt_fb_t *colors[] =3D { &input_fb, &blue_fb };
> +		igt_crc_t reference[2], crc;
> +		int i, j;
> +
> +		igt_skip_on(data.dump_check || data.list_modes);
> +		igt_require(data.supported_colors & XRGB8888);
> +		igt_require_pipe_crc(display.drm_fd);
> +
> +		igt_create_color_fb(display.drm_fd, mode.hdisplay,
> mode.vdisplay,
> +				    DRM_FORMAT_XRGB8888,
> DRM_FORMAT_MOD_LINEAR,
> +				    0.0, 0.0, 1.0, &blue_fb);
> +		igt_create_fb(display.drm_fd, mode.hdisplay, mode.vdisplay,
> +			      DRM_FORMAT_XRGB8888,
> DRM_FORMAT_MOD_LINEAR,
> +			      &output_fb);
> +		fill_fb(&input_fb, 0x00ff0000);
> +		igt_plane_set_fb(plane, &input_fb);
> +		igt_output_set_writeback_fb(output, NULL);
> +		igt_display_commit_atomic(&display,
> DRM_MODE_ATOMIC_ALLOW_MODESET,
> +NULL);
> +
> +		/* Finish the modeset before starting continuous CRC capture.
> */
> +		pipe_crc =3D igt_pipe_crc_new(display.drm_fd, output-
> >config.crtc_index,
> +					    IGT_PIPE_CRC_SOURCE_AUTO);
> +		igt_pipe_crc_start(pipe_crc);
> +
> +		/* Establish both references before writeback can affect
> capture. */
> +		for (i =3D 0; i < ARRAY_SIZE(colors); i++) {
> +			igt_plane_set_fb(plane, colors[i]);
> +			igt_display_commit_atomic(&display, 0, NULL);
> +			igt_pipe_crc_get_current(display.drm_fd, pipe_crc,
> &reference[i]);
> +		}
> +
> +		for (i =3D 0; i < 4; i++) {
> +			int color =3D i % ARRAY_SIZE(colors);
> +
> +			igt_plane_set_fb(plane, colors[color]);
> +			igt_output_set_writeback_fb(output, &output_fb);
> +			igt_display_commit_atomic(&display, 0, NULL);
> +			get_and_wait_out_fence(output);
> +
 This drops DRM_MODE_ATOMIC_ALLOW_MODESET for a WRITEBACK_FB_ID commit.
  Every other call site of igt_output_set_writeback_fb() in this file
  (do_writeback_test(), writeback_sequence()) and in kms_colorop.c pairs
  it with ALLOW_MODESET, with no exceptions. igt_display_commit_atomic()
  asserts on a non-zero return, so if the kernel still requires
  ALLOW_MODESET here on i915/xe, this subtest will hard-fail there for
  reasons unrelated to the composer bug being tested.

  Did you confirm this commit actually succeeds without ALLOW_MODESET,
  or did it only need to work on the vkms config you tested against? If
  it's vkms-specific behavior, worth a comment explaining why it's safe
  to drop here when nothing else in the file does.
> +			/* Require fresh frames without stopping or restarting
> capture. */
> +			for (j =3D 0; j < 3; j++) {
> +				igt_pipe_crc_get_current(display.drm_fd,
> pipe_crc, &crc);
> +				igt_assert_crc_equal(&reference[color], &crc);
> +			}
> +		}
> +
> +		igt_plane_set_fb(plane, &input_fb);
> +		igt_display_commit_atomic(&display, 0, NULL);
> +		igt_remove_fb(display.drm_fd, &blue_fb);
> +		igt_remove_fb(display.drm_fd, &output_fb);
> +	}
Minor: blue_fb/output_fb are only released at the end of the subtest
body, so an igt_assert_crc_equal() failure inside the loop above (the
actual failure mode this test is meant to catch) will leak both FBs
for the rest of the binary's run. You already handled this correctly
for pipe_crc (static + unconditional free in the trailing fixture);
might be worth the same treatment here, though it's low severity.
> +
>  	igt_fixture() {
> +		igt_pipe_crc_free(pipe_crc);
>  		cleanup_writeback(&display, output);
>  		igt_remove_fb(display.drm_fd, &input_fb);
>=20
>=20
> base-commit: bb76404eac7032ba85c53eac15b76e4fadaff0de
> --
> 2.50.1 (Apple Git-155)

