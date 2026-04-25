Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0E9FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F89510E51D;
	Sun, 26 Apr 2026 06:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AUg2tAmh";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7AE10E094
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 02:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf/uXjqNHcpVbQ9x3bcaKtW3bbenVlJMd+6yq9SNXZyxKR83gMLiHtUtFkxVO7FTPxMgEYBadisc6E7qw3b/gup4flKzRkS+94MlwFAIkAdK7UPnWQ3qDkPWD79x6msOJESoLfKLNQXjewxhMib/abVBZCgUmZsQ73Cy/1C/uN1VCA3TcStRkg73H5nH5XLknS88yFu9LHjghyDPN8h12CznYjBRFs0Lhgf/jmzV6m7PArl8Rrw18Yic+J85flMH3/pCgDGPpldWX6yIPsDiR+03EK4Q0O3vkA3W2cet5zBYmzZPQrWAJ/u6SIgxo2aUmiA+gUWDYKLVBwXSTXzHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CHlwTuyEYwBBYMf+cTtz+zZGRLlT7WAwF7EwT/wu4Y=;
 b=ih9r25JRWr/9xy0dH7iUtlBkIReVFkfWFFjH5VLxSTESzSySjp/3h0D2pAruYC7LZxJAW3/uhLuzoB5+LXdHOZ3VndaTMMmR4UWVTUMnUqRd/islo0eEHc9dph/Jon8YOxl7tX4m5hOs0g1JX5VZ2PswOgKfYMZsMuuznMcdiWZR+GqZh61QNlrpQdFylJkzRrvw91dtu+ohmZ/NqLxHxw6JLaiGnqvFGzaNCEpALZg2gDOhVTXOxjh6e9vjCGrcedGKUQ/f1DJz6/zm4NtZrlp4fb4fOZNEAs2sH1zchOE0XwblqjqJl0SqsYIP8aBvRCfG/bbx6fW/vsv1GsgBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CHlwTuyEYwBBYMf+cTtz+zZGRLlT7WAwF7EwT/wu4Y=;
 b=AUg2tAmh5nUMlLzLEp0mSXS/rFsNalhBfUW3b0YHrZ6ZfqSSOrK5Nm7sqcawpVuuAAoDAHY/Wx/3VgLZf4eKM7+fyZSZV7vANJ3PKN7YHkrlVvlZExlTevtDCtDJDv5zpuriVFTEe3xkrvB3wl9pvGXO00/+sm9sPIb0sFTsuN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY3PR01MB11951.jpnprd01.prod.outlook.com (2603:1096:400:405::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 02:29:43 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9846.023; Sat, 25 Apr 2026
 02:29:43 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: biju.das.jz@bp.renesas.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.madieu@gmail.com,
 John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH] drm: renesas: rz-du: mipi-dsi: drop duplicate
 platform_set_drvdata() call
Date: Sat, 25 Apr 2026 02:28:57 +0000
Message-Id: <20260425022857.2382603-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::18) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY3PR01MB11951:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd6660c-48fd-4cfb-1052-08dea272823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4x5sRf7e0Z3Os58VOV62Rilvp+0lTQDPkZ+8XDE0xuvqwQvTc9XI/sCG0sXt89OQVQgCOesye0xv+m8C5gVqp50Z1/Oqfg/WON5e3SkBqgWGyzxGWRD4woiv/PuRz07LzGHPKCePjnwYVhs16a8/pVI6hqOLPiSSLJrkA1BctEoOpOWWfIZxd4D1LGWhtkHqNI+fPPv+BDmbFOBcJ3u/deeox5BU7FA6+8OpP+9ajdt3cxIQc6h2CRKC1W8MAprhanNlKJulz0qIKFJlkTP0+uuSc/juFYpoXN8FmQoUjH+X0kLO0h+huFRcgUC1l13d2ZY/RQzcMNTu7tAkMIOEHAXc2IosYm2QNyx1knWvAolxG3Z8FrBXa2z6bUuUbrPhB7EK8Y61AxnVvb5duRplp4cI7gbF446TNigmnqC43pG9sFegERbRNXERsdLGkF4EWvoftAygbCyPpqQFzIxvpqzumKLlIwV2S2jpuZxwszC17cgw5aTeb1OGwJn+Rb8SCJaZAN+O1VVI3taBqaE2Pw7gFwqo478c3XVHJXxQfvqPK8b0VNoOpgxfH2TZ3CiFoeM6+DbFbwRkYnj5CXlO8GqfXGvKBW5XZ1UnminuJDzn0gxfRhaB6WE5SkIxR2VzMXIZdK36sDbq3xRQ7aQBBZo6LegH6/L84Cs2onEMPnUdLPqERTS7cOQgSUMXNxiQ9VAbXVR9DeEbBvKdoeJiypae7tfRHvdvStcYdSuTgVB5ofOByzFur1JYFZh8nf+2K3bjJGFrXAx3Nozlp+QYQdIl2RdFKkjKH2nGC83ZxIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY6PR01MB17377.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CpAyQJcX7uTCnhOO/20ddWeF9kgnj+IowKZgfPqmoUUepKNPrmXv89VzQxVL?=
 =?us-ascii?Q?szALQkJL0mszjEccI1GwEnHMMdw56f3DHdNdjnEnuwsrC8tiNmur+162CFO/?=
 =?us-ascii?Q?03z4ZfyNNykRNJmFdZhi3WUIJgWElw8KGb8DiKeg5YTPMX+ANYViFEyjD1dc?=
 =?us-ascii?Q?h4/XWUkaEyKj57pn72B9vJoQOg8PGTzVk/D6CTZ4D5Jv2GrdcIYSamig/mjl?=
 =?us-ascii?Q?YHGTPc+0e7dpImUYONt1CBU29OH8lztBD3ADv6+xYc3wgM5/0mgPPFvQK7Jg?=
 =?us-ascii?Q?1n+kJZu/2HyTvWF2AJGsC66zOjoXf3Dgf0lqAZHgAxWdiuEHHQfhegyK8/Ex?=
 =?us-ascii?Q?6aQYOrQ5f9uHmu+f7K80rpYBF7eb1thRzEP3roDLb2+HFkei3X7H7jva/9l7?=
 =?us-ascii?Q?AcshlUp2KbizIffLN9nlCKDiItrcSgbJZjTOkqvU7mPJDNjinf2t6lJHveKK?=
 =?us-ascii?Q?roied0H51LIR3YYm78uxVzqca92WXoeL2lYRoRzbzEVz4/tnIx7xJEDpqfxP?=
 =?us-ascii?Q?FHNL0oLi2KBnzkRvMNityV5Kmm6oXWvbF/wyOzKJxH3ROI96ay7w6D44YsCd?=
 =?us-ascii?Q?XQ85Ftr3UNfqkN7x/iZanOy5GGBYVKWfehj6cnxPpzZeUcq7hifHruKBftnd?=
 =?us-ascii?Q?Ez1fn9dUY7f5dnV3oKMBsDZRGejzC2eXKqnSBULUjj5V6XL2Gb82j0yf0IvL?=
 =?us-ascii?Q?YsHKR7GRZt4eP1wZtzPU1jhWdu5+7RCtVpYX9WjXFJ6HWZnUyi+FgCVWNSa4?=
 =?us-ascii?Q?siO4Zk9gZMqd4yieqMNCMLxiZTiCtRa5ejekCbKLhbwmqx/CQqKFrfcoLjvl?=
 =?us-ascii?Q?HX9AdabIUEd5KZC4sv4yNOafZk15kQQpxrdRndfGT4m5opMil48UzMuKGNkA?=
 =?us-ascii?Q?1P35hke3A44WjOZ6ZJUNEZMGxqRGsW20DJf7bXf46JWFCRD46S4PaxmoBZNL?=
 =?us-ascii?Q?P7U9zm9YKmduCpMloYvMtxyCkO/isMnQmu2VsfIRtSi6mOBsxbPkPWfWc6Gt?=
 =?us-ascii?Q?OaNGe3H/cuXP+VtX+/b2Ul1HvBsR7gO7Kgamt8QbiQSXiMHwcScuRldrRSzW?=
 =?us-ascii?Q?YvUN9GPqTIJx0n+REDWF4OS4ZGcNymbuJPnV/iH0acwTPWPvMN/ao7X+zloF?=
 =?us-ascii?Q?2do833WJ8HEFBhnThCVncRKYTu2LVeUHzV/2+qOEJF8pM3uvmxRvtlcgWTUm?=
 =?us-ascii?Q?eb2LZBn0cdvp8AslAre4gTMvuwm4LGDBTHZOSTKQtq3mwihwMS1QWcBOhIKP?=
 =?us-ascii?Q?OxqVZiJPCFWs3ONgex2meJSKuaHqfWeVxScWdOhH1ignR/+Br1vs1dt3Z5yw?=
 =?us-ascii?Q?W12SZf80huUPdJgoJNgM3rU5olyjyQj88/BDSvw3i9lL05a1kGT6nYaSbfZ4?=
 =?us-ascii?Q?mLX5brVg72f6/AUOA2tLQ0fE87hn+NFs9XpkO39fYqJP4pIJLsi/uoEOKBpu?=
 =?us-ascii?Q?87IMuf5qf84KPdB01wKPg9bL3GdEmxIensl9em9mEJnOKU1hPSQ3bj6pbtmU?=
 =?us-ascii?Q?5hZAAxwPO2U1gba3+qZivY/jHRTrIcC42C+7/OMCJHmZo79KRWCc39GWUHFp?=
 =?us-ascii?Q?GxzUoJ7l8Kbbj7zRBu0Osr8cE3m+gKCgHXobLoFZ9ky9fAllv7ZeanyRBN1t?=
 =?us-ascii?Q?kqmOq+pG925YHArG9LWWKhLKQoU/Tb8Y144QF3ELkTTA4k1sxIXaunFODdhY?=
 =?us-ascii?Q?wE226v2cTDC99TEmoWTybsLYBcEe/vrQl8w/19mL22dNJYp/sz6ATU7Sol0t?=
 =?us-ascii?Q?ozAgtG0VXjMOb1RqQdFQTugMoSd9UQ4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6660c-48fd-4cfb-1052-08dea272823b
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 02:29:43.1734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEInsjiHEB+9S+kKBbfYPByTteekVN+Q+CdOriIrvq4qcylvXMCmFchm3iQAml+c7TxKLny7PMbSPrfUiKGPiIzjtr4/POic81ayhKN+bJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11951
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:47:14 +0000
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

No functional change.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 0b4861824319..b8527661a409 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1441,8 +1441,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 		return dev_err_probe(dsi->dev, PTR_ERR(dsi->prstc),
 				     "failed to get prst\n");
 
-	platform_set_drvdata(pdev, dsi);
-
 	pm_runtime_enable(dsi->dev);
 
 	ret = pm_runtime_resume_and_get(dsi->dev);
-- 
2.25.1

