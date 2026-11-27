Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C60606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m3Mwx7ZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9A7112CBE;
	Fri, 27 Nov 2026 17:59:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D7C112C8D;
 Fri, 27 Nov 2026 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802369; x=1827338369;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=zjWzBE+cex37QYjwkABcKxjeP7IrAYxsZijLQ7cV/Gs=;
 b=m3Mwx7ZXicy3mtP6vEh8rEjKRer6siCOx7uPQ1XYSaYdYd15lEkm4COB
 Nl+Ef632Kjv9DTz0iWi77v+WnfvC0xIfLtOlwxWYZ3hoBPUXodItpYBpN
 WdBlMgcBpt9DqRujNy8HXUlhNpNRsE+0+EWVPp+It0d07IFz4B4/0+sUY
 xpd0Ic8sU3pgPeZXhtahOdmfbvTLTq/+pH6Ufdwo9fr6Mg+8N5V7+pkxe
 dl5Xu+v8I5wEMwZ5cH5t3r1HSUXPOWZkhH/lokNP8CJudUvATyWM3kc6B
 syDWkZxzx8f7wlzgoaVgiCfUvf2i0if5cyTj9/EYJB1qIFCHfMX62xQF1 Q==;
X-CSE-ConnectionGUID: zob27Pw/S0ijClIptx8rNw==
X-CSE-MsgGUID: I6Z3JkBwQJKYzOHPQ0ZkDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4717100"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4717100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:29 -0800
X-CSE-ConnectionGUID: baI3HdOeRlqOAWZ7yKJDXQ==
X-CSE-MsgGUID: t3DRdvLNSSaIu7Ujko2tZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12228736"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:28 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MttQopEFHX/yaXPfp7LCllvm/bWknAaIoQL5H6ejprQDsBJC1gf7a698H+suktBhd6LMJoc7GA9fwvYxOtc/UyTtHJzXvFw+C/z+5TVmbwO6HiH9Rn/A6MlPteo2oAWBuR3kDz02cKeVKEmQAHp9Rje8107znccgJFbpp3bH+Smw1gW28LC46KFdnsyvkLik0xMbhb1HWbCizUL0292JVsIx3dXYzjC4ZAJIoE8ZeObPnphShpA9U9eFY5EVjpyPfknwsfLEeG4W78QdPpyH8Z5wOkFAT9K958MSja6efPvKwZ/KjK6AvB8atqLt1j9LyU01TZoBXADPELkHEHoNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO84XDgaPFKuRf66a31zij3jowzC6/i+jndOoOg6wXM=;
 b=f499eBJbGWHSEBc+iqGgO4SaWgPWT9nJqmMYMilv3CUY3gD7kJWN03Cp128riva60zJxo1BuJxDp6VuCI8JuAYKPwZ+ksV1Nk6affAjAwMT/MWKLFyt3A6qSgYoVlqDPUYfQO0NL7CtRGAdVGHqdgpn+GGrA37yAGlloxinv3duYs6mt+Z8ZNg+DVWoboXBPx8ZPmqA78OE3ICZ2Ep+t0VEVdyO6kDl9idR87Mw9e2eR9uFkvrPxKeEPLhFGK8V8f180IwupZsbqynuAtZ4ftK0+U8Q99o1K/z8yAID0L3mhD97urxgi1VT/7emEBpwHZAVJoRqJLU/sBUquIWoSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:25 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:25 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH i-g-t 3/9] drm-uapi/drm_ras: Sync with kernel c95c93b6e26c
Date: Fri, 27 Nov 2026 12:59:14 -0500
Message-ID: <20261127175914.784751-12-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b43450-27c0-45dd-bac1-08df4cb02c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022113327099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: CFv4YUEGkqbjnFgYqN4+O/eU9o3UKnXGqAiITEpuu1NOlk785JNoodUyPa7JLKSpi0y6zdH8Q/7VH0wtFHBIlxkmY/QrbJaCPbIjIJSTwhcuA/ocjo41iIdqACEpjyHuY9nBdv+E1oqetVa6T1HBk4T7MEOooVzLiACFgR3u2fXagk7WMCJtSW+L8NeA+vyH5N4PWojmz1bunvCp9vBAjOKZp5tMPs1BmGMDeAj5hgw9k8YfKWRq/lhs5av4qyvxQff7fMoMZO/uZRN5n59jS5qTx4bOyltQEOl9drEC1KQFq8sAXXTjcGrFGdCKNpDv8+PGukiL92RpOsJzyJkioWODwhaU4F6h1qhW0dPeDCQTbkJ6iOGBRaadDhxZD6on8am5TTu2qpzhWVH56PhyLJi1jKmPQAfAfZm5ehAw8Trpk02iqgI7os8vJDM/iAW61sb+8ROPKj04waeJhIONDPieWbnf3xu7nYmXq2zmgaKGB1FHqL+EfTWX1CFtyepNiHCpiCyKy+YfZ26Jl1vfhx4dUlMvprY1ol4TwU3CQqqt/112kehUILM1jLsvBO21j85n7S1cjy6E0mDHF381S+Hlpy+JtX3H3ktBItTOgdGpNoqIXKFJA9ylOonvrwk+IcFDXFVbtrNkkSCRFED8OszRt3Oz6YooVzVuHhv57X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022113327099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVl1ckVlR215ZDNwMm44NHZFWGlCS0dhc1NTUzdxQ0ZEQkp6bklwWURLb1Bw?=
 =?utf-8?B?RWljeUJkL3BoQ3RycVUvayswN0krYy9PMHprUXFKcjBlSTVNbnR5MW5DdWRj?=
 =?utf-8?B?N1ZmVG5wdGFhY0FEUUZkRmdUQitOUkJqY1pCV1NFUkY0TjVrdVV6SnlLM1Zl?=
 =?utf-8?B?QjFOYUFoM0gzR21TZEl2SlBkY1lVMGY2d2gvRGNXb3NweGZJTmFRNHN0dGxN?=
 =?utf-8?B?MGFXekd0YXZsR2xNTDBkdlZQSGI2WS9Za251elRpVU1HNUp0YzdzSnd3QlZH?=
 =?utf-8?B?YVNSMnBNdUd0cHZIUTVTb3RhSUd5RUFTYURlZHJUUEkrL0pOS0hVVVRkNDlR?=
 =?utf-8?B?ZG5NN2RYV3orQTRCMHdNRHprQWUrcXlkbE5ua2xLQWVyZnJYczJWamVUS3Uw?=
 =?utf-8?B?bzdXZmZ1Rm1DYWMyUU91d3hTZTNZcENhMlhsMHNvVDVQc2hncjViWmZQc2xM?=
 =?utf-8?B?Skp6d2w1MUdXN0JwYlJyQ1MvZVgrRkJBcjRZTzRha3dyWFc1RHBLM0NYMGtX?=
 =?utf-8?B?RXVxSE81cUdoK0w1RXQybVJiSXdwM3d1ak5JQ1NIai90TldPcTBVc3Y0bTRV?=
 =?utf-8?B?VG50MGZmeFhXcmo1M0NuSWNrYXZYVldiaU5RdFB5cDVrK2pwVmVjTjB2VE40?=
 =?utf-8?B?MlBBUnN2N0EwakwvenVsSm1pQktucHJSbCtNK0ljL2t6OUh2L0JSbHFWVk40?=
 =?utf-8?B?Z2ZvS2xIcUR4Tm52MGRGT3NaV0RYUTZ5dll1M2hoZ1RJcVJQbWRRMGgxK1Bq?=
 =?utf-8?B?K0FpT3Bia0krYXBHcnUrZWhQaG94WFRUbkNubUFMZ0h5NGYwa043d0tBOVg0?=
 =?utf-8?B?YkNELzZ0cVk5aUs5bnJlcHRXN0QvVFRXcm1OSlhYR0NjS0pkaCtCbEhaVm4z?=
 =?utf-8?B?SHI3ZzhHTTJKcW9xbVR3ZUtJcm1KbjRxNmVGTStHT3B0Rk8rVS9rOW1hWlNw?=
 =?utf-8?B?THZFNGRRYmJJOGJsQVFQOXowNGRCSlJjK09oN3RhNUsxRkRxajI3dEEveWNx?=
 =?utf-8?B?TGxlQm5zam13eHFRWHlnLytRWEZZcFRFU29hZU1oUWlLZzRCbGpHLy9UWGRn?=
 =?utf-8?B?bmxMTklrUmpVQVZpbjEzajBNS3NsZjJHcE9PVHJHZTJVTW1DRFpJcnFBcTZm?=
 =?utf-8?B?TDA3TDRsd1dUSXVIMjgzRndySnR6SXcwMmw5Ukg2U3Q0Z3VCaU00YmNOTnNX?=
 =?utf-8?B?THRyczI4N3ZYcjgvcklTLzJjK3JpOXRQaFNIVDhNRFNCeGZSWDl6emF3aUZx?=
 =?utf-8?B?c3RLMzN3VmE4ODVuWFF1UmlNZkZwQ29zZW9sOWZReGMxYW9tdy9jNXB0YXFm?=
 =?utf-8?B?d1luNTZLb1RmY2dwOVVDWWtvTHJxL0NEZ1h3L3BKa1FnengwZDZwSUFDTWh2?=
 =?utf-8?B?d09rUmVZQjFRanVrWmwzU05Remw4OHB0UnlvaVMzVE5CYkhqRlNvSExaVnZZ?=
 =?utf-8?B?b3hZUEVsckkyOGh1TGhVd3ZNZUViVlpYa2Vkc1NoYWQ2TlhTVGxDMmRBUFRM?=
 =?utf-8?B?dDhJTHRJZzErdEVmRG56Qm1xN1F0NnpHLzUvcHdGTHArcldjbGhFSlI2TmxU?=
 =?utf-8?B?VDJqc0w4bmF3MDFDTVBFSmg0NldGejBBMFRtMEV5MW5naHhOejRaQlBNbDlu?=
 =?utf-8?B?bWxIdUZpVy92aVZnUUN6Q0hJdy96UFlIckQyZmlqcmxkM25EaFo5dFhHcE8v?=
 =?utf-8?B?OFVVYzJFTUFhZ0lPL0k1MHpJakVRMTcrbUxjV2xoZHpldzZMaFZqbUt6SXpP?=
 =?utf-8?B?dFJaMnlWZ2VYN1ZndHUycWt4dUEzNTYyY0p6NUhGRjNEblZyOVpReGhTTStw?=
 =?utf-8?B?ZkJkU0szTVpLN0VvWWlCTzlHM0V0WjRnbHhJQ1NxR1MvR0VxVFMvYTJIeWNH?=
 =?utf-8?B?NjFYdjFwNzRnQ0F3NGhFeCtuNnNWRzluUGVqcnVwZHJnaFFzYS9WYnJCSkdN?=
 =?utf-8?B?T25mTDROZlFtdjczUDllREZvNGZpOC91Tlk5WlcwZXdwVXZWb1Izc3hlV0pp?=
 =?utf-8?B?N2c3OXlUUEZhZGJGWjJwdENtN0crWHhBdVJEU3Zva2RQYUsyWkc5a01ZWUZT?=
 =?utf-8?B?ZGcxL0VxK3EvVlNBdGhqWExmbjluZzBRNDdqY3pvdC9WY2R4bkl5dVJNMU9F?=
 =?utf-8?B?M0puQnRwUlVYWE5MNXh3aXhiNFdNNU5pb2IzWE5xaVJYR0kvS0ZOcDcycDU4?=
 =?utf-8?B?Q3BXdktCR0NnMjVuTlIzcytyUWJWQ25PckdJaC8xTVVzYVFRdDFGYkdEaGx3?=
 =?utf-8?B?cVVHY3FEMWtCbTAvSyt0Wm01Z1dRNTNUUUJyelNmSlhlQjZhOVNZc3NadENa?=
 =?utf-8?B?TDZHb1ZYK2VJbkxnelRYZFhnTmo5MEVLWHUyVy9iUnZWOFJxby90dz09?=
X-Exchange-RoutingPolicyChecked: SyY9wnA1ndtp+HPvffwRX+qlzEMJ0LI2B3q6VnIbIYbTDP1PckMVR31KBJ2k/KixE3egOQRvIa+Rw4gelKzg9hi3D+8hwT2M70TE/N90gmEkgB5Yte8+4kEG/liBDmZGTnY9cApBSwWDsEJLO09qRa/jaaYaNIt/ePz4k3PenLJTRJBKxcOI6eVhMxZX9YNUizIDNlEZvCJ4OMqX44m4SrF6YJ4sSy3UigBLkzALw8KSTlMgBJuRBY7cGTaim8CDwx2aLw7wBUOJG+OJikOdLbBbmT7Bmie7u+FggB4jJQn9yaw0a13tG5UhrWgN4NMUKpK0/Ivy2qCXB3b11V1jlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b43450-27c0-45dd-bac1-08df4cb02c56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:25.3706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f80JuzeTmNE+fwWYhwCzLYQcqLLLttxG/gwUw9UJACDChlSFpJc7PFWJMFk/6y4WbUCko5h2FssmKgiRbVpSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sync drm_ras uapi up to drm-misc-next commit c95c93b6e26c, this will
bring the following change:

c95c93b6e26c ("drm/drm_ras: Extend DRM RAS interface to include
telemetry nodes")

v3:
 - Generate the header with make headers_install (Zack).

Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 include/drm-uapi/drm_ras.h | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/drm-uapi/drm_ras.h b/include/drm-uapi/drm_ras.h
index 54a4cf2e4..71b342bc5 100644
--- a/include/drm-uapi/drm_ras.h
+++ b/include/drm-uapi/drm_ras.h
@@ -1,7 +1,8 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Copyright © 2026 Intel Corporation
- */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/drm_ras.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _LINUX_DRM_RAS_H
 #define _LINUX_DRM_RAS_H
@@ -10,11 +11,21 @@
 #define DRM_RAS_FAMILY_VERSION	1
 
 /*
- * Type of the node. Currently, only error-counter nodes are supported, which
- * expose reliability counters for a hardware/software component.
+ * Type of the node. The error-counter nodes expose reliability counters for a
+ * hardware/software component, and telemetry nodes expose an interface for
+ * reading and writing telemetry values to a device.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
+	DRM_RAS_NODE_TYPE_TELEMETRY,
+};
+
+/*
+ * Bitmask of access modes supported by a telemetry field.
+ */
+enum drm_ras_telemetry_field_mode {
+	DRM_RAS_TELEMETRY_FIELD_MODE_READ = 1,
+	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
 enum {
@@ -50,6 +61,18 @@ enum {
 	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
+	DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME,
+	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
+	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
+	DRM_RAS_A_TELEMETRY_ATTRS_MODE,
+
+	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
+	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -57,6 +80,9 @@ enum {
 	DRM_RAS_CMD_ERROR_EVENT,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_TELEMETRY_GET,
+	DRM_RAS_CMD_TELEMETRY_SET,
+	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

