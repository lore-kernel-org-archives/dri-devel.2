Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B6DC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B5B10E0EC;
	Tue,  4 Aug 2026 21:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AwOCjPBT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9860710E0EC;
 Tue,  4 Aug 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785879225; x=1817415225;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Tji5yf7e12AVk/uIrbLEKI3my6lEvzDOu9FlaAw2S1o=;
 b=AwOCjPBTm8w7mKXVTJivioIot0qmCbpP6G1kMfs1WpDMs+ei0nHitSfk
 9PM8iYKhhfq0CVnZA7j3bXiKjbwdwAGDRzib+hkYgIvoE8YPjg0k8Mr/y
 c28kF11K2+novg6OhM4iFbaXxZTJEKbWfYuUM92sZkH04nAZAftmwh5Lk
 i85VAsL7hAgRIP1VARysVA5aMT2oOK9QGp4VOARFdkvq9sg2p5EPRt8It
 8qmcUv+36tm7znnZUhHYeFsg8iQxiO6N0cGw/mZ1zW2W0qSeE10Pgm7Qk
 RccByr/PAtEZeZKp6eLKyVIiVsBMt/ZaC3TYVdp+qsY5jiTgQofP3AdSD A==;
X-CSE-ConnectionGUID: Agp+YvRMT7WdyQy2pJL7Rw==
X-CSE-MsgGUID: 9g5oVgHESIadpcMRBJDJhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85421518"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="85421518"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:33:45 -0700
X-CSE-ConnectionGUID: dnrGZAULRFW8cSFRVd7SIw==
X-CSE-MsgGUID: Y0s1EUDcRtmAlCswuTeiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="261046719"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:33:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:33:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 14:33:44 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9ElhDpi3iQ/VJ4tAeJX3SBZGhprAoXX564CjWtvGRd0/lzJLoqFCQWnPFsJnnvybLliCuigvk6K98A5qk4JnOtMXMi7DRHyENJwzhVS8yxrS/5jn7kP4zxqtsu/20r+BtDjgDOqZy5ufGwxzCg/C5bVrcwpOn3GT5r7sBz0xi9hd9+Xszd6Eow604nB8fS69UWPntKYf7aKIjQo+PjdGYS4bC7Ndy7E8x8iLhi+wRk+ZQHSV+hrtwC8OE+Jhmk2MTYRU8Qr4wLbPmbpsouvw4bsUwc9lD7i5ffOl7xSOqHROJQlL5Y18OMG9XGkWx/g4NFahpEl5UNHlJ4y3GX2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tji5yf7e12AVk/uIrbLEKI3my6lEvzDOu9FlaAw2S1o=;
 b=yVZjm7+xhTQ/HYXmCkYRt3IYu1bFQvApgNFF17/LStUm17n0i7jkYenkZerLiPq7zLGiRT/2oJT1ZQmfYIedX3QIbOaGrkEVk51uX/uwpUjAZd0OnrZuTXokKqJmKHZl7Bkr9w4l693CBUgE79qZsRUe0Bp3V7cPVibqRnBrOnEobasLQOxD1XAyzSZwefResnusPCM7ab/JkPBpiV2MbtvDruHbOXVrRanrhobvDH5/Y09ea5qUY+YrPl1Z2xVhDmvzmtHMkya2pErBtmACb4SDG0UFNvFYzsuPAWKUB/XMvzYVvNsO1LNOfECy/3G08tCjz7JZukcjIJiTkvVIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9)
 by LV3PR11MB8482.namprd11.prod.outlook.com (2603:10b6:408:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 21:33:41 +0000
Received: from CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76]) by CY5PR11MB6320.namprd11.prod.outlook.com
 ([fe80::9cd7:94d5:90f:4d76%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 21:33:41 +0000
From: "Summers, Stuart" <stuart.summers@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "Ceraolo Spurio, Daniele"
 <daniele.ceraolospurio@intel.com>, "talesam@gmail.com" <talesam@gmail.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Thread-Topic: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Thread-Index: AQHdI7cQmhH2EHhEx02YHK5nxm2FrraOYbmAgAAG+wCAAAGxgA==
Date: Tue, 4 Aug 2026 21:33:41 +0000
Message-ID: <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
In-Reply-To: <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6320:EE_|LV3PR11MB8482:EE_
x-ms-office365-filtering-correlation-id: e6ee6410-2308-494c-e791-08def2700dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: PdFoHUOI/x6zaPw0Q1u0lwE7QPpXsed5pTRnfaxEnn+E0OEst+qe8xMsNXKIQpTLJclNlHtZPls9rWfcfyiClEtwm6ERi4N8k3oXMzrZTWFHOLm44gs8v7JjXcQotc1NNzgGTtQGPoze5udc9POW369PQDvUf6AzV+MEgb4XXnmA+mzHm4GyJ1+D5N0SI6vcIm48ZAqOm/T2CtqeIfYsRex7l9thhC3tWNCOxedmgvMBMo+FYNRABdgayxIbkQsGT6bCJVrsPikO/krHVx4aIXpPfmU/kDs2Nh/y9HEs7fBlL8/k8dn+b6S/f6FRKHZBbsq5n7xDew7UjMbC/gGqrK/7B9MOby6alKq4w3Nh7dYpbS7s26aE9VP/wpa+rQbTqV9Xdtt43yIElrzNGocqj4BgofoMpWAWISr+LZZJ7qkyPrc+ixYSx2kNAD6kafXiX2E7mnJ1hYjFqbjQUPx4xJATa/KeoUMywXlHZO/6bRVQEmtdvbEB0gDVmIYv7+YglIalKmvvAlRTS1Q1KUmC57Lr6QsnUdhatCkKbiTbZ7AKwEM+B6R2t4nCG6D9J75ojSf/L6DqeZmwh47Jv+0EDd+fw7de3SAqU3QK0bu/TOy7JwchZNvJxDW+eDovpvO+bEIyWVIJKcHQN8WvAZy6DGy0eE8JxTEt2+W/TcFH2tg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6320.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkx6UmJraVVKRWt5Y2VJL1oySjAyQU1MNTEvN0ZFSlAxSUdUa2lvTW5NYVRK?=
 =?utf-8?B?UXVBS1NqR1cxUGFzMmxlVFZRVVJManpIZlBreG53RnRIb000cU9vcXJTNExs?=
 =?utf-8?B?Ry90MFZpeGI0c2IrNUFGcVM4NG9BbXZsOVhFem1hanF2L0dXNU9KdDBZdk9l?=
 =?utf-8?B?WS8ra21zemNxOVVTVVkralpLbkxGc2ZoMmN2MlNBaVUramg4czIvQllyOXlP?=
 =?utf-8?B?ek42eCtXWkV4VnIraEhEalRQU0w2aDNyc01wY2V2dS8xUFpRZ2tDMXhxRlk1?=
 =?utf-8?B?eTdWdjJWeEdITHBrVXJkZmh4cVk1TVZMTVdOc09kd2x6emdsSDdqb0NrNVVX?=
 =?utf-8?B?M0o0RHdQc3BETlo3R1dGR0NxUFRHTlpseGttY29uRHp2dU43N3VtNm94M1NR?=
 =?utf-8?B?S0pCSm01ZlJOZzVPUklJZXVDenRvbFFqeXRIUG9qUGV6UHEvVktxamlJWUZQ?=
 =?utf-8?B?cC9LbVBuUENkc2JyMTNrQ3dRTWltanpvaGRwYjc5Mm1vbTIrQnBzcDkyeSt0?=
 =?utf-8?B?YXEzVkZXZmliNVBJd29nWmR0UWpyei9rYWdJd3lMWHhFOUhrQTNtM0g0UFVG?=
 =?utf-8?B?NnZGY2MwTEZWTFlsWkRQU05jMnFxaW9MUWJDeVl0YURpaUw5cEZOK21EMktW?=
 =?utf-8?B?MjRqY0w1THM0cjhoR3JnaDFzVEpBNlJBeVJvYllKWnJ6NmRvdEZhUkk1d2Fa?=
 =?utf-8?B?NFJ1RXB6dTZFTjEzSXo5SWF5NWZxMmZjSGZKZkltUDRqMy8yS2xtZHN1dmlD?=
 =?utf-8?B?bGRSUk9qdjdyd01wdUNGOXBvQktRWFdUdFRhZDE1TVN3R0MxU1lIc3dZSUxx?=
 =?utf-8?B?SXRwREp0MWx0WFZRVkZxSDRpQ1BZWEFCbEg3cEtnUzJZcHF5dkZpdWFITzl6?=
 =?utf-8?B?SXFDYUZESmxoTUNuSXBNUHdnRXlkZkhvekRGMUtTQ0FGQmxxVlVGeXBRSDVW?=
 =?utf-8?B?MUtQdGV5VWIxMmJnSDJaTDIrSjBDd3hKYjdXRVZNY2d6K2k2SGVoRzVHV3Bo?=
 =?utf-8?B?dXZVMUg2V09vZHpjQUE0TW5xSFlaVVJFbzJMSW9iVEJ3VFNCdnpoZXE0cVpQ?=
 =?utf-8?B?ZFgwcEd6N1hWaGRYdTRBakxIaUhxalBXUXBnMFMxSjc0S1FwY0hCM25pL2k2?=
 =?utf-8?B?YXFvOTg2a2NDVnhuQzVzUXlHREc1UE1mbTIrSHRNSmlMQWlDYkpFQmcxamRP?=
 =?utf-8?B?Tm44ekc1aUN6TUxYdTIwZHNRRnZ6SndtYnpCeVpUVlQ3R0FlM0VwcDhQMHdm?=
 =?utf-8?B?K281alg4ZVduY213bks0MXNMM3M0anYrVTlMWjFMZHBXNDc0UGl4aktsUnRR?=
 =?utf-8?B?OTVTellTVXUwSHZEMElBMmJiZWtadjZuQ24zM0hBc3RCSG1lSnpjSlRibXIz?=
 =?utf-8?B?YlhFbUVoV0Vna0djVVRQM0xUYW1oc2ZIVmd5cXB2bll6ZEd6ajRNcHFhY2ti?=
 =?utf-8?B?MFcxdTN1NzRaSHU3aktySWFvenltYjRVaGVVaElyNUdNbmx3V21xeklwbmxI?=
 =?utf-8?B?UFd1T3ltM0dUL0ZYRG11c09rVGdreEE0dVpQcURPdXJPOHNYRlU0UC8rT0g3?=
 =?utf-8?B?eXgvbzk2NXFLdGRraW02b2NycnE2SGVpem4zcmZOY2lRTjlBZjMrbm84UGtm?=
 =?utf-8?B?Y1JoVmdzTzRsaEgxOXEvdkZzS1BNa2xTU09WeFNwT1VWWkFybndLYWRrSEtF?=
 =?utf-8?B?RTVpNnIwcndTUWhMaVo3Vmd6V2QweTN4UjFSaWlFblV0SmZBZ2J5VVNSRWtL?=
 =?utf-8?B?eU5qMGI5VFkxdTFFVXlQYk5HdGNGV2VhbHQzMDU5OXBLVVpEOGwxZmthZVB5?=
 =?utf-8?B?NGFFM0MyMzBpYVRLNGxZeUFnSHBCNHlsYlZsWWp0MER3ZjAwTzdvM0FZeDUz?=
 =?utf-8?B?TVNsMG8vRUJCKzBIYkY5RzhLcG1tUzRRSGl1ZnBCejNReExaL1FKNmg3b3l2?=
 =?utf-8?B?L2ZHRXZSTDZ1b2FMS2xhZGM3NVpDRVd1eHh3T2oyUzVhcHJaa3ZyekgwOVZZ?=
 =?utf-8?B?RHhtQjZvR1dyZXRWQzdoeTdPcE9vU29xMGxKTjBjY2VVQi9ydkVkUXBmTTFi?=
 =?utf-8?B?K1FWZ1VHTU4xdWdFa1VMa0U1V3JZZW9sR2JFSEllci9GTUlDSkV4SFQrSmsw?=
 =?utf-8?B?UFNvSFRCSzNZY3hnbWdzQURLVjZnY2N2bEtFWW9tdXF4aVFoZmFnem96Vk56?=
 =?utf-8?B?UGxTSGNPd3VETzBqdFJSdFZlQjhyMFE0aWR2a3prNGppNmdoeHk0N2ZGRnVN?=
 =?utf-8?B?RjJnVzdJTTVmSXlEcUZlcFhUVVF3RHB1Y2tvNTk0Ty9vR0k1eHp4V0o3bnMy?=
 =?utf-8?B?cnFtSkMvL0pVZUZwemtTelcxcGpKWUhsODZ0cVlmYnpkbm53L1AzUDkvdWRI?=
 =?utf-8?Q?NKKO6BuegC7WQ+D0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CC0848B09DFE840A1EE9F8D8884FEE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AQyk1XK3l80Nfxpz7Dj/cOuJF8t9W7gBJdWX8ea/Uf3TyGnMOp7Hbestcd+sTBNxsOVFb5mVaGqRkoP/FLDqrpJpOpH4P3Radx9ik5xDTgbC5e7nHPLlw1g9TWd2uKkAW0zYO6RqcTU0aOk7dD3AwjqpjSlbGzUyYfUkV3+ib56ZZxKX3/ezDLFhN8i5ljbhoQo8wEmble8xvmwnXWfGlDdEd8fg7dXumLkjnyvX4F4poFTplYz8nNBXj2JE+ZwuIrdKkSGh5As0WO/rBieAOX3n3yoTElPIwkFl1Pu+p0Ekuhn0HGklSzSEv9h+DxtEoqqW2yPaRABzRY9k7TT/PQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ee6410-2308-494c-e791-08def2700dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 21:33:41.4316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nowH2ma91sth1WiGiW9JClcGN3GPfCQWKn+oIy+KV3tN+7hWMm4FlMYgLVC9dgX6ifucmR8HJLumGi0hGvNZQJ+DrVO6eHUQonTkPGAv5AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8482
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

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDE0OjI3IC0wNzAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAwNCwgMjAyNiBhdCAwMzowMjo0NFBNIC0wNjAwLCBTdW1tZXJzLCBTdHVh
cnQgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTA4LTAzIGF0IDIzOjE0IC0wMzAwLCBUYWxlcyBB
LiBNZW5kb27Dp2Egd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gVGhpcyBzZXJpZXMg
aXMgYSBmb2xsb3ctdXAgdG8gdGhlIFRMQiBpbnZhbGlkYXRpb24gYWNrIHN0YWxsIEkNCj4gPiA+
IGhhdmUNCj4gPiA+IGJlZW4gZGVidWdnaW5nIG9uIEFSTCwgdHJhY2tlZCBpbjoNCj4gPiA+IA0K
PiA+ID4gwqAgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93
b3JrX2l0ZW1zLzg2NzgNCj4gPiA+IA0KPiA+ID4gU3VtbWFyeSBvZiB0aGUgaXNzdWU6IHdpdGgg
R3VDIDcwLjUzLjAgb24gQVJMIChyZXByb2R1Y2VkIG9uIDdkNTENCj4gPiA+IGFuZA0KPiA+ID4g
N2RkMSBtYWNoaW5lcyBoZXJlLCBwbHVzIGFuIGluZGVwZW5kZW50IEFyYyBQcm8gMTMwVCByZXBv
cnQgb24NCj4gPiA+IHRoZQ0KPiA+ID4gaXNzdWUgYWJvdmUpLCBUTEIgaW52YWxpZGF0aW9uIGFj
a3MgaW50ZXJtaXR0ZW50bHkgc3RhbGwgZm9yDQo+ID4gPiB+Mi4zcy4NCj4gPiA+IFRoZSBIMkcg
cmVxdWVzdCBpcyBjb25zdW1lZCBmcm9tIHRoZSBDVEIgaW1tZWRpYXRlbHkgYW5kIHRoZSBHMkgN
Cj4gPiA+IENUQg0KPiA+ID4gaXMgZW1wdHkgdGhlIHdob2xlIHRpbWUgLSB0aGUgZmlybXdhcmUg
c2ltcGx5IGRvZXMgbm90IHNlbmQgdGhlDQo+ID4gPiBhY2sNCj4gPiA+IHVudGlsIG11Y2ggbGF0
ZXIuIFRoZSBmZW5jZSB0aW1lb3V0IGZpcmVzIGF0IDIuMjVzIGFuZCB0aGUgYWNrDQo+ID4gPiBs
YW5kcw0KPiA+ID4gdGVucyBvZiBtcyBhZnRlciBpdC4gVXNlcnNwYWNlIGJsb2NrZWQgb24gdGhl
IGludmFsaWRhdGlvbg0KPiA+ID4gKGNvbXBvc2l0b3INCj4gPiA+IGJ1ZmZlciB1bm1hcHMgZXRj
LikgaGl0Y2hlcyBmb3IgdGhlIGZ1bGwgd2luZG93Lg0KPiA+IA0KPiA+IEZpcnN0bHksIHRoYW5r
cyBmb3IgdGhlIHBhdGNoIQ0KPiA+IA0KPiA+IEkgaGF2ZW4ndCBsb29rZWQgaW4gdG8gYWxsIHRo
ZSBkZXRhaWxzIG9mIHRoZSBzaWdodGluZyB5b3Ugd2VyZQ0KPiA+IGRlYnVnZ2luZywgYnV0IHdl
IGhhdmUgaGFkIHNpbWlsYXIgaXNzdWVzIHRoYXQgd2VyZSBmaXhlZCBpbiBhDQo+ID4gbGF0ZXIN
Cj4gPiBHdUMgdmVyc2lvbi4gSSB0aGluayBhcm91bmQgNzAuNjAuMD8gSXQgbWlnaHQgYmUgd29y
dGggdHJ5aW5nIG9uDQo+ID4gc29tZXRoaW5nIGxhdGVyIHRoYW4gdGhhdCB0byBzZWUgaWYgdGhh
dCBoZWxwcy4uLiAoK0RhbmllbGUpDQo+ID4gDQo+IA0KPiBJIHRoaW5rIHRoaXMgd291bGQgcmVx
dWlyZSBhbiBBUiBvbiBvdXIgZW5kIHRvIG1ha2UgYSBuZXcgZmlybXdhcmUNCj4gdmVyc2lvbiBh
dmFpbGFibGUuDQo+IA0KPiBUaGUgdXBzdHJlYW0gcmVwbyBvbmx5IGhhcyA3MC41My4wIGF2YWls
YWJsZSBmb3IgQVJMIFsxXSAoaWlyYywgQVJMDQo+IGFsaWFzZXMgdG8gTVRMIGZvciBmaXJtd2Fy
ZSkuICgrSnVsaWEgdG9vKS4NCj4gDQo+IFByZXN1bWFibHksIHRoZSBHdUMgY2hhbmdlbG9ncyBz
aG91bGQgaW5kaWNhdGUgd2hldGhlciBhbiBpc3N1ZQ0KPiByZWxhdGVkDQo+IHRoaXMgaGFzIGJl
ZW4gZml4ZWQuIElmIHNvLCB3ZSBuZWVkIHRvIHVwZGF0ZSBhbGwgR3VDIHZlcnNpb25zIGFjcm9z
cw0KPiBib3RoIGk5MTUgYW5kIFhlLg0KDQpSaWdodC4uLiBJIGd1ZXNzIEknZCBzdGlsbCBsaWtl
IHRvIHNlZSBpZiB3ZSBjYW4gdGVzdCB0aGlzIGluIEd1QyAob3INCmdldCBjb25maXJtYXRpb24g
d2UgY2FuJ3QgZm9yIHNvbWUgcmVhc29uKSBiZWZvcmUgY29tbWl0dGluZyBzb21ldGhpbmcuDQpN
eSB3b3JyeSBpcyB3ZSB3aWxsIHByZXZlbnQgYnVnIHJlcG9ydHMgbGlrZSB0aGlzIGJ5IHdvcmtp
bmcgYXJvdW5kIGl0DQphbmQgbWlzcyBjcml0aWNhbCBidWdzIHRoYXQgbmVlZCB0byBiZSBmaXhl
ZCBpbiB0aGUgcmlnaHQgY29tcG9uZW50Lg0KDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9naXRsYWIu
Y29tL2tlcm5lbC1maXJtd2FyZS9saW51eC1maXJtd2FyZS8tL2Jsb2IvbWFpbi9pOTE1L210bF9n
dWNfNzAuYmluP3JlZl90eXBlPWhlYWRzDQo+IA0KPiA+ID4gDQo+ID4gPiBQYXRjaCAxIGFkZHMg
eGVfZGV2Y29yZWR1bXBfZ3QoKSBzbyB0aGlzIGtpbmQgb2YgaGFuZyAtIHdoaWNoIGhhcw0KPiA+
ID4gbm8NCj4gPiANCj4gPiBJcyB0aGVyZSBhIHJlYXNvbiB3ZSBkb24ndCBqdXN0IHJlLXVzZSB0
aGUgbWFpbiB4ZV9kZXZjb3JlZHVtcCgpPw0KPiA+IA0KPiANCj4gVGhpcyBpcyBteSBzdWdnZXN0
aW9uOiB0aGUgbWFpbiBkZXZjb3JlZHVtcCBpbmZyYXN0cnVjdHVyZSBpcyBqb2ItDQo+IGJhc2Vk
LA0KPiBzbyBpdCBjYW5ub3QgYmUgdXNlZCBmb3IgaGFuZ3MgdGhhdCBhcmUgbm90IGFzc29jaWF0
ZWQgd2l0aCBhIGpvYi4NCj4gDQo+IEluIG15IG9waW5pb24sIHRoaXMgaXMgYSBnYXAgb24gb3Vy
IGVuZC4gSW50cm9kdWNpbmcgc29tZXRoaW5nIGxpa2UNCj4gYHhlX2RldmNvcmVkdW1wX2d0KClg
LCB3aGljaCBjYW4gYmUgdXNlZCBmb3Igbm9uLWpvYi1iYXNlZCBoYW5ncw0KPiAoZS5nLiwNCj4g
VExCIGludmFsaWRhdGlvbiB0aW1lb3V0cyBsaWtlIHRob3NlIGFkZHJlc3NlZCBpbiB0aGlzIHNl
cmllcywgb3INCj4gbW9yZQ0KPiBnZW5lcmFsbHkgYW55IEd1QyBwcm90b2NvbCBoYW5nKSwgbWFr
ZXMgc2Vuc2UgdG8gbWUuDQoNCk9rIG1ha2VzIHNlbnNlLiBXZSBjYW4gZG8gdGhhdCBoZXJlLiBJ
dCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBtb3JlDQppbmNsdXNpdmUgaW1wbGVtZW50YXRpb24g
dGhhdCBsZXRzIHVzIGNhbGwgdGhpcyBmcm9tIGFueXdoZXJlIHNvIHdlDQphcmVuJ3QgZHVwbGlj
YXRpbmcgdGhpbmdzIGFyb3VuZCBmb3IgZGlmZmVyZW50IHVzZSBjYXNlcy4gQnV0IG5vdCBhDQpi
bG9ja2VyIGhlcmUuDQoNCj4gDQo+IEkgaGF2ZW4ndCBsb29rZWQgYXQgdGhlIHBhdGNoIHlldCwg
YnV0IGF0IGEgaGlnaCBsZXZlbCwgYWRkaW5nDQo+IGB4ZV9kZXZjb3JlZHVtcF9ndCgpYCBzZWVt
cyBsaWtlIGEgcmVhc29uYWJsZSBhcHByb2FjaC4NCj4gDQo+ID4gPiBleGVjIHF1ZXVlIG9yIGpv
YiB0byBibGFtZSAtIGxlYXZlcyBhIGRldmNvcmVkdW1wIHdpdGggdGhlIEd1Qw0KPiA+ID4gbG9n
DQo+ID4gPiBhbmQNCj4gPiA+IENUIHN0YXRlIGJlaGluZCAoTWF0dCBzdWdnZXN0ZWQgY2FwdHVy
aW5nIGRldmNvcmVkdW1wcyB3aGVuIHdlDQo+ID4gPiBkaXNjdXNzZWQgdGhlIGlzc3VlOyBkZXZj
b3JlZHVtcHMgZnJvbSBib3RoIG1hY2hpbmVzIGFyZSBhdHRhY2hlZA0KPiA+ID4gdG8NCj4gPiA+
IHRoZSBpc3N1ZSBhYm92ZSkuDQo+ID4gPiANCj4gPiA+IFBhdGNoIDIgbG9ncyB3aGVuIHRoZSBh
Y2sgZm9yIGEgdGltZWQgb3V0IGludmFsaWRhdGlvbiBmaW5hbGx5DQo+ID4gPiBhcnJpdmVzLiBU
aGlzIGlzIHdoYXQgZXN0YWJsaXNoZWQgdGhhdCB0aGUgYWNrcyBhcmUgbGF0ZSByYXRoZXINCj4g
PiA+IHRoYW4NCj4gPiA+IGxvc3QuDQo+ID4gPiANCj4gPiA+IFBhdGNoIDMgaXMgdGhlIFJGQyBw
YXJ0OiBhIGRlbGF5ZWQgd29yayB0aGF0IHBva2VzIHRoZSBHdUMNCj4gPiA+IChzdGF0dXMNCj4g
PiA+IHJlZ2lzdGVyIHJlYWQsIENUIGZsdXNoLCBkb29yYmVsbCByaW5nKSBldmVyeSAyNTBtcyB3
aGlsZSBhbiBhY2sNCj4gPiA+IGlzDQo+ID4gPiBvdmVyZHVlLiBPbiBteSBtYWNoaW5lcyB0aGlz
IGNvbnZlcnRzIHRoZSBndWFyYW50ZWVkIDIuM3Mgc3RhbGwNCj4gPiA+IGludG8NCj4gPiANCj4g
PiBJJ20gYSBsaXR0bGUgd29ycmllZCB3ZSdyZSBqdXN0IHBhcGVyaW5nIG92ZXIgc29tZXRoaW5n
IGhlcmUgdGhhdA0KPiA+IG5lZWRzDQo+ID4gdG8gYmUgYWRkcmVzc2VkIGluIEd1QywgcGFydGlj
dWxhcmx5IGFyb3VuZCBHVCBnb2luZyB0byBzbGVlcCBvcg0KPiA+IHNvbWV0aGluZyBhcm91bmQg
dGhlIHRpbWUgd2UncmUgZXhwZWN0aW5nIGEgcmVzcG9uc2UsIHNvIHRoZSBwaW5ncw0KPiA+IG9u
DQo+ID4gcmVnaXN0ZXJzIG1pZ2h0IGJlIHByZW1hdHVyZWx5IHdha2luZyB0aGluZ3MgdXAgd2hp
Y2ggaXMgc29tZXRoaW5nDQo+ID4gd2UnZA0KPiA+IHdhbnQgdG8gaGFwcGVuIGluIEd1Qywgbm90
IHRoZSBLTUQuDQo+ID4gDQo+IA0KPiBJbiBnZW5lcmFsLCBJIGFncmVlIHdpdGggdGhpcy4gV2Ug
c2hvdWxkIGF2b2lkIHBhcGVyaW5nIG92ZXIgdGhlDQo+IGlzc3VlDQo+IGFuZCBpbnN0ZWFkIGZp
eCBpdCBwcm9wZXJseSBpbiB0aGUgR3VDLiBUaGF0IHNhaWQsIHRoaXMgd29ya2Fyb3VuZA0KPiBw
cm92aWRlcyBhIHByZXR0eSBzdHJvbmcgZGF0YSBwb2ludCwgc2luY2UgaXQgYXBwZWFycyB0byBn
ZXQgdGhlIFRMQg0KPiBpbnZhbGlkYXRpb24gdW5zdHVjay4NCg0KU28gaWYgd2UgaGl0IHRoaXMg
aXNzdWUgSSBndWVzcyB3ZSdyZSBhbHJlYWR5IGdvaW5nIHRvIGhhdmUgc29tZQ0KcGVyZm9ybWFu
Y2UgZGVncmVkYXRpb24gYW5kIHRoZSB3b3JrYXJvdW5kIG1ha2VzIHRoYXQgYmV0dGVyLiBJIG5l
ZWQgdG8NCmxvb2sgYXQgdGhlIGltcGxlbWVudGF0aW9uLCBidXQgd2UgY291bGQgYmUgcG90ZW50
aWFsbHkgaW50cm9kdWNpbmcNCnBlcmZvcm1hbmNlIHBlbmFsdGllcyBpbiBvdGhlciBhcmVhcyBk
b2luZyB0aGVzZSBwaW5ncy4NCg0KQWdhaW4sIEknZCBsaWtlIHRvIHNlZSBpZiB3ZSBjYW4gZml4
IHRoaXMgaW4gdGhlIHJpZ2h0IHBsYWNlIGJlZm9yZQ0KaW1wbGVtZW50aW5nIGEgd29ya2Fyb3Vu
ZCBmb3IgaXQuIEhvcGVmdWxseSBEYW5pZWxlIG9yIEp1bGlhIGNhbiBnaXZlDQpzb21lIGRpcmVj
dGlvbiB0aGVyZS4NCg0KVGhhbmtzLA0KU3R1YXJ0DQoNCj4gDQo+IE1hdHQNCj4gDQo+ID4gVGhh
bmtzLA0KPiA+IFN0dWFydA0KPiA+IA0KPiA+ID4gYQ0KPiA+ID4gc3ViLTUwMG1zIGhpY2N1cCBm
b3IgdGhlIG1ham9yaXR5IG9mIG9jY3VycmVuY2VzOyBhIG1pbm9yaXR5IG9mDQo+ID4gPiBzZXZl
cmUNCj4gPiA+IGVwaXNvZGVzIGlnbm9yZSA4LTkgY29uc2VjdXRpdmUgZG9vcmJlbGxzLCB3aGlj
aCBwb2ludHMgYXQgdGhlDQo+ID4gPiBHdUMNCj4gPiA+IGZpcm13YXJlIGJlaW5nIGludGVybmFs
bHkgYmxvY2tlZCBmb3IgdGhlIHdob2xlIHdpbmRvdy4gRnVsbCBkYXRhDQo+ID4gPiBvbg0KPiA+
ID4gdGhlIGlzc3VlLiBJIGFtIGhhcHB5IHRvIHJld29yayB0aGUgYXBwcm9hY2ggKGRpZmZlcmVu
dCBkZWxheSwNCj4gPiA+IHR5aW5nIGl0IHRvIHRoZSBHMkggaGFuZGxlciwgZHJvcHBpbmcgdGhl
IHN0YXR1cyByZWFkLCBldGMuKSAtDQo+ID4gPiBtYWlubHkNCj4gPiA+IEkgd291bGQgbGlrZSB0
aGUgZmlybXdhcmUgc2lkZSBpbnZlc3RpZ2F0ZWQsIHNpbmNlIG5vIGhvc3Qtc2lkZQ0KPiA+ID4g
cG9rZQ0KPiA+ID4gY2FuIGZpeCB0aGUgc2V2ZXJlIGNhc2VzLg0KPiA+ID4gDQo+ID4gPiBCYXNl
ZCBvbiBkcm0tdGlwLiBUZXN0ZWQgZm9yIHNldmVyYWwgZGF5cyBvbiBib3RoIEFSTCBtYWNoaW5l
cw0KPiA+ID4gdW5kZXINCj4gPiA+IGRlc2t0b3AgYW5kIFZNLWhlYXZ5IHdvcmtsb2Fkcy4NCj4g
PiA+IA0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gVGFsZXMNCj4gPiA+IA0KPiA+ID4gVGFsZXMgQS4g
TWVuZG9uw6dhICgzKToNCj4gPiA+IMKgIGRybS94ZTogQ2FwdHVyZSBkZXZjb3JlZHVtcCBvbiBU
TEIgaW52YWxpZGF0aW9uIHRpbWVvdXQNCj4gPiA+IMKgIGRybS94ZTogTG9nIHdoZW4gYSB0aW1l
ZCBvdXQgVExCIGludmFsaWRhdGlvbiBhY2sgZmluYWxseQ0KPiA+ID4gYXJyaXZlcw0KPiA+ID4g
wqAgZHJtL3hlOiBLaWNrIEd1QyB3aGlsZSBUTEIgaW52YWxpZGF0aW9uIGFja3MgYXJlIG92ZXJk
dWUNCj4gPiA+IA0KPiA+ID4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAuY8Kg
wqDCoMKgIHzCoCA2OCArKysrKysrKysrKysNCj4gPiA+IMKgZHJpdmVycy9ncHUvZHJtL3hlL3hl
X2RldmNvcmVkdW1wLmjCoMKgwqDCoCB8wqDCoCA2ICsrDQo+ID4gPiDCoGRyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV90bGJfaW52YWwuY8KgwqDCoMKgwqDCoCB8IDEzMQ0KPiA+ID4gKysrKysrKysrKysr
KysrKysrKysrKystDQo+ID4gPiDCoGRyaXZlcnMvZ3B1L2RybS94ZS94ZV90bGJfaW52YWxfdHlw
ZXMuaCB8wqAgNDIgKysrKysrKysNCj4gPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAyNDMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+IA0KDQo=
