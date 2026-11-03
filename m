Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD8606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DoqjyKvy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A1E10F808;
	Tue,  3 Nov 2026 20:11:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DEF10F808;
 Tue,  3 Nov 2026 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793736661; x=1825272661;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UWchIcTmj7KfJwxaLG01mzwWGWyX88Jftu8hfG9g3Oc=;
 b=DoqjyKvyI4ZRVmEoDaw71sR0zf9fxXsklV7ltY4fyrhZgMkdOoyh1lhT
 WvKDp4F97CvB3uarzBbF/hOsXmlx2U82J2qAEofqn0881i3878s6JrFhZ
 2J3BirEBTmVLldjo/MzAveLwEex5E+0let+r8dluBlYSTeKo0wDlxJYnD
 MrchGHpH5jnwctTYwgtXWs0eXkjuIstxrUL/JojP4AFDIPxxY75qTVM37
 Byco4q7b43gBskRgKcrNxZmCyEhqHk+BUabBl3TR0zR0Ri1pvs7fqH3hl
 zL6hpQFNoiscAJQnd367Kqcq7YfNWOmSi0HkPemIXKqZAaLw1Gj+8hdD8 A==;
X-CSE-ConnectionGUID: QFffI6dOTl+zG6bIiJMdsQ==
X-CSE-MsgGUID: gD3raB7FSFGyvU54Otz2Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2362627"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2362627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:11:00 -0800
X-CSE-ConnectionGUID: WjWODKATR0+RiBzwcVKImQ==
X-CSE-MsgGUID: VTpo0A7uRxe0X79/TCz4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6526923"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:11:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:10:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 12:10:59 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:10:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+sKwTl9qIKCa8Sv//47EdI0aYPjT18qGgV+wYJBgMs5n+oGQoUjiLtoVXPi0yNrcQfhgVzGjsIi6KUU1QGT071Ozf2JnUAY79BRbfkcohOwgpyOCs0A3HVo/1Pmkt5vLY5s8B6TDDMgAGU1HnDezRhL626FDryL7URkfbXnrkYcU9e9Kn2p5Pt7I6r0mNIG73JSpMmPt8u2LLVIfSidexc39OurlrqTi12yDZwFHTQjITfO0++xqDWlcOx840YOTH8SOR790fX0yV+HOCdp5RT7gCTD8Vi7hCESACSoduazv37qUn4gnp8nD/Wy+ktrFrMQxgx6O5HNlDn2KIRjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wFGrdwO0MlayHnQFSDTU4bJqfyi01/UOmOheeG1Qqk=;
 b=iYYH4j9NX1Y/JOsUYDm0jMmKGcKfcYfIZ4tL/otCoOIFhF02unbhxr2LbfQaUuaPrHAzgBVdfFFvfZqxcYRs0DEXAaiL0MNK5C63SgTzY3etwuuzQ8mzp0s8ycdSuwxKY8LAa3R6jIukwzj7WqvLbH4qdqUDzR+rLubdR4W3kDT8VcUjrBN4CqUs1an0aDfAmf1/6XHFzIFZKHDt3OAkpsbf9jOaBWKKRVKUZ6rugVM97hIYFYICVdiWhXFrqy5XbzKgWxS+5EVCq3LT/R+J34dlaS/RHr9YA5ENpV01HMB2KXppwZ3ztokw/W8JUKDxzqmI/iNNivWczmzSTvUYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:10:53 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:10:53 +0000
Date: Tue, 3 Nov 2026 12:10:51 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Tejas Upadhyay" <tejas.upadhyay@intel.com>
Subject: Re: [PATCH v3 13/33] drm/xe: Flush L2 asynchronously in
 xe_bo_trigger_rebind()
Message-ID: <auo/y9p40e2jF/eN@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-14-matthew.brost@intel.com>
 <f61a62a6-01ba-4a82-8af1-435364232f1f@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f61a62a6-01ba-4a82-8af1-435364232f1f@intel.com>
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf35241-0efc-4aaf-882a-08df39e68fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|56012099006|261102123227099003|18002099003|10067099003|261009223027099003|261022105027099003|261022113327099003|261021121427099003|11063799006|261028144727099003|4143699003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: R12JS1PGYdnZ2BoDVPU52T+eGOeU6QdcMH+BVRuTK+6c6gtcgphZ5zhzE3Rv7iuGraDGEcxAYYk9J5hG41qucQkaElB074Zjd88Ft0bj7eaEzD+3qLSP3NIzLKOYngoegO0VCGRLz2px7PMuS+J6gLUTH0vswVHReB3p1J+XkE+X80JlWcz0qdR0H3Shj4zCmq0NChkkC1q1ds0UDgKrHrRDangGlBkx0TgHn7xvGrcfaAo70KUkMO/IhQKhJ+XMOBYo/vNG7poPs8Ll1t+2ybbBIm9dW5m6dELRrp2BfxszOPgM9PKSTHSRB+BXB99WvP31klUkRYM6GLvW/rdCl4xct1a1yuVU/feBr+LO5S+lmgA6fgu/6sX2Ds04c2mcF/8ids+g02TLt//gWUm5pTAjl95NBshDFCtJjRRdRbjuBx5WmpPaNxP0mkAnlgZNddZvw4Mmzwq+y7RW4eG26ph/h/uEql+eVvflGe7p3g8KtrxpiJD5O90BL5a6iQ5i1dt9ZQu172/IkrX0KosI/vsSfvWxr0rRr6yncxNLVB5ac0YLz3963WBurBa9H9ZuIwTcGnj1EtQyzwOwQKtBJsyHb4bmjg33crSX/JWlmJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(56012099006)(261102123227099003)(18002099003)(10067099003)(261009223027099003)(261022105027099003)(261022113327099003)(261021121427099003)(11063799006)(261028144727099003)(4143699003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qu/PxR5uhMnFpk7qhgjdSYlY3JwQGYZ9XuJtfrUFlcSnb8uI2ksrNLcqnQ?=
 =?iso-8859-1?Q?svHQcccbCfGGdfIB4nw+fYqojV68snQhnOcKDRPAA/eKpyIxbSrM7CrQBG?=
 =?iso-8859-1?Q?eJFKmH2tQSLp7+Q2gc+mn3wdolx/LR9nsWiQNhHwxHCIerdKg0rB/57XS3?=
 =?iso-8859-1?Q?hBEFA8k97NXSRZS3IU+86oGv1VJj7cMx07k2KdBTCGPtqswEvA8cRpY1eT?=
 =?iso-8859-1?Q?i+FBMFviF3bcphOnc1mIIrvAz7WmWEqcgEe6lYjrAjZZs/n1A5XwZvhhtY?=
 =?iso-8859-1?Q?M3pTRUIZMfDv1azqBpJCAkwg0c+pYcxJvnoYUEVEb1t8B8wMBboSCJjbLY?=
 =?iso-8859-1?Q?FAoG+fqbe3DZXrARq/P0R4Uc8mbzydU0pDNWAHGjVh8B2Dm0nVOh5Dymbx?=
 =?iso-8859-1?Q?ZY1VjP6+r8hybYRa/rRONXLRsbqOh0a0QYzP9Yfa031kxSVVgF//f4Rmcy?=
 =?iso-8859-1?Q?/EmZYDKz0o9unsnfL7slJlqani070gpIzulLi40FVEd3Oym0q8XNsENPjH?=
 =?iso-8859-1?Q?Qzou1CvjgZKkTBwZepbU06Q8MSiyVzYvVbLIOFKQB9ExAEEJ51uBGKQ3Vq?=
 =?iso-8859-1?Q?07Hw/OBqiB1N81QVsp0NVV+KyEOjWl3nZ9fF+KRdduSkuYlJKKBDFaVTdW?=
 =?iso-8859-1?Q?7ECAy1VYTO1TnxO6Ebput/xmrzmthxOLkecdoCXz7Yeta8Hi0BF6d16r5+?=
 =?iso-8859-1?Q?RkPtn1Xp4B26RVt+RvfE5nPzyF91tzPvDnz6b3w8MomIY2tUn3/jYr1DOJ?=
 =?iso-8859-1?Q?Midms21KppI/ujAQqjjVzSwS4awa1LIkP6klDUF/NMLNGiBKnrDhFugLKt?=
 =?iso-8859-1?Q?42FOL0LWe0b9o9JmmQbeYx53tLY0nbQEynArH2CQm/XDriSw4IEVtxh6+g?=
 =?iso-8859-1?Q?UfeOHm0OBHSrNTNJz75pPUqyDFdxY4GzM7JN3L41fq6ZPoAum6/RWdtkzt?=
 =?iso-8859-1?Q?l7cKxh+stKN50x4h7MCJ/LHIkrOigbCc3a03Zitg974ody9/o1rbphs+2k?=
 =?iso-8859-1?Q?4legHJ+txbjahGPBLV8Tnoz5tlfP4SKFKcYHkP9f81ObcBgGmZepAwF3rJ?=
 =?iso-8859-1?Q?PHBc++FKsQBhiHVwsbTRs7Gq4eZqB/vfAYrrm7hnZ4gRfI4EIbatrCWFCB?=
 =?iso-8859-1?Q?n/9g1B5SZHIWbgwzvo0HQWyCjdcklFEVjm4wXcDlicD2CuvW1p7FlBY2K1?=
 =?iso-8859-1?Q?qgMYkNUTvM1GijnGEX09k2ufYp4VU+cmRYZ7eVNGrwKn7vahLobbnvwzIg?=
 =?iso-8859-1?Q?AeLd7MByyOwh8ZyooKTUub+6sTY8fQxO52iJLOIKA8cAEhHOkV1wKbKslr?=
 =?iso-8859-1?Q?T5PrNT9/kQAJHrdPytBireCXEy0xw2iuEsgxuUdsXcX2hP2eIiaKtyZ7Dc?=
 =?iso-8859-1?Q?mL0WYgtkQV5prQVLhq0gbf4XKiKkgG/FlRY3GDrjJkLYPJUM66Rrwsqrsc?=
 =?iso-8859-1?Q?TsIul0KRt+dDzadifU6nPKk7l/dLDguZpeIBgO8dGnjzjdry2mJ1f088MR?=
 =?iso-8859-1?Q?fdaAnnhHelhIGKicTTuvDAK6JAy3ajRFudSTEJzGxDpQQJolfHZq9BLEhD?=
 =?iso-8859-1?Q?0wMI0bY0P0eodtvbmhgI7sa24NKAq7SYKjUkY97gWKFWCQNl6xkdmVOrne?=
 =?iso-8859-1?Q?7Rx4gG+YT6TTIXNsZKcDSSeZn19MWYTbwXpAN2Mj/b+hkoyPyy5qLZcqfc?=
 =?iso-8859-1?Q?/QRTxl/q8M2cN11+DE3MfHmkLOsZqqTTKywIYILjotfGWz0D7ej/6S0EfE?=
 =?iso-8859-1?Q?l1lnNmdUefV1iyo16Ttn8VamMN/+WmSzJhLgIjht2wkTo8sPREIjl5QDz8?=
 =?iso-8859-1?Q?5OXt5JNn1w=3D=3D?=
X-Exchange-RoutingPolicyChecked: arU1uGs+F0QTxSW23REa4fqNW9LMcAtnZAucblv+DfuMJOMdYg6thAi1KhnUV3NxoNeZQ16lbG61XJBHjVTsAnkUZTD8zibB7NoNgXyXnIm8AKdSgHpmvygEi086QbWFXOJPh7jAGWU17hmIwG7eahWabxjkyHmXzejHJDCg0UX5kYjJKLMI7Vl0lbDkZaL/cE7g30Q1yDkplEbMVpNLxPZ42hVYvI1eMqQbFWg8um5KqaiTekIhYbmo7aY+Wdsy24ObZuedtCYJPQNH7RxkDZ8TewJvMcHMlw51klaK2WQbwFmtxaU7kzj8YTdHDjGMXfXHVhijrieVw/j5nYZ5ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf35241-0efc-4aaf-882a-08df39e68fe2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:10:53.0788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OttE6IzJ5Toocf9i38ihW4otKmnNAEPl5XSSY0lWIxgf5ODqkj2ok/DIpmiUwpyP2dXBnjnZIRywdEafvn3OJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:02:02PM +0000, Matthew Auld wrote:
> On 11/07/2026 03:55, Matthew Brost wrote:
> > On L2-flush-optimized HW with a dma-resv (non-fault) VM, evicting a BO
> > only needs to flush the L2 cache before the migration copy runs; the
> > mappings themselves are torn down and rebuilt lazily via
> > drm_gpuvm_bo_evict() and a subsequent rebind. Today this flush is done
> > by waiting for the BO to go idle and then issuing a synchronous TLB
> > invalidation per mapping VMA from inside xe_bo_trigger_rebind(). Both
> > the idle wait and the synchronous invalidation stall the calling thread
> > while holding the BO dma-resv lock, serializing the move behind all
> > in-flight GPU work on the BO.
> > 
> > Replace this with an asynchronous flush. Add xe_vm_flush_vm_bo_tlb_async()
> > which, for each VMA mapping the BO on each present tile, queues a TLB
> > invalidation job on the tile migrate (kernel) exec queue. The jobs depend
> > on the BO's in-flight GPU work, captured once as a singleton over
> > DMA_RESV_USAGE_BOOKKEEP, so the flush only fires once the GPU is done with
> > the current mapping. Each job's completion fence is installed into the
> > BO's dma-resv as a DMA_RESV_USAGE_KERNEL fence, so the migration copy -
> > which waits on the resv - waits on the flush without stalling this thread.
> > 
> > No PTEs are zapped and vma->tile_invalidated is left untouched: the
> > mapping stays valid until the lazy rebind, and the only work performed
> > here is the L2 flush. On any failure the caller falls back to the
> > existing blocking wait-idle plus xe_vm_invalidate_vma() path.
> > 
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> I think this one was split out right? But not merged yet?

Yes, we can split this one out and in fact did earlier [1].

Let me respin this one as standalone patch today.

Matt

[1] https://patchwork.freedesktop.org/series/170046/
