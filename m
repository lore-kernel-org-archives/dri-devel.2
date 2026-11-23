Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EC606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b8W572Gp;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BT+Jx1JC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFD610E4DE;
	Mon, 23 Nov 2026 15:12:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F6910E4DE;
 Mon, 23 Nov 2026 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795446727; x=1826982727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=GoAs56LlOgOUQy7+6JZcmJUv54ooso12cAgY2NDX+38=;
 b=b8W572GpjDI004H+Qei6thc70A04h22uAM/MEUx4rEbw5RQ1EgkHzgI5
 UIhttIf0JPszNgz7LVlL3xcuNxbNr69oaZp9B8C7sCfaUQJQYTO9etQu0
 ZEnBlLSm3v1H8qfXi7PGPktY0e7GcI8pdj3M2yljZTQXEqg96Tn8d+Ri3
 xxhIWsdXUgoUxP5NA/HzCbd/J/qx+Z+4tFiDjfw9mm/azXMQsq9HO9T4R
 CQQbur9W/2AdtnieAvx/ejsIH1UrWW0KiOMvZ1DxzSmuCZVsp6oUIvTZm
 8N7n4G/o1X8Wuz8St7q1iAwXq9MIBfWgTe0J9th9j/59pUhrsOOrdvmnt Q==;
X-CSE-ConnectionGUID: YleVjoFGSh+EPiLkTiD2xQ==
X-CSE-MsgGUID: nLZJZ3Y3T2+wp1ztCsaJfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4094956"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4094956"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:11:31 -0800
X-CSE-ConnectionGUID: GrQyiMw+RnaJuL93D3Ka0g==
X-CSE-MsgGUID: bbqY1+FNTyCvjaqUzvQoOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="13306289"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:08:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 07:08:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 07:08:20 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 07:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPfovmEipnHtYAu73QX2NSu9+0Jd/jy2WKbgG5GWTrbMVUewL32sbdk9QEt79T3UIPUYJ4apaFXD2n53uW7DgUJAQtBbvrV6dJB3Gxqx0I8XsEcWGlJhdnI2td5Pdgp6/82aubRYBdM5hVxYCIl5+tdwlZuOjaIqnOdno19i3hZT8P+Vpi55vA1Meda17JGfcKlROFKQutN4y++81RU1SZTIKMnSrC0MPumvxfGeGrjvtbEgoGc3NvFS42OaieNkQUxTmD0vSYOK1vWe8jMSd8M11oQ7KSjXxX891BedKmOoKu/c3kJmrH9t413f7QWbZa2zIPDztQt8ljrPH+QW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWqhx7l1TeX1ApLJ/6dbLZ1EvTU1XzKNGDJYGpDsCxo=;
 b=f0M18QLcofz+9zYxiXx3JBCrR3NL1OaOV+5x3aelw/L3WgVuAk/GAdaidjhQUZrhiKOSmQRRw3XJVV5grFYSY5jMnIIdaP7I/+Qb/TQhQNlE4uy09LcRIxrQvUP6jCP8Q4S3UimXr1+XkcWV3I2RPJ6vUxBAi24WS7zlH3hxfEVyblqbWk/kNtWFF/OfdCGkYITuKGtJH36HYVrqnJBshQ7J1Q1peL/LbLbZJBnfPILf1B58izp03nlbgE47b+Tmcg1Yp3jZRRrKMcbBgWtc5NetcoFWRnMwTg9i6EIAq8g6t+FlmhVQlfwcqDitcbIzu7YM7NNvo62ulRekoZuvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWqhx7l1TeX1ApLJ/6dbLZ1EvTU1XzKNGDJYGpDsCxo=;
 b=BT+Jx1JCJxADJnO2ulqmulP//yH03KTquvMCQAxfg4gdYZCYjljKmhWmJZ+VwHruvGbSwKRtj6hULB9lT2WgJ7CV6J9b03ZPb9jkgRLWK1/D1dSvSFJ7Fn3DT/g8hb2Kg5PTeOOHWdOgv0Tdv9lqftoEKY6Ohy6gCC8qgnUGy4I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:08:16 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 15:08:14 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "Riana Tauro" <riana.tauro@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>
Subject: [PATCH 1/2] drm/ras: Add retired-pages node type
Date: Mon, 23 Nov 2026 10:08:08 -0500
Message-ID: <20261123150806.2266196-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
References: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: f14c7e0d-f293-40a3-67f6-08df497398be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261009221227099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Lw17ttySKa2aHr0R0NtLm4fojnuxw0lghSs0KpdWZD+59ocWrUOgjbJq42HNgYSHihw9qvZoDVY5SCEFjQw3fFzbExu0EM1IeG7az4bbtt3jncJI3YZS0xRtakCkK8iszz+qzozUDjpWL0QGELPvIxAhRFSmzSd72DR4iC4Uvk41H/NsnnmxyXFriFrHQqdng9X3rMuu9Vn+CLCkHaAZOU4OO35bIlrpTU5qMKDaYqbopf+eOJ7MigRpC+/xFvBhJyo78Fn2arZbV1WocDU9Qpzg+zOlqB3ZaMvdkhg7Chs2x0hD8tjCo33Y8ELU1f/HPBapMYK1kGEr033CzupGEqrtHuIl8ZLzFU6gf3lpd1HeC4HTD3QU2eDpBYF5YEX69fRSdWzdd1h8s9kH329pb0xmHBsuGrMSt0MIJexdulIzIyPiMd9656RunPN4SYlyDgnJzcdDjkmy6MSgsXP2QlNcToi84RQE8R+LsAGAJZ0jvAPm0SXI0MmpDScRNolitVaaZj18pO7ZMinNlWQmIWXW0iEqLR1LHqPvDk5iqvamdfaE7e+bHG9wvKZ8qxZnuTR6TYQWL4zcsC5mbv1UseIeSA5CtOaCPs8UVny8/9vA9CX8ufz4gjMpueMKMUMd+5w5xX5Id4dPs+YL58IIvRQb5alg+WkHiXlF/LPA5wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261009221227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BnsyOLY+jEpcTGUynEDU88zE8FuaBgJdM8AM++8csW9rAWN3dhuEexyH8mkU?=
 =?us-ascii?Q?ZKp0FlN+peaep7vyJ3Bc9yAUwbxQlNCzuxJvxl0Ot25V6aS7frLy5MmdPJrS?=
 =?us-ascii?Q?8iHnkJ5NXLjExq0odN6kT9l4Dac03btTmcjQHAohpNZ+K013ztRQaGebuOaR?=
 =?us-ascii?Q?z4VQT1UJcK0Oeu0o987m+/10i7uhpnPrjqeHJZkrDXxMqKJffPqszfSuNhfZ?=
 =?us-ascii?Q?g7w0hN0Dmv0G5s2HlCLgmwPduVyrkU15yUO8tKDMd/3D1dzGdWp59CyC9QaS?=
 =?us-ascii?Q?kAwBMLmoIol2JFHNydXsjMfX+MaEfU+0AQLsGWJ8fY3uFD0otChbIUFW5quj?=
 =?us-ascii?Q?LnkhZIpHHPP5e7U1lo90EOx21jcBdoioTfBrWKo5swuJW5RcMj6SzOa9K92f?=
 =?us-ascii?Q?k4x56bBjMLs36co1jtNT7q787yhlyEJVaoiUDSdTNwkdz38Ow5Czby4948Wl?=
 =?us-ascii?Q?WD+xAFUuV1Q7GacAIUUa4CY8DqOhVdmes/0BceDHrOqE3klmwf8Ws7k1eY6C?=
 =?us-ascii?Q?D+Wfeg9AH2p2kG2CA0kHG0fSZEBpNB/R/ND8G4abbQavj90WSgIwVjBrGIDh?=
 =?us-ascii?Q?RmUGe0MgsgHrA24L8AJL18e8Kh1fgFAU6alODUlkCmy7qjAst4yCoiqljOk3?=
 =?us-ascii?Q?j5QTZqLtgyAAgbjhuXKyA8SpMeRy/qau91NcIF3oajmv5MRV7sg3nNCQZ6gC?=
 =?us-ascii?Q?LqVqh+rAqba16oDMMR52TqB4RlUbEi8ubZE/92j8OceHzN35EqyuK0ETX8ts?=
 =?us-ascii?Q?qdzwJBqrkDPqn/Sk3F0ORlhs8SSfoOuILT9Fv3uzlB0MxWqtIDkQDrcR4pgd?=
 =?us-ascii?Q?WJRWTtUrO2p8bgdNPwDIVIyy8yT19AFMMe4PR7Deqa3o5SaTmCzX+vKx5jGn?=
 =?us-ascii?Q?JIyKoOEHToHCHE2d+EAfJQD3J6PDZ1OSsfo127nYGZt1Wo2UNmK8fTpAtE3/?=
 =?us-ascii?Q?t+0VgwS/7AlSrIj98IkD756ZrNwuqO3wgflvJutFfUR21floZZvkTnGdLgAf?=
 =?us-ascii?Q?v4or/2JRI2sA02KCQbPwAkBztaB0cKAGM0wf7TEP7bucdZunPq8v/Wl4rgcR?=
 =?us-ascii?Q?j2AM3KC+MAPVtljl6V/z5ch9HRZGHtnJnN9sQE9MRzsDVBgHXHkDdcSBYLJu?=
 =?us-ascii?Q?Cj+rUT531S34MQfk3Q3hbYZCrmbxpPeNGV/mJ8v7R90mNhWOvyj29xnFLKvw?=
 =?us-ascii?Q?0KB8bFE2RUDc16cvzd1dOjbdoOMYIXTcWCeFY20RKkArc7KVmv76x1VbtA2O?=
 =?us-ascii?Q?se1xM4dGGfui7ED6TUqVlQhK9m7IhasokG8FdYQYBN2n0zjKS4gZhWTObNsX?=
 =?us-ascii?Q?HMacwapiD2d4lUaYWDVIVWo5ut4Ll/CbsnScTb7JiNj95MKM7p8H9sBpNz1T?=
 =?us-ascii?Q?sVao5V5GKpu4CQzTkZ6+sXmwEauj3tFM+YupSkOSFflB+1RY0OnHI9WbFUav?=
 =?us-ascii?Q?bmd9+IgrCF0HagNhYk0l5gfaFpKuMMJRMrirYWwvmtZb8e3fXp7TZe74yCOk?=
 =?us-ascii?Q?+BU4bTOuMYpDIKXpSxj3T9CPBfrc21+nv728bvk6+od7cub0Bfj2h1a/fjdj?=
 =?us-ascii?Q?xNYLf3C6V3MdwANzWDfMdyv2Z10zzTnAx6cAvcdJtyztOGIjl8SUlVD0CwM+?=
 =?us-ascii?Q?Cj57U/3sq2fTgyZhM0Q3DdQdiygJtNJ5aHIzQN2c0wmt/zr56bodhbcdX563?=
 =?us-ascii?Q?7aVPoY/r/JzY+i4M0elP/5wUepGXE2utuQv5IZqIllLUIYpyEZpQFSbr6wo9?=
 =?us-ascii?Q?Rl6lucqnFA=3D=3D?=
X-Exchange-RoutingPolicyChecked: oIQTT3Upjqr/ipHHen+vXkzten/3lQC7ivKxN2uVtyokHaqGPC+M1TjInid866Yv9WwypNCC7Fk0jSIcuCRBnZQEzN02nLfh1INQZMsmnLbMrbeGkFiBpQJ+xcGeLXahCIJs6KxeRUVHyMRGGaR45VErywmOf745mteEA5de30THYcVccdKRT1fay52RAzqhuJs0O4wZY0NUANGrZVSbi0DufkGlzs4nXMeWJVezXq/zLLE/NwigGf1JyNclVGgjIrxhzNdq7H1YRMt4Dm7brbWsMVlh7Prj28krAL4Y7cZcKmdtm68bXOIbqMyvFviSRWPjgOJNssL9Mg1XjLo8Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f14c7e0d-f293-40a3-67f6-08df497398be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 15:08:14.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxm8v6FlC/i+N3PE6tov7CieBojrKTgsDlo8oyxM5ZZXOAfXRcYQOYebjEOcx3TB20NzbiBD+iAgLn3JEUrMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Add a retired-pages node type to drm-ras so drivers can report the
memory pages they have taken out of service, with two operations:

 - get-retired-pages: dump one entry per page with its address, size
   and status (retired, pending or failed). The dump is flagged with
   NLM_F_DUMP_INTR if the list changes while it is read.
 - get-retired-pages-info: return the maximum number of pages that can
   be retired.

v3 (Rodrigo+LLM):
 - Split the drm-ras core from the xe user.
 - Flatten the page attributes and name the node type retired-pages
   instead of retired-resources, avoiding the over-wrapping
   anti-pattern pointed out by Jakub: the type-specific nest and the
   resource-type enum are gone.
 - Use uint for address, size and max-pages, no pad (Jakub).
 - Start the status enum at 1.
 - Move max-pages to its own do operation instead of a leading dump
   entry.
 - Set NLM_F_DUMP_INTR from a driver generation counter.
 - Report unknown node IDs with NL_SET_BAD_ATTR.
 - Removed deprecated Assisted-by tag.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 Documentation/netlink/specs/drm_ras.yaml |  75 +++++++++-
 drivers/gpu/drm/drm_ras.c                | 179 ++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  24 +++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 include/drm/drm_ras.h                    |  48 ++++++
 include/uapi/drm/drm_ras.h               |  31 +++-
 6 files changed, 347 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 4c2ac9a1ba3f..448d22dbf1b4 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -16,11 +16,22 @@ definitions:
     type: enum
     name: node-type
     value-start: 1
-    entries: [error-counter]
+    entries: [error-counter, retired-pages]
     doc: >-
-         Type of the node. Currently, only error-counter nodes are
-         supported, which expose reliability counters for a hardware/software
-         component.
+         Type of the node.
+         error-counter nodes expose reliability counters for a
+         hardware/software component. retired-pages nodes list the memory
+         pages that have been taken out of service.
+  -
+    type: enum
+    name: retired-page-status
+    value-start: 1
+    entries: [retired, pending, failed]
+    doc: >-
+         Status of a retired page. retired means the page is reserved and out
+         of service; pending means the retirement is queued but the
+         reservation is not complete yet; failed means the reservation failed
+         and the page may still be in use.
 
 attribute-sets:
   -
@@ -100,6 +111,30 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the error counter.
+  -
+    name: retired-page-attrs
+    attributes:
+      -
+        name: node-id
+        type: u32
+        doc: Node ID targeted by this retired pages operation.
+      -
+        name: address
+        type: uint
+        doc: Device address of the retired page.
+      -
+        name: size
+        type: uint
+        doc: Size of the retired page in bytes.
+      -
+        name: status
+        type: u32
+        doc: Retirement status of the page.
+        enum: retired-page-status
+      -
+        name: max-pages
+        type: uint
+        doc: Maximum number of pages that can be retired on this node.
 
 operations:
   list:
@@ -199,6 +234,38 @@ operations:
             - node-id
             - error-id
             - error-threshold
+    -
+      name: get-retired-pages
+      doc: >-
+           Retrieve the pages retired on a retired-pages node, one entry per
+           page. The dump is flagged as interrupted if the list changes while
+           it is being read.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      dump:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - node-id
+            - address
+            - size
+            - status
+    -
+      name: get-retired-pages-info
+      doc: >-
+           Retrieve the retired page limits of a retired-pages node.
+      attribute-set: retired-page-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+        reply:
+          attributes:
+            - node-id
+            - max-pages
 
 mcast-groups:
   list:
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..34e5dab99744 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -53,6 +53,14 @@
  * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
  *    Userspace must provide Node ID, Error ID and threshold to be set.
  *
+ * 8. GET_RETIRED_PAGES: Dump the retired pages of a given node.
+ *    Userspace must provide Node ID.
+ *    Returns one entry per page with its address, size and status.
+ *
+ * 9. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
+ *    Userspace must provide Node ID.
+ *    Returns the maximum number of pages that can be retired.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -63,7 +71,6 @@
  * Node type:
  *
  * - ERROR_COUNTER:
- *     + Currently, only error counters are supported.
  *     + The driver must implement the query_error_counter() callback to provide
  *       the name and the value of the error counter.
  *     + The driver must provide a error_counter_range.last value informing the
@@ -81,6 +88,13 @@
  *       that are raised by the hardware.
  *     + The driver is responsible for error threshold bounds checking.
  *
+ * - RETIRED_PAGES:
+ *     + The driver must implement the query_retired_page() callback, returning
+ *       the retired page with the lowest address at or above a cursor, and
+ *       -ENOENT when there is none.
+ *     + The driver can implement query_retired_pages_info() to report the
+ *       maximum number of pages that can be retired.
+ *
  * Netlink handlers:
  *
  * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
@@ -95,6 +109,10 @@
  *   operation, fetching the error threshold of a specific counter.
  * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
  *   operation, setting the error threshold of a specific counter.
+ * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
+ *   operation, listing the retired pages of a specific node.
+ * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
+ *   doit operation, fetching the retired page limits of a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -105,6 +123,8 @@ static DEFINE_XARRAY_ALLOC(drm_ras_xa);
 struct drm_ras_ctx {
 	/* Which xarray id to restart the dump from */
 	unsigned long restart;
+	/* Which retired page address to restart the dump from */
+	u64 cursor;
 };
 
 /**
@@ -617,6 +637,145 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	return set_node_error_threshold(node_id, error_id, threshold);
 }
 
+static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, nla_get_u32(attr));
+	if (!node || node->type != DRM_RAS_NODE_TYPE_RETIRED_PAGES) {
+		NL_SET_BAD_ATTR(info->extack, attr);
+		return NULL;
+	}
+
+	return node;
+}
+
+static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
+				const struct drm_ras_retired_page *page)
+{
+	if (nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id) ||
+	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address) ||
+	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size) ||
+	    nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
+ * @skb: Netlink message buffer
+ * @cb: Callback context for multi-part dumps
+ *
+ * Appends one message per retired page, in increasing address order. The
+ * dump resumes from the next address after a buffer overflow, and is flagged
+ * with %NLM_F_DUMP_INTR if the list changed between messages.
+ *
+ * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
+ *         (requires multi-part continuation), or a negative error code on
+ *         failure.
+ */
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct drm_ras_ctx *ctx = (void *)cb->ctx;
+	struct drm_ras_retired_page page;
+	struct drm_ras_node *node;
+	void *hdr;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	for (;;) {
+		ret = node->query_retired_page(node, ctx->cursor, &page);
+		if (ret == -ENOENT)
+			return 0;
+		if (ret)
+			return ret;
+
+		/* Never zero, so the first message is checked as well */
+		cb->seq = page.generation + 1;
+
+		hdr = genlmsg_iput(skb, info);
+		if (!hdr)
+			return -EMSGSIZE;
+
+		genl_dump_check_consistent(cb, hdr);
+
+		ret = msg_put_retired_page(skb, node->id, &page);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			return ret;
+		}
+
+		genlmsg_end(skb, hdr);
+		ctx->cursor = page.address + 1;
+	}
+}
+
+/**
+ * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	struct sk_buff *msg;
+	void *hdr;
+	u64 max_pages;
+	int ret;
+
+	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
+		return -EINVAL;
+
+	node = get_retired_pages_node(info);
+	if (!node)
+		return -ENOENT;
+
+	if (!node->query_retired_pages_info)
+		return -EOPNOTSUPP;
+
+	ret = node->query_retired_pages_info(node, &max_pages);
+	if (ret)
+		return ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	if (nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id) ||
+	    nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages)) {
+		ret = -EMSGSIZE;
+		genlmsg_cancel(msg, hdr);
+		goto free_msg;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
@@ -631,14 +790,18 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	if (!node->device_name || !node->node_name)
 		return -EINVAL;
 
-	/* Currently, only Error Counter Endpoints are supported */
-	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
-		return -EINVAL;
-
-	/* Mandatory entries for Error Counter Node */
-	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
-	    (!node->error_counter_range.last || !node->query_error_counter))
+	switch (node->type) {
+	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
+		if (!node->error_counter_range.last || !node->query_error_counter)
+			return -EINVAL;
+		break;
+	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
+		if (!node->query_retired_page)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index c9f5e0ceb3b5..a301b2b3a194 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -41,6 +41,16 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
+static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
+static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
+	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -83,6 +93,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
+		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
+		.policy		= drm_ras_get_retired_pages_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
+		.doit		= drm_ras_nl_get_retired_pages_info_doit,
+		.policy		= drm_ras_get_retired_pages_info_nl_policy,
+		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 9aef097ea10f..9ea26c04d330 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -24,6 +24,10 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
+int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
+					   struct genl_info *info);
 
 enum {
 	DRM_RAS_NLGRP_ERROR_REPORT,
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..00bafe121eb1 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -10,6 +10,23 @@
 
 #include <uapi/drm/drm_ras.h>
 
+/**
+ * struct drm_ras_retired_page - A retired page reported by a driver
+ */
+struct drm_ras_retired_page {
+	/** @address: Device address of the page. */
+	u64 address;
+	/** @size: Size of the page in bytes. */
+	u64 size;
+	/** @status: Retirement status (enum drm_ras_retired_page_status). */
+	enum drm_ras_retired_page_status status;
+	/**
+	 * @generation: Generation of the retired page list, changed by the
+	 * driver whenever a page is added, removed or changes status.
+	 */
+	u32 generation;
+};
+
 /**
  * struct drm_ras_node - A DRM RAS Node
  */
@@ -100,6 +117,37 @@ struct drm_ras_node {
 	 */
 	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
 
+	/* Retired-Pages Related Callbacks */
+
+	/**
+	 * @query_retired_page:
+	 *
+	 * This callback is used by drm-ras to list the retired pages of a node.
+	 * It must fill @page with the retired page that has the lowest address
+	 * greater than or equal to @cursor.
+	 *
+	 * The @query_retired_page is a mandatory callback for
+	 * retired_pages_node.
+	 *
+	 * Returns: 0 on success,
+	 *          -ENOENT when no page is at or above @cursor, which ends the
+	 *                  list.
+	 *          Other negative values on errors that should terminate the
+	 *          netlink query.
+	 */
+	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
+				  struct drm_ras_retired_page *page);
+
+	/**
+	 * @query_retired_pages_info:
+	 *
+	 * This callback is used by drm-ras to query the maximum number of pages
+	 * that can be retired on a node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 2f832275ee6e..efbc45aca506 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -11,11 +11,25 @@
 #define DRM_RAS_FAMILY_VERSION	1
 
 /*
- * Type of the node. Currently, only error-counter nodes are supported, which
- * expose reliability counters for a hardware/software component.
+ * Type of the node. error-counter nodes expose reliability counters for a
+ * hardware/software component. retired-pages nodes list the memory pages that
+ * have been taken out of service.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
+	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
+};
+
+/*
+ * Status of a retired page. retired means the page is reserved and out of
+ * service; pending means the retirement is queued but the reservation is not
+ * complete yet; failed means the reservation failed and the page may still be
+ * in use.
+ */
+enum drm_ras_retired_page_status {
+	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
+	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
+	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
 };
 
 enum {
@@ -51,6 +65,17 @@ enum {
 	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
+
+	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -58,6 +83,8 @@ enum {
 	DRM_RAS_CMD_ERROR_EVENT,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_GET_RETIRED_PAGES,
+	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

