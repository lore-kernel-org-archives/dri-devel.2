Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDF9CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C97710E2B7;
	Mon, 15 Jun 2026 09:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XWhmCwYY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9C810E2B7;
 Mon, 15 Jun 2026 09:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfUlCcjy21ROfM17uATWetRHs9dvJ/9VYZxURzNeoNtuHKRjUZKaScEGIif1WNXHX28dG0sv3JoqIqJMmIZYphIIeOJmThNLUDZ/vzk5NTl/4wqr75c2QzRlGjUicx2kGQX9zxrDSAR3GOcPKdZXoayPzoVy+A0O4GRGKZGf7uWz536ZhzG10ZkF9NoNaSyEy1OuBGJQX3v4nfF0/xwXbWJk0LDTCQNBqqBkfsyDUVyzd3PUY9SzfzMEMBDaCmD1Mh3Ai8r2bdXA/W5QbvBm+0l4g2S2YK2S61THMtknZQp8E+Ljgbj9gnAksMnXyBWFa61NAZBsthFEk0eK77ZN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S1encNOOGOBsrlJdWjw5xYkSYqtChAgZaY30GDv3Wc=;
 b=OQtay8EShmcNKq7glNzfVa0RAovltHS8TMIR11pi3IRlMBdJfE/QV5wrb9u7khwxmkNB0pCM82ODetI7Vk95DTwu75fXD33wgGKD8Ne26o6ts51YeV402iCxBriBYAE8FqgYRazXwDUee7Wl9JRDm73CRrkbCxHaM59jZWo86ZPxuU2r5ouCqnI9HQPxVUj6t4OWkdCZ41QLQINXjDz4mRaWHBgC7KbGLyObMoE6fPzZtT2uenr0lbha4tuQMFLYKovSFOXOox3by4Voxde1CwWeRe6oOg30yDQKSEouVC8CHO33fDRBJmSw7UvC1uU9UC2JjXd1r0fe1knw6oQg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S1encNOOGOBsrlJdWjw5xYkSYqtChAgZaY30GDv3Wc=;
 b=XWhmCwYYJvz4KnIfNjnosnq9/VwWg0ljiEh3A4wxQP/POgh6pZLCDZOfOB3pZCWo+pFElELqEs9CMWc6U9v6bCOHikL9gEfTR2xgkaceEoP+sTH+fOHOViq8Dw9rnz0UB7Nk8bKT1x0VFPhIHLxfMAccTyVnAGBZHBHTKHl0REk=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:06:55 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:06:55 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Michal Mrozek <michal.mrozek@intel.com>, 
 John Falkowski <john.falkowski@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, LMKL
 <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
Thread-Topic: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
Thread-Index: AQHc/J6u70cfskUydkWfpmO1HIx8BbY/UxrA
Date: Mon, 15 Jun 2026 09:06:54 +0000
Message-ID: <IA0PR12MB82088093D39A6CFECEF6874090E62@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
 <3a5ef552-bd49-4a61-97cb-8af395a84de1@amd.com>
In-Reply-To: <3a5ef552-bd49-4a61-97cb-8af395a84de1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-15T09:05:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH7PR12MB6740:EE_
x-ms-office365-filtering-correlation-id: 40251abe-87fa-45ff-9453-08decabd7275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: EV0V2wdG9UQzt6yTuTNHFVL7g0Ee7zhaCHHnfKGExXrvkfDu1LuYXB/Ie+51maEz7JhBeCQvl6rAoEYzOiQlCYpQ7BZP0fiMVNGR4NVis0zx5ldKSDR5zkgnhY4H4p4GjzRBMx5GeZ3+aSVO6jmfcbW0woGkvofSu16oJdagWqXVE4Yrizawl9rsvMvOQh3RJ3gVFnrdt8hcauqOjf7z4QFQ0ruSFPb0WJ7wNFkAWe8EvmnY7a9q7qE1JMaWucF7VMkdimNr6KZUcMHeyrMI02b74PXeTN038nNXQnM0ZVSdptta7hAnwlAcUaSjhxDRFobbLqVfFYj4neupTebQUKN1sSnJYmL6uy88jrbPtdO3/Ii4f7jQaeM6sa5CHb7+NE7g6fVY9/fQS48j7IqQD/w1QPBoHTxsl0chIDDwMeLW1fYf/vNGw9OSdx3fKk2J3tKoKeQUk1yd8EjpbLvtd6380e1NAw9ydDWpQSF6NZ9f7etTkkB0AI8bp7FM6BMdWAl1Ap/5zIFtuMy1dG55opBt0SGTMpi4rCq33zwrgIOOPVf7QYp2O1W3umWaeLBd1Cjj03+Wi53tL/nNrATJAV1Pqj9qnCslK+3bMfedqsJH+ksu7fKEPOZEajJuEd1ymDYL+gDVZsU7hFLCtok1zoUxjKCEMjnAxk2UKDcywoCKyVkhkD8B8Jn7juvf8moU2gFAmBEiKT2u8BwTxUMnNtxV++V2aaFfFk1BJA83F9Hsv6dz+3vttajgAjcpnY+m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGx4eFZiZnkweHBVOC8veGtYcU0wTllSY0hxUWU3bVZ3ZnI2RE4zWk5TcVFU?=
 =?utf-8?B?UVFiWXg1QVE1S2dySUhKZDl0OTZldFdOQXFaSjZnK2lDeUx3TEhTWGhrOEdV?=
 =?utf-8?B?R08vMHNUdjArTTE5ZXpNcmgySVVlNXpmSG0rYUJFbUFoWmtxMGRKaFZNQmR3?=
 =?utf-8?B?Q2Z5bkdzQkx2clV2T3hYYXhWbDVOb1R6K1YyWk51OVluYllHQ0hqUG5jV1Yy?=
 =?utf-8?B?cHVsSVhDckVHQ0xEb01XNmQwRUw4SWcwemhsd0RHa3V2ZHBGNkovVkZnbmsz?=
 =?utf-8?B?dnFiWXA2Zm9mK2JtbStDWGp3UUhmVlpteXZOLzh2a0pOUnpRSGFzTC84Nklu?=
 =?utf-8?B?NmVVUXNXUDIyVzB6MkRyUHFjUkNwTVAwdW16M1VSZjZuYUNobWgyQTRwTjNG?=
 =?utf-8?B?VTNQaXhtOWxBSWV1Skp0QTVCR3Z3aExrYUlKT0VOYWp1QUxhVVIwMHdvbWt2?=
 =?utf-8?B?VlRIclhrQ2NGcEYzRUtra1ZUai9hQTQ1ZHVOTXQrVjBRZGp0VDl0em9TSGRr?=
 =?utf-8?B?RzVDMFB2NGlkYkd0b3dSNjQ1UFRLUzVXd0VxMUxGaDQ4aHdFeGszd1dvekRG?=
 =?utf-8?B?K0pGUFVjVUNuNkZoS0pIbldwQnk3d1Z5SUFUcG8yUUVyR2hnRHBjYU5YZHhu?=
 =?utf-8?B?N0pCNzFmcnFkWVh2UnVrVnFKK1JxTm9SMEFVYzBPMlpUbTRIZDZaMld6MEp3?=
 =?utf-8?B?YjRWRWI4VmN2Z2FCRkdHUDZobzl3WDdpclo5T2NNaU0zMC9jVnphTzNvMlFp?=
 =?utf-8?B?TVhkaGxFYXU2cDhKNlh6V0tKK1gxdFdRWDVwaDQ5aitQdFcrQVc1RFpCQWdY?=
 =?utf-8?B?MGlvVUxBQTVsNWhvNEMvTkxYLzhqWlNpYWpKaXBFUHdzRXFHL0dGRzF5eXJy?=
 =?utf-8?B?Nk9PWHZTdktwTXl3YmxlVVJ2MThFRGpFREtUUVVGdnR5TGwyWEFmajJ6SmZC?=
 =?utf-8?B?Q0x5dVlpTzRTSVY4UVZwUjZub1ltb0JiK0JwSVF0YjlYN25yd29oZVliblJZ?=
 =?utf-8?B?TUY3MnVXMkRIYTFWUFJMUzZSTEVFa1ppdHNPYjVPeWx2VU5uN1l5Mjg1aytR?=
 =?utf-8?B?RTZGckV4b1h0dUcraURFNDRVa2RVV2QrN20vYnREN29vZ2Q1aU01eFdkdVFT?=
 =?utf-8?B?amsxOHgybE1FekNvUTlhTnlkTkEzVnhRMXhJOFBDdVR6SEJzV2UvUDNJSzls?=
 =?utf-8?B?VHJISXA5MlQxcm9UeVYxZWY3ZGFNa3ZPKzEwbmFHbWZ2bDRBbmVPVjVzS2lP?=
 =?utf-8?B?ZjhwZlNmODhTblVjWVZwNm5OTFd6a2RWTGM0NmltRFdmbEJucFJlTWp0L0Rt?=
 =?utf-8?B?K2FaQlpWR1JibFhMZEF4Y2FyL3I2NnBvNVp4amRZQnRWOGJaK3lta0ZQZ3NI?=
 =?utf-8?B?WUxhOTYwVDdTeXNzVTBta05JOS91K3Q4VUJSWGVGTjFGMmZLVVd3SUQ5Tklv?=
 =?utf-8?B?UDhaYlgwUjN5RFdoNFJTRXdMZjNlWlJESHdrbUhBdVhXZk9PVGhNYVY4eUZI?=
 =?utf-8?B?Y0dIbStiYkxNM3ZMRkhWcE1qMUN6dU5HOFNFWEY0bDJxeWhaLzFEbS82ZFBv?=
 =?utf-8?B?eEcvME1MbzZ1R3lmVldURlMxanBteng0QldHR0pJVXNtbm1GRkpNUlJGOTd1?=
 =?utf-8?B?eGd0aTF2UnBXRjlwNVhZWTlvQ1lkenJLS0J1d0NrVGV4b0p2dmJ6V3U0VjhW?=
 =?utf-8?B?ZzhYNk04d1k4UytYYmkwbDJRUGkrZjlmZkk5OXdndHdwd0ZWRGF0V253SUZJ?=
 =?utf-8?B?UjBndDI0cGZVMnRBdVI4T3o0TU5SSmtVRUhSeXV4UEVqRGU1ek9GMXdHMGRU?=
 =?utf-8?B?VkN5bEVpbU84N3A2T3VoQ0xXdm13L0I1QVJZNzcrNmIvejZNeUlWZGlLdWxm?=
 =?utf-8?B?K0djVDN4WW5pL2Jva2UvT2pLNzBJMmtTQVV2TmlnL1pzWkVta0JEYi8zNUFM?=
 =?utf-8?B?U2lSbUZPV3FSOEc2UlJ6bS9EbmR3S2tkcndNclBNY3ZHSDhpWW5FU25kZ3Z4?=
 =?utf-8?B?K1JLVnpHUzVZVzg1aXgvVnl2UzdnRjJzbThkZllTSW5WUHVxR1BxL25sVUE5?=
 =?utf-8?B?bzZXVlUyTFIwdTl2NzFuc0t3M0tpdUdQQTVWcTJvLzVNWDY0RE50UXd1bXVx?=
 =?utf-8?B?REtpdnB2dWRnSjQxYzlSZmNVbkJuU1JTWklnQzJkTUFObXNzNjh4Q2xoRm5x?=
 =?utf-8?B?RVo4NFBHdlZnUGVxczhjcktHWmRDV2swZERDODlFYVRNRXl1cGZ0cG5ScUNh?=
 =?utf-8?B?aHl3aFBuMHVsUkpvajQxUTlKV09DVzQ1MjFWaGNMMkZxQ1JhcVp5OFFwNUlY?=
 =?utf-8?Q?XPx7jIonkmZUpeswcz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40251abe-87fa-45ff-9453-08decabd7275
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 09:06:55.1005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32U/7ncOOkJi+oY3HoqAAJVvHjtZfbcA197uZBwbRkB0/+kyI+eWQsffkZwB1TP53MdYyYpvaxnZcChihiVMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXks
IEp1bmUgMTUsIDIwMjYgMTo0MiBQTQ0KPiBUbzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5o
ZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgaW50ZWwtDQo+IHhlQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQu
Y29tPg0KPiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+OyBNYWFy
dGVuIExhbmtob3JzdA0KPiA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWlj
aGFsIE1yb3playA8bWljaGFsLm1yb3pla0BpbnRlbC5jb20+Ow0KPiBKb2huIEZhbGtvd3NraSA8
am9obi5mYWxrb3dza2lAaW50ZWwuY29tPjsgUm9kcmlnbyBWaXZpDQo+IDxyb2RyaWdvLnZpdmlA
aW50ZWwuY29tPjsgTGFodGluZW4gSm9vbmFzIDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwu
Y29tPjsNCj4gRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT47IENocmlzdGlhbiBC
cmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+Ow0KPiBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9y
Zz47IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+OyBEYXZlDQo+IEFpcmxpZSA8
YWlybGllZEBnbWFpbC5jb20+OyBTaW1vbmEgVmV0dGVyIDxzaW1vbmEudmV0dGVyQGZmd2xsLmNo
PjsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExNS0wgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvNF0gWGUgZHJp
dmVyIGFzeW5jaHJvbm91cyBub3RpZmljYXRpb24gbWVjaGFuaXNtDQo+DQo+IEhpIFRob21hcywg
U3JpbmksDQo+DQo+IFNyaW5pIGlzIGFscmVhZHkgd29ya2luZyBxdWl0ZSBhIHdoaWxlIG9uIHNv
bWV0aGluZyBzaW1pbGFyIGZvciBhbWRncHUuIFdlIHVzZQ0KPiBldmVudGZkIGFuZCBhIGRldmlj
ZSBzcGVjaWZpYyBJT0NUTCBpbnN0ZWFkIG9mIHRoZSB3YXRjaF9xdWV1ZSBwcm9wb3NlZCBoZXJl
Lg0KPg0KPiBTcmluaSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpcywgaXQgaXMgYmFzaWNhbGx5
IHRoZSBlcXVpdmFsZW50IG9mIG91ciBldmVudCBub3RpZmljYXRpb24NCj4gYXBwcm9hY2ggZm9y
IEtGRC9LR0QgdW5pZmljYXRpb24uIE1heWJlIHdlIGNvdWxkIGxlYXJuIGZyb20gdGhhdCBhbmQv
b3IgaGF2ZQ0KPiBzb21ldGhpbmcgY29tbW9uIGZvciBib3RoIGRyaXZlcnMuDQoNCkhpIENocmlz
dGlhbiwgSGkgVGhvbWFzLA0KDQpUaGFuayB5b3UsIENocmlzdGlhbiwgZm9yIHBvaW50aW5nIHRo
aXMgb3V0Lg0KDQpJIHRvb2sgYSBsb29rIGF0IHRoZSBYZSBzZXJpZXMgYW5kIGZvdW5kIGl0IHZl
cnkgaW50ZXJlc3RpbmcgdG8gY29tcGFyZSBpdCB3aXRoIHRoZSBvbmdvaW5nIEFNREdQVSBFVkVO
VEZEIHdvcmsuDQoNCkZyb20gbXkgdW5kZXJzdGFuZGluZywgdGhlIFhlIGFwcHJvYWNoIHVzZXMg
d2F0Y2hfcXVldWUgZm9yIGJvdGggbm90aWZpY2F0aW9uIGFuZCBwYXlsb2FkIGRlbGl2ZXJ5LCB3
aGVyZWFzIHRoZSBjdXJyZW50IEFNREdQVSBhcHByb2FjaCB1c2VzIEVWRU5URkQgYXMgYSBsaWdo
dHdlaWdodCB3YWtlLXVwIG1lY2hhbmlzbSwgd2l0aCBXQUlUX0VWRU5UIHByb3ZpZGluZyB0aGUg
ZGV0YWlscyB3aGVuIHVzZXJzcGFjZSBuZWVkcyB0aGVtLg0KDQpPbmUgdGhpbmcgSSBub3RpY2Vk
IGlzIHRoYXQgdGhlIGV2ZW50IGNoYXJhY3RlcmlzdGljcyBzZWVtIHNvbWV3aGF0IGRpZmZlcmVu
dC4gWGUgYXBwZWFycyB0byBiZSBkZWFsaW5nIHdpdGggcmVsYXRpdmVseSBpbmZyZXF1ZW50IFZN
LW9yaWVudGVkIGV2ZW50cyAoZm9yIGV4YW1wbGUsIE9PTSBvciBWTSByZXN0YXJ0KSwgd2hpbGUg
QU1ER1BVIGFsc28gaGFzIHF1ZXVlLW9yaWVudGVkIGV2ZW50cyBzdWNoIGFzIFVTRVJRX0VPUCB0
aGF0IG1heSBvY2N1ciBtdWNoIG1vcmUgZnJlcXVlbnRseS4NCg0KSSBtYXkgYmUgbWlzc2luZyBz
b21lIG9mIHRoZSBiaWdnZXIgcGljdHVyZSBoZXJlLCBzbyBJIHdhbnRlZCB0byBhc2sgZm9yIHlv
dXIgZ3VpZGFuY2Ugb24gdGhlIGludGVuZGVkIGRpcmVjdGlvbi4NCg0KRG8geW91IHNlZSB3YXRj
aF9xdWV1ZSBhcyBhIHBvc3NpYmxlIGxvbmctdGVybSBjb21tb24gRFJNIG5vdGlmaWNhdGlvbiBm
cmFtZXdvcmsgdGhhdCBBTURHUFUgc2hvdWxkIGV2ZW50dWFsbHkgbW92ZSB0b3dhcmRzLCBvciBp
cyB0aGUgaW50ZW50aW9uIG1haW5seSB0byBjb21wYXJlIHRoZSBhcHByb2FjaGVzIGFuZCBhbGxv
dyBlYWNoIGRyaXZlciB0byBjaG9vc2Ugd2hhdCBiZXN0IGZpdHMgaXRzIGV2ZW50IG1vZGVsPw0K
DQpJIHdhcyBhbHNvIHdvbmRlcmluZyB3aGV0aGVyIGl0IG1ha2VzIHNlbnNlIHRvIHRyZWF0IHRo
ZXNlIGV2ZW50IGNsYXNzZXMgZGlmZmVyZW50bHk6IGxpZ2h0d2VpZ2h0IHF1ZXVlIHdha2UtdXAg
ZXZlbnRzIGNvbnRpbnVpbmcgdG8gdXNlIEVWRU5URkQgKyBXQUlUX0VWRU5ULCB3aGlsZSByaWNo
ZXIsIGxvd2VyLWZyZXF1ZW5jeSBkZXZpY2UtbGV2ZWwgZXZlbnRzIGNvdWxkIHBvdGVudGlhbGx5
IHVzZSBzdHJ1Y3R1cmVkIHdhdGNoX3F1ZXVlIG5vdGlmaWNhdGlvbnMuDQoNCkkgd291bGQgcmVh
bGx5IGFwcHJlY2lhdGUgeW91ciB0aG91Z2h0cyBiZWZvcmUgd2UgcHJvY2VlZCBmdXJ0aGVyLg0K
DQpUaGFuayB5b3UgYWdhaW4gZm9yIHJhaXNpbmcgdGhpcyBhbmQgZm9yIHNoYXJpbmcgdGhlIFhl
IHdvcmsuDQoNClRoYW5rcywNClNyaW5pDQoNCj4NCj4gVGhhbmtzLA0KPiBDaHJpc3RpYW4uDQo=
