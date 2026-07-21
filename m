Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39EC44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B9B10EA52;
	Tue, 21 Jul 2026 14:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Av7Buuf3";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020097.outbound.protection.outlook.com [52.101.195.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438CC10EA52
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 14:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp0mjKmV74+uQ/yl4m/NbNptP5/wOxxHtbF7MLlz6h08sTNoLT5fRqbDqnUwCCW6FFF0nlwi1D/+jjTYqEbVxESThSie0DqlUS39s12dfRnMH+EDMA8f20s1w9yL6ZVQEcYswvW+aIoSufTOvT9LtDGV0H5mpbSWBO+dxTLZ6QfRxEfMzcq93HgsgUEeKrtC7HA06NRwUh3lFOHQOJm6Ph5frSPPnkpJLceItUvUmpsMvoE4WkvGKlUohC86kps1kOL6IwZY1TfTajZBYatBJLC6ihykDpWScBbJ3d3/KE3fFPEdTwNqZz3nYozcta2JWHPE8ALr2uiLhdlYeLelfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELscFbLiplbBiG1bfTtCj9Icqrn63aGGc+JGVGbFvZQ=;
 b=YwNR6e/4mNBCvnJGy2G3VUqAaIQQUE4es0NYjmyXVpTtPOmLmFtlVdEqeKLz7RSXalK+pDe3AUf5rIx+Oxpx//mjVjsDgdV8MfJjLPObfhhQFkCMySHtfBorDqU0D7m+inlWkUZsu5pGaj2KJHB/GPQKDuCt0KIw6e3NeYVwwsd+j+sHlfbv51+p1A0zNauVIa9qm1/zz9K4Y4p3fYZQNv/5GpDB0qx04oM95UN7EYSWoXwbyn8VIImlniirhLV7jrUS7rRmk1FbKpztZggsTijS7Cw0tN2JSDt6MEG4p6hF1cJRg86ZfFXJAtWfsCWK9IeKSvNsv5QCmk2+qsUrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELscFbLiplbBiG1bfTtCj9Icqrn63aGGc+JGVGbFvZQ=;
 b=Av7Buuf3WmzkMqx5sbpECGpGnBmp8TGnrwKEq7zdF9jAv2u1xD6CudAqTgShaqyBUACJjJXlgULYgnoWo7MP3TguIwhIiyikQlo874uGli8m7OYz3/W2r+GGbduqBclyzhdVOYUogGmJ9fIfouExUggFmNdFSs4T7a66plAKJPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2214.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:34:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 14:34:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 15:34:50 +0100
Message-Id: <DK4BO8HWCEPO.3VN9LIY5UQXKJ@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] rust: io: register: allow paths for relative
 register bases
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2214:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cae0bef-4bb7-4c8c-3223-08dee73538e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|56012099006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YaAHMBGI3Oc/F+rWDIvgnMlwsX2PPN4ZnGSabiNYPIdbxAHLLRjSu0L5LiUbyBfsxNx1CzGTxAqDKCAQw0Qdh9eLfsYs3eesIKm/rUS9UhNKV6IXVDtZtii0hy0kYQCpl+bLBOh8CfL6F3wnOrIwRvHLvfW5RXCiFRkVB5UY02PsM5Sp+LpBaL2OJQW+ojDGtJr3abfdAUDYh7AqOQF+kxszY0FJ6HK+koc9++z9WoCXlWJeSDngc03IzV0xC/Sc6h/IMkagvkx6CB7ZdVq6ewZEWluCAqb8YvnSrryZsga5fdXGcKnL45ZDYysjuKV00aLYdvuJP4Tdf9b1cxY02O/nJZ3RC0GXflxVXndSfcOkUvbnWy2KxnKAKUl0Bjxq50FfWQhzxNk1CfzCoA8k3iqdxKX6lGhFS8rOtHBSDtYVD4zTrFzYi6Qsbm92xeYCbx9sr+9jFC/9N9jQMvAs9coiL933E447ie1FGezfGIe2WeMyml7L+5Plq/jSfgykQMZKpBg6r9h5zt4UtYnsWK6vYmKuBElfTC4w3UW0Q9NMFrd0gI7b3g4tHS/+YuH5ziKLQhIqH9l9rASPPpEZzn1+dKDkQVXFEpU2uGb5bIZBoA5zU7arAFTmkaCBv771Xc/E5XBAJKl1jfuDqAgb1NNcNjM2XNnRDTwIyyIWBw2OLYBcVUG03L1jHseC1juLBrQqtdT+HYZpmebH++3psg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pJUjNJaDhSVDlwVWxrcEhqc3VHTHh6Yld0OTdYVndEM2JVdENjREo1cCs5?=
 =?utf-8?B?WUJGaHhSRGpJcmxjMnBCZGdhc3ZPemd0Q0g4YWZYYXJKMXl1Qnlya0gxQWpX?=
 =?utf-8?B?SFZydWVBa0NxNndlalA5QUhJdGc5VVFjcDJGb09VU1NHRHBRRU9Mc3IrNkRz?=
 =?utf-8?B?UUdGSzZEWFpJajlnZ0VSYzlYYUU3VzY1ZVJ0RnNqcWJsZDJMNkxhZVdRU0R0?=
 =?utf-8?B?dTNmZHF6U2gxS2dBN0hjdXp1VlBIU242OFZKVU0yUzBLMmVCb3BPMVdhQkM1?=
 =?utf-8?B?RUVBaDlFdXpsTzB3Q2NYaVA1bmpTZmFOZmxlenpFWjRQV3I3dWFzeXlKZFpS?=
 =?utf-8?B?WHh0UE5NdlJ5K3FTL3JydTdzbEhTa2tZbHpweW9EUnlWTjYwZ3FMZGtCc1Br?=
 =?utf-8?B?cmM4ZThQNG1mWnR1dThUOWF3cVY5bXVMM3JBWi9iajFwUFlSS1BHOGFucHRE?=
 =?utf-8?B?eGIwRlV1NVYyK21TTUhBOWpEVXg3ZFBtYzkwbWY2VTlOS1RXVlZMZ08rTlg4?=
 =?utf-8?B?WHJzbG1qVjJ2L2RzaFF6dDVIR3N1djMycm8rUmxHSGNaUVFyc0dzSUVnVHFq?=
 =?utf-8?B?YVZDL1FVZnlURi9qNWsrU0JNQmhQbG0zbjhLaHpOemE5eU90enNsYTZOK2lW?=
 =?utf-8?B?SDZxT3l3d2JIeXZTbDd3ck9LSThuTVRHTUZ1MTVDaDlYSnNFeUplUW1pa290?=
 =?utf-8?B?K1FMZVJpSnZDNVc3aDdSL0wrNkVtTWY2NDRFR0lEQ1hRc3hWUW1jSXRIWGtD?=
 =?utf-8?B?VGw0QjNwNEd5WmdpYXpLODJtOFJxbCtqRHFpUGp1N3kvT05Vd0hwUWlLcFBk?=
 =?utf-8?B?R3RneFFBRVZzb2NYR3lBNU04cHpWZzVKNVdCSHBMSTFYMnQ3WVJmN2pSMm5j?=
 =?utf-8?B?MDFWWWZuajVWR0F3VXlpR2R5MGdGV2ZYUmd4VkdBVXhvZGMvNVNCaUljeDVL?=
 =?utf-8?B?SlZtMUlaOU96c3FScm9BMi90M0ZvVDVGRndjcVNrS05ka0pWSGZvVDNBZThR?=
 =?utf-8?B?cmhDb0RvbkRTdzYxNHlqT3VJa2RPcnFMQVprdGhpTFJDbEpVcnBrMmVkRTZX?=
 =?utf-8?B?NjkxNTdjNlI0SXJoNmhXeW0xWWtZYnNVaEFhb1EyaU5FSE1KL3EzY0F2QmRo?=
 =?utf-8?B?WmhLTXZOTEExR3lzWmlyRklzZDhXalpZVFkzZFZPSXR0UHNpWUZlSVU4VmtJ?=
 =?utf-8?B?b0NHV0toYW5jOVJQdzJlQndjUzNIWWFQZWMrUnRFZTJ3QzJIbnh4UFhWTHZF?=
 =?utf-8?B?Z3B2akxoL2M1N0pRaWpVbmtQOEhvSXF3by9EbGxoN2NVSVFZNzJKMk5haE9V?=
 =?utf-8?B?L3JqSmFjdkpTT1VNU0Q4SmR0R0o4WmRpSHd1RkVYMlZnUG1Pc2NMUDl6eEpw?=
 =?utf-8?B?QnVYRVRXREU1a0NXRENlNzlDZm81WjdWajliUkhDVjVXQldDMGs1MHVoM3Uy?=
 =?utf-8?B?ZUpzZTdWb2h5cmRqR21ka0szNlpXZHRrTmNqL1dvMm5pK2FQMHhaUFVldUl0?=
 =?utf-8?B?enFueHJBb0R0M3JPL3J6WnRlbXRRclZIVEw5bldsOWZvVGVQalZIK1p6Y0p4?=
 =?utf-8?B?aFJqcW5LekxBbUhHU2h3dFc2YkErbDJqT09JMzd0cGtGUE45REJEWDZMSnh2?=
 =?utf-8?B?VVZQREp2WU1nUGxHUCs3VlVxdTl1ZElDeVJDalEzK1dxaytUZWFmOHY2S3U3?=
 =?utf-8?B?UVQ3bTg0a3VJQVppZGp1b0dLS2NOTTRhTlVBVjJyVldrRHp4Yk9lUmozeWdz?=
 =?utf-8?B?Mm1FRHgxUTkyclpMeUc0U21QR3pGdXJSUEVZeUovdVBYWThKVXVGUWh2OFE2?=
 =?utf-8?B?R2d1c2tRZUZjamxYNi9tZE1MZlRlTDIzVENjYXJza2VYeFkwT1Z2UVRLL3NP?=
 =?utf-8?B?elhTYlZCYllKdVFTQzRVdzB2bzVoSml4bW9HdXU2VEdySkJBU1IxSGlRS0Nk?=
 =?utf-8?B?NU5vWFdpTXRVQ05qcGppWnNUWmQ0ZXlqbFNIQXorUUpTY1lkN0RyRTlxWXVa?=
 =?utf-8?B?SjkzSitNNjFNVkdVckRCektJaTQvRDFtcVh5eVRkU2NGbGZ1eWVYVmNHTnRZ?=
 =?utf-8?B?OTc4NGE0c0l2YkJvQXZ6Nk9tS05tLzNXMnF1TWJUYzkySnl5b1RiRldQclV4?=
 =?utf-8?B?NTFpVkZoalFUU1o1MSt6VUMyTlJhVzdnR2h0VW5rY0dIb25wMkk3c2IrQnlY?=
 =?utf-8?B?VEQ0alNoK1Biek1jWjQyMFBWWmZGaEdQUk9od3FLREVQY216aVZ1VzUrem1p?=
 =?utf-8?B?ZlZqUjFzM2lqK1kvZHk0TnQ2Wit3Mk9TMllXb0hkNFNxSHNDM21IWk5XVXZt?=
 =?utf-8?B?TStnVENSNERZZnFsM3NhU1JwdytpYXp4OG4xZURxM1dPNGQyVEZzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae0bef-4bb7-4c8c-3223-08dee73538e2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:34:50.8465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2s/oVuStDVhn+BQ7p+zWXdGXvp+PMxHS3EfAgu4EjjW/4aVczzSIyfOoRCmxoqIbFWeF7C4rMV5E+9pwH17uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2214
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

On Tue Jul 21, 2026 at 12:00 PM BST, Alexandre Courbot wrote:
> The register! macro currently accepts an identifier as the base of a
> relative register. This requires base types declared in other modules to
> be imported into the module containing the register declaration, rather
> than allowing a qualified path to be used directly, which is arbitrarily
> limiting.
>
> This series allows path to be used as relative register bases. Since a
> `path` fragment cannot be followed by `+` in declarative macros, the
> `Base + Offset` and `Base + Alias` forms are replaced with `Base:
> Offset` and `Base: Alias`, inducing a syntax change.
>
> The first two patches clean up the macro's internal dispatch and
> arguments in preparation for the change. Patches 3-6 gradually add
> support for the new syntax and update docs and examples, while
> preserving the old syntax. Patch 7 updates Nova to use the new syntax,
> and patch 8 removes support for the now unused old syntax.
>
> The series is structured this way so the Nova update and deprecated
> syntax removal can be merged separately, as otherwise the whole series
> would need to go through drm-rust.

I would like to avoid adding new features to relative registers as I aspire=
 to
get rid of them entirely with typed registers.

I'll work on a prototype.

Best,
Gary

>
> Outside of the syntax update, no functional change is intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Alexandre Courbot (8):
>       rust: io: register: dispatch fixed array shortcut internally
>       rust: io: register: remove unused rule arguments
>       rust: io: register: use path fragment for alias destination
>       rust: io: register: use path fragment in relative internal rules
>       rust: io: register: allow paths for relative register bases
>       rust: io: register: use new relative base syntax in doc and example=
s
>       gpu: nova-core: convert relative registers to new syntax
>       rust: io: register: remove deprecated relative register rule
>
>  drivers/gpu/nova-core/regs.rs | 74 +++++++++++++++++++++----------------=
-----
>  rust/kernel/io/register.rs    | 75 +++++++++++++++++++++----------------=
------
>  2 files changed, 74 insertions(+), 75 deletions(-)
> ---
> base-commit: 22e77d81d0a9ab3aee1c5538b3f2f8a66930bfa7
> change-id: 20260418-registers_fix-7a67ebef9ba0
>
> Best regards,
> -- =20
> Alexandre Courbot <acourbot@nvidia.com>


