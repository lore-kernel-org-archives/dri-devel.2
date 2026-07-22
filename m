Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9418C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E8210EFD0;
	Thu, 23 Jul 2026 07:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="SgZGZbvk";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C6710ECB3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoUC9AMeC5CpVYJuG/D1ScScvjCd47A8CEHPoqxGpSAnUmjRgw7t1V+uk33hQQ07EiZrePA++MRVgeO0GcVkhCz6nG7pv59z8n2ZlB5nOV1LVYgg/x0dNQ9p32QRlPHL4ptffnG/uZ1NtqkaJ+AARyuNz26RJGOSuHYB+fy6kETw9pxSAcz5Nb3j0DKKgEG+NxrLkz/G+HL9V2S/1bK3irjXiMvbEyFsTyTM66zknlpp7vwgK07XWK7BEnP/+oEjkZg4/pGp0HiGUb2M5VxEsA55jv1aBcBfnPdUNdCjB+2ImCyo0Zm9eUzFetg566JLoHE0i0tNse0eC3FpAwHrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lPsSV8bMeEG8+F8gtOLknPVpWgzmnFunup9+QN9Zx4=;
 b=oPx7SrnGT0WvmQn2hypYr7Fa0kHlAKbROnEnMX6Wfxs2ypy4wjql2chjllupucwhBO4UqN4ksKaBq6DrlC09Cf035sDO2YRPdC+JpTX68YvP2/E+C8B33xBGkAISPgYGI+liHil1aNTZwxexGhTSTI6+12+VNqN2p8lCeq0+BvM7eTs/s7sm+nRDIQMjHK1JUR0JpwHg6VyF7xXu5krPFWlR3bQmPH5q5WBMX7VhDnhzDqOYLlAcve7BeJo9/N0moO/BmSliNV4jvM8YhT9OtzF1nbuImJ8M2sVqlaKtLkKVPY32QoNh2LtqLvbnq4vnFeKzT/SHAPvM9NWMg4SehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lPsSV8bMeEG8+F8gtOLknPVpWgzmnFunup9+QN9Zx4=;
 b=SgZGZbvkEfz+5yi+IB0N7qzO8Jtl84ko36k+7NViliiRYqn7QkrZh6ip3w6pUmMxPyIXiW6JbzlwB5iqZ1Cci360rrQ/Tw6X6niYXmYaVMi7oyeCSV6gDNn0r7nsCrvPyZACV3+n+81OQ/XvVepskbDxjOIPT9CXTJHyWNrl2yrk33tjCfq4UQEkpbvMKAbMEsH1eqShCEpeNL0IBqNWifxu3ZBCYE5LQoPHIG0x2ZW34AZ4PCo1CtSKk+jU6DuDwgy8scmnOQNiTrNWfENjYsL+S6s3SG+U5kBTy7shELVsVldDxe94cAvYPVbb4ZO/jacjm/88k7qw9qp2xVoRgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:16 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:16 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>,
 Kees Cook <kees@kernel.org>, Pan Chuang <panchuang@vivo.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, AlbertoArostegui <aarosteguig@gmail.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list),
 linux-omap@vger.kernel.org (open list:OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER
 SUPPORT...)
Subject: [PATCH 0/7] video: fbdev: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:40 +0800
Message-Id: <20260722075803.570532-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f02ead-13ea-44cd-5d5f-08dee7c6fc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|52116014|366016|921020|38350700014|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: nStf4tDqtH+IqWYLiDCWdN0OAt2he4aSJXaPWnqKoSmLh/7DS5vLQIDYltjuS8LSNQFMDyPy9zC9A8tlqmWeBLMveEQmdnjcXrKPBHxONueD32QTLvNLJngmd8cPs0HI93yyZstXS1WHSltLevImRkWwPMuhXIkS0jNCiBSjs2UVQgMo3K7dZn1Ytd/cV/HqForfwC5IyfedqvvaI7+OGNDiImg7KO9Igu/eWrbRJInSFXzItnnrUihrkQdSmFgtZGYu2SwidtgcrMlnux9Hsd2WTGr40lBdgabvzgArSiaihgrTYaeE+/kbg2iXdgraGyVKuEFLIxB7mwD08Hkg/LsPgYj1pI1th6XnEg0fp4jUI4yla3UB4qnI5vOaN2T2Bv+aMyBQl1naBc8KIYgOtdvzn07un5U/581pH2Utr2wDk+RIfBrzYaFiwDOql5r8Y9gqtLyfwrjrt1V2iSl7wjAG6bvWOcsyQ7lCFEIrdSlaqpYEDFv+iXo25prhsmT8vyo4K1zjE//Ax14gC59TLxyb/CCfI4CJYRm0kk+phzJZv5+uwNFDpQtdFfCcyzrSxGYRHbI7jtlGsUYHWgAvptUxjcG7f+cKTkfl/9DTvKxkxuv8VDHMW6at4aBUKU2EBAZ9Y+HZNAIEqH8Vpc0ayThEOvlHVJziLZa4KQGGLm3g56tyk9xuannhIPqT+zqTsn5F7IZ55DpH7msBKpOzvsc8tktvpLPXQxk+JS6P0o93VpRVdfKggiKlLooAptL5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(52116014)(366016)(921020)(38350700014)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IcFL1cM+qD5wMuKlNru70VRnVPw5F+RFaqZCw7bE7yhPvr4UbR/ARQ2w9b49?=
 =?us-ascii?Q?JjFD+T/t/7QJ2++nJi2u4Ile8B/wqEGDzc1GtF/FteVfqKFKw8l2+hFgLvIU?=
 =?us-ascii?Q?bupUFK63HO1W7tvK3oPesBep1TJ9uia0suvoOm1xCpRbpLbRCRiNvByIK9hc?=
 =?us-ascii?Q?MRZdjpZxDurNFUhVKZJYUhpC78DeGSFzGYuDECy9Cenjx0B1F9YflfAmD26P?=
 =?us-ascii?Q?O9HNku5ysRYYuSUOF7aURCKffhsQ43uAzx2eCITDYK7j0VPyXrgdeFjC972d?=
 =?us-ascii?Q?mxWXmfO/A/2BB1o471ZG7WfSlCvFQgubDkuH8Qh15cWlT4JJThWEhTYg3Vr7?=
 =?us-ascii?Q?3+xEL5c3n7ljVim3QAR5SBGpGAlBgf07ZFXophgSbzA4w/e2eIu9KVqyno8+?=
 =?us-ascii?Q?c0EKvq+B/Hnt7ilzUC9hk++VoaSDQyww/MvIWMlsHfAl7YLyF/fYPxEM04oa?=
 =?us-ascii?Q?lSNto0yvxb+kOF1rgij7AGAbNiu25/b21we95T5BZINQPpEnlaYjjHDkqMFP?=
 =?us-ascii?Q?yIPIWFEY9KPHx5HAeyTeVUaBCpr/cqr9C3elN6tqNobsbykckrPR36Gv7msB?=
 =?us-ascii?Q?ZXQu0WyjH+MJknNKdgryT7y+JsAK8vhpNf3HJ4v43UGQyYsmlMbdFjSHoXa/?=
 =?us-ascii?Q?X8qhuyJSesltONCh6bU6zZznDXYyfPFTVo3xLaf5xY/q/cIZClHSt4UI274t?=
 =?us-ascii?Q?/LTidMNt2zQJlvLJiZHxy96GRyT6YXBqINb2TBPLf0hGFSDnQjjz6p3m732j?=
 =?us-ascii?Q?46OjAGz1qX9uBjiDohL++q32Z83Hh2i10/YNd5BewSu+0VNGIXyUNW99Y1f3?=
 =?us-ascii?Q?2h79MVfpcUIcEm+wLzTyXXygj8eUjuGmEtZD8JsN6yF715IjXQxLavenqcL8?=
 =?us-ascii?Q?1ePiIf+0OvdL4lUjYtdw/rqjtSeJuB6DFd0G/4jdDxrL8nqb/OqZ4S8XOEXS?=
 =?us-ascii?Q?zhNsyudyGyNbMnaip5SIBY2FvDi2vhEmciuJwlkPlr8ULPNL/UlNRIoBiIDC?=
 =?us-ascii?Q?GCzM8vKeHKEGta8NcO8C4qoTyHmeC+oE0+Bl/Srg0oL0HbOD/Qju12DAeYQv?=
 =?us-ascii?Q?+B/zgnHMA6XQRoVzeoQFYrpXcDlqT5k827ZcOSMkmCG2zf1XSTzjxd7tgfMK?=
 =?us-ascii?Q?8sd4Ne1+TQQFkSmuMUJt2/lxdK7imzhSXqFe+dkEUhV/SuvNjsrQ4I6EAc7i?=
 =?us-ascii?Q?yH1zlMvw51sAWSiTyP1Kx9u5bC2TRhCbMqTFB27z+qD0yoWGOw1j0VGWozJ2?=
 =?us-ascii?Q?if5054tQWnSRldy/OmQlyJ5d0Oiw8W92aS9fmg/gyYDmQ2sXfXgOht9WwtMp?=
 =?us-ascii?Q?MCbPR+7Kp3STqDwOp+o2wejHypAePj0Ntt9+nRQ4POEEP09ubRVDHeF8p6d9?=
 =?us-ascii?Q?dVOsC9eRUk9LUO0iWCz3lm3HeLG2XpovvnfvuPmqB3yxKfleMrTizukfplQ5?=
 =?us-ascii?Q?HVpRaq+WkUSBNzh3E2aqYmBwx7GXUyR++dNep2slfzTcYH7N8BUCW1VwDKdI?=
 =?us-ascii?Q?ldGL3nWBIZyRNnb37IQEEUqPCxP6paXTHb/VWC0DESCL9aNgJ2GbJz2pZsnJ?=
 =?us-ascii?Q?oHKr10dKBpIUjAcYQbR4CtVXG0him5ou456UnsCk+PoEwu6c1Ks9gx4GlPsc?=
 =?us-ascii?Q?tt3faoNvyEN89J6EVjd2LWriyd8vTGYhQ6BILUpUA6vvp6mV6O8qQbcGi89b?=
 =?us-ascii?Q?2yjCqJ8xtLv3jFyTO/6u4s0Fs3dmx+e1CNNgLmzFFVhSsmU+Q1xR4ezG4d3Z?=
 =?us-ascii?Q?XU5YBbVRLQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f02ead-13ea-44cd-5d5f-08dee7c6fc8c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:16.2873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DG9+qollA4dwc8Vd4D1qD0ILO/9Kg5T5pBpb4rzWdGA5JiKarqimuFC+qaKLoBpx0Hhvr7Qv8J6TtBjpkK1ofQ==
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

devm_request_irq() automatically logs detailed error messages on
failure via the devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code.

Remove the now-redundant driver-specific dev_err() calls in fbdev
drivers, as the core now provides more detailed diagnostic
information on failure

Pan Chuang (7):
  fbdev: mmp: Remove redundant dev_err()
  fbdev: omapfb/dsi-cm: Remove redundant dev_err()
  fbdev: pxa168fb: Remove redundant dev_err()
  fbdev: pxa3xx-gcu: Remove redundant dev_err()
  fbdev: pxafb: Remove redundant dev_err()
  fbdev: s3c-fb: Remove redundant dev_err()
  fbdev: sa1100fb: Remove redundant dev_err()

 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                    | 2 --
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 4 +---
 drivers/video/fbdev/pxa168fb.c                           | 1 -
 drivers/video/fbdev/pxa3xx-gcu.c                         | 4 +---
 drivers/video/fbdev/pxafb.c                              | 1 -
 drivers/video/fbdev/s3c-fb.c                             | 4 +---
 drivers/video/fbdev/sa1100fb.c                           | 4 +---
 7 files changed, 4 insertions(+), 16 deletions(-)

-- 
2.34.1

