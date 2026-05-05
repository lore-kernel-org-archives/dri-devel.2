Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A8CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CF910E94B;
	Tue,  5 May 2026 07:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n2o6n2GC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CF110E02E;
 Tue,  5 May 2026 07:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpOhF88UA5Afw/WjYxk1wJvlGLqAuR/+JXXXTzmrc76x11h0ycztPtUH5Ssrk0wWUTbVKC47LAdzCwAEAlQtjNUJeIgvJHFVZF8ZXhzqDUUBj9arvOTFF/ytCJzAxVqS7bcSYZUNFOnHDqlS8hzhhCWu41SJtbZqHvvu/DaIuWau4rcJOOuJgsKR6ZL6GeiPVP5fnXrbdvQZQLdE5GtI/JxH6KJJcvIjtJX1H3Dj3xgpi8ALUir66SFGxRDmMN+EN+3etp8wG3zuDj3NilkE1szv4V8J4BEUzDoeZD0SyzQrTlJY9mWna0ucVKcgXvJHSH+wFP9IwSkOBrVjXJr8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6Fzw+i5PdLV0jCGLaR/tQ1b+6imTQfTWQzWx8o+0yE=;
 b=YqRfY0A7DVvBkYzzWfRsshnC9wleMcWd8HvgbhAm4youQdJimW5+q/Fdkc+fcn7XMAZ2YVoR0FiMeKuPqrw0sd83KPk0ZIoh6yvTMLEOJVvHnR+J7oeO1MCMoVb8DcXB0Z/Wbic//XmQ7IgApsp08Z4UTnTZhLAYoksoNCOBZhRS+b/7rMkcmys0easSA8bnLRkszbXJ31YwGJKgJPfc9knEcUznbYg8nRV1M38v4eqgeqvy88GJkxnAlFgOMP1Z5rNKDxrlKAG9N2POABF3qcaP2+FQbVEOYoG15wKGzeFs9b9Wbp4Ac21QyOkFb+WddEnfk+gyIKd1Q4/R7z6rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Fzw+i5PdLV0jCGLaR/tQ1b+6imTQfTWQzWx8o+0yE=;
 b=n2o6n2GCUHcIWkrhaeHebUhs+orxG0Jlw4PuuHaY0M5SjaJYY/avo8ODt467iPPsqkZR1f/LBzfFMUP2TjVVreIxWKPBI5WV0vwjbcitSshBjbNrFiuZO0UWINaEqNl+GurpON5tdmI9jJfiXsbv2wldLt3QA12RP5otJTcaf3DrOC5sNEHh/19L42QJM7fWg3SOBDbXiyLbkbc9bQL6OnghY0XTg71nIdKMOxqPYhbOb+p/wP3RHkN9DHtYU+GE+cIfM1ysShU0ihh7Z6G4yTwwUFvSjLHgvqKTESGvUZPZHj1PorKlq6yPpcFLq3emXjWExz3LfZPMJNDpwpHV+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW9PR12MB999207.namprd12.prod.outlook.com (2603:10b6:303:301::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:09:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:09:46 +0000
Date: Tue, 5 May 2026 17:09:35 +1000
From: Alistair Popple <apopple@nvidia.com>
To: mpenttil@redhat.com
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v9 0/5] Migrate on fault for device pages
Message-ID: <afmXIq8VY_vs1GPo@nvdebian.thelocal>
References: <20260505051658.2219537-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505051658.2219537-1-mpenttil@redhat.com>
X-ClientProxiedBy: SY5P282CA0168.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW9PR12MB999207:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1c1930-e905-42f7-7948-08deaa7549c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iHsEgscFTB2R22meCylDwQ3g/T8T4vFrwrNu8cX8ElweejNPhqZQ3of2/gbGf47XAqi9WcItWQWoxRN3TTZj8RdyKnXlKHaKEoB4jEfxN517Nhn/EPnSnI/uK5s19eq+jVG5bquvJqFei3hpC8Mr/ksBKLMBoFTYn+9hQB3i9BwENQl1x2JpH2BuWbKqqChGCFu+SUim5ipnUeFCjj20riggo+rAufGhauCCdbtLmEXJR3VPLqvZXSdumDg4gd3ziEIDcNxFFM/NyHbMUM58zkBt3k6v2xCeYqsRemeDHGL4xYxooe9CIIeFAbgWarmhozxxuiJ52O1rtj1sp5SueXhDjD9n4UoZSbc2zJd2lBQS5HgNTAcyM58YEU1QZXbvm6bnEwUJm5y6IyP4purIaxxuCu08Q3Cfuh61ariWdjvI9RdL8guQVqYbK0qMlD6dlv+1mNyh0f0ft1o+tLphU06y7upD0rm8YjbP/t0lFP4FT/n8Vkppc6t3ajihf/Qn8hgQyNfuLnUD7eUZhJl4Lf9+lbU1GNoxpo0TMyZQQ0/WRk6ENrtQm9t8WkqNtbeuw5ZLBR79GRe6hu5dzDNNoJySxDnKs1ftKa+FtgT+0Vo2Zl7tqVS0GGb1h8tDQwcBLSeE3eHuEu/zXxNIvijCWuMu/jYHTGVnsfn5auQlHKITUlO1sowv9SFv1ymbPIeKG6m/90OVVgtewZ6+kQ3QTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?L6R+V2nuKwb+x6CwXCtifeOqWRYd7e0PZeJDM5xXCZ1MNmiOhGhpfi/knP?=
 =?iso-8859-1?Q?ykKQoMTK3OZODtdspJCp1srRa3R/mh9jpX9SU261wf6lrrK0bxXefoIJLV?=
 =?iso-8859-1?Q?zPA7jwvfI1LpchyoLNPqNa9euilwvxjMSHCJt0nzyzlrmCCw4kQ7a+Uw0S?=
 =?iso-8859-1?Q?VVywUXCF7kxwLW8Dw7XkmJnK3zAifZaT+4FcJKCNtYxQhGplmW/Bv0YJxu?=
 =?iso-8859-1?Q?jU3CqIxdOnmlBU/sMlkt+I4c1WQQ5pYGx7Ka5aN7ixg4/y0aVHNr0EIDZt?=
 =?iso-8859-1?Q?17FpxM6xeYwhGs2CW4ASaddXkbBN69EwjYSwBfQTS3+n/QRldcefPkcckt?=
 =?iso-8859-1?Q?zCYYWYnpDaeKa2L6X3QexcbCOGucBUbXnOphiCfrjTLXDoDM49Koto0Nc3?=
 =?iso-8859-1?Q?NKReod4C9JKYab1g916emfKzG9aN1YlycQJGpUNx920BjmsJOnUCsX7QHQ?=
 =?iso-8859-1?Q?QiDjv9BHUdUofrqlf+NAjVCcjp61LnpWf/Etzw1f5gMetlzdMFuA2cZcgP?=
 =?iso-8859-1?Q?6nrUX147Gg/IcXiI8I5itUDqhqwcj7KeKPZShs3287+KkJZYdMm3p4Jj4d?=
 =?iso-8859-1?Q?kqDFsAyIhzJyVu5nh1mMPqQEB9poLNxk2CaRHx3QODMRTu1WHW//ikLw/8?=
 =?iso-8859-1?Q?JTcKtVoHSQgG3rRYoQyFqeswDa7GFa4aYDAKDOzrPPMfhwbuXy4qNUi1XC?=
 =?iso-8859-1?Q?LD3m1SubtZCMjmtXr/6VYO/RbSIOYEU3Wv3Rs590U/RKff4doOIFZhyPxz?=
 =?iso-8859-1?Q?rXaNAFBGXAsW1TdN9MEUZF5KwDJtQpwe7mp2gAjhJvPbq1OBzjKZsBgy3t?=
 =?iso-8859-1?Q?AxSQDkigQNFOhPe101luVV8iZ4EJguI+BzcqXw6RmJtXyVQKcwOBXh5Mzn?=
 =?iso-8859-1?Q?9PHemg28cFitGkskRDxdlk11Ht3VwkGfIG1jTEFIkhBodeY/IiIAvKcLkz?=
 =?iso-8859-1?Q?RpNphpvDCmAUXoVmYanLzlMsWlOhVJsyAq8187LNMnJa2y9nv4ooDwsgY3?=
 =?iso-8859-1?Q?m5H4aDCwmloPOkcUigDiS9C9if933x1tQTK8k/2NdmhA77XtMSfteypEED?=
 =?iso-8859-1?Q?9jiacBqzii1eAMnezTZVkdb6vOj3o+TH57CKSiAzBEhCxVWGzfMUroeAIj?=
 =?iso-8859-1?Q?HGE6Ihqq6x3LasWVCCa7DLFUKH9fkywDPgoKM2TBRin0hCZY1pCRSFUop0?=
 =?iso-8859-1?Q?Hk7gUZ54e8j3hxdMlokWssh70Ci1MuN1q1A/OgimJ2MqcQ6a2sykyDWXVA?=
 =?iso-8859-1?Q?hbDvxajNiYZWLIN2U5gJsaJIcEqGWAUIfCxrMo09v/NrE5tVxMOVmNiRS2?=
 =?iso-8859-1?Q?rEAc5LFgMF+2E0k9nKiMufj8n7l+IVjm9dS0ymxwNuhu3oXeW3igR7j5Rw?=
 =?iso-8859-1?Q?RPX/r3fMKMCE7EWlVy5ZBtF849/E+mwWCXjlxB7i+EErTsgaKVaopoMLoq?=
 =?iso-8859-1?Q?7bjOkMevbgfkqERdFm1s3EfPt91c8XB20DtQBMbV0sIiaoGw6xYC/BWcx6?=
 =?iso-8859-1?Q?ikOi23Tg21c9bPAoja5VKnKTqh/0RSgQy3VdMcPwMunJuAMi04kYQVWM1T?=
 =?iso-8859-1?Q?sq4bYpE5Ueof4MnDv9bwXInzikKX8aI1l00H+FPFsE65tD2wB+9Hw01oZT?=
 =?iso-8859-1?Q?7ULuC6fvCKWQHNjXKvcLOxDGaoFKszbC7c89oNS1KQd3RGqtJhgFotRc0K?=
 =?iso-8859-1?Q?lJaf0eKPu3w6XWPjb8D2qe4VEYSmjqutFWNhGsJ4lyTKmz/KOU5aDsBCQq?=
 =?iso-8859-1?Q?IiWkZZu9EoZu4FfTp1kzP28OxCQaGRvg6qjr7gBuFa3OCv9cCW/3z3haTI?=
 =?iso-8859-1?Q?NVdt+2T6dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1c1930-e905-42f7-7948-08deaa7549c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:09:46.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAAaK/FhXHDk1d7vdrvWrnG2RzSEFtFTGUUhn93Ysp76/j3/BDmRzAVA/kBf9dy9qNwbfMg9dOWNYLx61p3XOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999207
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

Thanks for doing this work Mika. I've been meaning to take a look at this series
for a while. I'm currently at LSFMM but will try and take a look this week or
next as it sounds quite useful.

 - Alistair

On 2026-05-05 at 15:16 +1000, mpenttil@redhat.com wrote...
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> Currently, the way device page faulting and migration works
> is not optimal, if you want to do both fault handling and
> migration at once.
> 
> Being able to migrate not present pages (or pages mapped with incorrect
> permissions, eg. COW) to the GPU requires doing either of the
> following sequences:
> 
> 1. hmm_range_fault() - fault in non-present pages with correct permissions, etc.
> 2. migrate_vma_*() - migrate the pages
> 
> Or:
> 
> 1. migrate_vma_*() - migrate present pages
> 2. If non-present pages detected by migrate_vma_*():
>    a) call hmm_range_fault() to fault pages in
>    b) call migrate_vma_*() again to migrate now present pages
> 
> The problem with the first sequence is that you always have to do two
> page walks even when most of the time the pages are present or zero page
> mappings so the common case takes a performance hit.
> 
> The second sequence is better for the common case, but far worse if
> pages aren't present because now you have to walk the page tables three
> times (once to find the page is not present, once so hmm_range_fault()
> can find a non-present page to fault in and once again to setup the
> migration). It is also tricky to code correctly. One page table walk
> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
> 
> We should be able to walk the page table once, faulting
> pages in as required and replacing them with migration entries if
> requested.
> 
> Add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
> which tells to prepare for migration also during fault handling.
> Also, for the migrate_vma_setup() call paths, a flag, MIGRATE_VMA_FAULT,
> is added to tell to add fault handling to migrate.
> 
> One extra benefit of migrating with hmm_range_fault() path
> is the migrate_vma.vma gets populated, so no need to
> retrieve that separataly.
> 
> Tested in X86-64 VM with HMM test device, passing the selftests.
> For performance, the migrate throughput tests from the selftests
> show similar numbers (within error margin) as unmodified kernel.
> Tested also rebased on the
> "Remove device private pages from physical address space" series:
> https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
> plus a small patch to adjust with no problems.
> 
> Changes v8-v9
>   - rebase on drm-tip
>   - fixed uaf around  migrate_vma_split_folio() usage
>   - added missing pmd unlock
> 
> Changes v7-v8
>   - rebase on 7.0
>   - fixed subject in two patches
>   - enhanced commit messages
>   - squashed patch 6 into patch 4 to fix kernel test robot warning
>   - readded dropped Cc block from cover letter
>   - fixed white space
> 
> Changes v6-v7
>   - rebase on 7.0.0-rc6
>   - added documentation and comments
>   - denote to be migrated zero page as HMM_PFN_MIGRATE alone
>   - got rid of HMM_PFN_INOUT_FLAGS movement in patch 2
>   - picked up Acked-By from David for patch 1
>   
> Changes v5-v6
>   - rebase on 7.0.0-rc4
>   - use range based TLB flushing while unmapping ptes
>   - gate migration behind HMM_PFN_REQ_MIGRATE for fault and
>     migrate paths
>   - always infer migration flags from migrate->flags only
> 
> Changes v4-v5
>   - rebase on 6.19
>   - fixed David's email address
>   - fixed link issue without CONFIG_TRANSPARENT_HUGEPAGE
>   - refactored into smaller commits
>   - added more comments to code
> 
> Changes v3-v4:
>   - rebase on 6.19-rc8
>   - fixed issues found by kernel test robot with random configs
>   - fixed typos
> 
> Changes v2-v3:
>   - rebase on 6.19-rc7
>   - fixed issues found by kernel test robot
>   - fixed smatch issues reported by Dan Carpenter <dan.carpenter@linaro.org>
>   - fixes to lock handling (pmd/pte) on errors
>   - added assertions for pmd/pte lock states
>   - other issues discovered by Matthew, thanks!
> 
> Changes v1-v2:
>   - rebase on 6.19-rc6
>   - fixed issues found by kernel test robot
>   - fixed locking (pmd/ptl) to cover handle_ and prepare_ regions
>     parts if migrating
>   - other issues discovered by Matthew, thanks!
> 
> Changes RFC-v1:
>   - rebase on 6.19-rc5
>   - adjust for the device THP
>   - changes from feedback
> 
> Revisions:
>   - RFC https://lore.kernel.org/linux-mm/20250814072045.3637192-1-mpenttil@redhat.com/
>   - v1: https://lore.kernel.org/all/20260114091923.3950465-1-mpenttil@redhat.com/
>   - v2: https://lore.kernel.org/all/20260119112502.645059-1-mpenttil@redhat.com/
>   - v3: https://lore.kernel.org/all/20260126111939.1332983-2-mpenttil@redhat.com/
>   - v4: https://lore.kernel.org/all/20260202112622.2104213-1-mpenttil@redhat.com/
>   - v5: https://lore.kernel.org/linux-mm/20260211081301.2940672-1-mpenttil@redhat.com/
>   - v6: https://lore.kernel.org/linux-mm/20260316062407.3354636-1-mpenttil@redhat.com/
>   - v7: https://lore.kernel.org/linux-mm/20260330115611.347988-1-mpenttil@redhat.com/
>   - v8: https://lore.kernel.org/linux-mm/20260414041226.1539439-1-mpenttil@redhat.com/
> 
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> 
> Mika Penttilä (5):
>   mm/Kconfig: changes for migrate on fault for device pages
>   mm: Add helper to convert HMM pfn to migrate pfn
>   mm/hmm: do the plumbing for HMM to participate in migration
>   mm: setup device page migration in HMM pagewalk
>   lib/test_hmm:: add a new testcase for the migrate on fault
> 
>  include/linux/hmm.h                    |  19 +-
>  include/linux/migrate.h                |  26 +-
>  lib/test_hmm.c                         | 101 ++-
>  lib/test_hmm_uapi.h                    |  19 +-
>  mm/Kconfig                             |   2 +
>  mm/hmm.c                               | 835 +++++++++++++++++++++++--
>  mm/migrate_device.c                    | 583 +++--------------
>  tools/testing/selftests/mm/hmm-tests.c |  54 ++
>  8 files changed, 1066 insertions(+), 573 deletions(-)
> 
> drm-tip
> base-commit: 94d56a898a2db27f841b17f6966a81ba502fe63c
> -- 
> 2.50.0
> 
