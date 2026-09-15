Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09E5C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8AB10FB79;
	Tue, 15 Sep 2026 11:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TGMnw7zX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TGMnw7zX";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4380310FB7C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:10:37 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=igTiXFkJY13uGT8i17BtP0gqBwaSAN/vqlV04p9Ax5nSWtfzL6iocTNeLz+NvPeGOurMhTLXJ2LsDTcP6S8PJvf80DgYNXYLpKFGnsnjH+IdQKGJ1/F42Ei26JBxq5gNlDypYYf3wgAsyAN6Xo9u0/CRExKshnWF8ZM0zBy1jC9t1NmLv6beFUCTK7rD5B/BQBXYyCaxXkT5Pc3owjt0h1f2Z3bDQhST0izynyx8jnoTUuPc3lS+nbzCOkv4yarhq+bguVyEEQnZFXLCY7XHataWYhVFYwMBNhrw4Hz+vRRKio19zmok+zObj9UWhrI74EuBAJMhLbDgGeSKOWNxYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh7Wxu0t4AImasviJ9S5T/myIIEuOC+Gw0qAYpZlKDA=;
 b=x/ASq36mIdcyNTnaeBYdtq+om0GCf9zMtSgHFjmrfYd6CqRdJ1wPC9bNNiCc6hPzLvrT2KgtY+h+l0Gcbz4463hZTOJH0eFpXWZW9L2aDshQGrazNP5EXUg9BcavXTuQ1obkJtvC0VWppBUm5UOoSE9g6Vp4ke/s+1yP45P8DYPBXKu+ie31MUihA6tWO7sbZNvIuuDNKpGt8Sxwi+AJtuOToiBRjxdJwfbH+rdN8QUMiJ48pdEUkEmMYdoBMCUq59kpLNUKdQAmQUGvVeWC7fyjxJq0zk0a0ds/TjG+P8WppTgQVaa7l0laBcq/fTttnZt+gWBD7ciZZC1FDG5v1g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh7Wxu0t4AImasviJ9S5T/myIIEuOC+Gw0qAYpZlKDA=;
 b=TGMnw7zX/b/vax/ATlIeWJ2FMUAnJ+W2BddS90pR9fvOiBFmcUztcgeBDoL4p/Ak6xS3JH7EGnqTlHBfFUL53atl/7VL60wvnEOG6pU5sq9Hb+JPznkZm8pq7h/IOoPwH9ysqV66q7O33HMgzZASAL/UbfPE77m+Qrw3fKsvg1Y=
Received: from VI1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::30) by DBAPR08MB5783.eurprd08.prod.outlook.com
 (2603:10a6:10:1a3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 11:10:31 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com (2603:10a6:802::4) by
 VI1PR0102CA0017.outlook.office365.com (2603:10a6:802::30) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via
 Frontend Transport; Tue, 15 Sep 2026 11:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 15 Sep 2026 11:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwsB+g8KjJ85iASCYgDrsl09bXUyKu8MKzjkxb3B5xrBtxcVAwJKYrisFLqqYVvozQ+WWEhVQpHblT/lyf5CiXjc9/FjiLJxct6ovogxn3PUuWkBgH3vgEVwHPaLld0UAXlkK6Qw1KFirGaCzvHBKskCQCiv/4BtFQIsZt7DfTOxZ4OIrjCeXE6VEycm9nceOGmWCj6we5QpePE4xEeATMNgDip1i02O5VP748pA7Vy4d2qhVzHcH/y4ozuKg038xF498d1rOTaqayt9Bx40s++/76Ek7kswcP7prQt5F69+ykp6b2iPHfn0CWFulweDqfLxev8CWL+lGw5xc4e/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh7Wxu0t4AImasviJ9S5T/myIIEuOC+Gw0qAYpZlKDA=;
 b=md0tOmD/vsvnkhHIWPtAGyh/AgVnpyae56h4YEY4wFFldX4WnvhW3g98xg9T+UVvscdkqmVYlkaNneYTddDdE1XacgcgkklVOyzwKN0OJYbXDZhUW1N+Stm9wF/lQN00zjYprg/+cgmjkU1MttvfUUrWdoKwmJjklS7ZqrHGadyCvGvCXo8hBCT1S4PygDRywHzMxSTNxmHHPgOgDWtH2ifjJNLicepaT6h+XO5grsvCZ0surhYZiO9D1Kfhs7TXW6M4Wrea07Q78LTsHyBXK+SyEkjHsAvZxAYLN7GZww/7Ba7tTaKoC1V2zVQii5k9uEf+sUb46fJvRV+1U+eLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh7Wxu0t4AImasviJ9S5T/myIIEuOC+Gw0qAYpZlKDA=;
 b=TGMnw7zX/b/vax/ATlIeWJ2FMUAnJ+W2BddS90pR9fvOiBFmcUztcgeBDoL4p/Ak6xS3JH7EGnqTlHBfFUL53atl/7VL60wvnEOG6pU5sq9Hb+JPznkZm8pq7h/IOoPwH9ysqV66q7O33HMgzZASAL/UbfPE77m+Qrw3fKsvg1Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AS8PR08MB10151.eurprd08.prod.outlook.com
 (2603:10a6:20b:628::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 11:09:58 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:09:58 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Tue, 15 Sep 2026 13:09:24 +0200
Subject: [PATCH v2 2/2] drm/syncobj: Use scope-based cleanup for
 eventfd_ctx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-efd-autofree-v2-2-06d2c9d1547f@arm.com>
References: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
In-Reply-To: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|AS8PR08MB10151:EE_|ZR1PEPF0000E461:EE_|DBAPR08MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb9d67c-3c5f-417b-5b09-08df1319f477
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 7/i+TYe4Dtk+loLIf0fwfi9OGvnKYMgK+2VFwTjzXbEVy9BCdTodU1TIFSsWuGRRmxhKsDVUhGOzzUSdiY2lM/heM+1q8Umfg8DINoc5eoZD8q8U6UaYBa2PANoClR8QoKI1MX37kOVNJ2DIF5zC1EHalR/zRkj5BPM+EueFl/RFUkbwbzHWOSAcvSCXVbwUm1UiTL8ITxkFZS64s0sTVatJt2JPaBxPD7tYSsGdHZ00aMj2udX7hgIOvwcYx3chYmyYw0ruOlNI3of94cMVCkD8B3cbut63CtyNlRHtuSSXBs5TVzlhPo6H3t9md2qZNST+LgwxMBypKrhOZUxZ9X/uWqcPrPVGTEEa6n2aPjIBE1l2A3xAHSixO17nL0f+kKEN/FKtdJyhXu405OaHp5a38fI+jI/XWcwUukGzwBJPL1qzh/rR52v24m9tHmXtC82owlYeQ6Q8OgwlN82hT8k/mDTiWHc0tsoJHKl09knwqrhMH+5Vzkmc/ioT1YIou+AasabAxgHUqqzdGDureRHyvkoPfzJIpRzkb5obRXMP0AeL/mZxXBrIxjPNNBLVec3RU79+meFNFZRz9t4NmbrG2AAxMNqG9Ws6dZDBIyUh2dBoKKP4yNZEZMeebBYmmyo2vcW208PX7UwWITrcSZPdWK7u7LayXZ5hXvmQ1p0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: qZeKPtdFyQaM9b7FCVcxo+WekHcfwAkYYDCQH+5LNsGmPpTs19t73KA3KvQALKY/2k5oyyCpahxcESB9gtaspv2F4ix5uwO6tEI4SraJdYCRk4V1+o41fwayYjb2BOJezqT8RqtBPVHwqAR2Tm32BeKFkHZLbPQi3J2P0poZh0Tph5yTMnde3FwjP9K27GP7KVZJ55YGawEoptfFN/ZUDYG6tkj92EH5g0uQpNrjOvQCo+3ziB1eRhoQLF9NalqsleaPg6YmL/OfFF5E9BH1m62hS7oQXFJ3+V3abwXiDz5urRQ0rfOtgM862GOC3I9ApopBXhEDy+5K1PAxwZwA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10151
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75f8e3f7-054b-4f30-0905-08df1319e0cf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|14060799003|35042699022|82310400026|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: D8MPkAX78Yr3PxGnIeapZjbWIMwvyItS5HIyj1hKX8SjaNQ6NK8K2kJK+I23cMaB8gUzzy+KR1FtZb3E1G1Kn1ejDL0DKCuf1avv+pF/e3s2n3VIHNMjK029YnhsKZ5XNuUnU1A8BGKMlG1DxW6JzOWvFQivh5Ln9cp/VuP4ifz3WBc1pDxKovnmiOdQbGaB3irD25XnFBmCeuzc0rZIlSbO7LUcQtGqlwfX8+CXr6QjsmWjyOEkQGXp+vgeIXAR5tIUfP790ohE9iKXFeMAnbUydOq/7YFag1Y5JRPQIw0eMO5mHck60IYkZdcr+OexQG+Pdfk/Rd0j/TFeaagWsE8gQGJEA/VRZTUTmvzq5MJFL+foQAkgGDlo+gKj2UiwJgJlNxZEMAMB9TfZH93OAmVx7rnXtLohPZBSG6FGPFBp60AP+Be0nBPiYCNy+jTYLrupBielygfn6sIr2/+JmkBvFQ6tbdWzmX3B+JvkwAh1BzIRAcmnZu0Xlfm1UkCrDUp1ZTYm6E6sCQGmW1XAw78AkaPUPpgb/tTAKKklE0nrZRcDNIt1skkuA+RR2ARo2fDqr//kFS/LcNyPzXAZ3nid1Eviph5KWP9DxYcnWT39xQCHERABGZRNrlolghkBlQyeUpAatE8OXYyf4U1xb3h/cWwKGwYIq7T5b59NR453UN7rlnLqqn+6pc1edkuN9et580TIkc6n87WIBep/6w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(14060799003)(35042699022)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bJXMO/n17Uq94JilHV8JYyk1Yn5hc5JkO9mFfilQekn7w+bk+0Y1qUW6PdfLlGf+7JmhlrwJXbQV8Ld9lQKxLGhKJs7S+Kvwl6alWw/9eXTrtrM0uW4DAJqn4+vunkDD6iPjuxSOGaYKmKn1/tbAZ4v6lmMKE0ltFyJBY/k6wJ4FpCU05wWRpRXznWHE1sGS0Si4XXPO7y9cVPRWnlLN4AvX0uwqaA5VokyC8SRaKu66Q/+byLOSVZhpau6cquyskzKyiePFYn3Qlfr4Tn5OogiFwfhs4za68mib1UuToNpOyuUC1A7/C8FFIgfb4ipQqW2gZ7W4UivBUx597WWJ0Z7Eu3Ix6LyzZYN9Ow1IQeUeVJCa7vP4BzVLTNv+UUIVqugPNFvzfwRfzQV1SK+c2TlvhfXlcn8SwgOpICqFi2vQEXPDqEarUnfmacJoDyUA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:10:30.4906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb9d67c-3c5f-417b-5b09-08df1319f477
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5783
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

Now that eventfd supports __free(), use it in drm_syncobj_eventfd_ioctl().

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 drivers/gpu/drm/drm_syncobj.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c23a5de27eff..efc4e8af220c 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1462,9 +1462,9 @@ int
 drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *file_private)
 {
+	struct eventfd_ctx *ev_fd_ctx __free(eventfd) = NULL;
 	struct drm_syncobj_eventfd *args = data;
 	struct drm_syncobj *syncobj;
-	struct eventfd_ctx *ev_fd_ctx;
 	struct syncobj_eventfd_entry *entry;
 	int ret;
 
@@ -1490,10 +1490,10 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	entry = kzalloc_obj(*entry);
 	if (!entry) {
 		ret = -ENOMEM;
-		goto err_kzalloc;
+		goto err_fdget;
 	}
 	entry->syncobj = syncobj;
-	entry->ev_fd_ctx = ev_fd_ctx;
+	entry->ev_fd_ctx = no_free_ptr(ev_fd_ctx);
 	entry->point = args->point;
 	entry->flags = args->flags;
 
@@ -1502,8 +1502,6 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 
 	return 0;
 
-err_kzalloc:
-	eventfd_ctx_put(ev_fd_ctx);
 err_fdget:
 	drm_syncobj_put(syncobj);
 	return ret;

-- 
2.55.0

