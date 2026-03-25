Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E73FEA839
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFDF10E83D;
	Wed, 25 Mar 2026 09:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RSdQW7c5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB6310E836;
 Wed, 25 Mar 2026 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774429740; x=1805965740;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SwavmnmVsIhYzUD4LNC7Y1ZkfxcBsB0q0Vrh9QP+nbY=;
 b=RSdQW7c50sCN7XbvkGNs4LMtf8qZLqpDTP1RFffvDE4sm0ZY3XyDhvh7
 fMo3v43q+dOXJZO7P6wkLR+UyX/eidN2vDw9scrdlJKyA1dWQoElfIRFW
 PicaxlhrTG+SMxrGsJRa2wg+dRNAHxeBANEwyDDU0fH/A5fMlChZa/lwU
 qxYL+PbsW5Drut864jkUw9ngttzFeFPzi0Oi1BDTAAHBxz80bZeL8xJOE
 obeMaXlgIO0YBdtURlbXH4zrIomOmlmSFFBih5c2APlailNIrtpp1Mu6U
 9fHeyWO+0Wh5cF8U0rDMUOw9Vn/tInFSJBmeLNtNmFG6ZfZERPg2baCHl A==;
X-CSE-ConnectionGUID: MuWNunkwQ0GnpWf5ytE4Xg==
X-CSE-MsgGUID: uPRfVwmcS6uVWlLSWDP5Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79368175"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="79368175"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:08:59 -0700
X-CSE-ConnectionGUID: YjZwZeTWSSu/oyniaBRAew==
X-CSE-MsgGUID: kn/tDpZiTBGDSNtQ6gVQiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="229087246"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:08:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:08:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 02:08:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ68A6GWLelSYJGsA6JtL5TY60vnC4CS8tU/4+jJ1Z9LXHp4vpsFObuCaSp6OPGetlsOmz4bZEq6LX/fOnPzzZL05R7YBAgJZYGdSYcyh2P3++RL6OYJoEpoGTZtCBbboCFmhkdHnudtH0LKUHKkbe8dFFi3/xHU+F61pXGm/NTmeVkl3ByxhcbwDq8xMURim/CZ7XXZUJADFgu5DaHfymWcWPIudj0p1B0Q6eyOQg0ZRIj/UYp+13V92rKHAUP0jgnIGSvWiIN4n61c0L7Syhq/OLLEV28KBPfizN8+lEl65SMzEqpUsfkADXW3b/RibwPicdlX/fJOdu8Clq3vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtX3toKr6M+BI/zKGsPaLRT3pHJYXHAibDqQxongg2o=;
 b=PEQgHpzcVn4V89w37cHslXdARx02wgHjd9lj4hB/+1fppq1F8rANBVuw7XYDcK9Eo3A8ii6W1I+ELqGvayDDA8EOpWPjLFbx3j/TzuBdv+KJy7CVwAvWIn4X0YzJPLwzoGDrKC6Z4RBVcjLTR1z8SbXtvoXQZv70N2Cb7SDGC34fPxZQ8P9D30zvoPOP/z2476JWpqNqrrJ+N+Q8sUJNjhBDgx/ftiaXk6BWcJeaeFXXp4u6QJMDFjZFaqQMDOcNnpAZQ45RUVkgLWRTPtBmsL04Eu5rUmFhHhoPKNVj4IbJ+U6eEnFb5Yt1RvSvGoijXuJ4m0B1F9JIVWpOJaZEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:56 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::45f:5907:efdb:cb5b%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:08:55 +0000
Message-ID: <feea29b7-fb28-4ac1-be74-b42c52173c59@intel.com>
Date: Wed, 25 Mar 2026 14:38:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/atomic: track individual colorop updates
Content-Language: en-GB
To: Melissa Wen <mwen@igalia.com>, <airlied@gmail.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <harry.wentland@amd.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <simona@ffwll.ch>, <siqueira@igalia.com>,
 <sunpeng.li@amd.com>, <tzimmermann@suse.de>
CC: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>, "Uma
 Shankar" <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>,
 <amd-gfx@lists.freedesktop.org>, <kernel-dev@igalia.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 "Sean Paul" <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, <linux-arm-msm@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>
References: <20260323131942.494217-1-mwen@igalia.com>
 <20260323131942.494217-2-mwen@igalia.com>
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260323131942.494217-2-mwen@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c0cd56-5247-4165-aecc-08de8a4e2462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|7053199007|921020;
X-Microsoft-Antispam-Message-Info: au+71t/fzSw8ShwvLisqI2TEpVcSPnT0za/SoSleHQTtnOg/vaceQtnUyIy9wpPFt34bt/6eP1dckDhMEderyqqt3KQcrCIiIsCEYi/Oixwf4kJPOu7V8smDIHJA/uxONHPEAsyuuZeoijECoCa61D8NxOfiwnzXny5lkSzb8SBHDEi5+y+ViJap3tmvSGnzwTK+Eit3Gv3sE8SddR2Pew9YzzIdIYKNa1M7U/E4VlScVtrdpNY+FCvhdBVYIRhT8fthZ0Nfvts9mn3jo3VJy+TBDFBPI8HQZHPkS7uPucFuV49n+yV5kbhiVQ6rFHbckqnr6W6kaUP9ahDUaCGVHswzEReXgWoDodZaWApqJ5zdqbGUfAgPe1HviLknAsBazoNsZqrVbPgeeDFkknwe4XY5m/uf/f0t8Rtpfoe0JbomSMnSwUNQ3Q7aa7BbjrM4Ld4Sj/D1w6n0ZMM4OQk46qxCeXhaysMGGJxHIFgL3IPBkKZWX1GOjIx9Do9DUBAsuDs0OoQIdErmnWd2ZVxSy0IBuqN8ovPeKgKg5M0ESTrQ0vtSRwsHYzAMnTCNtPt+y/EDkmzTPZwQlYV2/x7XEg20x9Uh3OWH5bTBXtEuShUGyXemCFYGyMXGyXK7f7Hjg1sP5GzWarw2YtOqhhokEHGSi33qBFqOZ+iYfN2Gi1XDEjB37oJZYqF9WQ1Ty64QLZxMucROIvspTqxjjda0XFfSKBTseX+p296CYA8E4CZJqCpsUJTaXsnlbSG6V1xRUn2wUsoAAAO78Mon0NIDmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6129.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNLdjFGcElqUm1aWDF4V25XV3B4WlFGUldGbFp0T2paSFNGd1dNWWRjQUZt?=
 =?utf-8?B?emw3bzQ3NzRlRWxib0pWTzRnaUdZaUoybllLY2Q2M0lrbVAzVUsyNGVVZDVE?=
 =?utf-8?B?TjI3QlJQNGh4Z25HVWhVSit6MU9jZ0Y1UktVWnBCMVM0N0dqc21WSjZhanZj?=
 =?utf-8?B?ZFhvU0R6dWRDeDhIZnkwWlBGaXVnUVU5ZXE4cGFmRDQ4L2VZb3FGeHU5OEsv?=
 =?utf-8?B?eTUwRGxsRnE1anhXb1R1ZUlndTU5b3NUOERGMXFUOTVSSFVVTk9iU2pFdFgv?=
 =?utf-8?B?QnVxUW0vVUEzdGw0TnJna2dwTkVVcXlWU2pLRW9LdGFKaDUzakR0Yk02Z2FF?=
 =?utf-8?B?NjJza1ZUZGlGc3REZ3F1bTY4SllRSHBqOUpRUUZKWmY3YW1JcndFdWlrekhG?=
 =?utf-8?B?Yng2RHl4OXEzV2kxN2huOHRmQ3Q0ekFvM1p4eHR6WmJIb2F0bktPWWlyYUdy?=
 =?utf-8?B?SFhlOVhSL1RQVGN4YkFITit5U1hiNU9aSnVSODNhWjAzZDJrYU1hTm91aHpM?=
 =?utf-8?B?ajQ2KzV6b0hwc2RvVGdvUkZ0MER6MWFvcXhPRDRiNm9xNlRCS3psbkJsY1dq?=
 =?utf-8?B?dm40M1lOR1o3SythZkZ3dWU0WmY0b1hZdmNZT0JxNFZiRStnMnZzUTNCSkFY?=
 =?utf-8?B?akVnRjlCMmYxSWZBcytPeUp3WjJRVDFJcWE2emhNZVEySVdBU0k0R2VaWEhU?=
 =?utf-8?B?YWFHWDF6bHVMbUY1eXpyL2hJMnJLanBOcmUrL0o3aFFKK0htckRVc1R0bGdo?=
 =?utf-8?B?RHdiRTFsbG5pcS9XK29oMHUzeEhTVHNwWTlLdm1lQ0N6cHp2L3R4Um1WLzEw?=
 =?utf-8?B?RFlxTTNXKzI4bldGS05wSTF5ZmZtMVg3M0JadUVWVkVGNGFXQ3ZiZ2orVGs3?=
 =?utf-8?B?aXpYRW1lL2kvOEt6ckJOaEJ2WFB1WmpMTSsyc2c3cElrTjhCdXFlb0lvSXho?=
 =?utf-8?B?UVNnam9NUnAwWjIwWHJKaHhUM2h1RElYQ1A1WFZHb1E1dURSZGcyMHdiTVBq?=
 =?utf-8?B?Z3daYzJjMGJCRG95aW9KbGRKVXNYT3JZN0UrWjVwdHFnZzRML2JPcHJBOGp5?=
 =?utf-8?B?M29wTlVMUThPYUUwUGR3UVBmUklUNG96KzU1Rk9mNCtxdkJjc0FZTmFSNHJD?=
 =?utf-8?B?N2ZVbVFPT0J0SEFpZW0rSkRrZUdSeW1lOWZoQzQ2ckdJTStMbVcxTkZKdGhu?=
 =?utf-8?B?SDlPck9iL0FIempEbzlZTHk1QjBmRmhzWGZGajNhUmlsbVhTSFB3d0VtTVVm?=
 =?utf-8?B?d1IrN2VlMU9lRU1id0lLUkRXdExNR3Jjdll1OVZEQkozTFlFaEUya0owN2hX?=
 =?utf-8?B?MXdBVkx4cTJEQXRUMXdzT2d3dWVJbGQ2b1BURktrcGFHM0ZoUGoxa0xHZDhw?=
 =?utf-8?B?WHd3VEhRTTd2bFFtRFRTWTVsN3Y3UFJGWC9WWmpDajNGNjNUQ1NnRkZVeWl5?=
 =?utf-8?B?UVlVVFdrVEVSL2txYlRUaDE5aDBIRzRHcHAyOS9IbU1xUnBwZE5WVThwUU1X?=
 =?utf-8?B?cExBSFZNVEdka0xDaFFoWElGRVdQMmtGNU5DOTk5ZC9Nakk1cmVyUS9BVmgr?=
 =?utf-8?B?a0lmN2NBLzlwY2FPMUlRckozRjY1dFY1d2NWMTFpeTVreGM1MEdLVXIxeUN2?=
 =?utf-8?B?aTdIK3d0ekFNSUkxOUhmWXMrTUJ6cnBLZjI5bTIvVkRKZ1h2NkhyVHNiUVZy?=
 =?utf-8?B?a28vaDRtR3M0d2hrd2l1TjI4WDJNSTRtWCsrQ0pqd3JtMWJhcDRGam1TcVJX?=
 =?utf-8?B?YUUxdGw3K3lvcnJaOGFwc0w0N1ZaS3VJdUQzZTd3Tm1oRXNISUdSWWw3Vjlw?=
 =?utf-8?B?c2JreG5qZkE5aWcxamxBRE9UOEpnc1NzWnpxamhzOTNrcTVYR0xMRTdMdVBq?=
 =?utf-8?B?My9SeWhJcHVTVktSL245MzJncXdqL3JmUTVIY3dSeXVUUkNBeE9xQjA3S2FY?=
 =?utf-8?B?NURpWGgyNkRTOHprYmVHOFpaL3JtZkltZEVCa3p5RUN1S1Vkb21oODRxQjNt?=
 =?utf-8?B?RzN6Y2VEbm5vSEZCNTVPSTdIWFlPdnNHNEtEQ3ZoU1NoaHRxS2JhMmErOCtq?=
 =?utf-8?B?SExNclFhZjhZRVM4Ly9MUnhlb1h5TXZ6YVo0U3FLREh1cWFVQ3h2M0FJNnl0?=
 =?utf-8?B?Mm1ORkJEcG1yaFE4R2pmYkpxeXpYRElLb0ErN1lqMndIQmZYYlBNRXNCNVU3?=
 =?utf-8?B?aG1xZVVFQTFyY1Y4WXhXMXhhV2wybi92N3BVWktlcCtYRmFYWnJzNVA1clBz?=
 =?utf-8?B?emNkMVE0Um9BcTYzclhPaDFZMFVJRy9SRUMvRmZFVWQ0VFp3Mll5ZkJVZ2hF?=
 =?utf-8?B?c0ROUWJ0Q21LMEl0L1dwU2k4cng2ZHpNN0F1MEJwbGNXRW9NRTR1SERqL29u?=
 =?utf-8?Q?k2SSqJ166y6EYvQ0=3D?=
X-Exchange-RoutingPolicyChecked: dnegbix3Qo2XKkf/3xzOPAgL+7ZlpV/GM8t1ALGEt/DBVTIR7ocRBRUf5UH5OaLGpGFE+qiIbOTLfA0Yi6t7CebGKl9f9dUFcPZzmxGwqWvTaj8ATZFBZNSZ1bV4TNTonz6WIGgFPtypY3A4SBLA1PbdSkjNNTa1R+ygtQj2EFSAFMnroGPU+2lQ2r1xY+0JS0kaW76h2zVYgcCqhFNybSJdPEQDDzU5s5+lC9BDhbiRBLtm29xpuXCK401H/WFvVVXUC5YAbM+n3jlo9uNP2bQ3/MDxhcaybAsxYzOuerykbgBFtutnpQhZVj70RkCnIATfKghmUhpwqTTDpdaaIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c0cd56-5247-4165-aecc-08de8a4e2462
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:55.9034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYCE6G6hv1Cfvvmv25vVCr/9Sm7aNonjfZJNwoGLWbdbKoOs7BQGhgBj8qdVs069RDv6WbXm9jUv5i8qh6g4kRrJ/8G6gBzlSHOkZlaTofk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
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

Hi Melissa,

On 3/23/2026 6:45 PM, Melissa Wen wrote:
> As we do for CRTC color mgmt properties, use color_mgmt_changed flag to
> track any value changes in the color pipeline of a given plane, so that
> drivers can update color blocks as soon as plane color pipeline or
> individual colorop values change.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com> #v1
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> 
>   v2: add linux types to provide bool for MSM driver (kernel bot)
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 53 ++++++++++++++++++++++++-------
>   include/drm/drm_atomic_uapi.h     |  4 ++-
>   2 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 87de41fb4459..713fa9e81732 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -265,13 +265,19 @@ EXPORT_SYMBOL(drm_atomic_set_fb_for_plane);
>    *
>    * Helper function to select the color pipeline on a plane by setting
>    * it to the first drm_colorop element of the pipeline.
> + *
> + * Return: true if plane color pipeline value changed, false otherwise.
>    */
> -void
> +bool
>   drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>   				 struct drm_colorop *colorop)
>   {
>   	struct drm_plane *plane = plane_state->plane;
>   
> +	/* Color pipeline didn't change */
> +	if (plane_state->color_pipeline == colorop)
> +		return false;
> +
>   	if (colorop)
>   		drm_dbg_atomic(plane->dev,
>   			       "Set [COLOROP:%d] for [PLANE:%d:%s] state %p\n",
> @@ -283,6 +289,8 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>   			       plane->base.id, plane->name, plane_state);
>   
>   	plane_state->color_pipeline = colorop;
> +
> +	return true;
>   }
>   EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
>   
> @@ -600,7 +608,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>   		if (val && !colorop)
>   			return -EACCES;
>   
> -		drm_atomic_set_colorop_for_plane(state, colorop);
> +		state->color_mgmt_changed |= drm_atomic_set_colorop_for_plane(state, colorop);
>   	} else if (property == config->prop_fb_damage_clips) {
>   		ret = drm_property_replace_blob_from_id(dev,
>   					&state->fb_damage_clips,
> @@ -709,11 +717,11 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>   static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
>   					      struct drm_colorop_state *state,
>   					      struct drm_property *property,
> -					      uint64_t val)
> +					      uint64_t val,
> +					      bool *replaced)
>   {
>   	ssize_t elem_size = -1;
>   	ssize_t size = -1;
> -	bool replaced = false;
>   
>   	switch (colorop->type) {
>   	case DRM_COLOROP_1D_LUT:
> @@ -735,28 +743,39 @@ static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
>   						 &state->data,
>   						 val,
>   						 -1, size, elem_size,
> -						 &replaced);
> +						 replaced);
>   }
>   
>   static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   					   struct drm_colorop_state *state,
>   					   struct drm_file *file_priv,
>   					   struct drm_property *property,
> -					   uint64_t val)
> +					   uint64_t val,
> +					   bool *replaced)
>   {
>   	if (property == colorop->bypass_property) {
> -		state->bypass = val;
> +		if (state->bypass != val) {
> +			state->bypass = val;
> +			*replaced = true;
> +		}
>   	} else if (property == colorop->lut1d_interpolation_property) {
>   		colorop->lut1d_interpolation = val;
>   	} else if (property == colorop->curve_1d_type_property) {
> -		state->curve_1d_type = val;
> +		if (state->curve_1d_type != val) {
> +			state->curve_1d_type = val;
> +			*replaced = true;
> +		}
>   	} else if (property == colorop->multiplier_property) {
> -		state->multiplier = val;
> +		if (state->multiplier != val) {
> +			state->multiplier = val;
> +			*replaced = true;
> +		}
>   	} else if (property == colorop->lut3d_interpolation_property) {
>   		colorop->lut3d_interpolation = val;

I think it would be prudent to add this logic for both the 1dlut and 
3dlut interpolation properties. Even though they have just one value 
exposed right now, that might change in future.

>   	} else if (property == colorop->data_property) {
>   		return drm_atomic_color_set_data_property(colorop, state,
> -							  property, val);
> +							  property, val,
> +							  replaced);
>   	} else {
>   		drm_dbg_atomic(colorop->dev,
>   			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -1273,6 +1292,8 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>   	case DRM_MODE_OBJECT_COLOROP: {
>   		struct drm_colorop *colorop = obj_to_colorop(obj);
>   		struct drm_colorop_state *colorop_state;
> +		struct drm_plane_state *plane_state;
> +		bool replaced = false;
>   
>   		colorop_state = drm_atomic_get_colorop_state(state, colorop);
>   		if (IS_ERR(colorop_state)) {
> @@ -1281,7 +1302,17 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>   		}
>   
>   		ret = drm_atomic_colorop_set_property(colorop, colorop_state,
> -						      file_priv, prop, prop_value);
> +						      file_priv, prop, prop_value,
> +						      &replaced);
> +		if (ret || !replaced)
> +			break;
> +
> +		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
> +		if (IS_ERR(plane_state)) {
> +			ret = PTR_ERR(plane_state);
> +			break;
> +		}
> +		plane_state->color_mgmt_changed = true;

I am not sure if it was the intention of the uapi design but as I 
understand there are no guardrails for setting a colorop in an 
"inactive" pipeline.

So, color_mgmt_changed  is set to true even if a colorop from a color 
pipeline that is not currently selected(or set to Bypass) by the 
user-space is changed.
I guess, the driver needs to be intelligent enough to ignore those 
colorop but should we reject it at drm core?

==
Chaitanya

>   		break;
>   	}
>   	default:
> diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
> index 436315523326..4e7e78f711e2 100644
> --- a/include/drm/drm_atomic_uapi.h
> +++ b/include/drm/drm_atomic_uapi.h
> @@ -29,6 +29,8 @@
>   #ifndef DRM_ATOMIC_UAPI_H_
>   #define DRM_ATOMIC_UAPI_H_
>   
> +#include <linux/types.h>
> +
>   struct drm_crtc_state;
>   struct drm_display_mode;
>   struct drm_property_blob;
> @@ -50,7 +52,7 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
>   			      struct drm_crtc *crtc);
>   void drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
>   				 struct drm_framebuffer *fb);
> -void drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
> +bool drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>   				      struct drm_colorop *colorop);
>   int __must_check
>   drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,

