Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF5FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 22:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD66310F64D;
	Fri,  1 May 2026 22:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H74jtr2S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7816D10E22A;
 Fri,  1 May 2026 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777675182; x=1809211182;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vJwdgmHyrb17kXAmd9VikAyxo6axYyN4G6KNmruBW9A=;
 b=H74jtr2S1PyPxeBYeBL7SVNLeuS3qrWBtr2l3HIyOhpUISWjierC8w6q
 XGnB9Y25WH31Lk7Bt5AYd1g3QC5bKBDXzg/M2fHJrT3Sqw7d6mkWm43n3
 VQZk2gJllgqr20CiblsHiCJNePA6n78uoQQ0/A3UM/ZVR+3isZ3XQEEeP
 Q3fU8ADWh0o1YbJ3qQ6BtmlyVSUlk9csoEz6gnqBVuznK8h9LDW4dwLwG
 Pci9Rl+mOJkJ6QlxTV09A79bJAnXV5HzI/fkoUAJ1H+PhWh3SmIu8WTCl
 ikE7IuvfbAIY3s2DjS+q1hzLGp6LfJ7YIPe/CgRq+NO2kmyIPtF6DCpUs A==;
X-CSE-ConnectionGUID: P2OXSM7KSWaqwXFmoGFYFw==
X-CSE-MsgGUID: 6cuqchb2RzKxxd6IcmSt1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="101302737"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="101302737"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 15:39:41 -0700
X-CSE-ConnectionGUID: zAbRxvOyS9eBcXTN7yd8jw==
X-CSE-MsgGUID: QMWl1VI+QAq23IC/u1JRxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; d="scan'208";a="239300514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 15:39:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 15:39:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 15:39:40 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.13)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 15:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Em52V2QFgGhgQWfsTV59yI0GnB1oFlW0yveIWQtps4n34N4+aoI6Q8luCoZnoYzuD0prRYz1EwQ+lZEphJCWMZzEsdrX/OoIHZo6osImkN9lfBMFew4eIQUEcsYZ6QykHndJQobZU8d8zPOMjUAD3FaFCKR4wY+kmKV16lRDEIntQbooEoZTqm2eUNBTvjsgGgJXevoV1ymoDXyBQivbL8iVk2xrNDX04BKZxeeJ5VjacHcDnwnY6PVPDWdCjlPxHF9BWXa3ctOXhkJTOE5e5vHZqi4F+4qNmuhOY+1if2hWNcn4Hs/c/4tv4VNerxLMHuupv3uXzVMwFGI1EmggCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkncQ8qyr+19vxvOeAXfvQRNYpGMKdorICv0eOPRudU=;
 b=fACV7W71y1OYrlcQzbmzFDkDpMkG23+BTAG5Zdb0Tm4ZkuAHwkuM7r3YAw9POj2N++zIf+dUUt1P6wOhEDMtiGN3bq461FWH9zckt3qEHnUJ+0aXNFyCa3wQBtZKwc5n+xuEhTpCcKfqdMfK7nfvCvaQeyByHk+FeBIbhB6WqVe29PlsCdBz7tRZpS9I3D+hpPIjTxxY72rKyUymWkii6NcAL07GOLiZwL/BSdJ9tGGXu4UPm6WB/QyoMYymyUY75K/ThoHpBqZWoh+ZGJARjhBlxOneFK3xvjpK2l3JXMa1eha/k5Fn/DBRQc+5gul6d36Q/EhQknAMOKiZihImlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 22:39:36 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 22:39:36 +0000
Date: Fri, 1 May 2026 15:39:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v3] drm/gpusvm: Drop redundant @flags.* kernel-doc on
 struct drm_gpusvm_pages
Message-ID: <afUrpqc4vd0zFekW@gsse-cloud1.jf.intel.com>
References: <20260501175956.4054088-1-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260501175956.4054088-1-shuicheng.lin@intel.com>
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 03afa52a-fcc8-4d38-0eb3-08dea7d285d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5Yf6uDRD11DKxDEBrX+/ygGG/4jWKBgzq26hnov89dNqzyMf8yINoElV/Db6tYpJ/rSEDq+d9qJsBe92egOCnkRxP9dEb+3XuVMbQYEKUGft7ygGcjjxdsA1aMTZX2vkoeT+ECD0QMGXBU8mNdr96pkp9IiIf//MZNZSEdfAeOA/S/ZFRplheI4rs0nKDeS/R1Ju3cLnt3KP36tuvxIB4jHLZFDP2XgfpUazBztcxM4X0eA5R6slXE4Zyyu0SmMlQyGukMDImETkbY+O5uvX5uE4giNZNM64BKiRwz2xN1qyZUH2xS+T4blbc6djZUVC9xqt6oB+8l2CoHb2DPZgbzp1p84iVCDyxxcGwxyqPnRPacln5vjs6g9FDcMWm7DXok+qOF7lQgmknfC1PQzQTsO0Zbup76iuFPqlsIl6qcgYwxxIWgZ/ct7otMWCzGiWo6zQFZwbY5ki3Ky8tzF+NhdBRlF+HIA1hZB8t/83tSR+TSxneegpZEmW+IoM70ESMiZdzH7olv8nlI/rLA9eZHu9Zk+aA/eRYU443ouslHGMWIv7h5VW7R0pa/6g4n2nCzGo3laDGb7ZC2RTge9taFIoPsYgvrTd2bZhyORrG3mek0tNGmy6oOeoh4gT+lM2+SgDt79aaHAh5rmhAU7XIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bI9/wWJr2otvM2tdUnHIyDGjlTgy9P98i8hmsKxPKQ2imoVS+poMqxxyEX4M?=
 =?us-ascii?Q?Dk5wChGfql0Ym56m1Zb81f63xnz1lUMt9cm/KKAf+zTTkEiBLhP2AmKBbcdv?=
 =?us-ascii?Q?G8wND7QNjqN0+eOGH6PaPjBSD2/7zXM6MevHrCzGnwWR3IC4xQw9QYZ5RWIx?=
 =?us-ascii?Q?SreE8Y8QVSALqXLjLIxxtOM9GuDb5BcuRsV7V64mGaeiWzPWh/PoA4qEnlk9?=
 =?us-ascii?Q?c3ldcW1MEWORrdLbs3n1LW5YhsIId3NYfvYzetZWqHSpsZGac31DRmmqCnfI?=
 =?us-ascii?Q?mezdS1zHDO2+FgVgDFQlONKuKWm9h+RRoqhLL0qR6it4feAWkcDa3S40ZG3v?=
 =?us-ascii?Q?xd54RnS95pJQQjW36dj2loWB36Ol6yz9ARS3qndDq91IezovpR2MGN47sOhV?=
 =?us-ascii?Q?LHNo3pDmWrJCmz5KbuzxgB9+iU3wVbh0immW2PRP/yJmNb4emQIzLaW0FaZC?=
 =?us-ascii?Q?lQHwT/6omNg/lL/KYJXx9Vrm3GoEZ3PP00j3trg9Nen6V4XG9gkUT32KNp/y?=
 =?us-ascii?Q?B9RNUT97BClegu/a5ZOk638uKlm1DPr/FErepfG84oCB66ZTs6o8KTgD263l?=
 =?us-ascii?Q?bEGwEQG5cUWf7P3loODnvGfsDg8SQ0J8KlgjUKfd9DjF+GzMtmrWR2n7iy0e?=
 =?us-ascii?Q?kpwJXjCRTgJ21xntixPNwqwE7WIAHpXQAwFAqWapUsyPS+8j2Vg03XKs9j5P?=
 =?us-ascii?Q?J5QJ0xYzIOQ2wFoMP9ny6Q/22ngjoT0DhczzBAc1yC2HFsmzigxEG2RGtko4?=
 =?us-ascii?Q?RbUOL513h4XYB9Fo6+aUj0D/Du32RVYaeGkv23f4eCRon5JpSMq+BrDFbSF7?=
 =?us-ascii?Q?UrlCEjkAn77/Jnfa7LUHHpBhOokzVdwvfdcoUz0Lz7UclvX6GTaT66VLF6Ca?=
 =?us-ascii?Q?odng8IhBkdSMs+H0FBRNQsj8Ubqmx5E0kvBSQ4wsVFYajlixZzCgap7/y7Bu?=
 =?us-ascii?Q?dKjKicdXSzHk5ByFGv/PcuO/5i0FLkOCoOU32Nc1ZE7B7s/LZiy8FAQbj+qz?=
 =?us-ascii?Q?C2m8Wo3KJA610c4qlf+CdQ95GqTYYEaeOcJEoUA6he40EMKIA0zdOXZDPW5g?=
 =?us-ascii?Q?i3GigY1fXKHXQVBBOLzshg4Vg3789PhrSVwGFIJLwLtOymApwk34PYQ7DpLO?=
 =?us-ascii?Q?z7VMRChnk1XYXKOTpdP09WR9Xu3rp6POoC7DFAKmeUq4KgJXzLSy99RMOSn5?=
 =?us-ascii?Q?o4rj5BBsQPLkC/HvqRUy/u3S+mVLtGDqs35g8UfbBxlJbkVRJ2ElarHpscoB?=
 =?us-ascii?Q?fs7A1dq8F6dAEdg7HUPPdmya5Tf6A+oa4vpBg2DCpN0G/YfR4g5RzTS+3mJM?=
 =?us-ascii?Q?+CoA1i/9I7zpOksdOPhF1ZahKLGmEJe13kC9N4rhBpP/1sBj60Nqcrb/F2nn?=
 =?us-ascii?Q?dw6FOe4hOFFMVLfFD54zBJIPGqSzgCby0PG5m/kAdAc2GeVr6j8DcFvwbmwX?=
 =?us-ascii?Q?EqgUn3qI0h98RmttwmW1nNGii5SPmES2jv8j94VvH4J7ZQQHu7qjLgc4C0Q7?=
 =?us-ascii?Q?Bp76yc2c/+TPlk7WflW5MtH+7FpfzTXdAJj0g/pjXQ9AOGKEqvSkeYkmUrol?=
 =?us-ascii?Q?UFVuXTh6TZfyBpllMCM95f5DboN3JFSNVZyQ/dllJn2vvnHTa8dduB8FydjB?=
 =?us-ascii?Q?ccX5zwSgix3+1yT3vDkS+Tw8ntcjtWJZ7ciDzPtwepRQiChmIRvJEyY50jh0?=
 =?us-ascii?Q?HhNg7C2Ul0udugxYh9H15Boy9DZ3Ov9/C19B4XUWWwb5iqrhfLMmhQpoTSDA?=
 =?us-ascii?Q?3b4H4vl1KFMCwtQkLM6Qd1g3Zg2DICU=3D?=
X-Exchange-RoutingPolicyChecked: BA+F5aZ/LhTTIEDJCxvZxMPq2gLKgn6ZBQfRcpwOqEGuVdXNLJg3vQDX5JM55stwSIxCArBDxs0k5kZAzDRoGdFfpydSmhpLxu3EEHRgV5i9IPm//jVI160oZwNHHdp8+iAw5scMcPkpp1cdg1kNzEJuSKuPredTdy31wGDbEOXZ6L5RmPmcDpIzK3C8poIbvu2O5SqN2jvp4ISoG65oW2A0tWlVkDhphQ1b/g9o+3Ik5SOAus8b0c1clc2PzR3yS5rD6d8d9wz/emonhVPaM5MYleRBe8bI3Y1z5EvL3c2Q7uRIt0x4ky2dbyaolmhYE+7a8L8nTUGpscI4TL05zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03afa52a-fcc8-4d38-0eb3-08dea7d285d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 22:39:36.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbzJcHO6cfWEaRJF9BqP8VYbxQvCLVsrlkq7r2vR9GjrsRy7PTCfN4OCn6jpGJM3nE/rJZAQo1yZdZptiwjX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
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

On Fri, May 01, 2026 at 05:59:56PM +0000, Shuicheng Lin wrote:
> The kernel-doc block above struct drm_gpusvm_pages duplicates the
> descriptions of the bit-flags that live in struct drm_gpusvm_pages_flags
> using dotted notation (@flags.migrate_devmem, @flags.unmapped, ...).
> That dotted notation is intended for nested anonymous structs/unions that
> the parser flattens into the parent's parameter list.  Here, however,
> flags is of a named external type, so the parser does not flatten its
> members and the dotted entries do not match any member of
> drm_gpusvm_pages.  They also duplicate the canonical descriptions already
> present in the kernel-doc of struct drm_gpusvm_pages_flags itself.
> 
> Drop the five @flags.* lines and replace them with a single @flags entry
> that cross-references the type via kernel-doc's "&struct ..." syntax.
> This eliminates the redundancy and removes warnings emitted by the new
> parameterdescs check in scripts/kernel-doc:
> 
>   Excess struct member 'flags.migrate_devmem' description in
>    'drm_gpusvm_pages'
>   Excess struct member 'flags.unmapped' description in 'drm_gpusvm_pages'
>   Excess struct member 'flags.partial_unmap' description in
>    'drm_gpusvm_pages'
>   Excess struct member 'flags.has_devmem_pages' description in
>    'drm_gpusvm_pages'
>   Excess struct member 'flags.has_dma_mapping' description in
>    'drm_gpusvm_pages'
> 
> No functional change.
> 
> Assisted-by: Claude:claude-opus-4.6
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
> v2: change base to drm-misc.
> v3: correct the assisted-by tag.
> 
> The failure is reported by the new kernel-doc check in: https://patchwork.freedesktop.org/series/164948/
> ---
>  include/drm/drm_gpusvm.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index cd94bb2ee6ee..8a4d7134a9a7 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -140,12 +140,7 @@ struct drm_gpusvm_pages_flags {
>   * @state: DMA IOVA state for mapping.
>   * @state_offset: DMA IOVA offset for mapping.
>   * @notifier_seq: Notifier sequence number of the range's pages
> - * @flags: Flags for range
> - * @flags.migrate_devmem: Flag indicating whether the range can be migrated to device memory
> - * @flags.unmapped: Flag indicating if the range has been unmapped
> - * @flags.partial_unmap: Flag indicating if the range has been partially unmapped
> - * @flags.has_devmem_pages: Flag indicating if the range has devmem pages
> - * @flags.has_dma_mapping: Flag indicating if the range has a DMA mapping
> + * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
>   */
>  struct drm_gpusvm_pages {
>  	struct drm_pagemap_addr *dma_addr;
> -- 
> 2.43.0
> 
