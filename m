Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB17C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B34510EBA0;
	Wed, 29 Jul 2026 11:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SQjlp/nH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B33A10EB98;
 Wed, 29 Jul 2026 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785324655; x=1816860655;
 h=content-transfer-encoding:date:message-id:cc:subject:
 from:to:references:in-reply-to:mime-version;
 bh=Rdu0twBQe+uHUApyCJ6b4aSll89IVZbFqGCpkVko+bg=;
 b=SQjlp/nHFbpYGRKEJZw2We8DHX0ap8eX9aKwvfKaC1/M6xvxgg78yo3V
 ZSCquupnqUkUVYuuaOzFIVDJAXOpGGPRUXIerCSjea+3W4jJO/E0LL25Z
 iEJH3wcKOe+rQ2oC3xF2NmlGQtIw+vqEZc7DF0Uwp6bakTJBKOAuseKMG
 upRCw8YI4NzSNhleKNTWnwcK9M9O4W4J6rwFlVOChVlztCMClc65Vb35x
 mlXSTp/5RtHRBUaJjmgJQMIkg3Ijmk+REODEFXSenPCIAz8vsnle7x/ad
 rB57GQncnvhKMVSToN/ByvmKlZnmRvUX5XAm+ovoGaLUhDFnsvHmgmumH A==;
X-CSE-ConnectionGUID: zF8qEzQ8R2qbn97qBQUHBQ==
X-CSE-MsgGUID: M3MGT0EMTL+BPatyNnAHhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73461554"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="73461554"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 04:30:55 -0700
X-CSE-ConnectionGUID: ZiN4LPuoSieikez7OOfEew==
X-CSE-MsgGUID: 09iUxPxLS5e0GeJbysD7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="263789183"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 04:30:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:30:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 04:30:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 04:30:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVkEHFpMwiuC42NKzuzHHEGfo/hLnFZ5LFqhUKPMf+jPEzHxWS8eu7lVEDWZ2JIWymWhi2ameBxP7e0p9CmucloZrsbWE7GDjiDM617/KQe5UEXrLj6ej3XvMz6af6q90IAkDnZI087jvZT7LC81ZAUY1blCR/Je0RBZ5wb7ihJlk7bIraASJlicPxXu2qETTXIBjwCa/H5qCZhTrJjlXHzBZXunZHMn6sQ5l6x1An3KRyZwF0KzSYoOn8Wlxm2tTrg/KClkRi35ROQ88Z87Z/ZVCZIXD0gCaFQy/pixhW/MyAF6+eHDzCziXppO6XDP2jFoRvO/osd25+49nfjpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fWzVInbMO2Ez6H75qAQEn/Tn5m6/49+JuE7UbFTg0c=;
 b=GWFMd+F57H6MBOXPRd11K0vbgnjvcaz1Q7hZQUluarrNoW6qpPIM98MpiREEh6ljdfojnEgc15TnZutK59gH0C76QG1Yuz2dHdMUBM/9ymXKGD7iefIc+0b0xrm3d5ResbwqeIcqXiv4Q3tAHxRPBj4FAFZ2Mv64RHIg7ltUREXXC2qxadW0+gy1B1ixVhy+m4lKFHhXr85hnTmY6TzTrqFNc6orLJ9qTErt+xhE6b6ZQ9Z+OCeJfRCr1px2szri1jQ3aaLzorFZG7q79gQ0GAtasVjEWh7ApcdhuyDUWJu44SryCpLxmyG6pCJHGp/CzJhHDW3GDpKUNbh6E50qCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by DM3PPFF3F4DC26A.namprd11.prod.outlook.com (2603:10b6:f:fc00::f62)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:30:49 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 11:30:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jul 2026 13:32:00 +0200
Message-ID: <DKB0SM0HNAGR.1XWQNAVPB5YTG@intel.com>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?utf-8?q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v4 1/5] drm/i915/gem: Count mapped pages in a folio
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-2-krzysztof.karas@intel.com>
In-Reply-To: <20260723102542.3245495-2-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU7P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::15) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|DM3PPFF3F4DC26A:EE_
X-MS-Office365-Filtering-Correlation-Id: e663e3cc-a844-4cb6-9cb7-08deed64d6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: FvinyVV9RucFG99YB0mvKCkzJkgi35vgvoVdvbnNDcV8PrkHzIP5g6Owsv6V3GCPCuFJQiIdqGTAj8bI1cN/7eLenLGpZEY7rTXNBbrG40LjC+F5CIfuFswHiHMr9zk7iJAzOec86ycRuJ0khjixt3bdc046bwgvl5ZiZW8ZNkPNQk1PFtCqqyzhQjbkx02uX2yBx5nAimU/wZTiHUUKf1jkQFyc5leoOTdWMx3LtRVa5Eh86G/C2AzAWu7wjo3hsSICgHoAuRtyELAHo4VoBzp2ESi9+bbLHzfW8PCkaPLq/Axq2hSObGPD5jixvZdW55engmBxgId5T88zMuf/RFYShveHLgREZcOms8LWCPWaU9v0gIsZYxZNz9adWAJ/Pl1Z8KHEaYQy+zW+sdQ8YgN3tVikTNvuGtJdL7fj8yTDXEYu00nzdzz/Af4znYivtaWdLQzQpmkP55/LlypmakL/Er+/RjviNE9upwIvQz/5T85JciD/sRLavQFSOARqqgojwe2uV1P5hKdwiBNEQ4k+AZvriHYhzJdB/PqVGvaPcNeloS1a2OHL6oJFlOrQAApUafzdkGCWMzOFwURLrtB8ZPRvSjIz0kTvfRrbsQFdiLC3e0CV+LCpCYqpZNJO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNNbllZVStaU3ZkNVBYR3pCTkxzK3cycGRkM0E4QVZrb3JFaTZDaGlWYzI0?=
 =?utf-8?B?UjBzdnFxNmVRSXpQTkZMOS82VUVTd2NpUFB4S0VBaDY2a3JWSzhVMlEyZkN5?=
 =?utf-8?B?eHRSRFRVa1BtajN4dzcrK1hwWWVuNWs1WGJjZE5EZVpEeHh3RitwQzF1ZWtj?=
 =?utf-8?B?QXdUZ0djVTcwQ3BwUmNiTzdGVEFjWkkyVC9UcllRQmRDdlByL1dhRTJXdm93?=
 =?utf-8?B?V1dQUUxDcDRvMklSSFlsZmpreElGVGZqdzZyQkF4QTd2eUUyalBKK3BNRHcz?=
 =?utf-8?B?dWlFR05aRnlIbW5QdnJyVkN3ekgrUkxFdzl3ZjVlcERrUVNxT3dDOTFyN2lM?=
 =?utf-8?B?STV1NFJmcnU3Szl6WE1MN0c3VUh0ZVhURUFiNFJJVDVtRk1lL1p4d2RXS0hC?=
 =?utf-8?B?MmVZZVRwTkRnM1JqRnFHWXN5a094TCtmVGQ3RmhYRC94T0UyVFJjWFF3M05V?=
 =?utf-8?B?bS84UksrMXFZQk53cTFHWmdHQnQxcm11Z05BMHhjRDlKVHE0NEtTY3ovMGEr?=
 =?utf-8?B?WUlSN2pVVGJpN2lzemlXRDhtWlMwemhOWWhpQTlhelBwYm44L1NvTUdVS21B?=
 =?utf-8?B?b205U2gxQWN1ejFpaGVSQkgxMFlZRVpEQ2VqakxzdUZocmJqRnFWM2d0SStl?=
 =?utf-8?B?dTlmbWorUTFpdDNMY2EydjErVEczOFMzU24ybytTS0hYZEt6eURnb25Kazlr?=
 =?utf-8?B?YUIyRWFFazlobDhqYUVzQ3VZM0I4VE5EWmhaV2NQZjdSTHg0TzZpSE1zVVRl?=
 =?utf-8?B?VFJ4Q0tMcU5vdkI2WkQ2cjV1ck5HMHovT3RYbzNXcEpsMVhVZXB5cHRZOW5Z?=
 =?utf-8?B?VU1uYzgvNkhRTzltTXFTeXd6Wm90NDZHWWFRVy8yeXA3bjJnZ2RlSE8rRnZP?=
 =?utf-8?B?a09tN3E2cnB1MDU0V1BDbWJJdjd4MUpYUVdJVThwNVpmdnpKMzNYblZqM2w1?=
 =?utf-8?B?bjE2Z29XSE0zOUZwN3ZTRE44SEtMTFliT2dSTXhwbHFLSzF4L0xvL04xenBo?=
 =?utf-8?B?UGRRcUpkQ2M0MGtBNUw3WU9HYitlK0ZjaDgvZWFwRWRTMm5qZWdiMllYYngz?=
 =?utf-8?B?dURSa0E2b0ZxS2pPdm1oRWpKaXpJaFRaVlNiR1l5TlVOSnJvSW9XbDNmSjdX?=
 =?utf-8?B?eUhCeVgvajlCSzhEMEd2S2lBMk9zci9NYnVLak1wUkxPMU1QcUluVDNBNW1l?=
 =?utf-8?B?MWhoeCtMZXNTZWxiUmdoaEtiT3V3WjZtUlRCSkhNZ3BGZ1pSMXd3YTY0ejY2?=
 =?utf-8?B?ZzdMajlxSWJRTXFyQzg1MXdQVXhsSjlXRXZkRjBVeFU4K010N0EyOGNDdHFJ?=
 =?utf-8?B?am9TN05jalhabFlhZEFVdU9Wcml1dmNyYm9Lc3NUNDdTblQyUm9WY3g5dmVL?=
 =?utf-8?B?MUM4Y2Z2T2lGc0JxaWM3QWVhVGVscm5ZRHpGbnJPK2FGeUZoL0x5UTJyNUo2?=
 =?utf-8?B?OTJyZ01wNlN5K0w1RjN4a2NsRGFUNGZsVVd3RWY5cytjZjZQL1R4ZTFuMVc1?=
 =?utf-8?B?Uy9TamNmUDRTSnZReTVvS2h4bUY5ZFNZYUdua0s4N0doR2FPekhOeFBHNEpO?=
 =?utf-8?B?SWVWb0R0V1hnV2sxTG45ZXpaaGNuV1dxRVdpcWNjblY4ZGpEVnVaYnZyUjZu?=
 =?utf-8?B?d2tkd2hYdlgzMXNwRFltbGs0TFNyR0xpTVNLbi8wMnFETytOZG9YZUtZT3Ey?=
 =?utf-8?B?bnBkQVVTWHBhNVEwZ1FxcmFIbVRrRlppNngvRmRycExGc0RMTGNMdEVOdXhH?=
 =?utf-8?B?bUdDWUg5ZWZjSi83VGRlUGJ6YlM2M1ptOTEwa0xjODZ0clhuMzV0TE1UK0V5?=
 =?utf-8?B?R2hob2dRWFYvcnJ1eGJjVlQwOUhoZVMvUklvOStMSDB6Q1NMaGJaaTR4ajNK?=
 =?utf-8?B?S1IreUVQZTBVMHBPaU5ONHFJd3ZLdjZkK010emlBR28vRlhPUzBDRndOM2NH?=
 =?utf-8?B?bU1lT2Q4S2M0ems1RkJLUFA0ZllPenowYTAxNjRrVXg4LytrRy9CL1ZtaDRu?=
 =?utf-8?B?UmlqMTRKTUlUYVZueThicGFvSnJqM0hmRjdXQVdZWjdidVZOQ1FpcFU5bWtv?=
 =?utf-8?B?WHM3aVRNT1FGVHEvQXhVUURjN3o0TkJxYWlZRHQ1TkRJSG1jS2dTNUtmZlRX?=
 =?utf-8?B?QzJ3WXA5YnBnZ1FsQVBmaTVNaE1uSUJCT1dzRXlFWVFNTkZDcm00OEUwN2Fl?=
 =?utf-8?B?TGtWTDJWOERqUjJTVDZBcGxqQitzd2R1Z3lvVlJPTk9Mc1R6ckhnRmZwQUpa?=
 =?utf-8?B?bEtJMkFlRXJZRUJSTUVoc2d2aytWdTR5QzJvR2VLZHV4R0NUdkcreHFOdWhH?=
 =?utf-8?B?T2pEdU85Q0dlUHpKRXhRa1gwdTRMNXdaWXZBN1VhSHRkMGlLd0pBbXF4UUlL?=
 =?utf-8?Q?yk1nwSDppDEL16Zg=3D?=
X-Exchange-RoutingPolicyChecked: DKgQX3LiadnoNsCoElsreAfuU/FFCbEhflXThta8tITnGx4MBw3mkpR3YtvDOExu8PZ3o0HaX4Oepj7gCoUEYar5CLDnvl6+sq/p0lZS5SVXRxo6YJHk42CMxN2rvfo8z8Egj4sY3fSz80l5qEu6lmnuMxllLGKWfTK/ax/3B8oRbb/drLbH7mkbDNNVVV03JiI5G0U1giOUbAwU8mx4oXt9MyBJCSLsyZ3Kv/qOCJzO1zPSyERepg7CJXf+AiuM03cX2ChBFeVX4MxT59FscphTi6iKXf8sNobMci35ma8idRMdQFfEDH214qEv3PqzrvovrEFwtAsxihQ4y4cx9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e663e3cc-a844-4cb6-9cb7-08deed64d6bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:30:49.0606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCTd9kGgnTuhXNP5hgQMi9VLcY5zYWWdVLkWo3KG4jcycHB+MoQo0dJjGGh8U5aqqxt7Bs/IYdVTNbhAFrZun+mmEoxZZNUbx3C0YHAZBrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3F4DC26A
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

On Thu Jul 23, 2026 at 12:25 PM CEST, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
>
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v4:
>  * Rewrote commit message to be more explicit about the problem
>   (Janusz);
>  * Moved max_segment validation to the beginning of the function
>   (Janusz);
>
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 123 ++++++++++++++--------
>  1 file changed, 77 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 06543ae60706..af195db63038 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  			 unsigned int max_segment)
>  {
>  	unsigned int page_count; /* restricted by sg_alloc_table */
> -	unsigned long i;
> +	unsigned long next_pfn =3D 0; /* suppress gcc warning */
> +	unsigned long folio_start =3D 0;
> +	unsigned long folio_end =3D 0;
> +	struct folio *folio =3D NULL;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
>  	gfp_t noreclaim;
> +	unsigned long i;
>  	int ret;
> =20
>  	if (overflows_type(size / PAGE_SIZE, page_count))
> @@ -88,6 +91,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915,=
 struct sg_table *st,
>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
> =20
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;
> +
Move this validation before sg_alloc_table,right now you're leaking st.

>  	/*
>  	 * Get the list of pages out of our struct file.  They'll be pinned
>  	 * at this point until we release them.
> @@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index =3D 0;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -109,71 +115,95 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
> -		do {
> -			cond_resched();
> -			folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -			if (!IS_ERR(folio))
> -				break;
> +		/* Grab the next folio if we exhausted the current one. */
> +		if (!i || i > folio_end) {
> +			do {
> +				cond_resched();
> +				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> +				if (!IS_ERR(folio))
> +					break;
> =20
> -			if (!*s) {
> -				ret =3D PTR_ERR(folio);
> -				goto err_sg;
> -			}
> +				if (!*s) {
> +					ret =3D PTR_ERR(folio);
> +					goto err_sg;
> +				}
> =20
> -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
> -			/*
> -			 * We've tried hard to allocate the memory by reaping
> -			 * our own buffer, now let the real VM do its job and
> -			 * go down in flames if truly OOM.
> -			 *
> -			 * However, since graphics tend to be disposable,
> -			 * defer the oom here by reporting the ENOMEM back
> -			 * to userspace.
> -			 */
> -			if (!*s) {
> -				/* reclaim and warn, but no oom */
> -				gfp =3D mapping_gfp_mask(mapping);
> +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> =20
>  				/*
> -				 * Our bo are always dirty and so we require
> -				 * kswapd to reclaim our pages (direct reclaim
> -				 * does not effectively begin pageout of our
> -				 * buffers on its own). However, direct reclaim
> -				 * only waits for kswapd when under allocation
> -				 * congestion. So as a result __GFP_RECLAIM is
> -				 * unreliable and fails to actually reclaim our
> -				 * dirty pages -- unless you try over and over
> -				 * again with !__GFP_NORETRY. However, we still
> -				 * want to fail this allocation rather than
> -				 * trigger the out-of-memory killer and for
> -				 * this we want __GFP_RETRY_MAYFAIL.
> -				 */
> -				gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -			}
> -		} while (1);
> +				* We've tried hard to allocate the memory by reaping
> +				* our own buffer, now let the real VM do its job and
> +				* go down in flames if truly OOM.
> +				*
> +				* However, since graphics tend to be disposable,
> +				* defer the oom here by reporting the ENOMEM back
> +				* to userspace.
> +				*/
Looks like this comments are missing space in aligment.

--=20
Best regards,
Sebastian

