Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD57CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00DB10E6D6;
	Wed, 10 Jun 2026 03:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hqtwo5QR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35C210E6D6;
 Wed, 10 Jun 2026 03:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781063053; x=1812599053;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=pz49YldpPCj1TNRTMoxLTvT+4Mq3c8KS4Hs5FuUozIE=;
 b=hqtwo5QRwm9WARgCgOTLtJfEA77Bih07mfl+4xgHzw7+tNZEkQUiulG0
 7m+SUh9OHjwfQN+mcuPbM71x4W4+Q7HBaIRtt5LoA7vTvlJdvI/ZEGKz0
 0YxzyO6wNepTNOzASlzap2mESBQuCBWL7VI34nBZlgpNL80BrjkowS1zA
 d8H4PxUD3fPVzQfDm0op5n67OpC6QO+ZZIH/F1r2YBedXrZL+mZ2ULx+a
 DMrg+yx9p3Ggkw/+XTSmyQLeFVdpeSga4bkWNkBWc6TaNa05SCN6Zgzp+
 cos58sSVZOD0XHhmMRUt9BdI49H59r+jS4dgElKBTw6VgENX2SejE8UvP g==;
X-CSE-ConnectionGUID: 6PW4iuxWRc+uBF9dcGCMEg==
X-CSE-MsgGUID: jqRBy7D5S7mij30McWXDnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99264999"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="99264999"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 20:44:13 -0700
X-CSE-ConnectionGUID: BnxwRKmPSxCS+ozWXlbYnQ==
X-CSE-MsgGUID: UxLwXWCBRkCwf5VrL8LMxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="276236501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 20:44:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 20:44:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 20:44:12 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 20:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDULUl6+28qS8rI2W2QMdkOVNd2R3LI9SPQFU2Lm8ui7CEWes3NuSdftppw/55pLI2uEbldUxqMthaDjdkQGVDg8FGD8kmT3LouZFZthXkR8GMwR4HYBqMAwLSAdZxlejy9igXqwk0jr970knao8P5Y7JCVEztRfrJbChloaeuA7mjJsrFHbZq+YKnqa+bFmY5mQ+CHJNOAsPlpF/EXGSojsTzL7r4+kK+dpSNp45GY6XNit9IKSROxaWmiLKdUcNvD1E/k6UI9pqV0pySChBMSNvtOmDA7tDEw4bcBhLsroxV3Ro9tgvPWWnTm0VeqzxprT2JbDvh5mo1nlKFHDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l5biqHZ6XeO4m8VLNbFyZtbHvNZoCgum5FK+2z62Ag=;
 b=J2cmsKRnFUy72uTMs6gifDbOXaq6uLT1K7TMtN2xpKqI/TK4+CRDSLrP+u7wC1gDmr5eptEpvvbHa9jVgwaH87mfUQV7A52wYAQUHkPqeTAw8tNKSJef1pmki5oFHbqBpcm7YBos35S2nQkf2wkn5bOFjcHNTTcHhSs3/LLTt9R4ISlDXSRrUwIcy9d2r2d52KF+MgBHWRfx1Vkh4fAf7cb9HJFJ2yJ7nvIsQIX4vXiRJFjDLUJWu8ibf5rm1CS23862M9W+Oote6Knnrvpjq+F37SHSdEzNITvB/qWNy3axvR6xOWVyvJ7D2kUPITZbiA0EjedJmCqmUEBWPOQJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Wed, 10 Jun 2026 03:44:07 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 03:44:07 +0000
Date: Tue, 9 Jun 2026 20:44:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 0/5] drm/gpusvm: split MM and device state across
Message-ID: <aijdg7RWwrEDEMxC@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603065620.2555316-1-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b73e85-8812-4eae-5b43-08dec6a28609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|22122799003|366016|6133799003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3TzAIP8rE8IJvDSrB7Yk3180duZ3Jg/6e/0w3WeGD7R32c4upT1ARI99/fjvyH5z0PCJZ+TJOUB//R/QO2wGmfHAy5B8fBZnWAFIMCsODyvXq2AwvOgEsj/yFVp11VoBzdRjKk8+Ur5nOl7nczTpDzhituM6hMjp84AL7o8lXSTecspAo8RYc70MJ852IvO4moYda2zMuScX6fggswR1oAPMtia1lsGeUvgveDX71sfL/t90kUGpbW7/SxtrT3ei8anJZoUTtJESLg4kU+MLO//yBWHT+aVlnfdKfdqZzehtyoQ6RpyxHi3zV9HUWT2uFvkZAHdvEJhWobJuZ0cA/Hntqzc+yKHmK//iGivk36q8yxW2Kgzge2Eksl+Z7RWHxBgu2yelZ6XMIjQbo4LOHmtKQzdhFuwyANtxH0MUCEAduYQGi5qAre3P9OwkBt3AOk4Isw8HUnfFNDQhtO+4f+L91xVov6gNvPStJuicc50W6JtcTYAsGWcpxqYbuWv1Djrvtmvrh9xNw5zvkn7r3g9vBnlvehamEAsscpXtJC52FWpaiTuEGotwcqSTT53c8jN6G7AojhDDsuWD6RuquN499u2+U90rV8xpE7toXKEpG0l+gLD3tnFEee0QFhB/3z/SSxtiUHUYKfvyy8JL6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(22122799003)(366016)(6133799003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNRSjV4VGl1eDBqeE02ajk1cWFsWGcvZXIxSnpOeXBuTVZKQ1lPQXlQMk9q?=
 =?utf-8?B?WjU0Y1p2ZDhMOFNibkZNODY0SXJXbmdWalV0b09OVURDZWJ3L1lGTmttc1VC?=
 =?utf-8?B?bGR5VXpFRmpXSkF3ZWx1Z3RCNDk3aVpkNFo0M1hRdXl6cERZalJCSmhRa3Vr?=
 =?utf-8?B?YUNQK3A0R1AvamI0QnNuOS9zZ2l0V2dDL1JRWEZJYXpGdmR5OVMvcWxPRFg5?=
 =?utf-8?B?enpqN29xNEdPSHhXMGlVRUtwWUFTVWFUZDVpbk5JWW9MYzhtcEZZaVRQNnJY?=
 =?utf-8?B?L0RIeFhKUzk2bi9OT0dxK252OW5nTHNZaDZtSHk1ay9pL2JmMDgwbDdaekx5?=
 =?utf-8?B?akluZHltejZZSGFuSkdzUXRob2xzdVdpRVk1UjFRRnNrU0lyY0kwaFhCcUtD?=
 =?utf-8?B?a0RzaHpxTmFwYkdYNUpMeGJTWWxFejU3WnlXZ0x0OUx3L3cweWxNTmpEZDI5?=
 =?utf-8?B?d1VzaU1ia2h6a1ArMlN0R3k0UytkSDlHMEo2c3ROUm5UOHZZamgwaVkzeXd6?=
 =?utf-8?B?bWdDMGM0OFFkcENYK0dvYS9LWUtMYkFFQXErc3YwTFRlMzRoVmRhOWtJbDRi?=
 =?utf-8?B?bzBSSW5iTzhZU01seGsxQnI5aVBSVVRWZWlXNXlnSFFFa2Z2aTcxZXdjeDR3?=
 =?utf-8?B?dnhiUEpEdWdjSEJuODVkcGZqbXZ3N0RHMHpnSmI4YUNzdTdVR0p3cGZIZXl1?=
 =?utf-8?B?MDRJcUNFVE5PQVVUQzJFVURBYWR5Q2Q5d201ZjN3aGMyMFlsSHFRNWNmcVlO?=
 =?utf-8?B?STRaQ0xqbjg0UEdIaTlESlFQZ1p3Y0JLS3VUTVhsbERXNGJvSkN1a1djNGEw?=
 =?utf-8?B?ckx0a0ViSlNqV2pERFhmWUhCV01zVjhsSGRaTUxJWGRyTHNtL1pKSzdMdytD?=
 =?utf-8?B?SkhvcG42eGZWdk44b0J5Zjk0cXlOUUE4c1QvcmxxVkFUVjZlVFh5VU1UYkhS?=
 =?utf-8?B?UytsQkpVMTV4cWRyREU4aVdseU5xeDdMOXdEcitIcHU0dnErdHcxYmNiNkZ2?=
 =?utf-8?B?ZWpta01OVWZJMWdUaENVOStqSXJKQlZROUcycG5NNllQSVZ5VkkwUHFkOXNB?=
 =?utf-8?B?ZkxhZEg3elkzamZJYTUvNTI3a1lncmFtSE02VkJqbGI0Z0RqN0UrRkJnN2RO?=
 =?utf-8?B?YlRiNFZRclNUcUFld2VHeE9EYjd1dWJEK0ltaXVEMFhBN2JpZ0owNWVod0ND?=
 =?utf-8?B?WEk4ZU96dkU0QmxmZ2JWbXJMOENmUm5vZ0NiR25GRW5XeTJ5L2p2enRQSTlQ?=
 =?utf-8?B?enVJSG9jR3YzdGlrbXkvWmlGcU1TemVkS1N1bitPYldiQzh3UUJ6RHpBWUl4?=
 =?utf-8?B?VHhWUzlWMXBJaERzL1ZPYzBHUVBjWllEMXFCb1hhUysxZVg4Kytsb2dNQXo5?=
 =?utf-8?B?Vzc5RUdjeWhZcytNZkw0eSs1aCtuclRqUHpaUU5PMWVVMk1kNWVTeVFOazNJ?=
 =?utf-8?B?dVcwSXlad2JjTVE4Q1FVMVVaN1RwTjlXWmtYcFN5SUJpT1R2VTB2aEgzc082?=
 =?utf-8?B?cjhlWVBQYU40QUhuSVlxVHhJb1ZDREdoTHdvLzliTG5FSExzMVB4TEdGdnVV?=
 =?utf-8?B?TXZXcU1sc3RoaWdld2hpU215cHgrY2dyWEZGejlnR3N2NWFNWFBzOFc0WkV3?=
 =?utf-8?B?TzcvSjc3Z0pYZHByUzUvWmxvNU0yZE4zamt3Vk1sc1dIVXVXYURRRXVZdGhs?=
 =?utf-8?B?YjUveVVOdVEzZUt3YUE1ZmVsa3ZDUHR6WWJJeXYzT2VBd05FYWV6NVAwMjRt?=
 =?utf-8?B?V3gyRkliZnEvOC8zVkNJcUVUL2hpbWhoTEc5anU0UkZnVUp6eVkxOXFvb3Uv?=
 =?utf-8?B?TGpQc2xRWTgzNjJac3JOSXIwc0JxWEliVkQ2bVJhWHl1d0pmN2Vsc09SdXk1?=
 =?utf-8?B?R3JDT1E0dFcrQldRakY3UmExV3BiL2o5dGNnUm90VnJ1RlpWV2V2czdqaHVW?=
 =?utf-8?B?WHVkM3FydTVBWW9iZjlrTXpsZU42MTdCVVlrem1Kb0JaWmsxVS9HTU9UVE5U?=
 =?utf-8?B?U3BBL1k2aUF5Z0x5a2NQVW5pWnZOME1HMS80YU45L2xhdlo5RGJpeEVlcExt?=
 =?utf-8?B?aHN4cjBrdFZNYUJGSStRMW45OE55QXk4OW9vTCt3OFVLSGp1dWVKdGxUS2Nm?=
 =?utf-8?B?QXcremxEdTZNVzNkeXgrS0hMZGp3Q3dvd2dsYXh2dXBvWmwyaGhBMEVXaitO?=
 =?utf-8?B?MGM3b1hjby9DclVDKzUxUStXa1N3d1AxU291a2VzV3k5KzRpblAxVXMrWjBy?=
 =?utf-8?B?THJXV2g3TVhFdkIxenRxV3VpRUZFbi9YOGpaTEZlV29zK3hXanJFTnhGZTVk?=
 =?utf-8?B?WUYwa2Y2UXV6cFhMbXpLTnRVZXNXbnYzL1lyZml0RFdsSEJEZXFjQT09?=
X-Exchange-RoutingPolicyChecked: s/iCs6g6zEnqx6aYOL+nJMMjhjtRP+mPOa/xDaikw/TUjn2WideszyoZwUdSXcyr2hBNwhSir+pviNt+3J1EghGfzGHLd7qspM3TMgscIL3TqcAc8MSw3FGB1BHmsolfyST0+hm5zfe216WCn4WwYZh09GOSZKqc+QJwyUibB9Vnd4fFei/IWLkz61CXlhh+O/dXmeQUF4MTIf8OCZxGgPikj4DdYBvrPj5kKl+0GerE9T5UpZWp9kle23eyHBfaqH/ofebG0ksZcpf8lq3u8gWBtVt33ivnWPi8Zw80Q7vojWMMuVUR/EN+XUW2T+QW9VOkZ+IVNOLZ67MVxnNdEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b73e85-8812-4eae-5b43-08dec6a28609
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:44:07.0280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAHGDfHbBFwVxsIL9Ge5a33YErdlI89+2XcWxAjA5vk/tGdNF2JUIdrQbwDdg3u4Df7BKSlpm72pqNBSS+Dnhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
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

On Wed, Jun 03, 2026 at 02:56:15PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> The intent of this series is to make drm_gpusvm more flexible and
> give drivers more freedom over how they assemble the MM related and device
> side operations.
> 
> This RFC implements the direction Matt suggested in [1]:
> 
>   - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>   - Embed either a struct device or a struct drm_device in struct
>     drm_gpusvm_pages.
>   - Drop struct drm_device from struct drm_gpusvm.
>   - Have the driver's range structure embed one or more struct
>     drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>   - Refactor a few range-based helpers (drm_gpusvm_range_pages_valid,
>     drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages), or
>     simply drop them entirely and update drivers to use the
>     drm_gpusvm_pages helpers instead.
> 

Overall this looks good - thanks doing this.

> In essence the series does only two abstractions, plus the xe
> adaptation that follows from them:
> 
>   - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>     drm_gpusvm_pages (device physical related), so the two
>     sides can have independent lifetimes and ownership.
>   - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>     the device side down onto drm_gpusvm_pages, which is where DMA 
>     actually happens.
>   - xe is updated to fit the modifications, no functional change intended.
> 
> If such changes are acceptable in terms of direction, I have a few questions:
> 
>  - Drivers now own drm_gpusvm_pages unmap / free and notifier_seq init. 
>    OK to push this fully to drivers, or should some new mechanisms need to add 
>    to ensure functions can be completed by the framework?

I'm looking at the diff of xe_svm.c before / after and I see
drm_gpusvm_free_pages moved to xe_svm_range_free. That looks fine to me.

I see in xe_svm_range_alloc() this:

range->pages.notifier_seq = LONG_MAX;

Can we make help like drm_gpusvm_init_pages which does this? I think it
is better to encapsulate the pages init into normalized helper even
though it is very simple. Maybe an inline since this just a single line
of code?

>  - This series drops the three drm_gpusvm_range_* helpers and changes
>    drm_gpusvm_get_pages() / drm_gpusvm_init() signatures.
>    Do we need to keep thin wrappers for backward compatibility.

It should be safe to drop these helpers.

>  - drm_gpusvm_get_pages() mixes HMM fault and device DMA map. Multi device under 
>    one SVM calls would repeat the HMM fault. Does it need to modified to Split
>    into MM level fault + per pages DMA map?
>

Hmm, this might get a little tricky because of how the allocation/retry
loop is implemented in get_pages(). Maybe we could change the function
to accept an array of pages plus a count? I’m not sure what the best
approach is here, but I’m open to ideas. That said, I’d rather avoid
having the driver open-code a retry loop if it could live in common
code.

Side note: another modification we need in get_pages() is to make the
DMA-mapping step optional. I suggested that AMDXDNA use GPU SVM for
userptr, and I don’t believe that device requires DMA mapping.
 
> Patch overview:
> 
>   1/5 gpusvm: split MM state flags onto drm_gpusvm_range_flags.
>   2/5 gpusvm: embed drm_device into drm_gpusvm_pages; DMA goes
>       through it.
>   3/5 xe: xe_svm_range owns its drm_gpusvm_pages and its lifecycle.
>   4/5 gpusvm: drop pages from drm_gpusvm_range and the range-level
>       wrappers.
>   5/5 gpusvm: drop drm_device from drm_gpusvm.
> 
> tests:
> AMDGPU:
>   based on amdgpu adaptation patch in [2], but still SVM:DRM = 1:1,
>   1:n is on going needs many modifications and testings.
> 
>   Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>   - KFD test: 95%+ passed.
>   - ROCR test: all passed.
>   - HIP catch test: gfx943 (MI300X): 96% passed.
>                     gfx906 (MI60): 99% passed.
> INTEL XE:
>   TODO: We bought some Intel Arc A380, but it seems like this cards 
>   don't support hardware fault / SVM, waiting for the new 
>   cards B580/B570 to arrive.
>

Please send patches that modify GPU SVM or Xe to the Xe mailing list. We
have public CI, which I believe can be triggered by any AMD email
address.

I just pulled the code, encountered a compile error, and noticed a bug
around unmapping related to that error. I put together some quick fixes
on top of the series here [3], and locally all of our tests seem to be
passing.

I’ll reply in detail to the patches shortly, explaining some of the
reasoning behind these changes.

Matt

[3] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
 
> links:
> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
> [2] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
> Honglei Huang (5):
>   drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>   drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>   drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>   drm/gpusvm: move struct drm_gpusvm_pages out of struct
>     drm_gpusvm_range
>   drm/gpusvm: let the drm_gpusvm core context purely MM level
> 
>  drivers/gpu/drm/drm_gpusvm.c    | 128 +++++++++-----------------------
>  drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>  drivers/gpu/drm/xe/xe_svm.c     |  37 +++++----
>  drivers/gpu/drm/xe/xe_svm.h     |  11 ++-
>  drivers/gpu/drm/xe/xe_userptr.c |   1 +
>  include/drm/drm_gpusvm.h        |  49 ++++++------
>  6 files changed, 95 insertions(+), 133 deletions(-)
> 
> -- 
> 2.34.1
> 
