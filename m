Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFBF1099B31
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0F910EB1A;
	Fri, 20 Mar 2026 17:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ndM3rtdV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E4E10EB1A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz4C3XLFxB5j31n/BMgTC9cHYaQd3VyGfhPy6OrDXyGOQ7bkRwuAHLywZayjaEyXC74BGdU3PM9honsMBF+uEoPfW5xmyV2eoeC8QfDOxC639CyGUQ8z07iIdvNZ2OJSB9D7UHY9Zo0lmSNL3MckoL+kDmJe5tw2S23VCqyyzRCt8fU1/zG65Zc0XNKIrdoDzMTKrxznooWe6lAG6W3jbd7B7sZVThSkVhpOtwa++4cUBXOVENO8rrJPmErYWKzOnOgRJ+Eq5kReKBlGkcdbgsUAJJcmffVkfqt+rAbi1nPkrEuciqTYcnFHCyHz3tWIYHmyZMZUEb/MUubYDhB0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZwJLRTD80Cd+zYB77wu0Rr6ysysHpozlXgpBT62r/0=;
 b=VLl12TVdH3xpgF/1ophtLSf8dXke8dRnFUQjZjn8ttOVGa03KyA62sc1Tzph5/ZbfdXm9+nZJL1AQwyxF5q4sHCTifj9ZBhScNnasc725UG17Dt0sEF1Sm2TJ2JEmqcJzNOqENxiCLNQjKail9LDmqZqjXM9pqKrnhBXEp8GhTt+xTN+neyp/IetraueyJmQNtCz7fwWt3O575T0aGcylLNJRHQw+hHawOEdFWiphB5jADcoQcHRD9Z+U+mZb7K7bcfI9jIa/5Y50dpkd2VT0Io96ylqDuoTIN6yvFxPqHisxkw/cxg3GbpI8ZSIJVoP9oQvqAgfLDzUaXZhLH6IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZwJLRTD80Cd+zYB77wu0Rr6ysysHpozlXgpBT62r/0=;
 b=ndM3rtdVfiLB1Oh9DBY0wvJVsGHaimYI+PoaBJWZFxR4Fztjs/rMlP2lIqr9x6cm76KSAheQC7aiRzdVCUQ0lWayxv0l4JtY25mshwlr1h37RgQshhqXFvDKbMBRJaI4bdq7q6z3BsOpwjv4PADcrvz+RwDCCep8J23Jjrm3bUfWhhDsRLqy3bbxwutWoT7ErcEPA6g+ecKlhJpLpWoIN9/17GnMUMUv247Bh+GrBsAN8mysY03RveLxS4XxF1okytbss2H8tkLtyrvUaFvtUnsKRdk0kxMnUQqpZO41y6Xg7hAGpWQ0almMVWysFDr1mZbm6IWBeOcrH/YZdnuB2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 17:33:44 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:33:43 +0000
Message-ID: <0231b5bc-03f0-4207-b0c4-fb6daf19d135@nvidia.com>
Date: Fri, 20 Mar 2026 13:33:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] gpu: nova-core: convert PDISP registers to
 kernel register macro
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-6-88fcf103e8d4@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-6-88fcf103e8d4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b88951-4eab-41cd-27c3-08de86a6d56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: HG/mRtlniOjg2Vi+u7zta2ofUl4CncndP7bMeWl2Eq8l+sbLP7VtTcacUjxw6Ybq+Oda0T3DYd/4XpyfC7vugA1GsKDEH5TyDlBQzGy20/9XIwqlJi2/b/EJxvlg3rQ6u3+P1P7vg78RZQc51bFLsue/rKOTqbu0GdzJa6vtIEwMOmHYFOkbYur+qzePmNo26BnqNNOAA/mCj5Y5bMbTTRAD3fbrdnAzvce4wRf0FOf+D0XJdAaGt6rpKf8LLAOb+kmbMI+sARI7xlwfrK87HRj5pnS8mCTz/9frGMBExklLlBGF2n0mVRNHwdhsMfoOIXVwZBNGe7cEpXRR/bmK5dpDETjjCcPzDO2QvC79SqBvQ+Clna0IrXwELyjiLgkLF9JP5KddHEsWerlrUExBJprDjwuaJVNz/kM07uWcrNf1+KV52skTeb1M0iiSgJRusVmQ604EyxYYthUu32KZzXPSuuUHXn6PyNcHW7S1f0Dkyq7ACA6NrAQBnifNnDbmtpxmutWC17x8jz2kBaygBWmxVzrs9pr8b0iv5NSuPPSFgtfkffZhT1zL0B7KV/12bWCqdpVaj/UiQnHQ13vjevk8Lb/3NldvJLmeQv/6xmroJcmKYFtY9aTCxa+ZeJ9BVy+54HRu6mOncF0qWfAK+SrYyiJzF6lBeYr50pnKqx8pj8mJVmFnZpkDr251wQ55u2BaMn1bragNsmF9+lgcuUWIeKOMRfnd23cID/GKBcyK58KZUtJIgg6eWLKEeVdr+sF34VqVyOyAb2nGpmr/KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJrQTF0VFFGQ0xUWUZvMlVUV2U2TG9maHhYSW5ldjVoSk81VFh1YU51dE1I?=
 =?utf-8?B?dkVUUHhDY3B3ZDg3aXFxOE1LWEppaWFmV2tlV3VMQ1cvTGZTUThQc2RVem9w?=
 =?utf-8?B?dWRrUGZJRUczeEltUVlSWG0wYTZlTXpDU09JaXp4QTgrTHJ1bmlLMFpleEpx?=
 =?utf-8?B?bXhZZlhMejFqU29RbGxHWFhmSGhnZ2JKVFlaUkdDQlg1bzA1MU5xREl6U1dl?=
 =?utf-8?B?RXVOV0dPaGY4YmRLakF4NGI4eEtBZmxNYm1qb2VMVnJBa0U3TFJVK3lkYjRs?=
 =?utf-8?B?QWZ4NnFuYnhUY1lKTktUUUR4OXhhNTZERnNWTTdVVEo3Qlp6TStHZDVoVitU?=
 =?utf-8?B?Vm85eER3SnhQVHRkS1F0U295TkE4T1pVTnJaclZQQlJtVG1NdnFNUm1ybFRO?=
 =?utf-8?B?dmNaT1ZqRi95SW9TZEQ0b3FHUnNPN000aGFJSitCWFM4OWIwSnY0UitqQ1VO?=
 =?utf-8?B?dkI4WXdxMktwOFN4bmxZMlBxNFV1R0NHemJ4aG9KR3RVMGdWbys5NTdQc3Zn?=
 =?utf-8?B?L3VMME5TSVpDR0paaEQxR2xSY0lVUUFGTG9ST2kvbVlrT1VYTk9HWDhxK1Fj?=
 =?utf-8?B?OVRxeUlTSVg4ODR6RTVsN0JLQUlnc3FNTzk5cVk0c0pySFdNVkZEay9nR0tO?=
 =?utf-8?B?S05QVkQ2TUJuVGtSK2pMNXg5K1NEa1lwOEpRdVlQOXdOU0dySFJvcjR4TG01?=
 =?utf-8?B?cGpRb2w4M0xCVmNrOWFqVGdlK0QrK3pRQlVJaXZNV2FKZ1NiU1VLa2oxNlB1?=
 =?utf-8?B?ZG1Ea1JrZitDV3k0aUhSNDNmZGlTMGh3UkF2NXRGY3RTdVB5ZFU1cVdjQXVv?=
 =?utf-8?B?c3luM3JrWTVYV2pldkR0akpVdGZldldrOXBPdGlXS2VDK08zZHdnZDMrdEpN?=
 =?utf-8?B?dkM1TzFEeUtPT2hNbzhjQUNXSkQ4QlhvUzQ3eGNKQ3NLaUMycHRDeGwvUVdE?=
 =?utf-8?B?OXh6blJRdFdCUkxnVHZwTXJwTVpjWG4zenVJMzVxQko3ZHc5UTFsTHdGK1lT?=
 =?utf-8?B?cExiMEprc3VCN2k2ZkJVNHJoOUw1WkdRVUxDZlpQc24wRXpQUW5zVEZnYWZK?=
 =?utf-8?B?bm5XcVp6SlZNeXQrZ2x2QWhBcm96UGdkeS9UVUtuRDh2QW1TMmR0empxNDRm?=
 =?utf-8?B?WlB3UGJ1czl6R20zdjhSc3hTVlNZOGI3Z0gydG9IMmt1ZU43YVpZMUhkTWRJ?=
 =?utf-8?B?R0EvQmJkT0dyN3p5Qmt0QWFVelhHSmJKWklqY2dKQUt3b2JCNzZER29tNi83?=
 =?utf-8?B?bU4rZHJWYnRXbmRKQkYrOFNuSk5ZQzlFSFkyeUJ4YmlTaWdYMlpocEFoc1I2?=
 =?utf-8?B?SXZNc2VxblRJSm5jWWpSLzdJbVI4K1lWTlk0VVpTQU8wNWNEYVFnZHkvcmxi?=
 =?utf-8?B?VEJ2R3R5RFJtVDV0L1cyUFdibEhYRDhBN3AzZVJPNW9BTmwvdVBZdHkwM2Ir?=
 =?utf-8?B?WEI3U3N4VUpYMlBNSWFjYk1odkVubUtnQk05bXp3QlhVLzVNbEV3MUxyVkc3?=
 =?utf-8?B?cnd3ZFVnYTBSNkVLang2d3JuMVQvZlVvWCtKUjhLcnlVWkEyVDdiTEg1RlUy?=
 =?utf-8?B?SS9SU01LQy9vTWRsMGNUT2trK3lQbmVmRS8wcGUwKzhBcWlKaFV5TU0yUDRi?=
 =?utf-8?B?RWN1Wnp1bXdMcW13K1dIdWpIeTRuaDRFcFNqN0xGOE9RZit6Z0p5Zmxvb1R0?=
 =?utf-8?B?WHJTa3VWWWExeisxNjNJOWRjSmt4Y21BVEZENCs1VExzQ3hMaU1MTGJzMDU0?=
 =?utf-8?B?dDBZTDlnajVGeUJVaC9vVjJuQ0dPOE03cHhvVSsrN2lRWEoxT1hIQ2dWcy9h?=
 =?utf-8?B?N0VoYWRsemNDVkFnS3RpRjZPUGQ4UWZndkNiOHJNckJLbytSUERmWnR6U05J?=
 =?utf-8?B?OXNOWWdGOEs4MU1PVm8zUXB6OWlwTUU2Sm1IQk5mMnBzYzkxbGFmZHl4dElm?=
 =?utf-8?B?azdjdGsxTC9XUDRNeWs5YVM0M1hOOXUrYTNxaHo3SGJOVHhkbFp3ajNCdjI4?=
 =?utf-8?B?VTJtK2FudDdFU0dnNWh1MkVTU0d0WFExcWo0N082UUxaL2J4Zis1UlRYWWVV?=
 =?utf-8?B?eDhpMmZRUzZrOEpieE1RTCtiTHZPUFpSVjNvakQzaGZ5a1ZZYVZJM1ppdW1S?=
 =?utf-8?B?MzdPVG5PMG4wV0Fwa3VkVktwSkNqNVlDR0QrcmxXa1hZZVJ0TmRzOHhMdEZ5?=
 =?utf-8?B?c05QMnFJRTcxRGxFdlJKakpKNmZEN3hiK2c3RXZuUjVJTHB0c1liU25XTkRo?=
 =?utf-8?B?aVlhaWR0MVQ5c2dSbWJUSkxHQW1OaDR2UHM2MTdLejlRSDgxa1Bla3ZBcDRq?=
 =?utf-8?B?WmZJZVpRc3cvMlJKaWxRcVFFSDhqUGhTc3RrclB2WE9rck9DYlhOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b88951-4eab-41cd-27c3-08de86a6d56c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 17:33:43.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFBXtgw17BdMxRq8NLQAStixtOJ22JIexiuCh91gK3V/7KoLvX3CEzX5U2wzh7NKuiWzSXgzpNUj1kjJ6+4U2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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



On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
> Convert all PDISP registers to use the kernel's register macro and
> update the code accordingly.
> 
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb.rs   |  6 +++++-
>  drivers/gpu/nova-core/regs.rs | 12 ++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 6536d0035cb1..62fc90fa6a84 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -8,6 +8,7 @@
>  use kernel::{
>      device,
>      fmt,
> +    io::Io,
>      prelude::*,
>      ptr::{
>          Alignable,
> @@ -189,7 +190,10 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
>                  let base = fb.end - NV_PRAMIN_SIZE;
>  
>                  if hal.supports_display(bar) {
> -                    match regs::NV_PDISP_VGA_WORKSPACE_BASE::read(bar).vga_workspace_addr() {
> +                    match bar
> +                        .read(regs::NV_PDISP_VGA_WORKSPACE_BASE)
> +                        .vga_workspace_addr()
> +                    {
>                          Some(addr) => {
>                              if addr < base {
>                                  const VBIOS_WORKSPACE_SIZE: u64 = usize_as_u64(SZ_128K);
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
> index 61a8dba22d88..b051d5568cd8 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -250,10 +250,14 @@ pub(crate) fn usable_fb_size(self) -> u64 {
>  
>  // PDISP
>  
> -register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
> -    3:3     status_valid as bool, "Set if the `addr` field is valid";
> -    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
> -});
> +io::register! {
> +    pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
> +        /// VGA workspace base address divided by 0x10000.
> +        31:8    addr;
> +        /// Set if the `addr` field is valid.
> +        3:3     status_valid => bool;
> +    }
> +}

Shouldn't this re-ordering of bit ranges be a separate patch? Also, what did we
conclude on the ordering issue? I remember this was discussed, but I am not sure
what the conclusion was.

Other than that,
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

-- 
Joel Fernandes

