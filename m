Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A6606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=VPJkDWhX;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=lniAxDcl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD9A10E787;
	Thu, 29 Oct 2026 06:53:02 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2629D10E787
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:52:51 +0000 (UTC)
X-UUID: 5924d828d36511f1b1788b6acf885367-20261029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=uBb7p7eQEDWLd3XFSVNx8QV1fs0rf4gpjQ8ldTZ6ELQ=; 
 b=VPJkDWhXiGBZOGi0DZcAf/1px7orJ2ddfvdANhE2Pz/nKoGRY3JazzPvPCmupVv7Z22kKUyP6romZQp97IcBiJMHMwiHlhHTfAE7U64GytyDgB/U13rwjKnP0YIiN9uOvYwHYDF/G4aEtCtuizeOJHKtYLMD99MAPBPvS+ylUS0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:8010a073-6191-4dbe-a60b-f8ddfb5ef1dc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:a013f92f-d43b-4f85-918e-87e30e60ce03,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5924d828d36511f1b1788b6acf885367-20261029
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1143592175; Thu, 29 Oct 2026 14:52:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 29 Oct 2026 14:52:45 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 29 Oct 2026 14:52:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ommPt0OQKG+TQrBn096GneXqkPtQLAaWGrkD315XzWG6wAyHYAPi6Pwlh6M7KMybF4zjCm6rhQr0MZnuk7mDyFLe+pkyNf9pfHDSrbr8sTTgJzG3PhvqmCpuvK5hNajenP1M1IKNoQUGUtf5UJSXuqVyzPg9vEsMi6BGiAgYT/upGqEgI+aX8DvU2j+nQ+ylGoRTY01vg66kywtEiLY9n0y0MpAtKIzaDNfNzkjYF3cqc/YSFznIMLquC3b4viF+vIcnvE2kAk3CqokvDuh2HVMMIs5XXJuwJyvmFvJwIFiK9sCpwbc1RDIxE8RFh1utzommcP3e4wWyqkjYcSyAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBb7p7eQEDWLd3XFSVNx8QV1fs0rf4gpjQ8ldTZ6ELQ=;
 b=Y6OkCnA1GT6uV6KqwHo1VwSURgABf7KZBcsYnMsFX9/rHjRHMJ+7VKXE8NAKMnuLQQMuyTlkd/2me9SfpIjfXQ+D9zNFPiSsyAQYBQFG1AkcEIAMam0KZyaUYu6y8UgRRfur4D4U7w+r12hCLI0VtVTsk54iT5oFJxZUU4qULIYqoWDoZyn38cfDj4tx33viqBs1c4axw5W/GzqENq6idim33UIRm1QRTcPSPK4J4FuEAE9LbFURfdDopDkUZhSyO9EunL7bllR9o/5HyWaEd/7fLt5oMLiJ9ZMvDMh/35tK7nyk+DHvWc/RC9NvJ3PF4ua2FJtMW4hukQ+bvkVGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBb7p7eQEDWLd3XFSVNx8QV1fs0rf4gpjQ8ldTZ6ELQ=;
 b=lniAxDclRI2iFzyGNo7hyjOQ0r5DzT8odrdKwVARsUIydqXCnrBtQgbAVaXvyyiVJN3paJRT7m5o0J23XXXaPrTglj1cwuG32SyB2czJ7nzgDaeCbq6Tutfw59OVcnK+arXSiLQrY4WmE6YSqceTLhvchwlrrRjFyKRCxUbiqLU=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TY1PPFE7B509EE5.apcprd03.prod.outlook.com (2603:1096:408::a72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 29 Oct
 2026 06:52:42 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 06:52:42 +0000
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
Subject: Re: [PATCH v2 14/46] drm/mediatek: Add support for MuteX
 trigger-sources parsing
Thread-Topic: [PATCH v2 14/46] drm/mediatek: Add support for MuteX
 trigger-sources parsing
Thread-Index: AQHdE4ZeEklvltrwUUGrCT+hq7QRQLcUvSKA
Date: Thu, 29 Oct 2026 06:52:41 +0000
Message-ID: <6055e7c1b8e0db0d43a8cc296ef327b5dc6c9b11.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-15-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-15-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TY1PPFE7B509EE5:EE_
x-ms-office365-filtering-correlation-id: d091e1d4-d8d0-40f4-3f06-08df35893a9a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|42112799006|376014|7416014|11063799006|261026140227099003|261009223027099003|38070700021|56012099006|261021123027099003|261021121427099003|4143699003|261028144727099003|10067099003|261026121527099003|22082099003|18002099003|6133799003|261022105027099003|261022075727099003;
x-microsoft-antispam-message-info: 2fxz7kcMMSg62PoJWrv7Ju3XcIkiUicWnx4lFX5/ZeAHLEZR7rYOxLZqXE5L7Rux4ghHmUHAh42lZMGqH27kiPrGNFKZgAGDkN4YiJDiDQZ+9fvQbzraXNM8PabLrHz9nn6nYBBLTRz7kfrW/4/ZYxru1rSytUHlPSgGIUpDPh1MffP1ze24/V/BwAif5tIrdkTtVolkceiVhkTCq2QqTeMs+cCI52dsOQGTldhn4vEQxhhQJbaEC7E+2NH1t4LLXBRqiTqBM9YmVRa0DsyoP7tUHno8XqCP9jMsSBB6j7CNbHMNudOOhd8ku/RB5Xl/WMqhl9L9GQyEgNEBsPP0FJp7N+ztEV5gdM2sxyka7zQKS8vg7lQhM9xb8N7nvLopyJXe2qSlHDMr730JcjGtemmS6KUuYvG2F3hEtseeCs8lD/9o3h8omEw1YkF8kUqWypRU9Inhf2ZKF9ymj0SrE66/IXZairZOwtvttCH6TZCvhXUVUjxaWQ8yWnq5wgEssbt7KEGNjrIVJ5GpiieeZK0hIA3ktAoiYVP+6fbES0Z1mQ/GfSetVqgqcJM8fv5pNrYDBLFKuN7sBTzGeFEcSTFcbgr6d1daAgSSFQcbooyqYIR0Vycwy5nAO8NL+rf8lGAVHB0bdVGAmwXaRxXiQri+EtMwRipmIfW9Wzlvh9K3hQ2cu7UKBR0HGvz306VxyldtAvEnGvggz4eNH7hzqZGC4srL0xWsHv21fhYRjFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(42112799006)(376014)(7416014)(11063799006)(261026140227099003)(261009223027099003)(38070700021)(56012099006)(261021123027099003)(261021121427099003)(4143699003)(261028144727099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajd4S2V6ckpCV2dLOEh2QkplSUQ5N2hjMmVHVS84dnJFR1VqUEhnMU1yOG5U?=
 =?utf-8?B?My93K2tlL2o5eStNV2JIZEw1V3VuSkFma2txSXI0Nml3T3oyd3Nsc3E3eDYr?=
 =?utf-8?B?WGFTMG1LampmUERFa3JlRjAwV1k3WTVUb2FJM0RtRmZSZ01ZNWg0a3h4WXNm?=
 =?utf-8?B?dWN3RU5QUDVuTjA5OXVtM3Z4MDBuN0o2dWdIMDJFbXVSRHpUSkE2UGV2S21q?=
 =?utf-8?B?Y0F3UTBpR3hhR3ZmZVlaTzNvVjJDamlJQms2Rm9iZS9tb09WSlF2V0N4SzE4?=
 =?utf-8?B?TjFkVjFaK2s2cTNKd0pBbjQrd3MxYUVoQ2pKQm9sdExrZGYwazZlaEI4bXdl?=
 =?utf-8?B?QVlzOU1TVDlyQzJJMzJJdnlGc0RwZDNiQ2pJME9RNDhuOUhOZVVjQmZrNUV1?=
 =?utf-8?B?NHBJcWxUKzVBV3FhOHNaaGErWGJIcTRxT1JWQ0VPTWNnSG9TZGdkd085amNN?=
 =?utf-8?B?K1pLRmE4VG9YTncycHM4OHVVOXFtdmJOc3BqK2oycnFKdFp1T3Z6RG12VVMz?=
 =?utf-8?B?TU5XVGQwamNTaGgyL1d5VjRYbERmaGNHcGlNR1hrQ1h5S3V1QVBEY3c2OGRL?=
 =?utf-8?B?NDhOWFFwa2VmZ2RmWVlhN3FjajM4eFhBUWdZSGdXYXhIZDA5QjEwOEtqWFBn?=
 =?utf-8?B?THprd2ZwSkhqUDUxczBJc0J2WE5ZcmMvaFQ2Y2hKSzNPT3lRemJ6K0dyK2tR?=
 =?utf-8?B?cTE0SEJ3SG82NEd4TEJpdzQrK2xqcDlxUzRzV3dRQTlqYm92aG5EYXJENENv?=
 =?utf-8?B?ZGpDb1dLays3cXc0TGxsOHFPalEzWjM2RURsMkVzT2xQTWpsVUd0aTk3VlIr?=
 =?utf-8?B?WEJLSDU3M2RNODg5eWYzYXJZWGdXQXFaVTdYMytDYlF2ZzJidFd6R3RBb2l0?=
 =?utf-8?B?SzZ4SGt5K0lxdENYMVFZK0Y3TUFjS0NSR01kTEg1dG5mWnk4NmdZclAyc0pU?=
 =?utf-8?B?OG0wZHFsd0pLa0VvMkVldXhDOHplK2ZwSnNtQUJ0K1BGcjZ3OTlaRzVlcEh2?=
 =?utf-8?B?bzNwUVVOcmdyTzluWTFqSitiQmFQVCtaSzZpUFA4WnBnMEZnL2FDcEtraTVi?=
 =?utf-8?B?VVh3QThONnNweDdlUHB1a0srUTNpaEFKUGxUQWwxeDhoUjlWbjZxYWxrMWEr?=
 =?utf-8?B?Q2oweXlhcUF4WmRjelFyNDhvWkNPNjF6VzRkd1ZPK0xxNVVEVm1kY2RBcFZw?=
 =?utf-8?B?VXR2Q1dpeEk4cm1WYUJOOGd4SmdlWStQeHZvSVlZNkVLQ0lvTmNKVVdnSjlL?=
 =?utf-8?B?Tll1TUFLR3hLY3hvQmJNR0U4MW90TnhEdFdBK1RLWHJnNmFIb0VxNFdHbmsv?=
 =?utf-8?B?ZGlyRFpQS3RWeitDd0w5NGp4NFZnTjd6cUw0S0tNWWNJNVZMT0J1cDA1WjB1?=
 =?utf-8?B?T1BMZEJwMDN2MmI2b1R6L3ZDVFRVcjJwYTRHQ0FxNUJJRkltL1RCZGJqNWtp?=
 =?utf-8?B?VWJpa1Q0T3VLYjQ4dlpXcTVXZ1NwclJ4MHhNcDM4akxzWXdRd0lWTGh0bWgr?=
 =?utf-8?B?Y1U1b1R2aHJib0tOTXdxejdXd21WVDdPdVB4dW1EU3hvSmxxaWJudDhwVWFE?=
 =?utf-8?B?YUYxVmpzVUd4TzZUbkRzQmhVT1IxZkF5dXBoVExEUEdWcU4wVkJSMmlRajhR?=
 =?utf-8?B?Q0ZqcWx5Si9vZ1U1SXpxcHFvVEtiYmYwR096Y21ReElUQ3QvQi9VOGpRRkZ2?=
 =?utf-8?B?NEpIa3l1L2FCUmNIa2tWNld5bW8xQm9FYjkzY1Y4bkNRcUsyVFVIY3ljVndQ?=
 =?utf-8?B?VTdGVFZBTnlla3dHcHZVb1gwWTZCbFZVOXVUZU9iNU9PemxOZW9uZUdqckRh?=
 =?utf-8?B?amxNMHZiY01xZFM2TzFYVkpIRFNNUTMySzA4SjhMb3hTRG5PemtCWW9BSDI1?=
 =?utf-8?B?SXV5REpIU3V6d3BxVTYwZ3VKZHl2b1dra1oxOHg1SHQyNnZ3emJkbXhJaWJa?=
 =?utf-8?B?ZGthaTkxUHFqL2xsTzd1aTNHZXdVWjZCeUxWUjBhUkdzRzc1UTJaOWRHTHpI?=
 =?utf-8?B?S3p2RUpvSzhvZTZldk5MMERES0FtZkZXUDNWTVJnakRpbHZDWjVtemdiUERR?=
 =?utf-8?B?WGJ4a29pTm1CdFZCZVdHZ1ZOSDlXWE5wYkFzbHNiMVJ3QUpZckpncWRaREE2?=
 =?utf-8?B?SlNOd0lBNEVocFpHMCtOazFXbnd2bUZjcXk2TEpWTTVnbVNjTHVHaSt5c2lZ?=
 =?utf-8?B?dEVuMDBDd1FFdjhTLzVORSs3VGdtbzJzakVnc212cEdNa0c4dEQvZFRPR2Y1?=
 =?utf-8?B?QmkxWlQzZ2NWUzNDdG5mK2h5UEdJTzJPNE5zTFUwQ0thYkxWaWNTdjVjQmt4?=
 =?utf-8?B?UFZMemR2QU12ekVYeDRIT2sxV3hsUE40WGhPNmptaFEybDVudjAwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D82FEF411D1384090F5F608E263FF6D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2AKev0NWcXrf3fscmyDP/LMwme1J7xiw+FK2t8LTbE4EAfnVBP18M4ZlNKSkppjvm9s2NDSY/WmuLJzi+lHDXCsg7jXPe4pmlx0Q0FRrWsru2uvaB/ogBXGJ9cGC5aWsiAoWYc+6e+mv25Jgw2cL9eYoyFO4707vl+4vXF5tzwBt3qkcS+9kebPpjy/f4NkRd56ZEj2B8C8J9ucLmX09VJCtdwCYyW4C2nSiFdfG+vnzUF28Hpsgu//H7pU8Et9YVqWtyeHIw3EYJzGmXik0xQ7FdVgxKVtdXDONTii90QsZMy9bQDsCcmRun1Z8aCazktOOYIpg/+jkDNcOtRjwhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d091e1d4-d8d0-40f4-3f06-08df35893a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 06:52:41.9582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/oxsfw7Tr/SvjzfWRHexOlbDrW/iiKtaQ1Vz0y0F35P6pTd/4PbHO80T6vd8SMKc43u1A1MYYe5TXJI4x/Jgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE7B509EE5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIGdldHRpbmcgdGhlIE11dGUtWCB0cmlnZ2Vy
IHNvdXJjZSBJRCBmcm9tIHRoZQ0KPiBkZXZpY2V0cmVlIG9mIGVhY2ggY29tcG9uZW50IHJlcXVp
cmluZyBvbmUuDQo+IA0KPiBJbiBvcmRlciB0byByZXRhaW4gY29tcGF0aWJpbGl0eSB3aXRoIG9s
ZGVyIGRldmljZXRyZWVzIHRoYXQgYXJlDQo+IG5vdCBzcGVjaWZ5aW5nIG9uZSwgYWRkIGEgaGFy
ZGNvZGVkIHRhYmxlIG9mIE11dGUtWCBJRHMgaW4gdGhlDQo+IG10a19kcm1fbGVnYWN5IGNvZGUs
IGFuZCBpbmplY3QgYWxsIG9mIHRoZSBoYXJkY29kZWQgaWRlbnRpZmllcnMNCj4gZHVyaW5nIGlu
aXRpYWxpemF0aW9uIGluIG10a19kcm1fZHJ2IGlmIHRoZSBNZWRpYVRlayBNdXRlLVggbm9kZQ0K
PiBkb2VzIG5vdCBoYXZlICN0cmlnZ2VyLXNvdXJjZS1jZWxscyBhcyB0aGlzIGltcGxpZXMgdGhh
dCB0aGUNCj4gZHJpdmVyIGlzIHN1cmVseSBkZWFsaW5nIHdpdGggYW4gb2xkIGRldmljZXRyZWUu
DQo+IA0KPiBXaGlsZSBhdCBpdCwgYWxzbyBtaWdyYXRlIHRoZSBtdGtfZGlzcF9vdmxfYWRhcHRv
ciByZWdpc3RyYXRpb24NCj4gbWVjaGFuaXNtIHRvIG10a19kcm1fbGVnYWN5IGFuZCBjaGFuZ2Ug
aXRzIHBsYXRmb3JtIGRhdGEgdG8gZ2V0DQo+IGEgc3RydWN0IG10a19kcm1fcHJpdmF0ZSBpbnN0
ZWFkIG9mIG1tc3lzX2RldjogdGhpcyBpcyBkb25lIGluDQo+IG9yZGVyIHRvIGdldCBhIGhhbmRs
ZSB0byB0aGUgTXV0ZVggbm9kZSBpbiBPVkxfQURBUFRPUiwgd2hpY2gNCj4gcHVycG9zZSBpcyB0
byBnZXQgdGhlIGxlZ2FjeSB0cmlnZ2VyIElEcyB0aHJvdWdoLCBhZ2FpbiwgdGFibGVzDQo+IGlu
IG10a19kcm1fbGVnYWN5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0t
DQoNCltzbmlwXQ0KDQo+IEBAIC04NTYsNyArODUxLDYgQEAgc3RhdGljIGludCBtdGtfZHJtX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3RydWN0IG10a19tbXN5c19k
cml2ZXJfZGF0YSAqbXRrX2RybV9kYXRhOw0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsN
Cj4gIAlzdHJ1Y3QgY29tcG9uZW50X21hdGNoICptYXRjaCA9IE5VTEw7DQo+IC0Jc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqb3ZsX2FkYXB0b3I7DQo+ICAJaW50IHJldDsNCj4gIAlpbnQgaTsNCj4g
IA0KPiBAQCAtOTA0LDE3ICs4OTgsNiBAQCBzdGF0aWMgaW50IG10a19kcm1fcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAoIXByaXZhdGUtPmFsbF9kcm1fcHJpdmF0
ZSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gLQkvKiBCcmluZ3VwIG92bF9hZGFwdG9y
ICovDQo+IC0JaWYgKG10a19kcm1fZmluZF9tbXN5c19jb21wKHByaXZhdGUsIEREUF9DT01QT05F
TlRfRFJNX09WTF9BREFQVE9SKSkgew0KPiAtCQlvdmxfYWRhcHRvciA9IHBsYXRmb3JtX2Rldmlj
ZV9yZWdpc3Rlcl9kYXRhKGRldiwgIm1lZGlhdGVrLWRpc3Atb3ZsLWFkYXB0b3IiLA0KPiAtCQkJ
CQkJCSAgICBQTEFURk9STV9ERVZJRF9BVVRPLA0KPiAtCQkJCQkJCSAgICAodm9pZCAqKXByaXZh
dGUtPm1tc3lzX2RldiwNCj4gLQkJCQkJCQkgICAgc2l6ZW9mKCpwcml2YXRlLT5tbXN5c19kZXYp
KTsNCj4gLQkJbXRrX2RkcF9jb21wX2luaXQoJm92bF9hZGFwdG9yLT5kZXYsIE5VTEwsICZwcml2
YXRlLT5obGlzdCwNCj4gLQkJCQkgIEREUF9DT01QT05FTlRfRFJNX09WTF9BREFQVE9SKTsNCj4g
LQkJY29tcG9uZW50X21hdGNoX2FkZChkZXYsICZtYXRjaCwgY29tcGFyZV9kZXYsICZvdmxfYWRh
cHRvci0+ZGV2KTsNCg0KQnJpbmd1cCBvdmxfYWRhcHRvciBpcyBkaWZmZXJlbnQgd2l0aCBsYXRl
c3QgdXBzdHJlYW0gdmVyc2lvbiwNCnNvIHJlYmFzZSBvbiBsYXRlc3QgY29kZS4NCg0KPiAtCX0N
Cj4gLQ0KPiAgCS8qIEl0ZXJhdGUgb3ZlciBzaWJsaW5nIERJU1AgZnVuY3Rpb24gYmxvY2tzICov
DQo+ICAJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShwaGFuZGxlLT5wYXJlbnQsIG5vZGUpIHsNCj4g
IAkJZW51bSBtdGtfZGRwX2NvbXBfdHlwZSBjb21wX3R5cGU7DQo+IEBAIC05NzksNiArOTYyLDE3
IEBAIHN0YXRpYyBpbnQgbXRrX2RybV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCQlnb3RvIGVycl9ub2RlOw0KPiAgCX0NCj4gIA0KPiArCS8qIElmIG10ay1tdXRleCBp
cyBub3QgYSB0cmlnZ2VyIHNvdXJjZSwgdGhpcyBpcyBhbiBvbGQgZGV2aWNldHJlZSAqLw0KPiAr
CWlmICghb2ZfcHJvcGVydHlfcHJlc2VudChwcml2YXRlLT5tdXRleF9ub2RlLCAiI3RyaWdnZXIt
c291cmNlLWNlbGxzIikpIHsNCj4gKwkJcmV0ID0gbXRrX2RybV9sZWdhY3lfaW5qZWN0X211dGV4
X3RyaWdfaWRzKCZwcml2YXRlLT5obGlzdCwgcHJpdmF0ZS0+bXV0ZXhfbm9kZSk7DQo+ICsJCWlm
IChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KDQpnb3RvIGVycl9ub2RlOw0KDQo+ICsJfQ0KPiAr
DQo+ICsJLyogQnJpbmd1cCBvdmxfYWRhcHRvciAqLw0KPiArCWlmIChtdGtfZHJtX2ZpbmRfbW1z
eXNfY29tcChwcml2YXRlLCBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikpDQo+ICsJCW10
a19kcm1fbGVnYWN5X292bF9hZGFwdG9yX3Byb2JlKGRldiwgcHJpdmF0ZSwgJm1hdGNoKTsNCj4g
Kw0KPiAgCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICANCj4gIAlwbGF0Zm9ybV9zZXRfZHJ2
ZGF0YShwZGV2LCBwcml2YXRlKTsNCj4gDQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcm1fbGVnYWN5X210a19tdXRleF9tYXRjaFtdID0g
ew0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLWRpc3AtbXV0ZXgiLCAuZGF0
YSA9ICZtdDI3MDFfbGVnYWN5X210eF9kYXRhIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDI3MTItZGlzcC1tdXRleCIsIC5kYXRhID0gJm10MjcxMl9sZWdhY3lfbXR4X2RhdGEg
fSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc5NS1kaXNwLW11dGV4IiwgLmRh
dGEgPSAmbXQ4MTczX2xlZ2FjeV9tdHhfZGF0YSB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWsubXQ2ODkzLWRpc3AtbXV0ZXgiLCAuZGF0YSA9ICZtdDY4OTNfbGVnYWN5X210eF9kYXRh
IH0sDQoNCiJtZWRpYXRlayxtdDY4OTMtZGlzcC1tdXRleCINCg0KUmVnYXJkcywNCkNLDQoNCj4g
Kwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE2Ny1kaXNwLW11dGV4IiwgLmRhdGEgPSAm
bXQ4MTY3X2xlZ2FjeV9tdHhfZGF0YSB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTczLWRpc3AtbXV0ZXgiLCAuZGF0YSA9ICZtdDgxNzNfbGVnYWN5X210eF9kYXRhIH0sDQo+
ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1tdXRleCIsIC5kYXRhID0g
Jm10ODE4M19sZWdhY3lfbXR4X2RhdGEgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4Ni1kaXNwLW11dGV4IiwgLmRhdGEgPSAmbXQ4MTg2X2xlZ2FjeV9tdHhfZGF0YSB9LA0K
PiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWRpc3AtbXV0ZXgiLCAuZGF0YSA9
ICZtdDgxODhfbGVnYWN5X210eF9kYXRhIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTItZGlzcC1tdXRleCIsIC5kYXRhID0gJm10ODE5Ml9sZWdhY3lfbXR4X2RhdGEgfSwN
Cj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLW11dGV4IiwgLmRhdGEg
PSAmbXQ4MTk1X2xlZ2FjeV9tdHhfZGF0YSB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MzY1LWRpc3AtbXV0ZXgiLCAuZGF0YSA9ICZtdDgzNjVfbGVnYWN5X210eF9kYXRhIH0s
DQo+ICsJeyAvKiBzZW50aW5lbCAqLyB9LA0KPiArfTsNCj4gKw0KDQoNCg==
