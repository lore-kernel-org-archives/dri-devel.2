Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164DCFAD3E7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C01F10E2E4;
	Thu, 23 Apr 2026 02:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gISSEkCq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9805D10E2E4
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 02:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ4xycLcroe51PRvCf27vpNfIqWAWFPkClV1GASqEC2peJWxs9J5ZaD4VXvBIFIcSPNvlqCyYGuqZ+uvq0pSdHEE956C2lKI8PmhAw5/2RuW1nMSh8w6xQoJ3m8ugSE0T57FdRw94kEXKPAebpquhqsVmUyN7yw8G4mPTUr1GMXrsLn1mJPY4OuaT48fz2qlsl2Jvw2mHeCUL2riQsc+67KNS+6hwIWQ1nzONPycUCi2zdu807krDUVchjOd9WdvYKq3nt66IxKMjzN2ArFtf2aMZdBRxwSE1MecnlGor1cxDe/NxQRZorasZ4j//+NDIl8R741H5UHT+5j9cyL7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW9UjKu1YgRdti+GSVuxnSKY2g6gqYy7yfSC/OjK9rA=;
 b=kiHuep94SUS03CR1FEWbmLl+MSzQNxdbAW9ia1OZEfiJCgeBBwm0u1jFBNQRORyvhCGXdMMmJZYeDBaDDfSAgtlfGksMpjbqZHru6LzZxWALPlOCAjfHOyUCWNzMch1guUOCH5TPOYIInN1zv3KhErVdx40ISwzMYzIX2UFvaB7HMCIrbcjyznFaD+RGnSfd1Qmu0PUs1Vt24xHzjsWnV15BWNVW0gcJtnEWp7BKnOUsmLcvNNPalSXhcBa+wnqNUBdquyAH0bgTFA5uW3WbWKJDeXkkSTnPkh2Eg+XxUH7gdYTdeiNRkIrKyyoab/C1aOV8U64u++31tLdD0HcAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW9UjKu1YgRdti+GSVuxnSKY2g6gqYy7yfSC/OjK9rA=;
 b=gISSEkCqOjOPpEBzk5P1GgkQuvAdWpWupJ0sC56lbj+fHBbJJT4rIJZ5U2nCEjvuuKJMpK7hPOW0TsKD1aYUTk7k3dwZ25O0ulN9271QG15Jv4VAPMKsfia5cezkqKyIgmGcwfgHdaUEtXAYi1xFK8sSz+Q3fLmA1xDFO1zZg0cQcqHFRiMW3v0d7nxnSc2BKvVwWXdOsaD3aqqDDrF//rM0LnjDAq1mSjsVLTdVjcAzJAXE06/C4Z4d8l+HpYcx10dm6ojhduPgWDu0bxKo5BdwV3rDVg5/Y9/sIp4zVOWRaj2CN5hRSJwva+GCUaEG3sT7LkP61QApLTUCqEAwhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Thu, 23 Apr
 2026 02:33:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 02:33:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 11:32:57 +0900
Message-Id: <DI06L1BZYNZU.GJLSJWUVL5T@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] gpu: nova-core: remove unneeded get_gsp_info
 proxy function
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <20260422-nova-unload-v3-3-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-3-1d2c81bd3ced@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 585e145e-d418-490e-735e-08dea0e0a399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: DAnrMQ9l/inOzz9Qu4YR2eYbZb2MDrbx3UxpbF1KXPc9zY2ULKsIzBcF8tE5J56X88o50pX35oo3Qg21TPRqytIFvS+SooHK3hspL9ZH9r/2KpFbySPy7w/YonStTFoaFVFZdMN0LCvrzSLr5ZigH/yWdLqnrPRKDkZ7AQgR2EJBA0yW50Eu/UoCZN3DBlFAC8RxrXN9QvaRhl4G9+f/6Tv8ZImm5dJ7niet9/xuZRz05LRXQk5bnNIi0x1I69d2foy8Dbz5lJ5jV4jBGDCFiRszy2zl5Y3uYw3HkzXQh2NF49Ch+pwJY0GOVR6wqCA7fQLql7tXtyYHdV+bYWC2hf7G3A0sscxT5h6DrHuzYKKtgWRGaMvVRiRSyf9UVbkdHdR5i+1RcxWjjj5kB1ksdrxvwwaaaCbJTpEgw4PiR3tOoGWMsoC3KoFV89Sd/d+acgEfRBgxQdwUcpOf2EQBpbEbY0bCFMpgYRrlm0xwofh8js/rMLQschDV8eJHE7mY1uTVjLwk67ts4ZJ1us2cplWvLDNRO+jpTFHoSA1wnjRFeTs25CjNcCYmcDnIcEZqfUWahdlpGRZn0U3u2ytm4CuR6ewE8VrI9KD+JJ1hHtaXOUi1t7ZhOKP5Leaw2jw6IKft8pogtsJzBLv3ngIJV679vDGSe+BviA6fcwgqjBKLHUQvyBP+Q67hCujHpsQhLBKC4BIgAusHhATSdZVvvwWKDmahrUnClpLtFYfUgXYZ9ZS2XeChGHTwZ1sKQ5NVPQrm4E9yCx/niXmRy8/jgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJqNEF5NUpIcG5aeHRHWDNWOVpTQmZHWnpOUXlMeGxBTGtoS2xaZ2hSVmdP?=
 =?utf-8?B?RmxVZ2V6enhTLzNEU1h5RU1wQVFFUW8wWk9idFJ2VGYyS0dYQTJ3a2tHSzg0?=
 =?utf-8?B?VmRCSzVPcklwczZCVFdEa2Q3KzNZY0JSWnBobnNISy9pL2IvNndVQXpWcGho?=
 =?utf-8?B?RnFIdmhodUNnN3JlblQ1emdWSXBHR29ETVcwaytIb1UxVUs2VEZjdVZNZ0Vy?=
 =?utf-8?B?V2lDYlZwb1JRTzFrNTY3ZVRvOXQySDcvK0F5eTRaRmM2SWZORTU5elptZHJh?=
 =?utf-8?B?Mi9uaDFpeGNnR0pzdjRNdHM2dGFOTlBUUGFvcmN6WFVWaHFVZ1BvN1pza05q?=
 =?utf-8?B?WlFpZXErSHhSa0VtTzJpYkVCNEFJb3hLck9OZXZ4ejNpRThHT0swWjZ2SGFY?=
 =?utf-8?B?ZlNvWm1qVEpDclpBR0lZenozUjY1UXJVSEdsMkl6cFMvTDQ4RWFjRXJhRGY4?=
 =?utf-8?B?emIybzZ4MlRhSmtHQzJ5ajJEeXlKVksxdU1aalZoZS9UZEJsWEE1NFpsUEkr?=
 =?utf-8?B?UXJzQXpJbU5LNWRmR2xDOXozN2NBR3E1TGpOVkdrN1FRSC90NDVjd1FXQUF2?=
 =?utf-8?B?OG0vRUxCMWRQSU10bm12MVcvWFdkR0xzcWNNcTgvREFTaE5XMkpOeGEwbHZv?=
 =?utf-8?B?dHJkRmtWejNjQ0lacnFaL3B2VTZ4MkFmYlZUOTV1N290QzRZWWlSSnlTQzcr?=
 =?utf-8?B?ZGx0UkZOeFhRL3dOVC9YS0tYdW1tZ08velowdGF3TzVFL2s1TC9uNS9YWGZi?=
 =?utf-8?B?eG1SWGFVZ0VjWmQwSVVnZjZLTi9MenlyYXA4bkw5emdjZzh0L21lWEt0OU9P?=
 =?utf-8?B?cjFmZlNQY2ZuYmNZdjQycjBnbHA2RWdGNi9reVlyMklNK0RweFN4TGFPVHVY?=
 =?utf-8?B?Mjc3Smt3dngvRDVERGJrK2lYWTVjU2Z5MkZ0U0VQNVl5R25rWHp6Rm5GRFdY?=
 =?utf-8?B?MlJxNUxzcnRkR0ZtYVJLc3h6dG4zYXk3dmE4bXRDWjVNa2tlSmlGU0FGZ3Ft?=
 =?utf-8?B?bEpEc3hyYkw2SFduUkVBR1BRa3RrdmR6dXY1ZHg5QzVRRU5DdmFzb0NOci9I?=
 =?utf-8?B?WFBFUFowM2FNSVRsNWF2VlBkZjgrTjlvekEvRXJvbmVITFJZWDlaWVY5bGts?=
 =?utf-8?B?Vm5pRTRJNE9WT2p4eURjQVFuc253bHJOLzRhTlU1a2NtaVlXZ3ZhSUxtSGpN?=
 =?utf-8?B?R0JxVHVoZ3gzWXNuQlJGZ0JyRi94WnlNeDFBQWdaUWwxTFRKZ2gybHVFaDFo?=
 =?utf-8?B?ME5ZRVVaSWVMK1FHWm44TlU5cHZ6aVFScEZxdFpTN20zVE54aGJHaGt6ZEtn?=
 =?utf-8?B?UzdYaVF4NGZoVUxyeU9mYnUyK25ETGJQNlUwWFBMdmJJc01lYjM1VzUxL1Jr?=
 =?utf-8?B?Q3B1Um93WEt6M2lNb1lGQlNubENBT0dJRk5uakxaZ0xDdk8raUtQQklrU1da?=
 =?utf-8?B?RzBvZGlTcjVQcy9INjdMQWo1cURxMU9GdTQ1RzFqNG9ZVldWUlZsS3RUdWg1?=
 =?utf-8?B?VW14QWk5TnFNY2FrMFBWQ3R5emI1TWVuUjNCZjFYRXVqWEg4RnYvUUo3QUo0?=
 =?utf-8?B?Qi9GTENqM2VKU25MbjVjOEp1UmY0T1RSd3c0L0JPZzR2R1J1TkZoNVZiMHdX?=
 =?utf-8?B?MW1FVVBqaHpJZVBOWGV6SEJIYU9hL3FzQWh5YW9kVjhITnNlZ01Xc2R0UjRT?=
 =?utf-8?B?ZnJqTldEZHJiYURNME0va0ZhN3FJTDFHc2wzdDJYSk16ZkhFaXoxNVBDS1hE?=
 =?utf-8?B?SmRySis2UGlOUW1Mb05RT3FJSHFLUmdBM0dtRWlmRS92OFNJbWVjUHpOVEtL?=
 =?utf-8?B?YXdNSnkrMU8zdE5xb0FZWFJWb095WEFOWWtXcWdpb1NUbmY0b09adlBkcE9S?=
 =?utf-8?B?QnlEOEIzMzJaVy8wWWJZOURLTm9BUDE3SmhmKzB6TXFoTGFOVUQvV2pHS1A2?=
 =?utf-8?B?U0cveTl5ajJLSUwrSlQ2SkZRS0dFQnFBZXhHdTljaytrNm1ydzVSYnFsUHZa?=
 =?utf-8?B?enlJZ3hZZHVTblNMK0grb3pYMTVxV3pNN0ZKQnBSRUt2Qm9OTHRXekh1ZWlE?=
 =?utf-8?B?dU1FYlFYVnpraExhc1dRVzBrRXBnQ0tWV09rRWUrNjhxNmlxMzhoSDduTFR1?=
 =?utf-8?B?dGRlOTBGcXRuRXJGcjkwS0lUMExNa3FSZ0EzUXd2cGZMUVNQWXN4RWhzOWNn?=
 =?utf-8?B?Q0daZkYzWXBMMktKek5QV2NPUjFCcW1xWC9SZ3o2MzlNWUpnekdoV2I2VStF?=
 =?utf-8?B?b2hhU2EwdHdmd1RjeHFwMTRNVG1hTDR3bTR1YlpPbXIxbVBIbmdpT0ZHc3JQ?=
 =?utf-8?B?VzU0VjJKWllNZXN6d2ZqMXpIWDRXNmNtdWc2V2FGRkFHUXFqTVdLYURjTnAz?=
 =?utf-8?Q?Mviu/Vj0CUt1vfhh1PmfOCcXYiPWeUu7BxlRXq1HdbqVs?=
X-MS-Exchange-AntiSpam-MessageData-1: ua/TytxH3yIdcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585e145e-d418-490e-735e-08dea0e0a399
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 02:33:01.3545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLyPD/PraOWKlvkiiQh6YtUj3Vt/0gclx1Unex4OlfmhBQSimFOrNi4PjvfMLOwnhToPUDkMFTVObN3B4cFPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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

On Wed Apr 22, 2026 at 10:40 PM JST, Alexandre Courbot wrote:
> This function was useful before the generic command-queue send methods
> got merged, but it is just boilerplate now. Replace it with the correct
> sequence to queue the `GetGspStaticInfo` command directly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

