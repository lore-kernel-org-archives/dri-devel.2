Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB37EC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CEF10E21C;
	Mon, 21 Sep 2026 06:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lyGBOwxj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC80A10E21C;
 Mon, 21 Sep 2026 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789973214; x=1821509214;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ve1vSlrafNCM7HngTjGV23jrGqrZVb3YfVhVACNL12g=;
 b=lyGBOwxjePA1E9SWUKXJ86orskr7eOQFSufw0X6mh2TyFSEhlk9FcJl8
 2bw0a45c5ccrIK6vaHkuqpaW1NDqfxWNKDS9o5E+2+gwuKUxFkRC8dvGI
 HT1LZt0z23VHLU4fuYZJ27huwllVdauDdq5B4XKN0xc5iCdR9y4+a5Nt1
 Mutot6CHGP2qytRlZ4XGxbOGvtg6BoTQZwR+9bM4coX0w3LP2QZ07WLz8
 AA0GUsrArdAqqJw590gaukG7HdqyYrNX2+LO3S4YazJ7v3GE+maZKxFkz
 uKku2vyKJAkbnrM78kLTfIk+WiC3RENWsMPQmMDr/U/1RcV56LPsx9gXE Q==;
X-CSE-ConnectionGUID: 4LqqcVXyQqaT2TxcfRkvqw==
X-CSE-MsgGUID: 07Q8fu2ASNCYhacWAEYPWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90591725"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90591725"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:46:53 -0700
X-CSE-ConnectionGUID: EA4eNzEYTvq+ePl+T7jDhA==
X-CSE-MsgGUID: tKUQ5v5OTVyJ3g+9G7rAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3827678"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:46:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 23:46:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 23:46:52 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 23:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOzczvuBtLOwSlV4c6qPMcZ3Uo1n8Y/VR91NifKrqSGlNfL+afHoTOYrdsTHiR7DdV9mlv7Eo2JRkEwvT1n7zRJGmM9il/j3nQljqvfYA27qgMJLdzVF+C7kcgcBi0PV5RvOQz15qRip6SjqDDwaCbmJ7RXx7TQYbRRQ5bm5Asi4xJWZa7RuKHb/esLlbBDKORGb479JnfRAY8E2ptekWV56W6DzarWx7YrkL82cEGCzRm/OZ+J1XWnmPnJZG2aDplNvgIV+T9KKXCAR7ziL+dNUcvJ27o6ZGvame2Jcpr0ftXfJ32M/zSLR7rZc7skJUccj7SDc8sl38/PTgOD7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SB7AjeeWrrTEdx+LAoJdJr24PEXPYoKssBMe75l19w=;
 b=EP6C8PcqboTCVAhByUYjcFAGUIUiRQh9YXd42b3RU2OaCbe3K7TTZX2cMLepBuLOWW1Xyyu9jXaT7pKUIdntax1pa5HSk6gIUfWAAkESE+gdKytYcFy4Bvcwh5pYC4L8eSswY/1x9uIkxcZHkF9yAJBkA/TTdSUWemiN0YFKz2en754pc2ts7YOnLtb2RUyysoUXQn50h4D3g+W1paL7Bhmkz0+E1kUTOvAWUgXIZontPQ/2Sh/3r+ELNQaBX0pZMtKR3UttkrS6ez3DUTFdNbGyI+YqWQ2rzxD/qYgc3X4tJh0ZiLOqTeNCyOJ/vcGXmSWLPj2ds6D/KrY1Bf3vaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by DS4PR11MB983458.namprd11.prod.outlook.com (2603:10b6:8:508::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 06:46:50 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 06:46:50 +0000
Message-ID: <f8599648-660f-48ab-aa76-3b3b327b9346@intel.com>
Date: Mon, 21 Sep 2026 12:16:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/xe/guc: Wake disable waiters after clearing
 pending state
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-3-arvind.yadav@intel.com>
 <aq285SiT1wirY125@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <aq285SiT1wirY125@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0298.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::7) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|DS4PR11MB983458:EE_
X-MS-Office365-Filtering-Correlation-Id: 20882d36-3d96-46bb-57e1-08df17ac1d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l1GzS1pRxBDy4d6tZuWmzVH7JesffwJk8cxQrZdE9Sp8Xjfu1V5bDeheZNWjWy8brCsRH29/Va4Bucu91l3i04eyvre3O1UezBdZ+irf3qm0eov1Y/Bd3N07n+dIJpIsguViwFenEEbY+0skWLqjmjpyCpLH+tGxBrMclDXokHGC9dFkx+vprv3om5iZAiij+AP0rTbL1w6K+VbMH2qIgoyfZHAXJybLOhYNYJ47Afl5UsxSOydEFu7Y9h2px6+6yqujAeGlxpV7noghIM/fCq4PvUZF1/Wm1yscq31d8mI7hJ3g9Odx3gr4EK2szMV6KJfEAcDHUeOTI14SQQ9qF/y2riW3xRwC4IyIeyG7aJ94o0wjA+mRm+7CNgZxZcv5ax/Iqe1bryAJ3i1GJz8oU4rGEC1QyYuyROYngzIjFf1jbYeNXvnmFnPtxdp+Lw0XyMIFcTVvlX+yIWLJkN1PI8zgJP/QWtswjj9573XI/wcUv0HxzUiaLpEGZtRoUriQi6F7w77J+R98ph4N5hbreETdiDpTfkpkWAaHgMkXb7Mru3yhyY5tawr4N3kwkdtTE1tVzzonuD+FqGCRH+P+GI+f984FX+3r3LsdpXXjnrdK7vT3NmCBEansNYRbp1QO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmhqU2ZYcVpPdTNhMWdRSXJyS1p6MHVTaU00QTdlLzh1TjJacGR3alhUQjNp?=
 =?utf-8?B?TGNKdkF5bWd1bUVnblFzK3hpS0g5S050MWd1cUNQTjRnOGtmaFRxZS9FU0Ux?=
 =?utf-8?B?eUJuZkFtSktFcnp5QmZQWHJ5eXk3MmxFdHVtejZlVUNSaGl3cGRXTE9RYjBI?=
 =?utf-8?B?MjVEZy9IUHd5WjVwUC8rT2hzYi9hNjlPMmwybVRiVlR6UWMzUFlGNk1wOVlM?=
 =?utf-8?B?VEhuWUNJVG5ERWRHd0g1TVRtUkExaFRRTmxJMXVMU0xjMmdMRmsxckVKVlFx?=
 =?utf-8?B?bzVOMThBWUs4Ry9uVjlFWWdQYjFadFFJTUNVNjlWVWwweENKRU9xYXdacUlh?=
 =?utf-8?B?R2RIRS9uZk1uQi81NndUaFhPUSszTC8wZmlCcm5NUjJmRTZYZkNJRkczdjhB?=
 =?utf-8?B?SVZrNkZ1ZnhlMjZIL0tMWThiaWh2bGdTVXdMSWRIUEdmM1hJdnZYd2sxdWVq?=
 =?utf-8?B?K2hwbm1IQmlja0NHaG81dmJsRGlDU21XalJDM1FsWnNTdkQ3dHJxRGNGY2Ns?=
 =?utf-8?B?VWppUnM4SzloV1NuSGpLQ04vVmVJeHZnb3VpTVloTDlVc2l2MGh2K3E5c0pE?=
 =?utf-8?B?cW1iWXZSZC8xenRlTm40S1Q4S3c2dG54bzdSQmhoQ1lwTTg3aTFUbDJTN2Q4?=
 =?utf-8?B?VnJKSk90UGVlWEFzZXNmNVpGSFMzeHZRcGZSTGhvckdkL29CNEowNFo2NHdW?=
 =?utf-8?B?TThFamVCZ3liZlFTbWhlUkI1K09lcTlBaWZGVG0xT1lVWFp5VWJyVjhlL0w1?=
 =?utf-8?B?TER0VXB5TFFUWjYybFdJcWVGbjBraER6ZHRUMUdDQWVvTTI2NithSm52OGx1?=
 =?utf-8?B?S0tXUTR3RDc2OW1ub2ZWMXFIL1R0S0tzT2R5SEhGZnU3R0I2OXFzN0pObVVG?=
 =?utf-8?B?UE4rOGIrUVkrQjlGSnVFQmVYY1BWSzVCcHBWNkRQbFVKLzB4WUtGdnJxVmpZ?=
 =?utf-8?B?RVBmcU9JTmVNb0YvcFptcjZSbVB0Ykx5UmIwZldROHk0R0pHejRuWklxb3hV?=
 =?utf-8?B?T2ltdy85WVVvNWE2M0diR0xQek13MFhBTmhjNWJNR0JyV1lsbUJVZjA4RVl0?=
 =?utf-8?B?OEs1cDIzbzJYU0xjMmp0VjRHRVh4Tksrdk9ZcEw0c25GRGtqbUZFbld2UXJu?=
 =?utf-8?B?aVdUd0ZsN2hPTWZqLzhRSjZqcVVPU1RSYVk5NVhFUGc5elV2U3NuVFh3SkJy?=
 =?utf-8?B?cVpUYjE1aUtGbjRrOHNYbUdwZUFrNkNvcE43dmhheU5ncmdoTEZ0N01RNXY1?=
 =?utf-8?B?K3lJdzYvNDBvRVBDcFBEVldwakVwWVBFUFFYYkRndmtYMmU4ZkNDZk55aWVT?=
 =?utf-8?B?MFNVY05KVVpxdGZBcW5FWkhGUnR3ZDM0N0U5Y2lkZld0WUs2QXpkaVB2TmFN?=
 =?utf-8?B?REltVnFhamlockIyNnNRZnpSdi9vL1RLUnZ1a25heDFmQmpLTzRuRkp3ak9w?=
 =?utf-8?B?V2I5YzNNMm1SeDZyaEREUnRXTUh2RTU2bll1TStSSjE1Wnd4ZElTcklUWXhO?=
 =?utf-8?B?cllXSkJKUjJCRXBIcW1mUEVjKy9iL0NXV0kvQnhhVXA3TS91U09zYkx2cTVn?=
 =?utf-8?B?c29jMi91NXBRc1dra0hFRzRxZXNPeE9VamtLMDFKUFNTbktMNmxyVjNucjk3?=
 =?utf-8?B?MXlxNFZoVE1OZExHQ2NRUmo2cWptUzRTTHZTS2gwYU5kK3ExODg5R0dmZ2x6?=
 =?utf-8?B?SExyZmlXVGp2VjB3VzB6a0swYzlPUkZkSENvVzBqSUhHUkpHNm9MRVo1R0tU?=
 =?utf-8?B?V3NoU2VMa1hCYkJiVUp1UUVua3lqN21FYzhtV0w1T0JiN1Z3UkgzSWNlK1lz?=
 =?utf-8?B?UnZGZ2hzSkNqUE5yaE8yd0w3NjdHOVlhN3NJMnRJL3pET1FaSUloZHgwUXFw?=
 =?utf-8?B?aDNrczdyUWpXKzRNTzhpZXo1UncwOE9BTjJSVE9uSnlFbGEzV0ZoZzFnRk9w?=
 =?utf-8?B?bWlHSENpSjkyQ0t3SjMya0xkaDdYSmw2RXdCWmVnQ09PSURGdHRwSlJsajBr?=
 =?utf-8?B?QU9zUG9IVWY2L2pMT3c2WkdUclpORU1VSmttL0tBRGxGVlhNMHdNd3Rzb2hI?=
 =?utf-8?B?SlJjQU1mYkdmbndoZTRxeDhuTTZ0bTdVWVRBa0RCMG1xZ0pqTEtPeVNwTVZm?=
 =?utf-8?B?RDJxbWs3Um43eERsMnlsQ3dGekFSUlpHOVRPVkNkdGxsNDlITWtnQ2pVQitM?=
 =?utf-8?B?TnlRSDhyZnZnaGRWdDJseG8xcm1vUGRCR2Z3eDZHR29IVFdtRWNrZHIwblpE?=
 =?utf-8?B?TnUvYVMvRVRNa0lCZzVCTUw4SEhwQ2JXeXVxQkhKYS9qYk96NVBiRnJuY05k?=
 =?utf-8?B?MFJka2k0MTNxS1RpL01INFhWdkdlMEZHb3lhZTZaN2MxNUVQajRKdz09?=
X-Exchange-RoutingPolicyChecked: 4oiOHiibK6OuyixYp5Xu4OZvby7dftY/96GO1UShsD6Y8jzR197aMQ8Kyy9PH9M52RtB3LiloRU3E+wD1CXmeskEzLGLTEArIzkhp3BJBX7rlixXjqgu7ea4zTvgcJG1CbkuTqMkxYt8K/a0D1zG5HE7ixFphnkDhlkJPz8peQ4up4Y0T0ObOuzLlKtrcWY6kHUxEr4GfxkzFF30rnm0sAtilXgY4v7xMMkq6MlZMuC50/moRleueHdn0Nhzt0ztNNqB4PwfVCnGA3ds66m7qeWlmCY1Dqanp8lNy7UyenhKFnvT8Sy8Jewmfb1BtZsOqGCZUraDJqwsg3tBH5n8Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20882d36-3d96-46bb-57e1-08df17ac1d07
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 06:46:50.0937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77eEQ6Xj8AZQQOyniMYYpfJbowa7L19cTy/8rI1kCnqZRg7Wf00lxoN1Bi/71A0R5IO4EffrTzVzDWdkJKFSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB983458
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


On 19-09-2026 04:06, Matthew Brost wrote:
> On Wed, Sep 16, 2026 at 03:23:34PM +0530, Arvind Yadav wrote:
>> disable_scheduling_deregister() waits for any pending scheduling
>> operation to complete before destroying an exec queue.
>>
>> For a disable completion, handle_sched_done() can wake the waiter before
>> clearing pending_disable, or not wake it at all. The waiter can then miss
>> a completed operation and expire after five seconds. This causes a
>> spurious GT reset and immediate TDR.
>>
>> Clear pending_disable before waking the waitqueue on every completion
>> path. Sample the destroyed state before clearing the pending state, as
>> required by the existing destroy protocol.
>>
>> Also wake CT waiters after a suspend completion.
>> The queue remains alive until deregistration completes, so waking
>> waiters before sending the deregister request does not release it.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> I feel like this is an independent fix (like patch 1) that can be sent
> on its own with a Fixes tag and CC'd to stable. This also looks very
> similar to [1].
>
> Can you coordinate with the author of [1]? Alternatively, if that patch
> looks good to you, could you give it an RB?

Thank you for review.

Noted,

Arvind

>
> Matt
>
> [1] https://patchwork.freedesktop.org/patch/753791/?series=174199&rev=1
>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_guc_submit.c | 42 +++++++++++++++++-------------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>> index f3ba8abfc228..ca24a77dfb26 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>> @@ -3265,26 +3265,32 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
>>   		if (q->guc->suspend_pending) {
>>   			clear_exec_queue_pending_disable(q);
>>   			suspend_fence_signal(q);
>> +
>> +			/*
>> +			 * Publish the cleared state before waking waiters.
>> +			 */
>> +			smp_wmb();
>> +			wake_up_all(&guc->ct.wq);
>>   		} else {
>> -			if (exec_queue_banned(q)) {
>> -				smp_wmb();
>> -				wake_up_all(&guc->ct.wq);
>> -			}
>> -			if (exec_queue_destroyed(q)) {
>> -				/*
>> -				 * Make sure to clear the pending_disable only
>> -				 * after sampling the destroyed state. We want
>> -				 * to ensure we don't trigger the unregister too
>> -				 * early with something intending to only
>> -				 * disable scheduling. The caller doing the
>> -				 * destroy must wait for an ongoing
>> -				 * pending_disable before marking as destroyed.
>> -				 */
>> -				clear_exec_queue_pending_disable(q);
>> +			bool destroyed = exec_queue_destroyed(q);
>> +
>> +			/*
>> +			 * Make sure to clear pending_disable only after sampling
>> +			 * the destroyed state. The caller doing the destroy must
>> +			 * wait for an ongoing disable before marking the queue
>> +			 * destroyed.
>> +			 */
>> +			clear_exec_queue_pending_disable(q);
>> +
>> +			/*
>> +			 * Publish the cleared state before waking waiters.
>> +			 */
>> +			smp_wmb();
>> +			wake_up_all(&guc->ct.wq);
>> +
>> +			/* The queue remains alive until DEREGISTER_DONE. */
>> +			if (destroyed)
>>   				deregister_exec_queue(guc, q);
>> -			} else {
>> -				clear_exec_queue_pending_disable(q);
>> -			}
>>   		}
>>   	}
>>   }
>> -- 
>> 2.43.0
>>
