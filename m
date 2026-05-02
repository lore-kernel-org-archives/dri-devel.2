Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65719CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DA810E296;
	Sat,  2 May 2026 15:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWYLklrt";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C05710E296
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3ACNMg1OPRQTHgLL5Q6j7zAzBpTnnRF2WoPzDQ29Uz/GcLSfwmweGH3S7ZH6MmZfTEvNYNUWHeChk4gGFseJZY83DvcMgy3t/TpZesmeosWF5vfJgYlb86wDjTE9Jqn9TsbYCjVLOtJ9L5OsIvEEbmHBDgb69fSt9B7AVquRcoAcZIRKz/kmpKWDSOtHqGJJe9NDiSdZnBVYr3t9qN/+4Ejeev97VEP7VAd7CEVDtVM+xavPMr5FgaQQSS8jgXbHj26uRvSSu37YOKEnUqabWVOoWsAsceSThMc/4xh/r0+fDc8Fyt4ZAw76iIuoDMYaTU/OM7BAF+87BMvo0KysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnTPrAJ/Pn9XF8e51QQouXP6XhRUlwa6eDr5MK5Mmns=;
 b=vRbrSzCUZSDFl+yORs8twbj/0ziaKtfVqB/vbrAxW+FA33FIkx6rIoaNvcR6U9daU2lE10M/oVTbZgNhCp88hF5WDtxJExokuVHFaXbr+9WopF5K8OsjqJD3PKcc1BDJYKIXfMfbmYHOrPpwBrRhsP/2JIwLyZsBG9nSrJOtw/GP3RTU8a9ASUXBwwDlIhHZiqi+XeDlPNCfwyRglpWRwpp4e3kZiybOnaYqI9Ix/DQY6naTAAPp1U8Xq/mhr/sIbQpDkl6WFrxQ+Iyg15bUfNZxa9wVKFD/piZ/YPAPSXtowDUelJ2a+fM/KylXil8B3qx2WG1yW+GaHP35rT02WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnTPrAJ/Pn9XF8e51QQouXP6XhRUlwa6eDr5MK5Mmns=;
 b=hWYLklrtXZzQI4asNR8nhjM+QF8gSilqSOeRk9Rq7YfTBxrP+xdHfSdC9fAoZH6Bsv/+jif7pmWrTeZRyXA1FmPK19e85auj8kkM/sZiynSYIMatw8HyjdPzLUWXM6pHqbjfxyXpuk2ILuG8TWAmwn2jOqftHa3/jMsyORlmlsqiwmz4P3ivU48y/HseCGjkyMOKhLblvkbQe21SeH3AjJCM4dOKsZVZsvWsaBzgTmmXnwM9b5mksZtQPU+ST/0SGALfuojd44b9xSlvW2FxrPamLt2BEP+kbjN2Q/P+owtrAqXUrwr9WJN6Yd2t8/QbK6u8qNBdqDcBQEcxZ+NJDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:06 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:02 +0900
Message-Id: <DI8B044D3N16.M8P8EPVSKB7L@nvidia.com>
Subject: Re: [PATCH v12 07/22] gpu: nova-core: mm: Add TLB flush support
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
 <20260425211454.174696-8-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-8-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: d8661d50-8bc7-43a3-eaf3-08dea8615d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 64XnYowJXtdsRnDrUD2M/kbsDuFPWMFn2KMRbUUXyAIhIv+3vtHItJxZg4CL95G/ArkdWrXMKsm3g2476Xah9TZA0Jhmhdxw+RwiUecKW39xo3sf/Y6Mt4/kDBglmnywYuU9e8YfuZwHAdvAluYDUkjtqqH/kduuX/3FLosvrcDNm6m07yrJ/a3zJhZ0uqfJJTEURJCLFipENxBIAyu45XAX6A54apHhMCagPTtvmrOVkeFk517b+QcgGXJewm6EKbu1BVpDYxPb6r6SNz2W3ACBDEPu2SU8ReTPg+WoMYDEnKvtdVXuhtplZVIt9nRz2lzIo0IcSchWAOhpdY+g1jggUASSC+7VenmfcYCYmNhwyPiTnP/1YwB3T0jl0+Cc7myFKAILYYTuXJEqCoWPjF0fLjVSUlPjvOinugvhjt90v5FwnoJJOuKQ9x8DsIU0W/BkVhJnI7EiFHOZpe7spnhGl6g09ygvkqTPZTn6mIhuzrIPfYnMb4GnxBjIlMe797lSBMU2fFo9pF+s0+dYWrJ/iUMHO3brjMuPqAZ6I0JzPEZfjJnP8mskM4L8st/bn7ZZGZC083ki2C4bZu89UePfGW7khgBAMKNKBPGA0+flhbIlJMJdsvxC0BFhlMw0259bbuZj8WdeA6oM9M7FZXDu0H+LUGsONXCQkiJegON+M8EHTYvLSOA6DHNAa7DV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTh4RHAyNmg4UFkwZ3RVOHlva2M0WXJabXk3Wmo5Ti9QNHRuanV6VE1pZDFy?=
 =?utf-8?B?eHBJWUNSYUY3TlJOQnVmc2xCek41MXk1SWRyZS8rLzBwVnpOaHJTdEQ3NUpz?=
 =?utf-8?B?dlozTkNzK0s4c0lUSlc2S0V3aVM0c1dwZW15cGdsUFFZYU9keWtxTy9BU1I5?=
 =?utf-8?B?bVI3V2VZQ3dIR2syYjdQL3RVcnlNdGxJK0podklILzcrR2hPWXhJa25oYzRP?=
 =?utf-8?B?NU83djJObUJ5Q2pZamtkeFFORG4xK2hHZVBnbFBQNUNhTEo0RTNhNHRUMHV5?=
 =?utf-8?B?NGh1N1h0VU5XMFowZkNwbzBpaEFrWU1tSURsYklhRk9BdE1GajJzL2ZVQURy?=
 =?utf-8?B?SU5tbFczdU40emJGeXplYmJEKzhhMlJRbmpVcXJNTVlmYW5ORmVKWGZXa0NJ?=
 =?utf-8?B?THFBaUs5dHh0Umk0aFVlWUliOUR5OThOUkRjWk1keFh2eXVlZEd4L2pqM0Jn?=
 =?utf-8?B?encwNG9BYmt1UFpJazRVRFJMZDIrOWVhUWt6Vkw0ZmJRcDhBSnJhZVJ5Q2ZE?=
 =?utf-8?B?TENrcmt3cVJMTW9pclcyOVNGZ1pLTXljWkJPRlI5c2JZNi8xVzZ5alBZNHJU?=
 =?utf-8?B?elYwY0xqZkdpMEVzbFNyamxnNmgzNDcvR21SQk5yNExwdnhBUGFBRVhXWXFt?=
 =?utf-8?B?Mzd4VlZrTzAwQStVd0ZQUW9wYy9nTUpzYTU2WjRtNG9XVnZIRkFvVkttQXcr?=
 =?utf-8?B?OXJTUVZ3ZDVuWjQwaFVPbzZqeGRQbitzbmh5UEFaRGpFek1pTEtibkVQenVN?=
 =?utf-8?B?N3JDZlhjRFZRdUpveTlRMVZZMnJkZVpVSE54K1hZZkZyQmtubGxqUFBzWlQ1?=
 =?utf-8?B?dXhUTTQyZE0zVGs2RXRJUFplbDRVekhBNHZMdTd6ZVM0SkhPNXJsc0hGc2hj?=
 =?utf-8?B?VlhXRkRpTTVjOVJ6QWhCdzY2K2ozNlgwZUo2dnBadkRpZzc2MGt6T2hvTHUy?=
 =?utf-8?B?TnhDUjBUNUxwMlNSZ09uQmhodWdlTVRHNEdDTnhRVFFiOUlHb2E2MXBUR1VK?=
 =?utf-8?B?bk9wWkJLWThZV2puUE1mMXBWd3QxSmJiWDVsNjFyeW5CT0VlNTh0bGlvRVlT?=
 =?utf-8?B?UEpkemFXZVBFSDBMYXZiL1ZraG5DNG5zeUoybkl1Z3h4c2pmVVNDRnJDc3lv?=
 =?utf-8?B?QWlEUytrNStma20zTE1ZMlhXVy9XOFJ3cXcxUXlJYUxtVjVKNnI2Y0llQjA4?=
 =?utf-8?B?aXlQeC9HSW44NmtWc0s2cUx1QmRPM3NtVXZIRXRPTW9lOG1ocjF2Nmk3NEtO?=
 =?utf-8?B?TlB2UDJVN2VFRXdwV082bGVkdm1WUy8xYlp1Ukx3cUZyZjhMZFd2dUsxTE11?=
 =?utf-8?B?cDNIZ3hWai9OdFg3cktidEIrYVpKeTNGTDA2SmV5NTZodFpYeGEzcUtUYi96?=
 =?utf-8?B?TUZ0am1BUHlVU29CMC9RUTRsRVFUc0hBMHJzbzlabFRCTzB0OXMzSWQ4bk8x?=
 =?utf-8?B?RUZOaGdxbCt4UkxPOTBJeEdwRlJRbGlIWWcvcm5MNVJrWHNabW93YXdUaWNu?=
 =?utf-8?B?cm5aQ2dSM1R6NXZXWnJ6eEttZDRBblBxQjJiM0I3czBNMWRpNVVsaWRmYmM5?=
 =?utf-8?B?VzRGNnEwQkNsQU02bzJTMVFlaUppaG1FVU8yY3pLeWlRcVFSSzk5cEh3MjVU?=
 =?utf-8?B?NkxQUmx0QUc0bkVNTFVWelVSRXVSWE4zMVU3WlBkMkR6Rlk1YmZjWHNYK2w2?=
 =?utf-8?B?bnhWQUVidnh0NlVLendBWlV2UE1IK2I4Vk9pZWY3eCtpRjdRa1ZwR3phWERa?=
 =?utf-8?B?QXFzMkI1cVBoWVdsMWl5Y2ZPZGVTSXNUVTl0eXREcmorUWpkbjQyZlk3TnpU?=
 =?utf-8?B?M0RoNHNvbENPNG9XeXNJZEZXTDBYZkh3ZzZwVmtaTDVlODBCSVgrZG1QNmdY?=
 =?utf-8?B?UnI5Z09lL0dJSlFQVWw0WStxLzBlS1UvTkh3ZExqSGFWUnZUSkdUd1EyeUFP?=
 =?utf-8?B?MllhcG5PU2tqdWJTMHQxUWVZdXZJL2dhbUJFNDdkWWN1SWw3SnZuaVpZU0dy?=
 =?utf-8?B?VWx6ZXNmZEcwSjZmejNWMk9mTURKWDVnUEdRNWVXUTMzOTJuMW9ua1gycU5G?=
 =?utf-8?B?enphUE1PcnVFUVdCT2pDZ2ZDNmtIbndMYmszK0tVd0M5MHJWZHFORUdmVy9D?=
 =?utf-8?B?TFpXdGFkdC9ET3B0QWpQNzNHdVFFTlhMZytQMmFlazlrQ1lxV0pJZ1VPbEND?=
 =?utf-8?B?ZlQ3TzM1NWo1emcwaXg5UFN4TTFHOExpeXlCTGUxUjVNM1VIQUF4YVdVQnVm?=
 =?utf-8?B?YU54RjdhK0RFZzJyK29YZkdZZW1xWXJObnY4ejdQTzFKRk5nR1NDS05SZk1E?=
 =?utf-8?B?WkU2NzZHbUsvVUxsZUlFY0V1WU9McVVjMzhvQUpLdG92ZjhEMnRUQmpRWXBK?=
 =?utf-8?Q?U/B3Fa/Fhv4c6OJUUw2qw54CmMJpEmWaGGEfsmxCIuwT9?=
X-MS-Exchange-AntiSpam-MessageData-1: wiv/1wMSYrYuiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8661d50-8bc7-43a3-eaf3-08dea8615d2d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:06.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djx4EPXJLQFbKaJYJjmNQE7w6bAN7XRwLmfPUdfeHU+kFMc/PrORNnybP9y48jWtWw9rIJnK2/jsH1v+5S8JKQ==
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
<snip>
> +    /// TLB flush control register.
> +    pub(crate) NV_TLB_FLUSH_CTRL(u32) @ 0x00b830b0 {
> +        /// Invalidate every VA in the PDB selected by `NV_TLB_FLUSH_PDB=
_LO/HI`.
> +        0:0     all_va =3D> bool;
> +        /// Invalidate TLBs for all PDBs (ignores `NV_TLB_FLUSH_PDB_LO/H=
I`).
> +        1:1     all_pdb =3D> bool;
> +        /// Restrict the flush to the HUB MMU's TLBs; skip broadcasting =
to the
> +        /// per-GPC L2 TLBs.
> +        ///
> +        /// The GPU MMU has a two-level TLB hierarchy:
> +        /// 1. The *HUB MMU* sits at the top and serves memory requests =
from
> +        ///    "host-side" engines: the host/channel interface, copy eng=
ines,
> +        ///    display, and BAR1/BAR2 accesses.
> +        /// 2. Each GPC (Graphics Processing Cluster =E2=80=94 the block=
 that houses
> +        ///    shader cores / SMs) has its own L2 TLB that serves reques=
ts from
> +        ///    the compute and graphics engines inside the cluster.
> +        ///
> +        /// When set, only the HUB TLBs are invalidated. This is a perfo=
rmance
> +        /// optimization for flushes that only affect HUB-side mappings =
(e.g.
> +        /// BAR1/BAR2 windows), where fanning the invalidation out to ev=
ery
> +        /// GPC's L2 TLB would be wasted work. Must be false when flushi=
ng
> +        /// mappings that may be cached by compute/graphics engines.
> +        2:2     hubtlb_only =3D> bool;
> +        /// Invalidation acknowledgment scope. See [`TlbAckMode`] for de=
tails.
> +        8:7     ack ?=3D> TlbAckMode;
> +        /// Write 1 to kick off the flush. Hardware clears this bit when=
 the
> +        /// flush completes; reads as 1 while the flush is in progress.
> +        31:31   trigger =3D> bool;
> +    }
> +}

Registers should be defined with their upper fields first (i.e. `31:31`
on top).
