Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B375FF4942
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9758510E25D;
	Mon, 30 Mar 2026 04:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C+F/aACj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA7B10E065;
 Mon, 30 Mar 2026 04:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774846459; x=1806382459;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kYr2hoIsjjI5W0dj69rPbdYIUnd2AsRAnzzsW/8c/6A=;
 b=C+F/aACj4i69PalHT06NzKnzrRBMi1k78nVe0PtYApNvkn20WaWfinio
 +05CJUlEVcKcEIV04XwQHzzuezjK8Gfjh7oLDM20uTNHQaMk4oSa3HEi5
 gPuEa9ChMPG/QoJehlQNkt77E4kSJIkUPXjHHktX3AmBbuL+XF6u0SSnk
 pgENS1elvlQ/+CwYg48fp68t3yhXRUGWZxtb2I+6q04QOxfk9uCHPZm0b
 HpsroH0leaaRBr4zI9HfVqyLFwje1u1mQXJDC5zwRRK9A/sC9pAptHuqP
 Iuca1C2iwxTdFb0cna0s6NpajmZXG5oeFx8Rjq07Pubb4DmoRmm6FrzeJ g==;
X-CSE-ConnectionGUID: wJIDtiwEQgSX+T4iF1rKbQ==
X-CSE-MsgGUID: ANPPC2PgQt6ZJs82scrq9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87220097"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87220097"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:54:18 -0700
X-CSE-ConnectionGUID: LOyzCjEqRte6ksq9EwSHIg==
X-CSE-MsgGUID: D8IZZqZGQGakVepFjn+juA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="219304901"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:54:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 21:54:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 21:54:17 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 21:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHKM8lO7bb6UJmBQEXqjUnxOztvOMnJaSbO0vBPgCst3YfL82p2c8fLr4bK1woZMdZEN3sUEpCrw7dvuZbLdnFS/R1uRmTg0Wd9bE5HZn5BquIe2V2i86M2J968Kh5flw09tv7OPZ0Vfqok4l1CgnSMKJpiI8u5gUENhirZK6WxIj4FaQACPVQ+yOhpcDjzbiwFVGSAPCSbQYVftidcq/ZzREWXIny9f+dyXRbtmN9E4gQmBXdC3Y2l/ICXZ+86GQvZOJ2m8ymGSTdQFFm37eDQkBauTeAJ5ro/pl4FMBcdufg1V8NOC21+szF+rFHEzlDE4ApLOHFZiNw44b+Hwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3pku217BPjW7iAHige1ijPzrT8UH04SOiL8i8+BR7w=;
 b=eID8Ocrccf3/hR4eHbKv6E1rsM9Hv40PjTXjQypinWVXEIA9QW1pQsVswzwvkbbL8X+xV0cNy+zGzeNqr09nGW02//jiiZDeUs8dIMFjUIm4H2U3i/j2CCz5YDxKbqIi10kEOkCtiOWRIPglKMgwP6ZZgNKYL6MBTxBL18trHTHuyCLzglFZS5shr7BOX5u/Zw2N8jIjvHiGGvupNW8AUgWIg5kplSvYcWy5pmrvshjgfZIv2clx8mOO9HAQxPcmE+36x/pu2QccW7F6V2YRFt+O1QKccS59mhEBAIvq2oOG6BSwiGmXW/SCX4w8I9VB9smZfvrCkrzHSmyeV4jtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Mon, 30 Mar 2026 04:54:14 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 04:54:14 +0000
Message-ID: <e2847c9e-5550-474a-b0b5-19844787c200@intel.com>
Date: Mon, 30 Mar 2026 10:24:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/xe: Add handler for power management unit
 errors which require cold-reset
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-11-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260318064016.374656-11-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::17) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 055f96ec-add9-433b-9d61-08de8e186428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: JsqfvesNl8LVYnrEyTWqOct+j8WX7STHLJDEfQWAR/CtKTG0Lxp4S9RYhMN11JouFoOMvpHsNCRl8h/sgFIuZj/eKn8tqLnOL/u6DWIvSzwb9idQyCE8mXGNFWLJtaMTGJACAWjcu4ePreXMOJrYCurpmyprF1+EWnm+D/Pd+iLDeHNvSTYsIwlgIxow+lTqvHhFYKUnqAKrPD41hlyMPBpOQftJoak4MP0PM883/R3uesSQdiT+YbJTZ8GyQBe9hIH6ZCEPJDdsAx4b60GGsw3/h4C9SM7Hvo4OUPmh/TQ50lpoZ2cNsOMm4ZXAh5Xwuc1PfFDyuzH102HHvwVs11iBpbtsVd1a7Hi1Rn0bWiCGyfHdkU+56N4U3CVs8cjwgKgi9myNQNLEoJJoiH17dEU8q/7HrZbGRu7mCyHfCN1CCW3cL+5SAOvnL0spTKYunqUyrIwtCzc84+1dGy+LZHtzXPulQDvsaw6E6WuAeBPPaJma+cRByZihxATk/M132T2aNlt6PByFkKVg94malzX08IyKkuVlsbFJs2i+MeWQ6H7TNbXPoTgf9rjy3Gsq3C3X4TTH37EdE6wUqvb/GN/7xftIVrH7o1EQ+VRyHMnPA3TEtB/jhnd0BcCwKqS4zGxFsG+XVMXck+xkk/Ke55dp9K6gYbwvVdGt5If0eYRBkcsHCesQvbdPEBnw0HSikZTR4qfQs4j0CfIrOMpLEVfhAIi9s1BQkdYlBg8+hkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdqZWhuMVkvU3drWEdiOUNiRGM0Qmd3OW1lVkN0bXNjZXFMSDdxdDcwMDRa?=
 =?utf-8?B?WENNZDV4MEN6c3pyeHFueWx6U20vRXpSdmxVY0VUazlBaHI4NU14cE5qRWUz?=
 =?utf-8?B?aHZPR0VIZnFnV2tmMURKTHF0UlVJME0weUVEbk1VaXpvQUhrc2xOZFk0c2RZ?=
 =?utf-8?B?NVdMSWU2dVlSV0FRRGNVTk1Oa1ltTVhkSDFKK01zVlRIcWd2Nkw5QjN2eEs1?=
 =?utf-8?B?NmN1N0kvcWxqZXlzTURoQ3owK0pIbWt2WTRwOU1sYmY1UlJRWDIxdng5OWRh?=
 =?utf-8?B?M3M3VUUzSlpIOVZ6OE00UWxNNndtMnFBZWpTbDFVRkV2UURGMDk0WHlxNzla?=
 =?utf-8?B?RERoZDJoNnJRRzNWWk0yZWEzWE9sTDFwbU5BWEhCTldZaEpVS3FDMERKcVBG?=
 =?utf-8?B?TGhZakdlSlA1VDR2aFNhaHJKdDBTMzZWUG43d1BmTXBGaUNycFJrVElPeDB2?=
 =?utf-8?B?cno3aGM3eUZVN0VzOXZ4MnZuR2VsckJOZmRvQ3k2MEVwb29OMUYzU3lkeDlL?=
 =?utf-8?B?cllaYVp4Y1BiZjJPRThBbVU2RHhvd1M3ZU5VYmRvQW9OQ0pGNHUwWjN1Ukhx?=
 =?utf-8?B?eDkwbHZoemtQdFY2ajZsbnI3OFNDT0szcDdTZHNUZVF2c3g2ZDFNb0NoQ0oy?=
 =?utf-8?B?TFNWT3pFMWsrb1E5UzFBQmVvZHJoOXJNNk1VcTFtWVFUNWtiU0J3bnRzT0pE?=
 =?utf-8?B?eHFjdkFTTUNoam1KYUZTKzdnM0FNcXVkUDdCRjJ1dnRvZ09OdlJqbnB6dEJu?=
 =?utf-8?B?UGNVR3dURmVPeVdkekFQM1hYM043MUFidWxWSG1ZcUIxb1JjaTJCUk9hZ1pJ?=
 =?utf-8?B?M0tpeEdTMkU3anloQzVsRzNOU0tad0h6Qy9OUi9yUzkrTmg4WWp3NitxMU1X?=
 =?utf-8?B?bHRQdXd4cUtMc3RWMHJzM1dzNEJ3NDJDTUEzWlJJZ2VVS1orQ0cxRk5qNk52?=
 =?utf-8?B?bzAxVUdzaW9qNC9ybUw5dmpXaUF4WW1FeGZLalJWa2dNaytwS3FCNEJWREhV?=
 =?utf-8?B?ZzhMQ0tWOHl3Ynk2K3N3OS8xNis1WjhYNTA5ZmZ5NzZ0VGtTMy9lTnVNZitm?=
 =?utf-8?B?dS9KSTkvNE5NbXZYeXlDWXJ6YXlqd0ZvQ0g4VG9Wa1B2RmZqWEdOTUh5ZkVl?=
 =?utf-8?B?MXNBSnZxMUJpcXFucTNWVGpNVmp4cmVMYktMY1p2ZnMzMXVCbEViRk9LNUNa?=
 =?utf-8?B?UDlnY2dCWUxlTWRxc1RwV29KSW5DWHZvQnA0WEIvdmI4aEgvOWRja2Yydmxj?=
 =?utf-8?B?bGVSeWdyRmdQY2s3bnFUeVFSSmRjRWo1RG9zUElNNWRMd2pYelYyTWNYQ1h6?=
 =?utf-8?B?ajdIUXZqWjZGTTJlejF4MEE0K3NkbHZ0NXVrVXYxdVRQMnV5bk5jc2ZiQUhG?=
 =?utf-8?B?RWc1ak1WdnVBZ0pDbnJkQlNocitlQ0xqcWt5WjUyeC8yMmJDcE9pKzZCUGRw?=
 =?utf-8?B?ajNNZEw0K2dHWm94Z29jMHAwcEppajdNRGlkNTdEcmtPTEJ4d2NReXZxVVBZ?=
 =?utf-8?B?UXE4LzFMRUZDd1ZnN3ZZbkVXaExhUmVGb0VTanFzVEJpb1gzLzNaWWY4REIr?=
 =?utf-8?B?Y2djSHJlcDFQMzEwdGgrSUcyckF1UjZOT2JLQlVoMzlzMVZUZ2tGcXcraE81?=
 =?utf-8?B?elRhUVlsSGMzTVV1SGhES3ozYXFVMnlhRG1YL2dmWWtRdmtieCtVYU4wc0VX?=
 =?utf-8?B?a2E4cTJWbVBCZUF4Q0p2YlJSVy9XaDFPSDBTQ0dmUEw1NGVDV0RLSjhtMWx2?=
 =?utf-8?B?dXFONVByZ3IwclMxUDduYVMzL0N4dE51aDZJL0RXR2JneXl5NVNLQVhjeDc5?=
 =?utf-8?B?K3h6dTZzSjNXRkp5aEZSd0d1aHFKaWpBMUNWRzJkVWYxaDZXSEdmcU14Z0lt?=
 =?utf-8?B?T21oZVpkeENxSlJJTG0vcWNoZWpaMGdzUjI5ZkNGeHQvWk0wTU9ud3NIY2pV?=
 =?utf-8?B?b2hSRVZmc3h0MDNLMmF1Sm52OE1TVXJOOU1KRkt2YnY5UUw4cC94NzVlQjBa?=
 =?utf-8?B?UWd1YWFZbEtCSCsvZXhlWG80WGV6UHRMaFZMV0tkTmhyaW93Mjk1VlRpWHJl?=
 =?utf-8?B?L2lqVU90RDdrS2trMkJ4OEFzc3l1dS9vaEhyczR3cVBhalRhMDl1bTViWTVh?=
 =?utf-8?B?ODdBN1hkZUY4SGYydzFvVkpGZzRydGpNSFp0NkRVb1lscHIyaDBFd2pvRE42?=
 =?utf-8?B?ZGx2bW5mZG1wQ2tKbVNRWHZrcEVPZzQ3RElYZ0trM1JDQ3RHNWd0L3VzeUt0?=
 =?utf-8?B?aTRCdmpZcCtUS05VZ3ZtWDFTTmo5ek11N09ON1RoVHNCYWo1Z2toWUNZVnNx?=
 =?utf-8?B?ZzZrZ0RuR3R0ZWRYNFJudDlzcFF2MUVhSm12a0xRSENhbENsOEJkdz09?=
X-Exchange-RoutingPolicyChecked: XaJs4ULULSaffTHXqyJdcOjqFDh3beTTDt5hR2Ll/rq4oaKQuNc/AEWTRlVAVwB3MNlTdnEszFXxHti97cmsrOV2ONSaOgvwNmRFFxHNJrNzZu6dOG+ZyTzt0HPai/eQ1+kuN5Xe458BSTFkq/6Hs4ohJ044pfovb+K9oF4M4DQ0ufWSj7pNHWyk2hpnsVb47HOmFOGi/MeKqEHrCY7Sa4p8ujZHP8jNBoL/PmYa/TnXKfDgTChWqlygqGaRtLmyDKH9AfMDK8tZiX+evq5rdkWrL2LHvTnicTWcDaAQV5aE8LuKQZV3duHtIP5giYWSL6xaAQsa7kF34dXbWzww7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 055f96ec-add9-433b-9d61-08de8e186428
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 04:54:14.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7juOaWZaIJ6nvvwhgMxkWZBSxZ2ftJzW4CzCXp+vXGs2T19FSeXYhGQHa9y5uiYJyq5W9hYyLGwVFqyvmCKn6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
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


On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
> This handler is designed to be called when power management unit errors are
> detected that affect device-level state persisting across warm resets.
Commit message should be clear.
>   The
> cold reset recovery method signals to userspace that only a complete device
> power cycle can restore normal operation.
>
> v2:
> - Add use case: Handling errors from power management unit,
>    which requires a complete power cycle (cold reset)
>    to recover. (Christian)
This is not an addition to the patch. Only add this in cover letter.
>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_hw_error.c | 27 +++++++++++++++++++++++++++
>   drivers/gpu/drm/xe/xe_hw_error.h |  1 +
>   drivers/gpu/drm/xe/xe_ras.c      |  3 ++-
>   3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> index 2a31b430570e..ca965a2b092c 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitmap.h>
>   #include <linux/fault-inject.h>
> +#include <drm/drm_drv.h>
>   
>   #include "regs/xe_gsc_regs.h"
>   #include "regs/xe_hw_error_regs.h"
> @@ -542,6 +543,32 @@ static void process_hw_errors(struct xe_device *xe)
>   	}
>   }
>   
> +/**
> + * xe_punit_error_handler - Handler for power management unit errors
> + * @xe: device instance
> + *
> + * Handles power management unit errors that affect the device and cannot
> + * be recovered through driver reload, PCIe reset, etc.
> + *
> + * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
> + * and notifies userspace that a complete device power cycle is required.
> + */
> +void xe_punit_error_handler(struct xe_device *xe)

You can move this to xe_ras

> +{
> +	drm_err(&xe->drm, "CRITICAL: PMU error detected\n");

PMU? also means Performance monitoring unit. Please use Punit instead
Keep this consistent in both commit message, kernel-doc and code

> +	drm_err(&xe->drm, "Recovery: Device cold reset required\n");
power-cycle/cold-reset. Use consistent wording

Thanks
Riana

> +
> +	/* Set cold reset recovery method */
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +
> +	if (xe_device_wedged(xe)) {
> +		drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
> +	} else {
> +		/* Declare device wedged - will trigger uevent with cold reset method */
> +		xe_device_declare_wedged(xe);
> +	}
> +}
> +
>   /**
>    * xe_hw_error_init - Initialize hw errors
>    * @xe: xe device instance
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.h b/drivers/gpu/drm/xe/xe_hw_error.h
> index d86e28c5180c..f588320eb94d 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.h
> +++ b/drivers/gpu/drm/xe/xe_hw_error.h
> @@ -11,5 +11,6 @@ struct xe_tile;
>   struct xe_device;
>   
>   void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl);
> +void xe_punit_error_handler(struct xe_device *xe);
>   void xe_hw_error_init(struct xe_device *xe);
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 777321021391..93257d0eaaa0 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -10,6 +10,7 @@
>   #include "xe_survivability_mode.h"
>   #include "xe_sysctrl_mailbox.h"
>   #include "xe_sysctrl_mailbox_types.h"
> +#include "xe_hw_error.h"
>   
>   #define COMPUTE_ERROR_SEVERITY_MASK		GENMASK(26, 25)
>   #define GLOBAL_UNCORR_ERROR			2
> @@ -148,7 +149,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
>   			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
>   			       severity_to_str(xe, common_info.severity),
>   			       ieh_error->error_sources_ieh0.punit);
> -			/** TODO: Add PUNIT error handling */
> +			xe_punit_error_handler(xe);
>   			action = XE_RAS_RECOVERY_ACTION_DISCONNECT;
>   		}
>   	}
