Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CCBCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 16:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BEE1121F3;
	Fri, 29 May 2026 16:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D4JxGbdI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6571121F3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 16:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNWECQNA8eTxpzm/XJOIsrSNVYPeDzUm8Yalo0FpyuhlUtg5eAZOFwUQz71zlMf9ayftYrUP+U+atSEXDRvR3ftBLbfi9BipG52+9kRVS07amLMzVy1c2R6NqmYrqEBNly8se4pqhN32t1HdJw+/WhSjIK476mpslu2qaIGDqiZozidKGTcNkLR4jyhVAsKIQSKp2ASeuhANOFBhsUXkC9JlhX7YiBE6S02RUs4K/yIr6T1L5WSXanft3QMRtcwg4ZN/aybsjreXCyOdrMuM78wuEH0tY34kFA/KolfFpjiqbDiTscTNom4JvzOZR+e361nd+SBfSVPOr+dE+D7HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX71y3XDMb6O3d+J+b+5xA2uzhH7G+OvyuauOLNOXXo=;
 b=M0VEekm9FAjfKQAxLiK/B0iul58UdmGOZqrOh63LA/LAdpj3r4tnzg0JXM9JJZ2Qi+w3RC/n1vsGkmOgtD135/UkfAfkfnKgW1JPPmN1WHFHdtENbgEKapFhU4Nod4R3xpwfvTMnzcGwxF6VaXX0BcRC2l8hnPSsqk864nl2ssBPVQv0Njt0qC9BbncZ/YKDawTjYb+lYlovePxwTeDfGwSjdBXSm4JbCJpaxyDPF+u7x94ypZXd/CJz01y83H6Mya78dX7wRlOTWBFNXtjqMTlvcumPKKujysoEHzlDpDOthsxJzpktIRYsFr/+tNwAwHW7TBhuQ5OKkUJXlQFMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX71y3XDMb6O3d+J+b+5xA2uzhH7G+OvyuauOLNOXXo=;
 b=D4JxGbdIjo2f/cq8R6AORsZZaQ34mh4EfJQsxAya68X4PwWy6jUna1EhhqMGzixsce6LqRxsKVbBbH7OV9evBnQ+3GCmfVzMB89kkWRGz3CULBChk7uXhOR+8QZx+Msmfb/eitXx0hdjesKBC4CdbD+Dt9YIX/TVCvc3+WOv430=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 29 May
 2026 16:14:33 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::9a) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 16:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 16:14:31 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:14:15 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:14:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 29 May 2026 11:14:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64TGEFtB3959378;
 Fri, 29 May 2026 11:14:15 -0500
Date: Fri, 29 May 2026 11:14:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Vitor Soares <ivitro@gmail.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, "David
 Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares
 <vitor.soares@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 06/11] arm64: dts: ti: k3-am62-verdin: Add Toradex
 Capacitive Touch Display 7" DSI
Message-ID: <20260529161415.5udu4na3ynthk2mm@brunch>
References: <20260522161105.277519-13-ivitro@gmail.com>
 <20260522161105.277519-19-ivitro@gmail.com>
 <20260529155345.z6ht5adzhwafdvx5@voting>
 <20260529160227.GA6917@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529160227.GA6917@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN2PR10MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0075a2-476f-43c2-c847-08debd9d5dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|22082099003|18002099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 4u9wYloH5bg0aW7+s6dfZe9sHDKZ9ERwLFDGmq+D5lL1btS3J/YgvUhYb3ppOlTrUBWERp1NzG81mhG5kdTmCG32YnN40WRYEwcg7HawFKdHs1VvbZ+KK+I+9yhpWs5HKBILuXy4FjdPOdYATqIzrVZZFVqGi6KC3nt2TnBTXqfY+C3WpPEiFmg8NJ6Ld+mIpoDWDSFWveqwWcxG5sHEJIRvDtNb8twiJAUWofY16fdXO1YkZbpsAV0ILGYAeaWfzTTUwI/4yFSMsnRzcrP9P9DG+5ZBQjaQ/mjRLe2F3xHN1a8WfLEK3/AP2aRQKXpttuNZa6V998Vgd/FZp4s9H6lM8RDNjOSTnj8605Km/a+EfSjkV+j4XuLEaVI9t2rxoSrI7hYVnMw/lhTHTtF5VNZLWY4/et623jLDyFVZWVbW0KbFjru8jEWJyLAfgT1PoamUBKKE+27/q07K0KBqkLBl7Ezt0wOkY4UcMhoUcNdwvJLvNnslPvltPD1iwnhFpNr+tVTrBfM+tBNpd6uUApRHxOfr5a9wqzY+YwEUku3jBbRkrqgoeGauK9rnFsktkUrQ6B+QhTLfUYsDr1uSlOaAbUwPgE7NPAVMVxPBtLCPr1cJ3DwF52ApcicCEHBd5YDgJHjCfXWQO01dhQRXVqgO8v7cA5EvKGC5fcZWACTWYXNMM4PVBva12O2gWqkG
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XMVg6Lzbzql0OzzRQ//Y7W6JOayjEdVl3aZQa5w7Gz4WaQVa3owTcvH9PanNR/HjCtOewpGXYwp0XjK1Xxto+xAqgEqz7Ap3jE/yJZWGQwK4WHN/GHPdAXdH8CFp5FJBNtjudtBnZRDLeDYsJLuu/ogpPARVFXR65TXEgQWRJ8StQrbjBtIa8eF8ho45w/5p005ZQwPRrMp4RrrRS19g4AXK59n4RDUJx8282YK2o6KO80jCwlBD0boCEEan6Rpxjx6ysT7jPkuEfP3++1UU7/zx4QN+uL3LknF8YpidfSYZUjv40+1xlT1/nJBsuQIX6NiZx02fT42i8S1O0nIQR4/DacP1zRNiekaPiUkTxydCzlg+O+gD6vbs1GJdDO6heUJSN5EikVblRGgftxdkN3IKDfWG46wlWWptJ9IK+sO9m5/kQm0MiYM2NXyLngLF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 16:14:31.5428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0075a2-476f-43c2-c847-08debd9d5dee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
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

On 18:02-20260529, Francesco Dolcini wrote:
> On Fri, May 29, 2026 at 10:53:45AM -0500, Nishanth Menon wrote:
> > On 17:11-20260522, Vitor Soares wrote:
> > > +	touchscreen@41 {
> > > +		compatible = "ilitek,ili2132";
> > > +		reg = <0x41>;
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_dsi1_int>, <&pinctrl_i2s_2_bclk_gpio>;
> > > +		/* Verdin GPIO_9_DSI (SODIMM 17) - TOUCH_INT# */
> > > +		interrupt-parent = <&main_gpio1>;
> > > +		interrupts = <49 IRQ_TYPE_EDGE_RISING>;
> > 
> > https://lore.kernel.org/r/20260521152550.A928B1F000E9@smtp.kernel.org
> > https://lore.kernel.org/r/20260522140245.472651F000E9@smtp.kernel.org
> > Sashiko comment would probably be good to explain - I see the same in
> > v3.
> 
> The interrupt pin of the ilitek,ili2132 touch controller is a very short
> pulse, the net name TOUCH_INT# is on the board side and it is generic,
> not specific on the touch controller used.
> 
> Both falling and edge would work fine.
> 
> The reason for using rising is that for the way the HW is designed the
> interrupt signal is not that "clean", and triggering on the falling edge
> produce some spurious interrupt. Those spurious interrupts are handled
> nicely by the driver, but they pollute the kernel logs for no reason.
> 
> 
> Nishanth: in general do you want an explicit answer to every comment made my
> sashiko?

Would be nice - or a comment in the code.. had me curious as well, when
i saw one dtso do it one way and the other do it the other way.. kinda
peaked interest.. ;)


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
