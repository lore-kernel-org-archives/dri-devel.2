Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D33C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 23:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0935810E10C;
	Tue,  4 Aug 2026 23:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OYvZgggF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CFD10E10C;
 Tue,  4 Aug 2026 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785887421; x=1817423421;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NTkWDD/aGkvU3uV/4j63DADL0c0q9eCJ0oykVmE+UYA=;
 b=OYvZgggFJYmlc7pzsNja9vYvAgT3yPCHlRVVD9lqEQwKKmESa2Pdt5hD
 PC5MV/9Y7gWSbJzLts7AAZQxgGtC5Jhro32ok8302HB4+DWf52Z8jJQlm
 budJWdomHLOnOAP1/NGNW8QrO+dk90f/azTSrxA/fuj1cjlcphe+WY+6a
 haktSrKejlPQB4kEFnCcDINxteXjnm7hR010Dy738Og0ZfWaaWuK7KYcM
 DAf/mwq1nd9dHzSKYn60/3ZrFgGyK1ONfZ5ydB+kTlcy1VEpRkhnJD9ub
 08Ej8d5gYHHl2kLQiP7mGWH6pJngJZ6j3m+IGiMz8sS8UtxrJ34254Zpq g==;
X-CSE-ConnectionGUID: hGKsuj9FQv6XgjJ4NpXqmg==
X-CSE-MsgGUID: nL/AUy0XRIqmnE96v4NDuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97814861"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="97814861"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 16:50:20 -0700
X-CSE-ConnectionGUID: 06exdrVRTeiazBkei1BWtw==
X-CSE-MsgGUID: oaAR5rI5SGG1z8127fWVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="262225236"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 16:50:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 16:50:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 16:50:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 16:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW9mAjyAzCgSLPHtQfGcigAFxjKzq7ekVCb5uAjJPJVjb8MKv9vy4ug932tzzUSzyS+iSQJQ/cbbNONFD+9q9mrpC/U63XGWVfmvx6d6ugxzLTR+0FMlQA2omFETStjBh3OtS9GH7SpT7V4EqvxbuQ/M+ZutECVFcnauhNkpeCHK0RvpoPZ+PbppMH3JDoxRRARqZYF2KwPN5webVbMHaGmbAgjNVP0o0ouPJNK7/VGvCU+cVhj9iFLVtcmol0CHusswyIACESdwGHChV0akzFsB1e7xWbQe6bQSJ7eQPMqyReo/C2V1ldLDMlI01oHJUhPT4/NxcclgDbnqDrctig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJrsa2d/Be8BXjHCDbSrUmR0ddz6jGOA5MZEPEoaAUM=;
 b=XjuzCOCjJia0KItzZonnNQBnxKonDwF+BUIeiU7TovX/0uEcnDFV+OqfjwYL3UEWui9iE1gkTzsgDwFyvBC7blz9H/NzrlMbdYduQ/g2hAer0ZI7LtTB9S0ANFT61z/NNTErV8JWfJKKvD1tAaroMgJZoN1LJl+SntBPj2f2hs1ULHcjsENOzFnCPtNkvDNSJYeIumWuKxLd0pzdd52ZRQhpVd+9lma+co7QFOIjBPMtZDVSBHajZZmZvVAuzFhR2++rA/PWByOwRRmV4m8o2cLTq7cFs2ytYgu+KPdfcyKeB9PIZ4GxU0Dql1SpaKC21BAPTkejCaYtQqcKqmHb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 23:50:17 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 23:50:16 +0000
Message-ID: <49792f00-d8e3-41c7-ab2d-1d7efe4b5aca@intel.com>
Date: Tue, 4 Aug 2026 16:50:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: =?UTF-8?Q?Tales_A=2E_Mendon=C3=A7a?= <talesam@gmail.com>
CC: "Summers, Stuart" <stuart.summers@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
 <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
 <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|SJ0PR11MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 43539483-5455-4488-76cf-08def283228e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|5023799004|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 37H8zDOKuR1VOb74ain1X6U7zXapUTMOMRBiB4koT8+8kYktVu0UeHnNc3AGkhNby0x/aoorj0pzEvZWg+IbrhnEm9WsHRYPrhAsBLZ3T7XRQhtfNRmuaJoTYEmfC/RwaTRKN81hrzpdHTlJJKSPewvTmNBGENCXwZdQ6AC4od5G+b05xmZXVPX+DQAsOtI/z20c682j+L2kYc9szWvh+dUTvS3/LVfPCfqOwnh27gQwpD+N/8s2ReVR0Mws5zuO9tK8hYr9FFA1ouhV6PhqmdVMtwUtXajZhOZT+s2tSBHG3VxEfHbKjDBCl4JgS8tJFPblE3chOa30GNlpXbkE47W/fCkQwr8zL4DmYk8wIbMDPwGwme92EZN5adGozd0YehxpxItZAf8vwrpI04bwXUppyygEXCqlD9Xyf3Tei4Ju4XcRBG6ZLgN1fSRdRmRc98NNSL45JUrpMev4IuMYNLDGbbs1r1Vgi/wB/4hMtnFZpMS1/A5H6V2ts60HYPrIAWpAO8mQeu20BL3A1wXUDH6gPltAPwhPuu79KSRyiae/QYNTTnH+HciHCBnKi8QxWoX8zagOp02dQfuAChv6TLki7OTp24+T0plHJP82GQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJXUlMwN1A0TXVLdWdMRkxvS012dXErMDRlNkFpWHUzYWJRT2J5bTArcktw?=
 =?utf-8?B?V3VsNEJkMVptVE12OWJyRVZ0NmZMSXNNcGo0a2tGK084UVNlR1daUGVsQWJn?=
 =?utf-8?B?aW9acWNWQ3VELzVKQ3ZIZW0xb29rZFMydzVoeG1rTjYvN0RIWUxwclNoYnlD?=
 =?utf-8?B?WE80YU5DSGV3OVg4dElYSHZ0RVZLWXd4S2NvQm0ybHB2N3ZmNTczYkE3d3hR?=
 =?utf-8?B?am9LalFTOHN3WTNHWms1NTFWcGpLNWZvOHJ4eFBDM3FsRGlGa2JtNmZKSGht?=
 =?utf-8?B?cU9KT0hzcno2dnZlNHU5Skcvc2R0dmFaSVVDa095WkN4VDk1NHJkYk02SmN2?=
 =?utf-8?B?ZXNBY2pCMUlNYXdmYVdaTUtKVjd2Z1FCVTIwaWpYWThRQVdvT0NrSi90Umta?=
 =?utf-8?B?SnI1eEdRSi8zOEJTWWh6dVptSzZDejdvMjBqV29BQlRDQ2xlSHVWRWtVMi9B?=
 =?utf-8?B?bnBOUU41ZXV0WnRDcnAzSGF0c2NWTHprenVkVkxoTWRUWFB6ZmdiMkhNNGVR?=
 =?utf-8?B?cHBYNkFpeDJZMG5OTzhYeStFN240UmNLckE3elZtWGNaZXM1TlZWUGl0bzEw?=
 =?utf-8?B?VkRtODRtdDA1bDJ2TDRUeEJNREpPM2lvazVuWTFybGEweWxvSjg3VmY1eTZM?=
 =?utf-8?B?UEZ6VHdJemhiWHhDYzBEeGFHd3I3QmVHZHpnWThNTGIwOFpxWkQ3Y3VHanlK?=
 =?utf-8?B?dEkxT29kNnlZQVpya3pOU1ZEV1JNd3FJeU82STd6V0dtWmJzNjFBRy9jUk8r?=
 =?utf-8?B?aWJrcEd2OEdtRXpjUXk1a3dwVXVYZGRpMXhzL1RrRUZEYWNjQ1VraVZ0VGor?=
 =?utf-8?B?NksvZERQbnB2SjJvMEVsYjFpdm1ram5zdkZpdFpXZVhEL2dOZHlDeVVMY3pT?=
 =?utf-8?B?OGhscFFwYk1sbUlHYXVaNjZTNWFPeTFMdW81blpKZ2NKcXNDcGJEalBycGNN?=
 =?utf-8?B?WWNtRy8rSjhFNkh5OURnbFhZQ2R1L0FFVHJTVlBIZXJYanlpNnMwQzIvMWdX?=
 =?utf-8?B?Z2hoY21YQ2ZHLzRFTWtQOWdhQmFVT1YvSG5POERsOGtBYUw0V05xUHBZelFj?=
 =?utf-8?B?U2hBd3l1d3VPRnNWTWJER0tXdDJLenhKSjBHMmt0cllFcFhyR2JsMlowbE1x?=
 =?utf-8?B?MGpyWlNILy9Cdmh1M3lTV1NLMjFtNHM2NWp0RGVZTUZYMFNDYUp1OTl1UU1C?=
 =?utf-8?B?allzZTU1YUZkSUltNFlSZEl3U0pYdjlJRFZuMysyaGxYMEJJdUl1RmxmOUFD?=
 =?utf-8?B?NnZ0bzZnYVhaU3A0L0EwckwxLzVrY1QzNFdNTVI0WjQ1bnRFL0h2Zk0weGpV?=
 =?utf-8?B?eTZkTXNjQ1lwNW95YlFwcFN3SllvSmhsd0d6eHM1a2hSKytoNUhHYWYxbHFM?=
 =?utf-8?B?MHVZUXZqa0ZqNUFWK1RjNHRMY1JDOHA2OGF1QXQ5cndtb1gySmVHOUhsNXpQ?=
 =?utf-8?B?K0JQcUxMNDhVWEJWeDJLUEFhN2V1N01pUXpoR3ZXeFlPcmw4KzIxTzUxVHVy?=
 =?utf-8?B?RFY2UUpaeG9UWWYwVHhDRnd2eXQ4Qm5ya0RJVWZ2Rzg0aFo4UWdPbVR5N2RF?=
 =?utf-8?B?MWIvZTJadlBCZGY3eGR6K3ZYL01lTmNrMGpsUmEvOC81N3Vmak9VQUNTZkhP?=
 =?utf-8?B?SC8wWTZFTmx2dzlGSFE3cVpTa2w2T1JiYzFERkcrd1JKSGZSL0ZrZFlUakR0?=
 =?utf-8?B?aEJ1eXM2YTNkNGgyWVBPaEZLZ01tZFpMc2kyZUtxUlRpR0thMzhGTXlneCtm?=
 =?utf-8?B?VWFncWs4OWR6RXpaVUdGN1ZpemlYdVp2VThGZkVnUWhjR2hvQmx3b3hlSmIy?=
 =?utf-8?B?bzBnczJGblhvOW1Gc3BkYTVEalUwS05kK3dCMnNFVHpUSjNiUXZjclpTeXgy?=
 =?utf-8?B?RDVTQzYzbG9qYXJ1TWRORlE5WVMxNUVDYVVXTTUvUFJ5aXFQK2hqZ1pGK25L?=
 =?utf-8?B?clJNc3VYai95RVhSTWtlWThzU1ZmNFBnby84am40ei9yZTJTek0rTXl4RkQ3?=
 =?utf-8?B?RTdtZUYzWXFGZTRsM0pQZWVIYThaYy9xRjdLOFpLMTJYbUdUbFpqZGR6Ympw?=
 =?utf-8?B?ZHBUdzJGQlMvNUd0SjdEajFBR2J6V20rQVB2bUQ0SHdtZmRuWk5DZlNJTGhz?=
 =?utf-8?B?SVpKbmRoQ3R0M1E3SGJTVnJGQXVHc2RodVdQMHE3VEpGRlZUY2UzUVRnYlll?=
 =?utf-8?B?dVJWNHlWd3B3YlNBamNUZGEzTHNxTDE1NXo0cWd3SCs1V2ExcDZiQUkvL21O?=
 =?utf-8?B?cjhDQnZNZlRBWWE5bkJ4YVVyb1d5ZmdTNXlSSThPNzRmVlFQazVBVTlaS1Ez?=
 =?utf-8?B?NEtoNjJmbGFRV3ZqLzQ1NkJwLzZodytMaGRTQ1BUak1Lc0w4Tm5hSk8yRlUx?=
 =?utf-8?Q?PZMp9VJE7jLYQEW8=3D?=
X-Exchange-RoutingPolicyChecked: VgcD5msTOhdZjFBorya2/72ZfNDMjQrxEzjOFiha00lGcy+UpMvcOaNS3wer4L8b8hv9ohefwrMcJ9TMo3l4knvgrXiTWbie3eHGEdiDfgulpt2SdlI8r8KLe7YJy57wGscA23KQ5Jy/p6RGayCAl0hhRN2GX5bfiyYuJLi6GQmy26BmuPCKzxieppejdPsG7jtE2UDiLCrpZ2eIBF1IGZyFWq8slD+eOKNr46VwBlTZ3QwOjSCGhr8+mHDppjwEj1NTEb0/uuWGiGlRZbN7y6RdGPHPoWXwhN9taD1peBhprHfA+CtOWeRH8khDvopEmZDa502sP9hNCGxGVSFmKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43539483-5455-4488-76cf-08def283228e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:50:16.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCcWjdvhjrFwgF8qxOK+19JHL82ifWnkkU4GDSDytMKIWxwoOwqQhF7cRR5RsI0z4a3w7T7zogly7z9I4JFH9Bql1sfn/SUFVV7TV5fGQek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
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



On 8/4/2026 4:00 PM, Tales A. Mendonça wrote:
>> Are we seeing this on i915?
> I have not tested i915 on the affected machines yet - the
> instrumentation that measured the stalls (late-ack logging, kick
> results) is xe-only, so I have no comparable i915 data. I can boot one
> of the ARL machines with i915 for a few days and watch for TLB
> invalidation timeouts there, if that data helps.

That would definitely help, because if the issue does not happen on i915 
it likely means that we're missing a WA or something like that in Xe.

>
> More generally: both machines here reproduce reliably (~1 stall/hour
> on a desktop workload, much more under memory pressure), so I am happy
> to test anything on them - including any GuC build the firmware team
> would like data on.
>
> On Stuart's masking concern: fully agreed, that is why patch 3 is
> marked RFC. Patches 1-2 are pure diagnostics and stand on their own; I
> am fine holding patch 3 until the firmware side has been looked at.
> The data point it adds is that a doorbell ring unblocks the ack in the
> majority of episodes, while the severe ones ignore 8-9 consecutive
> rings - hopefully that narrows where to look inside the GuC.

Just a bit of a terminology update here, to make sure we're on the same 
page: we usually refer to the notification you're sending to the GuC as 
an H2G interrupt and not a doorbell. I'm making this clarification 
because the GuC supports a separate per-context notification mechanism 
that is referred to as doorbell and which we currently do not implement 
in neither i915 nor Xe.

When receiving the H2G interrupt, the only thing that the GuC does is 
look into the CTB and process anything in there; however, you've said 
that the contents of the H2G CTB are processed immediately, so the 
follow up interrupt should result in the GuC just bailing out and doing 
nothing because there is no data to process. It feels like when the 
issue occurs something is stuck in HW rather than GuC FW and triggering 
the interrupt causes the HW to get unstuck.

I have pushed the latest GuC FW for MTL here in case you want to give it 
a go: 
https://gitlab.com/dceraolo/drm-firmware/-/blob/f783b931555be057dafc2400b7eb4d445c953fec/i915/mtl_guc_70.72.1.bin 
. You can override the GuC firmware used by the driver via the 
xe.guc_firmware_path modparam; the path is relative to /lib/firmware/ 
and the firmware needs to be in initramfs for the driver to find it at 
boot. Note that we haven't tested this image on MTL, so it might have 
unexpected results.

Also, would you be able to capture the GuC logs when the issue occurs? 
The default guc log size is relatively small, so you'd have to capture 
right when the issue happens. However, you can make them bigger by 
building the kernel with CONFIG_DRM_XE_DEBUG or by simply modifying the 
xe_guc_log.h file to pick the bigger size by default. If you go with the 
latter, please also set xe.guc_log_level=3 on the command line (this is 
automatically added by the kconfig).

Thanks,
Daniele

>
> I will send a v2 addressing Matt's review comments (the
> __xe_devcoredump unification and the fixes on patch 2).
>
> Thanks,
> Tales
>
> Em ter., 4 de ago. de 2026 às 19:08, Daniele Ceraolo Spurio
> <daniele.ceraolospurio@intel.com> escreveu:
>>
>>
>> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
>>> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
>>>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
>>>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendonça wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This series is a follow-up to the TLB invalidation ack stall I
>>>>>> have
>>>>>> been debugging on ARL, tracked in:
>>>>>>
>>>>>>     https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>>>>>>
>>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51
>>>>>> and
>>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
>>>>>> the
>>>>>> issue above), TLB invalidation acks intermittently stall for
>>>>>> ~2.3s.
>>>>>> The H2G request is consumed from the CTB immediately and the G2H
>>>>>> CTB
>>>>>> is empty the whole time - the firmware simply does not send the
>>>>>> ack
>>>>>> until much later. The fence timeout fires at 2.25s and the ack
>>>>>> lands
>>>>>> tens of ms after it. Userspace blocked on the invalidation
>>>>>> (compositor
>>>>>> buffer unmaps etc.) hitches for the full window.
>>>>> Firstly, thanks for the patch!
>>>>>
>>>>> I haven't looked in to all the details of the sighting you were
>>>>> debugging, but we have had similar issues that were fixed in a
>>>>> later
>>>>> GuC version. I think around 70.60.0? It might be worth trying on
>>>>> something later than that to see if that helps... (+Daniele)
>>>>>
>>>> I think this would require an AR on our end to make a new firmware
>>>> version available.
>>>>
>>>> The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
>>>> aliases to MTL for firmware). (+Julia too).
>>>>
>>>> Presumably, the GuC changelogs should indicate whether an issue
>>>> related
>>>> this has been fixed. If so, we need to update all GuC versions across
>>>> both i915 and Xe.
>>> Right... I guess I'd still like to see if we can test this in GuC (or
>>> get confirmation we can't for some reason) before committing something.
>>> My worry is we will prevent bug reports like this by working around it
>>> and miss critical bugs that need to be fixed in the right component.
>>>
>>>> [1]
>>>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl_guc_70.bin?ref_type=heads
>>>>
>>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has
>>>>>> no
>>>>> Is there a reason we don't just re-use the main xe_devcoredump()?
>>>>>
>>>> This is my suggestion: the main devcoredump infrastructure is job-
>>>> based,
>>>> so it cannot be used for hangs that are not associated with a job.
>>>>
>>>> In my opinion, this is a gap on our end. Introducing something like
>>>> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
>>>> (e.g.,
>>>> TLB invalidation timeouts like those addressed in this series, or
>>>> more
>>>> generally any GuC protocol hang), makes sense to me.
>>> Ok makes sense. We can do that here. It would be nice to have a more
>>> inclusive implementation that lets us call this from anywhere so we
>>> aren't duplicating things around for different use cases. But not a
>>> blocker here.
>>>
>>>> I haven't looked at the patch yet, but at a high level, adding
>>>> `xe_devcoredump_gt()` seems like a reasonable approach.
>>>>
>>>>>> exec queue or job to blame - leaves a devcoredump with the GuC
>>>>>> log
>>>>>> and
>>>>>> CT state behind (Matt suggested capturing devcoredumps when we
>>>>>> discussed the issue; devcoredumps from both machines are attached
>>>>>> to
>>>>>> the issue above).
>>>>>>
>>>>>> Patch 2 logs when the ack for a timed out invalidation finally
>>>>>> arrives. This is what established that the acks are late rather
>>>>>> than
>>>>>> lost.
>>>>>>
>>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
>>>>>> (status
>>>>>> register read, CT flush, doorbell ring) every 250ms while an ack
>>>>>> is
>>>>>> overdue. On my machines this converts the guaranteed 2.3s stall
>>>>>> into
>>>>> I'm a little worried we're just papering over something here that
>>>>> needs
>>>>> to be addressed in GuC, particularly around GT going to sleep or
>>>>> something around the time we're expecting a response, so the pings
>>>>> on
>>>>> registers might be prematurely waking things up which is something
>>>>> we'd
>>>>> want to happen in GuC, not the KMD.
>>>>>
>>>> In general, I agree with this. We should avoid papering over the
>>>> issue
>>>> and instead fix it properly in the GuC. That said, this workaround
>>>> provides a pretty strong data point, since it appears to get the TLB
>>>> invalidation unstuck.
>>> So if we hit this issue I guess we're already going to have some
>>> performance degredation and the workaround makes that better. I need to
>>> look at the implementation, but we could be potentially introducing
>>> performance penalties in other areas doing these pings.
>>>
>>> Again, I'd like to see if we can fix this in the right place before
>>> implementing a workaround for it. Hopefully Daniele or Julia can give
>>> some direction there.
>> Are we seeing this on i915 at all? Given that Xe does not officially
>> support MTL/ARL and is missing several critical WAs for those platforms,
>> the approach so far has been to only update the GuC FW if it is required
>> for i915.
>> Looking at the GuC release notes, there have been a couple of
>> TLB-related fixes after 70.53, but they're both marked as only affecting
>> PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or at
>> least they're not listed in the release notes).
>>
>> Daniele
>>
>>> Thanks,
>>> Stuart
>>>
>>>> Matt
>>>>
>>>>> Thanks,
>>>>> Stuart
>>>>>
>>>>>> a
>>>>>> sub-500ms hiccup for the majority of occurrences; a minority of
>>>>>> severe
>>>>>> episodes ignore 8-9 consecutive doorbells, which points at the
>>>>>> GuC
>>>>>> firmware being internally blocked for the whole window. Full data
>>>>>> on
>>>>>> the issue. I am happy to rework the approach (different delay,
>>>>>> tying it to the G2H handler, dropping the status read, etc.) -
>>>>>> mainly
>>>>>> I would like the firmware side investigated, since no host-side
>>>>>> poke
>>>>>> can fix the severe cases.
>>>>>>
>>>>>> Based on drm-tip. Tested for several days on both ARL machines
>>>>>> under
>>>>>> desktop and VM-heavy workloads.
>>>>>>
>>>>>> Thanks,
>>>>>> Tales
>>>>>>
>>>>>> Tales A. Mendonça (3):
>>>>>>     drm/xe: Capture devcoredump on TLB invalidation timeout
>>>>>>     drm/xe: Log when a timed out TLB invalidation ack finally
>>>>>> arrives
>>>>>>     drm/xe: Kick GuC while TLB invalidation acks are overdue
>>>>>>
>>>>>>    drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
>>>>>>    drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
>>>>>>    drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
>>>>>> +++++++++++++++++++++++-
>>>>>>    drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
>>>>>>    4 files changed, 243 insertions(+), 4 deletions(-)
>>>>>>
>

