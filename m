Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA8C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4549210E7C0;
	Mon, 24 Aug 2026 13:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQ4EvF9w";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0240010E1A9;
 Mon, 24 Aug 2026 13:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN8yI4DJA3P4c96oMBgnJJdGu+HKkUgugwE0fT4s37UvqTTbk8g1KpxXhIa3M9VXKFTb+ez8Q0rIcCh6sc8aW/ARm0L7ACayvTbqGx88Iwfl2DD6hjKheR9O4kNktAGYWHtK+DFhKtG7DFD3unAhgpdY9tUbV7AZwPZ2vRj4FNS+WUJtFXXXLgHd5QZTgbBbX8u68Yg1hMFSCIHPS9iqNKYr77RNRd2Olp6jUJODtQ223XUwgCS2/lzVhmm1jnHcUPlHuBYe6KApeTwgZ5IcWJ7Ncbu+0rDmnFfC0ctkiTx1pWhn+Ur5j/H7BZ4cClo//DSTxJIxxj1VilDNp3BKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rhQNhzp/86DHXCBVyY3sbNHjNlS7UgyZIomFbk84OA=;
 b=EwTqPC3rlImoa2P0Z29RJOwRBA3wMLylYiTSbObGrxfC3VJ9I+ser3upLNfUgIu36Zmu3GyBun96t3hiGjfHgrMdYzvOclZlQ4wZ517obbil2fXC1uW689J32oZ/gpLJeUUmfOC3ZhYVfrr0PSU8f/Wfy7CAfSUz2jZx4CXM+h8zLdLVm1moM6N2uKFw/HlBWrMKgaewJHwvkUDnwn6b4FcukudOPL2eD95zWoPGcqC0EH3bZiEgz0jDIUbN/q/daeW0dFUnYrFWM0ZFf1SrTvqfdenxcsgY1VT2kQL3U4RpBVNvTA4rhTstVQc1HaENIXyqWXZlT+L9QCxKRY2MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rhQNhzp/86DHXCBVyY3sbNHjNlS7UgyZIomFbk84OA=;
 b=DQ4EvF9wCc+SYlaerHjkBxbA6OY7gRmWcL1phaKON2M6QKoHSrhU5Bej8LFYiYGehg2KfA2yMy7TTckZ544DGePOl14wNHTyWhfWn+m+cNPln662KydXlsumiaVJLR1YMm1Nesb+qr8rkx7bfTV2oVR6o3zNb2SiVAZu2aP4ZDRNZoPuOJ8KhZfWKLahcHAN4lp9u4rhHZZ4GQNZ0bJXCWnbXPdH5T30WFKIfvjoVZxUfvWdVmKd82ERhx4Eu138dZt7mVIOtl6XJYqOUCRsLYuwTXnnwVyAMC24jDRA2ajHMtJIdQ7MNOgLTsLYj+unnTke1wqyEsRjjHOULGAB/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Mon, 24 Aug
 2026 13:03:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:03:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:03:24 +0900
Message-Id: <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
 <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
In-Reply-To: <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8342155e-95f2-4a4e-7362-08df01e016dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: GF2nJG38UksNWMPOqWan4XV5T+qsVcdK3xAlY0XN2PihxvskngSL/4xEaJjBmDFKrUPJksdYhj0Wr9ZAf/ZXMFlY1aAZdrRN8nFb7FyDk+IPK3ZPTifA9gcvUYudSMMnLsxeg5yt+oq7JvYd9VDHHMSEhDayKdNfF7SjMMODc5P8VK7ZNIrwnIlm7u9g2ZfCqw07HE1Pe4/FUrEywYJYsbjgkR5HpSXvsYvZiIqP/JLj/fsZFwWOGgDpO2X43F3VFpj1NCcTxiMXZ9Cy4FNYsXDJV3pXQGZ28s0NCIItL57TZgGGPVY7lYzvTXEp1H1S70AhvEjTBMq+m4FH4KY9WwLLBwptPioChmxVQnNY+H2spf1yxFU7/EHONV0bDHPdYNO2+CGSWY/kw+2zI23nkOX78Arwjbe6+//G1Tb7wiJZL8SwTliSxszGN+k+il7EkpcsKplld2DtwfiAtw+WMDI+GYBj4PK4IaMlOuDx3vV8F5SpzCrQP1m9aX1hmJHEbtPOYSIKTDt0QckMxgFYLcMtaBsln70yNyDggOF63rw2/GAcMj/BHMphIHIHNb1/7r+RoCW55oysdHpZ9K2UpW6mMeGCbllg5+l5Erq6vhLl2hhR2x5Z0fF8DmL5cXpC+7zhK9H6xkNgAgOZ/+uD3IODuNDtYjJAiwLcNZssv+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpvL1JvVkI3MkVFc0VOUlFPZFMrWmF2WHBpb3l1TVRlVHNGMVpDcUxYajRZ?=
 =?utf-8?B?MGdBTTBtSHAraWRRNDFtV09QOSs5RDU1aS9MaDRENG9pcTB5aHZjSXZVRVJF?=
 =?utf-8?B?bXZUK2FPSjRLUVZQT1FWT09NSW9BdHBqdC9GWWlLeUE2ZERiUzhkaThFL3Nr?=
 =?utf-8?B?KytpUzV1NW8vcVdhVkxVR0MrQjNNWHltR0Z4RkU2WEFJM2FTVXgvNXZkZVFx?=
 =?utf-8?B?R3o3N1RtWENaa2xYVFFPTjMvTUhxTFlyRElGRDlVdzdiNUZtWXJnRk56eE9F?=
 =?utf-8?B?TTFKMktORGNEYXN0bkhmRG81djVyUHN3bmxxOVNwdkUwU0pZc3A2d1liUnlx?=
 =?utf-8?B?Y1hzVWpDYXNXeXFabFY0YS9Hd0ZXdlBSNHZ3Wm43MFltQnlPL0drSHoycVhE?=
 =?utf-8?B?alJqVlo0dTkyb3drNm50R3dSQTlXU0FPNGs5Q2ZLWlF3UGZxUXo5RlV0Zm1P?=
 =?utf-8?B?Q3B2NS83bkdoc1EvOXc5eXpPczI4aU9OQnkrd0l6MVBaUVJHOTJLOEtpdmtl?=
 =?utf-8?B?QUJ3cW5PbGJnRTFnL1R4RnVkdFo5NGdrYy9IR1BaNmhUajV1akdsemI4c1B5?=
 =?utf-8?B?OU5FNXVNUnBPc05DQ2d3SHdYcndweEdnSkZ6MFZORnNkN3MwNDlqaUNyU0xY?=
 =?utf-8?B?R00vaUdTdGdzRnNzYThrTmhRVjZNM3dmZGU5eFg0YU9HeTJqUjV4QnlITW1y?=
 =?utf-8?B?b0VnbUo5VGNjcVN2MTV1a2FkdEFFOERYSGkvQ29FVFFra0NHN1VGNkRJSms4?=
 =?utf-8?B?bW5iRUNnQmhXMldZNktKV1IvdVVwNGxEd2lHUWhocys1MmhKQStTd0VKcmYv?=
 =?utf-8?B?ZG94eFNYa2hkMjZNQlF2SUN5ck9nSDR1NCtmcnhhc3NoVG5JeVpWajR5dk1v?=
 =?utf-8?B?MkR2VlBWTFRZKzh0cllPVkwxcjhrbFlxZlRYbG0zbnJxT3dWVUNsUnB3QjZI?=
 =?utf-8?B?YzRvMmd2alRyUjRHMU1VcmQyVmVWTTNyalBLVHJJUWRhQXFtMVQzZ1hpNnFw?=
 =?utf-8?B?cXNWVFRVSHFkTVRDQlQ0Tmh5TWlhSFgxM3V1R25QQW5oM1dkMTJLZXJUclh3?=
 =?utf-8?B?SG1zZkUxNVh0Yi9NVG9zeDVnbWUyV3phdlJOdlYwbDRsaVNONG92TFFNMisw?=
 =?utf-8?B?T1dTa2d2VnBDMFgzOU11RUtXclZFNmlWUjMxZFcwRnQ5Wjc0Rkp1cXZjbXNL?=
 =?utf-8?B?RTBxSjdId2JDSTAyNGZKSHd6b005ZlpIbXFiam9EUU1ja3Vwa0RwaVZMRTJh?=
 =?utf-8?B?UVlMUWEyS2tEOUNvY0lBd3RoMHNVTkZLK0srdHltMTdYTUdFUFgwNnZKUVE0?=
 =?utf-8?B?K0JlYzJCOCtNbk10Ty91dHBmS1hmMjQ2Z2kyZGIzWFpxNWxDQWVCWW1XQjZQ?=
 =?utf-8?B?cUhvMjBRT0NodVhUc2tGb1VIMjV3bFRXZVU5djdLSmVuME9KRkZUVklmT0lG?=
 =?utf-8?B?WWtYU2lMZEZvQnF2cG5GZ0R0Y2w2RDVuVG5UWWVnTUp2VGpjSFgxMTEwbmhn?=
 =?utf-8?B?T1NqTzBWSURNejZtNUtjVGlha1NHY0pESzgwSG90MGk5WTVXdU03Nytmc3dl?=
 =?utf-8?B?dHdCTEQ5ZldvWG1USzdaVkRIZTE3eE9LUVZSa1dkRDV6cDJ6MzZSd2ZSQW54?=
 =?utf-8?B?MmlrMXFlVFhDc3lGZnBsTEdlQ09ONW95SFZUTUpRMzlmQXdYLzlubDNkYlJs?=
 =?utf-8?B?TFp2WVBRQ2RKa3g0cEtyTk5jVFh2Z3J1ZFpKaG1ERUpqK0dod1l0K1Flcldw?=
 =?utf-8?B?YSs2dVFKK3EwdENXVDVGeEFZUGR6SXIzWlRNVnJKTXM0UlVPWWhkejRqeURW?=
 =?utf-8?B?ZHNRNkVpTG9WeGsvOW1iR0xpRW42ejB4VnU1d2E4QTFBZVB4QVU0dXpDS0E5?=
 =?utf-8?B?OWNzTFRoZldXZTFESDJSRHAzU1BkTFFjaEtWaHUzdjdUbkJCMHBSWmNUOUFj?=
 =?utf-8?B?OGRxcERRT1JrZzVzb3JGbXFlZVFWMUlZMjhJNUhmeVVuSDlCM05ITnhkeThn?=
 =?utf-8?B?QkFqNXFtRGpDTHRXLy9YSHVrdlBueDU3REExMk1PK3JKbGtxR3N1bXFiODlU?=
 =?utf-8?B?L2xjN1FuVkdVTC91ZU5id1ZKcFZNZjdPWE5lZGtINjlnMCtMSHJHZzFmNVk4?=
 =?utf-8?B?L2h4U2FDdk1MbVU1bE9Jc3pLeE1tYWJJSFRoczZoTTJITDZSeHE0MjlseG9Q?=
 =?utf-8?B?L2tHZlZ3d2VsQzJ3VTcvZ2ZKOFRqdnpQQ2JONjY4a0wvSkZNV09aa0tOTkJm?=
 =?utf-8?B?Y0pNYW1KSjlCSVZIdEJ1amVvTmhlNUFKQTRZYW5zaHhXYzFCR1Uvc0x3RzFK?=
 =?utf-8?B?cHpJK2RnNVFVZXkyaEYwQkNQTFU3VWtIbEpYM2JhM2VuRFRnVVEwRUlPYTVL?=
 =?utf-8?Q?17FRrsNsiOXmqAJE9j+CU9UHmFbVejIXi+XmYqrirglYj?=
X-MS-Exchange-AntiSpam-MessageData-1: mYZ1gVrHyH0+Vw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8342155e-95f2-4a4e-7362-08df01e016dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:03:27.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iEBzX1mRE5jGSDBQaWAFikrCll5xO+MP/zyvs4cSTl4RhSu3sJ3R8r4eUTDZqWyFYVHmZ1A2cazmMjAEZFyqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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

On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 1:50 PM BST, Eliot Courtney wrote:
>> On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
>>> In the CPU->GSP messaging path, the code reads the read pointer from GS=
P,
>>> writes the command, advances the write pointer, and then notifies the G=
SP.
>>>
>>> A LOAD->STORE ordering is needed after reading the read pointer from GS=
P
>>> and writing the command. Control dependency exists here which provide t=
he
>>> needed ordering, but it's best to avoid depending on it.
>>>
>>> A STORE->STORE ordering is needed after the command write and before th=
e
>>> write pointer advance. This is currently incorrectly done after the wri=
te
>>> pointer advance (and before GSP notification), but this can cause issue=
 if
>>> GSP is still processing ring buffer, as it may observe the write pointe=
r
>>> advance before command write. Thus move this barrier to be before the w=
rite
>>> pointer advance. Note that barriers are not needed between write pointe=
r
>>> advance and GSP notification, as MMIO accessors already carries the
>>> required barrier.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/=
gsp/cmdq.rs
>>> index 6da728201281..70674d2d0f77 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -27,6 +27,11 @@
>>>      ptr,
>>>      sync::{
>>>          aref::ARef,
>>> +        barrier::{
>>> +            dma_mb,
>>> +            Full,
>>> +            Write, //
>>> +        },
>>>          Mutex, //
>>>      },
>>>      time::Delta,
>>> @@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> Res=
ult<Self> {
>>>              (rx - 1, 0)
>>>          };
>>> =20
>>> +        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_pt=
r` read before data write.
>>> +        // Control dependency can serve the same purpose here, but we =
don't want to rely on it.
>>> +        dma_mb(Full);
>>> +
>>>          // SAFETY:
>>>          // - `data` was created from a valid pointer, and `rx` and `tx=
` are in the
>>>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_writ=
e_ptr` and `gsp_read_ptr`,
>>> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u32=
) {
>>>          let tx =3D io_project!(self.0, .cpuq.tx);
>>>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_cou=
nt) % MSGQ_NUM_PAGES;
>>>          MsgqTxHeader::set_write_ptr(tx, wptr);
>>> -
>>> -        // Ensure all command data is visible before triggering the GS=
P read.
>>> -        fence(Ordering::SeqCst);
>>>      }
>>>  }
>>> =20
>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>,=
 command: M) -> Result
>>>              dst.header.length(),
>>>          );
>>> =20
>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_write_=
ptr` write after data write.
>>> +        dma_mb(Write);
>>> +
>>
>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>
> I think it's more clear to consider `advance_cpu_write_ptr` to just be th=
e
> pointer increment, and the ordering should be visible in code that perfor=
ms both
> memory ops.

In the second patch, it looks like you're adding the memory barrier
directly in `advance_cpu_read_ptr`. So we'd have one barrier directly in
the code advancing the pointer and one not, which seems asymmetric. I
think it's less error prone to put the barrier in the function so it
can't be misused (and we already have evidence the barriers are easy to
get wrong, since this code was already broken).

>
> Best,
> Gary
>
>>
>>>          // All set - update the write pointer and inform the GSP of th=
e new command.
>>>          let elem_count =3D dst.header.element_count();
>>>          self.seq +=3D 1;

