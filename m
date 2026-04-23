Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70215FDEE4E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD30610F262;
	Thu, 23 Apr 2026 21:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZhU12DS9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C3710F262
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776980381; x=1808516381;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DnkpOg9JjG5gEzsnV6g85LFiWkZ0KIN2EtW786NjJbg=;
 b=ZhU12DS90/OQCUSCzoRPvqGhJF8GW9U07+ZN1HbqqKs0NIeAZ9zA/A33
 IEKp5IH7fQPIPoKq1OfLwOwNEsWV66JOBmYe65Qdh40djYnAp16unMzfv
 kOGHKFssXEKP4kfP3CDEfLqQMmw1iohTwbonQAIq7FA86L9Z0qyJuZo9X
 D/CnBOegfyRYcg/GbL+pNoBdQqt4hSIR2ffzNa83E7C35Ri948XRnOA30
 +NU8STjNFEOmk5W5vpWw+kSCbMroprNOr/ZRtso17dQ5mpX1wgVM3MJKz
 4H7WRtnUMdz1RXLEdlClEYg8kPtIUdu6tlYsG6UP/0kwZqrLS4m+0mWYB g==;
X-CSE-ConnectionGUID: vClBG6yaQP2JQMuNjWKXTw==
X-CSE-MsgGUID: 3rj1Hg5kQmyFQzWFwLOxbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89042137"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="89042137"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 14:39:41 -0700
X-CSE-ConnectionGUID: nj26NC1NQLeCJUsBwGRtmg==
X-CSE-MsgGUID: xbVqY6yvQFu3ScTA9pc6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="226240410"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 14:39:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:39:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 14:39:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 14:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1DYpYBR+qa6s0M4SmA+GEd+c3tez4xccEhLmlIIoCSCn2VHA3B0do4FrPXMKjgEv+QEAjeLJ1ztnRVDEes8V2w51QolIPUywVwxF4c7SDsBwwkKj0FPbfFTBEL6ixos6isyCdqzkdVtX2ly1xMp42/KPmUU8Z7QPTZ6waVq/JzzkdpnXGj9f1mf0xWfMSTdx8lRKFk6XKy8XV/+EebKzYuNq3sh4vLqMOjIDsfBKrpa7tQ8JwGsx3kuCucPfexNZoW2yu+b0GS1jlhCZYq/oJO+3cszcd8mAOcZCOVmDa5uoORTqXcoOaW9UZK3iUkSIuePp7gxKcnAVOmWRfMpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lagMJ6nJmzD3+zwiN2NxH/2nyDmwOBzexJVxfUTE1Ps=;
 b=AGOc8uhIz5NDzxsbbpLveZwk7DZX01wfTRfEi/x+wWgUNE8ZaY+CPfTTFqfPsAccou5WUPDCMTpTwyCSchZcM9uV2JvaIQA+ZEMF/Xx6/6I/p01S/3TaECnbC7v67ZrwpUnQqbZPwXeEYCIHX6Fhfo7Vx6rYDOwW6YL/KJzcioTuDNuQHACYMhe5LEoWT+9yH4oyYD53GZng5vPTRJ7hSDApencUQg+C9FC2evaElQ8YJv67Na1Fx8LN2pGPH+G3jYl4esmJAaUtgtxs1FtssPmT3yCvaaKnp83jeccW4advjKsdx/Zzn2m9MEybeYfQ5RrbiBpXkC8vruQ7WelwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 21:39:32 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 21:39:31 +0000
Message-ID: <a5a20cea-3e02-4e22-96a2-da2ac1a0b0a1@intel.com>
Date: Thu, 23 Apr 2026 14:39:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: David Airlie <airlied@redhat.com>
CC: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pasi Vaananen
 <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <CAMwc25qszFpFGXC8A6DSDhpE8AEEbqh1B6sUJMT=t6t+CaBJ0g@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAMwc25qszFpFGXC8A6DSDhpE8AEEbqh1B6sUJMT=t6t+CaBJ0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: b93cbcb2-77a7-45a1-cd0e-08dea180cde9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6Vtvs7EXBs7eDp7kaintFsdnEdy+6kTejsibwxu8ovVn8x4gIbuvElxPt+jFuQ6ZzSSEZJ1lhFFXQdmK3EAKdHQqREdnkIp4hjRHMcc+I/+UHI+3fx9LR0RLTM8nVCQlDrAN3OaVKJQQMIZ3Kl5B0Lpnu6G0R9rQanupfcwLFtUwHrbWaMi61eaZGqM9wcfRmE6s9Vn0OrkcHb8POhU+7J1XFrQ3slu/aZXOd8cexk7mwVUPQCqX2R3Ie3qgLu+oayAwbYwEiGN/To7RVhq9nBhjbd+D2GEEhXkfsxx13EbXtUMmzLn8f2J+tAZhPmPyZiFJUj9w6lF9fYkTYeM3+wI0cSz4PiXFW9crwKXluSb5NeXRRFsVJ5y5kFulkC7xH8JAqzg5fkm6l2QdbuyoFnUOZBZd0oNTFXAyaFqCSerPnp+ni5vFAbCiaanwVPmyecqKgQJFbGDaI/AS/8uu4G8hjqg1xgg51Gk1KG29zMEBXadnxhTkcMQdtd+ZiDwFRZMmvJnL70igLa/keyKl6PmtBbH3wWLfe22oEEJ8OMmadmda+wPaFtrLCa4NwJtei3m5awyRh+fPkZyk0eiMJWdo+RfAZKJFTid4L5II0tJ1lN8LJJ04Jlg8hAxHLyUvmHwKZuBBOX98+6XszjED063GYeZ4imwByl6hEEgGwVGrFTcJgunmKTefpIPd4gkfm9c2dEXfLaZtz4/yIESlfDOKfpTQ/ieDMGV+vK0jmU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtpakFqSXhMT3BFWkpzWWdGb3V4TWUzWlg1UE5kL1dEai9xUzJqQXJVa0JR?=
 =?utf-8?B?K2w2WVpKMFlvcWRmRVhBbUJaS2FpWjFtVnNEaGF2WXNoVE5oMk9SRkxLUWh0?=
 =?utf-8?B?RHp0QUlpQ2JEZjJFSDZqLzdDdldtYU5nYlB4dlk4NWFUMzkxRUw0WXozM1J6?=
 =?utf-8?B?WURxbVZRZFN0alhJYnEraGNIdC9HdVlaMzNhSngwcmZuQ0J2MGlJRDkzN0pT?=
 =?utf-8?B?Yjlsd0ZrRHNaeEY4ZjdNQU5vaDlta3QvYWQvUE1pcmlxN284QnJZZjZ5dGhL?=
 =?utf-8?B?WjdFUlVQUFU3M2FWamNSUlNSRVozNzRDaVd4ZVlCM3E1anY5Yk9JQXgrb1dH?=
 =?utf-8?B?QW9SQ0V2cGg4QStaWlRLYnVUNVR4SDEvRnhINk0vOWxqSDJIc2dhUEJTWFdt?=
 =?utf-8?B?YXlZVWs0a1ZDaDhNZ2ZNMDFsZ0J3Sk5FbEZ0ejY2V3ZBL2xNWlo0eWE2ZVVo?=
 =?utf-8?B?V2N0MWZQOXIwd09SeXQrSzZrRzBJdlU4KzRHWVcrZFFhOGN2OXo5L0hiSDl2?=
 =?utf-8?B?RGhranBrZ080UFZkdWNZbXhleXBRWXBhQkhMKzkxNGFqUXhTZzV3RGZSRnh4?=
 =?utf-8?B?RllyUTdSNVp3MDd3L05aMUV5bFF1K2pKRUxiSTNrU1NqcmRYQWxrbVdwelpL?=
 =?utf-8?B?OXZmVmp2dXk1U05tWWhCbFRnR2FTL0luRGpJWUNleFJnbkh4SnNrd1V5MWJJ?=
 =?utf-8?B?K0E1NGczWHZIVkpWSzNjaUEvems0NDJhMWIwV20wV3lBamx5ZFhHRkY2c2kv?=
 =?utf-8?B?dGZNd1JnOFJsVC9yTUI1TGUrRDBweEVSaUJ2dWhKVUZhRVBiN2Zqdk5QbjBU?=
 =?utf-8?B?YldvTXEvdUVkbDVPdFBPeS9jall4aWNSU3l5alB5MlZBR09mbjFtakNtK1Q5?=
 =?utf-8?B?T2d3V3ZoQ1k4V0ovSkk5T3RWSm5oeE91SEYrVitmbkNsQ1ZsRXg3dDBQSzla?=
 =?utf-8?B?WDMwS2RycWJqWVlRblpURFNHMFhiZ1BQMVFmYkF3aVI5cnkxMU1TOXNDM05O?=
 =?utf-8?B?UStoZXJKVzZPT2ZjUGhUaXV6dVVZMlZrc0t5bWJNdXJCUTE4alhqanlqL1pr?=
 =?utf-8?B?RWJwZitXUzFZWjVaK3Z6b01YUEFYVDA5N0JjTGt1c1ZrT3d3bnI2Y0FXdC9J?=
 =?utf-8?B?SEhmem53eGNlaENSVmlJNktSUUpQQUNiU0dNZStXZFdVdno2dWgwaWcyMDIw?=
 =?utf-8?B?STJPdldWNUV3RkxQbXVTZGhqNWhERE1zcllDUEVVekwwbzhHSDlvcFZxSDlj?=
 =?utf-8?B?QTRsZFNYT1VlVzQ1SjJwbVl2cFpnM2c0d1BpUitqSVF6dWJ0TUVZU2t5aXBt?=
 =?utf-8?B?bXJKaVQ4SktPRDVZa1NESkFnekpPMk1BaTVFdDRndGFEcWJsOUFKTXJheVhG?=
 =?utf-8?B?dDhXV1gvSUtsN0dvL2RjNWZXY09TcHRDVHBIS1diY0RkSUMxa0xTdzJpYVRJ?=
 =?utf-8?B?c2IwWXhRbHNpSlVoM1gzdVJvL2NjcEhGUG5RUGtRNEtpRlJlNU55MFU0cUVV?=
 =?utf-8?B?cmFnSEhPR09FQ1N4MktLbTk1amdRN3hZcitYMWZFTkVXTFBRZFFXUUdlNGtk?=
 =?utf-8?B?bVE5RjlVREo2Z2luNlZTejNITGMrSDd2UksrOXBvdXlJSGFnV3VMN3ZMUVpY?=
 =?utf-8?B?VWFNdmJtRTFpT2hJaWtocDFoZVF0cEoxVXE4Z0ExUzJjODdOaW8vTlFsRzVG?=
 =?utf-8?B?RkVhVkpndkx0SkFTYVFFN2d3dFNodXRadDdTTlorNlZiaWpSVFFFL3I5VXRI?=
 =?utf-8?B?RlpQVk9JVDN5VjBCVlI2UnZaZjhkSU9KQ3Fwc1gyZlkxcVFLMWcvSjlOQkpa?=
 =?utf-8?B?RHdTcEhudUd1OVFLdVBoTHlVMjhWN3dUUVBMemxXTnRXMDVhY2pvbm02UjNw?=
 =?utf-8?B?Q1ZRYmZ1QS80ZlhDN2V5WHpab1V3VWhnWWh6WlcyNHY0REhpMjVsRmFLbGUz?=
 =?utf-8?B?OGVSb3ZXZHFmQW91UzBwRkwyMWs1bGs0VXBkOGNEQzVKc3RyQ1h1RHVSWUxm?=
 =?utf-8?B?eXIya3dOUitqRitjOVZFQVlMMDJmR3dhZjhaVzZaa1l3SmdiaFVaMmEwMzVK?=
 =?utf-8?B?bFFQMTVMVG45b2dhdDZOQW1IYlcrWVV3UUsxekgvSzNkai8wbjRWTVhNZHBy?=
 =?utf-8?B?cy91L1R3bXBlYzNkV0NyVXd4MWNaQ2ZMTXA0M1VkQVcrYm10anJlNlJVb0lD?=
 =?utf-8?B?MStDcTNQajRYRDNQNkFBb2V1U1Z3c3hkMG9jcGNPTm93eFBpUlZlcFRlcTBR?=
 =?utf-8?B?WENZUnVncko3UVQrUjZMZFEyVmEzWWJVRHh1eDAzY2swS0tHYlMydGJYSFg3?=
 =?utf-8?B?dlBTdHZib0VJUkFQdHhpQWtyR3B2K0tHbWdMSVZuWkloVkszTFdqdmFhYksv?=
 =?utf-8?Q?X00pltp5VW9sTIaw=3D?=
X-Exchange-RoutingPolicyChecked: KG19cS1V/gTwZqnwXGVO4q1D8/sqU4YiM8t8wUPl3OzQ2AhPfbgqrbeUBJth7DOm3CBBtwZzYigt5F0ptG6VLt9JK3SuK5N0pGJ61hasHAutmJeqWiJSqUao8ZpTnw+o5fVY7sfAQ4diDk/8LOoIBujsyMJ83n1BpzYqlpETFe0FNmfgzK94uFjJt8b30JRgJs1Z0HGUcrafESZCSiVmmHelc3fk0iR3+Gq698Vgom57rAeE+PNh79qVoiEdEBpRfwmp69KRthjUZynByUc1OS1U6N5Xcj+ALneSQMgrB8sga7sCm0WftbGTXuJRCQxRsysaO/iP7UrVJYO7t7LkvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b93cbcb2-77a7-45a1-cd0e-08dea180cde9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 21:39:31.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOgpjjz7Fb91cR22pr/wC8Cpuo1YguV9yDp7ZJLmZ44H6MFoCPZKDXpWTi0eg1jvpwNSx10NwBu9GmoiubSA1ze0ds99rcxHKUi1L6ubWHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
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

On 4/22/2026 5:05 PM, David Airlie wrote:
>>
>> These all appear to be workqueue warnings about functions that are
>> hogging CPU. If I look carefully, it looks like they are all possibly
>> related to the same mgag200 driver. At the very least
>> output_poll_execute is certainly related to the mgag200 stall.
>>
>> I do noot understand exactly what is causing the driver to get stuck,
>> its something in the i2c routine for reading the EDID block.
>>
>> I also see this being printed:
>>
>>  EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
>>
>> It appears to print quite consistently every few seconds. I guess this
>> might be possibly related to a bad EDID block on the mgag200 device?
>> What does this even mean?
>>
> 
> It sounds like the polling is having trouble with the i2c bus even if
> there is no cable plugged in, probably cheaped out on some pull
> up/down resistors on the VGA connector.
> 
> does adding drm_kms_helper.poll=0 help to the command line help?
> 
> Dave.
> 
This looks like it is a global parameter for all users of the
drm_kms_helper. Would it be feasible to have a mgag200 specific
parameter made available?

I am testing this out now, but if it helps, it would be good to be able
to disable polling only for mgag200 in the off chance that some system
has another device which depends on its functionality? I guess that may
not be super common so maybe its not a big deal...

Thanks,
Jake
