Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49315F459F9
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F4810E9BF;
	Fri, 10 Apr 2026 16:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SVn8iDZQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SVn8iDZQ";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFAD10E9BF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:48:01 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ca9jA0qkHoTmgqai4pjdVNH1q+2wP4R00YrIZ31x+NyU1yi16r4bxHB7akBiWiXFUTrPlrGbolr4X1CSjlOSsOCbzt/+ktF4vjx4CWgbzEjoPAg6IraZ/IMIERWUELHZc7AFVPzGzfdP/p0t5j5Vkov1dzaq2BuiVb3qqXQuUkuRiWxjEHTicHKicBYGcPmrEeMvJ/wl7kKB4p7hZxq9fS/yaGqSbqdNgbtDajuNLiBmSOp/Bvd83V7/5yEBfgHMxLVdQjO/AhETnZzKapmEUuPaAgGdTr2ExZ9RdRBKuzFFYI832x1XPHmMT0ZAWDPGuwTYdm5p/ycQMU1X179vlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izXcV+hVjtTdiI1kDJMWBsjoe7S+60UQyoFRIDYDlLQ=;
 b=GJwXpd4YREAA8JscVp5dsjsrBpW1mgLCckpOubiCxIYqa6tQhv46TYYc5j50y2RqkFAdi51reEP4WIJEGdmlo0RLryRxenqdz792Po0yqtjr20MHgH8e3WqAx20dhSD3kr/zGsa+aZscwA+0nHl6xprvQAS/fuAJBKSLDzEpswyei9uesBoNVCSvMicX2km0pqDFBCJ/+w8TBsz/NIopkM7W/oJ6iFiwSbdcymgLcyASJVq/BxfIDdiChcY0eB0Ef1hA3m+rxFbTUK7k6B5HZ5kVUAFXAkMZVchpblWfp4aYVbCvRgGgvc4GQDwclRfpFA7jVaHWQA6W4LkgN2k6wA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izXcV+hVjtTdiI1kDJMWBsjoe7S+60UQyoFRIDYDlLQ=;
 b=SVn8iDZQUd5UAVZrU7IARZzzzp11naMJwFIGwWZCXJBsW4F9bGsvQ9v6hFSjyjFWDkwCZMd7l6yPWI/PuEPJQ7gPtnNJC/YgcifWHrWBii9FXRDJts4rWhxyfV0aHkScVz3g6NOmL6lLPiZ9GU1NpRep/OhrbQSEb6vWyGSTTC0=
Received: from CWLP123CA0252.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::21)
 by AS2PR08MB10267.eurprd08.prod.outlook.com (2603:10a6:20b:647::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:55 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::4e) by CWLP123CA0252.outlook.office365.com
 (2603:10a6:400:19e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 16:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 16:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw4QzdsDneGaXAsrN+zMMcmKr54U37W0yF7Vy4INVuXWzzNtwrwEksJJ0PLNQgNl+Qv31PA7tzqwaqSNLEclOjHY2m9y+4XGGg5qPhBAexlruQL9Z0/XRIN1L3+IFAzm9GZ8/D9YXUF7CwERACejym/EDPGQXhrmWjsY6lhhAtpcnYksXdU1N7MEBBFYELyuEjrrDa4dQgRNwVf4ImG5Ansbko9O/xnTdpLhTCR1+8mANdz4Q049a5EHqKKcSndMeCKRAdO0RB81r92dHzQekIycM/c6RAES9p5UlNJZuMdP8E838TNmYqrGgNfjNRisMxr1jYP96uNSRBdjSSQOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izXcV+hVjtTdiI1kDJMWBsjoe7S+60UQyoFRIDYDlLQ=;
 b=k/yb0fypNHW/i6YU9CzRvun/LX8WZSmh+3NOBuHg33g5ZKnbaeQuZa1hfZG+UXR4nD5qwuxyCR+WRtlihiPDzX9m70ANf4TwmIKIoObxPq5GOtd0klO/t3Tc7s/aUpUXsMxlDU5bUuV/XjDOoltiQqrN3uWomKYlZSJFLTwwhWuwfdnGuE9lHHc+XIPchcfVIznT54RbDd9vHS91tAL67SVkZenM6afCC1m91WyX7d5Llhe3R5hmEdaP10HjzXzQXZqnCRhW1HrLF0wMAHxEcLeXBYs1Qo2U9C6nC3PJj6zkuiW6eylK+Iw6FmSVP8hWNLXkE7vfRJh2tdoiHs7y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izXcV+hVjtTdiI1kDJMWBsjoe7S+60UQyoFRIDYDlLQ=;
 b=SVn8iDZQUd5UAVZrU7IARZzzzp11naMJwFIGwWZCXJBsW4F9bGsvQ9v6hFSjyjFWDkwCZMd7l6yPWI/PuEPJQ7gPtnNJC/YgcifWHrWBii9FXRDJts4rWhxyfV0aHkScVz3g6NOmL6lLPiZ9GU1NpRep/OhrbQSEb6vWyGSTTC0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:46 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:46 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drm/panthor: Store IRQ register base iomem pointer in
 panthor_irq
Date: Fri, 10 Apr 2026 17:46:33 +0100
Message-ID: <20260410164637.549145-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|AM3PEPF0000A790:EE_|AS2PR08MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: d5984bdb-d6b1-43f8-4f8f-08de9720ea04
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 6KvOkH9cOpwZjsJxKbReDmPc8tExVEYujt4gBUDO47M4MFYXu2mU5siy/xFn1Xv2Dx+4lTrjdnDHJWyRIc/ttubMnR9MlGcMoRqExdASaLvHfXZ4t6vHnU+l0eqAMZGGCyb+hFz7v34iy4f8d5jRl14WV2/QxObsuFFbjxSmr+gqU6ppkFkKdmpmLtlB0yzAtaUIVAeWMzqyUrN/VCRHAMwBQFmFbZsuZ6L121tfKEbgaebL4P8ya0J48Is9WtmHmUue/uXD7MJ0x2PHq8N1jmCCVcz82I7SCn0On8G45zM8IdR8o1CCXIWqdkcgj6zKzPUlk46fsDn4DaRnbXG74gblkY9ox2LrSvfR5jOLE9mIijBgTZFx3PBo3kcdIQX4RnjXuqOXkQmKuwQSfyiYZqMgKLnbhuGQ42YrfivdmwwylsaH2OGPCia9CkXAcSQY3dff94LcYCwsQnVzNYkoyQUF+Qsdbf4sN7LYw7ZpItURNWA6yTNB5nZzgirszB3prZRAkbsSh5rfcGYEyjcVidaUqccSh1Rn7JhPbxcj7daiwQkwgZPZlj4lt8k/okloylXIypUL0RgXk8Oxx/hoT2Mm302NNLw20BxMstehtPOFcPjMldia6yyFwgJIIG4b9nA57ZpyEFjHRGj56mqw2se3OFNvpUlMvCbVN/vOBPYoibMF5hUtz9b9klMyZRm5iUiZ7uRGWsK9nWQW5MLxVhdssEC/L6IvsqznkTrQMTU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YV26m+znATewHzaPeBnd5uppBlPpaQr2lf4q5oOLVczlW8+Rm/d+zPAgjsk8L9ePVQfPCSSCMlA5IZzPHd7n93oehbbvmScUdIf5PK61jHw6X3fdI7I7Ioog0KOGtqFMcRxTubCykubiUFKvUuHkX7TkG/nRE1lFtCr/a71pRIC+xTL0F7Ff7OKBpPEdU22gbu9f5/UAXx656zZK9k8ZgnKeBc2wLBHXP42oc7sjTe1X7NIUFvU2VYXleIQh4uIU2yq7EtdyB/b8N4I3Gzd2ODwyXlJudHL6csyd0A5oczjLnvMMuKlNWspYOc5KQpdYpFY96NjfhbuzP4z+Lu3t6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 02703918-b701-4f41-cca5-08de9720c106
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|35042699022|14060799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8I+nsHLzqzj+LPl0jCo0B9Som6iJIUYdqX9PNVU1mEVy2xs1bTfkwZiwOnczwCnHtS6Oif8LoVYmUBseHrKHLNOV07KHMpl3RJoIgjL2op2YrzwoTNo5+U8jy/BMDBhyg2ibAE9C93WryAkOEtr69mKI4fwsZUo7is6ZcbX4b3HuHdWP7g/RmxH1/BiPcgcCXCrlVaylbVY6tAV2PcB4njj0orpuNRA/nwiCMhbvuRKtWbxC+rV4qMUIGTt9ybv2Rqk+WnaWu6cwuPwooTTUvtqqXjZD+mX7TXZGRix3tm51KQFghQTVfw9fEo9EYIsnktGYqQp05gsmxUUjENua4Gz/44iMat0gu2vKox0aNJwenyc/Tq/XmT/7wDeNjXvqrI3zI0ogBtAKaU8Opj8kl2avXQT85T0seWckzgVaRb0VFlrZGaZTR+LTnlLVc+jz9egKzgB6Qy9wTtI6mekhyzp6utFzvemmHQ5fSVH4QWWUp0mkciFiScex6ckTENZrEGdaRd4gk6A7AFrVR/t3M1JwZHakLbeIkXtfdM7sbIqLjOO9wE9E7USPIwl9VEuBx6HG3m0uuvOKhDz4E2NpBp0g+BV+c3y2BV8XoDAaCrknxrX/B5/D+D3ika8ASvlK9qdl/bRPI9kjl+z4jlzuhsfCVmAshFCnafYXQFByEZterNiIkYwqIwLzc7BySjIh7t7WnD9AL0xSrOo7Jtw9AdHlWmFxY4VZYkEizHqpyTsDDJo/2BFY29IuNs9Y6rnHQq0K61RDrfpuu3vz+9efbg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(35042699022)(14060799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OrDCF5/6dDzSL+ihub+PUvemPwNiX+ah0JCgtCrhF3lftm8vKJXAtp1NZ71SflenQ7hw0a+BdwlG15dE5mq1SjNn2BTlE8YwRzt8x6jHZerDjCxxJANXhZIi0VhZ0i/xmGhPyVNskzdSZXnIB+shh+oGvHKvJwCENtDpIDj6sQVZiVuX2WOOkdx1318SEKK9SUJUuee7TaRQOfgpunke7jJfGMU7NhNn7bYRNsSplGjFkG/K0EKQ/8v9ez6QGA9mVIl20cTTnRXokdiNQ5XsccdKlLButFxmqnadddJ7eUUlaofeOTa/OJnlXkztHtYMDbudsCHMAB2mJPhw2YNrHYFtGPRx1MupKBM7+ogwdMCOxhKk5qMjowL2X+6K3L35Z3ZPeCPfX+a4agAD5t2n3xZsBTG6mTpjxitsJhHa8MdOtCmupaundmeX/ROmhhjM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:55.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5984bdb-d6b1-43f8-4f8f-08de9720ea04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10267
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

Update common IRQ handling code to work from an IRQ-local iomem base
instead of referencing block-specific interrupt register offsets.

Store the interrupt base address iomem pointer in struct panthor_irq and
switch the shared IRQ helpers to use generic INT_* offsets from that
local base. This removes the need for each caller to expose absolute IRQ
register addresses while keeping the common IRQ flow unchanged.

No functional change intended.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_fw.c       |  4 +--
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
 drivers/gpu/drm/panthor/panthor_gpu.c      |  5 ++--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  1 +
 drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
 drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
 8 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 285bf7e4439e..35a70df4a5da 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -82,6 +82,9 @@ struct panthor_irq {
 	/** @ptdev: Panthor device */
 	struct panthor_device *ptdev;
 
+	/** @iomem: CPU mapping of IRQ base address */
+	void __iomem *iomem;
+
 	/** @irq: IRQ number. */
 	int irq;
 
@@ -488,6 +491,11 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
+#define INT_RAWSTAT 0x0
+#define INT_CLEAR   0x4
+#define INT_MASK    0x8
+#define INT_STAT    0xc
+
 /**
  * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
  * registration function.
@@ -498,14 +506,13 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
  *
  * void (*handler)(struct panthor_device *, u32 status);
  */
-#define PANTHOR_IRQ_HANDLER(__name, __reg_prefix, __handler)					\
+#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
 static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
 {												\
 	struct panthor_irq *pirq = data;							\
-	struct panthor_device *ptdev = pirq->ptdev;						\
 	enum panthor_irq_state old_state;							\
 												\
-	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
+	if (!gpu_read(pirq->iomem, INT_STAT))							\
 		return IRQ_NONE;								\
 												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
@@ -515,7 +522,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
-	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
+	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
 												\
@@ -534,7 +541,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
 		 * covered for.									\
 		 */										\
-		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
+		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
 												\
 		if (!status)									\
 			break;									\
@@ -550,7 +557,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 					   PANTHOR_IRQ_STATE_PROCESSING,			\
 					   PANTHOR_IRQ_STATE_ACTIVE);				\
 		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
-			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
 	}											\
 												\
 	return ret;										\
@@ -560,7 +567,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 {												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
 		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
+		gpu_write(pirq->iomem, INT_MASK, 0);						\
 	}											\
 	synchronize_irq(pirq->irq);								\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
@@ -571,17 +578,18 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 												\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
+	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
 }												\
 												\
 static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 					      struct panthor_irq *pirq,				\
-					      int irq, u32 mask)				\
+					      int irq, u32 mask, u32 irq_baseaddr)		\
 {												\
 	pirq->ptdev = ptdev;									\
 	pirq->irq = irq;									\
 	pirq->mask = mask;									\
+	pirq->iomem = ptdev->iomem + irq_baseaddr;						\
 	spin_lock_init(&pirq->mask_lock);							\
 	panthor_ ## __name ## _irq_resume(pirq);						\
 												\
@@ -603,7 +611,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
@@ -617,7 +625,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 
 extern struct workqueue_struct *panthor_cleanup_wq;
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 1c13a4884201..20747f42759f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1088,7 +1088,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 		trace_gpu_job_irq(ptdev->base.dev, status, duration);
 	}
 }
-PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
+PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
@@ -1470,7 +1470,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (irq <= 0)
 		return -ENODEV;
 
-	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
+	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0, JOB_INT_BASE);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index d523d41e18dd..eeb41aff249b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -15,6 +15,8 @@
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
+#define JOB_INT_BASE					0x1000
+
 #define JOB_INT_RAWSTAT					0x1000
 #define JOB_INT_CLEAR					0x1004
 #define JOB_INT_MASK					0x1008
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index ef0aca2b7532..3ddce35ed8b5 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -110,7 +110,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->gpu->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
+PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
 
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
@@ -162,7 +162,8 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
+	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
+				      GPU_INTERRUPTS_MASK, GPU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 7303b7f5ee18..d7cf5165e987 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -19,6 +19,7 @@
 #define GPU_AS_PRESENT					0x18
 #define GPU_CSF_ID					0x1C
 
+#define GPU_INT_BASE					0x20
 #define GPU_INT_RAWSTAT					0x20
 #define GPU_INT_CLEAR					0x24
 #define GPU_INT_MASK					0x28
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b9f6031e24a4..b8665e447d95 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -584,7 +584,7 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
 
 /* Forward declaration to call helpers within as_enable/disable */
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
-PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
+PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
@@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		return -ENODEV;
 
 	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
-				      panthor_mmu_fault_mask(ptdev, ~0));
+				      panthor_mmu_fault_mask(ptdev, ~0),
+				      MMU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index cc9cf603cec6..de460042651d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -5,6 +5,9 @@
 #define __PANTHOR_MMU_REGS_H__
 
 /* MMU regs */
+
+#define MMU_INT_BASE					0x2000
+
 #define MMU_INT_RAWSTAT					0x2000
 #define MMU_INT_CLEAR					0x2004
 #define MMU_INT_MASK					0x2008
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index aafb0c5c7d23..4f600a6688f9 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->pwr->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
+PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
 
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
@@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
+	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
+				      PWR_INTERRUPTS_MASK,
+				      GPU_CONTROL_BASE + PWR_CONTROL_BASE);
 	if (err)
 		return err;
 
-- 
2.43.0

