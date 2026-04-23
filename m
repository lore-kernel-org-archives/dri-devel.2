Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F3F9935A
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AFF10EFFC;
	Thu, 23 Apr 2026 09:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WcPUbgp8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8590710EFFC;
 Thu, 23 Apr 2026 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776936852; x=1808472852;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RgtwLA6JxdeVVP3NTKxHKz+BGXkaOhc7Ev9juHLNziY=;
 b=WcPUbgp8nD5EwnjpPNW132Cy25/gabC8FUUOkOr3ehcou1OG7wlSG2iH
 UtHcbMyqjFTkk9kXp480C8gDc4jPeK9Go0Y1NKV2DmA7saazNRIO6RcM+
 zStXryFQXsM3tucsA7skMaXYs6XFVdDe1Y9jgBE+ZuLPyuhIcFXAXbRZ9
 mS3b03/qb3hWt7o4l1iU8v+6E8oD8Jgv4YCHdAW7R/gSTmCeyu2xDHTu+
 WmJVIg7Kkh0CNXCotFRDKPUY2OdjOiEnoZC4cvbgYznCkQ+I0uubAl24g
 coXCal74qwndubPYnf7bIws4UvISrLaLaf9veSWQ4aVYNTkK+z/8WV1lX A==;
X-CSE-ConnectionGUID: Y3pWYn1nR7SqdOH3dczHwg==
X-CSE-MsgGUID: WNKKSFOGTnuwxuhZXqv1cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88984283"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="88984283"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 02:34:11 -0700
X-CSE-ConnectionGUID: c3lU3NYqSzaeyb3seLJQ8g==
X-CSE-MsgGUID: zOcQnOq/Tr+M8SCcV6OCWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232517028"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 02:34:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 02:34:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 02:34:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 02:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFA3h0eFqdg803sATaJ8JhFs/e27mU0xMzoS63OK4h3MSWwOqjABggzw8Uk8Xk74JV0GEsbIa/ct1cr1Zo4nX9VbE/x15A+WJFqBrrLx+XhFpMNh/yOEEXuOJwE4zjhZw9uao1mfLkYZCc72V5HBN204PGW5bsdxYpSyy1s565RvyA5bXGSif3Kez6TEmNj/odwP9NEoIBHP3QRgZMrbZp6J5hSfIn8ybFZ3YLI5wVqgcJ1hPLL/4C3aZf0G5h9Ad/MT0IiWxMwC8iLZkGfKKz/KpatF1ZvG4FCsv/4RgdTGgnpKEzahPcTQuRoJUh/iUSabRcaTpmR/jdijUep4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCy4PGC1ujEeFaS27m8xS6iIYvns6mGoe7835Ggdg8=;
 b=MwFLjZeX25+7yAzDygupVw3w6AJo9uVMsqNHwbcVX2tUM7wURppDIV2dajYSWQ3Mb7GvQv1+R2fp4RvrfVw1tf0HYRvWBtmu5T7eaDEIwKSyQ9USD3T0NeEGWNh0/TEnw8VABUxJMtZbU3EhlLo/i/P8u6BMM2a5tpKy6HVQnyb31DTh4XKsSYv3ZdQ2Usbj89GpN1+Nm9HdYb1z+mlBnR1oLiupJtPrWGpSmPreqkC8f4DxSWu3s76w/enQVsRtBrDkHyVMoJmLVPlaC1O+T/c7M+8ngHUpN1YbQ1aS/2UTROriTq3htAUDlMFWDn37b9FhtJJszzW1OgFsJR8vjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 09:34:08 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 09:34:07 +0000
Message-ID: <1fe865c5-3f82-4178-a88e-88a6837a4819@intel.com>
Date: Thu, 23 Apr 2026 15:04:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/9] drm/colorop: Add limited-range YUV-to-RGB CSC
 FF enum values
Content-Language: en-GB
To: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-3-harry.wentland@amd.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260330153451.99472-3-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::19) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|BL3PR11MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: ff91eb0e-68ec-4659-07ed-08dea11b777b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CpKfc/NOIZonQ7V2VhLb+nlILTM/QWyCHa6d01uwWYXIHklmGVTvsCePYuYvW8zwAHY7YhHBuwqBbfdiPapdZ43UzEcTVMx9d7aM9Bc06fFi1TjEGycP6IIsA2amQWDMWX3L17lKZzWuFO8QWHMfYqBrhkgzZ/MvddjJwoBlp7pTDh0/ooWd/LqlxWK4Vbd/ySHVBP3VvDoFvOuyWcusHFfl0yGVUSl0XmcWGvDzqwgkSD8HjUiy+Dbbii9hcBtAnEcDiHrUzIjMoZJUw4udbAYkeCqKZNetmID/TEvBWC5Aubo3SFPK9OJECiTSrqd5YJCoAvQMhBE1HDTQNVmabsFtUoKO/W2XFvlLuZi4qmUp/W7+KihnMTM1U6x9VzUMSptZll2+SzKp9+DGwaMuJCT0F2v3IhTxat0VoyhTHwss9aVIM8uDwY9sRUxDv4TC++ugfW59Qj7Xhhau4UMT9SMX7ny+mpK2FRK/vDFG495P0zUILdzQJQbVPrdOpc90Hp1aQQPHZ/5U2dIcOly6B3GxjCspfV4goXAR3SBPGQ/vcyksW9wQIwgod19eldvuSpT/vHJo7Z7oW0v+HQx41HGwsZRB+fm0NgZnVwkut4h86NzK4W63cz8T+qnIZhOGYWpzf1fkDNMAQ9kSlqo0bhPmE+b+idHtB69cydFrvYcLSA7AkaW8nPFCk/+qIUJSKNBj5e9hKiIHSTF69Ufp8/4W7pRWttcsbI4/eOGTD50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlqQUppL3MzV1BvQ296aDhZb1NGNmsvWnVmTkRQNDRaSEN6c1pCdk9zNWRq?=
 =?utf-8?B?ZFdYWE11ZlAraTZTTDRJT2dYbmVaQ1I0MXhTWFNtV0xsaE81VEtnMENUVCtI?=
 =?utf-8?B?ZXRlVWx4NXhzNE9BRHFoQXNRbGFVNVRhYis3dm5TNlI5Z3YvbzlPb25SU29Z?=
 =?utf-8?B?SjJjUjFmM2l6dUg2M2M1OUU3WFFaYWlGN0Q5OVl2OXVEeEhhYnpnekxLYy8r?=
 =?utf-8?B?YzZWWmhYbk9rSmRWdy9UWG8wYUZ5MDNIbjl1NjAxL2VuN0xXNVQ5dHRCNU5L?=
 =?utf-8?B?OXMrd21EbDhOTzNvaGxheUd6ZENrWDRzRVBKOEpWNW5YdmVaQ3ZhU2srVWgy?=
 =?utf-8?B?K3hYQjIxQi9XQzN2T3pCclI2UGdtVERmNitIbjNGYXRZVUxNaCtnVkxqZTd4?=
 =?utf-8?B?cmZqVFluMCt6eUJqZy9zV2MzSUVoZTFuWVRVSW51azVSd1d5VEJtZmZXNmF6?=
 =?utf-8?B?dDU2eldCaW1zdlFwUllTdHNEQ2k5bllZdmZkcGxGQzV2L1o4enBHMVpZdlRB?=
 =?utf-8?B?UDBBbnF0M09IYnFSR1YxVTRZVDlxWEowc1NHT3FMRS9xakhiV2hiZU9BZGdD?=
 =?utf-8?B?VFRUNXNEL3dBNFJIaFRiMnQ5V0tlQzUzZ05KcGQwN1F5NUg3YWpPcXpmU1BH?=
 =?utf-8?B?aUdidUM5aWU3R2NJZHBxRzBHMEliZ25XVmRGY3VoMTYvUXdFMHBUSzdlYkxJ?=
 =?utf-8?B?eWxuNlpoUDlyWkdKSzN4OEFkUmJ6cllnbWs2bkg3THpBOG16bUlnMUtpNWtD?=
 =?utf-8?B?WDlGWEFpYStxOWF6RE5tYlVkeVdEZHNsd09ST2RLWXpFNjB0Q0RTWlFKeHVO?=
 =?utf-8?B?d0dYM0ZVSHBreUpxYit2VkhxYnBXSUhLZTJHZnA5L1FaWXZhYjNBcytPTUN5?=
 =?utf-8?B?U0dZTWE4bUY2Um5LMVg0NTFYSEpzNEpyUGcwNDY1TGpuaC9ZQzF1bVBySFh3?=
 =?utf-8?B?R3U2dXFqVE45OUI5TmM5UlVTaWFrbE5pRytTMFRXTURPMHhQak93TTVtY1ps?=
 =?utf-8?B?K1RQM1ZOTEdNTWhoYytTd0xTcW5wWldxakt4cGxmTGhxTWVUaDl4MWVVWjNs?=
 =?utf-8?B?aDZCVnV0bS9qbFc4a0pRRVZOeWZWbjN3MytlbStsem96NWZkOU5BNS9qWTJ3?=
 =?utf-8?B?Yi9FdlhJOEk3UENhazE1YzBqa2s3MmpHbGozdkY2d1EwbGpBbXJDYS85Vmxh?=
 =?utf-8?B?c3pHYzBQNVBEWkhvVVFxK2praDhQano1dWU1bEdmNXBmK2hrdFhOR255MnBh?=
 =?utf-8?B?UU9GMUg3Wk5kS2FJQm9sNWVpaEpVaDJVMnBmeWp5YTNjVm9WeHJzeDA0WWlK?=
 =?utf-8?B?cHZ6ODZsY3dBTnV3RkRzYnM1bUhEcGxzZkNhQWlvdDhWbTZJclVNdHhNcDhh?=
 =?utf-8?B?NkVmc1FGT2hXbmlhM0xybXJ5UVZXMC9wMWlIY0MwbFNyK2lHUUpmVDJNZ091?=
 =?utf-8?B?NGlHdHU1MzIveWRHanR1WTF4eVNBN1IvQXNlK0hTZEhTSk5NQ3BZYmpZWFNQ?=
 =?utf-8?B?a3VOeFJ6VHl1U1AyQTNKekM4ZUlkdzBSRDB1N0oySFM2N24zdHkrRnlkaFVF?=
 =?utf-8?B?dVQ0cDZHTzA2WUV0eTIzb2ZpWGc1YVdOc1FUTXo5SjJpcDlzbXl6Q0gwZHRN?=
 =?utf-8?B?S0tYbGxvcXpkMkczaWN0SGk5TmQ5bURaU1dzOWR2dGsybE9ZOFBXQ1M2L3R6?=
 =?utf-8?B?aUdITlBIUHNmSmZCV3dFUWkzTzhXejQ0bytOM1Jic3pVVVJ3K1JwQXlDUHI5?=
 =?utf-8?B?WkNQUkJFYWIyQkhGdTNyNHRpalNINW8ra2h6cy95T2pPZEJjRk9xNzhRc042?=
 =?utf-8?B?dFBhOXFJMmVsYS84SlFGdzVWSmJBelhJcStvcTg4SVdieGIxSUNyY29KVTZ6?=
 =?utf-8?B?RUc1SUJxYTJLelg4M3oyYjliM2w3bUNOMXNzNHpoaEkrdU1uaEtFanRqRk04?=
 =?utf-8?B?TWo5K1pjQzUrVFBzUFMrQ2ZmUW9qMTE3M0E0cDlHTnpTMllIT2hDOEtlc0Jr?=
 =?utf-8?B?UiswSXpxNXlnNG5yRmJSWnBmdVhqbnBlVmVXR0VObndDNmRsOFZyOERVQm1K?=
 =?utf-8?B?UmU2TmhCQWNxNERMSU9Qc3VuUXFNQTBOWHZHRWJia1VJODQwMUZhY0NCckhs?=
 =?utf-8?B?bnZHYVJmZGYvZUtXSXBDYStkVWhrejJOV1c5VlVMTzhlWmZzNTlNWEV1L01n?=
 =?utf-8?B?V0t0VGlJWWQ2SGtCTUh3Yzc1WHFDdDBOemFodEN6aFM2UE9qdzJoMUFmdExE?=
 =?utf-8?B?ME5SL2diUm5qczRLT3hLR2VRSnZ6SEJhZngzZE9PQ1NGZ0tSSXFyQlJWWWN6?=
 =?utf-8?B?VXdVcWQzc2FHNHFJcTZpdTNtb0RRM3lEU2tvZ0tvT2N2Um84dzFyUnBvbVZa?=
 =?utf-8?Q?Plaholwo8YD2clBI=3D?=
X-Exchange-RoutingPolicyChecked: NZjhYoIbs+hrorVZqnWwqALGhd+LBK8i03DQQs4VgH39KkBVvBRLQ3A9Ew6b7tFhp9k43/HgXJz2ZMgP6VxdW331BZJk5cFkyQ9qcPBv3RLSf5kM3xQLRPl20eXNsroCWFaKGkVTyKBgq9Q6d5nKS4tAu8Nipsxtao3EQA7xDlR5BIVtBgNou2BQfC/uqY/ux4UN6V0T4YPetdgi8AkehOHYNJVwUMvdu3DTq4cSsUSvyESzWe5qBHR5ADsFsKFAA0jIsor1tu7fFxINNAbhjsXjM35rkXNw1nxb6ERt5cl+DT0D0nalmEhpuc33wcESi4CVDyQ//VruV1djFyaitQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91eb0e-68ec-4659-07ed-08dea11b777b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 09:34:07.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6f9rgctvNYzhEydh3Cyt3TMsRGX0abN0r+fRFPl2k46abmZXX+AV13hcx+k4eCDFi27k/bskn2i8t9mv+DebNE+gGN+etAFjiYSDIxwFag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
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



On 3/30/2026 9:04 PM, Harry Wentland wrote:
> Add three new limited-range YUV-to-RGB conversion presets to the
> CSC Fixed-Function colorop enum:
> 
>    - DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601
>    - DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709
>    - DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020
> 
> The existing full-range enums (YUV601_RGB601, YUV709_RGB709,
> YUV2020_RGB2020) are kept as-is. The limited-range variants are
> inserted after their corresponding full-range entries.
> 
> This gives drivers the ability to advertise support for both full
> and limited range YCbCr framebuffers via the color pipeline,
> replacing the need for separate COLOR_ENCODING and COLOR_RANGE
> properties on the CSC colorop.
> 
> Assisted-by Claude:claude-opus-4.6
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/drm_colorop.c | 11 +++++----
>   include/drm/drm_colorop.h     | 42 ++++++++++++++++++++++++++++++-----
>   2 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 6a345e2e8b15..f0d11cf7e3cd 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -92,10 +92,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>   };
>   
>   static const char * const colorop_csc_ff_type_names[] = {
> -	[DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
> -	[DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
> -	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
> -	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
> +	[DRM_COLOROP_CSC_FF_YUV601_RGB601]           = "YUV601 to RGB601",
> +	[DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601]    = "YUV601 Limited to RGB601",
> +	[DRM_COLOROP_CSC_FF_YUV709_RGB709]            = "YUV709 to RGB709",
> +	[DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709]    = "YUV709 Limited to RGB709",
> +	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020]          = "YUV2020 to RGB2020",
> +	[DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020]  = "YUV2020 Limited to RGB2020",
> +	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]           = "RGB709 to RGB2020",

As I understand, all combinations of input/output ranges are 
mathematically valid (e.g., “YCbCr XXX Limited → RGB Limited” or “YCbCr 
XXX Full → RGB Limited”).

I am not sure how widespread such use-cases are but will it be prudent 
to have the enums be named as "YCbCrXXX <range> to RGB <range>"?

==
Chaitanya

>   };
>   
>   /* Init Helpers */
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index 2cd8e0779c2a..c414b9070afb 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -145,31 +145,61 @@ enum drm_colorop_csc_ff_type {
>   	 *
>   	 * enum string "YUV601 to RGB601"
>   	 *
> -	 * Selects the fixed-function CSC preset that converts YUV
> -	 * (BT.601) colorimetry to RGB (BT.601).
> +	 * Selects the fixed-function CSC preset that converts full-range
> +	 * YUV (BT.601) colorimetry to RGB (BT.601).
>   	 */
>   	DRM_COLOROP_CSC_FF_YUV601_RGB601,
>   
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
> +	 *
> +	 * enum string "YUV601 Limited to RGB601"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts limited-range
> +	 * YUV (BT.601) colorimetry to RGB (BT.601).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601,
> +
>   	/**
>   	 * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
>   	 *
>   	 * enum string "YUV709 to RGB709"
>   	 *
> -	 * Selects the fixed-function CSC preset that converts YUV
> -	 * (BT.709) colorimetry to RGB (BT.709).
> +	 * Selects the fixed-function CSC preset that converts full-range
> +	 * YUV (BT.709) colorimetry to RGB (BT.709).
>   	 */
>   	DRM_COLOROP_CSC_FF_YUV709_RGB709,
>   
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
> +	 *
> +	 * enum string "YUV709 Limited to RGB709"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts limited-range
> +	 * YUV (BT.709) colorimetry to RGB (BT.709).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709,
> +
>   	/**
>   	 * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
>   	 *
>   	 * enum string "YUV2020 to RGB2020"
>   	 *
> -	 * Selects the fixed-function CSC preset that converts YUV
> -	 * (BT.2020) colorimetry to RGB (BT.2020).
> +	 * Selects the fixed-function CSC preset that converts full-range
> +	 * YUV (BT.2020) colorimetry to RGB (BT.2020).
>   	 */
>   	DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
>   
> +	/**
> +	 * @DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
> +	 *
> +	 * enum string "YUV2020 Limited to RGB2020"
> +	 *
> +	 * Selects the fixed-function CSC preset that converts limited-range
> +	 * YUV (BT.2020) colorimetry to RGB (BT.2020).
> +	 */
> +	DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020,
> +
>   	/**
>   	 * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
>   	 *

