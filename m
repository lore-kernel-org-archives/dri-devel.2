Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD5C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 23:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945C210E3D4;
	Thu, 16 Jul 2026 23:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AV2fAsDQ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B7210E3D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 23:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJMLXfYhVzsAbKYiTLR8jKanUFwxJ9VyW11YOxBGdPZpcpBZIoxT4BdUBzRxsVL9vLfpL10y+wPs6FQdgXX6wFHFcONFDOobp+7rrJVh24T97s2ls0uBS22jSSPEW5nkfmj2EFSpQ96hefmpDQZfjlcS/tc4bsYx6MVYZZND7hV8FN52WtQX3jyL/177cKAmcU/YgAhGWK6CfEPD/nF6H+QwzLGmEThCWqyFX0LIocEzFaOoMNYSe0pvmOX74nAkxFBWt7vBKzQI81TIAPaMXOGQuGosTrpKQOBjtA7GDAFw7xDAVn+PITJv+E/xR8pw3XaV5wiIEmk0MDscSM8Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVr3ytK8NMRykB9upMN+wey9639tVHNwD10T//b4i8I=;
 b=zGtraYFEKKhgLJ1oYyzWJxK5H9r+JIlTDWhPrTNMkh7ectShjXRtHBwz/8g0wZhLaB3lwUSb0TmlN9xhxTI6l0gIyj9zg3FO63nKEBZN2Pmj+CetOAm8pCY6/NSMQP+1H6xuTEa8zzqbY0eaeWQijItXBpUIQhtBm5lVFJOmbvIRM5SnEq773o4YT/nVfoS4Mny8uV7ZDePUYmiZEoPa9Qpc41xHiYQXQD0bGK6FtqBO7wiTouKpWRpFKaFLn4j0RS3vawWu/m0Zp1O4rnc/Uc7pWKPK8M3U8nhp1kknCK/EzkEXVcWhIh75/XBFnUz4Totqi/bbn8J/Ol++B/BiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVr3ytK8NMRykB9upMN+wey9639tVHNwD10T//b4i8I=;
 b=AV2fAsDQk0taVrCsMkag/S5LKuHcgj5f0z24e8D3z6U1hopW5uhuBc2IOmmWhn/lDGpl6it8XKf1qjGlqlQ/UWi/o1c9FaTziQWAFjX5BErVgBfL2b45NjRNT0/yib74MjBGEqANGFGyUzWfpC4ZA4o1SrKmUawhL2ckdP7NretnHp+EjuhCrB+j1AK9oDrfzFsrJ28cRe9VwRbPMXSHmgLHU2ViJieFhUkJQTa0wXXpAHRB5SeUCdo3sKLNchmTGXZ1anXeSWAW+yRKDIrrJuB0FIglQOnNPxx4fl1lXWOB0xvoZ4YlVoRapACgF75+OwVzN1aN2DpoFW1wOiCRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 23:57:08 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 23:57:08 +0000
Date: Thu, 16 Jul 2026 19:57:06 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Message-ID: <allv0n0_xgE_IpyP@yury>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <alf1lUH0EDf3CRMl@pedro-suse.lan> <algrZLHyYcR2mwzX@yury>
 <aljkXMNLkciazVVi@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljkXMNLkciazVVi@casper.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 919ea4fc-a1c6-40d4-fbb0-08dee395f21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: L81XMNLFIptm5ESn8EIGx7ALwvwN+XXSgwnaB09UiQSzgZvfVJ7TBY2gJ7ne8+D3g1mLGZyXcWlQQs1YpQe2Cgmn3HvEeiOez/VXMwpgJ2r1wq2HNEvR0C97B04wkVnHz55dtRDe1MBlQFfALKhXE17tkQO2dWybknWMfUZwZg+R3QjLFmKwkUEAKCAgzkx47mRFUUcIE/BSl8CLY+KjBYVCHhJIsCuWQPQZkPn3PuDr9EWq2s6fHcHhHjFs4SE+klmgz22o+pX44p4gEA7AOFX1bpz0zHF86XqHXXgDMQXjVTWXvmC0rgmg9sNIzvDASAi8DdH3GJy1Mjeus56cFmJbJXFWpTYLKtmDKCFqlLcV44wRp63a1AVB7hvCoFRv7MrSPMO8a17JM6xmuiuL9ZLZEOQldWc+ss1jNhfewPir6q5domWPdEYc6vCFkDfY0uo9rhrdzOPvN77bo34/V72w+hFcsllvOCYsHEp7D0lCBsJcgA6/kLK8MB2HziMDEbLhab2RMnCutubTW8x7Q+gKNclzmK6QxiANtnsscH+zwQ/cP+O015vCKHPNTqoBMjeZnsaEecUDugpyyEYVV7D9ktWVPp5BCtWlAZ0WiX/2VbyTW3jArG9d54eI6waN59WtFtpTO5jSaRVs9y0a6iwYOPdIxqG0oEAjVyS/dYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nl+Zh4DbHCd7ABreXsE3kLykSdHSLIDIMOae+4g5Glah3nDjv20s8xtUKyt+?=
 =?us-ascii?Q?2cn/D5mYm35BiQZhdvrKBMI+6BCqUKN/zW0TlZPmCy0ToRJuL57vYtMMcQcj?=
 =?us-ascii?Q?156M25qDK5mgQQtFpNwqcMeu9GQImLzfdpuSZGLvx+fX2zQNcz9fULwtJBtg?=
 =?us-ascii?Q?nkmkPk5Nrj7EZEv7m8JYzeijac0Qgfs7bJ0UVNfsaqXH42F7wyHZKwtczgbV?=
 =?us-ascii?Q?w7/wT5CddxRqkQZIB4HAgEgwI1KTIEjlnrB/1Y4wdA73P8Hhgkv0HcbRZ1PJ?=
 =?us-ascii?Q?1bZR98kpISqUuUI2iwo74XJd+2uHdmvY6f98c6V3di/nTvg5x92i9Uiiuonz?=
 =?us-ascii?Q?Z7GvM1qJ62sihtYoJ03HLA/xMs/kVkdVkiEMsoYpmYD7jieCMrIgo0SVwSGv?=
 =?us-ascii?Q?jdVoRl1x4NaGiVkPWetppPDoHJbhipJ0VLAdkR4JzgrtsuJYOf+xZJra2pw1?=
 =?us-ascii?Q?CfURZ9e/NT94dTg2ssdVN9Jsrc01hJxAmMHLBLAugsehF5egabHP3XrYzfIM?=
 =?us-ascii?Q?VFCHshJUtJI9cj0yBIUMqAotZRtsbvjxEwtRM70zdZ+1EZkqtIRWe04Hsn3d?=
 =?us-ascii?Q?nC9if5F03rnANfRd/c7ks1VeE3cR2XL1nUm711javMvvRf2JrSEETbWbkFsa?=
 =?us-ascii?Q?bNUzpP/imwxkxrelZ9vkVKaPSGLUn6IwT2HPJ63N5ZiSY8Ao6vJae6kN89WG?=
 =?us-ascii?Q?855HUmdRAR7wLpAVZ1/W1mfgqUvFmnkmke4GOwWNGXE5yj05TG2QAYsKU5JS?=
 =?us-ascii?Q?eLvt2kS/3/YQdEHJG3pyd68AL995zHor9/rPeGvuHvDzt2fUM2tmyWc6b9cU?=
 =?us-ascii?Q?jznb9n3OWY6DwbwEELSdszsl7Tp3LsMhJI/e1eo8+/zW9F1e9+ywz9zvfOq+?=
 =?us-ascii?Q?DKateklj2g4a4++hjBNvP/ZAEJUKhM5Yili29gi2L762l6DnCPS2q9eK6aOD?=
 =?us-ascii?Q?A7M20X9Pn0ciWMx4LFEOhRW7aX/54T9yBSgJGVSEiMU78Y4ZyEM+RZEBVgTF?=
 =?us-ascii?Q?ATMJ6tLGqxALZ5jtYGEnJ1NL9Bqxqhr16o76gwVQURCyto8Ryysc9VAHX0aI?=
 =?us-ascii?Q?QuxB14lo6ndutbxydOSr4xU/YOmveDaMdkoQowK/ljsi0itAvB1TmwgLzn0C?=
 =?us-ascii?Q?d1H8/IQzZ6/pwZswgFq8tnmgJSrDRyXl7xc4TLz9R0A1cjCkmcRr4dKU+AJs?=
 =?us-ascii?Q?Hu4P7En+Sy+Px65RiRF93YCQ9Ck/XpF0dFdhPQRHcoplsPL6GTwn3SW8Xyj0?=
 =?us-ascii?Q?YgqSmyL2gm4dbm1dKrETxA4wxjYqt67TLBBT0APJFjuBdzuglWY1Pm04MDpp?=
 =?us-ascii?Q?PbJWJVziHV4RkvDdQXAh+Q7+lSi2qol2zCWz7HhC6gshaFFVvMdNlNqL7B9x?=
 =?us-ascii?Q?xPhWZVzBLN0jBh5Vp9f8y/rp2XPK/EPU18VZFnexhPrTOYzIRIPFWPlZ9II5?=
 =?us-ascii?Q?lqCtZ2XfGN6/77feMb+3/CU7K+ETTlPvpTmkmoXYtu2pqq8yDvbiLzX8Y2pq?=
 =?us-ascii?Q?j/PovmPziJESAWT10pS0WCohVNDsatjyigZ9uOT99/w1ATWaZ5tdiin+jUOo?=
 =?us-ascii?Q?qrXVMTxlu14h0L/5m07wAWbW11ZQhMj4fiwS2WruZyLxHaaNA8TRGteoZ5Xm?=
 =?us-ascii?Q?uNZfol/pPcWrqxUB5s3cZnfHpwAxbbwLMOl2NXjhhIfqzImiwKpTaZqNWgFq?=
 =?us-ascii?Q?HqpLGUVmvGdKg/ORqeFWuAxLROOCAjKrVeu5N+5jgl9FQqT0/2R051YLcYW8?=
 =?us-ascii?Q?8CEFY/DfTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919ea4fc-a1c6-40d4-fbb0-08dee395f21e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 23:57:08.6732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV+zjUYow39jxaa0c73yhiQI7PU2zZcVYfXgIhCgAUCT39BYK4yMyeVE2U3wDH478/fXJJWMESE62sTlIzqr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
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

On Thu, Jul 16, 2026 at 03:02:04PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 15, 2026 at 08:52:52PM -0400, Yury Norov wrote:
> > The test is very well motivated by that discussion. I'm not saying
> > it compares apples to apples. I'm trying to quantify the answer to a
> > very specific question: what is better for NOVA ID allocator. Or more
> > broadly: what's the best data structure for range ID allocators of a
> > given capacity.
> 
> From my work with the IDA, there are definitely ID allocators which
> allocate only a single ID, less than ten or less than a hundred.  Could
> you scale the benchmark down to 10 and 100 rather than starting at 1000?

OK.
