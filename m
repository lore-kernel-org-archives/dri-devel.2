Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF708CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520C410E9BA;
	Wed, 20 May 2026 10:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ad8ZU+vk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CA910E9BA;
 Wed, 20 May 2026 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779273243; x=1810809243;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FNSzQ0ZR9DvVlfV7EAOHxirunUU/sMkrKdRbsQaYxVk=;
 b=ad8ZU+vk/6Jot4z1IYL+FGMQyI5H5YY5NWcG3vhXm3BdiXuFBi4DvwIE
 WUCFDyz7sdNLamoS1aS6iAgOma5fKNaeMa5mDebJcRvPVuA7pNUnCfYzU
 tOqfC39f2VVrj/d6aVTzYr6blO+pMn+n65HawOzm1JZagGVvqtUKVmS/T
 V9vRl9EiIldzkNT2ytiJfEbHPnvmc3cgPtWhGALxNuCsbt3uq1AgCvwqW
 /yOJlYylW4Vhh3SdqpnrG1TrdEaIWE1twmsq0SKo0RAU5SMW7WrmCd7wJ
 cZ+ap+ZbTmPKmWPD4ju1UxLDY1afbgF7y37q6jkRG+vGqFHkU4aEYkPuR g==;
X-CSE-ConnectionGUID: 4NXw5vakSgCMYnU4BpM4Wg==
X-CSE-MsgGUID: yiRiAdmUSN25RwyRcmlvAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105626021"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="105626021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:34:02 -0700
X-CSE-ConnectionGUID: qBryYwt1SP+kJ94cHv/DyQ==
X-CSE-MsgGUID: 8o1beBdNSympnra+JPTccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="278226181"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:34:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:34:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 03:34:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfQIYY0bJWQYzHMryTkBG4fJD2PNPOdCxyV9vpCNSdQkxtO8OzPAloKvsgst/8wScmtD8J7WCQSVdkMUpL7hIMyerEZPrtZTFJ5150GSvUUPB38IMbDMp6UUOPkxdXXSRD/voBa10FeRXcs4wHXGGqshuxwq1pzzZY2K0sAaeKmEjySlyH78fGMqz/VgLAVsBsUyD4tKeGXfvIIJAl9sXQIAOy3F8c8COv1mFOwzyh4UB1VkbCW5uTIytp0VgrmFUlBHKRvTYWwWWyyloAgvMQvr9KVoxI2wrKsT/I3u5ysRR28b6SQo+qJYE68uzqJN52qAkD/eP4NBktoP1JIsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyE5/9bYtd+aECvrrqRpfySa13DLcuNbnyx0e1WWn2Q=;
 b=PbBGrOyqi+TFbwljasmd6ytCY2Czz01wuFCA4Oc8W6B1dlNk93X7CJqGlExfKdUimc8IsQ0z5NxDURfnJzYlkyxBLYCm+40VmddkleevyUbiLERIOyYS/JZiJTRDHl6t0QBeIOv5CSefwVJTA0WzidvtcoFvIdWNhn65ujc9jIO84ZxTvps39isPonkXW2PYUH3GZYlkcJP5naEcnUnXogTRd7H10+Zos/tQLyZGlS0x4sG4Q3KWenjSE6E3EWVE6/u7QOpsSYoawSfNgv3jLaYRJDzM0/rTgLuCtVRhqM02n4wHgskmL8Vdaw7NqucK13qkciJq1i/ytUjV/nJ6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:33:53 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:33:53 +0000
Message-ID: <cc73f8fd-19d3-48ca-9c1a-d645462e5286@intel.com>
Date: Wed, 20 May 2026 16:03:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on non-hotplug
 device
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
 <agWJbWQXA9XJnool@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <agWJbWQXA9XJnool@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::16) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4f34e5-454e-4647-1fb7-08deb65b4a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: GCqTNjHFlHrDW2ndSjFFYLlqCWZ7fe1UbRev8mlROwiWOmGAZFTtzooZNNcj09Dh/JXDLeytARXJ64yKaG5ngWDVf331nWZ5BgKySEtjykX7ms9x/rqu2w7Yz8P+QANkVqYX08KKCcSiZf6pWzNlU9xzUiPkmfLo6hciID8dOfS89nnl1Jwbg0RL9GXNsb1M1+opeata5kNzyDXDWabWWMNnmpZKb5xdce95IjXvzB8iTKuivQ6c+RXoGd8SfSyGjvXuoZp/qY2N0OYyjgp9OeCGfsu5YAslA16W0LlJ3L4WTJr55N6qNPfXeYVcIwuxrxEK0wHfSjPrej2ANd37K3wSF07MdXmBb0s+aROtVkGl5l5l5q2neSJCqbffQE4sJBTqfty8uucsxQKmNbfaHmHmuPdLTj7G5AO1JuxKlbbrnWhX9qI07o2mQFchJgOMV2O4WyPR0+GTch7GJOxVgzcYxAQruSahDLPy3wMkrdvnp/WOHPMzVeiAztXP1pDeQEOnUa0opqyOQRIt+ZuPsJNO9+P7PNv2CKfKq+mcJ6Yxv9lwU2YLfOXVlMZqXFilJvthVGL1qTb5X637Dut/Cl54Ax9BXiJt14ZLHPU55EW6jnjLdM7c9TzTNWW/D9EO6WUFpOhqP6GIV9SnompiexA+6n34zsLVBvzhM1dTZH2t0juF7g7G5SHEpITNwe3n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VKeFlZNXowd05lZVRVMWl1eWkyVk1RUk15TFg0c2VnMnlKL24yZ3phOERL?=
 =?utf-8?B?cm9zdGVxcDh5SHZLeEJSMENQdTFldVV6TXNoTzJzVUhBcTNZcWJGbm1Cc1ND?=
 =?utf-8?B?bHplU3dXNGxFa1hKTVZKUG9veXBGRmlNbXl0UUxJbzJDQWhHQlJXSlNvL2p0?=
 =?utf-8?B?NHMxTzNpWmJITjd3TlZVM3NFVG9ZR05rSVJOVnpRK3VNZlcrZE8xUFVhT3g3?=
 =?utf-8?B?bEsyK1hUNU1xWVNDdUhPdlo3TE93Y1Avb2FjVytHcUlGNml6T2hpTEdlN01H?=
 =?utf-8?B?MkU1MXBiWWJFQllhQjUzbHl5UFZwYzFROG5yaDdPUjhvWFo3azkrZlE0a3lK?=
 =?utf-8?B?NmRSSGZicjF0SUpmR3hvMjlsbnhpM0dnVU9BYnFoUUdobTlIT0pvRVFsV3Vu?=
 =?utf-8?B?clVvZUdSZWhCVFdSYzVIZ0d4d2t6VEgydnNPNXlDNkVJSUVFYnBoOUxraW1z?=
 =?utf-8?B?ZWMrZHQ2bHpGOG15RHN0NVpWOEw4ak9LWUg2dlEza0Zic0dtRWpmMXpUTm10?=
 =?utf-8?B?L1VKM2kzOTZqSGtFVU1mWE5PN3FTTDdGQ1RvRDJqcThjZXpMaHprbFY2RE9p?=
 =?utf-8?B?T3hHUlFwbitxRnJaWHJ0TndzQjBweG1UenVwSFRyWHpyVGc1WVFqWnAyNHBC?=
 =?utf-8?B?U3k4Smc2RVYyMURuL0V2OXFqc2liUHdkbE1IQ0l5Z0NZZ2RpQlRYRkg2dDdE?=
 =?utf-8?B?YjdvWVdTMUMvVkRLOHNZZk5iSlE2ZVFGMGV6V2JLNWdNOGF2cllyZFc2c1h4?=
 =?utf-8?B?RlRnVlV5d2JyUGNMSGtHNFgrS1Z1ZW9aOGYveE9tVW1mcHdlMHZUOERVQmxt?=
 =?utf-8?B?eDNza291aWFrN2dLMUdVNFlPNXJLMW80S1EyNDJVMy9nWFA5ZVZXc2FtUHB2?=
 =?utf-8?B?NFVpQitYZzJMeFpKdVI4ZEtqRlhudlNvcFJCSDZQRnEvOUozV3liRHFkSDh1?=
 =?utf-8?B?RkZUZ1dDMGhWRDFEYW51NWFyNUJQZHpkNVJLSUJlVHR2RGF3a2hUemNva1Mz?=
 =?utf-8?B?cjk3ZnBTaUlzQis1TWxNMEplTElNOGRiQWpMR2xOMlhFL3o4Z2cxbStLaXd3?=
 =?utf-8?B?aElTMlVZcTNrWDY1ZmpPRC95UWh1VEVyd1I5VnNtOHh3Y2Zmak0wRHNaMVRD?=
 =?utf-8?B?aEIzOG1RdWxhY29UdlZTUGFuSXFkNktZS2dPaXBUa0xwcEpabkFIZjJpaUxZ?=
 =?utf-8?B?ZUJNQm5Ja0kyOUVNekVaWEpjZHNsdmVQQTA4bnd6VEE5QUxLS0IvdU9XcGQw?=
 =?utf-8?B?Q3hkTnNWWmNXVjZWWTVrSFR5RUtseXV4Q0dZbHdtZWxUT0ZnMTZFMG1VeHBT?=
 =?utf-8?B?NllPL3dpS3E2L0hYWFh0ZUZBdGp1a3BJSHBmb0s5SDBvYVVxUU5OMXMrK043?=
 =?utf-8?B?amxKa1diRkJWRnBvZTZJcjVUbTVZZHN3SmdBQlZ0UTVNd2J4WGhGRTJ4TEYr?=
 =?utf-8?B?aWZUQmdXc2VXaVVwYit3NmJSQytHeXQxbUtGRGdsNk1SS3NRQmswa0EwRUla?=
 =?utf-8?B?SE5uaWRhQnRKUk1Hb1JERjFIOWl6b0tGVys0Vk5ERGxkV0FQc3huZmtUdXM5?=
 =?utf-8?B?R3l1M3FHR1lYT012c2Vld2Y4M3lUeWhNSDBzbHljRGdjY0VKL09jMWpiYTJo?=
 =?utf-8?B?RXhiUGg1a2xpQ0VjTzIyNlU2bFZmNXR6OXNUY0t1dmI4Y25jMHo1N09ORUJp?=
 =?utf-8?B?NTc2WkJxYlFEeFY5TVBYNzQwdERqbWRBS2l2RHM0NC9OSXRxbVkyQnV2dWRo?=
 =?utf-8?B?LzF5SGlBb2p1TDlnUzUrRVZhN3JnTDZrNm9KQjhpdUdYeUt5ZFkwYnh0NFIw?=
 =?utf-8?B?NEI1YVo5R05VL1VSa05rYnVsVkdsQkxHMGtzVzVtSmNGNW5sWU9Dem5QV3Jy?=
 =?utf-8?B?bnRKRWJqQ1JORnd0T1pTbzJmZ2xHS0xCRU9aZ1I1TnVZd3ZiSmtBYnI0Tkxz?=
 =?utf-8?B?eDFrQTFpZk9aVVAxY1dQRCsxblRSdklhdzRNdjFIYkpzLzVSQmJaWHN0cUtC?=
 =?utf-8?B?MW5ZUTZNaTQvSGxkVVo1SEpqc3BDZzBQT0hqTUVCWHQ2RzJ2UW1LcXdBWldq?=
 =?utf-8?B?MjRKRUpIejkyQmFGS3NaZEVJM2JURjBKZ0dtL3Q3MGFwaWg3RG4xWGc2bFE4?=
 =?utf-8?B?ZUdjUHZqelIrV0xPQy9kQ2JSUHBwcDRLbmtEZXEzR1FHY1IyTzNuWk9GQWxQ?=
 =?utf-8?B?NTl3WXBhUk44SWx5cnZKMkVqQzA4WXNoTXlzT2ZHZmhVSTRZN0VnNjgwMHA2?=
 =?utf-8?B?ZFRPMEZmRmdXZzNoV055aXNsSWp3WXBXYXpleFNrU2NPaWRkNkZRYktMYjJs?=
 =?utf-8?B?RVBiYytzWE9jQmVoTkJqemluTG1md01qbVVTMVB5ZzZTU3V0WWhkM1ZXTTVX?=
 =?utf-8?Q?YZBR/bE2yKmpaTKM=3D?=
X-Exchange-RoutingPolicyChecked: bQ74eY4tWOXOTgy/fFmjw/qG7McBqMbtvxTvM/yAm/9kZvsJahGaXL60VyO8uzRxSvwh8RhH0WmgLBgC2GngbGMQnDgrTgv8wqh+PS6aX2i+8wnAwA4zq4yzUVvLXpmsMNroUbRXkqcSvFatL+nN24DXU3b5RwHFTNdQ3eL5NCk+Ji8OPKONLKoXa5ZvSQQ01SONyX4g1K2gtLLYJ+GRkIU2zaoCrL02AN456B7n95g67TCDTQ8/1nRj6GBpnOb1i4UT9Y7/6NAmBSYwphEkQ8Kffx3GmUEE3cRpedeQQdIEQc3ZeaNfv82/AuSwsVtsRpHjHiE2+Gf/gsGbPzEziA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f34e5-454e-4647-1fb7-08deb65b4a1b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:33:53.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv7uk/BxFlh6mWQsmbWEblkHKFhoTECXWqBU/RvrqAUpYQXbOHcRhNZ2U5zojahesSg4Jslnt72DTLrL4YOrPTgVUFA+3HR92wN2Olujpgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
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


On 14-05-2026 02:05 pm, Raag Jadav wrote:
> On Tue, May 12, 2026 at 06:56:20PM +0530, Mallesh Koujalagi wrote:
>> If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
>> masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
>> Uncorrectable Error Mask register before punit_error_handler()
>> triggers the cold reset.
> Can you please elaborate on the "why" part? Is this something Intel
> specific?
Sure, will update in next revision.
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_ras.c | 51 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>> index 604470565bf3..67b4f25370c9 100644
>> --- a/drivers/gpu/drm/xe/xe_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> @@ -224,8 +224,59 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
>>   	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>>   }
>>   
>> +#ifdef CONFIG_PCIEAER
>> +static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
> Shouldn't all of it be part of xe_pci_error.c?
Happy to relocate if/when a second caller appears,
but for now keeping them next to their sole user in xe_ras.c
seems cleaner. Open to other opinions though.
>> +{
>> +	struct pci_dev *root_port = pci_upstream_bridge(usp);
>> +	u32 sltcap;
>> +
>> +	if (!root_port)
>> +		return false;
>> +
>> +	if (pcie_capability_read_dword(root_port, PCI_EXP_SLTCAP, &sltcap))
>> +		return false;
>> +
>> +	return (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP)) ==
>> +		(PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP);
>> +}
>> +
>> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
>> +{
>> +	u32 aer_uncorr_mask;
>> +	u16 aer_cap;
>> +
>> +	aer_cap = usp->aer_cap;
>> +	if (!aer_cap)
>> +		return;
>> +
>> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
>> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
>> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
>> +	dev_dbg(&usp->dev, "Non-hotplug slot: Surprise Link Down masked for cold reset\n");
> So is it required for all devices that want to use cold-reset method
> generically? If yes, shouldn't this be part of recovery script or atleast
> documented somewhere?
No — this is not required for all cold-reset users.
It's specifically for the non-hotplug slot case,
which is why the call is guarded by !pcie_slot_is_hotplug_capable(usp).

Thanks,

-/Mallesh

>
> Raag
>
>> +}
>> +#endif /* CONFIG_PCIEAER */
>> +
>>   static void punit_error_handler(struct xe_device *xe)
>>   {
>> +#ifdef CONFIG_PCIEAER
>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> +	struct pci_dev *vsp, *usp;
>> +
>> +	/*
>> +	 * Device Hierarchy:
>> +	 *
>> +	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit
>> +	 *
>> +	 * Cold reset power-cycles the slot, dropping the PCIe link. On a non-hotplug
>> +	 * slot this triggers a spurious Surprise Link Down AER event on the USP.
>> +	 * Suppress it if the slot is not hotplug capable.
>> +	 */
>> +	vsp = pci_upstream_bridge(pdev);
>> +	usp = vsp ? pci_upstream_bridge(vsp) : NULL;
>> +
>> +	if (usp && !pcie_slot_is_hotplug_capable(usp))
>> +		pcie_suppress_surprise_link_down(usp);
>> +#endif
>>   	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>>   	xe_device_declare_wedged(xe);
>>   }
>> -- 
>> 2.34.1
>>
