Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D1606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=byzpZ8A6;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=CY5A2TFf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CDE10E03E;
	Mon, 16 Nov 2026 00:42:10 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AAD10E03E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 00:41:58 +0000 (UTC)
X-UUID: 84e0925ae15611f18dc8c9802ae25ab1-20261116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=; 
 b=byzpZ8A6EtfDR1NfDHV+7vFPnZ32pbO2N1aP3/PA9aQs9n9oPKOyeDqx0xfoIoutP82bQhPxmDfvq2IiYfM4B6W00pa3V8nGjRtoqfp46Y0t/WuQwHy7ePx7mtMe1dXKFYSNjaV5zvtJR3TAXp69JpKWwT8BzdARHAmtoN3Tp7c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:615a9069-f960-4e45-8179-3d596a5cc982, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:df7bca8d-b3e7-4795-ae33-b1b4d51e21d7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 84e0925ae15611f18dc8c9802ae25ab1-20261116
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 86583998; Mon, 16 Nov 2026 08:41:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Nov 2026 08:41:52 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 16 Nov 2026 08:41:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7r+LNmJcaQHwXpStRqXRy5vi5/0vgKSCA4rVCCif9yiP2qC2QKjUSP6f5a86MliryF1MD1rkmfjDrEDw3RJ88Ms3hZE4AUqO93SnqyK4tE88PrAvD690N/WjlXIQFAhhRSLWMCO+yT2DYIj0lKbTu68bQIihbcbPyBhQsWDuaR0eSvoaf6sTPgaycK/Jr0goxx0OPkZMBEMEq548rkNl9m+I7ceIdBI2Kev18zaxu4kEuJimSOPREC/DzLBDBJ34ch4jAqdNxQDnxGyQuhYFXw0UEJZX8VYiJQwBh64luzVNFtvBZSAkg1QIRVqN1/UANsp1z9RlscBRmGRERK66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=;
 b=MWA57Qw39ukFnfKGcIn5NS1srLYogxhsBzrmMVtZpmrAL7wr7SUPfEWbygY8j2xQaOjsbZUsEGe+6CN6VR0PD+p7DC+fcLhRDeEUlh7xlpJqXSADokPOuW15jMfs3YnfxE+CnVtgpHyae7riEDJN4c5Iz/qJf+RO3zuF65aCOpVFSfiIamAG+/ib9KbwImjhlfU/pK/GQx539WyhFdSF41OPrtZyw+Y9oULMia7tDFhGa3a/vDhlbJAmkORkxig9U33XIsRICUyerjfoB69m5Me579qTGwmFLWN38nzL6noAL7vFM46uJxrySnK0l90BOInGsuV/PYop1ld7OilYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=;
 b=CY5A2TFfU78IeKCKLCj7IaQyn3fHoAZ6hZydEqCyFIeZkr5FGhyb7l09QY4MpCvVAwohhSU0Jk4rBpKPej7xUQnC18Pd4iyWCIWRaZ7eCOZQrQbS0QEMIcnCzAMpzvpAzf8LEEBHmGOjx8rpB7QttLqIiUees2eV2BqSN55zmXY=
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com (2603:1096:405:3d6::13)
 by TYZPR03MB9616.apcprd03.prod.outlook.com (2603:1096:405:b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 00:41:48 +0000
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d]) by TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 00:41:48 +0000
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
Subject: Re: [PATCH v2 25/46] drm/mediatek: mtk_dpi: Fully separate HW setup
 from common code
Thread-Topic: [PATCH v2 25/46] drm/mediatek: mtk_dpi: Fully separate HW setup
 from common code
Thread-Index: AQHdE4Zp6CJPVvWB90W+JFXrDea2V7csMlgA
Date: Mon, 16 Nov 2026 00:41:48 +0000
Message-ID: <4efee14426f4249eeb01a77fedd0aa839309df93.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-26-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYNPR03MB9924:EE_|TYZPR03MB9616:EE_
x-ms-office365-filtering-correlation-id: 059b107a-888d-4c88-0b9e-08df437a65f1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|42112799006|38070700021|10067099003|11063799006|4143699003|56012099006|261026121527099003|261022113327099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: ITwjW9vA7GOWZWWc5bswgsHptEzo/D6kSOUKfDtExf7pcmwOYM08Vg1REwHs0szd01mRGIm7bvHOH9KADYsb+crAFvH7KMjVaZZehSmtQQ6VK//gi9F+P+MLfh944kkbOuINHGRbOKTHSxN1MRlrc4ggmQFTe0Oeuagx5Qfstuc7GYAMoIrKOdTsq2f/e3VhlvbKqAlOX5ZjZYXPefzM64u82z5jRMholNWwzMKEtrR9rqXBwgNQTekcHScSjo/qXZFR3vPGvNOp/obN4iyDoapQhGdf+9lq4bdE4gzwYsVJOM5gAGL6ECC4oFDjjSw/UtilbLJnzxxzHgF5MZXCyQJ7cchBlC3HIf4+f+Z7VLeREZqIwyq7Wf+h6nRsuHsqEqrwm7SlXyMzE+Y5Ey7jd2ojvljdCbJqf5g6FEWrjvW3lT8IU6hVSRFUUj6ymoojgYpNAMxCoPSPH888khACTEpQZlPm0yNr7UvuO/+vbt3HlrwnQ3XdpUwJ+fDIegSB7SgU5M649aRLQQdhS5VON5DnwFF9CZgHhSThYRKWfDWtYqztICY2RmkjvVVcaIyATzrDb9dYiBG7kjVnz1YpVe29xxSIwS6rlv2XJXgsq6hWducog4h7yxOlE0gcnEjRS9u+ahreRAsA5QZYH2ptJRCK9M0mJ+A7NU9cYW5b4j6v/dpMuIu92vIg1NfvnC8Yfo5MnbGX5V3a/Tp4dIedsuU80WEYXZ+QIWdkv7p4bYI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR03MB9924.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(42112799006)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022113327099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REwxNnh2MG8zN1diclNqMk8xL3dVcVZyZW9jNXhjaEF3clpHOWlWSkNOWkZT?=
 =?utf-8?B?NncvaGFsTm1aUGZ0SnNDSFNBWEk3bktyUWY5OWdjYmZPaU1Db0NVTEs1MjE3?=
 =?utf-8?B?eVcvc0dTSzk3N3pLeXY4c0JUSHJUeUN5RUpvUkFUd1p5aDAyRjFOeXlsSjNo?=
 =?utf-8?B?YUpWc1pPdGYza0xJcHZPSW04T2xnYlNrVVlCWVljcVRoSytBT21VYmwxM2J6?=
 =?utf-8?B?Zkx3WXNlRjI3Y09PbXhRdG5PeWVtRHF0YU9JTDhkV1E0aFNhTERmcnRHZGVw?=
 =?utf-8?B?Mi8wWExVeFBsTmRGNzN1YTVuVE9HZVBBV0svWjdRZzFPdW5mdTRaWlVBVFlG?=
 =?utf-8?B?Q3lMdnplUUlreDZZRkdVMXFwS0E1WjB6cklhU2VLQithcmN3NFRHOTFlT3V5?=
 =?utf-8?B?TTFHYVJQbWpSakxwbitvZW1UVGwyNzBrMTZsMEpsdVI4S2hHWmJxbCtPcURY?=
 =?utf-8?B?R1VnZHdVdVRtTmFTQkNIRnphdVI3ak5mT1ptQUxrdGpvRzN6ZlduSU9WcWpV?=
 =?utf-8?B?V3ozYTJ5RkFNSWxURTBqWlhicHc0VEYzSUp0QkVZRG5uVjlpc1hPZzRieG1t?=
 =?utf-8?B?cWppU3l3S1Zlb0dhZHlQL005Y2ZUVUZMeVBTSlhDb3h1bWZiQU54ZjhDcmI4?=
 =?utf-8?B?ZllZQ3FIbFBBVVliQUdCcEhRRmdtVXE5anBPbnZGdjZDa25RZ2RLcitpVEVP?=
 =?utf-8?B?RWxQWU5VdnFCY2RCS2xQSFZkaGd2UjF3ZzZhN3F4ZktUSXh6MXB2TXFjQlcx?=
 =?utf-8?B?dGJrSEY1dkVXTHRQMEtDSkNSYTV4R1pITEViVGdzWkR3cUdxbGd1cEYxYjZ6?=
 =?utf-8?B?ZHFSWHNXQTlCNzZyMEtlbFpiMW5LaXp0cTllOVZYVVI3Q2hIZjhFTE8zbncv?=
 =?utf-8?B?dWJ6YUxlMWt5dHJCU2JHN2tTVXI4TkxqRlh1RzJmeEJNSEN5S0FLMzJWUUpU?=
 =?utf-8?B?ODZEMG9UaElMQzR4dS9vMFNTeHNmQnRJdHI0cG5FOGt5WU1Sc3pZMFI5eEJx?=
 =?utf-8?B?ZHhUZFVybm5oalRyV2NEeFNTTE0zazZpdmtPN3dJR1NZMDRLaGl0bHJ3bkVE?=
 =?utf-8?B?dVF5TVQ3cjNGYTdkdnc3bjVoSFJCWjk5UHY2SGJMbXVPd1pOU3NmY1pzSW5Y?=
 =?utf-8?B?VXBlcjk4QmRDNmU2Zk1RWjFuZXhUbWtmQk40NUxSOUU3aDEzNkczT3RjMHlE?=
 =?utf-8?B?eHBiQlJGRDNLSXUzTHhMS0Qwem1XUVBTYWpCb0VaUUNXcGlqUTlGR3lLUFBE?=
 =?utf-8?B?MTVNVjl3ZW0zdmY3STIreUVzcWg3cFhaWW0wYnpqS0hRSVJQSUtuOG82NXhI?=
 =?utf-8?B?WjhjOFhESFBoZ2ZNWElvSFZLbldORTAxQkowcGhtSThmdDFLTlNKcjhwakZh?=
 =?utf-8?B?ZGV2Yi9kRk96T3hDdHlTV1VmeHB4WEF0M2g1bHNjL0p6RUIrWUx1dHNqVVAz?=
 =?utf-8?B?SlhnWUQxcThuRlJYVEo0cXYzUXNYUkY0TmlJZEVMWVJLL2lDcnBPbjBzN1Qz?=
 =?utf-8?B?TFRPQ3pVeThaQzhCak1wU0pUUVlyd21kZFo1ZUV3elNSK1FyZm5YeHA3amcw?=
 =?utf-8?B?M0hheCtaUkxHWHoxMm10S3FNeGYxd0xXUm16UnJpN09QWUpkdndydy9XdnBn?=
 =?utf-8?B?YjJRNTVpM1VocTVhbUZRUUtUdUVqK1VhSWdkNkFDcVpUbjMwOXhDZU8vaUFL?=
 =?utf-8?B?MndkWmFnSGRBOXJ4SC9hM3JvbzNHK25oSG1NUlF1Q1R3VDVhYzREZUtGeGJt?=
 =?utf-8?B?SC95VE9TQzlZeEw3Q2tNbVczZ0lmWTJpUGdRZmxLVjV6ZjcwTHIvVVpjK2hU?=
 =?utf-8?B?eHRBVTdwU2hHOXU4S1REMG81N3k5K0k1cGgyR0RCejZjQ2dsMW1aeWMzek1x?=
 =?utf-8?B?TzE5ME00TGxMV1FKSkZVbVI4NzVTQTJic0o4RnNKc2Uxd1hwMi9lZDd2Zm4x?=
 =?utf-8?B?bjhxMS9FV0pKT3BxNmdlVmlwSWRKdnBTT1BQS2dBU25LOHlJU2JSTDJhYVhq?=
 =?utf-8?B?Sk5YUHp3N2cxQUk3TW9uNEpEZjQ0eU5GTHhtNDZEUHdzd0R5OERtdVRyejFD?=
 =?utf-8?B?WFhaSXl3SDJxQ2llVGVKQ213dVprQSswNDNVSVYvQlZmQmdvUmMycXNlckp3?=
 =?utf-8?B?RldJM2RKQWVxV3lCVGwrdVE2SmlDYnZVcWJZRWZRWmF2ZnErODZsQkRwV2lh?=
 =?utf-8?B?UDdpNlBTR1V2RkFUMkF3RkppM000VnBYN240Z2NCSVRwVHYzNWtkY3liMy8v?=
 =?utf-8?B?MjBQODIzd1FvN1BhdUs5V0RHV2Z6ZllLSGlwNTB1THZuUmU1K1RiTUlsQXh0?=
 =?utf-8?B?WnJPK1NuK29IWWF2NTJlRXpNb05pbFAxMFBSQ29WU3MvS1JkU1NhZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51F8FE96B0DB534D95F8FFBAFB78B99A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LqWgoBV71bMZqjrSnKIRVmFBthhNBwC5Fq1ksqQoSQBdFKEk3cIo/wz2uMtEBmuBWSFfs1BypCtVmEc3MRT9tpz7vj2ZKulIr88XJviaB77/TZQrROstWOnAd70eRvP0gicabY3BG21c8BX3uWV3nJokXuSjLSCzjlsG+1TypopV6FDUvxIWDFjkAPUWabORmHyGBvj8Wlx+OaPJfLmns00YKW8OVWgh4KeNyiklhDi7lh6Ro28XE3trEMocyWYDJEXXRg2MxfYalKahA8wkPMAlZX6mht2cW7sfGTZX6LmJJS78N6q7fwaQV7BZ6LifuIkPdHSZ0vkj9zRFAMYyjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYNPR03MB9924.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059b107a-888d-4c88-0b9e-08df437a65f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 00:41:48.4200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0H/kq6PwwNzYdbIfjjoQBJg31jvzDfAQRFrQxcNcRKI+n/VMzM4S9UlqxYshAxSKspsse3Tlr9IhvoukvmEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB9616
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgYSBwcmVwYXJhdGlvbiBzdGVwIGZvciBhZGRpbmcgc3VwcG9ydCBm
b3IgRFZPIGFuZCBjcmVhdGluZyBhDQo+IG10a19kcGlfY29tbW9uIGxpYnJhcnksIGZ1bGx5IHNl
cGFyYXRlIGFsbCBvZiB0aGUgcmVnaXN0ZXIgd3JpdGluZw0KPiBtZWNoYW5pc21zIGZyb20gY29t
bW9uaXphYmxlIGhhcmR3YXJlIHNldHVwIGZ1bmN0aW9ucy4NCj4gDQo+IFdoaWxlIGF0IGl0LCBh
bHNvIHBlcmZvcm0gc29tZSBzcGFyZSBjb2RlIHN0eWxlIGNsZWFudXBzIGFuZCBhbHNvDQo+IHJl
bW92ZSB0aGUgbXRrX2RwaV9jb25maWdfdnN5bmNfe2wscn17b2RkLGV2ZW59KCkgZnVuY3Rpb25z
IGFuZA0KPiBvcGVuLWNvZGUgdGhlIHNpbmdsZSBsaW5lIGZvdW5kIGluIGVhY2ggb2YgdGhvc2Us
IGFzIG5vdyBhbGwgb2YNCj4gdGhlIHBhcmFtZXRlcnMgYXJlIGNsZWFybHkgbGFiZWxlZCBhbmQg
d29uJ3QgaGF2ZSBhbnkgbWVhbmluZ2Z1bA0KPiBpbXBhY3Qgb24gaHVtYW4gcmVhZGFiaWxpdHku
DQo+IA0KPiBUaGlzIGNoYW5nZSBicmluZ3Mgbm8gZnVuY3Rpb25hbCBkaWZmZXJlbmNlcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBAQCAt
NTE2LDcgKzQ3NCw2IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtf
ZHBpICpkcGkpDQo+ICAJaWYgKC0tZHBpLT5yZWZjb3VudCAhPSAwKQ0KPiAgCQlyZXR1cm47DQo+
ICANCj4gLQltdGtfZHBpX2Rpc2FibGUoZHBpKTsNCg0KQ29tbWl0IG1lc3NhZ2Ugc2F5cyBubyBm
dW5jdGlvbiBkaWZmZXJlbmNlLCBidXQgZnVuY3Rpb24gY2hhbmdlcyBoZXJlIGJlY2F1c2Ugb2Yg
cmVmZXJlbmNlIGNvdW50Lg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byB0aGUgdGl0bGUgIkZ1bGx5
IHNlcGFyYXRlIEhXIHNldHVwIGZyb20gY29tbW9uIGNvZGUiLA0Kc28gc2VwYXJhdGUgdGhpcyB0
byBhbiBpbmRlcGVuZGVudCBwYXRjaC4NCg0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGkt
PnBpeGVsX2Nsayk7DQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+dHZkX2Nsayk7DQo+
ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+ZW5naW5lX2Nsayk7DQo+IEBAIC02MDcsNDAg
KzU2NCw0MCBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3NldF9waXhlbF9jbGsoc3RydWN0IG10a19k
cGkgKmRwaSwgc3RydWN0IHZpZGVvbW9kZSAqdm0sIGludA0KPiAgCQlwbGxfcmF0ZSwgdm0tPnBp
eGVsY2xvY2spOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlf
bW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiArc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNw
bGF5X21vZGUoc3RydWN0IG10a19kcGkgKmRwaSwgc3RydWN0IHZpZGVvbW9kZSAqdm0sDQo+ICAJ
CQkJICAgIHN0cnVjdCBtdGtfZHBpX3N5bmMgKnN5bmMsDQo+IC0JCQkJICAgIHN0cnVjdCBkcm1f
ZGlzcGxheV9tb2RlICptb2RlKQ0KPiArCQkJCSAgICBzdHJ1Y3QgbXRrX2RwaV9wb2xhcml0aWVz
ICpkcGlfcG9sLA0KPiArCQkJCSAgICBzdHJ1Y3QgbXRrX2RwaV95Y19saW1pdCAqbGltaXQpDQo+
ICB7DQo+IC0Jc3RydWN0IG10a19kcGlfcG9sYXJpdGllcyBkcGlfcG9sOw0KPiAtCXN0cnVjdCB2
aWRlb21vZGUgdm0gPSB7IDAgfTsNCj4gKwlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9
ICZkcGktPm1vZGU7DQo+ICANCj4gLQlkcm1fZGlzcGxheV9tb2RlX3RvX3ZpZGVvbW9kZShtb2Rl
LCAmdm0pOw0KPiArCWRybV9kaXNwbGF5X21vZGVfdG9fdmlkZW9tb2RlKG1vZGUsIHZtKTsNCj4g
IA0KPiAgCWlmICghZHBpLT5jb25mLT5jbG9ja2VkX2J5X2hkbWkpDQo+IC0JCW10a19kcGlfc2V0
X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiArCQltdGtfZHBpX3NldF9waXhl
bF9jbGsoZHBpLCB2bSwgbW9kZS0+Y2xvY2spOw0KPiAgDQo+IC0JZHBpX3BvbC5ja19wb2wgPSBN
VEtfRFBJX1BPTEFSSVRZX0ZBTExJTkc7DQo+IC0JZHBpX3BvbC5kZV9wb2wgPSBNVEtfRFBJX1BP
TEFSSVRZX1JJU0lORzsNCj4gLQlkcGlfcG9sLmhzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElTUExB
WV9GTEFHU19IU1lOQ19ISUdIID8NCj4gKwlkcGlfcG9sLT5ja19wb2wgPSBNVEtfRFBJX1BPTEFS
SVRZX0ZBTExJTkc7DQo+ICsJZHBpX3BvbC0+ZGVfcG9sID0gTVRLX0RQSV9QT0xBUklUWV9SSVNJ
Tkc7DQo+ICsJZHBpX3BvbC0+aHN5bmNfcG9sID0gdm0tPmZsYWdzICYgRElTUExBWV9GTEFHU19I
U1lOQ19ISUdIID8NCj4gIAkJCSAgICBNVEtfRFBJX1BPTEFSSVRZX0ZBTExJTkcgOiBNVEtfRFBJ
X1BPTEFSSVRZX1JJU0lORzsNCj4gLQlkcGlfcG9sLnZzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElT
UExBWV9GTEFHU19WU1lOQ19ISUdIID8NCj4gKwlkcGlfcG9sLT52c3luY19wb2wgPSB2bS0+Zmxh
Z3MgJiBESVNQTEFZX0ZMQUdTX1ZTWU5DX0hJR0ggPw0KPiAgCQkJICAgIE1US19EUElfUE9MQVJJ
VFlfRkFMTElORyA6IE1US19EUElfUE9MQVJJVFlfUklTSU5HOw0KPiAgDQo+ICAJLyoNCj4gIAkg
KiBEZXBlbmRpbmcgb24gdGhlIElQIHZlcnNpb24sIHdlIG1heSBvdXRwdXQgYSBkaWZmZXJlbnQg
YW1vdW50IG9mDQo+ICAJICogcGl4ZWxzIGZvciBlYWNoIGl0ZXJhdGlvbjogYWRqdXN0IHRoZSBk
aXNwbGF5IHBvcmNoZXMgYWNjb3JkaW5nbHkuDQo+ICAJICovDQo+IC0Jc3luYy0+aHN5bmMuc3lu
Y193aWR0aCA9IHZtLmhzeW5jX2xlbiAvIGRwaS0+Y29uZi0+cGl4ZWxzX3Blcl9pdGVyOw0KPiAt
CXN5bmMtPmhzeW5jLmJhY2tfcG9yY2ggPSB2bS5oYmFja19wb3JjaCAvIGRwaS0+Y29uZi0+cGl4
ZWxzX3Blcl9pdGVyOw0KPiAtCXN5bmMtPmhzeW5jLmZyb250X3BvcmNoID0gdm0uaGZyb250X3Bv
cmNoIC8gZHBpLT5jb25mLT5waXhlbHNfcGVyX2l0ZXI7DQo+ICsJc3luYy0+aHN5bmMuc3luY193
aWR0aCA9IHZtLT5oc3luY19sZW4gLyBkcGktPmNvbmYtPnBpeGVsc19wZXJfaXRlcjsNCj4gKwlz
eW5jLT5oc3luYy5iYWNrX3BvcmNoID0gdm0tPmhiYWNrX3BvcmNoIC8gZHBpLT5jb25mLT5waXhl
bHNfcGVyX2l0ZXI7DQo+ICsJc3luYy0+aHN5bmMuZnJvbnRfcG9yY2ggPSB2bS0+aGZyb250X3Bv
cmNoIC8gZHBpLT5jb25mLT5waXhlbHNfcGVyX2l0ZXI7DQo+ICAJc3luYy0+aHN5bmMuc2hpZnRf
aGFsZl9saW5lID0gZmFsc2U7DQo+ICANCj4gLQlzeW5jLT52c3luY19sX29kZC5zeW5jX3dpZHRo
ID0gdm0udnN5bmNfbGVuOw0KPiAtCXN5bmMtPnZzeW5jX2xfb2RkLmJhY2tfcG9yY2ggPSB2bS52
YmFja19wb3JjaDsNCj4gLQlzeW5jLT52c3luY19sX29kZC5mcm9udF9wb3JjaCA9IHZtLnZmcm9u
dF9wb3JjaDsNCj4gKwlzeW5jLT52c3luY19sX29kZC5zeW5jX3dpZHRoID0gdm0tPnZzeW5jX2xl
bjsNCj4gKwlzeW5jLT52c3luY19sX29kZC5iYWNrX3BvcmNoID0gdm0tPnZiYWNrX3BvcmNoOw0K
PiArCXN5bmMtPnZzeW5jX2xfb2RkLmZyb250X3BvcmNoID0gdm0tPnZmcm9udF9wb3JjaDsNCj4g
IAlzeW5jLT52c3luY19sX29kZC5zaGlmdF9oYWxmX2xpbmUgPSBmYWxzZTsNCj4gIA0KPiAtCWlm
ICh2bS5mbGFncyAmIERJU1BMQVlfRkxBR1NfSU5URVJMQUNFRCkgew0KPiArCWlmICh2bS0+Zmxh
Z3MgJiBESVNQTEFZX0ZMQUdTX0lOVEVSTEFDRUQpIHsNCj4gIAkJc3luYy0+dnN5bmNfbF9ldmVu
ID0gc3luYy0+dnN5bmNfbF9vZGQ7DQo+ICAJCXN5bmMtPnZzeW5jX2xfZXZlbi5zaGlmdF9oYWxm
X2xpbmUgPSB0cnVlOw0KPiAgDQo+IEBAIC02NTMsMjcgKzYxMCw1NSBAQCBzdGF0aWMgaW50IG10
a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiAgCQlzeW5jLT52
c3luY19yX29kZCA9IHN5bmMtPnZzeW5jX2xfb2RkOw0KPiAgCX0NCj4gIA0KPiArCWlmIChkcm1f
ZGVmYXVsdF9yZ2JfcXVhbnRfcmFuZ2UoJmRwaS0+bW9kZSkgPT0gSERNSV9RVUFOVElaQVRJT05f
UkFOR0VfTElNSVRFRCkgew0KDQpkcm1fZGVmYXVsdF9yZ2JfcXVhbnRfcmFuZ2UobW9kZSkNCg0K
UmVnYXJkcywNCkNLDQoNCj4gKwkJbGltaXQtPnlfYm90dG9tID0gMHgxMDsNCj4gKwkJbGltaXQt
PnlfdG9wID0gMHhmZTA7DQo+ICsJCWxpbWl0LT5jX2JvdHRvbSA9IDB4MTA7DQo+ICsJCWxpbWl0
LT5jX3RvcCA9IDB4ZmUwOw0KPiArCX0gZWxzZSB7DQo+ICsJCWxpbWl0LT55X2JvdHRvbSA9IDA7
DQo+ICsJCWxpbWl0LT55X3RvcCA9IDB4ZmZmOw0KPiArCQlsaW1pdC0+Y19ib3R0b20gPSAwOw0K
PiArCQlsaW1pdC0+Y190b3AgPSAweGZmZjsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4g
K30NCj4gKw0KDQo=
