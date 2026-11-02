Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEC606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kjm0jMGm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641F110E510;
	Mon,  2 Nov 2026 04:51:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3946F10E510;
 Mon,  2 Nov 2026 04:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793595109; x=1825131109;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FvuOjAbTLcyRn8AbGbcqYHIFwNyKTcINQLsAFzeqKvc=;
 b=kjm0jMGmm9127LcuVJWMjPjZeHx2+HbhJDIqTmghtq9id67vC0pHTUhi
 2aVGu5nsEywFSyuce8Wj9jjBqrpEPb2Z7xk5iok9WZoIGPBKdYC9J0rTo
 jzp9PQHNNGsjOoZJoXBmf/dx4gfnN6Un8NnTP7MChymExVA0O/bOmMViJ
 BZ91xaMfFaaLbPmoFr4lPnebmzviBp+bH3L+50nEZvA+1qcOQ3AwByuIa
 nafmGIvxe5dFXDaXLX7Gaf+8TsBabVI8Rrn9L5nm4IZPUXtHOqCAbI8X1
 TxiCgWpDSfIoO6LXDfdUD/sNOhQ/+UCEZPdffYa67RcabyPiUibVrVJ64 w==;
X-CSE-ConnectionGUID: GuuhAtt9Q+GbvXDckjrT9g==
X-CSE-MsgGUID: O+veuUdaTiWYXDj1gADXeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2281489"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2281489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 20:51:49 -0800
X-CSE-ConnectionGUID: YZo1GG33RrO8wpJmTn1QZA==
X-CSE-MsgGUID: S/px/9+aT+ey9gj0/IJsRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6062962"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 20:51:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 20:51:48 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 20:51:48 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 20:51:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdUIa7UU20xsipinvL6X1sbgACdcxnybEIPXaH425IDEKOadM/AZs3JAp+0KUL+mmB+sTu+QgH9qxLcsYu/Hq6xlt9V/h0ySGA6lVikH+ys5LMSq8QFhprrW/Jnbsg5aiqBV0JZPyv+EFOdimn8/RnpO3VzAO0DiP7JNEdHzYZBHdgX63Zqrz/4G9ldqW+UaR2Cm4pSGYM8u36v0KvmoS0VW6XtEqcpyry6WKLjSgjOAlaAeGcVq8DqX6dZrrz7XTSqbnA3KeoTSwe9azd/qy4PFo5zGmUd79CRB7xbEnzepE32XaoMKyG0Ra2wFFPqR51kC1flY75hEA9A/E1o2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhwJGN/q7pC40p4IzL5H2eb02MGKNtqYNTJMMDulSlY=;
 b=jyUyby90zu28/6RjC13MMyFfFJ+gnd+RU/u6EX3w1DCaK3zXfO9Xp4KMeOZyvnLOai//mwDTA2hLJOJ+LwBX2eEHB0UgAV0B4CejjHCL1SS8adVenBceH2Y6B41JNK1sSovgbn0+1uGf9mV3U4W8JCcuwpIdhiNnxSdxXzIwtN6uRYS2C5vnhyJEQfVgvUpepXHMLKiACBmdgkATGxPqgz02C1Bl92OrU/ItcQMZaK4M7VYXfQZNW6jrxY12hdoVJcVflaoESh1ORitZ0PPSmXXBz0rT06IzeQ+PTgLtVTOdaQnGM7lnwAPaewzy3xUKuRddwmGVTByuKajH4FGjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by DS4PPFE99BD3AEE.namprd11.prod.outlook.com (2603:10b6:f:fc02::5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 04:51:40 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 04:51:40 +0000
Message-ID: <651014ca-f970-4363-86df-13d66ab038a9@intel.com>
Date: Mon, 2 Nov 2026 10:21:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Arun Pravin
 <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
 <20261022051518.486064-5-sanjay.kumar.yadav@intel.com>
 <5a7d92b8-3752-4585-ba68-070857b89db0@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <5a7d92b8-3752-4585-ba68-070857b89db0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0256.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::14) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|DS4PPFE99BD3AEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5a4783-ee7c-4f95-a6e5-08df389cfbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: CbJZHBvYBU/UmTYRQ1xk0Nvzgy9G/AXyQGTzsq2ZYvPfJ499YVygNFamTm0NVzLSZxyLnd8zL4iCKKVw0h4su30L8Yfo/KWAnbU8kwnUpkpNulrARTB4Bz0L426UofQX4JOr48xuUpl2mGeUYUWsZgzMmMvwFqQqcL9RJfrky2HsKGdioYdrXqqlGLMaE08zXMOrkd7lnobqlA5+WYLnsYl6D7Iuw1GPULMqwFVsN/C43Wl9oxyeXyqrwTCMjWoh0ckqc5yXPYOvl51U4eMkokuA/bYEuk0zMN1KCdjmglS9MV3htjBDo0u2nE2B6k82CKIQDZ9RKynmZtfGjRij9N8F9zSenEacft+HGJHnGyMI6MMsBcfxlARVzgEzM1BU/pH0rnCid2SnnVrYF4CN0aUywndhBpcnJkCaBb4Kb45oBfdJGzeV5o7QQ8H/6NeivZQPIlrA7co5FQ8sa5D0Lu9PT//ZtgmQfCIDxZDeKqLg8l7vzwNifCaQWDlwP1TVOozt7iUTAVl2rBf5J9eFXVuOv6qimZV1iB2yRr1mGiusiwr7vQCtLlkc9Jq3GlXXbd2LqK3Y6VbqvgxKiVcFHpKbJ7wyUZG9/J9dVhDxDp7lSlh/mVLmuei1j+XT44lMpjxbjzMMwM6GxUtu4TjQUYOAuBhfG3Ex4hxsX9b97Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZpMFA5c3BrQldUTVJRRXc3R1lnUXkwODJTY2U5QTNpNWgxUENmRkRWeHll?=
 =?utf-8?B?SE9ETHZLallEYUFHZklOdlJhRVpwWDhUU0lPcXZxbEswMjFtaXh5SjVtMFl0?=
 =?utf-8?B?c1lOekkveklrZ0ttYWg1ODdyRWtEeVAwNDhEYklQRVdyTHZTL2o0cHNzRTRP?=
 =?utf-8?B?SHltTUhlK1RmVTFtOCt1blFqY0g5eW53Wlh3dG1INkNvU1lTYldVN1A5ZWRy?=
 =?utf-8?B?MitvN3BvcURjMEhOTS83VnFRMHNFZmNZa3p2QVZxMjYrYmZ0MHl1TEVUME9s?=
 =?utf-8?B?dmx2RThrRHN3TkIzTDVWdmJTOFdTZXZBaG9PR3paSHIyUENYbjZ4RStmRlRQ?=
 =?utf-8?B?UHlWMUFNS2ZLRjEwMXZESUpNR2R0bm5Lc3JtVm9CU0szVURsU0JDTHRUNDFD?=
 =?utf-8?B?N01uWnpLRUZkVU1rV24zZzVBY3V3QVJXMG5sQ1RXUEtROW1mRFB2Q1UwNjAy?=
 =?utf-8?B?cWEwVnNPalBlZ016UkdIMnVKMUlVRzNJTDY5dFg5ZzByT0l4RWdsNDAzbzI5?=
 =?utf-8?B?cTZLR3FEOHdZeXltQW43VFo5c0dSZHNBbkZLcVRQNUJCVVVybjlxQ0dVVVZX?=
 =?utf-8?B?Qk82ZS8rZUVFUzd2Z2RUcXUyS2ZNb0s4emNhWGIvUXBNdXlnMDk0bHlrbksv?=
 =?utf-8?B?ajEyU0hhRFRyVENtQTFBSWY5L2E0SmtydkpES0d4d0g1bzcySjhYVnFOa3cx?=
 =?utf-8?B?V3RvQi93VzR0WmN3cFdEbnIrb2pPeWFEQTQ4VVRBN2pzdHgvODIzQ1V3Tldt?=
 =?utf-8?B?cUM3NzBPcm5vUWtxc0RFNzNyWTUxdzhqUEdtMXYrYkI5T29aVW9UNHdFd0xr?=
 =?utf-8?B?WlpWaGUyY2t2UDJub3IyeWdoalY2WkZyNWVqZXJ1SnRsSlBmNndPMmxiOGpS?=
 =?utf-8?B?aE5mc3QrdlRlY2doMFFBb3gvV0hqM0J0M2xNNzJuaTE3TS9meGpHUXpNQ0U1?=
 =?utf-8?B?V0MwUTVWVnQ0YUplZFFCN3VHa2tsbXJxS1h0VTJ1dzVXMUk2cU54eVdPQ0x2?=
 =?utf-8?B?d2R0UE0xdjBCeFYyK1VsSjRlRzlEN3RkRzJsdkxBTmVxMldFRmVhL0REMitC?=
 =?utf-8?B?b0xrOTZDZHVrOEZ2ZDBFWVRnNzVkREhvYjVvc2N1YVFuS1NYM2luWkdyeG02?=
 =?utf-8?B?bHVybUVaZnVraDdJakdJYlpGajM1VGFhTDlWR3dURnZGT3JkRXlKU1haVFY4?=
 =?utf-8?B?OFpaVndrTGhob2g5M3VTbzI0emdrQmU2aERGaVEybjVjRXhoVHp1V1BMWGpm?=
 =?utf-8?B?UkRNdjRkMTZyeFg1UDJPMjBoSTl6VTcwbHJVempwZFkzM05xMHBIMXR4T3Uv?=
 =?utf-8?B?eXQvZ0IwOGlweitIM0MvVnl3WDkydUJhQS9QUDZNVTJhOHNtcDRwZTNuc1Bl?=
 =?utf-8?B?SlVyRklDdTdzRWY3R3ZyeldlcnlKaU5IajhQdys1WlhCNTZJc3RZQjF2dENi?=
 =?utf-8?B?eTBTWDZIVG44dTBKQkJvMzVFTDVpV2ZxUldPTXBSV0QyczBwaVF0cDdvN0w0?=
 =?utf-8?B?VkZTTUNiRXlaamNUdlRxajU2QVZVSFAyR0xYbERsVFp2VXZXMUY0bTV3NXZy?=
 =?utf-8?B?RzJzODJkVzd0c1ZGK3QyMytCN1FubSthajVEMFpNeXR5L0NPM21qOHRiUGpn?=
 =?utf-8?B?elB6R3U4V3dURXU3TnZ4Tmp3YW0wcXZEaldad2ZDcFdiMU9hVENkakI5Q29h?=
 =?utf-8?B?MWRhUytRbjZIUVBTbGl3clJtQXpuSktxcmpBQVdDbzB1Yk5LNDF1L01aZUJT?=
 =?utf-8?B?SkNoU240bzRuWDNhNEVjNUl3eVlFK1RaRWhEZmVSaEpsNmNyTlZRUGhrZDIv?=
 =?utf-8?B?YTlKSHYyOW9nK1YyUVdjOUgvaVRkS2hwT1FpMXM0T2gvN3owc2p0SGdxMzQz?=
 =?utf-8?B?bkxWTEo2eUhMZ3draTFrK3hnM3hJMFh2NzNTeW5yWSs0MEZIRkNRUFBlL3Vt?=
 =?utf-8?B?bUY5U09XQVJMTGRGbWNZNWxhRk9odVZvY2tzditKZmJvWlE5WGtUZGJ3ak9M?=
 =?utf-8?B?SGZHRUJnM3ZqOXR4bzBEM1FneTlzQndqRTh1amE4cHNxUjdBa2JZZWQvZGhE?=
 =?utf-8?B?VGJsUDVpb1I5OStnWTZWTjNwMzZUenJTUVpPNEs2ejJVUEttbEdXTEwxQjIr?=
 =?utf-8?B?Z0I3K29YemN3MHZCY1J4LzFtNDROMW9TdlYvdmJiZlJFc1c2VmFIa2xoR3BP?=
 =?utf-8?B?RjYvN3I4dVZOd1ZodDdoeStMdzN0N0ErcjJxSFU2dGozZFllK2g2UENXT0tw?=
 =?utf-8?B?ZHVnT1VBTWNMYlN0Q1pDL1FNNDdWdExLc1E4aENnNytLSjRVcmpoTGNXY0Er?=
 =?utf-8?B?K3dJTTBBOGpyaytxdEJPWVZNWnpTaXZDN1MvNmhrVFd3cjRmdWVkZndnN3FD?=
 =?utf-8?Q?xqZpVRsmRIcUUEAo=3D?=
X-Exchange-RoutingPolicyChecked: mbE4v9daGXdP74XR7evj98AsaYq84/SH3EpMTOixF/dDb9gUVSwlqo87MZGQdPEKZQrnyqDTpMx2z5I+Gl1I4SndULdhEiAuiG54Nm91Ikm2AkBXL8PptmPx6GHZait4ITUwEfVIySY2/Je7RzHaR2L+M7MhfBRU46l6yCg2vHcWsafeOXgYM5pauchKwEDzz8Mxx1f+YcrWN9J7p1y0rMED1MImagLAkT10j3AYd1gz7PdsPxlN+J82q/OXTzV/V3YlfxT0XQTVVi7LmMQIQb3cpgQRlpg2h73eSy5VJ5eKQhcOyHc25VFdBLo4RLakleDm+XbaKkGzaPZZwk+SSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5a4783-ee7c-4f95-a6e5-08df389cfbca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 04:51:40.2013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQkGlI3r5J7gGp6YuouzZCqbMiojsN1W0TVpmZk6fCOWQW0uxEM/uVPx7jV9iQ1fsJo8NRqPWQgCw3KXMSfVVWM5m4kvdmIq4umFKfGVTWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE99BD3AEE
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


On 30-10-2026 19:01, Matthew Auld wrote:
> On 22/10/2026 06:15, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
>> state, and skip subtrees that cannot satisfy the requested order.
>> gpu_buddy_block_trim() detaches the block while re-allocating inside
>> it, so recompute from the parent once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
>>   include/linux/gpu_buddy.h |  7 +++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..b77d7f621290 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>> *gpu_block_alloc(struct gpu_buddy *mm,
>>       block->header = offset;
>>       block->header |= order;
>>       block->parent = parent;
>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>         RB_CLEAR_NODE(&block->rb);
>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>       RB_CLEAR_NODE(&block->rb);
>>   }
>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>> *block)
>> +{
>> +    while (block) {
>> +        s8 max_free;
>> +
>> +        if (gpu_buddy_block_is_free(block))
>> +            max_free = gpu_buddy_block_order(block);
>> +        else if (gpu_buddy_block_is_split(block))
>> +            max_free = max(block->left->subtree_max_free_order,
>> + block->right->subtree_max_free_order);
>> +        else
>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>> +
>> +        if (block->subtree_max_free_order == max_free)
>> +            break;
>> +
>> +        block->subtree_max_free_order = max_free;
>> +        block = block->parent;
>> +    }
>> +}
>> +
>>   static void mark_allocated(struct gpu_buddy *mm,
>>                  struct gpu_buddy_block *block)
>>   {
>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void __mark_free(struct gpu_buddy *mm,
>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_insert(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void mark_free(struct gpu_buddy *mm,
>> @@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
>> @@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>         size = round_down(size, chunk_size);
>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>       mm->size = size;
>>       mm->avail = size;
>>       mm->chunk_size = chunk_size;
>> @@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           if (gpu_buddy_block_order(block) < order)
>>               continue;
>>   +        if (block->subtree_max_free_order < (int)order)
>> +            continue;
>> +
>
> If we do go with this, I think we can drop the 
> gpu_buddy_block_order(block) < order just before this?
>
> Also, I think we can also drop the is_allocated()/is_free checks.
>
> @@ -1304,9 +1304,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>
>                 list_del(&block->tmp_link);
>
> -               if (gpu_buddy_block_order(block) < order)
> -                       continue;
> -
>                 if (block->subtree_max_free_order < (int)order)
>                         continue;
>
> @@ -1316,9 +1313,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>                 if (!overlaps(start, end, block_start, block_end))
>                         continue;
>
> -               if (gpu_buddy_block_is_allocated(block))
> -                       continue;
> -
>                 if (block_start < start || block_end > end) {
>                         u64 adjusted_start = max(block_start, start);
>                         u64 adjusted_end = min(block_end, end);
> @@ -1329,15 +1323,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>                 }
>
>                 if (contains(start, end, block_start, block_end) &&
> -                   order == gpu_buddy_block_order(block)) {
> -                       /*
> -                        * Find the free block within the range.
> -                        */
> -                       if (gpu_buddy_block_is_free(block))
> -                               return block;
> -
> +                   order == gpu_buddy_block_order(block))
>                         continue;
> -               }
>
Agreed. subtree_max_free_order is never above the block's own order and
is GPU_BUDDY_NO_FREE_ORDER for an ALLOCATED block, so the prune check
already rejects both. Will update in v4.
>
>>           block_start = gpu_buddy_block_offset(block);
>>           block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
>>   @@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         block->parent = parent;
>> +    update_subtree_max_free_order(parent);
>>       return err;
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index ddc4eca84175..8037f5a0feb1 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>       unsigned int subtree_max_alignment;
>>       struct list_head tmp_link;
>>       bool has_clear;
>> +    /*
>> +     * Largest order of any FREE block in this block's buddy 
>> subtree, or
>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>> +     */
>> +    s8 subtree_max_free_order;
>>   };
>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>> +
>>   /* Order-zero must be at least SZ_4K */
>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>
