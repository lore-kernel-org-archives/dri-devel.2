Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iIlToX2z;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Y67nF9K2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89AE10EDA5;
	Thu, 19 Nov 2026 07:11:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE8910EDE2;
 Thu, 19 Nov 2026 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795072306; x=1826608306;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZZKiJgvwbsjxCLhhju1Ku8xhnKf5Wt86vAYUFAv1xGk=;
 b=iIlToX2zidQv5eZ+S938lRAT2IQ3W0pq6riw2ROnibH4I22z4CvHcKkK
 MIjgO+FsxNITGAS4Y/yuFyEgYryYBnlP8vgOot6+FUkBqLIjN1lwasNLp
 ORzsN2x8K+QhPnoYZBjui0cRxXnpbAmCIMzbse//WssfaPf2ESWrpvawN
 PF952sBEtrFxEOiQCUWwrmIttSv66RXf6gR8dp8FLko6LeEzxJinHBye9
 6bEHlxBdT1uyXr127WssyTYoUR7Pz8q6JTHHeqTEAoWvIA1BkiOLDm195
 l9qHKK13l0S76L2WLBxSIfzgRzV7WBlnGx9nYdciSZyCJV+IHG7e0W2Mi Q==;
X-CSE-ConnectionGUID: ANy7sAgoQE+qrfd7oBvvZg==
X-CSE-MsgGUID: b/niOFVbRVymJ3nxkb1Nzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3801011"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3801011"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 23:11:45 -0800
X-CSE-ConnectionGUID: OpKAD6B7Ty2pt5uzsyOE+A==
X-CSE-MsgGUID: 1OJnf95GQaeDxpwMm+25lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10914353"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 23:11:46 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 23:11:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 23:11:44 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 23:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO/LBMkcG5+AMS33g/+smGQrVKCmiAQ4L40kmRInb1A4YFkr78kzGvoXDuuymi0pyGoWdVOTbTVhqxKjJLa1CZsvXkmcqO7ukUjVeVRSyaI7cji27HIoSvuYeoAPEW5Flc1sVXLRxPs+uqmVpWvxDa8/ytwoxw6XxrhvZkw91uBAugSva9KN4t06gIcmg96YRZn5RZIYb4N1C039YrW00iUeRa2fY6KyF7//9oT+QuPVXARcdj0eFoRA8qXENTM8ks2tZFiGT7vEIfeSepUyOi2PU9eWwAEiZ6wLQQSKoksyqubD/oNoNDr901sAGj3+cJF+6bte7M9EEikGbqXHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZKiJgvwbsjxCLhhju1Ku8xhnKf5Wt86vAYUFAv1xGk=;
 b=Ws5PDB299NBsqPQDbC6RNevelPrSUJI/VJOSrqs93zYIYNLLxqah9luJWdX8I2bFPtXfGburSjPtz+tpoQ1wEYboWTsfcX8gBtA1xF4QbPrwB0vJ5pdymDAZpQ7zuzxrJf/mllS2UX89iic3ZH/UG8jo5lVL5tJyW5NgwOVO3sCvLieNT6NpS4ijIH/HcHEo6M4ZHnVJY4mDKAWyeFA6XHgOnsx14JqGib8mN/PZfppT7XNk6WlWxgaASwlutACSMHzLQDQGSLpEAj0rCstlImtnmmTHFBO+MWSKLttMLQkuu5/NWzjOQTQDK/qVg9RhuMTTBFe97/Rcv/U1k218TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZKiJgvwbsjxCLhhju1Ku8xhnKf5Wt86vAYUFAv1xGk=;
 b=Y67nF9K23Fvefw+Y+WScGG6vBmVCxa+ryckMgN+LQFgxpeWvvd5zg34KxR1ccftnWp7mcxnuZ3nrZKZeMAF5w1faY0fkhZ1UAn6HKxM+0lWzYutr7tG6E7xO5TPGbSoiIb3YH4TUGLO9memMse7o+XkpE0ue4y4fqXGrsvjcIgo=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by SAVPR11MB9550.namprd11.prod.outlook.com (2603:10b6:806:4e9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:11:40 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 07:11:40 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 20/20] drm/i915/dp: Enable AS SDP for DP Panel Replay
 with AUX-less ALPM
Thread-Topic: [PATCH v7 20/20] drm/i915/dp: Enable AS SDP for DP Panel Replay
 with AUX-less ALPM
Thread-Index: AQHdZQyj2aaMJ7tiVUa5/7LwQ5DqL7c1IFeA
Date: Thu, 19 Nov 2026 07:11:40 +0000
Message-ID: <3d9f9f410dfb508d530b0738abc82ce478aeb683.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-21-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-21-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|SAVPR11MB9550:EE_
x-ms-office365-filtering-correlation-id: c9181afa-02c5-4e05-b8bf-08df460c5be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: fZDi2HDYquy+UFzk1B2wWS1fJXIhncPrHFu0CDXMJphbXzwwiqYGjasWSwTVTiJ6b1UFH+EwPDpLTf1jRjdXkkCwPJfUQ/mvnZxQIT/p6Cbl9JwHYKovv2mkBvlRwNe8gb89W8t65qsAaJtbl+um+tshgAXDCt2a+dvTb7bzA96n25876DJp1JwrHe3QBGeLDTOGhYTVVFmW76U5qvU91Ox51ydAs171IvtilhDbI+huDQS/AOOUL/NSyEAFj1LfGvXXGqNt3lD2b9SHhVJyuIwLN1L7bgK+dBZf43cCIhz+bn72FhFxtYXOOpt2H+1hnjqdpODsJ3n1F/cIBPVaKIDAMT768jMnK4OTgi5to5VaYkSHacFfu33vAwLrEVgaBafU/VkCHEQ1SFTxKE4pZLUtk2HbSUEgIgBzfRNRX0vb3WqYTWjH12IToXtX50S2Fnar8J93oP0NS1JITrit07hQ3AU59vQrldeVBa7dgbU6lGq9sLqQgceT8GdlTZYQEkEoQ+Cgy9DUFmUONgIC4UIPnDMHNOloXYis+6xFparKEYzcyIGWk41ik6eS73EfIVNQ3Ru6ul8of0zMmLp4qzdarDRXMH9Sl6ZL6ByZRX9IVYZDNdeAD92/dp7Dz0awyzqbeOFLacxZFZ1uCLIgNlAFb8QNi+64RZwHp9zj32adjxVwPuY6ag+GTY9GV+LOcGuoHhhy4kV5Gd61mRYlMKTkklwnhVp1ZQoiSQ2OAeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261022105027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTlwbnppNitwbkVWVWNsS05CRVJRaE1uQ0pzQnR1RjlGUUFiMFJuL1Q5S2xI?=
 =?utf-8?B?aHpueEl3R2tmOTdYS3pQMFBmOWNLcGtFRk9ha3RSdDJzakdONmVlZE9xMFlX?=
 =?utf-8?B?WHRvUkFGNFpwejVkaC8ra0tzcVhROFdFclI2aURHQ3ZOTmgwY1RNc0g4M2ln?=
 =?utf-8?B?RWF3djN3TGFLcStoa3AxeXRBaGhFQXVGdDRjSkMzM053R3l3K2Y0N1JOaXdD?=
 =?utf-8?B?Syt6VWdadUhKVG5WZnB2R3ZCWFhMNmRBTVJKYUkwWGdDTzN3STNaeCtTZkVY?=
 =?utf-8?B?d2hlQUJLTHFhY3djbWtxbkFZV2hpejd4dXRvem1pYXc5QzB5cHZZU1o5TEJW?=
 =?utf-8?B?RUpUdjRySVRBdW9RVHZJSVVmNXlmcjJVNlF6WENsaWFaaDBmVTUwYm1GYzNB?=
 =?utf-8?B?cEwyWXJOQkN5bldIU214UUVobVh4NjltUUNzeVRLcHh3ZTY4SHYzb1FrZ0gx?=
 =?utf-8?B?RjNhdXJNUG5YWmowNjhjOFRJejdvMUxhL3RyaWR0Y2twN1lIemFPL3o2b2Jz?=
 =?utf-8?B?MzBTTCtOQzQycWdKZ1l3ZGRpQ2U1TDZFaTY1SEMzMWNjVkJtQTFudkRXeXl1?=
 =?utf-8?B?M3hWejJLOHZETkpCM2VwZFJBSVdzNmJMU3hlTC9idHVvZjY3dWdzV0ZGcmtF?=
 =?utf-8?B?QXEvZllpWFZtcXh4M2VrRHdrRDBZUG5YSU0vY0Y4cFRwdnZ2ZDBKWGN5VnF0?=
 =?utf-8?B?bGtCSVI0czJHU29CblNMa2xQVUdWdVhiaHpJYnRMTEN0SGxXUHJTUVN2N2d3?=
 =?utf-8?B?ZnJ6bmo0L3A4dDY5ZTdZdWhKbmkrcUo0SHp4bDJpMEs3eWRnNmdTbDVTWU5N?=
 =?utf-8?B?MnNIR0tPU21iYldPbC92SGY1UTlzNytORE9vOG5TbkxPcDBCMFpSWGZLL3Z4?=
 =?utf-8?B?MGlNRi9LZjBqWWduVDQxMVBscEV2czc1MDR4ZlZTcmUyWWxsN1RUVGZrUmor?=
 =?utf-8?B?L1IyUnp5K2NJQkRqR0gwc3Q1VGVnVmZLdTFmVk54clVXNTM3aC8vSzdHU3VH?=
 =?utf-8?B?RCtFRnNEb3FLdHA0TzJvM3ROaGRPZXlTYjJsNE1sWTloRnB6ZjN1WFNHa20x?=
 =?utf-8?B?a2VuOWRiYkxXbmR4VHBwYTM1Qzh6cENtVktncGhReHlYaW5lQnV5ZHIySkdW?=
 =?utf-8?B?cUlDNXhobk9qS2RLUXlXdjJWNHZXb1VqRFVTRjY1OFZXb05WbDkyVU1idHly?=
 =?utf-8?B?YlZjblR1cjdxeS9jOHg5aXVZL3ZLSHFLOExGSEFpMzBIck5nWFVLa0I0Y1l2?=
 =?utf-8?B?Qnl0OGFvVFJVeXdlL0pyQzRSV1prdGo1TWphL0tOWk4wTnJ3L0NvMW1jNlJI?=
 =?utf-8?B?SmZmd3YzZnNUczZ1aE5ULzRqRzFRZlRNalFaRFlNWUFEQWdGaUg5U29EREQ2?=
 =?utf-8?B?bDVLRitYcEFWTWp2djZKdGxPc2d2WmI2UllSZ3RzcVQ0bmEwelpzZE4wcGx5?=
 =?utf-8?B?RitFbnc0S0hPVjh5b2RBTTVUSFVGYTgva3hYL0w5SGthOXZ2dDVFZjZ6dUZl?=
 =?utf-8?B?eEQyU1grTmd3djdkNy8rWDNZc3hFdG01Z1VmQ2Y5ckM4c3RjWmEwNHJHZi9Y?=
 =?utf-8?B?dHNmaVNoQWtmQnMrc1pzMUxzb29RLzYyR0ZHSE5xVzVFMWxCQmNNTWZFTHFn?=
 =?utf-8?B?RGUxcFZrUEtUck9FK21GdnJUL2FZdDZHYk03T2laekZaTUVQaW9hN2VtVWdY?=
 =?utf-8?B?WnVrT241NktsWSsvWmdUSVJJUVRkdUdjYjkwUmhya1BJUStDTHNMZVEzRlNr?=
 =?utf-8?B?dEx6eWl1ZExUMkhnOC9MUUlvemIzWktnQ2dOSUQxejU3Y3dPdFl5UU5mcHlS?=
 =?utf-8?B?bU01WDZJaTZaTmN4T0dRdFh6TEdzaXZFK0FTSCt1ZTl1eWE2VkMya1hOTDVp?=
 =?utf-8?B?blFHdUVDdE5wMUpseHplandadEw1endMc28xUTAwUlBnYzJvck5QeFVuOGkx?=
 =?utf-8?B?M1FTczljc2lxODlIZjFYZXYwOTZzOElyVEhNS1JDNEo0M1ZFOVFOMkVxdmlj?=
 =?utf-8?B?M2lLK2M1MG40Wm9MYXkxOEM2NXdRa3ZROGltSU9XS3FJY3ZGTmRxR1NRNVVL?=
 =?utf-8?B?RTNPV3NpQWV5akFITG42cG5neCtiS0FwUHZ0QnF6a1BYTkpmRXNJeWR6MWIx?=
 =?utf-8?B?VHpSb0ZMK3pLT2VHMWt1V1pyMm4vZ0oxSWUrZzRCT3BWYldEU0E3a1QrWGw4?=
 =?utf-8?B?SmZNMWJWNmlzZjI5TEdxNWt0MFNzY09RRkJCbjRma2ZXdGY3TFc3THFTUStH?=
 =?utf-8?B?cTdqMFZQWXdURTFabHJab1F4ZFVhbEJaMXhjbi9LY3U3TWdKZk0vakJ0Y0lY?=
 =?utf-8?B?dGZMN1FCai9iUW5PRHQ4M0dDU1J5L0RwTUEwQnpzSTBocFhvMnlnV0Q2dm5h?=
 =?utf-8?Q?J1n2070R0uICxJxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BAC6D6F50F1DA45A99C14C2F7EB5153@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R+s/0nEQu99/a0uk7cdg+0FOD3fyz/KTWoL+wiZ5aPkQ33+PY1SiW5v2/bFQXgnZl+eJ+VovpkLAG4raUTmfD4ixdqNdiU4vRMcYktFFMzrGFU/KNWkAsrc/zG2ozEDtykuFX15+phoYXnxuywc0b64nQqqqn556H98h207wz/MVSnBTBHfeEXwFVMYgw//3VLZfvy/6Ro+Co+Eerx6Gf1063qVKmyDhOQUPeutr32SEC7u8TDfG+wki52RFK2BxxVN/M6d8CcaZ5/QC7fouHAA7hy0TZkFPWSZVaQDZacWy2WlbyOH8SMKLq+Zs0G6+iBDQJshYCQYKzaHc7lrKVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9181afa-02c5-4e05-b8bf-08df460c5be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 07:11:40.5123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EBceDq7JPlyJYIL7BChUXOo5GMlxdLt5WmouVcMBYF7tbCftaOdQu2npnuWDNR9C6OI4j6vONjM5YNqU38sJIFYOK8nBv1fV21CLW8nOZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9550
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBBUyBTRFAgZm9yIFBhbmVsIFJlcGxheSB3aXRoIEFVWC1sZXNzIEFMUE0gYW5kIHRoZSByZWxh
dGVkDQo+IERQX0ZJWEVEX1ZUT1RBTF9BU19TRFBfRU5fSU5fUFJfQUNUSVZFIHNldHRpbmcgYXJl
IGxpbWl0ZWQgdG8gZURQIGJ5DQo+IGludGVsX3Bzcl9uZWVkc19hbHBtX2F1eF9sZXNzKCkuIERQ
IFBhbmVsIFJlcGxheSBjYW4gbm93IHVzZSBBVVgtbGVzcw0KPiBBTFBNIGFzIHdlbGwsIHNvIGJh
c2UgdGhlc2Ugb24gdGhlIEFMUE0gc3RhdGUgaW5zdGVhZC4NCj4gDQo+IGhhc19hbHBtIGlzIGRl
Y2lkZWQgb25seSBpbiB0aGUgbGF0ZSBjb21wdXRlIGNvbmZpZywgYWZ0ZXIgQVMgU0RQIGhhcw0K
PiBiZWVuIGNvbXB1dGVkLiBVc2UgYWxwbV9zdGF0ZS5hdXhfbGVzc19wb3NzaWJsZSB0byBkZWNp
ZGUgd2hldGhlciBBUw0KPiBTRFAgaXMgbmVlZGVkLCBhbmQgaGFzX2FscG0gZm9yIHRoZSBsaW5r
IHRyYWluaW5nIERQQ0Qgc2V0dGluZywgd2hpY2gNCj4gaGFwcGVucyB3aXRoIHRoZSBmaW5hbCBz
dGF0ZS4NCj4gDQo+IGludGVsX3Bzcl9uZWVkc19hbHBtX2F1eF9sZXNzKCkgaXMgbm93IHVzZWQg
b25seSB3aXRoaW4gaW50ZWxfcHNyLmMsDQo+IHNvIG1ha2UgaXQgc3RhdGljLg0KPiANCj4gQ2M6
IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KDQo+IC0tLQ0K
PiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA0ICsrKy0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYyB8IDIgKy0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX3Bzci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0N
Cj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyIC0tDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kcC5jDQo+IGluZGV4IDQzYjE3ZDJlZDkzZi4uMDJlYTNmMmIwMGFjIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+IEBAIC0zMjc0LDcgKzMyNzQs
OSBAQCBzdGF0aWMgYm9vbCBpbnRlbF9kcF9uZWVkc19hc19zZHAoc3RydWN0DQo+IGludGVsX2Rw
ICppbnRlbF9kcCwNCj4gwqAJaWYgKGRybV9kcF9pc19icmFuY2goaW50ZWxfZHAtPmRwY2QpKQ0K
PiDCoAkJcmV0dXJuIGZhbHNlOw0KPiDCoA0KPiAtCWlmIChpbnRlbF9wc3JfbmVlZHNfYWxwbV9h
dXhfbGVzcyhpbnRlbF9kcCwgY3J0Y19zdGF0ZSkgJiYNCj4gKwkvKiBoYXNfYWxwbSBpcyBub3Qg
ZmluYWwgeWV0LCBzbyBjaGVjayBpZiBBVVgtbGVzcyBBTFBNIGlzDQo+IHBvc3NpYmxlICovDQo+
ICsJaWYgKGNydGNfc3RhdGUtPmhhc19wYW5lbF9yZXBsYXkgJiYNCj4gKwnCoMKgwqAgY3J0Y19z
dGF0ZS0+YWxwbV9zdGF0ZS5hdXhfbGVzc19wb3NzaWJsZSAmJg0KPiDCoAnCoMKgwqAgIWludGVs
X3Bzcl9wcl9hc3luY192aWRlb190aW1pbmdfc3VwcG9ydGVkKGludGVsX2RwKSkNCj4gwqAJCXJl
dHVybiB0cnVlOw0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYw0KPiBpbmRleCAwZGJjNjE3NGM0MDIuLmM3
YTNjZmQyOWUzNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gQEAgLTExMjQsNyArMTEyNCw3IEBAIHN0
YXRpYyBib29sDQo+IMKgaW50ZWxfZHBfcHJfd2l0aF9hc19zZHBfZW5hYmxlZChzdHJ1Y3QgaW50
ZWxfZHAgKmludGVsX2RwLA0KPiDCoAkJCQljb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0K
PiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+IC0JcmV0dXJuIGludGVsX3Bzcl9uZWVkc19hbHBtX2F1
eF9sZXNzKGludGVsX2RwLCBjcnRjX3N0YXRlKQ0KPiAmJg0KPiArCXJldHVybiBjcnRjX3N0YXRl
LT5oYXNfcGFuZWxfcmVwbGF5ICYmIGNydGNfc3RhdGUtPmhhc19hbHBtDQo+ICYmDQo+IMKgCQko
Y3J0Y19zdGF0ZS0+aW5mb2ZyYW1lcy5lbmFibGUgJg0KPiDCoAkJIGludGVsX2hkbWlfaW5mb2Zy
YW1lX2VuYWJsZShEUF9TRFBfQURBUFRJVkVfU1lOQykpOw0KPiDCoH0NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jDQo+IGluZGV4IDRjNDI5YTE0YjUwZS4uMDg3
NWRlMzNmMGRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX3Bzci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNy
LmMNCj4gQEAgLTQ1NjYsOCArNDU2Niw4IEBAIHN0YXRpYyBib29sIGludGVsX3Bzcl9uZWVkc19h
bHBtKHN0cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgCQkJCQnCoMKgwqDCoCBjcnRj
X3N0YXRlLQ0KPiA+aGFzX3BhbmVsX3JlcGxheSk7DQo+IMKgfQ0KPiDCoA0KPiAtYm9vbCBpbnRl
bF9wc3JfbmVlZHNfYWxwbV9hdXhfbGVzcyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiAt
CQkJCcKgwqAgY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUpDQo+
ICtzdGF0aWMgYm9vbCBpbnRlbF9wc3JfbmVlZHNfYWxwbV9hdXhfbGVzcyhzdHJ1Y3QgaW50ZWxf
ZHAgKmludGVsX2RwLA0KPiArCQkJCQnCoCBjb25zdCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0
ZSAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+IMKgCXJldHVybiBpbnRlbF9kcF9pc19lZHAoaW50ZWxf
ZHApICYmIGNydGNfc3RhdGUtDQo+ID5oYXNfcGFuZWxfcmVwbGF5Ow0KPiDCoH0NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmgNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5oDQo+IGluZGV4IDI1NTc3NzZhNDAy
Yi4uOGFkYjI3YzIxNDA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX3Bzci5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfcHNyLmgNCj4gQEAgLTc5LDggKzc5LDYgQEAgdm9pZCBpbnRlbF9wc3JfdHJpZ2dlcl9mcmFt
ZV9jaGFuZ2VfZXZlbnQoc3RydWN0DQo+IGludGVsX2RzYiAqZHNiLA0KPiDCoGludCBpbnRlbF9w
c3JfbWluX3NldF9jb250ZXh0X2xhdGVuY3koY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUN
Cj4gKmNydGNfc3RhdGUpOw0KPiDCoHZvaWQgaW50ZWxfcHNyX2Nvbm5lY3Rvcl9kZWJ1Z2ZzX2Fk
ZChzdHJ1Y3QgaW50ZWxfY29ubmVjdG9yDQo+ICpjb25uZWN0b3IpOw0KPiDCoHZvaWQgaW50ZWxf
cHNyX2RlYnVnZnNfcmVnaXN0ZXIoc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkpOw0KPiAt
Ym9vbCBpbnRlbF9wc3JfbmVlZHNfYWxwbV9hdXhfbGVzcyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVs
X2RwLA0KPiAtCQkJCcKgwqAgY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNf
c3RhdGUpOw0KPiDCoGJvb2wgaW50ZWxfcHNyX3dha2VfbGluZXNfZml0X2ludG9fdmJsYW5rKGNv
bnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLA0KPiDCoAkJCQkJwqAg
aW50IHdha2VfbGluZXMpOw0KPiDCoHZvaWQgaW50ZWxfcHNyX2NvbXB1dGVfY29uZmlnX2xhdGUo
c3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCg==
