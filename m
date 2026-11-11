Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=XknTB+6y;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=QD0HOl7d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C62710E0F9;
	Wed, 11 Nov 2026 02:43:39 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1574510E0F9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:43:27 +0000 (UTC)
X-UUID: aa54cc08dd7911f1b1788b6acf885367-20261111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Lp1iQ6eEgvh9aQk+S2SA8whuw6Z/xB6Fw8gL2LRc394=; 
 b=XknTB+6yUKTDREUQQUdagfjXidLztDOCLcqFAHIJGJQWpLV2JBXGygVXJaxlBAiNrQjFaaaybZY0ZMdJJPFSBgAFAtzJq0219/dExhJtQW/pdnsFI/R/fjOusX2QXP/uGRhch/k/UlufOiHKiCdxO7//ZdXKOzy7NNr8uifea4s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:1f44def7-e07a-47eb-9aa7-dcb12e449a45, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:b0318ac, CLOUDID:0d502066-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa54cc08dd7911f1b1788b6acf885367-20261111
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1770526719; Wed, 11 Nov 2026 10:43:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Nov 2026 10:43:23 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Nov 2026 10:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+LWsuyCDe/JjfU+2jObkNHdbseZEFqw8u0LNfq2xfif/wotDhCeDdHDk6DoSY+jtQ4BfytnQBMQcNIUbo1h2BFXk2ArdoEsP/UqaAohqLT9dxMRsZxQWPVGziOyGJSd37FBbWBR2ALQLr0LPOIVgQoMDBV3tH82rThYgBuH+mmHzeY9h9KMYBDf7ai2nv40x9phA8pwZmkGmZDW1qlaNbe4/fJY0wmBdxyjVABdIB7Ak2trgYi5zljWF0fZONUrE1ikVXC9KaP2rK+/5chLx9atOCRxp7yXOpWCFqQyjlt8eja9HUWmMu1RI8rr033yyxR/xA0E/1gGBJBpzxrcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp1iQ6eEgvh9aQk+S2SA8whuw6Z/xB6Fw8gL2LRc394=;
 b=IBpsAm7DdaZ5zznMHj/AXZ1nZbftj8CzYvrHrFq6wY5jBlc96r6Rv/YNSd0j4oMUlfEf2YCIrtTxe7LjGDpydQL5c/delauf2dC8zW3pltozh/bRrQMbOK95NpP4b+a9sXekxiTNjPNPQILFa7+rbxr2e0c+Etz4uePRXwgOW+14rROMXvtPNyCX1Z842OsG6Pcd2/rSBwWbtg8u4joBav1zwUorjhhQxm79/+CW6A3wSxsW/MLGQeI0LHQSTYST/q/Ixb1ogf3TaqcvDb0lwJkXcMjRT3IGtSiyCkDnCPqZGHsxwmYrSbYCMHRotSUgSxF46dzE+dSWOAH/KCLFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp1iQ6eEgvh9aQk+S2SA8whuw6Z/xB6Fw8gL2LRc394=;
 b=QD0HOl7dfR1vIXDs047zbzbyFXIDryP0BOsZVBmuFZsUVG5mIbenxNMn/7JR+E/hvPefCphWdSPcPzwUjZnITg0iNwxGPjcH9mODji41jvgJhDf7ShirUEeaXNGiCHVAK2y1mdZehussie3MQr5NROTRvILAuvILIH8NZoZmB7I=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by PUZPR03MB6911.apcprd03.prod.outlook.com (2603:1096:301:fd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 02:43:18 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 02:43:18 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
Thread-Topic: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
Thread-Index: AQHdVEHTVUg2MgTVNUWd9EVx7+g6p7coX7SAgAAEmAA=
Date: Wed, 11 Nov 2026 02:43:18 +0000
Message-ID: <524b9675fd10d0d21880821c10a4f0e188d24956.camel@mediatek.com>
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
 <8c8ff7e2-d1a4-45c8-aacf-bca93439a32d@gmail.com>
In-Reply-To: <8c8ff7e2-d1a4-45c8-aacf-bca93439a32d@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|PUZPR03MB6911:EE_
x-ms-office365-filtering-correlation-id: 0bf2640b-7cec-4fa5-e7dd-08df3f9d8b07
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|42112799006|366016|261028144727099003|261022105027099003|10067099003|261009223027099003|261026121527099003|261026140227099003|11063799006|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: D8wG58/pbR0O1NDaAMJC5JUtdT84rjybVzMwlN2xlhSqLGS1FJ28celxS4lBEMZHvgnSNSRLBZh5GzsDuB0CBZmgSCT1A4lcQqiY90J308AAMp+QgYRv17CQY/XFbvgGZ6YWFuaWT4vFqBgQVvR7FMtksUBC4HSYVgcsE3AGmgeRbj/uej/X3hnJ+xUTXMeEzCR4U1UKzBftHTxQF5fEjGaw7ERCTfARgdHcOhTpEe7cr0PeTiqAinyPUSYpeHl5j5YUCYbbCAyxEmI0yGFtrqGApxfxnbdkzeRSsqLGiCkQCPOOFb1hSCtXzijuNN2oCHTqm+Ero3LjbgkQSd9xrYTkLRMuw5+E+Tvp53wBneigCCwQ+kiAogTG71yTi2lWEkdTSJL6cJPp9Kdjq4lxXngFWgxIsyzo5aX68MDukkyCstQ36QQbH9KyNDyfqo0wzVxzTlWJIaQlB36N7YfXpKNTBzCKN9ljPMji7ZX6BYmjXxc5ckWS+Zje6/HZPVfH6MLX2v8jRto4wGjSlutzpbmvmrRf6thd4/oiLQYVGOiaQvgUFfvKFBQvOhtJHra0ZUJenxjkvyJ5wkChtNCHU6X2fhUaZH/w087dd+2t0EKN+uIuMKj3Zn0GSUKqIfZfhwtNxle61VOVF0B44Qpchl6OUn3frm31iZjf79PrUCw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(42112799006)(366016)(261028144727099003)(261022105027099003)(10067099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZjazJyakt0V2FxK0E5aVBJV1JLd2t5cEtDZnlZSERQeDYvL3E5UzVEVHhJ?=
 =?utf-8?B?LzNWSHFDN2F2clV3czZqdTFZWlpWTUpMTThJUTdpSWhubTZDRDYzbkhyMktZ?=
 =?utf-8?B?Z3lGVTA2QWlQcWprSFZXSnRkQ3c0U0xTMlgvY1lzUEFOU3VTaTlkUjdrbkRX?=
 =?utf-8?B?dDMxY2lYbkxhaStENEhuWU01NWxWRXlDQ0Mxb2wvOGhDWU1iNlNIbmUyVFV0?=
 =?utf-8?B?NGhDTmFoN2hQY2NOcWFQTU42MVV5a0xIOTl3UjcwRGRlRFc2NWRGNTNZa3NG?=
 =?utf-8?B?QU1ma0w4cUZrSUdZYTBaRTl6NUFqUWJzaSt5QVF5UnpSWWR1MDcxQ1grWXYw?=
 =?utf-8?B?cFdxSW5NNzloWDVrczNHUGhUQlFzYmpBUzJHNnZXcVEyaWRaVExuNktLQzJK?=
 =?utf-8?B?bHZ2bHBkS0xIaUZEN1hNQnpnQzVmdjN1b2dBNjlWdWNuSFNxeHZZcEIrTzY3?=
 =?utf-8?B?b01GU092K1VYQnZTaWZDcWlyMWhnZXd4NFN1bWYwUktXVmRZSXFlakJ4a21H?=
 =?utf-8?B?WnVhZXUrZDJxS1p4eVFUVTBuOGFuZnNnUElDenFFWjFkSlVyODRRdEQ5KzJF?=
 =?utf-8?B?bEZBeEoxSUUxYmJDL1JYLzFkNVpkRUd3TVFOSUZkR2RSclNyTlRTUG5yTHBj?=
 =?utf-8?B?ZXBvekQ4TFp0YlVNQ2NPUHUvRVZNY0hHbUhPYjZ1YlVJM1FZcFVMMmh6UE05?=
 =?utf-8?B?WkQ3ZlowSytyNE5Cd0lzdFVZUVNkSFlhK2ZrUXhXTzFaUHpxYXB2ajJMaFdL?=
 =?utf-8?B?WUE2ejJUb0lieXRRdFhYcm9kcWNic1lxQkF1aWNmRXNoYkRGRFMwVVd4aHdK?=
 =?utf-8?B?Y0Y4MDV5RWg2VlFkNVZ5eHpvdDJMb0VQMmM3RmU2L1hBWk9mNkpPc2RaaUx3?=
 =?utf-8?B?dFFDRGJNdEtac09HR0hmZ3NueXJsVVJhdk5Bd3puU3JVTThiVHQyQjlqTWhu?=
 =?utf-8?B?UUh0VEozbUUwdjZlVkNONVh4bFpZZDZnT0luTXA2WnV3cFAxL2hZckgySFZ6?=
 =?utf-8?B?SkM3bTZ5YzlUbUIzaElVV3kwelVCUFFKNmdMWExMRDdtYitqRm0vU3I4UllF?=
 =?utf-8?B?bnk2S0xiZ1d3N2hHYjRjeEJ6cmJHYUpSVGRmVDZmNlYySXZtVGQ0MnRrcFV1?=
 =?utf-8?B?T0o4YmswS01QSXNyYjFpbnhrRmRrVDVJajFqT2tBR2EvWk1Rb1N1b1ljcFZp?=
 =?utf-8?B?SUtBdnRoNklHcFlrU1BOWi9DM3ZMNS9uMXBmbjljdXhUMnZNTmVsRVFtTVg1?=
 =?utf-8?B?N25SbkwxUXR4TzZsSlh2UUNUa2FJV2ZsTHNjV0dINE5BM1p5K2g1bkUzSXF4?=
 =?utf-8?B?MzZLSWJxMVAxM0RhZE1CcGIvYmpyQVg4aFFpV1RudDRIa1h5U281dWUrSktW?=
 =?utf-8?B?WURDdDNsTHFsV3ZwaXc2blV3QkNZM2JDbmhTMDBEdEhNbUdiZ28vYVFnbjVR?=
 =?utf-8?B?aEw2aEswOTVUYmVsNzdoQURYTTJIY2hwRTdLaDVVcEFLN2kzUmprUHBmUjRH?=
 =?utf-8?B?aUIvZ3g3N2ZQMytZdjYxdkJBbzVBeXVRckw0SU5Ia09XTzJSSVZLVUk4ZnIr?=
 =?utf-8?B?Wk9OSzBwRmpFalVkUnhqSUtxbnNYR2xFSGFXZlJWYWN5VFZqREhMUzE2RUhh?=
 =?utf-8?B?UUxvSmdGODFjQlEzYXU1dTdQREdTZitVcldRK2k1WEZvTkt0QmVHdC84VEJC?=
 =?utf-8?B?UmJDZjh3YnR1OHhtS0ZDRHluSjB3R2lRWlF3K1RWbW5DRnJmcEVhckJtQlo4?=
 =?utf-8?B?QmxIRTVueldHbyttc0s2aWdsVmVrWDNhSXczcXZlMlNIZDRCSm95RjNnb2wx?=
 =?utf-8?B?Z2IrQUo0eUNNMXdGUnFzVlUxQmduLzQ1ZFVVMFFPK0tXREtMby8xSlF3M1NU?=
 =?utf-8?B?UXg2a1JIVElZWVJDdHZmSmROSDU0dVgxa05GVnFveFlBVEJjSXA2cUJXZmEy?=
 =?utf-8?B?Y0FET3FobVVZSklwbmlxci9KWVN4eTE1dVZCSXJqTmxobU1zbTc1b3ZuK1NC?=
 =?utf-8?B?eTNzSkFBOXpNWGtZaEs2c3R6b1lCOWxMWGozT1VJbnZ4VUR1SHYrVHN2L3dQ?=
 =?utf-8?B?OFVSMHlYN3ZIcDdFVTZodzFwUW41WG8zSkZxc3lzckpWdm51VHJRYjQ3dHJu?=
 =?utf-8?B?NkV2MFNwemRHaWsrNjF3STdTSTI4TUFsaEJjZGc1TFVRckVHMVk0N2oyUG5B?=
 =?utf-8?B?cmdNdkhueHJYZ2dpY0cyMWtTQkpId2xKZFIrTHYyNmpVdldYVXNoRFJKeDVG?=
 =?utf-8?B?MitvRi9maFN2bG5BdmRLcllLbTVHRHh6WU1jTmZDTG9zT0ZZZnk3YTRkRnVL?=
 =?utf-8?B?SnFoMk14bmJ2RDNCZEFqVG5PeXZzdnl4eTBCYUhabERpVTBnbUJkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B06D606336C864A8EA93299EC12FD28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AmZ9ZPMpLs2K5Yq3Jr4HagOmDtu9H2LCtkKOoUdqyd1QQL+OAYUzFmuzA2IaV8SHqD6xVdtclzpgvLtObpHC5oK9gB9/7qcelegZIsfhd2Nu79S7kJB8g0E9UirReEMzgONvy2vkBt3ASxXAGsZV9cFbAVuPdpux5zCqFOMB9OB1emxu4McvnFOZYG6fF8X3f5GgbFel+3KWOX3VUfxihxRMNRzBRa6jNUbVJXGr4Uja/inBP/LwMsOU9057d8uW6bA6LW7GKjlHB8+mSxxecVHHz3slEKVieTCFI1hKlIRDu3Vd9XzWMZkMGVRrbbykCV/6TNG3uwOL1XJm07MKaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf2640b-7cec-4fa5-e7dd-08df3f9d8b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 02:43:18.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWjKgKEInDQaBcdAK9qowDNeRNZleltQWrzoQDjDS6J0/wAzDiI+4184sryL8eb8g0qYZ5BHN/aXSJClLzmUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6911
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTEwIGF0IDIwOjI2IC0wNjAwLCBSeWFuIEJydWUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gSGkgQ2h1bi1LdWFuZywNCj4gDQo+IEdlbnRsZSBwaW5nIG9uIHRoaXMgb25lIGZv
ciBtZWRpYXRlay1kcm0tbmV4dCBub3cgdGhhdCA3LjQtcmMxIGlzIG91dC4NCj4gSXQgaGFzIENL
J3MgUmV2aWV3ZWQtYnkgYW5kIFJvbWFuJ3MgQWNrZWQtYnksIGFuZCBpdCBzdGlsbCBhcHBsaWVz
DQo+IGNsZWFubHkgdG8gdjcuNC1yYzIgYW5kIG1lZGlhdGVrLWRybS1uZXh0LiBJIGNhbiByZXNl
bmQgaXQgd2l0aCB0aGUgdGFncw0KPiBpZiB0aGF0J3MgZWFzaWVyLg0KDQpIaSwgSSdtIENodW4t
S3VhbmcgWzFdLg0KSXQncyBub3QgbmVjZXNzYXJ5IHRvIHJlc2VuZC4NCkkgd291bGQgYXBwbHkg
dGhpcyBwYXRjaCBsYXRlci4NCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTkzZTk3ZjcxNWIy
NDExNDE2OWQxODY1NGUwOWM2NDZmZDllMTQ5NzkNCg0KQ2h1bi1LdWFuZy4NCg0KPiANCj4gVGhh
bmtzLA0KPiBSeWFuIEJydWUNCj4gDQoNCg==
