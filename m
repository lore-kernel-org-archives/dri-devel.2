Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C41FCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76ED10E6E7;
	Wed,  7 Oct 2026 06:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZYkWUUM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A1F10F081
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgyvtUcXNphiubtqbbvGYtIAp7GyKoqu2YkRlBxHAhnHFwgAqfTIgCkrEpFw5e9cJHl2jHeYU50EBl/0/0rD9OZNCZrghVPLKmDJ/h0dfDJpBUSN1qo6MDWtUdlkH9RTkZ65AUkmcwiUAGKdgNQc5FBHAbmspARFET3H1muFM/9F1n3pc4JZ23nY6pAwNv7lAz4Fau7/KzS3EkA6e9KUPO7B+TG+LxG0t/IV/UMKBas5fTjUBtLJZE840ZiF1ffyhaOSlmsD3F4C5IfNVE6UUogRXFIv40/OYTiDsg43RAKfnj7xewrLOU+VPiMfbzZZVlL0gzAiCGxSRSzQksGbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcVXVHJ5ULUVZEIlAG/RY5gyQ2VYuk7OaJyJqJgV8zE=;
 b=d7HcvPru9jEgBodV3jWi9xctdVZyZUQGRA1LAVMM+wck79LoHmxW9JHsld3tACSVg8N7KSqMALgviQpbIcM1vVsQS/qqnQt+mxyV72Zhhkh+pDaFrFTbo9Dj3hDYEUYJV7DYQR0VxZ1NGn1VRXrTtOhJIuB8Bkt7KlE/l5VTwTInmjM6rpFtH5jDXsB2uXee6r752tuX4MvmFiOmI7bYcM4s0DbKbvw/xjOmhGJSIMVl2OkX6gR+Njy/KwvFA1J0H8DHpdi79mU8zVIiuZxFcZXMAyaoW52+P1wC8Fjbox7zxyzGijvRo0WabuDYKzztcxyEe1uYgEdtxzX1EPeNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcVXVHJ5ULUVZEIlAG/RY5gyQ2VYuk7OaJyJqJgV8zE=;
 b=TZYkWUUM/8GndpXzQd2MuALs5+BPxNHzZprTCms24Chn8TvIjcmEciQ2D/Gq8nE5gqb2oH/SgPSOYc/R7rYzHOuPX3q0YlUg6LKRoOHjw+a84Pdd66n7RSjTCQHljPuGyPO4ot6d+UKgTCqBEdfBkRbqk2OLMu5yUPR3uVcSRIYDwzJ8rJHpadyU7uydpMRqz6w+0nVfBKuNDoMlIUX7AR+Th1fQn8PK7KsFBTUs/q/fKId5PE0jhBoa0XEi2u1vW9RVLUkbenF7/TDntBrMHTc5IYx5KA1Tea44O6gNuZ3USF6dMeFaJdKp4ao8zjr030Z93udVOZlkCegsS+ULEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 06:30:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 06:30:07 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 15:30:04 +0900
Message-Id: <DLYE7KKATCU6.CUH7GIJJJ9PW@nvidia.com>
Subject: Re: [PATCH v3 6/8] gpu: nova-core: add NVKV typed encoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-6-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-6-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 719ec886-8f37-4068-2a3d-08df243c6de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FnP12N6MwDU9npHXhwqY5zRCOnbKCjvZ38kS4AOlv0O5qJD2nSsuen6+9fqgSgVuVbhPGFSzt5zqNZY/ZnpBrBo/MDUsHgkG8TzgEessC9vTqNKNFFhpgwlreOy3TDwIjXh6MWSjFqDVLPSqyoBtPAHQpjtQP8bxueYTn6rXG5WNp1LexKerYOACNOdj2vn42fdO0kRbUfHXdmD55ahmTqD9LTPrqi19P7qR+HzyDWWUKhF25RS+/4R4Vg6yB+fka9KeP+e1ykVtUTCi9BaMGsZNB0LpxA6Jtyi8j7s4LSCnZxeqM7y9MPLRGK5u+P1q/0zoUFiibhBymrIanmJrsiXrIfqD1/jqWIHqZX/RUVJ/i4dg1lt68kWiZ+R43UMSZPPcUW3Hb2CM0gWCpzfi4+DTtcxXAqegT4UBYBHihNTzffjZFkiUV2sVUdPhLvG8xhQCViKAQhGN1QnGC0mjWaElTDwBsfNy9uH69C93cPIYjIzVv7bQT5TtJfeTPLPzzz+nsnB3ds1C4JHZmw9+lKdugIJAzPgwRxTEOGxz6MrWhxF48rMvJyHy/IdK2cYHUi7dgjlsuxMSJBBqnTmpHRGYl6GtBalsBaxLwHy6peoYCSLyPUQ7HLkx/bp/VSmrdj+WmaPuhWG38eT0ESEmgV2Mct92/dxwLXCHsBHg2qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJ4TDFIcHhGcW1FU2J3MG1NZlR3NUFWeHN6OVlqNlpkVmRPMDBobk9MR1lh?=
 =?utf-8?B?Qitia0ExWDNmaXJ4eHZnYitnUHdPT1hiSkhGWjhnQ3hIWWFZWm5oMkcvYVZw?=
 =?utf-8?B?SVpRdE1MNGYzVXVqUzQ3UG1IM1QzVk1iNlFGVmF3UWVlSGlCWUQwWkN2N1dw?=
 =?utf-8?B?b29yV3hLTzN0RWYwcXhRYlZLRG1HVjRyRU9MdGYvREljVHlyRXBLYnhmOEtq?=
 =?utf-8?B?SGRIVXZxODNpUjVLRTFZemhxUDlrRnlZYW1wMVN6L3pEbWJ6QTVNL3NUVUlK?=
 =?utf-8?B?cEFWbzFOcnFLbC9jcDdvMUlQSWRmMnowajBTeG5tcnMxdXQ0Z094NzgvN0xO?=
 =?utf-8?B?Ny9ub294UmVrQVg0bUlyd1RXc1NCRDMyQU9RcVBqL0JhZDlHNFgwTWEvNndD?=
 =?utf-8?B?emdMK1J1a0dHTVF4aCtYSmg5VzR1Q29VNWh6N3dMQ2FzV0VDL25uWlFtMktL?=
 =?utf-8?B?YU5QQzNLdlUxTHlTaVZLdGlEaXgyaUI2aDk4R0ZtbEM1Z0ZRSlBBZWx0ZGd2?=
 =?utf-8?B?VFdOL3AxREZ3eXVLc1dPSW5DbUQrQXJXeE03c3Zib29LVVZPT215MDM0WHBq?=
 =?utf-8?B?YmlBai9zRDI1TTdyUGNUODJZbThRUnQ3RTdUeHJGMHpKNmRQUjlnVDdRdXNy?=
 =?utf-8?B?bUtjYVhGUHg2Q0xhZkdlSmVYN3dra01zSi9NYW9oOFpMVnAxUGxTaWh6YU9U?=
 =?utf-8?B?dzYraytWbXFzN2pUKzFLQTI1d3E4OEhwNHpyK0Q0NkE3VDNJdG5tR2dYM25K?=
 =?utf-8?B?ZjFpVHE0TmJoMnIzVGRJV2dMSjM2cXNGbXRwcTFvZTJhNlhRYmlmZFRkbWFj?=
 =?utf-8?B?T011WVNwcllZYld5T1IwTkF2enU5RzF1NmN3cW10R0dJOGFaZWdGZzBZK2Jq?=
 =?utf-8?B?eDlVeW1rRW5jb0RTcm1QYUtydG02RWk0bkIrOVdWdmhmZkpDWmRvd1g3bDRo?=
 =?utf-8?B?WFcwOFZCamNnNlBiTFhVUXBsQmZHUmQ3OUVjWktJb3Z4K093aEFyV2RmbjJN?=
 =?utf-8?B?M1JsL3AyTTlxZnBHOE5WcC9NWG1xZkVHNEJOeGE1d2hMWkRmU3RLbmFvWGZw?=
 =?utf-8?B?N1Z0cStVZGhncklhR1hHVFh5WUhPMmdaU2xmUzlOTmQ3TWMreE5tOVdPMTk0?=
 =?utf-8?B?bmNxb1BwbnVLdVhNVlViUTVYREZnQW5YOThVY0pyTGtZQUFtVnA4NWV1UnEx?=
 =?utf-8?B?RlRFd29Lai9KNUpkODZDejBvaGVQcXhUTEFYdXhpWFJDY05DNzArV01SdUds?=
 =?utf-8?B?cHdod2pRS1E5Y0lmS1M3czRHZkxkU2U2UnE2dk5INndBcEZTS0E4dWZFRlRQ?=
 =?utf-8?B?U3ZBK1N5RkJzT05uMmFSTHhaUUtqMXlZbUZqWjlrRmVLOHBob2xjM1NROGRz?=
 =?utf-8?B?R09nQTE3UWJqS1BwajhRbXFpWTNkQnhaamxSRmkxa1haM1NzK0t4aHpieWxp?=
 =?utf-8?B?S0tRSE5LTmVxUkRIdENua2VqbWpJWDNNVDgxbzdNUGR5Uy90UkJsUEhNTkJI?=
 =?utf-8?B?c2NScGtySk5pMEZsU3dUZUtJbS8xMzQ0b1I0STdRKy9RaUVXc1VxNWw4ZVE5?=
 =?utf-8?B?bGNkbWx0aVBWRmdvdE0yQktMaWp2c2lyNUNqdmEybDFsZ1JNUUVSWTEvdXFz?=
 =?utf-8?B?VFhST3ZwbE1BQ3hKb0E2dmlCSDJRaVk2VmlBTG0wWkV4ZHJpQmlIL1NiVWRY?=
 =?utf-8?B?NFVBNDNHeHJLN0VTTktEd1YvckRYL25pdmZ4cUk3MEQ2dXFYWFJFZ0hRUTFU?=
 =?utf-8?B?TDdqS1UyNS90ZkVPTm0yWTNmdFhHbTdwaWF2dmlFdEpCeEtIK01FYUJxQUt1?=
 =?utf-8?B?ZGl0SFNwbitNb0lnZk9WS0U2N1R6L09hQ3FFNVp2ZTBSbEV1YU1QdGViTUhE?=
 =?utf-8?B?MkVuakNYSS9GejEzWlBVTUg3bjAzZ3FIZ1EyemIrYUpSRTlxRklQLzhWZmNa?=
 =?utf-8?B?UzdpVHZrSDJhY21CaVNtZHlIMDR0WEdEZ3pKeDlxTHRscDFhS3JXUHNWdW5X?=
 =?utf-8?B?SnhTbzlocWxHOFVhaTRjSEdVR0hzcTU1Mm9zUXEzSkpZTGt1blRCTXU1UlZ4?=
 =?utf-8?B?QlBRdGtKSGZUcWM1dEZQTFdPMnhRSkV2NnJ1a1RiWjdmcC9VUjhWdkNyUUsx?=
 =?utf-8?B?MkJTU1p6UUVENWlMSGZ6WG14ZE4wWHYvN1pPeTVPME9xOER1eWNDdEE1TXRE?=
 =?utf-8?B?TUlpSlVGUnhRS2ZGN1J4dWk1MzZSeVV6dkdEZkV1K2VSOWtXTjdteU8yYjdL?=
 =?utf-8?B?ZDh1MWlub3ZkaGc4em4vZkdiUS9vSDdyK1Jjcjllbm8zZkhNL2Y2QmlORE1D?=
 =?utf-8?B?K3JvNWN1SHh1VzhvVXJyeFUreEIrYkRaY1FOekV3SFM0eTAwdVVJRVJRbDZQ?=
 =?utf-8?Q?d3GiGAQ912bCD+aGIjPdBD1MluCWhLEfx0mKICqQALrEm?=
X-MS-Exchange-AntiSpam-MessageData-1: FN16PzpdbB3Jlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ec886-8f37-4068-2a3d-08df243c6de3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 06:30:07.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDhiVefeKcChCr1b0m+EhWjogZa6pmtuRaNez5TQ16+VHwf4sUJ/6Pl2/gOEhlmYLyF5XkTDfGQMkwuAoFSszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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

On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
<...>
> +    // Tests that encoding via the `nvkv_encode!` macro works correctly.
> +    #[test]
> +    fn encode_typed_struct() -> Result {
> +        const U32_KEY: KeyId =3D 0x0001;
> +        const U64_KEY: KeyId =3D 0x0002;
> +        const NAME_KEY: KeyId =3D 0x0003;
> +        const FIXED_KEY: KeyId =3D 0x0004;
> +        const OPT_KEY: KeyId =3D 0x0005;
> +        const INDEXED_KEY: KeyId =3D 0x0006;
> +
> +        nvkv_encode! {
> +            struct TypedRequest {
> +                a: Key<u32, U32_KEY>,
> +                b: Key<u64, U64_KEY>,
> +                name: Key<&'static [u8], NAME_KEY>,
> +                fixed: Key<[u8; 4], FIXED_KEY>,
> +                opt: Option<Key<u32, OPT_KEY>>,
> +                indexed: IndexedKey<u32, INDEXED_KEY>,

API question: `IndexedKey` is module-private, but this use of
`nvkv_encode` looks like something that driver code could very well do.
Should it be crate-visible? If so, why not move it next to `Key` in
`nvkv.rs`?
