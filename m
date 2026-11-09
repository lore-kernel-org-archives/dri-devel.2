Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD748606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ja44nKCt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310AF10E5DC;
	Mon,  9 Nov 2026 22:35:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AC010E5DC
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794263722; x=1825799722;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Pr7SHvZYe+inPam1dfgN4DDLNAs2s8soEuUBNz2BOVc=;
 b=ja44nKCt1K2Q1Tshm+6r0FUk1pYg/2MZienDECG88vgtWL9wHzwX8bMI
 xwes/em0zQpvmcsPIpcyIFtqMEi2vZScXe7Vov434R1ajS/eaPLtze2h6
 EUOTwtWs7ae+6f9dOjKjZPpSzF0WythzMgNoL8CUbcfQvjuEympJhpMDh
 l7Zwf54QclIXHLnt+iO7nyx6ymS1phJ4BnW70uZMhCRFgQ4fNKj3kuyqP
 6x53kVKpdKtWLzoVPHBnDtD9uR5A0CGprbfTQWu3qc09bh4PMK4hYRQBQ
 jWR2iEFKrek7DxiYz+zW/g8/c1IDgHCFpxlNsiS028uCmfkJKEmH1KUtO w==;
X-CSE-ConnectionGUID: dksEnSbsQy2uyXBBSP0hLQ==
X-CSE-MsgGUID: iIoDBq6cQC+FFktjmHNO+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3011873"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3011873"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 14:35:21 -0800
X-CSE-ConnectionGUID: YaaGNloVQ0COXTg3tGL4uQ==
X-CSE-MsgGUID: j9mc/6loRSazMBH6Y3lqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8169238"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 14:35:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:35:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 14:35:20 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 14:35:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUEeWoM6jBFDrD7tjyqyc0PqhPbb3qItY0ZToUBrvrQwUoE8Bmv1Ciqg8KwNdkA9uD7xH/H5FkY4feVx9wuw8NVYYhd6hReCczduMBL+kXT21MqU7BRW9pXS1pAFMVbF+uSTkesjuidTb4r0eIDe2q8GakC8u4Xr1Df2SkAeeud74ZAx0EHY/iqWJSNH0km1AKZk/CqirMDKsV9soAcryLZEdMdbTI+VTf3CKmeyqZ2Q1T8Wif9U/KoU2T57sb83Tp0zkwdvUYo4krltJRE1jc4bQhT5YxckoyknY6gogAh5TNGZ4D+lkjwr1sF5w5hdribMuoc4RJAuqNRILYABhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SGVKEvF9P+fjgRj4GgE8YR4r6wE5fl7fQdWVobbH9s=;
 b=MKdk5Cwwmr42O4Kl/93zXqTiNz36R8PgCcJidfBG5EgZmdiM6N/5KIMoDeGpCbTWKFRiuJawzBkbkQSwV2AmFX4u5qqoKB1TRjIxhJ0CXqVQjpkqXRKd9rZds/OSX69j4rQqmX86AwTczNys+5UsLMn2F2p+HdGujEOnZKtJQyrzhjOIomZpjnsw0yjlVFQdJ1qY7agphWFFIzL+2AlBpwTjE60Hlo46xsPrGmhhp3ZzriGnXWACWwhGbbH2X/xxXBolJ+L2sgSbo+L+/qEALHgWNr8IUk9xUrW9AHBeFY1+AEpEwJZSEhSewxCQk2reYBN4BrkXXzw3+wdwUTJ/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 22:35:17 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:35:16 +0000
Date: Mon, 9 Nov 2026 14:35:14 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
CC: "Huang, Honglei1" <Honglei1.Huang@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Santan, Sonal" <sonal.santan@amd.com>,
 "ogabbay@kernel.org" <ogabbay@kernel.org>, "quic_jhugo@quicinc.com"
 <quic_jhugo@quicinc.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "karol.wachowski@linux.intel.com"
 <karol.wachowski@linux.intel.com>, "Zhen, Max" <Max.Zhen@amd.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "himal.prasad.ghimiray@intel.com" <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and
 retry helpers
Message-ID: <avJKouF5RYo8PlwF@gsse-cloud1.jf.intel.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
 <CY8PR12MB71707223ED3F56E5894FF353D9732@CY8PR12MB7170.namprd12.prod.outlook.com>
 <283f184b-eefd-2402-3ed7-a08a96dce382@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <283f184b-eefd-2402-3ed7-a08a96dce382@amd.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b007102-40ea-469b-f7f3-08df3eb1ba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|4143699003|11063799006|261009223027099003|261102123227099003|261021121427099003|261026121527099003|261021123027099003|261009221227099003|261026140227099003|261022105027099003|261102130727099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NNCQGQYGOQnm1XjPF60oV1P26GLXYejLy13z4trHW5IkxR8ek77kyyeeMQ5ZYMsIH+++duev5dpmWHCMK/ob8fVjzYAaYQHN/Bjut4wulWMMlCe7gGq9EzodWkiR1NEOndKkAEAzJfVCgAkn0aANJZN5qm9C/iLXan/rGJWRPLgJUdYAglW1BLhI4MKQrqD0AwI45fryMUDuPA77x5qowkup87Dg6x0AehvqJsFyc71VShUlfYkQnrC49YSwU6UIPJisoAU/hg477N+ej711eyIdZOW00MT/Kly5IsH81vrSyXqqBZzrGhJRuipAxKUKqxxCVqnvx1RHGPFn7bMrNUezX6NiUgmADwFzRMY6rJ+jWhOZMVwE8VO5zg1H43BOkQqFIv0aAXhHfN2sUwzuJ5ONEnP7NeMWIYrHdw/cXh+IGlcmFwy0wpkGDOEhRR9jJ8f94R5YhpEqaQVkt/HsjUDk1C4we7W1+hDwzUzrD2QeOHkNp7g830iyoEoZigKrmvHN8beCcO2r/zKe+wFrznGfyIJsUxobtGp/qc1ZdngZ7F4DNy2xIq8B7y2nxsMYKAABYfydPr67MjvE1N4juufldsIYnBo0IXNYkW9RvyQyjVk5f9+fIIIl7sJfvd0ZGGUBfXghSSn/jV7zWVw4h6wKGORsS11h5nebXwv/4yY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261009221227099003)(261026140227099003)(261022105027099003)(261102130727099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CIDV206hs21Lk7ExSHSsjeuAB5/CWhGKJNIPg7pF8XOa4K/UPFZDJ0SPkX?=
 =?iso-8859-1?Q?lYRjl5QQ2XhoayaKPf9oKQEcwtpYY4X8F1CjthCL+MKYWZ8fuOGxPV5hO4?=
 =?iso-8859-1?Q?Nf3hjCTZJ2/G0+s2Gaw16ZJubS8KsHNtKIhGlk8rNaRtkbgqD8SOyqutyN?=
 =?iso-8859-1?Q?wi5ey3I98o/elNdX9s5ud0vHeYqq2avi3KOCF0NLZKNWEae5OdQxVUM+VQ?=
 =?iso-8859-1?Q?zdqhhoj2Czy5LBATprXQz1Db7YZZu0HJXcxZPlasHqglYxFD4HOpqRMsrH?=
 =?iso-8859-1?Q?0hddRsSGsCVgdUJ09SltEBDXYEDKkOPDhPDdeQtD2yLbujdIUk4jSmannp?=
 =?iso-8859-1?Q?G6TrLb5x2EnaVkEhGVdb4AXUvmQxmFfdeKR11lgDz9wXKrYVt4iqtT0KGL?=
 =?iso-8859-1?Q?U6IEg5TAtHPCB7fPs5ylBfuarTG4qed6voapYCR1sTMezf66X5ybhMfol7?=
 =?iso-8859-1?Q?ApFX0soVtSA/jnmN/zMF5W0EY2nmmRnoBcnOLxgxuB31Od8aNmXQ46O94W?=
 =?iso-8859-1?Q?uRvBe98aalRWUd+Jr5ClLw58Nn5HbQu7pt2DUajfXz23uhhTEuCBmKo0AJ?=
 =?iso-8859-1?Q?QIPUVXTVVzEUPc7zBOIogte6NPeqMgraI6BBjJ7OvxHDGj/cq70/IR8vK6?=
 =?iso-8859-1?Q?SJTcVyMiMJasmI69Kg9tPAlWXqQDhFaWe34DuZoVJVoLmlyLFUq1Z3o8MB?=
 =?iso-8859-1?Q?806RzQ1/XrOKR88CuuUH8C8st31LA41l+iXvw2N6YTzGRfrXvJx6i614MG?=
 =?iso-8859-1?Q?r1MH+fzZr0oqpwmiUtU7s1afCSBI1lGF8pYe8/wfV+1/SjX9E5F9ZJ3dkX?=
 =?iso-8859-1?Q?VSZQKnhxKtFmGA0jaL6fWkW9MNTBdAhYEdL0ZebXwSxXmp9hSfYg354pZJ?=
 =?iso-8859-1?Q?XHp1aKZmBlJvD5PygFYbKun91UvX9c0JgJEi63Ap+mv/wGP5/eyroTeZok?=
 =?iso-8859-1?Q?MELg9BSdFjPxwYVZS8PhxgvTJOXtUDi74tqd6NP2ewFy8WIxqMgW2GL9uS?=
 =?iso-8859-1?Q?4I1bFxMQIVA+UHREMvgEtqNomEqXCzgmH/4qUsCh9up6zCXegDyHSNLL2t?=
 =?iso-8859-1?Q?tDiQHT3I+lzVTF9W5O3w71oMkK9bUs4XcW8/35FHnq7kDUzZDzsA5ElxED?=
 =?iso-8859-1?Q?CuCpakk8UFRAoeL/xpSA1Fv+27zLOAgMzWiZdcX76Fmi2JYh/i9JqUi7F2?=
 =?iso-8859-1?Q?+WIWDy02NippfgLX3CMVF4QtrtxKY4+FYWFlg2bVBemxqPM8DDskKBCyOM?=
 =?iso-8859-1?Q?EMQkWBuZy4XjhfczbVp6FulndUjCdOAHtdDL/Ej3ZC0FKUlrxP7qDiWy0O?=
 =?iso-8859-1?Q?uRkknp0ZBlPC5k2s9kEHrKozx5IFiJenf8wgY6dVFNw9LerED2yOKOk3Sp?=
 =?iso-8859-1?Q?PgSvcfXFf6aHypDdsWX/c1o8cwffRmszQWtM4cYVSX6JrgjJLLJMfb5HVl?=
 =?iso-8859-1?Q?L7BKHHc4HXQ+HkLzcaGj86JVDlKzoW5apPGG3f8B/7xC18Yr5MVgXAQsV0?=
 =?iso-8859-1?Q?rTALsC3Fgpn6nneclsqWMcaNFpMSoHf09b0zkxWqig6O/cXvcwZ5G4CVTs?=
 =?iso-8859-1?Q?pGe/SUI6YDx+F9nt11wDnIrLad4mu40iGUeNifjchnC2MSFHD06hPTTGKc?=
 =?iso-8859-1?Q?IVzQfYRsP8zklGQYfx6QO90lxqBZH72v1IxO3NhIFgbMQ72k9TkFwIcdB/?=
 =?iso-8859-1?Q?fp+EE8ykKDFr2tdQLfsdw5evUTxboiipGS1ps6n0NodWwD4IxFYb5BPOXc?=
 =?iso-8859-1?Q?knAWMNBFPr9pDaOJwrzuzTHHN0e+8qGcMMBCgaUxMmnQFinSnOI5WOgwaK?=
 =?iso-8859-1?Q?zhN7VDMOZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: J+TJiLN7Zf49rswR0HPTif0LFWi/ywr67x7PoClwXwfa4/WorCHWMv6OEATQObe0rWOl9Wqk8AiWo9Cm8FJjk0/ulNw+bfibRaRLxSCosLAhE2MiKZrvgtkE9Lg7kz+FtUZI8NddozxgYhVrH4LGGzOAqHKaHioHp8D+KYsILe01umj/0NT4VcAhXvSbLOLr/rUVOzHantcNBndxWiHySBGc3pHUOPpPfH8xnnW0VCjwC8CbFaJcIw0SxJSgdLlGxkUhlVNfzkzlU1rl8dss+OB6BxDFs3IB4nqmGu4qj2RrRjF+V/epkpMhyw6NTPLDrzNDzwKZWne2N8eZC2I+7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b007102-40ea-469b-f7f3-08df3eb1ba5f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 22:35:16.7706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4ClFdHNPDMzWsaZBzmnJdOmHKSKCZ5HvybONYPZg+Gg2DJdkIA2Y+1+vBpsQjlYTF0NkXydSNvJuv3odY3Hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 11:53:37AM -0800, Lizhi Hou wrote:
> Hi Matthew,
> 
> 
> How do we converge on this?  Both 2 patches are reviewed, is it good to
> merge them to drm-misc-next?
> 

I also gave an RB, feel free to merge or if you need help merging, let
me know and I can merge them.

Matt

> Honglei, Thanks a lot for reviewing the code.
> 
> 
> Lizhi
> 
> On 11/9/26 00:56, Huang, Honglei1 wrote:
> > AMD General
> > 
> > Reviewed-by: Honglei Huang <honghuan@amd.com>
> > 
> > -----Original Message-----
> > From: Lizhi Hou <lizhi.hou@amd.com>
> > Sent: Saturday, November 7, 2026 2:42 AM
> > To: ogabbay@kernel.org; quic_jhugo@quicinc.com; dri-devel@lists.freedesktop.org; Limonciello, Mario <Mario.Limonciello@amd.com>; karol.wachowski@linux.intel.com; Zhen, Max <Max.Zhen@amd.com>; thomas.hellstrom@linux.intel.com; himal.prasad.ghimiray@intel.com; Huang, Honglei1 <Honglei1.Huang@amd.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>; linux-kernel@vger.kernel.org; Santan, Sonal <sonal.santan@amd.com>; Hou, Lizhi <lizhi.hou@amd.com>
> > Subject: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and retry helpers
> > 
> > From: Matthew Brost <matthew.brost@intel.com>
> > 
> > Drivers which only use the drm_gpusvm_pages API (no drm_gpusvm_range) have no way to mark pages unmapped from their MMU notifier, as
> > drm_gpusvm_range_set_unmapped() requires a range. They also have to open code the mmu_interval_read_retry() check on the recorded notifier_seq to commit pages faulted with &drm_gpusvm_ctx.no_dma_map.
> > 
> > Split the pages part of drm_gpusvm_range_set_unmapped() into drm_gpusvm_pages_set_unmapped(), and add drm_gpusvm_pages_read_retry() which performs the commit side check with a lockdep assert on the notifier lock.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > ---
> >   drivers/gpu/drm/drm_gpusvm.c | 49 +++++++++++++++++++++++++-----------
> >   include/drm/drm_gpusvm.h     | 29 +++++++++++++++++++++
> >   2 files changed, 64 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c index 03dbe304e4b8f..63a26919f59db 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -1761,9 +1761,8 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
> >    *
> >    * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
> >    * drm_gpusvm_pages_valid() never returns true and success is only a snapshot:
> > - * the caller must recheck mmu_interval_read_retry() against the recorded
> > - * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it until
> > - * its work is visible to invalidation.
> > + * the caller must recheck drm_gpusvm_pages_read_retry() under the
> > + notifier
> > + * lock, and hold it until its work is visible to invalidation.
> >    *
> >    * Return: 0 on success, negative error code on failure.
> >    */
> > @@ -2021,6 +2020,38 @@ bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,  }  EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
> > 
> > +/**
> > + * drm_gpusvm_pages_set_unmapped() - Mark GPU SVM pages as unmapped
> > + * @gpusvm: Pointer to the GPU SVM structure.
> > + * @pages: Pointer to the GPU SVM pages structure(s).
> > + * @pages_count: Number of GPU SVM pages structure(s) passed in.
> > + *
> > + * Mark @pages as unmapped, after which drm_gpusvm_get_pages() fails
> > +with
> > + * -EFAULT for them. Intended to be called from the driver's MMU
> > +notifier on
> > + * MMU_NOTIFY_UNMAP, and usable without a &drm_gpusvm_range by drivers
> > +that
> > + * only use the drm_gpusvm_pages API. The caller must hold the notifier
> > +lock
> > + * in write mode.
> > + */
> > +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
> > +                                  struct drm_gpusvm_pages *pages,
> > +                                  unsigned int pages_count)
> > +{
> > +       unsigned int i;
> > +
> > +       lockdep_assert_held_write(&gpusvm->notifier_lock);
> > +
> > +       for (i = 0; i < pages_count; ++i) {
> > +               struct drm_gpusvm_pages_flags flags = {
> > +                       .__flags = pages[i].flags.__flags,
> > +               };
> > +
> > +               flags.unmapped = true;
> > +               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> > +               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_set_unmapped);
> > +
> >   /**
> >    * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
> >    * @range: Pointer to the GPU SVM range structure.
> > @@ -2039,20 +2070,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
> >          struct drm_gpusvm_range_flags range_flags = {
> >                  .__flags = range->flags.__flags,
> >          };
> > -       unsigned int i;
> > 
> > -       lockdep_assert_held_write(&range->gpusvm->notifier_lock);
> > +       drm_gpusvm_pages_set_unmapped(range->gpusvm, pages, pages_count);
> > 
> >          range_flags.unmapped = true;
> > -       for (i = 0; i < pages_count; ++i) {
> > -               struct drm_gpusvm_pages_flags flags = {
> > -                       .__flags = pages[i].flags.__flags,
> > -               };
> > -
> > -               flags.unmapped = true;
> > -               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> > -               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> > -       }
> >          if (drm_gpusvm_range_start(range) < mmu_range->start ||
> >              drm_gpusvm_range_end(range) > mmu_range->end)
> >                  range_flags.partial_unmap = true;
> > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h index 4d31c6bba7455..b43432af56377 100644
> > --- a/include/drm/drm_gpusvm.h
> > +++ b/include/drm/drm_gpusvm.h
> > @@ -349,6 +349,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
> >                                     unsigned int pages_count,
> >                                     const struct mmu_notifier_range *mmu_range);
> > 
> > +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
> > +                                  struct drm_gpusvm_pages *pages,
> > +                                  unsigned int pages_count);
> > +
> >   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >                           struct drm_gpusvm_pages *svm_pages,
> >                           unsigned int num_pages,
> > @@ -383,6 +387,31 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
> >          svm_pages->notifier_seq = LONG_MAX;
> >   }
> > 
> > +/**
> > + * drm_gpusvm_pages_read_retry() - Check whether GPU SVM pages went
> > +stale
> > + * @gpusvm: Pointer to the GPU SVM structure.
> > + * @svm_pages: Pointer to the drm_gpusvm_pages.
> > + * @notifier: The notifier passed to drm_gpusvm_get_pages() for @svm_pages.
> > + *
> > + * Check whether @notifier was invalidated since the last successful
> > + * drm_gpusvm_get_pages() for @svm_pages. This is the commit side check
> > +for
> > + * pages faulted with &drm_gpusvm_ctx.no_dma_map, where no mapping
> > +state is
> > + * tracked. Pages that were never faulted always report as stale. The
> > +caller
> > + * must hold the notifier lock and keep holding it until its use of the
> > +pages
> > + * is visible to the invalidation path.
> > + *
> > + * Return: True if the pages must be faulted again, false otherwise.
> > + */
> > +static inline bool
> > +drm_gpusvm_pages_read_retry(struct drm_gpusvm *gpusvm,
> > +                           struct drm_gpusvm_pages *svm_pages,
> > +                           struct mmu_interval_notifier *notifier) {
> > +       lockdep_assert_held(&gpusvm->notifier_lock);
> > +
> > +       return mmu_interval_read_retry(notifier, svm_pages->notifier_seq); }
> > +
> >   /**
> >    * drm_gpusvm_pages_first_dma() - Resolve the device address array
> >    * @svm_pages: Pointer to the drm_gpusvm_pages.
> > 
> > base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
> > --
> > 2.34.1
> > 
