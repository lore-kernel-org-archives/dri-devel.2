Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920E606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD3A10E4E1;
	Sat,  7 Nov 2026 14:27:40 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022105.outbound.protection.outlook.com [40.107.75.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8868410EA0B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnWIYgRYuFxPsqyD2uE9EyFMx66eNsr4WgrMbUSRZPKhm1ch+dQ9jNDQw81LGQ+FTOAlZUIzRP1TKiuOmCY3y+m16NUcL1om4LhgWvh3P4tWoAePg7DD/b/k5p18Mv9G15Y1vkr77m05XZDHRvSg2vb4koGPI8Y8Zh9zZk477WKNsNdGK1M1ACVBHcTgV5DRKz5aclXEP4C9MLttNAEfSSDlIQw3VmD7LAXeCo0t+sSyBnf291e37Dfez7jJWGj8OcasF3OCPb/cezpQ2O0jBGnku3CpOD7OXJ0dhoGeFpQ9EYlUn18p8Gm24WQffkBh0pWLANjmc2ip+99+UiJGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtD6SFP4xCGsYoTgBljLhRb78OXTtrmtJAiTEt/+grE=;
 b=mVBaT76SG6wxR6A5PD38QK8hHrfYZrejGg/j75Buk9z07fn0S7FkRaeXKgiBDDJ3fM8UfwqMmmphw/gyiX4aNBna/GikMHChqkUvhziLcAlTzj0Q6Bp/ieS1D/VtwhCjg1M5xPJzOBeth8UnuEgXqeQoyNU6UZO3zS83gfU8bN3TidUoHlTpVfB6wJ6FskkLZyVisXNW4XXuNKe/4C5JTiQTxvoV3xOqyvUmX8tyrJtEXCLvTk+3ZcroyLBf0cW2WAlQxZ4uH/6F8fhwo1ssp+Am3RKcW+KiSC9+sj5SouB0kLmdmachIoxzQkIg6EflHaPwN7l1daLiQ7wRmXd7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from TYZPR06MB7334.apcprd06.prod.outlook.com (2603:1096:405:a4::9)
 by TY0PR06MB6803.apcprd06.prod.outlook.com (2603:1096:405:10::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 13:02:54 +0000
Received: from TYZPR06MB7334.apcprd06.prod.outlook.com
 ([fe80::6400:f7b:8514:1154]) by TYZPR06MB7334.apcprd06.prod.outlook.com
 ([fe80::6400:f7b:8514:1154%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 13:02:54 +0000
From: =?utf-8?B?Q3VueXVhbiBMaXUgKOWImOWtmOWOnyk=?= <cunyuan.liu@cixtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "boris.brezillon@collabora.com"
 <boris.brezillon@collabora.com>, "steven.price@arm.com"
 <steven.price@arm.com>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?utf-8?B?R2FyeSBZYW5nICjmnajmlrDkvJ8p?= <Gary.Yang@cixtech.com>,
 =?utf-8?B?RnVnYW5nIER1YW4gKOauteWvjOWImik=?= <fugang.duan@cixtech.com>
CC: "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, cix-kernel-upstream
 <cix-kernel-upstream@cixtech.com>, =?utf-8?B?Um9iaW4gV2FuZyAo546L5paMKQ==?=
 <robin.wang@cixtech.com>
Subject: RE: [PATCH 2/3] drm/panthor: Add initial support for CIX Sky1
Thread-Topic: [PATCH 2/3] drm/panthor: Add initial support for CIX Sky1
Thread-Index: AQHdbdw+ckJM8aT+pk+oVQoM0CXn17cg8kMAgAAML9A=
Date: Fri, 6 Nov 2026 13:02:54 +0000
Message-ID: <TYZPR06MB733426B11A7B6E0904E86893F8762@TYZPR06MB7334.apcprd06.prod.outlook.com>
References: <20261106104735.1651267-1-cunyuan.liu@cixtech.com>
 <20261106104735.1651267-3-cunyuan.liu@cixtech.com>
 <aa7385b6f373cd6467b772bf0a9941618b35c5ba.camel@pengutronix.de>
In-Reply-To: <aa7385b6f373cd6467b772bf0a9941618b35c5ba.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7334:EE_|TY0PR06MB6803:EE_
x-ms-office365-filtering-correlation-id: adb01729-0a85-49d3-26bc-08df3c06456b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|38070700021|4143699003|56012099006|261009223027099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003;
x-microsoft-antispam-message-info: PXAn+j7elh5ZgYN2++V9e+dOpIw9lseaPyZGIs7jeWuXqeQq0ZZqrZv1Ae1tjVggS5FqkuGvx62UqI6jApqzcBcBocwhpegpi/8SoX4ny09XegmZh3CPy24SXkKMD3juDXyjGQ0GQnFnxH07VuyH1FDct2e6ddBCp/98TNIcHxUrpXoBbmaebuK4mzG7iz3xFtVJUbXfPiPRAy4bpDSgMONw07/Zb9q8vhYGUGsBb7vpDUeq7DAzCbLircEUnHfuesoH3Z8DxYMgvq2cAOCGM9kfkV4jz++OW5PzkjknbdqZDfVyFeZ8EFf5TxUeNeBsdYffvoaxucI6zlsagjifKRK8n09k8scRmw9HmXm1NXBcuRUQeDqX0ZZkmn9JQBVEv7ers29sM+wrHBme1YY5p5v0MoriXY6E47Z+r6YMhQGHStxhUu2y6wJ9LYolX/w0naRNwekgw8b29qFfqTG7+Ey8rN5dmajXQkAbB3eMcCCiKJUnx9hPR9hUeUeXKomeKXIl8CwMCpQvnItgDMt7URynWFcV95qqpTiBzAkQb+xW5hk+aV76n5ae5UAlRLcDLWpXyYdm5IoUC/oPShnZHfCvw/ITftLv59fzyvmNvaY698PTyo29OXw+XY3Z/0nNheG7Wk74k2bqEElTM2iH6I24tCFBG0fyLV+8qGShfW3S6uJxqNJLLxGuW+h20yh4lE2oZ3RTdLagY6IfdLRD7k1eVZclI9u1vc6uCi6sZVw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB7334.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnlIUXlnU2lBMDR0RVgxbE5zYzk4ak43RHVzVHl6RS9DeEhLYUZ1eDlqOEo0?=
 =?utf-8?B?RWlQT2ZTMHFCK0lxT0tsbUVEMmU4ZXQrdFExYjBrWnlRWDBiUTYwc1Q2YXA1?=
 =?utf-8?B?NmJ2Mk1ETWx4emNER25TQkxnVVJWVjV1OFEvMU5SWlFBV3R1MXEvOEdMUUVv?=
 =?utf-8?B?b1VZRTIvZnU2Nk41cDIxbEdqWmt6ZzJIUjVBWkNKRC92V1JoOWZPWFJRZkRZ?=
 =?utf-8?B?L3hFMU9oTG5EdUppc2RwcjBVR2l4SHAwZ0Jqa0h5RFRtWmtSblgrSCtsTzVj?=
 =?utf-8?B?c0tSQTJ5aitCTmNQd0orSnkxc3lJMUE5OGIzQlRFSGRaR0x2blROWWlPMHR4?=
 =?utf-8?B?Zll6NmVMKzZETnZISms5K00wNGtWQ0kwWEVINDRGVlUwWWJzUjBqaGlxd0hB?=
 =?utf-8?B?ZmYxM0VnTFA2UTNZTzJVVGlnZytHMkQ0eFN5VG1ORWdoRHVIbmt0N1BIZC8z?=
 =?utf-8?B?QkZXditUZlVDZWc3aGh0MTg2Q1lDRWNlY0ovRUw3UWZlcWhLVWVTcVh0MVJH?=
 =?utf-8?B?Qi8wdkFCRHMwNnRvNjhLNTk5Rk1LNEdJY1hEMFJTUUQxY2N3SkpwZG5CdjhO?=
 =?utf-8?B?cTN6MjRoU3dDSWg1b3N2VzZnaVlIT2dBRUJCYVFvcFFlbHZybkJobmEvMDBZ?=
 =?utf-8?B?UzA0a0QrZWVjRVFZeWFBa2RQWXVmVHdzMGh6SjRDNUdCWEJRVVFxSFNPcVpZ?=
 =?utf-8?B?RXhUcUd2OHIwL3hFM2k0TU1lWmRHUmEyK1VHbi9SUVFacUpQN3BoU3MreWdW?=
 =?utf-8?B?L0F4a1EyWVVVaDA3dk9SMnF2L2Fobkowbk4vN0ZlbEJLaTZOeTh6NnBBNncx?=
 =?utf-8?B?NnYrT3FScVFCS0lBeWRsR1ovS01xdk5wREpyVlBFMGtTTm5yaXloZUZMTDBq?=
 =?utf-8?B?bHZibS8vWEV3cFk0UzJFTWtOV1c5dGNzcnU3MW9RMlplZFg3T0RkYWtkTjMr?=
 =?utf-8?B?cWJXMWF4Qm1Sa1BRZU5Oam5pSjBLSWd5cjN0cUQ2ditQSlZMWUhwYnRMRXdF?=
 =?utf-8?B?MGMvMU1PbmZpMHNKM2kvUWVraUVuQmhZME4zODd6Tmw3VU9sbDFxbzlxZmRv?=
 =?utf-8?B?WDVFMHp1WmljenFLUVp2dHErWXVTcU91QkNNenovRWtla214MG9lYTBycTd4?=
 =?utf-8?B?ZC80b3o2R2pnS202Qm9NamR0c3JZTjNTMjNWWXVoWjNIOE9EZGpSNE1STlk1?=
 =?utf-8?B?MUFFU1dOMnBRK0JVVGMvakE1akN1K3dXUmt6eDlGdm9pWExVbjRFYml4Q2N1?=
 =?utf-8?B?bjdDSkJBczk2Mm9hYWlYQTMydEhwS2pNSzNjT2JaaXRNejdsSmEvcWFvWXYv?=
 =?utf-8?B?Qk05c3JobTJyR1Z6TnBmc2pBT3JGbHdPN1I0WkQ3NjhDZ1BSN3FxTlhpM081?=
 =?utf-8?B?b2l0cGJOK1BXWGR6Nm9oeDZMUWxpMkhwSW43cUhha1lNUEpYYkZLcW1idzVx?=
 =?utf-8?B?SDI0c3h5dnp0MVF0dFIxcUcySTJ3bWE1YUxrNFRQeWVlR2tCbW9pTHVoT1Js?=
 =?utf-8?B?VlVwdTVXcE5yZFFkclhibkMvbFRXQjRKQU9JL2pJQmhFbnNtYnY0a0M5ajVr?=
 =?utf-8?B?ZVErM2tUdy9lMDBjRDE5ZHg1RnpRSTAzS2dGYkNPTWFFU1JNT2g3WTY2bEE1?=
 =?utf-8?B?QURvYnhFQ2VWakIwRHYzN1F3WitUemd2cFUzdWFucCsyajBxYkxFdkg1ZU54?=
 =?utf-8?B?SmZRU1RkYXVJV2g4OXpaNm1hOVl2TVlDSHhwaW9JVWxOMmt4dllIdDQ3ekVV?=
 =?utf-8?B?ZzVuK2hvRzMyVlZIMVZSeHZBeDRnbnduODdENnRpMVdubjc0VzVwaHY3Tm8v?=
 =?utf-8?B?TTYraXFkcDAzT2JVZUVLcW93OCtDNWhzVUNhTEplSm9BMU01R3VFRFVIaHNO?=
 =?utf-8?B?K1JiY3NQa3UyOHhDb2lIRmRkaUlwM1RHNThMRllVSEg0SnhacVFhR0xHNmZr?=
 =?utf-8?B?aGh6Sm9hZDFHUWc1dTJPc2QvdzJES1VxbURoaUVML0RTTm5pbW43TWRyTUdF?=
 =?utf-8?B?OW1sZWozWHJSZkFoTm5QZ0lleWZOVmFqVm10VGpDOS9SQ1VtUElYS0JjQlVM?=
 =?utf-8?B?MmJCNnJwWTNyd0hJc0ZLNnIzNnNLcDVreUpEYkUyVUMwV3JlSTBFZEh0NWNR?=
 =?utf-8?B?M3k1aG5UQVp3NWI2cmsxTEp2elU0Y1ZoUmlwbzdYMldXb1kvNkhqaEtZZXJF?=
 =?utf-8?B?YXlYMU0xeFhuVTA2cFV1cUcya2RHR21QWW03dHdiYnJiVE5uM29KTnpZMkpE?=
 =?utf-8?B?dnR0ZlcyTncwU3pEbjNFelJnSmZ6VmRISXhEdGNUS0oyU2JFRTlqQVR1TVhy?=
 =?utf-8?B?V1JWWWVZRVRFdGtmMmRLRExOTFFwdFhxTlNuN0VNTzRSZmxVbnZ5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7334.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb01729-0a85-49d3-26bc-08df3c06456b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 13:02:54.1867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMmwIsxJOBDgIhEg62nI8CedUMjO1cqQt2oqw0q6gSIWievohVTb9m1SmwS/0W8tdLJGAFBpOjm0nE+AP++9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6803
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUGhpbGlwcCwNCg0KT24gRnJpLCBOb3YgMDYsIDIwMjYsIFBoaWxpcHAgWmFiZWwgd3JvdGU6
DQo+IFlvdSBjYW4ganVzdCB1c2UgZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNs
dXNpdmUoKQ0KPiB1bmNvbmRpdGlvbmFsbHkuIERldmljZSB0cmVlIHZhbGlkYXRpb24gbWFrZXMg
c3VyZSB0aGUgcmVxdWlyZWQgcmVzZXQNCj4gd2lsbCBiZSBzcGVjaWZpZWQuDQoNClRoYW5rcyBm
b3IgdGhlIHJldmlldy4gSSBoYXZlIHN3aXRjaGVkIHRvDQpkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0
X29wdGlvbmFsX2V4Y2x1c2l2ZSgpIHVuY29uZGl0aW9uYWxseS4NCg0KPiByZXNldF9jb250cm9s
X3Jlc2V0KCkgYWxyZWFkeSBjaGVja3MgdGhhdCBwdGRldi0+cmVzZXRfY29udHJvbCAhPSBOVUxM
LA0KPiBzbyB0aGUgZmlyc3QgY2hlY2sgaXMgc3VwZXJmbHVvdXMuDQoNCkkgaGF2ZSByZW1vdmVk
IHRoZSBOVUxMIGNoZWNrIGFuZCBrZXB0IHRoZQ0KIXBhbnRob3JfZGV2aWNlX2lzX2luaXRpYWxp
emVkKCkgY29uZGl0aW9uLg0KDQo+ICsgICAgICAgYm9vbCBuZWVkc19leHRlcm5hbF9yZXNldDsN
Cj4NCj4gTm90IG5lZWRlZC4NCg0KSSBoYXZlIHJlbW92ZWQgdGhpcyBmaWVsZCBmcm9tIHRoZSBT
a3kxIFNvQyBkYXRhLg0KDQpJIGhhdmUgdGVzdGVkIHRoZXNlIGNoYW5nZXMgbG9jYWxseSBhbmQg
dGhleSB3b3JrLiBJIHBsYW4gdG8gaW5jbHVkZQ0KdGhlc2UgY2hhbmdlcyBpbiB2MiBhZnRlciB3
YWl0aW5nIGZvciBhbnkgb3RoZXIgcmV2aWV3IGNvbW1lbnRzLg0KDQpCZXN0IHJlZ2FyZHMsDQpD
dW55dWFuDQoNCg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YyF5ZCrQ0lY5YWs5Y+455qE5L+d5a+G
5L+h5oGv77yM5Y+X5rOV5b6L5L+d5oqk77yM5LuF5L6b5pys6YKu5Lu25oyH5a6a55qE5pS25Lu2
5Lq65p+l6ZiF44CC5Lil56aB5Lu75L2V5pyq57uP5o6I5p2D55qE5L2/55So44CB5Lyg5pKt44CB
5YiG5Y+R5oiW5aSN5Yi25pys6YKu5Lu25Y+K5YW25Lu75L2V5YaF5a6544CC5q2k6ZmQ5Yi26YCC
55So5LqO5oyH5a6a5pS25Lu25Lq65Lul5aSW55qE5omA5pyJ5Lq65ZGY77yM5YyF5ous5pyq57uP
5piO56Gu5o6I5p2D5aSE55CG5q2k57G75L+h5oGv55qEQ0lY5YWs5Y+45ZGY5bel5oiW5Luj55CG
5Lq644CC6Iul5oKo6K+v5pS25pys6YKu5Lu277yM6K+356uL5Y2z6YCa55+l5Y+R5Lu25Lq677yM
5bm25rC45LmF5Yig6Zmk6YKu5Lu25Y+K5omA5pyJ6ZmE5Lu244CC5LqS6IGU572R5Lyg6L6T5peg
5rOV5L+d6K+B5Y+K5pe25oCn44CB5a6J5YWo5oCn44CB5a6M5pW05oCn5ZKM5peg55eF5q+S5oCn
77yMQ0lY5YWs5Y+45a+55Lu75L2V5Lyg6L6T6ZSZ6K+v5oiW6YGX5ryP5qaC5LiN5om/5ouF6LSj
5Lu744CCDQo=
