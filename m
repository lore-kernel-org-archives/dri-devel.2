Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF76E937E3
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3272A10E2C2;
	Sun, 12 Apr 2026 14:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="l4olrHVR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l4olrHVR";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011017.outbound.protection.outlook.com
 [40.107.130.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7683A10E032
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oQRT82B8aF42+U2lD8SVWKJUaoQ7Y4ZA599qH/gGmXAI2FKrB3QvpqVClujjrQUnp0Zz9XW7iWS2+tKuHtyqOc93KPEeKOwEiz62ZCRXms/WR+ugFlo60Unxxh/o4be4XyTlAZ9rT5vYht3XDvjAixVqyWImdRG72CfMSeUrhTkH3ninr3apj3EMwlBOmxTZ+3aWuk5epGN9qaCOBPmq+13oDyNqBRnVQukI7EM+syO+GwaZ0Rul0H0tZ86PugY6x00r8cVumdFpq6DTAWRlxFa1qdYFDaUTJo173y7f0k1jBZjywXNWoze5c+fVwKPNT5WsILkfRPS9hZfQ64ukKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WPgRFfrjuWztZ12VDI0F3bQUDgEDJZKiQrDUgy3Uw0=;
 b=b4xVQtPA4Eo4xbLgTfTvu0Ee/NSjr3+5Y9HOneRoqCn6iLIRHw31EGRZhDCKNhggtSFn3vqZfmITdISwCRrL4V92nyJWiF4tzpG7Vu5sJOJpOSXXUHSK3wd1upAh+kZ1Fvyh8vrC8PaScPrtkI8/3VXyFcaa/k6HUZTv5tefICLRe3RbzPvpLDz0WRTtbokFXu6icV+y50KG6F/8Q20gmHM1qZzd0isliIgL8kv7HbRH6p+S0RbHT1BUtsunKZhtVgCIGE+tqFn0/At8NbwHQFXqxev/Stu3MAhV2wzJzmqSvPUrTwMp3JU4C/QdqunAnQWFQbviG5H5ME/kI1kB/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WPgRFfrjuWztZ12VDI0F3bQUDgEDJZKiQrDUgy3Uw0=;
 b=l4olrHVRGpww0uIfEc1uox8fY4IWdsdvyIUB/+piE9XnmtVoAia7uTajIjdKc2TECJB+SmRcTJtmpLJr/9Dy28QpvY4ri7ue3ZdNSHF073/x9Lgc3vKNrWbqzY6DNs8H3n7on9JGXclY7GX9xEn7cy8+E8s+rxr75OZ3OnKPS80=
Received: from AS9PR06CA0763.eurprd06.prod.outlook.com (2603:10a6:20b:484::17)
 by DU0PR08MB7437.eurprd08.prod.outlook.com (2603:10a6:10:354::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Sun, 12 Apr
 2026 14:31:02 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:484:cafe::fc) by AS9PR06CA0763.outlook.office365.com
 (2603:10a6:20b:484::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sun,
 12 Apr 2026 14:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Sun, 12 Apr 2026 14:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPFjnkoMCAzY/3w7Q8OsKvMxw/fcsLO/b4rAs2VMc6uLCB+Iyh4Ot6yH/z7dIyboKWkW/B+OP16+/6muDUZYN44YwfRUPotsR2NyR5daY3cbkazaI6R/h2rCK3KQt4pEMGhESjtllI8xn0YPS6m5XqtoIn8a6ygedsAv/m0x3e6VuAfDH8sCAaZ9H+yvSA4ZZcPOE6Q2hnJuH33WEtWQc3YhlpZhjM+Byl0NUsxrDKQvfqRWg47tTjPdlZdR4OioEh84cumuNDPyzfnO0q7dZMVmSis+v6D57d7Kx8vNh/B2s1k9loi4I7uLIpUw6rGfrfq5V+LmQg21KOaKXz2Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WPgRFfrjuWztZ12VDI0F3bQUDgEDJZKiQrDUgy3Uw0=;
 b=uJTdB0MSjV2o0sKoXHk8KLS+kyETQvWfVym6+kTaZb0LG5SNGwSt8fsm2VMVLxZ13X/z4pnlVVuvn5aKgqYVl6EyDa6h3Dqm0mLlQiVxvgEt/4gECSkI00HzQH9yngXVNiMoLyyGlxQ8ASUhfRGT54OJoJxt7fJ0MK9FeRZYDh9HcbMmiQYdvL1E1AiMteuqgI3FNPCP8+zV9gF2OLS3BtqG2BFp8uuI+wZ4zwiQuYqMI0dIqg/Pw5FQzHuPlM5GNxvul3YLy0z9C5Dn7NQr32AdAWc+LbxMwZENZGGU50jgiAxZ7Hr8LW4zrhfpZFEOTb4EKIuGh/lx8E03aTDAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WPgRFfrjuWztZ12VDI0F3bQUDgEDJZKiQrDUgy3Uw0=;
 b=l4olrHVRGpww0uIfEc1uox8fY4IWdsdvyIUB/+piE9XnmtVoAia7uTajIjdKc2TECJB+SmRcTJtmpLJr/9Dy28QpvY4ri7ue3ZdNSHF073/x9Lgc3vKNrWbqzY6DNs8H3n7on9JGXclY7GX9xEn7cy8+E8s+rxr75OZ3OnKPS80=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:29:59 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:29:58 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] drm/panthor: Localize register access by component
Date: Sun, 12 Apr 2026 15:29:43 +0100
Message-ID: <20260412142951.2309135-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::12) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|AM3PEPF0000A790:EE_|DU0PR08MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daa3941-b98a-4557-cb5c-08de98a01f36
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: ljxkO58NmjKvr+0be1QxD4FfXBbGeGAoVEwgq+m3Ndnb1fOcYJMdi3rzVfWfb0g0V2QUj1/cLzVkvgYCTuyVoUE5UrR51in6/6UQN2IM1+YMTiHj7o/1W+ZqqA/yY+X4KFuGBOkqLbXTiK3OE3qRf2kNu7uXRjU/Aan26VaBM3PofpzFfxHMVSPj8AlrsI4ckaaRgYkH6po+LaHShPCx72/9z4lAzkdRsE72Fxp5LnjmWGmMvwdtt6pc0EMO6kMK9trLu9ZII0R+qCYFQznuGSWz87cOzONxBIM8bU7Mdx5TU5fmJojc+x9Xf1pKZrwadIfpQnhhx58Z4JOWriH1SZHavOQ8QoyrfWSe+k4fhIke9JVSKvQjWlbb41SikwlYtCfvIER4zaTVkgV4sVV1qlr2asli8zapx56thNtapTm7wiLveLDjr8mVD3pxoT2HUdQ4mjdJhRyRlKvevf3n9lLfv0Lyy5LBRdAM6OgII2GEY04O4UAiv5+c6vfkoPCsfMp2Zbl3X5i1mUH4/O3p2EIKx9RX4oyNtbgBgb+z/mz6BUIpj2zuPHYkf4CYDGtnOGkPjivNR2KO5nyHWuMI1wme357wu9qO0gEnoPqPb3t4iyS1Xy5zoGds/5ArMBP/tJ3o7rA7/5p5JK+Vahi7WDuHf3uEt1eSmrUw6dC1vEEDKqRwTo+/CDSJku3heY1WbbtxH5wilVivfTWOAaKyQj3zDh64iFHs0QqJHzeoRMw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: lKW8fQlKpoAsz6NRjT4dBgSqjgyDXRGRaWPYnLS2nuw6qtGKNjG1iwMIx1Bmhqid3GLEZ/bcXxtnVaig3ZQw6lEDK6HASIiFRRaYyXcy3h01XMMHWrniNWnBBbBDJZpY7tAwhNOBNLZanV7E4em62jFFzDub02QusrFDHqEAuYooG8Ruv98KMwcBdu5ayyQWssnBN+8ZlYOn+f2eiwoVDCFfh+R1nUEZxpvulwNZuREa8968/sGvWMt5BSpXHc+WQ9a2OmTZPTSGgLz5M/YwFeLo3YBITftx0+nh+LrfHvOWok4ebd0wvU1/p3y8cZwV4UG6SXUVuhayKBd/8xNaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 84606f19-2ea8-4d51-8771-08de989ff965
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|14060799003|376014|36860700016|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: j6LPnfnPPE4ULEvQH+QAmrZu1xwy1Zf9rFOaMcoTd0pNehQFv/+jm4zkCQMRRtgaj31+OnSQ6aQYyeSRAMkTuExLr1flQ5vT04f5/oLFA06QXrI3Y7s+Q0uP+ueKzhwdPxP98CS72fgHd6OVO818SmUtnQRi3lCpa9CC/4NcKX2W232PoTTyImW62T/IjsNUV01a1Gk2JJA0Zb7UkkzzNyVHigChBOlynolfuUnRI55iqHx1GiVvHH4ccUxTb1sj3pmF/dGFIx3ibGZkD1AGQLrtlGT4giSeQl1vmgaKGc4YGy9gJEwN4/X45J9pt7Ck6FYdvQJliehahB5oExYIeutb8rSn8TKEFt274vuLIw2/Ruo8eDkex7I8FfEcEzC6dyX2RdqBCUNp88+h9kstK5/aQiLEzciUI9YJ2o01ALRwEYC+BO6ffmUeH4ldWr0xU8HY8UolZAU6hrIdR8QR0+37b54fgJRcnzvwrQMmT/Fp0ux1zA1HMa+SNVQEo1MvpvJwlrAKoZo7udWJNiPTPWwLesobO4bR9KEvNVhmlQ+z/Ci+eaNQX+GXIMJIZB/9/ZBz1eE0N6UDR9C/2WmCv1/hPYgMK9JNiau13oEmLp8HUEaavGtyWy6eexUp3NC1+DH/SaBXTwrSJzu/zpXX6burV97nGPzffrR+I+EUMR3HFNuZKNc4w0OFNE7/OtKz+/jxo9ku2LaCqKh540UKLuCuDCL/nksJWYzt8hNmV8LRJkx4sDW7LoevQ6qpB9I1KQo2f3Bw+UKbvtXv75mEPA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(14060799003)(376014)(36860700016)(56012099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BQTgeNj5KVG0STW1VMYeVieONaSKuggIpcUYY/Qv85GCjYnw89Mdv/s8ny4kuToB+Ya1gB4OjnMiSMjPHnf1Q7GNMC+g91b4FLM1NqE8iwKyNkDCO9SMbwCvahnhsll14+jt1KZBjM5IJgOMxVafONyHeLN1LPBM1fyw6K5iKMGkf/7/osiRsOFb9CgD6VNw58/BNt9chii3FxVtEXpgZL5oAJApPtjhHevLdvFv2/56jLxeuvw6fbsCJQ8or636ReEMX3pipQORte2OuZ80BV4tLqKLPX5ggewVb0iwLvcMxICpsr6RMKvpDz4mJDHTDAh+efR8HP3XfbOpUK5B77FU0dhUuGa2dxcupY2KwPGU6CWC7TmHFcZHTkmF1GZyWIVt0S+ut3op9o74lzMZV8VRW9P845MXv6SZ0h2Iu34d1/UJiH+rzTVQIia1wue5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:01.8184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa3941-b98a-4557-cb5c-08de98a01f36
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7437
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

