Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC67C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A96310E7FB;
	Wed, 23 Sep 2026 06:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lAGK2YW7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1961C10E403;
 Wed, 23 Sep 2026 06:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790144380; x=1821680380;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cm88Vn1kc3+vthhK5u9VFqmpYG+RqovMmtE0iiUbWGo=;
 b=lAGK2YW7ZiN/6UTfaNW7xQE8wTzshyG+p5AYAPnVd71urjWDeTL1Ow+i
 votjJI7C6XteEX7ZhuYQWXnGhVGFmzQPHsp/qX9tuUDuPH4nUCe+YyQ1M
 b1eKA8VR3QFfHh4RxLhthjPm0xXwx+rULJbyHd0AthfgFWC0qH9+dv/au
 FsZFbomTT/F9GpM3xDzR18OVzLNmeTiEf9i/1VY0L4+fapnqapYlcEXgK
 +nmHD+80VdeZd3AH7n22kP5YTvhoNbHeA9TySJjhLajniO1HGzClMbCKY
 +SjpXPQXnkNsgv9MAXkPMLz0pZv6Y/2l11AmaVQnLHlsy7LgfFpRPlgTv Q==;
X-CSE-ConnectionGUID: +2M2dRAjTk+R6VeioSpnQQ==
X-CSE-MsgGUID: Dogj+DGaS+aWG6z1OSbvcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78359561"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="78359561"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 23:19:40 -0700
X-CSE-ConnectionGUID: s/RlFsZkQgmZmkIo8nxzaQ==
X-CSE-MsgGUID: yakqA1VqQDyyZXxSojAxag==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 23:19:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 23:19:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 23:19:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.39)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 23:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNhUby+VftoqZvOt+PVUeQjMoU0J9L1zwcTXm7iSvjMRjVotEXppv7PNhfGgeYozpQ17d13bild8JxHe+oiyd/UxBx0LrkMjE0y7L8dzP50oRmfvzDrAVqL2xW7G2rs4qMn9xcZN2oAY+RSMLU9j6X4hIAkcAoBC/zKUNwTB97PdSu9YDFZv0IJ4/fptUuIp+nnm3rJwbaunnmU5EctPGHXO/tQlUlOWS5LWGpcy8zpORUvxBaSAFIss4Hlh7+nRuXy1MjDp1/twHkxZHE4Ust1C3XmZJtMXNZboZNdYI1RLQR38+3zkqeviYUS/ghT98IgOwXna9Wba+NAGWX3SmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Xcis6hsGwshGmuQnBgzCL+sDgSvctJr6HpDskfXrk=;
 b=F9ydM8kARS9fyB8LGBkxLC5QZyhVG1SjJpF/SKmFRTpDM5Xy0ETciLxY0GiwVmsnXL+DCR+vVR53cvUafdcbjjzVNR2u5+eyAoTBftMQ7u59zDt+yFPryX28HXu/YsU/3qpzYeAq7d3h3QlMdcQR83iFfIjEHuf7xiwJqXNFp0E8SHE7iUwoUpsGQIze2dB3GCsNBNiO74N6MWcddk8Hub+yZv5BW6qm7iGfb4C86WCma9m/3lryNSCDRxteRULczNUotdtqdxCTYCeRsY+ywpzi44W5nZBTB2NIZaKUyg4tRM7Awq+7ijEEk98UnmQbmq+85sKRIYEADhXoz9/LmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:19:36 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 06:19:28 +0000
Date: Wed, 23 Sep 2026 06:19:19 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>, "Simona
 Vetter" <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm: Unwind drm device registration upon error
Message-ID: <r5hcjsnb54yvntn2a6epxaka52hsbo4ofynd5ntntamjpvk3e6@cfgq4xecszou>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
 <20260827143447.99553-2-krzysztof.niemiec@intel.com>
 <apC_eePJyeGnVQTG@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <apC_eePJyeGnVQTG@zenone.zhora.eu>
X-ClientProxiedBy: DU2P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::35) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfc9d5a-5cab-448c-a27b-08df193a9f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v38yAOO/Nf5PW9TX/7S4vyQSHKWOvfMptEdSjLlk/rk1neLdsJGsSskLvFQHhOrtdsJMjI0ztHqdIS2UBixenrxkJI4OYWY/E9hTrgdMCCOdvVD7JAA3AM6ohSgqbiQqXmGXnSYjzaSOOdXHae4GDEbplLrvVIDl+oIHcFYPr8uIx3vMdybjjvuN2s4Gmh4Y6jbSJOhxXmitMCd2esN2MIM4kb2IGXwmyKDDOO97LCt8nMCpSH/dLNTVK9BvmMyB9gn0Cl6JbnvMB9KtVi/AdoiwktZjT6jLX4M3/W2fu9sBD3gxryZVUp3IeIkWajzcL40WXfye1YsjaCzvoYuTR4v3u0eXU1QwP8fJ07zQVkHnXOv168P/7nqzL4j5C4/l6CP+E+OJK3oQyfI5Kjie7bil6LIc1dGeAcR8gDxC1ns4DA9uRILHnJfK5D9wu4Pf4glqNhLnMWb5UMs87v14k858h9QEl4mPJWiXKovbKxlVccNGhLpN9eiG1imrFcJajNmQeSPdHcG5Mx1VvS6jZk8L3KVEJt2PLjiw+f4Dv7aDdEolMSkwGEwqhj+fMtNUpehV7KgtOCKskrzdZ5nHCWfjuuHVKCX7HLRkTdBD18jGKJpxz078xxPtCfI0x6TmCqcxJY9OcENN26m3LWo7Qc/oNd6I1nO3PTdSVRmnVCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBVYmdIQ0dZOVZBc3NrT1hvcHhoUHZ2ZnoraW9KaC9DOUhqTktQZWltQ3F1?=
 =?utf-8?B?dHJLZFBJMzhkMWprOEFrcDRZNldKOHlHVlhNR2dVTk5Ob1pOTVgxdkVLWWpC?=
 =?utf-8?B?QXo5MlB3VmtjdTRINFFZNHRDSEErTmlFazdNUlJla3RNc2YxcjBQNWtTc3VN?=
 =?utf-8?B?aldFN215Y1BXVEhBRm9QVEg0Q2pFMmVKWFdZOHl3MkwwdHBMVG1QMjRaWFRt?=
 =?utf-8?B?QXo3ZCtkMW15SkUvUUg3Q1d2NTF0cjQ3MkliZ3kxaGFzbXo0RTBjZDVNK2g3?=
 =?utf-8?B?ZkdabmJzS1daRUtDQjBCa0hrZEM5aUVwRVpRb0NGclZ5Myt0cnR0Ym11TUdt?=
 =?utf-8?B?TWh1eGVRSWNHYTN0OXRFeU1UVzR5UUFWMDhRc2d6TnNWT0ZSMnNJMVdPaUk0?=
 =?utf-8?B?eTVOZ3RrSU95RExndkxuV1hvdklycm93OXRWa1JQWnhzV3FRdWtwYUtIODVM?=
 =?utf-8?B?VkpvdXk1WUZwc3VFYXJiSGt2WHVsVTdXWDJsK1FzQ0d2WENqWUljUnNDUklx?=
 =?utf-8?B?RFArVnZDQytOK0lQWk5QdzVaeHNSaVJVUkVRSmJEQjROSGpvdmw2d3lGRHBp?=
 =?utf-8?B?N3pQN01jaGFMRWRWdDZCZXpLL3l2ZFJGRGVhV0ZLRHJpR3lKU2E4czRFMXoz?=
 =?utf-8?B?REpQSGdUTm11NDRIMDR2anVyVURKdG96RG9aTE1YNUpXbXNFVWJDWmVZekV4?=
 =?utf-8?B?dTQ4SkUrQlFBRTFCbUhUZTNpVmp3Z0lYN0ZVMUpCYmxuTUY3WkdIQU85Rnp0?=
 =?utf-8?B?bTUrQmJ0RzhlaFhpbFJOak1TUEUwNlE5cXNTY3dTQkw4eWtadkhnQWJTc0RM?=
 =?utf-8?B?VjNIaXhYUlpCZk5Qejg3R1NUU3ROUzB3RjRvb2pvV1MyWHJUUWo1Ym5HNXJh?=
 =?utf-8?B?VXFBN0tqaUpOK1VCbHF2SmpvWi9QVjYvN0toNXlOZ2pzMXE3YkltOU4wTTVF?=
 =?utf-8?B?enpVSEI3UWF1ZFdieW1BdmVKK3lEMlpKaEhBRkh3MHg4S3R1Wis3ZHYvdmkv?=
 =?utf-8?B?QjJhTkhZTXZCUGZMeGZJVTNpVDd4NU1EMU5JOEcyV0U2ZnJJV2RsUTY3aGF6?=
 =?utf-8?B?MWViSTJ1V2h4NUdWcDRhdUFFbHZ4SVljb0lPZ2ZBcVVhQi9QU3RKQ2UxN2xV?=
 =?utf-8?B?NzliMStIL2lQT0xsTTVlMGMyUnEweGhlTFhJa1NQUGFNRXBWNWo1Q2tmTkJ0?=
 =?utf-8?B?Mk9OUHJzK3NFRU04TGxZOWpvQnZPVEZTb2RxeEVBY1VmQXlzb2p0K2RISU5L?=
 =?utf-8?B?NENYczlhOVRBZDBMbGJveVBIRXd0ZjhVUUdpK0ZLeHcrRTFtSXEramdSZWxx?=
 =?utf-8?B?WDcxVEROR0tBVGE3RXNjUVVNNnA2d1RhNlZwMVVkNzN6S0FDMXVMQnhpODRW?=
 =?utf-8?B?d3ZFM3VuSnFoTG9EMjJWK1Nib0VSdyszUXZJWUJXMGRiUkFPWWh5QWhxMDEx?=
 =?utf-8?B?bkJaZSt3QmROM0pwY0EyTnFqcnYwTXZleThPK1NTTU1HYTdxb0czSklxYklz?=
 =?utf-8?B?U3RiSHBrV2VERXRlQjFtQ2VrcmdsTFJlcnZDeU15ZmxuMnBKOXpvVHhjenB5?=
 =?utf-8?B?S1Y3TGd1T3Nob1JVeWNIZUFOZ1FmdGQwa1NTb1o4cVl1dHBqYmU2dnQ1dXZO?=
 =?utf-8?B?UDFLclZiS3lXd3ZGNVZLbGE0N2VDME4zVHF2eWJJZ056ZWQxMkRLVExPYlV3?=
 =?utf-8?B?RTR2N1p1cmFWMnIrUUU0SUxCL2VDVElybnNaeEROcnB4a1EzQjhtdWl0b3VH?=
 =?utf-8?B?OWhTU1I0ZVJCV2RISi91UGQxUEc3MWZXMTB0OGtjTkRqRU5TQjM2K05SOVp4?=
 =?utf-8?B?MkJ1Ri9tZDhSZ2pnMFpQV3gxd0l0eHlTQ2tWRGpsdWp1VHJYNHdHYzJmSndJ?=
 =?utf-8?B?TTh1ZWFxT0RYMjUwcUV3VXBWVFBreVpyaFowcUhjNGI2OWhsNm13REhrTUR1?=
 =?utf-8?B?QzJNN1BwVHRFb3AvN0FWZEdjYlNtOW5RMDUzNVU2c095YlY1dUJ5ZnlmTzlN?=
 =?utf-8?B?V2I5OVN1RTc0VDNJOU40YU9nUlVCaXN4QWxFSzd3MnYzaVYvRkxTb2pNQjJB?=
 =?utf-8?B?d05mMDZKUTFBdW1qd3JjQVMvamwxZUlFcDdvbC9tU3ZzOEN3T2p2L01SaGFV?=
 =?utf-8?B?SFVMNTRDcW9zYm9Vamc2anY4L0FTdk9neTR2eGRTcUkwVzJLQzhDdS91NXI2?=
 =?utf-8?B?blB0RnpLdXdpQUVEaW1XcTBDRlptdFViRHZveHZZTTJ4Sk9ibTNXMk5FRDZO?=
 =?utf-8?B?ZWJ1WStTZTdxT2hySDhpMzB2NXFMQkN6ZWdrYkxLZUhwSFpsU1ZMYXBuZHZY?=
 =?utf-8?B?SmlCZWZSbVZTS0k4a2c1SVJyNGgwUHRYNXliakYxYWlzdk1ONW1STno1dkMw?=
 =?utf-8?Q?s34w6yidIN75MUZc=3D?=
X-Exchange-RoutingPolicyChecked: hOdYBWvkx1yBsZw5/Wf7IBvnI2iYDevfGbGkQXJ925Usk5QyPuhp6/mfJJUrSjvh1bOOSvsdUA+BMib2H6wVOL/tU6dfmxsXIXIPn0NPf663Vvhn4zTFchb5q5j4ZmsPCFZ8A/Y32r71EieMXxME53vzePZTQL63MWX9+wfq1xdG38PWqOpmY9k/1ankjMcARNroCyFwPi5nf3BaRUIOyKXCwWXYgCIvolwemFbVmYdCdBYRg8zaMeo/KiQrIe+EcV03cwhXYHU4SJgAXty3/HZT7FXd6zmYSHAmHG1mbUzlscri/Ky6M6FtGgtEvJCRQKlnHoGZWJZwatOu4mAmtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfc9d5a-5cab-448c-a27b-08df193a9f98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 06:19:28.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPxuaPHicj5sl0MhS7Pw4bGNuPcI0AT0OcTcAkKv85ZLSTYzLyjzQM48yRD0HupoYSmvSDWN53zls8vczuqV2IGMV3/WghWEVjXhjPof9wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
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

On 2026-08-28 at 01:14:57 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> ...
> 
> > Amend the problem by removing debugfs entries and marking
> > registered flag as false upon error in drm_dev_register().
> > 
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > Co-developed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> > Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> 
> I think the right order should be:
> 
> Co-developed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> 
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index e51ed959da89..b98e8af6f1c1 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -1140,6 +1140,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
> >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
> >  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
> > +	drm_debugfs_dev_fini(dev);
> 
> I think sashiko is right here, this should be removed.
> 
> > +	dev->registered = false;
> 
> dev->registered = false should be set at the very beginning,
> maybe something like this:
> 
> err_unload:
> 	dev->registered = false;
> 	if (dev->driver->unload)
> 		dev->driver->unload(dev);
> 	goto err_cleanup;
> err_minors:
> 	dev->registered = false;
> err_clenup:
> 	...
> 
I think we may need another label. Currently, dev->registered
state is ambiguous, because it is set to true before the last
goto err_minors. That would mean that putting it under
err_unload would still leave a gap, where registered == true and
is never unset on the error path, if driver->load() would fail.

How about:

        if (driver->load) {
                ret = driver->load(dev, flags);
                if (ret)
                        goto err_registered;
        }

...

err_unload:
        if (dev->driver->unload)
                dev->driver->unload(dev);
err_registered:
        dev->registered = false;
err_minors:
...

-- 
Best Regards,
Krzysztof
