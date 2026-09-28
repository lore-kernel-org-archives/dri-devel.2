Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32850C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4843510E403;
	Mon, 28 Sep 2026 06:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QghSC15Z";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFBB10E403;
 Mon, 28 Sep 2026 06:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAHK5pI0f5ReOqcZGrRFcju6pVyVbzYnW0QmynGbz1EunrBp+Lj2WSi3hK9+YEjomBmZwQWSI1ODKlcBbDyVXmjqv8J6eUVZ496iBFdfy4mfg6TCayePRQjUX6yb0YT2100CJrFVn2FrBrtqujh8eTV4kD5A7TK1v3PcW5a+Z6HmBv4+uhNNReFxCBbT06FNZ2NY3noeubiLjHdjOV54S8l9a7Gebqxd6+wF368q+llopHG6HEvFut/zOKTEOEjbcZE/+hMJ+UoRpRibRMyJbPnNoVrZyM8rIwRL+YIHmYc+hWJ9hJgOoeEnHvl6ksBykZDL0JK43YR/macBkScM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4LTSZWMKxCxrSZVc1n43vX0ZJfJlK7OPaNWx9ZGoiI=;
 b=gT9xMD3tc/KvpWn/vBo1uk3eG4jyVED61+hLON1jjZL3yBteRsKdDTaWn49HlUGMnAQsbxzX0Qoy06DyXakhtwlm1GtUVk0wwLsLMprYCF2Ny3GI2T5Fb4Qc0bd1inhQFbyFNsSWNVU4LEkB3SsTu76HdMAVdeu9OmIdVsS42Sazw/jqhYVt5tbRVleK7J4qQsuikgiqWMehlXGsE4ykzhUQR6yPuIZZiZXjlW9zDCPFu4suMPYid6RsO7tT4ZZb7UMYgtXi3BaTOcPt3uXc33nYSxbr3wuYbGb5GnYExXtWK/hCAR8r+SLuCmobqvHr5Aus+G3bDIYqSRRbe579kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4LTSZWMKxCxrSZVc1n43vX0ZJfJlK7OPaNWx9ZGoiI=;
 b=QghSC15ZqQJXNBOwoPVCZ11oaumn40mDk/XzqzwyN0c36WENiHpMkg48zqetFWbhDwv4HLJtKnnUbcnF/Dwt/miiPxQRg52uG0kNj9TrjeKHScycSsqOxLOeTz8kDNJp9T6VIFTuSatdxzqzWKU5IvxWy5ooi81lKxyGa5m9FNJK9Yg5HencD3Vj6QdeFXWx8H0j7c1dTOwUECvkdCKCFCLqroVE4n9MvINXWh8N9YPMcWebP5xAwerj+JqURk2kgxpBq4G6N69tZgdcqTMoiy1EYXWVVMAIzAPmfhRZ27+zqmoZKWfkAeLt37F8+jjpAHU3lly3CpFr/bSy+K3ZzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 06:40:40 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:40:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:40:35 +0900
Message-Id: <DLQQSPX5V4GY.8G8ZVQXV6WQ8@nvidia.com>
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
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
 <DLQP0I37RZTD.4C52AA74ID18@nvidia.com>
 <DLQQCJRLIWXA.32C5JK2QOGGTW@nvidia.com>
In-Reply-To: <DLQQCJRLIWXA.32C5JK2QOGGTW@nvidia.com>
X-ClientProxiedBy: TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b478ddb-247a-4f86-2de8-08df1d2b68d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|3023799007|6133799003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dLH9lYwqIy2W/9ayFygRJNyr/LqxFxttsHTP/hCJghO53saYGThUTZ6WWlTg9+pR1O8bUrDzkgy06n2BTcxRh7erhPEqoPipebtcbLwahJddq69kthbS68Uv5tkTedNl/EMOkfnXV7S2uZDFHFhYxP+Nr+TEXFk37MeXJaoHsb4oDDBMJX5oqelBKylPz7ccUmu01ipq3yIS8A7LCV8EaiHZYesnJ3+e3QnZYdCQY+ZpETNb+ryHRbtXOnHCiE0XkjlzZ5Vwyreur5d29kOaCKKWeT6IuSi9XU8Itt9/G1iBP8ZkEZUK9Kcbl4NktYmwhwmXUjC3vLQ2NztMA6qpqq+V7axneitffeTMAuqJKjiKucffkAMe5bkS/WP3Yf25U0xzfWsSItM8gwoQ2axNzJUteU4sqn8uKHsAFCKCYeUiRvexgJrkuthjdQyNugg2zCmxhbhmaTBx9ZxMNBoUs87gRzIsCJAxQMoK3nYcnPcw+5w00YbTtSdG7lOgEU7sD0ETDoCNWVgbQR0o8iiyXpzanFHtHxJhYdxs+8QHTXAq46ULv0E+c6mVV6uS8ScoYPJHGUvERAOoRryXLXEGJMMf1hskErU5IrTpd210HARrNHIadCLzqcX11u+bmoDcQQUx3NNu3D6l5imyA/4zon+mUwD25zTZuEJVbXsmMRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(3023799007)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDN0K3RGNWxSMHJHTXZ0RktLZlM4amNCS1VIQUVjeFRqdkhTenFEZlgySWNX?=
 =?utf-8?B?Nlpxdy9nTnhrU2hDQmhNS0p5OWlEUVl3S1I0bXBJN0UwbEJSbmtNUEpzZThP?=
 =?utf-8?B?QjR2TzJPN3kyd2tFMVN1b09tVlkzYUhWbXIwTzlTSjR5eUhEN1c4bkh4RFNo?=
 =?utf-8?B?NGJmVTBqQ1RWajVvZkxpUTJCUURkekVrZm9uOEkzcUo1UHNGTWthNzZvWGVy?=
 =?utf-8?B?L016VmFNeTN1c2YzYzNDa2t6c0piQUNOYS82d2lSTnVBY2pYdFFpVFlQZk5R?=
 =?utf-8?B?bTZ5SjhBOTNzSTFTaUc1YWZsR25PaU9NY2c4TTNVWmw4UzZ4akdvbXpKSDBv?=
 =?utf-8?B?cjUvSjJ0dTNFMnhWcXh3T2c3WTRKY2tTaHU2UVoxUlhub1VQQUxod2NKOHRX?=
 =?utf-8?B?MTcyeXU3bWhYaGZobkEvMEd3Yk54WnMwUDhlNXE5eFArMk8yZjBlVGJBV2Qr?=
 =?utf-8?B?VGVnL0F3QkJtM1VES0w0V2NBcU1nUGxhUWtMc01vWUxBLzgwNGZnREpyZ2RY?=
 =?utf-8?B?U2N2bzhaK3RYTGVJVldVMjBZMWM3aWtyU2VIc2EzdXdTTUxoR3daUzZscElV?=
 =?utf-8?B?V2Z3TldEU0dHdE96QTFHaVYwOHhuZS9EdjFreHZsZk9Kby85YTd4dGlGVlJ4?=
 =?utf-8?B?blFoOTBoQnRXTVNXL2xrdEROakU2T3lDVTRNM3lBVEY2dXlCS1lwRSsrRisr?=
 =?utf-8?B?UTV4cG1Za0lZaTFXYmhsNDdpbVJCdEF4MVVVeS8rWlVmL0VHbHQxMVpaT3pG?=
 =?utf-8?B?RmNJRWJKc3FYdG5QM0FmRDREbmVNd2RpelhDRFBsREFrZ1krV1ZTYlV3YmR5?=
 =?utf-8?B?UGExcUQrTW5Va20vRWF6dWJLTG93OStwaFNWclZuckxVWUxMSGpoSjhqNDlU?=
 =?utf-8?B?RVRweVMxbVhkcy8rN2lka3p3VlhQeG10QTVRZ3FnaEVTK29LN1p3UEF5L1c2?=
 =?utf-8?B?TUxpMk96UGdveDdSejRqTUlabDBDUzlhdWhOL0t2cXFPLytYbE1UTGN0T09V?=
 =?utf-8?B?NFc0dkdhYzF0YW85aGdsejVYYXRWMVVza1hFVVgxNGxBVHFQZWhMeWtjSUNB?=
 =?utf-8?B?V25oZmZuZ1dURzMxQnJ5MSt3U3haZHFha2QweHRPUFdVTnFJU3p2ZEppclRO?=
 =?utf-8?B?SnFhQTVkMFhQaGxnTDZJa3lreW8zNU9KdEdqaG44dVI5eVNTZkFXK3drK2Fs?=
 =?utf-8?B?Z0hTS0M1ZkN2eUtGdVR1UDRyd0tDVlVkZ3A3VnZsbC90c2ZhSW84TnZtVXhR?=
 =?utf-8?B?ajBzbDNrK1ZpbDIxUC9mOVpPQnhXMUhJQi8zWlJJbURkNktRZ0x4RTU4OVZY?=
 =?utf-8?B?VHFwU2lGNW50dE9SSHVUQXBubWZjanZQWmhGSWFQWFI4L0psNVJWQkhYSDhu?=
 =?utf-8?B?MU94dDEwYjFPTklZUzcybnJ0S1ZrUEFpMElyTFVpeVRiSnFMYWs5cm5zZ3VT?=
 =?utf-8?B?RlhTRmVXRmJGdldpL2loTU5hVlBSWHl1cVBUSmdJUjF5Mnc3RDJvbmIvRTVl?=
 =?utf-8?B?em9qQVd0bnhCZ28xbUNNcWpsbFNVL3EwM01XTTlaZEFITDNzMW1xTHFUSThO?=
 =?utf-8?B?QjBjVkNaSXhjaStUSXdJcDY3OWc4bmp4MmF0QS8yeWVYUTB3NGc0Ykp3Z2VR?=
 =?utf-8?B?a0E1aXl6T2ZRUWdkY3hoYWljTTNsNHhIMkVFL3JDZFdYQ3JhNkRWM2trM2pq?=
 =?utf-8?B?UUNJMDByTWk1U21JZ3Z3Q21TSzVucndjWXZiYjNXNDRpaWZIaVV1WnhhcTRh?=
 =?utf-8?B?NHkwazZlbWNqTGJxZksySUcrbGE4WXRmUFJ0akx4QUJGekYxTSs1OTVLWWJx?=
 =?utf-8?B?NDRKSDcxbjZ5dGJUc3RYZG9zbnYxMk0wYWhwWTNRRTdjUnhLNFNsR3lNUlAy?=
 =?utf-8?B?OTlMUjRDNmV3eGlZOTMwMjFmb1pad2VpRU8vYnRUV3dHYzViOVRQWitYcWN3?=
 =?utf-8?B?MVkrWGd1eUY5cFBvY0NKWFBtMnI5SVl0SEhrcFpSTkJUQnl5NEMydEVxU0NC?=
 =?utf-8?B?NXdZTE9neFM0eGxhS2k3RUV6WjYrQ2hWR3NidEY5MTd4NC9uYzA1QVB1SUM3?=
 =?utf-8?B?WUJvbVNNRStRV2ZOQXhCaEVleFU1QldCUU5Nb0M1MzUyYktxdUhneXpqOFIz?=
 =?utf-8?B?QS9FL1JBSDdNTFE3eHphSElDVjJRSGRHRmw0ZzBISGhaem1PZjEvZUFjZ2N2?=
 =?utf-8?B?SmMrYVUzVGUxKy8yWGQ5amt4b1lXQWxvY1Z2SCtHWm1XcFZuNGQyRkhObEZq?=
 =?utf-8?B?TWovNzVaZHRtQjFLcENIWjZXbEJEYitHMW1sZkZRemk5R0w0bGtsMmJiZVZR?=
 =?utf-8?B?Qk1vYkVrQktGVytIZGdUT0JzaVZrQW5KRVdiUlVBTk1rekpNK2gxRVdYak9l?=
 =?utf-8?Q?C7dapsErrqI2Y3qkCKSo6VWSdDi4cT2Ps6s1REG/gZp6/?=
X-MS-Exchange-AntiSpam-MessageData-1: +ugUFcrj/+OPRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b478ddb-247a-4f86-2de8-08df1d2b68d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:40:39.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk18b9QbMuIEEa1skfUKS4zWnHw+MJOF6Eh4fapPCgMDvJxqVwoZsRcirBJkhSFSMtko7QazR8iIFo+FW/28vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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

On Mon Sep 28, 2026 at 3:19 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 2:16 PM JST, Eliot Courtney wrote:
>> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>>> Move the transport part of `send_single_command` into
>>> `send_command_element`, which allocates the queue slots, writes the
>>> element header, calls a closure to fill the remainder of the command,
>>> then computes the checksum, advances the write pointer and rings the
>>> doorbell.
>>>
>>> The RPC part of `send_single_command` (writing the RPC header and the
>>> command payload) is passed as a closure, unchanged apart from its
>>> indentation. This sets things up for moving the RPC code into its own
>>> sub-module, leaving the transport agnostic of the message type.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++++------=
--------
>>>  1 file changed, 74 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/=
gsp/cmdq.rs
>>> index 07e8e32c3d57..b6d50b0bd039 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -638,65 +638,35 @@ impl CmdqInner<'_> {
>>>      /// Timeout for waiting for space on the command queue.
>>>      const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
>>> =20
>>> -    /// Sends `command` to the GSP, without splitting it.
>>> +    /// Allocates enough send slots to store a command of `sizes_in_by=
tes` length, initialize them
>>> +    /// using `command_init`, and send the command to the GSP.
>>>      ///
>>>      /// # Errors
>>>      ///
>>>      /// - `EMSGSIZE` if the command exceeds the maximum queue element =
size.
>>>      /// - `ETIMEDOUT` if space does not become available within the ti=
meout.
>>> -    /// - `EIO` if the variable payload requested by the command has n=
ot been entirely
>>> -    ///   written to by its [`CommandToGsp::init_variable_payload`] me=
thod.
>>>      ///
>>> -    /// Error codes returned by the command initializers are propagate=
d as-is.
>>> -    fn send_single_command<M>(&mut self, command: M) -> Result
>>> -    where
>>> -        M: CommandToGsp,
>>> -        // This allows all error types, including `Infallible`, to be =
used for `M::InitError`.
>>> -        Error: From<M::InitError>,
>>> -    {
>>> -        let size_in_bytes =3D command.size();
>>> -        let dst =3D self
>>> +    /// Error codes returned by `command_init` are returned as-is.
>>> +    fn send_command_element(
>>> +        &mut self,
>>> +        size_in_bytes: usize,
>>> +        command_init: impl FnOnce(&mut GspCommand<'_>) -> Result,
>>> +    ) -> Result {
>>> +        let mut dst =3D self
>>>              .gsp_mem
>>>              .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
>>> =20
>>> +        let seq =3D self.seq;
>>
>> nit: this local reads noisily to me
>>
>>> +
>>>          // Fill the header.
>>> -        let msg_element_init =3D GspMsgElement::init(self.seq, size_in=
_bytes);
>>> +        let msg_element_init =3D GspMsgElement::init(seq, size_in_byte=
s);
>>>          // SAFETY: `msg_header` is a valid reference, and not touched =
if the initializer fails.
>>>          unsafe {
>>>              pin_init::raw_try_init(core::ptr::from_mut(dst.header), ms=
g_element_init)?;
>>>          }
>>> =20
>>> -        // Extract area for the command itself. The GSP message header=
 and the command header
>>> -        // together are guaranteed to fit entirely into a single page,=
 so it's ok to only look
>>> -        // at `dst.contents.0` here.
>>> -        let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst=
.contents.0).ok_or(EIO)?;
>>> -        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, =
M::FUNCTION);
>>> -        // SAFETY: `rpc_header_mut()` and `cmd` are valid references, =
and not touched if the
>>> -        // initializer fails.
>>> -        unsafe {
>>> -            pin_init::raw_try_init(
>>> -                core::ptr::from_mut(dst.header.rpc_header_mut()),
>>> -                rpc_header_init,
>>> -            )?;
>>> -            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.i=
nit())?;
>>> -        }
>>> -
>>> -        // Fill the variable-length payload, which may be empty.
>>> -        let mut sbuffer =3D SBufferIter::new_writer([&mut payload_1[..=
], &mut dst.contents.1[..]]);
>>> -        command.init_variable_payload(&mut sbuffer)?;
>>> -
>>> -        if !sbuffer.is_empty() {
>>> -            return Err(EIO);
>>> -        }
>>> -        drop(sbuffer);
>>> -
>>> -        dev_dbg!(
>>> -            &self.dev,
>>> -            "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\=
n",
>>> -            self.seq,
>>> -            M::FUNCTION,
>>> -            size_in_bytes,
>>> -        );
>>> +        // Initialize the message payload.
>>> +        command_init(&mut dst)?;
>>> =20
>>>          // Compute checksum now that the whole message is ready.
>>>          dst.header
>>> @@ -715,6 +685,66 @@ fn send_single_command<M>(&mut self, command: M) -=
> Result
>>>          Ok(())
>>>      }
>>> =20
>>> +    /// Sends `command` to the GSP, without splitting it.
>>> +    ///
>>> +    /// # Errors
>>> +    ///
>>> +    /// - `EMSGSIZE` if the command exceeds the maximum queue element =
size.
>>> +    /// - `ETIMEDOUT` if space does not become available within the ti=
meout.
>>> +    /// - `EIO` if the variable payload requested by the command has n=
ot been entirely
>>> +    ///   written to by its [`CommandToGsp::init_variable_payload`] me=
thod.
>>> +    ///
>>> +    /// Error codes returned by the command initializers are propagate=
d as-is.
>>> +    fn send_single_command<M>(&mut self, command: M) -> Result
>>> +    where
>>> +        M: CommandToGsp,
>>> +        // This allows all error types, including `Infallible`, to be =
used for `M::InitError`.
>>> +        Error: From<M::InitError>,
>>> +    {
>>> +        let dev =3D self.dev;
>>> +        let seq =3D self.seq;
>>> +        let size_in_bytes =3D command.size();
>>
>> I suspect if we pass dev and seq into the closure below, we can
>> further split the RPC layer from the transport layer. That means the
>> patches after this won't have to impl on CmdqInner for e.g.
>> `send_single_command` and instead we can just define a trait that writes
>> in the message layer data (so send_single_command could e.g. instead
>> take an impl RpcCommandWriter or whatever, and we can impl
>> RpcCommandWriter for anything that impls CommandToGsp, inserting the
>> message layer protocol stuff in there).
>
> That sounds like a much better design indeed - I was contemplating
> introducing traits and thought it might be better to keep things simple
> and revisit until r000 is completed, but it probably won't be limiting
> us in any way, and removes the unneeded mirror methods in `CmdqInner`.
>
> The same pattern can probably also be applied on the receiving side, so
> I'll try and do it there as well.

Yerp I think it can be. I also don't think it's bad to keep the trait
around even after we remove r570. If we are passing in closures anyway
to cmdq to do message layer stuff, that's kinda like an unnamed trait
anyway. Thanks!
