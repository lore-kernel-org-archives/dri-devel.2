Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7660A2606
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HyThkugr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C63510F94F;
	Wed, 28 Oct 2026 02:21:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819B410F94F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ervCO1WDcvyqoa68+YCcRygIb2JDLnTqndyA767EI1cK2oGWPZLT/nLoEEPuSQjpcgJsOHFmnUU94KqLjSfd60iSrarn0BBlca7Lb4ndKY9cqO1ITmVAt8AYD4hcjRq0dU/Q1Lzct/5nbapo6tLNnyZkH9CCtB/GSLXD45er7Wj7W2lT0VaJW2y38G3pZz+R0uY3eY8zN04jJW3AOKzVsFk/PEiwXNatGkAz+odC6K5VynorkEj9IpqUjN8hWQFiLLMGWXmadVMwlx664wF0o6bJGJYgPv2gVXX+XNfqXQaMQY9Oyd8kUkvixY8+sBLobUleZ/IqY6RrnC6MtumUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=952WFHLSKxyhQ+pjiOKBNWu6B3v11A2jF13/9EJOcd0=;
 b=x80yxC31suLC/QGGrsPsJCgNP7YNQdiWioN/SL6tba7c4kq2AWvw/0ZD0DZhjWDJVGklG6Q+o/uCdkdu7reJcS87Uby17PsVY7O2Pd/hQh7W4EV2N9IwwNzdLKzqFSVGgy6NuzGrFaluo8qPMFWaH61ngsa/u4YylnezGex/f9Hs+sYOBdD3seM2fI4hJSqd2emIagYg3w8nlC0unex3wx4sPEHF8dNC6uw1PDh4TCSV1fSFS41hMuv4gpKW+kaiokMvN+9BZdak101hLwIeUNsCi2DvX5Z973HJQ8fVU1uCA/f02kCED2A2SYm4IdN4ro+fjIz7INGl4j5jHOOHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=952WFHLSKxyhQ+pjiOKBNWu6B3v11A2jF13/9EJOcd0=;
 b=HyThkugrV+cRPyKrnOteAJiHap/U2uEI1MRU9rNgufNsu2XzOfbUvSnD3G2GnFQ/E9WwPeeWneq6llcUj170jCaffoatAIIAhICexFD0R7SOW0pY2Sy4eoV0q8LJVli88V8Kba38QZVmVmLrkJgqKI2JeDewx/lLvbA2AQegqoSVnhy9LU0yDHrDoCwn6xmZbMkvZc6m/1Ea5tq8112trtdrkROZHAc8rIu5SHOZPEjO9rWvTJKrU/xPXEOND4qEpGY2khn9/vOEKnLUHmksc26O/8FKR7qLk/pU7TcY3Vn11NlQ7mXEx4JssAt1+xM9UeCKZX4rPsMyiSQLK15auw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:28 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 0/7] gpu: nova-core: add NVKV codec
Date: Wed, 28 Oct 2026 11:20:59 +0900
Message-Id: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPTW7CMBAF4Ksgr2vkmdjGYdV7VCz8MwG3atLaw
 aJCuXsdaAmI5bPeN08+s0wpUmbb1ZklKjHHoa9BvayYP9h+TzyGmhkK1MIAcid5Xz4KhwZspzx
 qDZ7V9leiLp4ul95215yP7p38OPO/RqLvY50Yl9oh5nFIP5f9AvPr/9TmNlWAC+6MDE6RkU5vX
 vsSQ7RrP3yy+UjBO4h3ECsUgdqgvNHK+CfYLLBFs8Cmwk5IJWT9IXp8gvIGQYBeoKyQjGvRtWC
 tcg9wmqZfjXioy3EBAAA=
X-Change-ID: 20260812-b4-nvkv-131af5c2661c
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: a63a51e8-26ac-4143-c61b-08df349a2c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|921020|11063799006|56012099006|261009223027099003|261022105027099003|261021135927099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|10067099003|261021123027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: i6QydqDyNB7/i3PBbOkPt4RiZMEBX30lyoSycy1NkXDp4gp+EGcpRBQN6V9AsOkwAspTfheVfLlAKAkJMD9nznPoFrEV/03HFJKhRz4TrHPe4jRTOenQzIg5rkcZXB0eB2PR9OVvaRJ10pJ8xQGc0SHVpgNr1AXAhP0mD/Wmv+JD9KdAfNwJ6+A1SxzaVRQXfhOLUWOVx7zrjcBSrAr4lrCOsOQ3TS4rLTHmbOU4Mr01akCzkTYcf81EJAZA0z32avddIVXDBJEyInDKFcFgipuX07nUpMlbEfM+8HhH03Dgh15Yk5GzYB1F9QcATC9neB0ys1ceI9h7WD6yziqQenaukTNcTjWzKRYRBSvF7d8kBMYkVY6iHgu++SdbSvaKkiXgs5Xfe5zXaP4ev30kkjSIb3xPi20WBH6PwCYM6j5HdGoei29PQKMqVCbBOSvRchCVSYOK6RX773C3mLHFS+GxLlQYg+Xg9e4ImHkA5CUC5IEf5SIYJ3XLGcVLvR2iVihWZeOtfIYRnEk/FbskrlJUwwxCBPoQGrW4v7Koxo6olIy9ZV4ojGOZVA4z866VYtS5TA6uCDpgl6wj1Pz4c/RZAmkTRpAvI4qfWYQ/A8PpHO9NNPVZSEdHVDUBT1EZ8b2Xw5S8fQgEiuvw9Vn1Iu+uTC7RdS1z+q58W/RShHm/pr4LBNjcF9LabILPtCB/seSDm32+j4/UaLLl/9kAHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021135927099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFOWmdZME9xRlJtQUd5VVRHL0taWTVjbkFZWGltRm5CWUkyM0FvQTVHdWxr?=
 =?utf-8?B?TlVadS85STAzUkJmVTFQelJJWW1uaEpZaEExUUZ0TERyamZUOUEwODB3S21W?=
 =?utf-8?B?OHkyZGNzVUl0aU1Oc2JRaVllQnJVdnFtTkxRS0ZWVXJwTWVlM3lCb2lPTXAy?=
 =?utf-8?B?Q1NuMWY4cVFrR1RnanJhSVNjMXpIZjZIUWhzVjBhUVpoYzEvZEpDVTMwNVNP?=
 =?utf-8?B?Rnh0UTJZalY1eXpPd2Q2dDhHT09yaHZFNDhEOGVtS1d0aXQyYnB2NkJKQUhC?=
 =?utf-8?B?RzN3elZ2b1hEVDJOTXdnTDhPa3ROOVVUSkZ0REtvUEZUMEE5eGVJUmN4c0hn?=
 =?utf-8?B?MEQ5MEd6Mnc4cEJoMHdzTVlHYnp5blREeVkyUlBxYVZMRFRsMW8zRmdQNk1K?=
 =?utf-8?B?cGNuaUMzYXNBWVdyNVZyMWRKcUIrRUdVWHdGeVlYZUxhZmRISTlKNlQ2Rlhh?=
 =?utf-8?B?WW5YaDRYUFR3VlIwMm43OU1hNXoydit6cklxTStaWXQ4SnEvbXdHeVZqUnEv?=
 =?utf-8?B?elEzdTRTMGEzdkxmTjBOMlVzeDVnTUUxa0Nud29tdVFBSjRRT2N3WkFCdWpl?=
 =?utf-8?B?WVVaZWhaQXNSenJ1ZEJZTlJhY21Wc2NaUWlvRTlGNjFPVEdxOUUxOFQ1UWhI?=
 =?utf-8?B?TDE5cUdZcWpJZnpEcmlzejJyZnB4MGdlZFNNVUtsRzNFdUIyay92aS9MdzZU?=
 =?utf-8?B?Y3c5Z29VK2FlaTB6WGp1S0g1TUk1emFnODJBaUpIYXlCSHV0VzV1cnhSZ20x?=
 =?utf-8?B?MDdxQWoxNjBKQnVkMHNnZjVyVERQVTVNV295SDdWd2thNzBRWDdZMWtZanpX?=
 =?utf-8?B?aVhmZHEraWRVd1hLSkNIaDlPc3RhWlhpbnRteHMxMW85b0hmd1cyM0xnNm8z?=
 =?utf-8?B?Q2Rzb1QxR0p4ZytkNzFZRHpuT2Q0VEdBZGl1enJaa2hYTGJta1FmVUtzcUJo?=
 =?utf-8?B?TkZsM2xyK2txMkZqTjh3WTBKWWFQYXkwVVhoMzFrVk51MlBaUUJKeVdoT1dW?=
 =?utf-8?B?ZDd0bFNJNE0wZGQxVHM4NG1hV2ViMVJhaU1yWDlUMmZOTTdKekJFRWJmRHFP?=
 =?utf-8?B?QjNWUlFnNzRkcExJUUdMY1NhMWNLenBpZ2paWC9KRE1PV21GQjFMTS85UnVB?=
 =?utf-8?B?TUExTjloNjVZRENFRHJld04rWGRvM0dYZFEwbWhxb0kyMnhNZWs0K0VWWXlt?=
 =?utf-8?B?TmEwbUZIdEVXeks4WktWRldsTDZVbk5ZaEpReEVwUVNMdEFsMlZQcUwzZnNH?=
 =?utf-8?B?UnNVQWFZV2JMV0YxZ09JRGNwL0xlcmMyRkFDK09UMXl0Z1BvdU1SYzdQemI4?=
 =?utf-8?B?UmVtRnV3RThhR1AzUHpzbk1QNW91OVFEdnJjRXRBVWRSMEppcHBkS0ppOUFt?=
 =?utf-8?B?WUpKUzNPR2poQUU4NFJ1RktuN0ZDTXNVTDcxKy9SSTdFOTl5WHVVaEtSemRm?=
 =?utf-8?B?YVBnN1M0bXRZSFdXL1ByOWtPSHBGWnYyemx1cE9obFNnMWpFanB4cWJaQUNx?=
 =?utf-8?B?SVh2WHNQRXpMeHJhNFNPRjg1WU5tVk5PMWI4SEMwRXRFNjd6MXVZK2o3bUoz?=
 =?utf-8?B?UlVPM29MU20vMEg1NW1mb1BtRzdQTG9UeXF0RkZGNUcvRDE2bVg2a1c5OWF3?=
 =?utf-8?B?Ky9MYWhqU0tZM3l6L1NUSFNYN0FmYk9ObXkzdjh3NUQrdCtxR21YWGdnT1BT?=
 =?utf-8?B?QWpzeERaTFozdSszd2JqSUsydmJPUDcyMERsYnp0VnV6eXRVT21WMUhLZFRU?=
 =?utf-8?B?WjgzZ0czQXpnRERBMkhlVGVhdXYrWXRFR3FuRlNIS0tpbitab3pyZXRSS1FV?=
 =?utf-8?B?bEh3SHRScC9pdzQ3UTdBWkxsT1ZpNER1ZFlSK0NVQW9mejY1VktFNVBIVFRI?=
 =?utf-8?B?NUl4WnV6R1AwZEczVVhac3BzeWlrTjhzMHBzQ1p3N0FlZWJKZko1MDd0ZlZU?=
 =?utf-8?B?STQvSEx0MHN5QWNLVytxUHBMNHU5VnJac1VaNFZ0aXNlSXBDWWVxYUptWEJT?=
 =?utf-8?B?M1NTMnRzZTgyb2JBMXpnc3VKQ0s5c2RsZTBHQVRjb2R6SjNwMUFjVTJZdlRl?=
 =?utf-8?B?ZXdsMHJqWlZ2VXBhRDgwdW5XMXhodC9qbm9JV1lxTXdkMXFWaVlLTnZuKzR0?=
 =?utf-8?B?SzVRdlZRcUVsYjRGUmlLQ0ZmdFJFVWUzOVZTcnlzNDVBb1JoT0g3cU9lenJU?=
 =?utf-8?B?Tks0NzNOQnBUVGpURi9mMFZoYytzRW8vYnczWlZjVFJ2S0FiUmgyRjhIN1JN?=
 =?utf-8?B?cHE3eTNiQUN2WWJzcWdBSWhYODNSeHJCSUVIbUg2bzFDVStjMVBaU2NsdS9j?=
 =?utf-8?B?RFZrNFZSa0VUWkZCaXBPOWUvWkVFMXVyQ0JFM3RLeEsyeitTcCtWMExFdHl5?=
 =?utf-8?Q?6NoVck5Xmvsr/NeAKGTNHvEMM8pqB29G8WWCD3WS2Ki9h?=
X-MS-Exchange-AntiSpam-MessageData-1: YwpPzEiqC3W/nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63a51e8-26ac-4143-c61b-08df349a2c3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:28.2770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on7hD1DDhFOSYjZyuTi3q/VFn0cUfX0w9rxb0GU9XumKI0n7eyr0vlTWFuLIJ+Wm7R8e9h8fSQ6p/U4NPNnV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the NVKV wire format for communicating
with GSP.

Essentially, the format encodes a sequence of calls to some function
f(key, index, value), where value is a [u8], u32, u64, [u32], or a
[u64]. The key is a u16 and the index is a 12 bit integer. The
interpretation of these function calls is per GMCAPI (RPC interface
used in firmwares later than r570). Generally speaking, the function
calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
b"some gpu") naturally maps to storing a &str with the GPU name.

This series adds a general encoder and decoder that works with the
base formats used ([u8], u32, u64, [u32], or a [u64]) for encode and a
general `Schema` trait for decode. This could be used directly, but
since most messages are struct-like, it's more ergonomic to use some
typed helpers for this declarative use case. So this series adds two
simple macros for encode and decode of structs, plus some general
types and implementations that help with using these.

Future patches will wire this up through the command queue.

This is based on drm-rust-next.

---
Changes in v5:
- Drop the Zeroable derive from ArrayVec (Alex)
- Add ArrayVec::init_empty and use it in Array (Alex)
- Implement ArrayVec::push with push_init (Alex)
- Make each Encoder method leave the stream unchanged on failure (Alex)
- Replace EncodedStream with a KVVec<u64> which simplifies the encoder a bit.
  It adds a memset to 0 - now that we have zerocopy in the future we could
  add a extend_from_bytes method to KVVec if we want to get rid of this.
- Use constants in the Key and Optional stack asserts (Alex)
- Make TruncatingArray wrap Array and share the visit code (Alex)
- Link to v4: https://patch.msgid.link/20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com

Changes in v4:
- Rebase onto drm-rust-next.
- Fold Vec::push_init into the Vec::try_push_init patch (Alex)
- Rename PushInitError to TryPushInitError and replace FullError with
  kvec::PushError (Alex)
- Add #[inline] to small Vec and ArrayVec methods (Sashiko)
- Drop #[inline] and #[repr(transparent)] (Alex)
- Move IndexedKey to nvkv.rs and make it crate-visible (Alex)
- Make Required work on schemas and add Optional (Alex)
- Add stack asserts for decoded Key and Optional values (Alex)
- Drop the GSP_INIT tests, use literal key ids (Alex)
- Doc, test and type cleanups (Alex)
- Fix expect dead_code for CONFIG_KUNIT=m build
- Drop the clippy exception from the ArrayVec::new() stack assert
  It turns out this isn't just clippy, but also -Os.
- Implement ArrayVec::init_with with Init::chain (simpler)
- Allow a lifetime on nvkv_encode! structs, like on nvkv_decode! structs
- Add a stack assert for encoded Key values
- Support the As type of Key in decoding and use it for FbRegionFlags
- Add TruncatingArray and truncate a long GPU name as OpenRM does,
  instead of failing to decode
- Drop unneeded bounds on Array and Schema::init, make HostArch private
- Link to v3: https://patch.msgid.link/20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com

Changes in v3:
- Rebase + drop zerocopy prereqs which are in now.
- Define Opcode with bounded_enum! (Alex)
- Use #[inline] instead of #[inline(always)] (Alex)
- Add Co-developed-by for Danilo on the encoder patch (EncodedStream)
- Split Schema into Schema (init/finish) and Visit<'data> (visit) to let
  schemas borrow from the encoded stream
- Support schemas that borrow from the stream in nvkv_decode!, e.g.
  struct NameSchema<'d> => Name<'d>
- Construct schemas only in place with a required Schema::init() and
  drop the Default impls + stack size asserts (Alex)
- Doc improvements (Alex)
- Add a TODO for the O(#fields) visit dispatch in nvkv_decode! (Alex)
- Replace the Key<Option<T>> special case with TryFrom<DecoderValue>
  for Option<T>
- Make Key's field and IndexedKey::new private (Alex)
- Move the nvkv_*! re-exports to GSP_INIT patch (Alex)
- Add decoder tests (Alex)
- Add error path tests (Alex)
- Add IndexedKey tests (Alex)
- Add RegKey tests (Alex)
- Link to v2: https://patch.msgid.link/20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com

Changes in v2:
- Tweak Schema trait to avoid materializing copies on the stack
- Move ArrayVec to alloc module (+add potentially useful methods) (Danilo)
- Add Vec::try_push_init (Danilo)
- Add sum error type for try_push_init, PushInitError
- Use Danilo's EncodedStream abstraction
- Add some stack space asserts (Danilo) - needs to skip on clippy tho
- Using zerocopy e.g. ref_from_prefix_with_elems requires updated zerocopy to
  avoid linking error, so added those as prereqs.
- Link to v1: https://patch.msgid.link/20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com

---
Eliot Courtney (7):
      rust: alloc: add Vec::try_push_init and Vec::push_init
      rust: alloc: add ArrayVec
      gpu: nova-core: add NVKV encoder
      gpu: nova-core: add NVKV decoder
      gpu: nova-core: add NVKV typed encoding
      gpu: nova-core: add NVKV typed decoding
      gpu: nova-core: add NVKV GSP_INIT schemas

 drivers/gpu/nova-core/gsp.rs             |    1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs |  157 +++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |  133 ++++
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 1206 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |  465 ++++++++++++
 rust/kernel/alloc.rs                     |    3 +
 rust/kernel/alloc/arrayvec.rs            |  351 +++++++++
 rust/kernel/alloc/kvec.rs                |   86 ++-
 rust/kernel/alloc/kvec/errors.rs         |   32 +-
 9 files changed, 2430 insertions(+), 4 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20260812-b4-nvkv-131af5c2661c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

