Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD3A10E203;
	Fri, 10 Jul 2026 21:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8mfbtCr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BA410E203
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMosdmZ0nWqwh2fGrJruUCgc+pAvZkF6CxdELZX3f2vXEteRmPTWpcH79FAKez1Nrm6imFTmwdLXXf24bV0BlP8TLJRoc9lp1X4gfwjZg7WIv3+SXgZE6aYU6q0cfiUR3Vbj05560h000WFQ70LnOlznvVmjRicVdZx8sacDO2H5hjKcX77i4NGaVHT5Towob4celQZUFlOfJ2/NZlPdoLhOF4Hxqq+2YDab4h/gkwjiB9OO0EcRnKbDUP8VEFEpQSndA/5P6P1MqMq3E/xlxGdKjh1a2jlxPmWmoS29YcaRRSJfrduKjAOBU8SRFIO51N3sHTKElHR5FmanMZvlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hizogt5w1MNi30bHhvAO+HweJmsNfgTYNefPH64mvNw=;
 b=KNMJwcAGpO5FgEpTdfAvVvD4NadEhprbJXiTx8NptdGq+kXECA9ZQ6XobpEiX00teojzKGGv9nKdlwkl6TpRSHiC8904PjRZqqwDaXUhbVSxLnItmakKY6Gb6K75wjKFY48lskzfKJAbhtopZTfHPUAsr3fyG8W5osBNn7K3kSAssHCowUXR3hfd2fMF8EkzohgEYZpKwMehrq97lU2/KFCdb3vuQYeZ9o8oCNfGVydJT1NS7Dj2473nsvtXsZEO7eayW71VB4KCMyqD6F0gqassXB0ESQRm94yXwjeSTEqq2RLhzMY0TnUeBDHPS9ShmLbVdbRRfEMxceMK/a22ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hizogt5w1MNi30bHhvAO+HweJmsNfgTYNefPH64mvNw=;
 b=e8mfbtCr2qkwWlypgGR64RFzEl3vKftjA+eN+ZZ24x5+RQ5lGlUb1eYy1ZrGXcoSuOqbCzxrnSmMLRCKXKKnxKm7fUmhSIxLwHv3vfNTYQMD30OauzvzJp571mXwnStAE/tDydxl2ypYEKB2BFJCELaFM4+ZqQSA7JMhqL5Qtqf4xRGvOn6qshJsK1f65Ds9MpfEq8K8Bpjn8dL8oOmyunBjOOmqMAGxWBK0wDG8Qp2YyJdh8+o97jHNIMaIxHykdHdxyRx4nQCnqBMsx0Fw0QRKlmOG3pOjOwkpZ40ZpEg4zK5f8XTo43U18IID2xv4IRCYxfNiT5EWPKZqeEmV/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 21:29:41 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 21:29:41 +0000
Message-ID: <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
Date: Fri, 10 Jul 2026 14:29:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: add ChannelIdPool
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 Yury Norov <yury.norov@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: efafc217-91f8-4d25-d708-08dedeca5a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 33zdYetUtXNW54HUuHFaMPpiqKXb6QrOgmvp8+6zs1DEZk+Nh82mJxrulnNitVoQa5HSWMy2Km5TVXzrNz/Zt2sdNz4U+UVSjbGJ8qDIGga1LfBCE7yxlMBP+3JeGg32Qo38N3o6gzALaKyz84fF0JOWCKZ2nRbCMCMvHIf4U2V0o3UfqHE+aHUbvsXeNT9CUVGcJiOy+rCt5WPriCTzCMlZ4WXlai50Bz+dZea/GxJfYP7yTrMKrO7W2buuVj3j+lCdiYaI4oWWmDFLTuqtbABHL1ONozvvyWT8mKebwnMo08BuwkfOXIuUL/2A05qL2Qod7Xm7B9vwhnNJ4PaVSzn6YNxrTxjHurwEWkRJylxr8ZFzIalIs4rtFu0qIU57GSL7A3CWY0ZE8C+UFiN+qE2XehX4VfioJW7KlfHap8fJSYRMZ8c8q0AKZB/oXH1D1ZWBw8wqkYNRQXxLw6XkqL/awb3NsZAd57Nc8vyrb9Xr9mY/ZqhQ0kKc4HbREP5xDDfjbWtzF6VW6pMag9Afsg2/KD2d6u579PUwhMY7EosKSytf++h++Qap9/RT8OegzVjcs2ZOdI7dZAaqaLGFKAiI+4+cmTzMVbSWiuQG6wP+JzXfHl9CWo8GenVWi+tagnw8fx+kpYSeej+BDf2cQoMjcuUsBGKOJjX5TZ9ElQVOM2esXUUTXXuY+Hi+bG8itZR/GKpScOkk/WgXAxF5qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFE2RnVsWVZ1UkkvYTdUTThPMEpaQUtwektsRkRtSC9ZaGMrNHJ5anNSR1V3?=
 =?utf-8?B?MWpFZmNBRjFNWGdGd3hUY2VETlIvcGllREhLeDVzUUNpRHF5aTE5aEFTSjl5?=
 =?utf-8?B?NDR5UVNUMHRxSmVOUWZtb1ptYk1Ud0lxQk1jOFdDT2VwTVVmRGRkYVFORGFy?=
 =?utf-8?B?ZkxISW1GNk9Kb3RRUEVDTjNLR3VhMm9UbjlhZTJpSDBPVk5vWm9EOTJPSVlG?=
 =?utf-8?B?a3pHRDhodUVSUjZzT2dlVWdUYWUxTE9HWHV6alE4aHFHRlM4SzBUU2pQV3JS?=
 =?utf-8?B?dEMvYzl4cXdrcitYVDVHb2lVVURIc2o3VVJnaDhwYXVsSTdaN1pZR0h3aG1z?=
 =?utf-8?B?MGF1dHM0SElSL2x3Tyswc21CUnMya0F1WEI0Zm5OSmFuWGpjRlhJMitHN1Az?=
 =?utf-8?B?eUcrQWlGdlhIRWlJZ0VpUk9CTklOTTNzZGcvaWtRRFRMTVVDU3ZtazYwV1F6?=
 =?utf-8?B?RXZhQVQzd0F5YXA1V1RUSktNOElkT0N0bThBWTZGRFBYTElkbksvNVZGZDd2?=
 =?utf-8?B?U0JQTEl4OUlBMyt4NlQ2RWVSMThtR0VhME5reHl2SFNmZGJiVzNYc1QwbU80?=
 =?utf-8?B?TEtuYmhEMWFnaW1sVnlJbnI1Rzd6MEZtNTRTUnY0U016dHRyaTRvdGxFQXVO?=
 =?utf-8?B?T2tIZWVPQjY2Y0dvb1BncTNqV2ZNTVMvY2dVblhCQ05Pa2lyYzJBVTJldktS?=
 =?utf-8?B?bVZON0VBT0VXRFQ3WGhrMXUzVURTVEN3ZE5ydDZNOVNvckRQQW1tb2JxVHdn?=
 =?utf-8?B?WEptRmlUWWdDQk96eDNUN3VWMDNvZ2dwbnBTK1orYjdFMmhKRWkwWnBlc1Qv?=
 =?utf-8?B?OHVrdzJESTZOK2ZNTkYwcnVZeFhOODZRYVJpRUt1Mm5sM3FkcnpZMlBjczEr?=
 =?utf-8?B?eTZEREZDRWJZRy9CeVdCZVlTUjZVSTRSWVY3R2hqTHRnNDMzQjZCM1dPOEh4?=
 =?utf-8?B?WlNWbFdGWVladlBqL1FvMkdQQ2FaaUJTVGx5b2M3TTYyUWxDU1lQUVk3RVNr?=
 =?utf-8?B?WlMvUDJlMzdrWW44Ti9jblQyZnJsVFpQYWJ6SXlaY1JVSnpIRHRJNlE4cGtF?=
 =?utf-8?B?NGt5bVVpUUlycXJmRWdkWTNMS3BwdlFWODQ2c0JSakZ2TE9MUENPYkNoQUdM?=
 =?utf-8?B?dWFKRUltSmdCcGM3WFEvR3RNdTkvUVdDdFFVQmZEbit2elZFYTVFekNkTDAw?=
 =?utf-8?B?WHR2bzdPV09GTm4yZ3VBZ1E4Q1YwRVU0WmJndkhxTHhqUWRIQ0JoNlByTDYr?=
 =?utf-8?B?K2hLTmd3QWtHNWZ0RmM3N3FWRXlWRWhrWkc1QlE1Z3pXbmpMQS9ZUndqMDN0?=
 =?utf-8?B?b3kzOE1MT01QbTRUZXdDQWtyZUJKU1ZtQlBRTHQ5dzArSmdmZ3ZoNlF0OEJk?=
 =?utf-8?B?QzFTeXVrYzU4VVFWaEJkZG5pNkllVUt4UXVDcC8wTTBjM0tNeC96SEN2emV4?=
 =?utf-8?B?SHZmdUxGK1RJdjE0VkczUGdwem9DVUkvbDROT0lMZlltSFBjZnFFRmVqZE83?=
 =?utf-8?B?N0NZbXlvbmE2Mi9LNjk5WTFZNEtLNWhycGJVdW1oRUdFM3RlVllWbXQwV05j?=
 =?utf-8?B?VFpVNHBnS3NoejRsTkNjdmQ4VGNYbEFJOWJETytoNmE5M3F0dUl3YjNEOXhM?=
 =?utf-8?B?aHkzV0N1NlZRVm5SdW1KWWtRQW0ybVllL0FPM0VUZjVBR1RFZ1M5UEVGbVZ1?=
 =?utf-8?B?NlgyRDRvdzdEVW00d29jL09ZMmxrUDcxajNpMmcwNUtDMXRMcFd0eStDeVRp?=
 =?utf-8?B?WGVSR3J3b3JOUWxwV040QzZmODhXZGlmcFJvb0pqUnJXVkd5S3NYMW8zK0tS?=
 =?utf-8?B?SnJibTU1VmJ2QVpNL1BveDFJYWJteXB4MkdLT05Sek11MFluUTgyV2pMV28x?=
 =?utf-8?B?dWNRWWphZEJhOElxZ25uMForRE1wNGRyc0M3RDlQRyt6VmJJL054Vjh5M3Nk?=
 =?utf-8?B?T21HNnE3MG1LTlFyQ1U4TnVadXkrV21LMUlmTXhzNVl3REVzRlRIdFFOcCsr?=
 =?utf-8?B?MnNoSGx0YzBiQ3hUSkFLd1ZBYng5VUNCSTVkUjcvaFRQeUZldk01aCtreUdu?=
 =?utf-8?B?VGRxNDVTMWg4L3pWcGw3WWxKZnBqUFJJRGN5MDc4cTVMeDgrZjdoN0kzRzd0?=
 =?utf-8?B?ZFA2SDVjRVU5UEUxbmN0eEZ4Zm1iNUNtaHZJR242R3Z3eDNBRUp0N2tNa2Jo?=
 =?utf-8?B?bjZCR2F1NTRVUTYyMGhqYW1JUWNvVmxaZTdmTmhlNm02WFhYc0ZYVkFldUNo?=
 =?utf-8?B?ZDBmakRDanRyVGhtTk51KzF3Uk9RUzA3SjBVWDdVZENlVzdERG1QYnFCcnU1?=
 =?utf-8?B?c0x5K0J3VDFPNUExMXlwUm1FSDN2c1ZRbGMxcjNrKzAzVllPWVRNUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efafc217-91f8-4d25-d708-08dedeca5a41
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 21:29:41.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 688y96DUcJIZrrHQraPYX+hoQOrfXm1WKaP4IwhejLI+ICCi3BUi4kh8PHU4RQyAdu2g4IyWb3H3waWOX5+fxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

On 7/10/26 6:42 AM, Eliot Courtney wrote:
...
> +use kernel::{
> +    maple_tree::MapleTreeAlloc,

Hi Eliot, Alice, all,

Eliot already laid out the maple costs (the alloc_range+erase loop
replicating find_next_zero_area, the extra mutex, allocation on
alloc and free), so I won't rehash them. What I can add is why the
alignment is a hard requirement, since that is what seems to make
the decision clearer to me at least.

Pre-Blackwell, USERD sits in BAR1 at page granularity, 8 channels to a
4K page (chid = page*8 + slot). Giving a VM its own channels means
giving it whole USERD pages, so a VM's chid range has to be 8-aligned
and a multiple of 8. Blackwell moves submit to a per-function doorbell
keyed by (runlist, chid), and the constraint goes away. So it's a
constraint we're stuck with pre-Blackwell, not one we can design away.

Given that, the bitmap version is hard to argue with. The aligned
allocation is the one call the API is built around, roughly:

    let mut ids = self.inner.lock();
    let area = ids.find_unused_area(0, count, align_mask)
                  .ok_or(ENOSPC)?;
    // area.acquire() reserves and returns the range, drop clears it

One lock, no retry, and release is a bitmap_clear that can't fail. For
2048 IDs the backing store is a 256-byte array. find_next_zero_area()
is also the existing idiom for this (IOMMU, DMA, IRQ), so it answers
Greg's reuse-what-exists point as well.

I'd go with the bitmap id_pool.

thanks,
-- 
John Hubbard
