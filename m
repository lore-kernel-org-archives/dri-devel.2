Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC6FF8869
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89EB810E804;
	Mon, 27 Apr 2026 16:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Svv5QVNa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Svv5QVNa";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6634010E802
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aSkgpfVF38Oe7c7Pb9fgIijAdbua/9wovsp6StLju0+vI+mzZQppvJwOgIgs6IFboj/1O5nl3YeJI7OgANvRGVO8mLnXLPcK5sjJfhxJP91hu1CPWuM0IlTYdgbf+6AblnDJBBMs0t1J2kwAEnJNnVGoM/ZEdE4qg1uW/zYwrnzLmQWcw8jqOCXWqUAqBoU3mmlUbLfW6cCTKB/mvnG71J3bsV39dPRH8Fr7sThJbF/mlqeYxyW1w3km56JSAaEbOH9zgH0XahODo7UDV5cqQIedzP4thG9Aj49v3tGrUbC9qyTPBiHdDZvE/pAiLAfhwmp79M7VxC5jrtYkGe6UYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xElmLagnplZC+Rewrcti4YvkP3zKUxArBHjUziYSRbc=;
 b=Jis+2u1anmbF7jjAXWP/zCq0UjnHPjct6QJ9AAGor9PHVj+0q3Vh6Qfi0APrfqLhfpP36H61ucZ8SGOdxFV6ZSpTUeMRG517LaeWdViS1D9LI2SeV+irhkEreJ7QVA17SH3Sr4k7GzwZqd0MW9wnD62g1BtuhoECIhIo503Yd/9yycXSeF2GuJVdJkGJzP780cRgltp/KxXxeOTMZ1ecz4ZxU10KYL4wo4jk+76ceXIZ7mCldyrpa2oP45kZHlB0euQ8nnks02FEXwHUQGjxpXeXaU/gwyZs5i8AUOa5db49vPopuqJJ6jhdr8KLEdlKlY+lxTtDLnZk5F2q6V8yGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xElmLagnplZC+Rewrcti4YvkP3zKUxArBHjUziYSRbc=;
 b=Svv5QVNaR2OeRSWqr8s2TMl8qJTpEpFkeax4alr+kXOP/0qdJDdr6UtiyAAQtAZqFdcKqih07q/ITSb/KdWz+bMph7WMJClaIiaF7cy/JpaeMB2T7Z/kOKRjwpgBnmbSr/AQr0/gSiiT/UpLo4n98oVFL5roefxIemPHp3PabqM=
Received: from AM6PR10CA0094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::35)
 by AM9PR08MB6033.eurprd08.prod.outlook.com (2603:10a6:20b:286::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:53 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:209:8c:cafe::d3) by AM6PR10CA0094.outlook.office365.com
 (2603:10a6:209:8c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWtkCRhpteZtcqjD3V2+YsMSy9qaACvEbSOWEy6V45EW69FYFdGmzGyt8IOOd+PbMRL5ig1fidKkoJYjfhd71LR4qGUZY233NYBl5U1x260x1c2TpYTEpPeV/IWVRXXhhGg+ZSFKWJQmup3kM5/qbKhrh2Z9kBVJ0pVb7yAjMW+8eAdquiSTRuRLWjsm09DJGkKiL9YqGxtBjbX3KuJw1xJeWqAC8QutMJf1Xgn+83xx3tJ12NX6lh3NloalQSOAdpNNrajH8QopP1vJRlt2HMh98WPB3Vq/rNW5nfAhYSJ6hx+20vK0rQp2Ol1Pc82umTr8HNQB18kDFvkHgIYFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xElmLagnplZC+Rewrcti4YvkP3zKUxArBHjUziYSRbc=;
 b=IM8jdqsEA4pv1kr1KoDATgvJAaBjm51cjvQMlfbvQzMSrxp68rQrB0T0FULSBOHIGXPxaqQsGLkfrWqc3GqxjxF9E2NHPFLJg8X5JEjZPBtZKMNugKVrl5pkUCoTAMgKtNIghEEPI0vcDsQa8DLa9QqtQvAnABF/LeqjDRTvh51MXzDJe2LZwVesa9XdZZGz8bYLziH7l1iViLknp9ZQ7zeOvnJ+FdTQGFkVgv3eiZim5pFlTatht4gqi97XHQtlgHZpL0bjM6oKwkl1gmDymaxBE9TBmHNuge7AD6R2j7cPGvAMfIfM80EAXbOI/Nd82UBgw+lsPswcSlnF6tHK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xElmLagnplZC+Rewrcti4YvkP3zKUxArBHjUziYSRbc=;
 b=Svv5QVNaR2OeRSWqr8s2TMl8qJTpEpFkeax4alr+kXOP/0qdJDdr6UtiyAAQtAZqFdcKqih07q/ITSb/KdWz+bMph7WMJClaIiaF7cy/JpaeMB2T7Z/kOKRjwpgBnmbSr/AQr0/gSiiT/UpLo4n98oVFL5roefxIemPHp3PabqM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:49 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:49 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] drm/panthor: Use a local iomem base for PWR registers
Date: Mon, 27 Apr 2026 16:59:32 +0100
Message-ID: <20260427155934.416502-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3PR09CA0001.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|AMS0EPF000001AC:EE_|AM9PR08MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2bb331-337a-4c4b-db48-08dea47628d6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: t7KcYtBo+V0GWwvovwuduvmjZOKzh2CZJA2TG477zLh0bkU5TUXdGeENFUniwSbrSjVl8C6wxi/5FDCYY7oYg3+9EtgF/tYen5JDulcv5QY7FkzvfdaAvcQbwq1EebGfwJOxTiMiNTt8IyWvlOieD+cBtcMoDCYxNtzIKoPK3onuzZ5M/k4NY4DxkWgr1lyUuPbed8FYhDMHOidJ7ocALi4dLK4UgBgUPu8RqI8Mp62XxloRC8XV6h4ZINh2UivxbilpaqCKsh1+6upi0UVcaerZMG8axlXCrGCILrutu8VTm9PApio9MtAwFZBLLSDWZd+gpmIEHkUGT2cV9RvHJRcoKT823IqtdJfPOECLrOim1kxvT4hUHNh4AlEYMbzMXVP20GHwz9anJ/pJ2mczvo548LFH1ZspCvoKAUZvFAh4HMcO9Z6PIqu5Rl+NZXcHzp2qlaCTtSdOEbCAZwwVUZ0a+BdVxgYZ8ISmWmGs3QTB6Ag7eTO7+3R9L9WXhatGRuRqKJa4ENPU5XjKRLIwEAM8w4ngWY15xmPNyafnrPWgS8xBjlAulgUjuPLoLjfdZx53uPBbPCHa1iyuxOeOuijacw2YPLUintCTtfi6N+kvW5jwr2PJjF+GsZyp/yl6u//ouce3pwIeH1PYX136gt3k1dUaQ6Xfe1juoeOZ5AZxZiDqA0eaUoUYXr+jN/u2Mubn1RwPpOZcBVRn1oIQxkyUliqJpHTPjcuraOFxtRQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: rAROWUGb6OlnI7EAiCWOTNkohMF1rlxmNYVSTL9RnXVp4rrmUAXrIL9HWH6P9fj9WWzl6eb9NA2mZiY+5TXJwbLO7g0YU0TJAVDfzCvTatSAvsCfotzaNePGkjPnrN80XcPZAaIj90bQyAhhVwA+G2dbJ1sOvHQ/q7y1wW40XPkTd/ULz4ZqmYUfoDF74fWwnDJOQLtW4zdR8R6YBkimX00rpKJmmSzejkrs14pD+j7b1HIO/A2HgyR11MaOP61abgsjpiuNFzP8MX2XblGvERnrRTMLKYXD0irxj6Luki4giR5Okd9ck2fj6WY+eiQq+x5SDnEjyiMhg2kPcxZg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 55b9e3f1-50bb-4b01-d9b6-08dea47602e7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8SlC+K26WhFyTIpYC21wTOmKFQE2ooddDBJbzt51M3wb24Zc4jq9/JeSGMtZHbv4weMQwpwLDzN1tfujV9jhaapj6iadKzCk2x4CAGfA5NWMC5KwXwBG+g7i9ulLBOAhcxB95FeuLbWrfJsJXM9aHxAu/YwDFnggWwjD+WxnIE6cBHfkgDbO8/2phb+AXTkr2zbBYI4e7yN0aWIfFR9soQVyYCwN+hr34U8X0dchS7d+6w5Nyoeoc5lSmuiWtIL+EjSQ53AjsNzioy7/out82SJJ7dpggycQl3KvrYYZBvufvpOCwbrWcM4W80a8t+TbnwFZR5WAERUaipGPcemKEdnBFVLfTmSNm+4fq01eWCIhBkucqNGZOAmJYonxaD1YsqAbDHJL60wuSvC9xvQV+1Q0BVgMP/VPhnmS8eLnR8PR3wpoqZeLT0ipgDmSqsn1bvMG8aEPBctd7NgsRiMWSjpDl+YAOGglJ7+npwjTzA4bUQXHOYwuckGPZ8FP6y/VP+0/C0lezGJeZzzT9G5VFHSaFtHiHZBUMy+7fz8oW29SynedUxO0gdWIoaecyDmwWMloTNVvE1RqD+Hn8masoS4f+3mdqCY4pU0f4eDpRMcjXPi5oMAvCS9rO47xJF56DJb55YN8o5FG5MpKh4IgSnNKOVeEA6nWVqdeNHU6M27A/F+1VPyZlVgPLSVPMD+HBaQE2Zv2Y6qjgvQfoRQu7GBJzgmLXKPgLY7Hp/bND5JYbBZMUjgjhLbMCrSRmimjUbxcMO+EwOXPubRV/2C2Gg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lQBFOV4sVWMU787io90Qojhd6p+7Ifojos9kEoBFJJEwm2ZQH16nByJE1Gewr9l7idRXeljCWEBs7xFe3e6vEfhQSpnWsIJN2kQOlYSdQK020nUrt8b25AneejdNW+FT1q91A8Jhb8o5vlmfwvdmY8sCJpwcdEfhVNlAiX72CMkHMra6Cq9z0httyBRG/o5jnhdY1GJKKLMuyuLV+/PFTtphTjDilVFjCt/1mr3DgAr/VlmouyHgd6qSKtWAdf62tx0bAgl69a2wa6Hi6J6Q9Q9Hf8Fdisar2AQzdylprk+DvZa1B5gKyynEo7LFxiBMrhoM3lZhc/MkcMBv4mrUTTxywT4Uv1UHbZQp3RWNN63rjPu3SWfPf6oKjLsSEOwRqmZbdmjTvQf7HlfzJ40TK3OdTyB/2uFy0xBhhsEyraAtsB2yQVG/IH5PCsy12f7v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:53.0384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2bb331-337a-4c4b-db48-08dea47628d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6033
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

Add a PWR_CONTROL-local iomem pointer to struct panthor_pwr and switch
power controller register accesses to that base.

Update IRQ-local iomem base to use PWR_CONTROl-local iomem and update
the register definitions so the PWR block can be addressed relative to
its local base. This removes the remaining dependence on the global
device MMIO mapping for PWR register accesses. Update
panthor_gpu_info_init() to also use the correct PWR_CONTROL iomem for
the *_PRESENT registers.

No functional change intended.

v3:
- Clean up definitions for pwr->iomem and pwr->irq.iomem.
- Update PWR_INT_BASE to be relative to pwr->iomem.
v2:
- Update panthor_gpu_info_init() to use block-local iomem pointer.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++-
 drivers/gpu/drm/panthor/panthor_pwr.c      | 79 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_pwr_regs.h | 50 +++++++-------
 3 files changed, 79 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 80aa151d5936..7e315708ca7c 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -221,10 +221,12 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
+		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+
 		/* Introduced in arch 14.x */
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, PWR_L2_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
 	} else {
 		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 705d998447b5..7c7f424a1436 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -40,6 +40,9 @@
  * struct panthor_pwr - PWR_CONTROL block management data.
  */
 struct panthor_pwr {
+	/** @iomem: CPU mapping of PWR_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: PWR irq. */
 	struct panthor_irq irq;
 
@@ -55,8 +58,10 @@ struct panthor_pwr {
 
 static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	spin_lock(&ptdev->pwr->reqs_lock);
-	gpu_write(ptdev->iomem, PWR_INT_CLEAR, status);
+	gpu_write(pwr->irq.iomem, INT_CLEAR, status);
 
 	if (unlikely(status & PWR_IRQ_COMMAND_NOT_ALLOWED))
 		drm_err(&ptdev->base, "PWR_IRQ: COMMAND_NOT_ALLOWED");
@@ -74,15 +79,19 @@ PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
 
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	if (args)
-		gpu_write64(ptdev->iomem, PWR_CMDARG, args);
+		gpu_write64(pwr->iomem, PWR_CMDARG, args);
 
-	gpu_write(ptdev->iomem, PWR_COMMAND, command);
+	gpu_write(pwr->iomem, PWR_COMMAND, command);
 }
 
 static bool reset_irq_raised(struct panthor_device *ptdev)
 {
-	return gpu_read(ptdev->iomem, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
+	struct panthor_pwr *pwr = ptdev->pwr;
+
+	return gpu_read(pwr->irq.iomem, INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
 }
 
 static bool reset_pending(struct panthor_device *ptdev)
@@ -92,12 +101,14 @@ static bool reset_pending(struct panthor_device *ptdev)
 
 static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock) {
 		if (reset_pending(ptdev)) {
 			drm_WARN(&ptdev->base, 1, "Reset already pending");
 		} else {
 			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
-			gpu_write(ptdev->iomem, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
+			gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
 			panthor_pwr_write_command(ptdev, reset_cmd, 0);
 		}
 	}
@@ -182,11 +193,12 @@ static u8 get_domain_subdomain(struct panthor_device *ptdev, u32 domain)
 static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32 domain,
 					      u32 timeout_us)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	u32 pwrtrans_reg = get_domain_pwrtrans_reg(domain);
 	u64 val;
 	int ret = 0;
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
+	ret = gpu_read64_poll_timeout(pwr->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
 				      timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
@@ -199,22 +211,25 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
 	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
-	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
-	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
-	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
-	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_READY));
-	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PRESENT));
-	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PWRTRANS));
-	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_READY));
-	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT));
-	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PWRTRANS));
-	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_READY));
+	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(pwr->iomem, PWR_STATUS));
+	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PRESENT));
+	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PWRTRANS));
+	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(pwr->iomem, PWR_L2_READY));
+	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PRESENT));
+	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PWRTRANS));
+	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_READY));
+	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
+	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
+	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
 }
 
 static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
 					 u64 mask, u32 timeout_us)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	u32 ready_reg = get_domain_ready_reg(domain);
 	u32 pwr_cmd = PWR_COMMAND_DEF(cmd, domain, get_domain_subdomain(ptdev, domain));
 	u64 expected_val = 0;
@@ -241,12 +256,12 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 		return ret;
 
 	/* domain already in target state, return early */
-	if ((gpu_read64(ptdev->iomem, ready_reg) & mask) == expected_val)
+	if ((gpu_read64(pwr->iomem, ready_reg) & mask) == expected_val)
 		return 0;
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, ready_reg, val, (mask & val) == expected_val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
 				      100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -279,8 +294,9 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
  */
 static int retract_domain(struct panthor_device *ptdev, u32 domain)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_RETRACT, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	u64 val;
@@ -289,7 +305,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	if (drm_WARN_ON(&ptdev->base, domain == PWR_COMMAND_DOMAIN_L2))
 		return -EPERM;
 
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      !(PWR_STATUS_RETRACT_PENDING & val), 0,
 				      PWR_RETRACT_TIMEOUT_US);
 	if (ret) {
@@ -308,7 +324,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful retraction
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
 				      PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -334,8 +350,9 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
  */
 static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_DELEGATE, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	u64 val;
@@ -364,7 +381,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful delegation
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == delegated_mask,
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -412,7 +429,8 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
  */
 static int panthor_pwr_domain_force_off(struct panthor_device *ptdev, u32 domain)
 {
-	const u64 domain_ready = gpu_read64(ptdev->iomem, get_domain_ready_reg(domain));
+	struct panthor_pwr *pwr = ptdev->pwr;
+	const u64 domain_ready = gpu_read64(pwr->iomem, get_domain_ready_reg(domain));
 	int ret;
 
 	/* Domain already powered down, early exit. */
@@ -456,6 +474,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
+	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
@@ -466,7 +485,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 	err = panthor_request_pwr_irq(
 		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
-		ptdev->iomem + PWR_CONTROL_BASE);
+		pwr->iomem + PWR_INT_BASE);
 	if (err)
 		return err;
 
@@ -475,7 +494,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 {
-	if (!(gpu_read64(ptdev->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
+	struct panthor_pwr *pwr = ptdev->pwr;
+
+	if (!(gpu_read64(pwr->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
 		drm_err(&ptdev->base, "RESET_SOFT not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -485,8 +506,9 @@ int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 
 void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 {
+	struct panthor_pwr *pwr = ptdev->pwr;
 	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
-	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 
 	/* Abort if L2 power off constraints are not satisfied */
 	if (!(pwr_status & l2_allow_mask)) {
@@ -512,7 +534,8 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 
 int panthor_pwr_l2_power_on(struct panthor_device *ptdev)
 {
-	const u32 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
+	struct panthor_pwr *pwr = ptdev->pwr;
+	const u32 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 	const u32 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
 	int ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index ad3e446971db..9cf7a715066f 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -5,12 +5,8 @@
 #define __PANTHOR_PWR_REGS_H__
 
 #define PWR_CONTROL_BASE				0x800
-#define PWR_CTRL_REG(x)					(PWR_CONTROL_BASE + (x))
 
-#define PWR_INT_RAWSTAT					PWR_CTRL_REG(0x0)
-#define PWR_INT_CLEAR					PWR_CTRL_REG(0x4)
-#define PWR_INT_MASK					PWR_CTRL_REG(0x8)
-#define PWR_INT_STAT					PWR_CTRL_REG(0xc)
+#define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
 #define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
@@ -20,7 +16,7 @@
 #define   PWR_IRQ_COMMAND_NOT_ALLOWED			BIT(30)
 #define   PWR_IRQ_COMMAND_INVALID			BIT(31)
 
-#define PWR_STATUS					PWR_CTRL_REG(0x20)
+#define PWR_STATUS					0x20
 #define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
 #define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
 #define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
@@ -41,7 +37,7 @@
 #define   PWR_STATUS_RETRACT_PENDING			BIT_U64(43)
 #define   PWR_STATUS_INSPECT_PENDING			BIT_U64(44)
 
-#define PWR_COMMAND					PWR_CTRL_REG(0x28)
+#define PWR_COMMAND					0x28
 #define   PWR_COMMAND_POWER_UP				0x10
 #define   PWR_COMMAND_POWER_DOWN			0x11
 #define   PWR_COMMAND_DELEGATE				0x20
@@ -58,26 +54,26 @@
 #define   PWR_COMMAND_DEF(cmd, domain, subdomain)	\
 	(((subdomain) << 16) | ((domain) << 8) | (cmd))
 
-#define PWR_CMDARG					PWR_CTRL_REG(0x30)
+#define PWR_CMDARG					0x30
 
-#define PWR_L2_PRESENT					PWR_CTRL_REG(0x100)
-#define PWR_L2_READY					PWR_CTRL_REG(0x108)
-#define PWR_L2_PWRTRANS					PWR_CTRL_REG(0x110)
-#define PWR_L2_PWRACTIVE				PWR_CTRL_REG(0x118)
-#define PWR_TILER_PRESENT				PWR_CTRL_REG(0x140)
-#define PWR_TILER_READY					PWR_CTRL_REG(0x148)
-#define PWR_TILER_PWRTRANS				PWR_CTRL_REG(0x150)
-#define PWR_TILER_PWRACTIVE				PWR_CTRL_REG(0x158)
-#define PWR_SHADER_PRESENT				PWR_CTRL_REG(0x200)
-#define PWR_SHADER_READY				PWR_CTRL_REG(0x208)
-#define PWR_SHADER_PWRTRANS				PWR_CTRL_REG(0x210)
-#define PWR_SHADER_PWRACTIVE				PWR_CTRL_REG(0x218)
-#define PWR_BASE_PRESENT				PWR_CTRL_REG(0x380)
-#define PWR_BASE_READY					PWR_CTRL_REG(0x388)
-#define PWR_BASE_PWRTRANS				PWR_CTRL_REG(0x390)
-#define PWR_BASE_PWRACTIVE				PWR_CTRL_REG(0x398)
-#define PWR_STACK_PRESENT				PWR_CTRL_REG(0x3c0)
-#define PWR_STACK_READY					PWR_CTRL_REG(0x3c8)
-#define PWR_STACK_PWRTRANS				PWR_CTRL_REG(0x3d0)
+#define PWR_L2_PRESENT					0x100
+#define PWR_L2_READY					0x108
+#define PWR_L2_PWRTRANS					0x110
+#define PWR_L2_PWRACTIVE				0x118
+#define PWR_TILER_PRESENT				0x140
+#define PWR_TILER_READY					0x148
+#define PWR_TILER_PWRTRANS				0x150
+#define PWR_TILER_PWRACTIVE				0x158
+#define PWR_SHADER_PRESENT				0x200
+#define PWR_SHADER_READY				0x208
+#define PWR_SHADER_PWRTRANS				0x210
+#define PWR_SHADER_PWRACTIVE				0x218
+#define PWR_BASE_PRESENT				0x380
+#define PWR_BASE_READY					0x388
+#define PWR_BASE_PWRTRANS				0x390
+#define PWR_BASE_PWRACTIVE				0x398
+#define PWR_STACK_PRESENT				0x3c0
+#define PWR_STACK_READY					0x3c8
+#define PWR_STACK_PWRTRANS				0x3d0
 
 #endif /* __PANTHOR_PWR_REGS_H__ */
-- 
2.43.0

