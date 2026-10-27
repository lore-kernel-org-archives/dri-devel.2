Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C5606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PyILi6XR;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PyILi6XR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F69010F718;
	Tue, 27 Oct 2026 16:23:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4B110F6E2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:22:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=docuoWG5e3gT4EDE+dynJmX8MWE46c/7W02f3GapMaEO6j3GlHCe0jaPHu27wqH7tn6cmDop7uCz/ky/k9NgSwWkMjRmX7Z18UHByEdfNNp7ARnOsiXer5k0vwrd5jy/szfzI4GBpIUi3T7guk79ZilleNqbaFed9wpf+eqg5ChtzB1jxtHeS6XE6vxar+x4f/UjHlv9BYUCCJSQKd3HP4IfyBTJbkEDiYR1PFpWSp4SDISd39Y3l5W9NPilJ8EpsqW5QnnUu1CeTZsHHvbWSNs0qOb2bl7JsCY6CRS2qPtcOMJ94r1kW/LZxtjevytF2FDvs1GiO389+HDGW5PhUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffSh9K1pECYmnG6bpzeXAxiB7nJkR2ubi6UQWJvuqE4=;
 b=xJTu/Np7VosaM+AvvXAWGBrCwHGo1DZ3ixoADNPGX/8JyUpYS3BG8yRPQChQ13URiDYG429zRytTa9X89Q6TgRIZEAEEwrKGCNcP5QigWGeq41SoUdmo2Lndee6DVoKlT2dp3B68wOxYKHwqz9kTa26DLEYvY/s2ZPmh+vcuT2YCd+hNICME7FfnSth2TrXoQ3Bb/wLDlXNicjL4pUPG1kfeskctgkJdQZXcp5Own3UOptH1sRdEO0Kmsa9BLajWC22s7PCRoGDC0W0lZDH73Bl39Vz9SnQd/nsWVZSWnlH5JQNa6j5H35IL2Nkuv0UljNSw/PMOyVAC7GKSA1ePqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffSh9K1pECYmnG6bpzeXAxiB7nJkR2ubi6UQWJvuqE4=;
 b=PyILi6XRbZv/ymiylCqwhhTzOR6h5q9+0LfexGNeVPP5utd/f6NyiAafiJZGy2N+fxOVT82q9lPYZi3lEg4jDLnZk1STrnisuSk8SrIw6ssQs0++q2jVz9bieca2pOpvXUY5bldbXEFkpKuOaAmZsvjyP3SDuWZYuqLX4MUnP0M=
Received: from GV3PEPF0001DBA8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e6) by DU0PR08MB8188.eurprd08.prod.outlook.com
 (2603:10a6:10:3ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:48 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com (2603:10a6:1d8::166)
 by GV3PEPF0001DBA8.outlook.office365.com (2603:10a6:158:401::6e6)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.11 via Frontend Transport; Tue, 27 Oct 2026 16:22:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Tue, 27 Oct 2026 16:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA3oiWVWAFJFvswT5Wbvsw9hSPYk+cgm82d5zBVOKX4hMPk//2mqnWhzlqBim8kZG1Sp9NFtJcCee2ge/y9GnS5YyH41hXtdK28on4ZoFQ12DtzEZd70aa36yR3IRzUMyT5rseQhawWcwj0AMMfm3Pw4QXnMK2h6R5ibr0etczpP/fDigRkYE5STPgacX7vogwOPeHp5Z3Up1GtSaXgCik2omW90L4iCcIerolp2RGbYj0CdoNOKurTEoHAmKiixtFxQes0MhTD8TMDr5wDiGFkDcCRu2rMfm3HkVOBzVIMyFkN8WqOAOwIR+tMJgYnKwxUlI2FqXiLU7AM3aj8GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffSh9K1pECYmnG6bpzeXAxiB7nJkR2ubi6UQWJvuqE4=;
 b=aicmw1ZTvtewvMPv/sE+AaKuvL5jyad10jFP98b42cBfVXFwzQN8+CJY2j0pnr2N+ocJFKPSZM2/zsW+LUmbyJs33PdA8cAIxQZlDMeAD752GB8VH1775o41UFQBMYpMtlFXmMJiBNMMmRqqZkmZs1mPh/iIn3I8ahi1Opn7Hd3daNonbZHhZKD1dRZlYjfUN7kySoWmvW0oL6Khnd+32C+Nv3nph6Z/1yCwHaD5tciVqhSMLXm5CvOwMGK0rjfIoOOm6NTf++NJu3mLHb4Ypeqnj0kZNsbAtirpv+tRhUCDZEAfWzcYqO0VB2S1B+QzcPG/a/cCidvKgvPcS9hhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffSh9K1pECYmnG6bpzeXAxiB7nJkR2ubi6UQWJvuqE4=;
 b=PyILi6XRbZv/ymiylCqwhhTzOR6h5q9+0LfexGNeVPP5utd/f6NyiAafiJZGy2N+fxOVT82q9lPYZi3lEg4jDLnZk1STrnisuSk8SrIw6ssQs0++q2jVz9bieca2pOpvXUY5bldbXEFkpKuOaAmZsvjyP3SDuWZYuqLX4MUnP0M=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAXPR08MB6335.eurprd08.prod.outlook.com
 (2603:10a6:102:12c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:15 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:22:14 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Tue, 27 Oct 2026 17:22:02 +0100
Subject: [PATCH v3 2/2] drm/syncobj: Use scope-based cleanup for
 eventfd_ctx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-efd-autofree-v3-2-caa2442e1beb@arm.com>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
In-Reply-To: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|PAXPR08MB6335:EE_|WA1PEPF000099CE:EE_|DU0PR08MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: e17b0198-297a-4174-531e-08df34468a13
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|261009221227099003|261021121427099003|261009223027099003|261021123027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: RfBUW/Okd5rwbAtyAsX4YRaigMQ/yyGeEiffgKfwPIh3aYPiaxFR1vocVbqLuuI98z0YtpPEuxKvCCzYan63/lBuYZuj+LRf3Bw5gYNNefU6qZmB7RZ9Eqqc6g/Ux+NBmuxK+5iVib2Q35faQLcWzWxT2Og0AKprpjvmIH9gh6JCaGgWqRTazXRwe236pGUon0b/rXgk907eRG0OZAqn2C1OB7GCnaiH3X5NsEhLl+z8QrwCK6BXii4DE7LN0Ke7FRoslOjx+043Gp1ijacvW81n+pM0lOIV2E3YKJpMyjjEzExl4pPMq5szqGQFbYzkQDcNQHAbqOcYL9LbT1b/J04U/pJ/Qsr0j+hGBpw+8V/u8fexqTWkAhpVGKYEiHVbhV+1DYnAgPlr2XvMgaySwn3xR60038rRAfp2oEs10zFXY5gLwN5lYJZ8oL1kcObB1hzl304cnxegvtaojWVdtdddEnzoaRamiEalloIK97CMaDYYuvhvDwChv/WJTNOSvKHtqWWEFbdEGVxaReRuGqRYOC+xtwGPWeQDNJv6Qn2NahQO4reDvgrR7Gh7ATJ9AtmMGtU/ZcEgCgeZ4MMAd6crGrILSEQpPs9kkQaSmUnTkWvHyPZe3HZ8fnoLDaaqwB4GHs8/q7JS8U9Y8AxDCUWelML3qTUowd1AA60paP4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(261009221227099003)(261021121427099003)(261009223027099003)(261021123027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: DBSW7UG+vyacYY/39RvTxZJh3Q0Jr1I2n7XI0ZRb2xUeOac40pefEWU7KQQaiajUyHErvOMk9CnIF4aB0j07IoSrY9koaLu0B2SFoy7vKUMvvKpx2ADKG/kv5umgiBhlRjqA7FC/V4IBVLnoasqeerCOZ6xgzs2Cscyqd/RLtpV0l0V0Xalp2RtWetuKyoHqklE9UxIvkvq9sQ1bPbSHIsnEcpU4EyPKT/TNSRg1iaNpY6eRO0hpD+mgzTFPN1RUBE5kVWOgnaJPLITtPCMbUg8oL1oqHzWVS5EE+60OBTTa/9ES3SlAZul4Pk2nr5XlieVlOtsUWrHc9UcgGY4GmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6335
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2f760123-6648-4e88-fcf3-08df344675f7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|35042699022|23010399003|36860700016|14060799003|82310400026|11063799006|56012099006|261009223027099003|261009221227099003|261021121427099003|261021123027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: YfqEhuBklolpWr6hCa/2seyUIfFdWAx3ayMGqYs/ZuP1A9gXGI6RooKUhwcqwc/e2UosM84/ASs2wu5kGTb3mv1kn96lf9s3x84eXEngt7dVrGvlQWJp249v5TW2M5BCcgG/BcresnbLugvLmSUm0+AXKmLsmjMg8FUIsx7RM5c2aLWBxDPyTCvehrluQlFTNGi6gUSjhxMeiPoKTCmr+i5fcBVRwhR5qUaz1dcoRQce+fQJlfEWwcw8JMlBN5yWH0glR31ET2bfUs+yBGAd7/wt1EWnNhLoh8jtWZV6Lg8JNnxATlc9s2Wcw3x0gVkcrFpI2La1vazdRBPf49JmKKmalCWXj/4xnt0FZ0gLsp38c0oq3v35fv93V4SsHHB0b73xUu9Kb/KsGnhRIOvhRTaGm0kcjMEaz24pNPT1WAYb6ceMZ7SdCz/FjJ6jHf0Ki3LPuc34oPEUzLwz5+bP4zSVTrzOOPh1bxRP/qdxyJS+fqt3jsRxvbZDzomy2YQAorXh48C28YetzYTbLTw/H5lSnBcGNOhKl4TU1Z2+QW/LOataDWEL46uljfzxjtTD6I3nZWBlGH/faZuQeF6RjA/vhu+ZlMtgK3woQqrqaipbAeYRNgI5HkIFZBEj/3YIhyH3rys9902joOLFKa8POfI5w3Jbha+IYpo28gJ92EE/W/51MI2GvzzB3LV9ZJURA7C8Wlt4vFgOvOKRyfLmpQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(35042699022)(23010399003)(36860700016)(14060799003)(82310400026)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fljidX412vJtVBpYG8bG2v7rS9SE6csn/6xO77FQrbIIlTBzpP+0HMyqPvKTUl9LQ1Z38GICFb3fTg7T31WmnaFwhZsjmDIJAUfcwDSNcQYfpf0WrpkXtTtMCxx9RgYxXVyAD8nDM5cFKB2xad0tv8ltnLl4rT7TFh7HImQrrG6Nhf33VSWMGdmPDAfwUcjs14CC7+7i6WLFc9Xq6K/y4oe7oC7yAbZ7nNF87axhPndVEL1aJF2bSBay+cZCbUDY3kgVbw7eloC+uxk3Jbc+ut3sXzW3yPNRnS0IUxrFT6+nSZ6RireuxcwupCnrHQ8twJUr4FHSNXgWCZYluc3CaEcyLlz/XggoTSR/GLZ2nYXxH36Q3QlqbrNHgIkpmx1eA+FKQUwQqCUPuGgNIg4Nf1l10fdEaJ0uxGR8+qpmhbA/dDLHkVFp3dTxxwpOUmrJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:47.6751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17b0198-297a-4174-531e-08df34468a13
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8188
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

Now that eventfd supports __free(), use it in drm_syncobj_eventfd_ioctl().

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 drivers/gpu/drm/drm_syncobj.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index f1d4da168545..40bedd30b2fc 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1429,9 +1429,9 @@ int
 drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *file_private)
 {
+	struct eventfd_ctx *ev_fd_ctx __free(eventfd) = NULL;
 	struct drm_syncobj_eventfd *args = data;
 	struct drm_syncobj *syncobj;
-	struct eventfd_ctx *ev_fd_ctx;
 	struct syncobj_eventfd_entry *entry;
 	int ret;
 
@@ -1457,10 +1457,10 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	entry = kzalloc_obj(*entry);
 	if (!entry) {
 		ret = -ENOMEM;
-		goto err_kzalloc;
+		goto err_fdget;
 	}
 	entry->syncobj = syncobj;
-	entry->ev_fd_ctx = ev_fd_ctx;
+	entry->ev_fd_ctx = no_free_ptr(ev_fd_ctx);
 	entry->point = args->point;
 	entry->flags = args->flags;
 
@@ -1469,8 +1469,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 
 	return 0;
 
-err_kzalloc:
-	eventfd_ctx_put(ev_fd_ctx);
 err_fdget:
 	drm_syncobj_put(syncobj);
 	return ret;

-- 
2.56.0

