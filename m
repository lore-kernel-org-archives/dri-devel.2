Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50706107BCE6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 23:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE0010E03C;
	Fri, 13 Mar 2026 23:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UJT6LzrW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800BE10E03C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773444034; x=1804980034;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GqGnsCH/0YW5KDWfPIUDa3lCyXbs39OS/f3Uox8Mt9Q=;
 b=UJT6LzrWmHym8sFQGYKbx+UW8AmFxBXRmHHEG8Kqc3C+pHMqCY6NX8TJ
 w1UeblmMcb8XfFupjjY1BLyx1vSK40kv9VoO7199kxTFhzfyVoRqWsnEA
 V5A71LXiniGh2kSbRvsmqK93V3YRf735gVo464qaLlW1CfeX0KuDNvIoB
 OK9UHksbdTd/sVyC+pXzg+1+twRAnZS/nzgo96h0rg5KTWoDSkpCXsHLf
 LxOr+8G8W18NROMwY+cVY5QKOYqvfgfaU7d+TCuLDtlJkWEd12mHqerYG
 E5FN+hiX1YTs7nqJUHvgbniDxuI2UjM4TE+F5gkBiaYtadCnUVn6uX59U Q==;
X-CSE-ConnectionGUID: M69uWRVkRDKQB9Ly8tLkTA==
X-CSE-MsgGUID: MMaMmooDR4iCaUvuaBz4eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74635967"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="74635967"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 16:20:34 -0700
X-CSE-ConnectionGUID: h+AbCpgTS4izex2jb6E0lg==
X-CSE-MsgGUID: 6p1mkJ9xR5S3wgcNKRCFnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="223670981"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 16:20:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 16:20:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 16:20:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 16:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD9vzhdEv+SUwEwT/WvoEQVTVkajbJjXgRiMRz/o9dAZ7V4whKtU/RzxwtlyEk+7xB/ajIX/GRuksn+D3M7S+Am4SzdMJ4zptQqLW8aAx61KYFtuOM3zvdctlq8uCg2IMTVWViwIq01HdmQ5QmbtOsqyuUoXhXAPjZ90yWyqa9J8VMlxmvelD0DgtW6+J5W6EHgt2gGNPRpmjZFa3/BCNpcq2Hvg4iJptNpI/5/LTzIeLBkEeSJgU5SRDapCZHFFQJaekVPX91UAG5Gr7Cm5m7+9CunGxY7KLAQ1NFgn8c4wSX4joRI7K6oO25UCdJSOM53pmeU0dgrLQ+a5rbZLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4JjD5g9Rz4OKwhjN30GPBbcRdO7tCjtef4XP/EYHdA=;
 b=CX3UiZ/Y+ZargrpHq5IvKIOrgw8SPkDEZ2vf+cNcYLC7pmkoCwVpDCSbIBn3cmnM7BND19c8WmGB0MzHJ8jX2E3zFrDPthgTKrcoQFgeK5EenADS/+DHeQjxfjmqVi90TXTJiMGF+tKujIYOGoNo89FN0K+cfdF9xU32mySb5vUKmXmo1u+DPpw4fScB965EkYGfjYH4IB3J3Sytbc1dT5X5grMHipy6IbWrIQZOChACGnrrsitk+lqjA4bBJs/P1D1UpLQgpbNg0n72rgaXUskNA5w89NHQFOjOhbWUYKZN4hGIVorRsM6LJtio7X1xqxyfDA54pcub+Uq/sYYv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 23:20:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 23:20:29 +0000
Date: Fri, 13 Mar 2026 16:20:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Philipp Stanner <phasta@mailbox.org>, <phasta@kernel.org>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Gary Guo
 <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] rust: sync: Add dma_fence abstractions
Message-ID: <abSbutMzXrSaLG4q@lstrano-desk.jf.intel.com>
References: <20260210142631.6f8a3411@fedora> <aYs3VVH_UXMFa5oC@google.com>
 <f4c32d9a-7303-4a50-aafc-8039102fbd3e@amd.com>
 <aYtJznZcCEYBffil@google.com>
 <d9e00d8c-93c0-45f8-95f2-3235fb781e7a@amd.com>
 <3d90656315ab0b52f4725ca7c2cd10859d1e4f69.camel@mailbox.org>
 <CAH5fLgjNS1e420UX7muyEPWX3dZ-JsA_uy3=PM7QLA2NuoKJmw@mail.gmail.com>
 <50ee6f3f-82d3-4eb6-ae3f-9f032f3caf1d@amd.com>
 <3fa96185ef99f56947360355dc55739d66043f28.camel@mailbox.org>
 <DGHBFFSLQH1F.162H7FOVAS22B@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGHBFFSLQH1F.162H7FOVAS22B@kernel.org>
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPF801A91A7D:EE_
X-MS-Office365-Filtering-Correlation-Id: cd95e048-1621-4009-d627-08de81571d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yHTj31XQ/fUcBIYJWHT5Tkw8iACQ6GiVzDXBgDtpsTlzGxdVv9TVtS2nHVcEAB7JQNFOef9jyN5vGLbZ1ZlK2AUWVq5ZWjCa06h3tnLYyR9snSkoTtrkYRzE+4NLwOL4ZWLaczpBz1ui54gjk14zqkb3uGelFm9kMpJwr3H55Kc0Q/LYA6cFaQoE/i1HIEFaLbY5dmpofvaKB6mpnXkCCzgskY3cK5FsH5JKvQbsJhJ2cX+MB+2Im86retoe2M1gik3msjQX1vv50YIJgcxAkR/wW/bw8ijjrJ7sTyBoWpJK8/8W0y/4GnNqMyme1jT1ybWLPRic7Vt+Wvp8SSEQSuq85Pvpmrwbm6ybPkPt1UfFZ22C/HRscnE2uE7le9DYs6Ldx6QUdHIvtr+3t3t1Z1oOajLNxcbZ1EsyJ0VVUOUCugQqYU9I+x1SPfOZcWWgnYJeapR+a8QDn50NpiQdhe8WboDhDwQOYQxaJb3O8T/wEBwe4mlZ7+MBDpRJKPI2s5I5c1pncIgsYVnfEhxvToyD/QPEDSpZlIzW451yxX1CI62Im0P0srCn5JFRS7x9oMRcK4hJyzkRyhcqWioi9/S03zMVVDp2Rv5dqFwvI4DG9HNO62EUfb5WDCL7bHy95ZqlZiagDdEuJt8YZb97PmGBKyNXY/5hgit3kaSEufMo2yXwtGzRYomA2blcSvK6MtN278SHUfpZ13hAf3OoJtzLxKSD+fkcXbdswFbCZlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBaTTA0SzQ4YTFBclBXMWJJaStOWUc0QmNsMkNBcnZFSW1LSkt1RXBFeG1L?=
 =?utf-8?B?SlU3dmJtdXBBWGhvWTN4d2V6Ky8vK1pIOVJWZlBwMDNkbm90NGVwUHhrYThW?=
 =?utf-8?B?UFlVaFlGT3l2R1NUZDFYWEVmVm8vbUltK0FtaER6TzNFZW9GR2F3bE93Vk9X?=
 =?utf-8?B?QVBva2E4VTFPRk5zLy9GNE9zVHZINmxTcDkxS0tOOGVxNHlTa3dKbGYvbk1Y?=
 =?utf-8?B?TThXcmNqRTJwdWErQUd2anZ0ZjFIWTdOSnJtemxlRHJoSzJVd0JBWVE0VnNS?=
 =?utf-8?B?UncxOVd4QlFVN1kxQnc5ZkNyKzMrcytOb3BmYVk5YjdBV3I4YVRmYVMrWVpH?=
 =?utf-8?B?aSsxUEExL3BIUjBOSEo4NXdSL3lxS0IrVm42OEhIZW9oUmdXdE1vcXZvK0Q5?=
 =?utf-8?B?aWpJWS9kcHdTZjNydmt3NkUxeWk4enNpc3dMREF1eWxzT2JKdzREWXRSYTJR?=
 =?utf-8?B?OTVYVmV0cXBCOHB5Qy96TG9kczUwT24zRGc0d0pqSjhnK0h5aDJqRU1oNkhK?=
 =?utf-8?B?bSs2RXZ3d0ZqanBEMjA3WXJEQVRGTU9BazQrU01ETHZWVW52YUlTYTg3bnM2?=
 =?utf-8?B?Q1RJZEJKNzkvLzBSYlp2UythRVpGcVplc0ZsNlYveWVaam5LKy9HYUF6b0d6?=
 =?utf-8?B?c21wZHJZVjRnL2F6ekdFTXZmOEd5N3Z5YVhuNFVsY25FV0lWVi8xeW9sTUov?=
 =?utf-8?B?OTRTRFhEcm9zVFhIY2tRRWdUalRvNVNPSTJBOGtNRkRLQ0JTNFRUV25SSy9K?=
 =?utf-8?B?Y1RtWU5ZcDBWVzZNWmEzMXRiVEZGR3FCb1NMVWl6RWcyWi9LSjh4ZDhaNXlH?=
 =?utf-8?B?Y2s1bnJLcU9jbFJXTUIxU1l4V2RabTBYYldORTYyeksrZ0FkRzZMN1pmUkha?=
 =?utf-8?B?UWlwRXRUSmlNZDZlYW9jTHkveFJhVFRZNW1FYlNjZkhzUitHT1pBTHdmcEM0?=
 =?utf-8?B?V2JJUkhRWkFuNGp0cytkb2hEMlpnVC9UZlpudy8zL0pDanIyTGpYOS9UdlpH?=
 =?utf-8?B?b0lodmt0R0xVUWhRSU9WS0pZdER5aE9hbG83NWNNUXZpbzMvZlV0bVRONFNC?=
 =?utf-8?B?am0vcnh1YjV4SmZWNlVWNGN1d29ZL05jQ0EwVmRFaWRiaVRiMHk0TURQUkxO?=
 =?utf-8?B?eW54T2xVNi9Rc2tHeUJqM0ExZytVcWhOTmJvQUdXOEdHdDRPNjNucGczTnBM?=
 =?utf-8?B?enl6Z3VTTUxEVFhLR095ZUk1aUMvT245eHlGMmtqeU9RY1BYSENKN1M1MXNM?=
 =?utf-8?B?K3NpOHQ4eUF4cHM4aXE1V1o2K0ZTNTQ1NTdxUnZqQ2R1ZXExWmJIM2ZlbWVI?=
 =?utf-8?B?WUxoZWtsd2I3RGwxeWNlSnZWc2pqS2JWVVM5Nk1lUkNRQndqeHJ5c0Q4Mkps?=
 =?utf-8?B?ZHRiVG1VblJYV0JVSGNWVjlQTktDSjBnbjAzMk9PcG8yY1A1bHIyUXZNYmVB?=
 =?utf-8?B?cHpPbC9HbCtkSjJTR0N0cTNyUmxVcVhzUG9ZdGhCWlRHSDJaZCtCWGo0SndO?=
 =?utf-8?B?a1RvZzA3NmFCL2wyZk5CWTdZRjJlSyt3aTVLUDk4UGdWK0R2SUZNbitSK3VI?=
 =?utf-8?B?OTJqbTFlZlJwejI4ald2WXJHVVBncldUcWRUaGEwZmsra1RkRDhZTFEwRENh?=
 =?utf-8?B?ZnIzaWRjNUxkMFlSWUVRNmJNMDZsVTgxVlB3bXkrc2dPVWRadDVaWGpCVzVp?=
 =?utf-8?B?Mkd4V2RYVFRXOE1kaU5lQnRKZmlPaGttak14ejh1WkFBNS9uZ3V6VGhITGty?=
 =?utf-8?B?Zm43UXlPN1lMUDlmRzcxdTJsZUQxZjRxNlpGVlcvcWk5VUo0VmV0ZFNNRGd5?=
 =?utf-8?B?RlZWSFNnVHo0WE9FV3ZwdXByd1hjK0hDZDFCMXo3ejhDYjhGUGZSQ3pweGx5?=
 =?utf-8?B?a2hsQ1BYSjR5YTI0aXBIWmpWUURXeFR6dHJaamVxeGxGOFoydi9zeTF5T0oz?=
 =?utf-8?B?T0QwNXNEcUJ5Tmh2L2Vnb0xXcEdQdTc5MUlLR3RMdytzNm95Y3IwY1pISjcy?=
 =?utf-8?B?YTVzQ1ZxYTFaYytIRmJpUjkwM0s0N2Q3QU8yVk5rRmtMNFdyMnhNM21lVzV3?=
 =?utf-8?B?b3Y3VGo3NjhCdVBEYzVVV21SQzFhQTgxQ2x6L1p0KzcyTnZVYW41aXo1SUpB?=
 =?utf-8?B?K0pEMExDb3JvNkw5VDQ5Ymxnd2FKdUlXWkp0a1hrMEN1eXNrc2FRZEFWYzZU?=
 =?utf-8?B?RlNxSnVZTDR3eTJLRU5MMnFPV1R0YjExaGlhdHNLZnkwS3ZrcnJsOEs2NG85?=
 =?utf-8?B?K2VXL00va0tJSEMvOVJ1RGFzSDBzc0xlSzFEcHI1cVpiREsvcTZ4dmpVZjBV?=
 =?utf-8?B?bFErQlBnMmY4WkJxY0R4Q3Yzek4rYXM3L0J3ajFOUnQwbmNjTThXQkNSMFpp?=
 =?utf-8?Q?XSHTEvjQjlUYiC0Y=3D?=
X-Exchange-RoutingPolicyChecked: ez8n4p+/Eql3XQD65szjoUj92xNn8KsK9GVl1pgM/86gqJv26YPH3xH++7jC9AGolivtXOV+rYjNpEJPIroBV2w/lsGeCQptx5v45+BPI1Y+8ws0eIttzTfSyL6R1KoQoWSmNjXvAbzLkagGtb+wD893P5rgjKCp0PhLvq5BKDs6dRitJ3fjeJvaYkg0J7ZS21MmpuGwR8nONpHNFwmWZCvqv+XYo98BRQcDrcxs7scmF1IuDD882FmFTtLYmvgLwvH97jBYldKudmADtm0F83+eCRAaCDxpfZt7wi2nvgwcxixhGLpCkFgtYNOGu+NYiRmIKV8CTcBGhR/K9nrwzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd95e048-1621-4009-d627-08de81571d8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 23:20:29.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCUb4hVFVhcaQRMFoPNOjDevhRuhZdTCdRy1J6AhM8xyzIvB874ZeY4IMexS7ghcg47UP4repcUFlM5w35w8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
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

On Tue, Feb 17, 2026 at 03:44:06PM +0100, Danilo Krummrich wrote:
> On Tue Feb 17, 2026 at 3:28 PM CET, Philipp Stanner wrote:
> > OK, maybe I'm lost, but what delayed_work?
> >
> > The jobqueue's delayed work item gets either created on JQ::new() or in
> > jq.submit_job(). Why would anyone – that is: any driver – implement a
> > delayed work in its timeout callback?
> >
> > That doesn't make sense.
> >
> > JQ notifies the driver from its delayed_work through
> > timeout_callback(), and in that callback the driver closes the
> > associated firmware ring.
> >
> > And it drops the JQ. So it is gone. A new JQ will get a new timeout
> > work item.
> >
> > That's basically all the driver must ever do. Maybe some logging and
> > stuff.
> >
> > With firmware scheduling it should really be that simple.
> >
> > And signalling / notifying userspace gets done by jobqueue.
> >
> > Right?
> 
> Well, the timeout path is part of the fence signaling critical section until all
> fences have been signaled.
> 
> But, if I, for instance, just kick off another work from the timeout handler and
> subsequently signal all fences by dropping the JQ, this other work must not play
> after DMA fence signaling rules anymore and is free to do whatever (maybe even
> take a device coredump without needing GFP_NOWAIT).
> 
> Xe does this with xe_devcoredump_deferred_snap_work for instance.
> 

Yes.

> >> You also potentially want device core dumps. Those usually use GFP_NOWAIT so
> >> that they can't cycle back and wait for some fence. The down side is that
> >> they can trivially fail under even light memory pressure.
> >
> > Simply logging into dmesg should do the trick, shouldn't it?
> 

The trick is to make devcoredump a multi-step process. In the TDR,
allocate as little memory as possible using NOWAIT—for example, record
the parts of objects that might disappear, or take references and store
them in the allocated “snap” object so they remain stable. This is the
snap step.

Next, kick a worker that looks at the snap and allocates the memory
needed for the capture step. Here you can safely save off BOs contents,
for example..

After that comes the print step, which converts the captured data into
human-readable output for the devcoredump.

This is actually a simplified view: the capture step can exceed the
kvmalloc size limit (default 2GB), so your print step may need to
trigger additional capture phases. Multiple capture phases also mean you
must hold onto the snap for a longer period.

There is also a time-complexity bug in the capture printer. I added
support for offset-based reads of the print data to prevent it from
becoming insanely expensive.

If you have any questions, feel free to ping me, or refer to
xe_devcoredump.c for the implementation.

Matt

> You can't "log" a device coredump into dmesg. :)
