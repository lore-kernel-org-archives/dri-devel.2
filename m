Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB9606A329
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=j9yJfB5i;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=j9yJfB5i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB2D10F780;
	Tue, 24 Nov 2026 16:20:53 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6661A10F66C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:20:42 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PpWG3gOj47ld0Q6VurrhboSn6eQrHE5CUADpcYH8WCp75LMCe+/qbz0jvLqUykKddrq459H/iz7Zc/Ym/X3v2zCN151ZGJoi7Mupv1VlTx24Uy2qLzst/XQvzCbXD9IJazHFocnPBijT+je8HJPQb/Z4sZRRyy9UANSEFisCMoP50zgpGTh9OiHC02+CgtNgzlTJmnVnvYyky4IPY1HaEQrc6iGP0hm4hjdu3snK64LNPld+kwYGd4BH1RkroO3AXMxDsTiHe9XDUF2p1GgUP/WNYrwbSEeAFxZoq05kai5/WmiIZGY0oyKN2P/sdpVxJkgHky7JVdrAUpbWxI6lJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=emq/S89wX5VaLe70hmLFN4F2A3y7cHoDCGlz3xOZVbGzHm7G5jpOCRT167U1Wu3P/wbQcCOvgYLV1kcDNVf5K3n45PKm/5+wEUWIRcsSB/HKBBf1abWh8UguU6WZk4QcevrjkCo2KbGBwCauht1SHUb7mqJdSAFkI2IJEfBGilkXieeJ5NFiCMq+L2IsHyyxJZvDokbteh8O7lRvpnYqoxdjlhMYhGDpX+aIzbX4fkuxJnxWZn6ahJzbSqx3PRYm5QOA2nLek6LnFfSUdwUSfM7u4TbEkhpz0H8Ld5jwUAMj2ed5jbi+hcaMUQNF7GMZLY0FxJs0n/uuRfLfFBA3YQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=j9yJfB5i1nkBfxVYpKGLgJ5q5S2UE0msbPV/OP7sIe3iDYfE4+pCTsV978pwTLG/9aNb9IZZd/PggkY7JWIb17/X9JBKTSVkbjoop99NaiTINFFkbTuKDzukpxKRwq77f4I8yfFru7w4xM0qCEWtLHOjFE4wIr3JdK9qsmCIBqA=
Received: from VI1P194CA0031.EURP194.PROD.OUTLOOK.COM (2603:10a6:803:3c::20)
 by ZR6PR08MB180730.eurprd08.prod.outlook.com (2603:10a6:910:e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:38 +0000
Received: from MI3PEPF00008488.eurprd02.prod.outlook.com
 (2603:10a6:803:3c:cafe::62) by VI1P194CA0031.outlook.office365.com
 (2603:10a6:803:3c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 16:20:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008488.mail.protection.outlook.com (10.167.240.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNDtu1jdVq1JMTXeM+SIfDYbRWqLzzSH/EcOJIzeOIrYztWRc5Y32XQJvgo6BkWQYFNgnhTg0qyWccziN7Z+0+6EDGAsLFBhZoeXTTOiUg1p//iOLzCNJE6kJUgPnehAkhZMBAvdEjt3uPzCJ9TWLtPCdMqI5aONOg22ON+w+SXF1sw+yY47Eweup95VmGuX1w+V92LwwplChsxY2AAyzSFOqs3ayAW3puHIoJvRHspkrqHPT7qkSIQCH+3JdpvLd8xK6NWD9yq2nbAMpfHxkhNOM04Q9y5vKHlFMxvWrd46zGXXoYaxlEao5PV6XzTzjJAgNJ6B+AgrYKkepH0YSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=PPPfU7PTTAlUBHEBEgvOzQkxS3Rl5LuYwlGdcWR7lXaw+81Lvhry5NsekKOB9cKHGxCtI80e/r3+tMReIEvMl165UJT14T++pfRWhY24WXp3XcHvv29EdCvj66sBPeo8+o+grtRvXZNBrNsoMQR+dKN3vLL9WRAQpDkvUv7+AyFbjibpDScDO4l0Lw9pjkcAwfDTgfk5QitVcjwF9b9NDPD4vNxlJ0DnQpQSPZ1KC0+NuFB/PDnJp/Bk/IWBrDhtbyWwZDt0vRmO+kD7MvLt4zHNtHiXGxJE6ZeXQb9K+pH7MLPISuYKEkyhnc0brVeyZVKPEmvKznNk2YAuh+UuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAwddQeUkfulWmc05IVYKubi8Po7HPv3Tlxf8GAGqrE=;
 b=j9yJfB5i1nkBfxVYpKGLgJ5q5S2UE0msbPV/OP7sIe3iDYfE4+pCTsV978pwTLG/9aNb9IZZd/PggkY7JWIb17/X9JBKTSVkbjoop99NaiTINFFkbTuKDzukpxKRwq77f4I8yfFru7w4xM0qCEWtLHOjFE4wIr3JdK9qsmCIBqA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by VI3PR08MB938182.eurprd08.prod.outlook.com (2603:10a6:800:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:04 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:04 +0000
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
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v5 1/9] drm/panthor: Ignore -EOPNOTSUPP for shader-present
 nvmem lookup
Date: Tue, 24 Nov 2026 16:19:39 +0000
Message-ID: <20261124161952.1053586-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|VI3PR08MB938182:EE_|MI3PEPF00008488:EE_|ZR6PR08MB180730:EE_
X-MS-Office365-Filtering-Correlation-Id: 143729ce-bd96-48f3-8423-08df4a46dffd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261021121427099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: zTXbvpIhCbEtwosyV1sPGyvJrFCK9wgLyyoO+qKxUdygMtfZ5MiybKDDqxdPNoLEPDBBUv3pw9eDjCFyWvRacqAsA5r+vrNJQABNLK1oUC78+HOcwMEPeLayK1rcklQ059FLNgUOuso2YkQarf9bliG7y3KkwzdqEc2R5b97ifJacRqosBGdEQSuT5/AZ9nE3DjrIvOgUZ27OcHiKu2ro7k/QZ0WPHD9y8et0lYod7Sj74uCqnWPbflAXDwuE8Khj3igRRtYLD09PgCAlDgAJh4Cbu2rbEKpNeZofWfDjw/9huMwrniq0g4IKUmV291/v1DsSUnUQsx/wtJ5MDQsyxuNpN0irGvX+dEuPkLhv1BDFiy8gUF1nHdLf2P2asUJ6KRGa8Emjr1z0yP9+A7/VRrj8a8Ekq3C0trmwz8Qf8S5hlZCCLf+JaOy/P1YPZAweFLuPv/1WjISMt5KXzppr3Ba0iDiQaGakyxycdB2GtZMMp/6LRnwGKadhmyK5ocAts71hr6lbbHV/IveW2kFJ0cd0iNO4H83xul1KNQ0HNPyIVKr25nYPeptTpm4317ihphoh85zSrS8qLbwv2kVJc6a+ivfty2njKgNidVR1Mqb0ixxBC+N0dYhG0lyGTvhi8TJ1cO832Yp2Pfx+oriaZL7e8NHCHjWJ9oRtfl/F7k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Obwr8ILGi0zPPpA20Ed5amJK+d21H8yfZZYM9K0wxitVXpHqUYoV1+zW9NVpp1VnKeQD6SeEtHE+krQgp0tuC/neVzn+Dz8mvI3w2Wqo1jjE0sh2iwt0DEY10+nA8bbisr5GWRqYzbogUQ0I7nljQcSAq2TO569+CR6aJRcHSnO8bss7Z8Lkj8J8yzzmkJ2EPjbDWtO5aIK0bf2H8sx36TQA6mr8X/AtRGhb6N2Kk48Wh2LoIrGFVP2sBHwkAeLJ4Zw/qxGPpYotU1CCzMfomVUp8ht+ND6+T4gIsgBZ2w2sBwa0D3dH9IPzEIlVrLyQzEp16X92VE2o/da6h/jCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB938182
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b8f6910-dd59-491c-287b-08df4a46cc46
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|23010399003|36860700016|82310400026|1800799024|376014|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UBm7bwsxJGChQcQXnyXmxO8mgnqHzy/U/9d+phITB5dMOCx7v9P6KINS21cPYnvV48eoF7lTlUc4vKfAP1P4/3K1fNbfKTXFuGQBUQRLZjyTRviRocQDzWjcTiNZeWdc34REqjHL5WirjzmYc5OekJdpnBGYBirU+ZBQLqzm3w2cg+XzjRzFo4CASXMFCkFZn292gUoz8DAXOLy6ruiCr9n8/BXfZZUKOUHFhr8jRckfum2B/xOe5bM327rDuc16Jw/elyRyBaEDs9jVHZUZcxRI5lh2YQf6/Ym8605eiKlpo4i0tuo9UeSQfeaujsj/Mf3yaVLHA61nkK0f/tL+pxSkMrzd8mU4Bqzxd224s0y4igiSsgm7+GB0Df67To6TeHuKINmap4VcEcRplWaKnNK+RktCJLQPzcQBXV4jwKlGtDrQincNVuTe1hHerxZUhLaC1ovFo2nBbNuDicvZReUBWR/0wfati7I5J2vrowm1XE5ql87YIWWp7x9Rtzv3HGHYsB9QtVe2gE8+EnEDIV5ZpEOD5aKr2VH3YmYKhu4+MD7HYOQhIKpd5meFCiMBGMHrowbjr8U3q1SZVwx29fkkDjzEEUpCwUrQQOYaxVB3mKJfds4W+/9z/QubBKNcOG+m6If9v7ejC2ANaqH1LmWnS4SHJq6UXXp1CTSa0YvCnCuE2VtMTZ40fQuRCejHqfOS00Bjn2S2Bp3lxhyS9g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kam/3Xv5CgLW7ZlFuZlh1CVeW/ItewR9xCcCz8ke0F4OsbM+A2vnx5ud3ITDIt7kXbC2JNA3dr7rCX5yCXiod63C61RXoCVNFCrVu7nPk7QSVK2qADzo1TQVvYe3V+Gj+6w+Asp7aJeJvTafx2DRjph4lWJhj+XOJFX1fqtZoItVIaby83a3rv6u370BKmluudZ0bUlRtoNRIXYK6K/E0wSQRDzf/1GpD5eKVSehY2u4+wm3fkJmpLCjAwag3m/X1UgwhGnX+Qjn7kyUljIlCJY+qtaeoZHX2Y26k0oJ0UDCzOcebzlId/RPB4V7P9131CPs5h7CsCE+wYWEcbUpGzgfJL1CagTQIL3Y81d2Rkp4gf1ajtpBkZuN5rsk0s432HPXpOqlSB50TuOXnewJuC5Vd/wiaWCrTbGgYpWR/jld0nOanljjmZtlDt1A4cbF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:37.4144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143729ce-bd96-48f3-8423-08df4a46dffd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB180730
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

When CONFIG_NVMEM is disabled, reading the optional "shader-present"
nvmem cell can return -EOPNOTSUPP.

Treat this the same as the cell being absent so panthor can continue
probing on platforms that do not provide shader-present fuses through
nvmem.

Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from nvmem")
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
v1:
- Picked up R-bs from Boris and Steve
- Added Fixes tag

 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index ea1e222ef1210..34dc4b9d9dc09 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 					      &contents);
 	if (!ret)
 		ptdev->gpu_info.shader_present = contents;
-	else if (ret == -ENOENT)
+	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
 		return 0;
 	else
 		return dev_err_probe(ptdev->base.dev, ret,
-- 
2.43.0

