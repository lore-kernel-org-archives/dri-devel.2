Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C9C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CBE10E296;
	Tue, 21 Jul 2026 06:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JqqhEFOs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD7B10E296;
 Tue, 21 Jul 2026 06:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784614810; x=1816150810;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AnAcUtuvjv+9cBOuxZMSWLhI53nHtmU1ea3JzC6m0U4=;
 b=JqqhEFOsYxIEjmeXO/5zH81e2hJsiEzPsIJSOTCmPJyz0uEFcaEvtzHx
 MmifEcrUf4W0j3dA29A7LMzH7cWcjJYLYtWRUo7npuJ8togeY2Bul/NY2
 3p5Mm/TfywRaY7BEKngas9Q/GGJa9DYs5vr/vOjj/UkPKGhjm/1mPULi3
 2v6kTzFJSxbYgwBYnIle9qvGbbErfGDZSr1x/fR7aIh49V1w5clK97Blk
 VC+mBTTRJulUJhiQNa7jUHb1W0QSAtRDO5D5E1v/v0TOq+xkLTEUMXPmF
 RMniPwP4yAdFcGfB0BoP1N6kTo3llPmBc+fAKwByERC5bS4pvVi+zyGeL g==;
X-CSE-ConnectionGUID: OUs2WfAISqak6Cz8SCNjlQ==
X-CSE-MsgGUID: LqjgYSvFRp2OBKF1dKwH3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96562765"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="96562765"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 23:20:01 -0700
X-CSE-ConnectionGUID: N0gGEf89SYijgLHvmKyxkA==
X-CSE-MsgGUID: EZ+NxJ4+SuakppQ4ZzNtKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="280937380"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 23:20:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 23:20:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 23:20:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 23:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5l046APDj22M6H1zTSYa0gM00sQpFc08aXtQnP6LM/n0V/BFVx1Vdqe5sR4YDYDv/Cqgs0LLSdH8x+OvskWwNeiZa+atHqZGW9AUUdp/Qa/DCtQ/rryb+YVC+w1bytoX7Gg1pBneRfTsoKj5rdyuVydnL6rXqqj1QHeRcWlMoN9dk+URJXMunXkBOAxnD9AUvT2CGWtIQvOua6MVJriP2TVIYNtfFyFIycaFgoBCz2ULROVF6J9KX3dB8T3YtSCr4VH8xPH0GKdegLGnRYrQoEcbNHFNQJ9g74Ex3yTMz6wnZ0ZrSAL/RHgHCIF79aUPtywFOLuyykVuntCO8e7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZJ8UO4ucLV85y7ennY1ai8jHQAsE04BL8tQCOXO/nk=;
 b=BTlLxB/K5bbmDHx7bCfBuk58lil/NNuhBhqtqfx9rRT4PSdEeJvVuQJ5s1uQHJ4Tvvcxu6t9vC0ZIr4om7lCGGyz/+950TQKSvMkOflYOY41krBUW940YMwCCk+tTIPfF9fjwfJrEug61G6UJugtM//bpDUhYJhsswYWK7UInHJCXXSMVYST7o7NzVO7/m9P44jVcDgK0NBw/EMEsLQJEK9BjSbQXZblk7kXmOSq9wxLwwIJJPug24ZiIHCV04iam1l1xCjmqhT8Z0uA5/YAZtnH9ISzOfNOkijLXgEqLc/6El+5Gtgi7WQVtAT4DejU+N6TTAPd49XdjK1/0svcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:19:57 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:19:57 +0000
Message-ID: <8bc79a58-dc96-4774-ac4e-43c683faca69@intel.com>
Date: Tue, 21 Jul 2026 11:49:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/drm_ras: Add drm_ras netlink error event
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-6-riana.tauro@intel.com>
 <al8LkE_elgQCxcXk@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <al8LkE_elgQCxcXk@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|MW4PR11MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b292d3-b5f7-4d40-3bc0-08dee6f01630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aX7eE7k5WGiGsYw4hTDQon1G8EqtlH8AiWXLiDwqxSO+OjI4XTTw6tZdhY2mBFmJuIFAmkPhfOhaUkcPHoTpRNafi9Gj+X2V2hQFCgf5xTIvvdLyumWY5eenUZZZtzYp+l65sBJgEOcsPZY7ryUx/p7suQkaCYQTfnQ6KxrhQ1Dtx7NS2jl4vd5trXtLnoAeVB/7us2GSpZ7liic09qjHqHqFFEEWQWkC67yd8LUw9A7NlfbueocBC2MxlfWMO4ktpTcq0E1PAb81+gHi1GOFYyJ2dKH6l0RxWXcnzNbOzby5rR18FWJufY/PtACDR80XjWKs4PhG7lbu7mrwtOXAnt/MsPDmmdrL8t4wnch2uR9v9FHjoyj49PgPk7Sq6G2ZyjrxTeny3jmfhL5IVYCcd9N1+pN6m40yDeHP4itmfffkJXQJzUW3Yh4QaIm/6cMuJasrJRlvp+lnoKfoG7Wdrc3Dwae1k2vIJzOIB0EQPPCO5UUrCO1gPYdyIhgTG2qsAvTDg511OSLWhTTJY6yP09/qPQE0MemKsMCwgLzSKIFLSJwaE5dW2hWosPbvJtkdhOeQqb+tzkhEF1B3w1QWPL6BRGmS3hoCrsfHFPb5+E4gfnd/PJ2K87K4elncGS46IB+ymLIGnSN3qbTtXLgkkP1y6DePKhJlxNn61lA3FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZhTnJKQVJyWkNvYXE1UTNEY3A0cHRXaXdielV2cXFKYml0ZFQ4MXUxSlVn?=
 =?utf-8?B?ZGVGb1hLN3dsUTBZOWtsWUxUY00rYWRNSnQ2WUlscU9wWTlxZkwvSGc2eHpL?=
 =?utf-8?B?QkpETU9vZUJNZG0vUmlONGtsNVlRM3dUQkRiSGUvcUpiWTJSNXJ1ZWRyUUk3?=
 =?utf-8?B?WUJVYUEyR1VLOXEwT2RHZjcwb2ZYUkRmU28zQXJ4ZVBtMVd5N3ltNTNrZDNk?=
 =?utf-8?B?VnkxR1NxaUFiamFqVDV3TGRvK0pTM3AzR2twSWtGQ3RwNmMrbWNpVlVWTitE?=
 =?utf-8?B?LzhKWlJRUnJuenhwRW9jUFl3TGo5RUZLRjNKN3BtM2NxaG1aTnpuMmFPL2J3?=
 =?utf-8?B?djQrUzE5dkhhbjNORWJLOElmRUhwUDNCcnF5NjBDdndsMVZJVHlVR2U2algr?=
 =?utf-8?B?bnFLYW00NXFYb3pNbDNzZkdsSllvNTV2NmhkS2hNdzYrRy9SSVJzTWtXbEJt?=
 =?utf-8?B?U3p6c2RzV2F2Snltd0M3dTZ4dkQ2RVhtbmlTaU1pR1RQMmExMUZ0WmswakRI?=
 =?utf-8?B?ajM1MWw3MFpFUDUvRDFvNGZZb1NIb2JHbFVMdG4wcFo3U3lkYUVyMjZ1L2Va?=
 =?utf-8?B?cGF2SjJMWHk1VmVteFI2c1dSUnpiU2cyaXdMRWllbDdncUJtN2R6VUp3dVoz?=
 =?utf-8?B?NHBMbHQwNy9JT2duSjlLNDk4VXNpci9TR3ltK3RWSkhrQ1VQbUEvTlZhTEVW?=
 =?utf-8?B?OFFLNkJjcWZRRTlUdmdpN1dCZVVsQVRCWmxEYm16SkJMWFdBTVNPVkM4T0Fo?=
 =?utf-8?B?cXdrMkFjNEgzaWN5amR5bzN1MXdzMkR6T1FFN2twZGM1dVBmRnYrYXNPMFY2?=
 =?utf-8?B?bjJaamZPTmpmMjVPaW9ibkJKbXhoenJCdUFHeWhmYTlweG4yZWdjV1dGK1VW?=
 =?utf-8?B?THFmVDRQT3dld0tpam5HQlVXMUpWZUVhTGRzekdpdVNsQmtNNkllbEVlbHc3?=
 =?utf-8?B?YmVDbnJxd0taK2pMWWp5Qm5iTHltTnFZcksxUkswcjZ2dFZZTVlabXN5anp0?=
 =?utf-8?B?ak9Wcmc3eE1lTHREakd1VDVwWG94MmJ1WndoOFNod0hweno1eXY0UmJoZ2Vv?=
 =?utf-8?B?ZXYwYkNlZVpzSmlFVkYwVTJUUlBRc3BTZUdqeUt2cjVLeksrNldwQjgwdVBS?=
 =?utf-8?B?RlB2SnJjYTBtd0ZGUXd6TW55ekErN2E0WktNRlh5N1hTeHRoVTlvTnNNZ1Nt?=
 =?utf-8?B?dnVjdXlGZVZnU2ZiT3d1Y0tnbTlyeHBnY1l1dFpGZXRKb2RLRzIydDhBa2Jp?=
 =?utf-8?B?b0dFZnpaaExUbUNkanc1ZTFvQThoT2ZDOHVpZTZmdkdDQW5aeVJCak1lNjNh?=
 =?utf-8?B?MlpTdForY2tQT01naW9uMGhKbzZtOWZ4VXVVU29zK3hkTkQ2MlVKN2h3WWt1?=
 =?utf-8?B?V1ByVkRyaEovYkNtc2dTRzc4eVdSU2xwT0hpNGxYMjBTYzlOdUpyelA5Nkwz?=
 =?utf-8?B?ODF3WmVyTnhtYzFQbkgrVUJMbUNXcjBYSFVsNm5ER241WHgwR29YWXBTU3BY?=
 =?utf-8?B?dFpGOFhCQ3FadlptcTNhd3UxdjZWU0x6dkxZOFlPQmFEaVZpTkFsRERZdTYx?=
 =?utf-8?B?MDV6NG1scFVjMmFtQnM5RG5sSVMyWHlYa2hOV3ZiaVovNkpVYmdmM2QvREpK?=
 =?utf-8?B?UmxLd1c2dmREOW5WNmMyNFJsYWxUamhGbks5SEdXU1o1ajgxREIyQnMzQW5h?=
 =?utf-8?B?eldvZ3NXdERCWEF0RXJ6Vm90UzRIeHFwaFFETjZ2UC8zbk9xTGg1Sm9yV0hW?=
 =?utf-8?B?UDhjY1ZBaUdWVDVuWlV0bW15N2dpMkRaL3A0eWFkbkwzQkxyNytVQTRzdXhi?=
 =?utf-8?B?bjRQZS9GcmN4ZWpNSmU5K1A4SUozaXZKZlNyeXNoakRkL0R3OUc1OUJKV1FL?=
 =?utf-8?B?SEFFNm9hYm1CSGRHVVJPRjM3OWhPQWFvak9RZUxlVVJiUVhVMXlDNUo5ZmlX?=
 =?utf-8?B?QzE0bDJhb2FlTmV6d0ozM1lSUkdtQzEzM3g3QU9xQUE3SllJd1BOZlBjUGhN?=
 =?utf-8?B?QXRDYlY5QytNcGdEWi93U1Y5VDBsTmhCYXFyK3RwMUpWL0d1N3M1ajlIbXFj?=
 =?utf-8?B?VlZsWlB5cFpoaWJDM3NqWWNQdjRUZjFINXhGM2dWYjlwazBJV2hweXR4ZERr?=
 =?utf-8?B?VlJnS3IxaWNVZ24zZDltVjdHMW5JWjZCOS9nOGFaSUdNdFpydEZCUkVDQU1O?=
 =?utf-8?B?TjBFeHcvR1JmeWhhNDRYSzRmNlcwZ2xhdEUvYXM4OVQ4VmhPMkxvbmZYWndI?=
 =?utf-8?B?N3RvVXYvM0xCVERzWG1paEtUNWwxYkI1czVudGZVUndxckRPM0FIczErdzJU?=
 =?utf-8?B?dlVVSGI4bG01aEh3RmpBZ2VqTHBxaUUyN21YemEvbmRVa2ZNblZiUT09?=
X-Exchange-RoutingPolicyChecked: gg2ZBXfWklhACPOuG36Rmw8YRFfmF7VWVwafOVLKpQ/7U6rCsr45E/pWcnG05yUbQgdchFyaQO3eWYewY90jRzPlhSrMBshrl3yWsMZg54NQGEQVirulJL7FFgc7RxjKJ2hGr4qq8JMXSPOIGRgtGEJHsIbwEquHxH2HbpW5NGwQoKHl4lca5i4SHjfrHbzLVff9RuxG3s6Nqfc29i8LEJUvTIpgKrUEzxv4kkFm0zHutDvr+ilZB5HSX6rA2Wp4VENpSlgIYwge6e6rThmvmO1NW15mcB+TIwxXrB0mUeAKOXrNFwC7+3LNhFJnccI5uAbx6BBtE0fmGSArBsl1fA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b292d3-b5f7-4d40-3bc0-08dee6f01630
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:19:57.3344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B95QVOFjBkap+QdZLOtUhWbwSXEdIP9HLBby8vhqqyDQXI+z628d50AjJCGJOlwHXYtJcoopJ83i+x9G9DLMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
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


On 21-07-2026 11:32, Raag Jadav wrote:
> On Mon, Jul 20, 2026 at 01:52:10PM +0530, Riana Tauro wrote:
>> Define a new netlink event 'error-event' and a new multicast group
>> 'error-report' in drm_ras. Each event contains device name, node and
>> error information to identify the error triggering the event.
>>
>> Add drm_ras_nl_error_event() to trigger an event from the driver.
>> Userspace must subscribe to 'error-report' to receive 'error-event'
>> notifications.
> ...
>
>> v4: send event to all network namespaces (Sashiko)
>>      remove has_listeners check
> Curious, is it possible to have a has_listeners() that covers all
> namespaces?


We can do this. But this is already done in multicast function. This 
will be a bigger overhead
just to avoid overhead of creating a new message in error path

Thanks
Riana

>
> Raag
