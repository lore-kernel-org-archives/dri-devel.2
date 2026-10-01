Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF871CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDC910E02A;
	Thu,  1 Oct 2026 01:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgZ5BZ2G";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADFB10E02A;
 Thu,  1 Oct 2026 01:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+2C5sPU+KBW7+1TrKweg9oRuTPVZ7pc5GOvJGi0Hw3aqzFvdmL9fYG7PhYV4g3vszzIiS8BIb9DogYCkURuN4cVcWBM53bKc3sdKR+HnlhIAa4PBNNgC4kFYPJcBHVpRTAULhvsH40Lce22jESs8WWs2Xpk5jJyhVaUcPymXVJZIjzZFiUl/wI/8PbWz99GtY4jQWwLNiC5vaPQIm+6NpVzVwdmafTKsr8XG3HykfSlHDRYKVPBYQjJGLbyeaSfEH8t+moD+sziXaSKHeJluLjm6OwrY7Id9mM9HXMvCp4wQzQ0hy0GUt/MkNdWeGKtdz/YFcevOxjWTlqbRWl4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16pTEj6MdhlO6qd0hyr39bh5qCvszADUUb7cInl8RNo=;
 b=QwpegdPu6VnmOMc5BXm6g6C/D+PX4ofBFGr523VtW4qN9T6O2U/WejnV01HslMc2Aq1VOHCQ0krs66P/ey/L0ndQP776mOVIb6ZUBrL2RCnbipSmeg7qgxU6/h0Tfobmeaugh+nTpgFs/LOSWJpS3tpDDpVZUSS+zAX/jqKW/Tkw9XUijiT/qPYyMaP0GUcFpdL6A41RFLlWMYfZaH2tp4ExEiRscpTquqLfZlicBJflNfP8viGRT3ukHAlLEOFldAT3wYxoH2plxdQ9zyRxUHQpB56/eyoi4EUIREqXpMRqm22ixcJH1UCrBuzFvueZ9I818rC6wGjN4BvXQB3dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16pTEj6MdhlO6qd0hyr39bh5qCvszADUUb7cInl8RNo=;
 b=sgZ5BZ2Gjp67YJXYAW3D0XzmiXZcCjjKmx5+jKekoPDm6X+ZP0nTnR3G2TB/8PDH3m7ipV1ElktU88fUhu1xQmz0MJYeaiuxzgNkKTEPUxXRd5fz8OcTHu9V5xtWD6W7HXhUWrDTBW6yAKDCtlVCM7oFlrou5UHatznCVJ9ZxxbTFU29mU6SCLU6LRdWPASXKZz/j/DXX23jV65qT2N67IXubmwexUMgxd69pt1KOPczoxJUipYMk0fD4xAIVM1h6plZfi3LgAZCSS0hYcaONv0y2mPeMKrTvLTMlo8V+tNtDcfLfYIwuxQmsASadY2wEo/nARBI1k4J6U+JDrgd6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:58:22 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 01:58:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 10:58:19 +0900
Message-Id: <DLT4O89RYP29.UKGBMIJD8ZSC@nvidia.com>
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
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
 <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
 <DLSPS53NPYB9.1H9UH2Y6JV49B@nvidia.com>
In-Reply-To: <DLSPS53NPYB9.1H9UH2Y6JV49B@nvidia.com>
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae53478-8869-4237-0aa3-08df1f5f7910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10070799003|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: L3dFcVUJXPtp7bwe1m6QZ6HJ0OODO6ITmlc4IEUuYE4Pw6/K7kIxlXNRL9pvYFv1C7lC8EaCNz2YrizHrEhunnqnmKbQYpMtOlHVJjl1qdiuAcjIywEyLp6tfinlBJHVvSAV7Lui5W5dOfysrzNF7tAxY4jJzbR3bs2ad1s7a3wwinAUFt+J0p7HWjMURqkNkv259Fec374UoJn+EPIymorTGseLzdicQJ5cqh5T0FQmvzUq7hT8FLMMNh+jsVQ4jlDKhuLsOWvy9G8bNfC1PnpWFRIy1hLfQuj2jYmOjZY7imp81yVtlc3l5uEAHNMuHsSGP65ZWOWkOREpgXsC/UQD5arvr+vGxZKsb6hNuGgfMpTD5MUlkyxRkz1yaLfXz6IrkQH2Mj+PKvgqQ6xcV4plNNlE4u6s8NPnX8ym1jP/PTBWRH/a+BswDOwJf+222ClORJ07a/TV0kqKlAQePe/3p/SCg/B56vq+AeR7+MM6mu3x+8dLxAUFS4bFXwXictX02RxM5FLn40pDEzJVTXUGsEWAfuD5GGvIXyxivLLKsBqLp4ytM2UZvGq70iOvF0cpBqwH/9zDMPMz7Q668phZQszDs00F+vm1gcSSmUlVG2Ptxdp9CnPyXB+HETf8HsvwuzAtMsFWHorjn/UcWGkCydZcni8H3ZRGzZxsi6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlc1SXFzaWtHbnlWRG14aTI0UVpaTGVzcGIzWEpWcVVuYk1uYTFkOVFjTU03?=
 =?utf-8?B?dFcyemNsbGZkRjZNTkNldWdrZXVVR1hNNXZ5ZUxEMGFsV3ROZWl3dlIzdmNB?=
 =?utf-8?B?OWVhVzlVTndiNTNxbHU1N056UnZhZzNpb3AyL3FVQXBtYkJsMVcxOXpLZVE0?=
 =?utf-8?B?Mk8wb01rNUJiaUlFUFhzMVpFdFVxZDBxdXlwQUdEK25OME1IOW5UajFSR1U2?=
 =?utf-8?B?MDJyc0E2Rkp4QUU2MHc5ZXRIeUF2ZG5tQnN0TVAxQVZFLzhxUlhPRWVTR3FR?=
 =?utf-8?B?UjlhUjd5bHBQWnhINHZPbEdhb2FsVi9Qak5kTllsMEZYNzZSM1FtWklUcU5Z?=
 =?utf-8?B?UjJ5WGJ1RmNwc3BkK0dWbjdRTnNGL0VsV1ZUZEVnT0tuTmx5am5vd25IRFdZ?=
 =?utf-8?B?VzJxVndLK2V2UGt4S25SY1B3NElOMmlrR1VNY1JpbkZpYjFXYVdKSEgvRFI5?=
 =?utf-8?B?dkRhSTBmRVRuaTFaUkMwOHJGbTNRaGJGVjAzUzEzZDRqUmVNanhGR3FzVmhw?=
 =?utf-8?B?M3FKQVBRVVNkb2JiMkhRbmJzKzE5RkgybWR1MDRUQ2pkVnd4akpPb1RFdTMx?=
 =?utf-8?B?dVUvQWwxcmZBVzhJek9ZcEVxNGh1bmxpcm5QTCtvTUhYZmdKNGZIRUtuYW5V?=
 =?utf-8?B?dVg2MkN1QStkK0JHWjJNNUc0ckNUMm5xam5sNVZudWxyNS9vMlptR3MvOTBk?=
 =?utf-8?B?OVhDdGF2U2pSYUJiRHZwdW1NZUpkajlVeG9OQnBLd1k2Z01qQTduMVV0Y3JR?=
 =?utf-8?B?NWpyRFhINmdJeWRhT21ld1B3dnQ4RjJvME1JM2hLWkorZTIrbjZCbllvaGh6?=
 =?utf-8?B?UTFBRUdyMkNpUm1Vczg4NmYvZkQ0eVFveDk4eEUyNExuV1MvcExEWUZkWEtt?=
 =?utf-8?B?aDN4RzI3MkFFbmc1aStINkRqYTI3bnY1TzFROTR4RTdTamJiMVZ2Tm9BVzM0?=
 =?utf-8?B?d1VWczU1em1ReDhhbXBFMXVJNHhLVWV3ZlF6d3JhazROUEVrZ1VBUmhISkM2?=
 =?utf-8?B?U2k4S1hobUhwZmNzYnpSMHZkUTBib3lZOTFvYkFjbkxWNWZJUHZQUTRtRzM2?=
 =?utf-8?B?SEVxS0FHK1RYV3NFSUdiR2grYitiOVNqMW5aVzBFaVdqK09UdVc0MDcxWUxp?=
 =?utf-8?B?V2tWNDk2MEJiY2JMSFk5K2JrbUZBbmFhNk4xa2sxQ05FSExvNGlNekJjK0E4?=
 =?utf-8?B?ZDY0NG1mazJQOXJTdmdMSFFXeXhSV2lod2NGdENXR2MyT1RqMW1zTWMzRmdw?=
 =?utf-8?B?ZFB1ZUhsRXgrczlEWEUwR29nVXhqSFU3dnQ5M2hPOUM5aFNaRjRFRVVlM2lY?=
 =?utf-8?B?aUVxRFNwZ0EvdWFIbVMwZVRPVXVmWEs3ektsZDZJNmF2T1E2R3ZuWGpZeFpC?=
 =?utf-8?B?ZGZHMkRiT0o3S2UzVWRpaWtuaHVvdXFXQUQwZWZNanl6bXlPaXJQUFhZak9j?=
 =?utf-8?B?ZDRRNWEybHlGRnYxdzNzdXpFeStROHVmSGlwanRpczljNUF6cVdkNktuWXNh?=
 =?utf-8?B?NW10WHNRdTlmT1doOC92d1J2dVg2QnlkNkFpT2dJYVdINlBsVGQ5YVA2R2pG?=
 =?utf-8?B?T09QSEhNV3c3akhTNmJKTmdISGJaY0RHRklPNHhkRDFHRXRuWFZLclZ1T0Q0?=
 =?utf-8?B?ZkVuVkdyVnhacHN3RThtV1VRMGtVRDJIcXR6dWxMQXJRMmJQUGxnQlQ0SXln?=
 =?utf-8?B?dUUxS0xzOXYzd2NHY3Zid1pPaVJQK2xua0VRRlNid2lrOFNDM0xMWEJzS2R3?=
 =?utf-8?B?QVlVMDdmUzkrRno1Z2gvaWlwTFl3TjdOamF1NGMwbXoyR0U0dk5vOGIzcVlN?=
 =?utf-8?B?bkxWbW5wZGNTLzJWYklhUklWbXZMbFRxRUppSmRpRmNMeDViRHNqbWI3Mm1V?=
 =?utf-8?B?QUx3M0pvSnNRVWdYVU1NYnFzb1VOVVdSVHlya1ptUVBZcEhLUHpJM2lrS3gz?=
 =?utf-8?B?ZG1TRmdoQnlYZ0plV0lSVUR0eFpKN2cySzFkeDc5NjNtR1pBaHA3bU0yVE50?=
 =?utf-8?B?NUxUUEcwQUJMMEgveHREUkZmc1hPdGp0Wm5VQnVud2o1Qlpkb2pzUS9VaW1E?=
 =?utf-8?B?czhsUTRFdkRDUlZ1NkJmUVJITWRuc2RMWTVES1B3WS9pSWdnYktvcnhPTHZj?=
 =?utf-8?B?WVFoZWxwYzJOWVhydnQ1Y3I3UWNJZEUybGp6TjRQUmNrdmZ1VnNQOTE1aUNC?=
 =?utf-8?B?c3pOdzd0SThDaisrMERwQ3pSLzQvWnlxUzBzcTMwaG05RDc2MFlPRU4xRE5t?=
 =?utf-8?B?Ti9OUVFmdjVVTlQ5S0c1KzZrTHhRd3I5ZmV6T29yOEV5Tmt3RXpiVVM1azI3?=
 =?utf-8?B?Q25OeHVvRjkxZmgyNGlaM3JTUEYyYVkvQ0JEVG5pc2IyV0VTM2NaU21UTFJi?=
 =?utf-8?Q?bBAEX/BlKCHTzKhbGzx+uZhOrQzOODFqzQsgKg1Hhkl/5?=
X-MS-Exchange-AntiSpam-MessageData-1: FPWWGZuXcB/l4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae53478-8869-4237-0aa3-08df1f5f7910
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 01:58:22.5094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pn9q4blrYuZI6gpT9yZromO9tqcpYjzu0KqQqbDknHyyexvtqxfdP0inuhEf5hqscEm+D41gkCtdR4FxJ0Hmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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

On Wed Sep 30, 2026 at 11:18 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 1:43 PM JST, Eliot Courtney wrote:
>> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>>> So far, the GSP command queue transport and message layer code were
>>> intertwined, a design issue that goes as deep as the types themselves:
>>> the generated bindings for `GspMsgElement` even include the RPC header
>>> at its end.
>>>
>>> This makes it difficult to introduce the new GMC message type; thus thi=
s
>>> patch works around these limitations to make the RPC message header mor=
e
>>> explicit and allow it to be eventually handled by a different layer.
>>>
>>> The `RpcMessageHeader` wrapping type is introduced following the same
>>> model as `GspMsgElement`, and can be obtained from the latter. The
>>> methods of `GspMsgElement` that actually query the RPC header are moved
>>> to `RpcMessageHeader`.
>>>
>>> Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
>>> and the command queue code is now responsible for initializing it in a
>>> separate call.
>>>
>>> The only functional change is that the RPC debug messages now display
>>> the size of the RPC payload instead of the whole message including its
>>> headers, as they are technically part of the message layer. This metric
>>> is arguably more useful as the headers have successfully been parsed by
>>> the time we can print these messages.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
>>>  drivers/gpu/nova-core/gsp/fw.rs   | 95 +++++++++++++++++++++++++------=
--------
>>>  2 files changed, 78 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/=
gsp/cmdq.rs
>>> index d293d28b0967..3a8548a51259 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -50,6 +50,7 @@
>>>              MsgFunction,
>>>              MsgqRxHeader,
>>>              MsgqTxHeader,
>>> +            RpcMessageHeader,
>>>              GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
>>>          },
>>>          PteArray,
>>> @@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) =
-> Result
>>>          let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst=
.contents.0).ok_or(EIO)?;
>>> =20
>>>          // Fill the header and command in-place.
>>> -        let msg_element =3D GspMsgElement::init(self.seq, size_in_byte=
s, M::FUNCTION);
>>> +        let msg_element_init =3D GspMsgElement::init(self.seq, size_in=
_bytes);
>>> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, =
M::FUNCTION);
>>>          // SAFETY: `msg_header` and `cmd` are valid references, and no=
t touched if the initializer
>>>          // fails.
>>>          unsafe {
>>> -            pin_init::raw_try_init(core::ptr::from_mut(dst.header), ms=
g_element)?;
>>> +            pin_init::raw_try_init(core::ptr::from_mut(dst.header), ms=
g_element_init)?;
>>> +            pin_init::raw_try_init(
>>> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
>>> +                rpc_header_init,
>>> +            )?;
>>>              pin_init::raw_try_init(core::ptr::from_mut(cmd), command.i=
nit())?;
>>>          }
>>
>> nit: I think the style is to have separate unsafe blocks for each call
>> with separate justifications.
>
> Fixed.
>
>>
>>> =20
>>> @@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) ->=
 Result
>>>              "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\=
n",
>>>              self.seq,
>>>              M::FUNCTION,
>>> -            dst.header.length(),
>>> +            size_in_bytes,
>>>          );
>>> =20
>>>          // All set - update the write pointer and inform the GSP of th=
e new command.
>>> @@ -777,16 +783,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<=
GspMessage<'_>> {
>>>              return Err(EIO);
>>>          }
>>> =20
>>> +        let rpc_header =3D header.rpc_header();
>>> +        let payload_length =3D rpc_header.length();
>>> +
>>>          dev_dbg!(
>>>              &self.dev,
>>>              "GSP RPC: receive: seq# {}, function=3D{:?}, length=3D0x{:=
x}\n",
>>> -            header.sequence(),
>>> -            header.function(),
>>> -            header.length(),
>>> +            rpc_header.sequence(),
>>> +            rpc_header.function(),
>>> +            payload_length,
>>>          );
>>> =20
>>> -        let payload_length =3D header.payload_length();
>>> -
>>>          // Check that the driver read area is large enough for the mes=
sage.
>>>          if slice_1.len() + slice_2.len() < payload_length {
>>>              return Err(EIO);
>>> @@ -833,7 +840,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeou=
t: Delta) -> Result<M>
>>>          Error: From<M::InitError>,
>>>      {
>>>          let message =3D self.wait_for_msg(timeout)?;
>>> -        let function =3D message.header.function().map_err(|_| EINVAL)=
?;
>>> +        let function =3D message.header.rpc_header().function().map_er=
r(|_| EINVAL)?;
>>> =20
>>>          // Extract the message. Store the result as we want to advance=
 the read pointer even in
>>>          // case of failure.
>>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gs=
p/fw.rs
>>> index 918a7ae809eb..b12034db7857 100644
>>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>>> @@ -781,11 +781,25 @@ fn new() -> Self {
>>>      }
>>>  }
>>> =20
>>> -impl bindings::rpc_message_header_v {
>>> -    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self,=
 Error> {
>>> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
>>> +#[repr(transparent)]
>>> +pub(crate) struct RpcMessageHeader {
>>> +    inner: bindings::rpc_message_header_v,
>>> +}
>>> =20
>>> -        try_init!(RpcMessageHeader {
>>> +// SAFETY: Padding is explicit and does not contain uninitialized data=
.
>>> +unsafe impl AsBytes for RpcMessageHeader {}
>>> +
>>> +// SAFETY: This struct only contains integer types for which all bit p=
atterns
>>> +// are valid.
>>> +unsafe impl FromBytes for RpcMessageHeader {}
>>
>> nit: these impls are not used
>
> Nice catch, removed them.
>
>>
>>> +
>>> +impl RpcMessageHeader {
>>> +    /// Creates a new RPC header.
>>> +    ///
>>> +    /// `cmd_size` is the size in bytes of the payload. `function` is =
the RPC function of the
>>> +    /// message.
>>> +    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl=
 Init<Self, Error> {
>>> +        let init_inner =3D try_init!(bindings::rpc_message_header_v {
>>>              header_version: MsgHeaderVersion::new().into(),
>>>              signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
>>>              function: function.into(),
>>> @@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) ->=
 impl Init<Self, Error> {
>>>              rpc_result: 0xffffffff,
>>>              rpc_result_private: 0xffffffff,
>>>              ..Zeroable::init_zeroed()
>>> +        });
>>> +
>>> +        try_init!(RpcMessageHeader {
>>> +            inner <- init_inner,
>>>          })
>>>      }
>>> +
>>> +    /// Returns the length of the RPC's payload, not including the hea=
der.
>>> +    pub(crate) fn length(&self) -> usize {
>>> +        // `length` includes the length of the RPC message header.
>>> +        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<=
Self>())
>>> +    }
>>
>> Suggest calling this `payload_length` because now we have to `lengths`,
>> one which is the length of the entire thing (On GspMsgElement), and
>> this, which is just the payload. optional nit: rename
>> GspMsgElement::length to frame_length.
>
> I'm not completely convinced here, since the type should make it clear
> which length we are dealing with. One could argue that GspMsgElement's
> length is also the length of its payload, putting us in the same
> situation, only with a longer name. :)

IMO it is difficult to argue this because in patch 5 in the v3 these
lines get silently broken because the type of `header` changes from
`GspMsgElement` to `RpcMessageHeader`:

```
        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
            message.header.length().div_ceil(GSP_PAGE_SIZE),
        )?);
```

So this advances the ring buffer by the wrong length, but this would
have been noticed if the function name identified the kind of length it
meant. This is only a problem in patch 5 btw, it's fixed in patch 6.
