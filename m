Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFFBC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AC110E1E0;
	Tue, 30 Jun 2026 11:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YH0/Ds8+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB24210E1E0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPFZPmpLQ2WqssHNcpwvtla0RlZkFkiEN7Tg8fPHdYiuFYDhxXcoQ/lgPsfWZ2A5IOUQxed/rqKJWBDItYQA+pkWRKQQT3N60qw6w72kiRaEomuDR6Hr5e8TUdXoLonSalj5ydAe+CQoH+dMqUZGCiRSxpZQl6KivcXwkfKYWhnwcidm7a7iJO9l0EBygOtAtrSiezYgi581ZnQvgd/8DTYKLNrn5wY4gckIHP/9opz3Wka7J9dorj3X8cn/kUNRT1Sa5iH5H5Jlpc3UV2EcRitixZ4pARubaSQ8AdB7KNo+7086U/57M+XlVypUAxYqZkfp5yC2npJWaHD0B+SWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpMTwROdnaP05o9QRj4tTSFaSWQTQw7gqJx2d3iac78=;
 b=KU+Y/W4P6h2Yuv2Y/xtZ9W+ULqwXt0OOFcr86Op76R4M3a6l2ogKdNaCzhWqMOazWiMVBcZ7uPdIewZK2VvePRGUffUZYKoj8BxcxYSGdjBMOjEP1Iv6qE2ws/9nlYk5a0CXVQT0N067QGwa7L7riRXnKNs0dDYS99cNR9NKUqViNfZCHgjDarkW6yC1Rg8EvkbS0Xfvpu5dz81YbXgxxCtDQjWT8qkiIxmxu/Fljg9BsgwTLmHuVfxNpIm2cc/vsq4DB0klQmPlU9Ca5Q2ABNidoCDXI8PFg5+MVLuOmgcrRcXNKWH2FnvY+V2poxTXAKHZWSgZIF65hOB0goon+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpMTwROdnaP05o9QRj4tTSFaSWQTQw7gqJx2d3iac78=;
 b=YH0/Ds8+JclmAaL0gvNSX2fNJzc3SRsRfj4rZdZ4aFNVAJyzCDX2X+GskEPmrLSUAd2cC/FdYyeejjcyK20CABtQC1ik9+Xuym3riWmLrgvS1VIG7FES1a4A+atulPT65njAGubFvHBQE1p3HUoUvXTdj7mekXjdyB22ILzrUZaB9kttV56vYmjNjWXERHqhA/BMHX12mGehzVtvFU4WjEul0Kw/yOVgw+rjpLcLTqAuKAbQ1rSlX0o7D9lBuyZ6byY/srK32Kl6dF2+6KC3R01JD9pPCFW6/s7Pdw0Dn3qmcYSkgRejY/uZ9bO0VKiKa9Totyee44NGCp0Rosk9pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:39:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 11:39:20 +0000
Date: Tue, 30 Jun 2026 08:39:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org, Alistair Popple <apopple@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <20260630113919.GC7481@nvidia.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
X-ClientProxiedBy: MN0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:52c::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 145d427a-1e19-426b-1172-08ded69c3975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Y/xivIhjPJblBm3u77bAQhVD7RWGouI52x6/UvkhKGUOPWyqAbVj/2pGNgYLH/m4bma+q9+hPaO6phLI9sHSjJPVwIXOx+G2O6Frg9y2XFn5VyFriNT+iqHt1rc/hfNedLod/PfajuDFPtpq738X7EdDU/alOgqEOmjmiLRaXD2qbzgOa4xn2VzP2TIWtyL0bXFYkzEW51NMjb5BA/ZcEmi9ixEDWUZj/CfczcEIqlNlLLLM7b2vJaBmECRka8Xzivb44UBo9KLOQqvZMT6agsmt0Dm7QFOcDo0SEpqFJzI+II2gmv/mJypS9CSxfFgOIM8U7LFEubF+5eDJpvFAvUxsuGK9+XqjVD28cGnQGXeclhVIIAtCbW0U3amvEaXLGiBWBwplI6RNzhLY48Wypg8a4b+NGxBt24bUvR70gAE5UU70iOoOs0cE7ed0FNaHxvu7xentVIm8LPLuKdEt/eXA1FdII35Kt+bxdvvLbmb+i5Jhm5tCqD6WM2kcL8Sdw7wPg/fMpV6eo7lK7nRx1aoGeoiiMinIg4F30UM2R3M+uFiCczvZSDmAYtnLX/H1t9qvSNiFs2K7BXujd+d1BIH7/lrwGBMnn/H05SGuN6vcRVMeh2EHS/NRqwP9k6V2Vs3+Nx56cUnrH5zPoW2LNH9uqxqd92WdKN/YowdSgGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1iVb6i+31m0FOSUAVyUXnf3s8HCxTqi3qv70aWxm37njE4rnOuirz+bRoH3?=
 =?us-ascii?Q?JOWWfc5y2waEgeF65VNoQgPeX8811abvvqdjzl+3G73WRZqJzI/i9UrQJ2k7?=
 =?us-ascii?Q?aRtEm9cW4H+ug401KGU/MxnGiCsKKZyyg2Oe79s1lsy6s2aK4r23jofnC9DA?=
 =?us-ascii?Q?vDrUIg5YPvwvYGq2I4oeRnnqnvuVpmV24d97C86p+JpXi46r4z0/jfI/pyQa?=
 =?us-ascii?Q?Qi33JJSfCbWVt9ou3ZX89etAsCZ2C9IZbiZgLDPyHGNjNCyNiU0+oF/Cr5ay?=
 =?us-ascii?Q?X1XSGTcOnXaaEEkpBwxR+yBxQhVF7kh5I6siOwtc9i2KsZkoGgpFw56GsorN?=
 =?us-ascii?Q?sSL2tjQxLbDJQ14uqV7g0M4mUzXKgwlX9oy3EFtL+AD4XLq+lg85B/O/kyOg?=
 =?us-ascii?Q?yloWwHK1IOfVj4jn/u+8DRF3+hUPCimKXHK0Qwjidgh3O2m8ui9IPSvc0YP8?=
 =?us-ascii?Q?k1chBJ6UEmoRXXThVNslICzw3qE6qELs0q8Wp3LBYgu7MWkA8WY+EHDG45sn?=
 =?us-ascii?Q?pTkpohq0OEvm97pDHDEwyyQ2GMbNsLDrdSqWUJWix0tEKyn9jdv287evipUL?=
 =?us-ascii?Q?4zM/Lpp7Rq5HFzCDPK3HUw+tZWqo78J44bpeHMJVpVOrtaMz94g/+ngTVR1L?=
 =?us-ascii?Q?BLdqHPFSjBycJ3Hp9c2mw64GcYyVBw9z3s2Q1Gqr69dfO1N6tk9+G6DDuDkq?=
 =?us-ascii?Q?oAKKfa5vPh6Uby381bECPiLQWswaIZMHwQDiDCPRO0b6J0U7d4hIzUC6nrRG?=
 =?us-ascii?Q?8CIi174azNQ5Rph8Xya6B7vxGWQdNy6CBKtdvQs6a/Aj/AyIDvhhk7DORo0P?=
 =?us-ascii?Q?ta8q9u6PbGY4fkyesKu6D33HSi+sTkNCv/QZ2FyPsHGzbCOgHNoX/q39ZQVq?=
 =?us-ascii?Q?sINi4QYd2MHEXS5ferOo1t88y9lD8SmklhQuae/SAOkAyaC0sy6kNXSO30tL?=
 =?us-ascii?Q?Lna9448DrCiL8feVtNcTkzQnYdHW4jpFQVabsR/+tyD7HkjIeZedZiQXM01h?=
 =?us-ascii?Q?ZE/v1Fhr7ERBbA/rL9yX8FcZZezDXXSpKNZcodPLN1x9OR8Wa2iTfxVaGy2Y?=
 =?us-ascii?Q?VctJ9wCxODJueBU2OSXwQQ8jM2+heSW90XrZWDCBChqgbQqvbbfUXjMT6ojP?=
 =?us-ascii?Q?52flGKphJBXIhRVosXaaENMTAhIQHcgKWdSNOV2f7rQJeTjJnCMxBRZb7CUz?=
 =?us-ascii?Q?hMLkaVzr7pSCLD9S+QbLQUvh5j54zLg5wrpnjfL/2NgDQhtoXxrHSpGLEBY0?=
 =?us-ascii?Q?t6Az9eEltbc0rgEmYG1Bo8CQ6YWEc/ldx82VoM0mVoLeT1R5+ptD5AezH4Yq?=
 =?us-ascii?Q?Xfv7qR3dgBv+LWfdKaT/L//+tD2CzH+ycZzSS8/CrKX6GaCKyh6YlgI7i32g?=
 =?us-ascii?Q?y/mXLpytFA5HjcMsATDwM/QqTT1xglNGxdTHZGT2NwAj8W+dWZ/2ahj+lVWd?=
 =?us-ascii?Q?w17Fvcckgcit8zL99abHDCsPnd33Wk2a+oV/b5SN+JE1UUMqoZxYmSqDIlWO?=
 =?us-ascii?Q?N1ey25htB64eg8oJRzmjcB3901rN+EiZ+OyTK/9mgeAPjF3L4ddBBv41ajyE?=
 =?us-ascii?Q?ixAFxcbCUC5vNYi4Rw9a7XQCxxVaCIb7+5U1STTrXPMKMBaXHAwtbLwpzgt+?=
 =?us-ascii?Q?DGiotcijA/+tBnx9WJAPY/cb4KALuaAKt6LDI0rszBI308gdTpWKRGSDxjvT?=
 =?us-ascii?Q?wfCaiygEqR9x70JFuAs8lPa3mPasjLhGcRShqsaM7dbYFg7H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d427a-1e19-426b-1172-08ded69c3975
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:39:20.3029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPpuWX3zDdC/KBv/AUlFBtPc4zEnbxo/BKlO6ugsmBhx5wps1eLrunwZ251q2q7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
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

On Tue, Jun 30, 2026 at 07:39:44PM +1000, Dave Airlie wrote:
> I've been bringing up nouveau on NVIDIA Spark GB10 and fallen down a
> hole of why is the GPU writing to pages I've released back to the CPU
> page allocator. I've wasted a lot of time on GPU L2 cache and explicit
> handling for it, which might be needed but hasn't solved my problem.
> I've also invalidated and flushed the GPU TLB excessively.
>
> Today I finally hit up iommu.strict=1 makes things a lot happier,
> non-strict IOMMU seems to allow a race between dma_unmap_page and
> free_page where the unmap goes into the IOMMU flush queue, where the
> actual unmap are delayed until something triggers a flush later, and
> the ATS translations stay alive past when they should, and after the
> page has been allocated by some subsequent user.

It is a driver/device bug if it continues to DMA to memory after
dma_unmap is called. Strict mode is intended to increase security
against malicious devices and to aid debugging buggy drivers, it must
not be relied upon to have any functional effect on a correct driver.

This is not an API issue or an impedence mismatch, you have to follow
the DMA API contract when using the DMA API - meaning before unmap is
called the device is not doing DMA any more. It is a purely a
driver/device bug that the device is not quieted prior to unmapping.

You cannot fix this with any of your proposed hacks, the driver must
have control over the device and it must know when the device is done
DMA. Presumably there is a missing flush or fence that is allowing the
GPU to continue to DMA even after the OS thinks it has told it to
stop. There are many unique things about the coherent GPUs, I would
not be surprised if the driver needs some additional fencing
operations to clear the fabric beyond simple cache invalidation, but I
don't know.

Normally strict would convert these bugs from quiet corruptions into
noisy IOMMU logging, however in this case the GPU is using ATS and the
IOMMU does not log non-present ATS responses. Instead the GPU's
internal attempt to DMA will fail and the GPU will do whatever it does
to propogate that failure. Probably the driver has not noticed the
fall out, or it ignored it.

Jason
