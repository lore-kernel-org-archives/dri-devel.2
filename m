Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6066C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6BB10E6B2;
	Mon, 17 Aug 2026 08:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fqtkb6qr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D208E10E6B2;
 Mon, 17 Aug 2026 08:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGFQbr3Twq+QYICYcw2i/LfMbpSyyBgK4cHG/TgyNf49agB75N1SxKRotdAjWBgO50CIPV2jnWNzdegx8VcrD4qQyOMpLXeklWtyZQ263J3Uv6AdHqMMVRSrge1V9KwHPoXD8Ut0Xmm+/O7+x1lDQrnRcPbQiFvrcHSt7OXyaw8M6S8dj0lZK4ARtRCgvewtofi1HtZ2XmGLtACd9it7V6+Yomeu+ooKKwVxLHu7rBbtOytqh6mlXGzOPjKKXMZED0834OZC7tabPSochyrQzJXHvmaINt3M4w0p8e9cvOUddOnyt5QSpzPs2HeDDfaiQ6G50FHMaivFo0T4Thuyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjnLP7jK9SR09/DND74jgQIrS87CrHG23HcFp7XIbWM=;
 b=VW3ube5zbOieQjA52mTIxOAVfOkTngJHG5rdWjfhVyOgY0mfOYJhtfieYR6VufqrQkfsqOttS2fmTiNXPwe0D0/2ci8yTRSKG9anF5bHSfs4zX/01AHG48wGz4ChbFixmWBBlXVqWNOaf62Jpkv1eaNE0C0Oe2h1+FCCqB9ciMxP2NzQH0k8T0PaJ7z6IbG/PZ1NJJQ9FCPKw/AyIiJv+tIKq0Ka1IFQgoH5p+0Y9+k84hAvVENLfxHLgm500TScr76pjNf3kt7nxKVujmVE1t1WI4BkfN8WwtzKDNoixykmaqwXl03J1xQ+bYDz1EdfnnZuMrCwu1UDSyFd+N+Cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjnLP7jK9SR09/DND74jgQIrS87CrHG23HcFp7XIbWM=;
 b=Fqtkb6qrMmfFrZ5HgYRuDkrbYip6i+j/bZNjN8pPT70pvkzp011EzsQQuB/QJ+SbU250viFoPIFnGEui8Wd2FISz4fv+/WLV7yuqONbBqY9/T9uGL/Y6MTNhPfR57mDPKfmiU4EPwlZB9aKv+uZs+/zHCEMQXr7kzwIV7sc3FkdudM8yPTtqps9CpSSvBwEP441U5/zsD39m3ZoVh1L8iiGJGOgc93+Q84m4QDbYB/SvmEB7o2sDPZSo0AN6zJmmYIashbkGF90zo1xZiMsb/2nLFsk2kRUT42Q2AF/4p2aLrHDxrslheWFZY+/aRJH7Hi7+iM8KDe7j14Y+GgPDrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Mon, 17 Aug
 2026 08:20:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:20:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 17:20:32 +0900
Message-Id: <DKR2MD987IX1.11I18NM3UNVQO@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
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
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 04/12] gpu: nova-core: mm: Add VramAddress type
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
 <aoKfPchpfmTVguQf@nvdebian.thelocal>
In-Reply-To: <aoKfPchpfmTVguQf@nvdebian.thelocal>
X-ClientProxiedBy: TY4PR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:378::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e02104-b5e8-4dcc-83af-08defc3869ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|7416014|366016|11063799006|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: OB7yWHxSdyaBhRWZZGcp07kzx/jgt5UlIVYVuafdwdJ28achiFs3kVNDm/4pIjn25GKtRXHyvMaw7bwQYP+jWREpHP/a6OOrPybR1xz/MJoSXLnN0sQMpy8L7FXLZI4fbxQOlmA1cZ8tpfEG3qMBWKh+1Yv8hJyQJwi9oYEMy+rP6Gp8FPzMzF/noKoQtU+Awytp1W3lFHeMyF6TsbW+mqkjZ1akD+7oOcIx4goWths1SJfFsFwnZc/ZLMcI+WLAMJRQaQBMlGvpA/UvwVoWH8GhwFa2iI3IpJXzzopDN0mthtWakeem8U+ZtbAky3jamxc9S4VQ9HB9abhWaqpKZAnA1ohb9zXp/i+u0O20bKCxmHyiAF1JcIk+FeDV8HQFhPzmCqHnw3Pv3wACvuT9xMV/rracyOzNHbO+ujrw7LyugiAL8R+LWQt/tEq92tGwLB90if1r2wvQDrfnlpux7DcnwaQxgdFyZUG+a+AwTz1hhzyO9O9eoZO2zHm2iBkN8mvGo75K8fGTXDmASzWt+MSJOu+LGxe6qi99uNX2K6oIiO2GYrvGT+Yq+o86+DJvseCoJSkttbCyi8J/UOKUoUa5I/lBnTe4ftq0HpHEPIgJ97HEzVHQ3gSdjlPdDuRvu+OuxnfAWSQItbepAv3jDC7qCSVIOlchnnORpDYFOgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(7416014)(366016)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1QyM2MrMVE3RUNmM08vMnJFZ2l1UlNqOXY5MHFQUkhjdVppUGs1UStLWEV5?=
 =?utf-8?B?WjRpMGYrR0kxYnB3MDIwdHhvMEhlNHc0eVVaT3IrdXdBc3pyYTE3YXEraE16?=
 =?utf-8?B?RnpobnViVFkwclpKTTFURXNJaStJNHFCazBxUlJQeEltSnRrUlBRQ2RwcjFJ?=
 =?utf-8?B?QmRubk9NOHE5ZkszZjUyOXNlMTVaUjR1NmJQVGFmSGFuTWhpZTBqVW0rNEtE?=
 =?utf-8?B?KzJVb0pHMmpxRlMyblZqYW1VSmhTQmNVbk1MWFNTN2FWSzFWZ09ucE9VWkdK?=
 =?utf-8?B?OXFBemhrdEhSRjQ5TTFqb1RmbGdaTG5hUlRXbnJZR3I4MDk0dDJxWFFLeHFp?=
 =?utf-8?B?TzNCTDFVN3Z1aEtnckFsYWdaeDFSZWt5ZXdHU1BvaXVRMHQxSGNQOWY1RWRs?=
 =?utf-8?B?dHQ1V1RQYy9TTVlHSXlxaWJGN1hKb3JZVzJxdkx0cC9CYUw4ei9nTk1ReTV3?=
 =?utf-8?B?K21SZ1hzQkR2Q0F4ZldRMEdVbjhMM0hBbDB6WkxRZDlwRytsVk1KelZzYkVo?=
 =?utf-8?B?c2xQTjIyRjM4Smx0YkZCYkRlODNqdDNnWXYxWHFpdXpoa3ZIcEtkT2ljS2M2?=
 =?utf-8?B?ditFbldvc3UyeWJ2Z1BOaEFwQ0VqbC85WnRFQlhWMG9HSEYzRjJ6Y1NWL3Rk?=
 =?utf-8?B?dXlBMkdsaVI2anlvVEgvd2pWR0JBY1puVTJyU3g4OXptS0k5SWE0ZWlLSWZX?=
 =?utf-8?B?MnFPZVA3cE1oN3NQeUs1NXRXT3c2V1hmaUZOdjdXaTNGTituSVNSUk9ETFdB?=
 =?utf-8?B?Z0R6NEdNWWQ2a2NBMFpmVHgrS2hMb1A3dUVJZ2VpVVBLYzVWckZtN0JaY1RQ?=
 =?utf-8?B?cmJGT2N5VG9RSisvMWxxaXEvNlN2Zm1zdzZUVFMralhIdFJEcUcvYjg2OUxj?=
 =?utf-8?B?VlMxbDBzcmw0dk5LeDF3cnVNN1oxbWRRbHFDb1RIUjVXbHMvdXdiaGY2aStB?=
 =?utf-8?B?SW5hVGpHMXcxZm5CdFZnSHh0RWVwM2JjMVdlNXd0UDJoVC9QMGs3MTNFZVc3?=
 =?utf-8?B?bVpoSWgxWVZNbm0ybWQ5cGdTNUxVeWp5U2dpN3dyMjk3eHRzazBpN1pXeDY5?=
 =?utf-8?B?NVZQZFVjTXFYb3V4RVhFeWgzQ29SRHExMEdQQTRvMXduNDJMUHYxbTlmSnFZ?=
 =?utf-8?B?U0ZUeHVwWitkT2VuWm5JNmRtSmVERFRjYnIzQURUbWhSUitoUzdvS0xWNHRv?=
 =?utf-8?B?S0lhWStjVjdHWXhJWUVmNksvd2Nkays2d1JNYWlhOGNlKzVuRE4rL0NTdFZ2?=
 =?utf-8?B?UGhESmhQa2NxTjVSUGRCS3crZ1JTRTBtUnQwUEJVOGprSkNVK3hncDZKNnpi?=
 =?utf-8?B?a242Q0ROdHFBQnR4NHY3VlVDM0tzc2lnL3EwUytGNU5zcUdDMG5RazR2M0NE?=
 =?utf-8?B?Y0tRQ0VyZ0NCY0ZxWWN2bmNuQndCeU1KelkzM2dWV09RVkNhbThXeWV2OXN4?=
 =?utf-8?B?M1E4TlFSM2ZEL2NpRkVJSmg2dFdFZWlRa1hyTkhWaTROdnErVDRJamx1eGJS?=
 =?utf-8?B?MExwcytUN1U4RDZOU0lXaUhNbVpOS1BGWDFpbkF1QTByM0xXV2dKSzVUNnZT?=
 =?utf-8?B?cmdOM1FuTjg1U1I0MFhGSk84N2Voa2ZnL0JmL01GN3MvS1dHbnNEd3A2ZjVY?=
 =?utf-8?B?dFRmR01Ja0JSRnlWTGhLT3RrK3dYMDVIL3FNY09BR2VhUWEyTVBmRUJMeDdM?=
 =?utf-8?B?L1ZReC80NVZ1aklSb1ZLTkFBaFpvQm5uRWMzQWgrQWlnK2lWaXo4cWh4YmJk?=
 =?utf-8?B?UkVQemZEZ0YrSHhPVkNDYmQwR3BJb0JnUTlCTFNNZWVoN01najVGSjVEUXV0?=
 =?utf-8?B?U1NaMEFlRk9GV0I2ZENORWxQZGdlb3ZJQ0VqOG1SSHMxUTNQN0hFMGZjMkdu?=
 =?utf-8?B?VTlPaDR2SnQ0VE9TYTFVeEdFVHhIL0ppb3JNQVMyZEpLS0Jwa3JYNHhISWZ0?=
 =?utf-8?B?U1MwbU12RXBpRHYwQWdIdmc2UElQNFlFc09obVY3anVzV2hJYlVaQU9yQ1py?=
 =?utf-8?B?Y3BaSXQwT3l0QkMrUWlzYkxmZ3RBRUdMcUV3cDY2MTJKRWNRYnBTSDloRThS?=
 =?utf-8?B?T1ppek5sWUJhNjJBemFUc2IwWHplbGRDMFl2QkFpamp2WlhXYXFYeEhJTy82?=
 =?utf-8?B?TzhWY0NwUzJJT2VLaVM3WHh3SVZtRlJTNDNtb3pVR2U1R1o5emlucVllU0Rj?=
 =?utf-8?B?K01EQms1RTVzU3dmWWFiUVF6clIyZG9FYloyN01WUC9JcWYzZ3ZWNjVVb1BS?=
 =?utf-8?B?emZGais2QTJGVlBqUXhRZWlIUUIxZ1JVOVdrSlo4ZngrYTlLc3BoMlhLNkYv?=
 =?utf-8?B?dzQrT1RFcWI5SEt1NWd0eXE1WmlXekJweDBHQ2NpN21hbzh0NmNlQU1sSGJr?=
 =?utf-8?Q?bf2la9rjZvjML5ta8YfTxUAgyo0aFVcE1KtXdEMT/wSOw?=
X-MS-Exchange-AntiSpam-MessageData-1: iMD6vKTITzPIxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e02104-b5e8-4dcc-83af-08defc3869ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:20:36.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlEA9zQeB5wT/GHpkztBXFcdA+X8Fb7v1pLNbI0yn81BAUAtQipYUhTbp7EXF3ZSr85V4OZCc+AYC5WFW0imwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
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

On Mon Aug 17, 2026 at 3:00 PM JST, Alistair Popple wrote:
> On 2026-08-10 at 23:55 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote=
...
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>=20
>> Add the `VramAddress` type representing a physical address in VRAM. Also
>> add an arithmetic helper, comparison, and operator overloads which are
>> required in later patches for address arithmetic.
>>=20
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> [ecourtney: create mm.rs here, squashing in the arithmetic patch]
>> [ecourtney: splice the two commit bodies]
>> [ecourtney: drop the Pfn fields, open-coding what bitfield! generated]
>> [ecourtney: drop align_down and the IntoVramOffset/IntoVramRange traits]
>> [ecourtney: make checked_add() const over a plain u64, derive the orderi=
ng]
>> [ecourtney: doc wording, header, import, and signature cleanups]
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/mm.rs        | 60 +++++++++++++++++++++++++++++++=
+++++++
>>  drivers/gpu/nova-core/nova_core.rs |  1 +
>>  2 files changed, 61 insertions(+)
>>=20
>> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
>> new file mode 100644
>> index 000000000000..dcd5e5e919bf
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/mm.rs
>> @@ -0,0 +1,60 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFI=
LIATES. All rights reserved.
>> +
>> +//! Memory management subsystems.
>> +
>> +#![expect(dead_code)]
>> +
>> +use core::{
>> +    fmt::LowerHex,
>> +    ops, //
>> +};
>> +
>> +use kernel::fmt;
>> +
>> +/// Physical VRAM address in GPU video memory.
>> +#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
>> +#[repr(transparent)]
>> +pub(crate) struct VramAddress(u64);
>
> Is this the best type here, or should this be bounded via runtime checkin=
g to
> ensure it refers to a valid address?
>
> I was going to ask if it should be bounded to reflect the physical addres=
sing
> capabilities of the GPU in question, but that would actually need to be a
> different type as GPU physical addresses might not even refer to local vi=
dmem.
>
> Although I think that's a concern for future series - AFAIK PRAMIN can on=
ly
> access local VRAM.

Yeah good question. I am looking at memory management stuff after this,
and e.g. how many bits the hardware actually accept for physical
addresses (e.g. page table structures) is different depending on the
hardware. So it's not trivial to determine if the address is valid
without a bunch of extra info.

So the approach here IMO is just to tag it as a general VRAM address at
the type level and gradually apply runtime checks to narrow the type
into code that is more specific. Since our HALs use dynamic dispatch
based on the chipid we can't avoid some kind of runtime checks here
anyway.

I think it makes sense to say VramAddress is a local vidmem address, and
later we could e.g. add an enum to distinguish local vidmem, sysmem,
peer memory etc. This appears to be essentially what UVM does
(uvm_gpu_phys_address_t), AFAICT. What do you think?

And yeah I believe PRAMIN can only access local VRAM and sysmem (on pre
hopper).

>
>> +
>> +impl VramAddress {
>> +    /// Creates an address from a raw value.
>> +    pub(crate) const fn from_raw(addr: u64) -> Self {
>> +        Self(addr)
>> +    }
>> +
>> +    /// Returns the address as a raw value.
>> +    pub(crate) const fn into_raw(self) -> u64 {
>> +        self.0
>> +    }
>> +
>> +    /// Adds `rhs` to this address, returning [`None`] on overflow.
>> +    pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
>> +        match self.into_raw().checked_add(rhs) {
>> +            Some(addr) =3D> Some(Self::from_raw(addr)),
>> +            None =3D> None,
>> +        }
>> +    }
>> +}
>> +
>> +impl LowerHex for VramAddress {
>> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> +        LowerHex::fmt(&self.into_raw(), f)
>> +    }
>> +}
>> +
>> +impl ops::Add<u64> for VramAddress {
>> +    type Output =3D Self;
>> +
>> +    fn add(self, rhs: u64) -> Self::Output {
>> +        Self::from_raw(self.into_raw() + rhs)
>> +    }
>> +}
>> +
>> +impl ops::Sub for VramAddress {
>> +    type Output =3D u64;
>> +
>> +    fn sub(self, rhs: Self) -> Self::Output {
>> +        self.into_raw() - rhs.into_raw()
>> +    }
>> +}
>> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/=
nova_core.rs
>> index 35a8b1214b0e..8f59cfa97017 100644
>> --- a/drivers/gpu/nova-core/nova_core.rs
>> +++ b/drivers/gpu/nova-core/nova_core.rs
>> @@ -18,6 +18,7 @@
>>  mod gpu;
>>  mod gsp;
>>  mod mctp;
>> +mod mm;
>>  #[macro_use]
>>  mod num;
>>  mod regs;
>>=20
>> --=20
>> 2.55.0
>>=20

