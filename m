Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07355C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFA510E39D;
	Thu, 13 Aug 2026 06:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OSDoARcO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E15010E39D;
 Thu, 13 Aug 2026 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786602217; x=1818138217;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tq8QosGn+5ZROoVsjHYNBCvVPiuBvbgB/VFvvKBwVRI=;
 b=OSDoARcOVPNb2RWTB8QKsHI1IuIDoUtYLAUJInhpNcicKiKJij9GNPeF
 TuBIdW5jBGSMT97oZI8RD8534uJzTd3oYOHb11k4WXeT8oXMKoPmO0c0D
 WvnCB24BF1j4zeudsjyxRSwu0RlEt9o30p/i4ZqiujSBxj577uhXHRwaQ
 BnAEVxjVq9oPOL8lER8HOPROJk52APe0cEDkwZVy+xbUUo+IV0BWFQzvH
 TSrz9aLTG7seTQgZKK3m30vd7VQTZs23DbMDLWRjpgjSgGyzSiEGGu+C8
 fFCIQqpzjmRaqw4UtGhiviv2c6PttIMLOiiDxSctiWKd88d2wOdKgcZj5 Q==;
X-CSE-ConnectionGUID: yRHEv1lQRSKEQzvzO1nElg==
X-CSE-MsgGUID: po51Mj2MSgW2CRQ2zyjvxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97757669"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="97757669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 23:23:37 -0700
X-CSE-ConnectionGUID: Vex2v3BoSDersl15133CIQ==
X-CSE-MsgGUID: Ikkj4PYrSRm33cNv4/hTQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="260558295"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 23:23:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 23:23:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 23:23:36 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 23:22:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHehYgZMi0bqJTuLs4FBHz+mySPmksGnYdzD5fPoyhFt1HUaKvdX137QwT1s75sOKaQAVjG0uZnkV8uzA2GZW+5Aty5yO1rw5UYxE1MPAtFgfCmLNw26gI09T+A7qZKb79ZcB32hZYIAa0JpfFMu6KrNzYFlwyzkXTPG7VqElwAFbx2hpWCqH7zBYZVe/mrmYLNxTJUjpAtmkTu6G22bzZeOsf/GFA2Vy/V5mscxAsAVNBWhbMtNYPZKxNzABozUnpPQKxXfyryvjHJ/OTnlThnZxWDf52CMw3UT5ypdcyVzOG/Pk0ot5Mosw11jd37xneepsEMcUcxLROW9FgH/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKolULPBSfHBepqTsT3AGRIFlYFhZgVuG0rWTzAHOK4=;
 b=a6jg0nNrmiHrAY3yiTJKL8mQNnqBSmnenyeNxenGALbbMYKPeQGq1yu5MSeyP2la0f3WrZ9+fPzgN/6551apCOJgDrplt09e6KuqZ/48M93/RuB5oc6WUOvEsp5opB4kaLqSsNDvUEnPySgGUtj59JPnF5bY+g6qNibSAK/NVfEOhWrB009L3YgVzCWbGpYNawFpJs8pS4jV+kLl6jP/lkQaSCpVaiYHGSyRFPU177Xecmi27h5oLqtlfNkFxM/W8O3V5JM6xQJNqDPqPoWatDdOBnZ1NmTy8PkFn8evYMs1qNMMZEbm+4yQ5kGDh3K/nyQ8wsFofKcJ1XFWhz1Ipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH8PR11MB9481.namprd11.prod.outlook.com (2603:10b6:610:2bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:22:44 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 06:22:44 +0000
Date: Thu, 13 Aug 2026 06:22:33 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [RFC PATCH 1/7] drm/i915/selftests: Use drm_* prints in mock
 selftests
Message-ID: <cboq45kuykc7hmcd4u52jjghd4t5dtvgokjn4u5gjchteqp635@2nmtfo6aje3b>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260811133257.1133097-1-krzysztof.karas@intel.com>
 <20260811133257.1133097-2-krzysztof.karas@intel.com>
 <695f6840ccb16f40d89829f88fe43ebfaf9d85a9@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <695f6840ccb16f40d89829f88fe43ebfaf9d85a9@intel.com>
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CH8PR11MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 117d2523-62cc-41c9-075f-08def903493e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6da9s56dsotpgH7gPrcfTd2CxhN+++K3QQme0VlNY1Hlbu/TfIY+cXINYkO32ZjhrogmzeZLZZki5XH+/lzy9bIL1d+E7io9dgSdrrmhUrZDtUTdUCvTkTzbWl2e2fAPYmqwGVeS7SpVn/Z90sTuGkqBwkZ1pBf1LLLIW4SoVfoRniWcwd5vRACKu1oZralfmySX3KSqcq9Thi1nx0Fk8KwGUKj+gfWJgxZlUncfWhGnG26xrvd2bDYz/Z11RHf+BMmUvJJQSZLei36nmWKYJNWcE8UWSx1jb3z3YSfRr9xxckYozZksu9RB0wMZnt44xbUdBKzFeqMZoYP0nvZ95naK8oensrLChRQnEqZEhUdZEtrBW56rR02bSK1hvh+NL/U4QdiewobmE3RvUu4UOx4/NPQplT26p5V9IvkOikEyIHcGc1W8ABBujFtva9KIla0xsykRuqMjUtoFYJ/3lWnWdi/0+JF/oYfkL/dYjlqW42N6t6MFcMA44c1Ez8jvjsepFh0mewkJZc6SXkd2AwEjoXhhJp3rWJTr7KFdYmSzopCb8uYnVHEDT03NXZAzgyX+dYHZYHyRsHyx//HIUNH7Y3DulWRJu4WjGxV7iQRrB0dYNTiXLJjemCNnysZH6Z80y5bJ7FdMlNDqbDdGgdToG53yuLbx3j4S6Efgp0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdDNnF1bGpubG1xTDRML2QzMkFEUFl0NWJIbUpOU0VsSDRBeWxkVk9OdVpS?=
 =?utf-8?B?ZFFyeHFHVmphbE51WG5scnJsR2tVeE8yMGc2c2N1WGxEVXBMZ2JaTmcxS0hF?=
 =?utf-8?B?RzdRdCtGbDZKajZRUlZJckRiV2krVnJGWGh4Y2IzK3kydm44STIvUEQ1czVy?=
 =?utf-8?B?VE41YUU3VXFtanpqTGg2dS9jV2JFY0xBd0VJZzZUTTBxSGJ5dmFqYlRDekFW?=
 =?utf-8?B?VG9Sek9LcTFhYy9rK0RQYmFSUHBUdnFEMEk5MFpWUUZxMW5GMFdCTURYNEJP?=
 =?utf-8?B?TkphMExEVituSVN4UGVUM2ZrbGtWS0dPOFEzb3dTdklkVVM0dXdWN1B5NmMv?=
 =?utf-8?B?UWNsZXZWVWFSQjdmWG9uWVZZMFR4Vk1uY2xqeE5jWlJqR3ByMktGYW5yekwv?=
 =?utf-8?B?NzcrZy9GVTBKSFpYa2lyMzI2VHZNZ0JDSnVlM0JqVnRsSjF6cFNhNVhycVlq?=
 =?utf-8?B?cDFmNlFENkxWeG0rMmZtcGRkNWFhbWdyQlBmSGFXMnMvQXJYdWdudmo2V3Vs?=
 =?utf-8?B?dktsdHpLUkdzQVJibzNPUzZXVitsd2psTWc4WkhSbkVaNUJmbkU0Q00xVzRB?=
 =?utf-8?B?d0ROb1l2dERVRldrRENxaTk5cnJIZVRuUHJ2MS9BTW4wUG9RQmQzbzZFUmt1?=
 =?utf-8?B?Q3pHZ0M0eERRMEZQQWRTbUFiU091bnYyYVViL0FBY3U0VkVTTTRvcldTZ1Uv?=
 =?utf-8?B?R1Z0T2lveXl4NlVXWDJvY0RSS1F1VFlRU0p2dE9vKzhkZjVRS0lLYjBINVJa?=
 =?utf-8?B?bjc4UkQvRlZ4TUJ1U1A3QWVKckpiSm5DTmJ0YjlWRlZzYnd3TisyekZoOEdR?=
 =?utf-8?B?SWgwb1dlckhRcVowUTg1STd2aEg0WkN5SnRPcUZyaE1NNjVodWZhV1U0cXlZ?=
 =?utf-8?B?TkNORXpFOFlXemhIc1krWVUyQmhsNVBuaHVlY2ZhVlg2aUtJZnptbXl3WmRj?=
 =?utf-8?B?Sy90d3NVa0RhZUlLaWU2MFJQRW1Va0ZnclZlL0JybVEwOUZ4Smh2cE53N1E4?=
 =?utf-8?B?azdWemNvNkZDU05vdG5CRVVBK2dIUjZIeEw0SWY3U3dVRlNqZUR3Q1JVRXlB?=
 =?utf-8?B?Z3FVVk9zUFErVTRlLzB0K3RUa0ZkTkZxeU1ZdFFNNFNtTmVKS3RBRkxwSWNB?=
 =?utf-8?B?YlAwYnlPdUZvSkwxMWpwaEVqN1NXRU9KblE5L0dza2dLT05kQm1TUk40Wm54?=
 =?utf-8?B?K3V3clplR1lLdDJHU3BEYWpKR1dGeEhNdlEyL0ZoWGE2dmRmQ3U3MzRxSXNP?=
 =?utf-8?B?ajI2bGI0Sm5FYlVSU05QVjJnSS9iNGdFbDFmZDM4WDZoSU5YbE9ZcFR2aHZM?=
 =?utf-8?B?RENwbHVUL2wzVHRjcDFRZjJJUUdPNHNzSk85YlZ3NnhOSlZHT0JRZWtSWmNz?=
 =?utf-8?B?UFZUMGF1MGJaN0cyZ1J2QXNhN2tMMmZXby9FNm9XNmM0UEdvem1UN1BjaVRD?=
 =?utf-8?B?R1NTMUVvRERFc2VpQWgvTDhrZ3BKZUlYNmwyNHpOYXpycDZmVUllNkp6RjBS?=
 =?utf-8?B?anFUeDNuYmQ4UWJkdzZJSks1dFY5SW1QR0YxZS9tUHJKeDhlK1p0Ym9qRHdR?=
 =?utf-8?B?NHFpeFhRNnpJK3kycEIyQVFrcFBDdzBIRkRkc3NGQXl4MGpIWG5ibzM5Tmx2?=
 =?utf-8?B?L0U3aXk3VGlQWEYyaW1tL0V6cW05VjJKLzdjeGdBSFdValpybUZiblZnSS9I?=
 =?utf-8?B?Um1SQWNzRHh1azlsczZ6dGhqdlByUWNzcUdaWHpaR1ZRRWNhcERqeTkzUENC?=
 =?utf-8?B?aGRJNUpQaFdRa045NjU4UWtlOCttZml2ZWRDa2xYVFFlYkRSQUE4MThkMVZK?=
 =?utf-8?B?Z2RmNUFVRU1LVnBIQk9PWlU3bFV0TzcyejZ4MElVYk1MdVN1Rkg3L3RhRHly?=
 =?utf-8?B?bE9MVW92a2JmRU1XVHNrRFZ1d0pQM2hzeTFObTNMN29kQ3pMd3paTXBHWTl3?=
 =?utf-8?B?a24rb0dpY2ZRdmcxVVZqZHdWclR0Mms2T29Kc0xoSTU2eUlwQVIyUTl5RE1M?=
 =?utf-8?B?MzFQSG9zWHh4V0ZLTG43MlRNR2k2RkVEMGFzTWQxRklMemoveTRyM3FNZmph?=
 =?utf-8?B?S3NRbGt0Z3BKdDRLM3MrWFk0YmY5eFk4bnIybjRodDdLM21JckQvTXdHRDB1?=
 =?utf-8?B?RWc1UCs5dkQzQmlaYldWd2xkL1UrYlBab3ZLMWNTbERQK3U0emtTTm1kNmdq?=
 =?utf-8?B?NWVGOWJQTjBKb2xhRFJJd1B6Z2w4WXhaTnJDVWJWU0pTbDYzbVdETVd3MXd4?=
 =?utf-8?B?Y3ViZHYzdnRPdmwwOEZ4K3pEdHBScmY4WEgvR2l5VDRqRWM4dUpFcVlKYUF3?=
 =?utf-8?B?OE9BYnp5YVR6YWw2Y1Fza1haa3NOWEtYV0lEN2N6cjBIdDFHU0hpTm50SS8w?=
 =?utf-8?Q?/A/OhWimdgkAjrIc=3D?=
X-Exchange-RoutingPolicyChecked: HzZzORZJKJP8FL46/l2d2QiuatkQYJ5mr13aLwJxzThaeognhg/fvd2PR9YYS0BBT0xNppzLGccd1GxLZKb3ziPyuLBy8VnH0kvZWBhYl0z0NZs9sARsNGbUcbJy14oWT0g++XiAntRFVcv/1JS6h1bbsRnSqENJMxAHW8bGiSb3fRrSU45tuj+tSjs7u/uZJFC3A8/p98tji3EADl9cskYocaRDl1oPA5ixN0PXVkGnyyaTlzQH6h2rm5wDD2mP/zL9X+pZeL/JUWcWxmkgsiQldDg59BlrY8fM1u9Zozn6fMnpYtRQ2lwhXo/foiVQz8F4N/Gm0FRZwMvHqZJ/Sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 117d2523-62cc-41c9-075f-08def903493e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:22:44.3918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di+Va5BbKCR1J3pHESTeA9JUdNPznDP0C0LfWrMTD6XjaRjOz0Uixe1cfGAKWIHfswW7iB1mPfSvFTasjuOGN6MexLdSCSpNLVE+tSZlu/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9481
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

On 2026-08-11 at 20:19:25 +0300, Jani Nikula wrote:
> On Tue, 11 Aug 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> > Move away from generic pr prints to device context aware drm
> > versions.
> 
> Hmm, aren't these selftests independent of i915 (mock or real) and the
> hardware, and could, in theory, be converted to kunit?
> 
> Does it make sense to introduce a dependency on mock i915 here? There's
> no device context to begin with, why introduce one?
It may be an overkill. I wanted to make the change uniform
across the tests, but since you mention kunit testing it might
be a good idea to do that instead of mocking devices.
> 
> (For the tests that do have a device context, the case is completely
> different, of course.)
Mhm, I'll shrink this series to contain only the changes, where
device context is available.

-- 
Best Regards,
Krzysztof
