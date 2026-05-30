Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AEECD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E0B112718;
	Sat, 30 May 2026 05:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyGFlOXt";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65951112718
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 05:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go9S8TikN8pS5SrgudLfI4u8OKzeGYEyGdAkVoIvK3RUuWfbcQWE6TIceBlxKqZAEXUzuL1OPWAUK94NY+rEMgRsnu2a/dK7H9uVUakVBCmVh7XD4a4rpTO2pxmzpZM8NUVjpEi1vCvLQ4ADMzeweUcM/1o85h/2gIlc3FjqHEhw+5OaHSXNtyob2g9deXKay7o+Ds7hkjMVAW8dnWamyvsf75herR8hBo/+9Dv2K4n1LLog8N/yns1Okp7TFDcctU9vqzCvDieKlRi4kg550sikH+mt5NHZX2k80tCZwuYrEg76XgFDcKtdNA86nDmq4d1eVK9OyMyAUvljmxcS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvsUHZoSFLmMPz7eJkKMQpQNML4MiJ0C4p/IbdN4QkM=;
 b=vF2XxGcu7IK1VcQJkYvJcLmZTp8UgEeEcPLJ4kWSfMoD+csO7R81wdDAKsBqofYTkqGcOc/DIz3aBZ2i5ALSRVilyq293q5pLdsA0EYs8DMkdqYHabf0XaB9B8Vd0ztEKFmE2jkZE1Jj+Ixwh4mhR1DUFu3xukvR/fuAI2AnEgR3wdDEH4FfOIP1nKtsO3st9fi32gA7fzolORQMhVVM710UVVnCpNfdtvVTRmIUB9SvDEmO8dmVcrOTicpYw+SgyWrCzN1vb0pVVnekxNWv/FMjk94JQe0Gn2lA2s/uSuWvKWngsotZgaGMZPCe8ZqKx5LJqfVhvWpviFfcSNeXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvsUHZoSFLmMPz7eJkKMQpQNML4MiJ0C4p/IbdN4QkM=;
 b=WyGFlOXtFH7aUNc75Lh9zoMC1Ccm+FbboNWPRyYlCdZyrnOfPiw+dbxDUWyExoAjevoWYl28vF/Tdm8AGrXQE2KKCdnKZCVFGGqZAuMSXbc1qihL9SdetWnNpcSESHpLcPe1Vr1rcP2oZHeyJVrbXetwF6/kS5M1vXWPM1+Gel/roe4VtKB7qs81ywmJgD5jDKrYykQjZp4aIJu35Sfe7e9iaNEPCpHR6w08ksh4LM92n5N9DAktMr0YBIzCdXGdsACewvFu6kwyGTEpjbiCDZyC+JFqz0mzMBRv2AeO4QpeCYdx4CHrcabH5KMr59Z7N4F17c+3MWWHKusPyDEQfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sat, 30 May
 2026 05:55:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 05:55:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 14:55:20 +0900
Message-Id: <DIVS25D4TZQS.10FHBKSEU4SPF@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v7 0/4] gpu: nova-core: run unload sequence upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d770ad-0a50-4913-21a0-08debe100ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fp92J33v84J7hnrWWvU+lORmGUHqTyMfXByP9tJ4gShLXb7YD3Bydidjd3CmqYOlhbVrDMruvwTmaUdGG9y4HeSDo/8izWZPUW7CIqfolRbfzx/ZbfC0T3bH7Ud3UNo3a06jj5Y2EQma5TZlEAtTk7Rs0N9sQ6vhjdZl/JzqiFsZS5ntc7b9GTnkm0RWWIgs3rl0yVdo4CAEQKHJg2QApXieUskZhMrXJSxjt+amdhhrXtcWXDVC9tpfZK+uswfk5W4VdQEmXPFlZBM8LXp/3QIHfwWzEklcFNwMGLjvMlRRPcIZ5aADZaph67mT715ZnRi5eRkw4qzW/RjsRYLqk4gzDZqAFKL3924ZYWAzT2pINBZpkpNg/ZFUqAo4+0jEUdMA6NEXaSlUz2FHFt/zfZaN0dV86V741UORC18SY8I7xzFxx3SJOrlY8+mLAPtnU33pkrSyFO9Ir/zIIlkqdVlD5b02IZp+5MUUoK2I2zRMWdXTc4doy0Ig0dk2AIVbDY+Q2Mh/3c3/7hb45Z8A32D68cezrcfbQ1Sr50W3yL3VM22pEqAOavwz3Ouh59FynYrBZZ+pHKRBv+bRxatYgfsye4n6EunulcC69Ti1H8RPQY9YSq+x7aU/Dqs8BDvJv1ioih/OoSGsfzerV38vkIbdG48cgVyak4mbPITvYtkRORAoKegeHn02gYFHQrmVFzNBYBbEMBbWz40w/NsOIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTgwY205UDlUTkZndzhQMVkrQXlmT0VCMk1aVCt1MDM0MU51MTh5MTZSK3ND?=
 =?utf-8?B?RDNlZGQvUy9oWEQ4UVZkT1RmeUNRQnJiOWRqVEw2YUcxK3lLYlR4MHoyK0R2?=
 =?utf-8?B?OHpqT2pPYlYxTE5MbjV1Q0lPcThVL2NRdEtUYkcwaE9vbHlMMFVma0F5TllL?=
 =?utf-8?B?UGRSSG9KMTJuL0FnYitSSzlQYjNHWlhpaUxQN08yOVJ6bnZjd1BEYnROWmor?=
 =?utf-8?B?ZU05MGtHTUt0d3c5em0ycGhHOWVmZzJpcUVQYys2b2lJOXBpOHprRlhRYkZO?=
 =?utf-8?B?ZmJ1dEdzdHoyYzJwTXVtN1FEdVE5WEl2RTcxcm1PYldpdHZNQVh2eFkyTlc0?=
 =?utf-8?B?b3doWmJsb1F0UlNBYTlsenFhR0Q4UFg4dHVTSG4wQ3B5UTJWS2Z5UXgxTGtq?=
 =?utf-8?B?eXIwSUx6YnhmZDhuV21jcmoreHRUbTNYQnhqZGRZbHFQVVhZUzVpbFJodlYr?=
 =?utf-8?B?dEQ1UVgrUWZad2crMDYzWXdZL1JLdU50c1lnckRLVG1TcGtnOGdNQWltemdE?=
 =?utf-8?B?OExUeDZGeVo5Sy8yWkNMSmhVbFNNdmFzQ2FXKzY1MGF0SlJadWUrSGF6V2k4?=
 =?utf-8?B?ZHIvTnJQcHFrNmI0L3kvRUF1bEt4R2hjc0RLWjhuWnRqcGRQWVpnWld2QVRk?=
 =?utf-8?B?clY2MkdhVDQ2TzVXQTNYRW84MWxiYlkxVHVlR1czQmtXb1E0QmdBMDZLekJQ?=
 =?utf-8?B?OTV4ZEZaVnBwVkVvMk1YZVNCRUpSTkZabDBIZnkwY1ZDRjd1My9yRjRZZG8r?=
 =?utf-8?B?OHp5dnRQckxSSmh0c2JNb0l2WU1SeGJReE1ONU50U1FjeTd5cXpGeFRPT0ZK?=
 =?utf-8?B?K1ZFRFd3L0xKeStNUlhKaldxUCttTFN5K09ZY1ZnTXowMUZzYnFPV3VaMVlj?=
 =?utf-8?B?T01iSlZkRk50OHFybm0zeVM1MjloRnZ0dXk2VVA5NU1JVXBBWUtBWFFVVWs3?=
 =?utf-8?B?Nm80RUpBMmZnaWsrblh0S2dJT29SZnJLNWFzMGZtN2gxUEZ0Wm5MYkc2TEkr?=
 =?utf-8?B?Wi80WWxiZ2l4NXVyUUpLTk54TDZ2SkdLcGp6eXFEaVFDR2MrTnc1YlVmNVEy?=
 =?utf-8?B?a3psaEhucE82NTFib2h1U2Q5Q2NqUWtLQ1hJSXFwNWxyUDNpUTlZOFZ6aUdD?=
 =?utf-8?B?SVdCdHlzU3h6MXRpdzFhZHptUzFsZ3BsMWw1d2w2YU1sU3VYYWJMTlJoRnhp?=
 =?utf-8?B?SW9iNUJvditXZ1lEUW5SNzd0NUxJRkFxWVlQQVBNMkpUNTNMa2Q1Z1RvQldp?=
 =?utf-8?B?YVYwY1gwUi9wNTNWRDh6Sk5vMFAzbnVQTVB0eU1HZzFWdzMxaGdaeFc4KzJU?=
 =?utf-8?B?R3NzK0lJeDlNUjBlTTEvL1ZjdllKdDR0bjF3eExpUEhmKzRQVjkxaGh3R2NI?=
 =?utf-8?B?ZWR4a0RoL1dIT2RoZFhQMlB2Y1NucHgrNHNUN1BiRnlzcUR0VzRXRmx1UW15?=
 =?utf-8?B?a2NScmg1WFpUUFNaRG8wcndrOUxsSEV4WVBvaDQyamtlNWVXZEpFVUhqSS9G?=
 =?utf-8?B?c3cyYy9wZkJVZHRMNkhJZU83NExvRHpEQ1hNUzBVaVFxQjFtay9Zcmt1N3lq?=
 =?utf-8?B?TUJMOTBVR05EYXhPeEc0dCtBdVJGYm5uZVdrRmN3dTBDRW1DTFRrOTAreTIy?=
 =?utf-8?B?Rk8zSzhYSnBRWjBRVDYrWWw0Mmc1NnlqSnRVU2hUa2dGMVp2cXBTdi9JOG8z?=
 =?utf-8?B?NE5BVmNESjdzeHNLYXRtTVZQcG84RENoNEQwRzhUQXVOdGsyK1ljangrOFJQ?=
 =?utf-8?B?UzBjdmxKZmFidFlURFpuMXZ6NVgzV09jcEJzQWpiSzYvSDRFWGREMlBQWUpw?=
 =?utf-8?B?c0p0Z1N4NUQ0K1U2bXFWeElnbVE5UGFqMlFlUVIwdExuTzdnU0tuRG9tLzdY?=
 =?utf-8?B?TUZBNWJaYSszclRjM1NUQlNmWE9LS1lpRTlESnlzTGRFb2w4TlJTTFBoZGJu?=
 =?utf-8?B?WjlTWmVUS29DaEVBdFVKQnVibnUzNTlvVTVwMGJOTW9URm9BUVdSYUNZaDBI?=
 =?utf-8?B?ZzVVTkE5UDlvM0FqQ0pqRTNKNzdXSmxOL0hkMGROZkdlVm9ObXRMeWFobWpW?=
 =?utf-8?B?cklpQytxTUdIZVhRbUVYcnNvd1hjWDF3T0cvWTVxaUdpek0yL3paRFhubDE2?=
 =?utf-8?B?SmpkWVB6dHJaemhyQWJBdEZZTDREbzYwQW1BV0pnc054WkJxa2IwUkFuWUU2?=
 =?utf-8?B?cHQ2QnZ1UEN3UjU5YlFxMFlEelQwb012dCs4RzRWbTR3Vm9VRXk5ZS9DclI3?=
 =?utf-8?B?V0tUU2RwRXErUTJuY0VXZlByVHNFTGZLdTZxcFVISHZRVlFma2JXRVRibjkx?=
 =?utf-8?B?ckFKZzdSVUxMZWpPNDdvbEc0cFdFRUpVZ1hmaUpWS0Nzc2NWbE41enJwS1d2?=
 =?utf-8?Q?181FO27z9C+UmcItGg79RnhflpTwEeqRQbgUg/LyQdWv9?=
X-MS-Exchange-AntiSpam-MessageData-1: QEesZLT07mmu7g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d770ad-0a50-4913-21a0-08debe100ac6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 05:55:24.5682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqiHpa8rq/XsYjiaOtqGybjoVQiZi96x47LwOatH2tK3fBoBmh1od4Ko4nfCax6f1EM9msa/JmHHGPIn3x7iBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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

On Fri May 29, 2026 at 4:33 PM JST, Alexandre Courbot wrote:
>       gpu: nova-core: gsp: move chipset-specific parts of the boot proces=
s into a HAL
>       gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unload=
ing
>       gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
>       gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails

All pushed to drm-rust-next (after s/Result<()>/Result)! Thanks for the
reviews.
