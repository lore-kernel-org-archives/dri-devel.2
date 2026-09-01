Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A950C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A7E10ECA2;
	Tue,  1 Sep 2026 11:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="TVSavzNg";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020111.outbound.protection.outlook.com [52.101.196.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E1010ECA2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4LVjXZyxeITpLXbJvsPh141fee/gJUdEKATT5ErybnTUi9zJTjNj+v+BCQHr4kO7mDv8F3DY+XIBzZsE+aL6KR654vdvlQXQ5XFd8tkEUEHHA9pHFDNZElz5vZI3/WkBPOe2edl3Z5tYzEUo1Bv1SdLPFe63/3NgHB7LGaFws5341NKhzm84blRPP0uWnu4SnO3EAnQKNOoy/bWy0zV7NSi+2EkGjSt/PnYATBzkXfE1TAtiextbnR+xx5QluS467VUo1WO7t4ZxyKeeHo/WLPIyfJi438MvxEIENSbcLpPTuqCXWx393SAtJRFPO3FRE0fQ0rJWpcM9bZrTm6Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ztF0zSa9dC2UqKQZa8N5PpBHZRq+EwRSNRpRXqbdTg=;
 b=Zsl3AIBmO4VcTOdv+U2AyuPnRl4qMnkuXpMAZ0VDYLaNrmtpeFtVVGdxVvLBf36Y8LcHEpyFYKAnjGAhP40ijqXzFtdA+9v8wC4JFBjcGYwnaDpe78iplADBo8yjChY3+Fe3YSoS5/wh98nYGHQUTUrOvV7KV+CyQYLmDJTrUK1G3Q/exeD8p59r3oDUOahMkMDud2T7vjIQN8SZvrtF3U7b2vmljM+8DJkfIGDb/JoVsVKsqiscljbAzUJ4iyeCwJdBjBZX3g2OqIZj+qi2uEbD1QClh3rmC9FaNGeCZ2Us9MKWRgriJ51vc25O3DLYc8/nMc5Xo52LszeHdiBecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ztF0zSa9dC2UqKQZa8N5PpBHZRq+EwRSNRpRXqbdTg=;
 b=TVSavzNgKU54yKtbrD5JA9uvfuZzbWoLQysxfmustv6x2ZRmfA6AhOKZla0oNoLixS+xHFdvANFtJEBAswbNW00hqvcq1XFQfoLMRC85uYeOr/ZxnkFDYLSJbdxeOfrDBmcsLbRLLhpvd88iVsmOHVoAyR8HpVFlwVuCPOBXzm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6296.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:52:01 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:52:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:52:00 +0100
Message-Id: <DL3YIG34IP1Y.1G32YQU0JYUTE@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] gpu: nova-core: use cv! for constant casts
X-Mailer: aerc 0.22.0
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-3-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-3-446bc69d2ade@nvidia.com>
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdbcf90-5648-4331-e6a1-08df081f6f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|3023799007|22082099003|18002099003|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: xlkYg6xQ0bBft8u/cntKZOL0Sq9wRsaozyq740dnXWFeKENJkz7oqowffemjg6vrGg38+eH/qdsnBvN/zywmuyu9fronNzYkfOkYk3T9GBBu4PValFpKT9axwh+MpHKLJftrgw6B0POfJ9535eYyP4OsIZkH/5qIwTLKm79sXRbXKZWJgEoTd7s9wtkdfybPgxaSvol3Z8un9uO4inH2IWgSk/5LNpqCoQzAXvL+HG1hIjL0dM5jMEODrxsE5+E3nNrDYXYLHqHIqox9mY5zdxXtCerKFZY8Jv5TtE5+8dRX2yvEOwSdFnLIZHbeo2rp0PHY29XmC08uUIQ7sSl0k3mdtwzvUvX/fBiCkjQTk2Cu0gzHUsDAkQDpjCQFLokwyfaiT5CuDfGcvANsmlTFQ+RuIkpy6sikfMDE2C+4x0mYaMCDDVmAx399rdEKSxHA9JuBppndmtIq8yJK1qfOGv00sLfRLjb/bxYDBLLdK/BtxHG4D3zOl/DQ4z3xIKBUW7FTkl6uazxSX34xHDpChiz7DQsveN3BfUUh7hmAW7CSDc4/Y2A3i4Jhp2jM3WYcaNsg7f0yRhy/pOf41owKhePk3yopGYCYWCzm/Nef5eA6qEWtjeDhs8IaTV0LaJYVc5GMzFKm7WWtCNSiDpceK+f9krgXWO3peXYvjXKD5YpuWh8iDBZ9sh+EcgmXVKbog+DsRa9wjnQgcWuhl1ggLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smc0WWYrdDhqMktqbFNYNWp6MEdEL01SQVE0TFl3LzR1MmdsV0pHUXBPY2gz?=
 =?utf-8?B?QW1tdTlDZStibUxML3NFYXNybjRXdFo4Rjk4VUllOU1WelJ4NGRkajBOWE1U?=
 =?utf-8?B?cEl5WXRUSENqOWhrV0hTdkxpcU1sNnp4WGdiZy9KdlpncmlZTG1IendkY1BT?=
 =?utf-8?B?T0l5eFozWXhKV2UyOUJQZVd1THFkdjl6S3BYS3lzME0rSzNoK2VpNkpJUXRK?=
 =?utf-8?B?TVV1b2YyRzdobUFycDRDWnpQa1pJeXFZY1BUNXJXbUlUQjdDR3BYYlZqZUhY?=
 =?utf-8?B?YjFHSEJGSjhVbCtEbXhEdEUxeTIybFpRcXBSbDBGeWRYWVgycFJSbEU3R2pr?=
 =?utf-8?B?TnExdVNPZzNuUlIrRDBUemliT0hJUnJaOHN0K2phVnc4TlJWYjU5amJ3dmFk?=
 =?utf-8?B?dElCWGk1bVBWaTVpdzl0SGRBRGJOU1BaaFNHdmZVUlJkUklQQlBTUmNxTFY5?=
 =?utf-8?B?NFdhWFYxUmhDQlFXZ21IYjVQK2IvT2NiUkJ3NzVzWFdmK1E1RlZtcGs4c3ZR?=
 =?utf-8?B?VmZGL2txcnMvUC9lUmlLaHVQWWYwbHczdFhYVkJWNWdkT2ZqaCtKaGd4ZlZr?=
 =?utf-8?B?WVJpekRYSTVsdkJNUVFuek81bzFydm1uRXRmdkJiK0x3ZG00NFptNm5DY0w2?=
 =?utf-8?B?LzNOZ2NtZXB6U05FcGJudE03cFhBYlBZb2RDNENFS0xiUDJyUWZJOGdKK1V3?=
 =?utf-8?B?cjE3WGZzd2lUWjNSaU9JTW1hU3dQNTJ1QlVERzg0Z2MzRkdxNlNQMllkME9V?=
 =?utf-8?B?eXRSZFNWUEE4Q285RWFTZXJZNWNKNkNTU3FPM1RqUHF4NDA2Mko3bUhCRzRt?=
 =?utf-8?B?SUtweTRLSi8wVGtqRUZCQ0w4MFA4eWJES0RwRXB1S3FrcVo2RDZlcXlLMEZW?=
 =?utf-8?B?dXF2MmZhTFRUS09BWnUvV3hFckpTNU1pdkZDZ2FSUkJiQURNMldHT3B0dXBi?=
 =?utf-8?B?VHB3YVFzbkc1SitXTnoyRTJhYnBReENBQlJKUG5IcHE3VUVFT3RNTVZ5VWpC?=
 =?utf-8?B?YzlWckFYeEJuNnpuUXhPWHNhSE90WHJOY2J1TmdvYkN4d01Yd3RVZlY5SUZ2?=
 =?utf-8?B?aEpGM2ZIWGFzOEhPSXNxWC9rdVZPTGplcVAvZHJNNWxXelpPYzgxMU81N3VL?=
 =?utf-8?B?QllCNGZlU01HYm44WVhRalhUeWJGcWxPN2FZdnhBY2sxcWk2eUVYSkhEU0Zn?=
 =?utf-8?B?ZnRMSUNnWXFVZVRsZGYydU9FS3k4QkJMaWtoazg3a3pQRVBDRlMvRk5WRVNt?=
 =?utf-8?B?OThLRUlTL2s1VXZ6TDg3VW1oQUh5ZEZUSXZKVk51SVpPL3hLMFR3SGpQVGE3?=
 =?utf-8?B?L3pDZFVJdEpUOWdNc0s1dExIVm1XVHRJYTJXRzF4L3FLMmw2REVxKzZqN1hC?=
 =?utf-8?B?QWZjVU9SQlZ2TWp6dW8yNGp2eEVmSFduV2tnNURPbFhFZVo2ZkxRRXhrTU9D?=
 =?utf-8?B?WTI2YWtpRWRrWENnY2U2U1JmeUo5SHFxbXFFbnk2b0ZrL0Q5aTlteUphVUlI?=
 =?utf-8?B?a1BKeG80Q1BDVFJIVGEzRXBGUG1KK3duWVJWSEd4c29qYWNDcmVFNlhCV0I4?=
 =?utf-8?B?RzhVNUhTTWhVSDFIMHcxd0lHOUV2aHFWeHpKNU1VOFR0N1EvNXZYWFR4eWoz?=
 =?utf-8?B?TVZBcERXSHJJc2c3b3pKTjJFb3NPeGRONDBFUSs4eDRQc0kzUVZTQm92YThn?=
 =?utf-8?B?YXJvT01yWmt0cWZEMTh0YWpPeFVMYmlRODlFNDhzYnNnaHpqMFNOTnhJYzla?=
 =?utf-8?B?VmhaTTNpREtXaTRjaGgrSlNWN242bTc3T2N0S21aS3JKeXNGdDRseFd3UDg2?=
 =?utf-8?B?WER2M0NkcDlmYU9jakJyOGkyT3Vzb0NwMDRTcUZKUm0rK1lVd3AyRExXVWYz?=
 =?utf-8?B?RFA2ejNQUmlUbCtDeGUzbkw1UUpTeGRLeEIvR3ZleWNpcDBhWXlsTjdhaEtC?=
 =?utf-8?B?Y1Q3T2RkNVVkZEF0UlhHN0RRa2lQSWZEUFRqYWJyVFFLRGNOYWZ2cEM1aVAr?=
 =?utf-8?B?bFNTbE1zRFBqd0lyaEREb1FFT2poa1F1R0FNOC9mV3pFRXJwS3JXQXNXSkEx?=
 =?utf-8?B?clBMLzRibmN0b1YrUXhmOTBRQ2puUFpRb0l6RUVBYXB2NDZCcUZ1TGNNakcy?=
 =?utf-8?B?TnROY1IrSE9BK0dGdzlDOHgrWEZCbUNOSituMWxXL25qS0tkZGV4U0RDeEl6?=
 =?utf-8?B?aVNkNU85MjZVekpEY3QzckIxdFYvL2l3WmovQm9RdnB5eHR4K2NKVVVzYWlZ?=
 =?utf-8?B?Y1JpazZ4YjVXQ0dDWkM0bFlVRDBsMG0yT01keXFORlBYT1l6RnJVTVcwQ05i?=
 =?utf-8?B?TW9JNTUyeVRvMkUvak5ZN0pGZVg2OEFYWFRGZ1A0N3FMZ0k4cFFKUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdbcf90-5648-4331-e6a1-08df081f6f11
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:52:01.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W8UHsD7Q6dQ8zqWiSN/DgYcLANQgTjA/HhsSQnU74PnCEl0hlSEb50KlKL6U+8L52uzuRIF2WAYNg2qkVnOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6296
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

On Tue Sep 1, 2026 at 6:06 AM BST, Eliot Courtney wrote:
> The new `cv!` macro allows safe casting of constant expressions in a
> const context. Update code in nova-core to use it.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

I like the ergnomics improvement :)

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/falcon.rs                    |  9 ++--
>  drivers/gpu/nova-core/fb/hal/gb100.rs              |  4 +-
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 +--
>  drivers/gpu/nova-core/fsp.rs                       |  3 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs                  |  6 +--
>  drivers/gpu/nova-core/gsp/fw.rs                    | 38 +++++++--------
>  drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
>  drivers/gpu/nova-core/num.rs                       | 55 +---------------=
------
>  8 files changed, 28 insertions(+), 96 deletions(-)

