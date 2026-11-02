Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD22606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvJcp2zx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA7610EB4D;
	Mon,  2 Nov 2026 05:51:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC4910E57D;
 Mon,  2 Nov 2026 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793598707; x=1825134707;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EeOrBmQYC+qYV1e4HQdDq+aH7JWegPJqgS0gyVKf17Y=;
 b=kvJcp2zxMZwGwP4isTpuMjwP3RxMdJunwQsapz72/yCz9fSsSvVZoltx
 AbiihNukOLT4co8WjLZdpm8DMPSWKeevhlh6Ta1dGfjne4SwtRVLQNs5e
 AmhesXkJjFBikPp6uenfoM8zUoEI2K6HxOQUlFBThfFWlSW0t4S0sDk1c
 w789UB7rSeqHu7Mgh/2W7yLLUf/P5RBXCHP20F9FXPmcIIDjvHEK/dNCQ
 VSXAGEsK2EMdYtdSSu6C5okpt4SheJLFSwS14DHsmhK07c+rRJdBRKRWO
 yM3lVxoNbsTQY5anEOjW6eNCoWK31TAZlcjetSH2mQwxuEbTBiHBqN7Mr w==;
X-CSE-ConnectionGUID: 2GliUt2fSCWjh6vzsVPz0A==
X-CSE-MsgGUID: +qDP0aTGQ5Cc9XrTPekcpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2161345"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2161345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:51:46 -0800
X-CSE-ConnectionGUID: XirbJSqbS3GCbi3WvXlSWQ==
X-CSE-MsgGUID: Srenrr4sS6CMByOYCSh3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6123644"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:51:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 21:51:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 21:51:45 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 21:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsnKkS3v9y3xK9Sdih6Wk379A6Q8KClaLLaInOMPyaMazLHUL+c8L/4DmclP2c15nCnOe+AzlfpXw51C/MTSJfL1hgbvXeb9vwImlFFRorneUgJGWIcEjGuwaruLbE3nxniRxZGEz2LwuHA3PVL+N7qq9FJqL3XmSrHTsUt+5thZNDm7dT81+nwJkVjTSKTLKR9RblVOKXSeh3Er9lhMi++tgc/1OjjLIAoTwFmD8JI6Rlie02KxA9MVsxbyyPDFl/30WFCqBUAZB/8v/0uOYX7oYknhXTDEKMSetHm0Gh2H6Fdn4LJ3QcvyvsqkwBKqZJlP7C0boqbRrtgYYPIdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9CbdyjJZmzOW3i0d+gNTzQpTX4f/hPawGmtksxXLeM=;
 b=I/qjtPpwbYCRPMEM+xRid0bsarL6st6z6pncPlnFtzYFmlPaPdSafWiehb1LWXcd6/x/ohxxqWlKxxx7/Sdah5WnlnKIrBu/R1UX4/Q8+nRkPyMKfBVozY7pDQuCEke4VsSTR9UiFHMVgWxiGMD1UMhO9iBVO4QxFZpg2ihyp2ZwOfzuhm1+NICXUJlMogR9awm78KA1fCFRKACKLa9gUm/4I3gVTW4XuIWgxOQW4m4EQwmm/IjvTmAsZY0j5p81f2A2xHm+Y7a/hvlN3GtwDxMlMFtkQRTNxRpLQQbzwUb5E4nn4UOTcjOW003tyL4EJsa2q08VMTO5zgsx3prSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:51:40 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:51:40 +0000
Message-ID: <97194eeb-c204-483e-9945-e76db69b3fee@intel.com>
Date: Mon, 2 Nov 2026 11:21:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Matt Roper <matthew.d.roper@intel.com>, 
 Raag Jadav <raag.jadav@intel.com>
References: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::16) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 164d1661-a869-4659-42f9-08df38a55d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S7Qy0CBmbP1/cB5PTj/npMGyzY18Dtqxa+K0/W7G77T3UTiDR4gNagwmmMs4+bc9TssD51K8CFMGXorIt5nADMjX0sVXEVCk24ewK3KZa4Z5+yPfm82hzl10fh6Q1Ir6J2o/YK3sE+upydQOCyUxr0fvHVubyvGdTE9CenF+41uaPw+ACgmlpM5gu3xErBWfGMQx0UmtvfwW5PkAG+bR4usjIJqP3poOPhLPbl6hQqpX+fsKmWitwPOBi9apoLzd76PuVukqaA8dSnrPl8i0bY9AC2dVBFua2Vc4kTP2o5uxAxG69SMrcAcQ5t+LqsjE0ZfqTmyjB873GEIsh4t8fhmP+jXDAktbZ1kTfMY/MZoyUmDAKvQIIdZZnXCH3H+4LhQ4qGrnRR4kQ32oqcLmloeXiK2RrKTVhVLDk7zaUJ2Xj1EwIi/Eb7EDTwlkcQJCXCd8KPTnJQo4FMeim7NkgBxs86FfxfhQ7sgSZ7rUVdwZhCW70UfF810CtDXXl8SPSAh4VtNiDs80mvIfu3PL9PRjAxncuUEDxuJOSeymTvvtrIdlh1NzqOvr7ejA1J2fqieETQwMdBDCZG/74ygja7U3eePUnW1QfLzwfqiBItH+hdEjaGqtpDbkp5XcCgUOI0CWdhyk7JSXJxcynF3PAHhPX/l9joHX9IPjuzpI65s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVYTGwwazh3dndMb0VGR2xPTlhBOUJaNytQUnQ4MUZFdDRkN3hiQmhrRDU4?=
 =?utf-8?B?R0tmNXBtOGN4ZUR0czhKMElRdkhocWxBSFZyMEJNQVJCQ3VVYTNFUXR5UnpK?=
 =?utf-8?B?NzhCS28zRGhicEF4TDYrY2lVayt2bDRUb3BUMEFzUDd5ZmlBL2xTdUJzZ0d3?=
 =?utf-8?B?NDJWUkNTOGRxYmJEdWt5YXc3bGF1L2NrVldYTm1vVy9Qd1hPbnhCSXVndFZF?=
 =?utf-8?B?Z3U2QzkrMFFtOS9YVUpsQ3N6eW1RcmNYN2hWZDNOTFBVZzBOOGJhZWhsRHh2?=
 =?utf-8?B?c0d1QXg1ZWNWU3ROeTJjYXNKWTJiRDVBL2Y3SHlOOWl3R3pjYWdwMFdHUW94?=
 =?utf-8?B?SVBIaW83NzhIRHBKckVxS1gvMG9aSDM0WVZMakJmRzJnSVNNaG51UEViNnVm?=
 =?utf-8?B?bEI5YmczQUpEVmxjd2tNc29qMDRZTGdOb0JhekJKVk9oNzlrN0ZKU0FyYVNS?=
 =?utf-8?B?akY5U0lEL0E2VllDcEpaSWY3amZjVGpFb1I5UEpBclRUVUl2b09HYnV6VEN4?=
 =?utf-8?B?OW41cDVGd1FJTVFtUkRyV1RyQlBqcTFhRUVrRW5halg1WDVrNndvZkdjMU9w?=
 =?utf-8?B?dGF2V1pDUnYzdEhkWXBCNW5XZzFGMC9qUGI4ZkU0bkNyT2YxamR5OUVzTTNy?=
 =?utf-8?B?VG5CNEp5VzR2Nm5MeHRoVHZTc05uOUNhYnZrbzZkemxySFhnTzZnMnZWSG9T?=
 =?utf-8?B?eHcxbStJaTQ5NU1jTFNwWnBZVmI1bGw5Ti9XUitNcHBmaVIzYktSQmJDaE5z?=
 =?utf-8?B?MzNkSDNpYmN4ZFdzZzlKOVZSd3hRVVJHVGJCb2wwWVMzcFRZaVkzUng0Tk1y?=
 =?utf-8?B?VXJleFVqTkxObzN4YUpaMWJSVkM1N0IxMnZtWGhSdE43b3RxbzRHaTJKVVRw?=
 =?utf-8?B?Zi80R2FveUNtVGQ0YXhsY3ErN3FReVhTQ2k1Skk0QmErZWI1dk01dlUwTklN?=
 =?utf-8?B?Zk5md1VTaVh3UjV5YXZhVnFtWWxUOVhZZGRDLzJkUlEzcmF3Wi81eFVBb2ha?=
 =?utf-8?B?TEh4ZThaUUdxSy9jSjVUa05iZlQ4ejJnendrOWlWV2o1TmM5SXJjZXY1bjdQ?=
 =?utf-8?B?NW1HWk02NTkyTDNlV1lnR1QwcTVaQmUreFRzcTBENUJWUzlGN3VGN0xvYi95?=
 =?utf-8?B?b3F1dExGTUJYdkxGOENZU0R4U1BaR0cwZmQ1TFdDUDgyUHYrVTdPTVNNUkF4?=
 =?utf-8?B?cVJtZzVpSnNLdjNPVC94bjQwcWxmZFE1b0diOTRRR1gyVHNDN1RHZjFISmhu?=
 =?utf-8?B?dXd2dG9YMzc5K05TOURnYzBpSzh5Mkg5NUxIZk9WNjh0MXQ5L2g0ZkE1ektO?=
 =?utf-8?B?akdhV1l4QnJkWGZkS0ovOXNWN0ZtSFQ0eWIrOU5SL0RiWnJmaWhJNGJkLzhP?=
 =?utf-8?B?c3A2WEk2NU1QQzUvRmk5T3d2TG13TWxSSW55VEd2SFBCNVVublF0dzVNaHVM?=
 =?utf-8?B?SGordDZqRDEzVzBxMHQwUFdSSXBUMVA3WUFvSHF4Z1kxdlM2dThZSk1xaTBB?=
 =?utf-8?B?a2p3azhudjVSR1BlSnJseGxOdzhzQjl6VmYyRUIrNEREVFY5TmlNdDdrTE03?=
 =?utf-8?B?MTcxbjU0OWhjdVcreWdmTjkxdjNic1Q5bjlsSTA3dGRxeU5xYjd1SHd1dC9C?=
 =?utf-8?B?OHNsVnY4RjJzZFFuZmRQZTRlOHFwdTRmZmVLa05jYzgvWTBCVTd4S2cwNVd6?=
 =?utf-8?B?M0ZvWmIyNDJiME1qcjZQdithK2laZnZ6MTNIYVd0T3dwKzU3TGpXblN4a1ly?=
 =?utf-8?B?S2RIRDlXUnBzcWJaa2I4MWFQWFdhNHdERFZ0Vm5yUmpKZ05ESTh3K0pjZHdj?=
 =?utf-8?B?VmxhQmR2MC9SUE5DaC81bVZWWURiUzN3aEU3VFhhTXFPUkVMRllkMUZzWTdR?=
 =?utf-8?B?Rk90c1k5cGk3UUJQN3FUZ2NKQzJ2RDFQTWYycGlsdHZPeFN2R1ZQVFpicmRW?=
 =?utf-8?B?WW9IUC9Wb2xCNWowampnM24vTFhIWm5VMW9XVnJWNFFITnQ0VzdTazV0T2kz?=
 =?utf-8?B?YVRjSDBhWmdQd0h3bzVSNTQvNHE5Y2g0bEJ0bHBuMFM3OXF5eVY2cnpmeVVQ?=
 =?utf-8?B?Y1R6MU5jZURIcWo3bmNHN21qbG53ZmRhMnRlOG5GV2ZiZ28yOTJaeHlCc2Uz?=
 =?utf-8?B?Zk9pTk9rWGNnMlBIb0lGMXZsSXh2Y2YrbkJyU0t3OHdrTjZIYmdoSitkclF0?=
 =?utf-8?B?YTVkQWxVZE1qYVYyb1A0U0pxaU5pLzd4ak9uaWpYb3hCWHhBMDd0dWJLQndw?=
 =?utf-8?B?TG1NRjFiRGM4WURNanFnNWt1cytTNGZwZG8zZUtybmxrMENEUnR1ckJ5RXdW?=
 =?utf-8?B?T041VGdXY3lOYlVjWEplaEI4NjdqOGFvUE00YkRtRnZBM3N6RFVZdz09?=
X-Exchange-RoutingPolicyChecked: G8llTxlQvEnC7HISDOFvf4al6QafseQsxYeFbHG1og12nfcdZHLq2CajKgIMu6OjD5kBy7TJk54A5L134kfYH5NFkIvpr+5bFntCXToS2nE3QGh2hZtyhPc/kNPUIVO/efZMcpQDxh3pIIcbzqFfhtzRTHrNdWw7lY+d+Chj61cM1yHMkZwLrpphxUwbebntIqO7VjHhjM7mtXvvRmdzxyDLStHdXHbGtZUVKKXrWZRPVGi3p9c/cx8tdgHenIXRpjbvO9KNA4JCmLcEaFDpJB0UbLkgbTpCaQ4CjBnhYgWT6fU/nXfAKFxk5nylpECdynD7yF+RS1RVAKOsRVHbYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 164d1661-a869-4659-42f9-08df38a55d60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:51:40.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6ibh3drLDPxbTQSqBsFu8reJNL60AynyxtaOFYQP+nVAhU9FwcTXcFntSHj1dPd379uoGnb+9uSFgHyEpOI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 30-10-2026 22:47, Alan Previn wrote:
> When user requests to enter survivabilty via configfs, or if
> check_boot_failure is hit inside xe_survivability_mode_is_requested,
> no indication is published. This patch adds some awareness in dmesg.
>
>   v3 : Limit message to xe_survivability_mode_is_requested. (Riana)
>   v2 : Remove / modify messages to reflect underlying behavior. (Sashiko)
>
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_survivability_mode.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/xe/xe_survivability_mode.c
> index d73cdad0b3a9..344b402eb728 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -413,13 +413,19 @@ bool xe_survivability_mode_is_requested(struct xe_device *xe)
>   
>   	survivability_mode = xe_configfs_get_survivability_mode(pdev);
>   	/* Enable survivability mode if set via configfs */
> -	if (survivability_mode)
> +	if (survivability_mode) {
> +		xe_log_info(xe, SURVIVABILITY, "Boot mode requested.");
>   		return true;
> +	}
>   
>   	data = xe_mmio_read32(mmio, PCODE_SCRATCH(0));
>   	survivability->boot_status = REG_FIELD_GET(BOOT_STATUS, data);
>   
> -	return check_boot_failure(xe);
> +	if (check_boot_failure(xe)) {
> +		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
> +		return true;
> +	}
> +	return false;
>   }

Can we also remove logs from enable_boot_survivability_mode to avoid 
redundant logs.

Thanks
Riana

>   
>   /**
>
> base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
