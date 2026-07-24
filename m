Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F37C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80B810E04E;
	Fri, 24 Jul 2026 11:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKprNf99";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAAC10E04E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfHoeNg4GXIQgP7lox9g4OUHbHaJm6PhMxCER6SCRAphKqSIQDBnoLU3f5mbF5UlcwhIiViv01VY/jEB6TCuG0DJOrPlqpcjtiRH24g8EAQOPk3ATGcIWpR7zuvl6C4rUEq8P9AwelQ22qxBGTctp4FnMB7bFC9vjhdR9yZUL7lvywPUJLmu8IyDTtkHBH5dKEQ2kEyCv4FJHXaf/Z6xL4Nddz1Onqi3Cx6jjVHzLMimv7ZPhwNu0hJDDBvTW5t/eIAes5CA/9l9Ha658FDyoZcjJN30AEwTHn0dysnxQSDvXwlVB9vy2o+uPwXaB5OzLYWF8LX/wsb5RKda7TKedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvVGXGTZSnjjpUhMr8pilyCSsRECy1As/VYK2b9SFks=;
 b=PdO6C+M3PttEtP7X2AQDnnfxlZuzkELf7t/imVnB48yfQTsCfZSyTB7Jgt5A1Da8mbfzjSowykeWjSQay8ATt0USREyPYeecMx2nHanzVF3bIidMQrZzcqbcuKP5XjyGAcdO0iTT/5hKoV8cvXET0CmcXfznO448o61wp0Im8XaNZ5Obx09u6/5yW1bHNyDHH4cd+6r5vT39vrbY5L8TUcH7LZRTNb3GEHV7TRcjVYzGIAVCxGAidRMjEyJjg4c8DVMDqZbinsIC/mDzspKHlPqixBFbAMB0ApjRgDkAoVbqlFsa8lYNpghChehTb34M7Xo2J3Du8YlfVtm2rsPptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvVGXGTZSnjjpUhMr8pilyCSsRECy1As/VYK2b9SFks=;
 b=VKprNf99HcEcP75hJIa2Il2lUGIqN1z18G/3SPyMgEJ25/sg9VYbsaC6GVxgPpoYNBpSjZpEZ4f1zmwa6OVYPvCxyRGUYypCvuRbnmAI5weie8Cc1a71S9ErhorAaaUIA76Ix+Jxt46KHiQZrBLvizO+Y1sQeBxxENz01Rj+v8BSzOdpQklB0pt92om7iDH4GORsFseILs0YEw7UhCjTxNxLkbmY8q5DwzDRMjyC6f7Qaq6egh59UOS55EUfFzJhLO5IFYc3reCDH2XsIIcN+jVCb2SFcnWfzKsJjHZsZIHP86TdpD+Mb1dOk8HfZp+rrVrElUgR6CPKH3lWG4dWSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:37:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:37:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 24 Jul 2026 20:37:06 +0900
Subject: [PATCH v2 3/3] rust: io: register: use path fragment for alias
 destination
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-registers_fix-v2-3-a0fb58b02185@nvidia.com>
References: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
In-Reply-To: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9bf4d6-4db7-423d-751e-08dee977ee81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: stkmRzkNowQenZgVBPpziQQ37O6EFkA64rPuR3Fxkl0XvKO3utjU8qoGc+yyZGgY0gfYabY/H4xfnUw6uNO7VaoQcLRrh5Oe/kOfH6IQ5Sg9iUgPQGZ0u/tR4RmLyDlwI+y5/oYitMta572g5rTF6maR9sXbAen29qe4g8/kPyA2tEdETYgHYCtxPeCBHRoB53tUhWwZDRgtZVEEq5HAqzEvs3/PloCs8Or4+LHY8H/OcEZfhXQJxfhIdhBMHiFzuVumiwpz7vc5ndT0Omyf+wHIbBxsUyTuD3dX47rpRcDc/voxPPE1tqBDcr/Yg7+fLdnxGc+3Hp2J5VGbh0wtkfmoT/HWmpXVJ62ILZLgwyXSGqaybPbd2qu+ud3gz5f8jkYgBs1GmlaGJKId4jFI/DMOpc6UGU7SDdgECeVkPnTAenZ80Vz1v5uMnwuQgePs7iCL/L7CSRkuxCn0Zw0Q3dsRfadpc1AZY8NzLun/MG1ycDk0SFSUcPVjAzBPD3EOStGTQ6ZB+CFnRRgXwXbWxhh6L19/c7+9iF7RPe+LxRZ7lmjwLGhBIyGUm/h30Bf/1G32P5ejDT5MwsrPtboKYlFfjbe/5TS3QOxQucnpE2t0WTa0rNLHSymf4AYto3bRKXBqALxSJm4ctvQMxoOCG9HygrMDCesFbZlaNkyfcUfHxQGK6PlbffjBJxrIJlL0TrxScdnjzrmsSzROXQ1u1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpieWhUQUwrU3J2UURoVzJoVzdQWnpVRXpFTFpuOERXYlBkekpBWXlEcklB?=
 =?utf-8?B?TG9EcThUTGFrcUZLTjJiOVA0REYvU3Boc3UrdHhFMjFTRTlpancyMUJZbHRa?=
 =?utf-8?B?T0xaMzc3MG9QVi9rQ2RFa0NqcHNaWDJ6dk8rS1VIdUNxRGQzTy9ZUkFsa0xV?=
 =?utf-8?B?S3g4QXlSNlNyU01SdzczNlNTUC9xemQrU2oybDFTc0cwOTdFYXVHdG1uRXkw?=
 =?utf-8?B?L2ZLOFV1cFY5czhFR3h5NUJ5ZzhQZkdpZ2xrcnZlWUowS05HZVl0SFVkcnFC?=
 =?utf-8?B?dDQrdHptQkNhczQvM0lCUVZMb3VOaitCSmZvdUlvbnJRR0swVnNFdG9GRUFX?=
 =?utf-8?B?ZDhtdW5wRklWU1BkVml0emplcHVBNU5DQkZrUlJsMDBXQjRpS2dZeXg5T1ZV?=
 =?utf-8?B?bVN0dW5wQjlhakZBUXJ6TThhdm5lbWxuTmlKMXdxanZpVFlaR08wcno4aUVr?=
 =?utf-8?B?UzM2VkZJRUN2aGY5blMzUUUrSmtFQ1Nwb05CMy9ubVhXNXdtRjY2L3RMaGdh?=
 =?utf-8?B?TGIrN21QVUU3RzJrQVhDKy9yVEdmQ1FuSFE5aWluS0FBbTYrYmoweC90L0Fz?=
 =?utf-8?B?bU5iUS9vVXlhL1hiUXRHTGVsWVZqajVsR0NGWWxqSTdBT3ROckc3c3MwQ283?=
 =?utf-8?B?eGdFSStvZEVVckNpQVNHaEYwbUFvY3o4UVo2bXMwS2NSWWVDK0h1ZEhnL3Iv?=
 =?utf-8?B?RXpJMC90ekpuYkp0Q1dEajc3QjcrQVhpdzd6VzVoTHlrYmpQOGJvclZua3Ba?=
 =?utf-8?B?VzBLSFNLdXI3TVZaVng2S0NFVE42ZFhSTitvTkpEcGRTcE8zMFBEZzgwcjB2?=
 =?utf-8?B?NDFvRVFIbTBNZ2NHaXNoWitkYnZ6enF4QTFYQnk4VDRIZFRGTE9mM3FjakFv?=
 =?utf-8?B?eFhWTW0xajN2SUJZWU5qeHRGMDVQNXZ1ZFZHdHVPb2J4aHdXRkhrWVBHNVJS?=
 =?utf-8?B?dW1IVzdCcGNGcXJFZ1ZmUzYzc3FkbDZha3N0R0ZGRjd6bmVUUkUxWm1STW9V?=
 =?utf-8?B?UDJMWmhOY1cxeHJFTXpUaWVVV2I3NWVvcGRuZC83cUlTcW04akNQOWhzanlu?=
 =?utf-8?B?akJwT1plV0l3NjE4ejJIZ1Z3Y0hPZ2RqYW44THdJeWtBcm84Rzd0Ym1nUWdL?=
 =?utf-8?B?ZnFHWlBuTGZKOWlTLy9xQXJYL0EwcExCZGVrQ0VNWXl6MUxkM1VMZkhjZTNj?=
 =?utf-8?B?V3Z3K0dUa2QzK1JyczQ3dW1mN3F5MlozVDlZVDhaK0g1bVZaNThYNnhxcGJx?=
 =?utf-8?B?RVYzTEFTMDgvUjFrVXdKRUtBZVJNOHBrL3hHS052cyt6eFVQNmFOWTlFRktp?=
 =?utf-8?B?WllFRFFHNFhyNXF6OExMNTZUc3NsdkYybVRjSWhsSHVEeDNkU2M1Wi9uZGdE?=
 =?utf-8?B?K3REY21pWDk4c3IvNWR1Yy9pZTNVcTJjTTRwZUNHckpqaUJSUEhJZEwvNCtl?=
 =?utf-8?B?SHZHMzRYMUJvSWNacDV2clNsVlEzWXFIRXlDcVVXa1R2cFFPYkpDTlJPdWJv?=
 =?utf-8?B?aHd3bStxTzlXZGc0dlFmQUFtMlBhZ0ZVRGhPOWJqaExqUlhmZllPdTIwbUo5?=
 =?utf-8?B?QUt3OCtrNGw0aXNVWWtnckYxOTNDOFRFSVlYRG9FWjdEZ1hIcXhXRlZwNmNJ?=
 =?utf-8?B?czJEcUt4NXFobWFmRTBxclVjbjNqM3dFQ2M5V3gwNkNNMDdzU2FHbEdtOWtt?=
 =?utf-8?B?TXkvZnBBdm5wYXo0cUVHaDlpU1dUeTdsWDhyZnJCbHowZUE2aHg3R3BLTVkx?=
 =?utf-8?B?MHdGd3JiZGpjcHB6S1ZXa0ZBZitlNmlaeE0vWGhvdENnZ3hjckFrV0ZVSXBD?=
 =?utf-8?B?Y0gxeUo1VHBTUzNUcHVVSno5dmt6Z29OUzduRU1lY241MXNyeWNPYVpqQ1U3?=
 =?utf-8?B?NnhTaThScHZneCt0cDZPSERvb1paRDJxMXdNTjkvR2pKR2RwVDFRMFI2VTBY?=
 =?utf-8?B?dlRpSnhJbG1taVFSVGkzUDAwNld6WExxcyt0NDFMYTRJQmZRSmx5K0llUnR2?=
 =?utf-8?B?QXdQdzREeWtpcEIrRDYxN2owc1pxNG9yaFk0SE9PZ0NIcmVNVSsydVRwekdN?=
 =?utf-8?B?cUY4M0J4MXZROVoyWm5XaXBnTUFvdUFXREg5NmxpdFZDeGJwdmdSNnZiczFP?=
 =?utf-8?B?bGlVZXRacnF5aTBObEk2c0ovNmZNYVY3Z25XWHlwNXRmL05QRDliRlpNdjFL?=
 =?utf-8?B?Ui9IK3Q3bW5sNTRIbXhPYzRiSzFLU2VhWGpDSXdveG9aN2hxUHN0bEk4RExw?=
 =?utf-8?B?K3V6NTY0em13RkoycFd1VkxPSTF3Z2RVUEMvZWRsYWZadmhhTXMrNnlKMC9P?=
 =?utf-8?B?ZXh1SVE5NUVKRmNUeWh1cG10MndjYzVtMFRZWmdvbTZrT1lmUC8ycjhzMGs5?=
 =?utf-8?Q?SzrYG7wyqoMFbW4q9CW+sV6esAI1HG4udYIpvXe1qwRq4?=
X-MS-Exchange-AntiSpam-MessageData-1: 61OwWtaM2UmnHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9bf4d6-4db7-423d-751e-08dee977ee81
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:37:24.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BS33X3bXRHjbRJqQf+3uTA2HI8CPAmx9OA9RpnwQVUQByed+X5M7VjvYujE0kgKXxt+5pR7/RY58XJBMV2vSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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

The destination of an alias is always another register, i.e. a `struct`
type. Replace the `ident` fragment with a `path` one in the internal
rules: `path` is more accurate, and allows referencing registers using a
qualified path instead of only identifiers visible from the current
module.

This covers all aliases, except the relative register ones which are to
be removed soon.

The public rule cannot be updated yet because a `+` can still be matched
after the alias; add a TODO item to update it after relative registers
are removed.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 32cab54aafff..c945eb149cd7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -804,6 +804,9 @@ macro_rules! register {
     // Entry point for the macro, allowing multiple registers to be defined in one call.
     // It matches all possible register declaration patterns to dispatch them to corresponding
     // `@reg` rule that defines a single register.
+    //
+    // TODO: change `alias:ident` to `alias:path` once relative registers are replaced by I/O
+    // projections.
     (
         $(
             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
@@ -837,7 +840,7 @@ macro_rules! register {
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
@@ -896,7 +899,7 @@ macro_rules! register {
 
     // Creates an alias of register `idx` of array of registers `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path [ $idx:expr ]
             { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(

-- 
2.55.0

