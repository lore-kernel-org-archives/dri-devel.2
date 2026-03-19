Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D41088E78
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE78510E0D3;
	Thu, 19 Mar 2026 05:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A0FHwDiq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447A810E0CF;
 Thu, 19 Mar 2026 05:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773896924; x=1805432924;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=MY37znHToNcvNMdKfHWHc0PkZeEMvpn1drV/LmzDrw0=;
 b=A0FHwDiqN7G8K1lkzsCCG3k+0FjsKeKMlXNe+OjsqL4Bc1LtWGRPP8xQ
 NTHJkivnHLJOCar7GwSDpVDLtI2aRB7cPY3qJ6PtrzC92hxJeknbFSnss
 pBaeLpWSLxzkFsF9hsXaxaEclEpYaymhMAgMATZ94+OFdVBIYZXt+KqBT
 bj64Fza1r5dzhzZzP3KH3XGP089sV+hZ2Vj6lcGuzvUeARS4xkqsf8Inm
 3QxtJms0ilaiRDztFj25ALUyFQ8CWQ/vogqby7abxVfBZLlhamFh+Ho7v
 6EsLZWEGApqpzBCFmrrh1QJj5Ims7XnUP5H21+6tZAbKAJpGO5OpTCQLN w==;
X-CSE-ConnectionGUID: rQPyTj6bQe2GAhzZx7iayw==
X-CSE-MsgGUID: SCW5Y8u4RKe9Yd4gKbqSow==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74876611"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74876611"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:08:44 -0700
X-CSE-ConnectionGUID: UjPeT+GOSsOdwINvZvIN4w==
X-CSE-MsgGUID: OUhIq9ZiQaGa5EHTB7Y45A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="227549832"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:08:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 22:08:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 22:08:42 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 22:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWx67HAONWSgEwclyrzc8HL/PvPov0EcZ1EpZn9kc7h6kcyIeEsNktJ/I8fkBhQisOWke6C2jueohoHjZutqu4Gr+s6/dRlbN8qapeC2f9pxzHaQIWhZqHxvFfdmOFjvojb7qOXKJ/dIbpQrmOIDMhj7e+Pyy2zQnARoW0U3MEQ96Xbei2y8thGQXLLcbpCPKy+iWdv6xRGC3HuqssSw0iEMeJ7ZVzja/A3Bxke/DUgE6F6Q5taaP07o5P/+G4+EurNBxoJ17mttZ8MlEYHpyCHrcsgi67r3oafWI5qOYngwr6uczdLghNKYE2BxMp8RI1x3hvtTjMSjmuLdgiBa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpk1vVTFvLdhdEfcYGBZ2v78UDOQjV8LvA7rHMAe4NU=;
 b=PkwpS245PYZOSkS0zkQQbBVhNtC9IF0n2s2/AvVyi9dOYZEUsgCZi7oUcOlIMASJh4h0GteeRXDw9z9b0wXLRS86h74Fdt1khLUk5XXRcFXsG0vG2VM76o1tsVOhTiCx3UBA7JkQJhMghY68YpdjMNZOxebM9OgO9WRWGEp3ZxxjiDjXKCj/hAc7GWKG0JwH/9yT9F/rQ5QVk7sVezgIPx3uSU2ESqpwnQ43gV9dXyUdaP3lLeye8Z0oawPvXX9r9qwa3gC2+fsKPKQlNcW+4wj6pA0t/QMdN92/ipfNMw63acloDyZHAnsrNFuwdEYVHBy48dbrW1zxacRmQQGd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 05:08:36 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Thu, 19 Mar 2026
 05:08:36 +0000
Date: Wed, 18 Mar 2026 22:08:32 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Honglei Huang
 <honglei1.huang@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
Message-ID: <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
 <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcaf1bb-b5b3-4cad-be76-08de85759385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: +oenECV/ZDaiS/S0Jo/BmvueoYMsGGJWUdrcu1GcV3iCLECDxEUIo9yFR6wLc/vUY8+AvvWNOD4pA554NtDiKtGtbF7b0asmCHgBX2ZSpcqnbAy5xEi2pddEQB2bGnRxH/wQMksq1SIG2qXGNqjnyTC/oo4ytz9xkZ+OCNB+y0CUr4PjcnwRRNAkr1YWaAwn2pHPDcDLrgWCkv0J9HlIaJviJMVmyCAX7wCqiekqAoarPo4R2bR2JObMDgAqM/TTYLrGkfbJr1z6H4I9XgqTGrypRj28U4RfRSwq9olgIApZuYW876K1kTZ8vaNApKqKGSkmbKY3EH069YY46wdnZvJULhBwrA5GUr+JOZ6GAetBf7wDRTYwnM3f9BkZAdlD5Fl+WacOo2aAgvjyN1Rb/ZagaBYl2RjQIHjKG2smfJ5MPNTdFQmsRZD5UTZXt/lHVvzXDFU2Fu3NSZcCYv6zHe906wtzpO7IXGLaG4KCPYerKhv4Ns40BGBRdq0+nEXEAP+AEtvT/x4Z5cfHJkcPxJrTJFvLEPFI2V9RSgednVYIb+MOpjE0VI1CXGoaCvqpWHQx8/7LhRx4TjUng2hm/4fEbYIE7vz5Xnw9jT5kfWO3M9pBZyr6Ob8HkBzaH4eAtnL01Tr6XAvVG105RPXcR9nFktJUJaAKLVBO2G8nDQ8/JFpYwExEtHPpmP1VmHnY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VnSlZjL3d4ZW1PUlY0ZDJ4QTBpMGtvWDBkVjlkWDVwTGQ0TS93TTRrbG1R?=
 =?utf-8?B?WG1LL1l2Q05vaERyc3JrUE5jbDZWbzQ5eFN5SzBaSTNDbkhrbmVqZ3pDNm43?=
 =?utf-8?B?RnJGWE02cCtZMitsZFBDV0JJcUFyL3l2T0c2SlFhbXh5cHNTUTZLOTVscGlm?=
 =?utf-8?B?NzZuM2RqMTBqSGRNRzZlclFjVkRVNkNDeVA2bWZNZ0VtS3dmdlRnbjFUVko3?=
 =?utf-8?B?MkZuN3dGYnBkaHVjZlowSTZpaEVqY0dBUDVOb0ZaZzJRTHhEYng2WXRpbi9M?=
 =?utf-8?B?SS9yT0FoNm9ZMWxVb0FyTERhYlNSTjdUUTdOTGhKSjA0WkQ1ZnZKMDZtUTdW?=
 =?utf-8?B?U2k4V2l4VUU5WVVUK09XRHFOSnlhNmwwNG16aVByQWFCTXNKRTZOZWFpYVlP?=
 =?utf-8?B?cG1sYjV5blZ4bFVTMGpTV1J4aHNxY01ZcWtuRWxSTE5wSDFjS0ZaNXhXOW5D?=
 =?utf-8?B?STZ1VTFyTGV3cDM5SE5lTU9aL2xLVzUxTTRwNUUzVTV5OUx1elp5TytYc2dy?=
 =?utf-8?B?SUVGYVE0cUtwMmpYcERCamMvMElWeDUwZW1KMHlYMHBZbTFpWEJVVXFZSDhV?=
 =?utf-8?B?TDdXRXJvUlEvZnFHbEhRNjJHMjh4aWlkZ0ptMFNQWVNDdnlkUjJDSHpQTzQr?=
 =?utf-8?B?RjNMVm9URS9jU0RKQXdkazdBWE0wT0MrQ0VJVjdqU3VHVkZCMnNJMTBqbk5B?=
 =?utf-8?B?bU1DVTQ2MUROaUxMR21zL2NkL2lSYmVKOVY5a1JXdGNtdnYyTHZ0QmFybDNX?=
 =?utf-8?B?b3poc1RSSlUwc2szYkw3Wi9vbEZJd3gwaHhkRkJIa1pLTzNzTjU3ODJ3WW14?=
 =?utf-8?B?Q1lVT0pZYVE3ejZqM25aUzZMM0RLbjdLVjMreXVIaTZCVGFvVnowbDNmUnBk?=
 =?utf-8?B?bGY4TzYxSVVzVm9xMHNSQk9DclZsdFd4NEhXUzE0TmdwaXU1TGN4bTRudzNp?=
 =?utf-8?B?MEZHYUtzbjUzOStxSEpPWkNTZjI1S3ltNlhaNDVveWFRY1FNU1lQN1JrNG95?=
 =?utf-8?B?eHdYd1FOQ2N2TVNQYmxpNGdybVg1YjlPczdJalg5N09WZ2RJVjdFVjBwNVMy?=
 =?utf-8?B?aDZmT1BQa1g0OWxUd1ExNXVzTXNrSFVvR1VZSUpSVStWRWtxRFpnblZnVXZJ?=
 =?utf-8?B?c25zZkhPV2hJVW42VnIrZ3ptenlWYk9qbGFlVzVDSXd1YlBOTzNvVmlGVWJN?=
 =?utf-8?B?Uys5ZFgzMlhsZnRNbnQyd0dpZHZvK0JMc0RZNnlvZHFaRVJSVHg3U3Nad3Uv?=
 =?utf-8?B?NnFFbWI0dzVBTHR1ckVYOXBTeXdFekRvQ3YzRHMya2tac0xoSG9HeFNDMjd4?=
 =?utf-8?B?N0lCTmdtSDdFc3lLVmE4T3NodkZaa1dBNnMzY0dQd3NGUm1ibzVodm9qREZI?=
 =?utf-8?B?ak9qa3daZGhicmxFZjg3YzJyd0NrSUg0eFFTcFFTT2NTa0kvRnZ2VlhtaDZK?=
 =?utf-8?B?bndzdHJSYk9sUmF6ZFNGYmk1TTQ1Z01wODRPNk9yQlkvV041Zm0rWmZZZVhW?=
 =?utf-8?B?bHppbUxjWkhCZzgxUElIZnZjcWRhd3R0b1E4RWErS01lY1pUOWJyczNpZTB5?=
 =?utf-8?B?NXhYQnVkZWxDYTVSaDVhTTlDZDBaVkdUeFV4QVF1ZVpCZFNrSGZpL0doNE1V?=
 =?utf-8?B?UjRxK0d2K1dSRGFMRVdjU3B1eEU4K0w1NGlmemRnVnB4NUhTdVlGVFNmN1k4?=
 =?utf-8?B?M3F6WkdEVkZHclZzOEx6QVMybVpqM1ZpdXRhZlZRVk0zT250UUtQM1hvVmNL?=
 =?utf-8?B?L2l3cllhc3hSc2FDUUxWeDUweGlpTFh6Qy90YmZVUzUya0NOL2RIdFhpWTB1?=
 =?utf-8?B?NnB1cDZocU5mVWh1VGFqeHl5bndwa2orSko1TTJlV25FVWorZGJmeDYrSEtD?=
 =?utf-8?B?bEg5MGV5NHZBUmdqMDF6ZlUyY2hwUDlDTElZRS9VMllHSEZZNERncFk2YmhJ?=
 =?utf-8?B?TEpBbW9UQjlZS1lnT09Fb2hhZEw3VElRVktHU3dYSTlPM0VQbmhtV3Qwc1FK?=
 =?utf-8?B?aWFKWWhUZTFBVkpHdlZOZ04wbHVDYThmdWVuekE2OG5LOU9TeFFEOGQ4MDg3?=
 =?utf-8?B?RmJtSkxwNnR4R3FGSkVMeDdPeTA1TGpPUDc5eDAxa1laeUY3QjlFdlZmNGJ5?=
 =?utf-8?B?SWJzUmZUT29YczRhemJBREQ1UzVtcXZPL3owa3FiRXRha3g0OWRBWkh1Uk1Q?=
 =?utf-8?B?bEx0QmYwcXJKb3RCbnJFSWw5NFFhMUpTZEZHYkEvQ2J3RzlFWFNxejV2eVdw?=
 =?utf-8?B?bzJUY3NvU2ZqSVRuUEJOaEpUMXRacFhPcXZ6TS9LZmZzZmN2MmYzMzlubTRR?=
 =?utf-8?B?b1pwOVg5L0V3ckNldmptNkFGZk94QmU2eTFzWEZ3REJDSkxJQWkzdz09?=
X-Exchange-RoutingPolicyChecked: NJBqQGiMqFc7R5viEX4BH9Lv/RZ8xST7xHGV5FqD07SwspVJUa9MZJgjhnatNDwMktToWBDjzdGoonIURxwPDjEmGjxzRVlwF4HVjXm2k7pdpwwfBTsUOMBCFAn7wamCivDZTaFGFB47UZSxCq/4IX33dHFW41bHhmNP5KNr/YF51MGE+YFi0+3JP5pv695WJaM+taKmnWORWV6PNrWc9q8y3WUEVwtvAEwNbgbLaTKkWpPBqIpKPYaxfo9WEOG2+lWMODsLBnsdyCAvAfzkDC6OZ8OuiMPn8BXBKXtBWaaV6DoIIvsa5RkJPvyOs6Pzw1mdlFLOLJewFFWW5ou+bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcaf1bb-b5b3-4cad-be76-08de85759385
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:08:36.7924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIqSaHA8k/xBlT9bIycKy9HtmZCestQzxxeWZVYKJwrwQRDa/TYWRkx5wO5Yc48eDrpbuToF+/Vp5fOFe5qedg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
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

On Wed, Mar 18, 2026 at 04:59:31PM +0800, Honglei Huang wrote:
> 

Disclaimer I haven't look at any code in this series yet.

> 
> On 3/17/26 19:48, Christian König wrote:
> > Adding a few XE and drm_gpuvm people on TO.
> > 
> > On 3/17/26 12:29, Honglei Huang wrote:
> > > From: Honglei Huang <honghuan@amd.com>
> > > 
> > > This is a POC/draft patch series of SVM feature in amdgpu based on the
> > > drm_gpusvm framework. The primary purpose of this RFC is to validate
> > > the framework's applicability, identify implementation challenges,
> > > and start discussion on framework evolution. This is not a production

+1. Open to any ideas. Given this was designed originally for Xe we very
well could have missed other drivers requirements.

> > > ready submission.
> > > 
> > > This patch series implements basic SVM support with the following features:
> > > 
> > >    1. attributes sepatarated from physical page management:
> > > 
> > >      - Attribute layer (amdgpu_svm_attr_tree): a driver side interval
> > >        tree that stores SVM attributes. Managed through the SET_ATTR,
> > >        and mmu notifier callback.

Can you explain the mmu notifier callback interaction here? See below in
Xe the attribute tree is existing VMA tree (gpuvm).

> > > 
> > >      - Physical page layer (drm_gpusvm ranges): managed by the
> > >        drm_gpusvm framework, representing actual HMM backed DMA
> > >        mappings and GPU page table entries.
> > > 
> > >       This separation is necessary:
> > >         -  The framework does not support range splitting, so a partial
> > >            munmap destroys the entire overlapping range, including the
> > >            still valid parts. If attributes were stored inside drm_gpusvm
> > >            ranges, they would be lost on unmapping.
> > >            The separate attr tree preserves userspace set attributes
> > >            across range operations.

Yes, in Xe the divide is at the VMA level (set by user space) via VM
bind (parts of VM may be mappings BOs, parts could be setup for SVM) or
madvise IOCTLs which reflect user space attributes on current SVM
mappings or future ones.

The SVM range tree reflects mappings that have been faulted into the
device and contain pages. This is an intentional choice.

> > 
> > Isn't that actually intended? When parts of the range unmap then that usually means the whole range isn't valid any more.


Yes, this was an intentional design choice to not support partial unmap,
and instead rely on the driver to recreate a new range.

The reasoning is:

- In practice, this should be rare for well-behaved applications.

- With THP / large device pages, if a sub-range is unmapped, the entire
GPU mapping is invalidated anyway due to the page size change. As a
result, the cost of creating a new range is minimal, since the device
will likely fault again on the remaining pages.

So there is no need to over-engineer the common code.

FWIW, to even test partial unmaps in Xe, I had to do things I doubt
anyone would ever do:

ptr = mmap(SZ_2M);
/* fault in memory to the device */
munmap(ptr, SZ_1M);
/* touch memory again on the device */

> 
> 
> It is about partial unmap, some subregion in drm_gpusvm_range is still valid
> but some other subregion is invalid, but under drm_gpusvm, need to destroy
> the entire range.
> 
> e.g.:
> 
>           [---------------unmap region in mmu notifier-----------------]
> [0x1000 ------------ 0x9000]
> [  valid ][     invalid    ]
> 
> see deatil in drm_gpusvm.c:110 line
> section:Partial Unmapping of Ranges
> 
> 
> > 
> > > 
> > >         -  drm_gpusvm range boundaries are determined by fault address
> > >            and pre setted chunk size, not by userspace attribute boundaries.
> > >            Ranges  may be rechunked on memory changes. Embedding
> > >            attributes in framework ranges would scatter attr state
> > >            across many small ranges and require complex reassemble
> > >            logic when operate attrbute.
> > 
> > Yeah, that makes a lot of sense.
> > 
> > > 
> > >    2) System memory mapping via drm_gpusvm
> > > 
> > >       The core mapping path uses drm_gpusvm_range_find_or_insert() to
> > >       create ranges, drm_gpusvm_range_get_pages() for HMM page fault
> > >       and DMA mapping, then updates GPU page tables via
> > >       amdgpu_vm_update_range().
> > > 
> > >    3) IOCTL driven mapping (XNACK off / no GPU fault mode)
> > > 
> > >       On XNACK off hardware the GPU cannot recover from page faults,
> > >       so mappings must be established through ioctl. When
> > >       userspace calls SET_ATTR with ACCESS=ENABLE, the driver
> > >       walks the attr tree and maps all accessible intervals
> > >       to the GPU by amdgpu_svm_range_map_attr_ranges().

Can you expand on XNACK off / GPU no faults? Is this to the share GPU
between 3D (dma-fences) and faulting clients? We have something similar
in Xe, but it isn't an explicit IOCTL rather we switch between on demand
as 3D client submits and then resumes page faults when all dma-fences
have signaled.

I see below you mention page tables are modified during quiesce KFD
queues? I'm not sure that is required - you just need to guarnette
faulting clients won't trigger page faults when dma-fence is in flight.

Maybe give me an explaination of exactly what the requirement from AMD
are here so I have better picture.

> > > 
> > >    4) Invalidation, GC worker, and restore worker
> > > 
> > >       MMU notifier callbacks (amdgpu_svm_range_invalidate) handle
> > >       three cases based on event type and hardware mode:
> > >         - unmap event: clear GPU PTEs in the notifier context,
> > >           unmap DMA pages, mark ranges as unmapped, flush TLB,
> > >           and enqueue to the GC worker. On XNACK off, also
> > >           quiesce KFD queues and schedule rebuild of the
> > >           still valid portions that were destroyed together with
> > >           the unmapped subregion.
> > > 
> > >         - evict on XNACK off:
> > >           quiesce KFD queues first, then unmap DMA pages and
> > >           enqueue to the restore worker.
> > 
> > Is that done through the DMA fence or by talking directly to the MES/HWS?
> 
> Currently KFD queues quiesce/resume API are reused, lookig forward to a
> better solution.
> 

+1

> Regards,
> Honglei
> 
> > 
> > Thanks,
> > Christian.
> > 
> > > 
> > >         - evict on XNACK on:
> > >           clear GPU PTEs, unmap DMA pages, and flush TLB, but do
> > >           not schedule any worker. The GPU will fault on next
> > >           access and the fault handler establishes the mapping.
> > > 
> > > Not supported feature:
> > >    - XNACK on GPU page fault mode
> > >    - migration and prefetch feature
> > >    - Multi GPU support
> > > 
> > >    XNACK on enablement is ongoing.The GPUs that support XNACK on
> > >    are currently only accessible to us via remote lab machines, which slows
> > >    down progress.
> > > 
> > > Patch overview:
> > > 
> > >    01/12 UAPI definitions: DRM_AMDGPU_GEM_SVM ioctl, SVM flags,
> > >          SET_ATTR/GET_ATTR operations, attribute types, and related
> > >          structs in amdgpu_drm.h.
> > > 
> > >    02/12 Core data structures: amdgpu_svm wrapping drm_gpusvm with
> > >          refcount, attr_tree, workqueues, locks, and
> > >          callbacks (begin/end_restore, flush_tlb).
> > > 
> > >    03/12 Attribute data structures: amdgpu_svm_attrs, attr_range
> > >          (interval tree node), attr_tree, access enum, flag masks,
> > >          and change trigger enum.
> > > 
> > >    04/12 Attribute tree operations: interval tree lookup, insert,
> > >          remove, and tree create/destroy lifecycle.
> > > 
> > >    05/12 Attribute set: validate UAPI attributes, apply to internal
> > >          attrs, handle hole/existing range with head/tail splitting,
> > >          compute change triggers, and -EAGAIN retry loop.
> > >          Implements attr_clear_pages for unmap cleanup and attr_get.
> > > 
> > >    06/12 Range data structures: amdgpu_svm_range extending
> > >          drm_gpusvm_range with gpu_mapped state, pending ops,
> > >          pte_flags cache, and GC/restore queue linkage.
> > > 
> > >    07/12 PTE flags and GPU mapping: simple gpu pte function,
> > >          GPU page table update with DMA address, range mapping loop:
> > >          find_or_insert -> get_pages -> validate -> update PTE,
> > >          and attribute change driven mapping function.
> > > 
> > >    08/12 Notifier and invalidation: synchronous GPU PTE clear in
> > >          notifier context, range removal and overlap cleanup,
> > >          rebuild after destroy logic, and MMU event dispatcher
> > > 
> > >    09/12 Workers: KFD queue quiesce/resume via kgd2kfd APIs, GC
> > >          worker for unmap processing and rebuild, ordered restore
> > >          worker for mapping evicted ranges, and flush/sync
> > >          helpers.
> > > 
> > >    10/12 Initialization and fini: kmem_cache for range/attr,
> > >          drm_gpusvm_init with chunk sizes, XNACK detection, TLB
> > >          flush helper, and amdgpu_svm init/close/fini lifecycle.
> > > 
> > >    11/12 IOCTL and fault handler: PASID based SVM lookup with kref
> > >          protection, amdgpu_gem_svm_ioctl dispatcher, and
> > >          amdgpu_svm_handle_fault for GPU page fault recovery.
> > > 
> > >    12/12 Build integration: Kconfig option (CONFIG_DRM_AMDGPU_SVM),
> > >          Makefile rules, ioctl table registration, and amdgpu_vm
> > >          hooks (init in make_compute, close/fini, fault dispatch).
> > > 
> > > Test result:
> > >    on gfx1100(W7900) and gfx943(MI300x)
> > >    kfd test: 95%+ passed, same failed cases with offical relase
> > >    rocr test: all passed
> > >    hip catch test: 20 cases failed in all 5366 cases, +13 failures vs offical relase
> > > 
> > > During implementation we identified several challenges / design questions:
> > > 
> > > 1. No range splitting on partial unmap
> > > 
> > >    drm_gpusvm explicitly does not support range splitting in drm_gpusvm.c:122.
> > >    Partial munmap needs to destroy the entire range including the valid interval.
> > >    GPU fault driven hardware can handle this design by extra gpu fault handle,
> > >    but AMDGPU needs to support XNACK off hardware, this design requires driver
> > >    rebuild the valid part in the removed entire range. Whichs bring a very heavy
> > >    restore work in work queue/GC worker: unmap/destroy -> rebuild(insert and map)
> > >    this restore work even heavier than kfd_svm. In previous driver work queue
> > >    only needs to restore or unmap, but in drm_gpusvm driver needs to unmap and restore.
> > >    which brings about more complex logic, heavier worker queue workload, and
> > >    synchronization issues.

Is this common in the workload you are running? I'm also wondering if
your restore logic / KFDs design is contributing to this actally the
problem.

> > > 
> > > 2. Fault driven vs ioctl driven mapping
> > > 
> > >    drm_gpusvm is designed around GPU page fault handlers. The primary entry
> > >    point drm_gpusvm_range_find_or_insert() takes a fault_addr.
> > >    AMDGPU needs to support IOCTL driven mapping cause No XNACK hardware that
> > >    GPU cannot fault at all

I think we refer to these as prefetch IOCTLs in Xe. Ideally, user space
issues these so the device does not fault (e.g., prefetch creates a set
of SVM ranges based on user input). In Xe, prefetch IOCTLs are simply
specific VM bind operations.

> > > 
> > >    The ioctl path cannot hold mmap_read_lock across the entire operation
> > >    because drm_gpusvm_range_find_or_insert() acquires/releases it
> > >    internally. This creates race windows with MMU notifiers / workers.

This is a very intentional choice in the locking design: mmap_read_lock
is held only in very specific parts of GPU SVM, and the driver should
never need to take this lock.

Yes, notifiers can race, which is why the GPU fault handler and prefetch
handler are structured as retry loops when a notifier race is detected.
In practice, with well-behaved applications, these races should be
rare—but they do occur, and the driver must handle them.

__xe_svm_handle_pagefault implements the page fault retry loop. VM bind
prefetch has similar logic, although it is more spread out given that it
is part of a deeper software pipeline.

FWIW, holding locks to avoid races was rejected by Sima because we
reasoned it is essentially impossible to guarantee the absence of races
by holding a lock. CPU page fault handlers are also effectively just
large retry loops.

So this is one point I believe you will need to fixup driver side.

> > > 
> > > 3. Multi GPU support
> > > 
> > > drm_gpusvm binds one drm_device to one instance. In multi GPU systems,
> > > each GPU gets an independent instance with its own range tree, MMU
> > > notifiers, notifier_lock, and DMA mappings.
> > > 

This is a part I am absolutely open to fixing. Right now, each
drm_gpusvm_range has a single set of drm_gpusvm_pages. I am open to
decoupling a GPU SVM instance from a single device, allowing each
drm_gpusvm_range to have multiple sets of drm_gpusvm_pages (one per
device).

This would give drivers the flexibility to use one GPU SVM instance per
VM/device instance (as in Xe), or to maintain a single GPU SVM per CPU
MM.

> > > This may brings huge overhead:
> > >      - N x MMU notifier registrations for the same address range

The notifier overhead is a real concern. We recently introduced two-pass
notifiers [1] to speed up multi-device notifiers. At least in Xe, the
TLB invalidations—which are the truly expensive part—can be pipelined
using the two=pass approach. Currently, [1] only implements two-pass
notifiers for userptr, but Xe’s GPU SVM will be updated to use them
shortly.

[1] https://patchwork.freedesktop.org/series/153280/

> > >      - N x hmm_range_fault() calls for the same page (KFD: 1x)

hmm_range_fault is extremely fast compared to the actual migration.
Running hmm_range_fault on a 2MB region using 4KB pages takes less
than 1µs. With THP or large device pages [2] (merged last week), it’s
around 1/20 of a microsecond. So I wouldn’t be too concerned about this.

[2] https://patchwork.freedesktop.org/series/163141/

> > >      - N x DMA mapping memory

You will always have N x DMA mapping memory if the pages are in system
memory as the dma-mapping API is per device.

> > >      - N x invalidation + restore worker scheduling per CPU unmap event
> > >      - N x GPU page table flush / TLB invalidation

I agree you do not want serialize GPU page table flush / TLB
invalidations. Hence two-pass notifiers [1].

> > >      - Increased mmap_lock hold time, N callbacks serialize under it
> > > 
> > > compatibility issues:
> > >      - Quiesce/resume scope mismatch: to integrate with KFD compute
> > >        queues, the driver reuses kgd2kfd_quiesce_mm()/resume_mm()
> > >        which have process level semantics. Under the per GPU
> > >        drm_gpusvm model, maybe there are some issues on sync. To properly
> > >        integrate with KFD under the per SVM model, a compatibility or
> > >        new per VM level queue control APIs maybe need to introduced.
> > > 

I thought the idea to get rid of KFD and move over to AMDGPU? I thought
Christian mentioned this to me at XDC.

> > > Migration challenges:
> > > 
> > >    - No global migration decision logic: each per GPU SVM
> > >      instance maintains its own attribute tree independently. This
> > >      allows conflicting settings (e.g., GPU0's SVM sets
> > >      PREFERRED_LOC=GPU0 while GPU1's SVM sets PREFERRED_LOC=GPU1
> > >      for the same address range) with no detection or resolution.
> > >      A global attribute coordinator or a shared manager is needed to
> > >      provide a unified global view for migration decisions

Yes, this is hole in the Xe API too. We have told UMDs if they setup
individual VMs with conflict attributes for a single CPU address space
the behavior is undefined. Our UMD implement madvise is basically loop
over al GPU VMs setting the same attributes.

> > > 
> > >    - migrate_vma_setup broadcast: one GPU's migration triggers MMU
> > >      notifier callbacks in ALL N-1 other drm_gpusvm instances,
> > >      causing N-1 unnecessary restore workers to be scheduled. And

My feeling is that you shouldn’t reschedule restore workers unless you
actually have to invalidate page tables (i.e., you have a local SVM
range within the notifier). So the first migration to an untouched
region may trigger notifiers, but they won’t do anything because you
don’t have any valid SVM ranges yet. Subsequent mappings of the migrated
region won’t trigger a notifier unless the memory is moved again.

> > >      creates races between the initiating migration and the other
> > >      instance's restore attempts.

Yes, if multiple devices try to migrate the same CPU pages at the same
time, that will race. That’s why in Xe we have a module-level
driver_migrate_lock. The first migration runs in read mode; if it
detects a race and aborts, it then takes driver_migrate_lock in write
mode so it becomes the only device allowed to move memory / CPU pages.
See xe_svm_alloc_vram() for how this is used.

I’m not sure this approach will work for you, but I just wanted to point
out that we identified this as a potential issue.

> > > 
> > >    - No cross instance migration serialization: each per GPU
> > >      drm_gpusvm instance has independent locking, so two GPUs'
> > >      "decide -> migrate -> remap" sequences can interleave. While
> > >      the kernel page lock prevents truly simultaneous migration of
> > >      the same physical page, the losing side's retry (evict from
> > >      other GPU's VRAM -> migrate back) triggers broadcast notifier
> > >      invalidations and restore workers, compounding the ping pong
> > >      problem above.
> > > 

See the driver_migrate_lock above.

> > >    - No VRAM to VRAM migration: drm_pagemap_migrate_to_devmem()
> > >      hardcodes MIGRATE_VMA_SELECT_SYSTEM (drm_pagemap.c:328), meaning
> > >      it only selects system memory pages for migration.
> > > 

I think this is fixed? We did find some core MM bugs that blocked VRAM
to VRAM but those have been worked out.

The code I'm looking at:

 517 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 518                                   struct mm_struct *mm,
 519                                   unsigned long start, unsigned long end,
 520                                   const struct drm_pagemap_migrate_details *mdetails)
 521 {
 522         const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
 523         struct drm_pagemap *dpagemap = devmem_allocation->dpagemap;
 524         struct dev_pagemap *pagemap = dpagemap->pagemap;
 525         struct migrate_vma migrate = {
 526                 .start          = start,
 527                 .end            = end,
 528                 .pgmap_owner    = pagemap->owner,
 529                 .flags          = MIGRATE_VMA_SELECT_SYSTEM | MIGRATE_VMA_SELECT_DEVICE_COHERENT |
 530                 MIGRATE_VMA_SELECT_DEVICE_PRIVATE | MIGRATE_VMA_SELECT_COMPOUND,
 531         };

> > >    - CPU fault reverse migration race: CPU page fault triggers
> > >      migrate_to_ram while GPU instances are concurrently operating.
> > >      Per GPU notifier_lock does not protect cross GPU operations.

No, again retry loop as discussed above.

> > > 
> > > We believe a strong, well designed solution at the framework level is
> > > needed to properly address these problems, and we look forward to
> > > discussion and suggestions.

Let's work together to figure out what is missing here.

Matt

> > > 
> > > Honglei Huang (12):
> > >    drm/amdgpu: add SVM UAPI definitions
> > >    drm/amdgpu: add SVM data structures and header
> > >    drm/amdgpu: add SVM attribute data structures
> > >    drm/amdgpu: implement SVM attribute tree operations
> > >    drm/amdgpu: implement SVM attribute set
> > >    drm/amdgpu: add SVM range data structures
> > >    drm/amdgpu: implement SVM range PTE flags and GPU mapping
> > >    drm/amdgpu: implement SVM range notifier and invalidation
> > >    drm/amdgpu: implement SVM range workers
> > >    drm/amdgpu: implement SVM core initialization and fini
> > >    drm/amdgpu: implement SVM ioctl and fault handler
> > >    drm/amdgpu: wire up SVM build system and fault handler
> > > 
> > >   drivers/gpu/drm/amd/amdgpu/Kconfig            |   11 +
> > >   drivers/gpu/drm/amd/amdgpu/Makefile           |   13 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  430 ++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  147 ++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  894 ++++++++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  110 ++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 1196 +++++++++++++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   76 ++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   40 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
> > >   include/uapi/drm/amdgpu_drm.h                 |   39 +
> > >   12 files changed, 2958 insertions(+), 4 deletions(-)
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> > >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> > > 
> > > 
> > > base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> > 
> 
