Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4563C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815DC10F962;
	Tue, 15 Sep 2026 04:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4tY1wGS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513D510F952
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HebIEByVPgnWL5N2RQfMwzen7kHIma+c2jZHDpdQyyljEzIY/fyFPZj9mgzyywaaYyNhiZJQ/O69nSFLGI4HGsGg7IPQkyMjypO6/5AA4La8+TIrQHuhbfIYV9W0pOGujZaCoO0PLWeYcraoiWV88BL1MXaDW740USpX8FZsYgIKsKrePked1VrOIR9m+D9wHV1uItA6Sx3TLuMNnZvnKkn3y9rOF5cExf8nG6Fy3X7jlx2IV1TSObd64TBNMbKiVW6kbSiSQp4O1fv8cD34CKc3tOOnQ+6vGZ7JBwI/ysvxW0iyAOY7OJv7vKJcfo78fAqCElYpvTgzM/1I2/Mf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaQpeH7XgBmFN/9CT+OqKVfRtnxe/tbkmKNW+Cj0OWE=;
 b=QWDPpGY71w1CUdo/bjVHLC/XWR37gh509T/wYKNgjh0yv7lsalMTcC3v1kw/fnoCeAZ9b+aQRS5UWR4QTsnDSO2r5NuI0/ypaoTpV9S7pybu0rF2rock/TyYqgLnzIDsrvhU2tJz3VH3NYgbDX3YkI9kyudWju+T/d/Ukcv1fBALI8Z6U2iMOxNjgJZcs8CLOTlM0AhsLM59tCwdNdhgK1lDmN1xmJxQIDJeSpbXNLdnHDIkA+Q7FlMktnRcqNZ8JjlHA61/XLVF8zEmxms4I7pyi+F4+KbZT47BzL7/Hu4FMT9pU2v+N5sEAId7Z1IGOkJSJk54yatMv3bC5DvGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaQpeH7XgBmFN/9CT+OqKVfRtnxe/tbkmKNW+Cj0OWE=;
 b=V4tY1wGSIZJ7FphAhfVUVACY+XiLi1VFaodhMWtAzz+Ks+Ak3x1Odvhc82wIuipcWCz/nBh/OrbH9KPsWRSwfcMGINv3DeB87E07AV+7mUV8GXS2w/GSiKT92buGldTMT7j+hTw21+rKgmIhE+fkA48oNW5A82fUl83LNYF67kbNQ0ZQ39Rj0D2foL1P9MUFT9aUHX0y+Oh6JQKbyHwAxAOoXQyrLqBi0F8v9RJwBmldn2Zx2nHZdbsFGXHq0ji999E0vW2uUa80cVmqEs02pqnhLdtHyjUnrj+q3TnDWnXewK7Qq8zNKDu/DjnWAMvkARLpn2btQbFeuAaSTEt6TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 04:44:37 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:44:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 13:44:33 +0900
Message-Id: <DLFM6SJH6L3P.9YG5DXQPR3TX@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Matteo Kloiber"
 <kernel@matt3o12.de>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
In-Reply-To: <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ca7c5c-9cdb-4ab6-6dc8-08df12e40ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: vF5jhJX53D5OPW8HbB5i3p2QyDFBVhesl6u5Rv8C5DM+nadGOEs0nhJ2ACEF+2PJUGPfpOTiyDy2o4tMCem9CuUhfEV0xT8dsBXLsgCSHqzhpsiVJU5Wvemm/un1YLwojWE/CLgr2HiBqEX9RTEnWueylhnQPtg0/Z2CamBLjgPqqfNLalqVeRI/A73r7xchMOQxac1gDU3N928GBPH6DfRQZeKlgy5Diq2UWa2t2wdrFz13QBUzkBvZ+j/mPPvXdrJlx8w55fAfF+D6mIujgYwaO8AoPp0kkJJy1Hv+oc5BYUa1YN0V9nj4edsJ5SGUf7k7A4bDwyUasjZaiqbLqanJ62o4rL6ADDBRe1I8q5zam32Jo2kHAG1q4m40U7hEyFsqNB48HAEZ0Mpq5eHqAMSLT+4rBEWbVFdGJkDw9ytBZ0I6cL9le1peGH28xAi/eEC15I/YhEBuN0qjz7T1noFXu92LhqGsDAbYdgVOhWlhYU3ord/Bh1ECmBZLQN1jifT2IYazoZMaQdx1gmXgxH98h7Cm4j+rf3woAijAucVR0edTRepOT/rIsENp2NmEyOEX99RPIbA8tFkTS/4AgVpKLMV3hhEdrdqXQlzkeVAztEGTj8Ba/6urwjwaygS80MaoD4jyrHX/wVmrsf79WMtzz0qsjsVRiYQgmY404wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhBWkJUUmZodDRGQzhDMW1vSE5DRWx5bzRvbURNcG9rTDZWbmFHLzZtTGxR?=
 =?utf-8?B?b2pLTmlIT0puaUVuaDFuSGI5bGh4WGpYeUFJZkkzSXFIbDJVTktrUzZsdDZW?=
 =?utf-8?B?dHp0RG02RmFxWmhzM3pHY0pEYkRGdTBaUWhzcEtTczBkNjRXYWErV3NBVHYv?=
 =?utf-8?B?Q3diUS9mUVQ4NEtxNUV0RFJnOXdtNlRwUkx4NzluclFvK0orQjdWWWd0RWtt?=
 =?utf-8?B?OTQyYXgrdlFET0Q1d1JQRmZSZEcrbXVMRGtWcjJtUmZZa09vMUt2dHFQRlA1?=
 =?utf-8?B?UHNkS3lEaUZnY1VtUnBaOTYzYmNGV1VzbzBtcW4vdHE1NXRRNVk5ckFjU0g2?=
 =?utf-8?B?aG1zTVdOK21rak5uRWpZN3VmWU1ibzVNSGJ4OWxqVzI5b2dscGxXblZWekxY?=
 =?utf-8?B?NDQ4aFB6SlVCTFBQcGhMeXo1MEp6eW11T0d1TEp3T0EwbENTOHUvb2lZMWhY?=
 =?utf-8?B?NVh3UWYydncvc0F6TVdQeHpPNW82TWd5RzBIenJ0NGhrSDRHT2FUbE9kYi8r?=
 =?utf-8?B?RnBrVE9XUTBmMlByWDBtTGhwUUZ1ZlNJcDgwMHNVQ1RBNW8zUHJmVVdKcmJy?=
 =?utf-8?B?blQzbmlHcWtkZ2t4M1BCRHZ4RGtVZ0llaHRNT1RKbkNaREpHSGsrTktaOExS?=
 =?utf-8?B?aHFsajQxOEdIZm01cFVDc1FjNCtuUGdXajY0SmVSVHJVdFhuZFNuZVgzNEJL?=
 =?utf-8?B?elBTbVJjYko5am9DcnFjK0RWbUVsNDlUZ2djc0tnOFlXeXNKN0VrZkRXbWxV?=
 =?utf-8?B?MGFKN2FpbEVNdDVhcHI4eVkveEZKYjBDeWRLVW9lbllzOGZzRm5DekNxSXkx?=
 =?utf-8?B?RHBHSFZ3U2NmWGp4bkY5R2QzU1J4aU4rVDdBRkJNRGVuODlQOWk2aDFUYi9O?=
 =?utf-8?B?R3o0RXE1YUtidlF4d3V4cG1rOEZhSi9vcmVLOGlRdUs0NjUzeURjUFFXdGd6?=
 =?utf-8?B?WC8vY0o1V2psL3MrRmgvQW54M0hGUUtPUGNLQkpKQUhmMmNjdldqQXNLSFBF?=
 =?utf-8?B?OERzbGhUdDF6VG0xdXZXeGpVQ1k4ZTFNMzV5WnRuc3NvRitoWkxTa2FJN1p6?=
 =?utf-8?B?MTAzOW1Wdk43NzFldDBTNVlKbVlPSkx4RDdORUZUUFMvS0JJdDF1Q08xZWYv?=
 =?utf-8?B?YVZWOVhaRHlEbjFKUDhJZmh5SWdNMXY1TnMxRnk2UXU0eUpXSGJqK2pTTXV5?=
 =?utf-8?B?WGQ2ZUZ5K3lMV3NtYjVjQk5jT09MSkM0ckJ6VnNseTNzM1J3WC9yMmtOeVdY?=
 =?utf-8?B?aW5Lc3FyYkxkeUx4cEdwdjl5WXNFUFdwVi95bVY0YWlaRVQwTExsVWM1NzFR?=
 =?utf-8?B?S0JlcDlyaDI2TmdUeDJDT1M2WVhzM3RzL0o3TDVFQ1N2eVRXOExzREdwQWRX?=
 =?utf-8?B?UmZaMXpjd2N1VUp5UjMrdFl1bzRrZnV4V2w1MmJkYXEvQk1FRkpRZXVqOWZt?=
 =?utf-8?B?cFN2UFdRa0c2UW5CQkFCMjFrc1M0UThUcWRKcUpKTHBuVVNodWM2UmFlbEFr?=
 =?utf-8?B?OENUTmhHcXFhOGFSL2FUUk9WMk51TFkrT1pHWitLbG9iTEU2Vzl6L2Vxb1Ro?=
 =?utf-8?B?NUdiQ2E3Y0szOU52T0IrNmswWk84THVlYVJnU3Z3emxnMEpsU1I1MXNVb2JJ?=
 =?utf-8?B?MUtxN3ZlMk9TQ1h1TUFBVzZ5MVB0NGpCWnB1cjNkbS9sRURxVmpmWVlRdExE?=
 =?utf-8?B?V3hBcnZ0Yk10NXVBWmRMMlc2QWNaTW42NWlXRmhhbDB0ak9TK2hTRUNLRERB?=
 =?utf-8?B?SWRzY1RmRVVHRURqeHY2Z2JXQlBad2R5TGNzWmFSd21LK0U5TllLYVZBOFpR?=
 =?utf-8?B?QVVqZmpPdlRpQ2lwZDVwY0N1K2NZd3pUeFhqdGU1WjZtNjRHMHA1ajByWW1j?=
 =?utf-8?B?SHUyT3F2dnE2N2ticFlSZks1T3RvVFJwRDRDQVJjRkYzTG9JWGtmK0l0UjlR?=
 =?utf-8?B?RXpmZUd4NExJWWNwVmdJdW1LNXUvQitNenBNdXg4NjhxZlFYWjcvR1lFOTdB?=
 =?utf-8?B?SFEwcFhKeWdZVlhFRlVqVWZDNG1xSjNCNFpoNklJTDhRNkxOMy94eXNuWDRL?=
 =?utf-8?B?ZEQvTUFiU0hWWldVcEZoaU00dEo0ZS9vTmxoa2dPdUVXSGJIMlJPcUw0a3pC?=
 =?utf-8?B?U2JQUnMrUkdrNUFwN2VKMmpRVnA1MHdnTkhkUHpVazhqdXJOMzJVdS9rZkdu?=
 =?utf-8?B?WnVqTjloUnUwZXFBVDhMSk9adjVsM1dqVjkraXBLT0NlNzhQUnBpTXR1TjlH?=
 =?utf-8?B?bHI1R3B4RFlnamZ2TDIwN3gyb2Ztb0trRWhKMjJrbUgvSVYyaGt6N1NZaTdk?=
 =?utf-8?B?UFROd1d0eGhkTEZMdGJ5aEJEV0NpNWxJVmV4MExBbFkzWVQ4YVUrdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca7c5c-9cdb-4ab6-6dc8-08df12e40ba8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:44:37.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRNvMYLlZHig8LIScHkMmMEMUyu+foHvY/FLxCvGS/njkMWZH1vdEFxzF+SMBpLtbbCpcu2I4SgdurimIU88ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

On Mon Sep 14, 2026 at 7:22 PM JST, Gary Guo wrote:
> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>> It also means that without patch 1, nova-core would split the firmwar=
e
>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>> something we want to avoid. The correct fix is to make sure that
>>>>> `dma_set_max_seg_size` is called by the driver, and while we are at i=
t
>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ideall=
y
>>>>> we would use the type system to make sure that both functions are cal=
led
>>>>> before any DMA operation can take place (using a safe interface), but
>>>>> I'm not quite sure yet how we can do this.
>>>>
>>>> This sounds sensible indeed. Should I open a thread regarding that on =
Zulip?
>>>
>>> Probably not necessary, the mailing-list has a larger audience and is
>>> the right place for this. I expect people will jump in here with their
>>> thoughts.
>>
>> The problem with those is not that they must strictly be called before
>> allocating DMA memory, but they must not be called concurrently with oth=
er DMA
>> operations, such as allocating DMA memory, as it would technically be a =
data
>> race.
>
> Do they really have to be called *before* allocating DMA memory, not do t=
hey
> just need not be called *concurrent* to DMA memory allocation?
>
> If it's the former, we can require these to require mutable reference ins=
tead,
> so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still derefs=
 to
> `&'bound Device<Bound>`, but Rust will require the shared reference to no=
t
> co-exist with the mutable reference.

As Danilo pointed out [1] from a strict safety perspective they must not
be called concurrently to DMA allocations. So there is not a hard need
to call them before.

But my point is different: until patch 1 of this series, nova-core
didn't do anything particularly wrong but was operating with an
inaccurate DMA segment size. Which is currently inconsequential as long
as you don't set `CONFIG_DMA_API_DEBUG`, but will become sub-optimal if
patch 2 gets merged (which it should be, otherwise more DMA-limited
devices could start misbehaving).

The thing is that every driver *really* should set their DMA mask and
max segment size ASAP, but at the moment this is done through two unsafe
functions that are very easy to overlook.

And practically speaking, is there a reason *not* to do that setup
before allocating objects?

So I am thinking that maybe we could have a kind of `DeviceDma` type
which construction involves setting the core DMA parameters (or
acknowledging the defaults), and to which all allocations would be tied.
IOW, Danilo's DMA allocations rework [2] would tie to that `DeviceDma`
object (which itself would be tied to the bound device) instead of the
device itself.

[1] https://lore.kernel.org/DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org
[2] https://lore.kernel.org/20260830193824.471089-1-dakr@kernel.org
