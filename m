Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655BCCD342F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 00:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A29510E064;
	Wed,  6 May 2026 00:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDpxAucA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA4E10E064
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 00:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcTkZwuOEqTdwWd4sTLL8hSLimEs6adAXKmGugjJ8Itr3felObxjrBtQP1PY6HU5uBBBGrSj4VP9cAkjyDKWAaHhul0FL8OupnTQDl7D8kKj9Xe8vo+GbyhSeKlIduhMtnABci6WK4DoQcWhsCtvGK+NuzcwyRpW4SMiShA+QcHWHlBkQo3/3EN0U5pDPptg0iSv+ZA0ZFxAcTw8uQYFtnVCEzeJgDWgUVVLEiRIZ0yDhMejTtKf4wbC46gOS/lUVi/ZnF2YkbWIqzKMvRGHDcbuGBupk/OIlcaDFa8tiWkfPq1snbWryKpz728Y7KtTdgJ2pMoRuluFpPM44d32TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fpUZeXll9NWKmQdtTCzEHQvZ7FwYb7pJ9Gm9DXFYi0=;
 b=CKMUbBRmpCgsmms7UTWbgtkTZw7rsxK5s3ulkB5ZL0HEuIAWtD02gIPSyt2n5zXzMrdVgXEtYTxyzyA43PwkVE8JcxiqZ/oHAnavvj3OioAshwqrp7accyROb0F7oQdCBgYKI0wDNmRIy4TDaAYQrdRe+m9EoPHIovGvFMyzk1zWwg8mQBYs7KLpw4alTs19OLvGg64j/JV9Ckh6B4fMy2UUXDp48BkLAVLC75/okq+ABAGtByD+g44k0CgR3bxIPvEafzuzJHZtxFZCAizo+bjJQ6RokIUw0HU0EIMrdyTHv4HTmQvU0vX2JRUxuGINiQRCEblB9enhv5Trdx0vLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fpUZeXll9NWKmQdtTCzEHQvZ7FwYb7pJ9Gm9DXFYi0=;
 b=fDpxAucAngX3REsyzSIRa5lTcoABkYO4o8jyAaS7eF2TAaU8lzIhihq5UMr2lquC6twhE8a2U5buDih/9fqjVhuk47aqe/25helaQJlAxZ65bsNSOJadY+FcsYKtEVXJX2GYVUfRD4jLZWIOKxAu62HWlCLmZqvtCslnQ7V3u04etlmVdNfWQTYO0yIai9iuS5eTqLmvezpdPyf72EpQrNUlvR55rIbFDr9Yn31fvPuFUfRptI9I425ayq3noUsZfahjM5Ja4yuisXgf4QZRNRDaVk3nHel/m7Gep5K9DxyItnlRWaS4HG1av9ylq+o0Go4K6LkLUr/tHWKMbY+5tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 00:47:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 00:47:02 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 09:46:55 +0900
Message-Id: <DIB6GXZLRZ9B.3KO488FTILJUV@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 01/22] gpu: nova-core: gsp: Return GspStaticInfo
 from boot()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-2-joelagnelf@nvidia.com>
 <DI8AZLB2610U.10MNQ0IPV6NSL@nvidia.com>
 <b0d54b3f-4708-433b-9180-afd6a54c6226@nvidia.com>
In-Reply-To: <b0d54b3f-4708-433b-9180-afd6a54c6226@nvidia.com>
X-ClientProxiedBy: OSAPR01CA0255.jpnprd01.prod.outlook.com
 (2603:1096:604:29::27) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 251708e7-657a-42ab-0729-08deab08fbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G29M+wjrqnDarzYC+nn+PcXRL0xFWdTytwBRQN52XGXGtKrfUgnqqfFVFG5OpGksSEBiw3qvjd7ljTS8ZqPIkp5kL/9VN/Q/ZzjfgKEnx/sdTSXJxsVm9/OPiYOAYzRlpdbTlpPhuF1FAIzPkyDJERgMaE/pXjUWnLyAMkJZir600iPUxt4p+QXXX42Vh8OR32I5yaO9RfohY5NVmmThuSiVbxEptoLVpuazoZA2FGxBKGs4mUx+0IwYQloImagXYBQ3ozqI1QGeyLXXgMThHkPKUx233ZKX3mGCVi1XumiX0fu78i6/mikkQYqofV8rCUElNfQNtRJbazjCk6ItnJGCPZq9t61nmBddc7zZ4kxVI3gdMmNvdqcdAt9Mw0/MXmg8ka8gxac88YiCMzm2C3VgnOzk5yJKW2zo/2uBJ2dQ8cTmEfDsNeVg83LvqjZ3o27l/3UlmOXvRxHeyLNTEHGauWgxdxMe0a+CEBREcq1Xw+LBc3X5h+ONCoUlyEfs/TqwYs+qKRpe/d+zqOCi/HPD9jOiDCxu15WwdiNDUCV8linX6cUlKy3apL8KWJM9Haj4W4tIwfb56qW+e6aq8fwxGwFPb+7b9/O/SJrp75JX5/B3Mr6vbOk+/6UlnRKot99dRlhjc/+ORtJtZc5+I3LmdWAG9TzIjZwcmnHPOZQM4umzmLcUzRmVHZRPO+gR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRCeXgxU1ZhYXR1bnl1eVhjbHVEV3ZqV2U1YkJLS1NUZ3JJeklSdlFMaEZz?=
 =?utf-8?B?anlyY1NvcW1HY3YxRGd2VEhsK2h1eWoxbnA4d0N5OHJ5T3h4MlZndTdNbDNN?=
 =?utf-8?B?eTBlcCtJVXc0Ky9tbXIvOWZlN2w0NVJSWEhzTFUyVDVOMUxFdWl3VVIxRUtF?=
 =?utf-8?B?TmlEeDhEUHBuT0F1TFZhSUlJcjJSOS84OGhQMENLcVdXb1pseStVL0hZQkQ1?=
 =?utf-8?B?dXVSZVBBeUdhTmdGc1BVUzBsUkRZRnpSTDdiYU8rRUo4ekQyYTdMSThNQVcr?=
 =?utf-8?B?enFxMy9aTjlmN3hkU1ZRVHpzYmVUdUZXZE1HY0pReGJsZ1ZFQmF5M1g5ak1M?=
 =?utf-8?B?cDlXMnYrc013WnhIeitqckJyMXVidmRYV1RNYlYvcmNmVk1NWWxUL1lWTkUz?=
 =?utf-8?B?b2dCVnZ4MXVBRGRvVVZnSEsvMDZnMTFKNThTMmk2dThrZlgxTDcrZGNoYnJv?=
 =?utf-8?B?Ti93YjYyTGZncnlOejFXUzlHUnBWRE5CREJhcmd6WE5tbzdSTHZIeGk2OGNt?=
 =?utf-8?B?bW1yc0ppOUd2dW1TK1c2aDJxUkZnYVB3c1grWStxS2NiODJ1eVlzZlRSWFR6?=
 =?utf-8?B?Um9tL2EvUmZWVkZETDE3TmM5L1lXM0Jpb3FibVdzVVc3S294bzBqVnIzRHgv?=
 =?utf-8?B?T2xEY0JrWEpNUW9GVUJ4R01sVjR2dXVGU3VqbGFVRU1ocjlSaGZPZVdIdGVM?=
 =?utf-8?B?cFBuQ3QrOWVNUFBLOHV6ZUswMVV5R3RaZ3VyME1oOUsrd3E5cHhnTWVxTFFU?=
 =?utf-8?B?a2lGbGpFakdzNDFMTmVMRTIrNjdDTjJyaURHaTlmR2hISWNHZ0RjRFYvcHNa?=
 =?utf-8?B?eGFGZzdVeXVNZE9qZTVTRmNpRjA4NnVBTDdJNjg3U01ENm1mQkl0amhUaGpa?=
 =?utf-8?B?ak1henVEazIvcWdEZG9QSFV0ZWlUZzZiK2pSb2JqV0QzOGFTeThROHZiM2xz?=
 =?utf-8?B?bWVlNzZDdXJMSEJxVUtNZ1dCTVBWY2dQTHFsU1psTDBCK1Bzb2liemRqZ3JT?=
 =?utf-8?B?NC9jTm1QNDlxRWdTc1l6KzBqY1FGbmQybU5DYzFJYW9HTWNpQXFDWFY1Sy9Z?=
 =?utf-8?B?TzdKVXh3ODFBV1pyRXZzNDlxYzBPbk5HZnNaNEkveW1PMS9UUkRXSGVoM0ZB?=
 =?utf-8?B?N2ljQXVwN1NSSEx2QkJnMXRBZE9jR2ZXLzlqa1BLbHQ2Y3A4eE9QRXk0akw3?=
 =?utf-8?B?Qnp1ZXoxdUdNNVRvaUJDRWUxdXRYQWZWVEpGalNBbWdQVkVORm16Z2QxRFNM?=
 =?utf-8?B?TEN1ZU1KNFBnSjYrM0VKdjB5TW9qTm5KL3NlVmliQ0pTVG9vQzNISEFDWGtk?=
 =?utf-8?B?aFBNWkp6RkVsWS9YWGRDdnpFR1BrSURTQ3JkYm93ZElFbVBWZnNYbnRseTEr?=
 =?utf-8?B?RkJ5WTRLaFNKcklmVklCOFhmK0E5VFhnRzJSUnBuOVFZdFhWQUE2MWZoM3Ux?=
 =?utf-8?B?SWtTdkxpdkM2UlB4RkFRNms3RmJVeW41dHpNRTNGTnd2WVpzeUljc3paMC85?=
 =?utf-8?B?MkdLMnN1M2VoU2xYL1F0WVZtcll0Mmw5dzlNSVBPak5TSXNWSzh0U2NtRkZG?=
 =?utf-8?B?dWp1bkx0cmQycmU1RTV1VXh5ckdCcERWYXBLVVJ1eXRTZ1hhVXNMWmhHb0Vj?=
 =?utf-8?B?eGxDM2tBYmc2YWI0ZkdzSTdNY1liWjYrNXBEbS9zVkdCMkxVTzRZZFJDTzdh?=
 =?utf-8?B?Wm1RK0djcGpraEVMTVJnd0N6ZzljVnU0djR3WDBqaUY5ay9DRWx3MDBWdjVF?=
 =?utf-8?B?QUhKVXlBRktickZCV0hpSmhGZm9uZS9FenRla0hHRnhLYnJYK0ErUG9tSjlj?=
 =?utf-8?B?NEpRaW5jYjRkc2c3Z1dwT3FPY1h3OUVEMGtVNThla09JTEFQVCs5a0dPUVhz?=
 =?utf-8?B?OS9DNk4zbGlZNTVidVVXY1FBdHZSMWFwTHNwZ1NDamxhTk9OdUhQWUNGNmU1?=
 =?utf-8?B?OUpSbXNXQlhWdllGLzI1WDM5SXpmZVYzVGlYNy9leUN6Y0RNb29lWWVxbVhK?=
 =?utf-8?B?MUlhMGVtMnloUUdadWZEa3JSTDVTbWJTa2ZGbzdMSGpVMll0azJDTVVwZ0g3?=
 =?utf-8?B?V2RlSk9wRVhpTE15YU5FUEowck1OejFKYS96MkRaYkpSSFN1Y3p0Mm1wNnBK?=
 =?utf-8?B?QnUvbDZVZm5vT3UvL2tBL3paY1FZRDBCVzB4OUYyUU9qQ1lib2NvdmV4Z3Ru?=
 =?utf-8?B?Wnl4U0E1Mk9MWG9GazBVZHIxYW1mODYrTElJdjZPdTR3RkN1Uks3UXpPbW5a?=
 =?utf-8?B?MGVOY1EwVUkrMkpHK0NvZnI2UmtZRmUrcE9CQmU0NTM2RW52bit5bEs2SjNm?=
 =?utf-8?B?OTZwdXdnUFowc3pSclFObHluSC9YR1RVYXA1S2Vpa0FLdU5MaFZ0Y00yN3Jk?=
 =?utf-8?Q?rBR5WxTRDMtu5dPke2RwwX9VmJzrU33WpwImmSy+gesM6?=
X-MS-Exchange-AntiSpam-MessageData-1: Maor19yZ2eqi+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251708e7-657a-42ab-0729-08deab08fbfa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 00:47:02.2686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H57BxjSDTe7RxTnpqhs01sJ7udqS6Wy/I2axOcJ36X7JhUa1HqHSwutGvZU9W0PYkjkT8B0FbXa4KcAtwlmtVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

On Wed May 6, 2026 at 3:25 AM JST, Joel Fernandes wrote:
>
>
> On 5/2/2026 11:41 AM, Alexandre Courbot wrote:
>> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>>> Refactor the GSP boot function to return GetGspStaticInfoReply.
>>>
>>> This enables access required for memory management initialization to:
>>> - bar1_pde_base: BAR1 page directory base.
>>> - bar2_pde_base: BAR2 page directory base.
>>> - usable memory regions in video memory.
>>>
>>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gpu.rs      |  8 ++++++--
>>>  drivers/gpu/nova-core/gsp/boot.rs | 12 ++++++++----
>>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.r=
s
>>> index 0f6fe9a1b955..f2a8915a1ff4 100644
>>> --- a/drivers/gpu/nova-core/gpu.rs
>>> +++ b/drivers/gpu/nova-core/gpu.rs
>>> @@ -21,7 +21,10 @@
>>>      },
>>>      fb::SysmemFlush,
>>>      gfw,
>>> -    gsp::Gsp,
>>> +    gsp::{
>>> +        commands::GetGspStaticInfoReply,
>>> +        Gsp, //
>>> +    },
>>>      regs,
>>>  };
>>> =20
>>> @@ -238,6 +241,7 @@ pub(crate) struct Gpu {
>>>      /// GSP runtime data. Temporarily an empty placeholder.
>>>      #[pin]
>>>      gsp: Gsp,
>>> +    gsp_static_info: GetGspStaticInfoReply,
>>=20
>> A short doccomment would be nice, but otherwise this looks good.
>
> I had added one before, but John suggested to drop it. I could add it bac=
k again
> if all agree on what we want to do. I am Ok with either though I'd lean m=
ore to
> the fact that its not necessary since it will basically read like the var=
iable.

Without is fine, the name/type is indeed explicit enough. I was worried
that Clippy would start complaining if we need to make this type public
once nova-drm calls into nova-core. But we can fix that if it actually
happens.
