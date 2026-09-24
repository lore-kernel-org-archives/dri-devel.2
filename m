Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07ACC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F28510F5B0;
	Thu, 24 Sep 2026 13:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V3AZlt1L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F21710F583;
 Thu, 24 Sep 2026 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790257263; x=1821793263;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=qRgprxMFTwsw0sG/E9H7/TSxq5mo7Tkwk/XFTLf8wLg=;
 b=V3AZlt1LE8hRUg5iNaBWY6c8YPRHRJFouOZOJC+qtBPXWEfSjNIfODSI
 U6906iupAtTr8iBgVnMQswYax4kJrnFGlD69fRscE+jJQT3w/jNWlFM5q
 stMXuNA3xW9MKZuqbm4ELN/TvvAgwEQ6q6iYY4MDCimN0s+Ea7dq8IvOR
 8uEXQ0LwgJvJuoEQdPrlDQx1S6v0IBRiYL9aI1E5zd27qJem3dxeeLwOh
 eUiWZf6T0CcbrVX+IXYc7P+2RnTK5wEKGPm5Oknax0EOe9FYlE/M71Nsr
 eaby46nC/agiGivCUyxX4bo1IxPJl/Ij3GovHADxiPG2HYHk1Ob9YuMt+ g==;
X-CSE-ConnectionGUID: QEdubCO8R0KMIFDLlrCu/Q==
X-CSE-MsgGUID: nzIRaby0TwKuiwa65oMAsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101606957"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="101606957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:40:59 -0700
X-CSE-ConnectionGUID: MzKIZAbFRAiAzs53dQrTLQ==
X-CSE-MsgGUID: HwJ2l7BvRom2UxmaMANP2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="272615842"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:40:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:40:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 06:40:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYtMKDfhT/0U9l3uTvihjVwfSX6zz+HpHEMBm99koQUGgGQ5KEuQ3FMgC8N7hsCshv1vL8QYhXtuhQ1FJ0tbA9VzqoOl09WiEfHL/TUfz8fFBiSindmUBfVBJu2JocgOqoIIy5O1NUbT9zDFVZ4LXkJMx1bzHHyTxsSUEFGJ9bqUobjlsymbG2G1b1jf8P/A+0ZhfbcZMVTiu93cCvFqUlkZVlmZD4Z1OGgGPaC1L05o7QXnv0ywSRdO8KhjJcRKe1tqBL6E1eSupfsM2G+2BU04msk8gGWsjPwvbV61sdI9nbyJQSjC85K5wMuFhxAY4T1qYIuGjGsboZIDi19mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IM/nQGvxr53t2lZpKnesxWJ50l7P7vpytny7ugVPZc=;
 b=FjTJOE4H1RF6//02flO4b8sWXcpZ7klJt1w46rMji9RJWoejD7TwT1Bxs5FrgyzHFS/24tMe3E+5LSomgbq18DuhtDe265dLWjyoFfCzuhA08547nvmRQioQeHGHrUszEg6PMAOB2C1MIpS7XYfBZz5/PCPnhVMF27o1jiqfQrZHDkOdoR9bjNQ3qRtGUOKd7YSttrMWDL/4V8nwgH+a7ldYUXMvvwnJBMaT0W2ggmRCsFx0UyZCvDTDNUgBGPbD9Dg4YvGWXua/1CwkJUNd9bA5FpUSIDibI252dg5EY0PnKNMtap9J45MSnkTri4aH+iJVQt71VEDRLZLU2QJa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 13:40:52 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:40:51 +0000
Date: Thu, 24 Sep 2026 09:40:33 -0400
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
Subject: [PULL] drm-xe-fixes
Message-ID: <arUoUf9LpsJpJouN@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a1a467-b22a-484e-d4b0-08df1a4172bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: OghF7AkdKm39bTzualWYnsMRWsZUr4jS8nyd8khGrHHSl/XOLgxrp4kgiauOG+z3xnV6+xvfmy+V3JvYROmHRhM2bDG4OWFLcDzbWuO8/X59YKgAZSZ3v/HRh8e8laTrJEIOVMqYNTnt+bZfhDl91LLLxYstb0f84cwr9LsbVo+lNq3p4hkzo/kB8uAP0vryQRzC5gOY8lgcQLFukS6mth31aKsL4erCzQg9bNmCh1g28U6QyJd+zKE1JX4/S7NiM8yi9RwluWpIm7FA1cdrrAC/EES8FPScd4eeL834itKsZz7v5Qd+UYJCznWir4WLxNFMaFg6+u0DgYbJxx9tfSGP/XB19nuaaP8xn0HbUEd7R/jqpaxdjHQgbzxiEiir7xPishME/Php/CVkPfC+GEBBn8pYzMo+/hgP5Oetf/y3yqrpeQigKPwW9VmNwC3WQ1HfFzDIpWTAwV2fG9c9UEuLrn0ZrXFYsActVpGze61xJBTqbYGGaGPQ+m6qPg2MP1j2W6yFbXkxo/JRcigFlmvQ0W/pWXe4hMGxo70Bv845L+q4KxBwEWyvs0StzNlXu/1jrc3GRCkVXAciVmgmUiBuJ0diqXpIl38QxNmkRWiEbezhWCGM31usv0C78i/h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhMenhwNjFsZnNPalNYTkVOaU5QajBUQ2hSbkFFRk43VDdmN1FFSkFBdExF?=
 =?utf-8?B?bTFCZmlmTXBNVjQrb2hqQWUraXlpbGRQc09YNTlWMU0wRUlCZy9ORzViZE1P?=
 =?utf-8?B?aDkxQktMZVp3dDVoWVV3Vk1MRGRmT2VUNFNwc2czb0laMzQwNHdOUlJpVzlK?=
 =?utf-8?B?Nm13QkdPaDJ2ei82T2kyTkpOZzhBRUp3L3RHcUl6Y040WnM2bzlyNHovQ05p?=
 =?utf-8?B?NlZWOWZXanA5eVUyZTJFZkM5ZzFVeHQ2U0Fvdm8rSmtSNzJsZkx4bVdaakFN?=
 =?utf-8?B?c2FPNUM2TStZYWdpRU9NRiswQzVRMXd0Y0RnT242c1hNSWk5TjI5NUxBR2w4?=
 =?utf-8?B?aGJsUGhhc0hobE5nQTRlbE9VSm9pUGl0YzhWR0QzSmJPcGtWZWk3SWRBdEJB?=
 =?utf-8?B?dDZnMndSUHFFdHpwNll3dVI4TlZMZFZqMEJvaVZYcWJpNVdnUGszdGdBbDc5?=
 =?utf-8?B?U0tHQWtUaW1mcStDWC9hTC9td1NnTEtOZldCYThCazlXWlFQT3M0Z0hBZzEz?=
 =?utf-8?B?UzBxeFY4VmtDSFBpVHJTd1l1Y0lHZUZYOHVnSC80NEV1YTduRGhpTGk4a1FP?=
 =?utf-8?B?RXNHVm83bDlGTkdVWmJDeUtmaFQ5Rmg3TFdZN3ZDNVo3MnJBSXRCZlNvWVNT?=
 =?utf-8?B?amIxekZ0RVltVDMyUUV2Y1lGTnNCOGcwSS94QTZMdkV6Z1g1dUJEWFZ5djEw?=
 =?utf-8?B?MHNQaGFEVC91TWdvc25XNU5TMVpHc3V1SnpLcG94cXMzTWZvdmlvcmk3NFBV?=
 =?utf-8?B?dlhXaDVmbUpKQTRsR0NtZWFzVC90eURqV2IyeitpeExER29KcTJRU1pRbllK?=
 =?utf-8?B?YlU3REx1RkQrUDV6ZWpNWXg0TXIyWEhtazJPL3dqUEVuajUrd3JmSk8rV1k4?=
 =?utf-8?B?NFgxNENSb2tMNW8xd3o3UUxweFQ1SjBHcGd6QzJmTW5uaU01NDRzUHl0TjMw?=
 =?utf-8?B?YUNUT2ZoZlRjS3o4TndSWG9sMWg2THJEVmV4cTZCZjIrSC9IdEh6WW5GeWhr?=
 =?utf-8?B?ankyM2Y0MGEyMThMdUVZbWh5Q3VJOHhtVGlPeUVvbU51Y1BwYnM5M3l5NTMr?=
 =?utf-8?B?TCtQN1BSUFlQdXBhVSt3eHBvTjcxa0kwbDhtV25wL3N3UFhGOFFiWnVQdlM1?=
 =?utf-8?B?TFVjRzUvTGVndCtQa2pSbW5mMkZLdUNWVWgrckNBc3VTZFhJNURMb2kxdWx2?=
 =?utf-8?B?S1ZHdzJyZXZ4bG9LZDQ1dVRIak1JcnBGQ21LWnFzT1B6dG43VEMxSVQwaGNv?=
 =?utf-8?B?SGJEYzE2ZDhra1dBWG1TbzNOZHpmT2IvejBjVHArWmRORFpLK0kwL29KR1lt?=
 =?utf-8?B?S0ltdGF6L3U3MXlOMmhXOXpFekR1TTUzWndldk9kbmhDVU5nVzI0OW1LelRk?=
 =?utf-8?B?TGdEVSt4bXR5bXZZb3VCc0hjQUVJa3lDSThnaUJiWlZwdCtuZzRWYnc5eiti?=
 =?utf-8?B?OEcxMXVsN002dGg1b1lKOFpCMTB4WDNZL1ZpYVU4R21tM3prMFhZSGo3QUk3?=
 =?utf-8?B?Tm0wSGpFekkzNklzU0JZYjVldkNQNys3ZG1HU0RUNmo3YTQ0U3l1S1FlQmRM?=
 =?utf-8?B?S2JsN3grdzRNQVlpMXZNeWsrbTI0dTVOclp2cFhnckJSZkdhcXVVWmVkVXdn?=
 =?utf-8?B?d2xkL3BFRm1BQTEzZHh2YWwwWXZSaFg3dlh6VEpkdm1zMHFad29Ca0tmMVJ2?=
 =?utf-8?B?UkZZQldIYVE4QWdpNUpMTkhWVi9yYmZnN1VkWHFnUUxpdnlnZmdJMDVldG9F?=
 =?utf-8?B?Y3hhcmNRazh4S3d0em9ZVjVyRXNxSkdkaTNpQktQdGlpVWVRbEpKNjhzY0pK?=
 =?utf-8?B?Y1FEQUh5V1FydjhVZGdEamkzQlpNRHhINDY5b284OGp2anVyQ1hnQUZvN2tU?=
 =?utf-8?B?cnZTUlNvVDZuckJkd0UxVUpwMHNQWGtQem1RRExtYmlidnJYa0t4Mko2T3cw?=
 =?utf-8?B?dGFTM0hjbWdrSWVKa1lDVXhkb1BXQVE0Qm9TblEzSEdKVFdyS29Bc2pKTU9z?=
 =?utf-8?B?NkpqOUUzRWF2cUEycFZ3STJLM3RWcnIvL1FvWUc4czk2SXZOQkM2QmpoYll2?=
 =?utf-8?B?Mm9UMC9XRDRwMjZZc0prMHc4YnVlaXdWeGxWakgybWNUOTVuZXUyblpaWmdO?=
 =?utf-8?B?RnUvMEtBdVJ5WUgzNWo2Zm1qOGRmZkdNWjExZW91VHJxdk5wRlJ2QkYzdE0v?=
 =?utf-8?B?eEdiYWNNNis5QTRhd051c3BNNjhWdVZWNmt1NmtqMXhCWHJyMzQwcThER3Qz?=
 =?utf-8?B?dFlFMWo0VEhRL0Z0blRLVEZuREovT0ZJV2tFV1hhcTJHU1Q4K0wzQkdWMkN1?=
 =?utf-8?B?S1NNRDUrUFhOUVhZNlRjTElCSys1Q0QwQUZiT3AxUUhLcmpOZytndjQyZFNB?=
 =?utf-8?Q?h19V//0+Afr5WaPg=3D?=
X-Exchange-RoutingPolicyChecked: H3KKTAzPv3MJYBDE3w5YT9aCvv0zaBWmiTLb2nPqOnqouElHOv1q88JsonYRZdQ4dRwh9ATa94OFmthiyqJeJB7KSAqxZRdprh2+3oFHgLAFpvx53fcm0jINEmQqiWRLMakIZXfeUNmHIHDdyg1+dcFwEbmnsHqUkGDLxe93AG0R3xGEgrjPtUybd9k1okR0RtKdIfO9gcCVOjNB+GmV8EadTFa1vERHMYDuvsfBw3e9MRlzdrhMwtOQvy/4NlgTXtbvdh/+XVgz0s7pwuWuKzyJrsXBXJeO9eYUzdQxXUEuyiM1LDOC3rrIiQ2h7AOYheJ5piWc+q3QN5ZFUZ/m0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a1a467-b22a-484e-d4b0-08df1a4172bf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:40:51.8107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uA9uecd0fLNOpEY+P9Bk9A74fOVSjdvnponXPv7T2CCW46KbTRdNpF+vTFSs3YVPxYhlYAzIZ0MqkuiTWfgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
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

Here goes our drm-xe-fixes of this round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-09-24:
Fixes in:
 - CRI throttle reasons report (Sk)
 - TLB invalidation at wedge (Shuicheng)
 - SVM eviction and VM close (Brost)
 - Display corruption on LNL on Xen PV (Szymon)
 - W/a fix and addition (Tilak)
The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-09-24

for you to fetch changes up to cc319238e3f6668f867beb381ce93727c69b7317:

  drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms (2026-09-22 15:42:09 -0400)

----------------------------------------------------------------
Fixes in:
 - CRI throttle reasons report (Sk)
 - TLB invalidation at wedge (Shuicheng)
 - SVM eviction and VM close (Brost)
 - Display corruption on LNL on Xen PV (Szymon)
 - W/a fix and addition (Tilak)

----------------------------------------------------------------
Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (1):
      drm/xe: Keep walking on SVM eviction failure

Shuicheng Lin (1):
      drm/xe/tlb_inval: Treat wedged-device invalidations as complete

Sk Anirban (1):
      drm/xe/gt_throttle: Report power brake as a throttle reason on CRI

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Tangudu Tilak Tirumalesh (2):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms

 drivers/gpu/drm/xe/regs/xe_gt_regs.h |  1 +
 drivers/gpu/drm/xe/xe_bo.c           |  7 +++
 drivers/gpu/drm/xe/xe_bo.h           | 19 +++++++
 drivers/gpu/drm/xe/xe_gt_throttle.c  |  5 +-
 drivers/gpu/drm/xe/xe_guc_ads.c      |  2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c    | 96 +++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_tlb_inval.c    |  3 +-
 drivers/gpu/drm/xe/xe_vm.c           | 21 ++++----
 drivers/gpu/drm/xe/xe_wa_oob.rules   |  2 +
 9 files changed, 129 insertions(+), 27 deletions(-)
