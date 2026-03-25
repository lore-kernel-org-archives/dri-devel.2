Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BBD103A99F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E86E10E6B2;
	Wed, 25 Mar 2026 02:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NaP447HN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D6810E6B0;
 Wed, 25 Mar 2026 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774406007; x=1805942007;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+AaRUMBNdNXrnBmY0Z9KTWrLhR56V9hB70vKPh7qNTg=;
 b=NaP447HNiw2t4T4SoBEzo31PkCcBTJ6QX64iwLYF6oj9qJo9BnaPb1Z7
 OaEqz2Pwy6u0+Rqf2Y7S5oxVW53Kt1xVoFNbAhHDP8okE9u8q0fqPOG6t
 1k/Zktshm9P5rsc3jMw0krZGf4ZsJQLuNlKlK26isfRJhl/7ZGEObI1+B
 CLSRbVQ2fO9sQzlsweu6sjn89ZOl1FC7ZKbnMEkhxAei5xoAvOFk2q4D4
 02KS2dfA4ZwO2aUMdHUFiG7EAoQ8oW2y4ZKJTTxDBca+fBastUuE2GaMh
 Bn9gMDWERosfGdLtLEDv0Zryl9D+eyHY9Zk/cff+jApgIsDoToBwOSkGm A==;
X-CSE-ConnectionGUID: j3XBAG1ASEyqt4NM1+NeSQ==
X-CSE-MsgGUID: yQnP2/iVQ2S8dBYdo68uvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86512172"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="86512172"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 19:33:26 -0700
X-CSE-ConnectionGUID: xAzzWQgpSaOBh4QDyk9b3Q==
X-CSE-MsgGUID: FamTVoOyTaGwyGYh39fVHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="229311772"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 19:33:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:33:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 19:33:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEo8eNdipw97DD1X8h9ymZvgp6jIY8Za3nbnwRvvnOJvvSPUgkADwVQ9/qGOvc3Yt1hn4UOaGSvGjcu32/t9OBj0NvK2YuAoUbJtMstg8G7kFG5rrzJjVLkZf6ptzwOPwC+beSRxySnMjxXkVHnazUej/cZ9+jgR85FDCbWOhiBw3dxzE5XEqMO1p/HnGnjcWiMIULdnQuzvazKAka+J3b9pqLJeCBCGaZ6YNiph3Gwzl4fS2sJNiSWt8VWIPpafnNfVxLQ+GhzSX8TW+Mrc/v+ZvzrplwV0L3+3TmMtMJk7yVU1fRntBnC6VQWGHBk9sNSwTrrBajqXOjDphMAY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQydzpdDNZ86lRkJkAvB05+XCHNMI8pOuhZYTqTHnPE=;
 b=SAUO7W5V98ngViMBdYYa7MqseVuL0GBbggupuQB/XiwcvLisVwsoX0Z8jSOsjDgg65aaXqVSn6H4Pu4XeF/KswZnrjkMV84A1DW+3380rTN5Ff/SzZm4vDODdj8krg4wIu2H5BRaNOLCC3vnfdOpOgTRzOCSrDMdKcDSmoR7fg3R4pwduJDujac2rWEHOSPPQkbV0mUj3p3ZsM/Zkohjiqfv2YYKcQQ9iSYvtvuDkVkljf8Nqo04g6FN2Ed3q96JKpa9u5cTOvES/qLlFpaIJkwtyNF8ZMh73zb/LXjm9omO1kQuYOKlDv+1z102oVeOYzuADEmNnRWYRVVi3KHRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH3PPFC15E4803C.namprd11.prod.outlook.com (2603:10b6:518:1::d4a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:33:19 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:33:19 +0000
Date: Tue, 24 Mar 2026 19:33:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acNJa4W2qndtbxJg@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
 <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
 <acGIjjLXuxUzv3aI@lstrano-desk.jf.intel.com>
 <20260324102345.17742bef@fedora>
 <acK2apOn5DMJFb1+@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acK2apOn5DMJFb1+@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH3PPFC15E4803C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1431a496-be4f-4750-58e0-08de8a16e037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BZhBwIVQHHSc7T84lU3iJJ87ar+AG0RdJMROO9Nqd9m7LOnWmIDy8pFHx7f+L6gOFoW9nNOenJGrC021N+i7MsaqghKg8A9vP3lyURbsSqB5/Ngf9QXaBYTf8GI0P6CzvOm+NAq1p+fLCvBia81FAts12EHlhoT+nB2S9ipkqVqHDZckg4Pa3BU1uTKsSLs+TWTBmnH0LLR9BLc6+MP9HLLDNnmDgHaNqGvQfhiO21Og0DgrwEE+tsB3Col5iI3Uqq5EzvOi3Nf6wA/xZOEUFtlUuASVBH6M8+Px2iLkbxKajSNueOi/fIuNtB3C8RQ1tJQpgq+qMlQJ0TCybz/C7KeDU7S3Pqjpdk/IlyNNhZeFDaNVaDQnPhmjKxsGKof5Yqc3bDCVBC1RCQc7rYfktXiqsniwlpbhtO0qB5iWRXkz9MsnKOMN0F8Q0HNPsvJD/o1G5akZABzkEd60MWEeAKMKldg/xgXDpVzzYDbEBVDiFMxfLxu9DbQYho76giQucIlnVoCQiZWwc1IfpriHmCHY45H8n2HgfVeH+IytB6vx5wD2BfILjYmD5ABOwK+ByaKZzAhXZm3qIT86EXdx1iFZaGjpg51yNrv9k8Z+6cqSgjDkuRD2DsYDkyIacaMRrvHqTtRoB5PL9weeB0r+aOU6oHyGBQ2ACfGDXc1c/f/JQeR5gYkYkFjN6dWnaMRinAE9vumer/kial5msktD5uqvwMrlTPSoPjXdFGqjsOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJRSlQzUk1BL29nQWpIYlM3VnZqUm9BQmNVOEdVcEFmK3JtQUJtZlIrYmxn?=
 =?utf-8?B?ZnVsazNxY2hLVjFRYzJTSjFDZmszKzJqNDRCSjU1ZWxxV0ZPcGsxOFNpQlZO?=
 =?utf-8?B?ZUVlaWFSczZ0UFVrT3RoWS9CVUh2aTZEbFBEdWlGUks5MHJ2amxmQ2Z5dUhQ?=
 =?utf-8?B?ekdLWTJ1SWNVZENRWGJlVndiVmdOTDN3enlDQUNMUDg4eTRXc3JxS1ZnRTI0?=
 =?utf-8?B?b2MrVExkUnAxMEZNQVN0cGwvL2t5dnI0UVNKZzlzUXVrT3VCQkxDclFUdXBI?=
 =?utf-8?B?OTZWb25LcGI0S1FPcHN3cUx2dTN3bWJRSVBkT2hIby9qc2p6MGpCV0ZkdW5h?=
 =?utf-8?B?T1RnLzhFT285bmtETkN5MExwd2Z1ZzhMTVlTamFob0JLSHFGTXhJZjhHYkEw?=
 =?utf-8?B?UDY4aENhZC9KTFhJRm5ENlhIYVkvY0pwS3VuTmlpMmlaT3FPeU9aMk1YR0tC?=
 =?utf-8?B?blJ6S09uQkkwbTFlVDl4Z0IvMHNvclBBTE03RTRhY0JPVTNzYjY4S2VuU3pJ?=
 =?utf-8?B?c1ZVNlRjUzQ2bktVeXA4TEJqalFQTlYrRCsxeTJENk9tMm5hdGtqL05tTzJM?=
 =?utf-8?B?ek9sb3c2WG9OaDhpQmFDK2V4cnFQM25XZStZVU55WmZ1aDZpVzhpb0pab3VZ?=
 =?utf-8?B?Z01hcUUvdGF0R25haDRJQkwrb1hRYi81dG1mMnZrZjFnaktkNVJwVEVrRHNl?=
 =?utf-8?B?RlF0NW9ha0pPUnBrMy9HdzE3OEQzSU5aejNGbnBieFBMUFpLeXNrb0R3OHd4?=
 =?utf-8?B?YXZDaXJ3Qi92ajA1bVF3YjFmdWEvSFRZUWZBVjlCMTZ6OTJ1NzUxbnBjQ0xV?=
 =?utf-8?B?bG9QTjVzOFQ5ODdUOUw4UksrczY3YXA4Qlo4WXpNN01SRmJ3YkJ3Wk95aDNN?=
 =?utf-8?B?OFBuWWpDcWtnR3dtRlpGUlhJemc5Ulo5ZkdTT1puTTBreVJxRHNFTC9BZFlu?=
 =?utf-8?B?QTVUVWE2ZThEV2ltV1d2UkNHNkNQZDdSbHRNUmNEYzU1SElhNzlzWldOWFRU?=
 =?utf-8?B?amRFdmg3OERlS0lzcng0bjFSZWpnaGRNaEpRMFUydFl4YUQ1YkNhM3MyRzha?=
 =?utf-8?B?UHZYTE1hVjFWbVc3cmFzT2huSm12VmU1emJtS2o4Q1ZWOTN1WlJKa09ZaTF0?=
 =?utf-8?B?cjEzRmZzZ1g3aERlSDI4WVlmL2FvbktybTY4RXhKSUxvZkNmclBKeFhVYXRS?=
 =?utf-8?B?dUF4dUU2MnBSZkVUSzhIKzB2MVlpRkgzbzdEemFIOEZENmFmejNvbU5tN2c0?=
 =?utf-8?B?Tnp0S0MwUTMxWktraVdZQ2QwNTk0T0JaWUFUWEZZV1NoZnFEU0xmbk00UXU4?=
 =?utf-8?B?ZTZBSGxaUXV5M3FPR2xkSkxINEdlOTc2UEN4RFZ4T1BqaE5XTVRtRFErY0p6?=
 =?utf-8?B?Snd0WFZzWWtUT0VDZjUvWTlSalJLZ1Y5SFVTVjc5SzdDWkVXL01SN0o0SUFz?=
 =?utf-8?B?eStVTndTeitiQVhnVmVEenVnMzY5Szg3bWhiMXVQSTBINmR1MVNsbW9Gempv?=
 =?utf-8?B?dGVPWE14QWJ2UDlybWdCUW9FTy9ZNitTM0t1aUF3OFVNVlZGblF3WENMd1d3?=
 =?utf-8?B?U2R5QXdFVjI3UEdkR0dKY21SdzY1emR6dm9ldVg1OEdna0IxVTNpTUxDT3hK?=
 =?utf-8?B?eEovekNuVXBNS1VzUnBhekhndVlCTkpCT1VROTFDczhUTG4xNlJ5VlJ0a0lN?=
 =?utf-8?B?YjdHSDZtUC96Mjl3WGllYjRsWmNZaWtWTE5IdEgzeHZXcUNrM0FUV002YzYy?=
 =?utf-8?B?YSs2WktYc0d0Zk1DQTg2RmszbWFRdERqYTdNck5LR2UrTThRK2l1eE5IUHY2?=
 =?utf-8?B?R3N4OTdVR0xoQkFCWThHcVRQWmNabnZocUNVVDFNcmEzV2JVcEtNa1R2YU5H?=
 =?utf-8?B?a0F3RWN2MTEwQWluQTZhS3gyeHlTZzMwMnI2RGpYdmZnbS9GRTJXemVISVFE?=
 =?utf-8?B?clFXSmFmRVgvMFkzV2U3Q2U2VXRON3NVYWpBMHA5WUNyNUJ4aGdLSGVPcGhi?=
 =?utf-8?B?N091SDFNdlNTUFNXUTBldXQ4SEhSb2FJZ28xV2tyZ1V3d09ML2U5TmtvaU9M?=
 =?utf-8?B?dEtTNDlFeU5LT2NmOUJOSDIxaFQyVkVBckdkR3RxdWlGaXg1Qm94dDhiaDli?=
 =?utf-8?B?MWk0cWlkZ01WS3YvUjJUd1JOL3N4bXViT2M2Zyt1MVE2c05CZnN2S3hweGla?=
 =?utf-8?B?dTZuaENxQ2xaVkFvelY0NUx0T2dKRWpwYWVEQnhnYk9WTnBLWGQ5UHd4WmJh?=
 =?utf-8?B?aVNBRWl0eFpJOTdiQUZkcjE1Q3M5ODlQc05RR2hST1RPVnZ5QTZhcEMxNGI0?=
 =?utf-8?B?bGIrNmNrSWJ2VWkzVzczam1UWXA4QnAzeTZjSjcwdGJiOU81OEFINkN1NVBw?=
 =?utf-8?Q?XDv0H/EEkN2D2g6k=3D?=
X-Exchange-RoutingPolicyChecked: mjQZf1hApGljlBJGHb480fFTpEhvUbwAvh9mFTxdLRH36SJKNr8/9TkxlOo9v/7xutl1IAv3xsQ++5ae33n7z29XoKLX2yqFGDKSPAgwueh75XWTMVU8d5zvojnNyFOHe8HwJqWEYZcOvOgvWDLVpr3lmxjpoBs76eCKZeusK1uU/nvA/FFt6dj6/poicRyoOU7KwHjaWgKluxtyp4PztAdB6WkvuzDL/agOoa6JDelZ68+6mGk9ySHMZnfm5MAf45FRQF+uJMaRWeSFUpmVynyAs9ga7zw2Vxfdyw9czSJuH7XZt6KABadta22rugVyRTuYCJXfkjmrzmMSGOsDqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1431a496-be4f-4750-58e0-08de8a16e037
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:33:19.2015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgmlmFhSWA4h3ha7yZ/8EI2WfsfbwnWph41QQwWJRhuQdDv1moyUXbB8OqADWbb+ztpxirfr8wtGn6yndbjj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC15E4803C
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

On Tue, Mar 24, 2026 at 09:06:02AM -0700, Matthew Brost wrote:
> On Tue, Mar 24, 2026 at 10:23:45AM +0100, Boris Brezillon wrote:
> > On Mon, 23 Mar 2026 11:38:06 -0700
> > Matthew Brost <matthew.brost@intel.com> wrote:
> > 
> > > 
> > > Ok, getting stats is easier than I thought...
> > > 
> > > ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions /home/mbrost/xe/source/drivers.gpu.i915.igt-gpu-tools/build/tests/xe_exec_threads --r threads-basic
> > > 
> > > This test creates one thread per engine instance (7 instances this BMG
> > > device) and submits 1k exec IOCTLs per thread, each performing a DW
> > > write. Each exec IOCTL typically does not have unsignaled input dependencies.
> > > 
> > > With IRQ putting of jobs off + no bypass (drm_dep_queue_flags = 0):
> > > 
> > >              8,449      context-switches
> > >                412      cpu-migrations
> > >           2,531.43 msec task-clock
> > >      1,847,846,588      cpu_atom/cycles/
> > >      1,847,856,947      cpu_core/cycles/
> > >    <not supported>      cpu_atom/instructions/
> > >        460,744,020      cpu_core/instructions/
> > > 
> > > With IRQ putting of jobs off + bypass (drm_dep_queue_flags =
> > > DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED):
> > > 
> > >              8,655      context-switches
> > >                229      cpu-migrations
> > >           2,571.33 msec task-clock
> > >        855,900,607      cpu_atom/cycles/
> > >        855,900,272      cpu_core/cycles/
> > >    <not supported>      cpu_atom/instructions/
> > >        403,651,469      cpu_core/instructions/
> > > 
> > > With IRQ putting of jobs on + bypass (drm_dep_queue_flags =
> > > DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED |
> > > DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE):
> > > 
> > >              5,361      context-switches
> > >                169      cpu-migrations
> > >           2,577.44 msec task-clock
> > >        685,769,153      cpu_atom/cycles/
> > >        685,768,407      cpu_core/cycles/
> > >    <not supported>      cpu_atom/instructions/
> > >        321,336,297      cpu_core/instructions/
> > 
> > Thanks for sharing those numbers. For completeness, can you also add the
> > "With IRQ putting of jobs on + no bypass" case?
> > 
> 
> Yes, I also will share a DRM sched baseline too + I figured out power
> can be measured too - initial results confirm what I expected too - less
> power.
> 
> I'm putting together a doc based on running glxgears and another
> benchmark on top Ubuntu 24.10 + Wayland which has explicit sync
> (linux-drm-syncobj, behaves like surfface flinger when rendering flag to
> not pass in fences to draw jobs).
> 
> Almost have all the data. Will share here once I have it.
> 

Here are some numbers based on glxgears and weston-simple-egl.

5 configurations tested:
DRM sched
DRM dep (no opt flags)
DRM dep + bypass flag
DRM dep + IRQ-safe flag
DRM dep + bypass + IRQ-safe flags

Each configuration was run 3× on both glxgears and weston-simple-egl.
Raptor lake CPU, BMG G21.

Summary:
DRM dep reduces power usage, CPU cycles, and context switches. Enabling
both the bypass and IRQ-safe flags further reduces all of these metrics.

I’d say this test case best models something like scrolling on a phone
or using a laptop for non-GPU-intensive workloads where the screen still
needs to refresh.

I’ve run more intensive benchmarks—glmark2 and Unigine Heaven as well.
The results are somewhat noisy between boots, but I think the same
conclusion holds.

Raw numbers (bit of a firehouse):

DRM sched:
root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
303 frames in 5.0 seconds = 60.565 FPS
300 frames in 5.0 seconds = 60.000 FPS
301 frames in 5.0 seconds = 60.001 FPS

 Performance counter stats for 'system wide':

            71,548        context-switches
             1,466        cpu-migrations
        320,440.96 msec   task-clock
     9,140,249,815        cpu_atom/cycles/
     9,140,253,058        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     7,071,794,806        cpu_core/instructions/
            168.76 Joules power/energy-pkg/
             57.78 Joules power/energy-cores/

      20.029126614 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.642 FPS
300 frames in 5.0 seconds = 59.988 FPS
301 frames in 5.0 seconds = 60.001 FPS

 Performance counter stats for 'system wide':

            71,720        context-switches
             1,581        cpu-migrations
        320,530.64 msec   task-clock
     8,990,313,521        cpu_atom/cycles/
     8,990,315,400        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,988,827,285        cpu_core/instructions/
            172.15 Joules power/energy-pkg/
             58.33 Joules power/energy-cores/

      20.034862844 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.741 FPS
299 frames in 5.0 seconds = 59.798 FPS
299 frames in 5.0 seconds = 59.799 FPS

 Performance counter stats for 'system wide':

            70,871        context-switches
             1,980        cpu-migrations
        320,558.82 msec   task-clock
     8,861,481,467        cpu_atom/cycles/
     8,861,485,448        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,665,294,516        cpu_core/instructions/
            167.82 Joules power/energy-pkg/
             56.97 Joules power/energy-cores/

      20.035713155 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            27,398        context-switches
               678        cpu-migrations
        160,255.17 msec   task-clock
     5,002,546,782        cpu_atom/cycles/
     5,002,549,920        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,498,672,077        cpu_core/instructions/
             93.41 Joules power/energy-pkg/
             23.91 Joules power/energy-cores/

      10.017552274 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            27,322        context-switches
               580        cpu-migrations
        160,307.12 msec   task-clock
     4,783,734,059        cpu_atom/cycles/
     4,783,737,645        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,224,510,206        cpu_core/instructions/
             91.89 Joules power/energy-pkg/
             23.28 Joules power/energy-cores/

      10.020629190 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            27,356        context-switches
               573        cpu-migrations
        160,362.30 msec   task-clock
     5,112,653,847        cpu_atom/cycles/
     5,112,658,503        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,395,873,668        cpu_core/instructions/
             94.40 Joules power/energy-pkg/
             24.58 Joules power/energy-cores/

      10.023979647 seconds time elapsed

No opt (drm_dep_queue_flags = 0):
root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
303 frames in 5.0 seconds = 60.597 FPS
300 frames in 5.0 seconds = 59.989 FPS
297 frames in 5.0 seconds = 59.232 FPS

 Performance counter stats for 'system wide':

            66,233        context-switches
             1,820        cpu-migrations
        320,586.39 msec   task-clock
     9,028,164,726        cpu_atom/cycles/
     9,028,178,052        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,541,478,243        cpu_core/instructions/
            178.47 Joules power/energy-pkg/
             44.18 Joules power/energy-cores/

      20.036849235 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.691 FPS
297 frames in 5.0 seconds = 59.393 FPS
300 frames in 5.0 seconds = 59.803 FPS

 Performance counter stats for 'system wide':

            68,389        context-switches
             2,034        cpu-migrations
        320,457.18 msec   task-clock
     8,736,092,056        cpu_atom/cycles/
     8,736,096,958        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,511,630,145        cpu_core/instructions/
            183.23 Joules power/energy-pkg/
             47.43 Joules power/energy-cores/

      20.031469459 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
303 frames in 5.0 seconds = 60.458 FPS
299 frames in 5.0 seconds = 59.606 FPS
298 frames in 5.0 seconds = 59.590 FPS

 Performance counter stats for 'system wide':

            67,692        context-switches
             1,877        cpu-migrations
        320,524.05 msec   task-clock
     8,837,946,224        cpu_atom/cycles/
     8,837,949,628        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,018,812,170        cpu_core/instructions/
            187.63 Joules power/energy-pkg/
             46.76 Joules power/energy-cores/

      20.034428856 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            27,259        context-switches
               313        cpu-migrations
        160,538.29 msec   task-clock
     5,079,653,975        cpu_atom/cycles/
     5,079,657,432        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,166,877,411        cpu_core/instructions/
             90.72 Joules power/energy-pkg/
             21.70 Joules power/energy-cores/

      10.034716719 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            26,933        context-switches
               449        cpu-migrations
        160,334.74 msec   task-clock
     4,851,027,105        cpu_atom/cycles/
     4,851,054,678        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,042,177,215        cpu_core/instructions/
             87.33 Joules power/energy-pkg/
             21.85 Joules power/energy-cores/

      10.021873082 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            27,101        context-switches
               351        cpu-migrations
        160,333.98 msec   task-clock
     4,903,047,240        cpu_atom/cycles/
     4,903,055,111        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     2,884,284,727        cpu_core/instructions/
             87.68 Joules power/energy-pkg/
             21.36 Joules power/energy-cores/

      10.021938190 seconds time elapsed

Bypass (drm_dep_queue_flags = DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED):
root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.718 FPS
299 frames in 5.0 seconds = 59.615 FPS
299 frames in 5.0 seconds = 59.795 FPS

 Performance counter stats for 'system wide':

            56,788        context-switches
             2,576        cpu-migrations
        320,610.02 msec   task-clock
     9,056,383,522        cpu_atom/cycles/
     9,056,385,629        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,285,652,796        cpu_core/instructions/
            164.29 Joules power/energy-pkg/
             44.70 Joules power/energy-cores/

      20.041318795 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.734 FPS
300 frames in 5.0 seconds = 59.983 FPS
300 frames in 5.0 seconds = 60.000 FPS

 Performance counter stats for 'system wide':

            56,388        context-switches
             2,326        cpu-migrations
        320,581.07 msec   task-clock
     8,789,215,827        cpu_atom/cycles/
     8,789,217,484        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,251,346,200        cpu_core/instructions/
            162.67 Joules power/energy-pkg/
             44.30 Joules power/energy-cores/

      20.037648324 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
305 frames in 5.0 seconds = 60.950 FPS
300 frames in 5.0 seconds = 59.993 FPS
300 frames in 5.0 seconds = 59.806 FPS

 Performance counter stats for 'system wide':

            56,167        context-switches
             2,434        cpu-migrations
        320,594.69 msec   task-clock
     8,700,873,664        cpu_atom/cycles/
     8,700,877,150        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,405,556,662        cpu_core/instructions/
            162.55 Joules power/energy-pkg/
             43.33 Joules power/energy-cores/

      20.038448851 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            24,747        context-switches
             1,254        cpu-migrations
        160,543.42 msec   task-clock
     5,047,832,024        cpu_atom/cycles/
     5,047,823,996        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,124,591,155        cpu_core/instructions/
             80.28 Joules power/energy-pkg/
             21.49 Joules power/energy-cores/

      10.034654628 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            24,953        context-switches
               921        cpu-migrations
        160,375.32 msec   task-clock
     5,197,283,835        cpu_atom/cycles/
     5,197,287,623        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,393,363,950        cpu_core/instructions/
             83.36 Joules power/energy-pkg/
             21.92 Joules power/energy-cores/

      10.024899366 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
298 frames in 5 seconds: 59.599998 fps

 Performance counter stats for 'system wide':

            24,576        context-switches
               966        cpu-migrations
        160,339.37 msec   task-clock
     4,915,705,971        cpu_atom/cycles/
     4,915,709,503        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     2,968,947,722        cpu_core/instructions/
             79.96 Joules power/energy-pkg/
             21.08 Joules power/energy-cores/

      10.022743041 seconds time elapsed

IRQ (drm_dep_queue_flags = DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE):
root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.643 FPS
298 frames in 5.0 seconds = 59.599 FPS
295 frames in 5.0 seconds = 58.998 FPS

 Performance counter stats for 'system wide':

            60,305        context-switches
             1,994        cpu-migrations
        320,528.79 msec   task-clock
     8,518,549,937        cpu_atom/cycles/
     8,518,573,906        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     5,813,890,066        cpu_core/instructions/
            184.52 Joules power/energy-pkg/
             40.79 Joules power/energy-cores/

      20.032795872 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.759 FPS
299 frames in 5.0 seconds = 59.790 FPS
301 frames in 5.0 seconds = 60.003 FPS

 Performance counter stats for 'system wide':

            59,401        context-switches
             2,256        cpu-migrations
        320,475.03 msec   task-clock
     8,581,759,828        cpu_atom/cycles/
     8,581,763,986        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,748,269,548        cpu_core/instructions/
            179.76 Joules power/energy-pkg/
             40.66 Joules power/energy-cores/

      20.029861532 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.653 FPS
298 frames in 5.0 seconds = 59.404 FPS
300 frames in 5.0 seconds = 59.990 FPS

 Performance counter stats for 'system wide':

            59,381        context-switches
             1,800        cpu-migrations
        320,616.35 msec   task-clock
     8,829,473,025        cpu_atom/cycles/
     8,829,477,019        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,505,926,710        cpu_core/instructions/
            180.38 Joules power/energy-pkg/
             40.86 Joules power/energy-cores/

      20.040016190 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
298 frames in 5 seconds: 59.599998 fps

 Performance counter stats for 'system wide':

            27,341        context-switches
               786        cpu-migrations
        160,478.01 msec   task-clock
     4,681,440,843        cpu_atom/cycles/
     4,681,443,905        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     2,969,039,615        cpu_core/instructions/
             91.74 Joules power/energy-pkg/
             20.84 Joules power/energy-cores/

      10.031116623 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            24,626        context-switches
               429        cpu-migrations
        160,367.44 msec   task-clock
     4,828,015,355        cpu_atom/cycles/
     4,828,019,887        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     2,675,419,833        cpu_core/instructions/
             90.35 Joules power/energy-pkg/
             21.10 Joules power/energy-cores/

      10.024476921 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            24,679        context-switches
               340        cpu-migrations
        160,303.90 msec   task-clock
     4,500,129,961        cpu_atom/cycles/
     4,500,132,697        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     2,766,150,592        cpu_core/instructions/
             88.01 Joules power/energy-pkg/
             19.76 Joules power/energy-cores/

      10.019653353 seconds time elapsed

IRQ plus bypass (drm_dep_queue_flags = DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED | DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE):
root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
305 frames in 5.0 seconds = 60.958 FPS
299 frames in 5.0 seconds = 59.607 FPS
299 frames in 5.0 seconds = 59.603 FPS

 Performance counter stats for 'system wide':

            46,934        context-switches
             1,558        cpu-migrations
        320,569.83 msec   task-clock
     7,976,414,449        cpu_atom/cycles/
     7,976,417,934        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,126,973,947        cpu_core/instructions/
            178.36 Joules power/energy-pkg/
             40.10 Joules power/energy-cores/

      20.037681420 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
304 frames in 5.0 seconds = 60.696 FPS
299 frames in 5.0 seconds = 59.616 FPS
299 frames in 5.0 seconds = 59.781 FPS

 Performance counter stats for 'system wide':

            47,691        context-switches
             1,994        cpu-migrations
        320,602.83 msec   task-clock
     8,270,567,663        cpu_atom/cycles/
     8,270,572,484        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     4,361,204,861        cpu_core/instructions/
            181.56 Joules power/energy-pkg/
             40.16 Joules power/energy-cores/

      20.038511163 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 20s glxgears
Running synchronized to the vertical refresh.  The framerate should be
approximately the same as the monitor refresh rate.
305 frames in 5.0 seconds = 60.911 FPS
298 frames in 5.0 seconds = 59.597 FPS
300 frames in 5.0 seconds = 59.803 FPS

 Performance counter stats for 'system wide':

            47,129        context-switches
             1,921        cpu-migrations
        320,491.09 msec   task-clock
     8,054,513,204        cpu_atom/cycles/
     8,054,518,711        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     6,131,796,639        cpu_core/instructions/
            178.54 Joules power/energy-pkg/
             40.08 Joules power/energy-cores/

      20.032444923 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            21,991        context-switches
               286        cpu-migrations
        160,343.73 msec   task-clock
     4,497,475,288        cpu_atom/cycles/
     4,497,477,011        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,042,007,163        cpu_core/instructions/
             89.14 Joules power/energy-pkg/
             20.09 Joules power/energy-cores/

      10.021642254 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
300 frames in 5 seconds: 60.000000 fps

 Performance counter stats for 'system wide':

            22,366        context-switches
               225        cpu-migrations
        160,386.68 msec   task-clock
     4,398,432,348        cpu_atom/cycles/
     4,398,435,205        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,086,156,274        cpu_core/instructions/
             89.07 Joules power/energy-pkg/
             19.68 Joules power/energy-cores/

      10.024827902 seconds time elapsed

root@DUT6235BMGFRD:mbrost# ./perf stat -a -e context-switches,cpu-migrations,task-clock,cycles,instructions,power/energy-pkg/,power/energy-cores/ timeout 10 weston-simple-egl -f
Using config: r8g8b8a8
has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
has EGL_EXT_surface_compression
299 frames in 5 seconds: 59.799999 fps

 Performance counter stats for 'system wide':

            22,515        context-switches
               286        cpu-migrations
        160,481.91 msec   task-clock
     4,447,740,222        cpu_atom/cycles/
     4,447,743,314        cpu_core/cycles/
   <not supported>        cpu_atom/instructions/
     3,217,285,071        cpu_core/instructions/
             90.15 Joules power/energy-pkg/
             19.65 Joules power/energy-cores/

      10.029135743 seconds time elapsed

Matt

> > I'm a bit surprised by the difference in number of context switches
> > given I'd expect the local-CPU to be picked in priority, and so queuing
> > work items on the same wq from another work item to be almost free in
> > term on scheduling. But I guess there's some load-balancing happening
> > when you execute jobs at such a high rate.
> > 
> > Also, I don't know if that's just noise or if it's reproducible, but
> > task-clock seems to be ~40usec lower with the deferred cleanup and
> > no-bypass (higher throughput because you're not blocking the dequeuing
> > of the next job on the cleanup of the previous one, I suspect).
> 
> I think that is just noise of what the test is doing in user space -
> that bounces around a bit.
> 
> Matt
> 
> > 
