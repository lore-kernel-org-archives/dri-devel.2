Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C46C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54F010E76A;
	Mon, 28 Sep 2026 04:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7mGadCa";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A3510E76A;
 Mon, 28 Sep 2026 04:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfJZvXcNbcxK25lvJLpcb2EzlGXlfVVJwwectbERPhUhlC8jSIWfGRL8kg9ZgxWqpwH0AxzIiwpjBxfeAP1re+duymL+fwIFoNMyQGunUiiGDwVpPb9ZCwmkcPmSZS29BOrgkPTSEYV0DZQ8GlXFWwwVDwmzZ+t6AaCXt2kpZWxnPgWhm8zgdrkf8moIJCYlI5H0AXuI/4kfQF0lOyESIGqCuWaejIjrH+4eA1lqyxeTTJYWIsnz3dwMNl0SnXIAPYVCcZFI1sRCWB9jF+yRwjNRwbCgIAkYpB2bd8OhHmudg7T6qNSlVUSicjmW5MQaIClUfKJ3j7RyhfW3aHDMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpAst5mOaIup+w0Xc1yHmIMMNSBVh9UFbgm4MzNtiWU=;
 b=Yws+4dr8YB2GkyjCY2Yz+4lkkaWrroZUEzrqBeBUH5YtKgmDu2OKiizvhtEsQaHmHVHLBITp5rlZKzD57OktLjiZ604/MjhAzNsIM0EUp3Lh8ldBngeNcpVGKpTx1ymuKHITfF6VWGzQeQDlwja8jYyuJYb6zqZPOOx/gRY9/xDzPq2AXZqyWpR8uPAxp3Apqs15A48KXDKAynuQduVksYePYHOoc23f2zYzPt/2rtEauAANyMGu1U2vCrsAvnT+V1Tk16LioGlgg3CXgQNIsBhoTMbH4UUv2JEEiwebhiqTNjJZVqT8wHYkhpvKpbe7FMqv8DuxtWp4vTl3ENXVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpAst5mOaIup+w0Xc1yHmIMMNSBVh9UFbgm4MzNtiWU=;
 b=X7mGadCasLMZ51t3NS4D5a5bwlO7GzkjoiDRbfvrm6A6ZrAdeOZvrlMX8i66TTVJ6cwyUCRwsKXZmb+7f06Wg8uVZyTPMtSLOe6VY3LIiQhMkZieaIP9G/DiMoyn9wW0m0lRLXWAuXIYfo+RF7oU9BvBPjNup0sgwF2B7DdoRscRUqJmZJcGp7hD6QotfujnMM7pkop+A+ZY0qbqEvB2JazPygN6hFh6JFyeCt4xqP0rjhuSVDtH2ydU0FQSMBpj27sz42mw4ZlkJy9Ggju43zPrx2sLWwQSnfWPGvkBOkSsNOewY5BLq3jt/DZemOfRyjDhwrtng+v9DEHdT9aayw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:52:16 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:52:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:52:12 +0900
Message-Id: <DLQOHQMHZG6Q.1REHAKVLIIWEB@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/9] gpu: nova-core: gsp: cmdq: group the
 RPC-specific part of send_single_command
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-3-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-3-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 485385d3-cd0c-4898-3604-08df1d1c44e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|10070799003|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: SNE7pg67kW0tdwLKuFKuTpwNG9h3g9hYOUNYiVYfh4ZdgM9U/NLHuC2rXPH2FqyO+2iA1jMXBkSjCtXyL063x5gSZ+coJ/m3s4HolGLVYenvUyze06sBx3vBvpU5TyyEx9SemcmpHyjoOCLlKyjawMEQD+DR+bTQxVQkc5wQk5MtX+fHujznsYm6H/BjY8OKUANYhkkzGOhS/XNVIjs173VaKi2ZbSmjzgLP/0psmtjZ1y2L6rdjJR1k+kNrXcsHb2qXalV7IJH1gLycFrHLb6JYJkBPhzWS0eqW3ZuY7D4fXIh7jASqrtNolzmMIvMn4KJzkWwL0EDeZYDSfNBgV7A6bHqOVlQWEnF2HuPKqrLibXRCC5YhSISRnjuqp+J45Fulw7vuWmEaX9SlWu5tYxmYi1qZOl9UNIB0t3YBDO4psIi8UxYqD6WgcpYw29ypNrwS5dXlgTh5nuc4J1yj8w8IGuvEArFTp0Tvig/1L8a4SMxrqY0v88Zdg8fwn75p6vsytTF3GBDbHYvW6VsSjUHPQwkbcclQZ41QhYJhALXpTxyWU6/NbE5o8qfcVL7sTcvDcHjMi3GecIX/4r8fNioujTa92/3V4fo70l8XDxLyHAByuUs4VXJ25g8ylthtLUXT9PJmCO3wAMtlq7bhetnqjfjG7cy9nLvI+rndOHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10070799003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1M4Rm9NeFhtaWFSY05JRTRlcWVzN0RnM1Bxd0xpUG0rUUhFcnF5UjR5UU9K?=
 =?utf-8?B?TWtZczhKU3pHd1lObWZvakQzcTJUQ0dNbE5UYVJBb2l4WlhMWk5nSWJGK3Jx?=
 =?utf-8?B?ejdYN2lSUmY2U2thVDU3UXFFeGhJNWRFemEzSmxkeEtBZUR1Q2s1MlE5ZXIv?=
 =?utf-8?B?UHpyWTV1WUUvZkxZa3RUdDFGbVdxT3drQTdwRFExVmQ2eUZVVCt1dTFSZnhx?=
 =?utf-8?B?QU5aQzI4RGh5eEpjMXYyc1VzUWxPOEo5VzB5K1RKU2pPMkthZFlDWHh3RVpM?=
 =?utf-8?B?V2c4alo1ZFF5dnBWZ2l2UzE5aGtIYlQxZEFuS0tKcURhWDQ3a0E5VFluL1Nn?=
 =?utf-8?B?TkRUckE2cnNhWkZHKzFtckdJaGNvbGtEekxOR3VUdWkvL1BEK3M0Umc0Y0lo?=
 =?utf-8?B?K3RZalYxUVpkNlArd2kxOU53Rmc5bzFUOXZxcmNJZ0FGQlhrZG9iQi9BQWRv?=
 =?utf-8?B?VlQ4eHZWSDV5VVI0Yk1teStjbFpPNHpaSzRpSGdMbk1Ha0NxV2RFbkV1L0pM?=
 =?utf-8?B?eTBBOGFYVGpua2hjMVpWRHp5RXYyOVpaV1ZGSmd5UXZkUEYvZDEydjZKTE0w?=
 =?utf-8?B?OUkrZ1crZm9RNno5Z3RpVW9rUnpkc2tKVUZFakMxNUgySlQrUmxJenBmL2FN?=
 =?utf-8?B?R3FPaFFUajcxclNIN3dKTlpqYXRnMUJ3SnNaNHBsTFgxRzVxVGJWQXE0L0RZ?=
 =?utf-8?B?S0pOUjREeDR6SDlnaXdRK3gwZmUwQUt2N25iR05RNUlaV3k4bm9hdGUrRUU4?=
 =?utf-8?B?Qm9rSEliWVNWQWoxYmRKWkEwRHJlaDM4Y0JGY3JUZnBzcngvYTcxaTNWUG1W?=
 =?utf-8?B?WGxvQUZlMTY3WkNIaW8rdUs3cXdGc2pybldOVUtLbU1BcWlOVUcwMmR0cTgw?=
 =?utf-8?B?cktkVG1uaG9hNVZuTmdNNkJISGRrOWxTSC8wc2g0VEVQQzV1WkpXYks1Zit0?=
 =?utf-8?B?TndDZmFrUDNaVkltWU5ZOWhHbThPMVN3b3Z6a1UveHhudVVQTU9EMXc4R0dX?=
 =?utf-8?B?Y1hsajhjcUx6V2RQUVdWUCs4YjNkTHEvRkd6bVhlUCs1NnNUZWFhUWJDdW8r?=
 =?utf-8?B?dDZBdHpSR0ZKdUhaaTJkKzNiUWhZcDhDdVFkRHo5TUJncGVJaXV3Y1E1ZnFH?=
 =?utf-8?B?QTdCZGlRUGVkbUM0MklSMTBQYVR5N1J3NkdZM1FVdVFwaWk2OTlLcXUzc0ZJ?=
 =?utf-8?B?a3EyTjZEZWNJdFF2MkFJbGlqZjNvUGRGQ3VTN3FBWmhlaHIwR3p1WC8wbjhy?=
 =?utf-8?B?cFJmRURxMUZydm5GUmhVZXR5ZlMzWlVHWHF6aFNRVmwwcHFGUXBidnFOTWF5?=
 =?utf-8?B?RGNHc2pjWUxpOUdoV2E1c2NNcjd1UlBSZmVCbUllV1JDMzBkSnFmK2J3WjRj?=
 =?utf-8?B?eG10STZRRlBvdVMrZmJpakNjZXlUUlVBcGhHYUJFNU1BOEJIVEY1ck5BK0tO?=
 =?utf-8?B?czNXSnFFU2ZYcmF4d0lKZmZsakU2bHlrbTlTV0RoelVsQnkyajVJVUJqRjJr?=
 =?utf-8?B?TndEVzY2cDk2S3Rhd2l0MllZQ3ZKOEp1alMzWDNNUVd6akpicmlCaHpvWnFs?=
 =?utf-8?B?M2tEMlJOaFZmeUJIeXVzbHJIcHhrRGxKNkJGSy9wMkhPTExOWDkvWjBnZFpF?=
 =?utf-8?B?blNLTUJreDFqaFhPMGZEUkhTUFFLMXBHc2dOSTRmZDBiVGNpQTVSMGlyaGtE?=
 =?utf-8?B?ak1kTUVuMFhMNG1rUkJmVlZjYnB0SHdTcEh1dU9qTnVpU0hVQzNQQm9jYVE3?=
 =?utf-8?B?MUgxZnV5S2xNM1YyRUNKSHk3Zm1FTVZGNTdLbm5sQldoYkxHVVdWYzVhZGdG?=
 =?utf-8?B?NUhLdW5DcXRuWVNGUVdVQ3U0MWhtd1pzMUtqOWZKUElZYk9CNHgzL2M1bmdr?=
 =?utf-8?B?SFh2blZ4U2RIUTJjMzFMRnpmTVVYMy96TTNjWmpHcytOMlBQdEQzS05ZaTI3?=
 =?utf-8?B?K1phM0JiTklheXNJSTNKcnJpME80czF6WjBVLzlwMUhOdEpCeGtRMGtlUGZn?=
 =?utf-8?B?d2tzaG12cVFEZkJPYmFDd1VjQW81c0tIcVlBcUFSWmVGVEdZeXRUN04vY3BK?=
 =?utf-8?B?NUxwRDlBMXYxYitKcnltdkk0Ry8wV3hTUW9udEpkczlHcWg1S1N0b1AzcVZj?=
 =?utf-8?B?TjFUU2d0ciswc3VNL3UwN1RXWXRHQTV2amc2cWNYdEFTbU5NTkFPd0laNXYy?=
 =?utf-8?B?M2xqcjlOc2ZVVW5wdUNvQzNDZUp2N3ZXOStJdDFQTmJmNE02VWZ6MVJza090?=
 =?utf-8?B?OEVKTHpwUEZXQm53VmxVa1hqMCtZWXhUMUZXTXNVN3o5eGZ4eEVVOWUvYitB?=
 =?utf-8?B?ME1jejdQMjlvaDhPeVhTZ2J5d0lqaHhzNkpJSTBZRXBQdVJuS21lMVFsWlNa?=
 =?utf-8?Q?UbSVhFLg4zS3+NXbw3whcXm7U57N6gMxrxVAc2pr7ALkv?=
X-MS-Exchange-AntiSpam-MessageData-1: Wt1vWBgbo9JOwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485385d3-cd0c-4898-3604-08df1d1c44e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:52:16.3325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0vuaOey8g+IIfGURIFMh/EIpOlcBsNI/veblMANfUpEMP4eUW1iHw28QwB75Vw5C0T8XS1aQOiVbL1y5SgI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
> `send_single_command` handles both the transport and message layers of
> the command, intertwining the logic of the two.
>
> Reorder the code so the message layer logic is within the same
> contiguous block of code, so it can easily be moved.
>
> No functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 3a8548a51259..07e8e32c3d57 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -659,18 +659,21 @@ fn send_single_command<M>(&mut self, command: M) ->=
 Result
>              .gsp_mem
>              .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
> =20
> +        // Fill the header.
> +        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_b=
ytes);
> +        // SAFETY: `msg_header` is a valid reference, and not touched if=
 the initializer fails.

nit: `msg_header` not used here

> +        unsafe {
> +            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_=
element_init)?;
> +        }
> +

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
