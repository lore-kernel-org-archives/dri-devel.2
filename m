Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E784D1076365
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F7210EC18;
	Wed,  1 Apr 2026 05:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kaiB+mk4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82BD10EC18
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 05:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775019640; x=1806555640;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=t0z5p6McdmwhUUqN+eJfX/05F5gN3Jpi72HFKhDbpJs=;
 b=kaiB+mk4+Ti9sQkrYlRBatwMjrwFnqUcAZIP/frIe9sE2f3m/E33UcXH
 ZePE/S3yUNjGckFTcY+HFRbxiD8LIvPOmZDrww5ofAPzXdXd74fUOzDY7
 +ulXE881dboAWBeC3MTudgek+3nh56KJlVbrYyHqK71qZUrCnevtd/3Mn
 OJqAndhNFtFVwkJXxHJWxqUzPyHZ3NDabdFADqmV/NDebhG8XBPBh9NU/
 T6rJVItKMHblP2e184hCZEiHFkP8duoZBQS1KAvcN1+omXh/JOBv5Ht25
 FfmsZKBe8usTp/bn4HHtBbSw+OtYVaGevavYDlJwycNBCZntQ3EDF86+5 g==;
X-CSE-ConnectionGUID: fsTaNROKT3eg6sJnQNk7BA==
X-CSE-MsgGUID: JwOAL78FQ1SerkxK+GxCnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87506934"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="87506934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 22:00:39 -0700
X-CSE-ConnectionGUID: 0C0z3WuESMqaSwt46QZZmg==
X-CSE-MsgGUID: xKDQlp5xSjKmJnjf21SK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="226442524"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 22:00:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:00:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:00:38 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C758O2LU14vQo8djJw/Dm5AxhjL5d/czUeXsk2M6+m6oCmnVOSPW33emWDoxTzfS4NrTZ33wg3qJcjP+beQfXgbMexV0Sx7O0pd/zZ1DROeFfZV63xFkarL05Xx3g7Mobgblah5fA0gZ91qR3C2gThJ0WH3cc55Gf404dwCe9lavIJvde4iJhLAYOrvEdi9Capn06C4pErD/WKFXTEiC04EJL+GD9HKt+6AdjsiTBOh5TpNosEBr7R/CGZZN1MQPfTrkctVXfoxiqBuodSGk5In04oU5et2s5KH/xs0/Jc92GWaClIzeOHMG+dqoz+lubfJh53b4VssVoV38HxBkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkTjT/yE6NXa9dwgMvtICOP3GgyQEilQABm4gVlFI44=;
 b=n24MjzOeKiKWmux26QKpvoY0DmR9lLxy+9XWkHFmHjjKufeJCYQSFLm2EnLLoHGAW/fb42F0fwpO93g+37qz2UsC6xXl9kY1XS8vuyhBClA1DhKRbELmUopdQIOnrn0Nkw4thKc6kPev4y2rbehnqwBxSnGljVbNl2ienyfl1BKFMnwHX2NCCSQK2NLODjw6SxL8MUuvijP6puFg7VGL1oPqXhQ12ESBwmuHSlwxCp5UoX3/mvmS/8eSbim5Yb/8COOsg/dZnv5C8lNzBPgz4ZVKHSA8Q8pppRbAlhON1UzihbSag6oL5K8Hz/ZY2F++h58au/MKtxQS1Tgvz4x8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 05:00:36 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 05:00:36 +0000
Date: Tue, 31 Mar 2026 22:00:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>, Max Zhen <max.zhen@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
Subject: Re: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO
 mappings
Message-ID: <acymcah+Wlt/T4sL@gsse-cloud1.jf.intel.com>
References: <20260331172635.3275296-1-lizhi.hou@amd.com>
 <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ0PR11MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a133f6-af60-42c0-7de5-08de8fab9ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: rsH9Gp93XwEp9/X0c8KBYXYVoc01D0LiA4ckrfZO6RpJw7ZPc9YmQEeKSPputqufdBiFkWE7qBbXGJeU+SKRojrOE7fNHZOqED2NUhCdZ42O669TAUaLGqhqL/CMEU0Ua1mT6zDmu+tJC6O5jM/rALge6mLMyAU45Ai2D6yEsK68g7k6bFY1d+L2np7Lx3m3IhQKQnpGMTc6e2ksgZCs7mqZ43PRRo7Qr0WnzeFAAQvyYKQ4CJQi5wofS8WBiuYbqG3zikJ6roh4Nj5SV8tqhgrC1NosBqPOjB0yVG89CbXkmPXSZOuj2qrNp3Q0lpBai8EQgEgyK6+Oz58O+D1XkxDG7Fcz5TR7iBsngLLHZbjvXqEzpy4w/9UF0YFH+O4kxRJ49+L+HDeE7qIeHJX9Uf3qqYB7YjT2xXRbo7U40vYK847TeH3/hEzoClw2Jb5RMAfhDc1v1Cs9QA4JhhCKmtsvD0yNrVnv2UEzNDtVY4CyswINWF76cAde5+Jm7Ywinn6t0KUVZB+xuQIJ0SFxEgZosV4fbqAEAHM9/TE68JM1YafKndSDx20C8C4QUOxzxyMiEedUnk6szTeRm/fqoyNOWFZMRwBS9A6CMYLLIFD43Lq2BQPHmN+wHyYTbDpQj3Hvd8X2/sqVVpQ2UtyzGiR/XAKsqMoLhELjYBlR2b5Vk4/YkunYxqFKN7SrU7Z21eQLQTSRMupBN4rWAWFH5yNfAt+dNoLqwB7F5GM57yE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVDeGVJdmQ3VUJqZWZ1cGtmZjZkbUNXbFI0U0J1NWNyMm5vQ01TRkwwTzZY?=
 =?utf-8?B?VnRuQWt4STVWTG5hNktIY0xVdGFaa0lCQTJCUmhoS0RUL1VSOUgxaytod3Ry?=
 =?utf-8?B?RkZnOU45YlFYYWFsZ0lQU0E1c0RSTDVrK091amxYT1N2dGk0OC8wdzJXZTJs?=
 =?utf-8?B?N0J3dEtnTjRwWHBocU5QOFNQa3V5MHNlcVNDQ2ZaTDA5RXNrT1hacGhpQ2ND?=
 =?utf-8?B?NFVyMVRMNFdlcjBJZmlxa2NPSFJrY09PS0J5NnVhdG16QUxMUE9CTmRTYlJm?=
 =?utf-8?B?d0dlUWJPYVlQZE96UzhpdnBoVUhzYWNKOEdmaHVlcGhnVlNqdzZrZjk5N2E3?=
 =?utf-8?B?cUtoNnZpNG5OM3VQRDQ0aXcwYUZqRWhVS0JxdVpXelF2cnA2Zkx0RG1aRWRN?=
 =?utf-8?B?dkQ2ZzdjZzZkaEhDdFRrZ2Y5Q0lmemJGRENXYi9TMTVVZFJvOUwzeTJiMnlP?=
 =?utf-8?B?dHNVRC9zZStUZXhQRGg5anJQUHZZTUVjMWg5N2hVbzMxYkNVUGxkRngvdHRF?=
 =?utf-8?B?SEhZM1g2dVZtOTFaaTZwK21maXJKdERKMmFMNGlQcHBxNnBWYlVTaFhFR3hz?=
 =?utf-8?B?QzVrYjBPb2Evdnp4TUxBU3J4d09kYWEvUHBOTGlZK1g4NTF1a1VibHF4U3Nx?=
 =?utf-8?B?NlhNMlV0WVlJZVZMOE1XSnRaTzI4QWdQc1l2ZWVNMlNxd2xMMURzN0hZTjRr?=
 =?utf-8?B?ckVXNGRiZE9HZWlsdG1OVlJnZXoyK1h6Q2Z2TmxnUm1CY0RBeUFqS2NXVmpp?=
 =?utf-8?B?Mjh6eG5venZIRW14b0xSeDBSMUlnRnYreVJDNTJYU2FTbVp6OVZWZ3FrYWNx?=
 =?utf-8?B?cmxrbTJra3RRMG16dnVldElqViswL0RlVVFoZUtJWUhOWE5HRkpYbXhRTkk2?=
 =?utf-8?B?cGNpOG03SFFqK3gxdzBUSFhhQzZ1MVhDUkIwNktLZG5TSFlIYmRRNDlTNDZD?=
 =?utf-8?B?dU1CcEQwUFpjYXcwVzg1Vk9BMDBzNW1oWGt3azNNZ3RnVlNHbS80Q2hJWEJW?=
 =?utf-8?B?eE1QejhpNHREdktwMXUyYTNLSkxRUm53UTBXa1Zpa1R3WEpMa0FxRXFQUUJ3?=
 =?utf-8?B?MTcxcHNxR2U5SnYvdllCbzgvQ2hBVlRYWldDSThxM0poaFVRcUNZMFVVWEtq?=
 =?utf-8?B?NVNzK1VnbjVOVkR0YnlrdU5TRE1Mdkc5cDJ5SWtyMUtvU0hydnFkUHFRd1hT?=
 =?utf-8?B?eDVFUXIrdmlCR1hrZzRQOVprN1hod1cycnFQS0k3cFB2MVpwb2U0UGpjRlhH?=
 =?utf-8?B?TGNvZnpIbk90QlhZV0NTL2JQUVJZMDd3bzhzOGpOdy9zUUJFRmxhblR0cUo4?=
 =?utf-8?B?TTl1QVBxMldPekdBbzhnMjlTNCtXbVZCMTR0WGhHSVkwNlJ5eDdMaHYwbEsy?=
 =?utf-8?B?bVRVKzE4NEdUNU0xL0hhL2tYVWZhVHhaMWJOa1gyZndGMld0UTloV3R3cWlB?=
 =?utf-8?B?alJpYkhyQlk1QmdMNm9QNzdyUVRwazM2N1FDd0F1SzRrV2lxeWxmNFYyV3Nr?=
 =?utf-8?B?NHp4Z0I0ZFV5OHFHalZjNENaZjIzcTM2ZDRrbzdQbXBRQXcwR0YycUlVeXlY?=
 =?utf-8?B?L29PSlpCM1M5cVJRM2plRmZWWVYzR1hoc0FSVTNYdVZTZlJwV1VoeWEzNS9m?=
 =?utf-8?B?czMydEJDQVJqeGpvMWh6SEVXNmV6ZXV1SEdLaDJiVXNIcEVucFBEamh2VXJW?=
 =?utf-8?B?enA2d0hwM3lrVGNBcGNIZWRrSHZxZmJnd2I0bWlZUGVQZnRVTXVyclM5anhC?=
 =?utf-8?B?ZXRRcU1EeWFzalBhaGZYcGEvWjl5KzFuTVJOaHdma0ozaXFJOG01OG1oVjlQ?=
 =?utf-8?B?SXFqRWlXdUtPaEEza1FrTnR6TkxrV3BVTkJrc08wd0tqMlpFbGFiOFdmK1RG?=
 =?utf-8?B?WmZTUjkyeWo0MjZyT0pKTERNZXFEMTU3RFY3N1RpR0RySTIyQ3hkQTR6Qk1y?=
 =?utf-8?B?V0k0N3NKOFhRMk9VOG9jL1h5RUZPNG9iU2FrYUpXQmhTUFV3VnEzSGtkd001?=
 =?utf-8?B?cTlQN0NzUlRFTFV1ZEUrQ0RyQkhHWjM5anVSMUd3VmhUTnM3WDJRdWdGbStO?=
 =?utf-8?B?N1ZOTUViQk5pS0tLS0N4Q2RlT3ZhclFpL0UvQlZCUXJCdUhrei82MWJoRWh3?=
 =?utf-8?B?clF1R2I5M3RWbzVQL3BZWkJES0JhOEhCZTZnamoycWVCSER2MUREd09KTjdr?=
 =?utf-8?B?ZG05QXZSMERDbW5LdVRLVGR3NjJtbUcwRmFsZzNIUklvb3lWbUFXeFZ0SzFj?=
 =?utf-8?B?WldkYStzemo3dS9KVVFNWStvbk5Fb3piN2RHOGpzMGFLeURUc0Y5bGVPaXl1?=
 =?utf-8?B?S3Z2UmgzVHFCRFYyYnBuVnIzLytCMCtpbXAyVmNrOVIwb3VIQ3pBRWR2aXAv?=
 =?utf-8?Q?mopcrJnJIzwa3kPw=3D?=
X-Exchange-RoutingPolicyChecked: eFdUkIm/UTrVE39NZN6iuFmdEeMPyXVJ6pdtKYoQsEGVCUKSYCsU82mnZ+7+O1GEJIHq1xXNJ1l8xckS6pGtRYi5rDJ72NM6RFQxxwx06Em6UjJt3ddLb/kE7AE0Sd9M8iPZXWSNNMetWCf2GP1AWgv1YYITnwbTO/Bbfc3lqOmtzP7ENX/Mzv7M4bgLW9bt2XeTUOwHo3BHdtcOefnYtH+Wjim8d/oJKPOOLGxmln6auShW3E3N4HxkXzPhhIV7Wrg7/MbF1yQoD1fJslziKdjWRl3dT7xS3R7DI4mD6qUUNu/AjSLMH7SV1In2RB/atZG8aGqsC5LHiVtTweG2Sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a133f6-af60-42c0-7de5-08de8fab9ca0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:00:36.4038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho3h5oCRWJkwyAubEW45WGWFqe4ij1U3WGPDqi8Tb9f1MXq8VVrP5xsQYUHP5DTFBai5Bsfo7u2jWuLP9dYb9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
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

On Tue, Mar 31, 2026 at 09:57:12PM -0700, Matthew Brost wrote:
> On Tue, Mar 31, 2026 at 10:26:35AM -0700, Lizhi Hou wrote:
> > From: Max Zhen <max.zhen@amd.com>
> > 
> > Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
> > objects from read-only user mappings.
> > 
> > Detect read-only VMAs by checking VMA permissions across all user virtual
> > address ranges associated with the BO. When all entries are read-only, pin
> > user pages without FOLL_WRITE and export the resulting dmabuf as read-only
> > (O_RDONLY).
> > 
> > This allows userptr BOs backed by read-only mappings to be safely imported
> > and used without requiring write access, which was previously rejected due
> > to unconditional FOLL_WRITE usage.
> > 
> > Signed-off-by: Max Zhen <max.zhen@amd.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > ---
> >  drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> > index 4c0647057759..3769210c55cc 100644
> > --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> > +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> > @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
> >  	.vunmap = amdxdna_ubuf_vunmap,
> >  };
> >  
> > +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +	int ret;
> > +
> > +	mmap_read_lock(mm);
> > +
> > +	vma = find_vma(mm, va_ent->vaddr);
> > +	if (!vma ||
> > +	    vma->vm_start > va_ent->vaddr ||
> > +	    vma->vm_end - va_ent->vaddr < va_ent->len)
> > +		ret = -ENOENT;
> > +	else
> > +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> > +
> > +	mmap_read_unlock(mm);
> 
> 
> This looks highly questionable. Drivers should be reaching into the core

s/should/shouldn't

Matt

> MM to create primitives.
> 
> I also glanced at the userptr implementation here — it’s quite
> questionable as well, especially regarding whether notifier locking /
> hmm_range_fault interaction is needed on the driver side.
> 
> I’m fairly certain that, with a bit of thought and some extensions to
> DRM GPUSVM, amdxdna could build userptr on that layer (Xe does this
> wihtout SVM). That would isolate core MM interactions to the common DRM
> layer, which I believe the core MM folks would appreciate.
> 
> The biggest issue I see is that get_pages() in GPUSVM also performs a
> DMA map, which amdxdna doesn’t appear to need. That should be easy
> enough to split out. But amdxdna does need locking semantics, notifiers,
> etc., which GPUSVM already provides.
> 
> I’d rather see GPUSVM expanded for the amdxdna use case so future
> drivers can use it as well.
> 
> Happy to work with you on this.
> 
> Matt
> 
> > +	return ret;
> > +}
> > +
> >  struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> >  				 u32 num_entries, void __user *va_entries)
> >  {
> > @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> >  	struct amdxdna_ubuf_priv *ubuf;
> >  	u32 npages, start = 0;
> >  	struct dma_buf *dbuf;
> > +	bool readonly = true;
> >  	int i, ret;
> >  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> >  
> > @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> >  			ret = -EINVAL;
> >  			goto free_ent;
> >  		}
> > +
> > +		/* Pin pages as writable as long as not all entries are read-only. */
> > +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> > +			readonly = false;
> >  	}
> >  
> >  	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> > @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> >  		npages = va_ent[i].len >> PAGE_SHIFT;
> >  
> >  		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> > -					  FOLL_WRITE | FOLL_LONGTERM,
> > +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
> >  					  &ubuf->pages[start]);
> >  		if (ret >= 0) {
> >  			start += ret;
> > @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
> >  
> >  	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
> >  	exp_info.priv = ubuf;
> > -	exp_info.flags = O_RDWR | O_CLOEXEC;
> > +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
> >  
> >  	dbuf = dma_buf_export(&exp_info);
> >  	if (IS_ERR(dbuf)) {
> > -- 
> > 2.34.1
> > 
