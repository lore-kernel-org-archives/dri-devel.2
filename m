Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C572C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EDD10F280;
	Fri, 28 Aug 2026 07:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Rl29+lZu";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IuxnQHah";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA3510F280
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:13:07 +0000 (UTC)
X-UUID: e9ba0cb4a2af11f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Xgsl7gB1WjICr0TKd2A0/7Zuy9gAy9qVSujd6TE2qVw=; 
 b=Rl29+lZuCd05JkBc97KlnZoXbDhlgnFkTKcA/ebX+zqFQYKaavbnx/+iuD9bSxiBFjKzKh7AKV/+n+Ipt8QrdZrd9Fxpc+Ch8oe7/BjqWMJAy7RE+HNvnn9Tq/kCQKRczMoYByur8H3xY1lyG5kVfBI6qTxlA/9wuzhaw0zwc5Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:698d383b-00af-4595-88c0-0adc2d4b090c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:3ca84566-12a5-4d70-ac8b-bb56e33b3fc6,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e9ba0cb4a2af11f1b1788b6acf885367-20260828
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1830118184; Fri, 28 Aug 2026 15:13:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 15:13:04 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 15:13:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfCjKP25Q/UfGTZN9sDI1nApRuY/xMZ8dOalnKQ85+L7Je4NpMr4b/WBlpfXmqiFKZ/stUoExLAMT1zowQS43dT+FBuoCwMwRRpPsJKvZG390+Gea85rELLJpXzGg5pqCM/DcQWXVKReg3DiT0qd2I+XYlWUuCbd52wWc5bHbxX8FtV/ArkPkxhbFuHbCjy/fmSwyEGJLFg6koIzaSLydcw6g3ZNIPabYfQAG0dgS8yOQ/ttZBcR/soNR7FgHX9CYF8B1UmO3BbReSH5ff2g1SHYY93PeS4nsyFlwTsK9I7khhhKbu/g1lMezhqfWmHRWZ8zy8LcaD/s4kHilYdj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgsl7gB1WjICr0TKd2A0/7Zuy9gAy9qVSujd6TE2qVw=;
 b=TsEitUgcyGjNgWV8AaXe78hAuLvf4/24D7ej3Hq6YZdZLix2DnBy3yyK6ECia1jqssLt61vlYEq3KbhAtUAUngZSFJ4FsDD1v5Jklhh9jiU/zh4Uowe0xV9+GogSpKulVqmsuYWiVqDkcdqonvM/PXt+ui12uo0Hnruy5EhQmWaFVSkFNJAnEYF25H9DS5k5i8BsZlO83Bb/n0goxpKB8h4BWtPks5ZNptarOmDPCya8SiYKPY57HL9QXzfx5aG5YEDj9XMWgAuWS4CxBMx7HpJljDcOD0bxZz9I14F5NPstYNW4a0KBSB2Fr54tkLx5SbryAr2gb5YFSGI/l4j3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgsl7gB1WjICr0TKd2A0/7Zuy9gAy9qVSujd6TE2qVw=;
 b=IuxnQHahMWE5MtEoneCiwFxUcHXNAetiuScpFGl621OscMZ/WFwZbSLQT4qPXm5y4qH+ZTBR8wnypoo+lo9L2exoOQE5EXKF6q6+7m+q+DTwfF9uhYmYk3ZRJHcfiz50kDQUF+L8/jBlurEufqcJS5hHuon7dZrxD2dDtlapGsY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB8654.apcprd03.prod.outlook.com (2603:1096:4:24c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 07:13:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 07:13:00 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 11/12] drm/mediatek: mtk_dp: Add support for eDP1.5 IPs
 and MT8196 SoC
Thread-Topic: [PATCH v4 11/12] drm/mediatek: mtk_dp: Add support for eDP1.5
 IPs and MT8196 SoC
Thread-Index: AQHdD5avUekwY68WskqDPbbSy8blo7azWiKA
Date: Fri, 28 Aug 2026 07:13:00 +0000
Message-ID: <120af9d72c11d3a00efd39fd0ff69911b2b318db.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-12-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB8654:EE_
x-ms-office365-filtering-correlation-id: cb1e50c2-f796-45af-e69c-08df04d3cb5b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|42112799006|23010399003|366016|7416014|1800799024|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 1mutBh+M5ePcnwZr3wsY16RA4MXJJnG7XZklmaSBHYwWYUe8GdY4Nnz/1cWDSDS46F6Gs3+bPqSBmLAVIQ/voGiO/g7hfNLsiHQoheIuB9/4eGkTl8HvhVc/5t0SqzpUZ+Fz2H1jUjIXkl8JmfC/XAy0xWVN4q7HqMemERxIDQoOAjrG9HYuF+jqFQsI5Pq4VJtrBHyqmk5ulkzrV8EITLB0n4GSiGY+Cns+CW99PMvOTzU7U1A2irBtHn4B28kbNPLSrzCLP6gWLcjDt4vip1+Z4rL7Bagc1sFr0cgxVjt9hD4drMm2E/DoZMEgVb+zGKS0xB2KlbZRqNDzByrvvAheXXIqg5dbZ22NR+6UdwAd9FnDgC63wQeK8NkZiQRPFLx+1ZFJ7M8UAiLTT6eQwKreCS1nZyMMFRSGHmQlX4alLD0700tV6/IJKO0vbo0RA09I0Tbcg/YySjL7O9Agxrmol+YIlG7rYWQoNjD/fxVUybtNu/y+UgA18q1uogohDNas6TQGWjgDj19KzuLuZMBras6IXU2J8hraFJ5Hgtuojjw40cyUeL5jWxKUARXI4OsY/Q4qhhmPmhZfWzZx1DbpoGsnS0IA+9RssFScs+7ni05rQOLV0gxCgF9wLC8Rov0V5apiyDg6XCw9O5a901e8wishCQoL6md14d51cLxXOS5nao270jqYgtrMJjaezCdAHjc6qnV0mjUbM9PBXSILClJDJn0ixn9IogZDXDs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(23010399003)(366016)(7416014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTE3MkF4RGZsbWZLTEw3NTRFRkgwV2NKQVpQSHBmdWlmYml2UXZidkpiVitX?=
 =?utf-8?B?eUtNVGV0ajl5Y2VrVHdlWTgzU1M1UGNNMnRFYS9lYXJwQStUZkNZY09mY09F?=
 =?utf-8?B?U3JXak1paVhpcGtsMjF5S0dYL05nNWlXUFVzbHRKNHJGdUdYaHJtdUcrZ0VC?=
 =?utf-8?B?djBWaDMrRmZxWFhBNjB4dURlWVovUG96cHh2c1hjcFZrYTRDTW1FeUlpTWtj?=
 =?utf-8?B?NnJRditEME1CZjRMUDdpZjZuUW1GcnFqaElkUVlockJMTGd2Z3I3Vzk5RUVl?=
 =?utf-8?B?OUJVYWFVa2g5dlhKbFAyM0NZUmtGeTRaUzI1dTNKeW9zbEhTYW5CWDRIT3ZB?=
 =?utf-8?B?VFBYNkNsUjQ2R2hneHJobHFWK2FQdCt1dlU5Q21iL1YyNGtVZlpxUkRFSG5S?=
 =?utf-8?B?ZTluTUVzVWpidUtjZXVWei9ONjZwWlY2TEt6dzlkTjJzOFZkZExIamNTTGJH?=
 =?utf-8?B?WmlQTHZ3NVlyRHYrVXRsS2RqMVc4dVBybHY3aFlrMFhZTnU0dzdiUXJ6RVJ3?=
 =?utf-8?B?TitRM3dYODlVTERXRXQ3T3BWMmRNMmYwSU8weGN5RTNablNhZVRMb0FVMHZ2?=
 =?utf-8?B?Vjl6SHZKTWhnR1BuK3l4bExWOUU4WVhVYkJDblBKaEVrVXQ1YTZ3bVE2WVFz?=
 =?utf-8?B?UU92bDhqLytpTzJnd2dPKzhaNnk1anFveWtXYXIvOEJZM09Rd2w0emlkc2x2?=
 =?utf-8?B?djBFRWRWOG5oVXp3SUdLMGp3QU82aEFERFBOaFVvc1Z1VXpjc2JtNWRiWmpt?=
 =?utf-8?B?QThDaklqWlVZc0tqUTY3TDdjNkg2RzNoL0xVbldITlZsWmZXYVNORzJZUGFr?=
 =?utf-8?B?L1VhSVNaYmpMQTNEMFI4VUkvQmZZLzlsRUJpR0dGV3lOcG1EcWg5OENLcEJx?=
 =?utf-8?B?NUlXck1sVnZDWWJ6M3A0RUJUUGNWU1ZMUEJmWkZmeExXUXl3cElKOGx2aU5B?=
 =?utf-8?B?VS9LdHBjU1dvZXY5a2VWenJ1VHE4UUxHMTJKNHByT3FQNTdmeXorck4zZndy?=
 =?utf-8?B?RXkxM1g4R0FnOC9IV1JPV1NVcnBwVmpacWxyakZMbkFMWGNaK24rZzdIdVFN?=
 =?utf-8?B?bzI5QkFKVi9HRWs1d3VZeXlEaEExTUxhUklrUnpLOENGa0t1bDRPUmhaUmo3?=
 =?utf-8?B?NkIzdTBGbDlmWXR4RU84TTBHNHNaTm5BWWxqYjNjL3RpV3NabE9Gekk5V0ZF?=
 =?utf-8?B?aWQvcW5pQWx4WWhrS1ZKbnNSUFA4RUNwWWpHNlVxKzhrRGVwTXUreVhzY0k4?=
 =?utf-8?B?RjdWZHdHemtpNkwvdUZUc1RvemlIWmp4Ky9OdXFNSVdyNld2L0hUZ3NGR3Nv?=
 =?utf-8?B?S3V0UUlObkxpV1IvV3YyY0VPYkFxK0FOazBBckJ4dkJ0emtod1VLL0Fadllx?=
 =?utf-8?B?WTRwMDZZcGZsMlFoYmdOYWUzdjNiK3Npb29XWU52UlNDWDhwdVBId2ZISWlq?=
 =?utf-8?B?QzJ1R3VnN0NzSTN4aXZyTkxYR044NXNUTCtxZWl6SFp2SC9EKzhJUzhVTWdl?=
 =?utf-8?B?NXZJQll2V1p2N0tyMjQwcnpkeXp0eGJCdUZicnRXSEJtekNRTXc3bXppVUs4?=
 =?utf-8?B?amxxc0tJL3I5eHF4aXhQOUtKZ295MDlmSXp1R0t6WXdiaFJ0UTNOZVUvUEd5?=
 =?utf-8?B?RytlZ2pUOWpOdkU2TE1Ld1RncExFRmFHMmc1UUtjSW4zNlczY3Ntd3lNeXFF?=
 =?utf-8?B?amE5a3ArSCsvSmxlV0ROK0RYNXdEVm10RkhEcjFQNVNhWlBBVXRiYjhRb2p5?=
 =?utf-8?B?cmJ6V2k0SUxQTzR0akJXZ0h2enArdkw1TVNvRFpYNFFaZXZOSS9UWWU1SUpx?=
 =?utf-8?B?ZDlLUVVMR2l1K012bTVaNXdhZ2FzOUhvNDhpa0VZeSs0WHpQSHBqMmloUW1S?=
 =?utf-8?B?RDA3dVBVQWk2bUxVVlNxWmp5Yi91cnY4L0dwUG9YUWx6UVkvMFZnZnREMEV3?=
 =?utf-8?B?cVQ3SWFoMlA1RjZucWI5WnAwWVoveXRFMVN4dXJmaEdDMTk0UmxKeDUxSU5r?=
 =?utf-8?B?VEhRVnVxUHpHQ2hUcnpGU3dVckJZVTJrYm5xVFFYcUgxK1lEbzlCSmx2bEk4?=
 =?utf-8?B?L2tVc1haazBVcVdkVXdHUHFpQ1F3RGl5d1VSREwrYzZER3dMZlpFeW1UclJ6?=
 =?utf-8?B?cndIazVzQjNVK1lYZnZMYWdHQXd3eTkzVWdsbDNiRm44MTVvS01XblZpdUhB?=
 =?utf-8?B?V2NGYUg1eklJcUZTVDBZSkpwaDlkMGRGRU1DZzhid0hKOVNZZXprTnA5VVdl?=
 =?utf-8?B?TnhJVDhQSVR2dzVhcC8xa2RWUTB5QVp4QS9GRVFubVQvL29WL0hTUUJ6d2cr?=
 =?utf-8?B?aGoyMGt3RjdkTC8zRGI3NytBZ1pGY05IS1M4c1FjSTRIWkJUSnQrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E9A98EBC2C2CF4194393C053C6188FB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j6Wcrpo7PrM3ospbRRaUZ+HC1TxuXeLaiOmPyff4X55BEidT3nt7SLptITJ7n/ez4D3iBw1yipscuP3xgfB6xHv8cafwcLTMz80GTPdyp3gf7+ukyPEsOMorgWfyHuZEnC5U3dYEkoesgglVGbrlTjF6nsXvfV65DNHywj8/5iCfJxnWN1O1KQ3UMn1sULSucFIqNlZGrgPGV2FN0LFlF+iXXPj3s8hNncWgXbUnQboQ0+y8/+C5T1ynq7dj0NmRnxRmvmppRNAN72lIf9z5N1v7oOFXCOHJhhdlx4Qu8u7+KifkENXier1A4Iu63M9Lcw00V1vqmf/M8wvujBpnqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1e50c2-f796-45af-e69c-08df04d3cb5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 07:13:00.6261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H33c33Xg1i0WZ9y47VVzD+2NhRGIh/ojED5Iro2gL+4+SGJh+UsYj7bRq/EadaixDKrLdA6JsUbN6dx0OjnSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8654
X-MTK: N
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIE1lZGlhVGVrJ3MgRW1iZWRkZWQgRGlzcGxh
eVBvcnQgKGVEUCkgdjEuNSBJUCBhcw0KPiBmb3VuZCBpbiB0aGUgTVQ4MTk2IFNvQyBhbmQgb3Ro
ZXIgdmFyaWFudHMsIGFuZCBlbmNsb3NlIHNvbWUgb2YNCj4gdGhlIG5ldyByZWdpc3RlciB3cml0
ZXMgaW4gc3BlY2lmaWMgcGxhdGZvcm0gZGF0YSBib29sZWFucywgYXM6DQo+ICAtIFNEUCBvbiBF
bmNvZGVyMSBjYW4gYmUgc3VwcG9ydGVkIGJ5IGJvdGggb2xkIGFuZCBuZXcgSVBzDQo+ICAgIGJ1
dCBpdCB3YXMgY2hvc2VuIHRvIHVzZSBFbmNvZGVyMCBmb3IgU0RQIGluIHRoZSBuZXcgb25lcw0K
PiAgICBpbiBvcmRlciB0byBkZWNyZWFzZSB0aGUgbG9hZCBvbiB0aGUgc2Vjb25kYXJ5IGVuY29k
ZXI7DQo+ICAtIFBTUiBjYW4gYmUgc3VwcG9ydGVkIGJ5IG9sZGVyIElQcyBhcyB3ZWxsLCBidXQg
d2FzIG5vdCB0ZXN0ZWQNCj4gICAgb24gdGhvc2UgeWV0IChyZXF1aXJlcyBhIGRpc3BsYXkgd2l0
aCBQU1Igc3VwcG9ydCBjb25uZWN0ZWQNCj4gICAgdG8gYSBkZXZpY2Ugd2l0aCBvbGRlciBTb0Ms
IGFuZCBJIGRvbid0IGhhdmUgaXQgcmlnaHQgbm93KTsNCj4gIC0gUG93ZXIgU3RhdGUgZm9yY2lu
ZyBtYXkgbm90IGJlIG5lZWRlZCBvbiBuZXdlciByZXZpc2lvbnMgb2YNCj4gICAgdGhlIGVEUC9E
UCBJUCAoaW4gU29DcyBuZXdlciB0aGFuIE1UODE5Ni9NVDY5OTEpLg0KPiANCj4gQXMgYSBub3Rl
LCBldmVuIGlmIHRoaXMgZWZmZWN0aXZlbHkgYWRkcyBzb21lIHBhcnRpYWwgc3VwcG9ydCBmb3IN
Cj4gdGhlIERpc3BsYXlQb3J0IDEuNCBJUCBmcm9tIHRoZSBzYW1lIFNvQyAoYmVjYXVzZSB0aGUg
RFAxLjQgYW5kDQo+IGVEUDEuNSBJUHMgaW4gdGhpcyBTb0MgaGF2ZSBzb21lIGxpdHRsZSBjb21t
b24gcGFydHMgaW4gY29tbW9uKSwNCj4gdGhlcmUgaXMgc3RpbGwgYSBsb25nIHJvYWQgYWhlYWQg
dG8gYWN0dWFsbHkgZW5hYmxlIHN1cHBvcnQgZm9yDQo+IHRoZSBEUDEuNCBJUCBpdHNlbGYuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lv
YWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHAuYyAgICAgfCAyODkgKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmggfCAgNjEgKysrKystDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDMxNSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggNzcyYmEzMTFhMzRhLi5mZTdl
MDVlMjdmNmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTIsNiAr
Miw4IEBADQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IChjKSAyMDE5LTIwMjIgTWVkaWFUZWsgSW5j
Lg0KPiAgICogQ29weXJpZ2h0IChjKSAyMDIyIEJheUxpYnJlDQo+ICsgKiBDb3B5cmlnaHQgKGMp
IDIwMjYgQ29sbGFib3JhIEx0ZA0KPiArICogICAgICAgICAgICAgICAgICAgIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+
DQo+ICAgKi8NCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kaXNwbGF5L2RybV9kcF9hdXhfYnVzLmg+
DQo+IEBAIC01Nyw2ICs1OSw4IEBADQo+ICAjZGVmaW5lIE1US19EUF9UT1BfT0ZGU0VUX0xFR0FD
WQkweDIwMDANCj4gIA0KPiAgI2RlZmluZSBNVEtfRFBfU0lQX0NPTlRST0xfQUFSQ0gzMglNVEtf
U0lQX1NNQ19DTUQoMHg1MjMpDQo+ICsjZGVmaW5lIE1US19EUF9TSVBfQVRGX0VEUF9TRVRfVklE
X01VVEUJMzQNCj4gKyMgIGRlZmluZSBNVEtfRFBfU0lQX1JFUV9WSURFT19VTk1VVEUJMHhmZWZk
DQoNCkFsaWduIHRvIG90aGVyIGluZGVudC4NCg0KPiAgI2RlZmluZSBNVEtfRFBfU0lQX0FURl9F
RFBfVklERU9fVU5NVVRFCTMzDQo+ICAjZGVmaW5lIE1US19EUF9TSVBfQVRGX1ZJREVPX1VOTVVU
RQkzMg0KPiAgDQo+IEBAIC0xNjgsNyArMTcyLDExIEBAIHN0cnVjdCBtdGtfZHBfZGF0YSB7DQo+
ICAJYm9vbCBhdWRpb19wa3RfaW5faGJsYW5rX2FyZWE7DQo+ICAJdTE2IGF1ZGlvX21fZGl2Ml9i
aXQ7DQo+ICAJdTggaHdfbWF4X2xpbmtfcmF0ZTsNCj4gKwlib29sIGh3aXBfdjFwNDsNCj4gIAli
b29sIGF1eF9ocGRfc3VwcG9ydGVkOw0KPiArCWJvb2wgc2RwX2VuY29kZXIxX2VuYWJsZTsNCj4g
Kwlib29sIGZvcmNlX3B3cl9zdGF0ZXM7DQo+ICsJYm9vbCBwc3Jfc3VwcG9ydGVkOw0KDQpCcmVh
ayB0aGlzIHBhdGNoIGludG8gaHdpcF92MXA0LCBzZHBfZW5jb2RlcjFfZW5hYmxlLCBmb3JjZV9w
d3Jfc3RhdGVzLCBwc3Jfc3VwcG9ydGVkLCBhbmQgTVQ4MTk2IFNvQyBzdXBwb3J0Lg0KDQpSZWdh
cmRzLA0KQ0sNCg0KPiAgfTsNCj4gIA0KDQo=
