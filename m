Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A510C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501BA10EC34;
	Tue,  1 Sep 2026 09:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iAO2J9+V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857D110EC2F;
 Tue,  1 Sep 2026 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788253684; x=1819789684;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BRjsyu/NlnDYvTysn2ep9lx9yp0OmO/JicYHMv7rkhE=;
 b=iAO2J9+VRvMI0oyDyZ9DlnLi2L5XSZHQkOngvUozOyy4kDbrPbsZv2Ru
 O29HCUuBId5tJotGd826aJklmo0DrHG56vSIPYJpK37Zs5OUkI/Z7QIPL
 4RMzpcDZEOEPwLHrS1YZPvWO0jMGKCZnMsVofvOYkAwg0QlcwHx58agr3
 XKCBe6yQQUd+9PGU9BiyQ6+9u+f0FuQQ1tZ9+RNEsJwxYv1B68Zr123vc
 KMpdA+dN6YkQFIMqwm+8yI7crxKRIKiSD09BNhRjjPTRpa2IIWieZtXk/
 C7bljGDWGGoYVjEZ+dqzJEjroaUzw2OmNji+/YOrDDjWFHZFuxuAlyVG0 w==;
X-CSE-ConnectionGUID: aHKvZvEwT2iyV4Bjd63QdA==
X-CSE-MsgGUID: L+Q06BPuSKmf7bprUN91XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88725830"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88725830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:08:00 -0700
X-CSE-ConnectionGUID: c0Bz1rhnSnODA+QWQnZ6KQ==
X-CSE-MsgGUID: AQeztdGFQrOM+lbvaOUT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="267254866"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 02:07:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:07:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 02:07:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 02:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utH8kkX3wK1KTZiR3ADzPd184mzhA6PzoB3cDzOq3/YuRBVu7l5CYCHDg5DTCmINawN8gAc2TU0EUWyFG0ZcR2IqPd7cG+B0rxQyiQqi+jIJox8BqS/lM9qsg2UXKJg4REX7VdyCrmIayg0YbyofqK4glDqUguwqYbUUvuiFPUd0ZykEsz9zxfxY2PTQpYyTmyaXMsXSkazrUt1Nvq92kl0Zdm0G4C+UAi/CjAAuK5VjzkDWepGDJHg0DQnsmvP/tMgylapC8CskY/AwIjKGtgUAkycSJmiy/PlDeTBRdvD1LsBFsYR0QuUZJUDmcwtDIPAqX6iQipq3o5BbhCMU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jhTw/HMl7mUb3hRXofh/NsB/MHLgFYu7rSHoY+toj4=;
 b=XXab6tpP+1gNaXDhJJkt+EoIsN9JbR9EUgXZ2bG3l954ozczfUiQH7X1/n6PXrEFjJepD7etERjjvUn+gkpd3awZ8MfmWXzSaIg4BAhVsho2RED52D4sFwWGBldggmfkxgxifxoWWmjf7O4yhnHhB5RqwbdHp2tPOrRXffjSVvg3Zk/HnNi5ZjBz7xzGGK8mKAVSQED+ZXYI0nrOOS56/EdxbU0rrPMeNNRW4gw+j0WG9xEYS/dUVhxiNr09rqg6oZBPCjmhD6I586HyzfYGFEGukIefAxbPZMTWucQVIWoCUGbG1nns1EDVSeJPg6jNuNPqMmiIA4jt/qtd/hXDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH7PR11MB8010.namprd11.prod.outlook.com (2603:10b6:510:249::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:07:54 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:07:54 +0000
Message-ID: <6b71a97c-b44b-448e-a57b-4b646727dd6f@intel.com>
Date: Tue, 1 Sep 2026 14:37:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/xe/irq: Serialize IRQ suspend and resume
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-9-arvind.yadav@intel.com>
 <apXswR3F21zg0DOS@intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apXswR3F21zg0DOS@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::13) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH7PR11MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa8938d-c3fa-4405-64c9-08df080881c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LW6JomOSermuIV/Vkki08QlKBj/ZqVbBeZJDop+NUZIoPYztqip0UctC6ZFZxdarv4Fuwnqxu4Vn87+Op//ovuREt0TbaF0zzdUzwKrYSov1wS3cesHmfooQvuOGP8AJi2Ldcl7Z/aWoFGHAZA2ZiX67qZzA6SQmoNoyvvVASTAQax9qegmBCZ1Udmb5JOvtRYf2IR3tKNgMV/8X1qEXa7HLij3zt5MxWoFXUbNwLFYgh3/uSQXLJdDsqAiNVpHO/qNz8laRMdwxOJBlj/J9Fw3YLh5fSLYUC+Z8HZ78nmQzJrox3C8Zo/9HbwajdokDHM+970S3gw4+gn6FApjyZ6iXrHtE15jYT0392e6/VBozDAg2QBV21EdN1kMlJbyONHRX8/Ym7zJ6JyrFBnq+ZKJushY4VBX08ZzUk9zIkecsimx8cAN4xuITcxunu9XlFV/tnXcRwlpHQhuGHLK36ND6rKYcGPhYW/dhcLb3U8SOm8ys+zivAuEmaOLJgsmn2oNJAXMbjwZ912Yn4ZjluGx6uxU1ocAl0wh2iAh0oNPeuOEsgT9W2xviGOV1SA/Cf1MGXJ6xv5b/HJwOu5TIf/Jb4jC7MU1/rpMKiTkPe8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlmTmhUODlvMDQxT0ROeENlcEtmeFJzRmtlQkp5ZnRmbkh6YWxYczBXOTNt?=
 =?utf-8?B?NG1qV0RzT0FVR1pYdnVEQml4STYzTmtaOW9ZeFhqM09yR0hJV3l2djdyS2t0?=
 =?utf-8?B?RnFvb05XdmZUNUlkblNFbWo5bjR2eEV6YytUVW8ycHdYUHFlQVpPZElTVjJO?=
 =?utf-8?B?cVRKbk44dlVicHlOWDQvSmtxUVdnN0VtOUc1QU16WHB4NElZZzcxZVJBK2Ez?=
 =?utf-8?B?ZkRVSC9lYXQ5MTgzY25aYk9ydVRLZHBVSGcxb1VVOFNibk11MzM3KzJ0aEtX?=
 =?utf-8?B?N0pteStFQjBveHk1SVBVZXVKN2lVeEo1bkVCc2NEckpwTVdSSmJxaVZMTHZD?=
 =?utf-8?B?Q0JYdzIwRUtXMmdaVzdlUXVTOUdWWkZaZ2xheWpqaFZDVHFlK3M4c2MvOUN6?=
 =?utf-8?B?eUIzRVljcVV4cm9mTWhaNFlycnVCa3BKSDhxVlNLNCttSXlPRm5nbVNldFAr?=
 =?utf-8?B?QWlsY1lmSy9vYXJTcHRJL3RiYXR5R3o4eFhTWkE0U21tS3lUc1dPQ3gvRE9P?=
 =?utf-8?B?MWhLd3BHZ2F5bUVlVU5jOSs4NUlXakJsZ2NSd0JCZnNSSmFLS3pHeTA2d1NF?=
 =?utf-8?B?SHp3ZG9UUzliOXR2QkQveUJVcnpGV2Fpb1BjTldlZFdPUWxlQnRFTDlUaG1U?=
 =?utf-8?B?OWxnUWNaclVxbCtTMUZJU3dNOHZ0VXdrKzJpdW5FSEorUmJuUzJBK1A2STgz?=
 =?utf-8?B?YzRZN0x0SnYxcFUzZElWK1JveWFubk1pRmYraGd0akJjZ24rNWlmMkZ2ZEFL?=
 =?utf-8?B?WVV1aWE3MUtQZVBpbzJKVE5DOUJTZmRJWmxMdzFIY0hjRVlkYW9aaU1MQWNn?=
 =?utf-8?B?d3hoejc1V0J6ajNDdUsyWGtNYk4xWnlydXRZZFgvZTZMSWVsb3hYa2o0czZE?=
 =?utf-8?B?emhKM1V1NlJIZ1o4WDdVcmVHVWpIbHY1N24zaFZueU5PWU1xd3NjY2RYbXpH?=
 =?utf-8?B?SHlDQ2VYclI2V3paNWlzSlZzSHpSUUNicWdCbXJCS3BzY2MrbDYrR1UzTDRT?=
 =?utf-8?B?SU5yQkkzeDdMTEhrVnpEQy9yeFlsRHVKMG1ZaWJ0WWlweHFKazhYYmJ3d2pp?=
 =?utf-8?B?RHRKa1FHdDBpQWFObm1sRkgrcFhaTzJVYVJDYlJaYTJHTjRsUzMvdVpIK1Z4?=
 =?utf-8?B?dGxZVFc3ajB0Z3h3dEs2ekl3SXJPWVlJczhMcVYxVmZ6WWRUQVRQYzRTUUF1?=
 =?utf-8?B?ME5nMmNBMXd4dEk3VkdYWmxxL3RRcVBkSXZjcFNBTVplMDFjSnF5Y0pnK2F4?=
 =?utf-8?B?MzBzRDhIMlBQak1OVTcrSTdCd2xUeUM2SStRWHVyUUNFTnRRcjh2VGZtckFs?=
 =?utf-8?B?UEw0WEtORGZtZDl6dHJWdndQUFZwU1BSY2lIMEN1ZmlWR3A3djJxMDhHdy9w?=
 =?utf-8?B?ZEg2ckdySnJYVm1LTUVpUzZUaktLVE9ZV0VYYWlsZ0pRaUVEalhmTEhMcGo4?=
 =?utf-8?B?T2JjclI5R3hVWklDaU93d0FKOTNVb29Hd3hobHBPYkF3a3VieWdmOUxzYTZB?=
 =?utf-8?B?NkgwcTFMazMyTmNSdEZ4Y2dsQlNmU29nQUowVjZLVVp6SEdYdjNFT2lSNmVC?=
 =?utf-8?B?Sk1vVXBhZEdVOU05N3lnaHp6MUswejA4SWJ3ZlgvNXV3M1N5bVFXcHRwYWNK?=
 =?utf-8?B?aEZIZStsaUVrcDg0cTBFUnVoRXR2emJhSkVSYmxaalV3T21US21PVmFzUUU4?=
 =?utf-8?B?YWNxYndRaXgzME5qc1BMODRoOW8yQndSdEFuemxxRGtzSVIrdUJ1QXY4TGto?=
 =?utf-8?B?dXB5US9vT045THBlOW5MNnpYNUFnZHFRNm1PREZJSGQwZldQUnBhNTJyUWRo?=
 =?utf-8?B?QTVkSWhxeTE1WDhJY3J5UGNTWDRJd0VXNi9Ya2s2U0Z0TzdWYVV0Zm4xNGlz?=
 =?utf-8?B?dFlUV2REYUcyQkpQRC9lYk5OZ3l1SUtsckp5RDFyamFEQjM0K2IzSWE2Z3hF?=
 =?utf-8?B?dWJ4RnJtYjZaYnc4bXBZUXhVaEVBcEFUZDlIc3FTYm11NkNHbHNCcUcvbFZH?=
 =?utf-8?B?YmYybDRhR2NJdUMwYWRTaWNReXB4Z3dNQUVjNDFkaGpnMjJpRUI2N2ljb2VT?=
 =?utf-8?B?bldYbGkzMWlvZEpERys4QmFnOTA3KzlPN2QwOWRKL0p6ejI0ZE9TL29tN1lQ?=
 =?utf-8?B?endsZVdFTSs5cEtRaGRKUGV3U3JWbkVaOTFWM2VIRmhjeTV0Y1hyUXlQYUtR?=
 =?utf-8?B?OHNmMHpKNWpqQU8xcDF0elErZWR4WHNEbWJxODNjL0NyYjg5UnNWRHZMV1Y5?=
 =?utf-8?B?REI3Z082bVBFaU9qckcrYXd4U1d3THVKWlExZGdsdEQzSDJSY1VkWG9BbHFn?=
 =?utf-8?B?S3ZIYmdRd2loRHlNR05wYmIxZzRNYXNtOW1IZXVwS3BHYmk0SFg3Zz09?=
X-Exchange-RoutingPolicyChecked: ogTiNBQTyJ/9LrjptUx3/1nxGzFWFipkDfH64gOOZVrNVebLZMPwhC042255iEB3Pm3fa3cxVvce9cV3Ad4GGd6IWaVPdupaMWRqtI5a0TsWbdl9WIQw08ZE704Gr8bQQpYMvaLn+cDIp8CdtOvdPCJIQkUxYrOekHK878csKIu+xHkPKXfaTNv4hywtj/7D+ptU/3DvaAW+nJc1h59TaAkXGbmnjOCK18C93ArWtfxR7uHco1NTSU6ngyLi2rp7EURSYVNdnWCBWP0u8qE4QL137ZKkskVNrdUWOi17gOAB4UBHzFGKp8Hh1JTH/kIR6ZljdYdNssYLDV9UW5In6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa8938d-c3fa-4405-64c9-08df080881c4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:07:54.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x7Ay/E95E3/UHOxPYcX0o8BxzGJw5uW7h02aDS5aWlWvk99y61RXKf4RejEHbAGGRhTMdo94TSsB+f9Vqp9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
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


On 01-09-2026 02:36, Rodrigo Vivi wrote:
> On Thu, Aug 27, 2026 at 03:47:56PM +0530, Arvind Yadav wrote:
>> Wedge isolation suspends interrupts from a worker. This can race with
>> PM resume and allow resume to enable interrupts after isolation has
>> disabled them.
>>
>> Add a managed mutex around IRQ suspend and resume. Check the wedged state
>> while holding the mutex so either ordering leaves interrupts disabled.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
>>   drivers/gpu/drm/xe/xe_irq.c          | 26 +++++++++++++++++++++++---
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>> index 43a86564adf0..dda4d9919ca6 100644
>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> @@ -6,6 +6,7 @@
>>   #ifndef _XE_DEVICE_TYPES_H_
>>   #define _XE_DEVICE_TYPES_H_
>>   
>> +#include <linux/mutex.h>
>>   #include <linux/pci.h>
>>   #include <linux/srcu.h>
>>   
>> @@ -266,6 +267,9 @@ struct xe_device {
>>   		/** @irq.lock: lock for processing irq's on this device */
>>   		spinlock_t lock;
>>   
>> +		/** @irq.pm_lock: Serializes IRQ suspend and resume */
>> +		struct mutex pm_lock;
>> +
>>   		/** @irq.enabled: interrupts enabled on this device */
>>   		atomic_t enabled;
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
>> index d314993b14a1..9cdcb16f3ca8 100644
>> --- a/drivers/gpu/drm/xe/xe_irq.c
>> +++ b/drivers/gpu/drm/xe/xe_irq.c
>> @@ -797,8 +797,14 @@ static void irq_uninstall(void *arg)
>>   
>>   int xe_irq_init(struct xe_device *xe)
>>   {
>> +	int err;
>> +
>>   	spin_lock_init(&xe->irq.lock);
>>   
>> +	err = drmm_mutex_init(&xe->drm, &xe->irq.pm_lock);
>> +	if (err)
>> +		return err;
>> +
>>   	return xe_irq_msix_init(xe);
>>   }
>>   
>> @@ -843,6 +849,8 @@ static void xe_irq_msi_synchronize_irq(struct xe_device *xe)
>>   
>>   void xe_irq_suspend(struct xe_device *xe)
>>   {
>> +	mutex_lock(&xe->irq.pm_lock);
>> +
>>   	atomic_set(&xe->irq.enabled, 0); /* no new irqs */
>>   
>>   	/* flush irqs */
>> @@ -851,6 +859,8 @@ void xe_irq_suspend(struct xe_device *xe)
>>   	else
>>   		xe_irq_msi_synchronize_irq(xe);
>>   	xe_irq_reset(xe); /* turn irqs off */
>> +
>> +	mutex_unlock(&xe->irq.pm_lock);
>>   }
>>   
>>   void xe_irq_resume(struct xe_device *xe)
>> @@ -858,10 +868,17 @@ void xe_irq_resume(struct xe_device *xe)
>>   	struct xe_gt *gt;
>>   	int id;
>>   
>> +	mutex_lock(&xe->irq.pm_lock);
>> +
>> +	if (xe_device_wedged(xe))
>> +		goto out_unlock;
>> +
>>   	/*
>> -	 * lock not needed:
>> -	 * 1. no irq will arrive before the postinstall
>> -	 * 2. display is not yet resumed
>> +	 * pm_lock serializes resume against wedge isolation.
> if we are using mutex to serialize code we are doing it wrong.
> worth reading:  https://blog.ffwll.ch/2022/08/locking-hierarchy.html


Thanks for pointing this out.  The mutex protects the state around 
irq.enabled, not the suspend/resume functions.
I guess the current mutex name and commit message do not make this 
clear. So I will  rename it to state_lock and update the comments and 
commit message to make this clearer.

Thanks,
Arvind

>
>> +	 *
>> +	 * irq.lock is not needed because:
>> +	 * 1. no IRQ arrives before postinstall;
>> +	 * 2. display has not been resumed yet.
>>   	 */
>>   	atomic_set(&xe->irq.enabled, 1);
>>   	xe_irq_reset(xe);
>> @@ -869,6 +886,9 @@ void xe_irq_resume(struct xe_device *xe)
>>   
>>   	for_each_gt(gt, xe, id)
>>   		xe_irq_enable_hwe(gt);
>> +
>> +out_unlock:
>> +	mutex_unlock(&xe->irq.pm_lock);
>>   }
>>   
>>   /* MSI-X related definitions and functions below. */
>> -- 
>> 2.43.0
>>
