Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1DECD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37C010F323;
	Thu, 28 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="h0h4PTk7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h0h4PTk7";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013023.outbound.protection.outlook.com
 [40.107.162.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB5010F323
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r+2ggdrxn4DICfN2q0Kz+27R9dYon+54CO4WuHahgInL1GPJbCLnrrMU3u9sxyrC7P3gXksu94XOZL1VYnWeaFlqCnCUV9lYfvxHpGjHqEQ+k0iw/QUx0/5gZDSTp8+RNOWykFjcbiDJ2r2K7wBGQ1oQVDFkUAxblnpUiP0qUY1oQz5lK8VReLzWMpr6qubogK+ON9XQX8s8vgB5Ahcwl3fZyIQWjL1T9OUSHISqFPOLws4yob1jZxyyH6GI0ycDwamTjxAUhBTamie1wYbSmeUD103U1OFsuAHy6fRy2DTlxvMk47iiNVdGwZBOsdaqG1gBlYuSFoAI525C6bPfOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkfW/UxXjYlbbFp09u6efB9juXDbbUwiyw9vQHXuTVM=;
 b=IZdZE9mRSbPDrYNT/LlgcCyqdSuuoUJ7gc9kgotwAiaXAOKZg8NgLJXOiJUz9pH9vOi1W7QRK2tcBZ8/St/vPXrr8cSlcvmjIsYWEXIgmYy4OOWZOyZO96xrZwgBludLA6rXIaisRQTQboW1UCNIwzAqjhin9lWC5SLo8/vT4gndL5bJxGi24WGTI8X9BFr3heFVGxAhGfuxHkiChxTID+tF6sG22x8AdWZ0R0GlZahlgVWZLB50vTXTzuCgtWlNlJA4x1XgPZGsz/g1R5mJu9Z9kVxJF679ZV0Ky6DKDqWrvfiG5fzA+F2VlsxpHbhbmiZL+BW9Jp7EUzt5Ylt87w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkfW/UxXjYlbbFp09u6efB9juXDbbUwiyw9vQHXuTVM=;
 b=h0h4PTk7lMJ7NolkroukqbLDPiXRaAGl9HusLffvWPgATrusPqICyG7Noa6H5HnLVzJZmUUG4LzSPeLTwCGZXhDDhQfXvPnBDwiZyyZzCE3WY5lXQOh/esgqsdZkivGvVWVHrEEu7yo5iYUORXCgc+WAzLaoebW3iH2XL6rvxIQ=
Received: from AS9PR05CA0350.eurprd05.prod.outlook.com (2603:10a6:20b:490::11)
 by AM9PR08MB5907.eurprd08.prod.outlook.com (2603:10a6:20b:2da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:59 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::2) by AS9PR05CA0350.outlook.office365.com
 (2603:10a6:20b:490::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkk7yJ/o71bPHdCITP5KNcxlDe51CFAyJjiK/BVV3DmTsuvd9euk1T0DQvSb3N4gEKsJ0xZEi+gi1ZxgXO55x23qDP4C3ylodY2xSOtRw8WglIlCdFMP7e2Eppv2zTuI11emoCYLMfqnJjAGuSX6UydX19JT8UlQeTbATCVxZ19u9NnXcc0cv3n3YDVgLZbnePrqdbCDV5hWBGzP+famRJ7LwN42TLWAqnsWMsrE39g7g+emuUenRg3PVViylX5Z9vqLIQkefh28OEQHYM+wbvX5rtUQN3WMtpkQMD2+03QVEi/hFStCbhBlM2aiVzmQvUXuRkCmgxupK8eXIpK1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkfW/UxXjYlbbFp09u6efB9juXDbbUwiyw9vQHXuTVM=;
 b=Do79yobnuNGDCnqDqjLqAwLnShIJ/3Lc+fUpmvSY/hH+RWc+02S5x9kmnb61FqezCKF35FXZsAfcgF7S1Q+FwRia+UcU0Ok9f1tbNzx7nVM7R46sm1spxcA7Zo/hlTujWrXndKtcr3z8niLsyoKoUdFgLX5YV8XrVm3gHe+B9PTBanrwnhyH6CMSPztyxWfLIzW2tJ+O/vrpiKo6QCdnGd2QVyf33C5hjS9DAwmm+MiFeZ3rYLcYIX9NxqxRLtXttUMiQDWzCSlksAP5N5zyDh7FeCPpfbS3dKH8t25WQgZA7IzqbgW7jJbO7Gj9pdkdfoC0AqThJJB1JsZUKp8IbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkfW/UxXjYlbbFp09u6efB9juXDbbUwiyw9vQHXuTVM=;
 b=h0h4PTk7lMJ7NolkroukqbLDPiXRaAGl9HusLffvWPgATrusPqICyG7Noa6H5HnLVzJZmUUG4LzSPeLTwCGZXhDDhQfXvPnBDwiZyyZzCE3WY5lXQOh/esgqsdZkivGvVWVHrEEu7yo5iYUORXCgc+WAzLaoebW3iH2XL6rvxIQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:05:56 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:05:56 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/18] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Thu, 28 May 2026 16:05:30 +0100
Message-ID: <20260528150546.3168527-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::22) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AM2PEPF0001C716:EE_|AM9PR08MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: abcac078-be37-43a2-68a7-08debccac447
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: O7Ed/TCzn9Yhvlcpph4MbhIbxqRkI/BMtkBkb4mNv6ZOx3RDg5/Ai0wfPcgVk9KTux0mn/2R/B6DtDWiJSoR0TbLlGp/Kq5sf0i1GYxjx85JXVOobqp9XVIS3WNjN/WIYDw5RKYQl4YYQWOQO3MYbtgHJBuuY4PxKe6mOy/9hcFJW9ZsZMDPMfXDYRqu9y+NKbu95izXacdKo4qKqljIWOaqx+OWiu4fX5tyoKeKmJl61IuT3w2q4z5SAoWzs7AoHc0M34UzuZ/Zu3aoCx6PxUQ3HRkFEfKC8FbnXJkpbALxouCjLEH3erbkde49C/GrbSvcrBWXeiSsz7Ul/Go4PERNj+jezQn3chESYLZcNNufxQWzUrblJd9AQq7qr1nS36IHkNFO9CMZ8ZfFz/B3cYHQNOfa6baXwRFitkGvpE8eCkXEQH7cTchXQmYta9jOd2xswE8XYN1N2dVOYb53UpkRlXZdcLT8qkcERKedj6s97PDB1bXm75b4zW10MLbsqb32Cn1CaYuOqsX7PiKpUdnZU9YF/lFiqM7wFwWILgI5kaXGBVh68biccNhS0U6dvE4D8qY/TpyKsyK2zqp1xBIdjW0728CCPOghzPoOg3huyCNgXMddTYzq0mXysSkMyUDAMv0LdWdPHxLL29xELdfiakpvTj2+IGedgOIXw3r2GlBbibjSnLHslkeoPfgP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: MUT8Vx1EvHgHoIySrxl2ggke2WtmgTtwcymDd8DlKRhQepyG15n9OJU4iDn4oJDqKrpPutpTvJOhMAJHt7gmrKJo5qfkLwIo/x0dtTgRuUjr0ceI3GBocFPhKV2mku2ZumWp4S59xK+kRbtsj06TjHsfSfnRhuNdWjAH7Yzgtbd9u7VLT5NA23iblpQbXWvKhzFV8DZhoqelVJMRpGojkBm5yooqO09qsUuZLad8SahxeoyRnce5L2k9vM/ncKOtBbDTeCol9+/mLH4bd6PkQ0Hl5psad3+Tc/5XhPq2dLBZqZmZ1Q5UysGpzruGioF+Z7M85lJBmxcvhLqxarKC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 68c70252-7949-4b6e-a082-08debcca9e8b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|36860700016|14060799003|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vQgEyw4rKN74LVRs331yzSuvALr1CMPvW517Qrw2jYB3tYHsF4I0CiHrbfWUDkNd8S3synsLIxw7trporM6FTgTrAVetqFvQLyHKprALlO0DT3ibn59Is0SYjobteehqabQ7BfGXUOpMz/QlTzW6g/q72jgaGX0lAALlX3vzHS970Ug0Mna1ShQYjtasYGOvaxk2qFfGi1xnHMJje1ocmpsR2jWsFUDZxmVFw4JKROh15DukiLpUfnF0l8TZ/TjN2F3G2wEkg3IOXQBfjkd8bZ4aCh2Wq1YsnWA0lqEEVAZbCWfAcIO5Ne9GIWawTmQ8QD/u0jVhZ+pXua9+TWsh++wu5o/uy29h0QbUFWgk8VZWnnSNd/pmzfyY30ESLMxGTCLU3l6w9oIAwGrCIpFlD0ljB8IRacBmx8WbrztP3iIokWUzuTfGGrSCS9mRXlChRuJQ8gnh/ZE6xwGffdtwu2NB/OftQpH60TvPVht6OPmoZJ/kZ1mA+gttb2gi0ta6d/4S0vkNArauS2UDL4VieF3vibFMHKuGEUFqIOLJswHR+hkjS7W9V+8b+v0mtgJwW88rp5bpxLPiwlcpJHXp7JfFROc2axczv2ZJWleeyoJ5PoSQ3RVHYA29VWOrvjtRs81bQq+F+WDzk96XW9qq0iNkd/YKDG9lCAggY63kB7MJgevVGB1fyjegrRWo0rRSgjC7YMmnkb6DaCq7TZ/2CdoNgVHXqxbgsrSYfca2R1o=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(36860700016)(14060799003)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IHxWRICs9KUUr98+1S/mYkvjVyQK+DG+xH0XZYx4KJeeNn7f6KKST4lI34fKFESWOoEqDiprIc8+NiEPoB7quCQqyuM648bCnqGQGLEpONrkqkKZWDjUrBtCB8VCI5ptMxs5ZlFfuqYSlibbyLhNEZqtPqcXtSdU0AMwlGnyP19DArzcC5u7BLufg1RsMfxgFqaqSNoqJLzSZjRpYC0N74gDPT4xriSqBI+q2SaIxkh/9grZXWwbdwt1eGx5FVnIvtF/d+zSVdwTgZemgYkq15+eGZXtOfXKtM7VgiyJgVSMr+SaeMUUjY8dNNQcF0Zb4TsZpNsoVki6l2fKwntoLAUFgcE5rVFcaVMlPhDobuU/aRC87LZD+H9GtkAT7kUmuwVFGgl1gJg1FTSPxQsCciu/ZE/nkSed6LxsMJxud7fgUVQ3BDrj9wlYzmAgUF9g
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:06:59.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcac078-be37-43a2-68a7-08debccac447
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5907
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

panthor_device.h should describe the panthor device state, not provide
generic MMIO helpers.

Move the register accessors and poll-timeout wrappers to a dedicated
panthor_device_io.h header and include it from the users that need MMIO
access. This makes the dependency explicit and avoids pulling the full
device definition into code that only needs register helpers.

No functional change.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h    | 72 ------------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 81 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c        |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c       |  1 +
 drivers/gpu/drm/panthor/panthor_hw.c        |  1 +
 drivers/gpu/drm/panthor/panthor_mmu.c       |  1 +
 drivers/gpu/drm/panthor/panthor_pwr.c       |  1 +
 7 files changed, 86 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..c376e52e8564 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -6,7 +6,6 @@
 #ifndef __PANTHOR_DEVICE_H__
 #define __PANTHOR_DEVICE_H__
 
-#include <linux/atomic.h>
 #include <linux/io-pgtable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -630,75 +629,4 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
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
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 000000000000..54e206c6aaa5
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/atomic.h>
+#include <linux/io.h>
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
+#endif /* __PANTHOR_DEVICE_IO_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..52f176644aa6 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -19,6 +19,7 @@
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
+#include "panthor_device_io.h"
 #include "panthor_fw.h"
 #include "panthor_fw_regs.h"
 #include "panthor_gem.h"
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index e52c5675981f..b63a33fe155e 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -18,6 +18,7 @@
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
+#include "panthor_device_io.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 4c96573b649a..5cf54028f606 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -7,6 +7,7 @@
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
+#include "panthor_device_io.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 452d0b6d4668..48127313332f 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 
 #include "panthor_device.h"
+#include "panthor_device_io.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 7c7f424a1436..1cba093a2452 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -11,6 +11,7 @@
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
+#include "panthor_device_io.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
-- 
2.43.0

