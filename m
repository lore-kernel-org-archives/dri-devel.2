Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A210C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C4610E54F;
	Wed, 19 Aug 2026 11:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cnJGT2iJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A110010E54F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787137754; x=1818673754;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mng1iH7YPoNOpCjW7O/9iKKshG6mBdVBuZMGrOLGLl8=;
 b=cnJGT2iJxocrbfu0JesC1LcRoDE01AVoB02hluuenovdST7sbHBQY7mc
 cojKwSH5zvNmAwC8s03t8pqPbJEV21QPrbMhtsR1ef9zW5HeteaoyH1A6
 m4F6SP8jsqxhJS/IMrZ9So66//tXCnmAqiCDh6MhSBp/kolv2txJhG5D0
 s44QlBwgIigrU5I1CVaB6VcI2q5n/oB034BRv2aE9qzwMaAwKhnckSu9r
 i/XPjlIJSw/iC2AixLiETzZaPwLyZYYyWQClHGRewjJKreQtalXkBKIs8
 ycX+cu1CJC2ndH9OFdcxrPRKjQxjlEpVN8VwPj40RL0jSBk7u0ff6af+T A==;
X-CSE-ConnectionGUID: b+Sfn7x2Sr6Q0JU7Rwpegw==
X-CSE-MsgGUID: HySfDbiFQteNcNONw8om1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98241749"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="98241749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 04:09:12 -0700
X-CSE-ConnectionGUID: AoxDuJeIQhKKpD9XAVU2bg==
X-CSE-MsgGUID: Ml9AOZwfQNmXRN9a65lnWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="263767488"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 04:09:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 04:09:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 04:09:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 04:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ/4pAwI78kWKuqtsim0EKtDuDfy0ya6M6+9hhUxZbgcu21+vrKcKbwaScwGDnWhJTldt2ueW13//zlyoyRfp6bN/hbImhXcKj6XCusMqehsl6qVfS3M9+QdpF2/fPP9CUskdY42XtncwD61XicRS/y0DUmCO6qEhyGGSM+hv14rvXaMQ/QfsSc62kJFgOrZEC0fxDAI2UR4zrniJRyVl/9WLelL00gA2GrDZ1u7UdlfAmUrVv65C5XEnRV5NKdlcXx4azEz9gLmxtBXX1jzPTnayRV4MUmYJaFJk+elnWA0OZ5cCK5o+dRIyh/rEAO7MhJUxkjIZugiOSBCCloqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFxX8VUrJ6Qm6rSdoR5D3i31mq1VvKbEnZ7hmpOSaNY=;
 b=T5WAPA0d40YLX2E4BjftPNAG2LtSPSuF8OqmScMcIm8nueBly8hdn3iNUhIoqoGtjph6TYaiJmgnAihm70vPieFWkoCpZxgVWtXAEdCMRokHpl1f5ikazN79YZe4kf5lvdlJfE5AGt6Pn5q05HCzdG0MiUBt2qCS2cBTGPACISsxcQMQc2io4gs5Hp7AZdZvRcXPho6iKvAEBMSMxn4n08mMa2rAKgysvT7h8oYcpbd4bcxPQPUDdj/9US5FD/RdM5LZAoRN15HXbDjOJ0q7Tq6HChLwTIDORY0qbnfmkndI7BPNnoFNvHgqFTglJDrcfRWAboRHjIn0tnWYjeihNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by LV8PR11MB8699.namprd11.prod.outlook.com (2603:10b6:408:1ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:09:08 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:09:08 +0000
Message-ID: <685c687f-3f84-4af7-af23-452c2a1b2b3d@intel.com>
Date: Wed, 19 Aug 2026 16:38:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/drv: Convert wedged event string building to
 seq_buf
To: Raag Jadav <raag.jadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <jani.nikula@linux.intel.com>
References: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
 <aoUxBx5mNi7o3K3L@black.igk.intel.com>
 <56c19f54-529f-4e91-9859-5add0afe0891@intel.com>
 <aoWK5PnCNDJYHFv9@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <aoWK5PnCNDJYHFv9@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::16) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|LV8PR11MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: b56c79e8-e9b4-4cb3-b69e-08defde249fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UatzkwWPmbOl3nAJcNYoba7gkL1XQxMXugiyj0tRuWEGN5m+0ZhWkKLJywzJJLFvcunl/8wijMOIWEUeGRIRLcbCo2V5QdMd4Ji4MdxGdQwYErfyOABMODiX7J0AqaU+AnZ2xlVkgSCKvjOmd8KTFq+LkLkFy0DjtPQv/uoYHRur+C8SQituyIw83gIL14GsxbXtmQohER+saqvvttUNh+SuV398vJWYPXv8Pc6ExY2+p3k+i+QVF2kHl0hRCsoYOQ2mEPhwDqIHDJqfOr759Kkpvsc7RN66OoPjqqubSgUkPYut7WLCKkbZk4RTILgTGAbXYyIwd1D7dlVNSeKwYJtJagjG5qDsCs4Mx3wOiQws4UdtmweP2XQhIkR+Is9de5CK69bhebxVhgXZ5GpBGCNFOmOv9Dhm/KqXwsgMFI0fXVRNNOpBC6FltVkw/AlncslVBRNaQN1JXt3iOdnowSe51iPI1d7suxqbf23Z4masjhMszTVkpnMXtbTtk0T1K/HQ4Nn6G4ieOLz3kJ9iAB+Thtra8dp3Ho9WtLerVjnR1nexmW0XCVacLhHNeoFrn52X9stbRCx81iSK5AZaW7NJpqLBeeO3QIjr7/NVIds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitobUpNQkplTXVobkpxU0oxemVzOW1lN2l6enVOT2wxMlJsZlZiczJpS2pN?=
 =?utf-8?B?UHBHaDV1Z1JjWCtXSTNweEVwRnRUZ1JtU2hGY2o2UTE4cFlnaTdaVEZPZkZt?=
 =?utf-8?B?K0tJdmlkZCt3bE4zZHo4YWlJalF1aDlIeGZpVVlqQUdKQnVZaVgwU1JpdGd3?=
 =?utf-8?B?QUFrdEp1cmpLUGZjS25TQUxOVXJYZEpFLytVbUh3S0szOWxaUnI3SlBIVmpI?=
 =?utf-8?B?Z3hSQmZqMURTWWJ6NUhoaTBOZmlsR25uVWdIbjliR3JTZWttNkl0Ull6UmFX?=
 =?utf-8?B?L0JXclVDWmFTZXcrRVFiMTcvM2xpUzVtVHFTUDNvb3NHUU8xMkp0L2UxUlFI?=
 =?utf-8?B?ajY1TGFKaXRLTjJXbzgydWM2RVNpRlNQaTdyWVRmU2hrZENMczRBQWRBZ1Bn?=
 =?utf-8?B?Ny9oUmJ1Q1l5YTdSamo5WnVRY01NTFovN3EvNFcwWHpzYnJwRXM5Y2pFOWZY?=
 =?utf-8?B?ZGwyOWVVaVZpc0c2UUFVcGhGUXZKbWQ5NHNIUGZ1akZaejJONHp0VXZ4M3Zh?=
 =?utf-8?B?aHhXenVsWEE2ZVVPMy9PMk16N3NPeG1BbmJKdDVhS2ZSRTV4RC9JT0NDRXJS?=
 =?utf-8?B?QmE4YUlaNDZOQm5SWDZTSVYwdWZjNU5kUDFmUWt2SVNSUVpXWUg5SmF0K0t6?=
 =?utf-8?B?Kzh3ME91Tk5Tcjg3VE14eEt0aUdSdm5RcDBNK2t3YnpRWmVXN2liekdQNmpT?=
 =?utf-8?B?TTFTSGpRdGxPelNjcXlBOGMxVi9jYkMyaFVWd2d4b2gyanh2K1UyNHk2RmJh?=
 =?utf-8?B?NFc5aFlvTEJyMnMvTVdkcm1adTlyd0xaQWVjTnk2K2tMbTVVRkt0dFVLa21W?=
 =?utf-8?B?enNadEtiSlR5QmtHYkh1UGpLelNMYmFBOEdzMmJXT2tuMEh6UFBHMnlYQnNR?=
 =?utf-8?B?VDBId1Iwb3VRdnQ4YWNIUjlJL2JBQ3ovbWhNMjZEd1RQL05SaG5Mdm1hMkpF?=
 =?utf-8?B?dkQwdXdKeDZ0eXZYeXJwbTBualRPUnc2dFBQZ1pFc0dMZitlMUhOd1pud0R3?=
 =?utf-8?B?U3VxVFF2Q2JLVjBSQ1drUkU4aDVwWGgySlZYaW11cFZKSlhablZDTlFPMzJE?=
 =?utf-8?B?c0JuR3B4QVpXMXEyUTZmNW5oU24zVnZZNXNUNkJiSVlVL0hwS2JNeG9YdVN4?=
 =?utf-8?B?VzhFbnJFclF3N2VnUHNQWmRnNGtvZ25VVkV5UFN0Q1VwanBJb3ZpZ3pEU25V?=
 =?utf-8?B?bXZvT2xTd3U0d3dNWDhFU2JKWkdJWlBZYVA5Q05rcFlEeGVZZnJDTld5RVdi?=
 =?utf-8?B?NjhoSEVsYnlQSnY0N2NucUU2eDFhVTVXYmNpRC81eENhRmhFWDYvU1dUQ3ps?=
 =?utf-8?B?a1UyVlllaEtyT2Q1UU9SbTF6NUVyWWwrdVUwZlRvMCt1OEw0aVcrSGNmblZV?=
 =?utf-8?B?OWxESEJaMk9iWXdWK2drWTJPNUczNFdBMU5Cbm85Vk52RXJpemFOVTZIY1Bj?=
 =?utf-8?B?Um94Z0k3dWZxeGJ4dmx1bXFtTm1CM1JrQkhCeVhYZVRrZk9uUlREc21rcGU5?=
 =?utf-8?B?TURwa2dMTjB2cmd2bG9LMzg4ZXFsdm1RcXVpV3h5RUFHc3FBUXBoUFNNbmZq?=
 =?utf-8?B?aXpZeStOZUJhM29waHFhSVR5dXd4T3l2QUZJVlNDWHJwdXE4NEJUSkNBYndy?=
 =?utf-8?B?eUpXUkhwMXdHZFBRUVoxaE94N0x1eTR0N0xZSFUvZUVuMllCRE1aQ2owNnZs?=
 =?utf-8?B?WFZCamhHVUJnQVJzY0xsTnpCR21odVE1MGFqS2kzM29ONEFkK0s0SEE4TEhw?=
 =?utf-8?B?N3dGbmN5OFRmcEZaSG5Qa0hhR2hLVzBQUDAvVFlGcUtmSklBSHd4LzdqckRl?=
 =?utf-8?B?ZXFXUCtXa3hHNlEzT3FxZFFINjNia2VVOWNBQ3hibThJR0FNRitNeXRyRUZo?=
 =?utf-8?B?UXN3TmcxamRJdWttTFVpM0dUcmUvZVdKUkZZNnYxaWxOZEUrUlplTEdXWkNj?=
 =?utf-8?B?eUNUcFNQanh5YjlsKzJEMGh6bmtneUkrTzdNR0tVY3VCUGNFbEdOL1RGaXZP?=
 =?utf-8?B?MzRSdGpET3NINnZjWTlsMUlHYWthK1RXNjU3TGYrZEdLWTNodGdYbGNhdzBY?=
 =?utf-8?B?RTNLUDJtRkE2clBmYWlNOEhuQWtsRVlWZWhiRjFhdG11Ky9zOTR4UGprbkM2?=
 =?utf-8?B?TXh1S0x5ek5kbUJzaXduWWhDT1ViR2R0OWVrSE1FbHBJT25DbWIwdGUzd1F3?=
 =?utf-8?B?bkhjQzl0dHYvamsxZ3AyZWtnbDVYaHlIZXVWR2FvS2tvczBtTUxNaG85ekF5?=
 =?utf-8?B?ZzYxODU0UWgxaHdUUlVoamFQQXhGOGJMemN1UmV0WWhXVzlYVG84bWxUYVQy?=
 =?utf-8?B?eDhMdDA5SEgyS0I3VC9YWTBlRitCMlNOa1haOHlva21vKzBhbDN1eE5PNEFH?=
 =?utf-8?Q?fja9qjI1rRVCYBkE=3D?=
X-Exchange-RoutingPolicyChecked: kLbXQkVjRKzYYcfwkVhJH99m6l+4D+FBudUZqix0hM1vPZ6QdgiidSyDS19Z+hZP5By+fHpKsgDDWtRBvof/0rFz/EcszRZrnwn623yKydyNuRpDhziG1SNu6VIK463vNfoXqYuNRtfNsexZ1/n7ke2Nt6VO2yyMyuySdAD2bizxUnu219Y0QfUulGOhN6o/z7o1JeTMECYS9dRp8FDYol9vwsD4r20YQ1CwJNSzf8KDxKtUe4AEuJju+DD/5BJidBNjq4L55HAkAT0WfRC4g+6mdDiWG1D0+tTXqC99+MB/6YnHnBpQ5jUooSHb4JHTwDXSS3zEQ6ijML8AesjbUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b56c79e8-e9b4-4cb3-b69e-08defde249fd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:09:08.2863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3kttCp4GyFFbdJMTxTNCJDXme1ue6UvlX5XFDARByWSz1/c/Z1UtFC//YFvgKODAyrGkFcEElM5IZoXkrciSbZLg/jBrGPhGrnsuhShyFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8699
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


On 19-08-2026 04:22 pm, Raag Jadav wrote:
> On Wed, Aug 19, 2026 at 03:48:31PM +0530, Mallesh, Koujalagi wrote:
>> On 19-08-2026 09:58 am, Raag Jadav wrote:
>>> On Tue, Aug 18, 2026 at 07:06:11PM +0530, Mallesh Koujalagi wrote:
>>>> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
>>>> The original scnprintf()-based loop required a manual pre-flight
>>>> bounds check.
>>>>
>>>> Replace the manual bookkeeping with seq_buf, which tracks overflow
>>>> internally. seq_buf_printf() writes each "method," token into the
>>>> buffer.
>>>>
>>>> On overflow, len retains the position of the last
>>>> successful write, so the trailing comma is stripped cleanly without
>>>> including any partial method name in the uevent payload.
>>>>
>>>> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
>>> This actually doesn't fix anything, it just adds a WARN() splat.
>>> So I'm not sure if this is needed here.
>> In previous implementation multiple recovery methods may exceed
>> WEDGE_STR_LEN (32) that
>>
>> cause silently truncate a recovery method and emit a malformed uevent string
>> containing a
>>
>> partial token, however using seq_buf makes overflow
>>
>> explicit, when it occurs, emits a WARN and include complete recovery name
>>
>> in the uevent string so IMO, it's fix.
> Is there an existing drm_dev_wedged_event() user that is facing this
> issue? Please attach bug reports along with reproducers (if any).

Currently Sashiko is already reported that issue, here is details:

https://sashiko.dev/#/patchset/20260720101815.526813-5-mallesh.koujalagi%40intel.com

>
> Improvements are good, but not everything is a bug because AI said so :)

Agreed!, however in future, if we support multiple recovery method, 
definitely we encounter such issue.


Thanks,

-/Mallesh

>
> Raag
