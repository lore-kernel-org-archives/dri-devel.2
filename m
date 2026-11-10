Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QkXy14lP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4A910E074;
	Tue, 10 Nov 2026 13:56:11 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CFD10E013
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp7HtDthJHH+fFkRLuTwtBg+KoPuHqqXpCXa5+ejP4mYF7akLPUmTMjnkizN9Sn5NmH0+OSrOmMRwfL87bnJpfiqFmKMbcib7FqBdX6TWwaJ1YRv6FvL99HpiEEHJuLJjZaP5xaiAQtn8KrijixMPXFx1qFO1x1IbTyTO14fX36peQV9+Rq9Bm/CrSiEMZn+lU09vfwRjAUIiIe6CtkKhscmsO549hpB/zmOLSgUdz+cXcX3caqFjeC7wH47fX84keHHSAqck42dHBr8vc9X1m480gPqUuOiDk+iBaKBBLg45vf63qaFclKBbw5zTNAMXRcZ7jhuXJoUHXP2SJ41dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJMS44t5T59bPBV1yAUfWPdq1LrJbk2hnEvhUKhjFn4=;
 b=Xrkt3lN/MGcSJ5BC0/9dQPWdFQQ4ZwgYgPLcL0pNE3e5Bu24EIKxHcYx1Q+lrn/eUgPojZ+6qWCiJJ6maMCAAC9UkBoGo3zmgKB+bSdZv2XnXPU5ijjoGi6M2+ZuX0e2QhmAiFgMMOUCGSItex2djqbXcIMZa6mVRxgXLvpg+SkzeEd5O9fYkxKAYQhAuYYQ335c/FaxRTcE9BZFq6v2XMPgMhI+fhncXrEsOqAGGJefb/LqmfvDih4suzoMGH9dbK9hd2W9140M3clZk4pAPUqJ8KNdQer8iJwZCdOil8soWOY2glrx54aVLIyXm6JKV1szABiRplNS6ZRdFCjeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJMS44t5T59bPBV1yAUfWPdq1LrJbk2hnEvhUKhjFn4=;
 b=QkXy14lPt4MDU5uKOdFRwlLz3JHNYeaR0HVgZwEQBJb4ocv/IoZSdA2wJ4GGkd0CRkzMgzSkO80c1gCrUHhUw+VirkXac1VO7wWxbEwZkBTWVatRSLpFAHvko/6npytwphUZ3U3e0Pb6mkN+YSNZy5xg4S5xX/bz+ejWRS0Wqbx+V/3bZLmJX+hCt76dQQXxSsPzVxDgGQgag1quHkNS4+kKxJ+BYWY5Q8Z0me3Yjy/MO1JAekoYpX8jwBF1rfzuLl2gxpgXwRkRUz4tq7tAntCpfiX0pqr74Q1gI6PQ7hTZCtsEJ2ouxPPZGRxLF/LELEux1xgscX0ci0oVBlGnfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 10 Nov
 2026 13:56:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 13:55:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 22:55:56 +0900
Message-Id: <DMRKZH6R9R7C.ELQN4JSP2U5W@nvidia.com>
Cc: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] gpu: nova-core: add support for GPU timer block.
 (v5)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
Content-Transfer-Encoding: quoted-printable
References: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
 <20261106-nova-timer-v5-2-a0cd25f3ee18@redhat.com>
 <DMPVNWCP35KX.177YD8SUQTBT7@nvidia.com>
 <CAMwc25rdXBBmDjbTOE6PMv=24USP+y11TrTec3WbC7pjnD11sQ@mail.gmail.com>
In-Reply-To: <CAMwc25rdXBBmDjbTOE6PMv=24USP+y11TrTec3WbC7pjnD11sQ@mail.gmail.com>
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a269b3-56c7-4e55-77e4-08df3f3259c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|261102123227099003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|261021121427099003|261021135927099003|4143699003|11063799006|261028144727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: g8hPZpJtY08d4//Vp8Y1Sp4RfmNO3h4kTeQ1e12XJ11QNDDD0G5RI00H8XnHiVvzGPP9gLBbWauvdJ4flBK9m3WReOGvpxHt2Kmq7kP68SOxKQVVjFMxxHO+lgx4rqurVQiVfdNh45waTm9oPQUrPwdAJNJ+qu8BuuVKPT6/wHupCk1RYrW2hPsl+F7e6qOt+M96pRqEgJJUR2sQDnlJJysAU+NZkKP2PkZBTklwTfp4Q5XtgDa9yZgONeIl1zQz7e1+7eEMEQpvPMSMREwWTvtenkd0ihlHjODKaEq0SoFyTab+/wpcAQqoCsL6iNAhoBNPFfi0DsYWt6TyE9fgLTq6qh3LQj1gbsShN2CZMgQ+qp8z5U8rb3fzH3AC1IudYHMNSVa2CwSXP8vWy5zm3vn1BQjq07TTlT0JJesLakIrZ0ygBjb6vWqbgxG+C9tR23X/lA1GKPwBMufv0ox6XuPA3/BjYgHPpOT6tuWErTgtt7pHSU5MJrlGj0plhJxbxqlXYEzKICVNYsOwzHeed1M5LNzY3fMAFKCPJhLq26vvcW0Npf5mm/8hGjr5oQMrpJBbpaS3ufnBl5mS/8urNHecszIBaNsDuPigOVTQC8+8Xx0ndUioP542JHbbrcbBsH2R6Vg9y/L4rB/3V0qCtxZbdNrCSyVwHkq7Lv4TEqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(261102123227099003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261021135927099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0tKUDhXUTcxSVZ0cGUyM3U4UGpEWlVaaDlIbGxQMzl4OHdvTFFrU3BUSlQ3?=
 =?utf-8?B?YVdUaHc5NnU4b2FNU1ovUWNPdlFrZ2FXdml4MkVWVGNQd3h1bzZJL2NGdHQw?=
 =?utf-8?B?NmFEdXY2dFBBUko1L0ZLbVdEeFQ5RVhVSk4rODl0NjRyWkUwSTArMWc5eU5Y?=
 =?utf-8?B?YVJlc3U2aDlGcTRuR0pmemV4WUw3SzZvUFJyak1tL2dHZUx6aHRWZEJmNUc3?=
 =?utf-8?B?QUYvOGdmbmdYQUUvL2h0bG1IOFVHRTc3bmdFMkkrWnpKT1FBYU96bTNOa3pp?=
 =?utf-8?B?aUVrVVNIZjBNTUk0b0FDTHFlVEgvdC9xcnF4R1lmWHZhcGcxNWhPUmtUR3lL?=
 =?utf-8?B?TzZ0b2xSLzUwbG9vYzA4WmxrMzA1cnlYbEJZZGVFditVRGxxTnF0OEZNT2N3?=
 =?utf-8?B?Vk1FREpsSWhFZmxURVRLWlcza044QnlxWDQycGs5MWkrL1NHekRGMzdvS1lJ?=
 =?utf-8?B?ZkREbTc2b0Q0TUZ1UStoR0pWd2FnZDc3NThIZTN0K0NjRXJaVVZNcFoyMGdV?=
 =?utf-8?B?T0tuYmJqbjRPaDhlZm9iaElVMkZHR3lUeS9XMFhGTHFGWVVwZVNjSm5Ocm5Y?=
 =?utf-8?B?WmZWSUdaVFlzSmRiaHhybjdyZmdVaHZ4SDNLS2xlUWs4U2Z3Ui92SHp4dENi?=
 =?utf-8?B?ZFVyYXhtQzJaQ3lHNVE5QkNEZGR6Y2JEbVVHUUpFajJaSWZvdmNUUHlOZks1?=
 =?utf-8?B?YTVLa0pZeXc0akhmVzNKMlBWSkxsbExjYnFkVjV3RGJYR3FackJFVXRGNW84?=
 =?utf-8?B?TERQMWlHclFFdSt0akQ1c0Q2SzBRZGVBb0c0eVgvejB2VkZsL0FZZ0RCSHA2?=
 =?utf-8?B?WTdqQi9yVWVXWWtEUzNqS3VKYjNia3pRZHMyWjVLbEZpOUV1emNjRTZLRS82?=
 =?utf-8?B?aC95NUVEeWdtQk1DWXpYUCtHVGZBbXhtT2N3Z1AyK0R2TFQzeFhiU0VNT1dh?=
 =?utf-8?B?S2d3d0x0YlQ4MThmbUw0cDluR2lKTWF6Mk0xcHZoeldZVHVBU2xaMG9LYXF3?=
 =?utf-8?B?VlVXU0hHS3VYWDRYZDJueEpENldhanJSTW9ySEcvcTlPWFB0MUZydHpucERj?=
 =?utf-8?B?MXJpVjNUTGtOU1duQjZWaEZxL2t1ODhsbGVsZENrZDZ0dFBuR3ZhSzV0Ti9q?=
 =?utf-8?B?SXhCeFJXcEE0Sm9rWDhHMUxacDRpR1JKK2FoL0ZWRHplQitoMytkY09QRTFL?=
 =?utf-8?B?WHQxbUM2TkgxUjNwSW9ZU2E1VW5Ud1NnNmNIUUJjbU9lUjZVSnhTVnBOYnVF?=
 =?utf-8?B?amd6SHU2c0VnOWg5VjVLR2huYmZueVlRc3RRSEFicTRKRjQyaHFCOFhLMGRw?=
 =?utf-8?B?bzIzeUplckttZkRFQmRhSVlnbCtuMytKb3dhcmQxb2cyQlFRTlhkWDhvMzdj?=
 =?utf-8?B?OXNFdFBtWWdUNzg3UGZ1ckwwTHNaVThRUmQxaUZ3TTF4ckpQZlAyRnczckVt?=
 =?utf-8?B?bXFuejFsSTJIa3ZCcXg2ck83VUlldTlRam4zbHk5R1Y1aDdra3grOTloMWtO?=
 =?utf-8?B?RUozcVMzVkVBNzltWlhieDd2MGpFYXFMMUZkZ0dUZFU1SEtOZ3Y1Y1JtVVRP?=
 =?utf-8?B?YThEdlRrLy9HTDREYko4anJ6WjlsTU8zdlliN2lPOFMyZFp6SkxhSGNUMmx0?=
 =?utf-8?B?WHBKakt6N1JGRVI4dWN3YXZDdFNyd0NNWXVrNnEwQUdyeWZhMjZoWUZxT1hG?=
 =?utf-8?B?WVpqYzIwY05ieWwvYythdjFtMW9PNHErZWhMcVNDUzVITkFSOW4yRFBxMGwz?=
 =?utf-8?B?N2JiM0JpTzE5dG0xL2oxd1VibjQ4YmROOG9Pb2hHdmZWVzVKV21CVndvTlo1?=
 =?utf-8?B?cGgrakVKTHNpNVJ1Tzg3dUQ3T2VYS1hrdWdobTNmYmFvRVd2a1pRWEJhUG1o?=
 =?utf-8?B?VEhTbllJS1p4TWdTWTFLdWd2Z0x5bnBBQ3lOYjNnZWpnUkwvVmR5bTN3TWhB?=
 =?utf-8?B?QytSakhIeWlsQ0Y1Q1JFQTZ6WGpPR0hHcFpVd2ZKS2piOVh1U3ZyUWdEano2?=
 =?utf-8?B?aUpLZlBXSkFpZUNMYUZrbHVYYXhnWVhIZXV5aXpyVytWc0dQM1BFcWE1dUg1?=
 =?utf-8?B?STdlUGhjLzhkTXJpSW1uUG54S2ZZZDRaa29xajVKbmVXTnhLMnd5SjZlL2wx?=
 =?utf-8?B?ZVpKajI3M1dyYVRHYkQrOXNTMnQ2c2VKWWJDK0JLUG9wU2dzeSs3Rld4SlhL?=
 =?utf-8?B?c0VnejR0L0N4bEIzREgyR1ZWeVl2bXMrUFhETkZha2x1SDAwSTdHWTFjUnBq?=
 =?utf-8?B?WkFKSlpsb3Q1NXJkY1JxaGx0WWkzdXljN2pobXpubTRuMW4vNnBPYWlrOG9w?=
 =?utf-8?B?WE00WXpzQnpNVGZ5K2NtQit5cEw2WFZ2bjBVVUI4aDdaWlZhSnR0RlRJUzFS?=
 =?utf-8?Q?/FjO7S2W5MczdvG25usloifABcepWwv501SDH19JOL2m5?=
X-MS-Exchange-AntiSpam-MessageData-1: yZ4MEH72XRsXfQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a269b3-56c7-4e55-77e4-08df3f3259c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:55:59.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goruHB12ADe+E5t4QvfXZkGUeuQOm3aWQ9RpZI89EouCx8gIEFNCFLo+8xyA+fVIEu+C+Eoii6EcKCmuNuepXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 10:52 AM JST, David Airlie wrote:
> On Sun, Nov 8, 2026 at 11:52=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> On Fri Nov 6, 2026 at 2:34 PM JST, Dave Airlie via B4 Relay wrote:
>> > From: Dave Airlie <airlied@redhat.com>
>> >
>> > This is needed to calculate the system timer offset that is passed
>> > to GSP init.
>> >
>> > 2 HALs exist:
>> >
>> > a) tu102 is the gv100 path from open-gpu, the priv level is checked
>> > and the cpu time is written to the gpu timer. no offset is used.
>> >
>> > b) gh100 is for hopper+
>> > This is the gh100 path from open-gpu, where the secure system
>> > timer is read, the offset is calculated.
>> > On gh100 which need a work around to avoid sending it to registers
>>
>> nit: "On gh100 a work around is needed to avoid..." maybe?
>>
>> > if the FSP firmware is too old.
>> > Otherwise we write the offset to the offset registers.
>> >
>> > Signed-off-by: Dave Airlie <airlied@redhat.com>
>> > ---
>> >  drivers/gpu/nova-core/fsp.rs             | 19 ++++++-
>> >  drivers/gpu/nova-core/fsp/hal.rs         |  5 ++
>> >  drivers/gpu/nova-core/fsp/hal/gh100.rs   |  6 ++
>> >  drivers/gpu/nova-core/fsp/regs.rs        | 28 +++++++++
>> >  drivers/gpu/nova-core/gpu.rs             |  8 +++
>> >  drivers/gpu/nova-core/nova_core.rs       |  1 +
>> >  drivers/gpu/nova-core/timer.rs           | 38 +++++++++++++
>> >  drivers/gpu/nova-core/timer/hal.rs       | 31 ++++++++++
>> >  drivers/gpu/nova-core/timer/hal/gh100.rs | 62 ++++++++++++++++++++
>> >  drivers/gpu/nova-core/timer/hal/tu102.rs | 53 +++++++++++++++++
>> >  drivers/gpu/nova-core/timer/regs.rs      | 98 +++++++++++++++++++++++=
+++++++++
>> >  11 files changed, 346 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.=
rs
>> > index 3a4a10487f33..a2ea50465a55 100644
>> > --- a/drivers/gpu/nova-core/fsp.rs
>> > +++ b/drivers/gpu/nova-core/fsp.rs
>> > @@ -50,10 +50,11 @@
>> >          NvdmHeader,
>> >          NvdmType, //
>> >      },
>> > -    regs, //
>> > +    regs as bootregs, //
>> >  };
>> >
>> >  mod hal;
>> > +mod regs;
>> >
>> >  /// PRC message sub-command.
>> >  #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> > @@ -389,6 +390,7 @@ pub(crate) fn boot_params(&self) -> &Coherent<'_, =
GspFmcBootParams> {
>> >  pub(crate) struct Fsp<'a> {
>> >      falcon: Falcon<'a, FspEngine>,
>> >      fmc_fw: GspFmcFirmware<'a>,
>> > +    chipset: Chipset,
>> >  }
>> >
>> >  impl<'a> Fsp<'a> {
>> > @@ -428,7 +430,7 @@ fn wait_secure_boot(
>> >
>> >          read_poll_timeout(
>> >              || Ok(hal.fsp_boot_status(bar)),
>> > -            |&status| status =3D=3D regs::NV_THERM_I2CS_SCRATCH_FSP_B=
OOT_COMPLETE_STATUS_SUCCESS,
>> > +            |&status| status =3D=3D bootregs::NV_THERM_I2CS_SCRATCH_F=
SP_BOOT_COMPLETE_STATUS_SUCCESS,
>> >              Delta::from_millis(10),
>> >              Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
>> >          )
>> > @@ -436,7 +438,11 @@ fn wait_secure_boot(
>> >              dev_err!(dev, "FSP secure boot completion error: {:?}\n",=
 e);
>> >          })?;
>> >
>> > -        Ok(Fsp { falcon, fmc_fw })
>> > +        Ok(Fsp {
>> > +            falcon,
>> > +            fmc_fw,
>> > +            chipset,
>> > +        })
>> >      }
>> >
>> >      /// Sends a message to FSP and waits for the response.
>> > @@ -549,4 +555,11 @@ pub(crate) fn boot_fmc(
>> >          dev_dbg!(dev, "FSP Chain of Trust completed successfully\n");
>> >          Ok(())
>> >      }
>> > +
>> > +    pub(crate) fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> bo=
ol {
>> > +        match hal::fsp_hal(self.chipset) {
>> > +            Some(hal) =3D> hal.is_bug_3957833_affected(bar),
>> > +            None =3D> false,
>>
>> As I mentioned in my other comment, storing the HAL instead of the
>> chipset is technically better, but I'm ok if this is not done just for
>> this single-use method.
>
> Okay I've done it for v6, there are places we don't do this already,
> but I'll do it for fsp.
>
>> > +fn sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> Re=
sult<u64> {
>> > +    let sec_timer_ns =3D sec_timer_read(bar);
>> > +
>> > +    let sys_timer_offset_ns =3D time_ns.wrapping_sub(sec_timer_ns);
>> > +
>> > +    if !fsp.is_bug_3957833_affected(bar) {
>> > +        bar.write_reg(regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::fr=
om_nsec(
>> > +            sys_timer_offset_ns,
>> > +        ));
>> > +        bar.write_reg(
>> > +            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sy=
s_timer_offset_ns)
>> > +                .with_update(true),
>> > +        );
>> > +    }
>> > +    Ok(sys_timer_offset_ns)
>> > +}
>>
>> So I know we discussed that on v4, but this function is named like it
>> just returns a value, whereas it also might program some registers. Can
>> we mirror what `tu102` does and extract the `if fsp.is_bug...` block
>> into another function that `setup` calls?
>
> No, this gives the workaround too much recognition. I've renamed this
> function to set_sys_timer_offset,
> That is the point of this function, to calculate and set the system
> timer offset in hardware. Broken hardware
> should not direct the function's focus, working hardware calculates
> and programs the registers.
>
>> Regarding the truncated MSBs in `nsec_hi`, I *think* it is ok to
>> truncate them indeed, as the value written would still be a valid anchor
>> value for the GPU. It also shouldn't manifest itself until 2043 or so
>> for chips < GH100, unless someone decides to mess with their system
>> clock.
>>
>> I guess this issue is the reason why GH100+ are storing a delta instead
>> of an absolute value.
>
> For v6, I've done everything else asked,
>
> For how the timer hw works, I unfortunately can't know this, because
> it isn't documented in public docs, if you guys want to pursue this
> internally, I can only do what OpenRM does.
>
> Also are we okay using OpenRM? like I know there was some issues in
> the past, maybe we need to have a proper way to reference the NVIDIA
> open-gpu-kernel-drivers.

I do recognize I have sometimes ambivalent feelings on the topic of
whether we should follow OpenRM or not. :)

When in doubt as we currently are, I think the case for following OpenRM
is that doing so at least guarantees we won't do worse than it does, and
it has the benefit of being battle-tested.

I've tried to find out more about how the timer registers work. It
appears that the GH100 SEC_TIMER starts at 0 from power-on, so unless
people mess with their system clock it should always be smaller than it,
hence subtracting it should not wrap.

Now if it *does* wrap for some unfortunate reason, we would still get a
valid timer value by adding `SEC_TIMER + OFFSET` modulo 61 bits, which
supports the case for wrapping - it just needs to be documented as
otherwise it can be pretty confusing.

Then there is the year 2043 issue because the timer values are 61 bits.
It affects both the TU102 and GH100 HALs. I guess software relying on
timestamps will have to adjust for that, but from the perspective of
programming the registers I don't think we can do much better than
masking.
