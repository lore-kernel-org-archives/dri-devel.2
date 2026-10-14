Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB6CCC6B27
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A52B10EA3C;
	Wed, 14 Oct 2026 15:57:50 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8546710EA3C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXiPw9jBE3zEgAfQB/MR6HZiKOsDupeq86tyyWeCTrxXh5kghm32RBHTi321CsT14rNYA9xD93iMtPWsuZZVOCX/zsuWENjkd6P3OeVgkd4fXNOBtsuW6//UJ7ZsQJJn0rHKgDoaMUtW3VVPyK7bvWLlYu4ELZA+2kdAVffIdj5ibcl2t9tB5OU5zocGzuXCxGUqMiXpnmVOPyuus+LyUc40DelY7v+nHOzYxeL7O1FP+XQ+N0MuZtiob+VALhqo+Moz7g8kwmeyxEg7k+mfUFQgsoLvUxPSAW54RhcI8imY99dnl62++KyX0Dp/wQDDo90wTGBa/uA5DNUtJfvnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak/GRoxtPd9wUY5LzDypLCXKUGLNOsekS0T+T4BkU9o=;
 b=R49OX1MBZmJ4v/zRj1MR7x5JPljVsrvnPVG6AX1sxcqQYsmIyKsSdbvH51OO9FQ9NgdhncGEX3Lmne1cJS69J7gMc+W/vG449rBNArZrrVfXA9J9sNJ51fnPxdQCsGqBFJSHaZevfDZdFtRb7+WeQbwJ/kuqHTpMubRa9ZTVW0bQt3CBrM+264pzR0M66jOwa6hchvbttmYSJb/veDYI6SOaUUWzXXPtRWAa7T8t5iim4anQJqn6+2SzZsoEgI4TF2GF36qAJjSIA4S6Dfi4tAcaW449KXbMCuembi62rbHVc0JFwfI8U2boIMoco5fW4+O1pcmvA/HhLjLbn938hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak/GRoxtPd9wUY5LzDypLCXKUGLNOsekS0T+T4BkU9o=;
 b=fZXYAkclmIhtCD+rF1m4+6Pb4z5ZkOGs34HqbLy7MyfaM9nUXZr2PCBlHgbpg2XCcaeurLr2/fe7SsDpyGtRJPjd6bmU0pBQauMYj3fIMo6udMe72cIFW++0Vr4P64/X8ZrdNgjWzYsIPXaAIg2zxZbJTTXpseU+Gf844fd6GwepqKtjGId56sOsZwv5hOx3LndX4uswiSYLps114J/9mhp21DYgfA58dSrE8DNt9Ge014LwBlWd7Hkjy2Gb+sJoBP3XkmreqQgP1mTplpSfyOAGUJdm/RYYSCZ0dJ3SXZwH6iuNv4POx9Tf5Yk+gRUOIuiKn7/4Hc5UChJuaPda3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:57:36 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Wed, 14 Oct 2026
 15:57:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org,
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 0/2] mm/huge_memory: fix the copy of special PMDs at
 fork
Date: Wed, 14 Oct 2026 11:57:27 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c7d39c-6231-4071-d6ff-08df2a0bdc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lq6C1Or0kBPNiESn5H/vKv+soZ60NqYCUpN/QAu9/9GDcqtvQg6Pu7I1E8+ycrnc0aOcc1wSFGburRsHTPhyuELlsExGuwbPDYiQTj1QnTeGraeAWfqPCj6E0i3wxj+GEVDKKnT4N1uzpdyPXindlelYDee/KK4CJBx6A7Q2LPg7xbOqdjXv+Fmi7vnfFTxNkit8ZsVA6plAtofY9mB2lPabbHHgNM6GivSxN3uv1A0JhoCzxu29/dthOf4Q4UN6Np1cAB2+NtcfC1N+QxB7+1S77O0FfUhH168VN4Jr5GGI7YXg2g28fuFhVAsCRasMfx6ETtiShnZ/j9CpFMHwV2b/C4jTLlDkniambZyNMpHOtydfgZ7R8S0s/fhTfVgYJH1rMObCDwYzci39gIOIfkRla80j2dbqgvluQ3Q3rV64tl6Oc0J1UJZlEO0CGel7qwzVHI6d/Vmvdo8VkaQIf1ADFJVEwfkFoneffAYd8WPaOtUmy0+qVknqKM3/i+s8hQsGcFd7LODB/BiV3fiCdySkJh+999o8IwDxfSe9kJ2ClIkwIGRFBWY3tuGZ9el2bmC3fdGbbiR8cG6ycuIRcQ3J3RJozbppuv7Gtq/qAAoLeC4xeaQJDyHSPY5orABw7zm/zujthe2cAc9hKwQJ3WICNN1t2tsF8l+evfR05sY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ArhIWKm4v9YU3mvNhPw0e/dQvVixyWlSsm9+J+Wuvr8MzVg/9sUzl4Rf9NO7?=
 =?us-ascii?Q?1fB9r0900kVk7O4R7gB9zmAb2PQR8iBPBVN4Ny8j76Uin1slEM/4NEwNRWGc?=
 =?us-ascii?Q?0vpJ3tIdL0L8xSsmZWBJ+i0iC/pbByR5bqrHBe/8aalud1imjb2LmLnRS+eP?=
 =?us-ascii?Q?MlIV+GvbjBHRYwHjhGWXmKPfCR6CWr0ai/+HNMxAdi+VyAJFO/kL+Fq7Z30e?=
 =?us-ascii?Q?KXE0W6WvCq6eogaJpzq6cgyrVjdTq1u33UBiVfw1+//oya82XQxOAsuMSjGy?=
 =?us-ascii?Q?cD24XMRRCtBcbiyyyTaF/PGqETLil8hoOId2orsE4XIG0dFcBk47swt6vZgF?=
 =?us-ascii?Q?LtcUyrJ1/Dp3DvJRfD+m2r91QghadMSx/+ZWyKK2Tj/Hm8fxSIt+BVp2Dey6?=
 =?us-ascii?Q?LtPVqtb/dslZgMGZLX5qRFpv+xlUvuR4dh7xAsXgcuCXIwf6Mirp7dJGDzi2?=
 =?us-ascii?Q?/A330zrgfyzybAnpOfwjE1spCcN9EWtXi/qIn2TPzG6tb2jLz5GAaKi35Vq+?=
 =?us-ascii?Q?4Ejk6eI2TFifSuOrK7fixto0N7C96MQalzDWfnffYggTTcs13EdRZtybmxwU?=
 =?us-ascii?Q?htcQAQTAq2Yfn9qwzeKHG2Ip0+JTuy7Tu4hc9kEJqU4lVoqHCtRcI9DAN/es?=
 =?us-ascii?Q?oObJj3OpF1kgnKTDDmbvD6CZoXmOZCuQxLQSQ6GmCkVqGdO05bbvBoaKnTaL?=
 =?us-ascii?Q?I87s2Ja43aY5HiT/ixpt62/MXJsjMxRMXQijqcNb2vfgOG7yhJkXKl319EHa?=
 =?us-ascii?Q?kgq0vVBtdl5Tt33qYBgfbuo+qc3FTKT4f8udaK7a0K9N5DT1ZKzIJwJBF+XY?=
 =?us-ascii?Q?SXrbI9Kd4dsmB8MBMwPOUzqOPYTE8620mS82BOh0QWGZD3svMqfud+N1ro4h?=
 =?us-ascii?Q?DSIOK3o1XiomCu4InGLO4pNhCNMBtVcjKEi1gcTZjyjWeZ51MtSUwVQhMotm?=
 =?us-ascii?Q?pszjc0E2neoi5zKHIaSxzNT/9gl/CBK5w5e7eCTMSKVc96OGMxUhHOMNGJTU?=
 =?us-ascii?Q?rFMHkF9T41Zixrri/dy0sxNcz2CAMeNJ+rQ806lTyt0wQDcSeyw0O+FI0/0p?=
 =?us-ascii?Q?jF/k6yRTC5eU4ksBuOo4RV5DQPE9wn7D6eHaHUqh9D4RGn0uVJ7NMvFdDGj4?=
 =?us-ascii?Q?7psoHBCbeQfaf83bZ6L8xsi3affCBqEHGkOkO30WmBllF96l5FIrvkzejgNI?=
 =?us-ascii?Q?eEbghvwaMfxtWVDioVN648TlhmAtoNoqO9ZBpAy89AKIL8idHiW/UbNLU07q?=
 =?us-ascii?Q?jI5yVJ/w4xplPfcyrYDjuW2dn7wqPb7qF/JkUrpi/gb7Hn9mzrX66DdsFIu3?=
 =?us-ascii?Q?ouqYFy5+Yq5ls2RVpdP5EQKqFgA90Fjrcy2a4N5G4Si9gL3/SRFSujmHSOmZ?=
 =?us-ascii?Q?bT0+vtJplfGnmwipmLjMF26oiiyXkBphusJTKTZlwktl9lpkqSDVM1kwhMto?=
 =?us-ascii?Q?pynNnVBQuCTdFDBGQSIuLVm2Jh6VfivQVvGfWz4WPijzUahd3KLS6Fw5C5RR?=
 =?us-ascii?Q?6DJUBLK5ZrGPZakukUnXtCyQzYG3ao/OfCGeTvQ1e+vvguj/kxc8zH3TBkH0?=
 =?us-ascii?Q?b+FGps/cnuRy03oUFzsH6r1NdfcHYj/IoLzj8USvo+OekKw2vO+XBlljk7zM?=
 =?us-ascii?Q?ZZRdPy3D249bxf4hMYpwEtad77EJW0HE+MfRZ4krSNQnZBYS1rnVGbpMu2Pp?=
 =?us-ascii?Q?wt4Nixm0awPnwcP9K4+Q8WadS96vhiXc80OMo+T9aWmRE3Xs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7d39c-6231-4071-d6ff-08df2a0bdc1a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:57:33.7661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSnTeAga5AM9+8KwznrN15TMxXBZEjEMYYg6oHbQWRzag2FU07Zh/KYohyBlfNBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

On 14 Oct 2026, at 11:46, Konstantin Khorenko wrote:

<snip>

>
>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
> Changes in v3:
> - Patch 1: recheck the PMD with pmd_none(), as only a zap can change
>   it and a zap leaves it none (Lance Yang).
> - Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-co=
py_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com
>
> Changes in v2:
> - Add patch 2, the page table deposit for ppc64 hash, reported by
>   Sashiko.
> - Patch 1: name panthor instead of drm_gem_shmem as the driver whose
>   stale child mapping reaches freed pages: drm_gem_shmem keeps the
>   pages of a purged object until the last mapping goes away.
> - Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-co=
py_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com
>

Please stop sending new versions of a patchset repeatedly.
Wait at least a day for others to catch up.

Thanks.

> ---
> Konstantin Khorenko (2):
>       mm/huge_memory: recheck a special PMD under the lock in copy_huge=
_pmd()
>       mm/huge_memory: deposit a page table for a special PMD copied by =
fork
>
>  mm/huge_memory.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-=
pmd-bdf7efb612c2
>
> Best regards,
> --
> Konstantin Khorenko <khorenko@virtuozzo.com>


Best Regards,
Yan, Zi
