Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CE2C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873210F402;
	Thu,  9 Jul 2026 07:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="TaIJxib+";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023118.outbound.protection.outlook.com
 [40.107.162.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C9210E686
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aThXt3/O12Nv3RE9aHrgeH964Z9N8XGbI69uX3SQWjY5isVb5puhVB6Y/vz6ItFrSi6/L0D2pH4zzMpr3LfNtfNyO3u9Vh2r2I/34mgeNSMHOiwpx6qCg47YCiuyBwsWcunxjxmhhAb5wSNJSg09nnCpyc6i4VYLwJ9nNJ51IPoPk5Pp4M5VPB/0W50izAK9zxoymV2AnBr4O+GH7PuPIarS2Vq6Y4ff4lRGysnFWmT4iNRywt+km/bb/CbeDRT0PL3m8/9X9Vue8DIj7wrA3gv60u1O0+kMR5hAI8SugEQIfY/+m62LeZOeXFT2vWIM+1VzpyVnEszcmmNxDJ2/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhwkfsHK8Cy3Sxy/zFSQa2cb14RZ1Q4GNBFlrQwh7ng=;
 b=lMl0+fa4C7nitSgFyMGFpQJUu/DBIBhwk0BD2+0NcTjHAZkC8Dvw29/OBxVC3YF5/O/gnLgYeMPREKDXWcpSBvFGmqrkbnQOB8FDyV9rGQ+fkNw03p/BhzkrxTiINxmNi7p2PpOVZI2XJQppRY93DClIBrAXEMK4teDZNEORXvIsFuQh3eUx3xKduvIRFu3lpKNmpoGhzg0LVLRwizRh9K8iu0OdIWoh1YgxNJ+qMSGLOwa8+Qt+y5E/gQHEDTA/b4nlFfYimxWXed01oEZK2YWh2Q0D8+ebQmRf1eM9WQN0BKobgvhxXDYjRusxx1Mytq8+umzlo0aKs0ebpFBH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=ideasonboard.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhwkfsHK8Cy3Sxy/zFSQa2cb14RZ1Q4GNBFlrQwh7ng=;
 b=TaIJxib+m6dOgB4gzSYOR/4DRoGDZZCTj4oVrrW/g1mqovJuH7jmv97OzsCKVlSusJmay6U3LZGNriR7CDebwYkjN/4YWA1QsUnYCFb6gzlAEaNWOjJ37xa+NATTiUHzGWZco4X+6bLwOD9BeYc3lIxtjGs/ul+fXJKNY1A1nxE=
Received: from AS4P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::15)
 by PR3PR02MB6476.eurprd02.prod.outlook.com (2603:10a6:102:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 14:40:13 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::7c) by AS4P250CA0013.outlook.office365.com
 (2603:10a6:20b:5df::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 14:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 14:40:13 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 16:40:12 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Mon, 6 Jul 2026 16:40:12 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1wgkUW-003tPY-20; Mon, 06 Jul 2026 16:40:12 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <paul.geurts@prodrive-technologies.com>
CC: <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
 <andrzej.hajda@intel.com>, <dri-devel@lists.freedesktop.org>,
 <frieder.schrempf@kontron.de>, <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>, 
 <linux-kernel@vger.kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <simona@ffwll.ch>, <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Move PLL initialization to
 atomic_enable
Date: Mon, 6 Jul 2026 16:40:12 +0200
Message-ID: <20260706144012.927962-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260430143542.2279584-1-paul.geurts@prodrive-technologies.com>
References: <20260430143542.2279584-1-paul.geurts@prodrive-technologies.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|PR3PR02MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: b73e6686-1545-4324-0a62-08dedb6c7d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bvrwAZP4NwJrYIhElaq4e0rpgY6gRR0ijTBIjE1FA3968mFiI21PfSKMj+T1JLwpeIrPdAY6+tqINeOS55dfPZqnQGVi5n/R+B6ty77nuxz9yaNCiZgjjAm9JW5lunKnsxNe59zAFPTX42xWpgQE4ZUjjPR+e5/PLadPH5bBytD2q6d/nIL4B/InQVGaXgzvYIaydcnezpoUUV19JBTT6aVYbtxGh254z9cvmEkiyNHWRjiF/0TzabNPWXQmtuDA2kjF6OhMf7LXlYKtCKBKGxlBpFbE6zDTeI+d3TKJ9HaIIFVIVNzQXAhn3w+74TG28E5R7bDW6OWu/R07kjD5efz0f4/DwkUCYx3h3TkiEkXZdnBZUbIIRlgbCA77BOUL+iUyPal2e4uUKd7Rn3U75Uwx+o9Pk9g7mZKSRXgd7s2/pMbPDxpvEvfQpk6TZqvgCp4/NuHCGmO3DadvJdq28P9Yx4gRqzc6tnx44EB98tm8BQD21zXdvMGHJnXSzpr2o7TgS+dMVt9ENjwbfS0uUN0mvy0mR+Hi6TPyGWJQAdsrPgmCjQXgPzdtoxwzps8qfdNXcFlDLMJmhUwwL4mDxQXWUOpElhqXXlvQM/lN/CndU2/+0t53X3cMCO38QWub3tiI/8/lkf7Ig4J0SRp2QBXsNZzr6L/OKlVmuJrCRMt80PMOaY9SppqR46yhs439MsXvB9zMWRIPK0niCMJXlw==
X-Forefront-Antispam-Report: CIP:109.94.150.189; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:webmail.prodrive.nl; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uA2Q9GEaS7+CtOA8BHfVD7PJH19Wb/LXW9Rf1UOeE6tQ6twu1xGj2JdW+Vdrbtfpk0lVafIkiJ1TI8VcwAfuFqmrGoNEqIjScu4hkBAKJ5oR2h/97WXQQIoL67s83d8nmC7vkFsCRuA+FkwZzmsNEjWZJjUh5geWpgI9xBP/aQvBeRJnuEvvnWRqflSNf+KwX394fU9iMp9sXBSyyRff0fMcug+ZYZiZVqYtKReJxpajkTFSwf7yDWEK37WvkUmWaE1IqojhkNd8qRRujjSIwmrA6XZAE5Hzj/duGrmzgGVoH9MeeAf/jXOLWobfkx69vbS4gWlOnJLoQeyzimUaAYucHWEFfPuPR/VsFUaR/q9YMa5H6+VNNIpVV+sVH2Sf5H3R593yl9kiUXextj3XLOEmpxjaAl5YOgIj0lJYaJr1JelzFEfw8CP9Y+tGKjz8
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:40:13.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e6686-1545-4324-0a62-08dedb6c7d1a
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60; Ip=[109.94.150.189];
 Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6476
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Is anyone able to review this patch?
Thanks!

br,
Paul
