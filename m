Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E62606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MzFoprMv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3931B10E0EF;
	Wed, 21 Oct 2026 05:20:01 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A909210E0EF
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmqG+q10YyKBS3YpC2h1Zi/F0aXDC9CmRHJK/d6uakCMUJkC4LlhcRUnEM/atFuK5vckpnA8C/j/GLQm224mwd0ZQ7bqmCBSyFNPDGd0kdUUELndGn2Tj984du/27r4+9VCi6gVYPpab5FG1F7Lx9y+Divu9kkJlelZcdTVU7Rj1uoNAn3nIy6dcwb6vHeW1LfVd7igDhMGPCq4GO0+1Z7Ax5AaZiYpR0mcaHm+0eAvMBaDWfWmQUeYwZAbWnTUObFVJ/gWhh2TBUmIUqfgyvwxf3NdHlWkrSlyAsGYCiCiavbAZunsZyIVC9+gKK3G+MbzxHGSxHt1sl6xcDoapBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BRWYZqXcPz6hqiE1nzO4ZkAWMWsPglyBjbVZ2FWG6k=;
 b=FqEspRBc5+C89WXkjGa61yKhikeNG8YgMKQpUm/a9U/fZWkA+uMlILoxv4jaW/8zDs2G97hN5k8TR9uTD8+du3kvSkYCUoqIxIt8/VvEGzMPib+q8gq+k8gijCNZswBtLCnt855vrVMOQGb5GYFABYDTxMQGCEkHO2BFA6Ta0hGwsioE+dCRDvDaTlo7rbq1xHuECWOby1OL05oippv1X+EY73BYPehR2dTJhfD+4ZSlweYmdOXEFrhypkbVAspb4WeQE6LVsrqDcTqW7c0wPpwr+fr6DAunFAFljTSJog/bHYxZyf7pLRcKaVrvJXDvQzf8TLqafOg3B2poWLOOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BRWYZqXcPz6hqiE1nzO4ZkAWMWsPglyBjbVZ2FWG6k=;
 b=MzFoprMvaJ5hPOY2X3TIofez8sIPyh8KZ8Uexpmt+zBDOqmGggxP65E/A9yXypsKuBYnyX/1y4bpPXT2VQtL3IUFfoiWkTdSoeqjCujqjtvnswzOek0jkNCbTvrCrXdTO+lHgOCg4dbDIv+flM0LWaSCPlaWUbDjiRwwov+uRXhCwUcstPGMpuqZncDeqvDZlPMLGUCyXBPxszmvmyzcvm+uhivoqzYfCVBp8NImApr6rmoRDymSxGsoS7nQikcd1xK3PO238hdmuyvgI2zNYtYsg4RDGrdDjz7ccwhW1XIAQgvpBAy7zqCgfEZ33seEXfPMf0Is1MD/Wwhp0/DK2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by CH1PR12MB9600.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:19:43 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 05:19:43 +0000
Date: Wed, 21 Oct 2026 16:19:37 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Message-ID: <athLCINDCSUbRHiC@nvdebian.thelocal>
References: <cover.1792477872.git.kmehltretter@gmail.com>
 <atdKZpEJVZY0enR2@nvdebian.thelocal>
 <20261020182029.GH3008132@nvidia.com> <atgWXLYKOFj5cZ0F@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atgWXLYKOFj5cZ0F@gmail.com>
X-ClientProxiedBy: SY6PR01CA0154.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::13) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a15842b-a06e-4b73-4577-08df2f32ea55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Z/jCRlofg9pF+YJBrw6EsWn5UfzR5Y7vtA7k+tVjlxhacnb4n58OWIkOjS8DfvbgiJSmVL+8wVzyriEmssGLu+MwdCPPcrxpR5VjF8/XWjEudMNGu9pEQw0fO0cb2FCev/FqgjnMzwYDUc+FY9B/gIPuRyFxsH1facgg5G5bW5VsUZO+GI4+erwFZfdlX1ZXYHvo++e8AGxbIpC67MOzdC58q5XCZTCnqduaH2wBxBJjDinEQzXJj7ptbe/+g9vm+DCLKdQx/qBOQJZ0MxpiXapC1ecxDybingK+AvxED1sVMeglaqDRNz7q3CBLvhFH1TF8CQduX7FdD0FhGbCD6gpK3NYIl+ZaH77cF4hq9PM44at3TtbuvrjXkAH5ATmieZzgFrt8a3HMEScJ/pQ6RmMHg7cztTlQ/+nwDEP6WkVEWD3aPBPHZ8F9KtI6tQbaZFU1FMi9It88wQntr3QjMD/Bf8Wq8PeF3LCgxWT5l4/PmP/HBCeqro6IuwWaF+GMVtYqKYcL4uXZfJjxt0miKYiEQi68Y0lbM1vefPxM7FN5NdYoY6igj/gUSS88C4OpNt9a0ngUuR4nrMWLlGL5u7J0sRpb3YKqocryYxqgywaJ1lH6Vh3z7Szl+akYXoLjZNBAJadyaiyR3TpFvozX3UrPDYHm2k40tWP96zplqJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhNwvFDcteQtvV49V5/LBu9p4vjqI8Lx8cwTWs4mWLwToiiWMJgZ2EAX/fnm?=
 =?us-ascii?Q?bPikz/u2fqfLI1q/azpzdCPPjw6gVTG6wz820hy7+LZkPeOwwKevtcgxhRcp?=
 =?us-ascii?Q?MiDAwh3CQBpd5N8QKeUZGqnFWTQBuLcTg9p+u6biyx8wcf9ChVxNmVDbQR7y?=
 =?us-ascii?Q?IJ+7x2gzCQcuo63R8rP/AycBBXxWLxot89nPi+ccDCoMrMRH9nuSBPARsVQP?=
 =?us-ascii?Q?JTsHiA3sFSYpbeKYL992S7g90LUn/Hm7jHHNcbpV1aKFNaDBo/+YBApTN76L?=
 =?us-ascii?Q?i7MYfU5/6gp3fcBPEEfEmgfNW7O1jdZ56H5/P+0KzIWBQN3NqQJUjssK6AeG?=
 =?us-ascii?Q?VFv3KPimSEJI6uLi9Q1tKG0E43Qjq0fenrl+dmlAtREz7xEo1dduLJWTBshP?=
 =?us-ascii?Q?zRq9zZ4VsWpgOYeKOCjpVaoJoqFmoTImAXqI86z4IfHsGJYlddJfpbbQnrL8?=
 =?us-ascii?Q?135ovJ53ET2DHoYG9IG9pUGLsf7yNE9YJ2kfEpXtTnZaxVO2GrxTojM7GiYl?=
 =?us-ascii?Q?K5RAwheOWxWaVJroB1ewLUTtm6OLCvdbLnR7vIrlEN1xL/kDIKBxNL5H0t94?=
 =?us-ascii?Q?bhHL6BHzjNAvDKg1hHiwC1yrLTV3KUUaeZOeTxm0kYLfBMShcjsN+zwH41QI?=
 =?us-ascii?Q?4QwZmYrKuzsoFupk72Njh9fc94Iv73SnLlc6Y4u1/5LYLDgBg1WF2NTnhrp2?=
 =?us-ascii?Q?DsWHttzXQ9yyiONf8OTzcozJ9C0r1Z+x/JSL29wFKb0szAUzg7R+stHY1Zuc?=
 =?us-ascii?Q?TbUgc7yI5x2wd8357alZi6OH6EObOEX9vpZqFLwJD5fIn8vjXckh7N8PW5XD?=
 =?us-ascii?Q?cPO4WKrkFIgAIz7seVBw3dKIWQvgDBzXio7+ffKzEda4I626OkWmdy9yQIHU?=
 =?us-ascii?Q?mTN4k6NkQ0f4gzDchqd5SJaYvO4XhzMIrU26wwgnN/oT1VRHe+75FP4MDype?=
 =?us-ascii?Q?sHtao9TlDf3/NLZAKmOXsJ/oKBB78U+J49+pAf+Ejy+scNH0j7pSZpXQmtBQ?=
 =?us-ascii?Q?jELbOgAcjrc4BRNr2JfgonaJmmC5Kfx1j9+BZl+I3dJDI2hvfKo9mq4ot076?=
 =?us-ascii?Q?ri6X0NdNuXskbCV0qn2uzf/sZMn3dH7/Hq/hwf5XSJcaSVug0TrfEf2cuSDT?=
 =?us-ascii?Q?u2swbxGcYxBqvy8UbAvHJjIrz9AdzBemJ5LYUhQzdrY3AoheMWE/AjBPRHrj?=
 =?us-ascii?Q?S6LXVR+SFDg6dFQFFfz3444RZNAnGTucxbdSK4YqdjEej2NHOCnb1fsbUbY5?=
 =?us-ascii?Q?hkLSu58UsqvRcqTzvMp4PHwc56rsxzN1daHAjO9z/fhjOZB9UfO4K7IdsPXw?=
 =?us-ascii?Q?tntqjUWghqUluZwVcNpw34kiDMXWM71DSs6Tavag8WnNEGUyMeL/WN2L4VVU?=
 =?us-ascii?Q?PMCkoBHSAmwTuXwmGuNGRYqObvKTenIYhqXTAZ71mgaUMqWKqrCt5NcCbrXR?=
 =?us-ascii?Q?964Wq3d+LGKKlYhiTsw/Cx8y13nQZsh2ABXAU6o5bcHkCmYOZYFS3JgnOzBC?=
 =?us-ascii?Q?GgR7kOO3CBbWUjbrLRn/+nu2XaKi3TEiUSlAXYiNSOVvSDn5UJksgaN6jHDK?=
 =?us-ascii?Q?D+tNBbaK2tvwktN27gvilLPsCXLsW5WKI6P594ozBOq2tlXsy1LGTXiwiJbr?=
 =?us-ascii?Q?8d34xpsIG+hm8YjrYwovZLxIa8aN4tUX1notDJIdCwWQfiY5hnlUeJhPccq3?=
 =?us-ascii?Q?k4uOzK+aVgfnkSLUb4Nkk1ZM+9N5G42LZzNqX40ReamdhacbbWYQBya/JNnU?=
 =?us-ascii?Q?E4zl5g1gvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15842b-a06e-4b73-4577-08df2f32ea55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:19:43.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VYfe+7Q1ACM0QoHEmDXBBgbSODrU4hjb51S8IvdcFi6VT6nARcXCmYCxWZCq8tEdZRgSSG/7CWbeKKdzAEGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21 at 12:45 +1100, Karl Mehltretter <kmehltretter@gmail.com> wrote...
> On Tue, Oct 20, 2026 at 03:20:29PM +0100, Jason Gunthorpe wrote:
> > On Tue, Oct 20, 2026 at 10:16:26PM +1100, Alistair Popple wrote:
> > 
> > > I haven't had a chance to look at these patches yet, but if some of them are
> > > fixing bugs in Jason's series it might be best for us to fold them into that
> > > series, with correct attribution of course. Anyway I will take a closer look in
> > > the morning.
> > 
> > Are any fixing bugs in tree right now? I think one of them is already
> > applied from someone else..
> > 
> 
> Good catch. None of these fixes a bug in the current mainline tree. I
> based the series on the stale c37cf2824740d topic and missed two fixes
> that landed in mainline afterward:
> 
> - patch 4 is already covered more broadly by f2d70dbd3dce
>   ("iommufd: Destroy the pages content after detaching from dmabuf");
> - patch 5 duplicates Ankit Soni's e745cd2c749e
>   ("iommufd: Take dma_resv lock before dma_buf_unpin() in release path").
> 
> Patches 1-3 address lifecycle issues introduced by the PAL conversion,
> and patch 6 tests those paths.
> 
> My main goal with this RFC was to put the concrete lifecycle issues and
> tests on the table and get the discussion moving.
> 
> I am not concerned about preserving these as separate commits for
> attribution purposes. Please fold or rework any useful pieces into the
> mapping-type series as makes sense.

Will do. I hope to post a v2 later this week so will fold them into that.
Thanks.

 - Alistair

> Thanks,
> Karl
