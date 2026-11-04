Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072B606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=RgPXO8hg;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=oxcCmeS3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1FE10E258;
	Wed,  4 Nov 2026 05:57:28 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D35C10E258
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 05:57:16 +0000 (UTC)
X-UUID: 92e06efcd81411f1b1788b6acf885367-20261104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=gXl+ArOaVp1QcqyHLWXeVwA2frWi//TkJT+7XZ+9OY0=; 
 b=RgPXO8hgaqrjQNsfN543YONfJNpfYp2meiPLJnIXWsJH8J56nNLLitXL9GzJNl7fPcaWe6bRBUuKYmVZ2WmB1qDUokfsS3HoSDhewVZhgXxzFu3xK+MRgbkCX8Xrz27ZMIazQP+iW9lHfhuNoeaF3H0msVwDUAD+wPVuopxfaME=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:3e92ca78-de6e-4afd-b200-d071facd74a9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:5925907f-3613-4bd1-a0b7-c3a1d3e04ced,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92e06efcd81411f1b1788b6acf885367-20261104
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1529691717; Wed, 04 Nov 2026 13:57:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Nov 2026 13:57:08 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 4 Nov 2026 13:57:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmVcxGpfuJthko1m/vx3IBzu+wtSN5nmoOFpAhDpTJ2vPQi0VplsEcDsiTZvSd84H8zSngs9naDVHu0H0ID/FZZ/TQDRtvjgB/U+0lr4ExV5RtEuIME8ur5Hu/0feFDz8D5GIKBT6b76oK3o8lXsd/RxogB3q09Y6t5owjIpTe75wx6kYWZlDs/tO28dA5MKqqXMy7lObXJjI/41YvS6px0IFEf93OEVpzw3KxfDv7ZRjsF51yau5OPpRl/Mcn3wpubCq9lVKAqPiPkJXHzmXL7daDDAl4UyNPKfHSZg4686YQQxf+Y+RHTPxsGx3kG+jU7RicteC1L/E6z8I+QfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXl+ArOaVp1QcqyHLWXeVwA2frWi//TkJT+7XZ+9OY0=;
 b=yI/l2fJDnoWBo1VodDnc3T5f3LNEgTlSs6QZjOrgUl+c7/NBa0tsu1TO5/BMWd9dsJg7ZzV3WKIP9tWiodzceaP7N7ZnOXYZaRAMpfrgGtTPSvTQlScEcNtl5/K6a0gvLQ6dLfUW6wUzYhKBtW/0n8tt5ql9Qbx/vajODQMWx/WO1VuNtJsp83S5fABK53Ntc2PPd7GpeHuavfKVx5nCTOeK0ookGVFYk1uvG5i4LtR9DWWSFefDWBU0G+Ziqg4Akm6T/SsGTNzPrGOVPUJFYf3vc8+/2C/s8bmD0y4iZZMqGUEDf8vims1nLap0DwatVuZ5GPP9o4YyKqfCtZMAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXl+ArOaVp1QcqyHLWXeVwA2frWi//TkJT+7XZ+9OY0=;
 b=oxcCmeS3PJdw6VF+bQlDJQvg+L9WpvIKN2lqG2JVZbN7E70jB7+qxK3KtIrZe2w/sKboy1lgf9FojHe1sKK4kBo6PtBe1d8Y/rb9VNO7ayXhMAjzetuWq/OEFSuzX7wFEZQ/uXdiLtXvShki5ZliVI761/JGnCQBKHKlg+IE9WM=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEZPR03MB6491.apcprd03.prod.outlook.com (2603:1096:101:44::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 05:57:04 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:57:02 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v2 16/46] drm/mediatek: mtk_hdmi_v2: Don't warn on RPM
 active during detach
Thread-Topic: [PATCH v2 16/46] drm/mediatek: mtk_hdmi_v2: Don't warn on RPM
 active during detach
Thread-Index: AQHdE4ZbyGh53rLFN06DVPclzkTV6rceG5GA
Date: Wed, 4 Nov 2026 05:57:01 +0000
Message-ID: <ab84d3bee4af95347257b8605211c2fcab12f623.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-17-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEZPR03MB6491:EE_
x-ms-office365-filtering-correlation-id: d27c631b-db05-4fe1-331b-08df3a387246
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|38070700021|56012099006|261022105027099003|261022075727099003|11063799006|4143699003|261021123027099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003;
x-microsoft-antispam-message-info: rf0m8+mvK5Xgflrg4BsZfNxfhf6iDAl4cTvs2/bNcR2Pb2napNYysmpCopCPCVrRy/P7b4dCkiCK4CGYBUD4penrVFJDyLA+cn/Sdf7epE3NGB4uFBJAOq51gGPf8VE9XX63RZCYcgMM0eFCzR5OT+rlSB+pRepT6doukeeQrlqKJ/gsfViBm3yFkhXfw5fuRKCkh0RQ1YfG+Acjq9eGyBrf1B2aHr6dUP97qEWSJ2Qk3Wv9XyYbSY36FJXfv4mnCtVp0XyOT8TniYT+wYgTovZY/ydqIYia0Nq7w+NlXPvAJEm8GTKUJLSeEGVyGhWCfYsyYPceX7vNdMVNAzNJ/Ul5JDRjPjK8yT3ycpicJWOTDbuG9IfUwH6yHJQxmqWILW2fDEPpyy3mN66CAb8ZspMOaWf8Rptkr2jrnsLWumkSykkhOqxQVAoU3qoByXQxOVfCU/wrfd415utW2k6Pq8MD4cLUfK1uNjd0FdpwPp7I1mtk84SI206fHU4jD0bcttM/3HMJg4r6uz21lf3QoALT4w5TAigIK4ygMWi5pF9pYAUhZwr/tjpG0UcG1gMnk6ONT7Wv75gXMeWa9mOn2mLMzolonITtHkAWXjI3Vn3EWX2EBXInSvFQJlyRcsRtIcgY8EDXlaTFv5uWcA58bfZQSMRkg935dUf2dSM2VTcQBbOAdPpxJ8l8zLlngUtcM/g/xlL1LbOLMz0e1ipUeGB8Rk+8zNg3jK6hCpc+NEo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(261021123027099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJteVRtQjlBdFhLbVd5R1Q2b3BPY1dLNk9OaWh0dG8zU21pK1dlbEVENmQz?=
 =?utf-8?B?M3ozSHI3Rm92dDdNb2FwZjNEUVQ4R0ZmS0llNCtNQkI2ZGY4MmdIeC9wUXZV?=
 =?utf-8?B?ZG42UmU5RXhRaEVyMkhwclQ2bExFUCtWT2wxUVlFTU1UK2hBWmlQa1lCREpX?=
 =?utf-8?B?R296SkRKMTRMdkFzekp2OHdoMWcrcmsrbWY4NTEwQVFYanFCS3dHcFEzVklh?=
 =?utf-8?B?QTVHeGk3NUR3L0NZTGt4cGpqeUNJZi9GakdpWjROSVhzM3pmVWJUQmRZR3RC?=
 =?utf-8?B?bXRBdDBLaDUzbndoY1M5Q294OHhnaS9icHdjU1NZUEYxbDIzd2pVM3laR093?=
 =?utf-8?B?azNsbitiTHJXSVMzZE05cmQxQjFRSVpTbDc1cFh6S3FoZjArNnRNc2FTeDNG?=
 =?utf-8?B?bkt6VHh4RkQ3QkJhZUphR1lNKzhOQ1NIV2ZScXZjT0FVYWJjRWtrMU43UXox?=
 =?utf-8?B?d3pDL1IrTjVrdUo2Nko1SW1wRkU4d2t3a3hxSTNONTBLREUvUTZDQ2l1R3NC?=
 =?utf-8?B?YVZaUDBKSTRCcXQ3eXVKc21GZVRMOURwUEgyOVV0TGJqd1VIRENMYW5mUEdu?=
 =?utf-8?B?RGlOVmFyWlczTVZmeWVBSExNaXphMmpHcGtyamJyMDdkeExiY0VFYklKbHEv?=
 =?utf-8?B?aGZnczJMSkQzQnRQMW91L3hTbTdTanFPYTIyNWdNdlhwZWpidXNWUjdlL09t?=
 =?utf-8?B?clllT1JDaDRuNlRGRkxmd1JaaWVRaTVxR3QwSEhOakRqaDV1QTRiR3lxMG1E?=
 =?utf-8?B?NEFJN2ZtaXBGNzlTc2h2NENYdTFmejB1ZTBjVG53bHhqRXhuVXBoSDZhT3Fn?=
 =?utf-8?B?SzZ6eG14dU0vdnU0RUVlQU0zQmt1TjNzTGlwck5HcUk4QUFaMmJBWUJYK1hI?=
 =?utf-8?B?MmlOaXpiUSt2M1RpOXVURi9pL05keVFjeFZPWEp0RWlSSTVtRnI0dUJKMmRq?=
 =?utf-8?B?NDJHTWh4ZkpTamVudkRIR1UyYzlDaGZ4OUtmMk1naVo0aVB4dDlNZmt1cWdp?=
 =?utf-8?B?M2pNdktlV3d6bklXaGFORlpQVkF0dFdJMFE3aGx0SnZIK3pkK2FwbkJnL0Vh?=
 =?utf-8?B?KzNnU1UrYmV0bXlnQ2paUUpRaVFqZlRlQlFYRDkyM2o1bDFnL3NXa1BmZnpE?=
 =?utf-8?B?bFQrckg0TFVnK2RSdHFLV29ocUR6b0ZDU3R1cGkzRmltNkFOR1lrVVkwZHF5?=
 =?utf-8?B?dDJNVzcrZTR0UTdBRElQK2QyWkdOWGxJU20rbWRqQjU0VnJuWnJITU9pWUpH?=
 =?utf-8?B?WmVyVjhnL3ZPMFpMMHdXbXIvdk94dmkyT1F2MWg4QlJEc0FkN2RPUFg4ei9Q?=
 =?utf-8?B?aDhqRTBWMDBBYjBiOGU5a25wTDFsYzh2MXFTa0lsbmwwSURNYWJneVZaQWJY?=
 =?utf-8?B?cVdaSFZUZGJDK1VCK1ZnbVhsdC9NZkU2Rk50QW1LNmMyZndaZWVFNU5HMm1U?=
 =?utf-8?B?U2lOK3crZ0g4SFhhWmZPWHdtemIwWk1MUGw3K1pYZ1ZDS2tUOTlCWU90Sllj?=
 =?utf-8?B?Z2VoeVVzL0lnMTNraVZ4a0hIQU01RkdxMWNHdnBSbTBQTkJ3LzN3U3hnRmtF?=
 =?utf-8?B?aU15UDlGMEZLWjYybmkxNkNHcU5BT0JLOGx5bUZudUFUbDNlUFAzM2tXVENj?=
 =?utf-8?B?Q1pqbXhiMmQrSXZic3dveTZzdk8rWElpVnh0cWRVUHExd3BNalZDM01Lc3k3?=
 =?utf-8?B?QjhvYnlGVHJ4dlEvYWtnbG44WGJLOTJuK2VLMVpHL1Y1QXRzU1RRaWIzTmxw?=
 =?utf-8?B?VWIxYWJxbXkwYXQ0OUh3VWZMR3Q3REJKVzgzZmdxaHoxalQ3Q0hhakNRdUlG?=
 =?utf-8?B?S3BWQmtSRlF0V1JjcHRGUDQrNVQyYkpXT1llMzFFNzkwNDlwRlJST2ZYc1pa?=
 =?utf-8?B?Rm1kOVRERmdHYmlXdjdITmZhRFJLV21YQ05zb0xrLzA2cktzOEZMRkg5QkpZ?=
 =?utf-8?B?YkpQZGVESnNSYStnMU1NL0MzbUFWcEpPaHQxUkdhYW9NeU9sMmVLMFFrd2dR?=
 =?utf-8?B?NWJDa2xycVh6TUZSVnozaEZzM1BzMndldlVERWFUN0xwRzdid0hEMjBURGhG?=
 =?utf-8?B?cmdaSEF1dE9sVlQyMUhaNzlsWVpWZ21zUUhma0tKTkFNSURndTJVd0hEQW9N?=
 =?utf-8?B?MWVzbjNMT2NRUjZEZWVKUWdZdHVwUlhyR0EzZEtlc0gwM1o1K1J6UXVsN21X?=
 =?utf-8?B?Tk1nYXJ0VHZXaEtrWmdacklVUUJBdlJpNDFEdjY2NVVRMlRoR1hJQzZCTFpn?=
 =?utf-8?B?M1YySUE3ZXpJai9EV0llZjlZOGxJdmVGN0hVVDJjU3RYUENMMXpscUFEUDM0?=
 =?utf-8?B?WmtibjNiR244ZytIL3NPa09ONUpLYXFmMXk5bFlHbjQ3L2hPdDlNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40657FE9DB8C6F48B05A1699F3C51BBE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wLMC1uDUfhDEs8Es/IqAsrpatNiMJQLrobYENaWhcKymEHkz6jyEx4kFiPN8WwESmOIQwwieYnotPBB3fxsazgBA8u16bsFPSRTe34V5BEIKhpt1nJd6huJFM7J3Lv19hKuCI1zBiSSy0SKCNqjHsb8LkDZ6UieYJagxeuactwKN2QDZ8pd+0GukMnPG/V6jazw7Zc0WpJ/oUwcEbCTa9ioRSQZot23ZDxGyn3V6RArI3JqXPjZ8mNW+3RZ0SGdWFxck76oopBuMaJw35vaJQAwc4wTK2QZ8kwxVUYSwjH7WaCD8hjPOcxM55krL41IXEKMxSxuYH1FZSv6Xot1unA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c631b-db05-4fe1-331b-08df3a387246
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:57:01.9103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuGYDD5SzrO2avtNLBfJub6HYEMg1AJhDPkHs2dZu5pGKTM4/R68jnDO3EKMTyJ+t/t7kJf1Hqtt6O/GPHSpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6491
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

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlIFJ1bnRpbWUgUE0gbWF5IGJlIGFjdGl2ZSBkdXJpbmcgYnJpZGdl
IC5kZXRhY2goKSBhbmQgdGhpcw0KPiBoYXBwZW5zIGVzcGVjaWFsbHkgYXQgYm9vdCwgd2hlbiBw
cm9iZSBkZWZlcnJhbHMgaW4gdGhlIGRpc3BsYXkNCj4gY29udHJvbGxlciBkcml2ZXIgaGFwcGVu
Lg0KPiANCj4gRXZlbiB0aG91Z2ggaXQgbG9va3Mgc2FmZSB0byBhc3N1bWUgdGhhdCBSUE0gaGFz
IHRvIGJlIGluYWN0aXZlDQo+IGF0IHRoYXQgdGltZSwgdGhpcyBoYXBwZW5zIHRvIGJlIHRydWUg
b25seSBpZiB0aGUgRERDIHdhcyB0byBiZQ0KPiBoYW5kbGVkIGludGVybmFsbHkgKGxpa2UgYmVm
b3JlIC5ocGRfe2VuLGRpc31hYmxlKCkgZXhpc3RlZCkuDQo+IA0KPiBBdCB0aGlzIHBvaW50IGlu
IHRpbWUsIHRoaXMgZHJpdmVyIHVzZXMgSFBEIGNhbGxiYWNrcywgYW5kIGZvcg0KPiBIUEQgdG8g
YWN0dWFsbHkgd29yayBpdCBpcyBuZWNlc3NhcnkgdG8gcmFpc2UgdGhlIFJQTSByZWZjb3VudA0K
PiB0byB3YWtlIHVwIHRoZSBlbnRpcmUgSERNSSBJUDogc2luY2UgaXQncyBub3QgZ3JhbnRlZCB0
aGF0IHRoZQ0KPiBIUEQgb3Igb3RoZXIgY2hpbGRyZW4gb2YgdGhlIEhETUkgbm9kZSBhcmUgZGlz
YWJsZWQgZHVyaW5nIHRoZQ0KPiBkaXNwbGF5IGNvbnRyb2xsZXIgcHJvYmUgc2VxdWVuY2UsIHRo
ZSBXQVJOIGF0IGJyaWRnZSAuZGV0YWNoKCkNCj4gdGltZSBtYXkgdHJpZ2dlciAoYW5kIHdpbGwg
ZG8gdGhhdCB3aGVuIG1lZGlhdGVrLWRybSBkZWZlcnMpLA0KPiB1bm5lY2Vzc2FyaWx5IGJsb2F0
aW5nIHRoZSBrZXJuZWwgbG9nLCBhcyB0aGUgUlBNIHJlZmNvdW50IHdpbGwNCj4gYmUgZGVjcmVh
c2VkIGFueXdheSB3aGVuIHJlbW92aW5nIHRoZSBkcml2ZXIuDQo+IA0KPiBUaGlzIGlzIHdoeSB0
aGUgV0FSTihwbV9ydW50aW1lX2FjdGl2ZSgpKSBjaGVjayBkdXJpbmcgZGV0YWNoDQo+IGlzIHNp
bXBseSBhIGRldmVsb3BtZW50IHN0YWdlIGxlZnRvdmVyOiByZW1vdmUgaXQhDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiAtLS0NCg0K
