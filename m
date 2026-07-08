Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E902C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4648310E667;
	Wed,  8 Jul 2026 20:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l+ZWpRWy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC48B10E667
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783543627; x=1815079627;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XDqDWJtfdECxgcTJhBShMhNq/ECXOkhf20U0Jqk0LGk=;
 b=l+ZWpRWy40IBmF7/NQkZTXLAEoNIdJVdgEw0hug7+JH+di39a2ER30PX
 UR+BOOoPjOoN/kfGGfYV9xaSO1gd6pkteLOr2clDMoQlS0AcJc8X0Mtll
 AS0ySU/+lCetS+vZWmlI3UXeKn4BociHC71MZSdVNSvSToLt/Cxg2RlDe
 cKyAAGnaMXeXXbE/ZTrhSylAxlO9UZckaCWvz2AXAzQMQ8nm+O6NEUFsX
 vA6bjYgDlP6Y7TeLRfVELBVjvs1SpNuK5ZsM7GkCxFXkub/fkBJdG5C8L
 A4bfBqMrNja8lKSyt/1jMrRt5uphqfmkxoogAw/ERqwsmDx/a+SZKgkFb Q==;
X-CSE-ConnectionGUID: xAvAJlylTKSPfuoadNcsog==
X-CSE-MsgGUID: CVaFol1pRROKHDi5I2H3ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95594564"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="95594564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 13:47:06 -0700
X-CSE-ConnectionGUID: YZTAVei3RViI74ZMXp2N1Q==
X-CSE-MsgGUID: ok0e+epPTxSXUlCdEK7stw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="249971229"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 13:47:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:47:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 13:47:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvpmDkivXqy82GyPxxiyI25RY/rmLypVctbhWZD6/T2dBt4vbQcyT1WGlpJea0ijXZ7QNEHb3/twVEekPa6HdbKSlVn+q5EvOAGW7VmmaylnOK0WlToXYIwxDfYMDRlAqdwlbE/fmoeFn3vshmj5GyY7y++DYc7ru+7ECODF4iEHwZ6E3iwv6ZjW3S/q8mPEbDgidbHKFomfw/xiPnclhUBImnn1QGrZkkcEsvJExxmbGPO7IPTYIDjll0Q6zgQ0AR1S+BMJQ3O+6R0o2w7zE1ZEtlvtS3bipT81BXrSbrVKizuI85Djb6K3DhPB8+2hKPoZXyj5e/GJrCXSZZIOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuV68z3zBIjw05ly+DPPOILFpmhbE1UGCl0vPIwvE70=;
 b=jq4juOGlmTXTMbjZxwS8HkVw8q6/2nJPw6DMjGPxWrtRbt36R4/4U0XEMDP7/LfPR+VOkX8YxZKs5u+aWTa1eIDDOP6XvkrOi8uTuQhMACeoy4HCwF/MtvTRgZpjdcCyfxteYS6Xj4OEsbuSi24WqrM2cO5PTbVv3ZqM3X0HLDNLinZqXFl22VfDivDiGMQeQBQEMOVPrNru81HRbWHziuzVeGLnpr0Xr1A971vZbZSuwdaD7ZRPKLD1regrrPlWmdOx2ZQe2WxTrKvM1knuvZVj8gWwMO56JrAs+BO/yq1rLcwrIaoTxV7cXe0ZCAvoS/9DNpfVoAMGWSeiou7m6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 20:47:03 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 20:47:03 +0000
Date: Wed, 8 Jul 2026 13:46:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 952ac3be-44e5-4b55-73b4-08dedd32107a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: rIXQGhUlqkixffpF+8Gyap6udKLE4WRZ+wk9AFydkr2MkDir14PTIFrOjcLKTnRm1axNLaJUjO+gc0aBguDU3996SIpEJZf1Rq0iMqraF807uIoc09LHtd1Gzb0K6WQo0jt8lel06p9OxJOShSA6POxFdjSnQQznQlNpBjX9Rm99qO60f3MnRKDMM5gFSKnWZetGTSwqalZ+MENIT8YNlr5Sjz4UAyvQVYaGxLEPA4zm13X4jqjxasCHP+y2/vOKzm+318XeStz6giwObDgwunAgJZkEZMIFBX0PCvOTFpyXvYPRfX6L2sWSBpVDZ5kWbvsrKBs0xcHHwZD62PceYOcAhkLzTK756+tEdFM6FDHD9rS6vbS4r6Gk6gkPZHpN6H4+Aki08QNEDCuYvZxTC54l3qyl2tut4PGVlTc1BdWuKnYK7aTK9gmVGIlYpNCk/odsyUMDdvid4bWG77bNFncg8QwTVDzN5V3cotf4tuVVSR0rbeT2LHAOaQJdGT+mnf6orJlVh770QQs7uXxVVEBg8AHG/6JleHuMxai286i0T9Q6HXZUTc5mk6nsBDvHpdHaCP/8uEznPPVtMygGTbkZJ3SxNwvYjRHEwMDnLeHNrBnHiiDrov2Z4yKMb3Hk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hFSk1jTGkxemdtNnV4OXZCMEk0bXA1Y25FbjNEeUdNSmZhYVRFcUgza3hD?=
 =?utf-8?B?dVc0cWQ0VDdDK2FST0RFOW5SUUswMDhZbDdWSWhSc1MxTVEzcm5kQzZTOU1E?=
 =?utf-8?B?RjdCNDVXQlZaVkNIN1hGeWRCaTJweWVOSUpLcVlaekNhdTRJV1hZWHEvdVBV?=
 =?utf-8?B?WU1qVllaVmk2ODJQMEp0aGFoSW1MSFdmZXFPMXk2ck5ZUDhjSW5NUU5PWWlt?=
 =?utf-8?B?dzJFbTlvZTM0ZzlhbmttUVdvWm1kWHlWYVAyS0Z5eXdGK0lQakdFRU9kQjBU?=
 =?utf-8?B?cmUxRmNWaXFQdVFBZUV5YkM1WW9lVnVnT3pDS2tZRkN5UnRuRFVqVjBzWk85?=
 =?utf-8?B?clE4ZjBkSEc2eXJ0VnE1a2FaS1hQOFlRK21lZTFpbTFNT1M5ZEhhMGpHSndG?=
 =?utf-8?B?YjlRamg3SHEvUkZuSkUwQXAvZmdzVk5GQXlXekx3Unl6ZzFiRGxNYnduY2FM?=
 =?utf-8?B?eVVTZW8raXBQc3BEMXVFVXMxOFAzNmtQQ3AxazhpTTdsYU5xRFRjWnIyWHZZ?=
 =?utf-8?B?MXJnVVRuSkNHYWVkN0YwTkR1WW4vQXhmZjdxZFRIeEZqRlVZVTRFQ2srRHN2?=
 =?utf-8?B?a1ZON0lCd21LQTlmSi9mU2huMzlFWHhQZDNSV0dLNUxuWHlXbkp6Z21rV3RJ?=
 =?utf-8?B?UEpaUlo3dUxkSWN5ZHI3bmNzN3hEcXJwSUNQSmlpZ0Y5L1VhczMrWlQvcW1M?=
 =?utf-8?B?U3RXTGNjY2RnQk0xK1FpZUhQQzJwbzB4aEdrV3oydWlvejViV28vOU1KMEdV?=
 =?utf-8?B?WXBCL3B5ejFobmd1T2RVSHFNdGJrc3IxL3NCbFh6UnZseUZuTVZmOTFxOGxK?=
 =?utf-8?B?VHFXZ2dNM3ZkSWE2R2FiRmdBZngrS0lzK0xjNzdWb0phcVVYeXZvVWRQdWI3?=
 =?utf-8?B?YW52NzZXM05ydklSYTRsTEhvOW5CYmRLMGVVb0szYkVtMXJ0c0RCL3RjNmpZ?=
 =?utf-8?B?aUV6WUNWOTJ2T3d2Y2FmL2hOTGRWYk53UVMzOFlNcHlxRHlpMmxrQTRXcTVG?=
 =?utf-8?B?R011UHFYaVRSZG5CSVlrb0wzMFhNSURjVHd1VFJBNGVZb2IzS1pGdjhGY3lx?=
 =?utf-8?B?SllKdGUvWHRueDZvL1UxTnllUFNqWjJTZ0VIV2laUEFPaGlzdTRkVkJHbVNm?=
 =?utf-8?B?N0pMQ2dGQ1FES2l5aEtBcFI2dFB6eS9OOTlqc1NEckxHSEV4eUdZcVJoeXRU?=
 =?utf-8?B?UG5KWEpoUFdMUFlYZmRnalhqd0MrZ2lXZFl6QUZ6T2pyT2E0K05TdjdleFg2?=
 =?utf-8?B?anJtT21KQjBNdHIwY0htS2laWnRBaGNWWmZTbUtUZC9JVGtweGd5T2tDRzJ4?=
 =?utf-8?B?bHZRUGp3WXAyRXZmQmRSY3NlUUljUHVLTmRPZlJZWGVOcjhTRFFWSER2bXFH?=
 =?utf-8?B?Y1hpZmo3L2ZvN1pHT3ZCeFhPRnBaV1dISWF1SjlUdm1SZ0xMZGw5UVZ2UUZw?=
 =?utf-8?B?RDd6SkR1QVdzcmhaMDhTZms3R3haRnBITWZ1L3FwRHZGMlBDRzhrM0tLdVVa?=
 =?utf-8?B?MDdIRTJxYjZGN1YxclFXRFF0bFVtUWQxWmVqUGZ0dmwrdWJsYmxJTnI2eTMy?=
 =?utf-8?B?eFlTY2tyb3hTTVRQLzM4NWoweERpbnV5L1o4a3ArbXd1V0U5MjdBQmlod3R3?=
 =?utf-8?B?aWhaSEpPa0t0Z3JxUkQzRWNTcVYybVlKYzVkUi9JbUFpTG01UzNYdTFna1Nt?=
 =?utf-8?B?MW0xdjJ5Zy9TV1hWenNKS2pDMi9tWkpLZXhaOEFEM2FFYUJwSUZjZk9xYXho?=
 =?utf-8?B?U1ZvM0hkbkwwYkEybGx6Szl0aDZUTmI5WEpHV3RGMlRvK08zdDBYbnVodmNK?=
 =?utf-8?B?UWhTcWlGOWo0K1F3dVZMTlJBcUZ5VFhOQWVleHdNR21mRlhieUNmSldsZUZv?=
 =?utf-8?B?bXpVMDdnTWcwQXZNaHdxaFp6SEFRVGJ1cHBwODBoS241SUo3V3grUWs0c3Rk?=
 =?utf-8?B?YXlUdjR5ZTZpaWlhdHZqeHJ6VmQxU1Avc2tlWko1TFg0VXhnUk5Pb1U5czFj?=
 =?utf-8?B?Q0ppUDEzWkZwNFYyRVpXaXFGZmZaNENDZkdFNGJWWTBISEd0YWpJbFVvUFRB?=
 =?utf-8?B?eHFUKzVjdmF2R0liY0c1ZFRreXpRTVE2Ukhjay9FaGdoQVFRYUcxMkRpVFox?=
 =?utf-8?B?RVdndXdxWXBmQWk5NGdVR3F1Wks0QmdQVFFTTEtwLzF1UUJYS2ZCMXY1SllY?=
 =?utf-8?B?RVQyNDFsaDJOMUJ1a2tTSEFRL3JMYXgxMzRQVEpxeURacWZyc2R3emk3elUv?=
 =?utf-8?B?MGFGcWJCYUhCNWl2WFp2ZW82bXE2aEFFaDFuS0VtRmhvNWE0d3grOGI0L0VX?=
 =?utf-8?B?VCtDRU5CS1ZmeDZsbG90UkRxQnNZWjBrTXV5UTk2b1FKOHpqSUJZdz09?=
X-Exchange-RoutingPolicyChecked: k2LSzdwW8Q0D7sHA9kEYHdHuO26xQSwC8aCJmcQaHRn1513BBDINLbBz6wJdXC1HbAg/qKWxknNT911rDCrhjZDH7pWbm+gjqVW3k9VsaJZRmi2I1zPjq1/0pttOzDpZvoRJ1/0sp09Kfwj6xW/y6xfAwGtOp5/tMlRYcdb372KJMS/0209I5C8VuLcUbvtICHEYl7QEdWeB7NY6ScBwFoORcCAKsnN656ZtpgepvDWQyp1PZpXVQ8bmqSB0+YVcjwwYKUZKZXCO1EiimzOA878PnkZ81vGEnPbp/PK6Qjqz6qkJL7sjqePSzkJYAWsEvPTKAdLeCsqaYdBInFq2iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ac3be-44e5-4b55-73b4-08dedd32107a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:47:02.9326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/3KvR4B3h23Gnq0LANef3CQZ5dyFo628puIWeUm1h+kcvO4tyrYSLAOpK2qPYvnIf/VioLL1poL/pY6I/+e3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
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

On Wed, Jul 08, 2026 at 06:01:55PM +0100, Tvrtko Ursulin wrote:
> 
> On 07/07/2026 08:12, Matthew Brost wrote:
> > On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:
> > > On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:
> > > > 
> > > > On 03/07/2026 10:22, Matthew Brost wrote:
> > > > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
> > > > > > The problem statement is explained quite well and succinctly at:
> > > > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > > > > 
> > > > > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > > > > high-priority DRM client gets latency injected into the GPU submission path due
> > > > > > to the DRM scheduler use of workqueues.
> > > > > > 
> > > > > > This patch series proposes to replace the workqueues with kthread_work and
> > > > > > priority inheritance to solve this problem.
> > > > > > 
> > > > > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > > > > show a striking improvement:
> > > > > > 
> > > > > > 		median	95%	99%
> > > > > >     before	41us	1.5ms	2.6ms
> > > > > >      after	15us	19us	24us
> > > > > 
> > > > > Can you give more information on these numbers? e.g., What you ran / how
> > > > > you measured these. It is hard to argue with numbers.
> > > > 
> > > > I believe Chia-I observed latency on some production hw/sw and then wrote a
> > > > synthetic benchmark to test it more easily. Details are in the above linked
> > > > issue.
> > > > 
> > > 
> > > Thanks, I see this now. Part of the problem, as far as I can tell, is
> > > that fences are signaled from work items rather than directly from IRQ
> > > context.
> > > 
> > > For example:
> > > 
> > > "There is another 2.5 ms of scheduling latency from
> > > panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
> > > to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> > > 
> > > I assume this is only addressing the scheduling portion of the latency,
> > > but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
> > > of the latency appears to be on the signaling side due to the worker
> > > thread.
> > > 
> > > > > > This is obviously really good for preventing compositors from missing frames and
> > > > > 
> > > > > Modern compositors do not pass render-job fences to draw jobs as input
> > > > > dependencies. On Wayland, this functionality is provided by
> > > > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > > > > later. SurfaceFlinger has also operated this way for quite some time.
> > > > > 
> > > > > The obvious solution for compositors is to submit work directly through
> > > > > the ioctl (i.e., bypass path in sched) when there are no input
> > > > > dependencies, which should be the common case. The main exception is
> > > > > when one of the BOs mapped into the compositor is migrating or otherwise
> > > > > busy (i.e., a BO has a fence in a kernel dma-resv slot).
> > > > 
> > > > You mean the direct submit RFC you floated some time ago? What was the
> > > > verdict on that one, wasn't it rejected?
> > > > 
> > > 
> > > I had some patches for DRM sched that I never posted. It turned out to
> > > be a little tricky because of some other quirks in DRM sched, but it was
> > > still roughly 100 LoC plus an additional lock.
> > > 
> > 
> > Side note: I quickly rebased DRM DEP here [1] and prototyped some RT
> > solutions.
> > 
> > I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose between a
> > workqueue and kthread_work, and to enable FIFO scheduling in [2]. Most
> > of the details are hidden internally, but I had to make a few small
> > changes in Xe to support this on the driver side [3].
> > 
> > Putting aside whether or when DRM DEP will land, if DRM sched really
> > wants FIFO scheduling instead of bypass (the IMO this is somewhat
> > questionable), I think the approach I took in DRM DEP makes a lot more
> > sense. I haven't looked into what changes would be required in DRM
> > sched, though; hopefully it wouldn't be too messy.
> > 
> > Of course, kthreads are now directly exposed to userspace, but this
> > would be limited to privileged userspace with FIFO scheduling
> > capabilities, which seems reasonable. Additionally, this approach does
> > not require the kind of large paradigm shifts proposed by this series.
> 
> This sounds plausible and TBH I also considered worker duality. If you look
> at my series I wrap everything to drm_sched_work and drm_sched_worker so
> drivers do not even have to know what is the underlying implementation.
> 

You could probably abstract this to some extent, but any driver-side
functions that process work on scheduler workers would still require
dedicated function signatures. Perhaps some creative macros could do
something like:

DRM_SCHED_DECL_DRIVER_WORK_FUNC(driver_sched, work_func);
DRM_SCHED_INIT_DRIVER_WORK_FUNC(driver_sched, work_func);

However, this would only eliminate functions that perform a
`container_of()` conversion or use an `if` statement to select between
workqueues and `kthread_work`.

> It is definitely true this solution would simplify the implementation, as

Yea, I think when I pushed back supporting kthreads + work queues, I
wasn't aware of kthread_work which sematicly matches work queues. Given
the same semantics supporting both seems trivial.

> you say, problem of thread explosion is limited to RT tasks so basically a
> non-issue. And the need to create own worker pool implementation also goes
> away.
> 
> Why I was unsure about deciding at drm_sched_init time is a) runtime
> priority changes, but perhaps that is not such a big deal and we could live

Xe only allow static priorities on queues, unsure about other drivers.

Matt

> with a static setup, and b) the priority inversion problems relating to
> other workqueues used by various drivers (like the panthor issue Boris
> raised).
> 
> Or we can cap the number of workqueues to some reasonable number and then
> Tejun maybe can give us RT workers. There are many options on the table so
> lets see how to discussion develops.
> 
> Regards,
> 
> Tvrtko
> 
> > [1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/drm-dep-rebase-7-6
> > [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/fdc38e4acefc9327637fd818b5b91fd6b2a6198f?file_path=include%2Fdrm%2Fdrm_dep.h#line_99bf000ae_A178
> > [3] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/f1483af15747a2d5d73262d2cdfc9b616230c5d9
> > 
> > > DRM dep has this built in without any of that complexity. I'm hoping to
> > > get around to rebasing it soon, but of course there's always something
> > > else to work on. Sooner or later, it will get rebased, and Xe will move
> > > over to it given the latency and power-saving benefits I observed. Given
> > > power savings, I'd think drivers for ARM based phones would be pretty
> > > keen on moving over too.
> > > 
> > >  From an architecture point of view, bypass is the ultimate win because
> > > the context switch is completely avoided. Again, this is primarily for
> > > compositor use cases, since they do not wait on fences.
> > > 
> > > Also, in general, if Panthor selects PANTHOR_GROUP_PRIORITY_REALTIME, it
> > > would be very odd to pass in fences. The RT priority then depends on
> > > other work completing before the RT job can be scheduled, which
> > > seemingly defeats the purpose of having RT priority in the first place.
> > > 
> > > > > > similar. Another good quote for the above issue, explaining the consequence of
> > > > > > CPU starvation of the submit path, is this:
> > > > > > 
> > > > > > """
> > > > > > As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
> > > > > > gpu time.
> > > > > > """
> > > > > 
> > > > > More details here?
> > > > 
> > > > This just illustrates how long can the workqueue wait for it's slice on the
> > > > CPU if the cores are loaded with other tasks. In other words, how long since
> > > > job is runnable to it actually being passed to the GPU.
> > > > 
> > > 
> > > Yes. I do wonder if this is an Android quirk, though. While working on
> > > some MM-related Android issues, I noticed it has quite a few quirks.
> > > 
> > > I've done a lot of profiling around workqueues in Xe (submission, page
> > > faults, resuming after preempt fences, etc.), and I've seen latency
> > > spikes of perhaps 10–20 µs, but never anything on the millisecond scale
> > > on Linux.
> > > 
> > > I also recently fixed a workqueue bug [1] that showed up fairly often on
> > > Android. In that case, workqueues could stop scheduling under the right
> > > conditions. If I recall correctly, a flush_work() could get the work
> > > item unstuck. It might be worth looking into whether that helps here.
> > > 
> > > [1] https://patchwork.freedesktop.org/series/164199/
> > > 
> > > > > > DRM scheduler was originally using kthreads but was converted workqueues due
> > > > > > desire by xe to create thousands of schedulers. This series also questions
> > > > > > whether that was needed, given how the submission is serialized by a device
> > > > > > global lock (per GT, so almost device global). Panthor has a similar situation;
> > > > > > hence the series contains two patches to move those two to a setup which matches
> > > > > > the design of those drivers.
> > > > > > 
> > > > > > Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> > > > > > scheduler as a hardware scheduler, where number of instances follow the number
> > > > > > of hardware blocks instead the number of userspace contexts, are completely
> > > > > > fine.
> > > > > > 
> > > > > > There are use cases however which do currently track the number of userspace
> > > > > > contexts and which do allow for more parallelism. For those a straight
> > > > > > kthread_work conversion would be a problem due an explosion in number of
> > > > > > threads.
> > > > > > 
> > > > > > The most direct example is panthor VM bind queue which creates a scheduler per
> > > > > > userspace context and relies on work queue concurrency management to keep the
> > > > > > number of threads in check.
> > > > > > 
> > > > > > This creates a challenge for the kthread_work conversion. To solve which I for
> > > > > > now opted to create a trivial round-robin thread pool. For the RFC this is
> > > > > > limited to four CPU threads and is something which will need to be discussed.
> > > > > 
> > > > > 4 CPU threads per device, per drm sched module?
> > > > 
> > > > 4 CPU threads per drm_sched_create_concurrent_worker(). So depends on the
> > > 
> > > Ugh, that is a pretty ugly API.
> > > 
> > > Matt
> > > 
> > > > driver how it wants to use it. For xe there are no usages of that, albeit
> > > > you say single thread is not workable, we can discuss that in the other
> > > > sub-thread. For panthor this RFC uses that flavour of the worker for the VM
> > > > bind queues and in that case it is 4 CPU threads per device which handle VM
> > > > bind requests from all userspace clients.
> > > > 
> > > > Regards,
> > > > 
> > > > Tvrtko
> > > > 
> > > > > 
> > > > > I have more questions but let's get some clarification first.
> > > > > 
> > > > > Matt
> > > > > 
> > > > > > Ie. how much parallelsim those really need. The true answer is somewhere between
> > > > > > "at most the number of active userspace contexts and the number of CPU cores".
> > > > > > Or it could be less than that, since after all, VM BIND parallelism is
> > > > > > eventually going to choke on a narrower gate of actual GPU execution. We could
> > > > > > also allow drivers to pick their number.
> > > > > > 
> > > > > > In terms of how I implemented priority inheritance, the most important
> > > > > > characteristic is that it is temporary. As many userspace clients may be
> > > > > > submitting to a single DRM scheduler instance, a generic solution is to only
> > > > > > elevate the submission worker priority while there are active high priority
> > > > > > submitters. The mechanism is light weight and has a hysteresis built in to avoid
> > > > > > frequent scheduler operations.
> > > > > > 
> > > > > > That's pretty much it for now apart for an important detail that this RFC will
> > > > > > not build for all drivers! Out of those which directly use the DRM scheduler
> > > > > > APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
> > > > > > Others I have not tried to build.
> > > > > > 
> > > > > > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > Cc: Steven Price <steven.price@arm.com>
> > > > > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > > > > Cc: Chia-I Wu <olvaffe@gmail.com>
> > > > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > > > > 
> > > > > > Tvrtko Ursulin (8):
> > > > > >     drm/panthor: Remove redundant drm_sched_job_cleanup() from the
> > > > > >       .free_job callback
> > > > > >     drm/panthor: Use separate workqueue for DRM scheduler
> > > > > >     drm/sched: Use generic naming for workqueue helpers
> > > > > >     drm/xe: Convert to per gt scheduler workers
> > > > > >     drm: Wrap DRM scheduler worker in own abstraction
> > > > > >     drm/sched: Convert the scheduler job submission to kthread_worker
> > > > > >     drm/sched: Add ability to change drm_sched_worker priority
> > > > > >     drm/sched: Notify worker of the entity submission priority
> > > > > > 
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> > > > > >    drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
> > > > > >    drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
> > > > > >    drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
> > > > > >    drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
> > > > > >    drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
> > > > > >    drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
> > > > > >    drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
> > > > > >    drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
> > > > > >    drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
> > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
> > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
> > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
> > > > > >    drivers/gpu/drm/xe/xe_gt.c                  |   7 +
> > > > > >    drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
> > > > > >    drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
> > > > > >    drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
> > > > > >    drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
> > > > > >    include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
> > > > > >    27 files changed, 551 insertions(+), 134 deletions(-)
> > > > > > 
> > > > > > -- 
> > > > > > 2.54.0
> > > > 
> 
