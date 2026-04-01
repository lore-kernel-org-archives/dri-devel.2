Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03F61076368
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D07910EBF2;
	Wed,  1 Apr 2026 04:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SA7Xl972";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440C010EBF2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 04:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775019445; x=1806555445;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WoCfxz8luOOEePW5fvffoPn4BDvdWutK1eit50o4KSY=;
 b=SA7Xl9729ogOk4EPIEhO3mVtn9SHhHg3znlfyT3PWRF2h3J4gP05fs04
 49oM2BFlOX0Z10oz3hy2c2zgRMudubipGn7EOmoTyaivB+Kp3lDX7zjch
 2P/rQDQN8Z0nzvnLiIp/E7PBudlSoO+woNa2f/3cRez0jwMzo1YccYF4v
 6CIbxya9Key3GmqXlXnim8L2g9RxC4gUCyvQw9bt2ocgfZEsM6UEuUVAP
 70tDYVkjhs/6Qo1fwHVihiAuRlPG1KM8ZhVb8dkXtspY6nvBLzjLI1PcC
 lYUvgUDLQ+tO+2jhvNRvwLaGfBcoi6W2Zluga/cN+x5wFGNPwL5WYGoAe Q==;
X-CSE-ConnectionGUID: KDNOfyFuQqWZOAE2T3VRcA==
X-CSE-MsgGUID: df7QIVC4SVWcuysBuMPe/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76007579"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="76007579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 21:57:19 -0700
X-CSE-ConnectionGUID: zYz2IuHRRVeyIwiDxIsTQQ==
X-CSE-MsgGUID: uJ2Zj7pKTI+8Ge12mx1l4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="249608977"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 21:57:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 21:57:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 21:57:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 21:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS88dbYFLrfMIzBHzgZL8IFSdZp18bZ3pF7oivT9ofAAf80eoz1ZXdcrId/AnzrFeWYhVg4qKDqRPNi1rWMPcbRiMMS5HHA7MxkW2rT7a5Gc9ZAY6iDFpBaWxQ7PAu4oJaUiq6j4VRYmXwvzgHbh45Uh8o0pQXlX4d/mz7iLJFmvt9obIEBtkH3dbfMjTR4H5POFdzEbLjk5oZ/G0CttIMi5bBdVJz/XTL7eQ8T7+Cj7LvgUUdt4yOaYygYcWadV/S/vunxyoelnWJj0IFqEgRRrcV2mBosfOIUvHrLmTy0PwYc40s3QdqXMC5IPz5jwZg+6Ip9tnav6drSZSMw3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiSrZBMaMrECpo1dgaABsjTaNb3Un85GsgZTAmUkKDs=;
 b=H2IzjeS3dPGPEtMYf2hpntLyfzRPHYPl3JKsEZ9SIHTER8VGtEM/nPUu6e4j2DKcM85Dio8b3b5Ap2GuQVpgSRtaKFiFwDXITice+I9I+XStN/bylD96kf9s8ad7l20fOj1H24wqVs0dJRUs2O9EkUlFsXFe8r7jl5l7cJpSPyytL+CPJPXt0c2Ye6Tu4WHdO5ysUB3ED9q4Tcj2BaWYNbOl5oEf1gtuwErvuIom026gDV9VhQTGWKGbOii6oHJ3ZhLP2Q/8QMhDvRPToeIaZpY6qnVEUGSzXaaMWajYef2A+ERoX4us1cSIAyl0iy3OlcyqpSBZZYVGoXhR1+V4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DSWPR11MB9762.namprd11.prod.outlook.com (2603:10b6:8:354::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 04:57:16 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 04:57:16 +0000
Date: Tue, 31 Mar 2026 21:57:12 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>, Max Zhen <max.zhen@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
Subject: Re: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO
 mappings
Message-ID: <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
References: <20260331172635.3275296-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331172635.3275296-1-lizhi.hou@amd.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DSWPR11MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c96bc9-c9ea-4cc8-7fd9-08de8fab2534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ZhjOiqlkLqKqn96N9Mi8GbCFGrngFZCiwLTEhJPRQ5ZpQrZ3s4PPfYDP2NuotV2Sf31MvducAa8wR+X+Z+esX3oUkkUchgO6xqPm92bJyigmc0+TyZ820DNjMm4xiXY20ukEJcrvlxk/YCxxOaAi8VsDUNGWk01mTiU3L9RqXSZKEoTtEaEbGEViHd45DbvjUvzJ0BP9eeucNv6SquVXqmIzKEom+AmqtuaC3Z1oVRkROSu+E07q7dK3kgNIykAW9AdWm+F4n8mc4TnrHZJsAns2lN+QZclgszq6ye0uu7NjFCC7GjsI5TCwlkDm/0KbVr3F5SPpOrMX+PeGx4q4KxOwFwnZVN1TC9mk6Oby6RNnt6w1rUIbFiIjLFzkP/K6lGRPoBCKlJDswTrKTy+PiWB4VdBuzM4yzP+7mmF0JgtthZV7YLbhbQjSRzaM1da7wC+0AfxAnCRojykUBgBe4qwdR9KFrCLQ6pMakGEYz7IfQ0s/SYB2D6Wfvhh+vAkLQhAHfxgXeJ86sIRMrCOomDsobFf+S7OZEQlVtUflXKxMKKrELHk6mu68kRgt36rscT8CAgGBp5T+rqrkzW1sUIXVyHwWsssrIZMzYaELGlE6TsggtHWKqESQN9XrqV4UJgmBBkN/KOZMwaGIsEmwsrYtPGSYgp/IQplZ0nfrAntW7ZQEz/7uprFrBT3PXA0CwHyu9fIw0AOnYcyIgjQxfon3NTMba66XMk4O1jKSdok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RLU3RYeDliRmRpYkd5ellraUhIQ3hNM2NMYVFuSUlDT1Q5ck83QU9yRnBm?=
 =?utf-8?B?M3JHaUpDbk1rRmZYNVI3cDJlWjBjV25GcVZLODgrNHlrWVFZdHAzNmIycFpi?=
 =?utf-8?B?RlBuczEvb0dhTUFLK0VWTXpQTGJmQjBGU0pEd2ZzOFJXKzRYNTBkdGlWMUN5?=
 =?utf-8?B?S2d1OUdJTXFTY1FpVTBXUXJINzFoZHlVSCtWVGU3aTlBK0FxczBZZ1pwdXJV?=
 =?utf-8?B?bld1d2pHYjFIOWlqOG8yYnhBSmRpU0ZDTWRjV2t2dE83bkgrcHBzQmxqUjBX?=
 =?utf-8?B?aWZEdzdrVDdVQXBnSVVhUjB0RGY3OTlWaHhzTFhkNEY3RSt2YnVNYTlnNlh0?=
 =?utf-8?B?OXB3cEJ3ZjY5VlJsSmdmelJHU0hKTkNuU0dGOFJjMnZSNm1QSzFTa2VubnZV?=
 =?utf-8?B?RnpHUlJONEwvWVZUdDVZeHowWXI4UTNNUmdTRzFIdmVaR1ZIb05OdEdvam9I?=
 =?utf-8?B?bkx5YW5RUE45VFkwQ1hTMTVOckRqZjdKQ0puWGx6MUhUZzJoZm5XMXpoZDYr?=
 =?utf-8?B?RFF2RjZPRHJCdVNzMDNzakJqTUhlN2Z4UTJPcHVNRzJpS2hLc0tJSFBRRkxT?=
 =?utf-8?B?TDNxcVNXK0k3bDNKc3ZCcjFObjRBcGpPZFNHdWNGeEZPWUtyY01xTlRuZk5N?=
 =?utf-8?B?Nkk3bExmakVCdC9hK0drVFVXWFNlbWlLRG9nUENYWk9hUVM0TExjeVo5ekxk?=
 =?utf-8?B?RGRDZlgvejJrZkJOSk9DUEtGMUMvTFovYTMyUlRkbGtZaUpNL0l0bnZFWGRq?=
 =?utf-8?B?a1A5aCtHZ1lvM2x1Q2w1SlJ6NndEYThIMm80UE5SU1dkWjJmN1BUbngvcUpr?=
 =?utf-8?B?VytLRnh3N1lLV2o5cUVhaFEyWjNHbFI0UFpYNGxmd3UyU3JJLzBuY0o3ek5T?=
 =?utf-8?B?SndDMlFsVXBqbVpGQnllNm1VSlNvaEVFQ1dYODFhdVU2TWI2bkdGTk50eEw3?=
 =?utf-8?B?NmV0OC9oMGlHYmx2ZHFqcVR5RUluYUxWcjF0cCt2Y3dZdS85eExDYkNQc3dY?=
 =?utf-8?B?ZEd2WlBjWnRlZ3d2d0QvaW5LMVgwZmZxTU51a1FuQ2JWRU1CK2ZSZSs2Zk9s?=
 =?utf-8?B?V2Q2bDZaTDhsQ0pYWlhQczRjSTdSYmhoZnJXbS9oVzl0QjA5ZGxjRmxicmZi?=
 =?utf-8?B?UjdXaG14K2hGWUt6TUcwdGN2ZHRVU0RxVDVialdjRmlESUFkV2FGSlZtS2xF?=
 =?utf-8?B?YXVZNjJ3ZGNEZGpVWlZtUDBiSFU3NndRMXZjRENmc1hSN1MwQmFwVHNvN1FY?=
 =?utf-8?B?eWlXR1lJRDkza0paYStOSW5FRHA5cVFENWtMUWRVdFh4RVR2bTFwblUrdlBY?=
 =?utf-8?B?REYzbGdwQ09oKy8rVFpHWGJiRzhzbWswcWJZaHJHSmxNekhZcU5qWlRCN24x?=
 =?utf-8?B?cDNtdXl0WnBBdHhTZzRHNE1PVk9vdGpSc1N6anVvUXZzQjgyTjJyRjVnODVa?=
 =?utf-8?B?UERWeldIVmI3Z3MxeFRtaUVLcndkbVN0cW52RU56ZTVpSGN0dENaUmNrMm1v?=
 =?utf-8?B?Y3ZOeS9xYXdVYUFIckpWZnlNMkpEQjFQSzdMUStQRXFUMVhiYllBTlg4d080?=
 =?utf-8?B?VHZBeDJ6cU41WExkbEFDM25xQlQ3K0Z3R3FiWU5OMEdzQ2RDNm50TjZaSmJU?=
 =?utf-8?B?QlAyWXp0cTQwSW4rVW9aclc3ZHR2eFZWWllyR3ZZeWtOa0VUSmg5UHJWb0Jj?=
 =?utf-8?B?cThDSDJhMnpBeC8yRUhacDd2UmpsU09xV2xBZkFOamxyOG9qMER5RTl6MjR6?=
 =?utf-8?B?UTJMZnRoOEJwM1JxcytzRkFWa21FSWd2Wnl0ajVIeGcyRU5wRTVMUFFFZUhS?=
 =?utf-8?B?ZDBsMk90ZnhzMFBMRlpudXNUS2NpRHhmeE9xV3BsY1BaL3cybllma1NLOXNa?=
 =?utf-8?B?RGdReG93S1ZZbG5hajh4dm0vRjVEZEFhOG1MZlVVOHNOWG5SS0t4d0JGL3hJ?=
 =?utf-8?B?NVNtV3BvZmVQSHFUOTJZTGRuenQ5R0orSmx1d1VLR0tvWVoxNTlTbTRzNzZ1?=
 =?utf-8?B?ZDhJdVJ4TGlGV2xwN2gvVWVzcmZ6c3BVNVd0RXlUaFI1c1RpbXpSbFRkKzI0?=
 =?utf-8?B?cktjOWpsS0lkTDl2bGpXc0ZlN0M3TjhGa21kT0FhVkdHdWdlUkZ0bkFxYmZq?=
 =?utf-8?B?NlpmS2lxRFduR3BuVmsrQWxnT2hOa1ZpczYrZ0NMRzI0RTJ0aVZZUlk4ZlFD?=
 =?utf-8?B?MXBOSnFVbTk5c2I0bDgwRFlSLzZxM0pSWFVvMzNWbmo4TWNPRCtxVmNycHdS?=
 =?utf-8?B?K1pYMi9QZDNtaUhXVzZjRS8zWXpJR2xoVHBaait1ZDJSWTlUOFkyd2paT291?=
 =?utf-8?B?VXVyYVpGM3V4amw2SFdTUFlWYjlpMHhGREJFV29kSityYTAvVXNteWwrVURv?=
 =?utf-8?Q?0YT+oEyR4MU3vn7c=3D?=
X-Exchange-RoutingPolicyChecked: R8wOW8He02K9CZH7EdpyWUQz+rLjHzdmSEC05NPzkpvTfbSUAZzkAbX02YsI8ztw1eWloP7soifzF32jIxV4zYaTugs9ie/MMZ5FWkjaTYdBq57w5CHZb02xo8aBYIWvtU/vEf2uwV4uWTWXF+O5aUxRe/tai0vBRAo0YlcVb4tUi/vUQIYbm23osTwaeOY7P/GSJzk7pwe7Hzl607FTGLkBDr6fCy9TNpDdrPlkJQ3zzWV56LJVGiRbwzo5SnH2R/rLoO6+yk4VbHGGJLLSVz3Zvaf2gOr+PSPvU5iIBaLUinyBwT3TEh8KTlukrDJktRwkYZgq2xvfcInVgS8U0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c96bc9-c9ea-4cc8-7fd9-08de8fab2534
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 04:57:16.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixBQUorxxXlR8/k1hswOGW/SECxhvgKn+PxRft/4eMBxy9WBDJZp+Og2rOBVx/NKI20fLeYetI+ugAWXIn4T4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9762
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

On Tue, Mar 31, 2026 at 10:26:35AM -0700, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
> objects from read-only user mappings.
> 
> Detect read-only VMAs by checking VMA permissions across all user virtual
> address ranges associated with the BO. When all entries are read-only, pin
> user pages without FOLL_WRITE and export the resulting dmabuf as read-only
> (O_RDONLY).
> 
> This allows userptr BOs backed by read-only mappings to be safely imported
> and used without requiring write access, which was previously rejected due
> to unconditional FOLL_WRITE usage.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 4c0647057759..3769210c55cc 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>  	.vunmap = amdxdna_ubuf_vunmap,
>  };
>  
> +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_vma(mm, va_ent->vaddr);
> +	if (!vma ||
> +	    vma->vm_start > va_ent->vaddr ||
> +	    vma->vm_end - va_ent->vaddr < va_ent->len)
> +		ret = -ENOENT;
> +	else
> +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
> +
> +	mmap_read_unlock(mm);


This looks highly questionable. Drivers should be reaching into the core
MM to create primitives.

I also glanced at the userptr implementation here — it’s quite
questionable as well, especially regarding whether notifier locking /
hmm_range_fault interaction is needed on the driver side.

I’m fairly certain that, with a bit of thought and some extensions to
DRM GPUSVM, amdxdna could build userptr on that layer (Xe does this
wihtout SVM). That would isolate core MM interactions to the common DRM
layer, which I believe the core MM folks would appreciate.

The biggest issue I see is that get_pages() in GPUSVM also performs a
DMA map, which amdxdna doesn’t appear to need. That should be easy
enough to split out. But amdxdna does need locking semantics, notifiers,
etc., which GPUSVM already provides.

I’d rather see GPUSVM expanded for the amdxdna use case so future
drivers can use it as well.

Happy to work with you on this.

Matt

> +	return ret;
> +}
> +
>  struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  				 u32 num_entries, void __user *va_entries)
>  {
> @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  	struct amdxdna_ubuf_priv *ubuf;
>  	u32 npages, start = 0;
>  	struct dma_buf *dbuf;
> +	bool readonly = true;
>  	int i, ret;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  
> @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  			ret = -EINVAL;
>  			goto free_ent;
>  		}
> +
> +		/* Pin pages as writable as long as not all entries are read-only. */
> +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
> +			readonly = false;
>  	}
>  
>  	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  		npages = va_ent[i].len >> PAGE_SHIFT;
>  
>  		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
> -					  FOLL_WRITE | FOLL_LONGTERM,
> +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>  					  &ubuf->pages[start]);
>  		if (ret >= 0) {
>  			start += ret;
> @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>  
>  	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>  	exp_info.priv = ubuf;
> -	exp_info.flags = O_RDWR | O_CLOEXEC;
> +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>  
>  	dbuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dbuf)) {
> -- 
> 2.34.1
> 
