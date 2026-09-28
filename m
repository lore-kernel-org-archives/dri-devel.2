Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E6CCA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B087F10E89F;
	Mon, 28 Sep 2026 13:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="K/m8ox8v";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022143.outbound.protection.outlook.com [52.101.96.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A66A10E89F
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8ILCo13LPpV7LRrDir2iLwXDyvXKHkUdX35E/9wMDMC0JybC3wa47r9m9ljqMEem4xa1Dd92E/u/MZ7j1MTxcqbrXQ9jOH8vwKRsXhiKfmcc4tZ8NW1WexoWMuDKEJcDGi9VYwJMceLL5rUv1SAXkln4oH2ITQauVOQgRK9AiWa7pAZdqcjxLeUdvp9eZrFKys2RduAmU7Wmcpyl0Kt/hAKFHtXuYLG+cVoAyd6lAG2yrTAfLeow0jAbbc1Ibaa1U61r8bEAPnjePKWLjmQxc4EByETGdjbQiPdGYDlVeQnMfArImtdjNIFC7drLs2aN6WKKAvBJU7H093gAumHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lpg3zbpCsf7SiWZKVb87T9FUyiL4SgcDOur4GlH9oA=;
 b=bT2y6fQO1YBbVP91a1ZBEmkSzKxNsSrjyEPpjJueQWb6rcGGlr4eAsERdzrXF/L1V7LS/McExpfCMQ9sE5Ixf+yeJo8ExG8Y5fQCoxG7QJuORbRCs+cr40eNuUDZNnq8fo85KviZvToNbKTCDorVVaa1Bh/XWc9HzUWi43gclbTOoG+Vtp1QXTghYRbdeosYCI25xGaWqMS3im1pHQSCTsMAFF/zbqJtFWYmuC2+qrIUbKsZXtS171xmoSi5VgOwYCFHL+Dj25JR+wQ5OXMuaNWaUkVvU1mOksDj2hMXJhsT+Ijx4QdliuCmbqHHGa2w6eLR/dyHRZxOag4vV7ercA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lpg3zbpCsf7SiWZKVb87T9FUyiL4SgcDOur4GlH9oA=;
 b=K/m8ox8vPwFkmlrzqB9ncCSZSuv/TgxPIykzFZp9wOsgOCuidQFSH77vMuFsbfME9A3vb/7ioDoqNOJgrJn+DgCfXIjmN0C+HQ4vLLnBWqnzWMukAGZK2lcCHCcX77eABNOKAtLREwVS6H1SoXoWGiExmHAfSxDVeOMapl/agFA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2983.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 13:53:38 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:53:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:53:37 +0100
Message-Id: <DLR009WMVVQ5.26C5V2E6GFD40@garyguo.net>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
 <DLQXLV1FYMQS.JBP531K4P4T8@kernel.org>
 <DLQXTBWUJWGP.WGY6G88ATQM7@garyguo.net>
 <DLQXWXRP3P1J.28SLFOJJQ2EDK@kernel.org>
In-Reply-To: <DLQXWXRP3P1J.28SLFOJJQ2EDK@kernel.org>
X-ClientProxiedBy: LO3P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2983:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ce15f4-13a3-4844-5837-08df1d67e590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10070799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8RyQBdfYmP9SGR9VvZsbs9oWPB+tj9kaVSDKyeEZEXxHIP4J0IqBsFMXxWTgCRGcfFafTawAacb1n5Bpr/OSaMX0VuxMGtt0eAXDsnXnWtrPWu/dnFtUTihLwDzVXgupmxC0SALKUVt/2Gn/2syY8CiNRX2vpnYVsgsVlJvXYseUNLLK3vrE5TRJEcNRrgBNgRW5+E8csZ5/rqWZmg/OjVoDzESM4fWCgZAt7b9o/0kCEYXKxOJM4E4xw7hXGOVMS/QwDwGTuFKV0dhUFFdmiSq+IxYTm4/uHAdGFs5qEUvRt2/os7VaW3+0sR7FieGGuQ+2098ot6p8pJAiihDU/q8ijBr+bNfJBl05fROE3mHWSd/JLaoT3RocFmeEWPSdcBUakymrkDg8sRer2Va75wv6jkevBAQF5h5yEtiFVmdNNpcS567UtYAs0VdYNuEY1wAvc+aGiPNufzfQu841afAISoPyR0jcO2x6TXVLhH0g7IBiTOxnQeSMTjHRbYmhIWDCmb8HYDxvWiu2QbhMyrGMntHzIW54+94VcQExVHKJJdM7lD5yK+TXGo73AKagtnN9z12ezUhfj3MXz0MjjrfShY4bYa23rMp1RcQquvuZDKNu0oq97jIpKtYcn3o+e764sXn7Qj5wFkDUiK909JHT4Q7nnllmElN7b/OUwks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm52bkhhU2lRNGE3dDhqRU5LMWhOUE5DUWtIOXBnYnJKNTdrdXJyMlF4Zk1K?=
 =?utf-8?B?cE1nSk5YRmN4RWMwZlNielM4dEUxTzdxMHMraUp4R2s4UTVVMGFlbHpwVUYy?=
 =?utf-8?B?K1NZN25ISGlRMnJLeTdwcTRxYllDc2dDcmQycGZvSlpTSWVpb2xuVHFRVTM0?=
 =?utf-8?B?cHRJUUhnOWM5QWFoSFAzK1JCdEh4Tk5YRnl4aTZkQkp5L3VwVm12UUpJZHE3?=
 =?utf-8?B?OWZoNE5SOWhRQVFGTU96MjJ3ME9sQm5oZUR4bWlFZ1I3WlY2MGQrVk5SaEc2?=
 =?utf-8?B?N0p3OW5WeVhZSjhBcnVxZ21tb1lWV0FCWElTNFRaeU91NGlxLzFUY05zMXZH?=
 =?utf-8?B?Y0dweS9EQm11dFJDU1pNazlvbnh1ZE5oMGx0VnFucHJXMGlqOGwwSUtZeUhz?=
 =?utf-8?B?ZDdXc2xOMVFaam9ZRVo2UDl0dHA0NEJHeTRCUEdFWGp5THd6OEowbVdHWVJr?=
 =?utf-8?B?R2xZRXRSUGtiYzdKaHovMDN3QXJFd1ZwSFZMTk0yNmdNM2Mybk1JVjhReVlP?=
 =?utf-8?B?VmJxaU1XTUp0TjJQWmZKckpnV1Q4TXFhR1k5MzdpQWM2NGNGbEtaSHpaaUJv?=
 =?utf-8?B?WWc5K20raTZHLzBvRVZMS1RUczhoVWlvVzNNRmN4SzU2NFI0V1BDcTNTN0NQ?=
 =?utf-8?B?VWl4eEx1SWRPSE5CVnFwQ1V3VnBpTnE5WG9GbjdXKytmSVBLelNjdnRJcTcy?=
 =?utf-8?B?Y0hIRFRqNytHOTJ3bmk3dDFTTkVBdEVsUDAzYzd2ajVDRm1rUmNFeG1BUWMv?=
 =?utf-8?B?Wm5DemJOMEFySFViTzRUbDlMUlVIandnMHdXTW9UK000VXZkRUZuUmcwY2RL?=
 =?utf-8?B?YzQ4TWJQN2lidUJBekZuR01WaklHTDBpMTZzRS9yTGYrbkhBb3k3K3pzZjlz?=
 =?utf-8?B?WS9adUp1MGplVCsvUEE0NnJwc0NpR2h3bTlqcXcwVG5xUWNQMzlYYTIxcTdH?=
 =?utf-8?B?Q3pMZGh4ZHovcENQRFR3R3E0QitJUjAvM2F1M0ZCRVBqNnFmenJDTi9Hczgx?=
 =?utf-8?B?U0NBa2NDbnFWY24wWW5OYUI3OTI4anE2cENQT2lnbGZ1YmN4NGxHSEZpVWJK?=
 =?utf-8?B?eW9ySTBuTTNzWHd5bjRhVXFmOUdtN3FtQVF0eitsY1EwQkhhWHpRSi90eGd3?=
 =?utf-8?B?QjFJcWppLzdEakxkeFpFWEZhQlFIcXRwNnZYY2dVQzBoN0RSNTQ3WG50UTk4?=
 =?utf-8?B?ZFN3Zk50b091V0huVHJ0K2I5c2Uvc0JRWVIvdC9UeXBUNDAxOGFmRjFUcm5w?=
 =?utf-8?B?Q1RMQlZldVJYaFpuWGdmcjVGL2hTVUlQVGFyZUVnOVMxMzA5c25MZTVKcE00?=
 =?utf-8?B?MExBK2U5eWhHMTFuaDVhMkRjWm9jNDRCUytiQ05vclZsWnlUQlBONC90a3hi?=
 =?utf-8?B?RjRUNFNjRnc5aXVVYkoyQWJQYy9jYzBrSjNQMXhNdnZWbUJtU2VNNWFBalZN?=
 =?utf-8?B?Wmh2aFZHTklVNmYvK0lEM1lTdXF0VTE5TFNmOTBoMFhQTlJaYTBGRGdESWwv?=
 =?utf-8?B?OS9DQnZpT3VUZlpyb3JnZHowSTBPTG14ODFJekJCWEpzZ1RhQTZJTFcrUjFT?=
 =?utf-8?B?RmM1TWw5ZmI4TUZjV3FZbExLb3B2MGtnamw2U0dld1JBcUVxOG5zWWZCRWta?=
 =?utf-8?B?UG5LQ0VENnpGSVgrb2RURGR1NDNHZVZubGZDR3NnRFFSUTRNdlJMWkVsZm9D?=
 =?utf-8?B?OVdWTERNWm5hRVQ3dUhVdEdzTHVicHBPRGdOTnhlelVqbTJLZ2luU1liT2hw?=
 =?utf-8?B?Szh0MGxwWHhUNXQwT1p6VExKb0hMdEVKenJsR2xPNjEyVTRIUXVVU0pHZVpa?=
 =?utf-8?B?VXk4MGZselU2Mk1aTURyVU5zaWRBbGtHRFZVQzgyc0VIcEtYbHIzZThtVnRH?=
 =?utf-8?B?YVJkTlVnQUJHTjNFdzVrV1JFS1BwUUdDUE1QQlBLTnVBVGxwMkNqYzZKZm14?=
 =?utf-8?B?VVUwTk9UYnRDdVQ3aWZldzB4bVFHaUF5RlYwUWlJTVM4U0g5dG04THFGdXhP?=
 =?utf-8?B?NjdiaGN3NVRTaFdtMEYwS256S01ycXh3L3VReExGTkMxUGpmL1pERTgyd1Fa?=
 =?utf-8?B?cG9XMjFHNjVrOE5YSEQ4NXB0OWFRYlZTaWNMKzdwSU44NXpNRE40ZzlzWjU2?=
 =?utf-8?B?WGl5UXFTWW1QUkFyMVNPeDRqWlZjVjF6LzFDM25ramNka1h0RVlvc09aUWs0?=
 =?utf-8?B?QTZaclVNRkxOMS9HYXZCWE9jQ01jdWg2V2JhTmZMc01wOThsMkRtYm9aaFV6?=
 =?utf-8?B?NFdvajR3YnZFekJZQ0xGVUtJMVVUNGRkaEFaNmtWTGJtL3AwUTdISk5BSkJ0?=
 =?utf-8?B?QXk4U21IeXZuRXEzZFdkcDFpNlNtRWFCU00ydXVmQUdpTGYrQTczdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ce15f4-13a3-4844-5837-08df1d67e590
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:53:38.1696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d2Q5pHCn8KOuPP3A+Y0hGBcw4eQHjKXVmugimYDxWipLO2v0OD1znDRVSreyg4GGTaaEp4mCjFhrQ2NdfDvag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2983
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

On Mon Sep 28, 2026 at 1:15 PM BST, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 2:10 PM CEST, Gary Guo wrote:
>> On Mon Sep 28, 2026 at 1:00 PM BST, Danilo Krummrich wrote:
>>> On Mon Sep 28, 2026 at 1:36 PM CEST, Gary Guo wrote:
>>>> I think this doesn't need to use `pin_chain`? You can do
>>>>
>>>>     gpu <- ...,
>>>>
>>>>     _: {
>>>>         #[cfg(...)]
>>>>         gpu.run_self_tests(pdev);
>>>>     }
>>>
>>> Unfortunately, this produces the following error.
>>>
>>> 	error[E0382]: borrow of moved value: `gpu`
>>> 	   --> drivers/gpu/nova-core/driver.rs:140:62
>>> 	    |
>>> 	119 |             gpu <- Gpu::new(
>>> 	    |             --- move occurs because `gpu` has type `core::pin::P=
in<&mut gpu::Gpu<'_>>`, which does not implement the `Copy` trait
>>> 	...
>>> 	129 |                 gpu.run_selftests(pdev);
>>> 	    |                 --- value moved here
>>
>>     gpu.as_mut().run_selftests(pdev);
>>
>> should work?
>
> I tried that previously, that gives another error. I didn't dig in furthe=
r
> though.
>
> 	error[E0596]: cannot borrow `gpu` as mutable, as it is not declared as m=
utable
> 	   --> drivers/gpu/nova-core/driver.rs:129:17
> 	    |
> 	129 |                 gpu.as_mut().run_selftests(pdev);
> 	    |                 ^^^ cannot borrow as mutable
> 	    |
> 	help: consider changing this to be mutable
> 	    |
> 	119 |             mut gpu <- Gpu::new(
> 	    |             +++
> =09
> 	error: aborting due to 1 previous error

Right, we didn't create the let binding with `mut`.

Does this fix it for you?

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/sr=
c/init.rs
index c5b5a0ce5c4e..031adb46cefe 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -446,7 +446,7 @@ fn init_fields(fields: &Punctuated<InitializerField, To=
ken![,]>, pinned: bool) -
                 // Allow `non_snake_case` since the same warning is going =
to be reported for the
                 // struct field.
                 #[allow(unused_variables, non_snake_case)]
-                let #ident =3D #guard.let_binding();
+                let mut #ident =3D #guard.let_binding();
             },
             Member::Unnamed(_) =3D> quote!(),
         };

Best,
Gary
