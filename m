Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C73FC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7855010EE13;
	Wed, 22 Jul 2026 14:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ui3ylwAG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DD210EE08;
 Wed, 22 Jul 2026 14:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWCyjlIqpWeY8xW+nxGesvxQNI7t+c6kp60RYwMRg2uAnBPUnYpLEbfFbY5uxIuqZDfyFP2Aepemq7Y1QEwt9ybqH7qiZvWLjMfTwarTQAjbJKM+H01FrS0YyOfPLpIW8gQnj77/zk6NWhJUXiOmCn4HA8pwN0Ra4YbdvVf4WOX8vVqwtH+HWkq3ey+MsdjnajnwiIKnMHoUoDE5seLWbwaJgaUxI7RYsqvzu48aEG+/YIga0P2O2+Pbb2GqKOw1DX1CWkmx1bW2ss+dJy0I1XGKS1EogYV6PIqjFvcdDsvDiGvuxWGZAjBqeK0VrUS3KmRpeH7ZaIaarYxVvj+CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbX9ZrWVI1qDU+tPaarJoldwFi4GRNzdrNdZAxrEs6k=;
 b=rlJ9xjeOEtznlTf1SbysQRPQnugG90gYMJ4DuYywinTAaYMQ/TD7cRyhLITlQqleaYo7QkzNN6DY9Gbk+A57gSLJPQ7VKFNDtDvQjryJxwyWaNTmxAkbeZ8WjH+TIYN45+G16peSPopijdk+bF1/YEvNn8wzruK8uKOjqF1tKm9Jz8fiTxoI0O/FNXQJeXF+JUMjJK3vIidnyL/uSHiNfPr08oYw3LpwCjEDf64JykLcmDqG28A6vG9/PWjHtmRGGZsGfmdMXV+oCGEtDeFERX56E6raNrdKmF62Tled9oWcJWaYU2l66BQfazNR7XPTr4DRQfkZwm2JfGnsFYG86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbX9ZrWVI1qDU+tPaarJoldwFi4GRNzdrNdZAxrEs6k=;
 b=ui3ylwAGqIAbSEbnXSaGGib8vjFpadbBttllsyE04DlfdyhpamTO+MpvUH10tiHXH8n8lNh2H3tXfDVOGvA7bkuI9H836+SIEgo9/FTdyhGOzXRgXHTkaeUoCjCEV5Mf+3KKKUpAC2STzK//gCpAnTNK5C1ZS24D4o3N+uQhYaM7T9HQ+vVp2FHRUK0oECo1q7b99L/+kKu4ndyehy+ICzOQ7KoQTikKiq3UVD/ROa6ij+AY8VVHCaE1XG2NXlHxJe0qY9a1BEsNgwuoUFsME9JfYVCi6SGZD7G8vpst20+B9KvPqvTDWWqb47j3tndvBTHyFKWkPiFd8jGrj30qGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SAWPR12MB999268.namprd12.prod.outlook.com (2603:10b6:806:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:26:54 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 14:26:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 10:26:52 -0400
Message-Id: <DK564OOZ3JUK.292JORO9KGKEV@nvidia.com>
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Christian
 Koenig" <christian.koenig@amd.com>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Nico Pache" <npache@redhat.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Dave Airlie" <airlied@redhat.com>, "Matthew Wilcox" <willy@infradead.org>
To: "Matthew Brost" <matthew.brost@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260722044220.1110278-1-matthew.brost@intel.com>
In-Reply-To: <20260722044220.1110278-1-matthew.brost@intel.com>
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SAWPR12MB999268:EE_
X-MS-Office365-Filtering-Correlation-Id: ca32b1a7-bf7a-4155-b1ad-08dee7fd46d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2b30UpJa/QKFbDKxQXPMUZbmyiPkjLaWSh2KMiuBrmf7tZWMD8ymlRhbdXljhhv5hxhnCVneMQS3Cc6jAQi+EWtc6Qz+RtHpWNB5a5NdsjqL1dAXI6bagBiYaLkMU2V8kQduCWTTtQaLyss2mDxJsa0cnvZMBMT9DRrd/D+X2hyTsJYxUA7Kau43Swv2qJtOqCynLxzliSkwcMlWq6evLvPIvZCVypfr74BVJcMc4IKcz+kK9jJPhwV97MKBicHeWTN6L9Ymv625WQwl8E6HOJNOy73zRUOKrmclXDlsM6OYeREqdp/yD9Dvip2PiveZEo/N24D3RSh1ITdQD2ZoaOsreK9J1NuykwTRM5QqC8JjF4AmELYAZ68jo6ozScirtEi9JxcLR3AoJqsRMq5kdEG/iFxGzq4y649tWvrgPx+KZVa42xTmAJljuZsAcgwhk3WpWxiP6G1UpFiFiL24koQ/CvfpoBkZrA5NlSZ3iZMH5nPiyAtgzRzmhkGJ58+mjTWGoWjYUh1hbmUM4iBPzEnV/vPhxyh6aGn3UjkHg2OoC7vksnZ0ab5yInC2OPAmW+He+sgh/Ri2dvFls41APjdp/3VeQ5eSnrLRSTwbfpY3fPAc08DCB3MM4D0BtZBGQOzM+PObbpsdyZN8fUudQeMOuoOs84sVmKuLjRL7VzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnF6VWhidHk5c3JsVEVnSnZub3VGc20xaFZKRGVuV3pDSjR6R0JiNUhHdGND?=
 =?utf-8?B?TmYvQThzQkJoeW03cVBJUUlsRE9scDZyUnNMa2tWK0FYWDlkNkhMSk04amVx?=
 =?utf-8?B?dHB3NnlyajErUlFXSVpRK0hNV05vSkMzMUMxV0I1UFpYdjVNZWI0enZvRTQ0?=
 =?utf-8?B?ME1PWDBFMFB0UWFzVFFqajVmSE1IZUQ5eGdpS0tjZFB4NG5UVjFLQTdwN29w?=
 =?utf-8?B?Q1FXZDlrQktKSmlxM1FFUHRtdFBjVUQySkx3V25rT3oyV3NQQzFnTjBoRFRq?=
 =?utf-8?B?NXc5citobENJemtIaXBiOWFTVHBTc1VkeWNaRThlbW5ZZE01M3MvbElBNk96?=
 =?utf-8?B?c2EvS1NFTWIwTFkreWp4NWJtQVFKbEJSMWw4OWFZdFA1N2h0OWtvcXpsSUVK?=
 =?utf-8?B?cnlLYkhraVdJSlFSMDhiYjlBcHNpU29DMXY2RVh0MndxZ1laVGRKTE5seHZz?=
 =?utf-8?B?U3RaVkk4QTErMFhHeDY2NDY3NFR1K3AyTU1Nai9XeGFCa0g3bmhnUXdiMlVj?=
 =?utf-8?B?TmdodGxmOWhSQ1Ura0dObXN6S1pWL2F1NFN5NlhlMnc1cW5xamQwT3RtZlRF?=
 =?utf-8?B?Mlo3QWFTSzhnV0FVVC9WVnhtbmpKR05pV24zVkt0VDBuMVl0RFpKTlFWUm5M?=
 =?utf-8?B?MmdnNlppSFZLcXZvQ3BDdi9pLy9hcDlWd29UeWVKOUJEdUlENzNYL2R0L3k4?=
 =?utf-8?B?QU9NTGQ1cmxuaWR4aUhFWEFBaW9neEtZbXlkcXE2Q09hb2xQWnVZU2IxS0FI?=
 =?utf-8?B?ZGhBeGNrMmN2UHFXT3daN29pZENrN1FORjBJWGFCbTB2VHowOGtNN0RKcWVi?=
 =?utf-8?B?TkJXdVhSS1I4aWZkd0c5aGxscmI2a0Y3YzFZL0tTOTdyME1kZXdDd0FDZHhr?=
 =?utf-8?B?NmJZeGZDdGVHZm1sVmF5dmNZcUEvTG1ubk1qNk5tTzlCM01IU1V3dldJTThO?=
 =?utf-8?B?MldwOXRDT1R2c25pZlliWnZQRkdsTFlMcXpBOEF5MEw0TXBSWEZ1MVN2b3F6?=
 =?utf-8?B?UVBUcUZ1UjVueldkWVFpRXk0WHliS3puc1BpVmRJQTVLMUpkOHBNTWxJZEtu?=
 =?utf-8?B?ZEwxMTFtQkV5bVcvejVSdDVqUTcxRFNQK3FYbGFMckV6VnFoR0hMQzNxWjQ2?=
 =?utf-8?B?OUV1MkdFaFkrT0xNQW9MRVU2N2VJRWpjV1MzMEtFTGlSNVBZbUtIZ1RveGl3?=
 =?utf-8?B?YWtyank4WkxtQVVkQ1NFNXdQWHE5Z0F6eTB5N2FQdlVYWUZqVk0ranZOZHV1?=
 =?utf-8?B?SmY1bU40VkJMaUJrSEFUY1VIbWQydkJUaE5ncXovOU1CZ2lzelpURUM2VFZt?=
 =?utf-8?B?V3JlNHZZTHhZR2wveW9YL2FQRXJna2FVWFNwc2NsSDI1UFRFTjFHZkcrbmU0?=
 =?utf-8?B?a3VpQzQwbnpYMGZpcTQzSW5zclhkdnNhWGlTQU9iU2FZeVhnRmYwQkFHVVZI?=
 =?utf-8?B?a3VMV3hpck4wSkIyVUM0QjlhMDZ5RlhlUVVRc0E0aTl3OG9nRFdVbk5pN25M?=
 =?utf-8?B?MC9jei94VUlRSlBQaVFhV01iR2ZsSVNrallEZVFrQXZEN0U4UHZrcFBWMEpo?=
 =?utf-8?B?cWRWbGg4TnRFdDEwa08vM1FYcmRtSTUvOW5uMEc1bWFjYytQSElIUDhFMFRH?=
 =?utf-8?B?QWt1OVgyMG11RXVhYVlSaG5DZ2pMZTNyV05xUndMdVo1NTFHNFRJMGVWQlg3?=
 =?utf-8?B?b0dkV3FCT1RsYzZQVTBJNUlEdDkrOWV2MHNia01sWG1wbHYzYWsrS3d5SFY5?=
 =?utf-8?B?WnBZQnNNZGVsdm04M3NTOFhXMFAyOTZTb3cvTG5EbzRSbGtVVGVKQzkzdVJn?=
 =?utf-8?B?ZUFpamw5akJiM29icENoSW4xcEtlYmlKMU9sWHQyd0lrUmNsV1ZPbzNMU2VZ?=
 =?utf-8?B?NkJmWWt2bEkzaXNwZUsyMDRKdWxiMjBFbVZrcmRpa3B0SnhKNnZFYW5KZjZT?=
 =?utf-8?B?ZTFoekEvZW9JVzEvb3dlNm81b0ptM3dQQ1VRbUNtRmthVC94VFNKNmhZeFoz?=
 =?utf-8?B?Q0JZQ0RwTGtFMytWRGJKaDlmM0dyaE5vREhydDlqYzMzRm9MaGpsNGZtaTBE?=
 =?utf-8?B?SUpMSEJFSlh6TWFyYURrNGxpQUxHRXRYSHErR2RqZ292MWVqTDRBU2FJRTNZ?=
 =?utf-8?B?Ym5EMGxoak93MCtzZVVaOTdhay8rQXFFMkJhNDMyYVorZEtNNHV4dnRKK0dU?=
 =?utf-8?B?KytYUzVRbEE5SmFCUEhmdStYTDh4S1lDRXl3ZWhDdWdYdjdzNVhXQmVtVmsz?=
 =?utf-8?B?TlloZDB1UVJBcTNsVGEyLzlTcUZSckRxM05FOGZHQ0Y4ZUVOOTNjcnlJUW5B?=
 =?utf-8?Q?/e5mv51HXZVrmqHE2g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca32b1a7-bf7a-4155-b1ad-08dee7fd46d1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:26:53.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXgjVx/9sAwp+31U4gG3kdzykI+NK7EFZ/OII/oXZw2lCzX1ohS5p/mJDinz0sik
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999268
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

On Wed Jul 22, 2026 at 12:42 AM EDT, Matthew Brost wrote:
> Add a lightweight structural split primitive for large (compound) folios
> that a driver allocated with __GFP_COMP and manages entirely by itself,
> outside of the core mm's view.
>
> The existing split paths - split_folio() and folio_split_unmapped() -
> are built for folios that the mm owns: they perform a refcount freeze,
> walk and remap the rmap, and take the anon_vma / i_mmap locks, and
> folio_split_unmapped() further assumes an anon, pagecache-style refcount
> model (nr_pages + 1). None of that applies to a folio that is:
>
>   - singly referenced (the caller holds the only reference),
>   - not mapped through the rmap (folio_mapped() =3D=3D 0),
>   - not in the page cache or swap cache (folio->mapping =3D=3D NULL),
>   - not on any LRU or the deferred-split list.
>
> For such a folio the split is purely structural: because nothing else in
> the kernel can reach it, there is no need to freeze the refcount or touch
> any mapping. folio_split_driver_managed() therefore performs only the

I do not think so. PFN scanners like memory compaction should be able to
see them, unless you mean something else about "a driver allocated with
__GFP_COMP". You will need to freeze it to prevent the to-be-split
folios being touched by others.


> compound and split-accounting teardown via __split_unmapped_folio() and
> then hands each resulting order-@new_order folio its own reference,
> mirroring split_page() for compound folios. The caller keeps the original
> reference on the first resulting folio and is responsible for freeing all
> of them individually.
>
> The immediate user is TTM's GPU page pool, which allocates higher-order
> compound pages, maps them into userspace via VM_PFNMAP (never through the
> rmap), and needs to split them into order-0 folios under memory pressure
> so pages can be backed up to shmem and freed one at a time.
>
> A CONFIG_TRANSPARENT_HUGEPAGE=3Dn stub is provided so callers can build
> without the split machinery; it warns and returns -EINVAL.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: GitHub-Copilot:claude-opus-4.8
>
> ---
>
> The patch is based on drm-tip rather than the core MM branches to
> facilitate Intel CI testing and initial review. It can be rebased onto
> the core MM branches in a subsequent revision.
> ---
>  include/linux/huge_mm.h |  8 ++++++
>  mm/huge_memory.c        | 63 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index ad20f7f8c179..35661d82d54a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -402,6 +402,7 @@ enum split_type {
>  int __split_huge_page_to_list_to_order(struct page *page, struct list_he=
ad *list,
>  		unsigned int new_order);
>  int folio_split_unmapped(struct folio *folio, unsigned int new_order);
> +int folio_split_driver_managed(struct folio *folio, unsigned int new_ord=
er);
>  unsigned int min_order_for_split(struct folio *folio);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>  int folio_check_splittable(struct folio *folio, unsigned int new_order,
> @@ -656,6 +657,13 @@ static inline int split_folio_to_list(struct folio *=
folio, struct list_head *lis
>  	return -EINVAL;
>  }
> =20
> +static inline int folio_split_driver_managed(struct folio *folio,
> +					     unsigned int new_order)
> +{
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
> +}
> +
>  static inline int folio_split(struct folio *folio, unsigned int new_orde=
r,
>  		struct page *page, struct list_head *list)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..06f9a5f35df8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4185,6 +4185,69 @@ int folio_split_unmapped(struct folio *folio, unsi=
gned int new_order)
>  	return ret;
>  }
> =20
> +/**
> + * folio_split_driver_managed() - split an exclusively-owned, off-LRU fo=
lio
> + * @folio: folio to split. Must be a large (compound) folio that is owne=
d
> + *         exclusively by the caller and is invisible to the core mm.
> + * @new_order: the order of the folios after the split.
> + *
> + * This is a lightweight structural split for folios that a driver alloc=
ated
> + * and manages itself (for example TTM's GPU page pool, which allocates
> + * higher-order compound pages with __GFP_COMP and maps them into usersp=
ace
> + * via VM_PFNMAP rather than through the rmap). Such folios are:
> + *
> + *   - singly referenced (the caller holds the only reference),
> + *   - not mapped through the rmap (folio_mapcount() =3D=3D 0),
> + *   - not in the page cache or swap cache (folio->mapping =3D=3D NULL),
> + *   - not on any LRU or the deferred-split list.
> + *
> + * Because nothing else in the kernel can reach the folio, this helper d=
oes
> + * not perform the refcount freeze / remap / anon_vma & i_mmap locking d=
ance
> + * that split_folio() and folio_split_unmapped() require. It performs on=
ly
> + * the compound and split-accounting teardown and then hands each result=
ing
> + * folio its own reference, mirroring split_page() for compound folios.
> + *
> + * The caller is responsible for freeing the resulting folios individual=
ly.
> + *
> + * Context: caller holds the only reference and excludes concurrent acce=
ss.
> + * Does not sleep.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int folio_split_driver_managed(struct folio *folio, unsigned int new_ord=
er)
> +{
> +	unsigned int old_order =3D folio_order(folio);
> +	unsigned int split_nr =3D 1U << new_order;
> +	unsigned int nr =3D 1U << old_order;
> +	unsigned int i;
> +
> +	if (new_order >=3D old_order)
> +		return -EINVAL;
> +
> +	VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio) !=3D 1, folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio->mapping, folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> +
> +	/*
> +	 * Structural + split-accounting teardown only. No mapping/xarray, no
> +	 * refcount freeze: the folio is frozen-by-ownership already.
> +	 */
> +	__split_unmapped_folio(folio, new_order, &folio->page, NULL, NULL,
> +			       SPLIT_TYPE_UNIFORM);
> +
> +	/*
> +	 * Give every resulting head folio its own reference. The original
> +	 * reference stays on the first one, exactly like split_page().
> +	 */
> +	for (i =3D split_nr; i < nr; i +=3D split_nr)
> +		set_page_refcounted(folio_page(folio, i));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(folio_split_driver_managed);
> +
>  /*
>   * This function splits a large folio into smaller folios of order @new_=
order.
>   * @page can point to any page of the large folio to split. The split op=
eration




--=20
Best Regards,
Yan, Zi

