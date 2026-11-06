Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4D606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qRNMvqAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0403C10E436;
	Fri,  6 Nov 2026 17:09:39 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCCD10E436
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmGrKDP20VS2e6aS5U0HDQZ0k196ONvSBs951Q1RTU0dbr6T9kQyWTqHX/L/xO0r9FvW5tOVFCfE5dG+1jzjrSIxm96lITQf5TGvrCCx/q/jc0d9g0F0YcNQpGaN4ZSa5+Xg3JH3EH1Iqpie4jjcicuGB+OCDg52SDc47TNRj8tk39T7tSkz/Mtw/bZMMxBTozlL0Oc+cMVEHhPssJyzpTEF18tuLB9mexj451wLPY4FNv2Ow/S33+/dabjxs4gZex2qpmYfGWg2Cpd+xUuUIv82cxTAVzC/fkHg61aLC+U4JYmlO67ZzTiHgtb7pUj9X9cmgbHZIVZ5ifW2cNw5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJiTmNu5Nz6qtf1J2pEdXqok6/CatEby03oYJ75Q4jA=;
 b=Q2P/8FOOuZAefRwiD0ZpnoUkR16POUAjDFv/8WE9wuJydqbpQyJ2+kDoQjRxMtJP2oDlbXUZQ49hQv+hr3euxxqMzeFpi/hdo5vIlwEFiJX0/01Jxf2lu3GnHUltvD+yRffFhGOfIYtOh//kdw2AqRjP8d6Vslm5+Cw8enniz1mAuoq52tdzcBMtMfjqDyNijySMTX4AQ3DT5BxqS/aQ1BAPyJcFli/A/LC8nrjDMPqOLSg7j3Fb3hGOPurHQ2tjy4jA5Jg1xq0MqxuSR91cWROVxOSm7Elu/888U4TttYmqmisRQJCj7dW0VCMdav4TOD617nED922yck11ehzADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJiTmNu5Nz6qtf1J2pEdXqok6/CatEby03oYJ75Q4jA=;
 b=qRNMvqAQ8ILnJZxhHsUNQkRYJuCzdciZ+GNzpyeawN89pIDzYBUG00Yj3wRbe8UKqMKXDSGJ1B/kG6MQXpFRmCBvYh7ehOkjJGrQZCz8btP3W3rmVNZqgOxAsCk5FPl6bmB0HsFGOx08m4YKD4jsXy1NsggatnkdPsSmgS9cRBk=
Received: from CH0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:610:cc::15)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:09:22 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4a) by CH0PR03CA0070.outlook.office365.com
 (2603:10b6:610:cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:09:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:09:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 11:09:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 11:09:19 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 6 Nov 2026 11:09:16 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <michal.simek@amd.com>, <deller@gmx.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <git@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>
Subject: [PATCH 1/2] fbdev: xilinxfb: remove the driver
Date: Fri, 6 Nov 2026 22:39:01 +0530
Message-ID: <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: e601d8af-b054-4e85-c525-08df3c28b33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|18002099003|22082099003|5023799004|11063799006|261021135927099003|261021121427099003|261021123027099003|10067099003|3023799007|261009223027099003|56012099006|261102123227099003|261022105027099003|261022113327099003|261022075727099003|6133799003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: o6tx2zara7nPj3m80cPSKPU4XiaSk7oTIe09oAzEjvNxgc+sTmLd5W3sJXWbcjHdjxHQvRNIcbYvFfb3baOmDc4IoOziehTybl5YWglOEtrIL05sHVa/lYrkmOIE6eR3fpe4GVgFbMLPRWxOaajzZhc7ksXOp7DaoD7qUY9LLxXtH8vv5gDaIQ3Vs8wRWSO2G0zWaZCpfAZE3Q4s7A+xxoDTG49xql+LFGeOxWOUCzPuUoB0n0IwxNUbajrbjlAy5UzUsbELXKVdakflbdGrbu8NCvT7VgrRuyazAgUjjYtGIbQXljxp0drOaiB4XJwArM15cWGINBY2YmUSPGHk6dRqh/FCGYB1z8YagE4kxDeC0+wEwoVWoSQ5RIcNDHVvv3BbD/x8D41aasRCjn6nNIHT5VzWsiCKrTemV7Q/7sGTR+fC3CvZfcF9mIrQkXI2QSU+aHahtNE+OqeE4eFdU4iJB1aixVyxVjZRgzc5WZ0xLyQCPoNO8SjLxxGsnB4+Sw/lb9/pSJ/kRb5RxQN3UfOMLiaQ5Fx9hkch1AVd2NYLdJ16jNFqTpDrHKl51JMYexS90PDHd7jrxt9+yxfppEPgUKTKgrO/PRIiKFoIs8o356pUwf7UV6Y+tsZrB4Jcu17n0hjUhEW4FlN01HlZCN/7Q15lVhGHK8nTMRW+qYHicykT7eDJtx2ki7GiU5SGbgNymab+SwjvsIXti95Gpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(5023799004)(11063799006)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(3023799007)(261009223027099003)(56012099006)(261102123227099003)(261022105027099003)(261022113327099003)(261022075727099003)(6133799003)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9nHkAig3R5iBL0oji3SvyahKDzU5sIlRka8+DejXeOI/LTJHskt113V8om32W+yQnCRQ9qQXtSiS4V2jJAEg21ijgRnhzTdCm9GZ4/6ap8Yq3W/xSIR/3AnNci1l65C6OSXyq42Z4r4x/H1oyZDXp271IsJyyP1HKPmqk23BeVzv9kYiIvPDzzwSxiangShMVFuxoL/1JJg+UjEMNqD9l7WvDeYdItg8I20fJFV0RhIeCMzMVdLrKwj1riRutAmGYl5UBrDjFKaQ9XVihf3ep1ncPo8APIODzAF0TjeNSl48pOearBQHx10Gse5+CVsEOd4D1ZY9myFxbapZATob+RC8stMT9BfhSm96aArLlDh0pZ+oaXB7WcYsffwF80Cfi+g4oES/BCqbEpO/vgDtgawJlPjriBa59TrPxvjbAZoLFNd76/iqV/72xb909xKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:09:21.2910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e601d8af-b054-4e85-c525-08df3c28b33c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove xilinx framebuffer soft IP driver. This IP core relies on Xilinx
Platform Studio (XPS) and the ISE Design suite, both of which were
discontinued by Xilinx years ago. Furthermore, modern AMD toolchains
(Vivado Design Suite and Vitis) provide no support for the legacy PLB
(Processor Local Bus) architecture used by these cores. As a result,
no new hardware designs can be built using this IP.

Nothing in the tree document the driver compatible strings. Given the
complete obsolescence of the supporting hardware development tools
and the lack of upstream users, remove the dead driver.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/video/fbdev/Kconfig    |   9 -
 drivers/video/fbdev/Makefile   |   1 -
 drivers/video/fbdev/xilinxfb.c | 502 ---------------------------------
 3 files changed, 512 deletions(-)
 delete mode 100644 drivers/video/fbdev/xilinxfb.c

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e8cd8cb76874..50673b83cb85 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1620,15 +1620,6 @@ config FB_PS3_DEFAULT_SIZE_M
 	  The default value can be overridden on the kernel command line
 	  using the "ps3fb" option (e.g. "ps3fb=9M");
 
-config FB_XILINX
-	tristate "Xilinx frame buffer support"
-	depends on FB && (MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP)
-	select FB_IOMEM_HELPERS
-	help
-	  Include support for the Xilinx ML300/ML403 reference design
-	  framebuffer. ML300 carries a 640*480 LCD display on the board,
-	  ML403 uses a standard DB15 VGA connector.
-
 config FB_GOLDFISH
 	tristate "Goldfish Framebuffer"
 	depends on FB
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 0b17c878154d..9b77459f1e7d 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -103,7 +103,6 @@ obj-$(CONFIG_FB_PS3)		  += ps3fb.o
 obj-$(CONFIG_FB_SM501)            += sm501fb.o
 obj-$(CONFIG_FB_UDL)		  += udlfb.o
 obj-$(CONFIG_FB_SMSCUFX)	  += smscufx.o
-obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-y				  += omap/
 obj-y                             += omap2/
diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
deleted file mode 100644
index 462fe2e94d55..000000000000
--- a/drivers/video/fbdev/xilinxfb.c
+++ /dev/null
@@ -1,502 +0,0 @@
-/*
- * Xilinx TFT frame buffer driver
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2007 (c) MontaVista Software, Inc.
- * 2007 (c) Secret Lab Technologies, Ltd.
- * 2009 (c) Xilinx Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/*
- * This driver was based on au1100fb.c by MontaVista rewritten for 2.6
- * by Embedded Alley Solutions <source@embeddedalley.com>, which in turn
- * was based on skeletonfb.c, Skeleton for a frame buffer device by
- * Geert Uytterhoeven.
- */
-
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/platform_device.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/of.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_PPC_DCR
-#include <asm/dcr.h>
-#endif
-
-#define DRIVER_NAME		"xilinxfb"
-
-/*
- * Xilinx calls it "TFT LCD Controller" though it can also be used for
- * the VGA port on the Xilinx ML40x board. This is a hardware display
- * controller for a 640x480 resolution TFT or VGA screen.
- *
- * The interface to the framebuffer is nice and simple.  There are two
- * control registers.  The first tells the LCD interface where in memory
- * the frame buffer is (only the 11 most significant bits are used, so
- * don't start thinking about scrolling).  The second allows the LCD to
- * be turned on or off as well as rotated 180 degrees.
- *
- * In case of direct BUS access the second control register will be at
- * an offset of 4 as compared to the DCR access where the offset is 1
- * i.e. REG_CTRL. So this is taken care in the function
- * xilinx_fb_out32 where it left shifts the offset 2 times in case of
- * direct BUS access.
- */
-#define NUM_REGS	2
-#define REG_FB_ADDR	0
-#define REG_CTRL	1
-#define REG_CTRL_ENABLE	 0x0001
-#define REG_CTRL_ROTATE	 0x0002
-
-/*
- * The hardware only handles a single mode: 640x480 24 bit true
- * color. Each pixel gets a word (32 bits) of memory.  Within each word,
- * the 8 most significant bits are ignored, the next 8 bits are the red
- * level, the next 8 bits are the green level and the 8 least
- * significant bits are the blue level.  Each row of the LCD uses 1024
- * words, but only the first 640 pixels are displayed with the other 384
- * words being ignored.  There are 480 rows.
- */
-#define BYTES_PER_PIXEL	4
-#define BITS_PER_PIXEL	(BYTES_PER_PIXEL * 8)
-
-#define RED_SHIFT	16
-#define GREEN_SHIFT	8
-#define BLUE_SHIFT	0
-
-#define PALETTE_ENTRIES_NO	16	/* passed to fb_alloc_cmap() */
-
-/* ML300/403 reference design framebuffer driver platform data struct */
-struct xilinxfb_platform_data {
-	u32 rotate_screen;      /* Flag to rotate display 180 degrees */
-	u32 screen_height_mm;   /* Physical dimensions of screen in mm */
-	u32 screen_width_mm;
-	u32 xres, yres;         /* resolution of screen in pixels */
-	u32 xvirt, yvirt;       /* resolution of memory buffer */
-
-	/* Physical address of framebuffer memory; If non-zero, driver
-	 * will use provided memory address instead of allocating one from
-	 * the consistent pool.
-	 */
-	u32 fb_phys;
-};
-
-/*
- * Default xilinxfb configuration
- */
-static const struct xilinxfb_platform_data xilinx_fb_default_pdata = {
-	.xres = 640,
-	.yres = 480,
-	.xvirt = 1024,
-	.yvirt = 480,
-};
-
-/*
- * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
- */
-static const struct fb_fix_screeninfo xilinx_fb_fix = {
-	.id =		"Xilinx",
-	.type =		FB_TYPE_PACKED_PIXELS,
-	.visual =	FB_VISUAL_TRUECOLOR,
-	.accel =	FB_ACCEL_NONE
-};
-
-static const struct fb_var_screeninfo xilinx_fb_var = {
-	.bits_per_pixel =	BITS_PER_PIXEL,
-
-	.red =		{ RED_SHIFT, 8, 0 },
-	.green =	{ GREEN_SHIFT, 8, 0 },
-	.blue =		{ BLUE_SHIFT, 8, 0 },
-	.transp =	{ 0, 0, 0 },
-
-	.activate =	FB_ACTIVATE_NOW
-};
-
-#define BUS_ACCESS_FLAG		0x1 /* 1 = BUS, 0 = DCR */
-#define LITTLE_ENDIAN_ACCESS	0x2 /* LITTLE ENDIAN IO functions */
-
-struct xilinxfb_drvdata {
-	struct fb_info	info;		/* FB driver info record */
-
-	phys_addr_t	regs_phys;	/* phys. address of the control
-					 * registers
-					 */
-	void __iomem	*regs;		/* virt. address of the control
-					 * registers
-					 */
-#ifdef CONFIG_PPC_DCR
-	dcr_host_t      dcr_host;
-	unsigned int    dcr_len;
-#endif
-	void		*fb_virt;	/* virt. address of the frame buffer */
-	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
-	int		fb_alloced;	/* Flag, was the fb memory alloced? */
-
-	u8		flags;		/* features of the driver */
-
-	u32		reg_ctrl_default;
-
-	u32		pseudo_palette[PALETTE_ENTRIES_NO];
-					/* Fake palette of 16 colors */
-};
-
-#define to_xilinxfb_drvdata(_info) \
-	container_of(_info, struct xilinxfb_drvdata, info)
-
-/*
- * The XPS TFT Controller can be accessed through BUS or DCR interface.
- * To perform the read/write on the registers we need to check on
- * which bus its connected and call the appropriate write API.
- */
-static void xilinx_fb_out32(struct xilinxfb_drvdata *drvdata, u32 offset,
-			    u32 val)
-{
-	if (drvdata->flags & BUS_ACCESS_FLAG) {
-		if (drvdata->flags & LITTLE_ENDIAN_ACCESS)
-			iowrite32(val, drvdata->regs + (offset << 2));
-		else
-			iowrite32be(val, drvdata->regs + (offset << 2));
-	}
-#ifdef CONFIG_PPC_DCR
-	else
-		dcr_write(drvdata->dcr_host, offset, val);
-#endif
-}
-
-static u32 xilinx_fb_in32(struct xilinxfb_drvdata *drvdata, u32 offset)
-{
-	if (drvdata->flags & BUS_ACCESS_FLAG) {
-		if (drvdata->flags & LITTLE_ENDIAN_ACCESS)
-			return ioread32(drvdata->regs + (offset << 2));
-		else
-			return ioread32be(drvdata->regs + (offset << 2));
-	}
-#ifdef CONFIG_PPC_DCR
-	else
-		return dcr_read(drvdata->dcr_host, offset);
-#endif
-	return 0;
-}
-
-static int
-xilinx_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-		    unsigned int blue, unsigned int transp, struct fb_info *fbi)
-{
-	u32 *palette = fbi->pseudo_palette;
-
-	if (regno >= PALETTE_ENTRIES_NO)
-		return -EINVAL;
-
-	if (fbi->var.grayscale) {
-		/* Convert color to grayscale.
-		 * grayscale = 0.30*R + 0.59*G + 0.11*B
-		 */
-		blue = (red * 77 + green * 151 + blue * 28 + 127) >> 8;
-		green = blue;
-		red = green;
-	}
-
-	/* fbi->fix.visual is always FB_VISUAL_TRUECOLOR */
-
-	/* We only handle 8 bits of each color. */
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
-	palette[regno] = (red << RED_SHIFT) | (green << GREEN_SHIFT) |
-			 (blue << BLUE_SHIFT);
-
-	return 0;
-}
-
-static int
-xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
-{
-	struct xilinxfb_drvdata *drvdata = to_xilinxfb_drvdata(fbi);
-
-	switch (blank_mode) {
-	case FB_BLANK_UNBLANK:
-		/* turn on panel */
-		xilinx_fb_out32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
-		break;
-
-	case FB_BLANK_NORMAL:
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	case FB_BLANK_POWERDOWN:
-		/* turn off panel */
-		xilinx_fb_out32(drvdata, REG_CTRL, 0);
-		break;
-
-	default:
-		break;
-	}
-	return 0; /* success */
-}
-
-static const struct fb_ops xilinxfb_ops = {
-	.owner			= THIS_MODULE,
-	FB_DEFAULT_IOMEM_OPS,
-	.fb_setcolreg		= xilinx_fb_setcolreg,
-	.fb_blank		= xilinx_fb_blank,
-};
-
-/* ---------------------------------------------------------------------
- * Bus independent setup/teardown
- */
-
-static int xilinxfb_assign(struct platform_device *pdev,
-			   struct xilinxfb_drvdata *drvdata,
-			   struct xilinxfb_platform_data *pdata)
-{
-	int rc;
-	struct device *dev = &pdev->dev;
-	int fbsize = pdata->xvirt * pdata->yvirt * BYTES_PER_PIXEL;
-
-	if (drvdata->flags & BUS_ACCESS_FLAG) {
-		struct resource *res;
-
-		drvdata->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-		if (IS_ERR(drvdata->regs))
-			return PTR_ERR(drvdata->regs);
-
-		drvdata->regs_phys = res->start;
-	}
-
-	/* Allocate the framebuffer memory */
-	if (pdata->fb_phys) {
-		drvdata->fb_phys = pdata->fb_phys;
-		drvdata->fb_virt = ioremap(pdata->fb_phys, fbsize);
-	} else {
-		drvdata->fb_alloced = 1;
-		drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
-						      &drvdata->fb_phys,
-						      GFP_KERNEL);
-	}
-
-	if (!drvdata->fb_virt) {
-		dev_err(dev, "Could not allocate frame buffer memory\n");
-		return -ENOMEM;
-	}
-
-	/* Clear (turn to black) the framebuffer */
-	memset_io((void __iomem *)drvdata->fb_virt, 0, fbsize);
-
-	/* Tell the hardware where the frame buffer is */
-	xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
-	rc = xilinx_fb_in32(drvdata, REG_FB_ADDR);
-	/* Endianness detection */
-	if (rc != drvdata->fb_phys) {
-		drvdata->flags |= LITTLE_ENDIAN_ACCESS;
-		xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
-	}
-
-	/* Turn on the display */
-	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
-	if (pdata->rotate_screen)
-		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
-	xilinx_fb_out32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
-
-	/* Fill struct fb_info */
-	drvdata->info.device = dev;
-	drvdata->info.screen_base = (void __iomem *)drvdata->fb_virt;
-	drvdata->info.fbops = &xilinxfb_ops;
-	drvdata->info.fix = xilinx_fb_fix;
-	drvdata->info.fix.smem_start = drvdata->fb_phys;
-	drvdata->info.fix.smem_len = fbsize;
-	drvdata->info.fix.line_length = pdata->xvirt * BYTES_PER_PIXEL;
-
-	drvdata->info.pseudo_palette = drvdata->pseudo_palette;
-	drvdata->info.var = xilinx_fb_var;
-	drvdata->info.var.height = pdata->screen_height_mm;
-	drvdata->info.var.width = pdata->screen_width_mm;
-	drvdata->info.var.xres = pdata->xres;
-	drvdata->info.var.yres = pdata->yres;
-	drvdata->info.var.xres_virtual = pdata->xvirt;
-	drvdata->info.var.yres_virtual = pdata->yvirt;
-
-	/* Allocate a colour map */
-	rc = fb_alloc_cmap(&drvdata->info.cmap, PALETTE_ENTRIES_NO, 0);
-	if (rc) {
-		dev_err(dev, "Fail to allocate colormap (%d entries)\n",
-			PALETTE_ENTRIES_NO);
-		goto err_cmap;
-	}
-
-	/* Register new frame buffer */
-	rc = register_framebuffer(&drvdata->info);
-	if (rc) {
-		dev_err(dev, "Could not register frame buffer\n");
-		goto err_regfb;
-	}
-
-	if (drvdata->flags & BUS_ACCESS_FLAG) {
-		/* Put a banner in the log (for DEBUG) */
-		dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
-			&drvdata->regs_phys, drvdata->regs);
-	}
-	/* Put a banner in the log (for DEBUG) */
-	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
-		(unsigned long long)drvdata->fb_phys, drvdata->fb_virt, fbsize);
-
-	return 0;	/* success */
-
-err_regfb:
-	fb_dealloc_cmap(&drvdata->info.cmap);
-
-err_cmap:
-	if (drvdata->fb_alloced)
-		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
-				  drvdata->fb_phys);
-	else
-		iounmap(drvdata->fb_virt);
-
-	/* Turn off the display */
-	xilinx_fb_out32(drvdata, REG_CTRL, 0);
-
-	return rc;
-}
-
-static void xilinxfb_release(struct device *dev)
-{
-	struct xilinxfb_drvdata *drvdata = dev_get_drvdata(dev);
-
-#if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
-	xilinx_fb_blank(FB_BLANK_POWERDOWN, &drvdata->info);
-#endif
-
-	unregister_framebuffer(&drvdata->info);
-
-	fb_dealloc_cmap(&drvdata->info.cmap);
-
-	if (drvdata->fb_alloced)
-		dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
-				  drvdata->fb_virt, drvdata->fb_phys);
-	else
-		iounmap(drvdata->fb_virt);
-
-	/* Turn off the display */
-	xilinx_fb_out32(drvdata, REG_CTRL, 0);
-
-#ifdef CONFIG_PPC_DCR
-	/* Release the resources, as allocated based on interface */
-	if (!(drvdata->flags & BUS_ACCESS_FLAG))
-		dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
-#endif
-}
-
-/* ---------------------------------------------------------------------
- * OF bus binding
- */
-
-static int xilinxfb_of_probe(struct platform_device *pdev)
-{
-	const u32 *prop;
-	u32 tft_access = 0;
-	struct xilinxfb_platform_data pdata;
-	int size;
-	struct xilinxfb_drvdata *drvdata;
-
-	/* Copy with the default pdata (not a ptr reference!) */
-	pdata = xilinx_fb_default_pdata;
-
-	/* Allocate the driver data region */
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	/*
-	 * To check whether the core is connected directly to DCR or BUS
-	 * interface and initialize the tft_access accordingly.
-	 */
-	of_property_read_u32(pdev->dev.of_node, "xlnx,dcr-splb-slave-if",
-			     &tft_access);
-
-	/*
-	 * Fill the resource structure if its direct BUS interface
-	 * otherwise fill the dcr_host structure.
-	 */
-	if (tft_access)
-		drvdata->flags |= BUS_ACCESS_FLAG;
-#ifdef CONFIG_PPC_DCR
-	else {
-		int start;
-
-		start = dcr_resource_start(pdev->dev.of_node, 0);
-		drvdata->dcr_len = dcr_resource_len(pdev->dev.of_node, 0);
-		drvdata->dcr_host = dcr_map(pdev->dev.of_node, start, drvdata->dcr_len);
-		if (!DCR_MAP_OK(drvdata->dcr_host)) {
-			dev_err(&pdev->dev, "invalid DCR address\n");
-			return -ENODEV;
-		}
-	}
-#endif
-
-	prop = of_get_property(pdev->dev.of_node, "phys-size", &size);
-	if ((prop) && (size >= sizeof(u32) * 2)) {
-		pdata.screen_width_mm = prop[0];
-		pdata.screen_height_mm = prop[1];
-	}
-
-	prop = of_get_property(pdev->dev.of_node, "resolution", &size);
-	if ((prop) && (size >= sizeof(u32) * 2)) {
-		pdata.xres = prop[0];
-		pdata.yres = prop[1];
-	}
-
-	prop = of_get_property(pdev->dev.of_node, "virtual-resolution", &size);
-	if ((prop) && (size >= sizeof(u32) * 2)) {
-		pdata.xvirt = prop[0];
-		pdata.yvirt = prop[1];
-	}
-
-	pdata.rotate_screen = of_property_read_bool(pdev->dev.of_node, "rotate-display");
-
-	platform_set_drvdata(pdev, drvdata);
-	return xilinxfb_assign(pdev, drvdata, &pdata);
-}
-
-static void xilinxfb_of_remove(struct platform_device *op)
-{
-	xilinxfb_release(&op->dev);
-}
-
-/* Match table for of_platform binding */
-static const struct of_device_id xilinxfb_of_match[] = {
-	{ .compatible = "xlnx,xps-tft-1.00.a", },
-	{ .compatible = "xlnx,xps-tft-2.00.a", },
-	{ .compatible = "xlnx,xps-tft-2.01.a", },
-	{ .compatible = "xlnx,plb-tft-cntlr-ref-1.00.a", },
-	{ .compatible = "xlnx,plb-dvi-cntlr-ref-1.00.c", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, xilinxfb_of_match);
-
-static struct platform_driver xilinxfb_of_driver = {
-	.probe = xilinxfb_of_probe,
-	.remove = xilinxfb_of_remove,
-	.driver = {
-		.name = DRIVER_NAME,
-		.of_match_table = xilinxfb_of_match,
-	},
-};
-
-module_platform_driver(xilinxfb_of_driver);
-
-MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
-MODULE_DESCRIPTION("Xilinx TFT frame buffer driver");
-MODULE_LICENSE("GPL");
-- 
2.44.4

