Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5041075276
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9125210E0D8;
	Thu, 19 Mar 2026 08:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GadKkc91";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCC410E0D8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISSaIStwTGB7HEjZ9Lh1ZanW3oXJkD43d2RDpaQCH02U3kgPCTxkdgGf4DP+QV2GmpSQpdkqzuMM2ZjMw5x0/YYNYosv9c7+mpEBxHDkH4iG/66GhnK2zUVNKKi0o5cz6h4aJjiZwtTIkamV1eA9gputADrJNTf8VKyHqQ8I7g2M+QTqJOeXRgYdRj33AYqv9XvM/gwkIgc8niiad+QMNmsUPYiQPRZTjcPdUyzy5byNpQeH6pJaapf2mVyG0UqSr87YYmWiFv+CRrHPUweY5j7A/a9FPVF0KDnvCe5BID8olfEQa/iubAz4qo1JJW7X8re3XxJTx5rUo8WxKE0hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9NDNkSbQMmtTinEJRsPeMHuBTJY8tJjZv2fYHGPEpM=;
 b=QtjJguBXNLnbs0Gu8sezsDHe6r6/hNohZJ2Z89wXy6hPQ5oW+RHt3EXIddiI+LVzwrko33iLObFVOixZG2SzmmJl0uQI8GQg0ZqTuRn0ZgrK7RdmJe7qUkVFYhRJ+BBvrFjgkYo/tNFHBQh+b84zoNlZX9NbQap96Ux2HUSEH7Kn8jXpKbYiMwWJe0F/2QIRjhg1JryAvUG/117DXMzHGnOuwZj8GjjpbC91KyQxfAT+OedjRNWlyJHVtPtPTHnJh+2BaJwSWnbOMOHX7boJEVR5t09JpG78K1xfmdCwmIO9kP/CdIqXQz1eEEV1Q9yIIPArvSNOx9tpdFYy3Kfn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9NDNkSbQMmtTinEJRsPeMHuBTJY8tJjZv2fYHGPEpM=;
 b=GadKkc91CODm4stJhM0sojSg9fWWPj13mioh788yf+QY6hxcYJSQ/H3vGYd6Fx4sHurjBXzOWT4ZHtRtW8/AeLUeNCqMCEOR+4eO8cKPGvRNaIR0CY4VMadLdAa6TX+42nQSQbRErXikCQ0Ql+8MaKoc6Czivl5jvyHgef+0c8wjfkE6+lRg9zSd+2Z9x4f7OKj3Abz2QjNwcWuheBQa6l4dQ05vqUVtM2S2aJvuA/CQbKmSscs6J6vvTgnuJCC8j+9x6H1gOOfre6b/VRdmUPI5kui6qoDz4FWkrc8NYjzwM89Ah/hEDTijFa44KlWE7GdfPBjEixvMrMuu8rD3Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:24:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:24:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 17:24:08 +0900
Message-Id: <DH6M4US3F3I6.1D4KO7U3G6LZX@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
 <DH6JY86QZEYL.PKQ2W4ZA9UUE@nvidia.com>
In-Reply-To: <DH6JY86QZEYL.PKQ2W4ZA9UUE@nvidia.com>
X-ClientProxiedBy: TYCP286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ceb261-b181-4347-cfd0-08de8590e624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3po7gVtK5rpCAMQdLC1dSxA8KAK6Q/99BNL8HC0Qto0M+Z6BTLuCotrS8gBspjdlAxU2tP96N/J3Q8QyrB/UY5cMiCke6q8l8/pznSU/nm0IKznRTyTfu1B10vspHtZIYFcM3pu7xd7jrCtPJ1DbUgygq9dCXQ77Vp5uzGLJOd0aG0y1KOnyHE+DMyxlqvyB/7EpQjddEwlbugXHtixt90HBw+MK5IvqUsNuRYQOsnEkZKMZHa2YOlDi+n6WOPNUqOS5dq56toDWLe08sMCeGtolSz7sYYZwBJdn+RK7susAvvzZ9DOlABd2x+UUtK7lNBTvfn4YcT4FWQ8Tz7mfJjaQeZkwfbDQIzbYB87VG0OUhZE63Zb0C/IsVLMvE5iKxnRGGmsnFErK5rycxQP83C9SMYEe1piHNYEr9/dX/ZcBgnRhBqRtxTCps9oK6vmkYwmNFiSkefmDHVQX+42NT8CRY5j/3yJYAduUlVlgXUSUQ1GHdEXNmu6y8ntmqSR4HcUjFs0wtQ73gaWoGDrpptY4eoUle8+mwsKIeN4Zb54eK7b94/0Qva6C9ceijj/ROKh1EbGNwVW4PLKATgaoL/YH6ckT9l9x8YlYGFlz4nvNvR+lQo4XMCmwttj8W//opA9n4xZP34+hoa39o1P98Jv4Q/Zge8uGUDzS8dF9yc+lVqqjBkAfU6+khZTd+49RFPnB8xi48oBqTe+PsZLMMo5kssy8kvuo9Cx9epbv0iWT80YhYYSwItBYlHtpcLSM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRZS29heFNjUEFHZCtTdldsc0VSWmN3UWVJQW45bG5HN0g3WmM1UVhrU1o2?=
 =?utf-8?B?MDhyQTdmaFlWUFg4SVJnb0U5VVV5OUxNT1RPTWF5Rk0xS2FQUlFtNVh1VG9a?=
 =?utf-8?B?MnpDdFBJa3FoK2htR2MvWEZEV0ZIMk81blk4cHlxVWorV2c5cDhKM0NUYXlB?=
 =?utf-8?B?WFNQVHcrc21PUWVFT2JoYjdjR0k0ZXBqYkp4Z0tOcndFWFlNNTFVQzJUS29z?=
 =?utf-8?B?ZFZ6aHA0c3E5c05EZjJJZVBMZkt1N0h0eVlEbncvem1ndmJEc0dVUk5HMC81?=
 =?utf-8?B?MGlMZUFIeE8wOUNmdU9KMWRjNUxNUzRvbXFYcUo2SkdpeHpCWVJjK1piTW4x?=
 =?utf-8?B?dW5rczRUb3gyR0w4L21mQjZsUVFpanpXNy9Pc1AwckRsVTRXbm9LcUV6MGJJ?=
 =?utf-8?B?WVpvSXUyVGZiOVlFRk1QNitLN1JRc3FzaVVGUU0vNnNXaTdGZDNSTW4zRFl3?=
 =?utf-8?B?QmJoYWhuSnk0MmdYZDJGcE9TeXdEKzlxM2ZqQ0FQWWpnWGlvVDlETWlWMFJs?=
 =?utf-8?B?WGE3Sis2anNYOXFaNTN1SWlXc1hiV1ZsZnUxMFI3VUNNOXJQQy9HeDB6WEYx?=
 =?utf-8?B?MU5kWkw3M1VBeFczWFJKaDJTSDd6SUJsOWZ0MDJ1bVNxZUhtUFpvQlFZaHNj?=
 =?utf-8?B?Q2hRampRdDZDamFUdC82blY2N2IwcUg2ZFBnQ0V2aVhwUlVNa2NFWVcxOFoy?=
 =?utf-8?B?WWhBYkNHV3ZOaXBINTBQRmdPK0FMOWZKeVNrT3BjY2NsWjdaSHFETWdBZk8z?=
 =?utf-8?B?QUhNT0YzMDhzT3RqVlh5aUZocDBveGIwNzZ4bGN1QWk5ckI5NmxLTmFQZWpu?=
 =?utf-8?B?U2tTcDFOMVh2WXNHYXQ1WE93OGdvSTdxRkZVeU5peXhCOXBFWHRnamFMN2VS?=
 =?utf-8?B?bzNqaHBxcGRZaHA4Ny9BZmowSUhDM2dZK2JKcSsrTUdBVkd0c2hCWVZDSWZZ?=
 =?utf-8?B?a21XcXlxUFhyUjJtZG41OEZGR0luZUZoV3NlVTM2K0VDQ245ODQrOUJkZjRE?=
 =?utf-8?B?QUhiVE9vMmcrY2gyYXlKSFFBZ3RGNnZyZlVWRDZ5MmhRUHNMK2NhVkk5K0g4?=
 =?utf-8?B?TCtMMktud2U4TXQ4ZUVhZGZFdzhDWmlKcDh2cVRKWW1IU2xoT05MTlVGVTFZ?=
 =?utf-8?B?djFWQkxRRFBxZjRpS0pxQm9XZmcxVWltZVc4YTQvRHVTaG1IZDhMTWFVNDRS?=
 =?utf-8?B?VGwrMnVYOHdsYmpSanRRZ244YWtIbG9QYStJNkRWOTJ2TjRxR1F5cnZzVGl3?=
 =?utf-8?B?SkRqRG5aQmVXREFkRHJacmZsL2huWUZoZWV6MjhqM2lvMFZJSElSSjRiN1dR?=
 =?utf-8?B?NFh2NE9GK2U1M01LZTNsb2hQL1g1dENxeE4xQ0VkR0tXbEo3SG1JYWwwVGMx?=
 =?utf-8?B?QVhvUjlKQmp6RHYxUFFDRXNCY2kyNWZCd3htejQveGFLSzMyT3FjTVFsbkdH?=
 =?utf-8?B?ZmpCQ2g2aTE4anV0NGRBRldJTTNwRitCRlhwVHpjNkE0UEtzaXBZNVYzcDFY?=
 =?utf-8?B?cExLcS9iT29vUkM1MTdEVktKYkp4RXMvelNJbkJIWVhGekJiaE1xOTZJWW1t?=
 =?utf-8?B?WmxuTEZUWXJobm5FQ09CS2Q2cU5zWmRiTVUveCtOQ2xiSGkyTndPYjNyU2Yz?=
 =?utf-8?B?cjdNNm13OTlFakNOWXRBWmpCS3ZsMG14cVYzV2ZNNUNMYXBKdkpBbE0zeXRC?=
 =?utf-8?B?aUZWOTlGaHFJN3dNVVg3WWVFbDRLZTU4Mm8wY2dIQTZ3L2pzcHJKUFRIVmxh?=
 =?utf-8?B?Q3lEeldabUR2YjI0SWp6UlkyODFoWmxNcDE4SlBydS9CZTVmMncyZEo0c1Rp?=
 =?utf-8?B?cXp6QWJmUXNYSEhaR3ZSYVo3ejJBS1V1QUNHY3laL2t6VW1sMlhnL1hjZlBZ?=
 =?utf-8?B?bHIvcGZweWRESTlGVXVZYVBWd3NJNEVZbExVMncreThqaVp6L2kyS243TnAz?=
 =?utf-8?B?WDRESnFqQlREV1VUazR3WkFKNkNjY1lCK3orb3N1ckZtZXFhRC80NkkyK0VL?=
 =?utf-8?B?TEUxdmNLQjF3VG5iMkp5SDdHR0tselQxd09ZWGhVVGk5dkdUQjRZWit5a0xR?=
 =?utf-8?B?RUtYcm5oaytEd1VGU2UydVE1czZSZWdPM3FERjVkKzhqWFhJUWw4T2FWMXpP?=
 =?utf-8?B?NHVRWURQWmVhT3JtbzVNQXh4N3V6R0xSc2YwVU50dlZUNk1qamZFT256UzFJ?=
 =?utf-8?B?T0RDaDRQOGJkK0R4cWc1ZlpXaFJIWG44dVBYaHMvS3hrbnd1a2ZObndsNHpr?=
 =?utf-8?B?UTE5YlhVTWZrTnBLUnova0V4S2hrZEVOTTdJWWRmTVBZUGllYnYwTUVieGN6?=
 =?utf-8?B?bE9qeEdKaXh6bUcvM0R0dDFqQ2NleEZmTVBSNGNjZUtZVlM3dEQza1JlZzU5?=
 =?utf-8?Q?gGlBlrdDlfIvxs3hsoHSYJ3n0RJoQWtNbnZz+z+d3yNFR?=
X-MS-Exchange-AntiSpam-MessageData-1: KLyp4IBvq4rE/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ceb261-b181-4347-cfd0-08de8590e624
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:24:13.4671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbskisPbfsBJ4srfdcyyDuncvPp2jREoOFYWksd87RcGdQJ4WX9sKXxu06OGnM+vuLG6hsHr3Uifw9IDx7J5XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

On Thu Mar 19, 2026 at 3:41 PM JST, Eliot Courtney wrote:
> On Thu Mar 19, 2026 at 2:36 PM JST, Alexandre Courbot wrote:
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
>> Link: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
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
>> =20
>>          if rx =3D=3D 0 {
>> -            // Since `rx` is zero, leave an empty slot at end of the bu=
ffer.
>> -            let last =3D after_tx.len() - 1;
>> -            (&mut after_tx[..last], &mut [])
>> +            (
>> +                // SAFETY: See SAFETY[1].
>> +                unsafe {
>> +                    core::slice::from_raw_parts_mut(
>> +                        data.add(tx),
>> +                        // Since `rx` is zero, leave an empty slot at e=
nd of the buffer.
>> +                        // PANIC: See PANIC[1].
>> +                        after_tx_len - 1,
>> +                    )
>> +                },
>> +                &mut [],
>> +            )
>>          } else if rx <=3D tx {
>>              // The area is discontiguous and we leave an empty slot bef=
ore `rx`.
>> -            // PANIC:
>> -            // - The index `rx - 1` is non-negative because `rx !=3D 0`=
 in this branch.
>> -            // - The index does not exceed `before_tx.len()` (which equ=
als `tx`) because
>> -            //   `rx <=3D tx` in this branch.
>> -            (after_tx, &mut before_tx[..(rx - 1)])
>> +            (
>> +                // SAFETY: See SAFETY[1].
>> +                unsafe { core::slice::from_raw_parts_mut(data.add(tx), =
after_tx_len) },
>> +                // SAFETY: See SAFETY[1].
>> +                unsafe {
>> +                    core::slice::from_raw_parts_mut(
>> +                        data,
>> +                        // Leave one empty slot before `rx`.
>> +                        // PANIC:
>> +                        // - See PANIC[1].
>> +                        // - `rx - 1` is non-negative because `rx !=3D =
0` in this branch.
>> +                        rx - 1,
>> +                    )
>> +                },
>> +            )
>>          } else {
>>              // The area is contiguous and we leave an empty slot before=
 `rx`.
>> -            // PANIC:
>> -            // - The index `rx - tx - 1` is non-negative because `rx > =
tx` in this branch.
>> -            // - The index does not exceed `after_tx.len()` (which is `=
MSGQ_NUM_PAGES - tx`)
>> -            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` in=
variant.
>> -            (&mut after_tx[..(rx - tx - 1)], &mut [])
>> +            (
>> +                // SAFETY: See SAFETY[1].
>> +                unsafe {
>> +                    core::slice::from_raw_parts_mut(
>> +                        data.add(tx),
>> +                        // PANIC:
>> +                        // - See PANIC[1].
>> +                        // - `rx - tx - 1` is non-negative because `rx =
> tx` in this branch.
>> +                        rx - tx - 1,
>> +                    )
>> +                },
>> +                &mut [],
>> +            )
>>          }
>>      }
>> =20
>> @@ -308,24 +347,50 @@ fn driver_write_area_size(&self) -> usize {
>>          let tx =3D self.gsp_write_ptr() as usize;
>>          let rx =3D self.cpu_read_ptr() as usize;
>
> Should we use u32_as_usize here too?

Absolutely - I forgot to update that part (although arguably that could
be a separate patch).
