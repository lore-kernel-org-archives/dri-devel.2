Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE33F459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1FC10E9BD;
	Fri, 10 Apr 2026 16:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jrPtdPq/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jrPtdPq/";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C03510E9BE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:48:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zKJi7nLplsLf2mCpzEN5DImMFMx/aRyLPNiNZn7fOUW58U0DcY/Ut3Nm54Phvwg6i1FUx4Z1PTg9oEEoaZtgzIFF3K5POIdf9BNiSwVZe5sBfIaL0V8hu1LcUA9al155kEsfgbCmuOPPqIJ2Qhn23UgByH1K+9nqqvdBBgUAXt0rPxmENW5FSnWzELoTgWToBBOY49s9190VEyrBuKDpVBNbOssikCex+XWiCVLy01R6U6vjNgBCl0kMNskp2k8bOawfY9HVTZaG966Mwlwm9FWR0WRAVs66cl4V4PAOddjCwQB0Q9nr+p1H5N+ZjdliquJs4gTZOPmd7uMO2ZQd5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMOajQJNpIhyiNcCOQQTixpdmESoccBNs5P4xXQ3lFM=;
 b=hy9FJVMPxF2TNL1ZxHodMkoQoBKJ3FYowdbYzl6+QHbDMA06V+T0wDFV4TL+fSV1/115fTGzX4JhWzYtbdbTPUbngxQQbpRZbqwuop1LypLcebWIFY+HsKjHshEuf8MtlF6NdqrESKAaaxCcs5PH80oU80ecOi5knfMvUkKz95xSOkjgth9BIDbA7ild4ASenwFost+Zb1AvU268pN0vZUJ6GatGzsHIoHfSOSYZBeYL+ent3lBrzjcBRuLO+Id91Q4d66Ssczr7XYlo9p6pvL4avKNtX+rwMfuhC1mQWP9LiyR//Nm6znCO+8lrg3TUZmQI2yMia/nb5Qa+xTijvg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMOajQJNpIhyiNcCOQQTixpdmESoccBNs5P4xXQ3lFM=;
 b=jrPtdPq/O+fphV9ApzgF7985V23w5EH1U3M+sYSrCmczu5qpPymZ/uA6MfMLq7CRw8dPJ01JGP+C8JhB9eKdqNo13YsVEQe6JhyjjMP7364ijF/OTHbuulylMRneGlBscPMATnx1qGWqU97NUMEQLOIYFFn2p9gJJ42yAB1q6EU=
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by AMDPR08MB11674.eurprd08.prod.outlook.com
 (2603:10a6:20b:73a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:57 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::d6) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Fri, 10 Apr 2026 16:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9HRhBZSpEqNcDm8b0PiqLdYXeXqrQGpLGWP1JU4EQuO9TYwXA1rBdQ33OPGYRDYLEcFN9h4JcG98HpyFlmI4G5Nb14vJLWCR+wAwmjVxtHz+0MXxXLWis1VPYZmfueSuN4+h04rFV69011HZF9TTFII7WuTY6bgWrhLo+pTrfqxSULNuJcjLepUYhA2KtssQZuK6kgpQqwB7NpQkfILzfhyY7o50mAM3ga6Qmtl2kewKxi6CrIOzgE4/lTgevMKnUg90N0W/ci8A6kxJ6O+6gQCl/W1G64bweTpBdiBmzZOjTkJk53Pa1WULxdu75oeKHRlsNGI2e1f8NVAVxEQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMOajQJNpIhyiNcCOQQTixpdmESoccBNs5P4xXQ3lFM=;
 b=k2Ft4Nv+8IkjXtxpzVtSjyH2qHKmgnxSoYaqtWjg0gG9EiXx9Io25pVosiYWNuBGJUACLcXz6DeaQYDqEwVC9dt6OF2lO+0Y5ruUe3CsNuga0EH2BwUPZh10NA4ee0rJUFGbpRYnUFjRniiHg4OuJ9Uc5L3mCk9d7j33REp8lehnoUD9V/HFOM4T+bnRndNtjU84EjN7Xy66/jkgXmnDhMPAKLYKa1jIAb5O5lELJVPL9Ug3YTjWz4AfXGE6Y5PdIn02KCRQbwp7HajIdwuHO34jcIxr3YGi1uIM+xHsWMT+B3lcMV2h7ud6u0zByUHZE1I1D466/r94KUSG3LRqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMOajQJNpIhyiNcCOQQTixpdmESoccBNs5P4xXQ3lFM=;
 b=jrPtdPq/O+fphV9ApzgF7985V23w5EH1U3M+sYSrCmczu5qpPymZ/uA6MfMLq7CRw8dPJ01JGP+C8JhB9eKdqNo13YsVEQe6JhyjjMP7364ijF/OTHbuulylMRneGlBscPMATnx1qGWqU97NUMEQLOIYFFn2p9gJJ42yAB1q6EU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:53 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:53 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/panthor: Use a local iomem base for PWR registers
Date: Fri, 10 Apr 2026 17:46:35 +0100
Message-ID: <20260410164637.549145-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|DU2PEPF00028D07:EE_|AMDPR08MB11674:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a696ac4-8b61-479b-7829-08de9720ea9d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: gSVfTYRcauEmek7r6AsgLPIz3CgkEtBiHtKDDaJu5pLq/SxUxP50IVYEZt8MCop6PMdSrfT3iYPFf4ggHF6+1E/2P0N1V+2AbSBy+URhpOpmALJcoWowmSyQQRhmGxBMXkyBVxOr0cWITd39A/WFZP5DkV8gCe1na56HBxQUyyhzCpvkA7G2DKeUl3ZQ4Dc9pBXrI4MC/qngYORNSI6x8WwMEP9FDzXqIig/k9rWc6hgAkV/jeNJ2GdKA56cUiGe9P0SLkUzqkNnCpMxtakRuevShvghHByYZwHPtkuJav6iStQ3Pk50XZB01xqxB30o7fg94nwVZJD6VJGl1mzizMxvs1gyjG57ZUnWrUXb0+rdhyT6F6+vLqtzT0wTAzeWBK3tFlpDgopF0yQUzlhsznqOFEC53HFGe7Gocl3dJ417xGqP4fbQES695ZHYYS3MFNgyCQyGhnxN5OsACqXsaj5OxsBJMA4OgxH7+BBO9Z6Z8DxyOwomGMO+fVxpEpB4Y4THaQEjNV+ZyUPzC+QP87tTR6BQcQlDluxmN67MBmq5sSTcGQQpWB4Mb19uW1/rvgUa4Gz3fBeeHgC36N0sg7mkdR2u2v0W1uas1XvGjlIcpXS7hT14mFvk84u24vPKQ8wn9UnGK9j6VoNdJlfq/sJlrd6zd+o1S93jaRrxQ7rZrnx9dZIJWU6HZYcrZd1k+TJ7CtSqpu7EnzvVhn4jcqNuvqa7LC4+44XvV1JxFqg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dXkUGEsu/sgLAUW4OVSmWKvmoTQlDzxoR+6EBhUszYFgTWgoJnEU8Kb39NlVsPkPLOgg+zj5OBc4KAR1mZ0wG5aV3XuLv1hegajSeCpct1ojh0GEq/lqJ7y9jlElyposMzUhXk4Sn8IGMynWWDkejY3tBaPMueNAtPmS/w82u4MxfHbw5oZRyxBgPVmOdtpHqshJIjXLPBiDXdyOiZq7keQLh2OnpGj6/hNbzZxMqORNUJPorZmgg7Nk3ZTmt/arN+mLH59Wsx62vI4OBJ5jgk3gvz6jY/GKt7HX74IKkfTyJH4uHFsncPsTv953Ugy0B9V9bCm/zPZRJkjzYpeqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cba7dedf-6b49-4aa3-2a95-08de9720c2a1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|376014|82310400026|36860700016|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5oIhulKg6BV9UzosMwBFyTRrQOTGnhSDikDP0BxA97T7WWxTyxm5xVVE661RtUjapolANOgUKx7CEywk3YRrG9Tl5JOYSiQkt2g6q1ZJUPcMLTC6hV55Q3GZG+ovFDtKAygzA84jPNJ4PTas6+yLVMczS8FaYEi4MlYGjaqD76xJ38GlL0kHhiVgdgNc35yovJywKMhbWCEZgnQzU9qZjhSiqB7anjqD72ol3W26d7vVFg+RnTOxwIQVInbUgAAm2dgdUzkiwll5wOsswOL2ig6ivaWPB85R1z6ImOyyk3N0kRGqg8ZS6FGsbvvRqvzKtG0+mg72j8Ua7oQTJSLg89nHHoo81pYjvJT1r0qGPYfMYCXXGFJZBkZp3Rr2AKp8RSpBbkgmVi95b+n0gb9brtDtIW9i06Z6ZyBrEiYa75Dbm7cMXFXtFDTo/3VKLHYYRcqUPA91QaV1T0zru2qZqmmxrCJZDG/8c+wXagtMHKJlmXUVSYzcOiKdngvf651n+c3Ad63PjoaYtosFX9qCr2cqpDy3VV2dEt0TVZ+wG+StsuN+mCLdtmLhggvQxs+RodCJW8k5LYaBLyZNWr1MjIV+behVPVCQIBk1YACsmFi0Vzwwmi/HxIlgPyA9IYBnfs4hJUM3E5vk4ElhjNN00pI9SXUtz0irXlm7C2icLVPSOnjXvWAa9Cle7vgLOVKP+iN8IbQQabSGdhWGt/MuD6mh7/lpHYOG9IZn1M3boG+SYrNh1HxHdbD0JsfvOEFw6FcTWru7E3mBSjJ9kYps1A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(376014)(82310400026)(36860700016)(35042699022)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LYLi4/g/ceE5cyzVGxz1pOCA6hq/fQPq8mJIJhOqU5VcvCSpwQVe5OUPyIQxFK35Bbx6ewbnJ3fBcCQXOMr+Xq8BUN1JWPS6FHe6PzFEbjPPEZVRZ2nbaq3pw6cLFuT58T0Uqpj4UtwFZLy4e8/rh/BBuvVluA8EBGACFXHI1LkDrdNq+scwdAFFbLSEM3l9qOLVnlmv5rllkGj2lYgl38T9jbHG4X6XV4Abx9mQkGymv1IG12q7edrXRuCMHeUitGl2kKGa9YaKZYIA/QYsWKNCkealRZ6mtFgFz2i6reRBwaZYPGGOCgotSS8p/BIzDnoUfSbT/lytbDT/ktUuUm4A+FXyT4UbQZ4avJfzcAbMgmGvYUpxDsirF+yyPFuDwVwHzmTF2u7Vuca+m3pONUUqQuWgyh7T4i1Wgq331DSBNxaMXEwYAKmiwzm5rZsJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:56.2991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a696ac4-8b61-479b-7829-08de9720ea9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11674
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

Keep interrupt register accesses on the IRQ-local iomem base and update
the register definitions so the PWR block can be addressed relative to
its local base. This removes the remaining dependence on the global
device MMIO mapping for PWR register accesses.

No functional change intended.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_pwr.c      | 79 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_pwr_regs.h | 50 +++++++-------
 2 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 4f600a6688f9..f7fdbd15abf9 100644
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
 
+	pwr->iomem = ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
@@ -466,7 +485,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
 				      PWR_INTERRUPTS_MASK,
-				      GPU_CONTROL_BASE + PWR_CONTROL_BASE);
+				      GPU_CONTROL_BASE + PWR_INT_BASE);
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
index ad3e446971db..1fce05c3a96e 100644
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
+#define PWR_INT_BASE					0x800
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

