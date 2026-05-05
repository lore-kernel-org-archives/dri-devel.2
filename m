Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97930FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F0D10E492;
	Tue,  5 May 2026 22:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZlicgoE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4736810E492
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atMbUza0DqUXshXLHsjen5YYubobkdOns8f5F0A16bqAq4lNUxs7hSp3NtlAMGc0s3VpP4PNGh0kOTN3BpRfmXumaqCNtycNt1pOEnZO9fwUA1cQlgGLM4U0zW8cAMiHgaQ0XPP6nXDG0UAzIyNEGt5/fPepfeU3cZ/YJtqrWKpNe2fOm+mZ7G2QltXynEMQHxiWnMgHsu/c/ALAnMjAfdmS/4N65jWti/Thpfpx3RYiLxI/4rQIR2BcixOVeNnWoZ7Cer0hs6wz/BSvvtWZlSqS27g/wbl4UlZO3JpQWjM9fZTBmf+G3x+cZ4PAcsqQcPXnzW5BnfDSoOwUgO/uVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1QxNPBc0DwPgRnPcvgPgrUqM63NRZAFteqG6rseEOE=;
 b=WdlxiEFhVzflN25AEct2fLotvPiKYlTkOVt1ivOciZSmnlpQB+GCdbqxPxJF4Z5ZdVapYuN4Ymki3qHTpXAm5tS8qIod/IZqfH2lho8RPLMdYvK1eIpXI9sTUUSsoif74iSNZkKRjx0sarP7IMS5xaJf7bRTTHtAlfxa9VGu/Sfk38868WuTe5cjwZZnEtvO/ro41ih42iauuy4lUnJITESkzdGOw8S0q5g2De//nFBkAIIAXYz+JYvsJplDbXMHtWya63uPpvvu3R8GEm747fNIFMbzKSAEvoJQijmoD9IgNYts5DuJ+tgEsAOohXYzcSPT/qcHrhLZ0dPF1lUc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1QxNPBc0DwPgRnPcvgPgrUqM63NRZAFteqG6rseEOE=;
 b=PZlicgoERCSBYkuWfgXTTpaVcD1mOMegYQhQ3IKPNCG+dfxLBo+CQ+OxYogbD0Xf5Rtyn4bYjgjoMkIVDNT4qLtQMLDY4k4E2tAS204950TPemmVeRDcfuCTiLks2GQXWJVHibwUMoGOV9jo3h1P7ALKHQWhCSvbcdftUx5lPWv6B9nl4muy8HG462eu58N0KGIe/hZjIWMoEWnd2dXFaJM9sGjLFkFfv08me7EgDSc9zKH0h2PkWMiWWKg502yJY6HKOBAJHCREDq+aHOdWqPMKJ6GfcjCO37iPo/AcpxbsACJ7+wcK4+POMpz/ZxSJ0JE6KjQRf0785WXWhj6K2A==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Tue, 5 May 2026 22:59:26 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 22:59:25 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, Nikola Djukic <ndjukic@nvidia.com>, David Airlie
 <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, John Hubbard
 <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Timur Tabi
 <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, Andrea Righi
 <arighi@nvidia.com>, Andy Ritger <ARitger@nvidia.com>, Zhi Wang
 <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>, Philipp Stanner
 <phasta@kernel.org>, Alexey Ivanov <alexeyi@nvidia.com>, Eliot Courtney
 <ecourtney@nvidia.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Thread-Topic: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Thread-Index: AQHc1PidLNjW7hq7pkuBgJ+mkGoHbrX66naAgAUxPHY=
Date: Tue, 5 May 2026 22:59:25 +0000
Message-ID: <DA4303E1-F49E-42BD-99B6-C7472C3BB12F@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-5-joelagnelf@nvidia.com>
 <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
In-Reply-To: <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|DM4PR12MB7743:EE_
x-ms-office365-filtering-correlation-id: f71f38ee-40f9-46af-c06b-08deaaf9f45c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: odxjs4TY4ElcA19mEA26tCXi5eNedDO81zW04C8AH/TtNiEZZB9yEInLWRMPRMHmMd3a1E2PifD6/Y0CSlIGHSz0EvQn7Y2jeRSUgwTBNNj7qyguLYmDeahDGMzgbUAq2fdhOJpWDr1kXsj9+jN1HxKtrienPVGp6J2DPSa2T2n4KuIDFBtgoLxvthzE3rHRjgjW6EW+m8GfOnt2OTtKYkKFZ9us5niVVwgNZxBUY4L+Rb2Pb/gGxd7JSKAih3tSGCTxa1dwKpdg8hjL8iNu7wsjTIqSqM85iQlMTn8tWIHsv0FGzQcb7eqsPo3JxzIIU2NIRB3+3fS7CeU7HXLcKi2RJyXvUy6mIbyNZaOsL1QzoLopqM3z88iB7UkkLzwT7U9rroNicCv2N5HpvCDWl7MgyBZYoDnpDDNfGdEDTeivp7Xk0j/Oz3izD8Lg4dR7Ky0DdNcwV1Nm0nOXtm5shr9yzcmPm0PdE8VrVzqbi8Elv3QcD8tztwm55pH+BPwxoY+5pWr6SGvahSiUgHZRvwum5hXgPd/EYNjnVn6X5nfpCWpBVqhP4ZjZA6vyIlo3k5DLDXkF8+CqYIFlXBFp0xeZkfeCF9iXs7ikMw31ECtal4MO/k+ATBdajIQU5xI4biUNDJnW9TIllJ09SSR02UnbzDU6P8GQggBYrlfJjV7byWIRAnsuFgbI0xkB6Y0bPo//kQaXpn9gq9x7ZQqfgqFzPyErb3Vrt0wx/Vj3AZJBHWlkltAxozykmf+313UV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWJFL1E4UWNMSzdhVk5yOFl1VWhXNXAvaHp5c3B6Snh1dWpUZ0Q3UVg4Z3E3?=
 =?utf-8?B?Sk9sN0JCempXY1lDVDFOMTVWQ25HM1JXRmNFTHJFU0ptWnk4cXJKSU1RcVp1?=
 =?utf-8?B?TVg4c0hGM3BRQ3hWWWwxZlFVOGRzVDByMkpYQ0laaC9nMWdxSHVmMXUzbm56?=
 =?utf-8?B?WkZrU01uWm5Qc0ZxNFJFK0VET0hxRVlRRzdpb3lKN0IvNll4WFd4TFplQnRZ?=
 =?utf-8?B?TmNpU0kvRXd3L3NKQWk0VVZXMDMzdTJUaTExM0hOU2hWcVNTRHZuZDZpZHMx?=
 =?utf-8?B?R09Hd3NJYVRhb2pROWlXUnc2Zm11ZEN2bk4wSG5XdHhhZ0FiMkJsVzlLQW4w?=
 =?utf-8?B?bDA2c25jd0o4QUF1QVF2b0FKN1RYbVJRT1U1azI5SFhqSnZEKzZJN0dXNzFP?=
 =?utf-8?B?YTd1MnFpQ3J5Ymh4WW9YZ1ZVWGJjRFN4eDdhMkJ6UTZNT1VHK3dKbkZYWXh2?=
 =?utf-8?B?K1VtZTlEUHJBQS9Bc2htbFZiNWFnM2ltQk55RlcvTC9BNkNzakVVTHc5cHJ2?=
 =?utf-8?B?OStZUXc4NFYrUm53MFd5ZWFUblZjTmlacFdFMG45ZmxVQnNuNHk3N3duenBU?=
 =?utf-8?B?bkFieTU1UlB1bVF0aHFIbS9kSW1SeVRZZXlaZE8vODA3UnhoR21laDFScVdw?=
 =?utf-8?B?UGFsMXBnSUJsNEo5dkZsdERMNEh6WnZCNDZIdUUzdVcvVkwvVmZtdzZWUzZh?=
 =?utf-8?B?NUpIdEhkZ3VNVk5VZm8yN0w3RE9wUkRwQ21zOWQ3alpJalVna0dkWjExMWUx?=
 =?utf-8?B?Y3pVb1pzTWQ1MlR1c0RWMERyQkUxQVBoTlY5bzN3VTNWeUQzY0tBUlRUUm1y?=
 =?utf-8?B?L2lPY2tKcUVEVlQzRU9pb0N6Z0I3V3dGZ2oxV1JHODlqb0xZaTJGcysrNmNy?=
 =?utf-8?B?R1ZzSlBjYXBKbnp5YVdQN3Z5RUR6UGlSUWNIY2lXZ2Y0TXgvTklyNUx5ZExa?=
 =?utf-8?B?THFOVGVCWVhEZjk0SVMxVVFzWmpuWUJVaTZHKzJDeUkvbStmTmhoT1g0SGpu?=
 =?utf-8?B?dXZsSmM1L0ZXSWRkOXpXa2NrOG5aRTVYVmc1VVRaSDRlMWNRM2VkeThiZEJw?=
 =?utf-8?B?YzJZSnphUHpKVGxvcTEwUnV5MTRyVmNlM1VVd0tlb2ErUi9YK1dINGJrb1Z0?=
 =?utf-8?B?WjNKcmRTdStab1RqbnpzMXZRM2hCRmZUMWkvdFpObDVTcHlrcW90cFFRcll6?=
 =?utf-8?B?V2Rwa2hBTHNGRGpRWGlNMjZIOXBRbXFpZE9kRmg3RkNkeHNDd2FWSWIxeW1I?=
 =?utf-8?B?WndoTFdSQXBVa0tnY05ZcVo3ZlA2SjZWMC9SMUpWUGxZamp2QWx3WmoxYU1L?=
 =?utf-8?B?RS9FZmFUTFBBZWJnYzU2bkxNcHZZQVd4SzNyeDgzLzBjR1FZellMN1VTeSsx?=
 =?utf-8?B?UklPanFTRXIzRG5lSkV5T2dwcXZUWG9ZWURvR1JPRDZqNjZCRFFzN3FCRUVU?=
 =?utf-8?B?RFlGMklOQjZoR01SNjR2ZzNjcXRrblFQT0Erblk4YjN2VU5jR1lnbDUraEF6?=
 =?utf-8?B?cjdqejZvd2dBVXN1OEJRT2tHUE1FZjFPK0J6YThBQ2VBSVNkTmlTSXRHMHg4?=
 =?utf-8?B?djV4WFllOFNyMUlUcnd3VnF0TWM3dngzWGlpUm82Wm5qYUhxMnZOdXZhc3c4?=
 =?utf-8?B?VSt0aWU3Rkd6ZlE4MlZ2L2dKQmFvMEdQdytKZG05L1laZGFMVGRhWnhHK2U4?=
 =?utf-8?B?eTI0bFZJMThWUXJGVVlpZFVJWnZ3VkpiSjlNaTZsUVB4UHZhazVaV0FuZ1NI?=
 =?utf-8?B?SU1jQlBmTFJSVnRPOFhwOHFQaVpEdjFMSk45c2VIZDk2RXN1SlIwQUJiQ25D?=
 =?utf-8?B?Y0ZRNDk0dkV5N25IcHhkNnRlVG1vTWRwenZhQzh3cmp3eXdCNzE4Yno2NkQy?=
 =?utf-8?B?VVQzZVI4N3Ztb1YyeUNINTUyQ2dSWW1NbWRHb004WGltZ1RJQVMzY0ZyZXdm?=
 =?utf-8?B?YlNjWFora3ZPZm5MclA3NFJmWEZqUDVsaWtFUFhESVBvTEpNTmNrUVdmU01n?=
 =?utf-8?B?ZTNMVmlEaTVoY0NWVm1OdXFXaVd2aXA4Z3FCaW5oMi9vZUJveUhTUWUrNjla?=
 =?utf-8?B?dEx0VmtuNkNPb1hjNCs4aFkwRjk1UG8wUllpYUlwY1lld2pSTm0xMjV5aWpN?=
 =?utf-8?B?SmtjbUVPeGZxTzkyaUlWaTNFT0RMRWZNQmdoR200OXhkVUtJVUxKcEp5QUdW?=
 =?utf-8?B?V2Z1cHhSeDlqWmhqem9MOWNGMk55UG9lSGRmSFowVmVETW5wZ2xyVENCUFF4?=
 =?utf-8?B?MDlFd0dXNGtuN1NFamRtR21NZlRmRnRaOFlSVGNwYVl3WnpJRjljdnM0Yis1?=
 =?utf-8?B?Nkx5MklvQUhBS1FSMGgrb0JVRlhCWkMzZmJ0YTVhUHhTSXdMcW5yQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f38ee-40f9-46af-c06b-08deaaf9f45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 22:59:25.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTfVX8ZAFlz56pRasjzZH93vOlgoAkofP9kbElUu7wULZAWYYP2G+WzmG7jTD+5w+3NL0ZJZI+pR3gpEC7eQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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

DQoNCj4gT24gTWF5IDIsIDIwMjYsIGF0IDExOjQy4oCvQU0sIEFsZXhhbmRyZSBDb3VyYm90IDxh
Y291cmJvdEBudmlkaWEuY29tPg0KDQo+PiArDQo+PiArLy8vIFBSQU1JTiBhcGVydHVyZSBtYW5h
Z2VyLg0KPj4gKy8vLw0KPj4gKy8vLyBDYWxsIFtgUHJhbWluOjpnZXRfd2luZG93KClgXSB0byBh
Y3F1aXJlIGV4Y2x1c2l2ZSBQUkFNSU4gYWNjZXNzLg0KPj4gKyNbcGluX2RhdGFdDQo+PiArcHVi
KGNyYXRlKSBzdHJ1Y3QgUHJhbWluIHsNCj4+ICsgICAgYmFyOiBBcmM8RGV2cmVzPEJhcjA+PiwN
Cj4gDQo+IFRoZSBIUlQgc2VyaWVzIFsxXSB3aWxsIGFsbG93IHlvdSB0byBncmVhdGx5IHNpbXBs
aWZ5IGFsbCB0aGlzIGJ5DQo+IHN0b3JpbmcgYSBgJidhIEJhcjBgIGRpcmVjdGx5IGluIHRoaXMg
c3RydWN0dXJlLiBJdCB3aWxsIG1vc3QgbGlrZWx5DQo+IGxhbmQgdGhpcyBjeWNsZSwgc28gSSB0
aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIHByb2FjdGl2ZWx5IGRlcGVuZCBvbg0KPiB0aGVtLiBJ
dCBzaG91bGQgYXBwbHkgY2xlYW5seSAobW9kdWxvIHRoZSBUeXIgcGF0Y2hlcyBJSVJDLCBidXQg
eW91IGNhbg0KPiBza2lwIHRoZW0gaWYgeW91IGRvbid0IGJ1aWxkIHRoZSBkcml2ZXIpIG9uIHRv
cCBvZiBgZHJtLXJ1c3QtbmV4dGAgLSBvbg0KPiB0b3Agb2Ygd2hpY2ggdGhpcyBzaG91bGQgYWxz
byBiZSByZWJhc2VkIGFueXdheS4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNjA0MjcyMjExNTUuMjE0NDg0OC0xLWRha3JAa2VybmVsLm9yZy8NCj4gDQoNCkkgdHJp
ZWQgdG8gYXBwbHkgaXQgYnV0IGhhZCBhIGxvdCBvZiBjb25mbGljdC4NCg0KRGFuaWxvLCBkbyB5
b3UgaGF2ZSBhIHRyZWUgb2YgdGhlc2UgcGF0Y2hlcyBzb21ld2hlcmUgdGhhdCBhcHBsaWVzIG9u
IGRybS1ydXN0LW5leHQ/DQoNCnRoYW5rcywNCi0NCkpvZWwgRmVybmFuZGVzDQoNCg==
