Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58DFF512E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 17:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8460010E027;
	Tue,  7 Apr 2026 17:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ei0oiDVm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB24B10E027;
 Tue,  7 Apr 2026 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775583277; x=1807119277;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wtz2HWVg3aAGmFjJouFNjLScEtb/N4Dh7N8CGt0Wpbw=;
 b=ei0oiDVmXwbujQhH/4TixnxXwcM7ma2Mic5ayKYqg/ddaCNwqh674vUC
 ucVOaTK+QAoskyCwNojTsLl6WotEvUhxHToRA3eO2jzPxTYLY/NuSlPvi
 VAcfU+/ccn4hVmwcr7nWyedrXmjhl/Rp/ncWgrVQTUuqhQHl6VuQq3pXh
 IJfXem59DgDiLe1FblZ46W1gs7OnGW0Au0BLY5ZNnx+sYmXQUROv0IOyb
 pssrsgYnyf+faZcFO84kbeVNPRjor5JbANyW9gyAnfTuDh/Yiq9WVyAfR
 /+RMC/YKhvF+FHGKLxtZsS9I3ZrL8t1h2f0fhZnAfAcAyklKNkYCrif55 g==;
X-CSE-ConnectionGUID: HK2KDBzFSRexbtt4Fmsi0w==
X-CSE-MsgGUID: V+gsLsxHSQOTD4Mj+jAKSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76447366"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; d="scan'208";a="76447366"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 10:34:32 -0700
X-CSE-ConnectionGUID: gv+EneftSVaYcskOTUBprw==
X-CSE-MsgGUID: 4JPZka7pTkCzDqmTOUCUNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; d="scan'208";a="251526182"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 10:34:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:34:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 10:34:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 10:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0X0IAQZ5W8TSN7fw7IAyYgRg2LyQEyaDvoaKIeo8NwRN7bnqWd/lBzxWPVKB7p8WRgzj/hU8/NnHeFWu/508A85KDWy/XHhA0Q/HeQYnpcgH2r7rnHbcczh4LHHLMYPJ0tKP6jI5OZTZwYHgirSfe5gVnzIVk5FAk8w8T988iMj2k1/Pfk3loMKAYHLqFc5Q+qQWy9O4BoIL9B1qEhmvADAhomL0JLXdieMwecfAsYxGqPMm0RLs99sdOcMIdhmtKMUJonfd/g63gCMMo843nzKCquqr0ggjdr1A/RuGr4jI8bCHhSvOj/0CDb7OfibscfNcDp93C5ePG/l3Zo0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA0smrHLpEwpzTx4tlxwsv1AfH4ynUS7BG7GWFgKOE8=;
 b=ljsF6MUhfOTI2PtS9X5CE+PWdGd+DY4aSzVc4vrQB6OHI+6gaUmyi8UZoHsJRWItkJNdXmwBtuob5WSuczoKZYwJ2bJHeSEVehuRK8PKmUAJQNOCHburIcNBiZGBJXlF+nFT9wlinq1Y4e5BlGX4ENGEo7wH1HmwRNWT5Lxvywp88KplJTV/Dq6zZT1PQs+mPTsnB/GLV8dfuLWfVVn7iu/C/o1P+D81LdeIGJZknUTN7F5TzEhLCdrRq+shScbP1HMe4eTQE1A6t0/oXVBaEUwltQXbPFEGC5NLWb+gYaWM7sDFg/3VnRrzvkPtu75qblpPsjNmW/xXoEyDeJ1alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 17:34:26 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 17:34:26 +0000
Date: Tue, 7 Apr 2026 10:34:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Daniel Colascione <dancol@dancol.org>, <dri-devel@lists.freedesktop.org>, 
 <intel-xe@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
Message-ID: <adVAHkA4gERWOszt@gsse-cloud1.jf.intel.com>
References: <87341fsa85.fsf@dancol.org>
 <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
 <d8e8f290-c2bd-483f-ba0f-735c503e269a@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e8f290-c2bd-483f-ba0f-735c503e269a@amd.com>
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd421c2-478c-4ac6-429e-08de94cbea4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BQ67M+hTprnBJ/yLy7EO8S8TOGk3aGSumKYO1gNFf0+7mSFLVj1Vjj0r5jLsIYkALtstHArBh99/9xRysAYUecY5KImEXM4Yvr1ZkIyxDzl8Uah6KDcKMCqUdRWxsbZ7qms3FP0x0o9zoG2URbMea/fEjxLsN2IqSkaCfFGXqRR1JhTQLrJM75G/re/vcnaCyArc8c1fYU/wuqsACIu9by61CNW1+NwH7m6Y3LcRnwTHr/wwuy+91BcY8NRrmJuZxPTZeclyLmchrolFfKBOta7U/M8ggv3C86GjPL5LrPSMygrIiL7D7ZCgUcCkNJD/XoFA/REdTfQmRDGI24+2PmwtqR2YNRzQ5XV4Ak7J/auNVbHWzjO7XMvJwUQmFPlkvKTe7NFmI4Cw+XltkDKq0nnb3j7l61O2QQYjWxktsoGUqEFbSpAN+IY7xP9PGwTKDkkZMZLHvU5jSTbeGekURENL9hms/a6XVKyEf3zc/WwIdSYA0iRMh6jacfvJ5BT1LXWxsm5qP/8X71BsLc7DWXYStUu0p/+XGadyp9jBIbW/7GoMChU+tHHxtarGEmvPN6LxwVx0RPFy+QRN32GMimVfFAzEa5E+jJksiY9LNQx3tHlxN7Bk+LMzocTsKNcymzqQcLEZELpHvFVBcWnuPe+VtryBHJRVZrzb+Yxpe7S3gQKJaqL9EB9T5YCJFo+5FnFrLpiETwdCaSaYS/mi/+7J7fy6FThQFKcJNYWRd6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3BsYURGVkFrSFA2RGdxK00wbWp3dkxJdjl0QUNaZGI3c2I0NzI5R2lpbnRX?=
 =?utf-8?B?dnZnNkNsbTBIVFJQQ1k5NUtJc3psMm5hdS9VUXB2MmRGTUN1Z3oyZlpPYXh1?=
 =?utf-8?B?Qzdqb2gvOEkycEhhTW5uazU2N2c0cGRBMkQyZFVnMDh2K1B6a2piLzM4bkdT?=
 =?utf-8?B?OTVsckFTdlAxVE5qanJHWnFjUjh3MHV5a1R3bGluUTZMMEhUWlNRNmZuWDJo?=
 =?utf-8?B?ZkZQREJnUDJUbFNTNmNvVGI5OGxWd2grVEc4L0Z3U2doUHovZTJDZTh3L0VO?=
 =?utf-8?B?OU55NHp2OVM0cjZoTFBtdFVMQldiUzBJQnJOWVZpWDhEZkUwdG40eU90TWQw?=
 =?utf-8?B?c2FWRGlodk92QSswMXVLd2hUWFJCOWsxQ1dqR2ZwYVQxdDExSUpRbEpldFM2?=
 =?utf-8?B?RmVHSVZUNWF3MW1OdkVKNEtUekM2ZThodExWRnVDYUdlSUpZWmdnaU9jZ0sz?=
 =?utf-8?B?Unc5QXJYUDRoNXJxK1cvb09sdk12UHB6T3c3cTd1K05FVGJ4NUNsTkVReWFi?=
 =?utf-8?B?Z2VVYjV1QWcrcW8wMlpqMENPaUNrRlBPcDgyallpdGdYTXJYOEFidVV6K3Zv?=
 =?utf-8?B?SnRnUW1EbzRuQ0xML1VsSU96blUxVWpNU050cUNnSjF5MU1hVWo3b29XaWNF?=
 =?utf-8?B?ck45Wnh3dFp6am5IcFJwN2EwM3lkbUxyYlJSUldpNTNra1JEQTJ0ZTRTOWda?=
 =?utf-8?B?Zm8za3dPZSt0UnRPbEtmTDZsVEZQK002M2U5WERiNDdTT2wyaTNXajhvOUFI?=
 =?utf-8?B?RnpML1dYNDk1UktpUlorT1VHVHNOYWFDek41QXhYNGhaTXIzQzhCOFBST1Ra?=
 =?utf-8?B?VUFMVmlZV1RMS05yMlZnRFNIcjc3em53ZmUwVmJEaFlHakswU0x1emFVTjky?=
 =?utf-8?B?cjdSTGxSTHZNb0pYN3piWndBeDRhQWJreCtGT0grQmRZWGx0cHAzS1UxMzNz?=
 =?utf-8?B?cExzTVRDSzBydnpXVmc0Z0ZuRXRzMk81bENJTWdGQUEwRWRqOTQwVVRNYk51?=
 =?utf-8?B?MEk0c0NYckZDRWhSSlBrL3lxQ05henhuWlF6NVJhWmZPNEdHQjhRQUFzMER6?=
 =?utf-8?B?L1F1aEcweTNqWFZvZjVqdkErbEF3RjA3Z1lhang0SUVPY1ZvTUs4d1JrY3Bp?=
 =?utf-8?B?Mk8wbXhGaEZhbFUrMHZFYkEwKzhNMXpkNE5zSnl4R1RTNCtBQWZUUzhVbjdm?=
 =?utf-8?B?T2lMTVNLSHNDMHlnZVdreDJPd0R0WEk4cmhXZ2JrQUpPMWhleEQ2V1ZRVjI2?=
 =?utf-8?B?QWVOLzk4alpOZzRHQ2MySE4rMHRONTVHTW5WaWl4MVdzODBPUmRCSCtVME1U?=
 =?utf-8?B?bE5tdm9Gd2xub2hCYUhUbWdYdktwT2dTZy9vbDVuUGhuQVhsTmltNDVNeCtB?=
 =?utf-8?B?eXVYeGw4MnVIWCtxeW81MS9ndk43RHFZd3ZLeVhmNjJFSUxVTEZHdGpGNXVN?=
 =?utf-8?B?R2t5RGh4NkVxb1ZseWdUVVNZWHhyWkVQNWFlSHhpSG01N3lDbElpTkhxRldk?=
 =?utf-8?B?bnI0RnVlek0vNU02YXV6L2JGQmc2aVpQa05qQVhYd2NubXgvV3dVYkQ4NCtV?=
 =?utf-8?B?dkkrUzQ0VllpVUgxUjF0blJ2YUg3bTFhZThPMkRHaTR0SkZMSVhiTEpvS2gy?=
 =?utf-8?B?aHhPN2FUVmlWazVHZUpMMEpoUTZGQVJIM1RGWXJrc1czQnhyaXhqV0F4K3Ji?=
 =?utf-8?B?NUZxSjV1MjZpWTVkajFmQko4UkdmMlJBa244VURzZVRHdnNKTGo5aElkbGlD?=
 =?utf-8?B?R3I3eFFaNlJURy9XeEcrcTRjUGlGWitvRzFmT3c5djZmSWwzU3dhUVBXcUw4?=
 =?utf-8?B?YzgrTDh1Qi9mcmV4Mm54clpJYjVVWXZmaTdhazVjbGFpcXhnbjVCUHFRa3F0?=
 =?utf-8?B?cVBlSEg0RkkyS0pwbDlXMVFkQWV0Q0lTQkowWGxGSFJyQ0ZjaDZ0QjIva3A2?=
 =?utf-8?B?VWUxN3h4cGxYM01oN2JxeXlORTBjRDdxcUExczhZblFvU0lrb3dJWWNlNWI4?=
 =?utf-8?B?a21tb0lmQmdPTVFOdGJFc1B4dFNrOEM3RjhuV1o3LzVvZ210VGVlZzh4QVYz?=
 =?utf-8?B?Tmk4RDY1TXpKa244T0Y3U3ZMVXBZclJBUktERlVRdXIvNXhEc2ZJL0ZWUW4v?=
 =?utf-8?B?SEFrTWRFRkFseE96UVBNTXVJRGhVSThMMnhTbGhEZjBjRVRkSkpZbDdmeHdx?=
 =?utf-8?B?a0V5aENscmMrdUtJdkc0b0hKc0NLamthd21KblpoeU5JRzVLTVJaSWJBOWZv?=
 =?utf-8?B?d0tPYmx6ZXNpV1AyMmRaY0ZwS2Q4dU5jUVJHQ3FOb3Y0R1UvM1JKSW1kRkF4?=
 =?utf-8?B?MGI2V0NUSzNlKzNOUUdwV1ltV2p4VUk0RENuL2VHSFprSjJ4VjlEZz09?=
X-Exchange-RoutingPolicyChecked: wELH3Nx9fC1o4A8bAVKjPYNYs/5X22LURUxgyiYaoIh5q3Mg/tYIIE50Dx8aHq6RqM+Yn8pBUyXmna6jTrpSyavhPuZAi3bh7HYhZj/hEG3OonIEqhYpfcgh2Ecz9w9YAafO/LEvDwncgYzQzUntPv9dHqGCciwujal7jz+Ao5BA9H3CX7MDZ2HgOZTFRfVqNCLqs7mz6gHuJwDom4LfiIgddDPNttZBBSJ3/wtN9LUgBqiHEeDxWAxhUljCW4TfRTw0Tv/xWJr+HhTFfjzIHZQvCKplxA1yNkHeaaTMIBqs8/PZ378ALaeJAmgEI2j0Fjdmc5dXsm446uHs2oPtMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd421c2-478c-4ac6-429e-08de94cbea4e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:34:26.5227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88LIXrZVoSPwkPOhClrguiCgCIN43OfMt+NjAwQBn2S3uJCv2x7PcdFTJ1HtIL/X9HhvJS3VInoummpXuijqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
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

On Tue, Apr 07, 2026 at 09:43:30AM +0200, Christian König wrote:
> On 4/6/26 23:02, Matthew Brost wrote:
> > On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
> ...
> >> -
> >> -       /*
> >> -        * Do not add latency to the allocation path for allocations orders
> >> -        * device tolds us do not bring them additional performance gains.
> >> -        */
> >> -       if (beneficial_order && order > beneficial_order)
> >> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> >> +               if (beneficial_order && order > beneficial_order)
> >> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> >> +               if (order > max_reclaim_order)
> >> +                       gfp_flags &= ~__GFP_RECLAIM;
> > 
> > I’m not very familiar with this code, but at first glance it doesn’t
> > seem quite right.
> > 
> > Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
> > diff, help?
> 
> No, not really. The problem is that giving 9 as beneficial order only saves us avoiding direct reclaim for 10 (>=11 is usually not used in a x86 linux kernel anyway).
> 

Yes, the first snippet was a bit incomplete. I adjusted it in a
self-reply, but that likely still isn’t exactly right either. I’ll also
take a look at how reclaim works at higher orders and how kswapd behaves
there—I’m shooting from the hip a bit at the moment.

> > 
> > If I’m understanding this correctly, we would try a single allocation
> > attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
> > still attempt allocations from the pools, and then finally fall back to
> > allocating single pages one at a time.
> 
> Well the code is a bit broken, but the general idea is not so bad.
> 
> What we could do is to use beneficial_order as sweet spot and set __GFP_DIRECT_RECLAIM only for the allocations with that order.
> 

That’s roughly what my follow-up snippet did, but with
__GFP_DIRECT_RECLAIM replaced by __GFP_KSWAPD_RECLAIM. I’m really not
sure what the correct policy should be here. But in general I agree
beneficial_order should be the sweet spot where we trigger some sort of
reclaim.

> This would skip setting it for order 1..8, which are nice to have as well but not so necessary that we always need to trigger reclaim for them.
> 

This has made me think a bit further. I’m not really sure the current
approach of TTM setting policy is actually the right choice—it might be
better to give drivers more control so they can tune this themselves.

Rough idea...

struct ttm_pool_order_policy {
	bool enable;		/* Should I call ttm_pool_alloc_page for an order */
	gfp_t reclaim_mask;	/* Used in ttm_pool_alloc_page &= ~reclaim_mask; */
};

Then, in ttm_pool_init, we could optionally pass in a table (0 →
MAX_PAGE_ORDER) that controls the allocation pipeline in
__ttm_pool_alloc.

This may be overkill, and it still wouldn’t provide per-BO control,
which might be desirable for cases like compositors versus compute
workloads, etc.

What do you think?

Matt

> Regards,
> Christian.
> 
> > 
> > Matt
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index aa41099c5ecf..f1f430aba0c1 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >                             struct ttm_pool_alloc_state *alloc,
> >                             struct ttm_pool_tt_restore *restore)
> >  {
> > +       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> >         enum ttm_caching page_caching;
> >         gfp_t gfp_flags = GFP_USER;
> >         pgoff_t caching_divide;
> > @@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >                 if (!p) {
> >                         page_caching = ttm_cached;
> >                         allow_pools = false;
> > -                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
> > +                       if (!order || order >= beneficial_order)
> > +                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
> >                 }
> >                 /* If that fails, lower the order if possible and retry. */
> >                 if (!p) {
> > 
> > 
> >> +       }
> >>  
> >>         if (!ttm_pool_uses_dma_alloc(pool)) {
> >>                 p = alloc_pages_node(pool->nid, gfp_flags, order);
> 
