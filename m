Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22D4CA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674AC10E6B4;
	Fri,  2 Oct 2026 09:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GPeuUBsh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB5810E6B4;
 Fri,  2 Oct 2026 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790931642; x=1822467642;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AtAq9zo1WgxJIPEKhEVR3D21mckLOs/2pDefCefbroE=;
 b=GPeuUBshbJfc921v56+LFrGc6xPW3n8yBpGJupQHaALBqacxq0sqbqPq
 JlyWLjrHsYbvK7JmYWoqDVk31GhHmts4w1sBKz+WBtvtaAKFPXlsgr1xr
 GlF8ixDMWqdLPwddIfkhsRoGyvoY7dDuAtTmVPWrS1szwU1IlWWhq8TC3
 7gqv9soJ5UxgY5JFA/HW3IeKHUNZKGublPi9zGmJz2JwzN3Za2SjPsVWl
 aa0WP+84/DRY2gytdIkG9lI2kqmtBjgxGDNmZAmX+I4j46Yn0YfhUHUlI
 86L9jIQ6Zhaoa3YIOFTrWNE3kCGfTUOuzSEYQ8XsfoI7F35vbE5XYSymC Q==;
X-CSE-ConnectionGUID: BiCMgC3mQA+fETu3wx63ew==
X-CSE-MsgGUID: C2HguuMMTJ263wpX3NjIpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91560061"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="91560061"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:00:42 -0700
X-CSE-ConnectionGUID: SZqqAqrwQH22WkIhInDv/A==
X-CSE-MsgGUID: fe1AdXP0SbGzI7AXRowPSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="305708123"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:00:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 02:00:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 02:00:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.13)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 02:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjBjc+U1c1AwAEt/0ILvrv1x2bJ+rc9X5zJFBXF2SwfhD+RgLghIBtBzprgaNOCUpaPVYvN2sv0XmSf5mAnpjf5gzaOxf8fqoe/geACnWi0B2EbJv1txDatxWniafhWhpdZUnBB+SwgM4q3exgtWuDg0DHAdpzMv+wIFBmEZECnEFwGD5MSt7AN9nd3tCc9LTwtBHvWY7DsqnWgc7LpcJO8Vmmk0/eMjOpKYYdvQb6YNLLaBkBUNl0qtX6XPky6SrCFzVHygu5nvC3O+RAhPBtGX75tu3eAzeNff/pIFsQ98s3Dbcm5VFgr5AfrJlPT0a/WPvLrDoSv/IUxMjqdoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtAq9zo1WgxJIPEKhEVR3D21mckLOs/2pDefCefbroE=;
 b=e75oclCVw1xCA75Ch7P+AchXVqdkUUbSyZCqv3d5pp6zAnM/lIfOOfxIGUxVHhpoN1hAtaxp+KSJiml5+Mf+KAncnb6uzttbOnD6mzPj8L1+bwKSHUuSuKgobc/F3tPyiOYHJUVCDdqjLO5yn3YTlxjLXrCYnADbM8MI/05JHsw3OXUtB/LNJPFer5zZj/rh3g3spxdqSAoPx+Dh+2PGAbtKZ7mL8eidRCZkeWTzqmBvl9zEzuQmXh5proKBNCwthupfflKyuSv50UCbU0KhugoNA1zIH8gQAUwwispCZLN39ah1kH+LLZXklmUnnnn8lWO4nj9J1XVIPl6aqdarZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.16; Fri, 2 Oct 2026 09:00:33 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 09:00:33 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 16/18] drm/i915/alpm: Compute and program switch to
 active latency
Thread-Topic: [PATCH v6 16/18] drm/i915/alpm: Compute and program switch to
 active latency
Thread-Index: AQHdRUGbEmB3EhmyC0a0EJ0LnLqadbbqDnCA
Date: Fri, 2 Oct 2026 09:00:33 +0000
Message-ID: <62e8dc438b0bab75359472786162308e24e1c09b.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-17-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-17-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: 7f6d462c-099e-4003-7816-08df20639e10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: P5LUZCRmHgnxU0JcXyKlFtvz2hBDdey9Jsc1vLsk39qA0etgLfvGRdPvbK4gX+Wr75pSN6zYeD5qpqlXs6SVcCaRvmDTHGIITlKw/VYT1/api4VNpyo/gR/ywHHVdXk4C6bnpUy/IGLdSfCgKxvmYif30Jf3ulOEubbC2bZ44Pkq4XsSGMptejC6ux14cmqvzCWnmn8kBWIpUeCj6rLmD8xIUFgUoZNEBWc2a6mHZhMG0vpIIGZ/Dje1AerTs2uGLARZplTYmD2QtdAr3DOUSrzDMfP7+74qnj6ayH0fLAQmUt8bUTh+I+dW1DvKF9UXO5HBKclFCtk3kbZgrladic+ISEYILV/3+G2qo2MUcIqLu9SM4yESkq23xZixAQiPaP7lCJ120ODMIIM1+hTwpLcHC0h/BAa8T3JX9JeJ3jqmUWX4Q27Eq8UARbXnkMICrbdHoJEqMpvYohB3R60Ib+xEzLn6GdM2cbMXFJ36QdWV2MOhRxX0Zt3hZ8so9YBf152sFp8dhWuZ9EXve+rAVvocrYdhk7Hx5tKgd6cZBRH2U/XP8fLaQvhdfjv9yzpS446aK0P2xELjJdzue9JGjsKKS45S3v+DpSH7fyGKgUD2eP6mki1nUzW2HoL/IcKq9u0M+TsyQOGTgKEoTUJtNcUhBMvKUI1f2yfC+ff6UWpLohlHShez8q/c/YAVnG6hAGi46B+0yfZcQmOKBNgXA9L5CHH8BVE+bzag8fwMxrw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tlp1clNpUzZaKzhzc1lUZmdGMUkzVjg4ZWh6bmplWkVxZ3IxbUdJY0VzQktN?=
 =?utf-8?B?S0xsNnBVVGM1ZXZVNktTTnQ5bXBWaENyamo1azc5WllwbW5ZZngrZjk1N091?=
 =?utf-8?B?UGpJUndISFB6UC9sMUYrMzJtblVNOWhVR29uYy9TN08vdHhSa20vcGZsRDZq?=
 =?utf-8?B?Q3JtSGRVcS9UZlJlL3ptMStMMGdWUU9LbHZSWHdXZ2NrTGd6Z3djQ054M3Vo?=
 =?utf-8?B?YldhYkdwaEk5ZEdvSEc3TGxNUzIrMmhkV0RrRWZCTUVHSERNaHYxcUlDei9L?=
 =?utf-8?B?eDd3N3FMQWk4ZnhXN2FhbmoxdktqakNFcjhtOGhyWGFzK1pOYitWK2ZNSExn?=
 =?utf-8?B?U0ZHVGFJYmpmQThRcE5qdG9QekRSYmVVQTR3MTBlWDY4a0tQSkorMVFuSjk2?=
 =?utf-8?B?T0NpamNidHRzZ0g5S3BMNUI4bFViRlFIbXpKYUI3WEtGclVGcFVsdHhtU2FG?=
 =?utf-8?B?b1RqZUEvQncwUllWM0pRME5pQjRpSmtjQ2d2NjArL1FLd3RVRWU5aXRIMEhK?=
 =?utf-8?B?YXhBMSt2TmEwWTRYb3QrUjI3N1c5NzhQRS9iYUlDa3BJOWdVRTk3N3pDNy90?=
 =?utf-8?B?SnVoY2oxSC9jUXk4K1RUb2p2T2N4Nnhya3dCSU9RT0tsVVcxeUNjUjMzTlJK?=
 =?utf-8?B?NUExMEdtZmVDSnZMK3lGbFFBY0ZUZElKUnE3T0VPdXFyQmVSMGdLSnFBZUhU?=
 =?utf-8?B?ZDR1OW8xd2p4VzQxSm1oWHlialVOaW8wcEY4SjhPMTFTZWZIZ1pCY3Q3T3hn?=
 =?utf-8?B?U1hFVGprRWtwY0g3NUpnbDArQXV1WnJWVmxlTkNwYTJ4ZWNEWXVaM3g3U1B6?=
 =?utf-8?B?bXBMOEVtRk5ZZjFaeElGV1UvUmZ4akhlUHVyemNWRENKdGIybWt5bXdDREhp?=
 =?utf-8?B?SW5jdjVMVWViNTZMMlhGaUI1OWllZXdYc3BIc1h4TEFnUm9RL3RoRUtYU280?=
 =?utf-8?B?YTBINDJ5MXRvZDJBMURaV0Z0NkNjb01Wa3RvUUVxMVVUNXF0NkxrWjI3UDVE?=
 =?utf-8?B?ejN4Q2JNMm85OGhlZnByK05iTVQ1emFLOERhS2R3TllCVCtER05INERJUFhM?=
 =?utf-8?B?Nm9VeGFyTVVKSUZkbnlxMlNaam52K2hQUUNEa3hMS1NqOWFlSU1RNkNNVmJM?=
 =?utf-8?B?Unk0V05wY2FsTU1kZitLdy9HS0hyWTR0cUtBaWpieVlEK25zOEVnMnB0bGw1?=
 =?utf-8?B?Ni9teXNPM1k4K1JMSFVhYVBJOFA0MXlZSjU4RTZ4MDVZa2NtMmlJYmh0RmZ4?=
 =?utf-8?B?VHNPWXdoeHJLMldhR21qYXJHYjIwV3ZGelg0MGhVZnBtU2JmSVhJL1JSUlNw?=
 =?utf-8?B?OElnT3FObGsyTHYrRHRhTjhEWlp2T215WGl1cFU3MGFWbk1kQ21ycDI5SzR0?=
 =?utf-8?B?QVdVYXFhWmlwbzhOQlF1dVBvMXIzWWVYc0JlYTZwOHdGVGtXclczb0xsMVhj?=
 =?utf-8?B?Sm5VQ2N4YnBiM3NqRFpNKzVMSkVTZFRWUVpIbmRoLzVuL1hiTjRuT2RnSG1h?=
 =?utf-8?B?TlFyVmZ0YXBrZFJaeWZ3VUhQbnlOTWNOZnMxQWNySjk4TlNCdGh2bjYzeC9P?=
 =?utf-8?B?aHI3WVE3cGpnQVpiKzJCTno3WlZxYk5SdlpISTk2U04wMXBuTDlMWWtzMGlx?=
 =?utf-8?B?UzdhSWczV3VYVDhKelBia3dSOUs4aWRFMUdyMDE1WkF3aEFzbDlVYnp0UlpK?=
 =?utf-8?B?WVdUTHhRQ1IzcXlMcG05akNsbTBLQTVyVlF4UGRuTmdoaHB4R0w0a0VhSUhs?=
 =?utf-8?B?Yy9MaXpJK3kwVDRBZzErMUgvUE9hbWxGdDFxMjVrYU1yTkJZMFVHYWExbHBO?=
 =?utf-8?B?NThyM3RsR2docm5yYXV0Z3JnRG1ZenVHVGk4MXUvUkErMFRSbUpkZllaK2Jy?=
 =?utf-8?B?WE9SZCs4aGl1K1JoOUEvUTREVzc3Wkw0RVcvUG1qNldoRG81VHNIYnZqdVZt?=
 =?utf-8?B?SlJjMy9CSThYSFdXZnp5dmZRYzdWTEE2dEg3bWZTMWlnWWZjaXE4V3RscFBz?=
 =?utf-8?B?VDRHVElpVS81cVdzdlJhYjgyN2FKdmYxSHo0VTdDRndjUkIxYnBlc1k2cjJB?=
 =?utf-8?B?WjJibW4reUFid2hnM2ozK3NyZUV3aTZYdWNGUFV5VGtvZW9xK0hxNldHMlFP?=
 =?utf-8?B?akNnZ1Nqa09jMFAwOVFtOWtLSVNqUDVXZWVrQzg5SnZKNUtralFDaWlkVFBV?=
 =?utf-8?B?TklsSjhtOWk3YXBnY1EwbGJ5OUdCQS85KzBYbEFWK2RJMDhHT245TUVMWUdP?=
 =?utf-8?B?Z2VjOTk2S2FhQllqeSsxQWF6cU1MRXlrb2p0ald0S0RBV3RCaDVGZC9PenNS?=
 =?utf-8?B?NHJvNzJPdFJkdWwrRGN0cmpOL3QzNkFvK3FCSGxIaVFWNnE1YTFSbzJvcEV5?=
 =?utf-8?Q?u8Y+kXgKMU6tulVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1207727723535C4E950DFE5B40B75391@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q51z0lG4ZsVVF4o7zNw+sSySFzGxEvxmiNLpEN9Qlk7p71ZZfXkPugciVa/f2i0BarpVC5lZjsVgUAvqloz+OaiBiSQ0tZ6aY+NwBVX3JlJuQx3YvDlu1aw0UKNWnQyc9lEpTuDetILdfuvjTeY5lJ+EfYUv7TSRrDY9pG8pdbpdbtwpfyQZHWW14nbtaA5ekQbG32+1e6fm0MnTgAEHv/dEkc0Uz4PfGakOTqHmOJzK878cZt3O1dVs+Fh0WIP5+wvL1OAGUqE9SIlqk5JBcal0ycRvHj0EUtdSdLFDz+MappnKfdHnFEr8nfH5FUhowGgQFS1Ibu5xdlr9529UBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6d462c-099e-4003-7816-08df20639e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 09:00:33.5596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0KBRDE1r3JdN0Q0iJdqTAiPZbcZAXXHsQCdRlqEb/87kHrgvdpmeOMyU1wqeJMVDeXq+VbgSk9RIG1FD7g7caDCTNJSe+vvga50h+1KJEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
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
PiBQcm9ncmFtIHRoZSBBTFBNIHN3aXRjaCB0byBhY3RpdmUgbGF0ZW5jeSBpbnRvIEFMUE1fQ1RM
Mi4gRm9yIFVIQlINCj4gbGluaw0KPiByYXRlcyB0aGUgbGF0ZW5jeSBpcyBkZXJpdmVkIGZyb20g
dGhlIGxpbmsgc3ltYm9sIGNsb2NrIGFuZCBjb252ZXJ0ZWQNCj4gdG8NCj4gc2NhbmxpbmVzLCBm
b3Igbm9uLVVIQlIgcmF0ZXMgaXQgaXMgemVyby4NCj4gDQo+IHYyOiBVc2UgbWFjcm8gaW5zdGVh
ZCBvZiBtYWdpYyBudW1iZXIgd2hlcmV2ZXIgcG9zc2libGUuIFtKb3VuaV0NCj4gDQo+IENjOiBK
b3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jwqDCoMKgwqAgfCAyOQ0KPiAr
KysrKysrKysrKysrKysrKystDQo+IMKgLi4uL2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxh
eV90eXBlcy5owqDCoMKgIHzCoCAxICsNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IDIzNjM0MWFhM2M4ZC4uODQ3NzdjOGQzMWJiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtMzAx
LDYgKzMwMSwzMSBAQCBzdGF0aWMgaW50IGdldF9lc3RhYmxpc2htZW50X3BlcmlvZChzdHJ1Y3QN
Cj4gaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoAlyZXR1cm4gZXN0YWJsaXNobWVudF9wZXJpb2Q7
DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIGludCBnZXRfc3dpdGNoX3RvX2FjdGl2ZShjb25zdCBz
dHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3sNCj4gKwlpbnQgcG9y
dF9jbG9jayA9IGNydGNfc3RhdGUtPnBvcnRfY2xvY2s7DQo+ICsJaW50IHN3aXRjaF90b19hY3Rp
dmU7DQo+ICsNCj4gKwlpZiAoaW50ZWxfZHBfaXNfdWhicihjcnRjX3N0YXRlKSkgew0KPiArCQkv
KiBzeW1ib2xfY2xvY2sgKGZMaW5rKSBpbiBNSHogKi8NCj4gKwkJaW50IHN5bWJvbF9jbG9jayA9
IHBvcnRfY2xvY2sgLw0KPiBpbnRlbF9kcF9saW5rX3N5bWJvbF9zaXplKHBvcnRfY2xvY2spIC8g
MTAwOw0KDQpVc2UgaW50ZWxfZHBfbGlua19zeW1ib2xfY2xvY2suDQoNCkJSLA0KSm91bmkgSMO2
Z2FuZGVyDQoNCj4gKw0KPiArCQkvKg0KPiArCQkgKiB0U3dpdGNoIHRvIEFjdGl2ZSA9IDMyICog
KE1MX1BIWV9MT0NLIExlbmd0aCArIDMNCj4gKyA2NCkgLyBmTGluaw0KPiArCQkgKg0KPiArCQkg
KiBUaGUgIisgMyIgdGVybSBpcyB0aGUgdHJhaWxpbmcgemVybyBwYWRkaW5nIGFmdGVyDQo+IHRo
ZQ0KPiArCQkgKiBQT1NUX0xUX1NDUkFNQkxFUl9SRVNFVCwgdGhlICIrIDY0IiB0ZXJtDQo+IHJl
cHJlc2VudHMgdGhlIE1UUA0KPiArCQkgKiB0aW1lIHNsb3RzLiBUaGUgcmVzdWx0IGlzIGluIG1p
Y3Jvc2Vjb25kcy4NCj4gKwkJICovDQo+ICsJCXN3aXRjaF90b19hY3RpdmUgPQ0KPiBnZXRfZHBf
bGlua19zeW1ib2xfc2l6ZShjcnRjX3N0YXRlKSAqDQo+ICsJCQkJwqDCoCAoTUxfUEhZX0xPQ0tf
TEVOX1VIQlIgKyAzICsgNjQpIC8NCj4gc3ltYm9sX2Nsb2NrOw0KPiArCX0gZWxzZSB7DQo+ICsJ
CXN3aXRjaF90b19hY3RpdmUgPSAwOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBzd2l0Y2hfdG9f
YWN0aXZlOw0KPiArfQ0KPiArDQo+IMKgLyoNCj4gwqAgKiBBVVgtTGVzcyBXYWtlIFRpbWUgPSBD
RUlMSU5HKCAoKFBIWSBQMiB0byBQMCkgKyB0TEZQU19QZXJpb2QsDQo+IE1heCsNCj4gwqAgKiB0
U2lsZW5jZSwgTWF4KyB0UEhZIEVzdGFibGlzaG1lbnQgKyB0Q0RTKSAvIHRsaW5lKQ0KPiBAQCAt
MzYwLDcgKzM4NSw4IEBAIF9sbmxfY29tcHV0ZV9hdXhfbGVzc19hbHBtX3BhcmFtcyhzdHJ1Y3Qg
aW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoAljcnRjX3N0YXRlLT5hbHBtX3N0YXRlLmF1eF9s
ZXNzX3dha2VfbGluZXMgPQ0KPiBhdXhfbGVzc193YWtlX2xpbmVzOw0KPiDCoAljcnRjX3N0YXRl
LT5hbHBtX3N0YXRlLnNpbGVuY2VfcGVyaW9kX3N5bV9jbG9ja3MgPQ0KPiBzaWxlbmNlX3Blcmlv
ZDsNCj4gwqAJY3J0Y19zdGF0ZS0+YWxwbV9zdGF0ZS5sZnBzX2hhbGZfY3ljbGVfbnVtX29mX3N5
bXMgPQ0KPiBsZnBzX2hhbGZfY3ljbGU7DQo+IC0NCj4gKwljcnRjX3N0YXRlLT5hbHBtX3N0YXRl
LnN3aXRjaF90b19hY3RpdmUgPQ0KPiBpbnRlbF91c2Vjc190b19zY2FubGluZXMoJmNydGNfc3Rh
dGUtPmh3LmFkanVzdGVkX21vZGUsDQo+ICsJCQkJCQkJCQ0KPiAJwqDCoCBnZXRfc3dpdGNoX3Rv
X2FjdGl2ZShjcnRjX3N0YXRlKSk7DQo+IMKgCXJldHVybiB0cnVlOw0KPiDCoH0NCj4gwqANCj4g
QEAgLTc3Miw2ICs3OTgsNyBAQCBzdGF0aWMgdm9pZCBsbmxfYWxwbV9jb25maWd1cmUoc3RydWN0
IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJbHR0cHJfY291bnQgPSBkcm1fZHBfbHR0cHJf
Y291bnQoaW50ZWxfZHAtDQo+ID5sdHRwcl9jb21tb25fY2Fwcyk7DQo+IMKgDQo+IMKgCWFscG1f
Y3RsMiA9IEFMUE1fQ1RMMl9OVU1CRVJfT0ZfTFRUUFIobHR0cHJfY291bnQpOw0KPiArCWFscG1f
Y3RsMiB8PSBBTFBNX0NUTDJfU1dJVENIX1RPX0FDVElWRV9MQVRFTkNZKGNydGNfc3RhdGUtDQo+
ID5hbHBtX3N0YXRlLnN3aXRjaF90b19hY3RpdmUpOw0KPiDCoA0KPiDCoAlpbnRlbF9kZV93cml0
ZShkaXNwbGF5LCBBTFBNX0NUTDIoZGlzcGxheSwgY3B1X3RyYW5zY29kZXIpLA0KPiBhbHBtX2N0
bDIpOw0KPiDCoAlpbnRlbF9kZV93cml0ZShkaXNwbGF5LCBBTFBNX0NUTChkaXNwbGF5LCBjcHVf
dHJhbnNjb2RlciksDQo+IGFscG1fY3RsKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxheV90eXBlcy5oDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5X3R5cGVzLmgNCj4gaW5kZXggZTJjYzczYzk4NDc5
Li42Mzg3MjU4Y2Q2MzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZGlzcGxheV90eXBlcy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZGlzcGxheV90eXBlcy5oDQo+IEBAIC0xNDQ3LDYgKzE0NDcsNyBAQCBzdHJ1
Y3QgaW50ZWxfY3J0Y19zdGF0ZSB7DQo+IMKgCQl1OCBhdXhfbGVzc193YWtlX2xpbmVzOw0KPiDC
oAkJdTggc2lsZW5jZV9wZXJpb2Rfc3ltX2Nsb2NrczsNCj4gwqAJCXU4IGxmcHNfaGFsZl9jeWNs
ZV9udW1fb2Zfc3ltczsNCj4gKwkJaW50IHN3aXRjaF90b19hY3RpdmU7DQo+IMKgCX0gYWxwbV9z
dGF0ZTsNCj4gwqAJYm9vbCBoYXNfYWxwbTsNCj4gwqANCg0K
