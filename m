Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47C8FDEE48
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A3610E373;
	Thu, 23 Apr 2026 20:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AJOuOCUB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C62C10E373;
 Thu, 23 Apr 2026 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776974584; x=1808510584;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mR5zidtMdk1Ywvr8ph6Q23e6wvhT37OKHten4UO3TDE=;
 b=AJOuOCUByUE/GGpwuArp3AYMNqq5nEiBG2MYpEc68b9iklMyO/RZ8c4s
 JByxiflg3jRCy/V4i3UfmXR7q17MoqUXqE9wclgBAKtv6aDHpmcm3jG/0
 MOY6+B/AaUleWClUInyK+Ed9drI4w7K8NmGVvSvJJVLPLPh1kmRDwoRNu
 JaZSx4n+nuQh6s+L1MtGx7iiA5NVw92w2ACj05ZqOZ1yaUoWku+ROC3+K
 ejxxtICItbVO46g2cVgQqQyn0mzYCFnAUn5jdFXpYdjulZGkGxlR/2yPz
 OoRQ+wH57yxVJDtHUjjk3OBYJ+bTMYir0HJVEkvHgQtyrewYkia8BGrcH Q==;
X-CSE-ConnectionGUID: EsfQG8AEQPCH3JLJnUCSKw==
X-CSE-MsgGUID: UFKIN7J/RCOJm8VFgT2qDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77121310"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="77121310"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 13:03:04 -0700
X-CSE-ConnectionGUID: EaHqKzbtQW+ZBWLXVVhoag==
X-CSE-MsgGUID: Yo05Gj4mSmSAp7eoVlppDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="237104982"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 13:03:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:03:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 13:03:02 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp/CCg1KYm5RbTa0Mtg1byAZfwH7XoLxmtkVP7YuWvC76NtAJjPCMfzHpbO4gn8rDwdG3YGKQavX3dIYTrFgs2g8VC6gkuqZJoBwqx4K4+cpWWsXLbqJmzGW2o/5s3wmZXPBPWd/F3J3uvyIg+PCcIPPeZkq9ryvbrP8jvhtk0acUEpL+G+8WPu+YVNmBB54HhmDHiZvJ6UUjKcbsY17kXPnu509JZ2GSCLmdjGK+X29SMw6mKF7uaNJUe+r3/eTzETJH8YU+A8rR4Np4+xKHqIwrUEZwvLBpV1IPJiCw0euAX05lI33VTqEedR6amO6GR+3nzu9+QsGwuKd5r03nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goy1PSYUfhTN9A/s/UokCuS93CT46O39s5zBL+tDKMc=;
 b=mMfx3CoYDaJzIZpMNFjcMMXLikQWtYWQU2qEziYOSyS1r3EdobiizvgJQU35MxHVCn2SUwKNYOYPhp0/MEGyg53seRJNeBqPJqROhLxCrqreIIEg1Vcs39lbQiD6VJDzIoPzLd+YRKnpjoZ320/vZeyyDYoz/Bb/ZjnicUiCRX8kJCEx1P37DeN3c4ocaavcJkL4bnVtYRtyke/b3aD/lelYWLnvQhpn32c5yUKymkyfAAbMQ7SWaiIFlo30Yk/DIvEOgXMRpvZ6bsXyELhEZUOoTAC3KvyogxtolckBWXYjFT8LHqfGz+bRBVQxUtT3pQAFEpOyNuSqlTF9pHEa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Thu, 23 Apr
 2026 20:02:56 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 20:02:56 +0000
Date: Thu, 23 Apr 2026 13:02:53 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei1" <honghuan@amd.com>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
Message-ID: <aep67Z1YrJBtf+27@gsse-cloud1.jf.intel.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
 <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eed44ba-9907-4fa9-885d-08dea1734fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2M3h5dSyimuw5dJhlXj1yG6YqBeuf7VOsBgsBnBWVIMiYt7NDFMpgth8akN48SZA30x8zUHilcJKVMksEUm/PgHdGwcB5lG/VGEyXu82AIq08TBQehSZsIP5c0gYn5QtpfaJDDOwIBtCby0TA8vv56xOW3L2U0eAC1td3cSTV2d2SnbuG9fUTCiE0s+M8u1h4mrZCE8+TCG/FcivbigkFL59gcsFz7lA6ctfj+4AcQYYbZU07RE5/JlXERyWGM94ZvYMAYihCHe7dudHtZZJrzZ+jH1satbbQQTL3o8eyEhReESW1SAP4K90Fbt6gdEH93Xc16uYdl4wJnPeDuxP/9BuJa2i5C/8JkbzpVZ0SB0IJT26z7UIcJVppRTsPj8vZhGzlfebZGNGnvlsYhbzkIB4NBn3Fd24SnpXjA5QP3sMBkrmanXc18YlBHixJwH7EuyD2Sxpwjq9hyN+Rjy5kCT3BQYJF5XP7UEEGn7JipOrXzNVf6eryUY4KU1bnpR8iNSijWBPXifvp1z5odQSzgoiiwWbvH8OQrNottuQqjiRoyGokqxIGa/xddZuGXj4GKXTNxyiQm9CQLrVJVuKNu5uZGTm294day2ru4yCHPzoomiPUwiy+812S/wMLsxWfyTr7F2VYuv46qYfVKKoE8kImsdmdhGsxk5WaAVo10DCMvXfr1HOQ98CkMeI9sVH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18096099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2PyUlKQAHuPtUK6pqrTBUWs2C6S1lAQhgT5Xq95YnqIDRbzb+lPEqEDomz?=
 =?iso-8859-1?Q?V1WQG8rN7peHcterahIYZnklEJ8rlojtvE/JZWY8OJA5OuzlVu4VaeOWlW?=
 =?iso-8859-1?Q?KbO2iWYK8IEkP0merf6zIZOoK0Slkp3L3b7b6kHFFAw00MXJPsAtOwXKxY?=
 =?iso-8859-1?Q?i+TXS1iSEI8x3XXv6nOCgr6z/KQ+nUfOlEq8rLa0KxvNHOTd3L6DibPT2Y?=
 =?iso-8859-1?Q?eITsSSKm4imxg69Q2yNZE4TI+N4adVpxd4RMH6Jm4W7UkVPK2h+CpHvpoC?=
 =?iso-8859-1?Q?aJNBPbkqqvXbq5A0NkkoHTINkviiCBMNR8f135J4fBO5v+b79kii5D4hi6?=
 =?iso-8859-1?Q?DXZK1PMjo2EoS/9OmBXJOX/04DZjHwAubfQ5MJnKpq/lt5qoZqiHEqgy/P?=
 =?iso-8859-1?Q?nYGdk2+Log6VWSr0I08kIEUVj5ovmWEx403qpPH0K8d2uDIuE7ntcZFKxY?=
 =?iso-8859-1?Q?1UvTtsXwpm8SpZkDOYrhS5Wrwq7qQFPG9rJcCieY/ulMHGwwtYJNTicrgs?=
 =?iso-8859-1?Q?hckxrD52nnCUi4i+QUB1dfn/bCZzzvxBKtJp8jIQqxeMNKGqQy2D/21P3V?=
 =?iso-8859-1?Q?himuV+LbUL+czo5eofA17h7APnbm5ifyx14GSsLcsvXcA2bDyPMYtJ7vOU?=
 =?iso-8859-1?Q?d9Pk7wl36+zl/c/KkxNFL4PHOgOuqmaJqyn1A1QpeYvhSGICIED2+bOkAB?=
 =?iso-8859-1?Q?Zvs1X6kMJkr33yQMZ0mCQFkCVBcNcaJbY5XjZKVskWT6faratnE9iJG8mi?=
 =?iso-8859-1?Q?XcBKLrGWxPNfHk4bWJhqEUZFCIq7+Tr4ZYP6PCvekw0Br4aa8ekilLC/TQ?=
 =?iso-8859-1?Q?J7IInbCtNbPJpDc74CcCREPsye/rx1YJIfXiWBhtPXS6biDFjQoVZRrZY8?=
 =?iso-8859-1?Q?G1I0SaRa+to73dtNnrPgJGrUMRYe1oxIyQRL+G4FRdfbgcIhp7LcvgwQNP?=
 =?iso-8859-1?Q?8MazkZazeKCihk+8fhKfHVhFFNWK9eAtr0eK0jUa1T/9KRP57zhTPhVLEF?=
 =?iso-8859-1?Q?6I4EqpaZnOJq9rjpvHhXRxxfQqH6qKjwbwaaG5erVZbuJvws4it3Q+fMpy?=
 =?iso-8859-1?Q?ql/y3HZ7dGseQOYHgTtM6rEtdUwQyn1iBDyRooVfOaCl/vXPrWXW0r2iPl?=
 =?iso-8859-1?Q?dQ72KH72pEIPC1BKah8kKXvqxN3ubVakSFBLwRTXO1hOhFRRKvR1gU8itK?=
 =?iso-8859-1?Q?qH1aQb+9kC/CB7S+SB5GH9U2GR2WQqx5cnilq5/XC6fOuiWZiI4/Om9B5M?=
 =?iso-8859-1?Q?BFeX8g2tVdV9+0wMFGqoYzZtaKbtmWT0RB/bPDprfWde3fw80+8mRFjR9V?=
 =?iso-8859-1?Q?k46B2qjEYlyQBsGsXJOD4ZrLka3NxQRef/Gq9tbsIckRXcU5BUVqX8LyCE?=
 =?iso-8859-1?Q?pe1MM9kmRQ7HeA0G1zB43OcqaaoDTjsgg2kUtQTnvgCbruE2pW6ERoH8LV?=
 =?iso-8859-1?Q?DwJg7gmtPGttHbIZ/MMXs9DN60AJlnjnWezBZAj3J3B10oJpJ6xzzKgEUl?=
 =?iso-8859-1?Q?9pNlMBDa9PIbrmo+8SAkevpHemtwClTlqs4nfOIwTFoxjRgAMfchqM7bK5?=
 =?iso-8859-1?Q?rPa+VXFFSCz1LBO+39zXDZ17l/og5NnhprkO/nfcW10L0frGSYS1N333Rn?=
 =?iso-8859-1?Q?FtzFCgKNH1kRYFvyHZ9I52RWoAteO9V+PbdLor16FWj6UnamdYkcGEzVNE?=
 =?iso-8859-1?Q?+nKWn4TRzRMMbFBCx8T6XNzwFWazKdnxkYLfeS3emvkCgT0bOEeQO0cXW4?=
 =?iso-8859-1?Q?nJz7yltPmTfc6drdO1wlV766hRXUk8nEQYr4Ewfk7wQ3weWHL3m0zjB2Tn?=
 =?iso-8859-1?Q?xnk/T+Feaw=3D=3D?=
X-Exchange-RoutingPolicyChecked: H/wXZGlAnEHjno3PAR3wqKCdaVm7GIlQGhHH73Wk1IwYCczFjltNBiSYB1aGU6O2hfL2pi/uSNg+brGM0Le3VewWUY/smHiORJrsGz8E3X0ELQZqwYBoajkmlIeKSeAFBSE0px8YLXARXUbfavdfJhkG4E/4x+9CYe0HEsWl/BOrMBqPW/PwV5xneePjTwbv1BUwGSMIez7bVDun6/fgLNPdRbFH7Lm5SkwEipQp/pfqEj2WKJRRu0Cd4ufHDIzzfqjoP6MOuado9d7mHzurfR06wdrkMbi6b2K3YIhihR9TsLBID4eGJP0UrhUUa4wnIOSO/20/pPdAL7TSkriAWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eed44ba-9907-4fa9-885d-08dea1734fba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:02:56.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxadEME5SCH4mfsahVaXBBT4YJU9f/sG/aKeZcz4C+2163zRubBC9Mi+JrU9aBxMzMfw8k0y4e6lsQAhTTFRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
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

On Thu, Apr 23, 2026 at 07:06:43PM +0800, Huang, Honglei1 wrote:
> 
> 
> On 4/23/2026 6:39 PM, Christian König wrote:
> > On 4/23/26 08:21, Huang, Honglei1 wrote:
> > > 
> > > 
> > > On 4/20/2026 11:37 PM, Christian König wrote:
> > > > On 4/20/26 15:30, Huang, Honglei1 wrote:
> > > > > On 4/20/2026 8:15 PM, Christian König wrote:
> > > > > > 
> > > > > > 
> > > > > > On 4/20/26 14:07, Honglei Huang wrote:
> > > > > > > From: Honglei Huang <honghuan@amd.com>
> > > > > > > 
> > > > > > > Add amdgpu drm SVM API definitions built on the
> > > > > > > DRM GPUSVM framework.
> > > > > > > 
> > > > > > > This includes:
> > > > > > > - DRM_AMDGPU_GEM_SVM ioctl
> > > > > > > - AMDGPU_SVM_FLAG_* flags
> > > > > > > - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
> > > > > > > - AMDGPU_SVM_ATTR_* attribute types
> > > > > > > - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
> > > > > > > - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
> > > > > > > 
> > > > > > > Signed-off-by: Honglei Huang <honghuan@amd.com>
> > > > > > > ---
> > > > > > >     include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
> > > > > > >     1 file changed, 39 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > > > > > > index 406a42be4..bed71ed9b 100644
> > > > > > > --- a/include/uapi/drm/amdgpu_drm.h
> > > > > > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > > > > > @@ -58,6 +58,7 @@ extern "C" {
> > > > > > >     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
> > > > > > >     #define DRM_AMDGPU_USERQ_WAIT        0x18
> > > > > > >     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> > > > > > > +#define DRM_AMDGPU_GEM_SVM        0x1a
> > > > > > >       #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> > > > > > >     #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > > > > > > @@ -79,6 +80,7 @@ extern "C" {
> > > > > > >     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> > > > > > >     #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> > > > > > >     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> > > > > > > +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
> > > > > > >       /**
> > > > > > >      * DOC: memory domains
> > > > > > > @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
> > > > > > >         __u64 matrix[12];
> > > > > > >     };
> > > > > > >     +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
> > > > > > > +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
> > > > > > > +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
> > > > > > > +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
> > > > > > > +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
> > > > > > > +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
> > > > > > > +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
> > > > > > > +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
> > > > > > > +
> > > > > > > +#define AMDGPU_SVM_OP_SET_ATTR        0
> > > > > > > +#define AMDGPU_SVM_OP_GET_ATTR        1
> > > > > > > +
> > > > > > > +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
> > > > > > > +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
> > > > > > 
> > > > > > Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
> > > > > > 
> > > > > > > +#define AMDGPU_SVM_ATTR_ACCESS            2
> > > > > > > +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
> > > > > > > +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
> > > > > > 
> > > > > > Why are those separate attributes? What is the difference between those?
> > > > > 
> > > > > Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
> > > > > 
> > > > > So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
> > > > > it can not migrate, GPU only can access it in the initial place.
> > > > 
> > > > Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
> > > > 
> > > > It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
> > > 
> > > Got it so can I change the UAPI to the following format?
> > > 
> > > enum amdgpu_ioctl_svm_attr_type {
> > >      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
> > >      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
> > >      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
> > >      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
> > >      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
> > >      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
> > > };
> > > 
> > > enum amdgpu_ioctl_svm_location {
> > 
> > The enum name could probably be improved, but apart from that looks reasonable to me.
> 
> Will improve the name.
> > 
> > >      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
> > >      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
> > >      AMDGPU_SVM_ACCESS_MIGRATE = 3,
> > > };
> > > 
> > > > 
> > > > > > > +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
> > > > > > > +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
> > > > > > 
> > > > > > Why is that separated into set and clear flags?
> > > > > 
> > > > > This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
> > > > 
> > > > That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
> > > > 
> > > > As far as I can see just a SET_FLAGS should be sufficient.
> > > 
> > > Accoding to the reply form Felix, CLR_FLAGS provides a convenient method for deleting large-scale flags, do we need to redesign this part?
> > 
> > I think we should expose those flags as individual attributes then.
> 
> Got it will do.
> 
> > 
> > > > 
> > > > > > > +#define AMDGPU_SVM_ATTR_GRANULARITY        7
> > > > > > > +
> > > > > > > +#define AMDGPU_SVM_LOCATION_SYSMEM        0
> > > > > > > +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
> > > > > > 
> > > > > > No location for device local memory?
> > > > > 
> > > > > Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
> > > > 
> > > > Absolute clear NAK for that approach. This interface is per FD!
> > > > 
> > > > We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
> > > > 
> > > > We also need to make sure that setting attributes for different devices doesn't affect each other.
> > > 
> > > 
> > > I Totally agreed with your thoughts, but according to the reply from matt, it seems like we need to consider the P2P/multi GPU situation.
> > 
> > When the drm_svm or pagemap component has already code to deal with that then it is probably ok to have the same interface.
> > 
> > When when XE only hacked that together on their own then that is a bit questionable because getting the lifetime right is usually tricky.
> >

The drm_pagemap has a refcount which prevents it from disapearing. The
refcounting is a little tricky but Thomas wrote it down here [1].

A shrinker is wired to drm_pagemap which when refcount is zero the
drm_pagemap can reclaimed (i.e., free all device pages) as this is a
non-trivial amount of memory (1/64 of VRAM size).

If drm_pagemap doesn't exist or has been reclaimed, next use (e.g.,
create a VM on a device, madvise on pagemap on a report device, etc..)
the drm_pagemap will be created. 

[1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/xe/xe_svm.c#L32 
 
> > > 
> > > So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need to modify the UAPI to align with xe_svm?
> > 
> > I think we need to full clarify how XE works here. E.g. that you can specify both 0 as well as give the fd to get the memory migrated to the local device sounds odd.

Yes, the oddity is partly because madvise / multi-gpu landed out of
order and the pushback on exporting drm_pagemaps as FDs. Making
everything FDs is a completely reasonable uAPI IMO. You'd have to have
system memory FD though but that seems possible.

Matt

> 
> Got it, for this part maybe require more discussion and time to fully
> understand, so this part will remain unchanged in the next version.
> 
> Regards,
> Honglei
> 
> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > Regards,
> > > Honglei
> > > 
> > > > 
> > > > Regards,
> > > > Christian.
> > > > 
> > > > > 
> > > > > > 
> > > > > > > +
> > > > > > > +struct drm_amdgpu_svm_attribute {
> > > > > > > +    __u32 type;
> > > > > > > +    __u32 value;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct drm_amdgpu_gem_svm {
> > > > > > > +    __u64 start_addr;
> > > > > > > +    __u64 size;
> > > > > > > +    __u32 operation;
> > > > > > > +    __u32 nattr;
> > > > > > > +    __u64 attrs_ptr;
> > > > > > > +};
> > > > > > 
> > > > > > Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
> > > > > > 
> > > > > > And we usually use unions in this header to separate the input from the output parameters.
> > > > > 
> > > > > Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
> > > > > 
> > > > > Regards,
> > > > > Honglei
> > > > > 
> > > > > > 
> > > > > > Regards,
> > > > > > Christian.
> > > > > > 
> > > > > > > +
> > > > > > >     #if defined(__cplusplus)
> > > > > > >     }
> > > > > > >     #endif
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> 
