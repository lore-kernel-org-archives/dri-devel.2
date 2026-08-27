Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1EBC61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BAB10E34B;
	Thu, 27 Aug 2026 01:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0iL14ZQ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDC610E34B
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG73pEwyYn4O3z4Xb/ZP/3OXoJFcdyVfw+2CEcXzSHXbqPqmr4xuVEhRVqYTPxCip4IbMCsGuVV01fOy51JBABICwGpo4rWF6iYLatgOLUbqG9mhoSxJmsKykqF4IqiXx89EK5agpChemtj/G64tAdXv24hO0puwN0n5PD3n8MYdmujxfS+1XQFE/7AiNqVPh6SdOj3+O5DiVAYdiBgDPpeNqj08k+YH5GptzifEhO0G6BhvR4hW+QRM0pZFc8Tpa0lW/N7tI6Cu3sAHK4oWIml5l1RivDDgT4CVjEDKpyqUvSNhD+RTRMccKqqC0rIrQiXrGMtMy1RaPlJL9JkWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH/T99PsDNYFPrB0ZoZ4y3D37ZUA4ata24aJhw4Ai8k=;
 b=lKrQC+3PmUlqG8yYh1BZyH941PC+rYITGUlRO64TtItzTUG51WfGJdcwCjzNnr6wukjGqdIr1auSzhQUQLc7m3d2a3EczX/xZ4UOc0Fl8/4yjpDDJLa+VdAT+ZHW1by19iKpiGZmEgNFTKs1ZB1WZjql1RRCXoFoVWxMCxFYS2CN5z3s1t5U8q/KIpLjCKWbn3ltGFugDn6+79rnrqOyhvT6rag74dsof7WlU12Z/c859T+EfC6PeIXHc9zDnmy/S9v39DwF6pL3MekYcIV42azOJxYUXaF1KxoJfmCABHIFplWwJ5bibYbcfFrJyI5gp0SSSFZbyKwH0uo+G6+Ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH/T99PsDNYFPrB0ZoZ4y3D37ZUA4ata24aJhw4Ai8k=;
 b=I0iL14ZQhI02qoY3skqsmbR0YP7iWT4ogEmIRhC1yJaHvUpEzi4Jy/+bNuJ/Zhp2yvDE5leJkaWHuhaoU3ZekO0HaYERkBifABYt5F3frzzQEKLY9dKmjpnIpRdBmUhclIzHYv4tDmGovDp+BI5HWgDcvkOe1q14m8lBlozSkyo8eBkbtlV0yl9NXSoK4tHOZJgHsQao1DMy2CSTrmSgcgSf8vfk6P0Ihgq3iKjBFf6ofzRZIz5TBsKksoulJ0gAXo2Vb+vlgIwJrbIUg5tK9CAxkrmfWnGXvEyBYYFzfps4pTckZ2IFDbkVHzy0a8p0+0Mg30jvwi5xS6vHaotCzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 01:36:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 01:36:17 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 10:36:14 +0900
Message-Id: <DKZCA982UUSA.1CJ3DWAKN1E36@nvidia.com>
Cc: "Jocelyn Falempe" <jfalempe@redhat.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <ojeda@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260826145642.43807-1-ojeda@kernel.org>
In-Reply-To: <20260826145642.43807-1-ojeda@kernel.org>
X-ClientProxiedBy: OS3P286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 723a9268-e191-45af-fd04-08df03db96e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|1800799024|7416014|6133799003|56012099006|10067099003|11063799006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: DWzHSIdSx+GTOmZNqBcrKKPI45r903xq8CQ5oGgL4mGzhgKfThHzyR7sUyLNmJ+6ULoWCw81BJPwN3MvT8tlPq98Tgnln4z0U2cv2fGOkn2B9Havf3loyK/kiKvaZcYDl1lg4zWHHyweseEcYhd4E0lJrUVrgZdQ90q4fn3xjiKPkFa6jGnEBUC+NKhGVyjSELwQPTu+teFJi7pkwVZ/RD0SPq/tmrPZkaAEect3YSAl2DZ4JoVue9LMRAs/CJNOurg5Bo7mAxgcAoKRUFHzMb4dJuK21YfmUEYcxDXDlAAcREcg6YEr043UZX2LmMhOWTM79ZZl0IqdkpYHotrvwVyhkIn1uMdJTZtv4YdN/dp1Xw5Ra/1KoCp2DmEkwAKJepnxobvZt/459f8n4tkAGZTP0CtgWQp9aMpIRREJRRzBEAPSDUkMDD3kfn+cKiprGLNK+hXp5cKV4K65aEMKekPL4Y0jlpb37Rrc/36Vh+mY0nl6hS4pMjG9XoXXoqIkzp88nF4P+BN8jpZwSWdEDImYHkvUdCTb5sDpvRv7NszMMXFzyNPVXSI+hI/EXlAHtJofCwT7IRAPjW7ttzvQkvQ2CMpxhMrd0WvA+45QlcRCGwGAhJfy5d3O5ZTepyEJGa0VnH5CYTW6xAtjYRjIq71yFH9rlHcffAuhkaYpZq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(1800799024)(7416014)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZvS25TZGh3WFdCcXh6K2xYa1kvbmdRTDBSRVMreFlFR2ZjUlByMkNEeWJh?=
 =?utf-8?B?cnVwSkt2UmUwM3ZvV2xaNVdMSTQxYVIySi81YjlNNnpycm5CbXkvSEpzOHkz?=
 =?utf-8?B?dE1aS3RCRWhTVE0rTm9tTzZIVm95bWtQQzZXQkRHYXcwWWplYTZtRDU4Y1d0?=
 =?utf-8?B?NVREbnFxS3lkNzlmUUh5YjJvMW1WSnNvK2RnR2NZK0hEbEYwRmdhaWd6dFN3?=
 =?utf-8?B?U2VBT0lWaURKZDVlUE9ZdHFQcDRqa0xFeTd3VUFSMzZSQ3VwK2E4UWNONklD?=
 =?utf-8?B?V3paRzRxQldJQjRUWjgvVDlFM0xhc2J4SFpXaG1qMGVNQXlEYjFEZG5LTFQ4?=
 =?utf-8?B?enNob3B2TWczK1llRVY0dnJoREFEQmZUblNQZDNWVzlodkNFSktXZWp4Z0JQ?=
 =?utf-8?B?eHJEZnorZm05YlAyK1RFdEx1ZklPeE5VbktOazJIMG41QlJ3Yk9oQTdTNlhj?=
 =?utf-8?B?S1ZYUzJXci8yNWZmSXJ2MExQS25rMmFkMVEya1RhN2FKWERCZ1pBY2dJNitt?=
 =?utf-8?B?bEk5R3BYYzVsWFVNV3lQeHp0WGEvOUlPZEpNYXJ1UGl2ZVhDTTVkcERuMWNL?=
 =?utf-8?B?OHJWODJNdGRGdGZqOG1OWTZoV1AwWE9rUTJVdHpLdVBuRmczTVRGSXY4bVl2?=
 =?utf-8?B?alBTOUFCalB4L3JwRWFONVU5YjNXdkFVMldaeGUxUDFpVGIrbGsvbHNkVXVq?=
 =?utf-8?B?QWdEMU1CaTc5V0oyaGdwaUpNc3d4dEROb0VaSlhMQVJnK2hQajVvaWpOUWZK?=
 =?utf-8?B?KzVSaEovbEVGb2EyMGdmVy9CNXIrWDhYM2JaTUxHcEtlTUd6YXZ5WHJPdi9q?=
 =?utf-8?B?RUVqU0R0REZPTnE4KzFqdWtEZDhMb1lPTUtzb0RId2N4QzJEQjdHUCswdW94?=
 =?utf-8?B?K0hhZ1J3K3FHcERmUDNPMko0dlZmejBrZFkxVmJ6YUJZb1BvMmVXblFvUktR?=
 =?utf-8?B?ZzJ6L0V0VmF4d29NUjdraWFjMS9xY3VqUUY4RjB0WnVmVmFjcytQa2Y2T09t?=
 =?utf-8?B?dWlrMGsvV1RPV2ZiWUhWbXFQY2RRT2lkSEdUOEMrSGlSdVFIUzhvMUxxaFNo?=
 =?utf-8?B?MHhoZnJrbHB5V3BrSVk3bEpscFEzMmRYdXFaVysvb0FyTzVkZ291d0NhWjN6?=
 =?utf-8?B?TUVFc0QyK0pmTkg2RytvMFlhNi9GWTA5YTlCT0F5SXlJWjRnTGZBSll3ZEdV?=
 =?utf-8?B?Y01qcFV5SHcxN3pNanlYVHcwcFRpRy95dXV4Z0RCL1JqOGthRkkza0IrejBm?=
 =?utf-8?B?VUZCUCtKNEZiQUk1V1pnaUROTXdBcnc5NW4vUjNMcEJLbkNOWW9lckJ3cTcr?=
 =?utf-8?B?RGRHQWZIZ1ZOc1A1dktIcmNKUTZPTmpycyswdGxTclV4R2tyd0ZBR3hRWmNm?=
 =?utf-8?B?elJPWlJVVTRHUGJWSkkydnc4T21GekZIR0VNSnBlbnpENS8wWkxlc1hJbWtj?=
 =?utf-8?B?elN4SHFNbzJEeEk2ZnAwWEgrazVIQ0FiYndrRHhSSVBqMzhmZnlPSWFSaHlu?=
 =?utf-8?B?Skd1aU1KQmtUVXYvSnEyNkNia2tQaVkwNW14b214c1h4ejFVNUpqOXdKSU5R?=
 =?utf-8?B?eklYT3RHZ3YvdVlLMXFTU3RXRmVwZGtzRUZXTHhnZXF3Wm9FVXBjQTVpTWdO?=
 =?utf-8?B?UWdqd1lFaXRGRFg2WGx2aVYzZk0vSzlNU1BzRWNwUmxYZlMzTFMxRnZhalRL?=
 =?utf-8?B?TjJwQlgydEhFclJCMFpHbzczU2FmYUlVZXFWdTFPckZKaVVLNkMyeFJ5K3NX?=
 =?utf-8?B?RDQ5T2xwRFR4S1M3ZHhUVi9CYTFDalBsVzI2VFBTdWkyYTZ5ZFlqRmowamg2?=
 =?utf-8?B?Vi9GL3BHL3d2NzhhVmVEVmNVT09FaitzL0tGZWE4S0xGZ2FvNDNVZ3hBVnBu?=
 =?utf-8?B?TWwvNHl3U1QrMjAyczhvcmo2RW9KVDhxZitNQWNKcjhKTUZVM3FmS3ZrL2VN?=
 =?utf-8?B?cjhWZUZlVkQ5dDFuOWVzTjI2WWVqcFRERER2L2FTdFFJT0tLYlVjcklyc3RF?=
 =?utf-8?B?di9EZlM4M0dIODdUY09jVVF2d2pWOGY1RDZWcDVCR3JhbkFKbUhpUExhajdZ?=
 =?utf-8?B?Yk51dHZLS0U3ZlhSb0NkYmhna0dwVDRsRktUaUp3SE1ycExTbHozbUxBNnI3?=
 =?utf-8?B?TEJORVNzUDVSVlJIKzBUTm1jTGNSQktoeUlrY09lZTMyUEc2cTk0SG9rZVhJ?=
 =?utf-8?B?dDI1UWlBSDZNdE5PMWZlZGxiOUNqendZSUtIMEJBNmFmVERabjF6YW54UXlQ?=
 =?utf-8?B?djFQVmlESyt4Yko3T0djQXM4MUxCcDdJWStyMzAwRHBHRlNpTXZyUFd6V2Rr?=
 =?utf-8?B?QTB4YkpPUXFnK29LNkNaV21rZytlcFpxRjVWUFZKKzNPK0RSUEVOQ2wxMDVI?=
 =?utf-8?Q?fpNJx7w9m//23u7G9LluxK4rcaOIXNK/j3lr6I909ccyn?=
X-MS-Exchange-AntiSpam-MessageData-1: V3XEUNqhed0I9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723a9268-e191-45af-fd04-08df03db96e3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 01:36:17.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv25zJ0M3DcO5gYnMytwiquX1R8FdTZkyAz7UR8nt/mBxu9wxjUoGEX43aYTBD4gOibSv2bnWW5NLwkKVNOM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
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

On Wed Aug 26, 2026 at 11:56 PM JST, Miguel Ojeda wrote:
> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>
>     warning: the loop variable `i` is only used to index `self.decimals`
>        --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>         |
>     410 |         for i in 0..len {
>         |                  ^^^^^^
>         |
>     note: for this index operation
>        --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>         |
>     411 |             self.decimals[i] =3D (chunk % 10) as u8;
>         |             ^^^^^^^^^^^^^^^^
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/main/index.html#needless_range_loop
>         =3D note: `-W clippy::needless-range-loop` implied by `-W clippy:=
:all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::needl=
ess_range_loop)]`
>     help: consider using an iterator
>         |
>     410 -         for i in 0..len {
>     410 +         for <item> in self.decimals.iter_mut().take(len) {
>         |
>
> The lint did not trigger here before because it could not handle arrays
> behind a field access such as `self.decimals` -- Clippy was improved to
> catch those cases [1][2].
>
> Thus clean the warning by iterating over a slice rather than using
> `take()` so that an out-of-range `len` still triggers the same bounds
> check as the indexed loop.
>
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
