Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A15606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W5Y1HARq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E94F10FCB0;
	Wed, 28 Oct 2026 13:59:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C300010FCA1;
 Wed, 28 Oct 2026 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793195965; x=1824731965;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=htuMeE5DCAbWkPg2/rYqjXw7wSerDZKECJscsuHWC74=;
 b=W5Y1HARqiiRN2HMaBIPRFAFLvOPlXqp7atOx3dA7lsk0mWigsyH3k3cz
 wx6PKOZSXLxO+wNGF3TwsU3hWUftUdk4xcmsxqqNCKTEkzuDRDRwHBi1B
 bF9+ySQZnL003HAfBl0r1o8IF5sEX1DOeMQfMgt2fT8mG1a3lV8lOx08u
 A+aEABvtsjwL5Hwd+CQwwrMk0dFHkTwDIeQodGkV8jFjEqffUETbdDIaZ
 VzVuMSMr6U0hktlM6jPl7hc9KS4AXJdi+b5FALDCmUA2conzCSjq70OD0
 TqZ0+RRvv3FQ2eoWQU1TR2F9zoWuR/6UhkPD4+NzMavXVXJLMKFGPs6vP A==;
X-CSE-ConnectionGUID: nc90LEdGQPes2nEvH9e1qA==
X-CSE-MsgGUID: xYgCumKgTlOp6E4vuTwqEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1930214"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1930214"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 06:59:25 -0700
X-CSE-ConnectionGUID: d+ktACe1Q0mz/Fd8OIqBdg==
X-CSE-MsgGUID: x6IT/KW0TWimjwZHd+0Z/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6667921"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 06:59:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 06:59:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 06:59:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 06:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTUGD1QNZkOw5cMVQ4utF4tp5XJtCVpXxo2VQCIDKLm2ModwLTelnQ9soxrCoekinSHB27m98uk9Hpgz7eBS/eIVRVHqc6tRF5cqUkQJf+hCOuhqEfDgij+HRtLMowx4oXAyVvQt1kmm0v6zXxrrzvrn2A/Ng/sGkk83w1xZjVwJBcM0ilbx6dBwYq7kEdIYSNg3OVjirDtvreZtYF7DFDwGgSbkb9tmyWvZ/7bFZ58n+aaMMzLBf5CpHuljyWf9T759z/B6mZ1+KwdAcFT4VCJCE9jfil/YZpR86DXRTMS7N9vZWbj8krLVbeD3xxzHeYhAWOmTmnTJYYcaMciVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SauZ8Cn2vanJYAcyPXF9w5KdV2Eybx1adfwbndpsYdg=;
 b=NNEGJpEVZW7uKOPJXeTNLIRd3msXs+4uUVl6Ooggmuwj8/21XHZYo+EoxhAlIHe01XbVN3CwpFtFDiKaG7Al6shLoRj3BfdyOEv9QWUc9XdzlqC9piJ9oWH4ekRHZwgF9yQxWHX9cAzVV5aTdwG2b6JMR/kOv4UmYVj4BcABH7Aoy2e+3fIv7DEBUcPMpYaMgDT2Ne0VyEPU3oyHMa1cEykZItWFFOkzu5TOc9wcqyH7Aqym/i/hQU2h1TWeDYVe5Mp3ot/lx9fV/znSJaeF1a/HTPhv3mz8A+Jqyj7fK3IGlhlFFOE2jEdgDX0bX0ENuWZHIxn49MCgkKYmO6k2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:59:20 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:59:20 +0000
Message-ID: <02d4cf21-d068-4a12-ac74-5ea32ab6f57e@intel.com>
Date: Wed, 28 Oct 2026 19:29:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/xe: Hold a device reference across deferred VM
 destruction
To: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <rodrigo.vivi@intel.com>, <matthew.brost@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
 <20261028122125.3772832-2-arvind.yadav@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <20261028122125.3772832-2-arvind.yadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|MW3PR11MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: eebe4740-1cd8-4632-89e7-08df34fba9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZM2VfQcJJibV7ENVm0agVYoQD4ACAnE2bH9dSkUvHK2L0z/mFqFtzccBNsMB9h2R6tVL0VG4uHkXSedenX7Cfy1G+o6PSQ9J40XYJZgxDKUCDaq7/ze6N7Jae4uo5ogJay8IzWABPyQfMUOWIBe/53Dsc9RWnqkYyKs7Q9h4/deHtu+62OUUUZRocRGIgwuuH9tkwYqr1fimWiYCzoqlG6i0bugCN3hiSnaBZMCD5WynWCENvHR0GcS0fovDQb/0bYf7y0ZwNcbQYODv695leFmcS5SdYKbKssSsAOxtyjsKWyMsiJWMc4zZMk2Y1qS5kCE+dobQEHDoHrX1kAIX7f+B6c459YdRY93DBirXeplnj2IMU2MevIGFRQVqh5brT93LLDNiQsB8S2qA4aqocAR4vIsn6pb0F7JJADxVfEDMgKybaxAJR+nxFsAWecO10lQtIxDDx3Jm4PRfwFGW3HOvFrVC2sdmJBKKfaYR9uCtWz5T+Fwg+RopCv7b3kQggiFbmuxaF7rtXAjIFpfB49aGfgHejKJSVtaI9bIKn2JOzMm4YAa3FHVuLM5zyjupkM90w7L7JCTn6WpKAdBWPmkg7jvfDgCP2HLPwoDlfCoqAqDgQwYBnn/2YW4yzTYiAymrXLZiG8U93fSdz48AM5mLDoH9lO+ufuxA/Gqa2uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTI2Rnd3YXlOcjJiai9vcXVJOGlWUUt3QjVnQUVDSkhaZHE5eWEvUnRWbUpz?=
 =?utf-8?B?MHNRZTVra0ZCMDRqQU1GNVN6aGZ5NWs1K09pTFd0MjBKRDdNcXNKOTNxamFM?=
 =?utf-8?B?SjhmcithNVQ0RW5WYnp1YVU1NnFEL2pjVG5XdUNEa3U5eVJRREoydndRRHpF?=
 =?utf-8?B?RnhQRXlvalRJbjZSc2tOVHlmOGpPRk5KdXJXT1lJUGw5QndNdTVCbTJFSFpr?=
 =?utf-8?B?eGV3NS81bXp5VWpqbFNPRCtUL0YvWElwWUpleUJiZDdhUi9TRTYvN3l0VWs5?=
 =?utf-8?B?N1F3T3RBYktJaEtDWkVnRGZMM0JXQTRRZ1VmN3BTblgwRjRFNjNlT2ViOEpr?=
 =?utf-8?B?YWxoN0czdW4yUHF6eU9aTzlBOGtIOEdIQXdTYm5pMVFVTVBEUXZsL1pGNUtI?=
 =?utf-8?B?RTNzVlV1T3N0OXZRYnFvSFR2QVhZOHFITUZGZm1JczBkNjJ2K1VqSlFQK0Ez?=
 =?utf-8?B?bSt6UlJQMlpZSG5DYzRCVWQ0Y0FJcmV6Y3ByVXRpWWdzcE9QanFWYU5UbDRI?=
 =?utf-8?B?VnlJMTdPRDdBdThTc1lTMk5mZUw4Vkwrdmthbk92SWNKNDRENHVQSEZmQ3d2?=
 =?utf-8?B?aW1PR3NMdWszTHR6Sm9aeCt0ZFhpenByUy9LZE12L2ZmbHpLMkx6eUpZNC9t?=
 =?utf-8?B?ZDhMUmJlRS9vTmNUOUxwa3hxUW8yOHRDYm95L0owUHJMK3JoZUZhNklVUSti?=
 =?utf-8?B?T0ZaYmllbk1NdFFQcWxHK3IvQkpZaC8vL3hVSDBndnhaQW9MRWx2UGVJaGI4?=
 =?utf-8?B?MmFMUVhuY3Q5MUs5SzhTMTAyb3ZGSEZ0RHNaaWhyZGUxT0JxdHlFRjZxbFZB?=
 =?utf-8?B?YmtmSXhOZStvaVQ1ZCtFZVoxMmFPNTNzU3o3bkhaNjREQjhSaFc1djJLSEk3?=
 =?utf-8?B?aWUrM2hMWEUrK3lVTDVQUVJtbnZOQ2xFeXJqNTJNSU1lODZvR3RyQjU1T25D?=
 =?utf-8?B?QVBPVkszeWlUZjlDWXlYbkM4QjFEUE1zTVQya2ZnVlVDMUdxNlVYeXdySzB4?=
 =?utf-8?B?OWFlR2pYbTJwTkVkV1M0U251RXozcEIzVFBVTjd5TWdSa3I2M1d2c011SFBZ?=
 =?utf-8?B?eGVKSTBaLzhNOUw0dkd1T09kbHlDL3VlbURaNU1jelQyMFE2clZobFVFZDlF?=
 =?utf-8?B?R1phbnROUHIzT0hnT09MVUFIcEtyMk9VRWZQdlkwSlVIM1ZqUVZhclIwVWhQ?=
 =?utf-8?B?eXZUazNEQXd6U3pHc1c0MDBrTGdrT2pjYXcrTG5JQUExL3FiVzhobmYrK0Ni?=
 =?utf-8?B?b0dhaE1LQ1gzbjNvZ2FBSW9oQjJxMW9KeVc1MERoZEg0MFpjb2tRYkl6UkU3?=
 =?utf-8?B?TWFUYmJaSnRHVTBwM2FBeVN4OEJEU2c1OFUreXBIZ3ZFQlNpY0NRWFptY1g3?=
 =?utf-8?B?dzBvQ1RlQTY5SW5oaHQxRzZtUjVJRE1pN0pCSWdkbDhEcU8xeG4xYmVBSkNa?=
 =?utf-8?B?T0FreW1jellkMWpkTkVLeEpRNXJNZ3lFZUZMZUFQQ1ZyWkhKc1ZiOGQ3cmNZ?=
 =?utf-8?B?QUNsS1U1OS9LVlVzck0rQkpLTXR5K3Q4ZDR4UmVnTWpZUEJKZUxmb2pCVW43?=
 =?utf-8?B?OHhscjVCMFJERktSQ0tvZTIrL2wrVEo5TE1ZZjg1bXJ6VUU5K2sxTVRUWkpx?=
 =?utf-8?B?V1lRU2FtRldZcUdEaXZwSUw1a0VkQnRmVUZDS2VSUFd3am9LdHAxckhYZmVL?=
 =?utf-8?B?cmRZRkpFd1N4am1Oa2NzWFJXdzlLWW5PM01SSmxpRmkwWExpZGk4U0d5WVk4?=
 =?utf-8?B?L2w4VU04bVpMeHV3WE96SGh0U1BMOVNOZHJZaVVVb092VEFSbHpMemc3Rzlx?=
 =?utf-8?B?Qk9LSGdWeFN5TUk3V0UwVURteXJHYms5QmR6MUhLWk5lR2I0WSs3cnY3Qzc2?=
 =?utf-8?B?ZGNWOVZVOWQ2YXNPdTAxd2lPb1d0T3RWemhQa0FSN1RwYjNiUitrY2V1ZTk4?=
 =?utf-8?B?ZVB5MUY1Q1UxZmxxL0FUU0N2dVE0czROaUI4NEtYczJya01LY0JwdjE1MStL?=
 =?utf-8?B?U0FuOFVKOC94MWlzNnFqWVRqQVAyMHI5clhUaWt2MWdxTXZJV1VZS1pGSnF2?=
 =?utf-8?B?RVBBd1JFeWU1dXV6cVFSd1cwWEpnV1MwY2wzN2srb1diQjNZZ1lMMFNvYnox?=
 =?utf-8?B?NHcrTkM3TlJkakZoczFQdXJ5blBsUHFtaHBMUEF6bEU4SjRDYk5NRkxMRTlT?=
 =?utf-8?B?ZEpKZSsrYmdXb0NKTldRZnBIbEpQN3o3UHQwWU5NL0U2REF2U1BDVlRwNGtZ?=
 =?utf-8?B?aDgrZEpjZ3VlVURNOXV5bXo2eG1acGdkVnRUamxHa2tGQkVpeU9EdGt1Zzhx?=
 =?utf-8?B?VmJSSUFmL29hMEJPMzJ0b0dJcmVqU3B4SWplTUxNVjFZYWd6QTNtN055V0Uz?=
 =?utf-8?Q?ZKS+ph2yCg4d+JaA=3D?=
X-Exchange-RoutingPolicyChecked: LZ6K9fNpc3PQhcAGBAvYF71W3j6NzexDDWHeX7cdClndRYrM2ZxGKlfvFBXMrC7/aZhFDVIwUtKF0tV3GylFMbv98uF2/fLft1IRrl7lIuOpPIWhtGkgdmD7q+PYEbt7W6syXBihtYNGnnxyHfb3CAVZPD/HEidQZgOv2CYrD4ubwo+G4ipdbpogMOuNOyeEzpNZvhVasAlDqP4FZGohXm/jqga6IwIIZWmnEzwHylu5z/VVoaFOm+hdZI8O+hLQPiJ1S6Qw6I+crAHbwt7z3Z0bElGdFiuVQr7hHVGQpzSU8Qd/8sYzJgGCItS/UCTckuGmXoeDcpW7Pd+EcV0pEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eebe4740-1cd8-4632-89e7-08df34fba9c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:59:20.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLl2xdGgJcNB891BURBcxFvroE8odK8gQygTwlA3pDJd6OHvRASX+lOmf8bTNIbXGCNrdZtCV4QdE9BxvlMGNiaos8HsDzXxHEBg2YUwtRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
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


On 28-10-2026 17:51, Arvind Yadav wrote:
> xe_vm_free() is the drm_gpuvm vm_free callback. It hands the final
> teardown to vm_destroy_work_func() on a workqueue and returns.
>
> drm_gpuvm_free() drops its device reference immediately after the
> callback returns:
>
> 	gpuvm->ops->vm_free(gpuvm);
> 	drm_dev_put(drm);
>
> vm_destroy_work_func() then keeps using device state: xe_pm_runtime_put()
> for an LR mode VM, ttm_lru_bulk_move_fini() on xe->ttm, and the tile
> iteration. If the freed VM held the last device reference, the work runs
> against a released xe_device.
>
> Take a device reference in xe_vm_free() and drop it once
> vm_destroy_work_func() has finished using the device.
>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: LLM
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 823e264319a1..a1a4eaf3165f 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2108,6 +2108,8 @@ static void vm_destroy_work_func(struct work_struct *w)
>   		xe_file_put(vm->xef);
>   
>   	kfree(vm);
> +
> +	drm_dev_put(&xe->drm);
>   }
>   
>   static void xe_vm_free(struct drm_gpuvm *gpuvm)
> @@ -2115,10 +2117,13 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
>   	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
>   
>   	/*
> -	 * To destroy the VM we need to be able to sleep.
> -	 * drm_gpuvm keeps at least one device reference at this
> -	 * point so xe->destroy_wq must still be alive.
> +	 * drm_gpuvm drops its device reference as soon as this callback
> +	 * returns, but vm_destroy_work_func() still uses device state. Hold a
> +	 * reference across the deferred work.
>   	 */
> +	drm_dev_get(&vm->xe->drm);
> +
> +	/* To destroy the VM we need to be able to sleep */
>   	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
>   }
>   
