Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C9CC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F82210F168;
	Wed, 23 Sep 2026 19:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YB8IDAn6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A26D10E989;
 Wed, 23 Sep 2026 19:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuzUpVCjXl79TMqcCqVu6ElMWf+4fipUH2K1bjR+Sy9Q1Pp8zp5l9wJpnicue4W6KpMod29Uzf8MGZZ6B36vP9fLQMnt+7RWrn31QhoSHhE4Juj9ilBm3FBr8x3eXBkhnsaEXnYJ4ddJqQeqS9wsank4mvLnt8yWlzVkbdt89Bw+fmnmxkySa9Abpx43V62HaDmCub6QS45doNOmzcDEyA/2pW2sQjL2kcLK75QG3qHQ7OfqLWWHPC9wPwUcj2OYtSgHCnEARWNduBeLaRbr8+JK2n0BauhwKQSSZGkuWd3cxcSm2245iNoUJlXIoW8GM1ccpx9nCjTGT7T9MExp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD2x2RRhoGU/REi8c/1e5tchw06lAgc2bC9Seos6vGw=;
 b=GbZNDqmQ7b1YyWYv+b5leoINWxBC3UkOUHDJrtTUtD316s3d/8MhnR8xWt6aFMXriptINuGFjANmWt62WulDUs9yQP2SVBL9MvhKbYl8tGXsE9Ng1VdWGglnwWAIryeGVH80dDreH1m0b+iBJ6bAL4rVewiHBTw4nXvP6PJMOwhPEwR4NH3eqBCkEhSVztikUsybEFpVjFyLLIJv1cH1WJEFW3kE6bjAyD48eEsAN/RXx2/4cyNyhmWvdw0Z2FWRIOI6DIbe+S0DjPb2DA/K75t+flTb7Ktyr/LrDyyi3iQLuGjJUWlMF/px7z7z/Bx+tnCg3e0npwT9PDILYz9B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD2x2RRhoGU/REi8c/1e5tchw06lAgc2bC9Seos6vGw=;
 b=YB8IDAn6NwxIN0P02vWo9zm0xaYa1bIqGNRd4EDRF3YcYAJxil2NKAgooY97oFrSZCNQPlKlpSW4DnisfBIdDbbHl+TTGZqySyH9tdzNa8zot4IEZp+xobwmtZq4R+1+VUAsw5FhWNdV1i43NnjY97UYQDBXgSASIvKYVloItRQ=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by PH8PR12MB6818.namprd12.prod.outlook.com
 (2603:10b6:510:1c9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:45:18 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:45:18 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: teapot <huangalex409@gmail.com>, =?utf-8?B?QXRhIMSwbGhhbiBLw7ZrdMO8cms=?=
 <atailhan2006@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x
 despite AMD VSDB
Thread-Topic: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x
 despite AMD VSDB
Thread-Index: AQHdSzDjbtChPn4430O6nMzRh9SYq7bcVN4AgAA8giA=
Date: Wed, 23 Sep 2026 19:45:18 +0000
Message-ID: <CHXPR12MB999220241D7681B15420FBA721E5822@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260923002718.5915-1-atailhan2006@gmail.com>
 <696580d8-cf2e-47aa-8616-7d930c2f5b82@gmail.com>
In-Reply-To: <696580d8-cf2e-47aa-8616-7d930c2f5b82@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T19:43:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|PH8PR12MB6818:EE_
x-ms-office365-filtering-correlation-id: 45de489a-8788-4665-485b-08df19ab3231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: RG/+BHgvaiwg32E5f4rUVcag2GBp4UNGWHPZJNLSaUPHMLXTbmL29SxeCyEebWJkODfFTByV/5jTF2L5Fqfo/l724EYG0qh7CbDOndSg5hsENZk51iDFLmzXOz26CAxWbamFV9EM9vQQIC+dpxIAsnfCOdwl/T4VpAbvZIbAmp8Iv+MI7lXE1awbqFdT06drxDbPhCVXBqz38opCM+YztzbGOtatnaJSjsmjGvw5jqouT9PQsiWtuK2LCc1X7H+Adc2Wu7bOWs1+vGBPai0Qqu6TSrYO3fMq7M3Y+o3u+LCN7lak5wi+o1d0MgCYD/fp6uLh3Hd3EP3dTrMCtX3BBvlxPDwXEzpjlokjFWX/bdf3WbZAGOKARINZM2vK7rOzJwCph1qSpRXbqiw3qpd2O5OZS4aPF+LIGQ8BecZbQrlGwzRTlEF/D7ESehwtjxRcP5qh7FAAhqeYapi8mI4FkUcXzcT/uLVyoNS8MvTjTZXAgBChcAzby1a41TmmRUZBGqFJ0ijbY6yBL9rBpp/vLTReIiDA7pr/I2NQPWnRlj3ZR71hObBn9kjuCV3598+Pq8mMScjMHz0aLhwrjeViVEAslo781hfVD+UUPOAcBu+x4nTkCHfpvwCQ2HlWoLR7gI782MazxagjqW++5BDipRpNSKGYG4qc/2vyCrh7GuqW4SbQDuZr+ASfjLTKSGuXp+rxRMQkvFIVCTUoEAN3K55PFHAaSi6EM9OkUb4HMU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emRtbDZhNXhqekFXbHgwS21McFZJY2lvY0s0QnBrdHFlR1QzemQ2b1NrS2p0?=
 =?utf-8?B?aGZPV0RLNG1QM0tuMStuS29jSWYwaE9qK0ZSTWQ4Wm1USUw1c1pXNXJEVXJQ?=
 =?utf-8?B?S25CV1orcjVmakRZcTl5dzVpR1FBbGhYdkR3b2l6ODAwNHhXQ3plVVo0eVB0?=
 =?utf-8?B?Q1J6MUIyOU5OTmRqSU5Qd29QMk13OG1qUWhMY2pkZ25zUkc0Z3lqaGxHRmJB?=
 =?utf-8?B?OWVsV24zVE92cnNyWm1kZXR6SGhBSVU4cWpRSWhURnlkSUdNVEtxbEdlRXRQ?=
 =?utf-8?B?M2Z0NkxGVDFvMFhsUnNtOTZlMGx1bzBZN2xhaU0veWtVR0Z3VTI2bnlPZFRP?=
 =?utf-8?B?VFl2T0t1OVdReXFOWTJ0SlBCZkM1cEtuVUlCbzU4djR0b0F2bzg3VGd3dUVP?=
 =?utf-8?B?VmVVTUlhUkZsQlRudFF1dFhrWG5tUzRiWDM4aW1DVFc1SG55OVBQSVczY2xY?=
 =?utf-8?B?U0wvVzc3ZituTG5HNUswZHp3a1B2MTVMbUZjb3lURkZQSmw2eDF6WFEvY1pJ?=
 =?utf-8?B?bHJLODRpVFZNWkhYNjJlR0JKLzdMUXlQT1c0d2FDR1N4dm45bEhFTkpyMWFo?=
 =?utf-8?B?NkxleWR3WXhQQk5BSUlNYXB3QXlQaFVnaGFEV29vSU93MmNQTzdIY0pPM2dC?=
 =?utf-8?B?b3F1RFRTOWZLbFc3MnJ1Y3NnUTVCYlFrOGMrWFBBOE5GKzJ4N3NyLytGR0Fj?=
 =?utf-8?B?RHgxd0V2L2JJL0hpVzV6SUdBM1RNSEFKTlFSUnE1NU52Mk1BVk9qdTN3Z0FB?=
 =?utf-8?B?TnRaZzFYQ2V2SkFpLzBUUUlpbjAxWmlFWmhTVjdjaytYUEMrNzhFaDNIK29U?=
 =?utf-8?B?TDBSN1Y2ZXVSVkJTRjk5N0l3UDFvMFNqeUxTUnBEMWIvSmZGbTVBRFNHcGtN?=
 =?utf-8?B?UERacVRYTlFOUy9jakJOSXczMjNZbTVoUG9oUWMvdTRyUUwrUUZBcURLVzN3?=
 =?utf-8?B?c21qdm5NWjBRS2hqQ29WcndKQnp1K1k4ZWRkUWtiYjd0NWxxVDlBbUJHbjVC?=
 =?utf-8?B?SlJDWk5vVU1wMllSVVo0b2lSdlhTeWszQTY4NEFXUHpJN0NxWW9zUnkrUlZX?=
 =?utf-8?B?NXBHMkd0RU1XNm1adDJwWmQ1VW9XWGc5OHBscGVISEVqN0xSQnB0NHFSZVRu?=
 =?utf-8?B?cnZPOGQrbUZXQ0poZTR5WlNtU1AyQkkvNzM4clRpb3RUcVBUcVJNczJMakU0?=
 =?utf-8?B?Q1dxK2JHOS9aSzdwS25RZDBBSHVzelRseFRzcGdaZkUxUk5VYi9XYjB1V3FF?=
 =?utf-8?B?NXpwc2FRb2JQSHZDNlB5Q1hwQUlDQlUyNzliR3FXOG1oZEJMT01WTXo5UE1v?=
 =?utf-8?B?RzlSN0FsR3M0NjJYc0ZaaHB6L1R6M2FWY3FRbUxXN1Rqb1RPTmE0MTQ0MUpy?=
 =?utf-8?B?dzU1VFRIaG0zb0M3L29Fc3YyQTRZbXlKdnpwOENJK3JUZ2xGWGRZNGkvT3hI?=
 =?utf-8?B?L092OXZTeXZSaE1XTTExK29oUWVwbytzanJSck03NTVyODRSK2JRY3ZjKzI1?=
 =?utf-8?B?SW1ueHVMc3dONEFZbXZXSU1rY1VjdDNCZEVKeFdsRlBObVNBMytqcGpkUDF3?=
 =?utf-8?B?anRFZ2kzVDl4SGFmbEt6MUN6RmVZT2lCYmtyczdPanZINzRMY1pBSWZ6U25a?=
 =?utf-8?B?bzl4UmtrYnpSSERDb2RCVTBuajhiWFBwcTJVckMrTWFEU3hrOUU5V29MbEdw?=
 =?utf-8?B?QkVnM2FNNC9GeDhub0VDUlE5cDRRTE1TQVVTYjhzbndsdUZnOXMrc2JzMUR0?=
 =?utf-8?B?aTdia2UvQnZjMXJqcDhxbFh4TCtVeXd1eEJpZkppWUl1eGNieDd0SWJreWJ1?=
 =?utf-8?B?dk1oK3pDWG50eEZ6cG1BMDRET1pYa3hvcEh3SnJOYjNsVWtKaUxVYTFMeEli?=
 =?utf-8?B?MmY0b1hoQnFnYUVzVlp2dUNkK1RITFQxR1FraUxYMzRUeUxlOVVCVkJUVGRj?=
 =?utf-8?B?Vko1cHJLT2pHQnNNcWVRc2tibWN4cklKWmFiUWRDQUxlZllZL2JqZmRnSlpU?=
 =?utf-8?B?aXdwcmtleDl3WHJXRmFxRy94VGViclNPVEZNbmtLRnVXTnNnL0Jub0J3eTRy?=
 =?utf-8?B?NzNvMkd0eVRPYURNb1Y1NERscmEyc2hScVBqajRoMTdWVEN1VGJ4bTkwMDlv?=
 =?utf-8?B?U3VodzZBak01dk00WklpaHBXNkpLaEtLaXBLa2Q5YWFwREQzU2UyU3lObWJm?=
 =?utf-8?B?SThCMHhPY1hNWk5BZlY0RzBwTU4vRzliYmtmWDJYRHRtTFZWalFpTy91N2VI?=
 =?utf-8?B?UGxDVVpoT29SSHpPcFdhRkt4ckFGZGZ0dm42cVN4Tnd6VzUzU0dvd25lNGtN?=
 =?utf-8?Q?8g3qqfwfEV5l8lYrqC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45de489a-8788-4665-485b-08df19ab3231
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 19:45:18.1982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWt7urZJ+fVnG/sHqc+S0aH6UdKOS1eVZM1GXex1norfiL9ZuB9PHkM85ORLkCUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YN
Cj4gdGVhcG90DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIzLCAyMDI2IDEyOjA3DQo+
IFRvOiBBdGEgxLBsaGFuIEvDtmt0w7xyayA8YXRhaWxoYW4yMDA2QGdtYWlsLmNvbT47IGFtZC0N
Cj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogV2VudGxhbmQsIEhhcnJ5IDxIYXJy
eS5XZW50bGFuZEBhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pDQo+IDxTdW5wZW5nLkxpQGFt
ZC5jb20+OyBSb2RyaWdvIFNpcXVlaXJhIDxzaXF1ZWlyYUBpZ2FsaWEuY29tPjsgRGV1Y2hlciwN
Cj4gQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERhdmlkIEFpcmxpZSA8YWlybGllZEBn
bWFpbC5jb20+OyBTaW1vbmENCj4gVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+OyBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW0RSTV0gYW1kZ3B1OiBIRE1JIEZyZWVTeW5jIG5vdCBleHBvc2VkIG9u
IFNhbXN1bmcNCj4gUzIyQzMxeCBkZXNwaXRlIEFNRCBWU0RCDQo+DQo+IFtTb21lIHBlb3BsZSB3
aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+IGh1
YW5nYWxleDQwOUBnbWFpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiBo
dHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBPbiAy
MDI2LTA5LTIyIDIwOjI3LCBBdGEgxLBsaGFuIEvDtmt0w7xyayB3cm90ZToNCj4gPiBIaSwNCj4g
Pg0KPiA+IEkgYW0gaW52ZXN0aWdhdGluZyBhbiBpc3N1ZSB3aGVyZSBIRE1JIEZyZWVTeW5jIGlz
IG5vdCBleHBvc2VkIGZvciBhDQo+ID4gU2Ftc3VuZyBTMjJDMzF4IG1vbml0b3Igb24gYW4gQU1E
IFBpY2Fzc28vUmF2ZW4gMiBHUFUsIGFsdGhvdWdoIHRoZQ0KPiA+IG1vbml0b3IgYWR2ZXJ0aXNl
cyBhbiBBTUQgRnJlZVN5bmMgcmFuZ2UgaW4gaXRzIEVESUQgYW5kIFZSUiB3b3Jrcw0KPiA+IHVu
ZGVyIFdpbmRvd3MuDQo+ID4NCj4gPiBIYXJkd2FyZS9zb2Z0d2FyZToNCj4gPg0KPiA+ICogR1BV
OiAwMzowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXIgWzAzMDBdOg0KPiA+IEFkdmFuY2Vk
IE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIFBpY2Fzc28vUmF2ZW4gMiBbUmFkZW9uIFZl
Z2ENCj4gPiBTZXJpZXMgLyBSYWRlb24gVmVnYSBNb2JpbGUgU2VyaWVzXSBbMTAwMjoxNWQ4XSAo
cmV2IGMyKQ0KPiA+ICogS2VybmVsOiA3LjIuNS0yMDAuZmM0NA0KPiA+ICogQ29tcG9zaXRvcjog
U3dheSAoV2F5bGFuZCkNCj4gPiAqIE1vbml0b3I6IFNhbXN1bmcgUzIyQzMxeA0KPiA+ICogQ29u
bmVjdG9yOiBIRE1JLUEtMQ0KPiA+ICogRURJRCBzZXJpYWw6IEg5RFgxMDAyMTANCj4gPiAqIEtl
cm5lbCBjb21tYW5kIGxpbmUgaW5jbHVkZXM6IGFtZGdwdS5mcmVlc3luY192aWRlbz0xDQo+ID4N
Cj4gPiBPYnNlcnZlZDoNCj4gPg0KPiA+ICogc3dheW1zZyAtdCBnZXRfb3V0cHV0cyByZXBvcnRz
ICJBZGFwdGl2ZSBzeW5jOiBkaXNhYmxlZCIgZm9yIEhETUktQS0xLg0KPiA+ICogQWRhcHRpdmUg
c3luYyByZW1haW5zIGRpc2FibGVkIGF0IGJvdGggMTkyMHgxMDgwQDYwIEh6IGFuZA0KPiAxOTIw
eDEwODBANzUgSHouDQo+ID4gKiBUaGUgc2FtZSBtb25pdG9yIGV4cG9zZXMgYW5kIGVuYWJsZXMg
RnJlZVN5bmMgdW5kZXIgV2luZG93cy4NCj4gPg0KPiA+IFRoZSBFRElEIGNvbnRhaW5zIHRoZSBm
b2xsb3dpbmcgQU1EIFZlbmRvci1TcGVjaWZpYyBEYXRhIEJsb2NrOg0KPiA+DQo+ID4gVmVuZG9y
LVNwZWNpZmljIERhdGEgQmxvY2sgKEFNRCksIE9VSSAwMC0wMC0xQToNCj4gPiAgICAgIFZlcnNp
b246IDENCj4gPiAgICAgIEZlYXR1cmUgQ2FwczogMHgwMQ0KPiA+ICAgICAgTWluaW11bSBSZWZy
ZXNoIFJhdGU6IDQ4IEh6DQo+ID4gICAgICBNYXhpbXVtIFJlZnJlc2ggUmF0ZTogNzUgSHoNCj4g
PiAgICAgIEZsYWdzIDEueDogMHgwMD4NCj4gPiBUaGUgSERNSSBWU0RCIHRoZXJlZm9yZSBhcHBl
YXJzIHRvIGFkdmVydGlzZSBhIDQ4LTc1IEh6IEZyZWVTeW5jIHJhbmdlLg0KPiA+DQo+ID4gVGhl
cmUgaXMgYWxzbyB0aGlzIG1lc3NhZ2UgaW4gZG1lc2c6DQo+ID4NCj4gPiBhbWRncHUgMDAwMDow
MzowMC4wOiBbZHJtXSBGYWlsZWQgdG8gc2V0dXAgdmVuZG9yIGluZm9mcmFtZSBvbg0KPiA+IGNv
bm5lY3RvciBIRE1JLUEtMTogLTIyDQo+ID4NCj4gPiBJIGJlbGlldmUgdGhpcyBpcyB0aGUgLUVJ
TlZBTCBwYXRoIGZyb20NCj4gPiBkcm1faGRtaV92ZW5kb3JfaW5mb2ZyYW1lX2Zyb21fZGlzcGxh
eV9tb2RlKCkgZm9yIHRoaXMgdGltaW5nIGFuZCBpcw0KPiA+IHByb2JhYmx5IHVucmVsYXRlZCB0
byB0aGUgRnJlZVN5bmMgaXNzdWUuDQo+ID4NCj4gPiBUaGUgcGFydCBJIGFtIGN1cnJlbnRseSBp
bnZlc3RpZ2F0aW5nIGlzDQo+IGFtZGdwdV9kbV91cGRhdGVfZnJlZXN5bmNfY2FwcygpLg0KPiA+
DQo+ID4gRm9yIEhETUksIHRoZSBkcml2ZXIgY2FsbHMgcGFyc2VfaGRtaV9hbWRfdnNkYigpLCB3
aGljaCBvbiB0aGlzIERDTg0KPiA+IGNvbmZpZ3VyYXRpb24gZ29lcyB0aHJvdWdoIHRoZSBETVVC
IHBhdGg6DQo+ID4NCj4gPiBwYXJzZV9oZG1pX2FtZF92c2RiKCkNCj4gPiAgICAtPiBwYXJzZV9l
ZGlkX2NlYSgpDQo+ID4gICAgICAgLT4gcGFyc2VfZWRpZF9jZWFfZG11YigpDQo+ID4gICAgICAg
ICAgLT4gZG1fZWRpZF9wYXJzZXJfc2VuZF9jZWEoKQ0KPiA+ICAgICAgICAgICAgIC0+IG91dHB1
dC0+YW1kX3ZzZGIuZnJlZXN5bmNfc3VwcG9ydGVkDQo+ID4NCj4gPiBJZiB0aGUgRE1VQiBwYXJz
ZXIgcmV0dXJucyBmcmVlc3luY19zdXBwb3J0ZWQgPT0gMCwgdGhlIGRyaXZlciBkb2VzDQo+ID4g
bm90IGV4cG9zZSB0aGUgY29ubmVjdG9yIGFzIFZSUiBjYXBhYmxlLg0KPiA+DQo+ID4gV2hhdCBt
YWtlcyB0aGlzIGludGVyZXN0aW5nIGlzIHRoYXQgdGhlIERSTSBFRElEIHBhcnNlciBhbHNvIGNv
bnRhaW5zDQo+ID4gdGhlIGNvcnJlc3BvbmRpbmcgQU1EIFZTREIgaW5mb3JtYXRpb24gaW4NCj4g
PiBjb25uZWN0b3ItPmRpc3BsYXlfaW5mby5hbWRfdnNkYiwgd2hpbGUgdGhlIERNVUIgcmVzdWx0
DQo+ID4gZG9lcyBub3QgcmVzdWx0IGluIEZyZWVTeW5jIGJlaW5nIGV4cG9zZWQuDQo+ID4NCj4g
PiBJIGFtIHdvbmRlcmluZyBhYm91dCB0aGUgZm9sbG93aW5nOg0KPiA+DQo+ID4gMS4gSXMgdGhl
IEFNRCBWU0RCIGxheW91dCBhYm92ZSBleHBlY3RlZCB0byBiZSBhY2NlcHRlZCBieSB0aGUgRE1V
Qg0KPiA+IEVESUQgcGFyc2VyLCBwYXJ0aWN1bGFybHkgd2l0aCBGZWF0dXJlIENhcHMgMHgwMSwg
RmxhZ3MgMS54ID09IDB4MDAsDQo+ID4gYW5kIG5vIE1DQ1MgVkNQIGNvZGUgYnl0ZT8NCj4gQUZB
SUsgdGhlIGRyaXZlciB3aWxsIGNvbnNpZGVyIEhETUkgRnJlZVN5bmMgdW5hdmFpbGFibGUgaWYg
TUNDUyBWQ1AgY29kZSBpcw0KPiAweDAuIEhETUkgRnJlZVN5bmMgbmVlZHMgdGhpcyBWQ1AgY29k
ZS4+DQo+ID4gMi4gSWYgdGhlIERNVUIgcGFyc2VyIHJlamVjdHMgdGhpcyBmb3JtIG9mIEFNRCBW
U0RCLCBzaG91bGQgYW1kZ3B1X2RtDQo+ID4gZmFsbCBiYWNrIHRvIHRoZSBzb2Z0d2FyZS1wYXJz
ZWQgY29ubmVjdG9yLT5kaXNwbGF5X2luZm8uYW1kX3ZzZGIgd2hlbg0KPiA+IGRldGVybWluaW5n
IEZyZWVTeW5jIGNhcGFiaWxpdHk/DQo+IFRoZSBhbWRfdnNkYiBzdHJ1Y3QgaXMgY3VycmVudGx5
IG9ubHkgZm9yIHRoZSBWMisgbHVtaW5vc2l0eSBmaWVsZHMsIGFuZCBkb24ndA0KPiBhZmZlY3Qg
RnJlZVN5bmMgZGV0ZWN0aW9uLiBJIGhhZCBhZGRlZCBGcmVlU3luYyBmaWVsZHMgc3VwcG9ydCBh
bmQgdGhvc2UNCj4gY2hhbmdlcyBhcmUgaW4gZHJtLW5leHQsIGJ1dCBoYXZlbid0IG1hZGUgaXQg
dXAgdG8gdGhlIFRvcnZhbGRzIHRyZWUgeWV0Lg0KPiA+DQo+ID4gSSBoYXZlIGEgd29ya2luZyBr
ZXJuZWwgdHJlZSBhbmQgY2FuIHJ1biBkaWFnbm9zdGljIHRlc3RzIG9yIHRlc3QgYQ0KPiA+IHNt
YWxsIHBhdGNoLiBJIGNhbiBhbHNvIHByb3ZpZGUgZHJtLmRlYnVnIG91dHB1dCBvciBETVVCLXJl
bGF0ZWQNCj4gPiB0cmFjZXMgaWYgdXNlZnVsLg0KPiBJIHRoaW5rIHRoaXMgbWlnaHQgYmUgYSBj
YXNlIHdoZXJlIHRoZSBXaW5kb3dzIEZyZWVTeW5jIGRldGVjdGlvbiBoYXMNCj4gZGl2ZXJnZWQg
ZnJvbSB0aGUgTGludXggZGV0ZWN0aW9uLCBtYXliZSBIYXJyeSB3b3VsZCBiZSBhYmxlIHRvIHBy
b3ZpZGUNCj4gbW9yZSBpbnNpZ2h0IG9uIHRoaXM/DQo+DQo+IFRoZSBtb25pdG9yJ3MgRURJRCB3
b3VsZCBwcm9iYWJseSBiZSB1c2VmdWwgdG9vLCBJJ20gbm90IHF1aXRlIHN1cmUgaG93IHRvDQo+
IG1ha2Ugc2Vuc2Ugb2YgdGhlIGVkaWQtZGVjb2RlIG91dHB1dCBzaW5jZSB0aGVyZSdzIGEgZmV3
IGd1ZXNzZWQgZmllbGRzIGluDQo+IHRoZSBBTUQgVlNEQiBibG9jayBhbmQgaGFzbid0IGJlZW4g
dXBkYXRlZCBzaW5jZSAyMDI0Lj4NCj4gPiBUaGFua3MsDQo+ID4gQXRhIMSwbGhhbiBLw7ZrdMO8
cmsNCj4NCj4gQmVzdCwNCj4gQWxleA0KDQpZZXMsIHdlIGFyZSB3b3JraW5nIHRvIHN3aXRjaCBw
YXJzaW5nIEFNRCBWU0RCIGZyb20gZG11YiB0byBwdWJsaWMgZHJtLiBXaWxsIGdldCBpdCByZWFk
eSBvbmNlIGludGVybmFsIHZhbGlkYXRpb24gaXMgZG9uZS4NCg0K
