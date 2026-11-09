Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A3606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I4c0+oAm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9C710F1C3;
	Mon,  9 Nov 2026 11:38:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0688F10F1B0;
 Mon,  9 Nov 2026 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224303; x=1825760303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=AWykFOyRwtn596R8H/Z/H2jbx68oHLg7L1P0464rj90=;
 b=I4c0+oAmC1CL4kckwzf4mttd6ivaM1vfT5XxuLMuN2DyG7K4xYRJ5N/l
 hnHgkBneYUlPgfzGzOCU/xcV7Op73PsDgYjGHWZyFdDAU/k4Dv4/fb/LZ
 CKtrP19o6QagqTg4unYh5FArykAY5xSLgu48rWFtmoTjaa4iiU2gtz2oj
 Z5XRtI4wZKXY/EeLWbhJeeY8SZHe3TDMjycO0Fmm0vSVBordJTGvqvLNF
 vlweJj9S4H+ggkfAOIuwDn4XPofvBEZpYwQNkHlAmhePN5/ehOkZdJZ/k
 1ELEhMFoKShFKjrT+9FfdP+Q9WSaly7IEPSJu4mpuL81zQcMAI6UwW1Xe Q==;
X-CSE-ConnectionGUID: iwmh/UF8QN+aIUxER9dKHg==
X-CSE-MsgGUID: PHTERh9CQIKVJs5vzOdZXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2938496"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2938496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:22 -0800
X-CSE-ConnectionGUID: eI1dhSBATTm6va60b0WvNg==
X-CSE-MsgGUID: pWSpXtFxTzOsxsMGZe6sYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8282632"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:21 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Enuchqs+TvIS2sfEhxtUbWFRXa6cOZ1/yvXpu0PlB3kk19+m+wsjRrofynLYzUy5yQK/Vz0lNcB60PkRUb0Merp4HKuIYNlyEZ7/zc1KSYaslopmzzm7Q2DkpZWtYSWWLYFflIWYsdMtI0W4dQmo3nVYoi/c9MRtnYGVzaxsB2MNqnfMjKfd+kBmEkE3O7N7Wz83O0KpFV0whyuF00M4BRYanBW1x/ilh8mF2HUjsiJFjlVAYRCpQHGtZgdEHwYKp8wAIqvcXFVulVeFgB2HoLKKTjsnrphY0UZ1iabrqkbVMcdlxF3Lzv2tGjjRvBu4xMIFRedi003h6BrtluvXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/wWy2weJ5qgoK1EzGk6UzIAI8jB7zccSpm/wMP5Sec=;
 b=lEgK/+lUwdkjGk4cGfrds5hoaoaiiInD+Y2KrigyZMvO5epdRpPGXVPILZvHA5sedJow+JvynaojW5FM258nUftJMkYaw4pOlUWxyl6zgbfBQKfjPdx/qJRn1dmhcza+YQju8V0DjpNDfP1DGRY8FTfFID5Tj72chWa8q6Emg0Ffm8KeePfT9htC/pw/cWog/ZPazKxSGixq4crwZBoL6jaa29mfacusJgFJTa2TLblLB528bKn233z1+n/4pGhdKOniXdsipkVRlV/YNh0YsMkMf4t0LfvailzIpTe0piLRp2ae+KKZfnOII08ofipT6mwse1nCsNuKv/n2PAcr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:18 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:18 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 <stable@vger.kernel.org>
Subject: [PATCH v8 3/6] drm/i915/gem: Free sg table on failure to acquire
 second folio
Date: Mon, 9 Nov 2026 11:37:55 +0000
Message-ID: <20261109113758.1491891-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109113758.1491891-1-krzysztof.karas@intel.com>
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0215.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::10) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: bd99ab2d-c3d8-4d67-3adf-08df3e55f36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: j8ith/3MybqaPmsT2VTqxHghp18ju6VG1+Tl21ZY+SOyRXiYS3ARm9MfEmxKPcMXaj3CM4YMiAyAmmERsNWmhWAco4ywq1hLLUm+9+JoK1n7+s4k+r3QZJQm4qruxkHtufzGeUVWlwRQ05KPtWUn7+x5tLC8MujNDAKTS2UgHqgDTr/HeNrSw25n6AxHV2rK7u3kp3NmWTVuCx0Ayv4uc1eED5c6ZrvSLtgdJo/DPGYE2k9mrW7Rl/HueH/fCQUqdw5XlaytWjIPG4n37hhJh4ohAVYkSCcc9X8yXudFxoCul5t1FVEdbrtNp2K5w5FUy/rcyw2h6OBaBEQ9J/RQmppiDY7oxYOuEwzkGYW3KPWaE4xN3kvoT1r0MdJnN/fCsyg2LDttuicR7cL5Xg17IsykhD8wJFb3jcQLKJoVPu/Q/y1whHNmoec1pJzeC5SnmfG31lJTKXwzuAo2MVAsP8bvggOTvW4JWubray1MuwgrjlBH/5QOBW6GNescgyPEllwNFrnBeE/mnW1KnwnXQudnwRkTInhIYHdj4suAt39EgvrdLXB8GXXApCvnw8ifkOR+7gaZP/ldhaBqWTLiYaXZZCq1bnfm+yeBU66oOFROcYYAN7gEBk7UgjC035qGoAKIdifdCG4d0jz9lJBnBGzJojZVkFDcsVm0hYUDyDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGw4i2uHByQ+LP3CTnh/Dd7ukp5+WcbkrGOOhW7fnKHO7Skd54Ce4/t53uQ2?=
 =?us-ascii?Q?j4IUhwm09NX7qXJvlheCAcZMIvA8/5ReMXi4rSJ6qrR8eFZpcojA/nMaTxeR?=
 =?us-ascii?Q?S+un3VutygQJwhsPvnVmZa3MzOjQhC0cDv8JUh4LSNJpUsK5oUKtU09EBPbh?=
 =?us-ascii?Q?rlX0ivI17zzpL7dp7J6VsEcD8FtTqlREfxs5sCwFi/ikcxvcK5o6JrQPfDCo?=
 =?us-ascii?Q?H/QwdRXf27yfR5Acpz/9qfd+Mv0htPBewbCgXp4oPIdKTKZApWfMd5pnevGV?=
 =?us-ascii?Q?JkhBjedS4l0GXQAjOljCgvnJTxkmMHwr67kUr0U/LgnEgVNrqagUx3PduNQU?=
 =?us-ascii?Q?ImK4NN48sGpcjQhBmiaura8C5g98jRvLRdwcs7m7laH8VOlOGwU6y+JbCfi/?=
 =?us-ascii?Q?6atU5XGlCYHlU8hOT2OeJNGPOW01v9LRQDpQQ143vCV8QlxOeXYu1mtlwzV7?=
 =?us-ascii?Q?QTMgbCkuw75J1llD0/QTePvOF5m9lNiq2IVxsbUr/1vi3xbhOstfOo1xQMUf?=
 =?us-ascii?Q?hLkHeRFhZ04ACCFFSsxgSgrogxff4IjnCtvOUhGV97+v2FTXauvh2PMfvkka?=
 =?us-ascii?Q?Bom23SZNMeEqmjLzXVkKAudaoJrk00+zXn4Gz6ACG2edA+5IL2LFic7t3CVg?=
 =?us-ascii?Q?a3ka3F6PMNd2rjrUGvGXzz75339sR2X1tUYs2DrScta7uG8/UpZ9NEEyYOGq?=
 =?us-ascii?Q?eJioUH8Q7iWg9MbnYc1Go+YRX2dRKHZ01UA0s7UO5Jy8ptP+BoLCnbJ4Hfg/?=
 =?us-ascii?Q?YRoGK7bGimwIiSwzzfSQtnJ5FxE3ez5B8nGWQw+qJQY/A8IU1+Swo2BGakWh?=
 =?us-ascii?Q?TWwlaR45FKd4/ITXVCUd9/B0W3Lw5mh+g/n+b0Oguqudwq6KyMzf4IwyuxXe?=
 =?us-ascii?Q?6641UUQYwG68zixE33fBiaJhr9b3zaGr1MKUZcxNEtQ3mL1u6ashzXsQ/z97?=
 =?us-ascii?Q?KsvI1c19iySe1Z/2lgjiLc54peKYiHAsxtiTQHIBPVyvHT3A0S+qsjJ5WTs+?=
 =?us-ascii?Q?9MjUYTLmyldQH2J7Pc6Z7SQvWmRJHxeGpwTRQuKS5SVOZLcexijWfdaPEFN1?=
 =?us-ascii?Q?MpsT0ZmxJCFrHgalzYJcW3NiaURgWKv4j4q+tvyIpNhaRlBw1Gud757q89jT?=
 =?us-ascii?Q?AovGTmMbxuEhaEbLzPBkld2gaWDtZyoFaunw3bs4QeT/l7EYVMYZw7ipKIH7?=
 =?us-ascii?Q?OqOZeJmCqTASNHVjDgdfrNy1p7EAl9moT9yksvXPSmCjIbp0fjIcjnIUayhg?=
 =?us-ascii?Q?wpg6Zku/sRoZGB0XBFKl3q7n6/zUYrhk+PHBGryFLJ1CajkhjRo2afGtYlOg?=
 =?us-ascii?Q?N0sIw7FdumzhLN9Jrvv78ncyXajctbn4nKMXmJ2tcSMPp+imDm8vQ6XRImrT?=
 =?us-ascii?Q?b7Y6pPU7WFO3IAr2gFjvMUupdXpAYfKGUpZCQkTvYbcAoNEVsqMYMSUYgfJJ?=
 =?us-ascii?Q?0uSHZLEDJTzRHlk4o4UHik6HUdcS4lTsHELk2V939RG0gZg79QYLnO1gWhN9?=
 =?us-ascii?Q?0A35a9TAbjtlnPCtckmOcx1zX/hEFeB8z6S64KVLFOIRfuOI9ejnnZHmJmpN?=
 =?us-ascii?Q?obnYwEC/hGO1y8C52eMTWtyqmJGZbWVGzZNFi3l1gZRu5k0LRw0cXA+dQEn0?=
 =?us-ascii?Q?+hPeUq8LaozUqq8xNNNpoSUpglm92k5a/Kcx3bk2BP8Jil5vyizRmGLHihFA?=
 =?us-ascii?Q?nB/OZrYRbNjuJRZRPfKVvKy/q9IHUiL9+nznhCO5kWk9CedJkI5FlXI3yKcx?=
 =?us-ascii?Q?wQfqwOmMrDUCmlMSEiXh/GoKM7+cH3w=3D?=
X-Exchange-RoutingPolicyChecked: rRrtdUTbbueFb9xg7zJEMo8+J7bqKA9Uv7pYJXCwWLLt9Ns1/nSrNuBazihvph62DS8QO3ui1PBGDasDntg3rtlKmiLphyyO09YhnZzHFj0i6IVlW/17ZN4CdDfmA/Es2mmKqCt4w0AGEgjIyqEa5uOY2VbmMZLwOWGMqroOyjXN4xXhiZYtIL1jByXzq64HAyJ4wDNSgvoTQDBxzTERCEEr70l4pbRP3g5kcc2J2HdaNwmgo37QWeB/DLvgTBAam+VHAZQDnN4UjlrzJoSN3uiPXb/AtMDoWZXBFKTFqraZEm9FL+E7tZLGzqDWQk8EohnvS/fY0QBPJ41S5LrsFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd99ab2d-c3d8-4d67-3adf-08df3e55f36d
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:18.9191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qhtPP2e9ioeLYGgU4n7yGEKu5DxUTEd9eRsBJVbRfk5xKNHtdScdi9PflMckem88Jpo2Q2LP1LbfdWTb40KrCHwNjSis9uozXjrOffnQVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
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

We should release folios if the first entry was populated, but
loop failed before sg advanced (st->nents == 1 && sg == st->sgl).

Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index d57b5c67d47b..f4a2a3f34c36 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -204,7 +204,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	return 0;
 err_sg:
 	sg_mark_end(sg);
-	if (sg != st->sgl) {
+	if (st->nents) {
 		shmem_sg_free_table(st, mapping, false, false);
 	} else {
 		mapping_clear_unevictable(mapping);
-- 
2.34.1

