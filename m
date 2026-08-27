Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33147C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD9010F0B4;
	Thu, 27 Aug 2026 14:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="T5XSMFDg";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642FC10F085;
 Thu, 27 Aug 2026 14:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDhdXYUFrRmWWnxxB33grFCrryjDoP1ybHJlzk7TEXnD5f2+Y9VrSPNrosg90rL6PaUd5CnEg0MZYl6uyA5wgMGRX+4uKsg6d7cGU8eLZIgTFRuA5y4qoLKMMu7XIVLcTg9YljEjaMs1w0VJvQo7reqzPUgONuYl/vM1bXOsw9l7M/8jbajlJxOFh7jbTy1qQSPxXDW/ccnBCEasMje113mW0g0I8ZmwviaBoLQxwebTDa1/Nn169nK67OtgnM1OkoRapeUBOjPMrUcIx5XLKzDgqSVmJ31+BRBrIhjuXqrug7PgrcQxPoEZm1ktPS7pOcr8/GrskVtqQDBbZ9Q1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rzPIJ30MmvIiaieBGtWnqn6Lf8zr7CbFSsOy3aQi2M=;
 b=tneuqV4OhgkigwZR6FzHherrIY9lFDclkyodd/R6ALWhTtLouS3IBB8e2LcX5+cO7zIE2cvusrrTaoaAGc5BvykyfGs8oudxeTOlZZR9On/oKKCnw597cA7FPuCCkZaHxA4NU4M9040uiAhkqe7hPJ80yeJY5iwcdGnk1G3NdYWgg2Com/V9Y4x9JaAERQjfYZ3PuGN/xnuDyESn5ygwdmVmjEI5Mxo2okb1mlAV7s3EI/pDyf6uAOsVwVI50kVccBk/3WHCTp5Jsjfu83+KsWBOpEbMlYS6H7limmwRx4bvXL1LEurT2wV60ebRNPJVKbnXa8P27y6X7YWMOEUNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rzPIJ30MmvIiaieBGtWnqn6Lf8zr7CbFSsOy3aQi2M=;
 b=T5XSMFDgMuzdTrzj8uhot5t5E+R74iHd+qXLX/VhtyUG6OGfqltkEM71tRd3n4EJvTeM9XmMtcSQ3Ctmfue3kbb2NX6EbbqfcnoPpxnOGovau/QvrvLBsiFATRie4P99gzGRGOOpP6KJCyqOm5ZBl8zuf1lKhTCPoFiFhKmKiGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB7371.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:37:21 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:37:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:37:20 +0100
Message-Id: <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
In-Reply-To: <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e466cbf-6d60-415e-5157-08df0448b3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10070799003|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8b9adFatvu8e57WnSpTNErWD3KTwLaIPCN8xZrB3TIKCOnXFkq8Z6ADQu8jikgAMstrAc27CoNUgBdOFVHHNgqr+wAJRZRjbmLzTrBkrdGjvSHDtMiuRA/4t5qfy9NTYaXwudnWhaGDOGX3d53vRDZvZgrzlhJgILsYpJocF8GZWROwWHKknx38pw/aX4xtYnMqT13wHUp464gI54Cf9YJEH1ce9zrAPUWg0Dx0XXrhJmF63efXPp0LU+lcMidPSKdVY1IKHKpZOoY5NeVjO/D/Fpp6MAQNmgMcsxKZyIw7hq3Al6LBiMi4xnmKnbL4YXs5Fp+ixV/Wd2KKTBgLnRhe/hmoZGyOzEblL6AFSAvdhdSUbtPDg6l97QYHdWzdEnPlHzbrtD4yoVvGimV+GnWbXRT6E+EdSfIHB+MihjiAnAglKlspuJEB4CjZ0FMvQzmUPAJYAP1RXESeLtK9rtQJiG0V6VqLdiwBalDTNgj+saiHTEZY92POXlF5mpmfQYXviMJFIj8SOdJFum6aH3MolpcmfyhDWTRBOPgophhb7hJ419+1fCC0sSdA/ekv2SYIMoEg4vEFYoznwY4YCMsMg/jpm9/EqbzqidGuSJuFSUV1L+20/tLtqt7z2oUSeibDEughWPScfRKzAusWXiI4vKJhA3EefcXfPZczsMu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10070799003)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NlcmVnUkllanMrR05HekJHa0RZMSswSnJONmw4cHJDamZzUFB4VkRkL3Rk?=
 =?utf-8?B?UmZYazJZUWdmY1VFYVhDVUdzUFUvL0JEbTM3K1JZVmw5a3ZScWk1TnNvY1Jw?=
 =?utf-8?B?K1BrVzM2YWNqT2hRRjlkK2JQbEd1dGdWcmFuTXh3Tmk1TnkySDZHS0VuRzJS?=
 =?utf-8?B?d2JHWkRaOC90UHZQL2RPQks1VFU2K2NoTGhzY0F5RXppRk50Y1lhK1VYUXFp?=
 =?utf-8?B?V2NUcjJVcFpoMlU2OVFBN1psSzdyV0pFV2x3UUF3SEFySytaQW4zRnM5dGxz?=
 =?utf-8?B?OXZuSXc4bXp1MlluTkZ1aEo5N1h2OURVNHFPeXArblk5b1pvWWFHVmFBN09I?=
 =?utf-8?B?TXQ3RzMzMTJQZDFBNlBvbVE3REd4eklmTUNoSXhBVW5wN2kxVXNmZHEreXcw?=
 =?utf-8?B?OUQwMzFVZmRCU2FFVGtLVlJySUQzL3dHQi8zNVBUbGJQeGxJZjFqUjYvU0Fy?=
 =?utf-8?B?djQrakhtNktsQnBSbFAxZmx4MGxFNERiTWNLay9DbFBiL2FRWFBEd3Z2dmln?=
 =?utf-8?B?dWFhbG42VDhyN2o1WG1pVE43K3RYcDNZZ293NzJlK2duTVU0YTFYMjFqandG?=
 =?utf-8?B?a3lZT090d1dHMG10MVNleTFKTU1XMURCNEpZcnByWk1PUjgrTUZWa2RZcWha?=
 =?utf-8?B?eHdKYS9MREtPTnBuVFZTOWhuK3ZrSXVrUlJRZkdXRU15MXRvRnJTeHNxL294?=
 =?utf-8?B?ejBpTndNdWhCSnV0Z1VrWnlWdHQ3SllNMG5FYVVvSzdaTy9NamphT1FUQ1Yz?=
 =?utf-8?B?VS9wRGhsOUt2eGlsVlgzOGdVS3JvM0pkekM3TERIWEpPQnhYaENlQnBzTzBr?=
 =?utf-8?B?TXpCSFRhVUFZclZiUFlzVnowTmlIRWRZUEEvbzhySVZadCsyTm45RDYveDNt?=
 =?utf-8?B?MFJaMkpkYUxjOU5iK1M5TlVCOHJJbUJjMUxMcTBqdzU3OFRST0NiYnRFNVV0?=
 =?utf-8?B?ZHJnUmZoSndyQVY3dGNKa3ZjVVZRb09lc3gyQmpBNUh0NGxXQVdJN0NBQTAw?=
 =?utf-8?B?dkt4WFVpZUJzVDhZV0V0d1d6M3NTeTZ1Mlh4UUVtcHBORENVYlk4WG42N1d5?=
 =?utf-8?B?aHpySURIOTNlUFNybys3cnNxMkVTYWhiWEE3WEdHS0NMZ0VXa2pGcUhJRXBH?=
 =?utf-8?B?SEgrRHE1cDc2Q1VCQXUwY2JoS2g4MW55a2pxVXE4OVJhZGRrTnlpaWlabjlE?=
 =?utf-8?B?SlFXSmdBeGplRE56OWppWllJbEtiQVl4UFB1Q2Q4eUJOcC81bkJpLzIyME1D?=
 =?utf-8?B?Z1M5ejNMRDhtQlVUQ1hkRHdkVGF3azgxT0orSGF2UURVaG9ZaXJEMStNVkJa?=
 =?utf-8?B?Rm5zV3IxNHdXSnRLaU5tMU9oL3pQZ2tjNXNWRGZ6Ynlxc2tFZ2pEZmpHdnRs?=
 =?utf-8?B?Mml4R0JMbmVyUmZ3M0g4QzVETHIrMlJrVWpZbTdMZUU5ZjNsV3ZsWEE0VG90?=
 =?utf-8?B?Mnh5L0lzSDRSZGd0VnJBL1gwQ2JWZ0xiTkpsanRDYW52T2lzaU5rTks1a2sv?=
 =?utf-8?B?NWZ1V3FLOXpWSVA1aWp3bHFxQlR0am5SQ1RnVE9YRVd3M1pzQkdtcXJUaXYy?=
 =?utf-8?B?K3RQWnR5bHZzNmgyYmZSTWk2cWo5QjhVWEJLWDZCM3p2MmV3Y3hGcTdXYm1l?=
 =?utf-8?B?SW50bFEwd3QvSUNWS2c5cTV0dHJwKzNTOXRpZGRoTGY3QnU0SGlnSzRhSkNC?=
 =?utf-8?B?ak50S1dBRXo1eE91aisvOE5jbXFKN1BISFpSelFCUWM4aGdHajI0SFVvUDhG?=
 =?utf-8?B?eDFiN0thOE54U0EydUNxQmJRUXFwVFFEbWIyaWtyRmgxYmZZNmxuZFJLc2tE?=
 =?utf-8?B?ZVozclcyOVlQQzgySXNwQnlzYW9PRkw2ckRFcVc2bisycHM2UWE3T2djTE1K?=
 =?utf-8?B?RnVwWkFCYUdNc2RDYXQ1RGtzN1BrZ2FLSmxqcHgzRmRScVRkR1AwTm1FTWJL?=
 =?utf-8?B?SlBWaDhvdUJPc051SHR6aVR2UVBLSWFKMWlhQ2FYMS9qRDBMYkZiR1dPdFM1?=
 =?utf-8?B?ZGxCMnVaL1BqR2N6VVFScGlvdnZ3VHlYZC9kVTF3ZkcrREFiN3htY21obTg1?=
 =?utf-8?B?TFNlSHNWejJmQTFqUmRBbXNHZFBSaVZSSkxleEdia1BaZnVwTWpjRGYyMWl6?=
 =?utf-8?B?citMaExQUEdkMnlJRjhIN25lMHpUV1M4OGp3UnE4NWpPLzVsT2I2ZDVnNzhv?=
 =?utf-8?B?SUxDeDFHQzdmWUhHd0ljSFphN29Lbk45QzY0U0tnSmgvUVFFVEQ3blVWVFRZ?=
 =?utf-8?B?SEZNNkRGSlU1UmoyeEZqYUpRQkx5dmlzS21hTmFZQ1hMcURJM0orVnRKSjBy?=
 =?utf-8?B?RVhoNy93MmtIWDJoM1FIM01zbzlzdXFLVmVBc096QlNjeSs0Nk5ZQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e466cbf-6d60-415e-5157-08df0448b3d9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:37:21.2282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+h4sWbdP5nUTrXbq08MzjR9cfFDes042UnM0uqz94aExghxqRDUfxRanNXZD7P095FmNb64nuHVp7Addu+O1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7371
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

On Thu Aug 27, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
>> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>>> unfortunate because it disincentivizes using it in interface boundar=
ies.
>>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for cons=
tant
>>>>>> value) takes a const integer expression and widens it to i128 (at bu=
ild
>>>>>> time only) before passing it as a const generic value to a new trait
>>>>>> function `FromConst::from_const`. The trait is implemented by NonZer=
o,
>>>>>> Bounded, and Alignment and lets values of each be constructed from
>>>>>> constants without a verbose turbofish syntax. For example,
>>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>>>>>=20
>>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>>
>>>>> This doesn't work in const context, so I don't think this is a great
>>>>> strategy.
>>>>>
>>>>> I would want to use it for cases like this:
>>>>>
>>>>> drivers/android/binder/netlink.rs
>>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPO=
RT as u8;
>>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A=
_REPORT_ERROR as c_int;
>>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER=
_A_REPORT_CONTEXT as c_int;
>>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_FROM_PID as c_int;
>>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_FROM_TID as c_int;
>>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_=
A_REPORT_TO_PID as c_int;
>>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_=
A_REPORT_TO_TID as c_int;
>>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_IS_REPLY as c_int;
>>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A=
_REPORT_FLAGS as c_int;
>>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_=
REPORT_CODE as c_int;
>>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_DATA_SIZE as c_int;
>>>>
>>>> `const_as!` [1] should do the trick for this, provided you don't need =
to
>>>> create a const `NonZero`.
>>>>
>>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nv=
idia.com/
>>>
>>> ... but I agree it would be nice to be able to use this in const
>>> context. And there is an overlap with `const_as!` that becomes more
>>> obvious the more I look at it.
>>>
>>> In for a penny, in for a pound of macro code as they say. Since we
>>> agreed on using macros, how about unifying both under the same `cv!`
>>> macro, with as many branches as we have types we want to initialize fro=
m
>>> a constant value? For instance:
>>>
>>>     // Does what `const_as!` currently does under the hood.
>>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER_C=
MD_REPORT));
>>>     // Calls `NonZero::new().unwrap()` under the hood.
>>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi::=
NONZERO_VALUE));
>>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::ua=
pi::SMALL_VALUE));
>>>
>>> I.e. we would have one extra matching arm in `cv!` per type it handles
>>> instead of implementing a trait. The syntax of the macro would look mor=
e
>>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have the
>>> limitations of such a semantic dispatch.
>>>
>>> Even the name `const_as!` wasn't really accurate to begin with: what it
>>> really emulates is a const `try_from`, and we even discussed
>>> implementing it in these terms in the future.
>>>
>>> I'm sure the idea needs more polishing but I think there's something to
>>> explore here.
>>
>> Yeah I agree that const_as! is similar and if we had const traits we
>> could fully merge them and have it always work in a const context for
>> both duties (which are really a const tryfrom as you said).
>>
>> I am not sure about the suggested syntax (e.g.
>> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
>> verbose.
>
> A bit, but what I like is that it looks very close to what you would
> naturally write if you had const traits (minus the unwraps), so you
> don't have to learn a new syntax. As long as it's not *more* verbose
> than natural Rust, I think it's fine.
>
> It also has the benefit of relying less on type inference, i.e. `cv!(5)`
> requires the caller to specify the type even with a `let` statement,
> whereas you could do `let v =3D cv!(NonZero::new(5));` and it would work
> as expected.

Even with const try_from we'd still want `cv!()` to avoid having to write

    const { Type::try_from(...).unwrap() }

I think having `=3D>` syntax is great because it is a good place to *option=
ally*
require type annotation.

For enum repr for example, I think it'd be great that

    const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT);

would work directly. It might need some tricks, which I have hard time comi=
ng up
as I'm not feeling very well today, but I'll give it a shot over the weeken=
d...

Best,
Gary
