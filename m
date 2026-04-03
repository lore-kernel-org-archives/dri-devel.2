Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F25CE88D6E
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E8C10E138;
	Fri,  3 Apr 2026 23:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRPDOZi9";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC15D10E138
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 23:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teVdGknJXep/ZvM6JDJiwH+7y+20u2dlEf6ceSaJNCYZHJwFNAWGOy0dymbQG9X1rw84i7qXuhp5ggPhaZt7x9bJemamKyBxwjdTY/tv9nCRd9ZJKF/ekVLrZO9/koGg6bRPR58Br2IC9iz22zmfSFtW7E0CLe0VbwKta+8APZBvYa6OVVFLL4dOzKY6DqyIvEvUS1LmoGI/b9GnpEBcPYvKzkdIAf7mfV5P7tqbaLeXgJRBQ/B58d1XFsAIbXYrxRCZ1qveD2ay6EtkxHZzROSibNvg8UzVdjn5Kgm78g4DdNhkwTRJ5VJKj0Omf0zsZ7LM9Ey0wFnBEKnfkJgY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBXOHo7K8CY7i5KSMvdZlZBgsEkPBJOlOimN0jv8KEs=;
 b=Er5eVV8BwGKljjUO1Tvt5fK1g1eBOxDagJtVFpLCoWM4NqSyo1TLdj+AM8v16q4DPtxLNhJWuiT/cvSUwvOerTf3ey8NFqjsBErkAgmTmOCTo5+sV3Yt323C9XNrHGuJBuefEwypMXEZAxjUQeayZQ2+q9kpubk1aYt9QqFNoLiHdlywdQ0Qugkb4Xp/Sucw2TPBLjxwWzSEiXkE/JNkR81ehnPp95hsLJQML5Y7m0AsXCSl6nfKRFNP1gKLBoymCWsgK6gPhxrtsScQNjNvimt7m0bEkFF3muJOTeXJykZm+BXh7N7raqTDBSNmqK0WJlK1t/yNB95XaLpNibD01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBXOHo7K8CY7i5KSMvdZlZBgsEkPBJOlOimN0jv8KEs=;
 b=XRPDOZi9Tvx1v87GoZrOloJ77GHHo9G+TLSOGNaUMbeE3xpg5AVCEUofIHegcsYy1TSxsfO4SIfzQdzWxl4brdNBv9aJb2c+ZqFsEkE1jSH7nQqppoXLWZhnLd+rz+KdfSYKYnc0eH6iw0lJ4wDJ6ngy42RKQ85FZaUyCY4r5YthOvffmEsE6+5iPLn+AcfdoTx+LpIIUuanPN5uRrQvr6nhVVIpBVGtteZPcDp3TPrC4tBsTgWEN4dV+Sd7okBbZfa62/FYFLza08iW7ZtlPaClxD1ndrYdcXdw/KcPgyZZhZYlwSLp1TgQxG1lWU3/I1eImj8BuAp37naA9lkvHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 23:47:31 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Fri, 3 Apr 2026
 23:47:31 +0000
Message-ID: <11466450-aeb3-48d3-a86f-934346fd4172@nvidia.com>
Date: Fri, 3 Apr 2026 16:47:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
 <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 77272144-07e0-4490-1650-08de91db5ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5jl8fWg0SRss7WIS4bdUovY4e6k3fFAT8z97bjh9FNNmJt+GejaW2IpCiOn0fjvihdNZr/U12oJUqObQIk8EUNVr76iQk021uLA6cDFKxn/3Dj7DrjskgspC9ZUbtdGwbDkP42Q+ZKJdvZAPRuFE1dXz+5qI0hvaqX+KcTjgK6E+LjpYbKYUv55KPqkVywwQ65daE1K9cFakegyipxc1a7g3Yx7nKzw+w3QtOPXDKol87WDXv61KQFMf36wQKpfK3bKjQWWh2SmbAoBIzcqXth7IJuoWFguzrRqFgC5ABCKfRsdj3BKFTbXjbS2XpafmteWMAioZK9XLA9rD/vuR3qWwxncIqACuIoeQFQfs12npognhIwTKr0INJ+IykFQi9isOypIkwod+D3I3cW7CvnRZprDMl6to3SFHiRq66Le1Z+W4bf3D83DsHi6Q7M0xbv80vor4Tcp2hb+szpzIL6i81O61Qc7IiLmF2WHnjaX7HcR+E9JxTeoVx3/Ls0VeXYnu3Xb7ZgVqGRMribtWDOOqlZw75s+R/w3Ny/KF1YS2PmXLK2rCGZ8MdfwDsN1d6TRMPKa6E9lGe1Ve9ku8VIwONOLf7O5tMIpLCg0QeO1rSi4ff8uymt8hM0/2+ujUMyFNsRM98Dowe1fBboTcLLcA0OU1ojN9vNrP2efq4qOrXxmWaXLmz69oRMkRafDCEIB2AdFEOstgLhKzZhEn9uore20RaV19BmBLkzCDXfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5BNVhuOUdSMmV0cTZXRmdpVzd1NXdmUFpab2ErRk8wNXlnWHVDOFcrN3VS?=
 =?utf-8?B?eWFaK0lqdjZmMmhHam5JUEx5Z2hhSTRxRXgxeEJUQ2xobEp1UTY4bkExR0Z3?=
 =?utf-8?B?K0VyMEU3UHhuTStaUW5KYjB5YlRoOUhmallmUkJ5bnVnZmpteXI0SzdpaHdW?=
 =?utf-8?B?WjNVM2w2bFpYbm5HTmZIT0VoVHF0RUtSak1BbVVtcm9pTnJzOXRYbDNzY3Vt?=
 =?utf-8?B?UmZzZkM1dmpIL29KUWQvbHcyN29zeG1EQjZxblEvVnFRTGRuUzhlS3RFdmlt?=
 =?utf-8?B?WkRIMjdneHhWOVMvaFJaTjVyTkZKWXJic29YMlU2a09OWFp0UFI1U0VaNlY3?=
 =?utf-8?B?SWJZYjFoWVpIZzdZb3F4cEV2MDJ5MUJEUG1uMDA2NjhxR1RLSk5RSy9Fb3Y5?=
 =?utf-8?B?bm5hTHZQVFVmRXU3c21rYTFWVkIvUkxZUEg1dVJheHpkY1IzZlNrbG1iN2JH?=
 =?utf-8?B?QXM3SVYwaUlnd2Q5UmdlZ3Z0cG5zR0RFTjhZaFFVREc2NElla0YyNEhxVGF5?=
 =?utf-8?B?Y1ZKRzdtTGNacHJmSzdwTDdaMTIraU5DUHBIWkpwMklMR0Z3TnZvMWpLTkJS?=
 =?utf-8?B?VGNyL3k4U0JPTDJKR2xXWDVJOERKZit4NjNWVHdjaTZpeXRCYVhVdmU3dk1u?=
 =?utf-8?B?YXEvTHJ6Z2JTaGluTXZhdTc0MFZIYmg4SjVCaUxNT3E3YTJ5TnJnNjB1MU5U?=
 =?utf-8?B?Zi90d0Rha2x1SjMzN2VwdEdWNWN2V2VpaGZYMmt2SU1SY0x2bE9ETDJjRUk0?=
 =?utf-8?B?ZTEwVHl5SVJGNmZkMTYxU1JmQkFjUFgwa0UzbGRYOFJ1T1F3cHFEd2czMlJa?=
 =?utf-8?B?VkVyMDBCc2Q5NUFSVFE4dDBhNEhTUE1ZR1lxaHl5TFJLTGNLUE03aXpOOWd0?=
 =?utf-8?B?bEdydldTTlNVeHV4NnB2V0Q2b1lyampTT1lncFJaZnU0U3ZSUE0ybW9JY1pl?=
 =?utf-8?B?RGZ6THRQTllGK3ZEM21qQmZqaGZjRnFKM0NWbmpENFFYUnRpaDFrbzdmWkQx?=
 =?utf-8?B?ZW1GYmxKQzNUR2FTaEhPQnFtbm9kUFZKM1JKU1YxcDJKMGlPdFdOUzNzeGto?=
 =?utf-8?B?VUhxdVBZNG1ja3pydlAyM2tiVVBkV1d3Q0JTdFhHeTdvTVFGMlZ5dmRXTHZU?=
 =?utf-8?B?YTdaUTIxa3k3dDR3OWpMRXRqdlozL3RjS2VyOVpJeGZKT0Vnck5rTGxaem4x?=
 =?utf-8?B?VDdGeDB6Nlo2SGVRcG9DRzdzdWJMZXlVR0lNMkVzR2pIcloxWlB5WG1FbTZs?=
 =?utf-8?B?WnhkWjhQdnVQS1JXb3ptUnpya3BSbHNkUWJSZ2Y1aFhpUVV0cmJ5RDFjbDRJ?=
 =?utf-8?B?eTg4M2I1TzdEYXdqQmR4ayt6aXZ6ZTY2bTFmS0xFUTdralJkeXhQTTN6YWEr?=
 =?utf-8?B?dU45MlZmd0Z4SDhBMFZTNHMvUmdwWEZtOEdyOE03bmQxS0VEcFBVdzBDNEFE?=
 =?utf-8?B?c0xqQU1FcVNUWWp6bHU1TmNBc3RZSGwzTzcwbDJtT1FxZ01ReXdUMHlEeFVS?=
 =?utf-8?B?bDhjdGpISVN1bUZBNmg3Zm10YURHVFdJalBNYUlKOEx0Rm5JN0tqdnEyNGdH?=
 =?utf-8?B?TTRSbklmbmtucHJmajVYZG1JZmkySmtpNFJMeldIbU1LL0RMcUJPajVHbUwx?=
 =?utf-8?B?eHlRdUNaK2xTMzdsYk42eEVyVGY2ZGFBN0l1eGI0RU9TNGR4NVFjR01rbVkx?=
 =?utf-8?B?THhQRXoyYlhOZFRjQTZYdUlhenM5emZpM3pkbDFYT3d5OVd1NUIweU9IY0VC?=
 =?utf-8?B?N1ZjUytlcTZJcUNCRW83ajFNOE9HRXhEcnVFd1dNQlJEQ3NBamlJUi9NeCtX?=
 =?utf-8?B?a1lNMGcraC93aTBjYmczR090WVRNR2lhZ0NETkpFT1dUcTFzNElIMEVFclBV?=
 =?utf-8?B?M09KRzh0U3h4WjB6QXZwNFFzeEcyVEFLeE1sdTIrMjVwby9xY0RCZS84TGd2?=
 =?utf-8?B?MDBnLzI3TXNSSGxSTndhbTl5N3V4WXduelVNRFR4cm5kb2pseGNnak9WVzl6?=
 =?utf-8?B?UFIrNjBjMFhzY295UktEd1ZDQmhxRGN5Rkw0QzBSNHRqdys3ZmRrQjdsWHBN?=
 =?utf-8?B?ekMvTzRyaGJwTExVUWExQVAybE5ocnBrOGdKbWNTREdFcmVVK2F6UjVndXow?=
 =?utf-8?B?Q09JemdkTmJ5disrSllVclM4ZCtiamZQbWRoc0MyN2dVc0NETnN5NGt5V3ND?=
 =?utf-8?B?STJoVUpPVUVSWnBVZ3l0RnJCSGY5dFprQ2ZoamliZWRpRExTbWJVU0RaV3gr?=
 =?utf-8?B?UUk3ZVJFWXBxZm1wUmNISnBvV0F5SkEzcThGclFRaGVqMC9ZMmF2V1RFZUpw?=
 =?utf-8?B?MiswNTVVeTR5c1hXOC8wNTVsdmxIZ2ZpN2RnUjJsODZTQnRudFMrdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77272144-07e0-4490-1650-08de91db5ef1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 23:47:31.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cveHEV07HtBh4OWteDKuqn/rFTpPdDCAaOadwza+LX47SlRJDBM6Q5Otu5AffpyxK2e1wUus6dlmO2jhG4FZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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

On 4/1/26 7:29 AM, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read or write access, respectively.
> 
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them, even if never accessed, is undefined
> behavior.
> 
> Fix this by rewriting these methods to use pointer projections in order
> to create slices to valid regions only. It should eventually be replaced
> by `IoView` and `IoSlice` once they land.
> 
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++----------------
>  1 file changed, 65 insertions(+), 49 deletions(-)

This is causing a build_assert failure in the latest drm-rust-next, with
rustc 1.85.0, and also with 1.78.0.

rustc 1.93.0 does not show the problem.

I suggest that we revert this commit: we're very late in the cycle and
it appears to be relying on fragile compiler behavior (my best guess so
far--I don't yet understand the root cause).

thanks,
-- 
John Hubbard
