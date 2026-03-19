Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B21088E5C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 00:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F4B10E470;
	Thu, 19 Mar 2026 00:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqxiPcQU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AB610E432
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 00:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHvjvngR85Mn7wWWPKMQh4SyRNEiavw+4aYbskDmCzeTN47hLEXd0ylPSgla7JjJCVPI41AMsfIzxsMvTkbUv2VA5AEguw1AeyJqMrDnb+YdMk/J+exilx2oHVf+a3ULCRFdZgNBGf8W2jo26dAettmo9HHaFwxEjXQFX97T7lH79qjLTn+TnS08mqE1S3gvjor+Xdb/c3g24w0zrcSdDFm6aamRGMkXxcCGju7I5RhlYBrVTiV+NwZQ7/qJBaIxRkLgqZHFPNNm87sIWGwHoWjrhacZjQiATn16LPUaJT5/OAzx4N0kFETu8X4+Um+4XZgxS1pL8rh8IspPwPj16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18nv95un/nwj72lvdELV5Yom65Cf6QopJ1zD/0vByiE=;
 b=YK6e2wOAfp4oz05RwUKW6mILiVTcfVF/rtIWPB0tCmLsxDBKdd7Wz8cF77TMc4E8VmMJWzJPTIqPoyEKQpp0FxP6TH19n+qvK/j+vrZdFmOYG0hOj5/g9JPUdLVEhB25ujWevNwnz+f2LxyZMHFDGDrV/UiyY1KtVtDgyUJzEOveao83sGEv5sXtYydKiYQUXTbaysb89VtpYTZBJktGYWctcIyQt2QHWZVTZ3SGPfBWgreLQV5baGwZJJFDL43sEz1fVULhvdQvigG1aaSgWBUGeh8mGGOveMGKiVTZvRCF4o5fU/PxdQ9fpKXKWnXOQZcEhw/DWGCV/3ix9u+rHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18nv95un/nwj72lvdELV5Yom65Cf6QopJ1zD/0vByiE=;
 b=iqxiPcQU/ORbNItnQo1rqCAZGGBgM7DWC/ptHDuOjT1RCriePv4cZc/K7AoRJat72WacT2XFzwNhEvHJHWPStGRyfTnluhHLd1oVNX8egsZgW4rb2IWEklRl0xpFI7zYg1ag994ZjroT6NlYiiFOiI9Df48g97WZwQzjM+N2cl72W+pEUl2DluYEyqj8EQ8KtltF0DRWAv9npGAPeGMNXNhCRbNVlVVP+KTrFIlILoUIwV4HiTsUv2e2nqiud6rZXLOLcjOsAFYBYHAhZPkFOx93Ou/3pRBbvRgEjSlOrBB6q6ojfTBJdgaC4FuBI7zhB0NoivvxHGx7mbr26672Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 00:58:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 00:58:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 09:58:32 +0900
Message-Id: <DH6CNOO1WXMY.1DJR2VJKJLZJ4@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
 <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
In-Reply-To: <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 4584a94b-5fa6-4985-d57b-08de8552a61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XDfhMNIY6ErqtbygDIqGalILY7Z9Q2F85I4DOCuh8C55HzsPe9nhQaf5l2XTMuD4nfn+Hh5cpuuc0R9u+cCM7GHLueQXu2DB99d9j9iGALsura079dIYkY//wWVH6Tg1/D/3OrF1uvWNteiZIV/1UOPEBHBhC1ACxPJbxnIemGxcLPc4Wnmn8nQ15gg2Knh38XO0ew80ZfvBJ0HutPfe5tCd3ufCs/wBYBmdRyLMoZGJB260VphZpl8jgnrUCakHcKeIHjkOqBkWTTivKo3ugcdFjPXOgkIdYy/qHRIoFIWr78h0+aeEc0dKHBU4b5c7z2ki/wLSEQhNOEol+AwVqK+HGoT/kM2Bjgb2Xn+Q5wLzgYUzEAIQRATL7d9m926sLYyz6hY5pokrNCksrbtY0SLm8K+YFFa9RaM/q4YphYf4D+O5Es2je9PeBZXWqkpOYzbkf7KdtHwyMBofCTEAOmxrSZWCbh20li7zXCZrPIh13aa2yDMMZLZY0Y9xSJZ6jUQPCNXFledwQ4daSSzUOFFWJAv5s3GBTQg7GucCDdk8QGyTdyn91cZiUDmzqs5mmskABz5BH/5gBmtRoSkZCpCqqFwqrojIFSFti52HXQqbD5Ywcg33UEJeOgCIn5WijC9AEgH0JVZqgt0lD11LvkODyiCuvHvEyBURrxX1s37lTFMWl2oTyufP3atuwnXga09uE1GZLKA1MMhJP6GgXs6yZuBUJNtLClb/hOFbZZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRZbjJkdmZsTWNGNU1aWDJNTE5OVlRrQzdjLzJ5eVp5YlFITFNzZ1pIVE4x?=
 =?utf-8?B?MXh3cnNVMW44UlUzT0VGdUc3OW1zSE40cWtObnVzdDR2c0VscjIwck9PZlk0?=
 =?utf-8?B?eXl3UVd1ZW1iSzV1S1dxUFdjM2JVWXhyVERDL2xMZkFiVkpKTGd5bGQrK0JD?=
 =?utf-8?B?TnpWbVBiNkFDVEV1R3p3L0ZXZmNlbng1NHRrN0taUTRMMTM5WFV2OWxiZ05X?=
 =?utf-8?B?Y1hGK0g3MThyRURUcUlPd0tVMGV3N3Nuc0QxQm8wSGJ6eVo3SFFnVitQSUhB?=
 =?utf-8?B?OXc4WHB1V1BJVi9qeCt0MTlyL21BOFgwSlNnRlJjRFB3RkIxWGhjbE5pUVpZ?=
 =?utf-8?B?SUdtdndKVHBvZTBBMWNaa1NlSnpLc2JPNjhnRUZLMlJra0MzWWdkamZJdzAx?=
 =?utf-8?B?OHExVitzRHM0VkNXRFpTQUVvTWt4VUJnaDcwNVd6QmZLTTdjZnpqSGpnR1gv?=
 =?utf-8?B?UmpaV2pPaWRzMTVObTl0N3lpUGt2OVo0RzlRUmZwVGlPckdVc3oxUEtyZElU?=
 =?utf-8?B?a1Q2MndJazBLb0ZqdGZiYWZIdXRGQkJaSEc3ZEw2aUN0L01XdHNENFlNWmtt?=
 =?utf-8?B?bUZHalJPbm9kYUMwakdvd0FTRXh3WUp5ekNIVmEyZDFVZmhEbjlsSWxFa3Fm?=
 =?utf-8?B?ZktMaUpYRS84R0ZVZTc3SnRQRjE4eW9FaHZxZGtUQmFpNTlPWldhZUluUlU4?=
 =?utf-8?B?dHNYNXJXbDVURVdTdnJzdmpSNmFPcGlibElEeC8wTkh6bjhxNmhob0Z0a2d1?=
 =?utf-8?B?eE11dVhVR2lpSjNUUkM3bnQ5R1lNMmdLTGJCU0VnM2pCNlhhR1hCaVhQM0RE?=
 =?utf-8?B?WXZQME9rdy9xelptMTVKbTJHaUdXR0h4QkJLdzY5UG16Mzc1SnphUjBISVhz?=
 =?utf-8?B?cGpLRFMyNUVNT0libk16Zk9SWDBhUVY5dnptVm9ub294VlBrYlZ6STN0a2pm?=
 =?utf-8?B?MWlrdXJrTTdmY2pzdk0zQzFna0lFeUVaV2FKZTdYeFJCVXF2UGhuNHBkZktk?=
 =?utf-8?B?a1BKTmM4WU95bU9ORTdKdjE3R0hLVnltK2FqaEw4Tnp0ejlHdlQ4UkEzdTVV?=
 =?utf-8?B?VG15L3hDM2h3TFBNVkJUaFA4bml1MlZpeHJEZi9DeDNBaWZ1MkNaNHBPZ3BV?=
 =?utf-8?B?dHowRWlBT21Hb3haU2VENXNoeCtLRUpsTmdaMEZTbWl0eTVJNWZrcXloRUJs?=
 =?utf-8?B?SEIyUStXN2JnZmwvRlErUHJxYkkzaG13UzI1aUhMWHU3cFFmY3JKQkh6SGV6?=
 =?utf-8?B?VUdSZWlCRDd0U2JGUVBLamtiQlNhVWR6aUNvNG5EdzdUVDU5R2cyS25QV25S?=
 =?utf-8?B?SXBaVFVQbVRBV0xsS3Bka0I1S2RnN3lpcTV5TWhXUm85UWh6amVWc0wxK3JR?=
 =?utf-8?B?TDBzSzdEZ2F5MWpmVUQwOG9QM05mbzVrM2JEZmVEWFIwVHRXcjZCQko2dzFX?=
 =?utf-8?B?WmNPSUUwZENKSkVuVm5MTFRxaGhScUVhcFpVM05QMXlZeFdFcDZ2VzQrNmRM?=
 =?utf-8?B?MDh6TEtSbGNvWUpIclk3Yzd1cjAvSG12SUlwdXVHZkk5RTl4bDE4YW5GN3VC?=
 =?utf-8?B?b3NPTGhraEtHc1duaDNaMmMvYlBRUFhOV2hoZEEvRWJTenhjcmZpbFNPVEVw?=
 =?utf-8?B?QlNZdlFGTVFydHJoNUZ2emFpb0t6Z2FKUkZVcVZDSDZuSG5LZzFvay8zZUlo?=
 =?utf-8?B?TFB3VUt4am9La0NWTmpmMnk1VXZjYkNLcTU1YzJGSlZoV3BtT1c3bGErdTlY?=
 =?utf-8?B?VHhrandXV0dKS216YVVjcU1nQngyTmVlMmhqOHlrTXJNUjMzLzYvOUoxTkN5?=
 =?utf-8?B?RncwWUlKT3dGa0I1dzRicGYrdGY2MnBZaHF5V3hLa0JocUVvK09wbkVPMFZj?=
 =?utf-8?B?VFdJS2w3dWVRaWM1QVppdEJ1c254cE5waDVWZ2VHVlBRKy9waGxQSlpwdmhw?=
 =?utf-8?B?T2kyTWMvRmMwSkt3NmZzajU2TWdpalUxWFRCdmg3aElPMEtMUllCcUN4SmlF?=
 =?utf-8?B?a21zUS8xRHBqeGtWVGhPYlZQSzBjRjB1bC9tcm4rQ1FtL3hEOUsvaDJhaHVC?=
 =?utf-8?B?bEQvbWpVL3VUV1Rrc21PSFgwaGE1bDJCdHhJWHMva0pnNzhVRHU2YzMzOEtS?=
 =?utf-8?B?VmRNbWFzejVERCtjaThnYTg3QnIxckZ2QWx6bU5ySDFadjRzc0Y0bWRuMFJG?=
 =?utf-8?B?QjNlejdZWm5LMDQ3NEI2K1ZMVnJwaXdWTjJENEVWMWVBUWJuNWZYa0ZjM1ZD?=
 =?utf-8?B?akNUYlduRSt1NmlGVktpS2E1Tlord29wS3NzSGV0a2Y5MkVRVnFSd0VvcFRH?=
 =?utf-8?B?eGZGb3V5MFQwczdqbjFsaDRWRWxpekVtbElPREZocGdpbU1ZRTJLaXU3Skgz?=
 =?utf-8?Q?msbjxV3GhYEHM9ALQK8hrchnEIPc/GGbhdHMKj3JW6jwm?=
X-MS-Exchange-AntiSpam-MessageData-1: 5hw23i7L3bvQlQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4584a94b-5fa6-4985-d57b-08de8552a61f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 00:58:35.6097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R24OB0jjHdkbz65xBwXyihFyr73NK7+pBQhvl29viGEEi4WID70koWRZLj0FA1tC6+QTSzaYKKsPC5CSlowTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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

On Thu Mar 19, 2026 at 12:27 AM JST, Alexandre Courbot wrote:
> On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
> <snip>
>> +    /// Returns the DMA handle of the command queue's shared memory reg=
ion.
>> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
>> +        self.inner.lock().gsp_mem.0.dma_handle()
>> +    }
>
> Just noticed that we now need to lock to get the DMA handle. It's
> inconsequential in practice but a bit inelegant.
>
> Since the DMA handle never changes, and is only ever needed during
> initialization, I think I will just insert a patch before this one that
> adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
> to obtain the handle at construction time and can get rid of this
> method, which keeps the public API focused on message handling.
>
> No need to resend, I will apply this patch on top of mine and merge.

Yerp it's not ideal, but we only call this method in one location, once,
when creating the command queue. The locking in this series is very
basic and we probably want to improve it later to be more performant, so
I think it's simpler and better to just leave this as is for now.
