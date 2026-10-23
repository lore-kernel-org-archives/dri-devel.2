Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=XyN4UxBG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85273112C2E;
	Fri, 23 Oct 2026 16:50:37 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130C010E6C9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlq0rkLDMjiWm1kJMM3VPiHBf/Va9fnvbknSlPO8nx/Re+hjczKuyGcrjCGqifjGmG1e7mBUeX+cQdbaoKuJIKdxjD+kf9Oos7gNJer38h5OLWAnEMJVmHsT6WjtVueWVmp7HXL2PKP9zA0+RNMzTuYU6voCTgmFYFhUTfQHNRBQL1TZF6nh2txflBnYVNTz4qpXrsl9cZZVnkT6yL/7bV2G2UWnxJE0ozp588LZE+9JiXyDiWk3IcErFeu9M+DNXmp19NgVYAAG/SxMOVkWErL709XgwPlzM3lyr32Jut54VZgOnoypkIvIn3xEFpEAL/B5cyqcKqJrduB2vTM8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELvBXesgMWWARMzWakaGn+qT+YX0YWI/1o7Hutc0AXw=;
 b=aGsqj7Rr+Z0lKP8YureX9EY8HhrAGCMRHy2ofdM94GIrBU4oCL2yPbUgWAcZq+ffcQJYsmySWfYAf3LMBdoOvxrvSkPg2x0TN6tNGZDU2ujQH6HkirIgrVEvTYNSWg5paLT8h04zl+quj7zhuXXgiYN8hSeVooSn81rGhXopTMN0IjCwS4obJ7wXxy6sZ8H4/AwOJyMz4w4k/WMJsYhUV38hu05Czt3KVQ1xuuAjyfQaLXXaE9k3ErUsS2SikoSTNnkfLRd1PHdCExIp1RlFmk5l8uqLtWu1bOeO4UOtDekdOBt60VCwrTQmZ0KwYeGcMGM3do2JaBOf07zqo4X2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELvBXesgMWWARMzWakaGn+qT+YX0YWI/1o7Hutc0AXw=;
 b=XyN4UxBGsSZgqyoA0UWFQOLScpsZk8IR5pt3xyn0rxBA9PgIHrUsjZb1DnHgK2Pen12OeWml+mtK1WG0asFYhuw+rBF6j5rc7X1aDSszxbnBgwCtGTIwk88RXb8Mv8oMBvU4KDSfglXKkNYDP9idAgpevC6ruJCeU8jqUV7lSok=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:49:39 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:49:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/10] drm: renesas: rz-du: Make the CRTC index relative to
 the DRM device
Date: Fri, 23 Oct 2026 18:47:40 +0200
Message-ID: <2a117ec89653f68fdb7ff073a96845f879b685e1.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e3bfcc-b0cb-48a8-96c1-08df312594f6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: 3yodmiZRL0D04eFbx7sjR/SSRUascEn11Z4LzUQsvOut5fa/sTq9BcRw+lVTbtPIlfd+PlOgvdqw+EKOa3saFZkAd9oC0LDNShPHW+cl2j+/SR92sZi+E1lSxPPjy3haZvxu8Vekb8+yUip5vqAuHt8/COqrPJuCvp8kTiVTeMuJnHpPwjqB3PVUGf6u6k/wBQTpbW23pwgIIU9NcHRvnX4ayHQGFKvA3P7g6zMiiiYUlAPbAfSHIFoloaP+XAze8j3Mb12it7EPSsNuCGuZUOHx4Jy3XFYnFmO/mIQOMC3qIJh6kuzQNfeXD0H53xO014iSLxbVIlYRtrkIz/ADWEOWBT6dPSwn/R7UbUiJM6pq6Fy3kIDCmJO5Cm+1rYoiERwnuVxjvzn9l8ndieVjwSmTyLLm/RZQgMjs+QYeT1ppeap/4dcKa6k6qftfhcG9WstUUYwR1YXP2VhmD+s7GYsTGWkF5skU/C1f5f6kAEIYZbkAj/3fsga7tiW+xJ5CqLFNvOU0EjNYgc0nOu7o2WyPQHompkV+QH+NmJ9sL3ZfYY+/3HNNoTZEEBZnxtMd/DBadxDWD+/6Q3Rubxb/CqiTChTVtZPfnNszAjpYJjMWaEyRXtfbCa9WjWdtDpi4IupJ1n6ghj9hYHgq4iqcOBz8wO9cFiwgRLJ2t7orTu1vmfUaFyhHrqHFrWkMVgkFZtXXJ7oES4K0sTwYMBBdpjvmEnKsKHSH1pdZpUTD+mE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzCIG/H9FnS408mRUBMWDZrOxtxzFkPyaBzi4Xv4Efe0kpvzcyDgawGKRkS6?=
 =?us-ascii?Q?QXHy9h6YlUgO53e2YVVlmPTbQyvwz3+X1paaUt8A7m67sLSUXwvrbaV6zmOE?=
 =?us-ascii?Q?dcafhCQ5qnj6IgdA2WA/OaIi1cGyPtK9P3jnP0KPKU+auTxgipW13or1iFWR?=
 =?us-ascii?Q?BhtYqouBTJ5OfObGGQek6/fwDx3Jo+Q3KTfcsRZTWiqMVlBE9159fJacsH7U?=
 =?us-ascii?Q?Rc0zHKXCXKCrcdIYT/1QYRHT3gHjemsg4Gu8WZTDcNqrF5wko+4oqlldNO4Q?=
 =?us-ascii?Q?iQJ4xbSJGhfiLohUHdJ1c7q2iWdOHGYO6tfmE8ehzqIKhZAKYl7smmhoORjb?=
 =?us-ascii?Q?wZPwXTOdaCfgkvTv7szhKXoQWQuSVwHNWQFqisRYqBeZb9aj7JQys0wmC7WY?=
 =?us-ascii?Q?QLLxonMPs5os4qXzqKk4mc+fROrqINQf6ulOXbuRXL9yMK7YRTZtchHJCkc9?=
 =?us-ascii?Q?Lv1om7fB9P8aJxzjvaC7+LCVRDhb6NBsRiQ8hsaRlX4QnrmY71y2NWnQ/oJB?=
 =?us-ascii?Q?01Yc8qIyVf/1kqS1vGhgEPElkA51WRqJtT7PU1tHdJznNaNdnuu3X2t93SQj?=
 =?us-ascii?Q?W10FPW1GHc8+l1Cw6pRTix3HEXAsut4JEz/RGRyiHA4dyxYNrr5EdS/pYedx?=
 =?us-ascii?Q?VbTaky7Aps4r0HkLT0CrA2jaHR6OPp2zPtNkBgSuHu5hg7Srm+qFLH6kSG6r?=
 =?us-ascii?Q?XNgBIMlwzgXoZLZgFFWQxBnv89jOgYMdr6nJiCoIzUHJvaDR9vXvxnMhm47Z?=
 =?us-ascii?Q?QM2ipFN/pxufAGyLicWz03SrJCVDprfzyZKc10t/weH0tJTcZ1Bv2WtaTz36?=
 =?us-ascii?Q?mXc5UZkuQSqayLyyDplFfJ8qefRBlH8Mi9taf+ehQL2ftPuLg3VM9J90Cwc+?=
 =?us-ascii?Q?/aODMBplG1aeEm/h1kpRfUwfS4eX/SsngAwUI4m3dHhrn4nTgpergK6kupUH?=
 =?us-ascii?Q?5029/JjoCfbptSY0JLi6+RG/8G/VDOfffMkrqmPSPcAmKc3arTpzSeFKq3sf?=
 =?us-ascii?Q?jY7JkBMYxoap7Il0N9YROIimFHqt/9ailhNV+6rv0r379SLRVJPSkPgLsohy?=
 =?us-ascii?Q?ZJhumBeoVVMPB4hU1cwfQ4ugA6sWbU+qpYps+hsri2OUuwfyvc1XIdBI5A++?=
 =?us-ascii?Q?tbXfTVwbR1jecNWqdwTVEqthyTeaYMzFFpkJI5jj0p3n2EDqvkEu0bLZC1VU?=
 =?us-ascii?Q?SYoRXQqxuXhefAwKagJ9esP/GVV2GkbtnBUTSgr/sfmQFeexFFk8aE4gXEon?=
 =?us-ascii?Q?nCChQQIQaKJZe9vNr4bCedi6UBHEZLdBOEuQCJwuxOZil27xWQ23cWOWcGTF?=
 =?us-ascii?Q?cpGMBQDyoTIZ9QOBCyLjIqVAeMMUdZBV9iPX3BT4xWEvH9zzJ5LhAmo/wTrk?=
 =?us-ascii?Q?imGBijEZsdqEDDGmB/H1YpZjgTRyjhMT4mv8k+cmKxnOT5C+xxGhJV6vIkU7?=
 =?us-ascii?Q?u3YCuEv8MR/fqZ9Ta0wSIh/Cw1jli8jRldJZariJCbFnYa9FOJ8oKyuvdc5R?=
 =?us-ascii?Q?7JXWTuZ/D2tvBkyFDCQIGO4+FUfvumTmZYQ1AYyyrJMlKC73VHEPs0fFBU1U?=
 =?us-ascii?Q?K/KrRSKnVGxBXRdo43z128GjORoy8eHwxXFV3LRHpd4h4jV/BnQBr7/voY3A?=
 =?us-ascii?Q?4qP87e2YeZGATT0Q8vEvogFCTYzHq1fBkqIMt44u5otLOZ78SV7R1exOTPSv?=
 =?us-ascii?Q?fyCFq+hVMeuc3+UB/kYJa7vDlPbJMZO+0KXopNQzIE7ZOkHVlE9K9/U3ea9W?=
 =?us-ascii?Q?ISxbkdrZ/45qrjOiFKel2KglXOhEablJOdl6essbSbjk7MIuVybJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e3bfcc-b0cb-48a8-96c1-08df312594f6
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:19.5907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNFCCzXr0TfCu/Qz40YYzneJJzcmN2Zxs3tZGyLX7NBFMGgCanlgK+fdqw2vfe0GOostR8EfsvWpRZJz4iZGXG6E5dXjRbViLjm6DpOcqmV4dbfF+PFRcDz5xDUfzvgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The possible_crtcs masks of planes and encoders hold CRTC indices within
the DRM device, but rzg2l_du_vsps_init() and
rzg2l_du_modeset_init_finish() build them from the index of the CRTC
within the DU instance. The two only match while an instance owns the
whole DRM device.

In preparation for supporting RZ/G3E, where two instances share one,
record in each instance the index of its first CRTC and offset the masks
by it. The index is zero for instances that own their DRM device, so
their masks are unchanged.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h | 1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 47ceaf892339..2952c9d7348b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -70,6 +70,7 @@ struct rzg2l_du_device {
 	void __iomem *mmio;
 
 	struct drm_device *ddev;
+	unsigned int index;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 287f3f9fe56f..cad378418b38 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -367,7 +367,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 		else
 			vsps[vsps_count++].np = args.np;
 
-		vsps[j].crtcs_mask |= BIT(i);
+		vsps[j].crtcs_mask |= BIT(rcdu->index + i);
 
 		/*
 		 * Store the VSP pointer and pipe index in the CRTC. If the
@@ -480,7 +480,7 @@ int rzg2l_du_modeset_init_finish(struct drm_device *dev)
 		const struct rzg2l_du_output_routing *route =
 			&renc->dev->info->routes[renc->output];
 
-		encoder->possible_crtcs = route->possible_outputs;
+		encoder->possible_crtcs = route->possible_outputs << renc->dev->index;
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-- 
2.54.0

