Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83420606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MnVGEGmH;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fKAsFRBb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C4210FEBE;
	Wed, 25 Nov 2026 18:43:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D6510FEA8;
 Wed, 25 Nov 2026 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795632198; x=1827168198;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=QBZH2EvKryGUzbyuLxjwYFH35ZAE2TpT197Ojsz3PLI=;
 b=MnVGEGmH5Fq2UqCZ6fscEK8G6izXrXpRgxi5EOpZvbjuRzRW7ijI8oGQ
 /E0wloHxgfMv78PTn6rka+Unc4daRuXsEdUPNH1waNlxyrQu60fbP/jtJ
 kyPhDY7DfGc+zzmpPM4mDMWAmjUqL2xMdXaB7v9E1ncb1HhpHAiagQwyl
 Cz2AhBGazUfKsFxIglyYvapwrSy+iGS43/edTdJUeBAPUL87/Kq7LUwDP
 LvkfcpfRlVtXkjpGsoqGagvGaDRb4bl4brJdlPBogJarURue3wsPV6Fsa
 AYvfZWVALIiGWO2M5Y5eKi+NQ1qFXn1ZMuOSYWSQmuUjkPloTm3Xs7nJK A==;
X-CSE-ConnectionGUID: GAB1NJVLRDqr6tWCODpl/w==
X-CSE-MsgGUID: Vzh1tv0BRQKonge+Oo/Mww==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4524091"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4524091"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 09:49:02 -0800
X-CSE-ConnectionGUID: 6cF5zsekQKalB0h2herauA==
X-CSE-MsgGUID: fQ+NEnyiRTCFy0vcXPxglA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11816282"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 09:49:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:49:00 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 09:49:00 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 09:49:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ2RMSvOoCFIthEAnIfHlvDm9TZgaaPmBrE8OcEq3U+27kc0XBIdrcbGbdO9TIPB6tW4g9eeu92H8M0kLEl3WgJu8d7j+NIFE31M6mxrFWto4YNgoAn6U+TGVhw3oadtilZRieHeZYSE+cR9g8d4zsAZ0KtBwbrU/k6NYm12vG8k5ssn6DsNPMCIZBXA3YBawDu7eozHJbpWl8lobB28wSU3phAyS9uDubb1kGa7ll2AZ+mvvPbTeRVCgbTM+I9nCjgYfMSllE3VA3htlHBimoDjvNR/XAEWTPU7VDJBUEz5bz/cbrXqBxlxfHCtZK49VY2c/+wpeE44AxIKhw/blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP4jZEhQMh25DBuXhEISF1BkBl06eB+ndOtQBeeNWUs=;
 b=T7K3IBK8f2Ydee3CmaN6nNcHHQwJeLcaNhhupAw9kPiYR9Gh5AxI9GqVApMt1Tntv41UOKLMdcu+EllCw+uKVmHS6c3bTu/SD2H5DV1nIDpk/rG8HAhuxtNkr/zoW4rAks/FIhNgcfunGS85BcP0FvFCZp1kqSpCDQ7Soqc6Xz6L5qLuDArE69W5eS2AgyErkEOVZFOKNIjVLGqSJrMwmrbzzCbg21ATXtUcwS2j4VWtjrADjV3aCsspI25hMPOfYypIuwVKWVU3cMulGfqrta6rMrsXRdGed+OmfZqQz6m63VRgB7Nt9UG11Ii4IBtJPjUuinA5ss2Ng/SyW0JhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP4jZEhQMh25DBuXhEISF1BkBl06eB+ndOtQBeeNWUs=;
 b=fKAsFRBbf9JDbDWzr7qp6EzUEyzDstO1BhRy2ky81NHIIo40IV030yom4rjmw8XUyS8rCK+gaqqkKHn2EQExtCk3hGwQn4lMbnUeQrYBqGDUB7HBgONdSo0uU+Mdj0xpVwfrv8JiLE7Hwt9+eitbtuIg6WjYIF6B44PvY7V4w0U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS4PPF7551E6552.namprd11.prod.outlook.com (2603:10b6:f:fc02::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 17:48:57 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:48:57 +0000
Date: Wed, 25 Nov 2026 09:48:54 -0800
From: Matthew Brost <matthew.brost@intel.com>
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
Subject: [PULL] drm-xe-fixes
Message-ID: <awcfhqYs+sncz2eC@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS4PPF7551E6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e3c148-a342-4f31-954e-08df4b1c6157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261028144727099003|261026140227099003|261022105027099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: pEw0D2ex+WgY3T7gz4VRpuDT+vMeK87YjeLWoLO+wfMexdLo+26kxO9Gz0VNFlirmQKHM81M6rt99y4lWMqroE9ew8QkBvSU3oHb0XqWaKbwi/Ttp9yfztRgjg6jfKr9tddF+0HfU/HEIHL8EC+tGEeA8K+XFFyRFFAcL2bpwXZF25b6sSLatTqQ73nvWr0NfP/tjFJGuT9py+mrsO4CZUMDEYd86zaEPhn+XWE7bNpxbQRapa2U1j+DL2SLBvQ025tLmNyi7trLjAb2We6oPmwJeY9ovHo5AO0PVmGo8FmZO/pd8AjKfaiIEV44FP+hBB5JSePv5KURHnvBKByhET0lWS3PR+b6rQB/tXUkbx/MszbMnAyY3Ik97jHqBal+4bEBeTCWbVEQ8JCHj1yZUyy2qPmJ87NXEG2IVt9taNVhitvwSXJoloQjpjLq998tqESS6/ZL0HrMUVyObuAKXYjksXf0P6tVG61VTuVOAFUTLBAe6ZJ8o4cf+XSffE2QaevPbIpnmM+nmEeDsBlctUHQMbd+EeR+p0RLzwl/obHhmSa6LFdwnAISwtnHE4NXfgzsSK0b4igPhjk9X+yDMyRIvAW/n9DEm8MtUYU+LyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0h5zEtJ436yf5Z2VH3z/oZIrX6249qJxpmjikcCTTvMrXZtr1hQjWnoEkdP?=
 =?us-ascii?Q?itAK8M4AbRD04q3zhCw8WXDlDXspMH46epSHkCAi4nGw1prV62VUhKqma5fP?=
 =?us-ascii?Q?72UlACo4uX58bDC3QKNZ6As0Acf9V5TjaBB0OmM9Eq+HVTKTsOsnRYNS2EC6?=
 =?us-ascii?Q?jQVN1oPgjLoMC+IAQK0/pEvJX6p254l2lInsNN7cOnFD5mpHUuYuiAkrros0?=
 =?us-ascii?Q?flo06QY7sZFPVZ75/FSxoxt1xAaXTQT1r3ZMLkEW3BEwxnY3XGtCzeJlTYXz?=
 =?us-ascii?Q?D7AuwiLNHFPPUdNqk0epi6HHLkXdiflJuepPTUr0CegCCjyKb2vqpkU9/MxC?=
 =?us-ascii?Q?2A1vYOItxXlrqtkcQaaB7il4/vQSjtpUOQ/02iX16FYJTeVAwUzgjfMNbew+?=
 =?us-ascii?Q?5DNXgyoL9QxSSP6/xJpCrPoYJrGwbPyPo78nXsNA9JCo+zmO9dDfiLpvYYO1?=
 =?us-ascii?Q?FtoQiyI1SQkyA20ExLwawCCXBptfjQ3x/U7vWdlFdxDeWxlkeiZr0KPThuqu?=
 =?us-ascii?Q?KZeDtaRSqNZIkGv9YMoMQPT868HWNeWuwttgsvNObQiGy/5byWbaxZ6ZXShd?=
 =?us-ascii?Q?65JmTW2/MQLAXHYsKNXCYMvEPJwGZn+xbmTGXwYqUbOiYvrvl4s8xO6e9NnA?=
 =?us-ascii?Q?RCRThFxZ89iv9pUrePGgFZky//sI5d4RMi3LwEkEYjiH6QsHbN0prI3XW6EV?=
 =?us-ascii?Q?zxM9xMVJFiI0eUbZgd5ZCECJuYTgVxu4q4SRr/RF3SbuQki2JK/nlGjR7224?=
 =?us-ascii?Q?JvxLXM/3uzzxK/wQqrZ6jMtfaDKXODNxtXjGI/a5VztjEgITCnBprTlWj66Q?=
 =?us-ascii?Q?lES4NXMc5fyaiMC/PpKHBhZ4xgfrO6tSSvwBTxMwilGukAZTzzaxYAI/RSVi?=
 =?us-ascii?Q?XD9RIXrrlhgQ21Gs+9TmLi5w34dF1d3OdZ8PuZWh82vB4jR2a4lr7Grd4q62?=
 =?us-ascii?Q?EaH8WND/3C9qAk4TCBFaY/EpAg7jhyCVvXF9CishyWzPtcvleMBNlRA1Cx+3?=
 =?us-ascii?Q?P1slFYrwhLru2qK/IH9bmWNu72D+OXvLdlmbWM5dTrMR+jU7z2tztglE5axW?=
 =?us-ascii?Q?PQNnovP1y+wLlAs/GyJCNYZPCufidrOHRSQMVMezgQkrwLXUpm5oUz4k/DVN?=
 =?us-ascii?Q?FU324axlALnOaDxQtLjRTyQtFHqIUI//55PhXt2GEild/HtsGLjGpvu/5YSw?=
 =?us-ascii?Q?Fsu2bje7Wq8YePl+J1LclaJ9R5Fwa/fIxnrsx/HAq17IRM5JwI70Mwts17Xu?=
 =?us-ascii?Q?e7Pij6gNtEKJe62VzjwoBi9IYDXMtDhY80CjTn8BwRi3CEyxDDyMyAyqqH2S?=
 =?us-ascii?Q?4nH7Wga72Xibcm3pNtnBb/UA/D+gZ1viCkln0edOF4rnghEHIgmTqmRf9ENY?=
 =?us-ascii?Q?K01VzKZ+od6aS9QEVNA+0RuBN/kKa/1nktsM0Z8gdcaYn+IL70Cs0UyKnyNv?=
 =?us-ascii?Q?oHJxWPJwJ+1PM2/K4fEmRuzkvQ8+zLbIjYuLpsmPoIGUrEh83OW3US++Nfyw?=
 =?us-ascii?Q?xtlV54sev90rKjDCuCw9izs3IpSyxSVII0MZdQMEo4BtuUAuFGeJ2rv2iDNl?=
 =?us-ascii?Q?KMeVurGMMvdHb5BlrIva90F4D3dumL6ragW2UpJ03xmcTCasxonavHY4ySQH?=
 =?us-ascii?Q?Z+KLuoIV4r8skG/Q9kqSwCYXpXfEgvUdFQuef5wa9KLpehO23MfEbSE+ePEa?=
 =?us-ascii?Q?D748KJwpmPksiqf/yzPyy20v/o3/wYcJk1ZxsC9TVVU5nM6XQ8ygFPwc3nH7?=
 =?us-ascii?Q?30xWFlJbvwfLK+R3jK9Ofu5ugQguCgM=3D?=
X-Exchange-RoutingPolicyChecked: dNWt1thnvgVk5QQ3IfVvOda6cKXyn67g8HAnaZNnQl8BkNjuhAjZJD5bpv985lhkHGGaIwWGsAGkRW6sUCcPCJ5PNERaYAi7cRtYSH6rJb6TSjM/0yBlezFklcci/N6eK3rOubphD8QIi8g0k83Vnm/oA730mqARbM5BVmQhb+1LKtjL5VfKNJXU1ulLiKxQiK3KtSok6hjUBvETFYIEtZqykdRW7/jHS7SxGdclvAlpYofREiC+VC03mOkLBBPsV8BWq/bZRBsCqgXkWntxY9bEKDal48Z+2zD5ynRalr5cBr7r1+yEkfcbDAccXI2ZkbBWaOaY2gDWmkeQKMEItA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e3c148-a342-4f31-954e-08df4b1c6157
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:48:57.5180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5m/YeZGVhoEAcAAnkB8Fvj/129NI46jcil5iHgyMGCSfD2qvd8zBUZ2kvUPWGOLNx8oZ2B49ZzVLVrCvp4ERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7551E6552
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dave, Sima,

Here is this week's PR for drm-xe-fixes. Only two minor patches this
week.

Matt

drm-xe-fixes-2026-11-25:
Driver Changes:
 - hwmon: Unregister hwmon before the device is unplugged (Rodrigo)
 - Serialize migrate ULLS enter against a pending exit (Fei)
The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-11-25

for you to fetch changes up to 8f3b845bc30b42e25341693313afa7425ed3c7a4:

  drm/xe: Serialize migrate ULLS enter against a pending exit (2026-11-24 06:53:59 -0800)

----------------------------------------------------------------
Driver Changes:
 - hwmon: Unregister hwmon before the device is unplugged (Rodrigo)
 - Serialize migrate ULLS enter against a pending exit (Fei)

----------------------------------------------------------------
Fei Yang (1):
      drm/xe: Serialize migrate ULLS enter against a pending exit

Rodrigo Vivi (1):
      drm/xe/hwmon: Unregister hwmon before the device is unplugged

 drivers/gpu/drm/xe/xe_device.c  |  9 ++++++---
 drivers/gpu/drm/xe/xe_hwmon.c   | 22 +++++++++++++++++++---
 drivers/gpu/drm/xe/xe_hwmon.h   |  2 ++
 drivers/gpu/drm/xe/xe_migrate.c | 15 +++++++++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)
