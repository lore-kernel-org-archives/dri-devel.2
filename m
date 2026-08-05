Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A2CC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06AD10E212;
	Wed,  5 Aug 2026 09:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U2FcVRW5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A6B10E212
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785923431; x=1817459431;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=zKxLuAiLrS5nVgzc2tU5LlJq8tZammeXnfmt55hO/co=;
 b=U2FcVRW5p82NNRfyYnou4yUDaa8gJsMsD4Sp+So76492f0jQFMkjhGZh
 2fXNFMsfE4gTVrDtGtsReIBSi5GOKhZEYz39h/AYzIi5GIti2a2AfInvm
 scxCzB3VyvzMEPSxk86pkDegoRhwu6AgOJK1dhgavoDFJKXU+b8b27i/K
 lLYDhKVL4tEymWUidURPdxuPm/AX9zr9lWTgPa3i3wszZyViKgqIKlTcs
 sGsV8McdCK6Ue+Jb9z7Q0GgZBvN4YYhdjfbnyd3sUzu5UXKoNGTwqhqAv
 hF6jtdQi0QZeSeIGZlh0jeNdgzl1Fnz99hXammG7nyCMZaA1CkOMDm76W g==;
X-CSE-ConnectionGUID: lgYRtjOxQVizKFF7vy0vmw==
X-CSE-MsgGUID: X5TC2Jo6T8CTm2k27FgPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97086953"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="97086953"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:50:04 -0700
X-CSE-ConnectionGUID: nnlpkUJhTaWhHtk00Bv90Q==
X-CSE-MsgGUID: LUauTdwISbCnZM+kvlp3eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265602467"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:50:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:50:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 02:50:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYwXQ2ynXaEalN1Hfv9Q5DsT+y0+SFBQya5TURtPCsJ037X00QQqdVgpGS7txL5ZkGNAB4ybVcEvn2A/4VA0arjlstG0bUoarqf5mTL2XtCR5suVLFzb3YTj/Opp32wvCJSIgaKk23HGmGvgGrkLOXEMwW7dda2O9bGikKkQNzrRlDXocFxZv95jjZSlrYPxqwj4mF3GwiiWrumfTEt+5VaZNzpAtOnSLu/zhei3WnzET0xwBc/kfwo4jvFu9QUpptF8r9Kk9N0E5/pz6J+diDhdwug4vXy/7RR30H3/2t+o0eOsPhmyWf40mzu2wVXa+fcrAbl1N9mw3vk+7CG94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJ5AMkVQVjlHf25YsdtEVpuAqsahcZQWvp1XiW6EPRg=;
 b=ew8EYBRyyygOIA7bX9jIqjvgmzK9fKHZGXVKzSccxiazR/A0hdqEc8gmIviYcmB+Jtp8ARXJxzbNgf0nYF7RW1HBfEcH0Wb4Cnyg13HDvA9hbxH+AgT5S+GerO7V90zHU40i60P4gEUn/hSjiRcpmVJSP29+2GWu3bUj4OFDK5kt49tCuaQW3YT4yyfcDepBHinm46mZnnMGnEdDSteCb3X7aGR0aXkvi45P6jI91k/fe664cNgyyOWl6wXCUtpRzLN0Eo2qecpqtF/y7+g4M7gM8haEvQC3RVh6OxuBTB1QpH1+rm5U0uKeBNnx5WSustslbz/3LRq7aZCz/SSVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:49:54 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 09:49:54 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro
 <riana.tauro@intel.com>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Add entries for drm_ras
Date: Wed, 5 Aug 2026 05:49:50 -0400
Message-ID: <20260805094949.536651-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH0PR11MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 022d9c25-ccf3-4424-65f4-08def2d6e69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: lYE805QvICdmshon3cTYvLJN/NHKPR58ksnmKUqnyzZ70NihQ9vWCdzcTXVjgRBYYOAuKzT1y9Bhh0ZrcVeM2giiw6oxYZl1+9MoOctmy0wC5xk5XXGfg4RChVmmHOTvYB3G3sMds8/uK3EMpMmodMaUOFGRN9LkqI/GZ3QZKRghgRXMtJXlagrew1s123KwxvU1Yr+BvqKDmEWwub2KmaDbksnKWF5o0vuk/sIiHv+sj5QjDCEVLEzuibNlJzHvyr8zw3Rf6U+gQwX26tS6nFkHd0M87Ph4foaWl8B7sVNOYc7hWy84dvoKzr7OkesZinyDjnFtrA/dKge9TngeV816R36IB4WtKhNk0KOfqh7VzSJKjDeuKDhkbv/xqK5sFlgMqmlXsnPRy0FnKO3AoSToJlszXdU8t9f9MArB1uxdV8QRAZsVU6ejf0Hsrrvm39xvE5VB9brozacyZkXkYlMrsDiZLxSza/q8FJtwjjEizHVN6Wz90dnjR0S/xXRFQB8ZVaSvcMUXHqAciQHxn2zar0y3vh0dyVXnANb2QOE3iTs9VkdIurVeaaWgUF/s8Rx4mUUFly+eFa8UnTWfEzSkzH3Ki+yhoahD7GpWD+NA8kBSS0xmbUK3TLTo5kaROIbzAw+XL9t7gJYqgr9jwglLpu9o/jU1H8yrf6khicI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+Qzv73kOnaOBw1Qp4PB2Mzoq8uhbRReC2TYZ2ri7P4wsCG0UG54bfgUkW/a?=
 =?us-ascii?Q?8Z5EjB/BVrbIk1QWBFxA3HLK3tloiDcmPPIWn+K09dcVoTdvvBBb4Xncp9cg?=
 =?us-ascii?Q?dF5xyk4Y80W7BnRaQziradpiITXaRXsr2zhZk7vCqikpNOVCUBFFJtM1g2lg?=
 =?us-ascii?Q?ljnrSl4/f7D7lq0DebsrRNZVDt9mewDm/YijSSv/uinEBdsczho1qgcCo557?=
 =?us-ascii?Q?HOlTN5zRfF6NxmY3YxIYQcfjktcjIL49w+A09OsgwuzhTYX/6wlSSSheHDsS?=
 =?us-ascii?Q?BIzTfRROyHKXtGzfVFZHgbHwu0Y1mTrXuHaphJ0TK9Ch4yTqrt6rD8NqxdaP?=
 =?us-ascii?Q?5M0NkS7ofeugcrrOp8qZSOPBy+UydFQ1eiq2QyC3OJSQ4hRpAi0lfHMUUeWU?=
 =?us-ascii?Q?5fzmwKPqvF/cvT4KEBpBWk5v8L5iv5RHbLXF8gQ8pCFc/jUmYPKOR/gMUnCT?=
 =?us-ascii?Q?MeB3NyeL3EiVZ9xBCEh5pZWfoCYfLGcWh3J926fMv21DUQ173LSjhMZpEMhR?=
 =?us-ascii?Q?XhShNEe5BZNecgdrM2rou+QalzcZFu31wi1vZwxxb5j4llKb2iawgtQDlayv?=
 =?us-ascii?Q?TXGn8q0bYxO8OWLVa01WAVIGM88NVoMDtQdKVFnSQrUXUXgJzk9KSeeQ4FH8?=
 =?us-ascii?Q?NYTmasEpWc7wvP/qiI6upW+E1HNulOa6lofOilLMed1s58X66kcafGz8jWBQ?=
 =?us-ascii?Q?hBSKgjMa1u94acdCXaw4xhy3KEHkzC7zdKROEtvuOMXz4d2bhR61CqZNEu1Y?=
 =?us-ascii?Q?MGXqmty9iIwXVRkz76iu53bQlYVoZFnptx9z0RikmGUVAnm2y8x9oBf2oSmq?=
 =?us-ascii?Q?R6zT/n9jhF2LZGTSuXeI4jMbq7AWFuTXFyhez3CEhxDbSR1UeP74Mj/WhV32?=
 =?us-ascii?Q?nqiQaAVN/nllG7pxs7l/s6AxpLDJIaxBbBYTFleTCgRe/UR0zVCSNi9CsWf5?=
 =?us-ascii?Q?PnL7X2AkVhbeN+JJMTEEev3DQMsEm/uBE/TNGj/amWoasW+6AKT00+P2r3I7?=
 =?us-ascii?Q?QaGP2C9vQ9GZDsr80ebJFvda7PR7gDjACekHGuMDxMW+uv5hQX/+yHntaWJ/?=
 =?us-ascii?Q?w55EZA8c/D6ZoQIKjOm8KJGRr3TgRQ5JAJroow1L83SG0px9EninvARdVOZG?=
 =?us-ascii?Q?Js+fjyzVpNECItnXxHaN0UVIS5m7mMtrnJuzpqlyQbwkiMDaXDwO7wW61eZ0?=
 =?us-ascii?Q?IYj7TDToHECcZ3o2IhyKgYoejC5GCLmwOilNKv57L79cmmaHYoQ+Ajf2eTWk?=
 =?us-ascii?Q?s3abwpYkNfSY4SJw5lxVXIW49SICmEd96gDmC2wUdDDQQXAuoLuKYmMS2w+4?=
 =?us-ascii?Q?B7C/zH4Nzot3t+ZXvz3K+097WKDGx6xeeiQ8va4Z0ttNpAOiZMJu1RXdw1am?=
 =?us-ascii?Q?dMKUSj7AD+7Pg8IX5vKUVClUNM7YIpnp1oXG+WXYfM16X6r85zis23DCJvoP?=
 =?us-ascii?Q?iOtRYENt2Oz5hH1xA4wgG23iHY3bkPxHxsBWpgr/Uz8cByns/VIxAmqnCCE9?=
 =?us-ascii?Q?MkNea9NAdhc92V4baH/pAh1kCRMUB8bOSxlRVpEExikTBZJbOhdpSqyaR8Cg?=
 =?us-ascii?Q?F4FafrqJxPxyf6QsDf6chOPu9W44e5wCsiMI5TQC5wLjTMGMhEiUnzXx4Nq8?=
 =?us-ascii?Q?Dk4hJUPLkWM0Tam/OVeBzkK7IPqPFj2Vi1bu7xgMcXS2gGMSrsmsF+uWmI5Z?=
 =?us-ascii?Q?fz9qEuiBlSPhY7fcaEjXUe3yCVTDGzl1Upn4mGvkWtlor87h/tvfSVS9Vo0/?=
 =?us-ascii?Q?R/BrXiI+pA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QoF2FXb897nNJajna3bxhRaDRrw5j52x6ZXo4KpUB8cWacVLiKj3ZXXt5ybUnmTEjmvtG0p6TbAToWBqeAgGQiYufG4EncfmYKkoqoFZaBGy7S+2nR+jPwyv+ovROedJHzyepoCTCn7EdW04u0KlRcyCoFIvjfuvBVQ+kBdLm4VPQxb6SwvGkQUknabWn67+bnS1lQaMiVU+h9RvSb3bpJvF9se9mIJ6YFmf8eiOmSgNej/9SdCWv8dKWLd2KSdqXoDzGuNmAkGEqJ4xGZ8n8HwNmVlZMDCND23JXsKXyXkxGE6wp4D0vYBU67tUllQBB9JjfiyYwEPAH5qiNIsLtQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d9c25-ccf3-4424-65f4-08def2d6e69c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:49:54.1024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeiMYsCVJD6WuUXXHEZAyHIP33Pss2qgR3btj+N/2CnayDwJXmMg9QDw8Yli9BY4PMmipNO8sfmI1ef3IQEhXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
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

DRM RAS interface provides a standardized way for GPU/accelerator
drivers to expose error counters and other reliability nodes to
user space via Generic Netlink.

Since this is cross-driver infrastructure carrying its own uAPI, add a
dedicated MAINTAINERS entry covering the implementation, headers,
netlink spec and documentation, maintained through drm-misc.

Cc: Simona Vetter <simona@ffwll.ch>
Cc: David Airlie <airlied@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..51be7ad24528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9039,6 +9039,19 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/drm_privacy_screen*
 F:	include/drm/drm_privacy_screen*
 
+DRM RAS
+M:	Raag Jadav <raag.jadav@intel.com>
+M:	Riana Tauro <riana.tauro@intel.com>
+M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
+R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/netlink/specs/drm_ras.yaml
+F:	Documentation/gpu/drm-ras.rst
+F:	drivers/gpu/drm/drm_ras*
+F:	include/drm/drm_ras*
+
 DRM TTM SUBSYSTEM
 M:	Christian Koenig <christian.koenig@amd.com>
 M:	Huang Rui <ray.huang@amd.com>
-- 
2.55.0

