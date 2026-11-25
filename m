Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED225606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PsKHlnD7;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YNt9lVXe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B86B10E380;
	Wed, 25 Nov 2026 05:01:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2294010E380;
 Wed, 25 Nov 2026 05:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795582855; x=1827118855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5wbfchoufeWyihHUDQRVLtQR/LIyENcPPDnizytSj8g=;
 b=PsKHlnD7JpDe6aam3Gg4xKh4xoAuZ8bDl2pSlzeLrpe3QT2yoq3+5I6P
 SRHiR4NYCLyotQI1+yBD6nIsLsDAdPl8jMKXcRUbZujHxELyEGirKywQb
 AcqiqZqTL5dp0TEfW4+7YH1sZ59YkeWIlebMSniXMlgYICh59n5GdKi0/
 pDvGJ1V2Xe3g0gH+GoAJLy+GU65T3OYwi+b1fyhzY9ESV1e9BdS8Uc7im
 p0kl6e3NjJMrsyGA868K9A5snjE8TQqBjh26gujm7mjWOdiAZLrKp/WqR
 yAkMzIjMvDEVoTPpFLJ24VNhTnrCCYdhHV5Clk3S33qhxgohheuHPUeOq Q==;
X-CSE-ConnectionGUID: qDPfFUi7QX6rnBr+Mf/u4g==
X-CSE-MsgGUID: K7KCSSAKQMm42YEQDp0tDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4527045"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4527045"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 21:00:50 -0800
X-CSE-ConnectionGUID: iKHqlcDSTFWRtZwPl8k+QQ==
X-CSE-MsgGUID: 1niezAY+SvKhCxYuW2SYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12201726"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 21:00:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 21:00:48 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 21:00:48 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 21:00:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzSDeIMsJ8khtWYAL79exT1as/z2tJjz2geXpXGW5mow0bP00bAmN7ZFlCtXXmcw1EkHxL5cPEXDI7jENcnUgn6KD9Ve0RP+EiOAI0oajrt9jEayOSlGXvmm1/59JP30lP8kJXlDBL0EMoBAvgdGbvrM5SOWVoqlN7GVLQ/eHN+/7smPCFEhefrdgdpjzlZFBaQz4rPGQM9uVKS6e+0CIHLqXeUNhptuLSiTF24qxVIQYEEKvyAzkZC6/X/Kcb9pHocVXMyjdGmIoEPTCUP226IqwCz2HmNUNk3LmT9oyBjxgvxElJec254brtpNAz+zMBZD9pWV2EKYz640ibs9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wbfchoufeWyihHUDQRVLtQR/LIyENcPPDnizytSj8g=;
 b=vvl6hoxMIoSTvCnUPyMy81VsGQ+bn8UxQi4EAd2VlFiRWxCB/4vM3B9eLLJO5CphjdMj2z1nvKC+od9k+UEVuVMLRFR4StSKwpLvAATcJAn5oI8C8LorlQdZB+IPcuzQcvklsYQNkJKmwm7+53o6YudENpniDSayhdeBb2S4J7DNs9pKCUfxJ8Rs/a3yLbCIDHhUyM6vfRZhWsMvgQt5RoUlSMStC88xW5ztXGTqAFSk4ha6GOYPVnyMUFUyXsJUZCcEZMqH3eHluaEbbze7Gl6uiuIDv6scodPhOdx2z2Wp8j6TPqEPRdGuom7mikSBBMHt9D1EC3Bopq9+x62YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wbfchoufeWyihHUDQRVLtQR/LIyENcPPDnizytSj8g=;
 b=YNt9lVXe5XfuHKzdB+I1w24LxVU3QZwaHmV8EOu8g2yOPo+qV0Q8xf00+1c1jme9KeyyCP6fy4A0shizcsSLE4tmzx+5Pgioyy+rCeaNDoBcdRun/ua4O3I0RVKDD+acT1TOrymNDhmKy2nS5Ygp5BZtjzhs10c2ZodpWXMjJic=
Received: from IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13)
 by FT1PR11MB780136.namprd11.prod.outlook.com (2603:10b6:170:2d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 05:00:41 +0000
Received: from IA3PR11MB9325.namprd11.prod.outlook.com
 ([fe80::51e4:9ff6:bdf6:869e]) by IA3PR11MB9325.namprd11.prod.outlook.com
 ([fe80::51e4:9ff6:bdf6:869e%6]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 05:00:41 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, Liviu Dudau
 <liviu.dudau@arm.com>, "Laurent Pinchart"
 <laurent.pinchart+renesas@ideasonboard.com>, Tomi Valkeinen
 <tomi.valkeinen+renesas@ideasonboard.com>, Kieran Bingham
 <kieran.bingham+renesas@ideasonboard.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJhIENhbmFs?=
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Brian Starkey
 <brian.starkey@arm.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, John Harrison
 <John.Harrison@Igalia.com>
Subject: RE: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Thread-Topic: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Thread-Index: AQHdcXWpnwUyUaV+ek2lY8tlViTtKrc+Tw8AgAABioA=
Date: Wed, 25 Nov 2026 05:00:40 +0000
Message-ID: <IA3PR11MB9325E12D779BB5DA335C6B33E3432@IA3PR11MB9325.namprd11.prod.outlook.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
 <179558244222.1572056.13569389105654454020.b4-ty@b4>
In-Reply-To: <179558244222.1572056.13569389105654454020.b4-ty@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9325:EE_|FT1PR11MB780136:EE_
x-ms-office365-filtering-correlation-id: 64464ea2-3202-4110-f54b-08df4ab10db6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261009220027099003|261021121427099003|921020|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261022115727099003|38070700021|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info: IWycOAe/f6fjvSGL2NNFik9i9SGELatiGGYtXYHM2dFPKF5Fy57od6t4OubWt/lntRRPmu/FVHt2tAyNJyV9suCeCDac+szA8kGgREnMf/pPACTKoI51vqf82ZnUm0DkfwGIui0Gki8x+h/OAJ5Wr0YQKTKI0axlyUm1SUVMt0AHiG2hF0a8ZRPfY4ds01kO/ra0VNPVXymaLNxhegQlD1v4IwzXm5u4k87ebqo3sdhNYgJcKGYUso8W2ylmzH3/KpxgnX0N2fRK8gCmkQx+XajTs9RAt5d/jkoZRBAHwKH9ThCvSWe9rcs2jYcKpjPK8K4xACS70k7+Y2HXWWeeCgbaMwwwk7qWliU32ACmcn6rp5c+kSGHPnhflPuu5r1HRUgZZBRjE6CCFID5mOiq5IeTn1QxnunWYUr3u5CtXNuz5wa4I0tCI0Pq4rRbOJBs5HalLeVEkkMN+ajYMZClmNcBRlf5wOFzz9bAWBv24BZunY2oqqCT3sRKO/zzyaag/NRrFmndYuW6O8oG0k1nHaF5z4fs/DojwWgkQ8P2+wUfns7Jj8zh9cCN50C0JUDPf8E92Cn24Sszh/aorD499RMu2+p0vM0CZYq4uMdkXOJCwCtMOnIDKvOkLGJv4J/lIhTueiF1R74uifsi/kQM5OmevYi7mIi1JZBvly8+9VFUO+wb6MUtOaqN0DpDPuhY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9325.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009220027099003)(261021121427099003)(921020)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022115727099003)(38070700021)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0hGTzhQa1pGMEdHeWNnVldlWXpYRVUrYlBhazNsWW9rU29UUTE1UDRZeTN0?=
 =?utf-8?B?Zm1oeDAwb0ZQM0dtYiszSisvMFo1dVA1VDFRYWVVZHZ6N1JEUzl2ZytlTmlm?=
 =?utf-8?B?VjhBTThzL1dCeXdPc1BxdXBnR0ZpNDl4bDlkYndGdWprVDR0a3VyVnJKNXND?=
 =?utf-8?B?QTAzenRGYUMrZk8zVTlPOGxwYmZpdnh6ZXdNTlNlanpTYkNkdWJYTWU5ei8w?=
 =?utf-8?B?cWo1Z014MHByV0pLbm1hOVhWbkxPakJRcFFWTm9xL1hxcVkrbXVQaElKK2pJ?=
 =?utf-8?B?a0JhczV1a2lTYXAwWXdCUC9TK2p6N3ZJZVpKNnI2SkFtSFRUR1FQaE9iaVcv?=
 =?utf-8?B?UkJuYkZ2czZKdjFidnovSks5d3oyUkQ0UDZLOUM0SEk3VjYwdjhKcXcvNFRH?=
 =?utf-8?B?VE15MFg3ZGt0S3N0eXA1UEMxQXpNdWIwbURXNTZXc2FUV0RBSEFBMHZCc2dB?=
 =?utf-8?B?VGNBZlRzU1Vwb3VKdkREditlNUJncVhmaWhRMS9QRnkzcDUvNzkvTVRLby9R?=
 =?utf-8?B?T1l0bHRkTncrNXh4RkFheklMM3NnWCtnUTA1aDNyVm5CZTJ6TWVDQzVhWE9D?=
 =?utf-8?B?OFVzYy8yY2ZWUzBKK1ZrNjdacnNWRHNwTmkwWmFuTUZ5WkxaSURoenEwR3dM?=
 =?utf-8?B?OTZiZ2JxUEoxaUZneWVWMDlpcmdxN0hxOGVOdU9WUnpGQ2wxL0kwUjRvY1B6?=
 =?utf-8?B?a3RZaWdWcU8xOFAxcXBpN0xMU3RiRWJ4d0cvNUt1NGRjZ3RXQjE5d0FaNHpw?=
 =?utf-8?B?ZlpjcVZoOXJuV1E4NnFtTWNJQmp2azQzK2Z6eG4zVnlETC9HRXBPVzZON2Zl?=
 =?utf-8?B?OTZXNVpkeDNwRHdMVFJ2LzN6T0tZTS9PV3AvT1oyRi9URzZyNnJCZHNoay9E?=
 =?utf-8?B?ME9HOFl2TXpIMHY1eDQ2UDdWUXY5MnE4bEI0TDlSTGQxRkR3aWV3L0VVS3I4?=
 =?utf-8?B?RnAzNjVHZGhOQ05ybUYyaVBUMzFaOVlHYVVMZHFuT3RheFN3ejFCYkRtc3pF?=
 =?utf-8?B?bHRlRGtLR0tkME5UQTV2Rnc1RFRrRStYWGpjSUlrOGtrd2s2bzZHWVZhUzl1?=
 =?utf-8?B?d0JXSm9CMVlJbi9OWUZkOHB6d3llbS9yblFvTmN4RzlIK211bXlvV2ZOcEww?=
 =?utf-8?B?U1Y5bThoRmxud0FCbkovdVFad2s3d2lrZWlMWXg5RUdpZmJoZkNQQW1pazhD?=
 =?utf-8?B?aVRCaTV1NHpOLy8vcE1ibUJpMWJId2tidVBjTnAvZHlTY3hlVXBLd3JKYnNC?=
 =?utf-8?B?dEhWZTVQeWh1YkV1MVcyVDNGOUhueXNoc1o2eTREM1gwekR0NTZPMmFkakJR?=
 =?utf-8?B?L3krc0t6QS9uSlpwanJwWFZKRVNQbS90aFFLQ1NkVGdXVlVPRmZQZFYwanZC?=
 =?utf-8?B?WTFvNGF0eWM1Wkx2ZTRhODZDVG9IRE82MXJCQUlWQnRBTE85YThvcVUwV1da?=
 =?utf-8?B?cHowREhqYmdZWFM1OXQwb3dLUGNUQnozTmtzUi8rQXFjdi84YndIS0U1SWFa?=
 =?utf-8?B?QkZsWU1yWmIvY3hXOGowV1RFa3EwbTV3RnpiaWpxT2gzWHlBQStrZXorenpa?=
 =?utf-8?B?aFhzd1YvREhPcUlUNVVGWXRQUlNvRzMwTGVmcjR3aHA5VlVJMlhxV3V3WUVC?=
 =?utf-8?B?c0wvbmdSTVk2T2ZKY1VGV0x6UEZwUEp5djZ2bk5Sc01QTVVBU3ZDQmd5M2lY?=
 =?utf-8?B?ZUNJSUFkNkVzZnVSSEVVTUVOWk5kVXVEOE9kMmNZOThtTk1SSDN5L2pUVitn?=
 =?utf-8?B?dDVnWGI5dnhEOEFEbjV1SEJLQUJtSExPSHpYYVVlWWZSVWhEZW9OTlFWYmRj?=
 =?utf-8?B?UmsyN2hzRUh3T09qL0ZuNkhuazgwSVk3d1lkUlJ3enN5MExQODBaUFhKMi93?=
 =?utf-8?B?YTJBMTV3SWh5SGRnN0M1WWFEZ1NoZ3lPUjBNN3gvQjZ0Z3NCb1YrR2JycFB5?=
 =?utf-8?B?bmN2OXRDZXF2amxOdDRRcmF2V0UyNEVvb0FPK0NvOG9HTW1wV0FyLytJQ29x?=
 =?utf-8?B?REhCMGFvNUpVSzZ4U1N2RWRmb2RhUDh3TzJLQjB5WGFLbHIzRmJDeWVVWmdp?=
 =?utf-8?B?K3NmaVNsYkpUQ3pKVi9NajZWRjFKREpnK1B3NDhMUUZrdE40V1g0cnkzODJl?=
 =?utf-8?B?dTBsSGhSSjBQZ041WEw1NjhJa0YxRm1yaFhSVjd4aGJpcUlzRXdkUCtwb2Y3?=
 =?utf-8?B?NE9wdU9Cb2t2SFNzZU02c1g5cklOZGx1ZmtXZFFUbzRET29TNWcvY2tkZTk5?=
 =?utf-8?B?RXlMWnNyZWFjQlJnNFByUDBFTjZxNWNQb2NTdGRWbHpqenNlTjA1VEEreW5J?=
 =?utf-8?B?bHdFb29ZdHZSTEg2N25lY0VVa2ozVGFMaFlpUzZMbFdlR3cwNnQxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JVrIYEnbDGYsaHbhXAIvfYEhnIus0BJDAta/Vvjv7Qm1tZJ1RI69ot2hZAnNCSlmkFC1FJrLaqivalqpp84VGF2BXiyfwAJ1gQ5KlCS4sK3VSMRiGTZweoy+GJ+i3QXCqQlnzmZ8g2nitC12n80O2D+nGK4OHu2AV+mu4wcP33T3WqafGXTmQcKzDrllCQxLy0LCzZ61xvNsq4wBNydxH1fnV6aHbancTAsKsdHXonf0xZkzvx03XlJ2Eg25ZCrMqD+mXNcoznj6lvZsAyNf1M3T4YTnUyFbpx43eNRaGBWX/phKA7iE8VaEOh6NpGUGLuwDdolD/jSG3mzOjKAC7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64464ea2-3202-4110-f54b-08df4ab10db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 05:00:40.9203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5iobmcjYYXjz9ml4auVMaIdL7tiy8wQIjUf4+KuBAd4PdksPkXgcjQyblfUgLWGR1knHC3Ah5Nd0hcxOcJsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB780136
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IEJhcnlzaGtv
diA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPg0KPiBTZW50OiAyNSBOb3ZlbWJl
ciAyMDI2IDEwOjI0DQo+IFRvOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RA
bGludXguaW50ZWwuY29tPjsgTWF4aW1lIFJpcGFyZA0KPiA8bXJpcGFyZEBrZXJuZWwub3JnPjsg
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+OyBEYXZpZA0KPiBBaXJsaWUg
PGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgSm9o
biBIYXJyaXNvbg0KPiA8Sm9obi5IYXJyaXNvbkBpZ2FsaWEuY29tPjsgSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+OyBMZW8NCj4gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT47
IFJvZHJpZ28gU2lxdWVpcmEgPHNpcXVlaXJhQGlnYWxpYS5jb20+OyBBbGV4DQo+IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnDQo+IDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+OyBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT47IExh
dXJlbnQNCj4gUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVhc29uYm9hcmQu
Y29tPjsgVG9taSBWYWxrZWluZW4NCj4gPHRvbWkudmFsa2VpbmVuK3JlbmVzYXNAaWRlYXNvbmJv
YXJkLmNvbT47IEtpZXJhbiBCaW5naGFtDQo+IDxraWVyYW4uYmluZ2hhbStyZW5lc2FzQGlkZWFz
b25ib2FyZC5jb20+OyBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVy
LmJlPjsgTWFnbnVzIERhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IERhdmUNCj4gU3RldmVu
c29uIDxkYXZlLnN0ZXZlbnNvbkByYXNwYmVycnlwaS5jb20+OyBNYcOtcmEgQ2FuYWwNCj4gPG1j
YW5hbEBpZ2FsaWEuY29tPjsgUmFzcGJlcnJ5IFBpIEtlcm5lbCBNYWludGVuYW5jZSA8a2VybmVs
LQ0KPiBsaXN0QHJhc3BiZXJyeXBpLmNvbT47IExvdWlzIENoYXV2ZXQgPGxvdWlzLmNoYXV2ZXRA
Ym9vdGxpbi5jb20+OyBNaWhhaWwNCj4gQXRhbmFzc292IDxtaWhhaWwuYXRhbmFzc292QGFybS5j
b20+OyBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0PjsgUm9iDQo+IENsYXJrIDxyb2Jpbi5j
bGFya0Bvc3MucXVhbGNvbW0uY29tPjsgQnJpYW4gU3RhcmtleQ0KPiA8YnJpYW4uc3RhcmtleUBh
cm0uY29tPjsgRG1pdHJ5IEJhcnlzaGtvdg0KPiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNv
bW0uY29tPg0KPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBs
aW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IEthbmRwYWwsIFN1cmFqDQo+IDxzdXJh
ai5rYW5kcGFsQGludGVsLmNvbT47IENoYW95aSBDaGVuIDxjaGFveWkuY2hlbkByb2NrLWNoaXBz
LmNvbT47IEpvaG4NCj4gSGFycmlzb24gPEpvaG4uSGFycmlzb25ASWdhbGlhLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2OCAwMC8xMF0gZHJtOiB3cml0ZWJhY2s6IGNsZWFuIHVwIHdyaXRl
YmFjayBjb25uZWN0b3INCj4gaW5pdGlhbGl6YXRpb24NCj4gDQo+IE9uIFdlZCwgMTEgTm92IDIw
MjYgMDI6NDI6MjkgKzAyMDAsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4gRHJpdmVycyB1
c2luZyBkcm1fd3JpdGViYWNrX2Nvbm5lY3Rvcl9pbml0KCkgLyBfd2l0aF9lbmNvZGVyKCkgZG9u
J3QNCj4gPiBwZXJmb3JtIGNsZWFudXAgaW4gYSBtYW5uZXIgc2ltaWxhciB0byBkcm1tX3dyaXRl
YmFja19jb25uZWN0b3JfaW5pdCgpDQo+ID4gKHNlZSBkcm1fd3JpdGViYWNrX2Nvbm5lY3Rvcl9j
bGVhbnVwKCkpLiBFbm91Z2ggb2YgdGhlIGRyaXZlcnMgZG9uJ3QNCj4gPiB1c2UgdGhlIGVuY29k
ZXIgZW1iZWRkZWQgaW50byB0aGUgZHJtX3dyaXRlYmFjayBjb25uZWN0b3IuICBJbg0KPiA+IHBy
ZXBhcmF0aW9uIHRvIGZ1cnRoZXIgcmV3b3JrIG9mIHRoZSBXQiBjb25uZWN0b3JzIChhcyBwbGFu
bmVkIHRvDQo+ID4gZW5hYmxlIFdCIGZvciBpOTE1IC8geGUgZHJpdmVycywgd2hpY2ggd291bGQg
bW92ZQ0KPiA+IGRybV93cml0ZWJhY2tfY29ubmVjdG9yIHRvIGJlIGEgZmllbGQgaW5zaWRlIGRy
bV9jb25uZWN0b3IgaW5zdGVhZCBvZg0KPiA+IHN1YmNsYXNzaW5nIGl0KSByZW1vdmUgdGhlIGRy
bV9lbmNvZGVyIHdyYXBwZWQgaW4gc3RydWN0DQo+ID4gZHJtX3dyaXRlYmFja19jb25uZWN0b3Iu
IFJlbmFtZSB0aGUNCj4gPiBkcm1fd3JpdGViYWNrX2Nvbm5lY3Rvcl9pbml0X3dpdGhfZW5jb2Rl
cigpIHRvDQo+ID4gZHJtX3dyaXRlYmFja19jb25uZWN0b3JfaW5pdCgpDQo+ID4gYW5kIGNvcHkg
ZHJtbV93cml0ZWJhY2tfY29ubmVjdG9yX2luaXQoKSBpbnRlcmZhY2UuIFRoZW4sIHdpdGggdGhl
DQo+ID4gZW5jb2RlciBiZWluZyBnb25lLCBoYW5kbGUgcHJvcGVyIGNsZWFudXAgb2Ygd3JpdGVi
YWNrIGRhdGEgaW4NCj4gPiBkcm1fY29ubmVjdG9yX2NsZWFudXAoKS4NCj4gPg0KPiA+IFsuLi5d
DQo+IA0KPiBBcHBsaWVkIHRvIGRybS1taXNjLW5leHQsIHRoYW5rcyENCg0KV2l0aCB0aGlzIHNl
cmllcyBub3cgbWVyZ2VkIGNhbiB3ZSBhbHNvIGdvIGFoZWFkIGFuZCBnZXQgdGhpcyBzZXJpZXMg
DQpodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzE1Mjc2MS9tZXJnZWQg
aW4gZHJtLW1pc2MtbmV4dA0KRG1pdHJ5LCBKb2huID8NCg0KUmVnYXJkcywNClN1cmFqIEthbmRw
YWwNCg0KPiANCj4gWzAxLzEwXSBkcm0vYW1kL2Rpc3BsYXk6IGVtYmVkIHRoZSB3cml0ZWJhY2sg
ZW5jb2RlciBpbg0KPiBhbWRncHVfZG1fd2JfY29ubmVjdG9yDQo+ICAgICAgICAgY29tbWl0OiAy
ODNhM2NmYmIyOWNmM2QwYWYxYWQwMzAxMmZjZDA0OWRlY2U2ZTY0DQo+IFswMi8xMF0gZHJtL2tv
bWVkYTogZW1iZWQgdGhlIHdyaXRlYmFjayBlbmNvZGVyIGluIGtvbWVkYV93Yl9jb25uZWN0b3IN
Cj4gICAgICAgICBjb21taXQ6IDlkNWNkYjQ2ZWVkOTRkZGVlMzczMmZiYjVmOGMwMDhjNzk4YWJh
NTENCj4gWzAzLzEwXSBkcm0vbWFsaTogZW1iZWQgdGhlIHdyaXRlYmFjayBlbmNvZGVyIGluIG1h
bGlkcF9kcm0NCj4gICAgICAgICBjb21taXQ6IGYwN2U1ZThlYWM4NmJjN2RiMmZmZGQyZTc0OGUy
NTZlZTJiNDE5YTENCj4gWzA0LzEwXSBkcm06IHJlbmVzYXM6IHJjYXItZHU6IGVtYmVkIHRoZSB3
cml0ZWJhY2sgZW5jb2RlciBpbiByY2FyX2R1X2NydGMNCj4gICAgICAgICBjb21taXQ6IDEyYzg4
YWYxMTdjNzdhMTYwNGJiMDIzOTdjYjJiNjIyYzQ3ZGE5ZTYNCj4gWzA1LzEwXSBkcm06IHdyaXRl
YmFjazogZHJvcCBleGNlc3MgY29ubmVjdG9yIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9ucw0KPiAg
ICAgICAgIGNvbW1pdDogN2JjYjM3NjAzZGYwOTVlNTZlODdkNjE0NDIwMTE3OWZlOTExZTRkZA0K
PiBbMDYvMTBdIGRybTogd3JpdGViYWNrOiByZW5hbWUNCj4gZHJtX3dyaXRlYmFja19jb25uZWN0
b3JfaW5pdF93aXRoX2VuY29kZXIoKQ0KPiAgICAgICAgIGNvbW1pdDogODFmNjFiNGUwNDY3ZGRh
YjM2OTViZTU4YTk0ZmMzMjJjOGJkNTU5YQ0KPiBbMDcvMTBdIGRybTogd3JpdGViYWNrOiBkb24n
dCBkZXN0cm95IHRoZSBzaGFyZWQgd3JpdGViYWNrIHByb3BlcnRpZXMNCj4gICAgICAgICBjb21t
aXQ6IDdhNWM4ODQ4NjA2YTljMWM5YTU3ZGFiNDMzMmM5NDQ1YzdmMWQ2MGYNCj4gWzA4LzEwXSBk
cm06IHdyaXRlYmFjazogY2xlYW4gdXAgd3JpdGViYWNrIGpvYnMgb3V0c2lkZSB0aGUgam9iX2xv
Y2sNCj4gICAgICAgICBjb21taXQ6IGRhMTJjZmQ4NDAwYjdiMmZkMDBiZTIyY2RlYmFmMmVmYTYy
OTljNjgNCj4gWzA5LzEwXSBkcm06IHdyaXRlYmFjazogY2xlYW4gdXAgd3JpdGViYWNrIGNvbm5l
Y3RvcnMgaW4NCj4gZHJtX2Nvbm5lY3Rvcl9jbGVhbnVwKCkNCj4gICAgICAgICBjb21taXQ6IDJi
ZWQ1OTE5ZTAwNTY4N2QxNjNkMWI2ZDI3M2RiNDUwNDQ5YjhiZGYNCj4gWzEwLzEwXSBkcm06IHdy
aXRlYmFjazogZHJvcCB0aGUgZHJtbSB3cml0ZWJhY2sgY2xlYW51cCBhY3Rpb24NCj4gICAgICAg
ICBjb21taXQ6IDYxNmE2NTFhNWJlNDY1NWQyY2NlZWQwNjEyZjcwZjA3NmViMjRjYzkNCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gV2l0aCBiZXN0IHdpc2hlcw0KPiBEbWl0cnkNCj4gDQoN
Cg==
