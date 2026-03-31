Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9752E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF83810F42A;
	Fri,  3 Apr 2026 08:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="glWDpCM+";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F09A10EA8A
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKzzgiLywBpM3tVVHgKKZ05ziIZAeO2vSRA7v6apuE0O0xxdwHUgrw8SA8/Cm7yIBULSchMlnKhZTJKF8iHjwx10SL4l6aErJvcU8sc4EiZztYvSYbrlUv03FAk+B2F/UxGWagC2VeCVzbZ8vbK3z93ulv0UTVkuXs5M+QBRoeXB22no7hHrdLJSW9Hiklrns2dcsAUUS1brr7a09pm3jIwYbBGi7h1HcE4vVEc/7FA71ZhBQ5UIF3nYchnyq28i7Kxp1fEAKoZkVyUqEbUTlu3mGWqYiIAVS5rJqy9Cki21yLDN8OEUqJ3RoWHqeNeBRb+iHen0rAEsJYFlTnr4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBDSYEvqKCo62+0+uAl3NHVtIqAIea0rHV+2fdWl+04=;
 b=RxtNwYYRNWOoVcOQutvtqiViwpZIyRX0Kxyu5jlNuJLiecn9/3FA6Mzb81RMlh0/33DvCvI/QWBHOuayDjNqqInQPQasQJvE5ZU/CSYyBe/AkatBG/abyCHigMgekDvr1XZFa0Mhpe2bZNYm0CvJELqdWruWyHdT/K11lU7g701rsgldJFSiZi6ttlrB205V43yUlO78o2LizxTZTBwV2Ww2Q66YrNMU30Ety7AMyTchPNPfuYPXbeuJKZGK+DGXqvJXGb9aG4nWIKCt7iz4sQWQq7/D4V5XNF2YGjNijGWvaJXpTAZ03eaVxUwpXVDLeA+AXuGLLX9feSecaq76Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBDSYEvqKCo62+0+uAl3NHVtIqAIea0rHV+2fdWl+04=;
 b=glWDpCM+FADB7XDbwfTJiRLs+0DAZImRhsCTGUbnEznzL4yhL6PWt+T1XDTqB4/XsUQXpXY0XHUeC2fFIZhIiiHt0isGN3TQIuVmjKDujxyxqPb0o1MaHe6YFJbpfAhkZLro3pB8yxUYH6fvL/xMiRTgMuAM+gclUc+iSM1JyrSjoh3PMvL14rExKDKoJZfeYc5ZbX6HcPQobeU9fu/NHRyW5L5G+aARRcwryMwDaMz8lKDOf4Xhp5F+vDZI2HFZBYdZFgl7828W6hTAWC0UmHHYlsr9XJeOJYSr32EwcblbM/K6KH7l0RHpsWXJvwnvsUa/TWH0sdWXpiwje15n/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:04:16 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Tue, 31 Mar 2026
 10:04:16 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Tue, 31 Mar 2026 18:12:38 +0800
Subject: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document i.MX952
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-master-v1-1-65c8e318d462@nxp.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
In-Reply-To: <20260331-master-v1-0-65c8e318d462@nxp.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>, 
 Jiyu Yang <jiyu.yang@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774951984; l=946;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=wKPyV+K6brlK8Mytebjk+QjOTFx4lxICPSqMDkA/eZI=;
 b=j5EM1YXO9neUjZ5TGmcyFrpeGdvz1dCNzzyVk2PGqno3jySAfqCm5IQUfz6Tf/b4kkDbXnWer
 ONjzu+jAIqlDYbcCKjPcaohFBrUW2euJT072pQpj9zJjC/KRQOJRxWA
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::17) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f989b08-88a2-4dc7-2576-08de8f0cde2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Lm3/NjQEruorZKFMeHYIEWFQCzSKU4rbfIRwW3m5FW/OL4UfPOHR5r1RyanOtQfBC2hhC3w10v0ritYXLVSFVfk2stodm6xMY2sjpciMkUoDc47lGUnx6GmZmdRz5JFTDl2/fJj1FD2lpyEAOKTevTZVCVcnkUb+TKgD9qiD1ZBsHBOx2bEt0KJVJ+2gFMxoEK4bYh/agoQYdQLHfLYvFodrSL52r4XucvPlO2F1PnbG3H9MvV5cTUUfoDgeeVIH2aLqVbV0g5gFAvcQkHfm+I603yXZLVBvhCAprMNJIMDIdQ7wWHX/32QCIRHi78YUuvZQdDRtY5jwSzHjQzxPMjvDFpksYf9+KGUV4QuuB8TekWwP7in9FHma5xIZ99LM/SuD3VaTHx4Tr9CuiP26cTmmTq/Wzo3wcveVZqAi/tmfDjnM3uCR9nf02osoVnQD/hOkRZm3Q7pwMz6ApSVvAZZmZQQdEtODdeW53Erw3v9OzeEOvRuTpF8sRxtrx4s+MWph9rzdJKyGNNuhFydGSmKfoKXhdOMVKWI8NpvpjtMy0aCQDNiQaZEY68xWIKymx5HIF4IW0Gl0uVVLNiAmk68kfBrnsCwawJkM4pJdoMMOgAuF0eIkn4JUFi9Mc2Uk8Ucl1SCbw2/xKrQDxgLZys8m0d+espbxdi7Trzm3QtmIK/bus1EWqxmCH+qiVkep3M6MaAAIlMkmk1Aa6BwCkNWZbzzel8qMcgcJ3lPp+yl+1/6UjvjlFxLpCci1HaNyRyR5FEUmsp/Tek6bVb42u9FVy/aZWICxySgP2BB5clgsQ+GL00dS2ZzR8jzZcFMU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FaSklxNTB1Rkp2M1JTOWZUd0F1QjBvc01BRXR6VWZ4ZWhiRHFDYkFJbTNo?=
 =?utf-8?B?V3VTdW9xd0hjbWkwMnMxSkwzUTMvYjNyeTJzb2FoZXBKS3d5UW45UUNQbHZq?=
 =?utf-8?B?d1VPbXJGODd3a1RGSDFiY0M1a25IKytPeWNqREhSM1lLRGVIb1NYUmcrbWhC?=
 =?utf-8?B?bnB6dVRObk90Z1B4Unl5WWlHZnhXOFNrMy9yMGk3TVZBd3RMbnhrQmlMMnls?=
 =?utf-8?B?eVdzdkEyWE1vSlBsaEo0dHdlZTVSL2pncWhWZ0V1QlozYTYxQ08wSitxOUts?=
 =?utf-8?B?Qms0bHRLWFMya3I1MDlqVllGUE04Z0NoUUt1K1pFaFROdm8zL2ViMlBJM3Vk?=
 =?utf-8?B?ZTd3cEdtbzNOMWdDNDZjb2V1WWpYZnJDUm9aNFRMV1p2MUltN25DMmRNaFhx?=
 =?utf-8?B?amdNV3RQNzRObzExN0pIaUdjcGFVK1BleHhuazBVcFV1VEtOZnY3SHNJRmV4?=
 =?utf-8?B?eTNuS2Q2cGFRQ1BMd2dKbGRkR2VKSW4zMG5iSEpaaVpGZFR6bGZaMmsxMjBV?=
 =?utf-8?B?MXo0by85cDJBOHlSQjlwQVBQQll6U1dKblFPZHRlMnFGS1g4NW1Wbnc2d2ZQ?=
 =?utf-8?B?NSs1Tk1qVmlFOGRVWC9NZnliNVBDTHpEbnJReVRBc1hwVUlPSGdWRlNuaVBh?=
 =?utf-8?B?R25pTFlOQ3lmT0RxZ0Y0aitYT0VHWWFhWlJ2eUlVNzd3dkMxeDRCQno2MkJR?=
 =?utf-8?B?b0cra3hKaFZHK2hLRE1oZ0J6S0JEd0wrR0N0OEJJbzZUR2l1RFl0ODgzYmor?=
 =?utf-8?B?TGdVbldoSERFNW9CZ25NcEl5QjNvRDg5MW92Z21LZURtMTZYQitYYmE2Yy9H?=
 =?utf-8?B?RTEwVUJEK2NmRXBSblNIazQwYmF2TmIxTE1objlOVko5QzNNM09qVVRRVTNM?=
 =?utf-8?B?dE55MEhIdURpRmZKU01xOGkyZFBRY2dVazJDZk9HOW5vWEExSlJsOVJaOEdt?=
 =?utf-8?B?QTR3L3B6M0RDVkUySzBzUTJOYzh3UFZUS0tYVlB6SVA4dTZnYzNRK0g5ZWll?=
 =?utf-8?B?eTZyN1p1bzlzM1E1TUVhdlBvZ3hyWldmdUNyaG9FZmZsRlg2N2g2bnJxclo4?=
 =?utf-8?B?L1pjWU1XV0s1Yy83WENLd3Nwa2RaYnczaUpyRTh5Vm9jUWF6M1VrenM4bndY?=
 =?utf-8?B?ajd6MldicmxSZE1jTW5KelJ0YnI3M292NnpyamJ4RVBTMnJYT2Z1V20vaTVP?=
 =?utf-8?B?OFg1U0tOeEVNU0FHalRQVzh4U2dCQ1libUZaUzc0eVg2M0U4ak4wbldES2xu?=
 =?utf-8?B?akwwazFvaWNvUUVhZHRVTlhUWERVVEpHZWpiK1hlVCs0bnRPdVoyOUFPdmhv?=
 =?utf-8?B?TnRERHVPVzZ1VCswenlsd2dUd3lJUzltY0pZM3daOWJGOG5ZQ0RER2g3MWpX?=
 =?utf-8?B?eS9Oc0tGRUJGWktmcU04aVNyTmxiUVE0Y0kwYVdFNWY3YnIyY0Z5Vk5Pd2ZJ?=
 =?utf-8?B?YXN1ZDNRdDFKdWNpN2IxcFNvOGhBOTZCeUc2OGIxYTViYkIrOHI0NkIrSU95?=
 =?utf-8?B?SStZSGYrM09TY1lTdWNVVG1xUnlURWxIVHN6RTROV0ZrbmphNk5UT2hMUFdw?=
 =?utf-8?B?VHF5OWFlRFhwaVdML0RzcmJvcEJ0NTY4em9ONDF5R2ZtQU5NT3VMbjAybEdm?=
 =?utf-8?B?QjI4OEsxOGRFVGFqR0tjOXNqQTdmTDNTNVRQeG9pMkZEYUZTck53Lzh6d2M2?=
 =?utf-8?B?VXZINGpRUXdEeWZXS0s1TEtsYUpvZGFSQzR3MTl5SmMyMUtRcmJJTlRXdDlh?=
 =?utf-8?B?OXFJNWptaC9FVytsckExaEhrWXBSQW1OdEJlNUJaSTVBYTlmU3RjUjN0NFhJ?=
 =?utf-8?B?eks4VDAxR1g3K003R3cvRE91Y3lWd3h3djN6U2VLWkdIN3YrcnJzWGF5eW5K?=
 =?utf-8?B?MzU5TnFuanNqbzkyVHQ0Q0taSTVrZ0FueWwzTFAvelM4WGFjczBGelBvTFVz?=
 =?utf-8?B?bUZTclV4VURlR0lWN0hGNFJoVXBPazgvQzgxUE9mdktVb2hpSkNjZ3NxQytO?=
 =?utf-8?B?ZHNTNlA2YS9teVR0eStrdXY0TVlwVFlwbzl6eS9VMndLUGxoMmRYSzJyK3BJ?=
 =?utf-8?B?ak81REhaa0xEa3Z0cWRYaGlvVjhpMVMvWFJVcFNROEgxbU5pNjduNEtDZFNP?=
 =?utf-8?B?SUJmV2RQakkyZjNSeklIcHdvUFQvOFVTYXJXTVR1aXJwaitWVmd1UWxWdlRh?=
 =?utf-8?B?aURhQ0JkMjVSRldYK1kvSjRMS2Q3cFBWdXhibFVjNXdHaHRNV0R2akIrU2ky?=
 =?utf-8?B?ME5ZU2tBNlJnL3FsUUJ0TkJCZkJJa2NydVdWaytRNjc4N2w3alBUK1Z5NU5V?=
 =?utf-8?B?VDF3aXRjRER3SC81TGNhYVVXa3dibzdsTGFoWHkzbW1IRGdKbnNCZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f989b08-88a2-4dc7-2576-08de8f0cde2f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:04:16.4274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF5PrHfrtjh5fz14BG7gX4K0PrKwrKmdwNQBMGrJiMKZpAvpYKxO5Q0PtsbwxQoRZERvWHo2n9ofxdyz87wi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Add compatible string of Mali G310 GPU on i.MX952 board.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 8eccd4338a2b..6a10843a26e2 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - mediatek,mt8196-mali
               - nxp,imx95-mali            # G310
+              - nxp,imx952-mali           # G310
               - rockchip,rk3588-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 

-- 
2.34.1

