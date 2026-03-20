Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD1A1098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3986E10EA9F;
	Fri, 20 Mar 2026 14:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hyJZuRFm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4500E10E16D;
 Fri, 20 Mar 2026 14:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQoCo1V2Lpsb2Aa+Ua7NfvJ5YGtUam5tekznzr7VA6mmUDXYPNkS7oTkAemlKqc04kjw8uZRy3aoh9j24oUPKlryYgsRbguF02fHE2wX0fbYlHe91TnfOnAvq4NiVbPJX75HXk3IrFLxue4Qe0JDS4MvXYhIaGil8u7VZcWBN/M95OOnle/BvbX5cW72u59Uv+ubWujheFCBBKkbVN6KKTpwzpHwTFQUgV5hbPOBQN272qzjsmYfSHpbHaS1XQqYY7swNA2vFUXn4zjMaQDy6JiaUrPo5KclNhsZI0WGaqgXm/m+o/JYQ+LBX9Q+uyUaVth+m9WSBh5qsmCMxva2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALWvgJnuSQKwf5SHpJWJPqgs+L5OuSKjOmMj3EXsVWM=;
 b=bcmgznfLPCucfNSFZp9UtxwovQgb3VkwO1gIb16e0420bYhDvxJxYTHMt9XVGkqYmMfecuzGVUVmQe4APHvzmmZ6xtPFvuGc9FdAGX02OGmRm8IqBUyZWEKfKw1W/4/CcX3jgDD/zwqvH4GyXIWQam9GfSPhd5+E6Oq6tM6NUy7ZihJy4i2qgnlER38BGzST2XuFhK5CaYGrmp4WZB5jCgs7S4jrubnqttLA03Jbt2BoTeWrfsF5Shk96DwWR24aMXM0AZ/zy//W5fKRjIcBpszZCy8Phokg+L80qX3OI86JWBdVvXHfMnxekN4/VLPBjlfu8l1bfi/xSxaYXs4FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALWvgJnuSQKwf5SHpJWJPqgs+L5OuSKjOmMj3EXsVWM=;
 b=hyJZuRFmmTPVyeHs6pUp0Ji+MzLohVflxgRT1CiN4Nxi9ZzlbWqsw8BjgE+P+A4SzpEFFPCGQYj6d04VDhqCJKZ4Nbc/iql3TD/bHUZ1YJKHcovprLrAqIeP8YYUqY9TIo0va22ezmj+LDAk0cFH9qOk8RhUep515myCWtTcNDmKRvy/4OGATKRIjBvIzrHjO2uxDAoRxaIfgk2bzz9nBA3tD3y1OJXWD/EgJckRk8rzyzPXzZulAqZabzCgWlAngZX7plkpFhNzedliFWoObtN2k1Wpy86ujN51u1oZmXwd1DreWT6Mre/s/d+1kT9tcllYRXbZbK0um/oXzX52pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 20 Mar
 2026 14:35:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:35:27 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:35:23 +0900
Message-Id: <DH7ONNEQI7T1.1XP5RO1BWGQ0T@nvidia.com>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] rust: dma: add zeroed constructor to `Coherent`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-4-dakr@kernel.org>
In-Reply-To: <20260303162314.94363-4-dakr@kernel.org>
X-ClientProxiedBy: OS0P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9c::22) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 328aa5c9-421d-4f79-f663-08de868dedd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MpuwHtLNIO8zSzLE9Ds5S5D4lYvHx4MpC9wqN0GTILHh0Z/g8OvSzjreT1pY5zFUYQjdzoTfD4bzfste1yfBMxfg5dio+H+0QxqLvJ/IEW+r4h8gHM3Nha/swzkrhc/B6EHBSFlVl0/1xmMYU4Q1nxcNXRkXMwgxh+X1g5n38L699T0nru+QPGNHl60LxMsJYjSEo9kF6d3BJI8YrIbhYfVEKiRAbYAq0SlRQCOL7SI9ZvS4ooKd+aba9Rmi59m5NZSqgoKPDgEFGzxKEESdXYSHY9K0QnuyUDlGt5HYH87vMKMZJKdxFxB4865uTdfI1ZyTUKtPgNAFN8dcqXvKtN6ONwxArauJVP91pRYirRtG6TxMSpUO2JryPy8QxyY+Y4K1t/mMJC5ccseJ2YquBlEYHRHW2OqKqVRsyTNBnI2aQWdeDem9KJ8m1Ydi882uxtO0GtLz/IC3PXjiD/QiLlGxe/OZAJ0NaFEazkH7QdCAPcyAc0ZORY+OxjL4DVDQQ+Se3eokTyA7J8xYE/T2tXWGkkdWH9WPLjb6fmetjKxdeAStjyOWYePKvGs2Jrg59WuuxUdu1fulY7LwiJorSARKVAtrsaMtXV5ZNBGPranqzdg7KwHU5Zo5/RevTFXomyw3EFCxHsYdN/4oL0cGKZbxYSzc0OuUhFZbUSZIpyECx8wh0AR/N3mTcfpX6n27wJhC/bO5mHNDtW71mI3YsYkwBDsuYrdwc8IVOQJBEvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1A4UTFtdjU3MmlVWDR1T2xZcDJYeXZuOTVsR3dkNm4wN1gvVGx3Y3pvd2lF?=
 =?utf-8?B?UEMwaEZtbFlqV293NGlja0pUdnNJdVd3Tnp6SSszaXNPVFhqajZmcjNYUTVi?=
 =?utf-8?B?OHVoQjhHNHhpY0NRV3k3NnQyUmVzNm9hNUM3TFIxOHZmd3ZYTFdtQkd1aVRm?=
 =?utf-8?B?bit1ZXBQaWdoYUdrejZkVDg1WTAvSlBhNUtYQ3NwaHBGVDNTaXBGK2x0UGRn?=
 =?utf-8?B?Smc0Z3J2dXJZTmFFbGRncHBkMDB5N0tCRG1rWDdiai9rNTNrVS9scm9oK3BC?=
 =?utf-8?B?MFhFZWVqVVFsNmxUK3dNZUJkamdCWGFPK2dDUXRXMThzaU1HY0dER093RkN1?=
 =?utf-8?B?b0h1a3RuUWVuMitEa0RSbzdIQUNETnUwdG1uSFc5UUpXNy91MXB6cjZwb1VX?=
 =?utf-8?B?TXZXOXdaVFNLejRZanlodDdHMDV2Ulo0Nk15SWR2MFk0UGMzVnBIWmxOdVhU?=
 =?utf-8?B?RkdWRG8vQ0xSNUtWWS83T2VTKzFnWHRtbHNNZ1RIcUZjS3JaanA2cXZ2RmtK?=
 =?utf-8?B?NzJXd1hVc0JIU0VKK2xoMDg3WVRNa3pCaThLRExFZkw5M3k5R1BldXFPbFdZ?=
 =?utf-8?B?U1NsZTZaR0ZlRVhUanZxRXBxTkFXaVlxcU5vUTlRTWF5bW9NN1RYMjNDeFVl?=
 =?utf-8?B?K25FMnFPMzNrNXhtTFg0ajZwOHh6RHRHN1dNRzVHMGVvWHQ1SXNmaWNSWFl3?=
 =?utf-8?B?amtaVU1jR3lKYkpiVEtkclFtTkZ1NHlhNWVmWXMyZDdJeFZxY2F3QlFqTnBF?=
 =?utf-8?B?eWdoalA0WWVEaHhFSTVhZWVLQVo4ckxFdk5uOVd2ekJwa2Y1L1NQeXVSVDc2?=
 =?utf-8?B?RmFWeFp4VjRUNWR4MkJsSG9kaWhUZ2syZVBEWW9vOTJkU2dMQ1ZPQlVNNGZM?=
 =?utf-8?B?Y29NWGJDWksyck1VY2NjQTRqZVZoajd0RW95dEExS3l5YWY2WDJRMmNjeVQx?=
 =?utf-8?B?QXRtbitmeXJ3NmNEQkdKQXVCaTZuYUZRcTMrWW1QL01wWnlXaG5aeWZxQUVU?=
 =?utf-8?B?RFRWekNPREhXeXZPaDJVRDhQZ3k2bjZ4b05jclN5M3J3OVhNUVJEZFYvamZK?=
 =?utf-8?B?L2NqTXNqbnNFL29Da3pZdjhDTkhQdkc1aHlFcnFpRENROWhzWnpTa1VXVllE?=
 =?utf-8?B?eE0wWUo2NFVPcWRaNE8yNFlxeUQxQmF4bkRtcWRUOWkyd1RYZzBDeTZ6Nktm?=
 =?utf-8?B?eERwU0wvbmdXcmROV25kWUZJNmhvRnlyRjVremptelEvbEs0dDAwQWU3cnNH?=
 =?utf-8?B?dmVSQTdoK05QZ09NT2dPUjBNV1hCOVBFM1llamVKUGFkWlNVT1dYWmxmMUVa?=
 =?utf-8?B?d1hZRzBVUWVUa2xTcElDMEI0UmxxR3BJb3IzSWtTSDRsNGdSSFdaOEpoVW1P?=
 =?utf-8?B?NTFtRWVCRy9tWVhnOTVYR1R2WnF5b0l4TjBWSFFoOVFtTFNaMzhjRS9DR29l?=
 =?utf-8?B?c2MxOURmOWpVVFNqUDN3VHVnTWd3RXY5dmlRME5GTy9ZQkg1Y2VrSG0vUUMx?=
 =?utf-8?B?RE95Yk9KUWY4RU1hUnNETkFlUVUvdHZCTDZENkNzZHh5a3JzcmZvTjZ1bUQv?=
 =?utf-8?B?WDFnWUh5dldGRVZBNzVkWEdGQTMrZnI3YndHY3EzOWJGVGpYd05FWXM4RS81?=
 =?utf-8?B?SmszeGdPVzJsYzNUVDZXM3dBQUlWYW9Qd1p5a1hycjg5VG0wUG9FOWV3SUxa?=
 =?utf-8?B?NWRlZTRMMW91RkJXMDZlZHExRHlvcC9tTjNKbVM3cUVCeXptTDk1MG5pbDY1?=
 =?utf-8?B?MVNscktlYVlXNkFuekVrVEhDVGlvWW5vTzRYbFh3TWowZkJSdXRuQmZ3cGd3?=
 =?utf-8?B?ODFHaXhKM0gvak5xdEliMnZqaTBENGl2c2dkRlNKbVIvbk9QaE1HQUNqN2gr?=
 =?utf-8?B?YVNVUk4reGNLYi96Ulh5aGJuU3phRVovRFRVeEJXZG5YMHcrN0ViSlBxR2VS?=
 =?utf-8?B?TG04MGZOOUE2S21GWVZ2ODFBRWZhSW41MUM5a0xkVkJydDZzcExTbXRLWnkx?=
 =?utf-8?B?MzBxNjlvY3RUTHBBUkRqNS9mQlBKbitUdkRNclRkUXk3bE1UcTVuMW9lYVp1?=
 =?utf-8?B?d2I1WGR2S0F0NE5WVC9zSWVYcitQekkybkt1VTJMaDJoYnpxend5R3VFS29J?=
 =?utf-8?B?TnpvaDJrc3NKWHNzUHJDRXIrV29wMW9IbEVOdXZYS3QwcHVldHZtNndTWUpQ?=
 =?utf-8?B?VGdsTzkwNlBMdjlCK2xFRXNWMk5NZmRpdU1NV0NsSXZjR2V0cXFkaHlXQTdy?=
 =?utf-8?B?NVpDRnYvazc5MWdlbVRTSnpDZWZ5cmJXUnVCTk5NRGdtM3ptRzNmSHREYnZK?=
 =?utf-8?B?cXBPUEZ3bTBHa3pyZTQ1L21OUWZERm9BT21KcGhIWFBXSUZaL0lsMlpjNFBl?=
 =?utf-8?Q?t/hQNGO+JC+L9QVUA6MVAIyev08SC3RSBG9evT6XXNx89?=
X-MS-Exchange-AntiSpam-MessageData-1: tx9GMqQ1nqTLuA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328aa5c9-421d-4f79-f663-08de868dedd1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:35:27.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boWuRGcDgwqvCjJ0ITMgzEgOPuiK3D/bfY76x/ZWvZ3FxhLIN4SqAQIqBtFtN7APGK39Y4vd329ulooDRLq6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
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

On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
<snip>
> @@ -572,6 +598,41 @@ fn alloc_slice_with_attrs(
>              dma_attrs,
>          })
>      }
> +
> +    /// Allocates a zeroed region of type `T` of coherent memory.
> +    ///
> +    /// Unlike `Coherent::<[T; N]>::zeroed_with_attrs`, `Coherent::<T>::=
zeored_slices` support

s/zeored_slices/zeroed_slices

Otherwise,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

