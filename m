Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E225ACD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B4010ED10;
	Wed, 13 May 2026 07:53:31 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Tue, 12 May 2026 16:52:38 UTC
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.109.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B5710E59A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:52:37 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021129.outbound.protection.outlook.com
 [52.101.65.129]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-65-ayHovwD9NVOTmRWXUqPuMA-2; Tue, 12 May 2026 18:46:26 +0200
X-MC-Unique: ayHovwD9NVOTmRWXUqPuMA-2
X-Mimecast-MFC-AGG-ID: ayHovwD9NVOTmRWXUqPuMA_1778604385
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by GV2PR01MB12751.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:46:22 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:46:21 +0000
From: Boerge Struempfel <bstruempfel@data-modul.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Boerge Struempfel <bstruempfel@data-modul.com>
Subject: [PATCH 0/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
Date: Tue, 12 May 2026 18:46:07 +0200
Message-ID: <20260512164609.3390700-1-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|GV2PR01MB12751:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eb352b-1a6a-4a5f-dc59-08deb045fee5
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|921020|18002099003|56012099003|3023799003
X-Microsoft-Antispam-Message-Info: /obf0V2hItb52+cwqmJ6AXzbWLgOG4SiduD+HTH/wXtZLfL1HBLKcXZp6grgHytuISX7OPL88mEsJrZREYggXqQx3BEepmxtnyMzKtmg6hO+q3OG1l18aLTk/eNxChn6OvdcBuZxRphl1Lr+3anmaMdzygCvJMEtzfIy91uXPw5kmV9H6mEE5UfumkLL73RVLAfKCqqWbsIRaiYJhjDvVUhtESF7t7fhskX7wYd2gt+kOq8+AfLMeUr0hFy0WTkxStNl3bEnaMumVPErTgBLf4z0RH2efiGq1dOgXnvb8ZBbMj1ylP/7Gp1J/8bSKOv015kJKM+JVwwfEJ6hDrKlf7YkSHcTV4LpFWzGGTDRY7plmav/RtknydOchkoiD6OL9q6WOGrrtdKaK2scnigTUCh/Y9ieHMphWghXXHmzB+YFXSHuXlzm5cZ4CltmxdjtKJEI2N/UJX8gja3twlQ9sE/HnbBNpVnUW+GQW0Z8U9bRmMtjHCirYwHxKWuJLUrQ8rE82ka5EmlpUppKJe/kr3zl4WF2Bwd+B4T03MkTsJQuyiQvwi/XPDgA66lNQmtwoPgU2lGK7O498/48K4jLyV/1+Z7l7ED2RhM4O5Oyztc3OxyU2G4zyY4NZIxd/RcO/UIM5kBz4JI4PuI5i0ttl1J6C0Ap0KE5tFTYDxYRubVBKjeenQmMEGu9jmuZkvh/od7x1z8Xxb44Hms3efXkQJLAED4NYcZ3wJCkKVboCYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(921020)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PxebhiE3Uz5LNTUEhclFcxcQeSlXDwatf3B43dnize5QJf0Bz3skLJQLGrOJ?=
 =?us-ascii?Q?UFPJvTSxpwV2o40c/j5XXFqkU5xDUMlgGJFQoaYHWh2pSKCExG87mLoUamwF?=
 =?us-ascii?Q?AmYPlks+AcOIkxIhNV90f/UAacpWlQxHRTE2ysLKihICN385TLtTFwdzJn3l?=
 =?us-ascii?Q?vkExPg1US62H0MGyydUtNFajBcQFQaoWO8Pp4TEcx+uuTguVDdAKv27Q9F93?=
 =?us-ascii?Q?hPL4lqPBMlEHDTSLS1w8e+5HgjOXZu3PpxGYNijDCtr+rfVV5AssVTxk7lZT?=
 =?us-ascii?Q?S2i23xjgW7afD6AriHDzRile3F7WeeGgZhMCZ0NXOqsu3JQuHm9mNwQcG44U?=
 =?us-ascii?Q?zDziequEGN/PyOEPMI2PUtnT4OjmBvqHHDrKaNnqmvJJELpJgGhACiHH3H7e?=
 =?us-ascii?Q?Pf6kdLYwjg8n8yjuD/kvWvIm7pVis9+It9BHSusG3Ln9OgvNuGR7tD/zsARl?=
 =?us-ascii?Q?ToaMp5pUCBU/ds0qEgxjUXohbYVPO3cw0jkkdXjvH2GalewrPfp7B4i3RWG5?=
 =?us-ascii?Q?uLxjON7eydyGDnAMw+ycRZrqbm3nTmKoIFH6mYBn8Fr5cI5+bTBxJEpsSx89?=
 =?us-ascii?Q?1cw8/zgDGHLtXZJ/YRo8ZVOLH+jBFcfWPcdoEojiFQh8Dj7S3Z1gs1iT8WW2?=
 =?us-ascii?Q?y3dfahSGc22YpTxRpncUQjqItoqrF8ejKfULFh0m/kO5PbtzAu4WOOLg7Mid?=
 =?us-ascii?Q?LL6JZRSvTFQ79nSZ/T5FgHNVGrkAP6nr/Azz+xw/Vy5f854w5QW4PMF7bX1G?=
 =?us-ascii?Q?kL6tKRi1063JbvgyqYrDAYa0ANtzC3Z6LO08Ezk4y3YmMzNx5FSSqpO+luW8?=
 =?us-ascii?Q?uBzE54s0COE9XeuW/CVGZnN90daRL+NM68UTuqm+LqQb2u/o6Go6qZco9Spo?=
 =?us-ascii?Q?+7PcfXa3dQ8HAdtWDM2HRJilruakFrGdsByjHAiemV80QpP2c9lOwZrIh9o0?=
 =?us-ascii?Q?OBYAFgilx9dUJY9ndHEi9DEMCflJxmScDtARmjdYf31J2uSssDSwCqdnf0Wt?=
 =?us-ascii?Q?d23k94QKXD7vnJ4WJ8Jy9DogYYTzC3Mg9cB0WUVCnHq62EwDrzkKCQeRKU2Q?=
 =?us-ascii?Q?omKWZIIbIbacHOdwbvWWn0ASVnr6OZeDzd6ZiyPqRAj8MjsamtCggblFrK31?=
 =?us-ascii?Q?5PJifBkLj2+aeX5ThvQxV0tmEEXVlRydiKhzA5GFYEcuv9tw4NhcdZqKJM3q?=
 =?us-ascii?Q?L9rC7hvfT4olEbisH0XkwG4ZGqkqv72uurQcM3Bbf+ldiCOizdmBGNwgluWJ?=
 =?us-ascii?Q?cy/4izYE5566yijo3XfgirSXnTdaPAfen6cah1+wHAIGFgjnwag562NA0LpP?=
 =?us-ascii?Q?yZz4Ust3ugaOoxawnA7dBuNfR/3CJb43gh83V6GQ/Awzo+zjc25vnmkIgghb?=
 =?us-ascii?Q?sJMwgVT2aNbiQODdNIYZvx2b2X9EvFr21g1pifGzOtAFtC+RLU49W3Z8Cg+n?=
 =?us-ascii?Q?4aDe1qQKnRtdNuGZq303+iLxUeEn9JV4YeHZ2mLESYoTc3SRwFExG3FOq/Kv?=
 =?us-ascii?Q?LXivQTFCdLSLCvgMlQk9rdBu1UgVl9UetsCPbzysGYzHaGGScfpDvGdbsQlk?=
 =?us-ascii?Q?iDKIprxDkjsdPbxzzTiCgkbmZWo2jSl1c5fbg2WnmKZSexRcD1iSg3wa6aKe?=
 =?us-ascii?Q?FOhWZptUQtn/ojnqaS5+VBMOv353bLBwvkeWAGqflSFKd56pYN6qv439pPCf?=
 =?us-ascii?Q?N8QB5f/Eb8ofR3Xt4EotBKuAnT+m+lwmgDhO0OH9Umqha360S6FYzEfHJEBl?=
 =?us-ascii?Q?+x4cK2eeV8rrkHtrfF80zJIpNYPGEEWt4ZD3VqpSeI2ODD1U2qgGe2NOgdhN?=
X-MS-Exchange-AntiSpam-MessageData-1: IdtNcgQjenCkOLYDxm5TZQ+seM0iy5UBCFU=
X-Exchange-RoutingPolicyChecked: bMoYKqO5fGaUsm/3cWDwkB5r+dzZf50DizaEvXGTDJKj0fQXNKZ9gbjE3E52LYMHJ0nRmTQbKgFezqNR+lX2ufkr0Ongf3XhP2nNxROIg3Zd45rABNsDip5useCJrcqbIDx2kT9+Bq1ZMIk3TGrFOLO0w494f9n2Rx3a5v96XXi4JSdbvf8k1fnW8rqUSXxZzcRzg8Iw8BmXl/3UTIqZKUUwdYU1FZiaLrJ2Cyc9Cf5aa1yjbAoznc5AARUs8ZSm4xUmgJSe1MtDOVShyoiIA6hf63EDE7E98/ZJhy9z/6KzRoLqFvRMB6hGKum7chYUJ3Qaj6LuOU2fVfWg5jWOvA==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eb352b-1a6a-4a5f-dc59-08deb045fee5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:46:21.1227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS6SjXOGqBbWjYGEOuarS+IM1aEJEKBOjPPlww/ct2e3FLPGgMmc31DcHTA5rZ6mO4dFA5z4q8SbU9jSipO+YvvB5yPgRB/FDGECeUx6JkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR01MB12751
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wXXwhMXaKF-yF8YPA66eK3m3WIocgYMw2lEodqpVZ_0_1778604385
X-Mimecast-Originator: data-modul.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

The LT9211 LVDS TX output driver current is currently hardcoded to
0x8 (~25 uA). Some board layouts require a different drive strength
to meet signal integrity requirements.

This series adds support for the standard 'drive-strength-microamp'
DT property, allowing board DTs to select one of sixteen discrete
current levels between 12 uA and 36 uA. The default preserves the
existing behaviour.

Boerge Struempfel (2):
  dt-bindings: display/bridge: lt9211: Add drive-strength-microamp
    property
  drm/bridge: lt9211: Add drive-strength-microamp DT property

 .../display/bridge/lontium,lt9211.yaml        |  7 +++++
 drivers/gpu/drm/bridge/lontium-lt9211.c       | 28 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

--=20
2.54.0

