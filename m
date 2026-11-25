Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A804606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=l1r5Ynuy;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZRZneJk/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6727E10E6E0;
	Wed, 25 Nov 2026 12:22:04 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1339C10E067
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:21:40 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AP9oJBv619085;
 Wed, 25 Nov 2026 06:16:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+OBipBtb4NO3ICwn29MZSSWKRTctNd+Gxg1CaaFPj
 QY=; b=l1r5Ynuy0Mzr2jD3sRYqCZmHyaowSqy8PJcUg/tBLvXiFZ4n515VixrsO
 iKZ2g3yOGVuwHY5COjEt8ES5LN0a+2TdBn0yf7eGIiECi6+f83uNs8IeUWieDhy5
 JQE33sSxXMyxyf4bwOCBP9g0WQmQjIJi1gO4SM2ABc7x/GZBh+IrOGj9+kW2sc70
 vFzAeHcGNij2sbJ4xOwNyZWITd6pCREyd1GxIX2+PhRlgWej1bpfxLiAi4kPxHKA
 knf0LPU4qdNpeWjruUVRWt05HrcWuaLr7JhnPyH2aB3B7+LDJSzEMknxH80TiKW8
 h2gl1ZBo2YnA7bVpW8wodrlwXr/pw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j5q4cthwn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 06:16:20 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B48KjzgMEEyaMnOtrhmnDpdIvIi/GfoTm2EjnoJqWr2qP9+vUiiqlezPtRlfKBtu+X0jPmhl1j0Ouq4NOXuaMacExGvXPi0WcbjooBN1HfUh8jXCT42jBWckxVVooDucrqAG+9/h16X6B8ifivgjAPDzWQ9ilJgrgDL+fhjJYXFdQ2Fsfe+RmJU7RdP7kkbjSRhmv5r58enYC/8YWyZO5q7Jod+Q5w1XyE1XEwf2JPpUuf5wjX4T3uQlSkDjreRYCOMC4nhvmq4QaFAZreL8O/dXZ0Il6qLSr7V3CIA3itXgPS7xsI3oI8VYESSK+P7a43lf4L4OSRCCp5NycWS9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OBipBtb4NO3ICwn29MZSSWKRTctNd+Gxg1CaaFPjQY=;
 b=xLeB5DiIzeI0CweRrHEJzlFfHsyig0vtYHEgvGOvFbOgT9sfpiEUsOyorvCnpDpZsqVpLxoyLqNAIYL7tKgUJhqaTA2catMlNiGH9opRohgZ7aIehwvkPg0RfRzmUAYfDU2gWKJ4M2lC2nTYh2j5HBfj7QxFLu5+FFlULc1QwQOQZmlXvtxaekcEIhXrwPd3vNNMfJ5rPBaVVyiacXzvTv7D2HMAPw2M0k9XxxAdTgbIhcus/Sc9avcbcUUrIp20SzkB5rk1MAt6x5duHMYKVxc+Y2R1jut7I51ONFy/mM8ZKzg3Q3i2k9zwwin3WPsHlJEazpC+tH/cOrZxBhHYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OBipBtb4NO3ICwn29MZSSWKRTctNd+Gxg1CaaFPjQY=;
 b=ZRZneJk/CrczRg1XkuG8ZhNBVrvGTQpaM0JN/3txJK1fZoSIaF3WoppXgW84Whq6anJhMB+l7bA0whbh+s+bIBRYl3WcCa3+ETbuq8mKW8k47ksWVoERJDvi+4gTjhH9hKNGCM1+r3+H4cwJgzAyfKEwnOzcfnOGMWT7vTjaUJ8=
Received: from BN8PR10MB3507.namprd10.prod.outlook.com (2603:10b6:408:b1::19)
 by CH3PR10MB7863.namprd10.prod.outlook.com (2603:10b6:610:1bd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 12:16:14 +0000
Received: from BN8PR10MB3507.namprd10.prod.outlook.com
 ([fe80::314:3c4e:a767:9667]) by BN8PR10MB3507.namprd10.prod.outlook.com
 ([fe80::314:3c4e:a767:9667%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:16:14 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drm/bridge: cdns-dsi: Add clk debug print
Thread-Topic: [PATCH v2 1/3] drm/bridge: cdns-dsi: Add clk debug print
Thread-Index: AQHdPrn+UK/nsSFRTkqNATJjPkrForc/MBEA
Date: Wed, 25 Nov 2026 12:16:14 +0000
Message-ID: <8dabe5e2-bbfb-48ea-92f9-13629c0af56b@ti.com>
References: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
 <20260907-cdns-dsi-fixes-v2-1-96d9b116e9bc@ideasonboard.com>
In-Reply-To: <20260907-cdns-dsi-fixes-v2-1-96d9b116e9bc@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3507:EE_|CH3PR10MB7863:EE_
x-ms-office365-filtering-correlation-id: 8841b013-99e5-40cf-c126-08df4aede6a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|921020|38070700021|10067099003|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info: 61GCFu3/pmattG+OelUD8C92pmqvZ5skSxtAWkiDTVrySea4JQF35Uxy3tsLmX7ljPi7kQVuXi6rZeHAfYFFDudJo/D7aBtMQYCDzOMz/MeIQwIXo5BAR1GNW1slB6YIRH5JskRNfrHEt4TwouHSYNXCTGqlT8cYLE+zVKMrrL24BOSkLrxM8UXxv81OE/8jE9jXEolR3l6QWHZGqYXpLFCxbD5shKsCU5qyoWSZp0hZ1ITj9sqwI92XwrYeYAI54AFUHj6TT7hvb5ug6Y0EDx1YNQH/rLHvq8ah4ekfkEW3YejwGs0rLdT6dAiskswNy6Tmpk75x9aGzC9Nzpxa6iUYJcl4umCxSwJsvpSKfw51IDDRgit5WSwIxHrPNCcxTOHhUaoH1u2k6cEQrA12wFbyVDqbaH5munsuaJWr0lKvoRJIxxDtaNAGwFUOXYlZNGo+fm0TBrHvmsnOCIwSV7X7lfmW0tQRDuHNJtzZYBhjqVilOGtGVWos55fj72AhtVqAlONnx8JZHzh+tdoMwsqaJVR05PKZqd+bHh+lWkRGC9rLKY9h7O/+SbBxry1h3Nm2sOH9Uv2di3oGGxHgnwuCc7/ECFz0uUnoBIN4rX53OG7IatuWU/xNggLozlyMRMIwOGMf74k/d4G/Lkup3lBOfFDG0OIDlCp/ZmEmad0Dav2d2AsMrbzPoRpijg5YPQY36yOzr9xSn0w6l+C1UZecUGKioEjxLZO3NuDs1HHXWDKdN8pJ9yb6QQxt+3Bm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3507.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(921020)(38070700021)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2t0TU9PbFdaWlV0UkJtSlBUTWdyZFdoWUd1MzY3NFh6azFNUkpZdE1Ja0hW?=
 =?utf-8?B?STExSFdzb2tNWnBuY0tIbURSZWk4SnFpbStmOGs4N3htYnNiWG9JZUp4UHJy?=
 =?utf-8?B?eE1QSlN3djFNOUw5NE5CL1Q3SVFHbmxYdzFwdUtPZjJVbHZ6S2J4dVdNYTBS?=
 =?utf-8?B?dWltejQzQ1hqOFZ5V0dVMXFmSjI0MTVCclhiSzRDUkV1dGpJdHhjK1M4bGdG?=
 =?utf-8?B?NERTYzZ4YjdmNzdGSFVIekk2S1BMNFZOK2wrbTRydkh0K0FkWk5nNFVXcmZi?=
 =?utf-8?B?NWFQaXlERHp2S2ZmTmlSS0NFWUp5czNVNnY1K1JwQjBmK2R4Zk40Vmk2U0Zv?=
 =?utf-8?B?RHhtbk1sNzFUWHRpcXZwT2cwenJtNGF4S1puMEIwWVRRVkpPcHhsbzc3bWMz?=
 =?utf-8?B?Yk81K3o2c2NpeDZjYVhsbXVNdkV1Qm1Ua0ttdUNyZExQUHNOeGFpMEdWWXU0?=
 =?utf-8?B?UEhBWVFHYVE5RHgyOVJ0ekt2by9aN0pqMnJWaEdyaHZMQ0dnTGhhalljRUI1?=
 =?utf-8?B?dzRiVUVFZ1NpSVBRdDVuai8rOTFiUmpnYUFEMFQzVHJYQ3MzVTNPTlNFUDZm?=
 =?utf-8?B?enlSQ2I5cDFEamtvUXdiRWlkb1lmcWJzYm8rbTFad3ZraS96MjZOaitVNXMx?=
 =?utf-8?B?Qzg3Q29RVERKeGxJRk1rUGQ1V0w2ZlVsTmdwT2h2STliMnJpa3FkZmpHY0xC?=
 =?utf-8?B?RmxnV0pWclZuREk4YitiemF0ejdZa1Y4MzNrZmJkbWd4UWRTbkhSL2cvM2pk?=
 =?utf-8?B?VnNoV2xPOGZVZlR5QUxwUmNReVh1QS96MWN3ejRuM0oweUMxMUFzN1NGTFEy?=
 =?utf-8?B?WC9hUE43TkZOU20wcGg0aTVwWHpuT0d5MTlQOUpvNFUwdWZKTE1TVU9tTVhp?=
 =?utf-8?B?bVQ4VzJWM0UrMmZFVEZNa2t0WkZCZUVNc3NvU29xZ2ZDOHJ4aGNLS3FmTlA5?=
 =?utf-8?B?anFtVHFKaUF6cldoZWMydHFlNi83OGN2ZGRkYmVmOVVMbWZEWU1ON1JwRFRR?=
 =?utf-8?B?VnRKUDlhcHA3VTVqQlZ4L1c0SGp6dENNZUxJNU1KcmJ3RUJ4OUZvRVVIOWxX?=
 =?utf-8?B?M3J0YUtkc1JIMXh6VkllaURoUlNWWTR3NU1NR2JUdHozWDg0Q1libVk4Z1hy?=
 =?utf-8?B?cmx1bUUxRUl1Sm1ZRHZBSFZYb2JhSm9JNE9XNG1HM3padEZNdzNGT2lmOHlt?=
 =?utf-8?B?YzBlMFdoTXp1Ny9PNU5aREZpL09SNFFPVExVb2M5Zk9sTklLaVFWODdpK0dz?=
 =?utf-8?B?N3hTUmMvaUdWL1c0eHdUeXlLWlFVWDJWcmZZaS9WbVhvZFdEbEYxUTlQblpK?=
 =?utf-8?B?SkJmZGxjbXFGcDRSR0Uxa3VwSXBhRnNaNWUyUXZpVzM3TDEyMHYyVjBVeUEr?=
 =?utf-8?B?Qi8ydHEvTG5tZXR6UFNjdkhhUFVhcy9QdTl4SFFRVVZmRWptZ3hVM1YvOTZj?=
 =?utf-8?B?WXgwbmlRcGs0NlFrQ054UUtJK1pRU0pneUhRWUliTGtXZ0JRbkYzRjVsdWp4?=
 =?utf-8?B?MTBVcWgwM2k2ODJ0bWVXTm53ZjNRbXZjWGRMNTUySjBYV0g1Yy9OY0JPZDdC?=
 =?utf-8?B?dGtzOVBrMTdrUlhtZWVSV0gwdjBab3p6N3I1enkwNytEQUZiMDltWFdCU2FS?=
 =?utf-8?B?TGdsckN1a0VNdUNjNFRPbkhBTFhwSmFkYS92YmQxQWx5K2dXdG83NFQwZVVL?=
 =?utf-8?B?dGRId2hWbisrd1dqSEhHVUR2SmhIZVBiaXFQL3RyYVZuQzd3dENreU83Q1BD?=
 =?utf-8?B?d3RmRnUxdFZrMW54eHRFRGdseTZtVDUwS3pMbnExNHNHdkl3eElsUUFJRHpw?=
 =?utf-8?B?R0NpeGh1eVlXekR2dWUzWG1oZ3hWSXBJQzdiL1ZHcW5BcnM4UDhTMXVwU1hy?=
 =?utf-8?B?MnRXWlpxeE5vUk9BcG82SUw5dExvYzJEMy9SYzhHc1kzVkV4MmFoMVE2dlly?=
 =?utf-8?B?SEtRaS96TnN4RzhLdVk1NnF4ckZyN2d3TlpiYWVMQ1E5UTY5cTNMYks1cTFS?=
 =?utf-8?B?ZlB3V2oxK2UzdEZkVm5QY1E4R0U5Uys2VlNHd05ScmxVcEVDSGZSaC9LNmtB?=
 =?utf-8?B?QmZXYXNHMEpnMTlnRlVvdHp5dzBqRDhZbkRmV0lNa1JPcW9HN3o1aVZnNEN5?=
 =?utf-8?B?YlF2VHVHZyt4OTBrQVIyWXFRWXkxeGRBeENiVytSWUE4LzRGOHE2MGV1bHVW?=
 =?utf-8?B?VWs4V08zYlRqNjYwWTVxT2ZpNzJ6VTNlYXpFa0liNkhqeHJQOWRjQk1VZzdj?=
 =?utf-8?B?NzZGYjVrRnZnN3FrZFQzYW9rQld6MHNidjZYVVc0aDFHVTcxY0MrSmFlK2pa?=
 =?utf-8?Q?RuoKlUM3sSWDw901Qe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C5735F4FAD35B45A7FAD44822BAE51C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CeqMn4D18OtWln1oY+v8sNwBIfoNG59MhXl8ndbtneZvxl2YUSJoM6k5bmxJVjXz+ixQJoR9vhEQ3CuufrkUGjs1MQVNiJ0R4bhudqX+PNKNRAvTeOTYdiAo6icJZPRIe6rx/sj+qUv0jpSsIBFvSsVTld92JCVU2GRFh/5tXHUaZNehXHH3EhofGsB6ndcXSF9V3Iez9LOsRh0zZHr9y1974GFzF0taiOb75vgbr/vU5KwCWePEiU72krZODtiK3VfBylOBFKqm0u9Qk05pUp2Wc3xCvLmefyDuZUqbpQo1vhHojCavLIBC9JPZJzbY/Vj8SWPEf1Bb7BvZb1su5w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3507.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8841b013-99e5-40cf-c126-08df4aede6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 12:16:14.6978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUoSE/2g8amh2VHfHILLMNGmR8wIuVfNufMgBiL19Ad7LUL4zpWDGzNv8ztDN8oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7863
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0OCBTYWx0ZWRfX0HbCDNFm5xvn
 FtiT2PNZnchJXz/brDnHgHKTztsKh3XwM5nfUv70+htu9xL9j9D2BbIy5jNBfLCceYeKy9O1n+S
 wgfEGdJmPmsqNSES8tpocemmGymbEyo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0OCBTYWx0ZWRfXzJjgc0rBORu8
 LUx6AymXy54sbKbfzPvwGT5k/t2u6IZWpoSYUps7BLDPYMFcEWsWUl8Mi/WePmtcr57KhreLmU0
 zBEcekApAZCr+tzvVtSX+c3LD+tCFG0g3fGjbHnyLaNkyS3RUbwgR3+/XF29XA+/R9buFUo6EBV
 sqe7t0E+aI6eyCrjVj+2iAhih1pUaAd19HFgjVRmfCSahFhU2alxIbFc1QabEWcRhKEcIzxMfM/
 DpfEL19FZcKw44OuDYElYIhyuOT2UY/TWqPR9OdPPGi17fpXuKBE/L71pxh2qA1tuI6Re0akNi8
 ERkXtptmWADxAtIlJmKR59uuNxvL3gQ/Af6o7L2ymw75R79RzJ2QrRzf0EsbNmdsyViHr0qLvU9
 P1porNb9FuZdZwzNxn5oUT0uZknIefKwGprZmZvbO5+9W0i6lo5AmitvQ7GpVQ5rJyc7G7RpdxY
 QIjm7djiwP/Cg+jMyjQ==
X-Proofpoint-ORIG-GUID: VzTVDMFrwpPfhkl2mc9WgD-BegYcTVqN
X-Authority-Analysis: v=2.4 cv=ZvF4uN7G c=1 sm=1 tr=0 ts=6b06d194 cx=c_pps
 a=JgVaYur/QNM9XUS2zzqRTA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=P1BnusSwAAAA:8
 a=sozttTNsAAAA:8 a=LL4qAnRm_bvP3-ZouUgA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: VzTVDMFrwpPfhkl2mc9WgD-BegYcTVqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250048
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMDcvMDkvMjYgMTY6NDMsIFRvbWkgVmFsa2VpbmVuIHdyb3RlOg0KPiBJIGtlZXAgYWRkaW5n
IHRoaXMgZGVidWcgcHJpbnQgd2hpbGUgZGVidWdnaW5nIHBhbmVsIHByb2JsZW1zLiBTbyBsZXQn
cw0KPiBhZGQgaXQgcHJvcGVybHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb21pIFZhbGtlaW5l
biA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERldmFy
c2ggVGhha2thciA8ZGV2YXJzaHRAdGkuY29tPg0KDQpSZWdhcmRzDQpEZXZhcnNoDQoNCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2NhZGVuY2UvY2Rucy1kc2ktY29yZS5jIHwgMyAr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2NhZGVuY2UvY2Rucy1kc2ktY29yZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9jYWRlbmNlL2NkbnMtZHNpLWNvcmUuYw0KPiBpbmRleCBjM2U0NjZk
ZWQ4NGEuLjRiN2EzYmY1ODI1NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRn
ZS9jYWRlbmNlL2NkbnMtZHNpLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L2NhZGVuY2UvY2Rucy1kc2ktY29yZS5jDQo+IEBAIC03MTgsNiArNzE4LDkgQEAgc3RhdGljIHZv
aWQgY2Ruc19kc2lfYnJpZGdlX2F0b21pY19wcmVfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpi
cmlkZ2UsDQo+ICAJdTMyIHRtcCwgcmVnX3dha2V1cCwgZGl2LCBzdGF0dXM7DQo+ICAJaW50IG5s
YW5lczsNCj4gIA0KPiArCWRldl9kYmcoZHNpLT5iYXNlLmRldiwgImJpdGNsayAlbHUsIGJ5dGVj
bGsgJWx1XG4iLA0KPiArCQlwaHlfY2ZnLT5oc19jbGtfcmF0ZSwgcGh5X2NmZy0+aHNfY2xrX3Jh
dGUgLyA4KTsNCj4gKw0KPiAgCS8qDQo+ICAJICogVGhlIGNkbnMtZHNpIGNvbnRyb2xsZXIgbmVl
ZHMgdG8gYmUgZW5hYmxlZCBiZWZvcmUgaXQncyBEUEkgc291cmNlDQo+ICAJICogaGFzIGJlZ3Vu
IHN0cmVhbWluZy4gSWYgdGhpcyBpcyBub3QgZm9sbG93ZWQsIHRoZXJlIGlzIGEgYnJpZWYgd2lu
ZG93DQo+IA0KDQo=
