Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC43CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421D810ED0B;
	Wed, 13 May 2026 07:53:31 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Tue, 12 May 2026 16:52:38 UTC
Received: from de-smtp-delivery-119.mimecast.com
 (de-smtp-delivery-119.mimecast.com [194.104.111.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0664B10E589
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:52:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023141.outbound.protection.outlook.com
 [52.101.83.141]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-110-oV3G1j-LMF-dHkCm5h90dw-2; Tue, 12 May 2026 18:46:27 +0200
X-MC-Unique: oV3G1j-LMF-dHkCm5h90dw-2
X-Mimecast-MFC-AGG-ID: oV3G1j-LMF-dHkCm5h90dw_1778604385
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10) by DB9PR01MB7308.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:21b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:46:24 +0000
Received: from PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6]) by PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 ([fe80::5adb:b6ca:f689:1ac6%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:46:23 +0000
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
Subject: [PATCH 1/2] dt-bindings: display/bridge: lt9211: Add
 drive-strength-microamp property
Date: Tue, 12 May 2026 18:46:08 +0200
Message-ID: <20260512164609.3390700-2-bstruempfel@data-modul.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512164609.3390700-1-bstruempfel@data-modul.com>
References: <20260512164609.3390700-1-bstruempfel@data-modul.com>
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PAXPR01MB8486.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:227::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR01MB8486:EE_|DB9PR01MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f604391-3b64-4e27-f040-08deb046004f
X-LD-Processed: d72fb47f-f4be-4915-91c7-ebd53299157b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020|3023799003|22082099003|18002099003|56012099003
X-Microsoft-Antispam-Message-Info: +TrCGMWmXGcegAD0nk/6nTmBCi04qhIaIIkoatXsvIwCYogaBoyu4amCEuaM3uObwzmvixJlfZ61UgjRDkLkmlIfBlopZyDW7Q7Mavzblhihm00U8fWK7ucetEHIFUvfNpXgEA6Rw5qb8pDKF1d78Cel4hJsaN4xl1tWQUTM5WDGtV1fDaKWVcRUpA92U7qd2X6/h9ITS9Xu3hxg1phn4ymEPSu0v9VTqTH0AaDpHfoh5mNRBmr0rOQnmk4+xjYnEAHvfjEaY+OFaYMD3PVGUXHMM9My153IWa/Jbtll9Tb7enL9Xi+KwQLiweJ52zRGK8E7lWlPAlToggDfm/QWOenFbO7UhPcwZqD8VuiFPIVG4CdnhaZoLZIYA6o6/LAgRNrKN/ZxNxwHYPFG17VYcBvw8pnLZuVH0V2YlVRxC+z4KktOp4Ni5XDWOWUvz6fctTgCNNfMbOHZMTBUUid6yQx6Qc8xuaLOXdnDDJU9U7oGzdY6eIdTDWhxulRPpKx1MzvMrOilED5ArN6ZC0VFKVTQgAsSPacO6rYfOPUKG0WqoCn6Z9uRZKs5DKaBZ+EKdMmi574HFhp+HwiNXDDZ2eRzGHiuwwVDWDC7mUc312gcr0F8w0SB61yTW+5Mpqi9TL7Sm3DpGG5mMnje9Rgq5AfhJM+rgIpp4IfRkYQXlKRUc0rQwY8252l5Pnf33Q+ujlPIe+2iEjJZD9BHfc07WUu++aFDfif4ZJw5KYJWKUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR01MB8486.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DlAm42SuDS222A13HoId42uEXxVK4kzrq9kIt/8hK81vSL6dsFhtoTsxhpqj?=
 =?us-ascii?Q?pPrfxhITX4E91+HkUyqodZuwvNAfx3dqQt75BPJcKe0ZaeQLxEo8o1ZGM41y?=
 =?us-ascii?Q?hfS3Deb63gxohLqGoeZd6JnT2xytNKrIbacTeEsn6e2h84ohVaKPIITtQOW+?=
 =?us-ascii?Q?26909yFu+QeZ/8ReqdUy4au2eI4eSbgeUxYxrGfS2t+mIT/pk8sww8CMrstF?=
 =?us-ascii?Q?FAVz66fFJgVrtHNOKYnQPE5hCpOapRyYSrFV08YiICBDe9TA9T1r1ZxWk3lZ?=
 =?us-ascii?Q?HtMltJlLNmm6KwrEITvw6IPBf0OJJslibVfssrcpoyfWa8PZ2Xof5xFvceTH?=
 =?us-ascii?Q?kZA/pVWeDsoq0B1PsdB8YwzzZoSBYjatjdWbAken6kU7maZ4QSz5UzTupbI3?=
 =?us-ascii?Q?62QxYQtc3OlZm1KTyqYFiWuWFYuNbBfVnBfHKDpEN1kQIXBmMtUTaiJaQSQC?=
 =?us-ascii?Q?XELSuQiu4yKImFSCzjDeVocD1T1JnA7y1Q1JkdBU/dW48H7Rgw+Zqb6CPxRp?=
 =?us-ascii?Q?jZlQqv6jdEuOK8u3GNJe1UnhDS+djw7q+S79ZOaw0WhsZ736m/9wETUfFze+?=
 =?us-ascii?Q?YREAph0HSyDHnevnFpjC12/OIA9vd8imWOM4fGKn6w7iQFK/XM1asO3NtFd6?=
 =?us-ascii?Q?nCqZsM87XkCW5k5uxNI249b1yKGs6dqaUwiJUKjYv4Y8Ct55m92Iap0HUwCw?=
 =?us-ascii?Q?pjMbYOI/nI++rPiFfhU7sb5e/McmJhTIYeycQhMuOAm4PWxZdE3W+S4LB63/?=
 =?us-ascii?Q?WK0ARdi/qlwE27jnXdFVgptSLUg/YqzB+T3s9d8BtKMn9WeYj5aCPJquRHeH?=
 =?us-ascii?Q?aXkQN6yLzvojfwVED6+U5DexLmFh0Llvc8kuBtjq459eIqBlq/NLSnhLp3F+?=
 =?us-ascii?Q?8J57eOqCagWc6gNJ/c02vaZJP/YRj47mjAj/kXAqQAJJbq2aguX2Bn7IjTmq?=
 =?us-ascii?Q?0+brDIuEY4pcwwLAbbWyGGTHFhwwlcEIoioOctYRElDtCgohEQfIBKL7s9Iq?=
 =?us-ascii?Q?ZtoQaJUGlQAwniThTtSFeb/zZJ9YOpHYZfcSz14KomXsyaCqW3bP4cMpEVj7?=
 =?us-ascii?Q?M0Ixs8NMLgciOS5lLxUEeIHD5TmdZbiEuPHub4cVzU2A3ZsoEC2HuARABV8I?=
 =?us-ascii?Q?23QeIm1tzcBXNgOOsb2a7Nrjr9U+v7gjX4u94mZMu1X3fmtIAsmL67RsG8LC?=
 =?us-ascii?Q?82qamv0unPXUzPLp9kY0poEP5vPdiKQFayiBIb8f9mtO+FQG1A2aCbbLc6Sd?=
 =?us-ascii?Q?+yVaZRnokU29S69PCK9jdN48CxmHsSZwdmvK6xYEzeAp5A4w0yeQwIt/Zojx?=
 =?us-ascii?Q?K4bg8gs231OIws7Y1U+6OfvsAzZhMKBM6JD6LYmw5Wnxvi4heK7fLSyLPyLV?=
 =?us-ascii?Q?caGJ5a/XZI3sOez7DfvzR5385qUwgSs+/oZWWNPTPj8k3fD6KgOqv+5f0Pty?=
 =?us-ascii?Q?AgeLwOu78lz095qmDA0GMw4XgdjfhqcRwkkHwZmF1hP8WzwgzV9DwHS3J9W7?=
 =?us-ascii?Q?JTR4qJjuc5KRXWWOb5LeTOkLjxwvCe+ruv2NDfwGqFPPRz2A4r7G+8ohelPA?=
 =?us-ascii?Q?1Vrw+socBR9VAuLfTuuJrxMqRsYWVgbMNJwmXrJ+Hzu/rkhpYQ2xeNz6gopm?=
 =?us-ascii?Q?ewsjKKJfVS1HPHuLY9VdZ5eracCc4HN6GjQ4vVfHzULBtHXVtsxpWJP/tCN8?=
 =?us-ascii?Q?TOhzdcvR8Fa1rT36Jjs55/FKf7dD8Z4h5/6lom5AByRfutlLpOPbhHXlB6aG?=
 =?us-ascii?Q?yTCDuS0QIgB/DrDPjHyp6Par73IpFG2ebA5Em7jFt88YN0fr65dT4jFKtIsM?=
X-MS-Exchange-AntiSpam-MessageData-1: 4r9HIS+jaSvk2ScuC+4eqg8RkamHRDwAsUQ=
X-Exchange-RoutingPolicyChecked: giFB01hqNHVcMoztDp/Dbc9ha/h0krgVdt5hT89Fgdxbnyl6fDckcmXalJi0wazu6fMowZgAsBsPwYBS7ZjOJfJbc4sxvp+8v/z9QwwrMSffDKi3KvJBbOs3jF4Sy/CxOjV090VGWyXha7t9NPYjiAxozaaGC0HXxiT2l9CZ4kpEA/KIjCHWQJN5GhE3R0oKKiiLzT2NJpQ0VnZiZ/leKBR+mYZf7yvmf2M3y+l5jix8RV8mhmkTAwhvoBXBwvlTsDu7VUxq16WVc9db4qqytCI0naeKNxxuUzCXWemxqynrJgDJf5Yj8ZPwa7qHLZ1ddPGfuS93IEnrKmxYH8yH/Q==
X-OriginatorOrg: data-modul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f604391-3b64-4e27-f040-08deb046004f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8486.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:46:23.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d72fb47f-f4be-4915-91c7-ebd53299157b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKNOiEw6UdE5l5GGyG5saqGrTzWjN6tX9yoFtE+eAQ+ZsHFF7/ExiSktsG99EAQrUkKFxy+XSOoQI/qHme6ifrWjo0EQGV+Sh+zgf+Hblak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB7308
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rk0do6c3sK6BrKaSnI9LgAmK7RuggHKO5qsIvUsAMCk_1778604385
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

Add the 'drive-strength-microamp' property to allow board DTs to
configure the LT9211 LVDS TX output driver current. Sixteen discrete
levels are supported, ranging from 12 uA to 36 uA. Defaults to 25 uA.

Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>
---
 .../devicetree/bindings/display/bridge/lontium,lt9211.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt921=
1.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.ya=
ml
index 9a6e9b25d14a..381b69c761b8 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
@@ -31,6 +31,13 @@ properties:
   vccio-supply:
     description: Regulator for 1.8V IO power.
=20
+  drive-strength-microamp:
+    description:
+      LVDS TX output driver current. Sixteen discrete levels are supported=
,
+      corresponding to the following nominal values in microamps.
+    enum: [12, 14, 16, 17, 19, 20, 22, 23, 25, 27, 28, 30, 31, 33, 34, 36]
+    default: 25
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
=20
--=20
2.54.0

