Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6534FCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F16810F070;
	Wed, 13 May 2026 20:57:03 +0000 (UTC)
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.111.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A3A10E31A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:31:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021087.outbound.protection.outlook.com
 [40.107.130.87]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-102-o4Ut1Br-MIebuMesb4qCRQ-2; Wed, 13 May 2026 15:31:38 +0200
X-MC-Unique: o4Ut1Br-MIebuMesb4qCRQ-2
X-Mimecast-MFC-AGG-ID: o4Ut1Br-MIebuMesb4qCRQ_1778679097
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by AS8PR01MB8074.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:375::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:31:32 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:31:31 +0000
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
Subject: [PATCH v2 0/2] drm/bridge: lt9211: Add drive-strength-microamp DT
 property
Date: Wed, 13 May 2026 15:31:25 +0200
Message-ID: <20260513133127.376458-1-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|AS8PR01MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f834fe4-4d69-47a8-697c-08deb0f3f1fa
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|921020|3023799003|56012099003
X-Microsoft-Antispam-Message-Info: jB9YivCCmrZS4wQp00fkIXsyvCfn3pHd0jrDJvakgWNyHebjgBvoOuoHFA/ErZHYYa6ffFUxS4wlE9Mlid7XcJ+fYdtLFGTBciNmx9W26xvZ6TyPLfFHwffoKV6FxkGn9Eyu5Li0vmWlJOuVr0YQjctevSk3UEGbBEA0aowasol6ZsZ+RLU5wps4uBrOtQpHPbH/2+dQUmqAjU0Yn2hQkFepQp7DhJB01od1OOuT0FmwEUYEDo2z/fH7tXn5CH57YmOeJDmrfP352W3Blfzk5Zo8Cpa2vg7XAWlkDeZzMUYEJPAJsXRwLgvsBO50BCQgw8/MS4Z230CZTNtOw+U+3U7A+2oiPJxt1m+cx8LFueQsFQsBRXFPKgLj8e3SVBOeSBFjzeXmQZrec/dtmHE6NfnQ0t1XYIHFTbbXjpOIHRjq0RxeMnngO71Ch65GDUCXn8hFTuS9vE3x+NAgN7DnI5o45oi7dS9GAVhXKyFg8cKblHqVYEA2BLDAS9KNlxX6tIPhC9LjUsUqPWUW4dTC1fGdFBgr2jCcU507ugO0vzOlbtapLke8iOnrUmY0DXlwZzyvhUtcxVbDXa5yUAFQ4lLUGQK99vxtT3GHtRlpL5RjUxFObcxABCYKU0vdBzA0KRY+W7qRMT4fYyWMQ1cPPp9ppp/pgNgASuMM8KsQCB8RRVspoDzAEZukYHD80MW4FcaWGPkg7unnTcXjzkYi0WXLqiT0yHHb/hfefq+/KluiVikr7nbyxGuroo3S7+KB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(921020)(3023799003)(56012099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RW3q4oS8dSfTuWJgKDrX5zalh4GNGsXSXSG6R8h8zA0nk1RzVPGr1PjLI8k/?=
 =?us-ascii?Q?ORLdu00qXFGOvjwKRYZxZ7DVF9iqg+hBLX8SX7WF5swWXvA57Ebb0XV2dkWH?=
 =?us-ascii?Q?1bxjrLOnoWuP7c3XPmtcUAWI1qevfTzBRBh1PPPzRgkSTXn80CFIDENQkCK4?=
 =?us-ascii?Q?A7rIPGsxFpMGhbpcxoYumfkHK24FJRC8wONg0zTX4EPKTek4W8JR/L+BnMp/?=
 =?us-ascii?Q?8yg4rLUh1A/F+aHuP1CDQHh77qIX5epuwmP84k6QQwPH8ihWLpp6aTeQMTAR?=
 =?us-ascii?Q?LLDfjYNScRdXeyQAt3/K4hH1jFB9zRCsRnCHk1uI4/57q5PrAO00Yx0r8oFZ?=
 =?us-ascii?Q?SL9QzaYFkUG4tPiBqIouChPwkeDB+2KSKtXdttOTVm5xEok/VIcJ2ecL1Glf?=
 =?us-ascii?Q?n3pw6EIrgkS+ZZkigV8xshFLs6eOnCAzhet5WHdhr2SOu65MI228I4ac8XUj?=
 =?us-ascii?Q?4dsCvSrSrOMOpHqgJI0Q7wni9xZoU47L6RqbNo7/ggaBM4fxpKp+vShb55VL?=
 =?us-ascii?Q?MZTZbvAffpw7ty8Zezo5RntI/XgOz56a6F13BIzZDIsCjcqsB7I/ykaDcx29?=
 =?us-ascii?Q?/7Ugtked3Xim0Coa5Wq9IN5Qc9C7Y1h5ioq+biz5UkuYUcl6jKJdjPAYAKCx?=
 =?us-ascii?Q?hl3Z+4/05h1KfNGp6x6lACPg+Jks/cBQljNg+yM2Q6/5wK+dGdwr/4ChRm7N?=
 =?us-ascii?Q?8MyYgqrpZWd6P1w4YIPWm9Ogy82M1wtOwC+tfptZUL00F4bylt2TyT2xrAjH?=
 =?us-ascii?Q?5e7ClwaSYiOxdv4CGOwepZd5Xm7VdV0P6YQ7jPKVX4ior1tvOREVywznCvnz?=
 =?us-ascii?Q?O+pSB60kdc9Fnxj3JR1GvRR1ikrr9qFlXP140RMn8icDjm+ayQZzqFKvQPRS?=
 =?us-ascii?Q?Qlu4j8ED+pc1IYQx0RGkF+DQRLULxKNeKad9iFdgW/6NkGcUTXutCvDofrWk?=
 =?us-ascii?Q?/faP+0tyMJAgbk8czGMNopRj/cZPhWwGKwkvMz6fvW38YOz9xTprXAA0J5W+?=
 =?us-ascii?Q?/ECbI4GOb9aIbsguCH95igwxq3FP9DH4UvhSdhfO9pePTfpuN2RJ0O+y8sBS?=
 =?us-ascii?Q?XHYFb/qvpet3eQChhiZUsiwDA0UdhvtAbYj8rPPYZGIlpEKuR9blJD7WjSuH?=
 =?us-ascii?Q?UDaMB79NQ8ZZLlP0nwj0RrSRE9m43Iw58IaqSf2v9ss4sets/N1YvRogPqR1?=
 =?us-ascii?Q?FVa0EZBpz3pYP+FsobvfzUvqFUvjY2bnIECGBFuGdQ/KKBk/MOoK01Dstt4U?=
 =?us-ascii?Q?5gdvRMomHgsYzSJ6XjtPybS8Q2MEbB2rpbV2kbuLQBBS6O8bE4+H1zZpgVmv?=
 =?us-ascii?Q?Gj3JpfAiMAWJGmAXkhiHO4jmdlNG9n3Kb8oYw61/ts+0ybjrv2Hji5BBoOmq?=
 =?us-ascii?Q?7tk7pyqFtqsvXVmD4889/Cus3TFUXS7+L01RDVX+1WYm1qOD50f0q48x6KvG?=
 =?us-ascii?Q?IwPh8xh4OKcqLe7PrVAq3DyQk8y0b5DW0oVx7nA/Y6fL5dq8G5XiUe5Ospa6?=
 =?us-ascii?Q?JGaelSoueji7CaQ/H2lbLpGMFLR1d+VYktltJgt5rJPaaCj5cKusKq4DJLOP?=
 =?us-ascii?Q?G5BX9L8wS7t7D0VifgrCX6EPPGotGcIUMClK8U2NhnIg3meyuZRY+ldtfG0P?=
 =?us-ascii?Q?1QNXqjHpLDLa5qwSM6FrgMHexsYGawybqfjaGHkMcO7z+zkPX8t7K516soNq?=
 =?us-ascii?Q?G0l3uaQV9b2ICIRYdGZKhrNErmokK76Vw/2z8ruD0W+tVRKx58d81zvk9bKn?=
 =?us-ascii?Q?zCLNenZJjKxceqjEI+ur1vtO/25MRF0=3D?=
X-Exchange-RoutingPolicyChecked: BoGSY+LDTpSx49rHYFC6OoPxHKROmEn70ayNengqiFKkYZM5oWnxkkeFeXTq/oSecxTZvXQnIcEXuYRfQ86oPByRDaQsVjviNFPRR9hE3lrgri2XQR+cMx6lurXmEl76/ecHyFTzKIgPUGrsW63gtxq8urRLl48JMjmCWqksQ9XTZ+1HjirSQU/V52Q448pES29laG8EMOtZ6tCNe6wSo23qBzVbvAKhAA6wMZmoSCTt3W7q72is7erzkzuLOs+0zmFGvlemYqj4MvBmG61Q15m7O50rtBKn7in65sW/lF5dhrSvc4RnIEWalwcvnuOdUm9y/KrsQ4HeTXjzF7yItg==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f834fe4-4d69-47a8-697c-08deb0f3f1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:31:31.7620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0pU1bBWxcIof1eziHjhWzKB64ay4h+rXd8xWX43TqnBwgHSjGy7S29960MjoLlqUoQoj1lgWUfdG1/7F09xYVAWzU7ClyssrQKDoNj4wgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8074
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HfDKpG5wcQctKXbMZhHkxuhaIGwd9jKxztj-UqnoOjs_1778679097
X-Mimecast-Originator: data-modul.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

Changes in v2:
- Use u8 instead of u32 for the lookup table array (values fit in u8)
- Warn when drive-strength-microamp exists in DT but is malformed

Link to v1: https://lore.kernel.org/dri-devel/20260512164609.3390700-1-bstr=
uempfel@data-modul.com/

Boerge Struempfel (2):
  dt-bindings: display/bridge: lt9211: Add drive-strength-microamp
    property
  drm/bridge: lt9211: Add drive-strength-microamp DT property

 .../display/bridge/lontium,lt9211.yaml        |  7 +++++
 drivers/gpu/drm/bridge/lontium-lt9211.c       | 31 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

--=20
2.54.0

