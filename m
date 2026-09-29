Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8047CCA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B314E10EDC7;
	Tue, 29 Sep 2026 09:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DWRl6IIx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0BF10E038;
 Tue, 29 Sep 2026 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790675828; x=1822211828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=e1oGCRQo6Fq5cY1kxM7DQBqmbXVi17hFNHv+yC0xC00=;
 b=DWRl6IIxvMJbzqaPAW0HHRfKCaL8aS5W+13l7ZSch/0jtDCIGoqeQkVX
 HlzEwQ/VEKlDkGHogh4DG+Fw10VE+4lT420iXrl8pWflQ+jpFOgshW1lU
 fkMVjHZLFbgs7diMA+cwSWywqtIoIwFfnWyr67Mfa7InrT9KkXHYTNtWw
 mOTdPb1JRDY8xSmgq0jKHDdjHat5isrDHVOoFUXy5/ZLmOGNeA/ikZKrj
 NGee7p4fbTpEgrQITKmqUIPTCdxgA3g5NRCk4YpKypvF8mohTPAHrlYke
 05ohK6CzYPkrF+bkTQplOkq2sAk7aabnTtqPGdZnBH5BJREB0VaQZvYEA g==;
X-CSE-ConnectionGUID: AQKpLxMQSaqM1b5FB7CrFQ==
X-CSE-MsgGUID: ImVFF/eLQR6rHtl3ZERDVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="78955970"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="78955970"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:57:06 -0700
X-CSE-ConnectionGUID: 0At6yYYkQ2ClKzjiVHBNmw==
X-CSE-MsgGUID: 2hbcz0KoTGa/g9WnOwsMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273936763"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:57:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 02:57:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 02:57:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 02:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duud06kO0dsZz/gw6BcvwdaZTEvuSkkIR55Wslw3wnW/LQbDxF0h+u5z674hUOa+t0/Fzc4sikVBVhqZc13tLABqCeZ2LQShTJKP5HuxLEarO6bA69s+xe/Eipg6YJPvPu8Qk9egGFiH1t6P9WwRQ6FTL1sQexd8SmmzqlQOqCWIHS84UJqiG2EunM+OvctIIJrcAW7PkBqK8mzqOfz2ihSCnKVHRpi8pfYtRtJzHQ9bGp/+25WFOKbORwhVCOI/hpDOAysAUikA5Y97VaxNRayyvq8khZ9FiJSHnIYQcSz23TK2m/gWGCRfndkvfFgzwn5OzD2Y3yjLZydIcOCcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1oGCRQo6Fq5cY1kxM7DQBqmbXVi17hFNHv+yC0xC00=;
 b=jwE8+XKASrQfk5LUruPumU6ixTuvIfiN+7UkzLBnAp+R8g2WbV15YGkJygkiLLsIYYebeQMll+EoD0+dlDBf8iERTJ37uNsCa5eVflsEKR7VIyWxrvLbGzjR0PKRCa/YBNhAyZxsskxQiMxpx12fSp9Jrbf6agtFf2/D+8fqdM+fjv4sNf3MGJo0YIVeoUrYuMYSfqqujtkRGgb/F5FLjlAnKmnxx2edEYwjrbDl8kmZESdyk9vpKRA+0pvC+DYdUoKuHPS+cbCbwNHpJkBEMosmkiGBFkWGRh0ZLoXvyRUT9bk7WvAynVbF5Eh3HzjDpdeHxxkDQEDKinCy+cSUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 LV0PR11MB9815.namprd11.prod.outlook.com (2603:10b6:408:385::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Tue, 29 Sep 2026 09:57:03 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 09:57:03 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 09/18] drm/i915/alpm: Half LFPS cycle calculation
Thread-Topic: [PATCH v6 09/18] drm/i915/alpm: Half LFPS cycle calculation
Thread-Index: AQHdRUGP24zcFnTmXk2YRf/Bsxd9eLblZzuA
Date: Tue, 29 Sep 2026 09:57:02 +0000
Message-ID: <a3dda942e0e21afa02930a584a19e1318a31556b.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-10-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-10-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|LV0PR11MB9815:EE_
x-ms-office365-filtering-correlation-id: 60753c77-0f7b-4e74-04b5-08df1e100323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: KFBRZXXsYAgQJJ1vtgOhg+rFl3EYB1v1tqaMPvl10LYpsiFeRO7cAVZfhOJ14rpsAkU4ohHexbyFtbgp6XSLAxc1PdEhVLShW0rrO8ks/bpmQeKPGUjKhHXgiMyKNRHgO9HaPFTNBHQCZrq2QZxNOE2HP5pKcMuMxzeVvnwbx9YjIySGCOgFVn8LVepM3JdGGjafFKLRy6l3+CGV/jMXj1q17k1JcYO+H1UqCVHUF7pEsgFT5X9zAIcA+QaYYSYjRDBh0wi/ItElG8ShQNFVyztzCKrlq0/acwoulfuH/W04TIYdhYkU1EuP8DYSlsWsVQEWQGsYkJ42MVOtoI6TzSLUX2VWiiGAwxzsVKlReQOGbHo/iMkEdQP62JE9hbUz3GI6Syfi+oVZP97JnHNux0QJQUGJC6duQnQz2iFErGb3a7JwhWRwXUQMs8ydqn6WiDWJlZr2apMtLPlQqSqpP6icCCJGSiYfDH8TG49/PkKfouZMu96ecVIy37evSAQMLOcYcvzmjO2oRoWOC8wga05UBIgh9gt6xbU4nw2e+P2UcU+wq9tBMrik/5u/WMd5JVbXDd528+oeCNZ8LiyESytqf6xrJbmlWK6xMvg6ThpU2HVCDNaDY28akndtz1U/fWLW4yFWRRwgeafbYFx2v14zW3wIkblkUOwcYKpoFxaMxBWrVTCUDtN+w/mymDJ2v9Tn/zhdWzrwlMaHqyKCs2tRxxfAibwGeBNpw7GYudo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnBXdWJmcjN1Ylo5ejBhWlNkRGkzNHd1dDdYSTdVMkt1WEwwU0xmOVNRUDFO?=
 =?utf-8?B?eFVKeGRsYm9wa2hnOFRidDhVUy9ZK0JtRjdXVGRSWXE1Nk9McmJYTDZia2tq?=
 =?utf-8?B?UnlPb1VNTkZkSE1hRWIzZSt1elhnYXNEMEpqU2Jzd25KanBneHNZcVJ6N0hR?=
 =?utf-8?B?RnJjQ2RkSXM2SHFRckg2Q2tNVTh5S3pVNXdMQ1ExWGl2RGZHQVJZNzJnclNE?=
 =?utf-8?B?OGI0VkVWZjhNcE1hSGtkQW1XL3I5NWEyUXh4ekwydkVuM1FPRDFyalBpeis0?=
 =?utf-8?B?TnpKWjlhY1U3eCt5U1QzM2lURVJ5NmM1T0dWYmRZWnY5NzlhQ1lsSXRsck9r?=
 =?utf-8?B?RTBIL0VtRnlXRWEycnF2bEtqbWdCTmd6Z0lCSzI4cC9EcFVnbVBMTklwUm9G?=
 =?utf-8?B?c21pQ05HcXZaVlFlQlpVS3k2YWJWMkdCbWhPalg5Q2hwTkl2QVNKSFhja1dR?=
 =?utf-8?B?UnNmT250bmNyaFdHN2RtYkMrNVdTZURCcHZ2Yk8vRVB3WjB0ajVQTjRwMi9n?=
 =?utf-8?B?Y2JXSlgwVEI0WVFIWkE0VUlUSmVZK1Mxb2krbjBuQiszTkM4SWFYbjhIUlRw?=
 =?utf-8?B?L3NBeTNsd2UwTU5LVXUvdUVjcjVCRWVUZVpGeTM2NUNTTExBUEVudURiYzZZ?=
 =?utf-8?B?aEZxTEdGaHEzc2poL01TT2ViYVJPOXhjUGdlOURQSkplUDF4aUpFN3Y1cnRU?=
 =?utf-8?B?cmhOMHl4RTZycFUrU2ZoUE9KRCtqYnA1N3h0YWlTeHEyTFh0dGFyTW5NeEs1?=
 =?utf-8?B?OS8vVHErZk5uMUNsZEhDYlNneUd1TFJGaml2Y1lNeG9KVkNIK2tQSWw5UnZR?=
 =?utf-8?B?bE16c3FzVmd5YldyN3FzY2k4bGxOZ0wxU0tiZnh0THpJdWVEeXd4ZnIvclh5?=
 =?utf-8?B?NFk1dFA1ZWFmKy9sL015aUdIUXZlUFJFc1RCbnlKa1RncStLM1htcGdVaHQ4?=
 =?utf-8?B?TlNqNG5qOERQT0ROM2VsWk9qdW5tOWR2K1BUMER6WDVydjlhVXMwZG0xVXRl?=
 =?utf-8?B?TzhOSHdZSGdKTFU3REtTRlZQK2hqZjJzTVRHeS9xbHFUU1M5ZHdCc1oxVlow?=
 =?utf-8?B?UnpyVStnc29QRDduSEV2OHV4NjQ3U3JOdkJyekIySUQvMkdzWWhGMFgwdExY?=
 =?utf-8?B?bHZZcWc0WFZBM1BoZ09vcWRLNFV4dXJNMlhwR2VvTEFDcjVZRkVUbldjNDlr?=
 =?utf-8?B?ZU9QcUZsL0FvYlJ0eWRwU283UzBzK0o1YUJhNk9tNWRNZnNyL2l2WEdTWHk5?=
 =?utf-8?B?d2M4ZWtBZzZPNmFrNHdsdVd0WWJIU2dCZmkrMXBXY09BdmVyQXNLTmt2dk5W?=
 =?utf-8?B?TGNoandNMzlJbHpuK0c5YkE2U2FVa1lvSTM2Wm0wSTlZQzgzK3hjakE3Q3Jt?=
 =?utf-8?B?SC9xNm9jTzhacmlFNjV1ZzZuWUxyOUpYMm9qY1lKcFpjb296YlExNHpLSGlW?=
 =?utf-8?B?VC8vUExNT09BeDRNS0IvR2JSRFNJL0h5VHpzWUREbFpyYnRkRCtGTHNVQ29p?=
 =?utf-8?B?Um9ISUJ4VUlkSmpQTjF4MFkzTVFHb3F0UTVHcFVRNHp1bDRQTTltTGppcUpN?=
 =?utf-8?B?cXJWUGpLbXV4WkZUK3JodUMzb091bjZLRE5ET0x6a3NIQ1FGRGdzVDR6akFK?=
 =?utf-8?B?d3FPM2Z1a2RNQkx2VzBWbVJ6U05JTU56cFBtbDkwRHk5NmIrcXNka2ZaSjFR?=
 =?utf-8?B?TW5lUVI2bUtONUhzU2NTeWNZdnI0dm9sd3l2UkVKOXg1M3g5YWk5Wis4Q2E3?=
 =?utf-8?B?TDR5OVpKbEI4d2ZqUG81UXo5OWg2c28vUkJtVUQzdGcxait0ejZBaTRIY29T?=
 =?utf-8?B?SmhORkVKbE5iUnVPanM0djExYUNySmNJbnRPeWlrUzJOallaaEkxTGVIR0ZB?=
 =?utf-8?B?RUxia2p1Wkc3ZEZnNWFSOVBrUmlBbHhXcHY4eFpQS1V6aTJYdTd4T1pGQ29C?=
 =?utf-8?B?ay9hZ21KeDBEUDBHVWpKYmdQbFVOVFJmR1cwdzkrRGwrcXBZT1ZvMGRyM1dI?=
 =?utf-8?B?Tm1oZUN4NUJxSXZaUGlNTjVkMWh1aFM5ck5mbUR4aG93WU1heFdxRnZ6d1Zr?=
 =?utf-8?B?eGZrUkJjV1dhcm84SU10NUYzZHIrUG15a0NoVXJmT0xabW00RXloSXpEUmwx?=
 =?utf-8?B?Z3c4Wk9XRUM1MitSK2NwSXhVRytiZXdhM1BDajdNUlVITHFJbFRUelN6Z2tJ?=
 =?utf-8?B?NHFuY0lUSWV0NTRpNWxJeVd1VW9pSkRKNnE5OGxic0FnSzl1RzdId1p6SXJT?=
 =?utf-8?B?K3VKM1gwRitkSEpIVXA1N1dYSTEvbW56ZzJHRnRyRVFiVkwwYytwM3E5ajV2?=
 =?utf-8?B?UHd2WG5rclhXaWd6YlhFamcxSk5ueVFJWVpqOUtRbDBNazcwV3NQdmVNejFE?=
 =?utf-8?Q?O2/oBRqBwz/bmmhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65A08E9EF928484993558970A20B8EC4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rdjpOzf7DzmCcogefK6CeY+SQUGWHGq1rGMTuK3yYRAhxX/7Ybst4B+CwXuM+8cvLPZeXyi2oSWRZZTm8W5cjtmYLeNlcGyVSI8MqeI0y15HhjcREOCvB2AOoJY+N2MhpJ1zFc7gsm4DRn8yjglGQcRzsNKpzZRzl/Yzv35jjuaeBlF6kTyJ0aMl3M2i+69i/dH509qMpayOpNIpnsY2RCNF/Gy5saqmBjSe8IhT8XA8nJVsVIkXFKJo4V/n9qG++NL6Z7t0DIiz7ZV4CkCLGiUd6KFF3ISjMneAlJRG2pbJ6CAnfYtlyfI8jxOMsWCw0FRCvPaDMsJnW2oVpcjRNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60753c77-0f7b-4e74-04b5-08df1e100323
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 09:57:03.0319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDkEfbKmA5VtIrHxmjKvZNjxSc5A9sLMp1NyKBgqbF4DZRqeE2kaIbb9nB0DHI+rbGUJa3vq0qFA8msK9En4aKyPvqD0wTVkzUczAJJOsA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9815
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgaGFsZiBMRlBTIGN5Y2xlIGNhbGN1bGF0aW9uIGZvciBEUDIuMSBB
TFBNIGFzDQo+IGRlcGVuZGVudA0KPiBwYXJhbWV0ZXJzIGdvdCBjaGFuZ2VkLg0KPiANCj4gdjE6
IEluaXRpYWwgdmVyc2lvbi4NCj4gdjI6IEF2b2lkIHJldHVybmluZyBlYXJseS4gW0phbmldDQo+
IHYzOiBVc2UgaW50ZWxfY3J0Y19oYXNfdHlwZSgpLiBbU3VyYWpdDQo+IHY0OiBTcGxpdCBpbiBz
ZXBhcmF0ZSBmdW5jdGlvbiBiYXNlZCBvbiBIQVNfTFRfUEhZKCkgY2hlY2suIFtKb3VuaV0NCj4g
DQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0t
LQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jIHwgNDEgKysr
KysrKysrKysrKysrKysrLS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2FscG0uYw0KPiBpbmRleCBjYjI0YmJhODAxYTEuLjE0ZWNiMjcwOTViMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gQEAgLTc0
LDI0ICs3NCw0OSBAQCBzdGF0aWMgaW50IGdldF9zaWxlbmNlX3BlcmlvZF9zeW1ib2xzKGNvbnN0
DQo+IHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoAkJMTAwMCAvIDEw
MDA7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIHZvaWQgZ2V0X2xmcHNfY3ljbGVfbWluX21heF90
aW1lKGNvbnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLA0KPiAtCQkJ
CQlpbnQgKm1pbiwgaW50ICptYXgpDQo+ICtzdGF0aWMgdm9pZCBsbmxfZ2V0X2xmcHNfcGVyaW9k
X21pbl9tYXhfdGltZShjb25zdCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0
ZSwNCj4gKwkJCQkJwqDCoMKgwqAgaW50ICptaW4sIGludCAqbWF4KQ0KPiDCoHsNCj4gLQlpZiAo
Y3J0Y19zdGF0ZS0+cG9ydF9jbG9jayA8IDU0MDAwMCkgew0KPiAtCQkqbWluID0gNjUgKiBMRlBT
X0NZQ0xFX0NPVU5UOw0KPiAtCQkqbWF4ID0gNzUgKiBMRlBTX0NZQ0xFX0NPVU5UOw0KPiAtCX0g
ZWxzZSB7DQo+ICsJaWYgKGludGVsX2NydGNfaGFzX3R5cGUoY3J0Y19zdGF0ZSwgSU5URUxfT1VU
UFVUX0VEUCkpIHsNCj4gKwkJaWYgKGNydGNfc3RhdGUtPnBvcnRfY2xvY2sgPCA1NDAwMDApIHsN
Cj4gKwkJCSptaW4gPSA2NSAqIExGUFNfQ1lDTEVfQ09VTlQ7DQo+ICsJCQkqbWF4ID0gNzUgKiBM
RlBTX0NZQ0xFX0NPVU5UOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJKm1pbiA9IDE0MDsNCj4gKwkJ
CSptYXggPSA4MDA7DQo+ICsJCX0NCj4gKwl9DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHhl
M3BscGRfZ2V0X2xmcHNfcGVyaW9kX21pbl9tYXhfdGltZShjb25zdCBzdHJ1Y3QNCj4gaW50ZWxf
Y3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSwNCj4gKwkJCQkJCSBpbnQgKm1pbiwgaW50ICptYXgpDQo+
ICt7DQo+ICsJaWYgKGludGVsX2NydGNfaGFzX3R5cGUoY3J0Y19zdGF0ZSwgSU5URUxfT1VUUFVU
X0VEUCkpIHsNCj4gwqAJCSptaW4gPSAxNDA7DQo+IMKgCQkqbWF4ID0gODAwOw0KPiArCX0gZWxz
ZSB7DQo+ICsJCSptaW4gPSAzMjA7DQo+ICsJCSptYXggPSAxNjAwOw0KPiDCoAl9DQo+IMKgfQ0K
PiDCoA0KPiArc3RhdGljIHZvaWQgZ2V0X2xmcHNfcGVyaW9kX21pbl9tYXhfdGltZShjb25zdCBz
dHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSwNCj4gKwkJCQkJaW50ICptaW4s
IGludCAqbWF4KQ0KPiArew0KPiArCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0NCj4g
dG9faW50ZWxfZGlzcGxheShjcnRjX3N0YXRlKTsNCj4gKw0KPiArCWlmIChIQVNfTFRfUEhZKGRp
c3BsYXkpKQ0KPiArCQl4ZTNwbHBkX2dldF9sZnBzX3BlcmlvZF9taW5fbWF4X3RpbWUoY3J0Y19z
dGF0ZSwNCj4gbWluLCBtYXgpOw0KDQpBcyB5b3UgYXJlIGNoZWNraW5nIEhBU19MVF9QSFkgYmV0
dGVyIHByZWZpeCB3b3VsZCBiZSBsdF8uDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQoNCj4gKwll
bHNlDQo+ICsJCWxubF9nZXRfbGZwc19wZXJpb2RfbWluX21heF90aW1lKGNydGNfc3RhdGUsIG1p
biwNCj4gbWF4KTsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBpbnQgZ2V0X2xmcHNfY3ljbGVfdGlt
ZShjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+
IMKgCWludCB0bGZwc19jeWNsZV9taW4sIHRsZnBzX2N5Y2xlX21heDsNCj4gwqANCj4gLQlnZXRf
bGZwc19jeWNsZV9taW5fbWF4X3RpbWUoY3J0Y19zdGF0ZSwgJnRsZnBzX2N5Y2xlX21pbiwNCj4g
LQkJCQnCoMKgwqAgJnRsZnBzX2N5Y2xlX21heCk7DQo+ICsJZ2V0X2xmcHNfcGVyaW9kX21pbl9t
YXhfdGltZShjcnRjX3N0YXRlLCAmdGxmcHNfY3ljbGVfbWluLA0KPiArCQkJCcKgwqDCoMKgICZ0
bGZwc19jeWNsZV9tYXgpOw0KPiDCoA0KPiDCoAlyZXR1cm4gdGxmcHNfY3ljbGVfbWluICvCoCAo
dGxmcHNfY3ljbGVfbWF4IC0NCj4gdGxmcHNfY3ljbGVfbWluKSAvIDI7DQo+IMKgfQ0KDQo=
