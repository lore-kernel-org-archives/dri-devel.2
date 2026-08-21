Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BBC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 05:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2CF10E1ED;
	Fri, 21 Aug 2026 05:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/Y7YP5H";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA08210E1ED
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 05:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2NP5W68i0bFRNB7L8TICW98DxL9+6iPnKFz9OCH0/QXVELSgx7fwzSXgyHHcU8eqq2oW3lJgsB4EsKPDrOTpS0CKpPxBp0J752c7u5X52TjdpZ+z+t6gSDEnFLiKnq5LGGh9b2LbhEVtqp6kFunSUoj8aJ927deb9yCS6MQBxr9bxI80WtXoBLBrLR7CnRR8I7o894bAOu53OjdVemTLWhQpbGSJi0oNMPTRgXrMEi4gqomWb1LgRHnI7nTCbPUpGezTy9igPytpSMhVQbXx/7q8Q6NLKBgdt73JcnAYCrbbPpwwXGakcBrEWzit+gxpuZ+1pxYgxujxNcRvPZglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX1naT6CsFZw+jiYSPXYq5IRQOQ+RtuTdpx7Ec1bmec=;
 b=FrXBi7j5ACVGSroP+yHcFEJkifb+gO2CTR7PDnZBnG/EFKfgQJhb/h5eyZzTuRB3TwCemqmWYENLXr3JTR1GyANBmoW7Uz0YmmPmKbhmzBeTVHXZTmxtKKpZDB+xtjtSvOcyFjBPhT2mi9+EotXWbjCg1RsdhEql1RvgO92kWsmc5Ug/gETffgB17NXxy1tKUVu8tCPagcBSiCMjuQn+cpSxMAnW7M6RyOEzXW3AI3sy3qY5iLiYLkaG+nl1hQ1I3MLJ+exyaJNC8Yq8rD9Shf7/okDNvJu1G5kNc1V32osHZiPeq5aCSdra17NdAmYa+UDYJLwhhPeWXCAXJo3hFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX1naT6CsFZw+jiYSPXYq5IRQOQ+RtuTdpx7Ec1bmec=;
 b=R/Y7YP5HZCwWrX8B9ACpqcAnhOTWS0MkzzSqgiXLIYv6iC+kjhC50coAbtiwycu3GJiwFE3gnqCHmYRdZjG41p9gOa1fZ9gr0jq91fcDwb01ZrV3qy8KcHQ4rvLr7aC7Qsjl4XaCE4I2p6+w8L7xPHFAOWZR1VXEBbBs5SFKcneehIPk/wbE/hRiHZ9YYfaIHfOAox2+Un/s0gfjV84ookJV7z0jQp++rTHJivHyYXf8cMoXdvsS4VwoXF039CcvNqomc69uu/Ycf4a9CxjeyECOsP5zkXSa9mad1mDwzvORgAXpwLHWUOz2xlYw/eCKWKpvHQ5KH2eIog7gPzWrfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 21 Aug 2026 05:13:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 05:13:28 +0000
Date: Fri, 21 Aug 2026 15:13:24 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 6/7] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Message-ID: <aofd84GR1HA2H7xS@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-7-apopple@nvidia.com>
 <DKRHR24SW3XR.27EE53NSRT1D3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRHR24SW3XR.27EE53NSRT1D3@kernel.org>
X-ClientProxiedBy: SY5P282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bee09f-ac8d-432b-e4a1-08deff42efad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9g1FVnHy8E5fWVyeMqrXtC49cZgMv6ew7RbkBk1cPVKUeYDKzsh+IjylW7jdv99xYxXzHgIgv19jbX4OMQbih/NoqBzROcUGdEeIO112rVaCAS82ETZ3Dc9c6XwRMkNZB02RbIIEP3XCe6QzhXngX08RYL0SWhg6uSa8ABtTE+ULuzMN/iCYFKHTrun8p23dZbM4wpgpJBtDlt5B8WOeuWpzKW2527S86pQOPqIysJpPouXzHViEgF0dQZK6AEA2ISIIj8Q12654O+fNYMccza3JHRIoA+VXsIds0owz0UeGkKfyk+DJ7V5ALSTIyRGQZLRv+bWOr4LRc1C6QZ4EuhVKaQq/b9jxKT6KkRtVBve5yhVzSPWSsd4Vu1totV58NVgfP6gR1ntbTTpx5U15NK7jdTk071r1ZC1uCWzfKNgF3S07TWrMODVYjK0bJeqOrFOZWqM2eBDwmtUKhc7pprLvtTC509C+V9AaSsnOgAh6/gGXLAONB279L5SwW5HS3qUYlqjdz2A7gQ0iznzWlqhcXBKAHiolejYAv4y9gDtDBDG54tXNBYmCgf4g3304NR9tqXPHoW7fn//iGGR4C5DYgaz6W8YC7xu3cCAe+nhOwCHRovTDItXGTVwQ/9oMCD5EmSKHcfjYmVJLrEb1ud+mE+eToRqALzuVQ/s7DAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HoZOE2R+uEvAQIJgoyWDaFA9Y7SG/mlDZ0nfP9DLa1XB4YWYi/glr91v1jaP?=
 =?us-ascii?Q?zzIW9hTutOf53LZ37gfLYpA/hPn1SsPPGzSwL+83cbkKLElPKO+h5Hq9A4mG?=
 =?us-ascii?Q?yCtqx3kU9oyYQrJOa1PhTSDwuc8KBkTj6PjuHMYM40HHeyQ+3lgqfLO1uSgm?=
 =?us-ascii?Q?uWrVa/GqgqDK0uCxYyum4Su52yP3h29abUoDWl8oh6381s+e8//cdC2qOrok?=
 =?us-ascii?Q?VLzzAOsqynuf0qmFO+I8ca4vs1+Ctf6ean35WGxZzDpLMO6vYVxGDGjbEHUk?=
 =?us-ascii?Q?0G+34ag+/DkYy5+Og3wZLn54Pv4BksTnW1bxOCjXy9ipnrFxuWk2m+Y/wbsr?=
 =?us-ascii?Q?34AhRPOZOgHB1dBarXQXgY2ayVylDdkvSVoVsHsbRPZeFf3QWBft8H3LqB7K?=
 =?us-ascii?Q?c0KUbmEr4/bfpjjoZm2qrbqBig3NZitpAnLkC7fwRQnpFwkKPe7CH8LZTnAn?=
 =?us-ascii?Q?sGAHChrNfgHd1XQx2MBHrAYiUHfPBb+QZRNc+pqMKeVuIU6g1IAvRUIq2++O?=
 =?us-ascii?Q?hWNHKZJd0qxP2i9SDoZ6Uu68EVoC/SwwWeIJdx3xwii1wcW04ygACIo45icv?=
 =?us-ascii?Q?5enz9klaMc8ttlcxhJ+f5Yl7eBRr4T1S3+Y0avFdzX3BLgVAg6qPEeu2a1ZD?=
 =?us-ascii?Q?Fe9Z+jDlzJbqlBK1KFY8V64G050T/oqXOJ6+4QF3mk7xPUHYLhCybFul4KiQ?=
 =?us-ascii?Q?3a1HLFKbdwvQuPPSds311vajefB4sJ2TNViTdlDbVZESx6f9TD2sITtEahLl?=
 =?us-ascii?Q?0D0HM3R7Slwd6iJqVPsCFS9KzK1LkrD7AWwGbrMCYHtwv7nPbUyFNyfQDmpF?=
 =?us-ascii?Q?Qp5W794IFGpyVIJsY0x1AzW+gsQX86F8itbMzET5Mk5SL/uAre4K1dXExFKg?=
 =?us-ascii?Q?q7NNttRzh/0sAG1vK04Y4JW6hRZH/FmcPyjjhUau1kZlOHQdKXshr13QVkya?=
 =?us-ascii?Q?tR/VmJ21VNI35ViqVwIhnxgVk2gFSbmEdusLIpi6aIMYk2CpQ3Jn9NU5TpF7?=
 =?us-ascii?Q?1WPhC/QvXSB4cL8E+OnflOo8RJ35C7YXDoKrG2eEHaIFekWnKJHkzxobn97G?=
 =?us-ascii?Q?ACrrNbRjoTn1LOrCTpDdyYXE2Y1e9DBikK7To0WGxq8cEasIImPERcZtWFWg?=
 =?us-ascii?Q?JW4XJ4WRFlK1pDppfJnbw9LMd/BmSz5KugnCyzWQzK353emN7Q4Wi/OMsfaY?=
 =?us-ascii?Q?Wd0I46VOhRETTPoFXeFALnb0uqCWHEioGdLugbVFZH3xtXTj+XtIS3xrA1BA?=
 =?us-ascii?Q?uNplAQ5L/V3UUEUY0iYskQ94mB92wzV0yTTtSTbQQLoRdOlVx4mLj0xmzWQ4?=
 =?us-ascii?Q?a7bR2dlWvghuABlL8PtOIzRddAToGvYN2G+gUwgSEE7CvgdnUdOP9gU8dpVH?=
 =?us-ascii?Q?Fyfg1b1HDz0cw6BtPhyhjueF0mCvZJ4+WAaCx1wpNJYlGJqtiIMc9jyPYm13?=
 =?us-ascii?Q?qzcMKsNePW0mi5JdnJ1DsC5uoBsyMcu8jTHKA7PO7bSx/7YLcv4c8606tOrw?=
 =?us-ascii?Q?orivINRmsi1oilBJcpT1ZaCjE4GP7OvylVWEZ8o/p5DcBm3oAH77sqveEA1O?=
 =?us-ascii?Q?ra+4qya8dM5DBgvMSdr3DgdA1ZRz4WyaCktu/MLBkkghFJyvpG1i3pEUVlu2?=
 =?us-ascii?Q?9x0jkLENaoe4+Bkacod0qVCGly1WarwouO64/HIXTw3DXvPmcTsYc+qBSljO?=
 =?us-ascii?Q?hOXfTJVIlOJllj+UJD2kDFzyJSxlUiWgUrgR3SLrzT9cZjBcpPiF16Cjq8Mu?=
 =?us-ascii?Q?5bb3RtcVIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bee09f-ac8d-432b-e4a1-08deff42efad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 05:13:28.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InShA0FbZKOJLgOP1ftrHEh2Ku/CB+ZKXacadIVnNXeU176broeYh/Vpz8yzL/O6AIZC7YhZT72Tmn4dIXFvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

On 2026-08-18 at 06:11 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
> > Currently nova-drm reads the VRAM BAR size directly from the PCIe device
> > which requires trying to cast the parent device into a PCIe device. This
> > obviously requires the parent device to actually be a PCIe bus device.
> > Whilst that is true today it may not always be the case, and there
> > is no reason to make this assumption now that NovaCoreApi can hold a
> > reference to the bound PCIe device.
> >
> > So convert nova-drm to using nova-core to obtain the VRAM_BAR_SIZE
> > parameter.
> >
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> 
> > @@ -33,16 +30,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
> >  impl File {
> >      /// IOCTL: get_param: Query GPU / driver metadata.
> >      pub(crate) fn get_param(
> > -        dev: &NovaDevice<Registered>,
> > -        _reg_data: &DrmRegData<'_>,
> > +        _dev: &NovaDevice<Registered>,
> > +        reg_data: &DrmRegData<'_>,
> >          getparam: &mut uapi::drm_nova_getparam,
> >          _file: &drm::File<File>,
> >      ) -> Result<u32> {
> > -        let adev: &auxiliary::Device<Bound> = dev.as_ref();
> > -        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
> > -
> >          let value = match getparam.param as u32 {
> > -            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
> > +            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.bar1_size()?,
> >              _ => return Err(EINVAL),
> >          };
> 
> That's much cleaner, thanks for adding this patch!

No problem! Agree it's much nicer.

> Once this landed we can remove the
> 
> 	impl<Ctx: device::DeviceContext> TryFrom<&device::Device<Ctx>> for &Device<Ctx>
> 
> impl in rust/kernel/pci.rs. (I think platform should have the same impl to get
> rid of independently.)
> 
> If your are interested, feel free to send a follow-up patch (or include it in
> this series).

Happy to do either. Seems like it might be easiest just to add it to this
series so will add it to v5.
