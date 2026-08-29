Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACA9C61DD6
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C628210E013;
	Sat, 29 Aug 2026 03:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRATvRLl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A844A10E013
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 03:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS7I9LlJDanqVAZ5312BBzzQ0JXK2wGDEY/g1GRKf9oEWEKz3x85K5KmIk5dlEcnTih8TqL0KyEeC2KTyZ/HnYPowLmx9Hyvq7i/0WxRCKfl9iZExqOD3TxL1e+pjdVdV7GAgQrgimYUjurROcCxKrf7AUa+xqkXdHN8N7UFIzmnuCnSfZSlMhTqBw9F628zIXWV+Xw0s+eUqPHytM2sFPuUEkP35Bws+jvem++FOBGc2oGDxumHuNLG95rwlia5lu2/I+zqpDQn1YM8RPAkk97AVW7hC26m4yKKdv7pN2hIyj82EbSLvFIdrPbm+HlR55Qz6AsreYSkv04sIg4q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlsj3brzOGcABthXz4CA4aRqU4ZEQ/55Gbl+/NkBZ0w=;
 b=CC8OwIKxrbJgOkq6HIIryXHnssL/ju31lryWsX4ajtl6x2oFBUU8O9CJBpKf1LL0l2KNtsqWbTCOQjFN2CJwv5bvSCyb5AnGie0/gV9+lduzUxcmlVi9e+rPq6KZogAcbm7gvAUdKC5aCxefoAuV22PSFEiUGmLZBnPhJUi3abcrw217NA9svcAVrbuXfAMUe8UNkou9p1FqlxY4mFYvX23MyAGf6TNQaAu87DT7G8WL8Eo1e3IfqzOVeiEWQF0gzwiOi1sad87chYaJ+vSDDwruZ8hazlMZBkC+6oGpV9i5tnEbKGmFZD8lyIFl5SphhdUUMA1IeoE2M7z4/7WDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlsj3brzOGcABthXz4CA4aRqU4ZEQ/55Gbl+/NkBZ0w=;
 b=RRATvRLlynA6sLr+X1iHrH2ysNcWO8x4O2ix6j7ZtRRi6PRInZuC3c1jT+gsgl3107arvEwgRhcN8tYM7LeQHTU+9oTNjS3yVVsR8ws2KdVEyiO5rUNIQtTIZbYFCS4LVAcxJCqeTdNbiZxGGKsU8DmosXZbatWyBIqPlVULBo/xckor71hpgJM3jZrwsk7H4zUNwECXJkMk3vIMQXWyvlHJKQcc/RR3BNWcRtTO6Nt5arO/1OSn/Gaj2IDAW1uyOKqRioJIIin5BFJKLuKN7cZrwHg6BmXYDC2E7OPOwAIMSE+bSjYJN0wilIMPT/+O/6GAEisib0KLuUgyYh+37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 03:34:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Sat, 29 Aug 2026
 03:34:50 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Aug 2026 12:34:47 +0900
Message-Id: <DL142442KXHA.3VFWP2DHD7H2E@nvidia.com>
Cc: <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: use kernel lossless integer
 conversion module
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
 <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
In-Reply-To: <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
X-ClientProxiedBy: TY6PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: d374c011-b56c-4dc5-cd37-08df057e7b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|23010399003|3023799007|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qcv5lwPB5kvGMWQoGbFcSZxKmKOBTyVIG3FlY5qGA+Yfx2AjybOTkgCNVQToSUuSk9iXgPJMqNCgkj2K5/dOzF0fgAWDUWffcGdj30N9A4ApYsrKNzm5tzY5trGRz6wVZNk+JGf844qyn7lg7c56qI01cEmI7m8nzTwS0g3yr38bs6Uwg4It4MugEj0KB2tvW6w7pF7swoxiuMbi9AfBIDZqYvykIGGJc02Cha3SCHOxK0bhPoU0NdfniB/GnlltlRDWLQO0hys3KF9SxJ63fKkyLXWxD7IwyK1GcwanWGEhbkz6cG1aC0Vm5zplJum111fw94n8rTXl4lfa0NOffAYJCgKYbqB2zYsT547e+Rv3alMCGuNGjjTMQBJk65PhtYYvJGlpbybToRHBRZDZ0ynim3ASSZIwOwi+whUFh0wtl7BvQWDhn7P7PpvlYzGUjyIBwrMRZkC0O2gD2VlfUST67pG7bCeClc2+BHKM0ey3YDFtZkEhnQFL7sZK46dUjS5Jm71frJTOembXjjpCgqc7s70WNzHGIB3oBBsULfHrOb0JfmUvUgUcRPxGvlyfpLMqktjrdg4+XZ6o033Wq06k2II2Btk4f08rZoB7a18ltKZeZEslRujXss+b+KoUeWdYbdvqay6RRgwQsDtOWOC4IBCRpPoKCtsLufwUpD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJoN2FnMHlGN0pBWXpDM0E5T3QyekRuTUNwNW4vc1UzWVU3YkovZ2RXZitn?=
 =?utf-8?B?SGcyTXlTT2ZDaW5RUk1IWGhSSG5tL2dPYXJHanora0ZiSFlwVGZMNndTTGJo?=
 =?utf-8?B?Wmx4R3lnbC81NVV6cTNDMWZrUmtCMWJDLzNDWnM0M0FMK1h1aHN5UEVSc3NC?=
 =?utf-8?B?dUloeEQ0UEdGRE1OY0FTRWZRNWowMnQ1WlBOTG5HcFdvNDkydUhCbmE4eERa?=
 =?utf-8?B?cVpoTTFXb09hcDBidVowdm9NMUhXZjFCaHlseGFrZ1lrTzlBSXFLV08xZ0JN?=
 =?utf-8?B?cTk3SzNQTEpHYUcwcFRiSnhUUEl0YlRPMTMvRHNPYk9GUTFHWCtKM0s0ckVO?=
 =?utf-8?B?SzF4VTlMdVFmVS9DVnRIZ09acGd5L1J3cU5zWXJDbjhmMGc4MFd6OTdsVmdl?=
 =?utf-8?B?emdFWlJmaWFFRkI2VFJvbFRJenIzbDB0eGtKR3dTZWN6alBaVkZMUE9JT0Vk?=
 =?utf-8?B?dmRQaVB2OHZ0NlpWSmQ1ODJOLzhocnYxMzZhRm5UUXhmM25LTWx2bHdVa09B?=
 =?utf-8?B?eDJSNWUrOVBVd0docUZiTEgvZDNwYk9pUlFPNGI0c2NOL2hTc25MWEVFbGFX?=
 =?utf-8?B?Um1PWDE5WUl0bTNjRlBzRjJSU1grN3J6Q0hWd2ZlZVFJN0t6TGIvNk4wRkhD?=
 =?utf-8?B?MHBUWGM3TXVtdHpvVFdmK3RFalNENkhsTmJLWTFBNzFHZHpKWTJNQTRRZ1Nz?=
 =?utf-8?B?VGcycyt6MTd5WmhRSnlEZy9Sc0t1T01HUFM5RXlPcWZ2Tkg4UzJmVWg3UTdp?=
 =?utf-8?B?aEFQa20xOXhiS040RnhGZXR5WUNkL2pyQnQ1V3oyVjBzTC9qTS93RTZVcXM5?=
 =?utf-8?B?UzBRNlYyOVZ3aGFEejU4S3ZDQzZETE5iZTRtSVR2aUFuWGJXaVhZeWx0aGhq?=
 =?utf-8?B?RVphMjJMZ2xCK1JYUWxMT0g0MzBrZ0R4MFZBZ3REUE5VWG15aVpxR0IwTDJ3?=
 =?utf-8?B?VVQzYW91UDdlb3RTRCs0OE1ncG1IazExdDFvcU9leTVjZmJmZGx6d2tLSGEz?=
 =?utf-8?B?akdRY0c5bzVJaldwUHBmNnVqa095SGVoN0lOdks0Mk0vZ2I2VjVjNllneWRL?=
 =?utf-8?B?NDNJMHhmTlNGOUwzSUo1MEdSaFA3NmNpZ3VvMmZSYTl4L3NkUUQrVU9mQkda?=
 =?utf-8?B?c0lxdFcyamgrZ2NJUjZ6SklOK0xRRnhqbGRlSGhPOWNERXBlS2FlRlN2Q01J?=
 =?utf-8?B?V1hGb004Qms4QUx6U2x6TkdOTmdqVkJGMVdiNjFsdWcrN3k2MVd1UHlZQ21M?=
 =?utf-8?B?WXliTVJweHNoSW5ZaktkMzBoVTF2L3ZNQWYvSFI5RVB3YkJpa3RuSmdqWk1u?=
 =?utf-8?B?aG1mVGdrUlVlNm5mTWNPczBhalVISjNaZFJhNGpZWVlDZEJKUWdNaGlZb0Zq?=
 =?utf-8?B?QVFncU43VVdrNHptK05TaDhRK2J3K2NlSlp1OUdXNTlvUm8zSStLT2JpVDdx?=
 =?utf-8?B?N1J2Z0dwcWVTM0p0UzJwaG5pMXR4WTVXdDZBcHVTM1NxdXdmSnBEZkgyUzk5?=
 =?utf-8?B?Zy8wVU5jWFpiOUI4anlhWmJzbXQxMXErbXdXcHRFSXhEa3VDWkhCMDhCWWg4?=
 =?utf-8?B?WUhWaFVjV00wTml6bU03SzhxMnNtejI3c1cyOUN4Y09pckw3eHgxN3JvV0pq?=
 =?utf-8?B?dU9ick82anMxZ1prTHJoazR6MlNCNGZoYnpjc0duZnFlOXNHaG95NzdwOVVW?=
 =?utf-8?B?em15WXE2ejMwVHNCV2JyVmpGS0JMdXRPZGVHUHB4UXc0UUNlUU5LSFkyNFRo?=
 =?utf-8?B?Z0NHVkxNdjRodGdaWGVGM0M0cTB3VXY1aTl0VzlWdkl3VWl4SUFocHFKQk5R?=
 =?utf-8?B?ekorWDBXUzhnaThBd2N5SmFFaUNwYkFEY3YyOVVGc1hYWGlGSHdQVUp1M3dt?=
 =?utf-8?B?OEYwdktrTTl3WEFkZnJ5czJzYW51Y3g1N0hTcmd4RG5oQlJ0ekpFa1VzMWRI?=
 =?utf-8?B?cXFJVklBM25iZ2RQczdTdHFmdzREWlZJb09xTXZMWFAvYWdZeExBeGpjWlJX?=
 =?utf-8?B?OTNjWmI0aGxPZnFxMHVERHh6UFEvVmdTdmp1d3NDY0NFV0lLR0luYVc1QlR5?=
 =?utf-8?B?MzNHYjJZNVFMbDFGQU5PN0l6cm1FUjNyc255SGFvcXovQVMxalBuNXhSb1Rs?=
 =?utf-8?B?Z2p5SG1LQzJ4d2NEZ1BSNC9WWTdFMHBpY01yajdlQXNEMy93WVBocUhJN2Zp?=
 =?utf-8?B?MkUxZ2dpOEdndzdFWkljTzNiUXRrcytQWE9BcHdUVERyOFJGMnRheVNUT2sz?=
 =?utf-8?B?bzAyU29DeE1SMzZsNWJmUXRXR1E3MEJiS09lRkRVSTJOaW52dG16ZDgya25w?=
 =?utf-8?B?YjdzWG5SWWNQZ1lHTW55WnlOZnoyNmhmeXg4ZVM5clJTdDRPU3JXWk1FZ0lo?=
 =?utf-8?Q?5QLRGOGqUFnG139ntUbRA9oJpCAZQTNXzCNFl2D1WiAP/?=
X-MS-Exchange-AntiSpam-MessageData-1: GWZZvH3Lt5MSvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d374c011-b56c-4dc5-cd37-08df057e7b16
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 03:34:50.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBtoa/bTZggN+STcYe0O2gewHDrsMPpypwC+lBbNajuAZmzdmF9Z2+SJIXucTlN5kVHM5clozAKmMGPv/Etnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

On Fri Aug 28, 2026 at 9:09 PM JST, Danilo Krummrich wrote:
> (Cc: Miguel)
>
> On Fri Aug 28, 2026 at 7:33 AM CEST, Alexandre Courbot wrote:
>> The `kernel` crate now features a replacement for our lossless integer
>> conversion routines. Switch to the kernel version and remove our own.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon.rs                    |  12 +-
>>  drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
>>  drivers/gpu/nova-core/fb.rs                        |   2 +-
>>  drivers/gpu/nova-core/fb/hal/gb100.rs              |   6 +-
>>  drivers/gpu/nova-core/firmware.rs                  |   4 +-
>>  drivers/gpu/nova-core/firmware/booter.rs           |   4 +-
>>  drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   4 +-
>>  drivers/gpu/nova-core/firmware/gsp.rs              |   9 +-
>>  drivers/gpu/nova-core/firmware/tlv.rs              |  11 +-
>>  drivers/gpu/nova-core/fsp.rs                       |   8 +-
>>  drivers/gpu/nova-core/gsp.rs                       |   4 +-
>>  drivers/gpu/nova-core/gsp/cmdq.rs                  |  22 +--
>>  drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
>>  drivers/gpu/nova-core/gsp/fw/commands.rs           |   4 +-
>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
>>  drivers/gpu/nova-core/mctp.rs                      |   8 +-
>>  drivers/gpu/nova-core/num.rs                       | 211 --------------=
-------
>>  drivers/gpu/nova-core/vbios.rs                     |   2 +-
>>  19 files changed, 78 insertions(+), 283 deletions(-)
>
> Please see the discussion in [1].
>
> If we make this change, then the subsequent conversion to const_as!() wou=
ld need
> to go through the Rust tree next cycle, which could be a bit of a mess, a=
s I'd
> expect a bunch of conflicts.
>
> Alternatively, we could the the full three cycle dance, or have a signed =
tag for
> const_as!() and use it right away.
>
> But honestly, the former would just be unnecessary noise. If we don't do =
the
> latter, let's just keep the nova-core num module until the dust has been
> settled.
>
> [1] https://lore.kernel.org/all/CANiq72k+-fNWZCwGuQ=3DFTchxgm-X-f6WR=3DtG=
=3DErcn19ic1edQg@mail.gmail.com/

Maybe I am missing something, but wouldn't the following work?

- rc1 gets tagged, `drm-rust-next` gets the `num::casts` module,
- This series gets applied to `drm-rust-next`, then `cv!` (without the
  nova-core conversion patch) in `rust-next`,
- We wait one cycle for `cv!` to trickle down to `drm-rust-next` before
  converting nova-core to use `cv!`.

Would that work? This series doesn't overlap with the const conversions
that `cv!` covers on purpose, and it would have the benefit of getting
rid of the local `num` module in nova-core quickly.
