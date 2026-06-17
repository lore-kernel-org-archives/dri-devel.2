Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E44CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F8010EFD8;
	Wed, 17 Jun 2026 13:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="sienJCZS";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350C910EFD8;
 Wed, 17 Jun 2026 13:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euYLi1JI6d6CJx1czVtT2XIXUadtd337xSAqBwsve/qDYRH90bYH0fYhvO0MaTX9aHBYPLrTRRbh60wceZ6clrtmmU3GEJ9qDm5YN7WRcd/Am9ZURigIvw25gpDb5PK1a2FnmaZXQdfsvhAn+I0JwJ3mM0Qshw2Q7C3xfqVSJ4PT6KmQNRyelgw9owfIqgsWBRAFEK1/klklNtZsUlBamzimoMsrKtvTnc5mzVln0nfNH9LfziFX+h5mXO3su3xA+M4P0kschP4RhhKI+993Y71VmFpUlbuK3Ep7f+BFXYQnyj0SXVu6uAluYQTlFMPVVSKYrwJSNn1cjfW9Kvkr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9jDQs0NpfjrVs9MJbCc4QRv3ZemO2Kk05tg43lNRHQ=;
 b=vjIr2DbTfAJeq/T1axOMiPl8P6ExZL8kMZKBLl5KSiu1tQliCpE0EkINnycl98rmeM/XyUcFgUsGeYTA/2UIfT8wRbZo3lE4cbHZfHYCvVq0xSbOO1QA9zs4A0lzHB/xysIQzYiI4ElAfXOeEWxPZ8OSZ6/hq0vqhkhcOkS2TxagOMymfLsJqXJQwkjZK3RlUJCrU2dWIlwDIMAvy5iKhQMQ1n2iG3uSo1yLqT7W2omQYVY/28KxNR20PGO5Do0LUzchw5uOkljkzh/+vXDwoArNZWilIs26NA13wnRcf7DDxpPDABCS4+IPU0lVTTIW2vqWMmhDWWv1iUIROg2Tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9jDQs0NpfjrVs9MJbCc4QRv3ZemO2Kk05tg43lNRHQ=;
 b=sienJCZSipQibWHBeaw5OvFP0pI6YMqjbF5ssmQfrmRR+sgbcIPQZ3fwF8hJB/1rMP2ck6RtVJJWoNV2uILhtnmRUxywbhVQzJWHaAnO7onwhZjZJq0zWo7KlsHTevKacmEASstvlncwzw16n5Zrlg8ugpiYmWEF6+NlYWOWACI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3165.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:167::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:52:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 13:52:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 14:52:54 +0100
Message-Id: <DJBDHLVDG7LU.VBPNFIKARCBL@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 05/13] gpu: nova-core: gsp: keep FMC boot params DMA
 region alive during error
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
 <DJ9SQ12O99GR.3TDJ2L39P03GQ@garyguo.net>
 <DJB2QJAXEDVF.2KUIUQ90Q818W@nvidia.com>
In-Reply-To: <DJB2QJAXEDVF.2KUIUQ90Q818W@nvidia.com>
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3165:EE_
X-MS-Office365-Filtering-Correlation-Id: fe296e28-6860-46da-771a-08decc77bb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: l5jma38OKSdnSw0AWz0tIDLWpOVQ03xNhUKgRHyLMGbfiFL2Th0nPDcQxirZXBPvfYow1njePtEXAR3WQxTY8aqxOgiCuPrktFnrEW/gv9mFA9Ljk+tfMsfQmRqjmRsy7qhvtLRbF69KsBqoWrs2Asd1TToM92qDwshFrJjLW+JaY6zcn+9yF4J+6ipKuz2we3lbu+ATkmLHlclGzr7jufXT+xIa7H7urj9ZadzNm+4Jx+vqK3/PULz4lS5oHpz3sprX6T9UJZeekQ4MDA8vq3Qya4pgfCKHXycpJNQj4DFlH/dxxtJ3PpMGMi3+apZ1/w1oheRNBjENe29N3ArzZu9ZTmKPITEoaEvQPBuCWYVwpbdBcjOrt4jp5g4pB2aId248Bxg4xw7yWY/nz+Og5Q48HFkK3PJb1I4g1gdJ2YJ6WYEgfTX5i7tEKA/xQI5SM0s7RCQ1vgY79++UdImymQwPwSOARMUO29j7r435bXE4E6BtFEWvY+AFxk7TAxe4uSOZnkPWq2u4nooBaxXJyJMxzuenQjyGEfvHqZ2Y/4vm1R7XQWVWRjefD8az0m0TVtVqISqBUG9aaaVlOe9rpVLEebrrtvy39M94w4lI9H7oxCmfVTJ0YH1Oyzt0hz3+Q6qpvXpNKbiakFKiQAb1A/8Dt2F8hb04DbUXuf14nV4r3lI4zfT4HXWeytSDSa8T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xoSjhsSk0zRURzd3A5a2o0SlhmamdraEtJUnZmeWVYbnlvTzNnZjE0YWxm?=
 =?utf-8?B?WHI2eUFROU9JRFpudThuNmF1cUNpeFF2Wkdrd3BZTEFXOCt6Y2E4dVBneE85?=
 =?utf-8?B?UW0zblF0dC9uOUtveFZMK2tGMUIzRmdDaG9MbG9hUi9RV29uMitqU2NpZ2la?=
 =?utf-8?B?eCtYY3Y0UWlXbnBiWmJWWTFNUEZ3czVWMnZyaytETFNXcHQ1eGJhRGVvNzBZ?=
 =?utf-8?B?dlhQWS9MTzdwUzJHREhab1l5VDlYdWxkWXFMUFh0M0pLeTRVMVpNTHhxZm0z?=
 =?utf-8?B?NGlOWmN6ckYyWElCcWY2VWFqckd6bGd3Ky9sb1BOY3lROHhGNVNjNVBQN3Yr?=
 =?utf-8?B?aklWZlIya291L0lVbUt5bmNEZDVMSDU3a21NRUpYMjN5ai9yWnV4bXVlbThC?=
 =?utf-8?B?V014NE4wQk5wd2pGb25yKzhjOFNaN2d6ZGlIWU5UVGNaSVRqRzRmclJEK3dy?=
 =?utf-8?B?emwyMzFTdHREMFF5SVFhdElJOW5LV2p4aEhMcm11Qmd6NXFwd2JqeFg0cU1Y?=
 =?utf-8?B?MG40WGxvTnI1aDJCTmlDRnVSUXc2ci94S3lJeFNuUUlPTlQ1c0I2WWF4Nzdu?=
 =?utf-8?B?c0dhS0tqL3NJaWR4amU2TkM0ZUF1OFNWbU1saDVuTlJwb1hpTkVvNnJ0NGZV?=
 =?utf-8?B?WExLTzFmdVc3MDN6T0REUnk3KzczNTRIWTFTT055VEpiWWI4MEFvV21RUGg2?=
 =?utf-8?B?ZkdGRGRWeS9kWVBzZCt5ZnNtT2RPeDFwN1hCMEVKeWx5UXhRVUZUR2gwNldj?=
 =?utf-8?B?SzEyeWFIdVV2Tkx6MlFXV2VLWlp4eDZXTThzRmFmMnN0SjMwNDdya0RleVh0?=
 =?utf-8?B?TzF5NGdhWHEzdk1vL3NSclRkQUsrSkE3cHNlOTFERDF1MmFtOXdja1FKTWY3?=
 =?utf-8?B?dGtGVzYwa1liNmhERVMxNWtaanY4WU1hdVZaM29XMGZkbW1rN2xiV3FkS1I3?=
 =?utf-8?B?SnFYa0QwSWdYNTBDVnZydUY2amNjNDQzcmpuYy93dDZZUlRsZm51MVRxVytt?=
 =?utf-8?B?U09KWkNoYm9iQ2RyT3Jaei9pVzVCT0JhVHp4a2x3cUZUMXVicW1MYnhzWUNW?=
 =?utf-8?B?U29IMWxlZWpNQ2hVU0ZnUUR3ZEErTTJKWlBJK0tDcFZ5b0ZPTGRuNERxZ2tq?=
 =?utf-8?B?YVZDL3FUMkVIbjUyT0RLcmhXazVkT1kvT25UL2F2cVRkN3JaVXMvcTI3SDd5?=
 =?utf-8?B?MnFYWU5ib3dlTDRySmdFbWd4WDZlcUNNaktMeTNRQXIrMU16UTQ5bktNV01v?=
 =?utf-8?B?NXlHZGlubWJraEJNU1NlaHVXZWpEZERhTi8vU3hjS0RsZXVEM3NSem41cW5m?=
 =?utf-8?B?RWNpamRnT1JqNjE0YlZXM2RvVTExeGJ0UUZ1U21MTGFCb3Q5Y2l5MEJuakRP?=
 =?utf-8?B?MzNzVzlGUWRrTnEzUklNb093d0RGcE9iS2ZhVkUvMWFIa1lxNFJrdlU5SnRi?=
 =?utf-8?B?Nkt1NkJMSzljNENkVEdKci82Ri9kaHVvRUxXcVJPMng2MDUrQTQyTU9nb0Y5?=
 =?utf-8?B?b0ZSRzJBdStYUDl5aWlKQjNoWndlcG84NkFkNFpLdldRWDByditQTThySktV?=
 =?utf-8?B?RTZQRlI3U1BUbDUwUXJrNkRpL2taZkhTblFINysxVGJlWS81bDFEaVlsOXhN?=
 =?utf-8?B?aVVtc2t3NUt0RXAxM2FrbE1pNG14RTNVL2R0dkwram5TYStmRDlpNjduN01L?=
 =?utf-8?B?anluRHJmbFBIQWZEc2diRUVDM0lnU2F3UXJnc2FoRHpqd1VJdXVwQTY3Vjly?=
 =?utf-8?B?NUljZmJ2MzBMUktJVnBWQktzQWxKTzRJMjh2eFJmdmxnRDZ1UldtZkR6T0tR?=
 =?utf-8?B?SlZRdThtdjVNaEw5TTNGek9DaWlrUFBobmhhdVBsUC9hNENUdG0rQW5OQkdX?=
 =?utf-8?B?WkloeDhxdEo1ZUdEQkZCTUF2SWN3alU0a2tnWGI3MjErWkJtR2VDZDZER2hK?=
 =?utf-8?B?Y2tuRU1qUlMvUmhVWCt0c0JlSmZ4YXhyMTBEMXpGbHlPTGtWaGF2dTAxbFRL?=
 =?utf-8?B?T3c1VXhkUXNOU1Z5YkNPZEZtdkVKMUN1dFhvUU9lUW1CS2pramFURmlhTVhm?=
 =?utf-8?B?Um0xcTVUbThZQWRrVTBJcjlNYWsvNEFFT2tHbnArUGQxM3FXKzlrZ3JQMi9Y?=
 =?utf-8?B?NCt6ZjBaSzJTckdZV1lLTWIrZHZaTHNrQjc5SnpTWjFSNGZ2MVB4Mkdnd3lN?=
 =?utf-8?B?ekszRzE3bjE1M2RnMzB2dXFXZnplWVlRaGJneWFJZUdhaGplMXlJSzNicTcw?=
 =?utf-8?B?QUZFcThhWCtxOXFjYU1Hb005VURhUXpuTnBLSzZERFg1MzVlZ3IxWHVSYURD?=
 =?utf-8?B?SmdKNElDQ2h0aWNoazJ0c1BtcnlDb2FuV2t2alFIbklSK1RuSzVEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe296e28-6860-46da-771a-08decc77bb10
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:52:54.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO9kzo/hZzdWA46wXmyCn4zs9hyp9HTdMqH4IueKB+TyQXUHZ3azsSSrDjS5Iai6A9pEQfR1KDc+GRrC6vnnxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3165
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

On Wed Jun 17, 2026 at 6:27 AM BST, Eliot Courtney wrote:
> On Tue Jun 16, 2026 at 2:23 AM JST, Gary Guo wrote:
>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>>> Currently, if, for example `boot_fmc` fails, `FmcBootArgs` will be
>>> dropped before the boot unload guard. But until everything is unloaded,
>>> GSP may access this memory, so make sure it doesn't get deallocated.
>>
>> Hmm, this looks very weirld. `boot_fmc` only needs `&args` but it actual=
ly need
>> it for much longer?
>>
>> This is hinting to me that the signature is wrong of the `boot_fmc` func=
tion is
>> wrong..
>>
>> What is the exact lifetime requirement for GSP?
>
> Once `wait_for_gsp_lockdown_release` returns, it no longer needs the
> allocation. In the case that we get an error in this function, GSP may
> be (asychronously to the CPU) accessing the DMA memory we gave it. So
> FmcBootArgs should stay alive until FspUnloadBundle finishes (GSP is
> reset) if there is an error, or, until `wait_for_gsp_lockdown_release`
> returns successfully.
>
> So for `boot_fmc` to cover the actual lifetime it would need to be
> responsible for waiting until GSP is reset, which it doesn't feel like
> it should be responsible for (even as some unload bundle that it
> returns).

I suppose logically the GSP does need to take ownership of the full `Cohere=
nt`
until unload if this errors?

Best,
Gary

