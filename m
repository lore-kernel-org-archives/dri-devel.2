Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A60CD3424
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 11:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C0889317;
	Sun,  3 May 2026 11:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="a9zzlAKb";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58EB89317
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 11:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n413CyF3L5wJOTLlMVlzccOGxrJjAuP30iJCJOQ2flADOeFEl1XOPMrbGypGtsAJvDImjGwBfViAdiZLc/0KlUsuMxKtjgCbTgqp7jlYL6vWIKY1gmo3cItXWHCYCLZ5Rzy8M60rpYp6oEOwE1ckO4ZClmJcvI8u6GkxOMebDRMdFUPRUxJ2hgwLRONqaE+vPheaLlAvgUAEaaVfdJCJYxdA9aL6J0fbKoBehlaUfQNZQ01CxAOp1Hba26ckjGwEyz5+YorChb1kM5HqQvzcoB4zbsI8M957/Lb+ECyedSD5ScwDoQ4iKlAN1vP6QOUhKA60JdW8oQZsUfW56OG+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03z1WcPcqbPysOLI6x6oFuExaXWdHn1n6GZF0GRqUPI=;
 b=W/gXkjCQxZrgsQwDx/ddtv8YHDf+0mAa7korR5Oc3UlkeEmu6GiYqlH4GV9pXgKoBBVY7MKwogh1DCrQC9ouE7s1u5S6AQBKWspqeANaR6Glcmj/tdfhZTC4tRg8sIa6UpufFozVElRCebP9y5CY/nYSIACoWsJIXf4GKgHuPOCNWYIORY3aDb4ReHMyjvg+pGqGEvdL/TE13oX8k1nWByyKFGMnrOGGr1j555yNXGDQ09Yula30he65o/zJ8kV/qajLSLGNa/fRNrJqUQeqPnTGJhWL83CSvZ+KaI92K6+e9zGDULgrByXKoG0rr9AWuwljzqFPweF3HcQchEBXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03z1WcPcqbPysOLI6x6oFuExaXWdHn1n6GZF0GRqUPI=;
 b=a9zzlAKbTsBGNWIzYuAlCM7u8jU19B0l17HqkHb5nY6de8ZOjBaNUMN3uZDnFlNljrJUKzUgbZfmWMYxCYaX2PrHGzG9PQXhl0jVJ4cDjpgoiJSOLbkmIwAen6kAzfwKMb7ONOy6rKh+tQyJMbSQiBZk25kHObYI2KSWwPzlmNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2912.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:172::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 11:49:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 11:49:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 12:49:31 +0100
Message-Id: <DI90OMLB4VUA.K4AP08GH7I8E@garyguo.net>
Subject: Re: [PATCH v2] rust: drm: fix unsound initialization in
 drm::Device::new
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260501-fix-drm-1-v2-1-5c4f681837bc@nvidia.com>
In-Reply-To: <20260501-fix-drm-1-v2-1-5c4f681837bc@nvidia.com>
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3381271f-ec8c-43f9-b578-08dea90a0a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|10070799003|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: 30343gAOQbmLCTBi7UA/NBKg7/+9IoDUksvpXN9/5jUwBuaAIBnlLjbwCBAfJ9JchFdq52KBApOaKAhHk0BS4gJf62SZYtV23mSgH5scBh6hXStzEbFnqz1zdZcsoFgulBr6HEG1Mc6UGky6SBTgKORNXV+FjfF4MKitDlDYlNu+gdLuOw/9K3tqEKfTwZKOyr0+9fPm1OuP382FPVSXo0IBf4YWIBtH9795WKnNz7dDiTr3nJSa/wUgbXq7ONFqs3q+E9NSDmIKjlIXD8F5XVKj9O5TN9Q8rG/owWLv/6iPOWw8/I3mvrDpHyXUJMHtmjbY6Y11AoEwrtlrwZ2D+CqZOL1gccJ6SSGvn7AaoJkdMAAjlhIoxU0vSaOy9aeoysiQ4Onsbw3c5Fnxpx+Al0b8yj9UDZwz5qomW7uqD6XV/aB3yQJpOfLpkLIH4M6W6nvTCk9nuRPQDkILk6YzeDq2epBa0xe/PTFzFsfQSMbGFTk3DCpPtXBU7HM+BHorXPjo2CrX8XzKk6QWyvj4E3mVfU0iam6sj0lA7mOk4wf/F2eUz88EtcBXscAPDFxf3gaN6/bvoyF6vsoiiDQeyqsT/SmS6IfJrLhYJHgsPRDzhO7mEkU0wwiEPYHCcdD1hXogJIiq3QJmSCWlIsPYeTlQSIHpSjX5aLQAnGd+RqAJVK12nOO+lyFmPjKz/xdq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VRTHZVV2FKYlBZeTNiNDVVSUthemxxQzJNRXVIZDRHY1Q0RUV0QW1kSVZk?=
 =?utf-8?B?M05XQjJReVlVSCtCWFNoelNKcHNuNVh4UXArVE85SHozams0RTFuVWw5YzJN?=
 =?utf-8?B?MEVtSEp1emw2Skh6QjdULy8xK0VORFU5MzJhVlZ2NnN6VFNpN3htTTgyUTNN?=
 =?utf-8?B?aS9XK2QxUThkZmVHeVd4MUZlakZ3aCtKSE9LWTFYdTgveFFvVHoyVitWVTlH?=
 =?utf-8?B?c1B0YTlKS3FzTTE4WVRFSWQ3dGhMbzRuZEt4eUxkMzZCakNZMWFTcEhFWG4r?=
 =?utf-8?B?VGtGNU1ITGRNRTFHZERhTlJoYytXOHlRbVdNcTArK0w1bGFGSlRmYSsvZFoy?=
 =?utf-8?B?amdia0RhRmxvRC96QnBuQ2tkZVFJeTk0SFB3YjZWSHJUVEFzS2hIQ3ZkaWtS?=
 =?utf-8?B?MUNONE9qRVBZZzNWMzVQdENGNmhVZ1lNdlpEQ0FRYjhodDJ6ZzNZS2ovZzd2?=
 =?utf-8?B?a0dOLzk2VXhhaStiT0xqMkx5YTVUdllCOE5XVzBSSUZscVVqR2ljOG0xVEVE?=
 =?utf-8?B?bWpsMDQvZEtUaVUweGJZWmoxSnZJSXZhd0huWmVKdU12OEVJZ0lFNjVISkI1?=
 =?utf-8?B?WThFSTFESzlMSVBXQ0xHNGpRaTFOd0RNd09OOG1vSXpET2IzdGdZbDRuMW55?=
 =?utf-8?B?dEFORERlNmNjc05nQWNJOU5MMnEyRGVHQmtRWlB5M2xoRVFpeG9xYWNoei9Y?=
 =?utf-8?B?YnNiU2hKZmpab3ltUnlRanNneWFtVGNNZ2tLS1RUM0EyRUswa3l0aHdjVi96?=
 =?utf-8?B?RExTeTEwc1pZNjV4dk9yaWh2Z25yamdFWkdQaWErWkpEaDlnNU5hanV3Qzha?=
 =?utf-8?B?QUJpbHgyOGtTMFBXbmhDWWxVWkNEYXkrWloxdmhyRGE5RXYvUDd3M1JlZ1Zz?=
 =?utf-8?B?ZnhLQmJXdGVsV2dUYnp1RDhDN2EvblZhK3ZDNXlVWlZzeXdFMlZRRXQ3Ym5q?=
 =?utf-8?B?dDZDdVdUekgzRWV2ZWtSOHJlZVVIcW5lK2l0enNYcTBKNmNHUkFBNmVQaDNq?=
 =?utf-8?B?WHowNndnNVIycW80TVZoc2ZrbnVYYkRab3RCZUptVmRBNDg4R1F4bjhENmVE?=
 =?utf-8?B?ejBiR1l1WVF3NmRIZm9jMnIwdGI3WjVaa0grQ1p6azBTRnpkTk8xN3ZOMXpZ?=
 =?utf-8?B?MFA0RmpvRUdRREtVRlBXa2NLb0hrb09LUFNpd29EdHdWOFRaT05NSE1DNk9L?=
 =?utf-8?B?OWY0cUNJdDFudmx4VXgrREZwVlpBeGJuVmpuMTZLR0RzZ1VnS21tTStZNTNT?=
 =?utf-8?B?N0FQelhrTGRncGUvZmFja3hnTkRlU1BmWFlKTjI0SGJmUVpOekpJbDVsT0Zk?=
 =?utf-8?B?bnB0SW1xZ0ZpQXcwM1JXOUpkWWNTUlkydUZKZ1lacTFocytJKzJJbUtEU2h2?=
 =?utf-8?B?bk5vcExUQ1c3cEhnbDZJU09IcHNic2QxeWpCbEVqMkFvOWJucFVRUVl5RU5z?=
 =?utf-8?B?RDJuY0hLd3FQa2Qza010bXR0OERXTGt6WmdOeUh3SUQya2RwNW1BbE11VXNN?=
 =?utf-8?B?dXRJYWhEV3R0eXorWnduOUQ2OXJNZlUwTWRkV2VxbzNUdU5HS2ViMVRRQ1ox?=
 =?utf-8?B?dnlMbGNlZzBBRG91eWxuMDV5elBrLzArYkdOWU03aU1jN1Q0dFNCN1kxMndw?=
 =?utf-8?B?VWhZSi9iN0JGZDI5VnpqeUZKbEYxeDJVSm5hdFc3b0dLQW9pTFV3b2tSK1Q2?=
 =?utf-8?B?dndPWlBmWGdxOUd2cncwalp4WGlhSFg3MWp3M1k3bjdGSVYwcGM4MHZCQjRB?=
 =?utf-8?B?YlZWdzg4MWZ6VVJOSEpMUWJ2azdvbWc5Z084TitSMkI1U2M1QWozc1l4cDQ1?=
 =?utf-8?B?M3VPd3RDQ0p3bkxTRHluRnM4VTIrN3FBSDJwSXFlYTlDTFA0RXUvR1hBalNJ?=
 =?utf-8?B?WWxsam9LNEFpQjI3akt1aHphTFNnVHN0YzRvTlQvZktLMldEaXVPTWhXWkFU?=
 =?utf-8?B?UmxNOXZEcG5IS3FJdzNFQkx2ZGorbWNvb0lSaEl5eXpISkFDQlBPcTFMMzdB?=
 =?utf-8?B?eklFU3lSdmtkK1RDclVKbGpnV2E3S0VPSUVEZmZEVXFwNFI0NUwxYmVaamRZ?=
 =?utf-8?B?bFduUHZDbHRncStLVWxERVVtTEs3Vk9IYmVxNzNuckxYcExxcXF1SUszQlJx?=
 =?utf-8?B?Tndud2RrQ2NHMDBIbGEyNjdKa0U0UzF3cmxybjc3Wk5ZRkgvMkNPUmsrLzJJ?=
 =?utf-8?B?ak0vcURONjRUb0Y3L2tWRkliMnljdWorNHhGWFg4d1ZxcmxuUGhqVTJNVVhh?=
 =?utf-8?B?KzJjOE9xS2EzanAxQVJGTDNmYWpxTCs0SjZuTE16dEQ5UUE2T1dBc1NSdDVW?=
 =?utf-8?B?Rkg2Qm1jU1kwS0lNVkF3cUVUNzh6amExS1VnakwxWldyZTU3Slk5QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381271f-ec8c-43f9-b578-08dea90a0a24
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 11:49:31.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfQN1bvsKpyYYAIVqimStE9o192Pmb2/m3DTfzQtl37ph04cjFugw99K8Pbtc+k/JOCTvfhU5mpJfGTfZezxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2912
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

On Fri May 1, 2026 at 11:49 AM BST, Eliot Courtney wrote:
> If pinned initialization of drm::Device::Data fails, it calls
> drm::Device::release via drm_dev_put. This materializes a reference to
> &drm::Device, but it's not fully constructed yet, because initializing
> `data` failed. It should not be dropped either. Instead, if pinned
> initialization fails, make sure drm::Device::release isn't called.
>=20
> Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Device =
in release()")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes in v2:
> - stack allocate `alloc_vtable`
> - use const { &vtable } trick to help prevent future issues
> - Link to v1: https://patch.msgid.link/20260428-fix-drm-1-v1-1-7550571780=
66@nvidia.com
> ---
>  rust/kernel/drm/device.rs | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

