Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE2606A330
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Y+U8cPcT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16C210E042;
	Wed,  4 Nov 2026 11:37:00 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B66010E042
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 11:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHbEuT4NRgqbMwfV6En8sILxPpeCSgptgyNMBql5v8vpaftIBNTDOcDq7vZL1o/JUNB4jXZ32VjJ0hG3vMMh+DojcbD9cklv50kZTxe+a7XeVpLu1r5EZDdshiBY9CcCASR0NEMVcXCp5RvMCztgQHGZf9IionDQ8rgmANI/2u9BxdkhiOw5Z0x1I5s30YLhnsLa4kV2Afy5z1Y3V6Q76zNr8d+LGsnMvTdA55Iq/iur4JBNCKWhImT+kI+pYUz/YtUKo9W85vsEBwoGRvPbYtscAtrpghvz9ICyQXiXDWMnqDGl3GLT+RLRl3V8Y8pmviGx6NMfvpnAUKvbnhX3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/69YtFQw2ST7BOGkCKvRtBwIg7x2gLSHgC1AQp2FNVo=;
 b=nygtus0xokmbigcx6dfRxTO90nZtxbZbzOggGGNx6W1Wq++Qnnjcg6CU5DBawL2exPqa5CUskksL+rch+yGrwL9ranmzjHEmW/bstBbJAEa3s1M9TxzqU+/dUQ2PQw49wTCiwhhsy6w+cozsVC7mcxc5PXfNtt8ARDyJW5ySmznB3EAFz3i6mQ3QWpNhBMP2PBsp7xuyiNg3TKsKlM+9DtrAXy0Ni7B9VG0Hc/pL64gBVPqMxS0cw0xd7zsO6yICQCYtLx08xtMw2XeR+0Q02PmhGRNWjzeoxSqaqUscPbGkR1rALrNtL06zLslXPVko5Aeltro2Y9o9E+Xow1+PiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/69YtFQw2ST7BOGkCKvRtBwIg7x2gLSHgC1AQp2FNVo=;
 b=Y+U8cPcTsWFAh1PuJQutF8KxVqh/WdGkFG0ZiXpAV0RyrIpG5NMYJi9cIdbK12MhiTk3n2iLyOF9MW9N9ROh31CGB1xT+aLM94fmrYwOHw99dpj5raFQF0n3EPuPdcpkTjCAfzmGJdvLBt+RuUqF0hB6ZWUT4M7GFHwLSqpyHXFwp4e9nzpnlk+JnpFuPVLtIX+FdbBIuXLQyqN9t2QLTY6Izn6P4hXzBArpUaX0eDfnM11Bu+tZQR7+EfJBww/kgKxWWp6c1nYS1Nn4crfP80i0po/26XnlQXKdMqTDRY8sOd6gswp36Wy4Oo9e8MbyrjA10yzp6p5dMZ1K+X2TRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11849.eurprd04.prod.outlook.com (2603:10a6:150:2de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:36:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:36:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: aat2870-backlight: Convert to
 subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:32:42 +0800
Message-ID: <20261104113242.1634043-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11849:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff627ee-8986-435d-face-08df3a67cd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|261102123227099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261022075727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: XpDdzzt3Jwerut7ZHXS+j0Sx1Z5FYXYQWo2aXXfss21JRxnw4CX9hTMD7E1/UHoeWwQIQshljzxXkdDnn1JWC/NqkFbr+YfKHsva0ygMMvsERUqobVGadwmnB9H/0ya6RChYCxCephQcfuBjs4Dqth7gErcRbaLnsbCjgyZDwi+QP43XOrhjndwUFtnP/HkEEtVbT8vFelIJm4KUaI4AVY4EE9vU9fS4BgSdSQc9unQi+c+71jeFLykJ/3i77ZkTFehuxieMDEi0QigMwAcEoIXiyvSag44VqNJORuWHHZPjkv4CGB02obVgH/h7faFux9NxZ/mTJQmAl/LuZdO7+RYc5UK3Vldl/ZQjM4sECIfEf4x5L7axZB1bcaJqSwmIk9W4jQu7ydNb97CsJ4aYIqCCh52wCPi+a/aP8YTaxnkOrRerm9NDtmBZ8VzuBgEuZJ13AjlDcXClxXZXy6+AqbV28WFopN1VOxb1jPxXDqlMY9CBu9pRxDy8NC/zsCIpqSMhPH/gFLFUorysOeRxfTlqvxGQSwCKJisnW0VG2A9YJ/1NY42VHLvh+LNA6yDLkZq11Jn61Wv+SIF00TyK/RVRiG+TpNs4Y8nUF8O2vPwZKVquI7pP0PwoXsGqCEEtqVMuT08OrRsB4q+JXxWCDEo0QCkMRyKL+fz72Ppzhps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gpd4XB1FUXxBwW7qNFDQ8xK61/62P3mNPOjHLYtNlSqLDk0y2tpoEB03nu7?=
 =?us-ascii?Q?L8K/EpAjjBpBYU/b3Wn+Sw57XFc3eNuFOCI+ed4BJ9y1ck+84iA2nW0qIVi3?=
 =?us-ascii?Q?HxTJ8ocGRP9aM6CT9iC1Vw8vINk8lyBtoex/jiJyhcnTq29f8VVS+bpp6DDN?=
 =?us-ascii?Q?UZ0XPMTagmXoM0+p2M6YiHs4OW+fPIclV+HPFkXgxg0eUiiHT4ig5S+rdIyk?=
 =?us-ascii?Q?QtO4N8bSf25kPCTKTsn43i8GrbnH+y69OUnfMp10Gh4NS61Kbqx5sPvmMhdc?=
 =?us-ascii?Q?3KgalgS9o2OeLx/1PDDKWV8FGyCYyQ5T/BhpUMfi+lfcBSDlHW8uix7ngs08?=
 =?us-ascii?Q?wVR/x3i2WWIhodmGh84GakEKUTfik00Y5IOSHzgnlLsduS3Cb66Opn5T732x?=
 =?us-ascii?Q?sXgixIPzsFBnBCRegQtwYIa2EyK6rEea30MYtt57g8tQxxykIkX8zxcpxKLD?=
 =?us-ascii?Q?rxez/ldJYcqmC8+iQI8PkioDX5XftbTxr7QGzsuIKV3b/88g8YgmouLi6Y4l?=
 =?us-ascii?Q?QmSP6/6MUpuoFq7EldVyKR5wkOcw2IAPpiw6EKC4qX5sM+Im60BhHIRNQ+95?=
 =?us-ascii?Q?qM6Jmm3FQXqU7L4aKawFUqrh4aO3f2ncUBxmQH8NTqvvkDowQopyJagIwcJK?=
 =?us-ascii?Q?q8KNPjt/VVqHet8gOPIrYcvQJxS1WNHgygDrko9KWy2XZUr/bf6HR1TWeQbr?=
 =?us-ascii?Q?1rQRMro3TrnKYxFR0ofwS6zbK5IBbd41bSTxjAA6YVHcJbuv/oRnV96/rWTc?=
 =?us-ascii?Q?iSmLfqWtupWZpujOyplNiNozTdbwKvnnkz6FwHC26yXfUiDNyIeD+NaVMwDy?=
 =?us-ascii?Q?VmNbS9AliD7WAV2ZYk6u20nvPERzGRg+XenUSzrJwAObJX3P0sELLcMF5Bqm?=
 =?us-ascii?Q?lbzqd3DfjP5db8KNGRdoXsUGGgtbnpCkblfp4LIkk6C0X+DedhXXUPYwUGRs?=
 =?us-ascii?Q?8OdSfvxIeSErwelehZceKPCQd8AOtFdfCsr5wJJbNvAHqaXUbeyYgCfDufBH?=
 =?us-ascii?Q?GTLL7yKAxOMibQUJvAEfotmE1MRIrUIr7LcO6M9FEHg/iL3ITyOkvPkDrZ5j?=
 =?us-ascii?Q?VWCLA8INbR59BctnQNSC3gcOY7jwEzzNwo4ehnpABGaQXeHgfsYPrPyZI9SC?=
 =?us-ascii?Q?XUvUUcje5Qg7n1dFipBBw5z/n6WevThtV2yZ3X5TowyZ2Q03ahbuVYI70W2b?=
 =?us-ascii?Q?uWrbNR8dHrU6rCHYdSDs47rgR93m1wXPU9tn/hOetaCG8it6fvtCuV0YSocK?=
 =?us-ascii?Q?h7Oap5DNsRe903pcGpvF+mVOekWbXQYbwQI0g/8SNVRiBKnsDZTbV+wQpWXp?=
 =?us-ascii?Q?g6H0pyuuip40LSfyRNJaB7Jvv4QL9y0BBYYa/hBiPh8yBbGOxUdrI0n9kDZJ?=
 =?us-ascii?Q?TD/rc4yTBFgJRBW4A6Pvx1RRh30ujVO1/50qqoa+4TCK3yA/pf6J0h5UBNGo?=
 =?us-ascii?Q?Df6qIe6VeiZxPhrcfvxfNtqfFdFYkTn3Q9l9xhZli/qJfFMclhJ+yf2wqq7l?=
 =?us-ascii?Q?Wto67n7v+Oj2tB9/Vj61yxUlxtRAnLG9hFUS4VYjDDQiO1w9gL0Js0JGfIe6?=
 =?us-ascii?Q?QglZlHK5ptZGHZHJa5QFrSF66sCykpYluQrKG7gTomdUkIfv6+GKqWQIaCHf?=
 =?us-ascii?Q?wPvVwy3DF7v70Xzcz9IOZPVyDCT66CCUgt+dSZInVsJFU8UC8MVj5TJV5NsT?=
 =?us-ascii?Q?PTkp6F52siJLT2h2jsdnV7W6jCy3mR7qbH86ySze2h8l20sTH/TfhK41aYx5?=
 =?us-ascii?Q?Fw7pLkpWexmo/buO8ym98Q/3oxZ1w0AsdQ/HIXqWlou7hvTk7nIy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff627ee-8986-435d-face-08df3a67cd26
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:36:00.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD8VXVEmtHB+KiIg0lsOnv3SnXthyTUJ9BjA8AMB8lHyh22fzgpDKnlR1cC1TJtEbOxoSqVrgIbgRRJUFNiK99yQ9ghy21CV5fUcD4LvtvxYp+ijr3d0cXfvyv+YF7Eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11849
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/video/backlight/aat2870_bl.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842..d28f54ec5f7e 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -188,18 +188,7 @@ static struct platform_driver aat2870_bl_driver = {
 	.probe		= aat2870_bl_probe,
 	.remove		= aat2870_bl_remove,
 };
-
-static int __init aat2870_bl_init(void)
-{
-	return platform_driver_register(&aat2870_bl_driver);
-}
-subsys_initcall(aat2870_bl_init);
-
-static void __exit aat2870_bl_exit(void)
-{
-	platform_driver_unregister(&aat2870_bl_driver);
-}
-module_exit(aat2870_bl_exit);
+subsys_platform_driver(aat2870_bl_driver);
 
 MODULE_DESCRIPTION("AnalogicTech AAT2870 Backlight");
 MODULE_LICENSE("GPL");
-- 
2.51.0

