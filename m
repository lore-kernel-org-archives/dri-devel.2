Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E93C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075B610E2D2;
	Wed,  1 Jul 2026 01:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLUACkqV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3171210E2D2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvDxIpekV8KzoK8GHWgVzwKYnf+ZPQHAZQNPNwYRQ3UK28YrSfd2HiWWWnC6ZlYJMR4mV2Mzfvg8WdW7ACu5mbLOY/+6CbDMXul+HTMGibZRiPtjkp6qMP4LtLRQvjwGBYxN8fTVPOIUExQVogsqpq6sLNs4WwKhW9If184yubn2MZqnbPPDlYd3NolsBa+CcMNzQqXx3vD8SmydB9OLUIX1RzyPbHLgNyQgaqXtxUkY1I87kobGRi/Ad3lrHjaZif5LNEfyrRnyzdfO5yl/F2kOzNJUMrhv7B1+nhX6PhFflMTItLe0mzHLPc9i9euzj9ENkQOHtYrj+cUfKYaqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkRN2rWL+H6lHfAUlXZEWdQfJtLXCTjFWVrBXkfRwJA=;
 b=Db7lg+1UGoHbEV+mK/uTp0cxlVVURsyNRO0JOumc0DA4E626fdhXlA6UoH06QbRISdqh1Fv2x1DgccHXsW3pTbid5cwHlYvlzAfeQetXBL1JKEhvvm2XM8TPYnXkd+jaa1yfMASLqUl0KD5julJP7vVI+NoYEfQWovOvfM4gZIdyI6d7qwwkvL16PDn9EcEatY5Vcki0Us1MZSiq8Tvi16jhCn4iXdX+F0jQY5Hk3Cn21HgHJpEoT3Vzu9gSDKCnZQIERM2LvvDUx+9Z73q2zGbqRKX5RcSpBGzAH7d1blFYnc0o9cVGvZ7AvKEmMRJeqar7dfa5WRD5MjQoIb0NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkRN2rWL+H6lHfAUlXZEWdQfJtLXCTjFWVrBXkfRwJA=;
 b=BLUACkqV3ioNYhkuBx3LuXA5aowfSXtjyg62n+RlYOpho9uGv9ySTAJ4LriXA7oqdVH5/WsKWD57yG77N8+dp7inxjGaBUNZaOzeJMIhAleR78rZe2rgcuFN+lxPuBgLM177Dqi8O0wpl/8SgKca+3r2Rr1/EXULuEUe06X/dN//ZfuGF66XVvVSUfi7pwAbrO3Zm/QfuoWvlbKW7p1hSKHDuuoQzp7pNw2yp5xMN8iOJrnF/ZDkbXDNECB2bjir1S1HzcmmbXQwA79uZpmRta6hE9tfdJ7CNyyFpwbi+zSiYo4MZiT5OLUg5h6009PPlhOkWA6yGe0r0AfxWEshYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 01:23:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 01:22:57 +0000
Date: Wed, 1 Jul 2026 11:22:51 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dave Airlie <airlied@gmail.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 iommu@lists.linux-foundation.org, Matthew Brost <matthew.brost@intel.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <akRqSz3lrKHh_GV5@nvdebian.thelocal>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
 <20260630115150.GD7481@nvidia.com>
 <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
 <CAPM=9ty=fiCTrfwE4VUGUDak7paNcKwVo9t171FyYP4VyGM=4A@mail.gmail.com>
 <20260701001702.GI7481@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701001702.GI7481@nvidia.com>
X-ClientProxiedBy: SY5PR01CA0051.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2b052d-6052-4138-9fc9-08ded70f481c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nfO9+yN7EMfiQHCYGkBvEzyhGyRWVKAlUA17V4+iOK66jtoVI2fssI4eAdNz2eDAXSv7rp7KzlxHw/PgSrDXS6xDZ+ofUQdRSgHA5U+lVlJbwcowXbdiNEDEiIlMIt3so0G5K9T3Airr9kBKI9NvwqzHsCWWhVuK8/No6K1dz78pWDRFiJQE6e11Z6lYr4BQc3FVAk8aRNSn/1QLHaEEUuAIVV/2TaJeWOpCweVzNNCnZgr9Apf9YAo6mcwKwqObFElrsdFvWOntaaUq3auOpVB9z6qs4bzwu3Ikm9mxYCHNBh1gJSpM39D61oJOYiL1s+vr/wGZv9aVRlWW9pQHFzYKy/++arA0h5nXVbAxXM9TI8hNK2RWw1FsafuPVzNBeSx9cze96gOvnoaT/RO6CEv+vxPwo2VqZLB2wvQiZyO3onX7e6yDEiszR5Oec79b7Z4A4XUtaoaNikFclgXLQ5tbG/6y5ivC7beZ4o0PalwwPaCfXTMU8/hc8vVvyriy+aMZWBe0VeMIUYY5Z0q213+CXoDQ7bbTB60Lw1tpTiP//pWzwC2gY/KnT7ZKQz5cGHMSN46E0YLagseBM2FvrsoOrcXCCckLhtRMCKORh+ca0lJQ/P0micS2OqvobbRdmjMphoOstaA7l8Kd25fFn3xCW3nbj0Rg4tJ9habsNzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xjunan4yO/Nz7kZDpw4z5eeL9vvlpH6mjfZbo/ZqtkJWxEeJBqPppJlQeRNH?=
 =?us-ascii?Q?S/0JOM/Ln+D8c7cdkoc0j43CNoZbl2i9/2fUu6ioIlcuIEi5MqTrhAnJKKxd?=
 =?us-ascii?Q?DD4rQQusBmTWoC5e2uAOMl1BdGUt6UCJZ3Q+xldttVdg7uC+ovgJBKuuZlSy?=
 =?us-ascii?Q?Khd0uLMCecmcPSA0nOLPFPMnPGUqkkodM7vOb+uz/AQVlvrzM93QX5YVPJ3C?=
 =?us-ascii?Q?n/wP27ryr9m+hu5OyVwZzoUFxbph3uzwIszZHdrXB3MS9/gRUXAP+g0qJ7oU?=
 =?us-ascii?Q?/yP5RC4VsUd8qARiXUfQC9M7ZK9XqNmDtqHbokENp9Yf26C4FXD7BYTGQWlz?=
 =?us-ascii?Q?fWp/cmEJHknhQb/mZnZK5Hl26VjCXkdsDfbBDcuQK1AGLWYJ0aEEMJ0qYZdD?=
 =?us-ascii?Q?Q2LNBW9LrYkITCpiOUaFJSJqqniuzfwiLWKXX1Tee5MxKfCRhGqm3qXdj424?=
 =?us-ascii?Q?qOHmYFd2XZ0S2UPYeQKu9Uc3vZxpb5LT5Kzj8loN4xNDY8GrXW4YfnT9Iu7t?=
 =?us-ascii?Q?GOJziAsarRT5AJ8kzwV1j/KaXZiZGko4ah4cA37cFjte2YEtUQQAJb5TjtjY?=
 =?us-ascii?Q?q3SxyB9O/GoS0hPWy58n7tJpx0/CSEhlN4McYWFT1nEerPnuuJmux+vSK3TG?=
 =?us-ascii?Q?SJA2BaCaEYPuwlet20Ebi2yyFXImZlq/C7S95UtfAwilG4tYJHL0nl9RPu5z?=
 =?us-ascii?Q?6CH26cw59E+qp9rUKGMAWLnmmPIhTNqCzooaZcmmOEiTRs4mTpLeyMNnCJHK?=
 =?us-ascii?Q?jJU3PmBmqhTXkbmctEqa6qauTYUr/jz4d4n5weZzpXPzy9jk3x/zUvILW3uj?=
 =?us-ascii?Q?TI5WuK1Pkr8bk+Y/fIkBVGWtNWnLeck6UpzfO2qeAal8Wepf7/hCQyFhl+Tq?=
 =?us-ascii?Q?V18D4fk6tkIvwW3OfiSkm9YpD4DJKCZ/ECrPpYlkYPdFlqcGu1/7oXj3F7ZU?=
 =?us-ascii?Q?glSFfosVtyPONbT2gzT9kAL/7hz40TZYg+/MD426XyDxk0L8gQkIp+ePIP2N?=
 =?us-ascii?Q?S5cEqlXly5JmYoX4zxNhmGXCryBXtH+p8qlCYvlaXaw4YGlFj4Q3Sl6/uJLN?=
 =?us-ascii?Q?cxoi/Y/jmuGILIkRzLdb76K072WYtiixf8gHnSdWBN4E0pzwuK8cfJ5OjNso?=
 =?us-ascii?Q?HKr2MldeLxHgz/+Tf8jIMq+0Rn7vJZOHW7bOUcxLr6+RiYQOuSwHvL/31JbU?=
 =?us-ascii?Q?OR+kaDrhMIGqY+AOR1ixsS6FeGJFGQurarpbjmP3475QKhwsKp+UOIvUtA+D?=
 =?us-ascii?Q?mJQgo4Hd29PuhqWpSfX73f7kEYimzhg97CiYrlsX7hBz0HqMNR6bZG4HOVG/?=
 =?us-ascii?Q?1UOOwSmddlcMQXsUER4HYgAPSIWRFCtVsOcGuDsiiYwlyhMLryP9hILMX1cm?=
 =?us-ascii?Q?eMKUAIqTYuMUS4W1PvFQS8AM7vWvf8YCxMnQu3CvIfGOAY+yS7Y0VsKEWixv?=
 =?us-ascii?Q?ulm0QImaVTBs+ZlydqE0Yx7FFoyiztXl27s5BLoJ4lXOAj+Pl0un9L1a1F7i?=
 =?us-ascii?Q?m0M9mGC6NS3574IQN3jFzEZlerkggUo1t589Fm++QL0FuFIETVQYyYByL19c?=
 =?us-ascii?Q?EGrxKkvPLHg7nMXB7tqdywZ+Fp9pUEFJMZZhq4vWSCMCnwdbxHBg/O99SVD+?=
 =?us-ascii?Q?KZGKLX7EAbrf9r8hrjP2wzUIqZtPBMgUJpVfYINzfwfY10E5zpt2rB57qHjK?=
 =?us-ascii?Q?U1IjkS5kJ/15x/sE++2qhnd+EffG0gzm+ofUVYzOLC2NVwJAm0ma5hEBhAeR?=
 =?us-ascii?Q?lplYi+aEJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b052d-6052-4138-9fc9-08ded70f481c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 01:22:56.9224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+eW2eJUu2nwRCtO3OO9NBQgPDdDSJqlO2DB1n7n1O7UpSAcVIDEeQ78fJM3CjBe/eE+ZoT+cah1hf0A5PQ9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968
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

On 2026-07-01 at 10:17 +1000, Jason Gunthorpe <jgg@nvidia.com> wrote...
> On Wed, Jul 01, 2026 at 07:00:01AM +1000, Dave Airlie wrote:
> 
> > From the production driver, there definitely was some issues in the
> > past, however this seems possibly fixed with mmu notifiers, but for
> > these memory allocations I'm doing I'm not using MMU notifiers at all.
> 
> Well, the comment on that is this:
> 
> // Fix for Bug 4130089: [GH180][r535] WAR for kernel not issuing SMMU
> // TLB invalidates on read-only to read-write upgrades
> 
> And the upstream kernel has that issue fixed, so it looks like that
> whole disaster compiles out.

Yeah that whole disaster is something we should never have tried to work around
in the driver. However I don't think anything ATS in UVM is related to the
problem your trying to debug. UVM ATS deals specifically with SAM/SVM - ie. the
ability for the GPU to directly access system allocated memory (think userspace
mmap/malloc). This has nothing to do with dma_map/unmap() as these aren't needed
for PASID ATS. We're also not using mmu notifiers to workaround any issues like
what you have described.

 - Alistair

> Jason
