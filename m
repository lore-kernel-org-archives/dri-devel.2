Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA19CD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 18:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4B2112BD5;
	Sun, 31 May 2026 18:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ETBop7sw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CA8112BD5
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 18:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB6IzyTJTXlTzL8oqdwYzuA8k3RaOuRm8vAM4u+CSSkhLUopoHKmy7snTT25mL4vgCo0ccvNgnxGgwrbL6YXw8PpupBNfJegcW49+G/CpjFy1UHr0IjHmbW2Sz06aD2UkPOm5RznQ94064sjsbks9mWcXAHWPkd4CJYvBH02Kig/g3J/HPEh+7QJmH+yhfdaBUcThCELLceNHidcLPtr9+86hchMugQqIChKHgLXkNByjoVQrNopJ0idP02nOHIZmjxXCAr0OHSPROOh4sFZU+HdNz+46EKOg/QhDCry0P9+9/vgmpYmaDSVHeYdTDbooAa804qWvQqPdGaC1OMupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiVuKHZRWAICrz6jXYtUV2SFqlNfAtejWDTizqwh8XQ=;
 b=yJkfB3H7PKmWggzVnBKtp+RCWF7PrkRLOmCyKS9q/tG/3dL4eKIMLV+uAZxv2BU3Td3+gF7edN+O4z3dgzHNjoYcf/IT3rgg+JmLkTz4XpH1/KiVPqd8Xio5djUK1d9r7u7YfNhhPmlnkZ4kYv2TwAfxcMsVjEquQoMM/21LsYVWETnVFFnex6epptwkZp8wgfqptp5Aih+p6xBTfy2m+Zpsg/NsFHdXJDgG234ZHUIcoIw+UjYbSsxAwD9Hsle797Z5ufES4u+OJLgO1GG+HlDkCWgi1BR+SxMi0oEUxfgOd0p+jcWXUdibDTSAfX1aX0qAlFLMX6ueOuu1EqFt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiVuKHZRWAICrz6jXYtUV2SFqlNfAtejWDTizqwh8XQ=;
 b=ETBop7swUFDyiEAE5rELBpFHP8o1wpV49n0OxCVR/Pmwgsgn5+QPlyjY0t8ez11l5AxQmC8AwZha00Wc926QfvNp+5olA4Ryru4jtnGpEIUqDPZd8EWaC+JWp51d6hy08f5dCFhBZbue/hKmEHtf68ggtCe+7j+988gWHOdRaLH5DIHP3n3QpMjB2Dqr6+92BYl2xArdmq2D2HhPRPPcUdgMTgdrr8TJKmkjVJ+vhuWN4zh0S/dBZ5PkWc/zZQ+2aSfNSYjf65puUAplFU6tSZg/F3s8n8ELPPObEjbYnqaeFr8/VwXWHaP6HYpE7LmF/rPvBi8lGZDzZWaLkrs5YA==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 18:41:45 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 18:41:45 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, "dakr@kernel.org"
 <dakr@kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 Eliot Courtney <ecourtney@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Alistair Popple <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
Thread-Topic: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
Thread-Index: AQHc8PpD6ZyY9UsvfE2a5r4oiD4dM7YoeEuA
Date: Sun, 31 May 2026 18:41:45 +0000
Message-ID: <312f8467da270e33f881cab7780692a49756871a.camel@nvidia.com>
References: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
In-Reply-To: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|CY8PR12MB7706:EE_
x-ms-office365-filtering-correlation-id: 34c62ac8-c108-44d7-8174-08debf4443ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: nchYBgNDYr1iXVUlmbSiBS80RGfTiDbtDVQd8gjeKjoP0GQvIWNvmrteEuImajD7QO+FT+O+U5BgKB45F/mHI5uu1MZyGn+03HZ55w8AWMnQCFSKM2KL1C/016udGfIS6wcb99YP/rniOIBZsZXg36OWctaIoyTq6e1B8VXl6pahC8f14QT9C4pr0sr4xfaLZ7OcoOgtfUPikiBZHp2UU+Jhabpp4GqgCzpzD4EQfmU+fpnn6tDCCMKk78h8QdXAdqGaUsKCA28Yzyi7glLs7gDlyidrxNMIP4/filcO7aJ6SHfrFhG8FkkvWHmfvT8TV6RCNa/3WDWS85VMgxeX+j+0WWF3G+eLHc3iwg55BQhCy5nabPUNK9cOU7injHvIBC1OMIZ5aU+kbE3JnCgT7CXTJkNmYHCoc4z6G14gOCW8w0rHdA39PH0ME5Mm7H9Rz2BBWAvMEUbebBx/+g4/Sy2oes4Z7B1S7yCatBKl0PWaWkRxSfZhsR0C+QwsideU4DKcI4adYhwBP9z9Y45J/ix8DrgjPIJGAhb4oMGbzSVwnVTKF90bXDEOxovOhCNLLwMdxnRNVEvKCh63PbSAKWnG6gzoV32Yoz5oLL6lG2kg64/DJZIQWuUL+h7Ki+mxniUvBSe4/8kApuJjKe8zEvngsRwPODcp5w/Ewj6H2aX8dVOURedQkp+trXiH9xc0Xp3jes9BO1HVTEAhTaUyYoPC5Bkkt4tDv8Xx8Roz4IyCoWJk2MigEsSYAZEaRxGn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T05hY01hdVZNZXZkUm0wN1NIS1Zia3RhN010MmdWZ3N4c1NRUjVpTVBOZzY0?=
 =?utf-8?B?SHgzeTFKRHJaYzNLNWthcW1vTXN0YTdZMnAzQ0pLbFNDWHZDUm55MDQ5OWg4?=
 =?utf-8?B?R3lnVEVMNHFQenh0QnNLWk9RWjNjUHl5bWMwWC9yU2pHL0h4b1ZENzNDQ0h6?=
 =?utf-8?B?cUQ4TGM0b3ViaFpPeXNWYlF1Zm1QQ3NYUW1SYUNFREswSmlJb3dxT0lZRmVI?=
 =?utf-8?B?NDlyeW03UTcrQS9NYWNTT213L1BLNU52WWQ4OGRmckNhOWsyQjFscXpTMnY0?=
 =?utf-8?B?TlF2dXZveVRZSzJobkJnc1lKSWhxbDFaQVlVQlFBWlR5aWtWMDVrYmd4RFFU?=
 =?utf-8?B?YVJ1akVnRXNpUCttMUV0UGo4SmROcTFnZll6R3VUUENhdUNxTFVsMXRETTVC?=
 =?utf-8?B?UUtZSjNERWZvVXlISDVHaURDYWFDUjFXN3ZkUVdtMjQ2cXBZWElreG90cDN4?=
 =?utf-8?B?dmdmUWs1YzBXaFkwTHdabU9pZ2NmdXU1eFE2SzhDajNDZGVMRU1za0VtT05m?=
 =?utf-8?B?N08xc0Y0cFNtVzI3V0pWdUhIQVBmaTNKOTFQYk9vSDlCWmJBWUgrZ1ZSRFly?=
 =?utf-8?B?MmM5d0tSODRPUnM0R01BUSs2TGJ5bWRPcGVnZVFyRm9HU3BZTDFSQldJUEho?=
 =?utf-8?B?OHBEcG1UZEZkTTlLUjdkOCttWW9PRkRxWEtCdmhHMVc4UVFDMFNhd1F0QXlq?=
 =?utf-8?B?Z0phMEJvalFHWHJtMW5majF3T1RhTWxzc3RXMGxXc0ZwZ0JvQVowcERPMDhp?=
 =?utf-8?B?N255QlFVZlFyT1pLTzRIRUE3Q3RPK28yam1ONktpZ0JLbitjZWNqbTVRT1pl?=
 =?utf-8?B?U294Qk9DallxUTROSmU3TmNGWUhQL0xkTXI2ZWxiNmtaUjJLWG9qSXI2cm1y?=
 =?utf-8?B?TnZGeWFQWmZWdjJVaEJFYVhqV0kxaHlqN3ZSaXFaQnlFVXdkclFsVjJGMldX?=
 =?utf-8?B?VjgwanNpbDRMZ3dENlA4V2lHWFdQVkM0UllhSkhPZktud05xZkZ0cGswdC9H?=
 =?utf-8?B?SVV5YTFsL1lGU3d4dE9qVFlzVHFkMFc4NnlFOG1mRWZWd2hTdU5nNFhMNW9I?=
 =?utf-8?B?T28vQkRscmhlMmRXUEJqTlk0UzlNMlFxaytkSmFscmE0d0NxNDRoV0kvaWJZ?=
 =?utf-8?B?TGhaWTMxSSs3YktVaFRNTmxmRGY5MnFaaGc1a3dRV2Uyby9LalNjVTY3b3Fk?=
 =?utf-8?B?endJQUlrcXV2Z1AwUHVSTU9kNkxZS2JtVDlVRWt2QW11V1FzMmpmMUEyc1Jo?=
 =?utf-8?B?UU9qdlJoYXQ3NkkwaHNMRkNmOThVbFM0cmx4Z1V4V1BvV05pMDBnRzN4czVi?=
 =?utf-8?B?bmp0TnV5S1hsQ2ZzNTFBVlRYN1FXVEwwN01WTzVwRFlGZCtDaFphaklzZXdI?=
 =?utf-8?B?K2hKbWtmZTFRczdERDJFeUx3UDZRczhUOU4ySXpPMElBb0c3N3dXRVFlWmRR?=
 =?utf-8?B?YzBiUzhjVmF1UERhNm5mM0EwYjZFMHpMbnNtVWtnVDdJK3BWb3J1eWFpVUJa?=
 =?utf-8?B?N3hVcDlMeDJ5T1dGZ2ZxY0JxMVJGcmdURVNVRGZzYmZyM2xhd3NXUk9GTWZt?=
 =?utf-8?B?cExPd1dxQlJZVGZQelJWOWliMnpqRU5ZVHJmQk0zTVJYODhoSTlEYmM2dDdE?=
 =?utf-8?B?UG4rOWtjZWgzeWE5cWxUSTYxYjBpVUdMRXpYRHpOZWI4VlB4NnpncHJXUHhx?=
 =?utf-8?B?N0FLd1ZlRHUrb1Y1d3VlbEtpejJJTHJ2TksvbTVTM0pPTjhIdE5VTDRuNU9I?=
 =?utf-8?B?YWZla2hURDhsVXpjd0cwOEFWOVhDeFJNalYrM0M0c09MM3FHNmlQQUFZenVW?=
 =?utf-8?B?QktuWGQwOFBqRDBnTjI0S2xIUHdhbSs0OUs3QkJQRzltSkNBR2NYS1FZd29J?=
 =?utf-8?B?bWZlek9ycmtwQUdsR0p1RnNDZmt0d0lMY2xHMWgyNEpHYUR4ZWNOYXgxNVBO?=
 =?utf-8?B?R1J1RWhLektNek9OUUd0eFRZLzhKTDFKVW05SE5lYXFSZ05XUTMwUExHTFpt?=
 =?utf-8?B?NHlkQ1A1Rnd6cmcrdGhkZ1VkTzBmSzJoNVFBMjN2KzlvcGppaEptSlBha2Na?=
 =?utf-8?B?Nzh4Tk9zQVNHS1pLRkllRXRMUGlMc295OGZ5ekpJdzV4TmNwQXRvbEpXLzBk?=
 =?utf-8?B?RDBGTWZkZWZ6ODV3d0hUd3h5NEVJZzRoUGJ1U2UyYlNmdjhVUDY1VDUrcmxH?=
 =?utf-8?B?eDNtckFmVUZsR2ttZXVyQ1M2MzcvazJjNkl4eXQyanNXWnBJMStEK1BhTCtk?=
 =?utf-8?B?UFJTZWpINUxMRGYyYUVEc3VTVm5PZ1RvdWFDaW00RnFQU2M3bGRNUXpKSGl5?=
 =?utf-8?B?cGlRQk5YY1R6YnNVT3ExU01NeEIvRDhOMUJ0Mkk2OWlUV3RmZFh3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3E3AFB5D4413A4E85293EC2DB36D4D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c62ac8-c108-44d7-8174-08debf4443ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 18:41:45.1456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5+XU1Ua1C4VpvFPLVjOCOOkyHyd/sw3glwRwgfHGT1wFAEhMYPVSAZokP9iINueRKNuJ394j6ntT9CQaDc22g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
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

T24gU3VuLCAyMDI2LTA1LTMxIGF0IDIxOjM3ICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90
ZToNCj4gT24gVHVyaW5nIGFuZCBBbXBlcmUsIHJlc2V0dGluZyB0aGUgR1NQIGludm9sdmVzIHJ1
bm5pbmcgdHdvIGZpcm13YXJlDQo+IGltYWdlczogRldTRUMtU0IgYW5kIEJvb3RlciBVbmxvYWRl
ci4gVGhleSBhcmUgaW5kZXBlbmRlbnQgZnJvbSBvbmUNCj4gYW5vdGhlciwgYW5kIHdlIHNob3Vs
ZCBkbyB3aGF0ZXZlciBpcyBwb3NzaWJsZSB0byByZXN0b3JlIHRoZSBHU1Ancw0KPiB1bmxvYWRl
ZCBzdGF0ZSBldmVuIGlmIGEgZmFpbHVyZSBvY2N1cnMgYWxvbmcgdGhlIHdheS4NCj4gDQo+IFRo
dXMsIGtlZXAgZ29pbmcgYW5kIHJ1biBCb290ZXIgVW5sb2FkZXIgZXZlbiBpZiB0aGUgZXhlY3V0
aW9uIG9mDQo+IEZXU0VDLVNCIGZhaWxlZC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBTYXNoaWtvIDxz
YXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBDbG9zZXM6DQo+IGh0dHBzOi8vc2FzaGlrby5kZXYv
Iy9wYXRjaHNldC8yMDI2MDUyOS1ub3ZhLXVubG9hZC12Ny0wLTY3OGYzOTIwOWUwMCU0MG52aWRp
YS5jb20/cGFydD0zDQo+IEZpeGVzOiBhZGI5OWNlM2NjNzggKCJncHU6IG5vdmEtY29yZTogcnVu
IEJvb3RlciBVbmxvYWRlciBhbmQgRldTRUMtU0IgdXBvbiB1bmJpbmRpbmciKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kcmUgQ291cmJvdCA8YWNvdXJib3RAbnZpZGlhLmNvbT4NCj4gLS0tDQo+
IFRoaXMgd2FzIGNhdWdodCBieSBTYXNoaWtvOyBJIHVuZm9ydHVuYXRlbHkgbm90aWNlZCBpdCBh
ZnRlciBwdXNoaW5nIHRoZQ0KPiBzZXJpZXMsIGJ1dCBoYXZpbmcgaXQgYXMgYSBmb2xsb3ctdXAg
aXMgYmVuZWZpY2lhbCByZWdhcmRsZXNzIGFzIGl0DQo+IGFsbG93cyBtb3JlIHRpbWUgZm9yIHJl
dmlldy4NCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvbm92YS1jb3JlL2dzcC9oYWwvdHUxMDIucnMg
fCAxOCArKysrKysrKysrKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9ub3Zh
LWNvcmUvZ3NwL2hhbC90dTEwMi5ycyBiL2RyaXZlcnMvZ3B1L25vdmEtY29yZS9nc3AvaGFsL3R1
MTAyLnJzDQo+IGluZGV4IGEwMzNiYzg5MjA2Ni4uYjEwMjE1MTkwMjU3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9ub3ZhLWNvcmUvZ3NwL2hhbC90dTEwMi5ycw0KPiArKysgYi9kcml2ZXJz
L2dwdS9ub3ZhLWNvcmUvZ3NwL2hhbC90dTEwMi5ycw0KPiBAQCAtMTM0LDExICsxMzQsMTkgQEAg
Zm4gcnVuKA0KPiDCoMKgwqDCoMKgwqDCoMKgIHNlYzJfZmFsY29uOiAmRmFsY29uPFNlYzI+LA0K
PiDCoMKgwqDCoCApIC0+IFJlc3VsdCB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgLy8gUnVuIEZXU0VD
LVNCIHRvIHJlc2V0IHRoZSBHU1AgZmFsY29uIHRvIGl0cyBwcmUtbGlib3Mgc3RhdGUuDQo+IC3C
oMKgwqDCoMKgwqDCoCBzZWxmLmZ3c2VjX3NiLnJ1bihkZXYsIGJhciwgZ3NwX2ZhbGNvbik/Ow0K
PiArwqDCoMKgwqDCoMKgwqAgLy8gTG9nIGVycm9ycyBidXQga2VlcCBnb2luZyBpZiBpdCBmYWls
cy4NCj4gK8KgwqDCoMKgwqDCoMKgIGxldCBmd3NlY19zYl9yZXMgPSBzZWxmDQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5md3NlY19zYg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucnVu
KGRldiwgYmFyLCBnc3BfZmFsY29uKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaW5zcGVj
dF9lcnIofGV8IGRldl9lcnIhKGRldiwgIkZXU0VDLVNCIGZhaWxlZCB0byBydW46IHs6P31cbiIs
IGUpKTsNCg0KU2hvdWxkbid0IHRoaXMgYmUgZGV2X3dhcm4/DQoNCkFsc28sIGhvdyBkaWQgeW91
IHRlc3QgdGhpcz8gIEhhdmUgeW91IHRyaWVkIGJyZWFraW5nIHRoZSBGV1NFQy1TQiBjb2RlIGFu
ZCB0ZWxsaW5nDQpib290ZXJfdW5sb2FkIHJ1biBhbnl3YXksIGFuZCBzZWVpbmcgaWYgeW91IGNh
biBzdGlsbCByZWxvYWQgdGhlIGRyaXZlcj8gIFNhc2hpa28gc2FpZCB0aGlzOg0KDQo+IFNpbmNl
IEZXU0VDLVNCIChydW5uaW5nIG9uIGdzcF9mYWxjb24pIGFuZCB0aGUgQm9vdGVyIFVubG9hZGVy
IChydW5uaW5nDQpvbiBzZWMyX2ZhbGNvbikgYXJlIGluZGVwZW5kZW50IGNsZWFudXAgc3RlcHMs
IHJldHVybmluZyBlYXJseSBoZXJlIGJ5cGFzc2VzDQp0aGUgQm9vdGVyIFVubG9hZGVyIGV4ZWN1
dGlvbiBlbnRpcmVseS4NCg0KQXJlIHdlIHN1cmUgdGhleSByZWFsbHkgYXJlIGluZGVwZW5kZW50
PyAgV2hhdCBkb2VzIFJNIGRvPw0K
