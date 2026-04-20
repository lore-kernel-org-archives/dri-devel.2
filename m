Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1239FF588EE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4BB10E6DF;
	Mon, 20 Apr 2026 16:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SZERNu84";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C5E10E6D9;
 Mon, 20 Apr 2026 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776701197; x=1808237197;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=KRflUdpyqPKXOuKLLoI+/Q/mhRVoOkLvKPy9RGEVrb8=;
 b=SZERNu84YQpL/O3i7jfd96wVFVfQ/HetLq6BGp8zIUkMQpdkvouE3OiF
 dzpc71sik0lALzEqQmzmNPF70qnxYB/BYqmedavBt5IEZABC+hvusoQyd
 1riT+RZQeYJCyec/54SAVBOKzhPyAxvLgp5qE0aKKqbb35DOBSxcQOgrO
 jyzky/vApGqEjf6577zyDpy5SLW0F8DfuUUVQaWvaW55dwPI4FLx0jf4y
 VCDdERfJGSKjZGlt7yie3NMtIEqVNHTnnrXf/CrNIfuQcus3l7BfzQ4EI
 Xk/89Jjn+uQrrxd8WZqhb1LpoXKG6L4rXZdNA6aJv9Ysyw2p/grkR3Sic Q==;
X-CSE-ConnectionGUID: qsbIfplnT2qUIxkYlFvFCw==
X-CSE-MsgGUID: VIRshkqZSw6DOWtrmnpQDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88239388"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88239388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:06:36 -0700
X-CSE-ConnectionGUID: 3qpXK0inRqyE+sm7nlZgvA==
X-CSE-MsgGUID: 9yEm4f8RT56S9QQiSm0USw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="227419017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:06:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:06:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 09:06:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 09:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXI/cYoGA57A3EidoHYQ4KVn0ZFaAW1lP0caz4X3Yb5PxiIEzLDm9ACNgLo+5vRL0QWQW/FM8MrftkrtnwG8qudT4Vl2YeRfRU/0SexvPCau/ujrz6DDt9tgdzvzYYr8DmossLsqF5lQ1c4mvE9FlbdEtAC+k+rTTrN60Eiu18g2u/zHd9cJitB+a5X6M6iEUbpphk1cmquRcvt8+FLFR8tulQDUJRVKe+KGzBvU1XJyoPH15WhR3yEag+Ne3byaUSPlwCsHCxJuHnR+muS+EQ/e3SEp6AMHGw8XtxyRwqwG8I1kMCKdCDXR5JWXuxngzeImbvItT6vPeMyFkNpaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKd2XLSuXH+NvGxWRfsUxXUqCeSDFFUOFEMWVtqQyrE=;
 b=SkIkwDH5PHCPXjkzlYVp4YsZPuWzHkPW68LKiZ+C1MbqaPETUI+8NmTFy8aK2AdOhJoeiZR3IOxyjQxs5PfAx7Sh65kNF758MwWoeuEfr7TIgp6pWAmehx+9weXvLKbrLlufQpubPgTrfxnrF1sbVdoJTlHMIuor1YbO4iKRowwLVQvFrFfAkULQ4oHtrIkjbt9+hJmLWp7VYTFHX7bLNu/zwzYHsDymjYezaHgiZqOgqtNAx+fqhS7BagkxdkNvQgG1LUsjVp4sgEMhxw1VHpzbX+R9tagWzSpIRYAjws/yHv5DFNzSW5Drg9qTmb5hrCltqR4BN7FSlecROMnV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPF31CEE2CEC.namprd11.prod.outlook.com (2603:10b6:f:fc02::1c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 16:06:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 16:06:33 +0000
Date: Mon, 20 Apr 2026 09:06:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: "Huang, Honglei1" <honghuan@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
Message-ID: <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPF31CEE2CEC:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0b4573-d7f9-402f-1264-08de9ef6cae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: p0P7+OzlbCPTakLQsUWxzenLCrWpeSDaxD6yKA873XLJ5UqizOy4q9Kp6zmzq2xpDwMcPLioktuI9oiMlkCKnR2hg7DJMhKvfMJ/zEKVI3K7hxsPBievEJGICsrNbdkf7kNQUaygEEmKA0JOWgdoV6krzFNX4d1e6e76CsllIGR9kExmur48kw2LYfwoPLQxGnVwj05U5CSkBuC+0qf712Fv+0Vx/470YGk+Wi0m5U3KOBPL3kbEqgO5ElZ4rvCcQbrKrzb5QFNoLNg/yi3iNCbZCTuQOX7mecqFm6ZT1kMLJwC0RVCaQNOex43Cx4fmtMaYxldtH2mjtdAxoaL8PvToaUb3+vtt0G6xz7M671rGxLMdGbtPkvQ9/HQjdWBjfiG+z+R1uEC50+dcO6CdwbAR1iiodr6fzaRLmW2OzgXAGNMY5lUUFekzGst8rt22vK9IfRCj2/URXJv6zL0Jtli+WvoRSkXfVHVsuiIx3PPyQS6603arLO9HCqSeTrLXXeO4zOnxkrRPLaWgXsj/PdzCL6yCetm84kDHOGFjbr63l1RSUXqBn7xsx0bu5waNOrpYp/T+0l0lmK+n5pQgyUQbkPPj7uTjcz/IHCn25EaGG9CXL+GRwH7UghpiZd7G26p2RFvzOH6CqQwNbYszTIRwlDgnz61B2ZSIpyG7VJi6lVU7DbnrDxvY8U3k+cHzvljRsqlClcHTWsDsskqYy1hYwh/7CARL6aZFUAEicfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBCZzRBS3dMUVFIMHhVNGtBZnl0S283THBJSEhibnloSS8zbHZhckl0azk5?=
 =?utf-8?B?MDQwS3NieXQyS3ErUGZERVEzVW5VT3Q2M2V3bGRsZmlMbWJoaWw5YmZpY1Nz?=
 =?utf-8?B?SGxySFV1VWhCNkZBU0xiZ1FTcWRreXQ4bTlLWkJxQm1YZEYxSnd2RDU4aEw0?=
 =?utf-8?B?TmxzZ3NvSVFlZnc1UkRyNlBWdGtVR1pobXh1bXhJSWhaUkJiVlRJNFpOK3Zx?=
 =?utf-8?B?c2tZV0llRjRkcVl5MDRyVUlNSFh3MFBpNC9wanhKL1FYWnMyaGNZck1nSnJS?=
 =?utf-8?B?bk1rbzF4N0FiOWhiV2JsOTk5OGVzNTQ2L3kvbUlueXp3T2FVTmlwZk9aZ3BX?=
 =?utf-8?B?dnlMc0JHNm93OVpmTjB6clozcmVpNmJDRnUvdW15b1N2OWFyWEFyeWV4U2Zi?=
 =?utf-8?B?MVAwVDZha1ZIZFFzT0hUM0J5S1dlL0FTNHExVU1SNTlwaHREeVBUNnpFa2Z2?=
 =?utf-8?B?cXU5V2s5RW1KTGxjM2lzcHpVRzFlNE5UVTU2VmFJRnArSGkzdHBLZVlCTk04?=
 =?utf-8?B?TVpqQldxQVVwYldVWlRDOFJkU2diSUdINW40c0JUaVZDUEdJTTFNVVpLQ0tz?=
 =?utf-8?B?bmM0Z2JGNXg0aWFXZ3VKbUVjYXZXVmxqUC9adWlIWFYydUJFWmpIMTAxZk1K?=
 =?utf-8?B?S3d3MVM3RkJoWE1QRWVJY1BHTFFCdFdpekMwMWg2Nk9tU0JmYk10enRCUk01?=
 =?utf-8?B?bWZYYmc5ck5zWm1sMjBaNjduMis2aS81dmpvVzZKRWUxTzRibG9WaVM1MFVa?=
 =?utf-8?B?UXF3enpBR1NwZVVUQTJxaGZYTndxUCtQaUNsSE9kWlptVXEzSHBVRk1vT1Nz?=
 =?utf-8?B?OTJGSjV3S05IVGpGN2NjUlRtbWI2VTRMK01xTGFjbWV0T3J5N2hJLzJSMHhv?=
 =?utf-8?B?VDRMb213V2l4WHdVWkMxTHRvR0doUjdJTXRxTmUxeHBPM1dack9nOVNvdXJH?=
 =?utf-8?B?QnBGb2pzYUlSV0hldHdDaFp1dmtGODNtL2Q3SkRPYVJSZndHWS9tOGV4NDV3?=
 =?utf-8?B?OHJaY25tWXFqbm5LYzQzSUZBUmh5ZDFBdXJ6TWM2REFHYTBUSkNPWjU1Mk5l?=
 =?utf-8?B?aFpzZ2J3czZyTWpwbnFQc1BSM1ZnQU1VMnRHRUJoMlFHY0srd2dETk9JbTN3?=
 =?utf-8?B?RVBMME9mUTF1MXpwc2ZydXJLZDBRRk1mb3VlcnhnMHkzcXBtUUcvK1hXeG1R?=
 =?utf-8?B?cm9XaFhaRjQ3ampxb1dJZzh5N3lPTXRaaHRtYUs5OHRXclFDK2p4bmdjYmZ2?=
 =?utf-8?B?c3J4QlV2QzllZ1Z4NnFpV2JiU2xqYklpMXhZMGNwaGVBYnlKQjF0NU1IZ25Z?=
 =?utf-8?B?WDNwVURoM1Z5dmJqSngvcWhqZ1dqczZ2cUFDUThxWmNUWVRpcWhEV282bHZ4?=
 =?utf-8?B?d1A2RnFtUlhWbXF1OStVMENpQ2szZXdGUW9uUkFmamJDWTJFMHdRbEgwd05o?=
 =?utf-8?B?VFpEQnhPcXhReWtPZVRRelNFVk9WZGJjOW5hLzJqaUlnQ2Q5dUFDSEU4UHpK?=
 =?utf-8?B?dk5lYU9FaWJzWWVHZHp5OTE5OFVhckl0STdmSFB1OGZQUkltSGZkSXBLUGow?=
 =?utf-8?B?a3FLdEM2b3ZoSG4xaWR5UWgzbXcrMldwdHcwM29ucTJiRHlsSjEraUEwb3dZ?=
 =?utf-8?B?eStrdC95QysrWmI4NVgzV29pRWtYOUtHM0V6a0RBMTFENjVJUk5NMm01dGhC?=
 =?utf-8?B?Q0xQWjRQL21MYnFXOU51NzI2VXVsdjFlWml3TU9UdmRieDFNbU96a1MxY2RQ?=
 =?utf-8?B?Q1ZCWTdPU0xmaGNkSjZVdGJCckNvUE9OaWdYVnhDRVE3REYwaU1MSG93TlBa?=
 =?utf-8?B?b0QrN25KbG1ZOTJZb3ZMNkpOT1gzREVJMXdPQlhZaThqblBxQ1Q1WE95b21K?=
 =?utf-8?B?Y3pKeVF1TjF1akgwUGpIVDNvY2lvUzVyZU1UckcrNHBmcXoxRGcwdDFjWFl2?=
 =?utf-8?B?VnpyMytuc0srcExZbFdkN2lNZWdyOVVsZ216SzJoeHRQM3NSSkRnSm5vM3lL?=
 =?utf-8?B?RGYvYWp4VGIyM2VLYTFmUXRLK1RHa1VhMlJ0REdJdFBJblN4c3Jqem44bGdX?=
 =?utf-8?B?L0NHU1VpbGROMU56bDUxNHJrRVRPalFmU1BJRmNSck15WDA2aVgxL0E5RDVM?=
 =?utf-8?B?b1VHZmZEVmVsT2ltaW5oR1Qxci9Qb1VoNTlJNGZOVytFQ2RtZmQrcTlzaFVY?=
 =?utf-8?B?L1dZU3MzY1J0ckZLWE1QOW1kWDVWUUp1N1AvZ2g2bEJhUnVVdmJBSUhBaGkz?=
 =?utf-8?B?ZmpCY052TFk3RDFndEt2Z0ZtOStnNnhhS0tZajV1bXFrYkhjbjh1N1U1Nmt4?=
 =?utf-8?B?Kzl4VFA3NkRLN0hKQktja0xIb3VmUVNYRnA3UFlyRmxaOEdKUVA2Zz09?=
X-Exchange-RoutingPolicyChecked: XqFaX60JqrDe2pB5mvbM8Pfsw+of9Ue9rj3R+danS3Qze6c5cz1+vZz/UJllyF3MrhpcNnh7naRrJNVd/Vq+sz1/LbMDr5hePqqqZbLEtFX6pedeec0/EpU9TFf5ASmYhipg8DW6zRneR5hs6AN88uctxtnXLmOatLghouljWwfWXtgFZiJHkoDDi9/jUEouv2xyEjkY7rXpjMSkrwHlVIg+/rywerpL744RTy1FF/gwCON1mjIlxA1pTwdqtEE2meRRhNQ/soRh4aMefVSZvPo34Wl0c0nH5YycA6G3e9pN3ERHwNZ9+X05huLnBkLkH7WK0vU4wQsDSGz1axoWJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0b4573-d7f9-402f-1264-08de9ef6cae3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:06:33.8104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1bzLQUViTice7ZzUSr6Tgq/0fM6OQQK5gWdt+Eb8pcQsN7ZTTXP2iAIEASxVboo3RxoRopjnvSuCZNmuCAzuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF31CEE2CEC
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

On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
> On 4/20/26 15:30, Huang, Honglei1 wrote:
> > On 4/20/2026 8:15 PM, Christian König wrote:
> >>
> >>
> >> On 4/20/26 14:07, Honglei Huang wrote:
> >>> From: Honglei Huang <honghuan@amd.com>
> >>>
> >>> Add amdgpu drm SVM API definitions built on the
> >>> DRM GPUSVM framework.
> >>>
> >>> This includes:
> >>> - DRM_AMDGPU_GEM_SVM ioctl
> >>> - AMDGPU_SVM_FLAG_* flags
> >>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
> >>> - AMDGPU_SVM_ATTR_* attribute types
> >>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
> >>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
> >>>
> >>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> >>> ---
> >>>   include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 39 insertions(+)
> >>>
> >>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> >>> index 406a42be4..bed71ed9b 100644
> >>> --- a/include/uapi/drm/amdgpu_drm.h
> >>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>> @@ -58,6 +58,7 @@ extern "C" {
> >>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
> >>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
> >>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> >>> +#define DRM_AMDGPU_GEM_SVM        0x1a
> >>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>> @@ -79,6 +80,7 @@ extern "C" {
> >>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> >>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> >>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> >>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
> >>>     /**
> >>>    * DOC: memory domains
> >>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
> >>>       __u64 matrix[12];
> >>>   };
> >>>   +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
> >>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
> >>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
> >>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
> >>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
> >>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
> >>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
> >>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
> >>> +
> >>> +#define AMDGPU_SVM_OP_SET_ATTR        0
> >>> +#define AMDGPU_SVM_OP_GET_ATTR        1
> >>> +
> >>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
> >>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
> >>
> >> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
> >>
> >>> +#define AMDGPU_SVM_ATTR_ACCESS            2
> >>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
> >>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
> >>
> >> Why are those separate attributes? What is the difference between those?
> > 
> > Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
> > 
> > So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
> > it can not migrate, GPU only can access it in the initial place.
> 
> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
> 
> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
> 
> >>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
> >>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
> >>
> >> Why is that separated into set and clear flags?
> > 
> > This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
> 
> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
> 
> As far as I can see just a SET_FLAGS should be sufficient.
> 
> >>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
> >>> +
> >>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
> >>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
> >>
> >> No location for device local memory?
> > 
> > Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.

I have no stake in AMD’s uAPI, but I can at least explain how Xe’s uAPI
works here—and admittedly, it’s somewhat goofy.

0 == device-local memory, with first-touch placement on whichever
device/tile touches the memory first

-1 == system memory

≥ 0 == a render-node FD (which could refer to a local or remote device),
paired with a region instance to extract the pgmap for the desired
placement

I believe the reason this isn’t fully FD-based is that the compute UMD
team wasn’t keen on exporting every pgmap as an FD, though that was
something that had been considered.

> 
> Absolute clear NAK for that approach. This interface is per FD!
> 
> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
> 
> We also need to make sure that setting attributes for different devices doesn't affect each other.

We landed on the conclusion that it is undefined behavior if different
render FDs—or more specifically, VMs across devices within the same SVM
address space—set different madvise attributes. I believe this was at
Sima's suggestion.

From the UMD point of view, every madvise call therefore becomes:

for_each_fd_vm
	set_madvise_attributes

This choice was made to keep madvise attributes local to the per-device
VM structure, rather than introducing some form of cross-device shared
storage.

A misbehaving user can absolutely shoot themselves in the foot, but at
worst this only ends up corrupting behavior within their own process
shared across devices.

Matt

> 
> Regards,
> Christian.
> 
> > 
> >>
> >>> +
> >>> +struct drm_amdgpu_svm_attribute {
> >>> +    __u32 type;
> >>> +    __u32 value;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_gem_svm {
> >>> +    __u64 start_addr;
> >>> +    __u64 size;
> >>> +    __u32 operation;
> >>> +    __u32 nattr;
> >>> +    __u64 attrs_ptr;
> >>> +};
> >>
> >> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
> >>
> >> And we usually use unions in this header to separate the input from the output parameters.
> > 
> > Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
> > 
> > Regards,
> > Honglei
> > 
> >>
> >> Regards,
> >> Christian.
> >>
> >>> +
> >>>   #if defined(__cplusplus)
> >>>   }
> >>>   #endif
> >>
> > 
> 
