Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CB8C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E738510E48A;
	Tue, 18 Aug 2026 02:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="QpPKRIKJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5808D10E48A
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3FbvWcKseBCMGdI4VFKKVqli4OCZn3BEQBUwYN7IgfypMF5J/8BYVHN7VtYNecbDuKmZ/TL9n6OvJxJExWlbf4kxW2rjWkW05xCRxaeiLXRo0fLk9UqOhPDHb2Eg/teoXiDwNqz5ZHuP0e6Dwq7Z7RlOvT3awOhWG4SiyZ5Va1eSXRyHyejV0AYf8Qc6ofMc2QOVLhi/wsbtnA+TwZ1k336fkJ++5JTTO708Bb9SQzcdJLe2dCwEFYHakPm3V3kyKXknLbUrMsFiNAutcKLpC9zV6OA7jgzjpPU5ErF3lfsUWgIKKYKtSnCgIonyyKdmaWnC+DKwicWgZJu9Ox1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqMEb1vq4G1X2XxySZsdHTWxQcigz3QWTJ0L03Z1yW0=;
 b=jD25GXoZgxQCrITwoBG1RGQAJ/fpZuV3t39/i6DBHXHoJaerKT3GyEm2wLQB7kiKBwO4SGiBWpjrzt/nQ7e94rdup1eYcEzIUoE7vCs6LGazFnM3nOMKFsoK7AWyeHTHwOXFwY0gs2pCCNZdRaeba4euBkSDxxkRmz66KOHoTNTnz6Upg3ztuwumgPg/jArKdHWYR4yjCgxHR51aRfBZTt5+6p1LUI8tmiiu/Thw9w9KRbXKx/KaBBJxoDlTLxYZbxVtcb5qMPs4pNj3SwGOHzbSUVZis7LaWn8+/+Lc9BQj+2Qgn+cYOKpOgamIe7AEZeHETRBMag9ZY/INbdqGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqMEb1vq4G1X2XxySZsdHTWxQcigz3QWTJ0L03Z1yW0=;
 b=QpPKRIKJVq0ArK1at2X7JAlKsPST+f319OA/1GjrEtb+9gcsixi3WGUaP2XBAcmqZTTXVJ0doMZt4mDnSHhZvwjGZBla+huVdKuoaDAbtZQDoUr7tPgfBLTRNaHAjD9qQ2zLhjw0kqidta9Kdct+LrPsPLMU5E00ghe79mRijXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by MN6PR04MB9681.namprd04.prod.outlook.com (2603:10b6:208:4f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 02:06:26 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:06:26 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc: r.mereu@arduino.cc, bliang@analogixsemi.com, jhuang@analogixsemi.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
Date: Tue, 18 Aug 2026 10:05:57 +0800
Message-Id: <20260818020559.961335-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::17) To DM6PR04MB6970.namprd04.prod.outlook.com
 (2603:10b6:5:244::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR04MB6970:EE_|MN6PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 642ce1d8-6462-4c89-0a57-08defccd4f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|23010399003|366016|1800799024|376014|921020|38350700014|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: xNSy7SUFt2q5GV28QS8s/qk6py9I4cYNbYUjdI2mKr4jyBAEunjmbKxw7aYkCZL8qBA6Lj1EdhfY/YQEYRGuW0QnxWbNC4r+agtc5pfEF35VJ2EdMBmgKh4FtpbjfNntVKCUBYLfEY2KxrO+1qkmLKXp/kA9Frzob5x8uLi1dEsD5QZOE1WO4DhK5rongkJTzfDoZfNCaSyPNUkoITt6cvMxhQNrO0bHIxK3g+pZnfqWOldwFeJnjrAgrpq51Yn6BsmZWkTGJPNjT/Y/yIXF9ChQwZFUnLByJljf1hCga867qV8YVpOQ51vCmOrtr99tSaXligMHk7hQ8ZF8PeUG33+LEvkt+P2EwqIQDRfLD8rJ/f4IAxjS1wnvZ4Tylw2vNHfEwVINDbfRTcmFvlBrz0scU4eILuD8C7kjg3dLa2DlXA3m+uUQ52QEJABy8s6/W4ScvMV1oX3BnJJ0Lq+6p+yjI6qHFOph/W0ir1m6Lui/1cEabOWzSfisaEAqHZijo9ZOpJJNkFOiWWMj7k1OnCBKGWXJm5OntmOz0fgaNskEeSCL8xbnWphjKY6S8zLvnln2joY26+3APojXFeNCkNgoYtgQW23X11McsaQYjnRQVVVDLg+QA6w+AuYHXJSVdDg5KbWplkhsSq8IkO2un6vkvCMOIN2S7D2owUEAWxLUshG//Y/1fO7k4+k+Secp2KZXjlk3aHSRb+1sHLkJviLOLm1oeNJDiwtUEIFUG+UQXJLJgP3nd7Fu2AzheGC2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(23010399003)(366016)(1800799024)(376014)(921020)(38350700014)(10067099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTRoQMtBru+X0O8vUCdhdzYJfSSdlaYWwlHipw9t2JBKBXt0dV80s1699RhI?=
 =?us-ascii?Q?tXigls1DZtuXGV5Xhx8mCz01xGs708Dv9hDP5K+cZlJcIvrLa4V0IXghvk/E?=
 =?us-ascii?Q?/seclCU/KsrolFotfI7ohziqlvizq0ULoJmJ44QJNLTQUPE0cb5pcN3RH5vy?=
 =?us-ascii?Q?KOOx049lM+7k15GiMp2DNPIXdE9c/dXYKk3COqLeqXFg+jko+Cih6ay8QJvO?=
 =?us-ascii?Q?nY+/UJDDBrraJDXEJ10bLCSKqLc44ffcsnNKtb6OGslnZJ+BqTPR1RkECVvs?=
 =?us-ascii?Q?zzwjiH+xfMlI6eulipxc/8U89CXoKusDLIzKn9w8SffOFC3fefSjfad5C40l?=
 =?us-ascii?Q?5GdYxrllfhEESVjGMZ7Eg+RKiv72mp/FDlX+SLYGPNq9ysiPTW9B86xJ9HsJ?=
 =?us-ascii?Q?eLTZ37ZwXMpTlsy4gNKS3FW+vO3CqnpUASgvx1Y4fpuoR8JNv2uSpMeapPOd?=
 =?us-ascii?Q?z54RX8U9flZpqzFkUlNX+mMVgC1KMpJ/XoxxKXL7EN0aOPHbrfUjEHoHoyah?=
 =?us-ascii?Q?H7ykGKSFM0Pb+m6qLkw908HB3XxVoihQ5STHOh+//b0mvJmA34OFPW0WQjBG?=
 =?us-ascii?Q?+OAxqDWRsz0DlSCNqYLDfcq+1+uXoTuJ/yy8jAqBY6iQuNIBLsTEdxa8DUbR?=
 =?us-ascii?Q?TDrWA7ZsSSmuW6fIQpp03WDNX7GYQvBVZb7L0dV6uAU/ODp+ahLDp5QcTvJ1?=
 =?us-ascii?Q?qEHS44WvZmLmpBYgxgeo0RMYDPDbAJQtRtze0FUgwry9+El1mt+StB7ZkRcK?=
 =?us-ascii?Q?dbL17an3TbvWLEF9k02NSzu8XSKOiGA4nzKNjaUEQuOWiPKAqLfpek/Wk+iW?=
 =?us-ascii?Q?QSqKZX6m/u/gDzKS1BDwW9zzau6G51qWvHUf27eDLnRfxjAlS+OzCYnV4qgh?=
 =?us-ascii?Q?86R8D41jiXDOkADZ5sIwYluY2WTItWwD45dzXKNWz9Kvb4HMg08KGUw2X/ZN?=
 =?us-ascii?Q?eFoh7y4UxNNDhfwqSnHm/B72KDcDBMIkpfo4x7HUSU7iyDeH0g7lZmDDIu1m?=
 =?us-ascii?Q?U6ZhULf358ApRpTYKupAnDfEnTW03/GD6vkuWb/nTONMHCWXyUoud28CPekJ?=
 =?us-ascii?Q?ejmbymQwWOpPdJvgEPcI9QfAYwqyk/apU6NdVWJa4VXGIvYcC23r8JEKfQ4F?=
 =?us-ascii?Q?nRvw2AlpZhu6BwNrBdFadsY0GwgvdCteb8F2z9nf1kBjDaRk9iwFQQ5zfMNC?=
 =?us-ascii?Q?3WRhJPPPfZFB0+443zxEiKNfERWafpPiVbF9eRDFBC1KUW3T+Kk9OfDc9DKj?=
 =?us-ascii?Q?xagjGV460ASFCx5fs4bX6iaZ3uZa1kQEZI/vdQ/gBR2yq40XNUndRC8CtBgg?=
 =?us-ascii?Q?0ulBwhtO1zPj8EU56xskuNJRG4rAWyFEd4UAX3HjcWf6mWZuB2kV3UKTSa79?=
 =?us-ascii?Q?gEtyP+NWFwmpYnt8NCuvTzx1lzaodxX7V3tKZ5l/HbtZxAtDNFrO3Dh8WeGT?=
 =?us-ascii?Q?mYQUi7EjqNH//+RXNGHkn26iqCUIy3KBWv9AEOgkU0bFHqSX4WTxpYi29amT?=
 =?us-ascii?Q?59ERHMX0j1SbAKryh+uQHBsyzeo5F2IOotiOSNBi9kAsF4aVLeTGbBLEYZ8K?=
 =?us-ascii?Q?6mbvrC5gFFoAENBIQTN6UNDhEvYUIq3k9o1YCcciOUvAfTr06F9F+iSSt+qj?=
 =?us-ascii?Q?BQW9iNBYkdzniMj5zFOZFr1yAHG4MREIEUz4lJ16VJwbU04jukNlip6P2fE4?=
 =?us-ascii?Q?fZr5iy+ZgDKsFAY3UXg2KlGwENsZaTQdU8Ymwe5LmILX8A/wZ0qrwrmdW29Z?=
 =?us-ascii?Q?svAjnk8jaQ=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642ce1d8-6462-4c89-0a57-08defccd4f48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 02:06:26.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FXyJUcgx41+HQTVqQpSWCJoJ6O90WpwwgBN5WiE1bLCQZ7Wx73tfWe8dZYxsk5q5RlFVoc5rccQ1/ThQ+v8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9681
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

Add property "analogix,audio-right-justify-enable" to control
anx7625 to enable right justify.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../devicetree/bindings/display/bridge/analogix,anx7625.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 6ad466952c02..f1b08c6b4877 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -82,6 +82,10 @@ properties:
     type: boolean
     description: let the driver enable audio HDMI codec function or not.
 
+  analogix,audio-right-justify-enable:
+    type: boolean
+    description: enable audio data stream right justify.
+
   aux-bus:
     $ref: /schemas/display/dp-aux-bus.yaml#
 
-- 
2.25.1

