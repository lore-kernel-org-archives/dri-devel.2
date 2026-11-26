Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91386606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E6310F51D;
	Thu, 26 Nov 2026 06:27:36 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2A710F51D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl9AGD7NVSKeiQMN8S6wanYjokv5unNkqktM8uJkUOL3SqSp45pqg47Ss1ZzC3VVuSZ0Epc8wGyz97zWRYToSQgi1EenFJC2DCbD2QTIFv8Sawb5ruJ8bMGXHHpEfTm+w1JvESVqePjwCV4mRkQ/DZU4jdin4FIszT58gtVzkS6//b23UY0bhS5RhEPtgG/ybdylP3pGrPKxsHWlhyzPWw1q37XfG4qAgVXvIPY7wkbTb3eueqW58EiQFwA4xNqf+iMVSx31bI3EOe2wvJHK9gBi2aZeS12qRKzeHtGMYB0mOv5+UPmr24yZBLPYmjW8rNKhk1sCYo7n52NnaN6yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Ud6gYFjQxCkViPlVFmY6F9AFpXJBXobv3EU+DHeW0=;
 b=ZHcwrXAFOiXHbDREGcqN5yRQOlIfAB3LE+oiiwCWOndFLI9tGEg7zsi/72ZkJ2kojzQvJ4BtwDhzh65b+zOFMZHVasLSwFJNPdVMP/lIRdb9hYXyHY30suBeKnN7CgxiLP4wdLQHY40/qz2OeCyKSOoVyAnDM5Z67xUFN4AoUw14703/zMghrYZ9B7XpMBMfr78LKDT0EDavCa+1VPGbYm07Kk/f2nv3ie368CZTIiePMWAPH5kJDyxzmtzs1v2PnxRVGWvsAD4S7B/n0JMr70WXmE1OqhlxXo/aa7Hv6/2vsQC2h4Ch51LlVfS+W+IVA+Bhyp2WJcAkL03COAQhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from TYZPR06MB6915.apcprd06.prod.outlook.com (2603:1096:405:3c::5)
 by PUZPR06MB6056.apcprd06.prod.outlook.com with HTTP via P2P; Thu, 26 Nov
 2026 06:27:31 +0000
Received: from TYZPR06MB6915.apcprd06.prod.outlook.com
 ([fe80::8b39:ed07:452c:9396]) by TYZPR06MB6915.apcprd06.prod.outlook.com
 ([fe80::8b39:ed07:452c:9396%6]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:27:31 +0000
From: Luo Liu <Luo.Liu@cixtech.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjUgMS81XSBkdC1iaW5kaW5nczogZGlzcGxheTog?=
 =?utf-8?Q?add_CIX_Sky1_DisplayPort_transmitter?=
Thread-Topic: [PATCH v5 1/5] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
Thread-Index: AQHdfWtlcMSdee5UwEqzPTocfdz2Src/35kAgAACxQA=
Date: Thu, 26 Nov 2026 06:27:31 +0000
Message-ID: <TYZPR06MB6915D02AE69A9A5649146D31F5422@TYZPR06MB6915.apcprd06.prod.outlook.com>
References: <20261126060003.3979478-1-Luo.Liu@cixtech.com>
 <20261126060003.3979478-2-Luo.Liu@cixtech.com>
 <sashiko-outbox-234829@kernel.org>
In-Reply-To: <sashiko-outbox-234829@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-traffictypediagnostic: TYZPR06MB6915:EE_|PUZPR06MB6056:EE_
x-ms-publictraffictype: Email
client-request-id: 89d1a6ec-6431-42df-8bdb-b0088a4a1173
request-id: a450e69c-329e-4bac-a0ef-08df4b8659a2
x-ms-office365-filtering-correlation-id: a450e69c-329e-4bac-a0ef-08df4b8659a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|42112799006|38070700021|10067099003|56012099006|4143699003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: qHVKqhbp8Hv38z9q9pQJzYL9vv/x3i4WfndMrMPUymLET6Cii81zpdhAsDFyr592QvEKG5c2xU8zdphP7ePi0VrN4goob9mn6i2F2Gn5XXp4JgZhF2U2a9To3XWIsLdxKRi+TwZl8LQG7qX45Q5x60tUcB2Go79twQhWyiAOrvg6N6Mr7n+vkdG3LUa6H3Feg0ZEnzsZ0HnRhdOBbmXImd5K5FYVFWchjWVTuiLzLksqbClYnBspIsllFCZtZGfVrvYESQrpMWnOpPMM5FAc9g3NoqHLxU8nFCllU1wrz6TDI8rdjbxYXnznuGQfHbdmE7FPYGjFl4qf66TsyT3UEcm0r6TsLQ06AYJRQC0xrkChe4w0u4b9zEbZR1hUgqVO68ZjMO5sFz2Sxbo5YwWDmYd5wnI/uBr7bPEuJu8facBEROaDD0urYpChdN7SHLS/dBayZthrqRAJ5blneh19OX2dOfwCaDbpbDmUllyg51YpFGE2mAfErHag2Fa51SiwDDNfykkKwHP+rYF79FF4MKVBtZvauNyIC2aCZIoC4gyvZdIBqG700uTav/AK8oYuq2kr++OD/yexgR+lPRj/viBManj8OKxDfU7YeK3Mrm6SdX4vsKKVWBL+4dUWpNB9lWNTguGiXuJi28bbsLv5dsMgroBfYhM4h7NxAz5jYBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(42112799006)(38070700021)(10067099003)(56012099006)(4143699003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2JpUG8rand3VXY1aUFYT1AvYlE4SENqNDNXZlpqVXZGdWdCdml6ZTQ2aFFj?=
 =?utf-8?B?aGQ0RkI1MEdqNGo2TmVTVXh1NUlhV3VTejFsdjZpNkpZaWNFMFFScFREWXc5?=
 =?utf-8?B?L3FYMElJaWx4Q2RFdFVOYUFYR3FnblkvbjlOWktuR1VMdEpsRzNMWFNwMk03?=
 =?utf-8?B?TXV4aStVS25zQnFHaXJzcDRTYTQ2YlJLeWpQZUVxaUJUWXMzQ0h3ZWFpU3dU?=
 =?utf-8?B?a250Z3Y0RHl1MEpJVTNTRkJLM3FnOUpzaXBqRExyN1pKS013Tnl0VGdkbUhU?=
 =?utf-8?B?WWRlWG5USTV3NUJuQnY3WHh3QTBRaElpcWhzRGx2eVEwQ01mSjVBS0dpNDNs?=
 =?utf-8?B?Wm1GSHNkVHlJV1dpNTFmZTlKNXFLQm1NdGxpTlZRa3J2cXplNVdZZGpZME51?=
 =?utf-8?B?bVdRYTJVZSsrTmdobVBLNnI5WVRFZkRoZS9mWi9wcG9Qc2UzSzA1NlVBYUYy?=
 =?utf-8?B?WWpaK1FqVXJvdnBFZjJYZXBIb29HQW5VWkl2YnhzbGtWUkNmS2VvUzF3Vi9U?=
 =?utf-8?B?WGdRbDI4SDNsWEphb29oUlRrMDhXZ2tlRXF4TXJoQ2x2VkZyT0lEUHRKVHJl?=
 =?utf-8?B?b1daL3dDdGorcFlqcUZGNHFJeTZWcmZaYVRHVEdvcHNNMUFpWjJ0SjdFa3pq?=
 =?utf-8?B?WnMxNkVDNmF6Znhqb1F2bzB5NStnM3h2VHE5My92bGhhMVh2SW1DR2lzM242?=
 =?utf-8?B?MmVyZUYvek45akVRRlgraHFKNHBNVmdjN1Y1M004NGIyYzJsUnFZUXNCZU1F?=
 =?utf-8?B?aDYxclk2ODJKYjZ5MFdiVFN4UzRkWDlRZEY3SFpSVGl5b2xRUEpLRi9KR0JM?=
 =?utf-8?B?S1luZ1pyVHQvU0hLdTFtUkJadUpVWVdqNkNTYk84enMvd3RON2VIeEhOb1Qr?=
 =?utf-8?B?M2lvRDg3cUtDWjk0Wk1CNk5VZjBpbDY3SnRwN2l6UTUzSnhlZVc1WjBRblpZ?=
 =?utf-8?B?RlVGQUYvMFQxVEltSnYvc0JSaytmNm5YMHo4RjFFUHZQSFNtdkJhaW5zUHRJ?=
 =?utf-8?B?ejNJTGcwaExGalo1YUNCZHg4YVNJZmRTbkZDQWs0WHpzMExraGFwZjNvQ29v?=
 =?utf-8?B?U01LMk9oQXVNL1daQUFvWlE3b1Z6WTVXOFJPWVJEd1h2ZmFoN1c1ZlhPOWpG?=
 =?utf-8?B?bVA0ZnFxaEZOZ2hhaWZLSTVOUUkrTzhPUXVYY3ZJQ1BtUHROT1p1SFN4cjBx?=
 =?utf-8?B?L29xeTFTQ2tiaVk5T3pHUXRuREM5QWlkM25CVXZTMElDaUVKVkQ5YVhYVHJF?=
 =?utf-8?B?R2dicVdnL0ZPbEpKK2p3RGpaSDByVzI1S0hIczF5NWEzY1FqSnpoQ1UyNEFj?=
 =?utf-8?B?ZDg1SytGbEhXRGNUdjZROTlCUC9HOHhSWjg1RHRxZ3hTSEE3WjBMdzRwL1F0?=
 =?utf-8?B?Ly9FTmtoV0dUM2ZsK1NuUmdtTm95UHdkVlRrVXhxYS9oUk1sOGh4WVYwZ1hY?=
 =?utf-8?B?M25tV3gwTVNBTW1CNFR6dEVCWU1zWUlCeTV3UVdsQ2l6M2pVdGhPRVJCRUVG?=
 =?utf-8?B?U3RvVWNZcUluVWdiSStGRFJJQzBhWm5PeWlXSzJQUC9Cam0yTm41Ny90OFgy?=
 =?utf-8?B?THNOTDRTZkxLbHk0dk9WaVNyczd3N3RLSHpFYnpveWZOc3dmRjIxQ1ZmUko3?=
 =?utf-8?B?YTJpb09yemRzNUk3NkMzR3pzWlNrQUowaFBCQmtqTzFvZE5aUUs3WnVaMElL?=
 =?utf-8?B?VVRrZFJaam9VZ0xsS1ZJeCt0ZFlKaTJBRzJhSWo1Ukp5RWx5Z0V4V0x0SG1B?=
 =?utf-8?B?YjUvMHhvbEEvcTNDWStDcmEwL2RnN3BlV1NabEdTQnBMZUtBT3h3SG5hRUN2?=
 =?utf-8?B?WTZBR1dLRlBsK2l0QllFVGFwditiUjg2ZUNVT2x2UmY3dWNqbWNxU0E5cWRu?=
 =?utf-8?B?KzhwTUZrR2FCejBYdUJPRU9zZlFCMkZHVzF3N05rUVdVOGxhOFhnSkM1MVFM?=
 =?utf-8?B?RFdIbThaWE0velZqdnZWUWEzb2J1VHdCQVFSeC9qQkwwcGFyTHpmN1UwaGo5?=
 =?utf-8?B?TDQyZDhnN2VRaGxYUGpURE4rSjJJbWkzZHgwdm1tSVE4ZWFURjNKemhUY1VE?=
 =?utf-8?B?UUFJdE55b240OUh1bm5TZWNzTmVhYmZVN2dkdFJwRmNGVExJNS9UdEw0Q29W?=
 =?utf-8?B?VkJrSVdUQjltVVBKYUIzb2FJU2J2Z25hYldIaHpsdDh6NGdOT2pSdjNVOHUz?=
 =?utf-8?B?ckhFWkZnUmtlZjZiL0N0ekMxRVgzTlBDUXUzT2V3c0lSNUplaDZFV3l0VDBm?=
 =?utf-8?B?QTkzTzIvVGp0MHBZajBtdm9KdWxwZFVXYTJZY0E5U25QaW9zQWFPbDA1NWxt?=
 =?utf-8?Q?swxwWUu/deAZTGtuaW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6915.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a450e69c-329e-4bac-a0ef-08df4b8659a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:27:31.1035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlpBqnJXUzIzOBj27aIEAFsxIyCsZQo0821VdiWFN7CUg86JlU/JXJdCJakcoeQ4DFEnCzihEVZtaKuEe1AZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6056
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IHNhc2hpa28tYm90QGtl
cm5lbC5vcmcgPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAyNuW5
tDEx5pyIMjbml6UgMTQ6MTMNCj4g5pS25Lu25Lq6OiBMdW8gTGl1IDxMdW8uTGl1QGNpeHRlY2gu
Y29tPg0KPiDmioTpgIE6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5v
cmcNCj4g5Li76aKYOiBSZTogW1BBVENIIHY1IDEvNV0gZHQtYmluZGluZ3M6IGRpc3BsYXk6IGFk
ZCBDSVggU2t5MSBEaXNwbGF5UG9ydA0KPiB0cmFuc21pdHRlcg0KPg0KPiBFWFRFUk5BTCBFTUFJ
TA0KPg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmll
dyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZSB0bw0KPiBjb25zaWRlcjoNCj4gLSBbTWVkaXVtXSBk
dC1iaW5kaW5nczogZGlzcGxheTogY2l4LHNreTEtZHA6IG1pc3NpbmcgcG9ydHMvcG9ydEAxIGFu
ZA0KPiAgIGF1eC1idXMgaW4gc2NoZW1hDQo+IC0tDQo+DQo+IGNvbW1pdCAwZmQyY2Y0OTUyYWM1
N2VmYTUyZWNkODE3OTExMDlmODQ0OTE2NzNiDQo+IEF1dGhvcjogTHVvIExpdSA8THVvLkxpdUBj
aXh0ZWNoLmNvbT4NCj4NCj4gZHQtYmluZGluZ3M6IGRpc3BsYXk6IGFkZCBDSVggU2t5MSBEaXNw
bGF5UG9ydCB0cmFuc21pdHRlcg0KPg0KPiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBEZXZpY2UgVHJl
ZSBiaW5kaW5nIHNjaGVtYSBmb3IgdGhlIFRyaWxpbmVhciBEaXNwbGF5UG9ydA0KPiB0cmFuc21p
dHRlciBpbnRlZ3JhdGVkIG9uIENJWCBTa3kxLg0KPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2NpeCxza3kxLWRwLnlhbWwN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2NpeCxza3kx
LWRwLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAw
MDAuLjJjYjRkYmI4ZDVmZTUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvY2l4LHNreTEtZHAueWFtbA0KPiA+IEBA
IC0wLDAgKzEsMTAyIEBADQo+DQo+IFsgLi4uIF0NCj4NCj4gPiArICBwb3J0Og0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0DQo+ID4gKyAgICBkZXNj
cmlwdGlvbjoNCj4gPiArICAgICAgVmlkZW8gaW5wdXQgZnJvbSB0aGUgTWFsaSBENzEgZGlzcGxh
eSBwaXBlbGluZSAoS29tZWRhKSB0aGF0IGRyaXZlcw0KPiA+ICsgICAgICB0aGlzIGNvbnRyb2xs
ZXIuIFRoZSBsaW5rIHRvIHRoZSBzaW5rIGlzIHRocm91Z2ggcGh5cyAoVVNCLUMgY29tYm8gUEhZ
DQo+ID4gKyAgICAgIG9yIHRoZSBuYXRpdmUgRFAgUEhZKSwgbm90IGEgc2Vjb25kIE9GIGdyYXBo
IHBvcnQgb24gdGhlIERQVFguDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSBjbG9ja3MN
Cj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSByZXNl
dHMNCj4gPiArICAtIHBoeXMNCj4gPiArICAtIHBvcnQNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPg0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gU2hvdWxkIHRoaXMg
c2NoZW1hIGRlZmluZSBhIHBvcnRzIGNvbnRhaW5lciB3aXRoIHBvcnRAMCAoaW5wdXQpIGFuZA0K
PiBwb3J0QDEgKG91dHB1dCksIGFzIHdlbGwgYXMgYW4gb3B0aW9uYWwgYXV4LWJ1cyBwcm9wZXJ0
eSBmb3IgZURQIHBhbmVscywgaW5zdGVhZA0KPiBvZiByZXF1aXJpbmcgYSBzaW5nbGUgdW5udW1i
ZXJlZCB0b3AtbGV2ZWwgcG9ydCBub2RlPw0KPg0KPiBUaGUgcGh5cyBwcm9wZXJ0eSBvbmx5IHJl
ZmVyZW5jZXMgdGhlIGxvY2FsIFNvQyBQSFkgcHJvdmlkZXIgYW5kIGRvZXMgbm90DQo+IGRlc2Ny
aWJlIGRvd25zdHJlYW0gc2luayBvciBBVVggYnVzIHRvcG9sb2d5LiAgSW4gYWRkaXRpb24sIGFu
IG91dHB1dCBwb3J0DQo+IGNhbm5vdCBiZSBhZGRlZCBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSBs
YXRlciB3aGlsZSBhIHRvcC1sZXZlbCB1bm51bWJlcmVkDQo+IHBvcnQgbm9kZSBpcyByZXF1aXJl
ZDogb2ZfZ3JhcGhfZ2V0X3BvcnRfYnlfaWQoKSBzY29wZXMgcG9ydCBsb29rdXAgZXhjbHVzaXZl
bHkNCj4gdG8gYSBwb3J0cyBjaGlsZCBub2RlIHdoZW5ldmVyIG9uZSBpcyBwcmVzZW50LCBzbyBh
IGJvYXJkIERUUyBhZGRpbmcNCj4gcG9ydHMvcG9ydEAxIHdvdWxkIGhpZGUgYW4gU29DIERUU0kg
dG9wLWxldmVsIHBvcnQgbm9kZSB1bmxlc3MgdGhlIGJpbmRpbmcgaXMNCj4gbWlncmF0ZWQgZnJv
bSBwb3J0IHRvIHBvcnRzLg0KPg0KDQoNCkhpLA0KDQpUaGlzIGRldmljZSBoYXMgZXhhY3RseSBv
bmUgT0YgZ3JhcGggcG9ydDogaXRzIHZpZGVvIGlucHV0LCB3aGljaCBpcw0KbGlua2VkIGZyb20g
dGhlIEtvbWVkYSBkaXNwbGF5IHBpcGVsaW5lLiBUaGUgRFAgbGluayBpdHNlbGYgaXMgbm90IGFu
IE9GDQpncmFwaCBjb25uZWN0aW9uLiBUaGUgb3V0cHV0IGdvZXMgdGhyb3VnaCB0aGUgZ2VuZXJp
YyBQSFkgcmVmZXJlbmNlZCBieQ0KInBoeXMiIHRvIGEgcGh5c2ljYWwgY29ubmVjdG9yIG9uIHRo
ZSBib2FyZCwgYW5kIHRoYXQgY29ubmVjdG9yIGlzIGNyZWF0ZWQNCmJ5IGRybV9icmlkZ2VfY29u
bmVjdG9yX2luaXQoKSBmcm9tIHRoZSBicmlkZ2Ugb3BlcmF0aW9ucy4gVGhlcmUgaXMgbm8NCmRv
d25zdHJlYW0gc2luayBub2RlLCBzbyBhIHBvcnRAMSB3b3VsZCBoYXZlIG5vIHJlbW90ZS1lbmRw
b2ludCB0byBwb2ludA0KYXQgYW5kIGNvdWxkIG9ubHkgYmUgbGVmdCBkYW5nbGluZy4NCg0KVGhl
IHNjaGVtYSB0aGVyZWZvcmUgZm9sbG93cyB0aGUgdXN1YWwgY29udmVudGlvbiBvZiBhIHNpbmds
ZSB1bm51bWJlcmVkDQoicG9ydCIgd2hlbiB0aGUgZGV2aWNlIGhhcyBleGFjdGx5IG9uZSBwb3J0
Lg0KDQpZb3UgYXJlIHJpZ2h0IHRoYXQgb2ZfZ3JhcGhfZ2V0X3BvcnRfYnlfaWQoKSBzd2l0Y2hl
cyB0byBhICJwb3J0cyIgY2hpbGQNCmFuZCB3b3VsZCB0aGVuIG5vIGxvbmdlciBzZWUgYSB0b3At
bGV2ZWwgInBvcnQiLiBCdXQgbm8gYm9hcmQgRFRTIGNhbg0KbGVnaXRpbWF0ZWx5IGFkZCBhbiBv
dXRwdXQgcG9ydCBoZXJlLCBiZWNhdXNlIHRoZXJlIGlzIG5vIG5vZGUgdG8gY29ubmVjdA0KaXQg
dG8sIHNvIHRoYXQgc2l0dWF0aW9uIGNhbm5vdCBhcmlzZSBmb3IgdGhpcyBiaW5kaW5nLiBBIGZ1
dHVyZSB2YXJpYW50DQp0aGF0IGRvZXMgbW9kZWwgYSBkb3duc3RyZWFtIG5vZGUgd291bGQgY29t
ZSB3aXRoIGFuIHVwZGF0ZWQgc2NoZW1hLCBhbmQNCml0cyBEVFMgdXNlcnMgd291bGQgYmUgY29u
dmVydGVkIGF0IHRoZSBzYW1lIHRpbWUuDQoNCiJhdXgtYnVzIiBpcyBzcGVjaWZpYyB0byBlRFAg
cGFuZWxzIHRoYXQgc2l0IGFzIGEgY2hpbGQgb2YgdGhlIEFVWA0KY2hhbm5lbC4gVGhpcyBiaW5k
aW5nIGNvdmVycyBib3RoIHRoZSBVU0ItQyBEUCBhbmQgdGhlIG5hdGl2ZSBEUCBvdXRwdXQNCmFu
ZCBkb2VzIG5vdCBiaW5kIGFueSBwYW5lbCwgc28gdGhlIHByb3BlcnR5IHdvdWxkIGRlc2NyaWJl
IGhhcmR3YXJlIHRoYXQNCm5vIGNvZGUgZHJpdmVzLiBJdCBjYW4gYmUgYWRkZWQgYXMgYW4gb3B0
aW9uYWwgcHJvcGVydHkgbGF0ZXIgaWYgYW4gZURQDQpwYW5lbCBub2RlIGlzIGV2ZXIgbmVlZGVk
OyB0aGUgaW5wdXQgcG9ydCBzdGF5cyB3aGVyZSBpdCBpcyBlaXRoZXIgd2F5LCBzbw0KdGhhdCBw
YXJ0IGlzIG5vdCBibG9ja2VkIG9uIHRoZSBjaG9pY2Ugb2YgInBvcnQiIHZlcnN1cyAicG9ydHMi
Lg0KDQpUaGFua3MsDQpMdW8NCg0KPiAtLQ0KPiBTYXNoaWtvIEFJDQo+IHJldmlldyDCtyBodHRw
czovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjExMjYwNjAwMDMuMzk3OTQ3OC0xLUx1by5M
aXVADQo+IGNpeHRlY2guY29tP3BhcnQ9MQ0KDQoNCuacrOmCruS7tuWPiuWFtumZhOS7tuWMheWQ
q0NJWOWFrOWPuOeahOS/neWvhuS/oeaBr++8jOWPl+azleW+i+S/neaKpO+8jOS7heS+m+acrOmC
ruS7tuaMh+WumueahOaUtuS7tuS6uuafpemYheOAguS4peemgeS7u+S9leacque7j+aOiOadg+ea
hOS9v+eUqOOAgeS8oOaSreOAgeWIhuWPkeaIluWkjeWItuacrOmCruS7tuWPiuWFtuS7u+S9leWG
heWuueOAguatpOmZkOWItumAgueUqOS6juaMh+WumuaUtuS7tuS6uuS7peWklueahOaJgOacieS6
uuWRmO+8jOWMheaLrOacque7j+aYjuehruaOiOadg+WkhOeQhuatpOexu+S/oeaBr+eahENJWOWF
rOWPuOWRmOW3peaIluS7o+eQhuS6uuOAguiLpeaCqOivr+aUtuacrOmCruS7tu+8jOivt+eri+WN
s+mAmuefpeWPkeS7tuS6uu+8jOW5tuawuOS5heWIoOmZpOmCruS7tuWPiuaJgOaciemZhOS7tuOA
guS6kuiBlOe9keS8oOi+k+aXoOazleS/neivgeWPiuaXtuaAp+OAgeWuieWFqOaAp+OAgeWujOaV
tOaAp+WSjOaXoOeXheavkuaAp++8jENJWOWFrOWPuOWvueS7u+S9leS8oOi+k+mUmeivr+aIlumB
l+a8j+amguS4jeaJv+aLhei0o+S7u+OAgg0K
