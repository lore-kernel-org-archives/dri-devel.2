Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F1CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E93F10E382;
	Mon, 25 May 2026 13:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DNo7Gc4r";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8307A10E389
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqRaZ+FVK5OiH+GvInFGVb+kxfsTyq5M9v3NHNTy3DYFr0+Is5Xcp91hm2J3qUDyX1bx26ErlHYy5O+yWVJU13xd4lu3VVi+owJFQG8da+RGj6CjCeQuqtFVz10aJuwDXdrz/eGlmHYszVYEySoECr10pV+IgD9TEChIrqvui9j0KTqVZ3mADR3I79m7agHQfyALnFNV0TGhFhH483wkIebgaBYQg2PdWb5aB/A/gORNd+/L1wJBCRJlfB34DxdBmaQHPgQzkPTwbWv5zmnrg1N8XRSGyUGKvX6udqOyHtZon8nT/cbAY8CF73mJ4tT9lS4cwxmwWKO+u/MJJ6BeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2Fu+/N6fTQw7yoERolJMEuLXln8P7QlCYPqLlCbu0k=;
 b=jLckGqiLsZHgNVD0xfpDgcZ/G+mPjQacgQM5ndEnuczTkao0ENCBAzknvwykyeULFO+BxgxiYw8C7X9cuzcVRs5eyqRFlpWpm9G8/iAHMrt33iKit3A+I8gp+dMgL2sqW48/FyK5eY+bO/ntQigwuF4aUuLclf9AmC3KuOJGiDBdy3jRm/x1wgd7TiguF2rhBqQtppjhn/gLkKVWF/Yra3z4/y1EVadYifWfszg8p3T6aPbK28rPcVqtCBqTGarPnOg14h2j2r76Px4tt5mK5kKLC81ebdtg/Ugs6zv/jJFMrx+GmsK9bGWTyT0L6rjHtnPd+dq101hjf8zsPe1gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2Fu+/N6fTQw7yoERolJMEuLXln8P7QlCYPqLlCbu0k=;
 b=DNo7Gc4raZpNB/n/hE2vO/Sy75Cuy+U4DV7b1k/xmP/dUW80hVLXKfNFu8lRTOcjLETb9mIueKzsVc67BWSqt2+PLx3KrRj42L6hxWpVYVTfXpL+dUgzlUmgnkzahGZaDtX7TyCyGuR0VmIobEO5Xd6ncnJYjxqnMRroWcPlAfVJlAD6YqiShc82EV6viFwHenSV8tMG3TmJeErg6fkq2WJc3GyImQXrcXPzydWpqBUOt419Gno9z/try3DGXjp0aPrKdS8Dv8H1vFkNDVN75F5UOnwb6Jc5Yxq7nJytmfasb0mMCcXjppGq0uEEg08JXwM5f0VKhl5dj1wGhBGoPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:33 +0900
Subject: [PATCH v5 15/22] gpu: nova-core: vbios: use the first PCI-AT image
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-15-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0119.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e06095a-29c6-4877-4bfb-08deba65be3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3oojMWwvbDZlXodRRdBXyb7vl1Y4Jvob8nY8RfX65wNGZf0KBh8OpmkOOj47MPPpNmDlvY/nvHf3ugUnoWGYfDb51onjRYV2BiE/ydYG0rWFthZX0HYkeh3cMXwL3Nt0B5kxDv92p8b6Mb8H3qhjHxoy5Dzg2l3bgesTvMtwCkEF9gOXJqOM07M3Y7Llr1cehcYK5VBW1SQY6e8CqsFsOkkjvn47hYxsGN5jfOtiDF35P0svG9xZNYiweBBE05znIqk29z7mGjoBm9URSKPajIvgdXACjsZxI5z2NSMSjGgG/UlOjNLqXZqV+JVW94h4Uz5qwzFZLb/5QLzh7z4q388Z9YQsLOL5glYvwmAwWKhvujI09OJjwZMvNyCDrbDkZ49Qw4T6uNENYjgoZIjBoY3fsnKdOET0i8EpKEydKOJEpGSB4DfsLHrnsNJ/ioeAQ35l0h57i+EhJjiBu2/Df7e95maVPUGC2IpFrDgHG6sSauKK+BKKiX+UTwC9bJn3QmbnrXtOLyPkfNM4L+S2zf382zWQP/5TiBtMUYm02ugYw0E6p5cZsGgAaMPkZBXXuFgYd1igm/WPm2+C1bajUS1uDbQz9J69DSvYgbgMhBlXpAz/+zmxHegSNjBvbnHHG9vpe4qdnQa9JNKA8pIBWuuW9mdh3xzhNBsp1TID2zzIpboniXz/VOG7ftv/pCOr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZGRm54Z2U2SkJSNGVxcW5zRnlBVlp5em9WUDJaSTNrZ1NaYTNjbVd6WGRj?=
 =?utf-8?B?VXdrRVRyaWdEQjZPT0EyRmFNWHNXQ0QycW8zb0dKYnQ4RkRmN1FrWmlObGtl?=
 =?utf-8?B?ZUpvZ2tZT0Y5TTRTdC9sd1kxQy9PV3VCeDBPOFNEQXRSNHdPeCtSQ0kwaEMz?=
 =?utf-8?B?VEVjRDJVQ0NiK0ZlVHdkUThvOGNmTTBwWWNPd0dXeERESjROQWRBZEw2OEJS?=
 =?utf-8?B?M2lDMng2UWMxV2EwS3FNcHEvSjI3UGZKR3NmTXlnd2NMV0dpMkY0WHk1WjdB?=
 =?utf-8?B?YldlL2l1cDVYTWtDVmhlUysvWVVXb1EyZWZ4ZzlqenF0VmJzNFA2YVIwa3pJ?=
 =?utf-8?B?dXRQWG9XZkRXT2tTVTFzY2Q1b1RyUTA4c1g2MXJtUkRGOE1UWEF2a0h6TWVh?=
 =?utf-8?B?MnBLMkFLb3RiQVNla2kxU0lqQnhnTHVnL3FCZE5wSXBzUW9TSit6VDl1ck8z?=
 =?utf-8?B?WElDVHM2bGp0bGVwZVJ5b1ptbTY5ZGs4UDVpK2N2THpqelUzUnFpRHR3VlEz?=
 =?utf-8?B?WVR3TVNhOU1ndXpzK2pPWUF6a0VZbWNBM3pKemdUbjRFUjcrLzY4R25pbGlR?=
 =?utf-8?B?OXRsT0lNd2pYNUNrNWdNUVIwdWRYNmpCTEJXaW9XT3AycHlicml2b3lBUXhX?=
 =?utf-8?B?YVB4ZWZMeEdsTlpRMmpuQ3V6SGlPbGpYMFd6WTJKSzJGV3lNbVNWbmlwbUl4?=
 =?utf-8?B?VENnQmRUQ1pORmxOWlJLbExVNkRtSzJoZ2w3ckdraHFwZjRoMXplWkMwZWM5?=
 =?utf-8?B?Qlp3MkFDLzNrckx3NC9Wc2NDRk9Zc1habisxNms2OEUyY3JnbW1BbFM0OEcy?=
 =?utf-8?B?Z2NVcWwxaFZmRkpzUzBiMWVVa3hOMjhiTmRJUnlrNHJyVzBHNitRRGo2OHh1?=
 =?utf-8?B?b09zU0tsQXAyQzFTbDcrekRsTWZONHBzU2t4d24yVjRsV0QxL0hmQlZCV0Ja?=
 =?utf-8?B?NVBENGZaUUxGdU5IQ1dXZld1TEZ5ZllPcVZzZGRLVzFlQThGSlJSeWpXSUpE?=
 =?utf-8?B?NEJ0eW5TK1k0V2hEM05RSTRLSWdhcnVxcjJxcUEyT0dBcFgzc0VydCtBZHVk?=
 =?utf-8?B?SXhVU2VHNjVOdWREY1l5ci9UVUhlTGNEVUZERURycHJJUmhZcDk4YlkvSFo4?=
 =?utf-8?B?c1V3N1R2UGs0NHJKWlpVMVk1a0U5Uk8xSy85ZHlSSVlYQmthbDBZMDFiOUNu?=
 =?utf-8?B?MnBUSmF6MUE0WTJ0U0NTcGlpeGxaK3JhOTZKSmRtamYvUFlkVXlqVEpWRzVn?=
 =?utf-8?B?UWcvRStzQjJZZzlja05rZ1NFM21oQnIwQlgvYmJKTEV0OHF2Wkl2Q1htd0l4?=
 =?utf-8?B?WlhPNVMvRzFqZU1GZEtsbm1NMUhHNjVrVFNDUmdwQ0JONU92VVAxUEtZVjdl?=
 =?utf-8?B?MExxalNsWUxhdzh2QytlSFZKMlJLWU5qY1VvWlNJRkwreGVpMXRGMzlLajdH?=
 =?utf-8?B?UmNPSDdQM2dJa3N6Y2w2RHZnUVdzQkJyMEpYZ2M5djZZTjdxdHRIbm5RL1Q3?=
 =?utf-8?B?c3VSOFQzbGI2T3dVaVVhcDdSVlhMemhXazU4dURuUWtWR0FGOUxTck1waGlG?=
 =?utf-8?B?WnM0WURhQnZyYnJ0MWdIb0xHWG80UERFM1pWY3o5UDd4cmJzeGtqK0t4R1Y0?=
 =?utf-8?B?NGVwWVF6QW1NdUxlanUrZVBudVViMnVnVzRyUkxLbXBtWFFJNFFDUkdnSmhn?=
 =?utf-8?B?RStiQVFGUmNpMk54WTFIakhQTUpEa2ZRaXp1azVBTTlDUmNUWG1uNzdDamlB?=
 =?utf-8?B?UjhPaEthTFZONXkwc3FwWTJEYSs3TGdhNjZRV0h5VjgvZjJZQmJ2bElnTDQv?=
 =?utf-8?B?N3hWWUtvSDI4bGU3R2JYeklNdS8vSm1zTmlwZFltNkZKNG85Q2l1VUh5cjJa?=
 =?utf-8?B?dTlSWDluS3hHZURuK25lMU1TY1JUQnptSGtSY21RZ0ZyL2JKQVRuMG1JcmVu?=
 =?utf-8?B?VExPQnVyaERLZVZiWWdrMzVLbXZoeU1OVTFROW03STI3czlsVzA5ZENBVmpM?=
 =?utf-8?B?S0lrdjQxL25vRlIzeDRiSVIrRG14ZzJtY1ZJdGgrSkxSTHF1OEtPSzM3NHpK?=
 =?utf-8?B?VThhRzI4ZzM1ZXUvZFV4dHBsMlVVU1QxejlPelZNSVZLbzgrREhDSUliMXo2?=
 =?utf-8?B?clYyVXZvdm9zTnN6aUhJdjA1OXdkejRNU1pZTHg4RXBJN3RGd2pNdENjUy9L?=
 =?utf-8?B?VWZrRFNjaStiZ2llYWtyR3lTSkplM0hrKzlEY0JxSHduSjg1U1Z5ZzBpZjFk?=
 =?utf-8?B?K3RKMUVKeEdmNTlFUU02OXpkUGx6STE3amFwU3h3SEFUeTd1NURoVjkxY2hp?=
 =?utf-8?B?OW5vNmIrcllGQ0lhVzBNSjAvQk55L3BjRkt6TTZCS0IvMktsYVRERDR0bjFh?=
 =?utf-8?Q?Vjkp4mVZxc7HCswm/DLMIBxkFdtsmJGB4iQZP34BM+vNd?=
X-MS-Exchange-AntiSpam-MessageData-1: sqIpjQcRROEFtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e06095a-29c6-4877-4bfb-08deba65be3c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:48.1831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/A4vllt96tEdKG5eEYhUegbfzyKz5JHg3WcLdDqiizJMuC9EbFZQezs7jOZb7mKCJmKLSuPrf77OxZ9TogBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Currently, PCI-AT takes the final image if multiple exist. Use the
first one instead, to match nouveau behaviour.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 9c5281e7a0d3..82811e42e858 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -333,7 +333,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
                 Ok(BiosImageType::PciAt) => {
-                    pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    // Silently ignore any extra PCI-AT images.
+                    if pci_at_image.is_none() {
+                        pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    }
                 }
                 Ok(BiosImageType::FwSec) => {
                     if first_fwsec_image.is_none() {

-- 
2.54.0

