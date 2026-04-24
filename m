Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2275FE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131C410F4F6;
	Fri, 24 Apr 2026 11:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U+WKs6B+";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2A710F4E2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijih/38m08Dq/7dOZuwoqx9vrZE8wOLyLXPOJBWkd5WhVJHn72h+YQ70fekPzHUWvhj/8tyiIVKhgcn1Lf1T0cUAZ8tXRCb78x5lNii3oPGrMEaHP6BmU4i35IE29a/gjmODG0pp0nr6pOEXYpz1BEgGRSvTqRVCJ7Zin0k3613J6v3YeYeFDDCiRsdT9xye6NY0/zCZ8znQJHXH3tBoPOOON3BpJB2gEnzCmZauuvVq9T1eFuNk8jVDkpMiEjuj9rKMInvXg6d1C+KKLjUqGIc3jK6iPen4RxtAXAs6NQmTkucUXu6AsSW4HlYFdZfoJOiRE19W/xfE/hTZiNxIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RofJT9ktnqv8hDEkIUbuLS6i2QXFTVV+DV9zzOqpVNo=;
 b=vBOXRUmBS6DKtBf0xmKL4z5L1kmNvBUT/+B9+BweV6puLvuPVoRemNiaNGq4l6ljXg2eNQzhl6ApATaP0l7+DsUtU+4QqydrsiR+QiWH+PNf3bZcMo6QwWrP+gb5QfnWioMCzG5DDNscKZX64nmci6VRV68d5h9MAqdSJrJ4WabI/2x48MSRF3z7urPauR4z739M8gXPypZhiPrXjMHuNPEGwPYZp8fiOJw/p161uuNEvKu1IkeLozfcaUh4RvN7uLoE0RE58cfMLdHL9KnBIczxhdeLVlXsTCbOXkSqvD/Fl48pOaHsppgZLFAIDRNRcS93IYnzZOFcD/tVW2kLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RofJT9ktnqv8hDEkIUbuLS6i2QXFTVV+DV9zzOqpVNo=;
 b=U+WKs6B+uLpv7jE0vPqERsIUJbxDi5FDrBurk+TUq/6T+HYgQJod8cWbL7OSVE4yPAVIzIUgZXvGpV1rPsP70JydkqnobaJHL1YGn993R7y+tSvWdnEXdqA4JTzAQNYsex/eiXKgvYCZ92tO5XAQ+75dSBh1W0FYbIuLeC2jDPDCnAlGUi4hn8F18OXTgRHU0usC4jDXuOcYZeEyr9olEf3NPcKDlMH9yxpCYuq+5ZGmu0jp19sNQrTa5NswvkLNt3cjq1mk26zfOyZ9QBghkixwMsNPgDUZYhcUtrxQWxGXdKNU3ga96ap+NzjKxDvU3iHk27rwucawA0WMJxU8jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:08:01 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:08:01 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Nikhil Devshatwar <nikhil.nd@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 2/8] drm: bridge: cadence: Update mhdp8546 mailbox access
 functions
Date: Fri, 24 Apr 2026 11:07:15 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-2-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::29) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 58091653-c72a-42fd-d78c-08dea1f1bf77
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: zfk6j16UXdqALzOGm3Uqj0Sp96BH1b8QyyD4o8Ct3x0AHZjxozj1GaqdDwrSnO0Q2+i52qxIPQPQI08oqX7jSELH8yYqXMp+pxbF+8SwHkA4RmT8bO1xj7yXVsrjYs0AX9zHt9LKcNOC1J/MIORWELc1W+cOIfwkFrDP+A5RUTQKkzau+MT0rQ3Jvv87WFUan6Tu/qaNuV0bbCRDJVtG/Szsz4w+SRRuryISN3lWEksAT3cXSjOux3haCRBy2UeQLbrJm5oZeQxe8H+O7gy6aYSuIQtGGWbIhCifYckZI9RT5H6idwN9Q3zjW5e1lrPrXQKl+ssqeSJtdaeXohvacCGG8U7UHlnnhmshA4h4MVJ73bFTsPn0fWV8YI4PwidVvuJ8XL3TIjpZFk+Kt7hXtCzedAKFOgvRvNtiJy3cyrMvVs/ep6mFMLyiDRhJk6q3yk2pcZh64d+16ve7GP0POR85501mgLP4gZ7NBnyaTwX8E/WPY+7ivX2jhUNn0aW89tgkLWASNkxV+4HmZf3O3xih+LdrBTIEZkyDB2AKeCvLeTA7i0TMBut5rCw/0DJAXJ8Bx77WdWz6pVrtgwDvec5NJP48xNrsyALx8K9rVx6Wyob556jbQ7msCi9QcZQfeU8vCtVcRfXOJ6iSakdLPvfNW+ynnPzNYRzeockqagIXiOylXlI7+XSw8M8e5pyinhpXVHUgPif1rcjEhC2DKVh4uPdnVmCqaufn7QBPuOREhFznVFyM7EXKAGfDQr2vQzJlDEJUm3qKi8g8Khj0Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFNQYUx0WG11cmZJbGMwMEQxd1ZWSkdwdk9Zc1ZMcXIvWVRDMTBuWnVqQlJU?=
 =?utf-8?B?Vi9iSGNiRk1VOU5QYzkxQmpqRWFIZFNJUmlHQmgyQWF4djhKNkh3alF0L3M3?=
 =?utf-8?B?R09GMDNGZU96Yk0xRjk2blZ3RTcxS2cvOVFvK2FmSGJYWGdCT0FUQkJkK09m?=
 =?utf-8?B?VnErSXRObXJrcE8zMVl0eVg5UnUyc1E3RTZOdU1ScUhvZXh2ZFRDN21ocDBV?=
 =?utf-8?B?K3RaN1FKeUZDNFY4bGJEZGh5VXhTOW1McGZBdXFwYmFHTmFHSXkyMUxwbk10?=
 =?utf-8?B?dVRrZFhwNFFBei9DK005b2NZUC93NTVWVmNIUWFEcjdQYmQrY1g0dWtjb3do?=
 =?utf-8?B?Qys0TlJwUlc3c3V6VXdIeDNzQUhickpSZmJDbG9WcmpMSElHU1RyVHlWeWti?=
 =?utf-8?B?RDNSMnU3d0taSkxMV3kwSU9lSDd4SHZHSGpRQ3lWcnZYQUZpQVY4RDJBZGpw?=
 =?utf-8?B?Nmw3NzFyeWpSY05PN3MvNmFPd2RlcGFPMWRva2xxQ1FpV0F1V1FCU3ZOMm00?=
 =?utf-8?B?bTRBSjhSZHIwOUQzVmpyME1SV1grYlVkdUJ0NEVFd1hRdGpsVmtvd1dhZ2R6?=
 =?utf-8?B?VytmNExvc3NUd1BSZ094cGxuYlJrUEMzSGZxU1JpdFFvTXk0N0RDR1ZkOG1h?=
 =?utf-8?B?ei9zOUFEOGpTcm1qWVc5ZEdCY2wwUU8vZFlFNG9uKzVVbmhQeWVJR1pVdjAv?=
 =?utf-8?B?WmVHWW5xL3Mxek5DRGl5aEptMml1VTdIVFRvMjNqSC9sUCtGS3ZDOXJXVHlp?=
 =?utf-8?B?ZTV6UkVHSkRxTDNDS3hERVY2M3BiTExuNSswQVl6TVkzWCtGZ1lMdFVFcmxZ?=
 =?utf-8?B?bWVtSkJvbjdhdEo4YTlCbGM1TVlmbzF5MTdpUUFNc3RBeDJ1bTNqZ2tQNzl0?=
 =?utf-8?B?T0ZVckF2bGx4ZGc4RDhEdmF3U0wyM2ZhUjBUK1NOZmxvZExTcFV1UThQUmhG?=
 =?utf-8?B?aTdST0lwU01DTC93N2VKcjlhUWg3bEw2UklhdmFTWWc0YnptQTlYVlIxS0R5?=
 =?utf-8?B?T212bWRzTFFEWnlHSFVjUHZFdjdZODE5elM4N3RweFZJZlA4ekM1eXFQKzhr?=
 =?utf-8?B?MlVlRXpIMTZkVVJmekxCdlNkY0RqWG1GZ0M2ZnJjdEppM1NXM0xxQWhPakZ3?=
 =?utf-8?B?S0ZMRURsTnh6V2pTTThMTkd3bUpNSDJTc0VSVHBwT2gvQzI1R3diS0tkSkNh?=
 =?utf-8?B?Yk4rM2hhRDhVVmxFcFVpRTlmRjFDSU5JRXArd0EvRkNYVW1zS3hIMFFlSmtw?=
 =?utf-8?B?ZWZ1WmFQTlFqODhkREtrQjM2YlBoZU1OcXBWMU9xZ21QWWE3a3hpTFlkZnNQ?=
 =?utf-8?B?UmhXbk9pM1UyeWNPREFtejFMZWZNM21tZW9WZ1kzd2JPMnRVMkx5azdaR2Uw?=
 =?utf-8?B?bERseEIvb0VjYXpvT25nNzMvVFZCbTh0Vk9Ldk9maUt6N0cyR3ZNN0RhbEIw?=
 =?utf-8?B?R094cXNZMmN6OW5VMjJoZ0ZuZE1ma0ZuSmhKMjlZS3JsQnJoNEhGZXVVcjJj?=
 =?utf-8?B?NDdvQ0o1azc0RXpBL2s5RDVQU2FyVGdDa1hxdlRXRmVZSm4rY1djM3JXZVl0?=
 =?utf-8?B?S3diQ0s4WnlyY3NsU3dzYmJBWDdTeTY5TWZCVmcvUFUwUmpGRUZVYk9TNVV0?=
 =?utf-8?B?UjYyZlRrRkJEL2g2QnE3Q0dOdlBDS1VMcTJzMmhMZzAzcDZCV3BOSE9VS1JW?=
 =?utf-8?B?YXdZS3d2clpzMkNIR2taSzRZQndyWVlEaGdILzNwYWV6NDBNQUJrY3ZTejQ1?=
 =?utf-8?B?US9JMkxhVktncUdER3o0V0tmYUVEUlF0UVhpTGJKTisyQW54VEw4RW5Vb1FN?=
 =?utf-8?B?WE51S3B6MWdGcFFwZmVBYnZQVGhCSno5cHpkZUFwbk12SDYyMG1uYVp6VlFD?=
 =?utf-8?B?b0hHVEhHcFFGOTNCUVpNdEJpek9LQUNVRXlpcHhzUnRQY0g2SG9VbjF1Y3lK?=
 =?utf-8?B?aEpCZjk0NjRSTTBzcTZieWVwWEJIVVZvbjdlQllvKzBEL1RKVDNtUy9WcWxo?=
 =?utf-8?B?QVc2K25iOXRpajF2S0pTVFJ1OXdydHcyTllZcE1CV0dtQVAvOW8ySmgyQWQ3?=
 =?utf-8?B?Q2Eya2NNWU44SFpNbEFzM1BvZTNBYlZDby83bi9SRHd1bmZhTG4wMHBHQ25O?=
 =?utf-8?B?QUYzaTVrOFdCRFVuZ3RObW5OK2lib1lNOTFLWXRVT1FJcmpIRUlOM0tCbk5h?=
 =?utf-8?B?SXRmWlNnYnR2eVNiWUZKV0tsZFhHb3FpaHVEV21JYWVRT2lSc0RFYXpwbGtW?=
 =?utf-8?B?MXJRNGhEK2FaRzdoVHJpS1pkNGowSHE5eEpaMFAvaTNjU3g3bWNiNGhJL3JU?=
 =?utf-8?B?ZjAwTWtuVjJEa2pjRHprVVNKSXNQZmMyR3JVTDVFWFB4SDNxekpPR1pPdWxk?=
 =?utf-8?Q?I5BRs/r6sv/ubmP4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58091653-c72a-42fd-d78c-08dea1f1bf77
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:08:01.0860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCdo4QSxxX5Yaq9cm6iebXqInzLXSL+gKWm6vQYXmzrBsfnEyN5GmAnMmWaOBL3R6NiPWrKumHYxKsOU0A4Qew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279
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

From: Sandor Yu <Sandor.yu@nxp.com>

Basic mailbox access functions are removed, they are replaced by
mailbox helper functions:
- cdns_mhdp_mailbox_send()
- cdns_mhdp_mailbox_send_recv()
- cdns_mhdp_mailbox_send_recv_multi()
- cdns_mhdp_secure_mailbox_send()
- cdns_mhdp_secure_mailbox_send_recv()
- cdns_mhdp_secure_mailbox_send_recv_multi()

All MHDP commands that need to be passed through the mailbox
have been rewritten using these new helper functions.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Co-developed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

---
To: Parshuram Thombare <pthombar@cadence.com>
To: Swapnil Jakhade <sjakhade@cadence.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Nikhil Devshatwar <nikhil.nd@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/cadence/Kconfig             |   1 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    | 489 ++++-----------------
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.h    |  47 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    | 212 +--------
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h    |  18 +-
 5 files changed, 106 insertions(+), 661 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index f1d8a8a151d84..2ff261e18bf1c 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -29,6 +29,7 @@ config DRM_CDNS_MHDP8546
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
+	select CDNS_MHDP_HELPER
 	depends on OF
 	help
 	  Support Cadence DPI to DP bridge. This is an internal
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 064c6915c8960..435c006ab0c34 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -73,302 +73,18 @@ static void cdns_mhdp_bridge_hpd_disable(struct drm_bridge *bridge)
 	       mhdp->regs + CDNS_APB_INT_MASK);
 }
 
-static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
-{
-	int ret, empty;
-
-	WARN_ON(!mutex_is_locked(&mhdp->mbox_mutex));
-
-	ret = readx_poll_timeout(readl, mhdp->regs + CDNS_MAILBOX_EMPTY,
-				 empty, !empty, MAILBOX_RETRY_US,
-				 MAILBOX_TIMEOUT_US);
-	if (ret < 0)
-		return ret;
-
-	return readl(mhdp->regs + CDNS_MAILBOX_RX_DATA) & 0xff;
-}
-
-static int cdns_mhdp_mailbox_write(struct cdns_mhdp_device *mhdp, u8 val)
-{
-	int ret, full;
-
-	WARN_ON(!mutex_is_locked(&mhdp->mbox_mutex));
-
-	ret = readx_poll_timeout(readl, mhdp->regs + CDNS_MAILBOX_FULL,
-				 full, !full, MAILBOX_RETRY_US,
-				 MAILBOX_TIMEOUT_US);
-	if (ret < 0)
-		return ret;
-
-	writel(val, mhdp->regs + CDNS_MAILBOX_TX_DATA);
-
-	return 0;
-}
-
-static int cdns_mhdp_mailbox_recv_header(struct cdns_mhdp_device *mhdp,
-					 u8 module_id, u8 opcode,
-					 u16 req_size)
-{
-	u32 mbox_size, i;
-	u8 header[4];
-	int ret;
-
-	/* read the header of the message */
-	for (i = 0; i < sizeof(header); i++) {
-		ret = cdns_mhdp_mailbox_read(mhdp);
-		if (ret < 0)
-			return ret;
-
-		header[i] = ret;
-	}
-
-	mbox_size = get_unaligned_be16(header + 2);
-
-	if (opcode != header[0] || module_id != header[1] ||
-	    req_size != mbox_size) {
-		/*
-		 * If the message in mailbox is not what we want, we need to
-		 * clear the mailbox by reading its contents.
-		 */
-		for (i = 0; i < mbox_size; i++)
-			if (cdns_mhdp_mailbox_read(mhdp) < 0)
-				break;
-
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int cdns_mhdp_mailbox_recv_data(struct cdns_mhdp_device *mhdp,
-				       u8 *buff, u16 buff_size)
-{
-	u32 i;
-	int ret;
-
-	for (i = 0; i < buff_size; i++) {
-		ret = cdns_mhdp_mailbox_read(mhdp);
-		if (ret < 0)
-			return ret;
-
-		buff[i] = ret;
-	}
-
-	return 0;
-}
-
-static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
-				  u8 opcode, u16 size, u8 *message)
-{
-	u8 header[4];
-	int ret, i;
-
-	header[0] = opcode;
-	header[1] = module_id;
-	put_unaligned_be16(size, header + 2);
-
-	for (i = 0; i < sizeof(header); i++) {
-		ret = cdns_mhdp_mailbox_write(mhdp, header[i]);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < size; i++) {
-		ret = cdns_mhdp_mailbox_write(mhdp, message[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static
-int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value)
-{
-	u8 msg[4], resp[8];
-	int ret;
-
-	put_unaligned_be32(addr, msg);
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_GENERAL,
-				     GENERAL_REGISTER_READ,
-				     sizeof(msg), msg);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_GENERAL,
-					    GENERAL_REGISTER_READ,
-					    sizeof(resp));
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, resp, sizeof(resp));
-	if (ret)
-		goto out;
-
-	/* Returned address value should be the same as requested */
-	if (memcmp(msg, resp, sizeof(msg))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	*value = get_unaligned_be32(resp + 4);
-
-out:
-	mutex_unlock(&mhdp->mbox_mutex);
-	if (ret) {
-		dev_err(mhdp->dev, "Failed to read register\n");
-		*value = 0;
-	}
-
-	return ret;
-}
-
-static
-int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
-{
-	u8 msg[6];
-	int ret;
-
-	put_unaligned_be16(addr, msg);
-	put_unaligned_be32(val, msg + 2);
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_WRITE_REGISTER, sizeof(msg), msg);
-
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
-}
-
-static
-int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
-			    u8 start_bit, u8 bits_no, u32 val)
-{
-	u8 field[8];
-	int ret;
-
-	put_unaligned_be16(addr, field);
-	field[2] = start_bit;
-	field[3] = bits_no;
-	put_unaligned_be32(val, field + 4);
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_WRITE_FIELD, sizeof(field), field);
-
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
-}
-
-static
-int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
-			u32 addr, u8 *data, u16 len)
-{
-	u8 msg[5], reg[5];
-	int ret;
-
-	put_unaligned_be16(len, msg);
-	put_unaligned_be24(addr, msg + 2);
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_READ_DPCD, sizeof(msg), msg);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-					    DPTX_READ_DPCD,
-					    sizeof(reg) + len);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, reg, sizeof(reg));
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, data, len);
-
-out:
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
-}
-
-static
-int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
-{
-	u8 msg[6], reg[5];
-	int ret;
-
-	put_unaligned_be16(1, msg);
-	put_unaligned_be24(addr, msg + 2);
-	msg[5] = value;
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_WRITE_DPCD, sizeof(msg), msg);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-					    DPTX_WRITE_DPCD, sizeof(reg));
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, reg, sizeof(reg));
-	if (ret)
-		goto out;
-
-	if (addr != get_unaligned_be24(reg + 2))
-		ret = -EINVAL;
-
-out:
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	if (ret)
-		dev_err(mhdp->dev, "dpcd write failed: %d\n", ret);
-	return ret;
-}
-
 static
 int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
-	u8 msg[5];
-	int ret, i;
-
-	msg[0] = GENERAL_MAIN_CONTROL;
-	msg[1] = MB_MODULE_ID_GENERAL;
-	msg[2] = 0;
-	msg[3] = 1;
-	msg[4] = enable ? FW_ACTIVE : FW_STANDBY;
-
-	mutex_lock(&mhdp->mbox_mutex);
-
-	for (i = 0; i < sizeof(msg); i++) {
-		ret = cdns_mhdp_mailbox_write(mhdp, msg[i]);
-		if (ret)
-			goto out;
-	}
-
-	/* read the firmware state */
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, msg, sizeof(msg));
-	if (ret)
-		goto out;
-
-	ret = 0;
+	u8 status;
+	int ret;
 
-out:
-	mutex_unlock(&mhdp->mbox_mutex);
+	status = enable ? FW_ACTIVE : FW_STANDBY;
 
+	ret = cdns_mhdp_mailbox_send_recv(&mhdp->base, MB_MODULE_ID_GENERAL,
+					  GENERAL_MAIN_CONTROL,
+					  sizeof(status), &status,
+					  sizeof(status), &status);
 	if (ret < 0)
 		dev_err(mhdp->dev, "set firmware active failed\n");
 	return ret;
@@ -380,34 +96,18 @@ int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 	u8 status;
 	int ret;
 
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_HPD_STATE, 0, NULL);
-	if (ret)
-		goto err_get_hpd;
-
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-					    DPTX_HPD_STATE,
-					    sizeof(status));
-	if (ret)
-		goto err_get_hpd;
+	ret = cdns_mhdp_mailbox_send_recv(&mhdp->base, MB_MODULE_ID_DP_TX,
+					  DPTX_HPD_STATE,
+					  0, NULL,
+					  sizeof(status), &status);
 
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, &status, sizeof(status));
 	if (ret)
-		goto err_get_hpd;
-
-	mutex_unlock(&mhdp->mbox_mutex);
+		return ret;
 
 	dev_dbg(mhdp->dev, "%s: HPD %splugged\n", __func__,
 		status ? "" : "un");
 
 	return status;
-
-err_get_hpd:
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
 }
 
 static
@@ -418,28 +118,17 @@ int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 	u8 msg[2], reg[2], i;
 	int ret;
 
-	mutex_lock(&mhdp->mbox_mutex);
-
 	for (i = 0; i < 4; i++) {
 		msg[0] = block / 2;
 		msg[1] = block % 2;
 
-		ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-					     DPTX_GET_EDID, sizeof(msg), msg);
-		if (ret)
-			continue;
-
-		ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-						    DPTX_GET_EDID,
-						    sizeof(reg) + length);
-		if (ret)
-			continue;
-
-		ret = cdns_mhdp_mailbox_recv_data(mhdp, reg, sizeof(reg));
-		if (ret)
-			continue;
-
-		ret = cdns_mhdp_mailbox_recv_data(mhdp, edid, length);
+		ret = cdns_mhdp_mailbox_send_recv_multi(&mhdp->base,
+							MB_MODULE_ID_DP_TX,
+							DPTX_GET_EDID,
+							sizeof(msg), msg,
+							DPTX_GET_EDID,
+							sizeof(reg), reg,
+							length, edid);
 		if (ret)
 			continue;
 
@@ -447,8 +136,6 @@ int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			break;
 	}
 
-	mutex_unlock(&mhdp->mbox_mutex);
-
 	if (ret)
 		dev_err(mhdp->dev, "get block[%d] edid failed: %d\n",
 			block, ret);
@@ -462,21 +149,9 @@ int cdns_mhdp_read_hpd_event(struct cdns_mhdp_device *mhdp)
 	u8 event = 0;
 	int ret;
 
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_READ_EVENT, 0, NULL);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-					    DPTX_READ_EVENT, sizeof(event));
-	if (ret < 0)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, &event, sizeof(event));
-out:
-	mutex_unlock(&mhdp->mbox_mutex);
+	ret = cdns_mhdp_mailbox_send_recv(&mhdp->base, MB_MODULE_ID_DP_TX,
+					  DPTX_READ_EVENT,
+					  0, NULL, sizeof(event), &event);
 
 	if (ret < 0)
 		return ret;
@@ -510,35 +185,23 @@ int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, unsigned int nlanes,
 	put_unaligned_be16(udelay, payload + 1);
 	memcpy(payload + 3, lanes_data, nlanes);
 
-	mutex_lock(&mhdp->mbox_mutex);
-
-	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
-				     DPTX_ADJUST_LT,
-				     sizeof(payload), payload);
-	if (ret)
-		goto out;
-
 	/* Yes, read the DPCD read command response */
-	ret = cdns_mhdp_mailbox_recv_header(mhdp, MB_MODULE_ID_DP_TX,
-					    DPTX_READ_DPCD,
-					    sizeof(hdr) + DP_LINK_STATUS_SIZE);
-	if (ret)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, hdr, sizeof(hdr));
+	ret = cdns_mhdp_mailbox_send_recv_multi(&mhdp->base,
+						MB_MODULE_ID_DP_TX,
+						DPTX_ADJUST_LT,
+						sizeof(payload), payload,
+						DPTX_READ_DPCD,
+						sizeof(hdr), hdr,
+						DP_LINK_STATUS_SIZE,
+						link_status);
 	if (ret)
 		goto out;
 
 	addr = get_unaligned_be24(hdr + 2);
 	if (addr != DP_LANE0_1_STATUS)
-		goto out;
-
-	ret = cdns_mhdp_mailbox_recv_data(mhdp, link_status,
-					  DP_LINK_STATUS_SIZE);
+		ret = -EINVAL;
 
 out:
-	mutex_unlock(&mhdp->mbox_mutex);
-
 	if (ret)
 		dev_err(mhdp->dev, "Failed to adjust Link Training.\n");
 
@@ -773,7 +436,7 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 		unsigned int i;
 
 		for (i = 0; i < msg->size; ++i) {
-			ret = cdns_mhdp_dpcd_write(mhdp,
+			ret = cdns_mhdp_dpcd_write(&mhdp->base,
 						   msg->address + i, buf[i]);
 			if (!ret)
 				continue;
@@ -785,7 +448,7 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 			return ret;
 		}
 	} else {
-		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
+		ret = cdns_mhdp_dpcd_read(&mhdp->base, msg->address,
 					  msg->buffer, msg->size);
 		if (ret) {
 			dev_dbg(mhdp->dev,
@@ -813,12 +476,12 @@ static int cdns_mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
 	if (!mhdp->host.scrambler)
 		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_PHY_CONFIG, reg32);
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_ENHNCD,
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_ENHNCD,
 			    mhdp->sink.enhanced & mhdp->host.enhanced);
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_LANE_EN,
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_LANE_EN,
 			    CDNS_DP_LANE_EN_LANES(mhdp->link.num_lanes));
 
 	cdns_mhdp_link_configure(&mhdp->aux, &mhdp->link);
@@ -839,7 +502,7 @@ static int cdns_mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
 		return ret;
 	}
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG,
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_PHY_CONFIG,
 			    CDNS_PHY_COMMON_CONFIG |
 			    CDNS_PHY_TRAINING_EN |
 			    CDNS_PHY_TRAINING_TYPE(1) |
@@ -984,7 +647,7 @@ static bool cdns_mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
 		CDNS_PHY_TRAINING_TYPE(eq_tps);
 	if (eq_tps != 4)
 		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_PHY_CONFIG, reg32);
 
 	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
 			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
@@ -1248,7 +911,7 @@ static int cdns_mhdp_link_training(struct cdns_mhdp_device *mhdp,
 			   mhdp->host.scrambler ? 0 :
 			   DP_LINK_SCRAMBLING_DISABLE);
 
-	ret = cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &reg32);
+	ret = cdns_mhdp_reg_read(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, &reg32);
 	if (ret < 0) {
 		dev_err(mhdp->dev,
 			"Failed to read CDNS_DP_FRAMER_GLOBAL_CONFIG %d\n",
@@ -1259,13 +922,13 @@ static int cdns_mhdp_link_training(struct cdns_mhdp_device *mhdp,
 	reg32 |= CDNS_DP_NUM_LANES(mhdp->link.num_lanes);
 	reg32 |= CDNS_DP_WR_FAILING_EDGE_VSYNC;
 	reg32 |= CDNS_DP_FRAMER_EN;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, reg32);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, reg32);
 
 	/* Reset PHY config */
 	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
 	if (!mhdp->host.scrambler)
 		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_PHY_CONFIG, reg32);
 
 	return 0;
 err:
@@ -1273,7 +936,7 @@ static int cdns_mhdp_link_training(struct cdns_mhdp_device *mhdp,
 	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
 	if (!mhdp->host.scrambler)
 		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_PHY_CONFIG, reg32);
 
 	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
 			   DP_TRAINING_PATTERN_DISABLE);
@@ -1387,7 +1050,7 @@ static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
 	mhdp->link.num_lanes = cdns_mhdp_max_num_lanes(mhdp);
 
 	/* Disable framer for link training */
-	err = cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+	err = cdns_mhdp_reg_read(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
 	if (err < 0) {
 		dev_err(mhdp->dev,
 			"Failed to read CDNS_DP_FRAMER_GLOBAL_CONFIG %d\n",
@@ -1396,7 +1059,7 @@ static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
 	}
 
 	resp &= ~CDNS_DP_FRAMER_EN;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, resp);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, resp);
 
 	/* Spread AMP if required, enable 8b/10b coding */
 	amp[0] = cdns_mhdp_get_ssc_supported(mhdp) ? DP_SPREAD_AMP_0_5 : 0;
@@ -1605,7 +1268,7 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_BND_HSYNC2VSYNC(stream_id),
 			    bnd_hsync2vsync);
 
 	hsync2vsync_pol_ctrl = 0;
@@ -1613,10 +1276,10 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 		hsync2vsync_pol_ctrl |= CDNS_H2V_HSYNC_POL_ACTIVE_LOW;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		hsync2vsync_pol_ctrl |= CDNS_H2V_VSYNC_POL_ACTIVE_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_HSYNC2VSYNC_POL_CTRL(stream_id),
 			    hsync2vsync_pol_ctrl);
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR(stream_id), pxl_repr);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_PXL_REPR(stream_id), pxl_repr);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
@@ -1624,19 +1287,19 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP(stream_id), dp_framer_sp);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_SP(stream_id), dp_framer_sp);
 
 	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
 	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRONT_BACK_PORCH(stream_id),
 			    CDNS_DP_FRONT_PORCH(front_porch) |
 			    CDNS_DP_BACK_PORCH(back_porch));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_BYTE_COUNT(stream_id),
 			    mode->crtc_hdisplay * bpp / 8);
 
 	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_MSA_HORIZONTAL_0(stream_id),
 			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
 			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
 
@@ -1645,11 +1308,11 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 			   CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_MSA_HORIZONTAL_1(stream_id),
 			    msa_horizontal_1);
 
 	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_MSA_VERTICAL_0(stream_id),
 			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
 			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
 
@@ -1658,7 +1321,7 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 			 CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_MSA_VERTICAL_1(stream_id),
 			    msa_vertical_1);
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
@@ -1670,14 +1333,14 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 	if (pxlfmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
 		misc1 = CDNS_DP_TEST_VSC_SDP;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_MSA_MISC(stream_id),
 			    misc0 | (misc1 << 8));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_HORIZONTAL(stream_id),
 			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
 			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0(stream_id),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_VERTICAL_0(stream_id),
 			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
 			    CDNS_DP_V0_VSTART(msa_v0));
 
@@ -1686,13 +1349,13 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 	    mode->crtc_vtotal % 2 == 0)
 		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1(stream_id), dp_vertical_1);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_VERTICAL_1(stream_id), dp_vertical_1);
 
-	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID(stream_id), 2, 1,
-				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
-				CDNS_DP_VB_ID_INTERLACED : 0);
+	cdns_mhdp_dp_reg_write_bit(&mhdp->base, CDNS_DP_VB_ID(stream_id), 2, 1,
+				   (mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				   CDNS_DP_VB_ID_INTERLACED : 0);
 
-	ret = cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &framer);
+	ret = cdns_mhdp_reg_read(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, &framer);
 	if (ret < 0) {
 		dev_err(mhdp->dev,
 			"Failed to read CDNS_DP_FRAMER_GLOBAL_CONFIG %d\n",
@@ -1701,7 +1364,7 @@ static void cdns_mhdp_configure_video(struct cdns_mhdp_device *mhdp,
 	}
 	framer |= CDNS_DP_FRAMER_EN;
 	framer &= ~CDNS_DP_NO_VIDEO_MODE;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, framer);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, framer);
 }
 
 static void cdns_mhdp_sst_enable(struct cdns_mhdp_device *mhdp,
@@ -1734,15 +1397,15 @@ static void cdns_mhdp_sst_enable(struct cdns_mhdp_device *mhdp,
 
 	mhdp->stream_id = 0;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_TU,
 			    CDNS_DP_FRAMER_TU_VS(vs) |
 			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
 			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH(0),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_LINE_THRESH(0),
 			    line_thresh & GENMASK(5, 0));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG_2(0),
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_STREAM_CONFIG_2(0),
 			    CDNS_DP_SC2_TU_VS_DIFF((tu_size - vs > 3) ?
 						   0 : tu_size - vs));
 
@@ -1784,13 +1447,13 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 		mhdp->info->ops->enable(mhdp);
 
 	/* Enable VIF clock for stream 0 */
-	ret = cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
+	ret = cdns_mhdp_reg_read(&mhdp->base, CDNS_DPTX_CAR, &resp);
 	if (ret < 0) {
 		dev_err(mhdp->dev, "Failed to read CDNS_DPTX_CAR %d\n", ret);
 		goto out;
 	}
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_CAR,
 			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
 
 	if (mhdp->hdcp_supported &&
@@ -1854,16 +1517,16 @@ static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
 		cdns_mhdp_hdcp_disable(mhdp);
 
 	mhdp->bridge_enabled = false;
-	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+	cdns_mhdp_reg_read(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
 	resp &= ~CDNS_DP_FRAMER_EN;
 	resp |= CDNS_DP_NO_VIDEO_MODE;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, resp);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DP_FRAMER_GLOBAL_CONFIG, resp);
 
 	cdns_mhdp_link_down(mhdp);
 
 	/* Disable VIF clock for stream 0 */
-	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
-	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
+	cdns_mhdp_reg_read(&mhdp->base, CDNS_DPTX_CAR, &resp);
+	cdns_mhdp_reg_write(&mhdp->base, CDNS_DPTX_CAR,
 			    resp & ~(CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN));
 
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->disable)
@@ -2280,7 +1943,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	mhdp->clk = clk;
 	mhdp->dev = dev;
-	mutex_init(&mhdp->mbox_mutex);
 	mutex_init(&mhdp->link_mutex);
 	spin_lock_init(&mhdp->start_lock);
 
@@ -2311,6 +1973,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mhdp);
 
+	/* init base struct for access mailbox  */
+	mhdp->base.dev = mhdp->dev;
+	mhdp->base.regs = mhdp->regs;
+	mhdp->base.sapb_regs = mhdp->sapb_regs;
+	mutex_init(&mhdp->base.mailbox_mutex);
+
 	mhdp->info = of_device_get_match_data(dev);
 
 	pm_runtime_enable(dev);
@@ -2435,6 +2103,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 
 	cancel_work_sync(&mhdp->modeset_retry_work);
 	flush_work(&mhdp->hpd_work);
+	mutex_destroy(&mhdp->base.mailbox_mutex);
 	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
 }
 
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b0d22c3..ae7b85e56e986 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -18,6 +18,7 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_connector.h>
+#include <soc/cadence/cdns-mhdp-helper.h>
 
 struct clk;
 struct device;
@@ -27,10 +28,6 @@ struct phy;
 #define CDNS_APB_CTRL				0x00000
 #define CDNS_CPU_STALL				BIT(3)
 
-#define CDNS_MAILBOX_FULL			0x00008
-#define CDNS_MAILBOX_EMPTY			0x0000c
-#define CDNS_MAILBOX_TX_DATA			0x00010
-#define CDNS_MAILBOX_RX_DATA			0x00014
 #define CDNS_KEEP_ALIVE				0x00018
 #define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
 
@@ -198,45 +195,10 @@ struct phy;
 #define CDNS_DP_BYTE_COUNT(s)			(CDNS_DPTX_STREAM(s) + 0x7c)
 #define CDNS_DP_BYTE_COUNT_BYTES_IN_CHUNK_SHIFT	16
 
-/* mailbox */
-#define MAILBOX_RETRY_US			1000
-#define MAILBOX_TIMEOUT_US			2000000
-
-#define MB_OPCODE_ID				0
-#define MB_MODULE_ID				1
-#define MB_SIZE_MSB_ID				2
-#define MB_SIZE_LSB_ID				3
-#define MB_DATA_ID				4
-
-#define MB_MODULE_ID_DP_TX			0x01
-#define MB_MODULE_ID_HDCP_TX			0x07
-#define MB_MODULE_ID_HDCP_RX			0x08
-#define MB_MODULE_ID_HDCP_GENERAL		0x09
-#define MB_MODULE_ID_GENERAL			0x0a
-
-/* firmware and opcodes */
+/* firmware */
 #define FW_NAME					"cadence/mhdp8546.bin"
 #define CDNS_MHDP_IMEM				0x10000
 
-#define GENERAL_MAIN_CONTROL			0x01
-#define GENERAL_TEST_ECHO			0x02
-#define GENERAL_BUS_SETTINGS			0x03
-#define GENERAL_TEST_ACCESS			0x04
-#define GENERAL_REGISTER_READ			0x07
-
-#define DPTX_SET_POWER_MNG			0x00
-#define DPTX_GET_EDID				0x02
-#define DPTX_READ_DPCD				0x03
-#define DPTX_WRITE_DPCD				0x04
-#define DPTX_ENABLE_EVENT			0x05
-#define DPTX_WRITE_REGISTER			0x06
-#define DPTX_READ_REGISTER			0x07
-#define DPTX_WRITE_FIELD			0x08
-#define DPTX_READ_EVENT				0x0a
-#define DPTX_GET_LAST_AUX_STAUS			0x0e
-#define DPTX_HPD_STATE				0x11
-#define DPTX_ADJUST_LT				0x12
-
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
 
@@ -352,6 +314,8 @@ struct cdns_mhdp_hdcp {
 };
 
 struct cdns_mhdp_device {
+	struct cdns_mhdp_base base;
+
 	void __iomem *regs;
 	void __iomem *sapb_regs;
 	void __iomem *j721e_regs;
@@ -362,9 +326,6 @@ struct cdns_mhdp_device {
 
 	const struct cdns_mhdp_platform_info *info;
 
-	/* This is to protect mailbox communications with the firmware */
-	struct mutex mbox_mutex;
-
 	/*
 	 * "link_mutex" protects the access to all the link parameters
 	 * including the link training process. Link training will be
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
index 5cd0b873e16f9..1b5c90af63dee 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
@@ -15,144 +15,20 @@
 
 #include "cdns-mhdp8546-hdcp.h"
 
-static int cdns_mhdp_secure_mailbox_read(struct cdns_mhdp_device *mhdp)
-{
-	int ret, empty;
-
-	WARN_ON(!mutex_is_locked(&mhdp->mbox_mutex));
-
-	ret = readx_poll_timeout(readl, mhdp->sapb_regs + CDNS_MAILBOX_EMPTY,
-				 empty, !empty, MAILBOX_RETRY_US,
-				 MAILBOX_TIMEOUT_US);
-	if (ret < 0)
-		return ret;
-
-	return readl(mhdp->sapb_regs + CDNS_MAILBOX_RX_DATA) & 0xff;
-}
-
-static int cdns_mhdp_secure_mailbox_write(struct cdns_mhdp_device *mhdp,
-					  u8 val)
-{
-	int ret, full;
-
-	WARN_ON(!mutex_is_locked(&mhdp->mbox_mutex));
-
-	ret = readx_poll_timeout(readl, mhdp->sapb_regs + CDNS_MAILBOX_FULL,
-				 full, !full, MAILBOX_RETRY_US,
-				 MAILBOX_TIMEOUT_US);
-	if (ret < 0)
-		return ret;
-
-	writel(val, mhdp->sapb_regs + CDNS_MAILBOX_TX_DATA);
-
-	return 0;
-}
-
-static int cdns_mhdp_secure_mailbox_recv_header(struct cdns_mhdp_device *mhdp,
-						u8 module_id,
-						u8 opcode,
-						u16 req_size)
-{
-	u32 mbox_size, i;
-	u8 header[4];
-	int ret;
-
-	/* read the header of the message */
-	for (i = 0; i < sizeof(header); i++) {
-		ret = cdns_mhdp_secure_mailbox_read(mhdp);
-		if (ret < 0)
-			return ret;
-
-		header[i] = ret;
-	}
-
-	mbox_size = get_unaligned_be16(header + 2);
-
-	if (opcode != header[0] || module_id != header[1] ||
-	    (opcode != HDCP_TRAN_IS_REC_ID_VALID && req_size != mbox_size)) {
-		for (i = 0; i < mbox_size; i++)
-			if (cdns_mhdp_secure_mailbox_read(mhdp) < 0)
-				break;
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int cdns_mhdp_secure_mailbox_recv_data(struct cdns_mhdp_device *mhdp,
-					      u8 *buff, u16 buff_size)
-{
-	int ret;
-	u32 i;
-
-	for (i = 0; i < buff_size; i++) {
-		ret = cdns_mhdp_secure_mailbox_read(mhdp);
-		if (ret < 0)
-			return ret;
-
-		buff[i] = ret;
-	}
-
-	return 0;
-}
-
-static int cdns_mhdp_secure_mailbox_send(struct cdns_mhdp_device *mhdp,
-					 u8 module_id,
-					 u8 opcode,
-					 u16 size,
-					 u8 *message)
-{
-	u8 header[4];
-	int ret;
-	u32 i;
-
-	header[0] = opcode;
-	header[1] = module_id;
-	put_unaligned_be16(size, header + 2);
-
-	for (i = 0; i < sizeof(header); i++) {
-		ret = cdns_mhdp_secure_mailbox_write(mhdp, header[i]);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < size; i++) {
-		ret = cdns_mhdp_secure_mailbox_write(mhdp, message[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int cdns_mhdp_hdcp_get_status(struct cdns_mhdp_device *mhdp,
 				     u16 *hdcp_port_status)
 {
 	u8 hdcp_status[HDCP_STATUS_SIZE];
 	int ret;
 
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP_TRAN_STATUS_CHANGE, 0, NULL);
-	if (ret)
-		goto err_get_hdcp_status;
-
-	ret = cdns_mhdp_secure_mailbox_recv_header(mhdp, MB_MODULE_ID_HDCP_TX,
-						   HDCP_TRAN_STATUS_CHANGE,
-						   sizeof(hdcp_status));
-	if (ret)
-		goto err_get_hdcp_status;
-
-	ret = cdns_mhdp_secure_mailbox_recv_data(mhdp, hdcp_status,
-						 sizeof(hdcp_status));
+	ret = cdns_mhdp_secure_mailbox_send_recv(&mhdp->base, MB_MODULE_ID_HDCP_TX,
+						 HDCP_TRAN_STATUS_CHANGE, 0, NULL,
+						 sizeof(hdcp_status), hdcp_status);
 	if (ret)
-		goto err_get_hdcp_status;
+		return ret;
 
 	*hdcp_port_status = ((u16)(hdcp_status[0] << 8) | hdcp_status[1]);
 
-err_get_hdcp_status:
-	mutex_unlock(&mhdp->mbox_mutex);
-
 	return ret;
 }
 
@@ -170,98 +46,52 @@ static u8 cdns_mhdp_hdcp_handle_status(struct cdns_mhdp_device *mhdp,
 static int cdns_mhdp_hdcp_rx_id_valid_response(struct cdns_mhdp_device *mhdp,
 					       u8 valid)
 {
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
+	return cdns_mhdp_secure_mailbox_send(&mhdp->base, MB_MODULE_ID_HDCP_TX,
 					    HDCP_TRAN_RESPOND_RECEIVER_ID_VALID,
 					    1, &valid);
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
 }
 
 static int cdns_mhdp_hdcp_rx_id_valid(struct cdns_mhdp_device *mhdp,
 				      u8 *recv_num, u8 *hdcp_rx_id)
 {
 	u8 rec_id_hdr[2];
-	u8 status;
 	int ret;
 
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP_TRAN_IS_REC_ID_VALID, 0, NULL);
-	if (ret)
-		goto err_rx_id_valid;
-
-	ret = cdns_mhdp_secure_mailbox_recv_header(mhdp, MB_MODULE_ID_HDCP_TX,
-						   HDCP_TRAN_IS_REC_ID_VALID,
-						   sizeof(status));
-	if (ret)
-		goto err_rx_id_valid;
-
-	ret = cdns_mhdp_secure_mailbox_recv_data(mhdp, rec_id_hdr, 2);
+	ret = cdns_mhdp_secure_mailbox_send_recv_multi(&mhdp->base,
+						       MB_MODULE_ID_HDCP_TX,
+						       HDCP_TRAN_IS_REC_ID_VALID,
+						       0, NULL,
+						       HDCP_TRAN_IS_REC_ID_VALID,
+						       sizeof(rec_id_hdr), rec_id_hdr,
+						       0, hdcp_rx_id);
 	if (ret)
-		goto err_rx_id_valid;
+		return ret;
 
 	*recv_num = rec_id_hdr[0];
 
-	ret = cdns_mhdp_secure_mailbox_recv_data(mhdp, hdcp_rx_id, 5 * *recv_num);
-
-err_rx_id_valid:
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int cdns_mhdp_hdcp_km_stored_resp(struct cdns_mhdp_device *mhdp,
 					 u32 size, u8 *km)
 {
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP2X_TX_RESPOND_KM, size, km);
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
+	return cdns_mhdp_secure_mailbox_send(&mhdp->base, MB_MODULE_ID_HDCP_TX,
+					     HDCP2X_TX_RESPOND_KM, size, km);
 }
 
 static int cdns_mhdp_hdcp_tx_is_km_stored(struct cdns_mhdp_device *mhdp,
 					  u8 *resp, u32 size)
 {
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP2X_TX_IS_KM_STORED, 0, NULL);
-	if (ret)
-		goto err_is_km_stored;
-
-	ret = cdns_mhdp_secure_mailbox_recv_header(mhdp, MB_MODULE_ID_HDCP_TX,
-						   HDCP2X_TX_IS_KM_STORED,
-						   size);
-	if (ret)
-		goto err_is_km_stored;
-
-	ret = cdns_mhdp_secure_mailbox_recv_data(mhdp, resp, size);
-err_is_km_stored:
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
+	return cdns_mhdp_secure_mailbox_send_recv(&mhdp->base, MB_MODULE_ID_HDCP_TX,
+						 HDCP2X_TX_IS_KM_STORED,
+						 0, NULL, size, resp);
 }
 
 static int cdns_mhdp_hdcp_tx_config(struct cdns_mhdp_device *mhdp,
 				    u8 hdcp_cfg)
 {
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP_TRAN_CONFIGURATION, 1, &hdcp_cfg);
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
+	return cdns_mhdp_secure_mailbox_send(&mhdp->base, MB_MODULE_ID_HDCP_TX,
+					     HDCP_TRAN_CONFIGURATION, 1, &hdcp_cfg);
 }
 
 static int cdns_mhdp_hdcp_set_config(struct cdns_mhdp_device *mhdp,
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
index 3b6ec9c3a8d8b..1e68530e72229 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
@@ -9,6 +9,7 @@
 #ifndef CDNS_MHDP8546_HDCP_H
 #define CDNS_MHDP8546_HDCP_H
 
+#include <soc/cadence/cdns-mhdp-helper.h>
 #include "cdns-mhdp8546-core.h"
 
 #define HDCP_MAX_RECEIVERS 32
@@ -32,23 +33,6 @@ enum {
 	HDCP_SET_SEED,
 };
 
-enum {
-	HDCP_TRAN_CONFIGURATION,
-	HDCP2X_TX_SET_PUBLIC_KEY_PARAMS,
-	HDCP2X_TX_SET_DEBUG_RANDOM_NUMBERS,
-	HDCP2X_TX_RESPOND_KM,
-	HDCP1_TX_SEND_KEYS,
-	HDCP1_TX_SEND_RANDOM_AN,
-	HDCP_TRAN_STATUS_CHANGE,
-	HDCP2X_TX_IS_KM_STORED,
-	HDCP2X_TX_STORE_KM,
-	HDCP_TRAN_IS_REC_ID_VALID,
-	HDCP_TRAN_RESPOND_RECEIVER_ID_VALID,
-	HDCP_TRAN_TEST_KEYS,
-	HDCP2X_TX_SET_KM_KEY_PARAMS,
-	HDCP_NUM_OF_SUPPORTED_MESSAGES
-};
-
 enum {
 	HDCP_CONTENT_TYPE_0,
 	HDCP_CONTENT_TYPE_1,

-- 
2.51.0
