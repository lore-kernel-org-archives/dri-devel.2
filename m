Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klJNqo7K;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RkI5tAC6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5630410E2AD;
	Thu, 26 Nov 2026 04:28:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B087110E1E8;
 Thu, 26 Nov 2026 04:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795667273; x=1827203273;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K9v0Y54Td+ZSap0YaFwx71E4UH6wZTjqwPmKcH1kEc0=;
 b=klJNqo7KKSuM5rDWFHbky1gblPMvpoDTrqoRd5sCMhYyyW2ZriKjh0gm
 a9by3bG4iNfa6ltlKeBR3T8z/46VeNjCXgyNkLGaPDAQXZTJk8R69NCNR
 zKaekGDQhSIfIP1z4YfCszhGuwy9ITYVsatL0Fls5FBVTAqNo7o2nG1Hh
 3FLhakXxUzvIy0OpmUiVZsUat1rNmfncKgDp13l2IYiZL75zhZD+T3wzU
 07DcFqsXOa8EYv19lxib/JrdxfrpRzAwv8Qh19sa1VWhTLO+o6z9RynlU
 E2k7HNEI2eQjiUfUVzTorTfoclVV+55TWURVBMmBSburoJSzx01LZhen5 g==;
X-CSE-ConnectionGUID: i1tGSZ9oQz2ASMtv5YFPpg==
X-CSE-MsgGUID: iYfSFqC8SuKvNse+2nxE0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4450283"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4450283"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 20:27:52 -0800
X-CSE-ConnectionGUID: q5WpChobQtSs1h9Q5k9tdw==
X-CSE-MsgGUID: A+smPULUTiO83ro/PPJdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12221497"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 20:27:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 20:27:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 20:27:51 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 20:27:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTL8SneRVH6GKeDbOOkEZETHapMWOV7FjeIrrmjSEJ8lxHS888GbQUkj4ChU9TMXKO6UkpiTj/DgH142RGLsuxEgwDY45OlafEliFotAv6IJBz9Nr663bYGj51VLRNF00e4X0sqckp9+9bILz/jVrLyGYWq0oBnIj3TzfNoxyP7fpMN++7/0xG0QP9jOi01A3QKpULG2hWqNK0kBEmeLYKUkZnEOHniNnahDsbcXOhrMCS1lUiWx9aPdZ52Y1qeEmUY6f01T8XGajxsy9iRHeFq1mAjqH3WdtnDtR/TEHfk/NGyYdFNHfqNKYqnMOW763PjmPOfO+L0HZ9yhos6QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9v0Y54Td+ZSap0YaFwx71E4UH6wZTjqwPmKcH1kEc0=;
 b=jiaawIwvFaGc6GPhIGfgwSZGo0S4AO6Ju6Zroj7xkkkV+OWSzB3AacZMWKxUoNWOpg3stu2UDpuWWZBm+MJwcJhtNRI7tCTsR0V1XKrpenr80zqQ8g2t+JceaYTssOP73LrAjkqctefzzqW8KKMrkl4t0GfGfJgY0zLkVx/qc/NcHtxKYUB5XalAbd+upGwSNCST40aLbrMkhxJZp+Rt5TaxK0Jm0rPFUkiUciMxmZ77xE+uZyNGaKuNjIk1p3u6/Ha6C0a0cXMzIEaN2X94k+41NI2zZU7xL/AeypaUylC3ZtY1YWL76SYJBTrW25rxltK9KTnbcjFaCx3dDzYInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9v0Y54Td+ZSap0YaFwx71E4UH6wZTjqwPmKcH1kEc0=;
 b=RkI5tAC6XPae0254sr/f862NIJRQ1JQKJ0kwsDyszGH//ympKwCIaXjT3QRL1Rl8dXfLbQKnfaKmjHZemLxUZucHe1TUdZ/wOl4sNgd4H+HNqqf33rebqfmS5p6+c3rWIbNlns8L8fPpP+7Xtd4ObtG9NtO9Sg0kL6fPIa8AlUo=
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by DM6PR11MB4579.namprd11.prod.outlook.com
 (2603:10b6:5:2ab::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 04:27:41 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 04:27:41 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: John Harrison <John.Harrison@Igalia.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo
 Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <christian.koenig@amd.com>, Liviu Dudau <liviu.dudau@arm.com>, "Laurent
 Pinchart" <laurent.pinchart+renesas@ideasonboard.com>, Tomi Valkeinen
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
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: RE: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Thread-Topic: [PATCH v8 00/10] drm: writeback: clean up writeback connector
 initialization
Thread-Index: AQHdcXWpnwUyUaV+ek2lY8tlViTtKrc+Tw8AgAABioCAANleAIAAr8bw
Date: Thu, 26 Nov 2026 04:27:40 +0000
Message-ID: <DS4PPFE901A304F670ED0778E36700345DCE3422@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
 <179558244222.1572056.13569389105654454020.b4-ty@b4>
 <IA3PR11MB9325E12D779BB5DA335C6B33E3432@IA3PR11MB9325.namprd11.prod.outlook.com>
 <951f3f8f-0f2c-4a83-b4c5-d1ab83b853df@Igalia.com>
In-Reply-To: <951f3f8f-0f2c-4a83-b4c5-d1ab83b853df@Igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|DM6PR11MB4579:EE_
x-ms-office365-filtering-correlation-id: 244d2956-eee7-4c2a-e4be-08df4b759c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|6133799003|261009220027099003|261009221227099003|261009223327099003|261009221727099003|261009223027099003|22082099003|18002099003|921020|260925022911599003|260925021911599003|260925021311599003|5023799004|10067099003|11063799006|56012099006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: hvgFRBstIjGpLl4tNUZ3zyHWmIj9vnFIF7pXc8ArJhzVCgNEAXfSlOrYJxQfd3u946z8EJ24OEEZbZDvUjxSGNLG2o7aQAfsTfA7HkFe7/JKM+Dvo2jrRmijZ0bI58pd+8Z1U6sE5qGAwhx6tS4RsBzISEpqX8uT9a0fCjKNKVXJEjtNIPcSTQ0UH/FXEdt5GP7zc57OeQuygGaY/n0xH1KlbXj2XFmODAM5Rv0ZSJ2BoUasE3cLkExI4C+8eanzPGbm/R3tU3OhP2OvqzVfys/MXy+d7ZoBr/rHsO/IophdiKALF2tJnhjhmjj0qAoqld5VUCW2ZwktJb6bcIOqiCWEMYeuTJ1XAFTkL0+ZId+AnPffeTT7f+iEWbkRQ+H8ICNDH4NLUi1DreoK3oQwO5xkpwxW0+QQ+8osW0cMjANtB7ec97/UM1XurWFjt9ai8z38G4nSTfxG442EGZrBZRofrWpjIRzHWl7iy6U5cwbrGIuyCRT1X1kF+BzJXXUxqi+8+/wQkidoUPTPG1Ijjm2tcqcJ7anG9QRfxqCwHDT4kJxHPNQ+pdCrABCr8gY3NMNLhM8ldjmJXuykpukMME/UuX1GwxIXXbE++dAon9XD8AWuH7Q5ONNKxf87MjFwlBbzTSGYBwzjwESuThezQY8OGGiFTuQmSXM3UgtbUiOVexAGuyvLsW9CpmMfgBRZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(6133799003)(261009220027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFp6OGc0c1FGeVNRTW55aFZOTk04eGcxSG9IVFpnUER2Y09JSEtMM3k2ajN5?=
 =?utf-8?B?TTFhcWVBL3pjNHhXeExkRjNkMUFjc216L2o5blpNTGFUUlNwQkUvZlVFY25z?=
 =?utf-8?B?OUQ2cWorTlRkcVlLUmhkdHZjWG90OVFpbXhoeEQ3THM4U0pPbHBqQ0lkVjlw?=
 =?utf-8?B?TitCMDlPcWg4a2tJY0RVTStYRnFwYlBnU2RJd0traWNoYWVUZzZxTzdMWk9X?=
 =?utf-8?B?L3p2Zk5QcmhmN2dzSUxDVXk1ay9FNWFUa1lYSVE5M0ZUMlZVUXVQcnNWb256?=
 =?utf-8?B?d1p6bUkySlE0THFQRExBSktYbWMyZUIxOVJsbC91cGRwM0pQN3NEOEFEUFBl?=
 =?utf-8?B?UjZDdUl3U0laRCtQT0lYUEQzWHhmdWlFQWh0RHdwTC9keWVVVi9PNkZyRnRP?=
 =?utf-8?B?TlRtQ3VPME9RbVpvcHhZUWxta0hJVU1VWkU3bkh1L2xudFAvOGdaRzhkd2c0?=
 =?utf-8?B?OW1RaVBRTVRlOU95SkNtOGdkbnJ0UTZlVFozZXRSblF0R1RTTFllTzV6amdu?=
 =?utf-8?B?TlFZMGppRFMzTzlHQ3Bsc1FxOTVBWVFzTUZKL20ybGpuUmdWSlJNeng4L2Nk?=
 =?utf-8?B?OUFySWNwQXZXNlY0djdueEhRMVZRNnZoRVNVUjhCMnEvK2FwY2k0cG5pemlj?=
 =?utf-8?B?Z1EwbkIwNDNMb3dBR2dHNGErM1lFYVgra0tmeGovOTBNc3pwSzVHenhoT3ZR?=
 =?utf-8?B?TFJOdkVDQWYzOE1SVDhHR1ZPRWVHdnRlOFg5MVBKYjMxeXNMU0pScEJjWmFH?=
 =?utf-8?B?RVpiTTVpQ3ErelBZUHVIWHYvdFJwdkRua3hNVWxwRkV2RnduNkxicExBYitI?=
 =?utf-8?B?RVEvQVI2YUJBc3QvM1g2UGNXNzB2OEJYclp0UXFsdWgvWnV1eTNHSG5rRFgw?=
 =?utf-8?B?V3Z6ZkFwaWNwSDh6MFBRaXBhTjgzUnVVM05kMVhGMzBna21XbW9qL0xEbWJK?=
 =?utf-8?B?TklLNFR4NTQ5NjdLQ2dWeTBXOTQ4dVFPWXpJVUIrWmdoS2ZtUUd3bnMwSE1n?=
 =?utf-8?B?Q2tuRWs1djg4Z2Q1dDJlSHYxU01vNHNoWVRhSStoQXliam9MQ3g4UFpCSE51?=
 =?utf-8?B?MEFldGoyQ09RYks2Y2ZPQjFjUU9oM0EycEZ0b0NzNHl3bnlQM0xWRFhhV2Q2?=
 =?utf-8?B?N3FrRklXckd1WTE2SkNOUzBlUEhHcE1DTngrOHZhckxWdklnb2JwU1pQMFdx?=
 =?utf-8?B?clpSczlMVlpCOEF3aG5jRjNNUG9IR2FJVGo5bmxtakpWWGVCM2lDL1E2aHZx?=
 =?utf-8?B?cC9yd3RGRnZIZmE4V1Y0SHdlWlpqUUVSTFFQVmoybFZyK0t4c0hvY3E0dzlR?=
 =?utf-8?B?T2hPYllmRVVGekhSS1RLOFBhSWc1b3JSSjVUeVl2WkNLYmFNeTBUZ0tqN0R4?=
 =?utf-8?B?bW15N0RvVkNpY05TbksvRjNUM1NxRzVNNVpVc0tjSmFaVHUvYm5Qenp2SldD?=
 =?utf-8?B?V3VVNStXejJGVnc2emwwNUJsTHBobzFXQjBLRlo4NnpHb1A3bFBiQ2ZFN2xM?=
 =?utf-8?B?T1p0MGlkbmRLc3FucDVNcVNiK2NIRHBZQVVzU0h2Q2ExQUwxcmMvbEhOQm9q?=
 =?utf-8?B?OVBwZTJVVGlEQVR1aEd0YmVnZ0JMTjdHTVpmcnlHWmlseU5JZ2FIdUNnMFhx?=
 =?utf-8?B?REtVMzVoTGh6WHdxMk9PblRwTnc4aG9nU3pZWW05Z2RLcmtGb1cxd3BRQ21j?=
 =?utf-8?B?dTM0TmoyWUdIb1A0a2lRelY0MDUxUGt4c2VJODRoWG8vU0VFdUFKQWFOb2c0?=
 =?utf-8?B?UG51WGpxT1RXU2tzZldXQ3hEemE1OEZHR3Zuam5UcGw0c1gxOFI4L1hRWXlP?=
 =?utf-8?B?Qk5hRzIyVTZKOTJ1Ynk1MHlLWG1zcTFDVERGbWNJQUdUZXdZUGduV05oR2lW?=
 =?utf-8?B?Uk9TdXJrUkJwK0xQdnRpYkxnejBleXBsSkg3RmpBRVl5N2k2MWdxT2t5c0V0?=
 =?utf-8?B?b2o5SmswSmZXM1dMQzVIMStaZFpVaGNDaTdIWU5IV0k2OG1EOHNhaVJqVDZG?=
 =?utf-8?B?Tm1QQ1k4NXR6NTlFVlNMd1lEVXhwbGxTMmZwaHltVEhmb0FVZ0tLZTlXVFBn?=
 =?utf-8?B?T3FjM0tkOTYxUGxBeExicE9DRnhHSU5ZRjQ5bUU1dmJWZlpabStxUk1LR1hr?=
 =?utf-8?B?Mk9XdDFNMEc5RWZhZkFZQzNDN280dm1kYzAvK0JSckdnMWxBRVZxOXZ4YlM1?=
 =?utf-8?B?aGpKYXkyZy9MODk2RDFJNXFXSzBWbzVMMDMxM2xOazdVQmtjUWozeEF1MFBK?=
 =?utf-8?B?dDVkb08xTmxnSnZadVNZZmhjK2N3RHpxQm5GWWdORzVtK1daaTlkNExaem5C?=
 =?utf-8?B?NVo2a0lGYUtPZURuTGlObCtyM0VPak1mSHNSeXJaczN4MFowVlZiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HqyCjRSr9bvVGqK0i6Nc8w0S1RrsJkPF2CFsnjXcsZ21f56AM7/FLlAvjqOtFYW8fR13zaVVLd0DXgbC+QZKS6i/J0Y1fve6GdzMWXidrv9e4NZ/ivl3WCaS15dcYlMbbIDjRw0mJ70eX5iH/McK7EUvEhEcx6JZ/5U9D02HGiWfaN0H2nXTdiIjehCHRoNTzcLwQ+rUTmbSgGPU2oavZjDDiwwwpfroJcmq3vNxnmQZMVMelxDzxApvbpsXx1YPnrr6e+EM0QPDPUHTB8yQ1wwbCXW00gXocTP8sWqjdWLCKrmeOuq28szFGMM5xKC64PGky4CgMTKCoj81FtjSfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d2956-eee7-4c2a-e4be-08df4b759c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 04:27:40.4585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt7niaZKZfZWiufuRRykpBu1Vjlwncx0Vns0SOyfuw8NImhGCNsPOdf0LwAvszj7R5cTcldplo/pLAfd5vjl+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBIYXJyaXNvbiA8
Sm9obi5IYXJyaXNvbkBJZ2FsaWEuY29tPg0KPiBTZW50OiAyNSBOb3ZlbWJlciAyMDI2IDIzOjI4
DQo+IFRvOiBLYW5kcGFsLCBTdXJhaiA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+OyBEbWl0cnkg
QmFyeXNoa292DQo+IDxkbWl0cnkuYmFyeXNoa292QG9zcy5xdWFsY29tbS5jb20+OyBNYWFydGVu
IExhbmtob3JzdA0KPiA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWF4aW1l
IFJpcGFyZCA8bXJpcGFyZEBrZXJuZWwub3JnPjsNCj4gVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+OyBEYXZpZCBBaXJsaWUNCj4gPGFpcmxpZWRAZ21haWwuY29tPjsgU2lt
b25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgSGFycnkgV2VudGxhbmQNCj4gPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+OyBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT47IFJvZHJpZ28NCj4g
U2lxdWVpcmEgPHNpcXVlaXJhQGlnYWxpYS5jb20+OyBBbGV4IERldWNoZXINCj4gPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnDQo+IDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+OyBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT47IExhdXJlbnQNCj4g
UGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPjsgVG9t
aSBWYWxrZWluZW4NCj4gPHRvbWkudmFsa2VpbmVuK3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT47
IEtpZXJhbiBCaW5naGFtDQo+IDxraWVyYW4uYmluZ2hhbStyZW5lc2FzQGlkZWFzb25ib2FyZC5j
b20+OyBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgTWFn
bnVzIERhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47DQo+IERhdmUgU3RldmVuc29uIDxkYXZl
LnN0ZXZlbnNvbkByYXNwYmVycnlwaS5jb20+OyBNYcOtcmEgQ2FuYWwNCj4gPG1jYW5hbEBpZ2Fs
aWEuY29tPjsgUmFzcGJlcnJ5IFBpIEtlcm5lbCBNYWludGVuYW5jZSA8a2VybmVsLQ0KPiBsaXN0
QHJhc3BiZXJyeXBpLmNvbT47IExvdWlzIENoYXV2ZXQgPGxvdWlzLmNoYXV2ZXRAYm9vdGxpbi5j
b20+OyBNaWhhaWwNCj4gQXRhbmFzc292IDxtaWhhaWwuYXRhbmFzc292QGFybS5jb20+OyBFcmlj
IEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0PjsgUm9iDQo+IENsYXJrIDxyb2Jpbi5jbGFya0Bvc3Mu
cXVhbGNvbW0uY29tPjsgQnJpYW4gU3RhcmtleQ0KPiA8YnJpYW4uc3RhcmtleUBhcm0uY29tPg0K
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1yZW5l
c2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IENoYW95aSBDaGVuDQo+IDxjaGFveWkuY2hlbkByb2Nr
LWNoaXBzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwMC8xMF0gZHJtOiB3cml0ZWJh
Y2s6IGNsZWFuIHVwIHdyaXRlYmFjayBjb25uZWN0b3INCj4gaW5pdGlhbGl6YXRpb24NCj4gDQo+
IE9uIDExLzI0LzI2IDIxOjAwLCBLYW5kcGFsLCBTdXJhaiB3cm90ZToNCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRG1pdHJ5IEJhcnlzaGtvdiA8ZG1pdHJ5LmJh
cnlzaGtvdkBvc3MucXVhbGNvbW0uY29tPg0KPiA+PiBTZW50OiAyNSBOb3ZlbWJlciAyMDI2IDEw
OjI0DQo+ID4+IFRvOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXgu
aW50ZWwuY29tPjsgTWF4aW1lDQo+ID4+IFJpcGFyZCA8bXJpcGFyZEBrZXJuZWwub3JnPjsgVGhv
bWFzIFppbW1lcm1hbm4NCj4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Ow0KPiA+PiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsN
Cj4gPj4gSm9obiBIYXJyaXNvbiA8Sm9obi5IYXJyaXNvbkBpZ2FsaWEuY29tPjsgSGFycnkgV2Vu
dGxhbmQNCj4gPj4gPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+OyBMZW8gTGkgPHN1bnBlbmcubGlA
YW1kLmNvbT47IFJvZHJpZ28NCj4gPj4gU2lxdWVpcmEgPHNpcXVlaXJhQGlnYWxpYS5jb20+OyBB
bGV4IERldWNoZXINCj4gPj4gPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+OyBDaHJpc3RpYW4g
S8O2bmlnDQo+ID4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+OyBMaXZpdSBEdWRhdSA8bGl2
aXUuZHVkYXVAYXJtLmNvbT47DQo+ID4+IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hh
cnQrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPjsgVG9taQ0KPiA+PiBWYWxrZWluZW4gPHRvbWku
dmFsa2VpbmVuK3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT47IEtpZXJhbiBCaW5naGFtDQo+ID4+
IDxraWVyYW4uYmluZ2hhbStyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+OyBHZWVydCBVeXR0ZXJo
b2V2ZW4NCj4gPj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgTWFnbnVzIERhbW0gPG1hZ251
cy5kYW1tQGdtYWlsLmNvbT47DQo+IERhdmUNCj4gPj4gU3RldmVuc29uIDxkYXZlLnN0ZXZlbnNv
bkByYXNwYmVycnlwaS5jb20+OyBNYcOtcmEgQ2FuYWwNCj4gPj4gPG1jYW5hbEBpZ2FsaWEuY29t
PjsgUmFzcGJlcnJ5IFBpIEtlcm5lbCBNYWludGVuYW5jZSA8a2VybmVsLQ0KPiA+PiBsaXN0QHJh
c3BiZXJyeXBpLmNvbT47IExvdWlzIENoYXV2ZXQgPGxvdWlzLmNoYXV2ZXRAYm9vdGxpbi5jb20+
Ow0KPiA+PiBNaWhhaWwgQXRhbmFzc292IDxtaWhhaWwuYXRhbmFzc292QGFybS5jb20+OyBFcmlj
IEFuaG9sdA0KPiA+PiA8ZXJpY0BhbmhvbHQubmV0PjsgUm9iIENsYXJrIDxyb2Jpbi5jbGFya0Bv
c3MucXVhbGNvbW0uY29tPjsgQnJpYW4NCj4gPj4gU3RhcmtleSA8YnJpYW4uc3RhcmtleUBhcm0u
Y29tPjsgRG1pdHJ5IEJhcnlzaGtvdg0KPiA+PiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNv
bW0uY29tPg0KPiA+PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gYW1kLSBnZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IEthbmRwYWwsIFN1
cmFqIDxzdXJhai5rYW5kcGFsQGludGVsLmNvbT47IENoYW95aSBDaGVuDQo+ID4+IDxjaGFveWku
Y2hlbkByb2NrLWNoaXBzLmNvbT47IEpvaG4gSGFycmlzb24NCj4gPj4gPEpvaG4uSGFycmlzb25A
SWdhbGlhLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwMC8xMF0gZHJtOiB3cml0
ZWJhY2s6IGNsZWFuIHVwIHdyaXRlYmFjaw0KPiA+PiBjb25uZWN0b3IgaW5pdGlhbGl6YXRpb24N
Cj4gPj4NCj4gPj4gT24gV2VkLCAxMSBOb3YgMjAyNiAwMjo0MjoyOSArMDIwMCwgRG1pdHJ5IEJh
cnlzaGtvdiB3cm90ZToNCj4gPj4+IERyaXZlcnMgdXNpbmcgZHJtX3dyaXRlYmFja19jb25uZWN0
b3JfaW5pdCgpIC8gX3dpdGhfZW5jb2RlcigpIGRvbid0DQo+ID4+PiBwZXJmb3JtIGNsZWFudXAg
aW4gYSBtYW5uZXIgc2ltaWxhciB0bw0KPiA+Pj4gZHJtbV93cml0ZWJhY2tfY29ubmVjdG9yX2lu
aXQoKSAoc2VlDQo+ID4+PiBkcm1fd3JpdGViYWNrX2Nvbm5lY3Rvcl9jbGVhbnVwKCkpLiBFbm91
Z2ggb2YgdGhlIGRyaXZlcnMgZG9uJ3QgdXNlDQo+ID4+PiB0aGUgZW5jb2RlciBlbWJlZGRlZCBp
bnRvIHRoZSBkcm1fd3JpdGViYWNrIGNvbm5lY3Rvci4gIEluDQo+ID4+PiBwcmVwYXJhdGlvbiB0
byBmdXJ0aGVyIHJld29yayBvZiB0aGUgV0IgY29ubmVjdG9ycyAoYXMgcGxhbm5lZCB0bw0KPiA+
Pj4gZW5hYmxlIFdCIGZvciBpOTE1IC8geGUgZHJpdmVycywgd2hpY2ggd291bGQgbW92ZQ0KPiA+
Pj4gZHJtX3dyaXRlYmFja19jb25uZWN0b3IgdG8gYmUgYSBmaWVsZCBpbnNpZGUgZHJtX2Nvbm5l
Y3RvciBpbnN0ZWFkDQo+ID4+PiBvZiBzdWJjbGFzc2luZyBpdCkgcmVtb3ZlIHRoZSBkcm1fZW5j
b2RlciB3cmFwcGVkIGluIHN0cnVjdA0KPiA+Pj4gZHJtX3dyaXRlYmFja19jb25uZWN0b3IuIFJl
bmFtZSB0aGUNCj4gPj4+IGRybV93cml0ZWJhY2tfY29ubmVjdG9yX2luaXRfd2l0aF9lbmNvZGVy
KCkgdG8NCj4gPj4+IGRybV93cml0ZWJhY2tfY29ubmVjdG9yX2luaXQoKQ0KPiA+Pj4gYW5kIGNv
cHkgZHJtbV93cml0ZWJhY2tfY29ubmVjdG9yX2luaXQoKSBpbnRlcmZhY2UuIFRoZW4sIHdpdGgg
dGhlDQo+ID4+PiBlbmNvZGVyIGJlaW5nIGdvbmUsIGhhbmRsZSBwcm9wZXIgY2xlYW51cCBvZiB3
cml0ZWJhY2sgZGF0YSBpbg0KPiA+Pj4gZHJtX2Nvbm5lY3Rvcl9jbGVhbnVwKCkuDQo+ID4+Pg0K
PiA+Pj4gWy4uLl0NCj4gPj4gQXBwbGllZCB0byBkcm0tbWlzYy1uZXh0LCB0aGFua3MhDQo+ID4g
V2l0aCB0aGlzIHNlcmllcyBub3cgbWVyZ2VkIGNhbiB3ZSBhbHNvIGdvIGFoZWFkIGFuZCBnZXQg
dGhpcyBzZXJpZXMNCj4gPiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVz
LzE1Mjc2MS8gbWVyZ2VkIGluDQo+ID4gZHJtLW1pc2MtbmV4dCBEbWl0cnksIEpvaG4gPw0KPiA+
DQo+ID4gUmVnYXJkcywNCj4gPiBTdXJhaiBLYW5kcGFsDQo+IFNvdW5kcyBnb29kIHRvIG1lLiBE
b2VzIGl0IG5lZWQgdG8gYmUgcmViYXNlZCBmaXJzdD8gSWYgbm90aGluZyBlbHNlLCBqdXN0DQo+
IHJlc2VuZCB3aXRob3V0IHRoZSAnZG8gbm90IHJldmlldycgcGF0Y2g/IEkgZ3Vlc3MgaXQncyBv
bmx5IHR3byB3ZWVrcyBzaW5jZSB0aGUNCj4gbGFzdCByZXYgc28gbWF5YmUgaXQncyBzdGlsbCBh
bGwgZ29vZD8NCj4gDQoNCkkgcmViYXNlZCBhbmQgcmVzZW50IGl0IHdpbGwgbWVyZ2UgaXQgLCBk
aWQgbm90IGZhY2UgYW55IHJlYWwgY29uZmxpY3RzIHNvIHllcyBpdCBpcyBnb29kLg0KDQpSZWdh
cmRzLA0KU3VyYWogS2FuZHBhbA0KDQo+IEpvaG4uDQo+IA0KPiA+DQo+ID4+IFswMS8xMF0gZHJt
L2FtZC9kaXNwbGF5OiBlbWJlZCB0aGUgd3JpdGViYWNrIGVuY29kZXIgaW4NCj4gPj4gYW1kZ3B1
X2RtX3diX2Nvbm5lY3Rvcg0KPiA+PiAgICAgICAgICBjb21taXQ6IDI4M2EzY2ZiYjI5Y2YzZDBh
ZjFhZDAzMDEyZmNkMDQ5ZGVjZTZlNjQNCj4gPj4gWzAyLzEwXSBkcm0va29tZWRhOiBlbWJlZCB0
aGUgd3JpdGViYWNrIGVuY29kZXIgaW4NCj4ga29tZWRhX3diX2Nvbm5lY3Rvcg0KPiA+PiAgICAg
ICAgICBjb21taXQ6IDlkNWNkYjQ2ZWVkOTRkZGVlMzczMmZiYjVmOGMwMDhjNzk4YWJhNTENCj4g
Pj4gWzAzLzEwXSBkcm0vbWFsaTogZW1iZWQgdGhlIHdyaXRlYmFjayBlbmNvZGVyIGluIG1hbGlk
cF9kcm0NCj4gPj4gICAgICAgICAgY29tbWl0OiBmMDdlNWU4ZWFjODZiYzdkYjJmZmRkMmU3NDhl
MjU2ZWUyYjQxOWExDQo+ID4+IFswNC8xMF0gZHJtOiByZW5lc2FzOiByY2FyLWR1OiBlbWJlZCB0
aGUgd3JpdGViYWNrIGVuY29kZXIgaW4NCj4gcmNhcl9kdV9jcnRjDQo+ID4+ICAgICAgICAgIGNv
bW1pdDogMTJjODhhZjExN2M3N2ExNjA0YmIwMjM5N2NiMmI2MjJjNDdkYTllNg0KPiA+PiBbMDUv
MTBdIGRybTogd3JpdGViYWNrOiBkcm9wIGV4Y2VzcyBjb25uZWN0b3IgaW5pdGlhbGl6YXRpb24g
ZnVuY3Rpb25zDQo+ID4+ICAgICAgICAgIGNvbW1pdDogN2JjYjM3NjAzZGYwOTVlNTZlODdkNjE0
NDIwMTE3OWZlOTExZTRkZA0KPiA+PiBbMDYvMTBdIGRybTogd3JpdGViYWNrOiByZW5hbWUNCj4g
Pj4gZHJtX3dyaXRlYmFja19jb25uZWN0b3JfaW5pdF93aXRoX2VuY29kZXIoKQ0KPiA+PiAgICAg
ICAgICBjb21taXQ6IDgxZjYxYjRlMDQ2N2RkYWIzNjk1YmU1OGE5NGZjMzIyYzhiZDU1OWENCj4g
Pj4gWzA3LzEwXSBkcm06IHdyaXRlYmFjazogZG9uJ3QgZGVzdHJveSB0aGUgc2hhcmVkIHdyaXRl
YmFjayBwcm9wZXJ0aWVzDQo+ID4+ICAgICAgICAgIGNvbW1pdDogN2E1Yzg4NDg2MDZhOWMxYzlh
NTdkYWI0MzMyYzk0NDVjN2YxZDYwZg0KPiA+PiBbMDgvMTBdIGRybTogd3JpdGViYWNrOiBjbGVh
biB1cCB3cml0ZWJhY2sgam9icyBvdXRzaWRlIHRoZSBqb2JfbG9jaw0KPiA+PiAgICAgICAgICBj
b21taXQ6IGRhMTJjZmQ4NDAwYjdiMmZkMDBiZTIyY2RlYmFmMmVmYTYyOTljNjgNCj4gPj4gWzA5
LzEwXSBkcm06IHdyaXRlYmFjazogY2xlYW4gdXAgd3JpdGViYWNrIGNvbm5lY3RvcnMgaW4NCj4g
Pj4gZHJtX2Nvbm5lY3Rvcl9jbGVhbnVwKCkNCj4gPj4gICAgICAgICAgY29tbWl0OiAyYmVkNTkx
OWUwMDU2ODdkMTYzZDFiNmQyNzNkYjQ1MDQ0OWI4YmRmDQo+ID4+IFsxMC8xMF0gZHJtOiB3cml0
ZWJhY2s6IGRyb3AgdGhlIGRybW0gd3JpdGViYWNrIGNsZWFudXAgYWN0aW9uDQo+ID4+ICAgICAg
ICAgIGNvbW1pdDogNjE2YTY1MWE1YmU0NjU1ZDJjY2VlZDA2MTJmNzBmMDc2ZWIyNGNjOQ0KPiA+
Pg0KPiA+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IC0tDQo+ID4+IFdpdGggYmVzdCB3aXNoZXMNCj4g
Pj4gRG1pdHJ5DQo+ID4+DQoNCg==
