Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFE606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D/VBzm8r;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QdZXsZmU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144A910E078;
	Thu, 26 Nov 2026 00:30:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3F910E078;
 Thu, 26 Nov 2026 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795653020; x=1827189020;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PcqA26sVmwuPteWITNQZVqX52NG7VmjYuZfmw1mPFZg=;
 b=D/VBzm8rN4/jZQZSmQmi6P+943g6Vf19AzxeqF2dpnszEYAAYry1o/lF
 X7ktq3cUJZs75gZYLR28OnU/6f9pIyPu29Yn4SglFDpkvSUz0xwf+C7rf
 bGJ0y9mjH1/OujyneZhGbd9tmJ6yNqy8IwFU1wRehAvUbcnJ3ZgTWgieF
 paMcKI6lNfvIkz1sJJC0CNz1B3sEAka4s/OkPhpejR6SKrckxPRumnNKu
 pxaQte5XMw8WbSOdp6pcuLMnHOTM6gnG8VpmHXBVJkEz73DRumk2AzS9O
 4fts+m4/xuD9iQjY4+tK0KXfxTiZy/1lBW0Ll26lLzXXiela7yoA7NgMY g==;
X-CSE-ConnectionGUID: x5XfaaaHRMW/7CcAXHxYOg==
X-CSE-MsgGUID: PolADB7iTf+rdBoNeVAAag==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4501342"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4501342"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 16:30:19 -0800
X-CSE-ConnectionGUID: F2dbYKuyS3aHtfVTmcbgqw==
X-CSE-MsgGUID: YhQQava8RPyrXv6YNU8yqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12335979"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 16:30:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 16:30:17 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 16:30:17 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 16:30:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkyJR7n073CBRpQski6yxhIjLKIVVKmGGqew3RgLFPdNOI3o3AT7bMpwsIdvmlHOWpbJ+7m4RLjyJAf5Ah881bwwLjzn5Vo+P1KNuiZraEgB30NHHzmrN+rb7YDM8izjqOAil6HXGEGAQ87ApUIJqXJmO2d4LACru1WZ1J6ZKpp7rgtffzmcjjsL1gJfok3gmj2GGlj9wnvCH/VsZTTT+nSLlVgzkDrw86/m4hRvaHxrPG4rO5UDNesPkG+Ro4FGPJe1JULPxxeoLUBfaq+v2qGuOsCo4ml0IN/AFc6sl6sBYulJtbrzPq27Yr+qfNqNGgr2gLMLXQdLr9rKhITEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q44XUnr67BfwdNkhq7ERaml17OzVh6VQddCUMI18FOI=;
 b=oehxwP4YVqVlVq/2DNLNAuomNxLo6bAW5wfwIeNk3pQh2LszzX+Rvn2F0WD/jmVyv4VddDXui4hi7P8qptrqr21ub/l7v+zbyPcoLyYxodc8br2CqQt4ELMGpsGPW2jc/ATlceFAUioTcyJlJA47jS+uLU5Qui8PKeghj8BCatajvN1Q8ElwfALzeK54OkfX3ovS4RfQR8TqHw4IjV59euLQLLKargzrtyxtLwx17kg0RIpQa5eslKW/ps9D5GfHJZRT3sAmTNngzzGxumDqxVr8sQ8txcCE+2ZWOjRCrj3Id9MNFM5zpeR0FsdbVI7eFWzoup/xGb7LvjJk0d3/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q44XUnr67BfwdNkhq7ERaml17OzVh6VQddCUMI18FOI=;
 b=QdZXsZmUJCtwY/W4WX6LRKjHTXxyxPumqtF8sn9iOHGwDhECD28VlUDFRc4mUX6KIjaiWVkNm/QBQjwAgIo87/V2SfnHPzcIF3Q26ubwl1JXLypqxNCth2lEn88dUb09mILHZw0W4vjUvELSXLAQgbV3ASibknME5ghsGKMpmU8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS6PR11MB362586.namprd11.prod.outlook.com (2603:10b6:8:4c4::14)
 by SAWPR11MB9712.namprd11.prod.outlook.com (2603:10b6:806:4ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 00:30:15 +0000
Received: from DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a]) by DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 00:30:15 +0000
Date: Thu, 26 Nov 2026 08:30:08 +0800
From: Philip Li <philip.li@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: kernel test robot <lkp@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, <oe-kbuild-all@lists.linux.dev>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <awd9kCflXloWA++W@rli9-mobl>
References: <awXJ__-grexFFPb4@sirena.org.uk>
 <20261125093804.Ygd8f4XE-lkp@intel.com>
 <5fc38eb6-f999-4aaa-98df-21a0b1bca01b@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc38eb6-f999-4aaa-98df-21a0b1bca01b@sirena.org.uk>
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DS6PR11MB362586.namprd11.prod.outlook.com
 (2603:10b6:8:4c4::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS6PR11MB362586:EE_|SAWPR11MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e40321-98f4-4c47-4c8e-08df4b5470ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|261026121527099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: d7kOtV2CqTHoaMZdRrhX18Wc3RGiuBeYIk68tETKtch5/N+WuBhXG8FiNYIl2bvvpdJVPv1fZVbb0qgoi4Q32imoSUtPGCXjsopEqh6l9NXr2WmynnBLnqBskuG85aKFhy5YjzxEZlG29Pr36k5QWT3TJUkiT1kS/AOeNp6O88PNR4vxe0Aj4zDmy86XbHgdZl6WWejlwNY0qmouWpLeDEiSePFJARatJMSUq+VMfeHea2hWjtnWgh3tfOo1YWij9zXK+KBkuQL41xf1A5xNpB/OsmSUi0c0qalTVUjUN4bhbq+UspGHTB2JPMq93QugPRrGo0tAXwm7xuCNmNbLuUXJfL4Ecx0Tb8E48Fa1fVJH8RMWiCju6opaZ8WvcyS5frjJjbS0Z4dgs3CdVmx3CwExRpLYmmB4ompPvnM2RmBV4meAHQhzq58aELgk2Od/3XGM8x0GW3yRUbVEjX40C68FwvdBFYPeDrJxbIU9ZvQSBMRgFhlKAKA+DbAjIFyWkYDkFUkBpSBl7yX5IX0QsRVmz6ADspa8Q5iiLVhbrBUF6hAoLinkPJrnt4P5albsB33cx5Y5k/I9bzJ/zsGTbO096ct4tLu9EktmwEX22Ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS6PR11MB362586.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVuWtxGzuD9RYmsc8/F35ZoWre46s2uYO5IrNPiXS+3azLY4C8HlRPWTnJAm?=
 =?us-ascii?Q?X2nuSl/gssdkt30HAPEbDFDpje+EXP4sI6umC4AEYUjS34GcJT6b5Wbt7bo0?=
 =?us-ascii?Q?+6LgTHA47O2dWBHqtpk3PzIyxEEJQH0B1ah+EL5qRBVvr3uOuf5o89p6rz/s?=
 =?us-ascii?Q?rtRIpOIZlFFmQv+rxrR72aRYaCm4rMfFtiJoIjO6TPcTXd+2n4ngZQ8TyKYI?=
 =?us-ascii?Q?vgQ5CgEg6jwI64gW61V0Tx4aW0JQ5OWyk/USq6ifn+nOyHZFzcDW2G8dbHCb?=
 =?us-ascii?Q?JIPQJIw/4NqCfpmHDNJ1OYjzkFIBHilrX6M61mpVpLgTBmrmrrYRIUtiedTp?=
 =?us-ascii?Q?zMnPZnTQpeMmonBxlVh3gtvOuooGCvqB1+I5bjvyahNU0J37Ms+dipziw+Q5?=
 =?us-ascii?Q?mC36LhShR2aEkeLMXvzzV1/p+wDHUx33agmZqTDoKG77AzLBtou+gZSuc3ic?=
 =?us-ascii?Q?bv+PQUvtwErdE1tVJqFDPJD7BVGxdxvZbI9Y6qQoFAj/uZWcq0sj/nBYPAWn?=
 =?us-ascii?Q?bhVxf48Yidel/FZFOVf2u2SRwmVP+slMkjU4fb3HwaEdgDxx3IO3wLR9hJWt?=
 =?us-ascii?Q?Zq67qO3MqNBgA/LyhMXISoVTB3JjFVBBKPJTKOtpmg3uqGOd/aSHv7WS24qc?=
 =?us-ascii?Q?WkybY1o7hkeu8sbk14i7vI2jGxg8sgMzfkVRn5Q9YU9u9jWqEHAgALfjwMCs?=
 =?us-ascii?Q?3RnTXHrhzMpSXXOZZhz1PkHF568buQSyfSQ2n+2l2rHNurc2hDZSfU497y5U?=
 =?us-ascii?Q?SGeGhtWuGamoGLAAx3mUVypOWtKe3K8EgOaLHPKdu6IUlnFr5iaeLk7G+kEi?=
 =?us-ascii?Q?CidpflglEMVn0gsEagN5N4ybFcaiLjhE27y/gdpITX1tgA5Gt/kasIHRbwgF?=
 =?us-ascii?Q?1IxNqFEl/D6238hXK0RfKtQUCbgk7PTrq3pM7f+y9TjkY3RnW+RKQ+BZEg3Z?=
 =?us-ascii?Q?vZGigtNyAF2Hsw9SuEjsP0Ehh/uhwL4XYACmA4N5wL9208WXbXmA7xi8eyIw?=
 =?us-ascii?Q?fkHjwm/qLkwEk8YybnvKXFGCcMfVYHfAt2l/U9xjw3sSx53a8ENQUg65cuXL?=
 =?us-ascii?Q?BO+E+MBDwDVuarAFxVSEDI4lX0OnSx8AIGmEUTLkRVnDUq4wbMK7oAI6YlUc?=
 =?us-ascii?Q?2K/C6DPUg88DmoEbsA/iB7rhoiDq2te1zeSERCrgdVNtJRWmoJjjO+gui7p8?=
 =?us-ascii?Q?ST5I2ZmJA1nfuEGcyFrTsqLwgicZWGDIP/lfGUMyu0QRaODGo495WjN/kvWA?=
 =?us-ascii?Q?+4svBvOKuzRQ6gCIoXRaUci4BVdn6OS1SsCDcbecDoxHR2yyhWZ0JEHVBDLl?=
 =?us-ascii?Q?LCVRrYct5IeO+1jXGcR4ZGFhSpedZYW705YuwEbKDFSHNa8m/E6nd3DxwjF+?=
 =?us-ascii?Q?RY9gkzdH9+Mx+sXqAW0nK17UmBPdqWrlLYN852+5o4/X7WsFmMKGIjPeZ7G5?=
 =?us-ascii?Q?10F45R2q8W+93uUl8tnhz0i7s3MSYwxQVZ9nVtjscBoUJAbl5FiEWP6kKCzF?=
 =?us-ascii?Q?yYU+9hXRjT5z/WkGf3UQBGGGU36Dwr9nUzLopmXqXnvrd9wf6lvcbL1H3FsZ?=
 =?us-ascii?Q?7qKpGRqq0Z9mDjRtv2qU90VU3EgR4rDE3kFv069F47py1SAu93Zc0vmzOxhi?=
 =?us-ascii?Q?Q12Vz3WdLqV10z9ydNHfQ9uh0/9GRIKX0NdSJPBTkLq91IeGPCLa8E7z5RsQ?=
 =?us-ascii?Q?lGDiltxyzAb/dY6TsSlukH4moJXUngfBR8Xaw4TsJJvgIV79FazrvKhcdg4y?=
 =?us-ascii?Q?+p6LiuDJJA=3D=3D?=
X-Exchange-RoutingPolicyChecked: mU2g4MJi4Nb7S6KgFde+X5nHZ+u3GRMAwMsxoMwFaWApWh7pvZiACTgZ5cyjunlmq5FijskPcZe6NK6wB0hK7Tw5yY+HyYmwXHRNfXirQNyk+XBFQDKsNFusvxNOoLds9VwgM0SjTgngqIH/1vI9Ko+E6DuCZKX0WuTzJ95Zi86bEEpKB2/KTdw5/+uPWISJHPjywPMXP+Orm2WTL9zBBJTCoKT4eR68qG2Nbtu+Fs9YRbD0F7GPLreTvmUVgDRFVYSEaimxMX0mr1CtWL76/Tu1NuDG/HGtkbdzx8Z44u6P8IBxTZuumwtwQ1Za9cQ+SWvZwZsuSxig4A3UUJDzjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e40321-98f4-4c47-4c8e-08df4b5470ad
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB362586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 00:30:15.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvf2l/Rd8hMl5Cr0OMboxITujnFtdf+3rDXT1bNDBzVcIjUaYrPdHAkEeBXzn5oc8DX6494Ugt8+JserN0pZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9712
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 12:26:49PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2026 at 09:44:55AM +0800, kernel test robot wrote:
> > Hi Mark,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on next-20261123]
> > [cannot apply to drm-tip/drm-tip linus/master v7.4-rc4 v7.4-rc3 v7.4-rc2 v7.4-rc4]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> This wasn't even a patch submission.... 

Sorry for this false positive, I will follow up to fix the bot to avoid such
kind of wrong judgement.

Thanks
