Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6799CCD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DD110E29A;
	Sat,  2 May 2026 15:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGXqyvMk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E1F10E29D
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbcdO5xWA3bi6RJ0L/2367mFZT1VBJhrph6GtwvHdnLiX45yQlTrr6Qpd/VZTFlSHDfaCkexJge7+Y/+ZA0DdCW/qQ0zmFM+ye2gW8zmpAkyl1wr6GVqxxt4l/UVT57KdUlTYavv6NVg23W/aTbUcTl/eOuzG8vjveYGUINKwp3PbogIVi+uZOZI4WZpD2pox7rzdCkC/Gk+WTTm9OKqV7H9uyZUAfxX0r9tN8gvycLjC73DJwtCKxzBlzkCBctycFNlksamF5XHLLEPQXBLz5NQcUgMhyCNwCPEh1w1h51JBEjqcOj+bgbXUgnxmrZNdK44FFm+g8fW3c3/gKadnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXPzR0fmNthNlprcGfaOr+jI9VDZMwb6CS+imQi/ozo=;
 b=v22zd8iRitXtohPYXd5oLWI6dDLNJMMVNApD/h9jDa7LFl1RRa1YJWp0lALxmMGPoLvaAlhFVtrgp3sKvq/GCZ79EIfQdRpI9XqFBJqhr0IQFH5oV3NMyL/4Iw6SoUwgQhXg55u+nLEbDCTn5whhaHt8J6hFw+7MP91U9ZBttAV1fojaI7jGG21bkXPsl0cZzPHBsPh3NQxpJ1TGGEQ6KoPm2FDuZjpU8S+n/OS6nnnUfzv/ZKuQAPBqQM4Nc1svp4cXwAUHPizJ2JljJw+DRtkth+qZTuPjWDAQQ532ODo5h4YyRp0hb0i783DVwnwEZD8K1goP0MnFbzGR5rjrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXPzR0fmNthNlprcGfaOr+jI9VDZMwb6CS+imQi/ozo=;
 b=iGXqyvMkZHTFdnhXX6mJKIFUs4CLW4w80YY49//pLXLuaXndkf0lMpl7+pXxX44s5Oihb4IO/PthUQYk4YLgql/R9+FiAw5N9Dfo6uqFGix05Sn9J3Vy/EHsph0x2vs1ECtJEeTEsFAERraCX/pMa4fKbLwFGwgK+vN2UD4vwzG9YJ90ZMNQtri5E3mNVcU5mTe6gsvgwcocv/mOqn9bIBTwXKx48hZy5oAgHDJVU0Nbz7ZkjyfLx17WOIc9fvpaV80AQqOj2G8PzQYFsOkURS+j6AjOzHdN7sCyrMmOfn6iqB6VKHhvzZXcuiEkgFGRFpNkP/gbd47rlrx8YMuw1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:07 +0900
Message-Id: <DI8B06IYQLYJ.F22NKXAS9D2W@nvidia.com>
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
Subject: Re: [PATCH v12 08/22] gpu: nova-core: mm: Add GpuMm centralized
 memory manager
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-9-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-9-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b27adef-7ad6-4997-9b13-08dea8616021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vn3FtB4I/77Stdt6emRtZRFonsKPv1PxoQxEpJhSiC+jMGJtAzEsZZDA7nTuIX4vTnZPnqM3BlbMv2emexYRPpJSzIFa5ytAlEEDjmkhvvZ/UmkvDcTIDrnl4CNfESs0IiyiW742kUHKt9EO2c1HCyzzTlog6U/zXpUNDRlX7yaK+yqUJ8ZUl4xO+KYXNXQLSZGIlE8nWC6lgXmVHeBiBbNwrk+g1cQRx8cp/tEaVa1qDAil1oHnpoUX+aFGGyg9C815wgJqYBeU42i5MKIT2q2R3WjnX3KSl2Dex8z+n3tNdh2EUskITs7QuhK+UWnGYELyXczWxECW8m66gq7Y0seCCwJpxTUZHJalhwWjaxS617eROwstZLrpx7KHP7AvX1COYdC2/TngEHQB6mzCysu06/zGrm/JrfazaXZusiYSgCxy1yOgGd2DM+4BzkVqY9C+MfCBKR174WIbe+pKH1k33mjSvLB2FKkmmurQhGgGTHTzzBzu4yjoqveNQ9uDQ2bz7clHeFhyYq39eyg+PAIZ8L3gO7vU1Zi+e8vvCVdi5QtzogaYVwUENmIXvME5ot/C8qiqxh1JglM4M2CxBJtMhiVpSpmux3hc16dZ4OEakSdDyOgLFWUgikwig5EIppZiEO8JyfUbEHZu0dPkq29aHdCy4f9rOkIFuCa2ItrRf0tNCPPFuOeRbj2h8KBU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21zZTk2RTJ6ZllzNDZVTkU1VUNkbWxxQ0NybEJoK2lGcTJSU0lKQmh6bFhm?=
 =?utf-8?B?aVFnK3NIdUFLWXkwNnprZDdBZmJlTkhHa1l4OFBvMEozcVpBRXNPMndrVG0x?=
 =?utf-8?B?elVjQ0NIcmtmaWxobE9iMEMyWHNZbmRkR2swTkcyYUFkaUZ6L0IyS3V2OC83?=
 =?utf-8?B?aUNhbnhtbUJzbFdLLytYcXdhTXBJN1Q3Qk8wTkpmVmFkbU1FUVF5TEhrK3Zj?=
 =?utf-8?B?ZjJidEhZdCswNHBsam1uNEVndzNJY1lhcTlWRHVCL3lyeUNmcm9peXBidi9C?=
 =?utf-8?B?dGk4R0cwV1pYbC8rUEIrcDJoUXg4UHB5aXY0NzBzWHd4RDRTTVcwQlpJTGlG?=
 =?utf-8?B?MkcyY3U4aWNpNHo2VVB0dE9TUWNQU0o1cytYb2FSMjBXZWVjZmhQdUs3cEpJ?=
 =?utf-8?B?eTNQbVFZMjVxVnU2bVlJY2dFQ0VhZzdaait1T1h1VEppa3FyYy9sd3UzZDE4?=
 =?utf-8?B?Q3FCL2Zha2w2SlB4TTRNZWJBYWZ6Vk5jOVJRWEk5QXRjZHhqMlpoWXJQRVZt?=
 =?utf-8?B?ZHM2cGUxSnVxanI1TTREd1lkdDdkdWRVdjRmRG16VG1teElUUU94aGYrRG9B?=
 =?utf-8?B?d2swL2o3WVh0L1piMWhjdXFIeGI5OUFaRkh2MDhQMlduZFJ2aW9CeEdhZ0Ro?=
 =?utf-8?B?UzhqbVg3YitHQlFUZDZhUk4zSDJUTC91U0FucFMzdDJORGE5cUZzRVBmYkE0?=
 =?utf-8?B?emplUFJDVktlVlBGMjkyMWJjbDRyQnJLTjEzSmUvd3FBcGtzcm9kWlNJYUcz?=
 =?utf-8?B?TUxtcElwdEdQNHp3MHNKcFM1MW1xR2xZT3BSR3ZsdmtuZng1czlPTjZ6MnZ2?=
 =?utf-8?B?RTlSeDFaeWFtTUwxR0xrUktzQVF3bWNLcitKSU81aHJEWGlWK2Y3UFlXNjZU?=
 =?utf-8?B?RFRDMXd2dExUQU9ubnVIelgwQ0ZVYkNDaWQ3RzFVblhrd1N5bFRsZGdGbERi?=
 =?utf-8?B?dlpid2ljbDlxaFJJb3hyOVA4R1VnRis2SzlpVGZGbDhDTXgyNmVmZ2U1MUFU?=
 =?utf-8?B?M0pwc25xbGVRZ0ZoV0s1TmMwOWtydkZLa1pvYkNSL0FvQVZaYlJxYnYrRjF0?=
 =?utf-8?B?SndNdVM5cWJtK00zVUd2ZzN0cmhrS1dzVTlCMGJTKytxam5sUnhZTTVpeDFy?=
 =?utf-8?B?TXhiQlFDZklaakFOVG1iQU1PWTNKam5JK21CSmFjVlhhNWVpazF4emduRk1Z?=
 =?utf-8?B?SlFIc3BWdDQxVFI2SmFuZGhkSzZ5di8xLyt2eW5nREIxeUQrMkJVaTFtZWRx?=
 =?utf-8?B?dlVqbHpWaUdrWjc4clRCaUZZSEFjMkFWK1JkeVRQYzZkZzM0bDFUOEdERjBh?=
 =?utf-8?B?aVFVaGFBQkdYY3hMdGVZY3VURk9sTjg0YVhDMXJXOWt2UDRRZXdHVzNFV2hN?=
 =?utf-8?B?anNxc09RdTZ2N0ZiK0xHNE95a04yV0l3aTRxdWhoK2I3VXlOa1B1VVZ6S1Q1?=
 =?utf-8?B?M1NCT25nbTRsdWxjV2xoRVlEUzhndFN3M3ZXZ3A5Qi8yM2VjL05ETS8vRmRK?=
 =?utf-8?B?UFpIalV3eHJRNCtoaElwVGZYeDVUNnNSNTc1NEpWa29rYk1jd2ZsSWsyQkxI?=
 =?utf-8?B?WjFZbTZ0TjdHbXV4V0o0cmEvYlhIT1dJeDFFNStMSk9KeWQrWkp1V21GZkVH?=
 =?utf-8?B?aDhncEx0cUJyTm9wQk5BUncxUDZxYXd5SGp3L1EvNE4ycUNrMU1EZXF1QlVk?=
 =?utf-8?B?akNoN1lwcGhhOHJtaWNJSlE4Q2RTcXhUNkM3Mkp6dlRDTm9XUHdqVys2V0hm?=
 =?utf-8?B?ZDlPdFhiNHJ1NUNvU2FpUmZVZ0hUSUl5K0g2V21oMFdSUWpWQXQvK1lNb0s0?=
 =?utf-8?B?YUltNkxTQ0lkckFFQVNsSFFFQ0UrWFZYeG5JUzBEQW43Q0NNMGVMZWIwdm5C?=
 =?utf-8?B?NVAzdlhLNWtoaGc5dGowWmFVbVVQaVE4S1RKRTVpRjBIRnQ3dG5WTXBSYng5?=
 =?utf-8?B?cUtUc2UzbE15RjMrT2ZLTE5wOUlkZGduMVI4WG9nQSs0a3ZZeU1KNVVWRENH?=
 =?utf-8?B?OWF0TXRhSzJNVUJtbGxoUHpOSGhuUjdWREw4OGFWMVNYWnJCRm9MRW5CeUZO?=
 =?utf-8?B?T21VZTNqR1ZBY2p0aXBlWDJ2SVBzOXJZRENDUWdEKzBHeE5wOGpvK2oxakxM?=
 =?utf-8?B?YkVPRFdSVXZjbktYa1JhcVB5Y2VDL0Z2dzR1alpRS29OZ0QzcGlZR2dZQjRM?=
 =?utf-8?B?Qm94MWh4blVRT09QNGdzNks5dElJajM5K25sanhGdG9rUUhEZk4zTW9ISm5G?=
 =?utf-8?B?azU0bENOTEpLbk45VFBiVnpiNmoyWHZiZFNaZ3dtbFNMOWFvdEI0ZVVsSGNK?=
 =?utf-8?B?MVhJYlZ4U25OcmtIK2N4eWVvaXRxbDRvNHNNQTRiNVhOMkFyV0RQdEU5SzJY?=
 =?utf-8?Q?HU+k13jY+L2soIkEybHMikxammO38yb84+sDq0hnj0mQo?=
X-MS-Exchange-AntiSpam-MessageData-1: SnWdnwfd0mWZiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b27adef-7ad6-4997-9b13-08dea8616021
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:11.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+2epe58ASMoHd3t7MYJ+Zh05YIPwfeEVvdsVU37JHE4svy2MDnt4R2Jnt58buPvi8sIENtxcFyinqt2QV1ZHw==
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
> Introduce GpuMm as the centralized GPU memory manager that owns:
> - Buddy allocator for VRAM allocation.
> - PRAMIN window for direct VRAM access.
> - TLB manager for translation buffer operations.
>
> This provides clean ownership model where GpuMm provides accessor
> methods for its components that can be used for memory management
> operations.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/Kconfig         |  1 +
>  drivers/gpu/nova-core/gpu.rs          | 28 +++++++++++
>  drivers/gpu/nova-core/gsp/commands.rs |  1 -
>  drivers/gpu/nova-core/mm.rs           | 69 ++++++++++++++++++++++++++-
>  drivers/gpu/nova-core/mm/pramin.rs    | 20 ++++----

Why does this need to edit `pramin.rs`? This is the first user, so can't
we give pramin its useful form from the start? These changes on
`pramin.rs` apply perfectly fine on top of patch 4, so there is no
reason not to squash them there.

Reviewers read patch 4, build a mental model of it and write feedback,
and this model is immediately altered without even being used. Please
don't do that.
