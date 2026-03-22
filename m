Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD52AEC01A0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B772010E419;
	Mon, 23 Mar 2026 08:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ntlKrGJy";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazolkn19011000.outbound.protection.outlook.com [52.103.1.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B239010E141;
 Sun, 22 Mar 2026 17:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUodsq0lzcl9BkyWYOepZtVj2idHkpF0HqUnfaWZSQDZmFsXk+pGoc7qWgqPEiMzPd0wdfDcBpPMgAFrOBcG5CDgPVs94Zb7I89InXbkuo+NtEgYSBKGo0FDfhta+AaM3Yc2XE8/2V86bAO73y1245IV91T1qalg5aH6RmslD5+rKi0EAf78HX0S0/QOB6pn4b9ewEGNWXm1kqvLGlAAonyyddoW1Oyu8shrTklpg1KlbFKD/YL8m221sMQui+F1BCGp+bmB0OhwgO9ysLKXkv8ciSExl8w8358egKKh/aL3Nj1VxMgHaDZi6e+FA70ip3ewtC4h+JeN67Hf22N4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMIPGW7NRfCkZ2jM46nxT2/nPO2FLGzaj+gg8HvwD+c=;
 b=RQTjp+d+eklTIifHd7OAg16D67f0les/vP9/B176agHUSxG7JAubojpJzIZl1CuAt77iVDRg71NAUeM8xcgmAe7bel2Je03f26h86hkznzX13tnY7FrYrJVvb5TDYsRDnGUaTnqR3pV3SzrwJcCjixqAyyS6aRUpM4wJgeG/OY/TQ1AKphEFAeZFYrJrDekxWgpdx/Q2FODbmBlFc2j8pDfKTOGo3fbZjUpyTuLOrp16NnXIKKN36ipLX17ItJABysZ+PpqUowFUQQEaRm4y+C+/2gZtFEhqnhx2pp7tz9fDC+vr7BFjHKul0A3hDnHCcHzVRZXkhrT1saHsa/bEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMIPGW7NRfCkZ2jM46nxT2/nPO2FLGzaj+gg8HvwD+c=;
 b=ntlKrGJyJrJ3wy7hEKo2wLasao4D3BHZm8v5RBQ0RImBEojqkx7vTVG2iPfqnnmaRIusSUL8w87C6TC4F1HVmw9PG3ycrDnNe5nz0GFvBgO0K/cGW9RJOarF9QrmhXYQr3TpB/h/BoiKKoNy/dzWNO/F0MJY27XiYRHAUfT3pK/d7pS2CdkjUuy0zyGIxgPV9ypiOUKZ/lR7Xz1qkBRnuZq9A9tV3ypNMMpZp+6qFW/gYfgETaYNIcpSZqd09tPloyPH/zEc2T6LvEi+6dceqUKuPE34crHnLPnptp1L9vVWADg9rW21VXoTQ/+kbiNrxzqx6EsUUpilT4grVRq+AA==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by CPUPR80MB6232.lamprd80.prod.outlook.com (2603:10d6:103:c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 17:47:54 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 17:47:53 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] amdgpu (Tonga) HDMI no signal after suspend/resume on
 X11, system freeze
Thread-Topic: [REGRESSION] amdgpu (Tonga) HDMI no signal after suspend/resume
 on X11, system freeze
Thread-Index: AQHcuiOcDu+puIP0vki7wRFjN3FMZw==
Date: Sun, 22 Mar 2026 17:47:53 +0000
Message-ID: <CPUPR80MB6583406554BFA9508FB982E3A34AA@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|CPUPR80MB6232:EE_
x-ms-office365-filtering-correlation-id: 650fa4bd-9153-4e6b-862f-08de883b250f
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|461199028|8062599012|8060799015|19110799012|51005399006|15030799006|15080799012|25031999004|22091999003|24121999003|10035399007|1602099012|40105399003|102099032|440099028|4302099013|3412199025;
x-microsoft-antispam-message-info: =?utf-8?B?ZkJqMG90aGxoVmhlZlpuQ3E5SnZZa010MlcyVlo5UHI0dWNPMmhHWm1CSjNM?=
 =?utf-8?B?YnoySjg2UUtTa3M3dndLVFhyRE4raWVOSm0wc0pEUEl6ZmE5QXFncFdtKzBT?=
 =?utf-8?B?L1RVQ1lJc3plKzljbmZyeGMzUVhzdkp0SXZ5ZWkrQjduRG9MaXg2Nis3ZVNB?=
 =?utf-8?B?NmE3U2FwcHNyOTNPVko5K0FBN0RxTEFPd1ZKMFlORmhoWkx4WFVyMWp5Wk5p?=
 =?utf-8?B?QzFha0NBWkJEcndTMXVUWHZjSXlHRUowVHJwSmVMN29hZVU1alhpb1Y3MVY5?=
 =?utf-8?B?ZG5pWk1YNUd6aVNaaW83d0lBMEJqK0F2QjM2VVlvSFJPKzIrd3c2OEdWbXky?=
 =?utf-8?B?YXRnZXVBWkh4RkpPQyttYjZ4bnNMNFloRThOdUw5WFpWWW84VGhXMEpFeFM2?=
 =?utf-8?B?RUFLekg5TVRwRll1T28rQ3dLWnhKeitTNkxFUTFlbnlaanFBSUhZS1hSOUph?=
 =?utf-8?B?TjZ0UVFJdVlWSTlsa1JqMkI5RXRFaVdFMzMvVlZFbjFZaFQ1QnlqTW0zVFpF?=
 =?utf-8?B?Q2psUmZzV1RiU0JidFJWWFVBV3NkQ0UwRkdCNXBMTXBhV2VjeUNMdTV0UjlB?=
 =?utf-8?B?SkxRS3BiWmEzZFRpS1Zad3g4RmFLUTJJdG9pSTVRMnFGOVJMMisxUDFoRk9k?=
 =?utf-8?B?WHJrUHJJeC83QnpXaExPTEo5eDdXQU1MUG45WmtRaVJHbHpMWTFUbWVuanRD?=
 =?utf-8?B?SW1IbzJ5eDhvYlprMUc2ckhtZk1Ia1NOei9CUmtyYUZSaFRFYlhETHVKR09n?=
 =?utf-8?B?aWxXUUFJUEhhZjc5N2RML21paE8vV1hXNmk1N2RNNUJxVk54TjRLUXR4Rkpu?=
 =?utf-8?B?YXYzVUtHTGRyVk03ZDQ5djRtTzhHc0M4R0JwSGNsTjdQaHdndE9WZ0x1dEUx?=
 =?utf-8?B?ZnUydVhkd2NUemhXbU42VXJiTnBGVDdhOU9LQjlNNnErVFBCOWd6S3N2bXho?=
 =?utf-8?B?S3poSmVuK1JBczFvb3MvcWNpZmVGMTJSb2NKV1lGWXMzZjFCQlhlTkhWdXZs?=
 =?utf-8?B?RHBrZGVOSDloeE9LOU54d053QjRXZTFweTBabGw3bC9yWlRXbzVIRjFhZmd0?=
 =?utf-8?B?NUNNeTVJTVRaaVRtY2Q1Mk5aeDE2N25NVE16eHMydzZuazhXZitKd0U4SHNT?=
 =?utf-8?B?M0Rzby9nVUVnekNhdTlrQUxRemJRWTVFVld1NENycnQ4K0dwcC80YkVkSHFu?=
 =?utf-8?B?d090UGtJcDM5V0t5YndaN1NzdGtCRWI2NUtOckkrd3h2SnFpOHdYTEJ6cUlD?=
 =?utf-8?B?RkkzOHp4YlFyRW1IQmZtNy96amU5YjlpeFg1YXNSN2hBNFRXZU9zdTkvandE?=
 =?utf-8?B?NmhkTjZvMldQbVZ6QnljTmNuSXR1ZldKNmx6RUhRemxVQjRkekhSWU1RdjRC?=
 =?utf-8?B?NHZWUWRYQnNURVdPeHl2ZDFRS1BrZkVjb1g5WEhQdHFkQUZVNDl0VkNIK2hz?=
 =?utf-8?B?RGhZQWlEOCtIWHVER3FOOGFuZVZVcDExUkRtY2wvaXpEWURxOTNMSWZSOTc3?=
 =?utf-8?B?b0hhd1ZqbkhBTktWWEhCd2dLcjlHeWdWNmlxMkJCUGZmZmFUSnRsN0Jpd3I2?=
 =?utf-8?Q?eL/2DhS4vPb7C5Qh7NaxIO7ns=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2lscEh4UFJZZ1Rhc21UWU4wMFd4TXA0TTVKRjJKUTl3blNHZWxiSVFweVVD?=
 =?utf-8?B?M0dpUWVmYnpSNEZ4V1Z0YTVNNExVdGpqaGExbFJxcnRPZThkQWw1d0dNT09i?=
 =?utf-8?B?ei9qZlU1KzA5Vk16Qy9vNTU3VVJnNVJWRDBMYU1xWFhRQWcxc01YY09HbGlw?=
 =?utf-8?B?djYrcU13REdGZ0ljenVHVHVMK0ZWNCtuc1l6enRlM2RLVGkrS2hsTkJybHFt?=
 =?utf-8?B?VXZEM0tMTEt2bWxhb0ZMZXlNNjFCMmdFSGgzTkp3NkQ4Sm00MVFNZGxNOFgy?=
 =?utf-8?B?Z1dTTnlvcVVTVC9sMHpHK09FQ1BKMFp5MVYreDI1elNmNTgvZUltdlJSMFZT?=
 =?utf-8?B?Mmo3VXlzTzc0WWtwZ0tnTjJZUkNRaVNuRlFhbXNPL1lZMlVPbEJUREZFcHFY?=
 =?utf-8?B?b2xiQnk1c2gzLzRSVzRuSFNwTi9qTkdtcGRJeTZtMXlucTMyWWd4OVd3dTlE?=
 =?utf-8?B?c3FQL3pha1VpYmtnMDRna3EyeXZpODZRRzZ1T0JlQVhYekYxR1B2dmZpWGR3?=
 =?utf-8?B?Tk1WUHBkdUtydksrNmpDeXBnV1AyZzBLaHNLUTkxeTdLeXFldzVNb0NtQ2pZ?=
 =?utf-8?B?aFZxbG5zOFRIOExxcFZkUVpHdGZMYjdia1dDWDFDQzNiQkg1OFJEWHVwZy8y?=
 =?utf-8?B?NlZERitydloxMy9IMjJlNHBjS2dUU2VoTWYyQSt5MEpUUHZyci9iRHZoTG91?=
 =?utf-8?B?bHFNN3ZBLzR6K1ZUSStqeTl3UHBPTUZDQ0ZydEg3eG02RWVHU2pMSDVyUGs2?=
 =?utf-8?B?dHcxak9kREh2Mnp5L3NnTUFMc2YrdEVWOVltazV5eWNWeVZ4VFZmbjBlTkVN?=
 =?utf-8?B?REdWRWN4WDg1Q29obmlWc1JVRS9Dc2NVa3ptMzNDZWpDYjZFK2NOOXpkbXNK?=
 =?utf-8?B?OWZ4M256VktBNTErU3JZb3lDOVFpaTB5UEp2TTVHblJCQzJUQkI0S2dTazVp?=
 =?utf-8?B?NjNBa0tUeVdPeWEwR3UyMWJxK2k5NDhTL2c3Qms2azdZOWRnSnh6Y2hJUXIv?=
 =?utf-8?B?S2dadk5nMHJLMkNqaUdwRGM3KzdCc3UrUlA3UnF6L0tHZkJLYk55OUxuSlo4?=
 =?utf-8?B?NGoyYzYzUkY1VDFaeDNGUnRiUFFWQ2ZZTHF3VkJsenlNTmhiM093dld1U3Z3?=
 =?utf-8?B?OVRlRUZBRHJaSUV5RDgzVHBXcUZla2FzdUVoSkZKY0ZNRG1NSWZOdnkvVlh3?=
 =?utf-8?B?c2Zyc3N3dDYwS1BPblJyWlRDMUd1d2pQOG5YdXA0ZkNvQUJqNXJUSFBlZm1o?=
 =?utf-8?B?K3RmbEJtS0NBeUdWNEhaSlJlbVZNOXBadWhZTnlvWHZOZ2wzZk5vSUVoWnRa?=
 =?utf-8?B?VlhTWTFtN2lQSHF1YzZKS05VcmgrVE1SdnBVTm5SMjZJUWVKZHlvbEtUazQv?=
 =?utf-8?B?SGN0S29Eclp2WHMrcUpsOFA5blkvV05jL3JCOGhsbHdNbTNCL2hsT0Q3L2c3?=
 =?utf-8?B?Mll3ekZXdkVLMUtmalM1cG40cDkwY1lteG5kdzRSY2VWY1owS1JWTE1MeXBj?=
 =?utf-8?B?UmZER2ZWNkxja0N5TUNlRjFQOC9wS2lqTUl0ZTNQQUhBVzBZaXhBK2swVTdx?=
 =?utf-8?B?WFN6VWYvWm5TejJiWXYzZEUra2oyWEpQY3Rpb09XLys5RFEyVHRLVFhkRFZU?=
 =?utf-8?B?OFpWWXBFb2E3b1VBOUxXdEFjRC9kVCsvNU5LcnIwUmk1aUtIWGZVS1h2WjZx?=
 =?utf-8?B?WStTYTVtMFVKckhOT0ZuTk5XRUtuclJpK2U3blR4STB5dE9kM29tc2ZYanRU?=
 =?utf-8?B?Q0ZDS2d1REdjR1kyWFVpRHFObllPVWMyb01pMVlodHZpZ1A5ODJIZlBUWHN1?=
 =?utf-8?B?a3JxWjJXcDJkWFgrVDdPZFFqTGNNRzBPZ0VUTXVHcmNESU5qRDg5MHZqV2dm?=
 =?utf-8?B?K0xIYnI1N2c1R0hXbXFwUnh3cXhpUnhpOGhGL0N3SU4xem1TMWhQcjQ0R0E5?=
 =?utf-8?B?eWc4OXpmckhwb0NpSlZQc0xNU1N0dExoRk5pdnBrYXJmN2IvUkpEZTlpcEcy?=
 =?utf-8?B?Z1RMY1VDM29nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 650fa4bd-9153-4e6b-862f-08de883b250f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 17:47:53.9260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPUPR80MB6232
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

ZGFuaWxvQGRhbmlsby1CNDUwLUFPUlVTLVBSTy1XSUZJOn4va2VybmVsLWJpc2VjdC9saW51eCQg
Z2l0IGJpc2VjdCBnb29kCmIzYzk4MDUyZDQ2OTQ4YThkNjVkMjc3OGM3ZjMwNmZmMzgzNjZhYWMg
aXMgdGhlIGZpcnN0IGJhZCBjb21taXQKY29tbWl0IGIzYzk4MDUyZDQ2OTQ4YThkNjVkMjc3OGM3
ZjMwNmZmMzgzNjZhYWMKTWVyZ2U6IDRhNWZkNDE5OTUyZSA0OTg0NTYzODIzZjAKQXV0aG9yOiBQ
YW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpEYXRlOiDCoCBXZWQgQXByIDI2IDE1
OjU2OjUxIDIwMjMgLTA0MDAKCsKgIMKgIE1lcmdlIHRhZyAna3ZtLXg4Ni12bXgtNi40JyBvZiBo
dHRwczovL2dpdGh1Yi5jb20va3ZtLXg4Ni9saW51eCBpbnRvIEhFQUQKwqAgwqDCoArCoCDCoCBL
Vk0gVk1YIGNoYW5nZXMgZm9yIDYuNDoKwqAgwqDCoArCoCDCoCDCoC0gRml4IGEgYnVnIGluIGVt
dWxhdGlvbiBvZiBFTkNMUyBpbiBjb21wYXRpYmlsaXR5IG1vZGUKwqAgwqDCoArCoCDCoCDCoC0g
QWxsb3cgZW11bGF0aW9uIG9mIE5PUCBhbmQgUEFVU0UgZm9yIEwyCsKgIMKgwqAKwqAgwqAgwqAt
IE1pc2MgY2xlYW51cHMKCsKgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyB8IDExMiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCsKgYXJjaC94ODYva3ZtL3Zt
eC9zZ3guYyDCoCDCoHwgwqAgNCArLQrCoGFyY2gveDg2L2t2bS92bXgvdm14LmMgwqAgwqB8IMKg
MTUgKysrKysrKwrCoDMgZmlsZXMgY2hhbmdlZCwgOTEgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRp
b25zKC0pCmRhbmlsb0BkYW5pbG8tQjQ1MC1BT1JVUy1QUk8tV0lGSTp+L2tlcm5lbC1iaXNlY3Qv
bGludXgkwqAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpEZTrCoERh
bmlsbyBNYWNoYWRvIDxkYW5pbG9tYWNoYWRvMjAwMkBob3RtYWlsLmNvbT4KRW52aWFkbzrCoHF1
aW50YS1mZWlyYSwgMTkgZGUgbWFyw6dvIGRlIDIwMjYgMTE6MTgKUGFyYTrCoEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPgpBc3N1bnRvOsKgUkU6IEFNREdQVSBUb25nYSBzdXNw
ZW5kIHJlZ3Jlc3Npb24gaWRlbnRpZmllZCBiZXR3ZWVuIGtlcm5lbCA2LjMgYW5kIDYuNArCoApI
ZWxsbyBBbGV4LApJIGhvcGUgeW91J3JlIGRvaW5nIHdlbGwuCkZpcnN0CiBvZiBhbGwsIHRoYW5r
IHlvdSBmb3IgeW91ciBndWlkYW5jZSBhbmQgZW5jb3VyYWdlbWVudCByZWdhcmRpbmcgdGhlIApi
aXNlY3QgcHJvY2VzcyDigJQgaXQgd2FzIHZlcnkgaGVscGZ1bCBhbmQgYWxsb3dlZCBtZSB0byBu
YXJyb3cgZG93biB0aGUgCmlzc3VlIHByZWNpc2VseS4KSQogd291bGQgbGlrZSB0byByZXBvcnQg
YSByZWdyZXNzaW9uIGFmZmVjdGluZyBteSBHUFUsIGFuIEFNRCBSYWRlb24gUjkgCjM4MCAoVG9u
Z2EpLCB3aGVyZSBIRE1JIG91dHB1dCBzdG9wcyB3b3JraW5nIGFmdGVyIHN1c3BlbmQvcmVzdW1l
LiBUaGUgCmlzc3VlIGlzIGZ1bGx5IHJlcHJvZHVjaWJsZSBhbmQgd2FzIG5vdCBwcmVzZW50IGlu
IExpbnV4IDYuMy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrwn5SN
IFN1bW1hcnkKR1BVOsKgQU1EIFJhZGVvbiBSOSAzODAgKFRvbmdhKQpDUFU6wqBBTUQgUnl6ZW4g
NSA1NTAwClJBTTrCoDE2IEdCCkRpc3BsYXk6wqBIRE1JCkRyaXZlcjrCoGFtZGdwdSAoUkFEViBU
b25nYSkKRGlzcGxheSBzZXJ2ZXIgYmVoYXZpb3I6ClgxMSDihpIg4p2MIEhETUkg4oCcbm8gc2ln
bmFs4oCdIGFmdGVyIHJlc3VtZQpXYXlsYW5kIOKGkiDinIUgV29ya3Mgbm9ybWFsbHkKS2VybmVs
IHN0YXR1czoKTGludXggNi4zIOKGkiDinIUgV29ya2luZyBjb3JyZWN0bHkKTGludXggNi40KyDi
hpIg4p2MIFJlZ3Jlc3Npb24gcHJlc2VudCAoWDExIG9ubHkpCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18K4pqg77iPIFByb2JsZW0gRGVzY3JpcHRpb24KQWZ0ZXIKIHJl
c3VtaW5nIGZyb20gc3VzcGVuZCB1bmRlciBYMTEsIHRoZSBzeXN0ZW0gY29udGludWVzIHJ1bm5p
bmcgbm9ybWFsbHksCiBidXQgdGhlIEhETUkgZGlzcGxheSBsb3NlcyBzaWduYWwgY29tcGxldGVs
eSAoIm5vIHNpZ25hbCIpLgpUaGUgaXNzdWUgaXMgMTAwJSByZXByb2R1Y2libGUgYW5kIHJlcXVp
cmVzIGEgcmVib290IHRvIHJlc3RvcmUgdmlkZW8gb3V0cHV0LgpUaGlzIHByb2JsZW0gZG9lcyBu
b3Qgb2NjdXIgdW5kZXIgV2F5bGFuZCwgd2hpY2ggc3Ryb25nbHkgc3VnZ2VzdHMgYW4gaXNzdWUg
aW4gdGhlIFgxMS9EUk0gaW50ZXJhY3Rpb24gcGF0aCBvciBkaXNwbGF5IHJlaW5pdGlhbGl6YXRp
b24gc3BlY2lmaWMgdG8gdGhhdCBzdGFjay4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwrwn6eqIEJpc2VjdCBSZXN1bHQKQSBmdWxsIGdpdCBiaXNlY3TCoHdhcyBwZXJm
b3JtZWQgYmV0d2VlbiBMaW51eCA2LjMgKGdvb2QpIGFuZCBMaW51eCA2LjQgKGJhZCkuClJlc3Vs
dDoKRmlyc3QgYmFkIGNvbW1pdDoKYjNjOTgwNTJkNDY5NDhhOGQ2NWQyNzc4YzdmMzA2ZmYzODM2
NmFhYwpNZXJnZSB0YWcgJ2t2bS14ODYtdm14LTYuNCcKTGFzdCBrbm93biBnb29kOgo0YTVmZDQx
OTk1MmU0OWVmODcwZTkyNTlkODE1NzE4MDYyODcxY2MxCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18K8J+noCBBZGRpdGlvbmFsIE5vdGVzCkFsbCBpbnRlcm1lZGlhdGUg
Y29tbWl0cyB0ZXN0ZWQgZHVyaW5nIGJpc2VjdCAobW9zdGx5IEtWTS1yZWxhdGVkKSB3ZXJlIG1h
cmtlZCBhcyBHT09ELgpUaGUgcmVncmVzc2lvbiBhcHBlYXJzIHRvIGJlIGludHJvZHVjZWQgaW5k
aXJlY3RseSB2aWEgdGhpcyBtZXJnZSByYXRoZXIgdGhhbiBhIGRpcmVjdCBhbWRncHUvRFJNIGNo
YW5nZS4KVGhlIGJlaGF2aW9yIHN0cm9uZ2x5IHN1Z2dlc3RzIGEgZmFpbHVyZSBpbiBkaXNwbGF5
IHJlaW5pdGlhbGl6YXRpb24gb3IgRURJRCBoYW5kbGluZyBhZnRlciByZXN1bWUsIHNwZWNpZmlj
YWxseSBhZmZlY3RpbmcgWDExLgpGdWxsIGJpc2VjdCBsb2cgYXZhaWxhYmxlIHVwb24gcmVxdWVz
dC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrwn5KhIFJlYWwtd29y
bGQgcmVsZXZhbmNlCkRlc3BpdGUgYmVpbmcgYW4gb2xkZXIgR1BVLCB0aGUgUjkgMzgwIChUb25n
YSkgcmVtYWlucyBhIGNhcGFibGUgYW5kIHdpZGVseSB1c2VkIGNhcmQuCkFzCiBhIHByYWN0aWNh
bCBleGFtcGxlLCB0aGlzIEdQVSBpcyBzdGlsbCBjYXBhYmxlIG9mIHJ1bm5pbmcgbW9kZXJuIHRp
dGxlcwogKGUuZy4sIFJlc2lkZW50IEV2aWwgUmVxdWllbSB2aWEgUHJvdG9uKSwgZGVtb25zdHJh
dGluZyB0aGF0IGNvbnRpbnVlZCAKc3RhYmlsaXR5IGFuZCBzdXBwb3J0IGltcHJvdmVtZW50cyBy
ZW1haW4gaGlnaGx5IHJlbGV2YW50LgpHaXZlbgogdGhlIGhpZ2ggY29zdCBvZiBuZXdlciBHUFVz
LCBtYWludGFpbmluZyByZWxpYWJpbGl0eSBhbmQgZml4aW5nIApyZWdyZXNzaW9ucyBvbiB0aGlz
IGNsYXNzIG9mIGhhcmR3YXJlIGlzIHZlcnkgaW1wb3J0YW50IGZvciB1c2Vycy4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrwn5OOIFJlcHJvZHVjdGlvbiBTdGVwcwpC
b290IHN5c3RlbSB3aXRoIEhETUkgY29ubmVjdGVkCkxvZyBpbnRvIGFuIFgxMSBzZXNzaW9uClN1
c3BlbmQgdGhlIHN5c3RlbQpSZXN1bWUKSERNSSBzaWduYWwgaXMgbG9zdCAoIm5vIHNpZ25hbCIp
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K8J+ZjyBDbG9zaW5nCkkg
aG9wZSB0aGlzIGJpc2VjdCByZXN1bHQgaGVscHMgbmFycm93IGRvd24gdGhlIGlzc3VlLgpQbGVh
c2UgbGV0IG1lIGtub3cgaWYgSSBjYW4gYXNzaXN0IGZ1cnRoZXIgd2l0aCB0ZXN0aW5nIG9yIHBy
b3ZpZGUgbG9ncyDigJQgSSB3b3VsZCBiZSBoYXBweSB0byBoZWxwIGluIGFueSB3YXkgcG9zc2li
bGUuClRoYW5rIHlvdSBhZ2FpbiBmb3IgeW91ciBzdXBwb3J0IGFuZCBmb3IgeW91ciB3b3JrIG9u
IEFNRCBHUFUgc3VwcG9ydC4KQmVzdCByZWdhcmRzLApEYW5pbG8gTWFjaGFkbwo=
