Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B7C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D333510E150;
	Mon, 24 Aug 2026 13:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="d7GXb/PL";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021137.outbound.protection.outlook.com [52.101.100.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB19410E150;
 Mon, 24 Aug 2026 13:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX/6x2UIgCpjMWbpZ/9e8EYDuYds/EF3P374a9CDRl0TwoZ7dwwTNCWSLQAPvbKqJSw92PmRNYs4kX3mxhCUf/r+NffG814zsQ7tFG1mgDulS15Rent27sPQLp4PUZ2tuslGmmq5Hg6fUqxmE64ykho35SscToUtaCSMlC89HwUOn4a52g5WrLFUEQqxv21XocXT4UrydE5+JwJ8CUj8ogKMiNcvHwbgU4jkQcQyMKYgECUaynp6zO25U7TCBEY8/HoUcpk7EcgM2KC/d7tlOUJd2q966ELYk26N+pMFecAPGYlnMOoiErZmRixg9RDVPpxRiXjhEN2KsXRtGHwqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Bhs4EAK1mLPXkgmUiemYAYuW2GzN2mH6//Slo890eg=;
 b=Apq7n9KGiCfF+V9m0CCJmyyjLcw/cWG0C2xkz3PV3PZsVUn/Edyi//Tiyc3tFbWJHouEUYtItXRZjY6M1mmhrF264K60y/gn5TFo2PF4+zoahc0+yZGiDIk5OqA9iYlheZvV8lv31zYwqNEG3RgH6xaeWttUI33QvQiNGkja4OdhzV0cYjGITTr4Rqy4+V+7bYqv1M0mtBOlMSPT/aOyt7RsCX6xwbQmCKfMvV06qrIZDO5IbeO4lMLeWLmSyARfvX0dLI4oZOEWNvpw0HqeA+TiO3ah13vJpIt1aLR3FqLNialW1RcHNHu1Td580EiTAK6ovfM8NUCKxU1ApTb6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bhs4EAK1mLPXkgmUiemYAYuW2GzN2mH6//Slo890eg=;
 b=d7GXb/PLjfGjBlM19HpZNvhTiTV6PbvI9+ebW0MIu5Xafej0ik08W2QtB4HYyGvMkkpav/gjU5W2NwaVvtFuwuAS8LdTanK2dWeKruEjgkIbRK+Ifx24bNV7cE/c1P+dl69Y59T26Gw+CGKMP5xzJvQYgi4vgG1UfEDFMLqUIj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6500.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:07:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:07:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 14:07:38 +0100
Message-Id: <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
 <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
 <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
In-Reply-To: <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc539d1-5b73-47cc-8023-08df01e0aca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|23010399003|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4/cgixoL0EE+WsmlGvKST50EZFlsjFba6ymMk8OL4cJVahkzDpI4AxObZuRWGXKm0L63+sVrcw0sDjgbDffjFv7kw6VBX/Pgbmy86i6QHLcftSxHcTzWp7ftNE9abIEYlXJ7Deo5AwE3YJxgx+yylbHd9XEAXNS0JE7ALBoSMp8aXg8ZYMQhp80qeRA7BhCKJdo9K+UDGctKqZfipAbNnlroG4i+KvyYcqWBjjCKtb6xpkq3Of8xv/qYEtEU75Z0R+vM6HG4wy4DWRKUsaE0B+sRljTAccUdiZ8ddP/z01UCTc9vuZY58nl84SaHS608GQrSgui8DPIRTILEr83br4Kev9QfF5cMgHFiAlzJRUxagoriLJAigVLL34gGTkTLgX2nH1bnoc1WScI4cUMJ/YLV3QRSxZM0aL33ehsWbepRV/7sdTdGp74WMChaIxHqFPEnkLkO1xiiN6FLhM5LFkAuuiVksmz82lx435+1xie4Y/bFCrC95VL7aOqzCgRcQ6uVny/qctMBkWHJhFW7BTFeS701yNFyPNMIuQ3xP/6H5y+nc5JPHFYW14oLc1un52zeSUsOcTGfGHI+o/gIMp7diVNuNNB5jVjImYcXWeh6oKPrANCLcnB0rJ99zHP/ZGb//x0zxULM00aIidxUx5jfbai0CMcgw9aEDdsOSgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFuQWJHOEVmNkpETVBraUtGanZIWERVOFBrM21INXBhSE5IM2lDN2NPM0RL?=
 =?utf-8?B?R3p6aUo1M2lBT203cUo0bFh3b1RiZkpuMGQ0aU1ib3VtSm91TUtpT0ZpeU1y?=
 =?utf-8?B?Vy9DN2ZGSE10bkNIVHA0aXkvYzVBQ1BJQ243VFdmbTkvZHRUa1cwb1ZUSUNo?=
 =?utf-8?B?VXE0Zk1vS2l4a1lKUmgydElMWXh1UWhmYjhNZXlOZzdDSUNEUU02bTZsRmRu?=
 =?utf-8?B?MmlnNzM0SHJSV0pkbGJGMDIxMERndElGaFlVeE1ST05Tc1lhTGJuM3FjRUdi?=
 =?utf-8?B?UWZLbDdLYnpLZGp5NHhtU3lyY29iTVE5UlF4Ulp6WWNxejlzK2cyb0VGN3R1?=
 =?utf-8?B?VU1wUFk3S2NCSUhRblhKRG05dFRVcXlKaTZXZlpjRFJPNk5jVUZQL0FmN1o5?=
 =?utf-8?B?Nm0rQjhTOS9yM1ZMQnFHd1B0b1FneE9YL0lJZjF4MWhzak1nUjFkY2NyRS9i?=
 =?utf-8?B?ekRUbXpqWitTeFdFSmdhSVRQazZLenh5cDFCWU5SVHVWVVJhTSt5cjJNSDBR?=
 =?utf-8?B?NXVuZkx5V3dQUkFsY2xWWkI2TDE4VXIyTjRoSmdwYlpFRGFPSk93Y1g5bHlS?=
 =?utf-8?B?YlpLNjhHamJjWXluZDVxNzdPWWNlNmszejY3b1N4N2hnNXlTRTdtdHNYZU4z?=
 =?utf-8?B?ZndQRkY5VytZTjVBMysxREk3WENkWWNJNkpSajFLVUswZEFZbnFxb3k4L2l1?=
 =?utf-8?B?Q0swb3hiLzFPUGJnWXU0TGJJK3diNkVxSDM4UlE2Z2VsRW5MOHU0bm5jZ0x2?=
 =?utf-8?B?UythZjJrNkNvRWxVMWhDTkMvM2k4SkptZW93VTRNQUNRQ21zVkRud0F2SzdR?=
 =?utf-8?B?SjIwK0hlVFBXd0E2R1ZDS3ZMTk5keG82YTR6eVVtbzV2SW5QUklmS2F1OWQz?=
 =?utf-8?B?VjdUQy84V0tSN3lSV1N2MzZSdEZhaTlZWDJWMVdaZmJvRCsxZ3NHUzFwV1RF?=
 =?utf-8?B?aHUyQjNtYzhaWG5OQU15TUNYQjZ3QTB5VzhjdUNveGp0MDN1MXZGalpRemNm?=
 =?utf-8?B?ZFhJQ0N5MTR0dWpFUDJxRHkwV3hLMk9BRzdRRVVHcHZUVWxtVnlmNDBIVUZi?=
 =?utf-8?B?NHNMY2UwaEFjako0dDAyd2MzREhBODJWeVRKWFI4RDJjeWJ1QmI3ZmZPV2NW?=
 =?utf-8?B?M3J4YkNad3NrVXJ5RG4rdUJhVnYyaW1nUTgvTURoWjdOVC92UEZ2ZVNBZk5Y?=
 =?utf-8?B?LzVzdDVTZWY1NWIyRmtkbjhjYWhHMTVYWFdyakVlSk50dGtTUTRwaGFNQjdH?=
 =?utf-8?B?azZ1SHFKc0poWVc3SEZPOTV3M3lEd1pvaVo2T1hHTDIwU0d6czdkNktQMDlq?=
 =?utf-8?B?cFR1NnFHemZmbm9halhmS2lQbzVmV05iTG1ITVNUS0ZIM0xkK3JtRWw0MWFh?=
 =?utf-8?B?WG53d1BiUWZETDdqenhEbGIzY3RuT3BGNWtObndLUWIxS0tjTDhmendQSFVo?=
 =?utf-8?B?QS9qUndUc01FYlhaNUZqdy9Ha0ZpT3A2VEZ2YVlrdzZKaW1OQ2JEaDB4YkJo?=
 =?utf-8?B?bm0rT0pXQTFMODk0MHdkU1dpWkM5Z0Zxclp0RkNPKzdNa0VoV3U1ZDhiUE5l?=
 =?utf-8?B?S3VwbkZPVDczL2JRbzNHS1pHTXpEWUlCTlE0dmRrektyZ3BnVjJmNTlEOExH?=
 =?utf-8?B?SHFsSjJPeExaQWNPZ1NhQ1JiU1M2ajNYaVhoaTlRNEpVTG1sNmFyY25PRjB2?=
 =?utf-8?B?ZmJ6NDY3VEdvYysvWG1LVmhBVmZyLzRXU2JWOXB2NlZ5bVR6WUVONERNYUNq?=
 =?utf-8?B?SmNoZ2drZDZLcFRFb2Z5VkIxSTZBVWdrWDF4N3ZYRFJOZ1RvVkx6eFNsMTdC?=
 =?utf-8?B?YStZVTNkbzdONElMdVREUUFLcHNDRW9EZGxjd2ZoNmpLdU5Ta2Y5Zm9yMDl2?=
 =?utf-8?B?dGdSMkJsQ2s2dUlZbElWRkgzU0tkQjkrV281cllFYWtLdEdTVzgxcFdmMDlB?=
 =?utf-8?B?SXQ5NS9YcmJ2bzFObDlPd0JLODVraFFtUU82bVIva3lzT2xsSkxmdGtxYk9X?=
 =?utf-8?B?U1R6ZEVlbjVjVUNZUnVvS1hYYUoxanZDcFZ1eDVrMHprRFZCeGhHQW5HWkVz?=
 =?utf-8?B?R3Y4Q2NtM1JlUTNYK2EvM3d3b0hEUDM1VDNZTzBxVmF2UHpkbWFMWXB3Tjhx?=
 =?utf-8?B?R1p6TWFlTXpnWWcyQ3RPbkZhcG1ENm9jQVh0S2lsSlB6YW5RdDRQSjExSE1R?=
 =?utf-8?B?U2lVYXBvd3hDZHZUY2Q1MWhCdTNLMDhUNmRUcU56bGhSK0RLdnZFaS81eDQ5?=
 =?utf-8?B?UlY4dERFc1N2K2tyK2l1ZktOaUFtRHRhSFlUZHF4MUZaMFRYNkpld2pmNm1l?=
 =?utf-8?B?bVdQOTA0VTU5LzJ3Mm9jOE04dEJKZHIycUU2YlY4eUFEdXdwczhjUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc539d1-5b73-47cc-8023-08df01e0aca3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:07:39.3163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 192DIb3PkG+DDplREUQ7ySnzR5z09thAYdju017OpPue9LMvsok8mT1YQD3OEepP9odOiQV9jq6a1d4B3Ehbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6500
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

On Mon Aug 24, 2026 at 2:03 PM BST, Eliot Courtney wrote:
> On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
>> On Mon Aug 24, 2026 at 1:50 PM BST, Eliot Courtney wrote:
>>> On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
>>>> In the CPU->GSP messaging path, the code reads the read pointer from G=
SP,
>>>> writes the command, advances the write pointer, and then notifies the =
GSP.
>>>>
>>>> A LOAD->STORE ordering is needed after reading the read pointer from G=
SP
>>>> and writing the command. Control dependency exists here which provide =
the
>>>> needed ordering, but it's best to avoid depending on it.
>>>>
>>>> A STORE->STORE ordering is needed after the command write and before t=
he
>>>> write pointer advance. This is currently incorrectly done after the wr=
ite
>>>> pointer advance (and before GSP notification), but this can cause issu=
e if
>>>> GSP is still processing ring buffer, as it may observe the write point=
er
>>>> advance before command write. Thus move this barrier to be before the =
write
>>>> pointer advance. Note that barriers are not needed between write point=
er
>>>> advance and GSP notification, as MMIO accessors already carries the
>>>> required barrier.
>>>>
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
>>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core=
/gsp/cmdq.rs
>>>> index 6da728201281..70674d2d0f77 100644
>>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> @@ -27,6 +27,11 @@
>>>>      ptr,
>>>>      sync::{
>>>>          aref::ARef,
>>>> +        barrier::{
>>>> +            dma_mb,
>>>> +            Full,
>>>> +            Write, //
>>>> +        },
>>>>          Mutex, //
>>>>      },
>>>>      time::Delta,
>>>> @@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> Re=
sult<Self> {
>>>>              (rx - 1, 0)
>>>>          };
>>>> =20
>>>> +        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_p=
tr` read before data write.
>>>> +        // Control dependency can serve the same purpose here, but we=
 don't want to rely on it.
>>>> +        dma_mb(Full);
>>>> +
>>>>          // SAFETY:
>>>>          // - `data` was created from a valid pointer, and `rx` and `t=
x` are in the
>>>>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_wri=
te_ptr` and `gsp_read_ptr`,
>>>> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u3=
2) {
>>>>          let tx =3D io_project!(self.0, .cpuq.tx);
>>>>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_co=
unt) % MSGQ_NUM_PAGES;
>>>>          MsgqTxHeader::set_write_ptr(tx, wptr);
>>>> -
>>>> -        // Ensure all command data is visible before triggering the G=
SP read.
>>>> -        fence(Ordering::SeqCst);
>>>>      }
>>>>  }
>>>> =20
>>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>=
, command: M) -> Result
>>>>              dst.header.length(),
>>>>          );
>>>> =20
>>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_write=
_ptr` write after data write.
>>>> +        dma_mb(Write);
>>>> +
>>>
>>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>>
>> I think it's more clear to consider `advance_cpu_write_ptr` to just be t=
he
>> pointer increment, and the ordering should be visible in code that perfo=
rms both
>> memory ops.
>
> In the second patch, it looks like you're adding the memory barrier
> directly in `advance_cpu_read_ptr`. So we'd have one barrier directly in
> the code advancing the pointer and one not, which seems asymmetric. I
> think it's less error prone to put the barrier in the function so it
> can't be misused (and we already have evidence the barriers are easy to
> get wrong, since this code was already broken).

In the second one `message.header.length()` is read, so if I move the barri=
er to
before the advance it'll be incorrect.

Best,
Gary

