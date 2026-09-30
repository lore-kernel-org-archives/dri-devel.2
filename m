Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A89CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4ED10E300;
	Wed, 30 Sep 2026 14:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcXttamY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E8210E300;
 Wed, 30 Sep 2026 14:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrxRVesm5wjidSCrpHMEAKQzOZ3uvT1+hHo1gIt+agkqkh9U+XYwIsoYm8OH0Isn0iLY7ChSZIgqE2M249cUeQR+wHUA7K4IvfsTH/5/f/FyjYM8X+YzU8WzVYlLWIWu5M7e9WLS4hwuBcW2Bn2JRRIbsiLAThDEP28QgZhTgPdwuWHaqoJGIqb3Mzzb8Zjf2cA5EFib7/3o5fcnSmjZL/1pYNqYXRyoG6p9q/6ofLQkgPj61J6ME5co+1uPTkRRqUeDtQgUU4c778ghTIS/3kTor2yfav6Dm1fHgHibxrZWzJoXvnUUd4ZjInWSPJ1ubFkVATac9T/9mFUYAWdp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azOc5EJvy3AhV7o2eg1cefKeicaEh1+bo/KBiryc5O0=;
 b=fOT5CgDnEbNUy6jWhx6qA6tR8UCh1JN8QmIIMXyMKyBynGzKqArtbM88UhheCBrLPDraqzrKXvfKvExKVXB2Ynm5S2Da+Uq/7wptUpcfzqJzD79dCRLrxLQxDBbBEqvU/KWIEZ2RgwGAXbchVwgJjeXU/ZGSk5c01M/PCJubhffRt97LZXSOl7DTakjwbhFn0tvYNuN6thFneET2lZYaL6kIlmw6phRgn5ugjzckwziPL0sO22vamUXXIhelZEU1EaltQmCwqAKUPMHzwygCgkHZbhJuc/cZd17O5hs7NRckh2EU1v6TT/Ycon4dPNvKX+8Dm6tL26NWZar4RN9lIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azOc5EJvy3AhV7o2eg1cefKeicaEh1+bo/KBiryc5O0=;
 b=rcXttamY+kGheR9r6TRV1bzmKxrJILRK4YytoyXgNhKGhpxu7uAb9b4nUvxVN5U28TreSbsHleDQiytZV2VZnEqXZathUd2y28IwDz3XyhlqywnP9zvnRSYERudJt6ecZe3EcDmshZF7++Dw1QWXQuG0rNImrFdVdTY+pI2nDUFGBlZP5Cb8bNdtqvaU2EK4CoGXEGEn38mLORVYBl+PhcHAIfQJ43TL5xucDb8K00YALo7B5y+5OGONdn+EnPI5L8eGvmFhBnnfG9kU+bthBcDUjQdU1NPONOFBTlP86anOgwEVErDMiAdZF8AZFlIMh1q0lWU8qzKCcSjGgpXDPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB095541.namprd12.prod.outlook.com (2603:10b6:8:498::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:18:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:18:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 23:18:09 +0900
Message-Id: <DLSPS53NPYB9.1H9UH2Y6JV49B@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/9] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
 <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
In-Reply-To: <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB095541:EE_
X-MS-Office365-Filtering-Correlation-Id: 581e0130-bac0-40fd-bcf3-08df1efdaccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m69imjWLC7/BcXzSgaKqUBE2mdE7BkYSLieBy6QswPE4ea4UeK0nzYRH7hqD8lNjDwU87LT//wONOYoEZej0KZcenieVyvFNSe5QowtbdJ9Cm3YueP4GxzSpS4sGFyQPfpjyvLhGk+bGcgqUUit4UD6EuE3JwoO2RTysKN88zwgz/4qgugRUNNgJuFggSfwL8TUr8avUIBrHoe3/OHZ85oD+vbrQm+DkC030hPXNiV2KEf2gYd77SbX7c8VeDMkUkPbAKfWdzq6jQFePEAMBqXZedMkeic6t+rtDiOl9KANpkwTx4Wlz6DQx1HyoWWiN6g53zzcrcO1D9eD+B43Y4CGHNQjl1IW7/aAYaZ3KTyiGKhcgizPLbUwnY0fR/Ngg2ZMyKUAK7/AJO4c28tSrULNG4QtVK5UIWZaM4M+o2DxOgayScYpkdMVbeo2TslciKk51AZqTGiIcjAzxxF0AUpJIxe4q6jZcql/DEl+8BH7fFiZZNtRDuaonWbo61w+rh7GLU8QXtenht3hNxMiC13zCLzYuOC+gwpHLRvERJh15374GvLLCU3dTZ10FNW65B6sj8XC4YhWkfsYTEOycaWvYZ2cYbXR9f8XwHlDOp0YGC7/57oSbuXDi2HXeC0UyetJZd6cg0VsQEsvqIdWea8jJS8I224FcF2w4AkFXn/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEYxeExOWWFyVDNOaEd5K0JRaEdCMDc0eWFNbWJlTlJ5RHl2Y2I3S0xtSnRB?=
 =?utf-8?B?dTBybUtYdG5qTittNzZWL2xJOXEvbWJSMndLQXMwbFlaTGhnazNvSjY1R20z?=
 =?utf-8?B?U0c2NVdpUC9XRUgwa2tKQm5RYnAyKytOV1VpK1R5ZGp2bjRCWTdHVVBSbXVZ?=
 =?utf-8?B?c0NVbzh5bFQ0UXhkUkhCczhMbndXaGJ6dkdvZDZvK2pQeHY4NzVFa2pUSkdL?=
 =?utf-8?B?ZjQ5Ny9Gb3V2WE9OcENmMnRXd3lRcFZHV0ZYNDhxa0JHa1Z3WkJGVmtaVVRi?=
 =?utf-8?B?VVZWVTI2OXJuTlhKOVY5dTA4aURMRkM5NWNZeE1CM2VTak14Y1p1OUVxVTNE?=
 =?utf-8?B?bE52MTNtd3JXOGE4cXYzL0dJMGcwVk54ZE4vOFI2K3lKZVcvcHhDN0Z4UTQ4?=
 =?utf-8?B?RUtIcE5HMSswZHgrSzB2MGtqNmgvRzdCWDRhcUkwTHJBUDVlc243SjJ0YTdC?=
 =?utf-8?B?TzIvUVpvam5TVXMxWGdMc2R6RVZNK2Ezb3grUjZOYSsvVys0dklnN3BRVWZF?=
 =?utf-8?B?TE4wUnZVWHRzekhZUXZPcWpyVUkvNDFhVmRJMllDTTJCWm1PTjJlY29HWjZR?=
 =?utf-8?B?TVJJbENHR0xwUjVOaFZpR2FlaVlSNnRCb2VNbE5RVkFKK2dyMGc3aGNWNmtF?=
 =?utf-8?B?SE45eThlQlI3V1FrU1hXU3JPMFVSS1I4dEhNTlNJTExrWGhIY1hUVTRkU1dz?=
 =?utf-8?B?amdVb0xhdkNNUFNVR0J0N1BEeFRGcDNPbmg1ZzhQcDVJdEFPMkQ4SWpCSVpy?=
 =?utf-8?B?akVnc1FYQjFQbjZWbnV3QmNCMVZpS25jamdKaU9rRElqQk9mWnY5Z2h3dkxX?=
 =?utf-8?B?emJBVS9ra2wyK1c2TGx4cmdCUXM1ZXZkOS9EMTB0SnVRcFVIWVlhdk5rVS84?=
 =?utf-8?B?ZDdaaFdHOU1Jd1hFY3VpVzRJN0oxaVROdnF3NnAyVHBzaWZHN3ZSSnpPVThz?=
 =?utf-8?B?U3JNUnpXRkRaQVlUa3g4dWdSRWlnbjgvQ1gzL3habVdiZXY0WUY4eUVTb2dv?=
 =?utf-8?B?dFRBMzlSbm8xK1Y5L0Q5dFU4c2k2L3pFSmxiL2p3akZtbmEydE5NWEdNODRJ?=
 =?utf-8?B?YjdKS2ZwRWNQSFpwKzE5a01GSHpnemZqMU5YYS90LzI1V3BtTk05amVyM3Fh?=
 =?utf-8?B?S01kNzQ0RlZVT0ZVZEhXZlR6UlJNeFBnSlRQUVF0V3NUVFpZNjQzdmhRdzlv?=
 =?utf-8?B?WGxFWFN0VlJYWGFpR0U0c0RwTVlrK0lHWmdteUdMLzdqRXdpL0FiWEVmdFp4?=
 =?utf-8?B?eFM3cWErL3B2Z1JORnRZYU9iTnFqZnM5ZXpxdkNUenB2M3ZncjZyMkpVQ1BC?=
 =?utf-8?B?OS9zdnNkeWxWTzRrcjJoVVJsWGpKS1FWQkxMVzRKR3hYUkhCcU5yQ0g2ZENy?=
 =?utf-8?B?WGVQdllOQmVtU0pBRmRSTHRrWXhRY3F0QWxDTVdJNzl4ZEQ4M1F3dlJSYUVL?=
 =?utf-8?B?TThFcFJUVkN1SEtoNDdhTjJSVEFNODloQTllMWhJajJaSVpJREc0Z3lxUStu?=
 =?utf-8?B?V3FUc2NFWDRQNjBRNnYxOWJ5TWFSdTN6WmJaT0diTHI5b05NSkhia3pkYXlu?=
 =?utf-8?B?ZW8ySnNhMkx4bzRyMTFyK29kbFFxUm83ZzVla3dFMFdNMzFaY2huM3p1Qnhl?=
 =?utf-8?B?ZzZac2s3OWdFaDVvSWxyQW1vcG83RGVEcTFDSUFtTHo3L0MzeDUrTzFyT3dQ?=
 =?utf-8?B?SVlzV0dWV0ZROGEvRy9VaUtLZEQxMmFGOUVQWWdkSThaVEp5UStTUXZLckdT?=
 =?utf-8?B?c0tURndXTEs2MUw3Y0pqd2JiL2M3WEZYRmFYQlUxUlFLaFZ0dEU1Ulp3dElw?=
 =?utf-8?B?M1c4dXVIclg1TFA5dkFXRjlqNXVWUEtKdnYxMnZMZXFCbkxlRFJhbkk2bU9O?=
 =?utf-8?B?TkdqYjVVNU1JMmR1K21DWmpKU3ljS1NwU0VvOW5xUW5ncVhSSjU4b2laZTBV?=
 =?utf-8?B?QjZaTUhMYnhLT3gydWpkN1YrWU8wM3NtRWlzbDNoMHdPUU5ueW56bkUrRUh0?=
 =?utf-8?B?cXVIMjV3anNqUjBqaXM1TFBBYnBucXdWR0FaOFgwbC85QjREWUpjUjQxU05F?=
 =?utf-8?B?UzZoTCtxd3U3WXpDak1seFN3V1RuSTRFcm9zVlQrclo3aW9sNGRNTC82Z2pr?=
 =?utf-8?B?TEhHUGllTFdWTFpPS1lPcDU4UHFCV0cyUlR6YXc0dFhYdlU2NkUvNFJaNVRD?=
 =?utf-8?B?RWhpaGRxcFV6NHhRVUNlYWdXRjd1Yjg1cVRqSGtXc3hIR0RVUFRPc1JqVTdo?=
 =?utf-8?B?TkJ5Qy93cURsQXZsdWtTZHZ0amNwMjF0ZTN3dUUvVEtPcGxSYmo3UWFnVkVW?=
 =?utf-8?B?Z0JXYi9uMWpkRFZFNlN2WEszUkViYUlqWUZSK3dRc252ZC80UkpGSk92TE55?=
 =?utf-8?Q?nYuaZllRTGqCmm/w4141TX5Bw/kPUcC/VVPxv192BD6SH?=
X-MS-Exchange-AntiSpam-MessageData-1: nI+CglzHvPeVzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581e0130-bac0-40fd-bcf3-08df1efdaccc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:18:18.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G2tHtAGwChComa9YwOsDGgX6lf78DsuwAYThYGYTCJ0MFgLGFTFglBuw4E2Bi2fI8/aneOTFV0lME2yTLJ9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB095541
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

On Mon Sep 28, 2026 at 1:43 PM JST, Eliot Courtney wrote:
> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>> So far, the GSP command queue transport and message layer code were
>> intertwined, a design issue that goes as deep as the types themselves:
>> the generated bindings for `GspMsgElement` even include the RPC header
>> at its end.
>>
>> This makes it difficult to introduce the new GMC message type; thus this
>> patch works around these limitations to make the RPC message header more
>> explicit and allow it to be eventually handled by a different layer.
>>
>> The `RpcMessageHeader` wrapping type is introduced following the same
>> model as `GspMsgElement`, and can be obtained from the latter. The
>> methods of `GspMsgElement` that actually query the RPC header are moved
>> to `RpcMessageHeader`.
>>
>> Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
>> and the command queue code is now responsible for initializing it in a
>> separate call.
>>
>> The only functional change is that the RPC debug messages now display
>> the size of the RPC payload instead of the whole message including its
>> headers, as they are technically part of the message layer. This metric
>> is arguably more useful as the headers have successfully been parsed by
>> the time we can print these messages.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
>>  drivers/gpu/nova-core/gsp/fw.rs   | 95 +++++++++++++++++++++++++-------=
-------
>>  2 files changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index d293d28b0967..3a8548a51259 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -50,6 +50,7 @@
>>              MsgFunction,
>>              MsgqRxHeader,
>>              MsgqTxHeader,
>> +            RpcMessageHeader,
>>              GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
>>          },
>>          PteArray,
>> @@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) -=
> Result
>>          let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.=
contents.0).ok_or(EIO)?;
>> =20
>>          // Fill the header and command in-place.
>> -        let msg_element =3D GspMsgElement::init(self.seq, size_in_bytes=
, M::FUNCTION);
>> +        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_=
bytes);
>> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M=
::FUNCTION);
>>          // SAFETY: `msg_header` and `cmd` are valid references, and not=
 touched if the initializer
>>          // fails.
>>          unsafe {
>> -            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg=
_element)?;
>> +            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg=
_element_init)?;
>> +            pin_init::raw_try_init(
>> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
>> +                rpc_header_init,
>> +            )?;
>>              pin_init::raw_try_init(core::ptr::from_mut(cmd), command.in=
it())?;
>>          }
>
> nit: I think the style is to have separate unsafe blocks for each call
> with separate justifications.

Fixed.

>
>> =20
>> @@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) -> =
Result
>>              "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n=
",
>>              self.seq,
>>              M::FUNCTION,
>> -            dst.header.length(),
>> +            size_in_bytes,
>>          );
>> =20
>>          // All set - update the write pointer and inform the GSP of the=
 new command.
>> @@ -777,16 +783,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<G=
spMessage<'_>> {
>>              return Err(EIO);
>>          }
>> =20
>> +        let rpc_header =3D header.rpc_header();
>> +        let payload_length =3D rpc_header.length();
>> +
>>          dev_dbg!(
>>              &self.dev,
>>              "GSP RPC: receive: seq# {}, function=3D{:?}, length=3D0x{:x=
}\n",
>> -            header.sequence(),
>> -            header.function(),
>> -            header.length(),
>> +            rpc_header.sequence(),
>> +            rpc_header.function(),
>> +            payload_length,
>>          );
>> =20
>> -        let payload_length =3D header.payload_length();
>> -
>>          // Check that the driver read area is large enough for the mess=
age.
>>          if slice_1.len() + slice_2.len() < payload_length {
>>              return Err(EIO);
>> @@ -833,7 +840,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout=
: Delta) -> Result<M>
>>          Error: From<M::InitError>,
>>      {
>>          let message =3D self.wait_for_msg(timeout)?;
>> -        let function =3D message.header.function().map_err(|_| EINVAL)?=
;
>> +        let function =3D message.header.rpc_header().function().map_err=
(|_| EINVAL)?;
>> =20
>>          // Extract the message. Store the result as we want to advance =
the read pointer even in
>>          // case of failure.
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 918a7ae809eb..b12034db7857 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -781,11 +781,25 @@ fn new() -> Self {
>>      }
>>  }
>> =20
>> -impl bindings::rpc_message_header_v {
>> -    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, =
Error> {
>> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
>> +#[repr(transparent)]
>> +pub(crate) struct RpcMessageHeader {
>> +    inner: bindings::rpc_message_header_v,
>> +}
>> =20
>> -        try_init!(RpcMessageHeader {
>> +// SAFETY: Padding is explicit and does not contain uninitialized data.
>> +unsafe impl AsBytes for RpcMessageHeader {}
>> +
>> +// SAFETY: This struct only contains integer types for which all bit pa=
tterns
>> +// are valid.
>> +unsafe impl FromBytes for RpcMessageHeader {}
>
> nit: these impls are not used

Nice catch, removed them.

>
>> +
>> +impl RpcMessageHeader {
>> +    /// Creates a new RPC header.
>> +    ///
>> +    /// `cmd_size` is the size in bytes of the payload. `function` is t=
he RPC function of the
>> +    /// message.
>> +    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl =
Init<Self, Error> {
>> +        let init_inner =3D try_init!(bindings::rpc_message_header_v {
>>              header_version: MsgHeaderVersion::new().into(),
>>              signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
>>              function: function.into(),
>> @@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> =
impl Init<Self, Error> {
>>              rpc_result: 0xffffffff,
>>              rpc_result_private: 0xffffffff,
>>              ..Zeroable::init_zeroed()
>> +        });
>> +
>> +        try_init!(RpcMessageHeader {
>> +            inner <- init_inner,
>>          })
>>      }
>> +
>> +    /// Returns the length of the RPC's payload, not including the head=
er.
>> +    pub(crate) fn length(&self) -> usize {
>> +        // `length` includes the length of the RPC message header.
>> +        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<S=
elf>())
>> +    }
>
> Suggest calling this `payload_length` because now we have to `lengths`,
> one which is the length of the entire thing (On GspMsgElement), and
> this, which is just the payload. optional nit: rename
> GspMsgElement::length to frame_length.

I'm not completely convinced here, since the type should make it clear
which length we are dealing with. One could argue that GspMsgElement's
length is also the length of its payload, putting us in the same
situation, only with a longer name. :)

>
>> +
>> +    /// Returns the sequence number of the message.
>> +    pub(crate) fn sequence(&self) -> u32 {
>> +        self.inner.sequence
>> +    }
>> +
>> +    /// Returns the function of the message, if it is valid, or the inv=
alid function number as an
>> +    /// error.
>> +    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
>> +        self.inner
>> +            .function
>> +            .try_into()
>> +            .map_err(|_| self.inner.function)
>> +    }
>>  }
>> =20
>>  /// GSP Message Element.
>> @@ -811,17 +849,15 @@ pub(crate) struct GspMsgElement {
>>  impl GspMsgElement {
>>      /// Creates a new message element.
>>      ///
>> +    /// The RPC header is left initialized to zero and must be initiali=
zed separately using e.g.
>> +    /// [`Self::rpc_header_mut`].
>> +    ///
>>      /// # Arguments
>>      ///
>>      /// * `sequence` - Sequence number of the message.
>>      /// * `cmd_size` - Size of the command (not including the message e=
lement), in bytes.
>>      /// * `function` - Function of the message.
>
> nit: Update or remove argument list?

Oh right, `function` has been removed. Fixed, thanks - I've kept the
list format to limit the diff.
