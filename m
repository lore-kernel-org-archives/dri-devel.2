Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2081075264
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556FB10E8A3;
	Thu, 19 Mar 2026 06:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cNNS+jdN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DD610E8A3;
 Thu, 19 Mar 2026 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773902301; x=1805438301;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OGQ6ZD2goOgAZvaVgJ6r8MWTkhKhlBbef3KxCsgtIH4=;
 b=cNNS+jdNVbrbCytPTndBneS03ZBUjdy5DaKg5HhxdQDkDp0gULJEfJGc
 X9vZo5dEDxsV+VT85lJI1SygYepkorOhO/gw49b7EZ5qtNrSU7pfwav9O
 eXFGxkr9sRhzzX8Pi7TUXJyUSxQ1nh3vQaGLXRyxF5c48Udyd+MYxfoGt
 sCeKFBiHQijAVphX1FIGuIyA7i+4Ili8bd2Pjq1nYl69kWmnjCEfS6JY7
 4vr36Riwi5YT8AIBMEAq/t5sOoRROiZnc1dT4oUgpraplbqA3QB28wLgH
 ncAnkzV0wMXUUVsir0gfyZ6iYBEGMlYGRVf1sj9naxWsruFWo3L3Mr40L w==;
X-CSE-ConnectionGUID: X4HnroOuRO6BBHb5pgNBow==
X-CSE-MsgGUID: BvrAbkRCQ7eTUjKjKTrM9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74853891"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74853891"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 23:38:20 -0700
X-CSE-ConnectionGUID: 58qpwIQgTzGjc1F6UJzGMA==
X-CSE-MsgGUID: UDRbMaE3QCSm/3RvHIoxrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="221972974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 23:38:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 23:38:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 23:38:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 23:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcyY4VNQwhG7nAzi4GwtUdrG1YVIWfH0fEdz3+K/4Kiv9MU4W5zlmmIAG2C+Gft6cpD4sI8jlKpSFAe6Nos870DXqY1Rf08d9V0jdi1qnh98qTyg2EF9+OG877fJ66gStaogG+praeRgJcW6Arycq3qfkV77m6MZeRqrsiXYuw3moF7O0bJPQesj+2EKl9imo4NxXVzJbvuvnD0LmVux08H5iuZMg2KxM6+4puxoO3qC8iMu6/dgUzzq7MlMpE7+xeiGAmJkn7lrdET8XaKOS0vR5NgW8kEYv0o0VUUAKv2Psk2DiCALAIIuU29B+udcWJjuBits3EuZlv9tOzaDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XQ/HuMX+XR4LUKuWPkZcjHP+inEf0xy9D5b40CG40I=;
 b=IT3nXlpHxMaJv5y8bpe87aFEQ82/C6bgJJkzgrh8JfmNJ2ZVHPx7WJP7T9vdCluZW4TjKfImDzThI3qE1f61Ev8fiJjCX6zEzPZGfZk4+ySQpGaKHi1RfrVCYi9/Dckc8HYV0aV6U/DpohKFvAYD3nFvv1OetVdM0PL8OSD+PnfRCTSkDKZsgVFq3UnBI8dfJP2VTk8y15vW6UVKCPQyNHl9RSYIwP8IzvJjwtg9YSyHmhHm7A9dXkI9X0zbXD1j8Cabgy51herl+v0G3ZRu0RrJKREaucM8+0uxsYEQvLQm9cKEbEvFQqDkpqtgIh1EqXnB7zU+qe/W9nrifEQ2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:38:11 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 06:38:10 +0000
Message-ID: <7139d8f8-36df-4951-a3c9-d82f6ac636be@intel.com>
Date: Thu, 19 Mar 2026 12:08:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
To: Melissa Wen <mwen@igalia.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <contact@emersion.fr>, <sebastian.wick@redhat.com>,
 <harry.wentland@amd.com>, <daniels@collabora.com>
CC: Alex Hung <alex.hung@amd.com>, Uma Shankar <uma.shankar@intel.com>, "Xaver
 Hugl" <xaver.hugl@kde.org>, <amd-gfx@lists.freedesktop.org>,
 <kernel-dev@igalia.com>, <dri-devel@lists.freedesktop.org>
References: <20260318163629.300627-1-mwen@igalia.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260318163629.300627-1-mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::13) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|IA1PR11MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: c696a799-1e6c-4d0a-7a7d-08de85821644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: LDwbQAbO4JoZUvkukvTOU8IcxNoaXEA71Abno0U7LREWNsD1DjxMjmrn6ImXDG4mWJrxOXNGXpyckkeq/emgOke2Q5DlOv6rDkm846Mvo+fQQilb6YpUGMewKS5oZQjBRc2L0gIWPT/AhZilXbNqwMuo7Y53SA33pzv+wrAS3EWtablGCDuDe5mGRkUdZNIdLM8JjqmmcGCp3sbGW5iGPyNRJVUm3dDkxAlfQNZbk+85+e0c2BkGImmzpOtwyxA/ZfyJAe5SQUdbtBqb8AMsEa8yk05HQiCABdUva7rEMhBVBtzpFhRtDELgLxiFDd6bxNLuZirpyKiRjzRRdX75fE3ItrQ3IrMLjvezi42KEnz871enhbg+lyRX3lHuGKUX0JMYtt3hRLUyJWYxvDwp8VS0bNsLGW2edVm50uAeaHqJKfeAeogS0piH7W6K2gkEt/hXRfAm7C3ovlJHQ4wtEH+E/WZUGBuyP/epxh32xEJ9RKskSKG+EaXlYdgHZqMGmLzGObIL5eF8GU88qJ4CfqsC4FI2eVuek91QO+ZBswrGZlogqSMvdfAJ/ohzKKJITvArceVfjMjE4C82eTJN/VFjbb5pxjsQU0zd6/NuFP7MJQwlA3Lty5ub4bCXdo4ix1CRxJ7K1MmarWvhf0DjHnCPEKthUQoXNjfbVy13W5pKku3IWbSpUXvaeeCKEzbrFVxYKOlprtYgOBPflS0IH6uuAa1VtJbIJ0UiqBcy2+bMT1puL+vhrg9UGL8mre8oid7kI8vgpE7JlMQ4wEtGwtWpxicA99RE66QwPaoOfP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhHVDJzcHJlRXVjNGkxckxGL0ZuaklHNHV6WXRBaWVHNVE3aDk1OG41NEJL?=
 =?utf-8?B?ZEdhdzhwWGFkdTJwWmEreVNVRTlGaXUvRWRCK3BHc2VRd1ZCN0lITFAxeldv?=
 =?utf-8?B?eFYxSVgyS2FuVGpZQkNnOWkweWJ4MTVFZDVORXllODJCQ0hRREdTV1phQkQy?=
 =?utf-8?B?LzNRMlZ4dHpvcWNydFc0UzhaUU1BU0tnbktDSUtQVEc1NWpqNnQ2TGhpUFV2?=
 =?utf-8?B?OHVQeDd2U2RjOEYzV0dCcGhTUEs1Wm5TMU9sK3lvT0ZxUmo2NE5hOUY3WFI1?=
 =?utf-8?B?Y1VTSTZSRzhxNEZYU3ZOVDVmd0xmbExjYjNiV3V2b2lEdEMvOVgrMWZDUERq?=
 =?utf-8?B?SHhpTzE0U25FYzN1UTNLY3Naa28vVFhRT2dkWUhWSWs1S2xWSDNZWTBOQVBX?=
 =?utf-8?B?QnNuNHlmaWw1SDlhSVNTVFNxdDdhd2dMR2Fmdi91dTN6TU5Wend3YU5YU2NM?=
 =?utf-8?B?ZllrQzZVMHlnVy9JS3kyTUkwV1BLR3hlcU43MGZoRnd6WC82QmRMbmxKaER0?=
 =?utf-8?B?bkRsRzVmVzdZMDVxZk5PRC9YWklFcWpyY1ZjOXQxa3F1c3BUUG1wODYvSEVC?=
 =?utf-8?B?dkRrd3lDMzgzT0xGYzZGYXFyYm94QXFsU0JhaWwzejJaTk9rbnRveVQ3dHIx?=
 =?utf-8?B?V0o3S3duOGpPK29oUDIwRkhON2VmWVhrUFRVR3ZxUVkySjdnR0dweVlpRHR2?=
 =?utf-8?B?aUVESkRzKy9ZS3VWbU40Vk9Cc0dpaEZkRUw5ZkIvRkRZc0xLVVVXdm5QeWVi?=
 =?utf-8?B?bHV5Um1QdGFWRkVsZmJPUUYxazhualVmbDU3cVo5SHBvWDlhMFZMQ3FWaVl3?=
 =?utf-8?B?OVg4V01ZdEhqb0pKNWNXQUNFWldtR2ZBb3NOOWVGNEsrZFNTRjFDVk1qUHdz?=
 =?utf-8?B?cDk1WFNucDA0eGRXTXJQSC9KcWh2czFhVStnVEY3OGJtaFlsQjRWaEtjTE55?=
 =?utf-8?B?MDhjUlRPeFc2c1RON1VzM0lYS0RBZ3JabzBMWGJ2QitUYmNvb1RWSTRPbllR?=
 =?utf-8?B?SjlsbFRsSlRHcm5MY1NWb0pTUklGbUdIeHFkMXVTb1haQnQwNFlhcmxmZnlC?=
 =?utf-8?B?WFYvWGorMmlCb1BDQStZSUNjWGZNS3JnNHRNbHprQ0wyQ2ovei81ZEp5R3Q2?=
 =?utf-8?B?ZExhdG5WUEtOQTU4TUIwekdSWHZWRnpiT08zZlh1VkdweHNVK0lTSnhRN0ov?=
 =?utf-8?B?SDJmY2VpbXVqaXJuNmZOTHF1dGZRZ3M0U3B3dmU3WVBUbUZ0ZDE1Rk1FZ2ZG?=
 =?utf-8?B?d28rR0tnZUJaTDlucVl3UU15RHhETzBDZk52bkJpRW4xM2FoN3gyWmFEOW9x?=
 =?utf-8?B?UGdJMEZCTnZVT3hUTjBvSkZ4Z0pjWTdzWlhiOVM1T2pwK3VqaFBrZy8xS3k3?=
 =?utf-8?B?elU3eUhqL3d4R1FSREdlNkI1dEVyc0daM1B6NzJXSUZzaXNoTTYzQmZFRnp6?=
 =?utf-8?B?dmZKTEtKbXZyR1pqVk5NUkoxWVF0WEZQQUk4aXNjUkxQWm94eUc5TVZxTlI2?=
 =?utf-8?B?L3AyZ0h6KzZBSFNPa0twc05Wb3k3ekNCdGpOWUo5TkdidlUyZTlDMmxMbERB?=
 =?utf-8?B?cC8yTVUrZ2puZy9sMVRNT3lOLytrTi9HUUdRVG9jQ1g4ejg2M2U0QmQwTHF0?=
 =?utf-8?B?djRaOGhXQVgrS1gxVy9oMUVUZHhZcGRjOWpRY0RSdEpkSFpLZitHOFNYVVdt?=
 =?utf-8?B?dkpHMDN3OTM1dVNsS3ZYL0hSdjN0TmN6VVc4elVyb0F6UGE2TGRyWEQ5TkVJ?=
 =?utf-8?B?bms4aFE2ckRiczR3TXZ2d2xROFFvN3JZNDFOMy9wTktkQmVrVWN4NE1nd1A0?=
 =?utf-8?B?TXhGMGdZMWEydHRGVHNEdWpjV2IrSnVMNElsQmRNMGU4OHNZdHpMQ2xVbGJp?=
 =?utf-8?B?bTJWUXhWMTlldndvZi9LNjdueU1Nc29tWG1XWFdFR1Q0QkxlQkM1SWxDUzBV?=
 =?utf-8?B?Z2NPTnJoRkJUeFZMdTZ3VzF6bXRkTlFqaThVVG0rdUZJUUZCNHJFZEpSYldn?=
 =?utf-8?B?SlBHanJpMzRpOGhmbTdJK0hJWFZ1MWJ3akdES2huejVNQzVKTzJrQlFJdldB?=
 =?utf-8?B?aENkVzdEYWpvWmtNd0s1ZXM5VlVJQ21qczRHRkVZSktUQUp4WFZrZU1rREZT?=
 =?utf-8?B?Tk5pNUFac1Z5TkY0UTB3ZzFGS1pWV3hoVnVkZW9NWGoyZmxWT2NRSVdQMW40?=
 =?utf-8?B?aWdZNEtSOExDYVpkSVJYT3NGK2pNWmp6YzErOFZIcFVsczdRRDg2bUJ2aE9w?=
 =?utf-8?B?MmtvZ1Nta0l0aU16SGUyVUxLU2k3UmljalhZYi9HVnpSM0hMZmRwR1lWZSth?=
 =?utf-8?B?SU5ZN3o0TUpaeWhGV2lXWnoyd0JKalJ6bE1FaGY1SDFHQTlDQU9QNXFXVGc2?=
 =?utf-8?Q?y0dbNjncrUd984cs=3D?=
X-Exchange-RoutingPolicyChecked: bQaad1k4lI79Obmll24z310az/JrxbprrIEFTPKxpMeTLgV2xpBTdK7SO72dbTVGRz/8oulmtdipgYYxiy7LiZuf/ov4378RzRVQUlJsEHZzaFzqhqwpUGgKJVuGQsYBFYi/fwREEUxY4H57Sb3zm437fiQRkFUWj8XNQUZf9JIsME4t0TLwQbNc5FdCQERpx7Xu1GccAltVH0+7r9JCVQ9c4HfaASCrzPkSOKaYpBYrgiM3Z+nNy+oLJicV9+bt9o3ADNkMN9suf3B9eEivWTv/VtIUVyL+H6URsc2VNPTs5Hix4Ld/GVUL6Yf9mRWVm98amksg6d9c4Vm7eyKYgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c696a799-1e6c-4d0a-7a7d-08de85821644
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:38:10.2656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cCrsKCTRM6fNf5bluc8JQ+Hxu1PoJsm1pcdvr0L198hZXbeo+WCMnNeEE0kdpI4Gp2q1jMempFXBgZUnPJBNJv+GUe4vg9eqdFI6m1wSqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269
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



On 3/18/2026 9:57 PM, Melissa Wen wrote:
> For suspend/resume to work correctly, do for colorop state the same we
> do for plane/crtc/connector states: duplicate the state of colorops in a
> color pipeline if it's in use by a given plane when suspending and
> restore cached colorop states when resuming.
> 
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> 
> Changes from v1 (https://lore.kernel.org/dri-devel/20260316210055.234498-1-mwen@igalia.com/):
> - keep the object hierarchy (Chaitanya)
> - add r-b from Harry, Alex H. and Chaitanya (pending to confirm)
> 
> Chaitanya,
> 
> I kept the fix for unused-variable warning together because the warning
> only appears with this new usage of for_each_new_colorop_in_state() in
> drm_atomic_helper_commit_duplicated_state() here. Let me know if you
> don't agree with this approach.
> 

Please go ahead. Just add a "while at it" to the commit message.

> Melissa
> 
> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>   include/drm/drm_atomic.h            |  3 ++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e..481f92a03683 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   			err = PTR_ERR(plane_state);
>   			goto free;
>   		}
> +
> +		if (plane_state->color_pipeline) {
> +			err = drm_atomic_add_affected_colorops(state, plane);
> +			if (err)
> +				goto free;
> +		}
> +
>   	}
>   
>   	drm_connector_list_iter_begin(dev, &conn_iter);
> @@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   	int i, ret;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc *crtc;
> @@ -3863,6 +3872,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   
>   	state->acquire_ctx = ctx;
>   
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
> +		state->colorops[i].old_state = colorop->state;
> +
>   	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>   		state->planes[i].old_state = plane->state;
>   
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 0b1b32bcd2bd..96fd32a3e92c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		for_each_if ((__state)->colorops[__i].ptr &&		\
>   			     ((colorop) = (__state)->colorops[__i].ptr,	\
>   			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
> -			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
> +			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
> +			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update

