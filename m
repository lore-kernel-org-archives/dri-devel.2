Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EE606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UMwLA+Oa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4280B10ED8A;
	Tue, 10 Nov 2026 04:25:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D08210EDA0;
 Tue, 10 Nov 2026 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794284707; x=1825820707;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0hUuLZe2f4PsoYMWiNrkzSV2w/SoW2zKbSOehklcMq0=;
 b=UMwLA+Oa/lblVPHFxv7TSXgaZEMhfwKYqLpB+68eJdryveTSPp2/COgO
 M2wdXRKbzW1NLQ9nXb4cWdkK1JAfXELHh8Nm/gvYxvb/rsK4cJtdrjXMJ
 sCiS62bp01s47vfwxwye+g0lxQMS0TsESbvGcblgZ8yArK2IGK+ktdLq0
 mMBbRh0AU1X8WReQb+3eKJA8OkThxNSZ8BtxDvLahKdcahVDQI7s/6zfo
 DOMIqxaFMZ6K9501oXEUaf8gd9g1YR/5l+fLPAKzsCaFBsLPsKqtKyJoI
 2ww8OVjbU/DMb6EWeOfqMnLfWPP0iapwrsts+t2TYAIXUDNgiQU8oGbF8 g==;
X-CSE-ConnectionGUID: XFisFaBcTvyPYzxK6JSxyw==
X-CSE-MsgGUID: uuzIZ/OyQiCbf5TVmPJy8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2901898"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2901898"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 20:25:06 -0800
X-CSE-ConnectionGUID: I1QbqUs/T/mAuBFLnN9Tmw==
X-CSE-MsgGUID: yzX5KffWRGGeTGbITsWTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7913320"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 20:25:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 20:25:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 20:25:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 20:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=In49pA3QLosLuTrTi/qXkW4cexvAHBaX9ESSDBeme9CHv+CzPEV1Q73oinLvQuej9qeAqYfusmfkLonXhf9O4Um6HPg9oicys1xjkzwh0X03bYgzuqOKG/UmaHrGAzQH+06bVfgKixtqq9x6Ik61L6LrP2Zpt3WYh8mvod1lURN/YmAa5f1dBdQ3RZoQsqN0FSJ++nldXTSZm/fxRfIHDdwwD1pBiLgghGy4wD5U02obtpw0CNE22RclCwUwaEb4UN+bhmo1s220nX2HI0zAGjSNWcuKWBN5zMy46Dm1aZVL3fzxk3g/wn2Utb/xt2BtbodJ8KFNLPOtAioTHfrvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KySfYpPewmyr4iOP6wjyabw0UVkMbg4kGhIiMGli41U=;
 b=xtyRH/k4SASZLI3ViFqClhJkbKgmmUGM7O35vwD89fqUpVb8dvPwbA0X847fVg41Os7foK5Z0KouQxKzGLaDQdFSDVrpy1C775GSu18FBx1+5wa1A400UDSBfZHgGdukhAI+YKa8Cac8yh7nxuho6l6l4mUJn4Zr7tRXUq8LrITzJNzQUKEkDsPGeMv55ApHgtFM6w04NIG5f41J+hORam+3XJZzct26tBOFEhQ1i+ivDergXk2AW/xvjJ6J0sDD32BdHqlH/2lQ6vZ1LokR4yWu3x6gq5AweQG7kW1bg8GQYCvUNJWi0XJ5lbPdSCz0fZ4MIItvjXQp+dax9uqcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 04:25:02 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 04:25:02 +0000
Date: Mon, 9 Nov 2026 20:25:00 -0800
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
Subject: Re: [PATCH v3 19/33] drm/xe: Skip self-copies for borrowed pages on
 defrag moves
Message-ID: <avKcnNcgR_e0mXNN@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-20-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-20-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be06526-ac49-462d-c2da-08df3ee296a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|18002099003|22082099003|3023799007|10067099003|5023799004|261021123027099003|4143699003|11063799006|261028144727099003|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261102123227099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: Hi3lPdwJGK+6fUQL5s2xg9xelLDVATsr2hEGrdMHQqqEDj7bAzJzR8UtKb4D5YbCo1N613s79RmPXrPp089e8teAtLGiR6ahBscYLVM+LITzliezhXE7E2OA/jl/AeAx6MevxP5/FpA98dXguRHAUllsvV7uEBimvOvN5dYTx2YW2BzuFfWpAFdkRYnL6I0QmVPoeXnc3TX3AsFlHBSzLNS10WLzGvcNVKG0IyFYfx9/bmcjYd7MsQsbbfrX03m7DlAfeh5cKIXz50VPQyHe6X/FV1spZi5s59XXuHvqFK/NmBGIGtUfrIpe9Cr6Y+RvcnGopEjsgVUMXnS114UM8EERAcE1zdA7aG9OwTNw3z9wpwpv0jUyFUKTyXCd3OfPnkHgyX+J2zOU2BcHCckGaxiSHpawpqkIzAi0xRC8lrUcs52veh1ANpyAcB/s5fHeiXiVmtIAf7/cBDP7Z4dGT+LDenvr6Zi6hSaIYuiz7lkbDfkuRoLU+c1QBHUUrpEkCl/GU60itLrvAm1SYFyTDTP3LRnV3TYVAfvBc/n0xrl3NO45BlmmFvjzV4Fn3lqaZqg8isgpYaTx9lyEl26PMF3Syiurs0+Mt8O2IX9JR+TCvT7lkfY0EzISANgjWxg2XOphGc79k23KD2Rkl/1v4kuTBkSFeBAPz9QnzwuyIBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(261021123027099003)(4143699003)(11063799006)(261028144727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261102123227099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?168RtIchvU0yMnYLamcLC0GQomsu0htG0CT5mLXyhtk1XLlb7od73pXs3V?=
 =?iso-8859-1?Q?zciLbcm9fFFpvrZqJE6PT6fzxoNapN32ECRVuy7nthiPpQn4JQJatOQG2P?=
 =?iso-8859-1?Q?lDBNkMaULHB7jteBLzG0mezzHJ8gg4m8Tx2JdsoNAU1FZbYwwG2ncoiosP?=
 =?iso-8859-1?Q?/jZyjadZ49N60pfnpv4B6VXDeiOEe2kfK73kxMrrAQ37gkaZKXi1wyCPYB?=
 =?iso-8859-1?Q?ldhATOKkMDeIwnssdSFXDt9CEYQ2LJgz7wcIgO1Dgavql4bU7sWDE8iq6u?=
 =?iso-8859-1?Q?QMmmXEvR7SWjcZApSBtBmkdCRUuqeE3rgzzqtM/gwFnHhS38egN9FiwMVZ?=
 =?iso-8859-1?Q?eF6CUTXuXTRfvw99svHExDN0+Lu6H90aN4I2YbWYHbZoEi6QEJHTO1RSoq?=
 =?iso-8859-1?Q?lqflrH25V+8AENC4Ad/pDIi76qy/i2fXidn58dNaxHDNMuIdhKVTth8RrV?=
 =?iso-8859-1?Q?sVmO7dB2wed7o669/6OyKZQ5y0Wmjh9tISSt0/OoeFhN8ctJiqFKjEgLl4?=
 =?iso-8859-1?Q?U3Zw81v80qzbZj01h77vyCjrMcCvFkz00sQuqHug3+NEvER+XxkLSI60cX?=
 =?iso-8859-1?Q?5+c6O1hY+XDsgCKKlkQzYJ/4JJfDrNXUcMv87bridZyg/3K4kPiHd1vsWB?=
 =?iso-8859-1?Q?hV22H+fYg3koCp5zG+iSXrYbJtzHwLNV9/AJeM1no/I8l/UzWblLMb1e3M?=
 =?iso-8859-1?Q?zlSksP2aQSel2Qrs+iDgvzLSW5ghgXFnqCOvqgGBLlciJCdZuYHs6raVNx?=
 =?iso-8859-1?Q?zfYF3MMWrGBaUeJ9+Hqcc36OwvNYz03pkeUsTwB2NsGMBkQguMRqcW4Mad?=
 =?iso-8859-1?Q?ipanLNsDfGP5q9ZPaDzlHmHorR3afmufoYNDYwEpzKAMgB7ehDMC1Puofv?=
 =?iso-8859-1?Q?+dlCLVmYsuiKj+4JK0il9Ap5Yq/Bswv7UMupSak0GG75gLqurQz1ZIdUEf?=
 =?iso-8859-1?Q?JFZ9KyW//VFA1NGpaByYBEpBoQl77Dpu64SSWlVDlUXQWQPJnMeH+Zs2c5?=
 =?iso-8859-1?Q?bW87xGrsznRxjh2l6I+LGLNQcV9wLj4HMqpHQaYFh/0KREuwyEd8Dste15?=
 =?iso-8859-1?Q?WrMAHuQ81Srh9zDBY6KgfkJ1K9qBG1Sd/zamrhf7VZ188R+0bIP24y/xMs?=
 =?iso-8859-1?Q?Ixv95nOXW1iY2IdBbrCMULSQcwH4TnabhZNd2r9FAKPWwt6ZKxgQ/3aHAJ?=
 =?iso-8859-1?Q?c3ZQsDkoR5qCT5gTLbeIZqoQqY/V044VEATpJj8uYY+lq2/39NFXGoKQ8Z?=
 =?iso-8859-1?Q?0RFWgzyyfFr4SBnaOtsa8lU1PZM26wU3+Vst8K78nf/nlw1Glvg3+T/3uL?=
 =?iso-8859-1?Q?NQ4XGz41qLlYP1Gyzu/mayxeH2qQ3h+D/y0k3XPHB7dtDmGaK9dz246S08?=
 =?iso-8859-1?Q?Vasg+oBWH6aimasZU14o29KuqV2omEiQwfiKOzHWuLQSrD15t7Qs38zi9D?=
 =?iso-8859-1?Q?iECIbetsnBMxXKbDthdpvqjZLmrk1W2uXKQzX5iXWcVIQV3KXtTaHbCTS/?=
 =?iso-8859-1?Q?aI/pHbS2iZcgv6niqb3jLuRFV3OPBC0CNUzSZhgSWNi84L+ybAwXMU5uKJ?=
 =?iso-8859-1?Q?aoq3un8QWoCRrWJGoHPh1JnUfQTZda8WTVmz4l6TlH/cgzJAJvR8hUJz6N?=
 =?iso-8859-1?Q?PMerhcI1nkhr9s5rW3uhXIIyCm3ONoekCuQFVLJh5mcl7ZNZdqvg20kcrd?=
 =?iso-8859-1?Q?EDzvSKjUcRi+vDY0rz/I4CPWvkHMhQx5kqGOyY9rdV6XJCnDbJluTdsZ5z?=
 =?iso-8859-1?Q?NkKEdaXoW84sTML8l2gHqVMqWqgs5yrZMn0f9a5SIib4U6mjC3ofiv6JK2?=
 =?iso-8859-1?Q?eq2aEpM/98Lo+T8Vca6+udZD+TQV9OSFN3rElFrN4Nsf633i45Mf?=
X-Exchange-RoutingPolicyChecked: J8T9sSx81NIIzoBU6Irz2JGqkZNGOWOlvEctKm6sUGWpbmcrXBD6m81EU5l4e7NqDWtmgQWSpHYbaRINECt9MnRV1aVkwu4xdokvxxgltb8aHE765P0sHCqJ2Clz+IJJKxu6Gh+NgQo/NDjOVwUWx+Sfzz9Z0qOnSFYQEojDh32X7umhtEQ1e/YXwlJxaH/dIFEI/yvvran8pVvEzLWc4XiLTfMuSiyZvkU6oZKffdYFaKCIiNvop5u14N47aRSEc4zKTdPsxP7Rltl72nBOeYdzCI4sm0jJz3Oy+/fqkE+Vydw5TStrBX6a4P7sxSVWn6TLpU7kf9msZjo4s0WE8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be06526-ac49-462d-c2da-08df3ee296a8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 04:25:02.3557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+661NeQUxqxv46VqLHxw0UWAqAPe6rxRovrM60u14PJ3jUv/bCESv9U1y4cpxdRKh5aEifQTeMVv5iPvcEzghZcDH4kWUoB5dhU/VB22ebeA9IoVwk/G3Qy8ZplaSpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
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

On Fri, Jul 10, 2026 at 07:56:05PM -0700, Matthew Brost wrote:
>A defrag move may harvest already beneficial-order chunks from the old
>tt, so the freshly reallocated backing borrows (references) some of the
>same physical pages. For those pages the source and destination GPU
>mappings alias the same memory, making the data blit a pointless
>self-copy.
>
>Pass the source (old) tt into __xe_migrate_copy() instead of just its sg
>table, so the data pass can compare the src and dst tt page arrays at the
>matching offset and only blit runs of pages that actually differ. A new
>emit_copy_chunks() helper walks each L0 chunk, skips borrowed-page runs,
>and coalesces contiguous to-copy pages into a single emit_copy(). It runs
>twice per chunk: once with a NULL batch buffer to count the blits for
>batch sizing, then again to emit them.
>
>When an entire L0 chunk turns out to be borrowed, skip it outright: no
>batch buffer is allocated and no GPU commands are issued, the cursors are
>just advanced past the chunk. If every chunk of the move is borrowed the
>copy is a complete no-op, so hand back a signaled stub fence.
>
>The comparison is a cheap per-page pointer test (src page != dst page)
>that coalesces contiguous to-copy pages into a single blit. PTEs are
>still emitted for partially borrowed chunks, since that setup is cheap and
>only the data copies are worth skipping. Only the defrag data pass is
>affected; the separate CCS pass still migrates all aux state.
>
>Since the Xe tt sg lives in the xe_ttm_tt subclass rather than the base
>ttm_tt, add an xe_tt_sg() helper to fetch it from a struct ttm_tt.
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
>----
>
>v3:
> - Fix start_page page-shift and blit pitch for src-natural to
>   dst-packed copies (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c      |  22 +++++-
> drivers/gpu/drm/xe/xe_bo.h      |   2 +
> drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
> drivers/gpu/drm/xe/xe_migrate.h |   3 +-
> 4 files changed, 142 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index bdcc9bed5d36..7f6ee9b8d12e 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -473,6 +473,22 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
> 	return xe_tt->sg;
> }
>
>+/**
>+ * xe_tt_sg() - Return the DMA scatter-gather table backing a ttm_tt.
>+ * @tt: The ttm_tt to query.
>+ *
>+ * Like xe_bo_sg(), but takes the ttm_tt directly. Used by the defrag copy
>+ * path which needs the old (source) tt's sg table without a backing xe_bo.
>+ *
>+ * Return: The sg table, or NULL if the tt is not currently mapped.
>+ */
>+struct sg_table *xe_tt_sg(struct ttm_tt *tt)
>+{
>+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>+
>+	return xe_tt->sg;
>+}

Assisted-by: LLM

xe_tt->sg can be potentially NULL (though probably not in current usecase).
Probably an explicit assert better?

>+
> /*
>  * Account ttm pages against the device shrinker's shrinkable and
>  * purgeable counts.
>@@ -1290,11 +1306,9 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>
> 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
> 	} else if (ttm_bo->defrag_old_tt) {
>-		struct xe_ttm_tt *old_xe_tt =
>-			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
>-
> 		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
>-					       old_xe_tt->sg, handle_system_ccs);
>+					       ttm_bo->defrag_old_tt,
>+					       handle_system_ccs);
> 	} else {
> 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> 					handle_system_ccs);
>diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>index 4186cb51af87..32211016a722 100644
>--- a/drivers/gpu/drm/xe/xe_bo.h
>+++ b/drivers/gpu/drm/xe/xe_bo.h
>@@ -110,6 +110,7 @@ enum xe_madv_purgeable_state {
> };
>
> struct sg_table;
>+struct ttm_tt;
>
> struct xe_bo *xe_bo_alloc(void);
> void xe_bo_free(struct xe_bo *bo);
>@@ -547,6 +548,7 @@ void xe_bo_dev_init(struct xe_bo_dev *bo_device);
> void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
>
> struct sg_table *xe_bo_sg(struct xe_bo *bo);
>+struct sg_table *xe_tt_sg(struct ttm_tt *tt);
>
> /*
>  * xe_sg_segment_size() - Provides upper limit for sg segment size.
>diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
>index 305c6e1942fb..9990a7144a9f 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/xe_migrate.c
>@@ -811,6 +811,63 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
> 		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
> }
>
>+/*
>+ * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, skipping
>+ * borrowed pages.
>+ * @gt: The GT.
>+ * @bb: The batch buffer to emit into, or NULL to only count the blits needed.
>+ * @src_L0_ofs: GPU offset of the source pages mapped for this L0 chunk.
>+ * @dst_L0_ofs: GPU offset of the destination pages mapped for this L0 chunk.
>+ * @src_L0: Byte size of the L0 chunk (page aligned).
>+ * @src_tt: Source (old) tt providing the page pointers.
>+ * @dst_tt: Destination (new) tt providing the page pointers.
>+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
>+ *
>+ * A defragmentation move may harvest already beneficial-order chunks from the
>+ * old tt, so the new tt references (borrows) some of the same physical pages.
>+ * For those pages the source and destination GPU mappings alias the same
>+ * memory and the data blit is a pointless self-copy. Walk the L0 chunk and
>+ * only blit runs of pages that actually differ (src page != dst page),
>+ * coalescing contiguous to-copy pages into a single blit.
>+ *
>+ * Return: The number of blits emitted (or that would be emitted when @bb is
>+ * NULL).
>+ */
>+static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
>+			    u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
>+			    struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
>+			    pgoff_t start_page)
>+{

emit_copy() doesn't have L0 in parameter names. Probably it is worth keeping
it consistent here also?

>+	u32 npages = src_L0 >> PAGE_SHIFT;
>+	u32 i = 0, nblits = 0;
>+
>+	while (i < npages) {
>+		u32 run = 0;
>+
>+		/* Skip a run of borrowed pages (src and dst alias). */
>+		if (src_tt->pages[start_page + i] ==
>+		    dst_tt->pages[start_page + i]) {
>+			i++;
>+			continue;
>+		}
>+
>+		/* Coalesce a run of pages that actually need copying. */
>+		while (i + run < npages &&
>+		       src_tt->pages[start_page + i + run] !=
>+		       dst_tt->pages[start_page + i + run])
>+			run++;
>+
>+		if (bb)
>+			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
>+				  dst_L0_ofs + (u64)i * PAGE_SIZE,
>+				  run * PAGE_SIZE, XE_PAGE_SIZE);
>+		nblits++;
>+		i += run;
>+	}
>+
>+	return nblits;
>+}

Would it be good or possible to have similar counterpart for emit_copy_ccs()?

>+
> static u64 xe_migrate_batch_base(struct xe_migrate *m, bool usm)
> {
> 	return usm ? m->usm_batch_base_ofs : m->batch_base_ofs;
>@@ -865,13 +922,15 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
>  * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
>  * compression PAT index for the data copy.
>  * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
>- * two distinct page sets (old @src_sg pages -> new pages). The data blit is
>+ * two distinct page sets (old @src_tt pages -> new pages). The data blit is
>  * skipped (the data was copied by the @defrag_copy pass) and both the source
>  * and destination data pages are mapped with the compression PAT so the aux
>  * state is copied indirect -> indirect.
>  * @defrag_copy: Defrag move pass that copies the data pages between two
>- * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
>- * aux state. The data pages are mapped without the compression PAT so the
>+ * distinct page sets (old @src_tt pages -> new pages) without touching the CCS
>+ * aux state. Pages the new tt borrowed from @src_tt (harvested already
>+ * beneficial-order chunks) alias the same memory on both sides and are skipped.
>+ * The data pages are mapped without the compression PAT so the
>  * (possibly compressed) bytes are copied verbatim rather than being
>  * decompressed and recompressed, and no CCS aux copy is appended; the aux
>  * state is migrated separately by the @defrag_ccs pass. The two passes need
>@@ -889,7 +948,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 					   struct xe_bo *dst_bo,
> 					   struct ttm_resource *src,
> 					   struct ttm_resource *dst,
>-					   struct sg_table *src_sg,
>+					   struct ttm_tt *src_tt,
> 					   struct xe_migrate_copy_flags flags)
> {
> 	struct xe_gt *gt = m->tile->primary_gt;
>@@ -914,6 +973,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		!flags.defrag_copy;
> 	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
> 		!flags.defrag_ccs && !flags.defrag_copy;
>+	/*
>+	 * On the defrag data pass the new (destination) tt may have borrowed
>+	 * already beneficial-order pages from the old (source) tt, so skip the
>+	 * self-copy for any page they share. Compare the tt page arrays at the
>+	 * matching offset.
>+	 */
>+	struct ttm_tt *dst_tt = dst_bo->ttm.ttm;
>+	bool skip_borrowed = flags.defrag_copy && src_tt && dst_tt;

I think for our case src_tt and and dst_tt check is redundant here as they will
always be set for defrag_copy. May be add an assert instead of checking?

Niranjana

>
> 	/*
> 	 * For decompression operation, always use the compression PAT index.
>@@ -926,7 +993,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>
> 	/*
> 	 * The defrag CCS pass migrates the aux state from the old pages
>-	 * (@src_sg) to the new pages with both sides accessed indirectly, so
>+	 * (@src_tt) to the new pages with both sides accessed indirectly, so
> 	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
> 	 */
>
>@@ -938,7 +1005,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		return ERR_PTR(-EINVAL);
>
> 	if (!src_is_vram)
>-		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
>+		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo), 0, size, &src_it);
> 	else
> 		xe_res_first(src, 0, size, &src_it);
> 	if (!dst_is_vram)
>@@ -947,7 +1014,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		xe_res_first(dst, 0, size, &dst_it);
>
> 	if (copy_system_ccs)
>-		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
>+		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo),
> 				xe_bo_ccs_pages_start(src_bo),
> 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> 				&ccs_it);
>@@ -961,6 +1028,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		u64 ccs_ofs, ccs_size;
> 		u32 ccs_pt;
> 		u32 pte_flags;
>+		pgoff_t start_page = (xe_bo_size(src_bo) - size) >> PAGE_SHIFT;
>+		u32 ndata_blits = 1;
>
> 		bool usm = xe->info.has_usm;
> 		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
>@@ -998,9 +1067,30 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 			xe_assert(xe, IS_ALIGNED(ccs_it.start, PAGE_SIZE));
> 		}
>
>-		/* Add copy commands size here */
>+		/*
>+		 * Add copy commands size here. On the defrag data pass the blit
>+		 * is split into one command per run of non-borrowed pages, so
>+		 * size for the number of runs actually needed.
>+		 */
>+		if (skip_borrowed)
>+			ndata_blits = emit_copy_chunks(gt, NULL, 0, 0, src_L0,
>+						       src_tt, dst_tt, start_page);
>+
>+		/*
>+		 * If every page in this chunk was borrowed there is nothing to
>+		 * copy: don't build a batch or issue any GPU commands, just
>+		 * advance the cursors past the chunk. The non-vram tt cursors
>+		 * would otherwise be advanced by emit_pte().
>+		 */
>+		if (skip_borrowed && !ndata_blits) {
>+			xe_res_next(&src_it, src_L0);
>+			xe_res_next(&dst_it, src_L0);
>+			size -= src_L0;
>+			continue;
>+		}
>+
> 		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
>-			       emit_copy_cmd_len(xe)) +
>+			       ndata_blits * emit_copy_cmd_len(xe)) +
> 			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>
> 		bb = xe_bb_new(gt, batch_size, usm);
>@@ -1029,7 +1119,10 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
> 		update_idx = bb->len;
>
>-		if (!flags.copy_only_ccs && !flags.defrag_ccs)
>+		if (skip_borrowed)
>+			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
>+					 src_tt, dst_tt, start_page);
>+		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
> 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
>
> 		if (needs_ccs_emit)
>@@ -1088,6 +1181,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> 		return ERR_PTR(err);
> 	}
>
>+	/*
>+	 * Every chunk of a defrag data pass may have been borrowed (nothing
>+	 * copied), leaving no job and a NULL fence. Hand back a signaled stub
>+	 * so callers always get a valid fence to wait on.
>+	 */
>+	if (!fence)
>+		return dma_fence_get_stub();
>+
> 	return fence;
> }
>
>@@ -1129,18 +1230,21 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
>  * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
>  * @src: The source TTM resource (the old backing).
>  * @dst: The dst TTM resource (the freshly reallocated backing).
>- * @src_sg: Scatter-gather table of the source (old) backing pages.
>+ * @src_tt: The source (old) backing tt, providing both the scatter-gather
>+ * table and page pointers of the old pages.
>  * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
>  *
>  * Used by the defrag path where a single BO has its backing reallocated at a
>  * more beneficial page order. The contents are relocated from the old pages
>- * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
>+ * (@src_tt) to the new pages (the BO's current backing) entirely on the GPU,
>  * in up to two passes:
>  *
>  *  - Data pass (always): copy the data pages verbatim. The pages are mapped
>  *    without the compression PAT, so the (possibly compressed) bytes are copied
>  *    as-is rather than being decompressed and recompressed, and no CCS aux copy
>- *    is appended.
>+ *    is appended. Pages the new backing borrowed from @src_tt (harvested
>+ *    already beneficial-order chunks) alias the same memory on both sides and
>+ *    are skipped.
>  *
>  *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
>  *    and new data pages are mapped with the compression PAT so the copy engine
>@@ -1159,11 +1263,11 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 struct xe_bo *bo,
> 					 struct ttm_resource *src,
> 					 struct ttm_resource *dst,
>-					 struct sg_table *src_sg,
>+					 struct ttm_tt *src_tt,
> 					 bool need_ccs)
> {
> 	struct dma_fence *fence2, *fence =
>-		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
>+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt,
> 				  (struct xe_migrate_copy_flags) {
> 					 .defrag_copy = true,
> 					 });
>@@ -1171,7 +1275,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 	if (IS_ERR(fence) || !need_ccs)
> 		return fence;
>
>-	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
>+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
> 				   (struct xe_migrate_copy_flags) {
> 				   .defrag_ccs = true,
> 				   });
>diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
>index e4f996942a6d..4094ea1c19c1 100644
>--- a/drivers/gpu/drm/xe/xe_migrate.h
>+++ b/drivers/gpu/drm/xe/xe_migrate.h
>@@ -13,6 +13,7 @@ struct drm_pagemap_addr;
> struct iosys_map;
> struct sg_table;
> struct ttm_resource;
>+struct ttm_tt;
>
> struct xe_bo;
> struct xe_gt;
>@@ -137,7 +138,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> 					 struct xe_bo *bo,
> 					 struct ttm_resource *src,
> 					 struct ttm_resource *dst,
>-					 struct sg_table *src_sg,
>+					 struct ttm_tt *src_tt,
> 					 bool need_ccs);
>
> struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
>-- 
>2.34.1
>
