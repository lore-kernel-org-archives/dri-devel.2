Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC40CDB46B
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473C910E1E0;
	Sat, 20 Jun 2026 10:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ria9f3Jh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB8210E1E0
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 10:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVU4M7MnhNO6yNI5UnBhU8I6fBlOSvhM4M+vws0HJm9dehQtYuhcHsRvqPROMD1sj4N6ogNPm+7WDHF2RpOlMDimtYlrGVLeY9uzxppVPDsKWbiaK784Z2SCYRTdMI/RjoRSaBOqdHWfi9dy8Z3eq7T4KE0F0gVNurh4DybcbHMsW08Pbj9Dt6BwP7iSbAplLFw6cCbhl/nXaBri8YS7zBOHNGhzf3M11qZhcwHDey9tZUTCffNp3ystuxMRovFxYz2CKGatC1uCzBDEoiCDxaTGUmUjzKtcQNng2fTTm549S4Q2JEcU3LAtT2ylpDdUzvhAWYAd5umwynwJ8JlsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfEmHr5MuGyoApF1oKQxe/XbPvHuFe+6CaoyTginfUA=;
 b=Pbhp+Fs1NKW6JYjBy05K8NQuLAIQ9wZbQ1vWrIaozuPiQ9WJLxNLjLk8iCJCuX6M0lOljL4D7bPwhx+C6n+3hpA0PPCDIIGKI8wCGrnIQaWx3wdY1ML2eNvLpITDNjrJh5OtPsshB9vQOw3PC9HgGRsIrLo9Hy21pJvxHdVfdzboMObnBvIla/KmTGLWE7nisj9RD/EgRQ9PjQbfhp7qQct/Ac/npv96pCt1p0tqv3izwBuGj6v2/xW4FrNx5KvlzMVYmtufuBAb1ckwUJbpPjNhJaHgfUlNVoQctQnhkzsS/Ege94jF3LeTcwWLy4PskfyuBd8Ijkr1eGxikTb+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfEmHr5MuGyoApF1oKQxe/XbPvHuFe+6CaoyTginfUA=;
 b=ria9f3JhhJHCjRMz0qFv6kPkU8gKyDe/uP16Y9AR1+fxMrXG6cK2S6sSlycNf8+fTdQe+JDr8mLL9IQArmIGgpVc7ENvpICiau/1bHT0ApjGLz08GLfwiSCOdFofMzKTmMP3a1Q5ypuZ7Gtcqpxqj1kxVgo/515jmXdcLa9s0Y7jX1Lv65G8jbhS3bsZt0rfe6E5Q+3BDjcrTTRP6/niOfGJHqKnbXRREphUU2ejFvA7JKcxc1vu7nyTddCaMIc5ZNS2ZA/lThqqeRhs63HNBH+jsGOUfKCAHUPhAJ8gCrdeZ8sdApXIzomuRGUtK4OeEMmuE6NdvAziFWKjDmgeLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 10:49:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 10:49:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 19:49:26 +0900
Message-Id: <DJDTGS1Q6GK8.2C969852M7Q2X@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 0/3] gpu: nova-core: obtain and display VRAM amount
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
X-ClientProxiedBy: TY6P301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: bae6c7ba-3af1-4fd2-4515-08deceb99b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: QgXCABJsxLVg4u42v61n7Vj6mU9+VeX5Bzt+IrNpVoJaGD7tlTeIhTpT4wCsGIcCEizczqRLcLtcK08xtjXFjHJHsrtWNZGEx/GzvkipaFTYIkBVc4R+BiS8WxmVIBaUO6YeV1oWC8qJy9hhimE5F7AZuxzhExauWvYAGruCchvJ1BaYxJepzdjAWQSMjKekV2h8BOUBXXStcIKoC0mvyC+z42X9v4zy8Zf6VuC3CI1TXjYJph+Q85m8Mkt5bjiqlhaQkWYcWyoqkHaTSv4nZEpob55MNtWCUlubIfb1N+N6EaiV4NSKczuM+7uACjcXAm9VYPXgGukejpB0jNmfhhul4neH75p3Q83oJe4J7Qg+2HzWWba9TaVB22jN56CnCpOvek03Np7HVVKkRv3Hi+AGymx9G+AX/PDWis60Hfr03LzahYbW5F03FR9QY63UFjSrFz7+rweNhfxRSsO6KbWTb+fgXcWVlBijjAP0G78gog1geO+9RKMecPictUPYViPQIfjylSM4JFfr7i5Muu96LXNF5le9CGpSJSmsv8lXiZNA7wrqrQIpW6iSnA5JHj8hLqGM+WY5KzZWmFPf1Hn8LQPnesCXVTnuA+8Mg8DRTYM/ihe3fVsIofNw4FvaGDSXJCJmjyngV2dX6d4yjM7b1VidKVb1cN5uXto5cW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VisvUkE1Tk96RWJ5TWVCVHZnTmswSGRTam0wRzk5Z0dCZzFoQVpzd0F0TGZC?=
 =?utf-8?B?YUJhQVVyVmFPb09SVkdPUGRwczZFTUdtMHc2T0J5NzRPeGw3c0tBT2ZkOEl0?=
 =?utf-8?B?OXlYWFNwc044eUE3b0pTbEMxZlZWd0pja0oxR3NjTzNXOFRhV1cwTWZTdzhJ?=
 =?utf-8?B?R0l1MnJWN05RcW5VaWMzRStMcy9nc1lTWGhaY2dqRVFhWWpWSHd3SzlmLzl2?=
 =?utf-8?B?ZWFMU1B6UjUwdjhmL2hOcWlIcEtQU3lJem9lcjB6ZmdiQmhHeUR1LzIzcHNz?=
 =?utf-8?B?dTkwS0hrUXluVkFLUTE0aTA1eXJMYWNvWHllSGMrd0JoTXMyZ1NiN3p2MmNn?=
 =?utf-8?B?VkFqWUIydGdwMEdBVm5jZXBwOFVDdDBNdUpQUjdFN1ZZemI5RTdNN1M2SG9u?=
 =?utf-8?B?NEpvdE1KS04ycEJ4a0VBdlN6OXZuY0Y1VUUzTnEzaUNxMUdUN0RKRWxmUmFn?=
 =?utf-8?B?VzZLSC9tb2NWUElsZkhScmNlbFc2S0QyNk8zaStQODZNWFQ4N0hBSEhrUkl4?=
 =?utf-8?B?ckJLN1A4cWNsOGpuTWxEMzhtM2ZTRFpnMytFbjQwVDBJYWVyc1lzcyt3UDVr?=
 =?utf-8?B?dWhNTlhINkFoak5QdWoxeUI3Z2RhaFN1eE9pT3piazBsL2tOakVtdG9BQWl4?=
 =?utf-8?B?THJPaUJzdUkwZncxcjJlUDA1dFpLNi80YnZ1RG0yRFRBdnF2L2Z2VHdtRi9n?=
 =?utf-8?B?VnYzU0Y2bEh6ZXJpMi96QmFXOFVDU0NmRjIyMGM0Tm1TbGlTNXVYYkt5Qldr?=
 =?utf-8?B?UDNpZ2o2YXRPeVUxeFFqTE9UaFRCM0Fnd2l4RENGaDdQaEV5NUwwZEJLbmJX?=
 =?utf-8?B?UjlyaGRwU2JPR1AwUGhRVEEwMkpCcE9lNUZBdDVKYmJ3TEdOVWFqK01HdzRh?=
 =?utf-8?B?T1RRNitSN1FKQzZEbVpIOVJzV1dtWDFOQ3o2b2J3elhWbTV6dVBOaUpHUlhm?=
 =?utf-8?B?enVYQ3d5YXB1WGt0NmRaSnh0OXNRM3hRN2YvRCttR0NnRlBXNGJwcDh2UW5P?=
 =?utf-8?B?MUJvendXLzZBMHJObEZ0bCttbGxxemdWSVppOWZYTE5EajlKVUdZTldrZXlF?=
 =?utf-8?B?aDJIVU5QQStoQWlZVWJWeGdsNGppaXlOcTRSYlhjMEpXUUcrbEQwNk82dENt?=
 =?utf-8?B?SktSZjN5bFg5M1FNYjg1NHZFU2dOYXBpUGxVck4ySC9hbW5jY2NzTDlrS01o?=
 =?utf-8?B?ME5NQTUxbzVPTFV4RVhQYm9FN0R6Y1pHazhsQ0NwT2NrRU9kaVVXUzVhWTlX?=
 =?utf-8?B?SzJQajF0SlF2UytDV2hyenFpNUdxY0tWMkoyMyswbXVHbm9qWk1jVE1UU055?=
 =?utf-8?B?TEduSzhtQ0VjV3dRN2E4eXNVaTJBMzZGNlA1OUxXY2k1OGRPaXBrak5pZFRM?=
 =?utf-8?B?c1ZlQUxNeTBnMm4zT1JlcWdFd05lSkZCNWhMSUdLQmo4bVFpZzB1WUFJT3pK?=
 =?utf-8?B?aW9jdnVuUnd0K3dBUUpkMjFiS0xCY2lRSHJmVlZzRithNk9mNzJLczlaVVVu?=
 =?utf-8?B?L2Z1YjBtdUJpaTNNSVNBZG9lbVl4dE4zVFlHR3lNcVVPblB2eEpoMDQ2SUZw?=
 =?utf-8?B?SEdyanA1N3pUTC9nRHBiWm8rS3FtU2JicmFHT0UvZHhJUUhEQkpxSUQraDdT?=
 =?utf-8?B?akYrRWRvNVZTYkt5cGtnbEVFY0FyQjNCZVJCdFRUbTJDRE5XdVJPVm8vWlkv?=
 =?utf-8?B?U2c3Z0RQVDNJd29wUFNQUUY2eHNpUzRxQVZKNTd1Y25rZ2hhSUhITGo2SC9t?=
 =?utf-8?B?Tkh2S2hYZlJQcWtwMU5Ca0o0N2tlWVg0NEREajM3a0toSSszNDFUOE5QL2V0?=
 =?utf-8?B?UHRBZmtMWGNQNWFEWmZoWnZPTTFPNGFOUTRVbDU0aHBrV3d6QlVTamcwV091?=
 =?utf-8?B?OGNLdzgvdEgyc1hmZ3V5aXY1T0IyM2RYRE1VRjRaNjJFMnV0cmVZbmo5QXR1?=
 =?utf-8?B?SzZKa0EwclpWMW1hdTR6VUo0VWpRdytyc2VoeHVaR29yN3hLc01TeGIyTTE0?=
 =?utf-8?B?VU9MTUMrdEdaajVYZmU5a2RuemZMd2tTN0FXOWIyQmpCL0lac1RMRGFnYThi?=
 =?utf-8?B?T2VGd2ZsTzVzM0RWY2MxRmE1NmdwMzJxM3l4NkVGWUVjbzJrc01vZ3U2SkZ1?=
 =?utf-8?B?Njg2QVNYbjU4TXdNMEREY3JLYzhpVWg5UStRWFRheTYwK1ppajl6eXBsOE9L?=
 =?utf-8?B?blVsSmRZZGFGTXNLSXg2d3RudE0wemsrVnU3SjcydGYvUXZiU1FKVmZvYllH?=
 =?utf-8?B?NHVnVmx4S29IYS9hN0xLSnBWbkpqMC8yUisvMDBURXVxZm1BbVoyV2JLcUx6?=
 =?utf-8?B?dXM3THlkSG1LTnIvejBVWXFuV0RPMjJJZnFUdVBNWmx2ckFpZVNJOC84bkZj?=
 =?utf-8?Q?94eeyvo+xAOxQiZ2oF0lykF0k1+GN+CLykq8AUD+3Qz3g?=
X-MS-Exchange-AntiSpam-MessageData-1: e8su986xN2OFAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6c7ba-3af1-4fd2-4515-08deceb99b8d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 10:49:30.8884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vD2DOMDBEw4IMTAZQwBQT8jQ87338k+dF3Ofox09A8QcJ8F7GjI8reaoipj+nECtWipPrwx5LOUUxouFdh/9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

On Wed Jun 17, 2026 at 10:24 PM JST, Alexandre Courbot wrote:
>       gpu: nova-core: move GSP unload state to a pinned Gpu subobject
>       gpu: nova-core: move GPU static information acquisition to a GSP me=
thod

These two pushed to drm-rust-next, thanks!

>       gpu: nova-core: gsp: Extract and display usable FB regions from GSP

Waiting for a review tag to push this one as well, since it has changed
a bit.
