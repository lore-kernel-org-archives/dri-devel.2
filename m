Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D904109E52B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 01:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C27E10E8F9;
	Thu, 26 Mar 2026 01:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NAt0QEhN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65C710E1C2;
 Thu, 26 Mar 2026 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774489813; x=1806025813;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=lmXewP9Lv32JfCESh32IdBqlD5+15qRB3NgMS4NrCzw=;
 b=NAt0QEhN6lagc4/yBzEZrql+OOc0mumjRQX8z3BJuCqgyIZr/LjVAht7
 wdg6DKFNCI4BAvrubusPfE7VbDLBWm/euxs6VDvW+yLkNH3bXs0BYTMSh
 jwr5ZuE2uxS8yAwbiniDT+IbOIdDerX5bf6NTS6/vqAuyY5ZsRjAUm6JM
 I9shuUoLDipa2YAffNiIEDdWqBcjCw2lYlGm2OOt+MOu795hQmFviv/Pq
 bmWBNsyiXgMnFYLOZecYXkOd66WgX/4O5F3ai8uYaKVp7wCk9RspN5scU
 n26iLsoPavozwllWPiu+SFLmXfSmGiniUwmASfgobywF8BH6BfZUQNA5f g==;
X-CSE-ConnectionGUID: HC06C0IhSnyfiVoB6hY+NA==
X-CSE-MsgGUID: hfBr1LVuRsuK4C297M2G2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86158560"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="86158560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:50:12 -0700
X-CSE-ConnectionGUID: 4Y4fJo+RRSuZA6zbqvkAUA==
X-CSE-MsgGUID: 4Nn7SczIT1SGZow+edcRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="224798388"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:50:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 18:50:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 18:50:11 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 18:50:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0WGIKJvG/rai1CTl3Tf7FOXy3e/5ECTeb1Y4F6F2C/2ocn4SuGcwTXcVuTOGCW2ecdZYJEIExLyj0BbuyJwSoy9aQarYYYSZZ+vWBFmumExKi5dRUw9FYpC/Y9VYRK6EofVnXQAVzmjJhpOoHc3mtr9OTIPCkBmI31iR3r9SnIFuDpr6TbRpzIikZ4T2KsGZ/4xNeKXNGAewBct1AcPgdtIQ+Ft8Z80SsKIrK9+Xwqyp2yEaCizYiOzK27g+VlB4YiW4qODmQd62JDeNkcFtPnns9yT+MKffN8Mmx06lIAl/XBFQLYZvDb5aYfmvJY9LgJ501TI7ZHSDAVSJlWySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+WQ7hPOAsvDy7kvdyfuAnxYhmks6CjT9aoh5TTxKkk=;
 b=CYpOOToWc14PpZEqbxbnL7uSq9+ZWjcQvaFrSRX9YvNafaqoHZAnS0mWpFiCvtzMAYb/HwrJapnSGi3xJ5dj9+oJmJxUjHcw7jTk42gh6cyYErD1Qomvn9au7yracqDm/aFGNPvjJMNNHOrGhNi+JYejM9TR7NjGav1Szw/nIR3f0dWPKGPRU6cJl9t1w6TlsG4vddUH5WdKCBfh+/VQWNH9ah3OKRwmhQgLc/HzzRoIMMvrMJMzmiazUGDDoAD19HyuHSnxvr2YAX7qaHL+A8VrWbngs5YpF848TZURQGFmLlA8Nz3ZQOtnjmU3YI3bxp60O6EzAqIMZUXuhgqJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6519.namprd11.prod.outlook.com (2603:10b6:8:d1::5) by
 SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 01:50:02 +0000
Received: from DS0PR11MB6519.namprd11.prod.outlook.com
 ([fe80::c336:8ed1:4b09:4414]) by DS0PR11MB6519.namprd11.prod.outlook.com
 ([fe80::c336:8ed1:4b09:4414%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 01:50:02 +0000
Date: Wed, 25 Mar 2026 18:49:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to
 warn on reclaim violations
Message-ID: <acSQxyclGs7FYvbS@gsse-cloud1>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-2-matthew.brost@intel.com>
 <acQGehvhyfU5j6uL@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acQGehvhyfU5j6uL@slm.duckdns.org>
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To DS0PR11MB6519.namprd11.prod.outlook.com
 (2603:10b6:8:d1::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6519:EE_|SJ2PR11MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 924a76c8-4759-46af-e195-08de8ad9fed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: h8TUhB4/s2uyw4lhdLSlY0fK8x4IEbBrSW29gVVoH+uBYb7uyEUwpfPMgDt/iHpjbn7Wd8c/26JA3Al9MQrGy0LYqschIbM5oF+ntOXmK2lB4PYx1u6J2cFP2Pe1C5RQ/VomjecDlZiaEDWonMYJ4aUOjXBMKjp91GdaqYGv/iFGoHL7ZqRhw4kT5bD6tGf64eFd9t1Zgn4OCOfFyzZSYbVLmIF3iHWWJcr+p80iMcCrhGtHVkxiHzTU2WlHiGXLQXxd5aLibJLgxHScBmhiO+rgEVLyO5J0uCM7qbBpYLptKfWWF63q77ofdjLXWgcugZrwq8nnN4StD6X627A4HQnPDsnoEaVyt2Yj8Fe6QJlrF7YG8JTnKZ9WcjRvCl7pfY/HdaLXTF02qcS8xKNHEFSXFGjU3+cP4lWFOm3OTJVqva3sqUrReizuSU/j61/kb1FZr3+UVFrdNPXD2KIPotiQ/VCxpYegPKXqi+Mv9y/Xyb/BKJ6C4pihFJA73go1lMgxZ5jZdDFE2UwlCnkTm7l7jF1nBg+ZdIRrmMpA4X+sYoiPpXF/bmZOzu+laSZxle/OmU58wGoYgEvfRwazN3KH8qAhnKVPx6cIO9YUGW5jqfjPhmKqp1do1EXg3qOUQd/gb4I5sZKwuCHjOrR/oidk7x5BJK+gJZZ7LVBLPCjbL0luuq1SGkCI0jZARPMr0EZ6HjZsqRkhRr0/XLeLZKCwvnVmirouma507lOQ/G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6519.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJ1SHdDWWVVa2lEUjlmVUhaV3NOZkpPRXlZU05XSTdzazhYUDFkM01JYStJ?=
 =?utf-8?B?eHhiYjJZRzRZMnA2VGRqMDN3S3RiajFpWGVJMzJra2NER3lhMk1LeVZsV3pw?=
 =?utf-8?B?SlBZbXhZV3M2TWxvcU9uMWhRbkt6QmpMVGd0OVlUTFRuREwrY21wTXBiRHNq?=
 =?utf-8?B?WkppU1FjRUtua3p0Y0szZ003SjkrV2w1SlZFZHRZL0xtUXB0NXVCOXQvbTFU?=
 =?utf-8?B?a0dMRFhocHBMWkJXbkZPMkFhVnJPQ3FWKzdrbXQvVGE4ejBFelk0WkZiTVB6?=
 =?utf-8?B?VGI2c21RMXIydzhJLzhwcExWeW9qR1RIbFdWMlg0d1djZzRvZXdNZ0RhNDJ1?=
 =?utf-8?B?Q3lNcU5UQ1gyeDUxaXRHWklSWUZsUk5wL0tyalhkWGpUQURqb3hRSW90SXB5?=
 =?utf-8?B?dURESXdybmxuc0UzMXNNbWdLUHhRTlEvdEtlZHNZMnd4WHpvNUlseTZ5eHNC?=
 =?utf-8?B?ZDZpSW56WTdvNG5XblFwVDRpSXBoSzc1K3ZhZk8zQmNraHNMWlJ5RVQ5MFMw?=
 =?utf-8?B?Qlc1RzRZdEV1OEhtd29USHQ4K2VETFdMdDlRRFVJM3E4bm5kM24wU0szTUJM?=
 =?utf-8?B?S3IwMzYvWitmakc1TG9zdU41UFhQRlVOVlhXbjZsaVFQMHFOa2xIRDc3MHg1?=
 =?utf-8?B?MmZUYVFIOWMxUXBUV0RNMzhVbVVQcGdkZHNVdXgwRHdRSzBnS0NnZEhQbEJu?=
 =?utf-8?B?Q0ZUK2NGS2x2Q3NtcldOUnZUZ2NQL1J2MUFldHBEYWdrdTVRNGR6TjV5RDdW?=
 =?utf-8?B?dHhmWU9DaWJ3YWdvTytJRk9SWGZtNlhIMnVOckdTKzNXK25HalhpTkpaZzMr?=
 =?utf-8?B?enNDaW9Dc1BCU1N0U1hIKzEvdTFYUzFEUFJVWndZMHBIaEpIcXRuNEZBV09y?=
 =?utf-8?B?cEtuSndTVUlLQVFmTWFkYXp4NkJzbG8rbmVydU1iME41T0c0cEMyMUFlUWNp?=
 =?utf-8?B?SUhwZ1hUMktZWTRJWnR0TEM4Y1plVWdoOUk4Q1NBbnA4NXNrR0VKc3NEam9j?=
 =?utf-8?B?Ujc5VXp0dEt3OFNzU0FwSncyYWhnSndYV2UxOW5NaHdQSjArRUNHSWp1cXR4?=
 =?utf-8?B?NFl2UW1jbDhpKzZ6aEYvWlc5VG9lN095M25JWElXYjZGTjgwc01nWDhIUlgr?=
 =?utf-8?B?eEJlRHhTUVBiRlBQL1ZaRmovNmpYMUc3YTZ5U2JWRkZranBJVUdrcExyenJO?=
 =?utf-8?B?UGZIaEhRSk9jZkg0NnNqTGxYU0RWai93T3FZU2ZkTm1maGVvdUZpTEppOHRa?=
 =?utf-8?B?TTVyelowR3M2VHF0cmVRdnhMelZxNWlzdUlURkg3SzZrR3Zzb0RxbmVGR05W?=
 =?utf-8?B?Tm52WmVpenhOZ1FJRFpCVzBQOFByZUN2MWNlN2FUdko3czlXWllqMUhTcEdv?=
 =?utf-8?B?QW5EbFE1aEQzMnIwaG5sY09YemM0NWMxYzBCVEgzMmZ3cUVIemFIOHZqMkxT?=
 =?utf-8?B?THh3YzA1ZG1pbFRIUFhmbnBBd3VvTWZQUzNaSmNHRWVoSWc3WWJVc1NYcmNr?=
 =?utf-8?B?Uk5OTHh0RmIwUmpnSmZzb1NCeU0zRzQzN1pHS2g3MXFGZVg5TFZWZUdrTGtz?=
 =?utf-8?B?Q0lIWUtyWkRBdmFOSHJQbVFocjlDU3VNaDdZOXVlTG9kV3FiZ0Y4VXlhdWho?=
 =?utf-8?B?N0dwUjRKeW1hVW1tcFo0TFdNTks3TUpFOHJtRW9PdHJrNFJoekxRZldFb0lZ?=
 =?utf-8?B?OUlpdE5KUVBNcTF5R1ZJbHZpcDY3TUZseWFoZG9OREsxUlRDNEs4aE50aFMr?=
 =?utf-8?B?NkNmV0lSbWdDRHZJTENVbW5hT29WOGhHMFJqTnhLWXQxOGVYSlhleDBmbXhF?=
 =?utf-8?B?bFd4SWFWVXlWbm5MUGp6MjVIQ3JNRCt0SUpLZUtpUjRhSHZ4ODQ0d2l6c3NT?=
 =?utf-8?B?R1hNYTV1dkRxWDJVbUZWRXNaTlRTb0ZpZWJMUm9qV1lXUDNKYmx4RkFDN2RY?=
 =?utf-8?B?Yjk1d2FQN0hkNXl6RHgrNndqZ09WRWtqZlNxVFdjcGxYc1FOaHVVRk5yenBk?=
 =?utf-8?B?b08wckJrWCswaFZJMTdtaGJVaUNGOWlCc2tLSHRBaVFKVUc4RzF3WllXWTBR?=
 =?utf-8?B?bE1DN3ZtN3ZZbk1vbDJwdTM3ZGJDRFZyUld6WEpUR2xweDJEb1ZWWHRpa3Zl?=
 =?utf-8?B?azBXcXRDYzBSMEs0UmpjNzhSOU1Dd3lnYUZjblRJY2hyaFl4WTYxS2REOTJJ?=
 =?utf-8?B?NkwzMlJobHUxNHZ3Z2JhbHpZdGtFZ09GZlA2bUdFb2dLTkZyZy9TMG1GSFVL?=
 =?utf-8?B?d3FURFlnc2d1bjVYdzZOU3Vna1dlV0xmSUtSRmlFMU0rSmVsUGtWZ0ZDd0NP?=
 =?utf-8?B?VVoxOW5lT1VTbUl4bjlSaGxMdWtlUGhYV2tCNG8xSkpFcVFxSzZqZjVadUpD?=
 =?utf-8?Q?Dx7hywaChhidosYs=3D?=
X-Exchange-RoutingPolicyChecked: buFiQ2tn6JZVbHabpamEBPzyaUKIOkbXhjwNMbFtLP62NLZeIxMsxRxQ0OktUQaEasNiAGAPj5NWlyReiQuelj3Cj/KFfWs9QU2Wem7MOhXF0MyyWHmNAsvqySEShjxq8zgtaqfH77W0fA/TGax6GpzRS2Ga7F6mrGUKNOgTeyafRASfzJITXV/u2zRXkgtiw/iLp0HYWB1/gTgALgr95Iurm63QCXATFDR6wc5l8ed8eMJbZeWUx1pgf86x+RgW3BcE1xLMfEm5vr2WvZ9tA432rnoj62Q3+IELATW4m3rov9NE+FW61+r6xLkJ7feNMeFf7YJzeiTy1s6v+nj/Aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a76c8-4759-46af-e195-08de8ad9fed0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6519.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 01:50:02.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNVTQLqud9BxFPjoFCa4F2EulX1pdygsjrfe6YSKFbJQB7WPiJZKTQp/Uu0tKtqCVPLm9pJacgtN/1XK//xmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
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

On Wed, Mar 25, 2026 at 05:59:54AM -1000, Tejun Heo wrote:
> Sorry about the tardiness. Traveling during spring break. Getting more than
> I can catch up with each day.
> 
> On Sun, Mar 15, 2026 at 09:32:44PM -0700, Matthew Brost wrote:
> > @@ -403,6 +403,7 @@ enum wq_flags {
> >  	 */
> >  	WQ_POWER_EFFICIENT	= 1 << 7,
> >  	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
> > +	WQ_MEM_WARN_ON_RECLAIM	= 1 << 9, /* teach lockdep to warn on reclaim */
> 
> Shouldn't this require WQ_MEM_RECLAIM?
> 

Yes, so what is suggestion here? If WQ_MEM_WARN_ON_RECLAIM is set
without WQ_MEM_RECLAIM fail the WQ creation with -EINVAL?

> > +/**
> > + * workqueue_is_reclaim_annotated() - Test whether a workqueue is annotated for
> > + * reclaim safety
> > + * @wq: workqueue to test
> > + *
> > + * Returns true if @wq is flags have both %WQ_MEM_WARN_ON_RECLAIM and
> > + * %WQ_MEM_RECLAIM set. A workqueue marked with these flags indicates that it
> > + * participates in reclaim paths, and therefore must not perform memory
> > + * allocations that can recurse into reclaim (e.g., GFP_KERNEL is not allowed).
> > + *
> > + * Drivers can use this helper to enforce reclaim-safe behavior on workqueues
> > + * that are created or provided elsewhere in the code.
> > + *
> > + * Return:
> > + * true if the workqueue is reclaim-annotated, false otherwise.
> > + */
> > +bool workqueue_is_reclaim_annotated(struct workqueue_struct *wq)
> > +{
> > +	return (wq->flags & WQ_MEM_WARN_ON_RECLAIM) &&
> > +		(wq->flags & WQ_MEM_RECLAIM);
> > +}
> > +EXPORT_SYMBOL_GPL(workqueue_is_reclaim_annotated);
> 
> Why is this function necessary? It feels rather odd to use wq as the source
> of this information. Shouldn't that be an innate knowledge of the code
> that's using this?

This, for example, would be used in DRM sched (the existing scheduler)
or DRM dep (the proposed replacement) to ensure that driver-allocated
WQs passed into the layers are created with these flags. DRM sched or
DRM dep has strict DMA-fencing, thus reclaim rule that we expect DRM
drivers to follow. Historically, DRM drivers have broken these rules
quite often, and we no longer want to give them the opportunity to do
so—lockdep should enforce them.

Matt

> 
> Thanks.
> 
> -- 
> tejun
