Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30806606A335
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MxV7NM1g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8BE10FB4B;
	Wed,  4 Nov 2026 11:11:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD25810FB53;
 Wed,  4 Nov 2026 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790688; x=1825326688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=U+VGXPYrS7uBuV8AmK8uYxutPwQz4myYhTdCk+fo3SM=;
 b=MxV7NM1gvEzugtMTR9H8kIAhngl67QultZ5wG64xD1Ws03UI4Of3kDnc
 5/O7lvtYR7o2+if1aEKTbn9ClJd9/HM6AjrXW+l/Sf7GXwZNnGXTUvXqj
 Nrr270aV6VeKz8Bx6OGWPviHPB+TiYLx65T30HN2krLLcENzzRIeQys9v
 8ajQHkenzST6JkBlqLt7E6YfoVTV9KMQels5MdeKwl+dfvYUb4ZSAlP5C
 1L7J2HcHq621zAhyf8h+thYnC5XMy/pRgawmCyIU3u2B/gECH4nGMVbbp
 oigpcM/06aPsc9ALDMDGvQcXvRODDzm2t1XU16Lv+hh6s8n3EzXtFrJCr g==;
X-CSE-ConnectionGUID: 0C5SU8ZcSFCpgcKpdDCApQ==
X-CSE-MsgGUID: H5D7qThhQS+NWmLXU+k4fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2415371"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2415371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:27 -0800
X-CSE-ConnectionGUID: c/RmkvP0QwqrqJo6TUQfNA==
X-CSE-MsgGUID: fx3jYu28S6K6P/pw14B7Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6708193"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:11:26 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O80VaBAF4vNubvnKH51TSMP1iBZyD1HSMBbZPiG8huAAt50uWzzsBebT1FK+1EVmzBn0+DAvKjrhi0bqJ1nRm2BFW3oq8R1mAaD501laLxOQmiwuRDxCeeAVG9ncR0y16/ExbsBSJeR0+SqxX2ePHm3vtbBAvhUnds39e+DNRdWkcP7mHNg22Mrm214LcEfoqoUnWt5eGP/vYDq4ZQFbcshax4fR1G6/Dvuf5Dxv2UuFWuTkTJbMV3lTXt7S1nCg++FzMy9OPdn6EvSXxYr8PjV1uqlI3tMc6Zct2xqPz+I+chgEACxtZxN4BeKurUiC256JEJlmCCt+NCo9NGbnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjpeM2KOzRqucw7VCjoSB6G6vsu2fi5GSYH8U+o1Geo=;
 b=a7GQDOkJtk2aEVNo72+qCU8HJ3RKHcUojri0egdscj80X4/U7L+yHSOVjWMff1+9OFhL6j5WV4d38zigKrXiXxSFkbGDz2I73x8kzpUgb/oQEzLNV2pRNoiS7OxVaJLZtNEgMoBwe+TkRKc8NPryzM8JY81pvGteyRQVPmtfRZ9oY7JY5nKAYjMEVHETSIPVvGItPtqgk3ERMW4U3fBGbxOE7ycMrqJk7kMy8OI9Rv7piqiMoX3DmIU0zXok+zYudrLqHiX0kLwUNMn/xXWg7ubkqq3py4AGfFMtjOEepWjNckqwb/iu+ASGyIrUgUDWnge/YiJT1E0Z55OZOTnAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by DS0PR11MB7530.namprd11.prod.outlook.com
 (2603:10b6:8:146::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:11:22 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:21 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 2/6] drm/i915/selftests: Use gt_*/drm_* prints in selftest
 helpers
Date: Wed, 4 Nov 2026 11:11:00 +0000
Message-ID: <20261104111104.946617-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104111104.946617-1-krzysztof.karas@intel.com>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|DS0PR11MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a75e77-3bc2-4d48-336c-08df3a645b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NmkV0rh/InzU6S7b6C6rDz8ESiX1G0BgF5JqLOqG/0adDMzu41QzOylRseCzIw10cjT/1zhNgsd9PfqQ8/hFCybHAkc7mfF9wbV4abpBmR+6ziNo0jrZRlRX4GedExMa1eXjtQALOWowxbPf3hSn10VjOLCu4o3KGNn8nIwS4kQZT67A7FAaBJeqVvzEFqM58Xs0yB//gJlgR8CSkRid2qyvpn5IWOgOBYRRzKW6UsLlGzBbKNyLjovJ4MYLP91qCMU7tiW8H8aESNv0j8b/QWnR5gv4FFJWPRDXsKqNhvXMazX/9c46nKyuEya42HJuKP0ZryrUx8XuW3pd712ntVGvEsayET+yXT5/yOAiuvx/gERRQC+UKwtN66fqYcFtXfsbjEbZe303HnuoQDG0tW0Lfci4C32Od37Ire+NoVNUL8ChWrIQI/gvGfqcssnHm/dDWHy5W2f+ElXp4ZxOBfWe3oAwEYEuqqQh7YqsLqKeXtLS+u22QsEeki+RmOfu72HO+NdXtADa37q9cUE5R43yVY1miMlfeDJOaWBbfPOClH7tomXOwtEliT+pR53Kc5eGzQX2N8ACbBkcmD8r7rh1jn/+j8II00F6x7QRAx3J/VdP5zWgP5MYG8OCpU4uZVv8t4UU2czZzEAKVZ1Mx/cXbHHe8rGxIIPWSkIAAJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V6V6PblbBomqxT6k+VJpSLFwXf6FQ2Ru74XM5zZSFXbTAq0glXtsrweRjF+5?=
 =?us-ascii?Q?mOJqY/LXQyq5elTiXuOjDCCkObwdVYvLfR4f32ce3iZNIWuS3ZCQHSFHSM18?=
 =?us-ascii?Q?bjhizezLyKlr/A+8mNOapRJdPjw3qTgKU4TIU8Flo00VG1oo98iJvLAvNnOK?=
 =?us-ascii?Q?x8wQOgJ6CM3wTmIHdeETiZIDHUNaJvghAYlgtT+otOoSu1qn9FIuwjW5vt6/?=
 =?us-ascii?Q?Hg6REGH7gmrOk2x68UW2s4NKObb8u/w9c4tEhs1fBhNlrfRUIxzRfa9UsC4i?=
 =?us-ascii?Q?wW34LjgJOpVOvikKgo6ShuJse/HKUOPLvAC03SnVEfnQVI9MGrJszj4QGnpI?=
 =?us-ascii?Q?2zwNm32Q7c/oV+JMG2vBZtUbLqVmiNf0RaK8PLmxzqU1iSiFAmgz7jkwMrPG?=
 =?us-ascii?Q?RubSKbzCIzSInJnhX7Zkx1cV4JZ0rEnlmTJL2z2VJjQ2uTgP5WLCgJL41sSf?=
 =?us-ascii?Q?bAy6I3M1G6a0ISr/vPG41DaIy4r+z0fnFYBwkF7JqoDfyPtK7WcAsF9ygF4U?=
 =?us-ascii?Q?REAXMqZ+R4KzkhKw2TeyITbTPKsh5l9vJi9vOzltBNf/f9xR7r9CaVsKJrmp?=
 =?us-ascii?Q?C32g5+JAISymywDNelTN0FI4eWHtO3GeeMWnzR9lcB6Kl7FZXnnJkoFDoZmx?=
 =?us-ascii?Q?F+e0qTGenACnI1ZHx5YIh67FN6273ZKiWDrhEVyu0Yxxrlwa496CmToAHvFh?=
 =?us-ascii?Q?abTT8z7znHggQVHvNLuKNp61yeAHELZAgoVqPMcy9IvG3nPH6vXVQouj0sd6?=
 =?us-ascii?Q?ybcK+qksePKJFT6ZKBF1JtHcmpi1x4aqNU354ZepD2HkNRYbc2Mm9zdmH9IF?=
 =?us-ascii?Q?oTrRFTLaertyVsCN96nBU89/rDAQbNZU72RO7hTWytDvG+V7Ivv0njUNfcR1?=
 =?us-ascii?Q?FEo2b7QCDfGUSzR9gZTNTNCdx1KtIHygZbTvEqWU4uJq9bp66eAJTYwpnbg1?=
 =?us-ascii?Q?7yOk9cbHvo2C3o0anbd/8S5X4MICfMUre5VpupakS2JfMFjAuD/q6+uRNYtq?=
 =?us-ascii?Q?Sw6p0u7M4qfFlXIqQ0APrYYW60mM24PmIFr4XFIT99oUjDE4+HpmQNZ3F6mR?=
 =?us-ascii?Q?cAsnSEnnEV6qUB/u4CD8nd1XEKGkurSYmy9H9xO1Hu+cs/H9lgE6qIGzyYGl?=
 =?us-ascii?Q?0gJ9R5a+ngj309n32JM+pDzItJfh5CyUV5JOxVugbSXc3ElF74r4NSTenW6X?=
 =?us-ascii?Q?+OAYxMV/hOfMGcTcczDrkAWEzS3y4PesYY4qF8RwHf3fZ2j34aMSvXBza2l/?=
 =?us-ascii?Q?sJ28kgpcMGhlWOuN5oQzqHVOwWELdiY/94Mms6eD+p73yAiYPFNemO9DRoan?=
 =?us-ascii?Q?cKUCAwYbkd83Y0sKf0vr9Vsv+4+7qGBNwhCujz5rfGkJFzpz1feeoMlPhg8J?=
 =?us-ascii?Q?JHweKG3abZWGl4dAGe9sDtrmLwY8HCOpLwZet/CZ81dtwanR+Prygw9MNniJ?=
 =?us-ascii?Q?O1YIJ0XoWJplrd0HUGqGrpjY0Bs8bI76YAfUwmpfM1W84ATRIppzXUo6da4K?=
 =?us-ascii?Q?wRLXw/+8XrrSAaq+7jhSV5+ovjjVc88GNSaLWnTOqOv4r9xI7j+yqd71Jhvy?=
 =?us-ascii?Q?X1zNDPLc/S9jetxopebF7LDYR8K5Kh/Y4zvREWrtOZm2M1tOLQHGCauw1MhB?=
 =?us-ascii?Q?kJfmVVCGB+vb7BP5+ZkzzvWya34N3RvQPXl5F/qhDcqZIPGkvddrP31W9/co?=
 =?us-ascii?Q?ga2kap0xP0RHGOnMntBwFR1KoSqjmB+FIt1CAP1aJLM1VLJYs2sAaoqxl5JI?=
 =?us-ascii?Q?OlITGnib8rt9u11eRx/wvv5MFqnGu/o=3D?=
X-Exchange-RoutingPolicyChecked: 2j2aEDwu5Y+xx7ljWK6LcNA67UEZBBJdAgZy7KOQvB11UAgFO7+vzOu0s28FuVWJmSpcZ46Lnt25ZPewZa4vSlwXQx5nENR8bnFcHditL4Lmi9Mz7y3k0ON8xmhvOhjMkbveVZW2lT08+JLQo1c/K/aKJw9K+NZEeeHAzQEBRTF5gjHdCiIkMZ+bZLW7VTDk1M20gGAC6cfsqWlydxuXOI+B0i9I+nrPj1x2x6RQP029ns/i1WDh8lRjpeN1mG4X0/PFH7ZgUCmEKNYxoaVHzGy0tzCFyN/ozgsAK1XSeM9GYa5419mgS8+0VI95MYV+Rx0TQXRGDykU8163cWKSkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a75e77-3bc2-4d48-336c-08df3a645b96
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:21.8180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TZ/4AVsKe0GnjFpws/VWm0IA1x7dFkFnk7zHq5S80sB3i8XlInPQO1uG2cZSEbyPMf4sYOcKrhecjyXyB9x0UMxxcxe/ihNPHnWI25I/fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with both the device and the tile it
came from.

igt_live_test.c and i915_active.c now use drm_* prints: both are
driven by a bare struct drm_i915_private and have no unambiguous
GT to attribute the message to.

For mocked device in mock_gem_device.c use dev_err() instead.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/selftests/i915_active.c         | 12 +++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c      |  4 +++-
 drivers/gpu/drm/i915/selftests/igt_live_test.c       |  6 +++---
 drivers/gpu/drm/i915/selftests/igt_reset.c           |  4 +++-
 .../gpu/drm/i915/selftests/intel_scheduler_helpers.c |  7 +++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c     |  4 +++-
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..79b55df1e71a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -115,7 +115,7 @@ __live_active_setup(struct drm_i915_private *i915)
 			err = i915_active_add_request(&active->base, rq);
 		i915_request_add(rq);
 		if (err) {
-			pr_err("Failed to track active ref!\n");
+			drm_err(&i915->drm, "Failed to track active ref!\n");
 			break;
 		}
 
@@ -124,12 +124,13 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	i915_active_release(&active->base);
 	if (READ_ONCE(active->retired) && count) {
-		pr_err("i915_active retired before submission!\n");
+		drm_err(&i915->drm, "i915_active retired before submission!\n");
 		err = -EINVAL;
 	}
 	if (atomic_read(&active->base.count) != count) {
-		pr_err("i915_active not tracking all requests, found %d, expected %d\n",
-		       atomic_read(&active->base.count), count);
+		drm_err(&i915->drm,
+			"i915_active not tracking all requests, found %d, expected %d\n",
+			atomic_read(&active->base.count), count);
 		err = -EINVAL;
 	}
 
@@ -236,7 +237,8 @@ static int live_active_barrier(void *arg)
 
 	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
 	if (!READ_ONCE(active->retired)) {
-		pr_err("i915_active not retired after flushing barriers!\n");
+		drm_err(&i915->drm,
+			"i915_active not retired after flushing barriers!\n");
 		err = -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
index c383d31d46b0..c59425e7ccae 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -5,6 +5,7 @@
  */
 
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gt_requests.h"
 
 #include "i915_drv.h"
@@ -35,7 +36,8 @@ int igt_flush_test(struct drm_i915_private *i915)
 
 		/* 2x longest preempt timeout, experimentally determined */
 		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
-			pr_err("%pS timed out, cancelling all further testing.\n",
+			gt_err(gt,
+			       "%pS timed out, cancelling all further testing.\n",
 			       __builtin_return_address(0));
 
 			GEM_TRACE("%pS timed out.\n",
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
index 7d41874a49c5..c1fbd98d3164 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
@@ -59,9 +59,9 @@ int igt_live_test_end(struct igt_live_test *t)
 		return -EIO;
 
 	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
-		pr_err("%s(%s): GPU was reset %d times!\n",
-		       t->func, t->name,
-		       i915_reset_count(&i915->gpu_error) - t->reset_global);
+		drm_err(&i915->drm, "%s(%s): GPU was reset %d times!\n",
+			t->func, t->name,
+			i915_reset_count(&i915->gpu_error) - t->reset_global);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
index a2838c65f8a5..6be63451317a 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.c
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
@@ -8,6 +8,7 @@
 
 #include "gt/intel_engine.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 
 #include "../i915_drv.h"
 
@@ -16,7 +17,8 @@ void igt_global_reset_lock(struct intel_gt *gt)
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
+	gt_dbg(gt, "%s: current gpu_error=%08lx\n", __func__,
+	       gt->reset.flags);
 
 	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
 		wait_event(gt->reset.queue,
diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index e14ac0ab1314..2441887e3b28 100644
--- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
+++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
@@ -7,6 +7,7 @@
 
 //#include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
@@ -24,7 +25,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
 	for_each_engine(engine, gt, id)
 		return engine;
 
-	pr_err("No valid engine found!\n");
+	gt_err(gt, "No valid engine found!\n");
 	return NULL;
 }
 
@@ -60,7 +61,9 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 		break;
 
 	default:
-		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
+		gt_err(engine->gt,
+		       "Invalid scheduler policy modification type: %d!\n",
+		       modify_type);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 796c9b070e41..c0dadcd961bb 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -169,7 +169,9 @@ struct drm_i915_private *mock_gem_device(void)
 	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
 				  struct drm_i915_private, drm);
 	if (IS_ERR(i915)) {
-		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
+		dev_err(&pdev->dev,
+			"Failed to allocate mock GEM device: err=%ld\n",
+			PTR_ERR(i915));
 		devres_release_group(&pdev->dev, NULL);
 		put_device(&pdev->dev);
 
-- 
2.34.1

