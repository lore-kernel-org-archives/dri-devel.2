Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35841F54ADA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7297210E765;
	Tue, 24 Mar 2026 17:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JQT8O0b0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A7910E515;
 Tue, 24 Mar 2026 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774371736; x=1805907736;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VnNJYuJuKLyYcOUe7Frl4akb3ItwXziRhzNF+Dcu7II=;
 b=JQT8O0b0SHOie66RQAQUFO1NNty7sEG8n/LIdlFpNRYLn+MhJv/06Qje
 E53byuBU/AbjVXr1UoQ8gkPdTsPFhpjRcEp9jRktHaq7a/BQ32Pl9PUwK
 4Dm+3VFZj5Ms/SLBJQXBqpwJ58W0edn8dcOQ5+bhDb7JtU7al0Eu3cV8s
 QWY6WDo+wU0d0J+KJRFXUp4f1HsjmdZZawvpVX0mQOfWWbawFNz0J1iUc
 Eg32Lop+llMCkJmMU4RwpMBt/a+EmXkkoR76wLooYojW1W8mDf+IRmfWx
 9yCQKHWL/IKvIRFjCo4n5/G4uXfkWpd3OvoGhet+AsnGBk1olrce8jRbC Q==;
X-CSE-ConnectionGUID: AU2d4jAzREatAPuRkA8rnA==
X-CSE-MsgGUID: BZyR2pqwSamwpaGgBVHrRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75588750"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75588750"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 10:02:03 -0700
X-CSE-ConnectionGUID: kd4juJ3lTpmY8UB+OuKxrg==
X-CSE-MsgGUID: 6yXDxTuGQgKLdc/1X+Ub0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="223478176"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 10:02:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 10:02:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 10:02:01 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 10:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrDNSrStUQeuM3ar2lPj5dTDLvL+Ge2OBFKU8ZprRA/F5fNuVMegPDXnftiqaIKudKc78AR29IgMlCkEd9bFKzLWEwhXi0LJeniwLa3EaQ3MwcbGWCsxR7IubmAt9mvt6g2Ss8/XYGzoDcX2UtVJ0H/q5hbjU0iZhfEzEDaRh1WZa1GC1U40ACtQOK7c/YWq8L/Z5lt4yV8v9rtLPDrNL4gd6hdtmwSkmagH0EdXqV2ZvxBpmLT4ol4gbqqJGA0dGOOz1LB1kKzAqLXfUyf+HP4UiRGlS6j7083nkGuxRKKhSI9Op6PtXFCF5Zue1cutY5t32NsOFsGIWb8t2QZLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU6ITg856UrQimHmA+iEh1gWmsXUZSOJcjR4hBHVEU8=;
 b=NIvdPVK/siIwSG2Cb6fn83PuTdup29lwZkDdni7USyrYODWTtoIKtaVfyujQvd/AGPJ3Ki4AAiwt8Jj8JvMtB7hUhVPaT8AC1nZVy/l8mFop6mx2t974wG1TXiJjjuCsHU5NtfEt8D8zWD1EBU0yPHQMLlAtErAZGGcZ9spBe5Mnr6TJIJd2D45qVWXD3oLjGk9tLHvy1NGuz1zo/vtsef5s5ZbEl9PFdsd4Eo5rRaYQw0qBULw+82qxXYUnmbhAzGd0saDjhox86TrNObrKNGTh+zF2ynapw9XgUUPhWzg/lVys/jbvoazvyD02kI7w+J0/EYpYODPfALQYgbG6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:01:48 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 17:01:48 +0000
Message-ID: <9fbdff81-f909-4baf-9560-1104acf36ff0@intel.com>
Date: Tue, 24 Mar 2026 22:31:41 +0530
User-Agent: Mozilla Thunderbird
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: Re: [RFC PATCH 00/10] CSC Colorop with COLOR_RANGE and COLOR_ENCODING
To: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>, "Uma
 Shankar" <uma.shankar@intel.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>
References: <20260317160350.229028-1-harry.wentland@amd.com>
Content-Language: en-GB
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::9) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|CH8PR11MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7c5d00-48ba-4ca2-ba8c-08de89c70933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: H361Ihx/nRCSTvQVbQINaC+5NfDWFzf+Is42bke97iqy0CbTNUiKrU/C89IqRytiadqu+4109F+IJBIpEdGwC2fNEN/qLBnhIWTaGN5/GG13p7/66yynsOXCkUCntmxi9lLJ9XLxOEUsvAFO+TmgoOJopilcen1Mgli9YlSgcmEbr0TgBfLBMt7OdlNzmrWcEhUuqu7B9deXJGo8ZeiOlr9BJp3aO5mRlOmD0UKErDbUa4BpfBCjsOEcToq5Z1FeK4MXAfmk9E7RhtiTbaUxQBYScH15pBVjpm+fvoHJ8sTcQR8imRzeNl3hHlrPN/MhYgbGIgEoZCWOG2bX+VkCL+m/stdeELO7q1RQcvAsfYFZZ4Dvj9xZI/2PL/G5BchgXdM+/dD89j96y0iH84chgBzpDkOkbchI5Nac4zI95FrUJUWah5ui9r572e29dKUrHrzyB1UfYqT/6KbzsMMWKEpLGsyzjwyKPsNo10KGxpielEUu8DDEhmbc0/C+u6QeCN7uhXJlYa2BoQ1+pxM3ghYdP/OvpCMSXTyoMz0Aenyli8L9qB1g8lV6GeXy/64NNJ5UgSnQjYNjsDIVzyoO80IWgCQ15At5n1EcA/o9EIMdz+Mc9i8EIdNVIRNow+KleDnhPJxSSearsZ5WgFD4sbE58ewi4vIJ/Qmwt2mbKKB54lpnyTXX0WOW0lF0sc/l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVM0YzdNVW5MbEtOREs0R0lKcVpwYUVJbHZIQndnTHplMHM0bDhFQ1kyQmU3?=
 =?utf-8?B?WmhtZnZROHpaRHNSb2pETDdpVTJVSnJQajVkOWNZY1JZaHo0Wml5WUI5M09C?=
 =?utf-8?B?QjhDV3FWS3FkeTFZUnFySlYxcUVNRGpBbzUxcC9aS3VxVG1nc1ZmYnd0VWtV?=
 =?utf-8?B?QzMvREZDTE1VZFYwakNYOXJKZUZOTzVpc0h3N1ZYbmZMN0NsTlNDQ2pCaUhl?=
 =?utf-8?B?bGlaemk2d2JSTVc0QSsycGRxbmhFclRSTlRMbnZZaTBuMU9IakZESDFTOG9B?=
 =?utf-8?B?alphYVgyUk0vdFhRb3dFc2NtekcwYS9aZlB1TWh3Q09yMURJbk5zU3ZDTW85?=
 =?utf-8?B?QWErY0FMZ2xSbUx1RjA0S0VkeVRHK0QzQnFFR2NEMVRoUllPN2NIK1BvUnVM?=
 =?utf-8?B?RUJ2M21KZnJCaXBWc2pZRk1vb1hDS2I5R2ZMVlh5bWlNdWs4K3cyeHQ0TDVx?=
 =?utf-8?B?WjM1WVFBOHIxRVQrMHowWWZMTnJwN2J3bXdRK3ZjTE91VDAxUVkxVU9vUDZm?=
 =?utf-8?B?WXdwNGNFbmc5d05jRURHOFg1bUpEYTNxeGhxUnlHbUhwQlU1WGdZakNRVmpy?=
 =?utf-8?B?NTRRZk9DcFdYUGgvRE9ZNVlJbUh1Qkk3Q1FVc2daREI1d2w2czVYNEI4dWV1?=
 =?utf-8?B?VGE1NWxRVXNBL0dkbjIvaUxCSHNPRFpnZWtRbTVwVWt2c0Fzc2d6bk5DZlJX?=
 =?utf-8?B?clpjbEtGbnlhQWxueUpaNk44bkZtQmptZDFIM0dqMlVvRDl3YkdHQkM0bXJn?=
 =?utf-8?B?WmlaUlU3dSt0ZFFQMnNTZnJzekJVZGkzenE4WU9CMHBBMHRJM3JrTFN0Z1NS?=
 =?utf-8?B?dGdyaHQzSEZCN3BXdU10OXdEWWo4MlR3YTJrRldQYmdxUkkrTFl3V2pqL2dW?=
 =?utf-8?B?Qk1PSDBCNUNXTGlCeGdKTEs5T3pDUGZ1RUdTK1JYMEhPQzJkV0M2UnR1Tytu?=
 =?utf-8?B?V2NKaHlncDJiZHA5b2Zrd0JCS2lvN2NMYlBmV1Blb091dTVUSFFDRWFOVFYy?=
 =?utf-8?B?UG9oeXpzOXNLdGRYSFNib09uNHROWFlrejNjNGw4RVBVY21iSGxvSVdMcVR0?=
 =?utf-8?B?NkIydGlGU1R2NWgzRU1NY1FrUk1ETVN1YVIzOFg3VXIzeFdpek1tWUFtNzZ4?=
 =?utf-8?B?dEs0SWpSSk4vT2o4a1RFS2FScG9XcW5OdW1GamloTk8xUmdOMlQyU3ZVaDhE?=
 =?utf-8?B?eHlYNzVYR3E1KzdwYTFDalU1Rk84bWJWRStSUHRXTW12YWZ2YlJPNmtmdmxj?=
 =?utf-8?B?cVlyTDdxYVdLU2FZT2RjSElVenJmNy9MRnhuYzJVRzBHM1FBaWwrcFcyVExx?=
 =?utf-8?B?WnUxQXZsUTAwVFNYMWl3SlNGckdHUkVqSTZmSmlyYXd5eS9wclkydzlGTkhP?=
 =?utf-8?B?Y1hCVVdLZXRuRGd4Mm1KNkNzRWtHVmFUanU4OVFuWTduRDlFODBEWXV0TlBi?=
 =?utf-8?B?K2hDQVRYb1RlbGRwek5QVFNaMW1ZUGlvQU9UQld1ZXQvK1pmbnJuMjJSTzI3?=
 =?utf-8?B?SDZPL2N0a1IrVTdURnRFNU5hWndNYWJuUk1VR0xBNzJZcmNVSlkwQWlzU29P?=
 =?utf-8?B?ckM4Q1k2dTcwWU5PZEJvYU91R1JhY2JnMElQU3h5NXk2TlVJVDVGT29QaGFs?=
 =?utf-8?B?MG1OTmZmZnNrbDJPcXlhNVhnSncxVlZNVTVNc20xbE5paWUydUtrL0tUS2NJ?=
 =?utf-8?B?WFdSMDUzMnZzVXRHZFAvMlE5NHV1RjdBSmNxSkZNYm15cVlOdnJmcVBtN01N?=
 =?utf-8?B?c21xT0JGSjFnTXdFYklzekpzeXVoZnlyL3lNYWdtQlhqZ0JVWUlCUDJuWjBQ?=
 =?utf-8?B?WTFKZ2FTa1dNK2huZFViTnBlNHkyY2dHeFF5SFphbVgxY1pSd2VVSUVCeVQr?=
 =?utf-8?B?RUF2NHNYMURRaUIwaUlWRXYxR1pyYk1MOXdnbzJ2V1loLzBTRzFhSFB2ai9K?=
 =?utf-8?B?V2ViVktDbTF2VjhtVUxKdjZLRGJqeGxzNmtQKzJLQVZWNGU5ZzJKc01QQjZH?=
 =?utf-8?B?L3prS0FxUFZ5a2pKbGRVcldPOFpkVklZK1kxbzRrUy91SndMc2xLNnFOZlNq?=
 =?utf-8?B?UzdVaXVnL0NNUWY1MU9Sc1BOL3RNQ09XWEt6eTdrTFI2OHVOcE8vbWJiTHlK?=
 =?utf-8?B?UU5MbnkvQUh0NUxGcFQyemxPS1dNTkQrVWMwSGtJWHlYVmhlR0JBdy8vODVV?=
 =?utf-8?B?NC91bk1BbUJmUDV3dEUrNnRndU5wUjg5S3VDVmZwV1JEbXFUY2ZIS1NrSzF3?=
 =?utf-8?B?NnVjMjZzYW9QTGRlODh6U1RPVytnYlR0WG1MaUdRMTFOOUxRV1VHZlMzS0JD?=
 =?utf-8?B?Ui9IVjBpV1hIZXlyUDIreDBtd0FaVVhPUUJDRUJ1a21JUm4rOXdVN201REZp?=
 =?utf-8?Q?6BbqYS8D6EdqbC28=3D?=
X-Exchange-RoutingPolicyChecked: IC6yRoRzMNJtItyss0bXv3qc/Yc+g65uBe/rkctEV+CnVKUx7isNvG5Oc6PY2I6z9KFIezm2QqA0VWfAU53Zqb5bR6+IrnjY4echwYp+IA/e35dMyS4fc/i3NuHpk1GKZEumVJIf7ktRuHqqH9pd2Y1kVouTrbImcfjBPlnaUdgunuY4V6v9CubXN1SRIfypNTzYiPMTPdBPcsm88+yuu1HusXtNyR2y6vq1CykWUDawmN6wYQ4/0uDIA2QoWiD8jM2u97bf4p1O12jcN1NwAGgGp1tDD0Dq9kgLkT336CJeoFnjjrCcCs2RkwkHkVvbpJU2pWlcE84axl4BtRtm7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c5d00-48ba-4ca2-ba8c-08de89c70933
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:01:48.4331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0MYiYse30bjE498Yff/0TosFDgIS8tZZjLMtag3cqTZ8f4HgkuInu1BDw/+At2talZj/8JURchVysBvixrg/WVZo4x5rDbe7mp246tLefk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
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

Hello Harry,

Few thoughts on the series from Intel perspective.

On 3/17/2026 9:33 PM, Harry Wentland wrote:
> When we merged the drm_plane color pipeline API the major gap
> that existed was the lack of a color-space conversion colorop.
> We deprecated any legacy drm_plane color properties, which
> means that the COLOR_RANGE and COLOR_ENCODING properties can't
> be used with the COLOR_PIPELINE property on a drm_plane. In
> practice this means that we can't use a COLOR_PIPELINE on
> YCbCr encoded framebuffers.
> 
> This patchset adds a CSC colorop with the COLOR_RANGE and
> COLOR_ENCODING properties and implements support in VKMS and
> amdgpu.
> 

AFAIU, while COLOR_RANGE and COLOR_ENCODING were plane properties, they 
were more representative of how the framebuffer provided to the plane 
should be interpreted, rather than selecting a transformation. So using 
them to define CSC behavior is bit of a semantic drift.

From, Intel's HW perspective we could re-use this CSC colorop but it 
would be
preferable to introduce new enums like "YCbCr709 to RGB", "YCbCr601 to 
RGB" as discussed in [1]. That way we can still represent the "RGB709 to 
RGB2020" conversion that Intel's fixed matrix CSC supports (instead of 
inventing a new colorop). We might need to change the name of colorop to 
something like Fixed Matrix to be inclusive of both YCbCr to RGB 
conversion and Primary conversion.

Regarding the range property, we could re-use the COLOR_RANGE property 
as you have done. In the case of Intel, we would only expose 
DRM_COLOR_YCBCR_FULL_RANGE as supported for this CSC, and use a separate 
colorop to perform YUV range correction. This allows userspace to still 
pass limited-range framebuffers. I am assuming here that it matters for 
user-space if the conversion was done in limited or full range.

[1] 
https://lore.kernel.org/dri-devel/20260306165307.3233194-2-chaitanya.kumar.borah@intel.com/

==
Chaitanya

> An alternate way of possibly representing this has been proposed
> here:
> https://patchwork.freedesktop.org/patch/709860
> 
> This code has been tested with IGT and an experimental KWin branch.
> 
> IGT branch:
> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-colorop
> 
> KWin branch:
> https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut
> 
> The kernel branch containing these changes, based on drm-misc-next
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop
> 
> In order to successfully use this branch you might need a few
> bugfixes. The kernel tree containing those fixes plus these patches
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop-all
> 
> Further background on this work can be found at:
> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
> 
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> 
> Harry Wentland (10):
>    drm/colorop: Add CSC colorop type
>    drm/colorop: Add CSC colorop initialization helper
>    drm/atomic: Add CSC colorop state handling
>    drm/vkms: Add CSC colorop support
>    drm/vkms: Add atomic check and matrix handling for CSC colorop
>    drm/amd/display: Implement CSC colorop support
>    drm/amd/display: Use GAMCOR for first TF if CSC is used
>    drm/amd/display: Check CSC colorop bypass before programming
>    drm/amd/display: Check actual state during commit_tail
>    drm/amd/display: Set color_space to plane_infos
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 115 +++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  25 +++-
>   drivers/gpu/drm/drm_atomic.c                  |   6 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   8 ++
>   drivers/gpu/drm/drm_colorop.c                 |  91 ++++++++++++++
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  64 +++++++---
>   drivers/gpu/drm/vkms/vkms_composer.c          |   5 +
>   drivers/gpu/drm/vkms/vkms_plane.c             |  50 +++++++-
>   include/drm/drm_colorop.h                     |  39 ++++++
>   include/uapi/drm/drm_mode.h                   |   1 +
>   11 files changed, 388 insertions(+), 30 deletions(-)
> 
> --
> 2.53.0
> 

