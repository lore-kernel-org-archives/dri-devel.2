Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52E4C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AFF10E772;
	Mon, 28 Sep 2026 05:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQeycFSx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0DF10E772;
 Mon, 28 Sep 2026 05:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICp2utDpGSlN59vwPWOstGRh+ZfPMYA3a7yMYWgVzpI04nhIUzI0+xkt2Pv0B62uVSMrRCSv791cCk3wdCjUS0L3MTYbBb2zESkaZWWxIJmMZLajxfUE27xgkN57HMpiFdG8UqooK39feJW61fhrmBHdjtlqkk477DYXy9k+Z3zUD57HwDTD+JOMlu5x6cpKuv4ursShUi5eGg53rNMAr88yNPgf5AMKI+8H49wJurPf/NSEPA4MKjd2ZOwDTQGxtZCR/kXvruPMB4wQLVUJCNk5CQbdWT+hxl7rbokjOND9vKiutrsefFFvO+kLIXwiDPJPoSe8nM2OpONo5tyvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXiigj1Chx3gZTd7w7ch3jR6Cgh6A5JHeahnBZwokDU=;
 b=QFGq9jBDEIzlflNeNyQ85+AWb+0ZQ/bO0VvoxNfYJi/oK5qz9skt3yG86C9/YwAeDk2ewt8Vo1SUr0rHyHFjONFqlOIfPTbdCdnc8irorKnyAHO8t7onOp0zy4t2KjPBkuwbUQwHUPoQbf2bOwWi1UIhKgqldixSAdC2Nfv1TiI5TxhNBAW1qsW3aikde+7eou3pXkTDqoTHy22nghnHwWpyTcYQ5RKa71JJm+YXj39AtM/u2yx+OHHqjGG6W3kVn4kIbPcto4DvQub8KYC3udWDEgSZCkyIDuLTlespkDSubXY4EezTIRFtB7btY9hHSgUG+XreznAE7sdkRglgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXiigj1Chx3gZTd7w7ch3jR6Cgh6A5JHeahnBZwokDU=;
 b=CQeycFSx2XrIFKnOu02Nx7/NxfYXLhDA5d+Um4xLALzfs2P1Sh2pLZAfx4qbhpjTh3ONq8VJy1qIr2AwDd7TJ0vmTaFfmLtHWiSqdG/Ok91aTv08jsGvzwwfx+G+BLEm94gpzNl0rvB3EhS9nqymjgpRg1dobDd0ILg7SO06B7tFbEm5q1IYWyuRFr0miReSl4fBS4/gYIAgC6SePJAZ15R6/WyM8oDBMHGFonufdCCVEsUtjc4bk6ab4qWFpgkB0O1xykHE96WFU86eqEtPWusmYmTP43xcU5uUe8z3JRpE2cRSqMPuPomsLbt3dlfxRX9/PKjCkGMYK8nJnoBSrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 05:16:46 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:16:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:16:43 +0900
Message-Id: <DLQP0I37RZTD.4C52AA74ID18@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:405:379::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1321a565-11ab-4ddf-ba78-08df1d1fb107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|7416014|376014|3023799007|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XizOnlUaaE7Mn/59uv5+eF/fHkBjOS8oBs4nOzca7rpedpfTacvCElWFll++O2aUPhZfAGOlKy5RtaMtWr1keJtWlcCp9vcKPc4VA1aYB4HF2bqorxPLNaq3ZbUU/LrZn+MQfVZRJ1owDPiLMuhM3Z8Gc5d8j8Jeo93jMholS6XW2Jmiq6ZltRYxj71CGIog9boAv16ckBBS82ASCzRFLeP/aBad+H2TAc6IsbhtIrISRM2zKHCpbWgvqo4RDki9n56oYKSTzH+IrOnsejkiCMeNsr+lE4MNvAgBOe/LgASbS199LvmIia/YtRXfLpOOI+05x1MvoJYgAy4LPRKwSdsS7zIgkccUcTk6AsgqGvUH5qQla/og5xYdikjoaOtI+blNZFdr4KesLa0zSdAbXgFaQD2aWBmx+A9QtPh8kV56DZZHrxuzNNbcCVEiWx8R4b60p+o6NgDw2OWji+BBkurrcx7ED8U+koWcOjlfHSC6EVjOQ1ojT5tf2AvRIQ3gO1dWXcjFAswT6aMR6tWH40qYqLNv1uDMNKyT+jblYM7antTRL9/b4E5YMb1Ku84fXXQHErEv1UYJLIdKK5XtNeWJZI0fCxa3PTI0ci3d/fTuXBHG7QvscPmSxy/YkMl0KezKsr0DmVKwLfflQ1O0GutMoXo+NpvPjPFMJo1K1to=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(7416014)(376014)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1hLUGhndVFXb0Jrem11UjBJSS9BZEdqQWVYdGFZMW01aWVNMXZQT0RsZS9r?=
 =?utf-8?B?Wm0zQVZRQWU2L04ybXlTTVdYUUQxWXVCeWxIT3RTYU1DWElTZE1ZbGV0anJE?=
 =?utf-8?B?VUpPVWpXV3JrU1lTOVlFVG5GbDFkdTZNU0pNN0RiamdjVldoaU8vUHcySUFh?=
 =?utf-8?B?VWxncmU0T0czcWZhOFZZZ2QwQldnZE5wQXJMRVNNdW0rQ0lPc2M4dUpKdkll?=
 =?utf-8?B?TG5TV0hQeU5RTmEwaFZQcVhITEx3NWhPZDYxaCtad3psU0lmaEx1c3h0ZnVK?=
 =?utf-8?B?TWZzRFdkdFFwR1hOSVd4Y0VzTmVDVURQQ2ZwUS9lODdsWU5mTUVNc3hzZE9y?=
 =?utf-8?B?Ky9JeEJpSHlnYzRYa2tDeXJuMGhqSWR1ajltNk1DcmdhR1RIQjZScjRwTU5P?=
 =?utf-8?B?VjlZWGJtdFA3V2ZUbTF0TzZUd3dvUEwrVXo4dzNYZmJIOXVERDdwMnBPQlhl?=
 =?utf-8?B?TEJLK1pXOHlTenlHY3preVRqcUlkMFVjNVVBdURhdFA3K3VTWFJRUEZzRmhI?=
 =?utf-8?B?RWNGdUpya0QyTFliR2NRQ3A2Wkp0eHZjaWhIOTBRMDdkUm41LzVOUVBEQWl0?=
 =?utf-8?B?SndwY2lTWWxrQ0hFTUZwYlVWNDZlODhHVW9NbG8xV1YyL0RyTVZEOWZzRUJN?=
 =?utf-8?B?elIzU2FCQ3pEVlNGWE1ESmVRR3QxNXgxTWUyczVkQ04xdGI1ZHpZVEdxWVM2?=
 =?utf-8?B?MWJXYk9HemROVWRqV2pFZ3hYaEl6djFUL3ZEdUZHTFQ5N1BLVEpkRUZkVVhN?=
 =?utf-8?B?Tkl2K2xGUXpRQnJGbVN3aURHbzVYbStsdUllN21VWGF0QW1SRkNDTnk2dXRt?=
 =?utf-8?B?SWcrNW1jVXFpbVY5YnVZcld0RmVkeVcyZndPeFNYYWg3UkJpMGRhLzFXMElX?=
 =?utf-8?B?R0lYTHBZamZtN3hRLytyb1c3c2VSTlUrbThVVnJlUFQxRjBneURrOGRmZCtn?=
 =?utf-8?B?SVdoeHVjOW9ZekVvckRrRWJzTkwxUjNKK2x2Z2hrTWhVdmxZdjRLbEdXbVdF?=
 =?utf-8?B?dnQwemhMV3NLZVMwTi9oQWhVNmJlVGpEUGRsSVVpTndVdDB1dDFiT2hrUkxT?=
 =?utf-8?B?NzZNNm52MDhsK1dUREp1MkU4bUNkY3doNnIyQlhtQk1ZbDAyNW1xZGFJZzNP?=
 =?utf-8?B?YzIzRmNqUXlYQW1XWUpOSGY2eksycVBUOHZjTmpKVDZReUpBMmNtVmcxQ2pO?=
 =?utf-8?B?T0RJL1ltbTBoUWlqWEk2SnhCRmNPalljS2ZpZ3g3aUdsS0lGY2dxVzJSajNw?=
 =?utf-8?B?QWZsV1FWMTRLeGhISUV4a25vYmZ5VUtieFdiNkpFRWEySURkY1VtVDVMTi9u?=
 =?utf-8?B?MkY1WGxiZzZqRHhyUHdyVC9CcEIrcjN4aHRqckpxZDJuRUowcmlIY0xlblBN?=
 =?utf-8?B?eWlmL0YwMTkzY1JqMURoV1Z1NFA0WVNudElqdFE4ZWtOaEtSOGNER3dCaUo3?=
 =?utf-8?B?RUpDSGNUWFRZRlpaazJvaXFOWHA5KzVISVY0a2ptb0M0bkNxUnAxU3YvU292?=
 =?utf-8?B?aFdqMlBFdUZOUml2TS94V0FWVnAvVlRvMGg4UTk0QTJ6RDdzdEh6ZlJRYm9Z?=
 =?utf-8?B?YXk3c096d25MS3E0Wi95MVF3Zi85bWtlYXcrZFNIV05GQWthaEtUZFYzWjNT?=
 =?utf-8?B?Mi9WRlFvTUdLb1BvMm85WHJtNXhuQWN2Q3llc21Ea0ZieEVsZkwzU1lvS1kr?=
 =?utf-8?B?Mk9ENXJGVFZGNnpSVWtXbWY0VWFFcU1aVFFBN3FqaFd2RmphdW1TMXg4bldV?=
 =?utf-8?B?L2Z6ZEtRMFBHckw4aGJtaVMzQ1JneENjb295SFFXTnRleHdrblJmcXR6V3BD?=
 =?utf-8?B?MmVBT1lUV0VuU05PcExHKzFVY0VvcFIwak9tVzNPaDB1VW5QMU5MMmE1ekRk?=
 =?utf-8?B?NFA2cGZCcHJmZVl5b1B6cU5iZGNMRUdFRlJCVTBtbENkcUFNUkVwNXZWaUtu?=
 =?utf-8?B?TkZZWDJxTlNLZ2lzaUpFSHFzL3NZWFJGS2duUGFYd1ZJRTR2bVpkZDFVMGJj?=
 =?utf-8?B?UmxIMVlrMmZpVFp5UGtqSStFRWxvZjQyNXNOOHNVWlRobHB4aXc3eHp5ekpD?=
 =?utf-8?B?MGE0T2lFWU1JM1VJNGsyUW91bTdtUS9JdkMrQ2lLbHJONlp2TlVHSzE0YXNU?=
 =?utf-8?B?U2J1T2IvbzlSaitKdVkrS3diSXZLQmRhdkRzd1gxWDZaazVKZDR5aHllTFZn?=
 =?utf-8?B?bGRYWm1GWjdOcDBPNXhuWWoyVEJrcGFEZ3UwVTVzN0dtL2cyTjkycnA1U1FL?=
 =?utf-8?B?bEw5ZnJoTjBYaHA3a3VQbUlFa296QTVET2VsdUcxV0REdGNLUlBMK3YxWGRR?=
 =?utf-8?B?RWpUUk1meHdPNUNTQUI3aXQ0enlsY2lRbHpjZGdKNDVsMnBIajR6N0NxQVQv?=
 =?utf-8?Q?YzKNFBP9J11i6TX8WZD/wzrQhBxKEhLkAbixLcgacKST0?=
X-MS-Exchange-AntiSpam-MessageData-1: NqSZhEd4/Cafgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1321a565-11ab-4ddf-ba78-08df1d1fb107
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:16:46.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAKI1/d191+LxvZdYl8FZZBR/b+H1s1AV42RB5if04+j7GBatjOYyQ2oOnVHbdjM1WPVV0JTPLpXMFvPn0mfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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
> Move the transport part of `send_single_command` into
> `send_command_element`, which allocates the queue slots, writes the
> element header, calls a closure to fill the remainder of the command,
> then computes the checksum, advances the write pointer and rings the
> doorbell.
>
> The RPC part of `send_single_command` (writing the RPC header and the
> command payload) is passed as a closure, unchanged apart from its
> indentation. This sets things up for moving the RPC code into its own
> sub-module, leaving the transport agnostic of the message type.
>
> No functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++++--------=
------
>  1 file changed, 74 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 07e8e32c3d57..b6d50b0bd039 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -638,65 +638,35 @@ impl CmdqInner<'_> {
>      /// Timeout for waiting for space on the command queue.
>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
> =20
> -    /// Sends `command` to the GSP, without splitting it.
> +    /// Allocates enough send slots to store a command of `sizes_in_byte=
s` length, initialize them
> +    /// using `command_init`, and send the command to the GSP.
>      ///
>      /// # Errors
>      ///
>      /// - `EMSGSIZE` if the command exceeds the maximum queue element si=
ze.
>      /// - `ETIMEDOUT` if space does not become available within the time=
out.
> -    /// - `EIO` if the variable payload requested by the command has not=
 been entirely
> -    ///   written to by its [`CommandToGsp::init_variable_payload`] meth=
od.
>      ///
> -    /// Error codes returned by the command initializers are propagated =
as-is.
> -    fn send_single_command<M>(&mut self, command: M) -> Result
> -    where
> -        M: CommandToGsp,
> -        // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
> -        Error: From<M::InitError>,
> -    {
> -        let size_in_bytes =3D command.size();
> -        let dst =3D self
> +    /// Error codes returned by `command_init` are returned as-is.
> +    fn send_command_element(
> +        &mut self,
> +        size_in_bytes: usize,
> +        command_init: impl FnOnce(&mut GspCommand<'_>) -> Result,
> +    ) -> Result {
> +        let mut dst =3D self
>              .gsp_mem
>              .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
> =20
> +        let seq =3D self.seq;

nit: this local reads noisily to me

> +
>          // Fill the header.
> -        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_b=
ytes);
> +        let msg_element_init =3D GspMsgElement::init(seq, size_in_bytes)=
;
>          // SAFETY: `msg_header` is a valid reference, and not touched if=
 the initializer fails.
>          unsafe {
>              pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_=
element_init)?;
>          }
> =20
> -        // Extract area for the command itself. The GSP message header a=
nd the command header
> -        // together are guaranteed to fit entirely into a single page, s=
o it's ok to only look
> -        // at `dst.contents.0` here.
> -        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.c=
ontents.0).ok_or(EIO)?;
> -        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M:=
:FUNCTION);
> -        // SAFETY: `rpc_header_mut()` and `cmd` are valid references, an=
d not touched if the
> -        // initializer fails.
> -        unsafe {
> -            pin_init::raw_try_init(
> -                core::ptr::from_mut(dst.header.rpc_header_mut()),
> -                rpc_header_init,
> -            )?;
> -            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.ini=
t())?;
> -        }
> -
> -        // Fill the variable-length payload, which may be empty.
> -        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[..],=
 &mut dst.contents.1[..]]);
> -        command.init_variable_payload(&mut sbuffer)?;
> -
> -        if !sbuffer.is_empty() {
> -            return Err(EIO);
> -        }
> -        drop(sbuffer);
> -
> -        dev_dbg!(
> -            &self.dev,
> -            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n"=
,
> -            self.seq,
> -            M::FUNCTION,
> -            size_in_bytes,
> -        );
> +        // Initialize the message payload.
> +        command_init(&mut dst)?;
> =20
>          // Compute checksum now that the whole message is ready.
>          dst.header
> @@ -715,6 +685,66 @@ fn send_single_command<M>(&mut self, command: M) -> =
Result
>          Ok(())
>      }
> =20
> +    /// Sends `command` to the GSP, without splitting it.
> +    ///
> +    /// # Errors
> +    ///
> +    /// - `EMSGSIZE` if the command exceeds the maximum queue element si=
ze.
> +    /// - `ETIMEDOUT` if space does not become available within the time=
out.
> +    /// - `EIO` if the variable payload requested by the command has not=
 been entirely
> +    ///   written to by its [`CommandToGsp::init_variable_payload`] meth=
od.
> +    ///
> +    /// Error codes returned by the command initializers are propagated =
as-is.
> +    fn send_single_command<M>(&mut self, command: M) -> Result
> +    where
> +        M: CommandToGsp,
> +        // This allows all error types, including `Infallible`, to be us=
ed for `M::InitError`.
> +        Error: From<M::InitError>,
> +    {
> +        let dev =3D self.dev;
> +        let seq =3D self.seq;
> +        let size_in_bytes =3D command.size();

I suspect if we pass dev and seq into the closure below, we can
further split the RPC layer from the transport layer. That means the
patches after this won't have to impl on CmdqInner for e.g.
`send_single_command` and instead we can just define a trait that writes
in the message layer data (so send_single_command could e.g. instead
take an impl RpcCommandWriter or whatever, and we can impl
RpcCommandWriter for anything that impls CommandToGsp, inserting the
message layer protocol stuff in there).

