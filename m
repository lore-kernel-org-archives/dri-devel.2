Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE0606AEB3
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B7iR7LRj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566A110E6BA;
	Mon,  2 Nov 2026 17:40:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3582C10E6B8;
 Mon,  2 Nov 2026 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793641212; x=1825177212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=F8ThJR0T2h6yDNNshMj3qs5fhsycnAZNHNI7WHcZMgE=;
 b=B7iR7LRjqAKBDYE/Vl/NSywfk/TAaKsoMnzBzSARncWF20RoLO3t/gix
 OMwYE7oXHOzN3hvUziLGEEwyaw/OBuyB0w3eFXRfJkzv2Z6/r8uvsrhAw
 FUDSiUA1pdb6lD7kzXRxlWDEPhsg2ROBFCWy0rhSM9vgv2dFsOgG6RXc4
 36vNoosV5p3bHM3PCxw4Qc843hKIFeKt05svbym+iGJafVT5NlA37Ul5j
 J7OMZo0O/q59x7LnLVTtv9f5eu9UAyY/KMnAhtc/Wz2WvMie7W58AYumX
 1Mf/CVTuD1Rh2kx7FfjHfNS+fzYL4ZcyYxEjhnSsft7f2em0KWmaLF5tp Q==;
X-CSE-ConnectionGUID: gciRXENiRdW6R2xHclqkHQ==
X-CSE-MsgGUID: qdC5GNa9SGqLSqMbVsgg9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2341331"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2341331"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:40:12 -0800
X-CSE-ConnectionGUID: 6QW+ijGHQBezfN7NCnPq3Q==
X-CSE-MsgGUID: cyWsaIfqSQ+25KeqsAdbuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7947334"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:40:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:40:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:40:11 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:40:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKch5ifgq0cLrgzv9UbFz+BTGeThI+AE2b6jyo1IxoXTA1p39R7PuXJibyCF8yQatjTIdhzL3JsFV7amAVsomx2wL/ErTA2zmBRJWOSrH3gO1GsdyFQpYTlAv/BSe/BGS23JsvENLJJnA6GsLmMkKZfi5NRcT2fXhgur4CDlxpyLXjwSoGYA1JdsIyn41eJnjuyG0r9c5qZ1SkOTl7UCnN7MrbdesZEriuC0l3LDayQdWFuBvb2EIjDpA+gDEPCprcAkxVKQiEEkr7b2ZjSPAcnd/4/elgBeoWfY8NKbOIe3Ojb6++vSW+3yF3/2QjCm2AS5KWDG5MubGlocRHQFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8ThJR0T2h6yDNNshMj3qs5fhsycnAZNHNI7WHcZMgE=;
 b=A2uDtLYCMe+iHHQ6c6MmzdFpbUhKhF6NPb855o2IOSW4sVtiH71ApXbekCrAoqDPLpVbBy21gA3tnnjGb5y5ko63P9BY/ScIEpav+SyyP8td4vmhr5rrtyF37jY2gR538nTaeYsi5Z5qsRtvFYa4BI/KlDNNfh1Gnhu8i1frXCniZDXxqh6D88BnP12CLJxC0Uy7HTdZ/xW3LWfwVdjJ+rNwwtRBqqnicShnHSpjtnte3VpPhha0qLAQ95IOHvC5fzqZVlB6Mn0+q1Bc6MfI+LcAs5UhoYFdJoGMEPM0oBZLUZFdYJnSrvnhUPRMo2tXyGhcFU7aRj/TgEZuAWvhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:40:08 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:40:07 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
Thread-Topic: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
Thread-Index: AQHdaJRsN0ncUCqoAEi2hbx+cZNi8bcWWd4AgAS3XYA=
Date: Mon, 2 Nov 2026 17:40:07 +0000
Message-ID: <7c97d394683aa1c91bdeb010e56126c5ebbdf61b.camel@intel.com>
References: <20261030173038.681250-2-alan.previn.teres.alexis@intel.com>
 <sashiko-outbox-191350@kernel.org>
In-Reply-To: <sashiko-outbox-191350@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|PH0PR11MB5206:EE_
x-ms-office365-filtering-correlation-id: f4c28352-f47a-464e-44ad-08df39085605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: snQeGfVPAX6ovUPo4iJ1jsRQXuS75si7CGjfEOQYnQJVvHJfAeQUcJ6E9WXr+ufgUYDX774bRtXJPO143EyYyBhDXslDPMBB2QRYJVsA3stMro/4uqKtAnERep1n6hS9so9HxXmN44YtiFrRVSDfF6aWRB8UwfYNhyy5QEhoDOHGxB4LoVoH1eQ4y4/xsmJHbBT4U/hLb4F/o0EmuHHuqUnyA32Egxa6eF+/d4r2BoLE396yAVskTTwl1gVA/m0tJ/+4hhMnnedsj0boVkK5hIj+L4nUJq0TazfrTQXiYzZJTvuKHtxzqeSmXNbnbFkeyY3YrVyV7hwnU2ibITLXgh2q3kCNvIn308IzpWfvrCwhPq/tj7tMhKhnFyRKSufd8VeOllR67sKmxv+lNWQxUZ408o0vDpeF0mYGBbYm+FzCSQowEVPP+a6BaR2yWJJ15lD/OaCr4K7Kkoc4g95f9VPEilJ5wzu3TQbwiauEYf3HXgJM4pYYM+Xyo6bTWDMEGgKiqIq6d/CYGj2m8GfLz6iUlSaExRmIT0r6avHlgFUiIS/kh8vHj+DEcZyXVTYnY/Le11To92AobAjXYKE/6ICKwetiAs0DuKqUEdrbejDSCPd4O7oOQfoYfQClMIE2maabvtHiHmjtVqf3haXCoNIo7/moKxXLwuwN6L13oGNXckCwrc4abMhwszh4FjYlH/aAe6KSB3O21tfALij9EQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZuUHZGMGFYc3Q5WndZdVIyRksrWWU5Qi9DQmZDTHo3ZG16ZTRvbDVSVEdh?=
 =?utf-8?B?c0g4ZkRsbkJKcDNBWVpKbFg3L0ZveCtlTnZzLytqN3VBcDNsd3JydkFML3Bm?=
 =?utf-8?B?dm0xQlU3VDNickMzSTdpd0ptaVhRb1ZET253WmZCNjF2Q3M3c2Q3K3BFeUlS?=
 =?utf-8?B?ZkRBQ0dzOGtOcFU3a0FHaVNIKzVXR3Z3d1dnYnN3SFhMRHlDWkJ0dUxRc0Qv?=
 =?utf-8?B?VEwvUnR4bXRUV0NWZzRhMGtpUVd5c3VuSEYySmFsN2FPR1I2aFZ6ZlpUcTBr?=
 =?utf-8?B?VE84Tms3YTZhTDFyM3gvTEtPTU9PTGQrRHRBczVudEpQRTQzQ3E5T3p5UkRQ?=
 =?utf-8?B?SzJYZTVnL3VUakhiaVp4eDZrdEE3RDluS2lLL1QyalRmdkJJYXBiWVFRbVVO?=
 =?utf-8?B?dXFaVHJkQnRoT0pCMzdBbjdqUVNXa1VzeE50SERFQUk0emIxM2hXZ0Z5MVps?=
 =?utf-8?B?a005RkZxZDl5MDN6dnRkUmJhMXd5b25lWTI5by9XZlhBdUxuSEJJL1JaL3Jk?=
 =?utf-8?B?UWZ5UzdJN1FRRjdMc2Ewc2hLT0pOVkF2R2JSTGJnOTcrT0tzTTNoa3o3dFY3?=
 =?utf-8?B?R3IvV3dkSHRDelZBZXM4NTcweDY1RzFJSjVGSkMvc3dPdXZDSjNackVHR1ll?=
 =?utf-8?B?T3V4WldNcVMzOVVWVDNYME02Ykd6QkpuUlhuQy8zbnFoK21WOU91TUFqbGMz?=
 =?utf-8?B?ZjFHMXpORFFOVjlOKy9ZZ3o2RzJrUERBRHhZeXpya3VxMFBpbnBZcXBhWTN5?=
 =?utf-8?B?WVZBcXAreE9WVlYyTWZIYkFNbU56SXlNNXhKLzYza0Frd0FhVUNGNHJqNE85?=
 =?utf-8?B?WDc5YS9yelh6S2w2UUV1VUcrMi9HVCtnZUR0SkdUQ3FreUFMUk9LVmZISUVI?=
 =?utf-8?B?TGFQaDlsblJWTGt5eHR2c1FxRS9oS1VLWlFMRHVXSDNDbU5kMVozZnl5a2VW?=
 =?utf-8?B?YUZBQ2lKbGxUY0MwYVkwUWs2UW9YT0VaSjlsUFpKRFpBWW5GcjNIVnVwTGN1?=
 =?utf-8?B?WHpVWUtNZ3ZzaExiMXZURW92aFhaZXRDcktjZmZmOFg5RXhmaURTbTlzRGFI?=
 =?utf-8?B?SERUcFNoMCs4SzE3QmNyQktESGJ3c3hQbEdheWZtVFlYVVVzNVhFZ1pSTElX?=
 =?utf-8?B?b0VaVVZBWFVuVE9SQ1dVVzVOYjhuemNUNEFLdXozVVJnOEk2eHJCWGZjUmpW?=
 =?utf-8?B?bHUxUHdIa3JlQmg3cmtjaXA1S2VUT0pGRTM2c1JYUTE5QWhPdnk3dzgxOUxN?=
 =?utf-8?B?SE8yMnFqVHEyYldZdkZPK01TQTN3WnIvbC9WWFk3WjdYSk1PWEwrUUYrQ3d4?=
 =?utf-8?B?emhKNFFpUDJwRHFkOE1vN0tsMHowMzlPNlZPWEZEOWxQZU9uOE43bzhJSitW?=
 =?utf-8?B?NHU0YTRPS21EM2ZxNkVsdkpQQ3hjMitJV3U3Sk1pMy9XT0Z3bjhQNGNqWkxo?=
 =?utf-8?B?R1RQNFR3WVFvd0pyQzMrQWd4bjRmSUhzaS9wSnNja0hCNjZ0SUJxNVdUbW9D?=
 =?utf-8?B?TFdsUzVaYjRtOGhSa0ZBcHpVN2FLVHhuTXhVU2JpSXFzUFBrTWtFTDFDZW1H?=
 =?utf-8?B?UDdRK09lbXJjZGZMcjM0UGhyMVRrTVJPL0V5MGozNE1zYWFOajVnZjdDamJX?=
 =?utf-8?B?dTZmRHNRRnZjT3ZEWldIcWluSjNYTWsza05vSy9ydktETnQwSE0rWXFBb2tJ?=
 =?utf-8?B?SERiTkV4UHd5eEwwbFVScFZRNklsMFZmcjdJdEpjcThBWkhLMmkzeG4zY2ov?=
 =?utf-8?B?eWVON2xoQU5JeU1QS1F6dEZVQWF6UzdjamRRakR5YkpMaS9BYzhNZDltQVRW?=
 =?utf-8?B?MVRQN0NETGh4V2dVQVAwNlY0clNGMitQOTdyRGd1U1E0VGd6T2RKTkxLRllT?=
 =?utf-8?B?Y1M5elQxbXdlVmdpeWwzaEdCK0xrVllRVVhrVU9mTmJSMTdGRWdlaU83MGRB?=
 =?utf-8?B?aGVDNFdLeDVJL0VDYldvQWVVeVZqTnVkU0t2YW5pY2pLYXF2VEFOdHU1WDA0?=
 =?utf-8?B?SjQ3dHBiaGlHdzNPbWw2U3BuTGxzVTJtL0RBMUQvZGx2ZE5zUnFheldLZXJJ?=
 =?utf-8?B?MFBSKzQ5M1ViYmNwbzdFTXNXemJWL0VpY1FycGRNYzdhbzZpemlLSjdoMDIv?=
 =?utf-8?B?VDRvVnhGcjRDSFdtUjl1QWFRRzFSWmN0N3ZSMEx2SmRkVUl6TmlzQm5sd091?=
 =?utf-8?B?azVCVUlLa0tCUk1sTmtLZ21KSTJFdU5IekJnZUxuelBjdEwvUFcxQTdSeHlK?=
 =?utf-8?B?K21hK2xqN3JFRXNjS2tvbE1HdytaZ0YvUFArVXorVFhUYUZyY0MwdlFUbjBO?=
 =?utf-8?B?M1I1UzZiSGZOTkZqRXBxTGJrZmFhcm96QzdaeVFrb3pIeWtnY1I3WlZueHpH?=
 =?utf-8?Q?bbcACuN6XVy8Zz22NVsJ98Eg+3auskD0dQXtr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EBC8F6E39EB67429C4AD4C4877AF47D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GlHZ3SINlU5VZs6VNroZcwFnIPOgpLr3y/eBuAtW4gK29efCB4HJ3OEoAoPXeKYNhBx5fr1Gg1LyccESphmptKCeGJ6KP0k+DBuhCmWz/uAcIHZysR4QyW8NjRtJAtLYKMrMY0efNevC0E8gm6n6ahNP4WNPBJdfBkfctR05ke7AmNpeMVkra0zgEZf544l+jKIXTUzaPQszJVZr9Tz4UQnwbPIT5EHzBMqOhoCb4FQG/fEKT4SM0U1VaZqdSRQ7xyQ1d+AZdNulqUEobTUvmIzeYFLF+egf66Uoi+XP+H3xL4NYBvtol0DUtsklw/RSPt8rgMzbxcKgj5HseqMQAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c28352-f47a-464e-44ad-08df39085605
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 17:40:07.5049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8FOX6hJmnGhiLUZBRDwL7j5pXPQtSvwo/U16iIM68iqZvrIODorDS3JMRr9I2NoLHoM41PNIwgBK0lb8ecPB2BOeMmpNfmbi0cLkjUvrHYBZIj7a5FGDEnRF1PZFBAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qm90aCBvZiBzaGFzaGlrbydzIGNvbW1lbnRzIGFyZSB2YWxpZCAtIHdpbGwgZml4IGl0IG5vdy4N
CldpbGwgYWxzbyByZW5hbWUgdGhlIGJhY2tvZmYgZGVmaW5pdGlvbiBmcm9tIF9fWEVfTU1JT19X
QUlUX01BWF9CQUNLT0ZGXzEwME1TwqANCnRvIF9fWEVfUENPREVfV0FJVF9NQVhfQkFDS09GRl8x
MDBNUyAoY29weSBhbmQgcGFzdGUgbWlzdGFrZSkNCg0KLi4uYWxhbg0K
