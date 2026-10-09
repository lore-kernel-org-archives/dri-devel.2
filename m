Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3DDCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD4410FEC2;
	Fri,  9 Oct 2026 06:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBDX2OGD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280F410FEBF;
 Fri,  9 Oct 2026 06:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cavF/h5Ofkj2u9pXah97soINUTwoQCJgLnOJHJlMW/P6+0l4+6YY9H9blXYaDleXnba+f2W8cciih/uCk6OUQwNTXaVK9SSUQmkGMzySXTqA9E/L2akMTH9nPvjVitVWJWTDF+4E1vGxmkxoD8AtHaOUTtnvfKTTfLaM5NXyKiBBi5mvQ4SUlmQG2FBF0YDKV1JrUvkUqW1D/1k6+h9lvRjBxkxITrPUTU9Z0ZwjFNMYFeo/c4LARQPCHyRuTGPnT+oF/fVO2hezGOjvl+Qgsceki4upQKqOV711rj5gFSlPyoOb8HwbwBIZpUXeZL0/UNlR6AEDaY+0tsdcj9UJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfNTsBjUxsNeSEw4PPpbKR//nKVxOm6V1qNIIZolXgw=;
 b=sthxyStwoX9cpO2vUJvpZnkz2guagEdu2rtHOaGrffVTjmEl9aY9bJIyrnYQInS/S6/+qkyAouV4VnEkxZIP4T/bMG3NzaIs3t3finMc5OqvLQuWw35/YcWq2tdQGp33DgJvof3CIh4j5CfdlXxBtkwGwAJDf9A2oES4azfbtFJ1sCqPrGDWxVaWy1I7sp9Fdi7AFk9M9vwjWukiZ2sqxJ+T+EcZ6RFetAzkFILgBqV+32qpKoMViU7+fbS+UxThgCupFojFImI4ljBoyBjv2OI/Bv9KX9cMs8KtShYBAvnNrfpWOMaXdsT+YNIgoNyYN6PqxFyNhNY+9w2wCZj8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfNTsBjUxsNeSEw4PPpbKR//nKVxOm6V1qNIIZolXgw=;
 b=TBDX2OGDOOV5P5Vb4QU5mxgneqhURCfAFKSb+AaqmdR0TKWZAX1JyNGb2L4YIyW1XGTzMNJbFrU7qjpAZ2E6vNVfxm9lwQWDa3najCZUDT4XISdR+sdtjmLotWCAOWMJAgqCNLrYrN1WKCZctNG/sIY8Xn6Ewg/JUO2qj30YHRCqKcmQhYL0xf62OV0XfIohLQ5oKgokMTXgt8Xm3WiXnR2Gj6/qbFsBY3Y5p1Gjsf5wt8A5pL1XflHZWCfQiyr9J/D6HLa/oMLjYPsn9X/Y6drsHzOFR0w5YUAQ1h0frCE8AZwM7/NTWf6JBZ8WpSPezOYfjxXKwPd9vUr/pNJExg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:36:41 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 06:36:41 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 15:36:38 +0900
Message-Id: <DM03LOKOYPFQ.3UXED0I92H8Y6@nvidia.com>
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
Subject: Re: [PATCH v3 5/9] gpu: nova-core: gsp: cmdq: split RPC parsing
 part of the receive path
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-5-91613f06520b@nvidia.com>
 <DLT7CLF1AJVA.3BNA0XWZOZB99@nvidia.com>
In-Reply-To: <DLT7CLF1AJVA.3BNA0XWZOZB99@nvidia.com>
X-ClientProxiedBy: OS0P286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: f28c5832-8f84-4825-72af-08df25cfad92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|7416014|18002099003|22082099003|4143699003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: b4uAL0Wfd7ROUtcXdEVULYOPk5Z7Zw+F8ph8GstOBW8YKeL0NnD7V1IHproNbFooYEJzBlD/ROMvwq7ZU1W6Ptpm4Ct9tGKcQ+LluI+qQEzfBUcqUn7iwHENue/Uf8WLE4n83/dswuTpGaY86ryL5PFILu5LTv1NK7/mHQ9HycVFhGET0jrN/ydhIj3t7qaY2IsfSnVAeVtDDtysbjLqs5PTsXiZoIy4P5dl0ktACLP/Q27OEYE0XfImIgMJTgOb/zxllb3r3E66uHY1kSM8ujT3fVlUqTLvf6R42aJE3rBjJL8bK8tpYShPQ9M5isnzWLlrPgjhvtf+AVS5hGZlRe7QpxYZmKMRBlOOLVRQ1dxIr/sSS/iKIlcsz+TtYUmlgKjKrlaDxT8IMDA/K0tKyhDt4TxELVSgrzAwTCQdo/MpMQPipWefRdABngw669TwOLaeBXRKk/L2j1hucG0H07Ru4iFY+nAIiLlR01CM96WVZDQw4JknMkn49eFTAXrTJcCEger0HO5wIvqxljUV9fpzOdBsTupBYZwQ80ikVg0qw0ELdImst6R3JjDiCBpxnrJAki2VflYDN7yPiDt5qmeuBRwxkE57dLjlq2Wl0NeizOBU71SWolcL+2FQjTFI7AhpM7Wju8qPO1Ev24YJ0axi+tT6QmpI+Pw/xXEQVKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(56012099006)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JmTndtNEpUbzN2Ujd0Q3ExaUJKVHpuVCtqSVhyNFV5UmZIMHFqY1FEWlVz?=
 =?utf-8?B?QW5OKzRvUDFTS1poRDR4Q1FENlhVODgzV2p1S0RZbXpBdithdnJta3FtZTEw?=
 =?utf-8?B?QmNQVkxMQ1VCTnUrdVk5bndmREpMeW53UWxtU3VzVCtzb25UQ0VxOWZaQXpr?=
 =?utf-8?B?MUpBWDN6VmMrMmR5RGVMWjhYRDNYdFNNQXVSS2wzd1JxUTJsQzVWdEc1NlhC?=
 =?utf-8?B?U2pqU2lFS2lZZk9TckZHc0ZsNFErWkRna2cxMDZzc1FZQW9UUXV2Z0lVY0dv?=
 =?utf-8?B?WkxneklIaGdld3kxR2NDbUY1L1RrZ1JNQlhVM3FxUE1KRmZHaStWczliVllH?=
 =?utf-8?B?cWs0dElmMHF6MU1KenhkMjZCb1drcVBrQSs1QTlMZVFtTGZZREVjR2xxTFh3?=
 =?utf-8?B?SEJOSDlnUzNTVWwwUWg5NVpBTk5hc24vellsbTA2WXk5c0hxMUJ2QjVCZTNI?=
 =?utf-8?B?elJoRmNudnhod1pCa0xBMG9MdnVxa0JTR1RIY3prVDVnSTNvZnBBVkwxdzI4?=
 =?utf-8?B?bWdDQU84Y0o4dEdJQUppU0hSQVpNK1p2MVM3SzNhay9PYUNKRHI1TXhITWtD?=
 =?utf-8?B?cXQ1MXREZlV4SjRuWnBVbEh5ZnB2Q281YWs2VUwrSktJQXdNTmNYNDBJM2d0?=
 =?utf-8?B?VHdqZmY2WUppdFEwRjFaSG9xd2JQMmlmL2djbC84WnhoQ3pxNUd2VUZvRTZX?=
 =?utf-8?B?UWZsV011dW9hUDQ5ZUMrQmNuckVMYk5UeENIZEtTV01tU3UyRnZJVnZRQW5Q?=
 =?utf-8?B?OFBwbnA3Q2VJY3UrQ2JLRkhZNkZHTkNXUm5aTk1QNStDWlpoMFpTSEJoTmVX?=
 =?utf-8?B?UnRzZnpCWUI1b1BEaFJwUFZDUVJwcHlZa2VSS3RyQ3pTeDVuYU5Qc0o0OVk5?=
 =?utf-8?B?aWZyOUJhN2NLNlhqR2FoVEo1aWJOc3JxcGUyL0FxVENCWEhCaWdCbUtOMmhy?=
 =?utf-8?B?cWNUcFRUdHNMUDJCQzdSM2Y3a3BrSVRoc0R1NXExeUVRL2l5Z2ZEV3hlUVJt?=
 =?utf-8?B?OWl0S0U1Q1VqR3ZqRzY0NWEyd2IyQjh0OEN0cVFWaXZtcXB5V2ROZ0Juc3ND?=
 =?utf-8?B?VXp5aUVCRklBUjFMUTdqdHFNcytEek5VVTlJVkpBV0VlR2Q1NDRNaVBxWXRM?=
 =?utf-8?B?azVEM1NGelU3QnRxemtJMjZFa1hJc2tMREl0aHRYR1AzOU4rM3gxb1JZbjBC?=
 =?utf-8?B?UGdHMUpFR2tUYXN1UFkveFVxS25kN3NSTjlSNzZxdGJhRm0yZXozeG5rU2hD?=
 =?utf-8?B?d0s4Q0FXMGpNTHpoMFNvUDk5ZWNaN0dDNXovUkFBQlBwa3BjRG1YRmdKWWNv?=
 =?utf-8?B?WFh4TE1sSHBjQTBDQXE4WEZiMmpJalozazNqRFpwWnhwbWt2NTFNbmJWMHcr?=
 =?utf-8?B?Y255SUpFb2ZBWEM0anRhbXlHRXRkT3ZYME82YzBma2IyM1JtMW5lT1U3aTlw?=
 =?utf-8?B?cER2bFpWdUpnQ0NaUmtmTThlMXZOeHhsc01pcDJRVDNqclpiK0pZNkRkVDhP?=
 =?utf-8?B?N09DZm1VaXQvTzA2NThJY296cWlITmZBYmVKWmYvbWx6cVVFTWdNUlljRVRF?=
 =?utf-8?B?V3dZYWtZZW4zTXNUUzBUSnRwM3NSd1hWYjdQejdJNEJPZlhFUTZ5NDRLQTI3?=
 =?utf-8?B?d0NhRWd4NDAyN3pzYy8xRmhGWllOZHQ2OWJKc05GbXBZeWUwcElrWEU1UWRR?=
 =?utf-8?B?WEF4VXZremZYd3FJZ0xtUzRJM1hLdlpvUWRQU1hvU1JlM0swYS8vWCsvc2xy?=
 =?utf-8?B?emdYdy83TWZram5VbWJVSjQrY0UzK2dCQ1pJM3VlNGVtdVZkdWNKcFk3TGJS?=
 =?utf-8?B?WnRrRXNBVnF0Vk1lQ1FTMncwZmI4NVdFckNwMGJlM1FMN0dJeS9qTzBidEpF?=
 =?utf-8?B?T1hwUnBvcVJOSE1hN1lzQXlDQlRpRjVTVW01dU9RWmNGUWNnZkdVSWwwY21H?=
 =?utf-8?B?NVA2SW0wTHJvdjUyNzFrc3RjTUFFTXpWZFZianFzVUV3dXVkN0NQVlZpWkxI?=
 =?utf-8?B?bklnbWQ5R2RZSVBpdURXeEVtbnd0bDlLUFgveGhBVlVraExWam5xSHA0YlJS?=
 =?utf-8?B?TzhRdytUN0dGNVcwMXNSVGxKUjNnakV5SnBCMTc0QWtVYVlwVEo4MTE4bWh3?=
 =?utf-8?B?WVRSRWs4RTByWENINW5VbGtJd2JZTzBvNmNOWTZXZXZkZUppNnBETDRtTzh0?=
 =?utf-8?B?Z3JWTytUMmc5VFdCTy9Kb1k3K3VMSU03Q1l4MDl3dWZQS2R4S2ovbTVPUFhO?=
 =?utf-8?B?YytmZGkxSEFIZERlZE5xRXg1NGYyVVp2RDVnbE5oMVBEV25pU2xXNXpxMWl2?=
 =?utf-8?B?N3hsc09JNzhHNXBzRm53Y1BLZG5JNElZYUhTdGh1NHQxSllRekoxUGRQMHps?=
 =?utf-8?Q?5BGEWS/RJmywTs4RXGStNGW068hqPTAIZ+7Imn0vwhc8g?=
X-MS-Exchange-AntiSpam-MessageData-1: WFcxM7yveqTCGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c5832-8f84-4825-72af-08df25cfad92
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:36:41.3521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcYARNcDccvo2bnqb6jajrcNqqJLW9UlM4+ZWIAKneO5tyiNRspYiqH7Y+wSNu89MeV3D5LZ9cSOKars7WLD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

On Thu Oct 1, 2026 at 1:04 PM JST, Eliot Courtney wrote:
> On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
>> The RPC parsing should not be done in the same method as the transport
>> header parsing. Split it out and introduce a `RpcMessage` type to
>> indicate messages that have been successfully parsed as RPC. This makes
>> the code easier to move around into its new destination.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 37 ++++++++++++++++++++++++++++++++=
+----
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index d8a7716fc500..b8a9e02b76fe 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -553,6 +553,17 @@ struct GspMessage<'a> {
>>      contents: (&'a [u8], &'a [u8]),
>>  }
>> =20
>> +/// A RPC message ready to be processed from the message queue.
>> +///
>> +/// This is the type returned by [`CmdqInner::parse_rpc_message`].
>> +struct RpcMessage<'a> {
>> +    // Reference to the RPC header of the message.
>> +    header: &'a RpcMessageHeader,
>> +    // Slices to the contents of the message. The second slice is zero =
unless the message loops
>> +    // over the message queue.
>> +    contents: (&'a [u8], &'a [u8]),
>> +}
>> +
>>  /// GSP command queue.
>>  ///
>>  /// Provides the ability to send commands and receive messages from the=
 GSP using a shared memory
>> @@ -794,7 +805,7 @@ fn send_command<M>(&mut self, command: M) -> Result
>>      ///   message queue.
>>      ///
>>      /// Error codes returned by the message constructor are propagated =
as-is.
>> -    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
>> +    fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {
>
> This gets changed back to `GspMessage` return value in the next patch,
> and also introduces a bug [1]. What about just keeping return
> `GspMessage` here? You can move RpcMessage to the next patch.
>
> [1]: https://lore.kernel.org/all/DLT4O89RYP29.UKGBMIJD8ZSC@nvidia.com/

Indeed, we could organize the change a bit more smoothly. I've tried to
reorder and hopefully the next revision will flow better.

And yes, it is undeniable that having both length methods called
`length` is confusing and has caused this bug, so I've given them
different names.
