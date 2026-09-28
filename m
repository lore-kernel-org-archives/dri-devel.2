Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1640C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3828110E77B;
	Mon, 28 Sep 2026 05:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPPDT76n";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0817310E77B;
 Mon, 28 Sep 2026 05:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2ZPvYk0afykj0gLB6Efo+w0fs+3nRBau5zJclQb/6I7ckfsWd/UN3+uBjsPfVSVl4tWQKfzCCnwJEaEwyQE5QO1lyqRtsy6w+SnJ/EvgLrAf9tsasoriY5ruXb+Pd3ADoyLRelSfYJwlmMEpwwMK23s1SSiIUSxl2X/WFhGcTXrF7EnQT2ZoIFXFEMG9ip5ID9soRtztDLbNX4w3zmg2VGCwYqB3dzbEtU+zgRhhQWGYyD45SJQB7G56UKCGbba0gwWYwK1ZrS7FlHWVv6ffbeShMWdoUjjNKNR9VGDxGCySdtYQnEUyVCehcbmdeH2D/gf7x/kyDM0zD+g+qo5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/6ZPr8VTJeG2m4IenIHFN040gVo7ZkVlmkfLdWKqCw=;
 b=E3HWv1q9Qfspxp9z/YpkRr4ijaxLZVkjzbB+aCQQJCYwp0aIyC+7a6/1YnIwFiJpuhRV4X+aSCpYPgW9eR11x8ahpLiXPprEnGIMlCwiNlJ+flDOe1JE4G3/mva8BDU15fmjN+IkVouVDML0pyQDZVf+Z9aYZgbjqIzd9Qnic/ZfYDEQ1yT0rif1x3yEPnUQO+DblOl2ngACPnhoeq/EDJxnD/BIo4qgNmAAivEb9PvCq9D22sRJfjnSJpEvS6hNJdNAatszq2QXWf6pw8+OJmxkKZ3CB/Nt1O077dDrJ0MpGcR7IgA58AQtBpXHcg8J9DeJZy7G5j1QaoOrwT7S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6ZPr8VTJeG2m4IenIHFN040gVo7ZkVlmkfLdWKqCw=;
 b=GPPDT76n070N14lG5+WHpirz83Sm2qgtUIW9rg//HQIQUV+tNhQ2WcmAtmKd2DoroOL7wMijfP5T9NGc0Vl0eGr3kxyV8zuSQHUo0clBd7lNt6rpm8MUzc4KnyDRoyAd57cln82b5ObFIRPoqKuXPrKXpGi//f0I8g1SpjoY1GPrk6qDELHsP2ZzJbEvgFA2Z7GfGoGAS/jzn9Ennk6Fh50MsPlQgFRx0JDFcxHmTBPTpu9RvAep4IXC9y3XUXcsViTdruTG6cVVAODU/fxW/nOgvFHvgBRV2bEgIdvzrctiBQGWscvndztln2l4R8w7G0VNw5HtUzfHZcpiIAybzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 05:32:26 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:32:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:32:22 +0900
Message-Id: <DLQPCHIAIGST.37ZFN2FOEOUD6@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 9/9] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-9-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-9-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 64478a67-0680-4508-ac7e-08df1d21e11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Msr6+xN6SIVpHKJP1DlV8igRcjYE06CjUvcyUC476B6ZYod7JRd6YyPRVDqLFt45r7tlMB2zAqkmW9V+jSjoTcv9SMMJMeuD73FHOFJHKe832Sy0FMYiR7v3Gy8DG4XlwuYndUBOu0phY79QdQMrXPDlF52phSvdCdpOTvuRI688maqFPf/MT8ZedpOKmx4Bv2ci1V136puoTOHOFBHvgZDhADFRN21+d9MufJE1EulYbBbTGIE3J6X7B0+E0WxD4BxKGuOymgRHMb5fjCVt1evLfEalYLIYsPTjkSp+Qtp0JiFMxyg02/DTg4al086cEEe0C1iJAL65B5buOMovJGH6MuY1XSInKGvU/4tTDnAyft4n0fD4ZXTV0h766wIJJgYUQkGNFg6K6ClQ7cJA/aHzpiNzzdhBOZOd6kQ9OxQmHXfGwVXrB9FXLB7CmdAg6/lyMsfvOLqFdD/dkyMtMvMqOC1kuaB/Nth48DPNr8616qRihuIrET8UQV1u/U+Vc+9ahHz+xoMXDVC+Sx+PkQR7HDfOn99fC79Mj++eiIbenSMXCsZEqIHyGBENoyaX+dZc+zP+Z2B+KQPMgWHWAN1ur0CMrYVFLpjjtyBcq4ZHVSuyc7t/YAVdkMWMphB9TOYgQRMe+nSdXfYzQr2XCJLxykw9ndzTX8Uc3Pl+zlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzArY3FvQWZNcEMxVFJXQWV6ZGhNQ04xaEpoOWJ6TVVqTlNQU00xNzhzNGxG?=
 =?utf-8?B?c2x1VWZzYlVZS0Y5TmRwM1VZOFpyU05pc0M1dWpDMk5RRzlsT1JVMW5VUzV0?=
 =?utf-8?B?YlhYN2VKcUZnSUZwYjVBVkxzbWNML2hyWHZsRXY5M3VyTy9wcFFLNlRLMVlT?=
 =?utf-8?B?Nll1bDJYbXBHVzd1cTNVcy84R3pTQ21kSGszREpMK1ozYkVDcGZzenRMRjJW?=
 =?utf-8?B?ejd5ZGFhMXZhV1daeCt1WVBqUmQ3M2p5QU1uVndVRFNsSUsvRFRZbDRjdHRZ?=
 =?utf-8?B?cWZVcnJqcVV4Wkk1QjdpQ25aamp1RGpPT09jQTJxUEttY1FlLytmYU94cGRB?=
 =?utf-8?B?ZWovWEFpWWpXNG8yeFFYaDVidmxKYXpQVXlIYXdGOW1vYXN4RU9mblNMU05N?=
 =?utf-8?B?aC9DbjVXMUFWQ0ZNejZRRHhTWE5GemRJODUvb1B1MHFNRHFxWUNhR29ab0Q1?=
 =?utf-8?B?SFVwQ3F5Z1VZQXpNQWYzUVlycG8vRDV3b04rdk1VM1cxZFpFanlwajlMdzJV?=
 =?utf-8?B?cDlsTFJyNEloNmxFbHF6UVBsY1FyS0NXcnlyV1hvamo3L1hhSXh5b1hrdUlX?=
 =?utf-8?B?cytvSUdXTWphWENMOFkyV1JEaHRkL3NiaDk4SHdZK2RXdGhpNkdnMVduQzdk?=
 =?utf-8?B?RFRvcHNjdXJSbmxubEJvYjVYeTdJd29tdlRQOTZoVjJpMmFlVEpNSEpMazg4?=
 =?utf-8?B?L1l4bWhxd2x6MFlMTmdSU2VaN2xwMzNuREtnZkJ6QWZuakRyTHo0YXZucHFL?=
 =?utf-8?B?WjY0MDBMQWN6ZkVrNUF1dnZWajlNalBoakN1bllNb1FlSWFEZGdlWGpzaXRO?=
 =?utf-8?B?ejBzdFVhU05URXBCTDcyWHpkUTNOWkFkU3BETUR3TjJESUtSZVdwOTNvZ0dH?=
 =?utf-8?B?L1dyMVRhTzF4dXZZUWFkdnFHaGE5UytOMEx6eVhJMzRtMnNjZ1pJakZNK1lo?=
 =?utf-8?B?VGJqcFlqS09mZE9jbEFIMVl4MVpBNHFEV3JPQ1JmT2kzQlNCVXkxTHpjdXZq?=
 =?utf-8?B?RHZHRktFNkhETzJjQU1CM1FrWDcvZjl6L0xpL09mdkpNY01WZzJzUHFlYUJE?=
 =?utf-8?B?NTh5TUVEYzczRmhsNlVjWjFTWU91dGJPaVZFY01qRy9sbWFrTVNCSG5BNVBj?=
 =?utf-8?B?V0xJRlBXZWl6MFgwMU5ENzhGV1UxNFMvbEdLMWVZbFI0a3lDTmhwTVB5aTJI?=
 =?utf-8?B?TkNuWWl0Y1hoc2RST1NiMXhhNGJGQWEwTC9QcjJ5Q3I0Y3VlZDRXejg0MzBC?=
 =?utf-8?B?L2NuZVlWcHNtdUZ5SksrUXNSNTZHc0NOblQ2VTRoN3AzNC8vbFlCZ0duZEpu?=
 =?utf-8?B?UlVSS0RNWkVMQnBmRFRscjBMUDlXSlJQMmNscFAzVzhiOE9KQXBCeUVRVmlr?=
 =?utf-8?B?aU9nRUdvQXdaeDREK25zUXRPU29IbFFkVXB0UUVBbmEzbTl6MENIdGZ2OWVl?=
 =?utf-8?B?WnRoS0ZGblFCelRkazVuTlIyNXRaOTU3SGNKRGZtYldwVTdsbmw2OEViK2F1?=
 =?utf-8?B?LzVqcUxIcVNZamNZUGEra0xkdVAyaEcwRWIzVFZLenIwT1ZFT0QrT3VzcGdZ?=
 =?utf-8?B?T1lpcklja0pDZEFqdzFBNUZqdXMvZXZqZ0ttQWtCK3hkZWF1aXU2WjJrbFMr?=
 =?utf-8?B?TEF5Wi9yb2hNTUJMdDRadlBIUlo4ZlErSmJaT0UrdE45a0I0TlZac3lsdHlC?=
 =?utf-8?B?UGZJM3F6aDVsRUpPdnBiNXB2U1F6MnZMaSs1dkhMalFLL3BRV054VWtNSnNL?=
 =?utf-8?B?YTU5M1JqOFg4ZFBKaGVtTFFwVks0b2oxcGQ5K1pRaHJIUFJOSTg5b2dkTzdN?=
 =?utf-8?B?UGt1WkZZWlNWM2dMbGFHU0JDa2RqVHF5bVo0T29YeG5wQnpBQ25FQ2FucVRo?=
 =?utf-8?B?TGxYUExjMWFNRzZsQnY1MEZjelRaZjNnMjB4NlJsZ3hYQnVTaHkwY0hlMXNk?=
 =?utf-8?B?M1VEZmdIQllvaVdHR1huQ2RqQ1oybTRZS3Z0bmhjUHNlWnlUM3hxMXdqZnI3?=
 =?utf-8?B?RTQyaHY3MlVWdTJkMG1XeEZHSnJWekQ3TTFMdkxkb3FFSDhWdm9FOEluZVpS?=
 =?utf-8?B?Mk8yQWYza09XcXFHRXFjSkdxMmFuVVRseFNBV1lIMk5IWG4yOGZhZERJQU5H?=
 =?utf-8?B?N29iemlYemNYbzNSVWMzS2VwYlg3OXdQUGhRZzZEY1FWMlp1c0xwd0MzWDRF?=
 =?utf-8?B?bmR6bXE4TEZiazFSYTJibmZUTGVhZ2ZTb1luMWpTK2FWd0x0SmNwbXd4VkJN?=
 =?utf-8?B?SG5NaFErRjZFQlZSaVQ3a1dRVE5UR3V5RnBkcE4rREtvSkI2SGtseE5pa1oz?=
 =?utf-8?B?RDN0REF4c1BYMWJ5blY2ditvYjhrVG1peCtSY2Y1V3V5MmY1d0hUdWNkbnFE?=
 =?utf-8?Q?B197Qos/3pJXVuFaUz1a6wO0/p4jQ7mIW80c6NxKMMlCP?=
X-MS-Exchange-AntiSpam-MessageData-1: QrZRLScYLWNVXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64478a67-0680-4508-ac7e-08df1d21e11d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:32:25.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOQUJjRwiDlxHGJDTCjHDlNxTTF25qNLIrquJvIdVeR8bmRu5tfMCeFL4+YnOWAmodunWTDyfW9A8jCOWfDoWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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
> Since we are going to introduce a second type of message, add `rpc` to
> the names of the relevant command queue methods so we can distinguish
> between the two.
>
> No functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
