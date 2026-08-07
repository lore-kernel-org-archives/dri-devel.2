Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8AFC5AC80
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 02:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570B610F32F;
	Fri,  7 Aug 2026 02:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SpIOSTZG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E6610F32F;
 Fri,  7 Aug 2026 02:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786070279; x=1817606279;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4hud/GImJRPYpKqbRv1yRkU5jSkpOQ79XiRv+LRPqN4=;
 b=SpIOSTZGSF2agXWcmYwDNvErC85cmSVUjmvv+y8Qb4lOU4M546Eeb3+/
 Vd1N07xCYrEhHkKKU/9qfSLgmo9j8wdTavm7gF0mL3mo+qdM0ZuhrhbKv
 66PoDLZB1K+0XdY3iVlklvLwKhJX9gpaInP5QdixvpsJpnPPs4VDMwyBd
 zLe1Rkyy3zBi91Ow9kQo8fh35W64j/v99rAF7Oz/iPSKOeNwFOyOj+u+r
 +STRkIST2jEuDkGj8J82HtH++5aaV1LRqaqiGnccLe47+tJHl68WLCjye
 /zBHOI54f8yhQlP2sm6nEhw6HbaeETtUxBHxXY6hvw4NGmMkROW8Jcjuw Q==;
X-CSE-ConnectionGUID: w3Go521QTfC1bpTeijTxpw==
X-CSE-MsgGUID: n9cTvF6ESmycEtO+YNmk8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97325476"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="97325476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 19:37:58 -0700
X-CSE-ConnectionGUID: lyTZl335TumLuunMX8qmiA==
X-CSE-MsgGUID: 2nT5ibBpRpyjL4Z77amNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="261754838"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 19:37:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 19:37:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 19:37:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 19:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbvNbP1HEJpeGA9G3W/676ieI1kjlGdK8RV0IMd23Rg1vOwjXWVg/e4kvP43eVsLsIYejsvKJoAcU9r3WSbNDOqx6TDLzXUeDXImz78PRBs02XAq6CR6LKJhBj5Z2HUkXrvrDblwP2gOtqjmr1YJPvRw5AXIyOqu5ZBwgzkPv2Z1l1to92WHmT+Mb7Fp0ePQPHzS60FD+UcWXA7GlEuom1cDKmbsT/BC0lj36AOXUX7uNoiBaXxXb2SnfDS0h/cl2W6iapnP7lHZ2w2fw5GNt8mJ9TX3dIpts/iFHpkE02WbgleX0hrUS2LpTK5crCelAc18fiXtX5T21NlOE/CA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hud/GImJRPYpKqbRv1yRkU5jSkpOQ79XiRv+LRPqN4=;
 b=E9zgwYP4EETphfm4g8Ak7aDY9700YnP4PoDrAmUz/hakFqONQCBCVFcvZtnRUbTLO8d2jJDv3y8fkhznDnZTM+q0pmeNd/x/xjN1JH6ViebAhJY84O5bSt4+g59YOY1flJG5XqZSxD3MGHDuuwW8Zo3A5+oHs3jAifbe9uNqaUSuyAkN04d+KkNr7btNJiC9dRC83iQZsObeCyrGAD0ZOuutyBdJbS7KroMQnQwVwByp2Rm0R+F1II8jUvCyEmjRUlR7ctaPGCT37Q234YADPCiJhIxmdu6rmdNGVRfdjuzrwz1PVca8Aha3H80YrNPyt4h7ZXvBuIZ+NXWUmmeekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by IA3PR11MB9254.namprd11.prod.outlook.com
 (2603:10b6:208:573::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 7 Aug
 2026 02:37:55 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::5be7:2ceb:99ef:6334%8]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 02:37:54 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] drm/i915/display: Add quirk to force backlight
 type on some TUXEDO devices
Thread-Topic: [PATCH v3 1/1] drm/i915/display: Add quirk to force backlight
 type on some TUXEDO devices
Thread-Index: AQHdJEznsXtkW+u4m0qz3w31Ooka9LaPRSQAgAKb5eA=
Date: Fri, 7 Aug 2026 02:37:54 +0000
Message-ID: <DS4PPFE901A304F53791AC29FAD352E193DE3D12@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260804200021.171947-1-wse@tuxedocomputers.com>
 <20260804200021.171947-2-wse@tuxedocomputers.com>
 <f329f7c1-9277-4b9d-8c81-09528a66545d@tuxedocomputers.com>
In-Reply-To: <f329f7c1-9277-4b9d-8c81-09528a66545d@tuxedocomputers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|IA3PR11MB9254:EE_
x-ms-office365-filtering-correlation-id: 7a805fe9-4596-4251-a4f5-08def42ce25a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|18002099003|4143699003|56012099006|10067099003|11063799006|22082099003|3023799007|13003099007|38070700021;
x-microsoft-antispam-message-info: vOIeZd34XOJlyNcWvxYfqQaKh/fbGzWtZBGhdia0wr9nrcF+GW/WgK3MbqAaZqE/2i3zPybn8obJD1meu22ZWBBF0amxWKcxzuOCiru3VJkaq0z6nov9A1/pNXkLOgxwby3/Ym+d4VpXkRxl8NY/upfi3GM8QGGo9HKKtJHrLS7ZYSwH9pmD9fBEoSl3j2bFlKHM47YLIi5NcLzCOzn7T/s3jUSLM2yw0EelHdGmOtd0UnRPkF9WfDR/xRA7IeaErcTR7ojj/x2cKKKoxX9IVEC6SVPPDd+3GBXAIGCHFcYOxRew5gE61vzMlCylEK6Nla7f4A6ptXo7LRk7iMlVRzgl2dzigCz8BKuKTuoacQDT2brIi+cCFhHKY3BeehyxGF+Rp9YvR9tlL7xiVKfk90xGpsgVSbbQd5364jT+fKEsxkQmMVlgKMe5UetaVftEbxL3Mje0cPxV4rW1Il6Dhy/DHylDLbC/BEdu1d4MN29WHH01iqs1xBAp9GXFY6kH05olnOkPC4OB8s/s4JbkMmM7PAIlDZAliPSnyVgktLS0uN2L+Gl/E/5MA1PWZjt8k0AnFHk4t+TarEf3qPnuJoA2PSD3HgcvajObRby1yzsehPyE9WTQQ8HcaoaUk5KKaeXYlkAJ+iGqM7aC5bbQ2ABWu6HTq8+7TjObu/XO2sWBXB+v1lxMxcNnjVXO1FgvjA488dgudBaX6Hyv14hDiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(3023799007)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXBybGVueCttUUo5eXBwd3k1bFNpcm9IMkJYN1llL1N0Z0RBMGRCNzhjWkxR?=
 =?utf-8?B?V2NhUzMveEVKbW84QUtrSzYwRDZSZXlIakpwZlM3cE1vSU1FRkpZcUc5cmdK?=
 =?utf-8?B?TXl6NkxVUGlyR3o1dk1jVzhYZ1dUVmhVTmoxZis3aGZJdkNjUStwb2FoQm9x?=
 =?utf-8?B?YUtINytneGxoRnFhU2FZQ2hmRFZpNVh6SHdjNGk0RnlPektybXg2YTd4dyt6?=
 =?utf-8?B?bnRLTTgzbnpCR3JWemtzZlpRK0dEamRqeXNEQ01RRXdxaWYvZUlqRFNMZVh2?=
 =?utf-8?B?aG9pZEpIeFdMcmh0N1BtdkFFL3ZpSTZUZ21acGQ2OG5VYmxKUXNYcFRjckZa?=
 =?utf-8?B?eCtMWExvSlErT0pTcys1UXg3VDRTK2VNVzlMeVdueCtwdWsvUExxaWZJNDJZ?=
 =?utf-8?B?Z3gwanJ0UCtta1ZqazBXbjBVT21HRTV5cTdMYlhEVktTd3NXSnNjK3FYZE1G?=
 =?utf-8?B?UWw3WktZVWlDd09KMEN6cFptRFJDcDZPazJpbDFxUFJiYitVSGs0UUdBVHcw?=
 =?utf-8?B?cmVaYjNuYUpYNzBqb1pSbWxKZlRkR3ZFeXQ4aVEyLzcvaFBnL0QrNGpabldI?=
 =?utf-8?B?SXRocGpPK3N6RkJTeU5CekVGRk1hTlNSUU1odlNhaWc3Y0xnd1VSQTBPR0gy?=
 =?utf-8?B?aEFKdFQwNVdVOUFoc3NCOE5SZWpxdlp3NTdDeVYydktNT3B6eFFwZnRXR0xY?=
 =?utf-8?B?VFhDQkpncmNtNTdTckwzNEwyc1UzWDBXRG9vbVJJNEQ0SmZIR0lzOUd1Slhh?=
 =?utf-8?B?dm81UDdNdy9GVEJBYkQ0aG1qT0pSWTVhMkk4bi9pUzdQd2RZdUJrN21FS0dD?=
 =?utf-8?B?QWx0YW1oZUY5ZjRiV0ZoSkpKdzZiTDMzVkVTWlpaV1VnajBmOXM0Qk0zalJv?=
 =?utf-8?B?ODVyNUlRUFpyNjViQis4bzZybllVMUYvRmh2QjJHYzVjN2d5bkZUV2N5SjhK?=
 =?utf-8?B?MG5FbktKTk5FMHkycU5RYkxWMEJweW0ySnBscng0L0t2N2FzM0lmcWxPcTYr?=
 =?utf-8?B?anRIOWtvTkpaZ3ZPSEhiUzluV1BUaHJ0RWxqamFJK3Y2QkprS3dUWkRLY25F?=
 =?utf-8?B?YTZwWU5oR0FoQ1dLRUovajlCRnR3Sy8yaXQ0WFFkV3MvSm1lU21oeFdGU1Iv?=
 =?utf-8?B?RnJHbEEwWklvY3N6NzNqV0JkaWFMMDRuVnc2Um96ekZHb2hPaVlvUy9zbFJU?=
 =?utf-8?B?eGVqOWkzeGdhSnhDUXBBamtRODRsdnRmYm13dytBbVB3b2c0VlVmbCs4MStz?=
 =?utf-8?B?Nm9VSCtOMkJvTXhZL0o1cWlsejhmR1F4TGx3K3NEbGwwdzNCWkFHaEw1MFZU?=
 =?utf-8?B?VnBscEZhWjUvZURDNUhuT2dPOU8zVFdMKzRndFFyemZhN05RODlOdkNuL2dJ?=
 =?utf-8?B?Q0tVNnByQ0dTQVRtLzF0Z1A0OWdRK0UyS3N4TUppN1JkUmxDQXdnZ2VFdzgv?=
 =?utf-8?B?bmVkZTdtMkc3ME5sUzlmNEgycDFLU2xiVk84eUx0Q0UyNzV5TjBwUG5rSVF2?=
 =?utf-8?B?TEMxYWZ4dE5mcGd5N3JyVitaUXpOM0lqQzZJS05qYlNBSWpNdDVmYVBoUXNC?=
 =?utf-8?B?ZmRiZFJWM281a0w3SnJUTDczSWVzSFJ2RytBc3p3NzN1MDVXdFJhTXpIM1F4?=
 =?utf-8?B?TnlNMVNYNlhiem5lc3JSbmF0dDZHeE5xT0kvUCtJcWhNQmVVTGgvNlFBeksy?=
 =?utf-8?B?YzZjNStBbmxaN3BqaVFpN3FXYWNDVlVWaXl2aXlJZXJpZ0V3MWprb0xuMTlq?=
 =?utf-8?B?dFdWbmNPWGlKUEovNFJEMU9Lbnd2NklnaVAwVWMvYjQ5bVZ3K0NJUHpDMTY4?=
 =?utf-8?B?UUswZVhBN0toYU55K2R0S3V4VVRrcVEvUVY2aU1zMWp2bFhUUWtFY3hFQ0d4?=
 =?utf-8?B?bXdpalI0SHR4bGlUWEEwaG5YV3AxcGVPUnJ5Z1h6b09sQjFRZ0UrVGt3RDFa?=
 =?utf-8?B?K2gwTzJScmt5SmhuUDEzYUJ4dHdJRmY0RG5hdjFWeENXUTB4YlhlSDNBK05l?=
 =?utf-8?B?MjVCY3N1cXMxajdCRlpvd3NYZ2dBZ3N2Q01Na1dRekZRdDFUazRkM0FEcHZC?=
 =?utf-8?B?clkvNG15SkJnMnl5NG45Q2VmZTdIcU5FaVBnRWRBb1YxSCtlWEhSdzAzcmE1?=
 =?utf-8?B?bHZ2MXh3RGZzeXJLMG1Zbi9KRUxWYTZzYU03OGxscHNHdFN5ZFNuN3lLNFlz?=
 =?utf-8?B?UmpSQkpHMVpjKzB3RUlpNGFSRXBhV3VaRFQ5VmVDNGk5OGRMZWtFaWErYnNF?=
 =?utf-8?B?TVZtdHNhdWhBbjdscU5EWlhoNm9ocWJvckFUcUh2SWdhcS8rcUpTbFFtVjlh?=
 =?utf-8?B?MEhJUnBVQkd4b3BpVHBsMllEY0hPWERXNTVJSWNuTWNNc1NrR0VQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BlIP0YsbUbsDK0202zHhDWgvBWOqrJInBJfV1w6uKqTMfkKAPySKECZxAHYtD/veJZy+BtR4Hz0BGPGPxNeNpNSbb2ow2OAPUEvTFshnAeJCYgvQ8m+0f0PIsHY5J0eet3tPXt0IGpfItAm+g4betPRjjHtgbNM4CxudEcBtRWdVKFDY0+zWJm0HkWvg2H7Q2fQ6siSmL/CQXUguCD/TPCq6MAzNjwhOT6qlK1by2x23q1eiBBmOGdDzloW3BlKm/vajkKTUBn+xzdJRu/R8nhbD+5XzDCjnJUbvcCYhUdQBTzqVgahyK2vjirGmkTMh8FWyWgKwDQEaqAqXn9jhXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a805fe9-4596-4251-a4f5-08def42ce25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 02:37:54.5996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/hBVsgi3Sh2IvEpHsLM/p+GK0+ljm3Y8ak/qAxRKNqCSdYo0F32T4AI34knoMCdqNEiIEM388uuXofECVxByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9254
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMV0gZHJtL2k5MTUvZGlzcGxheTogQWRkIHF1aXJr
IHRvIGZvcmNlIGJhY2tsaWdodCB0eXBlDQo+IG9uIHNvbWUgVFVYRURPIGRldmljZXMNCj4gDQo+
IEFtIDA0LjA4LjI2IHVtIDIxOjUyIHNjaHJpZWIgV2VybmVyIFNlbWJhY2g6DQo+IA0KPiA+IFRo
ZSBkaXNwbGF5IGJhY2tsaWdodCBvbiBUVVhFRE8gRFgxNzA4IGFuZCBJbnNhbml0eUJvb2sgMTUg
djEgd2l0aA0KPiA+IHBhbmVscyBBVU8gMTI3MDEgYW5kIEFVTyAxMjcwMSBtdXN0IGJlIGZvcmNl
ZCB0bw0KPiA+IElOVEVMX0RQX0FVWF9CQUNLTElHSFRfT04gdG8gYmUgYWJsZSB0byBjb250cm9s
IHRoZSBicmlnaHRuZXNzLg0KDQpZb3UgbmVlZCB0byBtZW50aW9uIHdoeSB0aGF0IGlzDQoiQmVj
YXVzZSB0aGUgYnJva2VuIFZCVCBpbiB0aGVzZSBwYW5lbHMgcmVwb3J0IElOVEVMX0JBQ0tMSUdI
VF9WRVNBX0VEUF9BVVhfSU5URVJGQUNFDQpldmVuIHRob3VnaCB0aGUgb25seSB3YXkgdG8gY29u
dHJvbCB0aGVtIGlzIHZpYSBJbnRlbCdzIGJhY2tsaWdodCBpbnRlcmZhY2UuIFdoaWNoIG1lYW5z
Jw0KdGhlIFZCVCBzaG91bGQgaWRlYWxseSByZXBvcnQgSU5URUxfQkFDS0xJR0hUX0RJU1BMQVlf
RERJIGluIGl0cyBwYXJhbXMiDQoNCj4gPg0KPiA+IFRoaXMgY291bGQgYWxyZWFkeSBiZSBhcmNo
aXZlZCB2aWEgYSBtb2R1bGUgcGFyYW1ldGVyLCBidXQgdGhpcyBwYXRjaA0KDQoqIGNhbiBhbHJl
YWR5DQoqIGFjaGlldmVkDQoNCj4gPiBhZGRzIGEgcXVpcmsgdG8gYXBwbHkgdGhpcyBieSBkZWZh
dWx0IG9uIHRoZSBtZW50aW9uZWQgZGV2aWNlcy4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBu
b3QgYWN0dWFsbHkgdGVzdCBmb3IgdGhlIGV4YWN0IHBhbmVscyBhcyB0aGUgaWQgdGhhdA0KPiA+
IGlzIHVzZWQgaW4gdGhlIGludGVsX2RwY2RfcXVpcmtzIGxpc3QgaXMgc2FkbHkgemVyb2VkIG9u
IHRoZSBkZXZpY2VzLA0KPiA+IGJ1dCBhZmFpayBhbGwgdGhlc2UgZGV2aWNlcyB1c2UgdHJ5X2lu
dGVsX2ludGVyZmFjZSBmaXJzdCBhbnl3YXkgc28NCj4gPiBhbGwgdGhlIHF1aXJrIGRvZXMgaXMg
dG8gYWRkIHRoZSBmYWxsYmFjayB0byB0cnlfdmVzYV9pbnRlcmZhY2UsIHNvDQo+ID4gdGhlIGJl
aGF2aW91ciBvbiB0aGUgZGV2aWNlcyBub3QgbmVlZGluZyB0aGUgcXVpcmsgYW5kIGZhbGxiYWNr
IHNob3VsZA0KPiA+IGZ1bmN0aW9uYWxseSBzdGF5IHRoZSBzYW1lLg0KPiA+DQo+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZXJuZXIgU2VtYmFjaCA8
d3NlQHR1eGVkb2NvbXB1dGVycy5jb20+DQo+IA0KPiBGaXhlczogaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tlcm5lbC8tL3dvcmtfaXRlbXMvMTU2NzkNCj4gDQo+IENs
b3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pOTE1L2tlcm5lbC8tL3dv
cmtfaXRlbXMvMTU2NzkNCj4gDQo+ID4gLS0tDQo+ID4gICAuLi4vZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kcF9hdXhfYmFja2xpZ2h0LmMgfCAgOSArKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1aXJrcy5jICAgfCAyNCArKysrKysrKysrKysrKysrKysr
DQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1aXJrcy5oICAgfCAg
MSArDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2RwX2F1eF9iYWNrbGlnaHQuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9kcF9hdXhfYmFja2xpZ2h0LmMNCj4gPiBpbmRleCAyNjZlMDQyZTAwMjM3Li41OTRj
NTlmMmQ4MzA5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfZHBfYXV4X2JhY2tsaWdodC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9kcF9hdXhfYmFja2xpZ2h0LmMNCj4gPiBAQCAtNDEsNiArNDEsNyBAQA0K
PiA+ICAgI2luY2x1ZGUgImludGVsX2Rpc3BsYXlfdHlwZXMuaCINCj4gPiAgICNpbmNsdWRlICJp
bnRlbF9kcC5oIg0KPiA+ICAgI2luY2x1ZGUgImludGVsX2RwX2F1eF9iYWNrbGlnaHQuaCINCj4g
PiArI2luY2x1ZGUgImludGVsX3F1aXJrcy5oIg0KPiA+DQo+ID4gICAvKg0KPiA+ICAgICogRFAg
QVVYIHJlZ2lzdGVycyBmb3IgSW50ZWwncyBwcm9wcmlldGFyeSBIRFIgYmFja2xpZ2h0IGludGVy
ZmFjZS4NCj4gPiBXZSBkZWZpbmUgQEAgLTY4NywxMSArNjg4LDE3IEBAIGludA0KPiBpbnRlbF9k
cF9hdXhfaW5pdF9iYWNrbGlnaHRfZnVuY3Moc3RydWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVj
dG9yKQ0KPiA+ICAgCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0b3ItPmJhc2UuZGV2
Ow0KPiA+ICAgCXN0cnVjdCBpbnRlbF9wYW5lbCAqcGFuZWwgPSAmY29ubmVjdG9yLT5wYW5lbDsN
Cj4gPiAgIAlib29sIHRyeV9pbnRlbF9pbnRlcmZhY2UgPSBmYWxzZSwgdHJ5X3Zlc2FfaW50ZXJm
YWNlID0gZmFsc2U7DQo+ID4gKwlpbnQgZW5hYmxlX2RwY2RfYmFja2xpZ2h0Ow0KPiA+DQo+ID4g
ICAJLyogQ2hlY2sgdGhlIFZCVCBhbmQgdXNlcidzIG1vZHVsZSBwYXJhbWV0ZXJzIHRvIGZpZ3Vy
ZSBvdXQgd2hpY2gNCj4gPiAgIAkgKiBpbnRlcmZhY2VzIHRvIHByb2JlDQo+ID4gICAJICovDQoN
ClRoaXMgY29tbWVudCBuZWVkIHRvIGJlIG1vdmVkIGp1c3QgYWJvdmUgdGhlIHN3aXRjaCgpDQoN
Cj4gPiAtCXN3aXRjaCAoZGlzcGxheS0+cGFyYW1zLmVuYWJsZV9kcGNkX2JhY2tsaWdodCkgew0K
PiA+ICsJZW5hYmxlX2RwY2RfYmFja2xpZ2h0ID0gZGlzcGxheS0+cGFyYW1zLmVuYWJsZV9kcGNk
X2JhY2tsaWdodDsNCj4gPiArCWlmIChlbmFibGVfZHBjZF9iYWNrbGlnaHQgPT0gSU5URUxfRFBf
QVVYX0JBQ0tMSUdIVF9BVVRPICYmDQo+ID4gKwkgICAgaW50ZWxfaGFzX2RwY2RfcXVpcmsoaW50
ZWxfZHAsIFFVSVJLX0VOQUJMRV9EUENEX0JBQ0tMSUdIVCkpDQo+ID4gKwkJZW5hYmxlX2RwY2Rf
YmFja2xpZ2h0ID0gSU5URUxfRFBfQVVYX0JBQ0tMSUdIVF9PTjsNCg0KTGV0J3MgYWxzbyBoYXZl
IGEgY29tbWVudCBoZXJlIGFzIHRvIHdoeSBhIHF1aXJrIHdhcyB1c2VkIGluc3RlYWQgb2YganVz
dCBtYWtpbmcgVkVTQSB0aGUgZGVmYXVsdCBpbnRlcmZhY2UuDQpUaGlzIHdpbGwgaGVscCBkZXZl
bG9wZXJzIGF2b2lkIGdvaW5nIHRocm91Z2ggYSBzZXJpZXMgb2YgcmVncmVzc2lvbnMsIGZpeGVz
IGFuZCBpbmV2aXRhYmxlIHJldmVydHMuDQoNClJlZ2FyZHMsDQpTdXJhaiBLYW5kcGFsDQogDQo+
ID4gKw0KPiA+ICsJc3dpdGNoIChlbmFibGVfZHBjZF9iYWNrbGlnaHQpIHsNCj4gPiAgIAljYXNl
IElOVEVMX0RQX0FVWF9CQUNLTElHSFRfT0ZGOg0KPiA+ICAgCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiAgIAljYXNlIElOVEVMX0RQX0FVWF9CQUNLTElHSFRfQVVUTzoNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYw0KPiA+IGluZGV4IDMzMjQ1ZjQ0
YzBkNTAuLjg5ZDgyMzY0YWU0NWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfcXVpcmtzLmMNCj4gPiBAQCAtMTAwLDYgKzEwMCwxNCBAQCBzdGF0aWMg
dm9pZCBxdWlya19kaXNhYmxlX3BzcjIoc3RydWN0IGludGVsX2Rpc3BsYXkNCj4gKmRpc3BsYXkp
DQo+ID4gICAJZHJtX2luZm8oZGlzcGxheS0+ZHJtLCAiUFNSMiBzdXBwb3J0IG5vdCBjdXJyZW50
bHkgYXZhaWxhYmxlIGZvciB0aGlzDQo+IHNldHVwLCBhcHBseWluZyBkaXNhYmxlIFBTUjIgcXVp
cmtcbiIpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHF1aXJrX2VuYWJsZV9kcGNk
X2JhY2tsaWdodChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKSB7DQo+ID4gKwlzdHJ1Y3QgaW50
ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoaW50ZWxfZHApOw0KPiA+ICsN
Cj4gPiArCWludGVsX3NldF9kcGNkX3F1aXJrKGludGVsX2RwLCBRVUlSS19FTkFCTEVfRFBDRF9C
QUNLTElHSFQpOw0KPiA+ICsJZHJtX2luZm8oZGlzcGxheS0+ZHJtLCAiQXBwbHlpbmcgRW5hYmxl
IERQQ0QgQmFja2xpZ2h0IHF1aXJrXG4iKTsgfQ0KPiA+ICsNCj4gPiAgIHN0cnVjdCBpbnRlbF9x
dWlyayB7DQo+ID4gICAJaW50IGRldmljZTsNCj4gPiAgIAlpbnQgc3Vic3lzdGVtX3ZlbmRvcjsN
Cj4gPiBAQCAtMjg2LDYgKzI5NCwyMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGludGVsX2RwY2Rf
cXVpcmsNCj4gaW50ZWxfZHBjZF9xdWlya3NbXSA9IHsNCj4gPiAgIAkJLnNpbmtfb3VpID0gU0lO
S19PVUkoMHgwMCwgMHgyMiwgMHhiOSksDQo+ID4gICAJCS5ob29rID0gcXVpcmtfZGlzYWJsZV9l
ZHBfcGFuZWxfcmVwbGF5LA0KPiA+ICAgCX0sDQo+ID4gKwkvKiBUVVhFRE8gSW5zYW5pdHlCb29r
IDE1IHYxICovDQo+ID4gKwl7DQo+ID4gKwkJLmRldmljZSA9IDB4NTkxYiwNCj4gPiArCQkuc3Vi
c3lzdGVtX3ZlbmRvciA9IDB4MTU1OCwNCj4gPiArCQkuc3Vic3lzdGVtX2RldmljZSA9IDB4OTUw
MSwNCj4gPiArCQkuc2lua19vdWkgPSBTSU5LX09VSSgweDM4LCAweGVjLCAweDExKSwNCj4gPiAr
CQkuaG9vayA9IHF1aXJrX2VuYWJsZV9kcGNkX2JhY2tsaWdodCwNCj4gPiArCX0sDQo+ID4gKwkv
KiBUVVhFRE8gRFgxNzA4ICovDQo+ID4gKwl7DQo+ID4gKwkJLmRldmljZSA9IDB4M2U5YiwNCj4g
PiArCQkuc3Vic3lzdGVtX3ZlbmRvciA9IDB4MTU1OCwNCj4gPiArCQkuc3Vic3lzdGVtX2Rldmlj
ZSA9IDB4ODUwMCwNCj4gPiArCQkuc2lua19vdWkgPSBTSU5LX09VSSgweDM4LCAweGVjLCAweDEx
KSwNCj4gPiArCQkuaG9vayA9IHF1aXJrX2VuYWJsZV9kcGNkX2JhY2tsaWdodCwNCj4gPiArCX0s
DQo+ID4gICB9Ow0KPiA+DQo+ID4gICB2b2lkIGludGVsX2luaXRfcXVpcmtzKHN0cnVjdCBpbnRl
bF9kaXNwbGF5ICpkaXNwbGF5KSBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX3F1aXJrcy5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX3F1aXJrcy5oDQo+ID4gaW5kZXggOTcwYTRmZTUyZmFmYy4uNDk5NjQxOWFlNzZi
ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1
aXJrcy5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9xdWly
a3MuaA0KPiA+IEBAIC0yMyw2ICsyMyw3IEBAIGVudW0gaW50ZWxfcXVpcmtfaWQgew0KPiA+ICAg
CVFVSVJLX0VEUF9MSU1JVF9SQVRFX0hCUjIsDQo+ID4gICAJUVVJUktfRElTQUJMRV9FRFBfUEFO
RUxfUkVQTEFZLA0KPiA+ICAgCVFVSVJLX0RJU0FCTEVfUFNSMiwNCj4gPiArCVFVSVJLX0VOQUJM
RV9EUENEX0JBQ0tMSUdIVCwNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHZvaWQgaW50ZWxfaW5pdF9x
dWlya3Moc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkpOw0K
