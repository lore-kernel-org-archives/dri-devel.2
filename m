Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E105DF483F8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2BB10E4E6;
	Mon, 23 Mar 2026 22:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X2gbuxtt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169B389D9A;
 Mon, 23 Mar 2026 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774303394; x=1805839394;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XTTgSskucr8QaRq47p7qx6jbE3IVxA554qlgtg89YwM=;
 b=X2gbuxttBbSKNOKOf1Y2pSkb/rAATs9U6A62e8W/F4KF8rppfHUU47XL
 SlXPpUVNE+CakXeBa0SzWa0JqIwj+vBarItSNhGvQGM//r5vRG7SHbUkj
 zj4IMFPdamTb8QiKZAe3KRckGucPqXNQVooOaHZdMXN+7fQRJotIUl8Uv
 EQ9s3OfV/1zMp6PStAwwfxy1OHA7uz9ptpVqQ2PDSWRqBHBdGViuH4VyI
 Wcg7xFB8JRjZ2gOkR9m1tvflC8ZUW0SrkOOil/n1DjijBtbtAzfV6sBct
 mtkkyHfv2PXOG9FADHflQRQAWh8T+xYaoy3iikKfaKAjE6axPo6SQndEP Q==;
X-CSE-ConnectionGUID: f0HUmGo5S8+ODxg7w4o//A==
X-CSE-MsgGUID: gxVHRsNtSRmD3Y/Mjvjnig==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="85623559"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="85623559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 15:03:11 -0700
X-CSE-ConnectionGUID: FML/RRBuSrKFVMZ1zEWKow==
X-CSE-MsgGUID: /T2XgXOuR7KdUtpCWoIv7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="224373792"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 15:03:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:03:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 15:03:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsu6vY1ihjXdgy7u6VNoght56YPd3EWufdERK2tksXk3TcB1XBNSF6ZC86BLu27YHIZBUAIudYEM7idnT+wOeFh/RV4HZDDgIT5xPytt7OQ7irpUykowvxdyTBJeu6ucv1uTWyWHtvBkdZgVhJO91a7ivsU/4CEhyuukqECRsmecvspjy0uhbljXr9NdOGYhxwwLSeYOUmBo36rTEi8oLy/lG6XfWTRELealOcvsziKRkJR3xEQFhagpXExx+lPvIZp2lAOVlc4jhLIo4aSI9u/8uKgVYoADncsMcTizL/H4WM/Qj/4uJziweHhhNQDdd9jnbwArac6sSIeC8i9ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLoisC3+isQ5AWh/ZUD1lBfMGCQPCJe/HhfpwP3bmCg=;
 b=D1JnhqwzJ1t3Q3C07lIhLY+njPnNm7o24xgHSmATC+0eODhNTM4yTXTBUvYJEHyp8/biUOU64Rx7ADIqeWDg0tegvCEPWmcOiTDuLO+bHMicZ/cA/FjodW9mVQ8nEOdlLjNXxicfHztYgZts+ka9ksDvYqFOIgIKOJIfhxN0ZXkvNkMdG3UkdzomzWrJzvuMvsdDxZY6yb3w2QuhwA9X0AS+Xo6a6I338oE20Q9wsS+F/P6k2Q0lJfUj6buxilj80+RYf/hSxdWWZFLhg67imAnQt1g4xAazFMCTEJ2oqe+YXu7tkKdmjbbr6+mJyVgSRIpFvEpCPPXJNSM3rKaymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 22:03:07 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 22:03:07 +0000
Date: Mon, 23 Mar 2026 18:03:01 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>, Piotr =?iso-8859-1?Q?Pi=F3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC v6 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
Message-ID: <acG4lRQGh9ZCVZDW@intel.com>
References: <20260316064100.2542412-3-satyanarayana.k.v.p@intel.com>
 <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce72961-67c1-4eb1-38c4-08de8927f693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ZhlyuG31vPa7zSHs9SiUHYVlcEw8TLv6KYwejpsZLmp2/ur7v/D5zRiJHk3YI0npT0Hj+j7Nsx23uwOzS0dVkrINHMorZ1StcIk05ixYfXnzjpNLVL/4jxX+sMUxD30UNGVjjaUuGx2MaS7VVE234nURKuw7lhBPppjJWcmpNlPwlOjHUulo3t7wd//z7I8WQ9C9orrwJf6qmo6LmJ/Z0U5sM6iM5kCe63teHUOTDDuFcDHC+lUoFhrcO1R+LJyfkiDDSp9wodOhGYCUWoIQKI/HbG4KG3+W7e06nwYS602UQwBxzK50LO9qz0wsjbKu8VaVLIjO7qRJV2JWkjlZ7jLr9vQfpTv145kVZ5OUECV0K1smLTdqxoziG8PveCebucIBs71URS+4fIXb+R6vcU9cpo9dNBWVMacUBgd15muEGBghNAu8pNNJZFgpPseyMJcx+gma/0cLRYAn1tXV5xD8HdpJCt3bJLHxqd0pqclknQo0lGTaJDgR42wJQq9yN4MbYbORHcFO6YJwprTjD8IglOd0BIqcrY8zkz7dqX0rOY6r6RABFvnUNkLFIKTIXj/CRIczXIvXqlUq3NSrXD8svTK0KJm1hkIFASijQct8zGllYhEVorVqNLvB//7A2mWEJyWdge/rGQtDFwz9+aZ0bS/7KAHV9cZY9WLHR1WyxxinJ1PJ9eqaKgChrt+4lwIwi5ktpcbZFiU5kxkZyCMvVAMxhvfRLdNi7TMZa9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVkN0hIaVUzSitvenRlZllwMFhaREZRRGpIblNnU1Q5Kzd0Tld5SmNuS2Ft?=
 =?utf-8?B?MXhXNzZyZFk1MzRObUdhRE9EbkVTc0RIWmpQWlJOME9OM0RzbHJVTkg5aUVR?=
 =?utf-8?B?bmtmTzZZMGk3UHlkNU1IK3JPSzI3ays3SEkwQzUraFRyc2Nza0FVVTJYcysv?=
 =?utf-8?B?VHFIN0VMNkgvRm5yRlM3MTJuV3JXZ283NEV1Wk91QTl2bjhNRmhHdUpJOEZx?=
 =?utf-8?B?NkMzZGJZcFdPeklQaHAwb3RaNmxqOVNaR2hCR2VkUHR2c2tXNDdPT2dHWk40?=
 =?utf-8?B?MDExRjJZVkdLUERaeG5PeTU5b29wa1lBWnVFdXJCcEhoZGpBUlN3YUh0WERh?=
 =?utf-8?B?aVRRSDdNaklZT0w5RnhHcjc2WnNuNGdlM0NRSStudFg0bHRMYXNwNFpKY3VP?=
 =?utf-8?B?RlFKMHU0bldRNnBhQ0o5QW53SEc1OXJiVk5yODVHSHIrdFBBaEZaSThBMjZL?=
 =?utf-8?B?TlBJV3V6OE5TKy9ZMHhEOTdvcERFZTZlbjdZN3lpVUNHVTFuT2ppT0syOEFY?=
 =?utf-8?B?a2F4aFFzZlBYQkcybmZ4dTl2dGxnSHV3THU0dm9vYjNIU2xqdmVYQ0lsUTY4?=
 =?utf-8?B?RzR5UHZZa3MxMG5VbVNsWDFLaHUxVGRJOXM4SVhqcGIxai92aGRHYXNCZ0hk?=
 =?utf-8?B?bHdPcWNUZzk5MmEwekdPek9ybUViMVRkTEE2dWtRUUdvbW9pbDM5Ym43M2tY?=
 =?utf-8?B?N0NRSjJLbWFIdTh6L0FqMm10Wlk0T3Q2ekJqSldzcEFvcE1GemQ1eUlhaHc5?=
 =?utf-8?B?b1gxaCt3NzJhYlY0TWtJU3hSQ2t1Szk2bmNDbTZpbkM1OVZuaU5hK2xiakVU?=
 =?utf-8?B?ZDJvd0t1dGZNT1lMb1FEb1RSWmcrT0loS08weVplMEc3Tld5R2Via295aXY2?=
 =?utf-8?B?bzlLRHRwQVl4N1J6VVJzV2pqbUNCZ3ZidzlwY0prc3hMeXdYaHZxUHN5V1By?=
 =?utf-8?B?WThVMXdCdzVaTlBlT2ZOc1Y0VjV5ZG9xejRpL3F2UDR2U0hYSCthMk5GZWQ5?=
 =?utf-8?B?RzBXSTJGN0ZIVklYSndvcDF3OWtqSkJvOU92R0VZM0IwV0Z3WXZyVzdpc3Zq?=
 =?utf-8?B?Tk8rOEpsaU1zTUQvN1NkUFRmUURhZG1tT2Q0cHpmV1BhbDNGNHNQYUlGMnlq?=
 =?utf-8?B?eGJ4TThBZS8vc2hqd2NLYnhLYXBOYnJrV0l3eGs2cG9NTXU0Vjg4aXNINEFa?=
 =?utf-8?B?TDBBNlBpUTFGSisvTkwxSDlCYmNBSnNFQWR5TWl6SjNkYks5SnhEbURWU2FF?=
 =?utf-8?B?UFR3NTd6NUJqOFMyZytiVjQzb055ZnRhem5LdVhYK1g5STRzRDlmLzFqdjlU?=
 =?utf-8?B?cDRmWU11MzVmNE1sZDdNSzh4UEc4ek9ORldTa1dDV3VGeno3VXBKYVJNUDRS?=
 =?utf-8?B?MlczckU3cEVsWVEvUWpiZXd2TEcrWS9neFdHOHhlTHV0eFF6WVpUcDAxa1o1?=
 =?utf-8?B?NXI1NGZwNmg2Nm1XS3c0QXl2RHczREE2MjlpbkRzSTRHSjVXVlhsbGZOOGNn?=
 =?utf-8?B?ZzJnUVZxSHR1bEh5YnNsSnZpMmdVakdMc2RtNzhvNXVQMmRVSGIvREc4bFlE?=
 =?utf-8?B?RWFVbGlqWVBCdytjUVI2ZEhTNm1qQUsvZ2V4SnlKTzl0YUZyeVZxUWFGdHFK?=
 =?utf-8?B?T0dFY05DTE81OXVmOVcxblJRUjcyVjk1cUlHMjJHQXFrUXVhdU01MCtGWnRJ?=
 =?utf-8?B?ZU4rYzlwbWF6cFJlSXJlOVRYRE03bXdacm9yN0RHVFZvUHFlK2YyMFRCcy9j?=
 =?utf-8?B?c3VhWk5HcFdVZ20zZFRNNEdBY2J2Sm55ZlRqNXVtWTlZVDJLNVNEbjlqallD?=
 =?utf-8?B?dkJ3VStKNlNUYjB2YzRXejVyWjBvYjJQbFdaMGF0STdQSVlaMHVNREdwZzdN?=
 =?utf-8?B?eWtFaktFcjhkOUZBamVmNU1TU3dNM3B1RFRXVUk1Q3BKQ2RyTXJGTmRIZ2ov?=
 =?utf-8?B?UnVuSlBuQ2VOT21rNllpMktobnVFUzZVQ3d1NnlHQ0QyY2hUZHRROGRIREZ0?=
 =?utf-8?B?Rk8zYWF5eThzN0hSREJQTk9tZXBVNjYxM1VpWGJCY1E5UjNmYVdQcGZkS2cx?=
 =?utf-8?B?V1ZaWWdqUHArQjUvYzJnWjQxeENOcDdBZGRaeWpHbTVRT1JyOTk2ZDJRU3ZP?=
 =?utf-8?B?VDVTL2VRU29JRWFaREVTYzRnaXM2WDB3TTUrOFpxc1ZFVGRzZS93TTdqSHV3?=
 =?utf-8?B?OW1UUlMxVEIrTDA5c2RmVDFJMW9lL1MyVWNxU215dnFMU0RoREhrS0Znck12?=
 =?utf-8?B?RTh1S3RBNFZmbGk2djFuWVRmcWlkYnBvczExT1grdHBWZ1B2S2RNdFZNd04y?=
 =?utf-8?B?TGs1SjlLbFVXQWhaZ0tKWXRXOHZnd1lEQ1pEM2lwYU9OckNoaEFrUT09?=
X-Exchange-RoutingPolicyChecked: gS1h0J+tX7LfETsDEaj+FrBKgrSlKH+r0MUh8BLtFNsGeLCY1bjmw8boO2KrH0lLAgyPL1wmGDr4RtzIw0reEBDomY6ws373l+5yPzOXMVrlibgvBlxZqrQtUq/Q0tjC31Qbc4Agms8+63KrJ3OznkzNqoutx+tw/jA96ycPeuf10OmU5fLZCc6BFW/0u7tX3SiJtTaxfsODnFMIVMD80+PD8rf8m9JbzQdwvV8UZ4Lxdw8F43n6ZMYJ0lA+CzjNgpOMIaY4ktG+zdNKfPd1HkRYCq3aAwuSevbO6QgRzzPVQ9EdA2A9IsU9vU0yi9O5zjQJHs5X2SifHhlwgJ8iNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce72961-67c1-4eb1-38c4-08de8927f693
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:03:06.9765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMNbgh2v7el61cYLgwRSeGP+te94KnkyIDYOpwstZaPZ6okL3B4SXY4KXWsG9Sl0ae2AAQzK857oI0iPxgMcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
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

On Mon, Mar 16, 2026 at 06:41:02AM +0000, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY, and
> suppress capability-bearing query payloads so that the userspace cannot
> discover execution-related device details in this mode.
> 
> Enable admin-only mode with:
> echo 0 | sudo tee /sys/bus/pci/drivers_autoprobe
> sudo modprobe xe

instead of playing with autoprobe/modprobe we can assume it is already
probed and then we can simply put the
echo $BDF | sudo tee /sys/bus/pci/drivers/xe/unbind

> sudo mkdir /sys/kernel/config/xe/<B:D:F>
> echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind
> 
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> 
> ---
> V5 -> V6:
> - Updated commit message.
> - Return number of engines and memory regions as zero instead of returning
> query size as zero (Michal Wajdeczko).
> - Allow all other query IOCTLs excepts query_engines and query_mem_regions
> (Michal Wajdeczko).

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

If Mesa gets ready with this and Compute folks also agree I believe we
should already take this patch in.

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
>  drivers/gpu/drm/xe/xe_device.c | 60 +++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_device.h |  1 +
>  drivers/gpu/drm/xe/xe_query.c  |  6 ++++
>  3 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index e77a3a3db73d..7decc6510681 100644
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
> @@ -213,6 +214,10 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>  			  DRM_RENDER_ALLOW),
>  };
>  
> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
> +};
> +
>  static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct drm_file *file_priv = file->private_data;
> @@ -387,7 +392,7 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> -static struct drm_driver driver = {
> +static struct drm_driver regular_driver = {
>  	/* Don't use MTRRs here; the Xserver or userspace app should
>  	 * deal with them for Intel hardware.
>  	 */
> @@ -415,6 +420,40 @@ static struct drm_driver driver = {
>  	.patchlevel = DRIVER_PATCHLEVEL,
>  };
>  
> +static struct drm_driver admin_only_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
> +	.open = xe_file_open,
> +	.postclose = xe_file_close,
> +
> +	.gem_prime_import = xe_gem_prime_import,
> +
> +	.dumb_create = xe_bo_dumb_create,
> +	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = xe_drm_client_fdinfo,
> +#endif
> +	.ioctls = xe_ioctls_admin_only,
> +	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
> +	.fops = &xe_driver_fops,
> +	.name = DRIVER_NAME,
> +	.desc = DRIVER_DESC,
> +	.major = DRIVER_MAJOR,
> +	.minor = DRIVER_MINOR,
> +	.patchlevel = DRIVER_PATCHLEVEL,
> +};
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
> +}
> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -439,16 +478,24 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> +	struct drm_driver *driver = &regular_driver;
>  	struct xe_device *xe;
>  	int err;
>  
> -	xe_display_driver_set_hooks(&driver);
> +	/*
> +	 * Since XE device is not initialized yet, read from configfs
> +	 * directly to decide whether we are in admin-only PF mode or not.
> +	 */
> +	if (xe_configfs_admin_only_pf(pdev))
> +		driver = &admin_only_driver;
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
> @@ -708,6 +755,11 @@ int xe_device_probe_early(struct xe_device *xe)
>  
>  	xe_sriov_probe_early(xe);
>  
> +	if (xe_configfs_admin_only_pf(to_pci_dev(xe->drm.dev)) && !IS_SRIOV_PF(xe)) {
> +		drm_err(&xe->drm, "Admin-only PF mode is enabled in non PF mode\n");
> +		return -ENODEV;
> +	}
> +
>  	if (IS_SRIOV_VF(xe))
>  		vf_update_device_info(xe);
>  
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index c4d267002661..4695761585e6 100644
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
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index 4852fdcb4b95..a42b6606a55b 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -217,6 +217,9 @@ static int query_engines(struct xe_device *xe,
>  
>  	engines->num_engines = i;
>  
> +	if (xe_device_is_admin_only(xe))
> +		memset(engines, 0, size);
> +
>  	if (copy_to_user(query_ptr, engines, size)) {
>  		kfree(engines);
>  		return -EFAULT;
> @@ -297,6 +300,9 @@ static int query_mem_regions(struct xe_device *xe,
>  		}
>  	}
>  
> +	if (xe_device_is_admin_only(xe))
> +		memset(mem_regions, 0, size);
> +
>  	if (!copy_to_user(query_ptr, mem_regions, size))
>  		ret = 0;
>  	else
> -- 
> 2.43.0
> 
