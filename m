Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=YzvDODUI;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=DGkEKbH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0E810E190;
	Tue, 27 Oct 2026 07:55:07 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752E110E190
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:54:56 +0000 (UTC)
X-UUID: b11da8c4d1db11f1b1788b6acf885367-20261027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=onSePsilSkdACmrl6i/2aaYzmcd2fh3dioaqn5KfHok=; 
 b=YzvDODUINhnD1J23whHU4tdC0Fg0A/ALxR5gMPz+ORsEz+Fs6ZoeYyp0DknMbDEJH6sFB8qZLZlr9PTbdYii7FXe0Hb111vxJjD7MIH8dqBvG30nvFuKx3rguc6DulWll5nWwm90F6MTp7wabtFq6sbl8IpaRfDkcrr60gtIg/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:5ad87b1a-5742-488f-90a5-fe2d2295d0e6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:f3e9703d-7132-4bd9-9ada-f79a4f8833bf,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b11da8c4d1db11f1b1788b6acf885367-20261027
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1430694022; Tue, 27 Oct 2026 15:54:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 27 Oct 2026 15:54:51 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 27 Oct 2026 15:54:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvKCCGTQAEMY7IA1S83FMNVRTJTB2+avyWGSsiENji2AlpLzEgTy7myawx7OljiaZdbCPFP+eb68R7D3SJvI6UATEZkV3bzb+qfR1+P4PTe3lszmPQQGeeZMAepVTydMJr87a91e5FtiPdpD0olc3Hj2y/rzjMpN8C78QT9rXsu8WpriGDdsepMhKXsXnZZcgolz6MQa4x0hhDYIs3bTVKwZ+ZW6HaxvSMK8yzAuVIuGIVHHyBxC63h7lcu9Jl+FkbmJX+VP38QCVjmcMytHUniOwULw189zfD0LQNhPd2bsykhaMHSQRZU8Sq7Jz1xdEfBSa09zHZccfopk5puBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onSePsilSkdACmrl6i/2aaYzmcd2fh3dioaqn5KfHok=;
 b=QMLzgfYCpu9fyRqAel+IkjO7XdA0OcUqbQpuJsW8zGBg122/RUFurxx++YDLmqzcgNWne3Z+ZAzB23Z45VSPOTSymcwd0fqENMZYTHj/sIR9TT0vWK25aLvjykQTHQxE8b9or9zlKwMtl3gI1tWLOLaElsP0jjrqbJDtenEPFfsFheYhnD8Bm/YNthuf1KRvCnfoS7WKYgQteJa3RAGZO/Ol0YFMBR4d9Hdft34h5ZSSDsFNam8V9hgp4EwbXPyhswA5WarvKh668qTJLxOVhLLoMgiBy9366qlQD8q20/Bw+TabUqh8i3p0iK3RSBm5DJNZlXtBhlauym0mdcP3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onSePsilSkdACmrl6i/2aaYzmcd2fh3dioaqn5KfHok=;
 b=DGkEKbH3XNW/iDelyKqCtkyOuyMGhKUNMEM+cTYszLMkLbgwbJiMxhlfINloRD2BZ+IEKHw8Ly9m12Al7d59wMhcUny4lyJRnchKskMylN0JxP4PixreD7zVQKwRw4o3exki0LueVxWFYbTCzs86AzZAVs2pdLs46ErJF63zgCg=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KUZPR03MB10145.apcprd03.prod.outlook.com (2603:1096:d10:89::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:54:48 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:54:48 +0000
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
Subject: Re: [PATCH v2 09/46] drm/mediatek: De-duplicate internal component
 checks
Thread-Topic: [PATCH v2 09/46] drm/mediatek: De-duplicate internal component
 checks
Thread-Index: AQHdE4ZSc9ZIbPk0KEqTlj3SFj530bcRqdKA
Date: Tue, 27 Oct 2026 07:54:48 +0000
Message-ID: <1ed3eedf98dc39a5408f4792b7c6de0f07141dc0.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-10-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KUZPR03MB10145:EE_
x-ms-office365-filtering-correlation-id: 6ee7f2c5-0697-45a8-f3aa-08df33ff92f9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|42112799006|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021|261026140227099003;
x-microsoft-antispam-message-info: n/0v/0iZpEqnv68bjNca//uwRHEFuE0wtxnLj5cNUsNxassfRaj2QP232BrG+CBmadXpDwlIk+XKlwTSDVJC9yPHUoifyvixSMIMj/JsyNWhP6Ovz9LQJBdCx/fPnjFmbq+ARzkF9S7hvN7QzRn86fvT1bBsvomBzA++BW6+S8hepwwFmB+G511xqziHLwB7LJlNTTiwtN7mvJVw6EnnIC2ESEosw6N1CfpyCgjn8ZBMDMpetFg2VRweWKLmmfGczDUqVWbLmcoPCAC7hjn6yXksmqfqCKXdQRNVG81PlDgggvVjsg7wSjH33uDqWY8U3At+nqDy9eIZwudgjQwehtbazAfSLY+1l6Iaym9ZmT3jFVCJOVJ/WtnFnNz3LnUdhtWd7gZEpEeysS1zz/LUIIqURWOiutPXi15TdJGUQfiEbDSuYDjvZfJd0/7TP4+6kOQt/y8gtv8HwkJWng08ZQRGi0lxVSFfGQ0rtAgeN+a2I3PPI3zYSCmhe0sgM1GIvUX4yqTw8CaGNn6QFxDy31aNZ7sbcRkxwT2jP7QAErJ7SiPfftiTEEo39tR0nGl21MFXPdoi14v8oGg51LWvgvkBRo47QFlSyGlUQP/lBBtnEBhZKZ+kPMYX0bCnISBan8FbzFrwNO0Rrk/74mjpbaSs22Xc+OIOQwJvsgNRUSpJRC3AsmwTro5Bn8icB2D/UlpQLnvxKDIrqw9Hm30r0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(42112799006)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dMYVQwS25adXhNU2ZtV2JnbEpYWU9UZTNpUkNyaGxPWFpnS21wRW5ZSk9I?=
 =?utf-8?B?N2ZsODdSdlh6ZzhXSmFQTEk4Y29Fd2poVDM0RGdneHdkUHJaZnQxT1djZ2tU?=
 =?utf-8?B?WXlKN3hFWE5rTWtLUFNJL0k2N1doZU01RjJUTnVBRWF2Uk9qd0ZwQ2JqMHY5?=
 =?utf-8?B?N0hSVTRFVXBDYTBSZERtUEo3Q0hEc3JJRGhRME9WMXZEZXp3TU45YWhpUmdq?=
 =?utf-8?B?TktOV3V4ZVFKYWVFSXl2TUpSRnNYaHltajBld2NVay82c2NzOExEWEJsWGF6?=
 =?utf-8?B?a1ZESmQydm1GOW90U0VJMHROcGF0Y0FEY1hTb0tFd0ZYNmo5V2FFeTdoVUdO?=
 =?utf-8?B?OFA3TEhzMjc0ano0TVBQTkk2ZlhCOTczVXJPbWs1YnJnNk1pSzNQSFA0Vm81?=
 =?utf-8?B?bVlQdSs5eEMwbWJGRjVMb3JOSzlVRG1jck16dm9Mdk9XWUdicTZyL1hxSUpC?=
 =?utf-8?B?TjZoUnlZK0tob1lhY1ZtN3lSQXU2QzJPdUZqR1NRL3JMTVdQOElXeEc4RzdV?=
 =?utf-8?B?VWM2cHBieWxydisrUWF2RW9MdENrbWNoRnVmbHpWUkR3em94YkFrSW9MUXRU?=
 =?utf-8?B?UllMa0kxYmNuSWxDZ1ZSMUhWcVd5OCtJRE5BSXd2M2tvR1NZT3FXSXhtRW5k?=
 =?utf-8?B?aW9TK2NCSWVmTFNnbmJWRmt6UWYzbzNJSlp2d2YrYVNkQVBNalpZZUQ5UjR2?=
 =?utf-8?B?MUliVTdOeVhGV1gycnZ5bWg5SzB0Ymt3ZGpUc3AxNTNDVG9xREVMQm9La1Zi?=
 =?utf-8?B?S0x4WGg5ODFYNEluOExLZ3FMVk5Nam5Xb2Fnc01OeWpYbkU5bEJubXBLb0Vl?=
 =?utf-8?B?NjA0bFRtd0ZRVkc0eFBtL1BUMUZkR0RTOEwxTytFUkwySGJzeGFvUnhiU3lI?=
 =?utf-8?B?aEFXYnhldHBabmR5OHhRQ3FQRTViM0pmUWhHaU0wanJVQTg0b0k1VkZ5NDE2?=
 =?utf-8?B?SWVwdWdGb3hlL3NLR1oyNHhnT1ErWW15bmM0NkE3MjVjNitCRCt2WEZtd3ZU?=
 =?utf-8?B?bVB4TU5ZMlV2bnFQdS9LclhpREtMNUJNbndaWUwwOVdrdEk3eldkMXR5MlNi?=
 =?utf-8?B?S28yN1dUNWFCRzh3VnRrZzZVdEVzM2xwVlhIVGpKemxHZXhibGtuN1ZpK0tU?=
 =?utf-8?B?WTNZNGFEQXdxelJLbHNmdmR3clNiVU03WEJoU21iS2tpUjlVL0s1V3V6NndR?=
 =?utf-8?B?Nm9rODRtUlIwNmxRaUN1Q042QUNDa1hRVjhLRndlak05cmt4b2dwSUZib1Fs?=
 =?utf-8?B?V0FXNzVPeTBMRFF4YlFEUHR0elhKNUtkcm96a2FYbTBaTXNTT2Vsc241aW1I?=
 =?utf-8?B?QUpPM2FubUNBSXF1aGpaTDlGSGdJUW5Ub0dpWi84a29CYncvM20zc1pFa1ZV?=
 =?utf-8?B?ZnZSUTRLUnFIWDZ6eWlEdlpDOEdpUXhLVHdtWTV5aElPUjBUYUFydEpUR2Rm?=
 =?utf-8?B?eXA2OStlQkpja2R1UkZpQ3BPRGFURW9VMUIvaGtNeXIvU2VqRHlXUEdNeFh1?=
 =?utf-8?B?c2xSZ0hpblRvcm12elowckJpR2hEMzBkNHQ3S3MyM1kxSmhrbSs0N2ZQR2NL?=
 =?utf-8?B?M1dyWHJSRkY0QWFlYUsxcGZnR2g4NHVDMVRJbnJvNVZkRXhMQzJ2MW9kUVlh?=
 =?utf-8?B?MmcrZ3VoSFltcmR2K2dyQldVS0tLUjNHTm9Lb0ZaOFJ1RytnWHhySHVCeHgw?=
 =?utf-8?B?QVRRTVRDcWcwaDR4TkRFajdhbllpS25VUSsxQURNbkhESDQzVFI4QmNwWnpk?=
 =?utf-8?B?eFRkdlBCVm1UZGk1azVNUmtnYXNzU2I2VDdZZXdPVCtaWHcwSWNMNUlaMDFD?=
 =?utf-8?B?WWxRL2lydTlzT2o5OERkT1J3Q2NEdFlRZ2Vpd1FESmdlWEgxSUIrZFpBaGJE?=
 =?utf-8?B?VllhTVltVGRKcDlWa2lyaGNtSUlSU2Y1ajdjUkdDU2NlRm1zVUt0Q1hVU0Jh?=
 =?utf-8?B?NE9hV2tWd3ZuUWx2aDBBWUUrWlZvY2xON3UzeFVaR0RHbXpEUjlPZzAzT1Vm?=
 =?utf-8?B?TFhKOFhQNVJjQmFORmZPRzRDTUJrazRxZForak1vRnRLcFpDWHdXQmVTd2ti?=
 =?utf-8?B?c211MkZDMXIyMmNSaGsrZmtDN0piM3VwTEZ1WXBqMHJmd1V5QzNYRERKU2tx?=
 =?utf-8?B?bXhWbE5PMFJLR2FTMHFIT0ptTzRjOG5wSVZFTldTTExVQjd3dk1WOFNkc3hG?=
 =?utf-8?B?Ty9YYkdYbjN6TjR6enZNZzE3NXVtRTRnYjM0U2FoSElVMnBTSnB4Mm1hQVh4?=
 =?utf-8?B?d0EvR0Z3TUh6UGdCaWprb253NlBOU25qUjh2QTZRd2trN01OZHNoRjM1anhJ?=
 =?utf-8?B?YVNkVmc3N3BmYmE4OTljT1YzWit6dG1DaGcvakg5RnpNdHNJY3hBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8059012E69334144BFA1D4FE911C1280@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LLQCXj0yl5vb8tggrWJx43mt/7A4IYNS/APzqf3sH1v3e13LSONSk2F/gB8DRN9lk5EZ5JBsTGdKuYltqdxpayb4nfjw4afcCruS2A5yhJdENvA3rVQ2ceLWUVaYbmDiwJuuuyfDcwfUnQzG4i47lpZQnLrKYxOvwnxmTX1nWPPHDXvroWuL45WUxvkws4Y0oqztszrFB/uErxH0ALLpV2lPs9WKnDlH7L4W1/NWOFBSOnj/a4uvrrDhXeRimbAzzptr7F2cGN6392oqsE4cxK9E8dreCJto08m0osQ2iho6hAaZXEyOF87jv9GPXPHE7LYIhpp5OrLnxWfKXLAjuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee7f2c5-0697-45a8-f3aa-08df33ff92f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 07:54:48.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzuXZ01nHfRhGKvgVCwUe6f9emTNsR4jhSjltziTCHREOAbsSqrn3c9Z9pW0ZskjWQGHPKXb6Na5gFYOFj06ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB10145
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQm90aCBtdGtfZGRwX2NvbXAgYW5kIG10a19kcm1fZHJ2IGFyZSBwZXJm
b3JtaW5nIHNpbWlsYXIgY2hlY2tzDQo+IHRvIGRpc3Rpbmd1aXNoIGNvbXBvbmVudHMgdGhhdCBo
YXZlIGFuIGV4dGVybmFsIGRyaXZlciBmcm9tIG9uZXMNCj4gdGhhdCBkb24ndCAtIHdpdGggdGhl
IGV4Y2VwdGlvbiBvZiBtdGtfZGRwX2NvbXAgYWxzbyBjaGVja2luZyBpZg0KPiB0aGUgY29tcG9u
ZW50IGlzIHJlbGF0ZWQgdG8gYSBiYWNrbGlnaHQgZHJpdmVyLg0KPiANCj4gQ3JlYXRlIGhlbHBl
ciBmdW5jdGlvbnMgaW4gdGhlIG1haW4gY29tcG9uZW50IG1hbmFnZW1lbnQgZHJpdmVyDQo+IG10
a19kZHBfY29tcCwgb25lIHRvIGNoZWNrIGlmIHRoZSBjdXJyZW50bHkgY2hlY2tlZCBjb21wb25l
bnQgaXMNCj4gaW50ZXJuYWwvc2ltcGxlLCBhbmQgb25lIChzdGF0aWMsIGludGVybmFsIHRvIG10
a19kZHBfY29tcCBvbmx5KQ0KPiB0byBjaGVjayBpZiBpdCBpcyBhIGJhY2tsaWdodCByZWxhdGVk
IG9uZS4NCj4gDQo+IFNpbmNlIHRoZSBhbW91bnQgb2YgaW50ZXJuYWwvc2ltcGxlIGNvbXBvbmVu
dHMgaXMgbG93ZXIgdGhhbiB0aGUNCj4gYW1vdW50IG9mIG9uZXMgaGF2aW5nIGEgc3BlY2lmaWMg
ZHJpdmVyLCBhbmQgc2luY2UgaXQgaXMgZXhwZWN0ZWQNCj4gdGhhdCBtb3N0IG9mIChpZiBub3Qg
YWxsKSBvZiBhbnkgbmV3IGhhcmR3YXJlIHN1cHBvcnQgd2lsbCBuZWVkIGENCj4gc3BlY2lmaWMg
ZHJpdmVyIGFzIHdlbGwsIHRoZSBoZWxwZXJzIGFyZSBkb2luZyBhbiBpbnZlcnRlZCBjaGVjaw0K
PiBjb21wYXJlZCB0byB3aGF0IHRoZSBjb2RlIHdhcyBkb2luZyBiZWZvcmUsIGFzIGJvdGggbXRr
X2RkcF9jb21wDQo+IGFuZCBtdGtfZHJtX2RydiB3ZXJlIGNoZWNraW5nIGZvciBleHRlcm5hbCBj
b21wb25lbnQgZXhwbGljaXRseSwNCj4gd2hpbGUgbm93IHRoZXkncmUgZG9pbmcgdGhlIHNhbWUs
IGJ1dCBjaGVja2luZyBpZiBOT1QgaW50ZXJuYWwuDQo+IA0KPiBBbHNvLCB3aGlsZSBhdCBpdCwg
Zm9yIHRoZSBPVkxfQURBUFRPUiBjb21wb25lbnRzIGNhc2UsIGluc3RlYWQNCj4gb2YgY2hlY2tp
bmcgZm9yIE1US19ESVNQX09WTF9BREFQVE9SLCBjYWxsIHRoZSBhbHJlYWR5IHByb3ZpZGVkDQo+
IG10a19vdmxfYWRhcHRvcl9pc19jb21wX3ByZXNlbnQoKSBmdW5jdGlvbiB0byBjaGVjayBmb3Ig
dGhpcyB0eXBlDQo+IG9mIGNvbXBvbmVudC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBt
ZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0K
DQo=
