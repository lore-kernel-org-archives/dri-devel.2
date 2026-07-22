Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE06C531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FAD10EFC8;
	Thu, 23 Jul 2026 07:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="WeCkXWlZ";
	dkim-atps=neutral
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013060.outbound.protection.outlook.com
 [40.107.44.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F7F10ECB3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvXqDO8NpPXXatkx5y0gAZBiO5EggSQprmymC8dBwSd4PGDbJYhS08Ot0OKlYngQC/DpK7tP8/WrvPABENikh6fonGazuKTBpIarF8i4jYux0p20AybxY+ZoMcLV3u/ckOtJM2HH5oPxnE/Rd8wr4HHr23V7uGGN+Q7sdACATQYtHR5oPqdG+jR1TiWtj8NfcOEMEB7xshlNOJxriCtPFb3EIDqe1/h4Al5Ond/Mn5Y5Tr3f+TYW77bWtb6DE1RqZjex0Yxyegchr3CLMlZIXNThWHHbD5zIY3WLRARMf18r7eIr2zqVzA7bnEYWDdtrEQPYV6m558uRuuOIOv5NQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MadUgXqQiEOXArDA8KiqtKSYkwOJr4UTRAvyg+FYKnc=;
 b=ogw0lZWEq75m2PEkRZIrMJ6zYGapgMnrHKwi5G9NtMOv5P1s1bRwQT/B4jTB1QWbdFs1WSb/syC94DMaeLsBOVeax8C3le8As49rCzJbcjoJ86U+ut8D5e2ZoWrIKCqmwNiCIC1CMS5OmLwlgHsHsb1PO8uToK7XYjbDJ1ICUz4g+tL9w/uotIs0N3FoHQZFjjkxZb8x4pI0nd4d8Dy5fQWGYcAIs/QO8yvDpW6mbpYlvQdSHgMrcW4zdnLGHUJFqrL0h6dS31vhfj7sHVVMCwziRj/snCt5383BQeQZc8CWo0mK0V/AVX3WypQ9AX2lKYY93hbtD/gfD8zs3dIcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MadUgXqQiEOXArDA8KiqtKSYkwOJr4UTRAvyg+FYKnc=;
 b=WeCkXWlZH+Jloyy5UmL0C2Cb0UbApqdk6tMZflZc0QbFmaedkdk0mFLiQBT2K/E6mAiLJjOD/ce/uyoM3ocU7DH4sx5hYugZEoMl9B3aL8qftxhWoNw+3+Fu3p8tel3tfyuH7ZnH6Jt6bx7fhRHOGOTwY92hhRlYMTZJEDXiFHmfuWv5mHmCn6oakZPK2Z0+Ch1T7VMoYTiaNwfWlWLxfyr4x0C7LTo2etAmwHdBK2jWnviL+LyqKHBszJla17+OfsehJtrLobEb0lTmlonNsPAqRLb2YT6jGy/5Y0wEDykVkCe/a0eGHUQRtggjmycMp93EgNAu0SDhBVDYr9zTTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:37 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:37 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Thorsten Blum <thorsten.blum@linux.dev>,
 Pan Chuang <panchuang@vivo.com>,
 Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/7] fbdev: pxafb: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:45 +0800
Message-Id: <20260722075803.570532-6-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae5b0c2-567b-420c-c59b-08dee7c7096c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|52116014|366016|38350700014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Z3TT3n/OF1IVskz17HNnjwHgV6t94cIuPLMfQgtCnGpVQ69qTrrX3bsqr7QtqLFCt8u6DczoPOiqDTzg6Uq/NsfTaoLMCNxyAZql1cPWaxIPMGC2HYJS8hA9ccJxCc+O6kqOEYCF4hnDHUG3sCRqp98GokYL4+o/n0NkWw2S304a8xMIRxuM6GLxzyMavGSk3vmt/lfwKuODl2s2Cu7Jz7SIzAUi4BzqrnpU2eA5N719giz8Zveg0N6bosrdkdHK4yXd9WLWLJz8W9ZaBQrkZbde8IHJB3NlF2hp8d7y0FTvUZwTSRbfA2oDs/mVb0o6TX50BfTGXEnGNE95wuFvg+V6wrBCp+DEUPqhEJMB3iWrxwL6yYVyCNUl6rm7WXcO+4JaHUDfuevEyJ8jDF3g+JEqFSej4Aw4N7BSgp5jDeN007dtAX90/4Aspt6E5/PmmToXupEIuKzAWi37jWmDOsXWJWyb+Xggsj+qQUyat75OwO4dP5TtfysuFDgaIwpQJX2oluLwWFCt0c5hTb1ERRkaWk0rQ314DjAWiU9TXjxVUfVLonGMXu3ATuzXxnnOxXPNxuwVMvUc7//VHi8ZYjolC9vUUU/KerVRN5BW9lfvQklOYmfF6Fa9lGieTKLcfUE4cnb2gvl/dI2CHbmcDaRV7m6jlsko/73kZeZbQOg4E4w0QTmsmmv7uUTwF2h7U1nNWy2o0ZYeUszvHtAvAoswF0CQMNus3JbNHyHVPEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XR4S29fX9UnTzfAmcnMDr/CH1BPqbny5MfYVo4JP2z9gcdO77IXeVcrpgjWP?=
 =?us-ascii?Q?SmDjA+taePZmMo+s7hHvSoPxHreRB8qunllZ5jNDqwyfWL7BJGOvNJv4KauJ?=
 =?us-ascii?Q?dKqCZ5OvgGndD3EKWJFm/hjbUI2pMlT8aFKxtT8Is43B9NMQWgjB8eBjBOHY?=
 =?us-ascii?Q?hQgrRl7nPYLHD2zMRfNfgJv5fybr2QoOgjUGzvpFX5LEEE3m5X1ZEz31ec4/?=
 =?us-ascii?Q?ZnEbSyfNyL8YaTX7O+Rs/4WWYE5SssYpqi8Ow0rWQvspx/MoLQfTJ1HiYsYH?=
 =?us-ascii?Q?TQTH2jSp81kdjZ5M0Xp0dLgyAldv79i1Hfl/sS5bj1D7g1xaeuwP99cMpVrs?=
 =?us-ascii?Q?xPLv5oI+O0iyxWBzxeNI8YY5KcrdDi/+Yj4Kon5Zxmb8JtMlZ4rWQKGuCoFZ?=
 =?us-ascii?Q?5D8eZ8FRLS7VSBJCqR5oWKBUMzVbAxQHkaudaGoO0ZQYL4b8TOD4o/8sJpm8?=
 =?us-ascii?Q?HZSQXxrhYHCDBE4Pv6HNRzXI1mE9Ovy1/As18VvtJenj8tz9mxsU7sIx9pWL?=
 =?us-ascii?Q?U2oL4iufBva7/+I/+W9HG6NXKe+XJDD1u0J3Cjgn/qViWS2G2eM+X4cIqHhH?=
 =?us-ascii?Q?XzP2MxnVws/elehpOVmpJajVkbyR5Al6LXwKLs0B6pM0rlLo12HfdB6OGw2c?=
 =?us-ascii?Q?ACT6Odlczm1WilSAmC3/+FwnPgQvJvE3PwbCh0VcnIBUfhwcRCItR2+77+d4?=
 =?us-ascii?Q?YLqy8oZR4jFIntX2y8ZcvKnBhVDYoSwnbwOoiwkAN/Nfu70X3mqLqRX4sGXr?=
 =?us-ascii?Q?78ZR3/KeL2DhixVkbomz2qir8zkdFvmT2zHfxTmmABSx3cvTMRbppzNJZysI?=
 =?us-ascii?Q?XGNJoCh01IAU0zDN4YUSqiCzYTUenTeUGRHCdEAhMEMvS0OdEJ+s2PXm8jnt?=
 =?us-ascii?Q?RgY2oaaFgFQoJkSHKzpmwrxPhDTxPzxg77febVSCRTzZ/pBoYaCiB3teogBl?=
 =?us-ascii?Q?DACZBtTnSUFajJSguSNzPC+mW6A6UNgfBG7WJi0moJ8ezeDXkaebCgnXVC6t?=
 =?us-ascii?Q?BOaiuXbmDSHoyBfPy4ir+FLWe+uLOgeUMW0Sop/D+blTF+19QubrNeTYNHyq?=
 =?us-ascii?Q?4eycwgl2aaW28Qv0okyOaFJVfrjlDcjESt+nyIjyZKKTNmoIdUO5riG2TLdt?=
 =?us-ascii?Q?jNdSziyMdZ5uW5QDSOgdMtlAJbNyVw8iPcixGvQP5sisakeLbeLC9fxj+cYb?=
 =?us-ascii?Q?r9lbCarAFsfl9a3mVMZw8UHdEhSxM9S/oSiA1ipx+VrC53LaPbcuG1uuyPYx?=
 =?us-ascii?Q?Rw6lbn+FSKyETWLg40eKNbkdCXKHXDciETR8qKmW2ljOD3uPAWSjrKOo4Gpa?=
 =?us-ascii?Q?QtWkoHbbQSc32q2JoY+H2tHuD4oPVeI1T7QHaWHt1MNC/fzXGa7uM3TwvqhZ?=
 =?us-ascii?Q?5bVFMoq1fPtZ2FcJTbW4fsJHE72jUnHfBQOSQGS9jMmjT+9tEexxHcnaTTfu?=
 =?us-ascii?Q?DHWc83r4opa+NBQwVIkH+1rLnKJPFziYX6j3jD+zeOTpYLab64PbLFssrlds?=
 =?us-ascii?Q?zBao7jx7TogNlYkw0Lds9ONJNB5clIv76nCbh1dlHZswY7GKYTyhPLXgSyWt?=
 =?us-ascii?Q?soNCn0I4UoyXegMeVVzloJ9h38FzFnbEAQWjKJVMypEEQVJEaYhuI8WjIdrA?=
 =?us-ascii?Q?daK05EAlzp4neNZ9yWkcQxQoj6oHrK4x7HqakrHUjFru4nbPyru+U+ThIKi7?=
 =?us-ascii?Q?x6zToNNSEq8fxTGR/BQMedDGn8AwNHZ5L3/FAY6SYNSl+SHv7ZLtijfp9Mnr?=
 =?us-ascii?Q?IDVZg4OlDw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae5b0c2-567b-420c-c59b-08dee7c7096c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:37.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRU9+x711jc+Uwydz9j5rAJhxWeHYL/A/zut4xz3exL+xs5TE8epLgJHGZFptZJeSb+6xRnxXSI2Mgb3NHB2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8492
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/pxafb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index e418eee825fb..1682345fb9b0 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2312,7 +2312,6 @@ static int pxafb_probe(struct platform_device *dev)
 
 	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
 	if (ret) {
-		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
 		ret = -EBUSY;
 		goto failed_free_mem;
 	}
-- 
2.34.1

