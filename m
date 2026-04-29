Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E3BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04D010EF8A;
	Wed, 29 Apr 2026 11:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dj5fKneA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D54A10EF8D;
 Wed, 29 Apr 2026 11:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lah4lHajLpk/j02KhmtIWrhBJvIv+eNjdrH5zKUutpkwRcFo3h3Dh/Ft2B09gfI3cfJ5/IV3CEYksbWDeCngVOzL1wLyyIbiQk/eWHFzRAFWsjUjB33wI7JZuYPRZ/bVSFC3mt2QW/OIwZyFlsWj6+upT/J/Slh03C8qkOIwGI2cd0Ww+HxOmmAJtKMdXW8ekrlwoDN/C3+5f+EFje8ZKXRjfZkQUZj+1S8NEyp7MO2F31IFXl7xyRTEXHJwbGEcoiBNwGeha5JFfY6ZtgVQwl/7Dl5FZ6gvLBWvPAt+9236M1KLmuWwlqdsrGhaq0nP+fV4VQxujINU1XgPrclalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46m0nYgMRJRC67DwPeSFyIqQUVIbGaPazC5gGGf518Y=;
 b=Df7XpoVIa5Fy3dljJKTkr159Yuttbsz95bbFi2Y1G0JIeGr4AhbLq5nrc0+NIgApBvzpAWKdpGRcVaWHUGODyu/pnOHs47WqnpHCL4sY+iL8JtI2N/Gy5wMe303ieZsDvfEbhluW9heWXVPRxqwRqcFNo2dZ8K9jY2adjhAEBC6I9Gm4L2EAjj/0jST7TacUDbIhOCKmCMDHDDkOpQCa+EXuoGncv8/K1SLqf++3p3VIxiCHO+mKst6UqdU3wri6nsjre+afDKuAPl2PMVoupXkTX0MJXTggBMNrAYwf0uwdoUVMYOg0pgWVo6CY8ca+qdqkYPCIYcHDGSQO+8NaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46m0nYgMRJRC67DwPeSFyIqQUVIbGaPazC5gGGf518Y=;
 b=Dj5fKneAjuRY7YvlNEh99AIOI6tQAR3w0X5DsmZ1pROoFQmTriHPwzqc/lMrLigRDTA/H3y8/yDQ9UngrTLl35sq0mcytHDXZ5DZzuY+qsZzaMt/BgamvF0iWNgZHVZYFQ5rlQ0EVobUE6amSyokncjJCWINKTT3a+tNincdcBCgx7eVKvT4O7XzvLG+q7Hb9e1qWFeZSwgRaVBbiQsDlbPrzBe9TUEVYzMvrvZ1LX8RhItBzIRp3G+F1+HT7GiLW4PQYtR6l+nExW0cuVB3khwQJN6/L+0kbY+kDScx3Q88G7I3gWwqJPh47t4AdhbQOfwvaDPvYmSn5dcoEsJSKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 11:22:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 11:22:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:22:29 +0900
Message-Id: <DI5LLR40RNKQ.ZB5RHU67QKPH@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/5] gpu: nova-core: convert to keyworded projection syntax
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-3-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-3-450723cb3727@garyguo.net>
X-ClientProxiedBy: TYCP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c1a296-e723-4c11-2471-08dea5e19b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qlgItZR707twnr/C4OGqByYUkzi/sPKyubLkDW3tScQYLnu2djLu/9MO92/sc7+BdWbS1ubhE0/B1vkOviCFS5RlIgqUxeGgxD+SBX6JRn15lCP7j0f7c9c/NoOoGCh7ZAYlEHJqD0IpoHQgE8u6t7IwdLoSUmcL5FkQLh80Yrz6zSMFQJSLZaHZuFRSN9pFU46E1iJr+KmpJh8iHxMEAeKRRMTtAdzcfEESgcdaUXyWex1tt1ZWIJlvji7ZlC8beCCilwAy+E51nSqSz+vw+a3EEBsQNXXojOSa6DavG1gvtDRwa1U5Oqhe59opxC+Fauj58dqn3swdhOX9BQ30HYNzUrGD3Pdk8H4sntq3ubrfnDSWRSAbptUarilHTr3YcovofmwKNUh7KLnEXAG5g4xAEl9XALD4zNH2xHsZWoeyAnEXvcQs0qRimQoAhBPC49XM3M32UMt3soH3OeLb4yGg9pVhL3mlhl6nQLc4Rlmlqtr5lZkwOnEeBadpRE/JjDdIJHmsQwblDj8UeOMkDL3DEj5h5kjJKaiG3Punt2SZx07Dfjw3NCMXQzLfaREhVy3Z5rJe7ye9VQd2LM1X7bs9I7D+6ya2YPkbr2a2SjR3Iwpoga8K0d8s+NK79IjUbW/eA1+yRFVABG43Sda2pk3q8sSWYrbx+qtUsi69bzlQZPjMjJz0znaRRaGpSZ/0CZvqS59w7dt/xt5HW9Faf7o0lwY4h2488I6EBvjdC5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFUbElxeG9hMlFqeUFOOFNrYkwwVEV3S1krRXpsUENnTUlnbUtKSUpadnRH?=
 =?utf-8?B?ZCttYlVoTFg3aEdsb04wRnUvS0F5QjNPdTZFS1lvcW9kenVuNmVta2x5dlFk?=
 =?utf-8?B?WDJoRm45cnh6N0luemxPNWxoSUdmZ2lUamVVM1hzSzdIbFZYajlmQUJFamtS?=
 =?utf-8?B?NDZSMDdhRDY3OStTZWw3cElIQ1JjUkFBSm9lejg2azg5YnVrOCs2MHdoRXVq?=
 =?utf-8?B?YkFQTGh6WEl0aWhDaWRWdllrR3pJb2d3N05zenF6WDZwZDQzMkcrVnc5dVhx?=
 =?utf-8?B?U1QySUNNRUpmSEpCOTZUTWZrWE9uQWNLYUpRLzFYdHA2aDcxbUhQbXdjU0Vv?=
 =?utf-8?B?eUNWOGRKckhHN0pzM1hCZTYxamdhTW1KM05ma1NZczNna0pqUWhwc0ViT3Y2?=
 =?utf-8?B?TmNSZWxReXNSTlNKTFN0OHUrOFlhOU12cG9adWZKVStOSlFkajNiWWdxa1RE?=
 =?utf-8?B?QkJITjBkbHpTUk9UZUF3VVc5eUM3NEpDWjY0dVZqVUdBNmRCUEZyWTVHSlll?=
 =?utf-8?B?bHhGL2x1NnFFTUV6cmdoL2U2cE1zT1duYkV3ZGJUMzJRaVZXTnpHbldYbXA4?=
 =?utf-8?B?NVliT2xsQ1QzYWordm11R0g3Mm5VNExESDBkK0hqZnYwa0M0WFpIU0wyQ0Ja?=
 =?utf-8?B?S0Jtc2dHTVpLOTVDQ094bDIrSHJTQy9lQldqSGNHRVdXSmQ0eUVxeHZuM0VD?=
 =?utf-8?B?SEdBSVJvOG1rbE1HWlZ4cXoxdWxTbytXRVZDQlB0R3hQSjNIZ0VkMEZBaDUw?=
 =?utf-8?B?Q1JMVE1YTGpGQy9tOFVVYkJHS2hWVGdwbUhhK3dpaVNQRHZPYWtqNzkvQ0NW?=
 =?utf-8?B?MjVXejZsd05lTDNuWW1QdGNPWU9VUGs3c0hZWngyWkxGR0JYQ3dqNlZVWWRL?=
 =?utf-8?B?YWtyYjZhbndPUGRCN2dSOHBqMkhDZGtuQVZSaTBab0JMb3QzUUhWSThxbEox?=
 =?utf-8?B?cmtYUDdtUTBmOUdTOVZSa2lON2xxemdZYUI4QXJiMTgxVDdPRFJ5ckRXV3Uz?=
 =?utf-8?B?aEg2MmVyT2w4Y2xKdW1KSUxjZzNsNGI3N29qU2Q3R1EvNVhqbDNpNzQwK2ov?=
 =?utf-8?B?WGZ5cjVRVkZYZGFaMmE0eEg0REpGK3hLOUI2emswbU9FdEdGdFlJajlPRDNO?=
 =?utf-8?B?ZEpiZzVFZTMxTjFMenBOOE5XUVRuMXVaTDJzRmNJMDdnUGN0RjdhOFpmRXo1?=
 =?utf-8?B?L1B6ME0zN1AwVUp2UldpVUN6ZWtsdStqNlA2TFRjb0FVaUpZQ21FSWtSVkNJ?=
 =?utf-8?B?bzhqZ3FOMmlBcEVyU3BIREpTV0RsUmVCNTdsZjh6OW9XejROTkY3dHVTYkFE?=
 =?utf-8?B?b0pnVHhXR2piMC9rdkNsZjR6eTJCREFtQjlMenN0cXpaaEpTRHFDZS9pNjlC?=
 =?utf-8?B?ZkF0aWZNZkFZeTQ5Sy9UeUg1bkV1TWNpRXRjSHpKWjF0a3pYWDZHRHJ0dHF6?=
 =?utf-8?B?anpyMEl6L2YzcU1Xa1BiZ0R5UWhQMjRzZUl0bnhGckV4bVozRWZHRzRBQTcx?=
 =?utf-8?B?cWMyOTJ4TWFzRnM4cTUrRVc4MG05V0pEMGw3c3IzbDlZNTYwOTk1VWFLK0Fh?=
 =?utf-8?B?NlREakFneW51MENySE04NERnWm5SUHZCTUxibDF4L0Noek5PWVR3ZE0yalVy?=
 =?utf-8?B?V3ZyeVdGY0lwV3U1UCtjWmVmQmZEMU85UjM2aThNSG1Jb2dhbFRnMjVWMlFI?=
 =?utf-8?B?d0xMcDVFZG83c3gxVjFybjNlSEh5UUZmNnlRczd0OC9mczkzYzM1M29LQ2hC?=
 =?utf-8?B?VERwWTlpdXdGeVhvYWJucDhoR0NRTjIxNGRWM01DNCtqY1hxbTlHcGdmU3U3?=
 =?utf-8?B?MGFSR0p0ZVZGSzFwcVd0dmp5bFNXa25lakFhMG9jNUZ4R0JRZHczemloVUlK?=
 =?utf-8?B?K1UxT1lqS211MngwaWpEeGV4SFg3aWhzMmREcXo5Mmp6TjFHOEQwRUVMcFpo?=
 =?utf-8?B?TzRISzJOTXd3MVZNbmlNWmNhbkFZWDRmZVV3bVQ4aHZRNFpjS2d3YzdHMGVh?=
 =?utf-8?B?dHhTOTBURzNkRHVXa2FVYXlhR1ZReDBPTEtpWkY5d3hSOHlGalJBQVlqWjYx?=
 =?utf-8?B?MGQ5UG04N2cyMUIzUGxZVW85UzVuRzdBS0pGMXArMHlEK2tiOEEvazdhUG8y?=
 =?utf-8?B?R0pxT2JZV0tPdEFMUVQzbWc3UHlkZDlzTXF6WmVCY200SXlzdTdSbWJIQnQx?=
 =?utf-8?B?aUtmeUp3T0pLaXdVVktFNlhsMXRCNFlBNkJDWmhveURKcUduUlJrc05tTVQ1?=
 =?utf-8?B?ZmtvbFZjMGZ4SGJRT05LOTRhNnNrblphR253QW5HZXoyWlNDQ3UwRndoSnQ5?=
 =?utf-8?B?Q2dvd3VYU2ZMZ0NUSjgxdzFscGJES1VHd0Z2UlE2RTQvN1RCWnhnOW56RFJT?=
 =?utf-8?Q?VOfkHZzgmTHJBhOWI41xTApGdrs7tTcGFQJbWMHFZqMyo?=
X-MS-Exchange-AntiSpam-MessageData-1: 22qfLo08aDNuQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c1a296-e723-4c11-2471-08dea5e19b73
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:22:32.8532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYOlStsPSulFUVQOqjhDkkydCr8qduTgAjc8fhLnPRZZNaaY1SKmdQEBy/LgW0l91eYqTr1jY6Yd5Dc3OfPhig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
> Use "build" to denote that the index bounds checking here is performed at
> build time.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
