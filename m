Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A79606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wc7R/zgu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A20E310E09C;
	Sat,  7 Nov 2026 12:54:30 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB7310E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 12:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahyiYlF/zlzkFlXkM6LCeIgZFjUpoM/YGOOTF3o0RUqI6v0ltuHNOZSOLtl+SimCXGOwWOHghIV1nEBfn2dpeMqLcZTW1BX2JgP18eNF103asKGN/vwOCwCc1Ifub6GVq/VKkHg0uxtTCjYNwd3SgWW9x7njFgK8MwOMcZoP1eWuXBT4Yn1MdOTWFIpjKyKrP/ZJDTplMqwyCykpAZdoLQUHm2EVXdQ2Ta7fKn13piNUkYnf8BSOwO6xZjlLXIgtpZOHcTSFDJCufkfS9gkiIoz2lpWBCMFTeOqUWecDTS0mC6Np3q7K0dmmg8TTUA6BULrwOWxldzVUwiozBRoBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NicoVr4yWKTmWneFZFypLAitLzeB3lOoMcHgnztgqJk=;
 b=FRvBy5vVfG+ysJ5LjFV3X/Hgf3XOJwEONYyV1eJfZwitGYZXjq4+4ebU3GFGXw+Avz8kCgEAv9OwbUHcAGTnQ8vZjpbwGg3Cjo+v7Un6nPwqq2P+QjTEO7RqkYvIMKAcrFQoFFfRO/I/f2tNTe4EfK0INR2HxUU/ibPadszXPT8uJt1IBA3Q5FXjvdhHmzoKhG5IOLLKyaZE0A8GorCQ2UKyaUULyAbwkiC7IbfgHR2xoZvPmC5hI+t5eZUo9S1nexCAA3seqkKMmmJ7QySS9dq2W5GD2hE1p5uJSaOnNCwhA6P/OMzpgNntz0T4fR84XWFp4BhZfsC9Apu9NwiKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NicoVr4yWKTmWneFZFypLAitLzeB3lOoMcHgnztgqJk=;
 b=Wc7R/zgukYLJLxLZhOpTaIn3DJmFQ+CEOCPYxb3XNXG8vkDL/soOG2bPet85fOLlqkGigtfiUqa20dYLPR5pMNhxAkEfkS4kCgneLqnSM+UTAu1x4JVWtAeqF3Bt9rzMzLhpSOntUAc32GdUh4Iuva9DEJKyB2Ijm1Vgdo7uUPRjCgi6HnxTluFfeVV/CeiJPzv6FbM7nj9Y+Whvee3jOm8hnXPPcZn8U2+VHagecZhyfGV3h0uzOsyT9Gm2WRXrm176F1nLZVW7pXHykqrEdKjzCL3PdSwnWxXQnGzKTbrwc8XhDZtKlgwB4Ts4qSiqacIH0jJ/JfCfErVXNAVdWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 12:52:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 12:52:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 21:52:13 +0900
Message-Id: <DMOZR1THYXEZ.138HB6J6HIMFK@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
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
Subject: Re: [PATCH v10 1/3] rust: use Alignment size constants
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
In-Reply-To: <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: b3077c33-4168-4a34-cab7-08df3ccdf3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|10067099003|11063799006|261102123227099003|261009223027099003|261021123027099003|56012099006|261021121427099003|4143699003;
X-Microsoft-Antispam-Message-Info: 0GmP5nx8WuBWypz5A6n7sles+PxhoXxn7DW5EU1yKl92Poo8rUeUloxNMKzYJx4ttrAvWkPQG6ccBLbAoZyt4mKEhify9Dq3ZIw7LSNpcoy4aew2L19+T7zN3jWuKtidXSYvz3sQT4rWn7/D0qz7Dkc02qHsgsFGOU4QypfyoGvgg3nQezxcMB3E/PxDD97qBFmPbLjhK23XHQBW7hd5g0ZLlWs4ajaB7I582U/fsC+pKeQvmbJwu+teK5ii9x7Aix1Jyi6zFuZ7yl6CwqRXSDojwTOt18ijrBgyMXzrem8J5o3kDRKImvJP7gPMsqGKrKvOv393xKVexaz4YVB29kd0EXdY2Gav3XlcWW5+iTwwkRvEiem3PKAjWowxt/llSozR+SsWhiVeN6ZyLsyXmQKQB0pUMwUlLtoU7OVuSUbxhJ+200bMeHIkC5ivAcegA4FiBU+0EZ3IzFmuCydbnXtl/K/SB8Z5qi1IQvby1Sk/AsWAqY1JXT/Th+Tx/mFC4FNA+9L+BSS4RtXQHvUOiHZ0VIvaaUisWat588SHV4J7OisyACA+k02/hifrz7Nsv/eWc/CppjNtiF6UUzB3DnqcZ6KLwuDofTy5ZFRxpSXMRV6MXdL1VPiodyL36flpmNMNo00irAz3WLoT2hYIOWlUTMfr7oUSoDb0RnxgG3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBORlk5TElmNGtObTE5VkJMVkg0cjBSK0NyRzZFWDJ3bWoyZytja2g0czdr?=
 =?utf-8?B?ajBFT3diSzRnckxJYTBGbUdDMzRQNkZFc1NLamwvdGx5b0NqeStCWHVVdVBO?=
 =?utf-8?B?bitEcGhsenBvN01hdGdWOElUWkhIeXpNRklUa1VsOHU2K2hSOWtaQVNCTW9D?=
 =?utf-8?B?Q3ZPVy9oVU5yb3pocEFVWW1zTFpDajB6VFFuQThmWU5KNFpKdTI1dUo4VlZV?=
 =?utf-8?B?S0NvNFB1SnVJdVg0YmNzZjdZRlpUUjBMbWFKR0dVL0ZEZXhrWVp0Q08xWUVN?=
 =?utf-8?B?K0U3ektMdThqR3NBZ1pvVE5RWmhpRmhYQW9XbWtGY3EzOU03TDFpWXNwaGxM?=
 =?utf-8?B?UWJueTRCUWw2VWZ0K2ZML1N3MkNKWnBLNjFLUk16Wmt0UGFkVGhMTjNSSEtB?=
 =?utf-8?B?emRWRmt0TkVDVk9sWFJXZkNMU2hzVUlHNzBjb1pqU1V5cUVuNnJLd2ozMXJW?=
 =?utf-8?B?c3hyOXBwT214d29TLzRBZUdkS1hjekgrd0Q2VnVDZFNxQWlnTDRjSXN4Vkpa?=
 =?utf-8?B?dmhIeDlLQUttTTBsL0VqT2RtcWwwVldhM2NiR1Q0c1diamx5c3B6U0JMMTVh?=
 =?utf-8?B?NjV2RWpORnFva1R2RVZINEZxT1RRYmtzVUZ3anhWbkFUcjdlbVU3RkhYZWMw?=
 =?utf-8?B?cFdENURHWC9neThaSlAyMVVlTkxyenFmclFtNEZNWEdnd3VmWTNBSTVCU2U1?=
 =?utf-8?B?UHRWblZ6VjQ3bjZxOVFwTDJWckFFRmdPVHdCZE4yLzI1a05uUlMzc1lMOVo4?=
 =?utf-8?B?dWhvdFVDQ01GRzBjeFlTM0lvZDMvMDE3a1JHdm5TQ256QWM2R0Q3RkhTWFVU?=
 =?utf-8?B?cTVFTGdIUHNndWQ0dEpVV3lremRNZHhUcGJnRTFhYlhmZDdMdUMyYWpkREFs?=
 =?utf-8?B?VDhXMWNJeEZyZjFyZjBLYjhwZ1hBa1ZoOXNtMSt4cUdKV3FxVFZKajRVY2Y4?=
 =?utf-8?B?T0RwZGRXRG9ubVp4VkNjTTRoOGVObmkrU1VaYkNVMWZ0dGZ0MVl1SHdGeWNt?=
 =?utf-8?B?ZlhLYmNLN2FJTGMraXBEc1dSYldFRlpTS2RIa2dqNlZXRURRbjk2R1BNRzVL?=
 =?utf-8?B?a1hOWDFGcVNWaDU3SXY1dlB5aGE3UC8rY1hRcTlJdmM5a1VrVjZ5VUlhNVVL?=
 =?utf-8?B?ZGdYQ05mOWF3bmxwWVN5cHBOK0dnc3lkRWtjR1czeDVSUlJQMmNZU09RNFRr?=
 =?utf-8?B?T1RNSEt2ekNOQkpJYTlyTmduNzl3NjNIMlpES2RKMThVZUVIajNVSVRYbCsv?=
 =?utf-8?B?N1lSZTdXZEVjWWZZWTBNWlRaUHRpd3hVd1VDbnhvNi9Oc3FTeGZxT3hWb0Jx?=
 =?utf-8?B?ZTMvT3BiZUMxY0JLdDVSVkdLZWZ4ZE9WNlIvNmxkQkR1cVJOaFNFc1Z0RC9R?=
 =?utf-8?B?TG9hMmlXTE9TNW9RTlhQZnJkTUZmNFdRUk9JdEhrY0xWQTMzZnN3NVZQdDVa?=
 =?utf-8?B?Y0Q0cDR4eDNvNEJ4RnJ6Y2tabWRRTGtjMEViUUg0cy94Nk9lS1dWZVdVMVBH?=
 =?utf-8?B?Q3I0K2ZsRngyQXFybXdUZ1lYOHNKS0tGd2ZKM1NVUzFHTzBIckY0ZjV5Y2l4?=
 =?utf-8?B?YUROWHJBSVRBdzlxWVdNWWlFUmRQMVlTeFBScVJhYWQyQlc3cWpsazlZTUhN?=
 =?utf-8?B?ZHFCVUJCL2FobmpVcjMyOGljMXNnS1NOSEtsL2c1cGlTWjNyRzJrWkI5UTVr?=
 =?utf-8?B?a21FT1RFb1QydG5oWXorMHlSU2FUOHhKNFlEa2Jna1VLdG16SHNiMi81algv?=
 =?utf-8?B?bTZqbTVEdzNTNTlEcEVZWUpxTE9yZG04b3hEZTR2bklIVm5ka3I3OVRwRGRm?=
 =?utf-8?B?U2xNY2NtelNNSE1pN2p1OGl1QSs0YjdnM3NBSzNwRVNpZllBdmZLNGJtUkt0?=
 =?utf-8?B?RFZxaEZHMUFvZnYyQzJSMmR4NVhnY09GT2dHM2ROL1J3QnpadFIvV3VQbDdm?=
 =?utf-8?B?dUxodDJiZDRkRDZCT2JpMktrM3R2Uk82ZFJ2aGZ5dXlMaElmZjZQbzlQcEw4?=
 =?utf-8?B?a0JzOFpuN1lBdS9STkZPdmlRQmlKbmlNczBPTDNZMWFkVzRPYko2ZURjbEZl?=
 =?utf-8?B?d052QjBBSHQ2Y1p2QThyZXRhSTV5TlVTMyswc3FLWFF1bHJqRXFFelR4dWxv?=
 =?utf-8?B?eUZSM0YxaG11QjFLd3pWNHRXWmRYeHptcnQ5NGRDZWp6amdDVThxRWcvZWlm?=
 =?utf-8?B?ZjdqRE9lMjFUdE5nMWE4REF0VEIwdkJTWWc1ZzZ3Z2FGb1A1dEdxZkZFVzdk?=
 =?utf-8?B?K1VuNE9FY3lsL0lKWDA1QzhhclR3anF2SGdXcy93ZnY4aUc2N3ZGb1RQZ0FW?=
 =?utf-8?B?ZFpSanJuai9Sai9MMmMyK1h1bHdMVXdNZ20xV29ZTXF4UTZjRXNDQ0NpNXlL?=
 =?utf-8?Q?6nGvylEWYTMKmfeBsk8t7Yg2CHB7zACbZ9WXVdM9iLzZY?=
X-MS-Exchange-AntiSpam-MessageData-1: 4IIlZWDfOr15PQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3077c33-4168-4a34-cab7-08df3ccdf3a2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 12:52:16.6255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/O4dALFf7Y4OyhWOCJLify819wAocRGA0emAU3Yb/BxOv38+VSpuxg+ZjVZRcLYEt2zflEC7LiT8Jk0qMDOXw==
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
> Use `SizeConstants` for Alignment that are implemented now.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb.rs               | 10 +++++-----
>  drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
>  drivers/gpu/nova-core/fsp.rs              |  4 ++--
>  drivers/gpu/nova-core/gpu.rs              |  7 ++-----
>  drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
>  drivers/gpu/nova-core/mm.rs               |  2 +-
>  drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
>  drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
>  drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
>  drivers/gpu/nova-core/vbios.rs            |  7 +++++--
>  rust/kernel/gpu/buddy.rs                  | 26 +++++++++++++------------=
-
>  rust/kernel/io.rs                         |  5 +++--
>  12 files changed, 47 insertions(+), 48 deletions(-)

Danilo, Alice: could we get an ack for the buddy and io parts, in order
to push this series through drm-rust-next?

