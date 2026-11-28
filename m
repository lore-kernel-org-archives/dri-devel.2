Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9C606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EXqvxZ9a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06C110E6F1;
	Sat, 28 Nov 2026 02:03:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BBC10E6F1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD3+eJwYhqwFMGIky8aI8ru7AMQjcyova/wQdNEkFR3uFEz8Ir/yXNBZVqjTwUz71I1+dDy/aDWYJillSez8NKS8Fshm2TG1fOEc9qwKBAEnlBgQfa8UP6Q23U1rl0m2jQYvGe+GqAlcETeeB9c++phs1097JFQyot92a9DzfA82hG4URJa9E14ZqgwksC5rrAJmzKGdJvo3e5vKSXh6Yz3aq3gRQCTnmWpiBbFTx+Cbnd8Eb5c87xqAM5GH+e4NbVWSXC0++jWz9RQ7sBfnTgvDM7n6QkR229XC1tRWFpFUblcTNxA5fuAzxqFeef75fR6LEj4ujTSmoyGGCt+tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xncD/1oBca53kxNQvi8fza1DPxPIygh6ii/aHI5uA0k=;
 b=DSqbYB/RSGhE5lI0Y/w84AE7HsMpxZGOTekGOaWITGe4aPuBbuPCh7cykSI86ehE6jxwQGDi7PbJKyHkneYXu6JYItSwiR3FxLLrT2Rk+gwajk/y7UxMOwoBUtk+u+vJsfaqQ3N7V9sr4mhDXrd2BwL1cNXJO6btRCM/k5cJft2NOOG8r4QrSWsLeXJxG3XbYi39YpOoklSVh/d1q6J9Fmi90CV2U+j7eERd8mkQRPbd3F7ikDbXg4uU5lJFzUjcfybMfTalkUHibWmtrXs1GVEdbwLBzBxOvvE25QUYYAdifTFhrnpuNm2ii5+dmjn7Kmtb5D3JJOaDnTNvW7wgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xncD/1oBca53kxNQvi8fza1DPxPIygh6ii/aHI5uA0k=;
 b=EXqvxZ9aEsLWp51K4X4Vzx/Bdc2XXe4aE3pCqv+6iVbte/vxwyUzZgDkSson85JvC7GTx3cpxs8MS4HfHsn9hw/uYXUszmS3VcSoEyX+zl4MUyLKw7tU52i3W5ellHbbLWQv34ofdnpFmu0xvx0Q2zbDWf0LWNoYwNTxTxO1XZHIaQ5avBum0rTzvYI7z0H4/r8tBgMx939JJXVl9wN/TnTF75r8hCr/nkY55jN62k9KLnR90PfYtERoqp+X5eV1GiYIXiQM/cwKuiYr7BYGC6WltiR8o1vtsBzl2O3Pw1340tzyXRGMhMgpfnxYBMq1tarU5nMq9dwNbVoIsuNX+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Sat, 28 Nov
 2026 02:01:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Sat, 28 Nov 2026
 02:01:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 11:01:44 +0900
Message-Id: <DN6H2GAT9F0Y.2ZZRVU8FZCYZB@nvidia.com>
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <ecourtney@nvidia.com>,
 <jhubbard@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: mm: serialize PRAMIN access
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20261126213652.3716162-1-dakr@kernel.org>
 <20261126213652.3716162-2-dakr@kernel.org>
In-Reply-To: <20261126213652.3716162-2-dakr@kernel.org>
X-ClientProxiedBy: TY6P286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c6a659-d1a7-4b95-a220-08df4cf38f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|4143699003|261026121527099003|261021123027099003|261026140227099003|261021135927099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261028144727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: TinxDzQKh7usHhTiQC1eGkOWFuzZKbQDx99SodSWxCGHQsk+8UXtKvzQlpl4qmr2vZNd4Fn48wRYdb7hmWW0RBstM36A7q3LiPmQI6gzx2D/cdUbvGC0GjB9Z7KGBHxn0MDeDTPIhdxHYVjmZ4uCn4IUmVUcTeSPw/CtLwB3cOTWBWD1EYr4AjNv94xkjfXyH0fmPtzSebRkKDOhwBvH+1xPYq0GJKfW1RKLs+fRstPWxODe85LwDmZjEQnuhSM59YBBxLJQM2Ian+iQ3d4PDZgnIpF+uBTxv6kj8eQ2ukQc3G7VbKmLUXcIRMb1bIBQwxxegyHUjp+4S+jtYamQSMuBFGlkwBLAyYjeBJfLl+o9Zc54ODuojYjiazsxdv+ChBUI+6EFK8dwGavcjS9czn9MVF9CRhxt61z97MyerC3dddXsUolb86kikRNSNj3JOfX9cHa69gnFWKrCKvUD0yKxoAXP29pkAAH3jsVrXfI9xfAe/nKzqzRYGHHAYEaNQ5S8YkNgkBEBgdnvdaaK7EfIzgL5ZQ7pTJGp/B+ub2/SbT51sXw2dJtB1NZrWShLZ7Mq5TAAVj2IInnRk59D0HnSCSH66VH2w0eRhZx0CrXhAGqx/gN45A5Hbhty7VLtp/OnqwZaFA6Br3p5ZDUsFmdWeCIGMjc/ZTpkXqH5Djo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261021123027099003)(261026140227099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFpU0IrR29LOThOZmtpems4dURJbjNENUJpb3BqSG9jZ0VubUtxdFc2Y1cy?=
 =?utf-8?B?bGRjVFVKSE83T3hqa3lQV0lab29XZFgvOTdibU5EbUhhdHVQT0VjcGFGNFJo?=
 =?utf-8?B?ZUZNcHdDR3Q5R3BkLzlrR05kMmFGdjdHTXQweEFUQWNzcGFNR2dmSDRaaW9x?=
 =?utf-8?B?VU9BNG01ZUM0azBwQlFpWkJra1FNNjlOM2VHNG1JeiswVmJuUmtPVE1JZ3U5?=
 =?utf-8?B?RVkrVHk3VzdZRzFhcnJPQjlseWgrWUVvYjg1NUwvTS9XOWtWS3lXd09Md2o5?=
 =?utf-8?B?akNqM0JnRDBYckRqc1FhRXlxZ2hEZkt5NStzTklpRHpuazJJUmppTTdhQ3JL?=
 =?utf-8?B?OWh4Qm50czRFWm42dkVNY1NZenk3RjdCRkNCRmsxblVhSjJNOGtkRzJXM0Nj?=
 =?utf-8?B?RFZ0alJYUXBMNzJCSDVlcE1rRDBUaVk4U2NSVXErY0VYWnVQclozRHg2UFJZ?=
 =?utf-8?B?VGg2WDBJY080aVpjR1dWVG54UmVpSWtQQkhKUnJPY1p6cHJRYjBpbGNweWNm?=
 =?utf-8?B?MXFCRy8xdDhaRm5LOGdMbWlmRXFkNHp4N2tvRmVJc3VqS0h4RjhZbWtqWE1O?=
 =?utf-8?B?OGVzc1VjNUtPWk1TdEp4QnZTR1VNcDZWSVJvR204dEFUekRCTE5NSVc0QnN2?=
 =?utf-8?B?MzJXeE8yOXJNTGRYQmVNemI4S2ZLMWdFUS9YcG1GUzdxUkdoWGdROTRrLy93?=
 =?utf-8?B?RGxJbk5KL0NGZ0htWFkvRnZBZnI1NEN1TGFxQjN2dEdmQW0rb01Sdm1TdzhK?=
 =?utf-8?B?bzlzWjNIZlBBU0pyL201VGZSMXdveGNoNmRKdHFKcS8wT3FFeVZaZElVNHRS?=
 =?utf-8?B?L0NONzVVT3I4dFQvOU9Ba3VPVE5welo1Rks3Tis3bGRGTHN2bUkwOVBiWkRI?=
 =?utf-8?B?Z1dVcm9rYitRcjlOUCtHT1lXaG9uYlJwekwzUGovOVlXYVhwUmVseHczajRs?=
 =?utf-8?B?eDB2a2x5Z1g4WHVmVkQ5eSs3WVVCNkRBNFZPQ0JuS1h3a3d2ZEFqMXN6bWxr?=
 =?utf-8?B?S25mYnBjdWxCQlp3S290aWJVY3R0S0l1T1N5WEZGeEZDeEE1Y28zZkpTTU1Q?=
 =?utf-8?B?Y240L2dYVkh2Mktlek8ydHVRUUZYRGZ5YUtZT1VpUUVvSE1mUDdBTUdjeW1j?=
 =?utf-8?B?c3hXZVdzMWVqbFpOREpFWXFSb3l5RWQ0Q2Q1dmtZbFZZRzlHWWhuSmNDcmZN?=
 =?utf-8?B?TkNOSDdjMTlFTDZhYmRVUVp1WjkzM21yV3owN25jQldqYVl6cU9lSzVPT2Z1?=
 =?utf-8?B?T1RxQ0hVTmtmMXQxTHZYbk9CVDJ5cGNqbTdRK3RXMStKWTNCMmFIdmVZM3BP?=
 =?utf-8?B?cEQ0TUNsQTJ0MGk4ZzlVU3lpa1pRdVJMUVpNbGI3dkZRR0FFbHJGTHpTOVY5?=
 =?utf-8?B?a3NGMjl3RXlSdGdGNlNRWHExZjFJSkdZMjlxTlFmb3g3RWNsNFIySDJ4L0pB?=
 =?utf-8?B?WXJuamZLcHVuYlhMamZTbjU0TjZpNis1eituUkZ4OEZiays3bVAyUzdKaUZK?=
 =?utf-8?B?RjZBRHVZYTc0aGI3UVpjelNnY25SZmROd2ZCZkJSRHZZZXFFbEg3c2U5ak9n?=
 =?utf-8?B?eUVVUjVOODJ2K3ZrMmNmNmFJMzUvSVFMYnU2Q1hvN25hK1dabVpCQ0luL3JC?=
 =?utf-8?B?REFKV0xUY090TXRWbVRVdW5OQVlFVlRkTlFyblFKWk1IK3RNZFNvdlhVQW03?=
 =?utf-8?B?eHc2SmY1L25YSitFRmhlT2JKMzgwYmlqY0lUeHV6b3R5VEZYVEV0bDFMU2ta?=
 =?utf-8?B?Sy81ZGJ2bzVndFh2cGNHTGI1WnJYazlPbkJQOEdPVG9jTDZDK211UVJjeHhl?=
 =?utf-8?B?N29aSGtCakFKSFpUbE9nR1pza0NYVTdVdWhDQktBbno0MHZhdG1JSkRCSncz?=
 =?utf-8?B?Slg1U3hhV2c5ZTBkaU5TT2JWWnVROUQwMm53MUptb0Z6NU04N2RDNW1JSnBW?=
 =?utf-8?B?U2hwbXhQK0NIWDBrcVNUekxQQS9iZlJoZVRtUjNsVTFTWjlPWG1LZ0lwR3ZU?=
 =?utf-8?B?RnJ1UjVZUm83ektFN0VNU2JLZXNuaXczZm9TUXNQQkdtZUdiYVlTWkRYS01l?=
 =?utf-8?B?c2lHWWVUQlZYUk40M0hITmQ3c1cvdDNKWHhZenNjYnkvWDZQenpyWHFrMFdN?=
 =?utf-8?B?L1V3YldMZmlRWVIwdjlZMFhWd0VDN2tFamhoZ1FNdUJjQ0wralFKK0VYU0Vm?=
 =?utf-8?B?dTNEWmkwWDhZdFFHdGIzMUx3b2RQUlRYeVJFbG44NUV4TUxFRjdFSXAyak5r?=
 =?utf-8?B?WHR6WHFNSFJvU2lXVTVOQ1VTdkV6U2k1MnFmSUJlSjNnZ0RtTzNpRXdjaFFR?=
 =?utf-8?B?bnRIR0FQVWZuaDBIcS9SeGg0VE5MQjl6cUYyL0pvL21Da1ZycFFQVFl6MXhX?=
 =?utf-8?Q?hs6kfSluROKWRdWnvQcdj48DGcDyKeUajkPMxBEWDJur6?=
X-MS-Exchange-AntiSpam-MessageData-1: DSUqAYAxk/fa5Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c6a659-d1a7-4b95-a220-08df4cf38f82
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:01:48.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yEkXU8KKe4HtVMlF1K9wuX1q3sx6IERd63CpF8HrMqV1iQmh+/sWkwdCvrtHFrkHP6wF0G5YuxjWJMs4ZMLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 6:36 AM JST, Danilo Krummrich wrote:
> PRAMIN window selection and access must be serialized so that the window
> cannot move while it is in use. Give PRAMIN its own synchronization,
> independent of its GpuMm container, so sharing the memory manager does
> not require serializing unrelated VRAM allocation and TLB operations.
>
> Keep the lock across page table walks and update batches to avoid
> acquiring it separately for every entry.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/mm.rs                | 21 ++++++++----
>  drivers/gpu/nova-core/mm/bar_user.rs       | 39 ++++++++++++++--------
>  drivers/gpu/nova-core/mm/pagetable/map.rs  | 34 +++++++++----------
>  drivers/gpu/nova-core/mm/pagetable/walk.rs |  2 +-
>  drivers/gpu/nova-core/mm/pramin.rs         | 34 +++++++++++++++++++
>  5 files changed, 91 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index f53886f9ed91..bbe23dc6351f 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -72,11 +72,11 @@ macro_rules! impl_pfn_bounded {
>  ///
>  /// Provides centralized ownership of memory management resources:
>  /// - [`GpuBuddy`] allocator for VRAM page table allocation.
> -/// - [`pramin::Pramin`] for direct VRAM access.
> +/// - [`pramin::SharedPramin`] for direct VRAM access.
>  /// - [`Tlb`] manager for translation buffer flush operations.
>  pub(crate) struct GpuMm<'gpu> {
>      buddy: GpuBuddy,
> -    pramin: pramin::Pramin<'gpu>,
> +    pramin: Pin<KBox<pramin::SharedPramin<'gpu>>>,

Nice, this is probably going to remove the `SharedGpuMm` I introduced
(and hated) in the vGPU series. :)

A couple of comments below.

<...>
> index f7774b9cc972..ba23cd3c2b25 100644
> --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
> @@ -96,12 +96,13 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: Pag=
eTableLevel) -> Result<Prep
>          let page_vram =3D VramAddress::from_raw(blocks.iter().next().ok_=
or(ENOMEM)?.offset());
> =20
>          // Zero via PRAMIN.
> -        let window =3D mm
> -            .pramin_mut()
> -            .window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
> -        for i in 0..PAGE_SIZE / 8 {
> -            io_write!(window.view(), [build: i], 0);
> -        }
> +        mm.with_pramin_locked(|pramin| -> Result {
> +            let window =3D pramin.window_at::<[u64; PAGE_SIZE / 8]>(page=
_vram)?;
> +            for i in 0..PAGE_SIZE / 8 {
> +                io_write!(window.view(), [build: i], 0);
> +            }
> +            Ok(())
> +        })?;
> =20
>          Ok(PreparedPtPage {
>              alloc: blocks,
> @@ -121,16 +122,16 @@ fn ensure_single_pte_path(
>          let max_iter =3D 2 * M::PDE_LEVELS.len();
> =20
>          for _ in 0..max_iter {
> -            let result =3D self
> -                .walker
> -                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr| {
> +            let result =3D mm.with_pramin_locked(|pramin| {

nit: With this the method-level doccomment should be about the PRAMIN
lock being released instead of the borrow.

<...>
> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/m=
m/pramin.rs
> index c83b1681d241..841289d7bccc 100644
> --- a/drivers/gpu/nova-core/mm/pramin.rs
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
> @@ -13,6 +13,7 @@
>          Io,
>          Mmio, //
>      },
> +    new_mutex,
>      prelude::*,
>      ptr::{
>          Alignable,
> @@ -22,6 +23,7 @@
>          SizeConstants,
>          SZ_1M, //
>      },
> +    sync::Mutex, //
>  };
> =20
>  use crate::{
> @@ -54,6 +56,38 @@
>      PRAMIN: PraminWindow @ 0x700000;
>  }
> =20
> +/// A [`Pramin`] shared between users, serialized by a mutex.
> +#[pin_data]
> +pub(super) struct SharedPramin<'gpu>
> +where
> +    // Hide the mutex's invariant resource lifetime so `SharedPramin` re=
mains covariant.
> +    exists<'res>: 'gpu,
> +{
> +    #[pin]
> +    #[uses('res: invariant)]
> +    inner: Mutex<Pramin<'res>>,
> +}
> +
> +impl<'gpu> SharedPramin<'gpu> {
> +    /// Creates the shared window manager for the given VRAM region.
> +    pub(super) fn new(
> +        bar: Bar0<'gpu>,
> +        chipset: Chipset,
> +        vram_range: Range<VramAddress>,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            inner <- new_mutex!(Pramin::new(bar, chipset, vram_range)?, =
"pramin"),
> +        })
> +    }
> +
> +    /// Runs `f` with exclusive access to the PRAMIN window.
> +    ///
> +    /// Do not perform reclaimable allocations in `f`.

A little elaboration on why (deadlocks in the fence signaling path)
would be nice here. Something similar to what Tlb::lock has maybe, and
maybe we should also put that information into some module-level
paragraph that we can refer to instead of repeating it as it is relevant
in several places.
