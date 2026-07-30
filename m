Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA2C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E0010EDFE;
	Thu, 30 Jul 2026 07:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTasoA9S";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9AC10EE02;
 Thu, 30 Jul 2026 07:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHc81hAb57PEA5woWml+M2K1n0LMz7fVgSHFO0wlM3dashO54VxLwh1kqIwqboAjiI3myaQJIbAYeuNCRvdsh3g8CXqeSHrfQbYI+7qs1eoYuDa5lcfsHpmX9sikLaCtF9iPTSNjtoiStsAVzJ4L1tjpxFImKOtibhzQqAepjUGOjJJOm6Qwmix/4JtntpxYV9v1YkaAcSO3eK2rgsghJpByR8puwpQGETdj36xgz1A243MsP8sK96fGL1fgEw6X85Upp40uJWSqjKVSszrYJvgSljcbqCL94HKjbc5HMdA5x7Vf455J3ffquHi1dNo1ESwtrMYnADMw34E0v96E6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZt3o4e7fs/MTid31LKC9sDA9xhJIk/d/qyq0j4J9pM=;
 b=GrYr24LjZqQu1cCpt2veA+0olBYRFV9J8Q2mKQjb3Npn5jne8GgkGMObXunmgFHo0+dPapwtpm9tRlMr3S6Rwlq0aPm0hjlP3kLBIQ0MW3gxv67wCD4/4VYfQttbRbZLMjkLRmIYXHh7PM3GwIJyIqHH09TJCg5t48YQdWSpgCmNiTl6j+/brXdBQ+Smxcfp8QHd3hs9VJITDZJ6/kD0JLYqsskPcgkHH/Z25zsX507Gh8zhCHPNe4TjT/lOn3ykLfK6okympqiHSys+lGEjorO6Q1hgK60pmwGH2JfB6LN0xuncU79F17ZYj4VX5PcUDO+BNxCvkD/MLAt0C/avbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZt3o4e7fs/MTid31LKC9sDA9xhJIk/d/qyq0j4J9pM=;
 b=XTasoA9S6HsnuPhJONZEFxVZMcB5WulxgOw6bIVPUW/sq8pISK7kXYWQBnCLVdWQC4YQpRSXrlmcKc6Gm9RWMFeQPKDEk9wVapUMkJqnVNePJMM90xaXzWvm28M09W2ydX26qk8cOPYMDwW9uYA/BYMsEC99mHKROwuVbPyjlpA=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 07:28:06 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 07:28:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Teodor Bostan <teobsn@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add PPTable power limit quirk for ASUS G14
 GA402R
Thread-Topic: [PATCH] drm/amd/pm: Add PPTable power limit quirk for ASUS G14
 GA402R
Thread-Index: AQHdH1yAkSK5Yj+QvUO0we9fHkDvR7aEfHaAgAEjnXA=
Date: Thu, 30 Jul 2026 07:28:05 +0000
Message-ID: <BN9PR12MB52114DA65D11E67D0A6A246B82C92@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260728234626.86008-1-teobsn@gmail.com>
 <CADnq5_NEU98wff+MiLObBByUUMNkkz7XLZ9MUnGNr1e0B+EKvQ@mail.gmail.com>
In-Reply-To: <CADnq5_NEU98wff+MiLObBByUUMNkkz7XLZ9MUnGNr1e0B+EKvQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-30T06:48:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|PH7PR12MB6417:EE_
x-ms-office365-filtering-correlation-id: edea75fe-0a64-49b5-f926-08deee0c18f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|3023799007|18002099003;
x-microsoft-antispam-message-info: 7MAtFNyphyp+2tVjrJ22zyePHJq9zLU5rEUQHz9j1VJGAGI6PvtRmy1RfcbElKnCwI0+20Et5WOKTYiER1JLhGTwIasZm68VFwoYkrVWTjWVjeQ+lmoCjUKWZtCFwjF0NIEu/2/RKSMTAGYCzK0opkD6kq9Y22t/Zq+Olu0ZNZ23HTcD/eDPJEwzAuxaX5YJD7NRUFdxsv3egjDY6VNjePfLZyeWTFDcg9Qly131WvlEIfsHOkko3Ey2U+2MiFNqTBQTNZ0VL8PYi9egt0xyDSiVabQlmXe26Xzn0zIKJJDX5B4GEmY8pp96Lmz9OCQFybjW+pJzLgxxLZ/CwtTjUqLxvoghgOpJrbAOTPpojqVEYB40WesBFLkVpAZTrUBHM5oCH9Qti5hQniSZKHivKbtwhAJB5x/FnIzIUMJjukCy1+WLr56944jg/pI3AilILbislq7FBp7BFvbAPrR5aqj4fqatbz+R5tZ9LijnkgMITwwbr1mVTUKnIG1qOmTKsTiYvIP1lUMBTvAitPfv4/EEMGbYL4rDDPdCKL9grY24s9ofm98M4ShaUmN/p1sTDpIKicX1QYoCRMUHq3Ybl3cayty8LhgUdIqMgq/5fSpsxv500EaU5JuRoqRqqaLdsLvr0j9+OTcheethlRSNuH6cstmKfF/xww6nvrngtjnKHqWiz+RcnliIZlWAmKQXN9lJW48W4qIwFYncNYphWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzNPdzVqR2ZDZlBHV1IrR2ZsZThqWE1QNHFjVkxYQnBWVytPeDc3dWx5TEpz?=
 =?utf-8?B?Rk5OaUd0emRieFNqNmFnNmZMbkpQNVM5WCthVElsQmcxUG1nZnIrWmhTNmQ4?=
 =?utf-8?B?YUluZXd3V3ZuVnhsTzdQTlBGcTgrZVNmTytlMmZVSU9XOUlCTjZZZGdrWFdQ?=
 =?utf-8?B?VGt6azRzODZ5VGNNeVd4ck8yL2ZZSlAxc3J0MzlZSGRpMVltejlVSU1pZk1Z?=
 =?utf-8?B?VVFhU01lVEFoODgrRTVxZHZOS2hyNm5vY1kwSXVXUDdDdFhBY3hYZUxxNGlL?=
 =?utf-8?B?bGRlVGJ2b3pOTnpyUFVVLzBLNi93T05xRnNWNFRQMTdLM1BtODdCR01zV1Vz?=
 =?utf-8?B?TkhjcGtIZUsyQTVoRTB1Z0pTWHJxcUdCSzdqSGQvd1ArblNwUHR1ODlWQnZZ?=
 =?utf-8?B?R2k0c25McEhndisxTDBEa2xERzFZOHRERUNsSnFoTm9hamo4R3dJZVZ4R1U5?=
 =?utf-8?B?cTVZSW1NSlpxT01Ua01kdGZIeGJ5VVQyQytqeVM3Nlk5a1ZxTGRPQWYvZCtF?=
 =?utf-8?B?dHpDL1VyWnBNWFpxL1RBUDMyMmxPS1RHWDhsL1E2aGUwL3RRYjNveGlscXph?=
 =?utf-8?B?VFVNcVplaXd1ZUFpRCsxVEx1VmgvWnFYMlRkQ1BuQVh4MW9wajZUSEt4SUdW?=
 =?utf-8?B?UG11YjJiMXgwaFE1aTFMNUdXQlZrOUNudm9PbUpYMXBnaEFKUGlZNXVFK2l4?=
 =?utf-8?B?QlptclRjMXpwR0ltTFNlTWZneUhvVEVpd3VRZ0huUE9UaXAvQmVnT1BROGQy?=
 =?utf-8?B?M1FuZXh0c3FnaVRjTllOa2pXUitEVXdobm1IeVpxazMzdmF5UHBmZHR5QkNF?=
 =?utf-8?B?VklpN0lxLzJZSGxZcGlyL0lldE04RDBOWmZSQ29LZ1FXSmRTRXFBNUxDblAx?=
 =?utf-8?B?TDVzcnpUY1o2dHJsU0IzMXNmOVJqNzlvZHFHcFllS1p0b0lWNkdzbHpPMnFn?=
 =?utf-8?B?QmY5WXJjbnRaRkFRdWdtOGxlME1ya3BlVnAwMkZMZmRDcGhubm9IcXRkSFFO?=
 =?utf-8?B?RzIwdm85ZTlrckJkMzJCYW5jWU5aZEQ3SW5mZ2hrN2xKcXFWaUdEVjNUVytz?=
 =?utf-8?B?WkN4NG1HZlZKM3o3S2Fjb1Z1a2dRZ3QvU0YwYnRVTzljV1IxSzE0VXZ1NE5k?=
 =?utf-8?B?dzNzcVBGeW53MnE2eEZDTFd5WktxNXpkWjE0eFkwYndaSDRBUnZjZzdVWCsz?=
 =?utf-8?B?Q21BSk1OT1ZqUE5xOW9jcTNpYUdCS3VKelZQWWRWTUVmZGtHRGdjVE11MmM5?=
 =?utf-8?B?QWdBUTdrOFhsampIdi81NWxISVR6WEh5dTBhdHZXbHp4Vng1cHFoZU1qQW5F?=
 =?utf-8?B?TS8yWk1LMU0vWVM2cEN1cDdkY2RtZmJnRUFvbVhQRDh5Ni9wUmNiYWZYdmhY?=
 =?utf-8?B?R0dFci90N1ZFK3hGQktZQUYrRm1TVWR0cWhPRDF1US9ZMWROdTZ4R2hwZktL?=
 =?utf-8?B?RlY1WTNBcTl3MThETDJieWQwb2MzNHNjaXRNNVRkQmM3elBDR1BHMUVJWHZ4?=
 =?utf-8?B?SWwxZmpWTnZZYmhrMnVBT1VBMUJlRzZyWGFEd3J2RWMyR2tnK1VWS3dzdEUv?=
 =?utf-8?B?N1JUb0w1U1hMaFFJUGlxVXYzOHVZN2RIblREVFFtUVFrZVd1eWhYN0hjT2or?=
 =?utf-8?B?WklCWGJrWEEyRzhPZ01za1FXOXljUUk5cVF3TTJDSXVDMmdhWDlsd012L1Vo?=
 =?utf-8?B?MElPcldoc0FDYnZybjR5TFhHazB4ZGR0Q2ZQc3pobE5HZk9qeVFFS0hZWER5?=
 =?utf-8?B?c1ZINzVnTHpseFJCTEJ0M1J3RUlVblo1YjFTN2xiQ1N2ejZKNmFwSzlxUUxM?=
 =?utf-8?B?eVZia09uWFk0VFNvZWp1dTRPSzJ1S0tlSERhdnM1KytRcGIxZkRVT01zK3pz?=
 =?utf-8?B?OFJEUlA3Uk42T0xIYlVMcXQrdkJiL3dvQytxZnhNZ3RsS1NGN3NORkNNa2cw?=
 =?utf-8?B?dEtzUXJ6SHlTMnVTckFkWEJuQjNnMUcyNzQwa1kvNzJzMFpkVEpVeWhNNHZL?=
 =?utf-8?B?ZHhFdmt0OXFKQkZEbTFjSjVNaTJhME1QQ2c0SDVWMWJSME1Kc1dvRmJGQ3hQ?=
 =?utf-8?B?Q0tLTjdpSVB0cmppdjhUWjZacEpCa3NMWGtHUGhxWHpCb3Bmb256bnZVMWds?=
 =?utf-8?B?R3Y4eG9XcE9jQjhxMS9sMXMrVWtJS0x0QjBIWjZ1WDBjcUl4NnlnUGdGSjdL?=
 =?utf-8?B?bGNJVk9qNXRENDB0NllHbTZtSFN6V1pLSkpTOUd2dmJnZUxzSVF2Sjg1Tkg3?=
 =?utf-8?B?Y2JuWVorQU1qdm5yV01ZaXcyVjJIUTdEcWh2bUEwZ0d1cWlERkd4Ny9CNnVh?=
 =?utf-8?Q?+e3DGNSwcgSE1In8Ur?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edea75fe-0a64-49b5-f926-08deee0c18f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:28:05.8950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM4o/u0jCiAnAzQHUFl2IE6t5Sa5/kpDdrnxXN28Jj7SGmOs6TFRMrvqFg4RA4fd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5
IDI5LCAyMDI2IDIxOjI1DQo+IFRvOiBUZW9kb3IgQm9zdGFuIDx0ZW9ic25AZ21haWwuY29tPjsg
V2FuZywgWWFuZyhLZXZpbikNCj4gPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFt
ZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGltb25j
aWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsNCj4gZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBB
ZGQgUFBUYWJsZSBwb3dlciBsaW1pdCBxdWlyayBmb3IgQVNVUyBHMTQNCj4gR0E0MDJSDQo+DQo+
ICsgS2V2aW4NCj4NCj4gT24gV2VkLCBKdWwgMjksIDIwMjYgYXQgOToyM+KAr0FNIFRlb2RvciBC
b3N0YW4gPHRlb2JzbkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQVNVUyBST0cgWmVwaHly
dXMgRzE0ICgyMDIyKSBHQTQwMlJKIGFuZCBHQTQwMlJLIGxhcHRvcHMgdXNlIGN1c3RvbQ0KPiBB
Qw0KPiA+IHBvd2VyIGxpbWl0cyBvZiAxMDBXIChSWCA2NzAwUykgYW5kIDEwNVcgKFJYIDY4MDBT
KS4gT24gcmVzdW1lIGZyb20NCj4gPiBzdXNwZW5kLCB0aGUgU01VIGZpcm13YXJlIHJlc2V0cyB0
byB0aGUgcmVmZXJlbmNlIHZCSU9TIGRlZmF1bHQgb2YNCj4gPiA4MFcsIGhhcmQtY2FwcGluZyBH
UFUgcGVyZm9ybWFuY2UuDQo+ID4NCj4gPiBPdmVycmlkZSBTb2NrZXRQb3dlckxpbWl0QWMgaW4g
c2llbm5hX2NpY2hsaWRfcGF0Y2hfcHB0YWJsZV9xdWlyayBmb3INCj4gPiB0aGVzZSBzdWJzeXN0
ZW0gSURzIHNvIHRoZSBkcml2ZXIgcmVzdG9yZXMgdGhlIHBsYXRmb3JtJ3MgaW50ZW5kZWQgQUMN
Cj4gPiBwb3dlciBsaW1pdCB3aGVuIHJlbG9hZGluZyBQUFRhYmxlIGR1cmluZyBib290IGFuZCBy
ZXN1bWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUZW9kb3IgQm9zdGFuIDx0ZW9ic25AZ21h
aWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2ll
bm5hX2NpY2hsaWRfcHB0LmMgfCAxMw0KPiA+ICsrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+ID4g
aW5kZXggY2VmNjI4NzUyLi4xMGQzMzBlZGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4g
PiBAQCAtNDc5LDYgKzQ3OSw3IEBAIHN0YXRpYyBpbnQgc2llbm5hX2NpY2hsaWRfcGF0Y2hfcHB0
YWJsZV9xdWlyayhzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSkNCj4gPiAgICAgICAgIHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KPiA+ICAgICAgICAgdWludDMyX3Qg
KmJvYXJkX3Jlc2VydmVkOw0KPiA+ICAgICAgICAgdWludDE2X3QgKmZyZXFfdGFibGVfZ2Z4Ow0K
PiA+ICsgICAgICAgdWludDE2X3QgKnBvd2VyX2xpbWl0Ow0KPiA+ICAgICAgICAgdWludDMyX3Qg
aTsNCj4gPg0KPiA+ICAgICAgICAgLyogRml4IHNvbWUgT0VNIFNLVSBzcGVjaWZpYyBzdGFiaWxp
dHkgaXNzdWVzICovIEBAIC01MDEsNg0KPiA+ICs1MDIsMTggQEAgc3RhdGljIGludCBzaWVubmFf
Y2ljaGxpZF9wYXRjaF9wcHRhYmxlX3F1aXJrKHN0cnVjdCBzbXVfY29udGV4dA0KPiAqc211KQ0K
PiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIC8q
IEZpeCBzb21lIE9FTSBTS1Ugc3BlY2lmaWMgcG93ZXIgbGltaXQgaXNzdWVzICovDQo+ID4gKyAg
ICAgICBpZiAoKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDczRUYpICYmDQo+ID4gKyAgICAgICAg
ICAgKGFkZXYtPnBkZXYtPnN1YnN5c3RlbV92ZW5kb3IgPT0gMHgxMDQzKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAoYWRldi0+cGRldi0+c3Vic3lzdGVtX2RldmljZSA9PSAweDFERUMpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBHRVRfUFBUQUJMRV9NRU1CRVIoU29ja2V0UG93
ZXJMaW1pdEFjLCAmcG93ZXJfbGltaXQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBv
d2VyX2xpbWl0W1BQVF9USFJPVFRMRVJfUFBUMF0gPSAxMDA7DQo+ID4gKyAgICAgICAgICAgICAg
IH0gZWxzZSBpZiAoYWRldi0+cGRldi0+c3Vic3lzdGVtX2RldmljZSA9PSAweDFEQ0MpIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBHRVRfUFBUQUJMRV9NRU1CRVIoU29ja2V0UG93ZXJM
aW1pdEFjLCAmcG93ZXJfbGltaXQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBvd2Vy
X2xpbWl0W1BQVF9USFJPVFRMRVJfUFBUMF0gPSAxMDU7DQo+ID4gKyAgICAgICAgICAgICAgIH0N
Cj4gPiArICAgICAgIH0NCg0KQWhhLCBJIGJlbGlldmUgdGhpcyBpcyBub3Qgcm9vdCBjYXVzZSBh
bmQgdGhlIGFtZGdwdSBkcml2ZXIgc2hvdWxkIGF2b2lkIGFkZGluZyB0aGVzZSBoYXJkY29kZSB2
YWx1ZSBmb3Igc3BlY2lmaWMgZGV2aWNlLg0KYW5kIHRoZSBhbWRncHUga2VybmVsIGRyaXZlciBy
ZXN0b3JlcyBwb3dlciBsaW1pdCBzZXR0aW5ncyBhZnRlciBzeXN0ZW0gcmVzdW1lIGluIHNtdV9s
YXRlX2luaXQoKSBzdGFnZS4NCkkgd2lsbCBjaGVjayBhbmQgcmV2aWV3IHRoaXMgc2VxdWVuY2Uu
DQoNCkZ5aS4gc211X3Jlc3RvcmVfZHBtX3VzZXJfcHJvZmlsZSgpLg0KDQpCZXN0IHJlZ2FyZHMs
DQpLZXZpbg0KDQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+
IC0tDQo+ID4gMi41NS4wDQo+ID4NCg==
