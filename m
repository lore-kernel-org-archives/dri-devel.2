Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F7C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A2A10E087;
	Fri, 28 Aug 2026 19:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A6wcZiql";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D674C10E087;
 Fri, 28 Aug 2026 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787944693; x=1819480693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yDqrD3RkfaZW1dM33xXMd7sgHBief0xvJljsCEd5yo4=;
 b=A6wcZiqlPyr4NWWiTNx10kA/+C1rfsmcFXIDOQTgpX6qAOiAEzE0/wIf
 DEUAJW3LlPHPKEl8uLUIlLWf0tImIGNUbvXEPPtvBV8kDOvFMLBkc9hKN
 mmQ/b6LRlzfni+6g0ncR+ZraR6smqZPCrSiLpJFrHYpqLfe2XlBDLgLxd
 TLiHHcYtvDYSf0xQPVXVrKcbiHThTAJ767K3HJmx/gwTXybDq4aXFvHfw
 XD23X5gzslBcqhiiO5TqsSa1v/B67XJ/bfrDinREdu2q6PI3RZbcoo1+b
 nGEqpdzHBFTZv/EctCt3uZoR27J/i8DOlnR8bAWMp/mE3yewhqBzFwHrK g==;
X-CSE-ConnectionGUID: XpJgFpx9QmKNrRjnhGMisQ==
X-CSE-MsgGUID: n49+mUWySRKYmNA1J2+TsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88221524"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="88221524"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 12:18:12 -0700
X-CSE-ConnectionGUID: BqAGkU9XQTaH+OrpcXKuDA==
X-CSE-MsgGUID: 9LoB+5GYToedmA5M809eDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="265001138"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 12:18:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 12:18:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 12:18:11 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 12:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCEPXp+vY/bqIFkNkc400sgeLXEqxfUEOO9J+zX4DJnJd1m1PZUZ0hLBrAazWd6rbmEKNWJpCyOZ0++kAfMQVcS90jWYHTuH93/EvmkxPR/E7wC3+144Am/m+0e08+SwqM37ubr0p8QxzG0+9r2MpkcF8EQ/k2AooggoOGe0oHyNSLbkQpb1dmK0DMwt5L14qsiTOjKzVOpyAh+EPvuzN9wbUy1dZAvXjTEotCp8/6bTU6IJzCYwDwB/UJ4uS61rTo/BbJHue1Xq6fy/ffwYnuv0sVco0SYJffb7e/dsfKr6ZM8/3JtuVVOIX2rw57soO2bujSJuO3XyVbiPO7zHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulXAsont9X4ATcKV7F/eQFIQ/bkDD2IBFRPv2kb3fL8=;
 b=ITfk85VFNgOiHp3Q/fBXz4oQD8sf5TTzYJs+l4usjWlyFC+bsvXadQPFIFDcvt3MFnF8Tdlt6zsUy2Of6FZMa806cvd9KFRDM+9qS9DO+FcWnd/aTzxblIzmwazsLF9SJ7yGoYbtLTxQdirkVYdROG81h5F3R2XsoKSq1Ny/zq/wKvucvu4MrlVHpwaFsJJ4rFu1iePwu0rRwjm30AR0vbn6GrSU9tkA2yJPdE4nJ1A8gj1RUSQ/iiruo8Nk/9sps0sks+hItv04aJf/aBaTw4DlYV7iOlCd1DtALSrSIY0X8jcI50EdIDRUlb6jyLvhypr4azqfVjH09DDeN4mDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 19:18:06 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:18:00 +0000
Date: Fri, 28 Aug 2026 12:17:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
Message-ID: <apHe5YcWWiZF4i2Z@gsse-cloud1.jf.intel.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
 <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9b443b-8b14-47b7-741d-08df05391309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H8fiK7/Zb6TQcFu7A+G2OvXsr9A+Yr5RvJGZqgoZ+HM+Pajuu7M7LYTRvY5o1buJiV3iDLgeM9LH/J51Oup14AuDMyCG8Q7KXbe2Ul8EMOvHUHhc+8fMwFBcftK3rBnboaMg/0SwIFxeK/iYuiWzYnrLPmIjMYmoSunvcnTWwZmd2wJ39ZcaLdQ/WIrQQuaP8yzV4fUd5MB7pZDg51wp0eaCSDAzbhmOF1wYmHJJl4qPFcUdDofcbFcsuDpOHNF1KNq3oKDZVagUPF4ddIsph9pWNIFPK1Mz0+16HGmp1ZnzWcerJWxnsKWn3OWqWAgSBKfELkOYiPuRnio0WFFVNOT8csz3M5fjZKs32AkXwV9Mdpvlp0ugE/yLriwpYALFbQFoAUNoOqs7T5FiOlKPC4NbToGRUxZTsd3Kl6IDbBx3syYMyO+tz1VrCN5I55WZvnaFixXNmmMHtGgtpuN8GqDqR4W1N++UulpaYZWTK4fS3TlMrm+fXTJEoQnLTnFbV6bR8vsr7l8zH3Ow0OpPNk489SgJCs0e9q9NKq3jnNg5jIDnfptFXN0gcLDArIH5BYh3JiYdhuHvXvcYCqVCFlD4+iu+rti0ZBZLZnq5G6fDOnIdCcI4UDCmKt7zg4FQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIRB+swl+UmIRlvmYIl2t2Lstv0OOtsX56fOfxDtyXn44wesLB/zhW4WBhvo?=
 =?us-ascii?Q?K0rqcI1GpDgENAgnUQXIIhlg8SgS8uO4OczTOyXIxXI79eimBg057C1O0sgB?=
 =?us-ascii?Q?DfvEgBfs41LaqHg37wlsqH3p3GOGWz616wZzLfMvBGejKOrtiEIVxtMcxtK1?=
 =?us-ascii?Q?QeItzjdUz3N5Utx/ce/MwSnFIQwXBD6fuRRSgBfY/k46yEIz1rL6brG4XMWY?=
 =?us-ascii?Q?lKCV8sYgtJGDjhci4YkmrMhJmaFL7bypmsMEC7j6x1/FYO5k0uS5ioSU5TL0?=
 =?us-ascii?Q?ikhtwPgjaLEIzbzBPVwctgC5pIv3cxCGJ0Mvd9UOeBImE9zsWiDkQGxlzHRb?=
 =?us-ascii?Q?RLpPH+2SMLZr4awHo6szgGn5TXd8DMua2rbbFf31GAd5GaXifdBdUnATPbnn?=
 =?us-ascii?Q?1mbXRDD2cIx66hLcdQK3RvdNwM774SmCcAatZgdGOtBH7262SDDdlDkHAX/N?=
 =?us-ascii?Q?FJUsEJYSN0aehG/nkdB4XEdSZRSnOM9qPljgIBZvfcInv5UMI65J7E4SSgkO?=
 =?us-ascii?Q?IWhH3XTZT9wVugP68rng5G3B9L3DjQG3w6z+wga0Jj+qWOZJ47C04S5tHs8B?=
 =?us-ascii?Q?StX6ZSjrM3TYpzPm5YPyuN6fr/GCVLzfxrOsGsBtT/WEwOq6wgdj6ghtP6wc?=
 =?us-ascii?Q?g5xiuns3RsdKN5waprBl7iroxkueE2jaukmU0FOb2PNRQg0zH4iI0vbw7yru?=
 =?us-ascii?Q?AHH8mAcMNCxjY9QSMTw/MpiQkjooaHJrEYDJbYb7YEVp6HFUhB4B6C+xwS8V?=
 =?us-ascii?Q?/97I8KNI20meg+tmUjduJEcyue5ccOX/rpp1Y64zLFgC0oqHyMRydMJdO75D?=
 =?us-ascii?Q?OxBImTBsdZiuOkp/gRfb44vovbW2V6f+zLSf68DpjmkKG0hHQu0VPCswQQON?=
 =?us-ascii?Q?ogSy7B4hF5Q/Zs+Q7NrwH0wIPYha4RsX/lj+f1FJ3qhozuvJrqCqS8WAxkVK?=
 =?us-ascii?Q?D0le/upIybZXYjLf7jweiUYKt/nsJKI+HvDVrbBnI4JiMyn3VVdPYcRUR/yt?=
 =?us-ascii?Q?Quh2p43HZdk5GfwYi6kcR53JOmSWFTUUKD3VKKtCTHF2E610TbFVOavY1lnU?=
 =?us-ascii?Q?O8Q2ffnrWF7dt/+koO/JzURYI0GQwpzunJB0uwt9QFh8WtZfHAI9RQ1/vV4F?=
 =?us-ascii?Q?x7RKicj6FjUA3AsOU/P+gYDziEJROgEHivPLGZrjdpvbxR5BNjZ63IG/E2Gv?=
 =?us-ascii?Q?9x1G0JT7TBXmwz0C3VcQgERzqMi0tV0zi+e7BHtIjJCh3i2L3QQ/aePBaDOt?=
 =?us-ascii?Q?nouN7/q4pnklFd/d8cRs7Q6Gf3WDzCAP0M509yFOU1aqQtM7lzVSuHHQlKp1?=
 =?us-ascii?Q?hcnE/XjvJT2lRxO3zodtJ2NC6m8ld0Ih9l53SaJ3liFbCyBHxLOFKPgGeDRT?=
 =?us-ascii?Q?AM7oAe6ci0j4I3tueE4Oi7YEhHF52xFWnqOPR6hGkKQaDFuQDhUAXjOFdVqQ?=
 =?us-ascii?Q?rX3GxsUO1aMusVwRgMFaVoh0S1p5MzoY3D5AontvYU9buWfuzF+Z+NNHo7E9?=
 =?us-ascii?Q?VjW8oLiPDTUX5JT7HmCA4mFh+M/UxLbz0j+80HSKBdheKBH9rGTP3vK2cScs?=
 =?us-ascii?Q?MbdP26RL5pVCM3ozaQoNFkF8RqIz2ggi0hk62FPj8cut+jB2q0vNdoWHp+p/?=
 =?us-ascii?Q?Q4EOtBCnnSN20JYCzKKmZt8TN0BVKRp3biJwFqlmluCHxTn5Sfi5RzdEhDhX?=
 =?us-ascii?Q?NGJQKE6Wq0AttJrlIETUYq0Jm3umCKDl8CnbYV+46YjsU7jg3ZDwZt6Wnuk6?=
 =?us-ascii?Q?Eb2D/Jx96A=3D=3D?=
X-Exchange-RoutingPolicyChecked: IGX47VLRpRX593nbX0n9N2cJp8TX1IPNpr63IG7RSyZ8DzNmaqZctRWzF0CXlLZBS2A0z6CTDpM+9Ezm43ELOn5RpB29QF/gEKlJPGRtUOV3Dlo/Rw39VTCu14v0dQATNIKV59+/oYf88391benU0gjY+c88xW6XMEfGK8RWZ/w3uI5oVpbSvNKSUSpojVp3cgOe2yLH/etu2XR5ytBJBbYHzG/9oBn37ljNf+xJrKs18Fb8tZ9+Q+W2yWJQjaS+VTsihUgJoKxFT+0uAvqmO2Vn4pSMHs3HdmbTFzxrAyIlME6OVea4jl3KZwsORpLyYUSWdUFXKYX9Z4l7Rfl9FQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9b443b-8b14-47b7-741d-08df05391309
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:18:00.3044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q0SNFPJ36vLFmEu4xO1rC4gCaZXgtmD3RthgkIJGGSvAZpnBFPV2u+WDwGEpbmT/IU4RtOpwROfQAGA4+J/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com
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

On Fri, Aug 28, 2026 at 08:21:17PM +0200, Danilo Krummrich wrote:
> On Thu Aug 27, 2026 at 2:38 PM CEST, =?UTF-8?q?Christian=20K=C3=B6nig?= wrote:
> > This provides clearer ownership semantics and makes the code more
> > maintainable by removing the embedded allocation hack.
> 
> Again, fundamentally disagree; please see [1] for details and reasons.
> 

I think Christian is doing this incrementally rather than as a single
change across the tree. The last patch [2] in the series removes
`dma_resv_init` and the `allocated` flag. I believe that was the main
concern, and it appears to be addressed now.

I'm taking the series for a spin now, as our CI [3] had trouble applying
this patch. I'll let you know what my testing shows.

[2] https://patchwork.freedesktop.org/patch/748868/?series=172875&rev=1
[3] https://patchwork.freedesktop.org/series/172873/

> Besides that, I don't really know what to expect from the series. The cover
> letter says "Refcounting dma_resv v2", yet there's no changelog telling people
> what has changed since v1. On the other hand, none of the patches has a v2
> prefix, so what is it?

Yes, change logs / cover-letter would help as Danilo likely could have
spotted the above change.

Matt

> 
> [1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/
