Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC4C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1369710E465;
	Tue,  4 Aug 2026 08:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DMW1CBzZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC0F10E2CC;
 Tue,  4 Aug 2026 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785830694; x=1817366694;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n6ANhnV+nL0EdKOfyzUZhALYwy+qiSLpCJ9sj2R4Dbw=;
 b=DMW1CBzZgLb2VwMCbaJcc19/aVfpnBXedbUbIIEHueYE/ofdsumLKbKw
 mSVe0NGvRqXyqt1xUktCRND6p8ZvtLIYxdtpcwA8xLEGEo3clUH/RQzfP
 Qreyp4lc8izQ9QaZ3yRORsUIRmgnbLCHDH983kPaiSaBImcFNr7vjl7vr
 pv255faFltRHAHPmqxjCvYdP5VBJQwBFQA4vtnUsmBjABVe1BTu/fTkPW
 3+rR20fQA4NmRAuAfy8+ejZhkozGC/L6YXEYaRfzJ/0CRdFyZgiyDcnXV
 I+zaMryE5QdHgDftzrcMp2eNjG2MJAzYcR+6CHypqtMZj9oudIlU7WFkH A==;
X-CSE-ConnectionGUID: Ho4Pc7KZQDKWR/I9ETtH3g==
X-CSE-MsgGUID: jNRXFeu+R/Kn+UNpKh7JIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96966369"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="96966369"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:04:51 -0700
X-CSE-ConnectionGUID: Wa26cBVZS9eVr0G5N8SAXQ==
X-CSE-MsgGUID: +T7e/uB8RpejOjVtzjRgdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="257115115"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:03:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:03:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:03:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfhlXV5EN7ef+VKHbtooPg9kXaeNSdXr4jT5bSv5GUtrAHa7S4bAU97dhakv4dt0/APWDL4hJm85ruDFeUmKaql6e2bq6euNq31iXr7AyoKXHOsQh1nPm9oZn3B2MXNK3oBSY8f/pbnxh//WW7F366p8QKQWv0CgJTSl3/bhULvKErtSS8UF+ZfmXK/9596worh2/m44ac9R4VM/wK5V2vdgrR7chhNyXYxGkjUD7vM3U0UX9w56MLjgAvQeuOL9ffUyKsNielXVwl8u4gpdYXF28a7gvV/gsY94nJzTA81InEoOYa/rViNaOalhjqccE7ithhtUS/CDc96GIyNdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNNkqZk533okR8hh2Mk4u5snQPh80WDmUlRicdm9iKs=;
 b=BkxzrUgrdF9tbuFJFtjUisnXmecIsFtGC/x/f6SSZNO3V0U+fjRROdezv3S64AQDS8146UemnaBKS3lKS23BMuX9vstMEfaSJZt6OtFHAiD+hLTP+HKgv7OeTTlODrCS8yPkR5m1zfsvzPYbZDjTURCEyyAt8kItnkQdws9jIfbDxLHssSsCmxyyuQGo87cf4joLfIsNoBj8COYU1CF6STcolEC+w9ukei+FDBPrj9Uo5Om4OUA2NX25o1Rm7N1nSPA63BruOPdzN54R4RCjg+Qy8WSnxjKeMwYrUT0GnemigHG/KGbLVCkii2czxoyDhxlQGWKaz+JjGaH/rcPudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6209.namprd11.prod.outlook.com (2603:10b6:930:27::16)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Tue, 4 Aug
 2026 08:03:37 +0000
Received: from CY5PR11MB6209.namprd11.prod.outlook.com
 ([fe80::a805:a5ac:cf5c:8671]) by CY5PR11MB6209.namprd11.prod.outlook.com
 ([fe80::a805:a5ac:cf5c:8671%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 08:03:37 +0000
Message-ID: <46dc1b3c-2d5b-45c3-bb37-e9f639c95884@intel.com>
Date: Tue, 4 Aug 2026 13:33:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
 <amkCDzvNVZOXNz9N@intel.com> <e1cb0cca-c1b6-4c95-b2dc-2f23535befe6@intel.com>
Content-Language: en-US
In-Reply-To: <e1cb0cca-c1b6-4c95-b2dc-2f23535befe6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To DS7PR11MB6199.namprd11.prod.outlook.com
 (2603:10b6:8:99::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6209:EE_|SJ2PR11MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c85f75-8994-498a-d7e0-08def1fee30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TAGUQ/SQonw4QMwZu6rF2CaU6LSLL0zhxfLY/y1wV/yHT3Tlgr0fmbYYvfHUDQCsftNJtSkLaDqP3pPqcD4pyfk9WCnR7RoaJrxCT4CWmJapiLqyjobwTuKtWrdvTMQz+q5uOMkZCNXX/YDWeVqfE683rgQPfjhSmIh1x/wpznRfKd0Vk0/fo55wd2gaUz8p2iK+5MJEaydTpw/ZDudmm7KDq/mYK3FnwdR5dojxVo6daMcTvH652+D5eQ3Zw/YpLOa0sKujU/eyGrbWNZecV5VaHtmkIAWEo7pkXksGoOJmNzBceFldeoO69BPECQLn1QtpoCLMnj8KIWbRg9B7d7Tnu69a+tst3QJfhytoXl+33BLetHX//21Z2bcI/B3YMW+66k+15XdGrH5TJSZtbHawvryvhad4+g8yjFG8hvH4FvygmtURPBPt8RByEI5iK5K3jwBF1qCeeAHfg8tauhgcdJWJu9mMI+MzvLl9SXe3oqN/RLBq55WID0YckrnCYXlhllyz8krnOFUoXHmnsdS9F04pfUSklAeVBhOUdldpF38/PA4Qib/GDoTdvZbg4RFIZbbAD9h/iuwYADvGyFQnH6Xq1Ue2VilZwRanHr0UYKf6b30x+97IHspnm6bX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6209.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Y2ZzRkWC9aOEJCbVI4MmlVNjNRWUdBZWpLQTFLNUJGZzJCR3BpZlIvM2Uw?=
 =?utf-8?B?bU1iRFd3bUZWOWhhbDJRQ2o0MFhmT25obkxCWE5RYnlRR1BaZURqVG8vOE1m?=
 =?utf-8?B?L0NpZ0F1ZmpuK1FOdmlVSnhlTCtNcTZkY3hXWUhISzN1TllubkNJY0FoSEdj?=
 =?utf-8?B?cWhMaEYxOVpmTWlOYmlLQkkwcUJDR1BITEhuZktabEFVcGVTN3c5SVhXNWdJ?=
 =?utf-8?B?Z2l2cU5SaXpQUW5ZRTQrNVhKRFhFaC9EY3RCMEV0RVFHYndsdklVdmp0S3Ra?=
 =?utf-8?B?NkplMnpWMTRRVDRkejEraUNUeWlJNXduQks3dS9SUW9lTFZVVG9rQU9XTjU1?=
 =?utf-8?B?TkRNWnpTNks5QUlhWjdyN0EzYnRHcnZhUUIvK21MSzJPQUZDM3h1UHRFVy9H?=
 =?utf-8?B?SGpvYy9rbFBxQUh3TkVFUjFvazZMZVNyeWtFR0RUbmJuckM3WGhYUE5HNFBO?=
 =?utf-8?B?dVZ3dFE4aWRHWHFuTXA5SW9XWEYrbTV1Q3pDcVRKYS9RVi9WRGU3eHIrZ1Js?=
 =?utf-8?B?VHZYUEpRZ2x5dWU3cnVOQ3JMaFdOekV4QVBUYjg2ZlhVVUhmSGdRUFBpQXRW?=
 =?utf-8?B?N3RvQndhZVNlRC9Yb3lZTG1Yczg4ell2ekZ1T2ptSmJseUxpL1BmOHNDc3Ba?=
 =?utf-8?B?Wm1yZzhJYU1namZJWTNYZWhTQnphS0N3Qnloc0lWTXZkdkVzd2gxRUFLSlBJ?=
 =?utf-8?B?c2xDK09Xb1hGZkk4MGdnNDZmTmpkUW5rU0EwRXFrSlpyT3QvcFdPMUVJcDdL?=
 =?utf-8?B?OWg0R2FyNHBNbEkyM1QzNFQ0a2lOTUJRYUI3ZjNlVGZtUUhUNnJwWHNGV3Qz?=
 =?utf-8?B?QmlGYi8vNEhtVTZiRVVHOTlmZENHa29jNDQ0WDZ0WittdFQwYlpwV0lLREl6?=
 =?utf-8?B?akI3RFVXOElNTkszWHdNeUQzUUZwK1I5WnZCVFdmVkNDcHpCTHRTY005dGYx?=
 =?utf-8?B?QWFIOFZPQVltWk5KY1dHRzcxNkJQaW5veVhVVnpnRi9jNkhXR2RjeTNXanVy?=
 =?utf-8?B?dVF6QXF1cmdMWFFFMUlXVzBMRklySVdYRXlueXJDV1R2OERMbFoxYldaNlU1?=
 =?utf-8?B?dFdiMjE1ZXlKK2FKcGVMMGVza1hSYnRVZEJrWFJySUs4WVVkNVlrd200SDJF?=
 =?utf-8?B?QnhGVENpQzB0YSsvVCtxTjZ4Q0hnTXEvMEdJdjZ2VFB4czMvdEVtMWZrbVJo?=
 =?utf-8?B?QzR0Z0VoeTJtSE55WWJ0VHRCVjlwSUpnTnI1NVV2bGdIUmdLbVNhaGJaMElK?=
 =?utf-8?B?c0REdUoyZmcydmdPVWNtQjJMa0s4VmhNQ2phUWVEU2ZkbElKQUkyZGpVYlVp?=
 =?utf-8?B?ak96djZiRDJsRGIwNVQzcXUrWjJpdFhLR0ZYYjNFS25xLy8wZTdZS09ZdWZ5?=
 =?utf-8?B?TEU5eU5DVXdGRkYyZ0Z5WVowdmRMOVM5eHFlb29XMlBUTG15VWdZM0IyL3dZ?=
 =?utf-8?B?c2JsODludmhXYmExcThCYXMvd09NZVorZEZFR2Jta3pZdStWbjBDUXBnRTdn?=
 =?utf-8?B?SEJUaWw1OXJhbk5Cam5qQlR6VW9HZXBmT2ZmR1FoRlV3RjRNU0cyUWo4S3lG?=
 =?utf-8?B?NjVOcFVGUHJURGhqNm8yK24ydWh0YmhrUlRNNkJGNVd1RjFVY2tabnJ6SFBR?=
 =?utf-8?B?bEFGdlZOWVVkYU8vRXMrbE5LWUViSmt2eGhmWXM5dkNheGVXNjZ3b1p4Rnhv?=
 =?utf-8?B?amFBTjRsVHFnc0N6VzFwKzYxdVVmemhtSkVEZys3R2VWUERyWE5MU1BJV1du?=
 =?utf-8?B?T1Q3bUFjci9WZGJ6N213c1dGeWhmbVRDOWJsMzJNbVJ4ajVsYlgwcEVXanFn?=
 =?utf-8?B?bXVHZUFmWDBldUdjQytGbG04dzM1TnN6T3IvanNEdVlVZVRsNkdMbjEwQ1dU?=
 =?utf-8?B?Q0hiajRnVlVpaTkvMHhvUmkxM29KNGhGWUJNL0ZkWmtsMlY1a25XVG9UdkNm?=
 =?utf-8?B?Ti9JM2VDclFWbWN1ZmEyc0lpMnVsUTVwS3lKZ2ZjNWdnSWRHSEZjbkdSQlFI?=
 =?utf-8?B?NCs3ZWRxbStrNDFudmxJc1JRZVpFWE1vbWhSNjI2SExHWHRZQkFWY25KY0FR?=
 =?utf-8?B?MVFXYzFxaXR2ZlAxUGFCQ215U3NyRUtUVG1DKzlmVXg3RW1kVnQ0L29vb3ZR?=
 =?utf-8?B?YmRqY3VqU1p0STVuc1pIanFTSkxSV3JCUTJBanJER3FYTjJETDZQdlpLOFQ2?=
 =?utf-8?B?cFZJMUpJTFJJbTdna1dTelNEWjIwVzZVbjZ5MnBGTVVyTU9DV0Y4b3FqYmxF?=
 =?utf-8?B?QW10Z043VW92Y1dOOG9vVExaUmVpcGNlZkxMS2NZQjVQOWdwUzlLMnJBaUxX?=
 =?utf-8?B?ditXWVhGVEhsa2VFSjlqdSs2bGd4MldBOWYwZGtrLzg4S2VnUkt0bFlteDNO?=
 =?utf-8?Q?9xm4vBqkHuaZcxlk=3D?=
X-Exchange-RoutingPolicyChecked: qlQB2nA1E24WmbpdOIzH5hx8+C+a0249lwUxEOsthTWDR1R100FZl3h3Tk8GTSSLA8uBKUC9U7kGEQ1wfXQrkInldnAz1zuNDuDeNkPNMbc9sf8vNvmvr4vuvTrh70AZsV2Xx49MsE3iMXCFUYv/xWdMeak4VipU6Sk4lnRJebHELcRHQyIPNQ7BTsJtFY5oo1SZlaUR3PJfOfkEsPfdSB8YhLjxPI91mr9Qi0NdT6M2lPcSYQ3IJ6o6TtTvt/YsvUbIGoJtHFMQw6d27yKe0+6GCd2jUqSuMNMEzhHOCy0bsDrS/FjANHdMmcDEHTCLRG3QHIwgrrYLzyl7pG4PJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c85f75-8994-498a-d7e0-08def1fee30e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6199.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:03:37.3116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFR2zY2D1veqTuB/+YND/bCuLbbG2sY7VSeQWIOi0xmDBudUrLu/q/ECVbROMA6J5mTu2m2nRfzAvQnMkKVXDVI1zhwj7qPFDx/w6xsrYUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
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


On 30-07-2026 12:56 pm, Mallesh, Koujalagi wrote:
>
> On 29-07-2026 12:55 am, Rodrigo Vivi wrote:
>> On Fri, Jul 24, 2026 at 03:33:07PM +0530, Mallesh Koujalagi wrote:
>>> Use fault-inject framework to trigger punit_error_handler()
>>> for testing.
>>>
>>> Usage:
>>>    echo 100 > .../inject_punit_error/probability
>>>    echo 1   > .../inject_punit_error/times
>>>
>>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
>>>   drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
>>>   drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
>>>   3 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c 
>>> b/drivers/gpu/drm/xe/xe_debugfs.c
>>> index 5a3877fcb0f0..5599d493feca 100644
>>> --- a/drivers/gpu/drm/xe/xe_debugfs.c
>>> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
>>> @@ -42,6 +42,7 @@
>>>     DECLARE_FAULT_ATTR(gt_reset_failure);
>>>   DECLARE_FAULT_ATTR(inject_csc_hw_error);
>>> +DECLARE_FAULT_ATTR(inject_punit_error);
>>>     static bool csc_hw_error_available(struct xe_device *xe)
>>>   {
>>> @@ -62,6 +63,8 @@ static struct {
>>>       { .name = "inject_csc_hw_error",
>>>         .attr = &inject_csc_hw_error,
>>>         .is_visible = csc_hw_error_available },
>>> +    { .name = "inject_punit_error",
>>> +      .attr = &inject_punit_error },
>>>   };
>>>     /*
>>> @@ -76,6 +79,7 @@ bool xe_fault_##name(void)                \
>>>     FAULT_ACTION(gt_reset, gt_reset_failure)
>>>   FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
>>> +FAULT_ACTION(punit_error, inject_punit_error)
>>>     static void xe_fault_inject_debugfs_register(struct xe_device *xe,
>>>                            struct dentry *root)
>>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.h 
>>> b/drivers/gpu/drm/xe/xe_debugfs.h
>>> index cd56f7442b99..dd57914dd4f2 100644
>>> --- a/drivers/gpu/drm/xe/xe_debugfs.h
>>> +++ b/drivers/gpu/drm/xe/xe_debugfs.h
>>> @@ -13,10 +13,12 @@ struct xe_device;
>>>   #ifdef CONFIG_DEBUG_FS
>>>   bool xe_fault_gt_reset(void);
>>>   bool xe_fault_csc_hw_error(void);
>>> +bool xe_fault_punit_error(void);
>>>   void xe_debugfs_register(struct xe_device *xe);
>>>   #else
>>>   static inline bool xe_fault_gt_reset(void) { return false; }
>>>   static inline bool xe_fault_csc_hw_error(void) { return false; }
>>> +static inline bool xe_fault_punit_error(void) { return false; }
>>>   static inline void xe_debugfs_register(struct xe_device *xe) { }
>>>   #endif
>>>   diff --git a/drivers/gpu/drm/xe/xe_ras.c 
>>> b/drivers/gpu/drm/xe/xe_ras.c
>>> index 92b4181026cb..da06c16cf7ed 100644
>>> --- a/drivers/gpu/drm/xe/xe_ras.c
>>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>>> @@ -3,6 +3,7 @@
>>>    * Copyright © 2026 Intel Corporation
>>>    */
>>>   +#include "xe_debugfs.h"
>>>   #include "xe_device.h"
>>>   #include "xe_drm_ras.h"
>>>   #include "xe_pm.h"
>>> @@ -391,6 +392,22 @@ enum xe_ras_recovery_action 
>>> xe_ras_process_errors(struct xe_device *xe)
>>>       size_t rlen;
>>>       int ret;
>>>   +    /*
>>> +     * Only allow the injected PUNIT error once the DRM device is 
>>> registered.
>> That entirely defeats the purpose! :)
>>
>> Sashiko identified this corner case so I asked you to ensure that 
>> this is covered
>> and to prove that you should provide a fault-inject with test case.
>>
>> But then you are skipping exactly the corner case. That makes 
>> absolutely no sense.
>
> You are absolutely right!! Guarding the injection with 
> xe->drm.registered was the wrong approach.
>
> The correct fix is structural, we are splitting xe_ras_init function 
> into xe_ras_init_early() (keep all bookkeeping) and
>
> xe_ras_init() (called after  drm_dev_register in which 
> xe_ras_process_errors now lives).
>
>
> Thanks,
>
> -/Mallesh
>
Sashiko corner case issue is addressed with patch: 
https://gitlab.freedesktop.org/drm/tip/-/commit/20bc4883c7c0e28c3ba6c76ccc279486c349dd3e

Do we still need this patch? Please let me know anything else I need to 
address here.

Thanks,

-/Mallesh

>>> +     * xe_ras_process_errors() also runs during probe (via 
>>> xe_ras_init()), before
>>> +     * drm_dev_register() calls device_add() on the DRM minor's 
>>> kdev. At that
>>> +     * point kdev->kobj.parent is not yet linked into the sysfs 
>>> hierarchy, so
>>> +     * kobject_get_path() returns "/card0" instead of the real 
>>> sysfs path.
>>> +     * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent 
>>> with a wrong
>>> +     * DEVPATH that udev cannot resolve, silently dropping the 
>>> event and leaving
>>> +     * the cold-reset recovery broken.
>>> +     */
>>> +    if (xe->drm.registered && xe_fault_punit_error()) {
>>> +        xe_err(xe, "[RAS]: PUNIT error injected\n");
>>> +        punit_error_handler(xe);
>>> +        return XE_RAS_RECOVERY_ACTION_DISCONNECT;
>>> +    }
>>> +
>>>       if (!xe->info.has_sysctrl)
>>>           return XE_RAS_RECOVERY_ACTION_RESET;
>>>   --
>>> 2.48.1
>>>
