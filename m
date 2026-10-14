Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20509CA9EBD
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E1210E230;
	Wed, 14 Oct 2026 03:56:55 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA74D10E343;
 Wed, 14 Oct 2026 03:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRrv8CihUjKqS2J+3tif9laHrGHk/NsZ33ydgcr3FbC8dDsqzl8Btd/v8mCXrthRtgs8KTJDd3RhJb5OmmELFlkttG4CxaknbnBsZqtU1QxKdCkFXLiZfm/SW0a8D2o1TFqXSV2C8df60OPFyTSUNclWqioX0UaX2bZ1qo1GK8kGmSijVKtsiZl46tk4UVGTD9UtD0G9xgCYtyOU33C1F87xudDd4UnTazvL35e5j9VILoKF1zG43xpjui1mnuyMNCyCmYJnl1mO6ngrVM3I7Ui+tIk0qt8YLBHZVg7ic9ookMFppzNePq7mm6xy0i6zUWvBtCdepa00jJL3OslGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAhhHQXOuNEfSX0yYoz2hqqg6HWbp8//X+5meJaGAQM=;
 b=DrN/BGXFQn42iQ0d/+Pr1TV9rl+IaY3jZR/3tJf4GX7WQGIu0zq1rNSqwQR+oZIPzQhIitWfk0n8kd+Af/3DmS2491yaB/WxxvO+2WyAKO0wn/ZToJKGbkzqJQ/t1Gf4QAx8jjJXiSqXbueVEGVM6FXW6roGH/zlT+WsqzA/6Y/6HEjgoByxw3N3ElvAZaX0eKIsAwYWAlB6vR47a63U/MDIc3v5e71aeO4v8yLgLXwC7UDt9XUlX4VeRTa2Zss5VTBIREPUmgDrj6LLLnb/T9SO3rmk4nKMstpNpYjcxAa1PopcWK5hlSGaOFv6DTnOCF/Q2wd4MJlGynu/rdab0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAhhHQXOuNEfSX0yYoz2hqqg6HWbp8//X+5meJaGAQM=;
 b=plj66GRBZhBvfawhtoHr6BeS2popAZZ9YuXMKfvTSl6X7rzFh5TgTquYDakhVL/Qr6BpspKE0zkRQcx8lcNMetKKfAtcZ2+1HBYQEmbCrkwUx/JZr0hd4YhN4OrVzeo2M8tuf810ulPjVQhygEI83sWtwRKZjD1gonqpLz7bkYtgOGl1mP9iMK+wcYFBuURk6nR+1dgwpFkKbPPXCUCXc9DInIeJTc3KWnXA78mA+HX2uzKkH36CPf9oBgPXV7Ipi+saJKrWm1Ai276WtVX2KK73hXzKZOr+EjYA5IOBNtBssDOOKnoYMc2f1Dig5vi5XuDSTgN4gq0CUSoG/5DYzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 03:56:45 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 03:56:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 12:56:42 +0900
Message-Id: <DM49BYCF7DFJ.KDPNZK1EVPWB@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 07/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc3332d-8102-4d08-1353-08df29a729f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B8MElsSZhCtaXYlLlsarHsLbMIZcHilOOgkfuAf9fYzftrovyn47uofezOkyO6eqPUwAVfDRx4exhnycuJE+yacoihnIqUZvMSBye9yznk5WPNwoXCOPrwNj38d26mh0XnpUPPENrilKrODnEllfoiJ4KY4KE5d2g+glns4SCE3Slm1K8m/FbMqLUC6yDUlhfEXYpXtkGa8vz5gE6GuhVE4T0eN9SQkkYEUUMjuh/5ZZG2qt5urJepB0r7jdmiSgryR4fk7s4gKkz2s4+V9MQbRstlJ1ZGX3KfLqtxXqSEf+em/6MAYoHtYHv2tAWC3qTOQux4KOvxxbymxNd862zot5lNHvF8ABhp0Ph21zsqH0DHp+6MgtIyVG+BmmqS9Vgib/P77dyuczTK/dC2R/VWhNa7UdgM5Jy+2YXWyyE4wwmud3TqdQtPVOrU1P5C1nCCt4gJpgWU+Ua1sbKLVFr5k4Ajdj/pTOUXVnewDn3qkjQYh8XDO/NGLRWbyWgDDVua7A6mTcReqfODF3oZ56DitXl+/G8rR7/B8JGm+f9Wt7L5jpNOnt3cab1hMiEnj5csuOyT70OAflKlKt+Fd/cww8jPQ4oM9+BphzcgLLr+q+USfLBB+v8/yOLs8R22D63HXzDWUeybrtNdf1A4DS9ypIsaFBKLEnJUylTW8YK4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BWenh1cXQzMzRTa1pUcU93aGlQWmpxaWdFQVA0a3I4dGtLSm4xMTRFd2Ju?=
 =?utf-8?B?cTNYTThFMXpwRkhyc2x3dURNODFYSFFXUTYrL2VIT0ZsZjdweVlBMGlHU3hF?=
 =?utf-8?B?bTRrS3F4ZTBENzZXTW5nL3ZDTmI3SHJnQjRuUGsvV3NNOTF1SEFtRE1SQWx2?=
 =?utf-8?B?R3RZWlhLZXFFMjJRcW8ybkErQmYvVzMwNmhzMXQwZHNuWGk5aFE3aHphWE9F?=
 =?utf-8?B?MkVMYTFFOC94MEFPam9Bd0p0dTM5WXBIVU9FYVhYTU5UWm1uQk5DMkRTa1lK?=
 =?utf-8?B?OGUyWUt1THkrK0UrT0xlZW5YZWpid1pLR3JZaWpnMWlhYUhxUE8yS3JhMFVE?=
 =?utf-8?B?VE5VSXUvQWU5a1lTVEU3OWZuaFVWTmpPMXc0RVJrM3d2UXM4VDlhaWpWVFV2?=
 =?utf-8?B?Zk5qcUYvSm5UeXdJKzEwZUVTWHRDWjdSMW9xK3BIcEZiOE1Pc3NlZ1h3ZUh5?=
 =?utf-8?B?VElGVk1wY0xHMmxVN0YvSERCSmk3TlIyKzFJbW4vem9yRGVTU1ZmZmJ0OE9x?=
 =?utf-8?B?MlQ3ampBeTVJT3A5SzhHMTdWN1Nka0dQRlF3L2IxTUJ6OEhVY1IwZmgyQVRM?=
 =?utf-8?B?RFBEOHQ5Q1prK2VoUXRwa3ZTWWU0RllxYWRQYTdpTHkyUGROTlRlbHNhYlhD?=
 =?utf-8?B?MllRZjhHbEUwbmZnU0wzTDU0WU9PTk5MNVpBWlhnRkJYUVFTNEV4bEowU09Z?=
 =?utf-8?B?SFMwK3ArN2NkYXJBTkZLNEpvTXNJL3hrVXpzUjc3OEFid1Y3eCtjekkrUllw?=
 =?utf-8?B?WXBtSEZlQVVMZnZMVDJNS2tMZEU2bmFkWTdQbGYwc2Z0NUxEd0ZLNmxoQWFX?=
 =?utf-8?B?dHpaZUhKMzl5a0hrZ2RpYXo2UDVvNWtvVTk1dkJvL1VpTHdtNHRuaEF1cTFV?=
 =?utf-8?B?eDhqM2lDMnRIRmc1YndnUDBvbE8wa0xqR0FnT2tzTFpaTDBkcjhpT1UwT1BH?=
 =?utf-8?B?amxoV09oOFczUjVUMFZqMXNuWGQzdGdMa1U0Q3pnNnVUby8rcStKUTMva1ho?=
 =?utf-8?B?VXNsclkxeCtqUFA1WHYzc1kxcFpJSTZiSkFZbDR0OUVaTmRwWnNVTDgxTG16?=
 =?utf-8?B?bS85SEZOanpGVUhFVFJ1NXhoaC9xWGt3MzM3WE11VGJZOVpYenBuVzlSMU94?=
 =?utf-8?B?Z0RuL3Z3c2JmWTJOTDhrMkEvSWVjUkhOTXNDSFJ0RCs0TEVUMEd2dWJLT0JU?=
 =?utf-8?B?blBxTzQ4Y2FyU0hwWHc2TWJuOVltUmlqZjNhNW9xcndDOSs5VkRMbEdHNS80?=
 =?utf-8?B?dXRDYU9uZ3ZpTTRheEJ2UnB0RHM1Rm9yZnRheDRYdTlMTFpvL2QveHVYZjBz?=
 =?utf-8?B?R2M0eDN2Qmd3MUNlcTAwZ0V5MWord3lSeUw0VThTVzZaN1VoT1MzZHdTRE05?=
 =?utf-8?B?OHI2NDFLNHVVSDd2VldZRnR6OHdLUFBVLzJZTmdETXpMTTZYVUk4VWo0anlx?=
 =?utf-8?B?THpWTCttei9yeWR4OXk2bmw2enFweU1wZzhNaEJtc0x3UXlSOEdBYzhNQWt1?=
 =?utf-8?B?dUxBUFh6UDZYQlYyalZ3cFVDUHN1UFZkZFd2S2RiY3czNUNnc3hTNjc1Y3lN?=
 =?utf-8?B?U1hIZTZvNDRLbUE4Q2ZSdERIRGNZamdRWXhVYmpxcWkyN3hybGQrYVFia0ZP?=
 =?utf-8?B?aG02SzZqR0JBUU9HSTJPOHdVNGlyVTdpd1gyZFNvOUM1SFAwcmh4Q3BXazla?=
 =?utf-8?B?bVlNWUorMHlyY1k0ckpGMEZWNG5OM0VSOXNuOVBVUkFoMTFJN21WZ0VqaHYx?=
 =?utf-8?B?T2ZKZ3paWTNzR0tTTjNDbDZ0TXh6anA2ci9UdjJqbHY0WlhaMC9md3FNdTlo?=
 =?utf-8?B?TWg5MzJoU0E4THpYUXd3aENnR3VLa3lNdWUxYzJGMTgzdUQxNWYrU3JVU3Ar?=
 =?utf-8?B?UnRBVXExZDViWGV3b3FWTEx2L2hNbWdQZVY1RjNFazRMVmlYeEo2TXV2MUtH?=
 =?utf-8?B?KzZBbTAvNEVmTGpXVnZ1VVltS0R4MnhHM3RZNkxsbGZicWRkT1dzWk1jejF1?=
 =?utf-8?B?dXpRUEx5UmJqRVJEVDZxeUF6dzI3NGcrVUNrRjNWdlBsKzhEY09sZS93L1I3?=
 =?utf-8?B?NG5FSnVnL21JUDMxZ3lrVWsvbFFuWk4yejBDMHNubmFUQ0d0LzAzeENncFpK?=
 =?utf-8?B?R3BUQTlvUVJ3WFpHVGdYd2t6d1lCUitIRHJqM04xSHpxK0kxOUl4M3JQRHM3?=
 =?utf-8?B?ZjdEbkwrOFkxeUJIMTJWUmFoQXYzUTBQUHNpYnNBT1BqaERDSk05bHh3bjY1?=
 =?utf-8?B?NzdtVFNSVUVmdzZIQ2ZGaDVvS2tFVHVqVExCQStNYWpTdGk5cVBEcVFYUEE2?=
 =?utf-8?B?TSs3aXkvVEczM1M1b3hPMStDdGt0OFhNRkpSZnp0dDJ2RnhJZ2cwbHlteWZJ?=
 =?utf-8?Q?fjf0eQ3EyRVJGNDmGjEOSSpadBq0S8WTH/WR9V42f9MUz?=
X-MS-Exchange-AntiSpam-MessageData-1: IBoqNcj8W+Dsyw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc3332d-8102-4d08-1353-08df29a729f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 03:56:45.3045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m52qC4IEmrUV+jcFJ9yF0CywEkfkv2KMIWVGsyKh98hi0ofjRCyNPikNQ244Oo9lrW6KTZmVY7nxgFJqqX467A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
> `receive_msg` currently handles both the transport and RPC layers.
> Introduce the `MessageElement` trait to define how messages are
> processed, independently of their type.
>
> Keep the transport layer in `wait_for_msg`, and introduce
> `consume_element`, a transport-level method which reads the message's
> contents using an implementation of the `MessageElement` trait before
> advancing the CPU read pointer past it. RPC messages are handled by the
> `RpcMessageElement` wrapper, and the RPC part of `receive_msg` is moved
> to its implementation of `MessageElement`. This sets things up for
> moving the RPC code into its own module, leaving the transport agnostic
> of the message type.
>
> As a result of the new abstraction layer, RPC messages whose size is
> unexpected are consumed instead of remaining on the queue.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 102 ++++++++++++++++++++++----------=
------
>  1 file changed, 58 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a059ce74ba2d..65e1a0b6bb44 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -199,6 +199,15 @@ fn write(&self, dev: &device::Device, seq: u32, dst:=
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
> +    /// Tries to read `Self` from `message`. `dev` is the queue's device=
, to be used for logging.
> +    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Sel=
f>;
> +}
> +
>  /// Trait representing messages received from the GSP.
>  ///
>  /// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cm=
dq::await_msg`] waits for.
> @@ -224,6 +233,45 @@ fn read(
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
> +impl<M> MessageElement for RpcMessageElement<M>
> +where
> +    M: MessageFromGsp,
> +    Error: From<M::InitError>,
> +{
> +    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Sel=
f> {
> +        let rpc_message =3D RpcMessage::parse(dev, message)?;
> +        let function =3D rpc_message.header.function();
> +
> +        // An early return here would leave the read pointer on this mes=
sage.

I think this comment is no longer accurate.

> +        let result =3D if matches!(function, Ok(f) if f =3D=3D M::FUNCTI=
ON) {
> +            let (cmd, contents_1) =3D
> +                M::Message::from_bytes_prefix(rpc_message.contents.0).ok=
_or(EIO)?;
> +            let mut sbuffer =3D SBufferIter::new_reader([contents_1, rpc=
_message.contents.1]);
> +
> +            M::read(cmd, &mut sbuffer)
> +                .map(Self)
> +                .map_err(|e| e.into())
> +                .inspect(|_| {
> +                    if !sbuffer.is_empty() {
> +                        dev_warn!(dev, "GSP message {:?} has unprocessed=
 data\n", M::FUNCTION);
> +                    }
> +                })
> +        } else {
> +            rpc_message.log(dev);
> +
> +            Err(ENOMSG)
> +        };
> +
> +        result
> +    }
> +}

nit: temporary `result` here is not necessary since you can just have
the if/else as the last expression. Clippy (only at 1.85.0) complains
about this, so might be worth fixing.

> +
>  /// Number of GSP pages making the [`Msgq`].
>  pub(crate) const MSGQ_NUM_PAGES: u32 =3D 0x3f;
> =20
> @@ -886,7 +934,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>          }
>      }
> =20
> -    /// Wait for a message to become available on the message queue.
> +    /// Wait for the next element to become available on the message que=
ue.
>      ///
>      /// This works purely at the transport layer and does not interpret =
or validate the message
>      /// beyond the advertised length in its [`GspMsgElement`].
> @@ -933,53 +981,19 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<Gs=
pMessage<'_>> {
>          })
>      }
> =20
> -    /// Receive a message from the GSP.
> +    /// Wait for the next element on the message queue, pass it to [`Mes=
sageElement::read`], and
> +    /// advances the read pointer past it.
>      ///
> -    /// A message whose function code is `M::FUNCTION` is decoded and re=
turned. Any other message
> -    /// is logged as an event.
> -    ///
> -    /// The read pointer is always advanced past the message, regardless=
 of whether it matched.
> +    /// The read pointer advances regardless of whether [`MessageElement=
::read`] succeeds or not.
>      ///
>      /// # Errors
>      ///
> -    /// - `ETIMEDOUT` if `timeout` has elapsed before any message become=
s available.
> -    /// - `EIO` if there was some inconsistency (e.g. message shorter th=
an advertised) on the
> -    ///   message queue.
> -    /// - `ENOMSG` if the message was not the awaited reply.
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
> +    /// Errors from [`Self::wait_for_msg`] and from [`MessageElement::re=
ad`] are propagated
> +    /// as-is.
> +    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> =
Result<M> {

Ok, so we are changing the semantics to this always consumes the element
in a few more cases. I think this is ok and it's documented so sgtm. And
maybe we do something for poisoning later?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

