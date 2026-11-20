Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68F606A6C9
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eB9Tiwvo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OaMRh0iw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D98810E10B;
	Fri, 20 Nov 2026 20:37:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025D110E10B;
 Fri, 20 Nov 2026 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795207053; x=1826743053;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2VjzttfJdCajz7DlPEAnHvy2aeRmgnsAYFfNVtG+c30=;
 b=eB9Tiwvo0bawKeW4CvLhM+nhvOHVR7HJx5W+MhORltfgqc0zuSi5iNcF
 3ZRBM7khOyo/WgbnakVPe8T8rJCg4Qyl7p8BODzMkEIMuhpPxl0cAE6gq
 IXFN1MvGwLDfkYJej9R3Vf8xv+zBi9tADdDcvBZUAAQ3UbKfaPEIL2Rmg
 SqpaVz3I3P/o75f+7Smlmc2Dym9s8JK7r4L2JSWgZMIzT8sK4ZupO6MbF
 vcmNkTebc6a0lz3CWiFDB0jwa1jS/tdSiVgbUXgHYbi6oiGKDfticmGI6
 X/udNG0kGa1ZfYGesk00LbByXs5MEd+Nm/l+/St+iK/tnajS0p7sogtsw A==;
X-CSE-ConnectionGUID: JqPHUMXASC+xrdT7trH3dA==
X-CSE-MsgGUID: miWfjLn/Tt6doyq8B0w+8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4194406"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4194406"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 12:37:33 -0800
X-CSE-ConnectionGUID: CW3jM9IbQ+izHIKUAFTuhw==
X-CSE-MsgGUID: hRC77TcnRqW1mLOUjq8DeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11130099"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 12:37:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 12:37:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 12:37:31 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 12:37:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeSZrP92gQwY5eWIbsbHrWrEqsce0IikrbfS0ez+fAlNEO5EraTde5pWN4obqA88CLV6D4WWrRSXGnabxkIaEdHZqgHlNHyFoSkNSwsgqHgB0iKS/3u295/um2c5SPV6obeD7gxseIG0JdR8t1EIVxAkk2HJcW0UMddkMcNlMumySYwsrsSJj+aj9DqG4v53UqNUvrPmBz+P+s8M+qo5gDeJvFBDyaZ41p7CkF8zxGEW8+L7Irg4N3b1/VzMeZ0441IZNUyyNFAg8lg300l9lM9StTFHmRLwOscsERJjvW1M+T5teNqXm7GBPg7XVyGGdxF/Lsp0kGqSG1m6jNqQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7GVqOU853JeDajKCvaJDCgIn+VOKxxEW9O9JHBAbT4=;
 b=b47RtgF7rNvwyWtk5nZJkZJoAQo2T+waOiU0/afaExjFN5nMJ7JeUFNj6DxZeJUiGbEk3UMCVyarKCmnFyoVL9IL9ttyBI0O8KaEyAbmTnsqfP9ZQ3yXB+Oz/B+jpRGCFlT34cZCvptmQ2U+ihUE77WmU4M+TqAvTRBRBSbTwRPCrz2psVfktb9E1NRH5+bWpxZhk2xVLYD7D6q7HLdkGcRosJMTrmkX4cs3MsIDDXSiDHhqK2RfxipezjgmpJsip5ZbaC/FUgyaah9PuF3KHa31F8gDzj0KbSAqfFE7ClR4gfjwuJ/1dyKS1Ma7hPTXIYG363mikYQXL+R3PT6f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7GVqOU853JeDajKCvaJDCgIn+VOKxxEW9O9JHBAbT4=;
 b=OaMRh0iwvNP//Y6GdvFXr59MTj4dZojiZr87T8HC4Pg95amuz6uxekf2JH3vBMa908+DcYkksVVvIU2Zy7jMU41L1Zl+2VcZHx/kYS52mv/xOtVQRTaVcUrRannpbhDSuV1OxbGMO0XKOfVCihtyJC40xYEp10WIuXrpirlvesM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SJ5PPF3F833FA49.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::823) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 20:37:23 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 20:37:23 +0000
Date: Fri, 20 Nov 2026 12:37:20 -0800
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
Subject: Re: [PATCH v3 08/33] drm/ttm: Bound page (re)allocation per
 defragmentation move
Message-ID: <awCvgBh6-2-tinXR@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-9-matthew.brost@intel.com>
 <avKE9ruZsQwbsQEa@nvishwa1-desk>
 <av+s/38v9gtCDhhr@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av+s/38v9gtCDhhr@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::11) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SJ5PPF3F833FA49:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dd76d8-f6ad-4029-f85b-08df474614c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|261021123027099003|261022075727099003|261102130727099003|10067099003|261021121427099003|4143699003|56012099006|11063799006|261102123227099003|261026121527099003|261022113327099003|261026140227099003|261028144727099003|261022105027099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QobrgJUJ63PfLv40191gTM4xWOzeO4XzrPsO6uKE5MmDCyCSRLPyfBYLriGwGxghCd6WZkKxK7I+Na6SoyeFWbJTcUHlkDRF3keAnE5Mt73h+b0o1z7mjQa2c2THq80k110Njj5TFPSu5vJjqPpp1QTJEwy+OJzhqBgx8vT+l9N39guj+u9tJT84HJh4KaiDkZc711eMywMp4fV3ND779QsQ2dXTLXJieeN291yWCF0AeASwttA5/5m0PO3odHG2B8Hq/Kz1csCNXza02Kz5MAQ1Ubr6ADOfxIZLJlENvbbVxgaiPHospxCs7Pn5MGNlLUzBVAgpEQ09y97yYN5ZQLxvGCxYU85OdpZMqhABP0srv8/8dV24eVSRuwROa+wnhujl8wWmRIRB4PEdajMWwk+FKqZnVbcr4lpLiwiTZ1RCEpuUX+sq9MXC6Xzc0gZ42V/tUnibn3Iov74vDoYKUtZidH1klNTzTfUmXy7wwXlcCRzyd8z4+/pxLOibH/WgBAiibc3L02YsiIT5TxK1TfwIFFwJIlpbM7KiY52QPjJfrM6u62JGmEvzMYfZmW2ODgPszyi7DDT/bXXkjDukZtHoWg0GXlEAS7QAwtZG0t5ERFZymGOXHi6ctIx1jc+X+vw+W241DT+Rbkk30swPAx/e2uti0t3d/9tQJrW2hhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261021123027099003)(261022075727099003)(261102130727099003)(10067099003)(261021121427099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261022113327099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gYUkGpPUgYxLi4DKuQU+UbDd7H8ttmZAMI5xPUdugmf+p3CML44WHfI1Kb?=
 =?iso-8859-1?Q?+QAWoqjG5QV2GcXJFoh0bPXJdPEKaZe2FLDso2CqjQkL1Zxe7reTtZOJzJ?=
 =?iso-8859-1?Q?q8XqGDrxqPYauZ7hYACCpDLXZwwgXji7X/KecuDhToxJafN0Qr4yutKox/?=
 =?iso-8859-1?Q?wmdxZWkXCxclog1CWgQHETqdEAxaN9hPL7KfFXS0nCmMFngYeqiktCw35F?=
 =?iso-8859-1?Q?gJ+A8oIxg7vhbK7nTvscwMgESscDYYCPzBJfviLq8jXLoq0FS+5lQPTKP0?=
 =?iso-8859-1?Q?xoPpUZ7QTMYVA18BqZK1ucFG67ar6x4GyWU3wEuLm9aoLwAp0dEOof2R0l?=
 =?iso-8859-1?Q?gZEb1Pv40UDFyFHwRBzMPb7yirIcCZk6i3WXP5WzSSFZeX6AsSKPXRWe95?=
 =?iso-8859-1?Q?guNxdQVd6NoZrkmmOa7MzqZ8fO41F6xBiRKaLLlUTngpNHLP2pmwI9RvAE?=
 =?iso-8859-1?Q?EnBLVN9x0pq4Q5X4jZ80ZHtrTNI/4Oc7h07UPFug2ynYsvWBLDynLWZcNG?=
 =?iso-8859-1?Q?0TEW/mX4/wmMJ9vdPZU7x09BBqna4VHKxNtYat9kZZoHXngVxucH3QBBJs?=
 =?iso-8859-1?Q?jacJGA94BHW3eo/s+OZT4VAfiLx5HFsCvRB5ZWUWBStTyp4XrB1RoliMK5?=
 =?iso-8859-1?Q?CB2iY27+sUQT+EwSmO6Nax5+rWwrKDI4rH93b47SjFaXzUBr0MZd8Jexdc?=
 =?iso-8859-1?Q?6q+Zjs6QP2RBRwv2HVRR6KF2tQjAT6+y8dunAH20bkfFiqYR3cYioEOJSH?=
 =?iso-8859-1?Q?+rs/XSvDTPrpMM6pCz9xbf5kIL0MbawvIsnxlpLQ6oTVS9ItZTnsliHktw?=
 =?iso-8859-1?Q?TM0mJ2YcYpS8QR9X3g48GYJ4UsG3xA9HeW2yceqygaEnCrieF5ye5TsW1u?=
 =?iso-8859-1?Q?EtLktS//oCSI4aFs8o+4TRfcD8nDusPG+k7JJKwF1JpM/+3vijxgcj6r9d?=
 =?iso-8859-1?Q?UuG91A2Ln+07HAZuDi2BEmSmLCDC+o3Hzpiwj0i+KvpUs1i1tt7FW8Njup?=
 =?iso-8859-1?Q?v7lo9kELB/yI0fBSgoEuA6YuvxfM/rM1p8uD6SlGhYsgQX5N6dQ3bFfgqI?=
 =?iso-8859-1?Q?qzONtRlEv6aTFjZkWiyJKMNuy+15H67+pN7z205rYtB5Wuvjya/BYXMfxh?=
 =?iso-8859-1?Q?y4RnAJyOnLGzIhA+5N2uS/piBoG+PrzZoys5sazfZk0rjGqcWGZyZLTvbW?=
 =?iso-8859-1?Q?vlylRFlci5ePPQqf7PCs5H9FKJ8lK8eBmYUZbdBDwuhUnBvBjkzQKubaOd?=
 =?iso-8859-1?Q?fkfdoMbXqB9Qvwd0GxeAbvKTLeJWDyexh/2K6Ove54ZegFayE0nVFJOqq3?=
 =?iso-8859-1?Q?UCp2+DfAdJjtouIGPY0If0aGFghUnwywyBRETvwvrE7O8mSddE4ZzzHV6O?=
 =?iso-8859-1?Q?JLWKXjKg9AtI07Z9rVERCmwGPfqOhCeGhX/cvnjT/xYK/pjkg9DEJK+4US?=
 =?iso-8859-1?Q?yiI8Plj0RpXPph/3rbM1A+lBgA2cVZ7yRV0+jDq1rgLRV5vWQ6LDmyv3ij?=
 =?iso-8859-1?Q?oe4mDD6MTjjfAJvn7Hm678/ob15ERs0qUt0/bKQl5bBUf99ZAzkfLZRak9?=
 =?iso-8859-1?Q?t1OZCHw5BJybnn3JUbBBZfpr/TNSSRPPV4Ylh8RYfF3tJCT6+pc+FL2QhS?=
 =?iso-8859-1?Q?51QvdFbxmTiQsXZs3CnwV2TklF7WjP1v+7RJrO1wN54FfOQiMY6i70oqiu?=
 =?iso-8859-1?Q?ua05TFR6LivEjmFtGB46BgCQLeKq6ETzPNo8bBxlNFk9GLSMNI5dxZEGIC?=
 =?iso-8859-1?Q?Onqg5+mEOB70Tb9QvE91/Q5/XprpyH3VJkvnvoQD6qFSnS+x6bS5raitlf?=
 =?iso-8859-1?Q?eu8zeWzshYpaZOCXP58PALxEU1vopNSfIF5az4uZsORhEtxO5z4Q?=
X-Exchange-RoutingPolicyChecked: vL1IzE7j/IpOwqZEcspeAFTUuZb0o4n4EvBKJ57HDq5mFlNgSdm5JNevKruf14V2Gh5VI78kQcRAPNIuw44FBvLuxjQ0ymmL01L6QZoMEI59AvkGmU+AOdJ3x4jPke7xNdU/5460f81Grl11F+KRrpyjWjtfIw08WI/2gsqsbvDNgrkixKFCdT3Yq1yziVua9PD+YzD0Q2qClTVWSnbSsJbnzgTRojwpcRI8IIm73LMuSAcihJjhkioFvEBxPkFUQILn9OQJyoKxLkLSlLbtfAqVtn9HNq9DZ7i3/EW+zUN1kf7ayWa7qa98xZ/uW0qD0wFK9tQfMUDH9IMs92S8Fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dd76d8-f6ad-4029-f85b-08df474614c9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:37:23.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bzt3yz+v9y2FVarkFI45UFhxFv1Bm05nX/SuEO5OxR8D/h+leUK0brwPny0QnIhhtF6V015+q3Hjhf5f0xvl9ZQih8VBKGR++xOO+9PGwEpgQKrXXU/v4zEhYXYwos1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3F833FA49
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

On Thu, Nov 19, 2026 at 06:14:23PM -0800, Matthew Brost wrote:
>On Mon, Nov 09, 2026 at 06:44:06PM -0800, Niranjana Vishwanathapura wrote:
>> On Fri, Jul 10, 2026 at 07:55:54PM -0700, Matthew Brost wrote:
>> > A defragmentation move reallocates an object's backing at the device's
>> > beneficial order and harvests whatever the allocator cannot upgrade from
>> > the old tt. For a very large object this can reallocate (and have the
>> > driver re-copy) the entire backing in one move, which is expensive and
>> > can stall concurrent work for an unbounded stretch.
>>
>> Assisted-by: LLM
>>
>> NIT...So, a time budge would also be helpful here along with the size
>> budge?
>
>That could be option but a size budget seems like reasonable place to start.

ok

>
>>
>> >
>> > Add an optional per-move byte budget so a large object can be upgraded in
>> > slices across successive moves. Plumb a new
>> > ttm_operation_ctx::defrag_bytes_remaining through to the pool allocator:
>> > only pages actually (re)allocated at the beneficial order are charged
>> > against it; pages harvested (borrowed) from defrag_old_tt are free and do
>> > not count. Once the budget is exhausted the allocator stops upgrading and
>> > completes the new tt by harvesting the remainder of the old tt as-is,
>> > marking the tt sub-optimal (TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED) so the
>> > driver re-queues it and a later move resumes the upgrade. The slices
>> > already upgraded come back as free already-beneficial harvests on the
>> > next pass, so each move spends budget only on new forward progress.
>> >
>> > The allocator decrements the budget as it allocates and writes the unused
>> > remainder back on success, letting the caller compute how many bytes were
>> > actually spent. A value of 0 means unlimited (upgrade the whole object in
>> > one move), preserving the previous behaviour. This is only consulted on a
>> > defragmentation move, i.e. when defrag_old_tt is set.
>> >
>> > Cc: Carlos Santa <carlos.santa@intel.com>
>> > Cc: Ryan Neph <ryanneph@google.com>
>> > Cc: Christian Koenig <christian.koenig@amd.com>
>> > Cc: Huang Rui <ray.huang@amd.com>
>> > Cc: Matthew Auld <matthew.auld@intel.com>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: Maxime Ripard <mripard@kernel.org>
>> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > Cc: David Airlie <airlied@gmail.com>
>> > Cc: Simona Vetter <simona@ffwll.ch>
>> > Cc: dri-devel@lists.freedesktop.org
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> > Assisted-by: GitHub_Copilot:claude-opus-4.8
>> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> > ---
>> > drivers/gpu/drm/ttm/ttm_pool.c | 101 ++++++++++++++++++++++++++++++++-
>> > include/drm/ttm/ttm_bo.h       |  14 +++++
>> > 2 files changed, 112 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>> > index 52f5e64f05dd..1673e81b8df8 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> > @@ -77,6 +77,11 @@ struct ttm_pool_dma {
>> >  * @dma_addr: Pointer to the next tt dma_address entry to populate if any.
>> >  * @remaining_pages: Remaining pages to populate.
>> >  * @tt_caching: The requested cpu-caching for the pages allocated.
>> > + * @defrag_bytes_remaining: Byte budget for newly (re)allocated pages on a
>> > + * defragmentation move, seeded from ttm_operation_ctx::defrag_bytes_remaining.
>> > + * Pages harvested (borrowed) from the old tt are free and do not count; once
>> > + * this drops to zero the allocator stops upgrading and harvests the remainder.
>> > + * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
>> >  */
>> > struct ttm_pool_alloc_state {
>> > 	struct page **pages;
>> > @@ -84,6 +89,7 @@ struct ttm_pool_alloc_state {
>> > 	dma_addr_t *dma_addr;
>> > 	pgoff_t remaining_pages;
>> > 	enum ttm_caching tt_caching;
>> > +	s64 defrag_bytes_remaining;
>> > };
>> >
>> > /**
>> > @@ -780,6 +786,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
>> > 	alloc->dma_addr = tt->dma_address;
>> > 	alloc->remaining_pages = tt->num_pages;
>> > 	alloc->tt_caching = tt->caching;
>> > +	alloc->defrag_bytes_remaining = 0;
>> > }
>> >
>> > /*
>> > @@ -885,8 +892,12 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
>> >
>> > static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
>> > 				      struct ttm_tt *old_tt, pgoff_t off,
>> > -				      struct ttm_pool_alloc_state *alloc)
>> > +				      struct ttm_pool_alloc_state *alloc,
>> > +				      bool *suboptimal)
>> > {
>> > +	unsigned int beneficial = ttm_pool_beneficial_order(pool);
>> > +	pgoff_t bnr = 1UL << beneficial;
>> > +
>> > 	/*
>> > 	 * @off is always an old-tt chunk head here, never a tail page, so
>> > 	 * reading the per-chunk order below is safe. This holds because:
>> > @@ -906,8 +917,23 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
>> > 		struct page *p = old_tt->pages[off];
>> > 		unsigned int order = ttm_pool_page_order(pool, p);
>> > 		pgoff_t nr = 1UL << order;
>> > +		pgoff_t num_pages = off + alloc->remaining_pages;
>>
>> num_pages seems loop invariant. May be move it out of the loop as total_pages
>> or something?
>>
>
>No, both 'off' and 'alloc->remaining_pages' change each iteration of the loop.
>

Yes, but the sum 'off + alloc->remaining_pages' is always equals to
it->tt->num_pages, as we do +nr to offset and -nr to alloc->remaining_pages.

>> > 		int r;
>> >
>> > +		/*
>> > +		 * Only report a sub-optimal backing when a chunk we cannot
>> > +		 * upgrade (out of budget/prealloc) sits in a beneficial-order
>> > +		 * aligned region that fully fits in the tt: that region could
>> > +		 * have been upgraded with more budget. A chunk below the
>> > +		 * beneficial order is expected for the unaligned tail (the last
>> > +		 * partial beneficial-order region) and for already beneficial-
>> > +		 * order harvests - neither leaves real defrag work, so they must
>> > +		 * not flag the tt for re-queue.
>> > +		 */
>> > +		if (beneficial && order < beneficial &&
>> > +		    round_down(off, bnr) + bnr <= num_pages)
>> > +			*suboptimal = true;
>> > +
>> > 		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
>> > 		if (r)
>> > 			return r;
>
>e.g., below here (unseen) 'off' is incremented by 'nr'.

yes, but alloc->remaining_pages is decremented by 'nr'.

>
>> > @@ -951,6 +977,7 @@ struct ttm_pool_alloc_iter {
>> > 	struct ttm_tt *defrag_old_tt;
>> > 	unsigned int beneficial_order;
>> > 	gfp_t gfp_flags;
>> > +	bool defrag_capped;
>> >
>> > 	/* Mutated as the loop walks the orders. */
>> > 	unsigned int order;
>> > @@ -962,6 +989,44 @@ struct ttm_pool_alloc_iter {
>> > 	struct page *p;
>> > };
>> >
>> > +/*
>> > + * Defrag move budget exhausted: the upgrade can make no further progress this
>> > + * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
>> > + * entry.
>> > + */
>> > +static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
>> > +{
>> > +	if (!it->defrag_old_tt)
>> > +		return false;
>> > +
>> > +	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
>> > +}
>> > +
>> > +/*
>> > + * Complete the new tt by harvesting the rest of the old tt as-is (borrowing its
>> > + * pages, including any still below beneficial order). Never fall back to in-lock
>> > + * reclaim for the shortfall - that would reintroduce the stall we preallocated
>> > + * to avoid. Only re-queue (flag) the tt when the harvested remainder is
>> > + * genuinely sub-optimal; if every remaining old chunk was already at beneficial
>> > + * order the move fully upgraded the object.
>> > + */
>> > +static int ttm_pool_iter_harvest_rest(struct ttm_pool_alloc_iter *it)
>> > +{
>> > +	pgoff_t off = it->tt->num_pages - it->alloc->remaining_pages;
>> > +	bool suboptimal = false;
>> > +	int r;
>> > +
>> > +	r = ttm_pool_harvest_remaining(it->pool, it->defrag_old_tt, off,
>> > +				       it->alloc, &suboptimal);
>> > +	if (r)
>> > +		return r;
>> > +
>> > +	if (suboptimal)
>> > +		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > /*
>> >  * Defrag move: reuse an already beneficial-order chunk from the old tt at this
>> >  * offset rather than reallocating it. Harvest whatever order the old chunk has
>> > @@ -1062,11 +1127,12 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
>> > 		if (it->alloc_count && it->defrag_old_tt) {
>> > 			pgoff_t off = it->tt->num_pages -
>> > 				      it->alloc->remaining_pages;
>> > +			bool suboptimal = false;
>> > 			int r;
>> >
>> > 			r = ttm_pool_harvest_remaining(it->pool,
>> > 						       it->defrag_old_tt, off,
>> > -						       it->alloc);
>> > +						       it->alloc, &suboptimal);
>>
>> As suboptimal is not required here, probably send a NULL here and have
>> ttm_pool_harvest_remaining handle that NULL.
>>
>
>That is better will change.
>
>> > 			if (r)
>> > 				return r;
>> >
>> > @@ -1121,10 +1187,23 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>> > 		gfp_flags |= GFP_HIGHUSER;
>> >
>> > 	it.gfp_flags = gfp_flags;
>> > +	it.defrag_capped = it.defrag_old_tt && alloc->defrag_bytes_remaining > 0;
>> >
>> > 	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
>> > 	     alloc->remaining_pages;
>> > 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
>> > +		/*
>> > +		 * Out of defrag budget: harvest the rest of the old tt as-is and
>> > +		 * stop (the tt is re-queued if the remainder is still
>> > +		 * sub-optimal).
>> > +		 */
>> > +		if (ttm_pool_iter_defrag_exhausted(&it)) {
>> > +			r = ttm_pool_iter_harvest_rest(&it);
>> > +			if (r)
>> > +				goto error_free_all;
>> > +			break;
>> > +		}
>> > +
>> > 		/* Reuse an already beneficial-order chunk from the old tt. */
>> > 		r = ttm_pool_iter_reuse_old(&it);
>> > 		if (r < 0)
>> > @@ -1155,6 +1234,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>> > 				goto error_free_all;
>> > 		}
>> >
>> > +		/*
>> > +		 * Charge a newly (re)allocated chunk against the defrag move
>> > +		 * budget. Harvested chunks borrow the old tt's pages for free
>> > +		 * and never reach here.
>> > +		 */
>> > +		if (it.defrag_capped)
>> > +			alloc->defrag_bytes_remaining -=
>> > +				(s64)(1UL << it.order) << PAGE_SHIFT;
>> > +
>> > 		it.alloc_count++;
>> > 	}
>> >
>> > @@ -1204,14 +1292,21 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>> > 		   struct ttm_operation_ctx *ctx)
>> > {
>> > 	struct ttm_pool_alloc_state alloc;
>> > +	int ret;
>> >
>> > 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
>> > 		return -EINVAL;
>> >
>> > 	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>> > 	ttm_pool_alloc_state_init(tt, &alloc);
>> > +	alloc.defrag_bytes_remaining = ctx->defrag_bytes_remaining;
>> > +
>> > +	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
>> > +
>> > +	/* Report the unused defrag budget back to the caller. */
>> > +	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
>> >
>> > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
>> > +	return ret;
>> > }
>> > EXPORT_SYMBOL(ttm_pool_alloc);
>> >
>> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>> > index fcaba5fb8bf7..6124d2627b47 100644
>> > --- a/include/drm/ttm/ttm_bo.h
>> > +++ b/include/drm/ttm/ttm_bo.h
>> > @@ -223,6 +223,20 @@ struct ttm_operation_ctx {
>> > 	 * NULL for non-defrag operations.
>> > 	 */
>> > 	struct ttm_tt *defrag_old_tt;
>> > +	/**
>> > +	 * @defrag_bytes_remaining: Byte budget for newly allocated pages during
>> > +	 * a defragmentation move. Only pages that are actually (re)allocated at
>> > +	 * the beneficial order count against it; pages harvested (borrowed) from
>> > +	 * @defrag_old_tt are free and do not. When the budget is exhausted the
>> > +	 * pool allocator stops upgrading and completes the new tt by harvesting
>> > +	 * the remainder of @defrag_old_tt, marking the tt sub-optimal so the
>> > +	 * driver can resume on a later pass. The allocator decrements this as it
>> > +	 * allocates, so on return it holds the unused budget (which the caller
>> > +	 * can use to compute how many bytes were spent). A value of 0 means
>> > +	 * unlimited (upgrade the whole object). Only consulted when
>> > +	 * @defrag_old_tt is set.
>> > +	 */
>> > +	s64 defrag_bytes_remaining;
>>
>> If user specifies -ve value, currently it means unlimited. So, may be update the
>> documentation here to say "A value of <= 0 means unlimited"? Or, better only accept
>> > =0 value from the user ctx here.
>
>How about I reject user input defrag_bytes_remaining < 0?
>

Ok, sounds good.

Niranjana

>Matt
>
>>
>> Niranjana
>>
>> > 	/**
>> > 	 * @resv: Reservation object to be used together with
>> > 	 * @allow_res_evict.
>> > --
>> > 2.34.1
>> >
