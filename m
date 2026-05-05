Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA35FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0357D10EA51;
	Tue,  5 May 2026 10:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CGZTcQyT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D5610EA46;
 Tue,  5 May 2026 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777976242; x=1809512242;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Mf4MJXHGSeVu2JwzCTV2RWBzLDOX68bqudYXNKnGn+A=;
 b=CGZTcQyTt8+K1IAaqVdaYk/toooRqD9jxxZ1lNVicoiF7Gqk5q3l72hK
 TVFFGCSHolMBs/4x8Fv1mvoOTTs6+P9oV0MyElG62pVyK1QL9kJ6xBcZh
 NregCO5CGZBiIFk0oMyihSwRv5Bpgq122FAm62ep+c7p7L0sKsJ+wAylY
 dIkXiqAfwxZd/Y/aUDJCXI0FJV07IccqDQPup+Zq6kb7zV+jD8TD1krpW
 FTfZMtZ+aCcejeDO7+dMP/mkl22BNGx2NK5renj5l48rKtSPgb4ML1Y19
 CIt0VGJGDyilleWlrZGJgs2xzWUmK8bD3ovynlbRB81xA+8FzKNbe41/j A==;
X-CSE-ConnectionGUID: 2NaT64daS4eqJjOyUxKD9w==
X-CSE-MsgGUID: 9L97A2XBQfOPOCE7Ja7OOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89540078"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89540078"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:17:21 -0700
X-CSE-ConnectionGUID: IQKnAjRQS3qsswxwqvUdoA==
X-CSE-MsgGUID: Jqc8ZnOiRy6skGE5JkhVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="235647159"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:17:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:17:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 03:17:20 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 03:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyd2tgoy1l47OpNYWTGsf9II0TSIChBr4m6mEeMHSevguaMz5GtxNHmSo3UMMwQn/v2E88I7MPVCdF8I9EcB+Yj9KZtDP9nXcA8AqQk4tliK7y2HBBUbpeqi5uSWXJ+AdUvt8vLlCCJlepnuY0zhwrqsIemxYXcTyS2jhzBf8Nv7R9TDAE7veA3NFcOUQcz5i6vrlKILZXFRD/onLXfERZEtcLfBHWUNxWSvmJsjSh2xMTJjNT7PWDKQvEJoBvk/71iMqL1SiO9vdjmX6fSNaHF0+HxpxSEphjIi+DBFxBaLL5PZ5upKdKSzHIY9bsk2wj1uzKv28rz99Vt/PysHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsSGInnynjIyo9pRy7SYmzHHMCloTvYLb5bk+2mZXU4=;
 b=jVOyt3djNcOXu0p91hF8MiZ7icWllUmR06OSQuXds44vS9+pDAT9GTiTRb2ySclCmxEG4jzN8olyOk1AinLmR6jWCzhUPZvE88X7ginNRewhUQdKxHt7irQCYfWGGIzmldMzZE9yDPO78aUEZpsEc71TYt/zeDIFKUKWorCowXXjLvscrhiDzvMBKbxMJ17soL6iYrtjmsP56xoAYLEsvs5nY6gWC1YbORrfXplionFd9d5lzJf5QcfupOyY0/SX37tUWOYwZL4oMtXyyNn2TUCmkV1SZSfLMs/UXoxAqTkIMjTB738emP9TXVIOr93mibFoDrHJfKhhMXtUKzt+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:17:18 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:17:18 +0000
Message-ID: <bcf8f79b-33c7-4c42-9914-64d7b0c72018@intel.com>
Date: Tue, 5 May 2026 15:47:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/9] drm/colorop: Add limited-range YUV-to-RGB CSC
 FF enum values
Content-Language: en-GB
To: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-3-harry.wentland@amd.com>
 <1fe865c5-3f82-4178-a88e-88a6837a4819@intel.com>
 <7acc6e90-63e7-4c09-9944-502006c77f28@amd.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <7acc6e90-63e7-4c09-9944-502006c77f28@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::34) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: ad65159e-913a-4a08-d9b0-08deaa8f7c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: vzDlhNpyUpPa0C32Uu3z4N2eQSmV90cv7/8amlcDQnwcgnW/3eKh/fmZlPE5wUj+X6WGxE1RgzpUScPOaA5HqWBJTU9if2Wltq1oXcI0H9sOmR190Hke+LWV9/oDjExApOYpI1643s79h1uc3wMIUPFOcf6JO5ynk1Gquz0SsgX7mFCGgdngpIbpPnEIcwBzpL8fTCmz5PfUtt8i7jjMDznnuyP1cpxVm6bqKLoKU40GfarIw9fWzkXeYX1PUG5u0xquGXR9+ksd9+Txmv9HQwRinyG8ZKyJt3Jw6+GLQ7Z0VfutLFPjSI2U9RFbhlHj6Y3rZTag/Ddded+Zd6GxywahrCFpdpYlzoR4ZVfDieyXXTAKYiLWG+YBQhgpk0aTo6DWpyqhGF1uQ7vOEERaxG54OLf6PYT9r8iykbgRHfVNIelBvWnSYxOCbBbPgAH6QXedBg4mE1wvViHJHvxRdUUjFQy3ripa1gCIh+hbiF4F0jBtlT2Xz6rwpvCpq5V2YfemNf9rDL8JhWlCcrYawcFR8Nm5lC+qFs2NS7dhlY1Y3ue6grqekW3zfMI/eIElMrbB4Mcb3BrCkIyUH68AdWJScnWKcGcKiqH7ydQFwWHbe61Mr5OaF9e+KJ06mvgrI3U5Zz+Qoq2T2RfknP45x6F7uT3tF8cdQqb+/0REh2cXbOZLr7RtF7D4jDAFsH4h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZrQ2RQUlpvbkdNMTJKMmxYZFRId2NtNStuNUVhM0twUjBCNnJqQ0FINlhr?=
 =?utf-8?B?N3hqbXJZQU9xaGdxeHQ5dWNYaU1IN3M5dFFIL2p6UVdmOExTV2pveXptdFE0?=
 =?utf-8?B?RnRIVWpCQUY3clpqdEN5OTBSeHNGTkx6WVBoTkZJSFNlTUROQkhqWmRSQmJE?=
 =?utf-8?B?d1pXbUlSTWZVZTgyekJGNWhjVkoyQ25zRFFETndwV0lLc3RvUUF3TldFQUNs?=
 =?utf-8?B?aDVmUG5uRnNwVW1CMDZsSjl1TUZ2TnpjR3huWkNicnBWbjc2VVNrTlVvTzVD?=
 =?utf-8?B?OWQ5R3oySkdhTkJKMmxHZzRMM29yOVFEZ3JnT2VFNDI5UkJWL0dxcmZXOWEv?=
 =?utf-8?B?Nm9ISXd6bUV2M3IrdHg4akRtOEd1UXhIdzZxMEFOYVk1WlE4eVRvdlZJcCtR?=
 =?utf-8?B?TjVDWHVjeDBvZ2pya2VDK0dTZW1DeVVsVGdWV0taejI5WXlYM09DN1lLVXVM?=
 =?utf-8?B?ZmVUekpqRCs0eUFNK1NQTkplUzQzWkZNamNwZXhQY05WTStVTG5KaXpZalpN?=
 =?utf-8?B?WnRqWENtN0RpMWVBSmdZYkY2QUNHNmJ6SGQyQWpObjJhdW5SZzd0OHMxRGti?=
 =?utf-8?B?WnNyTktRMFdKaWJQcVRrTGJNbTcwa0lXLytXbDhFTDR3MkZkS0ltd010Q2do?=
 =?utf-8?B?dWZtd2FqeFJqNkN1eFcxa2x6V1lTbld0REFQZXM4WllZNnJlNG5waDduZy9i?=
 =?utf-8?B?YXU4T3BwKzBKYmlEVzdQQ0FONzZSQjRBVC9Zd1owLzV5Zk95dHZTYnowcnZ0?=
 =?utf-8?B?RUtkQVEzMWkyMGJuZTU4RnN0Q1p3MkdidVhNNEhFaFlMWUQ2VVR4cC9HVW5o?=
 =?utf-8?B?WkE5dmVZVDQ5Vno1VFdheWM1VTlDVVZjczBSM2oyWjFuUlZETGZNL3F1TDRW?=
 =?utf-8?B?UU5JbWV4cEt3WTNKODB0eTQ1aTlDZEhyOHcrZVRXQVRKNEZyMi9pWXhXS2hP?=
 =?utf-8?B?YStKblpzalZpa0NPQXpwWkJxcmtYcDNSREQvOUxFYUMxOC90Mjc4RFZzekFB?=
 =?utf-8?B?QTlNVlBHK3BpRXVhMm1yckYzRTg4RHhiWUduQnVOYTNIVFVWYlhmYytMSHJC?=
 =?utf-8?B?blVHekhUQkxROUlaNENOc3VYcUZLYWFlRHM5WExwZFNYRmxYekpIcHRVTE1s?=
 =?utf-8?B?N0VlVi96TGpheDdSemJYYXNVZk1rTytQOXJ4L2tJZEhvWjlPd0tCdmxyTlVh?=
 =?utf-8?B?bFFsUU12VW9zd2JMT0RTaUZDZGwrakFJS0pRMXdQaWNaa1U4bUFwRlVEU01i?=
 =?utf-8?B?bTNROUJiR2JwWFVoRHZpNXkrMk1relpQN2JwOWRDM3RONnlRcTJKMlhsSGNJ?=
 =?utf-8?B?NXdMM1J3Qm85ZklsWlRXT1RQNkpDKzF1QXkwWXg0czdaNXMxblo5dFB0VFk4?=
 =?utf-8?B?d3VFZGJVaWFhM05yOENmbXBzZ1J5a20rMHcwbU9jNWpMNFd6WTlKbnNMcnQ1?=
 =?utf-8?B?S3FZVzh2QUJicmZydHJteTNvR3ZCTjVCelVyeVVuQlRSdVA3dXQ4K2JaanpB?=
 =?utf-8?B?RGs5RDFKWEIzdXlEZ1J6b2hzQnBPVFVTdVhsem9melRHTjJtT21YR2pUUGxH?=
 =?utf-8?B?T3hzdGZlVnJLMFY1Wlc5MVlVYlhBOUZ4SGRsZng4aTh5Vmp3Tk94T3ZFaXlH?=
 =?utf-8?B?blg1UjZTMHgwZmhYdGNmcU1TQ0s1eXpCdUIveXNnVk5ubGs2cjF4L1VERC9h?=
 =?utf-8?B?ckZHOVpBbnFzMmswSmo3UTRLRml4WXBqQ1lORFZ4UXJSL1ArSG1uTW5TL2di?=
 =?utf-8?B?UFZzSVV3YUZLK0V6QUw2MldJZUlBMWt5NjJmZzR1ZHZ2ditHQVdwTEJGZ3Nj?=
 =?utf-8?B?Vk43UkxhM2VMakdZRThmYkYyVWdnVFNRbWdWd2djUmV4aGRza3JGN2dJblQ1?=
 =?utf-8?B?ZjUzcjFITG1uN3VJUjNrR3UySjBZaVhYUU5uV05KNFJ5bEgrdzRiV21yV21W?=
 =?utf-8?B?K2pzTVF1cWFYa0ZLV0xHcUpyM09nQTNzTnVEVEg0QndBNzJBdGdxakRqRzRF?=
 =?utf-8?B?blhRZjYzLzRGVE9nRG1PRy8vTWVjeEZ6eDZVQlBWVkV1UjJhUDVhTXAxajhj?=
 =?utf-8?B?dEduTENkMFpoMVI5Uy84bUlaRVQyNGw1YzZoS1c1WWQrQ3E3NVZWYmNQbnc2?=
 =?utf-8?B?RG5IejJGRUdFU3M1a1N6dlRmanJKZW9YVDlSWFBzRTZiN3ZNeG85Wk5rRmdI?=
 =?utf-8?B?dSs3dzJoSWp6RHJOeEpnc3ZjYUxaak02d0tCT1Z3ZVBNanp0VFdyWHpqSjVL?=
 =?utf-8?B?VlZISlR3UGxvZmZtVG1hUUpYQmpmWUJaRm9XanRCL1J5em15OXVIdktjdnlk?=
 =?utf-8?B?b1hDYWFnUkF6OVpQTHZRL251emxLRk8vN2Y1ajZJNzVnS0NBUk1VMjJSQzJp?=
 =?utf-8?Q?rnoEdLLvlppSWqnA=3D?=
X-Exchange-RoutingPolicyChecked: ZhKxZEm1nl2p4RpVVI2Zxq6YfSVVJl74L5UTJCixnbaW2X2wCqqSImqTHvlmQI7ARdkJloAl39phBRrSLXU2SVi1FIvbjrz2MGc+V2/DWTrwJdHlUBUtcuy5MjE91z+SKriySfjQtqOI+NyrPgN5GaqnmcBJx+4SVIYcA7SHnwCDGfx+UBlAYI9TUCKbbwIihMMxYYwmOC83WMdyUezpBrNXkQKFzzF1+95oiZayViaBj1LH63EGs94edwkccQRFPDL+tIJRYyvxvk0KmBx2zu+BOUXw5YEtPG52z5C6P5cgJbvP5Pjkefe96Dr1X+VnHxERHdlWvaybuTNfdPdTXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad65159e-913a-4a08-d9b0-08deaa8f7c6e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:17:18.1365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMImrrYDunijER6WaBY1U8I72lyB8wRRqWs8r/izt5W/D5ThxW7PMRlXWq0NfkYMKqTgeRrnyUz0LCG5H51UdVdCsDcoFurqOuoKZl6coQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
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



On 4/30/2026 11:49 PM, Harry Wentland wrote:
> 
> 
> On 2026-04-23 05:34, Borah, Chaitanya Kumar wrote:
>>
>>
>> On 3/30/2026 9:04 PM, Harry Wentland wrote:
>>> Add three new limited-range YUV-to-RGB conversion presets to the
>>> CSC Fixed-Function colorop enum:
>>>
>>>     - DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601
>>>     - DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709
>>>     - DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020
>>>
>>> The existing full-range enums (YUV601_RGB601, YUV709_RGB709,
>>> YUV2020_RGB2020) are kept as-is. The limited-range variants are
>>> inserted after their corresponding full-range entries.
>>>
>>> This gives drivers the ability to advertise support for both full
>>> and limited range YCbCr framebuffers via the color pipeline,
>>> replacing the need for separate COLOR_ENCODING and COLOR_RANGE
>>> properties on the CSC colorop.
>>>
>>> Assisted-by Claude:claude-opus-4.6
>>>
>>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>> ---
>>>    drivers/gpu/drm/drm_colorop.c | 11 +++++----
>>>    include/drm/drm_colorop.h     | 42 ++++++++++++++++++++++++++++++-----
>>>    2 files changed, 43 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>>> index 6a345e2e8b15..f0d11cf7e3cd 100644
>>> --- a/drivers/gpu/drm/drm_colorop.c
>>> +++ b/drivers/gpu/drm/drm_colorop.c
>>> @@ -92,10 +92,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>>>    };
>>>      static const char * const colorop_csc_ff_type_names[] = {
>>> -    [DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
>>> -    [DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
>>> -    [DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
>>> -    [DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
>>> +    [DRM_COLOROP_CSC_FF_YUV601_RGB601]           = "YUV601 to RGB601",
>>> +    [DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601]    = "YUV601 Limited to RGB601",
>>> +    [DRM_COLOROP_CSC_FF_YUV709_RGB709]            = "YUV709 to RGB709",
>>> +    [DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709]    = "YUV709 Limited to RGB709",
>>> +    [DRM_COLOROP_CSC_FF_YUV2020_RGB2020]          = "YUV2020 to RGB2020",
>>> +    [DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020]  = "YUV2020 Limited to RGB2020",
>>> +    [DRM_COLOROP_CSC_FF_RGB709_RGB2020]           = "RGB709 to RGB2020",
>>
>> As I understand, all combinations of input/output ranges are mathematically valid (e.g., “YCbCr XXX Limited → RGB Limited” or “YCbCr XXX Full → RGB Limited”).
>>
>> I am not sure how widespread such use-cases are but will it be prudent to have the enums be named as "YCbCrXXX <range> to RGB <range>"?
> 
> I'm not sure how likely it would be that anyone would need to convert to RGB limited. I'd prefer to keep things simpler for now. If anyone does need to add enums for conversion to limited RGB they could always add _RGB_LIMITED variations of the enums in the future.
> 

Alright makes sense, I will stick to the "RGB" == "RGB Full" nomencature.

Thank you.

==

Chaitanya

> Harry
> 
>>
>> ==
>> Chaitanya
>>
>>>    };
>>>      /* Init Helpers */
>>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>>> index 2cd8e0779c2a..c414b9070afb 100644
>>> --- a/include/drm/drm_colorop.h
>>> +++ b/include/drm/drm_colorop.h
>>> @@ -145,31 +145,61 @@ enum drm_colorop_csc_ff_type {
>>>         *
>>>         * enum string "YUV601 to RGB601"
>>>         *
>>> -     * Selects the fixed-function CSC preset that converts YUV
>>> -     * (BT.601) colorimetry to RGB (BT.601).
>>> +     * Selects the fixed-function CSC preset that converts full-range
>>> +     * YUV (BT.601) colorimetry to RGB (BT.601).
>>>         */
>>>        DRM_COLOROP_CSC_FF_YUV601_RGB601,
>>>    +    /**
>>> +     * @DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
>>> +     *
>>> +     * enum string "YUV601 Limited to RGB601"
>>> +     *
>>> +     * Selects the fixed-function CSC preset that converts limited-range
>>> +     * YUV (BT.601) colorimetry to RGB (BT.601).
>>> +     */
>>> +    DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601,
>>> +
>>>        /**
>>>         * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
>>>         *
>>>         * enum string "YUV709 to RGB709"
>>>         *
>>> -     * Selects the fixed-function CSC preset that converts YUV
>>> -     * (BT.709) colorimetry to RGB (BT.709).
>>> +     * Selects the fixed-function CSC preset that converts full-range
>>> +     * YUV (BT.709) colorimetry to RGB (BT.709).
>>>         */
>>>        DRM_COLOROP_CSC_FF_YUV709_RGB709,
>>>    +    /**
>>> +     * @DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
>>> +     *
>>> +     * enum string "YUV709 Limited to RGB709"
>>> +     *
>>> +     * Selects the fixed-function CSC preset that converts limited-range
>>> +     * YUV (BT.709) colorimetry to RGB (BT.709).
>>> +     */
>>> +    DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709,
>>> +
>>>        /**
>>>         * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
>>>         *
>>>         * enum string "YUV2020 to RGB2020"
>>>         *
>>> -     * Selects the fixed-function CSC preset that converts YUV
>>> -     * (BT.2020) colorimetry to RGB (BT.2020).
>>> +     * Selects the fixed-function CSC preset that converts full-range
>>> +     * YUV (BT.2020) colorimetry to RGB (BT.2020).
>>>         */
>>>        DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
>>>    +    /**
>>> +     * @DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
>>> +     *
>>> +     * enum string "YUV2020 Limited to RGB2020"
>>> +     *
>>> +     * Selects the fixed-function CSC preset that converts limited-range
>>> +     * YUV (BT.2020) colorimetry to RGB (BT.2020).
>>> +     */
>>> +    DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020,
>>> +
>>>        /**
>>>         * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
>>>         *
>>
> 

