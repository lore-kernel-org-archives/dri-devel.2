Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17C606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CX0y4oL/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LhyTGh5Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53F910E709;
	Fri, 13 Nov 2026 02:45:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4072A10E6F9;
 Fri, 13 Nov 2026 02:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794537902; x=1826073902;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=MdAwFTmQda7nv+mbTsahnDguR94qLKDNBE7ymhwkITA=;
 b=CX0y4oL/YTDcVatIZd22OlhjrEyEZyXR3hodi6JsucfiIIdvV6ihCxHr
 6ekFPlpaT4wh3UyV9mG7Ta2eA0ynLI5kTDUYhjQGsVsiJ+y5rkXikN+kK
 Cx4Xw+peu4FNQaNBe7VSkd5BvCA24kfX5oKY/12f5x4rmI0MNcUzG1W4J
 FvYK6LcEE+EVE/XRo7IPPXnEyzikBU5Fv1AD4kS6mLI03PnZm/WHcuGgw
 6+ZkkjN/dqT8h/Bv1m2p1nRd2pC4UVjUrF6+T0hLSadSjHMGHR6oYdVgY
 IZZyrQ8dYBHwO8j4o1B1ieCx6Ea72AWsojWRSxVeSasJx15ZMTUAYOMHQ Q==;
X-CSE-ConnectionGUID: ckK5KiQvTe2bUccTxWMrYw==
X-CSE-MsgGUID: 7n20HGXHSmSbyK2koI9Tzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3331429"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3331429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 18:45:01 -0800
X-CSE-ConnectionGUID: wYGasEGQR5KLU9RM1i5WcQ==
X-CSE-MsgGUID: SStoUF1fTumNujl9wTTUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9138059"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 18:45:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 18:45:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 18:45:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 18:44:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWP2lqr1mvf+C/70o02QqVjZP5pljs0l+/F92KIDlMbmTUKoNpKCvZdUZ0an/IMLDLi7ZWJemEodlC9t8Ct/eU+/RxC7FvqUui3zXpjL1yg4yxYhN7t10uFY+EJVTDO8X2JsiQjC2WWul3gzx9PSAkJVOjWzhpb2DcWDFkyyzB7k+8QHhnAwVdnCFPv21Bj5SvplFlX27AaEeEd9IWsB61ooBI7ZJz2dwgcKe+8Um9dYq8imqRfq29c92/ZTx/zwkx3NYTWqili6dIBMQLr5dbJWlf+YSN2nvSaj4WntYitVDzSHxgZvJW0Zah/cFPYW/L3Pa2ZP4YdKiORI6FsYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPMBs7oMw8RlCiWzx8GZpKeCZ8x7iC7RbOEcfRXVZWE=;
 b=t51X3e15ht/KAIY1sW1Fbr9epz7MiGzzNbdrftQ3Ee3adTfcR+wzoTKGYorN3THjAsO2mgKCIcEa4qakev5xGp4mH5Gt5kELh6bhfPKnJdCdKvpNeFCNsvngW3oeNQqZyk0Svu17+fJaCES1fdVuc0dwetjqlP4MAsf6aMGQ/um9HRr0m8RGBTc43oImsoniKpTZfndN8tZlUJUoBnZDTOmplWVAMYFjM0pVxp/ae0fUtcKIMPWydyzRfqerJu9jFFbz47zMCOc8aKJ1818ZYCBwnIsYdlpT/dOXZVmMh20c4nxG2FrIUgjfftlrtAssLAyB0E2B788Gli6rXLeR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPMBs7oMw8RlCiWzx8GZpKeCZ8x7iC7RbOEcfRXVZWE=;
 b=LhyTGh5QKf9XysTrzNTGPwfgGpiNsvdwOHJ7QgwPstwnDRaVvV2rurMxe33A221SbKQsa/GaYbrQkxYRANrSl0vxwuBauqFUXHUyrYZVA9owsvouTl2jJSgZZBRhcqpr6IcxU1peMSwDQ0ZZeYNPPmPkdB+Fi9dNderqm9HAsvE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB114605.namprd11.prod.outlook.com (2603:10b6:208:54b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 02:39:52 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 02:39:46 +0000
Date: Thu, 12 Nov 2026 18:39:40 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-fixes
Message-ID: <avZ4bHmL2NTc4W8a@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB114605:EE_
X-MS-Office365-Filtering-Correlation-Id: ff909dfb-9149-4b4c-c9f1-08df412f6113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|260925021311599003|260925021911599003|260925022911599003|261102123227099003|261022113327099003|5023799004|11063799006|261028144727099003|56012099006|261021121427099003|261009220027099003|261009221227099003|261009223027099003|261022105027099003|261009223327099003|261026140227099003|261021123027099003|261022075727099003|261009221727099003|261022115727099003|261026121527099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: prT0sncXMIqyyzKW7sn8qzqA3ra2a+4bPlziJUZbnUKPkzaLe8jOIEDMtmDMKzIOneE2D0rwQhLlAXsL4xW6cVhRpA6YTI6MO4b8ihZfq50OddYK/v58o4RzE9dVP/uzz+2nh+azxEgkEHpZIuPnfX50yXp7KBIMVLyetXLxNVmGcpNLhAU8U71iHbgAQx3C1Ew9JPnNaSZAL4734YkrvRSXe3PmqKNvV3XWaA7b2F16ZeuK5GFuKClBQJiEbg78mq9tajxblh8GZ0y6blTBMTFpNx9dXgnITXSeUVu074VfiB2WpKCat5h4L0zASqFPMRGkNKOkJhmLeW179R6NsAwmm6pMdc6yyWyQiYIXLqrX5cEOvzhIsf65ZfMRv1ddNURWjA6sPn33CtDRuUHmJKKzHcvV4Tx89yFaroFOezcjahgN+mjmbfctuIC701BfmoPEPasbeqP4gN5R9WLur/v34nDg5bA6g4sWaQTcj7d/2zxzP/SQ1RLdQY5HNW9sMAjXkV7MQjoXhlSe/+MyICP+jVXTEc/fmOZByDPtGfaMOEv/aeol+ynTQE/wFBZ1iyJJ4olCYzE2b8+W2wpanC4uoDOz+oBdgfJFJmH4+94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(260925021311599003)(260925021911599003)(260925022911599003)(261102123227099003)(261022113327099003)(5023799004)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261009220027099003)(261009221227099003)(261009223027099003)(261022105027099003)(261009223327099003)(261026140227099003)(261021123027099003)(261022075727099003)(261009221727099003)(261022115727099003)(261026121527099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1uuZKpFS8GTHR3J1n/xX+Z/A8IU9JVtV7f14NbLweRlmdhEWj/sbIPO6Td?=
 =?iso-8859-1?Q?JlzbajnLO5iPfzHC1lJwwhU+aIxbF6rdRKMarJFynf3oadPYMvQkesx5RT?=
 =?iso-8859-1?Q?ntJe0M/cugHtnksWXxGKQVBtsZsE5OqNl4tkbg6gE9gnxpeTvNqD+BCqvk?=
 =?iso-8859-1?Q?J7XcBPpMEqvVfPPq7F6cYcaBEa0abNxqgl1PPEOuRKtaZOHKWrv1Pi3PBg?=
 =?iso-8859-1?Q?x473vkVkRaNlFGg1PAY8aLgY0DJIER89fV/QwUl7t/09fgFqIFM8lVAaxh?=
 =?iso-8859-1?Q?MWLSu9Vl3a0hvM56UCO28OWVDuXIuLgz+DJZVv+ER7NCuWjLqV09UN875p?=
 =?iso-8859-1?Q?doThdlv19teruCwfyiRk08vurz7ir/vuX0snmCIuCzkI+9cZjQxctZ5r8r?=
 =?iso-8859-1?Q?TBHAbuBjKebj40sY8rha8I70el66gWSDoM4MTnesidTqo9h5cqkey8Rf1X?=
 =?iso-8859-1?Q?BkQLQKihEOK/Ep4b4HImNENvsJbL26qBwEXCMuCAiNEPghCAUeSZc7kLK3?=
 =?iso-8859-1?Q?fQF1PQki7zCgZgR1mA9V7xnaVJzWcbzhHjCcJsvLvmqFaO5NS/00MSrmfs?=
 =?iso-8859-1?Q?JEWAVPrbPH2Wa6zZAH4DoymS6sbC3MBBmEeKmGdkyr5Dy+Jnbrwnpp+fMi?=
 =?iso-8859-1?Q?j/m8a1GzTK2flJNz6MgJ/ZAoid5LR2XYuBPMXTHPlTlROzNzTMGoli5II2?=
 =?iso-8859-1?Q?mDokjYZipiIS4xmlzQl/bCU5YwQuq1i0LkXxE5EOaeagX1Z41pXVXOXVnB?=
 =?iso-8859-1?Q?V6o/Nlm1OOAf76oiMkOIKamI3Ci2eXHgh+KHSktd0LfDstCvp3B2TG0rID?=
 =?iso-8859-1?Q?Drs13HpelfB7XjAQaK+Vk1ZO2O55EjFT8AOyoKcztdRI6qmuWE68z3zyIn?=
 =?iso-8859-1?Q?JS/vlMv//KQqwvpldRlM9SUc9fkeY69zjxWOn0YvoLmPr0M0nd7ir+fhTd?=
 =?iso-8859-1?Q?O0dxXD5H4awHBxSY0b55D21KURCD/fCyZ6nInq16DRLTCjirHXBcjrI/Da?=
 =?iso-8859-1?Q?sJ1mkQzHa95HGiZVqTlqcGdm/D0lq1c3bQ0qPtWtIMg1TywgANeGuLHHwX?=
 =?iso-8859-1?Q?pRbBX+tocgqrwmtzz0K/vj074itnEiWLTyBt857v8T3gHOTfYDtNB+XD+S?=
 =?iso-8859-1?Q?/V0/QM8ox61ihvy7IfGF2rrye9e8KsL+lsj9OEyrmCJRyy3skVutdsaKYN?=
 =?iso-8859-1?Q?xrBV1JFoRz5oSxj8HKIf9gYBCkCXiOeCf1Z4EiEKiR4zdHNBOslmNxJeAm?=
 =?iso-8859-1?Q?ZwwIR2UdvJEwWiot2OdWwTRTK7/Ov7q3aQE8EAJ8wXpNeLw3KJzkm6UQ2+?=
 =?iso-8859-1?Q?XZhej8YMAi/KgocCZzRiNoPnvgEolKzUop++qoK8npHEZb3ti12IqGVRxr?=
 =?iso-8859-1?Q?+v13rpfJNWhdIX0kVDB9DN4ZwPh3JMFXEqlf72WIJlqs0vJeXQqaSWDUwu?=
 =?iso-8859-1?Q?qsDxyOoGTz4tiLMWQ9wsReiGITphjPb3BQx+8k/5J4058if03r4Rp72VoW?=
 =?iso-8859-1?Q?aI0hcWqIwFs475FPTXEU8HzqyTXS4OF2AqPXdz34eYSVMLP1VAAUGYRjBl?=
 =?iso-8859-1?Q?0UsLxRJ/7nNp/pmoW5sVcgL/II7yoWJuk3hdymO52rmdhgHoAhybAM/HXV?=
 =?iso-8859-1?Q?5TO9d4DVmgSdXGIY9fUq18aH+oCI/pMMRE6SkV7Jb7DGrePi80Mr0Kc3/Q?=
 =?iso-8859-1?Q?g/HpZfhUyuafs9jH22p3CZo7M91VZSn4kFIi8BHg5QxmFtfH2cdw2kJR9B?=
 =?iso-8859-1?Q?bG3XJAYz5T/GGMi+x00QqRAJzOok94UBmVfi22RXwpTJ3nzN+vpL4KYt/5?=
 =?iso-8859-1?Q?qYJlh+ZoqQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tztES3F706RW85xY+5Y8ZGgd4TeIs3Pz0vizIhCOwz6/nbI3Dp7NkA1Lz7Tm0cuMsSXncRrPgxIGQ6+GtwNRks0cABes4ZuSCps5elf+cmEwiw3MtA0s3Wn4qsQkTQuXdtul02zP3xEV6Dj55nTyIfrXZXszDB5+MfG4dR9Y+JGjFsAAkEf1IQhtO96jYdF/MjrfMymPYyOTnBAGsoU0QK31wB9s1U9OK8r9N4Yzqj0y3nsi7bwiQJjSdiEsfQuAAmW8O6220AV+1cc4oJjMiEgYIHbWKzGYDZX0omX/e42K+wk2VKrgUn4YfbXYJDNwDFfadRma0U8miwVlVX7QRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff909dfb-9149-4b4c-c9f1-08df412f6113
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:39:46.0401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4K86g+cZs/kBQVC/63zK8Ez/NQcTRp9oHdcj/ANbq9n0XWcZLvq+pRwWc617n5q5p3pMg3KRu/9H5LRh86o4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB114605
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
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dave, Sima,

Here is this week's PR for drm-xe-fixes. Apologies for the sheer number
of patches. I got caught up in various internal fires before rc1 was
released and dropped the ball on getting out interim fixes PRs and had
sanfu generating rc1 PR.

Honestly, there's nothing particularly interesting here: some hwmon
work, a bit of GuC submission backend rework, VRAM offline fixes, some
CRI fixes, a build fix for configfs, and a bunch of other small fixes.

I hope everything after this PR settles down in the cycle and this email
arrives as Intel's email has been down all day to due the global
microsoft issues.

Matt 

drm-xe-fixes-2026-11-12:
Driver Changes:
- select configfs (Arnd)
- Sync Wa_16023105232 in xe_was to match OOB rule (Gustavo)
- Program LMTT directory pointer from each GT init path (Satya)
- Demote uncorrectable local error log on CRI (Varun)
- Apply tile workarounds after PCODE init (Daniel)
- VRAM offlining fixes (Tejas)
- ras: Fix sysctrl and drm-ras discrepancy (Roper)
- pat: Return error from xe_pat_init_early() on unknown (Roper)
- Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
- guc: Protect timeout handling from device unplug (Satya)
- gt: Disable GT reset worker before engine teardown (Satya)
- Various hwmon fixes (Karthik)
- tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
- gsc: Fix NVL-S GSC compatibility number (Daniele)
- Don't abort the shrinker walk on -EBUSY (Thomas)
- Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
- Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
- madvise: use already clamped pat_index (Auld)
- Various wedging fixes (Raag)
- Rebind BOs evicted before the first LR queue (Arvind)
- Toggle the D3Cold enable flag at runtime resume (Vinay)
- Access GT MMIO after pcode init (Vinay)
- xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
- svm: Preserve default PAT index when resetting VMA attributes (Arvind)
- Unwrap sync fences before adding them as job dependencies (Junjia)
- Schedule disable G2H fixes (Jagmeet)
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-11-12

for you to fetch changes up to c1234293de147949bf9cf06e3ed59ad8766e29a0:

  drm: xe: select configfs (2026-11-11 23:57:39 -0800)

----------------------------------------------------------------
Driver Changes:
- select configfs (Arnd)
- Sync Wa_16023105232 in xe_was to match OOB rule (Gustavo)
- Program LMTT directory pointer from each GT init path (Satya)
- Demote uncorrectable local error log on CRI (Varun)
- Apply tile workarounds after PCODE init (Daniel)
- VRAM offlining fixes (Tejas)
- ras: Fix sysctrl and drm-ras discrepancy (Roper)
- pat: Return error from xe_pat_init_early() on unknown (Roper)
- Prevent VF memory IRQ from accessing a torn-down engine (Piotr)
- guc: Protect timeout handling from device unplug (Satya)
- gt: Disable GT reset worker before engine teardown (Satya)
- Various hwmon fixes (Karthik)
- tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin)
- gsc: Fix NVL-S GSC compatibility number (Daniele)
- Don't abort the shrinker walk on -EBUSY (Thomas)
- Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng)
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen)
- Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo)
- madvise: use already clamped pat_index (Auld)
- Various wedging fixes (Raag)
- Rebind BOs evicted before the first LR queue (Arvind)
- Toggle the D3Cold enable flag at runtime resume (Vinay)
- Access GT MMIO after pcode init (Vinay)
- xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal)
- svm: Preserve default PAT index when resetting VMA attributes (Arvind)
- Unwrap sync fences before adding them as job dependencies (Junjia)
- Schedule disable G2H fixes (Jagmeet)

----------------------------------------------------------------
Arnd Bergmann (1):
      drm: xe: select configfs

Arvind Yadav (2):
      drm/xe: Rebind BOs evicted before the first LR queue
      drm/xe/svm: Preserve default PAT index when resetting VMA attributes

Badal Nilawar (1):
      drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry

Chen, Junjia (1):
      drm/xe: Unwrap sync fences before adding them as job dependencies

Daniel Charles (1):
      drm/xe/pm: Apply tile workarounds after PCODE initialization

Daniele Ceraolo Spurio (1):
      drm/xe/gsc: Fix NVL-S GSC compatibility number

Dnyaneshwar Bhadane (1):
      drm/xe/pat: Return error from xe_pat_init_early() on unknown platform

Gustavo Sousa (1):
      drm/xe: Sync Wa_16023105232 in xe_was to match OOB rule

Helen Koike (1):
      drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2

Jagmeet Randhawa (2):
      drm/xe/guc: Fix race around q->guc->suspend_pending access
      drm/xe/guc: Do not attribute a TDR disable to a pending suspend

Karthik Poosa (5):
      drm/xe/hwmon: Fix pcode power limit handling
      drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
      drm/xe/hwmon: Fix thermal sensor data handling
      drm/xe/hwmon: Add helpers to validate thermal sensor readings
      drm/xe/hwmon: Handle unavailable memory controller sensors

Matthew Auld (1):
      drm/xe/madvise: use already clamped pat_index

Matthew Brost (1):
      Merge v7.4-rc2 into drm-xe-fixes

Nitin Gote (1):
      drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines

Raag Jadav (8):
      drm/xe/ras: Fix sysctrl and drm-ras discrepancy
      drm/xe/gt: Use GT ordered workqueue for wedging
      drm/xe: Drop xe_device_set_wedged_method()
      drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
      drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early()
      drm/xe: Make xe_device_declare_wedged() IRQ safe
      drm/xe/pci_error: Flush GT wedge worker before bus reset
      drm/xe/amc: Guard xe_amc_work() with runtime PM

Rodrigo Vivi (1):
      drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m

Satyanarayana K V P (4):
      drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
      drm/xe/guc: Protect timeout handling from device unplug
      drm/xe/gt: Disable GT reset worker before engine teardown
      drm/xe/pf: Program LMTT directory pointer from each GT's init path

Shuicheng Lin (1):
      drm/xe: Mark xe_vma_ops_alloc() noinline for error injection

Tejas Upadhyay (3):
      drm/xe: Re-validate external pin under resv lock before VRAM purge
      drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock
      drm/xe: Keep VRAM fault injection within the usable range

Thomas Hellström (1):
      drm/xe: Don't abort the shrinker walk on -EBUSY

Varun Gupta (1):
      drm/xe/guc: Demote uncorrectable local error log on CRI

Vinay Belgaumkar (2):
      drm/xe: Toggle the D3Cold enable flag at runtime resume
      drm/xe: Access GT MMIO after pcode init

 drivers/gpu/drm/xe/Kconfig                   |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h         |   1 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h      |   3 +
 drivers/gpu/drm/xe/xe_amc.c                  |  10 +-
 drivers/gpu/drm/xe/xe_configfs.h             |  30 -----
 drivers/gpu/drm/xe/xe_device.c               |  60 ++++-----
 drivers/gpu/drm/xe/xe_device.h               |   7 +-
 drivers/gpu/drm/xe/xe_device_types.h         |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c              |  17 ++-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h  |   5 +-
 drivers/gpu/drm/xe/xe_gsc.c                  |   3 +-
 drivers/gpu/drm/xe/xe_gt.c                   |  77 ++++++++----
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c          |   2 +-
 drivers/gpu/drm/xe/xe_gt_types.h             |   9 ++
 drivers/gpu/drm/xe/xe_guc.c                  |   1 -
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   5 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           | 137 +++++++++++++-------
 drivers/gpu/drm/xe/xe_hw_engine.c            |  17 ++-
 drivers/gpu/drm/xe/xe_hw_error.c             |   2 +
 drivers/gpu/drm/xe/xe_hwmon.c                | 180 ++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_irq.c                  |   3 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c         |  15 +--
 drivers/gpu/drm/xe/xe_lmtt.c                 |  58 +++++++--
 drivers/gpu/drm/xe/xe_lmtt.h                 |   5 +-
 drivers/gpu/drm/xe/xe_lrc.c                  |   8 +-
 drivers/gpu/drm/xe/xe_memirq.c               |   3 +
 drivers/gpu/drm/xe/xe_mert.c                 |   6 +-
 drivers/gpu/drm/xe/xe_pat.c                  |  11 +-
 drivers/gpu/drm/xe/xe_pat.h                  |   4 +-
 drivers/gpu/drm/xe/xe_pci.c                  |   5 +
 drivers/gpu/drm/xe/xe_pci_error.c            |   6 +-
 drivers/gpu/drm/xe/xe_pci_types.h            |   1 +
 drivers/gpu/drm/xe/xe_pm.c                   |  20 +--
 drivers/gpu/drm/xe/xe_ras.c                  |   3 +-
 drivers/gpu/drm/xe/xe_shrinker.c             |   3 +
 drivers/gpu/drm/xe/xe_survivability_mode.c   |   3 +-
 drivers/gpu/drm/xe/xe_svm.c                  |   1 +
 drivers/gpu/drm/xe/xe_sync.c                 |  33 ++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  53 +++++---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h   |   2 -
 drivers/gpu/drm/xe/xe_tuning.c               |   2 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                   |  11 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c           |   5 +-
 drivers/gpu/drm/xe/xe_wa.c                   |   5 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules           |   1 +
 46 files changed, 583 insertions(+), 257 deletions(-)
