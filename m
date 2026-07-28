Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E46FC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA31210E7E8;
	Tue, 28 Jul 2026 07:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="siMvBcoo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76B010E7E8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOQHcDgDAeMsZiy17hL5ubqEJGiuhepxouawVdv5Ai9p7i1tzfZhvhVJCa9anFXKFxL24/o8iIbzUC+cu6SDzo75FARnn/WRs5myNRlVl0A8NFPPt563xjgRD20efIZoe12ROtSgiL7PS/Igdm0j7aEi5T49ORL6FLJokJpWW3Vhe8EnKlS+wibzggvyBrLe/TBKQSBszFd4fsCGVqcyI/cbU4KRe5+g0FwHEx/Q8+RjtWehJ9AJYBdQcSPoBApRWSXATd8uqRyWyShYM6X5FCmBn48NiBTjpbQ/hHSEi22oGZHuIKeSkIEbPfWPMwq/IrQX5HZMhaluPBO8jSitNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1hHBbqAaeX2BhQHocpI9ErmJZV9eGBz4rxUvXSUftQ=;
 b=TkmghlM+C9hIG82wKrZjyeKgXdXI5BQ6baan4/xwuhr/hQqqAcEtWQrS82Cvw2FtH8vRVn7WibwPjvq8wR58woPGjPyT+wTZPh1ilCXhzaqAn3iHOD68iNIcsKqCZbejKF20h86nbnOmHn2ItYuHsK8gyZPlJFAFFvzT8VnUJtBqsH+5dK5QF2NQKedHjkSXjFaRCAudBW6N12BOw9KFzJJT0kAkb3zi5srG782L4peaudH21PmSLOFIQsib6ATXkDdcMS1hw1j+73qeBfNXEUWXt51Mp37dwoKGVl1y5V92wxG5/z8jOOOHYroaUCR/y78fGXaFKW0pJQgA62puGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1hHBbqAaeX2BhQHocpI9ErmJZV9eGBz4rxUvXSUftQ=;
 b=siMvBcooBLUwitByeAlSk5HvPcuMY3Pf5rzB5its0ECrmZ83OXMEbH7I6q8jjekwdynyrcxRX3angqLWQnVEAngg2yLO/kBRUQufG1eQJuNY+sX1EqLLUdBsIX2fR7wX2xO7iK3oHaSgc85to/A60JpR4dL380TbAa5z/hYtYqJXiYHWUWrjG4jfRZmgrqrYsN7FzvzrQjS45Q5CNYsOeRQMBe4bzsZIOjxK3ov0dHRrUetFNe3o2ONj6kyl07XUTgnabYVI8g4Q+NTGnpm/C6AHY0nraJCykLu4pLvv1vjH4VKdaVrNfRYru6KECfUzRQ7Jy3jHGoytQaz46H77eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 07:21:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 07:21:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 16:21:14 +0900
Message-Id: <DKA0U2CODPNE.DECTJLLUALOE@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 07/10] rust: io: add subregion method with compile-time
 check
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: a96a4111-7bae-4344-8861-08deec78d0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|7416014|1800799024|23010399003|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GnnppTas79OEZA4IKZfMXwgL7/z92B2UnCqWUp7091FLxoABRgBwvkePejq1mq1WzgMBWMLT3kidhZOAebOe48u6jgp49wjnHXdNJRgr5YWliVcN+al+UOF5ToIUZ4ViEwKT1pLWCKPRQXkyRHkbmSr4wKFiLWhJZcq0r6kdcUoygVpLr2to5hF/g7YrIBdNK1n5TRW9L0KDIX89DnMDHHdgBXkQa9f8OeGFvk8+tiFW44CJo8hfDRheFDW/WUhTuCInMI+umDyLXNtGDCMasZ1Hxfh3ivFzTEG+Ggx1AauNIknH+N7EKEiCMEaXmAzl/hrVYQCkZ0zvptPCCyuU1OcBo34up2OE8n+tLdldw1c4TY0I7Di1dFThCySxUe9xW1QJlTmRxbuGUJGHmW+tu3bveJ92pIkQSrTx6Obdug3rNJP0ycUlax6FXcjVe309/zEqZrpfIXhFH5CE+ZjNCiml/K+KMV3s6jmVw8BGGVYRCVHfuApFHwKQ8bpUluc5kXSJqArZPiDu1uLGcPdwbCsqk4WXr3LPWTfFw/LQEXEELCDwXFzowD0y4lfZpAyevwafYGP5tiUfbAtg5VdpOvJf2A0VYba+c+exqZVBwLU5rwSsgNTzMr3U+3R1PkxBQAFpb33b6X921PGEWJzJMBxK2GrQkk2FoMQkUw0rg6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTU5OHhQQ3Bqd0tJMlNqb2J1QnRXTC9ybHlZZUZWaDdFUklicnhubVI3SFFq?=
 =?utf-8?B?U3N1NWNoa0tEUEpyT0M5MWJwM0J3SFdISnhsVC9BK3RhUk50Y1ZMYkNMSHN6?=
 =?utf-8?B?RHdUR0c2ak11VjZPSktrTVVLclNCMkRLRTRCTUVoSDQ4Q09aUWpKaXpCUUJr?=
 =?utf-8?B?Y1pRbGgyaWxWY016UFVwL1ZFZVZiOE1kUEdFNk02alRUNDg0MWZOUTg0dkJa?=
 =?utf-8?B?TkZMZERra1ZYMmRKTFBlNXk4QzRpUklienZqdXdNblJKKzVVMHhKUE9wdldV?=
 =?utf-8?B?bmt6d0tBUHRNQmEvY1NZNzlRZG4vQmtwWElMTWRCUmpBVllSZTBXblkxQldq?=
 =?utf-8?B?OE44MEhoKzVMMGhvUnIvNG9Qa2tDeG5ra0c5NUJOTFBHdEh2K29HdDdSUVMr?=
 =?utf-8?B?K0g3NUU0S2xEQlp4cTAxMEUvTkl4RlZyWFEyMFp5TXlNdUhhL1hYZGRNUkUr?=
 =?utf-8?B?bm55Z1BSMVJjWHlPemZhYndSdHR4WGtZUTMwV29zSm9HZFZlSVNzVlB6aW5t?=
 =?utf-8?B?TlU1dFhPcXFBSEpEeldFZXVqUVJvMlJGOWU5RXlidXBuOGtjRTU4QkQxc2Y5?=
 =?utf-8?B?Y2s2YmU4UDFNQ0llL1U3djVaMHloajdScUtMQ2tmeXBLdUVyelZ6eXZzV2hq?=
 =?utf-8?B?V1lMY1Z4Z0xtZGhJMUI0VHA2RnBZZGhzZTloN1dxZkk2VnJpMU5tQ3lxWGhR?=
 =?utf-8?B?OVNNOUdEVHUwUjlNTzNYS0dYNnpkdVJZbGpUamtGNG1JbllXTmU5TXF6Sm9q?=
 =?utf-8?B?ckwwWUFESHBsekpmL2EyS1J1ZTBIZytDSUFRL0VZU1BmWkk2VTIzTDJOalY2?=
 =?utf-8?B?azRzSERhbnlCckVjYTU1Y0poWUt5SkxDa0hta2QxZTdma1BrQmJ4U1NzY0sz?=
 =?utf-8?B?MWZJZWtLVnZiNW1tSG9pZWYzZlpDWWVnb2RyRjZTcnZRY2s1T0grVWhOeVRm?=
 =?utf-8?B?cStzbFhaQUg1UjBxcXl3OUd2c3QyMG9jRG52T1pmRzczN1F5YjdIU2MyeWho?=
 =?utf-8?B?VXVMQy9MR2xnVm42SjBOUk9MZnFDbnpaWWJCMFhpNTJPMXZieTFKMENmRHQ1?=
 =?utf-8?B?WENWODEwRHplaHZ1eHhPN0dvU1VDTHBRMGdKcFA4QnVWbGtubDBVVTUraTRG?=
 =?utf-8?B?UzdZKytPb2tFK3o2OFFkcXN3YVVlNDhRVmczUE43ckZhWWZTbjN0Q0xvYmc1?=
 =?utf-8?B?WEJUTElwcTFDdkFCcHNSM2Mwd2o3ZThyUVd6WjhrUTlUUldNZ3VEeDF0U09X?=
 =?utf-8?B?OEN5QSt2NnlBZjdrZEpJNVBQejJNRGFnQ2NLUTNpUCt0U1FZTGxvTitCeHpJ?=
 =?utf-8?B?QjcxQ0RFeEtheTRPWlJGVG9jUWdhZkxXcUJxcDVtc2RBc0hqTUh5cVkvQWxJ?=
 =?utf-8?B?SHFMRVNIMUdYVlgrbGUzR1pHdmltRksxZFV2elRSbG05Z1c2Ym15ZkdwQnh5?=
 =?utf-8?B?OXRMTXl0TTRIcnFScGdnd3JNT3UxakJZbGdiRVVrT3BRdllTNWV0Tk1JT2tJ?=
 =?utf-8?B?VmpwM0pKTVhCeFNPaFQ2U3BEeUh2SGRPTmN2c0J0TjFPTUgwUFlJRW1uOHJN?=
 =?utf-8?B?em1hNzRtd0Y4MzArY1dqblVKb3B0ckhnTSs5R245WWZXOTdBdkhINmhJbWx5?=
 =?utf-8?B?TittMm14ZWRMNDNmWERJNS9ZMUxpZDZMamJaNzBxcGFGMmQ1UkpnSzloYTlH?=
 =?utf-8?B?ekthYUk0aElrRE5oMDRHUGt6aGp2c2puQkRKZGhKOEw0amxGLzlMSEt4bnEv?=
 =?utf-8?B?WDR6bVdmdnhMSXZtOWE4cHZCRUtLdDdTU25telR5Z2RpSnFZaUJVRDcrRk50?=
 =?utf-8?B?MnhvQXliZkx0SXVXekZ6NEFIQTVTZEx5T1RuOVpkWm11L2s0b0JaelB0eVls?=
 =?utf-8?B?NS93L01SSnd1MjB1eDlIdjBBbnh4djR6V1A4MW9XZW1vRlRlc3gyYno4SXFj?=
 =?utf-8?B?aFdPK2ZKd2kxUG4vRkhQUHdabFNXQVhBYTkrMGpQcUhYU3NUYXd5QjU1TUQ5?=
 =?utf-8?B?alBvcWFPT1F5c0hqWUZhRTdBUUtxK2FnOGlwcG9YRm9sdUFrQmkyOUN3blYr?=
 =?utf-8?B?c3NBbmFxaG5UWFlpN3FqR2xVVW5XNWpLVXpSTVJQUWRGeVVOd2RHRFBsYUlL?=
 =?utf-8?B?amJYQjlUank2eHZpdDVadjd4UTZkWDJGNGtOTlAzMTJXTVdIUDdleUFIY2pn?=
 =?utf-8?B?WFp6M1ErMGFGTDJkS01jdytJU0ZsdzUxRzZkSmFyaHFvRHBMc2FvdWdONGNB?=
 =?utf-8?B?UXNLeWs1OFMza05xL3lPREZMVFE5S25BNFgvSldwcHEybkdnUkU1TzRncUoy?=
 =?utf-8?B?K1ZPYXEvZmpJV0VaYXo4bTNoakpKaUFndHB4T2tHTTAweDE2SzB4ZmM1RUlr?=
 =?utf-8?Q?asexeqJi2iuOXeEphNBXf8kw60mJmuhfiCXG9l8CJO7MJ?=
X-MS-Exchange-AntiSpam-MessageData-1: cIqr8Gmhpp6Gcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96a4111-7bae-4344-8861-08deec78d0c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 07:21:17.9095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14G6zwidWsofabFWfdevCkdsayP+OE+HbSJJZ3lnIL0bLLxSiD0cdO8zcFADukNU5WSuYLnea9BGWgbJzEA5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
> Add a helper function that allows obtaining a subregion from region with
> compile-time check. This can be used by drivers to obtaining a subregion
> for relative register access.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0f8b166a6d3b..f31d37c8a3d5 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -80,6 +80,30 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size:=
 usize) -> Result<*mut Sel
> =20
>          Ok(Self::ptr_from_raw_parts_mut(base, size))
>      }
> +
> +    /// Create a subregion with provided offset and size.
> +    #[inline]
> +    pub fn subregion<'a, const OFFSET: usize, const NEW_SIZE: usize, IO>=
(
> +        io: IO,
> +    ) -> <IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>
> +    where
> +        IO: IoBase<'a, Target =3D Self>,
> +    {
> +        const_assert!(
> +            OFFSET + NEW_SIZE <=3D SIZE && OFFSET.is_multiple_of(4) && N=
EW_SIZE.is_multiple_of(4)

We are starting to have quite a bit of these magic `4` throughout the
file (they are also used in `ptr_try_from_raw_parts_mut`). It's a bit
heavier, but how about using the semantically more meaningful
`Self::MIN_ALIGN.as_usize()`?
