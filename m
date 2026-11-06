Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D6606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JqGqCa3L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5CD10E467;
	Fri,  6 Nov 2026 20:51:26 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FBA10E467
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9RIuksxnuURnJlDzTgUtSSLSf+3OUQMPF99Gy3mtxqgW9ae9I7ntC6BcwTnE3yWHCjiHxuVnvHMmmD/vjJc6VpngNHkkJu5FuHim+sdE277wZatdcfYzXsDSw8lFoxA54Jlxn6mpzsgMdVh0aHokYoYnwUJAAWTbBF/yjQB0c86Kj4v7F7m7xBW9kkdAVFUJeR92yLdkLYAWv469qr+43u7estpxrbGsfukuQbSTNyRlbbedv6WXkPtkcW/R0JVeDkpTnptRQkE2SBTQbu0K+SJ4L4Iae3aDL1ys9V2i3mymKf+ChBE9sDH20u5YGda/Tp9Emi8GBhoaOKRrwalXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYTHLmMmm7+070+2VMb6MLwePHRR5xEsC38Plzd3q44=;
 b=URKKk9qfhq0aTLMbCQPvozD1jkQJjd4XL412agSEscb+0se6Kx0nCuSDX+4qMFZ+dHs8ZYKq/W0KFcDilTQHL83SpLrnC4Qb3OTptoPfWcoiScRc6HAJYUJHKccrsmtlsPyhLozsTm33YoHMi1qEnX5GKjO9kq2Cdhmj0NpeBt4o4dFRrfwrWOpPIzsBlDQXVXzifiTT8JzDzs2Ir0cBf7rTk4k9vUWYVQrHdipcp52WFsv+PhRjYwpemks/7DwxCCppoLzXD212CnaxRcmnZIQ8OitrOIkBq/0bX6VaVSIn2lmkYg7xnlFqJ2YCINH+FuLDgNB5Qyb3tt4cRNX/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYTHLmMmm7+070+2VMb6MLwePHRR5xEsC38Plzd3q44=;
 b=JqGqCa3LbscRZiganvkFJEcZKjp4xBtnhbS3nGEaos0W+yYYTuKGm0WtHvSnE4OMQ0Gq70CNOLlwRxX/IZgG9XKhEF98srxr3Vsw/fN1f615NWFfvmlJov0VGr4EAgZIUjfKm03q+xikRusQ0DSNc1ZdKN5IG+SsnQesRVDw+s7k8nMEUFbE3pujvn9P1x4r0I6YdtWFXngpn8FqtewgpnE9GiodnzINlZOfQstKcJ3DM/P3p2W5ZGExuZDTQC2H3F3ATPDPS5nyKea/yWozTbESV9prwdNaTsPWsrMZPnJi+AlIgxrw9SdZUx4GK4WMTbzhAEZlDEBWOmuM6usGtQ==
Received: from MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 by DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 20:51:16 +0000
Received: from MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a]) by MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:51:16 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>
CC: John Hubbard <jhubbard@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>, 
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dakr@kernel.org" <dakr@kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
Thread-Topic: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
Thread-Index: AQHdW/MitWMU2rVbPEKgo0OePHoFa7chqTqA
Date: Fri, 6 Nov 2026 20:51:16 +0000
Message-ID: <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
In-Reply-To: <20261014154554.231015-1-vladazaharova2018@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8568:EE_|DSSPR12MB999236:EE_
x-ms-office365-filtering-correlation-id: ef92b62e-d172-4a68-6fe3-08df3c47b377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|38070700021|261026140227099003|11063799006|261028144727099003|261022105027099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info: 3GnqOLzlKq/wgDbDaOtoFzrzb4rxhVLhfeIWv5x/SFLmz72QCSk266/0fihkrGq7KK+2kAod7/3cHtLRhDzLf+8iU5Tc5OBhAWszOoDv/fOjwIlr7kVPdkLocdbBFSMx4UdojLBZRoUnVgrZfw8E2v25Xa9DSkjcRWZrN+BVvgruE59jGW7YDrD88rmEpuGKvIVELMEb4GieZNZJLawmcfFAUvGCozFcIk6ssrxpaAtdaFAPakEkYNJeuUMlQQ2x5JKpDW5FwrK8Fkh2zxwsv9myXIwT2p4U4bKNXNlOwqkwyI65IqKOFMi08ewJ7NM8aNF3Ye+717aLtpAhE7NO6lDTJmF6nxKmWMR1GOGOn+Myb5gI5IMHZl62n2iP/E5uWf5msA/aRPeib+TxClwvxf4g76uf+SO/xBy7d5+Ho3ellQxwwHW92+6D6AMIbPv7G/GJwb6WSj2czWnwLqJaNZiOokigRX+RBd1kf36263+Aq9sBJWEfTtWUQIxMKx+3VUZnYgtMNq3O/4DZMRY+rZyNWbh9ebeh0kYq0tjmzIlvE4BfU7EI/ORcMpVN6gTf9uDE7F3Ou9F6WNKFFY776QEj04++G4KIWvSIWPaPIESIydxZjEJfAA2QTF7719ShNMc44ix5EEVdU83sftRXRhTb8nLnfFC+13NhhfCMx7L7kV42Ke02PR/j+h6VzkYCvtrfDwRRUEhix/XzgbgWGMFn01WsGjmwuK27R9+TE84=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(38070700021)(261026140227099003)(11063799006)(261028144727099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNoRGtwa1djVnFTYnlLek4xSHBmVTVQZkR6THpaVVduL05Ib2YveGhRYXlh?=
 =?utf-8?B?MFVzQUdjUit0cEpoYW84QksyaEVmNXExa3h1aDhKSGk3ZFNhdmtxVE5DV0J0?=
 =?utf-8?B?RFloazNxbDlmdW1vUG9CNHMra1R3TUJwQjhtTEw1K3NNK01XdzVJOVRRUytG?=
 =?utf-8?B?dlF0czkwY21uSDlPaDZxNXMweDhrTm52bmRjdnRpMG96YkJId2lTYSszbEs3?=
 =?utf-8?B?N2VkQXRiREJ2YjV6QnlRYXFLdmNYTmpScjFBT3BPWGJwdjBiWWxGeVBRQW90?=
 =?utf-8?B?MWxqdkt5bVk3WUJrVURVaHpxYnE5Z2lpcWl4QjBIVWtUT3hPL0QzaDlTaDgz?=
 =?utf-8?B?Q3BVN2hCVVJ3Q3FXazdYM0NoSWNwKzhTdzFQdmUweDMvY0NMRURzSWpOTFpQ?=
 =?utf-8?B?bXhqNGE4SXplY0dEdGVHbUFmWnVlUk1MSjVQK25LdWNvUk5sSHJHM0xXb1U2?=
 =?utf-8?B?ZXUwU01PQTNrNXh4Z0lTRmVVZnhnbjNqOXlLR0ErN1hNMFpjVjdvUzJXZ2VH?=
 =?utf-8?B?NFlNOW1BbXBLY2hyaE83a29FQ1dBcHl3UDBROTQ1Uk9yaU8rTU5ZclRPWkwv?=
 =?utf-8?B?YmFuYkZzYjl3WmFjVHB4eDNra0Z5aDJVdnBmRFlqeExJa0s2NG1kSS8yOFhS?=
 =?utf-8?B?cU5WTXJrZFRrdUJjNVZ4RjRlZmxzdWE3dmo0MWdKSmsxbmt4Z3RaSTBtWDNQ?=
 =?utf-8?B?Mmw5WmNoMEtMZ3FGNzlQWm5PM01YSXVQeXM0ZFhCT2l6eVVQdkE3REMrNTBY?=
 =?utf-8?B?R1NFK1JpYVBiTjRkNngxcWwvOUZTMStQek1tR3N3V1FBbWRhbTR0OERnNDY3?=
 =?utf-8?B?a0RoUmQ1QUVqckt6dWRIKzA2QVRHclUyajBQSVZnOXBHem1ETnVJN2VBUHV2?=
 =?utf-8?B?QmV2enRwYkhYZVRJWmVpVVpqbGdCNiswQWxVNGlkRnFucnlCMkhBUUxoaHJF?=
 =?utf-8?B?M3d6a3pUajZlTCtvU2l0NzlJeWlsTm80VmdQT1Zyc1hseWh4Qk5laXREanFE?=
 =?utf-8?B?emxaTHBtbi9SclhZYStpVDdRc21tUDVBWFlGYXRkbVhaMzlGNitBMzRPbU1W?=
 =?utf-8?B?YnZNZmdOamRka0lZWGZxWCt6SnlzVmVFWjQydHZmQ2hxUElvNm1SOVZOS1Uy?=
 =?utf-8?B?YkIrODVrSEFEeW1lU05WUWVXZmFYSHAyZ0E5UDF3dGlzNmt0M25PK1MvTFo1?=
 =?utf-8?B?VldvQ3oxSm9OWjRpY010YmxZak1qaGU1SnJXV1N1ZWkyWDdzbTNUSDJQaFBN?=
 =?utf-8?B?ZTFOQzZYU1FVMmhFVFJGTDdBZitqVDhMeHhiZktYUE1QeWtVemxObUp2R1c3?=
 =?utf-8?B?QjlJY2FpZGkzelQwWXA3TEYreDlIU1RyR2JoMUtvNlRiSzhpZUx3QTF3MDZw?=
 =?utf-8?B?QzNwN0twZUd3Q0Y1eVVnU0MxbGlSOVJManJxRysxNHRYRE9yL0lvdWpiTm0w?=
 =?utf-8?B?WkF0QVhTcE5pZjRpbmtSNU1ZTmtPY1RUMjAyYVFzaktmMzlsbzRCL0t4dVZI?=
 =?utf-8?B?ekZrVjRTTVVYdUJiaVZlbU5SWk9odWp6UXZyb3pQbmh3cGhYUWRLQjdNeS8z?=
 =?utf-8?B?Y3AzNFZSRkI1ODFMN3JMalBHeGVnU0pjeWZ6ZUFhdTFMcWhWVUptL2Fpa25w?=
 =?utf-8?B?dlNWVHp5OWJNWVpCRy9WV0hKd2wvemd3dlFvNzF3bTZrNSsyeFIyKytGeUk3?=
 =?utf-8?B?QjdoS0JwMTNBWGliM2pHMzJZcmwrNTd4N2hDYnp1aU9GbHorSUVPZnhIWnh1?=
 =?utf-8?B?NDlIRE9Ic0dCTUFab2N6aXdpWTd6bjhSZ000VEtFem1tTHFVNGNlcXVqTVNG?=
 =?utf-8?B?UkJGT1NhMlZWdFUyLy9hZEhkb0cwaDY2S2FZV0pwbklpbHJoUVZMWCtwUFph?=
 =?utf-8?B?T2N0QVIyOStsSGEzTEx5RTYrOS9GNmp4YlA2NjN2b0dCRTByYTBpVW5UbWtO?=
 =?utf-8?B?VWx4ZVJ0R0JpcGRlemdWT2xDMzhZY1BTSC9oMkRaV1FIRU01RDREZ29Bamhp?=
 =?utf-8?B?aWxEUU1YajBxTHhxOU1Zc0x5cGpWZ0VNU3ZaaWRsdG5LK1JPRGE1NzRPY1BO?=
 =?utf-8?B?d3VYUlRzc0MwelF0Uy8vcUYyWDVDd3pVYWx0dzdnWHBXRjB0TzdnWFcyM0FY?=
 =?utf-8?B?em12SjN6a2lVZDlGdWxad1hud09aaEwyd3NDaVFidUpiR2pvZmRkcFRsYnhl?=
 =?utf-8?B?RjRoSFk3czBpdTM1Wkt6bjh2ck1UaWdoVGlndU9hK0lPTnR5anlqZlNtT1hx?=
 =?utf-8?B?MzJ0dDVOOXlaSUU4Z3Rla3ZsT2xXQWxDWlFZcU5FYTduUHIramYveDY1blNJ?=
 =?utf-8?B?MzhvV1BBZlplRTU3VWJiMWJIRDY2WDR3ZEs3cVR2TzdEaVhMcDZYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271888E1A677904E8A4B0D0CE723BBA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92b62e-d172-4a68-6fe3-08df3c47b377
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 20:51:16.0683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /D8qtngmslOfid2LIvYN3OtD1bKTr7gVFaLQKZOKp1OFBPVTp5+tXlkCxngCX4jDRDuo+RlEmw0HB/UnP2x6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999236
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDIyOjQ1ICswNzAwLCBWbGFkaXNsYXYgWmFoYXJvdiB3cm90
ZToNCg0KPiBDaGFuZ2VzIHNpbmNlIHY1Og0KPiAgLSBrZWVwIHRoZSAicHV0IiBwb2ludGVyIHJl
YWQgYmVmb3JlIHRoZSBiYXJyaWVyIGluIHRoZSBjb3B5LCByYXRoZXINCj4gICAgdGhhbiB0aGUg
b25lIHRoZSBjb3B5IHJlYWRzIGFnYWluLCB3aGljaCBpcyBub3Qgb3JkZXJlZCBhZ2FpbnN0IHRo
ZQ0KPiAgICByZXN0IG9mIHRoZSBkYXRhIChyZXBvcnRlZCBieSB0aGUgU2FzaGlrbyByZXZpZXcg
Ym90KQ0KPiAgLSByZWJhc2Ugb250byBjdXJyZW50IGRybS1ydXN0LW5leHQNCg0KQ2FuIHlvdSBy
ZWJhc2UgdGhpcyBvbnRvIGh0dHBzOi8vZ2l0aHViLmNvbS9HbnVyb3UvbGludXgvdHJlZS9yMDAw
X3JlYmFzZV9hbGwNCg0KVGhpcyB0cmVlIGlzIHRoZSBmdXR1cmUgb2YgcnVzdC1kcm0tbmV4dCwg
YW5kIHRoZXJlIGhhdmUgYmVlbiBzb21lIHNpZ25pZmljYW50IGNoYW5nZXMgdG8NCmRlYnVnZnMg
dGhhdCByZXN1bHQgaW4gYSBsb3Qgb2YgbWVyZ2UgY29uZmxpY3RzLg0K
