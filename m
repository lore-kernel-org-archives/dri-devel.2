Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FE606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KCzvIWZG;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KCzvIWZG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E303A10FF0D;
	Wed, 18 Nov 2026 17:54:49 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011011.outbound.protection.outlook.com
 [40.107.130.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF03B10FEDC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:31 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EaUHyWN6XYiT2dOwGK3PwYeOwI36NSfbMiDeFun3yq4GpgTI8bHacGv08rVldTIbVbwFWjaHyo9FebbbZoy9Gz3y3s4B/JzvhojxeP/dQCdunEhUJyoYXX/xDo4b3bl/waeogOrzyG8SHDPuOcWamLrhT/bZ707sln7UHaKbwgDS7+SrzdHPHxl7Lh95bvdH0niFgqdjkCcC0ztbyZE9txd5Ugz3h41Ng39YDFVvw9pmTAvViEWfl0RAD51h7D3NKd1pQkUCo1t0mvijqH6fjcJMKEiesE7tnOa5RzCelA2F53oDsjdtqvY432+D3zILDO0FfMdVhAgnp/MIEYFb/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=SO3Pp+MNlximESVQZyngssvhzNKC/uVDt0FvCLr95tPJCS1cKbNZohwuiMPUHJIVw0d79PuVf69bhzGdA8IRsDoyBTpt8QbQcmxYSt1szzAkypyCna8/73s/R/hqvevts0h6pjZ7yXVGEIC59lHrhbhUvZMbOUI00pYj2CvNI4QR/trkdwBTMBLb81oRL1Y0bfuSGfVrpiwyGSl6D1cqgRLSeX/lWdVjArMO3pTdjEBPFL21pTMXM4O823ssV/jFU5o082UjxCVk7uVbnu8f94hGnfQyiDJqimzJCYTf/hfuLvNkXKKKu+vUbjrla/jN4OFUVBN1tHAEu1MtORp7KA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=KCzvIWZG7LHk11wOLStXlmMuq+yAg36QefHzj7LY4K0GC5/h+us0Jii/shWETy7N6g30H6kBQ+dyrCR7GCOkLbnyhs01g/OoxM0/hUphK8dnGOgm67WzFmFxyRi42nzHTr8WJpffdQS75H3vrkADIAEu4qVy1XFmpICZo+oogyo=
Received: from DB9PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:10:1d9::15)
 by AS1PR08MB7659.eurprd08.prod.outlook.com (2603:10a6:20b:47a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Wed, 18 Nov
 2026 17:54:25 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::77) by DB9PR02CA0010.outlook.office365.com
 (2603:10a6:10:1d9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 17:54:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukK5eFErBRbyI2/JuZP7f7xeJ7gVmGAlH5mmkI0dTz/b9QlAx6dh/sIHGJoGP/ne1+1TK0GPoXHtMzNXirKzS+yh1JMfcGeILNONcwm90lLVogn1cZNTKBhBp9xnZ8dX+JQ052FpcmXSHQbH/iT6S3BFKQMl+yCF9L2N74t0puoZwA9TWUg306H9e+b2y5GOs5NkcOxqsKl9iEwDiMiy8Y5Ac/d+rU9ACYbsuvriOvPOCyJPJMkJdV5izf0Gptq0I7hKVOQ+wM9/BR1W6H5YziI5b9k+op3KOLkhOoP8NGNYGrUFrfWn9TdATIL9yo+4kUTDxES34sSXNHClqbsH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=XbD37wbx9nk8F+JLNh7xkggcnhBiiKRaSvOFBnJSZ8Vzkh1C43ZP7bM3Mb5I828wi5qz0nEUCU2/wInEV/9ftjYEAKhEB5cdZMKEE9Ioo9Am6zzOUBWPHAgMZHXSJYaxdqVR1TjtM8nI//n1UfgOXSd8LGjtS7Uvvz4vsJ+j4pRqqiPTVzaQNAoNKtyVUu7IRxGtmo3UpTlZ29enQUJINdF81XnHvQQse132glE4rjPpxcNSBbu03thj4/eHhxTs4o8YbGCS4TGOIfY9xI9i6SqL9y3ZdMzYIFuXNRG3mR9Bqya4teEiNolbhVrRQUOaHaHrw3DzsXdCVnJvWP3kvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wTt0zivYWqEqEdo5ISOvTvk3YqZf6VG5dJDRXhEmdg=;
 b=KCzvIWZG7LHk11wOLStXlmMuq+yAg36QefHzj7LY4K0GC5/h+us0Jii/shWETy7N6g30H6kBQ+dyrCR7GCOkLbnyhs01g/OoxM0/hUphK8dnGOgm67WzFmFxyRi42nzHTr8WJpffdQS75H3vrkADIAEu4qVy1XFmpICZo+oogyo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:53:51 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:51 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 03/10] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Wed, 18 Nov 2026 17:53:19 +0000
Message-ID: <20261118175332.519657-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0502.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::9) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|DB1PEPF000509EF:EE_|AS1PR08MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 400480e1-12e3-4367-e0d6-08df459cfb72
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 5KDZSd0uBSgfwmkFyRhyOMoNt07n2eao/5iuyBqliNEILqq8nrG1fBmBDI8m2hU8CBDcIcAM3H6wXXw3HFWq9fMXjz4rSKliDb7O2Gusqyj80otM5mimL7kFn20j9HlLiY0gORZ35fD37J8QJXMvOtwpydK4GehjOCcH+YT6IayAZWNg5toJI+54m53KGpbG4tbfuG6fmmqHYMv1ZNJ2NK8snxoJwzwjD5rsKUXTaauxSw9cmjIAWeINwcFYgL2ts7NrSYVQNxAzrReemVD0dCpehUMSp8jHkKfKswjnyKA5W2Ihn3XIUV1Qii4B2I22aFlZInM5IatlJM/qKYL/e9BlWEcgLEK49QOnxSvwPB0yrhMPHIWipzYqRRti1KRhvNKaz+Kb/rvj4yIPkyfchZW49XKBXtVXRTti2WstTl08OLhc8kZ7pd5Ye6ngt1rw+80wdb8Bpe19/R8qvse1pAd2Lcb6CXrNARFIL2RZ8ORmWIRSEv2IbeQ6obXB9/6oNQzb+a/6OsnYeyK7BlDh6c1W6FwT+MQG9CgmwavjguMwAPjmOpSuxb3nYZboT2+258TMSARa2bMNQCeGBvnWL37SGYEAnezgcLazTZQuR+I=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: z5CIb7kuVie69UhRqwCAZEiYve/1vPPeOecJ9ap34kPUTDv6Q3Yc4TabgF4FykZ3FLLJA85JKtkcpPIr8Av1ul+cI7QmkCjn3F96zKU1t86KPhwOh0O+dJlKRMNo6sFaq1gZyeXD0EDjgzCY3vo8QLIkIjMjsEyfqR38iC8CjdpTXL++KD5b0BQDjhSLrQ3Y1HhgCe1Y3YGAMdlpXAd6A+gsxwrFNFoCXqNYrTsx1otd+hFn6bQ6m0KCH5RP8T1WDLYxBO2LzqCsDugGDPCsKEEhAeGanBxg1DDN6zu8ts+VfYhxIR0I6DGIyZkkPuqvNJ9doMrBfjJX5+ly/1GFbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e2e3aa1d-c49e-4f95-9bf2-08df459ce7d9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|35042699022|23010399003|14060799003|22082099003|18002099003|261009223027099003|13003099007|11063799006|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info: MyLJm7rmCAvarCIMtanlGHZa7pO6tcn4E7U2BW4cFOH/N8SwbzRdaPmOKJ4EqXWqlv/HVBmPmoxUVjC0dfB+pnybEUC+IfCsvQS79yfr0AiIK6G/C87KLfQ8L6Czm+biKRdgbAzd70sI8Rts7ml5/RTKKAKr1Sjz4sX46h/jrXMFOmCzoMAablRM1FmHuRKrztVvZS5yVtBKkLjXrTWSbW4Pb/W1MUAW1PEtWFnl1Ccog8kGGeaPtaR505RK+ubQ8V9taehOBP64RF8nl+k4qkYMLFxYfqlNZou/tFluKPc9j2DLLR6yegSfg02eHz4iuNRUDUliIa+82TN50MjeRSDd7/QwEV1eZoJZfOdd87e40BV5K+kTLbPdyrj+NolYSZ8yX5PjlAMsDfeunGEXajJJ/z5+T2gFF/6i4PJxnYs5Pdrfmii+U4b7/OKC0UneAZBGkdZcqA5XRK/MN3XfQNfQLxGraoV6glaP76a3iVAv3dE2O4nel+53vX0xx/FNeyMeIqbzclRG46AlKLqcoMeAoywdqGxVONqy/ythptUNI8/34soXaTzJ/goZQyQE5egX0VGSGZdWtlMMsqbOxhG0IPkISCWKzY7V0pNwHa8NKp7DxbrFrhNAZH8iAprF5jaIwPiXgBOvf9CVAh+NWg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(35042699022)(23010399003)(14060799003)(22082099003)(18002099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IK9ALYJ+u7r5DXoBJO9m+4JX7m9v6Gg0afj5h+drbktT5+QnF2LFC76d4vWvAXxSEpc3iyRIWVJ7q4NNJkdE+2jE0WZrnTiXR47ZNBT+jE82N5NygU0FT/+yt3OgU0klZGTdEA2fXMQxQITSFUi8OGNKWXDwp/Z0o4nAmJAiOUwjps9aCcz2o7piS5bTp7VnhQIQYI8THFtb6JuWlkgC5b2Wqupl59WrrbRkGOsT7AGo1O+rmVaV4h6S8iI0Z5u/UZkarR4eIyeJYgQRGxpNJFfmO/CHoD0b2FJRge7jerEeYn7HuSlAACcoxc8xeYoMCMF75eoHOXE8/qwdA3IOR3mc5F+cYDU3OD7vrzr8RwOg/rHy5fajbFNDpbch8J9X4Go04kZANimQCaeC5YlthufONrUGQLIQSFw0axleIIaOPSarj0hYzTghjSniOy+v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:24.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400480e1-12e3-4367-e0d6-08df459cfb72
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7659
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
- Fix includes raised by sashiko
- Link: https://lore.kernel.org/all/20260922205441.263661F000FF@smtp.kernel.org/
v1:
- Includes "panthor_device_io.h" directly in "panthor_device.h" instead
  of peppering multiple files with the header.

 drivers/gpu/drm/panthor/panthor_device.h    | 73 +-----------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 84 +++++++++++++++++++++
 2 files changed, 86 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..4add31b12cfd7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_device_io.h"
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -495,77 +497,6 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 0000000000000..ce417c64abb44
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/wordpart.h>
+
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
+
+#endif /* __PANTHOR_DEVICE_IO_H__ */
-- 
2.43.0

