Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552D8C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A4F10E706;
	Tue, 25 Aug 2026 00:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="msUHBC+T";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1152710E706;
 Tue, 25 Aug 2026 00:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luj/BaiBBcYpJgzvnwVMOqITyShzxkmR1B70U/bOj6lusL5arKz/bgJRNgQSPFkjaYx37s0H/vEmPQcNzFlcSQZZ7fqXg3Z17fEMqwYvKf2Yf9NUmAiJjDhF8y6ONRUFu+CSHWnonJUSVmEsGFNnRsA4j8yR1GuhvaH3YHZ0biSdPPXBpiES2ieuN0Dd+xC5Dxbe1tk3+a2uhKKAJYaDOuceJEjUa5YyA0GouQ3q815HysISluGH5Hr3rgYtENNaFBno90MnVDPix5z+FKWXImls3Tk2XjnKVeiJ58JhUxNW3fdYUfkXoWWAN+g8Qc8u37QoLlYAgteakDD/cat5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQaT0wh5Z1Fu2q3HlYVlK09LV0T51ZjhTcK6H7NpOO4=;
 b=R9Bfck13HeFF0aW3btZrStMsjdZMJjhNvuYEXwG7fsj03ZCh7lFdSgh9WbSxeoyJDGJ+0n/JE8712E64XQbrJWD9UoSJmj/HMSzmcv7WMl6ilCXf5rnR9b+6deXu8NMd/zmSFvCPwZHzPccPBIaOdlLq8XiKimJ5GipmavH5dc2dmHEetwvZr0rartiYY/sgDYdLOdA1Zdee4zJ5s0Sl8+Bd3JySbmlvOo1hhJJ4qbAqa1mCnBlSQfTsid7F3saGqqz4aibbI+j9LnUUVkw7b6xtzlrSwDllNERumLk0CfMHlb6t8HE7F2pgXqbQbCFCRYXz+QiSPA7surVp5IvDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQaT0wh5Z1Fu2q3HlYVlK09LV0T51ZjhTcK6H7NpOO4=;
 b=msUHBC+T4dt/hMyiXCoo3Z6udv/9bwLH4anod/vmSs82E6YD2V5+EqpCU5oJWdLdSgXK+SeIzeU312KYtpUazooYUE62ro1iF0nr3kIB4oC1ymQy0Jmj+gNYrAWFyFZlICOBbqhLshv1n321vAe7eGYhF+BJtrjBEmWVvKTo0P2fKzDQZxVhjTuNmfyAAku3zl97SfqD5CMPd+r8SUfOUQ4tyHAuimoqjHmXgp2l0jqQu7dHCGpQsT7LCTMciJ58REqqYAomdXYOQ5UqOko5POHg7FxFTaSx3psjKcSPxr+AwhNj2E1+vRospDxYxf35CqzqIDWoshgdIeHhPqStNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Tue, 25 Aug 2026 00:38:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:38:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 09:38:07 +0900
Message-Id: <DKXLSOCZBYYX.1OE2DF4LYRMV5@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
 <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
 <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
 <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
In-Reply-To: <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
X-ClientProxiedBy: TYCP286CA0146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: d5983c34-aa7e-4e3e-74d7-08df024123f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|10067099003|6133799003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7wcKh3vVsTlRJBWDbk7Cg6aNwDeU7CtvxBBHDefPwnlpC5/YSJRIspYZ8oiuOiLIWMMIqb/yMqS8E76BL8GG2SnSzEs+KvZLlL2SaEfVihtNuU51b+m4+XmWs6IN7rw2XgncsUXxaMEdVIVaJns6W9tcjcINfY5M5TgaYmRHM8410G4IRTpi8nXU6kc0wS1l6iR9vNi9Dgm1OHa4PBlH0WWr+3bJ5bIG2aThDvZ7tQh0coHcTuJ0yYxxxeG6rDRgfJMrQ2ozuVz0NHmCrgQI99Bq0QIioZDAg/CuM8Zr7noOqLb3oMnBbLZ+UtgLb2vGXlKZ4ha/Utme4zPRXkW7VlPDxv8ppIRTcVnNfzAlihqRzMcCc5y/zv5F0v1sLFfV5IqiUkRUz96/+ojfqBwi7pgSujlcbPMYcudnKpsMIhg0EKmK1MlR3bUCvd4BUjTfTKunp6g9rGkR4/nGbpGCwTxEN+tceYaG3R2rZP1Kh7j+W/i+o/KTyju2ldw5cziwIZHcdUNIyU9bT16JJhF31++7fPjqVRIyWYVJaW1XHI6gq9x5nMHtRsfpTGSsz5rsCdUyieG4W4gc0JnLI1NV1+NOoavb6X+DkEtKSd/TjFh4SunGeKPHPA+uukjkpiCym2JuYeIxCtsWSsKi8MkKB9wFuMyMF9fvoj1auabYsZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWE4dFdjMElJeHB5Q3JLUmM5UllEVmRKZTc5WW9EVE9oU0hLazM0N3c2QjRK?=
 =?utf-8?B?Y3huSnV1Y1pvREFub0NieUtpL0FHTGdrNnNDVmtkOFBtaDhvOFM5ZG5uaFNI?=
 =?utf-8?B?aHl4MU10MmZGM0pvUkZBVVJUcndnbWlpYkg5emVoL09hdksxYW13R011eXhn?=
 =?utf-8?B?cXAvbVFrMEJ1TTBIWHVBelhONE5KL3MweDA4S3l0Wmg2OUhGdXNpMUROcDR1?=
 =?utf-8?B?NGdhbC8vQldobXZjTXh1VnZPd0FnbW9MMjRHVVQ3TlJ3by9tdUtLbjhRRDZr?=
 =?utf-8?B?dm0xeC9tb2NTeW1JVnVURjRhbkk1bGppSERFTU1ibDEwZ2FaT2pLR1lPOWtH?=
 =?utf-8?B?MHdTVDBBV2ZZd0duK2p4TVRDMDV3MUJTSWhFVk9KM21sTzBicjVkcXpuY0lB?=
 =?utf-8?B?cEJIMmZDTzI2a3BnOTZQLzJpQ0VacG85VFZwQkx5SEhLaDJuaDZvTUJpcjVl?=
 =?utf-8?B?dEgzcXZDYWxhZDk2VWYzYk9kb21jbWFCdUJVQTlEV2JJUTRZL2FtWmk0clVD?=
 =?utf-8?B?SEovc0dWeXJ1clAyQm9OdU04Nk5oVWp4N29OQXh2QVFZMzl2OFA5MFN1aURS?=
 =?utf-8?B?VGdMcFRoN0kra2E1bDAram8vd1ZLMjhmZFloa09YM2M4c1lrcFo3d0dKdHdP?=
 =?utf-8?B?YTVzL0h2b1cyYzZ3dW5oVGxZTG44LzBVL2MvSWtxSGhZT3I2MGdnQmdOR2tL?=
 =?utf-8?B?dG50bW91aHFFb1lkT3FFZXY5NjRSV3pWdVJ5MHJiU0pIcnJMM0I5MXR1cDJy?=
 =?utf-8?B?S3JXN3NRQkhPQlFBU2N4TEkreUZSd3RmL3hoSU81VEJQTFErZms3a3BPQjFn?=
 =?utf-8?B?NGpiMEVscEpOQzFURXV0NVJIN0NwUWhwc0ViRi9hRjhpNUVIUExoalpOL0tW?=
 =?utf-8?B?MmNKQVpJeUpOKys5aEFWdEFNaWpxc3VlRkFQdUdFUld2bTk2MHpOaUliVUtX?=
 =?utf-8?B?c2loKzN3ejAzdzFwT0R4T2JuYy96MjV1Nk9ic3RmNUpVOVc3TnJnRHJxc3ky?=
 =?utf-8?B?S0VpTzlURFlYanYyRXFHZ0crMGJHQ0l5ZDZVc2lvK21IcTFiU2NmLzg5aTQ2?=
 =?utf-8?B?UExBOUFsMXFVTSt2R2pYbi9qWHdxZ0EvY0tEcm1GVjllSHJkVGQ1aDRQaHln?=
 =?utf-8?B?YzkrdjAvR1ZMcnh2dWR4T0pkOFBRalBtWDAyUEZsNFhpeTBaYkZPVGpLT0Fo?=
 =?utf-8?B?dktnMmRWZm93Yk5GL1J5K0srRUVpN1ZNSXRxcFFLaTBTTkFJMWNYbkJkb1dj?=
 =?utf-8?B?VVo1QWRWUk9tc1NzNWgrRHdrWFhpQzh0a0VEQnh0TGlWOTc5V0NpUGxmVzdZ?=
 =?utf-8?B?MTd4eE9ZejlndmFVWFNXNHBHQzQ5ZmxLUmx4aTZvUmpjTlppRGdURVBtTHZ1?=
 =?utf-8?B?UTFEbTdDK3FPUFozdkhhWjZpWU5rVkpWeTdDUE5wOUtuek14R1gzV200L0xD?=
 =?utf-8?B?QlU2bHk3ZlZLeWFkV2U4TTU4clFsVkhIT2p0emZNaENpL2RsQ1RjalJ1WEFM?=
 =?utf-8?B?MWd6RklodUVoQnlHVkpkSDZJS3VvWXo0UGxwTXd2MFpWRnF2NFBHZHprRkM4?=
 =?utf-8?B?dm00akRmR25tREFmMlhpOWZQNjZNQVdwWUZ3ZE5HTHZ1OXZBWitpNGxXb29l?=
 =?utf-8?B?aEdHZ2pRclVNTVMzYmdkSnZIS0FQc0Q4czVOd2I1c2EyOWl1bTdWWjVGZENX?=
 =?utf-8?B?aXhqVm9CYTV2SXFTaU50bWpQUVVIdHVTbkw3S0luMnJXUS9UWWlHazNoZUVW?=
 =?utf-8?B?MGpMUmJCNHArdHRwcGVPeVZ0UW5FRGxlZDNpb1B0dWtKejdlMjdTZHBRSWpD?=
 =?utf-8?B?RFhjbXlVcSsxMTZXNWdHR1huRFRJNW5zaWhKK3hEbkM3QmVzd3lHVDJwVzJt?=
 =?utf-8?B?RTNRaGZlY3M1Ty9yZGN2ZzhaY1lseWQ2NVpsMHYrSkdsTlN3SWFuT05hbnZr?=
 =?utf-8?B?aHEvb2pUUmVNdUI5OGIvcDFucGY2clpyWVdSM3VDdjc0VFAwdXppM1hhTDd3?=
 =?utf-8?B?RHl0ZGdOVTdldW5pS1daTS9QU1htQ0hsQXk3OTZ3QkRVRTJWeTlQcG95YlZE?=
 =?utf-8?B?TmF0akJ2MWc3Y1hTdjFyZE1EVVJFUnNYR0Z3OG5SMFQ0ZDVrdWlIUjRtbm9E?=
 =?utf-8?B?R1VXbVp2eENMcWVjYzVybXB5UkxPNUtwV0hUcHlLOTY2ME5JaFV2bWRtdFNp?=
 =?utf-8?B?dXpJTXNnZCs5cE16VTJRMHBrS0VWRWdYdFp3UVlpYldEQmxLT2hmM1RudGhJ?=
 =?utf-8?B?OUgyTS9pSTlrd1V5c2F3QVRFN0xDbHdqRWFkMDVzQ1ZqS1RBcUprTFVHd3VC?=
 =?utf-8?B?VWRFUGNyT28wU3F3SEZCRE1ydFR3MEUwUDNXYWdvcEpaQUxLWndFOGlVaTZH?=
 =?utf-8?Q?qwtZgEQqVoO8C7VzIJivcDkpmU2ZEe8OR9jKKTlC8Xb+S?=
X-MS-Exchange-AntiSpam-MessageData-1: e8hjQ5xt742vkw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5983c34-aa7e-4e3e-74d7-08df024123f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:38:11.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4g6FpLmZVv5Th6PMb5PRc6ln495Y9Yw2fYl+acnti99vofXCX2Vy4ERgmZ6T+49XV5HHMZDjJu8OxmT5ehBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

On Mon Aug 24, 2026 at 10:07 PM JST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 2:03 PM BST, Eliot Courtney wrote:
>> On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
>>> On Mon Aug 24, 2026 at 1:50 PM BST, Eliot Courtney wrote:
>>>> On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
>>>>> In the CPU->GSP messaging path, the code reads the read pointer from =
GSP,
>>>>> writes the command, advances the write pointer, and then notifies the=
 GSP.
>>>>>
>>>>> A LOAD->STORE ordering is needed after reading the read pointer from =
GSP
>>>>> and writing the command. Control dependency exists here which provide=
 the
>>>>> needed ordering, but it's best to avoid depending on it.
>>>>>
>>>>> A STORE->STORE ordering is needed after the command write and before =
the
>>>>> write pointer advance. This is currently incorrectly done after the w=
rite
>>>>> pointer advance (and before GSP notification), but this can cause iss=
ue if
>>>>> GSP is still processing ring buffer, as it may observe the write poin=
ter
>>>>> advance before command write. Thus move this barrier to be before the=
 write
>>>>> pointer advance. Note that barriers are not needed between write poin=
ter
>>>>> advance and GSP notification, as MMIO accessors already carries the
>>>>> required barrier.
>>>>>
>>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>>> ---
>>>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
>>>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-cor=
e/gsp/cmdq.rs
>>>>> index 6da728201281..70674d2d0f77 100644
>>>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>>>> @@ -27,6 +27,11 @@
>>>>>      ptr,
>>>>>      sync::{
>>>>>          aref::ARef,
>>>>> +        barrier::{
>>>>> +            dma_mb,
>>>>> +            Full,
>>>>> +            Write, //
>>>>> +        },
>>>>>          Mutex, //
>>>>>      },
>>>>>      time::Delta,
>>>>> @@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> R=
esult<Self> {
>>>>>              (rx - 1, 0)
>>>>>          };
>>>>> =20
>>>>> +        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_=
ptr` read before data write.
>>>>> +        // Control dependency can serve the same purpose here, but w=
e don't want to rely on it.
>>>>> +        dma_mb(Full);
>>>>> +
>>>>>          // SAFETY:
>>>>>          // - `data` was created from a valid pointer, and `rx` and `=
tx` are in the
>>>>>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_wr=
ite_ptr` and `gsp_read_ptr`,
>>>>> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u=
32) {
>>>>>          let tx =3D io_project!(self.0, .cpuq.tx);
>>>>>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_c=
ount) % MSGQ_NUM_PAGES;
>>>>>          MsgqTxHeader::set_write_ptr(tx, wptr);
>>>>> -
>>>>> -        // Ensure all command data is visible before triggering the =
GSP read.
>>>>> -        fence(Ordering::SeqCst);
>>>>>      }
>>>>>  }
>>>>> =20
>>>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_=
>, command: M) -> Result
>>>>>              dst.header.length(),
>>>>>          );
>>>>> =20
>>>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_writ=
e_ptr` write after data write.
>>>>> +        dma_mb(Write);
>>>>> +
>>>>
>>>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>>>
>>> I think it's more clear to consider `advance_cpu_write_ptr` to just be =
the
>>> pointer increment, and the ordering should be visible in code that perf=
orms both
>>> memory ops.
>>
>> In the second patch, it looks like you're adding the memory barrier
>> directly in `advance_cpu_read_ptr`. So we'd have one barrier directly in
>> the code advancing the pointer and one not, which seems asymmetric. I
>> think it's less error prone to put the barrier in the function so it
>> can't be misused (and we already have evidence the barriers are easy to
>> get wrong, since this code was already broken).
>
> In the second one `message.header.length()` is read, so if I move the bar=
rier to
> before the advance it'll be incorrect.
>
> Best,
> Gary

Yerp I mean move the barrier into `advance_cpu_write_ptr` not move the
barrier out of `advance_cpu_read_ptr` - I agree that'd be incorrect. On
clearness, it feels very odd to me to have these two functions
(advance_cpu_read_ptr, advance_cpu_write_ptr) where one controls the
memory barrier and one doesn't, purely based off the structure of the
callers. And I still think it's less error prone (for future changes) to
do it this way too.
