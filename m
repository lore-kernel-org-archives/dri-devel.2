Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBC606A337
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fSwtp0OA;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fSwtp0OA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8326A10F798;
	Tue, 10 Nov 2026 15:40:37 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918A810F542
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q7yBkwgJHPuDrIrIIGtUgUkmm1b2Y69XAfBicpTVnz/ECUIexhVMC6iv5KIJ8IlPqMGS7JfaLSUzOS1ABaYhqpY5boeNKDBksXcy/CdXQCBMgraIr28lWN9npvOyw2TBihetAiQvLoKiOMxnKyKUx6A0LrBeC9EvryBBR86g32furNA4hqz5oitx9w0hhzz5UjoHW6nbb67f1JsprGImF4KXEfwEl9d7hx32CO9FUelBchZ80qqJqZVdi6NOBWDMii1FlbPxDGU3/78bt4ErTokmj1j5BIxMwDoWsxaUdT2EzVOwC4FonWDpBkK3bS8Ci+nBaSfbCOj27+yAzsGw/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=EsiNJrHcqJH2MO2d1FIciPy5XLiIcBTC6S7c6/CB/C2hd7PG0lAPZ6Qz5Ubq+HDiyUGsSTHC28kVirGCQE6Bnl2kladJerjU9yJ5bBWgSdcopJh+PdaLNEEtZwJiEaOOycHIOiWD0bigmHT1dCKH66pJgyAAyx1gtCeOfBGZ2mV4b1UsXJLXH4x9Wgj7idrd/4oN2GN+2vcmRaUzWwILN15+8H4Ft9K7cDKWEo7L1p5+JXiAw9LrMQ+qdSrUGyrPl1SeVWX4apYxDwe3sx3/JTQjbZv365FE8+77AoPNrv/jMn4oI716JFDu1mYajdv5dTlJpzuBzwiGPJqrKZlJEw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=fSwtp0OA8LLg3dwJEe8FbLrwF5Y+7KCk7nCRF55VVdNYK+p4Zpw1blFs3vsi1xk7mkcpXc4ByH8tSmJ9rNehXK1OsoE+/Dj4edYOWK9eBU0hzV14D7t46z0hHquKcwbZES71f88v/UI0piqU/3abrTa6S3Wzy0WyI2juY2kiJxw=
Received: from OS6P279CA0126.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3b::15)
 by AS8PR08MB8658.eurprd08.prod.outlook.com (2603:10a6:20b:564::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:18 +0000
Received: from CPH1EPF0000051F.eurprd04.prod.outlook.com
 (2603:10a6:e10:3b:cafe::77) by OS6P279CA0126.outlook.office365.com
 (2603:10a6:e10:3b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051F.mail.protection.outlook.com (10.167.241.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i14h1nyJ6TzRGPaFkt/6c7L5ilOu7Ff7XjXH0A+54yt5xnwi0VjudxzEzOsvaPLRkg6wBCZmp8KIZvEuCdSFGkFiNLPzPQqLuNkGAQfFn0CvxWd1vxcYsKKdaCqPXhdn7OrFztw3713XVh0F8pE4McRJOVYoT4bw00txNIbeY8PqGOQg91keUe5u5sJas5+8soaAEQ/VfThyB+nDJx0Weif81voron0Ng5az/Q/7pYpxzfnvA2sH2Gx7SBn+P3CxTapTqqww0D0ZiL7Nnd3qgdSjlUoMCeZMackMkmJFpQaHpW8bbtwdhO3n+CPnK+SFXlUNoW5Ee1GeOaIqt//M1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=D7VT+v5+3/uISoJlPRVHDbvt+Mm6ULQjQqZSGtV9tzPJ/N24jQgrJmwgUA8KR/jERobD1DqaL+NHroOs5invXZwId2XzBGljY2NC4bK25pknv1VSU9qwc61negckUpkiIHLH07NQuD/Mid/GzjLspNko2156geHPYqsUB/q2qmoJC4AzbCjU8+ztLkkjFgEyc7M3aCeEwfrvA4Oa74TtgMIgf7eU/9/jmFWlz+bxuBZgIEwEf2Idt8pkF260p52sD5Lw8afsDSPb513TMO5nAaPgFcAlAI+QWYvNF74m5Kvl+MlNfcSvC4bVLSmI66aVXl0uTjzfPo1je3VPMG5f0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KangYyxmJHQmw6xhktHM/8J0uPhIWKAvOeWQ7UoXARg=;
 b=fSwtp0OA8LLg3dwJEe8FbLrwF5Y+7KCk7nCRF55VVdNYK+p4Zpw1blFs3vsi1xk7mkcpXc4ByH8tSmJ9rNehXK1OsoE+/Dj4edYOWK9eBU0hzV14D7t46z0hHquKcwbZES71f88v/UI0piqU/3abrTa6S3Wzy0WyI2juY2kiJxw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB6616.eurprd08.prod.outlook.com
 (2603:10a6:20b:319::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:39:40 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:39:40 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 02/28] drm/panthor: Rename neural accelerator feature macro
 to NX
Date: Tue, 10 Nov 2026 15:38:23 +0000
Message-ID: <20261110153907.3241978-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::32) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB6616:EE_|CPH1EPF0000051F:EE_|AS8PR08MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 9190b538-1b6e-4544-4f1a-08df3f40eb7d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|261021121427099003|261021123027099003|261009223027099003|56012099006|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: jG/ttOs+wXjf0C18lponTHAx4CLBsZ36CeobqdcF5i0FzqexglNu4I93iHyYCVW5Is6brBjT2Y0ObO8Df2OEEvFMsrHVRn0F520HHXXKTSLAhvYlAbY0jrg5VG2g+zD2AUMQrIDAiSQjYRR2Su5Ihb76K3oCbsKv6prGKmdmXcMtr4yY9urV9AFdZfpwMeDcELUY/hqgVrHAvI0DdGcUwY5ftGR0480DAK4SpfnZp9kud+P6dirVKqTA4DWnKTQdtJpWqN6lssbFZLyl2e66gvae9kNYGljAzhCvIKyfkUBf96SMQY9h22a5VTFlG6bcqODObMdP3pNNq4x/dUmD03hStU8Ovey2lWAT7E8pYqpNjY6J5+N0gNJn1JeVrPliZZGxyv8VJpaz4SvaR5zFcciJMpvRVSrXeJHi69nnqJx0zTRzngiU8rTJRXJpO01omnnMItVk1Y8ZeOxWe6dae3ky2I3Ch/IfWp/Ln4ZP9HWUG8vUKJBOgUnc32GZxxcoEG1Ko/bE97jrt13XZpjjc8SVZF9IwcTAWGagaWREno+te8t66MGy4rgEHjj9asn39xs84FNxjYjefdpUQUNYhQU/1Vm2mlzMcxeQV9lyZjFPF+vctc2JsY/pJH9u+GuJcDwI5xCdsy5uGt0i6snr4wj9YVsOmEsteBwKlGab0o8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(56012099006)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: bpP2vq3UaXz2+iDOOCqKIjWjKCXdd5LsiwsXfAInUTeYmQStATY3N5XDELtXNv+IkqrAUFY7yvRdw09Nop6N7GeAisy0QEBUusPoenfDkJsyInP2qMDfr7l3r6NKE713FjwY1YE3VzvYUB164eGspF1/6qUV1URMbWxThbO7u8lstGNUvOmZABudwy1NfqdmA7jGajitc0FIc7E3LK5vLONH1D5Ji8rKvuavUshDeSlJQtih6VLjx6DTPvitEphahj2N62Hf9o35XPJ7sDg2Vg1UhUXNuultjJSTOqYn48s6LVYpxQih2gnz8xJFBCyA0XKojBRNxlHtyCMd8nps7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6616
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 729cc7cf-d272-49bb-f698-08df3f40d5a3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|14060799003|35042699022|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|261021123027099003|261021121427099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info: VM6MwhVKxzG4FobsL1/WJmDLCofVHIRWZ/97z/ioHBoNdLku4soAE5tOTlug4Zi14EVV4iM/lnme6MyaK6kPb0aplKtE1gmuWREF42UF4ZDyBwn07bk6Hp/sj9DJfErlb7GnLXAvPOTdvwo1KlnXqb/InnT4u/nrcouwLn1AGHrNf1yZFBkS7clyjQqunne4exfSzEi+X1PtuvZNpmtj7jMZ3enG3+bV9CMhmEn/xp3z5T75Kq72cPzYtM/7mgwG48kTR0DyxZU168/HTIT/h28rKfyB77jGcJ/UUlHO28ijzEhF4nc1c8v5oXhOzgYNEC9tP6VJ6hhRcYnnh0jvKnWB8NhB9kOND492Ol0SDnAnx6pKqWlmfCWrw5RhdecNPOEmSBEfYlNYYrxdkHUMyufqt2PiSWpeg58IjRyVtDobida9hHE+pxa52vDX6951waylsb/zVkvrXnpHUast9g/p+OkeGxJWTCitXEHWPCgwuM0VuOW1DstL0LtvLJBMjyZ/nTxOcU3NrXl7N1Km7OSZm04I8h/lsjDVoAWdFraxHnEqdV04diq4T0eC/EwVizWKzloYpWU2etzV93X0nsEJehk74Nm1sWrlgIVIlncTYf675Ff8BuMFaFSU78rO1kosH8ATT4Y8wLCLUce5SGcG+i5Y0du9XCFWiSIBXw1dSqlE9x5y1IM1GIfYrWoPSgxgaq+OMQLN0gtRA7K0GQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(14060799003)(35042699022)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(56012099006)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CtgXVIFa+gCak5exAO94hBTHPhjTKYi/zXVgpA3k7xrdN6QvdPagUXQOWwKqwdlqpf4NeLJh1vCafAA7UiofuWqkEoEJjfebLRHs3rhNWjBNqnVZY8rzbaBsNINzNpFtoPxzXhWuWPwXG3ocgPSPm2qbAWCW9wctqaokgty7AL5qZI31kq41J7mc/gOxjo+19qJd35AG4ONKn40toNofgYz+D1esVvdRD2CoibYn53PZkkeAaygWPYPmI00rDaJxK3vKaCq2sA+l4EItkZczU8tk7Li85/ppn1Alojza0vU+vdTvTC6ffQZSCMagdsbWWLGJcfI7jGhLqdt8pDqG5g/aSAzNZA3k6q7k2Tc4D4j6drv0whA1oikzm9nhJOu+fZh4LNjauEIP+8N+9zMwpoKEl0LQccOdtOLABgco4sTYhq1IdNZ7TbCkQT5XFFma
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:16.9806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9190b538-1b6e-4544-4f1a-08df3f40eb7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8658
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

