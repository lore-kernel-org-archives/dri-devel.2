Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1DCFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016D910EC00;
	Tue,  5 May 2026 20:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZbrvaWZd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E5310EC00
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSTuJxpcBC7obqS18aNzWMB6NwrSSCaXNbGli/jXqAPA8un09AjxSjflZH337hEGOG0Ssle1NTinYW/H3HJINNtcCynbeB1qaXqp53VBuLQeB7nPOZI8cV6lRKr/PvCN8Y0kQ1Hk+oQ4bC31bgTvlvdLohj8bp+pmoceiecDhABcYXi6/wR+DIOuJOHU7j1Yk6uqnl8agz7wygygxL23SotuTUWYdP1I+ZhcTg2g3rM1F+eDicL47nMU1iTz6zlh6psGFq0LTsFoivAH79lb6FwaSgE3McW6eJfBTpHr3INZbWK2CL+UQbGBb2MM8XSHfWCq1F8wfaflxuK/MYblOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIgD1P0flfdgKeWvCw43weU/MCWRkheFuaOVaZIWBjg=;
 b=rg9q1ny2FJWxmj5SzFU4hF+lMQhr2/FsmlnRj9vpKdxwpMbrcN7pdPU756SgcpK97gSnyVy9nSInrerv3G6eM6cgAsEheuqR+ElxLUTo9fxGC/h8+Hl9sQHhrk24ItDyEMU+oPIZbUdw32ozuvu8Z0k1AgBO/6cYoyqtY9itqgFzFG7hKLvW0bzoC3faFRzFQnpHOEzXq2K3pSXdSnGzgw4G3zSb9BXsVbqd2ThZ8aAwEM9EqHeWTwGDg+cel6+Kl+/pYvXAqAYaYIR0oQxjV805vla2ciaM8rfK6hyBhuNxbsWXQHw4dgU7BsVuvv9f8sjosW5HXt7b8YGJ4Nu9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIgD1P0flfdgKeWvCw43weU/MCWRkheFuaOVaZIWBjg=;
 b=ZbrvaWZdk+nk6xfvZQPIFllklwMTjXy5FeGpYOfNTd8ZUE1bxUDgox8M6CPBFlF5VNgBByZ5zZ4J+wQ/PTUUBKRhb0VijtNMnth3Po38dAuFc0LPYbBpvOniGLhhvbKu4LG3H3f5mR9hSBy38Bef2TrMzMpYJl945qa/TSckcTT/0zyy7SMrNuUvg13GbasrwOtqM73F63JOyfFUNJ6NoFkhCeqQXbCVqzeoQJxD1HT/bkW5Eu+Mmu7YGuNbC1hXvIwGByYK1vy3vBMPPdbIMpnOGzGmQTwv83mWyxUhdh35TEkPXVxwachNENIlNQ0/NFPbDVfaetXkSPl0AWuWiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:17:31 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:17:30 +0000
Date: Tue, 5 May 2026 16:17:29 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 03/22] gpu: nova-core: gsp: Expose total physical
 VRAM end from FB region info
Message-ID: <1778007695.2a66b3f6fbb60d25@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-4-joelagnelf@nvidia.com>
 <DI8AZTYWPYK0.2U0NV7Y5V9CCB@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI8AZTYWPYK0.2U0NV7Y5V9CCB@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dee84d-c113-4068-23ce-08deaae35572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 79eNcPvGAUxsNyUz6N7mk7ffViDdhcsrjH/HQR/gDrQ2IrmcQRz5XWXj7OHLXcSXj/7tHSRd41DQOcKwNQOEnKwn48lRvWr4OXa44+Jj+kYXhUhDSRTotE+rsk6VtaKXdJWw5OXrm++5AzJxBBRKAs+KgainLGi7LlkFPxUVxWVTnimC9CigCDVCX9+E1C0PkXd2AkF3NlbfUWPxkhbvehASM+3xmQXTxIU55x/tQeoUYkXZg0RUDFqkRpk1N0QeYbMDQNn5mAmVEYRfkuPBVb9LV8mQuF9plQ0JvA/eY5Z2HP8qLnNKsvwB67MYNmdy6pIN+G6beFJIw3RqDc5YmMi4mprw45K13UKNFrAImwWs/PzV2TxvOM13X3BKS+el4DXG0OqS83RziiQ6O4cTy3RfVRXcgzgY7ZMvgG71CsSuNwSeJnSCjGn6DQI4P0hUC/JP0kJgMyJuB5wmbFf8R9NSvvMfwlt9x/Uk6JUlmcJXNwJK/AQE0Hjf/+M8xPHyi+VRYy3Z7t7rqJNDX22KSXeiNpZ6xvx0sM+uobec7MYF05ceKEJP6CmZSKoGsOgNDOKza0q/iGeJgPo6/H8M+W162iIS2422mWlzzNvHA2Om9nV1y0yCvuE9LC2pI0m8zgtrgDDh/kzDtvrCO3LteEtfE7Iz4Aoh3E3MYrGQNoouc0kofUcPrQlrJdRwaAkX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMJkafk47GJkF2Omrl0+WnsoOrm6ZCBQxTKs0hNlCcyz783leDqO/59IaVoS?=
 =?us-ascii?Q?v+QcBwGURCJes8jrkyhIG/p1w5JEIENCU8qNmNGXH+0+U4EmTcbIopj1J8iY?=
 =?us-ascii?Q?pfpQfmAqh9sHpigSqi5vCcxvLEsZAwKfkC+3RfELV0pG/eTvRbEJIvW/Su6x?=
 =?us-ascii?Q?s1HX8LpNl91WALNUXI/qqpaWCDhe4GR8fCN2p7n5YiokhSyq+mlaml/1Mnhy?=
 =?us-ascii?Q?GEFdOFfMMG+7ptB62IXK70Tgd3SBZNnB8fOQq2iUBhiUxh5awcqDUUyQ1S+C?=
 =?us-ascii?Q?LRtlnoXyMDHZ97wSvN4FFyh2It0Qp8U41caY9E+ltOpVFlS5GLx9M4VDVuk+?=
 =?us-ascii?Q?0tFZg41iIK7jwRFhxbXsVgvUvbDp54ftIgYRiylHUeWc7qW9SoIGoKiwRtF+?=
 =?us-ascii?Q?yoxn+/MZDEZJZxD2WN1O4R4ymlkHdcTmu181UNqWLbbVOXbytTOKddd+tJPU?=
 =?us-ascii?Q?gEJ3qfeB1CB/1YFzdMr9PFoNkollV5mlzXLwFdCXAB4iC3PLmOHgaJ60Ry+j?=
 =?us-ascii?Q?OPd/WDCIREDm3gRCVhWip0kFmeCtKqctUvoojN18ACK9ovnSd0hETD08VEt3?=
 =?us-ascii?Q?zgRNmJpGddjb0y/XRGJvAwZagZ25Tlw0CxZJoiniBD66sD6W2kaMcD0kBQun?=
 =?us-ascii?Q?oVT2hAyRZ2BAknlZIDbTCYz1Szt+o1zvtfwP7eUONLq/FE6w/WdWt8QqW0bj?=
 =?us-ascii?Q?/J5kRRpsm0GAN3a+sgF+4NaRi6ZVCbq9YUrtesuBY0+/tgPauMEcrTBzVdib?=
 =?us-ascii?Q?5lPAxvA28ol8TyLmJTy2zvy1eDdYlROQRan7CDoKxjvz2pnqyawAwPFyOXZM?=
 =?us-ascii?Q?+x7iSUyrP2oOnmYrY4Xut5g6fGO8Sh4Cdm8xWXaOAuj9QBi8nViqsBsfoSMq?=
 =?us-ascii?Q?n7Ic+dbaIdpJhJ7hHaRy4hZ0AgmLgy/N4CDRO5dosGmTxYsg0dFkYW9r1h1/?=
 =?us-ascii?Q?ebXD6tVqKLWcCzSIsc0c3fvW0ec2mG4bvdwDx08kI09Rxcfm9n4zPIqrj4PS?=
 =?us-ascii?Q?8BZjq60fRWhZRK6LG0J4J1AXAwav+G5717+qnWBgdXpsYfIRVdHvHSt1gxoP?=
 =?us-ascii?Q?zL5Vb7BneaUe8fLLlXYesWJ6IcitGzSBtgP8Z+NpApxmx7UATU6OkzA3q2GS?=
 =?us-ascii?Q?hbR5lzkw2CeqjjWnNVSPja4qksOFn2NsL1MQgp3hltZc5Vw9Xse57BsK8tCt?=
 =?us-ascii?Q?Is7ORxk+UMr1mI8FPIf4I+fNtfdc/DyoJbLD+o91IUCrQRB+8Y0JSWHNyeXS?=
 =?us-ascii?Q?Cw+G3HCWXbmnfYTGif80RfzoQngJNfLEzc/Sh28Ni61OadVyjpFI0jVsbFOi?=
 =?us-ascii?Q?X2MkufQyMxyGGwlJWzv+MMuOgv1OsFz5aV3YZ5Wy6oJodLwhHb9i9AId8edO?=
 =?us-ascii?Q?nvCsLe9hbDJEtQcex1e01KhQIJXDD+0XF3PMbn820u3KPOqStNjqVt4bH1SR?=
 =?us-ascii?Q?UqvXPOmyvsqo94rUukh+nu9EvhuHNrduBzm3B0bmMrA3yeDZN2WOhc1D/ug0?=
 =?us-ascii?Q?H+g2nI5Z5ib050Yi5DUCtOUl4Iid52DPqiRNWcBQGUae26x54vpQKrwveYsm?=
 =?us-ascii?Q?RqgUJafAsspGELTOE6xKYNQ+t06zDZzlDvTbAXpl6fqEYcFsvFoebNbV9Rds?=
 =?us-ascii?Q?5Y4SVsyRPkxo4/p66EKT5gNr5T8jKImv0/kcCmKVPd/U7I1Wszxg6BRKSMC8?=
 =?us-ascii?Q?6WAIo7ZCZI7qnDgwa8W1B70zyJTpN2oP3of/oL791SbHe8OHXxCt/PLk4PDf?=
 =?us-ascii?Q?7QZCaQhu5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dee84d-c113-4068-23ce-08deaae35572
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:17:30.6714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHAiC70/e5IRluNEOn8ZAI3lJUIihzcFYVjhX/GckM2awUYe/XNQWMaLPNHuTqXDbzCJ1GxPpjPMiBwzU2+svA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
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

On Sun, 03 May 2026, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
[...]
> > +            gsp_static_info: {
> > +                let info = gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?;
> > +
> > +                dev_info!(
> > +                    pdev.as_ref(),
> > +                    "Total physical VRAM: {} MiB\n",
> > +                    info.total_fb_end >> 20
>
> `info.total_fb_end / u64::SZ_1M` (after importing `kernel::sizes::SizeConstants`) would carry the intent better.
>
> > +                );
> > +
> > +                info
> > +            },
>
> Let's use `inspect`:
>
>     gsp_static_info: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)
>         .inspect(|info|
>             dev_info!(
>                 pdev.as_ref(),
>                 "Total physical VRAM: {} MiB\n",
>                 info.total_fb_end / u64::SZ_1M
>             )
>     )?,

Both suggestions applied.

> If we combine these 3 first patches with the series enabling calls from
> nova-drm to nova-core, we should be able to implement a `TOTAL_VRAM`
> argument to `GET_PARAM` that would be the first example of an actual
> Nova ioctl using real information from the GSP (granted, with an
> unstable interface). Looking forward to this.

Sounds great.

thanks,
--
Joel Fernandes

