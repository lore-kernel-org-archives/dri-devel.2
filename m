Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E105F45A0C
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D682D89954;
	Fri, 10 Apr 2026 19:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gfxT8TFo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gfxT8TFo";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BD310E066
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 19:52:01 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DlBCMp50W0ch4vzmH0rwlWMlJiModyGIY/LrfPQS4/4mkD39Raj9GyaxSZdjnRVHzIthrw2B+9ObRPDNM+jFLUJTu/JbbljADFlWyQbSbTCtO9OJzxbTUwpo6VT9SoW7LP8bEM1wZuB3TxrUdAdlM/IOK4FJifzm0dQ44V3GXqifbAiCxS8WpA+eif2i8EWVZebyzfV0TcL2Owo/yODpYmWWx1bB/yWcsF2hlvcFL/MHn8jjAX15zG2vcWlEnznYIPoozpgCueHbqq7pCV/pabNjnn2hAsbgHBbW5NGtSHzjnIrIsvhwfrCGr+oK09qslfylKsnFnsToZSl/9WeV6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P89yZyTU9mcU42xv1kSsrCU8RQAGKZLHOrDfSi+Cx/c=;
 b=NNAPdVRqzHkg4oFd8n75KyqVZHPURjIgotUWO8CDbK1wasL+0A1ETQmRDDZ7pR+UyOSH3BGaNv7DHmhQO4+Pc53rO2iLxEdGVAXSa6R9x5N9TYTFZWcQsB1+QuQNSYaFcJjRkVAf0zC2FUjoMN81pfjXqvmoeGYd9eSIFKTVdwCR/r7xBNTWxINRxDljfWu4Uk+6iXfQIR23I4XXNt9bXXAFi4GaoK7Q5yztgY1u8tF276X4wmwGFd/ckLjYCTtBy90KtaKMM6l1EQOQRt20PX0pWBgY38Aq4RPB0it3aa0FNvmMZpw5fpxmTlZjDxJnEruKsX6JrfGCaPY8hMxxpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P89yZyTU9mcU42xv1kSsrCU8RQAGKZLHOrDfSi+Cx/c=;
 b=gfxT8TFoNSpl1jYJ52/Dl4Q0omGj4gm3TpK1uMIdKpSy7PAbfpBdXPBA10kzlvSOUgNZLrnKJIlRD7Q7QwFijQME32W+zVQuNZ+TcfI9Yu3nOWujTYwUzLWf6eBCJbLuMjio1+b22JbhmMiyKvEKOSdGS5lE5bDS8qnLNr5kcO0=
Received: from DU6P191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::17)
 by AM8PR08MB6434.eurprd08.prod.outlook.com (2603:10a6:20b:369::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 19:51:56 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::3) by DU6P191CA0056.outlook.office365.com
 (2603:10a6:10:53e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Fri,
 10 Apr 2026 19:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via
 Frontend Transport; Fri, 10 Apr 2026 19:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU1Fgh/2emxutsrUIeyCwGgn4Q7tRJRg7kD+IibdUAk/mRjSdKWVxQCpYAAXVwj9PfgsYObC8nLgZIUogH0EaxZQ9CqWc6ZvJDvCsMhD4Tw5wOjT9wzqjLvlfLcmn1+qocf7quOxf5d96NzM7JRam9f0CbUofXNdLBVG7q3+wDQCT+NCUO/dnuhqh6+ienJ3+mbVhZcH1XjERGEx6UzYancFyhqGA23MNF1Ih24gCPFfmNNwQ4kieX2+gUQ7CB/jJpJ/s6/5ZaGoN18QjwlSfWyn5Xqbfk/AsZQKtm8cuLb3KnXLsbi4XOV2arQwW8gZa0RmpmLinFx67yOKc9sutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P89yZyTU9mcU42xv1kSsrCU8RQAGKZLHOrDfSi+Cx/c=;
 b=vQ6Swmr5u6Pu4mQ1hRUFtqv8vUhMrkKRrpHsQ6wERMH0hN/Uip2pxd2eYrFnO6IepyajspQMphtYtjk1Phqg50VJKFSLFXe4xprXFD9IN7gCzTG+x3CvoSnlSwJ1n1faiapAeSbZziPVanZiuI2N5bFupy7QgdRKsep1ycL7TbUA9tRQfSZUtWfX/UdKca7vyxvch6has4GtDdUaOudIswhr7DjCy4fxhB4eUADc7zGjHN2qsr+2Zjy7lgZ66gaaGvjP/xvqObAyI/RsNmgh+OtS8N5RHtrAe8ak6V2T5RijGrgo/sdEx6wxJp8xK6rzOz/T+t5APodLyzbbNI/hTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P89yZyTU9mcU42xv1kSsrCU8RQAGKZLHOrDfSi+Cx/c=;
 b=gfxT8TFoNSpl1jYJ52/Dl4Q0omGj4gm3TpK1uMIdKpSy7PAbfpBdXPBA10kzlvSOUgNZLrnKJIlRD7Q7QwFijQME32W+zVQuNZ+TcfI9Yu3nOWujTYwUzLWf6eBCJbLuMjio1+b22JbhmMiyKvEKOSdGS5lE5bDS8qnLNr5kcO0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by VE1PR08MB5854.eurprd08.prod.outlook.com (2603:10a6:800:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 19:50:53 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::65b:44e2:e002:6499]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::65b:44e2:e002:6499%4]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 19:50:53 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH] drm/panthor: Avoid potential UAF due to memory reclaim
Date: Fri, 10 Apr 2026 20:50:50 +0100
Message-Id: <20260410195050.687201-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::13) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6982:EE_|VE1PR08MB5854:EE_|DU6PEPF0000A7DF:EE_|AM8PR08MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9917f4-01e3-43c2-e398-08de973a9eff
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 9aVZB8obTZ/nKOg+3QCzN6fIdDmJru6tta3RAMdK16bv8qwNc4tEbQc9MKf5sL5GTK4Gc5D4jjihSv2eiz7NgrDBINHqO34f3UK4JPLomHcdNjA3d6TiAZ7/If/DvMJ3aaZ1RiOQ2dEFHGHvJCsU73SkOVPoEtuaqrs5cVFsPuOzreS9nmELWAM6aEB6Jk5k2MSXmL3Dw/Dnt6B77wlTKmi6/CvFiglF4XJLRo3y/tXNnZB0EeFNoiLzlYXQRtt+EFgGGcKcaLfNa88z7Ej1Q8Y2ocjsA2oLJUfequYVFlGWgYChaw2x50iRk2RxxeQMsOayFlIpWYmAGr/VQQ6xwrMcnCzNJkCfGpOw81qA3qJ2OSOXal5xQnCnzhuQSJnUhUTZ/C3/aWJGfE8tyEuEYhgBLpzRgQdYXmWJenTKp79ZW9q8X80bwoD2o4jkgfEsSTlJ/7/15MTBgAPJQ76xfCouIwx8MsdQgSBX1Y4Nn7+XfPRQXAlD94Hn3xOefDqnxB9t3d/ZFKKrt2bZSXpNhJWAqNeqcI1tWB+wxogVpv45cNR7JZpePGwHRJhWk2Cl//Som3MWCcjwYWHJ6iCDS2aRu5yDs4QsmVM7avE6ar0EDURsh39kIucN3yK8pJCspcGbRXoNJvphg1FL85kp6gSO0rcjRsckQW8kTKCPJp8eFZXhw60D26vBOnKGf39pzB/8WYZb0CMtuYfwLqxEI8Ztej+rhffTFUWAsHy2Y/Y=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6982.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-Exchange-RoutingPolicyChecked: r+BS3ibwmK7nOKjosiFAtiRFOL6Y69OaHA3zyzXJw6qKGP2YKadK9d0Y9LdfYJliVXK8gOKIOC5miPEHUp8UUyWp2/vLs0W5N/c7nt1yzTE2VxVyOryOYQKKsMkDiQjxRSs3O+2xPZXMryhMHjJVkj1z2TPVKiIBXd6PYtG4kv5aXTofh1ulJ9iIhZ2SXUsZfhEe78LXp4dBBYGBKIxBw9zyAjUi2J9kkVkqksIkE2ShSF9VwkPAhw7kEbkW9EdttsTkwzJfr6CMlfhUSaIKwOr4sCPlR56145xp/gAZSGIG54wHGi/nG6ptn69tC+mxCchtG+mUBBuEUw7Lws40Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5854
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cbd4ebcd-ef3e-47d3-9a72-08de973a7963
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5tGblh5N4/YpwH35OaZLzLbY4zqucdiwe/dg4CnxEnlgh1PXOKczk5dtC+f4LhKEnOk95pz66NYMIAUt4yAgsFp6mWPXx14Lw5aeeULVljtSQx+h05aTvqhmPTD9SFbA37/cBT8/WRQ3KDz2idzd9CsdHRuERMH7ccZlsv1xvimN4dGld0mfjiLnd3sYUzPLzKN6RFabYNWo5iRFe431n++Wjio6gLHmIFuMFiKqhq7aPwlKVisgjcvFGlgeLBONimYqm53sX/lFXuNBcHxCuSkfl/Jrqsdg2+i0W+JwHBu9kP6SpEUiiPaPBSwQwuBtZaWgyD9/1G/k9VEueSGAX5ebEsKrKsEc7+e7q0DQaJFUD3IH6RSHP2pbyNB1D9PKLjui/7YIUccC6/ojy8eX2IFKK+IFZAHHWUWU6gBayJWtgECvi7ggUtjF3pkzS/XLnn+ZCVi1ubOMKwnhHNuSElrcxk/Ep6y00igJ4WQFMgI/lAHQ1MOMv9VZ7OumYAKkkVcyME7ekhYun8XepZ21g69rcPsZ0x0VXPdqurtKa4fZiFuxuC+qahqzAjLI7D9b+bqgt5bkRwEqZIOcVwEzQsmQDongRSI9FBrAzDOyOJ2tRxvMlqAZqLW4h7gmj5mxcstaJ7UlNiKyrcDVTjQ9o3k7gA2iyX+A0YRBE/jdNzVpwlCLvUcbVi3P72vCfQZpvHc8k3PhRkKof1rC0mZf0iGRw45jpUw1orXYdDHsJYtTT2wVl0rWxy1pMBKfKAYrhlsngDZ0U7WX2o612Z8dow==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YQouLy0bX4aS5xahdaul0S54PbfjxastCPumkpVe0Jpd0r/vmbUkVQEcS2MiQIPM5ADG5XpJ3hHFsDsaCqNJNXTqwB4tO6dNideyNtbN6U5qMWzkCkads1Iv4MrdG19vHcBVY3EQHg6zmEMg82fFxueipp9RBfOzPzHjH/wGjBy/AhAUmiK+zVcBxRsJNcFtj/bgRszXOl10EEPTkhEiZMUFNRfV0VtXB8S/dxj+zza7aKubEqzZmnfA/6jAZ4dtuEUXXCj+dPpgLFY7VFEsoMW85SdtqaFLroGtj/hzftoPW5Q6Oo2cy0rJ4X0xNPkkN5pqRa/ocrwz586tqVuRdmn92n/YLf+Dfd/kKkt4D25PT5oHef/YQu6zKpuaWTulP1bOWy7Cay96XSRz/7osjus/6AYDuKkU+kbn4ps5PbzHDuISx8d7cClLXseKdwCt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:51:56.3682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9917f4-01e3-43c2-e398-08de973a9eff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6434
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

Recent changes to add shrinker support introduced a use after free
vulnerability.
When a BO is evicted from the shrinker callback, all its CPU and GPU
mappings are invalidated. It can happen that another GPU mapping is
created for the BO after the eviction. Because of the new GPU mapping,
BO will be added back to one of the reclaim list but the state of
corresponding vm_bo will not be changed.
If vm_bo remains in evicted state and shrinker callback is invoked
again then the new GPU mapping won't be invalidated. As a result the
backing pages, which were acquired on the creation of new GPU mapping,
can get reclaimed and reused whilst they are still mapped to the GPU.

To prevent the use after free possibility, this commit removes the
evicted check for vm_bo so that all GPU mappings are checked for
invalidation.

Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fa8b31df85c9..8d0dfa93c45c 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2350,14 +2350,19 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 		struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
 		struct drm_gpuva *va;
 
-		/* Skip already evicted GPU mappings. */
-		if (vm_bo->evicted)
-			continue;
-
 		if (!mutex_trylock(&vm->op_lock))
 			return -EDEADLK;
 
-		drm_gpuvm_bo_evict(vm_bo, true);
+		/* It can be that the vm_bo was already evicted, but a new
+		 * mapping pointing to this BO got created in the meantime,
+		 * turning the vm_bo in partially evicted state. In that case
+		 * we don't call drm_gpuvm_bo_evict() again because this would
+		 * mess up with the internal gpuvm lists, but we do walk the
+		 * VAs on this vm_bo to make sure the non-evicted ones are
+		 * torn down.
+		 */
+		if (!vm_bo->evicted)
+			drm_gpuvm_bo_evict(vm_bo, true);
 		drm_gpuvm_bo_for_each_va(va, vm_bo) {
 			struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
 
-- 
2.25.1

