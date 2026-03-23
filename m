Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C0EF483D7
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4629C10E49B;
	Mon, 23 Mar 2026 17:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fMddWDa6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068E810E04C;
 Mon, 23 Mar 2026 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774285745; x=1805821745;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=jDwOZgHoUypxttzviW1Vs8rCbrZEPYBaJqGFvpALlTs=;
 b=fMddWDa6vgndN62gNx47bPyeYEPMoGqYl2REDcZWEaokY0eipNjuVgrs
 BfW+XEzper7pkMSlvXvrNGuWiNtTY/cOGjeYl+2j9yhD97pDK/Ydeot6k
 Y8jpikpFfkc0ofRZEobIbdvS90ghFWPTG/VXumzjj3f29uMTREKo8s4cC
 mMLppWVJyr/qJWhSmRLf7Y5OR0Zb9OLPpqr6FTMXS5m4rdpOR4mjCbaQM
 a1oCl2cuGF8VNr/zPZQ54SnMg7xMr+7pdNJ3y0YzBxZQjyML/1B2A1yfY
 jMIwUaf4TeuB5R3JQQGmHsb/ln3XymrNpXKyW0lE1JC/bApixtaZtUMFE w==;
X-CSE-ConnectionGUID: LBMmaYrwRrGgxxggGTzcDw==
X-CSE-MsgGUID: 7Nxj8zmsRrKxsfD2g3NgaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75261439"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75261439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:09:05 -0700
X-CSE-ConnectionGUID: aFMtf/eLSvabNNDlG7qQZQ==
X-CSE-MsgGUID: dL5clyVRROyAG8cuCXxHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="223152127"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:09:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:09:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:09:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpj8GMyYpIhvajn0jh/7a2mEzl/Hxf35bUPnk6xRSdL9A7Yg1lEzYcL7+01RBFFgk6E0KaAAcG38PzKgdBIL+8A0RR13eFErlvfgs0jeXCKkliEmBXLuRPgxWXzSkWEwc4X+FJgNBAkZ05lAda1/DnxdYsmy/dULtnK7o2xVnodZHLJ6+Gt8OIIqXusrBxOFHvWVpyZZ62JSyDpQKOVUbkb2GvaGlbNeQvN/Udw67Lf2hIxBZUvtNstS2gvxjnBLvzfa+jyHPdtrGfw8ows3Y9zBAqw3ebxho+C/SCqbE/q8s35ZNXwWu2P4YPkiIfjGeb7DpBF3a3TotnufGFwYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPzKLqAZgyK0x5uO08P7tbtKFEkLFq3QtsVdr5BQ7qo=;
 b=BxwliOE5wynmdrQrP2qZUas9aE0bSGs/CZ1G5OK70LUwPXhtvfFASSTLiwdZyd+5Ux4eOt46wQv3g3n5BYYgeUvrnVDLMEbE7XwmDHmrOkuTsY/klwRoBVjukSo3wy5eRs+Zii6PjhZZzng6VV9OKZ+vrK2jZlGCKDRJyJpOLQJZ1OrqEq+2ZUCRt4T7BhNfNkR6foY0gWFviF5LaUhDh/W8d/0hM4L386eZN5FUIUCXBeS2VVVYNdUfzgwFWwHG1GoHJDFhoszaB/ho5yLKINH92OJ1BKPhWki0YhY5CUSjj+rsoPo/qOBG4i/IKPP5OE2/LcEC5MBZYhSWloVM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 23 Mar
 2026 17:08:58 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:08:58 +0000
Date: Mon, 23 Mar 2026 10:08:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323105504.2d9ae741@fedora>
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 018fdbc8-2304-4ec9-2115-08de88fedef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cmFC047XNtjvZ3OI22hcVinSj1+tqarvmn/DwwIKILTYMH82rAgLrITesA3tJCJjped63WCo3jzBAvwIOlRX2Q+UZyvStOMI+UipaI78wncYt5sZiic6FNuavt/g1tTHvdKTvcXXp9Qish8bG7Q7fUKPRuhtPMzeew72gsuoj1fKw9BE89jl0c/XvNWT2RJQNNhiJ5VqbUzdpb0L9YNk/OCmqzN35/XjIkAJaIN/taif2he7CbD+qX8Fz/3HYHu+TMDSHCMCKay75SckureeGEN9EViPB88C0uppGDZc9O76MU47bZ6RpzOlww+BP0Xu31CjYQ24cz3ymgeCGGQ22LjgXj5SdTWb8BfclqEtHqgo2Cbqk5XsVKbC2HpGLe6OAjWkjrX/K0C//3O2wAIOmsWRdjSKI/dSHaDhjd+V7/D91GzmHDD3UWBEpzF5pyQ3zwPs6hfd5mUox1uBv7sPp9oiN7ss5MtxInlpGzJWoD9m2nHPyvB2UpukTdQWPRbi5Oa3rCXi4KVz/xv9TKI1y2/hYVWEK0z2m4w5rOra1lzfmAQvAjnTOCU6LCcIdwGmoJT1PdSjTan6BVVx+76D977t7w8Uzly5RhgoBahdNqm7CvdnyhseeDVzjSL4YrfQRGNxoMTC+X21cF1aXz+SLixqAWVlpIiT5XJnavcpDJWrW2U5+6+XG0IR+KTyngjW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW4zZXVWQmJVOFM4L3cva2FLWGJ5MVZEOHRCYS9oTEVZVEN4bWM5a0QyUTVS?=
 =?utf-8?B?VXhxWFNndWMyQkk5NW5TeDlybS9jVGVPVWtoRmRGdHcxVzMzQWNJZndUZHVq?=
 =?utf-8?B?TFVDYXRKQWJLamoxUFBIRWRnK24zTW5JbVU5d2ZZOXpFZ0x6R1dCUzRHKytk?=
 =?utf-8?B?eTRCQVZvZHRuOTRsTVdMTVhaVTRGa09GMjRZVHRvYmRtK3dOTHNOOGd4UGpx?=
 =?utf-8?B?ZkRRdXArSEhSN3FZN2t5dVI0bnJ4aVlIa09wYUdWMnhIRmNNMWVYbGsyL2xv?=
 =?utf-8?B?dE1nWUJzaHV5VzRJc3QwZnNrRUlBNkE0K0RHL0plTTZ1YTF4QjBoYzFCSlBr?=
 =?utf-8?B?VGpxME0ycVU1ekdDYVd2VTFTbTM5RE5ETENGUUJqSEw3VEozdlVwcERGb21C?=
 =?utf-8?B?M3dSYTBYNEZsK25ab2FqUnRYenFVWE9GalV6TGJNbThEZjVidFJCaE1kZXRX?=
 =?utf-8?B?MmE2Mlc1V24zNTU5N1hkS2RzZjBycEpZaDh3dzViOUMyVEt6MWNmTzliNCtR?=
 =?utf-8?B?Rlcvekx5TEpwbmQyWXhYZlY0a1BwVDVYeHVSaFZWR1dHNS8vWWlzQUVNQjRV?=
 =?utf-8?B?OVowUWFkTzFmSGhKVjUvdmJwaGc4RjBzOHBsaDVrRDdmeUpBRVJJOEM4V3FW?=
 =?utf-8?B?RlJiTFQrdFpJbWx3eUJtUlp5RXNSanFZUGprVWJQaFdwUWpjNkFrc1F1cGJY?=
 =?utf-8?B?M3lpaHM2RVVjOW4zQkNMSHBBMVAwRHZBSjFIY0E0N1RJMG5kRXF6aE5pK3No?=
 =?utf-8?B?L3Fjam5FcG5hT0tjUDlsOGZPdDcvd2NTUUk4WDdkNXZ4aWU4aUVlSEdZQmF1?=
 =?utf-8?B?OUZKYUJtcjZTcVJUdmJJMUJqVVBGZW8vTTJCT2cyOFdWMGFvL0s3WEFDRVN5?=
 =?utf-8?B?UzdyMTNlM0R2SERRMUp4dEhEc3c1MUwrMXlOZmRBR0xtSkk0RW5KaVR4c21u?=
 =?utf-8?B?cHZTZ3hDai8rNXhEc1Q1Lzk5NSs4d1ViQzlLak95MmdmSjI0VWNmd2dnQ2tP?=
 =?utf-8?B?L0JVdGZybGduOHNpZUZ6VUFKaEVGVXk0ZlNJL2FUVEtEazBGS0JDQk8vSG8y?=
 =?utf-8?B?SDd3VGJSbmE3Qk9FYnIzWmd4c202aXB3ait6UW11UnBtWmZTWkM1SG4wMW9F?=
 =?utf-8?B?NDFVU3VVazFMVW1WYkV0TGxmZWZ0ZkQ4emdSMUpoMWk2NGZEMlliOXUrOU5V?=
 =?utf-8?B?ZW91SjV0QmNMS213VjQySWRFRWRmMFJiMHNrU25BbkxOV3dZdjhmWUR1U3ha?=
 =?utf-8?B?R3NJZGQ0aDVrSWgvazgvTittb3JZMDdCeUNPYkVLUVlQbUw5TTFIdThzUGZ1?=
 =?utf-8?B?T094d1ZYZHY4Z1BVazZGdC90ZStEUnk3dkNPblZyd1hOWVlMNWZiajF5RjNK?=
 =?utf-8?B?dW5WMjRNMEFWcHpmWkhlaXNpR1dpVlg1eWg1UzdrQTVYOU1Oa3BKa25UYjA1?=
 =?utf-8?B?WmwyOFRpVUt4NEJueGJsYzl0Y0s4OCtqTG5Gd3hQV1M1VldxejRWNHdDaGlS?=
 =?utf-8?B?QVFXbXVRaXE3Zk5ndU1oM1R2c2tGR3RZcEt3U3NTQ2hOS2xOS1pmOGJIVGZS?=
 =?utf-8?B?amlWY05RTFpQL2NUOThTZ3lmekltNEo5ajk3ODJ1b2lEWnhBN004c3REVnUv?=
 =?utf-8?B?ckxGdElmVjhhRkhLbUdYT2J1dUhqK0IrSGtvV3JVZnZmaHo0bmhhUGhod3JX?=
 =?utf-8?B?RWIxWFgvUjlLUkFGenNmVU9PLzYyN1ZLNVRBOGE1M0pXbElzQnd6aW5XaG9G?=
 =?utf-8?B?Sm5BcmoxbEs3emJlZW13OEtIWXhUTktQWFdvMTdEbE9QV1N0T21rc1RsVEth?=
 =?utf-8?B?NE1HSTc3dTdZMlpHWlZMWERzbTdmNVAxdnVlSStMQXdnK1hZVlNwRGRnSHRE?=
 =?utf-8?B?bjdWNis2Sis4TGxCWDU0d09ndEFZaGtQVUtLME5VUjEwR3IvdE91d01YRFhK?=
 =?utf-8?B?NmpDUlhsYi9IRHIyZzhGSDRTM1ltWHkzeVF6UWEzOEpjMytFY0pOZkdpWFdk?=
 =?utf-8?B?RWpIamIzK0E3V2JVS3dyUHJUd3hXVDZBZW9pcGxKSGhLYmlmMUNFaDNGeGVa?=
 =?utf-8?B?VDIvS3dMOC9JQ3JGRFIva1FYdkM3RUZFaElqcUJKemNYcmZkQ1I1Y3pwSHVH?=
 =?utf-8?B?dThHNHBSQmk4R0UzTkJjUk96Y0JLL0VuckJueExmZzkxYWtjdmRXVEZLWmJn?=
 =?utf-8?B?cHFSUnJuTlhXV3ZHdFJDN3VkRGRWUDc4VDA3SnpBTHMzaXZadW5OWG5BTUEz?=
 =?utf-8?B?bERBTU0zd1B4TGpBUThyZSs2K2pXQ0dNNy9oS0JiZXgza3licTkxc3QwdWZY?=
 =?utf-8?B?VkNRcFZndGQyNjA5SWxiWnd1QU1sSXZoK1NiYXlMSzIvM1drYUJVZz09?=
X-Exchange-RoutingPolicyChecked: iWFtiT+AMZw2VTeqBXreWl03RwMsjoZa1zCjDK7w7VzVXHIYpSLMGhQLupNCMHGIbsQZtObrl1ZQpR1qordh2H4yMjAUF+zw1R4LxqCiy1LEOEWcL9iauci3mfdARt1fTuGNoejMbK3A/tv/8SU/HZ5Ubq2HnOugAQdh4Jn7XOZdwnWlyFUneqqz0k/eFF98o9Q6dWFbJnLDYpde7/aKCga7bWnGZF274mPHK2PxsghFtLw9Ck5ZL/RGX9/JF/NFt8/tc6NparCsO0VC0DIuqbi7iYcDpkPU9V+Sktk4I1cDetuc5pBMpJtCtER6KlgMahE1X8uApIeM98mzDEH0Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 018fdbc8-2304-4ec9-2115-08de88fedef7
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:08:58.0056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS/jJcgTnB22xbiPmq1ugi2ZuH3Md1CoXfj9lucfJ/tOqJ8Ixio+s/BjQrF3MgdzK1dG4ZpWpMhP6oVX9NXjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
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

On Mon, Mar 23, 2026 at 10:55:04AM +0100, Boris Brezillon wrote:
> Hi Matthew,
> 
> On Sun, 22 Mar 2026 21:50:07 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > > > > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..2d012b29a5fc
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > > @@ -0,0 +1,675 @@
> > > > > > +// SPDX-License-Identifier: MIT
> > > > > > +/*
> > > > > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > > > > + *
> > > > > > + * Permission is hereby granted, free of charge, to any person obtaining a
> > > > > > + * copy of this software and associated documentation files (the "Software"),
> > > > > > + * to deal in the Software without restriction, including without limitation
> > > > > > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > > > > > + * and/or sell copies of the Software, and to permit persons to whom the
> > > > > > + * Software is furnished to do so, subject to the following conditions:
> > > > > > + *
> > > > > > + * The above copyright notice and this permission notice shall be included in
> > > > > > + * all copies or substantial portions of the Software.
> > > > > > + *
> > > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > > > > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > > > > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > > > > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > > > > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > > > > + *
> > > > > > + * Copyright © 2026 Intel Corporation
> > > > > > + */
> > > > > > +
> > > > > > +/**
> > > > > > + * DOC: DRM dependency job
> > > > > > + *
> > > > > > + * A struct drm_dep_job represents a single unit of GPU work associated with
> > > > > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > > > > + *
> > > > > > + * 1. **Allocation**: the driver allocates memory for the job (typically by
> > > > > > + *    embedding struct drm_dep_job in a larger structure) and calls
> > > > > > + *    drm_dep_job_init() to initialise it. On success the job holds one
> > > > > > + *    kref reference and a reference to its queue.
> > > > > > + *
> > > > > > + * 2. **Dependency collection**: the driver calls drm_dep_job_add_dependency(),
> > > > > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dependencies(),
> > > > > > + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence objects
> > > > > > + *    that must be signalled before the job can run. Duplicate fences from the
> > > > > > + *    same fence context are deduplicated automatically.
> > > > > > + *
> > > > > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> > > > > > + *    consuming a sequence number from the queue. After arming,
> > > > > > + *    drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > > > > > + *    userspace or used as a dependency by other jobs.
> > > > > > + *
> > > > > > + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. The
> > > > > > + *    queue takes a reference that it holds until the job's finished fence
> > > > > > + *    signals and the job is freed by the put_job worker.
> > > > > > + *
> > > > > > + * 5. **Completion**: when the job's hardware work finishes its finished fence
> > > > > > + *    is signalled and drm_dep_job_put() is called by the queue. The driver
> > > > > > + *    must release any driver-private resources in &drm_dep_job_ops.release.
> > > > > > + *
> > > > > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> > > > > > + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> > > > > > + * objects before the driver's release callback is invoked.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/dma-resv.h>
> > > > > > +#include <linux/kref.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <drm/drm_dep.h>
> > > > > > +#include <drm/drm_file.h>
> > > > > > +#include <drm/drm_gem.h>
> > > > > > +#include <drm/drm_syncobj.h>
> > > > > > +#include "drm_dep_fence.h"
> > > > > > +#include "drm_dep_job.h"
> > > > > > +#include "drm_dep_queue.h"
> > > > > > +
> > > > > > +/**
> > > > > > + * drm_dep_job_init() - initialise a dep job
> > > > > > + * @job: dep job to initialise
> > > > > > + * @args: initialisation arguments
> > > > > > + *
> > > > > > + * Initialises @job with the queue, ops and credit count from @args.  Acquires
> > > > > > + * a reference to @args->q via drm_dep_queue_get(); this reference is held for
> > > > > > + * the lifetime of the job and released by drm_dep_job_release() when the last
> > > > > > + * job reference is dropped.
> > > > > > + *
> > > > > > + * Resources are released automatically when the last reference is dropped
> > > > > > + * via drm_dep_job_put(), which must be called to release the job; drivers
> > > > > > + * must not free the job directly.
> > > > > > + *
> > > > > > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > > > > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > > > > + *   -%ENOMEM on fence allocation failure.
> > > > > > + */
> > > > > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > > > > +		     const struct drm_dep_job_init_args *args)
> > > > > > +{
> > > > > > +	if (unlikely(!args->credits)) {
> > > > > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	memset(job, 0, sizeof(*job));
> > > > > > +
> > > > > > +	job->dfence = drm_dep_fence_alloc();
> > > > > > +	if (!job->dfence)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	job->ops = args->ops;
> > > > > > +	job->q = drm_dep_queue_get(args->q);
> > > > > > +	job->credits = args->credits;
> > > > > > +
> > > > > > +	kref_init(&job->refcount);
> > > > > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > > > > +	INIT_LIST_HEAD(&job->pending_link);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > > > > +
> > > > > > +/**
> > > > > > + * drm_dep_job_drop_dependencies() - release all input dependency fences
> > > > > > + * @job: dep job whose dependency xarray to drain
> > > > > > + *
> > > > > > + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> > > > > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel —
> > > > > > + * i.e. slots that were pre-allocated but never replaced — are silently
> > > > > > + * skipped; the sentinel carries no reference.  Called from
> > > > > > + * drm_dep_queue_run_job() in process context immediately after
> > > > > > + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasing
> > > > > > + * dependencies here — while still in process context — avoids calling
> > > > > > + * xa_destroy() from IRQ context if the job's last reference is later
> > > > > > + * dropped from a dma_fence callback.
> > > > > > + *
> > > > > > + * Context: Process context.
> > > > > > + */
> > > > > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > > > > +{
> > > > > > +	struct dma_fence *fence;
> > > > > > +	unsigned long index;
> > > > > > +
> > > > > > +	xa_for_each(&job->dependencies, index, fence) {
> > > > > > +		if (unlikely(fence == DRM_DEP_JOB_FENCE_PREALLOC))
> > > > > > +			continue;
> > > > > > +		dma_fence_put(fence);
> > > > > > +	}
> > > > > > +	xa_destroy(&job->dependencies);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * drm_dep_job_fini() - clean up a dep job
> > > > > > + * @job: dep job to clean up
> > > > > > + *
> > > > > > + * Cleans up the dep fence and drops the queue reference held by @job.
> > > > > > + *
> > > > > > + * If the job was never armed (e.g. init failed before drm_dep_job_arm()),
> > > > > > + * the dependency xarray is also released here.  For armed jobs the xarray
> > > > > > + * has already been drained by drm_dep_job_drop_dependencies() in process
> > > > > > + * context immediately after run_job(), so it is left untouched to avoid
> > > > > > + * calling xa_destroy() from IRQ context.
> > > > > > + *
> > > > > > + * Warns if @job is still linked on the queue's pending list, which would
> > > > > > + * indicate a bug in the teardown ordering.
> > > > > > + *
> > > > > > + * Context: Any context.
> > > > > > + */
> > > > > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > > > > +{
> > > > > > +	bool armed = drm_dep_fence_is_armed(job->dfence);
> > > > > > +
> > > > > > +	WARN_ON(!list_empty(&job->pending_link));
> > > > > > +
> > > > > > +	drm_dep_fence_cleanup(job->dfence);
> > > > > > +	job->dfence = NULL;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Armed jobs have their dependencies drained by
> > > > > > +	 * drm_dep_job_drop_dependencies() in process context after run_job().    
> > > > > 
> > > > > Just want to clear the confusion and make sure I get this right at the
> > > > > same time. To me, "process context" means a user thread entering some
> > > > > syscall(). What you call "process context" is more a "thread context" to
> > > > > me. I'm actually almost certain it's always a kernel thread (a workqueue
> > > > > worker thread to be accurate) that executes the drop_deps() after a
> > > > > run_job().    
> > > > 
> > > > Some of context comments likely could be cleaned up. 'process context'
> > > > here either in user context (bypass path) or run job work item.
> > > >   
> > > > >     
> > > > > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > > > > +	 */
> > > > > > +	if (!armed)
> > > > > > +		drm_dep_job_drop_dependencies(job);    
> > > > > 
> > > > > Why do we need to make a difference here. Can't we just assume that the
> > > > > hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> > > > > work item embedded in the job to defer its destruction when _put() is
> > > > > called in a context where the destruction is not allowed?
> > > > >     
> > > > 
> > > > We already touched on this, but the design currently allows the last job
> > > > put from dma-fence signaling path (IRQ).  
> > > 
> > > It's not much about the last _put and more about what happens in the
> > > _release() you pass to kref_put(). My point being, if you assume
> > > something in _release() is not safe to be done in an atomic context,
> > > and _put() is assumed to be called from any context, you might as well  
> > 
> > No. DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE indicates that the entire job
> > put (including release) is IRQ-safe. If the documentation isn’t clear, I
> > can clean that up. Some of my comments here [1] try to explain this
> > further.
> > 
> > Setting DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE makes a job analogous to a
> > dma-fence whose release must be IRQ-safe, so there is precedent for
> > this. I didn’t want to unilaterally require that all job releases be
> > IRQ-safe, as that would conflict with existing DRM scheduler jobs—hence
> > the flag.
> > 
> > The difference between non-IRQ-safe and IRQ-safe job release is only
> > about 12 lines of code.
> 
> It's not just about the number of lines of code added to the core to
> deal with that case, but also complexity of the API that results from
> these various modes.
> 

Fair enough.

> > I figured that if we’re going to invest the time
> > and effort to replace DRM sched, we should aim for the best possible
> > implementation. Any driver can opt-in here and immediately get less CPU
> > ultization and power savings. I will try to figure out how to measure
> > this and get some number here.
> 
> That's key here. My gut feeling is that we have so much deferred
> already that adding one more work to the workqueue is not going to
> hurt in term of scheduling overhead (no context switch if it's
> scheduled on the same workqueue). Job cleanup is just the phase

Signaling of fences in many drivers occurs in hard IRQ context rather
than in a work queue. I agree that if you are signaling fences from a
work queue, the overhead of another work item is minimal.

> following the job_done() event, which also requires a deferred work to
> check progress on the queue anyway. And if you move the entirety of the

Yes, I see Panthor signals fences from a work queue by looking at the
seqnos, but again, in many drivers this flow is IRQ-driven for fence
signaling latency reasons.

> job cleanup to job_release() instead of doing part of it in
> drm_dep_job_fini(), it makes for simpler design, where jobs are just
> cleaned up when their refcnt drops to zero.
> 
> IMHO, that's exactly the kind of premature optimization that led us to
> where we are with drm_sched: we think we need the optimization so we
> add the complexity upfront without actual numbers to back this
> theory (like, real GPU workloads to lead to actual differences in term
> on power consumption, speed, ...), and the complexity just piles up as
> you keep adding more and more of those flags.
> 

Fair enough. Let me measure the CPU utilization to get some data here.
It’s not a huge deal to drop this—as I said, it’s a minimal change.

> > 
> > > just defer the cleanup (AKA the stuff you currently have in _release())
> > > so everything is always cleaned up in a thread context. Yes, there's
> > > scheduling overhead and extra latency, but it's also simpler, because
> > > there's just one path. So, if the latency and the overhead is not  
> > 
> > This isn’t bolted on—it’s a built-in feature throughout. I can assure
> > you that either mode works. I’ll likely add a debug Kconfig option to Xe
> > that toggles DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE on each queue creation
> > for CI runs, to ensure both paths work reliably and receive continuous
> > testing.
> 
> I'm not claiming this doesn't work, I just want to make sure we're not
> taking the same path drm_sched took with those premature optimizations.
> If you have numbers that prove the extra power-consumption or the fact
> the extra latency makes a difference in practice, that's a different
> story, but otherwise, I still think it's preferable to start with a

+1, will drop this unless I have solid numbers to back this up.

> smaller scope/simpler design, and add optimized cleanup path when we
> have a proof it makes a difference.
> 
> > 
> > > proven to be a problem (and it rarely is for cleanup operations), I'm
> > > still convinced this makes for an easier design to just defer the
> > > cleanup all the time.
> > >   
> > > >  If we droppped that, then yes
> > > > this could change. The reason the if statement currently is user is
> > > > building a job and need to abort prior to calling arm() (e.g., a memory
> > > > allocation fails) via a drm_dep_job_put.  
> > > 
> > > But even in that context, it could still be deferred and work just
> > > fine, no?
> > >   
> > 
> > A work item context switch is thousands, if not tens of thousands, of
> > cycles.
> 
> We won't have a full context switch just caused by the cleanup in the
> normal execution case though. The context switch, you already have it
> to check progress on the job queue anyway, so adding an extra job
> cleanup is pretty cheap at this point. I'm not saying free either,
> there's still the extra work insertion, the dequeuing, etc.
> 

See above. I believe really changes if a driver signals fences in an IRQ
context or a work queue.

> > If your job release is only ~20 instructions, this is a massive
> > imbalance and an overall huge waste. Jobs are lightweight objects—they
> > should really be thought of as an extension of fences. Fence release
> > must be IRQ-safe per the documentation, so it follows that jobs can opt
> > in to the same release rules.
> > 
> > In contrast, queues are heavyweight objects, typically with associated
> > memory that also needs to be released. Here, a work item absolutely
> > makes sense—hence the design in DRM dep.
> 
> And that's kinda my point: a job being reported as done will cause a
> work item to be scheduled to check progress on the queue, so you're
> already paying the price of a context switch anyway. At this point, all
> you'll gain by fast-tracking the job cleanup and allowing for IRQ-safe
> cleanups is just latency. If you have numbers/workloads saying
> otherwise, I'm fine reconsidering the extra complexity, but I'd to see
> those first.
> 

Yep, agree on getting data here.

> > 
> > > > 
> > > > Once arm() is called there is a guarnette the run_job path is called
> > > > either via bypass or run job work item.  
> > > 
> > > Sure.
> > >   
> > 
> > Let’s not gloss over this—this is actually a huge difference from DRM
> > sched. One of the biggest problems I found with DRM sched is that if you
> > call arm(), run_job() may or may not be called. Without this guarantee,
> > you can’t do driver-side bookkeeping in arm() that is later released in
> > run_job(), which would otherwise simplify the driver design.
> 
> You can do driver-side book-keeping after all jobs have been
> successfully initialized, which include arming their fences. The key
> turning point is when you start exposing those armed fences, not
> when you arm them. See below.
> 

There is still the seqno critical section which starts at arm() and
closed at push() or drop of fence.

> > 
> > In Xe, we artificially enforce this rule through our own usage of DRM
> > sched, but in DRM dep this is now an API-level contract. That allows
> > drivers to embrace this semantic directly, simplifying their designs.
> > 
> 
> [...]
> 
> > > >   
> > > > >     
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(drm_dep_job_arm);
> > > > > > +
> > > > > > +/**
> > > > > > + * drm_dep_job_push() - submit a job to its queue for execution
> > > > > > + * @job: dep job to push
> > > > > > + *
> > > > > > + * Submits @job to the queue it was initialised with. Must be called after
> > > > > > + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the queue,
> > > > > > + * held until the queue is fully done with it. The reference is released
> > > > > > + * directly in the finished-fence dma_fence callback for queues with
> > > > > > + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() may run
> > > > > > + * from hardirq context), or via the put_job work item on the submit
> > > > > > + * workqueue otherwise.
> > > > > > + *
> > > > > > + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> > > > > > + * dma_fence_end_signalling(). This must be paired with arm(); lockdep
> > > > > > + * enforces the pairing.
> > > > > > + *
> > > > > > + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be called for
> > > > > > + * @job exactly once, even if the queue is killed or torn down before the
> > > > > > + * job reaches the head of the queue. Drivers can use this guarantee to
> > > > > > + * perform bookkeeping cleanup; the actual backend operation should be
> > > > > > + * skipped when drm_dep_queue_is_killed() returns true.
> > > > > > + *
> > > > > > + * If the queue does not support the bypass path, the job is pushed directly
> > > > > > + * onto the SPSC submission queue via drm_dep_queue_push_job() without holding
> > > > > > + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is either
> > > > > > + * run immediately via drm_dep_queue_run_job() if it qualifies for bypass, or
> > > > > > + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job work item.
> > > > > > + *
> > > > > > + * Warns if the job has not been armed.
> > > > > > + *
> > > > > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> > > > > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> > > > > > + *   path.
> > > > > > + */
> > > > > > +void drm_dep_job_push(struct drm_dep_job *job)
> > > > > > +{
> > > > > > +	struct drm_dep_queue *q = job->q;
> > > > > > +
> > > > > > +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> > > > > > +
> > > > > > +	drm_dep_job_get(job);
> > > > > > +
> > > > > > +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> > > > > > +		drm_dep_queue_push_job(q, job);
> > > > > > +		dma_fence_end_signalling(job->signalling_cookie);
> > > > > > +		drm_dep_queue_push_job_end(job->q);
> > > > > > +		return;
> > > > > > +	}
> > > > > > +
> > > > > > +	scoped_guard(mutex, &q->sched.lock) {
> > > > > > +		if (drm_dep_queue_can_job_bypass(q, job))
> > > > > > +			drm_dep_queue_run_job(q, job);
> > > > > > +		else
> > > > > > +			drm_dep_queue_push_job(q, job);
> > > > > > +	}
> > > > > > +
> > > > > > +	dma_fence_end_signalling(job->signalling_cookie);
> > > > > > +	drm_dep_queue_push_job_end(job->q);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(drm_dep_job_push);
> > > > > > +
> > > > > > +/**
> > > > > > + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> > > > > > + * @job: dep job to add the dependencies to
> > > > > > + * @fence: the dma_fence to add to the list of dependencies, or
> > > > > > + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> > > > > > + *
> > > > > > + * Note that @fence is consumed in both the success and error cases (except
> > > > > > + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no reference).
> > > > > > + *
> > > > > > + * Signalled fences and fences belonging to the same queue as @job (i.e. where
> > > > > > + * fence->context matches the queue's finished fence context) are silently
> > > > > > + * dropped; the job need not wait on its own queue's output.
> > > > > > + *
> > > > > > + * Warns if the job has already been armed (dependencies must be added before
> > > > > > + * drm_dep_job_arm()).
> > > > > > + *
> > > > > > + * **Pre-allocation pattern**
> > > > > > + *
> > > > > > + * When multiple jobs across different queues must be prepared and submitted
> > > > > > + * together in a single atomic commit — for example, where job A's finished
> > > > > > + * fence is an input dependency of job B — all jobs must be armed and pushed
> > > > > > + * within a single dma_fence_begin_signalling() / dma_fence_end_signalling()
> > > > > > + * region.  Once that region has started no memory allocation is permitted.
> > > > > > + *
> > > > > > + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the preparation
> > > > > > + * phase (before arming any job, while GFP_KERNEL allocation is still allowed)
> > > > > > + * to pre-allocate a slot in @job->dependencies.  The slot index assigned by
> > > > > > + * the underlying xarray must be tracked by the caller separately (e.g. it is
> > > > > > + * always index 0 when the dependency array is empty, as Xe relies on).
> > > > > > + * After all jobs have been armed and the finished fences are available, call
> > > > > > + * drm_dep_job_replace_dependency() with that index and the real fence.
> > > > > > + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and may be
> > > > > > + * called from atomic or signalling context.
> > > > > > + *
> > > > > > + * The sentinel slot is never skipped by the signalled-fence fast-path,
> > > > > > + * ensuring a slot is always allocated even when the real fence is not yet
> > > > > > + * known.
> > > > > > + *
> > > > > > + * **Example: bind job feeding TLB invalidation jobs**
> > > > > > + *
> > > > > > + * Consider a GPU with separate queues for page-table bind operations and for
> > > > > > + * TLB invalidation.  A single atomic commit must:
> > > > > > + *
> > > > > > + *  1. Run a bind job that modifies page tables.
> > > > > > + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> > > > > > + *     completing, so stale translations are flushed before the engines
> > > > > > + *     continue.
> > > > > > + *
> > > > > > + * Because all jobs must be armed and pushed inside a signalling region (where
> > > > > > + * GFP_KERNEL is forbidden), pre-allocate slots before entering the region::
> > > > > > + *
> > > > > > + *   // Phase 1 — process context, GFP_KERNEL allowed
> > > > > > + *   drm_dep_job_init(bind_job, bind_queue, ops);
> > > > > > + *   for_each_mmu(mmu) {
> > > > > > + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> > > > > > + *       // Pre-allocate slot at index 0; real fence not available yet
> > > > > > + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_PREALLOC);
> > > > > > + *   }
> > > > > > + *
> > > > > > + *   // Phase 2 — inside signalling region, no GFP_KERNEL
> > > > > > + *   dma_fence_begin_signalling();
> > > > > > + *   drm_dep_job_arm(bind_job);
> > > > > > + *   for_each_mmu(mmu) {
> > > > > > + *       // Swap sentinel for bind job's finished fence
> > > > > > + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> > > > > > + *                                      dma_fence_get(bind_job->finished));    
> > > > > 
> > > > > Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
> > > > > submit path. If we were to add it, it would be around the
> > > > > panthor_submit_ctx_push_jobs() call, which might seem broken. In    
> > > > 
> > > > Yes, I noticed that. I put XXX comment in my port [1] around this.
> > > > 
> > > > [1] https://patchwork.freedesktop.org/patch/711952/?series=163245&rev=1
> > > >   
> > > > > practice I don't think it is because we don't expose fences to the
> > > > > outside world until all jobs have been pushed. So what happens is that
> > > > > a job depending on a previous job in the same batch-submit has the
> > > > > armed-but-not-yet-pushed fence in its deps, and that's the only place
> > > > > where this fence is present. If something fails on a subsequent job
> > > > > preparation in the next batch submit, the rollback logic will just drop
> > > > > the jobs on the floor, and release the armed-but-not-pushed-fence,
> > > > > meaning we're not leaking a fence that will never be signalled. I'm in
> > > > > no way saying this design is sane, just trying to explain why it's
> > > > > currently safe and works fine.    
> > > > 
> > > > Yep, I think would be better have no failure points between arm and
> > > > push which again I do my best to enforce via lockdep/warnings.  
> > > 
> > > I'm still not entirely convinced by that. To me _arm() is not quite the
> > > moment you make your fence public, and I'm not sure the extra complexity
> > > added for intra-batch dependencies (one job in a SUBMIT depending on a
> > > previous job in the same SUBMIT) is justified, because what really
> > > matters is not that we leave dangling/unsignalled dma_fence objects
> > > around, the problem is when you do so on an object that has been
> > > exposed publicly (syncobj, dma_resv, sync_file, ...).
> > >   
> > 
> > Let me give you an example of why a failure between arm() and push() is
> > a huge problem:
> > 
> > arm()
> > dma_resv_install(fence_from_arm)
> > fail
> 
> That's not what Panthor does. What we do is:
> 

That's good as it would be a bug, just using this as a possible hazard.

> 	for_each_job_in_batch() {
> 		ret = faillible_stuf()
> 		if (ret)
> 			goto rollback;
> 
> 		arm(job)
> 	}
> 
> 	// Nothing can fail after this point
> 
> 	for_each_job_in_batch() {
> 		update_resvs(job->done_fence);
> 		push(job)
> 	}
> 
> 	update_submit_syncobjs();
> 
> As you can see, an armed job doesn't mean the job fence is public, it
> only becomes public after we've updated the resv of the BOs that might
> be touched by this job.
> 
> > 
> > How does one unwind this? Signal the fence from arm()?
> 
> That, or we just ignore the fact it's not been signalled. If the job
> that created the fence has never been submitted, and the fence has
> vanished before hitting any public container, it doesn't matter.
> 

Ah, this is actually a source of my confusion. I thought the dma-fence
API would complain if you made a fence disappear before it was signaled,
but it looks like it only complains when the fence is unsignaled and
callbacks are attached, i.e. once it has been made public.

> > What if the fence
> > from arm() is on a timeline currently being used by the device? The
> > memory can move, and the device then can corrupt memory.
> 
> What? No, the seqno is just consumed, but there's nothing attached to
> it, the previous job on this timeline (N-1) is still valid, and the next
> one will have a seqno of N+1, which will force an implicit dep on N-1
> on the same timeline. That's all.
> 

Ok.

> > 
> > In my opinion, it’s best and safest to enforce a no-failure policy
> > between arm() and push().
> 
> I don't think it's safer, it's just the semantics that have been
> defined by drm_sched/dma_fence and that we keep forcing ourselves
> into. I'd rather have a well defined dma_fence state that says "that's
> it, I'm exposed, you have to signal me now", than this half-enforced
> arm()+push() model.
> 

So what is the suggestion here — move the asserts I have from arm() to
something like begin_push()? We could add a dma-fence state toggle there
as well if we can get that part merged into dma-fence. Or should we just
drop the asserts/lockdep checks between arm() and push() completely? I’m
open to either approach here.

> > 
> > FWIW, this came up while I was reviewing AMDXDNA’s DRM scheduler usage,
> > which had the exact issue I described above. I pointed it out and got a
> > reply saying, “well, this is an API issue, right?”—and they were
> > correct, it is an API issue.
> > 
> > > >   
> > > > > 
> > > > > In general, I wonder if we should distinguish between "armed" and
> > > > > "publicly exposed" to help deal with this intra-batch dep thing without
> > > > > resorting to reservation and other tricks like that.
> > > > >     
> > > > 
> > > > I'm not exactly sure what you suggesting but always open to ideas.  
> > > 
> > > Right now _arm() is what does the dma_fence_init(). But there's an
> > > extra step between initializing the fence object and making it
> > > visible to the outside world. In order for the dep to be added to the
> > > job, you need the fence to be initialized, but that's not quite
> > > external visibility, because the job is still very much a driver
> > > object, and if something fails, the rollback mechanism makes it so all
> > > the deps are dropped on the floor along the job that's being destroyed.
> > > So we won't really wait on this fence that's never going to be
> > > signalled.
> > > 
> > > I see what's appealing in pretending that _arm() == externally-visible,
> > > but it's also forcing us to do extra pre-alloc (or other pre-init)
> > > operations that would otherwise not be required in the submit path. Not
> > > a hill I'm willing to die on, but I just thought I'd mention the fact I
> > > find it weird that we put extra constraints on ourselves that are not
> > > strictly needed, just because we fail to properly flag the dma_fence
> > > visibility transitions.  
> > 
> > See the dma-resv example above. I’m not willing to die on this hill
> > either, but again, in my opinion, for safety and as an API-level
> > contract, enforcing arm() as a no-failure point makes sense. It prevents
> > drivers from doing anything dangerous like the dma-resv example, which
> > is an extremely subtle bug.
> 
> That's a valid point, but you're not really enforcing things at
> compile/run-time it's just "don't do this/that" in the docs. If you
> encode the is_active() state at the dma_fence level, properly change
> the fence state anytime it's about to be added to a public container,
> and make it so an active fence that's released without being signalled
> triggers a WARN_ON(), you've achieved more. Once you've done that, you
> can also relax the rule that says that "an armed fence has to be
> signalled" to "a fence that's active has to be signalled". With this,
> the pre-alloc for intra-batch deps in your drm_dep_job::deps xarray is
> no longer required, because you would be able to store inactive fences

I wouldn’t go that far or say it’s that simple. This would require a
fairly large refactor of Xe’s VM bind pipeline to call arm() earlier,
and I’m not even sure it would be possible. Between arm() and push(),
the seqno critical section still remains and requires locking, in
particulay the tricky case is kernel binds (e.g., page fault handling)
which use the same queue. Multiple threads can issue kernel binds
concurrently, as our page fault handler is multi-threaded, similar
to the CPU page fault handler, so critical section between arm() and
push() is very late in the pipeline tightly protected by a lock.

> there, as long as they become active before the job is pushed.
> 
> > 
> > > 
> > > On the rust side it would be directly described through the type
> > > system (see the Visibility attribute in Daniel's branch[1]). On C side,
> > > this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or whichever
> > > name you want to give it). Any operation pushing the fence to public
> > > container (dma_resv, syncobj, sync_file, ...) would be rejected when
> > > that flag is set. At _push() time, we'd clear that flag with a
> > > dma_fence_set_active() helper, which would reflect the fact the fence
> > > can now be observed and exposed to the outside world.
> > >   
> > 
> > Timeline squashing is problematic due to the DMA_FENCE_FLAG_INACTIVE
> > flag. When adding a fence to dma-resv, fences that belong to the same
> > timeline are immediately squashed. A later transition of the fence state
> > completely breaks this behavior.
> 
> That's exactly my point: as soon as you want to insert the fence to a
> public container, you have to make it "active", so it will never be
> rolled back to the previous entry in the resv. Similarly, a
> wait/add_callback() on an inactive fence should be rejected.
> 

This is bit bigger dma-fence / treewide level change but in general I
believe this is a good idea.

Matt

> > 
> > 287 void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
> > 288                         enum dma_resv_usage usage)
> > 289 {
> > 290         struct dma_resv_list *fobj;
> > 291         struct dma_fence *old;
> > 292         unsigned int i, count;
> > 293
> > 294         dma_fence_get(fence);
> > 295
> > 296         dma_resv_assert_held(obj);
> > 297
> > 298         /* Drivers should not add containers here, instead add each fence
> > 299          * individually.
> > 300          */
> > 301         WARN_ON(dma_fence_is_container(fence));
> > 302
> > 303         fobj = dma_resv_fences_list(obj);
> > 304         count = fobj->num_fences;
> > 305
> > 306         for (i = 0; i < count; ++i) {
> > 307                 enum dma_resv_usage old_usage;
> > 308
> > 309                 dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
> > 310                 if ((old->context == fence->context && old_usage >= usage &&
> > 311                      dma_fence_is_later_or_same(fence, old)) ||
> > 312                     dma_fence_is_signaled(old)) {
> > 313                         dma_resv_list_set(fobj, i, fence, usage);
> > 314                         dma_fence_put(old);
> > 315                         return;
> > 316                 }
> > 317         }
> > 
> > Imagine syncobjs have similar squashing, but I don't know that offhand.
> 
> Same goes for syncobjs.
> 
> Regards,
> 
> Boris
> 
