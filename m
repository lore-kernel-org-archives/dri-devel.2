Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843DFCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFF410EA17;
	Tue, 19 May 2026 02:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJJi8032";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E78D10EA19
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVHEEfXl+7WJVVqu9aN2BEWyTlqtkj3dfFWPlnRBtEyWtqqVJ+Q3pavL+Y/Cy7p3BK+uuLObqxl5oOb9UC6cOrJI2D3GJqIQ14trV7Yd6/fq+EXceyGsSJRVlj6pKHC/1rW9v0md0vhKstOk4ReIAQ8LwExXIYm2wflrqisJevID9DyddDIm0rUTEz9gU2VM1Wzjk8dJTL5wu63FWDulRULDqdbAyDLa2dqMiLlki+vD8miLrKF7poHqS8n37VFzuAlMp8bQkuvNcYGy9PSpsLou5TE1qt5jy76FAiipidmBnnsL8ZQ9611i8slKIkG0LV/bxE5ME4L3c8awthNlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAmC7dXzERHx8iCmqfhi9reOsJWdkEDMp7+Ae2P4wU4=;
 b=kI+wK/fTXj+fsOcsJpSreD46p5ZUyJ3Sz7IN86Iwzn9FOUCndShRg0zOw9A2zHVtS/ChjOxQGTNak+dU1AeJSVQ7bwe2FAWaCcap7V0wM0WpDJaFLoTqPIUAIrFfbampRfSd31j0TRHhtH9BSdDgJ6+hr3GEWyrZqu5ZU+cKUPUFaqiR0AkQjMrixgSHb4M+KJqlYVnxJemdwZHrW23SqliuH+NGa6Egzoc+P1L93fFVEOzZ68lLvTconDDHCYlamCxpyn+HiWpVDwTPxHQgfoShNdukCG7lvrjrddrAITn/UAhLaWbXrnF3DjL2EOZFcM7o3GDE4AA/WCQd89ksyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAmC7dXzERHx8iCmqfhi9reOsJWdkEDMp7+Ae2P4wU4=;
 b=VJJi80322Xk5XRgrwX3UpYc5BFe5kPQd2oDe/joskRkVifIGZmqeiXa5A25SsqDAqVeJMXOoLBKIjuQzBWTEDtotxw4/cGN1Ym46BtUZRoeLnpt/Nm0M/0pF/BdiqpwselH49rcNggMfxzGRpjWNgWZD75IYJdJLMGfLKkbFtuSFsdDy5WGhxqneYb7aKBwL6wObNYukjL7ty7Y/8y3lt506wf490ZkXrwp2RrXAol35zX07YZN8aTJoTL1t/gGXtWRW+KP5Fe2T3WSXnnN3xVpD4d1X3rJ/ZJ+gCzJF3ze7s2AsjospKDQGNdv4FVV2v6AOk96JcPSZy668J+pAJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:55:53 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:55:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:54:56 +0900
Subject: [PATCH v4 02/20] gpu: nova-core: vbios: use checked arithmetic for
 bios image range end
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-2-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 210180f8-e024-443a-f57c-08deb552241e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: DKjazD7wQW9DhNsvBGeDv/oOKzjhGSrCF6De0IvrWbFxKjrYfQplp7/eBMwgvo6mGjzJmwCGuQIFNGcxqqYDlZJs/wIQ5s8+uHddHkiaLYN+lg7aKngNe7ZSdINfs1BeoP4o6A4gT5oEZ85BARYhoTJzY1z3OBdSe1QdBGLMFf6ndAIeeypiN2jsaWH2/svEZJgZID/y9uZSBtkLnt4u2nz69q7lGyLJE/UUghPcvvJEfT6c76/CLTKInhH/wF3bUi2ExwdEM/R4zkxw0qVeBIYDgmaUt+VFH7s50NYF0st8kFrQ124ebAJNzmKYumMxNJEl3JgbRYdSs/psxW/vfjMRMktpWVqPWO6qgam6pWJL/qMlKVMCV5bjERNkEkYw5WpDJZ9sjeJNDuu/C7MnBJFKsDQioEFga7GNbSz0ri8lP/cA2nk3YgWWTGZ7QsilYyGoc/qfvKDpOIR9gR6ypqvsEfH2QqEV3lCtosQQeEe3urLgVrGxb440cHS2XDfdAMn0rbPkZ87C1aODUVASfMEItuhbqSNEfikyu67uR0ubOjxatXkZlo9c4F103RBgQS6V7ma+QsZJMIlYwWZ1HPMrMl1grK7q57bbrWuYVaBdes6w6gJBJFCQaQ05NdKK+ixelSH/9EmPkA8Gso6BNxDVhIEk44lzfW32kVegm/shnPRBStw3g1295DY9uxsr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVR6U3dRTWhobEltbS9SZW5BemdYYXdPd254eDBqYit0L0FpMHFTVzNaeFJE?=
 =?utf-8?B?cVhBWkFEbldhaGEzSUZPUnp2OHpjOFY3OVRtQ0VQMDA2Y2J5elE2Mm9VT216?=
 =?utf-8?B?L0NCTHFZUitPZlUxTlYzODRaSGpGZGtWbU9VZjJIQnRYY0ZRZXpNdGtDeGFR?=
 =?utf-8?B?aEpMWlp5VFM0M0dSZE4zR3kxcUNkbUJuSjZmUXFkNE1WWFlXbm1KSnJxaXJ6?=
 =?utf-8?B?VGE4STJRSFBJYnZjWlFXRWxMUjViWDlQQXJYQ3VDVnpMMFdLYVpDUitIeDhT?=
 =?utf-8?B?elVrRFRhSGU1RHFTdjNWcW1nMFN3Z3NKL1ZOcVBwNGJYeVJVMUdkaEFXN1ds?=
 =?utf-8?B?K1BFUE0zWmlmdGZSTklDWHBiQlZ0dms3SGI3Q1NJUXZMbi9TZWhpaS9pU3li?=
 =?utf-8?B?MkdqSjFodFFlWENDNk9zdjRtR0w4cnQrRTQ3ckhvbXNGeWVQV0NyUkF2aVVG?=
 =?utf-8?B?c3FpSXhmOTBxNUROemp5aWtSMlNycWdqZWdyYlJ5aDJBTEFqU200bEh1a2l4?=
 =?utf-8?B?YnBBaFNCbWNnU2pucERGSUFKOXo5d21wZC9wQ2Y2d2VTT2M2ZWdxYTB2U0JC?=
 =?utf-8?B?cUE4eERTaWFKY1pINlNJZUZCeTBGMitPT1Nac2laYlVlVXM0bjhHR0h1dVZF?=
 =?utf-8?B?dkR5R1BwajN2R0ZTc1g4Y1pINVFoVUxSNkZiakpMb01BNnpZa3hHQzJNNTZk?=
 =?utf-8?B?WENVU3pScldIMnR1UWk0THFSM040d3JhSHNlT1hoUVE4alo5MHFJMFRkTGRo?=
 =?utf-8?B?RVE1WjVRaUU3dndQeXI4QWFtQm5CQ1NYajlnVDZJTXlEMmg4WStzYUVpZURQ?=
 =?utf-8?B?LzJYNWFsaWM3bUk2ZlAySlpWUUVwWUxrVkVpSHJrN2Y0MmdRNHJwa3lrYmh3?=
 =?utf-8?B?YWZvbWtwdHJaVzZCcks0ZlRJRit1TWdhcG1wMXpxWnE3TU1HV3pzMXFPS1ln?=
 =?utf-8?B?YmpGTUxTa0tNbnFNNTVhNTR2ZkZuNzVOK1VXekoySER2dlYvU0RJUWVJSEdo?=
 =?utf-8?B?SHcycHhDZFpIREo3THFXV3JlSDhFWTBZM1h0TkdOOTZzQ0llYWZqaDhUS2xu?=
 =?utf-8?B?dlhvQlYzWm1HV1loQUNlT2ZIczNVQ3YyZFZJaGFad3pjU2F2aERTYklLS01n?=
 =?utf-8?B?VVhkVENlOENFTEpiaWg3ejFoQ2NwVmtjSHRlTnRCTGE1UlV0SlJRME9pdEdz?=
 =?utf-8?B?VFVPQzJkRFF3cmYwcUV2Wldpa3FmOVU5WkEwQ3p0Z1VUNFlMcDVnOHYzempX?=
 =?utf-8?B?S3cwb1RjMVN3Z0dyaHhHYzlqMjErNkdTS2Vaa2Jlbnk0Ym9UbGxpd09HQ3NS?=
 =?utf-8?B?UzVWaCt0NlpaVU9nYXVOMFlqVjF2UzBHVU9jeHp5QTlOWDhwOW5SZFlWNkxV?=
 =?utf-8?B?QUdCWTRGOE45SEFIY2I0NjV6YllQbUJ3MzBWdlI3VHBXZTFaSUtERkROSUVN?=
 =?utf-8?B?UE13K3ZmSEpNYXpWbmlUeThpY0pZVGxlSS9YNnVYcWF1UFhCKzBIblNDSUEz?=
 =?utf-8?B?MW9YSVJpTnI5L2R0ZWFkMjJiU0dRTW9yVXVnS2hBaDFaV0lua0ZyQWFtbDR5?=
 =?utf-8?B?Nk9tTUNRUlNxVGFvK2xhRHYzdnNWcFdwVGtYTVMvYXV0RG5YakdZSS9lVHJt?=
 =?utf-8?B?RWRvdS9ObDZlMmpmWWlPekN2V2g1Y0UxVXZNUTdzNkVzUWV0UGl5ZWFRMVht?=
 =?utf-8?B?L05tK29ITFRqcUpiTFhIbEJDd09ocm5wN2RZcjEzNjZqYWM5czJBaExjR1VJ?=
 =?utf-8?B?SzFneHl0emhsNmJlZktLWWtPQ2M3dHlNekErVjQ2MFZSd1FhSVZJVzJuYW9u?=
 =?utf-8?B?UmVFanBoK3MxejdTYVkyQkRSTnNMM0REWGY5STVWRlFpaUpIcWhRRldub0pr?=
 =?utf-8?B?S3NNQjJVZEZUZ05qNVpCTE41WDdva2d3ckQ3ai90eGpKbGhTQ0VnS0cxczlQ?=
 =?utf-8?B?cUhiaGdWOVBScVkwd2NYYThnSnpnT3BsQTU3NHo3NnZtaDNoVmlQaENsYldK?=
 =?utf-8?B?VFZlc0tzMUw0cnpkNHBqR3hwTS80SHE4TEF2aVd6OUpQL2J4YTlqbjdBVENH?=
 =?utf-8?B?R0hYcDhpQXNWZ0dJN2JUUlBEVlFTdGRhWTVlUEFxRWNyaDhWVThiZlhWdEk5?=
 =?utf-8?B?SnYyNnBSRkNsRnRHSEFobVI2VE5FejBDL1FwN2ZLOEJCbGYzdFB0cnp5ZE9h?=
 =?utf-8?B?RmV0ZWo3S2w1L0lKWnZuZ0NibUt3enArM3kycHU4dUc3MGEvSlBIOFlYTlRi?=
 =?utf-8?B?V3J3TzBTVTA1S2hwZ0VWbGgxcVY4c1BNamxEdklXZmtWM0EwYThMbEZ5SWpo?=
 =?utf-8?B?b3p0b2sxMlBKM3VYelh6RkE1VnRpOGphWFdEeGwrb3BjaUJkZUZYUEdueW9V?=
 =?utf-8?Q?h8Fm6EGEcKZdVj7gzkSE5WuZ/VTYgyChIucGHs3F16HL9?=
X-MS-Exchange-AntiSpam-MessageData-1: vZUM+PFjqEFAlQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210180f8-e024-443a-f57c-08deb552241e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:55:53.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ct1nLltd5ADK34GmXI+6NKQzz/cVKQTpJ3FHXg8uUB4C4eoevmDaaoUHILNx+pgk1HmQwVqipLbb7LOXtamtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

`read_bios_image_at_offset` is called with a length from the VBIOS
header, so we should be more defensive here and use checked arithmetic.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 7bec81a37340..180928433766 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -238,8 +238,8 @@ fn read_bios_image_at_offset(
         len: usize,
         context: &str,
     ) -> Result<BiosImage> {
-        let data_len = self.data.len();
-        if offset + len > data_len {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+        if end > self.data.len() {
             self.read_more_at_offset(offset, len).inspect_err(|e| {
                 dev_err!(
                     self.dev,
@@ -250,7 +250,7 @@ fn read_bios_image_at_offset(
             })?;
         }
 
-        BiosImage::new(self.dev, &self.data[offset..offset + len]).inspect_err(|err| {
+        BiosImage::new(self.dev, &self.data[offset..end]).inspect_err(|err| {
             dev_err!(
                 self.dev,
                 "Failed to {} at offset {:#x}: {:?}\n",

-- 
2.54.0

