Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF308CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E2510EE0E;
	Wed,  6 May 2026 16:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A4NkLgVm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503CE10EE29;
 Wed,  6 May 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778084063; x=1809620063;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=G44TVCMimFSli2E27uqo3Bz0Jsnfpt/+mSPXH9IV6wM=;
 b=A4NkLgVmZkdQPI8xea/6mTBfldsmy+HOIZi85VeaG9J2E2NMoveXJCAU
 7D5iYq6TA+i7orb0hlzH+5WJ2cD6RZs1oaVM4QRmwYu3qLYGBeBEUMqz6
 q6BjBXi+BlysZOWa7ug25PM5mE8ZVaNm+4JMq9vLMiG+z7iIxfGeguxgc
 PXa058pXHXuy8JGjTVOvTR5niWN+iys+iM5ZK9iK50HFCVsN37zBIdzSl
 7rcqVC7aSDaI3aXBTAGoN+nf85kBQYd3ibMz5BlCfwmlTTLfopwPVzCjZ
 smrudL3IT8lah/5Ze0YTeGDaXM2V6Dcx//fKtLEk91hwYixr8kkPl/aXV w==;
X-CSE-ConnectionGUID: y1Rtfy4hSyqQ5jAPzl8zeQ==
X-CSE-MsgGUID: 6g70h41oTciTFnGRTLYdQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82892646"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="82892646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:14:23 -0700
X-CSE-ConnectionGUID: zaGZ7352RZGz7rb/oy1dWw==
X-CSE-MsgGUID: xUQIWf98R8GMU2eXRZBRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="266541339"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:14:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:14:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 09:14:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb8H4szjVz41IQVEIa7l16KjlCyIusxChsCm2py/JxNEswfEmDbKH5240RRaqxZRtLtdtxZ8LkqZoKUIuyjMovCd5+JH5tdosqYtgXfT4EeC5baLCFosgEBIhtkxnGgnLYYXnAj8apavE4POO2PkCthjbHmvSmlXKpGDud8a/vY/H8rz7jZ3V2qDg5EqFLUGihD37uPf3xiuo+KG7cUbUuXVyAFiwvr/+fmf7iXN7J5RVPYkcCELYavAb+3k91Qi9lyeQ2aLl3mE2c8g76q94/vJPfsdqUhsL3S3qpx9M+DyTbilTbtRZDkJHcsHWzu7q/0M2B3B1BLPUPvpsGRPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyu8z+Pm2lDlaws7pgWebPicz0xSuk5oLk1vMkhg4Vg=;
 b=j6dcVJKQgPGDYgZSRXjZm4xMt5vcHkdbNGDOPh91qR5wfguDAXsisVhOSD0ajqw0tWggt7ThVtMn+lW7xaaAX3zgNORBpIXIqt351+Albj14JabHsf0lz3ZpVIExz2VhXLJhV9x2EEX5B+WYOepZobze2pyfmKAlKVoOP4ltbaAgO3qDk+THfYAcfhg2Exm7sreYuUd1mUZOzc8pGkntIpi3ycJlLqDYvCgdB1Cw+woLT2zFwCKc0Rz1lEKWvb3LKI3XLdkP3IHwiQUGODytbSzniOJY8zQaWlNn/FHzu0Zu2rqsWJFaroYttG+Bf+PtTOxWiQMZu3BoyNBRWHbLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPFB9A266170.namprd11.prod.outlook.com (2603:10b6:518:1::d45)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 16:14:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:14:17 +0000
Date: Wed, 6 May 2026 09:14:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] drm/ttm/pool: back up at native page order
Message-ID: <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
References: <20260505200443.3300962-1-matthew.brost@intel.com>
 <20260505200443.3300962-3-matthew.brost@intel.com>
 <47256c5547c75296af32ca87161188588cacf727.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47256c5547c75296af32ca87161188588cacf727.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPFB9A266170:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5bdaf4-b983-40bc-f05b-08deab8a8567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|20046099003;
X-Microsoft-Antispam-Message-Info: +dKjfJZ6sHwta/Z1zFZiG4/d/rm/6oFQzkjDH+A3PHtvOyncIan6ETQWGEzpJyv7GnJtIiil9pXJ3XxXKT6OgV0OmCbZIo/Y1rCpt1eRUQ8Vg9obh4RfOMioNZH1iJYIoUUFbJV9CnuFxaWPUrvJTg0DBopSY7fmwtg2YUQ47zO/CuMC995ocrYTdFqu+gPHj2b3krc1IOcSG2Ua8aAXBNrHryxNAShZ/Hz0pTBV7FFVfs3JuqMGlqHm+EgZX4LVpmglxsESPonRWmV8hcfR9DViRM5YhUr0PtC2bMPgEb/68SQfJSw1GsYmZx2GhAAJux/ptDPyBkk0tlsBxXs9JEfNOkqpHBfi2mHrnlHelY9L08Q2owrRI8exIbCFShvSbzq8Cizeu6AdVotTxWdx9dO0EuTSHByYPtsIR+WD5kJ07Sto+LbYVDQizyEfHKNpXF5opU9V4v5r80h+lO9xK2Xe1hHYejYizMpkAM/vLNnxgVmLIJ0Yehg1YhYeo7mpDoI7AlpCCYjSRbWzCKBoiEB8y9w/L5AtpvOGfWbtmrPB6Obu+qPM/3wUoIqA1pft+ICY28xa52i+BM4rHPoJwLZmoBgAIwE71AbrCPbCZabzSG41qBzSgLUdxiPZlDpQhhIfC4h3QA9zjg2wAtQ75g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(20046099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEN1UStHZ1hGb2VFU0FnWGhzSFNhcHJPc1pVYzYreENPOVpGWTdYS3RTVFRw?=
 =?utf-8?B?WTExYW9STmhmcnBGTnFYcHFnMmpHOXVlR0Zwb1pBMTY3ZEdnWDc3blkxdFE5?=
 =?utf-8?B?T1VkN3RTUzRCa0dSNU56R3Fma1U0My9mK2VTTVNHSmVaTUx2NzVaUWN4Y2dy?=
 =?utf-8?B?ditIcGo2MGpic2YwRWUvWlBxaWhUQ3lpNE52R1pabUdyLzNlM3dEYlBNM1lu?=
 =?utf-8?B?OS80MVNOMmh2UkpwYUg4eUtFby80OExDZlVWdVltOG9jSkZKblR6b2tESE5N?=
 =?utf-8?B?cG9NdjNJVGFzUldpQ1lzRkVFRmoxN1hvR2NmS3F0UEQ4VlVlQU1SV2JycGc0?=
 =?utf-8?B?bXE5cUVLQldkQnh6Z1hHcVpGd1hUR2tGY29lc1ZFdy9mK1RWYWZ5Zkt2amh1?=
 =?utf-8?B?K3U1WDg3Ti9KM1lhUVpucnNGRWZUMnFwL24vekdtMWgzWERvTHRxNytRS3Rq?=
 =?utf-8?B?Q2pEUlp4aFphWjR0VjVCcnJWdzZ4NVZIL2pSaHZrREZIRXlROXFpMVgxWGNh?=
 =?utf-8?B?L0RqWWJuRzMvZmJDK2d3ZmtHZHpqMnlKTkx2U2Z4SHVkVnd3b3huUlJrMWM2?=
 =?utf-8?B?aEljNFZmOURMUGxqdGgzb0tJd1YycWhNTlFpSHFuT2Z5SGNieWdJSHdLTGd0?=
 =?utf-8?B?dGRtVUxBSmFhZE5vNHU0aUlwNDJ3RitiT3JOa0pEUGJnbnNqQzdZaXlwaGJ5?=
 =?utf-8?B?N3I2UDBsV3I4dG1SZ3FXcFNVQ25OY0s4bSthT1k2alIyTG5LOG5iOG56d1hq?=
 =?utf-8?B?dkFTVXdRT0RYNk1SZnFlUktiazJOQis4LzZLMXdtL0FJdnQyeUhucWZxbi9p?=
 =?utf-8?B?Ry9kZjk0cnZXcitUKzVaTU1vSFpnSjdTNC9wSDJuWGJCQnNIcEpVY1paZjA1?=
 =?utf-8?B?LytFVzhXUU0rYWpZMEpMSFFRRDdNcUNsZnR5cEZEbXozd3VnaGpIaElReFhZ?=
 =?utf-8?B?cXBhZmZCSmpIRXpWOVUzYmNCUnNaVmdHTjYzZTdzdXJGNjVGeTdrR0NTWDJS?=
 =?utf-8?B?emN1bXEzQVk2bnFnTnowaGVlTkc4bEM1YXErQkMyZ2svNVV0NWF4VDFCMmR5?=
 =?utf-8?B?MGFOZW9GMHZPMC9lRXltQ2I3MHRYQWRBUE1GYVpTMHFUWjJQbUlLNUZSbXNU?=
 =?utf-8?B?a0lPNTFZd0p5RWVXR3pmdDVzaWNQL1J3ZkovS3piRThxMkdWSjQ3cHF1b2ZL?=
 =?utf-8?B?RGl0aEFiV0hBZXpxSXJacm1TT0pEaWR6OEhuL1pSR0l2MEJQV1lma1NoNnYx?=
 =?utf-8?B?aEIvKzlubnZhSUY1N2VpaGZILzBuMWF4ajVWUytQVUo4QnFoMStaNGJ6WW9y?=
 =?utf-8?B?Y0t6OXNsTnV0aUdnNHg2dXlwTG5JL0E1bTc1NXlPSWxRSmJkRGc3UG9QZnNu?=
 =?utf-8?B?dHBxTlA1bzZmVnRjMzNUTnhtVlFNOGZteUQ0WWdKc0NHM3NqTGhVY01OK2s5?=
 =?utf-8?B?T1Z3cU5XU3Zyb0l3dkFvNHF1SnAyRHUwSHN2dnE5OHJhSEc5YTZDU0hYSGFP?=
 =?utf-8?B?VWVWNHU0dUJOUkNldTdSNnNJaEtxRVdXTmVibU5kaFBMVmd1cG5uSHRXQjRp?=
 =?utf-8?B?NExXQ25BcE04UHF3WFREdnJ3d2hYZ1dQSXlsTHhobFpONThOVDFMTlFKblFa?=
 =?utf-8?B?cWRITkMwaE16bGpZZ2cycHJReEpTcnhoQ2QvZjV3dTJEaGFGaVQ3NGtRaGxH?=
 =?utf-8?B?T0VMNHYrMkZrQ01vWmEwM0NYcGlFMjVFMGhJTHVHMkNyM0kyVGxmd0JaOGxy?=
 =?utf-8?B?YUJoaXR3OWJZQ3BwdWprSkdpRTFIdS84T3JENWEySGRqNDFuMEJJbTh6VEUv?=
 =?utf-8?B?L2sxQzlRWmc0WjBvS0JGS3NaVGRsV1g5cmJheDZUNXlIR25kTXlQbG1hQWti?=
 =?utf-8?B?SDVKZ3pDbGhCRG9OWlRDdVJabHpxdmNuNkdkUFlhbExFQU00YURPcGxlM1ZC?=
 =?utf-8?B?YzhXekZKUlhkQStaVG9JRWo3UFNXWi92VnUvSkdQc1UvYmNMRTUwRFJLZmgx?=
 =?utf-8?B?OXI0QnZwdThPWFlVeWEwWDhSbms2U2pOMVJKUEwyalRCVGRRSU5FOGtFT1J6?=
 =?utf-8?B?SDJKa2dLRHZVYmJBMm4yc1dOV254V1ZyMUIvTVVWSVl0aE0yOTgzNC9JNExV?=
 =?utf-8?B?eUNPOURpVHdiTW1aR1h4ZzJwM1FWanR5OGF4Yy9jby9odVVhS0svdXM1Ni92?=
 =?utf-8?B?ekxER3hCNmFZUnFKMkRKUXlGL05Zc2REVURVdUdWdm1OeStpWlBCRnNvT3Vm?=
 =?utf-8?B?UllOVG5FdUYya1R5eXVvdk16UW5uMUVPOUZkYmFtcDY3b0N1V3V4Z0V3OEV3?=
 =?utf-8?B?a3UzVTdMSjU5U3BhN1Z3cFB2K2tHS0Jtb0tNelE1R3FBZnZ2SmNjWjZCWHM2?=
 =?utf-8?Q?Zgf8AmyaJWQ04D3c=3D?=
X-Exchange-RoutingPolicyChecked: p1H93TSphs0y1jQFHiunJ2OZJhSg1LkcMxweH5t/9QnS3TOW6aa0+bw8zm/ZJXxYvQRSz70j6ki2BQgTVldAZtfovztTZtn2kIpLlhKK+ATnrB7yIsY+BOZftkS3c+4UgrKYOwL0jsSQ82C1gwz+YeHYyLxmVQxJSnuDbDaGGg/F7BB19nxQ320mI/pTap35v8kTbGnHUt+xqJy/UujHZAvQLpdtG8olfZ8V2zaTDtkfCZR2+KW4Ptuick+v+qR+JjjmTfIj0Q8nX97nlQ/nGKUqQsklucVs7ggLWeZIX0DlA6GRZ9LTOG2KylfbmB1UEaZOPUHn+6Gfxw1PFSz3Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5bdaf4-b983-40bc-f05b-08deab8a8567
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:14:17.0407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTB9lU+rYbMJwiSt/fvA/QzhOt/AuQ7KZvKU2sgk/XfM24+v1GU8A9uahHKxaJ+26dogIqikTcjkRVAfkeFgeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB9A266170
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

On Wed, May 06, 2026 at 04:23:29PM +0200, Thomas Hellström wrote:
> Hi, Matt
> 
> On Tue, 2026-05-05 at 13:04 -0700, Matthew Brost wrote:
> > ttm_pool_split_for_swap() splits high-order pool pages into order-0
> > pages during backup so each 4K page can be released to the system as
> > soon as it has been written to shmem. While this minimizes the
> > allocator's working set during reclaim, it actively fragments memory:
> > every TTM-backed compound page that the shrinker touches is shattered
> > into order-0 pages, even when the rest of the system would prefer
> > that
> > the high-order block stay intact. Under sustained kswapd pressure
> > this
> > is enough to drive other parts of MM into recovery loops from which
> > they cannot easily escape, because the memory TTM just freed is no
> > longer contiguous.
> > 
> > Stop unconditionally splitting on the backup path and back up each
> > compound at its native order in ttm_pool_backup():
> > 
> >   - For each non-handle slot, read the order from the head page and
> >     back up all 1<<order subpages to consecutive shmem indices,
> >     writing the resulting handles into tt->pages[] as we go.
> >   - On success, the compound is freed once at its native order. No
> >     split_page(), no per-4K refcount juggling, no fragmentation
> >     introduced from this path.
> >   - Slots that already hold a backup handle from a previous partial
> >     attempt are skipped. A compound that would extend past a
> >     fault-injection-truncated num_pages is skipped rather than split.
> > 
> > A per-subpage backup failure cannot be made fully atomic: backing up
> > a
> > subpage allocates a shmem folio before the source page can be
> > released,
> > so under true OOM any subpage in a compound (not just the first) may
> > fail to be backed up with the rest of the source compound still live
> > and contiguous. To make forward progress in that case, fall back to
> > splitting the source compound and backing up its remaining subpages
> > individually:
> > 
> >   - On the first per-subpage failure for a compound (and only if
> >     order > 0), call ttm_pool_split_for_swap() to split the source
> >     compound, release the subpages whose contents already live in
> >     shmem (their handles in tt->pages stay valid), and retry the
> >     failing subpage at order 0.
> >   - Subsequent successful subpage backups in the now-split compound
> >     free their source page individually as soon as the handle is
> >     written.
> >   - A second failure after splitting terminates the loop with partial
> >     progress; the remaining order-0 subpages stay in tt->pages as
> >     plain page pointers and are cleaned up by the normal
> >     ttm_pool_drop_backed_up() / ttm_pool_free_range() paths.
> > 
> > This restores the original split-on-OOM fallback behavior while
> > keeping the common, non-OOM case fragmentation-free. It also
> > preserves the "partial backup is allowed" contract: shrunken is
> > incremented per backed-up subpage so the caller still sees forward
> > progress when a compound only partially succeeds.
> > 
> > The restore-side leftover-page branch in ttm_pool_restore_commit() is
> > left as-is for now: that path can still split a previously-retained
> > compound, but in practice it is unreachable under realistic workloads
> > (per profiling we have not been able to trigger it), so it is not
> > worth complicating the restore state machine to avoid the split
> > there.
> > If it ever becomes a problem in practice it can be addressed
> > independently.
> > 
> > ttm_pool_split_for_swap() itself is retained both for the OOM
> > fallback above and for the restore path's remaining caller. The
> > DMA-mapped pre-backup unmap loop, the purge path, ttm_pool_free_*,
> > and ttm_pool_unmap_and_free() already operate at native order and
> > are unchanged.
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > shrink pages")
> > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > A follow-up should attempt writeback to shmem at folio order as well,
> > but the API for doing so is unclear and may be incomplete.
> > 
> > This patch is related to the pending series [1] and significantly
> > reduces the likelihood of Xe entering a kswapd loop under
> > fragmentation.
> > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > exercised; however, with this change the backup path no longer
> > worsens
> > fragmentation, which previously amplified reclaim pressure and
> > reinforced the kswapd loop.
> > 
> > Nonetheless, the pathological case that [1] aims to address still
> > exists
> > and requires a proper solution. Even with this patch, a kswapd loop
> > due
> > to severe fragmentation can still be triggered, although it is now
> > substantially harder to reproduce.
> > 
> > v2:
> >  - Split pages and free immediately if backup fails are higher order
> >    (Thomas)
> > v3:
> >  - Skip handles in purge path (sashiko)
> > v5:
> >  - Refactor into ttm_pool_backup_folio (Thomas)
> > 
> > [1] https://patchwork.freedesktop.org/series/165330/
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 110 ++++++++++++++++++++++++++++---
> > --
> >  1 file changed, 94 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index d380a3c7fe40..78efc8524133 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1019,6 +1019,70 @@ void ttm_pool_drop_backed_up(struct ttm_tt
> > *tt)
> >  	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt-
> > >num_pages);
> >  }
> >  
> > +static int ttm_pool_backup_folio(struct ttm_pool *pool, struct
> > ttm_tt *tt,
> > +				 struct file *backup, struct folio
> > *folio,
> > +				 unsigned int order, bool writeback,
> > +				 pgoff_t idx, gfp_t page_gfp, gfp_t
> > alloc_gfp)
> 
> I don't really understand why we can't end up with a
> ttm_backup_backup_folio(), which I believe is the proper layering,
> already at this point? Please see a suggestion at 
> 
> https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/ttm_swapout?ref_type=heads
> 
> Here the splitting logic is kept in the ttm_pool, but ttm_backup
> supports handing large folios to it.
> 
> Although the cumulative diffstat becomes larger, the end code becomes
> smaller and IMO easier to read, and we don't need to introduce code
> that we immediately have to refactor.

That version looks fine too. If that is preference no issue.

My goal with this series is get something than can reasonably be
backported to LTS kernels so the desktop doesn't frequently enter kswapd
because of fragmentation. We now have at least 3 reports of this being
an issue.

This is larger fix [1] which works in tandem but seemly unlikely to
backportable given it add new concepts to the core MM [1].

[1] https://patchwork.freedesktop.org/series/165329/

> 
> But I'm starting to question the general approach: Even if the
> *shrinker* can recover from a total kernel memory reserve depletion, it
> can't really be considered a reasonable practice, since if we
> frequently deplete the reserves, *other* important allocations in the
> system like GFP_ATOMIC, PF_MEMALLOC may spuriously start to fail and
> people will have a hard time finding out why.
> 

Wouldn’t GFP_ATOMIC enter direct reclaim, hit our shrinker, and
eventually make progress—i.e., take the split path if needed? I’m not
100% sure, but my initial reaction is that this concern may not be
valid; however, MM is hard to reason about.

Again, FWIW, I’ve tried a lot of things to trigger OOM—for example,
running WebGL tabs and then kicking off various very memory-intensive
workloads from the CLI—and I still haven’t hit OOM or seen memory
allocation failures or warnings.

> So I actually don't think we can be avoiding the splitting without
> direct insertion. FWIW, up until recently when shmem started supporting

I agree direct insertion is better solution. Do you think this something
we could reasonably get working and backport? I haven't done any
research on direct insertion yet, thus why I'm asking.

> huge page swapping, other GPU drivers basically also split pages at
> swapout.

I wonder if other drivers have the same issue? The deadly combo is allow
GPUs to subscribe all of system memory, allocate THP pages (or higher
order pages), and split them in the shrinker. Xe might be the only
driver with right combo to hit this but not 100% sure without a deep
dive.

> 
> Another idea for improving on the compaction loop, perhaps worth trying
> is this change, shamelessly stolen from i915:
> 
> https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/shrinker_batch?ref_type=heads
> 

I'd have to give this a try - I'm quickly running out of time before I
leave for month though.

Matt

> /Thomas
> 
> 
> > +{
> > +	struct page *page = folio_page(folio, 0);
> > +	int shrunken = 0, npages = 1UL << order, ret = 0, i;
> > +	bool folio_has_been_split = false;
> > +
> > +	for (i = 0; i < npages; ++i) {
> > +		s64 shandle;
> > +
> > +try_again_after_split:
> > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > +		    should_fail(&backup_fault_inject, 1))
> > +			shandle = -ENOMEM;
> > +		else
> > +			shandle = ttm_backup_backup_page(backup,
> > page + i,
> > +							 writeback,
> > idx + i,
> > +							 page_gfp,
> > alloc_gfp);
> > +
> > +		if (shandle < 0 && !folio_has_been_split && order) {
> > +			pgoff_t j;
> > +
> > +			/*
> > +			 * True OOM: could not allocate a shmem
> > folio
> > +			 * for the next subpage. Fall back to
> > splitting
> > +			 * the source compound and backing up
> > subpages
> > +			 * individually. Release the already-backed-
> > up
> > +			 * subpages whose contents now live in
> > shmem;
> > +			 * any further failure terminates the loop
> > with
> > +			 * partial progress (handled by the caller).
> > +			 */
> > +			folio_has_been_split = true;
> > +			ttm_pool_split_for_swap(pool, page);
> > +
> > +			for (j = 0; j < i; ++j) {
> > +				__free_pages_gpu_account(page + j,
> > 0, false);
> > +				shrunken++;
> > +			}
> > +
> > +			goto try_again_after_split;
> > +		} else if (shandle < 0) {
> > +			ret = shandle;
> > +			goto out;
> > +		} else if (folio_has_been_split) {
> > +			__free_pages_gpu_account(page + i, 0,
> > false);
> > +			shrunken++;
> > +		}
> > +
> > +		tt->pages[idx + i] =
> > ttm_backup_handle_to_page_ptr(shandle);
> > +	}
> > +
> > +	if (!folio_has_been_split) {
> > +		/* Compound fully backed up; free at native order.
> > */
> > +		page->private = 0;
> > +		__free_pages_gpu_account(page, order, false);
> > +		shrunken += npages;
> > +	}
> > +
> > +out:
> > +	return shrunken ? shrunken : ret;
> > +}
> > +
> >  /**
> >   * ttm_pool_backup() - Back up or purge a struct ttm_tt
> >   * @pool: The pool used when allocating the struct ttm_tt.
> > @@ -1045,12 +1109,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  {
> >  	struct file *backup = tt->backup;
> >  	struct page *page;
> > -	unsigned long handle;
> >  	gfp_t alloc_gfp;
> >  	gfp_t gfp;
> >  	int ret = 0;
> >  	pgoff_t shrunken = 0;
> > -	pgoff_t i, num_pages;
> > +	pgoff_t i, num_pages, npages;
> >  
> >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> >  		return -EINVAL;
> > @@ -1070,7 +1133,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  			unsigned int order;
> >  
> >  			page = tt->pages[i];
> > -			if (unlikely(!page)) {
> > +			if (unlikely(!page ||
> > +				    
> > ttm_backup_page_ptr_is_handle(page))) {
> >  				num_pages = 1;
> >  				continue;
> >  			}
> > @@ -1106,26 +1170,40 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > should_fail(&backup_fault_inject, 1))
> >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> >  
> > -	for (i = 0; i < num_pages; ++i) {
> > -		s64 shandle;
> > +	for (i = 0; i < num_pages; i += npages) {
> > +		unsigned int order;
> >  
> > +		npages = 1;
> >  		page = tt->pages[i];
> >  		if (unlikely(!page))
> >  			continue;
> >  
> > -		ttm_pool_split_for_swap(pool, page);
> > +		/* Already-handled entry from a previous attempt. */
> > +		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > +			continue;
> >  
> > -		shandle = ttm_backup_backup_page(backup, page,
> > flags->writeback, i,
> > -						 gfp, alloc_gfp);
> > -		if (shandle < 0) {
> > -			/* We allow partially shrunken tts */
> > -			ret = shandle;
> > +		order = ttm_pool_page_order(pool, page);
> > +		npages = 1UL << order;
> > +
> > +		/*
> > +		 * Back up the compound atomically at its native
> > order. If
> > +		 * fault injection truncated num_pages mid-compound,
> > skip
> > +		 * the partial tail rather than splitting.
> > +		 */
> > +		if (unlikely(i + npages > num_pages))
> > +			break;
> > +
> > +		ret = ttm_pool_backup_folio(pool, tt, backup,
> > page_folio(page),
> > +					    order, flags->writeback,
> > i, gfp,
> > +					    alloc_gfp);
> > +		if (unlikely(ret < 0))
> > +			break;
> > +
> > +		shrunken += ret;
> > +
> > +		/* partial backup */
> > +		if (unlikely(ret != npages))
> >  			break;
> > -		}
> > -		handle = shandle;
> > -		tt->pages[i] =
> > ttm_backup_handle_to_page_ptr(handle);
> > -		__free_pages_gpu_account(page, 0, false);
> > -		shrunken++;
> >  	}
> >  
> >  	return shrunken ? shrunken : ret;
