Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A36C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C3B10EFD7;
	Wed,  9 Sep 2026 08:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sM10aeQV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42BB10EFD6;
 Wed,  9 Sep 2026 08:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZOJRbxQTDyte0as3aOLOqeehURo6KbTrs+SZ0nr3g0Lp1MyLCA1NBXsaBlRQFuaTUX2F9s9vXD2laJ8nJREOBxj3RJ+exRumomq8rAG09jMl+f0+M7D4JqRVbCmIVY0B9xAkaL/vLsih4yOHhHAhG6zvTLzYw6WM+U2XGesMG+7WLpzCvF8jiLQvVeP2C9HVSK/RMbeGlTpNhIWpoeOgTfzESk8t6zyXlSDhe1FvX++xlpUKlR9YS/0/VPQIKfSYS52smSgdkisX8YhrWKo/xd91ehweb4xjnVvvy0I55FC5HUnxMBAL55bywBotw8tG5kCdSMJuLiFLRrZpOWN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LctsjTWCn7jY6g+shkWzuD0YjrGq4vUkmVVKGjGA4VI=;
 b=NEEYJeaNe5WYpO4e59dqFyJvbN/ExilXLzTktpJl9Rlr8OA+v7jrvNlOCl2GL48KirUeSqZRl+SID2ulAvP/WRFk8+tREAWToeh/IY4YOxl9D4eW3UveQmT2tca3hajUxdPnG8NKY/Co/8OOAaYJjUVBET6Zu6EgxlL1io6LD3xM4wQSWQsQdkh332teMv4oVU2eEb3RaQ0dUjwqrtjukjy3JHCMN9bNvGVmo4kxG9cj97hOJopzEhniyFCFOrTyHLAS9pgiE2uQGllY8yITVFayKbEu4TGnc0O1mPULxs7n+1Shk61dbB4Z7ot3TMnz3LJsFHcWGPevXqugWifEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LctsjTWCn7jY6g+shkWzuD0YjrGq4vUkmVVKGjGA4VI=;
 b=sM10aeQV9Lsl6IHCv7/v2IzxvQvfKSWO0vSgQBuHP1a6hP8MCz7bKH13bHx2k72IhfeZILvKr08Nt9CFMZhaFG5rLyH8yb7GbIwzaP4V8W+Slbn5Pm0C1ver3qpd+BG90zTYFlrIMZUIrM6IjJ4wT6Amlx/IUHma61MqZ5ye/qo=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 08:39:31 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:39:31 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Ed Schofield <ed@aicharmers.com>
CC: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, "Guna R . Bharati"
 <062bel313@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Thread-Topic: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Thread-Index: AQHdM/uLjqzkZB8+v0CfrEH3NFaxZLbF5zkQgAAT1oCAAAkRwA==
Date: Wed, 9 Sep 2026 08:39:30 +0000
Message-ID: <MW4PR12MB680331D488C107E4419315AE8EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
 <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
 <20260909080231.85025-1-ed@aicharmers.com>
In-Reply-To: <20260909080231.85025-1-ed@aicharmers.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T08:34:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|LV3PR12MB9093:EE_
x-ms-office365-filtering-correlation-id: 4258058a-7f8f-452a-de0b-08df0e4dde13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: gDYE8VgbFHNXuT+0d9xaTBKucjm0UrRQe4HzlQlcmBTHjdlxfMyNTmFBzChxAgLINleCpPhav9Iftpv+PZdIhTzVN/RLs4aM8uLaww3sLlpDJvWNmrMrea9RPxmXTsZcYyK/7y4cSgvYt8ByAPAkXJ+oAN8hNVv5+LPpF99c3gAJQgxNPtLfoNpFlZ7gD+3tsNPPUq5NXUCwoE+/AMWD3URJ3YAMPFJ2IttlsAYhQvOfB/aSv5+jMkPJ/KjVe0epYCt5cmHIkS77QIbn57/tdDTdIwpHkRxHKovdOmc+A/R4bQC3HK8T1sU8jVjouP7RaijkadMKB7FRJSIpthmkfgM7Svw+MCuEd4Tla4mMkyYpkBFDi5k46RKVTJ35xIQtirkTjsTGZjgKtCoX61zzeGQkhYtse2zEDlFhC6d7wMcZ64RuoEFLnsYMrfc5/TSbHoN2hVwzeuNXCJcruSWwz+DKQPeB4mD/ZhN666/hCMTtJGU480K03FcbblDiVLnHpu7HcC/Emh9aMoG0WN9qdvWBskZxJ0GpTdwsGk4attXrppKAEHviEFMuqhKNurejtRcEd87O20RVveVXNiYwFSV2HtkPCveS0ipD5n6WSQF90gntfVGgVaDIyuQfUqODkgxs+TvQgPkeEaOTgsHrcf66CgXlSM35VCcfmWsEw+WQ+8XwVtNINYs89JaPGF54nuG6xuNeDRXGh6NAJ7B2vg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVBiL2hsN0RLcDRtUVhneTE4Zkh2WDJiYU42QjJlTUZpODRndkkyTU82Qkx5?=
 =?utf-8?B?Y3ZhY1ByL3I0UW9sMHlrT3U3V0pRdjJiQnJibnYrK3BTYjV5M0NQYjU5cXR2?=
 =?utf-8?B?SFpXNkpWUSs0cStLSFZoYXlYbExEWTJLeXJmNGxKM1VzcmpmYXpiYkIyTnE0?=
 =?utf-8?B?bTBPSzZwQnBGbGVPOFovSU82VXpKTU9IQjRQbTd6dUM5b0JPeTRwb2hoWms1?=
 =?utf-8?B?VlFDTXkvWVNKYTBGVXRVY1ZvTjhvWjA0Mmt5MWxMYm93eGtvQTlNbWZGU1FL?=
 =?utf-8?B?VnhGYk15UnRmU0RsdEM5MkVUQnp1cEM4T3lrRk1ZQWJjM045dit6YnErL3Zy?=
 =?utf-8?B?Nnl3V3h3L0FpNXdocVdRRkNjeHl0a3RYeCttMGdQUDllQU40bGNMUHpFOVNh?=
 =?utf-8?B?YXZZQlFKMEpKb3lCTm9XMFdqazNMRWVKbVM4VG5kZEF1cU1HbURWK1ZoRnRB?=
 =?utf-8?B?czFvT2tyc1VjeUsrUnlmZ1hvTmlrWW5KZHNrQTBqdmZyQXE5MTZxNmVxUU9U?=
 =?utf-8?B?dUhuQVI0MnNGdU95Y1Urb0piN1NYTlY2R1lnNEdydlNrNFVTN2R3eXhJZjRP?=
 =?utf-8?B?K0hvSGc0VkNFdnJLaGFCY0xjOTl0RERYa0pqSHRYNWE2Mms5bFlWVHl3Y1dZ?=
 =?utf-8?B?U25Sd0pJaEVDQVdtalI1dHFxcDMyWGxHajNzdjZsc09kMHliR1dVMEY2T25E?=
 =?utf-8?B?bTNLMTMwWW9TYi9yMjhpeFg0ODJYSUg4eGN1c2JJKzdJajVoQTFwbmZ2THdR?=
 =?utf-8?B?ZmFMVG1zNXBoWEhXOXpadUZ2T1V6THNOUDdiOFF1YklTRkJ2QnlXSHFrOE01?=
 =?utf-8?B?S2dLNnhzVFE2WUl2WTRBZjZZMzhNT09sVGY2VTRSVmtWUHREU25SdllpaFkz?=
 =?utf-8?B?RWRjR2xtL05vQXlpSU16NEFqZnZGclFzSkpDZ1l6WSszL2xHUGxRTGFuNnVv?=
 =?utf-8?B?M3BZVG1BWlRNVzNQaTd2a1p5dTNTYVdXRjQwK2RQMnZabFJWNlVTQVpoRzV6?=
 =?utf-8?B?L1F1NSt0K0FRcU9WbHcvTnZDd0VoNVExMWxrZWhQS29QdkdWMlVodWJ6M0Vz?=
 =?utf-8?B?dnI1dnNidjczVzIvWm5WUkNFY1lVSjc2bUNlaGExTjNVN1orbEEwbHoyNW8w?=
 =?utf-8?B?T0ttdUg5OUVyUEZHcXA5UzlacVZ6RFlMTkJHL211NHN6RGNFZW4yYmk1OHRH?=
 =?utf-8?B?K2tXSStwWFc0VmpQV0NaSmtDOHRqanE1aFBUamxnTmhtdlJtS0VMRmtTbkw2?=
 =?utf-8?B?ZGN5MmRFaGlPNS9VZkU1RTdXNlNLUGlUQzNscHFIcFNtcUFtbGhBbGJvWFFh?=
 =?utf-8?B?Wm9nQ0FxY0pEemo5aUl6Q1NUaGR1SkdTeEUrakpPZWpnTEMwZmZkY0FxcERy?=
 =?utf-8?B?bEZjK2lteGlwZ0tCMEdOWjMyZVNVN3V0R1M1V0xXYVQxOE5NWm1JNGJwbmJC?=
 =?utf-8?B?SnlFeEk5b1hwKzBQMUpsU1RZeTlmQVpuWjYvV25xR0tONldMdXBoL3VnWk9O?=
 =?utf-8?B?ZXZocE5JWDFkNyt4UEhST0NGa0NJc3NVYTRERXE3b3pMRFBXQllRdllOK1NX?=
 =?utf-8?B?anYwakN3NjBCYjJiVytzY2dxVkpSSGNnK2laM2VhQitTT0I4MTc4RW1uYmRX?=
 =?utf-8?B?ZXpNcWxtRlY1bjAzMEtTM1JldnM4YlVxSE1MbEFoYkkvTHExSnlqM2xYdlZn?=
 =?utf-8?B?TE5EWGczK2VaQlVuckRsOFJGMVpwZFo2MkY2eHhtNys2VzIveFNsSEMxeGY2?=
 =?utf-8?B?M2ZJVjFLUStwWlJpd3FWbStWVCs0d3NzSFM2ZGx5aWtmMldOb1BhM2p5Y281?=
 =?utf-8?B?V2VGckpIM2RSem9xdktGaWI4cGdmbTFlTHFHbUlINmRPNm1NS1pTcWtWaHFt?=
 =?utf-8?B?SWpkbUMvL1VnYzdtaWlVWUNINkJUci9OMkNHSWdWcmZsd2hzbFNIb2w4dmFN?=
 =?utf-8?B?ZWtiOEhDNHlwdWR6MXNwUU1IUFZ1MWNuSzRsd2NaNTN2Nnc2ZkhaTTJPVmtj?=
 =?utf-8?B?N0pidkt0UEh6ZjVtSDU1MVNlNGNobkNUTEVYTGgyWm9RV2JhQUJGL2hCL1A5?=
 =?utf-8?B?bXZlNzVuV0h2MGVYSU03SWhLUzFmS2xWREVNWWhBRXgrSDlkeU52MGtteDE5?=
 =?utf-8?B?VG9aRWcrZElFYkRsdnl1ZnY0Nmx4WS9Xd0dVVDRmTzVxdm5idXo0TXI1bGc2?=
 =?utf-8?B?eGFkS3h0NkdCRTdHUGJnT3k0ZGRqckNqTFM5N2ttZEszZ0k4eElpU3IvbFhV?=
 =?utf-8?Q?FncHJ1HxYCJ4gmVHnUJN7+HsqufLB2/2bLqD2Naobw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4258058a-7f8f-452a-de0b-08df0e4dde13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 08:39:31.0649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jHU7y/iQoK+0SZUPf4DR4LsKSuVhxrgAAJ82MifCbPUw9idr8nML2cBTUyB/Kcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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

QU1EIEdlbmVyYWwNCg0KT2ggb2ssIHRoYW5rcyBhIGxvdCwgRWQuDQpTaW5jZSBpdCBpcyBMaW51
eCwgSSBhc3N1bWUgdGhhdCBBcHBsZSBkb2VzIG5vdCBwYXkgbXVjaCBhdHRlbnRpb24gdG8gaXQu
DQpPbmNlIHlvdXIgcGF0Y2ggaXMgbWVyZ2VkIHdpdGggQXRoYXJ2YSdzIGFuZCB0ZXN0ZWQsIHRo
ZW4gd2UgY2FuIHJldmlldyBhbmQgZ2V0IHRoZW0gY2hlY2tlZCBpbi4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRWQgU2Nob2ZpZWxkIDxlZEBhaWNoYXJtZXJzLmNvbT4N
ClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDksIDIwMjYgNDowMiBQTQ0KVG86IEZlbmcsIEtl
bm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KQ2M6IEF0aGFydmEgVGl3YXJpIDxhdGhhcnZh
dGl3YXJpbGludXhkZXZAZ21haWwuY29tPjsgR3VuYSBSIC4gQmhhcmF0aSA8MDYyYmVsMzEzQGdt
YWlsLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhaXJsaWVkQGdt
YWlsLmNvbTsgc2ltb25hQGZmd2xsLmNoOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9zbXU6IEVuYWJsZSBVQ0xLIGFm
dGVyIGluaXQgaW4gQU1EIFJhZGVvbiBQcm8gNTMwMA0KDQpIaSBLZW5uZXRoLCBoaSBBdGhhcnZh
LA0KDQpUaGFua3MgZm9yIGJyaW5naW5nIHRoZSB0d28gdGhyZWFkcyB0b2dldGhlci4gSSd2ZSB0
cmllZCB5b3VyIHN1Z2dlc3Rpb24gb24gbXkgaU1hYzIwLDEgKDEwMDI6NzM0MCAvIDEwNmI6MDIx
OCwgcmV2aXNpb24gMHg0MSksIHdpdGggU01VIGZpcm13YXJlIDUzLjM4LjAuIEkgdHJpZWQgdHdv
IHdhcm0gYm9vdHMgYW5kIGJvdGggZmFpbGVkLg0KDQpPbiB0aGUgc2FtZSBBTUQgc3RhZ2luZyBi
YXNlIGFzIG15IFJGQywgSSBtb3ZlZCBVQ0xLIGVuYWJsZW1lbnQgdG8gdGhlIGJlZ2lubmluZyBv
ZiBuYXZpMTBfc2V0X2RlZmF1bHRfZHBtX3RhYmxlKCksIGFsb25nIHdpdGggdGhlIHJlYWRiYWNr
IGNoZWNrIGFuZCBzdXBwb3J0ZWQtZmVhdHVyZSB1cGRhdGUuIEkgcmVtb3ZlZCB0aGUgbGF0ZXIg
ZW5hYmxlIGFuZCByZWZyZXNoIGZyb20gcG9zdC1pbml0LiBVQ0xLIHdhcyBzdGlsbCBleGNsdWRl
ZCBmcm9tIGVuYWJsZS1hbGwsIGFuZCBib3RoIG1lbW9yeS12b2x0YWdlIGZlYXR1cmVzIHN0YXll
ZCB0aGUgc2FtZS4gSSBkaWRuJ3QgYWRkIGFueSBkZWxheSBvciBleHRyYSBtYWlsYm94IHRyYWNp
bmcuDQoNCkJvdGggYm9vdHMgcmVwb3J0ZWQ6DQoNCiAgICBTTVU6IE5vIHJlc3BvbnNlIG1zZ19y
ZWc6IDggcmVzcF9yZWc6IDANCiAgICBpbiBwYXJhbXM6MDAwMDAwMDgNCiAgICBBcHBsZSAwMjE4
IGRlZmF1bHQtdGFibGUgVUNMSyBlbmFibGUgZmFpbGVkOiAtNjINCg0KQU1ER1BVIGZhaWxlZCB0
byBiaW5kIGluIGJvdGggY2FzZXMuIEkgY2hlY2tlZCB0aGF0IHRoZSBleHBlcmltZW50YWwgbW9k
dWxlIHdhcyBsb2FkZWQgYW5kIHRoZSBmaXJtd2FyZSBmaWxlcyBoYWRuJ3QgY2hhbmdlZC4NCg0K
VGhpcyBhbHNvIGZpdHMgYW4gZWFybGllciB0ZXN0IHdpdGggVDIgNy4xLjguIFdpdGggVUNMSyBl
eGNsdWRlZCBmcm9tIGVuYWJsZS1hbGwsIEkgdHJpZWQgZW5hYmxpbmcgaXQgc2VwYXJhdGVseSBp
bW1lZGlhdGVseSBhZnRlciBzbXVfdjExXzBfc3lzdGVtX2ZlYXR1cmVzX2NvbnRyb2woc211LCB0
cnVlKSByZXR1cm5lZCBzdWNjZXNzZnVsbHkuIFRoZSB0cmFjZSBzaG93cyBFbmFibGVBbGxTbXVG
ZWF0dXJlcyByZXR1cm5pbmcgMHgxLCB0aGVuIEVuYWJsZVNtdUZlYXR1cmVzTG93IHdpdGggYXJn
dW1lbnQgMHg4IHRpbWluZyBvdXQgd2l0aCByZXNwb25zZSAwIGFuZCAtRVRJTUUuDQoNClRoZSBk
ZWZhdWx0LXRhYmxlIGZ1bmN0aW9uIGlzIHJlYWNoZWQgb25seSBhZnRlciBlbmFibGUtYWxsIHJl
dHVybnMgc3VjY2Vzc2Z1bGx5LCBzbyB3YWl0aW5nIGZvciB0aGF0IGFja25vd2xlZGdlbWVudCBk
b2Vzbid0IHNlZW0gdG8gYmUgZW5vdWdoIG9uIHRoaXMgYm9hcmQuIEkgZG9uJ3QgeWV0IGtub3cg
d2hldGhlciBpdCBuZWVkcyBtb3JlIHRpbWUgb3Igc29tZSBvdGhlciBpbml0aWFsaXphdGlvbiBz
dGVwLiBJJ2Qga2VlcCBwb3N0LWluaXQgZm9yIG5vdzogdGhhdCB2ZXJzaW9uIHBhc3NlZCB0aGUg
dGVuIHJlY29yZGVkIEFNRCBzdGFnaW5nIHdhcm0gYm9vdHMuIFRoZXNlIHRlc3RzIGRvbid0IGVz
dGFibGlzaCB0aGUgZWFybGllc3Qgc2FmZSBwb2ludC4NCg0KQXMgZm9yIEFwcGxlLCBJIGNhbid0
IHNwZWFrIGZvciBBcHBsZSBvciBjb25maXJtIHRoZWlyIGFwcHJvdmFsLiBJJ20gdGVzdGluZyB0
aGlzIGFzIGEgTGludXggdXNlci4gRG8gd2UgbmVlZCB0aGVpciBpbnB1dCBiZWZvcmUgbWVyZ2lu
ZyBhbiBBcHBsZS1zcGVjaWZpYyB3b3JrYXJvdW5kPyBJZiBzbywgY291bGQgQU1EIGhlbHAgZmlu
ZCB0aGUgcmlnaHQgY29udGFjdD8gSSdkIHN0aWxsIHdlbGNvbWUgYSBmaXggZm9yIHRoZSB1bmRl
cmx5aW5nIGZpcm13YXJlIHByb2JsZW0uDQoNCkkgYWdyZWUgd2Ugc2hvdWxkIGNvb3JkaW5hdGUg
dGhlIHR3byBwYXRjaGVzLiBNaW5lIGNvdmVycyBvbmx5IDAyMTgvcmV2IDB4NDE7IEF0aGFydmEn
cyBjb3ZlcnMgMDIxOS4gV2UnZCBuZWVkIHRvIHRlc3QgdGhlIGNvbWJpbmVkIGNoYW5nZSBvbiBi
b3RoIGJvYXJkcyBiZWZvcmUgYnJvYWRlbmluZyB0aGUgbWF0Y2guDQoNClRoYW5rcyENCiAgICBF
ZA0K
