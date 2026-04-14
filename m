Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F58F9D0FB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 23:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C9B10E08B;
	Tue, 14 Apr 2026 23:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIf9Mtto";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A0010E084
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 23:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM3ljMmAlWJ5k8DsMea1nWHiYYuLKGv7bVJdsiqwCcooKoEPUKJlInBAooAYxvbh2wGdoMgTYs+BtLbaifvbs3X/ced7MKKX+81jaXj8zwRXAsVPlFTmOp1BNo4ln0HuSeRbOe5XWkWRMmif/KffIR54VxhsKNMlyrEd5TgsXrX9WtiT8+/zJdkXgXxWdWGThzj95XC9wBwqbBMaje9XUCXPGxWDLRfVtqNIYKIeBxAgkom0Ls9uO2SLe4apm+lFJBACY9c2JrnD63oRxu8XXLq7LD3NWR6/DgpxCCijLofJsGiRuUXpYXI39FuRHWJ080626Pmpiqifl5PSJn5ZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04BW8Dy+nRxoGmrmuttdP6caLauzZ1+dQrtV59E6mhA=;
 b=RSp+gdgAOd3TpH/8C8Raat58DHWUntqMHbzeoI7iygiCBUknKnFove1sl2M/hSZOMDmYA5mcvwzPNokRvmpNYl7pj7KYIezEeD1hoSXGsIhE3L5Sw4tgjUNjznY4RJfjM1kNLcwVEV6Q6k2EQngaJyBK0vqPuieVSuq+L5UiQIdUy2s+nKvMkxVopHaslmwhD2oSJ+5DOdS7F+dv1igLp6OixlbT+vlCMIaczIu88ZIHkGCtvOOouEIA+yWowNITv+XND3cORawfwBrAmZ07AATmRM7fnLLO+Ua9K0rvdDlPIH/KGsuvlxJEW0NPv75qhVi+fts2v39Ap8rygPnjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04BW8Dy+nRxoGmrmuttdP6caLauzZ1+dQrtV59E6mhA=;
 b=rIf9MttoMZRDrOtHMRBpJAvrcG+QHvKDbBfUYuA/Aoh9220zdKzXpd4kPs+OufhYQsvBN69KFjxorO44bbHQQhaOya9Cdxm1hdGH4B0B3eikAlaqzrL/XR6EG4kz8mk5MKAsdR8k5NJQOXFpe2JWols/SVv3vVFO/iG2u8cHtj12Skni7ii47DYuP1C2XhWpDVYlDSbLGqBx0S/G2UjU/CLGnngCrvETppUV4yUan6zxLVogFU9f+HDEfrP2scrZ5Qflp6gFexqYX9B5f/woHwQxv3qV+8/KI4+rteVNBM/I2PKwtsm37e5siq1Lq0fS/Ecbjftga0WxsgtFpV/baA==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 23:39:59 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 23:39:59 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, Alexandre Courbot
 <acourbot@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>, Eliot Courtney
 <ecourtney@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Alistair Popple <apopple@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Topic: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Index: AQHczAWI9K0ATWAIWkGj6vQxMH6BvbXfN/YA
Date: Tue, 14 Apr 2026 23:39:58 +0000
Message-ID: <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|PH0PR12MB5645:EE_
x-ms-office365-filtering-correlation-id: e6fcf02f-cc38-46b9-169c-08de9a7f2407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FKVnnf4gp9O7GeP1H7/DFjNWgDMxkr8XeF2LwDbVw7ul52nHYaX27bXAdZektsuhDdzMSc1YsaUElhpbf4qvSOtyB4cJzfZUUoit0n3uATp0omOyM5pZoued+wb1x8ElSO5y1E1MrPVe3Wmd9yY5osnAm6uwUH6fVwlW8VCsZjk7LPKLTAYRROhFM5qDyU9RDjGyOauEk6hgsC0dYT1Gb2aGh9qL19C7lKEWMA9P/9beOeEDm3w6OhDW+U1nlJR9xKlFGu7/UbQb8NerBjTtOOpgXbb6AsBU401LLaou1s5EsEpBuCkrEqyaYndOT/gXGhV39veIJ2+Vl/f9quHDI1OBkuYN4dlAIOdrBHezGW0Ui3Mkb7bwylXCrw0aBkTakzJeShzh9mPXh1+m/SjRYXEu5RQNp31kMWVVAj69CafDMLsQsgfb+OyGDn1lQurAcintjB3g9lXmY3kn1n4nis0u19+HJBZAHiGXJf2Vwtr1WO9QF9Bh/fdNzaztjvfsaqtk3KfmPi9fDur9ZZqh9EPapGR4nF+u32jPb57l9io9O+G3z1latlwoVaDA5NNhkCaNVuFUIPCojczK36Mth8MTLZ2v+ru15b6RNKMWayhE5oZkrWf5jSRWjJQqjVbhdG21oOK2ErKyCm02Oh4hPVOZ/BcCTW/FFAj+rD4xJgwNE3tf2tnOuc9cYJmjwUCbA1ugRFi+KgWtSxqMFeAUrWNU1KrpB5pc7KA6mgW5QP2ZrSRgIfzwkW3f8Z2kIGF80IOq4YI47YDVDZxCIBz+zqeQXxVgBuHHeFNjPOJbWQM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUN6dnVTNGxLeXRzYmQzekJCV1dJeGdFWjhpYVhsSTNlZzR2QmJHM0tLeGNI?=
 =?utf-8?B?ZVppZjlXdE1leHR5QXNIVVJPalpkaHNnbWNUK2FBSmorZ0xxZWphSVoxc2xT?=
 =?utf-8?B?UzhwN05IVFQ4eU9vdSs2QVhrNnZXNHNIVC8rZWZWSU4rNFI2b2gxc2MxbVhI?=
 =?utf-8?B?MXY4WmtvK2ZhMzNGMjFzT0lPa0NPN1lPQXFGL1E0cjJkcFRnZEJLVWFuNVg3?=
 =?utf-8?B?cWFPcENkOUVwMERnUFMxYkhqK2NHUHg4eThKQVV5L2RWRGE1SmdsazZTTWl3?=
 =?utf-8?B?RXY4TDU4eGdsN0hwaEdWOE1uYkd0YWhFN1Z3bmhXOVA2em9tQXIvSEF1eWRL?=
 =?utf-8?B?K3NCeFlJeVpaVS9raXdvWXBlTVdjL0REc01BL2lwNUlRc1R5TVVxN0hXaFlm?=
 =?utf-8?B?djAyRVBhSzVPM1M0cVIyaVkrWlMrZWc3eHFGckF1UkZraFhpMG9YcXdZN0dL?=
 =?utf-8?B?QnppK0JSa3BzV2V2eVpWdGljRlZNU2FkQmZwdnlNSWc3V2JFcFpNZjRRVTN0?=
 =?utf-8?B?QmhwZzJSSGNyWUJCRlVIcEQwZjRrbDRoUHI1ZytDSHYxRFJXcktmQ1Y4aHZD?=
 =?utf-8?B?VGYvTFdrUWFUTG81Y21pM2szakh4bXgrUGNRZERBMzNPcmx4Z0pIdERudjNa?=
 =?utf-8?B?Z0JCcG9JdW51VWdlVDN4RzJORUI0S3pUeHdCL1NZMnpmamRHb016ZWdyeDM4?=
 =?utf-8?B?eG1oYlRmVlZuY0N4aXJyRDMrN3phTFVlOTF2ZlQxN2dtVEhSd1hYdzAxVno5?=
 =?utf-8?B?eHFVbWk2bW1oSTVpODVsU3hSQjA3ajE0MkdWZVM3TXYyU2FHcEk1M1RFOXpi?=
 =?utf-8?B?RmdISmJ6eW1sdERmdGE2YXplOFZ3cHpoeW1namJaZ1NkcjR2djk3YjF6L2Np?=
 =?utf-8?B?MlBFb3dtZjlJTGlzL1R6R2Q3aGhQay91R3Y1Z0Vsb2xRc0FDM3FuL0xreHJJ?=
 =?utf-8?B?VmNiMmVLNjBCQ2FSMm9BUVJjUytENjUvVDZOMTY1eEYrRjlLZHNnT1dvRllE?=
 =?utf-8?B?NGRXZ21sSFgxU1UrWmFEWTArSzhOSm80WlNSL29HR1daZXRKRUhRU1FFZUJH?=
 =?utf-8?B?Rzh4T1BsdDJQM29VNDllVEwySHo4aklBNUlDb3YxYjBJVks3U3B4SVVWZ3Rp?=
 =?utf-8?B?MzhtanZUdXRhU0hEd1E3YjZGS09Rb0I3alZKSEJPR2hvTitoYnFiNkhwKzl4?=
 =?utf-8?B?blFjK1N0ZVNmRzF4T2hsU3pDZ3JKRHYrUlhDVStPQ3E3MGRYN0ZLTERIMnRI?=
 =?utf-8?B?cjVXY2drM1RZM0poZ0RvaHhieVpYRXFoOFNVcC9rWkJGWXpOTkw5T085aWwz?=
 =?utf-8?B?WmlVSVRUTGFqNHNCVVNuZ090MUhCSkVZSWIwRTNzSFZBOGphUDcwZURtZ1d4?=
 =?utf-8?B?R0FSajF1MVFMY3Q1RUZaR3dPTDVQYXJuazZxcmk1aElVSG1pT1N0VFRjQ1lz?=
 =?utf-8?B?Zm04ZDRrRjhjSWRraWN5OFE3MThzc3lSNUtXL0ZLZUMzb01oSkVGVGdra3B1?=
 =?utf-8?B?cFBUVTVPMXlqeXRJRGVRaFlYSTFIMEFldWU3MjJzc0MyZm1haDB5eVRKU2Jx?=
 =?utf-8?B?RFpGUEFGU052dzBiNUl2ZlAxSWQ2bkZmQVJ2VHBPeFpQQ0N4NnJvRlE0elI0?=
 =?utf-8?B?bHdaTllRU3NyRHh5cmdRT01SR3l0d2Z5Z3E4MkdFaEN6Nm1nalJ1UytiNmYx?=
 =?utf-8?B?RkJVd1JRSWxoYTlLWFhxUDQ4bXNHMlVBdzJOeWtzNi84Ti9KS09yVFR2ZXlT?=
 =?utf-8?B?bnZjUllyMTBGeTVpdUpyanBRRFpjRUxZUXc0NDVxOGw2VDg1SHhjV25Nc0FL?=
 =?utf-8?B?ZFpDRWx4alF5ZTVRM3RTcllOYTFpVmlSVUhqZi8yYTBvRzNiZzh4cC9JdHcz?=
 =?utf-8?B?OE13RmZuQUNuVHJaQ20rQkI0VlJPeEZGTWNxKzdKbHVlOGZWM0dLUUpUN21v?=
 =?utf-8?B?dGNJQ09RbnRhMTJDNnA5SW1Hazc0OUxCa0p5eGtCdnAzRVJmOGFmQ0dsNGx1?=
 =?utf-8?B?dnc0T3RjQzUyN2JTdkV5ZEdzeWI5Q0JWSDBpQ3lWQ1R2dmhZcjNYZEsrenVP?=
 =?utf-8?B?YS90MXhua0s5d0dXSnJvT2JFd3h1c054dTQ0eTVRZTI3bFVGZjlCSWVXaURa?=
 =?utf-8?B?Q0M0QlJGdHh6V1NwU3FmTkRGNGs5dTMxbVBUQjhMazl6T0FaN2dIUllXbTZF?=
 =?utf-8?B?S2hxRVdnb1hJN2Z0dCtSUzhhd1ZBRVArVklySDNEQTFNUzRVZjVLbHBzNW8v?=
 =?utf-8?B?U0g3UlMvUzlQV1FFZHhsYUk1MVM4VkhnZFRHZnRuWUh1aEtRN1BQNTMrc3BH?=
 =?utf-8?B?K213OHRRM0ZScHA1bzJ3S2JSdTlIZkphY0ZaSTltdCtQTW1nM3JOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <250CD2FC1DBA7443A50122DC656FD94A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fcf02f-cc38-46b9-169c-08de9a7f2407
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 23:39:58.8721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: as8L8TMbReBGZq1GqLhAiMHmZ/2k9GGdElV2qfyF5NBV+Azvy4gI2dx0qdiHeBxEYYeW4uFvqyIx2GyjJ/g9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDIwOjU0ICswOTAwLCBFbGlvdCBDb3VydG5leSB3cm90ZToN
Cj4gQ3VycmVudGx5LCB0aGVzZSBhcmUgc2lsZW50bHkgb3ZlcndyaXR0ZW4uIEluc3RlYWQsIGVy
cm9yIGlmIHRoZXkgYXBwZWFyDQo+IHR3aWNlIGluIHRoZSBWQklPUy4NCg0KSG93IGRvIHlvdSBr
bm93IHRoYXQgdGhlcmUgY2FuIG9ubHkgYmUgb25lIFBDSS1BVCBpbWFnZSBvciBubyBtb3JlIHRo
YW4gMiBGV1NFQyBpbWFnZXM/DQoNCg==
