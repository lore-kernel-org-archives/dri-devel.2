Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D002CD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC4510E2A1;
	Sat,  2 May 2026 15:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTAQSQd4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCD410E2A1
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5Fkc3yZgZ5bGqkfBXUDaz8aqGew9fhD2BjygR4j2ivhX5NLviB6Zr4iA88gclUhLFmyueytJ5cPVjMSdHn2APwu4yPtMOijkhKjyGq6B3kprnS80L+1XQ75BultI9pGdAr0VaH5sQcemW/PEEZm7aVN4hBWtYsOgyDSboz1iywd1S9ylAhCjDHifDEk8kmQnkKb7jkHR7OkaQbv865ywegfTMS48BDRyIAjFugjnmyOObS7G0RWWr8/VMk9mugle2iMC+GJWxh/m5fO02K3js4TG2IBqC1+ASU01PlNHzNXroDMb9e3d1qWRlgQjeylrMj9AN+YFTIepgQq9ruqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2dFRfHPmsRCMabAmM5WBq0wwuX2JPjhJHKTZdYdApI=;
 b=Ej0J4CIuwmUjMYOctI4zMSfhDbm4F6vcSwbfdHT+rLkK19iR4jt3pE+VyWjpRTJExtRfO96lzNH3I/XI0pUirzU7Jt+ALSMyqtV3VIqgARi/IHJin5rOGke/kc9A1MuJW8c18dC6Z+Mwwvlz3GNuS5MmuioWaIS3mAuDS25MjcLv/FlZPLwjM/KBZ+cUvNW0lxRA8qMOtobQXTFPoQ6QHV0kaWqb5eIn1TdjNKMHgV4MW6QlGBvfgmFahkOETINSXcxpkyP1jrrI/r7sNXQDknVPg2DzUbHEJK49rput3iIov21sJl1ECkIUoXv2cq929Gbi9prBCDzstaObU7efoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2dFRfHPmsRCMabAmM5WBq0wwuX2JPjhJHKTZdYdApI=;
 b=CTAQSQd4O/PFyFqrNM4Ll6ZV8MYBZSZZu0FvihhfY4msxtXtXcNJ2lzLz1W/kvRkYIuNzUQRjUWdwMwA4AfGnl8q6rot3am6Cq21C3vb5mFr4aznZKTdU908WeOnWLkfNRUV61qyqKhza9gaEePz0zXyxxuWhR1S99kgsq/j37la2vh/mmEgcPQr4tt1B45Qz78mA6K6+WAvDfHtNpOKGo7ewgNygz19cXfPuatWalLrZ17HwAdNT9mZRhKDqasTkFOjGiK5L8s/PCkvArzbxBZJUD6LMJUS0rAZtkb+vQ6sLBuRQHMfdsqL0VeiEcr4mTtMPFOuFjmo9wVtFPbvOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:57 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:53 +0900
Message-Id: <DI8B0RAI4S86.2K4SLZH2YS2W5@nvidia.com>
Subject: Re: [PATCH v12 22/22] rust: maple_tree: implement Send and Sync for
 MapleTree
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-23-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-23-joelagnelf@nvidia.com>
X-ClientProxiedBy: OS3P286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe8517b-de9f-4da8-8ef8-08dea8617b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H/9VsDPrNJ4nC/VmBCo8i+yBjILAauUxg4f1aIeL8XTEii2VspwjRPoIIn00xxOCXHfky1GvMag9k8pT+3eEwv9ymdoTlVO/UcKZl3YwPIjyeaPJgQsQx67GqAWzfuNp+KX4FY9idMg7KHDsV82ijKmCnziYPDCDYRew5eLrUHz4mwbyD8Tt51hxpGJxzD1Eewdtzbz5JuFDruJiawcc8Aylb4IqwSAqF5Ix5adYLawBpDfdIvgnSCv/iTi3qctAhIcM3kesFAAqiAG8wEgWf7ZrzmoC5wQTuVqdq8+6oJmOxX4s8e3tRl4YNaarNqWlgMa4t5e/1XjK4agCqzYRg9UKecLnbFGP49rkWQowsq5dPTFWmX1RAtvNCUnGrR4ItnozACJgnGnN+75DUESVycaCqW5qclth816McjCL1oqzp1O+yCozSxBG/Wp/XFv3f9CViLgz3T+/ki5CJeMYS3b9MQ9Sj9sEmeApUX7qTiAmB2cDDmW0QIyKgW9iNQyBPEcjUUFnu7y1e9z0G2GdyMCladFbVmun/YckRY7lTzzKoRjI4/vy2F0Dwb6X4ItQuS5i/wmr2+RcPsdJr9xBoipkQcDl6qCMS7l+J6eSrUzYx37h4RL5NlVR2gigEfaxJcwWLh5v1KK5F23wqA1T1ORbi0TX0uR/ORfuV/WaevILT0DWDAKahcPjvXl5q4QV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NZTVBodE1hMG9qMzZRTE5NTjFUL1VXMlY2WkhpTE1qWW1idUZza2lib0Y5?=
 =?utf-8?B?SStFZUxhVnlCUGJOeFRZMDlaVVp2RnRkd0RweVZmY3cxQU1qYjUzcW5YbG9s?=
 =?utf-8?B?SjlIZ0ZMNGx6eUdFNU5lNzFJdDJBU1U4NCtQMVJvMDhKbThQVkl2b3V2Yy9S?=
 =?utf-8?B?WWZBTFdIZGRES2NKVVk1SEVwT250c21ZeXREd2RrcEtlQmQ3dnpxbndNS2Ru?=
 =?utf-8?B?YStQN0NpN3N3a08wSDlodGFwNUUwTzQ2RTdHbHNMT3BXTVF4V1k4bHFxZmcw?=
 =?utf-8?B?TFVpKzEzVHlqVjVBNzBac0t4TnhLalAvYWQ0eWFSemw5b3ZUZEJDZjc4Z2RJ?=
 =?utf-8?B?b0Z1UHI2ZndWd05mUWZnYlhTSnpRVWQyVjlyQnliZUdYNDVDczI1R0xMMzhE?=
 =?utf-8?B?SGZvM25xbkFVbExlU0twYkdWcDFhU2Y1cVE3U0RBdGhPSGFnanBLcG96WGVC?=
 =?utf-8?B?TENJNVNBUy8wbi85ejc2S0VUNXJLengxbU12ZUhCSmsxdTBic3RJNW1DTzNI?=
 =?utf-8?B?QUcxcUhXQndMdXhVVEdnbWpxcmxpdDY2ZFAvZmN0Mm1TeXJERHc2MXBxalFj?=
 =?utf-8?B?MEY4cEVXUE5XZllSZnRidHFsY0o2SFJlV04yV2lWY0d5NGl6Y2hheUYyMTN6?=
 =?utf-8?B?MmE3bjhsejVESnFUNk1YMThManVIZW9mb002dEJLcUdieHFuSTR3Q2g5WGw5?=
 =?utf-8?B?dmlwMjM3Sm1pRTkwRzd6MzJFYmNTbmtYRWN5OG4rNUs2aXdUQkt3VnZKQ0lJ?=
 =?utf-8?B?ZjhFN1pSVFJyWmZQb3N5WTZkN29nUDhlSHBrYnBwQzJwNUtMVHlHTS84NmQ0?=
 =?utf-8?B?b2NrTnFCLzFUQXZkbmx4MnJpMkRxUnc5VE9WekU1cTE1ak0vckh1ZVFVM0ha?=
 =?utf-8?B?Z0tpNmZPZDY2VmJLNW8yUDlXUlpKZk1xWC9iUmg0aDZQRnJmWFlKNGNqc29j?=
 =?utf-8?B?ZGtFNklKeldCLzVreitWalBLMkkwS0hRTlRackZHaUpvbHRtOVN3RWxubXJs?=
 =?utf-8?B?UHRGYmh2TG5CeHVOeVhyczVHcjhwSjE3VzZiUktHZjN1RlE2azNiTk5ZbUFq?=
 =?utf-8?B?Nnc2RlZPeEJUVGFHT3JlU3dlVWQ2Uzc2YjU2N01ZaVE4dUtqUHhRZStqOURa?=
 =?utf-8?B?OFpDa1R4bFptWmNCZWJ2aUwxSEVrRG5MSWREenNFNld0OGFlWGQ0bDV5RkRS?=
 =?utf-8?B?ZUtoQTdlZVFLdnFzUmlFMjVpYnYvTktIWVZMdDBGdzdHdld3WjVYQUpOa3Ru?=
 =?utf-8?B?S0FqQVBDaUFEN1lyYzFWeDJGRHFCWXpJZGhRTm9OcUo4SGRya2VYa2tXenBW?=
 =?utf-8?B?REQ2K0FqSi9hbUsySVBrTXZPbHFsN0djWnRhaERlYWhHNFY3MVJua0FMdWhx?=
 =?utf-8?B?bVA3TkNxZ3hCTjJkKyt2dVF5UG52UjcyOXdoM2t6anRvY3V6aFBIUW9nZyt2?=
 =?utf-8?B?UU1wT3hPc3VMUUhFM2cwL2xXUjI1OXNjTWRNYll6cGllTTQ1dklqU3ovb3Ny?=
 =?utf-8?B?eC9NOUxoQlFObWNIYjJLMmZQMU80TlJsczdFVHFrWERBZm1KZW9BdjFIM2dZ?=
 =?utf-8?B?aWZGVFhHbzF3dWhKNjQxci95T20rL0M5N2tJaEdEREl6YktrOGQwUHZTc0lo?=
 =?utf-8?B?UlpqR0xvdFdZVFRmVUwrUDN1Q0lRL0wwN3FiRDFDamtJaTk2SW1wRk04Nll3?=
 =?utf-8?B?QndFMng3eFZianhkNCtJR0RBbE92UVIyT3dlRlFueHFFZjZ3UmZ6ZFhuNEhL?=
 =?utf-8?B?M0RQd3NiTnFpeU0vaVRVckEyMTJOT1BhNEhIa0xZYS91SHlVZldmOUt1L2o0?=
 =?utf-8?B?LzV5RkJNL2Iyekx1d2cvUmxPaW8rQmJKVTNHWW5wYml0UldtSjByYjNTOVRh?=
 =?utf-8?B?YysvTVJycUl3K3ZwV0x5K3hvWWlCQStSRVpSZEp3Q09IQ0VaOEVzNjBpNlNl?=
 =?utf-8?B?bFppcWlIYVRvL3d1aEdNWEhHTnlySTJzSXVyc2VxSVhsclRPNzUwZndFcC81?=
 =?utf-8?B?aVdLdTQ2WGE3UkZ0K1J5ZWh1U0hvM2pWNlBIb3RPaFF4djEzOWFaNHpvSGx2?=
 =?utf-8?B?R05pUjd6ZlVLQXJYaTgrMTlheHdEYkxvdWZxd3Z4UkdFL05wTUNld0FoRXJp?=
 =?utf-8?B?UVgzMDZzMzVlMFZiZG1KVUh6em1ZZDFsa3R5TWIxanB0VHBQN0dHUjQwUXp6?=
 =?utf-8?B?clNFU2g0Nzk5cjRDeE9HZldXUkpYUVNIRTNNNFNrSm0xd0hLbldwYS9KUkdB?=
 =?utf-8?B?eXUwaGF2K0F4M05KbllqdjJrdGkxL2NXWlJ6QzhKM1h4MzZJeGdCUHVLVnh1?=
 =?utf-8?B?NEZ6Q0dUbTdDblVyRitSK1REV0x0cTFzSTdIZU5GbDVBeFA2Z0FjM2luRzJ6?=
 =?utf-8?Q?1I5vPMva8AbCjFIjJDZRURt2USIk5fJxyS67bLXnb2tP2?=
X-MS-Exchange-AntiSpam-MessageData-1: qxV5ZkzLn6JR/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe8517b-de9f-4da8-8ef8-08dea8617b74
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:57.1351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mv4pT9yq87lSV6fTgDswTXrgeYDm1+yB0mopK5BItJv0pWJqpnWbrlk2FoQVPr9Il06p9opjv0no2Z5m9/QGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> The C maple_tree struct contains a *mut c_void, which prevents Rust from
> auto-deriving Send/Sync. Following is an example error message when using
> MapleTree in nova-core's Vmm.
>
> This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaC=
ore,
> causing NovaCore to fail the Send bound required by pci::Driver:

This patch is not at the right place - the last few patches of the
series won't build without it.

Besides you have sent it separately before this series, so just mention
it as a dependency in the cover letter, so reviewers can pick it up
before applying the series and not witness it breaking in the course of
reviewing it. The cover letter already mentions the bitfield series as a
dependency, so the same could have been done for this one.
