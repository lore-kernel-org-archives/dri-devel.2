Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF7F9D0F6
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 00:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDE310E02B;
	Wed, 15 Apr 2026 00:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oh3kbyeH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA79010E02B
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 00:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWVsBznzkeWCDJkHuHbrVhNyo0VGs90OAU/XfWAMCQ8EUo/PEySkscAlOu50y6FCwafOtXTtD+2if8K0dyT7ao+vDF8QDKI/0bMR6TW/UKZbv1tF1KAckzIZwBK05DIq7fj0ltseOoqaP0dQq0gwuofgsa6SHVtg4XaDAAfu9C/OzAh6dJCMH0nc6HdaxNvoD3EJrj24zQLlB2nYtLwTkxhh6wAM5kmYzrk0Tv2wahugmTsq9lOUZYzQk1EXVzeHrQyTw+Ja2IF8nROwfF6XYFtBJbZNMHaO5kZElftTxgp83V/r7mCF1xVU4kh0U/Vvl5CtGFKTpwQ5QRoR4oKjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoxeKIFky5OlQtQjXe15i5DC1pehH64d9tIAcyFEWcY=;
 b=rRBMfc7YvoGwswcDYoVzNge3o8gJug3r4HfPLWK7bkHhRfCJq8OO0kuGuOq4FbFvuZPb2/iWVehE+vTKFohhwNAbEnVhG8u943dsKOuGGDfMyHeuHoBmbeg6/u+mPPuo8mh5Mw7U6dpEuN6EA8mAFNW9vufrHPAMhAinkW+BnSS6kNZr1iuVujr1lwCwV09oEC6pd9UIUeonw+qECaWGF2JlDheXFX6CSqhsoZ7Y8jwGUMhrUQR9g3VVJB2t6Mgbq3wLyjchcnCbsD/SA2dWDtYIGqYaasVo1xBfP6h7NPy0Jh+VP/Dv8qFUa+PN45lsqZx5saLcF3pJkRTIaE3nMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoxeKIFky5OlQtQjXe15i5DC1pehH64d9tIAcyFEWcY=;
 b=Oh3kbyeHBB7yTgp7O4kMf60DaSiwINsmSgjopv+yLBdMPr7Vj83iziedLuVx7kpVadLSrkgqQLxZl7ar0KqysIew+Sj79LGciH4rFced6iZNcOdiBlslYDk7+rx79hV4Yv2+T7mRTYf7pk4BOJt4cwNPYi9ocSHy+DCj/FY2UCzqsSQc7vhLFZXukVY5xOTIbZ9Kre4AwVv1r9xoB8dvANf/3lCJcZ92WMeZxNv08Hsd2ur+h5yY+lfkKJLJdz/u/5r89i6vMo9ogSqU5WWwlwBoG0tDKOPxq2S/NVI0LC/hQ34ytOwLPEZ199WRXERVyjDpj1Pt6xUO4P8RKqouUA==
Received: from PH0SPRMB0083.namprd12.prod.outlook.com (2603:10b6:510:296::9)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 00:02:21 +0000
Received: from PH0SPRMB0083.namprd12.prod.outlook.com
 ([fe80::7307:e5f3:56e3:cf42]) by PH0SPRMB0083.namprd12.prod.outlook.com
 ([fe80::7307:e5f3:56e3:cf42%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 00:02:21 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Timur Tabi <ttabi@nvidia.com>
CC: Alexandre Courbot <acourbot@nvidia.com>, "dakr@kernel.org"
 <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "aliceryhl@google.com" <aliceryhl@google.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, Alistair Popple <apopple@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Hubbard
 <jhubbard@nvidia.com>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Topic: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Index: AQHczAWHlAw8eofhY0iCtg50QUfHXbXfN/YAgAAGQiI=
Date: Wed, 15 Apr 2026 00:02:21 +0000
Message-ID: <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
 <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
In-Reply-To: <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0SPRMB0083:EE_|PH7PR12MB6859:EE_
x-ms-office365-filtering-correlation-id: 7335f610-bd13-44ec-62c3-08de9a824454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: onQI5zGiBwih+4KtmZ0B+ZvvO4ubeun2P/BcMieo7uGJXNCIuOaa0RX8B6A76oadQgDZ19dRzFDvsSLOs8CYisKXi72ZDwkUxVMlOd4aZBZeFx1+rRthtwpDCXq/0DgcVj9cBD3uRpYH8dYaPID+PdlGmALgglRcqqYg5COb7lH14wkvCd9r3u9uh5MFrPaBxxGrHE0ELvNiCUE7jyqoK4JRLZueOl7E10hjradRx2Ji7zY6460f7Idk0dFFpcyl9sHMftTCDDTjDCPpRD9aUvkoFt6gor0Z7yszffqA4FamiIHhkoaDcfd0oCRbrW7HbsU4QgCvyJTlPh4zjhK3+dUU4GxvW8da+4F3ZASUIHVvfqYV7kRcF5/bQq/Okz69Yp9ZSoxuQqNQkaQUZtU8m9u/gsc59nQeBPntviVl2WEBVSg3R/BMvKJNVKYd04Bfkh+saTWTHkI6vocmO+e/FZOAoYOFKBo0vP4OOOVw6Ul6HblGZUDNGHSypOStcyd/iJYHmx0WAYHY85FDoOLSTh/LrYaYgrzZOV1CxrpUUfbb5nRybz44gebd/UWhGZX9XyUz5nVIRYS8oAAU/ptL9BcS7I6njyYdpuqdKmwBLaS7G+w+kQavlCiDNJnUazppyQD8A7q6WpUaHoWcS1Rs+Y7ZoBsKaxt8rd5WNwC6Cih6aCPrG2TlRDINzye9OR9B9x4z9UagIXRnjSKe0+yndPjXGvY+JNZffzJyKIIyOOUwYHjILZ85Be5ziZsg+ZlkmzSwR2p3FKnHUGMRoEiWs2H+QPIYfSyG8sRz28nPTQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0SPRMB0083.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZiczMvVHpwaUY2ekw1S3JhQWJNTWh6eithd2U4M0EwZkRoWXNlaiszZEhl?=
 =?utf-8?B?Wlc4OFpKMTRGRms1MUhLVFFJZ3FLY09Pc3J1ajNSZE9PY1FEK2ZOYkREWmRL?=
 =?utf-8?B?Mmk0SGJvL3diVWthM0ZsbzYvZlFzVlJnT0ZndnE4T1ZxMDBYcWlrSWFLaU4v?=
 =?utf-8?B?ek1QKy83VHV5Q0FKbm03Z3ljS1oraVp6ekswQXd0OG5ZZ0haSi9BS205ZVFa?=
 =?utf-8?B?R0pnRG10WjZzU0xEN2gzMEtlN094dmJscS9xb3V3ZlhkWlhIZHFMRGdyOHpu?=
 =?utf-8?B?RzQyOVB2Z21VLzB2VlJXbWpGM2lQc0oxTEp6YlJFQnRoSHlueGJkLzJ1V1Jz?=
 =?utf-8?B?UlFBMTJ1M2dUQ0FRZTdYTm9BWVVsYWtoQ0thaXhGRXZuRzRxMFQ5ajF4SVJS?=
 =?utf-8?B?QlhZbW1haGFPZlh3SDl0cGEvVSsveVV4QVV4VHUxTENVLzhETmdzeW9zUEdD?=
 =?utf-8?B?azAwQ09JKzkzTWtYQzZhaW04RzM2aWNtY05OU3VlL0VuSzZ4N1Zpdmx3M2Vu?=
 =?utf-8?B?S2ZraS8ydVR1dUpLVVNWblNrTURRM093SjlHa25JYmFIV0lBdGtFRUhGd0lt?=
 =?utf-8?B?bGpCMnJpaUJEVEluV0haUjJUYit4OHpORTU1cExZNzR2SzA4b0ZabmVCZXFt?=
 =?utf-8?B?UVUzODM4N2xDdmJTZ1NqMDJ5WWdpYUlFOXdqcXdPTS9VTjZuVzhHRVpxdkFy?=
 =?utf-8?B?SkdiMDNyc2JSaWYxRE9lS3QycUlBaXRWUTBvaGduT3p1aFVjWEVobnhpVUkw?=
 =?utf-8?B?MkptQ1FmY3lzOEh3Y2MvMDIvVnpwNmxHWWM0dGJacGFpMVZST1pWbW5DNEQ3?=
 =?utf-8?B?VExjN3orT1F2SWd3a2lVeTg1dmlTVWFMWldQS3U5Wkp1VU5RNnBTVFYzUVkw?=
 =?utf-8?B?a2VtZXpKYS9ObTExYlJuNDJLbFV3ZTFNTWlzY0NhL0RCTXFCa0dHOUh1SWRG?=
 =?utf-8?B?cDN3bGRuMWoxdUt3aEkxcDNLMkJQYkdvTkVWQ1FOYkhQUkZoUXZ0T1E2MzNR?=
 =?utf-8?B?N1RxTi9TeHo5c3M3djF0OFlTRmZRUmZBMTA4N2hGMmtYd2dnK0t0MC84cXhV?=
 =?utf-8?B?OFVtQW9OVFMzK01yci9vcFhWOVBnRXRMZWQ4dExtZGFmeDEyZENZMy95L1d6?=
 =?utf-8?B?VTBmay92SGgvWmE2UUMyNWMrdDd1NjNiZUo2RjFlL2ZLNnlCbFZzMGhXc2ta?=
 =?utf-8?B?RFZyZ1FTUDlSTXliU3NVRHVzc1hPb1lmZThaSkxodk1yYXlVc1h6ODd6WnRS?=
 =?utf-8?B?TUN6bHJkNWFwKythcXhEWVloc29HRUdhUnlHNHg3andnVTNMbXBGZFlDR1Vt?=
 =?utf-8?B?dTZTNXMrbTViRGp3eGhFNllZRHhGa29sZTBSL1AxemR2eXROY3hIcjJRRXpH?=
 =?utf-8?B?UzFGZXlML3VwNTF2Q3lmT1l6WUprOTBMcStIV2pLdm8ycDM1RFROR3ByT0x1?=
 =?utf-8?B?cUxFL2JPQUliNDM0T2NKMmc2V2VJdTRPMUFUTFVDVzRJa2tRS3hidlhCa1F4?=
 =?utf-8?B?cThuWE1lM2d5MUIrZE10NnlDSEQ5RWVINzMvU0NIOThlZ2JNT283djM2RUdQ?=
 =?utf-8?B?d0FEN3dEcVAwQUN4cmEwcEdYZmlMR29BRGxBQXZHdm1TMXY4YzR3VjFnSEdp?=
 =?utf-8?B?OGd5a08rRVBiM252dnJWVUpSeVhUdHdZSU55Z1hBdG92aVNxby9XRU9NUTBm?=
 =?utf-8?B?N05qdnp1RzBtdmZBbk93N1BBUXdsTitySFJRVjliMndHVFR0N2N3ZUt6dk83?=
 =?utf-8?B?SnZHN3FrMEFwVXVDRWFFYUpxVUc2di9vUmtMZHBCK1lvbWRrckNHdjk1Mmwy?=
 =?utf-8?B?anpGN0VaUEg4YW5hNjVQNkNMYkJzT0EvcDR2dHFJbGpIcm00Z2ZJU1p1aG9C?=
 =?utf-8?B?V3lCZklPbUk1bDlRdmlIclMxNFd2dEdUUlova29rSFVjdU5ra3h0M0tVOXFK?=
 =?utf-8?B?N1p4VGxuWUNtNmEyYnF3Rk1xREZqQkRLbkF2MGVKbUI0Y2k4NzN3T0IwNFo1?=
 =?utf-8?B?L1RpNU1vRk1kdTRtVXMyKzkwNHJNYnpLdzVkV3ZzZzhhdzBLaDVzVlFYOWJQ?=
 =?utf-8?B?Y0QvMmlndGZROHFrY2N6NExyemtMamF1YWU3Mm1SMW9ubzFGWHRhOFVhT3Bn?=
 =?utf-8?B?enVacWFMM0EyUUhha3FhUko5VFEzS3ZkeDNyWEplRzVvOHlCbFZMdUg3Tlkv?=
 =?utf-8?B?eFpCSkNkUXR6NmRQeDk1b0RsTnlEQ2M0Y20wa2Z4TE14RTNrQ2lvRnNITFRB?=
 =?utf-8?B?NHJ6VFdxaVNLaDZwNjZjVnhXdloyZG0yZDQzeVRrVmE2THZERjdON2JraTdm?=
 =?utf-8?B?U3FaUE9HU2ZxekNNTnZtbkwyb1hvNlJxSVdORUpvcm84T1RiZDFoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0SPRMB0083.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7335f610-bd13-44ec-62c3-08de9a824454
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 00:02:21.5544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIIZToK3rtN18BDDte+Zt2DSSctKDNlyF/yAxKp80NrTbdZA017D/YfKju/TtowmusOawV0RZ9KzAURJcWzgRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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

DQoNCj4gT24gQXByIDE0LCAyMDI2LCBhdCA3OjQw4oCvUE0sIFRpbXVyIFRhYmkgPHR0YWJpQG52
aWRpYS5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCAyMDI2LTA0LTE0IGF0IDIwOjU0ICsw
OTAwLCBFbGlvdCBDb3VydG5leSB3cm90ZToNCj4+IEN1cnJlbnRseSwgdGhlc2UgYXJlIHNpbGVu
dGx5IG92ZXJ3cml0dGVuLiBJbnN0ZWFkLCBlcnJvciBpZiB0aGV5IGFwcGVhcg0KPj4gdHdpY2Ug
aW4gdGhlIFZCSU9TLg0KPiANCj4gSG93IGRvIHlvdSBrbm93IHRoYXQgdGhlcmUgY2FuIG9ubHkg
YmUgb25lIFBDSS1BVCBpbWFnZSBvciBubyBtb3JlIHRoYW4gMiBGV1NFQyBpbWFnZXM/DQoNCkFs
c28sIHdoaWNoIEdQVSBpcyB0aGlzIGV4dHJhIFBDSS1BVCBvYnNlcnZlZCBvbj8gV2hlbiBJIHdy
b3RlIGFsbCB0aGlzIGNvZGUsIGl0IHdhcyBvbiBHQTEwMiBhbmQgdGhlcmUgd2FzIG9ubHkgb25l
IFBDSS1BVCBhbmQgMiBGV1NFQy4NCg0KDQoNCg0KPiANCg==
