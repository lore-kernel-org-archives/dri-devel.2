Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632B606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ac9i+zOW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2141810E0FC;
	Fri,  6 Nov 2026 02:52:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157D310E033;
 Fri,  6 Nov 2026 02:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793933524; x=1825469524;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KPNaIwBJdbV/K194wrp3laOmyBzMH67qOlN9nNPOdF0=;
 b=ac9i+zOWWFxmISW+RhAsD5ldOIAgUYZdugi70V57BMECWY78jG8eZfDV
 roy+ND95V4t/cLLi1lJmpr2wiU4pJsCKzWe8HkMKseq9V5KftOHpcUNXJ
 3Uimrq/ZenohUliSN0vlQemY8zK9TZGVnXA79Knks46MMoXbVA71kt1bY
 BUCpcsC7WChupdN6P2vN5KLuoyEbe6xapt4FFwfJfjTK9dGX3iX6gptsw
 cz+/Uve8yFLgMyGNWEFC32mW1QWKSejYobHvJcC5H2Jq4JKFfd/Wcy6bl
 Dcqonvx3JgvOhW4Q9QAvCm56GNWpukl/5XimG9Lj78Z5yYvH+fhxwlgzV w==;
X-CSE-ConnectionGUID: 0cUgSe1KSk2vFnPbHj36hw==
X-CSE-MsgGUID: UQQSjm48RWKM8YeTwsSqqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2619964"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2619964"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:52:03 -0800
X-CSE-ConnectionGUID: vBr82kReTG2Jgqg4QXCakw==
X-CSE-MsgGUID: SPaK7wDhRhizjaUVrTBw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7048129"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:52:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:52:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:52:03 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS0btwBNtuv/Lq8DuUIRsTLkUkx4llm3OXNNVvVMJLx+kaLwfi7H/RNR9yYrXB9sgj+xFkjJ2CjQjmVFH7uIrD5xhEqc5tfIDBTuZ7qxvf//ARBk8Bcpn9pN9XVVNSVLsv58oEFSTDy4FfvLxZNaUnoxsm3jFM5BeB1JVgnreWD+eOdlYUN9Fd2VsoRZjji6FgtmpMYcm2IXOSYc498393k2Dpmoj+3jo6lp5YvthvDwePQ6hzWasXGmc9oNR30cXfWenriAThv5zTLgLUuqFYWfkVkYexe4v+DKLHx3YnYLoymJGLa6D++nJnoLVAsSKmjlqOHznOciPM6l/iVGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDisY1RYlACYLgJmKLQofqGuS/xwhSR+g4s8ilsaT04=;
 b=iV1aFNmELoxlG9h/gWtI0sTv9wrmsAR+Fmiedz4llUBVhjQiImgpFOgqHJgTxGDYCrQNdMHZdYFzn+bBm+gF+sNltmSlEDiZECWW8JossIRKFiUK/ba9+QNTdQYoLnvXRT0Tf+Kiplbuhft24eNgtsFVzPuuUv1Okr1Mq4UEcvpvCaywlHL/qCzgZcCHc2afUBO0L3/A6UOm8w0o3ccnkVq5tkEeOHZS9JRVBw1Pj+iCeBVd91wGJz2fqGi2WlezHFGARexrKssHBX/z3V33lEsEJkJnDrkpqmnfwovFD1JD6ET9tAXCES8BzLwg59mpVYW+nbQBVqpCvtL3e2CInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DSWPR11MB9584.namprd11.prod.outlook.com (2603:10b6:8:36e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:51:55 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:51:54 +0000
Date: Thu, 5 Nov 2026 18:51:51 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 05/33] drm/ttm: Support defragmentation moves
Message-ID: <au1Ax4zGApeRJF47@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-6-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-6-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DSWPR11MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b97b85f-bfbb-4a8c-7ebc-08df3bb0ea76
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|261026130827099003|11063799006|4143699003|261021123027099003|5023799004|261022115727099003|261009223027099003|261021133027099003|56012099006|261009221227099003|261009220027099003|261009223327099003|261021121427099003|261026135527099003|261009221727099003|261102123227099003|261021135927099003|261022075727099003|261028144727099003|261022113327099003|261026121527099003|261026140227099003|261022105027099003|261021130227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Dqj2ZIFY95YcUD2B8R+H0HdFAAETFVJTz7I9TYyFhUncfdR5dR4oFwElnyWlbwK6moT2JrfUldCT+vSkuCketmzQ9hrb+g5QKuBhLlqB7+rCa/TQCcTlXhjUAKtuw7ti51Ak1uNtS1zeD0BJE2VBwsC3sPy7fzXbNP/9ci/elh6ABxDkW0s/IR4CQV78ckpFPkdVn73LO/oFIJOYepsKuIgMLs+7p6cOW1Nt5l37FgF3yK+FXg0bY6OoF/FDLJKxAC2D+MyEADdoVx0bDgNuu0AgA7Xvjt8MX1vvGFEpzd/mUdUyvVM2zA6FmcNowPZ+npE3lChVESJQyB9YL758RF+cUojwpAXBtqX57Zle0Lxj6TacZOo9QoaiszIByRxiyOsyVyss8vUjRG7pN7nFQzjOC2I5S6cQ7Lin3pYVkHDB5ZtsLthzWREXKRGMlO4P2eTKK5s9i9BW+VSg9PrDiDiSJ/BdlWBnMeD6zhHMe5QNZi5IknNlpjcF3lATGp2+foqgfqdIx95fPqbWPh9v+1IGvZuq1fmdoD3f6554SPJpAkPhmpC3S66HHTTxsHqYGoWxyUB6fpUqZsgvIBm0ZeT2Pbvn1LTSJhPu0H6LAsSpGM/siaZlTyR/9F1Zs2OMSVElNvnKW8X1x6OeeEH6951wLp7kIOCugVPXLLvzCSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(261026130827099003)(11063799006)(4143699003)(261021123027099003)(5023799004)(261022115727099003)(261009223027099003)(261021133027099003)(56012099006)(261009221227099003)(261009220027099003)(261009223327099003)(261021121427099003)(261026135527099003)(261009221727099003)(261102123227099003)(261021135927099003)(261022075727099003)(261028144727099003)(261022113327099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021130227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ujX+T8FxAp6liRMc6J3E3lTn49OZ92YwmveSPguRO8LUn03NIyr3VU4piL?=
 =?iso-8859-1?Q?vNHHAj7/uDt9xMxMKYk1SE4BAdY0WWkIdsqt9nMSZtuRNyetquznh4cipq?=
 =?iso-8859-1?Q?YomBORiJ5/s2oNtCSp5NRCaZXQh2eclYHbBq8rd3YzEa35rIj8XlqmY32I?=
 =?iso-8859-1?Q?/t65YE6aKJVLf5ZfjL93bbxEsLX2lzdtD7tE4VbPthYh5nWzHtwx//IyXp?=
 =?iso-8859-1?Q?tIJKIcpU8ISGKyk1EwQJnINdQlrUdsYn46Sud2iDSEnnGqS46yY6GFSznS?=
 =?iso-8859-1?Q?fImk86AX3As1rpXifMedvkmj+L0Qwy00kepsQFH9iJdsHvfS8cw3REAsrR?=
 =?iso-8859-1?Q?Jx6+Fqht/DPuxZYJFc5pPluYy/dNM1VOYsYLUSX5FQ7/i73emOvgCx6dFp?=
 =?iso-8859-1?Q?iY0rVwQq0z4nOwulkaM+hUftMV+VSMeaik71oPPJnSffmrUwrXQMvBjlHm?=
 =?iso-8859-1?Q?KBi0oNqim3ee8Ti8rLs/xWv1fLzozbKFqIrAV6PomUuwDe29FzhVS8G1dy?=
 =?iso-8859-1?Q?AQIYVLFqFmjRh97rEEXjdk7bucoTST4jM2uYwHXYsNfuuOHTK7X7CHUoNs?=
 =?iso-8859-1?Q?l/A4ZEzc5/BQ8/0AxWPVf+vJSBQ68HDau4xHoVh0x2OnMtHF6SD4bhYtsM?=
 =?iso-8859-1?Q?IyRvbLcdrcAmRunnhcDv761jIuFPpqjApAGfRZje1C16JaQKEGkimwO01O?=
 =?iso-8859-1?Q?oQCzeFCXP/yqwPDtxBUEKLeVT/32fg8LrdVTu+qh0np82vCcxpZ5olZr5Q?=
 =?iso-8859-1?Q?HePySVpyXxsrp+YNYWgHXVQdMDXtGtS+5zjwC2PbsezIVYxSxm8moJNTg/?=
 =?iso-8859-1?Q?/F8bOjvBDk0kaMFb8PEkvNY/KKCICdClqyPgKSBTQVeHQ3BuOfbX9P76ZB?=
 =?iso-8859-1?Q?MD74McH6gtwhNNsh9Uio0fJFy+gE+FupuFuf9qiARpg+M4240M9YH4sgTj?=
 =?iso-8859-1?Q?wcXZ2XsnxaSvnYM+qFyUTZTTMJyimn4nyxY2wR1HQJaORDaTGZBE283CdQ?=
 =?iso-8859-1?Q?P6Hq5jw7Fv3MPBQsL1H59jIRYCFdjGhRRgSjFmug304Y/i5ykEvZ9UcBhk?=
 =?iso-8859-1?Q?nrY3gtU2Z00UODEBrd9Dxe56mOvlScBXVLIzjVU/qeHrM5+S382wZIua0T?=
 =?iso-8859-1?Q?irLet80U8kLZc0gONM8O+MrpmcRFxzgFxUYG5z81m3QLgufooQ1yTTaQBp?=
 =?iso-8859-1?Q?Ny8KnhLwEL57nMF1JzNuE6wLp8UAeHR0LRKBRQk8hT3MbuhzB6y8W2RIw3?=
 =?iso-8859-1?Q?wYkx5qJIOSB9YbXHovpj343bj+wpfEwfEDX1fIi4sGe+BJcM5rkeXpvYH4?=
 =?iso-8859-1?Q?V32eiLPrGtYyPDA4SX4hAIE1ZEv/guWD88024k2TzVWM0RBJCHYyammJwE?=
 =?iso-8859-1?Q?hWhA6XfM0EirtUbT8t+ebRf+4wAEWh/TF/cbiqBfgJh0btfpOpyQTtiU32?=
 =?iso-8859-1?Q?5JJKNLGeX2gqb0Z/KV9zJ8qlvcBwXoJ6bV7ApwPKymseDwW/PMY/xgwWYF?=
 =?iso-8859-1?Q?W4ORcGhD/gG2B1f1WL4y0OgRxf4GEwi6o6vboeKwxU+KaAgxR/tzdbFBVR?=
 =?iso-8859-1?Q?c7qecWZP+XjCLbW1gJN419ygf6S6mjANoH24iXuiWHOdJ4wG8DZ0gr5u8n?=
 =?iso-8859-1?Q?VUs5EOLNL5BBULqvvP31vJHHzL0aKZpUsJ3qxlQHrffj3EcxromMvhfA8L?=
 =?iso-8859-1?Q?5PItxpwxow2dxiPTatlNsNO+O5Aqs2BzdpwfuOEH/A+MunKNShI1ONAMNS?=
 =?iso-8859-1?Q?gidSjWU8tE6UN64QcqG7qJeEFoqmYt2hffkY4hltSR2hFrEYkOPBOj/o2K?=
 =?iso-8859-1?Q?Ee9mZRoKiV86PeJEuh/qCcmM+yFUuY+xW7XJcWF1ZlhgXql0xqQD?=
X-Exchange-RoutingPolicyChecked: vMaFzUVoktjAMXBv6lDyiNopoVVf5gELMRJJvHRx9UK00nXPeAnNB/ibYHHGH5jchupkFpHzUTZs6HnFbXSspHgYjDA4ayPZ+zLiKpX6Xb7Ec94AzVkvm7jh+5VGW0O5AjxPr9FSrTGSpfED42dSREhxLy7tmCqjl2Ff07mBCxJiIWslN9E9M1rRpVAkhsKH0Ctoi1DmWS9PLKag82Vl2vTnDWtIRGuyir7B97Cz1n+QjeoWZt0RE9mP/ghYmM/+Ur1Yk3bgGNZxUduMvlLyPHExhGzC4V4JNEH+N0btVzl+F7op5TpVhXdLAuHo0akXgMLQjBII8pVaoApvTadOlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b97b85f-bfbb-4a8c-7ebc-08df3bb0ea76
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:51:54.6692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlSHboLJWD+RjCq76TaKJWh0wNOcjded97qFPIqaMgFs3eilzC9I2v8wdEZWLhnU1Rl/hXfmdAPnynbOmS0E0HKVFnv2sJgDtxTlOgB4/V2E5/+VQjOXWCEsGJ+eTIIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9584
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:55:51PM -0700, Matthew Brost wrote:
>Add infrastructure to let a driver re-back an already-resident BO with
>fresh pages (e.g. at a more beneficial order) by reusing the normal move
>machinery.
>
>Add ctx->defrag, which makes ttm_bo_validate() skip the "current
>resource already compatible" short-circuit so a move is forced even when
>placement is unchanged. In ttm_bo_handle_move_mem(), when defragging a
>populated BO, stash the old tt, create and populate a fresh one
>(allocating new backing), and hand the old tt to the driver move
>callback via bo->defrag_old_tt for copying. On success the old tt is
>unpopulated and freed; if populate or the move fails, the freshly
>allocated backing is discharged and the BO is restored to its original
>tt and placement.
>
>The old tt is handed off through bo->defrag_old_tt (reservation-lock
>protected) rather than the operation context. The pointer describes BO
>state for the duration of the move, so keeping it on the buffer object
>is better layering and lets ttm_bo_move_accel_cleanup() pick it up.
>
>Because a defrag move commonly fails (beneficial-order pages are often
>unavailable) and then leaves the BO untouched on its original backing,
>defer ttm_bo_unmap_virtual() for the defrag case until the new backing
>has been populated and the move is about to commit. Ordinary moves still
>unmap up front. This avoids needlessly zapping and refaulting every
>userspace mapping on the common failure path where nothing moved.
>
>Teach ttm_bo_move_accel_cleanup()'s ghost path about defrag: instead of
>tearing the move's source tt down synchronously, hand bo->defrag_old_tt
>to the ghost object so it is kept populated until the copy fence signals
>and then unbound and destroyed asynchronously, while the BO keeps its
>new tt. This lets a driver pipeline defrag teardown behind the GPU copy
>rather than blocking on it.
>
>This is driver-opt-in and a no-op unless ctx->defrag is set.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>
>---
>
>v3:
> - Reject defrag moves needing a multihop bounce: WARN, restore backing,
>   -EINVAL (Sashiko)
>---
> drivers/gpu/drm/ttm/ttm_bo.c      | 100 +++++++++++++++++++++++++++---
> drivers/gpu/drm/ttm/ttm_bo_util.c |  16 ++++-
> drivers/gpu/drm/ttm/ttm_pool.c    |   5 +-
> include/drm/ttm/ttm_bo.h          |  17 +++++
> 4 files changed, 127 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>index 3980f376e3ba..c1629b4c4f0f 100644
>--- a/drivers/gpu/drm/ttm/ttm_bo.c
>+++ b/drivers/gpu/drm/ttm/ttm_bo.c
>@@ -125,49 +125,133 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> {
> 	struct ttm_device *bdev = bo->bdev;
> 	bool old_use_tt, new_use_tt;
>+	bool defrag;
> 	int ret;
>
> 	old_use_tt = !bo->resource || ttm_manager_type(bdev, bo->resource->mem_type)->use_tt;
> 	new_use_tt = ttm_manager_type(bdev, mem->mem_type)->use_tt;
>
>-	ttm_bo_unmap_virtual(bo);
>+	/*
>+	 * Only the BO that is the actual defrag target (moved in place via
>+	 * ttm_bo_validate(), evict == false) is being defragmented. The same
>+	 * ctx->defrag is threaded into evictions triggered while allocating
>+	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
>+	 * an unrelated victim BO (evict == true) being misclassified as a
>+	 * defrag move and needlessly reallocating its backing.
>+	 */
>+	defrag = ctx->defrag && !evict && new_use_tt && bo->ttm &&
>+		 ttm_tt_is_populated(bo->ttm);
>+

The sashiko reports a bug about '!evict' check which seems legitimate.

>+	/*
>+	 * Tear down userspace mappings up front for ordinary moves. A defrag
>+	 * move is likely to leave the BO in place (beneficial-order allocation
>+	 * commonly fails), so defer the unmap until the new backing has been
>+	 * populated and the move is about to commit. This avoids a needless
>+	 * zap and refault of every userspace mapping on the common failure,
>+	 * where the BO keeps its original, still-mapped backing.
>+	 */
>+	if (!defrag)
>+		ttm_bo_unmap_virtual(bo);
>
> 	/*
> 	 * Create and bind a ttm if required.
> 	 */
>
> 	if (new_use_tt) {
>+		struct ttm_tt *defrag_old_tt = NULL;
>+
>+		/*
>+		 * For a defrag move, stash the current populated tt and force a
>+		 * fresh one to be created and populated (at beneficial order).
>+		 * The old tt is handed to the driver move callback to copy the
>+		 * contents from, and freed once the move completes.
>+		 */
>+		if (defrag) {
>+			defrag_old_tt = bo->ttm;
>+			bo->ttm = NULL;
>+		}
>+
> 		/* Zero init the new TTM structure if the old location should
> 		 * have used one as well.
> 		 */
>-		ret = ttm_tt_create(bo, old_use_tt);
>-		if (ret)
>+		ret = ttm_tt_create(bo, old_use_tt && !defrag_old_tt);
>+		if (ret) {
>+			if (defrag_old_tt)
>+				bo->ttm = defrag_old_tt;
> 			goto out_err;
>+		}
>
>-		if (mem->mem_type != TTM_PL_SYSTEM) {
>+		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
> 			ret = ttm_bo_populate(bo, ctx);
>-			if (ret)
>+			if (ret) {
>+				/*
>+				 * Discharge the freshly allocated backing and
>+				 * leave the BO on its original tt/placement.
>+				 */
>+				if (defrag_old_tt) {
>+					ttm_tt_destroy(bo->bdev, bo->ttm);
>+					bo->ttm = defrag_old_tt;
>+				}
> 				goto out_err;
>+			}
> 		}
>+
>+		bo->defrag_old_tt = defrag_old_tt;
> 	}
>
> 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
> 	if (ret)
> 		goto out_err;
>
>+	/*
>+	 * A defrag move deferred its virtual unmap until the new backing was
>+	 * successfully populated; tear the userspace mappings down now, before
>+	 * the move swaps in the new pages, so the next fault re-establishes
>+	 * them against the new backing.
>+	 */
>+	if (defrag)
>+		ttm_bo_unmap_virtual(bo);
>+

NIT...would it be good to always do virtual unmap here defrag or not?

> 	ret = bdev->funcs->move(bo, evict, ctx, mem, hop);

Sashiko reports a bug here when ttm_bo_move_memcpy() is used as move()
function. Though xe doesn't use that function, it is perhaps good to
guard against.

> 	if (ret) {
>-		if (ret == -EMULTIHOP)
>+		if (ret == -EMULTIHOP) {
>+			/*
>+			 * A defrag move targets the BO's current placement and
>+			 * must complete in a single hop. A driver requesting a
>+			 * bounce here is unsupported: restore the original
>+			 * backing and fail the defrag rather than retrying the
>+			 * multihop with ctx->defrag still set, which would
>+			 * misclassify the bounce as another defrag move and
>+			 * overwrite/leak bo->defrag_old_tt.
>+			 */
>+			if (unlikely(defrag)) {
>+				WARN_ON_ONCE(1);
>+				ret = -EINVAL;
>+				goto out_err;
>+			}
> 			return ret;
>+		}
> 		goto out_err;
> 	}
>
>+	if (bo->defrag_old_tt) {
>+		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
>+		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
>+		bo->defrag_old_tt = NULL;
>+	}
>+
> 	ctx->bytes_moved += bo->base.size;
> 	return 0;
>
> out_err:
>-	if (!old_use_tt)
>+	if (bo->defrag_old_tt) {
>+		/* Failed defrag move: restore the original backing. */
>+		ttm_bo_tt_destroy(bo);
>+		bo->ttm = bo->defrag_old_tt;
>+		bo->defrag_old_tt = NULL;
>+	} else if (!old_use_tt) {

Another sashiko reported bug about tearing down the old pages while an
async copy is still in progress. Looks like xe driver waits for move to
complete before returning, so should be fine. But probably worth adding
a documentation for defrag_old_tt that "a defrag-aware move callback must
not return an error while a copy into the new backing is still in flight

Niranjana

> 		ttm_bo_tt_destroy(bo);
>+	}
>
> 	return ret;
> }
>@@ -835,7 +919,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
> 	force_space = false;
> 	do {
> 		/* Check whether we need to move buffer. */
>-		if (bo->resource &&
>+		if (bo->resource && !ctx->defrag &&
> 		    ttm_resource_compatible(bo->resource, placement,
> 					    force_space))
> 			return 0;
>diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>index 3e3c201a0222..771313162c8d 100644
>--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>@@ -626,10 +626,22 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> 	 * bo to be unbound and destroyed.
> 	 */
>
>-	if (dst_use_tt)
>+	if (bo->defrag_old_tt) {
>+		/*
>+		 * Defrag move: @bo already points at the freshly allocated,
>+		 * beneficial-order tt that the move copied into. Hand the old
>+		 * tt (the move's source) to the ghost so it is kept populated
>+		 * until @fence signals and then unbound and destroyed, instead
>+		 * of being torn down synchronously. @bo keeps its new tt.
>+		 */
>+		ghost_obj->ttm = bo->defrag_old_tt;
>+		ghost_obj->defrag_old_tt = NULL;
>+		bo->defrag_old_tt = NULL;
>+	} else if (dst_use_tt) {
> 		ghost_obj->ttm = NULL;
>-	else
>+	} else {
> 		bo->ttm = NULL;
>+	}
>
> 	dma_resv_unlock(&ghost_obj->base._resv);
> 	ttm_bo_put(ghost_obj);
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 0ca63f5ce73c..d045105afc24 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -860,8 +860,11 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> 	 * pages. Record it so the driver can later try to defragment the object
> 	 * back to beneficial order.
> 	 */
>-	if (it->beneficial_order && it->order == it->beneficial_order)
>+	if (it->beneficial_order && it->order == it->beneficial_order) {
> 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>+		if (it->ctx->defrag)
>+			return -ENOMEM;
>+	}

NIT...probably good to add a comment here that says something like,
'return error here as the purpose of defragmentation is to get beneficial order'.

>
> 	it->order--;
> 	it->page_caching = it->tt->caching;
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index fd814b5cf535..f4f8a8c29f04 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -135,6 +135,16 @@ struct ttm_buffer_object {
> 	 * reservation lock.
> 	 */
> 	struct sg_table *sg;
>+
>+	/**
>+	 * @defrag_old_tt: Used internally during a defrag move to hand the BO's
>+	 * previous, populated struct ttm_tt to the driver's move callback so
>+	 * that it can copy the contents into the freshly allocated
>+	 * beneficial-order backing. Set by TTM, consumed by the driver; the old
>+	 * tt is freed (or restored on failure) by TTM once the move completes.
>+	 * Protected by the reservation lock.
>+	 */
>+	struct ttm_tt *defrag_old_tt;
> };
>
> #define TTM_BO_MAP_IOMEM_MASK 0x80
>@@ -194,6 +204,13 @@ struct ttm_operation_ctx {
> 	 * reclaim/compaction before falling back to a smaller order anyway.
> 	 */
> 	bool beneficial_reclaim_backoff;
>+	/**
>+	 * @defrag: Defragmentation pass. Attempt a move even when the bo's
>+	 * current resource is already compatible with the requested placement,
>+	 * so that the backing store can be reallocated at the pool's beneficial
>+	 * order.
>+	 */
>+	bool defrag;
> 	/**
> 	 * @resv: Reservation object to be used together with
> 	 * @allow_res_evict.
>-- 
>2.34.1
>
