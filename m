Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EE6FAD416
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFE710E0A1;
	Thu, 23 Apr 2026 05:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P0PDDSWW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CA710E2F2;
 Thu, 23 Apr 2026 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923583; x=1808459583;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MUuQiAcxvBvZOKr070V/Z4AzD/VPPlLGKhhtEQXjl68=;
 b=P0PDDSWW2qOT+ZmvtTiyhoJ/tmikO05ERiJjGAxWN5Ap4XMSQF51JWj7
 Xedu+p9439dxMNH5EaAnGF2DqwoR0zyYhiuQvv/0FBN0GOAx/8ZnIVzc+
 +5IEA7ttm81dndfyKqO06COXJGgtBrb456lSwkVCnZ3t3D07+TmgrZJFr
 U/KALrDykQxakkxHGhlw8VrLKGIwkekdkXECL38KhwfIcPirTDtD+bKKZ
 0Xu43pVVI32paB96dJvbVU6NKEp/FEWP9Wa6qg/nyu46igRdfx3HWLq7p
 7gKsuJCFaCKfmhAtQ5fPu6ZB1OOBbnlFWpO4R9n8yI7F3VaDAm3bbznjD Q==;
X-CSE-ConnectionGUID: SHfVPtDkSJ6eDpS7ATYvfg==
X-CSE-MsgGUID: otH572jWTfedensskSxyOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88494220"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="88494220"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:53:02 -0700
X-CSE-ConnectionGUID: F9mSz1JDR5Gw3Zol/KqJkw==
X-CSE-MsgGUID: SVBkpCzrT5GzjeouGs20xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232463513"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:53:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 22:53:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 22:53:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 22:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6HzBSgE0HTsCDAucXaL4Q3ZZBLruAraiXHOkr6MVyEtlRW+KVinb4FpYQJhwvX6P8/pq2YM2ZnnghL5aWVIBRa7C1JZpe0Rot+8Rv/qO7FT282FKNWZDnvLR/WlhThi7CbZibJfwSvtOssmmKtweEdaTK/K8Of2O4phbRTDgE+ppzzxBkz2BA/eHanFqzu6jZR3hLyC6GEndUg5LEdPV/8AGk/1DIADXtILwYpm8ONqVDT7icfPu3Ccl0LNX8MyNRoqVqd303mofZgjU3/bBdRoQI/briWnzXS5ldbC4jNSvktkzcEP5IlgGLQXgyFGtSM9YVqgcJOWgzFsoRL2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi8w/BUBolfmqn05Rg6cq7ZUtDJihjAjbdD2i9fprBg=;
 b=c+eTiekqDDf6wOPAOuyBOuksWyX4DZRsgLEL5TtXoeOoc1HYnOf5F+y8AHmj1n1LCKPE/LL7MGosCq+Ncft5FcswM6iLr/m0qX5LqdKtazZJO8K7vDPD1CqsajiutiZCqqUFeQjLoM+nwXzMJ06NO8iqc2lySVHYqXX4tgY+y/AS2SkamuRGI1TDJzVwQzeurx1ENFxo8wEnB+kp+n8pNdBo+vLC+oltXgBFwEJ5Z6D7zAW13omb4boezxDbe4ah2lKFm1p4Qh3PBdYz09I+Ueq5coZ9uFFKviQaTWOv/pZZC2pP9O0DO28I8cOOViq7SRw4sUfaWvMqF35gzCHftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Thu, 23 Apr 2026 05:52:57 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 05:52:57 +0000
Message-ID: <65c6839f-a92d-4122-b347-a1250dde961d@intel.com>
Date: Thu, 23 Apr 2026 11:22:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
From: "Tauro, Riana" <riana.tauro@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, <rodrigo.vivi@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <anshuman.gupta@intel.com>, <joonas.lahtinen@linux.intel.com>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <intel-xe@lists.freedesktop.org>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
 <adc6hTz-xMopiJsc@black.igk.intel.com>
 <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
Content-Language: en-US
In-Reply-To: <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a06f79-f815-4adb-4811-08dea0fc91ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UqMSAz0DroLzArf7fHShmTwD7fR1UmA0cAvLz3Glz+vPwkiRuX9eJhUy+zfDIcgKF47DSvhL3+A9uoty3Bc1SPg7h61XOyri7Lus5WvpQz3k+leCzzOh5Fe6p4NamebkYk5ZV1sEBmYIfz07FKYV+DfUGujmyFBk8Z7+wjdUpbg9BdIwqPIKmYC1wHH9Q4p2W/yXgbRNOYVGkVVWXXeZw/qkWOuhjxt97YTjgeQOcLEQ6ojKrwCeLhz3Xcjd6IZtgZ1umaHiW6AlWTZ4Gdv+I/aGpvPMtMz1Fb/5wTTCmfijtqYemJWINVVHYx9P6OVVRtwVqr55dNobnMN3AlvBq3oecNCfbKaj/mlzr8O42hFty3q7OwkUQ1vYldH/DDSmBBHzo0S7Uzm9DqvFHj9eynIquEsMgU9OSZj8HylBsywEtg0EzmF8HN6m/Z7aa7L8kzM8aLbxA7ptor0hJYQOYwWp7N/2QJX8wXfz1OoUGEsFXUmoWnxJdIrhKazUyJC7lDeLXyOXB0S3ozMdPTQoc6nVWjNcKAqQS5A0tusASv8/PNFB7LhM9hi9hpSNefjWQw86HIa1oNNulgeG2ztg8EfquZGlSIwMwzMe0UxxrNtTTA02zyzXc3/WEXLZre/e+RDEJ2rCY5Hx8qiWSCDf0atndy9wnQOYYeR0sKts1D+QMabHCADyQgZESwrrUT7MnbulWhrOO2F0AA5RznOpDsYNgZjDsYyr+wsJ7uyL518=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRXR2xmZGwyMVJtTXd0QWtzeDJvcmJlbEpjNUJTakQreVk3enZhYjlWR0tH?=
 =?utf-8?B?ZS9kY2FWSnJRZ25tc2loMWJSdGdNVndCMVJETytMR2U1WDJtZFFZOHB0OTZz?=
 =?utf-8?B?OXVoRjRaaHFOMzdpRi96UGg0d2xsZ0hqc0c5VGltNHcyTVBEd1I0WFd3MlZy?=
 =?utf-8?B?MXlneENaaURMZFJaOVdqQ0RGK2pVcFp4bDQ5WHRMbUlwZmhUd1Jkc0tUN3gx?=
 =?utf-8?B?U21Xb1lDMVVrQUlUQ1ZhVVhtZHBOZDVFUjQ1MEJ6YjNKN3FpeDVVN2ZMN0sv?=
 =?utf-8?B?T2RlZ0x5bndOKzNsZ3JrRjg4Q0lROFFjbWgxekw5NE9FaFUvcklBVUtlOENn?=
 =?utf-8?B?SXRwYmtGa2tHQzRxREVYWjJnMEJqMkhvcFVLQnFCNElYSEplSkxCMHRhRFQ3?=
 =?utf-8?B?WFpra2ZQeTlMMG9iZjAxVzgraXVqRENOdklyeGpQNE02K0t6VldnQVZESUtO?=
 =?utf-8?B?OXhxNnFCOEoveHhtT1FrdXlJNkRKL3h4djJORSthYzJPRlB6U3pDN2NCdzlQ?=
 =?utf-8?B?d2FJek9PWTZ3QkhJeWpkYW52cytHVGkrRHJGdzZUREJBbzkyR2h5L0hvMkxH?=
 =?utf-8?B?TlZKMVpOcEpFSzFmRnZYUWh1Z0NVTkNEdjVZZ2VROFhhakJPRExmUXhodVJS?=
 =?utf-8?B?aFlrQXNBbVNWTVh0dnI3VjZiSXZCc0VoejRCRFBYZno4U29VZy9RcnVrZ0Nn?=
 =?utf-8?B?VU5WaEpDTGVIZXBNNW9PdVRjb3VkQjJnSzhUSVJTR2hFQ1RJZEJoaTlkNkJZ?=
 =?utf-8?B?dW9QbDdVZkRtcU9Dem9jN3BEb1BEczlGS1g4OUVmZkdYZ2pvVWhnSXRrNkQy?=
 =?utf-8?B?d2ZFVTJXTWZ0cEJxaCtZek5VRkxJYThYNmV2ZitSY1Y3NGlRNThENmNGYmtW?=
 =?utf-8?B?QTdwUjB4eW8xZ3NmMWREWkJCc1IwSVAwTStGS0tsaWRkWmNlTm00Q2JNcTRq?=
 =?utf-8?B?a2RMRUxCdUdtbG9ZbWpBQ0lmSlJnK0xMeXFQeWMyMlcvL09hdUlBTHg4MDZa?=
 =?utf-8?B?S0RlZ0NoYnhieEUxK09RTlhjRkRwQ1RCb3V2aXBQNC8vVkdkVDRuMXV4OFFG?=
 =?utf-8?B?Zy9ZK1poNjcwd0FQR0VIb2c1cG5wNWVxTVRYMXNrSGRLa3FYMFFFSXB1ODFX?=
 =?utf-8?B?Mmgzb3lKRHJlTzY2angvWXlIWmxpdXo5b3JtcHRCNVZQdFk2SVNUdzYwZC9L?=
 =?utf-8?B?RFpLZWl3aS9QM2l3TjlUUGdqakFUbUw2eVprVmdqUkp5R3RmOGtDL3E4YTdv?=
 =?utf-8?B?WWk0S2l6VDRjVjZsbGtNWlVNYzhSaEpza1FiMUt6aS9XZ2Fad05CdUhLV3dn?=
 =?utf-8?B?MnZFdi9aakl3cHlDK1FScUxuRnZDa1BJTWZuYjVjM1JwL2Fqc2owK0VVRmlX?=
 =?utf-8?B?VXNTSVZ6YStuYU02Ny9XbWtzSDZJZ21qaFRnTXdJU3MyRXlheEd1VzlnYTY2?=
 =?utf-8?B?bFJLN3k5bHA2MDNiR0wyTHdyTWp6UEZLd21KZXZwMURGeXhrRXRpb0dhd0FZ?=
 =?utf-8?B?MWlvVXJRNXEvOXRrUWZ1UWgvUGF5bStkTlNVQ2orNnIvSGpVLzE1eDBnakpw?=
 =?utf-8?B?RnM2R2hZQm4zVHVWZkdTanE3UDhGY3VkaUswMUFWVFB1cWNEZGF5TDdpREEw?=
 =?utf-8?B?Tmcvc2NFTmdMcDBSbWU5Wk41MDlmRnVTb3pSMUlFUkRsTmYwODRkVmMvdlNo?=
 =?utf-8?B?eDk3b3Z5eUpNSng1dkR4RzZHN3A5dzJ5d3R3TldxZU0xc0xrQm1FVVZzR1JS?=
 =?utf-8?B?L2NaRXIzQVFyQ1hBNDhnTk9lTVBTM0xXdG5qQUpCelhYWkI1eXR1MUpHYjBv?=
 =?utf-8?B?cnFPUndrS1BkRm9pS09xVllzRktKcExOVDhmTW9zTkdOVWhKY3Q2NWxhdmNt?=
 =?utf-8?B?M2xnbE5OUWQzTndNQm05SWlhTFU2ZFdkTU5LQ21CT3RJZkdneld3VzB1UXBu?=
 =?utf-8?B?MmNzNW8zVExlL2NESjVZd0NMbytFVWxzKzROdWlEeEl2NGVKZm5pWUJERVlP?=
 =?utf-8?B?QngwUGVPc1lQMUdyeCtEUCtQeXBjUVZrR0svS2RtazZJRlZnR2VybmxiR1lM?=
 =?utf-8?B?QzJIaTRRRThwYzJnQ3hQV3dBdC9UcmR4Yk0zTWJISWw5MWQ1VFZHRlpDeDJR?=
 =?utf-8?B?dUozU0V6THE5dzZGVTI4ZlFLLyt1Y0wzRlNYUmliQWp6MTlwSkI0RFJhZ0pH?=
 =?utf-8?B?eTRPQUtKWm1LUmxmd1Qyd0VBVHdZVVJ0V0plYkdiTDN1WVE3NnNOWE9vZnZU?=
 =?utf-8?B?S3Jxa1NubzZkZFVqOURSU056THh1ekJEeWsxQmNOQmJZb1dnZE1XQXdEZUlt?=
 =?utf-8?B?NzR4SWpQUitWMUR0V04rdjRhaXFaZ25lKzNYbUxsZm01OVRsZVBTQT09?=
X-Exchange-RoutingPolicyChecked: gHobk0G56w9/MoH7DjxjYghu+Pz067Al4KcJdmowNmv6JBdLrH+BSdwybuaf2O8X1SxWyHDtDzQ4rNGv4QKrbyuPS+YLk9LAdDq7EITLax5l6hGgHlR6lh40tBQNP1IrYhN4Nu36Z1XewQ4sGE+6+uHQZG5duPzHE3LVcW2TPD4gVARFMtmd9m7SpRhp2IvjI4GHFtK0k680aOHBwpsRnYdyMWMdZKqb4Cy6gaShVeJK1V0gXNCBAR/spSOgklHu/VrHc6071BqE0wec6D61cd15JU1qYw5dBCnpChMyq/UGbvzep7tcvKgZ35ZDgHS/fTL+FAFZO1VNZpM8+SKNgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a06f79-f815-4adb-4811-08dea0fc91ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 05:52:57.5585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg65h9Au7DRR2mKDTBPSVPbWvcWtBAalU7QXqZPv9XM8gW87n88zOEBD8jyLx6jR+DCWRhcC3XBAQQQsOs6P0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

Hi Jakub

We had some questions regarding events in netlink

1) According to netlink spec, "Events are considered less idiomatic for 
netlink and notifications should be preferred."
Since we currently don't have a response that matches a get operation to 
use notify. Would using an event be acceptable?

2) Is there a way to check if there are subscribers to a group before 
creating the event message?
    Currently the subscriber check happens in 
netlink_broadcast_filtered, but a reviewer suggested we could
    optimize by skipping message creation if there are no subscribers.

Thanks
Riana

On 4/10/2026 11:50 AM, Tauro, Riana wrote:
>
> On 4/9/2026 11:05 AM, Raag Jadav wrote:
>> On Wed, Apr 08, 2026 at 07:59:33PM +0530, Tauro, Riana wrote:
>>> On 3/25/2026 7:01 PM, Raag Jadav wrote:
>>>> On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:
>> ...
>>
>>>>> +Example: Listen to error events
>>>>> +
>>>>> +.. code-block:: bash
>>>>> +
>>>>> +    sudo ynl --family drm_ras --subscribe error-notify
>>>>> +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
>>>> Can we also have error-name and node-name? I'd be pulling my hair off
>>>> if I need to remember all the ids.
>>> Yeah makes sense. We can add the node_name, error_name.
>>> Adding device_name would also be more useful in the event.
>>>
>>> @Rodrigo/@aravind thoughts?
>>>
> I tried adding all parameters, but the event response seems overloaded.
> I think node-name, error-name is not necessary since this will be 
> mostly used
>
> by tools and scripts that get the nodes and error-ids prior to 
> subscribing.
>
> Let me know your thoughts
>
> $ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --subscribe 
> error-notify
>
> {'msg': {'device-name': '0000:03:00.0', 'error-id': 1, 'error-name': 
> 'core-compute', 'node-id': 3, 'node-name': 'uncorrectable-errors'},
>
> 'name': 'error-event'}
>
> {'msg': {'device-name': '0000:04:00.0', 'error-id': 1, 'error-name': 
> 'core-compute', 'node-id': 1, 'node-name': 'uncorrectable-errors'},
>
> 'name': 'error-event'}
>
> Thanks
> Riana
>
>>>
>>>> On that note, I think it'll be good to have them as part of request
>>>> attributes as an alternative to ids (also for existing commands) but
>>>> that can done as a follow up.
>>>>
>>> We cannot use names as alternative because it won't work for 
>>> multiple cards.
>>> example in xe: Suppose there are 2 cards and each has 2 nodes. We 
>>> cannot
>>> query using node_name+error_name.
>>> Also most of the netlink implementations use id's as unique 
>>> identifiers.
>>>
>>> $ sudo ./cli.py --family drm_ras  --dump list-nodes
>>> [{'device-name': 'bdf_1', 'node-id': 0, 'node-name': 
>>> 'correctable-errors',
>>> 'node-type': 'error-counter'},
>>>   {'device-name': 'bdf_1, 'node-id': 1, 'node-name': 
>>> 'uncorrectable-errors',
>>> 'node-type': 'error-counter'},
>>>   {'device-name': 'bdf_2', 'node-id': 2, 'node-name': 
>>> 'correctable-errors',
>>> 'node-type': 'error-counter'},
>>>   {'device-name': 'bdf_2', 'node-id': 3, 'node-name': 
>>> 'uncorrectable-errors',
>>> 'node-type': 'error-counter'}]
>> This means they don't persist the user needs to figures out all the 
>> ids before
>> anything can happen. In device node world we have 
>> /dev/dri/by-path/<bdf> which
>> makes it much easier.
>>
>> Also, I'm not much informed about the history and it's still unclear 
>> to me what
>> problem did netlink solve here that cannot be solved by anything 
>> else? But we're
>> too late for that discussion, and again, not my call.
>>
>>>> Also, what if I have multiple devices with multiple nodes. Do they 
>>>> need
>>>> separate subscription?
>>>>
>>> No, we subscribe only to the group not the nodes. In this case the 
>>> group is
>>> 'error-notify'
>>>
>>> $ sudo ./cli.py --family drm_ras --subscribe error-notify
>>> {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
>>> {'msg': {'error-id': 1, 'node-id': 3}, 'name': 'error-event'}
>> Hm, perhaps I need to spend some time wrapping my head around the new 
>> concept.
>> Let's catch up sometime this week.
>>
>> Raag
