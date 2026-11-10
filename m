Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9E606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PXq1hcT2;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PXq1hcT2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CBF10F788;
	Tue, 10 Nov 2026 15:40:48 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE8C10F788
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:36 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lOzi/swcz1kb9z5JKXyhYuQ86K+keOXEaZuoGuiBaHJZJGs7AsqOnBB5ox5w2sRYFuApcQ92WdA/kb6E2KRBBl4xad55vcgRPsSCBZiWh4bU0tHfO8M1hS4JIhF6nzwxud+cuoXf9nO8rprPDVLlz8NOCofUlDDC41r4a06Po06uKdYJc5DYM9FdVEtDOwxmm2GGgVOUvVaHGf4R37/L239FhLMvPQ0Okk5ZoBTuaOdTVSCnP+gk83vUSwtpwLl2p+q9do+DPdEs0oIWjSGs82FV1NDEOOArWX0u6PhUdXnXUpDcAbAjJQdQvNB5bkZahs8Z8LeUrKJ2uKMS4mvFcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=PWJc+NWhYKnx8ONQMMxY35L3NbaEOHYdSb1LCUirf9/c8bQeFvgZKjXrEuOawgV7PK3RO/Xb0G87PViNgwmQcpmU7GtD8BL2ospF3GO3i5U/fPJyibSqobZESloOQVjkR48DEb6P6sy+DLF8S9VR1Qw0YW2DPIX/KqZp5cMe3gWHC2RlG2x6sOSsXJ40NwbTsk7P/zJZC8g8o4EXoK2PbK5NrLPiKEQy2hhr+tr2xL7ktfJsXkoEZYWVxvZ/mOluggbYEZql+HHcBtbCbzidsUV0xHRlW00OB3Rzuu97qxxXzUXABmWotRl9QeXReOnTGmF1iycQhlHiUebAtdb++g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=PXq1hcT2S5tsV0oNNjFA/PeSZPF6iAWi8i59vniUdpS9GJQAW5ib5KEnouxA/dcDNq4BTBoiI6WFd5cZZF+55cAvduH5MzV/gmwBrx17w77spKbsX8PjB9yBczzdxtDoVkrYQoqa1AxdTM2heFOkwvexEJOIbHSL+qCztvfXt9o=
Received: from DU6P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::21)
 by GV1PR08MB8428.eurprd08.prod.outlook.com (2603:10a6:150:81::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:40:29 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::27) by DU6P191CA0041.outlook.office365.com
 (2603:10a6:10:53f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQyVmSgWm+51fYlQND3ezfId4MTatmipNxDoE7OUWk5atvZpjeV+JJoLsjfWMvWuYoyGpXVwfViigp2Jy98zihco663Hp4wL19U5HxipPokPNLfsi55Pgd/yIlO5EFUf8ke4GYojpIUTohvn3Q7mo0tiPo8j6E2rv9FA2tuZUKzHGQWbw5CTFngbHFjOkCFd8P1AtuhIOXQumdl8RA/i8/9nPxXppBypyA9VlyjsNOLeqD+nK4whwycQ1y1I3JaCszuWZN5eHl877Of7qzimhS1uAg2zWAAfQ1A8Pq4ey5YfMnkV/vHus7geRTG5+0IIyXogaLUUC39VHaL+Eb79vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=opc8VBcs76y/Cu6e4QWVkfDwhHiluxKOBHD+ClkE3qINeJgEl5Ip3dWcaQSTNcJLXoku+DxFCC+Nz4sCnSjy/vfLcaq14xaYCvUqWmtv8Iw0DUVXTzg4mkfOKMcH2uDQ+oKF46vwD3dwxJTzgTyhEL5UfI+XPxWMNgVSmtsnsXG1zCZOFTadHyQEIqUNEfn1kVRW4kfT3mpV7mVyxX28g/lXTpBbU++e1jccl3/pmFSKAHL73DTZnBfM0en9XwanLcSwTaC1jjIHA4s9Tlo3RV8OHwN7xUVk7CV0zrlEfCMA4oIxPtJRDC8ya4RtEPghrfc31i5eF6bImsc4F9oNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=PXq1hcT2S5tsV0oNNjFA/PeSZPF6iAWi8i59vniUdpS9GJQAW5ib5KEnouxA/dcDNq4BTBoiI6WFd5cZZF+55cAvduH5MzV/gmwBrx17w77spKbsX8PjB9yBczzdxtDoVkrYQoqa1AxdTM2heFOkwvexEJOIbHSL+qCztvfXt9o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB8930.eurprd08.prod.outlook.com
 (2603:10a6:10:465::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:39:55 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:39:54 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 03/28] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Tue, 10 Nov 2026 15:38:24 +0000
Message-ID: <20261110153907.3241978-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB8930:EE_|DU2PEPF00028D07:EE_|GV1PR08MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd182b9-7498-4364-1202-08df3f40f242
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|11063799006|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261022105027099003|261026140227099003|261009223027099003|56012099006|261026121527099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: EmqvTXHYJRvjJbPek200n2fbAboY0KxkfyB549Q4Axg3f8byKCEWJMMtqdSL/S8dp3hUuyAjriuTCvI2DwXqNQ2YZt1sRjfAucUujGeQXeV9jcs/4lVJXZMQgQeW6U6XwoBsLUf6OeIuk+YFRV/wLVc5tu1eosCbF7z3spWzofFvo9JnPpJwWnVNDSPR30GcweLK5/rgEeVlsoByWbqvkXemgyKGHvs5FQ+BVGzdigamGup4dqRisMtJi8ZqysVhq/KmS/30PkyKt90THyHZEBBPM6nSEifNfycZUxyYoIxmWEa36QEqNyLm5GT9s5keGuuU3CWsiULLSd9TWYDiSve7Dn4TG0oS6vbp94ABCVVrqeQNR2iEQGQ//HtkSSmD3DlxYWwwCtmtXaNP7xir0t1Pw1pXWKjozFpcFBM2gmmbNGSS+fdcNPvmHa/d1oWF9jhPxMQ01BSGev5JOvZTpbXi93Rw27WjP4YQC3tCY3ehm+sN8MZgLw3YWmSJ8VhwmvfBd3rtWPVVVx70OQXpzCDXjMIzRXt6aPaFOQgCTe++Qy2ZMdm5SYFtK5XCwSPYfZOjO3iQ+sVxxbragikJKrVA/l5JeShkypFJUKD9iCg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261022105027099003)(261026140227099003)(261009223027099003)(56012099006)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: zhIc0dGnybUdyjf7XdUIfLuHfU4fojYw2/Ld1EuaYeGqaLEhbjzm/oRyu2lXvagY0MkoX/qD020cro1MgPXZrd+DPzHXMc/ZsO4EYhynH70TuUFNtFUN2p50aIcz2Twtc3cfObtMWWrz3dKOvyXqk5t4wx/CwDTcYnTJxDjcnRliGGHYjgs5DTG39RhbLugSS+6I1tw7DF8DPfIBUPfi77ZHeogE4pxnBy76+7o44ip04XmLembklMS3wQT49ko4Svjr7NXTLs8VEtYpNIC4eqLZWT4MN5WkWmOpmPnue0CO2c9VJW6KHbXFhQKoM498/JiYKcR9eTmB+gjfHCuCEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8930
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c4968eb8-ea69-4881-59e9-08df3f40ddd9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|14060799003|23010399003|376014|35042699022|18002099003|22082099003|10067099003|11063799006|261009223027099003|261102123227099003|261026121527099003|261028144727099003|56012099006|261022105027099003|261022113327099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: dU/+uDTyRDzDGiZOhW/VAP6AYLcgLmvHBKnktm1DDo2HlJX5d8bTY2CI87tYOeOs5qfZ0QYebrxSgKBjKtZTIF8nWtdFx+s1gSnO6KCOWCXT097luHURfcxqK5rwzoDWMd8AGuf5MCTsy1C9QsDzR96CzE2vKgk3jvh00UgbjQO9pmIOni9KSzuOdPmZ2pOqKbc+7AEXrgOLox7YXOIq9pAld2TDm8GQcgvZw0JDVxJJlBx8GY74J/9Y/6maR82hUzYSJTiTETNu+YQOPtrz4hfFDjMIopKoLSBxpAQpzAZTr556tmt5nHFtGAHxDUY23HDRZmUEr9XXU0j6FGKXrMoU0JlU7518ayD+OteIVuyloiPOrcjLsjsd1mTTKJACXBbs0CrN65V0gs1jWIxXbPSyHfXwWthJxKNUNq8jDmusjFt5lJ4FwIWjXWNusB1y8H0VhWxisRCYNplL1bTVbbhbPVkkf8395QgsxDr0rEuce4Af+WjIY9nly0itkTALnjdzPz8ysTkuqlq/mC2hB/C3/kFilLPeLYkXg6TKFhnAfceCCVj/HDSscmSE7J2U+07cfsbwkLiY7owC1C871hZ2+Uhh7tI52OzmimUzrBYAP3QIeLq7uDAbhPxQgzPVeZOUPuzYL5fFAlLWKrMCQw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(14060799003)(23010399003)(376014)(35042699022)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(261022105027099003)(261022113327099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+cMFDTmHkjaY6D+dlWUUw67K/nirQMSHAZDd0+OT6oqycQrnCbEpzpc3+ol6xxSPzPU/pCExPK5nJK2QhOHVCcXpPzX/kL7CgG+Lqi9rMWcIRY2fcTCSkkLHt2///6yWjFmoexTQh9UOY7+Hqi9lda4hyhrfC9UBhJ+ZzF9Kqnw3xP2BJIC/VH+/At/M2nVpYsmmaE8u4bSGZMMb6o+J2tr8UPFuZhyWeXZQ7DbHQWmFGMMefjNs2ei8oE4RlsT0W/t6mlaEwaweJ0rSJzS8fhPYctghmZB0v9O2KKffrSezyL9a47a8kNFL7ugK2xD2Ya8920M2VLwvKLTW6olwmiYi9wEP5SZLb9AA35gwd6b4/MQL+r5cDF7LQ1qgbpuAYeg27Ez1s4te33GM/vWoZoOkFD85AV+MCcoCW05Ux4DbsL4Ws19Dc3ANeMCa/eL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:28.3689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd182b9-7498-4364-1202-08df3f40f242
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8428
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

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
- Fix includes raised by sashiko
- Link: https://lore.kernel.org/all/20260922205441.263661F000FF@smtp.kernel.org/
v1:
- Includes "panthor_device_io.h" directly in "panthor_device.h" instead
  of peppering multiple files with the header.

 drivers/gpu/drm/panthor/panthor_device.h    | 73 +-----------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 84 +++++++++++++++++++++
 2 files changed, 86 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..4add31b12cfd7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_device_io.h"
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -495,77 +497,6 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 0000000000000..ce417c64abb44
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/wordpart.h>
+
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
+
+#endif /* __PANTHOR_DEVICE_IO_H__ */
-- 
2.43.0

