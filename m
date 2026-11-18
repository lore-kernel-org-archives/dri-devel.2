Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5F606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bNwru+tj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jdCUIDa+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C98210FB80;
	Wed, 18 Nov 2026 12:12:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE99D10E754;
 Wed, 18 Nov 2026 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795003948; x=1826539948;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=09CK99sm1YOyRcaDcfnHhUiCd4DWD6PJ8ChAsZ2T1nM=;
 b=bNwru+tj1qiK+IRCBWJ44mboOcFLjkUZAEGr6dqwct/AFZeM9SI8xF5I
 E1m+nGfTmdGsBveL/rZwCG9dd5IvSRmfzRWGFt8+i8ecXJ7Sk6LqJBLEz
 TswT0xZ8ThIZSxC2CNmDruLiC9aWwMhXMg2ZFtk6Cr62sBmn6A90PrVZK
 2Jo7GHFw+t34rJDmBlOBGX8Y2/4jOdgRbMkOlrBKGMbMGmSi88pPOc/nX
 GZl5fWzoditX5D951UvsMTmU2jbmWFySPQW5Z3hfkI8lmkngxX4niULUC
 cIkwktqMbEtnWui8rfQKUenPBLBtfO+ZEmK22MgcF7hhpgqmJ0RryyoAx g==;
X-CSE-ConnectionGUID: dl63vgZ/QX6pi4BkG0iMqA==
X-CSE-MsgGUID: Ik9xj2NPRaq7l4hgwrp4sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3802041"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3802041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:12:27 -0800
X-CSE-ConnectionGUID: 8wmZH2Q6QkyTvonNM7betQ==
X-CSE-MsgGUID: 6K9JiiK/QI2ue0hRjg4IJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10272271"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:12:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:12:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:12:26 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc2vlEHMlQAd9IPGtzh9b8vgSaNQBIv1s0rvcGlYIqiuWiIA7VTJ6xxJ/a5cqtxvW2cCPZHrxUc3/p/G5Xs9nrwTzdcT19Vg223BiqpogSlKj8TWGOZEFxWA3aXIwDZEOcCQjTRtKD0vm0FZOuO8ikHoEkCOlg9MDyJuv9SwfyvVklrAFlRG6RHv6EpfP/GZwSoyPrnbaRrWZYN5NM6m9pCqZQjMGhTvKxQqY6wQhaZO1OgRv5MTo/oR6iDnBPjgmGFO7U5v5wyPJxKEB4dINiEb1P0S7ZxlNQ2h2b0HJi0bRrbYs3/5CFnsZqFi/OyLXqviPRK6WsJ63B71xKYM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09CK99sm1YOyRcaDcfnHhUiCd4DWD6PJ8ChAsZ2T1nM=;
 b=oAmW26Y5W82HlYoI5kHbCIN0mAEjiXOUp7/vK0SZCtKL+0AOZ8EwnXHLfs/01q9jUKsYIyIDiOyk3JS5xbaSJuc/6wuBtaHttwatSADXE8nY0D/UacG01JjyBOkbWhyOlQw1TeanO6Qf7Mq8HK7ojtnlIk/Swrk4SZiUWkMQvfXR6gmRbLBfLj+DMrwL6ckiqohe6joWunuYCemdE5ffK31r5Oduvcl9VBEimla6HzS5LsTr+UjLUf4EKz4WMeiRLRZV97Zaqn3QCsc9dYu8ZWAfANG89AjpR8Na2Xlf7BnG3HZB5tErXyY/avB0pJj8NsToI57q2iAwF1+yObM4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09CK99sm1YOyRcaDcfnHhUiCd4DWD6PJ8ChAsZ2T1nM=;
 b=jdCUIDa+/QON/7NjZpmB5AyZBWJ11ajBw6kQQ84REdDL9RxhunqpQQo50gUrpe1FGlFJm4cApGJaTYk//lRAd0rIco12FXudu8mwrWpWTAJswzwU3Xe9R6CnLtShZfandEyzAOwlaFlg1CaBgs4jb4TC//Tw/tRh5Dl6STTUJr4=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:12:23 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:12:23 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Topic: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Index: AQHdZQyRfn4M+thqS0qGkzGlDaI6qrcz4gaA
Date: Wed, 18 Nov 2026 12:12:23 +0000
Message-ID: <7cad06cfcd10fe599c07075018538dc8e520204e.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-9-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-9-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|CY8PR11MB6868:EE_
x-ms-office365-filtering-correlation-id: 2be153f7-bae4-487f-d11e-08df456d33d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009221227099003|261009223027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|56012099006|11063799006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info: oAzB/z+vRrL6H19RITLK5pK/Dj5oPzOfpWbCT4HCqiV2zQQJ3fGnhoJrMnriKWxEOEHenqRD5mRL9e2lpp8rnFLSKeGtiRvQweQNEbkIPWB6nuDkkREs3nu3ONY/Zy6xJATooXer2jD3BaLyi4wGFl9PidR9rwOJsW6byS5/oO6ti0JSLgomY3DLY4ldfnV7R/YVNg2TXJWCFsIH/2BETPIyqvmb9m7e2outyX0E5oQpe69qX2f3Qa3VolOAj7rvlZA0qIWXxxpouoLDnSLnjqeFvk1o1/H20nYzyLTj8aXbGXfVwpOtSBfV52jG8WZkBUO7buvrJ3rZdl4DnGHWh6SsDZUNXSfA/19j66qtwr2dcI2qO+SIU9BRj/sJmqRWj+j0Y14HDUpEyuvRczmSLKo6IY9Zen7bFfo5uHYaeb/XznAGduOblKgpga3bM5QAujGKoRrAE6eUTPs0mkscdXzoeblJgF1iKMqzYeHHJljDdzLcSKZUSQEIT3Q7vT1iReNRW+6YCNeKYsigy0lIL2y37FEkj+qARGbYNMcLQ+KDEaH5gN6dyMMJy1SlYVR3JvUVBW6H6wl9DDsgGKsEO2j+YV+yQeEHjJtT5QubKrKsPSAdwmrBHR45ohwFZ6a6rJusOg9TwyX20szWBZ5I5ZIAkhH2BgMtZI62d0ASjXNgatqYz2zcUhcx7u3aXmkFnwAJAi2uILjyGtve3+xigHG0qhViU5tS7Tgtit7qEWA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXByWkxiaXFkS1hBRWRvTmU5bWxpbWcrMzhoTEU5YmxkRm5HTnR0R2g0RCt3?=
 =?utf-8?B?L1UrM21lNlZHVE56NVBYd0paUUU1WUxNbFNhbHBFcUZ3djZxY052SDk5RzNR?=
 =?utf-8?B?dTd0TUt3R1ZEK3U4YnV4RnZkSEd0MmxqRHppQmpmUnR3anMxNGpNK1RZb2F0?=
 =?utf-8?B?d0FkdnpBdUhXaDR0RkdWMXpEQXpzUVYwREpPbTdpeTN5OEQwSFArcFlXclcw?=
 =?utf-8?B?RXVjNkYxUjBXRnlnNmZWQ3ZwWXdVWmxCSEZSN0F6Mm9PeW1PRE02QjdVN3d0?=
 =?utf-8?B?SFlaMFhHNTM5YWoySXNvVjlzbkVzbVdlU3hjSzd2TmQxQUJrTFNhVVIzSUlh?=
 =?utf-8?B?SEtSdkZIVDdnNzBWZjNKbmt3OVI2bndTR3h6QXpRSEs3R2R3WE5qVVFFTmY1?=
 =?utf-8?B?UTVDWWpnNmxNSEdqZ3UwQXFvN084QThPaTRiWjZJVGd4K3N0cjNhY25ZOTZY?=
 =?utf-8?B?MjJkTU1kMGJEVE5kYXFVWTdHdkFNcFBkWjh6NjRiQTFNZTAyTUVnMjFnclRQ?=
 =?utf-8?B?S0dMVkFOU2ZlUnk5NlAvY3JOWllKM0dNRGZGcytlSExvZEhvVFhtZDJCL2p4?=
 =?utf-8?B?ZFZmS2xmUW9pRk5vVlNSZW0raVI1SDUwM1c1WmR1dDZBRi9qTUpuN0tHTXdK?=
 =?utf-8?B?S1JJS0dFRUFiZ0dCQU15SEluNUdET1JEZkdzb1QxK290Q1pnd0JqOStwUzlz?=
 =?utf-8?B?MEdxSTJmWmhYQ0VYUWcxcVovRDdOTlpDRGdCak9hOVBHb1ptZ2RBazdhL3VC?=
 =?utf-8?B?Y1lTQ0FWaXBycHh3bnhmTzBjNnlOd2I0ZGk5bDFENGNsd0RFSFc4SWJvczAw?=
 =?utf-8?B?MnZpeEdzOGo1OVV1b0s2d0FaUWdIb2ZxTHhzZFhiZ2RFMDBLZkl3dlR2Rk1t?=
 =?utf-8?B?b0d6cDlkWmU0RzBjNHdDZ1VmVXJzVFBQMjRvRnBGMUpTeVVoZG1zTVE5MnNP?=
 =?utf-8?B?ZEh6Ui9ldVB1b2JDNmVCUlJCajZiMmhFWlBYdFRGTnlDdk9ua1VsSTcyT01m?=
 =?utf-8?B?SFkyVCtpVnhQaTRsMXI5cnZHZFVCL2I1UmZwYnRZUm5RclJNeHFCVThkSTVr?=
 =?utf-8?B?a3Iwcjh0Y1YzeExEMmxIR3dEblEvaUR2TWxBb3Q5ZjlSYWN6dkp2ZWdCenQv?=
 =?utf-8?B?N0lWM25HWHY4L3RSR2hROHZ5dzFFaXN6TmJuaWEvWVpUZmp4WCtRM2YwOGo2?=
 =?utf-8?B?d3lUNmh1WDZ6aDZTQ2hKNTVlallmY0R2QjkzQXlnb2h2UHczeXhpWXY1QUwr?=
 =?utf-8?B?TGpQVGZ1Q1BVc3dCM25oTHNIMmVNTjRWOVVYMHhIWkpjY0tIdlR3ZnBVVU95?=
 =?utf-8?B?WTRaL0Y5UmF1RHFiZTNEcmNHbHc3SGcxVEJFU2lBQ0NUTnpzMk91YjRxalh3?=
 =?utf-8?B?dnFXVzdPK2doZkJ2RHBlN2dKb3hBNUs4M0RGcEVUbGV5SUJwRFlBYzcvcTJZ?=
 =?utf-8?B?Sm8xdld4emdJSDlLdWwyZ003NElLQ1NCbGxtVmxJWFNzVFRmQWRja05JWXdq?=
 =?utf-8?B?NVhtUE0wZitOL0hhVmxscjlSZHRDUzhNSHhwV0s5UkNYVC9jczE1d212L2tq?=
 =?utf-8?B?Z1R3ZUtFWGVYYlZLNGsyTzhZQjNUVlNDQS96ZGdoSmVwR1FtMFEzVlRLOEll?=
 =?utf-8?B?S1Y2cmZyUU1XS0R5N0VDOE04VkFWUUtTcFJObVhhclBCcmFlM0ZkRjd4TlA2?=
 =?utf-8?B?RUF1RDNnR3ZIY0xYOHpCWllTWVpOSzF2N0NEc0l4VEVVS0R1S2t6TGhVOEJV?=
 =?utf-8?B?UmZ5UkhHY3RRZHNENEErK0o4N25CTk9sVG1lck1ReHV6cmRWQzlrMjA4cmNG?=
 =?utf-8?B?RUNITHFJVnVwR2twQmZLZVhVek9Zd2JGL1FSOEdhZ08vWTFBRVU1enNEa29S?=
 =?utf-8?B?ZFkzbm9MNStoMENiRjJoSGIvejBBQ1RoOFcyQnE1VEhXeVNnbk0zWklLSU5M?=
 =?utf-8?B?azhtVHB2VVp5TE43WGpyNWRnYmM3cmZOcDVKanNNUzRYbWNUak5oVFJVc2Jx?=
 =?utf-8?B?SmIybzlTZnFpUUsveFN5Z255WVJTR2dFSmhQRXpxd01JcmpQZ3VZQVp0bTJn?=
 =?utf-8?B?Rk9Fd0t3SzdtdWRsWUNZVzA0VE1jeVVkTmlXeUZiKzgwekxTSFpqRGY3dUsr?=
 =?utf-8?B?ejhoVGVPQnRQZkd1Z05jY25vS0h5NGN5YURnTVhaTmNNOU1GbUpYbnFjSjVZ?=
 =?utf-8?B?VWRFWnNZYWdFUFlmNWI2ajEzT2NNdk1vcTdQL0J3VGg5N0lRbWk5eXBZUFdo?=
 =?utf-8?B?aGM2U1gvc1RqUnM2L2h1N1JmNnRjNnFtNDdPbUFIais5VGdTWEEvbEFTNTl4?=
 =?utf-8?B?UHVqVlhubTExR3JJNlR2ZHpmWFB1UUt6SWFHRVl0cTNQWEtWRDVMLzlqVTVM?=
 =?utf-8?Q?MIoLkBJ1fjvpOrWo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BFB65A0FB8B124B92AC228B42C85D36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G6a3nVX/0aI89l3dbIaldVHcilKuPT1gkXJXgzVpeLwlpjqCsdyW9AVV2ui6yNi5GuWHn9ChFF7NEnmEkxUOMbmKaUjt2ynVYmjDJH77U+bXF7dBSGdN7g09d1iizogXY5g261v9vWaB0kB+8jrX9mSzKizd05xw5nC9RqIWstgd78kPZTRz5v28GhylZaC2TXbWeQjr8vJ1CkWIqJV3H+cpYWQ91V25qx0TNbAVgl0v4oqluJrdQCM+MtpSR9Ehlrqhaqsx2HXKapmFrxQ+hZnxmayW8/C6851bsRSHlL/Peq/pP9bwgk0bn/uLaEkE97hnFLROmuSOhcrYuLsnYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be153f7-bae4-487f-d11e-08df456d33d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:12:23.2862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvVVa5nLSXvfukz5IgDIJAjfSNK6dRzjsU8w5ZMygImzfVS3wo8MlBS7RXmW1uZZ+F9gzuujQFgmMSLvrnaNm9FSkaGWok4GcPxfAJMDOfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBUaGUgQVVYX0xFU1NfV0FLRV9USU1FIGJpdGZpZWxkIGluIEFMUE1fQ1RMIGlzIHdpZGVuZWQg
ZnJvbSA2IGJpdHMgdG8NCj4gOCBiaXRzIHN0YXJ0aW5nIGZyb20geGUzbHBkIChkaXNwbGF5IHZl
cnNpb24gMzUpLiBBZGQgdGhlIHJlZ2lzdGVyDQo+IG1hc2sNCj4gYW5kIGZpZWxkIG1hY3JvIGZv
ciB0aGUgd2lkZXIgYml0ZmllbGQgYW5kIHByb2dyYW0gdGhlIHdha2UgdGltZQ0KPiB1c2luZw0K
PiB0aGUgYXBwcm9wcmlhdGUgbWFjcm8gYmFzZWQgb24gdGhlIGRpc3BsYXkgdmVyc2lvbi4gQWxz
byB1c2UgdGhlDQo+IHdpZGVyDQo+IGxpbWl0IHdoZW4gdmFsaWRhdGluZyB0aGUgY29tcHV0ZWQg
d2FrZSBsaW5lcyBhbmQgZm9yIHRoZSBzYWZlc3QNCj4gcGFyYW1zDQo+IGZhbGxiYWNrLg0KPiAN
Cj4gdjI6IE1vZGlmeSBBVVhfTEVTU19XQUtFX1RJTUUgYml0ZmllbGQgZm9yIHhlM2xwZC4gW1N1
cmFqXQ0KPiB2MzogU2VwYXJhdGUgb3V0IEFVWF9MRVNTX1dBS0VfVElNRSBiaXRmaWVsZCBjaGFu
Z2UgaW50byBpdHMgb3duDQo+IHBhdGNoLiBbSm91bmldDQo+IHY0OiBVc2UgdGhlIHdpZGVyIGJp
dGZpZWxkIGxpbWl0IGluIGF1eC1sZXNzIHdha2UgdGltZSBjb21wdXRhdGlvbg0KPiBhbmQgc2Fm
ZXN0IHBhcmFtcy4gW0pvdW5pLCBzYXNoaWtvXQ0KPiANCj4gQnNwZWM6IDcxNDc3DQo+IENjOiBK
b3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jwqDCoMKgwqAgfCAyMCArKysr
KysrKysrKysrKystLQ0KPiAtLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfcHNyX3JlZ3MuaCB8wqAgMiArKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IGI5ZTMxYzI5YWI5Ni4uMDA4Mzc1MmQ5NGYwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtMjA0
LDYgKzIwNCwxMiBAQCBzdGF0aWMgaW50DQo+IF9sbmxfY29tcHV0ZV9hdXhfbGVzc193YWtlX3Rp
bWUoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJCQnCoMKgwqAgZXN0YWJsaXNobWVu
dF9wZXJpb2QsIDEwMDApOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyBpbnQgZ2V0X2F1eF9sZXNz
X3dha2VfbGluZXNfbWF4KHN0cnVjdCBpbnRlbF9kaXNwbGF5DQo+ICpkaXNwbGF5KQ0KPiArew0K
PiArCXJldHVybiBESVNQTEFZX1ZFUihkaXNwbGF5KSA+PSAzNSA/DQo+IEFMUE1fQ1RMX0FVWF9M
RVNTX1dBS0VfVElNRV9NQVNLX1hFM0xQRCA6DQo+ICsJCQkJCcKgwqDCoA0KPiBBTFBNX0NUTF9B
VVhfTEVTU19XQUtFX1RJTUVfTUFTSzsNCg0KVGhlc2Ugc2hvdWxkIGhhdmUgYmVlbiB1c2luZyBS
RUdfRklFTERfTUFYIGZyb20gdGhlIGJlZ2lubmluZy4gSSB0aGluaw0KdGhpcyBpcyBnb29kIHRp
bWUgdG8gc3dpdGNoIGludG8gdGhhdCBhdCBsZWFzdCBvbiBhdXhfbGVzc193YWtlX2xpbmVzLg0K
DQpCUiwNCkpvdW5pIEjDtmdhbmRlcg0KDQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgaW50DQo+IMKg
X2xubF9jb21wdXRlX2F1eF9sZXNzX2FscG1fcGFyYW1zKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxf
ZHAsDQo+IMKgCQkJCcKgIHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0K
PiBAQCAtMjIwLDE0ICsyMjYsMTQgQEAgX2xubF9jb21wdXRlX2F1eF9sZXNzX2FscG1fcGFyYW1z
KHN0cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgDQo+IMKgCWxmcHNfaGFsZl9jeWNs
ZSA9IGdldF9sZnBzX2hhbGZfY3ljbGVfY2xvY2tzKGNydGNfc3RhdGUpOw0KPiDCoA0KPiAtCWlm
IChhdXhfbGVzc193YWtlX2xpbmVzID4gQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FX01BU0sN
Cj4gfHwNCj4gKwlpZiAoYXV4X2xlc3Nfd2FrZV9saW5lcyA+DQo+IGdldF9hdXhfbGVzc193YWtl
X2xpbmVzX21heChkaXNwbGF5KSB8fA0KPiDCoAnCoMKgwqAgc2lsZW5jZV9wZXJpb2QgPiBQT1JU
X0FMUE1fQ1RMX1NJTEVOQ0VfUEVSSU9EX01BU0sgfHwNCj4gwqAJwqDCoMKgIGxmcHNfaGFsZl9j
eWNsZSA8IDEgfHwNCj4gwqAJwqDCoMKgIGxmcHNfaGFsZl9jeWNsZSA+DQo+IFBPUlRfQUxQTV9M
RlBTX0NUTF9MQVNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLICsgMSkNCj4gwqAJCXJl
dHVybiBmYWxzZTsNCj4gwqANCj4gwqAJaWYgKGRpc3BsYXktPnBhcmFtcy5wc3Jfc2FmZXN0X3Bh
cmFtcykNCj4gLQkJYXV4X2xlc3Nfd2FrZV9saW5lcyA9DQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dB
S0VfVElNRV9NQVNLOw0KPiArCQlhdXhfbGVzc193YWtlX2xpbmVzID0NCj4gZ2V0X2F1eF9sZXNz
X3dha2VfbGluZXNfbWF4KGRpc3BsYXkpOw0KPiDCoA0KPiDCoAljcnRjX3N0YXRlLT5hbHBtX3N0
YXRlLmF1eF9sZXNzX3dha2VfbGluZXMgPQ0KPiBhdXhfbGVzc193YWtlX2xpbmVzOw0KPiDCoAlj
cnRjX3N0YXRlLT5hbHBtX3N0YXRlLnNpbGVuY2VfcGVyaW9kX3N5bV9jbG9ja3MgPQ0KPiBzaWxl
bmNlX3BlcmlvZDsNCj4gQEAgLTYxNywxMCArNjIzLDE2IEBAIHN0YXRpYyB2b2lkIGxubF9hbHBt
X2NvbmZpZ3VyZShzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoAkgKiBjaGVjayBw
YW5lbCBzdXBwb3J0IGF0IHRoaXMgcG9pbnQuDQo+IMKgCSAqLw0KPiDCoAlpZiAoaW50ZWxfYWxw
bV9pc19hbHBtX2F1eF9sZXNzKGludGVsX2RwLCBjcnRjX3N0YXRlKSkgew0KPiArCQlpbnQgd2Fr
ZV9saW5lcyA9IGNydGNfc3RhdGUtDQo+ID5hbHBtX3N0YXRlLmF1eF9sZXNzX3dha2VfbGluZXM7
DQo+ICsNCj4gwqAJCWFscG1fY3RsID0gQUxQTV9DVExfQUxQTV9FTkFCTEUgfA0KPiDCoAkJCUFM
UE1fQ1RMX0FMUE1fQVVYX0xFU1NfRU5BQkxFIHwNCj4gLQkJCUFMUE1fQ1RMX0FVWF9MRVNTX1NM
RUVQX0hPTERfVElNRV81MF9TWU1CT0xTDQo+IHwNCj4gLQkJCUFMUE1fQ1RMX0FVWF9MRVNTX1dB
S0VfVElNRShjcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5hdXhfbGVzc193YWtlX2xpbmVzKTsN
Cj4gKwkJCUFMUE1fQ1RMX0FVWF9MRVNTX1NMRUVQX0hPTERfVElNRV81MF9TWU1CT0xTDQo+IDsN
Cj4gKw0KPiArCQlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAzNSkNCj4gKwkJCWFscG1fY3Rs
IHw9DQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRSh3YWtlX2xpbmVzKTsNCj4gKwkJZWxz
ZQ0KPiArCQkJYWxwbV9jdGwgfD0NCj4gQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FX1hFM0xQ
RCh3YWtlX2xpbmVzKTsNCj4gwqANCj4gwqAJCWlmIChpbnRlbF9kcC0+YXNfc2RwX3N1cHBvcnRl
ZCkNCj4gwqAJCQlpbnRlbF9hbHBtX2NvbmZpZ3VyZV9wcl9hc19zZHAoaW50ZWxfZHAsDQo+IGNy
dGNfc3RhdGUpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3JfcmVncy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9w
c3JfcmVncy5oDQo+IGluZGV4IDc4YTA1Mzg3ZWFiNS4uMTI0YWE3NGUxZGJiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oDQo+IEBAIC0z
MDEsNyArMzAxLDkgQEANCj4gwqAjZGVmaW5lwqAgQUxQTV9DVExfRVhURU5ERURfRkFTVF9XQUtF
X01JTl9MSU5FUwkJNQ0KPiDCoCNkZWZpbmXCoA0KPiBBTFBNX0NUTF9FWFRFTkRFRF9GQVNUX1dB
S0VfVElNRShsaW5lcykJUkVHX0ZJRUxEX1BSRVAoQUxQTV9DVExfRVhURU5ERURfRkFTVF9XQUtF
X1RJTUVfTUFTSywobGluZXMpLUFMUE1fQ1RMX0VYVEVOREVEX0ZBU1RfV0FLRV9NSU5fTElORVMp
DQo+IMKgI2RlZmluZcKgDQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9NQVNLCQlSRUdf
R0VOTUFTSyg1LCAwKQ0KPiArI2RlZmluZcKgDQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElN
RV9NQVNLX1hFM0xQRAlSRUdfR0VOTUFTSyg3LCAwKQ0KPiDCoCNkZWZpbmXCoA0KPiBBTFBNX0NU
TF9BVVhfTEVTU19XQUtFX1RJTUUodmFsKQkJUkVHX0ZJRUxEX1BSRVAoQUxQTV9DVExfQVVYX0xF
U1NfV0FLRV9USU1FX01BU0ssdmFsKQ0KPiArI2RlZmluZcKgDQo+IEFMUE1fQ1RMX0FVWF9MRVNT
X1dBS0VfVElNRV9YRTNMUEQodmFsKQlSRUdfRklFTERfUFJFUChBTFBNX0NUTF9BVVhfTEVTU19X
QUtFX1RJTUVfTUFTS19YRTNMUEQsdmFsKQ0KPiDCoA0KPiDCoCNkZWZpbmUgX0FMUE1fQ1RMMl9B
CTB4NjA5NTQNCj4gwqAjZGVmaW5lIEFMUE1fQ1RMMihkZXZfcHJpdiwgdHJhbikJX01NSU9fVFJB
TlMyKGRldl9wcml2LCB0cmFuLA0KPiBfQUxQTV9DVEwyX0EpDQo=
