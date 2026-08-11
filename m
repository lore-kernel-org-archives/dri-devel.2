Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2268AC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8547010EA6C;
	Tue, 11 Aug 2026 05:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxsQJbOy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B83810EA6C
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiOkhUq3bPCT79zCoN/SpSFM8PSa/atPpC2hNgtNHHqr8oWULCcuwzmw+SJS3cvq+fJvEauLvQpORLf6j/JS5vEcmbtDkF8oOvJ61ER9prkV1QyQ4HbWaJtwNB0ltdN20uJGgbEv/FGivKKSZmD9rpOuUQDrEkBlNyuI71JDQ2hyqkRNL+401Ap2DJzjyx1j5cEeRQcglh3oaEX+i9D4VxZnevPQWCHdZXGWDUrQ1j/uGsdKX89VZ1xNSaZ04CYitnjGS1lr6B3PQztNqjZh+IH2e112Jeo884MDuavfbJ68/4m2Bs+yu7OyfoltE6pIjOPv5/IxWG/0bfr/CyRhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM0DAicPtB4aP4R7yRd9U/bV62VemClHgqlvHPLdyCE=;
 b=Em8mlzMaX/23320NplERgurd1M3IKh3msjx+mH1S1Q5PABX9RAUr8QgXoOcaQu21Z0WQ1sc55qCJXzGtF6wXOEVAlsBsI/GZJMASvn6DPtJnejTLI8OP/NEampx0iD1UfDijsLBRLLcKAHwNrp1mVDEicS8kOA02jfQPgRmeUHR3+BxClTBw/UMurixABGdZYCsEuVlg9bY5uU7SR8GbVW+5dDXUeEfXV6YcfRoiY998mLEV5BlWl9fYfg0AuJsI1iwO6bevBxyVKtUCRpOsN4LmBO939plI6w/Rul9rwQiedvWtxmoyWfN+J/meM+LBYioznPjnXxcBHn/CaLRw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0DAicPtB4aP4R7yRd9U/bV62VemClHgqlvHPLdyCE=;
 b=jxsQJbOygHYaoU4K6PahX313UQZX4h6GmI+MRYNFPQO8TUV/CW3nthOdotP2a8qGvD/ukJRUqIScdcp4pGbrED9qP09Qm4oIIMF6V1bGzh4Ami0bm+0lrHd2hdEqiO7kgPUu+IA/iK1jVRdkOXT4tfNpIDGJDCa2hfsU46DIVSXaBd1k2wc6TzsO974AqZpXAxAoAbaLndDGXqB8FpJZ8gK2dKpwjuyfl4z2IYuVmE8zQmc3JLPr+5RpnfDAOTdEV/vgIQLGGWc1UzdPalmpaGnKark75/MgpdMtqlZoFixIDSwq54hYcVGuGtShyosWk1K605tmr6EXttQ8ioUaYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:45 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 7/7] drm: nova: Expose a render node
Date: Tue, 11 Aug 2026 15:06:57 +1000
Message-ID: <20260811050657.646799-8-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0041.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c24594-4282-40c2-c4b4-08def7667a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10063799003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tdj3i9JR/91hLDcJp01Ez1GsRBhC5OUqNh87iJRhRGSQQVVBsAyfpPOXHQRrNStAw0jztPeKlJxvKvvxHWYF3u1X/L9lTC1+jZ15VOF6zJ4QThQLfrvGZo5QIN+8fzlBOzwpYct6mB4ttVUp4TKD1pW2czoLrgUHJ50U9DJkwLvnZH2p1rl1vP1oat3IGXS/6SKmAynUqusT0Nb1Qrj0ltEN3Mhy6uZ4104TS2PIEWgEVj40FK4So1AoThxhA5Pw3qcYsR1OSNWmJa2NeQ7nExSCn7wVL1XEdLoLV7mcBiMu/Gldt03nUcwQnA77DdnBk9Oa9mr6jKuYot4PrW28PAKGIgeNI7FbavQ6WCu0yDh0r+zxwgvFnhzdGNrcZwVKlbTW7pq/KeQ9s4+C9zLTm4XAIXMVr7w7lmZfFATNYh5MsLGfweF8D2RxYZnDW1byH8UzCqTmUJy6F8d6lERbEzxSIiKhDw3FJ9tXpihz1mxOLuCSV5NgaA87MZ87fr2s8V6Irkug9mtmH0+6BuLPxOGnVO47t9003XK2yhjnU7HCUjkHGyhq0/YTNL+Xg8R6GdFkBbjVoQDjiwXEtuM6UvBwxTOU3yB0AKY1OpmlEJJonrXBUA+U0I5Af9QbFyNpAvhbxJz1nED81KmMxN/k/HOIEtnX3UC4VymlnKIX8sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10063799003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0sAPk8wtnCHceKdrNwgULDF6V29Rr8Lmxsdyfrm1QksrEZvsnz/crGGKxlw?=
 =?us-ascii?Q?18C8CUheQxaDzPGlW+joViM1Jyoi2XfDWHYZ5RBvhL9II9y+Mf+FgfZmfbi6?=
 =?us-ascii?Q?cG1Oi1xx/Dt95G+kocmdel12H1Jmf7vJdBXsTqluJ1zIUkgkLI6NkH5/cfrT?=
 =?us-ascii?Q?7mOVOb5U99n3powYG6zmhW5FPkUuI1N8UlLjEMBEp7ON5ylkkR9I9p2Khkqm?=
 =?us-ascii?Q?QmtTyZTIvwDuYqc2tLifUyUMJg4WYF26kTQ6czlTuxyIgt0muaFW9Yi8ISOG?=
 =?us-ascii?Q?j/W7t1hebqSZIlC4QbFG+PvwiNm6xWw8Kcf9T2Ix3gqgq7HxQHyTpsxbI043?=
 =?us-ascii?Q?U7rvvL1UngUkN3sJB2syne6b7MM+pzEC8WaRJWdMOKtb7z5fvWzsisnDT9LK?=
 =?us-ascii?Q?dm/E0f16LkcN2BzST2/QYZNc0qmgNgWKy5n38z7AGE4/27RFGapz0NwS9KWF?=
 =?us-ascii?Q?tulZgQaoc2CkqSA6M+pv2spyD9ZoCD3vTtr0x9HmEJ+nisua/+MGesTPSccC?=
 =?us-ascii?Q?6MG3b7ELsgAq5THpvFzzQJanfBDCWMHhSJNYGTE9XJbwK3JwOwHtBTh3dsWp?=
 =?us-ascii?Q?Aep0Z1OoYgPlrcobU60zuNFg5jIQfUMP8ks07kbweF/B27Ye1FNGUuA2QDnb?=
 =?us-ascii?Q?JfIR4nxrCswJ+bE7U+CFqcPJCsEnPKMceYGqI//OucTJfwGLTiPQJABbDdxb?=
 =?us-ascii?Q?PnZWUTJbllJKuMYROBE5oJD9uBa7H6wT2T/WR3q+rNbXRY/tJK4N8imgCmFh?=
 =?us-ascii?Q?Fx7TanWZM/I/HMOZTywntRr00Wwco6cxwfV7L5QbRA3AbSIvzFbyq/XQGqPH?=
 =?us-ascii?Q?fmGPnoBaVSEbZDZJe1kd/rATh1QUOf9UQg1m3+56FOVPVDU7tKnJu2nT0rr3?=
 =?us-ascii?Q?2H9O7goJpB/F0LZBRfBxzI1dUl6jr1c/5DxVy2Tr+pJmNp6FCmzyxUI5IIzj?=
 =?us-ascii?Q?Gtk6jn0OYwsbykg2T6wj30p3WKWCxOy9k1LfjPbePxjLPoHIM0CGH+EZZd/6?=
 =?us-ascii?Q?LRpTG3Y+k64OC9D4BlKnyFdLTE45wLAZJV9YXUEzYhFYKAA5HZKneTSco1hF?=
 =?us-ascii?Q?UMY9ogp9K/butEe3Qrb2zYlZgcXnPKIQqSFSeitNIJs/Qz4KV5NnOuMscFky?=
 =?us-ascii?Q?zmr7+yIeM4H+AN/X4ugN7SP/jb8G8AiXroA3k1DY0oIRKwG+JPH8EfGIdqzf?=
 =?us-ascii?Q?xkIiH3ypJMcfhI2h6MpEWySMxETDhLluKYt/xkNUZ7r3/TDgxtS5prErB/YB?=
 =?us-ascii?Q?tN0rCXFFqgvqTjfRj8UM/rg+ioYpdSjVDn2hZHQD5Jt52B/Z3+h6oK/hllEl?=
 =?us-ascii?Q?K/UO1OUaxowHey5Q8kEg+XaE2H7xtSnbJpUc8CI96LiDWrWODU3BFURxES9y?=
 =?us-ascii?Q?lFRCENH+CXcBp0Zc99A8IcW6tkqf0DVaHCdkmngpC2nYuuLdCneyXToF22H8?=
 =?us-ascii?Q?BYe86K+WSmAn2xM6/61qsx0Y/BANinhX5iSzjeNQPjqDo6UDZPMsHigStPkC?=
 =?us-ascii?Q?b6WzcugIEzv5/C0hOzP+P6psgGr323fGM3xwUAu49qK3IgIw17VJGCAxzGDW?=
 =?us-ascii?Q?3L0WR+j+OGTq5Bt+zCeMbP8K4sYq1i2nKZxJ10+3PfbwUmkFFYrSxXuA0fW1?=
 =?us-ascii?Q?CTjJnOJVmvAo/YfIIvSTLg+ZEKyw49vXHd/4IOOFaTB3aF6TgPcaTit5nNFC?=
 =?us-ascii?Q?vkSdFHL3peGSZPkZpsMnvFPjcM6MINmypsUUq78c8Hxkwf/uyhO+qW+AtMx7?=
 =?us-ascii?Q?WWkS9A9YkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c24594-4282-40c2-c4b4-08def7667a92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:44.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V77VE2m06MIDRwLVC2ts49x1iaqO/7s1WeCq8LA3pCJXRQ/jSCGmeGqT8DMg6e7vkPBrkRusMOw7WLVdPC02NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

nova-drm currently only exposes a primary node even though all of its
ioctls are already marked DRM_RENDER_ALLOW. Set the DRIVER_RENDER
feature so that a render node (/dev/dri/renderDXX) is created as well.

This is required to allow render and compute clients to interact with
nova-drm.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - New for v3.
---
 drivers/gpu/drm/nova/driver.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index d6dce160f371..cbe2b249f7da 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -92,6 +92,7 @@ impl drm::Driver for NovaDriver {
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
+    const FEAT_RENDER: bool = true;
 
     kernel::declare_drm_ioctls! {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
-- 
2.54.0

