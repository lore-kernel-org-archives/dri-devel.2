Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FE5CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0AD10EAF2;
	Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=michaelburch.net header.i=@michaelburch.net header.b="NH5sNoQx";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020078.outbound.protection.outlook.com [52.101.85.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4012810E0AD;
 Sat,  3 Oct 2026 19:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7SmHwgh2Uo4SwYJ2NVLahsYpj54kR6fwdx/IpakAqzuWKnavBQ0KxsTRXF0OmBJ/sCu3rTURHkpuMztiYoBVjzclynZqfKQ+RVPqt7XTgayhMoAtZanOzHMs0C1ogKYhajLyDJyarK4cq82i1LduWQ/vaZqsx0AtBYAqD5vNrpaa35EsR+d04T6YqFCuJAWLSwgg9xBuj7wxVT15s7p5vbVXasgrJkCxKkME9qtHHqF2Fr8pO33eNfppf+QAtWymtiELGvgchlkEd5QVWwPzi4dmM97S151uhfFPMfSFJ9JxYSc7Ll22g0TPIxEAEHGrYRWPG8c+7+WvlCYLQnvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acwdDDgdzlplsPPveHz2f/H3thDUZtn3jfohH1efzK8=;
 b=CwJBGglztssXgfx28Z/wMpx9sMkNMNcsvTwfdUGCNMBWc8Jfhw4ehBxY8gIMvbo5bPem5QUPEiLf+icK55Po57GOC2Dzbr64mO+ooWZZoP1BSvNIwl+hEoNB6tf/M8eXkznhtAhgBHQiQGk8UTxdSw3RaLDSKLaDQ27ZyiQrmziLi7qdsjA6nrRJcs9Tm0KvQx56JBARgyGZmlZPtuz3kse9Cckgg56lW26hQwCCL2acok8g+8S9LKvU3FJRRXjmEt8AkmtoQrK66fDH/aeFgXX8uIOfWPvd+Twq530UrKwl7oZqaCMQjMx3UIA+iB3xOA4oHqKpw88tPXUOTMoS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acwdDDgdzlplsPPveHz2f/H3thDUZtn3jfohH1efzK8=;
 b=NH5sNoQxOGBqNE625OmE+WUrvHcmdVYsrt83fGqAIJ+xxvAsfFITMO30CQMhrUtk28p4rmxPOH9X7xke7ZG7srJYKLmKP1PAigqM+2ADbABEAVV6vecIk+7eqk8jYsyqkSM50d2IKoF9P53vlCBG79YwRmQqNQ5b2F66gYW/cJl4JnlERHHav7YJz6IPJzdHrHeM/oHJKKQAixTK+YWkLpbQyBeaVdgpoJSLfIboU6YXMOy08VX+dMotecqyngOiJixduFTRschdAUlwG8b+hcs1tw7+KGHpN01PjMTlxtKhhjDozluQ+wnBVC8hNkHxTXiyKW0KIENRgy5afRf/HQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 SJ2PR01MB8529.prod.exchangelabs.com (2603:10b6:a03:55b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Sat, 3 Oct 2026 19:35:27 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 19:35:27 +0000
From: Michael Burch <me@michaelburch.net>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Shivam Rawat <shivrawa@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for system poweroff
Date: Sat,  3 Oct 2026 14:35:17 -0500
Message-ID: <20261003193518.13811-1-me@michaelburch.net>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To PH7PR01MB8123.prod.exchangelabs.com
 (2603:10b6:510:2a4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8123:EE_|SJ2PR01MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bb6ee5-1738-4a0d-9125-08df218579eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JsretGg5Ls86qNpMsKDVdv7Wi8nrGTrEIdrprmLe+4pUqUsEjYGI0QLwvuY2C/Uy+0mk+3lnPrCg9gPYMBvWdKSQ0Gu4R6Ortcrz8CPmpUM5hQn2KQb0/lu45NxF4ajdr4KYpZT3uinxz5y302xOr/B9ts86iHbeE/dX3TI3XZHWri7imMhsS8MxaiuHRHH1wIa3AreYt/h0cmVAUhiABWQrAnzjW66jssdRkW9qYdIwm+SPWqDhmAlvoPfQ/ewIOb48zKLSMT562+Mm4aqFPI3YhK9t51nsbMtJWkbXm8TJ0mnnEF54vnjOcLYOZgJU1pB0qqTDqDH5yngnVHCQv/T4XpSWI1WI/QXQAYrl/OrtgqYcV5HOQelpAjqqDfsqbeSk3axyQDLbhDfEHJvHUTxUXDsA4sV7gjOZvyo4uq8kG0hlGF++zDA8s00cbDUC1Gy243YkWu8i2Vognx6eRE5yKAYR4Zd8ZmLwjCwa/7Of2tFjwzJvW2QaeNSDbc1rD2p6hC4dT52vNMYraHnzn0idCR1fQycFrYUPh8xlJMoXBjUTH76gThU9V/c1QycaFDAW2vsWsfwpdfnJtoAU3a+dZQyj/s7MUh3jZHxkcPQJnZOLDtLqvdPsfSP7pz4c814OIGZZL2i4WVwRHk+AFRBubzC1SzUebNGHhh4Sw1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR01MB8123.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTAmHG99wv0ugKLI+tdCCY+ueqm2XTmYyxH1iTxdbQ3slBTg257YBhXfg5Qr?=
 =?us-ascii?Q?sl5crTktAZpyL7lSeeRknN0cm2UUdpyvB5vjicsd3AIYOgnOBA9qGoZaEKvx?=
 =?us-ascii?Q?fU2RWkYc9nhYy/7Hrp87SBH0vYe10rH8dZyc6+paf7bGctxUzo+NBeWaArwe?=
 =?us-ascii?Q?h7VNzXByBgOSyO5wQQc6YWDZ8Yw6ziBaDh+n+x3xM8smBFfYy6MR6qzmECqd?=
 =?us-ascii?Q?Wv/ZK1F0pSmldnKS3vJTjwb7eSNFe8VjmrDjE6yJhU/mvUab0sU2nseo/SP5?=
 =?us-ascii?Q?eOFqpQdp7pb8eUjY9dSKRqJbp15RaLd9qblErDRkgsa47+XoG6oNVtGnewDl?=
 =?us-ascii?Q?tpB1zab8VOn/uo6SmKfmJH+RRDn6cx1uJBUHCNLR4qUU4hdS6DQ/Xc3s+ro3?=
 =?us-ascii?Q?JNvW7c9mZYfgXLnegJmtLNGiEHeZv1XXYEc5mlezgprn97Jz75uA/ZvI+A5V?=
 =?us-ascii?Q?V55160qNiaBeb+s601a/VCWacUHlG/1BAMqn+P7IxjXKvgv3ImPCHzvDjIHW?=
 =?us-ascii?Q?MPhy3+Hf+/bFjwcW25dW63PmAIerit0QjJxxaXhRHu/1UbkjL8HE6imNXVas?=
 =?us-ascii?Q?iY+VbR3AzfQypuxm9WVXEGXqvSpyJCXElsLc71MozdVPGmcisGbFKs53/x0O?=
 =?us-ascii?Q?f7ObSG2eOwCP7QNEFQA8oBu1zKONRrvN6593mvsL9PXaMKGsyUQQMq4J3AfH?=
 =?us-ascii?Q?kRy3EGohzeDUii2bApayGhNx5mqkPk3yXQMYLWsMd741DIUYklc8qfZqqVw+?=
 =?us-ascii?Q?1Sn2VavQjP1P8PtwleKmL5mrVjwWu6cyF1/f0GEvv8yznPA2fEI3aRmuWgZ+?=
 =?us-ascii?Q?bC0NWSd4+m+GR8OeT9xPU0ZDF8ZkpmsOG+2oc0zlp9E5fZXywbPLueAkBauO?=
 =?us-ascii?Q?ofHsdYCxwSKboq0UdMnkRvtWICBE5sc9MIwEuo+O4Vq/PelT+VYdEN4Ov3/Z?=
 =?us-ascii?Q?CF/UXKrvGuePsQ7jP3R5F2FEZNychEBunEXXwgGUaxWaxI4lKebyPLoAC4XO?=
 =?us-ascii?Q?QtdFlepxAyFaZhmlRAOL9VTz++LrYbBca1Bp5EFK76vuZ4G7zEyZMzxaChWw?=
 =?us-ascii?Q?Qwp7uWRHwHBee9wII3EytvmeKFwKkZjqlblUpjIZsxHUWJPxmR4PwLOOv/2A?=
 =?us-ascii?Q?Vvm0k06eM3tMrrsGlttbwRwEFpupdyFO3CEdKyR5wPZl4kYqt2M1XgtJabdI?=
 =?us-ascii?Q?ywdmo4lWWpfE1r7V6B5FkrDQE0Y9tfp952NBmFHu0xDqlK5SGHsYIf9pXlLC?=
 =?us-ascii?Q?AVnf7/UH7GYdVKHcNSfxKkNDH4zoKreuwHkp+0mtD95VmjidPM3CYCsaQMcZ?=
 =?us-ascii?Q?e36Zy3iIEZMrDbCfktn0Lp0lwJ5ewtFHUSQYddK4CUBqeaTTryD8NgzV/oxf?=
 =?us-ascii?Q?lIrJGtakzy0LscGEI2D5Gz8e7gEl7xLflBY8HAKxMBkKLmoN47HspUev/+89?=
 =?us-ascii?Q?+rEbjLZ8PNs3j4dasPQTprgPwJgvb9+qck55qyWEEWy8COaEqC/i7RW4lF+Q?=
 =?us-ascii?Q?f2fntIeYsPuxO5wpYrnkfr6uurVdZ734rHn1WHFztDJGN9wMyxlGvScBXXH7?=
 =?us-ascii?Q?Ihrr4iIi+4DNq+MWFuRnrg6Cim+Si0DbiTmNBe8s2Ilb8+BaK3wBN2vfDvlT?=
 =?us-ascii?Q?aJOTSG8TIjgYrY+gmY/YjtblVKGKQDO4NQikXRZRUFD+tKe23h1jmeVk86wr?=
 =?us-ascii?Q?qKH/byHei0hpM3uV4ywDnAw6FS+LZ+RLbPbKXHq7CtZEJvifFKrkPXljQRHe?=
 =?us-ascii?Q?VBu+1Q/bJg=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb6ee5-1738-4a0d-9125-08df218579eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 19:35:27.4535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jujpKFgJwbIQvkwOXe4Aj/Bh67HsJqxCNds+dh/KNov/2Gtuh/3CFp11+rZvuueQAQsC7MrOOF5i8HCBFuEhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8529
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On X1E80100 (Dell XPS 13 9345), commit d9108bfdb746 ("drm/msm/a6xx: Fix
stale rpmh votes after suspend") appears to turn poweroff into a reboot.
It seems to happen when the GPU RSC/PDC is asleep at system off, i.e.
when the GPU was idle before shutdown. Keeping the GPU awake until
shutdown avoids it.

Resume the GPU in adreno_shutdown() and skip the RSC sleep in the final
stop. Suspend and runtime suspend are unchanged.

Tested on X1E80100 only: poweroff and reboot on AC and battery, and
deep suspend still drops the GPU votes.

Fixes: d9108bfdb746 ("drm/msm/a6xx: Fix stale rpmh votes after suspend")
Signed-off-by: Michael Burch <me@michaelburch.net>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 4 ++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6d49c51df1a2..42a96ff51e5e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -645,6 +645,10 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
 		return;
 
+	/* Some platforms reboot instead of powering off if the GPU PDC is asleep */
+	if (system_state == SYSTEM_POWER_OFF || system_state == SYSTEM_HALT)
+		return;
+
 	if (adreno_is_a840(adreno_gpu))
 		bitmask = BIT(30);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 05c77fe27e62..224ab3fd14bd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -290,6 +290,11 @@ static void adreno_remove(struct platform_device *pdev)
 
 static void adreno_shutdown(struct platform_device *pdev)
 {
+	/* Resuming wakes the GMU RSC/PDC; the final stop then leaves it awake */
+	if (dev_to_gpu(&pdev->dev) &&
+	    (system_state == SYSTEM_POWER_OFF || system_state == SYSTEM_HALT))
+		pm_runtime_get_sync(&pdev->dev);
+
 	WARN_ON_ONCE(adreno_system_suspend(&pdev->dev));
 }
 

base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
-- 
2.55.0

