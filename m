Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4332C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3D310E437;
	Fri, 28 Aug 2026 03:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="haSMedRr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E1410E2D9;
 Fri, 28 Aug 2026 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787887935; x=1819423935;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FjG7sK4oeZFk13jb9gZrOas0AGTn0k7M+LxX5Ua2w6g=;
 b=haSMedRr45b3e4zJaVEML6p47rK/Mr3yqd5iUe54sLdMCjMsqPyHoL1l
 BOkHayyWa0AGCxdqoQR1Ysqj08TZvBDe6BZTF6Ndr0WGKMRA0Av3FSKLc
 fXPfNYLVTQIc9KBYqNtKzFR5WWFbu5axsqI0j2UsDExXe54prE5rYoOhz
 hi8mB3opOK8wYeU5JPTLb997bXtcBLbfIFp9nRKFNGQCDlX7MHo9wx1uG
 P/b5GR364jZ6jMkJqGjYEa8RngykSR5Diib1AHG8D2aGxSAZHTOXYaYTp
 afw+qtAZ4nzfaboG8NPovKlUS2m/sJ34PLXozkpSOZ3mUfKLgFMFtHayn A==;
X-CSE-ConnectionGUID: clXAN8YLRW2JdSdrqB7qog==
X-CSE-MsgGUID: rm6KZa/tQma6sESzyOdAPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88519076"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="88519076"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 20:32:14 -0700
X-CSE-ConnectionGUID: V5/2j819ToeNQl/Rrn8jUw==
X-CSE-MsgGUID: axZEEJLbSdC11Gxf6cLqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="268065442"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 20:32:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 20:32:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 20:32:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 20:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dez0Y6R7wM4KqFUq8JzsCPXn5EgTV0ZWy9QuhREq9b+r54i4ou8BuBytTscfEmTdluRqHQpc42CrTz8R1AembW8Pgmz9c/pm6OcC1ZOKowH+oabegFF2HYJwyKg9kcK7nS42yg8+IzpJ45HYiix7M0s46srzkKj7mHI819j1QGll6D4zKE6hLAx0df/eTVc2tL6mx66XeGreO0T7iRivoo0SrSJoAjoJH2dlDojxYQvyfDVeD1bgERSNauiKKwu87KwyYkn20sdH2o5jhvd6zQ9GQ3Z/V7wRq5Vpsc/ozMHUo2DL9yJmstaaaYrJQ02wJ4LjuF5gtbnf8wm4ed+OTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3SsZD0LSRcr3n49xk0hRe0AddMkV+ejDbprEn5PbYs=;
 b=VEpM92jmgFZx0uX0iqumQD3lHK5nrmGTeJ9+wJrTu6BMs9IzAg6MDSq+NOhLGH73r7Dch9LPz17SLW93oqtwrWLHzavhhAumGNGiOUTtKy8s1b3+BOimJcTknvVjPRnDqrwiLc9cqN6HunIstZ+fancav0F5S6v0CFPLA/DtERI3AqHXOnTWpgpmEdN8vrdAxTrjYQwLBTZLZg5NLX+MHNlnvUDc/mZsSeovfuOlXkWrBZDivm8XsCyJfcbUbm/r9zGomPJN27lOE6r8VKeQvlvTUeSc1LatRfhQvMck8VKIFl23fBf22MFBYh05mlvTKrarGkAUGq4bPzIlMqEszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:32:11 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:32:11 +0000
Message-ID: <8dd64ccb-2040-4831-a082-f9f7faa767dd@intel.com>
Date: Fri, 28 Aug 2026 09:02:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] drm/xe: Separate AER reset state from device wedging
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-3-arvind.yadav@intel.com>
 <apCiNlVXlZnhxeNE@zenone.zhora.eu>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apCiNlVXlZnhxeNE@zenone.zhora.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::10) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c480009-21bf-4da4-5378-08df04b4f1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BsMLGTq/LRCyDABZ2Fd1qmBzELwU9De3/rfX1nTen6dkTsSawLucbFbnNd24wIiDhbnCvkYk1zQ+s6LytigcSQvpaDcvERrtb3GwMwa6UGpaLGF6v4n8bq9WCTCt007MjzrxkIBp8PEUY0JDEw+efq3sbhcLD1+oGDUFZ8XoL/JLT9YiG1OdM7gAcMZbteJ34KNcr/reo3oLCHrD61uVYZYfo07ABfDBjfzFt9oTlG4pMV9XSeGkc/g6rYaK+WBavtWhEuvkFufETpkWs8zkUgVLSB+xzDpIXnmnNX3oQGupZuPcfLcqlUi5prP+Y0uha/T373cJFu7b6MMi7TznJs4sKogWr/qNBCNIf8h5Y8/XV8z2R+hAdNMxBzTRCyYMJ8126o7cKTD1BTRv7JPsR9gAaEn2VoIiKAeJCC0NcW5K82z9s0ZfjcojqfCiXaswKlDwG9R563cfkNKULgQfURri/fbbHb1PFyWLaGFtBTRybk20R7Xm3Vdt1xrEODB3/sjQFzs8aqO45TUBcntqUZvkvdVYY1N2m6cNOkgad7/zF84s7IvN8HCaNHl6x3/yKzQX03nAG+tvVaXSYD1gdzSkxfgdQLyug9FpQtK16uGCg7fRv7WmwdfGBtXlbV4jkv8n11pUIsjluRU4jgWYQ2kftUykzMcKMUm6Iq/Bmjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBOVk9zV1BUUUxGczFlZm5EQm9PV3dERmFJd0w2WUM2QXN3ZzdUUHh6ckFJ?=
 =?utf-8?B?ZDQxMnZETDgwU2d1RzBIY0dlRy81N21JcmFzdjVtWHE1YnYrQjR1SlVpTTZE?=
 =?utf-8?B?ZE9FRUwzOFVuL2NMaU1IQ0labEp6Q3ZTQzVYTEZOeGY3djR2aWladmpWK3E2?=
 =?utf-8?B?N0lNT3R3Vy83L01ZZVBldzJZVTI0QkJFUXowRVVjYnJmUTFKQXFWWldaMnZC?=
 =?utf-8?B?bHM2bFF5TCtvZUF0Y2xzY2VPVUN2N0RNd2RPRTBBZFdxbGt4SytjLzVJd2Yz?=
 =?utf-8?B?YVdKeTFEemhxK21ocVNJY0YrQzd2TC9oOEIwL24yeVluemJLSTlDa2laL2Yx?=
 =?utf-8?B?ZWk4ekVBRnNNVndiR0xodzVEU1JhUmVXME4vUW9pWS84bGVvcE95Yno0TUNx?=
 =?utf-8?B?VTFIR0V6UHJIam96VG5NNUE0TzNsQkdmbHN5V0o4cWxmeDRjM0ozNzJ3QTgr?=
 =?utf-8?B?YWptNFhiZG85R1Fqc1Fic0xnVTRWR3N3bEdZQlMwVlVEK1lWYWZIYzVaU0J1?=
 =?utf-8?B?NVVyV3lRZ0d5cTQzVy9zaXUzUTMvd3NCK3hKUy81MS9Cc1NjWDZJK1NWM3Fy?=
 =?utf-8?B?dVJVVmdSdFY4NWZ1NlZxcGhuOC9kcFpjRGVWbDlFd3FVclRpeEEwUjNmRXRX?=
 =?utf-8?B?dGRENWxDWFh4Vk1tL29hRUR5cmJLS2tWemNYL2VheWRiQWpwRm05T0NKaGk2?=
 =?utf-8?B?S2FXRHRVZXMwYnNQcHh3TzdNT3loblptZTd3bmc3YTNFWXZnSXhpenpTdTVK?=
 =?utf-8?B?OVpmUTJHajFwS0gwbkd3RVhVenRLNjM3dm5yek0rM29JR1Njb3FRNWpidjFq?=
 =?utf-8?B?REhCZmxpTzFFUkV6WHFqbUdtZGdJQy84c3YwZG9STkhYRHN0dFZ3L2hkRWdZ?=
 =?utf-8?B?U3NYQlA0ckNKV2c3TEZLVmRCT0NzdzhnN0pmS0k4L1NQMnVvOEEvbm1iRmV2?=
 =?utf-8?B?NE50T1BUT0J6MWlHNERRNHlqRC9FdzlMWFpTOGt5QmZiUi94YmlYYmJwWmgz?=
 =?utf-8?B?blpZL0dITjExQW1xSlJRRm9aNGd0eXBhdVdVUDJWMXFENDFVUmxsNlBYRzVD?=
 =?utf-8?B?UGdqaWkvd05vanJLYmU1OWxIR2NPdWxxWlF6dm9qWW5FcDBSbmsvK3VtOEVR?=
 =?utf-8?B?cFdjbVA2eDhEQjhNYW5TVzlZM2VQWkFHQUhIVlFQMXhnT1p3clk1Q2ZEUXA0?=
 =?utf-8?B?akgxRGtGVUk5RFNXU0t1eUwyaEdzUmhENHlTWlA4Yzh3MXFPNDU0VURqaEg4?=
 =?utf-8?B?bFpLOXZrUmNWSUlucjhHcjJVcnRyaTVHUC9xOHErQzZwWXpwQTVpdmpzaGV3?=
 =?utf-8?B?MDJINmpCRmFMYlFXWlBOcWsyem5yeFFsc25BaWJiM3VhKzJaZHV4M21tU202?=
 =?utf-8?B?TkJUVVI2SW94M0NRMUZya3FQYWVtajBGbitJQXlTYmVzdlNSUi9ocVJyYmV5?=
 =?utf-8?B?QVNpNHFleHpMQTZOTjJpMEs0R3dvMGo0VU4xQ1ovYTJVMEVjRVJBU3V0Q0xu?=
 =?utf-8?B?SnBmOWtzUFYrMGM5eUVwb2JTK2FNc1FPOTN4dzBrTEpnR0hBb2ZVdTl3aHdy?=
 =?utf-8?B?NDkxcXp1ckdpclVEOGdxRjBZRkR3U0F6RCtOQWtadW5lb0lpWWN6eHhrRHdK?=
 =?utf-8?B?cHNpZWszVFlvZ015eEVJMm51c2loL0Z1bnpsTkQyZExVcWVBYzEybGZvaThG?=
 =?utf-8?B?TUxMWE5mZEt5KzhvdWpmbUJVRmg4YklIQTFoTVFsWVRDN0VJcnAwSi9NUkFR?=
 =?utf-8?B?UlgvZWJ6d3I4Sitlbk16L3U2TGZTQWFiT2tqN09QL1dDTWJpSWJCYjM4Q05h?=
 =?utf-8?B?dnZCV3BwaWJxMmlpUll6UW9JSi90bDRTQ3VMMnBNYldYRXREczRUL0l3a0Ft?=
 =?utf-8?B?Y2JCZ2tTSlYzNzB5bVVzQnc2cjFJNE1xY3Q0R090SW5YcE50eVdybk05cm5U?=
 =?utf-8?B?YWMxeWp5WXRrMjlNNGV1Zm5KbjNLSmxzaXNVNkdOMHk0MXdsYi9vY2hURkVC?=
 =?utf-8?B?TlRJa1Bhdk8xUW9JbVlQUmRsZzJKZzl6TzNJV3ZLandpNFRHbmhZOTFIcFdy?=
 =?utf-8?B?U3ppVk9HRDZsVHMzY3JZcXlrNXhWeEFUaFpGSjhPM0gxRkJDQkQ2RnVGdk9r?=
 =?utf-8?B?OTVIVkcwMlZId1htVTQ1TGU4TkNYeS9SWldIYlcrQ3lMeFdjM0ppZ3o1emFY?=
 =?utf-8?B?R2tKRUdhZk0rQ2xVaVRGZzZBNkUyNHhXOVYxbE5oeHRFdk1ETDlhZHVudmxx?=
 =?utf-8?B?WEpsSjZpeFNzMGYrMXZhbmFlUFlRd2p0Y1ZXYkFGWm1Vem9FTkhIMmdtamJM?=
 =?utf-8?B?UG91dWl3OWIvT3p2ZVlXMVlMZVZMRzZPOVlPSFBTR2tMQk1WOURHZz09?=
X-Exchange-RoutingPolicyChecked: HvdBP3UOmaz6+uP+we8bv9vwjTpI4282LShKmuP4TvU+hl+9BAyCWLVVfrVVrnFOIjnXFCyDnfrA77wZIRmxv6K6oua81+6s+gS4C7LX1PJvVR6ufWytbyyMKp0WJHzqRGy6CFRi8tdmQHh/jJ12fR/ADD+SMqmdpm7kL8EAmdjwa4J0ltNuqtElDzmG8dWsFQjavYkYUkja1xCglqykgktlNJi+Bt8yiBbJt8iGY3coNrRskgYzydh6KyaPgrtYzCv1bU9fUz6Y2FvxmWSeW3bHfYQhNBXIyQbqAOliIff49rFDGUpfa7YyNfEX2BrgYRCBQ/zC1Qj6ncueHAa36g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c480009-21bf-4da4-5378-08df04b4f1fd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:32:11.2380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i1LBJO5WzLsYGV4sVTT3s2mUF+c/gR2nGe56eulzFzAt3i82TnBDDwRk96I5uNlZhnfnG1KNPvFNrQw4BxrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
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


On 28-08-2026 03:25, Andi Shyti wrote:
> Hi Arvind,
>
>> @@ -1062,7 +1062,7 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
>>   	xe_gt_assert(gt, g2h_len || !num_g2h);
>>   	lockdep_assert_held(&ct->lock);
>>   
>> -	if (xe_device_wedged(ct_to_xe(ct))) {
>> +	if (xe_device_io_blocked(ct_to_xe(ct))) {
>>   		ret = -ENOTRECOVERABLE;
>>   		goto out;
>>   	}
> There is another place in this function where xe_device_wedged is
> used.


Thanks for the review.
The later xe_device_wedged() check is intentional, as it determines the 
error returned to the caller. A permanent device wedge should return 
-ENOTRECOVERABLE, whereas a request canceled during AER recovery should 
return -ECANCELED.

For that reason, this check should remain as xe_device_wedged().

>
> ...
>
>> @@ -20,14 +19,15 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
>>   	struct xe_gt *gt;
>>   	u8 id;
>>   
>> +
> Please remove this blank line.


Noted.

Thankyou,
Arvind

>
> Thanks,
> Andi
>
>>   	/*
>> -	 * Wedge the device to prevent userspace access but do not send the uevent.
>> -	 * xe_device_wedged_fini() releases runtime pm if wedged flag is set, so acquire a runtime
>> -	 * pm reference to avoid underflow.
>> +	 * Block device access while PCI error recovery is in progress.
>> +	 *
>> +	 * The old runtime PM reference balanced xe_device_wedged_fini() while
