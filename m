Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F7F46C4E
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 16:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D6D10E27F;
	Mon,  6 Apr 2026 16:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQ3uDEy/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBB610E27F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 16:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSA2GBepjPS3Xa/Vg5F2V9Hs3C8ZBc8ZNHS8VMflkWg7DeJlo8LrUe/Oq0H+C3Qx1oiDagFmslEn239nJYOiqO+95e+jgiZoTxKgFAkyWS/NaIaLGj2FeQGovsP6BpsOns4LNppBKKzXSq0yxyPPSSBAUmuvwJBC0VA5/2aE1k5CwbD54Lg0+jXKpCJsVPbruTpzvIpC87OqRK0kL0pwUwMu16IXlsZEdbJIIvtrG5W7XNtiByP38cILk4nvOLXFhDI2FLAoNm0gsGQKULHdsyMgXVix4tQJOF/8sIJOhoFVhjbwRGuPGvep8jUygfZF7Hmtjz7WGFOsEBKKH2JdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amCJV+fsixoSZyFU3Jq27fZPE1d5rHONAoP+CymbIhs=;
 b=BrcwU/r95Inkz7wfYU7126TK5XLVkxh2zyyPNpNiIEZ9zfvSfcFPlpC4al4Zqawou+RFpSeNfx08n8Wbcg5Dfq1Zdm9noV9xlkHliAdDblFSY0GwU4PIkP4JLTY9CZwkqt5P+gpLWWyJDYnnNux82cB+KJTKYHzEHchGoB4wFUeSg8uqjGuKtAgoiLewAprFsPAR+QbNhLrfrqv/XHeqGG8QhhPtXUAc4KDEh5XjMvuRzreP2IDQJmjlaHNli7wcd1bEtBu58gn71mOTtevW3xur6oHA7+SfFuIRy3RboA3V+4CI9LH6r/ItHv5a5nkQHTSvzK7WGgAUAPZdNfwL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amCJV+fsixoSZyFU3Jq27fZPE1d5rHONAoP+CymbIhs=;
 b=gQ3uDEy/aaSBRapC1sqz2dwXAs2mvdyjKISZGb3w2jPLUD3CWTXQV54kx8igI3eZuiKzJApmtNtb+Z/l+6jnw+5QaaOZ2QkVJAdH6/Z342hW8NC9xx9P+gh+laRZ7kwd6tRxdIxApLVV3uYQRB+U1vYdgCin4iCAXqV9qbB9yNn6kaRQ2rTVxZLA/40T2eHdY25d5QNZqjWsyZfesmalwrjGcmJc/ZeWnK5Qo9S7J3focL90M6WfmdGoYSwP5fKXSsRq5/mqDCSsiF2M75FW41TcOi22uYDXxvWFYE4iK/UjByEOcNYoV0CLBkHW4kpahhVzx+ecfAfjTCaSNyfNFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Mon, 6 Apr 2026 16:30:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 16:30:53 +0000
Message-ID: <a66916c8-8e82-4e54-8e21-b312a7badfc4@nvidia.com>
Date: Mon, 6 Apr 2026 12:30:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: require little endian
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0984.namprd03.prod.outlook.com
 (2603:10b6:408:109::29) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 586dc9d0-470d-4ea4-747a-08de93f9df4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PcqCpuoxzjcfMFczavZxJbsNGRkuc11UKJ+Q08iFYHpQt8CExTf/Kt+97J3+Kpi32+FA4/7l5ya7eeK4A4A10vfdu4BKTR/NCsHFaNCX9sAG6Y5aZ8MmdzAdxqwwn8F9UrpxWDxKR+kmY43jtryCPcrqjFreYAwZypXbEOXrMfYzNj2sD9YEw63U0jHHRuCWEwRdpD03QXVXD0sij7XwPwD0xVN3p6VciTnyhyTzQZouD5B5UazRwbij4+5JBDst4vR/YeAovqimpYSaQbPy4afMY46/jmPmBwh+XWKa0S3q/aoxAOZ0nzaKAQlgMeqQRdZpnLUAgktm6oLvKJ7neUeIZfTSIueHzPF7fyzid7caFEc8Cw2+tHqJt2y9bVVgmlCjGU2sjUy4XugaNZ7wVn9XOpp8mxi7xRSJyMLsFq4OSssWLhmkp/td/TBd14szbNazpHnU60pgu4+6/6FKtrfoa3a80xkAnPpM47OObhW5G0JLIfIpM7kuE+hy0bLw9o7RH2eTiMBdnO6hJ+ogLlhSbkfgIr8cNubIVkQP+x98/WNIp7fQ6bL1yRJCWj0UNN7Rp10ejNXxuYPaXrRwS0JXD8kQcmT0RgO5n2MzSKfjDPe8tUFhgGMkGg8yPfZCDcgYeP3sIMpt453IWt51TJblVERM/VT3P7/kKjASwYqN2AFzBcl5WGVDbpHQhoiBJU5dIJMO2TC1iy++jGYFMpT3PVxsdPQcmv9u94s6hQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzc2MWhxYWlQNi9odU1CTmYvejZDcWZVMnNjdy9PNzBjUmY2QkhJVzFNdlgx?=
 =?utf-8?B?UklIMEUrQm8zLzlxT1ptSys0VVcxZjlxbC8yZ1BVeEl4Q2x0RnAxTDJkL0NN?=
 =?utf-8?B?Y0YzQk8zeFc2SnRTaWEyU0lvTERuTnJ3Z0hZOVYzbVprOTBpcnVpbzRZNys0?=
 =?utf-8?B?VTZiZkxjSjBDa1NUNVFxejM1SktYdmsraHMvelowZWhlZWtYSUN5Q2h2bTg4?=
 =?utf-8?B?RzRzalJHZndxWk5XUk1EVisxNTA4cDdBWUV1Q2owMVhFTVlUREZCMVNTOVRQ?=
 =?utf-8?B?Si9DNmlRSlFUTlp4RndFNXZYRk8yc0ZyekRubjZ1ajF1SHp5YmtmUldvdHVY?=
 =?utf-8?B?c1IrN25COVk3V2FMZ3Z1ZnJKZG5SVjlubkJ4V2NITDJybWhRbGxuREEreXJh?=
 =?utf-8?B?OW1pVWpqcFFRRkhEWjRkVk83ZUU4MjJWZUNnbk1qa0FPcDRmWmExM0k3MndR?=
 =?utf-8?B?OE1qN1V4SmkyUEhNVW5hMGVWLzUrUkxhdlVIeXBqZ1pMb2FZN1U3UklNRjBn?=
 =?utf-8?B?QkQ4dXlBRGxOaWNsdERUQnRNOTNYd3grMnh1WUhCd1Y5aUl1OVNHRG16NVpt?=
 =?utf-8?B?U0Uya2drZlhlK21JSjZEMjJEWDM1YU1aSzVsWUVxTjZocG5uMkZZTyt3UjVG?=
 =?utf-8?B?QW1ub1VJUmRxVUpHRlZKaFFKRnRkMWZINUI3YXoyekozMUdhSDJrUTFYN3dj?=
 =?utf-8?B?NFYyS2hicEo5Q3JTWEllNldRZXptQkJ0dVczY2RpL2VFRGFZWFliZkIrTXNq?=
 =?utf-8?B?TnU5a3Z1ZHY4ZTJISFdKVnhIOHliODhIVDJZRnh3eStjRHdyK0RxdDErV3gy?=
 =?utf-8?B?OVdBL0VmbExsVmFGRFBFTHZiN1VmcUVXNUw0UXBiVUdacFZQSFo5VTVVcFJu?=
 =?utf-8?B?anBwTUUvN3BQV2dyNTMwNWlMOFNOY0hUeFN2V0ExR3U3aVV3SlZWWjZIMHNP?=
 =?utf-8?B?WTgzOE5sSEt6NUhrWTVyQ21idUV1SFVncDJjSlZKV1FDRTJZTGR3RGtmMjZ3?=
 =?utf-8?B?cTZvRzluNThaaG5xa1FoU2Rod0JjNGQzQk5ZZTgvbE1pYVQzQ0RySXEwZ1BF?=
 =?utf-8?B?U0Z3MXJEcXVjTGR0N3lBUktHcER5OWIxUHBzK2tVSEZrTXFJSytXTVJVelNr?=
 =?utf-8?B?Z2JJWFViMEpLeDdJaklaVVJRWWJOOXF5cEFzVnJQTEN0OERpZ1hKS2crWndV?=
 =?utf-8?B?VXd3NDI2Q1hLOG5aZnJXemgrbkdrQ1J2MzVBL1d6VU1OejlBMWdyQk1BbzNC?=
 =?utf-8?B?WVU2eXpPM0JrMGpoUTNuYWk0aDgzZEN3NHZwTUNaenJvWkJBcUFoZ2ZlTDhM?=
 =?utf-8?B?a0Ewb2IyZGs2V3hnM2xCcEs4VnB2cXVPUmtCQ1ZlSHpZN0dwUU4yV0h0Yko1?=
 =?utf-8?B?aHVkcld5VmNvMFV5STNuOGwzdDZ2dk9iYUY5aW1DcW9EZ1JqTEZ0R0FMemFN?=
 =?utf-8?B?L29Jc2RGRkFyVi9KRUkrS3BtdXc0eFlkblpKaE44M0RKTXZlK2k3MDdkQit3?=
 =?utf-8?B?d2ZrTjVZS1QxZTh0bWJDaE9aMnc4Rzg3eDI0QVAvV0NVV1Btc25DS0FVMWow?=
 =?utf-8?B?RWFzeW5ZRXNiNFFwbWNvSER5UExxNCtYRXpVNWZEamRwek5MRjRhR1ZOazJI?=
 =?utf-8?B?ckpsQVFkYitJalhOQXVSaWVWUGtzcWFXbEpXZ1pQRmVWRGRRYTVtSHJIdlpz?=
 =?utf-8?B?QUE0RmJrK283TytSZzQrTmllYjhudDNNWjZQQSt6T1pla2hCcHRLWlJTMzh1?=
 =?utf-8?B?QzRsWXJMOFVxYVJJRFhNMWFLWkZmUFVma24zb090eWVUZ1poQy91SVZGZDRv?=
 =?utf-8?B?bjNnUkZOVTljVmUyV3BPZHRFaGZCaVozQ1N5VmZrN0R6QzI3Nk1TZG05VmMv?=
 =?utf-8?B?VXZMQ3A2YTcybGFxajJnUUdJZndZTHg2RDZKcitMb29BK09FM0kzSmE5SGJs?=
 =?utf-8?B?UVJoeFlDM1hIb1dBRTRwNUJMem9STjY2cEZMY0x6NjBOL3ArdjRHdCs5bjNy?=
 =?utf-8?B?b3ljMlUvNlY3RFlJZGRNY1RXRXVObnAzcW1tNGwvdGx1NWNsSFJmNmo1RnNM?=
 =?utf-8?B?R1hINk9VQzJzc2M3TUFjZGN4bUFsdDJuQStNeTVwbWRPWHYvd2JOeXFWU3pL?=
 =?utf-8?B?V1NXU01yam5qS0lFTVBpdzhWVGFWdC9iWnZhbDNMelJoVlVnbWdnQUNpeEJJ?=
 =?utf-8?B?Vmx3M1JNbFFxeXhNMGlOSzFKRG1sbU9lQUxpZ1BBT1Rpa0loWGZqcVUrbU1j?=
 =?utf-8?B?KzUrU3VyWmNCQUJJVjQ0WEl6RElOWFpQTU44ZGowVmJsbjNZZ1pzYWNnbVJp?=
 =?utf-8?B?L3pCL3JYZUEwVG9BZVVMVmRPUm44QkFDSDhrVktDSTFSRjIyQ1hndz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586dc9d0-470d-4ea4-747a-08de93f9df4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:30:53.7449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4Vv7zrDPW1WXFvCCCh5bHN+iqmEbINnH7/jXowerGwLkqIhBLOZ8bozroGNrfWlnD9vOP2ZXAiyQwxhJl7ZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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



On 4/6/2026 2:52 AM, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.

Oh yeah, its not just the driver making assumptions, it is the hardware itself.
The Nvidia GPU architecture is little-endian (including MMU structures in VRAM).

> 
> Make this explicit in Kconfig.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
> 
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
>  drivers/gpu/nova-core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	depends on !CPU_BIG_ENDIAN

If we want to do this, I am Ok. Although I am also Ok with the potential
transitive Rust dependency in which case the only value of adding it in Kconfig
is documentation. But just a side note (not a rejection comment), Nouveau does
not do this, and no other GPU driver afaics either.

thanks,

-- 
Joel Fernandes

