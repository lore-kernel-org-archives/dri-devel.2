Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD925606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=q1ecQxNT;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=RukwtCaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1439510E4AB;
	Thu, 12 Nov 2026 03:02:06 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7302510E3E4
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:01:53 +0000 (UTC)
X-UUID: 6573e142de4511f18dc8c9802ae25ab1-20261112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=2rk0SG29/MN2a9JOaocRioD/HQn9D2aJBJ6XBr1sJDg=; 
 b=q1ecQxNTUTnFrXLFrtoXZpBodIhp3seLlPL97B37x6HqeEOUImQGz/LfIKHreTVUIrMtg5tIh2Ifia2JbRiXKirQxqbsTajL9GXUeyAXpD9+9NVo3u9R2h4Kd+z9JNHFJAEW78h6U73CYXlPqkmTKgPF47uTMXcDM4Y+hzXcUpg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:1fcc49cb-f428-4a9f-b6e7-0ee67bf64fd7, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:09ebbc30-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6573e142de4511f18dc8c9802ae25ab1-20261112
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2078125152; Thu, 12 Nov 2026 11:01:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Nov 2026 11:01:44 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Nov 2026 11:01:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsPtD5nhkjZAd7dF17XA9VNhF93CZgx1uTUWCkc0Gwef9w/ZNSMyzuxxfkPjk5PsUxyvyr9snP38/5zLy08XDcbglUC203U0AKEJO7Yh7/KpEZoCg7fu8oWA2sbw1+lMCi3+H+PRa+lO2K7ks8b0ppYSE/eL7GXkT1fQkw5Uo2XXLcxARtJ8DcC/yzjQwoPb+s+l1QOvWexpsmvpbZHLx/xKoBeQJHweCboMu0yo6201zOTt7QuFOA+bgn5L1cpS9HL+uJcOhvr/8WDegESBjUdd+qXLoDyATKfZcX0HMNu+f6EvM3kYB0WFkhjP0Iuax8ATsj1+DAjkWs9boZLqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rk0SG29/MN2a9JOaocRioD/HQn9D2aJBJ6XBr1sJDg=;
 b=MBZLCz9rTYRyMbL8VqPzpIAcuwK4RySZ9t3SeXi4G15M2HCy+m2zL3W46C4hDXRSd9u5iL0CwscHZgx6RZDWyxe+JqcS2at+dY+WbS0YSKwObF0XmAIPJ0eimv07D4NShxDhln3mp6+XXSsEIYP0PqbJ59vR1AvQgsPbI4qzTY/urQPskazVAS1HhVaYlHzTBEsUYyc0urtWYbbhI3++u20hHXShSShscv6F3ecLGpWv+N+kpgCLuUGkNE8GxO+E6JUmSCLvud6EDJlXEvxOG/WTMa3/KxfDcEmyt1a8U8N3qynuzIHtYl/i3h7m6IwKyoC2rlNRszT7FUHKbXBaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rk0SG29/MN2a9JOaocRioD/HQn9D2aJBJ6XBr1sJDg=;
 b=RukwtCaVdN6Gn4cJAbeaM2hn2k3VF2U8n0XQUXbB5CHCx85kRptlPlKfav9AZDUBYcwOczBzf/ju2JFiJ6n89RXblmK/XxA8UjD0/Kg+/dyU1qdo5yrx65uBvKAyPIFWRmakSiZbmfXiCRuRD8OhZBgVNncxvz5ihSyw1KvTaWM=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SI6PR03MB8654.apcprd03.prod.outlook.com (2603:1096:4:24c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 03:01:40 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 03:01:40 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "yigejiang86@gmail.com"
 <yigejiang86@gmail.com>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Keep the mutex node reference across
 deferred binds
Thread-Topic: [PATCH] drm/mediatek: Keep the mutex node reference across
 deferred binds
Thread-Index: AQHdbdAmYdaK1pYVukqoVQx5WCY017cpyKYA
Date: Thu, 12 Nov 2026 03:01:40 +0000
Message-ID: <df981fa792a0da6a1958518cd342fac28706b259.camel@mediatek.com>
References: <confirmed-20261105-38-2e09963f1b23@gmail.com>
In-Reply-To: <confirmed-20261105-38-2e09963f1b23@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SI6PR03MB8654:EE_
x-ms-office365-filtering-correlation-id: 7b3a966a-51cd-4d7a-c482-08df40694668
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|10067099003|38070700021|56012099006|11063799006|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261022105027099003;
x-microsoft-antispam-message-info: MWkORYxwjLQso8B/1mkwy3knmDFYS/5dtx7gNHi6IJ+XQXYm7hSXSUYe3hbu0vhOonZHyWFyQhdx/6ndJ/mZe7BCfaePuzXGTy8NRI5LPnk1KNRKVyvZISyqz/bZRKZdOxjMfmUkPRVI55BeAQk0xNNZsSmREPCdLnQGHLuZJpQmKHGh4wRV4ND68v5WC9hvtgJNTsqGKxiResbC251CHX7itl+mCUfXIni2BgjVQxPOhlBcFruBq5xC5H9lfjpBWgR0mhJkdqFhQbSmFcZXct8n1I9+UD+YCS5MEAnH++OGNb/xODbI9Kwwpibdjo+d8i/Oob1crkeu/j/mEr8yStPRdHpv5zAptdIXeXhviKdZafoW4Fjii8XrHsB9Xedbe8wzSyJJbQ4RCgdPm8KPU7iguHHDiKoIbtGbAhZCQaNl1vqJd6tHcYzn/ikLBN1f5leskwzmjO4VXoFy2vEvUxFFtXb4VRJrDN9h28yfhbJjwUJsf/UJwJLxGKX3YOr6zjtMAtxDzaxDcHL90E8MaLls8+BkCHabAdwoDENiJzNlJyXipa5BzjJMKdqRYmfYdu6EG7Arw6WSL1u2a08N8SWsMuIswxewPjeIaezyCUe419WyLxWvV7HSUyyOoHxNNlaE7236+Pil2r1icygCLoMaSz0rrFWLroPiNGJctL2lM9mTw8mKiDibV5tMaV71kwTEMpxhHJQwISb5DcrVww/LdVdfa3cSbZ14iR+Xe00=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE5Cc25jWC9hV1pSaVJOOHNnajloUVZzQ0ZPYjdHVEIxTExlejFXVmgvNTd2?=
 =?utf-8?B?KzI1T04vT1JYNFhDTjNlbDBDWU1uN2V6QlJnalA2UzErVG9XNnpibmI3aTNx?=
 =?utf-8?B?YS9SVEx6Wjc3Rll6azArWG9NT295L3ZyRnI5QjBWQ3NkbVNHQVVkOW56U3pr?=
 =?utf-8?B?V2UwOEIxeUtNNmN1TFJZanlJRkFHKzJpWFA3N0pWdkd0MFFRdUl6MnhlTkpa?=
 =?utf-8?B?ZkMxeUhpeDF0bEk5RWJWcEFrVVpETWZrZVVLQlZWM1VYRFh5T1lDRDN2SmlB?=
 =?utf-8?B?c3lDeGVzbUNtMjE2dDFkaUd1aVBJR3RaelZYZzBhK01IN0ZhdGgwdHZsemk3?=
 =?utf-8?B?bHJjZ0k4cFdnSU5ieGpuay9wWS9kVHBUM2xIdGNZbm11QzBvUGVFR0tneW5V?=
 =?utf-8?B?WFNWYlFBWTBkY0RwTkUwUWh6M09vLzRvbEYxL1pGTmZUdW1LWVk0THJGTEl4?=
 =?utf-8?B?dmo3azQ5Wm5JZUJNSWZjbytmVVhwSUhydlhhZE9KRFIzb0F5RzdkcW5mYTJQ?=
 =?utf-8?B?VUJFYXBPRWNLaSs3MmFOVEJ2Q1VsVTE4eDJuZzJCU0MwWDR6aWZLZCtMSUpN?=
 =?utf-8?B?NHI1RWdKWi9QT0N1cjdLcjNsbmpUMTRPRW5BZ3BrRytSUTAwMTkwL21tTGNJ?=
 =?utf-8?B?SGJ6SFIwTm9mRFFCZCtQMDQvSHFuSkRNdjNERkNqV3c5d1Vzei9FaTE4QTV4?=
 =?utf-8?B?Q09SWi8wVFFMLzdNSDZhaEtFN20zbnp6bFZhazRGVnRxRkpjSlUzeGZDKzhr?=
 =?utf-8?B?NGxzUVdqLzN6aTJIMVZCMmFHZ3FtQ1pBMktYTkpiVHEveGlqSkw3Q0NWTVYw?=
 =?utf-8?B?UHFYdUNaTzZmSVM0SStySTZyVTJPUkNrMzNIS1BsRDlHOFYzblo5alRhenpp?=
 =?utf-8?B?czl0bFU3VW9KNTBKOXZramRrQ1ZtR0l1NEdJdXNYTURnKzR5NmE1QWNkTGs1?=
 =?utf-8?B?ZVJSYTJUc3hXK3N4MW54My9MNlhxUkVLN0FXc3N2OTBQOWtHL2lBaEtPdVV4?=
 =?utf-8?B?QlByZ3NVc29XWVFxSk9nUWFlb2tIY0ZKa0lidWVjQVdwSVRtc09SQVZmUHF0?=
 =?utf-8?B?REJiWW5YV3padll4akNya0FLeU00MVV1NGpLZ1RhSkhaZDlxMkxHTGxoQUxL?=
 =?utf-8?B?c2U0VzVPak9kSUNjN1JYMHd0VWNMZTEvSmJVQXUxelhTb1RRYzQrS2ZUWTFu?=
 =?utf-8?B?RkNOb0wyL1kwMVdsbXNrTm05czgvRTVFTkx1aWUySGxUdHQzdC9FMERERDJj?=
 =?utf-8?B?NWNXaFpGY3JyK1dwQkZHZWhucERzc0x0aXBzRThRU3dRQTVQSzArR3NpWjhp?=
 =?utf-8?B?aWVGNHA3UWN4enFMVFV6ZExRL0pQUUVqUG5Db3MySERMN0RJWXhTQmRDUjc5?=
 =?utf-8?B?eHVEOVJhbng5WjRNZ2ltQnJBSjVFU2l3bzdiLy9IbjFxYWQxM1dPSEhCandR?=
 =?utf-8?B?a3FVaFR6VkQ5QUxzaTEwemNmV3d0bkNMUWpGWmJUUHZzOGdrb3V6Z21YSDU0?=
 =?utf-8?B?ZXlPUGNTb1RpVWRhVzR5Vzk5Q1dtM2tsaGIxQ04wZ1B5bkErOXQ3dllGeDNi?=
 =?utf-8?B?SWhpcWdNTUZhS0dGYkFxaDdzbEswQTRaZHN3UjdEc1B3eXd2eGhvL1JHTklu?=
 =?utf-8?B?MWRTS0tuclVibHpoOXRPMnZTVEFFcGc1K3N1QUNQMVZac081S1ZmaXE0UUJ6?=
 =?utf-8?B?cG9yNXpCTS94ZkpudXZBWXRFMk1Eb1JiU1JzcnB5eWttSlhFNFYzOTdDd3JR?=
 =?utf-8?B?amVEYkJsbitIOHRxaEdveE5VMlRPQjg0QkNBelVmWDQ1ZkxCZkl2MFFObXZn?=
 =?utf-8?B?RmFIWC92TldVbnc3NlVtU0UzcFoyQ1lDYmRkdHVncHU2eUtVajhnelQ4aXo5?=
 =?utf-8?B?VnV3SlhZNVYwYTRVWTdpMi8zeXdGSlhmSzEwME1SZnhnSURMa2UwemNCcEl1?=
 =?utf-8?B?NjVNbFN6MC9ITWNaWWU0a0FJTkEyUjBISU85cGNTZUdWbmo2Mm1ZNGlMQktX?=
 =?utf-8?B?YXZraU9PcGtuV0FLenlkTWYwS3BmeTZKTDQySmsrY2pvd2VuTHdRVnJZSllS?=
 =?utf-8?B?eFcyQnQydURWVnFqZkEyd3hJRlRSaDQxRXBxb1JNajA2cWxLakorQlJLUzVm?=
 =?utf-8?B?bi9ZQmZ2OURQTW5Nc01KaUhFUEJraE1zeVVlNmhiTzJYWmpYSEIzNFFITUVW?=
 =?utf-8?B?MkZKWXlLMUEwZXdEQ3kwS2lETzM0U0hRV1doOU8xbnc0bmNZbnpkWUY5NnlH?=
 =?utf-8?B?ZTJPN3h3c3lONGxuNEdJcjc0aW9hVlRqQ243L1FJcTNTcWVBYXkyQWpkWGZx?=
 =?utf-8?B?NHk5RUt3UG1DMWR5bzZsQmZieGhTYzV1SVI5OVovUkdONHBCUCtyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5243A08F494625459201CFE4761E4BFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dzNVtggW2MRYi0aEB9Ee//TZY3IrUxNeY5CXzQHIo+Ok7mlSNC6vtLFCvnEgh8upR5py1kDnjapnIAo1xMzFpzfxTmGh4yPnftbi14oDMivDCT/rONiwyfwABm4p1rykBvAplO7UV1Kv582Tq3FG99T4agAyWEpsTbAYkle9PmyLLIUaXe7Mo1jl3XWwgUXRd77cqy/kN1lY2WNmmDkAwrdD49Itnzfb7tZWqcVFz8ST9KbvC7s/Xz8dnPJ5hmSBkpAY7lUSdA6QfFFv6Wb5qhsCHEAG9HCqChHrbUwfg2uVAkx0bKM1VlDazX8UPtMWM7RNGE87bHK5J062J1ujKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3a966a-51cd-4d7a-c482-08df40694668
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:01:40.6768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stGkGjF9xlSj1ZOxUD60SnskjHYYACl1GUBYpnW472Nz9e3+jG/ViaecazPemZRIyLvzDoq8O4ayXUF6BoyMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8654
X-MTK: N
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTA2IGF0IDE3OjIwICswODAwLCBZaWdlIEppYW5nIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IG10a19kcm1fcHJvYmUoKSBhY3F1aXJlcyBwcml2YXRlLT5tdXRleF9ub2RlIGFu
ZCByZWxlYXNlcyB0aGF0IHJlZmVyZW5jZQ0KPiBvbiBwcm9iZSBmYWlsdXJlIG9yIGluIG10a19k
cm1fcmVtb3ZlKCkuIFRoZSBjb21wb25lbnQgYmluZCBjYWxsYmFjayBkb2VzDQo+IG5vdCBhY3F1
aXJlIGFub3RoZXIgcmVmZXJlbmNlLCBzbyBpdCBtdXN0IG5vdCBwdXQgdGhlIG5vZGUgd2hlbiB0
aGUgbXV0ZXgNCj4gcGxhdGZvcm0gZGV2aWNlIGlzIG5vdCBhdmFpbGFibGUuDQo+IA0KPiBJZiB0
aGlzIGJpbmQgZmFpbHVyZSBwcm9wYWdhdGVzIHRocm91Z2ggY29tcG9uZW50X21hc3Rlcl9hZGRf
d2l0aF9tYXRjaCgpLA0KPiB0aGUgcHJvYmUgZXJyb3IgcGF0aCBwdXRzIHRoZSBzYW1lIHJlZmVy
ZW5jZSBhZ2Fpbi4gQSBiaW5kIGF0dGVtcHRlZCBhZnRlcg0KPiBwcm9iZSBoYXMgcmV0dXJuZWQg
Y2FuIGFsc28gbGVhdmUgdGhlIHN0b3JlZCBub2RlIHdpdGhvdXQgaXRzIHJlZmVyZW5jZQ0KPiBm
b3IgYSBsYXRlciBiaW5kIG9yIHJlbW92ZS4NCj4gDQo+IFJlbW92ZSB0aGUgYmluZC10aW1lIHB1
dCBhbmQgbGVhdmUgdGhlIG5vZGUgcmVmZXJlbmNlIHdpdGggaXRzIHByb2JlL3JlbW92ZQ0KPiBv
d25lci4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IEZpeGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0vbWVkaWF0ZWs6IEFkZCBEUk0gRHJpdmVyIGZvciBN
ZWRpYXRlayBTb0MgTVQ4MTczLiIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNp
Z25lZC1vZmYtYnk6IFlpZ2UgSmlhbmcgPHlpZ2VqaWFuZzg2QGdtYWlsLmNvbT4NCj4gLS0tDQo=
