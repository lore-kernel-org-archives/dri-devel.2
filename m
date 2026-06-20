Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCFBCD4F26
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 13:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85C910E1FD;
	Sat, 20 Jun 2026 13:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hBgfq/d+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DD010E1A5;
 Sat, 20 Jun 2026 13:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMGwNLU9YOsIFrI1knlGjZfgqbgYiJ6MWliG5cmZ3p2EMfGSZ/cv949vOqefrvaf6t4hxVD05QtNofTJVVORVTRPW8AGeB/uPtUMuAP+YZGp90Prp7+lb6HXnogF6KqcVoIrmANFnAbflbz1XBG36k0rfT7bxedn2lk4skLficY9krKbqnLdfdv3J4yr8yFJMTDV5Z8Q/i+AtVjEnBcqY+0nMqfyV2G9aUwIY3vkN6f+PNsmKAL0g38XKh8o5hAMe886GnO0kdIiEA+YH1ukxS8Mgk11vXvcoQ4vDTS5aVRFu3sJIqaXFb3xvjGPjrax1FTvaoPTnTDfSXqq3IWAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwaKp6C0twC4HSSBpjZJlAKoqLMCgrjdnZx/pxqQBu8=;
 b=xvqjtzsGacCwptsAnDw6DoPMs+0E9qH89m9e+7+67FReyP97sQylDwzZ0daaGCnaG4HpCSVjSfoMriBGwBZx0IQXGvmQZksN8L2Dpb/CQGzAUGcvYqbUHEeyya542PBdXfw1ffwoPZWvWdVCSx3eZ3H4e2qD3gkgcw31Rupjqiqb6ewfe5+qEtUBaURC2zYXWO10sjJA3dOJ9BsIH1GNBe/+b9uuWatiJpRPOnHL/V/BmN/+upsE5loqDSsM5Anl5Z3nTFzE5cydFRhUPlY2BLCj8rsrXKytjCWZfAjLJipwE2DoP2WdgncDKK6CD6Uopa5OGqHLe0nvdBgkm1RZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwaKp6C0twC4HSSBpjZJlAKoqLMCgrjdnZx/pxqQBu8=;
 b=hBgfq/d+d95AElfehzcQxqh7QqRCyOTVrasQGglkms2qs8pc/QRB0LHt60xBGtHRpTDeTEt+QIO3ELQXkjA+CUjvrAFYELEcZ0MdlNw2EyyO36T7UrKYaw1bGISt71HUXNaZIAcqbvwZz0G+26hFTo/g6rOsjnij3CK+BzR05pE=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 13:28:19 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 13:28:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] drm/amdgpu: initialize ret before UMC error record loop
Thread-Topic: [PATCH v3] drm/amdgpu: initialize ret before UMC error record
 loop
Thread-Index: AQHdAHvK2BgoM0lqsEaMPD3G8PNzNrZHcEsQ
Date: Sat, 20 Jun 2026 13:28:18 +0000
Message-ID: <PH7PR12MB87966AC2711567EB180ACEA6B0E12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260620061155.1442056-1-ruoyuw560@gmail.com>
In-Reply-To: <20260620061155.1442056-1-ruoyuw560@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-20T13:28:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB6719:EE_
x-ms-office365-filtering-correlation-id: e4c2f733-5094-423c-7390-08dececfcae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|38070700021|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: uIIMzZJVtGOZsaXxjc5rHCnJqQcabAhpdLQHhrlskmtY5UmMftR91NQ3SPxPaBCruda5yDNuWz75a76LDJmRrPKJsxhDW+Xy64S592BgsBS/S9Bt8vgmwGTAW4X5XzfO69YInt2uX6mYFvwBUBmjrgbEVFkjVQWmzufaJ/eN/U515dut8UAzr/uWAUOsmOjuC3EUzPSHenjmfnJGnKKwepOGawcxvTKBWbYS6Nb7cU73Nux2ILGfm2TlrYFP4Tsu6tThIJTtdmGzHVFzsQjhOWQWbfsBaW+DF6Zj5o2EbSZ7asSU2GDDZSOSElJygQfya1uEwpAg5w/Vfxf6j6ep2x1YoVIaJolhKVI4tuWIRD99k914txFo2Dvqfz+TdpkzcSQsVBX3zzkikx1//CD49L8zhEpBKta1LQCbVEp+Xn5mf5yTsIbXNgAMxwF3s8ymOxBzLO32XzuMn0SAJAtNo/VdnGVhNq09Bq9sWwN5UmcsDTt36tDopwqAewai6K5XP2lDPk41BhwXON2BSa5bUh6n2QUOZif6xn2wvVMH9Q/AELOzSNjUq4xFBaV6DtuH9xwzXFmUHf65pchbIj8NgzaYgFXoYX1M3bK/Q5S8DiBkduaMMCTOVo+tgtHA5NnWXGaAYmcWTF8EoHvFeLXT6aJr4e48c3nXiAHUoV7n3Xv8WEB0ycQz7QPpDKSPasoHb+l8/p3KsVPeQGD/3rhfWKLm/uCHdbpPDQH/eF7hRgo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(38070700021)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUgxSURUMktTTWNTbnRSRjVLaFJVY29nemg4dEJMRGI3MGR1d1hLVUMvL21p?=
 =?utf-8?B?SWJNWHVabTUxYnpCVW11RVcyTTdZamZBcjdzRXNpK3B3amZlZU5UNUpzZW5X?=
 =?utf-8?B?NVBYK245cUF2Q0JOUFpkbjBzbGRLM3pFMk5OOEFxTFl3WjhIWEFkZ0VySEhH?=
 =?utf-8?B?cE5Gb0RDcHFMcndoeTBuSi9FK3UrVHJRUGVHSHZ0c2tOUGZrRUFLMkI4QVBG?=
 =?utf-8?B?SnJGSnZiUTFMQ282L0pHcnBONm9QenB3TTJmNTVubGRNYlh0UlRRN3VHRlVG?=
 =?utf-8?B?a3dJZEJudmRvT0tKTncxMnQrM05IZk5ldzV2SGcxbFZZdlp0bDUvaFVkMndP?=
 =?utf-8?B?QWZFMjAxM1lJOURCeHI4dDdTTHh2WXAvaDM1ajJpa283WDdYcFJSMUs1REJU?=
 =?utf-8?B?NWl2VVFkeGVjOGdIbG0vbk9oc1VaaU9RNm9Hc21QZEQ5VkRLUS9zbkpDcUd1?=
 =?utf-8?B?U2NISWNoWmN6YmZ4M3VEdHNsRFZxRHAzQ0oyMTZJa0RJT3p2SytqSDNTT29W?=
 =?utf-8?B?VlFycUxUeEJ3V2U2dEw5ZzA4N2V0V0QrMDYyQ0RKYTR2djl4Mnkrc3p5cnIx?=
 =?utf-8?B?Z2JnaFN6TTJndzZqUGZyTG9qSmJGbnRLQzBqeDdXbVQ3c3hrZGQzajMzTnox?=
 =?utf-8?B?SUdXdGRINEZ3OWl3MUNndUZZWlB3NUdGQ2VETjdLK2FtNmR5SHAvNXVwN2Jr?=
 =?utf-8?B?MUkyTEpTaFVtQ1FsWUZ1OG12YkxML20yV05QNnNIQVh5a1ArTlh1U2U3R1VE?=
 =?utf-8?B?ZnVKSWRsb0dOdUFlS0pWaWdkck1YS25ZRy8vMU9lUGw5bWpvSlV3RFJMOGE1?=
 =?utf-8?B?Mzltd1kyQzFhMHpjOVVvWFZ3TWV5Q0pLZ1ZvYUVPNDR2UklxRWQyTHRyK2xp?=
 =?utf-8?B?R2Ryb0NqUDBoNFpBY2JVaERDdmdHU1RNTWNCbmV1V1dqOUdlTkxPRGc1QnJT?=
 =?utf-8?B?U0M2Z0NMNTRhWmhvVm85aER2ZVU3aWhjZng0Q0VGWTJGejV1TFJBV1lXMkdM?=
 =?utf-8?B?K2dFWG9VeG90WnpqaGljcFFJNDFoRXVWNjJWNkxHbmhTKzNMNXBHWWRtQTZE?=
 =?utf-8?B?TmpVcS9IaEt3ZHdEelNJalZSMURzWVM4TUUyQk10Z01kOFIvUDdNTGNBeENh?=
 =?utf-8?B?c2VKTWhUVHQrWFhLRzV4UlZ5OWZUY3dvOHVVSXhIa0FDQU52aVk1NDdQb2dj?=
 =?utf-8?B?QnA5U3VtRG51dkRNZC9uQ05sQzdhVXg5ajYrYXRXbVVKWnZWWVNlM2ZMTFFk?=
 =?utf-8?B?VWFINVRuaEZRY0xLQmlXYnQ1ZWxBY3V3UzdOcHQxRHlOTWloSGxCaGZ1a2lX?=
 =?utf-8?B?YW15YnVmcm1Fb0Z4ZzJNTzE2ZXlTRnpBV0NOVzJzMFJ6THVVQStvU3VTeWYw?=
 =?utf-8?B?QUdobytVdkJrbFpDZFg2bDgrWkd5MW5wMEpUZEpuRlhsR0xDdzZqc0pwT1Y4?=
 =?utf-8?B?bHMxZTZBRjkvbmFTM0p4d3FSd3BsamdxNU5uNW9XWVFTazFCOXFzRU5aOFY2?=
 =?utf-8?B?ZEcxUWljMWRwWkpYd0hLNndJWnV4RnA4VE5kKzZaVFpaUmt0TkpDbGtMRlVB?=
 =?utf-8?B?UGl2eUlmSmUrdjVBekNrNU52OFZEbHVsWjc5V3ozK3U0V0JOc2w0aWhrdmhj?=
 =?utf-8?B?MndWQldIaVdDN0N6Y1FzL0dXdGplMFl4N3NWS0tyaFovckQ1YktRd29yK3lI?=
 =?utf-8?B?N2UzU3kybzR1Zm5ETWZhZGlsL2YrNmdJVEtyb2hnamhTcks5SkwyeVpBU1pB?=
 =?utf-8?B?Sy9rUDVRdEg3QlJWMDIxenFBYWxKbHB0Rk5hNUdsK2dJNVg0Q1N4YjJ6cHc1?=
 =?utf-8?B?RGtHL2ZBWldEM1FxSEI4MStYSzNwNzR2cDY2c3BvbWcrNE55NG9NalRQeGc4?=
 =?utf-8?B?bkR2c1BIR1hTR3UxK2NTVFJMeU9LbUhmWWlkdldaTkQ1Ulp3Zlh4RXVIY2NT?=
 =?utf-8?B?bFB1ZWVIL0QzcGFITFNSUXY1TERPcU94cXc3UlIzN2Noc05rTG9rWFVUWkY2?=
 =?utf-8?B?MnQyQ3Mvb3FpREtTeTk4L1o2Y2FpUWZkclVxVHJZQlAxdnFXQmM4dm5qUHh0?=
 =?utf-8?B?MEs3bG52ZlFRYzQ0WndJVHBLdElqKzRNbGwrUEw2OFpqK1lWM0tiL1hIZVFy?=
 =?utf-8?B?bUIxcDc5bit3aEE3dEdJbWtIeGZVK0NJMWx4Q0Q3NjhGakdOSkZBR2M5RFd2?=
 =?utf-8?B?VVoyTCtPWWpLVHZmU1M4OFF5bURyT2lQOEpyeUxPaEtxdTV2M29uKzBwZmJo?=
 =?utf-8?B?eGlTM2FEcER5WG5uU0NqYVhOTFVrQ2N3allJNFJQVFEyOXEvK2l0aW00b2NZ?=
 =?utf-8?Q?mbXJBaMoBWKfU/A9hw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c2f733-5094-423c-7390-08dececfcae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 13:28:19.0103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3aBkoakkjGyx0Qb8w0ukUMpau+x291ncYT6fdbkyNCGLx0qtRjcVXLPSYz++4gY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdW95dSBXYW5nIDxydW95
dXc1NjBAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSnVuZSAyMCwgMjAyNiAyOjEyIFBN
DQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdTEs
IFRhbw0KPiA8VGFvLlpob3UxQGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFpcmxpZWRA
Z21haWwuY29tOyBzaW1vbmFAZmZ3bGwuY2g7IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFJ1b3l1IFdhbmcgPHJ1b3l1dzU2MEBnbWFpbC5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2M10gZHJtL2FtZGdwdTogaW5pdGlhbGl6ZSByZXQgYmVmb3JlIFVNQyBlcnJv
ciByZWNvcmQgbG9vcA0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJ1b3l1
dzU2MEBnbWFpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzDQo+IGltcG9ydGFudCBhdCBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiB1bWNfdjEyXzBf
ZmlsbF9lcnJvcl9yZWNvcmQoKSByZXR1cm5zIHJldCBhZnRlciB3YWxraW5nIHRoZSBwYWdlcyBy
ZXBvcnRlZCBieQ0KPiBhbWRncHVfdW1jX2xvb2t1cF9iYWRfcGFnZXNfaW5fYV9yb3coKS4gVGhh
dCBoZWxwZXIgY2FuIHJldHVybiB6ZXJvDQo+IGVudHJpZXMsIGxlYXZpbmcgdGhlIGxvb3Agc2tp
cHBlZCBhbmQgcmV0IHVuaW5pdGlhbGl6ZWQuDQo+DQo+IEluaXRpYWxpemUgcmV0IHRvIC1FSU5W
QUwgaW1tZWRpYXRlbHkgYmVmb3JlIHRoZSBsb29wIHNvIHRoZSB6ZXJvLWVudHJ5IHBhdGgNCj4g
cmV0dXJucyBhIGRldGVybWluaXN0aWMgZXJyb3Igc3RhdHVzIHdoaWxlIHByZXNlcnZpbmcgdGhl
IGV4aXN0aW5nIGxvb3ANCj4gYmVoYXZpb3Igd2hlbiBhdCBsZWFzdCBvbmUgcGFnZSBpcyBwcm9j
ZXNzZWQuDQo+DQo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogUnVveXUgV2FuZyA8cnVveXV3NTYwQGdtYWlsLmNvbT4NCj4g
LS0tDQo+IHYzOg0KPiAtIEluaXRpYWxpemUgcmV0IHRvIC1FSU5WQUwgaW5zdGVhZCBvZiAwIHRv
IG1hdGNoIHRoZSBvcmlnaW5hbCBlcnJvcg0KPiAgIHNlbWFudGljcyBwcmVmZXJyZWQgYnkgVGFv
IFpob3UuDQo+DQo+IHYyOg0KPiAtIFNldCByZXQgaW1tZWRpYXRlbHkgYmVmb3JlIHRoZSBsb29w
IGluc3RlYWQgb2YgaW5pdGlhbGl6aW5nIGl0IGluIHRoZQ0KPiAgIGRlY2xhcmF0aW9uLCBhcyBz
dWdnZXN0ZWQgYnkgQ2hyaXN0aWFuLg0KPiAtIEF2b2lkIGRlc2NyaWJpbmcgdGhlIHplcm8tZW50
cnkgY2FzZSBhcyBhbiBhbGxvY2F0aW9uLWZhaWx1cmUgZml4Lg0KPg0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdW1jX3YxMl8wLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dW1jX3YxMl8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYw0K
PiBpbmRleCBkYjUwNWFiMzJmYTBmLi4zODJlNmQyZGRhOWMxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91bWNfdjEyXzAuYw0KPiBAQCAtNjg5LDYgKzY4OSw3IEBAIHN0YXRpYyBp
bnQgdW1jX3YxMl8wX2ZpbGxfZXJyb3JfcmVjb3JkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiAgICAgICAgIGNvdW50ID0gYW1kZ3B1X3VtY19sb29rdXBfYmFkX3BhZ2VzX2luX2Ff
cm93KGFkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWNjX2Vyci0+cGFf
cGZuIDw8IEFNREdQVV9HUFVfUEFHRV9TSElGVCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwYWdlX3BmbiwgQVJSQVlfU0laRShwYWdlX3BmbikpOw0KPiArICAgICAgIHJldCA9
IC1FSU5WQUw7DQo+DQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsNCj4g
ICAgICAgICAgICAgICAgIHJldCA9IGFtZGdwdV91bWNfZmlsbF9lcnJvcl9yZWNvcmQoZXJyX2Rh
dGEsDQo+IC0tDQo+IDIuNTEuMA0K
