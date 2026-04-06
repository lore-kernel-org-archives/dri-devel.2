Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B86E9D822
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C7B10E27C;
	Mon,  6 Apr 2026 13:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A6VhOIMX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5CCD10E277;
 Mon,  6 Apr 2026 13:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775481429; x=1807017429;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dneqyUPFgWcsxcMUidrTzFuzpU4hUyg/zULZE5Ju+Wg=;
 b=A6VhOIMXWBZx0TIJe+pvoz/Xvjb2NFUWeu3G7ZDvS2yFMG7Vt9zNaNzX
 zZh21VQE/YbXS/odOOFzEirzpCQKLub9dFJDgDvpTLUwlwzVTEbSAkNg1
 Cb5SzspnEmDmQMM6K/lIOXQngOBUfIRxv8qk9vI+unPwKHVhOufzabIbt
 5gNchrNkq2SaF26/+2uby43FtNRiN4H1oisskwKVS8fUwXYEj6JyBkT2J
 LDtw51WqMP1DGSnpurYOWJ3Qd5osrqMUNtvIYen0mRHytXpDZOmr9AOFF
 WsDBuKhqi6Km+yGjggK6HfRe4Aj+3Efkd/1wtCE4ahy/9E6MtR3axNk07 g==;
X-CSE-ConnectionGUID: 3Qb0D3hzRJyzR4TnOxHROQ==
X-CSE-MsgGUID: K3o+cB81S7ehb9S/f+RMzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="80288512"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="80288512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 06:17:08 -0700
X-CSE-ConnectionGUID: SHO3MfY6SA+cIq9sxNWEhg==
X-CSE-MsgGUID: VD51l5XsQ0aRtVMZ2VvE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="251158327"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 06:17:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 06:17:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 06:17:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 06:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjNRhnD9XackeDvNZf/egvbMQPf6Z8Owa3HigSldnqO2BdP1PNkd2Jl02sAQSYYwniSxkJHW0wiH6m/yDuenz8oOqHzSmbms/DTXuV/MRnJjqi9tnf77+dzf7Vmn3iD56qxteogXzmD4pXl0Zc6Xn7rhO1cGwEspQs7vVun5QerPt0NMYT0BI5KA9sufiWtUBp2v34VjC10o9SaX1n5LJFVnlgDwkC37jB3I68T2pJmtNeOfk7/iTZW71lGaWkDoHmOE8pCcQ334RIyer4Qwoun0fNDcnu0l6sd45J+3dhIeqb55HB0yebBQxFHxUBUZKSsaP01GjW3i4gyyrxMGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJN8dUSarK/7ys8hYAbfeJhpplVVghOxb9C8BcbrC1w=;
 b=j1gaZC/xneuezk+6Saimnd12D8k3SmK5APewgFWYhrOXKEJO6chsjE5btnlRu8P8TUnd6D+7EI7qU1NNNvhB9r2gxHZswmc4BO0cgswFfTf5bFTVu8bkXX9mrf32ySU1vmeAvG11wbOa8I+IupiD8IedqjB7wqhBMQ1LMTcvV6SpUuaoJR4GBYtQIkfTOWse7iWEeKZsrbvCY9wTBa2InnnXdiiJqJgqKjNlYZ3FnKuPTEii3t9fqXRfWEeEFHbA43gQ+4wKUoISiDoIK6PztDGq3zBt3CQA48ZurhDKbxupfFhJ3rWDgff/D1lsSGzfEsgwmF+Zp3Y3vfHj23zC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 13:17:03 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%3]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 13:17:03 +0000
Message-ID: <e2e950aa-b8e3-4e6b-be23-082486468786@intel.com>
Date: Mon, 6 Apr 2026 18:46:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260402131912.634248-3-satyanarayana.k.v.p@intel.com>
 <20260402131912.634248-4-satyanarayana.k.v.p@intel.com>
 <e0264142-aaf6-45fe-9155-19a8b3b76a6e@intel.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <e0264142-aaf6-45fe-9155-19a8b3b76a6e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 921ea8db-a92f-4462-fe0c-08de93decaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Mkmf/WPJPdZV//I3357fCnK80CxE4irYEbSAArHVGCIyj5y1RWNLEq/CD+2Ls5SPaL0NdPkILf1uA0slMZ+80u0J4bEecg8ierJwKGXprD4WsenATG7wGpo+pxvi+f3L4xTJ1euE1cTxj96HBVRoF/4+i3ItwJcbCn8pOTxJnQIZgXBF9QljkK+D1yaWZLWG91YkkoIRpo2NfiSNuayho5Am6bzTKAdRBKZQynySehQuMtnOuFIImhobuGMznHMCs11KpPNJWO1D+P1an1Srb6wjvSLr/Fuj/yWh5lfvuZFX0WVNTDRbXrHArcDrObMhhLv2UghUi8Trew/6DyBpbfjPQd/A9zelsJvEUrcFcWGV/hKIuMZjTlOSNJVNJp/pp051OL8kl7TxXZOZgKt6y8YMRDfYgwvdjdJqivyc4CNZ/Sn0HjT3RGdERjnuuHCln2UgMp3uTx2XnRVKre2HDq7DiIw4q/ocS30l+Z39I/lZsolUszdI0s/gaMpsoPMBgeYzyCaMBbq2FedA0g0Qa1hsmpvJeGxwjmFhzCYilEOdebWoyh997/RUmCJT3z9xgqU5blFwyEAlzMu+bbNEBxbtsDKTZehBKbYO3DnaIZYNmssmY1YQCI0NpYpX6sMSIiAyX9uWCuZTucNjiOUi5P2BYcO/4WEE10HWrr6TBHjOBk71NuPRvPHKcE2OF0oaREkrYQ1TDLcP8ZdgYM32JeZ9mdB1XMvl0yCu8bmnmSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8695.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXR1M3ZsUVdvU3Bnd202TVlIVU84c0trb0FONVQ3L2pDei9xTWQ1Nmkyd01Y?=
 =?utf-8?B?SFZMNFVLV2ExcmNHTnRCSnNpMWxPd01ZeUhtdnlxQjRXell5alQzV0xZM29o?=
 =?utf-8?B?dG9VODM1RVdhRk5hRG5LMWpSU3dXdW9UOFJqT3ZteWlYamg1MWJjYTdrbEhr?=
 =?utf-8?B?ZFh6ZFgrVGludS9jK1dZWjlIY1BiMktaWlgxWmVGcmlsenVGYWIxU2lzdTht?=
 =?utf-8?B?Z3lxZk1ic3VVL1FRT3J3dWZGK0tWY0RJTlY3Y0t0cTdtd0NwMTdRTm1SVE9S?=
 =?utf-8?B?SzZRYUZMQ3lzMWNWWHF4bElHT2VHZWx0cG5tMVVYU2IvdDU1WGZGc2ZrUWxj?=
 =?utf-8?B?ZWtVNmhUSUxvS3JldTZSMVk3U0tTUGdPbVRMblc2MUUxUE1UTm5WcTY4blpI?=
 =?utf-8?B?OW1JOWVpQWhZaENIVjByQ0JJY205MnNQaTdiT3hVb2ZMZGk4N2hGT09aNG5N?=
 =?utf-8?B?V2pnaDUyN3VqUUM3NTFNU2ZuMERnNFRrb3BydS93SnlLMU9SdUxGdXZFaXVa?=
 =?utf-8?B?Y2lyOGJwT0lYdkFQcVM1UFhodkNnRXQrb2tFblFTWjdQMzhnT3E4d0FLNmQ1?=
 =?utf-8?B?RFpPcFlTdjh6VUZZWkhzMWZzSXJjV0xKM1VhdWF2anZ4bklIUVAzU0Y1OFdh?=
 =?utf-8?B?d3lUa0U1OXBxQkJzbGhZcFNCelFTa3IzZXMxblRWZmtKK1BPRFVQVld1Wm9L?=
 =?utf-8?B?QnVWZFhSdTRKREs1M3V0bGxQNmdXNUR0QVdudHcreXIvdC9Sb1l4YUcxOWVs?=
 =?utf-8?B?dTJLNS80dnI1VGxmZHJVVUlreFJ3dEY0bXBKZUN3dEJxc3k0cGFhdmRjdlRl?=
 =?utf-8?B?eXE4ZGoyQXNLZ1dzakt5QXdwTDVXL20xOVZlTnNPV1RTelZWOUg0NTNkT1dv?=
 =?utf-8?B?bmd2cjk1MVVpaENId2p0VkZGSlhZYzZpL01oMXFiamJjQUpRNEt1TVhNL25s?=
 =?utf-8?B?d0p1Lzh0ZE5vNWhZVzJTNTJrdUJzZFJQVkdKQ2VRZGZSSFJtOGlNdzRyaW9y?=
 =?utf-8?B?cUhVTTFIT0lVYjFRSjN3NGoyRStCcVVkUngxY2llMERrMmYzQjl5WWNpcUth?=
 =?utf-8?B?NzBjelIyZmpVVWQwSkd4bkdSYjlMYmpubmlSa3kvNk9LcG1UU3pySWdkSit4?=
 =?utf-8?B?NUdJazRRdnJiSDZldnRDeTlYMTFCVWtrRk4yZVFtVitMRExGUk1wTUdhbDhJ?=
 =?utf-8?B?N2k5N0wrQVdUQU84Uk0xWmpGbE9ScHZVeklId2ppVStFL0VEeDIxazJpNjRL?=
 =?utf-8?B?V3AyWkNQR1Q5UVE2MFlhODZ0QkJyRWtJT2c3NVJqeGR0Yi9GeWpCcmJUeWlq?=
 =?utf-8?B?ZFFMVGIvem4vNjdwYml5dHlUT0pOWVArQXZ4Wkk0dnZqNE1PTngyQkg0bTk1?=
 =?utf-8?B?SWlSUklNNjVZWGtzTWl3S25oZTlHRXcvY1pMVDMvbkdoTUxGZFZBMmZoSFlD?=
 =?utf-8?B?dUpUenhXZmJvZlVudGdya3BBdGRyb1NiNStteDJFVTlTRGdGRWVwa0djVEo2?=
 =?utf-8?B?cEZ4N0srdU9yWndIUFd5WHFQdHBSK2ZyT3ZXc3J2MWpZaXNHVFloUUJNSnJv?=
 =?utf-8?B?UUlVSFIzcDl4TlhaZDJ4eDdOdnZyTnVNak5uME42NFhlUWRtb0xveUJIWGFW?=
 =?utf-8?B?VjhoMjhBaTJCY2R1bnoxVmtaY0RqdTE1QzM0bm1NdlRwckdhQmZERXBrWmFh?=
 =?utf-8?B?RGVpL28xaXA1a1l2ZUdlUkdZdHR1bVdoY1NMKzZBVjI3NUJMbDZiT2hrTWxD?=
 =?utf-8?B?bTNyanZuWkFZb0FkSGRKV05jWDdTaElWQzdIT3BXVEJUUnJ0TnE5bmQrQlEw?=
 =?utf-8?B?VnZwa29VV1FsMUl2cThseFY2Y1JiajR2M0VkRnU0Yks3OFJSOTdlQXNuaXdD?=
 =?utf-8?B?UlFpbUM1Tk5yMEdPeU14WHhBeVVNSnYvdUtTaGltK01KaEhXbnZYcTVhdlV1?=
 =?utf-8?B?eWlFdEU5NmwxR2JVZHlyNFhiNk95Y0Fna2R1N3Y5V3c0cUJTUnZlZjN3L1Ew?=
 =?utf-8?B?c2E0ZFltSHBjWldvTXRBWU9ZNStRMHJ4WVJlaG5pb2tPaXpTTkpSa1dJMjlo?=
 =?utf-8?B?VWFwam9acktOV3FleTltQThYdkFrd1NEd2o5U0czRW1IeERHSitzSURvbEI3?=
 =?utf-8?B?SVVZd3lLTXdLbmlCUFJOVXNVVmpKY0RsUm1iemdLa2libnE0ZkR0Mi95Ymdq?=
 =?utf-8?B?K09oZ0hIOTJRLzJrOS9ySG9kTHNjRW9peERUZGVUb0hWbGlCUHZ4TWlIazMw?=
 =?utf-8?B?YWpsVkRjcm9Bb1hid2JiRW1ZVDVCZ2FNYk5yMEoxdEtrbjJpOUJwM213akRh?=
 =?utf-8?B?TWF6MHZTdkE3c3ViWkpzNERlcTFkazRqNGFjN3BTUHE2WjlHOG4wd3h0amh4?=
 =?utf-8?Q?OKtHLPsTWpIvsVr8=3D?=
X-Exchange-RoutingPolicyChecked: cANl/clhfbEln+4ZFTGFkHGheBfEz5rtVq9/PtS17kpODZu4m/PyYPjUTVdL2kYUtSvI3ktmmAs6ktVaFJEL7Ov9TXDOR4jsBD2VbHc078F2R2Ae3fIHFO9Q4r2cUDLWSmNcVUiv5azW3ikLXkrOtgnoftzvZp/cUp+fBIze4Epw7fNdDbuJ4XbT/RgL44GiduUxybLJOzLza94CIH1hyUU983Bs/V/DN0CzjTLaBcihIEvoZOXLiGOWfgJss28tjCY9uNFA0Yaa28duulbsPtd9vwbJB1BTx4Xtx/2fhlwFCFJvcBExOnNQK3YFuPE+IWtXPJsEB4MMcd+dfmT/Pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 921ea8db-a92f-4462-fe0c-08de93decaaf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 13:17:03.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLBRnXtx2h9nVf/PHQbCBc14xOTjIY/KgjhXctD1bvlzWxeLPtWB2F+RKjH+ACkzPWZavaZVWSgZ2k0fNy1gM31qLKvXaHeQeLZVr5YfrcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
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


On 02-Apr-26 7:39 PM, Michal Wajdeczko wrote:
>
> On 4/2/2026 3:19 PM, Satyanarayana K V P wrote:
>> When a PF is configured in admin-only mode, it is intended for management
>> only and must not expose workload-facing capabilities to userspace.
>>
>> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
>> XE_OBSERVATION, and suppress capability-bearing query payloads so that
>> the userspace cannot discover execution-related device details in this
>> mode.
>>
>> Enable admin-only mode with:
>> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/unbind
>> sudo mkdir /sys/kernel/config/xe/<B:D:F>
>> echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
>> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind
>>
>> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
>> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Michał Winiarski <michal.winiarski@intel.com>
>> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
>> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>>
>> ---
>> V7 -> V8:
>> - Fixed issues reported by CI.Hooks
>> - Updated commit message (Ashutosh)
>> - Removed gem_prime_import from admin_only_driver structure (Michal)
>>
>> V6 -> V7:
>> - Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
>> Michal).
>> - Updated commit message with steps to enable admin-only mode (Rodrigo).
>>
>> V5 -> V6:
>> - Updated commit message.
>> - Return number of engines and memory regions as zero instead of
>> returning query size as zero (Michal Wajdeczko).
>> - Allow all other query IOCTLs excepts query_engines and
>> query_mem_regions (Michal Wajdeczko).
>>
>> V4 -> V5:
>> - Updated commit message (Matt B).
>> - Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
>> - Updated all query configs (Michal Wajdeczko).
>> - Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
>> - Fixed other review comments (Michal Wajdeczko).
>>
>> V3 -> V4:
>> - Suppressed device capabilities in admin-only PF mode. (Wajdeczko)
>>
>> V2 -> V3:
>> - Introduced new helper function xe_debugfs_create_files() to create
>> debugfs entries based on admin_only_pf mode or normal mode.
>>
>> V1 -> V2:
>> - Rebased to latest drm-tip.
>> - Update update_minor_dev() to debugfs_minor_dev().
>> ---
>>   drivers/gpu/drm/xe/xe_device.c    | 60 ++++++++++++++++++++++++++++---
>>   drivers/gpu/drm/xe/xe_device.h    |  1 +
>>   drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
>>   drivers/gpu/drm/xe/xe_query.c     | 10 +++++-
>>   4 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> index cbce1d0ffe48..eba2fa6dc7d3 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -25,6 +25,7 @@
>>   #include "regs/xe_regs.h"
>>   #include "xe_bo.h"
>>   #include "xe_bo_evict.h"
>> +#include "xe_configfs.h"
>>   #include "xe_debugfs.h"
>>   #include "xe_defaults.h"
>>   #include "xe_devcoredump.h"
>> @@ -216,6 +217,11 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>>   			  DRM_RENDER_ALLOW),
>>   };
>>   
>> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
>> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
>> +};
>> +
>>   static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>   {
>>   	struct drm_file *file_priv = file->private_data;
>> @@ -390,7 +396,7 @@ bool xe_is_xe_file(const struct file *file)
>>   	return file->f_op == &xe_driver_fops;
>>   }
>>   
>> -static struct drm_driver driver = {
>> +static struct drm_driver regular_driver = {
>>   	.driver_features =
>>   	    DRIVER_GEM |
>>   	    DRIVER_RENDER | DRIVER_SYNCOBJ |
>> @@ -415,6 +421,38 @@ static struct drm_driver driver = {
>>   	.patchlevel = DRIVER_PATCHLEVEL,
>>   };
>>   
>> +static struct drm_driver admin_only_driver = {
>> +	.driver_features =
>> +	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
>> +	.open = xe_file_open,
>> +	.postclose = xe_file_close,
>> +
>> +	.dumb_create = xe_bo_dumb_create,
>> +	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
>> +#ifdef CONFIG_PROC_FS
>> +	.show_fdinfo = xe_drm_client_fdinfo,
> do we want to expose memory or engines details here?
Fixed in the new revision.
>> +#endif
>> +	.ioctls = xe_ioctls_admin_only,
>> +	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
>> +	.fops = &xe_driver_fops,
>> +	.name = DRIVER_NAME,
>> +	.desc = DRIVER_DESC,
>> +	.major = DRIVER_MAJOR,
>> +	.minor = DRIVER_MINOR,
>> +	.patchlevel = DRIVER_PATCHLEVEL,
>> +};
>> +
>> +/**
>> + * xe_device_is_admin_only() - Check whether device is admin only or not.
>> + * @xe: the &xe_device to check
>> + *
>> + * Return: true if the device is admin only, false otherwise.
>> + */
>> +bool xe_device_is_admin_only(const struct xe_device *xe)
>> +{
>> +	return xe->drm.driver == &admin_only_driver;
>> +}
> I'm still looking for patch #2 which would update xe_sriov_pf_admin_only()
Sent in the new revision.
>> +
>>   static void xe_device_destroy(struct drm_device *dev, void *dummy)
>>   {
>>   	struct xe_device *xe = to_xe_device(dev);
>> @@ -439,16 +477,25 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>>   struct xe_device *xe_device_create(struct pci_dev *pdev,
>>   				   const struct pci_device_id *ent)
>>   {
>> +	struct drm_driver *driver = &regular_driver;
>>   	struct xe_device *xe;
>>   	int err;
>>   
>> -	xe_display_driver_set_hooks(&driver);
>> +#ifdef CONFIG_PCI_IOV
> maybe use if (IS_ENABLED()) to avoid complains about unused static in PCI_IOV=n ?
CI.Hooks reported compilation error for some configuration. So, need to 
used compilation flag here.
>> +	/*
>> +	 * Since XE device is not initialized yet, read from configfs
>> +	 * directly to decide whether we are in admin-only PF mode or not.
>> +	 */
>> +	if (xe_configfs_admin_only_pf(pdev))
>> +		driver = &admin_only_driver;
>> +#endif
> nit: add empty line here
Fixed in new revision.
>> +	xe_display_driver_set_hooks(driver);
>>   
>> -	err = aperture_remove_conflicting_pci_devices(pdev, driver.name);
>> +	err = aperture_remove_conflicting_pci_devices(pdev, driver->name);
>>   	if (err)
>>   		return ERR_PTR(err);
>>   
>> -	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
>> +	xe = devm_drm_dev_alloc(&pdev->dev, driver, struct xe_device, drm);
>>   	if (IS_ERR(xe))
>>   		return xe;
>>   
>> @@ -708,6 +755,11 @@ int xe_device_probe_early(struct xe_device *xe)
>>   
>>   	xe_sriov_probe_early(xe);
>>   
>> +	if (xe_device_is_admin_only(xe) && !IS_SRIOV_PF(xe)) {
>> +		xe_err(xe, "Can't run Admin-only mode without SR-IOV PF mode!\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	if (IS_SRIOV_VF(xe))
>>   		vf_update_device_info(xe);
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
>> index e4b9de8d8e95..c220f2f1352f 100644
>> --- a/drivers/gpu/drm/xe/xe_device.h
>> +++ b/drivers/gpu/drm/xe/xe_device.h
>> @@ -43,6 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
>>   	return container_of(ttm, struct xe_device, ttm);
>>   }
>>   
>> +bool xe_device_is_admin_only(const struct xe_device *xe);
>>   struct xe_device *xe_device_create(struct pci_dev *pdev,
>>   				   const struct pci_device_id *ent);
>>   int xe_device_probe_early(struct xe_device *xe);
>> diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
>> index 337baf0a6e87..2c324acb1dd0 100644
>> --- a/drivers/gpu/drm/xe/xe_hw_engine.c
>> +++ b/drivers/gpu/drm/xe/xe_hw_engine.c
>> @@ -1027,6 +1027,9 @@ bool xe_hw_engine_is_reserved(struct xe_hw_engine *hwe)
>>   	struct xe_gt *gt = hwe->gt;
>>   	struct xe_device *xe = gt_to_xe(gt);
>>   
>> +	if (xe_device_is_admin_only(xe))
>> +		return true;
>> +
>>   	if (hwe->class == XE_ENGINE_CLASS_OTHER)
>>   		return true;
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
>> index d84d6a422c45..b10a281c6ae0 100644
>> --- a/drivers/gpu/drm/xe/xe_query.c
>> +++ b/drivers/gpu/drm/xe/xe_query.c
>> @@ -231,10 +231,13 @@ static size_t calc_mem_regions_size(struct xe_device *xe)
>>   	u32 num_managers = 1;
>>   	int i;
>>   
>> +	if (xe_device_is_admin_only(xe))
>> +		goto out;
> or maybe just:
> 		return sizeof(drm_xe_query_mem_regions);
Fixed in new revision.
>> +
>>   	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i)
>>   		if (ttm_manager_type(&xe->ttm, i))
>>   			num_managers++;
>> -
>> +out:
>>   	return offsetof(struct drm_xe_query_mem_regions, mem_regions[num_managers]);
>>   }
>>   
>> @@ -273,6 +276,8 @@ static int query_mem_regions(struct xe_device *xe,
>>   	mem_regions->num_mem_regions = 1;
> IMO we shouldn't attempt to fill region0 here, and then memset it
> but just jump to ...
Fixed in new revision.
>>   
>>   	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i) {
>> +		if (xe_device_is_admin_only(xe))
>> +			break;
>>   		man = ttm_manager_type(&xe->ttm, i);
>>   		if (man) {
>>   			mem_regions->mem_regions[mem_regions->num_mem_regions].mem_class =
>> @@ -297,6 +302,9 @@ static int query_mem_regions(struct xe_device *xe,
>>   		}
>>   	}
>>   
>> +	if (xe_device_is_admin_only(xe))
>> +		memset(mem_regions, 0, size);
>> +
> ... here
>
>>   	if (!copy_to_user(query_ptr, mem_regions, size))
>>   		ret = 0;
>>   	else
