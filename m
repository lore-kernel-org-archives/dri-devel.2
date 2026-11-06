Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21750606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qDlaTras
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5187C1127D1;
	Fri,  6 Nov 2026 08:28:22 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48D211283A;
 Fri,  6 Nov 2026 08:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8GIJAIqw3F8eITf6zGMO7ZqGpufCqAc2s0hVSmpWQYJ5suOVPwwvACU5BJ+XlF1UX1Gg+SzjqmzQkv4SnCWqShShsh55JMBiyC1YhRhsfVBqAbN/zfR8Mnp7gSA4q5oG2Wj9pOXrY5ux88W9fyHAybyMgGbqqhL41FIRjgD8K3AZ3VjpG7N0fRK8y3yBICZRYpmx43xSmdnxK4qqg6bn9YDXFG2XtcLU1mw9v+Vi4wA6WpYHHdgAyTO4gbYQD5m6u5bhigrjxwU6oPPezwO2nLlOoayDB4gKqw+h/+OBdZczjklImxF4DDcV28JvckZFgncpAJGzTNQRX6WfkWS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bilc6I3HyJuHmTJmSHKnlhgHiYx6oessjpn4Uq1mbfE=;
 b=HMl/O5CUWsIrftGCTb7LaQCvy46HgkkayigrBDz5nPEqg9v+aRFt1rf6hPFXzK7D/JjeUGsUxYnFArroHYb44HoaesRPLz537kJgtf6LPoeBEicmA8zvq0uiGneiDrZFb3xbQNpijU8D5g1AOYbPz50I10c/hBmIKdavxzJ2XgN/qzrGeiQI/xP8sMxJa6hWgsfjFjk5F77AooRz5TlsHxqya3B98+f0vZzIOIMGhdESbOnMfZsQDunfp20HBi5xCfimovNlr/SL4iD3gvnehtxyrtDnZV/1i2log9S7/7AgqLOighjSvPHM6yieLhvXEAhKXvn8LMX2hdTCTOhkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bilc6I3HyJuHmTJmSHKnlhgHiYx6oessjpn4Uq1mbfE=;
 b=qDlaTraswtmDuAGdFBe7h4p6I1B8nTWHM7/+BF9ek/j0wrJYHQldqQAvJ14fCED6x5wqAFkvDcXYors0iCU/MGC1X0s3GUhLia4guWrEOj/gqVAxR90178/iwMSwgxWztccSJBPQMB02hykRpm1LoPMGVqcGGvkCgKTARgzR1uc=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS6PR12MB534567.namprd12.prod.outlook.com (2603:10b6:8:498::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:28:13 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 08:28:12 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: David Airlie <airlied@redhat.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/client: Don't warn when a client's VBLANK wait times
 out
Thread-Topic: [PATCH] drm/client: Don't warn when a client's VBLANK wait times
 out
Thread-Index: AQHdbAX6Q4eRssTLSkKsHM0kTNv/JbcfldaAgAEhGKA=
Date: Fri, 6 Nov 2026 08:28:12 +0000
Message-ID: <PH7PR12MB6000215092E10B0C62D68733FB762@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261104024106.3109873-1-Prike.Liang@amd.com>
 <bad6a4e6-bd1f-49de-aa86-a7d8e4eb64f5@suse.de>
In-Reply-To: <bad6a4e6-bd1f-49de-aa86-a7d8e4eb64f5@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T08:19:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DS6PR12MB534567:EE_
x-ms-office365-filtering-correlation-id: e2aa3c1e-ba6f-4198-bdae-08df3bdfe5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|5023799004|11063799006|4143699003|56012099006|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: Vd4yhcb3nmhqtzuubWs9Os7ppCUmyaNEeFt3D0qRgpP0ws3TMKyHmAkRTh7aAVT8tD6VbX5DhXXeu4zhKTou3wYyz85XvpflwxASJzNnorCVihtEhQA7y7f7wZJBsPKBLXdXfHWNV3tbCRChUNCZfDPdI9SSYYCHOPKOZYX37CidbOqenDYdbns72dDroj9aOhhldA/tr/xIFQqOaJ2AnO8DmA4t+iD7A7Nn5q1nxW+8bI+qIIfRlvWHBVXeiPhZGjfrtYxC974yMYbVjt2jl9JhhqJACCugaV+8zrYra7e25rjzyso0ZTVDS21HY0Dvr8XlDodYzGfWkPP1GQXt91kHD+uCJ07BmMxsEAsIfLpV8OQwWWcFtBdOiBG9KZV8mmu1y/ZGEgsMEw9uvLQikAEPAIQPDBOhIJHqmekwtQDQAbdunladKC6uw8fTtikUCYff0KDAQXhbmLS+JJzWI3k+5DHLrYWdjMgCGsNnGoU2ciE98NhL1imr07mX8y45Oe3//YPrPByc5KCbLXYzfoGI9e+3DvMbFMYD2owCdhYX7YHUoVBWVC7Ko+iBRyxxLbDJsYDqQDsJQ+HxIqQBgT+wnHIfQdrKZ2Bd1R8ZvErsxDq26q62iWm7k14Np94OdSGLJvDI9Jaay0RSpKA9l8QEqgg6cpeJw3MrP3rdCIA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(5023799004)(11063799006)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjZJWEpMdFRuS2U3ckxTdUc4YWlpZCtIT3hIQk1xeUNoR0JxSkNDZGFmTEt5?=
 =?utf-8?B?bE1qVERXYVNsZXA3RDI4M2h1RXErOFlQMzQzVGxhS1BqdTY5MVZXY2JQUmlT?=
 =?utf-8?B?ajl5R01WNDRtRXlxcVFQMllWOVNodWwwTUVYdG5QK1Y1Vms5ZzQzZlh3bTVa?=
 =?utf-8?B?NGZzTlFicHozWmhISmQrWDFuVldWU0RXUVIzelpQYmJ3dmw2NmlXZHo3WTN0?=
 =?utf-8?B?UkdWMnI4MnYrYWtPY09uaUFvZmdKL2lRMWRMTzlmUEZSaFhhMU9QeFhTajRL?=
 =?utf-8?B?TTg1V1JKeUJWRzhpUVM3V0U0TW40L2tqVjlxak5LZXFMdTJiTlJpemppMDM0?=
 =?utf-8?B?alByS0ZpQmtxRXp4elJ6ZklNQmVtaHgzL01XNVAybEtpUUNFSVNva08zeTdj?=
 =?utf-8?B?UDlUSDh4RWdpT1ZDalp3ZFdwaVRIOWNBa0NIK1Bxemx5OXc4eWwwYm5GcTFF?=
 =?utf-8?B?dThLcFBxVURoMVZ5TTRDYzBNenNZVHFNQzRwMEZtMDFYbk5waElpcXVFa2tw?=
 =?utf-8?B?cVVDWnhCZGRhcyswWlp1U0s0U2I1YktFekJhaFI2VXBHcGpVcUJ5ZjBYLytO?=
 =?utf-8?B?WjFpMlRtRjR2aFFKckJkRjFxY2RsOVpqR0R4aU5ma05mVUNQVExPZ3hTS0g5?=
 =?utf-8?B?MEhsN0hvcFNrWXBQeXVzT0xVZ2VUV0V5MUU4enFEbFE2TFpnZ3pVOWNhZUZx?=
 =?utf-8?B?Y3ovUTh5Ti81c1cvb1FYZ2ZpODdWZTdidnduaG03cVkyQjVuakJobThWdENV?=
 =?utf-8?B?NExCcnpSWEl5QlNLRmJkUDJTV0draFRaRUk1YkFnNmpRK2lIcDNDRWQxQVJ4?=
 =?utf-8?B?R1RwbkpDMVoyalFyMUhsQ3BJS3JoM2ZGbG54aWdBWWZ6YzVnNTJEb1NtS1Bu?=
 =?utf-8?B?UXlubWtiRWdXRVhGaHFjNVpzZE11QU56ZmxSZkpVR0dhSy9keHB5RXhYd1hn?=
 =?utf-8?B?eDQzSjNQMHN3YnJkUUtaZnBua21ydi9uKzhZSTkxeUxkYldzN2Vjb0cvcnlQ?=
 =?utf-8?B?T2hPaXdQVVRFa0twSzJwV1FlMGl6NktZRDBrcFpSdG5yemo4ZWtnT3dwRi9J?=
 =?utf-8?B?aFJaMVpRZmVONUtSQWpJT3RaU3RpeXVMZlo0cTlnV3VndEcrS2tkMHFKMVFy?=
 =?utf-8?B?TlFEcGg0ZnEyL1ZyamNVT0kwYVd2eTdVMkhuZkVKbGFkV2RJRml5U2l3eGsz?=
 =?utf-8?B?Ny8rWGY1dTd2RDhEa0lQdDlMRVQxaWhaYTkvdjNkelBUMmI4cFVRdlJRTk5B?=
 =?utf-8?B?V2hlVHVDV1p3cEt4M21LZExBQWc0Z3ZEQ2hFMGozZE0waWRZZ0psZmh4bnFk?=
 =?utf-8?B?elNUbG0xc2ZoMEphbmp2QVNWMWp2akhtcFRac0VnaERYWHNXQ1puQkM1MkhX?=
 =?utf-8?B?SDYrekxES3RaN2h2dHVVdHJIRlNtVDJ4SUlpekRnSWg3NXU5WU41aXZsU0hY?=
 =?utf-8?B?eDFJMUY4Y1oxN1ZMVGJyOXFGN05mYWJ3ZTE5VUNzclI3RUpVWnZCZFpxRGJI?=
 =?utf-8?B?OTV0SEZ6ODFXclF4c202bGRTWXhBV0xzQ3VDNituMDU2dzZlVlhSVEYwU1U0?=
 =?utf-8?B?MWJxaXNGb0ZqdVRwcWkzUWc5STJYNHRaTnlwcFNLdmh5UVVlcVVma2dVYTFX?=
 =?utf-8?B?elFQMExyUTFhSUs3cU9ia0Yrc3B6MFZtRXBiODAxSEZpMXpCRFZKazJJSzBp?=
 =?utf-8?B?OUdYOU1IR0lZRm9Uc2Z0b0RReEQxbWVUd3hyVFd5TjJWZ255azVVWExNMFR1?=
 =?utf-8?B?TGN0Y2xaelE3Uk1PQW54Q043bHVKb1RXYTNrUEZHZ2NQM2NuV05KOWtNY1ht?=
 =?utf-8?B?SFdYcjZOeTFaTnRUUFJyTkU5U25vbllMWmp0c3NHcEFZNWZpeCtrK0Z0Rk1m?=
 =?utf-8?B?bjc2U1VzQlZRWWdaNUpuM0JnN1NqeTVaNVdxM0xTR1I2U1hyU0p5emlsWElh?=
 =?utf-8?B?K1B2aFFqUWhtTml6cUxidXZRaHpCT0t5RTNORmJzOFR3TzNSME43TWFkWkR1?=
 =?utf-8?B?VkRlQzZwRDBRY3hqT1p2dFJ6T1NPQXNIL3lxZnU2MERHQVYvbXlYaWZFTjFV?=
 =?utf-8?B?d2ZmWnJSb1o5YzZpVHRyV1JxU0laamZvUDlEcmgrK3JZS2I0T2F2dFF1enJJ?=
 =?utf-8?B?Tll0bUlWMk9lNUYyU1Zvc3VXZUF6a3htUHVTbERWQ2lINHlYSXRuOWZMbFRp?=
 =?utf-8?B?N0h4NzcwZnh5S3dVQ2xsbGtYTXRjNllNSTZuTWNnNkZTNlBjUVk1M1FOcHpu?=
 =?utf-8?B?WCswQ0lXb3VDKzFvSW5reVY4YUN0ejJxZ2tqcDlMMHVlalhhczFGOE12MmJE?=
 =?utf-8?Q?0UENcYOxYoWftuMhg6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa3c1e-ba6f-4198-bdae-08df3bdfe5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 08:28:12.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnwtxRLs6I8BDOqhBf2ap5vLmMQsv+WQJ9RubWblWGTsK5OT4QgPK9l/dN/5LYwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB534567
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2Uu
ZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA1LCAyMDI2IDExOjA0IFBNDQo+IFRvOiBM
aWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPjsgV2VudGxhbmQsIEhhcnJ5DQo+IDxIYXJyeS5X
ZW50bGFuZEBhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+
Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vY2xpZW50OiBEb24ndCB3YXJuIHdoZW4gYSBjbGllbnQncyBWQkxBTksg
d2FpdCB0aW1lcyBvdXQNCj4NCj4gSGkNCj4NCj4gQW0gMDQuMTEuMjYgdW0gMDM6NDEgc2Nocmll
YiBQcmlrZSBMaWFuZzoNCj4gPiBkcm1fY2xpZW50X21vZGVzZXRfd2FpdF9mb3JfdmJsYW5rKCkg
b25seSByYXRlLWxpbWl0cyBmYmRldiBkYW1hZ2UNCj4gPiB1cGRhdGVzIGFuZCBzZXJ2ZXMgRkJJ
T19XQUlURk9SVlNZTkMsIGJ1dCBpdCB3YWl0cyB3aXRoDQo+ID4gZHJtX2NydGNfd2FpdF9vbmVf
dmJsYW5rKCksIHdoaWNoIHdhcm5zIGlmIG5vIFZCTEFOSyBhcnJpdmVzIGluIHRpbWUuDQo+ID4N
Cj4gPiBWQkxBTksgaW50ZXJydXB0cyBjYW4gc3RvcCB3aGlsZSB0aGUgZmJkZXYgY2xpZW50IGtl
ZXBzIHJ1bm5pbmcuIFNpbmNlDQo+ID4gY29tbWl0IGViYzMzNTFjYzRhOSAoImRybS9hbWRncHU6
IHJlbW92ZSBzdXNwZW5kL3Jlc3VtZSBEUk0gY2xpZW50cw0KPiA+IGR1cmluZyBHUFUgcmVjb3Zl
cnkiKSwgYW1kZ3B1IG5vIGxvbmdlciBzdXNwZW5kcyBEUk0gY2xpZW50cyBmb3IgR1BVDQo+ID4g
cmVjb3ZlcnksIGFzIHRoYXQgbWFkZSByZWNvdmVyeSB3YWl0IGZvciBjbGllbnRsaXN0X211dGV4
LCB0aGUgY29uc29sZQ0KPg0KPiBJc24ndCB0aGF0IHJhdGhlciBhIGJ1ZyBpbiBhbWRncHU/DQoN
CkhpIFRob21hcywNCg0KWWVzLCBpdCBpcyBhIHRyYWRlLW9mZiBzb2x1dGlvbi4gV2hpbGUgdGhl
IHZibGFuayBpbnRlcnJ1cHQgaXMgZGlzYWJsZWQgZHVyaW5nDQpHUFUgcmVzZXQsIHN1c3BlbmRp
bmcgdGhlIERSTSBjbGllbnRzIGJsb2NrcyBvbiB3YWl0cyB0aGF0IGNhdXNlDQpsb2NrLW9yZGVy
IHByb2JsZW1zIHdpdGggdGhlIHJlc2V0LiBOb3Qgc3VzcGVuZGluZyB0aGVtIGF2b2lkcyB0aG9z
ZQ0KcHJvYmxlbXMsIGJ1dCB0aGVuIHRoZSBmYmRldiBkYW1hZ2Ugd29ya2VyJ3MgdmJsYW5rIHdh
aXQgdGltZXMgb3V0Lg0KDQpJJ2xsIGxvb2sgaW50byB3aGV0aGVyIHRoaXMgY2FuIGJlIGZpeGVk
IGluIGFtZGdwdSBpbnN0ZWFkLCBieQ0Kc3RvcHBpbmcgdmJsYW5rIHdhaXRzIG9uY2UgdGhlIGRp
c3BsYXkgY29yZSBoYXMgZGlzYWJsZWQgdGhlIHZibGFuaw0KaW50ZXJydXB0cy4NCg0KVGhhbmtz
LA0KICAgUHJpa2UNCg0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQo+DQo+ID4gbG9jayBhbmQg
dGhlIGRhbWFnZSB3b3JrZXIsIHdob3NlIGhvbGRlcnMgY2FuIGRlcGVuZCBvbiBmZW5jZXMgdGhh
dA0KPiA+IG9ubHkgc2lnbmFsIGFmdGVyIHRoZSByZXNldC4gVGhlIGRpc3BsYXkgaXMgc3RpbGwg
c2h1dCBkb3duIGZvciB0aGUNCj4gPiByZXNldCwgc28gdGhlIGRhbWFnZSB3b3JrZXIgbm93IHRp
bWVzIG91dCBhbmQgd2FybnM6DQo+ID4NCj4gPiAgICBhbWRncHUgMDAwMDowMzowMC4wOiBbZHJt
XSB2Ymxhbmsgd2FpdCB0aW1lZCBvdXQgb24gY3J0YyAwDQo+ID4gICAgV0FSTklORzogZHJpdmVy
cy9ncHUvZHJtL2RybV92YmxhbmsuYzoxMzIwIGF0DQo+IGRybV9jcnRjX3dhaXRfb25lX3ZibGFu
aysweDE5NC8weDIwMA0KPiA+ICAgIFdvcmtxdWV1ZTogZXZlbnRzIGRybV9mYl9oZWxwZXJfZGFt
YWdlX3dvcmsNCj4gPiAgICBDYWxsIFRyYWNlOg0KPiA+ICAgICBkcm1fY2xpZW50X21vZGVzZXRf
d2FpdF9mb3JfdmJsYW5rKzB4NjMvMHg4MA0KPiA+ICAgICBkcm1fZmJfaGVscGVyX2RhbWFnZV93
b3JrKzB4ODkvMHgxYTANCj4gPg0KPiA+IFVzZXJzcGFjZSBjYW4gdHJpZ2dlciB0aGUgc2FtZSB3
YXJuaW5nIHdpdGggRkJJT19XQUlURk9SVlNZTkMuIFdhaXQgb24NCj4gPiB0aGUgVkJMQU5LIHF1
ZXVlIHdpdGggdGhlIHNhbWUgdGltZW91dCwgYnV0IGxvZyBhIGRlYnVnIG1lc3NhZ2UNCj4gPiBp
bnN0ZWFkIG9mIHdhcm5pbmcgd2hlbiBpdCBleHBpcmVzOyBhIG1pc3NlZCBWQkxBTksgb25seSBt
ZWFucyB0aGUNCj4gPiB1cGRhdGUgaXNuJ3Qgc3luY2hyb25pemVkLg0KPiA+DQo+ID4gRml4ZXM6
IGQ4YzRiZGRjZDhiYyAoImRybS9mYi1oZWxwZXI6IFN5bmNocm9uaXplIGRpcnR5IHdvcmtlciB3
aXRoDQo+ID4gdmJsYW5rIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT4NCj4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+
DQo+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQo+ID4gQ2M6IExlbyBMaSA8c3VucGVu
Zy5saUBhbWQuY29tPg0KPiA+IENjOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3Vz
ZS5kZT4NCj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX2NsaWVudF9tb2Rlc2V0LmMgfCAxMiArKysr
KysrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fY2xpZW50
X21vZGVzZXQuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2RybV9jbGllbnRfbW9kZXNldC5jDQo+
ID4gaW5kZXggMDA4MGE4ZTk1NTZhLi43YjMxOTNkNzNiYmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2RybV9jbGllbnRfbW9kZXNldC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9jbGllbnRfbW9kZXNldC5jDQo+ID4gQEAgLTEzMDEsNyArMTMwMSw4IEBAIEVYUE9S
VF9TWU1CT0woZHJtX2NsaWVudF9tb2Rlc2V0X2RwbXMpOw0KPiA+ICAgICoNCj4gPiAgICAqIEJs
b2NrIHRoZSBjYWxsZXIgdW50aWwgdGhlIGdpdmVuIENSVEMgaGFzIHNlZW4gYSBWQkxBTksuIERv
IG5vdGhpbmcNCj4gPiAgICAqIGlmIHRoZSBDUlRDIGlzIGRpc2FibGVkLiBJZiB0aGVyZSdzIGFu
b3RoZXIgRFJNIG1hc3RlciBwcmVzZW50LA0KPiA+IGZhaWwNCj4gPiAtICogd2l0aCAtRUJVU1ku
DQo+ID4gKyAqIHdpdGggLUVCVVNZLiBHaXZlIHVwIHdpdGhvdXQgYSB3YXJuaW5nIGlmIG5vIFZC
TEFOSyBhcnJpdmVzIHdpdGhpbg0KPiA+ICsgYQ0KPiA+ICsgKiBzZWNvbmQsIGUuZy4gd2hpbGUg
dGhlIGRyaXZlciByZXNldHMgdGhlIGRpc3BsYXkgaGFyZHdhcmUuDQo+ID4gICAgKg0KPiA+ICAg
ICogUmV0dXJuczoNCj4gPiAgICAqIDAgb24gc3VjY2Vzcywgb3IgbmVnYXRpdmUgZXJyb3IgY29k
ZSBvdGhlcndpc2UuDQo+ID4gQEAgLTEzMjgsNyArMTMyOSwxNCBAQCBpbnQgZHJtX2NsaWVudF9t
b2Rlc2V0X3dhaXRfZm9yX3ZibGFuayhzdHJ1Y3QNCj4gZHJtX2NsaWVudF9kZXYgKmNsaWVudCwg
dW5zaWduZWQgaQ0KPiA+ICAgICAgKi8NCj4gPiAgICAgcmV0ID0gZHJtX2NydGNfdmJsYW5rX2dl
dChjcnRjKTsNCj4gPiAgICAgaWYgKCFyZXQpIHsNCj4gPiAtICAgICAgICAgICBkcm1fY3J0Y193
YWl0X29uZV92YmxhbmsoY3J0Yyk7DQo+ID4gKyAgICAgICAgICAgdTY0IGxhc3QgPSBkcm1fY3J0
Y192YmxhbmtfY291bnQoY3J0Yyk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIC8qIFVubGlrZSBk
cm1fY3J0Y193YWl0X29uZV92YmxhbmsoKSwgZG9uJ3Qgd2FybiBpZiBWQkxBTktzIHN0b3AuICov
DQo+ID4gKyAgICAgICAgICAgaWYgKCF3YWl0X2V2ZW50X3RpbWVvdXQoKmRybV9jcnRjX3ZibGFu
a193YWl0cXVldWUoY3J0YyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZHJtX2NydGNfdmJsYW5rX2NvdW50KGNydGMpICE9IGxhc3QsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcygxMDAwKSkpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICBkcm1fZGJnX3ZibChkZXYsICJbQ1JUQzolZDolc10gdmJsYW5rIHdh
aXQgdGltZWQgb3V0XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3J0
Yy0+YmFzZS5pZCwgY3J0Yy0+bmFtZSk7DQo+ID4gICAgICAgICAgICAgZHJtX2NydGNfdmJsYW5r
X3B1dChjcnRjKTsNCj4gPiAgICAgfQ0KPiA+DQo+DQo+IC0tDQo+IC0tDQo+IFRob21hcyBaaW1t
ZXJtYW5uDQo+IEdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINCj4gU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR2VybWFueSBHbWJIDQo+IEZyYW5rZW5zdHIuIDE0NiwgOTA0NjEgTsO8cm5iZXJnLCBH
ZXJtYW55LCB3d3cuc3VzZS5jb20NCj4gR0Y6IFN0ZWZhbiBHYWlzZXIsIEpvY2hlbiBKYXNlciwg
QWJoaW5hdiBQdXJpLCAoSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQo+DQoNCg==
