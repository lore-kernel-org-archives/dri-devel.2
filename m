Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9A510BA432
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008BF10EC4C;
	Fri, 27 Mar 2026 06:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JuWOjVhz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E38210E06E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 06:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxgGvU4nCm4V0wv7k4KxsPQ7469VIkzSUR3fCLfvi9HrJ9HY/Eb+cbsZALga8IAGP12NLz8QpC8418ZWj5pB3tuEKd4sdziWXtNrBAkliDJ0SmhirwJWm9Z9XI7Hq/kOEQcogM+OLdFiipYzDCOSF7dpVVfNPaODc+u49O3EYFWzmwFPYIXojz8EvX40mvRI80UcvzmXjzdkO2f7eYAlU24c8kYlSVJPHG+7bUqT8ZovL8cI5XBi5mQnc4wJhiGVT/SBSKo0OG2/k3cMfwQfib5c3/0lNZUvQIYj/EfbsrDGGgk/FWmt+FWqi+KWfarQIP0pTrHgYEua12ityn6nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rargSqebOZNnFiIXl0LMq2JhZj1YMPuOCvGBGarZYN0=;
 b=XsaedRnLFJ/YaZD4/lk0tmoLbSRNIqEaIy5giIQU3a+mZm41lj28CDk/WmA3RbRKWKYgDXJrI/KvCHvnEEhH2FvMpEH1XKUbbZGTG5a5iTy6KCbqEclGBCIraxVVLraYuetA6lkpDHeSJ8+eK+wG5fF9MYsxcBK4wgfraqm1KnnngC8sCVsO2XWXfsInaxABkTzfAgvp2FZFxYTA/XjTgA28uNB8jiv2rGD1CvCNB5XRuyCrocEtXl0lPQcZKdKXxZ1fbh//Y1biYr+cp0RebpqEwP9zTe1oSO4I3h3xSyoPVOzwuFd9pPz4jTMiGJ9rpRYR0wnaLnuQGcEkMSjGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rargSqebOZNnFiIXl0LMq2JhZj1YMPuOCvGBGarZYN0=;
 b=JuWOjVhz61IuZ9M3Jim68DveDGQGqM3OE8ogzmJjBbJAL0+ZH7LMG9cTU8FcH5lNQ4GjsFUv261qmLHPkVKvh96feMlPH2gUZcQAymUQAj4E1+ld3+OeoJTS38cZ3ZouNMhC4s9eBvgGhHQOILZH5Ygys+5Cvy789t5tlxgLmKDQqeaiprr9/ceXFi7kngFshrWnmCWDqvBZx2giTeJCoLx7l4EVLMt346d6uDzmPlKt+FgVdCWKBVxkLfJXzCfMCuQvlCZT2RDHtyToQNb49ffmYDEIuX4DZLhhow6Ylt4zAc6bks609bt0AY9ehhUYXiPVpS1BKpT9+M7CHmNk3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 06:56:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 06:56:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 15:56:49 +0900
Message-Id: <DHDDAD2BLW8F.F8CIHEK0N82K@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>
References: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
In-Reply-To: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
X-ClientProxiedBy: TY1PR01CA0188.jpnprd01.prod.outlook.com (2603:1096:403::18)
 To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8975c0f1-03fd-4eaa-2a68-08de8bce0704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SfyYrV0diwsjOMBxwNf9oRgGu49/c5C6wQrNkKn7t4o1iQ11Lwv6tXFpPqecXxihVjcDc34RUC3RJntf9a3nI+82vp8A1r1W5eMgtztU0RXtanBl0+hBwIPLRAuTjJGaV2lCWJ0qIzDuTuk/JuM9UaT6vuGp7pHphMWb4GnM90UnG6VP3wJ6e+KU5mLg+TLryKfoGCqFvCHcvqonnrPqxX9syuxUy1LOJugmTFPmbwdjb2grH4dngV+6MJHstzm+abpPhvG7qDzPg4ywqIA28R1AmdYRt1g86lk0h5MCv/RaZSsznQgqWuQl1muZLmI5uFP4uXgNGLCzVVb4MXiz0cS7lCdSQpMRbLLQRbpblcnGzXZYisN3kWEHYS/DYfeMAGWoz6CVqG8yJi8CfSl2ykoc4T637DiqJbEm3AXfewtc03+z9+X6gtQ9Oh2Cu+f20c1gwMf5UOjY6yxcCud+CuXRSCwP2y9arm6F//JN7/ENEI7nt+Ue3Mq8FSRb7fL5ezGKeH1lg4eSyT5dfWolAIPhO7/vt1zDFRs76/ftsuWoVaHgkzc1JU3LAX4w/oLLLvmSDkuqld0RGXPBKM8fQaGZgLb8Gnomizd7CkeTk3kzCYvIimpHXBHRjsTuZiJsWqCHZqzV4ETz6O6B0J/b3/ZIJUUrzJRdcvbh8PrCBm8zQ6lvvPLtOxGGl3JlccOYJpKj/zKWo5XfacyBpMKlkD//Wj40HYClnysu3j6O6h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlA0c1BpWE1oYU1Ob09JZC9XRjZlZ01tWEMzQkdjL0x0OFlROHVyWFdxTVZN?=
 =?utf-8?B?T1drRlArTkl1UzdqWUlqV1NQK0JZV054UThCYUhJMC9pYVA3Z09RcWY1cUlR?=
 =?utf-8?B?bkdaK1E2SThoRldrMzVIQ0R3eTZaTTE1Vzk1Wm5ZbnZ5ZmsvZVZhek1vbW0x?=
 =?utf-8?B?eDdsRVVqaUlZWGQrN1M3UWpZL2ZZek9ma0QyZHJhRTFPQVNLRVUybCtoK09h?=
 =?utf-8?B?U1gxdk1Na0tNTmtySk5iZUxzcW56RDVHYUR3eEJaWmVEZFZZZjFjbnFwb2lx?=
 =?utf-8?B?eTJ2RlgvcXIraERQVDVMbE9oUG84dngvaWhVWU16S2duMW4yUEo0OGVNRTJ4?=
 =?utf-8?B?UW9lZUFQWnMyK1pORWM3YzREY05NazZDbEdoMENVY1crZVV4OWhPVnp0T0Iv?=
 =?utf-8?B?Vy9wbVJoUDdreU5FRktnTGFZMW1xVnFnVGdKY1ZUUzJmK1ZJN0s1a1FuZVZz?=
 =?utf-8?B?U2hBWkNNYjZ0VjhEbjlqdDRNWXJTQUlXcHNOMm9aMVluMGdGMEd5Z0JyZkgr?=
 =?utf-8?B?RlRocG5YTTZHTkZUNmNHeUV0R2Y2YzFpTGkvZFZSVGk5M0xtZWQ2ZkJQNkhK?=
 =?utf-8?B?OHJTR1pmMlBXdDRWTHRoU2phRHhRTTBVMzR0UW5jT2hYVFNMdXBvWlN2Qld0?=
 =?utf-8?B?cWFDSVYreFBLaVUwOVd3YmFTd1ZpMFRSVk1ZbFROM052cWNlcmlPOSt0RHJ1?=
 =?utf-8?B?WWxDV3Zvc3pIZk9zNXFpK0lNMzJWdXFNRTdabi9sRkx6aUtjOHZXSFpqdEtr?=
 =?utf-8?B?UnV5aE9CdjJza2NlRFQ3TmVFOTZlTWNDMnYvclFFSWV4c3QwQ0d1a3cyMmJz?=
 =?utf-8?B?VUtlbVRJMEVkelA4T0dudkFZcUlTamtSUktnS0psOG03R09DRW9PTzgzWnpM?=
 =?utf-8?B?YzdtclBDYWluNEdjTXdPVFRjNTV4WUU4NE13SXExeXptVisyWHduQmRSdFZ4?=
 =?utf-8?B?andnSVhVaDVxZGxCb20rN1VPNWE2ZjQ2UEY3UmZmYktMRkkwSk10R1lLQzUr?=
 =?utf-8?B?L0xoMmphbmJOZmN5NzVBV1p5Z1p4VU5XYU05cytiUzFETXpvcWZWNE5Dc2xk?=
 =?utf-8?B?ak16SGtWVnVFSVdWV29FTFZERyt0ZGdaRjgvYlREbzNQOTV6Y2t6Znd4ZVN5?=
 =?utf-8?B?eG9TS3NWc1BZeGlPZ1dhMFloODZzcTVRMjBENm9hOGtKMzhKV2xRcVBrOWg5?=
 =?utf-8?B?VG1tcXZWejM5U00yeTZiMFNwam1vNXZhQTNYUWFuNklDQXdwVGdTV0ZKaldn?=
 =?utf-8?B?VGFHQVVLV0lIcS8vWWxMVXFDL3RNZmYyYVkxdVJXVW1lcm4vZS9Yc1Bsd1Ra?=
 =?utf-8?B?bTdaTVN1dVlYL3h6UjRHcnEvc0tUeW96d0JBblJIS2FCS1R6QmtZTUR1aVFy?=
 =?utf-8?B?Vzgxd0JuWGpZYmRWTVcrajdkUnF2enBJU3IrVXRIbUlZMVZzTkJ3WURCbzlU?=
 =?utf-8?B?d1NydGdyVjlIRHZwT0xkTWZFUk9jVjY3ZmE3S1M3WWhNMHVhbUhXOEZuVERJ?=
 =?utf-8?B?Z1kzT2puY3JkUE5WWXdFYlAySFhReWV0UEdqUWRJYWIxMU8zbkpxcklCZmtR?=
 =?utf-8?B?R2hwbmNkYStpR05vNXdBdzdmbjNQblJROW1sQlV1Ylhwd0tCeWlVTS80emoz?=
 =?utf-8?B?K2VrZkwyWlhHMlBsbFdkaTJjektRZW9tckxMVU1MM2NPVXl3RDdEeENtaGpz?=
 =?utf-8?B?dWlQdUt2NzRkaFFldzNtQ1FETWZFL0M5d0VxanVtSGtLd0J1V080Q0tFbGtC?=
 =?utf-8?B?OEFMYmt3aE1ZNWRrc0o4NDBnVG9tUjNUcEVYZHBnNXo2NGMxSkNrN2ozQ1oy?=
 =?utf-8?B?cDBsTDZROW96QTZTbEZEOTMvZVRWTWpxVHhNQlpFZlN3M0xubHdrcG0zV0dy?=
 =?utf-8?B?QnY0WDJtbDh6dmpoNHdadEl5YlNGNWJBRExyWWNHSGNYakVaTFphblVJb21O?=
 =?utf-8?B?VFN6cUsvWVhvbVJLTm1IdXhnOE1zaDJ1TWkxZm91eU1pcWNCRjdJZUZ1R1dT?=
 =?utf-8?B?VzBreTJMRTl0aTgrWHRhRUxIR3BZM29OVk9vVGVmaUlhTVJVM0k3VU8wZ2pW?=
 =?utf-8?B?V0FFWmNQVGYwT2lyWllSQTAvUi9Zdi9EWUxXZ1ZHaEdQS2RhQ1dsSFg1bE8r?=
 =?utf-8?B?S1NPa1pWMzF0L21ROVhuTkRWOGFnMmV5VmVFVHZiNnNTNkdQNzFNek9uRzNo?=
 =?utf-8?B?U3REbVc5Yk9XZ3BtUkErazNWVExBOHJ2YkM4UnVvdE5qcnFId09UdUZGRTY4?=
 =?utf-8?B?Z2xSMTd2eldySHppUXFzNm1kU2VoMkVGNDJBK296RzZKNmdHQlpVS1pFbXI5?=
 =?utf-8?B?cjJURDNUYU1FVEs3ekhWKzNpb3FLdGhvdWg5N2tpUmdRajFwWm9ZbVhSTzZ6?=
 =?utf-8?Q?NsNTj+AfI8EGI5lkjsmbvTKhtGx8tQJYLtvM1Y93R78al?=
X-MS-Exchange-AntiSpam-MessageData-1: 6JBal/JpC1HIbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8975c0f1-03fd-4eaa-2a68-08de8bce0704
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:56:53.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir2E3Oqcb74SGbFYhInApxQVxc7V0pWcb0AcGQvyigrmPiERZyj42pFgsmwEl8sIZEdA5GdQdNr2+fHu37V1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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

On Thu Mar 26, 2026 at 2:43 PM JST, Alexandre Courbot wrote:
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
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org=
/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I'd like to merge this before -rc6 is tagged and drm-rust-next is closed
if possible (i.e. this weekend) - so acks/reviews would be very welcome
if there are no outstanding issues! :)
