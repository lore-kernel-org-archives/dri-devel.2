Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC62EC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1466B10E605;
	Tue, 21 Jul 2026 07:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="xG/KScQ3";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013070.outbound.protection.outlook.com
 [40.107.162.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D8310E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKjd4jQPb8jG4z5s6MSLhv91W+BT5/CzW3Rmp6LA+4VyVniivLkVhBFcrl/kWfYDtz+h3EPyeIOxIMsAA/O8CUzPOJ01ELbXbK0wUgMzQOPznaoJJSsfLVUtjS+RPM8H+Txh4psl4KSP+BSzyeoXe3cRRyEoZtnsQXXEzYlef8vHl9J8dmgD3T0+XrnwZJVHWl/1oZZwlPk/mjRkxQXh1dAoPr5rS7Ih4RXD4BqlzUa30g/Hl9f0i9uQbjsUhArQA+3YAS3I4KXJhSDtoDL/3SbOC3v+mk/7Y3NI3Qc2OZ/aruD64fh3pJZ2vRhWMauQIUSYMHFFMrug3kHOs8tq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP3BUPUmJJQlD4JQAh90TXULFgl5wXpP7sNL4rEilLU=;
 b=saZG130EQE/ipWqIphzwVk5Dtlzt83BpmIgZFcBqET3x26THQ/qahTjW0WWEQ99SLOHagY/9eot1RYtmUJvi3jIoUqqLzKIAOKMxzWMpSBmU/j/mDxBseFjf1FXj2TO7Kka1Ij/N2QgYlBW2EnKIoE3y3YA9EWMip9TpqJKgOEp1xrBgadvUfSp7QfB91HkZ3A+etvGTFRLjNe6ixolIZx4/mo1Szl5GpnjPKDl75WiQj3FABnaaZIbXRUOFsr6gKjA5cWACGacqC5w2bT/WS0QF+iTzv/GCq6nzjpLQKDc8IxtsvNMSV4dTh12MtSJ91RJWB0JdMM5VNOxsDrzm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP3BUPUmJJQlD4JQAh90TXULFgl5wXpP7sNL4rEilLU=;
 b=xG/KScQ3zAnUew9xd0L1SHUer0d91aH8TdSiLYkRIIo99SKkpMDyTUh7lwwPv1sYrGehgh9TekAnQnVkYCV1axSZsm84Y8A0yPcTkL/8OCtDuqkCrvCzOnhYQtXlfh1WRO1g4cSLlzFT16JMDKcpMjSWKX1BFE49ApwOBJZ69AeyZIa+2h9n/aaTvlqA/DJDxZbZqMV3FuuATy4XBBdi7+Fw6ThRD2IS6Pq8+lS3YsQ7gk8ZhwYk5FTbVqG54+fJMYGomurbvTthl43lf04tu5hHp6vYgC9PxvIiKZt2KirgW+lvEmUo9fRjemKPZWxp2O2jaIU0xoYPF/CrlKR42A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11523.eurprd03.prod.outlook.com (2603:10a6:150:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:13:11 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:13:11 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 2/3] dt-bindings: display: sn65dsi83: Add output data-lanes
 property
Date: Tue, 21 Jul 2026 09:12:49 +0200
Message-ID: <20260721071253.1098652-3-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
References: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8a0947-a0af-482e-70b1-08dee6f785bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: xkiLrql2Xy3BbFMENoVRouBXWk7SrT48uRykpISz4hCffQJZyDVh00lrMr+AoRG7BrLtYkP0QgbS76R6IEjfmp8dpC0SMuhzsdvL2G8tNVEXvQpd2Iy1saOUxN2Fd7lmHA5iX64sXpTC4vrADFn7+VIOh2eGompVEb4AYCTIe05KZm1v57MOygT/jL6uwelrlKcYP1+BlbFSP7/mtArieKTJAlDXZuEwVEsZI/M/s69s52PW6pUmaZ3i6qUtwXCzoobeZJOfO1nwDfsKoRFEwv7zO0jiVjXfsHFK05+eTLyrFazdNB5kapyMu6IFRB/qxvAS4y/RLUqX7vK6pegvuQlGJxGgV5zzyGtihFAxudwE/oTjk+j5VuEw43Wyb2HyuYBTGqbSCBCOHHPGUj4wSj25S8OsKh79WXkXGWlw3c/Z6HSRJkWDln6vCEKsXQ4BmnGYjOK48NOuxVYH9IcYyVj3x5JfxoAQX/1Mt03IJiah6UCkjTMuiQ6Jq2AydBBMBoLmlag8ItQ4Byg+vaZbF0Y8LP2p054WojEtrxHf+4zplOehOu/SHYmDUvH7R2xn0cPfH1b93k0fZintVROBDDyI9vT8EUJCADzLe3D8q9FP59c0xr/ZZFNpKLaEdHsjO8M9HE4CiA76FaMq6KhqzC37um7buVRkThWBN7ZArhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBEp3mof/cTQkRUY1RYXuNzHX0RBqNiCMUlGjlNi8FG4lELd/E5tew1MnFAD?=
 =?us-ascii?Q?spejPurP2cofY3PFneGOttK58KpyK0rcnXgri3iS7t6eRQFvHJ1+HuT6T1By?=
 =?us-ascii?Q?5N9mH6ve9hY2gYWLodbiZ1dY1sqq97bcC41fDKMivOvRUNb1uZQUfJuOJzLD?=
 =?us-ascii?Q?SIZtwpvIOVEZkuA/ZqeKkaZ+YCP/RFHmGMVlNcW41KjbHe/hzAEMD5ppeUC5?=
 =?us-ascii?Q?swYtV9QeckXZjD1OdoXFzJoqQ7DSlmSm39Hkc+aYWN6Gs9l+l0bO7JOcp+7y?=
 =?us-ascii?Q?wicz8DPg26wZ42sTQiSXzUEdAfgXKyJD+Yyqz2oVukj69dE3/t8EbwIOXfDu?=
 =?us-ascii?Q?EXWv8xNWDKiMNmk/adHxcqyn42OacYt11f8dri3N176A3/j5Y1KcOJXiYPeP?=
 =?us-ascii?Q?u0trKFXdBtxyP1exUEr8JiGwdIKjuWIglCIHa+WeR/ZR1IVGsIRtiArIE5fK?=
 =?us-ascii?Q?9ZxHofnhPnlFod8x6JFkqhi5/dr3kSrsp82BBQZHj6s2G8cyWv9mrodfRB2s?=
 =?us-ascii?Q?ddFQbySayBBm/ICzEZiXX7u8DdFpQdy/i/lpBonbuTHJsN5NryyLyaMr5+eU?=
 =?us-ascii?Q?ReTF3tL6+5I1AUUpvnSvK8g3H5EBPWA2fUFHEFZXJK+12ApxJ/nBaKwQLp8u?=
 =?us-ascii?Q?hE+Pn/+XzEKjr8J2E4rRUmYNHLpL0buloiexHPsTjJjvwl+uIk75BglakYGG?=
 =?us-ascii?Q?OihAcE+RujQElTXoKpwGNWsWsIuEnjBEBmw0+HKjNXNt2uKLHtln35us0QIs?=
 =?us-ascii?Q?pwEQllETVNXldUim2DohWY14BoCVlOWNWPJCdoeu5de4jVCK6YV2O10bObYA?=
 =?us-ascii?Q?/MwMtGAP2sHnd+CMBNHwqnDtshCaSiXPExMdvkrf4mBiupMm8YQ7LnY3S3XU?=
 =?us-ascii?Q?rd2eXQ8ON89637f0cATevbre9YdlwjSxwxvddMOcrQ5dBKbXad3fBT2x9o72?=
 =?us-ascii?Q?DeCZQCNRZOWICdvFOeze0VDmq0euYuTcDLIzYBUIv7iCHfvdyY5EkipSZKaF?=
 =?us-ascii?Q?B4fTSRT6jCjkcwhS5kNob1uACxzxYdvtArtLCE3hadKw5/eDCo7ucIKmNOKl?=
 =?us-ascii?Q?2r82Iww3wQgbulqaJ0/POFJAKpZ7VjNpqE9gv3nUC7dUfXBL6ADAspb2cKqT?=
 =?us-ascii?Q?aDB6ZjXMYnyXttHmhVkFsEZp4fW3df5crprkckidgyxG7ps4+UFHKkUQjg29?=
 =?us-ascii?Q?Wl5MUOSOa1sqeJ6KPcldKSltIecriMq1FsPPkPFakwW6/rMKD+it+Z6oUmrs?=
 =?us-ascii?Q?fRwjdVWDey4GOAQ7xamD52srJAXDh2PU+VCSlJz2E+uCXLh19YQDOJnhmaNu?=
 =?us-ascii?Q?AP27fdLzzkuZje1nhYVCH7nRvmMokaM2gMZyPFTDROf4rbtkaxqSIK/HX346?=
 =?us-ascii?Q?M6q1aZCwoh3JFkF72kGJraivsBQGc22P6XfxwmcLIcPnXVa75sNOXf9/x7G8?=
 =?us-ascii?Q?optAAWXxgJWpD1JRsFsbuzcxKpeoYFs3QlHJq0PgAVvUOHP4lQwBotMeKN14?=
 =?us-ascii?Q?RGiGbx98XHubyqTwVjLoJWwCAqxBK4/yOJtVti6AtU4ukNFkRUJStuD6YOUI?=
 =?us-ascii?Q?nmcAXvX5+GRn7jd/VvmW9CbR8mxMph0fowOKE4FWGt//xUO6pvU9R9K+iLi0?=
 =?us-ascii?Q?EYOUzzVLjN2+/tpwXYDcnFusBb9GNoNEs0Hs9IRWWdZ5IbVLaWdR/NQTi2V1?=
 =?us-ascii?Q?TN3aUCkjl9f5MHMnkdZQcrpojzoYGu5qDix/o/yS6mA0SzhDprnxy4U1fthA?=
 =?us-ascii?Q?np8gLa5fpg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8a0947-a0af-482e-70b1-08dee6f785bc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:13:10.9587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5itWXehiuA7iTSiafDU6amXONuBpt43LPekgh8d1Jintwr7xRps6WFHjwOa/ADU8P9EUR0PLZw9ju4XSOtWnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11523
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Add an optional output lvds data lanes property with two allowed values.
The array <1 2 3 4> for standard layout and <4 3 2 1> for reversed lvds
output lanes. The latter informs the driver that reverse lvds config
option has to be set in config register for the respective output channel.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index e69b6343a8eb..4000bf0b1370 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -86,10 +86,54 @@ properties:
         description: Video port for LVDS Channel-A output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description:
+                  Array of physical LVDS data lane indexes
+                oneOf:
+                  - items:
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                      - const: 4
+                  - items:
+                      - const: 4
+                      - const: 3
+                      - const: 2
+                      - const: 1
+
       port@3:
         description: Video port for LVDS Channel-B output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description:
+                  Array of physical LVDS data lane indexes
+                oneOf:
+                  - items:
+                      - const: 1
+                      - const: 2
+                      - const: 3
+                      - const: 4
+                  - items:
+                      - const: 4
+                      - const: 3
+                      - const: 2
+                      - const: 1
+
     required:
       - port@0
       - port@2
-- 
2.47.3

