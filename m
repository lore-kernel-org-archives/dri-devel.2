Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC81C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849E510E3FD;
	Tue,  7 Jul 2026 01:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZ5x/48M";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410D410E3FD;
 Tue,  7 Jul 2026 01:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiNOI8rhEpY+OaZ/YhwaYaAIBhjc+IIMhuqD3LvWv3Hzn/0MrM+6D/1UJoKPqS8U67h8ODmK/KNmBucHXKyfUxv3JNVUEysdSxpLyBHRDf1uz/2p8Y/wUBNM2s+S11zYAS6GwgIvZpINja8ReimLdx39/+GBYN2Ev4wF0EublsO8A1f+8PzSHIKZISLyvx6Z6kJTtU9C0OKv6Ha0OLaMsCLHRGUu6IshOXA1YgDgG5qeQF4r6JG5gu5ppdiGuKRrxh/5xVkzsY39j6WJ0mogfdISKS4WhJphdn8e/sXssxaTAIWOiRVhdRhDHth+6gDt83mvNUI6bIQvEjyixlQxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEKiUxIXj6TXQ2kWVHWHjuiZjveMfP+R1AK2MPkJ0F4=;
 b=vZ8tD8lHLwGbHVivwE2MsV2CZ1h6UyKMa+dZMJx5cPVHlyDIStV/8SyBKscfhzHQ3fwK2daF7D27zg5HX3u0LJ2PvrH9yQnFexvDhfR+79fkJgLVlrT4P9gJFlRc0tgHX/cGxUZLN2T0+pAT2zSzqS5lfPcUeL+1tlXVKYUfriB3ZWFw95t0NSs7smsyfjMzoYl6fp0tMM44VzcMIOWlPOiqfK8M9YJs+OkUj5Xf7i3LpaVW1YM2Oy6gtc/70fWXc38uNXWLeC7Fg2+eV6A6noNMNBFPctrQLIAaZTjFXnUF+SyBYS4R0Fjn5yFDKo4kpC+ggqiL2dz4kTt0Ww8OUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEKiUxIXj6TXQ2kWVHWHjuiZjveMfP+R1AK2MPkJ0F4=;
 b=pZ5x/48MXZ/CU3aixb6Lkme5wtOEaZgD/+E9HR52wEi3V7PyPakNf32fU5/9BxzzOduU5vsL1Jf980tA3g+SF96yOmnrkVv/khdO63nWoXOW+tIg9xWquuA4tUg7aIG6wRJ7PaKprfcpZ7jCPLZjtGCb4tQGZtBBEeMHRIJYhY7dmdjWZ9PwFMRklUz9U3nKv2CGWFqx60VqX1FH4rGzVzjMi8A8lN8bfijXm3Od3yPqAYhmxZKtIDExUKba9FkfglBwaySsw5lELTf/A9l5AjPQf3u7X6VYGOLb780/BKFvhigBlaXy04cHkYlo1D28yCSEmJR+2ulW36rLna5fhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 01:21:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 01:21:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 10:21:51 +0900
Message-Id: <DJRY1GRYSM2D.38JVTWHGNBXJ3@nvidia.com>
Subject: Re: [PATCH v4 09/13] gpu: nova-core: introduce GspBootMethod
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-9-5539d8469590@nvidia.com>
 <DJNQC1A84TF0.17HUBQBCRGFZ4@nvidia.com>
In-Reply-To: <DJNQC1A84TF0.17HUBQBCRGFZ4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: b28c329b-3750-454b-a366-08dedbc621ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|366016|23010399003|4143699003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 5aGH/CrAimlrkiC6erkdxsQfFvc7wmH5ki8yqxeQKMrP/X8EQAn4J+MfAG/MkfZGC8CsxzYO9Zh8Uc06f0YBKYDAqIK/D2PelZ2ulocFVrouNkJA625n+AK5klYaJzaA9I/0kfQeXJ0BJ3F8njh8bVYmVjaPqAjgpVcRqkbN0iQiK51UnKq0dnw+GdUcXEMSicG+vJXCvIMrLqiIiKDa6O2bUsUyncMONnUK8nPSxIO1bOpiJBQZLnybdXbpiB/i1wqKnWpDwOgeJX3PwXeGhixM5TLoQvbBLyEQRI2a2AuSFpI0fu7oXe2/0q7l3PWIr8oRJCwPY0jlZinRoP3qKZfuMRXXTDGLF5FetrTQ4COhsKPYMELvgvs/uHHTBx1gpZYf7K2FerlMzJFbW+UE91mejMO4hV6xmKPyX04YAqTQaP+H85csBkLBgWudW8ki/mdNpF5MhvxuobzxVLr88UGvF+WQAZN4hA9nixtNvJMULPVm3KETdW/adeoIaMCMDbYr4l/zrOPciC0qlUciZaIN8G2rgjRfod78amB9m7twQdqx6jMLqcSQzHhx7ash1iRrb7YPxNLwhgUwl857eMwTWIain5N73m3RIEAHZ32NPq521L3zxGN8R4+1u5SOQujAYfrTX9PlSaiuX9KGU8zl7MZ4pkx4BtFaZGlnrYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlPeVFEcitZZlB1UDlnUFhwUVVsbUZSS3pXY0N1TXNGQmNIbktJNHlRTnpO?=
 =?utf-8?B?QkIySmhmOVJoc3NEenFFeGFPU3g0RHVLZEtYVUYvUGFDUFVkQ1c0dThiZTRK?=
 =?utf-8?B?QVZqVFNXMDQ2SFZMaFgydVhXRVhGL0tpNzdNUG1xWlFwVDAydkppQmRJWGxV?=
 =?utf-8?B?M1hnd25peHNnOGphSE9iOTFsbXBPNnQ3YnlsYTlHNWZqTGZTb2ROc2JPVjdn?=
 =?utf-8?B?ZDUrWUZ3SUtLb3RsNmFKWjREc0ZSZ2J2T0owUnpsdUJkNGxidlVUUy85Mkdz?=
 =?utf-8?B?Zjl1M0wzRVVydVptUGNIeWdUSXFwSHlxVFpReFhTalhzUWFKblVPSGxHSzRz?=
 =?utf-8?B?Ly90QWtnMzVOTnd4NFVUQVgxRFBFRU1wWjg1NUZCR3YwN3RVMm1EU1BpUnNo?=
 =?utf-8?B?c0JVTjFZSE52SmZudWc2TUo2cEowZGFmbWNobzF6UC9pMmoySHpBTTg3aGVO?=
 =?utf-8?B?L2YycXhyYk56YjRuSVNaM2c4ZWtQNlpvRTdVLzNaS3lPaW5PcHA5Z1RYN05v?=
 =?utf-8?B?VDE1WHZoMHZoV3FVT01aMHExYzZzRjk4Y21DS2kwWGh6Q1ZXWER0eGhtcGE1?=
 =?utf-8?B?MzJtWndqdGhsbDNhOW9YdWczd2hUNklaU0FEOEVBcUJ2cGhRYWZoVWlVYzVq?=
 =?utf-8?B?TjZUbm9jMTMra1lQU1lzUkxVMkg0bW1jRmdEdnc5NUZCN0RUV1U3QW1lazRq?=
 =?utf-8?B?S3ZJOHg5Zy90WDVNVFdhbVZiZXBYdjFPS3M5YTZoMkdoeXpaQVlnMzkwMS82?=
 =?utf-8?B?RWVwckVPME5XTVRoTWhXazM0a3lRZzlPdHBpcCtJa05SOGs5WllKcW5KcFE1?=
 =?utf-8?B?bldoRVZrU2RJVzZsejNQbWs0VFpneTE3eG5TNy9TTTZNT0wvdjEybWk0WVNL?=
 =?utf-8?B?QjRzQ1ZaN3lWcE9FdGlBTEMxNzk3VWNmQ2hINlVKYXlKSEYwTFZtVStJalRt?=
 =?utf-8?B?TVU1QmliK1FjV1ZyTHN5TmFDS1JpRGY2U2xUMmoweTBFWk5GTkpESDF6S091?=
 =?utf-8?B?QjRrY0hPVXR2ZHlFZlh1d3FHVGJZckhJaFFFN2NzTnVweVF4UXRHcGpodU5X?=
 =?utf-8?B?eFFDb1RocVRKR0dnQ3FzRXNUL0pkd3BlREloaTBhNDZBWng4Mm1abEMwLzNJ?=
 =?utf-8?B?VzVIbTJBMXQxL2xPbGNFQ3NYa0dsMXNJRlV4S2ZuWTlYZlNRbncwNG5qMnVQ?=
 =?utf-8?B?VFduN1FsMElZSXlIUGtRTGw4RE9vVFR2QXUzMmdkRzZTemdRT21mU3U2VGts?=
 =?utf-8?B?a1BmNG0xanF0VGpORzFESXZWWkVWcjk1NWpYUC81b0tOR1IzQjhseXdRVWtw?=
 =?utf-8?B?dmM5RGRqUFltb0hFRGlKc0hUUU0xMXdvWUNoaVhic3M2RWErTUJJeHNpVlFV?=
 =?utf-8?B?VWFjbnRoZDdTMzZwV1FmZ1BKUXBsK0dvMjdQU21JNTJFSU5aSklkY2NKNUN4?=
 =?utf-8?B?alVscXh4djF3UkhzaDVsZlRpQnBMVFhESmZBclpaeHJRRUFJcEg1RzBNNmpX?=
 =?utf-8?B?SGxBaXkyY2EzbUNIVkZEVGRib1FLOXhVZVhpM1U3K3ltMVhzeGJXTXdLRVRF?=
 =?utf-8?B?dTNMOHRLM1JXUEN5b2M1Q0dwYy9WNjVlUk9NNiszbzJ6S1N3Yzd1K2t2K1JS?=
 =?utf-8?B?bndXQWJPUGFmSHBuUGVDWFZETTVTSWdFdUNHc2hFU3hCZzdlbkNRNWJia214?=
 =?utf-8?B?YVo2TVBndHZEK3pyK29iRDlKLzJOTEw4REdzaVphaTlCeGhpMlEydzc3aUZ1?=
 =?utf-8?B?ZnpwdEgzbjlhekU4cHc4eXpQMDhwMzhHM2E3bkUyMW1BbmRjMU03TkMvVzlL?=
 =?utf-8?B?Ky9HaXpjdllvMlpzWnBad0tLS0x5MjY1OGgwMjFlZ1ZOWEpUSVI3V1FvQkcv?=
 =?utf-8?B?MFNGTExZL21vUWx6YW4zUm9zaWh1S1ZmNXVDWTJOSFl6Z25RMGdVNUdZUXRI?=
 =?utf-8?B?ZHdNMy9qMWovVkh3V0l6YWZrUEFIeU5PU2tOc3AzYlYvYkUrak9NN01CbGMy?=
 =?utf-8?B?c0Era3R1QjAvVFVKMjFrYmJwcElVV3BJVHU2VFEzVnZlRXJWeFRpdkh0bktU?=
 =?utf-8?B?ZHdZY1I3cms3MjJwUW02NEQ1NFQ2OVdEcjNWeU1BcDhuTHlYaExCRWpyOXl1?=
 =?utf-8?B?TG04SVU3enZNMjlwb04rQzdKa3d2bHpNWjdRZVYwMktCSzZkU2xFb3ZKaUhr?=
 =?utf-8?B?NWZNVURWdXRUTklmN1p6dlVzdno4ODFIcElzbE44SmgzMXhNNXRpSDBtY1Av?=
 =?utf-8?B?dmt0bU13MForRFB4MUZkd3ViTndUTnN4U2NCbldIdXloUHB6a0ZVVFllaTlI?=
 =?utf-8?B?UTFLWHRuZmFDZnMra3RJeC9tTlM4TllmSC96TGVaYXNqL0xMdENEYmYyODYv?=
 =?utf-8?Q?X9Wmh7GyQ2moOIveXpL+CoMo5Kl9rYEp+ubp5BVJ47JYh?=
X-MS-Exchange-AntiSpam-MessageData-1: vDm7e/yDQGO4+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28c329b-3750-454b-a366-08dedbc621ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 01:21:55.5535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyJkDTPYVBoq4XyIf1CdmE6J5AWDPqKwQQlrs/AKm57R5eDL7mMWZYHnG84F1q6wsRKpIHajLXnrLOPnxED3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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

On Thu Jul 2, 2026 at 11:28 AM JST, Eliot Courtney wrote:
> On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
>> The GSP boot method is currently determined by two ad-hoc methods of
>> `Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
>> path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
>> boolean valid only for the Sec2 Booter method that tells whether the
>> FWSEC bootloader must be used).
>>
>> This is neither extensible nor sound: the combination `uses_fsp &&
>> needs_fwsec_bootloader` is invalid, but can still be expressed.
>>
>> Thus, unify these two predicates into a single `gsp_boot_method` method
>> that returns an enum type unambiguously describing the boot method to
>> use. This ensures that no invalid combination can be expressed, which
>> makes matching sounder.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>
> Ideally we would not need to expose bootloader details (needs fwsec
> bootloader, mapping of architecture to GspBootMethod) outside of the
> HAL, and also not have to duplicate the logic for determining
> `needs_fwsec_bootloader` in both the HAL and Chipset. One thing
> preventing keeping all this in the HALs is that we need to know the set
> of firmware files in a const context, which can't go through the &dyn
> for HALs. I also find it a bit odd to go Chipset->GspBootMethod->HAL
> which relies on the GSP HAL being entirely determined by the boot method
> which doesn't feel generally correct to me.

So far it is a good mapping though - the only thing abstracted by the
GSP HAL is how we boot and stop the GSP, which is entirely determined by
the boot method used.

While I agree that not exposing these details outside of the HAL would
be nice, at least for the time being we need to - the creation of the
`Fsp` happens at the `Gpu` level, and is now conditional on the boot
method. Thus the introduction of `GspBootMethod`. I would be happy to
remove this in the future if we can, but that doesn't look possible
without more refactoring, and this series is already doing quite a bit
of it just to move the `Fsp` instance up. I think going further should
be a separate effort.

>
> What if we added a const fn n gsp/hal.rs called like boot_firmware_files
> ( or whatever) which returns the extra firmware files needed to boot the
> GSP based on the architecture. Then we don't need to expose details like
> `needs_fwsec_bootloader` or `GspBootMethod` outside of the HALs. We
> still need another set of matches but it's unavoidable AFAICT without
> being able to know the HAL type in a const context, at least it's
> consolidated and in the HAL this way. In the future we might consider
> type parameterising `Gpu` with the chipset and types that it uses with
> the minimal set of strategies that it needs (e.g. sec2 vs fsp boot) then
> we could even make the HALs not use dyn and push a bunch of stuff into
> associated types.

I like this idea of a function that provides the required firmware files,
I imagine we could have the relevant modules provide the files they need
in a const function and the `ModInfoBuilder` going through that.

For the moment though, as shown in the patch you provided this requires
another match on `Architecture`, with consideration for whether we are
using the FWSEC bootloader or not, and handling the special case for
GA100 - so it's not really abstacting more things away.

Conversely, the boot method is again a perfect 1:1 mapping for the files
we need, and removes the need to special-case GA100, so I think it is a
better fit for the current state of the code.
