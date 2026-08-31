Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2C6C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBEE10EAEB;
	Mon, 31 Aug 2026 20:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L0La43ZQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A26610E6A8;
 Mon, 31 Aug 2026 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788208583; x=1819744583;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Bs5MxDnjMPRKofj8IFN4usfH0+wkJaOWqstwWNE0APo=;
 b=L0La43ZQFbc3Wi2mUl3lIH9kRMShWgIZUA+aUy5y4HCsT0Nlw6mCsxkH
 W4zDVDtMnv1h5sZ4pE7GxcvNCf2pDSO/JvV/luNryt3qfSqBUpVeoMXBH
 iRTjQIs0y8EZy9V6jpsaZCznXKAOCvQFk/ANKqPVbtphN6iFAgpeA1vWN
 3v4vCtOCgNP9MtkGDrOBe3KiIn9mFj8EkGVY2CvF0LTSxzBescrQ9Bj3u
 3vpyQ+KFajILAgYwta/TO5ndlQYbWep2XSXDx9VYyWyL6U15vfebrggiP
 tR2hUkSe0OaYtLdd+5OgBh45PeyxDLudsBCGuhCF0OaprMYgYCwI5o/ar A==;
X-CSE-ConnectionGUID: CFNtYoPjSU6hX2LRZ703Ug==
X-CSE-MsgGUID: gwucIYT+QiyuP1AgcAHvlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106146341"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="106146341"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:36:23 -0700
X-CSE-ConnectionGUID: x1mDtvvPRPOMOwGwcYDP9g==
X-CSE-MsgGUID: GKfpAkngTpO/Yx5AxhCcog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="267091986"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:36:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:36:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 13:36:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDULuLXrlZ6EsZJJ9Qd7ceAIyq1Bpltnqx9MMuArNJraRvT/Ynap2UNcdoPHd3g837cU9wuIm1gDcg8xZb/jMEwfrzpd2nANOEIO4elDjTkfyD/m36+n9RFKQoOXEcKjKVkXbOJBHDbMQaQsqE/WN/iSRR+krMxFRMP5WW0/xFwPh8uvAr/UbG9TLLYW+oy7mSO+i1YhH94O2PUuh2oesxqElGDtBBmcdVmbz/nKJZT0yQ2eopQObW9H8ZURyzpDodXWRK+F8tP9I64kYOqXnbX02eFje8Igje0Ex5SGNikss+D9plnI77ABP11YwiPcWX1EGrNacIsMp6x+7TWrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVXGdyfVUhYUpu59jHmx1BOmmf8VJXIvtCRDb0dFWM4=;
 b=iuOyJe3DdaiHo6CK7rz3ehXkdedC0tG3Jl3HAKxOR0GVFwjULkfX1hqQuDEoGFIGvXb7jkCNO0ClnOeUXmMwcDIlOTtnlz7kIc5kVDmDRYAmjF98IAKXeApw4T8fOrK+uPy4hZWyXmlP4HTL8GIlAqqgqS3nk4BvWngV1Y7vblolQFJTvR7askL5a16ewr1pMipcWoK/FBJ4yC9gxw0iBAZlJsXWvRIJAQ1gv3mtNvp/Al4ePt+1ntYCugokSk5ItC+XJBBvkmJvDoDybhAuK87Dz/WROB8shNnTbGNo6HN211VwWS6vPUtkYTWRB5KmU8nLQ9HMXW1M/kipNxMSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 20:36:16 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:36:16 +0000
Date: Mon, 31 Aug 2026 13:36:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v6 2/4] drm: Add drm_user_fence helper
Message-ID: <apXlvgjIwe+lj6hb@gsse-cloud1.jf.intel.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831134539.112690-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831134539.112690-3-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: cf54265c-555a-49d6-8204-08df079f8182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pyZ1rWGhT0OL+M/39tMX7KCscjBvdXtFTObUeJf46hk4DLJb+iQROcaJus034G9nFWzIZ3RZzXnEg+yLbX7pilKIVd9K/e1yl5royARcXN6ttd8WmH31BbfFEW/YJ3BL56ucfvgc2e3ybmEvNvbkv5sLNu8Icc4yu4vQ2/ZPJnzxEEaZzP6aYq/QuG695K1PuMmpiwVYd4tIIgN26B684Sp456vHdOSixQn3TZFpf/Qik38wJ9WsmkO7TYKHTZB2PM2I2fUD4et2Lw2goFNl0eKvjQPRRM29aNI/tC9U2zsAlYVZ21BFSPjE/5HNJupsM07ePt+w09QhrdiB1mXXntZ1QsTyrCi8rf47AAomnlOyjHhusTVFzfKKCdSGrj9qwWCWIWA3GS1MMvEhlMz+8EBORsS43xDQwaXOQslAe2kODR30+ftsOxtNYmTcYZ9h125P+XVtoZQ/lR+lu3xMQPXi2bEPDhkAq+inIRLUJMIo59HaOMxAPdSNKkZs8mMJaJ0dJAas7ccJki8aEK9W9XwvyLYazV8mDCcO594Ajj8W84RzVYe5EOxR1UZIG6xgH85Dj8xsa6hBoD72o/zgpkaY70sYonOogYkuR7oB8r9hMkmUE4jLh7kAcTj4FiltD8JoHp+slXqMjbT+nMkDeDKpW3Z+MMKeeyxum3ekrao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDIwNVBQbWhOYlBDNktaY2ZJS3hVUU5rVjVJeFJHb29Oc0RCNldHN25DQVlF?=
 =?utf-8?B?VlFLWFVISEZKOUtxTDRVbEErWEJxekYwV3FEeGJJeVRWajJyTjcraWN2QjZU?=
 =?utf-8?B?N0tFMFRseWZlSGJlTlVVbGdBbklNajE3ZlNrQ2MrMEhEdXV6Q1Axc1NzUXdT?=
 =?utf-8?B?ckZ4WEtPbHdYZTQ2VWFBc1BmNUIrQ2gzWTlVRDc2TFVJNTBBVGJYZ1FsWk5J?=
 =?utf-8?B?Q29VaUdUc3FqY2NzUG1wL0tUMk5oWlZpQXJ5VktnMEJocUp1VDg3YnEwUHJR?=
 =?utf-8?B?eUN6azRlaVVQbjF1dkpBSmZnR0hlZlFxKzNNeXMyODVIVHJUc2tZTlNtSXlE?=
 =?utf-8?B?b3lhWGFMeWpUYTdqL3F0LzhyNmR1Q3UySlNmVnBHUkFtSEZ5bldFdG5WVkZH?=
 =?utf-8?B?TlhWQStQZjN0S3A1UnRVWnF2cmFBajV6Y0o4VEQ5SG8wVThSb3A1aXBNWjJp?=
 =?utf-8?B?bnVMUW5mRWhuSDhQUUZ4bG12UVVUN2tyOHRsM05xclkzQ2NlbktScHNYM0pn?=
 =?utf-8?B?em1TTWJFakJQWG5aVERMay9ESGRsUE9VVmpXeEFFckZxRjdMNXVPcFVSVkxi?=
 =?utf-8?B?ZHJadjdFQzQyeUJzd1NlK1JndGRVazljR3E3RUtCVTNva2l1UWU5TFloSTA3?=
 =?utf-8?B?eW1XYm9PNko1V2o2TE9Oejl0azYzT2lyNWlRTitnMmk1Z1BJWHAwak9vdHl0?=
 =?utf-8?B?dlI2bEVSeDFLVDVVMW9hL2dmWm1CVzdkK0xrTm1MZVJTZzFUQng2MDVqTzlV?=
 =?utf-8?B?d1Z5dnJLRFZrSDdnVmlSYnVFa2VWTEV2eWpUd2IybFZIbEZXOTRURXFPVzdr?=
 =?utf-8?B?Qm42QWdncUl6dVZnTzJkbXBBSUpjU3BLbFRBSjFwWFd0bXZSSUZkSlFqa0xQ?=
 =?utf-8?B?WGpoQ3FtVkFUeWxDWk43elJXYk1SSmFjeVYzMTFBWW16cVJ6VHgxNlBhTzFm?=
 =?utf-8?B?OUZTWG9MY3BQRzZreklkcDM0Mld4c0hVRHdXTzRUVWl2WmlnWCtyNWtSN3Rt?=
 =?utf-8?B?S2JhMm5abktEUXdqdGNaeU95OUk0eFlFZlBPNkcvd1BQbGNnOFMwVUtHdmM2?=
 =?utf-8?B?djB4RzQ1eXlVV0RRd2JlcjdyOGNEd3NDOWZaKzRidGFEb2lySVRqdXFjcGcz?=
 =?utf-8?B?eUhkN3pqNVBidFh3ZTZMME9DZmtFb2ljcEUzZ21ZMHREQnZjcWpSUllQR1Bz?=
 =?utf-8?B?ZlZpSXpSVm1XL1d5L3hlUXU5aTBOM3ptd1ZaekhuNWFrbUlBT1dicUJlakFE?=
 =?utf-8?B?Wjd5UzhyazVYVzlOU1dLNkFDZWpUVzhpZ1FzdHpza25UQ0RDSkFCLzJabjZV?=
 =?utf-8?B?Y2RhMHRCbDFWc1JpUXI3SjZpMSt6NU91NUhUanJGMklyTjEvNkV0Y2hqTGha?=
 =?utf-8?B?UFIvUURDdXRKQXF6KzVPNERTTFJlRWt4a0dLcUNmTUhYYkV6ckRGUDE3NTF1?=
 =?utf-8?B?RnZVWnRQem5xeE92VWI2WkhVUitzVTI4ZDdld1Vpd0dqQlFodnE1dzUvVWNj?=
 =?utf-8?B?bHJGRlVWNE96TW1qclBseGxwTjRtOHBzalY3SjVETE0xRGNxYkR2cEFBaGRa?=
 =?utf-8?B?d1BPSlNBa2VPSk9UL3l4akxWUmUzN2Q1NENIWWxtSHowdGdwaXlWZGwrb0VF?=
 =?utf-8?B?VG01VGMveUIzT3MvVk9BQzVpZW9yNEJWTmRmWmh5bkpmYlNrVHMzT1NlazZj?=
 =?utf-8?B?ZzFwSUpCSHJ0ejdYSm43c1hpRjUrQWZZYXRub1FSWkRQY3BwT3NlenJqK0Rz?=
 =?utf-8?B?YndLTDl1Z0F4V293eUFDdnJzQ2NpT3Yzb25MNkh0c1U1WVF1aU1rNTJsem5u?=
 =?utf-8?B?K3hucWh6VHVqVERrdm1EenVscmlYNXNMcE96RVdjR3E5REJnTUExTXpYM094?=
 =?utf-8?B?Z3lNOG96anI5azRZdm12SG16bC9OeFA0Mmp5MTU2OTEyTHJ3MjdsRzkyUmJU?=
 =?utf-8?B?dHljSW1ZL1I4bnBiNXZrRVY5M2FwYy9TdXVhMUtPNXY3aDRCY2tDa0JHVnBv?=
 =?utf-8?B?N0xyQ2hEeUM1MkNJS0I0blU4Y1NaazFwcjE0WGFadGpFbGwxZCtpc1lCKzlW?=
 =?utf-8?B?cVhZUitVRnF6cVp4TUphOHlZTkdBV2MrNUR2OEtrOVZnMHlHWEwxb1c1RlB3?=
 =?utf-8?B?TStRL0JMUTd0UFA2ZzFtTlVmcEFjWElwYXppM0ZDSEhKTlFXSWRBa2VCMktr?=
 =?utf-8?B?dXJkbkQ0ZHA4b2Q4VlpYUXBiVWUwcnN2RmlSMzExditPSitKRG1jSGhBYXdM?=
 =?utf-8?B?eDZzQ2RUQ2VQTzd0K0VLbDBqbnBhY3l2ZUlkNmgya2tnc1Q1elQ0QkhKSWlk?=
 =?utf-8?B?RXVROFp2VkcvcitveXdjYXBmRG1Ia3pvdFNTaDNiRnl0Q3hvdml5Nmo1ZEFx?=
 =?utf-8?Q?0Nw2zzIelgd7nibA=3D?=
X-Exchange-RoutingPolicyChecked: p/qv6+jIixPzOf/flNTJ2dh8o6djgf/2kPLDf6gOLsCDKU6OZga9TGVnONtdVsMyWuD383h7sYQzLC5csCBI8nZ1VbMPo5mjaBx9mmGFRrKvSXSRYSLToCdA7+aWaeb3YVLm0iBxXnRRrgbvJf10SR/BYI07CxjjSp7BwJa4rbtcpbrwDQhvjMg1WKIfrUYNLz9xYWiXI0VLFi9zMQSKCOT3KDNZhOkFACEP5nwuriQThia9Tf4ESE1+y2/E653qZI0CMvTghA5IRpYzvsYncMbYP1tVXF01lKyTvoPtNY4Z4pN31A9kPcIfN+rV2aCTla/7DAunu9DCUZ++Yx35yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf54265c-555a-49d6-8204-08df079f8182
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:36:16.5007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1UAzwzjBwu1cwIdG4KHJITp4ADF0bMpMyHjXR70DNRVGf56jCRHXEPAv4dJ6eSLubTJRUeaiiJjynoT3EGPNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
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

On Mon, Aug 31, 2026 at 07:15:37PM +0530, Srinivasan Shanmugam wrote:
> Introduce a common DRM user fence helper providing the kref-managed,
> MM-borrowing dma-fence-callback-to-workqueue pattern used by drivers
> that must access userspace memory from a kthread context when a GPU
> fence signals.
> 
> XE uses this pattern (xe_sync.c) to write a fence completion value
> to a userspace VA. AMDGPU will use the same pattern to signal a
> per-queue eventfd from a user-queue EOP fence callback.
> 
> The helper provides:
>  - struct drm_user_fence: embeddable base structure
>  - struct drm_user_fence_ops: worker/destroy callbacks
>  - drm_user_fence_init(): initialize and grab the process MM
>  - drm_user_fence_get/put(): reference counting
>  - drm_user_fence_add_callback(): attach to a dma-fence
> 
> The worker callback receives a bool indicating whether the process
> MM was successfully obtained, allowing drivers to handle the
> unavailable-MM case (log, skip the userspace write, etc.) without
> duplicating the mmget/kthread_use_mm/mmput boilerplate.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/Makefile         |  1 +
>  drivers/gpu/drm/drm_user_fence.c | 69 +++++++++++++++++++++++++
>  include/drm/drm_user_fence.h     | 86 ++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_user_fence.c
>  create mode 100644 include/drm/drm_user_fence.h
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index c5be8e80d0c8..ddb770738992 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -69,6 +69,7 @@ drm-y := \
>  	drm_syncobj.o \
>  	drm_sysfs.o \
>  	drm_trace_points.o \
> +	drm_user_fence.o \
>  	drm_vblank.o \
>  	drm_vblank_work.o \
>  	drm_vma_manager.o \
> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
> new file mode 100644
> index 000000000000..664178e2d74c
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2024 The Linux Foundation
> + *
> + * DRM user fence — extends drm_work_fence with kthread_use_mm() support.
> + *
> + * Use this when a GPU fence signals and work needs to access userspace
> + * memory (copy_to_user, fault-able operations) from a kthread context.
> + * For work that does not require userspace memory access, use
> + * drm_work_fence directly.
> + */
> +
> +#include <linux/kthread.h>
> +#include <linux/sched/mm.h>
> +
> +#include <drm/drm_user_fence.h>
> +
> +static void drm_user_fence_do_work(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(wfence, struct drm_user_fence, base);
> +	bool mm_ok = false;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		kthread_use_mm(ufence->mm);
> +		mm_ok = true;
> +	}
> +
> +	ufence->ops->worker(ufence, mm_ok);
> +
> +	if (mm_ok) {
> +		kthread_unuse_mm(ufence->mm);
> +		mmput_async(ufence->mm);

Xe does this incorrectly, but ufence shouldn't be looked after 'worker'.

Also mm_ok probably isn't needed either. I'd write this like:

struct mm_struct *mm = NULL;

if (mmget_not_zero(ufence->mm)) {
	mm = ufence->mm;
	kthread_use_mm(mm);
}

ufence->ops->worker(ufence, !!mm); /* Or just pass in 'mm' */

if (mm) {
	kthread_unuse_mm(mm);
	mmput_async(mm);
}

> +	}
> +}
> +
> +static void drm_user_fence_do_destroy(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =
> +		container_of(wfence, struct drm_user_fence, base);
> +
> +	mmdrop(ufence->mm);
> +	ufence->ops->destroy(ufence);

I'd invert this:

struct mm_struct *mm = ufence->mm;

ufence->ops->destroy(ufence);
mmdrop(mm);

> +}
> +
> +static const struct drm_work_fence_ops drm_user_fence_wf_ops = {
> +	.work    = drm_user_fence_do_work,

I wouldn't use the name 'work' here. I think writeback is more apporiate.

> +	.destroy = drm_user_fence_do_destroy,
> +};
> +
> +/**
> + * drm_user_fence_init - Initialize a user fence
> + * @ufence: user fence to initialize
> + * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
> + * @ops: driver operations
> + *
> + * Must be called from process context with a valid current->mm.
> + * Grabs a reference to current->mm via mmgrab().
> + */
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops)
> +{
> +	drm_work_fence_init(&ufence->base, wq, &drm_user_fence_wf_ops);
> +	ufence->mm = current->mm;
> +	mmgrab(ufence->mm);
> +	ufence->ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_init);
> diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
> new file mode 100644
> index 000000000000..2b2b640f510f
> --- /dev/null
> +++ b/include/drm/drm_user_fence.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2024 The Linux Foundation
> + */
> +
> +#ifndef __DRM_USER_FENCE_H__
> +#define __DRM_USER_FENCE_H__
> +
> +#include <drm/drm_work_fence.h>
> +
> +struct drm_user_fence;
> +
> +/**
> + * struct drm_user_fence_ops - driver callbacks for a DRM user fence
> + */
> +struct drm_user_fence_ops {
> +	/**
> +	 * @worker: Called from workqueue context with the process MM active.
> +	 *
> +	 * If @mm_ok is true, kthread_use_mm() is active and userspace memory
> +	 * (copy_to_user, etc.) may be accessed safely.
> +	 * If @mm_ok is false, the process MM was already gone; the driver
> +	 * should log a warning and skip the userspace write.

I'd wouldn't dicate if caller should log a warning - rather just say if
should skip the userspace write.

> +	 *
> +	 * wake_up() or other post-signal housekeeping should also happen here.
> +	 */
> +	void (*worker)(struct drm_user_fence *ufence, bool mm_ok);
> +
> +	/**
> +	 * @destroy: Called when the last reference is dropped.
> +	 * Free the containing structure here.
> +	 */
> +	void (*destroy)(struct drm_user_fence *ufence);
> +};
> +
> +/**
> + * struct drm_user_fence - DRM user fence with MM borrowing
> + *
> + * Extends drm_work_fence with kthread_use_mm() support for drivers
> + * that need to access userspace memory when a GPU fence signals.
> + * For work that does not need userspace memory access, use
> + * drm_work_fence directly.
> + *
> + * Call drm_user_fence_init() at creation and drm_user_fence_add_callback()
> + * to arm on a dma-fence. Call drm_user_fence_cancel_sync() before teardown.
> + */
> +struct drm_user_fence {
> +	/** @base: Base work fence. Must be first. */
> +	struct drm_work_fence base;
> +	/** @mm: Process MM grabbed at init time. */
> +	struct mm_struct *mm;
> +	/** @ops: Driver operations. */
> +	const struct drm_user_fence_ops *ops;
> +};
> +
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops);
> +

Kernel doc for all the inlines.

Matt

> +static inline void drm_user_fence_get(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_get(&ufence->base);
> +}
> +
> +static inline void drm_user_fence_put(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_put(&ufence->base);
> +}
> +
> +static inline int drm_user_fence_add_callback(struct drm_user_fence *ufence,
> +					      struct dma_fence *fence)
> +{
> +	return drm_work_fence_add_callback(&ufence->base, fence);
> +}
> +
> +static inline bool drm_user_fence_cancel(struct drm_user_fence *ufence)
> +{
> +	return drm_work_fence_cancel(&ufence->base);
> +}
> +
> +static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
> +{
> +	drm_work_fence_cancel_sync(&ufence->base);
> +}
> +
> +#endif /* __DRM_USER_FENCE_H__ */
> -- 
> 2.34.1
> 
