Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358B606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=emq3NGpv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600AA10E6BA;
	Fri, 23 Oct 2026 16:49:02 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D9410E0D7
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7+wHGobHP2tqCOrCNFeDXuejep509mL4dw8OhzuJ60rEtE1CulXYH4TxSjbjCY9Hqn0OvmhQ2NweQmw4z+ftcrzTGZP+C5/eHc1aJx40DBZw62AWxvoHJhzyVacinZZiDqJeOJVjG4P4COlCLa4Db59oAgCgvudBN1Whgi+AoCirx5QU3rtqxk+wo60T7LaJ7A4mLwkYrzl6gVZAxm8tJ4RO0URZOP6REUUGn1m7G2nv4z3fH2PS+eQtLWNom4SSJj1Wlh7xFUGRT1hgYN2hoVWURiDvmYbJhKifHYpQ+oAyBkHtwrMPlKX58S70sfbFQyKlCHv5BSP3k5wZP9ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvjfI4Or4C22ribIFtL/yjUf5aGR40YaYNI9wDihIaY=;
 b=qjxH0tgAIIrz0zSZAAxhx6atZ+E9jmRIYlInJ3AFBnjUYwiP455bQWIaZby3FMHThc9b6hwVU5jDk78Rqp8VEbEPmzouV7cNzk9LkCslj820t7iuZlOuV1Zng34/I14BUvHlzF9DGXpz2d6fyEVGCD9HEFCvfl4XRrx8w3kG5JJ3fJH9elspsoi41hvBGBZWx28/uAMbdFtQLXSzMYI2amh+7WYv9d87fnWYTqgMsKuVVF0RKp761j67jy7qIcKrtgH+x0Y7knQeCOi4dMK/gIxPjFUf2HdLcwD+KTbgUBVkG9h9g4Cc1J+IquoJIH+BziOWiYHCsZcP2qZp7aQ42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvjfI4Or4C22ribIFtL/yjUf5aGR40YaYNI9wDihIaY=;
 b=emq3NGpvb6bj1rNwFYHVc9fNN+UzBnFG2Jh0PvA48/b8uij0jU1aDIUyzbaxlWAodaCmiBJ470dvut86ZReW9FiV7uwADVRsjB8+5SftBJHmE9FYXGyf3TnguTJohdkyRa/tyBc8lvsdlhdkxW1Td7dJSIn5HsNTpo3p/YjRsug=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:48:35 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:48:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/10] drm: renesas: rz-du: Add RZ/G3E support
Date: Fri, 23 Oct 2026 18:47:33 +0200
Message-ID: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1db914-f629-4e19-ed0b-08df31257a51
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|260925021911599003|260925022911599003|260925021311599003|10067099003|56012099006|3023799007|6133799003|18002099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: ZZNbKdmGlZf2ZjirUp8bZ40lCZ+OArWgkGsTZjfLyDVkhuuNFfDmLjbV4a7eqBVUa65yeLELa/i+snE/o1RkX7o/iqcHz94CNMwJxAGncC6zMMmuadwv3Z+0UZ3BbD9PPA3RldPRt0tbrdEv5U0XVhV4HzUKCMNjsNmORm3SiikPiHYplMlJQ4MgKqo4cA81/o1M5vvrmQxD0vweHJmtk/wDe9h1xVE25BFOZHYOAmp0wVGEfTSmIk3LtCCW2jELmlMYYJMHiSQRWbqcZPM0kZ5nQV4MHdsgLoGbGDlUDjcxxycsRxK65g2iWWygS8gd0Cqhn3obHt4utAbQQj5m+LfakbCOVrdMMJkUDB+wFKhaixztfrOT5xLsuhHo6TmUbqo4mxyY6NY78AlkfkoaQ+W8qZOhbFqG5J6pK28GAgJ+uUQIrYGFR+bRLxODgCqLE6R+VFjEu10aSedE2c7SRgXKw2/dszqwQf34cdrjHpHcDtpr+Yw8tNaURDHQH1TgWy7QTlmAWFEiEEOCK6LBt0xbrz40VnjxEUP7+0N9m0hXfBWXrArR3CwkVDB2R1WmRzuNzb1lA64ysxBDZbZEjSQgIJMOheDD4Sf0dBAZELEF+0wFiP1hxcuvRCpJ+zV+iFSpM0MZ2rv0BR9ZRLH8ggsa0H2RPkqet/13m7WWe/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36O35HmXM8XfIUrI3ADIz60vtlGr0VvsdRUoNXd+nEY1f/iKqv3iLfOvCijG?=
 =?us-ascii?Q?VM/Q3wjPANUuuQagwPySuFm60e/zjahCtosrgZaxzfeR36fx+l56np7p8Gq9?=
 =?us-ascii?Q?ODd/RGAa73y+tTr4HQbnq9fbCPTBQ5GNYGm9MPhcH198RGkDIWL2whdr43Wa?=
 =?us-ascii?Q?Q1HgFmbFga9B593KvWXiqjyGEFJMAZ5zZ1ZEru6vTqLY3R6yVCADkLeOO3DM?=
 =?us-ascii?Q?/qmzZQ20tSxp96jBHyg7g+fOjobUG+fKsC2Ae01FtGkvFkdFfckqVJd17dG7?=
 =?us-ascii?Q?jY9On9j9CPlfufO6y5d7hm/jXgLcrrKSM7SleMpDay7E6oExa3NE9ypQT1XZ?=
 =?us-ascii?Q?eCnYeoUMRtkZozGoxicSa+hmU6UovdnwDWHBvqgo5XHltQq7Zhn8ag/C6id4?=
 =?us-ascii?Q?GhZNjMnf853j2oGOVZ3XSPSFmxpuc4Se/HB+v+cBFAyKcjhqKsdrXKsctJhX?=
 =?us-ascii?Q?K8DGC0oXVlhNGaSEhpZqPqv0y2tZ+MtAnZQu3+c6n9q40dd2o+U+zCis95nR?=
 =?us-ascii?Q?kclR9BI9Zd8Xe6ojbJrrqm+9qm7QVGHDWUcewM9vlII4fczT8hPK+iRGk6eW?=
 =?us-ascii?Q?HctqMsNDB5n0b4tHEP9KscAqwlcXW49TM0WqqlO4bq8XvET9PeV6zm6V8o+w?=
 =?us-ascii?Q?qPRT2nANBNFhC9PGOu10eskP8/Ze3Kq5RvSHziCOmQx5tbv3zqKxfs7ING4p?=
 =?us-ascii?Q?AKQ7zz9fW19s8HxY3/j33/m3Ntn6/XFFaPOGhytSXpUf8Uw2Cj0uSsCv7RZb?=
 =?us-ascii?Q?d5n0Cxm2E3PWuj+R/5YgohKGync0/kb3TOHyIY2dHAyO6ZqD1saVXuOnzDj5?=
 =?us-ascii?Q?g1TTXZol9gaxrDxo14gAr9HxZw6ZYRH6T3vwvzVRnDE7pzPO1Rsr0uWt17eM?=
 =?us-ascii?Q?v7k5teFmW7YiiDb2ou98n0Mo2KU2X5/qBxW/yP4kzGY3kw2oMjwcWeWhlaS0?=
 =?us-ascii?Q?Gxj87ca1VFDSaQL/Z439uSGCEqecxThWQMh3D/G0R9uoYOznA/UDa0DGuAO8?=
 =?us-ascii?Q?MRHpONVmW624F9YyjIem9BXsD6pafrG/QwQg4LkakuEf/lPwJw4LibRrgc5Z?=
 =?us-ascii?Q?FV4RsyNhjqHIOsRKuNHLUQs8EQAoz9SYwk39Q7rCCD8/3iSUgfo5xG4hFjcH?=
 =?us-ascii?Q?Lw0O37TZOdE8j/H6C7xmQya6N9WVxTZ/b8lhlojICLJEBERqdOBiwgM8gVTV?=
 =?us-ascii?Q?PPcz8po3190O1snhRv+kYcUlB5cg6M7Nzm6ttR/pT93ELVlmnMBx2ywrRX0n?=
 =?us-ascii?Q?ReoCKf/ZvVAvo+dGJKg9Pq/lBayZHLrwhQ/uYH/S5KOys0knAjxy29is4wfT?=
 =?us-ascii?Q?g6bW63/9fei8riLgGjliZ+sL8yXomt+vohhk0Z0IWk0+L8CRFcdI43a7Ld/N?=
 =?us-ascii?Q?oIdpmSw8gyjI+lfQljlNYINjsaXG4FZYxwJVBy85W0iJD3U+dw7m4WRaV3GO?=
 =?us-ascii?Q?eSJdhqiTNL6DkG7KkkhkCdzHdkIw6awIOcb/seFkyqHMBvPaZX6LZN2e/WNb?=
 =?us-ascii?Q?a0Y6hM5k7W42fI4KCGabgyAN7jciueOOOVqeNJT8pzwJC9lgNaSh37opDJT1?=
 =?us-ascii?Q?bEuj2WptTk9bfC1IUj6zdEYe6hTLmgN3uYx+z9DJ5mdkXJ0C1R1yErofRt2M?=
 =?us-ascii?Q?rAXGVSMqEvk/EZWXF78Z2NhyHmQkuDmP5/q6Oq7q3rZJscg/4aPqgCYeQA0x?=
 =?us-ascii?Q?pnJFEl0DggN87cf3/YuwFUJPr82np0cX/desUhSJZG2PahVgMrMwgi2fHJ16?=
 =?us-ascii?Q?5e8xeCjN7kpEidyveunUSLM/09RCtpR1ev60NRYze6U8MCmIcB56?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1db914-f629-4e19-ed0b-08df31257a51
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:48:34.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZPqvn28lwOfdmQ+LnZQ1xQ+XIFqZ6M3rdYNxjfvqD2SY2vVJVWcriHqP8TaPSmEYSPB3iV4AVyvTtxz+E7uyzXQwJD5w7eMk79+kxTsSBkLOPVokHV5/lHZQZ73V88u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear All,

This patch series adds DU/DRM support for the 2 Display Units (DUs) interface
found on the Renesas RZ/G3E SoC.

RZ/G3E SoC has 2 LCD controller (LCDC0 and LCDC1), both are composed
of Frame Compression Processor (FCPVD), Video Signal Processor (VSPD),
and Display Unit (DU).

LCDC0 is connected to LVDS (single or dual channel) and DSI.
LCDC1 is connected to LVDS (single ch), DSI, and GPIO (Parallel I/F).

Kind regards,
Tommaso

v8->v9:
 - Rebased on top of next-20261022
 - PATCH 1/10: Step back to v5 -> 2 du model du0 and du1. + added refusal of
   port3 for others SoCs and adjusted order and ports description.
   v5: https://lore.kernel.org/all/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/
 - PATCH 3/10: Dropped the vsp_pipe bounds check in rzg2l_du_crtc_create() and the
   now unused num_planes field, aligning with rcar_du_crtc_create().
 - PATCH 9/10: Added newly architetture support creating an ad hoc component
   driver for RZ/G3E display subsystem that embed the 2 du instances
   into single drm device.
 - PATCH 10/10: Split du into du0 and du1 node and added newly
   display_subsystem node.
 - Improved cover letter.

v7->v8:
 - Rebased on top of next-20260827 + [1].
 - Improved cover letter.
 - Modelled using ports/port instead of port/ep.
 - PATCH 01/9: Add RZ/G3E support on top of [1] using R-Car like architecture,
   improved commit msg and commit body.
 - PATCH 08/9: Use R-Car like architecture for RZ/G3E and added
   mode_clock_min, mode_clock_max for parallel output, improved commit msg
   and commit body.

v6->v7:
 - Rebased on top of next-20260605
 - Splitted the original series into smaller chunks for easy review and easy
   merging. The original series is available here:
   http://lore.kernel.org/all/cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com/
 - PATCH 01/13: Collected LPinchart tag. Removed wrong fixes tag.
 - PATCH 02/13: Rebased on top of [1]. Use single DRM device aggregating
   both DU instances (1 DU dt node), modelling single port for each DU0,
   DU1 and multiple endpoints for outputs.
 - PATCH 12/13: Removed feature flag usage, rebased on top of T2H/N2H LCDC series [1]
   Reworked commit body as now outputs routing is based on endpoint id
   instead of port number. Fixed rzg2l_du_r9a09g047_info instead of
   rzg2l_du_r9a09g047_du_info.
   Added bump of RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.

v5->v6:
 - Rebased on top of next-20260406
 - PATCH 1: Fixed rzv2h_cpg_plldsi_smux_clk_register() removed u8 width, mask
   variables and replaced with direct use of smux.width and clk_div_mask(smux.width).
 - PATCH 9: New patch.
 - PATCH 10: Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
   explicitly disable port@2 and port@3 for existing SoCs that do not expose
   them. Reworked ports numbering + improved/fixed ports descriptions in the
   bindings documentation. Improved commit body.
 - PATCH 15: Aligned ports numbering with the bindings changes.
 - PATCH 20: Update ports numbering accordingly to the latest DT bindings.

v4->v5:
 - Rebased on top of next-20260211
 - PATCH 9: Dropped renesas,id property.
 - PATCH 10: Collected tag.
 - PATCH 14: Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK
             Added features field documentation.
 - PATCH 19: Rename du0_out_dsi0 into du0_out_dsi.
             Rename du1_out_dsi0 into du1_out_dsi.
             Drop renesas,id entry from DU nodes.
 - PATCH 20: Use DU0 -> DSI instead of DU1 -> DSI.

v3->v4:
 - Rebased on top of next-20260130
 - PATCH 1: Fixed build error: https://lore.kernel.org/oe-kbuild-all/202601311423.gWtJuxiU-lkp@intel.com/

v2->v3:
 - PATCH 1: Added missing defines for duty num/den.

v1->v2:
 - Rebased on top of next-20260129.
 - PATCH 1: Added rzv2h_cpg_plldsi_smux_{get,set}_duty_cycle clock
   operations to allow the DRM driver to query and configure the
   appropriate clock path based on the required output duty cycle.
   Updated commit message accordingly.
 - PATCH 2-5: Collected tags.
 - PATCH 6: Moved clk_ids to match enum order.
 - PATCH 7: Collected GUytterhoeven tag. Fixed "dsi_0_vclk2" position
   to match order.
 - PATCH 8: Collected GUytterhoeven tag.
 - PATCH 9: Use single compatible string instead of multiple compatible
   strings for the two DU instances, leveraging a 'renesas,id' property
   to differentiate between DU0 and DU1. Updated commit message.
 - PATCH 10: Removed oneOf from clocks property, which is not sufficient
   to differentiate between RZ/G3E, RZ/V2H(P) and RZ/G2L. Use the already
   existing vclk instead of vclk1 for RZ/G3E DSI bindings. Updated allOf.
 - PATCH 14: Instead of using clk-provider API to select the right parent
   clock, just set the correct duty cycle based on the output. Updated
   commit message accordingly.
 - PATCH 15-16: Collected tags.
 - PATCH 17: Squashed fcpvd0 and fcpvd1 patches into a single patch.
   Collected tags.
 - PATCH 18: Squashed vspd0 and vspd1 patches into a single patch.
   Collected tags.
 - PATCH 19: Reworked DU nodes to use single compatible. Use vclk instead
   of vclk1 for DSI Node and set to the right position.
 - PATCH 20: Fixed: dsi, du and adv7535 are part of the R9A09G047E57
   SMARC SoM board then add entries in the rzg3e-smarc-som.dtsi instead
   of using the r9a09g047e57-smarc-du1-adv7535.dtsi.

Tommaso Merciai (10):
  dt-bindings: display: renesas,rzg2l-du: Add support for RZ/G3E SoC
  dt-bindings: display: Document Renesas RZ/G3E display subsystem
  drm: renesas: rz-du: vsp: Keep the planes in the VSP
  drm: renesas: rz-du: Reference the DRM device by pointer
  drm: renesas: rz-du: Count all registered encoders for the possible
    clones
  drm: renesas: rz-du: Split the mode setting initialization
  drm: renesas: rz-du: Make the CRTC index relative to the DRM device
  drm: renesas: rz-du: Share the encoder of an output driven by several
    DUs
  drm: renesas: rz-du: Add RZ/G3E (R9A09G047) DU support
  arm64: dts: renesas: r9a09g047: Add DU{0,1} and display subsystem
    nodes

 .../renesas,r9a09g047-display-subsystem.yaml  |  44 ++++
 .../bindings/display/renesas,rzg2l-du.yaml    |  28 ++-
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  80 ++++++
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   6 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 108 ++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  21 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  23 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  60 +++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   3 +
 .../drm/renesas/rz-du/rzg2l_du_subsystem.c    | 231 ++++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |  23 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  |  10 +-
 15 files changed, 564 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_subsystem.c

-- 
2.54.0

