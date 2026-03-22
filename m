Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B02FC72AA
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 06:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E081E10E012;
	Sun, 22 Mar 2026 06:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T1lV70P3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AF10E012;
 Sun, 22 Mar 2026 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774161802; x=1805697802;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=aT9lsTgrNwzegaDjW5BtrvkyhW7B81bMNfXh4z+H0Xs=;
 b=T1lV70P3b8RAHOVOdTzgLIrS3kyKnBzpSatv9ekSXD3BMPC4PfvbIrKB
 WUzMxd7w5NvR0PUfvviMQtYQXbN4emTyEzoZszGbN++O05J58oVw6a4UL
 r2FGj4DBfz9++YoXVp7b/DX+xJtEKjXKUnr8enM9ZGh5oY21rwM6j/srm
 Y3qrJHNaQMTGfyyVKJXV3agRV2BEi5f7lDeAh11hryVvoT1qsnfwpl9oC
 2foyISNFilCA0XVEQPqJXXvNgvsJNl8ra8CYOqhBNHTifIWWkeu3nemDt
 H1yOpMKdPJEYHCmHJzY75nN9fnVWkxqXXC2PXQWCPsML9WkitOz5w/lR/ w==;
X-CSE-ConnectionGUID: FMLC4GpRStG0sX3YjmaLsw==
X-CSE-MsgGUID: I0hkW8BiS4aI2Zc32dh1OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="79055988"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="79055988"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 23:43:21 -0700
X-CSE-ConnectionGUID: hEHxEIBeSrmPOD6cntTDvw==
X-CSE-MsgGUID: uUBZvd+KR9SigAxeFqZWOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="227807060"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 23:43:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 21 Mar 2026 23:43:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 21 Mar 2026 23:43:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 21 Mar 2026 23:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5yyeuWeBGVT3HxrLFrUk3ti1FKC3O0LRtRhjEI0l/5wSrOsfoPVR97KvUx9m/RFbCvPWReVXDL8JaOBVU1/k4gAspmp+NolPsdViQQJvTPt3krzYZaWDH1AohhkuXNZ3OWZvVc2otQv4rRMXHY4+Mwbkhl5FCYRBIu96xMfA1KNCVjQj8kpZPgaryenqcVTK/Ha/T1CjUIXcFAmXtDg8HvJWjcJy1K54lZNpFLlw8g/grTWGQkghUZYrScUWoeoHMdx1sssKDnYUi+ghKr/1JSGgdYgwZb0d17IDAaPUy7wfHBbtsDOIUsp+VdO609gzBNIvBJP9W7rYcTJ9L3EAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKGbJh+f2X5r5RlyfPe/ls3N9uc8yXYZF42LnpbvmEU=;
 b=E3z3WBz4kBdiuzQa6CclINuTaAZsZ8QJbcg8Wzcs1d5nol0pSUmKR/IrVBctgTlccGksM1BfpJqXXZ5FI5GPs8Rkgaw5bCODMz5y75z9CseDmp9kMJ/JpZGd3fg/cLgS9rmbgqPvOdmHNbBpyib7rSXxAElvNb/NmktuKt5Qd6TflrHV4v57P/qFO6iYV3mZF7BfUN7VFUeOfevdxPUoEVSH5Og1JDLOs5Mx4TWT73UilBpPymQ0do7T3HsFrkpGHx/4Rkfq/M/lc1tho+dqw8d+TDVuSFiZsriRyfTTiT06Xp8od584iEEhnhFpXOBalOFQAV2ZGUBlAetaPz9BaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 06:43:16 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::b36e:ab4:9ded:1305%5]) with mapi id 15.20.9745.007; Sun, 22 Mar 2026
 06:43:16 +0000
Date: Sat, 21 Mar 2026 23:43:12 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Danilo
 Krummrich" <dakr@kernel.org>, David Airlie <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Daniel Stone <daniels@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, John Hubbard
 <jhubbard@nvidia.com>, <shashanks@nvidia.com>, <jajones@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <ab+PgBzwJkhhj6dw@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
 <20260317214320.74e6c130@fedora>
 <absp4z1Op0BrXReP@lstrano-desk.jf.intel.com>
 <20260319105729.2c20116d@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319105729.2c20116d@fedora>
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|IA0PR11MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8f0437-f039-4acd-056b-08de87de4c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: q7uxX1Mp7930Bt+xgzKQbovxICCJwvqC1WSHQEBCr71pSxERSLzhyOD73990LigLwDiyZbfDN8qMh07hX3X0cMC6F7/EnOxRixg8IoCk2JHYqeK/cL9QZdeWxOXuebrhwFL0LgR9/39gJtd5ra2y+r9sEzCUi97VwgmioyEVwhEUvMhBl9y13WhoQUwJp+MYfRvhnkEfdf1PjvbJ2Cj8Yugw453He3hZl4ReSwVkcU2uZaD6Clze56k4UH9kE6Wng8gXXE1iVoWN5o2knxYv0T5nVs4QKw4/CoMSBtGfQMbZy45SUFVk/tf/9CUbxWvhPjTeHddZR59OyxnKzlNxF7EbHW+ysKvXYI3i3hpFRqmrDfh5V81pFjl+r757NOjElNpgSExMf+HMHMPnb0uN2k0NOEHsbf2vsF8UgTt7WwfC+sezkhPujKUVEiY0lPgsQ3vhN9jucUcG5im2z/BbVS7TuFkFRA45KCCWgI6iHwz736Vk4iO9FDK0kMCVyqnNue28IJYPcb6twGOlJCb1Rag16QyDdMBCWv2AXoHaBEldIIQGCC/VlH6HKDcxZgupuNoW6G1JqF66P/XFBKdxqvF9x9+b05YV8AWSgeVwjVRKJMMpXspXDKh1gNODGYIMDzcp4matfLgxs6iksi/NCyt0faPG1uE+1FTsdqz5/65M4nAQX8wtyahXk4zWdJz/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhsODBsaDQ4VFhXTzh0OUNZR1hnTHF0R0ZJSGRNbUpDcG9FOUtpQTlPOVR0?=
 =?utf-8?B?aWVVSFJMSHh2b1RlUHkzM0hoMk5CTldUTmNZb0ZIYlU5VExTUDJrNlJ4VGtQ?=
 =?utf-8?B?d25FY3Fya2VqK3BhVCsrL0c1VG00eS9GYUNzcHlVWnUyb2k2M3BKTWU2NmN5?=
 =?utf-8?B?OFJrNm5xa1VXbnJNaDRiRndPbjhETmdMWTFnbTZHeWx2cE1zeUtqbHVzTmFY?=
 =?utf-8?B?YTlEclA4NGN4Tlh4UVl4SDlSZnhBQUJRY2Q4K2syM2JoMTJFNDIxZ1BXQzFy?=
 =?utf-8?B?SmpFNGJDZU4wbkFkdmJyYlJGQkZ3NEtHWGNTditZWERoSEZQdzBqa2VlbEx3?=
 =?utf-8?B?YlhaMmpnWEo0WGtBRUMxblQ0eXdadTZTWnRFT2lkcHhPd25ZYmxMeE5mUnZH?=
 =?utf-8?B?Z0lFcFRQM2hmRVlWSDBHa0lJR0d1aVFDUDR6ZDR1eU5HT2VsQjBYdlY3Y0hy?=
 =?utf-8?B?aGFncytQcXpkWHV5cTdkMFN2SzQwM2RsdVhma09KbTI3NGh5T0FwOGVXaHc1?=
 =?utf-8?B?TldpRXpwRmdXVEEyVlpLNzdtRGtvbVRQL0Y0T0gwcThTU05lYnlaelk0c0tu?=
 =?utf-8?B?eXR6Smo4S1M0Tkc4cmZBWmdIdEIxaTBtRDc5N2s0NlhUcjJGckhVRXIySlJL?=
 =?utf-8?B?U0oyT1poRW90U1pvYVdEMUsxVEdQbUhERllvWENNZWdocFJTckNUaHpXcUF3?=
 =?utf-8?B?WUZ2U3BsNnZXSmpsTFJMYkxmVlBLTzdLYXc2VFV5QUQ4Nm9QOGQ2ZnlVMU1u?=
 =?utf-8?B?cEF6VTlVRlNoQ0RETEIrRFJ4cHRpOE1BbTlOczV1cGx2b0NLaERsL3lOTVlT?=
 =?utf-8?B?YWc5NnJMZy9jMmhDSmpidkVxK2tSZG5YZm5wS3RlNm1yWGdBMXJIMnJyTDJJ?=
 =?utf-8?B?MDUzNVlsdjEzK1NNUDE3b05OU0krc3lnL3NjZkphRXVRYlNvUXMxK2VsSldJ?=
 =?utf-8?B?V1RBMTNyc1R3ZEp0ZjVNVFFBamdQTnI1Ykp3R0xmNTBrWkRLMEJhcW8vcDRm?=
 =?utf-8?B?NUd4STY1eFJFelM3K3ZUdU9DdWdIdEYvc0lOL2t3UlAzbUtRTXpESXViY2ZS?=
 =?utf-8?B?NjBnQkl2SGdZbmtxM0dJY2lKVTVhajFSamJNRW9HZ0EyOGZFb0lkOVBpc2xl?=
 =?utf-8?B?TDdXNWg1eG1DSjA1K2xNSFZJdFhsQnJRS0IxNXdOcFNsMFNKTWJYcm5RZVRE?=
 =?utf-8?B?RCtVa3pvUXlPZjhiSTZ0U2lLMWQ3MnRJT0NPTDQxYVRMVS9Idi9paklMR091?=
 =?utf-8?B?elQzbWNNNlhwTzlDdjZZNnRuSnRQS1BHN0tvS0VOdENRY1Npdzcxb3VHcDN5?=
 =?utf-8?B?eDJxTDBJdU1JS0ZUamNybG5ETTlKTzllZWJFNjM3WmpUMGUvb2Z4T212Skkr?=
 =?utf-8?B?SDFUOTluSWs5OFA4d1pNZkhtOXEyd3hONVhVTEh3ZFpmM1BHcFlTNy85Rkor?=
 =?utf-8?B?LzVNd1IycUZuaURJblF3QWNDYlk5M21ObzM4eVFudm9kNEpuWmxKVlBqVDRN?=
 =?utf-8?B?OVZsOFU2RmNCalNTQmxMcEpvWmtHbWJKcmI2ci9YMVFNSnZYdnIvb3I5cUxs?=
 =?utf-8?B?dTQrWmpJbTNNQ0RhemM3S05GdUhhV0hNRUFLTEMvaVQxdXQ0NnNZTFZkTVlK?=
 =?utf-8?B?K0d1cjEwRHRCdFdkbGFSM2hGWmJ4cERWM0JOWWo4dk0zQTdnT09UQks0UU9l?=
 =?utf-8?B?SWFwUEV3ODJwVjVjcHhTWkpWUmtlTkRkd0RYaFB5dGw4YkVDb0RpRldiNWVD?=
 =?utf-8?B?a1NSMHF0c1dTM1dkeklzSVJ6NktKejlscnorY0JtY3RVNCt5MkR5NGRabHRF?=
 =?utf-8?B?ZVpGOEw5dUpoVU90Q0lnLzB1RDVocVhkTzdFNnp3dmE4aHVGRzQ4TlFPOEdZ?=
 =?utf-8?B?bGZFaXlPZ0t3ZUVZZ0RMSmV4VXNRWEtNQ0FPTW95WUoxVlVBKy80QlNvWVpI?=
 =?utf-8?B?UnAvN3hmVGVOK2hVTjFuN0N5LzA0TjQveXQ3Ryt2U1M3OFM5amtmMWFXektU?=
 =?utf-8?B?K0w5MGZDTGxZZjJUK1BwclFVMlYyUGMxMjlZakd1eFJsOWF3Tm1JN3htZXU2?=
 =?utf-8?B?a011SHc2MW8yYW5GeEVTVTVrU084UHNDeURRL3FZeFN3OXFobm1TVjk4SjFF?=
 =?utf-8?B?bkhwM01iOWY4bEhzTUJXdmQwOEloU2d4bGZGZWNVOHRYRjdENlRmL3Q0Yy9z?=
 =?utf-8?B?L0pqRmxNNTNJSkoxVHdiR2c1czFnYk13L0xsaGJ2SGFIbXBncmtKVmYrMVc2?=
 =?utf-8?B?VlZhR1g3Vi9YQ1JDY3JrVUVBdHpySS9XYnEzZGdMeU9jV1pEYnZ1bmFuWDF3?=
 =?utf-8?B?UFMveExZNzdCSnhJVlNLK1F2RGgwa2FuOFlDWTd3cHJ5SnFJeXRNQm9XMDBD?=
 =?utf-8?Q?GEMIZ/QiTrVyz3RU=3D?=
X-Exchange-RoutingPolicyChecked: IzKydvO3DCPO3XxzDrkkTGwxI1lHdh4R/5XVqo2jBjk6IrggBFqU7B+F/SX9LdWbA35533D0Nv1/th/MHyBpGMFRUJRMC0ubqRQZgw3CML0CfVh0rgr+K6OhMOBZtTKV4L+GKYDLxCqEA7dM3RlxsqaAvt7iXmdsBppnnMSGfgl5FlwIxwx2nbCBCqSupLyZIY+xqFRy5kP9LtNDAsqbVUiBhbxEdi1Lvv+Jp98H85ebZ5hmCifbCi2faWRB5Qmbz3znVnxULpP1IvHwweCnhsVRjSBeieK8aZvJ8zPxGvSlMqmIY1iv2pTRuEcvkehApGkYrVWKGS7/DjtMaXI64w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8f0437-f039-4acd-056b-08de87de4c31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 06:43:16.6669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOsQV0MdpOBxFs52RnoN4QRXvyWvVSY8tEtf39BH5PdFr3YnIxzPm4IOqs1cxhdlCPTJPLTYkFfU7UtMc68dHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
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

On Thu, Mar 19, 2026 at 10:57:29AM +0100, Boris Brezillon wrote:
> On Wed, 18 Mar 2026 15:40:35 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > > > 
> > > > So I don’t think Rust natively solves these types of problems, although
> > > > I’ll concede that it does make refcounting a bit more sane.  
> > > 
> > > Rust won't magically defer the cleanup, nor will it dictate how you want
> > > to do the queue teardown, those are things you need to implement. But it
> > > should give visibility about object lifetimes, and guarantee that an
> > > object that's still visible to some owners is usable (the notion of
> > > usable is highly dependent on the object implementation).
> > > 
> > > Just a purely theoretical example of a multi-step queue teardown that
> > > might be possible to encode in rust:
> > > 
> > > - MyJobQueue<Usable>: The job queue is currently exposed and usable.
> > >   There's a ::destroy() method consuming 'self' and returning a
> > >   MyJobQueue<Destroyed> object
> > > - MyJobQueue<Destroyed>: The user asked for the workqueue to be
> > >   destroyed. No new job can be pushed. Existing jobs that didn't make
> > >   it to the FW queue are cancelled, jobs that are in-flight are
> > >   cancelled if they can, or are just waited upon if they can't. When
> > >   the whole destruction step is done, ::destroyed() is called, it
> > >   consumes 'self' and returns a MyJobQueue<Inactive> object.
> > > - MyJobQueue<Inactive>: The queue is no longer active (HW doesn't have
> > >   any resources on this queue). It's ready to be cleaned up.
> > >   ::cleanup() (or just ::drop()) defers the cleanup of some inner
> > >   object that has been passed around between the various
> > >   MyJobQueue<State> wrappers.
> > > 
> > > Each of the state transition can happen asynchronously. A state
> > > transition consumes the object in one state, and returns a new object
> > > in its new state. None of the transition involves dropping a refcnt,
> > > ownership is just transferred. The final MyJobQueue<Inactive> object is
> > > the object we'll defer cleanup on.
> > > 
> > > It's a very high-level view of one way this can be implemented (I'm
> > > sure there are others, probably better than my suggestion) in order to
> > > make sure the object doesn't go away without the compiler enforcing
> > > proper state transitions.
> > >   
> > 
> > I'm sure Rust can implement this. My point about Rust is it doesn't
> > magically solve hard software arch probles, but I will admit the
> > ownership model, way it can enforce locking at compile time is pretty
> > cool.
> 
> It's not quite about rust directly solving those problems for you, it's
> about rust forcing you to think about those problems in the first
> place. So no, rust won't magically solve your multi-step teardown with
> crazy CPU <-> Device synchronization etc, but it allows you to clearly
> identify those steps, and think about how you want to represent them
> without abusing other concepts, like object refcounting/ownership.
> Everything I described, you can code it in C BTW, it's just that C is so
> lax that you can also abuse other stuff to get to your ends, which might
> or might not be safe, but more importantly, will very likely obfuscate
> the code (even with good docs).
> 

This is very well put, and I completely agree. Sorry—I get annoyed by
the Rust comments. It solves some classes of problems, but it doesn’t
magically solve complex software architecture issues that need to be
thoughtfully designed.

> > 
> > > > > > > +/**
> > > > > > > + * DOC: DRM dependency fence
> > > > > > > + *
> > > > > > > + * Each struct drm_dep_job has an associated struct drm_dep_fence that
> > > > > > > + * provides a single dma_fence (@finished) signalled when the hardware
> > > > > > > + * completes the job.
> > > > > > > + *
> > > > > > > + * The hardware fence returned by &drm_dep_queue_ops.run_job is stored as
> > > > > > > + * @parent. @finished is chained to @parent via drm_dep_job_done_cb() and
> > > > > > > + * is signalled once @parent signals (or immediately if run_job() returns
> > > > > > > + * NULL or an error).    
> > > > > > 
> > > > > > I thought this fence proxy mechanism was going away due to recent work being
> > > > > > carried out by Christian?
> > > > > >     
> > > > 
> > > > Consider the case where a driver’s hardware fence is implemented as a
> > > > dma-fence-array or dma-fence-chain. You cannot install these types of
> > > > fences into a dma-resv or into syncobjs, so a proxy fence is useful
> > > > here.  
> > > 
> > > Hm, so that's a driver returning a dma_fence_array/chain through
> > > ::run_job()? Why would we not want to have them directly exposed and
> > > split up into singular fence objects at resv insertion time (I don't
> > > think syncobjs care, but I might be wrong). I mean, one of the point  
> > 
> > You can stick dma-fence-arrays in syncobjs, but not chains.
> 
> Yeah, kinda makes sense, since timeline syncobjs use chains, and if the
> chain reject inner chains, it won't work.
> 

+1, Exactly.

> > 
> > Neither dma-fence-arrays/chain can go into dma-resv.
> 
> They can't go directly in it, but those can be split into individual
> fences and be inserted, which would achieve the same goal.
> 

Yes, but now it becomes a driver problem (maybe only mine) rather than
an opaque job fence that can be inserted. In my opinion, it’s best to
keep the job vs. hardware fence abstraction.

> > 
> > Hence why disconnecting a job's finished fence from hardware fence IMO
> > is good idea to keep so gives drivers flexiblity on the hardware fences.
> 
> The thing is, I'm not sure drivers were ever meant to expose containers
> through ::run_job().
> 

Well there haven't been any rules...

> > e.g., If this design didn't have a job's finished fence, I'd have to
> > open code one Xe side.
> 
> There might be other reasons we'd like to keep the
> drm_sched_fence-like proxy that I'm missing. But if it's the only one,
> and the fence-combining pattern you're describing is common to multiple
> drivers, we can provide a container implementation that's not a
> fence_array, so you can use it to insert driver fences into other
> containers. This way we wouldn't force the proxy model to all drivers,
> but we would keep the code generic/re-usable.
> 
> > 
> > > behind the container extraction is so fences coming from the same
> > > context/timeline can be detected and merged. If you insert the
> > > container through a proxy, you're defeating the whole fence merging
> > > optimization.  
> > 
> > Right. Finished fences have single timeline too...
> 
> Aren't you faking a single timeline though if you combine fences from
> different engines running at their own pace into a container?
> 
> > 
> > > 
> > > The second thing is that I'm not sure drivers were ever supposed to
> > > return fence containers in the first place, because the whole idea
> > > behind a fence context is that fences are emitted/signalled in
> > > seqno-order, and if the fence is encoding the state of multiple
> > > timelines that progress at their own pace, it becomes tricky to control
> > > that. I guess if it's always the same set of timelines that are
> > > combined, that would work.  
> > 
> > Xe does this is definitely works. We submit to multiple rings, when all
> > rings signal a seqno, a chain or array signals -> finished fence
> > signals. The queues used in this manor can only submit multiple ring
> > jobs so the finished fence timeline stays intact. If you could a
> > multiple rings followed by a single ring submission on the same queue,
> > yes this could break.
> 
> Okay, I had the same understanding, thanks for confirming.
> 

I think the last three comments are resolved here—it’s a queue timeline.
As long as the queue has consistent rules (i.e., submits to a consistent
set of rings), this whole approach makes sense?

> > 
> > >   
> > > > One example is when a single job submits work to multiple rings
> > > > that are flipped in hardware at the same time.  
> > > 
> > > We do have that in Panthor, but that's all explicit: in a single
> > > SUBMIT, you can have multiple jobs targeting different queues, each of
> > > them having their own set of deps/signal ops. The combination of all the
> > > signal ops into a container is left to the UMD. It could be automated
> > > kernel side, but that would be a flag on the SIGNAL op leading to the
> > > creation of a fence_array containing fences from multiple submitted
> > > jobs, rather than the driver combining stuff in the fence it returns in
> > > ::run_job().  
> > 
> > See above. We have a dedicated queue type for these type of submissions
> > and single job that submits to the all rings. We had multiple queue /
> > jobs in the i915 to implemented this but it turns out it is much cleaner
> > with a single queue / singler job / multiple rings model.
> 
> Hm, okay. It didn't turn into a mess in Panthor, but Xe is likely an
> order of magnitude more complicated that Mali, so I'll refrain from
> judging this design decision.
> 

Yes, Xe is a beast, but we tend to build complexity into components and
layers to manage it. That is what I’m attempting to do here.

> > 
> > >   
> > > > 
> > > > Another case is late arming of hardware fences in run_job (which many
> > > > drivers do). The proxy fence is immediately available at arm time and
> > > > can be installed into dma-resv or syncobjs even though the actual
> > > > hardware fence is not yet available. I think most drivers could be
> > > > refactored to make the hardware fence immediately available at run_job,
> > > > though.  
> > > 
> > > Yep, I also think we can arm the driver fence early in the case of
> > > JobQueue. The reason it couldn't be done before is because the
> > > scheduler was in the middle, deciding which entity to pull the next job
> > > from, which was changing the seqno a job driver-fence would be assigned
> > > (you can't guess that at queue time in that case).
> > >   
> > 
> > Xe doesn't need to late arming, but it look like multiple drivers to
> > implement the late arming which may be required (?).
> 
> As I said, it's mostly a problem when you have a
> single-HW-queue:multiple-contexts model, which is exactly what
> drm_sched was designed for. I suspect early arming is not an issue for
> any of the HW supporting FW-based scheduling (PVR, Mali, NVidia,
> ...). If you want to use drm_dep for all drivers currently using
> drm_sched (I'm still not convinced this is a good idea to do that
> just yet, because then you're going to pull a lot of the complexity
> we're trying to get rid of), then you need late arming of driver fences.
> 

Yes, even the hardware scheduling component [1] I hacked together relied
on no late arming. But even then, you can arm a dma-fence early and
assign a hardware seqno later in run_job()—those are two different
things.

[1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/22c8aa993b5c9e4ad0c312af2f3e032273d20966#line_7c49af3ee_A319

> > 
> > > [...]
> > >   
> > > > > > > + * **Reference counting**
> > > > > > > + *
> > > > > > > + * Jobs and queues are both reference counted.
> > > > > > > + *
> > > > > > > + * A job holds a reference to its queue from drm_dep_job_init() until
> > > > > > > + * drm_dep_job_put() drops the job's last reference and its release callback
> > > > > > > + * runs. This ensures the queue remains valid for the entire lifetime of any
> > > > > > > + * job that was submitted to it.
> > > > > > > + *
> > > > > > > + * The queue holds its own reference to a job for as long as the job is
> > > > > > > + * internally tracked: from the moment the job is added to the pending list
> > > > > > > + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks the put_job
> > > > > > > + * worker, which calls drm_dep_job_put() to release that reference.    
> > > > > > 
> > > > > > Why not simply keep track that the job was completed, instead of relinquishing
> > > > > > the reference? We can then release the reference once the job is cleaned up
> > > > > > (by the queue, using a worker) in process context.    
> > > > 
> > > > I think that’s what I’m doing, while also allowing an opt-in path to
> > > > drop the job reference when it signals (in IRQ context)  
> > > 
> > > Did you mean in !IRQ (or !atomic) context here? Feels weird to not
> > > defer the cleanup when you're in an IRQ/atomic context, but defer it
> > > when you're in a thread context.
> > >   
> > 
> > The put of a job in this design can be from an IRQ context (opt-in)
> > feature. xa_destroy blows up if it is called from an IRQ context,
> > although maybe that could be workaround.
> 
> Making it so _put() in IRQ context is safe is fine, what I'm saying is
> that instead of doing a partial immediate cleanup, and the rest in a
> worker, we can just defer everything: that is, have some
> _deref_release() function called by kref_put() that would queue a work
> item from which the actual release is done.
> 

See below.

> > 
> > > > so we avoid
> > > > switching to a work item just to drop a ref. That seems like a
> > > > significant win in terms of CPU cycles.  
> > > 
> > > Well, the cleanup path is probably not where latency matters the most.  
> > 
> > Agree. But I do think avoiding a CPU context switch (work item) for a
> > very lightweight job cleanup (usually just drop refs) will save of CPU
> > cycles, thus also things like power, etc...
> 
> That's the sort of statements I'd like to be backed by actual
> numbers/scenarios proving that it actually makes a difference. The

I disagree. This is not a locking micro-optimization, for example. It is
a software architecture choice that says “do not trigger a CPU context
to free a job,” which costs thousands of cycles. This will have an
effect on CPU utilization and, thus, power.

> mixed model where things are partially freed immediately/partially
> deferred, and sometimes even with conditionals for whether the deferral
> happens or not, it just makes building a mental model of this thing a
> nightmare, which in turn usually leads to subtle bugs.
> 

See above—managing complexity in components. This works in both modes. I
refactored Xe so it also works in IRQ context. If it would make you feel
better, I can ask my company commits CI resources so non-IRQ mode
consistently works too—it’s just a single API flag on the queue. But
then maybe other companies should also commit to public CI.

> > 
> > > It's adding scheduling overhead, sure, but given all the stuff we defer
> > > already, I'm not too sure we're at saving a few cycles to get the
> > > cleanup done immediately. What's important to have is a way to signal
> > > fences in an atomic context, because this has an impact on latency.
> > >   
> > 
> > Yes. The signaling happens first then drm_dep_job_put if IRQ opt-in.
> > 
> > > [...]
> > >   
> > > > > > > + /*
> > > > > > > + * Drop all input dependency fences now, in process context, before the
> > > > > > > + * final job put. Once the job is on the pending list its last reference
> > > > > > > + * may be dropped from a dma_fence callback (IRQ context), where calling
> > > > > > > + * xa_destroy() would be unsafe.
> > > > > > > + */    
> > > > > > 
> > > > > > I assume that “pending” is the list of jobs that have been handed to the driver
> > > > > > via ops->run_job()?
> > > > > > 
> > > > > > Can’t this problem be solved by not doing anything inside a dma_fence callback
> > > > > > other than scheduling the queue worker?
> > > > > >     
> > > > 
> > > > Yes, this code is required to support dropping job refs directly in the
> > > > dma-fence callback (an opt-in feature). Again, this seems like a
> > > > significant win in terms of CPU cycles, although I haven’t collected
> > > > data yet.  
> > > 
> > > If it significantly hurts the perf, I'd like to understand why, because
> > > to me it looks like pure-cleanup (no signaling involved), and thus no
> > > other process waiting for us to do the cleanup. The only thing that
> > > might have an impact is how fast you release the resources, and given
> > > it's only a partial cleanup (xa_destroy() still has to be deferred), I'd
> > > like to understand which part of the immediate cleanup is causing a
> > > contention (basically which kind of resources the system is starving of)
> > >   
> > 
> > It was more of once we moved to a ref counted model, it is pretty
> > trivial allow drm_dep_job_put when the fence is signaling. It doesn't
> > really add any complexity either, thus why I added it is.
> 
> It's not the refcount model I'm complaining about, it's the "part of it
> is always freed immediately, part of it is deferred, but not always ..."
> that happens in drm_dep_job_release() I'm questioning. I'd really
> prefer something like:
> 

You are completely missing the point here.

Here is what I’ve reduced my job put to:

188         xe_sched_job_free_fences(job);
189         dma_fence_put(job->fence);
190         job_free(job);
191         atomic_dec(&q->job_cnt);
192         xe_pm_runtime_put(xe);

These are lightweight (IRQ-safe) operations that never need to be done
in a work item—so why kick one?

Matt

> static void drm_dep_job_release()
> {
> 	// do it all unconditionally
> }
> 
> static void drm_dep_job_defer_release()
> {
> 	queue_work(&job->cleanup_work);
> }
> 
> static void drm_dep_job_put()
> {
> 	kref_put(job, drm_dep_job_defer_release);
> }
