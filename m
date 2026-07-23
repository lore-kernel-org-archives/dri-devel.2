Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0C8C531F9
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A5A10F180;
	Thu, 23 Jul 2026 16:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MQsCaMK7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918A810F179;
 Thu, 23 Jul 2026 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784824687; x=1816360687;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=iX6xY0SCkOrHhkGnWfZHuJnMcoZY5QlWfK8dUREqDTQ=;
 b=MQsCaMK7oDpxM8XlgjWsxb5rL72/iOpTtZwfQNTqTP1Wlf4THFpVVxTG
 fOr5Ka1XQfZFoq3iR8pk6FfeYP3SFkWC0zAsl/M32IxFF5IYB7aV3Hi9l
 Q17IKtSVyDMyauPF6ZuktomLvyihBSu8LKLJVhbjUWAJfrDvifMrapfVn
 GJED3SG+5J1XkMz/iWZzAbQBNGVhCRhm0uCicl35hY9Tx85ji8yqT7W9L
 cVSRNNnOCojPutWiSolo24KS2IZWehEH42Xs3CMbxjvBnsxdt9kEXHYaS
 6oyCqRfsUR6BL4ib+fhQqbh7OlSIIuqnV4bYDf3PdmqufMVz/OtxMQ9aL A==;
X-CSE-ConnectionGUID: TggMpB3ySN2Oc9iqUfckiQ==
X-CSE-MsgGUID: ZAwQfe23T8qpBJBMM7wF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85246005"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85246005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:38:06 -0700
X-CSE-ConnectionGUID: O1V3z2hzTj2a+lX9DdwgFQ==
X-CSE-MsgGUID: S8isdWLOSYa79iTuF7YmWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262772415"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 09:38:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 09:38:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 09:38:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 09:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maO38zrfqQJhCdzD/j5ylpwjdYGUJaHAu/PlzAjj0MxJy82eV6FAzDx9LzNsOLYaSQ0LpsSV5AcJq3SbWtAh+Au3MJURqE/6ESpZe8/k9fK8UgwD6cuCK99CQCVNxGkTjwZ1KBHMyvqOQbueCJSLRreYwgXoydGJQRrt3IuXawY7cO/fOJdDQ1UBvf4k1PCcuv6shugZI14ne1t2MJFiKACQ4cUlGQSmQyc8Vo9ZZpgcgDOfLoUV4mzm9uaA2heNPfDlJx+mfLpdUoMMh3tcaFBlBAE/xLvMiTPezjMH2XQCGJjaYfnd/e3Qvqi4KLSTXv5VHT19/uqIj/oIVLDH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMNXet/wnQVcB5clN0Y3eJrlgi1gj53iBnELlWbG0VI=;
 b=eKFTW1YCdA3uC6FmvANRNwm+YwowJ1FyoCXRKniUYTmIq16f/IB8Qob0ZzObME52Wy8g+pDlRX9j5FuypB9t1hdYMCW6l/mFNodW+HWYX6B/hBqcHyev8OXwH8YQqcBKn0crCbF3IrCnezrpOHIq9e61s6muFSV/9iB0v+Hm3jD2fshq5+AAdUyZtJw2Zh1NJ9LtSNbB070n0RHVWVQrHVxXa0ZZCLN39Ha/O/yndjQsH89fw2TW0W2Yq8R7Kvtc/rrxyuix9BELgKmtI4ldXhI4ZI+7TsfnjnWd635mt1d5S7c+fZ78pYmbWxhnZvzCW3uu5nk9c423fk6Izlv/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:38:00 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 16:37:59 +0000
Date: Thu, 23 Jul 2026 12:37:49 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-intel-fixes
Message-ID: <amJDXaBKC9uUgRFt@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: YQZPR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::27) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SA2PR11MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6903346a-064e-467b-e434-08dee8d8c18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +kf4jd4EhvRJz5ZJzyvea1SdmzrDtvMIHgwzwCegbzCf+9cvd6OpqcrBjTjyYTRGA1gBu4l6tdEz5wSeCNuq0jdhGpS7xC5qHSGNVak0Crmto1ACegWcxvr9eR+/2cQ2UtuAnb3hEVFc/7N8EBG8wDXNE/b488pJXPUXxUkuDDiqk7lnLZLpnKj2kp+/GtQ1DhI8V/tnHtfSEpFXqbY03u8OlqZB2x/apM7dMOymoImw+iXYJRSWRkBl/5HsGairWVnu8YkKQuAFMXVSY6SaNPpcrQw3U/b2747mg8F/IWqs1F49VxvEwIbIntjoRskctez9UKT+ighvnz0JbCEjW7qrWWCutnrnE3S5CR2s6823f9ZMTh8UsxPn77Qq6k457xygaPo9cDT8OWjdlwGJWzZTyY2B/+DTbcMbZn3OmMEGFEcLB6cV4I+V5G2kEvgjDYC+udqNya8fHF15aNQDozFYiDl5LusozVYEF/3U2xZZ0XAlKCzjgQWUBZIXGltVyn8vgOslnjJeK2sNO8s+ur0a/p+EHwgjy4nHVYqoq8Jvo/baE/PF1FFQI7zz4GPu8fdBSrgQ79lS4ZLTT+NFwjU5p4D9XMhogRBuoQB+fq/CKCaxpEDGqn2b7+PAROWa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFL32F4+jeBwP1i+kNpPfE+XC+oLaoqIgDWTP0QYi+AmDfSRkwhASevBrAdj?=
 =?us-ascii?Q?IrMuTsYGrimXhljSQWFBidWOUzAVqVqdkY4gkkbiqll0MOPqgEL70XWr0akz?=
 =?us-ascii?Q?B+NhuYNCufpItU7282GFZEgB3FseZqjwHk4BduT7GjKqaOEKwDZi8K3rRwuA?=
 =?us-ascii?Q?wM5H62Gx6x0owk0V+Zyhlc658Ug6E2zT7aAnF1H17xRtOIi7PuFeT09KcAGD?=
 =?us-ascii?Q?afnVCuFOoCG9rdup8CAA0eKsVpmjBqCH4j3iG5htyRC07t+Ff50JDXOp3QJs?=
 =?us-ascii?Q?R24WLaOWng/kEskgji0cd0w6pztRI9eTQC5yPuOgOdns2msNWfQo5dr5umGa?=
 =?us-ascii?Q?myTc0eF8xv3nWdlTEXDJ284cdFkn/OzrK1vZyaIEg/1K7BDOX/wPMdudH2Y/?=
 =?us-ascii?Q?pH9rx2sU7KgQWctImnhMsPOwkHGc9pBk1TfHRt0PvK6ZwhvmLuiSIKOOa0KK?=
 =?us-ascii?Q?tXsI53khfEFTueun4cjGFPawyMIoWS071P8RTWUAYG1oP68kRc1kqx3NNfgn?=
 =?us-ascii?Q?Tzg8rjaM3ZlieflXjdgfeNJ/Is4XT5RPWvYxaJOVZrlDawmB9vIpeDpFf/Sg?=
 =?us-ascii?Q?zl5KM1rnS6Hao7TTPXxP+9gPlaNqzWWvRi1uw8vHiM3vXtPcqPu4nP/pYJHY?=
 =?us-ascii?Q?hVFcWDNov5FsTnVFOAOF4D8R8UQyrtVI50XhZC5QQexVjEII/8eyAu7U2UFJ?=
 =?us-ascii?Q?FASDeOMdRcaowADe/FWzC5sL8USluXRARk+rHT/qcvBP6PbBDeqFAn8H5pGH?=
 =?us-ascii?Q?c58lOt7HeTND4eHaB7NYO0rS1YUY9f2AXFHFtPqWnxVD2JpMq6HKNkRcpvQQ?=
 =?us-ascii?Q?IxY87iCbR4WMIlIrO4a/c5mMpoo4+jnAy3iHABsKry4MCrNVcB6v8j5pMySO?=
 =?us-ascii?Q?eYm9n9nksLRYZRPKIlOZ7SQaDjIS8FNfrsXn5CUFvGaCUaq862KZ2LtgpcqN?=
 =?us-ascii?Q?PnP+u9aDCQY8j7qMTCdqeeoywkWmEVsokCbuA7Ug21FgP3s0yQDMtntIVqx2?=
 =?us-ascii?Q?5xu8436PVLt4jnZzDtg5mAsTG/RF6vJ2+tC/kvjUwhT+oY7eMCoQXaHls/FJ?=
 =?us-ascii?Q?oOVFFJ9YmbCotnHFlwqAMGWecGQaz04R4koslsmxzuIuj5RxYX97glGd8BpT?=
 =?us-ascii?Q?M3yD05OzglFIucdFkcozLzqAl4g6gkIBn9sXfItFfea1aWiAT/siTdKWrm/g?=
 =?us-ascii?Q?H13Nx1/hK6I0ICmlBgrT6CT1LfIpinA7oK25F+cB1vdmAP23V+pRtnmOnIGM?=
 =?us-ascii?Q?89czB7mBkQgbl4a71rp8D85K1m5ynKa258CE/NAbtGXzNeS7aLKHYpHqL5Rd?=
 =?us-ascii?Q?PD601GxhY1Oy1Yt1rEVIyNrcuizWeCNVU27DLuiB1qa2F59SofXAoQ3+62AM?=
 =?us-ascii?Q?9VESjWvY9s0VNqMgbcJD/J9z8g8ZZA4jyYNvMcdcyn01JMmige0gkTkCsFsP?=
 =?us-ascii?Q?lPpGwIg+ArqXX48dNxOrw7HYqIboVb5IOW/LULJoyJTDCsB8Dg9ikRTfhvQs?=
 =?us-ascii?Q?2gt6w1pnTOrx7FIDH+aE5wiFsKQ2YUNCbxB8McVS04CaK5dnO12VVHyZtlJL?=
 =?us-ascii?Q?EomBhbi+p9FpMS9WSWPUd8SJKcc87WlmaY32HPI+R2Kk3Nha/tkRne+YMiN8?=
 =?us-ascii?Q?UsEKkkNZIBsHvqIrmTSyDTJOOYvP77GCNRwWRZWLSk9a1AiOPvI5wgDZGXH4?=
 =?us-ascii?Q?NdjDeCRFMK4FLzj/S8g/+AguwsZhWMftmwLdmhupINhjcxnVEmY0hvVbIlF5?=
 =?us-ascii?Q?t+dLExR4XQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: mNgSbYUY35jMDLu2bRZhqOgx2fHQuHqYqi+Snk6u7YWGbuKFZtrwxODoNQiNnLvwoA0UgeAruxVSM+IBFlmF+H10eAhF1ZxskQvH6eFVPq0EBnlUggY8P2En5rsy4n2ex5kw+KZx2bTA66RAU7VmS+mM1tZ4DZ2RhcCFC3xbd7Qoe9Jf6ZcNqnib8pF2VC4rFafaqwDL0hdVjfyMXpjyk981KOxg9SkObJSld/QxxL2wA9kcKSHSHBqlllAwiXvELPTcNxVMVsqd7dSRWZgxGZbxJtA0h5/VWcJUt4pwqyq71cte5ua3rWMK4PR0pMamVl9YTNTkMVlQTHR30+lAlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6903346a-064e-467b-e434-08dee8d8c18e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:37:59.4467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x04ywtS4aesi3rPGb3yvPow9VsmWkCdkCG+uI/alSamfQC5o5aqrsIS2/yOlDEJIKcvGvMVGqD2WMkvKpY5LQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
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

Hi Dave and Sima,

A single display fix for this round.

Thanks,
Rodrigo.

drm-intel-fixes-2026-07-23:
- Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight (Suraj)
The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-07-23

for you to fetch changes up to a411ea4a87162898d2a0547fdfb721ddb7626be3:

  drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight (2026-07-20 06:30:37 -0400)

----------------------------------------------------------------
- Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight (Suraj)

----------------------------------------------------------------
Suraj Kandpal (1):
      drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight

 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)
