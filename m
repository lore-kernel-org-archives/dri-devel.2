Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C221088E49
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 22:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B2210E046;
	Wed, 18 Mar 2026 22:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a68+EMj3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383DC10E031;
 Wed, 18 Mar 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773874246; x=1805410246;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GehU1gN1OmuKUhKMglMSqKrXKgJUvnrWUmPQhWmHa9Q=;
 b=a68+EMj3I+gZz+iHKwruCnm/iS08Gzl6JC01Cxc+oVXLqxh+DQBsCxET
 6xc1LQedmobQbcgj9stcipGNLiizBpaO6Sv2qbumibUGj3LZ+G4uEX9eY
 YiOXI2oq7ZPgH72DE0mWDhSOZTyEcEcJQ1dFimUBMelpGaKXk6HdkaPnT
 Pwc+ok2Gtx0Z5BYNN753IyM0ZpN3bcN/OVMGZUWZaGWy0J3NpRunu8Fot
 5zP4eKlO38a78YoS+y4CPPYmCuEpOqLkzGi98vCZ0Wd1swM4HxXOAwFBh
 HVlxaY8qngJOujW2d5+JIXHwBpUCc/aMHO8xACJa7zquDlSBKA8pOAK0e A==;
X-CSE-ConnectionGUID: ZJA2xP6PTFmg1QZSwhQV3g==
X-CSE-MsgGUID: CtoY4/CvT3Cz778nRMOsXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86421076"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="86421076"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 15:50:44 -0700
X-CSE-ConnectionGUID: h/Fbau9fR4W/ERrNSxWbZQ==
X-CSE-MsgGUID: WLqnk4AURu6vwmXHeeQh2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="221881020"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 15:50:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:50:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 15:50:29 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMMgN2Z3RDLqR7ZGv1YaSft4RIgzVbqPj5A3IrZnvWSyKMMzY7QHvCHT9dD8Q+Mz9i+tYC4ULZ3SB7kauvCfyrPFxFeOvMAuOw28425PQ6ix3Dnis23kU/6aAvVBZTU2PF8plPp6CAYnq56fd84G3BlGI8bREH94+MXwGWFoKMrhSHUwzHPjMNRk0Yw6KVc/IksC3ccM4S+vxzh1+l0ukIrB01K28T3xApkmuEaLpLH+E1lrMLKUMtiMa+q5Wugi6VDuX6XnB9cMG10v5m3yWNwIBsf+Cu4UseegY/6aTvh8lVJPeh1ObdldSqVMRJdI19jMUe33ARmCprU6gybZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5tnuyF1Hqq9QpeK92IHcMiC35EZSAdrw1x++tjt4mU=;
 b=MxWEK+piDFRGt7AocV1BUPmZKhSbdMB1KMvE6pHllvidVg9YA79mvuMtKRP4yU9BUj2vDNIvqPnMJ98ENWKn9Ekfiy67wVntWHMTJhHjniNKCwAN/KR13rwkDMWTQsePHBiKG60UiMcUh+Yrk2Len5xJHsJCZ2qd9gGCjj9cFZF+hih5VOmvatw45Ly+npSexnjijsh4gyBomnLzKO6/DoFKLviVwjYTYq/rjbqUdzXrZWIzgiD24bK1F1pvyXPQs0v2puXiQjQAp4VbxqxDRFIDCOzHVrQ4vEB7rEzdwSV4Pv4/2FGRresyYaR79+2hOMXU1d20xVIotEYTudg15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:50:25 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 22:50:24 +0000
Date: Wed, 18 Mar 2026 15:50:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, Jeffrey Vander Stoep
 <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>, Daniel Stone
 <daniels@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>, John
 Hubbard <jhubbard@nvidia.com>, <shashanks@nvidia.com>, <jajones@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, rust-for-linux <rust-for-linux@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <abssK9Eu5LQAMzC5@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <DH524YJD4UD3.HLHJP0AM401N@kernel.org>
 <974E3052-FCA8-4985-A37D-A1F49C06A77C@collabora.com>
 <DH54QCVVTUZD.3L5VPUW8B38V5@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH54QCVVTUZD.3L5VPUW8B38V5@kernel.org>
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f28275-a63f-411b-dba3-08de8540be0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: KY3y8uknmmH27gnBCbMfgtEXlruFp0au4bzabKsdugYk4GGOYK754RLHCCDvGgqmyMy2b6fjzAfA7jwVvHsWKY74ChKqk53DWVRCSjZ4nrVPI3pEmcsjEMmR8Gbv6esPvvdOq8BLFJ9afF42Tj2gYppYR9eKU+xF0UBaC5Z1HcrAni7e3VdXfbIhhZXqsCQf7PYFUd8ff3iDu+6ap31urXVJu1tfjCJkHkIQlR2gZhkzU+OQNrF9kVA1T9Yp0nf74hv7ByoQZF1rzQgxyl9LeZeJQTHQHI8WZbvtsJuSy7fVkhZytBs7OZNuYEllB1HD9rs6Q/cuFoByAigSKEYmDsKyDw40DxmId0BRjhPkGIjs7goj0+nR/91tGd2ce61DYGIHqztYxghRhaIs8Eb//W56ckC3Fn0DQRe9LKT4LUEMqJkGeTXrJxHXadyoDg9xb968Bx9URtxqjzl7L2HRs9ehwRS2650SSUkOAQy90ndwyGjxnC/zBC3bnYFfbJbZZUjKS3PCTlQLKsB36PZyJoe595q/2++LOaZXppK4E0TWphf4hQrRZdZIMVpa/4Ntjgeq0Q77f51MJxBBi3ghy2sW+G4+F8F68vUsNDbgt3WsxTufrbqv/De7n9PZCjrHlmGgA9P+W0oGjFaV7VNWG1HgqKGDUSg1kiwUUkBPIL9s4Ouim6g08RQ5R5ILQBwj5CIzYQ5He7aVG2QAI6CgVPRPG0nxiwoixO8GVeCyBsnfiDMxnQC755Zx9Hlq97cR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3diZisyZk9veWR4V1NCcTB3UGpGRlM3OHFQTU1rWVhKVzVvMWx2bEJXN2JD?=
 =?utf-8?B?UUN6ak5SUXk5eWtxR3E5R2NzdzJoS2dKUHZRQ09wSDdEWVNnM2VCZjlhYVBK?=
 =?utf-8?B?QkJBQlcwV1RqSWFUY0tUdWIvN2wwWHFVNTF1ZlVMZXVaKzJJZWxGTWRKcmg1?=
 =?utf-8?B?UkhBWkppVDljOXVpMit5c1FOK1NqWXNEaEdnYzJRVkNWQXp2YWtUYmovQVpP?=
 =?utf-8?B?WTZINkFaTk1tTUJLVVgyRnZKT1lNeElJYUJzck5vc1FaWEp5anJ1WEdtd0w3?=
 =?utf-8?B?K0g3SEk3ZDVQdW9nZWsyTWppZ0Q0QnFpMW5DSzZBZjNDRnF1N1JVc01qZkVH?=
 =?utf-8?B?ZG4vQjF1UUp3RlFTSDU0cEsyeUhWVDYwYkM1L2I2eVJ4M1k0TFptL3NzKzFI?=
 =?utf-8?B?T1FINlBDaHJ2bkhnUnQ3dFU0czV3Z0hPSmE2a0VQVFF0NVB3VG9RL2hmbS9p?=
 =?utf-8?B?RGtURXcvK0Nsc1dGeDQ0OFZPakRzdUQxYWVidFgvUzZkYkJzK2RtL24rY1pX?=
 =?utf-8?B?V2VDTzc0Z1lSbTlyQko5OFRtK1hwUVJLQUNaTkM5REVPT0N3T3dvZVZCS2Rt?=
 =?utf-8?B?S25UQk1pclhpMnhSaThSd3BsWGd0VFFVTFkxc08waE1vMk01NXlqdE1HZ1pz?=
 =?utf-8?B?cWRLMHYvZDRyeWtwdGdEYkhNajNXYXpuTVpJb09kN3l3M1R5WGZLT3FBblo3?=
 =?utf-8?B?VktjZEdacW9IQ2pHTkhyUDgvUWJkbjU2Rk9DODc0bFVVS2hlemRUT3NPQkVS?=
 =?utf-8?B?Q1JMZW94aHRUUlRKelhSTVpRM2dNdWQvWDUxVUhjc1IrYjhib05wY2hTbUNO?=
 =?utf-8?B?VkRoUDN1QUJzaU0zWHhnS1p0TWkrbEVUeXRNMEVZbWhRVmZkbmdSMXVtN2J1?=
 =?utf-8?B?N1dNa1FZN1NtOE82NWFxdElUU0NUYWRZSGJmMVR5MC9MMWMyb1NzWlNpY3pF?=
 =?utf-8?B?cHgvLyt0QXNWUmtLWitxUG1WYlFjK2k1UDkrVkFBRlVQd3orVnNIcXJ3d3VL?=
 =?utf-8?B?V0RMM2dYRWFwSkZGbUVvdk5ZNEhYZTNyeG1hc0lNSzg1eWhrcXFlTU9pSld5?=
 =?utf-8?B?N1c0V2VheGNCM2FqUWo2b2pRNGE0cGlvdVNtTUFsaW4vM3VNT2ZIclpmSTRM?=
 =?utf-8?B?Y0plR1dGaERwRk4yVytTMmY0d3pqeUpDYVVkWGROK1V6c0YxS3NUN0RobmN4?=
 =?utf-8?B?bHBITlFGWmhSUXNJcjJYb2tqbHRuSXh2dDA4NnFCNkpoQ1RldVdaTTRVbFBK?=
 =?utf-8?B?TGZyampjOFJiSDFHYlpBeFdLWk84VmFvTTBtckFqeUR5R1VVd0xBOXdBRG5F?=
 =?utf-8?B?OHJadUUxZGVxSmdyYUJWbFlmUHFQQmN4Q3lLcEJBM2hjcnZyMnN4eDFQb3Y5?=
 =?utf-8?B?OGRDa0R1U3QwcFUrSkZrSDFZT201TWlsbEtJUklMNEtwT0ZLeExuc2FpVUNh?=
 =?utf-8?B?Vi9DUWZqWElUR1gxU28rbGJXdXF5a0ZmLzRRTk5DTGZDUXozV2g4bkJrZnl1?=
 =?utf-8?B?TlpyRTB2b3ZmcGJQMkoyL2I0TFFuSjdDSmtIOWtqS2g2eXZaeTBSWXpxYnJR?=
 =?utf-8?B?OXQ3UzgrcklGR2JjcmpNalBZNGtqMmlSMlk2L3lvbmdhRFB5RkFsZjZEVFNQ?=
 =?utf-8?B?UGdkZWM2d05pcGw5c2lzMmhqZWZLQUptY0tSQU9lMEJDYlduRFBrbjN6MGFI?=
 =?utf-8?B?TitDZW1jMTZ3a1lYd3haRlB6VUF6a1V0WjJiTHJIUVBTK2RmUFRmRXN3WUtR?=
 =?utf-8?B?eno3K2RLN0VPSkRPeDJ3NUlCYktpc2dZaC9ISUMrMDc3Z0N4dC9hN3dzeUpC?=
 =?utf-8?B?aE1rcW5jYjVPd0JLeG40L0dhanBzakc1cWRLV25iYVZsRTRlVjE4SzVEN045?=
 =?utf-8?B?bzJQenQ2bHhrdXg1M2EyTi95b2xaV2xPS2pBZW1lYTlnZC9NWTlmNnM4Zk44?=
 =?utf-8?B?NU9tdENZWHJITksxQXNzY2N3K0RhYjlhbHRVTVdKbmErdVZwc3FIamE2eXk1?=
 =?utf-8?B?NkNHVnhScElrZ3E1ZDFKUVZjVWZNcG1qQkpQTGJ2Q2orS1pUYnA4KzE4RHZ4?=
 =?utf-8?B?cDFSdWNMMW4zREtsZkNubHN0aDV1Vnd0RWRreTQwMVJmY1hSTEZjQ1VkMDdN?=
 =?utf-8?B?ZTMzWjVmZGs5K2NiZ1FvMjBjNmp6ZE1kVXdQWkJGYUhZSG84Z1oveWhkTE1t?=
 =?utf-8?B?akU2bjNlQWU1N2paYkNER0hLVmQ4YThzZzJTZ1JWZUVzSEtJNVE4Yk4xU1ox?=
 =?utf-8?B?NGpWUGMwTVkxbWpzbmpDT2taUmpKOXlaSkwwb3RzWTlNb2hNTFVKdjIrWFBQ?=
 =?utf-8?B?MnpTSXU5dVJsNEx3b0ZaME1MZDVQZnFwOEovd0VWcmkxMDdid2J6dz09?=
X-Exchange-RoutingPolicyChecked: dcvQJ+mlcKXuHh4HrfFI/iptA741IsU0GZJJtXpMfNzvjSQvqvB6URb7InTl5BSedV+x4rqAwfmUIsJLH+lOicycS0rafIkD+yltUrE1ktbGyLTWGlrplKJsx0NJwZS6xTZf0jtHDHRla3dsoj8hQDhMnn7su0GV1R20h6AZI8lnrbX20fhiL/b9qB2larV3SKpXOvj6v50k+sN0QA61reQ6702SlbI8djv1avEK/6kRqioR2LjSJ3iZkYbzEgMrzjBy14gdpI6h2g3xRpZVcnncn3b+/oVOGJwTfBbkVN0m0fyhfSwvq48ow3z3h+DIwXC6nF8MXWDn+755GwoXrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f28275-a63f-411b-dba3-08de8540be0d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:50:24.8033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuxUebbllclQXXEcdxLVy5HpbuskRGAMAS5aJKYooCfIjRn/d7S0V0sk6us1+gLpkFdAI3Jqij3FqFDVFSAm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
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

On Tue, Mar 17, 2026 at 03:33:13PM +0100, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 3:25 PM CET, Daniel Almeida wrote:
> >
> >
> >> On 17 Mar 2026, at 09:31, Danilo Krummrich <dakr@kernel.org> wrote:
> >> 
> >> On Tue Mar 17, 2026 at 3:47 AM CET, Daniel Almeida wrote:
> >>> I agree with what Danilo said below, i.e.:  IMHO, with the direction that DRM
> >>> is going, it is much more ergonomic to add a Rust component with a nice C
> >>> interface than doing it the other way around.
> >> 
> >> This is not exactly what I said. I was talking about the maintainance aspects
> >> and that a Rust Jobqueue implementation (for the reasons explained in my initial
> >> reply) is easily justifiable in this aspect, whereas another C implementation,
> >> that does *not* replace the existing DRM scheduler entirely, is much harder to
> >> justify from a maintainance perspective.
> >
> > Ok, I misunderstood your point a bit.
> >
> >> 
> >> I'm also not sure whether a C interface from the Rust side is easy to establish.
> >> We don't want to limit ourselves in terms of language capabilities for this and
> >> passing through all the additional infromation Rust carries in the type system
> >> might not be straight forward.
> >> 
> >> It would be an experiment, and it was one of the ideas behind the Rust Jobqueue
> >> to see how it turns if we try. Always with the fallback of having C
> >> infrastructure as an alternative when it doesn't work out well.
> >
> > From previous experience in doing Rust to C FFI in NVK, I don’t see, at
> > first, why this can’t work. But I agree with you, there may very well be
> > unanticipated things here and this part is indeed an experiment. No argument
> > from me here.
> >
> >> 
> >> Having this said, I don't see an issue with the drm_dep thing going forward if
> >> there is a path to replacing DRM sched entirely.

The only weird case I haven't wrapped my head around quite yet is the
ganged submissions that rely on the scheduled fence (PVR, AMDGPU do
this). Pretty much every other driver seems like it could be coverted
with what I have in place in this series + local work to provide a
hardware scheduler...

> >
> > The issues I pointed out remain. Even if the plan is to have drm_dep + JobQueue
> > (and no drm_sched). I feel that my point of considering doing it in Rust remains.
> 
> I mean, as mentioned below, we should have a Rust Jobqueue as independent
> component. Or are you saying you'd consdider having only a Rust component with a
> C API eventually? If so, that'd be way too early to consider for various
> reasons.
> 

We need to some C story one way or another as we have C drivers and DRM
sched is not cutting it nor is maitainable.

> >> The Rust component should remain independent from this for the reasons mentioned
> >> in [1].
> >> 
> >> [1] https://lore.kernel.org/dri-devel/DH51W6XRQXYX.3M30IRYIWZLFG@kernel.org/

Fair enough. I read through [1], let me respond there.

Matt

> >
> > Ok
> >
> > — Daniel
> 
