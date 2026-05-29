Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AEFCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 20:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75381124AC;
	Fri, 29 May 2026 20:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vG4H8L9J";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B96E1124AC
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 20:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFf88jsHBh/J3r+u78lary1i2mbhc3UR8htvhU2cicW3XaT1jCu/tWrmGBqv5rzmwsyfv7CoEgCXkRnWvBzZwqkQsqbQiwMYhJNZzdioNZQjUbxbEMGkX2h9kau1XoYA3CZWeCTssGei5cvtTm4ljWQUgKa10VowzHKGO4VO9Mkwf0M+I4metezDr/g2/sglpRuZHt91J4ktLmTb7xauX+wYcClrU6uPMdxzzLQR3hmM73pbuOyCoYRTjA08ztYRBoxp+gTzVwHJhX6rRMLeRiIunxx0kD72Spg+E+/6agE+I9m3v5UqHBJ/+uo+d6rv0YzVlCtxOagVOOpr8HYjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z++yGXrnuItwNYnKuotvbboICoE0BJ78sla09t4BNI=;
 b=xR9imDN0WyxHPF4sGDEEI9P4sESpOGfIrpHkHwzlWFfxc1bmGfL4qHvISNOJ0dVQgKTADnFDTUOUDSMSnYDxQPR3ishTyYsiCDwTWGUMeeh+3SfoqSEomDYjl93eJ3WJqHxKKwrRhfH7Lsjrcdhi4zv68fQ/E88AODQE0QfnqZ/WYP1pPK97j+1qNB9IoOaS1LNWfbaJ7vW+9dNKLkQO8F1NQDMkww6OEDcZIuN0HhVfFijbmsiQUj4xFuqo73EPSALlB0iX7vL+hf8ls+IYHD/w71DIFtUfholF0q4KV0cpVe2LGjHdRHjOx5PJKzaTVw2lrqUkdg25TKOqon6aaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z++yGXrnuItwNYnKuotvbboICoE0BJ78sla09t4BNI=;
 b=vG4H8L9JCK5Od+ncXlNOqnbckpDvWxqBJou9tGjm5wwkNcerOzV8xPBYTuaA5b/RRy5DLZq7GnFkGVwzEPd5jH319eDNW7Uvi8VSWbnrERXEX9CEx2c8AdpOjgemAVHBoI4F5yLeIn8KbsydVcW0dOXPQn8TLyygHJH2dleKT7k=
Received: from CY5PR22CA0034.namprd22.prod.outlook.com (2603:10b6:930:1d::10)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 20:08:35 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::63) by CY5PR22CA0034.outlook.office365.com
 (2603:10b6:930:1d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 20:08:33 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 15:08:32 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 15:08:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 29 May 2026 15:08:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64TK8W6R101622;
 Fri, 29 May 2026 15:08:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, "David
 Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares <ivitro@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add
 display and peripheral overlays
Date: Fri, 29 May 2026 15:08:30 -0500
Message-ID: <178008517336.3731914.15433260939449202476.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CO6PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: b47f21a9-07d6-4792-fd67-08debdbe0f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: cmZXWCewAlNxoxrUua+XNXoh00WEjdEvnBo9Qgi7lN8lsmvJk61EQVTuRZgpbQxF2i8loC2OFc+gULMHYMQOr1iI86LHqYgLKg4Kqd81+VMzN/k68uFNNTfXWppI1kHul+IvQYUHJp1ASt05lsHwej+e57OWC0doWxXk1H+T+ecFeHFwjr37ObSJhOVCnBB23W4cgJ8wiPs6kU1VJ48QwQyGe2fbacV0YoWnAf0Yb9BhJuu2MvcZwXEaeoO/XRFea32GgUth8gn8Q+YfuaN/5U7bqf0Q2QqQhNRrQPqNkiP13yVPGcxsr4zF78oW7qZfwqD/u4npBL4Fw+iW72SLNnnb3bVmJmXSlaHgsCJb/kfxWHUz/barNXFgSLDX1DXVI/8VFx88VX4Wt4v0Jl1KTt1HrHDUoB5zzaX7qvUqDLnl7Cp9s6T6Ktt4bNu/RoC3OpxBewSUaiNCchgRp4GyO1s4D2DNM4MkzN/1ZBh0Ijw85owcyMZH8sX27pfeO1/ShNAunwiAVOZ6vnE5fT33NOi01hbjdUhR+Dl6x7PGr/JCYVsyIPXnGPTqz2CP5Vq5y0aiZ3V0JhklmGsd3klHDtvoT+TGwH++kb8YuvvLf5/G5mAZsJvgh9QTvW4VYxYf40Q5Jidw/1CSb2jb0SMhsHrkVyDi15arHTHdUx4wVYUwaqdi9mUpKlsP4lD6pn8Uf4qfUtKFa39wGCaTvZmr6PjPZwOWzgdalgki+T3naeMw+lYVSdWn1+OOtZC1dKRpJwovlsAYSumNrWtvMI+pmGDtP+tR1k7jVZ3ioURtZfo=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S5xLz/u/g7P9BwIjkiKrz+um9DXkKHIcnff18qYdqqS/HUZNR066XwOlMC7EtcKUoW6JfxzFZvX7+l5h2NXZrSy7RTdQtX9a3AOF8eBdWg7664k7pCmWs8J/KX82cxDr83+hWSChPoopphtgSyD46IcxB5davSvRApTsJOz9B3smfRtCI4TrpIw6+R+tiT9QRfdYrgjhAEwRILTc9+pfU5rxYJYHkvL8XztSKlsnV4SEPt5gTRB5PmWX9Yofsq9N7LbKSGfKYvKYReGuitQDSdT8Tg4shr+Q3JTF1KsjhUOJop8rTrKj7pXkvPnevbYv9PFP2pVL5ojYqNVVq0vsB1BzNS90L4u2Sm3yb/v+vesdXZs9fHcdUR+Q5gBy1mHfA3lpN0/cWYsaybaguGeUgj08mwb8Hhk753Alfdjl0fu6oHSARmvr1OyTW1y14gIZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 20:08:33.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47f21a9-07d6-4792-fd67-08debdbe0f67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
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

Hi Vitor Soares,

On Fri, 22 May 2026 17:11:04 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> This series adds device tree overlays, expanding the hardware support for
> the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
> and peripherals available through Toradex carrier boards and the accessory
> ecosystem.
> 
> [...]

I have applied the following to branch ti-next on [1].

Now, I have assumed that [2] will get in, but if in the unlikely
event that things change, please notify me and I can drop the series.
Pulling this in from the best interest of Toradex community.

Thank you!

[01/11] arm64: dts: ti: k3-am62-verdin: Add Toradex DSI to LVDS adapter with 10.1" display
        commit: ff4427a465a018fedaadd607c8166588a28a79d1
[02/11] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display 10.1" LVDS
        commit: 38d01a245e66c30e7372a4a67d310fbcd8319649
[05/11] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display 10.1" DSI
        commit: 8e76e1539c440c3070e4004bd20392588f870010
[06/11] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display 7" DSI
        commit: 8a637725ad7cb29434bba0deb6b530d3116429b3
[07/11] arm64: dts: ti: k3-am62-verdin: Add NAU8822 Bridge Tied Load
        commit: a8891ba79990aded756e8bb92ebb690a4da6dab2
[08/11] arm64: dts: ti: k3-am62-verdin: Reserve UART_4 for Cortex-M4F
        commit: ca61bcec3e8a52ad2bf8b02f9244df1d47447ffa
[09/11] arm64: dts: ti: k3-am62-verdin: Add Toradex OV5640 CSI Cameras
        commit: f63de43a0d6f13874b6c20af0ca4726f7a5327f8
[10/11] arm64: dts: ti: k3-am62-verdin: Add Toradex Verdin Mezzanine CAN
        commit: a63211b0b7c9cea098ab954bbafec31982c89f57
[11/11] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with Toradex Display 10.1" LVDS
        commit: 837c7dbc5bee260768333c1f985dd0688b5aff8a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
[2] https://lore.kernel.org/linux-arm-kernel/178006233854.3611686.1401419911890133047.b4-ty@b4/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

