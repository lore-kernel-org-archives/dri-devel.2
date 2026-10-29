Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87729606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hOeOJorG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE850112424;
	Thu, 29 Oct 2026 16:03:44 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56D6112429;
 Thu, 29 Oct 2026 16:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQXqQLEQwwVpcBI60W2sZz6FHj7TGPJJaciQwcdlW9+g8kyZCmrfLpNmvVfPFRcVtK9rBSrSpmgRjM01Bq83xvtXQS+qGHl7SfJ77OK+i8tw68vn24E9ZGGa7QiCK0F6I4lrNB/lVA3iy7FxFcn6NJKK9QW9F7bfLqEPC09Dc/icAwM/piNH9/TTQ72AJfr0jI29wEhLdF3Bh6dEwG5Xz8QK9R+Eel9wCwGMT7G8zgrBjzL0BBdqh1B/cZqZ4OZJoP7MeUZswYQfNH1Vka50TBaQTmfmP9RaLzdAMuh3UWKMhr4HA9eLACcOwhmgBQ2Yaz2LEmPaLMQcF9GyouG4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24bXCJb6CWonEh/3ooVlXuRBm/yLmWqIOt67RangjeA=;
 b=uCcPtSO3fdfyDGF9fwuugek5USBCO02dHvNkwhoBPu2TWWVxS1TLUZulzITkFe0fTFrhFlrs4bpD2FX0VUBILeV/cE0tq/fZT7k0Rum4TSyjkZ9A1qDZ24nUV4e3LiXf0seeBfbJJjiFD+vlPIl1pk4ibcoh/7C8ZBblLtDg+OFHb8M4uQJcCqB7S/ikpaM2wyFi6uIrFfR2gcRny54lZliMNDhHwAoTc8E626W8G0AJqwiqzPTDXxZogtTsnomSvBHuz1Npzd4clmQsBVMawCufcnQ1w0FS5ClEh8y+RfUBntNlDCsyOmhr3oWbkk7wVFLHD39TAKCYl/jHCPqtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24bXCJb6CWonEh/3ooVlXuRBm/yLmWqIOt67RangjeA=;
 b=hOeOJorG1+YOjyhJiFn01qYsjWX00puPyj14vzwTtBC5M8NIwL13PpLRQBbzGfQyLuZ79alY18VE35GT0hqA4VjLGVTHgzdAKQIGx39HcLZJhKWXU8wg5SN8OM7J4qkqm2padNyFXMfrCUETD//6Y9kHB4WHn0PBSHle30qyAds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by IA1PR12MB8493.namprd12.prod.outlook.com
 (2603:10b6:208:447::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:03:31 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:03:31 +0000
Message-ID: <cac192c5-1e0e-456a-a678-024100dab65d@amd.com>
Date: Thu, 29 Oct 2026 10:03:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: keep LTTPR AUX timeout when repeater
 caps are invalid
To: =?UTF-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Michael Strauss <michael.strauss@amd.com>,
 George Shen <george.shen@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>
References: <20261024224940.17258-1-michal@nozomi.space>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261024224940.17258-1-michal@nozomi.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: e416d527-32c3-4fe0-bd80-08df35d62d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|261028144727099003|261026140227099003|261022075727099003|10067099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: 3N0klGJ4BmyMF4Oev0jUUeEXGtHQ2Yu8un9/pWeg3phG8fxuaokjk5oKXBnN8jyc4S4vqhKCE3Hg3xcOeCchrzZ4wSEo2ddtPhjTqV5NG91cahaioHD0yPnswPsTOfI1fcMbWqV6Y6hZLEeU4YGkYw/aDLwfS3tOH78alr/h05oGoAMCRBaVDZQ9dzAjh8PPr5COzAVVwBCz6jkahtN8bWqWht/D0Q6T0BsNVL5tf0aH/spHUIBOiesShVIAFvWsYrQjOikZ3OoTtu+JvXu97ssOOay2a87rEI26UwHLvqBRvnpGHZKfsK68Rs+KTlgIaij1l34s9CGmZh9ZUmTxxnJajebhi4gn6n4F9T2J3mUNc8qhdvT2ciLQ2BxTk8l2W9WlGqgfg3UogkfZtgAYGVURfyyMO1v0YrPDB2xebkvsjW2Lacnp24ZSfH0hNAAU+z6iZkd/Uttw7WfuJ7LUUK7Cpq4LOtYUlvGjJ28wIVuKOOsYV1l2KkKmzc6+qeVRM42gNd/XTrn01PooS/mn3ntDAZx2YOpfQ6whfgfPijazneM0ct0bxvPOWZqnzuBL39gMg48Y4e9uuxvOpHlfkXJVzDSx38VAZpftHpTbpR0nNxEWJpHa/BIOma5nyry73lJujwynp6BLmuCC3S800Xf1uAYIXnBeuNfga67eosQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022075727099003)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dNR2h5YTNsZXNFVUw1Vk1ja04yZGgybHZ0QXZHNG0veC9QUm9rTEUvYXds?=
 =?utf-8?B?MlEwQmRrYTJEL1VEbDFuZEpyaUtXYjdKK0JneEdKaHhMUUx0R1FhdHVGQ1Bt?=
 =?utf-8?B?enFjSnlXdEE4WVVqMTJEd0ZtMm9WSGpPTVNVUWo0WHg0OW5aOWZaRnJTcUdL?=
 =?utf-8?B?THMrMFZYeGU4THZsL2NjVk5LMnlOc01SeVduN0VtL0I1NkdSc1Z4RUI1cFp3?=
 =?utf-8?B?V2ZLUDB0Z3llQmlSNFpQYy9BVGJOK3V2REtVL0ZpTWpFeVFlcHVjZU5DS093?=
 =?utf-8?B?YkE0NVZjSXdzSGl1RDFVTGM4NlJmU3IyRDJUamQwZTVVS2FTWUZzZVZlL0oz?=
 =?utf-8?B?c0N6R3BobmhKVU1MR3RmQVc4NHMzeFpqUzZIQVcxbWNhZGxhT0p0ZlRKTXdy?=
 =?utf-8?B?R3FPN2ZmR1R3WWxzOGVjd01zMFBHa3VubHorbUx1Z1prMDROc3h0T2JyTnIw?=
 =?utf-8?B?aVYvOUlEeVlYOGJTdUFEQnJ1K24wTi90ZFZJMGVVOWdzZ04xQnI5eDc2clZi?=
 =?utf-8?B?U3NpeTAwN05KRysrNzdaakpNZFU0UVhmcEdOajBFRFlSTFJCNTN1QlprNkhO?=
 =?utf-8?B?NXdNT21LSUFlb0tVQ2ltbUp4dDZoWllGeUNDYnBoR1AxTWUrbTR0aEZlY1Vv?=
 =?utf-8?B?Z0VPbGJpc1ZmUHF4NzR1cWs3cUVpaWcvUVBTenNBUStrRE5pbUlFVCtoRGFR?=
 =?utf-8?B?QzN3aVdjMUs0VHJMaVl3V2MxbFVmVG5xQitLZTM4eWxvcjFVTTU5eXM4L1Jo?=
 =?utf-8?B?ck9raVFYMEVsblZ4STZvdlhzK3krdjdTb0hwN3JkVzB1L3V2SXBWTTVGVTl1?=
 =?utf-8?B?cmdxMDNTbTFURGdFd05mV0hXSzh0SDlrR1MxYk9tNDcwUnNpekloVkRKa3N0?=
 =?utf-8?B?VTdaMk9XSkdleW9TWG9EUG5OWG9Cd2dxWW81OFZ6RlJkVHp6UjFndlZHQkVX?=
 =?utf-8?B?M1VlMGFHbHJLMFo4US9ZVUVBS3NGZTJxUDRRZXIyMjRDMWxOOXRObTlsVFhs?=
 =?utf-8?B?MURFV1lqUnA3NWFmVk1zYUw3Q0VHSGg1K2FvNGxVelRsbGgrUE9Xb1BsenJD?=
 =?utf-8?B?M0twZWRpZ0JKU1AvcytodlVkSVcxay85aDk1bDBFSHlIVFUyZDl5Q2YreVBS?=
 =?utf-8?B?R0xaWTAvNFhKaUZFUHlNQmZxa0RBTVZ5cTVzb3JxVFEwcE0wcGVNazNnRGlO?=
 =?utf-8?B?Wit2dTJ2REdDNC9FQkFmVyt0WEtpNW1HNkxZNStxTWJxb0tpWmY5VVArRVZn?=
 =?utf-8?B?MWE3M3g0c1JJQW9zZnlDNmNTVDN0dm9jcStiV3NOTGpvNFVHQURQc213TnRy?=
 =?utf-8?B?dWc1RWxXNU41VEdaR2Q1OHp0MXVVOG5WNFlwS0xEeDlVUysydFIxdXdxUS9G?=
 =?utf-8?B?TVJ0cTVXUFcwNTNKREVzYlgveFVIaDlxTjVKQWMxVmcyQzN5dzdLaGpqNUJx?=
 =?utf-8?B?ZWVZRENsRmpBUUVHdnB2cXR3TTZtVTFzZDRQUlB0OHhIZXBHTzlDNzlVM05Q?=
 =?utf-8?B?ZjVOZUFSS01wdjNtRmg0eU5FSmU5VVgxcEVmdWhDbGt1dEZvTXZEWEpyMkow?=
 =?utf-8?B?QzdteG5GSDl4ZXkwODJIdFNLVFlRUy85ejVkSU8yZi9NOXdoSm1FdnN2YnZQ?=
 =?utf-8?B?Sm4vbDNtbjVsekY3UkV3NkZMWkprZmRKYno4OVRNV1FUY3ZjSEZBdzBzOUxa?=
 =?utf-8?B?TnpUNjRUeHhPWUg4cWVQUmZLWHFONnBrYm16NGNmS0RZODdaYWJaM2ROYU9X?=
 =?utf-8?B?T3Rya0tXd2tEVW51ODdlVnA4RngzQkpKTHdUdmFqQ3pSRjhGWENONXpqV01Z?=
 =?utf-8?B?VVJlUWs4anBTSHFLNUJ3Z3ArYVNYWnM3Qkk5NERpNlhhamdHaHB2TlNiV2J2?=
 =?utf-8?B?ZzQrVm1HZ0ZEd2d3dXpJOXlYUXlhVlJ1K1BNRlA3MGFRMUxOTklpMlZkTUFS?=
 =?utf-8?B?VTVuMkpEQjVUR2ROVzUzY2hOSGpBRERtUUdXV3p0bThiSE00R1h4d2tiTHdM?=
 =?utf-8?B?blpsODlSSGw5RnZjQzEvdFlCV3hwaFUxV0ZVeEFXQWI4Z1pJczZLOUlDNlgz?=
 =?utf-8?B?TjVEMXFJZCtRWTMxY3U5dEgxaGV4c2VVZHIzdUh1OFBPeUtVV0hvNkV4a2U4?=
 =?utf-8?B?VXBLcUt6Rk0wV3RRcitlSm5LMUtNUXlueGpHZnRMVHZlcTN5QUNWSmx1cXRZ?=
 =?utf-8?B?dkhlM0FpUnY1dFdidE9aNmcxMWxidUpRQU5tQ1ZVL1gxeGQ3OGNlZG1EcWRv?=
 =?utf-8?B?djZYbklBaEJ6VWtYMW90UUZDWHJyeWY3YVhpM1U3Yk81RUpIYUhjOS9MQWM1?=
 =?utf-8?Q?425V35GEuJ2iQqbkNV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e416d527-32c3-4fe0-bd80-08df35d62d5c
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:03:31.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RweDKsBjf2O0uDxnO9D/bt09y7PDjV2jqYTKreZMJQCBQTXHL9h22WjKkHBa9DhdV9EwvE/bp31HAEkiaf1Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michał

I shared and disucssed this AMD developers (Cc'ed). The patch looks 
correct but limited. They are going to identify the root cause through 
LTTPR-cap sanitization instead.

They expect a solution that will also fix your issues soon. I will keep 
you posted and perhaps share a patch.

Alex H.

On 10/24/26 16:49, Michał Kopeć wrote:
> Some retimers report a nonzero PHY repeater count together with an
> invalid max lane count. One example is the MegaChips (Kinetic) MCDP6000
> USB-C DP Alt Mode retimer in the Sony PlayStation VR2 PC adapter.
> dp_is_lttpr_present() then treats the link as having no LTTPR, and both
> retrieve_link_cap() and the resume path in amdgpu_dm drop the AUX reply
> timeout from the LTTPR value (3.2 ms) to the default one (552 us).
> 
> The retimer is still in the AUX path and relays every transaction. The
> MCDP6000 datasheet gives 100 us of round-trip AUX latency in its normal
> latency mode, and recommends that a source using it raise its AUX reply
> timeout. Reading the LTTPR caps has also told the repeater that the
> source uses the extended timeout, as required by the DP spec.
> 
> With a sink that replies quickly this goes unnoticed, but with a slower
> downstream device behind the retimer (a USB-C dock driving a monitor),
> replies miss the 552 us window. Reading the extended receiver caps
> fails, EDID reads fail, link training fails, and the connector falls
> back to 640x480:
> 
>    LTTPR count is nonzero but invalid lane count reported. Assuming no LTTPR present.
>    retrieve_link_cap: Read extend caps data failed, use cap from dpcd 0.
>    EDID err: 2, on connector: DP-1
>    enabling link 0 failed: 15
> 
> Add dp_lttpr_needs_extended_aux_timeout(), which is true whenever a
> repeater count is reported, and only drop to the default timeout when
> no repeater is reported at all. Links without a repeater and links with
> a valid LTTPR behave as before.
> 
> Tested on an RX 9070 XT with PSVR2 adapter -> USB-C switch -> USB-C dock
> -> Dell AW3425DW: EDID is read and the link trains at 3440x1440@240Hz
> with DSC. The same adapter connected directly to the monitor keeps
> working.
> 
> Signed-off-by: Michał Kopeć <michal@nozomi.space>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 +-
>   .../display/dc/link/protocols/link_dp_capability.c  | 13 ++++++++++++-
>   .../display/dc/link/protocols/link_dp_capability.h  |  2 ++
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bdabb4bf14dab..35885b6d6f787 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1333,7 +1333,7 @@ STATIC_IFN_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
>   			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
>   			 */
>   			try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
> -			if (!dp_is_lttpr_present(aconnector->dc_link))
> +			if (!dp_lttpr_needs_extended_aux_timeout(aconnector->dc_link))
>   				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>   
>   			/* TODO: move resume_mst_branch_status() into drm mst resume again
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index ad1a499b0d9d2..25e901f23d2db 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -404,6 +404,17 @@ bool dp_is_lttpr_present(struct dc_link *link)
>   	return is_lttpr_present;
>   }
>   
> +/*
> + * A repeater that reports a nonzero count with invalid caps is not used as an
> + * LTTPR, but it is still in the AUX path and adds relay latency. Reading its
> + * caps has also told it that the source uses the extended AUX timeout, so keep
> + * that timeout unless no repeater is reported at all.
> + */
> +bool dp_lttpr_needs_extended_aux_timeout(struct dc_link *link)
> +{
> +	return dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) > 0;
> +}
> +
>   /* in DP compliance test, DPR-120 may have
>    * a random value in its MAX_LINK_BW dpcd field.
>    * We map it to the maximum supported link rate that
> @@ -1825,7 +1836,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>   		return false;
>   	}
>   
> -	if (!dp_is_lttpr_present(link))
> +	if (!dp_lttpr_needs_extended_aux_timeout(link))
>   		try_to_configure_aux_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>   
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
> index 6e17f72a752f3..e5c2382390a11 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
> @@ -55,6 +55,8 @@ bool dp_is_sink_present(struct dc_link *link);
>   
>   bool dp_is_lttpr_present(struct dc_link *link);
>   
> +bool dp_lttpr_needs_extended_aux_timeout(struct dc_link *link);
> +
>   bool dp_is_fec_supported(const struct dc_link *link);
>   
>   bool is_dp_active_dongle(const struct dc_link *link);

