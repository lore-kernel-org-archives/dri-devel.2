Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvWN84w2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Fwd2CS2g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C4010E92D;
	Thu, 26 Nov 2026 04:44:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF4D10E8AB;
 Thu, 26 Nov 2026 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795668236; x=1827204236;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/O1m3vJrb2DFJ12JHGf76GSpT+wn36ocOipKkRe22T4=;
 b=gvWN84w2xdEzyLXY0ZpeEOzufp4T4m84aLLecUX84Ia/LM3stPI8JPew
 yRiMtXEq7VqGVCujNn84/A20+waPOtPsxPtCD/Dmlid/8N4e/zkemW+Aq
 qRneIzievTPdXdJ+FeC3xa7xPVGFZU3upRk1VxBz153YhUE9mxOi0DCFr
 qjGHpjBqparg6bzHNfsv3W8P2z/tpTvqamwXxh+Ywm3A85hR81ONwoWJO
 Ih12GKZnDPph1jFKplMxBZLX2phiWrXCygSu24n2nHsxrZ+WD2kRVGVc/
 VeTOavewCLg2/hSpF0KHHGqVLT84KY/6Q9uiQQGiHMWTkIW73AhTjB18V A==;
X-CSE-ConnectionGUID: w5yFF+czQSOh422c3Be1dg==
X-CSE-MsgGUID: 4otZuoSeRsmwlDj4Hwaahg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4576971"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4576971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 20:43:56 -0800
X-CSE-ConnectionGUID: U00T+gJTRLexpWtyeg7nHA==
X-CSE-MsgGUID: QQSif3NZS3KKPbP10ooBRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12663244"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 20:43:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 20:43:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 20:43:54 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 20:43:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivMOrmAYBOlEbVZyZQz2LjPj3vC4uEm497qIME1H0vAnhTV+DD0MB4VxQdL7vRpD6AYbKRx3+vWfwrp6VPVr4H7cQDf4oJDLQfidesGYFeA+A17857F+4D5o8+z2rlnbIX7H0PSPZEIH4xnFNCh5NcOAl1jNujFGhMoFFlKQZ/CZR5seTZMOIy51CbnA63nmUR7YnROcwXKoHtLo70rENEeBcDstVYXoa6cUdZFDMLMYS3oJGdMHq8vW0sNCgbDPlxUY7keKGDMC4iM3Vx8Wj+COz2dH7+3tXmUsVQGYvhpmCUW/nxgqzMyyvFPnpsqPs2tIIPr7DhJY8dqIwCuk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61Q63q6mZRYBWc8JjFtRJPtQt2gLb7LKuWGLYuqWPus=;
 b=XLrcXqr95fqRyduqeI0DoZ31nbdlY9DMgnWp6DXQALwiwvOKW6KEpCK72nO2oLR3lqRiViP+bm1gDYOo5f8A9y314hMy4YN9GKGpTT8+9F1tnNPjGiXu6AITqGEYT+G1pS7C0zO+xcSGGBsEsxlMw8P4X/tD7XEfGOAWYCsIpTmS5GGusTX3bKBqMBSje59OXpTjmS8xsBBFp+sizCGQjhoOOdQX22M+/cdQZD3sJiiEzClYmCb0/ab7IVGOyE+G3lL8QgcmlUwTBRzK1UX1dJcCjcSTjNYLOsSQRsNuMyHKQX1ISt7OEKqlaYR0ksdVw2mVl8vFFaRvwa0JUya4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61Q63q6mZRYBWc8JjFtRJPtQt2gLb7LKuWGLYuqWPus=;
 b=Fwd2CS2g3oeqYEnti3tc0cU1iOtvAW3IzbUEoIFUOWXt82BWPhLjcMLctKWZhOibeuj4wKcLwBIWgsFKoRcAv/R4hWIOpRe1jakS8d1dEvavyyuLDp7VpRGOrwilQzqWfnmN0bEiOIpJ41Sq47IgKC89I4Y48JauCKUeN1kRp8M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 04:43:50 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 04:43:50 +0000
Message-ID: <ffb3e0b6-5e70-41e7-9000-b44d178507f9@intel.com>
Date: Thu, 26 Nov 2026 10:13:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/vm: Cancel pending rebind work before freeing the
 VM
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <tejas.upadhyay@intel.com>
References: <20261125100744.1440957-1-arvind.yadav@intel.com>
 <awcK/Q6SifMWJNR1@gsse-cloud1.jf.intel.com>
 <awcbPRYPCeNHsRGL@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <awcbPRYPCeNHsRGL@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::17) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH7PR11MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8ce00b-a7a7-4aca-79f9-08df4b77dd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021123027099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lg+nWoYS7ckEWFPEslkBD7ZxVmD9UQ4sKfmoQPw+UodripeHIWavwEvXSHtve+QGyySUXHQFYMvMLAtba/UWmTbcI5ZPxDnZtPhNm5OdLYUXVDeYPOuklGRzRaanYGvLPOb97v3+DCemwZR7t7IiKCF4gG+NNYxgXICo2AEMhYoYu3NHlkTiynSEHNbm3HjyF3tOUhHS51mQQZHF1HOY7chOQ8rq1Uol3EMsIVaSyVRpfDY7y5g/048gPSkGn+AtTznjoZDGK6wjzMIb3juKBCRGghyQhdxdKyrMEL942QzKXtLWx4gWnCVQx3AJi8BIq3lAI9xwCtgU8vipT9TdZ3cqaPJaBw/kr2/DkgILJs2b+2tGfJ7KkPPaJlaiyDEK43AuOXkbQggn6mJlIx9NuzexCgChxqU2PqcyWbpZUoRDXiSH3E8PEc5bZqDyOn/W43oVWy2HTX7uii2eZdLHzCnhNTS4B5vGWDEZVGP/djEXVC6/vz4USytcLsxV4cISFULi+ZZYo7cpi5LsyDzGVKfClnU3mN2L8I6s8tFeX1vmLhKRySMJwI83XqM9mKZDWc9SoKWkR+vIPvQUYwQoUOvKtWAUVnkx4hPv2GrmEi8Rw5n5LXsHqkziHD9F9YQ1njBVESRQUODQlW5WGcH7NGXeJ36Xguv+QTMR+c1iNWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnc4NTBjQms3Ym9KdzVDejdFZ0w3clE4RGpCWUtValpFNEVJaUpvdEhHbUNh?=
 =?utf-8?B?R2VUS0MxUzIyUCtOdU1BTzVYOHAvakRFZzFkYmRBUmc0ZDgvTmVNbTM2VlQv?=
 =?utf-8?B?ZVVjdFRuRXZUNHVPbkgySHFOalVYSFQ0ODNpaXpKWmFsdjV5ZHJOTWZ4VDFT?=
 =?utf-8?B?djcvZGRmNEJqeXhkVEE1Z01VYjl0OW9iM0NMdFIwTzBENW00R2JnNGNYVXly?=
 =?utf-8?B?RmZRMyswY0hvQ2xwaGsvRXhWc3BKdnc1Z0taM05hWWV0Skd6UVo5WFdxbCs5?=
 =?utf-8?B?U2ZKc1FQWFZRdSs2RklBWkQzNERVcnFxR21mMnl5aTdsQ2dFRlZBZi9mbjZq?=
 =?utf-8?B?Rm5wUzZPVm4yemVVL3dhWUlGRndUMjNiSXA0cU9lRTN1enhsVkxIYjNwVnBK?=
 =?utf-8?B?VHF3QVVrb2pSQy9EaWUvQjRaUTJZTjdIQjh6TjFGU0p0VXBsZVRlK2cxbHRT?=
 =?utf-8?B?VVNURWNUaFpTeks0UnJVSDlCK1ExdmRwYW1rT3hkdFl6Uk8zbldaR0JnT0cv?=
 =?utf-8?B?ZEpsRDd1bXVDSmJSemxaTHFyc3hyYnRRL2lweVM5UDZvY0Vxa0haS2JDU2Fn?=
 =?utf-8?B?dTRSWHA1VE5QZmVrTFN3UWEvZnpHMGo3WHN6S0NNV3NyU3pIQy9wMklRNFFr?=
 =?utf-8?B?cGQwNFB3WklKY1BXdnUxc2Q1R2FWM3pDbkhYUFhkYmlDUlNyNHUwSGJIRmFu?=
 =?utf-8?B?NWdNbHNKZnhaK203Nm9LZ0YzQVhXQ21KSTQ2elJWNkFId0hGaGNQQ05rajJy?=
 =?utf-8?B?SW5RLythMU9pVlBVSThKRy80NE9IbVI3ZlovTGd3ZlFpZDBEeXpva0JtUHZX?=
 =?utf-8?B?ZVl3c1ZjRWdrTXNCM0NyMDNOeGNNNUl3eGRubGxGbmhMVEtMWFllT0RWK2Fu?=
 =?utf-8?B?eDNOcFpxN2toeFQrNmJRMEJ6eENiQk9QellYRnArYWlIZ05DYU1pS3dSQXNo?=
 =?utf-8?B?TU9mSXVlM0d6TkNMVThEcW1JQUZxcm4rbmZGTkFpdkt6NlpnQ0U4WFRmWFh0?=
 =?utf-8?B?am5iWjBKNklYSTF0TVY4YkVzS1YxaHc2SUNEQVhqZzg0cEwzdDdiM1pPSS9B?=
 =?utf-8?B?aStPMGZjNGNlRytENmhWOGxjN2VvVUxPYkhldktNQytxakRIb1lnbVl1blFM?=
 =?utf-8?B?SjkweEVSa1pQZi95aDhEbUh2aXBTNnByRXJwcW1Xc1VDaVBHcWV4c0Y5MU9a?=
 =?utf-8?B?dGVhdkxFbnArSnZsd3NRME1MWUxyU3dDb0pnZ0FTU3UzWjJDV201U2tyMG5q?=
 =?utf-8?B?RFhWTlVtVnJzTmlEdnRWWDFoa1lhdk9BNlZxRjh1ZGNqUkp4UnV6RzhVZjJF?=
 =?utf-8?B?SWZxa0dWZzZLaFdvbjg5SFFnaHRubHFDa043bHFzTTNpaU52NVJHdERwWXVk?=
 =?utf-8?B?eUlYaDR5UDNJNG1ZdEVMRzMyM3lXMk91SXNHUXRMRURXZ1dMMDY3ZGZaOVpW?=
 =?utf-8?B?dWszUTVaMmZSUkliRkVESmJuOGt3OTRJVTc0NVRKT2tGWE5VYkwvRmh1K0l6?=
 =?utf-8?B?anNJQy9LR2pINS9OV0VaVlFjbE9waVNhWmNWc1RvQUxpT1hQYnd4a0x6NTBm?=
 =?utf-8?B?QWtMcFFQTTdIUWN0NmxGVGNLZFNWTnNHT1ZHUHZLbnE5UFRRN25SNTVyOENl?=
 =?utf-8?B?OTdZc0o1YlAvOE5FOHZ2LzhFSDB1RW0rd2hEWlJkamNIT0xxL1FwL1RVUWRR?=
 =?utf-8?B?VzZnNkF4Q1JTZ01iVWlSUTJ0aTc5djNjOXdmVWVOc1FkbHlSSjJXZ0ZmalFE?=
 =?utf-8?B?Szl2SVFPTGRGakU1bU5rY2dNOHFJSUI2TVRNZmYrR2lLeGVIN3U5NFBkemdK?=
 =?utf-8?B?b2cxT0xxVGx5ODIvZ2l0dE5UUFM5ckNQSlBjc05RRmhaakZBV25mRlJrNTFi?=
 =?utf-8?B?b0p2ZnFtblNYclNMQzhCU1BPSXEyYlhCdXZVdnZlS0tNYzZIZXRpZDlMTGd4?=
 =?utf-8?B?V2FvYmp5WEcvK3U1d3BsSHByM0dkajBuT1JtMWRFV1pheGYvRkVNTFZRNUJD?=
 =?utf-8?B?ZHJuRkZUaFc5NkprNmRLcldjcE5IczVzY1JnQVpsMHo0L0paQWFFQ2lHaEcx?=
 =?utf-8?B?Mmt3elB6aXdZcTVyalhrTWJSUVdlZDYwaU1jSWlVOFJYNHBVK1BCK2NrUVRV?=
 =?utf-8?B?TmYxZVc0NVJmaHYwNGRuUVRoMkpFdEdrajBWVEt2aWRlZGRuYU03WkdZY01v?=
 =?utf-8?B?bXdJWW5pU1QyOCtsYkRhaHR5NGYraEdXR0Z1UEE3YkJ3KzdGUGdoZXhlVW9T?=
 =?utf-8?B?OUVlalRXUjFLMHRPeVRWR1ByTmY4d0VOOWI5SEhGclFuc1NaWU5kNWYrMFR5?=
 =?utf-8?B?SSt5Tit3S0VxTE5jY2hOcUdXMy9nL09pS05hTEkrZ01QNGMrWEhhUT09?=
X-Exchange-RoutingPolicyChecked: M3n5hiQT2uRpZsHM6to2GWfCbhHFXqgyFFcdpksRs4kzQa6ld7vvmgtzgAMV5eu697t+KO1CTKQhfCjaJ7G1pvE+Jx3P5D5lv1Um/XYCExlBu0TRsTLQhKoYjCzYVHWYg8dfAS5qIthpEfJ8pxlvdcpcCYZjY50R+Pq8zWDWyUJjQzNArulHOZUHlU9iDh5j8n5FiK7FYX3zBvpL9q1Vwu8D7NfMGHGwxtahf/LrnJ4dl4WRN3V4RrykXa4+e+XIpueNXxSmgKy6ujfz8gqAHSadpn1VdmrObKNH6/5g3dqYANp5f3tXPSyYdqeKyusRI3fWM8bcJ8721O/QYuDJPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ce00b-a7a7-4aca-79f9-08df4b77dd93
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 04:43:50.5527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zzU2o7wS+5Ui/KBL1lOwVr+Psa/ay260K8VR8vNT6djUlqwgUO2MwEFtvSVtWhCXoqV835TLIkOBBFouBcMnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 25-11-2026 23:00, Matthew Brost wrote:
> On Wed, Nov 25, 2026 at 08:21:17AM -0800, Matthew Brost wrote:
>> On Wed, Nov 25, 2026 at 03:37:44PM +0530, Arvind Yadav wrote:
>>> vm_destroy_work_func() runs on xe->destroy_wq and flushes rebind work
>>> on xe->ordered_wq. The destroy queue has WQ_MEM_RECLAIM, but the
>>> ordered queue has no rescuer. The kernel warns because this wait can
>>> stall memory reclaim.
>>>
>>> The VM is already closed, so a pending rebind would return immediately.
>>> Use cancel_work_sync() to cancel pending work and wait for a running
>>> rebind to finish before freeing the VM.
>>>
>>> [  727.067318] ------------[ cut here ]------------
>>> [  727.067552] workqueue: WQ_MEM_RECLAIM xe-destroy-wq:vm_destroy_work_func [xe] is flushing !WQ_MEM_RECLAIM xe-ordered-wq:preempt_rebind_work_func [xe]
> I didn't read the stack trace, but this patch, or switching to
> disable_work_sync(), probably won't help.
> cancel_work_sync()/disable_work_sync() can still block if the rebind
> workqueue is running, and I think the same warning would still appear
> (though I'm not 100% sure)/
>
> Maybe the better question is why xe-destroy-wq is marked with
> WQ_MEM_RECLAIM. Sure, it frees memory, but it isn't in the DMA-fencing
> path, which I think is the actual hard requirement for marking a
> workqueue with WQ_MEM_RECLAIM. So perhaps we should just drop
> WQ_MEM_RECLAIM from xe-destroy-wq?
>
> Also, I think s/flush_work()/disable_work_sync()/ is technically still
> the right code change, but I wouldn't consider it a fix.

Thank you for pointing this.

Agreed on disable_work_sync(). You are right that it still waits if the 
rebind worker is already running. We need that wait before freeing the VM.

I checked the warning path in kernel/workqueue.c. disable_work_sync() 
calls __cancel_work_sync(work, WORK_CANCEL_DISABLE), and that helper 
passes true as from_cancel:
     if (wq_online)
         __flush_work(work, true);

check_flush_dependency() then returns before the WARN_ONCE() 
because  from_cancel  will be true if we call disable_work_sync() :
     if (from_cancel || target_wq->flags & WQ_MEM_RECLAIM)
         return;

The case this fixes is a pending rebind. flush_work() waits for 
xe->ordered_wq to start it, even though the worker will see the closed 
VM and return. disable_work_sync() cancels that pending rebind, so VM 
teardown can proceed.

I added WQ_MEM_RECLAIM in 9b7e60184f4b for the SVM pagemap shrinker. 
drm_pagemap_shrinker_scan() counts the pagemap as freed, but 
xe_pagemap_destroy_work() on xe->destroy_wq does the actual unmap and 
free. I would keep the flag for that path and switch the final flush in 
vm_destroy_work_func() to disable_work_sync() in v2.

Thanks,
Arvind



> Matt
>
>>> [  727.067726] WARNING: kernel/workqueue.c:4043 at check_flush_dependency.part.0+0xd9/0x110, CPU#1: kworker/1:0/33641
>>> [  727.067876] Workqueue: xe-destroy-wq vm_destroy_work_func [xe]
>>> [  727.067963] Call Trace:
>>> [  727.067964]  <TASK>
>>> [  727.067967]  __flush_work+0x44b/0x660
>>> [  727.067970]  ? __lock_acquire+0x584/0x29c0
>>> [  727.067974]  ? lock_is_held_type+0xa3/0x130
>>> [  727.067980]  flush_work+0x28/0x40
>>> [  727.067982]  vm_destroy_work_func+0x1a9/0x350 [xe]
>>> [  727.068061]  ? lock_release+0xd0/0x2c0
>>> [  727.068065]  process_one_work+0x2ad/0x890
>>> [  727.068071]  worker_thread+0x200/0x3f0
>>> [  727.068074]  ? __pfx_worker_thread+0x10/0x10
>>> [  727.068077]  kthread+0x113/0x150
>>> [  727.068079]  ? __pfx_kthread+0x10/0x10
>>> [  727.068081]  ret_from_fork+0x3bf/0x470
>>> [  727.068085]  ? __pfx_kthread+0x10/0x10
>>> [  727.068087]  ret_from_fork_asm+0x1a/0x30
>>> [  727.068096]  </TASK>
>>> [  727.068108] ---[ end trace 0000000000000000 ]---
>>>
>>> Fixes: 61e18525023a ("drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq")
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_vm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>>> index dd855876f571..2ba99c083db8 100644
>>> --- a/drivers/gpu/drm/xe/xe_vm.c
>>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>>> @@ -2091,7 +2091,7 @@ static void vm_destroy_work_func(struct work_struct *w)
>>>   	xe_assert(xe, !vm->size);
>>>   
>>>   	if (xe_vm_in_preempt_fence_mode(vm))
>>> -		flush_work(&vm->preempt.rebind_work);
>>> +		cancel_work_sync(&vm->preempt.rebind_work);
>> disable_work_sync ?
>>
>> Matt
>>
>>>   
>>>   	mutex_destroy(&vm->snap_mutex);
>>>   
>>> -- 
>>> 2.43.0
>>>
