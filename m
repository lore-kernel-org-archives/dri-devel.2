Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE6606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jhs01VOs;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=M48PiXc3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F4E10F2C9;
	Tue, 24 Nov 2026 01:51:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A377110F2C3;
 Tue, 24 Nov 2026 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795485050; x=1827021050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=KwqUsm+nhupl+dsFsDzVO49WFCOr8Bbgdg4TwZNtM3Y=;
 b=jhs01VOszps/ZR1bHfsRgfFHOQEI3qRyWd1QxmspwXx5JuFrh+aytcyf
 tTM1P01/4kvklChND6yi4C+JoKPUde9oq/NNgXGDcIV9EGMHBdszqRQsC
 gFtdIoOIfIbm+1Zc3GDFn0RcmQmzagyRMjS8yPYJaomo5fJyvM99WH0fm
 UGnFiStnyMNN0Xs0EzrS5WKGS4qOzRMjPgLvsJo8RS2hzvWufXSHjpBqD
 ZyCCCPzEVA/H2xUg7zAtfxn4IuF1CDtIVdWTsc7rofBxDLypHYoV6iNyO
 uHbk2LlYJ80EcgHKObWiylexR3Pem2yQcJlPrt1VWWrpS78GgAOhbLK1T w==;
X-CSE-ConnectionGUID: K/gpBSM3QV+s22jp5r+FlQ==
X-CSE-MsgGUID: Y/NgUTuYSN+fyqf/fLaNaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4360267"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4360267"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:50 -0800
X-CSE-ConnectionGUID: GzLuKgwDTyGJ5f1bCkSgUA==
X-CSE-MsgGUID: w8W143BPScysOltIkUpTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11775311"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 17:50:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 17:50:48 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 17:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKjfLZdt1slxjhGaSculd2yoQAO6fHQm/qXThA8ctbYbvbFlbphXor1VJCa3Vu85RSkA1He14uMI5dD7JAXpOR1fS1bbycMiP1UjuuIgy6rEezUaUA+QsFitdng63DQummSZc3SUAA4aHhEFUm8Py5/9njxDuxTgcluJKGeglxui0pdfvtmCckDtdVprBWGEcQTf/qKDIdTjePRqixLToP310Zgsh+scnZz2euaJ9Ju2gAUjMIWtxJuYwdCTk1p5cG/cjFVIWUE1VODVJjPhk+kngU7PRfEEuOMKOlQa35NNMcAWgg0DQzMpDnqPUxGQgCGDskywk8UUTZLC0ksHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgwY4i8NiXHYnXDklCBsnJKc1zx0UJQbm5nY0gI4F4g=;
 b=M8e6uwzAfL2YpMVJ5nPRr/45ZlrTRJ7NaPBQJNbjGzYG7Ih9PzX84xIboAsIIrJgeGlEk1SD8YP/vRqcjZ11RVBqOqbFWV9A0R0SA2tQUukST6bSNlaz1PnCBa1di95qMrp2+TtYSaO3Z6IncIn5P9nutja597ZyHpifhEn2Gj9/HHLPcrcdStb31SKmLoOekULJQuU3VBx4TSkxAQLQKjb+JXUQFMZee/8nxW4ItM8HD1Em2neaAYcB5a9CwLqR9oEU58QSwJ4W52bUWFrCylc9J2A9FQd6U0FoAnehYUTwdKX9T+UoYS+/mHLuLgLJFQbvxnZ4Ku2clC6KJrTcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgwY4i8NiXHYnXDklCBsnJKc1zx0UJQbm5nY0gI4F4g=;
 b=M48PiXc3jK4ABnPM+VSDpGBev6d6wuRExDQ3J1oNXULSeDjzLHCn9g3VxgktX6FlzJxqX8SOmpyRvpc8ZRK8y+yhxvqfwV/cF4KHp4epqjhH+HcCn2UzqqgVjLgEzvjyZLYQ7lqitBH8/XFKUER0qTYBIaqLNm0cj0uyFMXzn8o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 01:50:45 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 01:50:45 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH v2 2/3] drm/ras: Do not fail an error-counter dump on a
 skipped last ID
Date: Mon, 23 Nov 2026 20:50:38 -0500
Message-ID: <20261124015035.3100218-7-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
References: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1ba7e-c9ef-4cb3-4f8f-08df49cd5ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: D0G1MCy+aBLPMsTJPs70y8PHZwFm/sLbPP6tzGvfGNfiXt0GaUQVQnKX9f81dxworMKMUGhdNe9U3K5Dw0vTe87ijDRx1y5O9NeG7cxMc6Sv4zSBdKl+RLM3tLpAWFfQbOkXv4OiU/E+xeKsxod42TAEOLKW5eLE3M9dVDCTWWZq92X36RTFs5DFRjwBcDpKRJ9/zmDUb8O27P7GVjw13nUiCURM6Lfw0/V+3tzPxEMw7eVP3CFitncn6VoCDmrb3TT2mzqKBgajoErnqpfiWkJPzntbcYg0jMzF1Ve3aE8xSOKw4+cRthSlDzkFiF5hTXrcJQT9vLao3xjoS1BrLU2Wy3L3P8LHPkfMWYvNYHRPcKmf+HwCrtC8Xrm19er6PzFLluO1w06T36HaRW2glanRPwyxVFHAyWLXbmf0EJQYXfYK7DBs+alZZB1rx2t1Mik8MMdsBBo9aqJgN3tg6pjXFic0wb1bGY5ae6Myy6fiGNb4ZRqva2pkHcJ/8aOWrHg7EdQwguOsz/Qo3cn0wm1jPg+KrvIBKXd7TMhq/5AKNHR4VMvHFSaPUCXOjRx78t2P/92oJQ1dtgTzNXwOoFDE57y2Jrlmbe369lOQRaTO3L4nU1KruDPG3gjtCMLjKcRgnISB4N8ro0HC+Mw5ZgYAK9ZQvlWzMi+/7FTApw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfhP31/IASMFVlz7q3FxJ6m3EPyY5poxgKosKyuKrSW+SB9Wh85jvT1jxiMS?=
 =?us-ascii?Q?csVytM2syxV5A5IEIs9IC6paA0XPmPBwvq3NOZQ4utgzSKKIAHWXErleq8HH?=
 =?us-ascii?Q?YTJF+2vasUEygGal7xOOKyBfBdPcQIZSfCn4aG1gaXv4qkgRdLdncCZFbkW5?=
 =?us-ascii?Q?N/iSTv8KVkVXkoQbq0TiLkeMW3o7DbGwsibiQ4pjWrC27bGmfkcKftSi5B4Q?=
 =?us-ascii?Q?iVMrYrabFI9ZFoVXiO3KRdDQht23vf9DpJIWqT3SQB+zezmFnExW0TCBKonI?=
 =?us-ascii?Q?IgTtPkJhiSwr1vaE2ZaFp9vT0yCkBlX6EP6mV0wysBvlo7vVQ5UIw7pWSh0s?=
 =?us-ascii?Q?Gs9JhQjNjEvXPqxhdlA26kKZ3cu9QNyxO9W8m7jLr25OqS1XKingouWAWKca?=
 =?us-ascii?Q?3t9FaTqafdOvXLnYt+kgEoEHQSk6C07y7zuJkKDsaPG92deFhLvAjwHnzaEw?=
 =?us-ascii?Q?xuwstcXqdrUQMemLdDuzLRTaYqC7fIkzzfsA+ZX64k7alc2MHpjTU7V13tjs?=
 =?us-ascii?Q?N6oB4mDlDyI+L3GayfPhW1RFr6HMG2hTNa15mAswXsoJkpd/Mn6RAZnr2++a?=
 =?us-ascii?Q?n5nGj07yOl60J02sl0XrZzi4B7HwOv4oTyyiNMVUMRnPowQ37fAT8W7t6C5y?=
 =?us-ascii?Q?BDHyY7ibXKTUlb1zZNOC8exZtzAQ1Twvi27KCihW9rkMLNXDwwXfSFW5AxfM?=
 =?us-ascii?Q?/Lh4xhzgHzPMz3LuwzVyQVL4DcagHCiFjk4GDs/PhuweBfHlrDO3EvQ3vKRL?=
 =?us-ascii?Q?Eg51qNoymZCQ7Ig9K75VQwiVSSl+LZVkAACQd9itXgeeXEl2T2pDaFwIXrZh?=
 =?us-ascii?Q?G8lgY15AUASLyq/HuZgDX4xSzuSXS01k2gsOSr7GoV4MysXBz/30C1W3+VQ1?=
 =?us-ascii?Q?0Cxpo0Ke407tgoaN2LtLHmmJdy23mO4fkX8XabP9GWMs6q1fHNlQd0TfdFAY?=
 =?us-ascii?Q?9PpAEfbzolh5poqzSPzF/PhPHjRNhEsM0nuCGUNY2efWFNVYmBhL1HwXw+iO?=
 =?us-ascii?Q?DySdfUV6PsiGEsoeq7oOPfSd60GT57haPmfPjyF/sggfM7PEFHbv9aXxJLC1?=
 =?us-ascii?Q?+Xr8nTEB0XmqTkb99QjvkqV3J9wwmJA6e0+efgV0CSOTTC6C7RPd9os4aET2?=
 =?us-ascii?Q?pQA2HYA8hd4pgZrbnXOolK+mxB1bu/GOJZhD+P/9rUc6zSMTslzgp8cJoRfv?=
 =?us-ascii?Q?K7zmDh4bVpm54auJLMB6Umo6mf8OvMFAMKaoGul7FCO1py89LsYl8eCrMbkm?=
 =?us-ascii?Q?xDhtUhifNAEnR8FlpdLt9b8PCF6aPpQeury98+M9ocMk7hl27qMvK3NL1L/7?=
 =?us-ascii?Q?M37fOCWW+Zjaf2m+1rcbYDKHRjihMAk/plO53SjBnAmKvuKiGRb9KAFS7s1v?=
 =?us-ascii?Q?UR1sC4SW3ZFzCypg4smXcjBikRfvKveTw8bh9GH/HuG3tGeewMB5NbyfCwiF?=
 =?us-ascii?Q?yfA6GYI9Imvlk9pJ/0zKAmPfG4RySh8xbrIP1EBeKA7iB3blhhuI5+qzHwe8?=
 =?us-ascii?Q?nBVxMtRPPg1I8D/HkNUijikQly9ZX2Ot7iSQy6AYmb+BhW9x06FQJ5wNuEMF?=
 =?us-ascii?Q?klBgYuiIFLRd6TJQ39siGl03/+Fwwk0ABLY6C/b28iZ4WSG6Xo5LaSHr8oZQ?=
 =?us-ascii?Q?Xrb4vmZakARdrnYaTyjlLwc1qJjsfZf0gFQ2AbgUM7IoyE7jB++zP0wuUrcH?=
 =?us-ascii?Q?HsMrvsgUMGPNXeSKSpNY+8cCWCBWGCjB5wZEnZEdBqagbqvlb8Qneu9s1d/u?=
 =?us-ascii?Q?azUV2t44mA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Nk9ISxYLYIXYQo/ECd/nvZS1FE2Unk06Cfaw3Egdz3ppOMQnxiPcFwLWYnF0aIhE1gqGd6dBFAFG/UZ6l7iXBTbkkxn2eRr35JqIcjA9e+jWhDcnCh7RIz5yc6USnbKx3yDOiAbwjlxNJFE7S4CxmPH1rRMC7bcJs2oCIUucnlMbYFqUOUlIOxyu70r0HFCd33y74Zkv1rv+OjfLLBkq17mWujjrhIpixIqcnlgR9HOi75smIpg/VeLUVivm+FNPXzHsJ3TRkkooM6BJ+k/dGkyL4s6CggYrO6ua5jYroHz2Cbr3xTD3FTU9d7vMvg7XYYQyrWkiq/KQ9j9QpCeZvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1ba7e-c9ef-4cb3-4f8f-08df49cd5ac3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 01:50:45.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S87aab38aRoRInopoSwrZ6ytss9lDODmYKNoUdmFCNtXmpGiT/dU0RVCwVP6en1CAcE5kq1cJ0gbiLt+fX644w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
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
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
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

