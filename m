Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB8FC5DF69
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB8010E52B;
	Fri, 14 Aug 2026 04:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e4Rp/4zm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B543210E52B;
 Fri, 14 Aug 2026 04:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWAV1YRYQTr9iHsrjUVz28zv8/lis5ui89rG/Dlgwg97k28zZW0N2AlgowpVKmZvasFm0UZGVjPBFyp6YPo8Jowl4/MYFzDzemBIOnV0ulsBXqxZjfSG89Eky5z5n+fhvk6CvmttHvMzt3lxZQUEVi2p13RnoJeMmb59NRF2DXcoBcRVd7lywTpaFiA+ci14bBFMs90TdBxEpcFszJs3LfTlTXBHS+qqwKh4bJ0sq0SgJq+mOmbeVp+rjTlOCpGxDaRWpoRjpC/Gl4wzycfVQ5kr5pys7GcQy8q6PVy1jsu+E3osQkvY+hDI0ENO88K3X7Pf6upZZah/T4UgvRUY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l51LlM6gCw5wh+ube5Diel8hbmqmr4dJ3JGhzxYGGLY=;
 b=neoba+DGyOyLR/y9ZYtwIz93D79zy/CXL1Nef458eM6OwJn0Ty3ZK4ZovsdxL30vnHKEFzW58YCoRmV1GZdwD0DhMDn4zIMaa4tohTQQ1+Gud2+CcyqvWARDC4myhXW4CH6+O+5zuILdw9YjoxCYPmDe8j36GX0Xo+g7QnmY+kM/ZZCZTF3munl+hjIW6HC80Qg88Qh7Vr3ZtPN81ce/g7S0lDgvvIhR3oqJtGJqhdvsi5utTXS9D4BeCIXkA4vbgeEGGuhwEahUMim6ov3r6sHs/eYerN+enPa7+bG8aK+2wEDNrUExbDJnoONxi4M9uwTvbBeISFr9cXKuLXA8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l51LlM6gCw5wh+ube5Diel8hbmqmr4dJ3JGhzxYGGLY=;
 b=e4Rp/4zmvE48RgYSUG2vLBCayvm1hquXvcRoA2fptmnqIhSKofyBnia4lJpDZBGRsHGfxdSgkRcOm7LBrJ6yPCZNEENp7saCyEe2Ng4TRy7wEAjw3xHB1+zX5xFo/kFIW0GqStm3zLe6Mk68vLwpYb+VVohFdVlxgI0uI+fFvdDVly20/tCTY+tr7qOoY3NexB0rQHoZ4oQpPK/4SHayDmrC7T1BoQVDmhb8V3ydjksQOS4tmH7u/dDDbMDNGcOQZt4Qqakx6qHFGFL1mHMCY1Wyr6rYuAMgHivDgD4SfyYstUZ1vD0hHffNw/1B3Wt40Qg3vFBToqnCk0GboDE1pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 04:54:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 04:54:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 13:54:24 +0900
Message-Id: <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <ynorov@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
In-Reply-To: <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
X-ClientProxiedBy: TY4P286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aef94e2-ff33-469d-79a2-08def9c01ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: iup3dLgB55mzN/XfTLgEx2ss1nKTPpCn3Q8chao5ghLXcNT1j0LJi8QGxw1jpI8kcmv/0HsdGF206rDI5csGND7EeAGFT/GwGZuMnLQ5DoiMgiRoW9iKpHAVTn2CKiQuGO+uRzQrx2D9wbG8Lv9fGX7JBlddfwU/EFIr72e48k4anDqw8/9UhoJd/4/88m9dyVk+AWV5LDRm2FraQQHiCz+n5YuZfxmTtO918Rx88uiGRhUQso26EQK0NsHdB4kiKp23I6Ig0vPrQ40TzfyTcesjtcPge+zeXUBD0bTVoOqyw2KSW9OulfkN7eKAEhZj5t3gEjiSLVvM2GXsMOrdNzaLAjtaBXKZdqaMaEqMFK8lP3kNjXE/tOLoSL7eopujrNhTUd2p7hLNeZeFfl9fDC7NtoO7TQ8KIBsuDUb57UJmTUSYE9iUydUzSBigINyWgYt3hhUd2KoAHyr5q6Mi4Xw+tPnLKjmQtKpWPszzSKLgBxx0Qk2hRK3wLB3bxq2Hq0bYe0iiHeLqJreOrs3TcGwHwtNl9rJ8tXShTgmmhOeZzimcR9b9NRby70XQt9Q4KYshWjK/ISKy8n+w+eySx3b0tr5LFJHNG3ecLAfwS7o2pp0MSdUXXv00Sw9s6IyanvNBtOcPOjfN1RkPfOe+d0Yv+prgEuMpZIMkSL5Gu6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJOS0t2Z05XZWxUajVGcFZ6M29xcUg3Vk1XT1plTXR6NVRKSTdaNVVHcU1B?=
 =?utf-8?B?QmtSZENvTjJZWVF1eUxCcWtvZkRPUVI3N2UwS0FUamt3WU1DVUdMN2lSOFFR?=
 =?utf-8?B?QVFjMU9hMWNPei9CbTVQSGl3c29nbTkrN3loeFBDTmNva2hkbEx5NlNDSlNV?=
 =?utf-8?B?QVk4dVk3NTVpYjhqQTBDUFVIZi8xYUZobjI4cDJSQjZRc2hLempUdWo2Kzd6?=
 =?utf-8?B?aVZwTWZzNndMR2NvYm42YUhESHFFWDA5NHkybXBrc0tLUzVmYlVzZG5GdTZH?=
 =?utf-8?B?eFk5ZEZqSnlYaFhvdGRDQmZFdXI0MjJqNkJRUTZCL1hZQ253T05qZmt1ZWE1?=
 =?utf-8?B?dkp4K2tFQVFabmNPQXdzcnRmZ05ZV1N1UmFZbkhnZVZjb1hQeXpBVzRyU21N?=
 =?utf-8?B?Q2VBTWh1YXZJbUxIVDhmWXg5c0pld3F6bVIrOThJUTVUYjcxK3R6dkI1VVJL?=
 =?utf-8?B?Vi9jS0NrSC91ZHJMUWI1V1FWTkFXUWYyTUx4RDFQWkJtVGNMeG9JSUF0QXov?=
 =?utf-8?B?d3Rrbm14K2J3SGxQVytuVHV5ZzZmVHZKRXVPUlVwWlZYTXduSk8rbzBNK0hl?=
 =?utf-8?B?d2I4UlRiemtvZkNXUEFUYW44Zng2d2JwMFpPOVhmM2NNS0FNUVdiZ2R1VWRt?=
 =?utf-8?B?K1lGNVdtVjVhVnR5V01IOEcxUEF4eXV0Qy81TDVyZS9FaHNCbS80eERlTXg5?=
 =?utf-8?B?WGJNdUFpT2pPZnJpUzdnKzhRR2FzNS80WWhhNTBTaXZqZnIzcVJSQnV5c0t5?=
 =?utf-8?B?ZGo3YlM4aVczOEFIOVF5TlJHZXhWNkdPa3VYSWRhQTArMkdzcWszblhob2Fx?=
 =?utf-8?B?Y2JwNzlqUlJ6N0Z0WFptR0ZuajRReUNtR2lmMGZCSytZYzJpNzJiZHRKeW45?=
 =?utf-8?B?L2lIM0pENmJSOHB0WmVOL3JvRFMvREJadlNRSzMrM2FBU3g3WnNDbVZ0aXdN?=
 =?utf-8?B?bXNOWnpBcmh3L1ZIMTJJVEp3ZFVVWHBCd3VRbzErWXA3bGF2OG1seVZ3cWkw?=
 =?utf-8?B?OWJFaVpCbDNhYlBUdXhwK0NKa1VVVWtMcFFqTWtDQWNreVNUejVhTU1hWFRh?=
 =?utf-8?B?cW5hcUZ1am1TblhFUkZ5MlkrSXFKZUZSOUxOTjMzWWZZZTR5cTZDb0w2QVdT?=
 =?utf-8?B?SWFXZkgwZFlWNXAxL2dGNDJHY0RCVHZ6WHBtVmVhMndjUHBNUzZkbjRlSzg0?=
 =?utf-8?B?elBwSC9VRjlsT01za1FNTXNicFZ6WXNJeHlVSzBIZTJocVo4OTE1TERFSDlO?=
 =?utf-8?B?dkxmejMzRTRFZ3FCNGJtSzkzZjJFRnlkbVZEdkxKU1JDMzNjelFEQjdQVXcw?=
 =?utf-8?B?aWtIUlcrQWtBTTBaQ25IYktBRjVMbnF2THdtdjBUVGlDeCtxOHlFT2NXUm9Z?=
 =?utf-8?B?QWhJSnN4UWtjNFFyZ2treVp5Y1VxMURrSmpMN2pUS0ZNQ3BORTFid1gxUDJp?=
 =?utf-8?B?eUxXREs0K05wdmswYWE2RlhyNUtaeVBtZkI3RU5zbTMrSysyb2d6N3piRVFy?=
 =?utf-8?B?cG1FS3Q4bTY2ZlF0cUxFdStBWlVyeWtObHlDU1pucFZmTmFiUkl6QVlqQVIw?=
 =?utf-8?B?YWEza0VJMHpWT0FlNHJQSlF4SmVncGp4bHl1RUQxaWNac29XYWczL1NTeGxi?=
 =?utf-8?B?VVF1NnZTblUya1BYbUVKaHJLR21aZE9tNGo1VzNwRzNDV0FCZ3BKK2tkMTFn?=
 =?utf-8?B?VW9QSSs5Q3R0bkVVQmwwc2hZa0FLMkl6TER5V0lwclBmYk5lUWtUaXU1K2Jz?=
 =?utf-8?B?bW82UVZMeGFPQVpjYXl6dGFSaHR5OXdHZnpnbnZMNWUrU1krVXZrc2pyRGJO?=
 =?utf-8?B?eXhtaDhFVCt5SFBqZ0lZc3YvTklQUWRaRUlsWEpWY2lBR1A5d1RBUTg4cDhm?=
 =?utf-8?B?ZWVSd2VXdnBrZmUyd05zVDBuTmlEWkg0MCs4TmcwWmloNHE5aklXK3V0M00v?=
 =?utf-8?B?dGlzb3N2bnpLT0h0anh3alRBOHBiNTgvdmxzWHlrTWU5VEZKQk94V0tPTzBP?=
 =?utf-8?B?QlJRQnhleFZDMUp1SnVLWnF6SmxHUW5JTWZMT21ZbnpyNitrcm1lbVBYNGJ4?=
 =?utf-8?B?TVk2YTVwcHduSDhuM3NhRWl6cWw5YXBwcHVPNGh3b3RJV3VUTGtOWlAxYTE2?=
 =?utf-8?B?REd2TWNHbHBpOXNMd2ZLSnJWQlNiT3VwMHFpbXZ4UFVtUTJzaWRtNEEvSk5B?=
 =?utf-8?B?MXFwR2FLYnRFcmJpV3dQVHg5Q3ZnekZIdDFCYjFWVC9rQzlucWRCLzQ1M2wz?=
 =?utf-8?B?WEd5cG15dWFUSlYyb3NmdUFUUFdLMjNZT1VKYVZ4WCtPSlBLc2t2ajhNNGNm?=
 =?utf-8?B?My9QRk8vZlpQdVFJTmhRcVBvOEYzaHluZVhOMy82VURJN1JQL2w5c0NnM1ht?=
 =?utf-8?Q?S3/JwTKm93gvPla0ExegJpTM5LjMP/SwV1TBNrkrFoxOy?=
X-MS-Exchange-AntiSpam-MessageData-1: iId4tesikUUoEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aef94e2-ff33-469d-79a2-08def9c01ff6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 04:54:31.3669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr3r4objsmQFolld8CctRi9KImvj2xtkTZqc60eXLBhtqDnn7DVjFeusvBGRRVnnh+WVHB6F9A4n4yICWIj3Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

> 1. Provide a nz! macro to create constant non-zero things. Provide some
>    constants for common alignments
>
> Potentially, we could use build_assert! for cases it is provably
> non-zero but not a literal (although tbh not sure this is a good idea -
> at least not do this initially).=20
>
> So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: some
> build assert gated construction of NonZero. A general nz! macro could
> also help ergonomics for other use cases too.
>
> That looks like this:
>
> pool.alloc_area(nz!(8), Alignment::AL_8)?;

Actually found that if we implement SizeConstants for Alignment then we
can get Alignment::SZ_4K etc almost for free.
