Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22914FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 02:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA1B10E0CB;
	Thu, 30 Apr 2026 02:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fIrAVVEE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66B010E033;
 Thu, 30 Apr 2026 02:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777517256; x=1809053256;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=tFU/hJntKXI9KnsMKwSFcMJTtXst1B4Xhp1oWfh4/bc=;
 b=fIrAVVEEst6RrB4hWbESQDWLFycHole3XYc+xrKsh4fDV2lna2Og0S+E
 mpQPzmdfaVngYbUhWl7BXTay3H+RQrh3OmZ4A7OxwW9vbyIcLK61Ow9w7
 xaDsv31+cZX9UZUJbMVBcJHzjLKnaKthQBJWZGgaSPPkY0Il/l8rhTJXD
 Y3rqcI1WzmM8oaWCOflpBJANz9TKeDOI/FighzDvTaKbt7TJNDA0oXYyB
 iOalmRU53m9Ps9EzoNVmQ8+1B0wQCFAYU+kS4Ws/HgDkiGSKACRK0Rt36
 CekI5eTfyTV3MgZPHvFjQAB/6H79SZSMDMiNZly6lzAf81xkGpcdPW4j+ A==;
X-CSE-ConnectionGUID: evfypl0qRBGzPiEjcxOzow==
X-CSE-MsgGUID: +PsnFLBTS3Wkqx9R90auFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65990633"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="65990633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 19:47:35 -0700
X-CSE-ConnectionGUID: 4t16rsTUSQemVSWwdM8BZQ==
X-CSE-MsgGUID: F03le5cAQveHjRh8d64dsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234476451"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 19:47:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:47:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 19:47:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoIPgH/G9BqSIh9KmoRppYSHFnicjYRrgwOQJJfX5Q17al+UMiYAhHOdheUzsJ7SB1ypxGZ+HZpZCExmw6Lrge+eUYc+ECKxnDwFEMiXBL2f+D2X0Z+KCq3YIlZmYmw0STxbDpPttw8AmTx32wwqi+smBc5/fR8D4bbPO4MKMEj5TRFvZG6/8DeSQWBLWvoDRvzIKGAf9bqpPo/Jw2JkzBXWQhXOh4Sg0dDtokMYKCfUYD4dLwiytcI7swR5iDXGjH4/8DjyAoXKCvYsQIngFuQBE4gCZfFw7jUqy5GpbR2htoi4iyx/9/D2R0Agm0ruDeZOLg8+nPP00dDCiITu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0nWRCv5scTO0uQp6D9y4bPHdpfcsOeruQ8/pt//SA8=;
 b=humUskNbSRExeYEiszMI/Ktiy+jac9d1aEqY1qRKwszrsWbzSQPIPX01kWVZKFQEhMPGV12CkJk1nPC1obAciDZY2QXxYeimN2NdbEUv4oIrWDFVwwc95zEL7KI9ZdWW/aQWmWXrw+ziwO6lTWL3pnDaBmGr6G8oxyAcNyvf5fcOId/6460OFl7adM8PfNYca7CFo3sYqNazXi4W8AvIpFLtuq12r8IsyP6az7FlOfyRCAC8Rouoza9iPRWhHmW31G+7QdNOAlFeuSuXJ1uwGP9XMw17bc5Ypdh67WRtThrNgBoxGrPS43Z85PooZZbsRXTiDWy4Wn/VlQXDd/eOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 02:47:31 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 02:47:31 +0000
Date: Wed, 29 Apr 2026 19:47:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <afLCwHaPZMu/dxqY@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
 <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
 <aepuNL2fwp47P1Wi@gsse-cloud1.jf.intel.com>
 <aeqbe/9YRKNyYuWY@gsse-cloud1.jf.intel.com>
 <291406b26b8badf2e565996515931d9ebe50208f.camel@linux.intel.com>
 <a1252167-63a1-481b-9f1d-2a7bae7a3b6c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1252167-63a1-481b-9f1d-2a7bae7a3b6c@kernel.org>
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 913898ea-858e-4a10-fe31-08dea662d338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TV+a8jYS9yPjn+ufjV4MZqakuYI79ktClF7rMSgSXx9K6jYf54q74/6vcsiGcm9FBiM4Xf/jLlqRL9dLCAu+CzWSRIJxQhOAWYEPFzJeRVdtJJkFxj5oYjVUby0tp5SWHV9jGVhaKYE9kpul4rA7mW6z3rWVfj7Lc5wfzt/J013UuBOsstcFYrz9SV9ILlVNaB42YCi6BDozMCwBbZxAz6DZj+3o00r9Rc7YMgQ3ekjnj0fCHFKBMNoYStDU1rPLqZl05WaUC2a5oJ1sfFMTJIt88sBN8Z4aWpUr4NuMBg271VFidZqbsDW2J7i9vtdV04EnJAMm/YWcA1RxAoCYoktgnBI+3FJeT0wYYWvdJJhF6pXXANTa6N6NDdg+wZq6FB4cWHYkUve+D+M67rVvha8hFyHiO/bkGU+EYMG4hlDru7JExAL8MSKg1E/KIn0qy9tF19BBbuduujmkLiCqlsK0UzfIwPuu7HyjOzglOoKZkfFnSuAyl+sq8Oxhm6N5sVPQnkEUYd0MPkOAQJFQvxlT9gvbJ0WdGfXeF77FDipD8lAsgs+rKt7vPf17XC+syBXMj2mesv327X+HcRlYQBpu1dW6aPgPtdwidMKB2vcNM0dI9Gg4sChho7RD9I5dZxn1WyPdTxbVDOB8POPXgAxyBa4FyKFgwW3+DfHW5eBIHmWzSX2UlM2MVEMpRFcH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhzT3VyRmdsYnlXbkdKWSs1NnhYN0pmTFZKdUFyYnoxYXFGK3RrSmtja3or?=
 =?utf-8?B?YzhUcVdHS1NJRzBuWUdySVJPeEtWV3RtdS9obVk3b2RsazFoWmtVV3praEFT?=
 =?utf-8?B?SnVhcWpDNWVDWGlZRkNMNWttWmZxeE9taHovWDd0SHhjYVJPbTZpQU94aXd6?=
 =?utf-8?B?dFo0UVUvbkk0MXZ4THNYRVVyQk5JQ2JvVlB3Szlud2kxSlQ3RkZRVnQ3Sk9D?=
 =?utf-8?B?K2VjbTZLaGZMeW90TmhIOXlHbFpuNmowNXRENWxxZEc1MSszMWcwdStBQngr?=
 =?utf-8?B?emxFdWZpc0tNUUlzeUhreHlDOW5aMmhCdkdrTGJBeEg2QmhWT0ZuVW9JRkNT?=
 =?utf-8?B?VUFUUy8xNW4rQ2NHamVGblMzM1BRdW1QNDN1N3V0dHJvamhMV1B0U0JmaWE5?=
 =?utf-8?B?R04yQ1UzYzNlWTJiTlhkNmFhZ3p1U1plNEMxdVpTYnI4RnROck4vSXlUbFVa?=
 =?utf-8?B?d0xoWFRiOGU3a2NueGRKZTFZNkllcndKN1lDUG90eXF1T3IvWllTeWg0djNP?=
 =?utf-8?B?YUJyNzdnRGF2cGJ4TU94ZkQ5a094c283VzhrUVFtRGEzaklmOW5nbXBtSXVU?=
 =?utf-8?B?ejRKWlhrNDZtUVEvcGEwS3VuV0FRNTFFNk9lbC9zWDIzazJnazkzNWM1REhp?=
 =?utf-8?B?K0pneFpFdlhiVllpUWRmVytyaDd4Y2VGR3IvcVMxRzVpUHRLTW5RQUhzakVJ?=
 =?utf-8?B?NUl1TnR1NjdSQ0NYL2NWZXZCNG9tQ2VJNTFNREtiTEN0elNjelNVZGR2QXJN?=
 =?utf-8?B?d093OGdxSXgxUDJldHV1NUNqMmJQMjE4UkxKaDJzOWplUElkdWhUN2NFT0lE?=
 =?utf-8?B?RmtSMHNKV1BWWk9XMklKQzZWcHY0djdXV2lsL0J2NElvUHRBSmxhRk9oUFB4?=
 =?utf-8?B?NmRCSTdHSlZKUHQ1WHVYQnRJamt0SHlIZHRUakJuSXRpU1BiWld4aVlIRXAr?=
 =?utf-8?B?NnF1bWRmcXd1TkxIbVJXcktsN2NuQmN1bnpzUnN5WFIwdzJWK0k4YXVHeWUx?=
 =?utf-8?B?ZlJiVWI5Qk5NanFtdFE3YXBtV0tDR3NaemI2RnMrTEFWT0dxUFJjWklEd2M3?=
 =?utf-8?B?V0tLdkdPQ2R0cUQxRTFwNVBJQ0lKSmR4Um1rUFVVN1c4MEhDZEFhTFV0UHFz?=
 =?utf-8?B?ZUJJaENVbE8yZ2NCUVNtc3BPRytqSXRCaDBBR2gza0VxOUxXRWtkdGpMVUpq?=
 =?utf-8?B?OERSZVJsTks0OE0yUkppME44c3REamt6SDIwWGp4cEwyOTBuYVlYcUhYWE9D?=
 =?utf-8?B?MFMwYlNZRUZzaTFyNkVXWVR5bDY1NTRMM2NvVHVYWXZHTXFBbmw1MkVBVXFl?=
 =?utf-8?B?MG9yb1cwRE9icWR3Q3VhVTVnS3Jxd2lONUNFUVJxNmdJOWtVSXRMZVEwZXhK?=
 =?utf-8?B?TitmK0RXV3dqVzFCWXhRYStkcStvMGNaOHFMNFdGRU1JMUsrbjJ1WVBNaEhH?=
 =?utf-8?B?YWxDSk1uVnpWVERjSjdKUERRR0UwSC9ici8zOU9OYmRUNGxhMzlGbWQzZ3Bz?=
 =?utf-8?B?dzl2V1pNcTd4TFF6dzhSM1ZZODQ4V3R5QnE0RjczVkpscUZ1ckxSak5iUWhy?=
 =?utf-8?B?Rm42MElBbUt0N3lzdVI4ckRjb3RKZUZ0TDNOblgrcVcwSFFTRTVtWWtOdVNx?=
 =?utf-8?B?Q2d0WHFiZjZTRENEVlhHT1RzL2JZd2dmd0FWK3dVTGJEa0ZWYjZIS2NkL3RT?=
 =?utf-8?B?Qk96aVdmeitjQlZKRDg5K3BiQXFNOG1tSGt6Q214ME9qWVdDc0F6Wll2czVX?=
 =?utf-8?B?dEtPN294L0ZNU2ZrYk5nS29sdS9YVlJkRkJoNEViNFJGdHhURUNKTElYWTc0?=
 =?utf-8?B?SjgwbjlYcFVxZW9lZksreUlqQWRhWHB2aTNEcXNrRmlCZUVpV0FlUlNHRU1j?=
 =?utf-8?B?TjlkaHl2N1pCZmtLS3lqcXlWa2ZSSnMvb3pBMm42RWx3RGNZd3JwZDBLWEhm?=
 =?utf-8?B?ZHdpK213MWVjc0FtOU4rZUJ4NU82bktBUHB2aW5pcVp2dTF6RWVleFJnOWVC?=
 =?utf-8?B?dmpYbHBEWEF1czRITUk1dEd4WjloQWV1aUk5cmczaWNvS2prWTZzWFlNTWJS?=
 =?utf-8?B?QVNnSjVEZ0Jxa2xZTDZvZUxabGE0OVFvUUVLM2l1d0Y5dWY3UVA0TFRQcUdr?=
 =?utf-8?B?c2pnaUpoVzVQQUE5di85TnpDL1lPcW9QZFpXYUlUSTBJNGdzSGorWTdUYklO?=
 =?utf-8?B?YVYyZEJPYW5jUWtqNklRRm9EK3NEQ0JTTEFpTVg3Yzc4NHVIa0xVcFpPUE5u?=
 =?utf-8?B?RGhXaEJZbzJQMEpibTMrLzBsaDcxbXNOVXZvRDNOd0FxVFFTUXh3dzYrcE9s?=
 =?utf-8?B?Q1N1Zk5heFBBZHNueDVsNXdzUDZGdnRJYU5xUVRFTkRWRkhnZUJ5QT09?=
X-Exchange-RoutingPolicyChecked: JREQ91cVNFVn/iMXiGAuaMoWpnNkccQSaEOB4LyRdYXyWc8yqIV2LrK/1uSDEkOg+8Rde7bHKMbZYMkE5JEJCArlJdUh89KyNs53mkGx15b+TxVO0Iz+eQ/pCO1l40GH7n5FZqH36MrzKNgHgqyUZ8tmutEzca/EJoJGHYdHV6H6mR7BDo+r2LotaBwazhBUwpC8AZtL7HturkshDEkjUtjeIehlfYv0xFf18H0qdVKSXi4Unu9qoG/LZeukoBk9Na0rkzvLYxvDErqfuxIKjdn12nGSIFA5m8Lv/2qev52EsvEqBVwIk1WJfvre65UDkxKcb5JZ87NiFs1aiFDzZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 913898ea-858e-4a10-fe31-08dea662d338
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:47:31.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YI+Z0ZK+tJsq+uKZd39zCokURFY+YF7qImaLNcy4XOb985Gi5lF/uXnUohsX785JrC4Vx5p1cJ+o8Glgruttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
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

On Fri, Apr 24, 2026 at 09:26:18AM +0200, David Hildenbrand (Arm) wrote:
> On 4/24/26 09:05, Thomas Hellström wrote:
> > On Thu, 2026-04-23 at 15:21 -0700, Matthew Brost wrote:
> >> On Thu, Apr 23, 2026 at 12:08:36PM -0700, Matthew Brost wrote:
> >>>
> >>> If the order were included in shrink_control, there is about a 95%
> >>> certain that this change would allow TTM / Xe to break the
> >>> problematic
> >>> kswapd feedback loop. This may also better express the intent of
> >>> the
> >>> problem we are trying to fix here.
> >>>
> >>> For reference, the cover letter [1] details the problem.
> >>>
> >>> Any guidance from the core MM folks would be appreciated—would
> >>> adding
> >>> the order to shrink_control be an acceptable solution?
> >>>
> >>> Matt
> >>>
> >>> [1] https://patchwork.freedesktop.org/series/165330/
> >>>
> >>
> >> It doesn't look like __GFP_NORETRY, __GFP_RETRY_MAYFAIL, __GFP_NOFAIL
> >> make it to the sc->gfp_mask flags from the caller and get into kswapd
> >> loop...
> > 
> > Perhaps that's because they mostly (only?) make sense from direct
> > reclaim? Looks like the trace is from kswapd.
> 
> kswap obtains the desired order through pgdat->kswapd_order, as a hint from
> allocation code (wakeup_kswapd). The order can be easily merged (just use the max)
> 

Yes.

My current thinking is wire the order into shrink_control as that is
quite straight forward + only call this helper + short circuit shrinker
on higher orders.

> We do have the gfp_flags there, but merging them from different wakeups is a bit
> more tricky (and when to reset?).
> 
> Assume we have one urgent request for order-0 and one non-urgent
> (noretry,nofail, ...) request for order-9, we'd have to figure out a way how to
> represent that. Gets more complicated for more orders.
> 
> Of course, we could have some kind of array, and try to store some "priority"
> per order. But I assume plumbing that into the rest of kswapd might not be that
> easy.

Yes, this seems non-trivial. I was also on a call with Google today
discussing what Android (client Linux) would like from shrinking, and my
initial feeling is that we will need to do some surgery to the shrinker
core and GPU shrinkers to make all of this work well over the next year
or so.

So again, I think starting with wiring order into shrink_control and
this helper is a good place to start, as it fixes an immediate issue.

Let me know if that seems like a reasonable direction.

Matt

> 
> 
> -- 
> Cheers,
> 
> David
