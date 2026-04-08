Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E619F10F9961
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 17:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F118810E6B0;
	Wed,  8 Apr 2026 17:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D3Wrp2On";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E1C10E6AD;
 Wed,  8 Apr 2026 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775668397; x=1807204397;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nr9W/6/P6u6iWoc+sx8UxAoM/mRX6k696SF66pJSm1E=;
 b=D3Wrp2OnLufsQDumGz3wAw66FAuqYnYmep+wOl98f1S7H5/b9QTaLhrq
 oZlIxIDQ+JVkCxBvw4uK43u8edIoi7DHcESPeNivEoZc3k4HLE+B/iHFC
 Y1dPKjqmyA2KHhwyM29JCs/3rL0dNf+T9pr92upY5OARro/wu20aMNN2T
 M3vjqtepXNSx1mXNFhVvrMVS1OnKrLwY+fgvZksk2Y/l4Kat/KDt7mCLj
 zyCxX/mi1ZSwoEXS69I3djeOJXvKDqITFor3WeoZg64P4et19dAvi1BYl
 kG332vLwBg0R1YEAFL1H7QjaKRHs1xTFw4cNZUIbQrpGgeQTgBxcyRqH3 w==;
X-CSE-ConnectionGUID: h3ym1Ap0SZqj9VanIn58Hg==
X-CSE-MsgGUID: zAvuKVgbTR6dSZs1AsfJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80520408"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80520408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 10:13:17 -0700
X-CSE-ConnectionGUID: cykYkH9qTdCbfk3L/a02Ig==
X-CSE-MsgGUID: yBIOy8NjR4KZlwuPyKPzPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="258963806"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 10:13:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:13:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 10:13:16 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 10:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0vR997rVWm1O3lw1Nh0UfT+XcGfo/wB/h6Gww7G9el0n97drry+8nkR2jLknFClXfhCbshnvtRqxNayAvjt4vymML9+9Gdj6vBTWc96b7NfgMWBHqUm3qVa12S9KdLIMkXoXzpzw31BXabjHxspkmAO2xtlcM5m8a2JrBESY0fg62renN/er+p9mSQhHUqCBRDZPvev1K7ULiKLKYHbEN3t4IDkjTeYYYrjVCBnWYgGB/8hkUvcj3EksRHNINPruzYsUGuBWh/juovqbjXJfKuNbIVfLv4iSpqcnabxf2dF99Kdqc+sCDdxQVQm8aNWwYbSQ2CFWQ5S1DzN1W0CuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBpJ4+6vtacUBqC/wN/cEGVqQUA9Bm0emQXJ3RCIwZ0=;
 b=WHdlNnEz6S1BCxFCGHkyV2dqg0zo5Ul60Azpuwef1oPJHj6RwOaxuXtg4uFlozPbUcvYl3ySjQERXw5/rMtMshtfj2yGySLGhbH+9O6XZqVO1hOUbjCsIC578aF8ZonO9APNbUresD0nY4izUo7NLoV7skgpQ/8rD0MPtRdeJjyT3T5Jv1IFZJLU8x2CCf00DhB0yA+i4nwTZk1YD+003s7NzeY7GZNL4LcVdbzXI7LMOLhJ3ksSTdv0t5DjKH4HGcX+rjDhaOpAQmv7Myz46sJgsRKKtmpIoKl9sCTVZ/2KQzXPlI+pE7f7ylnOfJdLcmKsz6pV3DNYJAyIQPGbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 17:13:07 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 17:13:06 +0000
Message-ID: <bc61447f-9b95-46b7-8a92-3ee3fa887711@intel.com>
Date: Wed, 8 Apr 2026 19:13:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260408160514.2388689-5-satyanarayana.k.v.p@intel.com>
 <20260408160514.2388689-6-satyanarayana.k.v.p@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260408160514.2388689-6-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::7) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|CO1PR11MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec251f7-2282-46f2-4373-08de959219dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: DFFOki1cawXL1PTSHRNGRAT3WoCPG6iLJ0gDRdYkxUhJ3XU8n0hfTpjRcYwyRa7UkypASbKa7EuKwFvO1N/dr4Ffq4KLNzOFPrFS0HqUbIlAR2BpmBlwB1ZesShouaV2L7LZxjcrGaevLMol2sINi2tPwCRAiLxZ7yE8DCbNAvw9kO0zKjWOGl5v9yWalwq4aR88Jlm7/MycHrXDjZJfSDN5qUTcsUVb/xMBRytS74vJcKoxXAWkOjD/gXerVw0beqibGThZnNNoGRSSw5Bf7aQmHFBxW7x3ffl+YUkClNFoIY1hr840rBUGML4TMAwdGsNn4grBl542LRBUpolZMQhKiTNxvSEN+Dy1SHchaL1nz0YLU6r6CavjULMLh0kYRtwNv0MfteckpzlAvhxzxArbNVqDicUOPUyN5agjGcCYAcOoIZo6gbt3KSXGCN6f7BvqP6WAKVdkZM1fvvVpQiv9J8MYBaSda0RNYVoyQ3fpzR5Hi2UP16PjDZPRgiH9De6siUvI5oekwDIg0xjvjGn/zAYhBxOSF3IBFNzj+IYG2BsilIf8sH8MlPVly9hPyWVp6fYXCqBg6VdeNhe8N7SpnmXenx/OIBPXK7O18AzmRrbdoXp3tlTbV4hJYPviPQc2gLqMP2rVQXF5WGwujFnrcBnfXSz+to+UB2LX58CyuTG7m3D1fu2mVap4QIuk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDh5ZHBiKzdTR21YK1Q1Vnd6Q0VvMGtPVGlkRXQ1Y1pVeElLVVkva1ZSZ0wr?=
 =?utf-8?B?MFI2aWFJMnNlVjlCUXd4RWg0UXlMb08ySTVmc241Z3lOOWJPRGIyOGN2MVZ4?=
 =?utf-8?B?d2pWaExxUy9XVjlQL0FObTRKTXZIZDZaWFBvd3R3MmVNT3E1OE5Ob2p5TXdL?=
 =?utf-8?B?eEhINytnZXpxT0RReG55KzZvdExLV3ZPRkVPRTZzdllvT0tIVTNLZlp6emVl?=
 =?utf-8?B?WGs1Q0c1UnpSRnFER0FDYzZEYkFLNkNORlRxTlhGeDBVT0sxZ0tHcXVpVndp?=
 =?utf-8?B?K1dsN0NlVEF3YzFRTVRVdUlIT2cyTjdETHd4ZVQzbGtjbWpsMXdvZmMzb2Z1?=
 =?utf-8?B?ck9RS0s3RWF5MElQMzg2WjY4VkRGTTFjMXRpT0VFMEd0TERicHhtWHYyaGVv?=
 =?utf-8?B?Nk91SzRqc01IOUtLcFh0T245ZmE5Y3J5ajF5UnhjMHB6TVdEdzFmVEUyRzdo?=
 =?utf-8?B?c3pmLzlWR1BRSngwVmpHUHhzZ0E4cTgveXJGMm92cndUNFZBU1NYSWpKVGpS?=
 =?utf-8?B?alpLZkFFQ3EzUWtUQnZVY1d0RXREVHh5SUpoTTZvR21mSmM0dHgyNTI0S3RI?=
 =?utf-8?B?cTlOa0o1NHpuWmRpYXNIMWRUTTl6cVZlcVlscmNOQUVzZ2dMZGU3cCtiSUtO?=
 =?utf-8?B?ZDdQTVhvaWZzSjF4VHVTRUQ5aDl4b09GUzJQZ3BoY2FhM3I0cm9qNFZxUDBJ?=
 =?utf-8?B?eDRiSklaWm5ySEsyZFBnYjNKM1pVbUl1eXY3b1Y4MHd3NmUreHorNjhvTkNC?=
 =?utf-8?B?MW5sOVZxZExFVW1QTUZJREFmcnRhdVNwUUhNMVpIcVlVZ0kra2o4eU15OW53?=
 =?utf-8?B?Wkx4eDRyem5pTi9reWVEbU1aeFI2UmdSam1sY0x5ZnJWa3FvYy9pRTRMVmlC?=
 =?utf-8?B?VlR5bGp0c0FFeGFQbitFS1REM3preGxSM3pCVzVGN3AzZXdET0dOUS82eGVW?=
 =?utf-8?B?QjY0eGZnMGlYN0pxb29CTUFJTXNQTjFOaTMxVDhlUlh4RTRoKzFIZ2JGNEdM?=
 =?utf-8?B?RWVyYjNVT2FwM1dyb1dZTUZSYk16eGVyWkEzUDFBNDE4Z0dUenFuWFdKRnNY?=
 =?utf-8?B?K09hc2JRWjRxOGFEUnVkOGJiWnVJTi8xN0FqNVdQanJXd1ludU5YTk1PeFhZ?=
 =?utf-8?B?WFJXOVl0UVlmQzBLUnFtcUhiRDhkYzB6LytrVFQwZmZSaWl1Y3VyU2JtVEFS?=
 =?utf-8?B?S1EvcC93VGVyUXFEZ2FuRGtLbmdtYzFuS3Bjay80RHdJSDdacnJaUVhtNzFm?=
 =?utf-8?B?NmEzZFVQNWgwK255K0xNRDA1WFZxOXdrbVV6QmsvYjhCVlJuUnFvOEs3SE9j?=
 =?utf-8?B?VVFiYlZCQk13aXNHR08rSzJtWXJnaWpaRm9pT21QSDdWeUxtUnFSSFV5NVpi?=
 =?utf-8?B?OVpSWTdqU0ZyalBPVWZJWU13K1VQRVpKbi9kemdyOEdNUEp0NzBUZW9vL1dN?=
 =?utf-8?B?elhyK25MZktWSHRVNGNNd3ZENE1MRkpOK1czVG1mSXB2bmMxWnRsWHJPZFhl?=
 =?utf-8?B?U3dhVEorVFQzYTZnRWdiZ3NLZnBDd0xnMXpZQkhONnlwOEJNVGIzby9sd2Jk?=
 =?utf-8?B?ZStPTVJhaDNMeUlOK0dZT3A5OGpaRTZrZThsSmhhTFIwQm02am5MQnpRb2pU?=
 =?utf-8?B?ZVBrVTBjYWM3eXlqSEM1MVF0NlFMUDZJNGFob3QydnJIN1A4YjZ5NUhJeDBN?=
 =?utf-8?B?S3E4YmpmRHJ5UERRVlI5WER4UDBsVlNrRDJMUUQ2dW5YTjdDK2VvclV2TVpp?=
 =?utf-8?B?b05DSWIrMlovVHZPVlhmcEJWVG9NdnNDOUhYLzVFQWsyWTRZR0RhaGJQK0NH?=
 =?utf-8?B?c2FJRmpHV0xYYWQzeVp6dFdYaGgvdnNhRU9rR3JGSVo5TDdSWGt3akhQVTFJ?=
 =?utf-8?B?Z1NkUHZPbnFFR3FSNUlsRkkvSnI4STk3N2NkVjBCUTF4MC9ncUI4Z2ZnYTVu?=
 =?utf-8?B?ZDUyUjRoMVhjZVBoSGp0SktnVGhUMU9Zb3JNSy9HSDNlTjNiaVlHRWd2ZkNC?=
 =?utf-8?B?NU45Zitqd3h4QWd3VUFYUlRxVTRCL2FIbWlENmVFa3FwRXVkTkczYjFRMWJE?=
 =?utf-8?B?bDZkSTBhenRlM0lDNzJZZ2ZFbG5Tcy9mSmFuaFhIUWs4Q3pRTkkyOXNaNjF2?=
 =?utf-8?B?ckowcW1nL3pKZnhyQUNGY2NhV2M2WWdyeFdaZjdFUXM2WHdXTUR4OGZLMHBW?=
 =?utf-8?B?eXh2QlVWU0YvMmlkL240VzZSSDJiUU85RnFsTzgwY3J4c3d6c21jUHUxZGNP?=
 =?utf-8?B?K0U1RDhKSXN6RHNwbmMveWhJMVBQZnVHVnVnUDZmTDEzdnpvenZoa3pCUHE1?=
 =?utf-8?B?MDk1Z3ZkQkZwMjdzSnRDSzBJenVXYkxYMzF4STdCN0psSW8zL3hkaHJEL3VE?=
 =?utf-8?Q?am+LDqcDEQLA/fi8=3D?=
X-Exchange-RoutingPolicyChecked: LdZ/S7/xxKrJm/riXHFchRD6vxY3x52wFiY4Pcp9/WPh/T9s7KJNcsB7A2Li64w1fwVRaoth58VCMzaKy7A7Ji6enKf0WZwJfIKeqZ6HFyqL7Y9TTDsP2sTIJavWFSQR23ECaVTIfNWINPpxf3esdZg250uDMkm7IPsILPyh7RK0+HQtqjO3Qamh4WYFgQ5nPautyynVX2UgfjXjtnrYnMw3mp0d0lTrCBYLY6nQOTL5OFYdVNcEn3BSDnvX5PQu0IvXtJ78OMpiRJbbqQE4RIRTIRtpo9lafJOrSfMZuj5l7EZknDqio769LC1Nke7FwSomiz+34ZTQGu0SsdvQSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec251f7-2282-46f2-4373-08de959219dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:13:06.7094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFYB3Lk7CnbpAHQfblLglVCmSAwORTcnmexYQGlBWaC+sMC7Rkravq7SCA1Wye6A7J/8+w996tL0eo4FyrTKuZZHHJVSlmOKGEBWLq6wvx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
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



On 4/8/2026 6:05 PM, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
> XE_OBSERVATION, and suppress capability-bearing query payloads so that
> the userspace cannot discover execution-related device details in this
> mode.
> 
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> 
> ---
> V9 -> V10:
> - Moved some parts of admin_only_pf mode under CONFIG_PCI_IOV config
> option (Michal).
> - Updated commit message.
> 
> V8 -> V9:
> - Memory regions are skipped in case of admin_only_pf mode (Michal)
> - removed .dumb_create, .dumb_map_offset and .show_fdinfo device specific
> operations in admin-only mode (Michal).
> 
> V7 -> V8:
> - Fixed issues reported by CI.Hooks
> - Updated commit message (Ashutosh)
> - Removed gem_prime_import from admin_only_driver structure (Michal)
> 
> V6 -> V7:
> - Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
> Michal).
> - Updated commit message with steps to enable admin-only mode (Rodrigo).
> 
> V5 -> V6:
> - Updated commit message.
> - Return number of engines and memory regions as zero instead of
> returning query size as zero (Michal Wajdeczko).
> - Allow all other query IOCTLs excepts query_engines and
> query_mem_regions (Michal Wajdeczko).
> 
> V4 -> V5:
> - Updated commit message (Matt B).
> - Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
> - Updated all query configs (Michal Wajdeczko).
> - Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
> - Fixed other review comments (Michal Wajdeczko).
> 
> V3 -> V4:
> - Suppressed device capabilities in admin-only PF mode. (Wajdeczko)
> 
> V2 -> V3:
> - Introduced new helper function xe_debugfs_create_files() to create
> debugfs entries based on admin_only_pf mode or normal mode.
> 
> V1 -> V2:
> - Rebased to latest drm-tip.
> - Update update_minor_dev() to debugfs_minor_dev().
> ---
>  drivers/gpu/drm/xe/xe_device.c    | 62 +++++++++++++++++++++++++++++--
>  drivers/gpu/drm/xe/xe_device.h    |  1 +
>  drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
>  drivers/gpu/drm/xe/xe_query.c     |  8 +++-
>  4 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cbce1d0ffe48..b0bbb079ca8e 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -25,6 +25,7 @@
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_bo_evict.h"
> +#include "xe_configfs.h"
>  #include "xe_debugfs.h"
>  #include "xe_defaults.h"
>  #include "xe_devcoredump.h"
> @@ -390,7 +391,7 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> -static struct drm_driver driver = {
> +static struct drm_driver regular_driver = {
>  	.driver_features =
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> @@ -415,6 +416,42 @@ static struct drm_driver driver = {
>  	.patchlevel = DRIVER_PATCHLEVEL,
>  };
>  
> +#ifdef CONFIG_PCI_IOV
> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
> +};
> +
> +static struct drm_driver admin_only_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
> +	.open = xe_file_open,
> +	.postclose = xe_file_close,
> +	.ioctls = xe_ioctls_admin_only,
> +	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
> +	.fops = &xe_driver_fops,
> +	.name = DRIVER_NAME,
> +	.desc = DRIVER_DESC,
> +	.major = DRIVER_MAJOR,
> +	.minor = DRIVER_MINOR,
> +	.patchlevel = DRIVER_PATCHLEVEL,
> +};
> +#endif
> +
> +/**
> + * xe_device_is_admin_only() - Check whether device is admin only or not.
> + * @xe: the &xe_device to check
> + *
> + * Return: true if the device is admin only, false otherwise.
> + */
> +bool xe_device_is_admin_only(const struct xe_device *xe)
> +{
> +#ifdef CONFIG_PCI_IOV
> +	return xe->drm.driver == &admin_only_driver;
> +#endif
> +	return false;

nit: maybe put this under #else ?

or better, provide an inline with false in .h 

#ifdef CONFIG_PCI_IOV
bool xe_device_is_admin_only(const struct xe_device *xe);
#else
static inline bool xe_device_is_admin_only(const struct xe_device *xe)
{
	return false;
}
#endif

> +}
> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -439,16 +476,26 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> +	struct drm_driver *driver = &regular_driver;
>  	struct xe_device *xe;
>  	int err;
>  
> -	xe_display_driver_set_hooks(&driver);
> +#ifdef CONFIG_PCI_IOV
> +	/*
> +	 * Since XE device is not initialized yet, read from configfs
> +	 * directly to decide whether we are in admin-only PF mode or not.
> +	 */
> +	if (xe_configfs_admin_only_pf(pdev))
> +		driver = &admin_only_driver;
> +#endif
> +
> +	xe_display_driver_set_hooks(driver);
>  
> -	err = aperture_remove_conflicting_pci_devices(pdev, driver.name);
> +	err = aperture_remove_conflicting_pci_devices(pdev, driver->name);
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
> +	xe = devm_drm_dev_alloc(&pdev->dev, driver, struct xe_device, drm);
>  	if (IS_ERR(xe))
>  		return xe;
>  
> @@ -708,6 +755,13 @@ int xe_device_probe_early(struct xe_device *xe)
>  
>  	xe_sriov_probe_early(xe);
>  
> +#ifdef CONFIG_PCI_IOV

nit: not sure if we need this #ifdef here as for !PCI_IOV below code should be
optimized-out by the compiler anyway, since is_admin_only will be always false

> +	if (xe_device_is_admin_only(xe) && !IS_SRIOV_PF(xe)) {
> +		xe_err(xe, "Can't run Admin-only mode without SR-IOV PF mode!\n");
> +		return -ENODEV;
> +	}
> +#endif
> +
>  	if (IS_SRIOV_VF(xe))
>  		vf_update_device_info(xe);
>  
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index e4b9de8d8e95..c220f2f1352f 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -43,6 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
>  	return container_of(ttm, struct xe_device, ttm);
>  }
>  
> +bool xe_device_is_admin_only(const struct xe_device *xe);

nit: can we move it little down, maybe at closer to xe_device_wmb?

this is not the most important xe_device function, and prototypes here
are just for high-level create/probe/remove/shutdown functions

and if we go with the inline in .h then it could be placed near the eof

>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent);
>  int xe_device_probe_early(struct xe_device *xe);
> diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
> index 6dd05fac6595..2f9c1c063f16 100644
> --- a/drivers/gpu/drm/xe/xe_hw_engine.c
> +++ b/drivers/gpu/drm/xe/xe_hw_engine.c
> @@ -1026,6 +1026,9 @@ bool xe_hw_engine_is_reserved(struct xe_hw_engine *hwe)
>  	struct xe_gt *gt = hwe->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  
> +	if (xe_device_is_admin_only(xe))
> +		return true;
> +
>  	if (hwe->class == XE_ENGINE_CLASS_OTHER)
>  		return true;
>  
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index d84d6a422c45..0dc5a9bb481a 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -231,6 +231,9 @@ static size_t calc_mem_regions_size(struct xe_device *xe)
>  	u32 num_managers = 1;
>  	int i;
>  
> +	if (xe_device_is_admin_only(xe))
> +		return sizeof(struct drm_xe_query_mem_regions);
> +
>  	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i)
>  		if (ttm_manager_type(&xe->ttm, i))
>  			num_managers++;
> @@ -259,6 +262,9 @@ static int query_mem_regions(struct xe_device *xe,
>  	if (XE_IOCTL_DBG(xe, !mem_regions))
>  		return -ENOMEM;
>  
> +	if (xe_device_is_admin_only(xe))
> +		goto out;
> +
>  	man = ttm_manager_type(&xe->ttm, XE_PL_TT);
>  	mem_regions->mem_regions[0].mem_class = DRM_XE_MEM_REGION_CLASS_SYSMEM;
>  	/*
> @@ -296,7 +302,7 @@ static int query_mem_regions(struct xe_device *xe,
>  			mem_regions->num_mem_regions++;
>  		}
>  	}
> -
> +out:

nit: "Choose label names which say what the goto does" - see [1]
so maybe as this is not pure 'out' but we're also doing copying:

		goto user_copy;
	...
	user_copy:

[1] https://docs.kernel.org/process/coding-style.html#centralized-exiting-of-functions

>  	if (!copy_to_user(query_ptr, mem_regions, size))
>  		ret = 0;
>  	else

