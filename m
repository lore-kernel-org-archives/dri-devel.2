Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256F4FEC0EC
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663A910E61A;
	Tue, 24 Mar 2026 18:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eIxp/3Li";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011040.outbound.protection.outlook.com [40.107.74.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DA710E61A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 18:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGYmbAty3qJUPwM51LbolQAWIQwY6UKrwpFcqmnaETo29a+2byKxnGxoU7ZknGXtayaX05PmLWK9oKcMIQn/IspMVOrBLPdL8veJmC4UhY1VFdXZ+fH3l/4be9cXOYNWEDk4lTjcIMSd2hE0p9Sx0/BzFnPLYWGaLNSG/93b9w+z9zFWzK+tTpY4uKbVI7WkNtIossoJNcM8vJHBHxnW2Tun/TpONW41rsqVyURIQH9rBvwyMafNrKQU2kcsGHEM6DPzyFDsfhZVFLj63ZSpWW7hLZJFf6c1isnh+WviflP2d3auMYnS+ZOkOtlCmWG35J8ljENRqq3zXLmY9jp6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj/OSgKxCTprmIkG6oHLJAq/cBgvqkvUw9WBJnEqyFY=;
 b=weYWhM5La7wWca1aIoetOK4mU+9RGrArCVoJtpG6RpZtKU2qfETFWHJFK1OPqKqwM1Ka6w8fCIiXLcD2b8E9HIPU42YH3WOSJ0h63y+V5FxEcoWSyA7nNZY4hI9nj9/7Apqzgd4FcAZ6DJtvb2Z6FRlTYpaSTBZSyw9IEhepyesg8VqvhmKMYh7RM9kA9at2DhLDFkrgpLbKjsZOuyl1JWtj/67uike6hI1HmNFpd/BPbzOnPj0p7P0/jcDe4VgEpXeCGOLRtD7ixPx33VQjpW6YVUWKnHxVpjyPc2qAjhXwfpGgA12fHv5Z2z4ccyQSp/4zT75RTbcVaHyIxq+mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj/OSgKxCTprmIkG6oHLJAq/cBgvqkvUw9WBJnEqyFY=;
 b=eIxp/3LiVf+emRWWNcs20/q6WugWvMcbgZBU/e+DkGZNbijT9VkynuyAXkI3YLbo9lro0cLU+CIOM9AAHLOImBhoFY7n0hcr730PsJfGwBLjSmjKPxbQRXtA7EqDU4uCvVDdQukrv+eNlteNgWnHRa59zSLedMWbUsMCj491UiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB17371.jpnprd01.prod.outlook.com (2603:1096:604:43e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 18:05:54 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:05:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm: rz-du: Ensure correct suspend/resume ordering with VSP
Date: Tue, 24 Mar 2026 19:05:05 +0100
Message-ID: <20260324180512.2277875-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB17371:EE_
X-MS-Office365-Filtering-Correlation-Id: 08280f79-1a43-4a3d-f6c9-08de89cffd40
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OaU1DULgOD62IYwBSCBZeW5UkimZ56247zhd1JsAYuTzdwkf3c3CYf8iVT80miG8KeWP1ajQINQaRvGqtzfHcVBRtjldDwk36nKzTG/z/g3nGpQ8JkSRWvA1DMzWi6aNvJzdpiOItfgV4vcjFteKItC2QrWFeZlOdyuklfmwFcu4GszFC7cDwrtmfIMehj0W62e8gznpW1kYZ/tnGnJOK3MNYXmyLRE/m2TZ0eJyba8od2Yl1VHicA3OJRCfl7oqoCCsWvXVZuZs55DEBpxA59N6sDamw+cwROOOj5UJJ1Fo1pkz7iLXFOYPIaxGB6K5JrBeVkGyMF0g32pvunZlyi0JHu9jOPh6JHoekkd01QRDF7E41U1uvzzh9oiCAr9msywNwiOvktLXaJnqERThkN95qjfTxd/thsLzBX4Lsr5DCbJtw7gpRoW2ikU7UKXCjpTD2FAHSFBKOjG30FgqJtYR1v0S/rcioR6eM2xMBTB6D742rne8r0IrtiwqTGj8jXUjfIb7/aBHLsnhQ8pRi3mdDaN/92W9RxDIAXlppYkI0BL4OR0/nBG8tX5uZ5wFFx2AMEiW30LXxqtCWAV6bM6ITG5MjBOcMdkLJQj9/NQAiLRrygCWJSOmDaC+ZUrmfIAPBm17mUvzfDl2jF+Wm5jvnoQ0oGIbPnUfSuY/A/QZ+pmnTQZaoKh2NoeA/Y/mRTHjufj8mtX917HwsAFhmwcVNTS8s3mtmf5VGvUlpJDIOL/dAgSQSbD/z1KnfH0GEzydp+oLbRxmq90Z1d6xEwmHq1HFlH3kezMidikZqZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTrwqligDTrDYYVLUeEYYg+DtgPNbOgRWpLopyz+4dBs9vFHE16nM8WX4G3Q?=
 =?us-ascii?Q?N6i8WUZ7agpYBNIcBGE5+YF6pPy/T6Ta7UUPwX3x+FP8TnQ4n1O79oJUb0qZ?=
 =?us-ascii?Q?Y7R3ynW5IO8AowKU592Ww7dX5jOtHowPAnq+BPwz+IjQKfLGU70p4W8FQ8Hl?=
 =?us-ascii?Q?D98bQI25hZ6HrGrSdU3U3YYVyNUqJcaJcXQMy5dMW3yvKYKBWacl4ebEbKFA?=
 =?us-ascii?Q?PzaRGrnsNo6q8e6FgfXbHGa8QV77mUfuEG/LcbuEVyfFZxQCaKYnz5IyYOcS?=
 =?us-ascii?Q?bxXgIDEClNYpc9FUUjZX4Wm6BUkBoVmKOjdGielBygLrXODDud+JaZzaV8lp?=
 =?us-ascii?Q?qksnbobY4nJSx0uEB2iHYbD00lrOqD0VfhBSKcr6aetxFM9fD8hIIwN7VbuG?=
 =?us-ascii?Q?LfTRLj0swm+wVrNhKtaEA8AtcombRy6uLV08b8LayqOgm99dfm+lz/GhiJld?=
 =?us-ascii?Q?Q9A6vlY5/jDbaWnzRDhKvHFdSyGNMuPmm7+JfKKQrCeC1Ib+SUd1aFZ+5aO0?=
 =?us-ascii?Q?/n+3I4nZ5GjOLWHsv9upTIznqobkSFv4bq8/9pYuLsPRxz4oXCOlIOwZD/qA?=
 =?us-ascii?Q?oHHcw4NjTY8Qrprtgasuw33+Y04p9TWutphSFtADhk/piWeitk6zWnRYrjEK?=
 =?us-ascii?Q?qzOyjcJXcq/A6+vjSkUT0zIE6TLcG7mJ8C2Z/H9Sodta5rPifPMRZnw9CUjq?=
 =?us-ascii?Q?iCI/NUPQyqtKYc126JsdSn4kqUyqbe8AO4AVzIQ97iDEYgTgdaXAj1yTpCak?=
 =?us-ascii?Q?BjTn+dribilvrTLgomTJTcv2O99Gi/9yYsMNITyE8PGAXZFk9mEuMkzSfN/l?=
 =?us-ascii?Q?ihoFUWStV8uKpQWV/shIoQBEQmgfy643W4NAoGQ0lZv3sEoStgaOQlZi0Pf7?=
 =?us-ascii?Q?nhBuIX4sl8/cNA9KAKtLn0aZSxdsLaFLzLfM7hCLBogtKMBDHU9FBFB6BEeG?=
 =?us-ascii?Q?1o7NDEqmcdKLRV5kOLiLPMFa/wiFLf4Cw1MUCYDFcCDeE7SKkdwgFQNoUoLg?=
 =?us-ascii?Q?6+UTNXfGkfeR4lhXfdzfXULjYv5BK4PT0KqhNV/D/C9OrlAgQSliyGwr2mFj?=
 =?us-ascii?Q?zvnMxqFcoW6eeJJPfUGiU7cHpFNn+rypkzA8bYjd6M5ZPbbd9ePnwZI9pI7f?=
 =?us-ascii?Q?/iTr8PYOPQf9GQk9iTCAZNZP1zd59mGrvGiVn9yGp5gIKHFz5X0t/oMNrUIO?=
 =?us-ascii?Q?fJQ42v2L2KQuU2uYx0lPJElWZawZC6hnmrEAqMdObqoeW8bnSfe75VN0ugbm?=
 =?us-ascii?Q?iIVE9bAEW/S9EdoZb8NjQniMYZaVAahD/FgU0qASculehoRUT8Ne7Cp3/+dm?=
 =?us-ascii?Q?BeZ7BCgBAzVgJK+fXqxejjUWe9F/l2nUG/vBKJ4dxQraeadxRa/xgFFV/o+r?=
 =?us-ascii?Q?N3D8Ot5u72cXW+qKPHpS/l9D+XrQ1YgKd1/Ri4qLRgGRdLRvbwamZhRjEpyd?=
 =?us-ascii?Q?nLAXyuze/L+Wf7NyAw4o3CsZXCNN0NOedyOXcYWmy2tLFpCFf+Y4Y+Q4oMTY?=
 =?us-ascii?Q?YfjYMZkImdl9+qst6MRbdFL78gWqb66ofsaUa6ay9WFZCYVXpt2818YHZs7V?=
 =?us-ascii?Q?OM/4A73KCZ2zzoQhinw9WsrE/6far026vB5+UVxjVCpyL7pnfnJu3godqU5s?=
 =?us-ascii?Q?TG24SgayeceEP9iL3eW8XKW+DnTBoRWx9PacgZlGuNe5ExVBoHvwBuAqXtpv?=
 =?us-ascii?Q?Dp3WKcwQaZetcFPtuSazHRZHTDhyXWoOxIs1M57oRMVVSwb33C56Xk/M17d+?=
 =?us-ascii?Q?oEz351F5dkznd5XHW3VSOnmuDGD/Qv7bV0dweCfN5Ofln9yg+VRJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08280f79-1a43-4a3d-f6c9-08de89cffd40
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:05:53.7026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9lkHnr3jRtktQz0+DYP2GLPhy/3t+GBO4MLYM9aMJ63RnSFucGv8f9EgpIHp65Pxhd1+tRCzvsgOgbBPAcKQ0BiYT5Rwnp7RkKHBhHOm6sA/GsaB7uN70+jLnIjcskq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17371
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

The VSP serves as an interface to memory and a compositor to the DU. It
therefore needs to be suspended after and resumed before the DU, to be
properly stopped and restarted in a controlled fashion driven by the DU
driver. This currently works by chance. Avoid relying on luck by
enforcing the correct suspend/resume ordering with device links.

Based on similar work done by Laurent Pinchart for R-Car DU.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 16 ++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index bd486377f037..eb626c3cc421 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -20,6 +20,7 @@
 #include <drm/drm_vblank.h>
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -293,6 +294,9 @@ static void rzg2l_du_vsp_cleanup(struct drm_device *dev, void *res)
 {
 	struct rzg2l_du_vsp *vsp = res;
 
+	if (vsp->link)
+		device_link_del(vsp->link);
+
 	put_device(vsp->vsp);
 }
 
@@ -317,6 +321,18 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Enforce suspend/resume ordering between the DU (consumer) and the
+	 * VSP (supplier). The DU will be suspended before and resume after the
+	 * VSP.
+	 */
+	vsp->link = device_link_add(rcdu->dev, vsp->vsp, DL_FLAG_STATELESS);
+	if (!vsp->link) {
+		dev_err(rcdu->dev, "Failed to create device link to VSP %s\n",
+			dev_name(vsp->vsp));
+		return -EINVAL;
+	}
+
 	ret = vsp1_du_init(vsp->vsp);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
index 322eb80dcbaf..a22aaf0843ed 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
@@ -15,6 +15,7 @@
 #include <linux/scatterlist.h>
 
 struct device;
+struct device_link;
 struct drm_framebuffer;
 struct rzg2l_du_device;
 struct rzg2l_du_format_info;
@@ -29,6 +30,7 @@ struct rzg2l_du_vsp_plane {
 struct rzg2l_du_vsp {
 	unsigned int index;
 	struct device *vsp;
+	struct device_link *link;
 	struct rzg2l_du_device *dev;
 };
 
-- 
2.43.0

