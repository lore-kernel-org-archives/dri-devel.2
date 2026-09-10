Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14820C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 00:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F47C10E231;
	Thu, 10 Sep 2026 00:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ws8L1jlM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A0A10E231
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+LI5A196Rgq48IAxR0RfESt7yuju8vemQzes+87Q09sxGqqwGmEflukEOkVUhsc3ZcQMvuA+YJnQ5opQdf6uULGicOkoT9vMcdq4zgtFW6DQdBD7dJGdeUs9RvO3zjPfdGjyd+mo7kCsglqISLmEGmO44ZwFtb/LfPZa7Im5xIKh03hJaKDqfhODhVaumqZf+H6ACkRWTJ8ObzTAMJTMnqBrnkjZc7zFOtC/QnKOqMfqS776JXlqFtZI4mP8YFZxb6S605ZO9gde7g883tGX9rCOrZpghdaqgg16lc2bP7wPNISSrZ1ItJabKMrZX8vrG2b0RZmwCQaIJvn9aDF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe0limKfwkktLmi1dqjHRxeVd1UoQfUN1PDSmCyiTQE=;
 b=SbV/KryDVfgzdO4KG/woCBU0qZRj3dYp4BS/b6cNm91+R3KyP2Cl0ZndrgBiAgQD2pLfenw7xKiveUX9bWd8bQyGMouYt4mJEYXLZ8zm/tPlcgGhXgnCLXXRECl4l4HLFXOyG3EgEWQ9WeYLuhVO8AYol5WGgRX6k3faPehEJ5u2xITZSnV03/CM8fW7CedN9i5Yk4nXsBvpKgOrUfwXTO94FWr6xeSdhJvgeW6y8e2jms/0x96LEpE8pK7922s1weferm6CKyPgP6hxfr5GeiDE4Vh3kEm3kvcKQWB4/Kb9zFUvElpbhQY+PLdw8jGtF/3rWLsYuyY9erfZ+eqOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe0limKfwkktLmi1dqjHRxeVd1UoQfUN1PDSmCyiTQE=;
 b=Ws8L1jlMNW974/Z0ExqCQx1ZBeY3vxs2XDy5TpBLvL2miupQeWZ8JgGaWZdyxl7vMhrZI4nf7huxVedkeNidFeIk97Y3ayvCe8ljSefjmbamjy4R6ERJL0v6sD2cHuug6+l+tn11QIWXiYVXZ+eJ6NVnCe0IZ1dMD28M6iCxH+/isl9yiq1i5Bt4DnHtmluT1GmkMaofepntSVv6gcywgpDNHajG9BLGfud0fm4OJjAV15UmAg26lvtFEI2KM7A7PIfQzWemzrmO1w+/TREbsOpUxf5SJFf86fEANxMnSu82WsGitMVBNH7cy7KyzdQqk7UfwS1qwmC2hemyMAb6RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 00:47:42 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 00:47:42 +0000
Date: Thu, 10 Sep 2026 10:47:36 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH 13/16] gpu: nova-core: mm: Add multi-page mapping API to
 VMM
Message-ID: <aqH5p6jsrHVbr5ui@nvdebian.thelocal>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-13-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mmrebase-v1-13-8dd5d4225d2e@nvidia.com>
X-ClientProxiedBy: SY5P282CA0123.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bb67e7-6fe3-478d-3712-08df0ed51edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: faVL0BIhj90QSGUMgmoW3VX029gI3UkHqmGFiInjXIC5uwpCsZBne2+ZR/u+xhtMgre8thEIeglORvMd26RYqTwOXNk5hlQ5FFY+Zy0GOyYaEqWtrHn0wNLPZxfnEtFJz5TO6LtjfaHstvrDm3XH/KcmDfE5ti867dyZi7RMpUbzfXq4wLVsap3PjYQfOXCE9cB9Al3mjEBKhHZPZdDu4FtWBjv4hT2rTUsLDTqNSZbNEq/Us8/w/v+4ZvxplX7lK0cMyJ7e+JJN14gpzeg3F/k0RfqWIV6IrNQci+9twjDoicC9P6SKU5zE8Jut3cob9mx1ne8IaK62+4w034rKOo2YodCIo6m+SBTikJj9SwTDOiK3aWaYnXFJzJeQVABPzzAL2g+8YIr1SsAf3c3mInbydjqSGEYwWbnfH/P5RqQ1NJ0FNMFExff03RIkIcWUm29TsNe//oyClZtEqQJanA9uNFskpi/lTq5WzR2yIZLRzr1zn6qWJF64ZTrRqVqfaGb0I6gJrLm0ZPuD/Ae/ngVWL2UbZGi0+d06q+wtDsbtzXlVIvMoBbqAheasZMQR0cTt+7wYHHD+y10/BJwTtdG5Bw7wHd44bW1DxP2yBEXgP5FHAA/lVRP/tcoXGbbWI0WkVS8YJCgWO2FIHrJ1aVrzNHPIeug/0ndWWWzYqvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+850K0BQal15fZDb/Ik3iaWF4AcyhemA4cqZbyh34eC5JEHov3aYsXxZQND2?=
 =?us-ascii?Q?WTspSdv3bJwdfLWz5oXD1eJWVeoVIFHuJQU1dv8ySlWxa3EEbGkKiV58RxeG?=
 =?us-ascii?Q?hEe9Lovh5LdBfv6QbU0xz/PZhYiRFxI/Qfcb/ACkpbrgcxa5zTjaxOzoFU9B?=
 =?us-ascii?Q?zGDvoFeHcsqcYnBNScOJbvGi3lylKbaCO4zcnH4YJpc1KrCPE/kYl2k7PJkS?=
 =?us-ascii?Q?O9GGER3VnkD3n6RC2hyhnUuNnS9ZxWg8pw3bb3VFMy+FhvTZHNyfxiR9llPr?=
 =?us-ascii?Q?82a69CGgdBwi5/OWrgW1jqlekKjHdwa2HYlN74KosNWOSwLXmDAFnSjW/usQ?=
 =?us-ascii?Q?vct4rBPfjI0YUvtB6IMb/hbcvSwD10mzx1A8PTE9wPLT0T2FKd8fZ8nO/9Sb?=
 =?us-ascii?Q?vyNVHKKNYAzQAzILvK2yxplcERQntcsTds3honLgtvwJ9MaD/nW+eZIdFJdI?=
 =?us-ascii?Q?UitgaIwaaup97iiS3QSbE+GF/GwZ8L563jukizijJdsf5tTvWMv8hIu1lfrz?=
 =?us-ascii?Q?pEYxD5+6lp5L4jwJaUNotMOwf9fgDm7lLya7aABgKDR7MP+D1Ks4FPrITv9J?=
 =?us-ascii?Q?g92WIiQixLgz6nOz7n/PJ3kYR9Z4T5LpTrw6tqMv18iofRyqH2ynGLhTo6lL?=
 =?us-ascii?Q?tzvRlfDL92N+rHu3SAwOctyBLKAQbegVRCd+EIG4dqhWCuUjweWXSpD/tMjB?=
 =?us-ascii?Q?dkyKzBZ69Z0O2piej/s2JqSI1mV/FNKMPBhD3GKfwpJpceZh4UDtPZC6QAUM?=
 =?us-ascii?Q?ILcFQKsjYGkK5jczO3aD1Z84zObMcEjskFnex30VK6S05XyRSh5sRpp0RxFY?=
 =?us-ascii?Q?/CLxxaXF5OMDMhWx/FCCJefHML1Mn8ULGR2k/z304ucuRnyqE8qmjuIC2Fem?=
 =?us-ascii?Q?qzSGDd9sXWTszFq5YLj4RJpVd3z0MhjNrnZSfLBwwcIGAhIkL3XpDKiIWjNQ?=
 =?us-ascii?Q?NGLMGwJBp2HjubfDA9Alx3sk74pxs6UQ+YvHLCSXlOmiwUB7skk09Rq6FZI5?=
 =?us-ascii?Q?Ygb7XVXj+74zYMn40kxRLTCVyVmMvn+thHgd6tE8h060IMXwPkbX/pDgPuT/?=
 =?us-ascii?Q?MoLFowt0neIaVGuJROdNqeKm95gXjqGb6lgRUqfnQnUjamGXaKgcwCLP/xWG?=
 =?us-ascii?Q?eB6WGwoLPhhBTgcQkGUl3TLYkiz1B22V+6E0+od+zjEL0HtQWpJnpvTXivAO?=
 =?us-ascii?Q?G0Spbsruc61JYEIXaezcKhDNOCuDE82JXYNDgjInG8F4Iqk6YNwWZ+Cb2tT9?=
 =?us-ascii?Q?+ih1H4yDiBgPS/3Y8du6hhG6Y7AmUg1poc2F07HFZ8fY+6q0rRF1V9sjbQ8F?=
 =?us-ascii?Q?zZj8sgaOwK5qWXV3LkgoN+JxgYsONF4PvIC4XFVfEtD2r6Z1TSN/g/JBv+LK?=
 =?us-ascii?Q?+WGrT0EIxiA7kAK34ynClmjVM/F+3ZC7DQ4zMYN3yD1MZ7mqnCxzT66DSkvT?=
 =?us-ascii?Q?v3dpvnWndS/K5hZLOFCaWeh/Q7k6KP5OhvT9FejOtsONMzdcRujQMqb6xbIj?=
 =?us-ascii?Q?Gqk3gnMezdAmQUAMLYxW3hs8PWSChDYMErkhHC8xxOaRSJ0pbO9q5bVxYjjK?=
 =?us-ascii?Q?HhjQY9Oc9khtcgcbakDJ2UqRJmRF2B3qWHNWhBtwSz39T8DJ0U5ANfAL6wjV?=
 =?us-ascii?Q?jP1X4N+b02Kff6ctjpi2RVtP9ktsC8NWfHOKZxuQ2cnQKjZzBaPertQElFuS?=
 =?us-ascii?Q?HYpQCc8brNlXhyoLlv4YXfy8UCPza7SaFzg2gAhKsURyBk1WyDyXRE5WklNA?=
 =?us-ascii?Q?cApWZecXzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb67e7-6fe3-478d-3712-08df0ed51edf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:47:42.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3uoxrx7Ky0Yy+vl0pwzL12IFeJ2OD/SNB/NzviJHfewjxjf+ueWPucVLNbtpdLQlyR2FOnSLWuxckebA+jT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
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

On 2026-09-09 at 13:59 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> From: Joel Fernandes <joelagnelf@nvidia.com>

[...]

> +        // TODO: Internal page table pages (PDE, PTE pages) are still kept around.
> +        // This is by design as repeated maps/unmaps will be fast. As a future TODO,
> +        // we can add a reclaimer here to reclaim if VRAM is short. For now, the PT
> +        // pages are dropped once the `Vmm` is dropped.
> +
> +        // Free the VA range regardless of PTE invalidation success, so that the VA
> +        // range is recovered even on failure (PTEs may be stale, but that is better
> +        // than leaking both PTEs and VA range).

I don't think this is the correct approach. I'm not sure what exactly can cause
PTE invalidation to fail, but I don't think we can just recover the VA range
if something might still be using it via stale PTEs. That would cause problems
if the VA was ever reused for example. TLB invalidation is also part of PTE
invalidation as written, so we could also end up with stale TLB entries.

So leaking the range might be bad, but it's the least bad option IMHO.

 - Alistair

> +        self.free_vfn(range.vfn_start);
> +
> +        // Unmap complete, safe to drop `MappedRange`.
> +        range._drop_guard.disarm();
> +        result
> +    }
>  }
> 
> -- 
> 2.55.0
> 
