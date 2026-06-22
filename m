Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A86CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2769710E4AE;
	Mon, 22 Jun 2026 06:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WfXt/8mq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE5710E4AA;
 Mon, 22 Jun 2026 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782109419; x=1813645419;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=ADLA5Xdm3TI9VIwQRRhVIOQw4OLGYQ8envR2VkxYDY0=;
 b=WfXt/8mqkuT0NYkd6z6qo+m8tEY/8Jwtb7enviEIc3o0YuYMZV8sk7Vq
 HShYFXyy2u3Ag+pb/Q6s0deOjJRfu4CLjqYJAqXZ9jzn56KTyjXKnf4Tm
 31xae/1Q8cEvKw6hULaFMx6dMpKjT4vQAzdk/Jt+lUv8iehcV5hk10njB
 gT8b6mGkQ16V64zbCpbhZnhYgXN92nbUrl8HWSGs5Euo+PJbVtLywRef4
 VM/fkzbxl8ucGxQhVMDslIg45U7zCi0pd83wA4tgY1D9/1b9DyDwml5Pi
 Fow8tV2ifW5TtQHfcdOBIHFT4w3bmin49TJdfVAXtRYzcc4lrAK9gwOG2 w==;
X-CSE-ConnectionGUID: bCRWDR92QzaTkanmHF3Ymw==
X-CSE-MsgGUID: 8QPPuu2ARuOssfPEtlEgXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82943735"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208,217";a="82943735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2026 23:23:39 -0700
X-CSE-ConnectionGUID: GV598EEgQzS0UuFwBqOxYQ==
X-CSE-MsgGUID: 8zLvyasETziF0o0ahAKmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
 d="scan'208,217";a="279335253"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2026 23:23:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 23:23:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 21 Jun 2026 23:23:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 23:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH+aQ23t0jDMeqIkTlEGy4yrMDMf2GSOGSHaboMcypTiegjrTi/SYZnxqc3KcEiLCvx82VxRh2f4wg6b3oAKHjZZl5xWAshO9QKHM3sm3bQcRpYSj7mhhdbi2xf9v2r2WTqcL3qNM2lDEuh4bBxEVC0uAmCjkEDB5u8DMtRGjx1SWFtkSxZNgD5m23Z5C2e2wDSPkQbhYbK2i9yifO+WOOSjFEXb1fEnJkENj8bQ18HoecZgwlOJmnrjqTbNFxA0mLH50ofOHvJ/+gmAIfFf1VRX50Le3P8d44OsC4q/OGgk+sjrDisBsNOlbUBT0p7wq9fBn/ZeTQXXOyLsCRcGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxaLwAQcpoM30pQH/QoTcO0yfHYUtEJYp4lQpOTi/RA=;
 b=YJGWKkjptog4SoHqkkS/yAwe0h/QkxpUgQXEFe5lCY0RCSbblX1DcXe7EZf7Ki2ul9ag2/Kvb1hZe94lZuU+4IoNAvXHcknRT6PTgWyyAWxNoEpDfTu5ZuEzEJ1LEcGcTJ54RzDKyTc6v5l3DvsX22GdyUgp2Sx2JS+DbRc33XBAqqpkHc3opH8M26cK9jW04wWwsJvqDd/29nCO2LFE0OZIe9VQyFgkKvxjnGAnVOsx7oJoHpiTI/xkZ3Gaiuk/D/fa6SVHaGe+GotrH5sKGtjebFpxf4yjDQa7laF//yZjVa4bvDDnSbkEuD4xBSIsuRIajwTI45yjmIivgitXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 22 Jun
 2026 06:23:36 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:23:36 +0000
Content-Type: multipart/alternative;
 boundary="------------0LZg4mwRtBw0ocuF0fNNLEYP"
Message-ID: <c8bab444-74aa-4f03-b727-513784ead6d6@intel.com>
Date: Mon, 22 Jun 2026 11:53:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
 <20260612080722.26726-13-mallesh.koujalagi@intel.com>
 <ajiwXJuY0PrGq7Gj@wunner.de>
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ajiwXJuY0PrGq7Gj@wunner.de>
X-ClientProxiedBy: MA5PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::18) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ce38cf-ae57-41e0-5f80-08ded026ca6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: FKF1Kg9mbDWSKKJusblwnXX9xLFIEMsKwkJtO7fK2dYY57Psp/O0AgrqsEIwNZfdOr2eRA03tgjv1R1vN9a8WQ0ZY0ig71qnnicOURQkJHXe+sO8+/qZARbDVg8HgJaeEObFVbEFH5sKzRc2cANpE6dZgObui5I3ANQORyDENAkeI7J0VpgceWZnPxNgzVlgRESsz0OFCaORZTwMW0NDmUkxoz64hRcYhD4Mz7COtH/omS29WqFPdjIvDmGr87yZX0XVY00ySIBUqsTf8IewDjOshLNc45GO2d3gPhPKoWAWR2+ITWn874thplMgFHrYxzwLjHtDBmHwkUbdcwI2j5gEFBAjDoseV7JXPPkEIT2wn2eK107pIpUWeYe6JiBgGwdA4EsJyikbhAefBZ3d73BqrEyAuFG7JIYo52mUgsIgX2Q5spU2kUHWD5/cyXOUFfutzJCRG+5QQLP/x8I3SNn6HE99FFcpuHa3xkNGA5Vx88hxn0HOTvM0dHivVcveCY2jkOak0uwU0Nx+Un9W+MeWSjOhT+8vyAk9Z7iamPVU8YmRdUJ2dvwVF9rMSJFhSZhuW/i1Eh6ZF9Sd71gK3OeXMN35NrPsM3XA4SbXtO7U6RnkklO721cdfwypJ5KdtEBqrN4P1SfMS1Fh52CtUC2io/pV0aws6dgUyMLehx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZ2VjZQN3FpRUl5NXhTQis4cWRadDdKRHpZQUkxSFQzMFgzaW9rZHZEVWEy?=
 =?utf-8?B?cTRFUmR1bnBoY1pTOVBzQndXTWpRdHVXSFNUVUlLekVUV0orb2VXcEIvRnpq?=
 =?utf-8?B?aUVidlZTcmp4ZlY4cFozOWJVREdFSlUrSHM3WlYxajRBRnJWaDlEUW40QjVp?=
 =?utf-8?B?NElQVVBEVmE1UGozQXFjczZFc2hGMFVXZ0lTZkZEL0daNVhsRjhCaU1NSGl4?=
 =?utf-8?B?Nlk4YUlnSkgzazdpTGxCUXRiOUZEem9XNTFab3dxKyttOWd6U3RyQjhlVTNu?=
 =?utf-8?B?ckpSK2VmOHF3MGY3S1lzZTBZVlFvTnI1a1VTSHJMd2hjbTFURm5DSkwrNWVq?=
 =?utf-8?B?M0txMEpNOWFPaytwZzRUdDVKSTkvOTViV0ZJcUlXTXhGanVKMzZOclR2K0py?=
 =?utf-8?B?bUt5VjNQSHh1dStoOWJsTHNBMWZtZXYrSGdtcGIvZnBpa0tKOWpXNFJUVWFC?=
 =?utf-8?B?MkhXWHZoSVJiQUVoR1U1LzBQQ2ltUk1lVTdvNVNOQjE4Vk55V2toMjViSXc2?=
 =?utf-8?B?dW9HTmd5cXN5eFVuMEh1KzljTzZrU2tJenA1VmkvUXJXMVppSStIT3VzakRl?=
 =?utf-8?B?VU9Xd0pPZW1iTUFmRjhiQWt6ZThRdFVGNlNUeCtFdVpEWTdweXZmODFkNDNG?=
 =?utf-8?B?Zkc5bzJOTFlCaUZqYzZrNk9zRkVhTnZsMjZDaE05Y3lYU1R0bS9MdXVJTys4?=
 =?utf-8?B?VlVzQTdpaVZ3d3ZwdTJ6bkptME9NaytSbTF4bWxnZFdUVnlNRjZvM1Boc2hw?=
 =?utf-8?B?a3dPYm5LbVRSVlBXNW40R0xDNnFPMVZ0MjR4ejZpLzhtNlBGWXJoZ09FYW1S?=
 =?utf-8?B?TXphZWJOWklWQlNQWktUeWRtdnpvc3FwN1VNQkxzQWluRzZKT09uTzBRaU5F?=
 =?utf-8?B?alRiUllqMXBZYmN6bFZsVXNuSk9uWm1pNVBBQ3pmaUl5bUpneE41TEVRSkxa?=
 =?utf-8?B?Qm5wQ2pnWkU5NFRZSXRpMXBFbkVQUkUvYkpxYk5ycnBSZEhCL2ZiRE53eVhK?=
 =?utf-8?B?L3BvU3REOC8rdi9CN0I0eUs4QWRQZStYWlVVczBobjVwVU82Ti9PWjBQSlkx?=
 =?utf-8?B?NjZXL09MMnU5ZXZSYWUzVU5IUVpLeWs0WHE3eWhldTBQOEFDd3J1MWQwWjF4?=
 =?utf-8?B?K1dEZU5GQzlHWW5IYVBVSXYydkg2bnVnUXNtcUZuQ0xPMnlzRUNFc1l6RmdY?=
 =?utf-8?B?aVBKekZTTlM5bDR1YnFjUHk4UFhYaEs2bk1RZU1XSmQzMlY1czg2dmpSTDVa?=
 =?utf-8?B?Y2tqRmMxajJVSEZaWlRjVDFBOXNOUXIrVnlVSjVhWFl3dzNueVBrN3k1VzNQ?=
 =?utf-8?B?cXkyY0hUVFNFUFFpLzVPMzRYbGpCOEJnMXF4ZXpNODRQV1c4S0pDeDJHd29r?=
 =?utf-8?B?YTJxMDd1aVRjdytTdUVyTnZFb3pJcjc3djNZVnJnRTRsR290WGpKSlJzQkVS?=
 =?utf-8?B?K1NFNnVXT0FvVUtkUFAxM09kK3BjcGc5ZTBRZnNYZUxtSEx0MThURUdUZnNX?=
 =?utf-8?B?Y0h1SjQ1U0FkZDFuZVZ6N2kxWlV4VWFuYnV5ZVBpSmlEQW9YSERyNVN0d0M3?=
 =?utf-8?B?b2JSeWRkb1BZQ3hmZzh3TFRrQm1oMnZhR3BRNncxRFU5SmE5V3liWE5hVGll?=
 =?utf-8?B?cjZHM29zSjNZL1VUeDVBNDM4bUxBYWdwRE1kRllDNy9BZmV6dGlqNHFRZDh5?=
 =?utf-8?B?RlUxVVh4UWdTVW82cXJBMzMwYnp4SUZvRWhGaFdMNGVTYXRDNHpBZFdHM201?=
 =?utf-8?B?YnFOdms4bk5MUlZXdzQxeUdKZm9DeStvMXFmNkxtNHVhV3dUOXJ1WkFFQXZa?=
 =?utf-8?B?WEZmYW5hMno4dGFGUysvc3lvdytEUGJIQ3NTeCtUb3ZvQ3Q5ZExhZmZVUjJL?=
 =?utf-8?B?Ly9LZjlBNnFCSWt0MnY4YmMzcTE2N1dyTmJTUy9KalN2R2RDTmlEVjJzUWdo?=
 =?utf-8?B?eHB4bi9UU3o4bU9idHVPNHhHN1Y3Qm1yMGZMNmVqajNqcks5SFNvTjBKUFM4?=
 =?utf-8?B?ZGY2a1BteEhvUFVNY2pZdkN5MjhCejA4bWFwMUl6djkxSEduWUVOSjI4Z2R3?=
 =?utf-8?B?Uk1rUkJIejVlSHcwSWlNSk4yTTlYVFN2a3Q1WWtxWmIvNExpR0F3cFB0R3Nz?=
 =?utf-8?B?RWpuUndwQ2lsdXZTZFY4Y0lKV1FCRFN6WW5ockZmM0c3YzhiRzVtVXozKy8w?=
 =?utf-8?B?aHhESXlDOWdNWnJHQlRrUW9nWVI4a2ZyazFTUUtuMHVSVlFqUksySmpnTURr?=
 =?utf-8?B?MUUwaEE1VzJhaVRMZVViY3o0TVE5YzViaTlFNFBPMlZ1cVVjQmFNWk04RTUx?=
 =?utf-8?B?bEZDVk1lakRmQ2FmbmhNaXZ5YktkUzlmRXpYNjkyS2RCdlJmVjJrYmx3WFp3?=
 =?utf-8?Q?9bxVX0M8yvLBW6pE=3D?=
X-Exchange-RoutingPolicyChecked: ZcsQflEYUJaPT/WQroKd4JQyoK5WD26QuAyMpQx+T3zESBX821QdWQPMYwll6ULWXwxSDAIW+o+WnC9wiHVOQh0h9B9FKIN0lQVBMnJVP5EsiLUuFLuDHdLmMVArMnksT9yc8WgWPi9ANNTFmyzC0JJ3lh5RUlWhVJ8OpL/KK4yZOdRzJI5pn7REeLL1DE4JGL9csrQBn9Uz+kZAsEo19KRSbVSdSmHtuPtFr/HyUwI5B3GozZxAfRIbt9Gr7/iecGqLX5AB2Wm+iXvMk0Nq7RQQM+Qp40Ic6ZCQvE0n5KFtmFs1YqKImoXSSFvaQmtJ2jGQ+1IshTAMnc5UOtpnTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ce38cf-ae57-41e0-5f80-08ded026ca6d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:23:36.0264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kq9NHSSYYuSCF+pNCpYtkvqeTidZCocVaADHqPk5RImw8dy3kUCfvymjjuEYw7eXHW50YBMmHpLboWg8Xl8Hvn0E7P8cQen4Eu5756nOqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
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

--------------0LZg4mwRtBw0ocuF0fNNLEYP
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 22-06-2026 09:17 am, Lukas Wunner wrote:
> On Fri, Jun 12, 2026 at 01:37:28PM +0530, Mallesh Koujalagi wrote:
>> PUNIT errors can only be recovered using a power-cycle. Xe KMD
>> sends a uevent to notify userspace to trigger a power cycle.
>> On platforms where link drop caused by powering the device off and
>> back on is reported by hardware as a Surprise Link Down (SLD), which
>> AER then escalates as an Uncorrectable Fatal Error. That error fires
>> before the device finishes coming back up and defeats the
>> very recovery we are attempting.
>>
>> To keep the expected, recovery-induced link drop from being raised as
>> a fatal AER event, mask the Surprise Link Down bit
>> (PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
>> Mask register before punit_error_handler() requests the cold reset.
> You need to clear the Surprise Down Error Status bit in the
> Uncorrectable Error Status Register after the reset.
>
> You should also unmask the error.

Good catches, I'll clear the PCI_ERR_UNC_SURPDN status bit (W1C) after 
reset completes

to drain the latched event and restore the original mask.

>> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
>> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
>> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
> pci_clear_and_set_config_dword()?
Make sense, I'll switch to that helper.
> OSPM is not supposed to fiddle with AER registers unless it has been
> granted control of those registers through the ACPI _OSC method.
>
> There's a pcie_aer_is_native() helper to skip access to those registers
> but its only visible to the PCI core currently.

Gotcha! Happy to send a separate patch if we export pcie_aer_is_native() 
helper outside PCI core.

Thanks,

-/Mallesh

> Thanks,
>
> Lukas
--------------0LZg4mwRtBw0ocuF0fNNLEYP
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 22-06-2026 09:17 am, Lukas Wunner
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ajiwXJuY0PrGq7Gj@wunner.de">
      <pre wrap="" class="moz-quote-pre">On Fri, Jun 12, 2026 at 01:37:28PM +0530, Mallesh Koujalagi wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">PUNIT errors can only be recovered using a power-cycle. Xe KMD
sends a uevent to notify userspace to trigger a power cycle.
On platforms where link drop caused by powering the device off and
back on is reported by hardware as a Surprise Link Down (SLD), which
AER then escalates as an Uncorrectable Fatal Error. That error fires
before the device finishes coming back up and defeats the
very recovery we are attempting.

To keep the expected, recovery-induced link drop from being raised as
a fatal AER event, mask the Surprise Link Down bit
(PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
Mask register before punit_error_handler() requests the cold reset.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You need to clear the Surprise Down Error Status bit in the
Uncorrectable Error Status Register after the reset.

You should also unmask the error.
</pre>
    </blockquote>
    <p>Good catches, I'll clear the&nbsp;<span style="white-space: pre-wrap">PCI_ERR_UNC_SURPDN status bit (W1C) after reset completes</span></p>
    <p><span style="white-space: pre-wrap">to drain the latched event and restore the original mask.</span></p>
    <blockquote type="cite" cite="mid:ajiwXJuY0PrGq7Gj@wunner.de">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &amp;aer_uncorr_mask);
+	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
+	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
pci_clear_and_set_config_dword()?
</pre>
    </blockquote>
    Make sense, I'll switch to that helper.
    <blockquote type="cite" cite="mid:ajiwXJuY0PrGq7Gj@wunner.de">
      <pre wrap="" class="moz-quote-pre">
OSPM is not supposed to fiddle with AER registers unless it has been
granted control of those registers through the ACPI _OSC method.

There's a pcie_aer_is_native() helper to skip access to those registers
but its only visible to the PCI core currently.
</pre>
    </blockquote>
    <p>Gotcha! Happy to send a separate patch if we export&nbsp;<span style="white-space: pre-wrap">pcie_aer_is_native</span>() helper
      outside PCI core.</p>
    <p>Thanks,</p>
    <p>-/Mallesh</p>
    <blockquote type="cite" cite="mid:ajiwXJuY0PrGq7Gj@wunner.de">
      <pre wrap="" class="moz-quote-pre">
Thanks,

Lukas
</pre>
    </blockquote>
  </body>
</html>

--------------0LZg4mwRtBw0ocuF0fNNLEYP--
