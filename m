Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3EEC98304
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6EA10EE64;
	Tue, 22 Sep 2026 20:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="m9dH+Gse";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m9dH+Gse";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63FF10EE64
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N+21Vgs029I7oC2NEUPVF7rFTUkXKkZHB99COn0M6hscIRli3PPDxuhSK96i3T9ZSKAdyYHOU5V9tat9BX6Uga5A7g7DUKDb6dOMKIdsgw7Y+AK0U/C0Ch2FO3zBxyUbKprpOPGfFXa8ldoi6riFTVVN0WcY9miOqGq1o+wIJXULk8enS+cCEQ02RN6YfbmrjylOKEAIrvxZYvSCCgqztkRnnWQ7lSjActHazRPHruHdHyKwf5uPk3oSD5C970u4sf0derxMpqnyssmNnl/pxgJus+DjZDGVyvEelwg81LmVaNKk3WfxXgQxv66mfJbxJIsKPuTBh4CshUlYBz5PcA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O8HMqwZOBiUDO+yQIot2F0/bZaTbSJr678HuFSXmLg=;
 b=iXHxFl2m62rDzGp0xz/fWZA5tZFsQoL2ot+KggQHYmabdW1I3f59T+dHSWlBFM7qLYtzQ5sP65UYHxX9DA5ipP76kR0ls7WTaEYDD93BSxpSPu3aK3d1/oPrkaV2WswRzg77QTtoJzEw8JwgJZw3mgmMu/yNgoX5KeMw4s0aJWBnqRgcMGZyt3Ys8PZCi5P2UppXGa7ONyXJB6lYwBCTu8AaKUVHDhWEjS8x3Y5F60jO5YSADMu/c6NJ+Q0jDDIY2fa5NvWVjUKpzoqVkrVYuwSSe1Qe3RRaW28i1GF5gR2YnMB2WzdTxqwAPkIXj2Arn54o/wFwAsCCnIykUgDhKg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O8HMqwZOBiUDO+yQIot2F0/bZaTbSJr678HuFSXmLg=;
 b=m9dH+GsezsVRBQEOBwtJ3vmLlgyN8ZjvC+SzGtJT4kF8U21BakUS/jc1wKfoRB5zQyCz0b57UW2wO8JfAiJaZrioxnSaNBudaSyyK/0rD3j6Rg/qzd06qPlsDDoLWNoF3JxtE+GTccvg76e1/vrOMjnqtUUL4Ba38Zm6j2gqYak=
Received: from DU6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::7) by
 AS1PR08MB7499.eurprd08.prod.outlook.com (2603:10a6:20b:4dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:48:03 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::11) by DU6P191CA0051.outlook.office365.com
 (2603:10a6:10:53e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 22 Sep 2026 20:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNIqCOeRkEWf4Bf8k2cOsuReMFvwLnpnRqTpkkwQk+AiEsOvYUrN9DL8bPUPeURsSdnK/MifSQoBxJY/mTm27wH+LK/UsAr6IMD1zX1BjklZNHmDX5yjvujHT/Ic0Zv9W3SdTeYTNAKoQnWHPHNz8phJ/rnqGHzy+SCK1MMcSVMEhrR0cprc7FIRtqBEQba+df24XEqukB/BG/HewPcvX93tW+o+vXVpDdfpWDmRsxgIXXsXri5mjprU4z3baAXG/ODG+9VfQsKWAMLhxuQ4I/3F56lHgfXFAcS4iOY9BoFCOWCGBOtK5VRa1mV7P64agbxdgLrHMikT/Hpsqp3Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O8HMqwZOBiUDO+yQIot2F0/bZaTbSJr678HuFSXmLg=;
 b=Mwlz8SQPcxZ+ig6FQe74I1LOe3zlQU1eO5tjg9yaP0+rnhSPzNAuFCabWJA5MJBLo3xq/cgHZ+cvBhetZyA5ziGJ64bME8OVui7dhBq27bjx8lP3DZCi9a8Nxtqm180SAj7dK1VISiZ5+uxQDITsQURQrFYRcxaGolNimWbHiLoAzcUx2WhCs2Fj1WjoSfz+00UtGHmMiV7tf3ufD7nl/GpCFFq7OCu4XQVj5Mkcaq0V4QZtuMbX/WXDO28U6JFaKrH05t3MZSuqTcyn8t4pqA8G8j45uX5OmshRtrVjlexKzubi5rhd+vBXP3+QPefrVBH6o3raZ+wM17CdISO6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O8HMqwZOBiUDO+yQIot2F0/bZaTbSJr678HuFSXmLg=;
 b=m9dH+GsezsVRBQEOBwtJ3vmLlgyN8ZjvC+SzGtJT4kF8U21BakUS/jc1wKfoRB5zQyCz0b57UW2wO8JfAiJaZrioxnSaNBudaSyyK/0rD3j6Rg/qzd06qPlsDDoLWNoF3JxtE+GTccvg76e1/vrOMjnqtUUL4Ba38Zm6j2gqYak=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:30 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:30 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 23/27] drm/panthor: Synchronize HW component PM transitions
Date: Tue, 22 Sep 2026 21:45:17 +0100
Message-ID: <20260922204535.2850094-24-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|DB1PEPF000509E8:EE_|AS1PR08MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: e55a212b-5661-47b1-58de-08df18eacbdf
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: kmox6Q5dZ0mcT8QCmgoKtmFLVZ1W+3Z5mV0peYoTSk8oXuukRcZ4QTHzImguSxS1LSFfFI48iN7eyez5zQkN2rzWYTlEOi0LtiynI8OuLo4ewjSlG5FWqjn7RDAkCdS/wCTcVnWNIaSRmB2RtvFl2fzggsXeaHcwiOA307R//TLv/uUK07GFbHvT0t375QIsalDwnLSByi7w4lEBYK6n4zNwRgDCIT06NRvqgpz1vRa3vaOxnck8TlceGVPXuNZ3JOXbepYeM9OFmQ+E3bgMopLZw4obtvBMx+0EziO4uT7gCmF6eVzUpdfGGp/0YF4cl4iReN251KwJGEp0R5kg+EhY8Z69gi2fqIswRHfp8cDXDRNsTWXEQjVWHs8p9W5nX/iKfurwk4EM6zR4j8cVI48HyOEJhnEMDdZ/eslu459MEHvYQrTWslFgK7p05dYeVyp8UQlZTBwtsFmVTmcrY2gZRTrClq2oUFusAayTrcL7l1UHNfbXhMG6NOofsC+Kn4MUjBv92uFSNUgMv0xOTjC1xMazi/3c78LgwHYY/tB65G2okuRy7+BVwRKrf6dz43CTBTg9+ZBX8Qv4rGoeI3pA9w1vxPG3pEg7as/GDU+ir2WxUOU+anCAbzEDaHeADgNzS43Sd5cl0jzDEw8LA3H5BxkX52GyPRYUFyb4rRw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bNvaIhsxyS7dlMhlbP46IsFLzfBQDpUlVArWh2TMd+XGx4wdw4CJp3YztRs+q8ZrIBt2zmZZ7a9sSL5130N00Ai63sgsyllKwS8t5x0c4eqF+4B2phJHAE+AzegyfCr4uwmyaFOaT0IBqQ6Jk7RPlE68lmrs/mYgUYJ7i1XA9dj0/FMv9S0r9ope4TZ7tlqb7/GwDpdGIfEfXUtLE+VbXLrcNwDz1Vtou7zCqNONRUmZ1LGHxjgs5qfYo4Pwi9cnlNV2UvJo/pH1KTxb7K87JHS09C+KA5i6kbZ10GctV/x3mc7SQX3xMWw/5i1Ha+cpBKKBaLm+SZXB8zuhd49IrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e888a31-d9c1-4a79-74d5-08df18eab83e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|14060799003|82310400026|35042699022|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8OFaIJSyqOGN842iK0SLPGBtUHf2D9j03nTq0YhdIG4CWvQkQ5Hjzbc1XLqAEWPiK+mS3OfNBXmtdeePMnFENuCp9yJhYSRcg8YXbjIacYuTHltfAuWaz49+tPvP7qQXzTimpuzgER2rKymKY+gOsJ0qrTZJHuonVTElvyFFaoJovEER+PRwNu+U3/pGXSsn0yy0GxAS2unyebHyXTFTAhuhZoFV/eWfsTY8XyO6+DTlqhxwmLh2ewmJ+Gvm2QNWxQetEE1iedldCrySms5WcSYOJ6v/gi8/TDhOnU3TP6Y/xV88Qq/MdyKJ37gO56JL7DnIvk6SriqqjgDCQGYQXWXh/T56XR0P2UVAyztFTzX65mkMhl2kZ5evBfGtJ2mFjDQubWnk3TfQlg5kqBuVoqAhhoF/ec+pEuYWbS/LzI3Y92ei3sX6saSAOsNZuteom+LD7PvWTn4gcky5rT6/7LjDemnX5Fej8kfPmL1meR0Ptg8LbZgezSc5THqoyMKr87AUSxzwGrI7NHUo/owFzUSKauOiEh0sNFJDvCrVEJN9XPLRxAAe10UQt9HAofuABW0IWpRWhQLEmYKEwq+qYzk4MFGrKV6cZQbnUHO0xFWzbfyxu6QazvL4i1qd+4IxUgQ/KAhFvg9+yrrG3uiHWfisbdj2VVADCHkPi7rDWl4p3Erryo7p92g10iJLn0pqBtoVAAVeT8NMrXAqAMtD8Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(14060799003)(82310400026)(35042699022)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wr6zff8RL0gOfMtKABkflfKh7hMzMXWqJecpNMyPr+hjbMLAYOI88xPwlOjn+K4Fa4WqkX0ikvtO7m2hG+ha0PNDZLqs6cPrzeXRgvLxWMNaFisv1F0T7tm3tU8IS5SllV4mSG+iG6gX7ds5r6eioqAp6v/2KEje8uMsJPc7d6LwsTpQmJrcRMx0e5VN4aik8hxE6mhxe6PAlt9DobP8wUv5ULe/5tOhbRjKcrtT+whF3jwMz+IKtLeXKqpBQFSAJiryG0BprAIhgV74y8iX+cicOhgDs6wFoJbt16nObeV2xGWJef5S9tBLt6tv395rt65cRLDehp07/+C5GYJ8sdToUlH6rz1bEbPZe3CVmWcC7RbptAhe6Gt6KM7DojUxSrGzuTIwQ1QV09ztUGcMwhKZ9vvUWEMIW+rvGgEbwXJ0R/1dd5w4ZZ9R2IQooikq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:03.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55a212b-5661-47b1-58de-08df18eacbdf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7499
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

Split hardware component suspend/resume from the top-level device PM
path and protect those transitions with a dedicated mutex and state
flag.

This lets access-window arbitration suspend or resume GPU components
while runtime PM state remains controlled by the outer PM path.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c     |  1 -
 drivers/gpu/drm/panthor/panthor_device.c | 50 +++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_device.h |  9 +++++
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 848fd64eb51b5..40122bb4b83af 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -192,7 +192,6 @@ static void panthor_aw_handle_message(struct panthor_aw *aw)
 		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
 }
 
-
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 {
 	struct panthor_irq *pirq = data;
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 98c0dd3ce7bcb..2ccd8ad6318d1 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -179,6 +179,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.hw_component_lock);
+	if (ret)
+		return ret;
+
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.mmio_lock);
 	if (ret)
 		return ret;
@@ -293,6 +297,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_mmu;
 
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_ACTIVE);
+
 	ret = panthor_sched_init(ptdev);
 	if (ret)
 		goto err_unplug_fw;
@@ -484,21 +491,55 @@ int panthor_device_mmap_io(struct panthor_device *ptdev, struct vm_area_struct *
 	return 0;
 }
 
-static int panthor_device_resume_hw_components(struct panthor_device *ptdev)
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev)
+{
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_SUSPENDED)
+		return 0;
+
+	if (!pm_runtime_suspended(ptdev->base.dev)) {
+		panthor_fw_suspend(ptdev);
+		panthor_mmu_suspend(ptdev);
+		panthor_gpu_suspend(ptdev);
+		panthor_pwr_suspend(ptdev);
+	}
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
+	return 0;
+}
+
+int panthor_device_resume_hw_components(struct panthor_device *ptdev)
 {
 	int ret;
 
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_ACTIVE)
+		return 0;
+
 	panthor_pwr_resume(ptdev);
 	panthor_gpu_resume(ptdev);
 	panthor_mmu_resume(ptdev);
 
 	ret = panthor_fw_resume(ptdev);
-	if (!ret)
+	if (!ret) {
+		atomic_set(&ptdev->pm.hw_component_state,
+			   PANTHOR_DEVICE_PM_STATE_ACTIVE);
 		return 0;
+	}
 
 	panthor_mmu_suspend(ptdev);
 	panthor_gpu_suspend(ptdev);
 	panthor_pwr_suspend(ptdev);
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
 	return ret;
 }
 
@@ -609,10 +650,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_fw_suspend(ptdev);
-		panthor_mmu_suspend(ptdev);
-		panthor_gpu_suspend(ptdev);
-		panthor_pwr_suspend(ptdev);
+		panthor_device_suspend_hw_components(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 960e06236fc03..42c5052ac83b9 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -352,6 +352,12 @@ struct panthor_device {
 
 		/** @recovery_needed: True when a resume attempt failed. */
 		atomic_t recovery_needed;
+
+		/** @hw_component_lock: Lock protects HW component PM state transitions */
+		struct mutex hw_component_lock;
+
+		/** @hw_component_state: HW component PM state */
+		atomic_t hw_component_state;
 	} pm;
 
 	/** @profile_mask: User-set profiling flags for job accounting. */
@@ -441,6 +447,9 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev);
+int panthor_device_resume_hw_components(struct panthor_device *ptdev);
+
 static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 {
 	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
-- 
2.43.0

