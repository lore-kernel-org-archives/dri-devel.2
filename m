Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B726C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE29610E6C1;
	Thu,  9 Jul 2026 12:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nv0Pbp/J";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D6B10E6C1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEhr5RUgl8RKoFb8/Urg47a+sjI9D7t9ZuV12v3CJL3IDQOgLWaDZadBfJ28zSAuXDs/c6CQ10dFFi9xEzA+hXas4G67NRRsEtAxyeBSZBE2P6opOy0dgmddJC+Jtqkf0Ghfa0jGQgK/PyaLXTgi/JYQDWDn5c/zj31IzfH0ZkvEK/2eMPUpKEJizQFj0/uy5PocChcLKZcYcF95wxWkhwLiK2O4J1eM8WQrl4iqdKjmT/BdWDiegxa1tvOLVxemZlWIp0XfZFB3nlvCVx2vVMX9+FIKaegq3jg6Ee7LvfZhjPHMMCQMNaaBohjHsJ+9GVdLjCkJm2Ev1NTtzoBtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z78VP0YXQQd2wRpRbRheBn/jqKzzAkcOwvKnl8Rd7Rs=;
 b=D5xjGou3tYYHV5k3TpErTtZszNB7d1NFj3giuTGPR8nZ9j++drC4173Fq/dedLWAZiMBsVJA8d78ZhDHpAB9M4KotdKgeu7nEB1brVLA4vM/j87szhasyQW2Ts/E8qsUylCLMFSYN7aB4hBh2zgWp9wL3stXa9OIBPBqVRiOjmYwLzOdhoFedCiDRBzaxFK/1QQw/3qdCuvKGKmfKyKeq4slwK0S8Y62r+7wyMGKuDKbmroIlgq2Fb9t8fajAnsFoh65tcC2fNmum1HG75PqElCe+yPcjFRGDCxyO1ntDdV/PdK8PGRFSLVwKNV8vHQ6rL9rmdV3tI16eMCYnHWVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z78VP0YXQQd2wRpRbRheBn/jqKzzAkcOwvKnl8Rd7Rs=;
 b=nv0Pbp/Jxw0PfYlfpSeQs+7cX06ih/tGYiEmfVpZcJTXO7MZhKy9iUG+UWjfwuKH9JLF6FGnpesQ/f7RSsxynw+dfHB+RZMQ3BnTCX3O1F2RYlc8yaAPcs2ADtPQ23kutJ5KthyOCD500xBw6Wj4IkfojxnUoCWv5wjqUizxDriJ2Ek+ffBK5qGwt6JGGPvG6pCRY7KlogdbOIk9rrAHZtRRV/uAMhuRcKn3TDcaSxbzvgF0vnLP3SUaIdFAtu+OegfMKhV1HgiaRvpuMD5yXQsdntLUNOBpqz8SaK0WSB+LiFHq5nA3I9V3k/x28RgDymyOBfeVEUH/orQWY0tNeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 12:34:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:34:55 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 21:34:52 +0900
Message-Id: <DJU1LUNHBM4C.UMFY6KQ9C7UD@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] gpu: nova: Add DRM registration data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260709085204.565159-1-apopple@nvidia.com>
 <20260709085204.565159-3-apopple@nvidia.com>
In-Reply-To: <20260709085204.565159-3-apopple@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: d62f9865-b9f8-4bbd-049e-08deddb67b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3Rhi/8GDrYF6VRAbektztGJVktUxfFYTf2FjwQfw/tEJjtwwpM7uMaJj1dNzbv1xCmqg9x7ZXOnbIh2xMM64iqH0ylAuFF8iF4stPUz2+XRfmn/XB0xbwiwaoo1bV8+wmcufjPnItaS1PcHhPkOb7PZMe7Z0Y5PG+ujjgYN3+XV4isIoG8EkzpZ8HL9OYEMeOTumtWN8dWFCMu8B+rB21A9OKJtZjjy0LKP4ujn+CHAcewbifqKNtHbpv3AUJz5gco7CEYGIjF3IQ+ezHhCY70Fgo/g7Zh/qw0Y+EhcZFdBic3Z0YA7izJ/8kn+HHU7d/NOgw+s11T8gjzGxmejAUo3OOo4n2+sAwsOS0sb1QilsNOjRUzBrzKnwlziqljhV9EpE7ZxY+R0g4QYFZUEW/dW2Juw81Os+kKA2+Q7pdvB9Bx73ka4RlKAKYw8y3DqwAj+xnnq1rKNFgUI1Bs9N06Wwcm5zMrYiZvOnaallZGNEgHuCqdZEp7ZGXHjQpnnQYzxOcr38Qw/iMwiykrMK+XyBzyolXi9erY+8JTvXDxZJxnnL+unKVBvhVmNTwdK0sGNLseGQCsD766gOa59JcM5M2j9dtX9FCxvc1G1ubTlzfSlGwewitOIW91h9mNCWj9LTWyb0yOgsqn3klGrJpEv8s2XgTm23sSO4tjpLfy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFiSldsUUFCeEU2c2ZMeDQ0RjBmdU13VEZOU3h3eWtnanN3UkJQaHZkL0Ny?=
 =?utf-8?B?WW9aR1dzbkxnb0FRSklybTZXVlF1SjYxdjlIY2lHS29PdXd5UHNCODVUOWJ5?=
 =?utf-8?B?UmJKbWVqQUs2c1BVbzJSZXdRQjI4R2RhZkhDVjZVaC9vSllKMmN1elVrdk9L?=
 =?utf-8?B?c0Ivb0ZoOGpTd0JoYkxJOEpBajJLRUMwN2xla1Z1ZnhVU3phb0lEMnJDbmg3?=
 =?utf-8?B?WFIxK2tHOEtlNjZxZHoyYWdVendteUpSL3ZhZm1wQm5EdFpGN2NaM1I2aUo5?=
 =?utf-8?B?ckp5aHloQm1kb3dINUgvZVJNNkhkSXB5dkhwZmlqUDhyaWoydUNnaExiTUpl?=
 =?utf-8?B?SGQ1bUFoMkU5aU9EcWtrdmI2eW00bXFjYkx1Sk1VanNpYWVvWGJSeTg2Q3dM?=
 =?utf-8?B?NDltZG5ZUzhScFlpRjlqM1JpMFJFMFdOTys2Zmp4ZEJvb2xMbThDZGt4dzM2?=
 =?utf-8?B?OTZpd1BRMUJtT29rL2trQ1ZlelN6ZzBKbE5kclhtdlNSS3prL0E3TTFvV2ZJ?=
 =?utf-8?B?RmxyZmRRaE5TMW10c2JuU0txbFd4dHNZcFl2cTBmR1l6ZHJXNjF2OERnb2hS?=
 =?utf-8?B?MU0zdFkrWjZ3MFRQZS9md1VaV0d6cTVPbUJTaUw3b0czNTIvVVQzMHVPTTFH?=
 =?utf-8?B?bFp3M0grcW9uMVVKWUVYMU0vamRFK1B6SlVVZVdFd0dTSVJLMWRuZnFCZzlY?=
 =?utf-8?B?ellyaVBwZmI1Rm8wQWlITlM0b3BFUk83Vk1lTWgvS21wMGpqRkQ1OTVsT3Fh?=
 =?utf-8?B?T25VekptTTBVRW5tRkcrOVdZeXZLSzNxckxNM0MyWWVpOUUzVXVjSlhMRGE4?=
 =?utf-8?B?Q1NrWHVHaGs1KytqbUlKMGh5bWxveEhMMG1manp1VWNrSElkaTFwQzVDTFV2?=
 =?utf-8?B?T2FzMTZmR2lpZEVCMEJlN2FVTFJZTjdKb1FjL1ZDUVRkZFFGaVRPcW02bjRp?=
 =?utf-8?B?K1JBR25jUUVjei93QzJYV1hMaVdtb3gxZWhuM29GeHpQdUVPdnVJSTR3M2h1?=
 =?utf-8?B?MG9nZC9GWVh6czhyL3FZdjVMdjl4KzliSnlJQnpKUTEvczA4M3QrR015Szhm?=
 =?utf-8?B?bitXRjRLc21KZGliWCtZTmRDZUhQMVNSNmlDMTkvUXlXR1VESVZGUnJqRVcx?=
 =?utf-8?B?bUtFQUpQemI5bkdSbWtvZFRnaVpod3VUb2ZWZUUzVDUybFJFbGtFSVRmd2dS?=
 =?utf-8?B?T09BblhnRG5ndWY0dWhKWnl5RzQrcVU1OTJjSDhiQlNkSCt4dGtsTGFGRUdQ?=
 =?utf-8?B?OXVrUGc1Nzh0YmJia3FZRTFiTnFEYzNBZE9NMmo2MitBeGkwVjM3RWVlNVR6?=
 =?utf-8?B?MXFOOXBsOG8weFRVUTU3cCtoNy9makMrUUZjNk1RSU5JQnR0bFJTTWNoL2lM?=
 =?utf-8?B?OUhnYXJXaUVwbk5GUWFrbUxlTnpybWdXMy9CaVloTW51R2p6cHNORVVwS3Jq?=
 =?utf-8?B?bGE0Y0NLUEwwaks5UGY4S21HUkJKL0ZFUFZUb0cwQmZRRjVzZmszSjAyZkJq?=
 =?utf-8?B?ZWh0ek9rRm5ydGpTZXVSektqc2llejBBSnZmL2NtUG83N0hxTXNpNVBSWE12?=
 =?utf-8?B?S2lwdmVLQ0JtZ2NjWXZkOGdEdXJncDFWcFVpVGZoZmFBdUYwRlhSN3J1Rk8w?=
 =?utf-8?B?VFB3d0sxSFo1VVFXdk42NlFHRzQ2UnNyeUhNbStzSFh3Q01hZm9pcDVKN0V1?=
 =?utf-8?B?eFJuUlhORG52MmpEcXlTRHFrdzdYUmdxUFA3SVZhdHhwemYvSWEvcUpGY1V1?=
 =?utf-8?B?VXV3WlpuNVpTeUk5M0FOMDNLOTVoLzNMTllHKzVSdlN1Witzb09mZzZPTklU?=
 =?utf-8?B?dUU5cmRTWFB5WXJpMUFDY0tmN2xCbXBBbmxZcTBJdHhhWW4xMzZLeThhRzRt?=
 =?utf-8?B?OGlJVFVDeG8wRG9jc0pteE43dk9ERkVwa21EdXlISzhBMWRSU1E3WkRISXdX?=
 =?utf-8?B?QVhDa2Y3OHZGOFpnajEya3hPbllkNXd1SW5MZExlOENkRVJCVVg0TlhWKzkv?=
 =?utf-8?B?UFc1N2R5MUFFM3JCVXpQMkNudy8xcnFzUWk0c0c5RlpQUlgwaHZnMjBlZlFq?=
 =?utf-8?B?Mm5SVjl2SzhnWVBTM2VxcWh6cWNaT1RYd1RxMFZMTnZiWGpqWmpQdlVKTlBP?=
 =?utf-8?B?RW9UQ0QvRy9kTDRmSTZxTXIyYmVCdE1FeklsRkFpRDFMT0RLdXhVMGQwVFc2?=
 =?utf-8?B?UHFzdzdVZEFCSGYvRDBnK2pxK1NXOWtueDh0WU42alNxcmJYUzk0Y0ZLd0JP?=
 =?utf-8?B?OVg4V1NZR1VhZEMveC9aYnFZa2orbWlEaTcyZWs3TmhzMTFCNFFsdmZqTFcy?=
 =?utf-8?B?dlRQNTUvVE8zTzRNSDNNTGVyZVVrQWJjSnh0S2I0WWZWRi9hK0YwdjVZeU56?=
 =?utf-8?Q?NVcFgYuS5Q9VzACK+SccUS60LxlMh0LYVjvySHVMofBcx?=
X-MS-Exchange-AntiSpam-MessageData-1: fgqivZPoHMiaXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62f9865-b9f8-4bbd-049e-08deddb67b47
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:34:55.6576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/0s2B2p6bozTPv+IsUj0RwQX5PUPfXccuyKP+iVTiD4vIph3NlRr1v1vdBKgD+gbcMB4v/l+prjbrNsYV56Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

Title prefix should be "drm: nova:" I guess?

On Thu Jul 9, 2026 at 5:52 PM JST, Alistair Popple wrote:
> Currently the nova-drm stub driver doesn't really interact with a real
> device, so it doesn't have any registration data and has no way to call
> into nova-core.
>
> To allow for this add a DrmRegData type which will hold a reference to
> the NovaCoreApi associated with the auxbus device.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>
> ---
>
> Changes from v1:
>
>  - Drop unrelated device::Bound removal.
>  - Switch exisiting import to vertical style.
>  - s/allow(dead_code)/expect(unused)/
> ---
>  drivers/gpu/drm/nova/driver.rs | 16 ++++++++++++++--
>  drivers/gpu/drm/nova/file.rs   | 12 ++++++++----
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index 739690bc2db5..0204d1cee6a5 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +use core::pin::Pin;
> +
>  use kernel::{
>      auxiliary,
>      device::{
> @@ -17,6 +19,7 @@
> =20
>  use crate::file::File;
>  use crate::gem::NovaObject;
> +use nova_core::api::NovaCoreApi;

nit: Let's add a blank line between the `crate` and `nova_core` imports.
