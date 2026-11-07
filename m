Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73F606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MaR79yhJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6861510E5DA;
	Sat,  7 Nov 2026 12:58:45 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA75310E5DA
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 12:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NctionnnpC9UAFdNFzeLEpcfk/FoitFmMmBh3MMBlThwbouqwQoPELG9WdXvIZELUVKAhCH/pECtmRrdUtI5oHn1oJz0ANBMAlXwUfszMfZzOLSfcG9t2XdUoQ79LeHw1YFpZvJjONYu8f1k0WpSyI8HooeEu5xbXXD2ILdk8jYw3kMKT5cAQn/d4pL3FRgeJO+2NBAGpwSdLvnU09dxutTBF9Oj7GxKe1OJuSS31PFyoW9YJJYBDRWpMX8BYznmmng/LvzGnNyUET6rX2qygfnzq5F6R1/riiJutHTwVv9KABkxK3j3kuEKImNT3xZBiYM8NUx6uXyv4qBYMbNYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bJAOlWAI6k75ijwwNTs3FldfnSZVh840N2R0jB17xE=;
 b=SbzZmHtdWeeOBWdytoEKkVOCreRXiRt+LRCqgVPzVabLZeAQPsdxMCjtsYEOWQSKRbE9i2lB7yYTAearNJFkRFAfvqpQlJNfYhYWQ1VC+5WjZTNCgzZVIu7rWXNl+nqpj93OMF8/mIwSrlcUi0ECLietjwwlAB5K3KURjHMdl5mlgxMlEmoMX9NxSrfsNs1oEU0U56rnNqw0ZkFK3oeGMQTMnHyDdGjNpK/+MlxId7Ib+pH8zvwCCW8RuCZU+lzOmudENGKWVoPlP9hx3X+PRRSO3Ia95344ID6pCeBUbfrjnF+fUFW2w8RIGFMK9G43dp3XlJPKaBLwi1BKyogaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bJAOlWAI6k75ijwwNTs3FldfnSZVh840N2R0jB17xE=;
 b=MaR79yhJ22qfxCQ7ZwFlNQC0Bn3GTwKk1kfak1plzT3ur/v9wxIHB8/faGy41d/D2b8EHO57rgxBD8ieQDv171q0NqH+NtRJ5vnhsSOO3lfH+I+EpzP7c3PQR7qdx6shJ3yBwAfYNElJhtbnBNONcgzCn8WstSBeYEo3Bpihn5C5VFaW8sx3z6ZjgGc/3YdTuC90MznE2fKm+9qHcrMxQN8nOn74JqLDyAgSRRZKiQZCCzVbKZ2n8dTerQ3Eas3xx3dsRo6PH2Lt5//xZ38y1uvvPCmzozl0OxlJSCebBbY3rpy14+Gs4eAXc6sfybJ75RoR/XjxEf2ivzUDNjQJng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 12:58:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 12:58:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 21:58:31 +0900
Message-Id: <DMOZVVGB0O5E.1XLZHZVLFYBAJ@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v10 2/3] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
In-Reply-To: <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
X-ClientProxiedBy: TYCP286CA0329.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: aefd6580-e5eb-4b0a-d539-08df3cced4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|10067099003|261026140227099003|11063799006|261022105027099003|261028144727099003|261102123227099003|261009223027099003|261021123027099003|56012099006|261021121427099003|4143699003;
X-Microsoft-Antispam-Message-Info: K1Jt45I0PjNMtl+pYoGY8j1cbkqY5rwWi9dlEfA+lx8nppgcMUowz3xkYQvt0AcqcqzNthF+ImxXy5L3hG+NqCGpUNb+zA1hR1mLofK0UEYUSJ2bzxP6zAInSnpnuaPcLji/upoCc+UR9zmJfo+WS5d0S2ktB5bN03Zv2usFEe0eDrWlovwpSZWWault+a5H0N6s1fQTaT8F83+dvmVSCXOV4aFOt2P+AatBdFx4xXw86JFLwEcfxYyldTzZcfXjXTIRz0EAi8b/KUJIEfC20SBAf6P4vM26KQ6uU64g1zd2nHgAOwjHEYpUKEphJ/Sk3Xf3yBiAWAF3zOw7mpCBZyAAwO+po6T+pZazNLSD6LrMk3u8av2YYQIgbLRN+LT1jOR6bfyOsyLT44UTzRZeti1/DmJSOfnLlbU713nhF12iNjkQPKQzDFdCCeXDzLr4NpI1VaxLunJ8syYIGu8ALtKnncxsWxWsmGXfD6lQpUAT2dZsqdxlxExxeqLFxvpSTob839Dw+lxliMs6yugvT1fl2mIm6RCA41QCkp8N6d6uLZ1JKpaHYJ03Me4IavIT167Mc+fGCWWsJjBke85DLaYILAcTvq6xtFU4fd4siR8C3g3W7WXrd1pj7attE3AjrfK7y9QBGEGGyUQzXLZDBKRcuZLMK7qul995X9fvRco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(10067099003)(261026140227099003)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0oySHV4b25Md0kwSE9iSTd0Y2ttZ2M5d2xkVGRxb0tOS0FmWTB0c1RzcGtF?=
 =?utf-8?B?bnJmcUhlRXFhL0Y0OEF0WUVBL2dDMy80UnE0d3FkdlZTelNSN1B6QlVTK0xm?=
 =?utf-8?B?YmM3REFGbmxwM1ExYW1MelJuUHFRZkxKWnN1U2dXajB1c1MrUndzNnZndjQ3?=
 =?utf-8?B?dG5lYVhmYVBWeGs2emgyNjlPajhwQVlBMEl4dW1GZkVQYTR5UmpUeHlGaGtK?=
 =?utf-8?B?WDJVNS9TcDZKYkNPSWtyY1cvSnNDSjFITmhYdnJ5V2hOdm9xeHYyUEV2ZURU?=
 =?utf-8?B?M1ZpRm5TQ3QwK015VnRrQ0twWHkvQ0lvKzlveTN1VGV0eGhKcG1Md01aQVIx?=
 =?utf-8?B?Z1M0VElMZVBtZTBNM0pVaFB6UFl4aTEwMnRtTnlZQjV2aHljbTNWb0JjK1Rh?=
 =?utf-8?B?L1B1OUE4dW8xL0xpejNqUk92NEtOdUpsV0Urd2ZpL2hQWGZWTkJZV00wS2xH?=
 =?utf-8?B?S2tLbEpuRWZLaWkrSGdwUEFvVXU2QlZNZUxWRFhQZHpIN3h3bTk2Q2tiWG5z?=
 =?utf-8?B?NGROb1E4Y2FnNDBlMlFoNVQrQk5aYUlsdGt6RmJhbGlQNGV3RnNHdXpFZ0JD?=
 =?utf-8?B?YmxDR2FodkQvZ3FNNVBuNENuQXNlZm91OTlWeEhXM1BYQ2FXdlBsWkJ5aFox?=
 =?utf-8?B?RktSRlUxS3lQSDM3UXVaaGxsbEpsRktZWHR0Zm9ibk00UklXR0hkUFBHOE16?=
 =?utf-8?B?SEZsRzJOa2dUcVd0RHQzbnJOOHMzTnNpbmhwT3NJVTNTbEpSU3NQaWV5M1lC?=
 =?utf-8?B?U2lKQUl1WGR5QWdFTXdlNGNoOXNGN0dEY3lZanR2T0RRUDQ3RWxqeldsM3VS?=
 =?utf-8?B?Z2M5MzVabnFvcU1TUXNVeTJQOWJ5bEZjR1FLWnkwS2dTVGprUktVbXRNSXhB?=
 =?utf-8?B?bTdzMlBlOVpHWnNWOTU1VENuYTZnNk5rTldUOHR6TXlOQ0xmVkgxMkFWR3Uy?=
 =?utf-8?B?aW1QSVVwbEdxem9PaHp4ZXRPY3g0d2IxN0M3L3BoK01Zc05pckN6VHM2T1ZX?=
 =?utf-8?B?T0NuMUxkd1NpSDZFdFUyMVVRUFkvZitzYnFiSE93a0ZUUitNODNzUkVEUGx6?=
 =?utf-8?B?QzBIdi9uWGpUWHdjWjc2RWpIdCtRWkpINFlmZUZpOHhUazQrelVpS29FMnVq?=
 =?utf-8?B?N3kwUU5odEIxek9NTEdSM2h2QXNUTmxubzZQckplVWtoRm43T2pTU0NYbUdk?=
 =?utf-8?B?bHZHZmM4Mml6Mk55bEpnQlVQdHRvYlhUK0lKbFJiQmhweFBmR3FHRUlPdndl?=
 =?utf-8?B?Z1EwVjRKY3NGRWgzWmcyNW5SdFBNWFUralFtekd6TGJvU0g3cnVpZkh4N1Q3?=
 =?utf-8?B?Zi9xRENuY2VkNnVGT0cydU9jWDh6M2d1TmsxVnZnZmZyenRtNmYvWUFsV3hW?=
 =?utf-8?B?S2hkNmdyK3lGa3h2RWZwRndwZUl6Y1psWjdtYk5ITFlZSEJta2xDZjRmK3hp?=
 =?utf-8?B?MllQRlJjYU5QbHI5OFdTUkxHNjg0cUJZRkFycnV1RUhvcVdKNFJTRC9MaENo?=
 =?utf-8?B?NGR3NHdseDJ1T1VZbkc0TVRhWVVHb3JCREM4M3ZPSzlJNk5LdkJlNjA3WUF1?=
 =?utf-8?B?Lzdrc3E4S1dFNU1rMzdDQ3JCait6Y0lRU0JEcnNMSU9qakQ5ZEYvYXN3YmZR?=
 =?utf-8?B?dDM2Q3diRHo0WXJLOUZxRm84YzBwQzFLbEcxdU1jWEFzcW5USnI5ZmZJSWJJ?=
 =?utf-8?B?Q3NOM2F4UW1wUFJycmEvNVBIWjU2Z1pjM05COWxGcG56alJmRVRKTlVOc2Vh?=
 =?utf-8?B?ZktzbGVSS0hycnRWbHloRTBCOUhXRTJsOFNlRzAyU05QZ045d1pzdlhLNnJa?=
 =?utf-8?B?RWNNdjBZWE5HZ0VEMkt2Mk1KS2d1UUlwdDUwaXZKVnlISFBjSGdIdXdtL3cz?=
 =?utf-8?B?dzhtQjdFVDhIbnhwTE5qemU3Snc5UzZkMXErVkdJVHF0VjVheUdlVTJuWkdC?=
 =?utf-8?B?aTEweGRMeE5ud2k1cG9mclZJdGI0b2FYV0ZvUWF4MWlveWVmRkdqYk9mc3h6?=
 =?utf-8?B?ZHJ0eFZoS3RkQnlhQnRYSTVzWVdtQWtHY2U2NDVFL0lFOUZGUWlzdkNkMFcy?=
 =?utf-8?B?QXphMmdiSTBNZlN2UHdybnZ3KzZqSEFlM2pwU2pOdkNOU1IrNmZLeWpqQmx4?=
 =?utf-8?B?ZG1PcTcyM1d0REQ2V2VyNG5WN0NLME1lQWtlNXIyQ2owZDlWNGtYNFFOSWxt?=
 =?utf-8?B?VXRoRFdFUkhkWUQ2Rk1Wa3pMaDM3ME0zeS9wcTN2SmllSUZHVWM5elZIUjdC?=
 =?utf-8?B?aGNhbjRDN2dXNzBHcW9qeHFac0dPcTdoQ05YNUxtdjQ2TFpOUEdjSy84eFpT?=
 =?utf-8?B?YmJBQmExV3NOVW1jWGtZNDRpTmJGd0VQZXU4RHdDcjJSa2dqNjhHVW9FVlYy?=
 =?utf-8?Q?alB4PE+hPQuqjHJMVQLKtxTxJgVo1vLH+s1WNhh1z/N8f?=
X-MS-Exchange-AntiSpam-MessageData-1: YBj6Poe7LGJgCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefd6580-e5eb-4b0a-d539-08df3cced4d9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 12:58:34.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wT0ZEXyIBiE0SutahF3KPDjdw/0RXUxkHrFgBumxkH7QqMnr5ItZtQ8dOOLGnU/6snnY2zNUX3xtLgiMX23UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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

On Mon Oct 19, 2026 at 1:29 PM JST, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
>
> This allows specifying a real capacity of 0, which was not previously
> possible. This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)

Alice, Burak, Yury: I would like to get this series out of its current
limbo. AFAICT, Alice and Burak are ok with the current design [1][2],
and Yury's request to change stop using a zero-sized pool in the example
has been fulfilled by this patch [3].

This series would need to go through drm-rust-next as we have
dependencies on it for the 4.5 cycle. May I ask for an ack on this patch
to push it through drm-rust-next?

[1] https://lore.kernel.org/all/ao2U1jNaT7waibJW@google.com/
[2] https://lore.kernel.org/all/CABwQupOYBBev5WkQry3oOoX5tGCs-ggDE4L_nK8BBY=
vrO=3D81bA@mail.gmail.com/
[3] https://lore.kernel.org/all/DM62T4RN38EX.2RMVNDEJV9T5U@nvidia.com/
