Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888E2C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D362F10E05A;
	Mon, 29 Jun 2026 09:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3y0oj3/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F1B10E05A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR+7zqDVKDOq5b7m72APr45I5QVllaJvASaSQrI/vsjPrRJjBj0lvd1oJK7P6vlcQUhnBVXG7r0/kf0xp7373jOxOzVeTL6leMdmJQBJZglKjENOabTiTAL5dNjDEVXJhAcGqrblzS2hqW1HYiz6IHaRHfGvdPfa4y24MrAzy6kRMacMS95QiEpU4D1cU4MlDXLzrbjl+RUcPzOEd/2yqLqUiSjSNZl02jBH0PPaxWW+OpPpsY1H8eRc1pWIq097TVF7Rs0GQE60OEfgSc27+EHw3Vv+2QApLLNn/Qy8DKkhDC/lt3h0vsEtg7CqrhpsOHy5ksGYJWw0A/vw9sc66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/IfLWS4ongUWv/hINAvyjl90yFydRvIK2izJMrtADU=;
 b=EtbhcBLKIaSg5geSPPvmQaZVBbcsluMgUJzszoDtPFf5kAfjesAYlSudCvTbuR0cxco+nlOECmrAEol2P2VyLVLzjkM21ipCTAGfF1DMlwGrmQb6n3VWAEqEBE7WvsoItzfxn0x95JHtkPo7RXzwhLWmJ30gCdsmrKoh6Bkv6RW4hOi20mr+Bz0mBfQB2o4MgBofZHz4/qKUPFA/UW/n6C7WZEuI5s/XkTOlQCXjGgsDxurN96lrM7qnFmbEbzPFDaTkUA6M7RqvlA6rs0Kz4n5pzZojJWkuWBgVM0EfhkNJbqEM47vlT1OqEkeNVHjYd+HJJaEZWKcIIR0ckahHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/IfLWS4ongUWv/hINAvyjl90yFydRvIK2izJMrtADU=;
 b=e3y0oj3/L16IiRiaB9Qn+LBofuGGcGjVviLc8uhnZEgsYdsiq8xHLeyCzNmLCto4HRaDZLDAUhA6/m5Pj8uAqGvehprWRTIovMmLJEIi2zqHsOR/1ys6lzZkQUgsje8P+ewr5Ldu4JNybG0BOHrZRoMlEG+h904IMZ/Q0S7zBwG/xPikqBO8pjkrOZ3fiRmbEs1i/mVNyx7x/MjWt9rQ9vmvvYjO9WLHnSWJDz5LY0Ct2RTT1vfcLQSjR2eET3qj+VXs8fB4OBzavjx2Az2KcMHXenUMOAUs2L0GqPXkTLD8KNC5mm7HMJPiAZ82EhEjHpG20I3BTZmW5UXfgyHzQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:45:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:45:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 18:45:01 +0900
Message-Id: <DJLFQCYVLUBU.1OHNGCE2QANK1@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, =?utf-8?q?Nicol=C3=A1s_Antinori?=
 <nico.antinori.7@gmail.com>, "David Airlie" <airlied@gmail.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Pedro Yudi Honda" <niyudi.honda@usp.br>, "SeungJong Ha"
 <engineer.jjhama@gmail.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.de>
Subject: Re: [PATCH 1/1] nova-core: Update firmware bindings to use zerocopy
 traits
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <20260629025220.1935622-2-apopple@nvidia.com>
 <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
 <CANiq72=CBpZ8qPRfNPq7sNQ-notJe5wHkP-ya+kxGv2MDZRvqg@mail.gmail.com>
In-Reply-To: <CANiq72=CBpZ8qPRfNPq7sNQ-notJe5wHkP-ya+kxGv2MDZRvqg@mail.gmail.com>
X-ClientProxiedBy: OS7PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1b93cb-731c-45f3-ecfa-08ded5c31c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8HJLqmsHNItUZux3CDykQby3dY2EwSWKqJhc/BUcwXG+xMYSHMCw5ljGD0mR9/NlLJMViq07yrn2vrHocfPvoZ6jtWp9gJ5f3Z4ZdnA7FBxFI+iD/WpvdqAfQ7x1IgYsixgAk4uHzU1OlVUDzqnWUYuFypgcAVceSH7kPm/2DbSMTxB5j4OnX8VziPdwt3LrIGPL8z3HoBSWPjxyR+X6NsRIBUMTqXB+aMPmgCFQ8/v8WWDH8DYplU7lY1g3qBtjf6uBR0EgFCuMeHoA0X+keC3cXiQS+xoVbmkdjM7GyX3Y3EugMhIjS52yyKhMNbVn3rQsWMyB8PnrsFCtvZ6npbMK2D6E3erushbIMFeDyEagC/tmLcYGno5vEjBYIpfZPWHkacptqhGEBnO5er/TGHT/OWMpsU4R5uXo/aL9JyHL+1kOnGR9+dcXiq6PKoWTid7EMi0oMl/Icjp9FV7TteumJNihvUG1YnvwAkYYuKf75oa1NdgT9oHGDgbGQ60UlCayz+tTRG6FGvl8RUDQobc3O7lBurzi2pBzJz28IRd/oiAo+qqLX2+oVAtxCNvMFz74ir8Upk659PsifjnYTPa/visXQ0Kn/ZcFtykzA6mgibJlMjLf2+cjhfXAhxhvsrlpBx0qGkpdoLIHgfVAKFxe5rrLCRr+6Lf1V05lGn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJaMytOL0tpZldsWjFwTW55dmdFQnVEWkYwb0ZvbjNyWmZ6R1JqVWpMbHUw?=
 =?utf-8?B?YUgzR0ltYkZLSGJrZDY3WnZlLytCYTdHcG16SHAvbHl5TTZ0YUtsU0FVSGxu?=
 =?utf-8?B?SlExQTM0NTRzYUVQOHVFTG5iUGtkMm8zZ2NZS0tzc1BJK2tOVzUwMU1ydkRs?=
 =?utf-8?B?UG1BQmcvNmw1ZmduTU5hR204VEIxckVucVc3Z2J1NFBWb2pGOW5XM0NhSmZH?=
 =?utf-8?B?R0FQZ2hsa1hJbTBxSk93NUZmOEgyT0hUd2JGZ0QyMlFQaDlxOTBzR3lsTnZP?=
 =?utf-8?B?Ky9rc3BGOVl2RkI5WS9BdDlOYmQ3SXdNZ1FVeHhVZ0Jzc2dnbm11Ymc2bkxP?=
 =?utf-8?B?dlZVWW16dVpXYkRFSGMzZDNzSW9LS3JpWGZWcVhRRVVURVNlRVZGSVVpRFl4?=
 =?utf-8?B?Zjk0cTBKL2tVWTB5RFg2dzhURHp1ZnZGTDFoOTBWTVhEaEs4YURkN2EzTnR4?=
 =?utf-8?B?S21NYVFibllLdUZFSUNSMzd3cEU4VStqeVRmTGhPWmlZeHVzaTFQRTBDY3Z1?=
 =?utf-8?B?T1RrbTdBbnU0a0pjS29uQlp6NFNacHQ1b1k4MUtabU1naUFjcXBrSU9KNlVG?=
 =?utf-8?B?NklPbHRkQzlKek5LaHNzenV0RUNyVHJVYzZjRFpwdG1NYlpNRmtSWjIzYUtM?=
 =?utf-8?B?bHQ5R0xGV2lBb3E3bElBeTNYdi85UE4rakM1UmJGakxXMjBiZjNHVWt6WHJB?=
 =?utf-8?B?S1JlMXBoelVRT3ZzQmh4UDhoTTdzUm5TSndzTG1ra2ZScHRDWGNqWHF1Y1Nq?=
 =?utf-8?B?SHVaVWczNnFndVNQajM3dVRXYTh2anZuejlBQkRKWFYrNDJmRUVCd0VxVDE0?=
 =?utf-8?B?MWIvZFkrUDlDckh3NVY0VmZVMzVqcGFFRWN4c3ZhY3c1ODM2UGo1NUZJWkhB?=
 =?utf-8?B?bGQvNEhXeUd5MkVwM09PYkV6RzVndHZBYTVTVWJTS2duNU82RjI2NGRFdTRU?=
 =?utf-8?B?ZGFKZElwcVEwcjFsSUk0S2c4UzkxRmt6YXc4WVZMcDZTNDJWVVdvRm1BUC9z?=
 =?utf-8?B?U3h3OHZTcXFid0pyejBPeHBIM3RTbDRBVXRIY3hxbUFFTU5MNnAyOUM3Y2Vv?=
 =?utf-8?B?Ymp6THd2clVZZ0NqNmNWYUprMGpmM1lkUVVnQnM5ZEpnUWlwTWRKK1lzdUZ0?=
 =?utf-8?B?WWlCQ2dXTHdkL1J6bHozODh1Z1gwY0hPR1VyK0w4ME1Ua3VZcGNyVm85UTUr?=
 =?utf-8?B?aDM3Q1FsUC9MTWZVTmFQZ3VQUHlQbXB6Sittemp3eW5Bbk54bzJPQWNCT09y?=
 =?utf-8?B?Y0xlc2R5QjNZU0VTNkh2bDNDVW02S3ExbXVrenBPSGpFUnpNYTlnSVd3YVNR?=
 =?utf-8?B?cG80UXlPYWZLT3VFNEhHdFIzWFRsR0FZam5TZXdyVlBFVWdPUHI1eTFCK2hH?=
 =?utf-8?B?VE0yMDFiVDZWd09nbW1pb3hkbWtFbWhza2toRTV4b1diM2tKU3lDUFJYN2VX?=
 =?utf-8?B?dCtySVpwOGROSldwemNNWkVOZ3BZTkc5QSs0QkxXcUZEaEh0S2xDMjhwUENN?=
 =?utf-8?B?enMzY2ZCS3NJZ1Rmb1gvaGsydWdOM1ViZVhtMzRQbmpuajNoWGhVbVg0aVha?=
 =?utf-8?B?NlY0WGV5OERvOW9PQzFjZW9xbFVFUmRqUUw1cUc0Nk5aYVNDMXQ0aElOek1M?=
 =?utf-8?B?Vlozem9wQWlNQldVd1pteEFoRlEwaXB0am5lelNCZTAxeEgxbjc3TjNZYUha?=
 =?utf-8?B?d0VaeTdONFF4VXhCZGl5cXdyQzc0WWFpR0xuOXJtNWJDUGQ3bmZ2TFRoS1Iw?=
 =?utf-8?B?OTZMNWFKb0oyeHM1TmFRdEhNZVFmYkJSbVRQSXI0UGRROHNYM1plcXdKTWtr?=
 =?utf-8?B?a2pSd0xGZ20xN3JweE03Sm9VblA5K1ByWUJuU25KdmFtMEptWmRMbXRsL2hW?=
 =?utf-8?B?RDZmNUIxSXoxN2pGN0wydDZCVlVxWGwwY2hCYUhTU0tUdzRKUXhqcW11QmVu?=
 =?utf-8?B?QTM1Y255ZURoYmlmSnp5bW0yQTlqSk5VNzQ5aHZsa3Q2NW93UWpISkl2SlpZ?=
 =?utf-8?B?VGhIMjd2YXlycnFBc2t6ay8weTRNY0kwemlJWjNSU1lNcUZjL3U4WmF0azZl?=
 =?utf-8?B?cFNWbjJpREJDbzFpNnFab21BSDlkeVRzZ2xjRHNHQUFNcjVxV242MUpjcGVH?=
 =?utf-8?B?WGtVVzlBWFBKZnNYT01sdWt1L2lDQjEwdHY4Wm1aTi9aNGlKck9WU3YxNFdp?=
 =?utf-8?B?dXdqN2JjK3p6TkNGOW1YMTFtUUJGam1IYXMxS1BNclAyd0hrSDhFWlBwdmtZ?=
 =?utf-8?B?bkg5UnExTWx5Uy84Z3FoVWszaDZvYzE2eVhZc0FCNkFBa3BsMUhwZHVjSHJn?=
 =?utf-8?B?ZnlKMzVkelAwSkRkcFptaXZwck15Q0g0SzNleVpEOVJYS1NYcWtRMjFkRnU3?=
 =?utf-8?Q?Y2Y1CNE0RniiZriDY5zBP1WomMrRUll9SjlJqAdj5Y6US?=
X-MS-Exchange-AntiSpam-MessageData-1: 0+czUOt9zFgt6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1b93cb-731c-45f3-ecfa-08ded5c31c7c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:45:10.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruWAe4jimtV7mZli8Yl6APWTq3ELO6RDlH4PNEBPJPbd73xOD2LLQHqqzLeTwinCjMO4+1FNGWKPd5w0eXLoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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

On Mon Jun 29, 2026 at 6:21 PM JST, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 9:37=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> This is the part my other email [1] was about: are we going, long-term,
>> to replace this with a `#[derive(zerocopy_derive::most_traits)]`? If the
>
>> This also might be something that will land soon through the Rust tree;
>> Miguel, do you know what the plan is by any chance?
>
> If you mean:
>
>   https://lore.kernel.org/rust-for-linux/20260625231919.692444-1-ojeda@ke=
rnel.org/
>
> Then yeah :)

Thanks - also, is there a plan to automatically derive
`zerocopy_derive::most_traits` for generated bindings types, or is that
something that Nova should do by itself?
