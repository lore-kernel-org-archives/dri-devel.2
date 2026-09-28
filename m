Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D42C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2991B10E755;
	Mon, 28 Sep 2026 04:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISEpP3Ba";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111E210E755;
 Mon, 28 Sep 2026 04:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDF5NT/LzT4NgBi0TIO4+qbCely5ROr2ZK/rWpjBkNFfF6m2q3bL2NJyAq4zzMXbdstdiWux679JEo2zeaihO4NzG8SqXh6HVmUlwR3ZCAOJyRvIzoVJbtog6UvKV4jw7Ww3qjpIUy1DdNf4wfm1feyWZmh6wlyVbwFtpSy4s6cr8lcfu3P1F7699YXrOsIjAvNWpC3gk3FUbyBtylvdqDeCfix7ZhXtJc6sH0t2o640M37loT2Np3oQYxW58SiMfSZpWuD+1WYfCz2JX6xY0uD0yr+AyTR6DWVQb4fXD6UDkcUPkMouGCVpdqf+oNMUj1iaKKT31ayNhB75KZgMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYfZzQ0S8jJoCyFN3XDHg4RMaDhqWIScNMgECFJV5GM=;
 b=BDxwZKqj6hXqPp1yQfVINa+aMAT1DSKAtB45KLMysplXd2j8Gqx0YHbhjNvg2vGr+lXGwa+5VbJsfSX+pniu6xxX/uaY0l6gMGV1oAdRbObt7lMF/6BZR9RBW6AYcQ/FOPS77yBhdAE5r1N0c+Hs0GLrNTno4Uyl2UNo7oLK9hUhkB0SYc4/X6q3if3kfKp+aqKnF3OlvZECIf2wtRxDX8dlqy6SIVGNQsZALyUnYU2JUoUW7w0+ts3aL2LCn1VKnrdezYG9VCvQLOdXLalv11+LMfZ81KMk3rGW0/btqxe86M2CODltLeHQ+bXN0daIo1kfQsdGFB2BLfnxbLi9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYfZzQ0S8jJoCyFN3XDHg4RMaDhqWIScNMgECFJV5GM=;
 b=ISEpP3Baet5fYXOpLOhwpt9msvz4GM1Xme/70C3ktTSB43AzPAILW+ZptnmXNcH1Vd7YFBdsliVg+Xxtfo/IZ1bFZgkqS4AXRL8KLMt9v5EeIzjAQXv1cNPNYShJ12axNgunz8//ABTTnonfOxvP/yJIALXKU18Cb2i5/k1g8ue/Kjc5o9tE3GP5iE/aA/W3uuWIjsNgd+amkMC2ZWbyg1ZFYP73/T8AuiO2wZO+IknQc/GXaalxQtIBDJLGGIZSG7xaQc7zOA2QKDE2zlEtRQltXbFoi/fUNOJRpuCHPe2P7n356GlmnWMiVb/9LRJc74u1kA2OdAR1r+3MyE66TA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:43:34 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:43:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:43:29 +0900
Message-Id: <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
Subject: Re: [PATCH v2 2/9] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: PAZP264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: ed96dd46-bee5-45da-03e7-08df1d1b0e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|10067099003|11063799006|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: wUExPhB1jO8KIgWvDM8EMv3YoCf4eztG014YxoP9KapRAEpibJyDpK3tUC/jyrM+jwl1rNd7CuisAjwqkGiZg8DR9oCdGHBYQYhq2i/iCkFloIPzuR970OR+6uTWsoiwOwAs70Vj0sOGd27NkimMheiuV0OptPA2olTZdAnFupnawOdzZIoTCql2weE/3FAQtHISMccudZm0BTfR6rKPVPSVydvluqj7KNkSlFw7tT7/uG1sYBesh+7VSArBnBvJRSsfh6vXuPbVeMsBN97pBy/2wqKY8BqBNauFXQ4mUqfmhwmakNrZN1RsMInvDaiA2qCkSGDwPgFTpcLS5oi3vbX7T9S0sabHlsgInKXGOpTQHu33zW1ozMu1JJKNiVZLDWpeWAVVzLiZyRLME9TB3+hhtEPgJobE+RS1KDrtkAGdm3egD/cSQPe/NlnaSA43iNTiqK53E0ZmCkBgq9x9RYShJrM7BYJrki6gWyeUWl00OLRE/WJqszTnNMNTaJZKOFrR2soqYBGmJhLyMlRl0E9c9k8232HdfMoWFSE8atmqmK0iaeMO8Dhe3XbM92PrtVCZ4WKPgATEYJoCBqPaCS1WB9SReU9nhTg0Y5IWzQKzONkXE/aGenHtI0QyElvGOaQBu2+k0hVR0FErXOtAhXGM4VmF317uUwnO9NhTlUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjQ1TkhTa3h6VExWS05BMy9qYTJpK1N2R2dzd291UXVhK0phZDcwdUxVVk5C?=
 =?utf-8?B?VFh4U080SEtRMUllQ3pWT1h3eXM2ZTNQNkIwNHg0QitsOERIb1BNYURCeTlr?=
 =?utf-8?B?by83emJhY0JBY1FvRlZCbHllaE55UHN1WWtmdnl3V20yOW9oZ3RTNUVYUzRU?=
 =?utf-8?B?V2VPSU5mTWR4V2ZPcTJMOXZHR1FXLzJVSUx4SDBHSmVNQitMakpFQngwemh1?=
 =?utf-8?B?ZU5RSGdFbXpIWS9CYXRPS0pnWllyeUFYV2cwbnZjdHkxNXdJclBRUDZlbVMw?=
 =?utf-8?B?aG8wcFJERzBlQ3ZTaHVzSmtDd2NmYzc5N2VRVUhubEhrTWtOcENCOGludWNu?=
 =?utf-8?B?amxjR29Bbnd1OUdDdWdpdTZCbjJ1NlhYNnFwYkNaRmRna2JQSWRtR3VES242?=
 =?utf-8?B?ZVJvSlZTS2l1cjRzV1VYV2lQWkFoMjVYbVdiVEVYd0xTVzhKOWpDcno1ZGRt?=
 =?utf-8?B?TkxFQnlvajNwcHI2M1RiWEZ1ZXZqY3RKZ01XNkU4OGNtMFhCMzBUTEpJUEFD?=
 =?utf-8?B?N09KTHp5OUVwbTc2MGlmanBkbUpMSGd0ZW93OUZibHJhWisrT0xHNHBXdWt5?=
 =?utf-8?B?NFcvZUNERW41eFBRRmxWY2VReE9CMVAxdi9pb2huUjBESkpmM05TZHJYbVR2?=
 =?utf-8?B?cGdxdVEzQ3pVQWk3bDE4RzIzUHM1QnZGdjlOZlEvNFFpdXpWdWIvUjdWZE5M?=
 =?utf-8?B?YUFkUHNxaXF3a1dHSXY1Q05BUW5YTFFseVBwNGFRUFdLbFE5YVlScEJoLzZM?=
 =?utf-8?B?cDMrU0pwY3AyV2liREd1a1duM1hHazZMdG1aem1iMkFTcjhYMmZZRk9qVmda?=
 =?utf-8?B?aC9jclI0UFRXZlRJbVRGZmI4b2t1MGFCVlFFMDFsdTNHWGwrNU9GVllpejBM?=
 =?utf-8?B?YTJ2WXVGU1BSOEE1enR5dzFqWFpjSk51dUJGWk1FUE1HUlA5WERaWnoyVld5?=
 =?utf-8?B?aG1EVHdES1BleHkzUVBCbmJrclREUVlkdkJ3MzRZdXJVbFhmbm9LdXhzZXVY?=
 =?utf-8?B?cVVqcmQ0V1FtMHU2WE54NUZ2RUZCbmFNWHErN05tS3V3WDI5Q2kxRHJZVlQ2?=
 =?utf-8?B?K2VJNkVDRDhCMUY5dUlmeVlzQlZoVy9ENmVqZjc3MmN0c1BnZ0Z2bVV5Mndj?=
 =?utf-8?B?eUo0LzZpd0MvTmE5T2Q3TFFFMHVKQklGZDA0RjVVTjNMNGpVdVpLaWpnVW5u?=
 =?utf-8?B?MWRqVmxqU0JtaEgvVVNoZldDTXM4MVZlb3orN29uYlZDUEw3a0s0cTZMb0xp?=
 =?utf-8?B?Z1BLaFRxdnR3T0JmY3N4TlZyNXp3bWxKWk9oUlFCSEZtQmJDbEVNamY2cm9G?=
 =?utf-8?B?dmZaZ0pTTTFhTlJ4VEtEMTE0WFF6Yktad3lDY3haczYrMm9YSUVPR2Jwb0dv?=
 =?utf-8?B?VVVFYmF2MzA5Zm93Z0tNZHNscmVRMkdaMjhib05uZzdQMXV4SjdULzIrQTFa?=
 =?utf-8?B?b0gra0RpUmdNdE8rM25QWW9XUnFqY1FVb2Nua1QzNTY1ZnNyWVN0bHgxL1hn?=
 =?utf-8?B?SGtGRXE2TFkwTFpqS1dSQk50UVlLVXFFZ3NOOFZNSmJmSTVoTkxXaHBaUHFZ?=
 =?utf-8?B?WWt6OXp5QTdONmJNTVNlTGt0d3ppQ0l0QjdTcmZJbHY4Rno2ajk1dkppMW9q?=
 =?utf-8?B?di83M0lwT1JFVGg4OVoxZkgxdWwybi9aaTFKTERvWVBDZDNCQ0FkSVJiQ3ND?=
 =?utf-8?B?Z2xxM0VTc2pybVhickVaby9XTlFCMlBsNzJqdEhVcnZLNVNjak5aL0NMYUxy?=
 =?utf-8?B?bCsySlJXNE1COWdEYlp0enErd0RIckw2VWp2UnhOT1F0NVNsejBjb1RqaWEr?=
 =?utf-8?B?c20zeFd6NWpqQ3RnZGU3YmpoZ05BSitHbVRzU3dac3dUWmc5UUtJUUJaSm1t?=
 =?utf-8?B?MWxmSnlVTlBTNGJJcHVtbkFkbkJIaWlaa21IMFE5ZVM3dnV3cG5lQU5BODdG?=
 =?utf-8?B?UVZhdVFWcUt1dHMvdVdRdWJ1aTM3dENMWFI5QmpiQlZTN25sNDd6dnYzOEFL?=
 =?utf-8?B?OHFrRDhSVHVXTWVXSUo3OHpPU1R4TWMrZ1JWV3EwNzN5b1VSdlNRNTFlUWJ1?=
 =?utf-8?B?V1U3M1pCaUR4QUphTDZ0YkovM0g2ZTJoaEYxTHZPSjY4VFB4cDJYWGNjUkJv?=
 =?utf-8?B?L2dzMGY1d0hoMTFNL21JWHJaUXZ1dkNvRWs2NDMzTEJYV3h2QXE0REIzZHBZ?=
 =?utf-8?B?RGNoSjFqSG9LVzh6bCtoOXV4eDVTNVZ6MnMxRlBwQjExTGRuUGFpSVNvaCtW?=
 =?utf-8?B?cDhjTWxzQ3JQWkxuOFJ2OVc1RXdRYUgzQm5RSzhWcGlxRDRCTTVrU2dlVHpw?=
 =?utf-8?B?cnlEZ05PMGNnQk5RN2o3eGYreWdQN3dFbGt3T3c2NjVXVWFuS0lTZXUwSCt6?=
 =?utf-8?Q?R9I2itwYA7qrEOqnhXC2Jkieyg2Q3FnPnDRL+/vWaplW5?=
X-MS-Exchange-AntiSpam-MessageData-1: DaPFtKLjLbKDCw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96dd46-bee5-45da-03e7-08df1d1b0e03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:43:34.7740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnDdRkNXytfoqRiuQo/QLrRdJ3fqEgXVuIMrjhgp6GlRgSZIrgYS+I6rE1VsCZWfVI/5/KyFAkG95ju0fqFKIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6
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

On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
> So far, the GSP command queue transport and message layer code were
> intertwined, a design issue that goes as deep as the types themselves:
> the generated bindings for `GspMsgElement` even include the RPC header
> at its end.
>
> This makes it difficult to introduce the new GMC message type; thus this
> patch works around these limitations to make the RPC message header more
> explicit and allow it to be eventually handled by a different layer.
>
> The `RpcMessageHeader` wrapping type is introduced following the same
> model as `GspMsgElement`, and can be obtained from the latter. The
> methods of `GspMsgElement` that actually query the RPC header are moved
> to `RpcMessageHeader`.
>
> Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
> and the command queue code is now responsible for initializing it in a
> separate call.
>
> The only functional change is that the RPC debug messages now display
> the size of the RPC payload instead of the whole message including its
> headers, as they are technically part of the message layer. This metric
> is arguably more useful as the headers have successfully been parsed by
> the time we can print these messages.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
>  drivers/gpu/nova-core/gsp/fw.rs   | 95 +++++++++++++++++++++++++--------=
------
>  2 files changed, 78 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index d293d28b0967..3a8548a51259 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -50,6 +50,7 @@
>              MsgFunction,
>              MsgqRxHeader,
>              MsgqTxHeader,
> +            RpcMessageHeader,
>              GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
>          },
>          PteArray,
> @@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) ->=
 Result
>          let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.c=
ontents.0).ok_or(EIO)?;
> =20
>          // Fill the header and command in-place.
> -        let msg_element =3D GspMsgElement::init(self.seq, size_in_bytes,=
 M::FUNCTION);
> +        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_b=
ytes);
> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M:=
:FUNCTION);
>          // SAFETY: `msg_header` and `cmd` are valid references, and not =
touched if the initializer
>          // fails.
>          unsafe {
> -            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_=
element)?;
> +            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_=
element_init)?;
> +            pin_init::raw_try_init(
> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
> +                rpc_header_init,
> +            )?;
>              pin_init::raw_try_init(core::ptr::from_mut(cmd), command.ini=
t())?;
>          }

nit: I think the style is to have separate unsafe blocks for each call
with separate justifications.

> =20
> @@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) -> R=
esult
>              "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n"=
,
>              self.seq,
>              M::FUNCTION,
> -            dst.header.length(),
> +            size_in_bytes,
>          );
> =20
>          // All set - update the write pointer and inform the GSP of the =
new command.
> @@ -777,16 +783,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
>              return Err(EIO);
>          }
> =20
> +        let rpc_header =3D header.rpc_header();
> +        let payload_length =3D rpc_header.length();
> +
>          dev_dbg!(
>              &self.dev,
>              "GSP RPC: receive: seq# {}, function=3D{:?}, length=3D0x{:x}=
\n",
> -            header.sequence(),
> -            header.function(),
> -            header.length(),
> +            rpc_header.sequence(),
> +            rpc_header.function(),
> +            payload_length,
>          );
> =20
> -        let payload_length =3D header.payload_length();
> -
>          // Check that the driver read area is large enough for the messa=
ge.
>          if slice_1.len() + slice_2.len() < payload_length {
>              return Err(EIO);
> @@ -833,7 +840,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout:=
 Delta) -> Result<M>
>          Error: From<M::InitError>,
>      {
>          let message =3D self.wait_for_msg(timeout)?;
> -        let function =3D message.header.function().map_err(|_| EINVAL)?;
> +        let function =3D message.header.rpc_header().function().map_err(=
|_| EINVAL)?;
> =20
>          // Extract the message. Store the result as we want to advance t=
he read pointer even in
>          // case of failure.
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 918a7ae809eb..b12034db7857 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -781,11 +781,25 @@ fn new() -> Self {
>      }
>  }
> =20
> -impl bindings::rpc_message_header_v {
> -    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, E=
rror> {
> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
> +#[repr(transparent)]
> +pub(crate) struct RpcMessageHeader {
> +    inner: bindings::rpc_message_header_v,
> +}
> =20
> -        try_init!(RpcMessageHeader {
> +// SAFETY: Padding is explicit and does not contain uninitialized data.
> +unsafe impl AsBytes for RpcMessageHeader {}
> +
> +// SAFETY: This struct only contains integer types for which all bit pat=
terns
> +// are valid.
> +unsafe impl FromBytes for RpcMessageHeader {}

nit: these impls are not used

> +
> +impl RpcMessageHeader {
> +    /// Creates a new RPC header.
> +    ///
> +    /// `cmd_size` is the size in bytes of the payload. `function` is th=
e RPC function of the
> +    /// message.
> +    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl I=
nit<Self, Error> {
> +        let init_inner =3D try_init!(bindings::rpc_message_header_v {
>              header_version: MsgHeaderVersion::new().into(),
>              signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
>              function: function.into(),
> @@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> i=
mpl Init<Self, Error> {
>              rpc_result: 0xffffffff,
>              rpc_result_private: 0xffffffff,
>              ..Zeroable::init_zeroed()
> +        });
> +
> +        try_init!(RpcMessageHeader {
> +            inner <- init_inner,
>          })
>      }
> +
> +    /// Returns the length of the RPC's payload, not including the heade=
r.
> +    pub(crate) fn length(&self) -> usize {
> +        // `length` includes the length of the RPC message header.
> +        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<Se=
lf>())
> +    }

Suggest calling this `payload_length` because now we have to `lengths`,
one which is the length of the entire thing (On GspMsgElement), and
this, which is just the payload. optional nit: rename
GspMsgElement::length to frame_length.

> +
> +    /// Returns the sequence number of the message.
> +    pub(crate) fn sequence(&self) -> u32 {
> +        self.inner.sequence
> +    }
> +
> +    /// Returns the function of the message, if it is valid, or the inva=
lid function number as an
> +    /// error.
> +    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
> +        self.inner
> +            .function
> +            .try_into()
> +            .map_err(|_| self.inner.function)
> +    }
>  }
> =20
>  /// GSP Message Element.
> @@ -811,17 +849,15 @@ pub(crate) struct GspMsgElement {
>  impl GspMsgElement {
>      /// Creates a new message element.
>      ///
> +    /// The RPC header is left initialized to zero and must be initializ=
ed separately using e.g.
> +    /// [`Self::rpc_header_mut`].
> +    ///
>      /// # Arguments
>      ///
>      /// * `sequence` - Sequence number of the message.
>      /// * `cmd_size` - Size of the command (not including the message el=
ement), in bytes.
>      /// * `function` - Function of the message.

nit: Update or remove argument list?

> -    pub(crate) fn init(
> -        sequence: u32,
> -        cmd_size: usize,
> -        function: MsgFunction,
> -    ) -> impl Init<Self, Error> {
> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
> +    pub(crate) fn init(sequence: u32, cmd_size: usize) -> impl Init<Self=
, Error> {
>          type InnerGspMsgElement =3D bindings::GSP_MSG_QUEUE_ELEMENT;
>          let init_inner =3D try_init!(InnerGspMsgElement {
>              seqNum: sequence,
> @@ -831,7 +867,6 @@ pub(crate) fn init(
>                  .div_ceil(GSP_PAGE_SIZE)
>                  .try_into()
>                  .map_err(|_| EOVERFLOW)?,
> -            rpc <- RpcMessageHeader::init(cmd_size, function),
>              ..Zeroable::init_zeroed()
>          });
> =20
> @@ -848,34 +883,28 @@ pub(crate) fn set_checksum(&mut self, checksum: u32=
) {
>          self.inner.checkSum =3D checksum;
>      }
> =20
> -    /// Returns the length of the message's payload.
> -    pub(crate) fn payload_length(&self) -> usize {
> -        // `rpc.length` includes the length of the RPC message header.
> -        num::u32_as_usize(self.inner.rpc.length)
> -            .saturating_sub(size_of::<bindings::rpc_message_header_v>())
> +    /// Returns a reference to the RPC header within the message element=
.
> +    pub(crate) fn rpc_header(&self) -> &RpcMessageHeader {
> +        // SAFETY: transparent type.
> +        unsafe { core::mem::transmute(&self.inner.rpc) }
> +    }
> +
> +    /// Returns a mutable reference to the RPC header within the message=
 element.
> +    pub(crate) fn rpc_header_mut(&mut self) -> &mut RpcMessageHeader {
> +        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the t=
ype of `inner.rpc`.
> +        unsafe { core::mem::transmute(&mut self.inner.rpc) }
>      }
> =20
>      /// Returns the total length of the message, message and RPC headers=
 included.
> +    ///
> +    /// Note: this method is technically a layering violation as it is t=
ransport-layer code
> +    /// accessing message-layer data. It only exists because it is neces=
sary to accurately compute
> +    /// the checksum upon receiving a message from the GSP.

This is also used in `receive_msg` for `advance_cpu_read_ptr`, not just
for checksum. Also, I wouldn't necessarily describe this as a layering
violation. The transport needs to know the size of each frame being
sent, it just so happens that the data that contains that is at a weird
offset in the transport layer message (i.e. in the RPC header). It's a
nit but I would move the comment from on the function to inside saying
that > it's weird but the transport message size needs to look in
message layer data to know the length; Because it's very natural for a
transport layer to need to know the size of its frames.


With comments fixed or refuted:

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

