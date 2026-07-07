Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B07C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FB710E445;
	Tue,  7 Jul 2026 07:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bPuFXFcD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9AA10E47B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783408379; x=1814944379;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VhNtATYYDAmdCKB0d7XFqJOwV0p34YP0V7j70g3scPc=;
 b=bPuFXFcDyGaRZ+B9TE/WnY7zUVWTOzwttJAvLknAWiDIFVT4R7CCH/oj
 oCJeMglfhdLVqD+I1/1pLs9ROjvy7x/UUHJfxMmnYrWMdVNCOQduCJJfL
 t3Zvwx3/Yc4JkfsKHRcB7aLJarl4kYuVZ1DWaeKPJX+0WCGab2wtY6E9K
 Q40cOXE3oBYBbwj2ej3SCsIilkbAT4vZ1jZexTBvpwH+JDdiLvfThHjWP
 QDWVnd4Cdx1puN3bOoOpuNDRfRRcN4DqmX4C+IALVJMHGcsZIP2RGSD3c
 4ML1i95QAkTRYizgRwJNb0dMkCRAIUCB64bJEF4vtTgCZptAoA9vB1hmQ A==;
X-CSE-ConnectionGUID: jcpz/dDjQnaVZNtAsX+EAg==
X-CSE-MsgGUID: J7NtYhqbRfWS6NwAVWYnfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84139411"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84139411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 00:12:58 -0700
X-CSE-ConnectionGUID: 6Vt4tD++QDK1cVVgEtSClA==
X-CSE-MsgGUID: yq+XTg2lR2KOtNMPt0KCKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="278282647"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 00:12:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 00:12:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 00:12:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 00:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjbANxAlB7plTAsDpd/TLC3K9C/9lw0cC14XrpQii82Gn77oSnIiI47tz++coxpTGd40iquLzWDYWVhnAfC9Dg3pSMEo1TjMFYtArAD10UKMLLHXDPoFynNVZmcB9ztibEcB8vhCtaANRx710yrB15NYtl5kRFVPntIWdE7wm1G8xRCCmFRPgyRqHGxPSmpqoOKyABatGSKnKPDldpJZ3hLNm7lpbDz9nXZa7yNcz68iLIDUPpMtsoiyn7ttZ0HmSlvN6zPzbZnR6Nb7ikQv5oKdCgDvCCaTszwtm+MqX6yI5G70x5HLGWrykjsV/0E4AGFWNRK9EzxJoA7DumAGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYCUP4T4ZOUhzefyQrqjNb95nbM1h+2w6cxKbtYDUcQ=;
 b=tA8BMGrYSFbYIQuYrkSAKffLcvxpdjJMvn957zMydTLN6jwR+U9R5DHdj/nlluLENWHTtZLlAQ0spml5y5OdHoekVQMVhi3pizXGzgP84rL4xp6e23dXUochF/2u4NUPD2EOYJL7domt9LyxXD6zklJrpgAPzxbmfroJlGXyWOkecwGZ+MaN8fyLxJccRk8PjGAYAjDm8Fyyb4Vcd5jcui/17nw0o73iIZGMNYowZKtNN6Cs28TrW5QJURFyS0rpO1VrzEDMjwovI78Kiv9d2pZ/HRFmWDEvUDiXtkdTxG3jI0X5dbTtZQPbQEw9gIxJLLQKlVny929f0WkiQN5fHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 07:12:48 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 07:12:48 +0000
Date: Tue, 7 Jul 2026 00:12:46 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 889d347a-f0fb-41e7-1a63-08dedbf726ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|5023799004|4143699003|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 6N5noys2EcLoWZwyTAC9tW3AIhSgJugkDagKnBSkZn8Yg/H87jjNO47KCQtoXoVURtc01IxnKyVKGETIFRBnQYnXew93QX2HoorhY5+HjWGr0336TB3QocSqkSB0UNo8vFgGHNfVA8zo+MJHcW2oZh2YZi25Kx6W0UReA6qPCB+XoUfi/LRe8zt7dCu8FOQVZLckkB8eDB+LG3XhYA9o0UGk9SfalGcyGJ0VIdOHLHr2c/SJXryC7irBKBirXJ8pSXMm0KkyubMqOFTu4GLJnJ41M7ChL0wONiuERI9s87mtGYooTb3w+zcq0Houa+/nsw6qdvMOHdIZoJ1RKtl1jIHT19yb805AuU0M2kGyxWBSHQYOrhVMpI/kvA25R8iyo5+JAnlfWT1EsTfUwTTo7+XyvcK1aZKUi35XOweTiOrEJ657V8HumbuJBzZ4oUUbUYx1ekQVp1SZ3Pif4i5X+OpLWt+kViGBkya641Az5lE8vHekH7JVhGX1hxu29SI80uPPLKbVvFUBkiyB0W5A2cNYfUKJvgptG14ysxmvrcOewwsNAfIgCi9VEJzkibOCYNBWKHGws0xQsRmCZgcPFcxITJy/KDo0kdsszI057tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNiTklDQ0NjTjlaMncvT2F1eEN3WUVHS1pOa2YyWTNSb0tZWjYzZmM3YXpr?=
 =?utf-8?B?UlNUMTF1WnVQVlYycWVYbGx4NFUrN1VyQ3BzMlZtd2RsZU15NU9iZG9IQi9p?=
 =?utf-8?B?cHR6Ky9xb2NPTzhJOHlWZUpRK1ZNa3k4c1VOaFliWmI5UzF1N250NERveDY2?=
 =?utf-8?B?NlFTRzFuY3FSRG43L1dJaDRaUkRxd2xYV1FWY0JxbUxURnkvSng5aGdlNG5i?=
 =?utf-8?B?T0toVitlMnpxRDhEZnQ2UkpBVFV2NGZmWWpqSTVFb3hvbXhMTjZzYUtMNmsz?=
 =?utf-8?B?ZnpVb1dnc1JyRy9DK05HRlg2bVRsK2ZSUTBaKzRZMU80MzNJd0JwZnFDd09T?=
 =?utf-8?B?VjRIb2RiWlpYZFZrZ0lwRXQ1VWtHQmh6cGRndkRJelh2OTE2bVV3Y1lRWlp2?=
 =?utf-8?B?cUw1S3JZSitONzNSZXpVaGh1ZkJmeFVFZkdiUEFkZm00NzZXcTA1UEQwOGdj?=
 =?utf-8?B?eXlLQVBUNFFicFdua3N1YjZNZ0xIUmNEZVRGQW1Mci9UcXVsVUNmczRhaDJJ?=
 =?utf-8?B?allOU0thdVFNZkMrVFZPVVRONTIrdDBoTWk3cTQ0VjJvRXhscFVSZTkxT2FQ?=
 =?utf-8?B?Nm1vTFltNC9NVXB5ZDVOamZnQm0ySkt2dy9MZEJyM3NoWkpySWJCTnYxOGsv?=
 =?utf-8?B?SXZVSGxQWmxpZWpBTFU5bjJlbnhOZGFMcXJTdXhNRklwWnpremZRZjM3aEVr?=
 =?utf-8?B?VnpKUlgyQVpoczRWRDF0RWM5M2lsQllZaXlYTnJ6TzFReVBpY2ZWaEQ1TEV2?=
 =?utf-8?B?bVl0REo0SnZJZTQ4MGUvVzd5aVdPcS9ZbytwRW5sOXdEWllZTVVpSVRiR2VH?=
 =?utf-8?B?dzcwMlBTWEtMUmI2OUlUZWtuei9DMG02ZDZaRTE2YVV0TjV6V3lzL0JOVTlp?=
 =?utf-8?B?NHltWFQ3NUQwVjdxRWdYay9QM05kaHQwUER2ejNnVnBXTCtya0wwV01KaE14?=
 =?utf-8?B?U0U4U2NGVFlEZzdDK2EzQXdTZ3hrcHBLSmNTSG9VbWlwb0kyQkZ6OFRJNDQ5?=
 =?utf-8?B?b0phZzJxM1A2VVdCaUxNTHNYbDQ2S2VhNGREV1NReG9LcGExaGJMWG5VSDk1?=
 =?utf-8?B?WjNPTG9tY1VRYW83M21XYnZOVWpYMk1CWk9FTnVlRFJwRVgrWG92WjJKMFRW?=
 =?utf-8?B?QXhBd2VlRmtIV2tTblFCQysyY0s2YWJ1NFFKNnRycE5nOHFNQ3ZaaXdmL0lQ?=
 =?utf-8?B?NFlOS0E4bWRvZHI4UFZjRENXZDlVc3JnSElDekJPeXZ1bnM1UEFsbk01ZnF2?=
 =?utf-8?B?SUM3MDVwdERrQkYwWEhScHgybDN0eFdJV3VOTXZNejkvQ2hhSUpTb21od09o?=
 =?utf-8?B?QWREOWpaYU1DTEd0TkFwQjhvNzduakVndTdTRi9GZnlkaUJJcWcrTlkyMWdr?=
 =?utf-8?B?dzFmaHJSWmM3elpxS1A0YS9mUldvUGVRd3cwdExjNDU0UXYvbjZ5YS9sbXQ3?=
 =?utf-8?B?SEJtNk1KbmJEcHRadkhMTDd6Z1orMXYwS2wySnpCeG1iV2VYREhCV3lXSXlp?=
 =?utf-8?B?eTlaOVN3Vk9tems1Tkc5UG5FcmRoOTdRNHltU05LblhHcVZ5Y2dJaWZaRGdH?=
 =?utf-8?B?cndzUDh4TWdKeW9Ia2cyRHhDRVRGRGFhRWxlTjdpSnYvRTF2dndxVHM0eTVJ?=
 =?utf-8?B?c1JQd2VZL0VESGNYMk1ZNWlpQUxvbHpmcDVKVU1YVU5lTUtUK1BXdVRpdHkx?=
 =?utf-8?B?RHJYd1RtVVlmMU5JRngzZnd6d0s0ZGJ5RVh0VTBoTklWdnRRUkswa1hQNEww?=
 =?utf-8?B?US9VTTcwcjFNT2E4eW1OanJCZTdZYUk3Y1JERmtPRklUY20vellmN0t2d0dL?=
 =?utf-8?B?b3dIbExES2dBY2UxYVdrZnVuZVNFSUdpeVYwWWg4SmR6MnNoUFQwUDA1UzZC?=
 =?utf-8?B?L2pVSThkUmhYZTJqcld5YS9oTHo1Rzc2R0FzVXl4eVY5UzVLUklaZndCdW1E?=
 =?utf-8?B?V045d2o0bUgrREFoMStCUDRnOUY5Vy9mRjc1UngxZkJGTmFMRTNGUmNueEdK?=
 =?utf-8?B?bzFmYU5RM21SOGZsMDdCZG96ZEdUM1N1NW5XQ210WUQwNXhhUXhRZkZWUGN3?=
 =?utf-8?B?czBwclVtbXhqa1hpMnhJWVMzcXJ1TFRkdXMvSTY3MjNkTkFWVTNteExDa2lD?=
 =?utf-8?B?Q0RTV1FsWWtzR0ZrcmxqSllNek1obEJBQW54U3h3RnZsYVFMTkltZ3pVUDF6?=
 =?utf-8?B?T3JBOWdSZERvYlNacDZrMUdJRVhYTXhaL1J5WDMrT3hQdnZieHZwSXFxR213?=
 =?utf-8?B?aVlnUmVSYUc0N1pTS1lWTnluSmhGWE82UXBnTFNHSDFVOXJSbDcrK1E0QnFl?=
 =?utf-8?B?ajg1OGdmYkwwRjhHQks3YWZCcDJObHQ1R1Q0SkF5elhlTFo2TytrZz09?=
X-Exchange-RoutingPolicyChecked: Vh5JTMxt0ROI9j9kyv82B6yfWX9ENyqcG9E1tmUDQ820v2gQ9zo5/qw4Lkd8fA3ojrguKydHatKJ942aHgEjwITuv/dHA+WoaV/I1K2EbkWuLnajOEjIgsh/QMaYMO94BIZjPEKAh1QMWXvKDc5gsEhfVBzEawPId+FFw/cjwksleM2NcysVt+zIz3HYQVwgg99jEgadgJUS0XI0w8KyfBXSsYx3eu7ZXg2ehX4kPNfKqTMackYmZK+U31y6gB88qzWBOApjy0krjzx28gzm2TsLWQpLfzsy+7mD6bA5mhtgpRXGpLQqxJdxhwGGPRXIW2ko8VgqvFQ0o8W+fFGZIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 889d347a-f0fb-41e7-1a63-08dedbf726ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:12:48.7687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPvYVHpsYSmxsgCxo6fLm9gDFOcOqWsW4jQhubWukeskRV6aYb7p0cbfeRnFgZNwZpLJE+n5OZjB4t22wsC+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
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

On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:
> On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:
> > 
> > On 03/07/2026 10:22, Matthew Brost wrote:
> > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
> > > > The problem statement is explained quite well and succinctly at:
> > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > > 
> > > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > > high-priority DRM client gets latency injected into the GPU submission path due
> > > > to the DRM scheduler use of workqueues.
> > > > 
> > > > This patch series proposes to replace the workqueues with kthread_work and
> > > > priority inheritance to solve this problem.
> > > > 
> > > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > > show a striking improvement:
> > > > 
> > > > 		median	95%	99%
> > > >    before	41us	1.5ms	2.6ms
> > > >     after	15us	19us	24us
> > > 
> > > Can you give more information on these numbers? e.g., What you ran / how
> > > you measured these. It is hard to argue with numbers.
> > 
> > I believe Chia-I observed latency on some production hw/sw and then wrote a
> > synthetic benchmark to test it more easily. Details are in the above linked
> > issue.
> > 
> 
> Thanks, I see this now. Part of the problem, as far as I can tell, is
> that fences are signaled from work items rather than directly from IRQ
> context.
> 
> For example:
> 
> "There is another 2.5 ms of scheduling latency from
> panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
> to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> 
> I assume this is only addressing the scheduling portion of the latency,
> but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
> of the latency appears to be on the signaling side due to the worker
> thread.
> 
> > > > This is obviously really good for preventing compositors from missing frames and
> > > 
> > > Modern compositors do not pass render-job fences to draw jobs as input
> > > dependencies. On Wayland, this functionality is provided by
> > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > > later. SurfaceFlinger has also operated this way for quite some time.
> > > 
> > > The obvious solution for compositors is to submit work directly through
> > > the ioctl (i.e., bypass path in sched) when there are no input
> > > dependencies, which should be the common case. The main exception is
> > > when one of the BOs mapped into the compositor is migrating or otherwise
> > > busy (i.e., a BO has a fence in a kernel dma-resv slot).
> > 
> > You mean the direct submit RFC you floated some time ago? What was the
> > verdict on that one, wasn't it rejected?
> > 
> 
> I had some patches for DRM sched that I never posted. It turned out to
> be a little tricky because of some other quirks in DRM sched, but it was
> still roughly 100 LoC plus an additional lock.
> 

Side note: I quickly rebased DRM DEP here [1] and prototyped some RT
solutions.

I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose between a
workqueue and kthread_work, and to enable FIFO scheduling in [2]. Most
of the details are hidden internally, but I had to make a few small
changes in Xe to support this on the driver side [3].

Putting aside whether or when DRM DEP will land, if DRM sched really
wants FIFO scheduling instead of bypass (the IMO this is somewhat
questionable), I think the approach I took in DRM DEP makes a lot more
sense. I haven't looked into what changes would be required in DRM
sched, though; hopefully it wouldn't be too messy.

Of course, kthreads are now directly exposed to userspace, but this
would be limited to privileged userspace with FIFO scheduling
capabilities, which seems reasonable. Additionally, this approach does
not require the kind of large paradigm shifts proposed by this series.

Matt

[1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/drm-dep-rebase-7-6
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/fdc38e4acefc9327637fd818b5b91fd6b2a6198f?file_path=include%2Fdrm%2Fdrm_dep.h#line_99bf000ae_A178
[3] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/f1483af15747a2d5d73262d2cdfc9b616230c5d9

> DRM dep has this built in without any of that complexity. I'm hoping to
> get around to rebasing it soon, but of course there's always something
> else to work on. Sooner or later, it will get rebased, and Xe will move
> over to it given the latency and power-saving benefits I observed. Given
> power savings, I'd think drivers for ARM based phones would be pretty
> keen on moving over too.
> 
> From an architecture point of view, bypass is the ultimate win because
> the context switch is completely avoided. Again, this is primarily for
> compositor use cases, since they do not wait on fences.
> 
> Also, in general, if Panthor selects PANTHOR_GROUP_PRIORITY_REALTIME, it
> would be very odd to pass in fences. The RT priority then depends on
> other work completing before the RT job can be scheduled, which
> seemingly defeats the purpose of having RT priority in the first place.
> 
> > > > similar. Another good quote for the above issue, explaining the consequence of
> > > > CPU starvation of the submit path, is this:
> > > > 
> > > > """
> > > > As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
> > > > gpu time.
> > > > """
> > > 
> > > More details here?
> > 
> > This just illustrates how long can the workqueue wait for it's slice on the
> > CPU if the cores are loaded with other tasks. In other words, how long since
> > job is runnable to it actually being passed to the GPU.
> > 
> 
> Yes. I do wonder if this is an Android quirk, though. While working on
> some MM-related Android issues, I noticed it has quite a few quirks.
> 
> I've done a lot of profiling around workqueues in Xe (submission, page
> faults, resuming after preempt fences, etc.), and I've seen latency
> spikes of perhaps 10–20 µs, but never anything on the millisecond scale
> on Linux.
> 
> I also recently fixed a workqueue bug [1] that showed up fairly often on
> Android. In that case, workqueues could stop scheduling under the right
> conditions. If I recall correctly, a flush_work() could get the work
> item unstuck. It might be worth looking into whether that helps here.
> 
> [1] https://patchwork.freedesktop.org/series/164199/
> 
> > > > DRM scheduler was originally using kthreads but was converted workqueues due
> > > > desire by xe to create thousands of schedulers. This series also questions
> > > > whether that was needed, given how the submission is serialized by a device
> > > > global lock (per GT, so almost device global). Panthor has a similar situation;
> > > > hence the series contains two patches to move those two to a setup which matches
> > > > the design of those drivers.
> > > > 
> > > > Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> > > > scheduler as a hardware scheduler, where number of instances follow the number
> > > > of hardware blocks instead the number of userspace contexts, are completely
> > > > fine.
> > > > 
> > > > There are use cases however which do currently track the number of userspace
> > > > contexts and which do allow for more parallelism. For those a straight
> > > > kthread_work conversion would be a problem due an explosion in number of
> > > > threads.
> > > > 
> > > > The most direct example is panthor VM bind queue which creates a scheduler per
> > > > userspace context and relies on work queue concurrency management to keep the
> > > > number of threads in check.
> > > > 
> > > > This creates a challenge for the kthread_work conversion. To solve which I for
> > > > now opted to create a trivial round-robin thread pool. For the RFC this is
> > > > limited to four CPU threads and is something which will need to be discussed.
> > > 
> > > 4 CPU threads per device, per drm sched module?
> > 
> > 4 CPU threads per drm_sched_create_concurrent_worker(). So depends on the
> 
> Ugh, that is a pretty ugly API.
> 
> Matt
> 
> > driver how it wants to use it. For xe there are no usages of that, albeit
> > you say single thread is not workable, we can discuss that in the other
> > sub-thread. For panthor this RFC uses that flavour of the worker for the VM
> > bind queues and in that case it is 4 CPU threads per device which handle VM
> > bind requests from all userspace clients.
> > 
> > Regards,
> > 
> > Tvrtko
> > 
> > > 
> > > I have more questions but let's get some clarification first.
> > > 
> > > Matt
> > > 
> > > > Ie. how much parallelsim those really need. The true answer is somewhere between
> > > > "at most the number of active userspace contexts and the number of CPU cores".
> > > > Or it could be less than that, since after all, VM BIND parallelism is
> > > > eventually going to choke on a narrower gate of actual GPU execution. We could
> > > > also allow drivers to pick their number.
> > > > 
> > > > In terms of how I implemented priority inheritance, the most important
> > > > characteristic is that it is temporary. As many userspace clients may be
> > > > submitting to a single DRM scheduler instance, a generic solution is to only
> > > > elevate the submission worker priority while there are active high priority
> > > > submitters. The mechanism is light weight and has a hysteresis built in to avoid
> > > > frequent scheduler operations.
> > > > 
> > > > That's pretty much it for now apart for an important detail that this RFC will
> > > > not build for all drivers! Out of those which directly use the DRM scheduler
> > > > APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
> > > > Others I have not tried to build.
> > > > 
> > > > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Cc: Steven Price <steven.price@arm.com>
> > > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > > Cc: Chia-I Wu <olvaffe@gmail.com>
> > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > > 
> > > > Tvrtko Ursulin (8):
> > > >    drm/panthor: Remove redundant drm_sched_job_cleanup() from the
> > > >      .free_job callback
> > > >    drm/panthor: Use separate workqueue for DRM scheduler
> > > >    drm/sched: Use generic naming for workqueue helpers
> > > >    drm/xe: Convert to per gt scheduler workers
> > > >    drm: Wrap DRM scheduler worker in own abstraction
> > > >    drm/sched: Convert the scheduler job submission to kthread_worker
> > > >    drm/sched: Add ability to change drm_sched_worker priority
> > > >    drm/sched: Notify worker of the entity submission priority
> > > > 
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
> > > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> > > >   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> > > >   drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
> > > >   drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
> > > >   drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
> > > >   drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
> > > >   drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
> > > >   drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
> > > >   drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
> > > >   drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
> > > >   drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
> > > >   drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
> > > >   drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
> > > >   drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
> > > >   drivers/gpu/drm/xe/xe_gt.c                  |   7 +
> > > >   drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
> > > >   drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
> > > >   drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
> > > >   drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
> > > >   include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
> > > >   27 files changed, 551 insertions(+), 134 deletions(-)
> > > > 
> > > > -- 
> > > > 2.54.0
> > 
