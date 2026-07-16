Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A63C44510
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AFB10E5E0;
	Thu, 16 Jul 2026 06:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M7d8NlVO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B009210E2EE;
 Thu, 16 Jul 2026 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784182063; x=1815718063;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vuiSA7iO4HFRkyjvK7dmlf2vGO8c8awdap1A652KALE=;
 b=M7d8NlVOBvctJQOJBBIqje50qWdnq55yZdGBXmX/+y1464pZ2nCawl7E
 0xVE7Ukfl2I7hyAsjte8f5pmPfAZY2F7QEt8sQps3o8lC+aaWRuUQ/VyU
 MVaO16bWLx7bMAWm5mIs7b/s3ZT1FMkNOg5wSHVWuGtTfVjZmr2AwypG5
 bnryUOL9NeZvugS+xrUuWh4tWgiWeTAl7diCcHIRiDmo0zo1T/3s6Lfxg
 RK54ONG8QYU3bcBODNWA3Aokd/Xhw5+xlG6nIib9ysOjU1raROUomPMnN
 6o7ElOJBAD1cpyvvkAO/xfE696o01PJ5s42rEdhmsfT0olKOQfO9hqYCT w==;
X-CSE-ConnectionGUID: WVvL4CAPS4WxBlmx0eZifQ==
X-CSE-MsgGUID: 1t+RbrqxRXmCZeFbSC/vdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95475815"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="95475815"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 23:07:42 -0700
X-CSE-ConnectionGUID: 4DrhfTQrRqme+HZMsyGBYA==
X-CSE-MsgGUID: /fUQvqv0TSK+eJO3EYdX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="255272638"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 23:07:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 23:07:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 23:07:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 23:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2V5iVISrs7F2mDWHjSrhiiB0XIeQeRFe7DPNOkaCnw9sEaSUzXdjgEfeHsAJOr4Y6sMssHdx5BREdV3CuZYeAveYijbSJfGMAeeDfK9m9Cc5teMptRwJK/7rgcBkxFueUTiVK9DYa7JEqFJZmld5gIT1mt8Qs1RvfOj1gxcCcD8DA0tM8RUTQ800ohlsqkSi0Rv/87+k7Qvfy8GZ0zWF5SLbjhQiiB1CayZiiV7mNeungiHjdv/6jPpIpEa+bYQ67i/jRuFlMCVYi8oGTrtEaphvyfYWOr5g9Rj9Poqf4AT8/NJmv6YepbTz5n3JwRayNoQCTLoTEwkMAw8nXeO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTbNBmH2SRqCMG9W+VmbcLMDX1bc1NeGVxjBYtlEZf0=;
 b=GqvQbvQvFDW3u38nuUETSTQ1M+HW4zOE2JCWegMTRk+/4eAX+/+iA2uSY5JG+27FE7BX2DQRK5oyZTBZQ4fRcVOOEF9YOaW127f/aYam6QqavLH0F3Hd3qCBAQnWl5hAh+yxSIDHSekbsLguH3U0AttymyzMuC4zZNs1HL6R0+XOQq0SAgr+nQA69zpAWcU41ug19NNG1KvZBgNSt797AXxW5jEDfUReVVi66UQQCmqjZpc9pKF5wbWt3lpnqdpayNqvCB69hzSZuzf8EkbmAawll7d9Cdm8qTWEtKasgNlz/uTCBIhUPTEuEohXAtTpD5HFT6YZhvB7LSLCnFKXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:07:33 +0000
Received: from IA0PR11MB7955.namprd11.prod.outlook.com
 ([fe80::6021:79ca:45d2:ae46]) by IA0PR11MB7955.namprd11.prod.outlook.com
 ([fe80::6021:79ca:45d2:ae46%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 06:07:33 +0000
Message-ID: <f94de9dc-ab8f-42fe-955a-ddc17321f4f9@intel.com>
Date: Thu, 16 Jul 2026 11:37:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
To: Raag Jadav <raag.jadav@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <kuba@kernel.org>,
 <aravind.iddamsetty@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
 <anshuman.gupta@intel.com>, <joonas.lahtinen@linux.intel.com>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
 <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com> <ak6xThf9qeB0wqgK@intel.com>
 <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
 <ak9oUmZ8sS3aF6jB@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ak9oUmZ8sS3aF6jB@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To IA0PR11MB7955.namprd11.prod.outlook.com
 (2603:10b6:208:3dd::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7955:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c7513a-8dce-4299-cc7c-08dee3008651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: luxivYmOyHuH3lncSyCv+QG6+EOQWQgx00vVasFSp0cce4kS1ruIuib93D+ifcXK+uugFtmkSXnNvQ4adg803ivKW6ktRWvQNBjVl3HwgQQZDgjVkbhB1UYjXWvp34Mrw3Kk50XRksg2Cnh5Sha8/T0iQgSupmObdgAqyrPsjsz/OAwzkZCZAJB7gYQfd2mfmbnYAr2OwL8kKjaHMqNEvvfJd0K8lpc2LkvmzHs1GCyYQiuac2SXCsy62uXRMi3YegAubhDhBNsk3eTcLwlmt7g3kBxmDTuYRtuClVNjvsXnOKBFs+5t0mWgg5lGjIaF1H2hgcz81bvuGmlRV+vCMxqwywRGTFlkspMHAagxaoRpPy0jBK4UPD9xgFbBRTGG/BGaY30TzJH9Du+MsQDKKKveAkuL49xn/mI2UhZXYtCnJza3rI2PqBkMh79+xBrOsXcqea9HCf/hS2lmjIjCqgtBqcZ8tOXzSCt8SqH2pcPzpU/E6iHQhaNj/nkynU0Q3CcGCYNIG50EfmdIlk+9Q4FrBfNIoslVQ/NfFSMBHqckPEIH0su1wPKNC1n8EOrGFASFrT6i0CU+W+VqkVXE9qPEc2gu9WROAxC7LWG/7pj1rkdUE5hvLvO/AZ+JssLoWnn7cgFcEFofU9/dae+crTCsi8cRJwQNrACPrSvuPm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7955.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhEZnJkU3VTRXhSSVZXSGg4eTdoa0FNT0h4YU1oZ2YzaGtlMHA5SHFIRENN?=
 =?utf-8?B?clpZdjJleFhEcm5Bek9JS0R5NDNlV1BMeFZlS1dJdTdUYWZtcHRmMTltRmha?=
 =?utf-8?B?bDlsVTdmTlhYc05DeDhxOHFjV0VBeE9tMkh1S1liNzBIeEUwTlc2Z1JYanRo?=
 =?utf-8?B?bXlWWTNBbzJJL2JOVWRmYUFsaXpCc2xiUGVoVjUvNlRnejVTZkpBM0FYOE9P?=
 =?utf-8?B?OHdxMGwvelRobHdsRXgrYlVQd29UUlhxMUg3V1JEK09YRjB4RDA2ZmtaRzRD?=
 =?utf-8?B?VjJBM2gvMFNsck85OTBXRmZKTjVvcnRWK1YvdFdpc2ZOK2pXNkxUbzUrYW9K?=
 =?utf-8?B?UHpFNkVmQmpHak9ydlpCd1d2UGhiOTYxbjJwTjdVSEhDVHpiWjhCampKM2I4?=
 =?utf-8?B?a25ET3U0dmdLdzhLMDdodGdNcC85V3laQ3lQemx1M3RoVmc2MDlCOWxHWmlU?=
 =?utf-8?B?WW5keGhzMkZsWjBmOCtJbWs5T3VzOHFXQlFvNTlwVEc2YzBUV2RGTTA2Y0Fj?=
 =?utf-8?B?bE1NVWlIOXU1WS9DNXFHWmt5MzFkMk9ZRGdTK2M3R2VLZEx3TFNmaVlETVFZ?=
 =?utf-8?B?Z2FpREE1YU13Y2p5LzNKR3FvbW1LUUJWOFM3Y2FiOHVGOWNYN2NBRzZrbTJ5?=
 =?utf-8?B?K3JITXM4cXN6b1FNb3VGaFB6RmJ4MmxNMERGRXJZU0JwU3A4SFUvcFp2aXgr?=
 =?utf-8?B?Q1JqbGZDVGpDU1lleE9Mdmo5RGUyeDhUUlIvbkZ1TEk5ejRPNXdrSHFlOVZw?=
 =?utf-8?B?OWNqZHF4TloyOW1ETzRVOTdiL1REMk1DeTg2K1NkdzZGOUFGdVJOUGZFdUtC?=
 =?utf-8?B?WUV6VEZwMWdxeUVJZGtHQkkrYzZMald3eG1RYnlEN1VlclNlQS9CT0QrNDI5?=
 =?utf-8?B?YWNXZHIyWldTdWxNdS8wNzk2RjdROUxFbXRlY3kybXg0SmlSZFpNa2I3Tlpk?=
 =?utf-8?B?N0tRTm1vME5Jblk1Z0xScVVLcE9MZmRYeU94dTM4Q0Z3U0VQaml0QVVYTDN5?=
 =?utf-8?B?ZEM2YU9VY1p5OUY1ZXZ1N0Z5VjNFQnhlalN1SXJUTFI2RzN5MWJnVXdzUC9H?=
 =?utf-8?B?ODVBK0w2QVdSOE9MbllQcmtTc1ZtbS9wUStkdmZycXlJZ013V2VTclphRFB4?=
 =?utf-8?B?a1RLWmlycHYvOHVTaXc1RUNhaXMyd01ROWV2MUVxUlFzYjVJWVRQVzBQdVA3?=
 =?utf-8?B?UlhSdnBBTFgxOGd2S2d5ZmNnNGY1UjYrUzBjZnk2S2lDbTZDd0x6QWJiQWQv?=
 =?utf-8?B?VklSd1V6c1VBVE1jeWlBTUF4dXRXV2d4Q29KRDhxaExsVmZjQm5vM0dvV0s0?=
 =?utf-8?B?czhYOFRNUzhoLzNNUmlhL1E5ZFltVmc3cHhLaXB3MVRMSHpNNlBGbTkzbHgw?=
 =?utf-8?B?c0hqUW1KbG92MUdDYUhrT2w5MlVjK0liRFFtQStQWmJkeUpXZnFKZGd0bXhP?=
 =?utf-8?B?eTdlU1BPT3FmVENQTGZ5QVBOM2V4RXNmeGk3NUVVSnlNcm5MN2R5ZUIzRHkx?=
 =?utf-8?B?WjRzOVRDQXhUSzdrd05TbndTcXJrUnpRYytrSXlMRFdlRDk5bGtBakc3MGUy?=
 =?utf-8?B?SlUvUzNQVU1iMlM3VnlyL2NnZXpiU041UnNDRUtDbnQ5ZWVnOGtxZHNEK29i?=
 =?utf-8?B?LzBCTWM5OWh1UVBiVDJrYXROZmVXaXFvSHhxL0RWTU44aHlydFIrNWU5MDA5?=
 =?utf-8?B?WlFpN05OMis4UFFMa3hrZ0wwdjcrMWl3WmZKRHJqR3R2Tm9aWmZHQ3dKMlFp?=
 =?utf-8?B?V2I2ZzRuUWhkU2lJZlU2VDlWcmVIMC9tTlp1eS9XZkFwcjBOQ3NadHN1TEph?=
 =?utf-8?B?OEttUERXbkFNQVROM2NHRzg4MlhJc283elpMcDN0Nk9FZnFhOGxFb1R4R3Uz?=
 =?utf-8?B?UXJqZzNGUkhzb2p6bjRVUGthbERnTTkzWHBBVWVVdWNRSlB6NXozaHI5SjZI?=
 =?utf-8?B?NEEzVzRzUFJGRXJHSDJZL2dBMmxrelVQbEVoN1c2SnNOQm9VU1JxQVU2Q1ZR?=
 =?utf-8?B?WmVMSUJqOWE4aHFXbkdYMUloS2diZTlQdWtiMDNMMHVKdGtuWWlGN203eURJ?=
 =?utf-8?B?ZW50VjZzQ1F3MXlCNFBHNExiN3p5K3h6bWNnYkhGUTNKaktGSTV4cDVQVFBS?=
 =?utf-8?B?RVlqZzVXRWpMTlJiVkh0Yy82MHFsRkYxbjREc0t6bHlZQUFEMDlSSzljaXdv?=
 =?utf-8?B?NnFJcGZ3OVJScHhmT25TSnZ1ZFptWWxiZ1NTdHp5ZTNISE41SVVRWjhXcWlE?=
 =?utf-8?B?OGJxRUNPWit4VlgxVUdKQU1wN0tJL3NFRzRPaFFLRm9SNkNIem05d2ZQeHlL?=
 =?utf-8?B?ZGhQdi9TdXJDT0F5OU94R2pETGJrL1pTczNIa3ExMTlIeFQvcklNQT09?=
X-Exchange-RoutingPolicyChecked: mNvOtlIYjIzEIoclPcg6VoS7Ru8AeYudt323qIcJMF0ICPT7pGHmTUVbfdDA762hE69md21L1mnuRG73mztPnfAk+7c9p3G2GEb3Cj30GXK0o1tuvOd9p6GGob0+GfpE2j1EJiw5XkUaapfWd6BsSRuQZtT611jdbswicq7+m/rd8AXEziZ49ottYgAHI2pMzoALDrJZJU3/l2Rma5SrkaPfoMcC+5pwqoGuirk7h/1xSQQDZa7qZyvW7yWQ+SQG3mm5ouMgiwPJ5evUNjnsad3yR8hxOEN0Pa26rHo9Bid1l7unZV0ZGJ+14QAtwK/WSMlTjLBJPLRqX6vh1eyyqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c7513a-8dce-4299-cc7c-08dee3008651
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7955.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:07:33.0577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwT/WttpLBPC6oyAt7MQg5K06znPIITE6zs9XjmP8XbsG8mjLS1vIX+AmjtWfKrhvOF2tMjuX3aG/fb3jeTTMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
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


On 09-07-2026 14:52, Raag Jadav wrote:
> On Thu, Jul 09, 2026 at 10:45:27AM +0530, Tauro, Riana wrote:
>> On 09-07-2026 01:51, Rodrigo Vivi wrote:
>>> On Tue, Jul 07, 2026 at 12:02:11PM +0530, Tauro, Riana wrote:
>>>> Hi Rodrigo/Jakub/Aravind
>>>>
>>>> Please let me know if you have any feedback for this patch or can you please
>>>> ack this if it looks good to you.
>>> I looks good to me, but could you please double check the sashiko's comments?
>> Sashiko has a comment regarding namespaces
>>
>> [Severity: Medium]Since the generic netlink family explicitly supports
>> multiple networknamespaces by setting .netnsok = true,
>>   will hardcoding init_net hereprevent listeners in non-init namespaces from
>> receiving error events
>>
>> .netnsok = true is auto generated not explicitly added in code.
> Because that's what ynl_gen_c.py does without it being parsed from
> anywhere.
>
>> But from what i see, drm device is present in the host and not replicated
>> across namespaces
>> and most of the non-network implementations use inet.  (ex: Binder)
>> If this really needs a fix, we can drop the has_listeners suggested by raag
>> in previous patch.
>> I don't think in an error path, allocating a new buffer would be a big
>> overhead if listeners are not present.
> I don't know enough about namespaces to comment on this. I'll rely on
> Jakub's disposition if netnsok is relevant here, or needed at all for
> our usecase.


I tried to find out more about network namespaces.  Network namespaces 
are created everytime docker is run without --network host.
With this patch, event notifications are not received in docker env 
though other commands work correctly.

Since this is a valid usecase for drm, removing has_listeners as it is a 
small overhead in error path and replacing genlmsg_multicast with
genlmsg_multicast_allns.

Thanks
Riana


>
> Raag
