Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F99ACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E296F10E058;
	Thu,  1 Oct 2026 04:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWd0U6+3";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6300F10E058;
 Thu,  1 Oct 2026 04:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNs54bauM2uMV6GtjPt/wFls0HmVMgwzK6wnYdVOlutmGuCQwLr+FpP7DfpplCERYOXm9IUjjnQWMTfMPny1Nsy3D5gB6y3hxVOV3diP60Zo/3jMtR6Gng10ddkUm5oBp4U+Hfps98eckSBoqOhlUWIPlwTunjNSaBoyK47GmJvbvEntDdwNShpe/PIlSU9iyparCLeYa5JplEt/uqrNxowrK6XaPJqCNly7mt1M2UMnf/mlzUkFVvGC8ObcvgSgCaKTJ0Ffeg9fFUQ5sgIF3btez7OrbXxNFHmMKt+C7Mz5BJonD4BcNcwDtQMTz+wYWnQR8ltlu/ZoH2zlRRjiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R18SeuZkofCrsUU6mKDmlG2PDqNmNj0hlSz2uSSdbxY=;
 b=HNVJDgbG/GqUP+S+Qy6bz/jiQ7mSRy2sNLqVZzJwMf0hhVzpkMc61gZoxf5Zy8uxc2u9OrIX4e1xA0FeVTALvKCUe27rDHaWPB8P0efC46Y1ktyibangK3C677+v/kQrLc3Uuj1EuBfGnVJ1V8MIewRWyPAy/GFarEz+3yF5fzMHNktaxa9unTywJr4DQU+7XT/b4rRI7mwDjXR1vD+qdFBAKswTpNbvN81rHWQnK2NaGH+3XE49qvirCc2d+IrvRFQj/fd6mO/n74zeOOx1Y/OnIMN6hIPKj3tBs7o/uZudNUgxGr/BMwCqkM9poY79kLmRnfc/JdnGKlqgsTGCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R18SeuZkofCrsUU6mKDmlG2PDqNmNj0hlSz2uSSdbxY=;
 b=dWd0U6+3s9/80sXGkYi1YLE7Q8QpigXgSYst1Hda4vn+o5Oa9Xx0FZx9yfagbKrAPE9xqCvQWH2kQGf+zB6zLJvUzNR9IZ7DTLf0kg1qPT4LoGLbMhPwAjlb9ma0FJ/o8QGQb6+EwKuCVrctApJzSBUr5x0QREWkMJq52ULvdb6yEWk+T627TLJVxfmBxWv5YOoOLuzjuEJ8aseWHVMRRb6Dh0u+yC3WFASY2muuil7i902I/YtrD/F8c5915dTC/xVgRS1qnx6TUIuRU6ujPbZBzP6NcZXqlX2MZgAvX0dOH8UlhXrtblZWtreMEtlXA1hY68kZNDXJKSxLeGmEfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:48:09 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 04:48:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 13:48:05 +0900
Message-Id: <DLT8A7TU1HDY.1NYIPVOXD044F@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 6/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-6-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-6-91613f06520b@nvidia.com>
X-ClientProxiedBy: TYCP286CA0370.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d5d028-af8c-4cd8-db3c-08df1f7730a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IB77glL37k9pjlTPhF+2dbTH70UtGnDdVdhm+VHOLMBr6NUjs23H53pNXIluJIxqTCt6iLuBqeLpHF7Tv7W8GNpEqr2ZgAlN5QEnJFC0R8khVyEHwM1WPS3xcdAWgDTzzCDPJ1hCW1/PKG7zCbx9oTGO72s+TayxBATrxjfYhJKvM4xgw4Qiiqo8c2AL7VRTFWlgRDWU9kQRZAnKxzMj6pvuoYeSpzOQZSqRk2PMg7REpuRU22jDpr2lPQR8jeRR8Ab3cL8Gre+ot2fE3hX1p6l4nlhcKUZpoMziweBHCg8XOIvClVFBWrGefZJ6hXDylTEeupmcF/v3bg1PhdiUS1zFPFxUiOgZF25IKnVrWkrrH0H9UyZmjh5smCMzVZLtrOkYxYBnx3zB23hEQEeIJ07/zO073w3u2EYZWBQQI6++kvUVT26Cd5Ng+mBVCqztN12rsT9v2BtXG+Q41RZiom0fb8kaI3ZFYGObzaHsB5DiYl3vBLjKEG746c1wMT0WKyIS07CFVsXxe8jTEfJNVuFfyjwOQUsmY2Dyb6D3Ocu4c/qmHE/nUDyDHbVd6+wpgSX+lAmtndUOJQQTbjeOONnUH+fX4f9fxmvKcY1UzulyqS9AP+UWYPiZSORbGjugZ/4oPvcc9MaRuiRR9YwNilgq8ZlwfYXMLO0HzmGTpfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZSTmVNSkRETFp3MGl4RUlLbWFwdW41OXN5aWZDZEQ4eGNTR01FNXVwSTk2?=
 =?utf-8?B?bE9tMFZGV3pCRTRjeUh4WG5CLzI4RWZ1UCthcDllbzJOYjVSeEFWYWthbW5L?=
 =?utf-8?B?M3c1ZXk4OGxZQ0xxeVRUTE5HbDRiLy9qU2VOb3RKcnRnTlpVZU50aHp2blRZ?=
 =?utf-8?B?VlVTa25FSEQ1R0FLM0FjMDJiaDdRdi9qTmJuQ3VtcktJWU1Ic1N2UGFjNyto?=
 =?utf-8?B?RFJFT0xzc0pGUzlvNmtLc3UwWlB1SVc3WUZBbWpHQTBkQzNGRmUzQ1c5ZElr?=
 =?utf-8?B?cHB4QUVoRGREZWNTZlRTeWVvdUZsZXY1cC9jQTdLNzJhS01kem9US2J6Lzcx?=
 =?utf-8?B?V1FBa1d3Z1FSSFgxZEJmdHRmNjRuVC9VMjZXcytwVzh2VEVWRWZUN3Bnd0lL?=
 =?utf-8?B?aUlRa3ZQV2tvZmFienNMWEg0WEVTdWhBQzhLdldyUWEyVlNydHNJYWY5SkYy?=
 =?utf-8?B?MmFqT0ppazFhR2FSWGdMdDdBdk5zd2dteEFtcmZGS0lxRlhXczU5Y0lBODh3?=
 =?utf-8?B?K0djREx4SGUvOE9Vd3MvUXVyWGc4bFBHalEvaEQ0MDlSbWVRdE4rVGlzaCt3?=
 =?utf-8?B?KytBUDFNZmNPK1hVVzlCQzM5dFBlbUpndkVvaG90NGlubnk3SnpWT2VhQ0My?=
 =?utf-8?B?L2d0cFdXbkt6ajUwMlU2ZlhuV1d0SFVsbVo0T3E1bEJ2L1JqYTBiTDdhUm1u?=
 =?utf-8?B?TEhHR0FXZFZsZ1FVRCtvaHkrSDBWbXFtcXRvY0RXdmZ5SlYrL0VmNmk3bCtz?=
 =?utf-8?B?V1BCeDlvQUp0c0JmUFVIK3ExN3RTcGFTd2tQTEUrYThZQ3d6YTZuT29kdzd2?=
 =?utf-8?B?eFJJM1YrcVNpcjdhNzBCYzBWTWJvQisvVEdsdWtvY01BcXRZZXpHM3lEaWVp?=
 =?utf-8?B?MHljd3pod0p6bWJhWFNEVk9wbG1CSDljelg1dzFzTFNJWE5DdlJIUENOY3la?=
 =?utf-8?B?SzB4bXp6a1J3VXMrL0tCcVhiN2oxR1ZOMEZpNWtVbzNVMDZsRis0eUNCM0h6?=
 =?utf-8?B?MHZlUFBqa2lVdUdxSDRxay85LzUyQXFOdnNoVGYyam1ra1V4VDRnQjk5VCtO?=
 =?utf-8?B?Mkd4d3lMRGJQYVBLYnF0Y3ZrZnIzMWhWOUkrZHlSSFlCSWxGYUJYeDlDQXFP?=
 =?utf-8?B?OE9lZkYrRnM4RElzaVp6RVdSMFRpbE80OGxKZHFWS3BsVnFINFlCY1lvRGVN?=
 =?utf-8?B?N3JvZTQ0dlpDMjEzaDhLOE1VZ3hzZDVMeWk1dzRmSUZwYlhTckFUR1Z1cUkz?=
 =?utf-8?B?a1YxSU5JVExGN3ZlcmMzZjlpNm5qeUpLa1BlVW9FS2VPOTFmeW4xL0h1bERs?=
 =?utf-8?B?ZTZtb1k4eXMzdHBoeEY4RmR6YWhRWVpxUVR1UkxtaXU4bXZxK2xjVi84bTR4?=
 =?utf-8?B?MUJtTGZSc0hMRndXRmFieVJMRnA2UkNLZVFMQkVNdmdIaTVsSm1BOXU2WVd2?=
 =?utf-8?B?cHo0Y0x2TkdOblVqcXJIbEtyenQ5ODFXTnlYMjUra2daa1lkWThQK0NNQklF?=
 =?utf-8?B?TjdVbEtNcTRZUGZjYzh2ZE9LWjhqcGVSM0xpYjJLNklyM2VwSUZWZS9pTWVM?=
 =?utf-8?B?bUcyY2U3SXozR2tqVXJwODByeXRpcUN5Z1E4WDB6OE53YWgxSXRRMXdUT0Ru?=
 =?utf-8?B?ZVZ1QkRYK1R2dEVjcDh3UmxUM3hRTFQ1VTFXTWdBTjVCV2JxMWVtTTZzbVcx?=
 =?utf-8?B?L0RQKys3UDYxU3NHRVdVWHdtS3c3QjZGUVlhZkVrUWNtRnNjYW5QeTU3U0RP?=
 =?utf-8?B?U0c5WG82S2FXUlNSdGVuZ3REOVNzQzR1MzRGR2dHVmdqQUFsR1pyd0xxelFM?=
 =?utf-8?B?OGZ3ZUpjUTBoUGFIM01UWWVkc1A3VEkwQ3dYQU9VaXBkZ2xESDZUQzJEekFu?=
 =?utf-8?B?RjhtZm9jVUE0RnFZdDl6ZDNCcU9qekxsci9pQlhZWldqRDZ1YlJBMVJzbXpt?=
 =?utf-8?B?S1JoR1AyenZNUElFOExTSEpPbHlxbkU4NC93VEYvVkhhcGVjSWZkc1NndlMz?=
 =?utf-8?B?UWMxSnFFbWRLUnZSZlExcFZtaE5pMmxNOUNmRTBROUpXQTJUZGg3WHZlTkF5?=
 =?utf-8?B?ejRJU25Hem9TVlRCMWVDa1JlK2xkYkNUUm9qcUExczErUUZzS1ZxSW93ZFVE?=
 =?utf-8?B?QmhNeGYxK09TVGNaZzNzbjN4NThFWEFNaFNWM1VyU3h6dkIrOVB2Q3g2cnlG?=
 =?utf-8?B?dFVkOEpNOSt6UWRqRk8rMkIzV0lGczg0NC9BR3lSd2QwODdkYS9LV2Nrdllx?=
 =?utf-8?B?VEQvcnJNaGRtdlFKUkpRRlZSQ0gxR0s5Y0thWW1na0Jnc01oTDh6WkRweExz?=
 =?utf-8?B?OHNxVS9FL0NZY0hjMnlHOTM1cDcreEZRbEdhdVlIZkdoR1hJSGMwVVBzWS9U?=
 =?utf-8?Q?/dq5KwBwWQKiBHsdU62irRziZtPQ8SIvQRMl38m9QjKVp?=
X-MS-Exchange-AntiSpam-MessageData-1: HAfY/rTrxZrSsg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d5d028-af8c-4cd8-db3c-08df1f7730a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:48:08.9253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE0ai91WkMufuH62Q0TsjNUzMnYNs84Xtn5isSC6ChKXmxbgPsl9FuMhZqIrr7Bhy8kEavt5f/TuPAn+SGadeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
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

On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
> `wait_for_msg` mixes two layers: the transport layer which polls the
> queue, extracts the element header and validates the checksum, and the
> RPC layer which reads the RPC header and trims the payload slices to the
> length advertised by the RPC header.
>
> Move the transport layer into `wait_for_element`, and introduce
> `consume_element`, a transport-level method which reads the message's
> contents using an implementation of the `MessageElement` trait before
> advancing the CPU read pointer past it, and `parse_rpc_message`, which
> validates the RPC layer. This sets things up for moving the RPC code
> into its own module, leaving the transport agnostic of the message type.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 219 +++++++++++++++++++++-----------=
------
>  1 file changed, 119 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index b8a9e02b76fe..07036972dbec 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -195,6 +195,15 @@ fn write(&self, dev: &device::Device, seq: u32, dst:=
 &mut GspCommand<'_>) -> Res
>      }
>  }
> =20
> +/// Trait implemented by types that can be received as single command qu=
eue elements.
> +///
> +/// The command queue validates the element header before calling `read(=
)` to interpret the
> +/// contents.
> +trait MessageElement: Sized {
> +    /// Tries to read `Self` from `element`. `dev` is the queue's device=
, to be used for logging.
> +    fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Sel=
f>;
> +}
> +
>  /// Trait representing messages received from the GSP.
>  ///
>  /// This trait tells [`Cmdq::receive_msg`] how it can receive a given ty=
pe of message.
> @@ -218,6 +227,94 @@ fn read(
>      ) -> Result<Self, Self::InitError>;
>  }
> =20
> +/// Wrapper type for receiving a RPC message from a command queue elemen=
t.
> +///
> +/// [`MessageElement`] cannot be directly implemented for all [`MessageF=
romGsp`] with a blanket
> +/// implementation as it would conflict with other future message types.
> +struct RpcMessageElement<M>(M);
> +
> +impl<M> RpcMessageElement<M>
> +where
> +    M: MessageFromGsp,
> +{
> +    /// Validate the RPC layer of `element` and returns its RPC header a=
nd its contents trimmed down
> +    /// to the RPC payload.
> +    ///
> +    /// # Errors
> +    ///
> +    /// - `EIO` if the element is shorter than the payload length advert=
ised by the RPC header.
> +    fn parse_rpc_message<'a>(
> +        dev: &device::Device,
> +        element: GspMessage<'a>,
> +    ) -> Result<RpcMessage<'a>> {

This doesn't depend on the type M, so it could go on `RpcMessage`
instead.

Also, moving this here breaks some doclinks from other locations (e.g. `
This is the type returned by [`CmdqInner::parse_rpc_message`].`). Can
you fix please?

[...]
> -    /// Receive a message from the GSP.
> -    ///
> -    /// The expected message type is specified using the `M` generic par=
ameter. If the pending
> -    /// message has a different function code, `ERANGE` is returned and =
the message is consumed.
> -    ///
> -    /// The read pointer is always advanced past the message, regardless=
 of whether it matched.
> -    ///
> -    /// # Errors
> -    ///
> -    /// - `ETIMEDOUT` if `timeout` has elapsed before any message become=
s available.
> -    /// - `EIO` if there was some inconsistency (e.g. message shorter th=
an advertised) on the
> -    ///   message queue.
> -    /// - `EINVAL` if the function code of the message was not recognize=
d.
> -    /// - `ERANGE` if the message had a recognized but non-matching func=
tion code.
> -    ///
> -    /// Error codes returned by [`MessageFromGsp::read`] are propagated =
as-is.
> -    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Resu=
lt<M>
> -    where
> -        // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
> -        Error: From<M::InitError>,
> -    {
> -        let message =3D self.wait_for_msg(timeout)?;
> -        let function =3D message.header.function().map_err(|_| EINVAL)?;
> -
> -        // Extract the message. Store the result as we want to advance t=
he read pointer even in
> -        // case of failure.
> -        let result =3D if function =3D=3D M::FUNCTION {
> -            let (cmd, contents_1) =3D M::Message::from_bytes_prefix(mess=
age.contents.0).ok_or(EIO)?;
> -            let mut sbuffer =3D SBufferIter::new_reader([contents_1, mes=
sage.contents.1]);
> -
> -            M::read(cmd, &mut sbuffer)
> -                .map_err(|e| e.into())
> -                .inspect(|_| {
> -                    if !sbuffer.is_empty() {
> -                        dev_warn!(
> -                            &self.dev,
> -                            "GSP message {:?} has unprocessed data\n",
> -                            function
> -                        );
> -                    }
> -                })
> -        } else {
> -            Err(ERANGE)
> -        };
> -
> -        // Advance the read pointer past this message.
> -        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
> -            message.header.length().div_ceil(GSP_PAGE_SIZE),
> -        )?);
> +        self.gsp_mem.advance_cpu_read_ptr(elem_count);
> =20
>          result

Previously, if we got an unknown function code or the message was too
short for MessageFromGsp::Message or the payload length is too big for
the remaining read area, it wouldn't consume the element, but now it
does. If we had corrupted data that happened to pass checksum, it could
mess up the queue (e.g. wrap the read pointer around in front of the
write pointer).

Since this nests transport, message layer (RPC here), and content layer,
it might be worth saying how each should be handled. Here's the previous
+ semantics with this patch:

Transport:
- Timeout, ETIMEDOUT -> no change
- Bad checksum, EIO, not consumed -> no change

Message:
- Unknown function code, EINVAL: message consumed in this patch

  If we get an unknown function code, we can't know if things are still
  in a valid state, so I think we should not consume the message and
  return an error here.

- Known but unexpected function code, ERANGE, consumed -> no change

  Think we have this since we don't have async GSP message handling
  implemented yet so we use this to drain the cmdq of misc messages.
  So all good here. N.B. we are implicitly relying on the discriminants
  in `MsgFunction` essentially being an allowlist for events we can
  drain, otherwise we hit the case above (in the code previous to this
  patch, at least).

- `slice_1.len() + slice_2.len() < payload_length` hits, EIO, consumed
  in this patch

  This will mess up the read pointer.

Content:
- Payload shorter than MessageFromGsp::Message, consumed in this patch

  This is another weird scenario that shouldn't happen. Arguably we
  shouldn't consume the message here, but this patch changes that
  behaviour.

- MessageFromGsp::read fails, consumed -> no change

  Not sure, but seems a bit weird to consume this here.

- Payload not fully read, warning+Ok -> no change

We could solve this with a custom error type for MessageElement, or
return Result<Result<Self>> -> the Result<Result<Self>> is arguable
since we are returning the result of the content layer.

Send path semantics look unaffected by this series to me.

>      }


