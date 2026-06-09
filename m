Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D238FCD98C5
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5116110E417;
	Tue,  9 Jun 2026 15:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="cdm9TXoJ";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E573610E3F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5Z2cXtzntpD7um/8jyF15YY4Z7KkXEwTgMdCTv0ThSDmOJkoWkgGdGnKNVmdqmdlaT1qc+1fl+QXxP7SJV4CvR4DdHutFlpNOfsO3nxv47fEFLmiLt5gIAEXpsrn37zkyumMjKBMcj12f5FDgg9Mp8+8RR7ZOBMpRwPYdlLJeNmOVE7e6BNhSFaYasvLb80xZrTjQVX8n6PgQvUWYc/LZcbIOzybFf8VwlUtlOrSLILPZnT4EaUlnuglAgAf8RUwe9q8NbqOn944p8ldn+vCPSMB3FPE14PDPqix65uz3bF28Gt20offZRr7A1e0W6eIOozg9XxsytBS4+pjL6ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu9+6r+PRiC6zGslo+znItAv++oMbovvw68hH1rOxA4=;
 b=yLI5XcNKSZTENmr0g0MmSx2JoIV5PrtBfFBkhAYdOmu4Jcrg2PgUl0/ngM1pkgt0lCDGyQp+SdDh6fp4z1SagTaOkZL1BgZyvMh9zPNDCXE5cMjyIGhfglVdIHbtwa5cf+dyO0ST+U1KjYG0t7c35ZxafFBiT+Jc8VmgiUrG9CImc3d+avxi0Xc+bj46HimZsM81rdYgtZqANSC6GFb5HT3Clkuig6KAcbKap8UjTR07KzpSUEIhED239BhjGPJ+dVxyfln051JEApYRCfF0ZwiwAtxVTkTmGu0FkN+Wn9LcjslUvvXIF0gTHGu0pU2ExycinXUVyGUzh2GEoMnmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu9+6r+PRiC6zGslo+znItAv++oMbovvw68hH1rOxA4=;
 b=cdm9TXoJMhQ4a4GUH7YssPKo5MSRXWRSobYNgK7O9I7DamCFW/eNGtuNclQQw0fv0imTVe+npZaJbUeIxreh3o+g9Fs9tdbk6Q2MoiM8+T8KGjALKF/2gdBA13KZmQBFa+Ptu2kt0pcGvGGqo32NOif2xxXyOY+D2ns/FPAWmcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:38:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:38:58 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 0/4] rust: more memory barriers bindings
Date: Tue, 09 Jun 2026 16:38:36 +0100
Message-Id: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHwzKGoC/yWNQQ6CMBBFr0JmbUk7lCKsvIdhUXCEqilmCkRCu
 LsFli95//0VArGjAFWyAtPsght8BLwk0PbWdyTcIzKgRCONLAVPYRSN5bhiYTJZXMkWBpWBOPk
 yPd3vyN3rk8PUvKgd98Zu9C6MAy/H36x270xriSpHrbNUybw0mRYoOsvL7U3s6ZMO3EG9bdsfw
 T2dobEAAAA=
X-Change-ID: 20260609-rust-barrier-63078ea76216
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, Alan Stern <stern@rowland.harvard.edu>, 
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
 Luc Maranget <luc.maranget@inria.fr>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 lkmm@lists.linux.dev, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781019537; l=2784;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=0yK5Evkku+86XoUxtSl1LdLc+pNN7Ki3tsa/7mBr/VM=;
 b=/m6i0QmXg4SLQ0Aae2cbnZXCDwPyPXPLGIe1BLLIJ/krOYM6tDcuPEHE/V3XNLy4gonIesMtw
 f6XAJqrHstzAz8udRPIXDDTg4fbZ3TLAkI6elKtEURPIXhK8JsOux3+
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a662cc-3567-4c89-cd70-08dec63d38b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Yg7vNQZA6aunYyVkWPHBmx81ytUU5aFRYWVVcfM50j2Udj1AP7Q0xG3iyxGBxlXzl/LcDr91KUrOUdar1+jAjtDZJHkzV6iBm0tlAX3srdxzqK5uZj7LMwFJL06F/BVYwCcHshomX4CoXDcyXS/rvH3S8F/kr1N1L9VuVl2sDzoUaPgrEJH3IdfHjXN0blE42w2pmlmbaz4HkPLfNfLVAwcokVjcTqhs08C5qsQuHjVByo6xPCMa6wr7I95wyvao5/oJJ/Co/YkjmjdfljnPn9ftwtjgb0BephaVM5pzvUYujDGK2bK0eqHMs1R6ZI9CIjQ3ATzt9HbYk63AWajVErPmHvvlyYwXp2iPBURHVcvJI++m3cPUOkbuuPn2lVvjTn1sIp05m305/uH/pJ3Ig01stfZGEof/xw6YvgmeFf3sQHoe+elhPWVFNtbYWvrPIo5G4f+D3AxfMEYuk7I73UC4jZguuza0hKqwQdzR1z+VWefGtns/0pMvy81Lx2UBaQaQkOD+v5v40qZ2YFqrxfubeinOzzOvSfHoX9TkMNr37xyPEoRve4DeUAt007xg2qJZ7vSt+U+fSeIrYIAsg/l6bdcphdEVLM8whZqnPxIt8l4XmHY3CyxmILNtY4jM0GVDCL8MdfdMzysGhoP91XoLLwY0mbzBI8MPwO84yZ+tTrNQZpIFIMUCqT99+Bb/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlY1N3FibnRKNUVLWktQNS93bm5VR09nQzNPMW5Oelg1eVVLSGNVcXhIbmNH?=
 =?utf-8?B?YjRndm5tZGdBL1lyRUhkb1F0T0kwd2RuWEpvNXNES2ZDZ3ZFTmREZEV6SlhL?=
 =?utf-8?B?ZGVFQmwwQWEyb3hmNG1zRmlJWjNyelBMakNrWTR2ZjlETHZRTlZ3b2Y2NUxO?=
 =?utf-8?B?K0M1UGlSdFUxTXVieHFBZEFzMkpSSlJMbDluRU83VFZmK1lPVHhrakxXNEZo?=
 =?utf-8?B?UGVXbnR6Q29WNjhtWXBaS0c0TjE1MTYraHpJNmM1TWRPaG9vSWU4VHdWTVQw?=
 =?utf-8?B?MlZjc2RqRUVyazJBNmFwbjRzdTF3NkV6cHE5bHF1RzNDZkJLWGxkYUlYZEts?=
 =?utf-8?B?SlRFWUppNU9JaFR3Ym9RKy9sRFFMV3ZGUjljTU5yaytjaGVhRDRtSDFweUdr?=
 =?utf-8?B?c0g5MUlVLzhhSzFXUXA5WGJQL1FIVUx6bXFFbHFQWFkxdzZRUG53SEdNYTRB?=
 =?utf-8?B?bGM3L0x0ZjRFaDVlT2tqMlJrN1dKRzFqNFZ6M2RKWXh2eHpjbkRSVXRhN21h?=
 =?utf-8?B?dUk3cXkwWmI5SGVYdmtMcmRINE10REtTOXBKdVVydjR6c0drVjBZRjB6blpl?=
 =?utf-8?B?aExaVGQ3cFE1c2QyNGZVb012S0dQbEhxRUNiMmZMMi83dzJtNmE4Zlh3MDNj?=
 =?utf-8?B?M1ZNdEVpRld4anNIUis2VS83Z0wxWVI4SWpIVVJaTVk2TzBKaE5US0xXbzBN?=
 =?utf-8?B?SHI4NCtKQXdrWTV2UmdpV3I3MzBjckRHeUFZTyt0SUV3VDlxM2pFWTlTTkNy?=
 =?utf-8?B?QStWM0o3c2hJQkhFTVhkMjk2Z1R0czcrMlFZWTkrbXVVNFdmMXlQdG1qSW45?=
 =?utf-8?B?ZXRQaUpGWjBzcVBDTnBDZkhYRWNNWGE0d1VwQjNvRE1uYS9OZjdxbmJJamNj?=
 =?utf-8?B?NFZ4dG0vVHNLQ2tEUW1xakFJR2JUN1MxRUR5bk41MFhQWWc0L0MraElJTU9Z?=
 =?utf-8?B?U2RYSDRwWExGVjJtTS9RYUJ5ZzRoSXdsQ040WkNiTGpmU3ZvaFM5Y2w1V01G?=
 =?utf-8?B?MW9XNzJJQkdNS2Vyb2hZY0FMZUJtN0FmUGhOSUQ4WnVaaFhDN0hEQm1mVDN2?=
 =?utf-8?B?cjYvZHRPL0VlcEJOeWhTbWVDNEM1QWZGUEVtTWx1QzZGcnpRMDQ3cGhpbGNs?=
 =?utf-8?B?VWxXYXExU0huaktBVVp2N1ZOczlRT3lEakxmbUh5MkpzRi9vcVRyOHVUVmJJ?=
 =?utf-8?B?blFRSTVjR0p3UGh4Y1h5RFhTaTNhRmlwNVBFOW4vc05xNjdyZUkxTTk4Q1Zy?=
 =?utf-8?B?NmJxRjY3dVc5a2RLbGUzMzVyc2N2Y0dwRXNocWdGeUp0bDIrVTY0ZTdHckEv?=
 =?utf-8?B?VVRyMHJzZDBnd3d5dEI3Y3RoYUdyY2N0WUtLVFZzcC85UDlOclM1S2kxTFRo?=
 =?utf-8?B?ZkQzUnhXNlVLSldyU3U3YjdLclpSWlk2TmYrN213WUJtSjF1V0FSTWdwRHNy?=
 =?utf-8?B?MlBmRGE2U203Z2J2dEJMVEpocjZaYUZsM2l2L3hCSkZEZW5raWpEN0ZlWno1?=
 =?utf-8?B?a2NaZkxOVXpZVnp5NlYzNFAwRGk4ZGRrK1ZKV2FhazFnSHUxZTBRNGhXSzll?=
 =?utf-8?B?bC9LZ21DUjhWNkVhaFJZQ3A4NTRUWUZjdUxvSHJKdXFGbHdYQy9ZenkrM0gw?=
 =?utf-8?B?WEo1SkJMU0dELytFdUxTUmJoRHN4WXFRcVZCdmcxY2VsT0NyNjNmbDgyR3hn?=
 =?utf-8?B?UVVKM1M2cmY1UjVXdU9jOFpEOUJxcWRBTXpoaEw0NDB0dlNEVmxQMWhuek1Z?=
 =?utf-8?B?czE1UnpCSWdkaG9kZFhUTUorM0hRYXF1dmhoSXRKajNoTFdJbHZrZ3p0cXkv?=
 =?utf-8?B?S2xVZWZrSk5IK2t0RnJsREo3VjZUWlh0VmZqTzd5S2Evelg3TFJEUzBxc01R?=
 =?utf-8?B?N2MxZkoxVjRxVlVHRHNQMG83ZHRBRHV6UzYxcjJWYjFBWjJ4dXlWckN5NG8z?=
 =?utf-8?B?RGoxb3ltR0pOTW9HWGFVeXhNWkpFcWU0V3RyVXFhajRmSXQvaEZaQlh5blZX?=
 =?utf-8?B?RnBxd2ExaEZwd2xWZHEwUWtPSGJpaExSTzRBSmVLc0hSV3EzcHBienZoNVNm?=
 =?utf-8?B?Z1pkdkRZc01tZXg4UDNjYnhodHlzczg5S0N2b09id1BFVFU4Um5ka3NONFc4?=
 =?utf-8?B?c3lkajFMdlYzaUlyZks1L1hIS3Rkd1UwSFMvY0dKTmpQZG12Z1FlUEFNUkZj?=
 =?utf-8?B?UlByU2RpT1I1VDhiaUczck1oRkdrN3BWc2N5R0I4MCtMTnpKZHlyVTVUNDUw?=
 =?utf-8?B?SWI5S3lXc2paeDh0SE9adllSbDdrT2VxdWIyN2xoTkdwMyt4R3NqL1lrT1Fl?=
 =?utf-8?B?eG5waDkzWElUUXF0QXJIN0ZvL3ZuMUR0bUErWTRCcFovdVVqcjgwUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a662cc-3567-4c89-cd70-08dec63d38b3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:38:58.0861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5uAVbGcWGEhxHI4WEQVOiJJNgEJJY36+K3fV7FAV1cCdo/um416ILWY4bEZALWSen37oI3EXK6SB1j02QB4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6167
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

This expands the existing smp barriers to also mandatory barriers and DMA
barriers.

The API looks like: `mb(Ordering)`/`smp_mb(Ordering)`/`dma_mb(Ordering)`,
where `Ordering` is one of `Full`, `Read`, `Write`.

I retain the use of generics to avoid duplicating `CONFIG_SMP` check (but
also retaining the ability to easily add `Acquire` and `Release` ordering
in the future).

A user of these introduced API is included in patch 3, which is a
concurrency bug that exists in Nova code today due to missing barriers.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v2:
- Dropped `Acquire` and `Release` aliases of `Full` (Joel)
- Use macros to implement most `MemoryBarrier`
- Split Nova change to GSP->CPU commit and CPU->GSP commit (Joel)
- Link to v1: https://patch.msgid.link/20260402152443.1059634-2-gary@kernel.org

To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Will Deacon <will@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: lkmm@lists.linux.dev

---
Gary Guo (4):
      rust: sync: add helpers for mb, dma_mb and friends
      rust: sync: generic memory barriers
      gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      gpu: nova-core: fix barrier usage in GSP->CPU messaging path

 drivers/gpu/nova-core/gsp/cmdq.rs   |  18 ++++++
 drivers/gpu/nova-core/gsp/fw.rs     |  12 ----
 rust/helpers/barrier.c              |  30 +++++++++
 rust/kernel/sync/atomic/ordering.rs |   2 +-
 rust/kernel/sync/barrier.rs         | 123 ++++++++++++++++++++++++++++--------
 5 files changed, 144 insertions(+), 41 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260609-rust-barrier-63078ea76216

Best regards,
--  
Gary Guo <gary@garyguo.net>

