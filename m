Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A8606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F8ZSwxMh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5ED910E5D0;
	Thu, 12 Nov 2026 12:38:58 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2764E10E403
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBxNvPieoA2FegSKt3D1KSNoTYI99KGaHHboPpCFJZwchMoKG7WCPtb6t3AYCAB6mYQ23PCy3oqU4FoxQJ+FL2sNE7biAaP4cU0D1aDdwEnuQ06liuGhfaIKOnoUBNIbDVWhWIMXDt5Y87TjrLSetztZdSfNO4EeanxtQNV5GHqSq1OTA0fugtwb8d9XADs3InbNBJU5LQ8QuVVCxT2BlfP1onmPLaphJVaY1Mt3Cvch6SFHUhFHY8u4DCV4F0iT+TAnwizbX6uzbeVyUxaYsweWkTQ7f/23LPIQp1f47xYlOmTANut6dpaMs9rJi2JK9zh8pISgnnvOiGXukpMkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb6QrcO/RlQ6WQRO225cvrtn/AWlH7DyYCA+goldqD4=;
 b=HwUACP82/IWJOjQt9OQfjrj5neaxpTEWqENK0nkTJhPkaukeoXX+0LBnEqZwqIiYK5wePtboQcDRklBP5fYl9T+INDEtWrCh+BIuqVZCC0N4ll2HumYvnQP0Fw/mfUjCbxkC95H55Pd+vXmj06B0BtZVkEWk7ga1y6+okvTLKsegLUFvVEul2nYlrkKo3CSlFk9WA0kS4QoXxAlrULn67DoDzue7MhRO20f7+ysLSHjm5xcgV1GjbhMwZF6ySZ8HiwmPWRBxi2AzxOKRR2fEdyC7b/qEc6CgqmdNRH8XqwM4+2wCPurua2l7TnFDY3UO+cExWcRwz9cH8QLYmnSFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb6QrcO/RlQ6WQRO225cvrtn/AWlH7DyYCA+goldqD4=;
 b=F8ZSwxMhq5hPEp9m7iCiskb1SMJGLMPr36U+HmolDKfKmf9Ddhx2tZG9Jq14Wn/GukIGIztFvlYnB/QuWv155ftW0Se2HgETAIG70iCsQ9jcd5ahvjatyIkfI3cF18scsxRbP/aGnH/W7GXFJmlKV+EtjVV2igW5/YeUWA5mQZUidxyogz6tjNWYsGvOETaJaBVKIDnTVEpHT0MHNWSuvqE9JKI2AkefVcYcFXbFXocj/T2E/svCG5GLSeFiLTFjJnM1O1Z/o+JfRuSQvUmoYLzo6FHh6t8MpyzvKeuXRkzrXp/PHX1L6AiviDMBSugqym7MMHK86JvrDqxFRNYkrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:38:44 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:38:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v12 0/2] rust: Add support for reserving of ranges of IDs
Date: Thu, 12 Nov 2026 21:37:11 +0900
Message-Id: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzU7DMAwH8FeZeqbI+U448R6IQ+I4LEis0G4Va
 Nq7k67tVhSOqfyzG+d/bgbqMw3N0+7c9DTmIXeHcmD8Ydfg3h/eqM2xfGg4cA0abIv7HFtmk3d
 SoI4am1L62VPK39c+L6/zeTiFd8LjZKeKfR6OXf9zHTSyqW5uaUDMLUfWQmtlIsuVI6np+TDmm
 P0jdh/N1HPkG8VXxYtCoUiRS0FEVymxVW5RoigOiGBB8BCwUvKuLINFyWmWSxx0ihicqZTaKr4
 oVZRGo40xEESSldJbtd5LF8U0BFIxBRVipcxWmUWZoryyhpOW0f4zy24UX5UtKqCRaEwEzmrl7
 sqJdRuuKCjvj14YjSlVisGNMWDr6ss2yz5MJMcsBEn1zdg9HozBzU35KD/tvQtJecf+uMscup6
 +TiXDxyWJl8svWUX3CuECAAA=
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 304eb5cb-78d2-484a-7623-08df40b9e3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|56012099006|11063799006|921020|18002099003|10067099003|261102123227099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: hy5Aa2ChTVvb4EyT37R6GT8f8VSD1iph51UXguhHjt6iL5liWSmVePmv0AMatODhbngZdsFApHdshV/Yz6iQAeVtwXFNaWWKB4pHvfh9xMBb5Zx5Bf5BI2SF8l2/tAsfXZozlpNYwlzqWkoF2Q2P+p0vHs3312QZooikWGxwTFGcJBxk+aiS5/GECPngecbSd6XaDVVajur1KW00XS9DrQUaBf+keJsr7v92mJS9eZbFwvlDwtzio+Z2R9r62u1EWBAGLc3vo1ANt0GlDD7/q5gqs8PEiJDOiMxqAVBsIMNjNDpPYqX/NmHEMASTX+9olNwZqbchWGHJ4RZdE7coru0+ZfF7Qzx/BngfhS+TkOv0s1LJTxtdcP4yq6Mk6QLA4CWxYYNlVqjJJHfMmDxN1MZm4g64eEdNs0ikdhPts4Lf+4jhKDB3Q7K7qR1TY2g1/c4enGv9om2jskpWMyVY6Pso/0tiaUHZQbD3+bCQtn9Ft6YxZHZSt0ve+/kbRvnvxbk5cejQrsWutbul/Z9dh0NWxqecqWZ5Wmot5HqDAzhZh8JCRj5Re/k0IwxYJgOYi6gSpjO6c69CTIscij/+hRgqKgv8xcRTld+XTQ8Dp4U7yeUvTY7S+GT8H52FxzYcEBpIPB44zwp+dVVNheDXgLiOAM1116Ay2nmURSsxGQU/UEP7eV794UdiLnViEJTMh/kuiNRdKvDfnMK3HCfQ5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(921020)(18002099003)(10067099003)(261102123227099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BSa2VHR0hmNytJWFFwTTA0WVZtWlI3bzVpMEg4NXdEYzVsOC8rdVhHMFUy?=
 =?utf-8?B?R2NUK0VINjRHRDd0ZXlRL0ovNkorenliOERqVjBvalFrbGR3YTNtbSt2Sm9P?=
 =?utf-8?B?K0hEb29uVUFyRHVQZ0xtbTRzempIblRZbThtU2R0NXhWcE5vMVVaNEUzamdy?=
 =?utf-8?B?MUdwNk9hVUpQZTMrVnFhYThFelg4U21MVXZiMm9aN1hLdGtrODgzb293Q0xp?=
 =?utf-8?B?N0RtNHYzSFQ1WVNZQm5wcXZ5MExHcndZNkRJRHhwODdzRm12dFlia3h2Tlg2?=
 =?utf-8?B?eFpObFVWQ05kZi9xRWxyUitkQjdhcVozZUh5S29DU0kyWllWdEE5T3JmT000?=
 =?utf-8?B?TUhmNDNyZ20xdTRoaTF0OFM3ajl1VDhwNmI1WGtrSTFQQWwrbzB0cEprbTRn?=
 =?utf-8?B?OXZLNHF4dHdPUGhmR3JiR2dydTd5encyNnRTekc1NUp1Q3QraU9oWDdBK0tT?=
 =?utf-8?B?Uk80YXpzM1Nudk9VT2ZINlF4R2p2MWRYUFdFM3BjMmtWTUF0ZVh2M3Vhd1Fa?=
 =?utf-8?B?Y0lNdHI2WG1pY00vL0k1VEhYRmhXWUZPa0dQUTA1Z1d4aHJBc1NrS0VQWlA3?=
 =?utf-8?B?eU9HSGluK0k2YnU1U0xIc2NvVCtESmZsYmVsNFZHVG1ZMkkyeU1pMU5Rdis2?=
 =?utf-8?B?WWRqaGRuTi9PN2tDUjhML0t5d3Y2Skl4N0tXczlXdFUxUy9iQ0lKVEZjN2c2?=
 =?utf-8?B?VFVtOFd3VzM4WjZuVXJpU0RqTkRWSDhuc043WlZSY1B5MXZPU1RaNlFQcE1w?=
 =?utf-8?B?elN3eW1jZGhVQk50QkRLS3E0R0R4V1hCdFNGS2hGUXA1N2E2TXdYdGxlTmJW?=
 =?utf-8?B?Y2p5VjhaTURhNmgxcHJ1NjFtT1plNWZoZkZ0MS8wS2J2YWhYWXluV0doZ0tI?=
 =?utf-8?B?NlVKOFk3RjhjMDBlZW9Ldmp2NDdEaGFuWVVrNVVJb1hSZzAxWEZzbksvazBl?=
 =?utf-8?B?bWh6aVhCZDNseTMyaXBydk92VWIwVS9NU09ENzdmNGJyMHNvNDBudDAyTVRK?=
 =?utf-8?B?U1dXR2IrOGhSbUZLc1BQV2dBTnpLWEluNnQzMzc3TVRJWkM5b2VLQ1A5Y2Yy?=
 =?utf-8?B?c1VtR2ZxZlBVaDRwQXRoYWdZRlp1ZEswcGtCU0lOcTA3Nk1IRDF3NDNmNlU0?=
 =?utf-8?B?dGQrMEI4NFdscEhBbjhxUmRmdENFcUR0eDNCVDY0UEliTjE4WnU3NXp4Y1Bm?=
 =?utf-8?B?ZkFLNEhya3Z3bGJnN280WkFQdlBGazU3M0lyMVJRaTVrbFQ3cnJyZzhZVmZr?=
 =?utf-8?B?bTd0dEw2RzZ0T0NsdUZYWlVJbVBnVU1iMFo3dW1GVGZXc2VZeFdSTjJpOTlX?=
 =?utf-8?B?QjhocU1JdWk2SVBzbm1rTitPQ00wTk56ay9qS3BIZWQ2QUVzb2phbVpUY0xT?=
 =?utf-8?B?K1N3WWdsWjM2RzZLTC8vais5bVF1cnJtalZsRy9KZG5oNFAyVFQveDVlOE1V?=
 =?utf-8?B?dnQ2QVoxcDlZeU5DOXExcVVvVWpsSnBUVDNINExqcm1ja0FIUU5MSW1XMFJk?=
 =?utf-8?B?d1lFb0ZxYUt2eHFIanp0VHVoSG5pOHRvUVBjeTNsS3VQbUx4Q1ZlL2srWUky?=
 =?utf-8?B?YUQ5Ky9hY1pjTWJpRkUvOERhQm9QR0FZZytrV1JXUkZtUzNxSWdlV1c1d2tI?=
 =?utf-8?B?VGlFeWVIZWhJaGRscjVnVjZCdXY2ckpBaGppeE1HdmhpdS8xSi9PYUxpZUZi?=
 =?utf-8?B?dENlTTh5eWVpWFJQVkpWWDZtYWFuaHRGcjUya1ZmOHZRdUNlN3M0b2phTWRq?=
 =?utf-8?B?UkJqR3h5VUUrSWNybnVvSTZ5VFB6QmYzUmNUaE10NWgrYTd0VlFCak9zRUlD?=
 =?utf-8?B?MGV5dDlDUkFPQXhEeitWMWpkOHgzckdZRkFtYnkzdGdpNFk4cnJFT2JEbnlu?=
 =?utf-8?B?RHFSV2FvUHd6L1luOGdEb0R3NlFSNzFXODE3UCtpRjNPeFpTZFNCMnZ5SkhC?=
 =?utf-8?B?WXJiYTI1NTRVbHpqb0l1YjNMTDRjaHdWNXVBYlR1TjBPb0FWVVM3N2pFbmxl?=
 =?utf-8?B?dE5Hc3pVVzRRc21WbFZIMEU4M3I2ZFBuL0swMktLeHBlSG1PblUzQWxEM2tQ?=
 =?utf-8?B?UVBHVmpBNWtKcUgwc2FjSC9oVDVKZCswQXRYeCt4dU52VWIyZHFqZ2NBU3FG?=
 =?utf-8?B?NTdOd2tnNXVaQWxsY1BYUjQ4bmZUL0V4YURCT0dUVkJaNEQzMHZwRzRQUzJy?=
 =?utf-8?B?QklDV2ZCcnVCS2tOM0hydGhYRkpkTktGNUNDcy9tWDZhcVZOblFwNi9EUjZt?=
 =?utf-8?B?a1EyTnFxN2pER09KZVlRWmxVZlFzZ01ab2ZqK1RPL1pBOXJYVkx1NUNPTzFv?=
 =?utf-8?B?QXdreDA1ZkpXYUJFazQ4K2RRVCswclA0SW90a25DdkExdzlrN1hhU2NSTmo1?=
 =?utf-8?Q?0GjK7wFa502evCMAqteQ3mDUnGSprevoi/KZ5kqOPcfkQ?=
X-MS-Exchange-AntiSpam-MessageData-1: R/t+MGPCi9OBEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304eb5cb-78d2-484a-7623-08df40b9e3b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:38:44.5799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOsnouK7GZErzWS3nNLeM8ac1vUcZzOPmpPn4c/aM9U5KMW8NP2fEX4K+6dTwt8xJCS4tBC23hun4LOYDaQZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs.

The bitmap and `IdPool` parts from earlier versions are in v7.4-rc1
now, and this version has the remaining patches: exact `IdPool`
capacities and `ChannelIdPool`.

Channel ID tracking is needed for allotting ranges of channel IDs to
vGPU guests, and later for regular host channel ID reservation.
nova-core needs allocation of a contiguous sequence of IDs with a
specific length and sometimes a specific alignment [1].

About the tradeoffs between different data structures:
- IDA/xarray do not support allocating a contiguous sequence of IDs
  (ida_alloc_range() allocates a single ID within a range, not a contiguous
  sequence).
- A maple tree works, but is not as good a fit. The ID space is small
  (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
  loop (plus a Mutex around it, or new mas_empty_area() bindings) that
  essentially reimplements bitmap_find_next_zero_area(). See the maple tree
  version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
  [3].
- The bitmap API natively supports aligned contiguous area allocation
  (bitmap_find_next_zero_area()).

This is based on drm-rust-next.

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v12:
- Drop the patches that were applied to drm-rust-next and driver-core
- Rebase on drm-rust-next
- Drop the zero capacity part of the patch #1 commit message (Yury)
- Add reviewed-by tags
- Link to v11: https://patch.msgid.link/20261109-chid-v11-0-082aa9bf5a91@nvidia.com

Changes in v11:
- Rebase on drm-rust-next (pre-reqs are merged now)
- Split patch #1 by subsystem (Danilo). Just splitting with no actual
  changes, so I kept the reviewed-by tags on the new patches
- Add reviewed-by tags
- Link to v10: https://patch.msgid.link/20261019-chid-v10-0-67de9180b4ed@nvidia.com

Changes in v10:
- Drop the patches that were applied to rust-next
- Rebase on drm-rust-next (plus pre-reqs)
- Use a capacity of 1 instead of 0 in the grow_request() example in
  patch #2 (Yury)
- Convert the remaining Alignment::new() users in nova-core in patch #1
- Link to v9: https://patch.msgid.link/20260930-chid-v9-0-0d6cca376cff@nvidia.com

Changes in v9:
- Rebase on drm-rust-next
- Moved cv! to a separate series which this now depends on
- Reference Link: tag from the text + indent code in patch #4 commit
  message (Miguel)
- Add reviewed-by tags
- Link to v8: https://patch.msgid.link/20260827-chid-v8-0-bc74c77d0214@nvidia.com

Changes in v8:
- Clarify overflow cases in patch #2 (Alex)
- Replace nz! with generalized cv! macro (Gary)
- Add cv! macro to prelude
- Split SizeConstants and adding new constants patch (Alex)
- Move alignment size constants conersions patch (Alex)
- Drop NonZero on IdPool, fix grow_request instead (Alice, Alex)
- Add shrink/grow doctests (Burak)
- Link to v7: https://patch.msgid.link/20260817-chid-v7-0-a5872e64d8f4@nvidia.com

Changes in v7:
- Add nz! macro for compile time NonZero
- Implement SizeConstants for Alignment + add sub 1k size constants
- Use Alignment constants + nz! in this series
- Add final patch converting existing callers to use Alignment constants
- Rename alloc_area/release_area -> reserve_ids / release_ids
- Link to v6: https://patch.msgid.link/20260813-chid-v6-0-160be5dfb5bd@nvidia.com

Changes in v6:
- Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
- Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
- Add patch: take a NonZero capacity in `IdPool::with_capacity()`
- Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
  which also removes the bounds check in `ChannelIdPool::alloc_area`
- Add more testing of Drop for `ChannelIdPool` (Yury)
- Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com

Changes in v5:
- `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
- Only run overflow check on 32-bit (Yury)
- Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com

Changes in v4:
- Add `next_zero_area_off` to match C code (Yury)
- Replace overflow checks to match C code in bitmap-for-next.
- Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
- Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com

Changes in v3:
- Use `Alignment` type in id_pool and bitmap (Alice)
- Remove hang check on the basis that it's extraordinarily rare.
- Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com

Changes in v2:
- Collected Alice's Reviewed-by on patch 1.
- Address Yury's comments w.r.t. using __bitmap_set etc directly.
- Address Yury's comments w.r.t. following the C names
- Additionally check for an overflow case that causes a hang
- Added more info to cover letter + patch 4 w.r.t. channel ID allottment
  requirements
- Add align parameter to ChannelIdPool::alloc_area() plus an aligned
  allocation test
- Add missing INVARIANT comment when constructing UnusedArea
- Link to v1:
  https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com

---
Eliot Courtney (2):
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs               |  38 +++++--
 3 files changed, 232 insertions(+), 6 deletions(-)
---
base-commit: 6e557330b874b0e1fdd03e8fe4c438f36c93eefa
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

