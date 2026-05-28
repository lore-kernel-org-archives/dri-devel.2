Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A5CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5634F10F344;
	Thu, 28 May 2026 15:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Ys9cd8RK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ys9cd8RK";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAF310F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eokrLdg3PpQJu/GABUa6JSbcmC3yJ57AZ0btMe4y9rGNM+RwrvM15HgN9iO6GsTdC58nwfAOfB4n+KDPFSgxPKqpdk0B65WAijpPMHmBJvX4fCM3lYxHZU9Ln7yEwLA+rO08/b1n549/dqacDugwgtgrf5ptD21pV6SQRy+FstrkeZyNDHEiIe+mnrtDTzK/0HxHXenDaQ02FCSUHKRiE/eQfbkew7AK7IlkDr6qBFcuknAY05yDqEnKjiei2Xh1ZXaKXb+c2A11+9YrQ6WUkY4zhnk18ox8rPTEDRBUVnb4c1hUBO4o7vNH0J1/K2dETCRGnJ9p0by4fAbugmHlSw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHI0V/LvIrLHH3MAO+lRJ0d/Q/Ragsz9KhwufGENAw=;
 b=byP/3fkCNiiCAsoiNmOJ3RAtBNRT6WK9tvzPfMhJSO791lz6cqzEvXA0FBJsDG/Je0hBW2sF1dn7rKkMPcgWipcG7FatQyWR1v4Z9YP6Q7GmMlaeJLJDmuyAzZ9ZO0hj0QRrOVW69VowZkx1P2KQO/aAOcOzwsg4RYgy/Bz8aOQNocT/zA8t7I3+YFw6CkUY8nmJAQbbwBf7eOcjxIj/ufVG87YbMC5FLBvx4xg9Tr1NmRSH9w+mj5kni/Bh+eTkp0ZM6DvYuNqDP5KOuKpJmH33/zm7JYV2/f8AHj10Fs3iM0owRWl9dyuiZxHlIcL4SzlvGjj7X3JZthfjziXF+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuHI0V/LvIrLHH3MAO+lRJ0d/Q/Ragsz9KhwufGENAw=;
 b=Ys9cd8RKPGzHXNZVVAZVBd58PA2PXQKoQtnw3ThjvBbz7nuBFaS/lXFhLyzf+pz7UlAQAmIIa4wK0taGqO0+fY85QLzRZ5RoQuZkLkZF+1nEJrUCiC4D8p7U2KXjvbYCEJWg4Qz3Q9+fCBWEVltABqyrbbveH2Et9HTmG2++dHY=
Received: from DUZP191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::26)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 15:07:16 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com (2603:10a6:10:4f8::4)
 by DUZP191CA0043.outlook.office365.com (2603:10a6:10:4f8::26) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13
 via Frontend Transport; Thu, 28 May 2026 15:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBULt7555HvH6lnEhtVC6uKiZUhg55JD2wZx+nflQyMq4ksZY8Urn/1iB/YhTWz7XLMymy+znyUUFjLnI1DbTVZohweAhL53Pe+dD69rjhkvxlNbiQ5JidHsGYYt7NedyipXWmScXstUYDbowFqRixaeTsVuUD+iIh+7ocQaTeqN16lIqJdgjpnvsE0oIIokYMOgYyXrcLAMslqFy8oCEFjXy/tTgv1K2GIm4AVnjjZX84PLVaDt6h3/KhmztQffJ5UpxzE+9vn3F8R3NeKT3jsA+rOaWsSKhJsEeyIXaCFt46ok+7Vk+tWeXqUAc1QS7nOEGfhXXbdoJZeBaCGq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHI0V/LvIrLHH3MAO+lRJ0d/Q/Ragsz9KhwufGENAw=;
 b=vLLSErjiAnO7g9xpmGhdgtpLkqXK0MkXBcHGHHPKnKVsSFQJTKpDHLvowq1gApzkH4bweBIUkp6XQ/TDm7SfOoSOajZp2RMFekss4mC2pioozd7CxKwF4SuNV+qmDbdRJ1Yrcu+V4L0f2zrXdNqFjybt3NMTojf0bl+Idp3hSBIK8Q3vuir7+ZZavqD5YkDc3rtYVW0FGZcXOyw6vdwgV9Qp/P7HvliH3MKeRrhq9ZuVQJ64k09C48u1lum4Ql8KiIwL1G8iXgu6fR3FwgYf3e638IZ1jv4Zds4nORG0DIJwrldl1otYxzBwD0j64tF0DbAogjsWESTibbxPdJCUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuHI0V/LvIrLHH3MAO+lRJ0d/Q/Ragsz9KhwufGENAw=;
 b=Ys9cd8RKPGzHXNZVVAZVBd58PA2PXQKoQtnw3ThjvBbz7nuBFaS/lXFhLyzf+pz7UlAQAmIIa4wK0taGqO0+fY85QLzRZ5RoQuZkLkZF+1nEJrUCiC4D8p7U2KXjvbYCEJWg4Qz3Q9+fCBWEVltABqyrbbveH2Et9HTmG2++dHY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:14 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:14 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/18] drm/panthor: Add access-window support
Date: Thu, 28 May 2026 16:05:43 +0100
Message-ID: <20260528150546.3168527-16-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DU2PEPF0001E9C2:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: e466bfa9-b6d6-4595-f84d-08debccace8a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: CuUODcuVMTS9EvJ7i/D3u726DL3MIwAD/UxQTWQ/FoNJCPVd6RryzzrVikkXrkQacElW36uVj6OFCHrrDCe1di9XM8nuCfcPlA4X8nUAz7XXYzZBD2s9bV1ZVrl+BHdUB+1qjhu4U14kvdp8PcMiPYW8CHmw5E8O36AmOwoKFIZfVOqj8GfTaV1Hq6Fojq6u7IXTFPjBzdfTb3GgwAntQpZxVx+e8rYt/FbDp9oO6bLulZK9gZhxYYtqmai3J0LEn476Mc0hWE3a2ATsjUPWn/UKBJWdesBoJHItFq2MpV03LT4FiXGCmGCsJcAbadC/Q7ppWKk12eGgJ3OBfQ98h/Fdmi7bzhvW8VeTAHrYbU3WWD3dbnzqPVRU13A2rrNxRzgXv/4w3FfJ2MDkntKnHWHSOFvNcKT9v7jUz6XwL7NhLoKN5obPXowhBiqut4kCga2DJkaNHJDSVAPy2ud+kSIbOENZ3Zm1rT3MXg0vqL01N31ddGx4YbxOqzVd+zaqmb8k9qkOyHqq2RFWWr2eEmaK1Bkm+nbDP10eKd6q6lh+k0hVuQtICAxBDxFwuv/o7GLcxPul2CkFfbfuYVGeHG8fqfX2CLABQJZDf3q4zeSLVv/266KnUONqu85B6nKrj25Fow0STB7JBGbP/Zskufr54lfmyMSLvj9+MLLbmTvG+6VJoP2UJxD0IbngLRQP
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NGeUMx5hERQu/aZw5Qy77ExR4I7O6ObDHKexsq3qSnHkcV44Pxmhgee9r23A3wJVjiBJi3BdHrAZN9DVzwEVcyvIoGVDd/DvAIM5OhyYRVBL7C2nC2+SuJ+33io976S0+T8CHJebKohmVaHjx/Wdq9p1ACUHE7EKeLhiIUpACUV0iJ4bRw3SSjoVu3oKSKaporps4x9+s320ItqGo2FuaBFPO5kL1RW8nkIKt37y86vR6JALrAGJqEAUK92mMLlfP1PEa2CfSAib70lmLQEXsrYddgVF+IVl9dv5jjNMz2e9M1CL2YFofJYF1Sv6iBSVm+OQzGgHcPu3DM3i0DvIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ce7539f6-2028-4561-f662-08debccaa915
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|376014|1800799024|36860700016|6133799003|3023799007|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: WASkaSLyHI5VUnZ/bSpKHAnU7a1NzeZew0h+eUHdGNUQteq7mkvCsvQhzt9ETbrxAMXy7sNhzkDXngMwWPI5LIF8Qe0+R01lzJ4IKMkbxwdGTJWisROU2WI9pH0/Wp/jYXiTf6u7wh+Rkn1b+OWiv0TfGRmgSelLslFXkhYtGsFjAWafCVCse+MZseRqlA0TtmdBaQqSym5a3QBUBzQ9ekLrbERXLHFgriQRcRkRxYXSDIhG8LQ2Pc4IqWFEq49NWX6ZmNQ6DKn2LgjH3iFXkAvfvp/yHEljGcpzFLlXNiNV6aZjGtH/69OrBzl/B1yBdd73weQZTIkii/e4KtZPhZVkXDgsUWHcWz0x1tukUcoB7K0AKEkUr5w20v17Q3wFRjxylSX3mp8BlnrRCJQyNGbuURvfIb8j11phK/apA8OOfc59a5sElOm30ALGN16/1IRcsIZ/1KQ+Iw9XHAzHj07tiXp3TM4F+8hNiz1IkWzm5t8KE/Dt14xzA0jTpaP9HgjyH3++vWcU04mrKLoUzbxHGQUu1OuMviNNysCZzvjVTLc77lUP7tPLaH2+q1d/bG+cCX9B3VD46fUgV9Fa79Vc1+Gcky50bGgE3KaunDC4nbqEv2Le81OTz1F2Z09gq5INiy4EgMCMPsMMA/shNotYw+J8WZWeaDDaAQcvhWWAOYz8DeXSRd+9CGj88afKivvKupREMcf8R5GF0wdladudPIbR8g+4NHgKh1qlTfk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(36860700016)(6133799003)(3023799007)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G8WjQpbXKivA1lFAb3KKtMzHxfdWh6cFxhZK9OEv5R1GfAMWi6ZJU2TNvw73HCFjCBXBs7HH9BPsroFpbyvJWIZ8BqCQjEx7Ex9OnrNlN/oHaqgTzuklyb8Ia9M+JzOGvsArWiTyemglHUvkVhM30nKFET2UeK5Yx93TliewRKbdePjpOmE6y2wAni3ksOpk3ByErTAs3fQwfrkjk2+hHv7hf4MJEXMatIUqk43888vHLCQfXhWs38mF+Furoez2kNTJfaHzHzU5Ryn5uXiNoSvlG8ihF8W+u6kvkeaUpzyZpV73MWuVGqXsRpq4ApxseScXIE5dXMuiVoaevjUEbONpNY1DeamUIUTWFoQ7Zllhm8GdBhsTGnj7MznHnpCaAQYT6u+uYYimBbzuSVeGMjlY1tyEvDgYuzDRdJu3S2DEbAQVGlD+2gTQlP9SmQqS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:16.6681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e466bfa9-b6d6-4595-f84d-08debccace8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578
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

Add the VM-side access-window component for v15 GPUs. The new code
handles AM message handshakes, requests GPU access from the arbiter,
waits for the window-open interrupt, and yields access on suspend.

Split panthor_hw_init into bind device and initialize gpu_info after
panthor_aw has ensured GPU access.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/Makefile         |   1 +
 drivers/gpu/drm/panthor/panthor_aw.c     | 421 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h     |  42 +++
 drivers/gpu/drm/panthor/panthor_device.c |  15 +-
 drivers/gpu/drm/panthor/panthor_device.h |   4 +
 drivers/gpu/drm/panthor/panthor_hw.c     |   8 +-
 drivers/gpu/drm/panthor/panthor_hw.h     |   2 +
 7 files changed, 486 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 5d4d0ae64952..aa48212653dc 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0 or MIT
 
 panthor-y := \
+	panthor_aw.o \
 	panthor_devfreq.o \
 	panthor_device.o \
 	panthor_drv.o \
diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
new file mode 100644
index 000000000000..00a52175f3a3
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/platform_device.h>
+
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+#include <drm/drm_drv.h>
+
+#include "panthor_am_msg.h"
+#include "panthor_aw.h"
+#include "panthor_device.h"
+#include "panthor_fw.h"
+#include "panthor_hw.h"
+#include "panthor_sched.h"
+
+#include "panthor_trace.h"
+
+#define WINDOW_CONTROL_BASE				0x0
+#define WINDOW_CONTROL_SIZE				0x1000
+
+#define WINDOW_STATUS					0x43c
+#define   WINDOW_STATUS_IRQ_WINDOW_CONTROL		BIT(0)
+#define   WINDOW_STATUS_IRQ_GPU_CONTROL			BIT(1)
+#define   WINDOW_STATUS_IRQ_GPU_POWER			BIT(2)
+#define   WINDOW_STATUS_IRQ_JOB_CONTROL			BIT(3)
+#define   WINDOW_STATUS_IRQ_MMU_CONTROL			BIT(4)
+#define   WINDOW_STATUS_WINDOW_OPEN			BIT(31)
+
+#define WINDOW_INT_BASE					0x440
+#define   WINDOW_IRQ_MESSAGE				BIT(0)
+#define   WINDOW_IRQ_INVALID_ACCESS			BIT(1)
+#define   WINDOW_IRQ_WINDOW_OPENING			BIT(2)
+#define   WINDOW_IRQ_WINDOW_OPENED			BIT(3)
+#define   WINDOW_IRQ_WINDOW_CLOSED			BIT(4)
+
+#define WINDOW_MESSAGE_BASE				0x460
+
+#define WINDOW_IRQ_MASK \
+	(WINDOW_IRQ_MESSAGE | WINDOW_IRQ_WINDOW_OPENED | WINDOW_IRQ_WINDOW_CLOSED)
+
+#define PANTHOR_AW_HANDSHAKE_TIMEOUT_MS			(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+#define PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS		(5 * MSEC_PER_SEC)
+
+#define panthor_aw_wait_cond(_aw, _cond, _timeout_ms)				\
+({										\
+	int __ret = 0;								\
+	if (!wait_event_timeout((_aw)->waitqueue, _cond,			\
+				msecs_to_jiffies(_timeout_ms)))			\
+		if (!(_cond))							\
+			__ret = -ETIMEDOUT;					\
+	__ret;									\
+})
+
+struct panthor_aw {
+	/** @ptdev: Pointer to Panthor device */
+	struct panthor_device *ptdev;
+
+	/** @iomem: CPU mapping of WINDOW_CONTROL iomem region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ data */
+	struct panthor_irq irq;
+
+	/** @msg: Messaging data */
+	struct panthor_am_msg msg;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @state: Current state of the AW */
+	atomic_t state;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @msg_retry_work: Work to resend messages */
+	struct work_struct msg_retry_work;
+};
+
+static bool panthor_aw_is_open(struct panthor_aw *aw)
+{
+	return gpu_read(aw->iomem, WINDOW_STATUS) & WINDOW_STATUS_WINDOW_OPEN;
+}
+
+static void panthor_aw_state_set(struct panthor_aw *aw, enum aw_states new)
+{
+	atomic_set(&aw->state, new);
+
+	wake_up_all(&aw->waitqueue);
+}
+
+static bool panthor_aw_state_try_set(struct panthor_aw *aw,
+				     enum aw_states expected,
+				     enum aw_states new)
+{
+	int old_state = atomic_cmpxchg(&aw->state, expected, new);
+	bool res = (old_state == expected);
+
+	if (res)
+		wake_up_all(&aw->waitqueue);
+
+	return res;
+}
+
+static int panthor_aw_state_wait(struct panthor_aw *aw, enum aw_states target, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(aw, atomic_read(&aw->state) == target, timeout_ms);
+}
+
+static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 timeout_ms)
+{
+	return panthor_aw_wait_cond(
+		aw,
+		(atomic_read(&aw->state) == PANTHOR_AW_STATE_READY ||
+		 atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_GRANTED),
+		timeout_ms);
+}
+
+static void panthor_aw_msg_retry_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, msg_retry_work);
+	struct panthor_am_msg *msg = &aw->msg;
+	int ret;
+
+	ret = panthor_am_msg_retry(msg);
+	if (ret == -EINVAL)
+		drm_warn(&aw->ptdev->base, "Send FIFO unexpectedly empty");
+
+	if (ret == -EBUSY || ret == -EAGAIN)
+		queue_work(aw->wq, &aw->msg_retry_work);
+}
+
+static void panthor_aw_send_msg(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	int ret;
+
+	ret = panthor_am_msg_send(&aw->msg, message);
+	if (ret == -ENOMEM)
+		drm_err(&ptdev->base, "Send FIFO is full");
+
+	if (ret == -EBUSY) {
+		drm_dbg(&ptdev->base, "Pending messages, scheduling retry work");
+		queue_work(aw->wq, &aw->msg_retry_work);
+	}
+}
+
+static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 message)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	bool acked = AM_MSG_ACK_GET(message);
+	u8 version = AM_MSG_VERSION_GET(message);
+	int ret;
+
+	ret = panthor_am_msg_version_validate(&aw->msg, version);
+	if (ret == -EOPNOTSUPP)
+		drm_warn(&ptdev->base,
+			 "Msg protocol version less than minimum supported (%u < %u)",
+			 version, AM_MSG_MIN_SUPPORTED_VERSION);
+
+	if (!acked) {
+		u64 reply = VM_ARB_INIT_MAKE(1, aw->msg.version);
+
+		panthor_aw_send_msg(aw, reply);
+
+		/* TODO: Handle AW restart */
+	}
+
+	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_INIT, PANTHOR_AW_STATE_READY);
+}
+
+static void panthor_aw_handshake_init(struct panthor_aw *aw)
+{
+	u64 message = VM_ARB_INIT_MAKE(0, AM_MSG_CURRENT_VERSION);
+
+	panthor_aw_send_msg(aw, message);
+}
+
+static void panthor_aw_handle_message(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+	const u64 message = panthor_am_msg_read(&aw->msg);
+	const u8 msg_id = AM_MSG_ID_GET(message);
+
+	/* currently only support ARB_VM_INIT */
+	if (msg_id == ARB_VM_INIT)
+		panthor_aw_handshake_handle(aw, message);
+	else
+		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
+}
+
+
+static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
+{
+	struct panthor_irq *pirq = data;
+	struct panthor_device *ptdev = pirq->ptdev;
+	struct panthor_aw *aw = ptdev->aw;
+	u32 status;
+
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
+		if (atomic_read(&pirq->state) != PANTHOR_IRQ_STATE_ACTIVE)
+			return IRQ_NONE;
+	}
+
+	status = gpu_read(pirq->iomem, INT_STAT);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & WINDOW_IRQ_MESSAGE)
+		panthor_aw_handle_message(aw);
+
+	/* TODO: handle WINDOW_CLOSED*/
+
+	if ((status & WINDOW_IRQ_WINDOW_OPENED) && panthor_aw_is_open(aw))
+		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+					 PANTHOR_AW_STATE_GPU_GRANTED);
+
+	gpu_write(pirq->iomem, INT_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void panthor_aw_irq_suspend(struct panthor_irq *pirq)
+{
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
+		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);
+		gpu_write(pirq->iomem, INT_MASK, 0);
+	}
+	synchronize_irq(pirq->irq);
+	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);
+}
+
+static void panthor_aw_irq_resume(struct panthor_irq *pirq)
+{
+	guard(spinlock_irqsave)(&pirq->mask_lock);
+
+	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);
+}
+
+static int panthor_request_aw_irq(struct panthor_device *ptdev,
+				  struct panthor_irq *pirq, int irq, u32 mask,
+				  void __iomem *iomem)
+{
+	int ret;
+
+	pirq->ptdev = ptdev;
+	pirq->irq = irq;
+	pirq->mask = mask;
+	pirq->iomem = iomem;
+	spin_lock_init(&pirq->mask_lock);
+
+	ret = devm_request_irq(ptdev->base.dev, irq, panthor_aw_irq_raw_hander,
+			       IRQF_SHARED, "panthor-aw", pirq);
+	if (ret)
+		return ret;
+
+	panthor_aw_irq_resume(pirq);
+
+	return 0;
+}
+
+static int panthor_aw_request(struct panthor_aw *aw)
+{
+	int ret;
+
+again:
+	switch(atomic_read(&aw->state)) {
+	case PANTHOR_AW_STATE_GPU_GRANTED:
+		return 0;
+
+	case PANTHOR_AW_STATE_READY:
+		break;
+
+	case PANTHOR_AW_STATE_INIT:
+		panthor_aw_handshake_init(aw);
+		ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
+					    PANTHOR_AW_HANDSHAKE_TIMEOUT_MS);
+		if (ret)
+			return ret;
+		goto again;
+	default:
+		ret = panthor_aw_state_wait_transition(
+			aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+		if (ret)
+			return ret;
+		goto again;
+	}
+
+	if (!panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_READY,
+				      PANTHOR_AW_STATE_GPU_REQUEST))
+		goto again;
+
+	panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
+
+	/* Wait for GPU to be granted */
+	ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				    PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
+	if (ret) {
+		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_aw_yield(struct panthor_aw *aw)
+{
+	panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
+
+	return panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
+				     PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+}
+
+int panthor_aw_init(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw;
+	int irq;
+	int ret;
+
+	if (!panthor_hw_has_gpu_discover(ptdev))
+		return 0;
+
+	aw = drmm_kzalloc(&ptdev->base, sizeof(*aw), GFP_KERNEL);
+	if (!aw)
+		return -ENOMEM;
+
+	aw->wq = drmm_alloc_ordered_workqueue(&ptdev->base, "panthor-aw-wq", 0);
+	if (!aw->wq)
+		return -ENOMEM;
+
+	aw->ptdev = ptdev;
+	aw->iomem = ptdev->iomem;
+
+	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+
+	init_waitqueue_head(&aw->waitqueue);
+	atomic_set(&aw->state, PANTHOR_AW_STATE_INIT);
+
+	panthor_am_msg_init(&aw->msg, aw->iomem + WINDOW_MESSAGE_BASE);
+
+	ptdev->aw = aw;
+
+	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "gpu");
+	if (irq < 0)
+		return irq;
+
+	ret = panthor_request_aw_irq(ptdev, &aw->irq, irq, WINDOW_IRQ_MASK,
+				     aw->iomem + WINDOW_INT_BASE);
+	if (ret)
+		return ret;
+
+	ret = panthor_aw_request(aw);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void panthor_aw_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+
+	if (!aw)
+		return;
+
+	disable_work_sync(&aw->msg_retry_work);
+
+	panthor_aw_irq_suspend(&aw->irq);
+}
+
+int panthor_aw_resume(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret;
+
+	if (!aw)
+		return 0;
+
+	panthor_aw_irq_resume(&aw->irq);
+
+	ret = panthor_aw_request(aw);
+	if (ret) {
+		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	panthor_aw_irq_suspend(&aw->irq);
+	return ret;
+}
+
+int panthor_aw_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_aw *aw = ptdev->aw;
+	int ret = 0;
+
+	/* suspend hw components directly if AW is not supported */
+	if (!aw)
+		return 0;
+
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_READY)
+		goto out_irq_suspend;
+
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+		PANTHOR_AW_STATE_GPU_STOPPED))
+		ret = panthor_aw_yield(aw);
+	else
+		ret = panthor_aw_state_wait(
+			aw, PANTHOR_AW_STATE_READY,
+			PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+
+out_irq_suspend:
+	panthor_aw_irq_suspend(&aw->irq);
+	return ret;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
new file mode 100644
index 000000000000..c2b89caa87c4
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AW_H__
+#define __PANTHOR_AW_H__
+
+#include <linux/types.h>
+
+struct panthor_device;
+
+/**
+ * enum aw_states - Enumeration of possible Access Window states
+ */
+enum aw_states {
+	/** @PANTHOR_AW_STATE_INIT: Initial state, prior to handshake. */
+	PANTHOR_AW_STATE_INIT = 0,
+
+	/** @PANTHOR_AW_STATE_READY: Handshake with Resource Group completed. */
+	PANTHOR_AW_STATE_READY,
+
+	/** @PANTHOR_AW_STATE_GPU_REQUEST: AW requested for GPU access. */
+	PANTHOR_AW_STATE_GPU_REQUEST,
+
+	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
+	PANTHOR_AW_STATE_GPU_GRANTED,
+
+	/** @PANTHOR_AW_STATE_GPU_STOP: AW is requested to stop GPU access. */
+	PANTHOR_AW_STATE_GPU_STOP,
+
+	/** @PANTHOR_AW_STATE_GPU_STOPPED: AW has stopped GPU access. */
+	PANTHOR_AW_STATE_GPU_STOPPED,
+};
+
+int panthor_aw_init(struct panthor_device *ptdev);
+
+void panthor_aw_unplug(struct panthor_device *ptdev);
+
+int panthor_aw_resume(struct panthor_device *ptdev);
+
+int panthor_aw_suspend(struct panthor_device *ptdev);
+
+#endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index bd417d6ae8c0..7248e2aa9da2 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -16,6 +16,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -100,6 +101,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_gem_shrinker_unplug(ptdev);
 	panthor_gpu_unplug(ptdev);
 	panthor_pwr_unplug(ptdev);
+	panthor_aw_unplug(ptdev);
 
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
@@ -255,10 +257,18 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_rpm_put;
 
-	ret = panthor_pwr_init(ptdev);
+	ret = panthor_aw_init(ptdev);
 	if (ret)
 		goto err_rpm_put;
 
+	ret = panthor_hw_info_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
+	ret = panthor_pwr_init(ptdev);
+	if (ret)
+		goto err_unplug_aw;
+
 	ret = panthor_gpu_init(ptdev);
 	if (ret)
 		goto err_unplug_pwr;
@@ -315,6 +325,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 err_unplug_pwr:
 	panthor_pwr_unplug(ptdev);
 
+err_unplug_aw:
+	panthor_aw_unplug(ptdev);
+
 err_rpm_put:
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 8b2a9bb426fc..a1092d02a1fe 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -18,6 +18,7 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+struct panthor_aw;
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -196,6 +197,9 @@ struct panthor_device {
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
+	/** @aw: AW-specific data */
+	struct panthor_aw *aw;
+
 	/** @pwr: Power control management data. */
 	struct panthor_pwr *pwr;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 52271fb9db52..aa77d1b7f21c 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -326,7 +326,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	return overload_shader_present(ptdev);
 }
 
-static int panthor_hw_info_init(struct panthor_device *ptdev)
+int panthor_hw_info_init(struct panthor_device *ptdev)
 {
 	u64 l2_features = ptdev->gpu_info.l2_features;
 	u32 major, minor, status;
@@ -433,9 +433,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	ret = panthor_hw_bind_device(ptdev);
-	if (ret)
-		return ret;
-
-	return panthor_hw_info_init(ptdev);
+	return panthor_hw_bind_device(ptdev);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 1b2678ea00db..d60860102b95 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -60,6 +60,8 @@ struct panthor_hw {
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
+int panthor_hw_info_init(struct panthor_device *ptdev);
+
 int panthor_hw_power_status_register(void);
 void panthor_hw_power_status_unregister(void);
 
-- 
2.43.0

