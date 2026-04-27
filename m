Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4F3FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5778610E7FF;
	Mon, 27 Apr 2026 16:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="M5Ba6rTa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M5Ba6rTa";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A737A10E7FF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:50 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s66l1EzDAdd/kGnE2D8e1d6Q50EXiPkX51iL4T9x+3Wa+598o1f3PnW5P18s1S6LmDsecdb4wf0dDwnRtUkoXvlLDgYTJd0xGPQ8m+h+pQxW9/Ll8JliCzE5WQ4UP3vdIodeBNoQivB7hr3fmgLpRBpdI/Dj25dxEMYrxFHOgdfzYneGoC7ypOgHgd/n0F1vrjHvtG1E7G9MPW4HxxacoLXB/W6RvIqSaf1lFh0rWqN9CQ6lRTzE2u+GY7odhKuST95jvpvdhLUetWCK8K+iFsEgkR096nlPLlnaGyL0XBpDgESJWrefZPHdrvJLEJLlY1uilD8bJ8KWuFUgirVN/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VpIM1GAM8s2s/AG2+C4dp2/a0IcFxF2A7If+fPQUmQ=;
 b=qmstM96sbdVrIavUXt2c9ai9v3IPBAp3BTus6WigKleiR7GdzVCqkOn3Ne/8dspGgwMCrLePqQQ4qQ52Zk4GMkxLQCP8T7jUTahk9kPQjfmYIKWVZXmRB9NwpttTbErsZZv17gAhr3lhbc7ZyXMfs2EKJZ77TG+nQ02HwggjvoWClpbzqtSwHs4fA3AolNB3rZMfV1l+qMC4o/elm5n4MJRMUQ0WJcnPnQZn3RbuxIju/qYDDb9qy+em4x2ceEkdrZPtsKLP0RSz1hpqPCgAAgXUPXiWEGjvv5kL7d9wG6arDeLLebj1Zl1aJMfLi92qlFFsKwhG6wa+a+cMQmAKFw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VpIM1GAM8s2s/AG2+C4dp2/a0IcFxF2A7If+fPQUmQ=;
 b=M5Ba6rTaZ3pGsAe2OsboWE65SLpurmyngLQVcCdQikQNR46qUBU8fGQxwa9pEtqIHTjUD7/etqU8jdaMc9ONt3XZR92xm4vrJ0B5NaEAHnqXAl7USMCDRdBrmSVUDIlpoMu6TPok8b3HdZkKj8vc/LWKzzYISc9NIVUZO8wqLEk=
Received: from AS4P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::8)
 by AS8PR08MB10070.eurprd08.prod.outlook.com (2603:10a6:20b:631::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:44 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::6a) by AS4P191CA0013.outlook.office365.com
 (2603:10a6:20b:5d5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTfwoz48JxmQlquErpA0JrHX7h/o7jv3VVamHx6f0egsAL661EdzoHSKMefRTtTw6TuOBypCEpFwALw1LLMMH18UAPEQ7XhHm444E32yKrHqC1VhWqlG4+nozvNWzbGLQHEXc1aJ8IJ5NzQIGGyl+GUYcfZGn1o3TTHF+htLSTEXxpaucjY1wHGa5/pjIqNGnmmV9UjeBQuX5Dosq7xR/S4/qcRLxzQZWrS9w6U3zFMZUOrFAYrERHgc0zWBj9T9sTntMsCegtop/d0JXHkMV43VQomFDu75e5p+G8u3QKeR0NZkOoClDfQ5KD1rAkueb9IhUS9y6/3O/0ST6FqRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VpIM1GAM8s2s/AG2+C4dp2/a0IcFxF2A7If+fPQUmQ=;
 b=RIBwdhbQIEBF2LTEBSHcRbmXQZDGiqI5Wk/16pJQbTJ4on2/oWwNOS2Ng4rWCw+ndtQc+LtEDIubE8z/wr/goN5WwZIZFjd8INORZe4lCZpl9n3FmF6rSFcf42RhC9CWAXBzSppFBBr4MKwz3ztPIolYARFb1jfROWoUs3UNVUnR/M9gLOQDJLmEe2o8kT7yegzk3LRwO6eJU5TaiCWFUnYclK7qLpff3LaPIgVhdioojPBeXIW8HLNRtZK/puMtPrKG/oV3sFQQoa10yKlOMUeb7OwNeVMUDmP0tx/UuKvpGWNJcGhIRaFOGOFcjBGkx/ULFoZyrbdhi+TMVhlhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VpIM1GAM8s2s/AG2+C4dp2/a0IcFxF2A7If+fPQUmQ=;
 b=M5Ba6rTaZ3pGsAe2OsboWE65SLpurmyngLQVcCdQikQNR46qUBU8fGQxwa9pEtqIHTjUD7/etqU8jdaMc9ONt3XZR92xm4vrJ0B5NaEAHnqXAl7USMCDRdBrmSVUDIlpoMu6TPok8b3HdZkKj8vc/LWKzzYISc9NIVUZO8wqLEk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:41 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:41 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] drm/panthor: Localize register access by component
Date: Mon, 27 Apr 2026 16:59:26 +0100
Message-ID: <20260427155934.416502-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::7) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|AMS1EPF00000045:EE_|AS8PR08MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: 920320e0-ee0d-49f4-fe3d-08dea476233d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: Rd+d66smkh0690Qdf2s5VUoZzD7PMM0Y2FHtCMkmJJ9pWSpO8RbBYEyvww9SSpHTqtoZQY9GUs7t1Dza47OQK2SonvI/TNMllUl6RdalDExAOF/S0w6Zr2kP/vk816oLeVTZSBsd+9siMMsxD78KUSXWVKmHoyRDkOPKEniqPB0wx1XmFHX4zk0bchlcU+f7YDAAyK6dpY32DH1qPlxil08VJ1kpdzQB60SWJCozBmG+acrVHQOZd4J2tkPlL1KIKhXn7efiP72nIh+ksE0a7IUIyQWNYbG01+JXI+E9IYyUlCDR6pDpZbpvdmjDMqBoK/Zc/YKrTzzrjYfOwi9R0TQyH0Yy1gc1+dySldqnoE9dvJaEU7flJz0DVcgmRKD00+0Hzn7aJLjQeUMceb6zWrZs4S2l4XX7g5ucgE6gdvNhneSN5dv1XtQJ2osoHKPPjLb23QlAHZZ7G0HUEalCD2UJ9PKT02fJfh9KXD372hRKsNgehhT78/J6kSkOgmohmBZlcK4PrIU/LcLjX+Hm1UZ9wLCvL+1euEVaRU/CxChX72qKF5YmZXhUhF5rl6x8U7y9ZWtv5HwIz7thF7PwGHAXhZmg5pZ2PyDqAnu1AL1gpHpelMdG6gwnWpuTpjtlfepgFh6OfB7D+drIi1Y7nNhLGG2M64E4W+ZojyadzPzezv/Gk2Yrppy3i9xRF9dh42vyjB+t011nrkt7m4fe90mk6a1VzUKlu6EjaHRrpi+/mBp+9ehWsAo1wGfw3DdJ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: c7Edl4lMqq1jtVZOsatlfMHEpf9MwVWezuyiT45U8KZXbrc1zvB0grJ+INPjHNiqKohN8SzKE5EuFZ3YEezXiOOSmemffqHBMzVEmYErtaDBNBOxdoiw9VwoAlCEAdhBTEHK5E6oqH+ixyce/VfH7H8sYAuHyTvSCmOFWN0VQXrR/F7KNqs8qry2X9yMv+A/cyUAbNA56rnWndQJ3Rt+3tNSJTbSdgmOuZypEz1w+wvMNIGXgxktJNzudDbgU0py5MxCYqSHzDd68fsJ4u0MnfwrQUQgj8zhnkXgq5HJpNLOoY7RkuyUbmB42NCBMkP462NnV9tjNQ3OtD1cdwxxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 165bb0a4-9bd2-4811-9a60-08dea475fdb5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|35042699022|82310400026|1800799024|376014|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: bxqCKdAoHrVAazNr7Smco5hBow9suNlwgVUwizSyaBKgNZKEH8+OJDxvSiEKfJ0BZIjnJh1SH0Hf6JU4Y87xjTY5MfMwqwwHxstrNZiPJMcQ7ooAqAJi1VRRxCSo/TORS3H7oHBb3/ltIVMzkfVNWuZu1AaWiCxi4+J/l1QwkWGMrgo80xryceaZgkksDsgr4s4Op/ciHZwwOdtnnOCfjVdDx3Oo/vw3VaqoJbX8JhKCUM++/edxPq5mxaiNCwK/HinHoZL3pROxxC3RnPt9coWo05GY8Dpobmp4B7c87hNlvKlqSGuceumWcS4zr83+luqTdZR5ul6eeOKOv+Z0lJYU9mNvVpU0sjifqDbFdCEtCM5HVI4skBf5JbIdII6CZuSz8HJwP51MAV0F09h6CImdzoLpmWVCgFCr2+BZuQoZfqY7haNrezhs7v+a8oKINBK3ev3MBmX8V6raEohwbMqsiIyY/d5vgS5FySzevgInn87H2t+Hn0LA3V9lnLY+UxuEFwyqRiBQ72kbQvy+9/HNeCIl7s/9GaD7DrMf7RYktoQo81exwLByFsnaEvtY7wGK1suyDj0hiFuN8NRatSqe9y+893Ei+7FYb7DU6LXmkp3FSsOGmzycs9MO/KXWA9CLtODDh+178jwBzfFK5Eb+V7btQSatltdYv0TjpXNs+H2QB23UMi5yMiR7uzOf7HLC4KkCBzyfuROb7dfVOfiFmCXSMbxdZR7RWX1YYHF+UMBcsIk3CleKoNAoyaQ5oFcwrmuXLinuOcGIB9oiazwm07aqgvXiW7fuwCTD7a0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfEIZekaAHqig7SZKccxdyrU0twJTa2dZtAVZp1fqleP5wOpm7gUjo3it9RPFR3pZKJ7FbDO76M3PgN0y+Cmo2+WgLBPt9SY93PmKT3akgZCvn7j5mnLcD4P9NmWq+caTRQ14pBYTyDw12gynsqtqTN9nIodQKAdqfka8WviiLPzHM7YPT6Q8ee7AFYGhYoh4FeCtNToA8E3TOqO/li5xPNSdlnWpSXUibtbSHMXDiG3mwm1qsUzLJs52b2OydPTV8SaF1Fp5RxEIBRJzWL1ILwCjIep/mdOudTIMo248xssM4PdPPnxCVU7AZl6fe7JbdHDaKz+GniMjBGphXSdvXfuFzLJ+XOFxVGL2sjW0dhBy2MMxLoQ6FT9OL4O0E2fmyEculu3MqfIvDoPSIxepWeJOHQm+7kQti1tqj3xelxVABHve9zOuR8trj9yun3h
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:43.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920320e0-ee0d-49f4-fe3d-08dea476233d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10070
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

Hi all,

This series refactors the panthor register access paths so that each
component uses its own local iomem base instead of relying on the
global device mapping throughout the driver.

Today a number of register definitions and helpers are still expressed
in terms of the full device register space, which makes it easy for one
component to reach into another component's registers.

The series prepares the driver for a cleaner per-component layout in 3
steps:
- make the low-level GPU register helpers operate on an iomem pointer
  rather than a panthor_device pointer
- split register definitions and move cross-component accesses behind
  helpers owned by the relevant component
- convert GPU, PWR, firmware and MMU code to use component-local iomem
  bases, while keeping IRQ handling on a dedicated IRQ-local base.

The end result is that register accesses become more obviously scoped to
the component that owns them, cross-component register accesses are
removed from callers, and the common IRQ helpers no longer depend on
absolute register offsets.

No functional change is intended.

v3:
- Picked up Acks and Reviewed-bys from Boris, Liviu, and Steve.
- Cleaned up definition of pwr->iomem and pwr->irq.iomem.
- Link to v2: https://lore.kernel.org/all/20260412142951.2309135-1-karunika.choo@arm.com/
v2:
- Picked up Acks from Boris.
- Moved GPU_ID definitions into panthor_gpu_regs.h and deleted
  panthor_hw_regs.h
- Fixed incorrect spelling of timestamp helper functions.
- Changed IRQ request function to take an iomem pointer instead of an
  offset.
- Update panthor_gpu_info_init() to use the correct block-local iomem
  pointers for register accesses.
- Link to v1: https://lore.kernel.org/all/20260410164637.549145-1-karunika.choo@arm.com/

Kind regards,
Karunika

Karunika Choo (8):
  drm/panthor: Pass an iomem pointer to GPU register access helpers
  drm/panthor: Split register definitions by components
  drm/panthor: Replace cross-component register accesses with helpers
  drm/panthor: Store IRQ register base iomem pointer in panthor_irq
  drm/panthor: Use a local iomem base for GPU registers
  drm/panthor: Use a local iomem base for PWR registers
  drm/panthor: Use a local iomem base for firmware control registers
  drm/panthor: Use a local iomem base for MMU AS registers

 drivers/gpu/drm/panthor/panthor_device.c   |  28 +-
 drivers/gpu/drm/panthor/panthor_device.h   |  92 ++++---
 drivers/gpu/drm/panthor/panthor_drv.c      |   7 +-
 drivers/gpu/drm/panthor/panthor_fw.c       |  40 ++-
 drivers/gpu/drm/panthor/panthor_fw.h       |   1 +
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  29 ++
 drivers/gpu/drm/panthor/panthor_gpu.c      | 101 +++++--
 drivers/gpu/drm/panthor/panthor_gpu.h      |   6 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 119 +++++++++
 drivers/gpu/drm/panthor/panthor_heap.c     |   2 +-
 drivers/gpu/drm/panthor/panthor_hw.c       |  54 ++--
 drivers/gpu/drm/panthor/panthor_hw.h       |   2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c      |  46 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  69 +++++
 drivers/gpu/drm/panthor/panthor_pwr.c      |  93 ++++---
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  79 ++++++
 drivers/gpu/drm/panthor/panthor_regs.h     | 291 ---------------------
 drivers/gpu/drm/panthor/panthor_sched.c    |   5 +-
 18 files changed, 584 insertions(+), 480 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_fw_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_mmu_regs.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_pwr_regs.h
 delete mode 100644 drivers/gpu/drm/panthor/panthor_regs.h

--
2.43.0

