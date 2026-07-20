Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD2C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4257610E10F;
	Mon, 20 Jul 2026 19:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="oMnyjGPT";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7252710E942
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vL/g199xAtv1sM/mFXDtNbkzojizodPfJh79xN4+Kt0/NysbCuC9QmgpV5Lz2EhgzDXjAVwW8WRIjIygpez5Wa5b8i1mtMivB7e9GGbY/nP00Vo2yAHo3Wo7e61NaW0QuDcYB3LQ5Qz2q7pri90iiONGJHB2dlK2dahM1BQNMjMYyORRJDvL6LdHncuysLg3dGdBEcHZUjcJIx+QYxDrcGBy7y9y9pmGgpjiC8O0qPRUfNd1SrDUQV9NXndHBtG4WxqwW9n8hxgdh55XTqgBgGRdpgPxR0426JT4SLp0w90gqIbPTYzuVA6CMvCY05ggUzDXb5JJM1F8C5K89IukMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXYp47D+LGPSx3kYUrThkKd8Mn9eBaQ4Dd5UtW+c9+s=;
 b=fhoMXAGG7LxqQ7QMc3Q0HuLLRH2gtevxV9qb4sG5gpsFMJrss6rM5mnTBtozTeustgrBMrI8SMz86Z98sW4+qrn4nBxj+f8jcpDqnD9m8KQDfnbkJRRxh+O0GWNkg64BbJanZtfIwlDxk0BVrrVzK16ouPMB7aRCTY46hi7OeMPfA57jO0hTD0iga6JxZR785aQ2Oc4ifBxLmSoosqUJFM3vBkqNmT1R7ZN/t7mslmB5xlZ/tZFgUL8RP0AKlDYETiP+56wJTCKSNnyDprmdhzL2UuhXEUoo9dIcmE/a4+GYk94WFyBXfnepiKSjDMStKmiaoDI74TNjpbUvukk0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXYp47D+LGPSx3kYUrThkKd8Mn9eBaQ4Dd5UtW+c9+s=;
 b=oMnyjGPTXoCKuWyzzcuGoQ2XHYYM10qChHacoXyp5IpOgi3svsSRWx81f+OkY3+A02BVL+7bhk1jjlkHpBUCUCbKoINKtpx19GcO3USYvUm/HRlVe2OAFL+/AwKbE8UDzpivroytRsFL/t2TwrFbxGUFJCffOSpxmEsx6Bou2U+5E+7sIiyiI4a5Syi7SlPZaR8+gcuUMYV8cO4I8157WpRfvH9lTsZKXIOOt90yWkHeix4ONnPzR5L+GQM/gdjv+f9+C4U1yhuFWt5oR0NClER9VFND5TLEGSI7F5VbBHlqu8XFkOvNooF9EfaEKyukRe1jbG7ZkxDc3vZFex7wdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY0PR06MB5457.apcprd06.prod.outlook.com (2603:1096:400:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:43:56 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:43:56 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pan Chuang <panchuang@vivo.com>,
 dri-devel@lists.freedesktop.org (open list:FBTFT Framebuffer drivers),
 linux-fbdev@vger.kernel.org (open list:FBTFT Framebuffer drivers),
 linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] staging: fbtft: Remove redundant dev_err_probe()
Date: Mon, 20 Jul 2026 21:43:08 +0800
Message-Id: <20260720134324.239391-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720134324.239391-1-panchuang@vivo.com>
References: <20260720134324.239391-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY0PR06MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f94b486-374f-4c4d-3572-08dee664f1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|52116014|376014|6133799003|10067099003|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I64wgd3CfSowWIxdtQcapqoJ+GEwmloMFVAoIdP5FHsGLMIzmZKNAlX/0uiuNpZ8otdDTBl5RGaAo10T0Kg0qC8ox4RJFVPYtMHoPtN43CipBRi2YJlxJMe8TjdFLqclleRjcdQE571zXNKPwePlHRQsNPYvzBB+HVK3p9gmjDcpgXxFwoLp5bYEm/pyaoRGcPl6x5bpxMx0+F47wFenRipsvVzOxAfi2O3LmBN2ect48J41DdxUmNPHaVrAUAh6uBZzU6Qr4UZ8UYwYmiNeyhAQgZQk0hDFQZboWjll5bjW1VOL4rVksgmw+12fdI8f47/d85Ot3U25LsJEQ5w+R78+VZxZs4+O7qwlNisPjUPR4GF8jinMvhBiXOF5jK7xLHr/thEgFS2fOurDJcgLTFKPm9JC8vbmUqNEZ2OBWaRuDQVc4Rcwo67LWPdXakH7P462eg8L1FQg5jgEdQYj33iM/tk7ewIeF3YbWm5hWmN82WSr/NY9PFS83MUr1Th9RIlQcyySJ6OYgK23U5MnMhjLFK4OYbMFqqkLFtXeNwLLA3aViRApapX3z3ZUfkjeIZdjjtfrhXmSxfs3kymfLuxWBToiPsNDFkldKPCOorspKy7moPwnZqZr/dmC7Z63ci+JElUetRRhm28Zi01VHr2h3PT8i/AjDmhOzIgmy8tgBLrDJoSCA/W5cGACHqUtMLSE6DGzdoZaTTqIADFj7bhiRB/HOIoWGiA8VaSyNUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ajp4NSe1Jj6qkYLrpFNWFIE/udF9XEGA2DvxJ/nyyS9ZQSdXnvki2pW8Py/R?=
 =?us-ascii?Q?EivAPblzHAmdn979cv3vBj6t+9CkSPOnsTq2n3fmJ9khqOdniNIf1q+v53sm?=
 =?us-ascii?Q?xO2Wc26+HE5+UEKhjIQU6w4XZ3cQD6oBCGKGWO0r38e4qljnMwakS38MKjg+?=
 =?us-ascii?Q?6Yf23GrWjc1KQm1rVEKfAS4ubAPg4HcIugmIOdo8DhGJS5YGxuXGg5FReKR8?=
 =?us-ascii?Q?EKRsX98tRZ0t0Ar4N/IlCjEtUCcDwOzpVGLsDwIGjcauUA3/T+5e1m/w8tId?=
 =?us-ascii?Q?R6LgI4cEGgTCq3Wrsbo9hR0lP0gK0yJ5NuThKCa5GYxCJuKLK1U8ksN/Z9cK?=
 =?us-ascii?Q?8Y41BSehT4hZjZKe9f6OWROJDCrj0pMQCdKmePcXU1fRVFNzZplVw5ctdFna?=
 =?us-ascii?Q?99K4Oj85Tl6JrZ4hvQkxv7nOJBrD8LqF8prXuIez/wHRwCEWRFKGHvWEE1k5?=
 =?us-ascii?Q?R/QFcJw0TPlgck+w5oBSFEWrxjTcJbPdurpkFK0SwaGBIQs8eNsQ6TsTdFQW?=
 =?us-ascii?Q?b3RTUlpPI9RJtEGAGKO7ZrXuFUUL9DxhsrH6hNn31nSqCKMNLpTMKL4mI0k5?=
 =?us-ascii?Q?vnpSr4NNc9QofEVVIRBqGVBdWe0qC42KIFRLo/nXZURbqT88xq49O8puTK7s?=
 =?us-ascii?Q?nEwQ7tEzV+uJci5OfZLikzKRPoQ5dnG41JtG2qMGLn9wrvgYOr7aTN6dODKq?=
 =?us-ascii?Q?MEPs5VTD4SqWODIAZHujyyh/oYBAhy2UvZYw/PwUz89KPZhu8Pkz++ULf/Ik?=
 =?us-ascii?Q?3vnUGZjhGlnSvxXpfR+IlCgRsBcb5mcxmsJOM8O+kW4h1MTQl6xA7ZY6Gi3r?=
 =?us-ascii?Q?7mZxZJpaEoREf4S+XiTb59+8GJaegLdxxFrqDXK5d6etZHqBwgTfZEc3PKW3?=
 =?us-ascii?Q?7y5d/mXTQjRghSWreQTMqRd0DKN2chxMpN3KVzKaAkB7mOPMFXEnH6jlsA2G?=
 =?us-ascii?Q?VPMf0cRJogtPxIB96236mmgyP0C2JvQ8cy/aIV3Ko+4cYcTWbDIpweuw6uAC?=
 =?us-ascii?Q?ephf8xyeC6SsO826CB8drLsUv1DuAnq6JQBakhd110G7i5Bp0Tdrtu06ZPVX?=
 =?us-ascii?Q?VJhzO6nxXw6tryDoFvZw/qUvqyIPcjCqTuwxs5bbdTOdJix3TQ8UGM/iBINU?=
 =?us-ascii?Q?aIxL6DyQ2Q9jvSUaKSG1yzxryUXU2qOCdqHRkECxCXe9ULdV+WldQ8/j3RUq?=
 =?us-ascii?Q?jdlv1dIzxbVAZK9wkUvCHovJluh9k4V7FEIIrR2REYVPzDYDaMZzowNPMGcF?=
 =?us-ascii?Q?tz7jjgJ1eHOv4k42kv4l77hf8oCgh8I5RG/62GZFT9jDHD0fwyVkQrdPjOyR?=
 =?us-ascii?Q?41ApvqmvUUnKqreZe819UjzxNwDGFYIuPuAUPRaxy5a4AGEk6OzxEvDSuwSC?=
 =?us-ascii?Q?ANdPlzsSn5JahpJaFMh+sI4I9YB/gk5O2QTZF3aKiU/Y297G3FqbTgBAEVkI?=
 =?us-ascii?Q?N37XM6TfaXukGFRGGjVkA+BcVZ80u26Rbt/WpEl87VRTd7sjQQfFSS6OSvlI?=
 =?us-ascii?Q?ueokk2NS41iz44q288ugO1JYoAPAbOWaRN2siiJO11Q66UH9oE99jWcrNTN9?=
 =?us-ascii?Q?Z0kn+dOanq6C2hLhAPHVt7dbXVnq+tIRTrrS9soJkcANh6fkK2G1N8H9K6ev?=
 =?us-ascii?Q?Jgqa913Ui1SXNB6Wp581sERJBKg9QdMqEEymb3FU43113OxwKZcCywRdCVeQ?=
 =?us-ascii?Q?+EsNLolGR1ICgcw8SV4kBetSNYRL+A39R4qCdbafgza1IzmB/oYzFt0q7zLO?=
 =?us-ascii?Q?dLeyN7/fIA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f94b486-374f-4c4d-3572-08dee664f1ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:43:56.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Me0/yqj9GMuN1rj1+ZnOwDsDnWpigN4E89wL5aSyLE3PDY4IOb96DXMyvr2m4kPjeTGF7z/5IIW85fwuk909Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5457
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a154144e6..ec46ad3f6a91 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -119,7 +119,7 @@ static int init_tearing_effect_line(struct fbtft_par *par)
 	rc = devm_request_irq(dev, irq_te, panel_te_handler,
 			      IRQF_TRIGGER_RISING, "TE_GPIO", par);
 	if (rc)
-		return dev_err_probe(dev, rc, "TE IRQ request failed.\n");
+		return rc;
 
 	disable_irq_nosync(irq_te);
 
-- 
2.34.1

