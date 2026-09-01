Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDEAC624A4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF2A10E023;
	Tue,  1 Sep 2026 02:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rayd8+Lq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5087B10E023;
 Tue,  1 Sep 2026 02:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piFwv6l6GYC38FyY/iwUurzUmT1g4TUCBpXLLLlL5QB5Ix8zYLxwuy30nDqaZzNG6/QDzfiAzR7IaSiL/K12UWJ3+CFlWfiuyKiSLUaK8vksjSNf2N0eKuG1SeA6/Oxm3azPA70Nabt0WKkvdwuYPB/bUUmfV8pCKN/aU5g2bfS7koH4EiE+IAUQ5SV+AF2wUk+LnQDmacdoTE63Jkc5t+wl9ajcOq7bQ6L4k9AQpSZpIwDOukTEOQW/o3wTbu+K45HdbM4Bl4sVAKDuUWETP9abj5EQQWPIEQx78ktNNhTsVk9Iv1eus6ZFSVu57Q1D/zxvMXBYJkrJ1UDVeh/Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOsvOtQ6syE9JzaIWjQv1n0XOB3s2aHDthskbiri1to=;
 b=pZPUhiAewgxHO4RFHeJwObG88zlmsW0QVr24l6CcGBWIRoXujxctz1A+XXcJk+oXouSnolb5iN9/2k6GlA8jMcHvZqab1tweMovO1+PUPGhTMeHpI6MnA3Bt6s2Nv1Li+yTizFQmi4DN8bRmieJeDFLg8LoBMW2tqPawR6Rdr0dqhH0+V01c2Jj/+Bx9b4IAodtyFsRuGaUy+Q3LCrzV7nohfl8SsNveIvP/A7YxJJvH1YHrcNo0BFdOVzEcHigICu+ioDHrKrEI94qc7Lfx06P6YTe81TX/X54SlGpddeMU6vADPR2/kCP6LDyyx6sZB1MivzFuiVljZx/YJTCFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOsvOtQ6syE9JzaIWjQv1n0XOB3s2aHDthskbiri1to=;
 b=Rayd8+LqKgRVqnpIA5SNO67B+aPGrUgBK8uHxtSmu4t92E8PiN10Qv0HB3i56EQO9CW7Jt6NDZc+WTD9PTgLNMjY63xDVaBcS9TiCQioc87UWqwk8bJegHLTPOmYp+vKTBSiDOoToauhIhRfQ7iipxLUfjz0xWz8AZUI26N/g3fpMJgiC2bkgptbZsjThEvchaDHWUAFdQUjJ52Xz4meTDj5isYsXENJ2pVg0v03t3js+wAFmL4QdLEZaFe+Y5GKU8FZkesX2cww3pyrkMOyVcABLVOKNjEd1i6LItysRJeCOWjWhAA8OIaBtuHqkNV6eevvPhmTdc6Hh8Bd4C6GXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 02:48:00 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:47:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 11:47:53 +0900
Message-Id: <DL3MXU3NQFLM.21AFT3KWNROVP@nvidia.com>
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
 <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
 <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
 <DKXLSOCZBYYX.1OE2DF4LYRMV5@nvidia.com>
 <DL3AYW5D121E.29D3XI699XMKN@garyguo.net>
In-Reply-To: <DL3AYW5D121E.29D3XI699XMKN@garyguo.net>
X-ClientProxiedBy: PAZP264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f0b6dc-8e80-41dd-782e-08df07d36edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|366016|376014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 5/FttQpBGKMH7Pm9Vfr2+K9T4a31oKYSWmjygSXVF+v5ZZEEQlCUMSoIT0gB+ddcstHYhqXpWQACElWmE2GThsNHJT4i1LZBgafFmAnJb0ZKs2J6PVG7C/1Y2fbmJnK36NOewOlTzOGPpx7tKAuxYbdLYoCYKZ3mnIIXNq+hLQC4BfidyThZtz5XHkzVpPQWCwNnfHeFSQARj82btGO9V4xv4GHXnbp9DfCLyq2/Td912+EuAXmL3NE3kO8QY/cSDqP1lnSo2GPevALubJm4d6mjw2emdPqusmjhZLELDX+vVvtjAQjC59Eo5aU6GDtiGt6N7N9C7RaUeIm3fT7zZrLtJPdMOwPRe5ZjwRgYjKE1xE5vFW9y+4Vo9kGzz9J3tO+b+qRIJE0z1Nq72odRL/rYNPxmjvy4/kr/8DEuIr/UxUqLfDqhPPebthJYvczGDmzrJ/4gVrNnCavQt/lhMCaTfGmxWB960jwB+Q3odaOThdh1KJwS6nACEgIsncRmgczrk2jJrnbN1aChznN/ZZGLleDYJbUn7XskYpz69Wl9r1DNHGtcXKgs15yLvQLBghzwRtDM2T9an7MqK421+ho9IzZi+kwdHbTTKVis+vBqCNxEz9xbZHnX+c0hjFHm9+DOWy4tssYkj3IHkWyY5sse7h5dk1bGcPPJKD8Kn5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21XUVlMa0VxNnFGSGxUdlY4cXlNUTlIT3NLMHJzMjBMd0NCRE96TUx4YjJs?=
 =?utf-8?B?Z0lGODUzaFlJUWRHODV5cWxnYWtWSGtUYm9HRmswNDdvWExHYXVPUThqQWZT?=
 =?utf-8?B?ODQzckJ6ME54Tmt2QTBQNHIrQnhlQ3ErMVZlUnZUekdyNEdjQXBrdTBKQUoy?=
 =?utf-8?B?SUhEcTExVkp2dTA3YVUreGZmcllsZWJud0VWRmN2bGM0RUNEUUxYZGk1eFhj?=
 =?utf-8?B?ZXFaUzNhMFZvcGlxK3BIT0JoQWsxZHlNcEpnMyt6QVRNVk9aaGx5UURJWGZN?=
 =?utf-8?B?WGxINGZ2SWlvQ3ZXeFAweW9KYkx0ajNaaUk3Sm9nNHNhWGxESHBFY09hY3lU?=
 =?utf-8?B?UDdEQ2Q1cjJITy9aeXE5eTVLc1E1VzFJYXN5OVBrSm9qZzEzRXhEMHFLYjRE?=
 =?utf-8?B?ekJXSXdKbnU0RWM2T1lnZEViSVJTc0RqcUZkczN2QnBmUGx1K0puZmtQUmVt?=
 =?utf-8?B?TXhqbWx0VmlXdkU1TEFlWnV1NWpXT29DdG5DQTA5cWo0bUVEeHR2VzRJUmtG?=
 =?utf-8?B?aHRBQVhmbzFuSFFhWnRVZWx5S1lHWVNNYU5VU2V0R0V3bEJkZ093RkZ6NW9U?=
 =?utf-8?B?TnF5azk5N09KREFmOW1vTVNqMUVXZmI2aFBEQWdhZk4ra3NGVmQyZGd0R040?=
 =?utf-8?B?UHRzQk5od0NLQW92VFNoWE9oKzNGS3lJOXA5ajUwSjNJL093T3ovYjAzNjZi?=
 =?utf-8?B?bnF3c0dManU1eVNodG1xMTc0VU4yalJ3YlJSSkpvblZQcTlCTWJ4TWJIWGNE?=
 =?utf-8?B?b3p1ME8rZkJoMVB3ZlE0TEtGQjBQcFErQktuNjV3ZWxUQzRIbUdXVFBDQzdN?=
 =?utf-8?B?V2FNOFE5Ukt5cmhZZUc0Y3hRWjJ6U0x0MXQ3TE52bGJuQUhyZGlUV0diN0dr?=
 =?utf-8?B?R1N3RVlDSnB1QXlVWU04ekppY2ZTSGRkK0ZpM3BYYk9QdTdqb2lUYjZzampJ?=
 =?utf-8?B?VlQ4RCtQV1E4R3pjVGw1RkRzR29MTy9ibmVyMlJKakpyWEdpQkxNb1Rrc04y?=
 =?utf-8?B?YjlzQkFNdVBnRm5FUE4yczhSNGhJTUNucnk4RDZCZXJGY0tIbHZTc1NPWlNH?=
 =?utf-8?B?UnJGa3o5NE9pWmhENW5hRlgvVVIwbURJY3haR3B2L1VUK3RneGVsRlkwcDdr?=
 =?utf-8?B?Z015UTB6RzRMWWczTDVSSGhCT0twekl2TzgyL3d4T3dEVHI3dms2SGZHZEdL?=
 =?utf-8?B?b2VCRnJyVE9uSTZDSDJNL0hNbzlkYW03MWt0bXdVcUl5K3NvdVlkNHJzQzhj?=
 =?utf-8?B?TFovcVNjRGk4dDErZDNvZWlRbnlVMVdWaERGc1hjdW4rQXJMMmdVWmw0MXFT?=
 =?utf-8?B?KyszbG9SQkdaYmJYQVNTTWhRQnNNQzhRM1pyT2FYSEx2dXVvajNTWFJVUVBX?=
 =?utf-8?B?enNtQzh0MUhIVEZaK20zbGtzcWtTSFNyeFN2cXNEOFdqYTliUklPQmVZcklk?=
 =?utf-8?B?aWpVNFJ2SGptZkNmdXBMcUlldWlhL0Jtc05sL2N3U2ZJYlhzbE9OTlVPRkNT?=
 =?utf-8?B?c0lzZCs3d0xTSWRHRzRZSGtYN2ZQczAvWk9VcDBpcWVZSzZHcVhodG0rNElX?=
 =?utf-8?B?VFB0aTZYZG0xRFVENEJwVGI1NmtyS3lQdVBtcXVtSVdSYzB1MStLWkVHYnQv?=
 =?utf-8?B?SlZrWmhZNWE1bTZhUjZEd0NMeVc4NEF4cFBaRGpCU2o0cUFLQjZNLzlqb2VH?=
 =?utf-8?B?dXlzWU5zamE4RUVmN2dBUlhteEFad1l0MW56clZKY09ZaWFXb3hEdUFFSFBh?=
 =?utf-8?B?TUdhZnJ6S2F6MWVKbzlFYjhqaXg0T3pEOE9TL1hIMFduVnNkeG91TUlxZ1Fs?=
 =?utf-8?B?dE9xSEJvVnRYMWZwSW9TUy9Ia2ZrWml3Y3Fva0JqcXl6YmZVNDNaWXZiTmJ5?=
 =?utf-8?B?clZkOTZHemxhaE02TDNFVlBLVUNZeDlmdWpGUklxMytkd3pPNWkyNW5nQ1Fa?=
 =?utf-8?B?VC9LZkhZM3FTaWJUTzJ2a2k4cjA1UW1xT1ZYU2dJdjFaS25Jb2duamhaZW83?=
 =?utf-8?B?ajExSXo3aUxpQzl5NURDbXpBNldyMkJoZzhjRm1Ma3Z4WXh2d1pNZEF6Q1Bw?=
 =?utf-8?B?N2FQSXlSQUltZldlVkZwNFdMakNBQ2s4b2RwK2diaXh1ZmJNU3hwRXhFZTZK?=
 =?utf-8?B?bm5hTzRJOSs4YnJidk10UVNEdmN0c0cwdTdrejkxMDlOZHZjR3lKTWp0UXB0?=
 =?utf-8?B?dWVGQTNPSC8zYU9MOHVhbEVQTkxuZzRhYWQzclJYT2tMaFpMSHZRMmFxaHVH?=
 =?utf-8?B?MDVlOGkxSnlzMWRWRDFhREhKQ1VjQXgvV3VEYmVRTXpoaWplUHZwMjc2NFJw?=
 =?utf-8?B?aDYrL0t1THJjRGdQNXM1WjhrekdNZEJiQU5RV2tqZGZLZWlleW9NV1hnSXRt?=
 =?utf-8?Q?VMX0UgXlDo1JOjna458AEz4NTuGpAB5hRArG4MFoCsvDb?=
X-MS-Exchange-AntiSpam-MessageData-1: XBCNv6lZPPxiSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f0b6dc-8e80-41dd-782e-08df07d36edd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 02:47:59.0864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jX8H3N+Yklt+EEnoQf45jfQ+VXGwP2v+Sy6I7nUhsrP0OE2BXa4+MDM0ecX+kS1JmftWI6Q0KMKxTSwpeXi0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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

On Tue Sep 1, 2026 at 2:25 AM JST, Gary Guo wrote:
> On Tue Aug 25, 2026 at 1:38 AM BST, Eliot Courtney wrote:
>> On Mon Aug 24, 2026 at 10:07 PM JST, Gary Guo wrote:
>>> On Mon Aug 24, 2026 at 2:03 PM BST, Eliot Courtney wrote:
>>>> On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
>>>>>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<=
'_>, command: M) -> Result
>>>>>>>              dst.header.length(),
>>>>>>>          );
>>>>>>> =20
>>>>>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_wr=
ite_ptr` write after data write.
>>>>>>> +        dma_mb(Write);
>>>>>>> +
>>>>>>
>>>>>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>>>>>
>>>>> I think it's more clear to consider `advance_cpu_write_ptr` to just b=
e the
>>>>> pointer increment, and the ordering should be visible in code that pe=
rforms both
>>>>> memory ops.
>>>>
>>>> In the second patch, it looks like you're adding the memory barrier
>>>> directly in `advance_cpu_read_ptr`. So we'd have one barrier directly =
in
>>>> the code advancing the pointer and one not, which seems asymmetric. I
>>>> think it's less error prone to put the barrier in the function so it
>>>> can't be misused (and we already have evidence the barriers are easy t=
o
>>>> get wrong, since this code was already broken).
>>>
>>> In the second one `message.header.length()` is read, so if I move the b=
arrier to
>>> before the advance it'll be incorrect.
>>>
>>> Best,
>>> Gary
>>
>> Yerp I mean move the barrier into `advance_cpu_write_ptr` not move the
>> barrier out of `advance_cpu_read_ptr` - I agree that'd be incorrect. On
>> clearness, it feels very odd to me to have these two functions
>> (advance_cpu_read_ptr, advance_cpu_write_ptr) where one controls the
>> memory barrier and one doesn't, purely based off the structure of the
>> callers. And I still think it's less error prone (for future changes) to
>> do it this way too.
>
> Frankly I don't like the asymmetry that the advancing code does the barri=
er,
> while the pointer reading code doesn't have the barrier. However, if we m=
ove the
> barrier to the pointer read function, then the `driver_write_area_size` w=
ould
> gain a unnecessary barrier. (Actually, `driver_read_area` code have a sim=
ilar
> issue, a failed pool would execute an unnecessary barrier).
>
> As an alternative to move the barrier into the advancing code, alternativ=
ely we
> can pull the `message.header.length()` to a separate line instead.
>
> I think we should either always have barrier inside the pointer read/upda=
te
> code, or always on the user side. Given the former would mean unnecessary
> barriers, I am erring on the latter.
>
> Best,
> Gary

I see - so you're saying that one side of the maximally consistent
position is to put the memory barriers in additionally `gsp_read_ptr`
and `gsp_write_ptr`, but those don't always need a barrier e.g.
driver_write_area_size because they are not necessarily followed by an
access that needs ordering, and the alternative is to have callers of
those functions handle that responsibility.

I think the differrence is that `advance_cpu_read_ptr` and
`advance_cpu_write_ptr` definitely need barriers, so why push up that
one level? Having barriers in `advance_cpu_read_ptr`,
`advance_cpu_write_ptr`, `driver_read_area`, and `driver_write_area` is
sufficiently consistent since it's the deepest set of functions that
can't avoid memory barriers.

If we want to remove unnecessary memory barriers on polling
`driver_read_area`, we could add an analogous `driver_read_area_size` or
move the memory barrier for driver_read_area up one level. The poll is
only once every millisecond though, so I doubt it makes a difference for
performance. But if we were to change it imo `driver_read_area_size` is
most consistent.
