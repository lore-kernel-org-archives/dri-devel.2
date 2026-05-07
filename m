Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DDECD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415E310EFFB;
	Thu,  7 May 2026 09:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Fx6THQEW";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011022.outbound.protection.outlook.com [52.101.125.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82ED610EFFB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVEuBC3vvEqUIeUHKZObu8Ue8DvDc8eFbew2qGOIpWxPCVcePiHRf29E6k489RZ4f2Irof3526k+gA6mvb1wOc0QdGsEppMvVya5gihl3SLBzG2eozlIlTgjTIuZ6dePjizfZlEJB9Jh9j3OJ0fthCmKWUOhNreo7iQ0yNpNdaaNRV+o6GfFJCFFIE712icPIuO5xyCwLHQ2cFyAsGIVHAuHPGmK8hjaD4VdMAeszOJpfuuSCj2lKKNjgbDfbFB2BecwDqI6+gCkeMpkEsLUM1zxR0ze3oe5hRJ+9ZtJYZCygJKV8QSmZu40FW5uGnfk6tyWVxbZP2/CHg39/GDzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Oq8YN0lL74t6wOIy9BhaeRdSko8/Sg/Lx/4l92vkS0=;
 b=M8y4I+ynz5eZvreFSbcvLpSw5iG3Xx7dnG0guNCDx8UTemdd/7yadJttGX3d9P/qUu73ZkCwvBA3W4YQAnPPblkikz77BqsBly4R5wUlL+HMV/KyXEVVrPJf2IYqEO9Ljl5Jy7Z/GhsTQ4XarF2LIDEUpXcWGNQOMjgcQiqEtEkH7Lzp7ogPhsRJkeJ8x4FDue+U9Q1HhBqmVSuPgofyNFKOonhbMdKahVmugg4GpPBxnisfnSyCUImjUhXb/NXswSGSSGFn88rPblNkgaUYujQdysiB1b3HBGSW9oDO5op0PF+usgmXBUlrSMU2xfqpmKM2WhpWIwwnJbP5uZLl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Oq8YN0lL74t6wOIy9BhaeRdSko8/Sg/Lx/4l92vkS0=;
 b=Fx6THQEWQvM7QSO28vSRd2t4ADlt1JR1ZA/1gdJx6bWUn2yHD95Yl5mwGeYmCENb+qVlJqVQAZ+D6nw2Gf7ZSx1z+2DeviNhoFZ9udD3R3ZS06HfAvAjnPmNiL7j2xzUwSqOM8990eKw9uXchwuUnd0Q6/qpesOJNOitIwv9uNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB16094.jpnprd01.prod.outlook.com (2603:1096:405:2e4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:23:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 09:23:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/13] drm: renesas: rz-du: Add multi-VSP instance support
 in plane selection
Date: Thu,  7 May 2026 11:21:39 +0200
Message-ID: <4bc31522770407416e62703c458a6f06d3b3996d.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB16094:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f2890a-5b1e-4d1b-0f7e-08deac1a51d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jLsabt6FNBldxO42/sRt2IimMgkhxViAREIa/mlpH/dR5mmgusNfZ4PweIkGhOCmIPMJ8rWUyRlFLaOg1TuP6IWJS2hjQaN1yCTFD/n50ZMBFXE8ORol4LV/0wQrYDCrLqaxQfmqHmmUxc+UjwVkWLG9Qy4/znKCJafLsHGPtgJDWDu7tNt4D8+nsK5xr30sV0LTLE1lw0/cQMOXnskLyECiu3swzD/UP9FHiI7gmRMaKRUCyWStxlDqlDaPxA0sZAuHjRFwtR3Q0GT29+4lR4X8ORccWAobyLNnpFnlgSqpmYmLyTmshqnkqUoWXQ88PXjxu3yeU4tPtCTK3Q4+1grRgzouOPeAmtZMWpZivghMPadi++hQu+zl1UrOYJwkxw3dE5gCnalOi9BSnC94ehBzcEe1ywazET5wSparmPZvnS0VPJl7v7oCdc9uSAKvhM6558Y+ok3pAVjx9B7jOVWpFkMG6cn2YVMRb0MyiFofiMXyzGdFaUnAZuicsARBHLL5EdorpzDTKdxEEWIRufdgTkZ9A1+g1Ai+GVwuK/nj0Dtud39+p5zp4rr+yizpaUJ4q0y4EMTLgtrqvc8p2yqZNbF6CNdXigR7ogQ5fCjMce3MMZpGyiR4CPh/KqbDRA1eKUw1WwlJD6hIKbGqsB5O+BmfLaNOpOVpNqtE4FasfM5/gwD9jMeeMTm+srSQIuHSiKIPDVn4rE5SkCQ6UN/q59jE/Erd5U46JsxeNYidVbeMCsyUyMsninNv0N0k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTDhhOm2mifkp1iP2ClCPPzTc72clxAO328TLDyN4WWLxmkCojo4jb8DDeQK?=
 =?us-ascii?Q?ccvGdgV7xjmhW6bWlQS+V0ZUMcw4p+iJ8AYxTrd0LZkTiM/AjhKfmBvuvW42?=
 =?us-ascii?Q?9iSizxeesWTNoW7rNX/KOw1SqQKU66C5JA+C+rVNal4JBZb9NupbTfJ2+aMU?=
 =?us-ascii?Q?GmXpoETxLXUk6Q9YzCAfyYyqK3bPPM3hKCm6i/tyva65MOwgknA+V7N0yJjC?=
 =?us-ascii?Q?QbbyzLZc3txQg7HMCU8l9eCWbbQxzmRonP759iuyq4JT9GqUersMpuOw92yc?=
 =?us-ascii?Q?QNnKEfaMBXxhOkIHc5savh39HgudkHIQ2mdbTiqWf2gq33orCb7gaPj46FWG?=
 =?us-ascii?Q?QrBg7o2KvhX+EGselOhFXxBDqsG3LNEWzU31PrjlL+ms9wsVNFF2ntXPZoT5?=
 =?us-ascii?Q?XUTN/1euJDOj+dJ0O82L/KcQrtMop5EevWhKX/SANpm1pohdeJvK58Ovqxlv?=
 =?us-ascii?Q?paV+fyi4xO1iY46BhpmZcqufxsRe/5anOMUdgp+cLvnI+SSBPp1qxoZqGQ6b?=
 =?us-ascii?Q?pCSbu1bzmqy8DSfp6i1BpMvnp77gKboyF3OAsMiM9uX5eND5XSaYawnUfUM7?=
 =?us-ascii?Q?hLLbEjz3vNCgszxOkf16kmEuNe5q0Hj+C7dyBs4D1WZ8uqYueHibzsCtuant?=
 =?us-ascii?Q?69ewkhiEbNgrSbemT2eME6UxRYlUbLHy3/XsWcXMabOZsFN3Bdf7m8pa8AL6?=
 =?us-ascii?Q?zcdc2M4heoR9wRla1vwbUoBcXXeuUWcIWpPil5/UI3tfPYE3TvA7KfUSN/SL?=
 =?us-ascii?Q?F37C5ChYi3Q9fYUi/wsUhIUGt1pvhDT8ublkTSkm26Pr0+05rWhrxfzVzzvA?=
 =?us-ascii?Q?g51b6nJhb8SxaWgdc6ZOW8ZTtov01SMDeTm0v2SASQEv9G9ziMwX7NcS30JK?=
 =?us-ascii?Q?aR5UNO9DqMdYTUeFll7dO0UQ0ZavXFXtMjvweK9mXy+d8KuUZUxG7txB9/fp?=
 =?us-ascii?Q?20PlWHxZWhnmnjqaUCT3fb/nsfHkkHtFc3JPnfACy0co3/eu15l63Lw5SLbS?=
 =?us-ascii?Q?BaT5wYaxLwHuupoagcJQTcShc8vv8B2OUrQomJpnCQ3wmyb3S1hKhcQVkXIW?=
 =?us-ascii?Q?S9zdFTghO+rw5SLz45vaH9R49qZVrhcVwc1kIdWvrEW6q40QAiGokpHwYi78?=
 =?us-ascii?Q?6wkMJSXhxgvHB5RGfPFSiOxyDKAhJ0Fd2Xq+h0ytVt/7XlsVhrZ0vUWBrokM?=
 =?us-ascii?Q?vi2PwEn8ASM6l3ETk+Lb9eV4fHRWqFa42CJ7fuvIy5e531cpm00OC+9wrN4T?=
 =?us-ascii?Q?qhXVg0BFOGwdJ884jntVgvxz35X7t/qADexJccUTRUU/mAddlS8jwMRFiYYT?=
 =?us-ascii?Q?pOwIzT4qK15alY9bzY8NWtyQ3sE95nAd0XlPQMO6pYrAsffUfRTEUPgSr1jA?=
 =?us-ascii?Q?rJC8Q9dv6p7+2NVL54uVc1PVe5wwvJhIQ3r3pISRD0r1bKFWD1aqx8O5YR+b?=
 =?us-ascii?Q?81ZiG0zY+JvOUypL5hPtWrHsHtDTFdITp9Pf9PCmpeDTIzwTKV1bUcuyXT/Y?=
 =?us-ascii?Q?IBZM9/dl527rACIu3zgkfvJxiFGHO9SQwGKrKPOe5uqhiXI7FSo74wWGpRGz?=
 =?us-ascii?Q?1IKpWcz4Pwnxf1H47immKGTqP97chSLWUgFCiRUKpdokjEN6QO5273LoYCkE?=
 =?us-ascii?Q?Np55PrVhh7tF5sMQjufQRsrTe0txfsgeVqvya7qV7x+0rUzb5RmK1f6Kk85f?=
 =?us-ascii?Q?GFREYHTbUpF3aVyMXyxloQbZVevBhwMRx0O6o9bv1bWAfPY96M2zEDGapUUm?=
 =?us-ascii?Q?pNTMdLGRK5aBds1ttOwKpoeWdMS0atD8ozGr2iSifsXAJs0If5TC?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f2890a-5b1e-4d1b-0f7e-08deac1a51d1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:23:38.1366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9zZnplCs8Key+S1fybHJWFIVxOgOVVhXr/Br81/pe4Bs0G8Xul5Pf0He0UmNKc/jOIzT/OggtdkpEubdf7vsmigCFtdxLOLXVhp4X0mJVsJi0XzPXw/BuCzw9yXv0K0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16094
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

rzg2l_du_vsp_get_drm_plane() scans all DRM planes for a matching
pipe_index, but with multiple VSP instances two planes belonging to
different VSPs can share the same index.  Add a vsp pointer check so
the search is scoped to the CRTC's own VSP instance.

No functional change for single-VSP platforms.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v6->v7:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index bc205c25cd21..1edbcb9f134f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -80,7 +80,8 @@ struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
 	drm_for_each_plane(plane, &rcdu->ddev) {
 		struct rzg2l_du_vsp_plane *vsp_plane = to_rzg2l_vsp_plane(plane);
 
-		if (vsp_plane->index == pipe_index)
+		if (vsp_plane->vsp == crtc->vsp &&
+		    vsp_plane->index == pipe_index)
 			break;
 	}
 
-- 
2.54.0

