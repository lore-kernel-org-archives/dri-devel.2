Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C3C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7569410E7AB;
	Mon, 24 Aug 2026 12:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="n/ezQW5k";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B09610E7AD;
 Mon, 24 Aug 2026 12:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbvQFot4o/efqDwot3RQ+TF8l0KE0TK1w0XmUcwa2/iNtx/dkzSDhAaxHb1DoKedE2YGmAtUO8ljj+4dbeMTaPpmon2SrjRqIbN0MwxAIOtxTa2IjSE8TkqymkigLwihqLBvEuwksYU59ibmS0mgfQfVL+jcH4c8pW+Z7GpJ/7x/s8/ajxgym/CxaHjYYCRoRxTG1uwqBQ6ZVWXHO0y+jhqFpoZ7boDSTtI8owp8x+JBWC9T1qv1rzuEmS7gKZWzVcde+8jSSQK9nTfOyzWK4kb5ans/52woZJsnsvIaym5rvmmDLVc1euTByetbQCLe7B9v78T3kCxRg2mrsR40tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eiYrS3FgtFpa5PsbMKFN+HFDrXxOLeNI2VyHwqR0ao=;
 b=ZkFEkvantQdcFZVCX+l3+99WWT+CQC8rK8rCJYKCwnMKU8ngMGAOtENgGEY9oDptvcTUwSuSbqT4pK5K/4hnATBKsLlVnRT9i8KykQxh23824TOKKChUtVfxjHoQC/IBuYyj+2sA8uZcFuwAqV0sQojRoe/SGtQXQbrM5T1p1u/OerUESQ26i+G140FiQZeIGeUVztvwjxzARiSzGFiuVxwTLcjji8y68scy5nH/bLxWIKqNiu0+O2StCcR+Qj3+VI/MKgN6tPYdJ0bKpoYLDALc+5m8BcOfKKVcBFBSFDOHhpQkc2lNe9Y6nooNkzpx5Pf0AAjzoOvRyhzmoeAIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eiYrS3FgtFpa5PsbMKFN+HFDrXxOLeNI2VyHwqR0ao=;
 b=n/ezQW5kRat50xbbUEq+rOBRF8pONTBJsTMv2EeKT/YfqIKJ2IdTloPyvzHO5F8jPyMhEXcSDjDj5h0U12vpQNuF40P29c5gavBvNxzCtCHYJ7/lM1mmPs5jfZDaWJXugxtowON/kYqit2UH3xg16gijrs4VxsyYZrXMJKPLz10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6366.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:56:55 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:56:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 13:56:53 +0100
Message-Id: <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
In-Reply-To: <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d5103-b969-4977-6d3f-08df01df2be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: buBWawxluhZsgA6kgoU/xGzzdEtY/jAvtys9vIvWGlHKwS1a75olh+EUvsZmXo7AN7vuITFC2L6PjCxEd04Fy+w5C+gRvzefNWXFwvOfBFdW0jyPcUED4O06kt30yLQxtKJ4Zl76eBoWgfW+IQmeKVJUXP9dEik2HoXHqW/ot9MtdJqDRBKxtEgoIZTMTqILyTTFIuYQ9LCPRslVKbY1Ao825jsry3lNif1w/nYulHGdFt5zv6QlfHrhZ4gYCknDkRWpzKurome04zQ8fql8VTIVGWHrlQlJ0dwXcN47SX5634XTtQOstxK12SfSuoW0CjPjghS6UmXXPYKaWf016quLTdrcKRT8cj8Ws/Rtlmxr977mxJF1OACtSJI+DZ/ipTBYYK/snrAiRg1eZx2akxFBJmsi5/VC5DOn/Y+ISmDSsbUUMWuVHKSmgo+h0tMp/35woO/4R3lL5hx9qDPKkSFbL+N229kGm8yGQOfIm4XaWLGYAQbD4EK5Y9NAmpwroZl/snwARIqf2OQF1wPN58BciPYDsv/jdRcc3pql7g+Qrp6uv/Bq7bIw5MjhNuur5oiBm8BhMfa+U8AZnsFcz/7I2px0esaiPqzWpB95pvi8xBgDG8Jw32I6t1I4LDqi2IS38lpu8Xryvfmc/65ahbbSo2r7tT0Ck3zg48AW1YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVIwUm80UXcxOTgyd0pqQ1kzZFBhS0o2cnR2WUZ0NjhVVGUveEc5OTloYjdC?=
 =?utf-8?B?ZGVrOEwyVFFnSDl3bS9nd1FYSHpVOFlodEZOMDVsT1QzUmxwMTFqckw1ekE3?=
 =?utf-8?B?dE5PbU5lMTNYYUR0M1pOZjFxNVNNQUttcitsaTBLOG9KOWQ3aldzVkJQOW1l?=
 =?utf-8?B?YXhweU9VQ0dLQit5WDZhMHhWZW5GQTlBc1RybkV6ZGVOTkJERS9HdFRWYjMr?=
 =?utf-8?B?NDJpM0ViU3k4T3VTcU80TDFBdVh4R0dwTUdSOUM0RGp3cnJvclI5REpGR1kr?=
 =?utf-8?B?VEs3bW1BVUJRdzZqc1c0dHVIY3FiWFJRQjVjTzFPekRiTWNPM3dUbmRNcG0x?=
 =?utf-8?B?L1BYS2t5OHFJeXNBM2tGOWRQNDhKUWFNUG81K0pTL1FZcm94TnhHRHkvUXE3?=
 =?utf-8?B?Tnl5bW5GMTlWZng0K3o0a0QwNjNKM0h5OEhxMDJGcXpzN1V1cmROaHpGSURh?=
 =?utf-8?B?RUNpOUc4Zk1CMDNKeU52STZxeThpMlVKM3VSL2J3eTZIK2pzYlEwOFZRb0Q1?=
 =?utf-8?B?YjdsQkZGWTVvZ094R0MyNmQrc3BOSkphdUxTNHNvQ1RnQUdmMXhFVEhrb3N1?=
 =?utf-8?B?bEVhNUNaVDBCakNnRjJHYVNwOHltY1Y0Y0RBSWFqRWE3bEhsRnYrK3pmYmJO?=
 =?utf-8?B?Sjd4bWZWalFNU1lWYUNUeWNaWlJYaWlqQmZXNmhGelRMaHhOUXB5L3VEUVQ1?=
 =?utf-8?B?cS90Y083WlhWL0lWb29oekR4dUlJSmV6d3BwU1oxSzJDRnZ2Y0tYeUFLWXVh?=
 =?utf-8?B?S2hDcUsvc2xRdXRQOGNYZ2gvK0lnRWlFUmM3YllMUmxLRWxybEZrSU9HbnJJ?=
 =?utf-8?B?ajVqb3l1NkVJbFpDbUhjSkk0NjF3K3grbzBUSGxuUlVuQVNvWnJadWU2ZDVR?=
 =?utf-8?B?RVdpaUhidDdCUFF0aGE5NWhNNWxIMDh2TExNZGxjSi9PMDQwc1VvQ3RXVlM4?=
 =?utf-8?B?bGhITWVBdTNvVVZFeHVjazc0M0V0U1AyYjRoQ2w5eDFKRzNlM2FUZldGUnpV?=
 =?utf-8?B?dlh0M3ljUGcvWGNuaVZTZEtWaVZmMzhWRG1HbVhkTEJ2LzZiQnBVVlVOY2tS?=
 =?utf-8?B?WXJocWhheTNnZVNVUzRFYVdFSDZDUDEyaHhtSElwb3p4Q1JYNXlBUjNabHVB?=
 =?utf-8?B?V0VoSU5kaTMrdEozSGlBaUFSck1kZ1ZqZ2pCQkZoTStWMENmMFRvRjR3YzlP?=
 =?utf-8?B?cnQ1RjhCVkdVM2dwdEtaaWgvc3lOdCsyQktJZXJJMFM2dG5ISWthTUV0aENG?=
 =?utf-8?B?N0toeTMyZVBwT0lyQWRaYnowbnhkUU1LOVkwUWMyZ2VoaHd3QkZwR1NUbDZj?=
 =?utf-8?B?WFFoRXVDenhQRjZrN0pKeEhpZHBOdW5GcjA5NUJhVWRTVmtvbm5taXMzbU9K?=
 =?utf-8?B?TUMvbWpON2p2N1lxUHBVZnpiaDE2aVlqRmEzQXBoMnNuZE44dTBURTI3Nzdy?=
 =?utf-8?B?L3N5cWVzWm1KUUY5d3hwcHV1eDdKVUJaOEFmZ0MrTEdVMDVkaFRZRmxzWml0?=
 =?utf-8?B?YnMzeldoelEvRUVEb2MyMzZ2WmtlYVJPQ2x2eGh2d0ZxRjdRM0RuRDUrZjdV?=
 =?utf-8?B?amx0ZkN5Sk91eGdzSlVRWmtVYVErU3d1ODNqbmJ3WGZ1aFp1Yi95cS94TFpM?=
 =?utf-8?B?ZWRYYys0UUNhMUt6em5DWEhocUdjM3cyYnRHVDRDQUl0M1BVc1MyMjN3c2lU?=
 =?utf-8?B?T3F5WDY1cUpjRUVRVXl0bTJZdlZZWnQxQWJNQUxVT0VGVDQzalphejhGVmlQ?=
 =?utf-8?B?NHNDa0kvMyt0N1N5NDVvRWR4QlVlSlpwT2thUU84amZDL1lxSlA5UCtOR3VU?=
 =?utf-8?B?c2FPekhWMTA5Qi9sVzM3L0xsRWhZWDNRRlhNcXcycEE4NnllN1NxNlZFME13?=
 =?utf-8?B?ZEFFOGxhOXVWK09hMk5weVI4cHVrYy9XZ2RDckJlRmMxK3JLUEZtTHFFUWFq?=
 =?utf-8?B?VEc2RmhsTXNkd3NodkU2Y0NMS1UxcStyZUFMQ09Rb2F6Qytkdkp0YjloM0Zi?=
 =?utf-8?B?eFYxTk5SSTJMdGRXLy9PbWZJbm8vM053MUcyY3d3Sk9Od2hBNXEzRkdPd0pw?=
 =?utf-8?B?OGplTnJrVHBoWnExQzdQbnhBTU5FcmJ2VGs0c252QUhTUjRRd28xNmJmOExj?=
 =?utf-8?B?RHV4SjBQZ0dGSUxjNnFzOE5GdWZVVHB0Wk1IWDVsV0Q0UmpiMmpsV1hnRTNF?=
 =?utf-8?B?eHQ5TjgrRGNuSTFKczVCVlhFNEthWUlHR2NLTHoycEt1cmJEOXMzMUZ5bmVt?=
 =?utf-8?B?ZmFESXdUZTVNUEcvdi9paTZWQjNaY00zcGFMNHpJU2F1OFY0dzdvWmYybEIr?=
 =?utf-8?B?Z3VSZFNPUTQ2MXA2MDlVN25zRE9pQWtDZUhBZVFKUGpiWGovYnRmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d5103-b969-4977-6d3f-08df01df2be9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:56:53.6641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2AkAi7kIRCHVLzNsauOZrdQk3tFzqVR1C90p2lGUFxhHNKBi0dL0GB/r+98sNN+gcXDtYo2tog/2iD/mK94Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6366
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

On Mon Aug 24, 2026 at 1:50 PM BST, Eliot Courtney wrote:
> On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
>> In the CPU->GSP messaging path, the code reads the read pointer from GSP=
,
>> writes the command, advances the write pointer, and then notifies the GS=
P.
>>
>> A LOAD->STORE ordering is needed after reading the read pointer from GSP
>> and writing the command. Control dependency exists here which provide th=
e
>> needed ordering, but it's best to avoid depending on it.
>>
>> A STORE->STORE ordering is needed after the command write and before the
>> write pointer advance. This is currently incorrectly done after the writ=
e
>> pointer advance (and before GSP notification), but this can cause issue =
if
>> GSP is still processing ring buffer, as it may observe the write pointer
>> advance before command write. Thus move this barrier to be before the wr=
ite
>> pointer advance. Note that barriers are not needed between write pointer
>> advance and GSP notification, as MMIO accessors already carries the
>> required barrier.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 6da728201281..70674d2d0f77 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -27,6 +27,11 @@
>>      ptr,
>>      sync::{
>>          aref::ARef,
>> +        barrier::{
>> +            dma_mb,
>> +            Full,
>> +            Write, //
>> +        },
>>          Mutex, //
>>      },
>>      time::Delta,
>> @@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> Resu=
lt<Self> {
>>              (rx - 1, 0)
>>          };
>> =20
>> +        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_ptr=
` read before data write.
>> +        // Control dependency can serve the same purpose here, but we d=
on't want to rely on it.
>> +        dma_mb(Full);
>> +
>>          // SAFETY:
>>          // - `data` was created from a valid pointer, and `rx` and `tx`=
 are in the
>>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write=
_ptr` and `gsp_read_ptr`,
>> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u32)=
 {
>>          let tx =3D io_project!(self.0, .cpuq.tx);
>>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_coun=
t) % MSGQ_NUM_PAGES;
>>          MsgqTxHeader::set_write_ptr(tx, wptr);
>> -
>> -        // Ensure all command data is visible before triggering the GSP=
 read.
>> -        fence(Ordering::SeqCst);
>>      }
>>  }
>> =20
>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>, =
command: M) -> Result
>>              dst.header.length(),
>>          );
>> =20
>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_write_p=
tr` write after data write.
>> +        dma_mb(Write);
>> +
>
> Is there a reason this can't go into `advance_cpu_write_ptr`?

I think it's more clear to consider `advance_cpu_write_ptr` to just be the
pointer increment, and the ordering should be visible in code that performs=
 both
memory ops.

Best,
Gary

>
>>          // All set - update the write pointer and inform the GSP of the=
 new command.
>>          let elem_count =3D dst.header.element_count();
>>          self.seq +=3D 1;


