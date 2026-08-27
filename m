Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19FC61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5A610EEC5;
	Thu, 27 Aug 2026 07:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvNHPhwS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99D610EEC1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fahlVwMDXPEI6l5lY4a1/t2ARTCer42W3BVnd2/JWzOL0wARrXDeDHwJJgZc7i4DQpOAr0kg8RAnrH2KHyig8/CyMvIFCrMSxKr8JERO5f3Orfsj3dvYeaAVIRG6ygcfOzE0IS6i0SI5KjI9bkeV0wodqaRwsHO/T4VF3blWiSmnvBtMmwP/SIniD10tSBqGsYotDxuM3uIAc5ckLQsx0HWfuSaO7KGQmPLKdloneIFoV9XssgztcA0IfWIlM7IJDyUzFyp+Ui5bA5SExMr9Ttskngl4R19N9gCKeNkbhQJ/UA0AdDWy1YlIeoUIRmak7qMMB8qpYY7/guEv9xbDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXhhHGl3VLOXz792gB7aeR+tdD8rwoh60eiv+xJes28=;
 b=rPsPWoGFWoEHfjcUkwfIFMjNvQd1rjJfrk69wnsADweBfz53APbazPUetXzN3xrVlE25u46bGuMYaAZqhO2kmO96HyBoBdzrFLGeWH5thvetPQyACvrUWil512AX612qxHnbYumGREqWMWh0x9XYtUO8yDhh9sIDM86HgTTsWe12ePecMgxB6bAVpPXSLvtIoRvhfYUYmFXU7fq8DJrc3tBkXwDhxUzdNEjclclL97ihCZMR1zli2NTG9dTHJDZwNOKaVCyOPWsEiy7rmqEHUHq1KyporQaYsoyMtxBdG8guWvMdfy+6v1oC7rr2ECiVm46UeGuXMLUFgt1AnJhZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXhhHGl3VLOXz792gB7aeR+tdD8rwoh60eiv+xJes28=;
 b=nvNHPhwSt6qViR7Pcc3sCuJrIINDqOcOYGe1P3dV11XdoieIHH+yg8Kx6hgNTA4pV9EDIeUKyWlCf8wKczCbKqjtDiR1iAvrQtOsSHZgYR3qq1mvVivqRNwx95vfD5Gket4VGWkrWB1qoEHL8YH9zIc4uXHPe0LLf0ULKibPECMd1NgidGifFcZ4LwXdtuqzqpLJEQ28VI9EybbEMX2OfK3WOUVc44r8Z/rL9jV9N8+MQQ+YDzIAzoRb+7yfKugSt6FF9Fyj7n4ija6Tx5s9stO8PLvMj0YRC7u45lcYZabmqtbDghkby6PQA92Owi162iVPOki+KJw2ZEQ9OZ3Idw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v8 00/12] rust: Add support for reserving of ranges of IDs
Date: Thu, 27 Aug 2026 16:28:28 +0900
Message-Id: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XRTU7DMBAF4KtUXhM0/re74h6IRTweUyO1hSSNQ
 FXvzqRJRUSU1SjzvZH1rqKnrlIv9rur6GisfT2feAhPO4GH9vROTc08CwXKgYPQ4KHmRobSRqP
 RZYeCVz87KvX7HvP6Ns/9JX0QDpOdNg61H87dz/3OKKe9OdKDniNH2UATTKGgbCTj6OU01lzbZ
 zwfxZQ5qpVSD6VYobZkKZakc9wovVZxUZqVAkQIoFVKuFHmTwUJizLTrVgUuJIxRb9Rdq3Uoiw
 rh9557yHpYjbKrdXjXY6VdJDI5pJsyhvl18ovyrNqbfCKnMnh363bXExHXxeueZjbEqntqeH/x
 zrsdwZjag2XIgOFTAlcTuiMllKlFjkQ+CvRctjtF2eQzpQ7AgAA
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: a303b712-6c17-4dea-d697-08df040d0ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: gwv86CLYb//CSSjbMM9uizVjWoo4ThxIML8zcs0//LtJxFkvUYROwesnuO5JXRByG3QPBnv47p5ZpjaqvL9Z3wKJCKcAqO1hHVl8Oga6Zz7hPZHBsYZ2a1TukAHGVJ/BTMGRJEH8uaurZsTK8cTe1wsAgDfglQWLyKwPrTN5fg7xV0w9rnPjjBoxteSmzkkL7H9CgJs716X/DpzPXh97/OseMX59fYGo7m8eS1VMGySYntximuZ6E5ZaIFjQ8YJbxFeFzXnhl19Ynme1IvLj5q311bImaGEJHr98weyfiHqe/6WqCTHUsclfele7/pfcfDHQXNjOfjHZEmECRNpKFYP1ybohyOq1jmpaBDDJXx5+3+M091eopdzxCOpUMLQkYz/AmaZPdXuRKgg+Mw26Fq/6yxpKWx8LQHbcxH9Mj/+nGB7VMjhVjncMLibzpjB1x7UTTz27aMZ823nAZHiwwpJO1Dm+AQPnYKLQdMl4MP2pz8gSzhRigRVv0qGgvobBWp1mK7jcf2VnjtiQMDNx/sj+osfc1cLwejN90rKjiK6HZlbDH+X0cnWC5mT62KEGTI7oqfiPHu00c66Hmfzz59+MxfTx1ZoLNsV6xTL8BfF952Qyl5RVnjz8z+frMpPBNExGEzI6h6pDFl3eH0TRHJNVdf9SSfQlAToNQAin1AwQFg8lJw/mGJOAEjS2ZnTu0/t3aEKON1rVVJXrjN9zXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxRQ29XeWtoSkNzYmhWLzFZaDl1elQxVE9iNjZJN3NHSVE5U0x1VUdITFM0?=
 =?utf-8?B?SXJPWDVqbHdKR3BxK21HY0NFZ1l1T0tHd3FOdm5MOEw0T0xESjJXVW9sejJo?=
 =?utf-8?B?aktFZVlPWERLVjBRVHROM3F0dGExcC8wbEY4WjBQbXFhdHlEdFhHUHZabnli?=
 =?utf-8?B?cHRPWWxwa29QdlBGQ24ybzBpWlU2b20xT0tEUDl0dWx4ZWptdllwazViSkRy?=
 =?utf-8?B?TTFnM3c4TFhuMW9JTitQbzcxV3lCRjdXY0Z2Q0k3dTlOaDE0NXdMR2RmbHll?=
 =?utf-8?B?aUtiRFYrYkpteE9NSWlEV3cvQnJJTlV0RnlsOHFoNXNBcnZHRVlzWit3WmJJ?=
 =?utf-8?B?ZXh3dWxXR2ZwSnNWQzRDaWtSd2hZdnhYVTl4S0JWVHlSZlZtTHVOelBQeU9l?=
 =?utf-8?B?NEE3eGxLRmcxcHlWSVhSQVZmVXRPVmRPSXNxT0NhMWNZRGg1UHNKTXhndGZt?=
 =?utf-8?B?aEgyYVVRU2w3RXNwMXUzNDc2YnJIRFR4WVJ2MmtwRmNCaVNZbjZ3UzNSL21I?=
 =?utf-8?B?dndQcGIwdEtLR2dCbDdHRUpXanZaVFMrdEZLZk15NXdqZnBQWCtYblRienV6?=
 =?utf-8?B?NnllTDZaZzc0YVE0RTZUQVhsWU5PNk9XYTUwY1d2K2F4N0xyOTRYMXYyb3FF?=
 =?utf-8?B?Sy82SUx5UmpGejVPUWdWN2NOZGJqN2ZDb0V2b1lsUFA1Z0JoeUtQbW9HTHRI?=
 =?utf-8?B?Z0xrRGxDcWcvMFdONlVrVC92bTg1eCtLMUkzZVExNlFQbzk4N3k0V25Yc24y?=
 =?utf-8?B?MGJWS2hpemtxUlc3TzlLY3U0RXJLeS9OanhwWjUrQ1dDYUJ3TzdyUDRqQVJX?=
 =?utf-8?B?alZkWDB4YjQzMWJpbVVzOWNFNVorR2cwRDB0eGhTZmNDT3FCLzVLVHlWZjRK?=
 =?utf-8?B?MnQxTGJ2TEhpd0pENTQ5WUVNVmtmdFV5ZTFYQmNncUhRdTQveVRFWWpXY2FV?=
 =?utf-8?B?WWZtdHBacExaTmM4YjBLcmNZVnVEeldFank4MHNSUHpWL3ZnTUtrTTc2bGp1?=
 =?utf-8?B?OG94eEhoZW4yNGdzN25JT3BRN3hWNlJ3aWt6VmcvMDR6aUszUHArNkwwSTIz?=
 =?utf-8?B?SHpLZzdaM1dRZ3llRUZpb2NDL1QvS2k3K0ROVkpVY1dwUXllRWgzeTVZbTEx?=
 =?utf-8?B?Q0h1cmdIeVJNNTEvRE55NXpjL1c4eUlVQllIR1ZUbjYxU1VHeXE0OVpjcG9p?=
 =?utf-8?B?MG5IWG9VUjVhQjR2MXgrQnlpcHVBVndpcFJQejhIb1lId0V0OFlTTTVGZjFn?=
 =?utf-8?B?RHZxMWhGWjltemZQSFd6Y01XYXlvQVhJL1l0eWp4UXc0eUpmdnBDaTM5RFpP?=
 =?utf-8?B?NmJndXBTYU1YZXZsbnNYNmZ6bnFhV2EwTXdNTmxVZzIzZHRneEoyZFBTbjRy?=
 =?utf-8?B?aW9WVmFnS3FXZlBHbjcwYlZoTjNLZXBYRlpxbUpLNlExN2daeENoMmpvcDd3?=
 =?utf-8?B?SHp2V2RGN2JpMHdROStkYzBFdThhRFRwa3lCV3locU01MTVvZ1AvWHJSSG81?=
 =?utf-8?B?RlVGOFVhcWV3cUZrUS90K1QvUkpNQUxrMVBqTGorcjRXbW5hR2NVOWNhTm5x?=
 =?utf-8?B?cWRLUTJ4eVdZL3JpcEkzVG9yL0FjV0FnMW5WSXdydG1KV21OUnRic2w5eUFY?=
 =?utf-8?B?Umw4cEdicVhnaytjV2d6Wll6Mkh3NGZXeUhoVXgzUlVkR0ZGWUhWVVFleWwv?=
 =?utf-8?B?alBSYzh5T0M3K2FVcG5EOE96UGVMLzBVakxwc1l1ck9VZ0xKeWFEOU5KL0VF?=
 =?utf-8?B?bk0vVFA4enM0ck5FTm9xS0loRndyeFhCL05QeXVLRk1oNUhsVG5xRlhxQnYy?=
 =?utf-8?B?UWlBb2lWRzIvcXJjR3AzanVXbkpyVjM0VTZ0Z2NqSTNCNkR0UFRPUXZMREhr?=
 =?utf-8?B?MFFBWlhSaW9ZMnZ2YVBFK056dXBYSzd4b25FamtHYzhOVERKUnhXNm44Y0ZL?=
 =?utf-8?B?RVhpMlBsRkJSb216TmtLSHV2c0NnalpsNVhWa2E1S2lvSnFpaWR0N1FzalRG?=
 =?utf-8?B?YUp1REp0VWJPVG1salVsbUVzUHZkaU1QUHA4eXRER2Z4UXgvMXIxUUJJRXJp?=
 =?utf-8?B?UVNxRldXT0ZxSElDT2U5ZXhuZHdZcXNpY2hhTFZ4WTRJYVg2RE1KQjhmZFhn?=
 =?utf-8?B?RS9uemhwODJkUzQvS2VHVU5JREs4UHF2UUFrazUwYnJMZktlMDZjbjRUam5Z?=
 =?utf-8?B?UDNZaUo0cG41QzgrSVBnb2M1K1lTQ2lneE4rMDVuTVJpYWtzWGxIM1A5T29P?=
 =?utf-8?B?dE10WWoyVUVETFJVUHdGSWtMbkJoa2s3R0RKYlY5R01vend6dnRzY0lISmla?=
 =?utf-8?B?anM0MjdNeENQajhwK0tKOWxQUkk2MmRBcVdHd3c2blczSGdvcmM5MytNYnha?=
 =?utf-8?Q?xF4n2TPlqww6mBfiDg+PgWy65DWumxPz5Zf/RzI8C5ZTu?=
X-MS-Exchange-AntiSpam-MessageData-1: vr5gHrFd3qgJRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a303b712-6c17-4dea-d697-08df040d0ada
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:17.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/f1n+9Q4a+w9MS+NfiI9E9GmXJMHDtuwglB0JFoc+zkUIwj8+ynWeaRjcWqlLZK9ci1vEUlh4ZD7fs139Zr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs. This entails adding bindings for the C bitmap
API for ranges of bits, then users of that in `IdPool`, and finally a
user of `IdPool` in nova-core, `ChannelIdPool`.

Channel ID tracking is needed for allotting ranges of channel IDs to
vGPU guests, and later for regular host channel ID reservation.
nova-core needs allocation of a contiguous sequence of IDs with a
specific length and sometimes a specific alignment [1].

About the tradeoffs between different data structures:
- IDA/xarray do not support allocating a contiguous sequence of IDs
  (ida_alloc_range() allocates a single ID within a range, not a contiguous
  sequence).
- A maple tree works, but is not as good a fit. The ID space is small
  (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
  loop (plus a Mutex around it, or new mas_empty_area() bindings) that
  essentially reimplements bitmap_find_next_zero_area(). See the maple tree
  version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
  [3].
- The bitmap API natively supports aligned contiguous area allocation
  (bitmap_find_next_zero_area()).

This is based on drm-rust-next.

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v8:
- Clarify overflow cases in patch #2 (Alex)
- Replace nz! with generalized cv! macro (Gary)
- Add cv! macro to prelude
- Split SizeConstants and adding new constants patch (Alex)
- Move alignment size constants conersions patch (Alex)
- Drop NonZero on IdPool, fix grow_request instead (Alice, Alex)
- Add shrink/grow doctests (Burak)
- Link to v7: https://patch.msgid.link/20260817-chid-v7-0-a5872e64d8f4@nvidia.com

Changes in v7:
- Add nz! macro for compile time NonZero
- Implement SizeConstants for Alignment + add sub 1k size constants
- Use Alignment constants + nz! in this series
- Add final patch converting existing callers to use Alignment constants
- Rename alloc_area/release_area -> reserve_ids / release_ids
- Link to v6: https://patch.msgid.link/20260813-chid-v6-0-160be5dfb5bd@nvidia.com

Changes in v6:
- Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
- Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
- Add patch: take a NonZero capacity in `IdPool::with_capacity()`
- Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
  which also removes the bounds check in `ChannelIdPool::alloc_area`
- Add more testing of Drop for `ChannelIdPool` (Yury)
- Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com

Changes in v5:
- `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
- Only run overflow check on 32-bit (Yury)
- Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com

Changes in v4:
- Add `next_zero_area_off` to match C code (Yury)
- Replace overflow checks to match C code in bitmap-for-next.
- Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
- Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com

Changes in v3:
- Use `Alignment` type in id_pool and bitmap (Alice)
- Remove hang check on the basis that it's extraordinarily rare.
- Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com

Changes in v2:
- Collected Alice's Reviewed-by on patch 1.
- Address Yury's comments w.r.t. using __bitmap_set etc directly.
- Address Yury's comments w.r.t. following the C names
- Additionally check for an overflow case that causes a hang
- Added more info to cover letter + patch 4 w.r.t. channel ID allottment
  requirements
- Add align parameter to ChannelIdPool::alloc_area() plus an aligned
  allocation test
- Add missing INVARIANT comment when constructing UnusedArea
- Link to v1:
  https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com

---
Eliot Courtney (12):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: restrict bitmap length to at most i32::MAX
      rust: num: add cv! macro to create values from constant expressions
      rust: prelude: add `num::cv`
      rust: use cv! to build Bounded values from constants
      rust: sizes: add sub-1K size constants
      rust: sizes: implement SizeConstants for Alignment
      rust: use Alignment size constants
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous ID reservation
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/fb.rs           |  10 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs |   3 +-
 drivers/gpu/nova-core/fsp.rs          |   4 +-
 drivers/gpu/nova-core/gpu.rs          |   2 +
 drivers/gpu/nova-core/gpu/channel.rs  | 198 ++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs       |  12 +-
 drivers/gpu/nova-core/num.rs          |   3 +-
 drivers/gpu/nova-core/vbios.rs        |   7 +-
 rust/kernel/bitfield.rs               |   8 +-
 rust/kernel/bitmap.rs                 | 336 ++++++++++++++++++++++++++++++----
 rust/kernel/gpu/buddy.rs              |  26 +--
 rust/kernel/id_pool.rs                |  70 ++++++-
 rust/kernel/io.rs                     |   5 +-
 rust/kernel/num.rs                    |  88 +++++++++
 rust/kernel/num/bounded.rs            |  21 ++-
 rust/kernel/prelude.rs                |   1 +
 rust/kernel/ptr.rs                    |  13 ++
 rust/kernel/sizes.rs                  |  47 ++++-
 18 files changed, 768 insertions(+), 86 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

