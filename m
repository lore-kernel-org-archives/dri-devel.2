Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71170CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C776610E80B;
	Tue, 13 Oct 2026 12:55:33 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013004.outbound.protection.outlook.com
 [52.101.83.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D000B10E80D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:55:21 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=P63Nf0DbXathCalncbucU6g4h6EK3rtq34j7jhySuaUb+K8xHJ8eJFsfXUG/3nISr6L5xnx9pnciK8krXOwRz3pvcHs8qIz8MLhiDliL3D0t92BW8LIMIar1FYgTqKXDVdozWZtN8AQGtPBU104waYjSROIIkCLLIA/pV+K0woBAkuWtGpzRzN66zfBgHyp8S6f9gjwf3GY4Ni6CeYLi1fzn2AstVyQpw9RjXOnshyY9F4SMvzt2zodjj/wGknIJNxT/fj5shzqp48h7hx/L4RUPpPwmcJX9LOU43r6ohNP+40d3ComKZWXkQYr6wsiAIoQhvbbZtI6CYnWQQuhYjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzuaweuWKy1KTGG3wKk+LkNpZx2N7+dDI07MFR7p/OA=;
 b=kHgLafgpiT/vcONl4mrCkVLScR87io+0XskfT+0Jvc4gss055BI603nELunyq+mVdUdVWMT8iEqugNcqdVjgvRw5xRAqJaLAhtpaGGh86XFZslvvwmtgJOhw2LVYnfMNw7XhmwD8dsnw2u4QY/s+QxVw4/xarmu01y7IBKS8iOEMBLtKoSrX5XdOv7tEYM9gwuwCV7RRUoNzI9UP5IsMJ9LhSkK3D2+JmzC8fXJnglJqx2BGa+s8KP5KEMXRgKLYUpks3hX2UbjQ2ud4i7QuQ9JW2CuPsqSdjNwRRNJxow8ttI7CPUMyNBxead6zBzeRoNh4SkRAwoYpklULwcCSSw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzuaweuWKy1KTGG3wKk+LkNpZx2N7+dDI07MFR7p/OA=;
 b=SpXujTSvgrDQXep0U12FCXC99QRcNKBIeEIPNGdTBPDBNuOAO7TiW+kZkVGAQAJvG7loNA6qyEUKYvSOryjEVjy5SVl8U2N8YdnJCkGTvKDLGeVxD2kqJWj7WNjVOlvv7U7FlOMjUtph/4VrLBJYaEGnftN3H2MT09L7pDa31nY=
Received: from OS6P279CA0067.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3f::20)
 by GV2PR08MB11955.eurprd08.prod.outlook.com (2603:10a6:150:36f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 12:55:14 +0000
Received: from WA1PEPF00009B37.eurprd05.prod.outlook.com
 (2603:10a6:e10:3f:cafe::1e) by OS6P279CA0067.outlook.office365.com
 (2603:10a6:e10:3f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 13 Oct 2026 12:55:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B37.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 12:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv0yrTvwnYK6ZAohhsZIkSnFz7bcLHkFONhwrs2QoE3DICWDZ+vxQnddE2P7MAwTft9dZemJqMO+qGNvXrlJRNiRNcu8aJfcNV/gjUkW7IBPK5a9tcHWrOhJmM5ErX3j0mdC1eQyYfSzxxPZbaZ067PyxNcVwGMLdbKqGuTpaExICy2AWNiExVSrvTpoBJkV+hU0jXFG3XliXIIqucSAtAMXKLE+lzQN0fdMrQ4nHsy1xSlmSFz0Ie/27rgK+ifHCAPHby/CcrLuqluO27HrqLRZiItDT5cVQ9e7cPVJqJO7+LOoUY4T/wUhvAS3v71HrXaBwaW6A+u8+ax+ppqDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzuaweuWKy1KTGG3wKk+LkNpZx2N7+dDI07MFR7p/OA=;
 b=j1UMBVoAg1rkU/BZ2QWQjDtzdSJRTNk4+ssmnlcm/8HcNsPL4hxZKsvq9hgKRVfJp5J7ULl8q2FNtCfr8bgkLCsbievjFmmy1IbC4Q8dVqjqO1IQwCH+jo2qjSHCp8YA0oczvj7Yv3nEvDiquPZo2MIxCVjOTNOpnD+QjaZQtevUurYasUem8NaS2IGw0Vz6VmuK/b/UyRaP4MC07bKZZVglSeG0ZAMY95dmzzWGSsaQfdLEqpUwVjzHqUFmP/bddtXMNLjE6VjtflcoJmE/oToP5mMJWWuEEk7ybGLCt28dmnm+9L4Rt/OR9XK+1VRE8NO6YDA5TBFHAOd2xzo2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzuaweuWKy1KTGG3wKk+LkNpZx2N7+dDI07MFR7p/OA=;
 b=SpXujTSvgrDQXep0U12FCXC99QRcNKBIeEIPNGdTBPDBNuOAO7TiW+kZkVGAQAJvG7loNA6qyEUKYvSOryjEVjy5SVl8U2N8YdnJCkGTvKDLGeVxD2kqJWj7WNjVOlvv7U7FlOMjUtph/4VrLBJYaEGnftN3H2MT09L7pDa31nY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by PR3PR08MB5756.eurprd08.prod.outlook.com (2603:10a6:102:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 12:54:41 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0522.002; Tue, 13 Oct 2026
 12:54:41 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2 2/2] drm/panthor: Remove redundant
 drm_gem_create_mmap_offset() call from BO_MMAP_OFFSET ioctl
Date: Tue, 13 Oct 2026 13:54:33 +0100
Message-Id: <20261013125433.26432-2-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013125433.26432-1-akash.goel@arm.com>
References: <20261013125433.26432-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::20) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|PR3PR08MB5756:EE_|WA1PEPF00009B37:EE_|GV2PR08MB11955:EE_
X-MS-Office365-Filtering-Correlation-Id: e9114f32-24e0-486a-70fc-08df29293962
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: YybNtsLoNgdIaPzUEmaZeUYO1sKUPbho6VijEvk1nqpPEIOfyf0QjUd7J3BIxUjMnYC0m0GTmooJsTA5UqmcA5lzufvuKIjh1iYfTDQx38Nb+4+sn7Riwh+Wc9uML0ekwFz/ARSU4r1eaXY8jHzyGpcDqslaX27CKeM0TsI4TDbwbEI0hD9jpL1UnuJ01iKP1X9qWIIwcH2nnWMB65Ybzz6MPGEafcVV9a8qZrdJ5v05pOSyb6I4/6QjnwUhLuaiaEvZMkD3YR/5gBbDN9YXcSW4cv83r+9wF169Og8tYLmyLYljh0Jkhq0D+6jjsFICubMWYPn7mfY1HG40MIguSeKyHks+WzUz9qCChBIEXXO9YYgCZc/Ee7Qpcy6gAX8Q8sbr20TzKNSqzFAQ5jkk67jPLZNTBTMlNVicE/U2InMyeKsLsjlVDzRg2VVz3GW70tSPvvYdxINxSq4W6hxNLI7aHlqmGCUK90uHxRvZCR1C3J1J9T42GLpJfN35L3mvIreGKukW05BjcfK7IM014LwpIxaTqb9xuxseKIdcVmzfT6vSIpmDsktlvRvkCQD+UOuFqx3/H3UKX6Rlggm9YaYB/PAh8JAQ8XyoOZyS+pEuRFrEgplpHYOZfsxRCE6y1KDk9v1wV5I+WafoRCDqeBiL2y5e8Wr84gjiKDgHcvQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: qnUgAlPd8jiU29ui2ztXMj0Y0zoleXXNFLPsO3yrzvFiXQ67hWK7aT4TAhKi5L+rLylswyBf0nYbr6y8aLasLW1vT46tpjoTI8whcWBn0S3Id4OYPFLtoayZj6y5h39TA5E9x9ReUTexLXB7zF+9RpSNhbrYf0R78VPkj8r+bHYy8xkY8NPTKmt83YZkCsZRwYXIbN7CoIy5SGbpkxj3S7f8UwlXJgbiSsPVrBr5JLfSr4JPxtRugGchC9j/Xll6Xvx28cX0/hXNcWHH7V3RE3X0vS9BBAFWv9FXR7xkzaVONq4iNvdHSdenj60ScQxIhNCAamlZ/ihJluqmjlShGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5756
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF00009B37.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff08dbff-b1f9-4a06-3dd1-08df292925de
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700016|23010399003|376014|82310400026|35042699022|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hs2mgwjeLJtujQIcLPIEwGWRR5cep4/3NTXRSQFtKUMF6RtCJqz8+ZIhm0p0RHajCWmGKlXb5TP+qV5BwdAd/cbk5wo/clSyblQ8pMeRT7mhmIGGiFZTQRBOx3drd+fxyeVwKz07KJeEyE9toUnF+lGBl7GXxJEhZDVIeyrSMblGN0ATSQp4auOQfsIlTi6PuTgAEdpun1VOo2qYeVIDLM/7BKZevxyULeWCpz6kChe925DpWoAgdxtUwmsBXg7zOq6pOSEiVD2D3KMnlQZ1FquhDUPI+EdKlfkXvyqvris+M/1131IG+A0hICFHyu+QEcUKWTwo62B7GzTBeQrvz86nHLuqkj1LWzi5g5s/6gSXfPcwbrxbu8818ucACgY6wzQKDqS8p5YCmAEcZw4LJQl6jozpEkOV7N2PAopTdTRIYobzyeejhPM048Zg8vgZGFv+9tuod6k+TZ2G45/C0KuC2ORA8znB7FspjMIaDSVe5hod1xpYrMcszG278+JvVj/kcQZI8oqGJ4YYaFb7RxYYlSrM/lrd8IZYA7EhDfR53KBjtbGBlKI9xBgUVwLu3/vCIo7SVwDS7JraIIBHILaTDgVAP8rarlW2XeKexQh9Dv9ETLgemmXvoZfIzQlzdoB4a+aHR52mROXa7QA8AtTIhVh7BfOBlJ6tRmvQ2FjzmyjNJRyUiReEWFG1BZfDKrCb95gAIgDH54xAJqd03w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700016)(23010399003)(376014)(82310400026)(35042699022)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gjjA9mOfOJfii8Fe2zj9GZbbN6k9/85aW/yeFAUruLcnJEWa3ZVH/hhPdEtbA1NQ9sSHHUQ3XcemkJNcDkdhnYTjgDwek1AxRYU50EUqTYvDb2uDcccyqHaMGsBcAp+ddCj9hXP58vRAHRZjZB+2D5x+8iE0Z4WVmGCnwTEF033ddJn1TnaOb+wyAR9qgp91tFDqDn6MPb3WD9/Mz0UTGmEPbU0rpFgIpOQm4TPRYZVcDTuBSGhecUymt0NVb/ue+2iQ9j+y8QKJ2QZFGwC5H2hJEGLuMV7h2ickPm7xq0zgm7vVJp2lA1WP2iSAl+jSLYnFmVuVIWVNarbjU5nX7wEKZxk8VPiseMixarmAYov8H+kYR4I/cnqHQl9XO7x+KYFf1SB3DGyM2zKW3fLWpMfQwTcyv1jQ28ovtM0voHGEsVZ8KtW+vrRrcn5bbfL1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:55:14.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9114f32-24e0-486a-70fc-08df29293962
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B37.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11955
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

This commit removes the call to drm_gem_create_mmap_offset() from
the BO_MMAP_OFFSET ioctl handler. The call was redundant and didn't
have any effect as file offset range is allocated unconditionally
at the BO creation time.

v2:
- New patch

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 1ca8aedd83f4..dc8d0191aef4 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1081,7 +1081,7 @@ static int panthor_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
 	struct drm_panthor_bo_mmap_offset *args = data;
 	struct panthor_gem_object *bo;
 	struct drm_gem_object *obj;
-	int ret;
+	int ret = 0;
 
 	if (args->pad)
 		return -EINVAL;
@@ -1096,10 +1096,6 @@ static int panthor_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data,
 		goto out;
 	}
 
-	ret = drm_gem_create_mmap_offset(obj);
-	if (ret)
-		goto out;
-
 	args->offset = drm_vma_node_offset_addr(&obj->vma_node);
 
 out:
-- 
2.25.1

