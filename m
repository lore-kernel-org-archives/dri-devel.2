Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86578606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RDm7ajaB;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=XFKoyhHl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F357510E1C6;
	Mon, 23 Nov 2026 23:34:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D82910E358;
 Mon, 23 Nov 2026 23:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795476831; x=1827012831;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5yE41ScjGGUj4gtqLjGbOn7pymzWgn5cZeE3e5zB6Es=;
 b=RDm7ajaBmJFvR9NaQ0YyS0j2V836PK2Ae34SyppieIICjAHhasIWQ4Ir
 lYqgLqeY+XCN4TKtuS3pcd9kYqJN7X/4bIJLMqpccs0SAbRNWiSyAyCgs
 Pew69RZKbhp7v1DTgzPN6tNkcIKmVHAd0qPk2ALBaSIaUAEMXRN+QloI4
 4BwHI2UsFXgJAH5glBWv0rANNcI+RTmkQeFF6xGfjRNT84gPXBm/ifnmd
 WVylEHnv7PgZ7Ja8ScFm2T28zppVFrq89dR27ZI+IRw1JWnnzKdM7XJtP
 6AaozPQhqKDbi2PSMnAZfjMfNjtBiYVsxu0k0ND5K5hgk9TEFYLGjVEoL w==;
X-CSE-ConnectionGUID: OHlPetlZR2eBE4+f3SbSXA==
X-CSE-MsgGUID: PyJ06pkxSFi1IBI9MKqm7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4194427"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4194427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:50 -0800
X-CSE-ConnectionGUID: RagUE5LoR2Cuk2ewk2/I1g==
X-CSE-MsgGUID: tCjqhlaeQ26szoW0l3tmPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11398718"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:33:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 15:33:49 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:33:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6jpJ+lD/RSqzeN+Hp5zZSj11/ZFo5xHcra9+77CxEIW+6V7dX3OR/WeuT67uyBSLcqEEV3Ier3ExbtAIrFaPM43gayYDcO4g9TL6pSkHzAF3IRm0Z4p7V/MSSqHVBP9c//LjKUtJdmqR0i1AESwi2wW3Jcz6yRT/AcSiEaP+yWzagx3paVpxYOxV3JAmSQIjk8DYSWsggb1qn00eP/AYP8bziDbZlSWdMtc+k3NnNzzILKu5b6GaDj/LAY0JPBnkgY260OBoqGpcOpTt88j8DtgQxMM+MYq6SwlnY/uyhpAt4b5F1LXol4Vp0XZmgbRfEEYTjUhEGq9HKPNiGfInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHrVBXFnAtqcTbz4Krhmmgvt8nbP9F7fVhOVxUcaqvU=;
 b=C6K/L1Oaeetc+Et8jjp51oIu+FdK45Y1HTSLUgFDmbN57MpiuydFmI6SZTqXG9KOewbURmQn16SDdlGzfrtHucXVHHqiuNWBr01o5YeD4NzVEUyfYFQwcRomvuWGWN92ubSosDuwZnb+ygvYL5g2+GNsFAdtmntioiVA5Q1PrskkSPdESd3bIk5LqZuiY5YDGqrzh7No95eBO/qSB2mgef0qAIswWsyK1zasXKSpQ+TFuRk2B9PznOrs1HH9b/nqXvSIdbP5/bfKQFXLKCq5JEP4rTV7pOKE+0xiEk+Zvxkj9pSG6iNRJK8DccLiRa71wzPzs3Vq5Ssj19/7hUudxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHrVBXFnAtqcTbz4Krhmmgvt8nbP9F7fVhOVxUcaqvU=;
 b=XFKoyhHl0i8JJ/pprYSHZFFro2D0aaWHQQmAgOaPlgwx38UXLyY51x691s5XSgQRBiBakz42M5SX6Y4z9Odx8JMYSSyBm6WJWjseSvwCYi6aseraOEd35tm+T1b6APqn35WaQHZDvu+g9vJU66m73ozmsYMaiZrdiKez5Nk+maI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 23:33:45 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 23:33:44 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 2/3] drm/ras: Do not fail an error-counter dump on a skipped
 last ID
Date: Mon, 23 Nov 2026 18:33:28 -0500
Message-ID: <20261123233326.2882114-7-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: aa30bc88-05cd-40f9-b0b0-08df49ba3666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: WGiVu4V1rRDEa1rTWF9X/2C29hshDlTDWRxzBHsrH/YPVev7DCDZnK2xjLjGYRifTofsJKcjGUdEAM28pFCLE4FevoQ3XiLFimgy51pBUwt5UK66J6HNH1xeoMaior/Ib6tvntOaBPbHBmlPl0s2nRzXya73Ht4QrLT2jHBUaeP3hCN4lJI2cJKU57IzDe6QSTH2hDCUsTBU0QeTw77Hg4E9RtrtNAMzyNAGsY1mQZ0ZwhVnUGVwko5+7exT7DpFiwp0SXJZ2QvtraXMGQBsjEVWL5bjE8wqhBNfquro2TVsNTjagK4P3OMdp8ZWTZjnpiSyS+13iQHgnp75bJRJBzTSb0npaiw87qCtCT44CcowL207/xy0uPRula60zxZ3W8Eb7n8Yj5P7KbQoP7itaGDEgCcW5ZxOP44xn+Wk6czR99Jdo5VRu+53A/P4x7x7yNkPIfscQYnriiLU7bLtFu9cmZlVY3iqti662sAMhM8pwekK7shcoBMmhfDMH7NGo+/YSIei99Cq32Ie49MCw83/FUx2ZA9JJYDXpIBBsRXmQzhpE0yiluBo8J2/58fiZF8tMtguwzfcqvn78fF2raAmUpluT5mZfPrAwGGiC6ZY4iK6cUx+wzOoLqN3qaetgLarES70I3TabMQTkF1hzXrsAqGUzsH3SZc7FaQeexs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4vEL+TnY73Bo3VG4mX06b0X0NkBWWbrJetZwnys7bg5J8HoyNYxt7ZWQa2Me?=
 =?us-ascii?Q?QwuWCZTHVDRbsoRUU4coWFiIgC79exytsMnfixm/ZkUnHxd5SL5iavqNmREh?=
 =?us-ascii?Q?6CQsbkEjw873VZfu+eS8Se1qynlbypSMMhozc6/wLMpS+kh9ooAgaYo25Gu4?=
 =?us-ascii?Q?D2aVgDi1o1OWz0UBmYp1PG0jl6ClIrS9uxirM6j4pGjVL3oDuCNixH2uy3nv?=
 =?us-ascii?Q?H0DCDIpsHy5WGs7lFGSNjIV3E2SsEow6djwT9DAHWTq0mTCgpC3XipV/Wxr6?=
 =?us-ascii?Q?u7pzYrRtJcB6NIv5jm9T2hTzSw6w5rTOjqyY9PDp/l+zePKGzwvFX5olrNUs?=
 =?us-ascii?Q?nlpeqgSLju2eHvkk+a2/KeqKzE13AYssiGwM5nt8rIam075Ug3gcfT/HqRRw?=
 =?us-ascii?Q?h4n2U060Z5Gxh26wdGbg9JRn5hV3eWFDxcClzPX/nfei/1SqLA5a0w8o8q6Z?=
 =?us-ascii?Q?yx7IfNgRj1Lnz0MsKeSh4S5WiVK65DeZWaUI6zc4YbazL6aEtioXwYYWbHgj?=
 =?us-ascii?Q?Hg4Cjr/ITaUQv+dxUT0AXm7Zd6Yrzw693YQIAHDJ1MofAo2s8u28W5AeNyrN?=
 =?us-ascii?Q?Savjvdxir5McOyMJnLw4iLUngMr7Rp3kLmamv9DT3psyudC77v7aypcAJ+md?=
 =?us-ascii?Q?31sMBVzRMhJOL30IwyAwJhyIXtegNKBzO7wEVxWB3tlQ2DW4Ka59rY+UpH9F?=
 =?us-ascii?Q?OOsLJatgaXveTDUmDJFzLL/z1XyiWey//HQDtTtzOm42NKL1wSGWhsJsht6z?=
 =?us-ascii?Q?MuNc3l3I0U7PHq5UlyUOQycz9xOMM3CskULAdDIRNvUumnUnyTLP7W1/Jg2e?=
 =?us-ascii?Q?nYDEN8ReiF5FA+WqOAELFJ3AJxD8P5eT1UU55MH2J9jEtbpkc9xJg0ZHKW7u?=
 =?us-ascii?Q?0ZKILephTAkzq/fgByjw0jjOO29vZUZHfjPVbMdhHPMEBSZjTnj/IkB/6jBW?=
 =?us-ascii?Q?WdK3dU8vlk7piAyz17uxQRmYxBbBpW8ldPL/MXqkNvaqS/jmDlh7Hu6BuLf8?=
 =?us-ascii?Q?iwtWu8EHvZ5/ahOeo9GhMrPPEUyILSqimieqsNwvW9XheIwNtIUySA3qIEoz?=
 =?us-ascii?Q?5CER1vqxijVWzTvfM/RjSobDxZFxwB5CtVuDdCcrBftpTnjb9m8Ue78/FYFB?=
 =?us-ascii?Q?3O+2EyEb+IQT31FIS3hKLrR+Qd+lrm9lBPnN17G0dPsG/2zKwLKMvfJEKz33?=
 =?us-ascii?Q?y51yrFA7ryrBpSbSgSvOg/22H9CGDpfZs5Ff1KlP2VESduoKHamnbYchG1eD?=
 =?us-ascii?Q?8yLhX8XaXa7BcEkmNGWzmWr8FzVVaZG+A2CCkLZQwbbcjrdbYvafkHIss+6Z?=
 =?us-ascii?Q?xjpUMVIJHdZisCLvEIlbmAnqIPDdfUUfya0KLnOht90y5J08p/CrVxcSasQK?=
 =?us-ascii?Q?nXyBGRfnUyPQ7ErLi/sjSmaWYcex+GgkUzXDaMNHvrPBWTVvnh9zyi0drTXx?=
 =?us-ascii?Q?OiAg/u6ixzN8VXvfz/ZTEingD5TWmSIbWv+ypXrPze4g0C/b5AXUrGFZnVLU?=
 =?us-ascii?Q?H9pZtwHjviTzg1nSSKaZdTcNBbrRj60tnFBRvidVjca3qo+CNhICbpchu7bx?=
 =?us-ascii?Q?+r8iv7QeYeMk3t0AsZYOprdPVaDvtl02iQSc/vwzTfs97E1yE8QjUcn2OKyq?=
 =?us-ascii?Q?RvetbT/OlDtNOTW6a+ma+CAUDC4Oy5sseVMBX8QsTfrYatvZjsk/yla3oBXP?=
 =?us-ascii?Q?YZE2HskDY2PD0crY9PYd3sMaGLeMHrfx8J8mrJvpdJMReV70uW9i2j2oQ16z?=
 =?us-ascii?Q?URDUgpI1yg=3D=3D?=
X-Exchange-RoutingPolicyChecked: h78gr+JOF8udBiH3mrRUyVzeCTtaeAgtf5psqN3oqfGGZJDPUG63pE+Go8atADPhPJ3WjgytnJCpGe3OpempmdABaCq9ODcr+M56HisxVP+7oSLrUjO7BiYWxFdWKs5XWeah64SbsH48e1r5oSVImOPvhMMWMDS7NTw8CObVT4aiqMzqmtFBA+l5hkcEmTMFch4TYd4l/ZfT/P+/IRa686cxlq49EqORo4nzH1pbqQf1IcB8OgRCavL+6C4H27UQ4JqSbFnJqM/szmdeTBpVObSBUIMInJVUf7573eRtvUry9+PN5X+K3JH9NuCgMgJGvYrTqPHWgGocLv1aaWuX4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa30bc88-05cd-40f9-b0b0-08df49ba3666
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:33:43.7408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV53r+p4mM0N0/X1oFP8F0Hp4hd3AMVoED4SCo0h90oAd/Lkqyfdnky57tklBH2dfg/h+D+cQu/Il8ioqF6GtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_ras_nl_get_error_counter_dumpit() skips the IDs the driver reports
as -ENOENT, but keeps that value in ret. If the last ID of the range is
skipped, a complete dump then fails with -ENOENT.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 4f4777060a4e..f561604e7e96 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -475,8 +475,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 		 * For non-contiguous range, driver return -ENOENT as indication
 		 * to skip this ID when listing all errors.
 		 */
-		if (ret == -ENOENT)
+		if (ret == -ENOENT) {
+			ret = 0;
 			continue;
+		}
 		if (ret)
 			return ret;
 
-- 
2.56.0

