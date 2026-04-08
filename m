Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5885F1073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB20910E609;
	Wed,  8 Apr 2026 10:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AZ3i6c4v";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1213410E609
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvH8D62Pblzt7wbMqt5YXmauxtjE+44kEDfQJrO5Pwvwaofdgj24gsKITbTtycyziu1QtmuWsc6+8T5RHSMa9I8WJhRqwER6xuvuBkxYa4twl6hZZwuWf/hdZRS9A8h3MYDfdRnfaGNz7W/qDsZB9AeZyV4Uh86fDLTbkCkMCgSN1IiqXbhJFbHRK7Hc6JbtT7YFNGKX9MpA/EUWGBMwGW2eGjiIMMYP3P4093xf6/9RzDYOT3zaRtHKKhOO2vIE0t8x7dA/OmC4osTAqXTcTP6YXZrp6XswIKNJn4AxYgxMidZkRl+CLr5CBgEXqihnw3gS5xtX6iUXYk4Dy+28Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpAG8NQRQjv7LxpTxGsRAcZ1jOTI5S1iN9x2eKApzLU=;
 b=By5eCU07UTGV+oN8dondtla/UDeftVSNYqB2h25CYFm/Z9iB+54rJ3S84SNn4+sMwTES1FJa3a2GhLFG6KtIUSBP0wglJMWihUgekBXnOAyGXoe7687ngFmVkTZFV2I8oe8xxlAS8uavIQ4sxv7I8PHqbElHGzG7etu93m5teqomcPDW9xPt6YUFRGYMuzux/JygEhJ0nOISOJ3SNJpflgI0lR5bQ+hfNdy4BPEY44kgx3D1jdzK9WrLSgGIPMMvX5PGvz1N0DqWBmRedvv5szI+K5QWOI8qjdz461XftIDCivCj/0NfzZ5+Ytba4/Hsgl6Xh0PUxoRXDiTWxejM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpAG8NQRQjv7LxpTxGsRAcZ1jOTI5S1iN9x2eKApzLU=;
 b=AZ3i6c4vGSUgsNrw7I86s38SB+z6hrV9KhXQ2tejT0OjyZWD8pG4++mx9HmU26QBF12WiW62MFAVKGOQVNt8rP/OpSL56fPLdBqgRKpSdtWRqfy4Wy6WcMy/zWStMjgBsUUal+CkmLK0qDqt7Fv7Cuxz6UJb4YXbjaf97V0Io+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYVPR01MB11293.jpnprd01.prod.outlook.com (2603:1096:400:367::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 10:39:58 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:39:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 16/21] media: dt-bindings: media: renesas,
 vsp1: Document RZ/G3E
Date: Wed,  8 Apr 2026 12:37:01 +0200
Message-ID: <c1e2eb36af01e0cddd8050ba70847c3a0821c91e.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYVPR01MB11293:EE_
X-MS-Office365-Filtering-Correlation-Id: 470394ba-af6c-415e-3fbd-08de955b2e21
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AUbAu91Ozc7cPBBjMzHjEpq6+O+2nepXe3HXnZMVTinnBgcMOW+ezPp/rYYekRhgB5toSVnbFIphH+BqIXDzUvfAuwVzHj7VpVSQ/nzBO4y8O13CjrTdn7mbCYTcXYiIKtZDI72lK1NuhWHCBWdXXBymeY1ZwwFc7qz8aapV+GSBLwcZr/c08+12lslqhm6tZbfBIx3SKrePseTTK/JJw0EOh5oLoxJ5e9tdQZeoPRvv7xlLHPWR+y0Wghrgwiq9H2ew1bejvzyElrG6Hd3yGk2WjK2CWm0h6ZReavZ1UUkyEc6bNxPKwLCVRBKC95uGkheXX7lQ+YUQ2tRTkaXm2+BYesUQyjLbnyUigWb+3norh7+vli6qvqlj5AMEFOM3oH7MDeNUulHkTX+3VxQVA5UIN7sJo24wyvxVLovjQI2YZ2EPckVshR8PR55FkNTIHSI5jzB5w+WpHdXYJ8EcqfszXu4t2vcOMtF2Eh+KsNeNS+AzxOZHG85hjIdDT6N3+fZ/aWfr+5ZBT0NxigOURGDMfcosRuwFy6w4BIcjm+d2P0HVD5CMa6UAkvmUKT0xnBPfTsoQpjWI890bLvnLQth8PjXITtXSungUf3Xcx0LOxa8usx5hShnw0Dmn6pG2ARiDaRjovFyHe3T01pt3T+3xML4mqb/gh5PDmzbLc71zZgVVvS1YwsiHy0+Bj6LMCRQUVLGGT8Szl28KLDTEBEfGAV5t+P2bQjAj0LPoEffhPWmZX8XvyFKpwljyFEOXcp1jSd3hMNgxtGb7ulTt8F3IB0ED5SuBiWM0Q1BadVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPWAitE3Cf0T0EW3swjSEu+ZdAGs43xw7zy1RUiiE9FYT3fFal5JEsVusn/U?=
 =?us-ascii?Q?cs8gEmJimkV1qaGP538fvLdlP0cKOljeLRd4ZxcQUhAqi8MBzTIfmnbKyjLb?=
 =?us-ascii?Q?xU9r8nAszKWUvxIewcZhQUYAjivFUR0dV5Yi2VrXHLmf6wNr+R7E3fTKKZkR?=
 =?us-ascii?Q?V1oriaiETxYpaEslIAH4Y9IBPdYRdkmWc/J664sFppFkcNx/2oHv9ZbEnnwX?=
 =?us-ascii?Q?fdIp5B71Ah/zkNp29SiFsreb6Cpk/wBU/Fkh0M8jv3lZSqK8LrZGQgiDfxay?=
 =?us-ascii?Q?hbWrFlbg9Iqjdc6bAm+pnbNQnWxxoNMsQcWi3JijiyyBalZK7wJkwu5dx/k1?=
 =?us-ascii?Q?UWmWwDpsnsbCm2qdrT/FkZasWsbXtlABVz/w8BV2wO5n0KWMs/pFZ/OgXMBU?=
 =?us-ascii?Q?lOBMDKy2/9vIiNGvpAn7hj51oY1JWd2zN/QTuvhxOy5uPAAxjCeiPJ1FVlTW?=
 =?us-ascii?Q?UzIUVjn2du4fzgYSDQUpQ/tYve/SDX+yPrTlzGNFzMod66w3MU+/jP9haA9E?=
 =?us-ascii?Q?6QFKN14guGnE/8fPz7bKmBUMHfH2kMPAn85x9y+B8gjk3QmfW1e1mcWqR+RD?=
 =?us-ascii?Q?271BeLv63H931MlOVHuOMMOivxLCJ7J/1S50sl2jglts4eaHACkQIkj0uzoC?=
 =?us-ascii?Q?ty1MlpvqEev5jelpRpX3fADqDV5RUbw2PoHkK/fVzm6Uq4L+udUDqwWfv4V7?=
 =?us-ascii?Q?o6lPBse9E3ZysYIbiCrtgG7RZWweyhKG35WedumXCwmq37qOfizaG9wipjuQ?=
 =?us-ascii?Q?S8bvyh1WEuOSk02dhwBi2Kb6YNdhpYdQkV8McnTm3zp0QaGPD7F3pDO5j8c4?=
 =?us-ascii?Q?iZ1DgQs73ks3FW1xZROewqDuL0LtFz0PP/zPVqSWpyAs8TfFxyuWJ7hSvd3+?=
 =?us-ascii?Q?M8dkdeXcZTt68xS+0ZQG1D/YeYths4TcS7ZyeIT//WLD46ArFxiB6yhm3PUd?=
 =?us-ascii?Q?mQOJL+Bb5XjjoVfpOxFuAMEzoiidJAKruqZx0Ilsv3RlmB4/B7NQmDWPfhDW?=
 =?us-ascii?Q?N1ixrqb87G7Z78dJXujGmruYEYqp+Ry530wnvPlo0hNaoJi9NPC6qwxTHhpL?=
 =?us-ascii?Q?+uD3jyeskJU7t9NLIVtpbuDlPWvG2/U3ppVC/M1/4pr9cICgE+pcqBkS74Gf?=
 =?us-ascii?Q?yx3ynJYP8qNSf80sW80tI3RgvfVG2Njx/ZJjopubnuD1vpJDmsxhTRd7teyl?=
 =?us-ascii?Q?z6WL8oUGYeIjC0d5YYaMHqNkXSGpwFq2T+y4nCpr7ac8pWq9aL4hnaUwyNDB?=
 =?us-ascii?Q?w/wELgL3KlZiL0WIMEK5JxAnBs6sx6TzFYOaKI6AMuvesWIRxhilaqRf2TT0?=
 =?us-ascii?Q?M5Egl8tV2t6/Rusgc9e+TlUu/LSNGV3TpsM03mBzs8Etg/5+h4Ehp3XX62e1?=
 =?us-ascii?Q?K3rHIjsz8W6V5G/rtWH4rQqF9Jd4KWuYppq29t4zNoiEabBnDJTfkhydqttb?=
 =?us-ascii?Q?KM5ACkMgq9Uz4dUbCtFv16qW38nH2zmzl5OjHpE4n1X1XG4a/cvobLAyy/u0?=
 =?us-ascii?Q?uAwaFXT84V1D+73k+xBrQAwqsiaoVBEpLhUr+QwYqhzR6BU9SIjW5/TnJDfM?=
 =?us-ascii?Q?ONrxEpZDRlDLrjJ6CT7qWUDuN/SwzVD2SH+iM/HkGcxniEZ6x4KYyJksy5+c?=
 =?us-ascii?Q?62tu1hC9F1d14GEMn5MlXTI0NFL29+iAxtHPKjbdQDuz6fwr/qKzZEOQ6fSk?=
 =?us-ascii?Q?62+5KCtrC2xTnuRUywJD33rE/3fQ8nCtc/h1XgHii05leH193aRlnRmhRx1a?=
 =?us-ascii?Q?Rge2hvXtP2cGGTo0XpZZHIeSw+elXfAQGWTqq8MfxF7GA3pWPVHB?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470394ba-af6c-415e-3fbd-08de955b2e21
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:39:58.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DevCG7xFhaBpV+vps76X7BSHlYNgCGMnajDpMQl5/8YTBJ039+Vja0VV49XDPrznyPfPoNY5sG/8pSKn62CvY7FHY5GQ6JjGHgxpEoBl7peoAr8N0IGWK5RZa4B9ygy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11293
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

The VSPD block on the RZ/G3E SoC is identical to the one found on the
RZ/G2L SoC.

No driver changes are required, as `renesas,r9a07g044-vsp2` will be used
as a fallback compatible string on the RZ/G3E SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v5->v6:
 - No changes.

v4->v5:
 - No changes.

v3->v4:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Collected tags.

 Documentation/devicetree/bindings/media/renesas,vsp1.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
index 07a97dd87a5b..62bff3ce3eaa 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - renesas,r9a07g043u-vsp2   # RZ/G2UL
               - renesas,r9a07g054-vsp2    # RZ/V2L
+              - renesas,r9a09g047-vsp2    # RZ/G3E
               - renesas,r9a09g056-vsp2    # RZ/V2N
               - renesas,r9a09g057-vsp2    # RZ/V2H(P)
           - const: renesas,r9a07g044-vsp2 # RZ/G2L fallback
-- 
2.43.0

