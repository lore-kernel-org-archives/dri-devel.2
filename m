Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2714E88D9C
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD78110E170;
	Sat,  4 Apr 2026 13:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="MIluE8cY";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021142.outbound.protection.outlook.com [52.101.100.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091FE10E27B;
 Sat,  4 Apr 2026 13:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRlIEPlO1vBl55EdHunBQo5AXRFPif0NOcntcLx6lgKsRKJ/oq1587c1IT/ilgW6glWlxAcBfyYR9pQHYWWts8UbR1hfNDfom9xKF9oAz7j33AS2a4Q56b2yqSrtVjggVpHNOAqvWUzNXwjWNBbK14f1OqLaG8NOtV97vvTTt6eQsZpDafC7lWB++cmQ+CYWvXo74LGaiDvYXcYkywj2DgHnAgLHDNakkA1pp4eREOD+itnzjUxu/FZu8tYdxMrrt2Hh2oprCwIdI31QwK2rgLy5zDUJ02LNijmV+I2CnEpZdNeBRCY5AD9qrtGUt8CigRn7AgKU56TKWIWQh2MO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHGl6J4/swqwNXnugOFKgoi/JztiJLGx0vgWAiHZAAc=;
 b=HO4JxQnjO67QElHyQVvm4DFPjA8DSpAp6rFGz8pg0ISTJMqa8icRCbVNUM0fSrXdcSl6opk162UHfJapxEsHW0LHCB55l6JRGNEsmDm2igZ/uf0e8ARwxRp8VmbO3tW6WYcgQaS04L0frLgnWOkmSP+68rH6TuIboYzFqgAHESrhC5+iVn60L6nEMPedHOKf5FrpliI+Q+hY6LJJqt6o3S3ppAQ2R3Yk5Oy/OYz20TqtCLmhe6IISzcqpE4/eNfIkMMwn8CznNyGcbEpbZIdqFAVCBa7YXmsaJTmLC4JlHRgWzxdUHRHkBAcYYfuqvqyCxk7Ynt/C9slEf7hXJtCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHGl6J4/swqwNXnugOFKgoi/JztiJLGx0vgWAiHZAAc=;
 b=MIluE8cYtn1ezlvr2xoyIIwUq5UhbRJS3kCz/pLvK3BCXk3Dce7b7wIg55+2o1/jE5vssG2HxQA8tYgYhXB/TIJILEf1c6slxXi6ZXkdHvZwxBSS/jhihJY0IOwZGHkaLsQ3RZNl0S/kFwg0ZXgm8H4otmqSaKdh6CBLdV3WOQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 4 Apr
 2026 13:02:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 13:02:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:02:40 +0100
Message-Id: <DHKE2U46YAJE.3SSXBYRWRXH4C@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrea Parri"
 <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Nicholas Piggin" <npiggin@gmail.com>, "David
 Howells" <dhowells@redhat.com>, "Jade Alglave" <j.alglave@ucl.ac.uk>, "Luc
 Maranget" <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP code
X-Mailer: aerc 0.21.0
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-5-gary@kernel.org>
 <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
In-Reply-To: <dc9c3448-d82f-4cec-97f9-7ea3387d8296@nvidia.com>
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c0bdbf-7331-4b98-7b8d-08de924a7450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|18002099003|921020|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: b5igLSeZBLsLWpEnBH+DEXTmD8Mt8nCmoUHc/XH2lTXVQBwzTc0RsjrBIxMHyW+foEDYQp2UxM5GtFqEByL0gmuDZEZzLjteGe4jC6Pq2d0fBkqXrhffJPJLmVHlGSEq5heGxhtsWGx+vj9iP2X5O8XUE04rVI0YfN6SoYMRLlRBpaiNraSDNxbCe2+6xJf05zU58Gv4IlbMaaC7yhmd4evAjax8v/+D/blOLXDcf5FdJweJUPYThJFlpLi9OOCoZKdYYiOuZmEu30vIBsRarYAzJFxJyOXm7N/dZIQYurYQcqH29ZpIaeEWx8MpjogszpgJwo4H+t/2qOUKmWX9iRrZaVv7DFGLeBsQCfMONM2qC2MsPBJck9rT8IMjmwSqzIMcxI86TCSu9PkkKfWrfNpO+lSnOls3csgcCPne5srnZltm05un11TQLLHjcsCgxjRIyysZ+gksonvVmXTXvup+NE4su+SuSxTrGiCIK0UdX+BgXO1vvtNHyGkOqKEHMvogyVw5hT6yS0AjJwpR+qxl4fdLYTP7tWWnV7br8A+qub0jg6zqNf6Ln7cdP+nOHgZ6dRdHIYZFymV0kcfLWtMyPQ+rp0bFvi+xODhV4ijNgCAkBHHR3DNvui3nIV1UIIArbyL/3reM8hRYBrsWaSYLFt8fVoD5xAA5UuNQfa9KgBvVH+z/LM5r0jNxB/bPQ9OasgzOcYLadFIrIe2Rx6MHZmd9JpZZa37e41vxrQhgNkTSt+JZiKbitQH0y4fBbHi9MPiX+xfJHenNT6UStg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(921020)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29ORkJJUVBXY1RtTzAvZ1FIY2kyZUozMnNkS1p6YkRkWWlFbk9JWmNLaUNn?=
 =?utf-8?B?MUR5WFpBS0ZSZG5oeE11c2dmRzRZU0xQMisybTZ1azNnSm9YRzc4YVBRTUx2?=
 =?utf-8?B?bVpSSG52bFlHOG1pWXkzVW5saHpubHg3Y2Y2T05yMWovMVVxVy9qMFhPQm9T?=
 =?utf-8?B?TFhpWDNyOVkxU2xPQVJweWNyTnJZaGZvWHdNeURHQThYdFdNRldpUmh4b08z?=
 =?utf-8?B?eTVkSWNkUE9RbkJ4aDNzSld1WXlLeXJSVnFSekxadXQvMmxyMXQ1NHBML3JF?=
 =?utf-8?B?THo4UVI0anpVYUxQYUptTnI2Tzh4VkNMSWlYelArdjZWUDdzRW90M1RlSldX?=
 =?utf-8?B?MDhGVVZDRUcrOU0rMHVhZDdlRndDTlNNb1VXUlgxM3VuenV3eGJKRzlzQnJY?=
 =?utf-8?B?SmJ1Y1NTQlpGNks1RkRLOGZFV21ueUU0ZjI0WTF3VkFDeENIcFZJU1Jmd2U2?=
 =?utf-8?B?Q3QxVVg2K1Z5OWpGTWNQSEdMUC9uR3g5Sm40WTFBTEdobnZzZC83VE1BdHBw?=
 =?utf-8?B?QTlwTGNjdFFrWlM1VjFiUFR3ak92VEZUTG0wVFVMTGJXWUdiV3p5bS93dFJL?=
 =?utf-8?B?YUE1S2NRMEk5QXFPSzFnYkVQaWRMSDZFSmg3a1NieTJncFVraCtHMUh1em9L?=
 =?utf-8?B?NXRBTnJPdzIyVHNHMGlheTJDT2syZzZyb0lWNlJ2ZlkweFJrZFIzSXB4T25E?=
 =?utf-8?B?dkgxWXY2UDJ6UHF2Zys1cjZFV2tKQ1psUy9SSHNqQTAvdEo1ZnpMTE1FTFJO?=
 =?utf-8?B?STgzKytTbk0zUmFUb0VrT093eVl5VjlhK2pXQVkxdEU1eDRpRXA2NndPTlUz?=
 =?utf-8?B?eWEzSnVMM2d2S1o2Wk9NNFMwZlVQR1ZJb2QwVGdsdWQ5SmRsUTVBNVpxNWkw?=
 =?utf-8?B?cGpoR3kvaUJlak45Z1FlNG40TWpBektvN3dudU16MmJHZWswNFgzd1A2NzFQ?=
 =?utf-8?B?eWgzSlpCSnUwcGxvZWtQQ1dIZmh3bk9aTk5OQktOV0lEdWV4MkFGQWFFakVj?=
 =?utf-8?B?VHJCVzJnUzdNc1pyejl0L2hTMHVWUlZwMjNFN0RDYVh4VzlBR0ZBazhLbWZz?=
 =?utf-8?B?d2trQ2ZrQWlnV1ZBMFRML2N0c2JDdlFlQ2k4bVBnZ0R6ZjNPbDVjVlNhandp?=
 =?utf-8?B?QVllYk1CaVAzU0RLeHdPMjJKNXhtb2NrMk55WnlRRFdza1R3WFdZSTdLc3dp?=
 =?utf-8?B?Q3c4dzZydWtQSVlheEZqZjNtRmJNVWlJb01ud2NNRkIyVHRDRDVNVlRvWWlQ?=
 =?utf-8?B?bW9GaEJGQUZja0UvbW84d2NiQ3ZZUVIvUG1aaEFOWTdWR3lmbmcwY0wrZk1Y?=
 =?utf-8?B?YkNyZDlWQVZsQk1UaEQyL2g2eUNhQXQ4MDFKcVd0WDFKTytzNVhId2pObm9P?=
 =?utf-8?B?RGF4RzNucmNUb0hlYzhoem1rT2FtQVk3OUtpamdybk1rUUFIajdEVU13ckdm?=
 =?utf-8?B?d21naWcxS2FpQU9URDVOdjVjcTdqVEU4LzNQa1F3eXQ3cXFaRERHL0szRkN4?=
 =?utf-8?B?cVNLMEdhRDZhNFRVOUVoNjZ0cDVnRk1UaXpYWHFBblUzbTRqN2t6YkhiOFEw?=
 =?utf-8?B?cjRzSjhmMTFFaEtuVGxEekxFaUFwQmVjRnBISVRyUDk1MVhWYWFQUDAxR3pM?=
 =?utf-8?B?TXNKcElzdmgrZW9LbzR1c2JOclg5SmJFNUI4Rjh5ZW9mR1d2T2pkMTlyWlVP?=
 =?utf-8?B?K29KWE9wYXVpSCtTeWVsYkwySkd5MUFRZUNjZmZmRmcxaDlXa0xaWDZZbWcz?=
 =?utf-8?B?clJrLzhBbi92ZXErYlJaT29uNmUwU2xGa21QTUV6azArUlE3MGhlUnRnRjF1?=
 =?utf-8?B?YmdLdDlWWlNJUDVrdUJSSWhNU2ZpMUwrYmRKZElta0oxZ3VpN0ZVeFVwNVVV?=
 =?utf-8?B?dllRTmJRS3dWYVl3cWtwc2xZQ0F3YnFEZ0lZQkpwc0g4cndwVUdRRmVhdERw?=
 =?utf-8?B?MUMvWEU0dCtva0lTM1JoZ3pUZ0E2YWxyYVRhNmNTSXB2cDdzMDlOYTc0Slh3?=
 =?utf-8?B?RFEyOURWeEF4K2IxZU9VM0FyK2J5dnZxU29vQzQ2a0d6amJhTXZ6aHVjVWt2?=
 =?utf-8?B?YXBuYUw3TkNISHNLKzEvUHNuVk44MXNOeDhuRUZxSWtlSmRhekpzK1NCRVI4?=
 =?utf-8?B?M0FXTFJRNEVpY2lacklSam1QY0V5b1EzU2FyeGZEeElzOXEyZUF1Z21XY2dz?=
 =?utf-8?B?ejc1THc0MW1XMTNzd3A3Z0ZMRFgwUEZ0ODhVRG1aWDdVeGxzWTlVdWFiNTcx?=
 =?utf-8?B?UEJvR1hleXl1dncxMmxibUFXdnlKR1BGVTNCZEJtelo5aFRZSFNMMUJveE11?=
 =?utf-8?B?N3htMzh6NkFaYzZNWi9HMnhsbHNuOThualZ3NWM2QUtyaFV5QzN4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c0bdbf-7331-4b98-7b8d-08de924a7450
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 13:02:41.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2yq3njnYfvrjhRIMRs+GrPg0i47PHdmY2ZEd2OJ3NRLNDBKfqeXQwZkEyOWiawacT7H11hvFLjkI8xxpjnRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7417
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

On Thu Apr 2, 2026 at 10:56 PM BST, Joel Fernandes wrote:
> Hi Gary,
>
> On 4/2/2026 11:24 AM, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>=20
>> Currently, in the GSP->CPU messaging path, the current code misses a rea=
d
>> barrier before data read. The barrier after read is updated to a DMA
>> barrier (with release ordering desired), instead of the existing (Rust)
>> SeqCst SMP barrier; the location of barrier is also moved to the beginni=
ng
>> of function, because the barrier is needed to synchronizing between data
>> and ring-buffer pointer, the RMW operation does not internally need a
>> barrier (nor it has to be atomic, as CPU pointers are updated by CPU onl=
y).
>>=20
>> In the CPU->GSP messaging path, the current code misses a write barrier
>> after data write and before updating the CPU write pointer. Barrier is n=
ot
>> needed before data write due to control dependency, this fact is documen=
ted
>> explicitly. This could be replaced with an acquire barrier if needed.
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>>  2 files changed, 19 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 2224896ccc89..7e4315b13984 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -19,6 +19,12 @@
>>      prelude::*,
>>      sync::{
>>          aref::ARef,
>> +        barrier::{
>> +            dma_mb,
>> +            Read,
>> +            Release,
>> +            Write, //
>> +        },
>>          Mutex, //
>>      },
>>      time::Delta,
>> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
>>          let tx =3D self.cpu_write_ptr() as usize;
>>          let rx =3D self.gsp_read_ptr() as usize;
>> =20
>> +        // ORDERING: control dependency provides necessary LOAD->STORE =
ordering.
>> +        // `dma_mb(Acquire)` may be used here if we don't want to rely =
on control dependency.
>
> Just checking, does control dependency on CPU side really apply to orderi=
ng for
> IO (what the device perceives?). IOW, the loads are stores might be order=
ed on
> the CPU side, but the device might be seeing these operations out of orde=
r. If
> that is the case, perhaps the control dependency comment is misleading.

Given that CPU cannot speculate store, I don't see how dependency ordering =
can
be broken even if the other side is a bus-mastering device.

For this to be broken, the device would be able to see the dependency-order=
ed
STORE to be propagated to it before it does it own STORE that propagates to=
 the
CPU to trigger the CPU STORE in the first place? That'll just break casuali=
ty.

I'll say that control dependency is sufficient here. I'm not worried that t=
he
compiler will break this particular control dependency given that if
`gsp_read_ptr =3D=3D cpu_write_ptr` will imply command allocation failure a=
nd this
condition cannot possibly be optimized out by the compiler.

Best,
Gary

>
>
>> +
>>          // SAFETY:
>>          // - We will only access the driver-owned part of the shared me=
mory.
>>          // - Per the safety statement of the function, no concurrent ac=
cess will be performed.
>> @@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
>>          let tx =3D self.gsp_write_ptr() as usize;
>>          let rx =3D self.cpu_read_ptr() as usize;
>> =20
>> +        // ORDERING: Ensure data load is ordered after load of GSP writ=
e pointer.
>> +        dma_mb(Read);
>> +
>
> I suggest taking it on a case by case basis, and splitting the patch for =
each
> case, for easier review. There are many patterns AFAICS, load-store, stor=
e-store
> etc.
>
> I do acknowledge the issue you find here though. thanks,

This is pretty much just a common MP pattern, where there's even an example=
 in
Documentation/core-api/circular-buffers.rst (except we're using dma barrier=
s
here as we're talking to devices rather than another SMP CPU), so I think
there's no real need of breaking this into small parts.

(That documentation makes use of smp_load_acquire/smp_store_release which i=
s
another reason I want to at least document the barrrier to be of ACQUIRE/RE=
LEASE
ordering).

Perhaps I can move the removal of redundant barrier after write pointer upd=
ate to
another patch.

Best,
Gary
