Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E9606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ClnP1jrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766C5112CCA;
	Fri, 27 Nov 2026 17:59:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA9B112CC2;
 Fri, 27 Nov 2026 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802385; x=1827338385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5f9n6OOdRVyZGZ97l3C6XJDsvyqW1jmgSdEOClJKdrU=;
 b=ClnP1jrf4/s1mD5giNOSnPqVwtdfxdn6GFEHS6jEvPtknVGQv+We2cSe
 ElJhVZZlfCg3dF+MIeEKQdYhbuWMbpHOnDkm9H+hUVwGeX13pWXa7qllo
 nl1owof3dkxgaqujR9rKdlis+8uJomlSDCnS8/rOLd1vyXo7H1BzAal8j
 Q1305prduV/fCBopNlYmMNEV13SGkj8EZNaF/fT/N4P4CnyLzhTjnAg5W
 eRV37c9AF63unxusHHVSlCvvipOS7GTJBMLTDJCiLdCQARjX8FYufCFoh
 fo+FovZ7lJNKzSsrKxj8BdjvXugYzlFgkGF1M5wYoUcTUC7s0ZqQg0V9h A==;
X-CSE-ConnectionGUID: Ezl2LDsRSiaVyaqocZNe3A==
X-CSE-MsgGUID: RvLlPNuXR/y2SkEwmJRKnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4717125"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4717125"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:44 -0800
X-CSE-ConnectionGUID: zS3qjxB+S1motSo2jvIxDg==
X-CSE-MsgGUID: pf69E7YkRQ+5oF94mgqgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12228777"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:43 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag0X9DR7oM+nwTLHH4Wuax7zBGNdrAxE3YuSJ8ZoSVgu16383U+eoz0X9a0F6mx5tT4dA5taTSBheozSIs+/gJ1jrUFaSRqOZWX5DzQZR9JCfGv9Dfivp0wVNGLmw/wcJgsiNm8cakpQTN5lmYLqWwYwtcg9cjOIGFNkF1q0+JTuWsHL0y/TKbOaUQYKnjFaoo96Tx6KqqtdsqwESya7LFUE0MMB/SUAaRDLgy5EsjbBN8Co4rcdFMJ8vSUvcWc6DUjp2m/rgEmS1xhR2y28uIBrPSIWF1mU/AbGqR1J+9zo5jNMR1vI8AR4R0Qo/MNKK+jhpoZda8eCAUIJPgdUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzNlBXVIwWCZ3BhJ/4ZcSkWtfPxPzKsbS6vfYmH6wJk=;
 b=coZ/5hNeM1ZacbfFvuZAQe5sYGTMuJIjlW0HGyLT9PSc9Ih/XsvPLvTxcXLH/LtPGzx1CGDvfIWqMFlEXLGBIHUnioR+EWxEszeeIYPdLTRPCVQowZwNLm+e+fXNKfuVIRhiSmw2b1tFjUGoPs+LddIEv+M8mQOWtNYsiP/cl4zIsRSVuuZI4oox+UYv3n92IGyQfa95Iin6K+ZZmPmc3jYeZ4zc2UV/M4E8MNJP9BsmB7lA+5kFHNEP9PiYPz6OEiVO262dnyG7rbqv2ZhlAKdUmxTvBVzRbJeM7Sn1JNkWaG6sYDJgO0rUeBxm0cIki4mx9mqxTQ7Q78vb4czG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:41 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:41 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 9/9] tests/intel/xe_drm_ras: Test retired pages
Date: Fri, 27 Nov 2026 12:59:20 -0500
Message-ID: <20261127175914.784751-18-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::9) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c130908-4d23-425b-ccdd-08df4cb035bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022113327099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: jq1hNz3/OyGx2HG6J0Grey/rEIoGEEcLlgCWeiM4RQuUUr0Ns7SN0uvJa5Q6nAzPODPJZrGo/X5mhmofsceZcr7tFJ8Qff9I2VljWPSzWyrmzsmp5xZ1Lurdf7yMqEGBMFH3SA9OSbuZGmr3Kxx/ZUQ0MbNGtjlduteGcB2TPbmA0Gdo9iy2TffzmVspV3jmDtyC7x+pOqYNe7lGvZ/EW/OlA0xGgF+p2E1qsrAnn7aevSpM9VBk3/94fh3DuWLMRu92OxYHABm3hzCqToE9Y8psuoBNEaL2YWLig/xVyiJpaPq3BiBPhwHEqj7aam+4JJOO/VJhsBJlI1pMJYHsSqbCWODcevrR3OuNrMzrRTwHp9CGfkEJbienTkzAZX6UqnStvmUzJ3FVZ3rVdPj8luiqkF6WUK3QNGBkJD1FFo8WERti+VJ8BCMY1NRw4CF6pA9SS9/9xgjNjvhrRwhe0/CqmRU1VVs+sy5yT46uA5xdUqisIRA5VcguJX9L1S4y/8c+xXZBHI1PEgtroIgJnGyH4Sm4AV1ZxThypdMp8tvoZtVHzGKPxEYexUjgWe1nC6fluBdEF3UuSAl6oMdwKFy4HksSrrqIQ5PmiKZBYcvsAvV94tVC5/gWGZNoBZkO24QErngNcMtZEqJ3ueP9YZq351kmZIt8UQcHytGRYyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022113327099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VoRktkTU1Wb3NTektNY0RoK2NWaWliTURrQTJIZnhxcHEzdk5MUXY3Vzdy?=
 =?utf-8?B?TTVPR0VzZHgrL0h2cVZjcDhQMHZHdmIxUEw1aFk4SHZZNENzYVFocmROSlNw?=
 =?utf-8?B?KzBUaHVtNk1jeHU1Z1FjYWEwOVFMTEM0ZUhNZG5MaElSMytkM1crTTdrZnRW?=
 =?utf-8?B?NVBBUU9MNDF6MXAyWGQ0QWR5ZStHR0pkWTFYTWRRLzR4R01xd2RZeXRpZWUz?=
 =?utf-8?B?MU5RSVF2bCtNd2VzSDVFamgvWXZCYXFteUJEUU9FTnBwOU5jM0hBNXE5K0Nk?=
 =?utf-8?B?bUR5UmxGb2pwTzZEK0JOYXdwaEpyS2tBZjV2dFdDOHJGeEZLVUg4S3c1OGRs?=
 =?utf-8?B?MElBWDFYZjgrR3NaVnRWRy96NkJoN2MyVVhjVENDNFk5M21MZzNqL2d2eWx6?=
 =?utf-8?B?eGl5UnF4OHVvV2J5dXJKZW02THV6V2k3VnliRzB6U25SRlVOUWtZYmJSM2Zs?=
 =?utf-8?B?QXhhMlgwc2FDdzNiSzQ0WUdSTkxKRzFXbzRyOG4zenh5azhtYldxaGlwSWRm?=
 =?utf-8?B?MVlZSEkvb1NVVExrRDU2V0Z0VE1yWldaM3VIcXNIWXZ2RHRGQlp4eFpJM0dS?=
 =?utf-8?B?a3E5b3V0bGkvemJXSUxGdGttSFZHWFpRRXp3NXQrZHhYdmZzcW5GSlNVblJ6?=
 =?utf-8?B?N0V6d2VlUDUya0RmK1hINnk0L2JiaDdBdjdFTE1Vd0xzSDBUOVR5ZnlOWXZX?=
 =?utf-8?B?L2t5QXdreFlTUVlTdmZUSDVFMUI0dUgyYVkrR01hN3c2VG1peUFjRHUydGJh?=
 =?utf-8?B?dXRJQ0trekVOL3JQaTJaTkF2NnQ3TE1hM3NlbTVWejM0VytFSmtDa0tPL3Va?=
 =?utf-8?B?eWdxL3pSRjgvaEVmSko5RnlmdUwyVEdxMW9RbVZkTmxxSG5obElIdlVIZC81?=
 =?utf-8?B?eEdlMWRGM1ZSN0l6RmdlM1Ewa0dPRFNrSm9vUGJSenFjeTNOQ21WQmplaWlx?=
 =?utf-8?B?TlVEb09ldGt1S29ZTGEycVJWMnRkMDAwUjVldkIwZ2pUNno3djNpTWxUdm8r?=
 =?utf-8?B?OEJXSlo1Mi9mbEFMSGpoTnRVWFN3WkRsbVB5T2x3blQ4Sm4wV1VBeXJmUmJF?=
 =?utf-8?B?eG9mS0ZrYkgxbVRzSXMxVzdYT0tyYkRnemhwRGM2U3FTYWYyTDk4N2U1VVNa?=
 =?utf-8?B?R0o1QkZDQTFFTzlQRmR1TkVuOFlBTzkvOENFQjMzb3FHY0svWkYzZGpqbHZm?=
 =?utf-8?B?Zk1kQm1xMFU2R2Q1Y3ZadGtUMzJ0Ym4yQzU1SWV2T05vUi92RHVEajduZG1E?=
 =?utf-8?B?L05FRXVaeXUwdlcyM1NWTXJpVXdzODBmNTR4aEQzdlBlN095SFJVeVVSNm55?=
 =?utf-8?B?U2hlUURjdEpGMHU4NVdiQ1RTNFNFaVBGY21oVGxwNUM2MGVrZUZhMHpVM1Uy?=
 =?utf-8?B?eDhJMWNiMUFvTVU0RTE0RFBqazY1SGpBTUl6U0orSzkxcXFKcXZLRW5sLzI0?=
 =?utf-8?B?OEhaU1BEK2lSNGl5alhNWlhYWkRiemdMRHdqYnlTaVdMenRBMHNjcUM1OUc0?=
 =?utf-8?B?OFY5c2dWSGwvWFFMcFNmcFdIMVRsWEZ2dUcyNVlPTDdNaFNkaVNkWGh2SHZT?=
 =?utf-8?B?bUlzRkRUMzYvTDRpbmQwTWxYYVJldzVxZEJ6NEcvbUgycW1BZFJlcDNkdmJk?=
 =?utf-8?B?MmFuK2twTGFOWks3dE1yamwvSnhrdW5nV3BhQlRBa25uS3JTbjYvK0FjYkNI?=
 =?utf-8?B?Wjk1MEdKRmx2MGk5dVVGQ0NmUGhkdkZkeThUVXliOUFWeDRqQjBpMnBYaFFY?=
 =?utf-8?B?MWRyMDVnZ1dtajRrVHpYOXVtUDZCWHRGeDZGRmVLQ01lMjg1S2VCOHVMUlAy?=
 =?utf-8?B?QmorT1JsSGxtQ1RTYlNadS9XTWF0KzdVanBBZHNXK0lvR0huVEhnMFNhU1NS?=
 =?utf-8?B?MVBTd0dRMkN1NWQ5eFZ0REZHMXdkMVFYQ2ROd1Nub3E4QXQzd2RRRDk2OEVm?=
 =?utf-8?B?T0VPZUNjMWZjdU5MaWZZcFJpdnN6Z2k0WHpmc2djVlMwVndUTVVmQVJKR2lQ?=
 =?utf-8?B?YXpVRWJablRDblk1K3o3MTBvRXNNRXcwNk1MWWJ0QWEwVDE0Q3MvWDN0MzND?=
 =?utf-8?B?NllOQUhLZG1zRzArbWI5bDVyZ3NwU240RVd5b0pxOFlsdm1CL0VkS0ttVlpa?=
 =?utf-8?B?WThlM1FDbStGMUVhZEUya0ErbERJdkR3SzJOcm56UHRqSDBHNlhUWnBabHFZ?=
 =?utf-8?B?R1ZhQjJ6MXlKeEwzZ1F4NngvNzVXRTlvQnlmSzhZRDQxcWZiK21hUjB3SGlD?=
 =?utf-8?B?ZVJ2SGNLNFZPekpmMlozb3F0bDVydFlqTEVRZE9hcmVMZFhtUkp1ODZVN3hK?=
 =?utf-8?B?VWkzOUdYcVozNWtKejFaN2laUlNLK0JtQ28vSTYxZkNkOXdsQnMrdz09?=
X-Exchange-RoutingPolicyChecked: Xwkz3/JJuljmOF6HFPdTiL2AFF61aeSvf5hlpXCMQvb5kQKMdO5HtgCe+1lhftAEiM4X8cJJeii4nTzLmShJwSNXnli0Rk/8Zf4Ts7h4f5nT284GV+axrwoTYB22nEQt5hjuLA1GNGg8jlSM2DsFC9OOMsavhSUct86ANZdJPYYB/xselnrC5IPd0ww2kL2XOhpL+gZSKgmCIXtMKmbrpKp5b5dF8w0m8NZIraLO+2IhzgURdrlKgOVX+ZOj1LHUdifMGU3MJZnLaNG7SnHzbQjdsRdbXvZlCiw0sWsErVYZ41Iu6sRuiwWQsQRTDJLK69ERhVBBHaAB8HwiACHbxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c130908-4d23-425b-ccdd-08df4cb035bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:41.1755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxKNRK2uyug78vI8uduIbgu2NXGzA7jjAicnSJoMBHKHcpxdNtiDBT+/r7RGXSyAn+8rXYVnoAzKuUkPGk6ylg==
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

Check the retired-pages node of the device:
 - retired-pages-info: the node reports a page limit.
 - retired-pages-inject: pages injected through the VRAM page fault
   debugfs interface are listed over netlink, in address order, exactly
   as in vram_bad_pages.
 - retired-pages-invalid-node: requests on an unknown node or on a node
   of another type fail with -ENOENT.

Tested on BMG with simulated retired pages.

v4:
 - Sort the pages before comparing, drm-ras does not sort them anymore.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 tests/intel/xe_drm_ras.c | 217 +++++++++++++++++++++++++++++++++++++++
 tests/meson.build        |   1 +
 2 files changed, 218 insertions(+)
 create mode 100644 tests/intel/xe_drm_ras.c

diff --git a/tests/intel/xe_drm_ras.c b/tests/intel/xe_drm_ras.c
new file mode 100644
index 000000000..3be002040
--- /dev/null
+++ b/tests/intel/xe_drm_ras.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+/**
+ * TEST: DRM RAS netlink interface
+ * Category: Core
+ * Mega feature: RAS
+ * Sub-category: RAS tests
+ * Functionality: drm-ras
+ * Test category: functionality test
+ *
+ * SUBTEST: retired-pages-info
+ * Description: Check that the retired-pages node reports its page limit
+ *
+ * SUBTEST: retired-pages-inject
+ * Description: Inject VRAM page faults and check that the retired pages
+ *	reported over netlink match vram_bad_pages in debugfs
+ *
+ * SUBTEST: retired-pages-invalid-node
+ * Description: Check that retired pages requests fail on other nodes
+ */
+
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "igt.h"
+#include "igt_debugfs.h"
+#include "igt_device.h"
+#include "igt_drm_ras_nl.h"
+#include "igt_sysfs.h"
+
+#define FAULT_INJECT_DIR	"inject_mempage_offline"
+#define TRIGGER_FILE		"inject_mempage_offline_trigger"
+#define VRAM_BAD_PAGES		"vram_bad_pages"
+#define INJECT_PAGES		5
+
+struct nodes {
+	const char *device;
+	int64_t retired_pages;
+	int64_t other;
+	uint32_t max_id;
+};
+
+struct pages {
+	struct igt_drm_ras_retired_page *page;
+	int count;
+};
+
+static void find_nodes(const struct igt_drm_ras_node *node, void *data)
+{
+	struct nodes *nodes = data;
+
+	nodes->max_id = max(nodes->max_id, node->id);
+
+	if (strcmp(node->device_name, nodes->device))
+		return;
+
+	if (node->type == DRM_RAS_NODE_TYPE_RETIRED_PAGES)
+		nodes->retired_pages = node->id;
+	else
+		nodes->other = node->id;
+}
+
+static void add_page(const struct igt_drm_ras_retired_page *page, void *data)
+{
+	struct pages *pages = data;
+
+	pages->page = realloc(pages->page, (pages->count + 1) * sizeof(*page));
+	igt_assert(pages->page);
+	pages->page[pages->count++] = *page;
+}
+
+static void netlink_pages(struct igt_drm_ras_nl_context *ctx, uint32_t node,
+			  struct pages *pages)
+{
+	*pages = (struct pages) {};
+	igt_assert_eq(igt_drm_ras_nl_list_retired_pages(ctx, node, add_page, pages), 0);
+	igt_assert(!ctx->dump_interrupted);
+}
+
+static int cmp_address(const void *a, const void *b)
+{
+	const struct igt_drm_ras_retired_page *pa = a, *pb = b;
+
+	return pa->address < pb->address ? -1 : pa->address > pb->address;
+}
+
+static void debugfs_pages(int fd, struct pages *pages)
+{
+	struct igt_drm_ras_retired_page page;
+	char *buf, *line, *save;
+	uint64_t pfn, size;
+	char flag;
+	int dir;
+
+	dir = igt_debugfs_dir(fd);
+	buf = igt_sysfs_get(dir, VRAM_BAD_PAGES);
+	close(dir);
+	igt_assert(buf);
+
+	*pages = (struct pages) {};
+	for (line = strtok_r(buf, "\n", &save); line; line = strtok_r(NULL, "\n", &save)) {
+		if (sscanf(line, "0x%" SCNx64 " : 0x%" SCNx64 " : %c", &pfn, &size, &flag) != 3)
+			continue;
+
+		page.address = pfn * getpagesize();
+		page.size = size;
+		page.status = flag == 'R' ? DRM_RAS_RETIRED_PAGE_STATUS_RETIRED :
+			      flag == 'P' ? DRM_RAS_RETIRED_PAGE_STATUS_PENDING :
+					    DRM_RAS_RETIRED_PAGE_STATUS_FAILED;
+		add_page(&page, pages);
+	}
+	free(buf);
+
+	qsort(pages->page, pages->count, sizeof(*pages->page), cmp_address);
+}
+
+static void inject_page(int fd)
+{
+	if (igt_debugfs_exists(fd, FAULT_INJECT_DIR "/probability", O_WRONLY)) {
+		igt_debugfs_write(fd, FAULT_INJECT_DIR "/probability", "100");
+		igt_debugfs_write(fd, FAULT_INJECT_DIR "/times", "1");
+	}
+
+	igt_debugfs_write(fd, TRIGGER_FILE, "0");
+}
+
+static void test_info(struct igt_drm_ras_nl_context *ctx, uint32_t node)
+{
+	uint64_t max_pages = 0;
+
+	igt_assert_eq(igt_drm_ras_nl_get_retired_pages_info(ctx, node, &max_pages), 0);
+	igt_assert_lt_u64(0, max_pages);
+}
+
+static void test_inject(int fd, struct igt_drm_ras_nl_context *ctx, uint32_t node)
+{
+	struct pages before, after, debugfs;
+	int i;
+
+	igt_require(igt_debugfs_exists(fd, TRIGGER_FILE, O_WRONLY));
+	igt_require(igt_debugfs_exists(fd, VRAM_BAD_PAGES, O_RDONLY));
+
+	netlink_pages(ctx, node, &before);
+
+	for (i = 0; i < INJECT_PAGES; i++)
+		inject_page(fd);
+
+	netlink_pages(ctx, node, &after);
+	igt_require_f(after.count != before.count, "VRAM page fault injection not active\n");
+	igt_assert_eq(after.count, before.count + INJECT_PAGES);
+
+	qsort(after.page, after.count, sizeof(*after.page), cmp_address);
+
+	debugfs_pages(fd, &debugfs);
+	igt_assert_eq(debugfs.count, after.count);
+	for (i = 0; i < after.count; i++) {
+		igt_assert_eq_u64(after.page[i].address, debugfs.page[i].address);
+		igt_assert_eq_u64(after.page[i].size, debugfs.page[i].size);
+		igt_assert_eq_u32(after.page[i].status, debugfs.page[i].status);
+	}
+
+	free(before.page);
+	free(after.page);
+	free(debugfs.page);
+}
+
+static void test_invalid_node(struct igt_drm_ras_nl_context *ctx, struct nodes *nodes)
+{
+	struct pages pages = {};
+	uint64_t max_pages;
+
+	igt_assert_eq(igt_drm_ras_nl_get_retired_pages_info(ctx, nodes->max_id + 1, &max_pages),
+		      -ENOENT);
+	igt_assert_eq(igt_drm_ras_nl_list_retired_pages(ctx, nodes->max_id + 1, add_page, &pages),
+		      -ENOENT);
+
+	if (nodes->other >= 0)
+		igt_assert_eq(igt_drm_ras_nl_list_retired_pages(ctx, nodes->other, add_page,
+								&pages), -ENOENT);
+
+	igt_assert_eq(pages.count, 0);
+}
+
+int igt_main()
+{
+	struct igt_drm_ras_nl_context ctx;
+	char slot[NAME_MAX];
+	struct nodes nodes = { .device = slot, .retired_pages = -1, .other = -1 };
+	int fd;
+
+	igt_fixture() {
+		fd = drm_open_driver(DRIVER_XE);
+		igt_device_get_pci_slot_name(fd, slot);
+		igt_require_f(!igt_drm_ras_nl_init(&ctx), "drm-ras netlink not available\n");
+		igt_assert_eq(igt_drm_ras_nl_list_nodes(&ctx, find_nodes, &nodes), 0);
+		igt_require_f(nodes.retired_pages >= 0, "No retired-pages node on %s\n", slot);
+	}
+
+	igt_subtest("retired-pages-info")
+		test_info(&ctx, nodes.retired_pages);
+
+	igt_subtest("retired-pages-inject")
+		test_inject(fd, &ctx, nodes.retired_pages);
+
+	igt_subtest("retired-pages-invalid-node")
+		test_invalid_node(&ctx, &nodes);
+
+	igt_fixture() {
+		igt_drm_ras_nl_cleanup(&ctx);
+		drm_close_driver(fd);
+	}
+}
diff --git a/tests/meson.build b/tests/meson.build
index 806320a82..14e576ea6 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -361,6 +361,7 @@ intel_xe_progs = [
 ]
 
 if have_libnl
+        intel_xe_progs += 'xe_drm_ras'
         intel_xe_progs += 'xe_err_injection'
 endif
 
-- 
2.56.0

