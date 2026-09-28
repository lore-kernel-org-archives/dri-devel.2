Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE3CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE34B10E092;
	Mon, 28 Sep 2026 11:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="svj3jU/s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B0110E092;
 Mon, 28 Sep 2026 11:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEKE0VZrHneNtZR07MOetu7C4fXBctC9OzFx6UoXt5zNzBRcOq/MCIlkgPBSST8dP9UpLyKyXBAYVfwREAM9mEyzfxXtuKyG2SR+qSV3LfnZ5SOdDp5ETQDqKgDEoX9cWSphtASvMMdVIJXWHQAkC9cs7xHl9+e79Bud7EY2jd52CjGiQd8Ukd8V2wAAZL3K/m/wwBmaQiPzP4P1Y2JfymL3Cjtod7vBjBk5ri+o/EaRRJnu7f2dt+wgVKW/9rImDtsRz1ox3VoYVwUWoJD9IZgeVSOyM1nRciH5hut/2/E2xqoqYtHRj7PynYbz6tfpxZ7XvOZgfONvvLLei+11yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2wwws7KLKWMdV43RJQgyOwJaPVN9HoujQtl8P45k/w=;
 b=YIIeAxdf+zBBt1lUPQPK91DGr/IFtfWeKqQpVTkPN5RZq5IKJz2d6GKSlfdkLUmnzyBsi8YQtBKcerjoaxk7eaxDMHkHYsKohe0dtFLW7/1xIObbucncie4uMYf0nooQlC1uiNeTH6q95e9eL/lf+8kcbXSZnLLq31Mt12gsbyg1xx2vJ1YEjYapN6EDUXpoiJrggM+S7sAmSuBxEbfu5oDXVRk+LXT7HLUwhkG6hLV2rXk4FA7+lZ3qUe37/tkgbFnzfdBddiwFsfOfOlZpA5OjDS1h8vRegOIUGqRWEO5uEWfnr4EGsAKCXA9peIMbkWpHFck30CAtGgnNTztQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2wwws7KLKWMdV43RJQgyOwJaPVN9HoujQtl8P45k/w=;
 b=svj3jU/s3GytCNy4M6j7I8PiOxibrD5S8zUR5hN46rDDiYyxWvSDmbaQWMw0jB/HZiPo/MwOri7N+xyacBVOJPbvChyE+2MyIEYPRYcRQk79RxJxr87u80EDQaS0/PcjReFyIxZyOd2HIe0OMZbSVJ1shXyLay6nFiJnG9sOm8uUeroHR0QVQaF5HWGrNYsiAy5qgjmJbRqbJ+pgt2Pql/BH6cPkm8QP8PSqIg8pN8ChZ/9+eNC4lhv/mVyAPsFScFVbwJn95jHOwGnAT7MtFx2CoIEUuRiZqu59fCruZHsssGfirIGQwi0Lu6zAMbhykZ9ZDgd1T/H6bmAeeM72hA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:35:46 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:35:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 20:35:42 +0900
Message-Id: <DLQX2OJHU8Z5.1349KUKXXCLWJ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/9] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
 <DLQP0I37RZTD.4C52AA74ID18@nvidia.com>
 <DLQQCJRLIWXA.32C5JK2QOGGTW@nvidia.com>
 <DLQQSPX5V4GY.8G8ZVQXV6WQ8@nvidia.com>
In-Reply-To: <DLQQSPX5V4GY.8G8ZVQXV6WQ8@nvidia.com>
X-ClientProxiedBy: TY4P301CA0094.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b46447-069e-4c59-22b7-08df1d54a284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|10070799003|366016|1800799024|10067099003|11063799006|3023799007|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9Tk7Zf0MO516yH2pQqvVk1pGYUQo2J4gLjnAekNMfThKhDAcNkdnkvqe/BtVlgTRkktshfo0Dhe8Dilglet1vv35If8ueY7twr3Swi9ETR9oIVmiG69V4Zto5SC8S/y8lhZwvdJt3ObABXBT+Wd43q0U/qj8WSKFwNE/pPRYLleJ7BMKAWdf9eBiThYUktABIhUkTavgvXINIdsw/b0bylDRbNaO/JdvVb4SSylSCC9+yX7dBy7e/BdjOjp6Du3wAASl8W+8lbbJny4TZBTJ1WOdxHIleeg4DTf5pkUmJYD5FctlwwKZ/Szyk57+4eKbV+98oU1zRJU01T+9q2dMNYC5Z7T7n941jtBoVDuBqAhKM6M2B5blK+zTdT5T7h77eM5DPpfbkvi0l7EilqmvvxKaJiTjGu3x3BrfNx3SrebRB1/NbdRtLoFuVXYA7ddH8b35G8KmV9pY6k2AiYW4MnKGVCN5xM4Y4KWDaOSdZQXWkB/3DwSfnteb473/hggAb7vZhHKrWPVjdYoFnDfckB5OfYDwfm7DyQR2KvGRqc/wkHnNESU7Ptz05oPkals8Klgwp45TU8zfgP6G68WluZ68P3FXJcz6ZLac5qZmd2G9WLRTz5enfPcQHglk5rWAuhNPUpsVsvTrDQ0Hli0M+Z9lKUpJi6+orKA/dVthrMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(366016)(1800799024)(10067099003)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWsrcHk5SGorR0dTZ3BqK2VNZVl1RkpuTW1GaDIxZTg3MnNPRmlHT3RxV2R4?=
 =?utf-8?B?K2VoQUI4VDdTYjRzQnJJWHI2d3dUcEorR0s3NHVGNUdUL1VlRDdwQi92bG9k?=
 =?utf-8?B?VGhjK3FSTWxGSVU5VFhRektRVzRJYU91TE5oY21XNnJ1bGVzdGNtK0NzYmxp?=
 =?utf-8?B?WDF2VUh0YkZwWjdpc2pWaXlpKzM0eHN3TUpYTitQeWJMYldiZEtHa3hBL2Yx?=
 =?utf-8?B?R1c4QkQ0blFtRXhJTzhXOEw3Tmlsd3IvMG8rWWlFbDFsUmhyeWRXNXpDNlps?=
 =?utf-8?B?ZVJhRnEzbzhjTzE0aFJwOTVhNnVBMGNuN05vMEIyTGtLSlhsM0tLZityQW9l?=
 =?utf-8?B?ZDhpTTRqMGZTR0FPcUUraUtBcmtKdlBwVi9VcUZJYXdTbzgydEc3MmsvWUF0?=
 =?utf-8?B?NXFwN3dHZUNRMnpOU2RzamxwSWFWdysxUFVncmsxSWgwZFMxQ0VzYmtEVjlT?=
 =?utf-8?B?d2xkdzBnRGs4ME9vbEJ6MVN0ZkxUSnpBTURxVDZVT2p0d3VhUkl3N0x3Z1pv?=
 =?utf-8?B?ZnRrQ0phdnVYUEZzMlozVWY5b0MzbkRDQWJpOW8yK090M0l1YlZ4Mm54NUt6?=
 =?utf-8?B?RDY2QzAvc05YRVV4QThDNEk2eE5ydEJnMVEvaEZFSGc2dU82MW84M2RaWERn?=
 =?utf-8?B?Q0gvay9kZUw2aEpFY1Jtai9Xc3FONnk3QXNWZUJFalJCVEJUZHFPNTRGZlN4?=
 =?utf-8?B?Rm9uKzl5ZDJ0MVRjeHE1MEU0MW9iWk9yeXprQUpWS0R2bHRhTlhIeGJyK2pn?=
 =?utf-8?B?WjFFZnVsaHpUUVVKdjFtc0RVUnlkZWM5RlgzY3RMaUU3QzF5YkhMUVpiV0ov?=
 =?utf-8?B?M3J4cHhVWlZNSS82eEREeHdHTFFGN0FwSnRlTklmR201SkxTcVgwVThXQi8x?=
 =?utf-8?B?eGEwL0hwMnRPOExlNHNYb1VFdXBoMVVzWFFaU203bERrYmNjL0t3anJIRXBr?=
 =?utf-8?B?b1hsSmZORmwxTmZNY29WcU5GOGdieFFacjE1YTJVOU1jUUJzWFJtS3NYdGQ1?=
 =?utf-8?B?S3ZENHk0dEpDQldpWm9scnRtRUwxZnhsalY0TFkyUGgweXAxNEU1aGVlQnB1?=
 =?utf-8?B?RU1CM1BUSEliSjFGMGhjR2QzQzZLZ3VqVE9vd3EwbEVOT2tJWUNuS05sSVBs?=
 =?utf-8?B?K1NsbUJqREErUklmeUFtU3BnODF2eFFpY01zUnJOUXg1ODNpQVJPYmhtb0FJ?=
 =?utf-8?B?YkJDclgzRU1KbzVFSlk2YWFUOWpkeEJ4TWxQRDNRdndBZU16VWdrQWtXSyts?=
 =?utf-8?B?ZzlpdzNtSHFPN0ZIQlI3Ny9CZHpjNjB2cS9qNFcwR01FNmRVWTczT0ZaTlZ0?=
 =?utf-8?B?RitKUHFQcnQyMXMydEdRS1d0SERQT0dFQWRkR0Q5SGR5b2pPNzB6MENRNU5a?=
 =?utf-8?B?ZnAvZGpJTWZtRVJXVDFIbTBXU0wvQzJXQ3VjeGFCNFVuUnQyTVo0VzZQQWRV?=
 =?utf-8?B?cTN6bWhZQ2N2clFORUJsaWxpZHpwS0pUSzN0OTJiWlVxOU9RNlZtdzY0SDVx?=
 =?utf-8?B?cVZBdytYbFF6YkdDMDNiWUJnUlZaRGViNHZrTmwybEZJeUhaNS9vQ1NnUlFQ?=
 =?utf-8?B?dllIRGJOaFVkOEdPZXNmNXhqSktwL3JqQUMwVUVvVlFTMHFnNlVGRmJKcDIr?=
 =?utf-8?B?emFZVzhNNmI0dk51RXRKRE13K291VlAvVlZsY1dTd1FZeXF3RWhlWXpYUklj?=
 =?utf-8?B?YSt1Mml6YTVNc1loYnM1Vy83d1ZLQ254M25YMi9rVUhROVgwZGtueStyQW41?=
 =?utf-8?B?OGhGWmRBSWQrVFdleGNrZElIZGtEVzFaRjlXMGp0SEs3ck1qc0FyaklxQ0JF?=
 =?utf-8?B?Uk0ybmQ2ME5zTmlPMkRNZU5kZ3pERjBka0ZIY0ZtSmYrZ3RQRkh5TGVRY0hm?=
 =?utf-8?B?Zk5aZDRSMkV5TjYrMEpEejZGWWRIVTVnZElKT0tPVUVTK0N5WDZTMG9LYnBY?=
 =?utf-8?B?VzJpTGUyOVlwQzVYc20ycGoybWJBajgxaWFkY1Y5NmpVZDdobmJEZVFqZnQ0?=
 =?utf-8?B?NEJVdk5GcStJQVdGKzlyMlVlcDFaWENCWkl4NUxEaEtOYU8vRkFrVDRiTHhN?=
 =?utf-8?B?L1BUdjBwakcrUnU3T0dLSEl0R2Q1NGhDQ3RUazZJNDVVTE15V2lWQzZWUFV0?=
 =?utf-8?B?ZVpudnhPODUvRlpvTW8yaWxCZko1ZnhqV0Mra2lHRFhHK3VFS1BFNGc4eEZF?=
 =?utf-8?B?V0U5ODUzajdqTXF2Y3RySGkrYW9FNm50MHpEUS9kekZEVGpIRmQ3OWd2QzNr?=
 =?utf-8?B?dUJoRUZ4cjN4cU96TWYzWW9xWTdVYjFWN25rb3c1SVFsWktvWU12YzRZbnd1?=
 =?utf-8?B?bDE0UFpjTzRtK3Vwcyt3VitydmpsMnljdHJPSEhKUDE4WjZ6OGJZdDRKVmVR?=
 =?utf-8?Q?CSjuzjDTiTebltm2I5b29bPsLV2ofoeMOivW8d7YesCoC?=
X-MS-Exchange-AntiSpam-MessageData-1: XZ4xlWGTUFXE8Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b46447-069e-4c59-22b7-08df1d54a284
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:35:45.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYA5EuFKalq3IZwGZR0Z9ysXXyfZr5ldp9dZGXWXJrdCXr4dWEwmKCpXRnXHJa+NbmkmkrQZ6L6x9oAPCkVMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

On Mon Sep 28, 2026 at 3:40 PM JST, Eliot Courtney wrote:
> On Mon Sep 28, 2026 at 3:19 PM JST, Alexandre Courbot wrote:
>> On Mon Sep 28, 2026 at 2:16 PM JST, Eliot Courtney wrote:
>>> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>>>> Move the transport part of `send_single_command` into
>>>> `send_command_element`, which allocates the queue slots, writes the
>>>> element header, calls a closure to fill the remainder of the command,
>>>> then computes the checksum, advances the write pointer and rings the
>>>> doorbell.
>>>>
>>>> The RPC part of `send_single_command` (writing the RPC header and the
>>>> command payload) is passed as a closure, unchanged apart from its
>>>> indentation. This sets things up for moving the RPC code into its own
>>>> sub-module, leaving the transport agnostic of the message type.
>>>>
>>>> No functional change intended.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++++-----=
---------
>>>>  1 file changed, 74 insertions(+), 44 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core=
/gsp/cmdq.rs
>>>> index 07e8e32c3d57..b6d50b0bd039 100644
>>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> @@ -638,65 +638,35 @@ impl CmdqInner<'_> {
>>>>      /// Timeout for waiting for space on the command queue.
>>>>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
>>>> =20
>>>> -    /// Sends `command` to the GSP, without splitting it.
>>>> +    /// Allocates enough send slots to store a command of `sizes_in_b=
ytes` length, initialize them
>>>> +    /// using `command_init`, and send the command to the GSP.
>>>>      ///
>>>>      /// # Errors
>>>>      ///
>>>>      /// - `EMSGSIZE` if the command exceeds the maximum queue element=
 size.
>>>>      /// - `ETIMEDOUT` if space does not become available within the t=
imeout.
>>>> -    /// - `EIO` if the variable payload requested by the command has =
not been entirely
>>>> -    ///   written to by its [`CommandToGsp::init_variable_payload`] m=
ethod.
>>>>      ///
>>>> -    /// Error codes returned by the command initializers are propagat=
ed as-is.
>>>> -    fn send_single_command<M>(&mut self, command: M) -> Result
>>>> -    where
>>>> -        M: CommandToGsp,
>>>> -        // This allows all error types, including `Infallible`, to be=
 used for `M::InitError`.
>>>> -        Error: From<M::InitError>,
>>>> -    {
>>>> -        let size_in_bytes =3D command.size();
>>>> -        let dst =3D self
>>>> +    /// Error codes returned by `command_init` are returned as-is.
>>>> +    fn send_command_element(
>>>> +        &mut self,
>>>> +        size_in_bytes: usize,
>>>> +        command_init: impl FnOnce(&mut GspCommand<'_>) -> Result,
>>>> +    ) -> Result {
>>>> +        let mut dst =3D self
>>>>              .gsp_mem
>>>>              .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?=
;
>>>> =20
>>>> +        let seq =3D self.seq;
>>>
>>> nit: this local reads noisily to me
>>>
>>>> +
>>>>          // Fill the header.
>>>> -        let msg_element_init =3D GspMsgElement::init(self.seq, size_i=
n_bytes);
>>>> +        let msg_element_init =3D GspMsgElement::init(seq, size_in_byt=
es);
>>>>          // SAFETY: `msg_header` is a valid reference, and not touched=
 if the initializer fails.
>>>>          unsafe {
>>>>              pin_init::raw_try_init(core::ptr::from_mut(dst.header), m=
sg_element_init)?;
>>>>          }
>>>> =20
>>>> -        // Extract area for the command itself. The GSP message heade=
r and the command header
>>>> -        // together are guaranteed to fit entirely into a single page=
, so it's ok to only look
>>>> -        // at `dst.contents.0` here.
>>>> -        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(ds=
t.contents.0).ok_or(EIO)?;
>>>> -        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes,=
 M::FUNCTION);
>>>> -        // SAFETY: `rpc_header_mut()` and `cmd` are valid references,=
 and not touched if the
>>>> -        // initializer fails.
>>>> -        unsafe {
>>>> -            pin_init::raw_try_init(
>>>> -                core::ptr::from_mut(dst.header.rpc_header_mut()),
>>>> -                rpc_header_init,
>>>> -            )?;
>>>> -            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.=
init())?;
>>>> -        }
>>>> -
>>>> -        // Fill the variable-length payload, which may be empty.
>>>> -        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[.=
.], &mut dst.contents.1[..]]);
>>>> -        command.init_variable_payload(&mut sbuffer)?;
>>>> -
>>>> -        if !sbuffer.is_empty() {
>>>> -            return Err(EIO);
>>>> -        }
>>>> -        drop(sbuffer);
>>>> -
>>>> -        dev_dbg!(
>>>> -            &self.dev,
>>>> -            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}=
\n",
>>>> -            self.seq,
>>>> -            M::FUNCTION,
>>>> -            size_in_bytes,
>>>> -        );
>>>> +        // Initialize the message payload.
>>>> +        command_init(&mut dst)?;
>>>> =20
>>>>          // Compute checksum now that the whole message is ready.
>>>>          dst.header
>>>> @@ -715,6 +685,66 @@ fn send_single_command<M>(&mut self, command: M) =
-> Result
>>>>          Ok(())
>>>>      }
>>>> =20
>>>> +    /// Sends `command` to the GSP, without splitting it.
>>>> +    ///
>>>> +    /// # Errors
>>>> +    ///
>>>> +    /// - `EMSGSIZE` if the command exceeds the maximum queue element=
 size.
>>>> +    /// - `ETIMEDOUT` if space does not become available within the t=
imeout.
>>>> +    /// - `EIO` if the variable payload requested by the command has =
not been entirely
>>>> +    ///   written to by its [`CommandToGsp::init_variable_payload`] m=
ethod.
>>>> +    ///
>>>> +    /// Error codes returned by the command initializers are propagat=
ed as-is.
>>>> +    fn send_single_command<M>(&mut self, command: M) -> Result
>>>> +    where
>>>> +        M: CommandToGsp,
>>>> +        // This allows all error types, including `Infallible`, to be=
 used for `M::InitError`.
>>>> +        Error: From<M::InitError>,
>>>> +    {
>>>> +        let dev =3D self.dev;
>>>> +        let seq =3D self.seq;
>>>> +        let size_in_bytes =3D command.size();
>>>
>>> I suspect if we pass dev and seq into the closure below, we can
>>> further split the RPC layer from the transport layer. That means the
>>> patches after this won't have to impl on CmdqInner for e.g.
>>> `send_single_command` and instead we can just define a trait that write=
s
>>> in the message layer data (so send_single_command could e.g. instead
>>> take an impl RpcCommandWriter or whatever, and we can impl
>>> RpcCommandWriter for anything that impls CommandToGsp, inserting the
>>> message layer protocol stuff in there).
>>
>> That sounds like a much better design indeed - I was contemplating
>> introducing traits and thought it might be better to keep things simple
>> and revisit until r000 is completed, but it probably won't be limiting
>> us in any way, and removes the unneeded mirror methods in `CmdqInner`.
>>
>> The same pattern can probably also be applied on the receiving side, so
>> I'll try and do it there as well.
>
> Yerp I think it can be. I also don't think it's bad to keep the trait
> around even after we remove r570. If we are passing in closures anyway
> to cmdq to do message layer stuff, that's kinda like an unnamed trait
> anyway. Thanks!

So it came to a surprise to me, but RPC will stay even after r570 is
removed (although it will only be used with vGPU IIUC) - that's actually
the main motivation for this design. So the trait will have more than
one implementor even after the switch to r000.
