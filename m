Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0941088E5E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC13A10E7EC;
	Thu, 19 Mar 2026 02:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="M6loVOB4";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0163310E7E9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH6qwUo2LeiuCiUf9Z9Mn7JGea+4ed5nmwuls1zOD8WaCusoNSH2dh7MoikM/f7LEY6r2+8DSarFxUquml0d9jh1WUMKw/bczYimx/0XdNUzco57al8Deq7EZGZoEPTMRmDdChVdz9L8lwZrrL1gZaviyh4E0nbmDY236oeGt3hG2tD+goThlOIqVxi3/mNfPCXA/mhbyIyuIVH0vWqIO42wRzrQsrO6eHxEBDbmoCPBUZqo6+1MA8UqO9JTazt+UpPuL8vCVLWytYXskouao6hWS0woY/kQLEVLh7Ymrf16bQ8OMtM28nID09ONJ4E3BBqHNKXSc54J9CZhyZyvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5e3JtHJGu/ffFP8t1Dq1k8k654jGWKyBsxJ0YqmJpk=;
 b=NhvGIpusR1yZW2ZpKt0Zx5B9lnK8vpyAe7KOduXXJx+kBuyo1E+vkyhqPO8iPy4YbPxtUOu68dfZLo3TtHlmMJ0U3aD+NDxza+kXxieQWHfChL76GvWTD8Zsf/YxJh1vnbyBBcyNFPikg/zYQLWUMcmnk/KZkQRenZ4j9mJqmIlsxG8blP1PFeYD8a/E6SIzt6OGXtJdxXcKs9Tegcph6qBRuZD+d/fh0EaMJCKnM9Qa0v3eUfrZeuRuZi1htyUjBbZlAlW+r5FBBr2RJRvdlsmI/xhkygFirqCHRs0V2Avc6G23YSbMDJdeN3Mr94piI9YyZ2TL3Yg5oVM2ee1RAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5e3JtHJGu/ffFP8t1Dq1k8k654jGWKyBsxJ0YqmJpk=;
 b=M6loVOB4RamYdMVlNBypihGVwdJNT0FQQDEtsMGlCGmTiJrtEgLjw6+Dw1qg7Ud2vUc4fhIAWuZl9hoxws1XAQ0X72XZItis0wd8qE9FHdBxP1L7N2LDj9cincAIrJ2XKHPeuKzeKv1T13o0sKxY0LNUsju1pNAL01rx3R8b6BwQCImbCrm10BqkTSA4CI5LAqxaGGD+6YwH/id5J0hgRI4wuU7ZRJgGnMUA/qWKMe1nMyHntQ/vEFeImIYHJ1P1ZsV83WSjyYOl4JvtWB+6YC6tHhZYki4TTaPSABmgiVKUPdTD2O5K/wJpQ3yDTTUfyqV32yQElDv1KMuIo1waAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:07:08 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:07:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:07:03 +0900
Message-Id: <DH6E45B9EBWR.1MAR230QYC2HG@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 4/8] gpu: nova-core: convert GC6 registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-4-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-4-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b92347-e805-4d17-7bbe-08de855c3905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: S+tOyXBPNrPU6DSBU37xOTUiyYfe+IsEBkqdXjmPLb5KEOZThjdO5x68+mSFdCmV7Gi9Nkn6SdkP12utSMj7Gej2ZFFDnEYRR5cYqXVtw9amHgOoAAlIRpeGfyFeikYkxDxvgGV2C0R2SU58InYqdUXL4RXuHoLpngMBVrV4SH1zUVAUGB6u6Mm4hbXArjb0DGL03fAtfaAANdtKDcXfmdY2hHovkYkcm0aj7GOiI1waSEks0cUCZ9KJhNZpfFYE1TKWKMdmVPPXwLEu9pseAjR5MQeweIGyF/l93WKI/z1HyVfENqGOvVXxmZsUoSRrCXZpnKKyvwC5Ih1I9nX2D3jAoPKQEmr46w7VkqueE2rr7DByX6o8QbQJC8oDQp2zSw5gG0xuGI+ixeClVOYaz70wSy7cP0ZxHkPelGs86psp3lN9Bowim8Xp/eN4urM21cjanckT/eKNja2Ls8UGiqRZ+32ANKocawg4alzeNaSMC70dAwPmPlymE0VB9uVNKI/wmi1Z29c8cA9uFl6fzt3AO/wFjjfZzFL5UdbJoM4zOCWMEFQGad+Pg5bu81DdwwYDMxFIxuZQ95FfH/f/1LFKMS/rTwLXhEFeJxB3OQALNHCDcbOgzLLhYrapQSEI4Adz5qGKVaXB13+VM3HRuGLpfckzQN8aLOKHF2rJv2LBqFhEG6K6IVqUA5HBsbNDCsJjpoB0Popf66Qybq4+Js0zk+R/lWXD3sSakeAbYBrIdneHWDM8HZux02XCNjicNIiwPJmY6LhO8s0KLJv18Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGVweDE2NU5GVHMwUjZzUEc3ay9sK21SeXFNNVduZnF3T0hJQUVZWGIvRGtX?=
 =?utf-8?B?NHlWWkV1NnBkMzdITy9vSnkxRnEvdHVOZ0tiSGYvdkFrNTk3bHdOYTFzTUlj?=
 =?utf-8?B?bmIzc1EzUDNxSTVnL2hhVXJvejc1L0JwK1hLVUx1bWJZZVRUOU5Ya3c0SlA1?=
 =?utf-8?B?S3RQK0Z6dUdQL0lvMi9KTHlPN2VLaTlicElJaE14a2Q4dlhLTEtob3FzdUFt?=
 =?utf-8?B?T25kZURvblJyaGkvcm9LcWNnNWhwcU16OTlqR3VwZzh5UFFOQW9GTWFOQU1w?=
 =?utf-8?B?UW1yVWxrNDVnRWFnV2U5N1hkd3R0c1g4ZVE3RmNrbUsweWEwTUV6YWRscDlU?=
 =?utf-8?B?S1VXaHBadFdNTlV2OVlLZGU0L1pLK0ovK0V0d2s0clp3bUV1MTk5Y1hyVWNN?=
 =?utf-8?B?bUgyaURkMEFTMGRRY29sWTByNUtVaHhlSHJIQzdsR2tGeDlwQ0NCWGNUSk1E?=
 =?utf-8?B?enVmaDVaVStmeSs3cjFyR2lWUzFsdVlwY1ZEcjYxL2cyVVJLb3REVkhxckxS?=
 =?utf-8?B?VitqVy8xcXJPU3lLTnRkVmVubkRmQ0V2b2FjMVFhU0lXaWNLanBCUURYalZV?=
 =?utf-8?B?YTJIWE1QR1FHRVd1aHRqMnVDd0FNMUFmWTZoZ0phd2pobUx2SUs0d3BmdTJV?=
 =?utf-8?B?eE9XaVhHckppQWgxZzgzSDJ4aGJsZ2syZDFlTjArQ2JuazRGbnI5azNvNnV5?=
 =?utf-8?B?NWpDOEd1YXhaMDJyQnhHODRPTCszMldjWWFGQUUxNHM4OVBpeVY0UWdIRmlT?=
 =?utf-8?B?SXVLQ3Uydzd0S0tnbWxYak5tQ0ZtVC9WMEdIY2hUMlhzYVM5UGJSbDROYWYw?=
 =?utf-8?B?dFhKQURKRExPcjFqQjlKYVFpbi9jaDhEckl2SzUzSWdxemh4anlObmpnS0RB?=
 =?utf-8?B?eEZobHNxYXBnUGU1SDRYVjA4M1Mwa1FvaFFNaFF0eEpWWGVGanNGUktkaTcr?=
 =?utf-8?B?ak5FVWg5bEN6M0xvUmFiOURMYXBuNWRkdEw2dURZeTdaa1ZnRm5GOVVlblNC?=
 =?utf-8?B?bUg3Zk9DbDc5VFhSS3ZZME0zTjd1K1k3eXRyZUMydUZZWEYxZE5abUgwN014?=
 =?utf-8?B?blBvdnhMUU5pU2xZMEFscW1YM3VudTVwYmZ4NmdHNDc1L3hBNmpNYU0vUUU4?=
 =?utf-8?B?WVNTTFpLRTlQYXJrZTBUcEN1Qlp1R1lnVEpWQ0orVmZ3WVhOTGNZQkl4ZE95?=
 =?utf-8?B?bDFUTVRwRjJYSE9lU2N2VXM4RlEyVSs4clJmUG9sKzJvM3B2MUdMUmVyMlhF?=
 =?utf-8?B?SWRiVU8zb0VBcnFOdHBVbkdISGdicUhKRVNvT09kY3JmU0o2Zmt1UHpDdFVB?=
 =?utf-8?B?Yk1FZ0tkVGR5QThCT0JWclN2TmNCbCtUK1dSeDF1OW5obVN0RThpZmtCVU5H?=
 =?utf-8?B?QkZYN054U1RYS0NVZDlsOEhMOHZ5enV3WitOTDBkS3B4N0tvYnhpOW1RREZO?=
 =?utf-8?B?NGFobGdYSmcvSms5VlBCc1ZtbmVqcGFQRmhXblBicXVFWTZScGhaSERjVE9a?=
 =?utf-8?B?RzJnRSsvcjNMRDRhTlNSQ1hPUFc4bXBCRFdiY3NseG5ObU1GbWcxdm1lREo3?=
 =?utf-8?B?TEg3YUVIQnFBbUprTWJmbUhiY0lwem9tQkZENlNDOURVQVh1aDF1dUVVVUQ5?=
 =?utf-8?B?TitNQ1J1WlRjcTY0ZitzQytwaFBRbkNieDkrb3RCTkpJVnZ0MVJQWUdKRDQz?=
 =?utf-8?B?MXFpemFaN2ZZU3VVdXFHUzdab3pXOThMbnpsVkQvNk44QmdjMGlkWlN4WVVL?=
 =?utf-8?B?VEJjdG1oZW0yNWN3N2lnQnM3aEVPcm1FZ0RON0x3Z1crblJwL0liNHNvbUxG?=
 =?utf-8?B?R2JhSytZT2Yyc0diMitnSVROeXR6SWJIU2MzZEtVQUMwcWI5Uy85eW0ybTQz?=
 =?utf-8?B?Y2RxaEZsYVlrUmNoVmQ5bWFiTWwrNE0ra3hKQjVoUUY5eUV5YSttUWhFNWVz?=
 =?utf-8?B?RUR4K2FuM3JkTE05eiticTVDZGVFR1FuYXZyb2JGUXc4bUttVTAxMDRxM0Zq?=
 =?utf-8?B?dkR0alN1akEwZ0E4WFlkT3NvOUZ2LzJKS3ZCamVUR2NKVHY3Mi9CbmFEOCts?=
 =?utf-8?B?YStTTDRjTzJKWGJlVmdpdzF6KzQxRkp6ejl4VkFqRTBZZm5SclJvZ2syckZB?=
 =?utf-8?B?THNpUUVkeldRMEdseSsrbTlZeEhBa2gvWjZ1NHZqVXhQUXljQStudnFsblVn?=
 =?utf-8?B?Zm40cEFkUzlvNjVEbFhGaGEzaHh2S01sajc2am1JT1RHeDJQSVg1L3R5SE51?=
 =?utf-8?B?b1MwamdwUHZlTERUN0xKOUtNdVNqa3JxS1V2Um9XWkFiQ2lmeGdZK1VOZSt5?=
 =?utf-8?B?d2t5ZXR4THZqbE1KQnYrZG9sUnlRdGU3VkEvSk9FczhseHdVWGFST3UyQnBE?=
 =?utf-8?Q?cLLu5lQXMsYZviduoorjPN0c+4jpYvZ3R0gFCtyJWZZ71?=
X-MS-Exchange-AntiSpam-MessageData-1: EZY7CmxcCLAl8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b92347-e805-4d17-7bbe-08de855c3905
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:07:07.6721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO70LZcjuCFGcJQBOg2Kw3+pIyOc261FjqLx5/XYV7vleUqpvsB4QgC/QAtiIPr0v69V/SKB4Ldc29rSpKw7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all GC6 registers to use the kernel's register macro and update
> the code accordingly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>  impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
>      /// Returns `true` if GFW boot is completed.
> @@ -252,16 +253,17 @@ pub(crate) fn completed(self) -> bool {
>      }
>  }
> =20
> -register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
> -    31:0    value as u32;
> -});
> -
> -register!(
> -    NV_USABLE_FB_SIZE_IN_MB =3D> NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
> -    "Scratch group 42 register used as framebuffer size" {
> -        31:0    value as u32, "Usable framebuffer size, in megabytes";
> +nv_reg! {
> +    NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
> +        31:0    value;
>      }
> -);
> +
> +    /// Scratch group 42 register used as framebuffer size.
> +    NV_USABLE_FB_SIZE_IN_MB =3D> NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
> +        /// Usable framebuffer size, in megabytes.
> +        31:0    value;
> +    }
> +}

This is not an issue with your series, but why do we have
`NV_PGC6_AON_SECURE_SCRATCH_GROUP_42` which is aliased to
`NV_USABLE_FB_SIZE_IN_MB` and not used for anything else?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

