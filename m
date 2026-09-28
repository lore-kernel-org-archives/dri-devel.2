Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D68C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0AB10E0D1;
	Mon, 28 Sep 2026 12:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="LuzKfWLz";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022121.outbound.protection.outlook.com [52.101.101.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413A010E0D1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeI+go6skxJyiXF0FNjmr6vxg41qTzZIHTq5Mpx2KetVkfYBhcya54l8idWQirN2na8SLnyRjfTXrYKEUTW3TKGvT2jv8OqiiM/FQCR/RDOK/yGP2a0RU8KOzl4LRi24o4p6LW8pKlezpKbutbIHfRMfllcTS4uc3dEJiChU3CK4BI/I2Rm/ILVoKzaiEbFTe7J8131ly8nbHBVNTU9L8e1SYbJiNXsJE+cZgHZK4sjbLziWhfrRr8+MpII+tS97yonysIfBWb68BFnpFHY1igjuevxn/AEkPqfUZFowSyyq2FfFWep1g5ElxJYtGjNYu7ut4PUlnSs4APvulxF/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuT6V/kHOggrLzQSzDdMQkfoPo7xXOavM7u+wFh1uGA=;
 b=YcUUgHc3Nqxzv69Q5lf+UB9mrPX8iidXCVgEm+Kgoz9RTfqzLKflfJ7QdR6PeM/ja1ugt5uiA2PCbatfrUI9esneJy4J+z+plLZh9Gbv4VRXxmikQWm7RSkXKihklviPRAshlSJdVXrIBe/vDpjmxqlZGsLga0vZDSkPKKWBM27GLsLer2+H10GUm6v9+vdsyT+/C3KwDn5Za2f2lqEvjMPAXPBnMrjnLUQUP1OuUBaLBr2pROTgZ5mmPrqXmuLXNE4nmYSm7QeQJFoBFVqRB0WLNa4xpPqcj4xupxJddP42oRHpGrqLONMWXakCOveT11LqM0uhSxeJtgq4541gWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuT6V/kHOggrLzQSzDdMQkfoPo7xXOavM7u+wFh1uGA=;
 b=LuzKfWLzpzJ+kIzUa7V0B22Hk8WiGAl6lIuxMaE2U/q8Is4vBQwOZ68YOKJRLiU3P4KqaOC2eJBaoaza5pAl4vw56Bq6FDIy/R9k9gf7dPzUfpp82is9xmWVwkpuu6PhatzOEmu4/Yfd/sMGsApEBDuPXADecGaXSKxGEt8IzGI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7805.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:210::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:10:31 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:10:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:10:31 +0100
Message-Id: <DLQXTBWUJWGP.WGY6G88ATQM7@garyguo.net>
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
In-Reply-To: <DLQXLV1FYMQS.JBP531K4P4T8@kernel.org>
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: bebb9bc2-613f-4ea0-be4b-08df1d597e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZUmCtViMO/5NZsuE9w7feMVxWz3uo/o28Opp/qnDI5U6lFW/hfqQ2mhH0ZjMagaaBv2z9sCYYVGbiTdCxpPCJ8fxjQZfDuevXbX8h+BgYUEJCDWB+o6SWQ5E15oh6j1+TTaRNdn6/7YZg+xD7OjLLOF2P/JYnceOF7RRxdKJgqaP8iFNjFQJky7O4//DyfQI6l33UHSvMLwxUgCJUG5yDfYgGRb0jaDHpCRhizAJoGnvkEhdA0RJ+8s/7zxotmpN8kyM35A+hOfR2uWGCzoWpahpL93UKD9GE34L20dKVooNIr3GFDa15DUWw/a18KXVsRkrxwqQU3yQ8k/+ypaBUo4LIHR03UAlJAEgOgStWaCIM0JBUu2x5jJ3bFnz5AznYX4FUqjSs5FCqLP/iUYD5H5aLgPGAP0QK1Kar+oYOvSTzmkZ/RkBUdjEQKca0dZpXYDTFGdnMyTGkGAEX+4XFy5lA7rbEFoNany8xlk2+hDdSGoH8PcNRaNJMgx8xANta5pwGsoFAsZ/Ud8ffyTwAClFoKrLEvK725S+mX2ufi88cl3d8wQpFR4S5KJYuKAnKVnymMSZ7KuzzdV/cP2VGjzjKDiMuWpipnfmD+IZ8EjP0nVBXSqipAIRBeZglayUir5AqReDf+uLOeWlDh3aQkwwOE/cBZTU5vTDxEFOwwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG95aGFYRSsyMi90dnpzV0hNRjh5Y2VqdEJLNTJkUnBnVWlST0g4cWpJdTl0?=
 =?utf-8?B?Vmp0Umg5b2paaVkrbkdkTjF1S2VoSk8wY3ZmZzhTYSszVWQwcWxFYnJrbVlj?=
 =?utf-8?B?ZnJlNUxac3JtYURXTDU4L1MzQmpGbkIzYk1ObXRjRXNSUDhHL2NoNFZjL3Zl?=
 =?utf-8?B?eW1WaHNjMDVwc0ozQ1AzakNhNG5wcUhMM09kb3RlQk1Xa0gyS0lkemh2MWow?=
 =?utf-8?B?RlFIWXBhdUxxZ21POFEwUVZYRFUxaTBaSGd3UEdaWXZvS2RFNjZGem5QdWI2?=
 =?utf-8?B?UHVNbUVJcjV2VUsyVmJMUytIZENQUFhaSjk3d2tTL3FMVUxlZzhENjdaelBm?=
 =?utf-8?B?L3ZKU2duOUJCOHlTVjdxa2pIdlpVZDlHTEY0bGxweE1seXYwQUZNNm9DcmVH?=
 =?utf-8?B?WVhPckFKWVl6RC80Yzh5WmkvWlFLUVE3MUd5UlpGSnBWeXZCWDhid3Y2eEc5?=
 =?utf-8?B?eVkvZDBZUzBjK24vY2wvVXFRUU9TK0tyUGhIN0RYbUZnV2FrN0hSdGNKeHBh?=
 =?utf-8?B?Q2Frak9yUFlNY29ibTRuM0VHL1JiajJ0eEdEK3o4WE9hZnJ0RTFxWHdQYUNs?=
 =?utf-8?B?WTE4TUI4ZzZybXo2WVdjaTN6dFB6TEhsbE9kNEF0dDRCY01iMnBvbXVVSUhI?=
 =?utf-8?B?THNRYU5WQmpaak9oVTJ0MGRmL0NpNXFZL3dXRHVIRlJBQ2FkNXg2ZWhwbFdQ?=
 =?utf-8?B?Z2JYbGVYZFgvSTh2OCtuaVU4cmRFOUtpZ2RTaTQ2dTgxNU5wNko3OFBXcDRl?=
 =?utf-8?B?T3NsbURGeXNmeS9ERHBrbU9vY2NOQkFoWmhRY0R1cFNzL05TYWVEbjlqY0li?=
 =?utf-8?B?eGpkcmt0RkI3d2tkMnlyU0JoZS9RYk43VnZNYnEwdnkrS1NmYnFxRUhRa2pm?=
 =?utf-8?B?bGp4L04rTENDSlhvTHZjTmVsY08wUERQTWpQV1RveTVDbkFGL3dBbVpRQndy?=
 =?utf-8?B?MjdMdmU3Kyt4OVRBZHhOK0E5MDhDWmFuQkhvZTc4SytSS2hJdTVNcTZibkNz?=
 =?utf-8?B?N1VyencxUVFMN1pIOVVDRzJSTjlvMkRLb3IyY0N0NTRqRGlLa0h4NVRUU0da?=
 =?utf-8?B?SHJjYXQzblFLejNCZUdWMkJ0SnB1L01veFFDYm9OKzVuY1lGYUdvQjFuR3Av?=
 =?utf-8?B?M0oweko0VXJqbmtBVyt2WUgrM2pVSlI0Nmo1Q0I0em9jdGJGSWpPWnN1ZDJD?=
 =?utf-8?B?MW5mczFBakttQVN2S3FVMlhyYnRKYlpBNlhoVkJnU2lRbW90eTFhdHRwNmFX?=
 =?utf-8?B?S2EyQUREL2s0cm1ud1UxSTRCMEhISDg5L2xwbVhEZlBmMkI4cThDWUNoUGlt?=
 =?utf-8?B?RXE0bXlGZkpDQ3BKNTVaZUdaQkRreUVhOUppQk5KSGdNcjFtbU1zMlFKRjZH?=
 =?utf-8?B?YTRUUXY0UEpiVW4zUWhuOXQrOFhIQVJuYUtKcjlkRE1jN3EyV0pTTUVWd3dz?=
 =?utf-8?B?L3lXZW1wM0R4akl4WDNIcnRLby93QUtVVHZISDhFN0xRc3U1Y0grblRmU2l6?=
 =?utf-8?B?Q1BLRzNWWU5aNk5DSkY2eWlwa0NoS2dMa0F0MjMyeml0RUxBYzQxU2ltMUVs?=
 =?utf-8?B?L0ZWemZUQStOUjdHck9aekpLZ3FNQkI2bHZJVVRIQklmU0tIVmV6SXZTNDd3?=
 =?utf-8?B?d3EwanJhTzU0eE9OTEtDWFhvaWkzc3ZwaEhBdk5kSVJNY3JVZ2xLMVN3L3Yx?=
 =?utf-8?B?Zk9IUHp2V1dDek4yZ3dBMW9HcmZTSE8zT0pzOVk1R3pHNVlnZ0pxd3Z2T2Zs?=
 =?utf-8?B?MWlXUXcycmJheXpvTlp2VElzcFJEdmUvWVloYy9waGNpdWNiWGVsTlZKYWZX?=
 =?utf-8?B?MWdqQmFsM2hUSm5vMWdNOUw3cWFJb0xJaGNucTNGeEMzL3dGbHNTSUFyNGE4?=
 =?utf-8?B?Rm1yVWlQNTA3VldWMTIrQUtNUW1XUjRLRDJxOVV5c3NYdzBRNHRkZHFMN21R?=
 =?utf-8?B?WEs5cittVFRuVG8zeUFhYnc5aWRFZERyT1BxNmpSWTFMU2g0cEZwUUt4VStr?=
 =?utf-8?B?OU9kOTJsYUphOVBxcjlWRG9zTWM4QXg1U1BWQlNJcU12aloxa082ZWdheE5D?=
 =?utf-8?B?c2lFbnlkc0FSWmNmUktLTkFpTkFweTlZZHV0MDJjU1ZPa05HMkhvb2picVhs?=
 =?utf-8?B?RG15WjNFL3hQWG5XQXBLNFNtZUZaZGIzRkZ0TUVVMFdmQ2JnZVRhbzl2dnkx?=
 =?utf-8?B?YTRYQUkwRWdOek12VmhuMFpQTjJwRW05TzNpMEcxTFc2KzcxUnJlTjJwYXVT?=
 =?utf-8?B?RDc2bnlaNTEzenQ2SThRWmE5N1dSaGRvcWtONHdzNGlXNlI3a0VuVWRqQ245?=
 =?utf-8?B?N0cwM0RxMHNIb3dWbU1wamx4dFU1UWI5d09vd283TWJrdC9GOEVUQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb9bc2-613f-4ea0-be4b-08df1d597e2c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:10:31.7086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvTePylrdHMhe5RHI7CWVOQdxegZDUTkXSyylGDqLQ8zgf+3dSX6GjiNs/QdJGQl8bJByX9kuWB7ldPFL8IBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7805
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

On Mon Sep 28, 2026 at 1:00 PM BST, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 1:36 PM CEST, Gary Guo wrote:
>> I think this doesn't need to use `pin_chain`? You can do
>>
>>     gpu <- ...,
>>
>>     _: {
>>         #[cfg(...)]
>>         gpu.run_self_tests(pdev);
>>     }
>
> Unfortunately, this produces the following error.
>
> 	error[E0382]: borrow of moved value: `gpu`
> 	   --> drivers/gpu/nova-core/driver.rs:140:62
> 	    |
> 	119 |             gpu <- Gpu::new(
> 	    |             --- move occurs because `gpu` has type `core::pin::Pin=
<&mut gpu::Gpu<'_>>`, which does not implement the `Copy` trait
> 	...
> 	129 |                 gpu.run_selftests(pdev);
> 	    |                 --- value moved here

    gpu.as_mut().run_selftests(pdev);

should work?

Best,
Gary

> 	...
> 	140 |                     Pin::new_unchecked(&*core::ptr::from_ref(gpu.a=
s_ref().get_ref()))
> 	    |                                                              ^^^ v=
alue borrowed here after move
> =09
> 	error: aborting due to 1 previous error


