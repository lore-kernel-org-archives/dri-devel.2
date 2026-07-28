Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA2CC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC52210E8EC;
	Tue, 28 Jul 2026 13:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="qCBhY/v9";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45C510E450
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW2PSBNuVemAjTHh5aeV3bQrkuhpniUr1DR+SDLLgDSYllYrFCYUJskkBQ/rvNtSviqyRxdGKSF+RqfGVsFWtwooPLoT/PsQxIi2BKJHWrgzkbonS6hzmVZiBNQmi16+dOunKYqkjvPGQX7Z+TzOEQFOmG9q0SY5eYWx2O9Thi81AgjpBPSs47FVHvY9cVojlbL1SWonZ/5pwIEc4P7vIl+7ryJqym684KfAsPjyFqyzFeRVslg6CNufXcSopnOso/ge2Sqwj1KbPwz96PUdH3v46BShBGL4HWZKvshdwhK/AVbwVfobVazHAwYQIUaT/WDfQfkxTLJN9oGTD3atlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO5yJDbVNfae30McC3Gh7setBxeFntJcNgYQ/0CtX+E=;
 b=O/JX7lYu9QyY9hBhdTUbE6I+iqio7pd0mAJBlTYP+nlsQ13B8G9Y877aC1LKJWWwooY1g9wB6nxRN3swsTqq0mqNtzrDhYrcoI3rur2nyufA6D0YywT7g/jjv/CK28+uOfN0vSKkjTQNxeLegp6Xy3W4m1OitTkbXT9Uh313gIyjUl6DXcQKSJpdenxW25w3V0uYI8nu4BiA2wbRU4RxXQDiISiR1KMBwxAFjib7NnMzK1yvsBRF8H0deTo2Nb95Hv7B0Q8a/rESNUDK0N04ZSlK2EV0C+9bLZuPzOeqsLWr04ifuVgh0gyAWGXznCXf2uMwNyr+j3zCUMb8A5mc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO5yJDbVNfae30McC3Gh7setBxeFntJcNgYQ/0CtX+E=;
 b=qCBhY/v9GXkDwdrugi1N6Zed3BVlVejgpkKmQEoA43OPbJphxzI4XW9I1E9xl7yPCNTXML9DrEF3iryvbWdzGzrG7Dgs1XdQS8LjrLq5ObJtcMaJqxWX1vM9/jZN1wWhYvq/VLEJJKnAaos3GaM4O5A235N74qYKyWz9rrhZFbrqr28kD0zEwNmF2AT967/paefs7is+Kowbtw5yguswW9C3z7kLuVaRpE2a7eFfSPtRyc5ZS5WC24Ro0JvX+5KmSLtsACKhH1Hhv3l2XcCMqk1nwjkd053yQe+0n1P6y+s0Iykzk1mk8Dv7eS9tErnBaeTmWor2xG6aQet05r5ZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB7993.eurprd03.prod.outlook.com (2603:10a6:20b:43c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 12:20:46 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 12:20:45 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v7 0/3] drm/bridge: ti-sn65dsi83: Add reverse lvds lanes
 support
Date: Tue, 28 Jul 2026 14:20:28 +0200
Message-ID: <20260728122032.692482-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0ddb47-0590-40b4-229d-08deeca2a641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|7416014|3023799007|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: dvHpooiGlD8YFglYHzKkOtLah/3bp6ytmz2Hrwt899IwRQtl2r7DRhVIqmgqi6xbk4mrABXtl0qJz0Qwc/6g8hV+u9WiSH6zbBSqiZGqqMDnlSRaQqrpRK2kPiqrap9r5CdN1B42wRPXZXv/xGyEC5Apz8llp6dan8jt/zQQviAm5u9728fZV0FoEM5lSPJZLaaBzHRW5UZ3t/p7NoIj0Pi+07gJWuB9fgJ7r2iCuXZEr1w6Nuqc5q4pVTuru5EQAdTDicIiO6kH65wLYYe3/krcnmTXBljklEZq2BWwiKfTKGJCPICi9MFwYrzj9Rr9LOs9wQLBtmbPfAC3lKBn+NnaHydaHe2ssofn0NdmcNMkt3q4txNDsVeKI2Ofo5CuK42oC2BuQ/dYiFzESwPMPon/mSfYVzz5kXpYUxvYyAH3nC2O+/XXK2kXK8g86aioIJtohYZ3ogovM7/7zYsp9LKJ3dnU51mZAUhre9RSXmrFWl3vknUKRexMgORuqGhXIf3ZbtEo37E7kLFySDYcRHA1RAeo2+9yO4qwnArgmHI5hleH8wpLwx9IXzctFtBoCNaDaV/Q4a/UeLXHl8z7mLTk/NRwjApvOtVXq2fWoDWB3pRoYkQTil/jvajnqJ9RIMugfKmxKE6i9JSemlUSgGbUn99njOULrhtnej9cJzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(7416014)(3023799007)(10067099003)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3A6edmiL696sXJpyx2OVNopaDGhE5H/QZ0XKzlGVGWxju+NlEJpeIvPqKPL7?=
 =?us-ascii?Q?TocGFhlAIji5BT4fd965FqE0BRB9MWKtLqevj9nVLba95qX7KzQO2rdk9Me1?=
 =?us-ascii?Q?mOjdrBFNxk8eAOKim0jxVolxc6JVUSOJXdBkLs0XlEJo9nP4nGPJoAbYeCUO?=
 =?us-ascii?Q?y7cPIznKWF0lOBuySeTPk1YUN+p02TtjuENsbD/BkgVIBJdagpffpvB5lAuC?=
 =?us-ascii?Q?F2+HolgYPA9MavxZtB7zmcvfV6UNl03wXYjjAcqMwxvmxKDUAcGAz8CEvnLd?=
 =?us-ascii?Q?ZqxtGOgEPbBGYHboqYa2rIJqUHueWXMFkfEkfplUb9NFTi4AHpYhIEsL4GMZ?=
 =?us-ascii?Q?JBkGxKsmg5FnE/2PCzg1tz/TB8DqIJoFv9hSMjYMQ2U7XgDbunUxSjSnadkl?=
 =?us-ascii?Q?BEykNqRhSQZUFKtZ+HrfW0WqQeOlcut2rRhSzWfI4k7w6o9u/cqjec2BhO6W?=
 =?us-ascii?Q?HeSnLangL9pvmVo81q0QGPZiQ/0VgkWoivk1eztToG9VmGY6ekMbdS/oH2jP?=
 =?us-ascii?Q?vxEJP5SJ09/EQYXzFWZzmGaIpoKtIbQqK0ON5IHDVGBbfiUWwQXttQ9sXA0c?=
 =?us-ascii?Q?IOoC0VklgmcdTg+QbSU5oby8vRrhpjAiOW1QnYQI/1AOakFsgGDbEKyJrCfd?=
 =?us-ascii?Q?L5yxjkWrYTIin0wEo4pbkeFohb1sYZNYn7gnQmOFTNoZfIzh3ZI2nMlk0cTx?=
 =?us-ascii?Q?sGtVKdfOlov7VD1tcNmVeeXNnfq5x17OVXI63mMSrsYVwbD4k5eGa690BIsH?=
 =?us-ascii?Q?L3MgokuALKZ0tP/vYVghaFMMyMC6CksXeuMUsKPqScA7m7diX6EhHTknSufH?=
 =?us-ascii?Q?AA7DAl/o6DsOGsMgy98o8clHkZWTJil2EkrVx1wrr9qSGgPuAcKCeqkB3I/t?=
 =?us-ascii?Q?KgmkIqh3B7px5TGmmS2A9zG43dLK0btuZu/s8LB2vwOJj/ggCKMCtODx0XXW?=
 =?us-ascii?Q?ke3S0wHlcpe4FGr6vLE3TSahmuiMXMJQkCe6GacAJygqwS0ugb7EOv1X6JVY?=
 =?us-ascii?Q?JR0Q2HY+PjylvjfVGaePLLyi0Kzpj19cjjt3O0+7KIdNLMPz31OEUrrp7xaD?=
 =?us-ascii?Q?bXoOUlGmsnT1XRiTqBkPfFj1NXpn1cIHBItpiiW9NzeesNlKoCDxbmUW2KoU?=
 =?us-ascii?Q?unV0b3C8nSH4mnlmZFoaHJLSxZC4DiZJ8T15DrRbYsx3N3V2RWHHqx9IaZ+p?=
 =?us-ascii?Q?LvxAvwTL5jf0KOu8HcPYmZp/KtmJYvR2w5bUFJcuhLDqba9CRSDGC7ME8bmF?=
 =?us-ascii?Q?hXKGxXl5JQTfcQoP8X/DCpn0Wxm/7FYOELgmqxbl905PHInW2K0UJLecd6jp?=
 =?us-ascii?Q?Fln3lJqkg5GoOjfgHXxo0DOKUqZytWsU7CYoVA6ojvD/FUJqI0uSaEI7dJlx?=
 =?us-ascii?Q?juwUl4bBiIEl5zjqWRJp5PQC7DkCp8eiOzGmiqpSg4RQbQSDvUs1LbMvkZXl?=
 =?us-ascii?Q?qejw/4zAbfIIpAKbZdhxEexykObj/sRUkgwoAkvRUcr/ecIE2q5LziFDW/G+?=
 =?us-ascii?Q?vVQ6oRJJ6KVhqFQlMKcUJt7WzTdUDiMe8q63W7dRdHl4KRu/aTHrEgnRm3JW?=
 =?us-ascii?Q?fE4dxQeNk3BOsBEJY3rQL8vlTRCRdsmPM9VPgTAlthrMzaAixOTHHqS9nT2r?=
 =?us-ascii?Q?Llf7CpTed3+i1OfV4udNCyMNTHTiKuHCY/mbvLeHoiExBLgXvibI8FSOv09j?=
 =?us-ascii?Q?pXyq7jQWeypA2e+nppzz9+GJLvU+jJVPaSEg6qJxaPlYry21VpWueT6+UYMO?=
 =?us-ascii?Q?HqpdMF9ehQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0ddb47-0590-40b4-229d-08deeca2a641
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:20:45.2888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQQn0tlMPgGdhySvgWCSD7r8mWr60NjxR7QoE+nY4lb8nGkgKUixdoZqQqPoNHEwP1Pw45XxZnURq4DWhgQQQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7993
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:00:37 +0000
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

Add support for reversed lvds output lanes. With an optional
data-lanes property one can support default layout <1 2 3 4>
or reversed layout <4 3 2 1>. The property is optional and when
not set it keeps the default output layout.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes iv v7:
- dt-bindings: Removed Reviewed-by pointed by Krzysztof
- dt-bindings: Moved data-lanes property to the lvds port scheme
  instead of specific nodes - sashiko-reviews and Rob
- dt-bindings: Simplified commit message
Changes iv v6:
- Fix wrong size in memcmp reported by shashiko-reviews
- Add missing Reviewed-by Krzysztof in dt-bindings
Changes in v5:
- Add an extra patch to simplify error handling in lvds DT parsing
  suggested by Luca
- Fix formatting and description in dt-bindings - Krzysztof
- Make naming consistent for lane mappings constants - Luca
- Simplify parsing of data-lanes - Luca
Changes in v4:
- Fix data-lanes bindings to be under endpoint subnode and not in
  the node itself, discovered by shashiko-reviews
Changes in v3:
- Add optional data-lanes bindings for output nodes
Changes in v2:
- Parse existing data-lanes property instead of ading new DT
  bindings
---
Wojciech Dubowik (3):
  drm/bridge: ti-sn65dsi83: Simplify error condition logic
  dt-bindings: display: sn65dsi83: Add output data-lanes property
  drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

 .../bindings/display/bridge/ti,sn65dsi83.yaml | 15 ++++
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 72 +++++++++++--------
 2 files changed, 58 insertions(+), 29 deletions(-)

-- 
2.47.3

