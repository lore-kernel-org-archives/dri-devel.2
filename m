Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E1606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nNTzlqtD;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Prnti6NR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5135810FB50;
	Wed, 18 Nov 2026 11:45:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3532910FB4D;
 Wed, 18 Nov 2026 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795002348; x=1826538348;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Lb5zxzqtVxCtP2Nj1xLrgcQx5zH0SiCFmb/qLwxh+1Y=;
 b=nNTzlqtD8IX5SS+Wneq5NpIvaEUxlf/1BnLKmuFCUFHewwh4YNuOtAGH
 7KODVWviJwc9zAAt681DpuX6YI15tAGQcTx55tFqrVrCErFs53ADqbau3
 MjN11BsxLDv4Lsr+BOVFz0Pw9UPzQJpkjzg8M5nxJOUM7YCYqvLqMgtaK
 9/422cyO/moD6zDv7sA2Z3cGyi4b6QXhEksIR3ondQvDNIyqi6qC7dG1p
 U83VCdOKCFygdbFSesW7kAW/+Qtfdc7HroD9oBDqfcaVerCii/KMcfTGO
 mrWOfdBAHcCKx8Ntg2TcLxT2OdYbrqPg75EOxv4Zkpi3nsdmw2rhyyhaV A==;
X-CSE-ConnectionGUID: Iquu1EKgQHadqgIGntXTRw==
X-CSE-MsgGUID: 3uDbrRFZT7efCmhuE2kI6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3688739"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3688739"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:45:47 -0800
X-CSE-ConnectionGUID: 5tp3hvSGRhmcIRgWu4hgpA==
X-CSE-MsgGUID: jz48twMUQq6zY/8yr7xNJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10005984"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:45:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:45:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 03:45:46 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:45:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Urum/HtPF5wm/IcC8c2/LDvxlxsxjNVwjJ567HIy9tizxPv6crdCfezYl43YVndY4/X9WaZvImNz4CJEr3sA5eIftLrd5RswbzWW1jyZjkJXpQMCiKE6xAlmmWCthV4lKFkZCtHXRIkJ6VMLP2F/1vUglDxLmeryJ+BCynn/vzRv3HcjShwVLTQ3G4pdUo/lN+LD8i8M9rDC63Q721rDn3JYxErLzQaNfxv7G3LhdbPbM3Ns/DElsMTi621YOtuvJEpcZGg8V3b8mYhQjy4jIn0ofz0Fr0b2TfOTADAGfU7xplWaNxMSG3yMla7IOIxvBo73XyXGsvr7L0dqtjWo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb5zxzqtVxCtP2Nj1xLrgcQx5zH0SiCFmb/qLwxh+1Y=;
 b=JOBdsHcTqNHGBrFkD+KLaY8bWfXVXPMYT4dhFIh5WTq5vLyh/fA+ZTJfGuAKU59dH7FZH6umTVwg4Lo71W4eLjuFDIyCWPf2QRufr4FlwoGMxohWjYXU9vk8efR5u9WWXx0AwCs6Nh9B9oi720WeeahkDc1CtVCNgnDPX0eW81YeBnM/PuI5wJXlQMIMtKfMb07LCbGAdCicKzqMM8WfMS4izy4QWrddzpFyEySLZf8eaeuWGfN1aNAP+R1ycPywTHjdpsHkVsRbYA238eaZslJpiX8XJJsptYuZORQzDmDWSnms2iqs+3rLmACxrWUHMALZHpiIVosPK08jloZfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb5zxzqtVxCtP2Nj1xLrgcQx5zH0SiCFmb/qLwxh+1Y=;
 b=Prnti6NRy1yRk7VIjIy7pmG28iw1ql07j40s3tPA0kgJjG1mrL+CcBv5uwtbtZE9PUOImSwbl+HgwCwkyy4jbZoKJouxTPpWclPcvq1OUVSFtuKW/zRZZmhr9NXL6dWQfqou4751D+kSaK6qON875sOb06GNWgQB169ymdgO5pA=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:45:08 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:45:08 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 05/20] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Topic: [PATCH v7 05/20] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Index: AQHdZQyHWy2rStUIOUis18WVdkhf2rcz2muA
Date: Wed, 18 Nov 2026 11:45:08 +0000
Message-ID: <318261d8f322789cc8661bc9295fa652c3f3f203.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-6-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-6-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|CH3PR11MB7867:EE_
x-ms-office365-filtering-correlation-id: 9d8051cc-1325-41a5-4b7b-08df4569654e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: lU6znbJjg1MF8zgSTZtih3p1dV3HLB79iijftj0/igFQNi7r/5fQxfewXGIT/Fq4LsNkyZLiDsP+zHGOghAQCmbxbdGvbEw4d6vfnOdjsLwO9IumT6h37vYJ+C+uEnQnsuRjuA22+6VBhjxtDagEHy+WekBZczqSRh1zQSqu2evOXk4jo4hYYLelROIeH5Xb3be3QwiGY19fbW16ymjD2DxzyUztvO3bbF1oJj7zlRLJJ5b86OOEQfxjCrFrtYpe7DqeXsLdzTazUH7YkN50+eVBNFZX/CCMZZ6QgW1VOvXTZYDZUCQJLSnFHNfyBBpJQ96BgdwiFgan7Ro+Cwxn1p1/gNr2e1enwt6P2+STbYfNzekBqYTmNoLDeon6sV1y8pmi7LdbSTBdwFnlQY9EK6G+Y8zb8eI3pLypjXfSaH8tOmKlcM/N9ShZSo4s5bCmrBpRoJoc+Y+UBbb+T7qgrLKcuf+iRc17s4GfwsOGjEtfbWhmYPxC7riKgHi+WvIAmSTpHzwXqT/IcpxndzH9sPOxHEX7xDHM2uTscYu1/2UNfHApr1i2f5bsWnXix+j1xxSh6B2ufPhDLy9WfufFV+Z7neV1ZanNKtv1AkJJAOBEvAvHI/cFAnbAwynrCNQ+Me3Ncd05ez/1C/NJ3SgzupeR0KBzbx79tbTk8ootcSfzB8Ff5ZLiEECi4c9MVGz6LZ0jtsqAs/1QmAIy8TVJGQqSNSolpwMDrHlctetO0sQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2ZPdktrR1BLN0Q0SEFUbW5Uck1tQzVyT1N1K2pISGcxVUI1Sy9odmtQNHd0?=
 =?utf-8?B?dzQveHdMeTUxTUt6cWlHTDI1MCtRdnljWFkvdmRSYUxHYktGZG1iZnpwZXlW?=
 =?utf-8?B?a25FMU96aFBCaUJaclVyZENXTmVTUytLWUxhalRWdU03Q2dFaVdLN3ZNdENV?=
 =?utf-8?B?ZWhzN0pIZVRjRWpLUDZTQzhidi9hdWtVRWVtbFBFY3lPNGdwbkFpYTVsdFIx?=
 =?utf-8?B?RUhBelRWMHZhQ3RxWWFNNG1JeThTT3IxZkN5WTIxNlk4K2doVk1yanoxNHFr?=
 =?utf-8?B?MEJTakxrRHhCOEdFMmNqUlNoaTNYdUkzODZYOUY4c2gzdyszblM1OU1PY0Nn?=
 =?utf-8?B?RGRYQS9ia2lYeDR1ekdxdFZwZjlhekdCWlc5bmRpUnhwR0FZaTlNNmdyU2tS?=
 =?utf-8?B?bGVhSEVxN3AybitPZ2Fvci9ic1puUjBncmozWmdza2h4Z0RzeThxcWxEZFpR?=
 =?utf-8?B?ak5HRmZoNUtSQ1Y3NmN1LzFCOTVHL25KNElVN0dsU1VCa3Y2a3pObHgwNTBV?=
 =?utf-8?B?TDU4VG1CSTNhcU9Nako5VFpRRklXYTRUMW5rcHZJYTlFRWYyb0N5aStCMEpr?=
 =?utf-8?B?RVpIelJyRDVIdWVIY2N6L20zY0Z6ZGJGTGc2b1ZMcXpndVc3Q0pvSUk5WXo3?=
 =?utf-8?B?cmpFc0p5MGxYKzB2NEgwWHBtRk56ZDI5U0Z2MnNibnVkMTVPY0tQeGs0eGRt?=
 =?utf-8?B?WHgyS3dYYWd3L0JBbmt3ZmJ1RTZYUzZzbUtwQ3A1Y0pLZ1BVdVBrYXliNHhR?=
 =?utf-8?B?Q0hyNjM4N0JwbkZkRnAyVVlFcnFaQW42T05xQ2c1VTZoWWVBZnNvQVd4OFcr?=
 =?utf-8?B?TVZ3VXl4V3hkQVZCRmNCdnZ0NFdnd2xXeGFiSWIwdTdPcll3QVJFZHVOeU9C?=
 =?utf-8?B?MStQdm9Jb0FCME1CVk5UcjlTbWVrS3hOT3g5YWZKZGtGNDh0alJkOTNKMEc3?=
 =?utf-8?B?Ym9pekpXb1k3eFB6UEhTVlZxbVMrS054dmVlbGYvT1p5NnRmbjkwVW9BcEhG?=
 =?utf-8?B?RlBmd1Azc09mcWdvbHoxUlFMcnp6NDRjR3lqNllrNHdETHFMSW5IMGZsTUt0?=
 =?utf-8?B?TzZKbDZoaTVTTkhHT3VZWWhXV1lJTHJvNkx1K1NyS29NcWVSS3FWMWVrZUs1?=
 =?utf-8?B?L2h0ZHcrcTRNZkRUcE51ZEtMVXZZWEdJVjMrRjV5WkhTamU5NXd2NWNVK0NW?=
 =?utf-8?B?TFltMGVtczF4ZER4VlJTbGZVcmxTY1RQVDJGc1hWNmRDTVRVNnVZelg5QmQ1?=
 =?utf-8?B?QTVXeVQ1V3duWmJyVnRiRzh4NEdsc0tSeXNLS3U2d3NXUDY2RzJnemVIVXRN?=
 =?utf-8?B?aVdDWXdXa1ZwTll5K3ZuZ052OHZENHRqQVdVSm9VdDdtR0Flc215aWN5ajZJ?=
 =?utf-8?B?Z09CTzI2ZkM4OG9TcmhEN3BraG9BNmJyZXJ0S041WEZGVTNILytheFpHNlp3?=
 =?utf-8?B?Tm8xTkVOVW1WUURNa0I2V0RXT2xOc0VFZi9oelZxaElFUG9tdmRYUUJTc0o3?=
 =?utf-8?B?ZVRCOThYVHcxVW9yejg3YmhMOFU5enFuVVozR2JSTGVVNDNrdXVuVnUvd2Ft?=
 =?utf-8?B?OXA5eHpDYkV3TkdtSUlTK0NsWHJnUGphSldsc1lQYzFMSE1teUNPdk9zMWtr?=
 =?utf-8?B?MXh5R0JmVXBZLzZXcnR1QVZwRERnalNYUWlxMnAxOW02S2xPQ2xWMUVGME9J?=
 =?utf-8?B?N0ZkNEV3dVgvN1hSaFNYdGRDSktpcEl5eGtyR1lJYkxhbVRRZkdjNnJsZkdE?=
 =?utf-8?B?ZVNvTE5WZDFDcUF2YStlNEk3MnZCK3djSUt0c3FaNHpDb0p2TWJ2UFFIOENL?=
 =?utf-8?B?TTJYSThXeXM0b3F3UU9LdEtGMjhTQUpvQTFBeHBjdnZwZ1E2YU1WVE1vbzh3?=
 =?utf-8?B?MDdXWXg2U2gxb244eDFpZHpaSVJPQkViajEvY0R6bnlyNHVIOGNVV1ZUK3ZJ?=
 =?utf-8?B?c2ZoeS9QZ1lia1FRbC9obUViRDhQOVhjRkQvS3paQUFvSWdTUmFvcm1DY0xC?=
 =?utf-8?B?dWJ4YThFd3F3OGtzRElKVDhsQUxjMHRkN0pCK1I5QUdjSzRMSkd2T0dsdjR1?=
 =?utf-8?B?ZGlITVlITFB6VWRHaGJpQ0lDZVEzNEl4Ylc5L1pLWVJTWitsS1lQQzQzcHNP?=
 =?utf-8?B?MHVudS9SdFZVcThXQ2hMUFo3c3Z3SzVQSTdsZU1rZ05hVjB3WWtjeWVvTU5o?=
 =?utf-8?B?a0lIdWFFTlAxcFRGYW9OcldMYWdWcm5MVU5JWGZ4djQ0dWh5bGNRa1NLb0JX?=
 =?utf-8?B?WGJTOTY5Z283V1h2UTZzV1FxZUQzYzVHSWJYSzgzU25OVndkRkk2cWdZRGxW?=
 =?utf-8?B?T2VXN0RkcjZ5c09WTkVpNk1ZMEFnb0tNMm9HaVAxaXptSUJ1bFN1VVM2alNW?=
 =?utf-8?Q?DSyKqFBqh2tFDTwQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D74E7107A0B914DBCBA7860DC0FD909@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qg6wq8aZG/rTY//f082C1GAL80B8LWX6lluRB8wv9gaSQ8CwFaHk2xT+UIfgGeGfER5wbxTNBhB2vzoSAmy6hGGR2QxiznA2bY/B75+0mGLayU7YV+gbj2X9W8CRRspbb9c+cQl0VcHEkc8IKJ6VJdGXroztUHhCE7ziJuXMkWuZSKgf59zlUB1kqOA/tsdBzZHq6t4NV7dJX8vMdKtbLaFUwr8xAi19RIuJxOxZXtJMbz5dAFZ8IWmiswhq80orgjzfHodUMirAYX2aN2NZ1PZCYiK7zE+5SWu7rxWSHxezrJ1UsuUEPsVCVqOxVUjCPpCV6Nvk6F26Bb/Oe9D8fQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8051cc-1325-41a5-4b7b-08df4569654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:45:08.2665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAjW9isJOgvfe0w+SRvSDtxt3CF+ReDZe0rGgjsD272NQtn8DH+H7aNh1Td9R75zE4pyYM+mklkkZEXoGgO8ZeAqpPXqx+SxV11jxImmoHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBFbmFibGUgQUxQTSBkZWJ1ZyBpbmZvIHRocm91Z2ggbG9iZiBkZWJ1ZyBpbmZvLg0KPiANCj4g
QXMgTE9CRiBkZWJ1Z2ZzIGVudHJpZXMgYXJlIG5vdyBjcmVhdGVkIGZvciBib3RoIERQIGFuZCBl
RFANCj4gY29ubmVjdG9ycywNCj4gcmVuYW1lIGk5MTVfZWRwX2xvYmZfZGVidWcvaTkxNV9lZHBf
bG9iZl9pbmZvIHRvIGk5MTVfbG9iZl9kZWJ1Zy8NCj4gaTkxNV9sb2JmX2luZm8uIFRoZSBjb25u
ZWN0b3IgdHlwZSBpcyBhbHJlYWR5IHBhcnQgb2YgdGhlIGRlYnVnZnMNCj4gcGF0aC4NCj4gDQo+
IHYyOiBjb3NtZXRpYyBjaGFuZ2UuIFtTdXJhal0NCj4gdjM6IFVzZSBjb21tb24gYXBpIGluc3Rl
YWQgb2YgRElTUExBWV9WRVIgY2hlY2sgaW4gbXVsdGlwbGUgcGxhY2VzLg0KPiBbSmFuaV0NCj4g
djQ6IEFkZCBkaXNwbGF5LXZlcnNpb24gY2hlY2sgYXMgaXQgZHJvcHBlZCBmb3IgRURQLg0KPiB2
NToNCj4gLSBSZW5hbWUgZGVidWdmcyBlbnRyaWVzIHRvIGk5MTVfbG9iZl9kZWJ1Zy9pOTE1X2xv
YmZfaW5mby4gW0pvdW5pXQ0KPiAtIFJlYmFzZSBvbiBpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0
ZWQoKSB0YWtpbmcgaW50ZWxfZHAgYW5kIHNraXANCj4gwqAgTVNUIGNvbm5lY3RvcnMgYXMgdGhl
eSBoYXZlIG5vIGZpeGVkIGVuY29kZXIuDQo+IA0KPiBDYzogSm91bmkgSMO2Z2FuZGVyIDxqb3Vu
aS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBTdXJhaiBLYW5kcGFsIDxzdXJh
ai5rYW5kcGFsQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5p
bWVzaC5tYW5uYUBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpv
dW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDMxICsrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4
IGI2MzA3ODYyYjc1Ni4uMTJkYzc5MTk4NDk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtNjgwLDcgKzY4MCw3IEBAIHZvaWQgaW50ZWxf
YWxwbV9sb2JmX2VuYWJsZShjb25zdCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqbmV3X2Ny
dGNfc3RhdGUpDQo+IMKgCX0NCj4gwqB9DQo+IMKgDQo+IC1zdGF0aWMgaW50IGk5MTVfZWRwX2xv
YmZfaW5mb19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqZGF0YSkNCj4gK3N0YXRpYyBp
bnQgaTkxNV9sb2JmX2luZm9fc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpDQo+
IMKgew0KPiDCoAlzdHJ1Y3QgaW50ZWxfY29ubmVjdG9yICpjb25uZWN0b3IgPSBtLT5wcml2YXRl
Ow0KPiDCoAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXko
Y29ubmVjdG9yKTsNCj4gQEAgLTcxNCwxMCArNzE0LDEwIEBAIHN0YXRpYyBpbnQgaTkxNV9lZHBf
bG9iZl9pbmZvX3Nob3coc3RydWN0DQo+IHNlcV9maWxlICptLCB2b2lkICpkYXRhKQ0KPiDCoAly
ZXR1cm4gcmV0Ow0KPiDCoH0NCj4gwqANCj4gLURFRklORV9TSE9XX0FUVFJJQlVURShpOTE1X2Vk
cF9sb2JmX2luZm8pOw0KPiArREVGSU5FX1NIT1dfQVRUUklCVVRFKGk5MTVfbG9iZl9pbmZvKTsN
Cj4gwqANCj4gwqBzdGF0aWMgaW50DQo+IC1pOTE1X2VkcF9sb2JmX2RlYnVnX2dldCh2b2lkICpk
YXRhLCB1NjQgKnZhbCkNCj4gK2k5MTVfbG9iZl9kZWJ1Z19nZXQodm9pZCAqZGF0YSwgdTY0ICp2
YWwpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgaW50ZWxfY29ubmVjdG9yICpjb25uZWN0b3IgPSBkYXRh
Ow0KPiDCoAlzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwID0gZW5jX3RvX2ludGVsX2RwKGNvbm5l
Y3Rvci0NCj4gPmVuY29kZXIpOw0KPiBAQCAtNzI4LDcgKzcyOCw3IEBAIGk5MTVfZWRwX2xvYmZf
ZGVidWdfZ2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQ0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMg
aW50DQo+IC1pOTE1X2VkcF9sb2JmX2RlYnVnX3NldCh2b2lkICpkYXRhLCB1NjQgdmFsKQ0KPiAr
aTkxNV9sb2JmX2RlYnVnX3NldCh2b2lkICpkYXRhLCB1NjQgdmFsKQ0KPiDCoHsNCj4gwqAJc3Ry
dWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9yID0gZGF0YTsNCj4gwqAJc3RydWN0IGludGVs
X2RwICppbnRlbF9kcCA9IGVuY190b19pbnRlbF9kcChjb25uZWN0b3ItDQo+ID5lbmNvZGVyKTsN
Cj4gQEAgLTczOCw4ICs3MzgsOCBAQCBpOTE1X2VkcF9sb2JmX2RlYnVnX3NldCh2b2lkICpkYXRh
LCB1NjQgdmFsKQ0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQo+IC1ERUZJTkVfU0lNUExF
X0FUVFJJQlVURShpOTE1X2VkcF9sb2JmX2RlYnVnX2ZvcHMsDQo+IC0JCQlpOTE1X2VkcF9sb2Jm
X2RlYnVnX2dldCwNCj4gaTkxNV9lZHBfbG9iZl9kZWJ1Z19zZXQsDQo+ICtERUZJTkVfU0lNUExF
X0FUVFJJQlVURShpOTE1X2xvYmZfZGVidWdfZm9wcywNCj4gKwkJCWk5MTVfbG9iZl9kZWJ1Z19n
ZXQsIGk5MTVfbG9iZl9kZWJ1Z19zZXQsDQo+IMKgCQkJIiVsbHVcbiIpOw0KPiDCoA0KPiDCoHZv
aWQgaW50ZWxfYWxwbV9sb2JmX2RlYnVnZnNfYWRkKHN0cnVjdCBpbnRlbF9jb25uZWN0b3IgKmNv
bm5lY3RvcikNCj4gQEAgLTc0NywxNSArNzQ3LDIyIEBAIHZvaWQgaW50ZWxfYWxwbV9sb2JmX2Rl
YnVnZnNfYWRkKHN0cnVjdA0KPiBpbnRlbF9jb25uZWN0b3IgKmNvbm5lY3RvcikNCj4gwqAJc3Ry
dWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkgPSB0b19pbnRlbF9kaXNwbGF5KGNvbm5lY3Rvcik7
DQo+IMKgCXN0cnVjdCBkZW50cnkgKnJvb3QgPSBjb25uZWN0b3ItPmJhc2UuZGVidWdmc19lbnRy
eTsNCj4gwqANCj4gLQlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAyMCB8fA0KPiAtCcKgwqDC
oCBjb25uZWN0b3ItPmJhc2UuY29ubmVjdG9yX3R5cGUgIT0NCj4gRFJNX01PREVfQ09OTkVDVE9S
X2VEUCkNCj4gKwlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAyMCkNCj4gKwkJcmV0dXJuOw0K
PiArDQo+ICsJaWYgKGNvbm5lY3Rvci0+YmFzZS5jb25uZWN0b3JfdHlwZSAhPSBEUk1fTU9ERV9D
T05ORUNUT1JfZURQDQo+ICYmDQo+ICsJwqDCoMKgIGNvbm5lY3Rvci0+YmFzZS5jb25uZWN0b3Jf
dHlwZSAhPQ0KPiBEUk1fTU9ERV9DT05ORUNUT1JfRGlzcGxheVBvcnQpDQo+ICsJCXJldHVybjsN
Cj4gKw0KPiArCWlmIChjb25uZWN0b3ItPm1zdC5kcCB8fA0KPiArCcKgwqDCoA0KPiAhaW50ZWxf
YWxwbV9zb3VyY2Vfc3VwcG9ydGVkKGludGVsX2F0dGFjaGVkX2RwKGNvbm5lY3RvcikpKQ0KPiDC
oAkJcmV0dXJuOw0KPiDCoA0KPiAtCWRlYnVnZnNfY3JlYXRlX2ZpbGUoImk5MTVfZWRwX2xvYmZf
ZGVidWciLCAwNjQ0LCByb290LA0KPiAtCQkJwqDCoMKgIGNvbm5lY3RvciwgJmk5MTVfZWRwX2xv
YmZfZGVidWdfZm9wcyk7DQo+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgiaTkxNV9sb2JmX2RlYnVn
IiwgMDY0NCwgcm9vdCwNCj4gKwkJCcKgwqDCoCBjb25uZWN0b3IsICZpOTE1X2xvYmZfZGVidWdf
Zm9wcyk7DQo+IMKgDQo+IC0JZGVidWdmc19jcmVhdGVfZmlsZSgiaTkxNV9lZHBfbG9iZl9pbmZv
IiwgMDQ0NCwgcm9vdCwNCj4gLQkJCcKgwqDCoCBjb25uZWN0b3IsICZpOTE1X2VkcF9sb2JmX2lu
Zm9fZm9wcyk7DQo+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgiaTkxNV9sb2JmX2luZm8iLCAwNDQ0
LCByb290LA0KPiArCQkJwqDCoMKgIGNvbm5lY3RvciwgJmk5MTVfbG9iZl9pbmZvX2ZvcHMpOw0K
PiDCoH0NCj4gwqANCj4gwqB2b2lkIGludGVsX2FscG1fZGlzYWJsZShzdHJ1Y3QgaW50ZWxfZHAg
KmludGVsX2RwKQ0K
