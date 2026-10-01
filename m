Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6DCA5FC1
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425BE88CE4;
	Thu,  1 Oct 2026 02:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gllPMmqp";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE0088CE4;
 Thu,  1 Oct 2026 02:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfiEgeR5jTgrKrq4AnZr/kxcjvywHzaMrn76e2BLuvrC91otEZC0sxK1inxda6kdpG1QVOhKydlD62HuFy98iOCMUol73VEIPMs4G8OpEXth5UQ0/wplCPI6tDHL/FkpKHh0qEbTvUhziNjlZAmsEmit6kIgmLubtGKFx2t55Ws7JlGV0mMUXLJVyx95X127D/+iw/cS/oLojWfolhgl9MS8kRoPZHsjcw/gT7HaN1gwE7lQs8cxLb+hxftM4c87r0/adHjcqCY+C/KZ3ZPl9Mo0RWqq5BzSNfYuu2Sn++P0p/DqVzF85aK2cItXYQzaI8sRuL+kAiOumUNjpFrfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErGDj2QMtzPs7qvuXPtIuEhQDeK3FHTg1rSbl6vt2/E=;
 b=RNraxDo4/QNgmxvDf8W3N+m6qOg/zFwSyvSy4KzHjx842cmI1ZqbMXKXMFJ85NcFLTlksAO1cOEF9/xKfyO5efUV+a6CAB6OdQRKlJaC+djod/Vi5AtMpv3iD6u7/kh4UpAaPCz7ZBoOqHuhnw56k3Qsl6ePvHLHCiKGly9IosRlpl5jC8BH7VVq5FS6g2x7Ld6MwbjNrqeWIHldqSVdLaTIHrkLb0Kq28+A/x1A78wZtB/eqmmdPbt+PL1kBYXErgEJj4adh+fhjJsw+tHEGSWOWhJOEdAWN4VKVY/tr/7D+3AnjznskbMz8IJrTFGMquxqO+h/YMCtKmJ3MmpGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErGDj2QMtzPs7qvuXPtIuEhQDeK3FHTg1rSbl6vt2/E=;
 b=gllPMmqp/xRt5vRPwZ5SEw70dfjuLdFc4aGlcHw5FNhz6Qb5VsKWifXrhbdXpq3Ybr4avqLrsme0ddWBgxYJ4S+y7SY1lOVl3zN+ii5++VbmDNWwAubwIKY+1uBaNcWaLgE6p2oFbMLo5B09UYQSWkaE0kQrzIBsl0vwRHQkFBCdo+4IFy4Rt3yI33z10KUTdr+Mh3Ds0T8bMvY+BzfE3GfScdma0jV13a6OqdYSkVVSfUwZMl5Gmlf7pBF/J5zZgqMAHwijG7KoYBQpuz5X1IC0zqYUKQz8+fnWDivizxTYpTfMZbsiY14Bbix5thVKr9BbzNdd4t3TQvnSYoHlZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Thu, 1 Oct 2026 02:21:44 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 02:21:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 11:21:41 +0900
Message-Id: <DLT564CV8CI0.1GHQWYK054K8V@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-4-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-4-91613f06520b@nvidia.com>
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 75531535-d2e5-498c-c2a7-08df1f62bca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|10067099003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WGrMaR+tN1JbuWLH3cGtKig+aa1sfThREIMvucSVoN7DuQHsvaN/YcXjGcYEMZlfp3lU8bxRY93LrZM+ueP4/D7jBgvv3pT/0tItawA2RomUz2Jrz7bRc/Pl61ujkdFIydu9bxG5PgOGiMLLW0/CF+nx5vc+/3jEDoRCbD/sLKOtfz8GlX+dsLT8vPB30LdvdD6Df0sIBytWtcrALLOXv7FnsYSIzCc8bkoQ/VHLU9wulBBlEjpZ2TLl1Xe6eNCirFV401j4QWbiq1o3GWgCZOXiCKgR+F/lhBVeIg6nCjUvb2ir/IH6RraHIJ1BXolKkkgb2FFIxJrl7922bnr7fxFJ5yavs6WIk0SXQHA5ksENjTaxPm21cJR5kOIEPS2/C9u6H6BCUtsNyO23ZVlsr+XsaBmdWoGEyYm6ca1rE0iC2w1/X1jWwUW8DNIvL+4CyAxySnzrEig1tcltss1fo2DQ9E0avDTX8pw0Pn1A1k9wF3eFYiDFWJzX7Y9ZAYMXt0A7Vns5QgmdAWbkoWHRertxM7eUFskojLr73yW1Mh9VyXLz89tANxotWmDhrcytjqer+h98ah0wzqXhQKDey7Z79/c0p/58VMuQ0Ab2rv+2chWVaNE5Hjyeru2PXTn7mYnuWE21nDmPYxItxJpdA6Y0EZ3310nOEuM9EtDYhvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZFRGU5RmlqbUUyQUl3WHVVeTN2bmJaODdDdGorY2F6NVMyd0IreXp6NlVZ?=
 =?utf-8?B?Z1VTWnZQcFBVWkJWc3plWmxjbjU2RitxbU50dHB4Sk5DUExzVnZNVFV3TFJ3?=
 =?utf-8?B?NFpwUitWNmE4YVp3SHRDejdWNWhkNCtqbDVWeFkvVHFhK2NYTFNQbWw1WWk4?=
 =?utf-8?B?S0ZCS2dwWEh5bVl0MFd0UjBRSE9SUEJEQjVZV05WMUpJSm9Dd0xKNTh3dDlK?=
 =?utf-8?B?WFNJVnROVC9FVldIVGVOSkhYTjcxODEvWHRTVERwaStHK3hKMTRFUi9uU3k1?=
 =?utf-8?B?NXdoK0c5Tk13MUVjblNsRFQ4TzdHblBaWGtIRzlXbHNJaDQvMmRKdUwzZGxG?=
 =?utf-8?B?YmR1Unlwd0RVZXRaQ1pGZWhJRG5pYit5WFdabWVPblhkSFJSZldjOTRtK2Yy?=
 =?utf-8?B?OGVzb3NPeHc4VG5nRG1sMGJVWTB6c09BMDRyZEVRME1rbHowYTZmSFVUU3E2?=
 =?utf-8?B?Q3NQUHFQV0Z5djJaWVYwSFZzV1NCTDVHMFA1R1ZxWmtJVytxdTBNSlRQZUhY?=
 =?utf-8?B?VEVoejgwcUkzQzM3c3B3ZVpYVEV3MUVhcEdZd3VCSE5wcnAxblNkOXNjeTRV?=
 =?utf-8?B?VDhmcjNYTmwwaS9QeU5PQ0VsdU9oWVhDMVFkaVVNT0FsSGNuQThnck5vV2RW?=
 =?utf-8?B?UU5JbUxwOGc1SEV0aEpKNm9tQXpBKzdXU0w4RitSYnQwNnpjZUlJRkIrcUV0?=
 =?utf-8?B?V0ZCdDRlenAwRDRBc3dCWUIyZWRLdmV2TE1FcmxLclJNMzdEczJ2RXNTTDRT?=
 =?utf-8?B?bUNrN2U0K3R5UVdkTVV5dXRFazhMajJWVFJhRGlqakFEZFlhQnJ1TDdCdlA2?=
 =?utf-8?B?YldZR0M5VE5xTTZnWE11R2JxSzN3WWZ4dm9NQTdheUh4TWJhQisyMzJPSjky?=
 =?utf-8?B?aDlWQncvbzd3YlhMc25EUWdkQXFMWlhrNi9CVGpuNmRCMjE4LzlVTk9aUjhZ?=
 =?utf-8?B?MS9yUzlzb2hwVVBMVDhPcjl5UzdybnVVcGUvSE9hREhmVTlaWVBubGFIRlRs?=
 =?utf-8?B?MWxjZlpsMXdiVWR4K3VhblZ4cm5pZC9IYjJkTTUzTVU4a1owMEkyaVc5MG9M?=
 =?utf-8?B?Qk14K0orMERQV0FJZG1rMGlDU3ZkN0VJMGJ3MTh6SXZMeFh6VnhqNVVCb2NH?=
 =?utf-8?B?MW5aelpiQ0ZNaUVONDg3dENERVJQTkFxTHR3UlFuVStQR2IvQXlQeWU1NmhK?=
 =?utf-8?B?OThoTVJpTDJhdEpjQmVFUWYvYm91YUVQbFo2VU54cWpDSkwwcWhoY09qL2M0?=
 =?utf-8?B?YkQ3QXdlNzJERnQzNUtySEEzMFVsRnY1VHFxZFg0L2k1WXVWQnZBaVd5Rzd4?=
 =?utf-8?B?aVpna3hKc2dXallHNkF3OUJyTEF6MkVWYnV3bkhEUnVUaktIdDBxcG5TS2pv?=
 =?utf-8?B?eUVZTW96YXNFTUc5WTRkeFllMUQwZlk1bzlocEdqRCtNSGk5MUR5QWRYS2JK?=
 =?utf-8?B?emR1OXhhUnNCc21odWJMUWU0ZGtHN2tReFlSZ1VwTlp0UnpxVHJYZEdOd0kz?=
 =?utf-8?B?azZ4UXZTSHBBek9LTU1ZUTlFallkS2lsa0svbTZRWEI4SXhDSWVxTmR0VEdu?=
 =?utf-8?B?dCs0aE5obU5Tb3BjaEtVNmhld3A4bjdQeFdFS3hMNmJDVEFlL2F1djRBZTJM?=
 =?utf-8?B?bGRCMGFyRUZ3czRJNEJqdGZxSy9kb2hmZ0FPeVgrRDNOK2xCeUMyR2FXTXkv?=
 =?utf-8?B?MnpFUld1TGNNREIrTXdFemEvQ2FoQy9tdTl1SUxCc2lPSzM3L3BlSHhIOXNa?=
 =?utf-8?B?RlBsdTZkMUVHTldrL0ZrY2hSYjk3cVZ2TndYYnZZOHpWZHVYVW1CUjJWVnpi?=
 =?utf-8?B?MHdQdXhDRURyNGVtNHk2Vjh3N21vNFJZckVVbU5TRTZqblhBSXE5LzlHdXpR?=
 =?utf-8?B?ZGRIam5KbHppdlZnT0ZUa1J3UDFyaXQ2Tk5SUVhybitHMVhJWXZqbWphM2Ns?=
 =?utf-8?B?WTgvWDV5WS9LRkh0Nkc0aVF0MHhZNys1S3Rxcjdlb0dtbEF0N3JqakhlVHhw?=
 =?utf-8?B?VmRMQ0twdHhnd0hxMVNxUTYzUEZXdTdkVWthQ2V1Q3FNRkNMZWQ0clVvdlRW?=
 =?utf-8?B?UFk0OG1JS3Z5WE0xenN2VGlWMGhSWnQrakUwL2ZZS2JTand3eSthcE1HQ0Z6?=
 =?utf-8?B?b3pORytiRmdsNng3cWUrbURUeXJ2bEpZdFZxak82ZXhwQXdqOStxRU1oWVMy?=
 =?utf-8?B?cENXMVZPaTdkOUxBblV6bTJyUVp2blJwMEVBMnkxYXNFbVAzZDc2VHBGaUsr?=
 =?utf-8?B?aUlza3hTTXZzK1J6eml0c25RUVV4WG9vVUVRZkNlSGhCSmJCaXZwU0xEa1hs?=
 =?utf-8?B?c2xsa2VwdHVaUlJKOC9EL0tjbm5HelRKUTNJR2lvMU1HQkk2MTBMS2ZneFFl?=
 =?utf-8?Q?MG1+48k7wSawiJ6pYLMHye2ptezcJRwu94w9cF4KQJtsq?=
X-MS-Exchange-AntiSpam-MessageData-1: 0//CVX8X2mb9rQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75531535-d2e5-498c-c2a7-08df1f62bca3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 02:21:44.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LBd1z/mTZyO54gc5Dh3CdGsA2z86m9eEY7cQamdtT7MrioErV64iPPNKg56X+wAWQTryKuHART7isbgURBy7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
> Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
> type to define how messages (independently of their type) are sent
> through the transport layer. `send_single_command` becomes
> `send_command_element`, which allocates the queue slots, writes the
> element header, and delegates the writing of the message itself to the
> implementation of `CommandElement` before computing the checksum,
> advancing the write pointer and ringing the doorbell.
>
> The RPC part of `send_single_command` (writing the RPC header and the
> command payload) is now part of the `CommandElement` implementation.
> This sets things up for moving the RPC code into its own sub-module,
> leaving the transport agnostic of the message type.
>
> No functional change intended.
>
> Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++---------=
------
>  1 file changed, 80 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index bda79f23626d..d8a7716fc500 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -35,10 +35,7 @@
>      },
>  };
> =20
> -use continuation::{
> -    ContinuationRecord,
> -    SplitState, //
> -};
> +use continuation::SplitState;
> =20
>  use pin_init::pin_init_scope;
> =20
> @@ -67,6 +64,19 @@
>  /// reply type are sent using [`Cmdq::send_command_no_wait`].
>  pub(crate) struct NoReply;
> =20
> +/// Trait implemented by types that can be sent as a single command queu=
e element.
> +///
> +/// The command queue allocates `size()` bytes after the `GspMsgElement`=
 header and calls `write()`
> +/// to fill them.
> +trait CommandElement {
> +    /// Size in bytes of the element, not including the `GspMsgElement` =
header.
> +    fn size(&self) -> usize;
> +
> +    /// Writes the contents of the command into `dst`. `dev` is the queu=
e's device (to be used for
> +    /// logging), `seq` is the sequence number of the element.
> +    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand=
<'_>) -> Result;
> +}
> +
>  /// Trait implemented by types representing a command to send to the GSP=
.
>  ///
>  /// The main purpose of this trait is to provide [`Cmdq`] with the infor=
mation it needs to send
> @@ -129,6 +139,62 @@ fn size(&self) -> usize {
>      }
>  }
> =20
> +/// Wrapper type for sending a RPC command as a command queue element.
> +///
> +/// [`CommandElement`] cannot be directly implemented for all [`CommandT=
oGsp`] with a blanket
> +/// implementation as it would conflict with other future command types.
> +struct RpcCommandElement<M>(M);
> +
> +impl<M> CommandElement for RpcCommandElement<M>
> +where
> +    M: CommandToGsp,
> +    Error: From<M::InitError>,
> +{
> +    fn size(&self) -> usize {
> +        self.0.size()
> +    }
> +
> +    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand=
<'_>) -> Result {
> +        let command =3D &self.0;
> +        let size_in_bytes =3D command.size();
> +        // Extract area for the command itself. The GSP message header a=
nd the command header
> +        // together are guaranteed to fit entirely into a single page, s=
o it's ok to only look
> +        // at `dst.contents.0` here.
> +        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.c=
ontents.0).ok_or(EIO)?;
> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M:=
:FUNCTION);
> +        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, a=
nd is not touched if the
> +        // initializer fails.
> +        unsafe {
> +            pin_init::raw_try_init(
> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
> +                rpc_header_init,
> +            )?;
> +        }
> +        // SAFETY: `cmd` is a valid reference, and is not touched if the=
 initializer fails.
> +        unsafe {
> +            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.ini=
t())?;
> +        }
> +
> +        // Fill the variable-length payload, which may be empty.
> +        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[..],=
 &mut dst.contents.1[..]]);
> +        command.init_variable_payload(&mut sbuffer)?;
> +
> +        if !sbuffer.is_empty() {
> +            return Err(EIO);
> +        }
> +
> +        dev_dbg!(
> +            dev,
> +            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n"=
,
> +            seq,
> +            M::FUNCTION,
> +            size_in_bytes,
> +        );
> +
> +        Ok(())
> +    }
> +}
> +
>  /// Trait representing messages received from the GSP.
>  ///
>  /// This trait tells [`Cmdq::receive_msg`] how it can receive a given ty=
pe of message.
> @@ -638,24 +704,18 @@ impl CmdqInner<'_> {
>      /// Timeout for waiting for space on the command queue.
>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
> =20
> -    /// Sends `command` to the GSP, without splitting it.
> +    /// Allocate enough send slots to store `command`, initialize them u=
sing
> +    /// [`CommandElement::write`], and send the command to the GSP.

nit: not sure what send slots are / seems like a new term? - I think the
caller doesn't need to understand that it's per page anyway

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

