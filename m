Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DC8EDB7EF
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463E510E3C8;
	Tue,  7 Apr 2026 10:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dBDBrAQu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E807A10E3C8;
 Tue,  7 Apr 2026 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775557714; x=1807093714;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tl2f0wtO9kQQuZ6TTMGh4fCi5IeSh8r92JuYBRBvkjc=;
 b=dBDBrAQuyqaUDOFbpZJUIRc11XLRdOM8AbA9s+lwQ10b5RIeLP4b24uE
 dmnAu9KiEmiel0gNNYR1m7X9SwK2/nQOHJJd4KxZRJMKBqpKRB21JxAB9
 dhLOz+zr47TEgy58Nm6P4ZhoMiprQLUOOfx6fOVOrszicYKcWkAR7hZge
 PxnkCmw5jAXSUJS7C0HBO2n6usa4Vec7QG2eCUQ1FtumyHHum3FHr8XCp
 SjHzKzLDeOnSQxyScY/h+LvkBg8OdTw5k3bGRy9ydUb5RFfIzqCKUqcsa
 XyZKBfkoLu000wERW6g/KOzBVmdaSIp8XltTn+SkbCGwrWw71O4Kif8yO g==;
X-CSE-ConnectionGUID: XzCxtGi3SCOzBJUs2PrTYA==
X-CSE-MsgGUID: dzfRZhsoRyWDIuuPEiHoUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99142835"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="99142835"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 03:28:34 -0700
X-CSE-ConnectionGUID: oI9YIpV5QliK8o71YJ584Q==
X-CSE-MsgGUID: RUex5GeGQjKagCAhA3TmMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="233102246"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 03:28:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 03:28:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 03:28:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 03:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0kQ2SQctUboJ9PdyAY8EeD56g4e5oHhKrltyN/qkfCu9xX2Z0b71stytg6PT4ijvxA5kQJHCRXBprk9eoi0tlO/WhbSEdwn1zR5o4QbwdJkW6kgmJlEg1YXPKIdc3oi2ggbPcqC9IodwzZdd7YxnPATiHlhy3FQIVo1ZVk8LI9tuaw2ozi73Mif5hasRYGgkYOTQG1pWzI/gXucJDNQvZGM5HWO2X0dbBgi6st4zkBLXQmNTUBl8z+fSzl230BZcPmeu2U76ZfTz+FXnhn4yhAMKybbiw2DYx/ZpQpt/gp17XiHoQuH13v/ugE11qcFdBcXxbZSyGiadXHIrDAekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEeBECz2nz2zJ32NtXTmapBbiidJvbzCe+fqGQ1Ls2c=;
 b=XHzq0Myk6/W6ZDz2ERwNf5k/WSk+Rb58QiV6BfCQGfPdqket7z8FgSSOKGp3yxjemSASJjKHSBoRD8TE/zOH3x1Vo0RRaf863/sstiZHiOIhkA6Rkf6eD/nWnsQW8yrwf+b4Vrfmk+QPHkTA5xfXrp27+DtBnNhD7kETeBdD9vH7dBIQ4yQXlOqYfQ+Ws44PrU0XV9PVycOtvEZlXm4RX5zg8NRLC1CmFzhjA8crsKWqI+AFvzGVhuAg8t17x9fR3DvRVpLPbuXSNUyduCWPaUdt7cjkKSnLjG+xzK1DH475sdirYuLC+JX+oHru0j6i/xlnAiVofAkPBJmbhoNx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 10:28:28 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:28:28 +0000
Message-ID: <3e720c90-36fc-4ba4-bbdd-985960b0815a@intel.com>
Date: Tue, 7 Apr 2026 12:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260406114515.1043145-5-satyanarayana.k.v.p@intel.com>
 <20260406114515.1043145-6-satyanarayana.k.v.p@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260406114515.1043145-6-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb611f6-4ba5-4af0-107e-08de949068b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /lglD3PPYoBZNYns4xCQ2Y8ol0Y/rs5JDIZM7LG+fpKFTP7nb9aYDfx2Y7wBc8+kxRcilrNnTwCGhD6pNcMaYIctmng3NYPSzxlT9EGurK8v7o6bUGn8P48+sA+FFE5G5fOxpwEm2YGU+E31lJXc78EDMSJKt2M2K3nfJsW6qKW0OqQwlUixT/I1rRVxiwz8TAZDr0wzZ36E9jnl2scHVZl/QE2880kafk96BslWFl8jcq79kgaY50eLUVOCJrM+QFWeABXC3ls0yKBq6L14tPpDtZTTu72Vz9vKH5SCj+pK5P2V/bzti9/Cq9FIKIXYBHBV5x/G4yk/BilmH/ql5RrmvNjQZPJoCh38x5OkSO4JoN9M6DVQFyR1TrdkcPGhtCKWkYyjX2gaxzjAWO6cpgB4TKfCFfdw+y8F6BvTkgoOjWV+0TrKgKp2PVl9aRKAYpJSxRwm72tBjqlrflnnSLIk8Xzs4FXNY/UoA+RDhrMAphngKqmn3qksV+/N5ICsv1zAsRglxtxJVDmbkX5FfxK873C3yhhMsZR5Aa+O8ssMKLwA/a35XKYpQkvHFF5XOGw2FOeFWUIUyuf28kJf91yxCR+oxtf5LVup0qlwNXpxlk8sYAvuaMGdb+I2fNldm5B4x8ngjfZ9h30oXC/BRfEJwJKf5/Icqm8ARBPE0m6tIJUougZeaIDYnvQ2unOrXYnSZDXYEKhq92GpKpua/RMxsAlN7DDAjj193En3L3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVScE5UaEwvNG42SEM0WVZvYThEMjl0clFoYlF0TEJGOGxMNEFva3JYMTdu?=
 =?utf-8?B?MU5kTkFIa2Q0ZThzN1VRVFJDVkNzQi93OG1ZSXd6L21nWkMwSmkrNFU3bTFj?=
 =?utf-8?B?RHpSSnhZSlBCYkJEVkRqbFp4cWxvRzVBV0lFMmpSWjE4VG1vRGU0K1Rxd1lQ?=
 =?utf-8?B?WXVVNTBwNlVLc21SNWQxZzA4U3ZPV0NVczlRalVSS0N1TGN5bHl3RTJaM2wr?=
 =?utf-8?B?L0JyUHZUY1ZUTk1xUEhyZmMrWHJPYWhzNFpqdGhRRzlRMUNXQkozWnAzNWpt?=
 =?utf-8?B?Rk5STWtOaGZUZmZmNFFLa3RwdzlQcVN1SE9sSDNtS1lEOWQzZXNnTm1ma0pz?=
 =?utf-8?B?VUZKUi95YUpyQzcxcit5MHZNL0Yyc3NTZUZIbTNKSHZpV0ZEU0RGNlV1bFFL?=
 =?utf-8?B?Uis2MndWZTdFY3UwTFpKMUtiVGo3RjM0a0JKSmYvREZLM3pORE01aHdwSFBK?=
 =?utf-8?B?TnJyMTZoR3RLdHdGQkpObFpLVVUrdW9lSFE1dGZlSlhDWXVTbm1kSjZkd3VR?=
 =?utf-8?B?ZHYvUDhyRzMyNVA1VDVsQUczTXhLdXRTYnF4WlNlUjZ3bEQ4V3JCTytydVVS?=
 =?utf-8?B?R0pBYjZJb0ZSdVhBWGtxWGdCUGppMDd3NHpBVVVLQXFkQm13YXcvZ3Uvbnhn?=
 =?utf-8?B?TXpSSEk0M1lyV2FjSDhSU3pXV05QVjJGamU0Rkp5bnkvMlhTd3grZEJxQkpz?=
 =?utf-8?B?K3hxZmIyVGtTUW9RUnRobjJLdzcxbEluNG9TTzRsMUJaQlhPQTNRQnh3bXU2?=
 =?utf-8?B?NUdCNjNnS1NQSEplVy92NllmcjJRdUc2dDJGbnJ0dkdJMVRqbkM3ZFh5QVFB?=
 =?utf-8?B?cENvZ2E5NWYrUU9PdlRmb0VuSWtMVHMyWkpVQjRNbTlGc2ZWQW0wQzlrMkY2?=
 =?utf-8?B?aG95a3hxN09LYXhERXJoemk3SFRtOERSN0ZkczF2S1JORW5VdUp6RDhWS2o3?=
 =?utf-8?B?ekR3V0hZYzVIWW1RbVZFUjFVWlVRUEhHYW5tR2FmbnFJUGZ1N1EvM2ZGaU1T?=
 =?utf-8?B?TVVoUG16OStJeTZtNU90V2Q2SVFlenQ4RW5TaGdTc0FHQUdwM2krMXBvZE9k?=
 =?utf-8?B?SWx1NUxNVDBtVVZSTFA1V2RMdU9jY3EwaHdKRmw1eExHSlIwaUgrZGkrNkFR?=
 =?utf-8?B?aVVwdzJIdGVDVFdUbWlicHlxd2JFSUxHVmc0UG5HTHNMaGlFckltM3I1QmVm?=
 =?utf-8?B?RVg2eG44NWZSMkl2Vm1uNWFkTDdZV0RaeE9uV0dva2FFSVZ4VmNsU1VyRXRo?=
 =?utf-8?B?NTRHaTNqQVdXUjNuTEp6Vnc4UzBoMUZpUDZuU1lRYmN3bW5PeS9DakZFTGFQ?=
 =?utf-8?B?LzNOWjNZLzUwcTlBMlNabHpKQUtJUUUvaWIvUS84SzYyOTVMTGpMOVhnR0hh?=
 =?utf-8?B?MVNNdmNpbThiUFNvMUY5YXp0U0NueXUyV3ZhMXkyeWRXbzZZUE4xY3FjV21m?=
 =?utf-8?B?UzZhWVRDdzYyYmpldml3Qyt1Wjl4eklnTEZFdFlZeXllalZDYzFBdWV4bXNI?=
 =?utf-8?B?Wkkwcm5oQkJFdHpQK1hUSEJDdXUyOFdSUGNLcHlXaFJGOWdkM3FFOHNEV0Z0?=
 =?utf-8?B?TnN0dm51VVNvVFFrdHRVZngyR2hKR1hVcng5VU80V2ljY0phRi9HMWdNYWlV?=
 =?utf-8?B?Nm9ZSXdUWUN3SDRzbFBSTkYwUnY2cWd5VEYvcnFkZXZrdXZYb0tPZDlLQlFq?=
 =?utf-8?B?a1FvbkFqRXZPOVhnN0FNMEZQb0NqNkR0L1cwWi9aVDd5RzhBUjZDLy9zSFZz?=
 =?utf-8?B?cnZNc3JRc2M0YlpnWmZ4ZnplcnkzSTBlK2JQS0QwajhCOXI2ejh0V1ora3A4?=
 =?utf-8?B?RFQzMFVNUEF6NkNHQVhBQTRBQVhjVFRFSVFlVkprY1A5MnFlQ2RDUDZ2Vmhx?=
 =?utf-8?B?OU1PQkxkZC9mdGZSMkduSndUeTc4Nzg0Z2tCYnRaVzR3RXNqWHlvVTE4SzEr?=
 =?utf-8?B?cE1rM0hXVTh5YmhkNWVjak9MSkJPekIvWHdRdkRLYjZZZkY4Q1gybnplanVv?=
 =?utf-8?B?NzdlaGNSVG1DK0wrWGZpWXRHVWtwQks4ZXFkekxvV2N5WmE1cTZDU2Y2OEky?=
 =?utf-8?B?ZWt2MUYrY3k4RFJRQmUxdGFzSlZyS3I5eEtkZFY1TzdwT1phTTZ3TVRwTEpU?=
 =?utf-8?B?RVd0NFVIM2dvVmt0ZmNqN1JJUmlGVzVVUkxKT21rMDh5bWc1OWpQdHJoT09D?=
 =?utf-8?B?RlY5bEVjZThMN05GQWRrVGtXSTFJQUxzNFVPL2JrYUNrL2dlZWgxSmp1YjFv?=
 =?utf-8?B?WGpibEpFWUlTbmZycVNNSjJYTXRjYXZMV1ZnNmRwYi83cUJnN1pOcXlaemdz?=
 =?utf-8?B?c2FPV3ZjcVZ3SEp3WVFXVE54VUhadTZFdnBPS0xvNmVUQlV3eVBIVXVMdGND?=
 =?utf-8?Q?3dd9twojLe1NFUts=3D?=
X-Exchange-RoutingPolicyChecked: tHRmBAy+t3JUNWW6VRTcjwW8i/bA2UKZNiizoSkyZslWmKl4gvOmjAs4KsTv9Ulb/XzGWuQsOChTS/eYr/d32jmFYRzwbbsaQNVacpXWa2JEWny82WsIgBGSIvVO1Cf582C1BkuTxM+GntTQJC9udyqRh6Ik+rI/MARtr8IFyZ0BzUatsV83wtgVxr3QLAmzc6LZiuyEy79ItnFUzziLViJrj4XSmDrbGbHyxVJ9GP5T7OfcNNOezea3G2cJYRc+PPEN8vpK0ai7Xgilgqi6AdiR0zl2h6KQegRBmgBuKAWYkwe8oshp67thFirAPKjeN4VZtioAiZ6Tdm3uHN94hQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb611f6-4ba5-4af0-107e-08de949068b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:28:28.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxL9OMBrha+RuYw2wGJzM08UAtE0V2v19/xKplsqLYdCuwDFMaS2Nl5gi5rQ1evRBAyk3thdTmV5JhGt5Wur3FQ0q7/JQYfu/1kvRtJ8lx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
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



On 4/6/2026 1:45 PM, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
> XE_OBSERVATION, and suppress capability-bearing query payloads so that
> the userspace cannot discover execution-related device details in this
> mode.
> 
> Enable admin-only mode with:
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/unbind
> sudo mkdir /sys/kernel/config/xe/<B:D:F>
> echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind

maybe above instructions should be written for already privileged user
and be more aligned with our configfs example:

"You can enable admin-only mode prior to loading a driver using:

 # echo 0 > /sys/bus/pci/drivers_autoprobe
 # modprobe xe
 # mkdir /sys/kernel/config/xe/0000:03:00.0
 # echo yes > /sys/kernel/config/xe/0000:03:00.0/sriov/admin_only_pf
 # echo 0000:03:00.0 > /sys/bus/pci/drivers_probe
"

but maybe even better option would be to just update our "Xe Configfs"
documentation (in a separate patch, as this attribute is already there)
and here in this patch just refer to it?

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
>  drivers/gpu/drm/xe/xe_device.c    | 55 ++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_device.h    |  1 +
>  drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
>  drivers/gpu/drm/xe/xe_query.c     |  8 ++++-
>  4 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cbce1d0ffe48..b70fa3af6d15 100644
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
> @@ -216,6 +217,11 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>  			  DRM_RENDER_ALLOW),
>  };
>  
> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
> +};
> +
>  static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct drm_file *file_priv = file->private_data;
> @@ -390,7 +396,7 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> -static struct drm_driver driver = {
> +static struct drm_driver regular_driver = {
>  	.driver_features =
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> @@ -415,6 +421,32 @@ static struct drm_driver driver = {
>  	.patchlevel = DRIVER_PATCHLEVEL,
>  };
>  
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

hmm, shouldn't we wrap admin_only_driver in
	#ifdef CONFIG_PCI_IOV
	#endif
and use regular_driver (or again CONFIG_PCI_IOV) in the check below?
otherwise we will use it's pointer only in the impossible condition...

> +
> +/**
> + * xe_device_is_admin_only() - Check whether device is admin only or not.
> + * @xe: the &xe_device to check
> + *
> + * Return: true if the device is admin only, false otherwise.
> + */
> +bool xe_device_is_admin_only(const struct xe_device *xe)
> +{
> +	return xe->drm.driver == &admin_only_driver;

here

> +}
> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -439,16 +471,26 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
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
> @@ -708,6 +750,11 @@ int xe_device_probe_early(struct xe_device *xe)
>  
>  	xe_sriov_probe_early(xe);
>  
> +	if (xe_device_is_admin_only(xe) && !IS_SRIOV_PF(xe)) {
> +		xe_err(xe, "Can't run Admin-only mode without SR-IOV PF mode!\n");
> +		return -ENODEV;
> +	}
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
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent);
>  int xe_device_probe_early(struct xe_device *xe);
> diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
> index 337baf0a6e87..2c324acb1dd0 100644
> --- a/drivers/gpu/drm/xe/xe_hw_engine.c
> +++ b/drivers/gpu/drm/xe/xe_hw_engine.c
> @@ -1027,6 +1027,9 @@ bool xe_hw_engine_is_reserved(struct xe_hw_engine *hwe)
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
>  	if (!copy_to_user(query_ptr, mem_regions, size))
>  		ret = 0;
>  	else

