Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1ADFF4941
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC76210E263;
	Mon, 30 Mar 2026 04:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P3nNh71i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACE610E263;
 Mon, 30 Mar 2026 04:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774846566; x=1806382566;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e6fy7AmllIAXERfUMA5oUOq02B1KZa0buAH+m6BI34M=;
 b=P3nNh71ie0CayLCh+1J9CifDMR/68RoE+1VQTquskrgAsoJ/ju/1EgXi
 zqCKbkw77E2iA9rK1fAAKnvwB7gvGahyEHaRErhzpIN8PH6o8K0T/QV5X
 L3h7xERxvzVKVZL/1FW48QbRn+sC2wpSloOXUR32uzSZ3X/EH6KY2g9Ao
 +86zJ8x0lUnSlUUrLiNz8A1PlN9msNYYLVmRVa1wC0bCdkypM95gjcGQp
 DvnQKhstSgyye/c8Q6+7bj7vhCXpiZ9pqDRLsHaip85vSfhl9qfFjNzci
 +hxYfUZ1dc9+Z8IqdG3W9cQX8QOO+FY+8tsf4DNIJbGeSikNExAjBHpne g==;
X-CSE-ConnectionGUID: y5HcYJ3IQqakWjJ2Cu3C+A==
X-CSE-MsgGUID: rXOd7U8PTVa8J0wMAoqL8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76022918"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="76022918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:56:06 -0700
X-CSE-ConnectionGUID: 56MPMm+qRsSMSa0Kcs3wCA==
X-CSE-MsgGUID: t2mScj19RCOZnYyrdT6Ing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="248987888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:56:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 21:56:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 21:56:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 21:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaVppvbQkWvQRWDjMfUQUksr1alufVNeJ0PbaLPO/N33FQnRk7yEzjqSclnNOSBVQtqFMKcVJedSDJr955iyes30Brb+BJRGUltYYIEeJfsRhWQRcnWbk43qDUS9hLAlcMJixi+KM1wgGLAqIEhryWarws2wb+vZoqRoY/lvzSw/7sGs+8ZbWflvmveq3z9wD5+4VEmMHUh6sqTQPE12yyacmGj0neuusRmbeNlJY4hj8eY+nq1VhLMFKkqem4SmCd1GDFLQ7CA+z1tLpms79TJHFYo690G7K6RGzwYVP8NJ4Dq7qLF9Wmpk0U0SiYP6jhcnTEz3UcpTbbHrnGSurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t868oXzQYnTGLIOMydp71pXnSprLO9r1H3TZ1h3Q3W4=;
 b=DoQY0P/aHbgsiOA0kq7pxbKSi/yGxQ6dHgP7olUX8u+C8C9IqzSR7/wf8XhXb0jKq/YYw9POaItXdq/Q9jWeEV1mbgY+naY4nSoB9rIZFXI7U8RVFGBWOI2zrh3hHe3QRhHCPEVFGQ8XvpSwAcmVeIogY3sRHhGlazxyD+UcZ/WQzBlAa8iGzPFsWTVWZgQL1yoscGIdsCRgOwhUNpFkHn2+tkkDtWjA4IgY7k0X0zmBApLiiBeOThNMLkOn3FA1nuiLMXWrpksubOw4SLZuLAqsj7EYbQIvgwXKXebH1JLntuEIa3V14F2MOTApDVmumVUTPCTbE7k6bWz9vU4kYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Mon, 30 Mar 2026 04:56:01 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 04:56:01 +0000
Message-ID: <ab3e5dcf-d259-4a29-a70b-071bcdd24ec2@intel.com>
Date: Mon, 30 Mar 2026 10:25:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/xe/debugfs: Add interface to trigger power
 management unit error handler
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-12-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260318064016.374656-12-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a18ad1-dd1c-47a2-abe7-08de8e18a3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 2c9Yl/q4pnPl02UzttNuiFc4QhoSRpTOxBib7GMcdu7o+aVM5Z8ejb+sUc6By3Cm4lrY3Yhb5CzXFYFBwBqrbptKXBYzKN8fwKEiltwAdmvTlpBtZ0EScLt8gNjNQRULgdqttqr2FYW4srWPB0WI1JgId8kYFk0Xm7DTY8lpTJdO5tMnHMa/8LhdElhFDKx+pjNlnBCSO/pAa86PTICmBsB6zxYWdUTuL7s0P2nYvuLRpT69Ugz1sxTmS6VgoEHpg7l9Zugr/JU6e6dfIaxBmW7o0dJr0uMGkvTpefP8CRWaLteqtGfPLj+yxgsKJLqvJHcc07dh65Z4CLXDzFyspk0eikkSYTgUZqN2BqlRkxN/UjeNigmjzzHEUSzbtq06KpWCsm7GZJSfAJWx32w/xmb5eh+HZ8a7DfMgs1dOpINMze3b3x2Jc1Vbh9WF4XQhnzd8iQHjof/s/FxRBGUdiKQSEhzi2mDG5w08pVyRrWMtJ7WvSJTonuwiwllCNV3I9W37CWIoLK56bx4oLsjZwzC10bs3Um6NR/W3tFwUGvhuGrL9aoFm89sEiwSqTtrRWu0EKREc9Cm1uhXienO5NfldFyptxhRA2JNQ6QAT3ayqza014DA7Ulry7Gtak8mQ3BmB547dVV0XMw9zqBIoHoJFtwdku035ZXJEFAmFUv0aoP4UA+PhTfRbXZUeB+Y6pSGH8UG77b/B1YgXbUGj/aj4haVhm/x+zhTKx0Nnuy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGIvekk5S2FCRTRxVnRqcW5saXBqTE1PcTBsakhHak4yZ2lVVU5QdDlSWXZU?=
 =?utf-8?B?Z1FoWjdicnpCV2lYSkxyYXZ1UEVEcjM0TlozM0VxUmZDYmh6cFFBbHI0cnZQ?=
 =?utf-8?B?d0dMODBibEh1bVhDT0ErUk9YcVF1WVRWcGhQNkJoTHlGLzRwUnhWUTRHOXVL?=
 =?utf-8?B?QXBWdm1PeEhuTGZXVWdGSzQyQk0xQ3hWSjk4eTRra003NE1OZmZXaW1LZDl6?=
 =?utf-8?B?TVkyVXNZYmpWeDRCV2pIelp6ekJPdnFIVE9VSkw0WGVZdTZFS0taSlIvOFcr?=
 =?utf-8?B?RU9iTktBaTBrY0MyNFR5aTZSN1QwMlEwdmNJNU82emIwL3p2Z2Z1enNLM2N0?=
 =?utf-8?B?WGYrOHdOMFRBSEhpQkZyanZRR1lWdi9ZUVkrVlBtZmwrQkFLSjlxcmN0a0Vu?=
 =?utf-8?B?a3hseHQ2cFl4SWxiZ0cvaWdCVkRzQW1nQWs5aDV1V0NQNXBCTG50aEk0d0dG?=
 =?utf-8?B?TG9EVW5GZkVRWUx1UGNHZXBuMnVaK1ZRM1pIT0MrTFRUQkg4YmEvVU9wTzY4?=
 =?utf-8?B?ZnMwYnBRM1ZaLzNjUjlWSStJUTgvTVJuSURGRmZRMUZ3elQvSVYxQVZEYytE?=
 =?utf-8?B?eDVwWS9LUERlT2Joa0VVS1RMUWhlZnJUQSszckZsZzBsZjhKRWJ2MXZMUUxO?=
 =?utf-8?B?MXVOWVBnYVNFUXNLWGtGcjdlU25mVGlVY0o2MEdsMXFCbDNQLzBUdHdWZzlr?=
 =?utf-8?B?QW54ZFZvV3A5NTBacFRNRVJDaEl2Y3E2OTFPejd0ZkRVKytUWk02RjhwSkNl?=
 =?utf-8?B?WER3dDNiTlRmTWJ0eVE5c3dnWU1CTUxxNmNaaTJGVFp3c25xTDdtdkZDZzFS?=
 =?utf-8?B?TDlDaEZYSGdZNjhYTWN4bUE1bWt6OUxldjk5V2FzWVBneDNKaVpETm10cFgr?=
 =?utf-8?B?dlRNVFFHT1VUaTFrZGw1QTFXeXErQ2p4SHJnQWJlRzNaNmRocndxMXN1ZmF5?=
 =?utf-8?B?UHU1Yk9aZXVaT04yNGdXYVg1SWFqRFU4eUJJU3Z5THVOSlB0WjVNNG1jQmVz?=
 =?utf-8?B?aHVnRWZxZ0VjRTlHRzlEcVdqLy9sb2FIemlzbUlVK0pNWTNoMDduZjYzckcr?=
 =?utf-8?B?RGFmb25nM3N6T1FoeW4rOXdlbE1ET0Nrck1tM0puaGZSNFZQVXZsOXg1dGtw?=
 =?utf-8?B?NmkwSVpSaGQrV2E0VS9hOXdCYnFQNGlzQVVwSVlDZW5WZDBOTWh2dlprM2Ri?=
 =?utf-8?B?M01TdTZvZ0NQK0MrdDFQaksxUEo5alB2RXo1c0wzVHlpYTlTUFRkRHZHb3NL?=
 =?utf-8?B?NVFZYzhFalhOT00xaVkrUXMzdWpDQm84ZTVPVzVwa3h2TUU5Z3YzYzJaTEI2?=
 =?utf-8?B?S2t4Z3hvcmZjZ2N2aU1EaVJzSTd1aWFtQjlZcGltT0RUV09PblRlR2xHd3po?=
 =?utf-8?B?RUVBQ1AzYjhsdERXbkNEZXh1c0h0L3hRSjFRTjNUOEtFZG9WRkZ0TmlGSng1?=
 =?utf-8?B?RVErYk1WSU1qOXlzRVFsNnFNOTFlQW94dlphNXVGeWRlYVdWOUxsUU43bXFD?=
 =?utf-8?B?Y0Q5a3FteTZicUNFc3lrOHd1QUZBa1RIdHpTbFR1bFc5d0FFZ3BxWDBGM1ZF?=
 =?utf-8?B?V2JwV2p0TGliRDdySTRFVzh2KzlUbDdRRFJlYnhxZzExeUFUWDBWbmlHdCsz?=
 =?utf-8?B?Y2Fpb3N5Mm9UV0Q0SnlVd1FENXNud2FuRnI1UXJmQWt6RFlDVE9xMWI3NWwz?=
 =?utf-8?B?QWJPRklnVDNQMmw2ZzlsbjF6cURwY0ttWkVuZW11S3F3RmRwZEVkaWZ5QWlG?=
 =?utf-8?B?QkFRZGI4b05UejY1N3BpdDNCRTFER3MrQmZJNVdVc2R6cllCYlZpRkp5a1JB?=
 =?utf-8?B?WkNkV2VzcGFIQVh3Sjc3dVBRcWwrUGZNS0h5UUcyUjJ1WW5pb2RkWW15Nll1?=
 =?utf-8?B?Mnd5NmhQTFNtMGRUQkJDRFdERkUvNExzNENNSUpMWmNWOHRPSXhxanlZMTJX?=
 =?utf-8?B?RWJ3NnhOZ3JnSFR6R1p6TWVxeWFWbFZpRjk1ZnNwQ1p0T0lsTnhQS2U2azE1?=
 =?utf-8?B?YzQxb0h5RUZ4MVRKS05HV2F3SHNBZ0VHV3Y4ajZPTUQ4YWp6bkdiUXpVOUtI?=
 =?utf-8?B?ZE5wWC9rSmVra3BNbXg4dTZWT2NmZ3dFeXkxaXA1UGZZRWxUMGlFNmwyeTVw?=
 =?utf-8?B?Sm8vZmZNQm9XSW1LVU5QYXZaNTdER1U0VTViVVErTzNvT1ErMFRMaHlLazhW?=
 =?utf-8?B?RjJVdElEYUJwcTIvbGFHcVorN1BKVEZkcGlOTmJjNGJLcy9lNUpKWWFlQ1h5?=
 =?utf-8?B?eUMxbUdaNVpkZytleUZsK1k2SnF1VlRRbEV6VlUrRjNNR053RUU3cEFsL1pR?=
 =?utf-8?B?UkE4N2Z0RHBMclp6RmdMVEUvRlZ6cnkxQWxGNzg3dGxkdmFxejFGZz09?=
X-Exchange-RoutingPolicyChecked: Hm6hyVJLWmdDGTpSbszUO8s/Q93WL+RlTJWTZF1uCjHwFfiWWZ2i1nclBMfLSBPESFksPI/TuOz8KhQykSmUSz8mFmFd2WNRbfJYlC/H052t3TSoIIGmLp6+35mmF1RsDWiejrjK9Wcrg9yhceJX9O+h3W2ZjRISRpFXY0pjdAoett3rhBZCDBsCdOUGBkFFZ0Z0L5Yg6/oFL1FqIDG6+cp2USjp3k3etI4gpmWxC24MbG8ssiZ8iQh+6gZGvBIHC1A2FOZWNT5f+04vvWRq9mOFiD4HTs6mrQlw8GzpU7pCz9wgQmikNbrvKUZCXdz0sJ8YB0vDV3AlyF2obSI4Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a18ad1-dd1c-47a2-abe7-08de8e18a3e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 04:56:01.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCEKOSh8KnaXAs8YHQpMYLC9JzlWHGM7CoCDWZNHtsJkxObGUO61E/Klub2fgjOZy5O0tvc2yroQXURjLgiK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
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


On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
> Add a debugfs interface to manually trigger power management unit error
> handler for testing cold reset recovery paths. This is useful for
> validating the error recovery mechanism.
>
> The new debugfs entry 'trigger_punit_error' is located at:
>    /sys/kernel/debug/dri/N/trigger_punit_error
>
> Reading the file displays usage instructions. Writing '1' invokes
> xe_punit_error_handler(), which marks the device as wedged with
> DRM_WEDGE_RECOVERY_COLD_RESET method and sends a uevent to userspace
> indicating that a complete device power cycle is required for recovery.
>
> Writing '0' or any other false value has no effect.
>
> This interface is intended for development, testing, and validation
> of power management unit error recovery code.

Would fault injection be more appropriate here?

Thanks
Riana

> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_debugfs.c | 38 +++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> index 844cfafe1ec7..390bbed9c1af 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -18,6 +18,7 @@
>   #include "xe_gt_debugfs.h"
>   #include "xe_gt_printk.h"
>   #include "xe_guc_ads.h"
> +#include "xe_hw_error.h"
>   #include "xe_mmio.h"
>   #include "xe_pm.h"
>   #include "xe_psmi.h"
> @@ -509,6 +510,40 @@ static const struct file_operations disable_late_binding_fops = {
>   	.write = disable_late_binding_set,
>   };
>   
> +static ssize_t trigger_punit_error_show(struct file *f, char __user *ubuf,
> +					size_t size, loff_t *pos)
> +{
> +	const char *msg = "Write 1 to trigger power management unit error handler\n";
> +
> +	return simple_read_from_buffer(ubuf, size, pos, msg, strlen(msg));
> +}
> +
> +static ssize_t trigger_punit_error_set(struct file *f,
> +				       const char __user *ubuf,
> +				       size_t size, loff_t *pos)
> +{
> +	struct xe_device *xe = file_inode(f)->i_private;
> +	bool trigger;
> +	ssize_t ret;
> +
> +	ret = kstrtobool_from_user(ubuf, size, &trigger);
> +	if (ret)
> +		return ret;
> +
> +	if (trigger) {
> +		xe_punit_error_handler(xe);
> +		drm_info(&xe->drm, "PMU error handler triggered via debugfs\n");
> +	}
> +
> +	return size;
> +}
> +
> +static const struct file_operations trigger_punit_error_fops = {
> +	.owner = THIS_MODULE,
> +	.read = trigger_punit_error_show,
> +	.write = trigger_punit_error_set,
> +};
> +
>   void xe_debugfs_register(struct xe_device *xe)
>   {
>   	struct ttm_device *bdev = &xe->ttm;
> @@ -550,6 +585,9 @@ void xe_debugfs_register(struct xe_device *xe)
>   	debugfs_create_file("disable_late_binding", 0600, root, xe,
>   			    &disable_late_binding_fops);
>   
> +	debugfs_create_file("trigger_punit_error", 0600, root, xe,
> +			    &trigger_punit_error_fops);
> +
>   	/*
>   	 * Don't expose page reclaim configuration file if not supported by the
>   	 * hardware initially.
