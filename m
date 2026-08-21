Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB742C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FF510E27F;
	Fri, 21 Aug 2026 13:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVENXyTC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED81910E27F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtknVh0yuVhc3iyaeDwbL88FTXySxUAyMofM8baTBSXpetYsHgeSxUelmJB0jqcaxPheeBEk4r/h//BGVm7F/aNpDtAjhGz4+St8bY9LyjRv8I4GcjzSYGR8joc38HN6nTpTfzyncHBjqK0pssyTtQj4QkhTw8dXhqdiJ3oA2D5f2JHs+hh/VRf5uOiLRtfgBpoGhEIDyRC6E6yJe596uKogvEUd/oA3qdjM6w93rlSmmOgqBAbLYimN0EKTe270RExvs2wC89+0Xo7BuYd6mlYxIf4JG5deC5QCbFlzQ2ONqRS84tVTmk7gOrXS4bPI5fybdgL5bZOT0OEmbNmWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWbQdd7mrV0XQ7d+8ibw0T9fL9l4PuplZVJxZm3m4Qc=;
 b=RdhrTBvdhC7UcUVEBkl4oNWoHPiKbM7BEwtnFLxuG+9+x+zHeEdH7b2Gu2nx+hsQntSZ2b+gaGQJP0ghoE7mJWxw8ha4ViAwp8zhfYQCgUjD8zoCZ51qsj8mA3tBwMHSS26kjtv2s+65btsKDnxIiQSUa/9n6Y4wCV1o0QA1LwUFrr6hPWDFFZnXFxjYBVZqLnOo+xWs74rI5zDB7tXohP/BKZukWTjBoprOkww7FtOgCkbKdkdCXDR6TlcOq89nPu3R2OdCz7iw4XqHJTcetmn/J3cJ+4R8vSWREH3ZQK3n+679XkZFKazvewJhVk+2jidm2fluFmA1nQAr3DDJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWbQdd7mrV0XQ7d+8ibw0T9fL9l4PuplZVJxZm3m4Qc=;
 b=IVENXyTCfTcJfiQY7WC6mXlfFEV77/tFudWl57P6pK/jwqO/WUagDBC32JWTaHFfjbCNVEVkglpffspq/+LodzJS5sRnRmrXF+P7ti4p3LjkE7qM8eppapMDIhjFwoCuvzt8IBLVoj50GawMpXC/szZ89TeOeoQm1xxkxPJlgeXPpE/NPmXYpDmkQwnmZ2aitH6IFXEvXykvjKLDyZ5V9ZjwO4YPtQzT7keiiX13rA0Mv8af3hbT3ZgtwqxYc4QxZM6ii42KA4aPkmL7du4lkxNvQYDuQvT/XpHu/7YDHwbFH3C2Mx7HhI+WCMCqGXDe84DlrRlkK+Hi7rRk1HQ1+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:53:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 13:53:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 22:53:56 +0900
Message-Id: <DKUO7T5FN47F.3J21T5BJZ6Q5@nvidia.com>
Subject: Re: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: a281bea2-7203-4745-9187-08deff8ba665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XluHgd4+FvlgzYXOtGvsY7x9OQpBJTQ7gJRs1ytos6cLpGntv6fauGUDHOMHU0NWuM6GoyrqVYK6YMV5cbwRuXiDgWB/fzWu+WP/+TB08LKP9EZ6jY3gQtUJAxxhMgNcbqHdB/d6Vjop6wZ28d4EpNVerQ5H7BGlia3n9PCV9rOaD9Ij/1MeCksJvMTZ/PfVgfwF3JvkNJxVpZMYNrbrhhh69TBzooN3zxn903hwwhlDQvynTKrIDL6AY2mycQLCv9p4QB0p+iGuyDrKP7ntjGc0RVxZP+a+jDpZR+j3fNxRH1ENFJWdXbLK7jPoIqtXgz3LEYh2hpkD5ecCN3TmaQc8UEGuGq9Z0BxrX5pxgfrPx/9naCTAYmeV+FpkYfvzQBQlVjPGFMjxYLcznU1r6j1xPTI/YipLhd7aTYWQR6WWuVAylgY2k8mZUORd3d243YpzKuC+JOmCemFBg6klYQPOCqrCz+wHOXFqGRbcfk/2aACLwvT5YHsb5qNCLPBceVf2BsI7GSvNeyjIUB2hCsEt1CqhQAFH3ZlLSjcMkjyILRiqIl3YKH729y6d5i6jBBMsD26uCTHZcg3Pc0KvmveMAfOWtQ1E95dZ95ZLNB0yNwx/jG4co32kk8cqfFkQNIdq+RR947x6AcFCcHmAx1ViBPHUvtDOmu+3bOwk5rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGtVakRSbFQ2NzdhRkZxRjI5UVN6RHJKSmVOMC85OTI2OWs1UlRPaWVNbFJh?=
 =?utf-8?B?eWF6dkxSQWJjR3JKWStremllT3F4WW1zT01kSWxUWUhGRUtVRUVTVGhUSEVu?=
 =?utf-8?B?aHkxU0NZczltbVVONXEzNGxmVFFVeFZ2dUo1Zy9aUmIwU1hIQkxoT3BmTERu?=
 =?utf-8?B?R2R6STFwTTN4cW9kMXFFWS9wL1J5T3lxZ2pnTmlEcFBEV3NZSnVIY1FJOUxY?=
 =?utf-8?B?bGNraDdNRTJJOXZpbGlIZUxsNVZsWUNvM3N5c3RtYnRBdnI1OGc4Slp2aGdx?=
 =?utf-8?B?cTJHTnNkM0kyTzkrMytkbVBFMVpiekNEdVM4ZjgxbWoyUkVqR1N1Wk9EdHh6?=
 =?utf-8?B?ZFVxdDFEVWJNbTk2Z1BKOXkrKzlpOEhqM01JVG5oTzBoY29Lc1o5K2E1Q2dQ?=
 =?utf-8?B?K2p1aks5cThuVG9nT0tyeFg1cHR3K2w1T1B6L2JtL0RJd0FYREYvckhHc3hr?=
 =?utf-8?B?M0hMbWpmaVFZVzZhdEhaNkpQZUJrMUk5NmxURFdOTGlWY1pkS0dNV0F0SUtJ?=
 =?utf-8?B?dGVIaWdRdUxkUVF4WmRJeG00RUR4Q01xajRGTEpTd2s1WGg3cTkwS1dlQUJ6?=
 =?utf-8?B?VGxDSHg5OFNuRVpMb0srMzltQmdsei83T3BtSHEzZ2xPelh5L2w4L01wVUxH?=
 =?utf-8?B?TzVVZ1NYRmtQRE4venUwc0tXcVpNbmFKM2hCQVQ5ZGhURUk5bDc1dkE1VDND?=
 =?utf-8?B?K1p1Yk9pc0ljUmxyMEo3ZGhleUlISkV6YjZhTTJ3ZGh5UjNhc3ZVOHJJa2dI?=
 =?utf-8?B?eDhzK09GaE5xU3VuaXNTclNlMkhVQnBOaWxiZlhkakFKVWF5YXBNVjc1UHBI?=
 =?utf-8?B?RlZEQndQZkp1YUhSblBWajJtWExvdUt4eW54U1Q4LzA3NGVlZ2hXYUhEZ2Z0?=
 =?utf-8?B?YXo1L2ZuZ1lBZXZQV2paZlJaMmRzRE5iMVBYVThORXRPN0kvZGx5WXp6NHJ4?=
 =?utf-8?B?dGFaTFZnN2c4aEp2ZERhSHA5M1dEcER4WW0wZDNGU0VYUUpUem5pYWJ5NlZY?=
 =?utf-8?B?SWh2YUVtdm5aK2lsSktycWVoRnIzblJCYXhvWWNBNjlPRUYyb09rc21aN3Rr?=
 =?utf-8?B?SzM4U0MrRnU0NndMLzBDb01pSnBzTEVYYTRRbjNUZ3RISmZFRWg4VVN1L1Rj?=
 =?utf-8?B?M2VMQkVaWjNHZ1FoMDJoTkFRSHBnN1dianRUSkt1Q0dwcHR4MVE1RmZKMHlj?=
 =?utf-8?B?MVRPMlQ1bm9XS2Z3d2pWRmUwU1ZyNU9HdzNQWGZnRHZBbWpyU2piN00xOUZh?=
 =?utf-8?B?QjFablN6QTAvYVU4Yks3ampiRWpvQU9LVEpJZlRtcjBjbVdkMURCaEpvMFl1?=
 =?utf-8?B?SWhuY1RtNVZVV1NxUm5KN1RTTGVPRy9iTmZzL2lYMHNuRXAyWWRmNVlZR0c2?=
 =?utf-8?B?bFpOcGJyNTFtdlplbjlhODNOYjIwdXVPeVFmYlNDUzdKS0FWSGlOUEpWNE5q?=
 =?utf-8?B?dC9CZEljQU5jNjBVL2ZwdWtERXRqV0xUUG1ESXBTMEpXNkRGZ2hJWWlkM3g4?=
 =?utf-8?B?VlNrN0JpTHNVWnJKbjc3NHVST2RZWi8vc085RmZXNi9aVFVDVHJWM2RtNzZk?=
 =?utf-8?B?NHM0SmM2WGFvVEs0WUZiRzQ5aW1HMnB5Y1MwRzVXUmpSeUVGQ1RVMFBrNGZp?=
 =?utf-8?B?c2JvMDk5T2NEZU1PODRoRTJpaC9TVUVNVzVJOTM3c0ZGNnZVRUo1OTljSjd6?=
 =?utf-8?B?VXdESkdmK25zdFVvYlZTRHBNRy9vNVJWbTNCY3Z3MEZvVGowdDNMNnhrY3JW?=
 =?utf-8?B?SGQyYW51SWI0cmwwS1d3M2FrN2tzRU44TWVISVVJWS95UkxIaFB5VWtjU05N?=
 =?utf-8?B?L3lGZTF5Y0xZNTdVSk9FcUFXd3lrVnBvanllQk8wT054Y3hHeG4vcWlCWE9E?=
 =?utf-8?B?eWlDMGl1Mm9KMWdqUjBQUm1xRldwQ2NPRFNJWHhXMVArV3JYR0QvZXhSSk9I?=
 =?utf-8?B?aDJ1OGtSWkpqMlFGZk9RbE44d25xaGx0NUhIM0NmRjdDM1RyM3VYTTVSSmta?=
 =?utf-8?B?QmtoVW4xcFJjRUtDTkh3L3ZCMkhGYVh1MUEwQXZaU2FvSlo1cXRQNlVUaHV1?=
 =?utf-8?B?OFhtbWYxSTMydTExOVNKcmFpZ29KMXJEa3pFOGQzd0V1anQ0cTZZK1ZMaVVq?=
 =?utf-8?B?Y2JJM2VZN3d1SkFXVzVtTG1hV2hSTTgwSGFtMXloSHV6RTAyV2FNRkpqSS80?=
 =?utf-8?B?VVBlU1R2cWppQ0l2eGZOYjRuSUZGL2JyUk5HaEhHQnJBenNxTW5lUXdHT1By?=
 =?utf-8?B?UjRlUnpNNDlHcnIxNndGNGlvcW9RNENCV3dTRXNObTRORWEydHRzbjVwM3Fx?=
 =?utf-8?B?dVlVKzBLbWptR3dBSEQ0NHo1bkwyZmlYTlByUHRKZWNEMDhxck9OdWRpN0hm?=
 =?utf-8?Q?yhEAIoJQxP0/sMPKz0rl23Ix3r8ub1kLke+v58aWFnwXc?=
X-MS-Exchange-AntiSpam-MessageData-1: FOqM3DgTTMEAVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a281bea2-7203-4745-9187-08deff8ba665
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:53:59.2890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L+ehKJxihFie6INJWpnHDjqcoZdpWvfcD9g7htq+8UT4++iH5MtUW9CFsprptiUTVuI2/++lyXi5jWk+IH+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
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

On Mon Aug 10, 2026 at 10:55 PM JST, Eliot Courtney wrote:
> Convert the const-block asserts in bounded.rs to const_assert!,
> matching the rest of the file.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
