Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF97CD58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 02:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A90010E2FB;
	Mon, 23 Mar 2026 02:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lEiMxgHG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011022.outbound.protection.outlook.com
 [40.93.194.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6110A10E2FA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 02:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkekCqdkyNq6zisORHVA9hoFCRo3VgYLYShBWie4qstZSqbA9eiYB8OJjyeKXfJwgdsBs5zLwGMKVZdMvmk/NNc8Wq2W7S3ZUNelaWyBjYxTD3zAuKkHY9abknAUVjQEOiNW+fFhgpvwtaOY83p3c4F1owgeK6U1teAnWWBh3rO2CvDgkizwJ/6i09JoVZYKad9WDD8xod8snngLhXa0zXnkiNLJYYmE6jIxiO7f41FYec5xiwieZwUGPeEo4NH73j3XudcX74RgP+b5vqi2MHK9+GmeWfg7bQvU5w4NhU68f3UZolXTibOrD7gdFHB2SiG8Vl9QXx0K2koRuxGOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSuz5jd+f16Vl+f5+FJDiP7BVdyHAxk4xsR7iM0IijU=;
 b=PDnXr4RSpDcyGYq8/bWk13GrSrnZKfRQVbeiMBrq+9YWMLM2b94ENXfw/wHDvYKR9HvOK1JpXGt2k0M1TqhJjmr0ePC5nRaoz67tGlxnwPGSy+m7w0jcvL1YTCjzhvhe95/W4nrjsG1w4LICKObY83Caveva7xIVj/CS17w+nIgmVqO+GX6FwcMp+46yu+75WKAwqrpb+SuvhkIExzWf7FnvN3YkmdXvlob7s6xbdgd6eVNaTI6VPX47VcSxIJccvEyvYvCCsh6SU6zMiUSyjcNEC2GKviBPdy8DgN11DZBDeUtk0qja3cIbw8Gl4LqQHagjcziqbekdkm8mSy7YFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSuz5jd+f16Vl+f5+FJDiP7BVdyHAxk4xsR7iM0IijU=;
 b=lEiMxgHGQTpS79NowiC5F+hU0AiQTMjnRVNWSVcLZcR6Ou5B4dXc4mrNkVbjLCPRg6hipMrj1ATCE+4808Zb44ZbaL6HSqcZLfadjB3yvfgpM7fPULLm4TFVJzK9N9MYSIl9psPmoKuaoza3c3n3ZIYToHbV58Dk2W9skmGHo7vrc/wWWhCM7LUuMp6/vBrEXMFUAPJrWfh8WzJZtflc8ks6LcRfb7xeOJme93XtTR195E4XUTIdzhwak8d1NxBuHtxGoGFNX7U7y91OT9Qebi2sI6k6RH2HmAh63WJdZ/YvtBRVbwrrBLPIuuFhzWpGWgLC93dEzk4X3HdT8cna7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 02:58:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 02:58:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 11:58:54 +0900
Message-Id: <DH9TQ0OS7NDN.R1VT6WC8LHZW@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
References: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
 <DH7MIC1ECKRZ.1YN5T4ATB7A2T@kernel.org>
In-Reply-To: <DH7MIC1ECKRZ.1YN5T4ATB7A2T@kernel.org>
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: f37ca228-af64-4673-2320-08de888820be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 7P2VOEptLguhi9tX7RAfHASd0vkvCpaz7ePTOVq3jrO3HqsME5UlDhPIagSObnRb1YI71OgzL8888stEaKdiUGwwy3ssQomw4KkwuOwBt1A3RuwO/0/LHFnGFcJNZTxHUNERN3zDjIviVN2NzJfFBoNNz60sd8qPzqedY0jX9tLZn1ZKX+4yXptmkddhTBwCINCYQ98BE8F6sJnrWHLTebA7jheL3FQB3S0uSSXEyTpCJwLxDdrI8VnVly7h/IF+vKiFdi1s++ZaSOJF2QXoL+cALJ/BqOBW1stDJ1r0kSbOqY+lk17siVORpwBYFi/pMopQl4PoUZkZzUqjUDhAzzwTK3wUi/ITEJeDPVnOJhT/VaZmeC8OillEH3VKFm+JY/rmSVboJ9zVvOEZD3TejLBxrAZ41N/jyE+CRvjLoMNolMA0eKPhQ8puCcl2vBrMimF6q9MYw/6vnK9n24HtRKHkIYHoHU1sXxF3Q0xJAhA1qDy2k8lgArWZw3yvWWkgJOPbPV/OP2Nqv7NF4sKnRVY+hHvQagLic8CNrlsh/5/GPDbBZwWBKG5GjvsKwx8ZsMKjb5y+gESZPHYFFqGjkTxNPbxGPHSke9ZATfGFJvwr1WxKtNzZX9dcRezjDhlOj9a1JnDQl8VMFZIHLGL0QZmNgqMWrsxnTHpFciFhF7hUy95u2i/SYX61nbyMeT+n3m2o20JWobTQdwRRScMWuvdIHNSbmrNLe/iXDMMk5RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FpRFRUWUhZNDZMWWxPWWFldGZMOGNQait1T3YxWmJYSEtxcFZ6RmtRbm9Y?=
 =?utf-8?B?a0ZPQWpvZmgwYmVYUEVHNHBESjB3QmZkSTd2dzh2dVNUWVJVVFJEZXU2MHNm?=
 =?utf-8?B?Rko1bTNoOE5va1V4VDJ3S3A3cmdtQlBiZ2M2OTlodFJUZHhtK2RINjZrSnRu?=
 =?utf-8?B?ZU5DWWV2NlRQSGx4WTVJazNTa282eWd5ZVduUmYxaG5Lay9NOWZhZmVxWlBZ?=
 =?utf-8?B?RlBZck93UW1rS0daeGNoS3A3NlRkbmJGY3M5TGt4bEZRNUZoUFdmUkZiYlBU?=
 =?utf-8?B?am9qR1F0SitTTklHYTVkS01USFdRZE1pZElBaDJubUE5S0l5U3JIYllUN1RM?=
 =?utf-8?B?NWJJTVNmUkNpcGVYWFc3aG5OQkM1QVlacHpEdnpMZU9LOWpXSHdUV0ZtaHNK?=
 =?utf-8?B?Skdxd2o2b1VlQXlRT0pLYitHNWh5Qm9HU2UvOWpEZ25JaUprZWw5T0ZjNUNo?=
 =?utf-8?B?Qkc3a2JLeXM2NlF2UUFGUzl6QmMvMGtNUkl3YnA0T0xNRG9zWHlXS0cwK0ZU?=
 =?utf-8?B?Rk5pWE9nbHp2S2ZWeXN0TXd1cXJ1a3FDYjM2Rm92eHZtSjliVU5vOTJYeEpN?=
 =?utf-8?B?L3BZV1JOTTdueG5DVDA5ekpRdnRlN2R6QW9ldFBOUmsxK1JnM2VBbFZVWmI1?=
 =?utf-8?B?c1F5d0Y5aXdEZmxzNGVkNU85aFFIRVA0VnVLMElqRld3THNzWFB1ekFKbHUv?=
 =?utf-8?B?UVFDdkRLVFJURWVEZmY2Rm1Fa0NDY0M5ZWZOcTZvK3VEa1RxWVMzWWU5R1Vy?=
 =?utf-8?B?djNrSkljSkJ4cGtVMXYrenY3SDlNZlRHQjhFRHdlWDdMNU8vQlhCeUt0RzhV?=
 =?utf-8?B?Y3lJaFJ2WmVLTnZ5WElNWlYzbE9kd2NhQW5KUXhZa2MvdjV5QUVCaWxLUStG?=
 =?utf-8?B?bWZGeEQrZ3lObzkzVGRIWGg4VkF0QWMzUGc2eC9JNmMxM2pvUmsra3crRXRq?=
 =?utf-8?B?UzhveVYwcTRIUkxydTR4OHdrTkJ6Z0FpcFAxU3FvdUFuNno4RmQ0YzFpdlVm?=
 =?utf-8?B?aWpndytHbVNidS9vUm1DSmVQT3VERGJ2OUZ2UXVlUWtCQktialNDNFJWMlNE?=
 =?utf-8?B?UmFwVXZybkx2VHZJbG5Lb0tvVTJENVJuZlltSDNsQzVTcWVjR1UwTW1rSzd5?=
 =?utf-8?B?d0p0ZjBLUEIyOGtIVE5lY2JIRXpvVXRqSTIxUnJMbDZJMTdVMjdEK1lQYm0r?=
 =?utf-8?B?eWpJbFBveTFvWnloL3puM1RiNGlRdzY5TW5odHdvM01ob1plcVVaTkJadHJC?=
 =?utf-8?B?ZUV1Z1FEQ2QxRGVBWG5GeFNKdFkvUTdYL3RhOHZzUHlSL3hPVFV5azZCalk2?=
 =?utf-8?B?TGw0dEFyK0ExTVhVUjBwdnB3c2t3VHhIaHdmTWZBR1JRa3JzUEY1Uk1yK0xG?=
 =?utf-8?B?YnJxWGRaZVRTSmJhWXMwV3B3elhuWXZJNDFEcXZaUjQrYkp6N3ZZR2FrcUZu?=
 =?utf-8?B?SFFLT2ZRcGx4NlR0UDNuNWNQMm55NFYwd3hpRnhwWkNYREZmN1ArajJGb1F5?=
 =?utf-8?B?S1FuQ1lheWcrc2M2dW43UDg3UmdGRDFnMGhkc1k4L2xIOVBESEtlbW5RWjYx?=
 =?utf-8?B?cUZ4SDNIZlpNaVBJSHp0amtwOHNaSU1LVnJ3U1NZSTNXMjVQSThKT3gwaUg4?=
 =?utf-8?B?NmlqdlhFMEVRM2YzS1FYbnZ3Q21wck1Ec1NhcGN2VnltYTVrek9HeHhjb1Fx?=
 =?utf-8?B?M0QxSEZrUzBmcW9zR2g2RHFoaXpsNkJxNng2SlFoNWRma3VBei8zdTJnVjdB?=
 =?utf-8?B?UVp6bHBrMG1rOHZuSSsxdi9IMzYzMCtLM0FoY01DZmtseUVKYk9Kc2xaSnhh?=
 =?utf-8?B?UVRtdUozcnJnekdFd25BV3ZaZUd6cjZ3RXhRTnEzeGdTN0JpWkpBNlhMNWMv?=
 =?utf-8?B?V1BITW4zaEJyOUJFRmVqTUp6ekFWcWtqWEtybnREeUVRVENSRXBxc1BQZC9B?=
 =?utf-8?B?YkEvSzZzN2pERThmOHBVdTE4SDBNWGRRMTgrM0UxQWFZaFpoait3a0dUNTJH?=
 =?utf-8?B?N2NEb0plMjFJVzBBYlEvR2pXWHlKL3NTcEtUOW1qNklQY3lid0k4OEJzMTNY?=
 =?utf-8?B?c2lsZmF4bmdQL3VTK29YMmQ3SFR5d3FKSTR5cXVwOHdkRWQ0L0t3c3JNNmcw?=
 =?utf-8?B?OFQ5cFE0bnZwQUxkcVZxME5GcmxnalVCRm00Titxd0hTd056dDNsT2lIVUJ3?=
 =?utf-8?B?NG4xMTBKNDFUTDFFaURxazlPUTdKTWJ3M1gxMC8yMmxWZVNQV2FCT2tzNkdk?=
 =?utf-8?B?ZDVlc2x2dEFTTFlUdS9zY3hLUUx4dkNFaFg3MCtDNHJER3JBdCsybnNhY2hR?=
 =?utf-8?B?ZE5PYWdFbnErSDE1NmtpUmxQZlJxVXpBWmozdFlhbStnUkVpbFk3U0xESlVC?=
 =?utf-8?Q?fQHH+CfJ28vP0jNnviDfSPCnucDntCCDnAMBMitH1ezGA?=
X-MS-Exchange-AntiSpam-MessageData-1: OFOtYRkho4zzJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37ca228-af64-4673-2320-08de888820be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:58:58.2722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsjY3VK9G0r15NkCg0/fqha/ADpRwB7coLkP3/66e9FteUY4NHo2xgWqr66K/UMwSxtbrsixdrkYUiDCx7FUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

On Fri Mar 20, 2026 at 9:54 PM JST, Danilo Krummrich wrote:
> On Thu Mar 19, 2026 at 6:36 AM CET, Alexandre Courbot wrote:
>> `driver_read_area` and `driver_write_area` are internal methods that
>> return slices containing the area of the command queue buffer that the
>> driver has exclusive read of write access, respectively.
>>
>> While their returned value is correct and safe to use, internally they
>> temporarily create a reference to the whole command-buffer slice,
>> including GSP-owned regions. These regions can change without notice,
>> and thus creating a slice to them is undefined behavior.
>>
>> Fix this by replacing the slice logic with pointer arithmetic and
>> creating slices to valid regions only. It relies on unsafe code, but
>> should be mostly replaced by `IoView` and `IoSlice` once they land.
>>
>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue binding=
s and handling")
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>
> Should be Reported-by:.
>
>> Link: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
>
> Should be Closes:.
>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 135 ++++++++++++++++++++++++++++---=
-------
>>  1 file changed, 100 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index d36a62ba1c60..4200e7986774 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -251,38 +251,77 @@ fn new(dev: &device::Device<device::Bound>) -> Res=
ult<Self> {
>>      /// As the message queue is a circular buffer, the region may be di=
scontiguous in memory. In
>>      /// that case the second slice will have a non-zero length.
>>      fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mu=
t [[u8; GSP_PAGE_SIZE]]) {
>> -        let tx =3D self.cpu_write_ptr() as usize;
>> -        let rx =3D self.gsp_read_ptr() as usize;
>> +        let tx =3D num::u32_as_usize(self.cpu_write_ptr());
>> +        let rx =3D num::u32_as_usize(self.gsp_read_ptr());
>> +        // Number of pages between `tx` and the end of the command queu=
e.
>> +        // PANIC: Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_=
PAGES`.
>> +        let after_tx_len =3D num::u32_as_usize(MSGQ_NUM_PAGES) - tx;
>> =20
>> +        // Pointer to the start of the CPU message queue.
>> +        //
>>          // SAFETY:
>> -        // - The `CoherentAllocation` contains exactly one object.
>> -        // - We will only access the driver-owned part of the shared me=
mory.
>> -        // - Per the safety statement of the function, no concurrent ac=
cess will be performed.
>> -        let gsp_mem =3D &mut unsafe { self.0.as_slice_mut(0, 1) }.unwra=
p()[0];
>> -        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ=
_NUM_PAGES`.
>> -        let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_m=
ut(tx);
>> +        // - `self.0` contains exactly one element.
>> +        // - `cpuq.msgq.data[0]` is within the bounds of that element.
>> +        let data =3D unsafe { &raw mut (*self.0.start_ptr_mut()).cpuq.m=
sgq.data[0] };
>> =20
>> -        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ=
_NUM_PAGES, inclusive,
>> -        // belongs to the driver for writing.
>> +        // Safety/Panic comments to be referenced by the code below.
>> +        //
>> +        // SAFETY[1]:
>> +        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
>> +        // - The area starting at `tx` and ending at `rx - 2` modulo `M=
SGQ_NUM_PAGES`,
>> +        //   inclusive, belongs to the driver for writing and is not ac=
cessed concurrently by
>> +        //   the GSP.
>> +        // - `tx + after_tx_len` =3D=3D `MSGQ_NUM_PAGES`.
>> +        //
>> +        // PANIC[1]:
>> +        // - Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES=
`.
>> +        // - Per the invariant of `gsp_read_ptr`, `rx < MSGQ_NUM_PAGES`=
.
>
> I didn't do the math, but can't we just calculate the offset values in th=
e below
> if-else-if-else blocks and call from_raw_parts_mut() once with the safety
> comment above? I think that'd be much cleaner. Similar for
> driver_write_area_size().

Much cleaner and much simpler - great suggestion, thanks!
