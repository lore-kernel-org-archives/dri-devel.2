Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A30FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5074F10ED60;
	Wed,  1 Jul 2026 01:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nN7lL40j";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C76610E2E0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdUxL27OiQQBORid6APUfsO100jODnA2rYw8fgqaJhYRrjJ0JWKlNEPHdepQ66RjSxJcf0i4vyLqYNu9T12oovf8RdpbSIza9jZVHQr5acHT88HVJYs9E/sDYQHhVNrcxY5uIaZzuLKUZbEfdU2XxccxS/adkOFAL+ZLh7kw01sZKg8C65mI6rwFFR3bXWHgxdST4dQdwGaaRigP+cwHIsv8cn879qruCB8lhgJwisrZ1SZxl514NmtppAJmW+a9cHjzPNXuyV7fTWiC8m+X5kJM21s2XxNY/Lcp7J1JMJ1bYjQEqxn/JTGnVZxal0YCi3DlLUR1EcEurKzoR6sm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS3Kqr3Hcdspmb41FTVCWwiESViU6dGZuOKyvCjiNMw=;
 b=tztDcuv4ZCSfWE+tVJhWnD0kdN9p3iahx/QSroyahsG3ec4NSYU/FwH8AV7zWfRqXdz3O8DpxC24r/qW3kJ8PGPd3oA7JyMxU7FlBfeIpY12F3+bm7oU1ZPvJuW/KpMQJ2JwyNVOfJekSSfcAjp7XJe/+wO1itFQWA+aFsB5QjTM/KJiLdaCiGewFg1ofsqetjS/+Nk6Zj9iLk8lY8TcUmAZBFw6OdnRq3B9Hh2LtHOyehMBrXQLyZFjmzefKSN/lwdaG9VkllNkDwhxIYMLE78qGO1nly5EyaNA+LWOHRQwwygwwbMf205bqS9eVQsgiYUv/0xYEBAwhS8P7lcafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS3Kqr3Hcdspmb41FTVCWwiESViU6dGZuOKyvCjiNMw=;
 b=nN7lL40jRU3sM+TNkcsyXRFZkIGcBnR5T3ISLjlLDFoZehmSaSkLx0lZ/jChbtgkBM1ptnKZIAerAQsxIQja9NkV4bbmTVZFB2x0J3AuQ24ijSeq85YZIDVXPadev0iUeVYkKq6i0SkZ6/zroDpjxO1ntj4h3e0ICFFMMwirw0m+LTE+ybg7m3wW7KlSoQXPTKRL9R9xhNcCd1OOOvybsv1BiAeZ5OrUEyHYxNuS73ggqwyvo4N8HklqJcg6nedKf6Z9L1VR0EnPaKzkrlk03had+G8MFheyiJG+HxxwwU0fCP0wKWvBCNMSjVfTEQBbyWz7KW+MfdRuXX9yYCxuNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 1 Jul
 2026 01:30:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 01:30:12 +0000
Date: Wed, 1 Jul 2026 11:30:08 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Dave Airlie <airlied@gmail.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>, iommu@lists.linux-foundation.org, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <akRsELMbwJmUKWek@nvdebian.thelocal>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <20260630113919.GC7481@nvidia.com>
 <akRPkj5iNaNgIqNk@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akRPkj5iNaNgIqNk@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SY6PR01CA0042.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: c5952b8d-a78b-4e2c-9563-08ded7104be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K5ASB3j/RNc3zFWk9deTE0+2hreNKOA118imwDlgAn/nso8d5shVE2+in5fwtiQ52/XuThO0nsjgVoqLuchMMticsZmEmW9EN4YVuuTeIbD232Iogk4H0UcgkjTV5J1aYZKnOtK0sS70Um2f3BF8FU6ku5ikX1bbR9PHO+MVHSov8Mzd9kwIzytpeIm2mhBrwhoLxRF0zZfYKWbfPpAMAAFbO2kA982+DrqX6vDzniPWCXHuVPADosv3zPWMiCeXv89CHy4+jMQUOu4rp09+oc1rsd0XX1jo9k9lNiez0h095d0iUc9mvZL6yE/0RopwP0IEl8q1V05j8UlTXX9gPsAVPj2jSXny8YdmXEr073cTZRx5suHZZJpP+jXDwnuZybkb6CtW/v+1h7hQ4ppU9FTQML0bXsDZ0HaF2tZ3m93Rynzin5Mfy4dH2wHk1AsNaH83kPU7uid3HTotpZnkWU4wEDyfTPy4/+INdKw46NpAGCHt0ClbZDT5q9BX6hNW4OkVnYMvaj36h+t/u/Zo5v9OMMfUAHny79NVsZ9TTZdZn7LoOivdr6RXTw1hNbX2Y3Qpk97BcEDkwRgLfy7qX4CqE/OGtgefB9EPa5QrxgnBiemhFHn+ksokfvDd2Gavyw3xlwgVuxLOwUllMCh+k0TT82SSoo6cgriA1WQWQWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdAdYZNqjMKA77M83Ja5RzWoLwXkXo1cpCpxMh1wJgBxWHK5NBrIHsVGNQin?=
 =?us-ascii?Q?wmr4GZt6TCeRiBgHb+n4Z/mMkvh4qHwF0un/qIKoAuqNOavaDV87w1HZe5CP?=
 =?us-ascii?Q?lFr00MUsN6YL7uinUpUbxXNt8csSmcKlTEVWk5jerw/VCExf1VCI+50G1UXe?=
 =?us-ascii?Q?z7wujzdxP+3qHwi5KX1tambDf+zv9B5Yhskd3PxaJoBSnBDryBCo2ItfZBrn?=
 =?us-ascii?Q?4Gcz79sTq9XGOiDKiVzUkuA8GiQTlFgbhXXHm+j5HsVc7zbYBgh2149huyQe?=
 =?us-ascii?Q?PKKpiAsU+Y9LQfCppL1defwY0m+NBXGekT+/ppGCgGGiu/SqdBFVfIHXEXjX?=
 =?us-ascii?Q?mVr17L0Ybli4TwgnA+WJOZRD2l7qfqZkMza562epvRJR6h0R3ZYFWjjG4PL+?=
 =?us-ascii?Q?9jyYqgJv7GIyQgLljVfhjacehnT+cgKyM6ANx2Jd2Fg5J8L7NYC5cshGsDOt?=
 =?us-ascii?Q?fGq/PyEBF8FlJtSI4zXbgVWOAWkjqmwTQtwXZddAi6y5PY6NseF4gNIjWe7d?=
 =?us-ascii?Q?2qj1nKOhImAA2rHFucq6b3+QErWUe5o0HYGvHh+b2NOsPQ0osu0LhmWVT8y7?=
 =?us-ascii?Q?JyrohnNrmgYryq53Ufmjctu1lEEaDoLFachENyXBqB+as2kd3vuDkfBZY7AS?=
 =?us-ascii?Q?fFIt6rBrnIlfcxaZJaDQ9D5SqfLhSLGlCEuaSLUrfYQhgfOC3WPWFLd5Mfz/?=
 =?us-ascii?Q?cAIGcjoGz0vKmL9DxCwV44D6czshOvxRn8nXX8/YC0RG3dkFq9ynISu70yYt?=
 =?us-ascii?Q?/9taGDjmilpIWfEc3EEL7vNthRlGnY8s4A//QGxRn77o3o/LD3oXR+YBzRkM?=
 =?us-ascii?Q?wFs6yo0qIxqyGr0zL0WM9u4ehvoZlD4G62/g4xL7M0ZKWrhsuw7i1o/l2uzn?=
 =?us-ascii?Q?A3WvrMF7zf7cmpGyFlPzC6P7pXywPI45ilO56b0zFx4SV9jEkVqtVuaq458R?=
 =?us-ascii?Q?/bMGI4zoVnNRrvNh09U0rEQwxmuZzI2wI9RWUo4Rp3OH5j8yFP3oHmadqTqP?=
 =?us-ascii?Q?rnEt1kjWLLKPyCIi07u1ppZfIrEYzlEyPx1mswj75wZKCc+JxrB5dgrYbkNe?=
 =?us-ascii?Q?sZnCKGKxQF/QqGS1hwxK7d7+CJK6jgX7S/QSwxKZc1Gu+aw8oSxslMuRMNNb?=
 =?us-ascii?Q?T0dDcSu2hYNn0xkOhZIlqKWo8bTyuGn0hJVKJfRVWhTg70kyX6p4Pu5iW9Fq?=
 =?us-ascii?Q?BD//sYepgNKDhpyLFetNN6RXKefnovK5wA2RqhrXy4eRE0v5wxsJMqsGvObq?=
 =?us-ascii?Q?giFLNUmPcygLJ154CZMTfstTLCPLnKvF3CgYgnD6QyGK4zANUkxitrPrUBpo?=
 =?us-ascii?Q?rmZ7vzX2wGOf6Ta9nhrIXWCosKwPBmlHSpqzvlI1sYrjPDUhnbPMOJNlf363?=
 =?us-ascii?Q?139Ej6WQecAFd2WEOQIXdkbgJeQqFdRCqSh4bre9AAhKbVwfJg5XvPZuSC6m?=
 =?us-ascii?Q?X/kff9AcfoKOgbdy6FBrm/mKv1wI+nJkOdt+E1Mser/O4T8MfEKSXod6p6d3?=
 =?us-ascii?Q?St57rAN5ITfAuAIqZ/f7bOzItJxIFs9sf37aRIQYZC8FYj1JOBpN3I+w76WL?=
 =?us-ascii?Q?molXtsWvjL/b/AAsr+UZsIkdC5gF7KgaImMU+fg1sDRyXw3NUSuoz+s1KtCv?=
 =?us-ascii?Q?d1Ob6LCBnMGzo5CQ5JLX6k2ZA6ud2tAje0e4l5weY8znvj84zvUrdQsbhA9k?=
 =?us-ascii?Q?ifZJ9p5BipiBwN6j1PdmhBY4NX8SlyxxDlxbu7qlGyhsNJKSegdb3NvZvUgZ?=
 =?us-ascii?Q?BTqJZuJ1Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5952b8d-a78b-4e2c-9563-08ded7104be6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 01:30:12.7787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB/jqLluMizbVBy21YGa/aoRxb8fHAxdW8waNInJIaIKaFKizERvv8ydUiqFennZhOMQtTBS8kEtZuSflFZ70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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

On 2026-07-01 at 09:21 +1000, Matthew Brost <matthew.brost@intel.com> wrote...
> On Tue, Jun 30, 2026 at 08:39:19AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 30, 2026 at 07:39:44PM +1000, Dave Airlie wrote:
> > > I've been bringing up nouveau on NVIDIA Spark GB10 and fallen down a
> > > hole of why is the GPU writing to pages I've released back to the CPU
> > > page allocator. I've wasted a lot of time on GPU L2 cache and explicit
> > > handling for it, which might be needed but hasn't solved my problem.
> > > I've also invalidated and flushed the GPU TLB excessively.
> > >
> > > Today I finally hit up iommu.strict=1 makes things a lot happier,
> > > non-strict IOMMU seems to allow a race between dma_unmap_page and
> > > free_page where the unmap goes into the IOMMU flush queue, where the
> > > actual unmap are delayed until something triggers a flush later, and
> > > the ATS translations stay alive past when they should, and after the
> > > page has been allocated by some subsequent user.
> > 
> > It is a driver/device bug if it continues to DMA to memory after
> > dma_unmap is called. Strict mode is intended to increase security
> > against malicious devices and to aid debugging buggy drivers, it must
> > not be relied upon to have any functional effect on a correct driver.
> > 
> 
> I think I agree here. In Xe, AFAIK, we never call dma_unmap until all
> fences have been signaled (dma-fence or preempt-fence mode), after which
> GPU translations are rebuilt before the next fence is installed, or
> until the GPU page tables have been invalidated (GPU page faults). TTM
> is a little harder to reason about, as we DMA-unmap via
> ->ttm_tt_unpopulate(), but I just audited the call sites and TTM looks
> correct.
> 
> > This is not an API issue or an impedence mismatch, you have to follow
> > the DMA API contract when using the DMA API - meaning before unmap is
> > called the device is not doing DMA any more. It is a purely a
> > driver/device bug that the device is not quieted prior to unmapping.
> > 
> > You cannot fix this with any of your proposed hacks, the driver must
> > have control over the device and it must know when the device is done
> > DMA. Presumably there is a missing flush or fence that is allowing the
> > GPU to continue to DMA even after the OS thinks it has told it to
> > stop. There are many unique things about the coherent GPUs, I would
> > not be surprised if the driver needs some additional fencing
> > operations to clear the fabric beyond simple cache invalidation, but I
> > don't know.
> > 
> > Normally strict would convert these bugs from quiet corruptions into
> > noisy IOMMU logging, however in this case the GPU is using ATS and the
> > IOMMU does not log non-present ATS responses. Instead the GPU's
> > internal attempt to DMA will fail and the GPU will do whatever it does
> > to propogate that failure. Probably the driver has not noticed the
> > fall out, or it ignored it.
> 
> Right. We only have ATS enabled in Xe for experimentation, but whenever
> we've had issues with dma_unmap ordering in Xe without ATS, they have
> resulted in DMAR-related dmesg spam.
> 
> So TL;DR I'm guessing Nouveau has dma_unmap before GPU idle bug
> somewhere.

Agree with most of the above and this seems the most likely explaination. ATS
doesn't change much here - most of our driver still goes via dma_map/unmap to
access host memory via an IOMMU IOVA so non-present entries there would be fatal
at the IOMMU level. So even with ATS enabled a non-present DMA mapping should
still result in noisy IOMMU faults.

 - Alistair

> Matt
> 
> > 
> > Jason
