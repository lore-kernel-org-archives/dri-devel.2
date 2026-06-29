Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7B9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD18D10E050;
	Mon, 29 Jun 2026 13:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eq1fZ+Xr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EBA10E050
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3qOcA6b70osO/fUDmSvNYDiNU+mo/vG5cw//QcuWeaB1Pi8YLedIW+Xg9cog/6mXPoBAc23wDHZyXLo7k8w4QaqNaLJBAZpvN73wGxxU59cJz2aS4Hrn+QO0GaY2/ScfpKoI9PVxt3pRrwrKRSw55grG6laWrwZPKyhyHqPg09v2aziijomhrd8T9m8PFs3D99NKpr9IPf+oByAE6mwaJ6rzPHl865FRWc7ZSO66kxGHtCkeZ6I02+4PskFoq/xNzUplOLY2fgh/OjKHon6WiJHj6/pduZ/MIAB1Ql2aflJajaa330P9sQk2ltioy97HqWNpS13CJw9xcyWR1RVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TQlgV0R06Xbv0dZxV4JGdC2mBpSMoIZ/kuCEsOlKx4=;
 b=O7Sb4/oSuICZ7EqYZP7cJhsjWSoYGAnSXaSaq++HFKSIfre6Uo2ryvb4lDzJ764bXH9OHhXiNEg9Q1mvjevQX9Q180hsfICyOZRi3MBuBw4Ow6vcle9dZwtA88s7XIxIcxzDVtYpboZIYA6z2Qsw9tjN1/q7n3ZNgO0B4z/ft9xqrGme2w33/qwG4RORqwwxcJgter6yLZXAlyqXmgbbvbCJ+ENrI5MQhejLbdGBAI45CdN1LMz0roin1vTBBqpTyr66Im6yMjZTWulrwblRmp/hheRasD44wldULzccAuE5HxJuEr8zM23qFlTjrh3KfU+h4dSyBNaYOSnJuK0cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TQlgV0R06Xbv0dZxV4JGdC2mBpSMoIZ/kuCEsOlKx4=;
 b=Eq1fZ+Xr3kZB+Dy7W7ja8G1jDv5XlMX+cnIpvqNIyMEKyDSs5QT36A2NplSvQi/PNz3YHuISdJHYSWcLs+LHSedaNi2G4NYxs2d8AS+ck7cZHwRTw8YR3ihPU4uEjVD9Zo65Trb75AZaRohKByJWeue34wh3jQz9dReoN93YzkKtfE1/GJhyVAf4Y9kWn/2I3bD9hbdT2BdM2cbKcLojx2goA3a1dimbKjfIiM5kUKEPbS58il9BjA7/dWh1Wv3NlFdlQunCKzO7FZDvFduQM4oszH6VdRFyasZ1daxHBZ12ZHapgYQcm8Lcripo7wnsedlLzFm1FDZ5v9/KnUdgUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 13:00:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:00:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 22:00:19 +0900
Message-Id: <DJLJVW1OUBZ1.2X2T2M2SU8BOI@nvidia.com>
Cc: "Tim Kovalenko" <tim.kovalenko@proton.me>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: falcon: store bar and dev in falcon
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260625-drm-bar-refactor-v2-1-9db6b890d92e@proton.me>
 <DJLIEZJL9ZS6.J2642U4G4CT4@nvidia.com>
 <a9f1b6a5-ccf5-4bb1-96a8-54a3ed8f3f81@kernel.org>
In-Reply-To: <a9f1b6a5-ccf5-4bb1-96a8-54a3ed8f3f81@kernel.org>
X-ClientProxiedBy: OS7PR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:604:24d::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a770e54-cdf9-47fe-d6c3-08ded5de61ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6ZgdL0u6oChxHLLAHSbPNmn+c2/S5eXbTiLJpRqAmJH7nqRAAIbgNoQXO3BSr+p5e7GRYMqcZOsmmUhcs1HtpT74glfx7gfRwAfP/UEdObB5D/vMR1DGLcIGNbHcAVjt/DfFQsG/APJr440c4BXEvZuTeGV6MaJv6Ok3O5HjfNQyWENm8RyrT2+EtNfgoAVlXIWpHZ55H9Kw59sKpNbVfYi9lY4Y3y3bHbJEf0mp4AvH4udVTvmUDKeAGLXpfFoAoZtSJv9fRD90/sABlmePAhvYymO5OzHRv3M4VtbraywvW60gWz6IRI094Jmcnumpzye2CFRIWYPo4VpyzY4QCWyYb3RWnvYfu9qiZTrOskCiW9k6Ty8B0ag2+bpmR5fp9ngVLNQp4W1Qd0xsGyPFkil/tbiZXW9goXCJUrbS/V1fTXcxx8fiIys39bjL/7tHMlEm0bAOG3cXpSPINKdZhbrKW+ki1Szm7WkoZE74uC6pDZ25lVKZEAgYYUjb0XN5pBBtAn8W7IEDxQN873rZwBJ0JgM2mt3KoMKwzOqggIZ/wI9tLbgWo8O7kudVshxeKLrtdLytQTE8GX9RA6FJCaJRlK7MCkmEHDic2JaC0n2DhaDH0ZPD9d+yQYF0gvMtpX85WDpAIbE+0EemU/SvM4FyGz5mn74kCX8to383VQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVHdzFJY1VWcFFsSDJHNUFpV0d6SGxJK0JyVmJNUWVDN1k3MUY2NEN6bXlD?=
 =?utf-8?B?OWFEbFpwK2NKUklUWU50ZGdmS3pTSksxU2RtK1krVWRIRUppUXFSNGprUGtv?=
 =?utf-8?B?ejVLd3ZzQzJtQldNclZGajk5eUNzeGcvazlXVlB2bWZENERBeU9mQi9pdVEz?=
 =?utf-8?B?NDZ4ZGhsZHFDcGQrTGpHQVF5a0IwVlVOUGFnUzlZMUlKU25Gc2J5NlNKK1lS?=
 =?utf-8?B?bjR4YUdaajlwTU5CdFV1MFByRFJRRm8zTjZpQWJGYXBXbGZDeU5hVlltRElO?=
 =?utf-8?B?c3pOK2NxSWlTYzdySUF1Q0JKWFJTZ0tQWnM2MUQ2UXJCVWVYMDM3SmJFUHEz?=
 =?utf-8?B?U2tnREoydDZTMTF0UlhHd2Z0RGx6d0JhV2lzV05aandCdFdydVFuY3JWbHc5?=
 =?utf-8?B?SXJ5WFJQekU1OVp1Ym9QQTA0UVE1N0dlcG12dTcwZDdjb0lJVjM5SW9nTmMx?=
 =?utf-8?B?bytTaUYwNm83RzFJMUo4dXJHWkZxRmlwbVUwZkFuampHeDcwK09RRzdDZzNH?=
 =?utf-8?B?bjB6ZDRJdnBGLy8wS21oemZpdWxUb2lCTWY1aVV2NEVVa3QrMHc3WHdzTzA5?=
 =?utf-8?B?dlJuMGEzQXpRWFRVTG5NY0FsMVEvcm9pRHNvakxUZkpFR3J6cWJicms3YVRu?=
 =?utf-8?B?ZHA4bXR4cFY4dkdZQ2c4dGFXWU9WeFZHYk5adnF6QVR5R1M0Y3JBTUNiVFI3?=
 =?utf-8?B?bUhSZFE1RVY2c3BjWjlOTnVsMXhGQXpOUlRrdm5zVzM0anp4a0RFQis2NDM5?=
 =?utf-8?B?ZzFiVmlORGR3Um9DUXNLeUJ2YnBIekczWnhYcVMzbW5UUUxpbkswZGZRZDBV?=
 =?utf-8?B?K2VKNEQraW1ucDdwWWJuOFgxU3phVnRhSUJML3NjTGp4WkZFWU0zV25jcnlQ?=
 =?utf-8?B?T1pBSlk0MUI3SDFoSlNIUUIvRld6WFN0QWNzUFBhVWo0dkhCMnFMbXU3NmxP?=
 =?utf-8?B?TnBDM3BaVy9aSVorT2ZSSTNPSWREMGZrZDV0RGQxNWVnTzNwZngwUk9FTTZT?=
 =?utf-8?B?YWJ5NWtRYWh1QllGdHlJWmRLYUd0WDNnL3NGM1dlemM0clpyaXlmNlVLTkdF?=
 =?utf-8?B?a3I5WW1qYjltellQNkcvNmNmUkdscTQrb1Iwck1TSkI5UlVTM1A4Y0w0K1pZ?=
 =?utf-8?B?aWEyZEo1UE15eENrRExXbTNYTjFyQU9oNExjYkNlRzRzalJkdjViNlFETmVG?=
 =?utf-8?B?S0JzcjNUQ3BVWnRJamdGNGxIb1BuS3AwS2tEYXNNSTAwNHNCN1pCTFN0MHJl?=
 =?utf-8?B?elJnZ3llMFlkSTdkTzdqbUNCNHJZVU8zakl5bnIxVDV0UU1Jb0xHbHVjdktV?=
 =?utf-8?B?L0phQnBMRWlKbUVXUkZEN2Zrdm1UYnFiaEJiNEh0cWFCdktoUnFXa05hOER3?=
 =?utf-8?B?Zm13R3FwSll1UWUwcDdxak5ZeWo3QTJzZitUTHJNZFNQaktvSSt3U0pnRGZ3?=
 =?utf-8?B?WFAyeUxaM25xcDhDNFgwbUFCVWp0MG01aGlQakh5WGZUQXRtMk1kODFwQ2FW?=
 =?utf-8?B?K2M0TlE1eU4ybExVRThFNm9xTjI4K2FucEcwWmhQMWFqTlp0N0RNVVJHUUgz?=
 =?utf-8?B?VHdGMlhXdTd1cmJta3UzWTFLVVVFS2IwZnhJTnBzeEhxR0hoWkpRWVdjN3Rj?=
 =?utf-8?B?K1dRWGdOVVhCMlp5YU9UMGt6NzRHdUZ5RFZrNEZGZ3JrTGRtbUlJSThzZVJm?=
 =?utf-8?B?OGNFVldweCtkdTNCSFFiZ1JBdnBnSkt0eWQ1ZDBVVXpVOFlkWGFuRjFXaG95?=
 =?utf-8?B?U3NBKzFJQkJtNjdnaVB6VE84RS84by9kTnJVdy9IL0hBMVJhQUdsVEdrYmU5?=
 =?utf-8?B?STNRcUcwUVF3MVRBdDdaMVR4RkZjeERtUXlkSFBTN1Z3N2pyTmhSbEJ1UnpL?=
 =?utf-8?B?S2JjdWs0N2srcEp3VHRWOS93MmUzWmxuYll5VldUVzhtNFEzeGZRTEFWSWhW?=
 =?utf-8?B?U1FCTXV3MHlFdUV3VW1DUTlET2hsT2NMNEFTaUJLQnBRdzJKWFFMYXZwL3dM?=
 =?utf-8?B?MTFjY0FHL1lWemducys3ckpiVlo4bVFHdWJZUm9JekNod1FjRml4RkVXc1dH?=
 =?utf-8?B?R3BreGlKT3BpTW05bnhNNElkWjBmc3g0TzNCMTlWVXNtaTBBUXZEdStSeXJU?=
 =?utf-8?B?eXFMM0kvYURSQy81RnVKSXZxcEIzbUhJOWdRengyR0tnemhOeUlyMWZuK1N6?=
 =?utf-8?B?K2FucTJrTGFwRERJQW1MNU9TSjFyOFQ2VlFNVFIyeEZSeEFpK2NFQ1pnWWMy?=
 =?utf-8?B?NVQwYUhBeUIvc3htVnFuak9ERkhSMk9rY1hHZnNkZ0RZRm9zSlBBbEZxeGcr?=
 =?utf-8?B?L21tTk9mblQvNXFoNEVCdkVXamE2bkxrKzhnSkl1SkxFMm9FbHFjOTV5Tzgv?=
 =?utf-8?Q?hS56s8KeDzIEakfvMzyLSTUOI8iZ5VlMagbXxicjsgB5R?=
X-MS-Exchange-AntiSpam-MessageData-1: yNDPNS2xS3SSIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a770e54-cdf9-47fe-d6c3-08ded5de61ca
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:00:23.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOtHQbic9H8S1ebM2Nj6PMDpzerjXO9P7nw0L6Z8Iy863G9baApMIoeZ/FFRDTUTMPfuneXm5s0TnmAyizt6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

On Mon Jun 29, 2026 at 8:53 PM JST, Danilo Krummrich wrote:
> On 6/29/26 1:51 PM, Alexandre Courbot wrote:
>> Danilo, any objection?
>
> Please do,
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> Thanks!

Pushed to drm-rust-next! Thanks everyone.
