Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBBC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E72D10E9E9;
	Tue,  8 Sep 2026 05:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b8kEqC2j";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1512310E9E7;
 Tue,  8 Sep 2026 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788844302; x=1820380302;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1tAdUszI4RIuvXrWD01HONIROQgYk9B0hutvAgsauXc=;
 b=b8kEqC2jeOW+45hKv5F+MtKfEVXMjiDDMCXbM+O9EVfbz9nJIBqkEQB8
 RZu7S0+F6xs8bS5HGv5txMqR7+YiLVWO2dG/ufCSTltDqKYlE2a3tjAlS
 /BL98PFFB/ySyDAJPsRa+mH/64giyaB6s+MPSkQk2fkn0r+w2/5OB1Tsu
 5LQEwbTYitKyvGYtFctG50lhhr2qTEyAULP7goMYA3MiLPHVj/CIBOfYE
 JS5RR+sEmNG311VNEoQEYejeE5YmfphomUF7L27WCMQBj+YLhqeg3cwND
 N6721XxcIytpT4IDPvP7UoATHCdQiUadqFfo/Ii0kqKI6a2jptjsGIzSz A==;
X-CSE-ConnectionGUID: ft0svbunSHWECH6WfgXztg==
X-CSE-MsgGUID: 259L0QpAS32zLVdHnqc+IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106607339"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="106607339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 22:11:41 -0700
X-CSE-ConnectionGUID: ddWjuDOdR6KJA0AJvAHuWA==
X-CSE-MsgGUID: f0DJYjLeRySHfNU4qIkbHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264677378"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 22:11:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 22:11:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 22:11:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 22:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvVmiKYNJF5ZKurfO5aWW/BJh+J5GPjB7kV7tMy8zGTWHK0xDTC+JS+RmM92wPUKvu183M6l74XSd/VGmS+r0n9bNpt89Tgp7n03k8LAzrUtFK1u82Pk6aUU10UEh4BuPKAEWmcEDTDZTPmEeltIkDQa4YATNzBB6b3CTW91TMPpppq9Gz6406hy49Ar3gtDS0gIcYu40XRFOT1IIhWYrNvulOmaAKaof9v+W/MPUWalurfraJ1fGvP4ITfdf3gTvWJfUYbyLnHLdwHru3N0E61CVg7GJmd8cg6OCs+4RDKeUg3WJziOrTWU5YdmhZfRqCFYes6qjMStMpL7dfJZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ3Mox0P9SmZHLPdydZ2GGyBqZgSTklx1pOZcCfn8Cg=;
 b=pZrj3ulhT/ANisE9JDosumT5XjtPj2g5NWa18XjFF4utLizb9y1Bym5blvUUJtVJl4euKtYCbi6ghQ8Scd3IZtX8q+fiWWc04eXUo9rHsw6lWHvZmc8uM9fejhJHoaGF/4xcXI44g8VNMTHw/+Ac+m0B3+/tVh1hYhxZ6/Wa5eZ1VYe4N2ufl5gMIuDICslEy8ralyCohOv70hbj5ihHCOiHocNUYUccAidtHOJNG6FulWQ3gGEp4ZSQW65cBaYDP709rxNGP+F3u9RiVKa4oB/5pMAqfDUdqmCC87wY9okHfCFM4s+BGHW1UFTZf5ndeHKNQR2DZyJ8ppBbqJNQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by LV2PR11MB900551.namprd11.prod.outlook.com (2603:10b6:408:424::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 05:11:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 05:11:40 +0000
Date: Mon, 7 Sep 2026 22:11:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v7 3/4] drm/xe: Convert xe_user_fence to drm_user_fence
Message-ID: <ap+ZCSZp4uxmwl7n@gsse-cloud1.jf.intel.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902152049.183685-3-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|LV2PR11MB900551:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd154b9-5027-4357-2885-08df0d67aa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1SV5qkvoDKSKYOS0nB0rlCzV8hBxo7vEyQ6HLplv9GhIUNOqomfrjIaMjEaD86VA5EmJfcT0orES1N772D3gXNcH72WjXtbNqXL8OczzyTX116VMC1zNZWQlrOSdiAhgLSQgQ16HQ8QuzMD0I5OUdaYq5YMdBN/cY6zawsBtIIKw1m3ir86VJ2aLtDbEFoOi39ELa6jniV1xTEkwGlaZM6tPJTzzPQni+PLACflS+WFY1qMdgcxUl0hWR96zP+36DRIq1i5lLPDIFH9pVb/H+3x9X0ffn2wnsJoShDsmdlaEUw3VLb1qegS1XS4+Z4RxsnzZicPJ4Cn1Dn5l84Mgyq6zpZQWcfxNvApuXABEWHfEH5l/tTpOCHhI0Eh6tQa9aZazHZ7/+qCI4V+DmpLW8ApktI2G5Ffe+pDd+ngkj93eMRPVggLszPjW/y8xbp/XbnpFd9Ml4PAd56QTWO17/Ph1/G5sn9p7tkysfq2gvrlIgHB+sBZhRwVkcGIGNAz1OyZwc8YX/aExxD5kI0WeA3ePMXZEfKx+d0E99FFlBV+ZUuwo6OxPD7Bj8zwQekutTjnVfvd3JLPXR8cRNjfooLhk1gvhSnCHxEnYusXz8wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hKSTZrUDRaQlRKNFFMNHF3cU1rNWltYmZvaWN3aTQveUU0VkszcVZaYUtw?=
 =?utf-8?B?Um1GRjVtUFl4UVU3RzBPR2kzdnFjSmpvMGNTeDFVSVVEQ1g3MkFHYytZNmUw?=
 =?utf-8?B?SmozM3MzRENURUpKcU9Zd3hKWEIvZGRTUVN4UjZGQ2lFUlhmWXc3QTVNMTlq?=
 =?utf-8?B?eDk5WkFaaFlwbDhhVHh2MmZpOHExbk9WV3hCNVQzUVRCZTNxT2Rmayt0dUo0?=
 =?utf-8?B?RDNuQzh2ZU9XTGk1M3ZjTnR1U0tLbkRmaDFVT3NDOGNBekxIcVpBRXl3VXRu?=
 =?utf-8?B?czAwQi9uTFV5N0h1NVBJQVZ1Z25wVjdKb2tNcUw1Q1hqdUtaVkhKNkpVczNl?=
 =?utf-8?B?ZGJkNFpSSWpZMzZWSHhIN0MvaGk3OC8xck5QWk9HVHYrNDdmTjJsejE4R0Ni?=
 =?utf-8?B?QXduSHo1MEhZNFVwVlZwSFpueERJU0F1Qys0NWZpbmdxU2FpRHhQdFdINnk2?=
 =?utf-8?B?Z1QxT0tJcGQrTTh2N3F0VFdLMEpLY0t1WStTYW9YN0N3dEtiZkhpc2VldG5w?=
 =?utf-8?B?VUpESTlWRDljLytBUWxCWU9Pa2pJTUJ2T2dGWDFpL3NZTUxWeFR3RFpjam1T?=
 =?utf-8?B?QTc5eklzTzhCVE1TRG9zdy90azBEK2dTZXhVNmNMU3puaDB4NXI2aGhLcC9I?=
 =?utf-8?B?Z3dIbnI3OWpJUDlaNlFzZFMzSi9pQ3JJNEJYT3hFazhsUmNLSTk0cDU5Tnhw?=
 =?utf-8?B?NUwxTWlybHhrbzVVZ2JoNnRWcUl3NklwOW83RW1tTGdqeFJDQXpQUXVWUFVL?=
 =?utf-8?B?SW91R05HQms5aGxRVmRpQ3NIc2Z3d05Nejd1OGdOWHJIUlh5blFqYU5TelYz?=
 =?utf-8?B?MnZWdkgyZnVzY2RwK0JsaVNuVWVJNEkwVHd1N1dZbnZUeGNKRUhoeDRVV0ZK?=
 =?utf-8?B?bVVHSFVybmdVb29QcTJnNDJ3VVB4Q0JLK0FVZTBoekRnNi9Fa0VETHNyb2Ir?=
 =?utf-8?B?N2tBbW80OWphRHNzZnBQVlRndFVRSmJiSzhDajBmenRSQlV5WTA3NWx6OURy?=
 =?utf-8?B?dUp6THdlbkdidWhHWTBFc1g2TEJUZUZYWXdDckd5eVpqVXBqSGF1Y0g3WVZH?=
 =?utf-8?B?RHVhcjBnbFZPMmI0YzZCNHVMcHJramt2MEw5dGNYWndDY3hnTlpuL2JaKzVJ?=
 =?utf-8?B?QjgwUUJMeEphZGtGdCt6VDkyNmpGcUJoNG9uTlpqNmNZVUFhc1JQczBqWmpk?=
 =?utf-8?B?M0EybUFFajhIanJTVUxjc01DNTc0NlgwS1V5dHozZ0FyTkpxRk5CbVFoVnNM?=
 =?utf-8?B?QUFLOVp5TW52dVVTaFNGZlEzQVZpY0tmZ1hha2xyVEl2UlMyckkwdVI5dWdT?=
 =?utf-8?B?QzVxQjVBZldSRmh1SHNBYTlNYzlpS2RNSEpwSkFsSHQ4S1Qyb1hJTTBxUmxm?=
 =?utf-8?B?c1RUZVhreGE0dEhoSUwwaW9LdUFvanRUcHJkOUNEY0ZQd1ptcWs0TDV2SEh0?=
 =?utf-8?B?MzExT05kYUhkczN6UVBxMGJ0OURWSDhhYk9obFV2SkNLb1FvV1JUWERZN2Jw?=
 =?utf-8?B?UVhXV0FCTnp5cHIyMk1OdFgxclJjT2NWQXh3RFhkQW9KL3UzQkR6dzdjSnls?=
 =?utf-8?B?NTNJbEZ1cys3VjJVOEZZTm50MU5uWFl6MithdVo4RyszaVNPYiszN0lvR0lP?=
 =?utf-8?B?eTJ3TCtDa0t0dkM3ZGJHZlppMTU0RHMremJBd0hkbXErc0doQ0JSN2FnSzlp?=
 =?utf-8?B?bzNxWnQ5Zzh2bXJaN1F3dG9xVDc3eC8xbDNQQzdnWWw2cnZOTFBIN0JjVVRo?=
 =?utf-8?B?ZlZFeVdvSmhXdkc1RFRXUUd2QXJmMFV1RW9Nd1lFbUU5THpieXBBS3MrQjlG?=
 =?utf-8?B?Q1BCSGVzRHQxMFFEQ2d1NHVlUGFwR3hxeXY1eVFUMTg0TlZLbTluWnJNMDVQ?=
 =?utf-8?B?OXNza2U3bVlNL0ZWQk50SDhqMEc1YmowVENTOWZQYXFrYXZBN1d3Mk5QYTFL?=
 =?utf-8?B?NVZVaER5YStFZFc2TTZ4UUJjNUVzbzBLcG5Gczd1cFRtQ00rdDM1YWdnM2t3?=
 =?utf-8?B?WmFBZ1pYVXc1UStyZzh3R3lXZ01RTzZaTEh5OUR0T3NERlBCZVFqUGl6TWZa?=
 =?utf-8?B?U2YxZk5OclVXa2JQK0pRdlUvQlBRKzA1S2MvclVZcEpnV0VjckR1VEpWdzZp?=
 =?utf-8?B?b0xNU1ZVOVk2WnZOanR4dVl5VmJITzhDM2kzMjNHUkEzU2sya2NvaE91bEtW?=
 =?utf-8?B?OExoNElhZWFYYmVrQm9ISVF3ZkcvNEtwTmU1ZDJjRG5EOEZTb1B5eGxsWGxs?=
 =?utf-8?B?RHJJbjhWMEpLTUZ2V0dCdHhNeTI5TGNqbUJBQmluNmZBOXlmVTFXZG1OdmVB?=
 =?utf-8?B?bUlUU3BHYUlWNUV2ZDNCOFZLYmZ3UXlyVkFRNnowdGd6VU1pNHUzQWtnUFpo?=
 =?utf-8?Q?g0BK9WPzSYqIjqDw=3D?=
X-Exchange-RoutingPolicyChecked: 4KAVDDUCRa60t9zDurMGLCrxQXlSdrJXKw/ZY6CoxpUkTDQYqcr6jCfOC+0xWNZEgpf7wgInWuD090DWI65ZL4L307muxtTwBUufBJVzoVJOEjKZ1BVeObVa65gfaYKEwQS67WFVb+v9CrQSEPh+ZW4sCo0uyYgcYzh61xQxF8RGakEl0Ljw8Wn3M9lqXCI2bbZqTG7+QcBTclJvNWVgPvzG7MNmFZjxorwOUZP3KpZN7vAVQ3xkzgZq5HHdIagaPvXN6zzz02zXRhRHFklr75b2dRQp+Rvb86DPu3r4q3VVhjjKV2+ISwrv1TDWjw6gRQ1T2tkDoCfmdALWFWNE6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd154b9-5027-4357-2885-08df0d67aa13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:11:40.1344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1fyHYFbSzWoaKpt6wqJ2tcPoRe4/t7vdB19wSmpNPj3REPbgN2kz4Son35rqtCYNuNIMaJFWPHBey8N/THeTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB900551
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

On Wed, Sep 02, 2026 at 08:50:48PM +0530, Srinivasan Shanmugam wrote:
> Replace the open-coded user fence implementation in xe_sync.c with the
> new common drm_user_fence helper.
> 
> struct xe_user_fence now embeds struct drm_user_fence as its base.
> XE-specific fields (xe_device pointer for the ufence_wq wake-up,
> userspace VA, expected value, signalled flag) remain in the wrapper.
> 
> The local user_fence_destroy/get/put/worker/kick_ufence/user_fence_cb
> functions are removed. Their logic moves to xe_ufence_ops.worker and
> xe_ufence_ops.destroy, which are called by the drm_user_fence helper.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/xe/xe_sync.c       | 147 ++++++++++++++++-------------
>  drivers/gpu/drm/xe/xe_sync.h       |   2 +
>  drivers/gpu/drm/xe/xe_sync_types.h |   1 -
>  drivers/gpu/drm/xe/xe_vm.c         |   1 +
>  4 files changed, 82 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c..05f6794af1ee 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -6,12 +6,11 @@
>  #include "xe_sync.h"
>  
>  #include <linux/dma-fence-array.h>
> -#include <linux/kthread.h>
> -#include <linux/sched/mm.h>
>  #include <linux/uaccess.h>
>  
>  #include <drm/drm_print.h>
>  #include <drm/drm_syncobj.h>
> +#include <drm/drm_user_fence.h>
>  #include <uapi/drm/xe_drm.h>
>  
>  #include "xe_device.h"
> @@ -19,36 +18,58 @@
>  #include "xe_macros.h"
>  #include "xe_sched_job_types.h"
>  
> +/*
> + * xe_user_fence wraps drm_user_fence with XE-specific fields.
> + * The drm_user_fence base handles MM borrowing and work-item lifetime.
> + */
>  struct xe_user_fence {
> -	struct xe_device *xe;
> -	struct kref refcount;
> -	struct dma_fence_cb cb;
> -	struct work_struct worker;
> -	struct mm_struct *mm;
> -	u64 __user *addr;
> -	u64 value;
> -	int signalled;
> +	struct drm_user_fence base;
> +	struct xe_device     *xe;
> +	u64 __user           *addr;
> +	u64                   value;
> +	int                   signalled;
>  };
>  
> -static void user_fence_destroy(struct kref *kref)
> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>  {
> -	struct xe_user_fence *ufence = container_of(kref, struct xe_user_fence,
> -						 refcount);
> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
>  
> -	mmdrop(ufence->mm);
> -	kfree(ufence);
> -}
> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
> +			drm_dbg(&ufence->xe->drm,
> +				"copy_to_user failed, user fence wasn't signaled\n");
> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
>  
> -static void user_fence_get(struct xe_user_fence *ufence)
> -{
> -	kref_get(&ufence->refcount);
> +	/*
> +	 * Ensure the fence value write is visible before signalled=1.
> +	 * A UMD polling signalled must see the committed fence value.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Mark signalled after the user memory write so UMD can safely
> +	 * reuse the same ufence without hitting -EBUSY.
> +	 */
> +	WRITE_ONCE(ufence->signalled, 1);

Sashiko [1] is complaining about the order inversion between copy_to_user
and WRITE_ONCE is correct.

See for more details:
git format-patch -1 8ae04fe9ffc93

The order should be WRITE_ONCE, then copy_to_user. Adding the smp_wmb()
before wake_up_all is actually probably right though and could explain a
random CI failure we seeing related to user fences.

Matt

[1] https://sashiko.dev/#/patchset/20260902152049.183685-1-srinivasan.shanmugam%40amd.com

> +
> +	wake_up_all(&ufence->xe->ufence_wq);
>  }
>  
> -static void user_fence_put(struct xe_user_fence *ufence)
> +static void xe_ufence_destroy(struct drm_user_fence *base)
>  {
> -	kref_put(&ufence->refcount, user_fence_destroy);
> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
> +
> +	kfree(ufence);
>  }
>  
> +static const struct drm_user_fence_ops xe_ufence_ops = {
> +	.worker  = xe_ufence_worker,
> +	.destroy = xe_ufence_destroy,
> +};
> +
>  static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  					       u64 value)
>  {
> @@ -63,51 +84,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ufence->xe = xe;
> -	kref_init(&ufence->refcount);
> -	ufence->addr = ptr;
> +	ufence->xe    = xe;
> +	ufence->addr  = ptr;
>  	ufence->value = value;
> -	ufence->mm = current->mm;
> -	mmgrab(ufence->mm);
> +	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);
>  
>  	return ufence;
>  }
>  
> -static void user_fence_worker(struct work_struct *w)
> -{
> -	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
> -
> -	WRITE_ONCE(ufence->signalled, 1);
> -	if (mmget_not_zero(ufence->mm)) {
> -		kthread_use_mm(ufence->mm);
> -		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
> -			XE_WARN_ON("Copy to user failed");
> -		kthread_unuse_mm(ufence->mm);
> -		mmput(ufence->mm);
> -	} else {
> -		drm_dbg(&ufence->xe->drm, "mmget_not_zero() failed, ufence wasn't signaled\n");
> -	}
> -
> -	/*
> -	 * Wake up waiters only after updating the ufence state, allowing the UMD
> -	 * to safely reuse the same ufence without encountering -EBUSY errors.
> -	 */
> -	wake_up_all(&ufence->xe->ufence_wq);
> -	user_fence_put(ufence);
> -}
> -
> -static void kick_ufence(struct xe_user_fence *ufence, struct dma_fence *fence)
> +static void user_fence_get(struct xe_user_fence *ufence)
>  {
> -	INIT_WORK(&ufence->worker, user_fence_worker);
> -	queue_work(ufence->xe->ordered_wq, &ufence->worker);
> -	dma_fence_put(fence);
> +	drm_user_fence_get(&ufence->base);
>  }
>  
> -static void user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> +static void user_fence_put(struct xe_user_fence *ufence)
>  {
> -	struct xe_user_fence *ufence = container_of(cb, struct xe_user_fence, cb);
> -
> -	kick_ufence(ufence, fence);
> +	drm_user_fence_put(&ufence->base);
>  }
>  
>  int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
> @@ -282,24 +274,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
>  	} else if (sync->syncobj) {
>  		drm_syncobj_replace_fence(sync->syncobj, fence);
>  	} else if (sync->ufence) {
> -		int err;
> -
>  		drm_syncobj_add_point(sync->ufence_syncobj,
>  				      sync->ufence_chain_fence,
>  				      fence, sync->ufence_timeline_value);
>  		sync->ufence_chain_fence = NULL;
>  
>  		fence = drm_syncobj_fence_get(sync->ufence_syncobj);
> -		user_fence_get(sync->ufence);
> -		err = dma_fence_add_callback(fence, &sync->ufence->cb,
> -					     user_fence_cb);
> -		if (err == -ENOENT) {
> -			kick_ufence(sync->ufence, fence);
> -		} else if (err) {
> +		if (drm_user_fence_add_callback(&sync->ufence->base, fence))
>  			XE_WARN_ON("failed to add user fence");
> -			user_fence_put(sync->ufence);
> -			dma_fence_put(fence);
> -		}
> +		/* fence ref consumed by drm_user_fence_add_callback */
>  	}
>  }
>  
> @@ -434,6 +417,34 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
>  	user_fence_put(ufence);
>  }
>  
> +/**
> + * xe_sync_ufence_cancel() - Non-blocking cancel of user fence callback
> + * @ufence: user fence reference
> + *
> + * Attempts to cancel the pending callback without waiting for the worker.
> + * Safe to call while holding dma_resv_lock or vm->lock. If the callback
> + * has already fired, the worker runs independently — xe_ufence_worker
> + * only accesses device-level and userspace resources, both safe after
> + * VMA teardown.
> + */
> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence)
> +{
> +	drm_user_fence_cancel(&ufence->base);
> +}
> +
> +/**
> + * xe_sync_ufence_cancel_sync() - Cancel user fence callback and wait for worker
> + * @ufence: user fence reference
> + *
> + * Cancels any pending dma-fence callback and waits for the worker to fully
> + * complete before returning. Must be called during teardown before freeing
> + * any resources accessed by the worker.
> + */
> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence)
> +{
> +	drm_user_fence_cancel_sync(&ufence->base);
> +}
> +
>  /**
>   * xe_sync_ufence_get_status() - Get user fence status
>   * @ufence: user fence
> diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
> index 6b949194acff..b5ff3387c592 100644
> --- a/drivers/gpu/drm/xe/xe_sync.h
> +++ b/drivers/gpu/drm/xe/xe_sync.h
> @@ -44,6 +44,8 @@ static inline bool xe_sync_is_ufence(struct xe_sync_entry *sync)
>  struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
>  struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
>  void xe_sync_ufence_put(struct xe_user_fence *ufence);
> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence);
> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence);
>  int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
>  
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
> index b88f1833e28c..67048199b070 100644
> --- a/drivers/gpu/drm/xe/xe_sync_types.h
> +++ b/drivers/gpu/drm/xe/xe_sync_types.h
> @@ -12,7 +12,6 @@ struct drm_syncobj;
>  struct dma_fence;
>  struct dma_fence_chain;
>  struct drm_xe_sync;
> -struct user_fence;
>  
>  struct xe_sync_entry {
>  	struct drm_syncobj *syncobj;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index b01f31ed4417..fbd2c28de8a6 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1181,6 +1181,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
>  	struct xe_bo *bo = xe_vma_bo(vma);
>  
>  	if (vma->ufence) {
> +		xe_sync_ufence_cancel(vma->ufence);
>  		xe_sync_ufence_put(vma->ufence);
>  		vma->ufence = NULL;
>  	}
> -- 
> 2.34.1
> 
