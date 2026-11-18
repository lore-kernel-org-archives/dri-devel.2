Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F71606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XXf5eJt1;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XXf5eJt1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED52810FEDE;
	Wed, 18 Nov 2026 17:54:44 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5888510EC7B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RgGoQtlg93c0SSaWUjCXdhmaqISpu3bIZ+vFCBFSxScKOC9YqjTRxdNcNtuVI8kyoaDoGGIyNsDlx4InsC3jtI51VaDP0RWvFbFo0jRWc1xciCVRMjFI21updXTga1R7mMexrVRaRfKD6/j5KGIzPY+nA9zPXgehpzUjK4n+JzPdP11pzZhICG0yufvF7MOPn4WXwdu7LI3zmwkp52+ptyQ2HVfnEtStjHs06/z3duJ8hzfaWhnCG+CCWIsystntNAozQOiKFl3YBlFkdfQ80Jg75xFr6PbEjMmQHtJd2JS3jrEkjcJH1x3o4N06qbjsU3q1rTjjmJV0qAYbZZ+jsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=h/WMPv9xZETtyt2h3kSAIcQ6NOsJsuQPjHYYFiioO9It6649HThBZEL+dr+UzrUw5DB085dyqMemC7HR6jCRLUfq0LKNBiUyiCPPTCg4FoTqOxedzrS/RPQtS+IA7T7C7I8XWllMABfUEpCeV0znvqaRaWvP/hHn5bP4nBNsKcsXRuk/6C1ujJJZOrlGqmtodQkK74E+CxAR0jtRciMCzTNU6+Pvy8Xdgj30hOlxD5fuotKymMSO3zAir536E4R6vJL0zd0kuak6QNO/A0yZDtOjP2JtRWs3Xn1XAYr4kg3dk/2gsSpEJ+sq2DK080T+2Hz+3xlKX5AqUAnMc+O5Xw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=XXf5eJt1izBU+n8rdv+rIpIwVyrpAxNgvDoUpChr7JdqAygtIloYDZiG6wXghTiAOmdFxRhcKTIZSmHErBRwHAJWjp401pcnB9XZ0E3MFYnnUF8Gx6qVUPXRmF/No2NToLNmAje6rQzvSXiupEYOUkuLVcUCfcxnUlNbS2lfNu0=
Received: from VE1PR03CA0022.eurprd03.prod.outlook.com (2603:10a6:803:118::37)
 by PAXPR08MB7333.eurprd08.prod.outlook.com (2603:10a6:102:230::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:21 +0000
Received: from ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
 (2603:10a6:803:118:cafe::9) by VE1PR03CA0022.outlook.office365.com
 (2603:10a6:803:118::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 17:54:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6BA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3Fi+KyY7r1VImoLKVwq5NNYST8VwZQ86IMlF/aSFWBGxw0hi0Gk57l0ZN+Ts8zrCyhG/TsfGdoj3p4LRpYZwQndwHL10WJkLtIghkCPukhWCgWZrVmhtl1L5RYBsiJDdL5RWZAe1+SBURr1ktb/Xpekff8rLNzKrDzRQVmp3uxzgD1GHd+xMrwz/HBFIpeOAPGRsuCN0/pI/MO+K43cu2PJLL4QOJk8r7ouY8DlZpyQhLt/656YuLC/L+k+pk9EMg6Cci1sre+Fe8ts41kt94jEpXITrG4sl4ZeCuNxi8kjzO2Ia63deZNN+WiFJAVyCz5YHzHrYDafifejDrihLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=Ybxp0fMPQjG6aruyB4gMkOq3L7g2JzS9BQ5KkEhKqwTpKfwO4LFGjFBWLmTJAeRracjbGb7MJTo62Su5tJ5Poave0YYpO4gEI47Zoh7TZsnQyV4iRc90MOOIhuJl/sX0jafsTZFp1nDS0CkzZA5uIX1V11fuez2kBl8S0E0gLukblGjAt5fITN4iAdI9JNn2wAAXU0ip1mKUeLMv83E905yqEW4ZtE7oMS4bWHL2hGcGMwsx6kjgztHbNYJIgY7VTCdl5dUs5PuzJhmkvawcPW4Xw/OzkflVA9w6LQhNXTLwuGQ9mIz6Q0FcdowfLwQMecX7g96NSX7yhe+8KdclAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=XXf5eJt1izBU+n8rdv+rIpIwVyrpAxNgvDoUpChr7JdqAygtIloYDZiG6wXghTiAOmdFxRhcKTIZSmHErBRwHAJWjp401pcnB9XZ0E3MFYnnUF8Gx6qVUPXRmF/No2NToLNmAje6rQzvSXiupEYOUkuLVcUCfcxnUlNbS2lfNu0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AMDPR08MB11410.eurprd08.prod.outlook.com
 (2603:10a6:20b:718::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:53:48 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:48 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 02/10] drm/panthor: Rename neural accelerator feature macro
 to NX
Date: Wed, 18 Nov 2026 17:53:18 +0000
Message-ID: <20261118175332.519657-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AMDPR08MB11410:EE_|ZR1PEPF0000E6BA:EE_|PAXPR08MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 17df6b51-ba46-4d67-e899-08df459cf946
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|261021123027099003|10067099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original: oQhqVbzXRmi9u3NP+VWcQAudblF5xut899jBhuXixz006Wn/FbKbbaV+PWt91YOCnfWQLqqa2zRaFlG99mzlXp0kktT4xHz4FN0y7rdjNJV2z0MRiOlVSX4icd0eTBytNGGkC+VcWrdkkx6Ok+7a1kUMZIcELaUJTVBgrFkBUSC6HGnMiwZbZ62ez/vqMnunZIvpZ44feNtOIWbsm14EhzAn+lXnLt41ss4T0CEjCFerRcWBDU7tTv1GS6toP540O7FX6rR8m5cyDT0YRCn1T3UQ/9vLRFxbGQk78jILf0WZCewgBat5L1xO8r+ZTYhkM11jpTV+yS5gmDlgswxNCS34xbNSP4wfpnIfc0aeIRPAq1eaV73dBfWo4nRwFR56fYA229/FUqaGEXbUxQatRxNU5fUsVPN3wwgkH/g5y4/S9CYt6y9BKGQJS2Xoso5IJ1YcRefx2F9AwYjebawM6iBsdzdpNJn4FwJG8ZvV5bjlVbngQX9+D9bReGK9I887iq7t3QqgGhuGrfeRWNgPWK/Ynz6VzlAZLaofyuhpS4dqwO97l3mozTp2aNbBqXE0cluYN05lwI1Z9Bhtqpc1F63CZQz8YuyFbflrsRC4CP42JC533Em3Ukw0sbE9uyVcN/tzJ+LK4Cn/NwRfIyEqnaTUcjj7kv/F4IraHxkXAF0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dYehRGzJ6pktLqQOJRwRO8dgEJfbzUOf5YGQ/9OSO44fFzqzU8XBTmxHPqnyJAnpQvMV1IIk1bfse5OwFB5H28c1t88qQPnpUqsPUPwp543cDhofyx+9UthV0CeYCzdY6edy81ea7v1Hxq95xzdbVWA8xXNXCAsPnAckDXmopEDDJE1nf6IBGom5i3mBDte85xCjMDG0oh/WBxQd3yi8se3z+bo/FUlhppHmufSQG9XOW4EzT115VoyianfgVUFEnGziQbFDSRYhSv22AcceLzZEAJeSvQZEJXYJVKOtXTEOS1bDV/iLlohKazvbN13oFCjxKlnTmWFYwzh4vxbSZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11410
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6753f852-3ce4-4f2d-2915-08df459ce5e3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|35042699022|14060799003|1800799024|22082099003|18002099003|11063799006|56012099006|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: A4sTPZg1pKg/D5MFjM52Mz8FoXrw0kgeU2LvVCEhdx6aP7p4Q8F0YzvR4hZ5enBaJ1sGmV3HfHBLjBmeLmffhOMsQt//tstzap53OJXl0py+5f1Ky7OG4xPcm4YpGMHDr2N0jRUOpo2+XGUj+uKIa2xH1YlHMc8zpzf1xeO//X8drOJI0n6l/LeUXMdu5YN8IIoogWsvB9i8HdSLHwc83/q09i/ElGkMhc5sexYuVrO++E8MzIB4YOcBuwaEFvSagKFp3lZRX81F9K8NS4bENMujPCkt7mPIBQg3TITkua57r5AaCigH9DQkQgll5XsvUGruvRXgKKBbQNDdLJNcZ55v4slk7tmdcjF2ra5VqGGFlX84jlOtWTnCNfnjXZUOjP4a1kwiNHoiWDwWwaMnoUuoOH5h75xjUJubIyQfwUMdFc6rpqsDO0JG6ts+vvyEF69Y+Ro99I4OCF2YWWHCNGWqnsLolXXLqcYZ2g5Ze0ycT4TcRflq52F5FP1Q+NfA1azbBXw5INnI2nRd5iCGYtUj2UgziFK8XjEfYT+8XeYLjEGys3GDCJgUyEszn3cy/LtgmRctMphufHaW7vHlxe6Tr3aiaZndT2K2rdWnNyZSYZnkgPNoWqT/pEwAcHWPcGQnjCAQUzY5iD1Cjqvyn0uxEFXmRnJo86KHfRJg9Mgn1Q7T0JRp/jw4PCCP85IZVU5Kn0NrpTwyYoCeJURTiw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(35042699022)(14060799003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C8/MWefNHKQdcwbTwSWdwzMHEZPrxA8GdTsl5PMBBhv38Vxm0HuH5Q79rAt0Z7GhPFS7H8uYQajt8cyLK5V0j9IbM8KpQf8v631OM+yJtTHZj/ym2PlnxZxLEZfVkgKun2Eom61f8au76lZdilYm9sWuFUUAZIaxAn/sTq6d2GKk66HNIKina/f0UKBRkLnQ8u5RilExP1r7zDzbSEb8ObCOJm7uv8XtvvOHoeZnnG7kLjpUGQVClhz68ngF52L7zEW9XiIbH/67qyw+N45VdcCaQwMNPp3IhY4Kx23KCfsHo+sqkg+AXui3mCF334MzvGzenbOsjOTZuYD2kg24FiAnJQVtBeC02V90sjrtV6I2Zo99NkbFuNJXcCvz9kejUnKFDGDn/DF/9B+ezH614WPMFJcqyiDpC1L70jVdBdCm5b6VSpEPho+4tLC2oclj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:20.7895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17df6b51-ba46-4d67-e899-08df459cf946
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7333
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

Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
Update the panthor_hw helper to use the new name.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 2 +-
 drivers/gpu/drm/panthor/panthor_hw.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 5340966caef37..c7581b6d4c5be 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -67,7 +67,7 @@
 
 #define GPU_FEATURES					0x60
 #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
-#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
+#define   GPU_FEATURES_NX				BIT(4)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
 #define GPU_TIMESTAMP_OFFSET				0x88
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index eeca936f44bae..f770dc40e6216 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -64,7 +64,7 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 {
 	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
-		ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
+		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

