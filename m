Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F6F46C4E
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 16:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D3510E277;
	Mon,  6 Apr 2026 16:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="zn80Vxgw";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9166A10E277
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 16:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFkNyVFmg7g+W0oqTS+lHT5i0e0jnO5zj+2KN/wJgSttSy93H4xiEo5yDMFFI6C/8J6bX4NVdJOxs9iHmivDMojE88W0BK7KSSP8E4rC7LhOJmWkJ5za1aBOBZeiUJEWz1dry8MptHMVDqIusmKfBpNMw/zzg9wxGWUapFHjp2csuqbRKlqZNu2lZuVcFbo8FCUAJ2uSHBWavb9NWF/PP1hwEzNn1/GjKT37wrvOULYguY5LdCnFmPtYLCxp0Buvxr8gMQwqR9m80CafBLc3aZ+CtxYoY2/E7jiidzgb+UkpeLqfyyuaEzXvKx5o4XmgKSXbYKY+04bSkbKgHw2YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpWhvXHrqwDq7XXjRrBaVMdTySed2e7y6ZxEIU0Q2OI=;
 b=DwOve9ifXrGDZ/HKU2LkifrSoHiUOTHRWu3ZQTA+NPYzVTEIe7s98z8ymjisBUzLnIshxYZb0uGbCM5KxoPBZTBCLXzP+4xoUqccceXzbXgjMOltHF82E+SB5xDE5rJd4gLXTeGcr3zWi2m0/qFmOB911N0FnJjpUCT2vNi69XNb+eyFbdz8rL7Cfi3uMJHCYfldHWHliyJ6XtnftSUfZSsD3QdahxfeXnWeoE/Ef92d3Jc63nYPWxeg6eXhKLC84radNbWkkXEGlRDf8TZvkANNr5fk16jqgwh5kpmj4ScGdMX0CmbtetMD3UcGEZBNu+Ev6YzCkwaM7cF2hb77AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpWhvXHrqwDq7XXjRrBaVMdTySed2e7y6ZxEIU0Q2OI=;
 b=zn80Vxgw7CLEShmmO7ljelIHYLFoNK2DEjV39w2PzkDsAB3ez27XsRMjOFkZhLDgIqGDz6b6+gWv45Mp2jAhzUIgCJrioTPkowg5FZXsjkRWono99hsezXnWEmzRcJsT6c6dgN3QyCI7aGohKn8qso7zMwOrrkFbxDp2izqWHas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5706.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 16:34:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 16:34:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 17:34:28 +0100
Message-Id: <DHM7U3F0463G.15D4YIQENI45D@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: require little endian
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
In-Reply-To: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a98144-b077-4ff3-be9b-08de93fa6018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: a7Cmap5uXVVU7A8dRz1e2zcLoGOyFPohHf+/1gBgB+3mIbd34NYRr1Phuq5JqU4SG0vUezhistX/phuWm/DkKHJSue8sXRH6dKT8bJJTIS40uDn0nPwb0LoCA1kkS0OnwZvmXFYeXQ65ZS+tid93sorEj5JWD7BQL85sxrI922rNqgQnypvPM8cxDbBt+JR3Qnlswy6swAoGg3mLXPj9ZvyB40+bcL3kKYBwGz9CH47Qth0gzHpL4+TdkCuVZlMcWATT2XNmwuDlwM3Vv3ldBlr4nfWRXQHYFPV6hmBHFSLzdh/zDXR2osjiwwyrquyQkaI80F11Ft2MjxiDT2wFukoPvLE58Jxt19oD19ssKY1bnmbz37HbabUYOESItWpHYfwP68ifh4UIN4p0uLKc0xIcjqjdHPO4hWvHPYtgzkBkZUhVkVyNnpMFwqmRdQO2vWiv6BMtRuG0qoevpjDgQVrYcm7S873pjX3BTSESG4WozBDksAibV6qG4B80ahfWlA7icK3goNFXLgXEArjKvT3MDW0NLLPMD/Gu9jdvZ3+RoIoPEkcYvXpDMV9k5EqwoqV+S0CbcTuXIYOUE1sHj7kpDvColv4JZiGc0nPt0rgZzCbkDJAS/9k2xYWHwKyTh5JDHY18+BMqZIBBgg9ztNV1wtxoRQRdGGjTHUq66ORy9ka8de8a9hU8Sbpwe9mZT/2d0STKeQQ6mr3+O7eWTE4Awxd2ztGD52dokBgxGYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dPWXNmQzlhOVluUG1ZZzBOcWl1djFhVjZoa1M1eVFsRE9EdkZtRGk0cmhT?=
 =?utf-8?B?QU9jMzJGT0ErbjYrdzVwbnVrd0pDYmJmVTEvNmIrd2Ezb0Yzd0xZYnp1dUxN?=
 =?utf-8?B?TmRFeVoxenFnejNQOTk1S1VYR21GWHRMWWZMUlJobUF6dWlMK2NlaGJiOUh5?=
 =?utf-8?B?cEZKcllwQ1VpNS9KYm5pSmhBaXRYbzM5VDVCelhlQjF2RUZXSE50YjNoMmdt?=
 =?utf-8?B?ZlNNaVJSMmhvZXBJc0M2RjZzUVo2cThLVnNRMCtJSjJjcTVRdWFGQTAvWlFI?=
 =?utf-8?B?NmFaZzM2dm1hemJYN1NWdHJka0pIWjF5ZHNIYWpsOG1QdTVzZ1MwWnFtenVk?=
 =?utf-8?B?TjFBZDRWVHBUR3hlcDRoQXZWQzBCZEJWbHJVaWpqS0FWNHFLTHllVzMzenFD?=
 =?utf-8?B?cjl4MnJZamE2aGZKQUM4Q1dVVE1CVkxqUVBrYzB2c3E2aEU5eFgrNUxDUkJT?=
 =?utf-8?B?SWt1UWlqRjBKUEpjN21HcFptdElCZURTV2ZMVjcwZ3FvZURXUzB6VlZ4V2dU?=
 =?utf-8?B?N1d5c3JyREROVUV0eklCYmFmcmZ1VlFIY1NiRzJndUxaMjlnTHU5RDZJdVhw?=
 =?utf-8?B?eXkyQ2lqZW9paWUxWlhIQjRiZ25ETldmZnJzWUhkVDhSbzNlRHJuOFJYNjdC?=
 =?utf-8?B?NG9CZDl2TWg1WFJzVjBLM0lnOTJyTVhOSWFRcWFXTE1GVHYrM0FUNzIya0xK?=
 =?utf-8?B?NU1FM29zZHdnZ2kzdWdwa1N2QTZ4bXVVZ2VSaWZYTENMTXphTlgrNEFCcmtG?=
 =?utf-8?B?OGl5dXJPNmZyU2NJODN3MERYQXl5eGNRK1dCdWhOcC81OEVTUTF4K2FMbkxJ?=
 =?utf-8?B?c1pKL3BOMnlXRnpkZFJyTGtCTWZqM1pyRE4xWjE3T0RuNlVHLzRTZ0MwVG92?=
 =?utf-8?B?TVRQODBLTWpLYUtEVi85ZWdGRFFVRWkyN3ppd05aTEJpQ3NabGFsSDA2Wm9q?=
 =?utf-8?B?MmZjVXhBd2p6UW5abU9IeW1HVlZOZkxMMVNqUW1kV3YxOUlBVW5kK1loWVJn?=
 =?utf-8?B?Snl3alNZWXhjWFlJVjAyWTJSdnc1WlQzUUNqMXN6ZnMwbFlQaW5JbDJrTlc4?=
 =?utf-8?B?Y1RxQjdiOUNwT1FSOUFHdXJCditObWFKQ2ZINW9tVTRENFU0cDc0aHZHbGcv?=
 =?utf-8?B?Vm84bEorMmtmNzZaNk5Xbm1hdTBaYzcvdHB4L2NTMUp1R2MzTCtpREVOYXpv?=
 =?utf-8?B?d21UQmhualRGSG1Gb3JJS0k2dzFJc0Jjd0RrWUNaaHQxR21Ob3V0SFNFSCtK?=
 =?utf-8?B?eG1VUWo1aWpkNy9DNzBIOHE0eFNlVSs1QVNDdFRlVEltbk9pOEFObTM5ZjJk?=
 =?utf-8?B?NEJXaDJwdU1mWlIrZ1NHK1ZwTUE2cmlOR0k1dFg4UzN1Mzg4SFdMbGZyYmIz?=
 =?utf-8?B?aDFZS3ArUC91M0NNYURUNDZPbml1NzNDOGduU25XZFpWbi9JMkJETmFUdzAw?=
 =?utf-8?B?SmhHVjR5VHBnWlBvenh5MFFJRXNvQ1pKbVN4bUVSbjlsVGVBcStDUDdIVlpi?=
 =?utf-8?B?UENxbHY3MkhiQldkaG5WaEhMTW53QUd5eTl0V01yejExVjh4anBYenZjU2VE?=
 =?utf-8?B?SmhRNjZ4ekdYczY1U0RjZzN2N2Y2TmtoTlZGei9TMVQxeFNHUDVWK0xjK25K?=
 =?utf-8?B?VjZCK20xL0tjenRBNW1EOUJsVEtvenJ3UFFBeTJ0SDh6TE1iNkNBVUwxc2g3?=
 =?utf-8?B?bFlxa0hXQk1BRGR4ZWM3ZmwyUTA1MXNUdHpHeTVZKytneTkydkxrVHR0MVlI?=
 =?utf-8?B?Ny8vVVIxbHE1OVZKVWx4dVYxSjBKcUtoY1ZSSEkwY1p4dElRUG9lckowR291?=
 =?utf-8?B?TjZxQlNLYlYydW5lNUpZVFhYb3BWYUhxYzNXUGc2ZTNuakRwRVJqYmxWYlR6?=
 =?utf-8?B?TW01QzdKU1A3eHRMM3IwSEprMys2VWxlZjZOaUJFbDYxMDFleUg1MW9EYTBH?=
 =?utf-8?B?SGtkaER3Q1ZIdFV0L2ZoRkdPclIwQXRQY0tnalRMRG5BS2FhQ2pQY2RQRFVK?=
 =?utf-8?B?QlJqbjM1MVFucEQxN1E3RkJHS0d2WkF0bXladVlSM1J6a2psYmVlR2VacUVx?=
 =?utf-8?B?ZmNEWDdhOVBJWm5BWjRuU2dYN04wd0hjZUxVbmo3cWxFdEY4ZlRvUUxIK2ky?=
 =?utf-8?B?UEJaMHdGQUZ0dVA3Qkp2OXY4Wm1uazFhK3Jhd0RHTVlXdERFMmlGRGFERW1V?=
 =?utf-8?B?dDQvaXBjd3E2dS9kWWI3YVF1WlpvR09Fa1hCZ29ZTHBxbEhBOUdHWVZXYU1Z?=
 =?utf-8?B?RUg2WVYrUWYvenhNLzVHY2Fldmd4dDIzWVJ5UVpiZm53cnFmajhvT25zM09Z?=
 =?utf-8?B?REs0a1N4UWtBTnZzOSsyN1d1cE54UCs4Z2F2WnhzaVlXT2E2V1AyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a98144-b077-4ff3-be9b-08de93fa6018
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:34:29.7643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZsodnVZz5mLwE1lC/GBiX2Wg+PDK6HPASGi9gOcxhWo5b8tb3y6RwbVgVmUWT5SQGKCpJ8l1ZwesqxfTvy2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5706
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

On Mon Apr 6, 2026 at 7:52 AM BST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
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

IBM is adding PowerPC support which will be the first BE architecture that =
RfL
is going to support. However, only 32-bit BE is going to be added soon, so
`depends on 64BIT` will prevent Nova from supporting that.

So I think it's good that we put it in.

Acked-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> ---
>  drivers/gpu/nova-core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfi=
g
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	depends on !CPU_BIG_ENDIAN
>  	select AUXILIARY_BUS
>  	select RUST_FW_LOADER_ABSTRACTIONS
>  	default n
>
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260406-fix-kconfig-3a059f622697
>
> Best regards,
> -- =20
> Eliot Courtney <ecourtney@nvidia.com>

