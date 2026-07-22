Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA3C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B64910E2C9;
	Wed, 22 Jul 2026 13:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OL7IXEu8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E7810E2C9;
 Wed, 22 Jul 2026 13:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh/lZjmzbKQdTZyWhZas+l+WrCCh99v89OTWoUn93pO7cWuZMCveK/8t/l7bcinE71Esolab2O6dF3MtxNVvA5fh9STZNhrfZhXazMSOpBIa0G4CrWaiShV+u2qVSFLdgzjin+qpVB99N68ZvnmZyrninP22PMZbj+0LyNdoZdhb+ZFNHvFOj1l5bYBPTlF92kWrztHT56zRjrU4qrsYSTUcjvFPjG6LcyvWRMK4IXeyr3aZkelFjVZH6GwhHWBOVyWe8A+cT5VbUiy428ZJhBnBr3BHI0uUSMIP1PFQOXbQL29L5+ExHEgmICV6ivEBi5c0+dJGwko3jYOkKSUZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=musfeROXPLyAg+0Mu/HQgD6+cK0CKlOlW41N460RmAg=;
 b=OsO3s5lvugI7wgvLzuzq6pxOu/hznJPblGegIQQTMklRzU0uzpSqOvZ9PIHafMMTXoJZta7uiI8ovE55r5/P/x3iw7MFoE9sQ/uZ90DpleU9eCcwZmVZ5L3dHRb5MEVTsj1gfn1ZoxFpR3AQdE51VwnqToYovJbNrwA53S/K0Aqhf8xOHKos2Kvuvi+Odf8mHjl0u5lq2orC7P4DMInsP7fBj7//vce1Bann2UADN5hZrucojtaxxyquozcI5p8CoEXHJHJj35Etg/qdnXw/EmR3f+dopYVXE8AhdB6S725QxJ8syDerWfNPZxN96/vOR0y6I/zwM39l33lYapphQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=musfeROXPLyAg+0Mu/HQgD6+cK0CKlOlW41N460RmAg=;
 b=OL7IXEu8Ev/uhIcV0sH9r9QoGTR/tS0Z31FNwb4jIH6ScRtmJT0DTZJ8Noso8xnsm1BRo8HL4zo60oFdAsuzK/Zd+SdY8C/UGrriO3KY1zCPBMFUgpIOaVwDegUA7On+hPiBZ03BU5BNX2ubduHdZmC9nNwZEPvhCkns7Agyo4bitzXUWgbIb5wASMQ+L9eX76LZbPX0BryRHjk//Wzb5PQqcT0brm33Z4N5f1SPK9AGw9B5LDgZCyWnVG4CB7bvyXw6t5+qtdLbdyabsb2Dpj+8/lTWosNqIsZJt2SPXEIvzMzzUNyCDA9eTWrgherArseV7sIOe4O7Cr83WYRvew==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:36:49 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 13:36:48 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>, "lyude@redhat.com"
 <lyude@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/nouveau/gsp: validate sequencer command span
Thread-Topic: [PATCH] drm/nouveau/gsp: validate sequencer command span
Thread-Index: AQHdGZGYBg1zNAIUwkamoCGrqtYDOrZ5iyOA
Date: Wed, 22 Jul 2026 13:36:47 +0000
Message-ID: <ab66a9fa67984252c5b1562345313e4ae724bc49.camel@nvidia.com>
References: <20260722042123.39900-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260722042123.39900-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|CH3PR12MB7545:EE_
x-ms-office365-filtering-correlation-id: c4c548b5-6765-4b56-2cc9-08dee7f6473a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|366016|56012099006|38070700021|11063799006|5023799004|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: xegk71Vmmnpfzl3a8STa2bEvH8A12pz7Nhn8tFXixsw1IZ+KKWHacatkNHYfSd6FtLJZLMI6hAFUvx6/Xc+FGoh5iD7HcMTqHp+rng0Qh0HqE5Y/Gbz3MybA4fPn+KvfkhtDiki16Wf6/tJvAWsLn/UchwwlakJPGJig/hb4q3uS+ptAujSZ4bYoJINqR1RxuPzfX2LGvjR9cODfFc12dMVynAwBB5tCGlVQlFGPGEtNp5gvKjbB05ieu1/rtL9Wo2PNgKKUXeQgjSMTb4HzeM3caLaQyFs3HxmO+gcnNn2UqkgK+OxIQve2x5+78/834SZUNUd9vwWNUiaEnK2N5lNxpd6876X9qwr27zE4EeVgjkxtfp6YaHMofNylg9R7tIPFiNMValqLnNk0IeSOHaCT3dIRGFUbQOFwPLy6/95jTni4kFz9MeC56VL33xNT1V39iKt4K6vjmi3ER2T2AaLk6oW2XWsIhZ/mnLexuvmvt2tWyjiU8JXNNyyHu4UrU0HktCquJttow0WBmOY5wvi2ySHxVi0T5T5pfMspqM5J6tWYOUy88finff7s6CAkJ8y/1nHwPqFNnXlhuob21AZLK1u+jukhxbmUs3CBZjaoXrGMkrqy/ac773uTVsyfmVluWozPKJKNNnPEoeZ9cImopO65Da7fh1nlsQVx/DigHYslNCggI1PFZi6NSdHyyl3A6a4lEVzj3Y7kjwAN3hj3sa/g+uLCqV48kjf5QC8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(56012099006)(38070700021)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emY1cklJbWlZSVR5Ny9UaXMwVHM5Wm5jSnFMTjB0ZXU3SFYySjFaT2xpakcr?=
 =?utf-8?B?aURFYlFWTVJkUE5DUERjZjlyN0NXNHhQb250YjdBSXdOTnZuUzRLdUx6d1R3?=
 =?utf-8?B?MWJheDZWWnVBemN6SlVkYXJ4Tm96NmJqelhrbmEwWmh3cFZqMmdWTmdaSWVS?=
 =?utf-8?B?MDVxVDgrSmxFTDIxSDF4RVBGMlZrTjZJenY0TVYyRys3R3k0bmhFbGpQYy9q?=
 =?utf-8?B?K3JyRHdQRXM2WnI1MVBDYVA4SDI3UTZRK1dBSy96RTQ3R3dwTDVveFRlZUxx?=
 =?utf-8?B?ajBRbExaVThKdDI5VlRsd0dxRmVodlJBSkJNN2FxcUxiUzB4QXVXajN1RjhV?=
 =?utf-8?B?cGlyY1llMldlVUdmVzAwNFZEMEM1cG5Objh4RXlpY1lsYnlreDdCU2JzYi9W?=
 =?utf-8?B?UTVYSzRWNENtd2lJMHVUVHcwejA3ZGpTdmZKV2xBekxLazJ1czdUR2dTSzNl?=
 =?utf-8?B?bWlibmV1QjB1cFppMzZyb1U1bEZoRHJjSUJ4Y3FCdUxYblJCSnNpSlloVkZs?=
 =?utf-8?B?ZkUzQ0RsSklrakFpblhhU2NCeDlHYnNNVFFncWJ6eW1YM2w3UnFPT2puRkpu?=
 =?utf-8?B?SGZFbm1pcFpWS1FseEo4akFndjNWTllGZHVuY2hESUtRdU9GZDMxR2lQV0px?=
 =?utf-8?B?ODRGRVN2RTdNU1kwSXhWSEEzMnkvUnlyL3JWSitjR2xWa1RYaXFOaUNZcVl5?=
 =?utf-8?B?aGtsOHU0S2VkbThsbWFCYVBZYktTbk5sODVsdkdyNnVGaGZNNkxaWTlzWGF2?=
 =?utf-8?B?Qi9QVDhieUs4SmNRQWZCeDBrYjBJUkpTTmRsWUl4VHdOVGFiT0RrSnNQWXB2?=
 =?utf-8?B?RWZjTS9TaDVqVWxvd1hCYWwwWU9LWnZtU1U0bFowbDlaNHk2R2RZNVhYREMr?=
 =?utf-8?B?SGlBTWhTUE90bEpRZ2F5Z3VBdUNaSUZQeGJTOUNTNmlxdDluZWxFei91R2dH?=
 =?utf-8?B?N2wzeUZWRlFzT244Z0lJUDRtQkJFNi9TOVhWWnIzUU1qeVEwcUViVTRLTFFP?=
 =?utf-8?B?UUtJVjFBYlRXcm15TzVnNnFxeDd0b0Z0czJrVVB4RFp5MUlsc3QydDVTa1Y3?=
 =?utf-8?B?NzBLS2xjZ0dTMWJvVDA1Skl5djEzMjcyRXdHbXU2NGJmS2NJdzFuTlFaZFd5?=
 =?utf-8?B?eG5KRWc5aGtEMytUeHNjMTY3WC8ySk9qUnJ0RHgwVnFjb2ZnSE9FYU8rbktG?=
 =?utf-8?B?Z1AxUDJ6SVpKZ3FNQnJHVHZnZGxLUHpZVXV2SmU0U0dENjJwbkpVV0doWW55?=
 =?utf-8?B?dHd5NlJGWWZTeHgrUE1DVGxQL3VueXMyemNjZHFHcmFXSHZ6dFQwVy80RHNt?=
 =?utf-8?B?OVQvYVRSeDZvVjdWc3NhRE81VGpjOFpaZEhDMC9vTmYrWUQrWjg3ZXJLclBY?=
 =?utf-8?B?dnRReEhBYitVT2dPd2hyVTVxam1POTdTQ0IzcDB5T3lqMCtYTFNMd3pKNnBm?=
 =?utf-8?B?WVlDbFROYnJlR1ZXRUNmdk5tL2k5SjlwaDc3eUUrUlpNOWNGWXI2ODlCbVFs?=
 =?utf-8?B?eDVNS1IzVXFPbkxWVHNVY1pKbjBXSmVsTGQydWdwejRqM3h0OG5ObmZ3dFZN?=
 =?utf-8?B?SGRXWEc1V2NxOGwxcHZyN0toYXk3SmhSaUxqT0FFczJBY1VQVTFKYS95TjVO?=
 =?utf-8?B?M2VZaUFZN3hGbUJZNGthcFloUnc0Y1VNZmNxZEJMT1FHRzk0LzRNQUc2RXg0?=
 =?utf-8?B?UFl5c1VjcjBpQWtsODFrdUNaMHF1OEl1K2F6bTUvWkg3dkxnVks1T3NGMmha?=
 =?utf-8?B?QVVlaTIwVEJOdHV6aE8wcmw4cjBlWjZSbHJwNFpuNVd1NVNBL0hpaGdPa0hS?=
 =?utf-8?B?RHFhRVNNcXM2aHc1NVRNbkJtWUdIOGdQT0FnUVE3QVBaRUJWaFovRUdpQWFy?=
 =?utf-8?B?aFBRODlITXJCSFNwRkRtaGhVK3JJU3ZPMVZpWk94WGdjV2ZhVG9DMEVlMTB1?=
 =?utf-8?B?dmNkSEQwSGdJbXpsVDBqZ0JaeXY1UmJGV3R6QnZHaGpEOEhjeDVvSTBpTEky?=
 =?utf-8?B?NGFORS9kYnIyVnphR0ZJQWc2R1F2b2gvWE1HTzhVNUt1UVd5S2lIOUVlMmhk?=
 =?utf-8?B?UCtLTWdqVHRKOTN0ZHNMRW9KTVBPSnI0aWcyaGs4Q2p3OTU3YktWQ3NVZ21X?=
 =?utf-8?B?NFh2a3l2K2tXRFRzZFRXbEtJRmFSZ2t6emVkbTdMa01HZ2xWYzl0TTBXMFEz?=
 =?utf-8?B?dWlHeS9uU3BZdEFETmdsQmdZR1lPZzk3ek1pWmg2amg4OWFnSm1iZE10THM2?=
 =?utf-8?B?am40djZZSWwrTUE0MlgrdlVPZlZrZVQxOWlDemVkbE05RjFYQ3lMc1lYaHRM?=
 =?utf-8?B?UnVqWWhOTmJEUlFObFdJU1k3aVBNQjVkbHdBOG9mQzllUG1tKzlTMitycWlq?=
 =?utf-8?Q?/m3qeFQsJYt0vrXx4H/XM77HZom9mTVU5gzZfpQd2D2bz?=
x-ms-exchange-antispam-messagedata-1: AWjBrxjyHMGvzQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AB5D6B9FE093341AF20EB1219E603C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c548b5-6765-4b56-2cc9-08dee7f6473a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 13:36:47.5241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nwj1aUfsV7K3j788K1Zu4HH//quqmrpbNS1AMNmk0lFDkAuBgNIx0GYlIjeXzF4LIH2piW25YBHiaW2BAv/Q5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDEyOjIxICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
IFRoZSBHU1Agc2VxdWVuY2VyIFJQQyBjb250YWlucyBhIHZhcmlhYmxlIGNvbW1hbmQgc3RyZWFt
LiBUaGUgaGFuZGxlcg0KPiBjdXJyZW50bHkgd2Fsa3MgY29tbWFuZHMgdXNpbmcgdGhlIHN0cmVh
bSBoZWFkZXIgbGVuZ3RoIHdpdGhvdXQgZmlyc3QNCj4gcHJvdmluZyB0aGF0IHRoZSBzdHJlYW0s
IGVhY2ggY29tbWFuZCBwYXlsb2FkLCBvciBhIHJlZ2lzdGVyLXNhdmUgc2xvdA0KPiBmaXRzIGlu
IHRoZSByZWNlaXZlZCBSUEMgYW5kIGl0cyBmaXhlZCBzYXZlIGFyZWEuDQo+IA0KPiBWYWxpZGF0
ZSB0aGUgc3RyZWFtIGFuZCBlYWNoIGNvbW1hbmQgYWdhaW5zdCB0aGUgUlBDIHBheWxvYWQgYmVm
b3JlDQo+IHdhbGtpbmcgaXQsIGFuZCByZWplY3QgcmVnaXN0ZXItc2F2ZSBpbmRleGVzIGJleW9u
ZCB0aGUgZml4ZWQgc2F2ZQ0KPiBhcnJheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmdwZW5n
IEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+DQoNCkRvZXMgdGhpcyBmaXggYW4ga25vd24gYnVn
LCBvciBpcyBpdCBqdXN0IHNvbWV0aGluZyB0aGF0IGFuIEFJIHRvbGQgeW91IGNvdWxkIGJlIGEg
cHJvYmxlbT8NCg==
