Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G2CzqSJ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0374C10EA8F;
	Fri,  6 Nov 2026 15:58:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE5010EA89;
 Fri,  6 Nov 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793980707; x=1825516707;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mBxOUo3LAu5A/JVCpkaAfl/F7ORfA9AXFfkWexQbC1M=;
 b=G2CzqSJ6VLPhH3NW9m7cW2QNSvLm58W3FniLdOo/Q4mYjoY1CoaAttd4
 CUc6fR2jP0Ds2UrY8G1uJsD2g0dS+VNHmNVadidLSvqWwElpzZTgnOpK0
 K2Dlr8H+8iXNiCpt3JcgfpqlyeYFFLMxsGxrImWxqXcj4+AERka0njHnL
 yTO2RWqmqDnoDBpKu2nxaDxwPerJnAZgesxkpvoqtjjs0ryrAPXrVZmD5
 dk08KN6grgK8rh8cSIV1ZNS/8Gs3N6zY16KUrTlnKwql0s8UjuN4TK1c+
 Jtin/Q2qglRvoPeNLBzJ7LiUJaVoVnm/bMAZfgeHXjefi8pxx5Hno9ukH Q==;
X-CSE-ConnectionGUID: u8Ys1aSsRw2U2qf1e9dfcA==
X-CSE-MsgGUID: FT6MnachSbK89OtGarhaAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710980"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2710980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 07:58:26 -0800
X-CSE-ConnectionGUID: POw9dRJZSReiCJg5bU1ixQ==
X-CSE-MsgGUID: e1TC0BQxRpa03xVIFSN23g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7414372"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 07:58:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 07:58:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 07:58:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 07:58:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSAWoOGE0XxVroKwR7ho4f8ONf5Sjyg5/iQxmRMH+qWFEbB8HglmOMi6yUywzAQNl27zwJOgHB0AnulV+ir1MQ0MORM/ljagNbWYpGN0bggMPGrBmfVVyJ0HmRQ7LLnmZOBAirCpxfWw/6kJ/C87OcpP0GwDg5DFgn1XlR3a9LrDOvseT2JKW/UQcJ1jAucYoesSnqLTuOmcPVZdVDaHgtX1U0PnXTcp+BVB+Cn3zLJbDn1iTmusjLeCYpi6F0CA1/UWKST043jQSeXi/hSRv0GJgxkfLJ387modhrE63kVROeajndttsVP7XJqOB/xLOW4CFE8G7O5/rW9eUlqTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKdx4IlZ/sR3Om1SAU1ItYwfP04p2eUWLT8f26QkSrQ=;
 b=FeEeIu5zKygSO6tjw68/wj2ttXQg/XOdOShqf8rtQPKj4qbMI8CzTzPDSgbSsCdqIw9ubg6Kf+dfG9hPD4pYMyQRBpTmUhOQtXT+gJYzoyPLlx7H0A88JMWaJTh5PxJbDPd2+1gTGvHsa3pxWwbDlO7Q7giyMrgLlWbI/piRdshiuN1trMKjpVPLszUSaRGSInehAIDvUiuID5WIz6I9E9GhJKuerwLL9gMbxGYbfiEdWqaZKzZvWYs97SOb0v5Sj8l4vODHqctmennb8oh1+w56s5Au3hgXsSCn5159TazqJLyVFXYxIPObEfsj1bB+gX33qiGL/N222l55QiAL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:58:17 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 15:58:17 +0000
Message-ID: <5d52fd12-dc9c-4473-9d3b-b1c3d92e82ae@intel.com>
Date: Fri, 6 Nov 2026 21:28:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Matthew
 Auld" <matthew.auld@intel.com>, Arun Pravin <arunpravin.paneerselvam@amd.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <e87c786b-ceb5-4907-b215-ef276910392a@intel.com>
 <EDC6334F-76D0-491E-B91A-0E583350F74E@nvidia.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <EDC6334F-76D0-491E-B91A-0E583350F74E@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: d576bdba-c462-4123-c006-08df3c1ec5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|11062099010|7136999003|10067099003|4143699003|11063799006|5023799004|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: KpHFuWH7Xaf8IJKYxdVfWJa9qqH3vUDFcWGbFURFiBE0YjTzW9Mk2hDF+X/tyY5ZrpbOX+6zy+G2NCbvw8O9DwzzXC6MOSgsWAJ9cJ0YJdvSxcCYGiwLcTY/aAZ0fhAmEmaRg0/osUJV+NEtl3QAQPq4q4QnU15iUwtasXwuHTrY88Q7nfR61zLQRGxGrEhmkVg27OLxiYsHyBTHai1doyPWUpCloK3zL9orNq/HGfFnbGtfMhSoM2TVNRs7r7OuuUCUb2iobxjJoGe40uSpMdAyFMibCiyDJwPJqlzqOc2wr2Ib4E/O7hSgo6+XjQkLJBQvJFxWIijhpqBj0F2l27c6FecI+YSGI1aU5l4u7v2mh97cyA6CldNezFdNdysR0i00hLrna8e3KDkpBwTBpHmIP/2jqWG6vZJvlMxb6c2VMMu/lp+g+fia0emYS3aCHfNHH2a278JRBg0J7e+WMAyuN+NPUFRajtXo5eT1A8J9LML1OTt02TBtdHrw4vJ8aW3YyrkWx06gw8i5IGM0x/zR7mPzJA0oK//Ux9rva+Wmo2soE8iqicFmTTPAbVlRuSNNDlTTDB3Y+1PCe3A/3ZaZ8991EsYuhWnr1F9paFsPKiXRd0i0gdgGsL3HM2WF8mheH260x2FBHr/+0GbQs/dWNrzdBSsJKC7zDvt4Rpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(11062099010)(7136999003)(10067099003)(4143699003)(11063799006)(5023799004)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lDT0JrTWFEZUcwZGJBajNGNmk0UE9kWFRsS29xdzJsRjNKWEo2aG1MRUpQ?=
 =?utf-8?B?aWhvWWlEcnpPSGo4U01LS2ZWWllXWG83NmVod3Y3b2Y0WGpFanIrVXJjTC9T?=
 =?utf-8?B?enZLTDZzcTE1R0VsSXloUFkrWWF2NkhZemIyOCs2amx4cXl4L21oRVpFU2x0?=
 =?utf-8?B?ZWkzVzFSZXJqZ2RZS3RIeDYwa2lmemJ6VTBCOUt0NWVWUDNHNWxONCtLdEJ2?=
 =?utf-8?B?UUhVMHpUdFZOeTlmT1NQZ1VQVnZPUHExRzJlYTlWdm9PTWl4Z0NVTnZuZmth?=
 =?utf-8?B?TVVYdUc4ODRZajFodWxDZ2xXMi9kSU9Xdlc1SE5DOTUvejNmbDY0cG1QWUNO?=
 =?utf-8?B?QkRTbU42RWxyNlh3SVJ0cnVPOUhld2lsM2FxTnZXcGhPRXBsRC9RNUhCRHpK?=
 =?utf-8?B?U1dXT1ZUNnBxUzFNMDZncmhDeTlicEYwdGoyYmdqT3BHQWc1aEl4bE04ejRn?=
 =?utf-8?B?ME1JRlZVMWxET21ISEExby9KbHd6bjJMZWI4STBxV2pESDcvN0tBeUp3QTJH?=
 =?utf-8?B?T0NXTEdRaHArQ1RvZ2t3WllxeFJiNjRRV1U1TGRtUXdnaDdsMVM0ZW1iYnh2?=
 =?utf-8?B?VjZuQ1FhUWllWmZHRmVMUzhNRE03VXJWTU9VMmlHSCtMeUZFQ0ZhK1dzZ1h4?=
 =?utf-8?B?cFVhc1Jld000S1QwYjF1MTdseGV5aHJNdXJZa0pSUXpSREZRM3JJVGk2Mzcy?=
 =?utf-8?B?Nk55NGV3aUh1aWM4bStkWHVpUHlNSmFuKzlVWWpLV21pYzd4eFVqZUllSGpO?=
 =?utf-8?B?U2pvRzZBRHJ5TzNoTFZOb2M2UFdldWlmMkR6ejVZRTRSSGcyUXRjUGkxZ0I4?=
 =?utf-8?B?blpXUzN0SnNNdVdCd1Byc3N4YVphb2d6OHBxdGQvMDFIMTJFWGxmd3RYbTgx?=
 =?utf-8?B?Nk9qOWVrMGdKNGtJdHZyNTlzbW1hMXY4eGdMbXo1THZQblN1Q1dzVTNwL1dC?=
 =?utf-8?B?Q2FUNElMY1IwaXczcTkrYzJOVFZsdXFtbWZCb1BmckozYit5QVI5dlQyRUYv?=
 =?utf-8?B?NVJMVUlsZDVPaFA2bWlQUzRyOGNOcEdzWGNFMFlQc280R2VZdXJDaVQ2MUo0?=
 =?utf-8?B?WVA3aEVKN0NqZXAramtlUXNwTWdySUM4bWNyQUxIQ0t6cTBvaFh5VlJSUkxm?=
 =?utf-8?B?enZETEpSVjIxKzZHa21HZEswQXVuOUozaWhYbkJEb3l1U1VUc3VtTmNxTmp0?=
 =?utf-8?B?UmFSeEhHU3M0L0FzZ211L1NhSTI1bzF2SGFQNHVCelhVcjFKek54aEtFZEVt?=
 =?utf-8?B?YkRCY3U0THVRRElPd3B0cXpwOG9YZ3ZzczdxMGtCSmJWdGNCN1BiMHpZbFBC?=
 =?utf-8?B?K3BueG05NEE2YnQySzNzekxsaXpCZ3RKcjRwNTdUbkpzdXlwdVhLZTVaWmdk?=
 =?utf-8?B?SGlZZE50ejJkMTdPN1RUZ1pCVjc4ZmNPd2FQMEhmYXNqaHkvOXVmUWpGR295?=
 =?utf-8?B?dzcwTGoyTnp4d0xBcUFTZTJKcW9IWWVYMk82ZnlYeGZMUjI0eGtZWVp2SEo0?=
 =?utf-8?B?STNnTXFvUFkvaFdxZVgydG0waXM4azVWYjhCMzJiVUo1akRmN292MUdCYnh2?=
 =?utf-8?B?ZlJzZTlCejc3SHFYWjVhblV2N0ZUZGJyWllqclFNZXU4cmZlM2Z0RXA3R3J2?=
 =?utf-8?B?U2F1dnJVWE5zaVNkcHBXNXAzK0o3ZzZ4dkNSVkxSSmdZSDZTRmZWSjNRU2RY?=
 =?utf-8?B?cTF4cGRXNHMrRUJmMnh3c095R3NJNzJmdktpUGE4MTNLdGJYT1g3NjFTRmdH?=
 =?utf-8?B?V1oybVVZN2ZwZjRGaEp6dXFlamczb1pyWTRKSExKNUl2Z2hNTDlKVnFoMFRk?=
 =?utf-8?B?TzVyQnFJUU1kWXV4YWdtSGhpMGhuNitYTDFDSUpBUUZYY205V1RFUU5hQU9X?=
 =?utf-8?B?Z3NqZ0QzZUdZczJTUytETXdaV3haTUVIaVA3alBsM3Q1K3RoUytFd2F1czNU?=
 =?utf-8?B?WkhmOWZnM2t0a21RTERPUHkvQTd2TTg0K3ZLUmVPSFpyWUx3YXpWTHQ4S1Mw?=
 =?utf-8?B?czFmTnFBWmtVTnVUSzE5ZTFlYjVkTnJ0dW16NmdBZFUvOEk3eEVMQ2pIR3da?=
 =?utf-8?B?czA0MFpaVGhlT0NhSjI5ZnJaZjlSNktsTUcwL2F3a0dkdVZibkVXVVZ1aWl0?=
 =?utf-8?B?eGdEbGcvYmxpYkthdWVQaEVaQjBRenJoZE9oRXJCV3F5QnpVVWE2TzNlZXdO?=
 =?utf-8?B?UWlhYVJIdjZ0VTh5bm9qc1Vld0V4c0NtRnNBS1NoN1hwVUNMS1lpUlIrVkV3?=
 =?utf-8?B?U2dtR25TWTNzN2RQalNUYnMrUjlRcDcxQlpHV2FkN1pHRi80TnAvTWk3bW4w?=
 =?utf-8?B?aVdtM1QrWDRXU2xZQXFTSW9OVGFNVHR6YkJLcEdiaTNTb1haUEk2ZU4ySXg3?=
 =?utf-8?Q?/8jqRa0xTbcrJTJM=3D?=
X-Exchange-RoutingPolicyChecked: WvEABtbzBGY+YC3Zp4hSEsKXTRAoCIY407ZIKJhC539OZ9m8NFLzthCCYJIXtWml2vwDkpQQJZJEXXmJgHgFKyW9SvsZ7/8LIQGtGCKlonF4ZU7CAupkxbdYQvJbShm4Zb/lDE+nCarM79bIG+iIuIRuCS4yVxdO1wMrFYSAuCu4KN7NaErRC+aDZgTqlva2V4TGpTMH39UQa5j12RFGoinyOhoLVipBJ4cKmgPFpJ5mv5j40I9zdMdz9kZ1VJmvlDNEVndKqPk/t3Z+BBBdc7crKJ3uh9Z9fgYt4WIWgwQlMNEy8zkYfn4JPoS7Mu3+FWVs+knfkhzZIwq/zoB4Ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: d576bdba-c462-4123-c006-08df3c1ec5c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:58:17.5758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxgh3bkv/YUiTvhyL+y9YCnNTI+lHs8ey6iW5vpLu04ICZe7Df0eCqdvt3GNna53JsWfcrkd3l9v+eKOKpcxcis8n4E7zqzdTYoa1iTpK4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
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


On 06-11-2026 19:15, Joel Fernandes wrote:
>
>> On Nov 4, 2026, at 7:13 AM, Yadav, Sanjay Kumar <sanjay.kumar.yadav@intel.com> wrote:
>>
>> ﻿
>>> On 02-11-2026 10:46, Sanjay Yadav wrote:
>>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>>> first, and descends every SPLIT block even when nothing below it is
>>> free. Range allocations are placed top-down, so they pack below the
>>> range end and each new one walks every block already allocated there:
>>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>>> lock.
>>>
>>> Track in each block the largest order of any FREE block in its subtree
>>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>>> or freed, and skip subtrees that cannot satisfy the requested order.
>>> Splitting needs no update of its own, as both children are marked free
>>> right after and that propagates the new value up.
>>> gpu_buddy_block_trim() detaches the block before freeing it, so updates
>>> stop there while re-allocating inside it; recompute from the parent
>>> once it is reattached.
>>>
>>> Skipped subtrees contain no FREE block of the requested order or
>>> larger, so the old walk could neither split nor return anything there.
>>> The remaining blocks are visited in the same order, so the selected
>>> block and placement are unchanged.
>>>
>>> v4: (Matt A)
>>> - Drop the update in mark_split(), the children being marked free
>>>    updates the parent
>>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>>    only the final update from the parent propagates up
>>> - Drop the order, is_allocated() and is_free() checks in
>>>    __alloc_range_bias() that the pruning check now covers
>>>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>> Assisted-by: LLM
>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> Gentle ping
> Can you provide performance numbers with this change too?
>
> Thanks
>
Existing gpu_buddy KUnit performance tests, drm-tip vs drm-tip + patch:

Test                                            drm-tip        + patch
Fragmented allocation                            139ms       154ms
Reverse-ordered free                            91ms        96ms
Contiguous alloc after fragmentation            8ms            8ms
Repeated 256 KiB allocs from fragmented pool    14ms        14ms

Metric                                        Without Patch With Patch
Average range-allocation time                78-793µs  340-494ns
Blocks visited per allocation                16K-147K        38-39
xe_pat pt-caching-random-offsets runtime    ~48s            ~0.7s

Sharing the same data that was previously requested by Arun. Please let 
me know if you need any
additional or specific data.

Thanks

>>> ---
>>>   drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>>>   include/linux/gpu_buddy.h |  7 +++++
>>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 28cff97d57dc..93f70c98b235 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>>>       block->header = offset;
>>>       block->header |= order;
>>>       block->parent = parent;
>>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>>         RB_CLEAR_NODE(&block->rb);
>>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>>       RB_CLEAR_NODE(&block->rb);
>>>   }
>>>   +static void update_subtree_max_free_order(struct gpu_buddy_block *block)
>>> +{
>>> +    while (block) {
>>> +        s8 max_free;
>>> +
>>> +        if (gpu_buddy_block_is_free(block))
>>> +            max_free = gpu_buddy_block_order(block);
>>> +        else if (gpu_buddy_block_is_split(block))
>>> +            max_free = max(block->left->subtree_max_free_order,
>>> +                       block->right->subtree_max_free_order);
>>> +        else
>>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>>> +
>>> +        if (block->subtree_max_free_order == max_free)
>>> +            break;
>>> +
>>> +        block->subtree_max_free_order = max_free;
>>> +        block = block->parent;
>>> +    }
>>> +}
>>> +
>>>   static void mark_allocated(struct gpu_buddy *mm,
>>>                  struct gpu_buddy_block *block)
>>>   {
>>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>         rbtree_remove(mm, block);
>>> +    update_subtree_max_free_order(block);
>>>   }
>>>     static void __mark_free(struct gpu_buddy *mm,
>>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>>         rbtree_insert(mm, block);
>>> +    update_subtree_max_free_order(block);
>>>   }
>>>     static void mark_free(struct gpu_buddy *mm,
>>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>>>         size = round_down(size, chunk_size);
>>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>>> +
>>>       mm->size = size;
>>>       mm->avail = size;
>>>       mm->chunk_size = chunk_size;
>>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>             list_del(&block->tmp_link);
>>>   -        if (gpu_buddy_block_order(block) < order)
>>> +        if (block->subtree_max_free_order < (int)order)
>>>               continue;
>>>             block_start = gpu_buddy_block_offset(block);
>>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>           if (!overlaps(start, end, block_start, block_end))
>>>               continue;
>>>   -        if (gpu_buddy_block_is_allocated(block))
>>> -            continue;
>>> -
>>>           if (block_start < start || block_end > end) {
>>>               u64 adjusted_start = max(block_start, start);
>>>               u64 adjusted_end = min(block_end, end);
>>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   continue;
>>>           }
>>>   +        /* Not pruned at @order, so this block itself is FREE */
>>>           if (contains(start, end, block_start, block_end) &&
>>> -            order == gpu_buddy_block_order(block)) {
>>> -            /*
>>> -             * Find the free block within the range.
>>> -             */
>>> -            if (gpu_buddy_block_is_free(block))
>>> -                return block;
>>> -
>>> -            continue;
>>> -        }
>>> +            order == gpu_buddy_block_order(block))
>>> +            return block;
>>>             if (!gpu_buddy_block_is_split(block)) {
>>>               err = split_block(mm, block);
>>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>                            gpu_buddy_block_offset(block),
>>>                            gpu_buddy_block_size(mm, block));
>>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>> -
>>> -    /* Prevent recursively freeing this node */
>>> +    /*
>>> +     * Detach the block to prevent recursively freeing this node, and to
>>> +     * keep free-order updates from propagating above it until the trim
>>> +     * is done.
>>> +     */
>>>       parent = block->parent;
>>>       block->parent = NULL;
>>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
>>> +    mm->avail += gpu_buddy_block_size(mm, block);
>>> +
>>>       list_add(&block->tmp_link, &dfs);
>>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>       }
>>>         block->parent = parent;
>>> +    update_subtree_max_free_order(parent);
>>>       return err;
>>>   }
>>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>> index ddc4eca84175..8037f5a0feb1 100644
>>> --- a/include/linux/gpu_buddy.h
>>> +++ b/include/linux/gpu_buddy.h
>>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>>       unsigned int subtree_max_alignment;
>>>       struct list_head tmp_link;
>>>       bool has_clear;
>>> +    /*
>>> +     * Largest order of any FREE block in this block's buddy subtree, or
>>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>>> +     */
>>> +    s8 subtree_max_free_order;
>>>   };
>>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>>> +
>>>   /* Order-zero must be at least SZ_4K */
>>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>>   
