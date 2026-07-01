Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82386C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A1110EE1D;
	Wed,  1 Jul 2026 07:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ibn8i4xE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F77810EE1D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782892058; x=1814428058;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wnYlHqBYeDRzqa6c+eaV0zS0PmzTAErKHQgDMKqQGq8=;
 b=ibn8i4xER5dom2/e2zhZREvCnfVit9pcw4s0zB9uZykfJMtJGiWhtwpk
 4KgKk6YFcPtP+plPfGLtz+a43Wu1KsG+gVn9ZWd91RvOCYYIVz4awp49N
 P5TYYGeRLWvZKU6ek57ZDj/zrC/UVDGob5AUk1125CafrfDPg3A8g0wMa
 i86I1xtt7hbre0St8Eim9zoUxPO15jyEAgo457oNb07hlfPyFqI87R/Zm
 BiF5oKiaNhDvJnP3tGMPCY/dhrxCrVguc1POdxJ0RD55dF1llmQaMDoRG
 mkmy2bCyyqgpENAKo5h+E+ggqqcwH4qMxr62LMmIQkuxHm0Nc8VT4lRPR A==;
X-CSE-ConnectionGUID: Ek7vFP7STYylsmFM4MoPbw==
X-CSE-MsgGUID: YFyrEpycS8K9ANrSEFKaiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82733665"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="82733665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 00:47:38 -0700
X-CSE-ConnectionGUID: i1R7qUgmSDqK+P2VA/ZUAw==
X-CSE-MsgGUID: HVHDuSl0RgavzO15vsFfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="251441646"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 00:47:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:47:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 00:47:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI2epTAMzO9rnXdcxFXneduniws+AgKMOLFz2Ynl3ZBuAD5QjpjfwEZ9e0/Aw5IALLUVHzpZWSaQ/CzDaGMuAysbeVormQ7iDyF/Y7R4ZmOxoTniSokiBXHn/Y47biHXkzT+r/6MjLQOoMpqZUMmsIyrHq9ZiNCrhlX1dohw3K8zBtGMjRrHBBmCnMmtzwuFL0bF01RgCMW36V63O736AkcbG9MHfwB1rqnjWTwrbUmT6zg700VFt2vMVRbG7Xjjdte4Q/3XRfuBDcd0b+uHYEPjtAGgItOxHK/S/GU4lBHf/MI6DttyyKbdjSAfAXgX8B9fGyEKD5LHC5rwsXYRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxLCCCHBmpigBYhRf4rbj2K8D3umZcGGC8j5XFYSdCc=;
 b=bSCibxUU7Afl3VZCg7DlfnBtbBs+ju6wrLsN7pRMa12N8vv2jiweiRu9HjcfnAMg5uQwTt6yqxE8RBd70EmBI9YyLpZxFEF4vl7UnZGyRCES/efGMDpY5d0ZT7ZDRmtNJ7FEX7IoozUWV2LiDVIU4cCQnauUm5oQuiVSfoLvpZX40oO/vVi9vN4oFF2I0qw4nzTegWR0Nm/C2CA7o9DB2Nyeug/BqFJ0qGTXhQOngQ2eA1UoKplvHMmNq1t0feVXX9YKKdwYw+8lcDaajzFRS6XBY5nYsnyx5/icfjazpeLndcgpUXPLpw0GC2XxKCuiggG50g4EFKcqZaL2KqywBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH3PPFC15E4803C.namprd11.prod.outlook.com (2603:10b6:518:1::d4a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:47:35 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:47:35 +0000
Date: Wed, 1 Jul 2026 07:47:25 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
CC: <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 1/2] gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
Message-ID: <f27oviqsgvl4ztdnsymcv45zzficj72kvzftd6264taralob3h@2junsxehx5vs>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-2-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260618152331.36763-2-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DB9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::33) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH3PPFC15E4803C:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dd90a9-464c-4e85-fcf2-08ded74503d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: jj9lWuE/E6hyR+be0nV6N5Gr9GFnm8xjlD2SdXnwW1nCwj7wTd844lZZgraXzzVqEP6JxXotjB/ydVjgPz/LTF6u30lTKW+JygiZtqqecOUq9D9c2li/u03UFi9BO+C7/REFhNJ1abXkLexWkLowlE5y2y9j7GOv0HhukJ5nrUG6I6in4U7kdcY4dwkw/ULzBsYbUTwffgaDtxlqFpHdiVtVVnC/YfZVKFxFfP7Fk0calSlKaFEQejiwZdlhck4Gen9wHvq3ssNWnWGJUicdcgiC9+Tw2+mHiAlsdD1jqqs+5rZFxhL3miIDBlENmH1lDCN2qFwtgABFfB0IPOeBlfAX6VT0nNmWBDeiCo8PquHOLWU5Zjonz80S5vELW3XfC32vYvPk8vDD0sozCQZOEMf97aEIxUhR5FXM0CPZIgRRorCJhxVD2YfzZDBzOXkGEwgxfgHNO0ssBTZhr69+qBqFtBPkzFzmfXkI4hgU8WvjI0INP80c/dmf9mV131a/A0V4ORZuQ1CivL2LTTCe9EgIfoWwQUrDYmCRD+PIJp8v7O3U2Ap3f7fT8vzwS5pS5nWvX7jP7m1CjNcRDlVZDnpDHNBL5vRuBWcrWpM8HgD/0j4LzLrTP0PXLQysiCrXlOAWqejY4muevJO8bi74OuHbbTYlAPH97OHB6T9W0Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUZ0c2NLekIreHRXcjJoMTFkUlJFZE9UTUlObmNidXQ0WWE5RjNka1hKa2wr?=
 =?utf-8?B?OGg4dWEvM2VYaktZWHNlTmFzem81aEFDUVJ1WTZlZGpaM1RQYXJLNnh4b09G?=
 =?utf-8?B?V25FZXRLTzhMd0RpQU54K3I1SHBwa2RsQnQzOFRJQ0R4Q2J3bmN6LzdrcVZP?=
 =?utf-8?B?TktOa1pYbHdxdVVmM2xKa3JLOHdXeUhJS0NZY0xUVEdZa3NIankrZm5ob0ZE?=
 =?utf-8?B?b2dtdC9xWjdWZmp0ZVN6SDJoUHkvU3ljS1JjZitmS1dJTElZbTdJcnYwQVYy?=
 =?utf-8?B?TS9CaE5PSUdhSGlTaVFtbE5nZVAyUWxMSUFhSy9Td2pWKzFOd2RlbjhVbS9T?=
 =?utf-8?B?dTZoV2FWVUhraFFLZmVFVzMzSlpNQzVCdHphbW8vMWRLaGp4STMrTUJidzV6?=
 =?utf-8?B?Lzc5dlM5U1VkTlJweFdWN1AwdG9WU3RRQzMxSUxZcVdlaWRhRHlJbC9XWXJp?=
 =?utf-8?B?TDFTL1N2MTVWY3NKREYzV3krUzdDNkV3N1BFMzA1a01qUTZxalc0eHVoa21K?=
 =?utf-8?B?Tk9FeG5YNjFUL1VkMElSeU5SZHpEVVpYVzJ5S1BuZC9peW9Va3gzTW9NRUJl?=
 =?utf-8?B?RlBvdDNxcTJYN3FYc01jSkU0NHZOMzFpQjNZTFM5NUxBdEpjVTlZK1IyWjY4?=
 =?utf-8?B?bSthY2hGUU5HN0s1YmdKRTNxT3BONTA5K01ZbUJqUWhOWVlJanVpUUhncXlD?=
 =?utf-8?B?WTIzeWkwV3lmRmU0dUs0bzRzbUliQ0hQdGpqSjJMelh0dW1DdlhXNElBWTMz?=
 =?utf-8?B?NlNTU3A4WDhIdzFoRC9zOWRCL2FoQTdYR1EzSk5iY0tZUmRpcWd0Y0c4VUpi?=
 =?utf-8?B?WVV3dU05dGw1NGtXblVKaFZRUUpuQ255UTdVMExwWHVzdlphVkUwS29lc2gx?=
 =?utf-8?B?cGtFOTNDb2J1TmphaWZFMlR4VnQvOXpKK2ZuWmlKZzBsOW9uQk1OeU5FZm5j?=
 =?utf-8?B?QkJBZ2tydmZmZVJ6REpiTVRFUFdMbDBWQzh3U2ZzaTlMVVA0aDNub1lqM2k1?=
 =?utf-8?B?Y2EvMGVFSmRxNmVEQmVEK0d3M1dNTkJDbHpLYnREazRYaFllRzVLNEFXblRx?=
 =?utf-8?B?TEdNVlBnOWFhejZJUWdWdHdyQTFaanUwVFBBcWRaU21EeC95V2hwNTdKOHRo?=
 =?utf-8?B?OCs0aWVHeURnZ0Fvdms2VXBJY3ZmVnlZZlg3MUdPdW83MW1aZzl5amVJanhv?=
 =?utf-8?B?Z0E1Nkd6S3VEMS84ZnhzNmxBcUVZZHRFOU5VMnpSU2c2Wk92VEVlb1U2ZXcz?=
 =?utf-8?B?alorekhwYjJ2cGNJT1UvWmRkSGcydmRWUVZ0eVpPQ2ZrY1dlQURjOFhZMkVt?=
 =?utf-8?B?ZXlBNjR5UjJvUFFBUkppMXdsTUN1ZmM1YUE5WStGVmM0eGRSYWN4Wnhya3cz?=
 =?utf-8?B?L1p5UU1qK2wzZkdZSVlrUjNQMStaejNoYVlIcEZoNzVSQ1d1YkdlWTlXR1c5?=
 =?utf-8?B?QWZjVHd5SW5jYVNlYmdCSWRjanpMQ0gwaS9wc21SSnpsdHV0ZFJmaFVSUnZN?=
 =?utf-8?B?dUlxRzl3TnRsK2tOclMySzlTVDlzN05ibjRMQ3JyOEVlcW5DSXNzbmc5NlhH?=
 =?utf-8?B?Mzg2TDV0VHJpeURZZm9PU1lFZCtTMzJzWXVUa2JqamRTUVZQRkdDY3pSZFBl?=
 =?utf-8?B?RUJ5UzhqSWsyWi8zUG9xbW1TRHB0cjk2QU1ZQlAya0hsK1JaUDRaVHoxUUox?=
 =?utf-8?B?R1h5b3VpaXFxcG1EalJPdngvNXM1enNKUGY1TXlrSzhpWk9nUVM5RUVocEly?=
 =?utf-8?B?UHdVOWR6eGZOdlFZWm1Cdk05c090ZWZxblRTOEFmQXpKNWxBbG5lSmZDU2s2?=
 =?utf-8?B?a3c3ZHdIaGZZeFBXTjh2Q3EzWWQvamdDY0JiUHExbVZKY1lFZWhmSTMrbUht?=
 =?utf-8?B?aEk5SEtLSXl6QTdlQjZrVU84TDRDNHgySUpWbXQ2eG9oaGk5RElsZER6bzFJ?=
 =?utf-8?B?ckR3dFFjdFd2Z2hhRWZNQXVjUEFKdDJGN0JzelVzK2hBc0lSejhUakttcEFj?=
 =?utf-8?B?RFp6VVpUdEd5OS85SjgreWh0c25rYzNyTHlGd0x6UjNUR2pyVGJsR0E0QXlH?=
 =?utf-8?B?dUlIM3B5U0Vtc3FKT0xSTmY5eXNseW8vV1o4elBrMGZlZllJNXgrSEQ5Q0p1?=
 =?utf-8?B?V1ZmcEpKWW5XcllLNmhSMDkrbkpOSHVTMG5oSGY5cEFVSzFxOHJxTHJyWmln?=
 =?utf-8?B?NkxMNzN6bmpXRXZWL001S3E2YURLcHpBY0tPbnQ3cndVaUVGSStpdHNWZ01E?=
 =?utf-8?B?Qmk3bmJIc3Vhb1l6UU1rUEZSOVo4ajhVZGNWVmlsMjh0cmVLK0JydUJKMHRX?=
 =?utf-8?B?TTVZNGNZYTBIemJ4VWRwZlZKSnVpWWF4NmdOQ2k2NXhxWjA3SXdicE16R3dj?=
 =?utf-8?Q?+fGxGdXnfxB1JxKE=3D?=
X-Exchange-RoutingPolicyChecked: qGpJ6qg8u0UE3ER84F69xuQDGtMTIaqDpjmfYKCPUL8AoGC9ZuDhwRt/u/NDKaXKYp+Ap09AaXzi87H08vX2BKoDFjgHFAy1a4gWqURm7s2VaCaW9qkinXzEvmBsCvuiPpNxtm1rlc72XuHxhS3qaojlKq/wQjrFbxev7L1JdYQdN2c9YL3SD16ibSBZM+q2XzYDg3cguyx+I6FTntftB558jqCD1i0ISc4yuM6rsgWCbGgchwuttJ41S1mb1pHRStgFvbE2vcmpGt2h3A9xB6pJlsvdbJPBbG59xK2gXVgbRlxgstTDjLdi/XC8kiSTzinX6nC3/qjKnONZQxJ12A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd90a9-464c-4e85-fcf2-08ded74503d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:47:35.1719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLigil8aW8yMiCiY8JgB/Xp4zpg4U+h0nFGudmAGi4JVgnGtvQvC2IpRTC9jGKbQH7iZo47OEnmdZeJzOa9VR/uoFL2YiHKvy16tka12ViQ=
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

Hi Krzysztof,

On 2026-06-18 at 17:23:30 +0200, Krzysztof Niemiec wrote:
> CONFIG_GPU_BUDDY is currently not selectable by the user, mirroring
> how CONFIG_DRM_BUDDY does it - the idea is for a driver that makes use
> of it to include a "select GPU_BUDDY" line in its kconfig.
> CONFIG_DRM_BUDDY is also selected when building with
> CONFIG_DRM_KUNIT_TEST, as it can be thought of as building a mock
> "driver" running the tests, that makes use of the buddy functionality.
> 
> CONFIG_GPU_BUDDY_KUNIT_TEST doesn't follow that logic, requiring
> GPU_BUDDY to be selected already instead of selecting it itself. This
> requires building the test kernel with another driver that uses
> DRM_BUDDY, as this is currently the only kconfig option that selects
> GPU_BUDDY. That shouldn't be required to run unit tests for a module
> now completely independent from DRM, let alone any specific driver.
> 
> Fix the dependency declaration in CONFIG_GPU_BUDDY_KUNIT_TEST to make it
> work as intended, mirroring the setup in CONFIG_DRM_KUNIT_TEST.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
>  drivers/gpu/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/Kconfig b/drivers/gpu/Kconfig
> index ebb2ad4b7ea0..3bcf08260d73 100644
> --- a/drivers/gpu/Kconfig
> +++ b/drivers/gpu/Kconfig
> @@ -7,7 +7,8 @@ config GPU_BUDDY
>  
>  config GPU_BUDDY_KUNIT_TEST
>         tristate "KUnit tests for GPU buddy allocator" if !KUNIT_ALL_TESTS
> -       depends on GPU_BUDDY && KUNIT
> +       depends on KUNIT
> +       select GPU_BUDDY
>         default KUNIT_ALL_TESTS
>         help
>           KUnit tests for the GPU buddy allocator.
> -- 
> 2.45.2
> 

LGTM:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

-- 
Best Regards,
Krzysztof
