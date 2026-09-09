Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B79C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EB410E1D5;
	Wed,  9 Sep 2026 15:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Q7C1yqsv";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021126.outbound.protection.outlook.com [52.101.95.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AFE10E1D5;
 Wed,  9 Sep 2026 15:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcifu5jvRRqDi0vUvot//P2WZT7bMhVWAogRpi7Ld1t8uinJtC6txKT3HlgSGpF79IeY5e+YYc1QOYaXxwncUl/ldHb7sOn3fcSrl+YxNd2t/JApFE+uPdtgStg8X3wRt+83vW+MqtUXjEHbyTTnIhQcRmO7tFAwfLfMvbDG+r3DVBLgLQa902nLZi4wz1qGNPnYooKughdYikF/5oF8DFtH27GWWzkLdwi5PMNnr2zrNHvlWC1H9BDr9YYzV/7b1VtNxdf7eP8loUWWF8B72nG3q3XpYHvtuW5xRDjVTpeDe7oTCDgyiY3dhK5KdomLpKu3onZAg5mKUYptSS/pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8FnZSSbCjL2BnnRbLvYuZp4YwiYAKLm2EBxT0poxRE=;
 b=N8ERifRIjYBCe7s4Ap0iGj3gsOrHj3n9uj8PLswgVJ3f7MqbOVi7j0TRDgy433DUpa3z3cHESmiaZ0n1I1GAjOMfyLCVISFE4KK1gYADZnFXVRGGOZ/DxU0mkkw6DTpC4lQ9YtKgYJcNelaEXzUSFn1bqndRC1UqrIormt9lp8MzQOpumQwVsCVCY6y7g6X7eqqigVaZS3PHXZMdg5Ui1JeBLtTFexJylLSzsAK0MTXRhmlTrgY4+X2E6vmQj10vnPQwMIhfo4/YuwvpeNv7ukbPYis9DpbWwhW5gf6vt5aRpsT3GKxsm4V1Mcvfhx0TU8liZ4/zmmnl8uczIoG7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8FnZSSbCjL2BnnRbLvYuZp4YwiYAKLm2EBxT0poxRE=;
 b=Q7C1yqsvT0l9MaMiUklACTLYnbhyfhZgHKxX8OryxrA6R0NESNCLrLTlwdPibhWTAU5Qe4aKKWtr0pqChWn5xDaVQ/L56ffEC8gAjSB1C8YnQsMrSU2g4eRjIynTm002N5efLVGnl9Y9WYChvtnD9Jd15Jd35CFZmJu28WPLEWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2595.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 15:51:04 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 15:51:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 16:51:03 +0100
Message-Id: <DLAWLU6AXFHL.21123DVM64SKI@garyguo.net>
Subject: Re: [PATCH] rust: drm: gem: add missing handle_free to the object
 vtables
From: "Gary Guo" <gary@garyguo.net>
To: "Mike Lothian" <mike@fireburn.co.uk>, <dri-devel@lists.freedesktop.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <alexander.deucher@amd.com>,
 <mukul.joshi@amd.com>, <rust-for-linux@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260909094729.1593-1-mike@fireburn.co.uk>
In-Reply-To: <20260909094729.1593-1-mike@fireburn.co.uk>
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2595:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f15f307-2eba-45ac-9282-08df0e8a2768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10070799003|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HRq3fTW6L6mDXrbUEl8PP087kIeGZquFbcBeWZG06thpnbKZn0FmqIkRYDNmF2eJQFya7iVfKe+K0V6wLc/k3TqmctBK2Mk1SxymAUW6HREHrRk3F1Uj5ZCswkZUlpCseI+RLithGRjLdNZvXnDzwd5tkSgzB65it06/T76sVOugvi4N/WTqmjkHsw5WgK+pN+I+UkFLnGw3ocWld5BzyfgB+I7ZZmpqpyD1P/6JgiEGAWd2WR2b1O1/zNDO+dQaMBwzOetaKp4NFzpFYJJyvZHT6Vkxg6NeWeem/nGlghXGpGA4gbc++JolxqRQcvSTmlQfUWVvfNRune2/Y8yBJi9s2rAxv1Z+MhytUmmVNjyuFlfX5DNg3dm0fJ33VjL66BdOYJ4mA5IDDt6t4vvju8qmFKrwfBqnbfqrcp3ZoQlgmVU7/HQkkk9JD6USnZ57YSoLCntLL2k46CBpiBSkSACtr4tCRizKU8M+QdPY/zfgzQ0RWCH11mFZikIuwcJa2TFAQ8Q7IrybTgDQOPQdf5VKxIq1U2Uukv3fW4XHc7gvUOc3t5MfAJO00p5iwHesqvwxz2HJV/XW7wl4xI8FLNN60fsR1HbwbjJ36xFBJahHcGZSnLlW/333Ym3DFuvt0QWZAqBrtjrGaSVB/lfAUSNxn/VI2B1bqLGuajmStnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmV0TkVEMmQrQXVzMzg0eWFQVEZUaXZ0UitHK2YzT0RTc0tGanJzcS9UeEdh?=
 =?utf-8?B?SUZSdFpFOUhwRUlqdm45RXRCU0dOdmt6eEQ3RmRyRHNaSDJHdm9uMzFwVDh4?=
 =?utf-8?B?YWpGQnVnSlVGQzFqaG5sLzFiQXZZR2JLa1IzSTdKeXRaMnExQ1Fock5JSlFq?=
 =?utf-8?B?dFhXbE0xMnlya3RIUkl5VW4wWnlWejlVNmJ3aHNValgzZGorOS8zaGVyWWVD?=
 =?utf-8?B?bzRnSFRlSVZBSTlzdjNwOVNJMGhsL3ZyNXIvZHAzdXVqWGswTG9IVkZtV2M3?=
 =?utf-8?B?U05LOUJyVWZoY3BYc0dKYW1BdzlzdTBmYm8zSndaWW1wSHZ2L052RTZjL2t3?=
 =?utf-8?B?b2tXMW9kRkd1TmJmQUxpQy9PWWFjUnFmdGx1ZmFiM3hVQVFlSHlPS21RNlVY?=
 =?utf-8?B?NStGWTFkc1JMVDR4UWtna2Q3NDJISXNiVU9wdHpoT3dINmNBL3pCZElMT2Nt?=
 =?utf-8?B?OTlCVjUxd25PS2Y1WjdiRk9sbFFRT1NaT2FuSWhzZnRPTmJuVEV2LzZDdVh5?=
 =?utf-8?B?MWNEcERybm5OOE5WQmd3YU5jMVpzbC9MVmJ4UDlORlY2RklleCtnbTJvVVZS?=
 =?utf-8?B?OW9qL3l0MkNQamJvdUwzT3lLL1l0Uko4d04xaUhlN091cEg3cC9UaUlVWlV6?=
 =?utf-8?B?NTR4VnFNdnBqSWNSbWY4UjdRa0l5WjVMZDZwZ3Vjb09sWGdnNEZTclRxOVEx?=
 =?utf-8?B?d3M1WTJoS0xRUk5CUUZkNXliaXY0RGRyQit5emVmL2Z5OE8zR1pQMXhMUHR1?=
 =?utf-8?B?Mm9uOWNLL1pZaU5WQlNWRHUxMEVmNmN5dXRSall0dmJZL1VwL3I5WVNQYlQ2?=
 =?utf-8?B?eGExMnhUbXgwbmJ6MjNhdGg3Vjh2WXRFMTZqOTBON2duazhSdHNja2JKMXFL?=
 =?utf-8?B?M2RZVEZqSldrWThyRTFlQlVrZnRaQzdvSkZjdHl0Zng1eUx2dU00Smh5TS9S?=
 =?utf-8?B?RHlhYU9zd0YzSUFWUFVhSHcyUG9hVEhLQVZSNVpMM2tjMjBhZ2h4bGppNHUr?=
 =?utf-8?B?SEd2QjhjeTR6NXpvMnZCQU5WMkxkajFlN2o5QVdseFA3WnU2dldub0V6Z0JL?=
 =?utf-8?B?ZUsxNTk0eVdsekRSZFNGSG5BM2VnMXQrSHFqQXBnOGpkd1djMXZRUElleUV3?=
 =?utf-8?B?VU1GbFFPcDNDaksyNUQ4U0o5Q2dFaDNyeDNXWDIremJIU0JhOWVwVTlZRyt6?=
 =?utf-8?B?ZGxBdkV4L2NIMkJxekhGcUdzYXo3OE4xcVZjTmxVQjBlSElUSE1BbXJrdTE2?=
 =?utf-8?B?WEUyMHRsMjBtS0h1VHV1RitxVmcyOVBLaHZWaGYrbVd0WE1PeVBUUlZDYnJW?=
 =?utf-8?B?NWhoZk9UL2YvMVJjTkh4T2lZYWJmaVhyRXh1WVd6bCtCdnMxekIzaVN5U1Z3?=
 =?utf-8?B?YndmYWRndmN5YmZzdHlHYm4zNVJSWTFaYXlPTXE3TWp1d0JzREVBZHhidkZ1?=
 =?utf-8?B?MjVzY0lVYXhnZG5rRTh4QWhvbUYvMFh6dUI1aEJmeTc4RTJNK2ZnTllGVmo1?=
 =?utf-8?B?VEN5U0dvQlpVT3VyUnZiQ3BaeFRkRjMvV0tmbU9oK3NEMjNEUUV6dlBPcENs?=
 =?utf-8?B?akdLbzllbDNvZW1QWWhNZVlUVmVHQmNKTHZaMEZ5V1hiQlZvaFpjU1o3ZWNS?=
 =?utf-8?B?ZTJWaTRMSFpBV3M1cWV5ZXordW5CSHplSDVUcWZWMlExMlIwdEt0MEhUcnpa?=
 =?utf-8?B?VEF3VDIzL1hoQ2tZNWJiUWo4aDZuVUgxSU9vMXAyeWpCN1NMdEYzWk5VWGFp?=
 =?utf-8?B?eXAwTkFvQ0dLRXhNUEVtem9ZcHl4QlhTVzhaNGoyQXN6QkhwL0hVYzVyVkhV?=
 =?utf-8?B?cklHSU82aU15YnBESzNnc0FkR3Q4RUQ0S3ZhUklacUQ5M01PSHVnSVdubDBo?=
 =?utf-8?B?eU56RmdFSUJDSmE3SjlESldYTklNVXZSeHE4WldvMTM3bHZWSU0rbjlGRjRo?=
 =?utf-8?B?Z3diZUVhWU96bG5YaXMrTTN1a1N6UzhmUkV3SmxvS1VoeDNVNWM2bFg4a0kw?=
 =?utf-8?B?cWZiRHh0NG44Q0VDdFF2eGwwSE9FNWE5OGg1R3o4azM1UGY0akRlQzNiMTNC?=
 =?utf-8?B?SEZQZmk0d3FjR2hhSlBYSGNxUlMwaHFXZ0F1WTZQVVRyN2NHSkxrdkNXWTJF?=
 =?utf-8?B?YlRESnNCRS82THNTSmhwcFJtYWpKY2MrbUdEVU54WiswY0xIZTYxbDhNV1Zk?=
 =?utf-8?B?NUR2ZlpUQWM1cEViNHlvV0o3OVh3VVBud2wxNEdDb3pqeXArYlgzRXhyWEdC?=
 =?utf-8?B?UEJ6N2IwSW41MHlncDhhMVZKd2NDTG9LaUh3LzByYkZsc2VDV3IzbGh1eHZF?=
 =?utf-8?B?K3VCZlJsay85U2poUVNQUy9OWHpZQ2VmYUx4emJobXJuNDlhUytKdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f15f307-2eba-45ac-9282-08df0e8a2768
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:51:04.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bSSWiHJ2ZR69Q/v766J5VjYXy95NDoqn05QPiVPbGD1ZS/SZOLuTkjQqd7kgPgFTgNKI3LCa+F/puVJDjY3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2595
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

On Wed Sep 9, 2026 at 10:47 AM BST, Mike Lothian wrote:
> Both OBJECT_FUNCS and the shmem VTABLE initialise every member of
> drm_gem_object_funcs explicitly, so adding a field to the C struct
> breaks the Rust build:
>
>   error[E0063]: missing field `handle_free` in initializer of
>   `drm_gem_object_funcs`
>
> The callback is optional and the Rust abstraction has no equivalent
> DriverObject method, so leave it unset.
>
> The shmem copy is only built with CONFIG_RUST_DRM_GEM_SHMEM_HELPER,
> which DRM_TYR selects.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to=
 0")
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Assisted-by: Claude:Opus-5 [Claude Code]

There's
https://lore.kernel.org/dri-devel/20260908175427.47207-1-klarasmodin@gmail.=
com/.

Best,
Gary

> ---
>
> b67d2d039f64 is only in agd5f/drm-next, so this can be squashed into it
> instead if you would rather keep that branch bisectable.
>
> The shmem hunk is by inspection - CONFIG_RUST_DRM_GEM_SHMEM_HELPER is
> not set in my config, so only the mod.rs copy is compile-tested.
>
>  rust/kernel/drm/gem/mod.rs   | 1 +
>  rust/kernel/drm/gem/shmem.rs | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..ae61ca7e1246 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
> =20
>      /// Returns the `Device` that owns this GEM object.
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a687d46d170d..d08a03cb7a13 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -145,6 +145,7 @@ impl<T: DriverObject> Object<T> {
>          // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on th=
e C side.
>          vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
>          evict: None,
> +        handle_free: None,
>      };
> =20
>      /// Return a raw pointer to the embedded drm_gem_shmem_object.


