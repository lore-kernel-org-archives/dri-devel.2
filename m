Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CE606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y4/IKNtT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0158F10E848;
	Wed,  4 Nov 2026 11:11:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D796A10FB58;
 Wed,  4 Nov 2026 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790698; x=1825326698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=e2TgNgMIwxj6QoUJ66uHMxj9ZaqXGS6eaiDe+anQUY0=;
 b=Y4/IKNtT6w/mNxhD5v9iVrc+VLL1V/Hpj8YQvfQoxvRpdyq3QLhu7iS0
 rzFL+kKQZLsJ7cbXer6f30k69BVdd1Fo6PcZx7WEQXZ+jOCOEI70lMlpB
 C5wKkaefHwUBzjZUIo4jVQjQLLANTDXma9z/++F19MBR9oLY4SNCqqKVm
 W1YyGhpDYtpYim3svHI8h2gJ9pCWA1NQ6MxgaAmyEv61J+/ph8H758ZP+
 F8tUaDH2waSXTWahGrrVIOaP2Ol407M/QB1adXrRWb637Tn+j/LL2px+5
 qN8edmpsT4+IVl3xBUTcYAy3C4RqyrgLf+56agN7JHCX3EbXTWPH6RgDb g==;
X-CSE-ConnectionGUID: +8y177+FQSOPoMZnoNgmxw==
X-CSE-MsgGUID: p6G23OOzTBShnP2J9ENleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2572935"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2572935"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:38 -0800
X-CSE-ConnectionGUID: RdBHayqqTXOPFjZcO2k5vg==
X-CSE-MsgGUID: Ed05SSdcQ8CwTOsDrpxwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6833894"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:11:36 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVqSwErXXDxYGSYV3Olc0H3ZK2/V5mgr7kJx15t7+B3pY4tit4se3MvXY+b7E5C/julYOe8XDgvja+FIbXIwSzzWn459pYoyLZGoN2GlcIm3n/Tm6Zh3wXVTeNtm/d49RD4HApdKGn6NFTmX5GpzHNABWNCGI1KRcbBaAzmfQajYJOFBmXZJkqOsGLGASPUob4N05JuqtXd7mKtCibhE81eASzTie4LngehBalCBW3ZTtJ+Bz/CoDeU/+IfATBErmrhoxVEZkG+o+CGce+6xD+1lQEDSX4ouTDhF3XvuOmgqc2To8fgNhhjK2YZd5gnH/zzTy+pRjgURBPbtCMZkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IuQAOmoTjT4J9DL4YrXiM4TpJYiHDemrfe5mqznJuk=;
 b=PBSF1C2NBALvFOM9gb68Q0pLi6IptXvOwY5V8ZIUjSh9cKTvnBpvNGu0NcXpHQ+pFZiofG27woqf+sWmBRzDQ+LTjxwer+vGCVHWeO0lAe6VKyS2jPNpHDOkDdnW/aj74YqNztkS77AJPvKaO7cXyfQbX2sQkGrd6GzaRBEuNNXsMcVexaNJl0h/BUWoSl/adGQZ2FtNZ+FKmqLoWGZitrvinyQ0Khzb+Jrrn1yYk32eeryya7eUt/DXz1YJU87Y/Ak81/r0RmoiGUoOwcAL8cR+9eiAarls2D43MEyOdI9ioZj6AOpdwT8A+UTTVnSXjSaZTxAu/p+/8M2osRusTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by LV0PR11MB016677.namprd11.prod.outlook.com
 (2603:10b6:408:607::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:11:29 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:28 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 5/6] drm/i915/gt/selftests: Use gt_* prints in gt selftest
 helpers
Date: Wed, 4 Nov 2026 11:11:03 +0000
Message-ID: <20261104111104.946617-6-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104111104.946617-1-krzysztof.karas@intel.com>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|LV0PR11MB016677:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f2e8ac-4cbe-48ba-dc5e-08df3a645f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261022113327099003|261022105027099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: R1LvuWz4Ll8SrVBPJSQYdSSAghUSbK6BZNfnn8jjisd3+rOI1LJehw3wuVgqyWuhG+NVP8N90G7STSo99cAbXD+F4lNpCBMZgX8yAsDRlxja/k4mw4bFJPJXS65dfjG2/r6t3lcJ+wREMKKMdEzmV7xyVGWD9WGrZoNfXswQ9gEz1OvUq+NjigcKFohpMabT4vFtlgyuYzZZWpVyOCIz9YS66yCs0BHnljtG6qiDcREuLa//vAzoWiq4vMKhdWRowFHp7L4aHZ3lTApM20Buk2jYlbdZ9AxrpLZD3r7otMt8LwaZ75hdYuDrUhtV1KpctYkaNJJr9vAbQdBF3uF1NDH2w7yetLd7LSniowdxo5a5myBpjN0c1gdJv1o6c8GA16kH3C2AGdedJcTkCYQzlbG3KIS2i3NTC9HZ1CniOiiM+VaBxKjf949FaWwrJTTOElvAKse9pT3sUAHnKQeQ2BsQOfM8iupoAnGslEmPK6Y73WjvW8dzI8FjR74G9+VMHEALKbtOW67HHsUGN5BVL7fvPu/qsZxTGvPek7gtZ7lYcaQ28NcISIAc+XQtel2hk8cBzJyxuLsnXncJyP+Drg6/Z6I6ZfZcJ9o/rQ26oWTiw11USsHeiZuCnMCgBjQKkBkqs6wMa/XeggD9GAHQ+AOD9dXr3+bKo6QnoW380TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022113327099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZLbDdmNDM5Tmg5R3d2Szlyd01GMnZoMENhWXNWWWlQU3EreXdYcE1wemtp?=
 =?utf-8?B?bE5QdzFRUlltSEQwbW8wbG5aOURLNVB0c20wNVE0bVpqaHhjTlhLS3FwcXJD?=
 =?utf-8?B?bEZrNFpxcEtRQXJrTnZNRFdyRitMTDhnVDY3akpNeGdZeDJxNnN5cXlGbzh2?=
 =?utf-8?B?b2wwdmozUjhTbGlJc0syUlhuaHJ2L2xGYmVtK09lUkZUNEhGZ1RiTlJHRzFa?=
 =?utf-8?B?c01KQXE3Mi9rdk1FZzBPOWM1T09SZ3NiNDRSU3B2VUNma1djZUNwOG9TTGRu?=
 =?utf-8?B?QlNrcGdlc3ZLWDB0cTJXaDdFQU5xN2h1N01kSGVscXVpNDNZY2l5S2VEcmU2?=
 =?utf-8?B?bFM5MU1uamVQYVVDa2NoZHJvL3dzQ0M0ZTlZRUEzM0YrdmVWbVFPMENKOWlP?=
 =?utf-8?B?Q0tueUNsdUhtWXZnV2Y2c3NHUDN1QnBpd3F3L0JuUmwxaFcxcE9GZmRCd1J0?=
 =?utf-8?B?OFU2RE1sUUx2WkFXS3J0bjV4VHdSMXo0TmV3MVVyaG5HR2JhOEJGdENYdkhZ?=
 =?utf-8?B?ME55d3lxMVpmWmk1emw5Q2R6VDIvNGROdUNUc0Q5dlkyVWxscnF3QThjRytL?=
 =?utf-8?B?cVdMbVBlZW9RTkE2T2V4RU1Dd2p0NVRxbTdPNUJLM25MRXA1VlhqWUtZYVdG?=
 =?utf-8?B?ZXJmQ1R1bWpMVVROaTJPbjNzbzk4L2dwL2VyR2w0aUhicjlMTktKamsvVmhM?=
 =?utf-8?B?V0drYy9IV09HNWlJMVlXeUZTck1jYUNtZ1pkaTFucHkyZTdOajZXY2wzRlg0?=
 =?utf-8?B?VDNCOXdZbjNDQnEyK2dSZjNzUFZUcktrNkpNMU8yaEVESXVqM2RjV2VPTndp?=
 =?utf-8?B?blBTUVRibUg4aXFWSHQrcmtkVmlkZ3didE5NUFl0T0VkWmlCVUtUdmFWL3FS?=
 =?utf-8?B?QVlZNUhLRzZ1aFI5dlpiVDFPZ3BQZCtHU2ExUjdkNUJuWE9WUXlzNHp5TmNh?=
 =?utf-8?B?TDVEdENDNE10OSt2VnlyZFFkTmU3MDBkbDVaVUZYYzR5dlozTkJtR252aHJj?=
 =?utf-8?B?VXlpbjVXdWpTTFZtT3I5MUFUZVZEbkxSb1lxTmxaSm45L0FxOXVrMWpFQm9L?=
 =?utf-8?B?RjR5Lzg1TEsrb0hYOXBJaFRoWFk1OUtlMGtDWDgwcUpTSlAwNkdXcTBDSDQw?=
 =?utf-8?B?U0psNnJmMUNJZjhVeDhHWm5qQzcwdjNJYkpXYmUrWlhWODFnMU9JU3FQMHRa?=
 =?utf-8?B?YXVJMzhUM3pyM3krUlVHREJjUUI1TVFKWGM2OXJmOG1uL3RENktUelZEWGtw?=
 =?utf-8?B?UFdxdk5ZK2YxcU9xRkhWNmVKQ1VRbW80SStJVi9IejFPamIvR09MMXF0N1gv?=
 =?utf-8?B?L1pxeE5YQ2I4YUVab1hHaWdRcEpUMlAyRUVEaDRJbDJFMk5nZjEyUiszdkQr?=
 =?utf-8?B?UExJUjgxQ2VnVXVRQmZxOThPaldydEZlVEJPSkJTNG9JSjg4Um1nNHUzbjA1?=
 =?utf-8?B?VVZvVCtRSW9vM1FZaXpXUjRRczFmR05LUU16WVNzNlJQNmV6L3dja3M5V1JI?=
 =?utf-8?B?WGo4ODlNSzF2OUpaUnUxKzlzVjlWZHlWM0p0ZWsyL2JydHZFd21JR1ZMY3RY?=
 =?utf-8?B?MTB2SGJhOWZKU2tLQU54UTB5VEdqd3RONDVHN3RmZUQxNU9HU0U5SGNXU3hV?=
 =?utf-8?B?T3BaWGcwVFo1c2FqeHB6aUk5a3VET29hc2xFWGNKS0NSVVJGTE44ZDN6NkpI?=
 =?utf-8?B?NzMrNXhrL0VvdDFzMUZNaHN6YTZTZUZaQkNSUXpiRExWOGUzRUVMSXpsemxa?=
 =?utf-8?B?NnNrU3JIc21LUTZnQUZCeGV2SDNsOFdHVFhUR1BkdWlOT0wrTkpydm53US9L?=
 =?utf-8?B?QXMvS0pTSmdLdGVuV1FLdHBZUWJ6TTFITDJSdWJhdC8ybVo4bGNWc25lT0cy?=
 =?utf-8?B?THVWWHFrWlgzQjVCTXRnbUdZNkMxWmdlOExmTzhyYUlYMmQ5WGxsbDAvRDE3?=
 =?utf-8?B?MzdkVnNaMTVtK0hEcFg4cStrT21iVzhQb2JIVFh5VFZ3c0xEU285QnAyTnJ6?=
 =?utf-8?B?byt5K2IyQm5uQ29KdjJsUWtqUG9HSjFIcjhoZVpleGxUTEtBZElMd0c0YXJN?=
 =?utf-8?B?b0EvKzBoSWtJNHZhc1JQRlJoU0NsRWtuUWYzaWFvZzZEYkpCMHN1RnJ1cVpm?=
 =?utf-8?B?UkdRY0Y1VmgzU1gxUy9UVnJSQ2M3VUNhaHlzM0xoN3FkZjZkUGNpMzJKcGUz?=
 =?utf-8?B?SFpYSG5hZUlWcVdXWmFsYlBNQnVpL1FpaE9zR1lBcEJJUjNuc0pnZjhYTyt4?=
 =?utf-8?B?UGNCemhaNXIyUjcvaW5jcWE4MThmZFdmQXRaMlg1eFRIekhrY0QxSHBmdUNL?=
 =?utf-8?B?MkZyVElmdWRIbHY1bXpsazZKNnJDWk5zLzJzUjhqWTlDQ2FxUDFHMC85MGlo?=
 =?utf-8?Q?D7zeOrs3g8z5scvM=3D?=
X-Exchange-RoutingPolicyChecked: xu8W+CE1Ibhx6grTAPOqXw9nKG5Y00/AG8n1J/wlBf0H8RHXLzHA0VryVHuIAEMan+QLg5q9sa/1Gwerdu4X8adq+z8KNEvTnzFn59K5MjlnhXlSJeWXpdFLi57ygXv/R/AbLY+I3FxVY8ED2Vjy/Qj3RbUXpaFZA4VnUxkrz9DO6e9/W8jCtMKZXsoVuMOke+R8r92NJCrqHi7xITZv1QIo9rbtPT9+boGwb5gFzI/ZP4WITWr2nmxrPuNWs5aBLqsVjv5EWKSrmT0hAUTO5Ao8akLpGtRGOMwlbu9t4Apxfl8H4CRMHnaZTisPwR2wTEyMZvDC0sQVTQb1u2CXig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f2e8ac-4cbe-48ba-dc5e-08df3a645f91
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:28.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qptvMtCPDQHqblPP3X/fsfFl1z2bcM1+bYK2HOkFH/fw6nWCh56uFgXW49kOvok6kH8as3zywm4rFByVvUhaH3Vj2vww6mOlxM/0kvgmbSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB016677
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with device and the tile it came from.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/gt/selftest_engine_heartbeat.c   |  7 +++---
 drivers/gpu/drm/i915/gt/selftest_llc.c        | 25 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
index b893a8fde895..1164dd4aea11 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
@@ -7,6 +7,7 @@
 
 #include "i915_drv.h"
 
+#include "intel_gt_print.h"
 #include "intel_gt_requests.h"
 #include "i915_selftest.h"
 #include "selftest_engine_heartbeat.h"
@@ -202,7 +203,7 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (!delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat not running\n",
+		gt_err(engine->gt, "%s: heartbeat not running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_pm;
@@ -215,14 +216,14 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
 	engine->serial++;
 	flush_delayed_work(&engine->heartbeat.work);
 	if (delayed_work_pending(&engine->heartbeat.work)) {
-		pr_err("%s: heartbeat still running\n",
+		gt_err(engine->gt, "%s: heartbeat still running\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
 	}
 
 	if (READ_ONCE(engine->heartbeat.systole)) {
-		pr_err("%s: heartbeat still allocated\n",
+		gt_err(engine->gt, "%s: heartbeat still allocated\n",
 		       engine->name);
 		err = -EINVAL;
 		goto err_beat;
diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
index 779fadcec7c4..71ea688be154 100644
--- a/drivers/gpu/drm/i915/gt/selftest_llc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
@@ -3,6 +3,7 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include "intel_gt_print.h"
 #include "selftest_llc.h"
 #include "intel_rps.h"
 
@@ -22,8 +23,8 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 	for (gpu_freq = consts.min_gpu_freq;
 	     gpu_freq <= consts.max_gpu_freq;
 	     gpu_freq++) {
+		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;
 		struct intel_rps *rps = &llc_to_gt(llc)->rps;
-
 		unsigned int ia_freq, ring_freq, found;
 		u32 val;
 
@@ -32,17 +33,21 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 		val = gpu_freq;
 		if (snb_pcode_read(llc_to_gt(llc)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 				   &val, NULL)) {
-			pr_err("Failed to read freq table[%d], range [%d, %d]\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq);
+			gt_err(llc_to_gt(llc),
+			       "Failed to read freq table[%d], range [%d, %d]\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq);
 			err = -ENXIO;
 			break;
 		}
 
 		found = (val >> 0) & 0xff;
 		if (found != ia_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected CPU freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ia_freq);
 			err = -EINVAL;
 			break;
@@ -50,9 +55,11 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
 
 		found = (val >> 8) & 0xff;
 		if (found != ring_freq) {
-			pr_err("Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
-			       gpu_freq, consts.min_gpu_freq, consts.max_gpu_freq,
-			       intel_gpu_freq(rps, gpu_freq * (GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1)),
+			gt_err(llc_to_gt(llc),
+			       "Min freq table(%d/[%d, %d]):%dMHz did not match expected ring freq, found %d, expected %d\n",
+			       gpu_freq, consts.min_gpu_freq,
+			       consts.max_gpu_freq,
+			       intel_gpu_freq(rps, gpu_freq * scaler),
 			       found, ring_freq);
 			err = -EINVAL;
 			break;
-- 
2.34.1

