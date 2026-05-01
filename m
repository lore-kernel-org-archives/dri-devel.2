Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F9EFF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E4B10E146;
	Fri,  1 May 2026 08:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kUVli+jy";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A586C10E146
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 08:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnGpEexZ6Nbq02slCmEJEHCLe6MoLRVD7aSNB8UQN/8kJnC5mp5xgHnaWGHelq779W7bQA45QaE8Dn4NXOnz8Dv7SF0cS1h5WofC0mkyCl8VxzqUrjv2U+ACMF+ettpwEo94mhbsnMVA0S8SdNSB85dqTz529I0yXzAzgMxnE7y9EG5k2A7Ug3ckCDw5+4yfn6IeAawspQbWvwMA0UDi0qT0nYbnr9N3l0QrDc8Jik9HWFJ3m+P2AOaMImHfRL7SqD6rW2Yq55EGhocOepsRk6AC45uMorJyoNNvWfr21bfPKmXRT50qx5rDPeq7Afp9SrVDySqEAzhWqiAuuQLd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vBf83+ueHBXrNb+AWSR8SvOWXJrCgiMnQ1i3XctFiY=;
 b=CG0V6GwZU9UfIVvqrakRzXPuo/elWYj/6JrUcJmnOcIBVgwuoh3yQ4cQRAS7+uqL8EPO9KlSvv6zsDh2IuhWCcYge5AiRBSJZ5Qaq/1fNNZBGs4b71byOV9V9h9LxLX8sy7jr7s26yTugMFJHPYZ3mTcaqsdXTgY/j5+pCt3wKIzGVIhqzhP5acTToeqfdZI89MSIRv5z2ySprKQ58W3ym8ZJSRk8VmXrHyCVar9AHEfnBveIt8V/Sue/Lzz3v1HQHV+GQ0+u2G3vlOf4c+J5exz8xwlCLiAC2/HglFNjRVsnae2+/9Tl9H7KXJSTOhXMo4U56JYtJWo+faXqGJM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vBf83+ueHBXrNb+AWSR8SvOWXJrCgiMnQ1i3XctFiY=;
 b=kUVli+jyM0E7hY8tB8qfQkOoT0JEQIsAegNnXKVew59vc36uTODxFprWdXLhl4ox/vufWLVY5RkuRdTxJdBGdCzwmfiw2HKuu5ZwWYhHGT7uXhp/ILX9kXYGGD9LJvwwzfEVNVvW0jobGOSZJiCHYpDMGHuaoeaXDX8SphsIN0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB16984.jpnprd01.prod.outlook.com (2603:1096:405:337::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Fri, 1 May
 2026 08:09:23 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9870.016; Fri, 1 May 2026
 08:09:17 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: biju.das.jz@bp.renesas.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.madieu@gmail.com,
 John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v2] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Date: Fri,  1 May 2026 08:08:18 +0000
Message-Id: <20260501080818.955914-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::8) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB16984:EE_
X-MS-Office365-Filtering-Correlation-Id: 927a8cbd-4de8-4737-b5bb-08dea758f051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Jj3JuBKq4B3ikOM574AFs+sw2fhzQlPJOqJVJ+HjUQnk4PQ9YQo32808lbLlbP8zXIfxDAOi1QNNV9hKdOqubVsBa0UqbFyli4K2oFW6nwPCrqrInVh+O8Fli/x/Qao51xSZLZK5NoQ8rfagR05bVGPS0tkxZ0nKQ71NOlk35zJE/2IKjrNMNk7jNwIE2SgB8S+FLenSitTo1tR2wPzSF+8GXFSs/2gnjoaHJrzOfB5rBQhTObmqwAnGJUwrOuY9rp4rO3D58wj4Ah1p9aRO/r7AlyFRBocOLQLXw/ur/sCEbU7DlG1YNsZvck4puPIY/95yaMReoyU67YHS413F9gSLKQd1NZOV1Z2grF0ZtR7zGwINCEFF69Z6ELugJPNlEKGE8oCnjVr3aWQGRG86anqW7sOQKvbK9x26GAytWYf52SmwnYuTMbAsW4U/GmbPXqNulWty5fgVtCG+E62u8AQgPUi7Bs7TupoLbaU/CQShEUGxdo6i6o8/gj6dqxWa/adzkdA8UiLm+5VaFVkBIxju9u+Hs5TDvuDjmeBlWaW0Y8uG3vcTKUO4cVA4BVKZ+pg46HgjGEh1QTVqZcMyyJy/kowmpmRk/CxpT/3xPsHiKx3v6Twlo3oBEUplIJ0dk2X+NcsT91Kq4gzBp1QJxF+zbBNak+Mas1pC55i5donYwrpO+J/Ue7yB5AVRdPjHfaIBlaVVLyNxY3zwrjsglbb47WtJy5vnSoo20sktcMVx27iw202dY5ZcDSiz9TS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY6PR01MB17377.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ke24jewXqGScUW8v+oaj3ClD2Jexy2qr8iMH1wpIkdKqFCAVzy5Mac1dcNKw?=
 =?us-ascii?Q?ey9bJVzF8KMQt/j5xdNq1BTEzWliFgLtICVP+YDwmspcqxUboDp0N0oA58aR?=
 =?us-ascii?Q?k2eT/IiUpEM4reeYywm3RpR6B95dwPzJwJGu8R0MO3aruOlXYC9rnDZJ06B/?=
 =?us-ascii?Q?GlpSq2k0Mqwxz7oQPIXjKrVRDKrrcNO6dldOvGEVK5NoXH3BoP0xTiG9GeTl?=
 =?us-ascii?Q?BoZgVSIVvnqC97kQcFhL4WsEiliqxxyUbzNk/u7jxkkByZLVDlOd4JyRLzhp?=
 =?us-ascii?Q?fQ6ts9GWy6OegSor31Q0qpfPfmtJ/UyFkd93YrodfldpdJZs/Y6x1hbJ09pl?=
 =?us-ascii?Q?Gx7Uol/cwpE+SFBG4tFcYeQ5VkeLcBrWnuOkw4Fndx0wprm1a4infkch44US?=
 =?us-ascii?Q?oZyPcLMASs+bae/gaaAY1lXxKH+fqkHHUY2pdTwjmOO8s9aXvxPYG/4fVahL?=
 =?us-ascii?Q?qdnGQAy0BCw34S6NdOWP0XZZtx2KgOpcPirnj+Cu6SvgxM4j3qCSR3QLenQ/?=
 =?us-ascii?Q?dEF59q0e5/AcGpzEBILLNdafQ0G7Sb1YRRkKWYve3HUTa62BJbrgTjvHOtJa?=
 =?us-ascii?Q?0UxJkZ+FRxI34ZtOjnXZspWa5Ys1H0ZtdVl+LZ0CdRZIk4EMFgR6qB6hV7Zv?=
 =?us-ascii?Q?I1hD+mt5MC7YUJadMmkchb8tzFJ+7lFd8nvk+MclMhs7YQFuZ6B5WwoA9YQV?=
 =?us-ascii?Q?IFHIQxGBbhgLadkSseDE0TSzNJ8IB5ejygsHGMdo2y9Q0y4QePqW4eV4onKD?=
 =?us-ascii?Q?uoc1T8MARey3OyPkOWm8XpHneX8WD8BTHcelQK2WFvIgMwKM3C62BgPO0nWD?=
 =?us-ascii?Q?JPgZzqYXpA720U/33uOzS3xFojvQor4GzA687grcwf/GDyLSd2T3//CbgoN/?=
 =?us-ascii?Q?rnzKKxGyxnlFjN5wK37POWL1od3Tbh0UvXyV6mEF5oTJJlUnj5cI6TjUhcFo?=
 =?us-ascii?Q?dbRnkKYoAvN3Z+2dut3xn/HlW32KyJDjAzDfGKIEA9Sd5w1+Tq0bgZCJtEje?=
 =?us-ascii?Q?gLh0nRscbpbmxWuOK/G92ShVxyq7oQ9faa5JiSiBfi0Sjt3apBWp720kXjRm?=
 =?us-ascii?Q?B+U5RFo0Y6dOoWAMbH7z6DsZ6uVoHgfy4bWmysIlocHL4w/ejMThklrjuEAe?=
 =?us-ascii?Q?3aw0h4MJvSY3dCMcMe0GaaropirN+dz5pAT6PHQloKHw42Y0SndWrOyfB/J/?=
 =?us-ascii?Q?MEdH63Eyo3/mJ8P/VIUqRnt3lconbzA5sj57aOy3VAQqMdpwDXwK1kNeQUPC?=
 =?us-ascii?Q?1R3mNiGKB9dapL8YTjZdvK170YTnKGX5ewNwB2q+iTmQwtdtvBEzMXu2uthk?=
 =?us-ascii?Q?2LMwX609XU9qti7j9s7ELVSkq5lYW6HcpJzZT8ScnME2KtL911z+quILUPyG?=
 =?us-ascii?Q?7A020jXkxpKa1hhgbq9DZA//8AsqMzl8e4/elYQOgHbKSSR9YIuzCpdkAztb?=
 =?us-ascii?Q?2WyU8qQ3L89Ul+d2WY0K3xQw5DYbHFN1sJtooBnr6kGlZFbKVYN+f6jyeDJK?=
 =?us-ascii?Q?mzWC6E7fS2bIzfmgCC9UO8v4FwYLozZtTZgHQrDJaD8EjvR0XDX5NlvD1FYW?=
 =?us-ascii?Q?e4+NeHOoiBWmHZuOspi4Ryfua7prqOup5TtiuRklVrqCtkIwTb47YaIPivVg?=
 =?us-ascii?Q?hwzB3aZZAl4jtaPw/dW2T/21OBRFFqM0PuY8uNAJdTDaldmXTTniTGXlm+/1?=
 =?us-ascii?Q?6Ve3I6s7sdtKEBBlMGcb5+JMYPgERsopYPA4Ku7lrIfn2QgwYq2UrmPwryEh?=
 =?us-ascii?Q?saXmfWqWFB8hePCQ0x0b/LFZFuIZJJw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a8cbd-4de8-4737-b5bb-08dea758f051
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 08:09:16.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpDzfj/0dtENT1N/KA4tCkV4K2gAPmUXn7YOV2hkLAh+WatVu94eGo/hGjcpPTsCmlvvEWkDcdJhovEX//PAcLL8bvLfDtOG9+npZlJtPX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB16984
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

rzg2l_mipi_dsi_probe() calls platform_set_drvdata() twice with the same
arguments: once right after devm_drm_bridge_alloc() succeeds and again
after the reset controllers have been acquired. The second call is
redundant; remove it.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Change:

v2: rather drop first occurence, leaving the appropriate call
    close to where the platform data would really be used

 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 715872130780..32616e5bc591 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1406,7 +1406,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi))
 		return PTR_ERR(dsi);
 
-	platform_set_drvdata(pdev, dsi);
 	dsi->dev = &pdev->dev;
 
 	dsi->info = of_device_get_match_data(&pdev->dev);
-- 
2.25.1

