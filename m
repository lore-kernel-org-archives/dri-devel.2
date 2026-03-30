Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33459FB3CE3
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF9E10E30D;
	Mon, 30 Mar 2026 09:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=axis.com header.i=@axis.com header.b="onkVLOnB";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F29610E3C1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJE4bQOpBeVPOxR338m+WorgJjRoEs2wYUvlDk3fPxyy1+hjMpfHjrX1Wof6wZIUoIUU/WWB81HusAekmbqdN8QQqUAdnGBJGpKOx/1PZrLDo5xLxN4hI5xCGXAbtkmtaeX37TOQn0J+R2qpQoiJBwY0ttfQPOMJ2B/TJkYCF9voNMB2d+yr/c7GLCnIM1DMrJfvQmSqMlg6juDUgvjr5HzGIu3pgXHtYYUNSP2naRH/8Xx7zh+NjkxQpX+evEWlxaOAg1YAiv51A339vesw7PxNcbrL4vLVTySzpKg0Rc2pti3tMz2vlLxy+K7cQX43kJtYcNSSd9yzoxqVJNFMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktsc41aARCSkkLRkAvQ1RTaErJazSSAIy4STJje0WNA=;
 b=IT/vz8qNTOh9fNfwW+VN7Ja6RQ3DovwID46FZlIfreQ7COarwyOoXq02kSjo8IK3QZD4dwOg5qlO0kr6foIK2wxDNkybk08NpFQ4tTO4NmKnekKhKAAozd8QV+Rqxczzoh1NmM8vDscuFix04NnzMcOdWLceNsxWrkru9VUCWq6IDwm/BJw75YzkDGzWYrOwPlRjP3v/R2SFOz3VN1WsmXmDwKo3SaZI74Hh7250doSW0bPngsqKHSJq4kx2nD0fVMp6LG+MugKTPA8KvTq+2MhwFDDLcZIX39kmv52JmIAOSFj8Gj/6/YvGAa+i4TLkFxyBvaKCMlNe9Ln10e0+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=baylibre.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktsc41aARCSkkLRkAvQ1RTaErJazSSAIy4STJje0WNA=;
 b=onkVLOnBD78nWAJ7TsIGvXSBBgHoMWJyMjNX8fLIShSo9zm3ADx4Ncmw6umCKXO/lsJNIW8xkHdEAelpudfEiLN+Wyh20YNsQXbXtNKveDNw602R67uf6lHBk7v6Dg1ueUz8lXHp9kH6v5AZlH99NzNFWkRSZbMaMtK3WtoMGdY=
Received: from DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) by DB9PR02MB6682.eurprd02.prod.outlook.com
 (2603:10a6:10:1fb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 30 Mar
 2026 07:20:33 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::a) by DUZPR01CA0015.outlook.office365.com
 (2603:10a6:10:3c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 07:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 30 Mar 2026 07:20:33 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 30 Mar
 2026 09:20:32 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 30 Mar 2026 09:20:32 +0200
Received: from pc63130-2524.se.axis.com (pc63130-2524.se.axis.com
 [10.92.173.61])
 by se-intmail02x.se.axis.com (Postfix) with ESMTP id DBAC5C92;
 Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
Received: by pc63130-2524.se.axis.com (Postfix, from userid 18369)
 id D6D35603F57B; Mon, 30 Mar 2026 09:20:32 +0200 (CEST)
From: Tobias Johansson <tobias.johansson@axis.com>
Subject: [PATCH 0/2] drm/tiny: sharp-memory: fix TX buffer corruption on
 partial update
Date: Mon, 30 Mar 2026 09:20:15 +0200
Message-ID: <20260330-flickering-v1-0-5a192bf4b93d@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8kymkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mz3bSczORsoJ68dN00y5Q0A0sjE+MUozQloIaCotS0zAqwYdGxtbU
 AySfuZVwAAAA=
X-Change-ID: 20260316-flickering-f9df09243d2f
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DB9PR02MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd7b20b-520c-4f46-2d95-08de8e2cd514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KlQqWAoGiKj9XtrMRjy8WusqaUZISqXPJA55L2IRZ1qoiX0jXgOuoIGQl3q8IULFct7VbjkzMxkq600vv9uULCufmwcwjWx3QBEHQcaSxYc2POW9fOrxElDKPBst2gOPBU3lAtmZ+8/jacbfQus0vT0y1RjOX0ZlsrI9RpEvsxhxXNSQV7X3ULUB+PQssknM0w0GjiqZPpiLGjCUXUAMwytxCiisYwWLMFKEiV0LWaUnuEOUCQ5kdGnkGff2HFzQFOsWpH5XeeNOBZ+Yrh6DNHSqKHcRONd/tRV9dp+fSOd+vSEVcK8JgFcCBtxZdOlXvcEbqHBd+QJz0MNGPFwFcxLcqCRbNZm1igY8D+CBMNXG8M/PP5pd7bq7LzpxE5Ps/YeJ1hcopyUmDZH2jbLPjRtVlxcX9Cd8hFRQC5JFio5Pj8EbMJIgLx7s6ZB412OYKzWlTo/c8RggUIIZIcW8Q4eY3eX/tZ+WiRAAXbfgrO+W2e3Th98ebiAtwpV4Rd1P/MCIYtKXW0RBOtb0tQ3pWTNH4tSrfIyNDnTUPrHSS9FNBEz+mBSrGpfyCdx+5zDvZxJOpY6GzcHS++B89DFLJd/qZbyM5+dd2jGonK0joUKobQQUjCTUztAmaRaNZIjkrWiVaaIAT/dt8jjO3cv/mO45PfiVr+z57RgHWsCzzrt8OwoB92v9YIyt2BGq55deilgpEjKKkG6GFuRyWv2oVy9EjI9M1MJJxSobqY5/dZ4VmVriSsF0kqUBNhabEXEw+Ha47/7ZZ8Y1EFVy7dtGdw==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rRanFtY13I7Kg+tAjZn+pNT7iIESjKuZw6RmYbZS24rOL6taPcc20sDQvrL9vUIzcF0FEiW24KtjrEx4hrRhSGlhY/B7C1k86+991FnDRzZmBB+wHrwF6zebeEOolw0pFzN/O/a5Go24ca0niUl6opZSTIkhovI8QNZmeeCtE44j8Nt0/i1DfokxrtMDKILht6bb9kA8fYpYQxiCxwDUnkiLuoVwCj29oa9Q0HO33rOXgk4Mfeu2sIuOBYHSPnBmq4BZVjzS915YzWOy+yNexFao28y3RCxRyXpLAfXco1cpt8xXQ2npRBgnm498YZRklj2xb3e54zInEOn4Vc809pByyaatE400bzDzj7P7C8R3fnqb8Etb1yA+/S0bDHdBUgx/mGOXmEQGLYVKXSUWr6mE46MfeZfX0kYVvWxOhFtsJLznxBiOsu8S6LMo84zQ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:20:33.7279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd7b20b-520c-4f46-2d95-08de8e2cd514
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6682
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

Users running applications that submit partial framebuffer updates
(such as LVGL with dirty-region tracking) can observe persistent
flickering on the display when using animations.

The flickering is caused by two bugs that corrupt the TX buffer on
partial updates. The first patch fixes incorrect line address
assignment in sharp_memory_set_tx_buffer_addresses(). The second
patch fixes stale data transmission in
sharp_memory_update_display(). Both patches are needed to fully
eliminate the flickering.

Signed-off-by: Tobias Johansson <tobias.johansson@axis.com>
---
Tobias Johansson (2):
      drm/tiny: sharp-memory: fix line address assignment on partial update
      drm/tiny: sharp-memory: avoid transmitting stale TX buffer data

 drivers/gpu/drm/tiny/sharp-memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: ba683f774299d89d17cde03bb1bdb13f3513cd20
change-id: 20260316-flickering-f9df09243d2f

Best regards,
-- 
Tobias Johansson <tobias.johansson@axis.com>

