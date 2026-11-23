Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CD606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYwCE/My;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gpW12da0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A572E10E808;
	Mon, 23 Nov 2026 17:53:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258E410E808;
 Mon, 23 Nov 2026 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795456399; x=1826992399;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OdUF5bayg46syr2VV14Crl2icr+qetOZrfAIPbINZek=;
 b=aYwCE/MySBeYf7cVpQ8RWmxSab8C0Y/or/jMfeUR31yjxkD8UQNrg2YW
 p6ZttbwriTbtx5XtFb0OrCr1eYqg+81nR5ChOpjCxxUIhVw1L1l0jq6kC
 fPbtYHfum3t2qZp9UOU/DGqe4Zt+ob9pbAlGux5D4l46gufDAmeDx4ZFu
 GXRVJ0ZBzHGYsZgNmjQ5Dwe9m3C6nuH+whrPIfK3G/ifsu+ZsNZJS4AT3
 udajVeRlidPuUePCmFQ07vKdP3EglkAgiwQPneXdu13+zSwXYhnteQk//
 ZwPxv/QgWAduBbfCkY8x8va5c9e5LxbZtqVNeJVVD80138q3AfePCtEM0 g==;
X-CSE-ConnectionGUID: Fuczo6/MRbSsJLtD+nwdEA==
X-CSE-MsgGUID: 9dDdUyxZRM6KbwePXksCCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4114622"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4114622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 09:53:18 -0800
X-CSE-ConnectionGUID: Qczz/tJHTQaZAKJW9XBHMQ==
X-CSE-MsgGUID: mGd9sYLASFKsEVOZoC1XMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11384635"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 09:53:17 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 09:53:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 09:53:16 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 09:53:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTNAt7Laq86uW0FT1Yaf/5KZ7U1TjKxG3CYNy/bAV4YrRsY8gid/4lxGlhrKzoiQVrGpmDtlY8Z3wjdte9pEkuWQwIq6sR03z6oXCp2A0KOWuDr6fvVX1ifxxFLGQXIw7V/JcywWt+1omZL7ZAxvM2zRUsiCZkRNlKkSdLT0TGVSLveb080/ljVxlwifZtPrxTPqC0Urwbm4UPj653HYWIrd5xgIGvjEFs5S5qo80B+l8gjwlA4rEsMNxtKCEiuA5wo13rSTZfSJBOooSp6LOZM2ZkFKI3KEBCsZctGBZYKWcqo5WQgfXELxrUdPyuR+Va1ynmtkC8HQGwvQ/cf+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dq+YwzsVUWwxDs4mWO9B2BBSIyPOZb22GTwNrl0Q74=;
 b=o1Rpkq3IBCIY6t7eOzPSfNHNUa7Zw3MvAaXmbDPtPMlVMyvsMDJFlGIgt8nOlBUSaU1pserOBKSOkbmD5xVJNThIe8mvpSkJB7RaGyz9SkWQUg4epI0f9f+S+GsKPRCjkJFR629H2UHaN9Y6r5TrbhBRvn4jkIhPJtSFgHEMIkiJG/j760tehckav24RBjfY4H4S2RHDqi0cpjv3axWZJ3Iy7mVlV7+QfMw2r6ESznE17Ed0tdto6zeTJ5oyRosCqyIgnAEGELLOOGEf5JO9+KMDydX0ii6JxIpkBLPM3uu/dBsuCYPJL0/534ShJgVONReqm6R1GBpFhAClsTas0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dq+YwzsVUWwxDs4mWO9B2BBSIyPOZb22GTwNrl0Q74=;
 b=gpW12da03wHnyXdlmjEArsS0G8gre4JPHj81ydUS/OBSPtEjbm1uFtqGaEOY5l/oJ8PTqPo75H2FbB141xyhclKn6EZnQCuQD2wS5onmH++NGCKauVPKGYY6fsjaAiYFo6lCpnwNaLp2wccEaneVcM7BSw+wFhK2wK0Z6oV/bNU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB185972.namprd11.prod.outlook.com (2603:10b6:806:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 17:53:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:53:06 +0000
Date: Mon, 23 Nov 2026 09:53:03 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 05/33] drm/ttm: Support defragmentation moves
Message-ID: <awR9f/cIDBFDl+sS@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-6-matthew.brost@intel.com>
 <au1Ax4zGApeRJF47@nvishwa1-desk>
 <av9Yz12dG7+vtgb2@gsse-cloud1.jf.intel.com>
 <awE6dk5EYBiu8k1-@nvishwa1-desk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awE6dk5EYBiu8k1-@nvishwa1-desk>
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB185972:EE_
X-MS-Office365-Filtering-Correlation-Id: 444e5a4d-254c-4141-3889-08df498aa113
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003|261026135527099003|261026121527099003|261026140227099003|261009220027099003|261026130827099003|261028144727099003|261102123227099003|261009221227099003|261022105027099003|261021130227099003|261022075727099003|261021121427099003|261022115727099003|261021133027099003|261021123027099003|261009221727099003|261009223327099003|261022113327099003|261009223027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5ofgx2xOCGFFwvQ4xObmYqnXN+V1TvgnAm+y9IxMVxHejj6f8dZcL6q3CEBvtDb8EUu9jeWeuQlRhHq3Ndns4PGhldmjYaBD48IvYt3YXN6qxKwSrfzej4ne8NKpdT93DnulXLWKUewOuTTJv5uhY1T3Ax49s9LDVIH5KehdJnrJbWHcTlHs32bL2R1r2GwWNu/osDYnJAJwQkfyCq65+3MnGe8lKSiBfy4wnBLvjEUgf/EsAOeNEOVu4sSKQs8cKwzrfPEVJSQqpDRUfo7G2UwKQH5hDkJyk13gWAqMdmrdMU6gO6HMouU3KPUEYJvW9G0kZvjetChuDkE8qyRXkXMl/5bHjaE2B7n8aVhxWHsO4bZjKfrsIcgUR40AX+0SeORQLJ44Eagwic7k2uu6ezC8p3f80GZdAKCBZVb6vtgbCfsMOM3tFp4qfx+8Cd4VehI9YWsGvbEukZv53j2tOXrUcEgZeKwvS8XvjRfVVDe7vVC1+RXFUkWxozF1WJxaYBwfXiIFpW80b0cKHyrHM9N5x7NGz5Wp043hO+vt0WXVlPpoAc/IfsFl/vMVvlKBQ+vgrkNvmPLsckt3tJgh9XT9MeQ6n0EyD/6pUFwpzlhZfQsI29EEZFUCQxuwxL5GZ83qJGYdSgzsUP5u/x4203NQPabJuguoDrgbRQ1bwoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003)(261026135527099003)(261026121527099003)(261026140227099003)(261009220027099003)(261026130827099003)(261028144727099003)(261102123227099003)(261009221227099003)(261022105027099003)(261021130227099003)(261022075727099003)(261021121427099003)(261022115727099003)(261021133027099003)(261021123027099003)(261009221727099003)(261009223327099003)(261022113327099003)(261009223027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1VNUWRaTXMyN1hJRCtPQ05aQTBBQXhNWE1kbjJ6MnFSRHcrOW14OG1DOHZj?=
 =?utf-8?B?Qkx4d2ZJb0Jmc3hHcUNNcVE1Q3hBNXgwSllNSkExUTNMYnpiMDFheEFlYlVv?=
 =?utf-8?B?RFhCZVZNSmpDdFZwT1FWcit5aU5ibEw1U1NocDc5ckVtYkVxL2FOVC9QK3M0?=
 =?utf-8?B?SWwrN3dDMExiU2xrWlFoU2NWWTJXKzN2aStUam44NzdFc3lEYzRURUUrVEUz?=
 =?utf-8?B?VFNmYURFSEt6V1NBZkpDNEZUY0IrdWdFZUhaczVvTEhYOFNXRVpGNUFsOXcz?=
 =?utf-8?B?M2QySDZ0ajVWdkphaTluKzQxeVpIWHdjSDNpMGhxcnBTVHpNK2lRWWMwNU8y?=
 =?utf-8?B?OHF6dTNaUEczVGhiMmZmYmxBeUpjWUpiYW92eElWa3pqWGpraFBtN3FsMDBL?=
 =?utf-8?B?Ni80U3RUZTNCN09lUGk0VUhjS3pSNUV0SjRjaStSM3BNNkM0bHRRc0NwUEtL?=
 =?utf-8?B?SmtCU1dSYS83eEJqa3NwSzE1RGw0NVA2RWVMVjhTb2hpQmxIOEE2L2w2Z1V2?=
 =?utf-8?B?WFl6a2dSaWNFa0FDTU5YaDdzZmRLRmhEUDlmWWM1Y0RuQjRWcGwrOTVQWWZ1?=
 =?utf-8?B?L3JraFdHRWR1NmVRQW83czR3VGZyOXVyOTl6WFlOQTMyWkRtN3QxcDRONVRY?=
 =?utf-8?B?SlpPVXdpbWRJQXUvRGFsaDBOTTNpZmIxZkwxZG5KZEdCaXJVR05PYUhPVWM4?=
 =?utf-8?B?dTlJRXhWa3p3dnZzWXo4aExiNXNYUzZXR0FnaldwTXRpbnlldWRSQkRacFNF?=
 =?utf-8?B?NjY0elFJU3VzbFVaWkRleHdtcXd2OXBiZkRXZ01TRDE1TnNJbjc2ZS80b295?=
 =?utf-8?B?elB6WE5pL2duSkF6bCtTWEFYbEprZTExYytoMVNWSkZuLzF3bGJ0TzVDK3kw?=
 =?utf-8?B?eVdZcEJqMXlncmIvQytIM0FteDlBSnYzdnNEYmZGdEJpdkxvWFBOczFQVE1G?=
 =?utf-8?B?NHBSdjkwbDE2M2FIcnFYMkdPRUcxZU5EMjdVcElQTEtJdFhkZThhWmExc1E4?=
 =?utf-8?B?TDRmbE5TdDUyN1JTR0c5eHZuRks5Y0NrdmI1Wk1WSTdBU0JaS3MyU1Awd29T?=
 =?utf-8?B?aTNDRWhDcW5LY3JiMzRxRTNCN1RwNE92elJXbGd6ZGhFYzdwTTlvdU9JV0JF?=
 =?utf-8?B?clpsME5uRi95SEdsNmEwY0ZJaW5VMGRRT0VEYjlCaFpRMmFCQzZ3Tk9yN3lX?=
 =?utf-8?B?SlZuRW91YkIxUFk2TklBMjhqMUpNMlQ1aW1rVk5NU3V4dEFUeVVIY0VZL00x?=
 =?utf-8?B?TmF1bmpLUEZDYjhEVGVCVWtzZXB1SkltWGh5OVVKRGxUMWUxS1Q3VllDOU9t?=
 =?utf-8?B?Rm9EU1EyRjV5S2tVdldEMnA3ZUhsbmlaNHkxT0JId3Bqd0d0SFFyckUxcXZP?=
 =?utf-8?B?VEpIRzU0bWdtTjJPWFk3R0hyUHM0N0t2NklLcmhJOUl5RGRoYld2S2JSM3Vm?=
 =?utf-8?B?REQwWUpFS1c2TjNWRTFOZytDNVJXanZMcE1RQnlqZ2d1bktLWEd6U0RLNHR2?=
 =?utf-8?B?emhBWmJJMEE1aFJZR0tpT3pwaFZHaTl0RjVoY1ErWEF0TWozTEtqdVdwVm9a?=
 =?utf-8?B?UGtSK0g0aElHRE91bTg0cndVN3VSL3dueWg0R1ZPTW5ZZGlSQXFaZjdwOTlh?=
 =?utf-8?B?YkVaVzZOdEd0MHlQdzNHeUpVa3k1UHI1UkJnbjlDUFhIdjZ5dlRnMG56TjVF?=
 =?utf-8?B?WmE1QVphdDNybElGa3VLNFRJQjdXMkc2QU9QZUFMZmRjTitmaHlBUVNVczAy?=
 =?utf-8?B?QnVOeTRUZ2t1WWxnVzc5d0huSmpqbjBRSGluS1Y2WEl5YkZUY2Y5UE5zSDFa?=
 =?utf-8?B?bjB0V2duTVZCK3hyYTNPOVNLdmxVUkp1bm9lVlF6cS9DbmJybDBNNVgzZXll?=
 =?utf-8?B?TGtud2NCb29JNmNFYzZNdytoZlhpV01xaW83TWpYOFczaEFxYllIdXI0Y1VS?=
 =?utf-8?B?dVhQYWpFV0MxbzZ6Z0F2L3pHTWpRWEZmSUE5TFE5Q044d1BNdnhFS0dnL1Rp?=
 =?utf-8?B?bjR6d1FYL0R5WSsxVjF3bWZjWjdKS1d6S2RWSlFlZnc5ZEVsZ1NqaFZlTWIy?=
 =?utf-8?B?azhBblRrcWdMcVBTRkpKVk40QmJIOXdpOUIxdzlvYmZSdi9vRkl6aDVYYlVI?=
 =?utf-8?B?dzF5aDZsMlVaNXBoMkQ2bHkyaENsWlB5ZlIrQzZoM2toSERTRDZMZ1dnQi9W?=
 =?utf-8?B?WlhZN0duQkVhZllqdFdrR2YvR2M3QkJHSnE1T05iSGdPQ3Jab0pxOURuek42?=
 =?utf-8?B?NVRLQ1EyUkNUR1VQTHA1bHdPdnppSFR3MkpuMHlFZVdyVU5XUmJpVXJtV2xD?=
 =?utf-8?B?dVM3QzU4S2Y0QVh5aHZpWEdoL0xBT3lwRy96a2dmTGhiRnRnVUpVQT09?=
X-Exchange-RoutingPolicyChecked: mgBZud9dJZRWivUdZo4HiKQX/kcOd2pA//cuTw3nWR5h2prOGMsihBTr/G95oEsEaJrTs9bPIOPcQ0NplGR6/UtUTf9djeqDscsFTCmTiWSUZlVqZwDCDmKb6zGStzbwRhW+wR/vrHObMvPJfWqIdgM1hd5XU6qx0S4ZbOvGEPae7v9POf726CKQF7R/eUDDA/4XdBADXd2DVahPD3yHgssnoQoTk8LyuPXPJlvJcaQCFeCAa/pHc7cIfEU/26DX/1xfQtrfNzjQittUTu6h/Hc0YOMxef1+wAG8WO+Ujueh/Rf2A4sT3BLlVTy7/f1kBWiUMnGAJFKEisE0MSt7QA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 444e5a4d-254c-4141-3889-08df498aa113
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:53:06.8468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLh5383hAEpPjRW5nk4ezacoNCqGVFPoG19/kH83YUxJAMv/q6LbwmfHGniJ7aweV609qWnKm9jjOWyQ6p4H6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB185972
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

On Fri, Nov 20, 2026 at 10:30:14PM -0800, Niranjana Vishwanathapura wrote:
> On Thu, Nov 19, 2026 at 12:15:11PM -0800, Matthew Brost wrote:
> > On Thu, Nov 05, 2026 at 06:51:51PM -0800, Niranjana Vishwanathapura wrote:
> > > On Fri, Jul 10, 2026 at 07:55:51PM -0700, Matthew Brost wrote:
> > > > Add infrastructure to let a driver re-back an already-resident BO with
> > > > fresh pages (e.g. at a more beneficial order) by reusing the normal move
> > > > machinery.
> > > >
> > > > Add ctx->defrag, which makes ttm_bo_validate() skip the "current
> > > > resource already compatible" short-circuit so a move is forced even when
> > > > placement is unchanged. In ttm_bo_handle_move_mem(), when defragging a
> > > > populated BO, stash the old tt, create and populate a fresh one
> > > > (allocating new backing), and hand the old tt to the driver move
> > > > callback via bo->defrag_old_tt for copying. On success the old tt is
> > > > unpopulated and freed; if populate or the move fails, the freshly
> > > > allocated backing is discharged and the BO is restored to its original
> > > > tt and placement.
> > > >
> > > > The old tt is handed off through bo->defrag_old_tt (reservation-lock
> > > > protected) rather than the operation context. The pointer describes BO
> > > > state for the duration of the move, so keeping it on the buffer object
> > > > is better layering and lets ttm_bo_move_accel_cleanup() pick it up.
> > > >
> > > > Because a defrag move commonly fails (beneficial-order pages are often
> > > > unavailable) and then leaves the BO untouched on its original backing,
> > > > defer ttm_bo_unmap_virtual() for the defrag case until the new backing
> > > > has been populated and the move is about to commit. Ordinary moves still
> > > > unmap up front. This avoids needlessly zapping and refaulting every
> > > > userspace mapping on the common failure path where nothing moved.
> > > >
> > > > Teach ttm_bo_move_accel_cleanup()'s ghost path about defrag: instead of
> > > > tearing the move's source tt down synchronously, hand bo->defrag_old_tt
> > > > to the ghost object so it is kept populated until the copy fence signals
> > > > and then unbound and destroyed asynchronously, while the BO keeps its
> > > > new tt. This lets a driver pipeline defrag teardown behind the GPU copy
> > > > rather than blocking on it.
> > > >
> > > > This is driver-opt-in and a no-op unless ctx->defrag is set.
> > > >
> > > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > > Cc: Ryan Neph <ryanneph@google.com>
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > >
> > > > ---
> > > >
> > > > v3:
> > > > - Reject defrag moves needing a multihop bounce: WARN, restore backing,
> > > >   -EINVAL (Sashiko)
> > > > ---
> > > > drivers/gpu/drm/ttm/ttm_bo.c      | 100 +++++++++++++++++++++++++++---
> > > > drivers/gpu/drm/ttm/ttm_bo_util.c |  16 ++++-
> > > > drivers/gpu/drm/ttm/ttm_pool.c    |   5 +-
> > > > include/drm/ttm/ttm_bo.h          |  17 +++++
> > > > 4 files changed, 127 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > index 3980f376e3ba..c1629b4c4f0f 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > @@ -125,49 +125,133 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> > > > {
> > > > 	struct ttm_device *bdev = bo->bdev;
> > > > 	bool old_use_tt, new_use_tt;
> > > > +	bool defrag;
> > > > 	int ret;
> > > >
> > > > 	old_use_tt = !bo->resource || ttm_manager_type(bdev, bo->resource->mem_type)->use_tt;
> > > > 	new_use_tt = ttm_manager_type(bdev, mem->mem_type)->use_tt;
> > > >
> > > > -	ttm_bo_unmap_virtual(bo);
> > > > +	/*
> > > > +	 * Only the BO that is the actual defrag target (moved in place via
> > > > +	 * ttm_bo_validate(), evict == false) is being defragmented. The same
> > > > +	 * ctx->defrag is threaded into evictions triggered while allocating
> > > > +	 * that target's new backing (ttm_bo_evict_alloc()), so guard against
> > > > +	 * an unrelated victim BO (evict == true) being misclassified as a
> > > > +	 * defrag move and needlessly reallocating its backing.
> > > > +	 */
> > > > +	defrag = ctx->defrag && !evict && new_use_tt && bo->ttm &&
> > > > +		 ttm_tt_is_populated(bo->ttm);
> > > > +
> > > 
> > > The sashiko reports a bug about '!evict' check which seems legitimate.
> > > 
> > 
> > See below - we don't allow multi-hop if ctx->defrag == true - i.e., we
> > pop a warning if driver tries to do this. Thus the Sashiko feedback
> > isn't right.
> > 
> 
> I think the issue is in ttm_bo_evict():
> 
>         ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>         if (ret != -EMULTIHOP)
>                 break;
> 
>         ret = ttm_bo_bounce_temp_buffer(bo, ctx, &hop);
> 
> The bo here is an unrelated victim BO being evicted to make room for the defrag target's new backing —
> not the BO actually being defragged. ctx is the same ctx threaded down from the defrag target's
> ttm_bo_validate() call, so ctx->defrag is still set.
> 
> If the first call (evict=true) returns -EMULTIHOP, ttm_bo_bounce_temp_buffer() calls
> ttm_bo_handle_move_mem(bo, hop_mem, false, ctx, NULL) — evict=false this time,
> with ctx->defrag still true. defrag = ctx->defrag && !evict && ...now evaluates true for
> this unrelated victim, misclassifying its bounce-completion as a defrag move.
> 
> Since this is the final hop (it's completing the bounce, not requesting another one),
> it doesn't return -EMULTIHOP itself, so the WARN_ON_ONCE+EINVAL guard below never triggers
> here — that guard only catches a defrag-classified move that itself needs another hop.
>

Right but actually evict isn't reachable from the Xe defrag path.

We set TTM_PL_FLAG_TEMPORARY which doesn't change the new allocation.

I could change ttm_bo_bounce_temp_buffer to clear defrag I guess, but
would rather not have hack like that in the code. Maybe I'll add WARN_ON
to ttm_bo_bounce_temp_buffer if defrag is set?

> > > > +	/*
> > > > +	 * Tear down userspace mappings up front for ordinary moves. A defrag
> > > > +	 * move is likely to leave the BO in place (beneficial-order allocation
> > > > +	 * commonly fails), so defer the unmap until the new backing has been
> > > > +	 * populated and the move is about to commit. This avoids a needless
> > > > +	 * zap and refault of every userspace mapping on the common failure,
> > > > +	 * where the BO keeps its original, still-mapped backing.
> > > > +	 */
> > > > +	if (!defrag)
> > > > +		ttm_bo_unmap_virtual(bo);
> > > >
> > > > 	/*
> > > > 	 * Create and bind a ttm if required.
> > > > 	 */
> > > >
> > > > 	if (new_use_tt) {
> > > > +		struct ttm_tt *defrag_old_tt = NULL;
> > > > +
> > > > +		/*
> > > > +		 * For a defrag move, stash the current populated tt and force a
> > > > +		 * fresh one to be created and populated (at beneficial order).
> > > > +		 * The old tt is handed to the driver move callback to copy the
> > > > +		 * contents from, and freed once the move completes.
> > > > +		 */
> > > > +		if (defrag) {
> > > > +			defrag_old_tt = bo->ttm;
> > > > +			bo->ttm = NULL;
> > > > +		}
> > > > +
> > > > 		/* Zero init the new TTM structure if the old location should
> > > > 		 * have used one as well.
> > > > 		 */
> > > > -		ret = ttm_tt_create(bo, old_use_tt);
> > > > -		if (ret)
> > > > +		ret = ttm_tt_create(bo, old_use_tt && !defrag_old_tt);
> > > > +		if (ret) {
> > > > +			if (defrag_old_tt)
> > > > +				bo->ttm = defrag_old_tt;
> > > > 			goto out_err;
> > > > +		}
> > > >
> > > > -		if (mem->mem_type != TTM_PL_SYSTEM) {
> > > > +		if (defrag_old_tt || mem->mem_type != TTM_PL_SYSTEM) {
> > > > 			ret = ttm_bo_populate(bo, ctx);
> > > > -			if (ret)
> > > > +			if (ret) {
> > > > +				/*
> > > > +				 * Discharge the freshly allocated backing and
> > > > +				 * leave the BO on its original tt/placement.
> > > > +				 */
> > > > +				if (defrag_old_tt) {
> > > > +					ttm_tt_destroy(bo->bdev, bo->ttm);
> > > > +					bo->ttm = defrag_old_tt;
> > > > +				}
> > > > 				goto out_err;
> > > > +			}
> > > > 		}
> > > > +
> > > > +		bo->defrag_old_tt = defrag_old_tt;
> > > > 	}
> > > >
> > > > 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
> > > > 	if (ret)
> > > > 		goto out_err;
> > > >
> > > > +	/*
> > > > +	 * A defrag move deferred its virtual unmap until the new backing was
> > > > +	 * successfully populated; tear the userspace mappings down now, before
> > > > +	 * the move swaps in the new pages, so the next fault re-establishes
> > > > +	 * them against the new backing.
> > > > +	 */
> > > > +	if (defrag)
> > > > +		ttm_bo_unmap_virtual(bo);
> > > > +
> > > 
> > > NIT...would it be good to always do virtual unmap here defrag or not?
> > > 
> > 
> > We could unconditionally move the ttm_bo_unmap_virtual here. I didn't do
> > that to not mess non-defrag behavior but it looks harmless to
> > unconditionally shuffle around.
> 
> yes, ok.
> 
> > 
> > > > 	ret = bdev->funcs->move(bo, evict, ctx, mem, hop);
> > > 
> > > Sashiko reports a bug here when ttm_bo_move_memcpy() is used as move()
> > > function. Though xe doesn't use that function, it is perhaps good to
> > > guard against.
> > > 
> > 
> > What is suggestion to guard against this?
> > 
> 
> As ttm_bo_move_memcpy() is not defragmentation aware, it will cause both
> source and destination kmap to refer to same bo->ttm. we should probably
> guard against drivers falling back on ttm_bo_move_memcpy(). May be in
> ttm_bo_move_memcpy(), add a WARN_ON if bo->defrag_old_tt is set and
> return error?
> 

+1

> > > > 	if (ret) {
> > > > -		if (ret == -EMULTIHOP)
> > > > +		if (ret == -EMULTIHOP) {
> > > > +			/*
> > > > +			 * A defrag move targets the BO's current placement and
> > > > +			 * must complete in a single hop. A driver requesting a
> > > > +			 * bounce here is unsupported: restore the original
> > > > +			 * backing and fail the defrag rather than retrying the
> > > > +			 * multihop with ctx->defrag still set, which would
> > > > +			 * misclassify the bounce as another defrag move and
> > > > +			 * overwrite/leak bo->defrag_old_tt.
> > > > +			 */
> > > > +			if (unlikely(defrag)) {
> > 
> > Here is what makes -EMULTIHOP (Sashiko evict issue) impossible.
> > 
> 
> Responded above.
> 
> > > > +				WARN_ON_ONCE(1);
> > > > +				ret = -EINVAL;
> > > > +				goto out_err;
> > > > +			}
> > > > 			return ret;
> > > > +		}
> > > > 		goto out_err;
> > > > 	}
> > > >
> > > > +	if (bo->defrag_old_tt) {
> > > > +		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> > > > +		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> > > > +		bo->defrag_old_tt = NULL;
> > > > +	}
> > > > +
> > > > 	ctx->bytes_moved += bo->base.size;
> > > > 	return 0;
> > > >
> > > > out_err:
> > > > -	if (!old_use_tt)
> > > > +	if (bo->defrag_old_tt) {
> > > > +		/* Failed defrag move: restore the original backing. */
> > > > +		ttm_bo_tt_destroy(bo);
> > > > +		bo->ttm = bo->defrag_old_tt;
> > > > +		bo->defrag_old_tt = NULL;
> > > > +	} else if (!old_use_tt) {
> > > 
> > > Another sashiko reported bug about tearing down the old pages while an
> > > async copy is still in progress. Looks like xe driver waits for move to
> > > complete before returning, so should be fine. But probably worth adding
> > > a documentation for defrag_old_tt that "a defrag-aware move callback must
> > > not return an error while a copy into the new backing is still in flight
> > > 
> > 
> > I think it is implied in the ->move() contract if one fails after
> > triggering an async move, you must wait on async move before returning
> > or TTM will explode. This appears to be existing behavior too.
> > 
> 
> Ok.
> 
> One more point below.
> 
> > Matt
> > 
> > > Niranjana
> > > 
> > > > 		ttm_bo_tt_destroy(bo);
> > > > +	}
> > > >
> > > > 	return ret;
> > > > }
> > > > @@ -835,7 +919,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
> > > > 	force_space = false;
> > > > 	do {
> > > > 		/* Check whether we need to move buffer. */
> > > > -		if (bo->resource &&
> > > > +		if (bo->resource && !ctx->defrag &&
> > > > 		    ttm_resource_compatible(bo->resource, placement,
> > > > 					    force_space))
> > > > 			return 0;
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > index 3e3c201a0222..771313162c8d 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > > > @@ -626,10 +626,22 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
> > > > 	 * bo to be unbound and destroyed.
> > > > 	 */
> > > >
> > > > -	if (dst_use_tt)
> > > > +	if (bo->defrag_old_tt) {
> > > > +		/*
> > > > +		 * Defrag move: @bo already points at the freshly allocated,
> > > > +		 * beneficial-order tt that the move copied into. Hand the old
> > > > +		 * tt (the move's source) to the ghost so it is kept populated
> > > > +		 * until @fence signals and then unbound and destroyed, instead
> > > > +		 * of being torn down synchronously. @bo keeps its new tt.
> > > > +		 */
> > > > +		ghost_obj->ttm = bo->defrag_old_tt;
> > > > +		ghost_obj->defrag_old_tt = NULL;
> > > > +		bo->defrag_old_tt = NULL;
> > > > +	} else if (dst_use_tt) {
> > > > 		ghost_obj->ttm = NULL;
> > > > -	else
> > > > +	} else {
> > > > 		bo->ttm = NULL;
> > > > +	}
> > > >
> > > > 	dma_resv_unlock(&ghost_obj->base._resv);
> > > > 	ttm_bo_put(ghost_obj);
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index 0ca63f5ce73c..d045105afc24 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -860,8 +860,11 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > > > 	 * pages. Record it so the driver can later try to defragment the object
> > > > 	 * back to beneficial order.
> > > > 	 */
> > > > -	if (it->beneficial_order && it->order == it->beneficial_order)
> > > > +	if (it->beneficial_order && it->order == it->beneficial_order) {
> > > > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > > > +		if (it->ctx->defrag)
> > > > +			return -ENOMEM;
> > > > +	}
> > > 
> > > NIT...probably good to add a comment here that says something like,
> > > 'return error here as the purpose of defragmentation is to get beneficial order'.
> > > 
> 
> I guess, you missed this point (sorry for signing early at previous comment).
> 

Sure.

Matt

> Niranjana
> 
> > > >
> > > > 	it->order--;
> > > > 	it->page_caching = it->tt->caching;
> > > > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > > > index fd814b5cf535..f4f8a8c29f04 100644
> > > > --- a/include/drm/ttm/ttm_bo.h
> > > > +++ b/include/drm/ttm/ttm_bo.h
> > > > @@ -135,6 +135,16 @@ struct ttm_buffer_object {
> > > > 	 * reservation lock.
> > > > 	 */
> > > > 	struct sg_table *sg;
> > > > +
> > > > +	/**
> > > > +	 * @defrag_old_tt: Used internally during a defrag move to hand the BO's
> > > > +	 * previous, populated struct ttm_tt to the driver's move callback so
> > > > +	 * that it can copy the contents into the freshly allocated
> > > > +	 * beneficial-order backing. Set by TTM, consumed by the driver; the old
> > > > +	 * tt is freed (or restored on failure) by TTM once the move completes.
> > > > +	 * Protected by the reservation lock.
> > > > +	 */
> > > > +	struct ttm_tt *defrag_old_tt;
> > > > };
> > > >
> > > > #define TTM_BO_MAP_IOMEM_MASK 0x80
> > > > @@ -194,6 +204,13 @@ struct ttm_operation_ctx {
> > > > 	 * reclaim/compaction before falling back to a smaller order anyway.
> > > > 	 */
> > > > 	bool beneficial_reclaim_backoff;
> > > > +	/**
> > > > +	 * @defrag: Defragmentation pass. Attempt a move even when the bo's
> > > > +	 * current resource is already compatible with the requested placement,
> > > > +	 * so that the backing store can be reallocated at the pool's beneficial
> > > > +	 * order.
> > > > +	 */
> > > > +	bool defrag;
> > > > 	/**
> > > > 	 * @resv: Reservation object to be used together with
> > > > 	 * @allow_res_evict.
> > > > --
> > > > 2.34.1
> > > >
