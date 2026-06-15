Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1263ACD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEEB10E298;
	Mon, 15 Jun 2026 08:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lHC28/8T";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5664210E27D;
 Mon, 15 Jun 2026 08:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781511447; x=1813047447;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xA1pLRZEPPVVHTQliQMNXHFtWXDqLOOEw144R0tT0SI=;
 b=lHC28/8TV97WQs8BfLg2ffJqopuR8R/9bLZb3sOSsRZpICKBXETCXlKS
 yLMhWdL/mXpFo/t73gk+H9iw6MTMOio9Zsg+HypV/QAOHhFAusPYPMX9e
 sdO2GPuglDKUQN7vUpGck4l0ldEk8KlmTbEYYUWKkyuuoVxFuThVFKZUd
 rtH7q86iPEbmKSo3Fxz4JobicFJk2LNsywKlU+nJm4VU1nTMzE8W/xxw1
 r5blMr6Jp/Ur5BxXHFS94G17357Q7jPO9llLMtn15WaSojxQIPGWp5Wkn
 L0FKNLRE0E6ZlZaDKyBinSAZMYhfwO33TN700rVckcxSGmhMNLE1fjUUL A==;
X-CSE-ConnectionGUID: yKrCznQHQ2aMpGWFZ9ESrA==
X-CSE-MsgGUID: pCaOA4ltTSCEm3lmOAOR+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93361816"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="93361816"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:17:19 -0700
X-CSE-ConnectionGUID: 9fedjiecQ2mJQ9eD/N87Mw==
X-CSE-MsgGUID: BpBfha36RiSDKYgvstFU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="251685958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:17:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:17:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 01:17:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHQQKTkjH/PhVsj6GCP6kB1kAsf5no1QTLhz/OQ2IOfuu4JJ+45Oq7jnWUenZ15z7hDyIp2AU4XXULbSHcZrHXHRqlemscG7Kc+UURT5IdD7MvxbiBue3ZHMD9BnSc1md1FflgnbBxVI6H3XWD0EauGIZSB/3xhhatol0KyNmn1UcRbbrMsfu9LQ/pctODyMHImY3h5Nk74BB70J0QSG56/lLybXpWxcI0o+hwZnjbqz0IrAjqmzcjdig3VhXYisDFFE48/lEtMDlD4QrQ0pN+vz4y1BRZsjU4svCgPaE3ok97I4ocNGlaoyTnPQxzdw+S6Jl/CJ7sDnC9ngBrT3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aKb+omOlyTexOqnpFFlX4y01eUIwcpmQwXGldg2TCg=;
 b=Om9gY3A0XUOhLDxyU51rbO0oCN/lc63ho1LQiiO9HfYdz3rDDGtMnI/ToxyvqbBLtw+BL5UYUzymKbb2JWoqhIoNv+jDEMM68PyudzE4ZqVd1LWsBx4uf+7vL2gi2PaUvuw2vzGzbdJ12Ytj5hXRph8bAhcrb9X8LBb6iXwgIPbytpzLm8Wzpvngsb969YK8NhFMolCW73S2G6Z7I+cevc1DEL1koZkB9vvf4TVP2VzY3aQs3nJu51y0ffZOTJTSIN6Gdt9P66GMKx+GdKjC+9fAnk/0LcKe52vBN0oUaCr7gLIvS4XYv4on6nZUjYU3tatORE5OY3XC0PuMF7ankA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.16; Mon, 15 Jun 2026 08:17:13 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:17:13 +0000
Message-ID: <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
Date: Mon, 15 Jun 2026 13:47:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/xe/ras: Add support for error threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
 <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <dev@lankhorst.se>,
 <zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
 <michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
 <mallesh.koujalagi@intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260604184849.1011985-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0296.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e85a7e2-71c7-4c87-6c1d-08decab6811f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kFvgWoA68CQkDCnODOnlqt+RfN1g+Atxo53KddoJEQHutpfuu/b5SfTgRnoCIM7N8Ps5ngET1L7Uj2Asfb9eeB1wlKW/xau9Fzo2sbvWsuDNSeQOjQQtfjve1ylHRBHrznEdxsrLFe+hY08f5fQMLtL5o7N/zH2TBxlf3jzFBw8G80DZ1jU0dVK9E1EXmjeyFZ00Zh7TY+71HqsxaC/RqBRENuPr2JMcM4ggyzR84WJ5pRMa9Q0J+mOLboatwh9Wp7uHRc7RotT0cVLvVDk/BP47f1BDFs5OxEgOdthQRabtk2BeTN6AvYefKY8uEo0tRdmFqhI8+8TUEqxJdNXjv5fgI3wZvNPpXLNRqZeGT/uCFcSK8inxhrljuj8W7IdUZbMc8c2qr3whGUO496zjauCyi/ebhd9RNVvzSm0HE/lfr90fKtlYUg2SZR0jEIFgvQtxHakAnfQM/3uRRe0imFdOon25JVfPbL/pRRv1n9rb/4TmNRRFRUTgQyoeJqUE5O5AWxeswbemmbe0Lc0zjNF7BzZihasyA2Me78Cpz1bReKqvJd9HcHCiljKTcvRa5r0jdI+jsgPoMfXzgEl4PyEF4TgosA7LGV8EiUTiwlAACuMN6tXMYRqVHW3DphuJprUaiAzhzNmHz4Az+IithjPdgmvg0kQzSSBDa3fBIWIZVMJRL+KmFFyQliz19tbh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtybk1rbzJ6Nk1GSjFBcnNYTGh3ZXBvM2hXQjZJeS9neUFqb3NPQy80YUdN?=
 =?utf-8?B?cnVEWm1ULzBmcFhHZlhPYXdjZjRWak1vSC9aMU9rY2N5YWpzSXRpWnBwZ3lV?=
 =?utf-8?B?b2JhRDNiMHJHRDZqYmVnYnlpeTh2VG9xR0lNcmIwMmNoY2JxYjdLQWhqZlVY?=
 =?utf-8?B?YytsVVQwS1VVSFgyMnFPcUFkeXJPSDI3ZmF6V2ZXUVRzaklPWTV6QmE0ZGtn?=
 =?utf-8?B?YmtPNysvTDZ3dzZRMVRxdUI0MFB6cmlCK1RMRkVhTGoyTnBoV3lxMEFFRjh6?=
 =?utf-8?B?Wnc3YUR2S2FGSHBJQjc4QnYwKzlubHFQL2JWUWloeDNGeGlDblV2OFI1cDhk?=
 =?utf-8?B?T0FBa3k0cmpIaDBTQXM2eSs3NE9ic2o1Zy95WGhWU1FoR2t6TVBTR3ZHeStv?=
 =?utf-8?B?QW9naFZCZ1RYTzJxYjhPNEVEdEJ2R0kveE1nRXhvMUtsYXQxbjlTbWpHUTlo?=
 =?utf-8?B?LzlnNS8zbFBxc3Jsci9SVm9NVmd1OXdTSjNZUW1aaG8yN2tWQ1Fsb2RoUHNl?=
 =?utf-8?B?WlZCR1NiSVQwMHJ6eXp6RzhaUllaZ0JEd2NPbERVUVJoRjBNT3IrRURoVEpX?=
 =?utf-8?B?ckM2WElEUTY5SlVnbklPSk0waGc2Ny9STjBsNmt6bEpFb0MvOHdLUDU2a3M4?=
 =?utf-8?B?WWk2bXlGNG5STTNLZUJQYVZiM3ByaURDanJGZ0ErczFMNldieC82dkxudVZv?=
 =?utf-8?B?K1poTUQ5V21aeHQwQ3NkVE1RakJ3d0Nrd2pTb0dSYjVOWFd1b1ZkdXFHeXdZ?=
 =?utf-8?B?VGxpdnhBaWRRdXA5SU5MbFBsZUludVRpM1FYNEdiTTlPOGNGS3dBUXZKSUh6?=
 =?utf-8?B?YTlQYm1PU0ErQXVrVWVNaDRvUGNCVW5Ra1loYWtoby9MYjZRa2tIUXF4d1ZO?=
 =?utf-8?B?SWtTeEQyUlkzZEllRE44MFg4Wm9USndmcFdxa3Y4MkZXRkpHQ1d1K015ZTMz?=
 =?utf-8?B?VmhLK0Z2ZDRxbk5ack45YktxdjdXVW01aVZKTkk3Zk9UYXVSZDhvYnFrY0hI?=
 =?utf-8?B?MCtyY1BrVlFOYkticTlRYlNVTHNtVERDdTExbEFoRUwxKzdpMm5IRHl4cUh0?=
 =?utf-8?B?allEUWdPTmRJTFFYYWtEQ2JzdjJ5bFl1R3NIQ1ZoQW5FcTRlRi9MdHBqWCsz?=
 =?utf-8?B?QWMwR0oxN0JqSmhEWjRBWFRVSzlmMjd1LzF5UWcxUDlrbWFUTDQ4b1pKcUtx?=
 =?utf-8?B?MGN3V2ZZN3U1ZTBITTNKSExxOE9qY09oQmJ3dllsTzBuaVpHWkRKT1Q5amVu?=
 =?utf-8?B?WURWQ0tBZTAyditGaHBmK1VNcm11amkrbG1NRkJNMGY0QWZUdFpvZXhjOU9y?=
 =?utf-8?B?Ym05VDNlUmZuZWVQcUx6aWtISlRHcDBQWmhFK0hOVjBCQmlkclBBdTJSZWFt?=
 =?utf-8?B?U2pZZFAvVnkrc1V5Qjd4VG4rWjFHdmE1SkFuSHE4YXVYNlR2VVRuTW1NMjRw?=
 =?utf-8?B?QnM1azRocVBHVkhvRTRvWVRlYnNucW9VdWQ2NUtpbU1WMDdGNGIwOFlZaEpn?=
 =?utf-8?B?RWxYRC8wc0hFS2xlbW55VXFmc2diWFB3OU44UWdlMFUvOVdzOHY4amxnbTVQ?=
 =?utf-8?B?UU5uWWpTYlNQd1VYWndkRlMySkNycmdHVjNmUkFpNGd0cEtvdGpkZ2orWlAv?=
 =?utf-8?B?TkI0bjhvV2haVUR1VjdmK3dDTS80VmQwc1Bya2s4bmZXZWlFSi9Idi9KbHhX?=
 =?utf-8?B?TUl2c1Z6VGN1N3FETUh1dzhvb05hTFJVMjZGUElYZzlVT0RKaDVhL2lhcnk2?=
 =?utf-8?B?NWowbzVkV0pVRnREbmt2cDBvK2ZiMXlFdm1TdWozYWhUZysyakZwWHJ4MUJu?=
 =?utf-8?B?aTVwWGJnaEtlY1l5SU81YStuQ1g4SFA5Z1F4QWlad21YUDVJYityN2tJeXVw?=
 =?utf-8?B?bThyYmhWdGt3SUg2K094U2lkaWZDSGtacU9FWnNXSDcxeHh5dFFEVmJ6QlQ0?=
 =?utf-8?B?ZnEyci9CTG5hUTJaUFg1akxVdTdseGtsd1lsV0JmVzBFYVVDUGw0Mjc5eks2?=
 =?utf-8?B?ZGNNVS9PbE1vTnpXekt1bzJYelYrdjJDTnpiVFZSdC91U0JMZ1lXMUxnVyty?=
 =?utf-8?B?WFhkTWVKTTR5VXp6SmF5clNUSGxtTlB1OTM4TzdLa1NqVTN0T2FkbG1rdGNL?=
 =?utf-8?B?eG9wcks3UDBwZ1lHRk96TnlIVmxWTXgybTZRTUdxODl6SWQ0cTVjaTIzUUhV?=
 =?utf-8?B?RXVZcHZlMzdteFBMUU1pTnBRdWVEVVVBL0k4MHhTa2hKTnhFNnMyWmYxZXY1?=
 =?utf-8?B?VkZGN0tLaEVma3NpOWJWUGd2Q0tWTi9IS0JhYm15VUcwT1lFbTFFMlBZeWky?=
 =?utf-8?B?eThtWk5hL2l5cmxlNERNbmNSaEcvVzcyQkp0QmIyTG8yMW54VThDdz09?=
X-Exchange-RoutingPolicyChecked: D+tZV0gbX/KVmHcJmuaDo2qAxD8nK/xPs8Tq/6wdokqMulQO3MJaJdx+79Z/pn8iqZz7wgp52C8/hl4kLy8D1s2GTxyKczk5SWlVY//qhb5Tx3WZHQB8dG7KWNtR3a4QJrLVKl/1uMAdy5so9cgitN5PbTiDBFAFNUob5Mcn1x/G6xju4QAGtET5SebAnRiJnH30hv65Z3dS1mizXQeCazcpNGNMdYfok3pc52rmAzE6bpZtKheNDvZJNAU2ZJCndNdU/MTPo3ecu9hHEms+gh9PZD1QY0PBvb8Bb+SS6ncn5N1vpLEgECw8B3dr6cKrVApX9DQB839uu6oYOy7Sfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e85a7e2-71c7-4c87-6c1d-08decab6811f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:17:13.5816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSZTtRHx/0pT6WOUnACsXqn5uVsr6IveEp8Qj2sWKdu6uRCs79U/1feLUs0c0NW6XCmZeavrfbx3jeb9pui5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
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


On 05-06-2026 00:16, Raag Jadav wrote:
> System controller allows getting/setting per counter threshold, which it

for correctable errors.

> uses to raise error events to the driver. Get/set it using the respective
> mailbox command.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Add RAS operation status codes (Riana)
> v3: Reuse status codes and uapi mapping from counter series (Riana)
>      Access request/response counter using local pointer (Riana)
>      Mark unused field as reserved (Riana)
> ---
>   drivers/gpu/drm/xe/xe_ras.c                   | 105 ++++++++++++++++++
>   drivers/gpu/drm/xe/xe_ras.h                   |   2 +
>   drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++++++
>   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
>   4 files changed, 162 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 7cb6fcb1254a..d6f89b429cec 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -270,6 +270,111 @@ int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
>   	return 0;
>   }
>   
> +/**
> + * xe_ras_get_threshold() - Get error counter threshold
> + * @xe: Xe device instance
> + * @severity: Error severity to be queried (&enum drm_xe_ras_error_severity)
> + * @component: Error component to be queried (&enum drm_xe_ras_error_component)
> + * @threshold: Counter threshold
> + *
> + * This function retrieves the error threshold of a specific counter based on
> + * severity and component.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold)
> +{
> +	struct xe_ras_get_threshold_response response = {};
> +	struct xe_ras_get_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class *counter;
> +	size_t len;
> +	int ret;
> +
> +	counter = &request.counter;
> +	counter->common.severity = drm_to_xe_ras_severity(severity);
> +	counter->common.component = drm_to_xe_ras_component(component);
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_THRESHOLD,
> +				  &request, sizeof(request), &response, sizeof(response));
> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	counter = &response.counter;
> +	*threshold = response.threshold;
> +
> +	xe_dbg(xe, "[RAS]: get counter threshold %u for %s %s\n", *threshold,
> +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));

"get threshold" to be consistent with <operation> <value> <component> 
<severity>
and other prints

> +	return 0;
> +}
> +
> +/**
> + * xe_ras_set_threshold() - Set error counter threshold
> + * @xe: Xe device instance
> + * @severity: Error severity to be set (&enum drm_xe_ras_error_severity)
> + * @component: Error component to be set (&enum drm_xe_ras_error_component)
> + * @threshold: Counter threshold
> + *
> + * This function sets the error threshold of a specific counter based on
> + * severity and component.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold)
> +{
> +	struct xe_ras_set_threshold_response response = {};
> +	struct xe_ras_set_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class *counter;
> +	size_t len;
> +	int ret;
> +
> +	counter = &request.counter;
> +	counter->common.severity = drm_to_xe_ras_severity(severity);
> +	counter->common.component = drm_to_xe_ras_component(component);
> +	request.threshold = threshold;
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_SET_THRESHOLD,
> +				  &request, sizeof(request), &response, sizeof(response));
> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	ret = ras_status_to_errno(response.status);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: set threshold command failed with status %#x\n",
> +		       response.status);
> +		return ret;
> +	}
> +
> +	counter = &response.counter;
> +
> +	xe_dbg(xe, "[RAS]: set counter threshold %u for %s %s\n", response.threshold,

set threshold

> +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
> +	return 0;
> +}
> +
>   /**
>    * xe_ras_init - Initialize Xe RAS
>    * @xe: xe device instance
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index ba0b0224df23..1aa43c54b710 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -15,6 +15,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   				      struct xe_sysctrl_event_response *response);
>   int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value);
>   int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component);
> +int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold);
> +int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold);
>   void xe_ras_init(struct xe_device *xe);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> index c6392435d1c6..8ea817583eed 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> @@ -121,4 +121,55 @@ struct xe_ras_clear_counter_response {
>   	/** @reserved1: Reserved for future use */
>   	u32 reserved1[3];
>   } __packed;
> +
> +/**
> + * struct xe_ras_get_threshold_request - Request structure for get threshold
> + */
> +struct xe_ras_get_threshold_request {
> +	/** @counter: Counter to get threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_get_threshold_response - Response structure for get threshold
> + */
> +struct xe_ras_get_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold value */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[4];
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_request - Request structure for set threshold
> + */
> +struct xe_ras_set_threshold_request {
> +	/** @counter: Counter to set threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold value to set */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_response - Response structure for set threshold
> + */
> +struct xe_ras_set_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @reserved: Reserved */
> +	u32 reserved;
> +	/** @threshold: Updated threshold value */
> +	u32 threshold;
> +	/** @status: Set threshold operation status */

Nit: Already part of set threshold.  Can be just operation status

Thanks
Riana

> +	u32 status;
> +	/** @reserved1: Reserved for future use */
> +	u32 reserved1[2];
> +} __packed;
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> index 6e3753554510..10f06aa5c4b5 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> @@ -24,11 +24,15 @@ enum xe_sysctrl_group {
>    *
>    * @XE_SYSCTRL_CMD_GET_COUNTER: Get error counter value
>    * @XE_SYSCTRL_CMD_CLEAR_COUNTER: Clear error counter value
> + * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> + * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
>    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
>    */
>   enum xe_sysctrl_gfsp_cmd {
>   	XE_SYSCTRL_CMD_GET_COUNTER		= 0x03,
>   	XE_SYSCTRL_CMD_CLEAR_COUNTER		= 0x04,
> +	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> +	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
>   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
>   };
>   
