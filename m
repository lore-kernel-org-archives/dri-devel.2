Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AA606A335
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KWiRY/fr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0308410FA07;
	Wed, 11 Nov 2026 09:22:16 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021093.outbound.protection.outlook.com [52.101.100.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C9C10F9FE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYSHMHmngGnNqz6H6R8X+G5KXVnMKB7mE8+ZSsHUIBbtr3q12uFJ9aZUjHOUwsYlqsgsfDXqte1n1B/3LKCD9dnY6nIN0fv2NgqwbvQzZnFYFwFM1yt7+b63EJlGsx9nkUl3xxzlN5ctSiIjFOiatz3XVk9maxGn+HBO7O9Baih3tTKpIGd7d+3YGTcYXWi2iB6xaQxoVTGtJ9N0uc+aWPuU3ZRhWwUI2k/J2Bhqt9y4C3jBCw9bZhoqA3itF84je2thnf27zBI0uwdNwyCURP0avq8KDfamZBem5KVjHbSKb9f7VufFkmDnegKHPrTPn5wKiOhbpsg8TTd00CbrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLSma1mgV7DL/VE8N++qnRbyhaPRo+MyCXcVE3u+kGU=;
 b=Zerdh2k982AF5P1HB4L+dGnWZalsE8xCgfVAERldu6C+mN8DH0MTevQ+SIbjC0LUIpKpwml3mqW0gwJhJjz3l4PlrZeB5QcHTAP9OVcXyX3FwIkJUCHwZcSucz0lTfI8vVTLHyLLnvuej8lVRL2sNyDtvk63hFuY9KyU+vrj1NujNHs6Ul0Yss2t2WoiKF9ndvWzqcIXxdApxn8R6YOtVhVlta6h5bc9ia9yKOZ50mKQbwGL62R8qBfsgncelYbY4AnRR6AoAOuqTF4w9ipJeZUzZqDiOHW4N1mdWVOptsn2zng4L3guuLDA6kUDsFEmjCjnzGabi6/Pujob5p+iYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLSma1mgV7DL/VE8N++qnRbyhaPRo+MyCXcVE3u+kGU=;
 b=KWiRY/frR1QJkMIy5PBlc5WQpjg8ZcRPwvGpbsXKXgj7ehn29wNgkcUZ0R7501z4AuQQEVnLiLVHKdAo4yVFSjH0pCHI+DRzLIqD6hzY0dcL7dX23Jv2T2s88iyfF2WgMdHlCfeTXC3Q/OlQw7u/37WbIN9bMcReigMXC3jteMs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6206.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:22:07 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:22:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 09:22:04 +0000
Message-Id: <DMS9SBWG3MXV.19BZZD6TNIJIQ@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: move file_operations from gem to device
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-4-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0028.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::19) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: c59d1ff4-b890-4299-0a5d-08df3fd540a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|921020|4143699003|10067099003|56012099006|261021121427099003|261021123027099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qzIW34xaZHb4M6HAI2xTnJskINF95rn0emstwIA2nvoB/0emDyf1tmAx/LgraQxKxZB27SQlRJ4GJsDav1vTvK4zOxfniajHfPzzWJ62btj4kjEgv/V/RBJdVTEj4QSnb6CyF8eJJs2jjF+LFY4VbjB4UJdjxDnDnbj3Es76u4Y53B50aGxBgPGdV5FjSfr+OGHiIWhFjvgZZZ9xRXr8zxSVH86xPoJqW+z14aKWyFfyHhr78YP7GuPKMN2K9MRr1H5KJLLUQYaTT14skLTDTm0Gcv4HoicSSlKux94I5uobS5GpGMrOXv+KsdG5161tjpEdpkqQlVUVvkhVlZcod+/lawtMRmBu5BP1dt6nm6aCClR7B5jOwpkQCseu6nrAukdhXaZM7hnH+MAMRwtP9NkPxj5LVAVG4opTyqS9VqdBJhbxvuo5cdBP2r3Xx9MrKqjNyS5sJz6nCuYl9KbBbihgfDTiISmmrnEuarGAlApkaOMqoIB8AFevqPqUah2E48tUNAeU73qFYiZDN43fjyw1K6c3wlvsTGeZbLvwAtOZS2f1y3c6yT/Rsl3H08gMLObPLwci4fhobMn+K1F0mgcNPjMVjRbG73tysyN5uiY5fus9ulMt7qytRBdep7TYRAOUQC/QeHTD5anQzdlPa6Z7HrZQFdRn7cYy7tNyuIqz3Qcjm9jbVtVJaWsqSAuwN8PaFTtcSwQmtncGBmvyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(4143699003)(10067099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lBczlTQ2lUd0dFNCtveHBZOWF4ZzVJYml1cTNuV3d4d2pEVXYvSzNDMDc5?=
 =?utf-8?B?ZXQ5OTNTTlRKZXlvK0hrcEdyNXVuUG04aExVM0MxQ1E0NmRtdEF5RFM1cUxj?=
 =?utf-8?B?bUhCYk5vWTZFYVNFWFJtRkhXb0NRc25wVUpTek1DYWtGSlJ0UEFmc1dwU0JT?=
 =?utf-8?B?VnNBakRQTDhrTDBVbTFTS0RwamRtV3FXclhnMHdoR3FaMkhsOGhRRTduMDZG?=
 =?utf-8?B?aGpTRm1CdHNyZHVDVTZjKzFFdm9mODVydEdtY3VUSzdZcXJQbDF0VnNhNXBH?=
 =?utf-8?B?VzNTeFdWekc2Z2xsU2thM0x0TDBMc1dHbEtnSGN1cEJtR3c1N1VHRDlYa2tG?=
 =?utf-8?B?VGtIZ2JlaER2TXRTZE9ZdzZ0cHhQb2cweUtTUHVvT1hyTzc2VjUzZmtGRndN?=
 =?utf-8?B?eGQ3Z0FFWkRYUVBoTktiRGRoRDJZU3ZpWnBsRkY5aWRUOGNSL1B4VXFPQlpw?=
 =?utf-8?B?YVlvUU5OR1M5M3Q2S2I4eGkwb3Y2QnlaSnJrbWQxakNERjIrVFBEanYwTVpp?=
 =?utf-8?B?TEc0NzU3SndXcC9JNGU1WGNtQkdSZ3Q2dFJqUDdKUks5S3lIVDZLMDF5V0lz?=
 =?utf-8?B?Q0NLMmNZbVpBaVlkY1FEOXZwelhlMmhwRkFidXB6dWZZYTNzTnBOOHFudWpm?=
 =?utf-8?B?U2M3TW1WYlhybFQ1WVYyZEE5bUV2YnAwRHprOUpyR3ZLWGZSd3hrenhkZ21q?=
 =?utf-8?B?QUd5aGNDdzlWMERrVG83bHRkVWlVZVlhYVNVY2Viak1KQTluMVFHRUpZZGdH?=
 =?utf-8?B?U3lTdTh2SW94ZUQzUksremZGUTNyWHZZM0hTUGV0TVo4VjRVU2l1RG4wbU9Y?=
 =?utf-8?B?YUtMbzBZZFZYRTZMSkVZcVVGeHFYS3VOdUZxampIYnkzN1Y2WVNZTHhxQ2Nw?=
 =?utf-8?B?NGU3eG9odzBWMzEycVRjbnRZUE54MitKQmlVSW1yNTA2NTJjOEdtZXYvRFJZ?=
 =?utf-8?B?Z3BQcGFJTUJGQXV6ZG1lS2ErWjVUaTJ5QlJaYnppTWs3eUtTZkMwaFk0dkxt?=
 =?utf-8?B?TkV0RlVQYzVvTEI5elVKczFpd0hPZm0zTTMxWGZyeE5UMHkwckJHMVhPS3hn?=
 =?utf-8?B?UjU5by9xOXdPVjdqaTR1dW1jYmpQSXFZY1UwS1RjRHdQRGZGNHdOQTRDMm1n?=
 =?utf-8?B?aFcxWHgyQTlyb3IxZTdoOWcvazR3UWE3REFmeVBwYTVsQ1BTQmZzajRVMnVY?=
 =?utf-8?B?aFVyL0c3Q2FJZUt4VjEzTWlrNVpCNWNObzBjZkt5WnpTbG5OMlVZRVVJcTYv?=
 =?utf-8?B?WGNFTExSLzNUN2ZBQTRNNVo0dXo3SVN1SmYvWFZoYnN0bGE4NWRVUmFpbzJB?=
 =?utf-8?B?QThaRnR2bzBiVGN3d2NOSk5yNWMzbkMweUZhZTdlKzdQdWpTTEtsYThZTmQx?=
 =?utf-8?B?SkhsN29BdEdFMEY4TXdqS3cvclBIeWZ1K25IV1lNNlVkcC8zclRBdlc3UUxq?=
 =?utf-8?B?WlVQRlZwY2RwRTFRWG1qMFpvOTBEQkNnWnZqZkxVSUp4Y1g1ZmE2OGpSWWdp?=
 =?utf-8?B?RjRmRkdhcVRSdW1VVkEwc3FTN1gxS2tqZHVvdXgzeUI2eDY4djVLYTJ1eUxQ?=
 =?utf-8?B?OEJUWVVmK1VDMEZMbjZVaklZWS93N0dtMXZOTkxtRmV4dUt2WUh0eXFpbGpU?=
 =?utf-8?B?dGlKZEpIZkRKaGFkZ2lYK2k4ZWlBaXBtUU5iSndKUUhSZTdzNXBQVGkxRERn?=
 =?utf-8?B?WmlmM0dDcGNCY1dEL01iMStrVmFmbE1GNDhYNlp3S3dVSDRhdnRvR3NtV2V2?=
 =?utf-8?B?eXJZOXBWSnFzYlZFK1JKRENvMEU2VVp2K3dYR0FpblhIZlgrWWlCSXFNMTVt?=
 =?utf-8?B?TUEraXVIMEhwaXBJMCt4RVVwdFcxRUQxQVdQcDNNSmEwNUVVbXZTUjB0ZVpm?=
 =?utf-8?B?MVhDTzVKczJUSnlMaDhhK09HZ2RiV2VEYWhSeXRpbUFsa1hBd0s4WXlOa0t0?=
 =?utf-8?B?RnhCTTl4UGxLVHFDQ2xWSDVtcTY3UE5XcG5wMTFKbUpTS0hLMkFIUG9rVUhT?=
 =?utf-8?B?WWIyQndMT2dSNTJKbFRCWE1vNCtOUzY0UzY4bmg4VjYyZXY1SHNueTNFNkdy?=
 =?utf-8?B?dnIybGVMK3NjQUxvVnFHZ2dnc255dGF6TGVNdHFRbXY5NXVuWHlsZVNjL3Ns?=
 =?utf-8?B?YytlU1BzNTJnLzRSa0ZaOG9IRWpZdVhFaEtCanowc2FEOWMvMlBlUE5WU2Yw?=
 =?utf-8?B?YytRL0NHNkdtVGJSdDM1ZlIzQ1FnRmcraitzaHhRREhsVTRUSXdFQlBMVERz?=
 =?utf-8?B?dzNPaitxSC8rZStGY2MyanN2UDk1Zlo0THVQaXlrU2F1OE0wL0hSZUpWcGl4?=
 =?utf-8?B?TXJSYnBuUkFhOHU5L2NTelNBcHo1NjR1VHlDYU5hOW1XY2VaTkVCdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c59d1ff4-b890-4299-0a5d-08df3fd540a4
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:22:05.6616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYO1/OfqnRvK9fA4faF9axcmYjPlL13hQKzuXxY9YNWfJs/YwkcYcjNNfKvV/tShJz9HmHNbmQVN5P5GDa3hnA==
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
> Move the file_operations definition from drm::gem::create_fops() into
> UnregisteredDevice in drm::device. This is the file_operations of the
> DRM minor device, set through the drm_driver struct. It is not specific
> to GEM.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/drm/device.rs  | 23 ++++++++++++++++++++---
>  rust/kernel/drm/gem/mod.rs | 20 --------------------
>  2 files changed, 20 insertions(+), 23 deletions(-)

