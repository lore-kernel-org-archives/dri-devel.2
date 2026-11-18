Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB12606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sg6SYXcd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66AB10EC61;
	Wed, 18 Nov 2026 18:07:13 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FA910EC61
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V72AzXY55QhlYXyTdu1GDAG0nDBU4JUZQiWVguvRygAQg9l/KPKxxD/pXUNG+HvTtqzzPgpPv7J8xN82872K0NyafNDkZ14zj3BSBtzFgGLa0JtMRX7X17vlbZ/XBUQgLgmaygYlm+xGRmekS1QUKHE+o0wlm/nD8mCNfc6MRN+nOFP4U7zGo3TU+qvxEniNo6kPy5O4M9ZIwoF0ocIcQ68Kbirg3A4qTzMI0WQriBuXo91qi+TEtEA/Q7Nh/YetJHBGchQXHWp5CQzgSYkU/AbdH2wyEBOY6JhcjGzMEmysWox3ZAK7tQHHSKpT+t47J/dHP9zKTzCYqdnH5Me/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G1U2zVeKSuKE+J3Aiabjx6y35FJ1RFEgckcOHaqURU=;
 b=iN4M1n1OOSc8qs6PdcFKgdLyRo8J5w/gbR25x/j2z89k8z6homR5PB7LOC3rHNS9l0jXYO4GvJ/UUkTAOIFycEZhmSMvaC2j0FZPgpbsa1vQLovehSqh4HKhqIxtqqpFdPnF4P62w7cO28AkrvlNNOTso3qODKFV2AHrTUzmHJ6WhIQqRT+muP182VdOIVBBCOlrHKuLADurdco9CpLCHrQmfYdgH5GRM5veRtfYtvBPPyk6qr4nBqPDQicF7NZ5ArQGVqOVI0XKMBUyUjq9yNKAea55koUiskaYO2Yfps6hiUyCCl+fRfmY+tUd7lbeRJhRdch+umOJEPz5nAIdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G1U2zVeKSuKE+J3Aiabjx6y35FJ1RFEgckcOHaqURU=;
 b=Sg6SYXcds3+BMHuA/VRRH+lD4Hd8qIqQ6SrX5TgQyLlaFdOV964tM2/bWGPtkCf2Z5jsnGULHQLTFFYEZJssmKdLyMrTXYB7pPTEO1h47govVxhR2/h6+8Iw5frTdunUPVEV0BZcCmm+1t+zF2ouDK+7fhW1UsJLCJv5oH4NHVkSC8M/ZuNCWxgWSqz4nUGxkb7YB2dywfPfHWjdYUcefiRpDC+SgelhnuJk4LxFLtyluFTXS8RhqWojv05y1EoK0yw96U2aJ8qaIjxE1QCBdWuMOAGzO6W+9PQGlaLGlPuBjsBOUDqvi5mRxgAfGIJXCvuRQCdsd6laSUSZCLl4zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:06:59 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 18:06:58 +0000
Date: Wed, 18 Nov 2026 13:06:55 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 0/2] rust: Add support for reserving of ranges of IDs
Message-ID: <av3pKdesSwpPYnnq@yury>
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:408:fc::25) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: ac085a08-20a4-4729-3411-08df459ebc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|18002099003|261009223027099003|22082099003|261021121427099003|11063799006|56012099006|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022113327099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: +Fq8dVT2hQ4zEU4/QyQzeGArPUTuIfl3Pe0e0ypthXpOUiuVI8zSE40hndRX5hm3IWsXKa80Vp6gt4ueBjrRRySPkPmHIkCSOhXoU8TQLMlhOxfVKId0aydOaN5isAScyutLJvqVWbKnLz6LqeLaWszUZMgSiVgi0CSr0d0oHBSdBNyN9RFZncdnfJfLkpjAiW+1tg1z5T/NzIPBG3hsNSFaJxlifQSiTYemDMt6SEMELkwgtf4iccTBtxZUIlKbxwgyj66JaAjhsQ/9L2jG0aeYinakgNoO19GuUWTixmeqa1LjEwT2I0hlMd+HFF1ku4ikdKlGrp1QoVpIalr9Nk/zuSKdlWG83KWcRY/OCn4Ol9lrLRGbGVZSmMDKxn3KzvhC+FWi79AN5mVaBS2ZBPhZtVLDosoMEg3rXcalDWohAt3Zbzncq4iWhxfpZItLs30hPHYwXsRhFoQdq6fZ2EJIlWlX2NUzsis/8yiD/+9esy4+EslKoqLchfEV9d0TvkAZbiVMxwU8K0qlA2OKRsjWZ4SuY7yKa0LLomIS3kaVYH/VK3YBS74Ym2ANexohFgObasmuk2tzxe1muEddZx7KtWlqUP53Xoi2KhA3EKG6y0OYI6pcQgGnKfQeKNBatQjGX6h9DJ27iWrwirkX1KvI36x2103Etn9M1Yghqjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(18002099003)(261009223027099003)(22082099003)(261021121427099003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022113327099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1Y/iYoVHhKpU8kDYKYjhh+nbnLdBq7DhkixyOuI++rtnhdbeTpVcsJJceCv?=
 =?us-ascii?Q?dpmrqYLsEKMTBQthRsR1s/njMRUevYszK8qHsg9tS9Q3jfYot3+smPYNAhT+?=
 =?us-ascii?Q?xYGlEIvPMzOJtGPqhruKShGabP32XgHXt5f/i5s5l7uGmNvVpnePFei6EQil?=
 =?us-ascii?Q?W9OJ5XA8WZELru8NwFo+OB5XH3C+gdMYUrA13a6ftsw9rbYic7snUyNhmces?=
 =?us-ascii?Q?MOaP9DbcGLqN9nNwMJkrvu5eC/FSLv8FOeu4joC4YK7c3ZPpbciZkpmbAII2?=
 =?us-ascii?Q?Mo7Kkj5fpJKxwArU+tkZuYaNT4pWFp4UddxS4vvItMzYWp7ARiQgYXc6cjD+?=
 =?us-ascii?Q?lkj7PbWp9bbSoo70Awtu+rCqdqbE8bwfPQqQHIQkU0JyKdCU8pPl/4HkfMq3?=
 =?us-ascii?Q?XPUI/wTlJDOfQ5SVYE5tAXtrUJh088nrq9fRrVj5ouJ1tUVjcH1D+N16b6l+?=
 =?us-ascii?Q?mkT2ida8a6KURFfcjYpnSWvc5zsd9DfVf+i1Ih16vMmUKSoZQI0cocCBes/E?=
 =?us-ascii?Q?T19tKMkzA/OKlmUO4KhZtRDuxO/tuImRwgEQUtCQlMWtY0wRS5y8tOUkt7dA?=
 =?us-ascii?Q?EvteWWIsUF+T6xI2LitLJqw+cLi4VFAUO0gkHaI0oKUP0WGicyp/8kUpj3mq?=
 =?us-ascii?Q?W5z9QyVwXXc04PmMqf+XGLnjcXVlTOJs3hoOr92sFPKtQ7dpduFyRiLA8t6O?=
 =?us-ascii?Q?b4R8MbFpUtS3JpU2o3MWj6+nehg+J+hw4hFaFzjwHBnFog4gTxDnGkunMVCh?=
 =?us-ascii?Q?FkJDkVyasUVCgG8nxbLLlZTiVmjqFRV6EPJsMN+MBLUfBnCe+A/31vViUemY?=
 =?us-ascii?Q?2X9v8Jvcw9Hmvj9LDq6JeLZ2Pu07m/d2waMRxetGTUb+8fkPP+HCblgDTIvx?=
 =?us-ascii?Q?NNySxEsriLE3ZjRPBfvcFULtgT85kOs95x2BpeZ3twlZ6CbXYF6Zb1274t4S?=
 =?us-ascii?Q?1MwVg3/NXfc8rABUhTdleTkfaapdMka1voQZOusbB9pvZTg3Wi0Er2WWmmmj?=
 =?us-ascii?Q?RgSG9Z/KHJL7OFrZ8F/I9Os/JGGZMhvPYMozUdEOgWoT9XFHxyFJcmEE2fIo?=
 =?us-ascii?Q?7s8kRH7e6fl/gNIIlEhfw9BTlEEmWh1VvEK5+CObyyPmnYQL/2bCNEaQR+1t?=
 =?us-ascii?Q?I8/+LTDveoICdAnSvSDGNAMggFmXMVxTZhuVip+XZ2LZXQay/FFDmyilaueh?=
 =?us-ascii?Q?kaaOS1Exe8pCePfo7pYGV2LXbvsav+oGukSH2dEgBhEYuqK/YAFlkgEmk8G7?=
 =?us-ascii?Q?RZD6k4og/vyaTbLR32TjmA5GU6iLxSBFpUgFd9nGKh1z8I6Xd5cm0/fRMZD6?=
 =?us-ascii?Q?bS2Xq7jI9vyTS3Ls2L6q2JYQWWQhmThDgMkYEaWjfwzANZKq52tSjUBqVZKH?=
 =?us-ascii?Q?l5Dw7ZWa6nFLCCAlHW+J3xeNK0VFKO0Ae5SFpsSyzobSng7NkiJ3q7ITOOEQ?=
 =?us-ascii?Q?t2ULn+kIt/DWy0teKwSKTJmY30MEukw+lT7cX+gL9KZbqgLt+btALNiW2ICV?=
 =?us-ascii?Q?u5CTSjvUX2tTPvfVJOMnjVAy8tX5a2OdUr7QXFG/6vHeSCQcwlelqAlCDHrl?=
 =?us-ascii?Q?61H9YjkU39KHZ4qh9HmWzY0KzO4/6WfGcm1LRoUTSeQ7xkRJ3d3SoHOSP4/i?=
 =?us-ascii?Q?0bIWG99vJbAGMLCt9NiuGdAdoi0Qsvfmqg+kuZD+2lJsvNr3SWcLJwvRds0I?=
 =?us-ascii?Q?d0yu2s9duoewsnPjLnOSeWyqit1nPE8RRILYYFJg0y9jXoDsov/7j8RuAt0D?=
 =?us-ascii?Q?ar49hEYsh5QewCxoLLSm2Joi6fE2bGSmvxpRObV+hhzFrER0PPBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac085a08-20a4-4729-3411-08df459ebc75
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:06:58.2966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7FIaVcNRwbM1a6i/oaGljjtyNMvDLJBkh5SN6bRanKf8e5rEJW8qh5BEANUYoPrPIbfkJMurtGUQ3T2dHgp2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

On Thu, Nov 12, 2026 at 09:37:11PM +0900, Eliot Courtney wrote:
> Add support for reserving of ranges of IDs, with a usage in nova-core
> for channel IDs.
> 
> The bitmap and `IdPool` parts from earlier versions are in v7.4-rc1
> now, and this version has the remaining patches: exact `IdPool`
> capacities and `ChannelIdPool`.
> 
> Channel ID tracking is needed for allotting ranges of channel IDs to
> vGPU guests, and later for regular host channel ID reservation.
> nova-core needs allocation of a contiguous sequence of IDs with a
> specific length and sometimes a specific alignment [1].
> 
> About the tradeoffs between different data structures:
> - IDA/xarray do not support allocating a contiguous sequence of IDs
>   (ida_alloc_range() allocates a single ID within a range, not a contiguous
>   sequence).
> - A maple tree works, but is not as good a fit. The ID space is small
>   (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
>   loop (plus a Mutex around it, or new mas_empty_area() bindings) that
>   essentially reimplements bitmap_find_next_zero_area(). See the maple tree
>   version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
>   [3].
> - The bitmap API natively supports aligned contiguous area allocation
>   (bitmap_find_next_zero_area()).
> 
> This is based on drm-rust-next.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
 
> [1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
> [2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
> [3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Maybe add this links in the commit message too?

> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> Changes in v12:
> - Drop the patches that were applied to drm-rust-next and driver-core
> - Rebase on drm-rust-next
> - Drop the zero capacity part of the patch #1 commit message (Yury)
> - Add reviewed-by tags
> - Link to v11: https://patch.msgid.link/20261109-chid-v11-0-082aa9bf5a91@nvidia.com
> 
> Changes in v11:
> - Rebase on drm-rust-next (pre-reqs are merged now)
> - Split patch #1 by subsystem (Danilo). Just splitting with no actual
>   changes, so I kept the reviewed-by tags on the new patches
> - Add reviewed-by tags
> - Link to v10: https://patch.msgid.link/20261019-chid-v10-0-67de9180b4ed@nvidia.com
> 
> Changes in v10:
> - Drop the patches that were applied to rust-next
> - Rebase on drm-rust-next (plus pre-reqs)
> - Use a capacity of 1 instead of 0 in the grow_request() example in
>   patch #2 (Yury)
> - Convert the remaining Alignment::new() users in nova-core in patch #1
> - Link to v9: https://patch.msgid.link/20260930-chid-v9-0-0d6cca376cff@nvidia.com
> 
> Changes in v9:
> - Rebase on drm-rust-next
> - Moved cv! to a separate series which this now depends on
> - Reference Link: tag from the text + indent code in patch #4 commit
>   message (Miguel)
> - Add reviewed-by tags
> - Link to v8: https://patch.msgid.link/20260827-chid-v8-0-bc74c77d0214@nvidia.com
> 
> Changes in v8:
> - Clarify overflow cases in patch #2 (Alex)
> - Replace nz! with generalized cv! macro (Gary)
> - Add cv! macro to prelude
> - Split SizeConstants and adding new constants patch (Alex)
> - Move alignment size constants conersions patch (Alex)
> - Drop NonZero on IdPool, fix grow_request instead (Alice, Alex)
> - Add shrink/grow doctests (Burak)
> - Link to v7: https://patch.msgid.link/20260817-chid-v7-0-a5872e64d8f4@nvidia.com
> 
> Changes in v7:
> - Add nz! macro for compile time NonZero
> - Implement SizeConstants for Alignment + add sub 1k size constants
> - Use Alignment constants + nz! in this series
> - Add final patch converting existing callers to use Alignment constants
> - Rename alloc_area/release_area -> reserve_ids / release_ids
> - Link to v6: https://patch.msgid.link/20260813-chid-v6-0-160be5dfb5bd@nvidia.com
> 
> Changes in v6:
> - Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
> - Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
> - Add patch: take a NonZero capacity in `IdPool::with_capacity()`
> - Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
>   which also removes the bounds check in `ChannelIdPool::alloc_area`
> - Add more testing of Drop for `ChannelIdPool` (Yury)
> - Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com
> 
> Changes in v5:
> - `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
> - Only run overflow check on 32-bit (Yury)
> - Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com
> 
> Changes in v4:
> - Add `next_zero_area_off` to match C code (Yury)
> - Replace overflow checks to match C code in bitmap-for-next.
> - Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
> - Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com
> 
> Changes in v3:
> - Use `Alignment` type in id_pool and bitmap (Alice)
> - Remove hang check on the basis that it's extraordinarily rare.
> - Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com
> 
> Changes in v2:
> - Collected Alice's Reviewed-by on patch 1.
> - Address Yury's comments w.r.t. using __bitmap_set etc directly.
> - Address Yury's comments w.r.t. following the C names
> - Additionally check for an overflow case that causes a hang
> - Added more info to cover letter + patch 4 w.r.t. channel ID allottment
>   requirements
> - Add align parameter to ChannelIdPool::alloc_area() plus an aligned
>   allocation test
> - Add missing INVARIANT comment when constructing UnusedArea
> - Link to v1:
>   https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com
> 
> ---
> Eliot Courtney (2):
>       rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
>       gpu: nova-core: add ChannelIdPool
> 
>  drivers/gpu/nova-core/gpu.rs         |   2 +
>  drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
>  rust/kernel/id_pool.rs               |  38 +++++--
>  3 files changed, 232 insertions(+), 6 deletions(-)
> ---
> base-commit: 6e557330b874b0e1fdd03e8fe4c438f36c93eefa
> change-id: 20260608-chid-18fa943c6d6c
> 
> Best regards,
> --  
> Eliot Courtney <ecourtney@nvidia.com>
