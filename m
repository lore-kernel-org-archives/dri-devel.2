Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE948606A887
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WmOsR7ld;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=nLJUa1is
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046F110ECFB;
	Sat, 14 Nov 2026 01:55:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BEC10ECFB;
 Sat, 14 Nov 2026 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794621336; x=1826157336;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ppAWdLZC2W34RVDH6siruly+ZeTWPaItW2/Nlec49fM=;
 b=WmOsR7ldmxU2HG79tWx9H35hOc9NC2gBPKw97Sodir1FpDv/LKvFWLkD
 GdG4OF2k8QNPTePXA0J2Jyu1SunxZEVbp7PYF4/+7uRxfO/W2IbqKp9K3
 4js9FcKJpc0fkVlRnl/BGC/AWsfnG7SCB1vdmBpzx6BsqHJh4yJbp+0wr
 D5Fbo7A0ma88AgZckxyOVL1zEgUSCWH4W74EpA++yqDbpGqU+pjTMwZO2
 mA9T84oZfe01SeepmBM5hDAXeRuGgi92ZoONtp2ABBn4Er3QFo/hCDgjW
 GlW5OLaPDeGHnQVxWQpacZBvuC+EDBVe5nAjb/EhRJWcc32qGn9xPmmPn A==;
X-CSE-ConnectionGUID: NMtNkcYHST6HZO9wsizGqA==
X-CSE-MsgGUID: 6hZcQwmgR8KlkUcMGYcHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3326470"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3326470"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:55:35 -0800
X-CSE-ConnectionGUID: WOJhuYPBTiWgmitewPSPyA==
X-CSE-MsgGUID: y+gDwoMpTNCY/aLduaCEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10971431"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:55:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:55:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 17:55:34 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 17:55:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YheLPUjzf773HD4daRsAPLkgP43d/5lhB9OJxWEdXz73fklmNxVEmHl+2pRLVBwuy2PTSee0YquT+iEVyxeGg3TdKcQkwudrMKEkgPcuILremr+jIgdZDcS7FDx4XUCnRVNrM4cT/LLCdhttHD5s7N5b9UdrealmiBeqDI1neJyMeMfuMcWw2knMhecnT4HJxAEDoxS7ZxOs3Rpx0tocXS05T/bvWpgWcGoAaMphPq7oZPFVfoHQUsELWAuy9qfSRyx7qVzSEy1C1B8MWZ+N1Y5cxUBpSJu/ej38GVpXnlHZHu4hkWGnQgu6ird910G4WxGHkEIIF+WlGEKq1eowRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzmDgdVQ33QP6+ai+fB8LqEhsBvb1S0sg4cErTjfOoc=;
 b=UACHVPTxCV/RQXsibUbXbwwGMDvKzEkQfklBEJNTWzn46SXAZgEa4xg9T3UBYs5B5ZpB1rW97J8qT/sOZ+hY1R6trjEv2Yb6I2fj5ptcpT0j4Uf2ZaOslJ7xL3gErQTEooMmEwJz7rw08fa1UboBkYdqqVioaGKJuP8f7svjzpkZS/RUY50Id2owUnJyKCZz846hqGoN9Yrs1PbeV5o6rWjDhLNiXmoEGaGBIuodDYOHhhQKmPRr8hTNxvH0JqdqAtYP7C0XM6bI7C1j69hQzU/G+UEzMEAmOeN62blZ7StILn0cWqnSS5RSN2ImjsARGeuHjWoZvmOrD9EcQ6nToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzmDgdVQ33QP6+ai+fB8LqEhsBvb1S0sg4cErTjfOoc=;
 b=nLJUa1isja65ooAfxUrkMiBbCLByV4MlB/LblenVtLWNIN01a5m/L+pykKyHvfW5a5Iyl91r4Y/s6rA3YmLRF2r8FJy42Kp8BRpji4U4PYZO9Sw7wnss94/MGVZvuTQScw6sFhB1BzQ/Y/XIJNwppf5zSu5W8ePHYVkoazLZxaM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 01:52:55 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 01:52:54 +0000
Date: Fri, 13 Nov 2026 17:52:52 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 30/33] drm/xe: Add packed copy-step IOVA mapping for
 defrag
Message-ID: <ave-9FuepY6oCWzW@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-31-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-31-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b60765-df42-4fb4-f267-08df41f1fff5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 35xO2xcsiCkrPTNy7mwjbywxcptLrbzpScT3fNialCJSaYv3+ferkmC6zcoN0U9g50iJ9+01ku7H9PzPpkiGp4YAr97RNl+jHCKmUo6QL8vZ/BIdmAWrXdB/e6rkPqsmeINvrAV53NfU2vLixQA98kMH3FceGfRnJGizcgh4ViEIzUapZGX+NIjvANMTDg1kTEOJXjrjC4KjXA4IW7b2bHy3UaS5/o79w9iNPOFYEvddOVlC0GduK7Bdh2J44lWEhI3D8rIX/Pi+wLwD8uqjtEIT49Qq8miX/FSUbAmMk8UXXqwo391tHIN0ZoQrt/VG+4pL0Pz+HPKmj3/NMnDDMiFYraDCpEsHES1JSZluJRNIGrS7EdNRnhZ7uM4pIHY7rwHA3PjVM1DY4uME0yk94ETSzt9k7KVZC7xXPtbSHXhKMrp9+UPcBCIY1x5w4vHfLbpRmaWzBDzBW5pM2fZZZ77wADWcueyU7LD1yIQ0Lh5UbfKw8MOupYEDopnxS00hVj9vmChV2KleMnCq1CpxSAVu00upHdm/mPWGgFLZEaYn3exrXpkPHTrEo5LK3D7zHhD8235hZcgtezmeUfxqTuDFjUhlFD53PuVip3rr94d8JrAYvNYDh8YTRJTTP2SvrnP/hrGlqWXpXqSvmy0BSx0NJo9n5YD3u+ir5N++itk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o9ZZvcPJAarN/qjHVCE7p+3s+5eASQ6uPo16TowsgM2RkSXmiwyndUvrvh?=
 =?iso-8859-1?Q?ruNgKTFZxTT94z+pukdn0R5YRFcVLzAbBWGBh3hbuZTwUd5jyD2CqLMGBd?=
 =?iso-8859-1?Q?cWXoHcWlEBHjyOAKM8qcKI+6rMw66MB4Te4kN/iNOMQbsJLpJ5Ja/FMrEs?=
 =?iso-8859-1?Q?gPTRmOenqmpMGkeqdp5B1ju2oUkyiIWHod0jADFeyOS4zkByv4RiK9ygGy?=
 =?iso-8859-1?Q?yhtQbCgHOjD3a1X77EDog81hi1r4YD76IrDLBVeMApiuZiBs+VLn/Oa+Zv?=
 =?iso-8859-1?Q?SpmUWYOXvCo8Sp9AgvvPOKaPpcXzZtRePnADnCZaTQYEajTB3kV+jycEN9?=
 =?iso-8859-1?Q?IvuwQ9KeulI8bZohjwXouZCfA3NhRSqoH/4gOKXHucJkBIfwSmFLDZXviO?=
 =?iso-8859-1?Q?64b9J3NzhLXc60oQNue+ftFE6VCW2TRE/Ctj7dPXzfnqWX8a24ii8IROL2?=
 =?iso-8859-1?Q?FtYDsX2hB3FNbObN0XKfkCPu1QwG+qSLiUFhQHtNAbis4M7Nr8JQhCrRV3?=
 =?iso-8859-1?Q?2V2B052wtB/UBxtiPnl2CtZsj1scMt1B2c4wxytwFJt2fC2wjrseIY7VGM?=
 =?iso-8859-1?Q?lzUbwOCH69HNPXr+gDgrC19QRHLeOtO2fozhqUYo1rcV0c871uw73JYnrl?=
 =?iso-8859-1?Q?wkRzrnpZf3GHgsvUYqZyYgkkku9Uq9Mf4YPSkujt+G3QDbS9Tfz2mtdX8d?=
 =?iso-8859-1?Q?OfgUBMwJSg8RaB1TatOBGJAAhlThDO+ihr+nXvJgCU2ZAQtjVowsLNjWQP?=
 =?iso-8859-1?Q?pkm19GqN1WVYZYI38I+iuYn9RL3t910N1NPldbW8wPNyS3NgDm7m40WMNm?=
 =?iso-8859-1?Q?Ypa8Qm3zKE6YEgZhnu050gHfaFGqDSv+Fr2pxhvLfre0KX62TNfF/UIkMo?=
 =?iso-8859-1?Q?oZHL9LaiFabvMtvlhrlXWwOnafexlZxPsxVotMGZ8lNX0ErgcbeU09QfhX?=
 =?iso-8859-1?Q?hRI4OzVfxt2BRnqf6l3EUpchZuXjdcwU143ViZv59ImM3r2EM49AemHUY7?=
 =?iso-8859-1?Q?7wsa5UJxDBZvEzkQETg5zctefwlsxIhr8L46XfQkmUDG6T/E/I4MHkOOww?=
 =?iso-8859-1?Q?AWDancDjY5Cp9gFlNujDYPSlyJMIdiv/ahEDe7iWURqhIv1Lm1wq20LAEb?=
 =?iso-8859-1?Q?hkK1MB/VXOyQiPxAUQHAaLz+itgv+WAFiihQtcIT1UAPtl1tLLJCLtl3pE?=
 =?iso-8859-1?Q?IS4SWntcuUz1Wc7pmidrqptET83paaRxzVmQUwKfT0gzGLSdf35D1EsY/E?=
 =?iso-8859-1?Q?AOQ5qGtKHXf7J2Xzbx1irT9La4WrrrdoAQ3mLUCMNC0JjVn6wm4kdqqKRh?=
 =?iso-8859-1?Q?kGt3v8vkGlnVcbcZWkBArA5BmlYwnznXIjV87zlonwepMKz2bYpx1kNIcC?=
 =?iso-8859-1?Q?cGNeMcTZodFLal06Mh337oRA5VDfbRQVOMBtuuFxTzzhuzLPXvq/bcKTK6?=
 =?iso-8859-1?Q?fz5nL25HpoUe7NWenelzrmxed5qLYuOwosEcajvYPEnLdOq95ZIxE9AjNq?=
 =?iso-8859-1?Q?gnxzvfj9bz/z+koLAxZVfsuwEQjFZuVvNxCSOQ62HoqlL/rKGm1p2ZAhP7?=
 =?iso-8859-1?Q?+/0ilFdqW68zm5waLxQkWoxy+AQVu6GzV22zyT5DyM5PPPPbBBPrWX46vc?=
 =?iso-8859-1?Q?2up73t5Grbm7lCzFbi2gKXSiosLdmqD7TiFTglVpmXdc6DPW1dVwtfxyQn?=
 =?iso-8859-1?Q?43orb9zrwz1v7cUg1P3Rk6wz4rQyhva2CnBRXBW77O0pMC942mdps19tgQ?=
 =?iso-8859-1?Q?3CtOt/Ha/8MLoQBzQFK2QZzboPr11vx2puFGw4u8xtPOibqS5ro9vj7htU?=
 =?iso-8859-1?Q?m7/Y7JM7iXh4tBHDG2G7zUwkV1HFdaGGbDMhUfmKXrSl5yktnJXk?=
X-Exchange-RoutingPolicyChecked: 4p/TV+7qFNcShr/WZmgbm5nrpuK5AHhCoLnl7kNsGMyqp0aT84QMU2bwrASbYJdSjzsN+JM4/BsQk4+kW0YuMhucfV81nu2QczBsMY+JJFx3ydR5DVkEEOsDq9VJK0BOKURSjZaN1pwxxWZSHWo/EmaoZmFulP/U8KbWU8FO1nPjKHMgW8DVCU1VcDfGG2HfwiFtqowJwC9Jsr6iors3wIrKGRTyhozklUW2vGRHOzRNIOUvmspaQszdGgtAf+sZ5e4aekStN8JT9yrNuNDP708EbGywcYiQSKluegaXByMY21GD6u2UjjKhBN3j2RafHJKN1Ocezc5dzAhSMOQ8NA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b60765-df42-4fb4-f267-08df41f1fff5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 01:52:54.8616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnNdeP2pfUwCiK8BqDYfYCtVByHvr7AMoqhpJ3sqq4xllpFQ2n8L4+vhf1npD2rL8RD4SeVmbbqzjn4sL9tCMHGTDpXsye/mmMRMvqIBzXm/J+4ks4oYdHgqlmGVZVms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
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

On Fri, Jul 10, 2026 at 07:56:16PM -0700, Matthew Brost wrote:
>Add machinery to map only changed pages during defrag when the
>destination TT is IOVA-mapped. Only the non-borrowed (freshly
>allocated) pages need copying; borrowed pages are aliases from
>the old TT.
>
>Add xe_tt_iova_copy_init() to diff new vs old TT folios and
>record changed-page runs. Add xe_tt_map_iova_copy() to link
>those changed pages packed contiguously at the front of the
>new TT's IOVA reservation, synced and ready for GPU blits.
>
>No users yet; wired up in later patches.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c | 364 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 364 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index c5022c16411f..c087f17ad6db 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -531,6 +531,31 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> 		}
> 	}
> }
>+
>+/*
>+ * xe_tt_account_iova_pages - account a tt's pages from a full folio walk
>+ * @xe: the xe device
>+ * @xe_tt: the xe_ttm_tt to account (its @iova_dma_pages must start zeroed)
>+ *
>+ * Walk @xe_tt's pages one folio at a time (the same head-page order walk used
>+ * by xe_tt_map_iova()) and account each into xe->mem.dma_mapped_pages[] and
>+ * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
>+ * the pages a tt is actually mapped with.
>+ */
>+__maybe_unused

Assisted-by: LLM

NIT..I see may __maybe_unused added here and removed in patch 32.
Maybe we can avoid adding them here to minimize the changes.

>+static void xe_tt_account_iova_pages(struct xe_device *xe,
>+				     struct xe_ttm_tt *xe_tt)
>+{
>+	struct ttm_tt *tt = &xe_tt->ttm;
>+	unsigned long i = 0;
>+
>+	while (i < tt->num_pages) {
>+		unsigned int order = ttm_pool_page_order_nodma(tt->pages[i]);
>+
>+		xe_tt_account_iova_add(xe, xe_tt, order);
>+		i += 1UL << order;
>+	}
>+}
> #else
> static void xe_tt_account_iova_add(struct xe_device *xe,
> 				   struct xe_ttm_tt *xe_tt, unsigned int order)
>@@ -541,6 +566,12 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> 				 struct xe_ttm_tt *xe_tt)
> {
> }
>+
>+__maybe_unused
>+static void xe_tt_account_iova_pages(struct xe_device *xe,
>+				     struct xe_ttm_tt *xe_tt)
>+{
>+}
> #endif
>
> static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
>@@ -714,6 +745,339 @@ void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
> 		xe_res_first_sg(xe_tt->sg, start, size, cur);
> }
>
>+/**
>+ * struct xe_tt_iova_run - A contiguous run of changed pages in a defrag move
>+ * @start: First page offset (natural ttm_tt index) of the run.
>+ * @count: Number of pages in the run.
>+ *
>+ * Runs are folio aligned: defrag borrows whole beneficial-order chunks, so a
>+ * folio is either entirely borrowed (unchanged) or entirely freshly allocated
>+ * (changed), never split across the boundary.
>+ */
>+struct xe_tt_iova_run {
>+	pgoff_t start;
>+	pgoff_t count;
>+};
>+
>+/**
>+ * struct xe_tt_iova_link - A snapshot folio link descriptor for defrag relink
>+ * @phys: Physical address of the folio's head page.
>+ * @offset: Natural byte offset into the reservation to link the folio at.
>+ * @len: Byte length of the folio (PAGE_SIZE << order).
>+ *
>+ * Captured at copy-init time while the destination tt's page array is valid and
>+ * stable under the BO lock. The post-copy finalize job runs asynchronously,
>+ * after TTM may have mutated (or torn down) the destination tt page array, so
>+ * it relinks purely from these snapshots and never dereferences that array.
>+ */
>+struct xe_tt_iova_link {
>+	phys_addr_t phys;
>+	size_t offset;
>+	size_t len;
>+};
>+
>+/**
>+ * struct xe_tt_iova_copy - Changed-page subset of an IOVA defrag move
>+ * @runs: Array of changed-page runs, in ascending natural tt offset.
>+ * @nr_runs: Number of entries in @runs.
>+ * @links: Per-folio link snapshots covering the changed runs, in ascending
>+ *         natural offset. Drives the asynchronous finalize relink so it never
>+ *         touches the destination tt's (possibly mutated) page array.
>+ * @nr_links: Number of entries in @links.
>+ * @nr_changed: Total number of changed pages (sum of the run counts). This is
>+ *              also the size, in pages, of the packed copy-step IOVA mapping
>+ *              produced by xe_tt_map_iova_copy().
>+ */
>+struct xe_tt_iova_copy {
>+	struct xe_tt_iova_run *runs;
>+	unsigned int nr_runs;
>+	struct xe_tt_iova_link *links;
>+	unsigned int nr_links;
>+	pgoff_t nr_changed;
>+};
>+
>+/*
>+ * xe_tt_iova_walk_changed - Walk a defrag move's changed-page runs.
>+ *
>+ * Iterate @new_tt one folio at a time (folio order read from TTM via
>+ * ttm_pool_page_order_nodma()) and compare each folio's head page against
>+ * @old_tt at the same natural offset. Pages the new backing borrowed from the
>+ * old tt alias the same struct page and are unchanged; freshly allocated pages
>+ * differ. Coalesce contiguous changed folios into runs and, for each run,
>+ * invoke @fn. Returns the total number of changed pages.
>+ */
>+__maybe_unused
>+static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
>+				       struct ttm_tt *old_tt,
>+				       void (*fn)(pgoff_t start, pgoff_t count,
>+						  void *arg),
>+				       void *arg)
>+{
>+	pgoff_t i = 0, n = new_tt->num_pages;
>+	pgoff_t run_start = 0, nr_changed = 0;
>+	bool in_run = false;
>+
>+	while (i < n) {
>+		unsigned int order = ttm_pool_page_order_nodma(new_tt->pages[i]);
>+		pgoff_t nr = 1UL << order;
>+		bool changed = new_tt->pages[i] != old_tt->pages[i];
>+

NIT..I am seeing here and in other places, code implies
"new chunk = union of whole old chunks"
(new chunk never replaces part of old chunk).
But this seems implied and I am not not sure if there is any
single place where we ensure that and document it.

Niranjana

>+		if (changed) {
>+			if (!in_run) {
>+				run_start = i;
>+				in_run = true;
>+			}
>+			nr_changed += nr;
>+		} else if (in_run) {
>+			if (fn)
>+				fn(run_start, i - run_start, arg);
>+			in_run = false;
>+		}
>+
>+		i += nr;
>+	}
>+
>+	if (in_run && fn)
>+		fn(run_start, n - run_start, arg);
>+
>+	return nr_changed;
>+}
>+
>+struct xe_tt_iova_run_collect {
>+	struct ttm_tt *new_tt;
>+	struct xe_tt_iova_run *runs;
>+	unsigned int nr_runs;
>+	unsigned int runs_cap;
>+	struct xe_tt_iova_link *links;
>+	unsigned int nr_links;
>+	unsigned int links_cap;
>+	int err;
>+};
>+
>+/* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
>+__maybe_unused
>+static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
>+			   size_t elem)
>+{
>+	unsigned int new_cap;
>+	void *p;
>+
>+	if (need <= *cap)
>+		return 0;
>+
>+	new_cap = *cap ? *cap * 2 : 64;
>+	if (new_cap < need)
>+		new_cap = need;
>+
>+	p = krealloc_array(*arr, new_cap, elem, GFP_KERNEL);
>+	if (!p)
>+		return -ENOMEM;
>+
>+	*arr = p;
>+	*cap = new_cap;
>+	return 0;
>+}
>+
>+__maybe_unused
>+static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
>+{
>+	struct xe_tt_iova_run_collect *c = arg;
>+	pgoff_t i = start, end = start + count;
>+
>+	if (c->err)
>+		return;
>+
>+	if (xe_tt_iova_grow((void **)&c->runs, &c->runs_cap, c->nr_runs + 1,
>+			    sizeof(*c->runs))) {
>+		c->err = -ENOMEM;
>+		return;
>+	}
>+	c->runs[c->nr_runs].start = start;
>+	c->runs[c->nr_runs].count = count;
>+	c->nr_runs++;
>+
>+	while (i < end) {
>+		struct page *page = c->new_tt->pages[i];
>+		unsigned int order = ttm_pool_page_order_nodma(page);
>+
>+		if (xe_tt_iova_grow((void **)&c->links, &c->links_cap,
>+				    c->nr_links + 1, sizeof(*c->links))) {
>+			c->err = -ENOMEM;
>+			return;
>+		}
>+		c->links[c->nr_links].phys = page_to_phys(page);
>+		c->links[c->nr_links].offset = (size_t)i << PAGE_SHIFT;
>+		c->links[c->nr_links].len = PAGE_SIZE << order;
>+		c->nr_links++;
>+
>+		i += 1UL << order;
>+	}
>+}
>+
>+/**
>+ * xe_tt_iova_copy_init() - Compute the changed-page subset of a defrag move
>+ * @new_tt: The freshly (re)allocated destination tt.
>+ * @old_tt: The stashed source tt (bo->defrag_old_tt).
>+ * @copy: Output description of the changed pages.
>+ *
>+ * Diff @new_tt against @old_tt and record the runs of changed (non-borrowed)
>+ * pages into @copy, along with a per-folio snapshot of their physical
>+ * addresses, natural offsets and lengths. The result drives both the packed
>+ * copy-step IOVA mapping (xe_tt_map_iova_copy()) and the post-copy finalize
>+ * that relinks the new backing into the IOVA reservation. The finalize runs
>+ * asynchronously, after TTM may have mutated @new_tt->pages, so it consumes the
>+ * snapshot rather than re-reading the page array. @new_tt and @old_tt must
>+ * describe the same BO (equal num_pages) and both be populated.
>+ *
>+ * The caller owns @copy and must release it with xe_tt_iova_copy_fini().
>+ *
>+ * Return: 0 on success, -ENOMEM on allocation failure.
>+ */
>+__maybe_unused
>+static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
>+				struct xe_tt_iova_copy *copy)
>+{
>+	struct xe_tt_iova_run_collect c = { .new_tt = new_tt };
>+
>+	memset(copy, 0, sizeof(*copy));
>+
>+	/*
>+	 * Single pass: collect the changed runs and per-folio link snapshots
>+	 * directly, growing the arrays on demand. Changed runs are few (the
>+	 * borrowed majority is skipped), so the geometric reallocs are rare and
>+	 * this avoids a second full O(num_pages) walk just to size the arrays.
>+	 */
>+	copy->nr_changed = xe_tt_iova_walk_changed(new_tt, old_tt,
>+						   xe_tt_iova_store_run, &c);
>+	if (c.err) {
>+		kfree(c.runs);
>+		kfree(c.links);
>+		return c.err;
>+	}
>+	if (!c.nr_runs)
>+		return 0;
>+
>+	copy->runs = c.runs;
>+	copy->nr_runs = c.nr_runs;
>+	copy->links = c.links;
>+	copy->nr_links = c.nr_links;
>+
>+	return 0;
>+}
>+
>+/**
>+ * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
>+ * @copy: The copy description to release.
>+ */
>+__maybe_unused
>+static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
>+{
>+	kfree(copy->runs);
>+	kfree(copy->links);
>+	copy->runs = NULL;
>+	copy->links = NULL;
>+	copy->nr_runs = 0;
>+	copy->nr_links = 0;
>+	copy->nr_changed = 0;
>+}
>+
>+/**
>+ * xe_tt_map_iova_copy() - DMA map the changed-page subset for a defrag copy
>+ * @xe: The xe device.
>+ * @new_tt: The destination tt (must be IOVA eligible, use_iova == true).
>+ * @copy: The changed-page description from xe_tt_iova_copy_init().
>+ *
>+ * Link only the changed pages of @new_tt into its IOVA reservation, packed
>+ * contiguously at the front of the range ([0, @copy->nr_changed) pages). This
>+ * provides a compact, contiguous destination for the GPU defrag copy without
>+ * mapping the (majority) borrowed pages, and lets the whole temporary mapping
>+ * later be torn down with a single dma_iova_destroy().
>+ *
>+ * The reservation's remaining tail is left unlinked. This does not establish
>+ * the tt's final mapping (@iova_linked stays false); the post-copy finalize is
>+ * responsible for that.
>+ *
>+ * Return: 0 on success, negative error code on failure (any partial linkage is
>+ * unwound).
>+ */
>+__maybe_unused
>+static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
>+			       const struct xe_tt_iova_copy *copy)
>+{
>+	struct xe_ttm_tt *xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
>+	struct device *dev = xe->drm.dev;
>+	size_t mapped = 0;
>+	unsigned int r;
>+	int ret;
>+
>+	xe_assert(xe, xe_tt->use_iova);
>+	xe_assert(xe, !xe_tt->iova_linked);
>+
>+	for (r = 0; r < copy->nr_runs; r++) {
>+		pgoff_t i = copy->runs[r].start;
>+		pgoff_t end = i + copy->runs[r].count;
>+
>+		while (i < end) {
>+			struct page *page = new_tt->pages[i];
>+			unsigned int order = ttm_pool_page_order_nodma(page);
>+			size_t len = PAGE_SIZE << order;
>+
>+			ret = dma_iova_link(dev, &xe_tt->iova,
>+					    page_to_phys(page), mapped, len,
>+					    DMA_BIDIRECTIONAL,
>+					    DMA_ATTR_SKIP_CPU_SYNC);
>+			if (ret)
>+				goto err_unlink;
>+
>+			mapped += len;
>+			i += 1UL << order;
>+		}
>+	}
>+
>+	ret = dma_iova_sync(dev, &xe_tt->iova, 0, mapped);
>+	if (ret)
>+		goto err_unlink;
>+
>+	return 0;
>+
>+err_unlink:
>+	if (mapped)
>+		dma_iova_unlink(dev, &xe_tt->iova, 0, mapped,
>+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
>+	return ret;
>+}
>+
>+/*
>+ * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
>+ *
>+ * Move the (fully linked) IOVA reservation from the old tt to the new tt,
>+ * leaving the old tt without a reservation so its destroy path does not double
>+ * free. The new tt keeps its existing reservation snapshotted in the finalize
>+ * job for teardown. Called at the defrag finalize job's point of no failure.
>+ *
>+ * Also rebalance the per-order DMA-page accounting: drop the old tt's
>+ * accounting and account the pages the new tt actually ends up mapped with.
>+ * The finalize relink leaves the new tt's mapping equal to new_tt->pages
>+ * (borrowed pages alias the old tt; changed runs use the new pages, which may
>+ * have a different order distribution), so deriving the accounting from a full
>+ * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
>+ * mapping lives, rather than carrying the old tt's stale distribution.
>+ */
>+__maybe_unused
>+static void xe_tt_iova_transfer(struct xe_device *xe,
>+				struct xe_ttm_tt *new_tt,
>+				struct xe_ttm_tt *old_tt)
>+{
>+	new_tt->iova = old_tt->iova;
>+	new_tt->iova_linked = true;
>+
>+	xe_tt_unaccount_iova(xe, old_tt);
>+	xe_tt_account_iova_pages(xe, new_tt);
>+
>+	old_tt->iova_linked = false;
>+	old_tt->use_iova = false;
>+}
>+
> /*
>  * Account ttm pages against the device shrinker's shrinkable and
>  * purgeable counts.
>-- 
>2.34.1
>
