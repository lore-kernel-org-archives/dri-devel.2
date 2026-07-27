Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4E3C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C8310E70A;
	Mon, 27 Jul 2026 20:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XZsAy4Bs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09F810E0C1;
 Mon, 27 Jul 2026 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785184463; x=1816720463;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ha7ycRnYMtmAiSEzsZv5pf/1AU4aHXnoEhQqg78f+qA=;
 b=XZsAy4BsGxJ6oPWMfiaxEwRzC0GTPdgtfWTWuvcdyiGjcf9wFlOzIqDg
 mFCi+hA6Xqk7ZJxB5VOu/mhDKcYU9t4XJWvZPYy/hR401jaVuxrkDJEKB
 WoLfGS/6bu+tGppWcTZYi4Ft/XdS0veF6yPBaYQLjom2hT/VyiGxlnMBc
 IWwLUQ4pvh51bdD1PTNE9UdvoYNrnzIDzx5AUecpd+kd9TcVhLg/L6IAQ
 fm35K3SgWdAaPqN6MEvy13XiqG8TFvQ0trIEDEtww/o0vgkGfD+Z2tSPc
 WXG1okfHjRboJP8ve6Ps8iEbZKnnSR5mLaB/2ygLQ3KM7ZnYLUWzEak+q w==;
X-CSE-ConnectionGUID: sz93arL3THy50FV8PogOUg==
X-CSE-MsgGUID: 1G+rbC/mSz6yMHy890o4Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89651910"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="89651910"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 13:34:22 -0700
X-CSE-ConnectionGUID: pTm/xZM0Rxeg9Go6hFBhcg==
X-CSE-MsgGUID: K//gofbFRM2dDgzp2dQdkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="263001970"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 13:34:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 13:34:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 13:34:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 13:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3FLinG6UQxceUZuFj775Kfn1Nkt73n4SleFKoLe9IFabn7suyHmjEV4u+YaHSIhLWjY3efMBfA084fmEt5KLBSP0D5tmlNpKmlGn6dRp7bnthKD678t6I/5SkHxxgSwl1LtBFSmPCbqbTSob8z7NtNPe0NfqYhuW4z4Nqij3RkKhmX94i8S+jFKw3dX9pQ9J13djx31KxiivNqcbJi94vuMbhX1eAaO5qpEyqpaLhhbKPMuZ1HTnjXqz4nXclVo5TCIg+O+uTxuDwyKXuOiWZ1FLi4mVr38UVQ/+BOBSRdjeW1Pudz1YF4cZ60m6L8WWyrHtuC4OIwk20Ofv4dgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f+HBcDGBS4Bu+6nSN1ERAFYoIs+iF8W9OFRzijfDXY=;
 b=MKcXH8v6o3+v01UXruzURlp49gbUK+rBZ5+uPXjmlHZjTIRK3HqvgLSQGWv20MCBHu9804Rtp2V1XOlPD9FwB1KvpoyfAFIYRR0el1Fr3hDH3UXU45eTaJQT6hDB4Ryx5cCDeB6Ehm7cBvNy3o4ApMwvLtTjWGnCSO30LHSYwdMwz4l0HFLSb7zDOcQ88tbxKJ/eu/0q4u8wOUGZcA9V++IhC2x0UrkBuvYNrYvnyPvKi+CMH7uiUhCmAZ1Pt1+di3tFaCRkqdN5YR/s2AtaGA7RTWQzrzwBPcVAg+GcOqT4gfiVThPxA5VnZW5CO34LEtVAjySxi9FEas72HDp4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:34:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:34:17 +0000
Date: Mon, 27 Jul 2026 13:34:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Zi Yan <ziy@nvidia.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, "Dave Airlie" <airlied@redhat.com>, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Message-ID: <amfAxfD9257Md6Bn@gsse-cloud1.jf.intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <DK564OOZ3JUK.292JORO9KGKEV@nvidia.com>
 <DK57FVTRTLR2.1A906PYJ2TCE4@nvidia.com>
 <a0c06d8c-fc3a-4ede-8aba-8c7430027a35@kernel.org>
 <2FD2B991-09B3-40EE-8230-49BE3A239EEC@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2FD2B991-09B3-40EE-8230-49BE3A239EEC@nvidia.com>
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2701bc41-c1f3-41f5-c4b8-08deec1e6de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|4143699003|56012099006|11063799006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: btdkPyS5GsUKkwAhtN0hTiQ8mB7h1mMnFvhQwyi2csAwsfU/h8BS3mT1R+Was3e2wFryvT00Y93Bma+0kZh2B0XmHlYt4OU3/s9L70tvpbfLQmRD1/Gl3ELVRaZNpHAnedBVPdesNILmBu03Yctt8aq9Rb2gpKnmHLE9zxRSB2EYpmg4SMlqZpRH8+JplWQlPuo3SgXDis+VxCL0oJ33mzT9ri3Rn5IjIfAYU6WHGJLuw8q7i4ox/6J7SHS+nJz3Yc54NeN8xDefRIUHn92+N8cFzSEkvFS7hSmNviJMuSUfuLc+cpsvz76lP+jD6qk3cGv96rVHNYYgd1+Ljd5nHVmV8H+4Sp/RImdmDQqA+L1al3bdUppkpoKUaY5eaLyw81vqNjFyh7BpXQHXX2wwGGE8akdcWfCy9eduU5PiCXRfgLWG5mF17ubke6ok+K6Ouqi1dWOOI++cEniRFJdAmMs8l6gjUeBqgdPflzN0A62+bj8Z9eCQOOPCoLE6HaxEIYUkWJ30cn2TJFxRgCTQN4s9qZgDS/CTLBr+RJhQaRiFF5yMJDrswPr+Ac8sJIWlpbO26GLCYCWAkXrmBWMUT6zYH0T7tA6Tpkhw94TvakK2es84S9w/DDTOoRhSy6MdLo6kqr6CcRzo/rf2s5uqGaanHXFU+Mw4f9BlF0IDkcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05EVjIyUmVvRDgzRU02MTdMb2NWQ0ZnLzUwcXB3LzNLS2tSS1FkVVRQdG9j?=
 =?utf-8?B?eHErTldGM1oxbG14ckFVbUhkYTZHWlhBcGVWYkNPOHZwZk94dDJJNlpMeTRP?=
 =?utf-8?B?Y1BBV2s2TGxDcFp2Qmt0S2NFdmVGNnpzY3NWdTNUcExRdWdiL3dkRGtMRjE4?=
 =?utf-8?B?K29PckVHR2xqbUpGRjVNaHFXK2EvMFgzSWxKWkw3SjQvdHY0QXFjUk5yOHph?=
 =?utf-8?B?SFI2b0NQRXFockF6L21yNUJjNVlkekZFbjl3Zmdxdk16L21aSkFNbzloY2Jo?=
 =?utf-8?B?andTS3J4ZFZVcmpuOXp4OFk4UkFBZFlQajNCZEh6WmtVV3puV09IUHd6dU9w?=
 =?utf-8?B?V2tRY0xIdEhYV0lFTlNmZUpqNklTdVpoUFpCYVNUTGdqd21CcjhQWWR5R21J?=
 =?utf-8?B?Vjk4K1N6MGNtZGlQTThvUW11cVhDeGZpeUh5VC96OW90Q0F6QzhVa2JwVHlZ?=
 =?utf-8?B?eitTZllibXdLa0N1OXBLRHcwdVB2ZzBBa2FBR0lTRUNtSTNXUGJsZXhQNDcz?=
 =?utf-8?B?YjlleFlIUVRhRHB2VWJWaVVNS2E2U0syczlhSEJmZ2tDbEV1S2lHQWE4OTdo?=
 =?utf-8?B?NUNSSlBROVVXZ0crNDEzZFBlMXRGbEh3TENLNEtVRCtwVWRJdWJmVEZHNGY1?=
 =?utf-8?B?UE5lZEFzZE5QVGVyN0pLMFgzWmVTbVdkNlI4QWNzQjN1aXVyZE9Wc1oyb0Z5?=
 =?utf-8?B?elVaeXlEc1JCRWhaVUVuOUdNWTBBS2V0dEQ0YURHNkpXcGMyVjB3UWxmajVq?=
 =?utf-8?B?SUM3R1BxU3VucXZZcTZhS0xtNXFsU1VMemVMRnphaUs4SEdVa2krQi9ZdnFV?=
 =?utf-8?B?YUVFTWxDcHg0Z0k3K0FGdlFlSHVkM3AxYkZDekhENkZqM0pGWVZkUEVJMFpp?=
 =?utf-8?B?UGhueVdVd3ZEaXZSYjlvYVI5NkJrWHhBWEZYdW9BZWJQL1FadmxPR0YvNlRN?=
 =?utf-8?B?eWZzcVJiWnpqUjgwVDRGYjRhemN4Q1g2eENWdVJGdm1yVGFXWENybHNEY3Yw?=
 =?utf-8?B?b3ptSERrVU9NcWRnZVNsVmRoVFJsTHRLOFlLeURLUFBqdVJvNEFLTU9vSEJN?=
 =?utf-8?B?d3FyS2p1SCtTVXFkRnNQSHJlK1dBU05Edi9HR3VKbWNGMHd6aFRrSDBuOFVN?=
 =?utf-8?B?WEZBZ0JPd3ZmNmc4aklEWVpueXk1ZUxtdllFcnZFczFEcUdQMGNkZGppaWpx?=
 =?utf-8?B?TU1aOUw0ZGxaZXBtV05YQXh1bUJHRFpCdXhPSk1VTytPc3ZSV1BnTnZpUm1w?=
 =?utf-8?B?Znd0Uy9HOERFWmpJbTNGWXlWcHIySE5LMC9yZDZadUVLWlJEZnVSYk5NUmdp?=
 =?utf-8?B?QXI3cXY0N3BYRWF6Z1pGZ1pqMUVlQkdtSUZiNTJRdjJpa3RxUHlKWWgweHJN?=
 =?utf-8?B?WHFxRnhPbnM2U2l5ZUVYMEpvYi9qelFISDhITDlqZlVtWDdwc2RXOEN5YUla?=
 =?utf-8?B?cmI4TVp0WFk2bXJSTFl3ckV3cW80VEd6SmppRkh1SzZ5aGJGUFAxbXp4dXho?=
 =?utf-8?B?TnJyRVdWTXZnNDVuZFFVSjI4WlF4Rm10QzJlNE1uUzl2YzlyTmVvaU5PVGs5?=
 =?utf-8?B?QjV1MDBzV3Yza1ZPS2Nwelo3V3RCLzlSRmRXZWdzalM2dzJRamJtYmVBZmE0?=
 =?utf-8?B?aGJKVGR2ampTWE1TaWhBWjIyeWpRYWNhRnNVOVJxaFlvdjlKUFhKb0VqNHhB?=
 =?utf-8?B?YXY3aVJSVG9PRWx1WWt3TDlCeHYxT29uTGt2dVVMVk5jc3J4R1RxeWVKbTdu?=
 =?utf-8?B?YUVKSWpEU1RVcnpyYUhPRGJmNjJpQmZDMEs2YysvUHpTL0FVYnBMTmxBQkp3?=
 =?utf-8?B?NjZ0SjVmcHZIMnRpLzEvbDFNaFdVZ2VjZ0d2NXhyN3JwM1ZLcWJ3Z0NtZy80?=
 =?utf-8?B?N05IVk9STXd6bldRbWxOTjhXTEd2dEIwRWUwSzJqNnZsVmlnNkd3d0FkVWYw?=
 =?utf-8?B?SnRvRnhLSEIxOHZMR2ZaZC90WjlUb0R3UHVkQjVoVnowd3cvcWNTQlFHdWZk?=
 =?utf-8?B?cGx2U1Y2VlhFMGg0bVVmUEY3bkxKT254aDgxdkJTcENDMDlvQ0F6NGkvL2cx?=
 =?utf-8?B?UzcyR1lGaUxoWmFmRTZsNmp0YW1tdWNmQ1l0cWw5RnVyWVNpVDl5TEJuY2pn?=
 =?utf-8?B?aTR5UUV4b0FlNWY3amwvUHhyM1R1WVhBVGZKcjd6SUQ3RTRmNGdSbzl4WDBR?=
 =?utf-8?B?RGttT2l0L0tMczFsMFA0VS96ZkVNYVdPbFJScDcyUmpZY2NJZTRnUkkxdjZk?=
 =?utf-8?B?cW1FbnlOa0hDN3p2YU4xdVRzMFNrRUpGS2lxcm1Td0MvUGxUUytxWWkvekxM?=
 =?utf-8?B?aEs1bVpXN1pLZVVxZnkxNUZzaXdQaVN2QVh2YmJuY3JFQXpXTlJyUT09?=
X-Exchange-RoutingPolicyChecked: OnF+xnHw199mAM3tUoMu7aL4Ui8XpAsrgwY9Z3GAduedhYcmWJCpcg3DmVMaVTao+ljMJsPqvizURK1q+YWmLD+8gkO9UnKCD5cczp1QCjC9KfCmA/LEjXp7Hy8R2l5JMqcAJzWvS7JHKPNUUCJzQaw1yRSyE3uWfMYu3/7DUo+llyBOd8JVBYmElfik3krWWpPdOTLCXqoii3piERQpj8zmCqaGcaHcbJ6XZjT/9LBqa1ajMD5LHA+41/DFziqTUA+/x0Et53xbnORPm6eRffhGXoni3nwwnbklEwrwLMgeDwBnsvznZmOehLGAZHiKWRnA7LyA194J2rwnocgNyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2701bc41-c1f3-41f5-c4b8-08deec1e6de0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:34:17.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vkx5Men44XPoc0WtKLf71dwVuLlrsJ9lOUsSItTBCwda+sIrh6v7Zizg4AAc5IXrKXjXJtd8gxVLhZ/ZZNaXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
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

On Mon, Jul 27, 2026 at 02:23:33PM -0400, Zi Yan wrote:
> On 27 Jul 2026, at 13:33, David Hildenbrand (Arm) wrote:
> 
> > On 7/22/26 17:28, Zi Yan wrote:
> >> On Wed Jul 22, 2026 at 10:26 AM EDT, Zi Yan wrote:
> >>> On Wed Jul 22, 2026 at 12:42 AM EDT, Matthew Brost wrote:
> >>>> Add a lightweight structural split primitive for large (compound) folios
> >>>> that a driver allocated with __GFP_COMP and manages entirely by itself,
> >>>> outside of the core mm's view.
> >>>>
> >>>> The existing split paths - split_folio() and folio_split_unmapped() -
> >>>> are built for folios that the mm owns: they perform a refcount freeze,
> >>>> walk and remap the rmap, and take the anon_vma / i_mmap locks, and
> >>>> folio_split_unmapped() further assumes an anon, pagecache-style refcount
> >>>> model (nr_pages + 1). None of that applies to a folio that is:
> >>>>
> >>>>   - singly referenced (the caller holds the only reference),
> >>>>   - not mapped through the rmap (folio_mapped() == 0),
> >>>>   - not in the page cache or swap cache (folio->mapping == NULL),
> >>>>   - not on any LRU or the deferred-split list.
> >>>>
> >>>> For such a folio the split is purely structural: because nothing else in
> >>>> the kernel can reach it, there is no need to freeze the refcount or touch
> >>>> any mapping. folio_split_driver_managed() therefore performs only the
> >>>
> >>> I do not think so. PFN scanners like memory compaction should be able to
> >>> see them, unless you mean something else about "a driver allocated with
> >>> __GFP_COMP". You will need to freeze it to prevent the to-be-split
> >>> folios being touched by others.
> >>>
> >>>
> >>>> compound and split-accounting teardown via __split_unmapped_folio() and
> >>>> then hands each resulting order-@new_order folio its own reference,
> >>>> mirroring split_page() for compound folios. The caller keeps the original
> >>>> reference on the first resulting folio and is responsible for freeing all
> >>>> of them individually.
> >>>>
> >>>> The immediate user is TTM's GPU page pool, which allocates higher-order
> >>>> compound pages, maps them into userspace via VM_PFNMAP (never through the
> >>>> rmap), and needs to split them into order-0 folios under memory pressure
> >>>> so pages can be backed up to shmem and freed one at a time.
> >>>>
> >>>> A CONFIG_TRANSPARENT_HUGEPAGE=n stub is provided so callers can build
> >>>> without the split machinery; it warns and returns -EINVAL.
> >>>>
> >>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>>> Cc: Maxime Ripard <mripard@kernel.org>
> >>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >>>> Cc: David Airlie <airlied@gmail.com>
> >>>> Cc: Simona Vetter <simona@ffwll.ch>
> >>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>> Cc: Huang Rui <ray.huang@amd.com>
> >>>> Cc: Matthew Auld <matthew.auld@intel.com>
> >>>> Cc: Matthew Brost <matthew.brost@intel.com>
> >>>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>> Cc: David Hildenbrand <david@kernel.org>
> >>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
> >>>> Cc: Zi Yan <ziy@nvidia.com>
> >>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> Cc: "Liam R. Howlett" <liam@infradead.org>
> >>>> Cc: Nico Pache <npache@redhat.com>
> >>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>> Cc: Dev Jain <dev.jain@arm.com>
> >>>> Cc: Barry Song <baohua@kernel.org>
> >>>> Cc: Lance Yang <lance.yang@linux.dev>
> >>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>> Cc: Dave Airlie <airlied@redhat.com>
> >>>> Cc: dri-devel@lists.freedesktop.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Cc: linux-mm@kvack.org
> >>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> >>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >>>> Assisted-by: GitHub-Copilot:claude-opus-4.8
> >>>>
> >>>> ---
> >>>>
> >>>> The patch is based on drm-tip rather than the core MM branches to
> >>>> facilitate Intel CI testing and initial review. It can be rebased onto
> >>>> the core MM branches in a subsequent revision.
> >>>> ---
> >>>>  include/linux/huge_mm.h |  8 ++++++
> >>>>  mm/huge_memory.c        | 63 +++++++++++++++++++++++++++++++++++++++++
> >>>>  2 files changed, 71 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index ad20f7f8c179..35661d82d54a 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -402,6 +402,7 @@ enum split_type {
> >>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >>>>  		unsigned int new_order);
> >>>>  int folio_split_unmapped(struct folio *folio, unsigned int new_order);
> >>>> +int folio_split_driver_managed(struct folio *folio, unsigned int new_order);
> >>>>  unsigned int min_order_for_split(struct folio *folio);
> >>>>  int split_folio_to_list(struct folio *folio, struct list_head *list);
> >>>>  int folio_check_splittable(struct folio *folio, unsigned int new_order,
> >>>> @@ -656,6 +657,13 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
> >>>>  	return -EINVAL;
> >>>>  }
> >>>>
> >>>> +static inline int folio_split_driver_managed(struct folio *folio,
> >>>> +					     unsigned int new_order)
> >>>> +{
> >>>> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> >>>> +	return -EINVAL;
> >>>> +}
> >>>> +
> >>>>  static inline int folio_split(struct folio *folio, unsigned int new_order,
> >>>>  		struct page *page, struct list_head *list)
> >>>>  {
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 2bccb0a53a0a..06f9a5f35df8 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -4185,6 +4185,69 @@ int folio_split_unmapped(struct folio *folio, unsigned int new_order)
> >>>>  	return ret;
> >>>>  }
> >>>>
> >>>> +/**
> >>>> + * folio_split_driver_managed() - split an exclusively-owned, off-LRU folio
> >>>> + * @folio: folio to split. Must be a large (compound) folio that is owned
> >>>> + *         exclusively by the caller and is invisible to the core mm.
> >>>> + * @new_order: the order of the folios after the split.
> >>>> + *
> >>>> + * This is a lightweight structural split for folios that a driver allocated
> >>>> + * and manages itself (for example TTM's GPU page pool, which allocates
> >>>> + * higher-order compound pages with __GFP_COMP and maps them into userspace
> >>>> + * via VM_PFNMAP rather than through the rmap). Such folios are:
> >>
> >> Strickly speaking, these vm_insert*() compound pages are not folios,
> >> since folios are supposed to be rmappable and they are either anonymous
> >> memory or file-backed memory. I am working on separating them from
> >> rmappable folios by replacing PG_private with PG_folio and marking all
> >> pages in a folio with PG_folio in page_rmappable_folio().
> >>
> >> Hopefully, we can find a better name, like refcounted_folio, later for
> >> these non-rmappable compound pages.
> >
> > They wouldn't really be folios, I guess. They would likely be a simple
> > "refcounted" memtype that allows for compound pages.
> 
> Yes, they are not folios. But “folio” was started to replace “compound page”
> and slowly becomes rmappable anon and file-backed. People outside MM still
> thinks “folio” == “compound page”. But once I manage to remove PG_private
> and get us PG_folio, page_folio() will return NULL for non-folio compound
> pages and we will need a new type for them, “refcounted_XXX”. We can decide
> XXX when I get there. :)
> 
> >
> > But what is the conclusion here? It sounds like "folio_split_" is the entirely
> > wrong interface for these compound pages.
> 
> We probably would allow folio_split() to be used on compound pages now
> until we can make a clean distinction, e.g., using PG_folio, between them.
> 
> Yes, folio_split() and its helper functions are meant for rmappable anon and
> file-backed folios. But currently “folio” is de facto “compound page”, since
> for example prep_compound_head() initializes folio fields even if it is meant
> only for compound pages.
> 
> After folio and compound page are separate concepts in the code base, probably
> we can think about how to have two split functions for them and still keep
> maximum code reuse. Namely, we could have split_compound() does the compound
> page split (e.g., copying page flags, adjust compound head/tail/order, etc.)
> and split_folio() calls split_compound() and perform extra folio operations.
> The details are TBD.

I like the idea of split_compound, ideally in mm/page_alloc.c, similar
to split_page(), which performs the mechanical splitting of compound
pages managed on the driver side (i.e., not mappable, not on an LRU,
protected by dma-resv in the case of DRM, etc.).

I got yelled at for not allocating these types of pages with GFP_COMP,
and I basically found that this missing MM primitive is what has
prevented that approach from being practical. Using GFP_COMP makes our
life quite a bit easier for managing these types of pages too, so it
would be great if we could get a solution for this.

So maybe I should drop this for now, keep an eye on the MM work, and
circle back once the missing primitive is implemented?

Thanks the help / insight,
Matt

> 
> Best Regards,
> Yan, Zi
