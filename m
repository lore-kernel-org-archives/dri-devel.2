Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD062E9D82E
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 02:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33ECB10E186;
	Mon,  6 Apr 2026 02:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZDDiP/2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FAD10E186
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 02:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGRN+jNjWuHTCu3L4bk4jv34sjzcD9M5SFWsi1FOwDc7ZAINrLzVVSE3Q0nPAtJCFgQb8/p5m1Q0YsqTdR5/yjkH2Mt10XM7KMbblTqnxc1WFDSGmeJbVtFpQhtaPu/BvWneTN5lCutP1ZBsff4Og81WuX87HLQrvlYOhCJbrEXoqT741FMro2Bt1Tv5hNFgqTnIwoJm3VYCsaCMRCtsZyyPH0I0jL2xleceuXMnd8uHIzC+56NdRT2LXZhYIC61+Lw36U8gYdSi5KBlenLX1v4skx3RMewMhorxSv0EG+P9QToHKB5P5eLnyoBvuaDWARVesBsMqYUBq/U26l5ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dz2Za5UoHz9aqifnph2K6pU3RIADCk6olaXbfeHxJY=;
 b=HVvQa3TWm7uSiKSUuLg18li723ggQ6mP4vFg9/stJQGc1iwirtU3xYbX3E/g2UKAFA4s9s+ihOJS10BwcgOBVAH7XvYLqrdoKH9RzRGgz7wGjWwc3W+dlIp4UIhvI8Z2YN1FDVk2Y7W9DXxo4g+xy+1mWccoVUS4DYAOfdVdbCS3rkBUNDfCnqO9qXg0dquT0ZwmLmxoxzA56an95nO3b1Ywcsf5qKkwVa9ecZf4G+7rK71anJUUdo3uiptA53p2aAanrh1dnGE1iXty+Ozfdh/9GUvNtaBgKrjxqJkJP5F7gm5Jvii3A8BZVdGV8e4KbCFuB/jeAyvPvBWeOPFzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dz2Za5UoHz9aqifnph2K6pU3RIADCk6olaXbfeHxJY=;
 b=bZDDiP/2RCBtDqWXr/1lTtOs23FtAbZ1ilAbYh4rKkJqD6Wfz6jNbvPW8XxDnlRYOBLf+lRx/ORD27I3ArBx2CDE8RBSF2J2vBpbb7bBkNO2/dGZoUXcW01Ya4PRG/zVCMnko0c4VG8A7WLBxfyo0kCWmSxiTlyrzU3bXPsqr49/JAsvswjvP6JQXj751SU6BaVD5gMhxcAiwV7i4a4UwtpXT2xfV6kulItJB2Mz9g8J45R/sT1iQU1MbEbGAYFJiMQFMR45+7mKOC1V6/ysCEgJ0xC7oIdOAATfy6N/HjuKg3j8Q0gjDFg/Dp8iiJn+HrnCfYvJB9qtBjTM+3qWjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 02:29:10 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 02:29:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 11:29:06 +0900
Message-Id: <DHLPUU2FS8JN.2D56YCZ74AYUH@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] gpu: nova-core: gsp: add RM control command
 infrastructure
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <7428e395-33ce-4dd6-b74a-9f61f2b831a9@nvidia.com>
In-Reply-To: <7428e395-33ce-4dd6-b74a-9f61f2b831a9@nvidia.com>
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: d6408696-360d-4677-7490-08de938448f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: D6K1SyPxLPjZoRtteyClFiiNkWMuw7k5P38XuixqcNf+HfSsysGnAPbVC+TJZhKFcdO161uX/R8yW8Ll3Y3NcEhybcuoPtExInOkUgX/wkhCBI9/HbAVA3e2UIAvzN5tWsW3qS+z1XOpljtueu4ZCBN+rW5E4BkPr/XjRiu2bqNKjQJrzbJgD4RzWLvPvYpXH4Cn7Yb2yBjmKLeuslz8fAcqqlWn5sbzAkgMtfo8hT7lS3IJG/AlLc4lV4cW6wlf+xIC0AA/Z5vx+shoFDZnuZBVEIK5bgnLlDHd0QuvJtovpgrYfZz04gZYVbuqI4jPFiG2UtPtXl8PTRMCl34W2cX1DnU/p6F6Mok4gR5OI/+i/WBTS9KUmLDiVfwnFUArc+fBMRIqKfxn8PKnOy7FSYALeJSad65hORptyUzFkYS58RPwG50D1NULy2X6RBP5rb1R/fTM76PCrwIxlZPVEJ1Yii0YJsrAUAzX2uRdYVPzyiEurmSDKa9INWbMM4dsRZ+Qw0NP+tQWdfGHD74z+rG7D8y/Mw6VtZqWJD+yUvW0sERoqRRRAWw72nVoX99hKVjRch31isE7vs3c9tg6KpXUeKD8kVn30XpwUSNCx5h0Yn/WJj1phAKkdoSfZWaWYiAnJFX8rkiCAMTCVR504A/ghBlMVCZ64fzwzXXnm6u69fAa78wUs5Fyq2QWhyaSrcqKB0gViuHkJBl3qs7myF5XTtOXTvmniS38+oNx9O8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVweUlvQVlsaE5DdGZYQ2FIQldPRFB2Znc3VTY1Nll6MTVQSmlZaXZScHBH?=
 =?utf-8?B?V3hEc0pGMDJ2VHhERURoMVcxb3dZRkVwU2RDUm43bUpaWERsd2h4OGR3YXlm?=
 =?utf-8?B?cHJxTS8zSUwxaFR2RmNLTE1LWlVwMllSQ0NTbllMRk5COVFWRXRCaUMvbUxl?=
 =?utf-8?B?Z0FreU1BTXlYMUwwME5TeS9ISG9rWEV3azlubHVRQWJBL04vV0dqdzhPZ2NK?=
 =?utf-8?B?c0Y1SXJ2VTRXQTA4dHBIV3UwR3d6cHIza2FZRVdvWGVaMi96eXJ6TElOcWU4?=
 =?utf-8?B?cDg5eTYvV3hMdTVNYjQxd2tNRTJiM1BTYVpQZWFqMDhOeFdOV1BreVpXMGJD?=
 =?utf-8?B?UXdaMGpJVWZpNTNRL1B1dTEvNmxCb2FDbklRczFLSFNVYmR4RTFYTHRGTnVN?=
 =?utf-8?B?eFk5aDNlelY4R294MkVIdVlxLzkweC9FRDNVb1NaK3o1SGEwaFFIZkQyMjN6?=
 =?utf-8?B?d2E2c3I0ekNjb0lOT2o0Z0hjN1VnZXlHbWcrbEx5MVBwTEE1WTVkWFV5Y0Rv?=
 =?utf-8?B?cUZHc3NNMnpkOE85dUxSNWNuakZoK1V1RWQ0bDViZUZMQ1ZMejVINzVJekU0?=
 =?utf-8?B?OE5qYXlBMS9TRzFZSzhnbk5aZzZ0SjlhMDl0ZDAyY3podFhtMVh0TExCODlG?=
 =?utf-8?B?a2dhelVmelVjT0E3dTRhMlBVS1pDUTE4QzJNMGtMNVowV0lPVVlCcVptZ21P?=
 =?utf-8?B?dDkxWmN0djFRMFozVUZQancycmxPRmtxa2ZxeDRNdUtUVURBUjRZVnNGcktR?=
 =?utf-8?B?bXY1Z1pnYVpuUEVteUR3TmZMMCtodEEzNU5rWlFWTERVbHh5T0gxN08xSlcw?=
 =?utf-8?B?YU9BRTR3R0R4Ny9VejYrc0l1QXJGcFByUFg5czFVRGhwUkNqdjliMDlIdXMr?=
 =?utf-8?B?S0p6cGRCMzd5aVhRYkNXMXBWaXNMbmxwOEJIUlVxVjJVdUV2NmgzaHFicnlI?=
 =?utf-8?B?VnZ3UHpBZVFJaW5kTzRMd0FReStJV2VLcnFta04yUFEzSUJkTWN4VHRveWhJ?=
 =?utf-8?B?UzA4dDhtcnErdTZGS3c2eG83OWs5eFIzTDlsWm1UMzNhMGVhMFp6V0FGbXQv?=
 =?utf-8?B?VklnWEZxTzRRVm41Uk4zazJ3eUJxMHk3U2RGUFBiSElaQVJhWUxleVJUTjZl?=
 =?utf-8?B?UDR6cVpYTUJQVlhObGNPUzBCcit3Q2FiTENTUEtPZ3R0T2NtbmZ0WHBNeEti?=
 =?utf-8?B?RXVROUdCWlJRam9LTUlGL0VycW05R1pKL2ZhVjR0dFhJTE9HQVBSU3NNNTYw?=
 =?utf-8?B?cnBnc05nYWVJbzhDMFgva3pFSGRlVGdDM0Z2V3VpeWtHcW5zN0U1bW5tMW44?=
 =?utf-8?B?Y1ZNRllzazRKNGQrbjEwTFNqOUN2NHhVTjBqVUdXRFpKU0VuKzFmOEZQRWxZ?=
 =?utf-8?B?ZnhrbVBDRE44aXI3NjI5NWVINzhBaDZ4cGJVZEM4ZWo0S1dVa3NYVmExNWxx?=
 =?utf-8?B?c3p1OTVVQkpzdHd4ODRPaVVWdUxSREduK0tKTFdKUVBiZnZOSTZFQ1p4MUZo?=
 =?utf-8?B?VXYrWUZvOFliSEtwRkR3WnVDdlFjcjRhQlkyWkxkOUxCZkk5blE0UnZOcHYv?=
 =?utf-8?B?eWp2RDV4SkVXT1ZiYnd4QXZTK2tueWxacStrK3dWQXVhYkpRbEliY1V2MGlk?=
 =?utf-8?B?WjdvM3E0QUk1L3NJbklhUElucU83Q3ZaUjIrUlhxWjBwb0FPMGk1VFFXTE9Y?=
 =?utf-8?B?SDlCeTZxL2RWbWdkZExxRDEydWZ4dWp3UVlhWUNVZHNwOE5WbDRwaXpHV0Z2?=
 =?utf-8?B?djZuc21OT283ZldNeGVGSFlTbFVta0U1d1QvQ0VaMHN2a1liamRLVkhUV212?=
 =?utf-8?B?S2hHbGZVRnBjTWJxWEZQSHprbmM3QUszNHBKWE1ieFdsOFF0dC9RMDVjNkMx?=
 =?utf-8?B?a0ZBTk5rU0x2djE0WjdnbHhDTzh6Q1pGcHhCOTFUaUh4RzVySy9ZaG01a1Nm?=
 =?utf-8?B?MWYzRjJpcitSSXhpS1N6MDlLRDJvdmpMeDBZRFN2ZVlFQTNRVjJHZVBQUkND?=
 =?utf-8?B?d3ZnazdOL2syRlhLb0I1QUxrMjliWEY1YTJKTXBQK3VwdnVFKzJsZUFRNHhz?=
 =?utf-8?B?T1dSK1VxbjNEczBxSjhlM0grTGtUemwwLzZ1Y3h0NUxwdVlTMGFOYk1UcGpk?=
 =?utf-8?B?NmdPYnRrUXhrL1dBc3pSTHA5blRtZVg4NjdoSElqVXJzajlXQVhEMlVJQ1Ri?=
 =?utf-8?B?dTFTTEQwci9hMFZOcjYvM1NDRFdiampCekNQY1hQVkZEWkxlOHRLNW8veHJD?=
 =?utf-8?B?dDNycUxiL2VzMk16bEcvV0xCeWl4QUFVN3dYOGEvbGdGaHdVeUs4MlhaZ2ZQ?=
 =?utf-8?B?T2dsR0hzTFR3T3VlZm5tZCthVTJXZUtoelByTGdIR045amhYQzVhakJvQWFk?=
 =?utf-8?Q?jl7lHYrUtzPwgnWt1EhQIPVaXf6vtxGQscNv1vLKDz7y4?=
X-MS-Exchange-AntiSpam-MessageData-1: OBtVQTohSKHj3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6408696-360d-4677-7490-08de938448f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 02:29:10.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVht1aPtBS2BxTsXBRjzp4HBpRSnqmZ0DjinWeVa4mgj2UHajbaA78oC3NWQgx7/b6FGjyTLlu/XgdoG1VNTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

On Mon Apr 6, 2026 at 4:48 AM JST, John Hubbard wrote:
> On 3/25/26 5:13 AM, Eliot Courtney wrote:
>> Add the infrastructure for sending RM control RPCs. This is needed e.g.
>> for channel allocation.
>>=20
>> This series adds:
>> - `NV_STATUS` bindings and wrapping `NvStatus` enum (used by RM control
>>    RPCs)
>> - The necessary bindings for the RM control RPCs.
>> - `RmControlMsgFunction` to identify individual control commands, like
>>    `MsgFunction` for GSP commands.
>> - `SBufferIter::read_to_vec` (using KVVec) for reading large RPC payload=
s
>> - A typed `RmControl` command that can send RM control commands.
>> - One usage of `RmControl`: the `FaultMethodBufferSize`
>>    RPC. This is useful for channel allocation later.
>>=20
>> Each new RM control command can be added by extending
>> `RmControlMsgFunction`, adding the bindings and wrappers for their
>> parameters, and writing a type-safe wrapper to send and receive the
>> reply for the RM control rpc, using `RmControl`.
>>=20
>> This series applies on latest drm-rust-next with the listed
>> pre-requisites.
>
> Hi Eliot,
>
> Nice clean series, I appreciate the work that went into making
> it easily reviewable!
>
>
> thanks,

Thanks a lot John, and thanks for the reviews.
