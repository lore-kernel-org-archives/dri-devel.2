Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C96C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E47610E0E1;
	Wed,  2 Sep 2026 09:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="naBz1x0D";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148B810F088
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klWIqWTVuubmDYSUyA16T1fPhVkyhbhh+PsL9jDKiGTix9I7IAMKob70MQQnP+YiOqlK8v3pwG2q1m+aR8e0UM9t8/umhobE6BY8HJnV4TNHIUQw7SzepcMRGfPg0ccRgdbGf4krsPDiAf5D88WrMwcnBGL2Es/PRj92gz+ImVS4re9qbwPq0376faiCfru0E3snYdSqR6eG5AnANBnZFZcJKSctvtTeOVWAwQ7bc4DMWf8ixKRqwd2DqqliAniK04KaOvzjhRcGRGfMDIQq1mN6a0Q4h4r6Un06g/rVatJx4zw00MMNy9EFjyR+ojEBl+TUi8GUCJy8YqnJw1ckyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3+tP4oP1+Op5GkPmsE+EbIy0q7uqlwIM5xh+GQKNZU=;
 b=Zw0ALGAM2jrC+g97mf7Lp+8566qZjnOxQrArmdCyYsBFfd3DMTiCyIKc6/oGSAcRVi8TETavAnHZjd5Jr1xQ8p8FUyQAmzf3BHzGptTmbWS8K1E3IkBItqDziMmbD90NQxoDag5iHqhq0QW+bo9VMW9dzH1TiSWZES4yCVlT/pWuNyS3AsOOsjxYrCuDd3QISPaHqXnfS7DqQMs6N7EsDPsVTJIm0eCma4kpi4xvWO2lFfebAncroj6FL587cjQAspGqrWhIXDU0nRsfugZ7LYpK5cciSpbMnF2BL0WSIQJ4w5FHQxcYLbwe0A5NDcxRtsN92HfPiXX1OdRabWT0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3+tP4oP1+Op5GkPmsE+EbIy0q7uqlwIM5xh+GQKNZU=;
 b=naBz1x0Dq5ewm/zYgMWyrOfp41hUD9REeNCTD+c7rGNGdkXVUa9JgVQg2GQDfzpDExNzqUhXi8BKEo56EtBXYzOpMbdw1GIlsZfRKl/HkAtPwoz0YhX2XhR4k5e1sZBbDT6/TFPjslwRu0k/wwSMb/9iXfGMTHdm7eXayG7q7NyMFXQ2TAefM5hEJf3jKKMy0jJlDxzmQJ0mlHiqecX8SjViws+Kt0zmSZFC0cG0qO7aIvnXx0WSFtx3FdN2DLU7ciewqSfwbsXBAPLclgyY5PGl0LYgKu9fSJClQ4FOAp6+lKKnCSSIRHrbf3r4eG4UaC8vmF9eQDvPrlvc9YNgnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 09:17:00 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:17:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 0/3] rust: introduce cv! macro for safe const
 conversions of integer-like types
Date: Wed, 02 Sep 2026 18:16:39 +0900
Message-Id: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOwU4EIRBEf2XCWQw0DIE9+R/GAzSNi8nOKMwSz
 Wb+XYY1UY+V1HtVN1apZKrsNN1YoZZrXpce1MPE8OyXV+I59sxAgBEWLMfGbdTkZkgoNbJefC+
 U8ueQPL/cc72GN8LtIH8ahT6u3b7dayz4ShzXyyVvpwmJnHKzx2iFVoGE0TrAjEqH5K0xoBIEp
 2Z22M+5bmv5Go+bHLK/55rkgmvrpRUxoUb7tLQcs3/sY4Nv8Ms4IQcDB6NNQOMi+Ej/mH3fvwH
 dVuh4JwEAAA==
X-Change-ID: 20260828-cv-8d4e952fc14c
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 09783691-2c38-4e39-5108-08df08d2f1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|921020|11063799006|10067099003|3023799007|18002099003|56012099006|4133799003;
X-Microsoft-Antispam-Message-Info: AriQkXPdSGKuL1lk9bKQhk18AYCPGMXjGwnPACbTGjKtrcy3AQJ5l3n867OwiJtki8Y9uwH4y71wvrCiGajlAGbiK2rUJJFAf9GPhft8RE7d9tTp2QTimsyxVRmWg91leVtXjuwrcHh4TFuF+fO7AFKAZse7JozFvyvKXt9JW8R0KItkaDAEbqf+Tko5LaXIt/X65AFFQX0eBvUg9kJ06ZLR8G4Rd4MTy7PKDGCgwGqUtc3q4JCJI7xeh/Fm5+A/oRrYU4vF66NGslbQtFTQd0y7f9qAV5Yxbyjuy2vnZeFoZ4gY2Okl14L87kdcmgL4p3KQ50sTjrcPQrtGq9C3H+CMwCMOdPoeaRBlOtV/4cOA1clQ6FzLdkqFBpJryQJqtPRDfbQ5hzgXZgGrZy224vPLwAut6BRDmSHpT95FvNPODmDefBcFhZHBFnIFkYGJFvOHTlKQ/Dq7RitSBpYeXV7PWJjnh5TXdui/IqIOoAhF5eyM0TeNwqpIhD2n5W9l76j2sTYEzFC9GFRFINJy4wQqrUQPyc1sSW2omYjMcZPsfnKilZEm0bS+8hR9h4Cr20OxUfGDGew7aHc0+qpqPy+8ogtvFshIrUNxfFqDuWNNAD/cELAb0ofUtR+3nMZEaUVHYVO9eJAafUz41/5iMkKdTn6SkLC3AyMjYstLpCXyDN3ZdlQxCur/v9i9+Yaz1Xfo1xwQ037VEjFpespdfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(921020)(11063799006)(10067099003)(3023799007)(18002099003)(56012099006)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJsTEhrdUZSVlNsOVNmSUU2OWZvRVJIKzBya1RBNy9VaElmQkg1L1JsSUJ2?=
 =?utf-8?B?cElQdlVDTjN1TDUvSXIwYzdWZGdIdWNXTjFZOGdCN215SEVQUkVMUkJFV3V2?=
 =?utf-8?B?d09FbFVSakZmd1BOUDJ6Q1M4V2ZlQjg3V3RmY2hPd0tZR3dhZDN3ZGdTS2o5?=
 =?utf-8?B?eTlXNHNhTmI2TklsaWFKT3VBd1FvUnhHVTJ0M2ZDMDRrMzJrOEltYU82WC9P?=
 =?utf-8?B?Ty9aOEdFSjdueFNsbG5CcU9xaGovVk1obmEzdXBEZDRpTUY2RjBNaVFxRXRn?=
 =?utf-8?B?MU5veTBjenRHVWJ0bkg4VllLcEthSUdVTmpaQ3krTU5yMHlyNFVGeWVYUEZ4?=
 =?utf-8?B?VFdYTkgyTndnYkp6ME5xb3RtaVk5d0V4NmtiazZ1bDJ1Y2lIY3NUM2MxVDhz?=
 =?utf-8?B?U0lBOEtEa2dOQW11SDFMeFd3dXQ1d2RlcmE4Mmc0SnRJai9qQk80a1ZIU2ZE?=
 =?utf-8?B?TkY4ai9GMjE5ZlJHcmd1UjJLR2pYa1NlbHJBRGVkTERCVS85MHhIRGxhbHVo?=
 =?utf-8?B?cTlhaW42WVlkN09LMUFUczZlR3E3aHBQb3BIYTEyS3NYQm1yUlNmRGZFTzNk?=
 =?utf-8?B?WXhHV1pnTFhONTNGUDZtN3V1eVVXK2ZyMFJkVU4yZnJ6TEFwYzE4OUc5WmNy?=
 =?utf-8?B?OW8vU0RNQXFvNTdKNHhoSVh1Q1lnMGRrRE9EZSs3L2hNYnIzZnByNFQzM0dO?=
 =?utf-8?B?dkxJTTNISnZkMWhjajFMRkR0Mld5YVJURnpWSTljTlhJcFJCSVl6RFZCcjBV?=
 =?utf-8?B?bVp1N1NuR0VORWNiN0laYW1VMkRmd3Q2aGlJbTNERERlcXhGYjZnNW9xQzRY?=
 =?utf-8?B?emdVSzZRZVBYLzZkSTdnS0NnYnIzRXcyM0FDY2ExTzRJTUtrRGNYMUFQYUY2?=
 =?utf-8?B?MFR0MkFsTnlWOFRjNHZQT3FnVDFneEpPQ1owZE1HR3BmdnZ6Tm1iMlNNVWla?=
 =?utf-8?B?elN4a3BQRXVleXJXSmtKQW1SSFJuK1dIa3NFUHFKUU9ydkFCTVRLL1FGaUht?=
 =?utf-8?B?NGdQVllpbjNCZHRUYXB5Um5aR2VEQWNPZmJDYkN4ck9iOUZBM1Vlbmo4Zk5s?=
 =?utf-8?B?aGtxcjB1Q2Y3blROeWg0N2pERnFEaTJPeTVaQ0taRWtLVHdPQmdnWjZJZmEz?=
 =?utf-8?B?TzJ4aHNrNmZzUHBzVkc1K1hHYWVOdUxYR3QwYWN5c1JSb0tZQTBPc1N1ZUdv?=
 =?utf-8?B?MDFxRklINWFuQTd6WGVMY3ErTmVNSC83SndmNDh2UDBYVVpYNjBEbk51N2hK?=
 =?utf-8?B?cThhb0JCYTd2cSsvei91bzArS2hzeFBEcGpua1FJSVJBUTRyWTRoaTJZZ0s5?=
 =?utf-8?B?T2FGanBkK1pZNG9rNzkySSt2RWlmYU1OMVB5cE1peU12ZGdUemJLMGw3Y2p4?=
 =?utf-8?B?aWNiTTZYZ1YzMkJXTVFydWNCTXpHKzYwYWM5b09rQU9NeVY1ZlNqMDhES25q?=
 =?utf-8?B?RWJ6QlY1TU1abFdsRldIRGUxNTd6M1pDQWdUOHZVM01LNE9SZ2s2eGs5TDJY?=
 =?utf-8?B?RWpVMTgyMGYwREg0dFlWK25RUDVxdmNNQitLUXptSURtM20wN3VvTjZJaFoz?=
 =?utf-8?B?TVNySWVSWWhxOXJpTCtWNVNaTEc5VldudHlta0dXMExHUGlhMXRuRHRhK1Ur?=
 =?utf-8?B?ZUJZNGFhVFlWNTJscS9zVTV3OVVQRHg0ZW5Ua05PZmk1ODlwYXM5K29vWlNY?=
 =?utf-8?B?TXYzY2JsYWJmbzZXRDV5Z2JDbllHbGFMa2FGaHRHTlh4dyt1TTVWY2FrVGI0?=
 =?utf-8?B?TnRnUUdmenRoK0dYdENVbEtmRXR2WEFacytTOEJUak9ZOVpvekNLWklHZkp5?=
 =?utf-8?B?MG1HL3Zob3Y0SmlrbzlVdmNhSkRLSm9BUk4wdlJPRHhDc1dNak5ydnJmY3Zz?=
 =?utf-8?B?ZkkrMnhLaW1VMVpyTEhTOWpxWlg0dWdaQUJNSURWNUJ6QW9KVFFVeUF5azYv?=
 =?utf-8?B?QnBseEpIMzNubnA3dEQ4L0lsQ2VrTHJEbVRCV2xCWXhqaldqUmdEMXRSTDRj?=
 =?utf-8?B?Y3JBY2x2aG9ZMWRIZ1EzVk5MWGNDT015d0cvR3JPOGlMOVo0K2tUZm9DUGs1?=
 =?utf-8?B?MW51dVJDSHZuTzF3SzdJWG1jbWFsTFJLNEFhRUxRRjdGR2hJRVBXblg4Zzdi?=
 =?utf-8?B?SUpraklPb09DVU52amc3blZleklzOVRTa1AvZkUvRzhvMExuTnlJejJKQUdp?=
 =?utf-8?B?Zkk4akNiNnVNcDhCN2lQWnoxa3ZGdWxFQ2pReHNLaHF1M1Nac3I3VUZIOS9w?=
 =?utf-8?B?WnZ2WFdyNVdqZEp2a081Rk95US9SbjVjV2JHSE8zZTVNQzF3OWcvVkJYT3ZC?=
 =?utf-8?B?RXI3WC9DdVIyaHFPaFg2Z1pRaTR5d0dYdmlSNjY4ZTlmdjhibE56TCsrcWZv?=
 =?utf-8?Q?9qL5R++F6EwagtvLgZRZNwdqxGaOjZJrwovnf+g+XcWUN?=
X-MS-Exchange-AntiSpam-MessageData-1: GvcQQme2tM6fpg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09783691-2c38-4e39-5108-08df08d2f1de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:17:00.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuM3A1rRxwetbjDBBgyxP8yIIUfeQt5UxhJFDu9R3CKF4d9I8zRzyO8zAjtD8ISyPn5n/H3ZedpN1Q0S5Ul4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

This series introduces the cv! ("const value") macro for safe compile
time conversions of integer-like types. The syntax is `cv!(literal or
expression)`, or `cv!(literal or expression => type)` when it needs some
help with type inference. The result is that many expressions can be
rewritten into a compile time safe (no `as`) and less visually busy
style, for example:

```
- const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+ const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);

- .with_const_msg_type::<{ casts::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+ .with_const_msg_type(cv!(MSG_TYPE_VENDOR_PCI))

- data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
+ data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],

-pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+pub const NSEC_PER_SEC: i64 = cv!(bindings::NSEC_PER_SEC);

-//! let b = Bounded::<u16, 5>::new::<0x18>();
+//! let b: Bounded<u16, 5> = cv!(0x18);
```

This works by defining a trait `FromConst<const V: i128>` with an
associated constant `VALUE`. Then each implementor sets `VALUE` to a
constant expression. This works around not having const traits. An
alternative idea from Gary defined a FromLiteral::from_literal<V>
function [1]. This version essentially moves the implementation of that
function to the const block of the associated constant (since it has to
be executable at compile time anyway).

This is based on ideas from Gary Guo [1], Alice Ryhl [2], and Alexandre
Courbot [3].

One (potential) limitation is that const generic types or values can't
be used with cv!, because it requires the const generic expressions
feature. The const_as! [3] macro did not have this limitation. This is
worked around by special casing conversions to language integral types
in the cv! macro (essentially subsuming const_as!). This special casing
can be removed when const generic expressions can be used.

Some code is taken with permission from Alex's const_as! series.

The structure of this series is as follows:

1. cv! macro
2. updates to nova-core to use cv!

For a follow up series (I've already written this, but to avoid spamming
a ton while we iterate on cv!, I'd send this after):

3. updates to various other code to use cv!
4. misc updates to other code to remove usages of `as`

We have multiple ways of converting - T::from(),
FromSafeCast/IntoSafeCast, cv!, *_as_*. This series uses them in that
order of priority, based on Alex's suggestion [4].

This is based on rust-next.

[1] https://lore.kernel.org/all/DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net/
[2] https://lore.kernel.org/all/CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com/
[3] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[4] https://lore.kernel.org/all/DKYTZNAX6ON6.1K1372FFAQOF7@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v3:
- Add comment about not using FromConst trait directly (Gary)
- Lower case on const assert/panics (Gary)
- match instead of unwrap() for NonZero + message (Gary)
- Add reviewed-by tags (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260901-cv-v2-0-446bc69d2ade@nvidia.com

Changes in v2:
- Improve error messages (Gary)
- Remove pre-req for Alex's nova-core num->kernel series.
- Link to v1: https://patch.msgid.link/20260828-cv-v1-0-48a180dfc4c8@nvidia.com

---
Eliot Courtney (3):
      rust: num: add cv! macro to create values from constant expressions
      rust: prelude: add `num::cv`
      gpu: nova-core: use cv! for constant casts

 drivers/gpu/nova-core/falcon.rs                    |   9 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   7 +-
 drivers/gpu/nova-core/fsp.rs                       |   3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   6 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  38 +++---
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   2 +-
 drivers/gpu/nova-core/num.rs                       |  55 +--------
 rust/kernel/num.rs                                 | 137 +++++++++++++++++++++
 rust/kernel/num/bounded.rs                         |  19 +++
 rust/kernel/prelude.rs                             |   1 +
 rust/kernel/ptr.rs                                 |  14 +++
 12 files changed, 199 insertions(+), 96 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260828-cv-8d4e952fc14c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

