Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35391C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7942E10EA32;
	Tue,  4 Aug 2026 13:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvTzZrKa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBF110EA32
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYU/9xdqNO0XN3s0mPUpUWggyyJZ8v356C9DObnPxLg58SBSG11b+Fr2fmCM4dTP6c8B88LezVsOiidsbCYZn/Gl8PCfrjXjfIRnR1Rd5Gkj7Qi8mtYFWsj11MhQsE9+w/EOITrdP4/4kYl6/dQ/YebxT5dulQpw3thyTGZ/Qq+Z6gJ5hjTtLS2I2IT7uEMvPm2ORHMx9MulnAEIEkacwaaRUzdQ888NEfYwCgge2A1NRpd07WjUnaLweJQfV8ntBY2QnUu6NGYM78uGL3IcnnWclX0S9hwAeUysevIB+R+VjNhMxDdFP4Pm01ENANxi0S9DEF9tYrZ/jE8ksT7faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy5JR8eTzqJlWVnbuIpDbR9Ltx42piHTkl5mtLCJRXg=;
 b=lIqg8pWOuiHjWdOJKo10YAb2nPoaZv74xl2qSHiqIJhhesUmPP9bOkCjOw5ZX/bkb5pdc0UUhumzDZTfHJALcBTXqp8DF2N2d9VyrwAlI3rdmA0h0XzOAFBI8KaepCXN9fs3PzR/Tsm7cXzmVNSOUc5DHy1rta7IGGO8lcVDRSnjvR9kk6hfcRcbEAZ3f80uMuRs8zIIyb5SIesx6FYC+rkxrGxEr1vcwFcvUvXME+yue+SxZJuwgKElz2NTJVu73AtZJwBcBee0LnQvScNY200bseB9CnduGawUWV3zJ2FzWOL61CEDQh3JWnSQMER3MuXM+vpjd1U1/pSkM9gc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy5JR8eTzqJlWVnbuIpDbR9Ltx42piHTkl5mtLCJRXg=;
 b=mvTzZrKaikOUDRUed4NlyqT5bEXUP/Wd7YM9kW9PtEY5MHLqzLC74337UDwRA6UuHdCumH63Oq/gM32zxi63MqcNCixqDKQ0SPQIMYn+7b79hp8VblzNlAs8LxDJEvdG2V9ff/IH4afQV6rNuPx4IMbH7Aqi8pasXGDs4P2ZSR3yzh/vrGP0ABtEceeaVcpE+a2ZtELyi61e4MbmgE9p6IKAn6h0NbOqMHBZWlbfVVFv+ZLniBWy+ROWyCL+z477IvCN5Mz98M3lv8SZUPgVRnCwusDhMwXw0TkV50ylxl/DJ4CAifurj1D4jErf7PR1W0HmCqfd9lb0da1PiANF+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 13:08:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 13:08:09 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 22:08:06 +0900
Message-Id: <DKG6LGDZGWNQ.1FL8VTVTZGTGJ@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] gpu: nova-core: correct FRTS vidmem offset
 calculation
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
 <20260804-blackwell-fixes-v4-1-ac858b6a1935@nvidia.com>
In-Reply-To: <20260804-blackwell-fixes-v4-1-ac858b6a1935@nvidia.com>
X-ClientProxiedBy: TYCP286CA0311.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: eae3f621-4d71-4e3c-55fa-08def2296e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|10067099003|56012099006|22082099003|18002099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: m2ni3edp6HdI54AdIr1r406zhHQabQHeB872FVzItvsMTQjayRDKc4vPL/X2mMYOZLRpOsalzcf5nwWDLGtxkQ0pJZS7RdnKNVrqU7P6QwuPfWHPO4bu/7WWwMQG6hRYuqh3T8iEbt3xZOHsaB91z68w0KN3BP2eKKbqTRqEtU1W/95IbBL8xdcp8Lhf55E6HfGjf7WeJKn7J/tVPLWJ3mwHl/Vr9PQRRXq8i3UK9YVnHsWATdOIYJmqsu3UmcmtfITMVlRRoWM136fzMuyvlHm6op8nPVbGVbWvby3JldIj6qX4HeWiOwoOgmwQzMzZoMxDnMCh06bbIGBqZwj5W9l1UoNVIHarKgZyF3l7Zo/YXnQB2gj8zj4FnACgZxBjJF/BYHy+rPDLqvM7vYzSVEdCb69RVjF52R5QgebvPveC9gSd129b6LZCJvw5Wlg089yYEVa6Q0nGVHlo9BTbyKlJzqzQqZYf9JtzP2i30AoxDTBTpRT3fimiE3jU4rfQVyTmApfEkbq9wKVWaad0Cd+Yi3tpCasHrm/4fVmrAPQsGjpuxvmYd/qKuVuv1zWLg/CeBFb+ec2q98rtblUR3AfeqO71yMEcU2JtXvw3lEhbnrXWLbKZjgJlh5g6eOa9lUGaqKqSfcv+ourLv8Se9JkH7+3qfWn77MskkhXMuAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhSbStxYjVteTArRjFhZFdST25MeDVmcGxUMUQyUGgrZW5veFN6UEY4YWNs?=
 =?utf-8?B?Rk9NMXVhQjVFcTArcHhMdmNSNWk4V1orYkZ1Q3FrcjNWUi9yVm1PS0Z0UDNm?=
 =?utf-8?B?REZCYVZRcll1Smp6V2pCOW1QeS9pcDc0MUU1dUdaL1NHd3MzZlQ1dG15WnVM?=
 =?utf-8?B?VG04UlUxWjAzaDhoUmlaQXM2ZmRua09KVXYva0ZtOVRZdEhVSFB2MWJndDNo?=
 =?utf-8?B?VVlQbVlQNWkvT3k2YVhUUFYyOHNscTFIdVhCa3c0NjVBOXo4SWRoNHpEUDlT?=
 =?utf-8?B?cVJpVkNkZUxYaFZuNzJBWE45dXdnZndlU2lkU1hrV0RJSHgweWVsaDhUVzJm?=
 =?utf-8?B?aTB3T3JjTnVxNktRS0FKQzY5UTJMSzNXTGptTlJpOFRwb3B0RVQ3eVNUWkZv?=
 =?utf-8?B?Z2RUODBCUVdvbkJ6MGMzL0ZJY3UwdTY4dGJoZWhJMzBza3lkMmFuSHQ2ckEr?=
 =?utf-8?B?b3g4R2JlcnRZc3owMkd5dmN0Q1RJYW44SE52anAxeXYvV0xFZkRWTjUyZmla?=
 =?utf-8?B?ZThEdUcrSzQ4UythOHRLdGZrRmhRRlFnUGNhOVFwYlpCTFF2ZWNJQVdkanBk?=
 =?utf-8?B?dk43czBpSjJHcU5Ia1FtaVZ3NEd1TVZFVFJ5YzhjL0tsNFZzdXZtN1A3R1FR?=
 =?utf-8?B?K3VmcXFLQ1Z0Y2lYa1Y3c2tEZDQxZ2NGKzBhY1g1U20yTitWSHZGc2tYZXJH?=
 =?utf-8?B?QU1VWDl3ZFNBNkdSaFVDakp4UnFSVXJudjNOWGxTRkF0YmR5Wko2bzU5anN0?=
 =?utf-8?B?MHRDV1NVc01KSy9MRXFGN2F2V2NCRlVSd1lMOENKUGtrRUVMdTV2N0NsZDhJ?=
 =?utf-8?B?SkczcHdmLzMvK0RYVGduMHUrSXQzaXRleWJXa3BPaVA0NlhCaTk1cWw4UnZT?=
 =?utf-8?B?bFZEZVovaWxjSm9rdi9XZkd2R0FaYUFqQWlabVR6VUF3V0NvN1VhaFl4d0ND?=
 =?utf-8?B?T2psL1lIU2pSQVA4WVVxbVprcWw0YUdKandOb0ZMMGpOcWhVMHhkWFRlMXlw?=
 =?utf-8?B?Y0RCYWFyTFZ6UjFaQk9HR2ZSUnZEYW10R1diK1h4b2lLMnhsc3Q4Tzh3MURs?=
 =?utf-8?B?Tm81V2dxOWJnSjltY3kyY2JKYjU1TkxNdEVJMHBwcUV5TEIvcU95cFNZUWJi?=
 =?utf-8?B?dG85bGR0V2pGY2pWV1ZrOXd1Z3YyNTVZVEdFdWlWeHp1TlJ6SUJUR1ZNd3h0?=
 =?utf-8?B?NCtVMit6TE5hcnpGZVdQd25YTXp3Z2RqMlMydWVNRVd5ZjRubWdnRjBCRVd4?=
 =?utf-8?B?NGxMczhJUEx4ZkRkQUovZ2txUDFzOE1QRmoyODNJVFFSZkNUcG1YTG5xbDJS?=
 =?utf-8?B?RzVZSkpualFWSXFiaWdRSWVQQmlIcjNNOXczelBydzVodm95ZGgzbFVEQWhj?=
 =?utf-8?B?RmNxOXBmellXdzIrRlJHS0p1Mm5Ia25SbFVESzFqdkFqOEltd05ycVRkZlhq?=
 =?utf-8?B?YjJXMXF1Q2VLa1RRT3FEaFVaUC9NNzQ3cGdBdngvaExFd2VBTExac1FROFlI?=
 =?utf-8?B?K1M3NGFlb0ZmUTllUUhOSmtFc2QwK200VG8zTjU4T1lkSmgvNktmWk1IeS9D?=
 =?utf-8?B?Ly9udHhmTFlKMHdNRDBwRkF6ZEpXVzlUVWI1NTJLaTNIRmp1TkFKeUVPSGI0?=
 =?utf-8?B?Vld3cG95L1FPMXYrcStRR3lGVUc4eDdyazVyYThaWnlVZ3NlZDNYb3RpSkZw?=
 =?utf-8?B?S0ZxU3RtSUJ2YWptZUgwU2tPT2NITnN2OWJTSVRWeGI1ZXNYNy82K0t0WGJz?=
 =?utf-8?B?Ulh1TGIwRlY5alphRTMxTWRXaXA5T282RFZhUTRLVlQyS1BDS2xLenlKSEtW?=
 =?utf-8?B?MjlzNnZoRlB0eUREZzNCQVR4bWZqR202QmhPcVRiY2NscnB2MDk1WFcrdTR6?=
 =?utf-8?B?ZFlJQktPeVpaQlFBcGpQcHhvYzNDQ3J5VFZ3ZHBvZVBpOGhLNDJvNG5WcUVx?=
 =?utf-8?B?NzNaUi9HSW5YNjJxNW5oLy96ajJPNFZKVm1DOURhU1RLUlVGMnhkdjFMOFp2?=
 =?utf-8?B?aDdwbGsxcHE2MG9RSDdobmtiN25EZCsrWEJTSm1CM3RFZnNjbVU1emRnNDYx?=
 =?utf-8?B?WTg2aWtLOXRQemFmVWZqOXhIVkZuSkdpdTFGZTBaMWkwMElBenZtdm1BRGda?=
 =?utf-8?B?YmdGTlZ3WDR4L0dCMmNaczJMT0MrcCs2OUIybTBnTXJTUHdGTEpVc2N1SnUz?=
 =?utf-8?B?YTFsNjQ0MDlGaTl0MGxxSWIzK0tYOTVzUkpVeWhYempxU05rVzZ0OGhaNTFU?=
 =?utf-8?B?Q2gvcGdyZzRNMDJsb3F6UlFZMUZTbEJoaUZSckNwV2NqVUhKb2l6Yk9RV2hX?=
 =?utf-8?B?aHBtM0FBeVh6ak1BeDlRdUUrOFkxNU96L2V5dEJxdnA2M1diS2pSQkVBSW1i?=
 =?utf-8?Q?eOmYCcP7nosVj4v2cSI1WPtBIaeawcb+39vAqeRflXSVR?=
X-MS-Exchange-AntiSpam-MessageData-1: mpAzvY87MhDAVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3f621-4d71-4e3c-55fa-08def2296e37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:08:09.2383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGkUkwXpZ/MrdJ5hXUxyuTzrynWXyhhU0PN7qPCJ4EkvoByIR8aigsXxI427WdqMQgW78qffrTL3nOJRlJGuRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

I'm basically ready to apply this, but a couple questions inline for
potential push-time fixes:

On Tue Aug 4, 2026 at 2:41 PM JST, Eliot Courtney wrote:
> Currently, the frts vidmem offset is calculated based on the non-wpr
> heap size and pmu reservation size, but this is not right. The layout
> actually looks like this:
>
> | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
>
> It's just by coincidence + generous alignment that the values happened
> to match. Instead, define a per-architecture reserved size at the end of
> the framebuffer and use this plus the PMU reserved size to calculate the
> frts vidmem offset.
>
> Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of =
Trust boot")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb/hal/gb100.rs  |  1 +
>  drivers/gpu/nova-core/fb/hal/gb202.rs  |  1 +
>  drivers/gpu/nova-core/fsp.rs           | 27 +++++++++++++++++++--------
>  drivers/gpu/nova-core/fsp/hal.rs       |  4 ++++
>  drivers/gpu/nova-core/fsp/hal/gb100.rs |  6 ++++++
>  drivers/gpu/nova-core/fsp/hal/gb202.rs |  9 ++++++++-
>  drivers/gpu/nova-core/fsp/hal/gh100.rs |  9 ++++++++-
>  7 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb100.rs
> index ec55ec3fc7e1..7e5b0e3ffc67 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
> @@ -80,6 +80,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: B=
ounded<u64, 52>) {
>      );
>  }
> =20
> +// This PMU reservation size is r570-specific.
>  pub(super) const fn pmu_reserved_size_gb100() -> u32 {
>      usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment:=
:new::<SZ_128K>()).unwrap() }>(
>      )
> diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-cor=
e/fb/hal/gb202.rs
> index 69ba35d2ea08..c590e5b1269c 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb202.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
> @@ -73,6 +73,7 @@ fn pmu_reserved_size(&self) -> u32 {
> =20
>      fn non_wpr_heap_size(&self) -> u32 {
>          // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, G=
B202+).
> +        // This size is r570-specific.
>          u32::SZ_2M + u32::SZ_128K
>      }
> =20
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index ba4544210e40..a81b51028282 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -251,20 +251,31 @@ struct FspCotMessage {
>  }
> =20
>  impl FspCotMessage {
> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. =
It is measured backwards
> +    /// from the end of the framebuffer.
> +    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -=
> Result<u64> {
> +        let mut offset =3D u64::from(hal.fb_end_reserved_size());
> +
> +        if fb_layout.pmu_reserved_size !=3D 0 {
> +            offset =3D (offset + u64::from(fb_layout.pmu_reserved_size))
> +                // The 2 MiB alignment is r570-specific.
> +                .align_up(Alignment::new::<SZ_2M>())
> +                .ok_or(EINVAL)?;
> +        }

Sashiko pointed it out, and I was on the fence about commenting on that
in the last revision, but I find it strange that we only align on
`pmu_reserved_size !=3D 0`. The only chipset for which this doesn't run is
GH100, which is already 2MB-aligned, so this would be a no-op for it
anyway. And worst FRTS would sit slightly lower in memory, wasting a bit
of space above it.

WDYT about applying the alignment unconditionally?

I'm also fine with keeping it the current way, but the condition
deserves a comment at the very least, say:

    // As per OpenRM's `kfspPrepareBootCommands_GH100`.

As that's where it comes from, but the OpenRM code does not give a much
better explanation.

> +
> +        Ok(offset)
> +    }
> +
>      /// Returns an in-place initializer for [`FspCotMessage`].
>      fn new<'a>(
>          fb_layout: &FbLayout,
>          fsp_fw: &'a FspFirmware,
>          args: &'a FmcBootArgs<'_>,
>      ) -> Result<impl Init<Self> + 'a> {
> -        // frts_vidmem_offset is measured from the end of FB, so FRTS si=
ts at
> -        // (end of FB) - frts_vidmem_offset.
> -        let frts_vidmem_offset =3D if !args.resume {
> -            let frts_reserved_size =3D fb_layout.heap.len() + u64::from(=
fb_layout.pmu_reserved_size);
> +        let hal =3D hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?;
> =20
> -            frts_reserved_size
> -                .align_up(Alignment::new::<SZ_2M>())
> -                .ok_or(EINVAL)?
> +        let frts_vidmem_offset =3D if !args.resume {
> +            Self::frts_vidmem_offset(hal, fb_layout)?
>          } else {
>              0
>          };
> @@ -275,7 +286,7 @@ fn new<'a>(
>              0
>          };
> =20
> -        let version =3D hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?.cot_=
version();
> +        let version =3D hal.cot_version();
>          let size =3D num::usize_into_u16::<{ core::mem::size_of::<NvdmPa=
yloadCot>() }>();
> =20
>          Ok(init!(Self {
> diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp=
/hal.rs
> index b6f2624bb13d..aa2f8bda59d2 100644
> --- a/drivers/gpu/nova-core/fsp/hal.rs
> +++ b/drivers/gpu/nova-core/fsp/hal.rs
> @@ -19,6 +19,10 @@ pub(super) trait FspHal {
> =20
>      /// Returns the FSP Chain of Trust protocol version this chipset adv=
ertises.
>      fn cot_version(&self) -> u16;
> +
> +    // TODO: consider moving this into the TLV firmware metadata when re=
ady
> +    /// Returns the size reserved at the end of the framebuffer, in byte=
s.
> +    fn fb_end_reserved_size(&self) -> u32;

Only noticed now, but since this is immediately converted to a `u64`,
and in the same spirit as patch 3, how about returning a `u64` directly
here? I can also do it on apply.
