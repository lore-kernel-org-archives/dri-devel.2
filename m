Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B822FC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F7110EA81;
	Tue, 11 Aug 2026 06:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VLgIxQe9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A5C10E28B;
 Tue, 11 Aug 2026 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786429704; x=1817965704;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4lbCg0us4EX0JBSSeMKIbhgEpsNdeST2vWNN6V5X/rc=;
 b=VLgIxQe93nmtJaF7cpl8a+hsRvYuhPz5ii2oTS/tVxIOD7UO5ey0mFEw
 nO4oyftTgNJuSbeBNX6fovXhjUWexJ0oYaMiIiCeEk85atBRxNXfBiIq3
 nINwG65qAaMFpjgrHwyjrTbqJoIUsBflWAPvDOHM2x1vcsLTAm+1MxUjF
 OskeEAie0gRs7Qfqsbo99hjCwaFUDk/AxRWciF/oEiN99fuyZgrLU5V8f
 9Bk40On/TDnDA3H6TNp8b6/7n2urhCGEpnrellYG3JipFw3BsJZXW11/g
 LUs6ePFanA4ZsAywgV3xWAFQ9N5+qTo8SmuI/ZcG/xYvqwSwD7jcuCf1W Q==;
X-CSE-ConnectionGUID: 4gKv+2FVQqKJ0sSQ3oijJg==
X-CSE-MsgGUID: ArYQp1+pSKyEsouD174QKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86888123"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="86888123"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 23:28:24 -0700
X-CSE-ConnectionGUID: MnLXmQ/ZQAuuaeO9z0A9PA==
X-CSE-MsgGUID: JuryXTqdQaSWin972YSzCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="259936112"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 23:28:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 23:28:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 23:28:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 23:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Fxl2l3x8XhtnCa/nYr+wyjCXdQhaI3GB1BBjTtGao4IAEyVouvdj59mSd/Xrw9EepkSacHcH9Mzf8J+OuubLHSoSSF50rlVH9FS2KE/18gjUnsRKMf2EPJyCus5by+4FyUrPpxfL1iP9yGktURrp1x0iQp4FOmGu5tvRfehaSPXDgRm2il87OAFDGvOZhqP+Pr3CflNcOiNIIE8tjYb8BQpxTEbgQ/dbswYFoKcVcc9exQTBhR9JQFiEePT1bef4c1PifuCJWGuA0UY+ZaIygwJzaVxx7b+BXEN+Q3Dunf0BGC1pZ3/iKaK6BnEWniZeoOXMjywCPA3wLtGWZdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO7u3C7uDHzmE/v1Wo+7JEfeD5/B41JMlhP5zjzSP1E=;
 b=FSZjDWYdfq5B8BrqxpR2+WHDygiFDl8wsdk14AspKASDjp5IL4KN22vFTZ/8731aZhplBrC8iHydbxAPAvM34E5Di6/v5sOkEfcAWdptQirvj6cJXoL+r6EZQCZW8WGIu5vqDOFCTRPn+qaF+z2ZErYTaWyOcwhOhkRH07slxKKqMFD3KlMUxtxYbE3eyN72WCWwT34WLCmJ6Ca9hDInyvMj4SUFyLz7uq7PYSH+otiBayAcRvRby4mOzStMF0v8441tXgt1Xv5nArFaapofSuu0h9v+ACd0vSft9393y1c79IUqRVRUqXTgaEUP7zNCpBpKvctkSiw6N4xlW7vu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Tue, 11 Aug
 2026 06:28:20 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 06:28:20 +0000
Date: Tue, 11 Aug 2026 06:28:10 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
CC: <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <tursulin@ursulin.net>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <chris@chris-wilson.co.uk>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>,
 <syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com>
Subject: Re: [PATCH] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
Message-ID: <w3p7i7btvl6b7o5puofyxcjm362ni3mtcfmog2plm6h5wxk3an@dflvwud5t6zf>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260809090430.20577-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260809090430.20577-1-kartikey406@gmail.com>
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f26f901-41c0-40bf-9b17-08def771bca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|11063799006|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: w3CoNzQ/16o4T4ypbjGMgXJzrGmAFGSbmXqEMAcGqGOsT9PxxdS7JUjOZAbzIn0ktfxj2jNFPl7FEK7ZeXIkyF/U8Sjs7Bq/bqjW8Mu5xUgm7l0lzQIRZksl2YDJgi80FMzwkoHTJU8Zz9KYSdPjxyWuT1q1jkgF0DTRSAuw9ph8aU5BTAgOnuAx4hj8z3bi1hd2WFnRBI0DEq0slVFYRYn7B4KXqjOpGM5u2Zlm+E+aTlLSl+isajQC7esliFRurqbiMTeXRNQVPhj796IfMEHSwYQc8AiZRxKrQZi0OWQPCsHVTgpp3ZvEwUZ/+bCUIkAAQovyjGgDd/rkpkWXbFzzzdwAmLC8lFErctA/LwzFGaobjGgMPNz7P46eeQHAHaWgoEQBky9BGjwuHby66ksGiFfkyGLYD+3gNRvSMtzUoHQt9gW+zcavGkLqnzkzZ5F9hlI9N4OosUwhKEmTo7/6KjPvlwuEfOieUFOIVpbgjVBADWACSe5YT8RDY5EBNeZzlALl97CaMGySSV9A4ajppKzjI0eBfRyry5ULGMyy0RKBRrQ0g3FOvlQHx69dpgfT/GKHkAmd1DT58RDAa1hTb+S8LSgoJNgG7j8L6I0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNDYWpRL29TWlZPUW0wdnBPaDRsckRvd2NuaWdjeTc3LzI1VHpmUXpxNm5v?=
 =?utf-8?B?eGFlNFhVbGNra2t6ZkNZRFNONzZYbGo4MG5sQ0gwbXBId05GT0RnMVE2SGhL?=
 =?utf-8?B?OWFyZ0Y1RlhacTJWMWQvRkJnL0RKbWpqaDVaazNuWVFXMWJ5anl0R0lrbjA5?=
 =?utf-8?B?dDVOL0NGZHFmeElWRjNOOGdLUm84WldCV0gyQ0VrZjFNUGpaRVRacjZwR1Ft?=
 =?utf-8?B?R3VxQ3pHN01nMFZSbzNCaVpiNlk1bTZLN2ViNDB4a2FjTjhEZzRQcVR6UTcx?=
 =?utf-8?B?NGRmdnZMaXNONUNjdmdMb2RvRGFJOFU1NDlUdnF0c2phWWRPdzVuZG5LRGpE?=
 =?utf-8?B?Y2tMNXpzTTZzdmFMcFNyUkRFQnBBVEJwTCtjUEZJR1pHejREV09yaHFtbmg0?=
 =?utf-8?B?dDdEeUFwTFdnd0N6SHZNWGQ5SndLWlUrWnN2aklSY2oxTjBvYlpVT0h6dWdE?=
 =?utf-8?B?L09EVU1wTlE0SFg2VU5sZ0hQVkdQRmFOOHQrUzVjT2Zsb0hodGxQM25Jc2N5?=
 =?utf-8?B?UVRSdkNoMG10dHQxVmFGRCtSRWFVK2o1ZXlQZVF2cmRodFovdnR1QU1CdGJ3?=
 =?utf-8?B?dWpZWWtPeG1xM1YvNWJIbzJxc0VkUjdla0o1MU1XZzVSSzliZFRmTzJSUFFk?=
 =?utf-8?B?aUYzalFwSzEvdWtXeSsrK3BIYjFyc3oydjBqZ0RwRG1hKzdIM2dNaXNhL0dl?=
 =?utf-8?B?Und3cmdETTl0bEJ2Ui93OHpFQjhzQW8vQ2hrUmF4YzRUWHQ3YnlMR1V1LzRW?=
 =?utf-8?B?MityanBEWllpNDlRYmd3RGJnWEMvQ2Rvbm9jN0liYzdGbnZ1T3dySGkzcmMv?=
 =?utf-8?B?R0FUT0d6TkNZTCtpNzM0VG5TckJnSWQwWEVPL1JiZlNVM0VXNEdQNjRTYmpK?=
 =?utf-8?B?MHFPMUtlTUZHSVJUcHBheFFPSkFwcHA5K2ZDNzZPQjRESG5LaDd6SGJKdUsx?=
 =?utf-8?B?b2N6cFNjSkV3bEdWYTdDWE5DbnlLRkVlK0IySHU5dVlxVlI4U2NtMDNtNjMr?=
 =?utf-8?B?dGo1dEU4aE84dWdRMWk1S3FralY3cFhQME0zZVRvMEwzQ0FLVFJoY1hZNDdD?=
 =?utf-8?B?SjR2dVc4YytPeWFqQjNVb2hJcDRJRlhxalFPbjZYRnRGY0U4VC8reWozYkNu?=
 =?utf-8?B?cFZyTFVJVGtPWFBHNWIvMnFQZGtmRG0zREo0ZDQxRHFCN3RzNjZwWTVzTkwr?=
 =?utf-8?B?NXNIZXYwaHgzUEdPZDJzN09RQVdGS0UwUHB4RUpCUmZ0U0FNM1NKZWdDSjNn?=
 =?utf-8?B?aU1CZktpRnRtcGhxYjE5YnBVemRadFN1Yk5wLzlYcVJaNjFFQlhpcC9LL29Z?=
 =?utf-8?B?enFpejVVOXRYd1AyUXBQd2dNa05KZnZacEtZbm9OMHBGWXlHTWlpU20va244?=
 =?utf-8?B?eVRUWklVanM0QUNueE9lNmJQUzBJaStlZDZvQkllYWkwVzFIZ0YvbEpFTXJl?=
 =?utf-8?B?WVkwbC85V1lHLzZWQ1JXSkJ6TGN0UEo3RnYxZDNkNDJsNWdRSTliK3k5T245?=
 =?utf-8?B?WklUK3hSeVJaU0Z3QytkRFhOYS84UjJhc3I4QXBKLzFuWVllT1BCdW5PQ1JQ?=
 =?utf-8?B?WThMWTBtdTNhNXlpdUlrc0w0amlZT0RKSnVqVGVZRllGcFNRaVhKc01OajBK?=
 =?utf-8?B?dHE0MUFRRmdyU1VIU2Y3Z0NybHdyUjlaNCs3a0JBdHY5ZXNwZ2xTREtWcm1u?=
 =?utf-8?B?YzdJYWcxSkptbVZJOEQ1NHlIVmkrc2VNbnZMWXRYd0N6Q2E0a3FvM3M2UktG?=
 =?utf-8?B?N3BwSzVrOHV2YWxtNmp6aTZ2blROODk5T2dyQTJxZ09jd0ZCNnV0OGI3MXhz?=
 =?utf-8?B?RFlFaDRmS3ZDZmxKUWREV1hXcjgxL1hYUmtTRk9zVFpMS3dKYTRpcEZnS1ZU?=
 =?utf-8?B?MExWcStqM243dlhveGx0c012TVg5U3dRajNlTGNPdC9LdDV3U0MyTXRmL1hv?=
 =?utf-8?B?eFcyV0c0UGU0cUtpSjRUbTdIL3RlYndEbjRmWnJiLy9Zc21EMzEvaEtOWWwr?=
 =?utf-8?B?am5tc1pTajdOMFlMb0Fvb0N5Nk94MVFLeXh3UWJ4WXRrZHAyQWh5YjJoZEhM?=
 =?utf-8?B?U2dldndqWmpIaFNvcW16OXJmMXUrL0ZPUmhWS0J1N1JnSHhINnZISERKbXhM?=
 =?utf-8?B?YnV1dGgxMEIrREpMbkJUelJ2dXlQalR1ZFRLVjU0U3E0OURSWkxDUXRqR1J6?=
 =?utf-8?B?eVVkUGd4SjRVbk9xRG9YNXg4THlzank0MVFyYVBFTXJzdVFOQXNQazdLdkJE?=
 =?utf-8?B?dGI4cHZnSS9yM1Y5Ymp4eXEvd0JnblBBeG1wRnE0dCttSko2bnpuTVdPSXRz?=
 =?utf-8?B?aVlsZzRwbmNpK29IK0p3elM0VlZXeGdPR2FKRTNRZk1tRXpmYjZHTFNuYkNx?=
 =?utf-8?Q?N9pVXKgvSbUWn2/A=3D?=
X-Exchange-RoutingPolicyChecked: eF12G/hYhAQciFnVsWQ5ck3c3VcfE0lr//vDN0SWXAfASY+Un3LSp9jr/4CvigTD8aGtfaUjyFrcrqGtRsDylEAbs4b1QW1hcA0MqQLbNZu7Sk3W+4kYEPN6j/890J4cqmzolqi1zJaR4EOh/XDgq15JuVnPjWy9TI2XzwSyAPpsZUHtQYcoGDTaqVqcr1domXP4SkFwR58IqjAWFmDPtt0e+GM4EwPC8jzs6OXy7tqCAymB8Jgm4lMKIf2ubMUJg9n3KWtJ9L/E3rTwAj3fTN7dweHymm+DfkXJzbf7DwJYgFE//g5NTQvzZKq2uWgRKo7Od3qd9eLVmZrD8lEPNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26f901-41c0-40bf-9b17-08def771bca6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 06:28:20.2643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tE83/88n3P9XXEMuUp7fNz361VT4ZU7rncSQMx8lfIsC03OZJRx4cVoOZVIgZuUlg3eYfdZYWPMv4vfPA5NW3yj+Z/0pMsq2gt1opMDUjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
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

Hi Deepanshu,

On 2026-08-09 at 14:34:30 +0530, Deepanshu Kartikey wrote:
> pci_match_device() can return the dummy pci_device_id_any entry
> when a device is force-bound via sysfs driver_override, in which
> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
> struct intel_device_info * unconditionally and dereferences
> intel_info->require_force_probe, causing a NULL-ptr-deref.
> 
> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Fixes: 42f5551d2769 ("drm/i915: Split out the PCI driver interface to i915_pci.c")
This "Fixes" tag should point to the commit that breaks stuff,
I believe, so what you are looking for is
7ef5ef5cdead ("drm/i915: add force_probe module parameter to replace alpha_support")
since this patch introduced that unconditional dereference.

> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 82415af47d54..2f03f95945f1 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		(struct intel_device_info *) ent->driver_data;
>  	int err;
>  
> +	if (!intel_info)
> +		return -ENODEV;
> +
>  	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
>  		dev_info(&pdev->dev,
>  			 "Your graphics device %04x is not properly supported by i915 in this\n"
> -- 
> 2.43.0
> 

-- 
Best Regards,
Krzysztof
