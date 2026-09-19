Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6983C982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 15:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FD710E1AD;
	Sat, 19 Sep 2026 15:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAEqlgZZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6CE10E1AD
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgAScCOQ8cjIi707plrnct1BOMNO80o3HpnBTaD9RkLGvQJ6abxzZvQTnwWD4UM8jLDau0BRqV2s4IXi22uc2IZEKg8fGhiBHlSPi8nVe9CAcwY/L+vB7gUdoJLEyRS8vBsAceCnE08snRDNeDWswK4TeIogvmIfjwLMKXIvHylP+VJyF1rK+6jrTwX2z7Vw2coMATOXDIF+fb88S5bLmH8bqwOWKDLCeASQcsxh/X7En2NFVrKyvgHWdGsMz4hyUAgQfHe/BLdST9+LZRhmOgNqDAGGoPsbCV0z1p0fX02KznZCzsImujpzECVOUk0rPiwFm0NL42hnlk8GGF5RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUlDM3xP9Rf993PhFQDXtPCnwEN0aEZPzJsbBDMAA9I=;
 b=DzWOFuViZpXVUaTfVeDXJZXiunkf0kg2jaKljeqWDamnObrpu/I7YlPn1Hlbkk6wSVGWWXNcNunrDjsyWbkSLftTjA0Y12ktWtN1Yt13xq+Lb5BkC2ZVKFhdO9BtqywaaHnaSlsQnWNe0B9BckWfyGnSFbT2D86RCBU7wmYcseHEQIZelRyivKmJWqJDdv59x+G465pHluzp2DswHJVFRcawk2TjbSldiamvLMx/kky/KuQRl01QF0MkpxGS1fH+0vcRO/m6wTh58+uV/4vGQ0HXDZ/D6pwV+gR5ujZJglHR05vDLFAFJ9fNy5rT5Yu9llQF2Sf4MorS/LQJJekvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUlDM3xP9Rf993PhFQDXtPCnwEN0aEZPzJsbBDMAA9I=;
 b=TAEqlgZZIG44KrhI3+vfN+MOebwDZeB8n2IF+NiSB5biaw9Q70H8wr2ck5JqxQyak4A7sAU96ltjQWLoxo+x0WofTRqwAKW3t5pnmjqX2aWrt/EoRom1L7AnOQUFj5q6/f1lxCzR1RDvGoSuKCjY9cLux+enY/u552It9p6OB6Frfw3R8l0WDs9Truiot4W3XzNW3IVn8WfyrQk+K3iXRYi4s8IOhkDKwX6LQZqy2Q8fv6Kl/UxMRzXjrkeSwOkBje3kPg/5ANQp3GiU4hm96VUDxBKOXXh638q2HVIxeWTEWyWIQKdPrzCmC4SaWxfeV7SxLUgOZm1Gt8cPqBim+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 15:04:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 15:03:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 00:03:55 +0900
Message-Id: <DLJDV72PBGVA.1M0RZ780ZPJR0@nvidia.com>
To: "Dave Airlie" <airlied@gmail.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
 <CAPM=9tweFRWWjCrkBKvR03BaRVs=N+-qw2ju0g-dgMj+S7Q=ZA@mail.gmail.com>
In-Reply-To: <CAPM=9tweFRWWjCrkBKvR03BaRVs=N+-qw2ju0g-dgMj+S7Q=ZA@mail.gmail.com>
X-ClientProxiedBy: TY6PR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 6146aa36-d95f-4a83-6ec6-08df165f3b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rV80UaXWJnrVLiOxNurYIIpbr1quvuSCirlO93WrF5YLuOedeLWewC9xJDU8loJiqpOm5MeE+gRE3XusTyHS8eho00qDVGEaI42nzw7bHN5QbNzy0y3BMC6Q/XcJHm41a1glR1s+AQcn0mS/6JT2yZZLFn8coHd9HUM/DbPNk4axqoUZCHmYxPGIkI4ITuhgv/h/sNqvsDFw5jPsEAT9RIvJwGMSmL2H4YmrdHlWxAT8VdYUteYW67nuMBrKU3pHEjIK8JlmWy8d4LC+2CoF6ewiwdocU5EBWcWMLjKVXmRnIKtponTM24GklsCvk3y51ewua/2QWtsqywaTwefmT4ZsZdE+FWOEMd1m+H2XptEud09YalRPKFUQ2BFYSbsWInx8cOs/gEsUPTVeQphvizgn6Ik+xo+yU2gaUdRr7pZLtaF8Cs6hPpnJ57FulTmoNDpczeEdOUhYXE0TyGJAowyW+4/VBJYL3i3xZZLkDe/cEqJCrAjpOPdFipF9jHQ4d78ECn65sNdr2pisGgLZQFpTIHw2E+5JvzrGO3fHHs1eUxyBGqEwGFMKsKsbnVXhjIvr5CKnalIEd+Rlyas4yiju9YaIC0Gur2RHXS6cCryf2e4P4ZHQlmpEsyQt+CxLo1DvoYx9bUx+ipNOp9nWjjxiT4yjw5PjA5yUqny3nhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dLWmhDZmQvandWQ3pCNVZyejVSZ3owMEV5cENSbktrUnd1RUJ5WlRsTlgy?=
 =?utf-8?B?U3g5T1FlaC9DelJNbmhlWnVPMmxVRlZYTGtGUU1wbnlYK1ExTUVlcDltWjZI?=
 =?utf-8?B?a0tVeGF6MmVQT0JXeGIvdGFRaHI5OXdRSjVyQm44RjJWTzBieDZNWjMxbm9z?=
 =?utf-8?B?T1hqZ2lLVGJ5b2Vsd21KbytCNmJOUGRMS2VuamltTXY3alBDZVBJT0I0SVVC?=
 =?utf-8?B?RjVqK2piMkVEb1pJbDdRazBhVzlwVG5qRWk3RHJIR05UWm0zSnkxajlzU3Iw?=
 =?utf-8?B?TG5IdVJMMXE1c1BIbmlNZ1VrV3hVKzdaNFBxM2VaU2ZEWEZ0MHVHWUMwQ3hr?=
 =?utf-8?B?aFdnSkFiMnFWVm9rbnN0VDc0QnlYZTlUVzlJWkZnOVhmV3FHQ1BQR0JHNnR5?=
 =?utf-8?B?ZUk2d3l3dk9SZFpCMFRUS2xIUnlRbHpnTjY3ZzlzelZVUEw4MUdiSzN3NmlD?=
 =?utf-8?B?Z3dEZUo5eXBRdUUwNlpWQzhPeEViWC9ESjl4dXJpQy9MdVpRMXJmQkF2Tm1H?=
 =?utf-8?B?Mm5Ccjh6MVZoalFYQk9rc3QvMWdQQzZRRlgxZU53dHhLeTl4TzFYMHNVSWxY?=
 =?utf-8?B?YjZBaG9HN0M4U2w4SEdSQVEzRUYwWmZsbUIvSGRiTG9BMTVIRVNhbXhaMkNL?=
 =?utf-8?B?VU5YWFJGeHNNZHVxd2h2aXhxWWJHcVJZeG5IRTNpbnZlcFd3RG5kY0RCcytt?=
 =?utf-8?B?dEoxcXBlSjNlajZvK29QdlJYS2piMGRTOWQ0eUNRMlZLSVltUm0rYkFMUlEx?=
 =?utf-8?B?clUxUnFhbnJXTnA1WmszNktWVmdpL2lUQVA2K2RBVkVoeWJMWEpNWWZOQ3FV?=
 =?utf-8?B?S0JteWJCMW5scERveEVIaXhTeElBaWZvRkt4WEorNHJnb0xvWGJzUW5BRjdz?=
 =?utf-8?B?MFZqb2luZWpKV2F6ZUI1SVE0UUZBMmJFV01ZVHR5RWI5ME53eVVjNVBzZUs5?=
 =?utf-8?B?UGdiVTRBdE9ndHZWRUhYSDVnNTZRLzhXN2huNS8zKzhhRFdqK3J4Qmg2c0pF?=
 =?utf-8?B?cFE0R1NWenRIOGRNTElMV3BCRjRQMzdOUG9veGpWK1dxakdMbmxTanF2ZmU4?=
 =?utf-8?B?K25GcGZodFY3dGk4MEZyMDNVZUM3QkxJRkl2aFpBVThNRU1Qbk81WGcyTVRv?=
 =?utf-8?B?YVNFM1dLL0F3WmpqUUQ4ZVJVT09Obi9RaE5hRGlpTmRLbS9kdzliRmt1a04v?=
 =?utf-8?B?YkR0TDRWVEZFZTA4OEFNcnQ0VFBEcjZ1UlpzSFdVUXdRQnd4WTRsWmRidmVU?=
 =?utf-8?B?dmkrbmxONk9HOURvY3BVaTROWldwekI1ZlVBUXNralU4Y2FJUk9yMXZza1l3?=
 =?utf-8?B?dTdoNGFqZFE2OXpseGQ3elRYZGxUYWhDd0Y0eDI4MmdGcFdSK283Qmp6NWJS?=
 =?utf-8?B?Vy93SHVHUEdwMCtGSUZ4TjJOcGtZc3lYMHNNdytZQ05PQjdGTDhYZHZPUUJ4?=
 =?utf-8?B?aktCV3VGSFltSlF2bjUxbmgvMUVxZzBlMXZkc1dRai9lYitOY1NhZVk4eEJJ?=
 =?utf-8?B?STZyT3g5U2RSWnpWVkI3akFURXkxZnNZQ1Q1UFZpbURJT3h0Rlk1V1lvaUkr?=
 =?utf-8?B?andheEJISzVQTFlna2lDcUVoVldlejRHeTBiV3pwTm40WWVScWZCK1o4K3hZ?=
 =?utf-8?B?YkNOVFNCUmdpQTdIVU9BOW1mcTF1VjFKcW9JUE9TRFNrcXFVWEVjVzRjOVZ4?=
 =?utf-8?B?KzBHMnZxOUo0U0daUDVJQkZxLytCZ2pveDJBM0tORjl0cUVTbWtyRVArdW5E?=
 =?utf-8?B?MjRJdzBzcll2bGM0b1JDMVZJUlZBeWk4THIzQXd2NjNtc0pDYXNoZTgySTZQ?=
 =?utf-8?B?Z01jNU14amJHQkZwZERhWGdrWTV4TXRBa3g1QWZZZ25wSi9MOWV0UHk2VVYw?=
 =?utf-8?B?Nk9OQzdBNFhibCtPS2gxbWtaTjBQSnZTSEZmeStrWVBYRm44ai9YVTlwTVBp?=
 =?utf-8?B?TXdid09wejJwRjhVYmc2c3dEcGwxbFRiZE0zOVE0NlR2UGV4UXdCRklNbFgr?=
 =?utf-8?B?bGdwU2RpNngwMUs1RDlOQUlTLyszY0Y1d1E0YThkYllQdmp4MW5sY3MwTW8y?=
 =?utf-8?B?YnkvS3k2UWwrd2NBK0p5MHJ5LzZFUzZKMUNjWjFCSUFGWk5NL3YwSHBKV09C?=
 =?utf-8?B?NFEwVkpTZkdOaGd6NkJGQ1pIbFBZbDFQOU5ITmNmN0Q3TmRnRHR1SHF6M0Yw?=
 =?utf-8?B?S0Y2aG9FUXlSbm0yZ0daU0djakZTMU1PV3M2dHVIMTZLai9nM1VDSmdYNmVM?=
 =?utf-8?B?cFNWSC9XZE1zUEhoRWZEOXJZRzZMTS9qVWZuTVlraEVFeEtqM0NmVDU1S0Js?=
 =?utf-8?B?cUhIUk9xd1NnRU1icjJRdFRCLzFpckUwcE9KTVA4Qld2dkhPZklXK3lFRmRl?=
 =?utf-8?Q?HpfAPT8I3CGgbPs4sLbr2PEtJNRnt1asLVS/pO6jazkQ+?=
X-MS-Exchange-AntiSpam-MessageData-1: B8Z+Sfz7TeuXxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6146aa36-d95f-4a83-6ec6-08df165f3b5c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 15:03:58.9030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6sTh+rpoLlBBIAeC2oYVEzcIkMc06erKRsJ8mJ4yiir8pAmpMnchDdUZVhzVV8z5l0m9Y2tEM1/NpqTIh4kdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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

On Fri Sep 18, 2026 at 12:38 PM JST, Dave Airlie wrote:
> On Wed, 9 Sept 2026 at 14:25, Eliot Courtney <ecourtney@nvidia.com> wrote=
:
>>
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Add the BAR1 user interface for CPU access to GPU virtual memory through
>> the BAR1 aperture.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> [ecourtney: map BAR1 in NovaCore, borrow it in Gpu and BarUser, no Devre=
s]
>> [ecourtney: update for the VramAddress raw API and gsp_resources chipset=
]
>> [ecourtney: drop the owned GpuMm, pass it mutably through map and releas=
e]
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>
> BAR 1 and 2 need to be optionally detected and used. At least on SPARK
> there is only BAR0.
>
> I've been playing with John's branch on spark and had to rework this
> code to make BAR 1 optional.

Thanks Dave - indeed we also hit an issue on a device where the FB
console was enabled (?), which preventing BAR1 from being used.

I know Eliot has a bunch of follow-ups in the pipe, Eliot can we make
sure to dynamically detect and enable BAR1?
