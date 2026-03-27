Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36515F532CC
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B43410E335;
	Fri, 27 Mar 2026 04:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P0xYAuwF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FFB10E335;
 Fri, 27 Mar 2026 04:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774586026; x=1806122026;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AUajeTCVNOrEiJmGjEmi2+MF89sFuymVccP4/y1XTbs=;
 b=P0xYAuwFcYedNTRcyaCm96rDGp0/1vsYZTDpK1DD8jWIwQm3iXewiHHS
 vap1w2nv1+ALEsXfPh2Uiqfiloa6rGX5AExjv0IFMypxOrfuHwehf/QY2
 4H+W81NNq3ovE4ic9LbfFi3MeDURHZRBE+zRQMTe0kXvbGapcoqgssVR9
 pgZMIMl2J8CCNVa5xM0EwxZSSIFPrRniaN9gGku+VJux8Wsq396oNcel+
 HNMAUH3saQr3WLXf3v8OQU8BRIFWUlb5Q8WEFR6haRQIH32/wZBnqR8uY
 f0KDPJ6MJZvqkbs1czoERyJaw1/7DtPaZRpPyFHWMvs+O8N5JAwn0Z3jb Q==;
X-CSE-ConnectionGUID: YMFjEKYhQWCGsa9PRyGtag==
X-CSE-MsgGUID: AErnZFuJQSmEmzsfj3z5SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74839363"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74839363"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:33:45 -0700
X-CSE-ConnectionGUID: guv8PcOYRQCLoRi+LfeaiA==
X-CSE-MsgGUID: 7oVM1HoxSqiY61IgmFi/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="220803781"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:33:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:33:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:33:44 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ/FnOxu8PIuOMRfn3V6LdqOyeoIpNS7KdS8vWcYVWPaRG9jEW6Am7D83SQqdaUwEP4iE9dKpy1VcoBzzP6RTilyu4qoA4kYTaYqyhoghNydHHEwGWys56zIC/G37UYCZRzwN3x/584/ptQNN529EoViX62ihHLR6p+WMsyQ9bM4WIFbQaf3NYXGqOrif8vL+VarxOjNm+V4SDO66nYH9rY4r8LqQJJDfzJuVZ0Am+RY3sQ3tprxGicQ8Q1B26xAPJXEYZAOnNxs9jSzizmiknPDEdlz0yDlvkNGLXwWN2vmB55/kGPLxLxq2ACJbciBQVfAewhvgZa6cIRWreu57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMril7JXRGbtSF+eL6bVjadoupLvGeysrEMv6ePu+A=;
 b=LLxd0ZyadL0I6iWnH1WjQC8j18mvdMocYB6Tc0hCHVtifnPWxcWt4ULetribJ3Hw7LYBxC6gjEnzZiQ0DKMy7coxBhMAfLPH7pmWN0c7A4KSrQ7kB+Zm2whbJImQqUoyttj/f3rN9X+YWE+sDuX2x/c+/un9SLT9+JMIQY/cqEz+fKR9HPZ7fZscCcBv0jwcSyJyfHduWZ0PfK3aivZurzignjWv5g8WOsUnKfh/KNUK4BhY24mTTQvvQi6swPwT0Yp1Y3QDWFBFOlTsf2XJ4Sgmpl5Axq60EjrS+K9mz7ORTZyRDtx2K+IoR+EXzCiDhjP2T894dqJ8D13bAMRDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6519.namprd11.prod.outlook.com (2603:10b6:8:d1::5) by
 CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 04:33:42 +0000
Received: from DS0PR11MB6519.namprd11.prod.outlook.com
 ([fe80::c336:8ed1:4b09:4414]) by DS0PR11MB6519.namprd11.prod.outlook.com
 ([fe80::c336:8ed1:4b09:4414%3]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 04:33:42 +0000
Date: Thu, 26 Mar 2026 21:33:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to
 warn on reclaim violations
Message-ID: <acYIo0570M0Ndhp9@gsse-cloud1.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-2-matthew.brost@intel.com>
 <acQGehvhyfU5j6uL@slm.duckdns.org> <acSQxyclGs7FYvbS@gsse-cloud1>
 <acSXwPliraMdYTFH@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acSXwPliraMdYTFH@slm.duckdns.org>
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DS0PR11MB6519.namprd11.prod.outlook.com
 (2603:10b6:8:d1::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6519:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e6523c-63f5-42c7-40bd-08de8bba067f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6aIeHHPhU0bv6IRrJezJ2yx9Fim94Uy2VBxJ1ZF5F0njxRNNi44pGwRYuCE9WhWC80fCvJAs/6aV/BddC9ITHX2UZkBdeKGrBR2SjYr9Qp6tJBFKcXBycBpTj/NvI42YwwFZztekOIuuOzYxYmTE8YN3y6ia6qot1GhI0FzUT5fn+LUjTeSIpxYYOdYlyy0Nt/zq+DWMR/d3Wc9MfoWHEcRl68jgLOsAMr3E+XATpAcChXL4M/OrIyozq020P0DGANV21ZUwMWEM7DhwqRjsh2YhJDbyazKxfhSb2zsBb8qThlEvjb3GNZ3pjQtQpkK3DsbffXXoqVwadKuMUK//NBibTqDJwo2swi3t3nOiFhhz3L7hhkCBc12pwL89aK/Q2pzSWHFQhfR7PPYaFyUpHgnzkg60evd2nxqqeHUkQXe//KURk7L8IrFEgYv2L2PZdACXw6zEkc6zDZtFBRERaD/W2XLqq9l7/iOixAcIuBfq9ij9BeM3NtpUbPTysW3Tuua8QSsXHatZhLnUKeLgLHkjp2FlPwvNUjofSP2HGwcMwk5JdbURQRspVVA1cKHQgZIeIwvDfeGIJQai6T44I//QJQ7w9szOvZVhdwiVwak9uPTmTGi6AGplMGSQpBM8lKKhNio8Xhy7hK2FRzANwThUfsgcuQwVXpKY1ou3UqWbkdeBy4w+nmVGOwYmkoB41adtBKBOO551KdKwS3Od9v3OWe27aNc61JMsuWR9FzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6519.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURxaEtWTXk1dFlrSnpQR3dHRXNTSDJyeVU0eXRyNnlBbmpYZ3E2aWZ2NFF6?=
 =?utf-8?B?cW1HeFB5OWtkQzN5QWU5TE5rdWo0RzBheEdFOWk4SUNPOUsvRFlaUmtIQ1NK?=
 =?utf-8?B?OTE3bHBVSzJkNnk0WDQyczdmSXVuMkpLVUc5NWRMVGpWdUFvUElxMHpzVDFn?=
 =?utf-8?B?bkxFeDNCc2Nsdy90MVVLcHhWbEFwamdyVVc3TnM0Rk9DWlRyZ0tLb1dQYjhK?=
 =?utf-8?B?dENjMEx6ejlpUWlBNFZyWEoxaFcxZ2JCSy9FOXBLUkgvWWliejRLd0hWT1RL?=
 =?utf-8?B?eTBVVHpPT1l2YVhtcnp5bVNsVVBmVVBNRG15TVpaZGZrNzZmZUdnL05TWGlQ?=
 =?utf-8?B?WXhpV2tmckIzTkdnWjZNSmthMWt4eUF3Yk1sUlNIeC9RbVQzSlh0c1dUUThM?=
 =?utf-8?B?MGh2blk4Y2M0S2orUTdQenRrMjE1RmJQNTR6YzZKZUJHYzRoalBobnoxRitD?=
 =?utf-8?B?ZE01OHREQVYrblFtT3dHbE9JVTNlMU9YTERaYllCeStTVGhnTlJHdWZ5dFdU?=
 =?utf-8?B?bDkzNHNHUktlVHFtRTJZNVJHQ2hhUlg5TE5aeVlsdmRYeWhOUDg5RFM2bllv?=
 =?utf-8?B?dmFUWDZhWExvdnZ5TzNnMVBmeE5ia0IxMjRTbkJhR3ZqL05IR29wbWg5bUVP?=
 =?utf-8?B?enU2dlhibHFMQlJpUVRkZG1MdkNGZHlwbW5nVjhHYnBIMnByN0ZRMUZqOTE0?=
 =?utf-8?B?NDZvcUU5dnYrelZqdUprcFhyUC9kbUUvMWxnMytmS0NXcEF2SlR4QmYyNTBi?=
 =?utf-8?B?R0lJaGxqTHZSaHFWN2F4TTBOZ0dKMFRtUmRIQ2VwU2NqY2R5YmplUkxidHlk?=
 =?utf-8?B?N2FxYXZkTldqcmhuRlhScS9CbUhlU3RURGRUdTJpZXF3Q1FaNnZFTE9CZ1pV?=
 =?utf-8?B?ekpMTlhMQjRDQjlYb2syWXMveGowTlduQi81VTZSalZwV1pnNkJDMWxJOGpJ?=
 =?utf-8?B?Nmg0bEZSSWxLVkFVOEo1eTV4N25GQjhtVVhhaTVDKzNVMDJlRGFYRzVwZ0J2?=
 =?utf-8?B?U1dLOG5kT1FJcE8zZXNnaE1HVjFvWmdzSEtFTzh3SjhrdHBDaDR4Q3FkK2s5?=
 =?utf-8?B?ZTRsZVpoZXlocXdIdzdQVi9HdmF5dUhpeHRXYVpGa1dpci9SYytMaHY1TWky?=
 =?utf-8?B?YlUzSmtkQmhONTA0eGFFbU5kd0E0SEc2KzFWdmh4clhoZURiU09BOEhWQWtu?=
 =?utf-8?B?UlJTMGdkMnBlUHZBdCtXdDRPK0RCOWNYSHRkNUpadVpNOHZRWW9oR3ZNaWVU?=
 =?utf-8?B?MXFLN1laRHVBWjNhRndNaUl4azgxMllKRGZZZXEzSnNwbnROV0ZvWUdHQUU5?=
 =?utf-8?B?dHNYT1o5czBLMDRJVkRQT1FmUXN0YVRocUg0YjI1dm5EKzFBMkE5aTBxbDJK?=
 =?utf-8?B?MkFnMUZaNUdDRjJsVlUvNFhNSnFkcStZSXYxd0tDbHdoU2NPSmV4Q20rb0JL?=
 =?utf-8?B?UlU3dDM4RWVhS0pmQUhMYkc5OVVxSE93OHRiY2RPQzFNbnROSmlWQnhOVXMv?=
 =?utf-8?B?YnNpekM4aEt0ajQ2aGNGVTBrK05KcExhM3lXVXphdS9KVXRObzFJcFpQVEl3?=
 =?utf-8?B?SVhpSDZ3UWNrVTYvVDNEOFg1MVZUWEpRTU0za05abE9rTjM1T1pqeHYvTlVs?=
 =?utf-8?B?amw1L2VZTFlxT09FWlcvMThUaVkyZmxER2FHSHBLZFZKTkx6L294Z1ZubnNJ?=
 =?utf-8?B?Yy83eE5wTnhPZW9ubzZlQUtWQTIxVDBISjBZSE5TU1grMWZQWkc2bVduY1U0?=
 =?utf-8?B?RTA4WTFUQzhhZUdFUFo0Y0VBYkVhMERYNnJjVjRncVJDTHFjdVRtVVZiRFJT?=
 =?utf-8?B?bHhBOGRqMWNFV2dTMnJKeDBsa1hkaW83bGxaQzBHaWM3OUxVTFgxN0FjWUh1?=
 =?utf-8?B?VU9PYzI0VDVINGpHQWN4SUhENERaSVJLeWpzUXRUTmUyQk5NRys3OVdSbFRU?=
 =?utf-8?B?QldxUENTSGgxd09FZnJ4UEl2NWRsSUN2SGpwdmptVVhQL0VCbFlBbFRDWEdF?=
 =?utf-8?B?ZXhMdWFTL2pIWHFRYVZmRnNBT3habFBJdC9aaVRvOEJUN0V5K2JZbzJUelQ0?=
 =?utf-8?B?ay84d2crTG9HRlZnMCtqcGpEcW90czlibTZScXcrdDBvOTNudEhDVXVDUEI3?=
 =?utf-8?B?Q0pyTmpwemwvWXJ2U3ZBbFgyYkdwY2xUN0J1YUttckpWdmlYWHZqQ1hPS0tR?=
 =?utf-8?B?MittUnBNOUgxUllKdURhd2g0NXdUMHYxVEFkVFdldlFVcklyUHIzdHcrTzJ2?=
 =?utf-8?B?S0xha3huckQ4OGJnbFhJZHkzZWdJTEtHUUJ0N2JGLzhHNk96YmVaNXRBSTFa?=
 =?utf-8?B?Y3ZDVUtqdnVUdko0cm1NWksycUx5YmhsUUNmaWtXQ2FuSVU4N1VCdE5mSXJy?=
 =?utf-8?Q?XyHOpP8hq2GyDuZw=3D?=
X-Exchange-RoutingPolicyChecked: XCT4BFegM5M4+tSJViy8i5gvGQS84tUPCZ1qsvRUSrl2UyBtznDr+iOujN2DUUOd2FLY6oaOsu65efJIHlMJqzX+BaxLAXj1uaFFLJiaaafzt/Q66Cokv6JgNDfLMX5ofOtJObrQ9pJMwApLfH4Xca++Qpx36T5ml+qgX8Wrrc8ic1cOMhOaZNg7jktfZRP/Owr0DDYR8xzwgcX7LpPMjBoWXJvbWH0IbRYanZbsnPgdvhLzRgWW2J/1c/3ZuApj9rVicEo6KwEdZjYWlfmIhtTgQ33zLZe0B78+1qt6b9tT+VhJdNb+ahfpjAM2aahaHZfetZmi3VsLtpaPRWNrxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e6523c-63f5-42c7-40bd-08de8bba067f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6519.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:33:42.3716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBJRT0YDUE/s7OjzwumWCr22WREvQ5qZRbBoO6c+13YoerrgomOCPDb++eUq/zBY+Nzpb5SNyNwVUG8yE7SUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
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

On Wed, Mar 25, 2026 at 04:19:44PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 25, 2026 at 06:49:59PM -0700, Matthew Brost wrote:
> > On Wed, Mar 25, 2026 at 05:59:54AM -1000, Tejun Heo wrote:
> > > Sorry about the tardiness. Traveling during spring break. Getting more than
> > > I can catch up with each day.
> > > 
> > > On Sun, Mar 15, 2026 at 09:32:44PM -0700, Matthew Brost wrote:
> > > > @@ -403,6 +403,7 @@ enum wq_flags {
> > > >  	 */
> > > >  	WQ_POWER_EFFICIENT	= 1 << 7,
> > > >  	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
> > > > +	WQ_MEM_WARN_ON_RECLAIM	= 1 << 9, /* teach lockdep to warn on reclaim */
> > > 
> > > Shouldn't this require WQ_MEM_RECLAIM?
> > 
> > Yes, so what is suggestion here? If WQ_MEM_WARN_ON_RECLAIM is set
> > without WQ_MEM_RECLAIM fail the WQ creation with -EINVAL?
> 
> Yes.
> 
> > > Why is this function necessary? It feels rather odd to use wq as the source
> > > of this information. Shouldn't that be an innate knowledge of the code
> > > that's using this?
> > 
> > This, for example, would be used in DRM sched (the existing scheduler)
> > or DRM dep (the proposed replacement) to ensure that driver-allocated
> > WQs passed into the layers are created with these flags. DRM sched or
> > DRM dep has strict DMA-fencing, thus reclaim rule that we expect DRM
> > drivers to follow. Historically, DRM drivers have broken these rules
> > quite often, and we no longer want to give them the opportunity to do
> > so—lockdep should enforce them.
> 
> I see. Yeah, that makes sense. Please feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> Please let me know how you wanna route the patch.
> 

Can I send an independent patch addressing the WQ_MEM_WARN_ON_RECLAIM
usage above for you to pull into 7.01? I’m still working through a few
issues on my driver (Xe) side to enable this, and the larger DRM-level
changes will take some time since pretty much every driver is doing
something wrong.

Alternatively, we could defer this to 7.02 and merge it through DRM,
since the 7.01 DRM cycle is closing today. Either option works for me.

Matt

> Thanks.
> 
> -- 
> tejun
