Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4635DFB3CE2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D715E10E500;
	Mon, 30 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.b="r1T1Xr4J";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260D510E3C1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf2KLGwtBu1Yxte+j0gOghaZ6VFYPhB+AuvOKnjywItk1exgAtwnOj0mmrOF1lMiKX3iMJIZ+QAgf85Kx1PrhKMV0C/I5GiQmMA3+AUcs+5IFrm3lBvY8bjbxid2ub2/RNNunhhlU/T5IK391mlviN2PacgfH0EC8EJLvgclHGU2Gp21vvPc/D5Qebwa3K2KOABfUWU1uH1OuA7JxxjqIgbQzTqWECa6Fw1gkh/pXhme+v59eq2Fop+kPV+P3oblEXVaTo3gaoCnBHaxfH0Xmdo0e/CpavZBLKjGkRno3M5ERhj0mCY+ZDAObCfwx/J68o+sOzwinjhost7I6HfWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ0fcQFSvjb3CR+FT4pD182w1AJSezVIuW9/rtuW+Fw=;
 b=kxpWfwnaOGtIKLaDpRSFG/deh+vfVKqmxgYdjc29ZvDrj6prukMDfDXiXKDocQGinqDOfEyC4+e1nkb/XkC3azBNOWzGRHipOKCtIA0ziJtoXi11P+CCR2F5pgmThAY+HTzjttrsbo6z9vZdpq5dnBIkpPj6AlU6mp+qtQIdo4/vvnUQ6u7jkKw6lcErJ0eVs0VUqEzm1YaISy/308trBbb7h6FjAn+0vVZlyVoelIby2Vjtj1HyXZNE1r5KS97sfDN+Arl0+ThsYua2r0rtcx3pE60waiX7BZPRuKVyGBOUiZ4V2QHAPgxn6Z3ZLsjt74BuduWhKAKbaQvG0aSMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=baylibre.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ0fcQFSvjb3CR+FT4pD182w1AJSezVIuW9/rtuW+Fw=;
 b=r1T1Xr4JcksQfAEBXcqcNc9+8PBF57AeB00ESX12pBCb2NGJc4fpfVNOkO53wXWLWNnzKYZTAmMZbLNgyMzicRKav8I8rYMsPWPSnKr3/SLRjcyI+1EPJgsk7rk52iMLvryu5DJPb4nwPHbWhDo1C25rCuEcHTXOkE0nlCTfvoQ=
Received: from DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) by PAVPR02MB9913.eurprd02.prod.outlook.com
 (2603:10a6:102:310::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 07:20:34 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::e3) by DUZPR01CA0014.outlook.office365.com
 (2603:10a6:10:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 07:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 30 Mar 2026 07:20:34 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 30 Mar
 2026 09:20:33 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 30 Mar
 2026 09:20:32 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 30 Mar 2026 09:20:32 +0200
Received: from pc63130-2524.se.axis.com (pc63130-2524.se.axis.com
 [10.92.173.61])
 by se-intmail01x.se.axis.com (Postfix) with ESMTP id DEA7A934;
 Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
Received: by pc63130-2524.se.axis.com (Postfix, from userid 18369)
 id DB32B607D8EB; Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
From: Tobias Johansson <tobias.johansson@axis.com>
Date: Mon, 30 Mar 2026 09:20:17 +0200
Subject: [PATCH 2/2] drm/tiny: sharp-memory: avoid transmitting stale TX
 buffer data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-flickering-v1-2-5a192bf4b93d@axis.com>
References: <20260330-flickering-v1-0-5a192bf4b93d@axis.com>
In-Reply-To: <20260330-flickering-v1-0-5a192bf4b93d@axis.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, "Mehdi
 Djait" <mehdi.djait@bootlin.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Tobias
 Johansson" <tobias.johansson@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PAVPR02MB9913:EE_
X-MS-Office365-Filtering-Correlation-Id: e82281ba-8a2b-431e-5e1b-08de8e2cd559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5/TThs41aZCjoLZyA9C3mI8IYiQ2NT+y23xPduHoapSh4Kv9pVh5lH5W2K+azYlfXLeO3LGdSgBB8nwAObUos36W6pzGbZjlidve/17MIeqa5ACFuP8hJOaUOl108AP6rbvZ7YVxKKTPpaK7svknHjbMnlTj1e65/RSO0BRSN6CcTLAntKJ3upH/j/ht5NOe/+NimpPcjNr3ht3RORcmcExnhmt1L3WhRwkyCbIGat0CrCoLQuyF3wCbXXfCap2CUFigLZAdqLhwmfjf3x3YXr2XVX/9jV5PlOFCl98oHTlKCP0Mw/jm1N1OeUT2bMwk/IfFm2IIusc5Q//tbmlxYnLM6DPvmB805SCO7fA8gvJtS71eGJ0CURP/Z8BkksseSLF/rGKMdwxOgK4JCXUsdSB7Fb+oQa1MRnh+MVBCUGidgQ5CoPEUvnLCFXw7o9iY9qVecfLCuWxTys53x5yLnKb0N1CJ1BCzt2iuC1qEJAvgsiLrdS+xZ/TnZ5p0nwtg8X5ncKTOZJfbsrG9e1Hs3aU192khuQHzSMLZ8KulU/MbXR7Tff6jWOvfA2OjYQHJkrIkH/jfgOaTi7W+XrOUWkhpDU+LPU3NCfqxXk+mNCq4ym2ad7Gbsbmn/mHNjBQlvmjsQlcdFcCbopvih/FWzuVG75Vl+9VsnUKBU7++aTJR0HHfeGWWJNpz6vSJj2Ifm2f7UrMGPf3KmuvG+c00CMx7TSYMOLcePoDLussoh+uADC+/UGN0+9HbExvUsbEzV4Hqn4fPF/mzHvliJUO8LA==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wrN+1qRdps5X+e+3yE4gaA3cFpzH7eSBsR4hbRwhtkLyza0ziugDVv6wFRA4NzPCVCnDT1uaIK6nf1VYhjGVgPd/7lebXN2qUkPat1KhNSCL+U0GqpbO5S5dnqQGgzTx4lnGH0pM6MwBrZ2JYEVVWonk+u6XTuwjZcMqrKrn7fGyeElurTMxaBZcK/aonuQGVLYfVM4SocdPI5zdqVT57wgYhTvi78YNzFqJ//HV7D49kpp+BTiWGoiLctqjyBZaEKE9Rt69dH0BRcBpn2UYvXfoepQqifmz5cLMU2wySuf3twD7OX1l5o/sg1yF2Ruw9uBfm0djrCM7IXXQOyUuklq0mOplwDQ5WOm3bHxzv1Oa1HZAJP7HsRvApG2DF/BwRDniehmrgSVL7lpGSO7+n4xA185hLSwYY+GS61zETjfCrC0KwyZ7rmucuU4BbPEQ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:20:34.1817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82281ba-8a2b-431e-5e1b-08de8e2cd559
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9913
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:06:21 +0000
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

When only a subset of lines is dirty, the TX buffer sent to the
panel contains stale line data from previous updates, resulting
in visible flickering on the display.

sharp_memory_update_display() transmits the entire TX buffer
regardless of how many lines were updated. Entries written by a
previous larger update linger in the buffer and
are retransmitted on every subsequent smaller update, overwriting
the newly written data with stale content.

Fix sharp_memory_update_display() to transmit only the buffer
entries populated by the current update.

Fixes: b8f9f21716fec ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Tobias Johansson <tobias.johansson@axis.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 595926ed660e..e7521fc6a010 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -155,7 +155,7 @@ static int sharp_memory_update_display(struct sharp_memory_device *smd,
 	u32 pitch = smd->pitch;
 	u8 vcom = smd->vcom;
 	u8 *tx_buffer = smd->tx_buffer;
-	u32 tx_buffer_size = smd->tx_buffer_size;
+	u32 tx_len = 1 + (drm_rect_height(&clip) * pitch);
 
 	mutex_lock(&smd->tx_mutex);
 
@@ -165,7 +165,7 @@ static int sharp_memory_update_display(struct sharp_memory_device *smd,
 	sharp_memory_set_tx_buffer_addresses(&tx_buffer[1], clip, pitch);
 	sharp_memory_set_tx_buffer_data(&tx_buffer[2], fb, vmap, clip, pitch, fmtcnv_state);
 
-	ret = sharp_memory_spi_write(smd->spi, tx_buffer, tx_buffer_size);
+	ret = sharp_memory_spi_write(smd->spi, tx_buffer, tx_len);
 
 	mutex_unlock(&smd->tx_mutex);
 

-- 
2.43.0

