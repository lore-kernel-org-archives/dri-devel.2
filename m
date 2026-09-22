Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632B1C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BDF10EE63;
	Tue, 22 Sep 2026 20:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Ap4khveh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ap4khveh";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011043.outbound.protection.outlook.com
 [40.107.130.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E824510EE6B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:15 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HhTMRwPpMelz4LDKJ/nEoAf4zsk5dGh1zX8CDJ45XXzZtuyaID8Mzsp/o45do79QvX7NjnkpfooOzpSWL4CYwJHtvwd/QEzwv26QTyt3hQO6MNizXQ3m1uJPHQLoY+8QcbChnp4+nEBiDNPwHxaTXwK4laZau5HqYRfhH413OXhNcNBabpJJJ07LehQ01Y3nfgHbk5xuV/+SS2I4VEkU19dgoBdgaofe0PTZQnL5JractaSPLdgDTJyTQ7vhtWosC9N+Mm4ygOkhYnovwdBdTs82Bcs+rJtXxsvp14THuWO8bhjWJf9O1rhNNrHhhYTNkuh1NyMh9ZuB66tpgC2H3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5AljVafS12/A4VvkaxC6EYWb055xtVlipTgb9XwgaY=;
 b=MH6e+fAhwqDJ4v4cLdoxwZkFxSG/TOUs6rn3dURgD6lg3rVhjj80GGwq8W1EFgYuaO9zaw/xZHbbNXSDJSBfbtTfSiJ2K3oV/QhctdCFPiV386rTkzEZJXuW7Lcv8DMcwbaZ2rnk6pt6C5m9V6XTwfAsdTlSKsUWKd++iySVZSa3Ih/AYomd5k86xkJXp+WuOdxR3bZNc2FbPNAqhgULKpZsA29zI7JXnzm2xreCwm/PCUKtz0pm6xsnTwWFis5DO9XO2PTGmWpFjf7auyqZNH0Pmzmx0xeyTELeiQz9GwflWVc61hHOEy4LKZ9tSu4fu1j8hdrEq7OZVVHbD4xWfQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5AljVafS12/A4VvkaxC6EYWb055xtVlipTgb9XwgaY=;
 b=Ap4khveh+wpH+L7f/r9vh2NSDoryTx3s5tkf/1otxhjXSant6sU+j8jef3e4ctN2oGpZxnLgV/dVH6hz/rTQMg5cyvLHo6EUGHHvzk4WSwdsG43O3BP/LWO0TTCEvvrNs0lgkIac5PcCxvf7lVYVTUNmiKj+zW4voBhJZZE09Ro=
Received: from AS9PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::15) by PR3PR08MB5771.eurprd08.prod.outlook.com
 (2603:10a6:102:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:48:10 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::6c) by AS9PR01CA0041.outlook.office365.com
 (2603:10a6:20b:542::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwnCwoCgzCgqb7Y/EIgdWTkUX9cA0wUwyZTtClpGlklc/AOCzME7mTCKAfH3YOdFisfTnIHhgy7vw03D/+Bx+ymxch8A6MKKnz/r5WTJLL+nownKOm66iyuTn65vVsGjApUqje6oQp1/o1vqxsDuQcqpFCIh0YY9xp/objNNUnXGq9s8aA3Dr/l6lF5gLfa6H6b857S8aqI9VrV9DUqGYsdLmfVR7oAKnoRUOBBW6W0X/PcQgcyynvuJT666xvMz1rs3q/cA3eTcpBkOGEnGVPe8NNP5E5jO4HcyzFLtr4s2Q2uZQIgCUYKe0Wnng9VLd+xoZTZCkmtXk6s/hH4UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5AljVafS12/A4VvkaxC6EYWb055xtVlipTgb9XwgaY=;
 b=J4r5Nh4HuQ78ZVTpUrFXKqHzbzJYyU3ybgH3jQWrodtgC6Tq83l3/mARwNWeyXZLMfpDom2jYRkc/lh5nPMRzKrjvSfS057NHLlkCnShApvA++UOR+MmpcXiMLrRjm0elPAVzMHn+JpIUhB0WIlu/jc7x3elmYgXsv6dC31JthJX6Lz00k/fQnyUG5tmY/Z1V/OJr67Vsykx4zOCAwH7m+RL8uNEy/BWuWj5Vi38OqZRKKdfTD7zCbt1t9tABpgVlFjY6fMjcmBzswspk4HylZnJtzmTjAuyim4wmQbTXL09lIYsTrbCTC9kyzjJj1cncHJAD643oa8y4n3ddd0SeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5AljVafS12/A4VvkaxC6EYWb055xtVlipTgb9XwgaY=;
 b=Ap4khveh+wpH+L7f/r9vh2NSDoryTx3s5tkf/1otxhjXSant6sU+j8jef3e4ctN2oGpZxnLgV/dVH6hz/rTQMg5cyvLHo6EUGHHvzk4WSwdsG43O3BP/LWO0TTCEvvrNs0lgkIac5PcCxvf7lVYVTUNmiKj+zW4voBhJZZE09Ro=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:37 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:37 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 26/27] drm/panthor: Prevent missed post-yield cleanup due
 to reset
Date: Tue, 22 Sep 2026 21:45:20 +0100
Message-ID: <20260922204535.2850094-27-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0370.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|CPH1EPF00000524:EE_|PR3PR08MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: b9323b15-1cde-4fba-d1c3-08df18ead013
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: ZTsJl57+tic3Jf0Qceb71vbjxCJTgqMXnJNVk/YtgirgzvdrWjpxbOkgYw63ojxvbXfbSMQgfUhEuadWI60EvT/3gWyTA+4cf3yRl0oTsqb/yKmvIaSr1LA/PaiwQtwT7vUtr8rXDc1zUhkNGkUYkCW0bo+z0to+d7BYqVHl102NjudfdvpreNWil0rChAsd2Bzm/xbl+CJSkryIaPiMUxemdjpTHWWiAHMZBve006QccRPXR1wdB9Q+dPudSv+MP130QR5iL31j/LxIGGVnw2DoTocniDgyhqbGC8TW1BJEd2kdGDQUrEOAUTpdDu0TI5p10Fp9qctRJuxJo/fQD6+0ue+3w7DDt6OyuB7MMVmHAxB6tbW4tdqaYJt8YMkNbe3/6KfmK4qPQgYd/2tyGDpVnAdYfRC+PEV474nTnggseDu0jITSc/yFHr11073jvi21YVyLBerR5yIe+nvYg7U6eVX87rSCbw7EUShreblTuYiEYfrYhG0XUf3kW29nbXO1wVHZlO/w31Wg2kD3PnykWZwVejkxSYiuQIetvw8aqHGjGMnxpTz9mDkSKkorxghGAhNTEfxGPldy0VBjAr+0CRz8hfOPfBxLNru0p4dfly093lROCb7ZzLPeXF3LN9RYe3n0ng4JrkxnXiumC/voNyI+D19NRvMXAGUwjf0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: xkIWXQ+jmy0jnoMcyiteEkjCqq66z2zZFITLtQBwMHLNAlXcB3k1NuPy0HWFsI/KFEGVx9UBu95NUqiy2x4mXygjXQ+8ptEJLpFDTtdGYpLIw8FiqIPOF7JX2LVZOlw5OX5F0pu1qH4dZumBZpZEB1L8EJCIwZ5NM3aauaVb4YiaO0lAumlqDh4WZ0Y8uMAt1uJnJxXBvsOjEhXZvgR2FiB5ZiIRrk89gY3Up9UJoN3/4cLDZfsAQu0v+//HaEsDRzEPT4Vv8EVPVf+RIEWIYFehy9WZYXNOLinXIiO5TAqsZafPQzUTKn5Fth1VZeqJWYMMEIbsS+BpWVu74G35/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 769f941d-2dec-4480-8e11-08df18eabc77
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|35042699022|23010399003|1800799024|82310400026|14060799003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KZA0/lwM1wQo5/l+M+1NZ7RQjEgOokD284ERycap399gKofG9efVbq1xt/Plo3bIcIcoktRtmg4ozGdWpA4SyRDoVhxVL+1iZLdL9QCoiKHwBYhll7d68fHH3ZOZP9Z8iDJXSlGM0/Hy5updog+dOhd7dNTnQgLc/r49m1c/JOPLvL9LHLhtpG7Nv9AL+cemd+oceKdVsnUacbCWx63o4NZ+0BklI0HHedfsiMxdLDe/6CLfGcW8Rp6bFUx5zkW+MwWpGoVGR/HKkw0uWnv3crTgfaC8teTR75RjeIS62ECKWUIG3qHhbw/qffmSYVxOu8Hq1elmMK8CsMm5y5B1GlYnkh7X2LY0IIYICe2yq/B/d7VbG4KHyNZVyVhejBDIvsEXO9p9QpkQ4h+hfhfa8Ow88sTsH8R/UyrNL+uK04hxYD/nA4XJn/xDpCdDTeo2scDx5y4o6+vEsgKcymRwqVv57Beg5TVOAF3fj0rZnHBrOuOOLiwDxSKk+ZBosI6Q0hmCRawW1ic2SGThx3+ZLe1kXHlHV9CHPbsXg7ZFFqfvNlHTXMTbPTGsJuNgKXW4U4L0JZtpn45iwp63/WKwQ+7ubs5cUJxCGq1tUnO1YEmtESS4BvznZYPk+jSjVDOhJ4NJkAircsqXzbryy5IOMYhbwIol7RFdZTdnfEv2eK7b/byfftQLpYopA921cNdk66OddjaHOkEq2kioZqZk+w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(35042699022)(23010399003)(1800799024)(82310400026)(14060799003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uh684HkjVZZQY0ixXN4yqa494WwpIJY4yBBwUA2ZBLc/mQ9WENLT+XNKPd04m8K4cjg72tBXyWdWAxmNI6yx0Rs4x/tT5SXjVat3Bp8bsBgBe8ZqtItusekIeWtwwkKt1lwixAzxBxeq3clhXacPQxVX9I3fxuy0b063nqtpqTAfEVpYgjQltb3XjNwD0PhvgPaKTeOTD9lywwSRSgf2PsTsgznzE3cLYnK9wrT24dlqEtVDJTarHbWOFKxa8IZ1vtTl1bRuP5gfpN9hANpfyf/jDPai1rAqx9jvqoYd0J88YNu5iXVy0Pv+FTgOD/A+kb8s1PsYeBjd/KSySdzKCjEyh0ouyd7WxGKPTr1h4sMaUPEfFCW5HjyBuYOfZB3tw+vu61Gd1Mp1W6ilEQy3dbniTWpEYu/tP1caomyUK2PJAPLPsVED35lyhJu9Gv5a
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:10.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9323b15-1cde-4fba-d1c3-08df18ead013
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5771
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

With v15 GPUs, FW can yield GPU access at any point. This includes when
panthor has scheduled a reset. If a WINDOW_CLOSED event is received
after reset work is scheduled but before the actual RESET_SOFT command
is sent, panthor_aw can end up assuming that the WINDOW_CLOSED is a
result of the reset and fail to schedule the post-yield cleanup.

Introduce pre_reset and post_reset helpers for panthor_aw which marks a
granted AW as reset-active so reset-originated WINDOW_CLOSED handling
does not suppress post-yield cleanup when FW yield wins the race.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c     | 54 +++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_aw.h     |  7 +++
 drivers/gpu/drm/panthor/panthor_device.c | 13 +++++-
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 9ebb23eadfec5..7ef13db4acf50 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -248,7 +248,7 @@ static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
 	struct panthor_device *ptdev = aw->ptdev;
 
 	/* Ignore this WINDOW_CLOSED as part of reset operation. */
-	if (panthor_device_reset_is_pending(ptdev))
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_RESET_ACTIVE)
 		return;
 
 	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_STOPPED ||
@@ -260,14 +260,14 @@ static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
 
 	/*
 	 * Window may have been closed immediately after opening.
-	 * Setting state back to READY will prevent WINDOW_OPENDED from
+	 * Setting state back to READY will prevent WINDOW_OPENED from
 	 * mistakenly transitioning the state to GRANTED.
 	 */
 	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
 				     PANTHOR_AW_STATE_READY))
 		return;
 
-	/* Triggerred from messaged-based yield. Unblock its wait */
+	/* Triggered from messaged-based yield. Unblock its wait */
 	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_STOPPED_IDLE,
 				     PANTHOR_AW_STATE_READY))
 		return;
@@ -275,6 +275,17 @@ static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
 	panthor_aw_schedule_post_yield_work(aw);
 }
 
+static void panthor_aw_handle_window_opened(struct panthor_aw *aw)
+{
+	/* Ignore this WINDOW_OPENED as part of reset operation. */
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_RESET_ACTIVE)
+		return;
+
+	/* Window opened due to GPU_REQUEST */
+	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+				     PANTHOR_AW_STATE_GPU_GRANTED);
+}
+
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 {
 	struct panthor_irq *pirq = data;
@@ -297,10 +308,8 @@ static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 	if (status & WINDOW_IRQ_WINDOW_CLOSED)
 		panthor_aw_handle_window_closed(aw);
 
-
 	if ((status & WINDOW_IRQ_WINDOW_OPENED) && panthor_aw_is_open(aw))
-		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
-					 PANTHOR_AW_STATE_GPU_GRANTED);
+		panthor_aw_handle_window_opened(aw);
 
 	gpu_write(pirq->iomem, INT_CLEAR, status);
 
@@ -579,5 +588,36 @@ bool panthor_aw_has_gpu_access(struct panthor_device *ptdev)
 	if (!ptdev->aw)
 		return true;
 
-	return (atomic_read(&ptdev->aw->state) == PANTHOR_AW_STATE_GPU_GRANTED);
+	switch (atomic_read(&ptdev->aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+	case PANTHOR_AW_STATE_RESET_ACTIVE:
+		return true;
+	}
+
+	return false;
+}
+
+void panthor_aw_pre_reset(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	panthor_aw_state_try_set(ptdev->aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				 PANTHOR_AW_STATE_RESET_ACTIVE);
+}
+
+void panthor_aw_post_reset(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_RESET_ACTIVE,
+				 PANTHOR_AW_STATE_GPU_GRANTED);
+
+	if (!panthor_aw_is_open(aw))
+		panthor_aw_schedule_post_yield_work(aw);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index 1da613fa330a0..0269bbbbdc165 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -24,6 +24,9 @@ enum aw_states {
 	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
 	PANTHOR_AW_STATE_GPU_GRANTED,
 
+	/** @PANTHOR_AW_STATE_RESET_ACTIVE: AW is being reset. */
+	PANTHOR_AW_STATE_RESET_ACTIVE,
+
 	/** @PANTHOR_AW_STATE_STOPPED_IDLE: AW has stopped GPU access. */
 	PANTHOR_AW_STATE_STOPPED_IDLE,
 
@@ -43,4 +46,8 @@ int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
 
 bool panthor_aw_has_gpu_access(struct panthor_device *ptdev);
 
+void panthor_aw_pre_reset(struct panthor_device *ptdev);
+
+void panthor_aw_post_reset(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index ea35c5e1d87b4..86eb4e9a61789 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -138,18 +138,27 @@ static void panthor_device_reset_work(struct work_struct *work)
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return;
 
+	if (!panthor_aw_has_gpu_access(ptdev))
+		goto out_clear_pending;
+
 	panthor_sched_pre_reset(ptdev);
+	panthor_aw_pre_reset(ptdev);
 	panthor_fw_pre_reset(ptdev, true);
 	panthor_mmu_pre_reset(ptdev);
+
 	panthor_hw_soft_reset(ptdev);
+
 	panthor_hw_l2_power_on(ptdev);
 	panthor_mmu_post_reset(ptdev);
 	ret = panthor_fw_post_reset(ptdev);
-	atomic_set(&ptdev->reset.pending, 0);
+	panthor_aw_post_reset(ptdev);
 	panthor_sched_post_reset(ptdev, ret != 0);
+
+out_clear_pending:
+	atomic_set(&ptdev->reset.pending, 0);
 	drm_dev_exit(cookie);
 
-	if (ret) {
+	if (ret && panthor_aw_has_gpu_access(ptdev)) {
 		panthor_device_unplug(ptdev);
 		drm_err(&ptdev->base, "Failed to boot MCU after reset, making device unusable.");
 	}
-- 
2.43.0

