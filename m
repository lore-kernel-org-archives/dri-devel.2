Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F66510F3DCD
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C091310E22F;
	Mon, 30 Mar 2026 14:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OjpuuyAu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987A510E22F;
 Mon, 30 Mar 2026 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774879369; x=1806415369;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HSMogUj7sHOZL98NnZw/c1Iu1YPaPNQgZM8Wp6RYbuM=;
 b=OjpuuyAuWzI9Whl9id4vZdJcb0BHxDVgFlmAzG/9xrs6rVFjHUfvqaQc
 3LtbYUo7AB8EInmpEkv+hFq83WYV76vzxFKHVc9SSKC59X67S29VR5lv5
 qApS1ORJiMCx9dpn8weW3MAWhXGgHC5Dz7EmjbnS3TTv59aEvuksW01T1
 sZ3oseNdwyxqlXlEfIcyiZWydpoQK4hJ1PD9cmBMngHxfbZqUzTcriyy1
 zufqsaK37bSEBPicWvw6qO53SImfNYvk3OH1L5zn28SxUTISdTdtF9ln8
 wy35NNo+vw4wspb9IFEprPxakjrinjZ3m7AT+QPq+6A9jdtSZD1rVhOAk A==;
X-CSE-ConnectionGUID: qudiQkK4QteP4ZfAIh7HAQ==
X-CSE-MsgGUID: hc6qgW3TRYKpb4Uh4PvahQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86489753"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="86489753"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:02:48 -0700
X-CSE-ConnectionGUID: ZObEVoMxRHKl/OLvpm7LFg==
X-CSE-MsgGUID: 85jrPkNiRiS9qpg2wTCpFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="230535433"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:02:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:02:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 07:02:47 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d466kHzbyBL452R2PLuDpQlnIIcP7Y3P++XNljI+xRfHe64dXdam4jnw1rKPZz8Vjtt8hSv11tIen9BxgYMR8cnfDdp+CKUtB3eRvFpDqeAnxR7v/MLJchWi93pxqpHwuTops22/BI756FJl02X6H2iVgqqviQE+qjRzaKRUOkwm/qsV6pSZSOHidgnyCyGeSfhvzq6dQNmsGl/5BxURnUSG3v9rDzOOJwBiG4J4lKqL9Fqvla8jxnD5vXFdPx9rOjoTSZJqspdzmYAxTZZ8Bfo0wRcMrNeh1ZGYTcp80OT1cfuIOiMIPhj0dDOdWKDLLOK1eHx7mdQNiQ06i3M4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+6qgJmigiKS0jr5imwL66pwyBGu8d/nAkyJhnTR1Q4=;
 b=HjNorryfHX8VU1cnars3ehHXvqzCBCVxiMt+MV9sJFHhN5iXL+Qba4HZ4DXhP5rgtKa6ohnyu85ULfhAxMhDm2FpTRqGRzuAQ8aZpbMUHRpnDSTxrSbujqbMKstq2srMVR5wOOrChrbjR9BiuZOwm++KqG9GTfsttZ3bOWN5VOMsnWKUVQxzwoBXj8fEX2XvoGit+X4D6UyJ0M6DoOLbMEVGbcZ1ph7P/Io85dlVgz2rTuQOr1p6CM8tAhOJHgMUTy+pXkO33H2fnhhRCsxM+1LUtoi+RMHDs0mmRq/uaN2jDi3rtNMJRHmHqUHTQihGXMmk3amUG0PVs2rZG6Ut+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:02:40 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:02:39 +0000
Message-ID: <7160e2f1-04d4-4fb1-bd21-e7ede1a72c48@intel.com>
Date: Mon, 30 Mar 2026 19:32:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: "Tauro, Riana" <riana.tauro@intel.com>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-10-mallesh.koujalagi@intel.com>
 <88aae008-ddd0-4f23-914f-f4c8e8d6f54e@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <88aae008-ddd0-4f23-914f-f4c8e8d6f54e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0209.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::6) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|PH8PR11MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbd64d4-70fe-4b6d-9f52-08de8e6500ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ca5OFqiB8fUIGGgUaU8ZqsGfzlMoS2avHrgVsMo33QCPQzHEK9DdN9flXUvfejp5CNTdnsdSufRj0IZU4hkfJKiO5EofycDhirz+v3/MVb0FY0u1kvB2JGJvYZoFhdiN2sQn6dPJy2lo2GezMNUkjN1eNOj9RlkCleMJUUHwXVV6t9oxesImWYri25uaIJR163TQfj9r/9SUhYohgTJX2wGt/h627ZR8DTP5su1mpCV985N3pnFoOlvX6DSgcshRySRn5SHoIlpcftxesXOwB+MX/XxYIZ2WVPGc/9hYVeN5amtxslbHuUqUX8yBvDoGS3JpHsQBHyXp4mSVgsTrhf21boCCux1B+PZhapNm1MltJf7pp2vWZnGJpoLsAHHlquEV1EWp25btcOfSxxN54RY9zBRaXTvQpzucW+1YELDAk5PoISHIyJM4gdVEw9cvhSoiqs4Gixum5VmZeTRYq7E4d/5nzJbF2r2cROMbTm72zA+BKvQnuyEmzI8xj5Z1aqhLxfjeDp9QI+LDQF9wtRHueKAfeWiC9efPrj6raLMbuvLBTM2wLM00pjUtIJearc0caIwi/bnuLQY/R/AeqDjvk1kLb45duNTk6N+OqK99MVQfcWlSDV83mb9mTkGYPqOyHU+VsKYbnPo7DX/sP6Ki4s4xZVOx4w40S9Eyi5fq2ozZN64OSd93Z1lx4xGIXTpUK1c81mHHIf+vuSMRLK4XFaYTINmIZ/KaPlwGRww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFzRmpPemJSaWtMcVhmRGdPM0h6cWdoZi9Ldm1HS3dVMzExL1lqM3VqQWt5?=
 =?utf-8?B?anRXUEhwUUQwZTI3NG9xaGF3SjZzTW50NlIyZWhuQXZRQlpEamVjeTBFU01j?=
 =?utf-8?B?bGJTanJDQk5nZ3RZZjFFcUs0QmQwTEhxRUdXMng3T01oNEtZcHN0UlFGTHli?=
 =?utf-8?B?NlhlMTIvdE1PSFhFektoVDJqMExMSm1LZnJobjM0OHlwMklwRldPM3JaRi9M?=
 =?utf-8?B?N200Z21GQ1hRVmQ5OWV0REZlU3BNbXlHeXkzWDEvUWorSFluMmdxZXhPU1hL?=
 =?utf-8?B?WXlNb1g5amovL2UvNXZ2QnYvYy9iVW5vOGpOQ0pQVG1XZVZUa21nZnV4Rmh6?=
 =?utf-8?B?cUJLek9laWJhR3BKSW1ueG1UckwwRUFKTVA5dVg0WnRNZjlPTHFLemhzaHBa?=
 =?utf-8?B?ZjZZYmRKMXRHTU9NT3FJN0NnQ3ZQakM4VkdSbStvb1BNNVJoVGorcFU3VzRr?=
 =?utf-8?B?am1VSS9Obm5hUDdCNXZSdDNLR01NOUNWcGVTSHRRQ2FYaWh2SVgzczZRKzVD?=
 =?utf-8?B?bGhtZUY2Z3kvR2Q2MndEckQwa01ybk0wL3pJdzJJMmxyNlBRZmtwdlFzOCty?=
 =?utf-8?B?M2kxdGwxYzFUV29CbU8ydjA4eS9OM05mWjdPYm5DVExaRHJ2SkFxalhsSEh2?=
 =?utf-8?B?b042T1N5WGo2bTdZbStJL01YS0NmV1AvZXFDd1FpUWhnVlVIclJPN09sa0s3?=
 =?utf-8?B?MFJ3YXdlb2VXS2JnM1BGRnBTbCt4bFZCRk9PVS9LOFZDeDlzVEN6V2grM0pj?=
 =?utf-8?B?dmRsWi81ZHF6LzFuRngzQVZ4TVZ5dVcycmI5dXJWcW9YOEovbWRhSkVsR0pI?=
 =?utf-8?B?QmV3TFY5OElES2ZMcUhHVkI4cFYvSEVJQkh1ZU1pcWR1eTBST3Jpb01nRlhz?=
 =?utf-8?B?V2FqMEtYYk4ra2owTDZxUmpwSjJ4U0diTGRFTFhQOHAzYlQ4ZHlqVXhxS0hh?=
 =?utf-8?B?NzlzMjNPdkwzZlJGYXAwK09VaW9qc0xxaGpkNG5mQW5OZkEraWVycW4rQmZr?=
 =?utf-8?B?VzVmRzZ2cUhELzgxcTNJMkhUWHlIK3ZyVkJyOHFVQ1lNNEt6Rk1qRFFRSGtu?=
 =?utf-8?B?eVM4OEt3YnBFdHFKdk1jYS8yZHZ3RkJhbWtXbnlWTTlIdXJxWmNML1BUOHdn?=
 =?utf-8?B?VWFBb3Z1VXJPM0JPVEZ3VU44TE9uVHFTM2NNbzJGZG05ZE1idGFOL1NWVVBR?=
 =?utf-8?B?WUlUeWxIcE93REpFNndTQ1J6eDd1bU12TjlwMzhyUjVicmcvVyttb3FHMXhm?=
 =?utf-8?B?OHg1NXdoZE0rdFlqZXZkdWpCSDZ1bHRPWWM2WTNnVXVINzV0TXIyU2lSSHkz?=
 =?utf-8?B?MmtSQ3FtOFRjYXMxNm00bXl0eURRMDh1MjFocmdXRnkzOVcrTk40QWxBN1kv?=
 =?utf-8?B?Z2QzdVNjSnZweVFuTUoxeUozbGtpZU81WitDeG11d3lZeGdaUytIQTUxa0tE?=
 =?utf-8?B?THExRXdJNkFyQ04xQzE3ZUozZDRkdGJ3dThnQTV1WmNuM0FnKzJERm9sYVk3?=
 =?utf-8?B?eDhOcjFTcU9aYmlNV0EyNXNneWRZWU9lRllsUDR4RE1PQTdjL2FibUtCNXJE?=
 =?utf-8?B?ZzlkS0h0bEhOa2QyNUc2dDN1M1FsSGZQcEJRbFFkd3pqaEFxcmhaVFFEN2Nn?=
 =?utf-8?B?RFR4UDEvRXJkNHNZNFJVSFBsRFNEa000cTdDVzl1LzdVM2NjT2lMb2Z3VGhs?=
 =?utf-8?B?TGlVNVNOc0trSjhvamt6bmh5TGJlb0IvL1RXL1FSWlBtQ0hVZ0JJYml6VDFR?=
 =?utf-8?B?aSsxcSs2WHdSOWlleVhKc2JhdzBzUzZsdm9XL0QwR0RrNWxYZytvbG1CTThG?=
 =?utf-8?B?c1hhQWcvME43TW5kOFdHdlFPeXZYeTdvZ2NBbjJ0Y0hUaG1mdXdYMW1ONUgv?=
 =?utf-8?B?VTgrWldXNXYwY3RaUm5jUnhZbHpqNTROVjBKOHI1NmU0Nk5sV094VUVKUTJF?=
 =?utf-8?B?OHErL3JHcUh5RlRwbXhvQmhhcGpZR0JDSVdYWWJmcGFLOTlLVjhTU1hYNjVW?=
 =?utf-8?B?RmpBdWZXUHhOMmVkR01Pa0xnWWZob0Y1VlFLTjI2KzJFQitqTXo3WVFBd0tx?=
 =?utf-8?B?M2wyVFJuMS85c2VzY1g2MDBhVGR0cVBCeWNoRng3aWF6cWcxMUxEKzA1bWx4?=
 =?utf-8?B?R0NKRUNjb0tXMjZiTktkc2p0eGM2ZnhvSUpia1ZZRWxON1ZEZlpiOWFPVmhL?=
 =?utf-8?B?WVZWU0FiV2RGM005eER3RGYyejlqcnFhNC9qYVJ2TVptcmRLd0R3c2JsQ2xj?=
 =?utf-8?B?a2FHaDN4NEFGWm1vZmJ6dThTMDRReHhMdlMyTXN2WEFmejQ0VkR4UFc5amR3?=
 =?utf-8?B?ZnRhblUzQ3lqKzFhek1OZ2ZWSlJWMGkvaHBQcm5YeVJPcnlWL2VPdEZPb2Yx?=
 =?utf-8?Q?CSBjIsVUP1Y6hJzg=3D?=
X-Exchange-RoutingPolicyChecked: cEKXAQFVFpxhP0v4V8c/r7AoW1q8MI1sNfH00oAZTC5QL7vS69Rz0s4edclh5jnAF1+YKrSM071weFLXPnG4nSI0IhxIwCd6MD6zuqTZVVu52+eO1PT7EdXVyJtAfGZM7XOpZjYHq4dVIbqVILicYkx62XfK2GsvBXgJ4zljvOaOn/yQJEslar2yOX43dK2Faxc0KILP1ExJYH/tYvXtG4FzdZjRYik6WaG1WJ+clZZNcOcEwsmMHOX9AU0zC3nf2dvcSdOxufDbYsItwg7mXKtKGIVGgab96WFvF3U2sE6Qbf/lYQlwzME5v/UVdVLNrnusdZNJgOSwJ6AA06RfKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd64d4-70fe-4b6d-9f52-08de8e6500ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:02:39.6694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXZnI+XQZ8jzdXRLgHRymjbrx/pT0C0fMmkF/aKBwR+mz/ILb8W9q2YSw9SLKGLRCOGmg7XPJavnoTvp86GbgMiSb9u2uoHHwfCrcTYDs74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
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

Hi Riana,

On 30-03-2026 10:30 am, Tauro, Riana wrote:
>
> On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
>> Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery
>> method introduced for handling power management unit errors. This 
>> method is
>> designated for severe errors that compromise core device functionality
>> and are unrecoverable via recovery mechanisms such as driver reload 
>> or PCIe
>> bus reset. The documentation clarifies when this recovery method 
>> should be
>> used and its implications for userspace applications.
>>
>> v2:
>> - Add several instead of number to avoid update. (Jani)
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   Documentation/gpu/drm-uapi.rst | 73 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/gpu/drm-uapi.rst 
>> b/Documentation/gpu/drm-uapi.rst
>> index d98428a592f1..5b63f1c17b9b 100644
>> --- a/Documentation/gpu/drm-uapi.rst
>> +++ b/Documentation/gpu/drm-uapi.rst
>> @@ -418,7 +418,7 @@ needed.
>>   Recovery
>>   --------
>>   -Current implementation defines four recovery methods, out of 
>> which, drivers
>> +Current implementation defines several recovery methods, out of 
>> which, drivers
>>   can use any one, multiple or none. Method(s) of choice will be sent 
>> in the
>>   uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order 
>> of less to
>>   more side-effects. See the section `Vendor Specific Recovery`_
>> @@ -435,6 +435,7 @@ following expectations.
>>       rebind          unbind + bind driver
>>       bus-reset       unbind + bus reset/re-enumeration + bind
>>       vendor-specific vendor specific recovery method
>> +    cold-reset      full device cold reset required
>>       unknown         consumer policy
>>       =============== ========================================
>>   @@ -446,6 +447,27 @@ telemetry information (devcoredump, syslog). 
>> This is useful because the first
>>   hang is usually the most critical one which can result in 
>> consequential hangs or
>>   complete wedging.
>>   +Cold Reset Recovery
>> +-------------------
>> +
>> +The ``WEDGED=cold-reset`` event indicates that the device has 
>> encountered
>> +power management unit errors that affect core functionality that 
>> cannot be
>
> Power management errors may be only xe usecase.  Keep the 
> documentation vendor-agnostic.
> Some vendors may want to use it for a different usecase
>
>> +resolved through recovery mechanisms.
>> +
>> +This recovery method is reserved for power management unit error 
>> conditions where the
> Same as above
>
Agree, will rework!

Thanks,

-/Mallesh

> Thanks
> Riana
>
>
>> +device state cannot be restored via:
>> +
>> +- Driver unbind/rebind operations
>> +- PCIe bus reset and re-enumeration
>> +- Device Function Level Reset (FLR)
>> +- Warm device resets
>> +
>> +Such power management unit error state typically persists across all 
>> software-based
>> +recovery attempts. Only a complete device power cycle can restore
>> +normal operation.
>> +
>> +Upon receiving a ``WEDGED=cold-reset`` event, userspace should initiate
>> +a full cold reset of the affected device to restore functionality.
>>     Vendor Specific Recovery
>>   ------------------------
>> @@ -524,6 +546,55 @@ Recovery script::
>>       echo -n $DEVICE > $DRIVER/unbind
>>       echo -n $DEVICE > $DRIVER/bind
>>   +Example - cold-reset
>> +--------------------
>> +
>> +Udev rule::
>> +
>> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", 
>> DEVPATH=="*/drm/card[0-9]",
>> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
>> +
>> +Recovery script::
>> +
>> +    #!/bin/sh
>> +
>> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
>> +
>> +    # Get device
>> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f 
>> /sys/$1)
>> +    DEVICE=$(basename $DEVPATH)
>> +
>> +    echo "Cold reset: $DEVICE"
>> +
>> +    # Try slot power reset first
>> +    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read 
>> slot; do
>> +        ADDR=$(cat "$slot" 2>/dev/null)
>> +        [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && 
>> basename $(dirname "$slot") && break
>> +    done)
>> +
>> +    if [ -n "$SLOT" ]; then
>> +    echo "Using slot $SLOT"
>> +
>> +    # Unbind driver
>> +    [ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
>> +    echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 
>> 2>/dev/null
>> +
>> +    # Remove device
>> +    echo 1 > /sys/bus/pci/devices/$DEVICE/remove
>> +
>> +    # Power cycle slot
>> +    echo 0 > /sys/bus/pci/slots/$SLOT/power
>> +    sleep 2
>> +    echo 1 > /sys/bus/pci/slots/$SLOT/power
>> +    sleep 1
>> +
>> +    # Rescan
>> +    echo 1 > /sys/bus/pci/rescan
>> +    echo "Done!"
>> +    else
>> +    echo "No slot found"
>> +    fi
>> +
>>   Customization
>>   -------------
