Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAE606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TKMiqO1Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF1410E711;
	Tue,  3 Nov 2026 01:57:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E2710E377;
 Tue,  3 Nov 2026 01:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793671046; x=1825207046;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H8nX7b1WlWrH0okhTNsGcSy6zmfJXMuxVvE18aj8jPk=;
 b=TKMiqO1Y+6hNUR0nWEsIyoFaq3ciLiOovAGm/wumesqOAFsa6aB5qCw4
 +XJPSYWRdeerdrSAxLns3pPsfoDyGAGZcROkjkWJ2XVneuquOQd21JRuJ
 0K3e43l1aLZWlRxHmsixW9QokIR7CY2KJebOl56bm15LFUmgTExARlpqq
 bf1pJCMTc4GL2nPsMYLV8c4GcT+qrtLjEY5KiVVkUE3gF+KfprrpwkkAq
 0GNQ82NlS+wfXRWJlHVSnq7FVfUlUZpPtl9U3zHubmFyKhbJdmUz+Rlcv
 wD0VPhMIVHUN/+JDgXQOdsK4a4bkM+3QYudUpeKShO4BPGd8HFuVgtGL+ Q==;
X-CSE-ConnectionGUID: OgWIgelEScyQtoDHnYXJAw==
X-CSE-MsgGUID: wdmxtzarRfmVsG+eq/4jxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2272847"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2272847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 17:57:25 -0800
X-CSE-ConnectionGUID: 8mseNo2hQD+1dC7iAA67Iw==
X-CSE-MsgGUID: sYb0xjf9T+2ETTzpGLs4QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6164332"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 17:57:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 17:57:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 17:57:24 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 17:57:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJJ10uEvsmTgDVGxkFEQfuwETF3eOdlBqa5Z1is2KzW5fhw+KppRbAxMKEIF0KXrw1KvNpcrDdci18DZgLl9hratu9uLbS8QHiHjKSLKTp/yDb0aIXF09rvrDokw102kQV75kY9pRTqJRshiVGCUsMaX+hxn4Y3gQDs8v6LS23Wm/AeoH6Z+Kd2O7QUpkE1pnwI1E++gD2tYXPIeVwQ4nFZ+84EO/cMQceUhqWAMwxCEXSE/Bg9u0zUMLlVk/NoPA5hXwGxCAwdwl2eu7H3wJyyYbR4dgCm0bMx7Wtg3smxGfLf2xWaiL2eJoMOjIc0wWHUJKS06w5iEV/iQiVQ09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myds4s6DWdTSQ+bFtHtQYksQA+Fk/Hjumr9AQ9ajkyg=;
 b=tc2o+4E9/GnbhAWpehNddORcCzqW8DivH9+Sy3WvsqNSN1REBJcm04sHjma7ce4XSWkDFHLQ8WDBviOSfF+11n1XMIH4i8n7IEQHeX4vRTumK4nKYi9LHUPVDVHNCkqS9w/DbwwRsDSTGWbDcFB/pyPk76exHBqv3m4tCl/vk6KSBRPmlBEKeNygATgykDSPuLxbk2YNzbDmYuhixQVssm96CtZDZTwIpTZb/yZYeSp3EyFx8THo+9oviK7uzekM5MR8ZAJQyFmfDL53uWtyUpRR5YEMxfQHdrmJOP+nv7dtzCyC6l9voDbmRCHZ5Xix4fa8QBFEnza2kMJCP+G9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7821.namprd11.prod.outlook.com (2603:10b6:208:3f0::22)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:57:20 +0000
Received: from IA1PR11MB7821.namprd11.prod.outlook.com
 ([fe80::6518:db96:947d:6203]) by IA1PR11MB7821.namprd11.prod.outlook.com
 ([fe80::6518:db96:947d:6203%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 01:57:20 +0000
Message-ID: <2c1fa55f-1981-442a-9faa-ccf8ae8e7398@intel.com>
Date: Mon, 2 Nov 2026 17:57:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe: Add support for Wa_14028250015
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Daniele Ceraolo Spurio
 <daniele.ceraolospurio@intel.com>
References: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: Julia Filipchuk <julia.filipchuk@intel.com>
Organization: Intel
In-Reply-To: <20261102180516.1551869-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To IA1PR11MB7821.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7821:EE_|DS0PR11MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d2057f-cd03-4c7c-3448-08df394dcb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|261102123227099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|261009223027099003|261022113327099003|261028144727099003|261021121427099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: 9rAQhyF/hYN0NCWkmyRG5KeasCLZqMzuhZtwGQrECcP583fQNFf1680it9FcQ7gH82Tlfm+A9ZqzN+tcWvO5cP3PjWc2d8gPM/mtZ2/mzlHMLF8TEEr7j5Zu/Um8Uifvtw+1Mjq4SmG7o9URNYypnRRUGMeoo5u6J2ymTxSBbY8f5hxFnZp8xl6S7mw+v3DpnShFvYXrkug9/4wlIoqMUYDkrPfELYYBGF7R23BDJX8McA0+np++u0HvzYyq3qaw8FlWPx1qmWwKz7ZQgHZ7aYiHih2YYXh2djk27ZHdNS6AA5+X5AhFDFPtlwMnyLbe25KjKtq6VlgM/QYE36Pl9htzJAIX5teNGIZc1Toji8V+Hja2efvLBj/F9+bAIsWPpOydV12SA06e7WxkGJ/3XQUXG0jOg/bLpRRQ+s55/twnKHTBAnAIGE9p3VLVrT2zILw4v1Ui9ycaN3kBmTI3VkZj4bZ1k+8UWE2xKHNzGgMCMlyC706+Zxyu+zZ6st8SOxvCgXTzToMJ6D3U+08lJaO7/QosJKcvyKYcnbEBBDd/DZqBBdPjU0yvMijlue9xg/5DLK9X+XGiuVF61HAqpXhuekXI/WYARpnJSguZ84eKHBres+8a3+ONad2EQyofOpQZS6BJrL89jnghvgZ3TmFKKUfO95AWhRA6ci6JwJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB7821.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022113327099003)(261028144727099003)(261021121427099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRPT2dydjN5bHRTTnlrbDJFR2JueVcwYlBBcUNJZEMweWpPRXhMekd4YWRv?=
 =?utf-8?B?ZGVoWXBtd3E4SXpZUzIvTUZmZEpodlphdWozdFdBU09XSWE2ZTZDSFhwenhN?=
 =?utf-8?B?U0Zla0xETHdhVHYzQm9pZ2pDYmlJTUZCOWhXcENxR3NwQjl1UUgxWDdTN2cr?=
 =?utf-8?B?NTV0VVFOR002ckx6VEFKVUNXa1d6SmcwSWF2VExLc1BlWVBrWG1aaEtNZHJM?=
 =?utf-8?B?ZitjdHBYbGJjYk9LNFdDQkowQ1EycnBickhDeTVnUGZyNGliYWRVMDRyMXJh?=
 =?utf-8?B?UmRlRFk2cU54b0V1cE5HQ2Y0QmVlUkRsNmVMMXpJLzZpdEs4MlIzNXVGd0Q2?=
 =?utf-8?B?RDcwamZtTG1lcDZSOGErKzZxeEFieGVEQTJ4elNSb3RyeHFGa1RQZXpUTWox?=
 =?utf-8?B?ZzJIY2k0OVZESG9VVmt4MC9tdjlNVUdMOHdJa3Uwck1vbFVxS2lZMGR5a3Nl?=
 =?utf-8?B?RmsrVWJJMVVGUkVCVTNkd2I5eklmUGZkTXZRR2xzakZWcmZoa2pQQUcwSDg0?=
 =?utf-8?B?bHRnOUVPOWdaVmJRc04vYXJ2R25BMXprMEJoS05RNTU5eTViS1N0cVhTYnNS?=
 =?utf-8?B?ZEZVeGhFQ0RGTHJmR3VkVlBRcmNRT3pocFVuWk1jNmFhRkZCVDV1cjkvVS9y?=
 =?utf-8?B?Qjd0eHh0M1FFV0p6eFV5WWYxakx4Q3RwY0JZSmdTV2JERG45RTJCM3dZTUFD?=
 =?utf-8?B?ZHdDUXBNMlhmeExBbEJuT3VKM2I0QkpJZWE0alpoTkp3Z2lDcFZyZHZQV0p0?=
 =?utf-8?B?cmhlK1NKbE5UUDkzRTI5dldhL1RvRE1FMUVUMzJ5S3RFeVVWNzdHNTRtTWlJ?=
 =?utf-8?B?UDBhd1Q4bDFrdXRRRlhsUFUvOTRmclJ1Q1FKZHlxcERPV0kzTW5sRURWQUpX?=
 =?utf-8?B?RkNUYUxmTy9pVE84UnFYaFJqSzNBcVRUcmJTaUFsTnlZeVVCZStWQzIxWC9s?=
 =?utf-8?B?QlZ3cUlRV3JRd2I0dXZ1cmFTZ0pidTI3M08yL1U4Wll1Y01wVUVaNWtBRXJv?=
 =?utf-8?B?dGo4bVhaK2VmTjI5U0Z2K1AzVmlDR3pPa1h5STlEc1RCMkNGRXhnRFBEOStj?=
 =?utf-8?B?ejNhMStkUGFubE1FZ0V5WVBXS2VGMlQ4WWdNWTJnaWJQNFJNN2RkdExMMTZG?=
 =?utf-8?B?SmE3V2tSNGdyeWFPWjJNUklmNkhTcXcydEFyVGFibjU4b0k1cVZQdFNLanRl?=
 =?utf-8?B?TTdYbGpCY0hzRmpuR2Z4eUxrNU1WcFp2dzAvRzFjN0s2dHRBaUZvajFjU3hs?=
 =?utf-8?B?c0NpUUdoVURIeXcweUJjVm1UNEx4aEpjWndWaFNEY0I2bjF5ZUw1UXZFbjhD?=
 =?utf-8?B?aGZYOGVTOEVVT2dadk5lV3hneUszbU1LM1pNU1hHcGZXcnFWODZrVTRDT1Bo?=
 =?utf-8?B?SkdRSVRsVWxVTWtMSVZXay9xdHdxazUwL3pEbWwxeVVJVHdNMnBoQUgyaGQw?=
 =?utf-8?B?elhSR0JUNHZXai9DQWVwcUxnMUZueXBvTHBveUdBcCtqNGI3ZldKZE5rQ0Mr?=
 =?utf-8?B?SEVRWHc2Wm5rWlZjTlQwWENSam9zYWxTbUY1Q0REMWVIVE13clhLOXdxYnpE?=
 =?utf-8?B?azV2K0s0djdmZDdOZVJITklFUFJUZGxUczFER1AyWnBVMEFsYWNCUU1XcEdo?=
 =?utf-8?B?VnFIYW0wMU9aQkZaSVdmM05tN1llOE1Qcmc4SDVDMW50Zk5leWh3eG5qV2xU?=
 =?utf-8?B?YnRXZXkwVmlpOThJZGtSM09qMUxJYUF0b0gxU25aMFMvWVVEaWJ5RG5ZY1g3?=
 =?utf-8?B?ejZPMFZnZGJrbnMrLzd6bjdPajNoaVNPbG9zSmxZczJ5VjRid2NkNGNRT1Ft?=
 =?utf-8?B?ZG0zRncrRWlRRlYyeVhiR3F3MEdGZUZ3ZklkZFlMZG1uL3JYQUF6amV6cEVk?=
 =?utf-8?B?OTJVMWtValBVZVFBKzN4TkRrbGRKT1lJYzFQaG9qdUh3MTlWMGM5enVUckdp?=
 =?utf-8?B?UXl2eVJmcXJOeWtMMGN3UktLeFFsZHNhbDhZeDZmWTRSMXM2d0dPeUwxb1Mz?=
 =?utf-8?B?TkdROXRUbkpDQ25reGNaWEc4QzBtQm1IY2RlaUVKSGZEWHZMTXpIemQ1MlFa?=
 =?utf-8?B?RzFaUnFoNThQM0Y5K2VKQlE4REo5TnA5MjdKcUNDUVJoKzRUSno4R203bFA3?=
 =?utf-8?B?UTdRRW1qMHhjeUhuZW5DVVFmK2FpRXNOVkNlUDNPaThscEhOT3hhVndXNnZP?=
 =?utf-8?B?NDFtMHdxL1IzbkhmMFNNZkJ3ckprTDJ0OFJNSmtmTDlJSDlmNFVHMXMvNFhC?=
 =?utf-8?B?bytLN2R4S25IeFR5Sm91V1poQlRDR2laVGdrVjgvV2hQSUtkZEp0Y0JJTFo2?=
 =?utf-8?B?QUdOTDVOVmN4dTh6d2pkY2pIbFVrcmlNeWFESjFIM3p4d0lQcW5ZbVFnYWtD?=
 =?utf-8?Q?9ecZ1pKyiIi4Vt1g=3D?=
X-Exchange-RoutingPolicyChecked: sW22gNHlF7Tq6TDuzXSZarDIVllbJhkyaK/iZDgTe/bmEqvQWXhVBOmdXZHM3oZ7qOizM7hMxHAhd9U4I5NwveDQlNPvXj3fo3RFudxkGpUN9eRdFpS+BiAg8mP+//SqyEWaLFa1qOT6nV7SGtuOwL9fHi8gV/gwNS3cb+XoGarU2iYGvy+e8BvMuhjvGBDTvt6HW7H6tDUWsERRNQteexmaSaSsMreeUieTMuDaDqyaKeJrplop8tVZ2ZjrD3DSrG31fMria6uLq7K2xC7LYnge08FkyKSqYPQI91aQm6vCjLSmyaYyFcqn9HqmH6LxKVSKa1dCO9FQ13OAYfRVIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2057f-cd03-4c7c-3448-08df394dcb8b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7821.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:57:20.1584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP7hvNcOSv0n06v0/gi3jpSzPWfZd2PQmcVfP1y/BOdmjfFUh1Mc3mu4maMeA6hg63lkpxrzfFnwqifnsfbaVe0G7lPUsxjUOIazZdqIoHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
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


Changes looks good to me. However CI results seem to be missing? Will review
after a re-run.


On 11/2/2026 10:05 AM, Alan Previn wrote:
> The WA is implemented by the GuC, so we just need to enable it via the
> dedicated KLV. It makes the GuC complete page reclaim requests that
> end in an error, instead of leaving them pending. It is only needed
> when the page reclaim HW assist is in use. This WA only applies to
> graphics version 3510.
> 
> v2: Update "Wa" tag to align with others. Don't gate against value of
>     has_page_reclaim_hw_assist. Change the #define name to match GuC
>     specs. (Gustavo).
> 
> Assisted-by: LLM
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> ---
>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h | 1 +
>  drivers/gpu/drm/xe/xe_guc_ads.c       | 5 +++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules    | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> index 4bcdc1a96785..4103de0b1c97 100644
> --- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
> @@ -526,6 +526,7 @@ enum xe_guc_klv_ids {
>  	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>  	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>  	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
> +	GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT					= 0x9012,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index c3ce3c8c905a..1927b595ad67 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -389,6 +389,11 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
>  		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
>  				 GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB);
>  
> +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
> +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78))
> +		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
> +				 GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT);
> +
>  	/*
>  	 * On GuC firmware 70.66 and above, use the Feature KLV (shared with the
>  	 * WA KLV buffer); older firmware uses GUC_CTL_DISABLE_MULTI_QUEUE in
> diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
> index 61aa50a63764..fde91192bd46 100644
> --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> @@ -78,3 +78,4 @@
>  		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
>  16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
>  14028709524	GRAPHICS_VERSION(3510)
> +14028250015	GRAPHICS_VERSION(3510)
> 
> base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2

