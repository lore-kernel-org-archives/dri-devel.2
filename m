Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94342606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=TvovcP01
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D2F10F9FC;
	Wed, 11 Nov 2026 09:21:58 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021091.outbound.protection.outlook.com [52.101.100.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD1D10F9FD
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqY2DoiQxMBnQnwn62letU43AmqN0DsU4rgovgLEfSZ3UgXc3M8SN9kRRE017UhPk3Gbt8plyrh04hBHtGaIojybHhYujmysTQWqDsFbs+T7frvuIhu1TNYQzsopWDMv8qJxsPht00OlcnoQv0fTF4kPmv4GSuO/zAwrTOD9Qu/o133DUDLjsb22SYMfRAKa8dgaLBxlCH5Tx7/H2rjSCaYY0RrRGoJRyF74goF39rVddlBIlZVVuWKDP7+pUFUOmYihfECyUZ/NU4sn88ERjl7oj330MvJqp0CKhCvsCbLBUcP/rXx6Ia+1LV1oTCe3k0TV5RqYeihTets7swJA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsf4mRrCfVWMo0gXU8B9Cv6Pv1TulRz3iKQk3WfXt08=;
 b=DDeEp2SQ4OZhjGljd9TMjg57eqbt6rrN5Do+dLoyvIatPEe/o1e8u+RBY2cYvWdk6RtcJWMU8MkJYvA4Q/TqT4n5uwtvbl7x3uFcdFE/aUGwnF2hTGQbEOIuHj3t8ctDYW/Yyg3i/1jGRVMH89nu+/IJhV1uMqmHpNrdmPCWU1dkDSw7ZMR4U62kYHDRjjLaqIceYobIT30ch/KZJqAwT4FvDdSlz46nDWCLn4YtbcI9iSPpxfR9pQV6zYy9wLAzkccCdmvF0MCNcwbh/lmrsCYPdadoNvoo1tFvdNBR/IXO6FMToRPEPtC1d6KBxPvmATj9zMcS9vQppL6rSBOl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsf4mRrCfVWMo0gXU8B9Cv6Pv1TulRz3iKQk3WfXt08=;
 b=TvovcP01jWGoYugir4cW6VOLNg11IZPUA2DacfrZwbKjNsxwRF+PEm5WpBYbS+YbAQqc5az7vlcUQS5Vnp4Yb6gktzK8BdBA7x2sChT8LVsXwsH6sFP2k6m+wyP/Yh/UTP2YqEjVgTLplQvQdkKschM2ZbcwmFHsSInsTDk1FDE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6206.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:21:44 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:21:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 09:21:43 +0000
Message-Id: <DMS9S239GI3X.14IS8L60KGEOW@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] rust: drm: rename Ioctl device context to Userspace
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-2-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f3ea48-36d8-47a4-e1e7-08df3fd533c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|921020|4143699003|10067099003|56012099006|261021121427099003|261021123027099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ymKOh1i5t6ravPSZbId7zocUTCoLAJKf3EI1rzptoScKWxA/gBBEuLkRdMltsGbCtj1NYJ3NachpKh8mTpvFcygEuo+1kOPdookXKxAJbHy9dgfr+pP6MKB1jTCxuqynZT1smkuTNUOWhg/F47Zok8EKMQqOQxQuRDDvCf3ZaKS6ja0ZpV3FgKruQ7eqV9qQNovMeZoaeyqNMUOVREJRv6ZHWeHkujXlsAGdozgrpEwMnBtrm/55Vtw/Zq7C/fcfgG/hObVPb6AenNRBsmY1/4+x6JioNh/udfwH6TCzSuW+48PGKNKacWI8PeOXc0o/vw4p1Q84nYc3A7Ql5nTeEwMtM1Dz93FM9I1MohU9YaFIFmPqEGXQ7iHSM1Bm5jJQ0fFsmgg8HUBoVv9l4DU73ULY6zsQT4ors0SU465kHhW0i8sltPAvL84AcmbEVZp2YX3uQy1Dkn4dTFXhDsgskJ4vNEra1b2Wc7E/qQ0/oeGMKkelegFek8uA22/SVgA0gserpR5ect6/C3u1V2K4s4g129xoWhJe98O0bnh49iPKUfVKdD8H7HSBaURxUJCmVWiI2RzKbikyXrhpOlGH084UsweZpUjZHpK7z5rM8x92iYRqffPfAZiECGni+j/xJDxg8NoygMibrBrtS1f746TPjV2NIaWXrRKtY3Lqv34jGD1EWDGSN0F6GP46WIQYix/IFzhvcoSxpI6Pp3umww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(4143699003)(10067099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUUrV1JJOEswaXZoQzF2TmphODJzUFpMM2tORStkMkMyNHJKVHI2QjFDajBF?=
 =?utf-8?B?bnBrQndUWTdvdGlCM1lmUFQ2M1BTL3ZiMGdPd3N2L2FSYmprY3Y1NitYMmMz?=
 =?utf-8?B?L3NkRUZUbmJieE9lYjJrREM0anRzVXJuZUZMM2dqV3drYTYrVjY3S2JGTCsx?=
 =?utf-8?B?RzR1ZjE5d3JGSFlOS3BIZkhGWWFsWlIrNkpsU3pCcHBYVmN2OGZyUmV4ZWcv?=
 =?utf-8?B?VzIwT3hZb0kvNFVRZnBhNktjRmxyWGVuWUd6WVFoOGE1UCt1MnY1Qk9OcG40?=
 =?utf-8?B?WkwwN0pxOEtrTTl4VTg4NGdKRzBsQXZSc3FDQ0FyUjhURDJxSTZ3TFNTYTh1?=
 =?utf-8?B?bXFwRU1PQ1BPSFFGYVdIN1dPOENRZTFRZmNMMFlzbkpDTmUvT3pWdFhjNThZ?=
 =?utf-8?B?L1NhMkoxTzlGNU1jRzUzRUhIVjY3NzZ1Tlo3QnFrN1I4VXA3elpmT1JOWjJY?=
 =?utf-8?B?Nk1SYnpoWEFsL2kzdlRTYUpNVjI3RGVsWmtqazVJRHNvTVFlYld0RkFzS1Y3?=
 =?utf-8?B?ajJpYU9VckpZL3o1S2xaV0M1eENxYTRhRlRXUmZmVU1Yc3BMOXFjSStPa2RC?=
 =?utf-8?B?YWk2VGxWQ1F0WDdKa0ZvWC84ZThmYTIzbDBvZGl0VUlxcndYeVhjcEdlcVk5?=
 =?utf-8?B?SE4wL2VwdFNPQzdIOUZhSEZFTUVwV3hKanE4VWI3QTNFL0lZN0hnUS9RTEIw?=
 =?utf-8?B?TUQwOWV5M3c0K1hITVVTTmpLNXpTaGkrbGhKQnhJWG1teDBTby9hQXdyc01J?=
 =?utf-8?B?ZGE0QzdCVVBTT0dqZ3FHOGN4U0dScU5XTml3czhDQnN0TmJYNzQxMzg2N1pQ?=
 =?utf-8?B?ZHdPZmNXWHRTMFdMZTFiN0VLMTBzQ2hXUERBYU00UnFXYis1TnZhaU4vSExt?=
 =?utf-8?B?NXp6UEJpVjhZNXk4WlA0d2xPdlhlOGZCSHYzWVc2TFBtVWFXenc5K3ZZb0d1?=
 =?utf-8?B?cm9PbUJkb0RxMFE4ZGduYlFVZEVkNjZwb3N3WlZ2d2NHYnFPS1BXRWZwYUVU?=
 =?utf-8?B?Vmg3c3ZRTjE4ckJ6TlM5cllEUUlsc1hKUndUclZIcXd1aXYxR1NPMXZnL29J?=
 =?utf-8?B?cStMVmhtZGZORHZLbzhKUjd2bEs4RE5MNjlqak0zeDdXUFc3aG1RSURjdlg3?=
 =?utf-8?B?dTlyYThHRm94MDQ1bWhDLzRDUERXY1o2N0M2aEEyTWVBTFd1eXpyQnROd21s?=
 =?utf-8?B?cE5lMkg5TnB6SHEzRXdFRjgvcE4wR1FqbDFpeFFoMkhMT1gzQ2hjb082VFVq?=
 =?utf-8?B?eWs5dHJ4bE1pa2xmcHlNMGNjMTdIRGpvRm0ramVVK1RJcXJzWjNvbDFPNEZi?=
 =?utf-8?B?cXc2LzVUMUQrMzJtTDVHRHp1Q0x5aEsxWVVkMEM1bTI4U2dRbHNSdTdkaVYx?=
 =?utf-8?B?S1h0aE1EUkNaTWtpNElJUU1nQVN1TEswaXJjaTUwMXgvdmZvclIrN05BVlc3?=
 =?utf-8?B?N3owUmphb1FGRllKSzVRZkVIanlnY1NTaFRZK2xtWTVGV1loMUM3OE9WaFZq?=
 =?utf-8?B?YmdyZUlpdFlCMlVhSldpRExvZnd1UVBta2V1QjJLQmxaNzN6ZDZCMkF4bTM4?=
 =?utf-8?B?MUJwREhyc3VXVGNhQStmMlhFWFhoeXkwTlJBZ1piWjJBcGtRb0ZvbVpEQmln?=
 =?utf-8?B?UEVCN0pyTHhnaDN5OERxZ2dqaGxEYmlEMUQ0R09QdklZU2RVTFhYdFZNNEN4?=
 =?utf-8?B?WGFXejJxcWs4dEJra0dkNnNTMnpjMUxLYUFDLzcxcHJyeTB5TkRNR05UMHU5?=
 =?utf-8?B?R3ZTS1pPcVJUUkx4SzNYYjR3RUp1YkZKb2dBL2ovRnVKYThYdGczTEdPc2NY?=
 =?utf-8?B?Y1IzYmpRZlJWSnprV0hpUkd1d3pCUWx5WXNRRjZnTlBCbHJTT25aaHlrcjZ5?=
 =?utf-8?B?VC9rcGR6SXBxSFYvU1JzNjliWmtwSHdXaWV2N2x4RjgycWZjN1E3ZUNXWEFI?=
 =?utf-8?B?UXJmN3ZtTkw5Rnh2RC9sWjFmQU9WQUVxdkgwdmdZZnNXUi9NempsNXN1Y1ZD?=
 =?utf-8?B?YzZiS0hvV0ZacUZibGt1Y3RiSytteGVGUTJWWVRlcXNKTXRCd2p6eVNjYzNZ?=
 =?utf-8?B?dG1UMmVkdXlSU3A5RjdFUW9hcEhMYlZtdHpSWjZJaGw3QjdyWnpGV1NndUF2?=
 =?utf-8?B?YkxmTWpYTG9mUFhIY3M1Vzl1dnZ3MjRZMXdoRU44Uk5OYjZiYWF3YlRjeEZT?=
 =?utf-8?B?c0FxbDZmR2JuOG5JbzZaTUliUHkxTEY0V0VUb3VDSlZtOEN1NXNUdzg1ZElq?=
 =?utf-8?B?dUEvV1ZnbDlKMTJSRXdLRWdNSFVWRGhVeFpoNWhnUTdJcXV1cmtJbVQ1VWRD?=
 =?utf-8?B?VFJMbHdSOEpNVldvWDlndExQaHVwY3o1SVd2c3FrSmxRaGpHUHJkUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3ea48-36d8-47a4-e1e7-08df3fd533c5
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:21:44.0819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op3LNfzkdakJdf55zbhLZEz50Y+q5QAWUu9L9rV2OHG6+Eb/cICc8o1tFAxh2UApzEXddHE2pOVkaUzX1ESz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6206
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 2:03 AM GMT, Danilo Krummrich wrote:
> The Ioctl DeviceContext typestate represents a device that has been
> registered with userspace at some point. This context is not specific to
> ioctl dispatch; it applies equally to GEM handle callbacks, mmap,
> fdinfo, and any other operation triggered by userspace on a registered
> device.
>=20
> Rename it to Userspace to accurately reflect its semantics.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/drm/device.rs | 21 ++++++++++++---------
>  rust/kernel/drm/ioctl.rs  | 12 ++++++------
>  rust/kernel/drm/mod.rs    |  2 +-
>  3 files changed, 19 insertions(+), 16 deletions(-)

