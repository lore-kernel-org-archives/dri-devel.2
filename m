Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4709FCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF6310E389;
	Mon, 25 May 2026 13:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTsO+1u7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDB010E38E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+m4e2va5R2IUvUUSycCPebTjwAJ2hzqUg2iy2HO/fgW3tyXTYE+hS2VNlqbo9cdHwypV37s8fGIqIGga7LD1dG78d1/Orr+e/bPLGYG7soX3JXYPBgr9U0yuJA/mt5gzxBQcX5YrtsmKZY9WcPJn4f+vwFc+r1oQwGlyYqDEN9HLfU8L1RBTIwi7DxnBr7oyrgCYSj8sBSM2cJOh5RofdmTSeFltRArJTtQWCVfczImvHlkUL+9AO3njQk6xX1rK/zLHfzDWYSaeZp646D6qmwDbIuM8TWQgrMQBFQagEcBBpCRsBviB0QqHBkuUxZDbLg89piOvZBLN+FUqhAwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI/M1XhsK62JvPYAr6QFmk1ib9sJFHoDd1xQwj8CBMA=;
 b=agZ2MRJA4eaWeIMRTrL8XEP9p8Tx0KbViS2YV8w9F20wQcZqLjkgH8R1f+MeegUp+o1fQE0Z3r8nXI5kStX5XIovcpSQAkBSRj87jjudJ9wM/zqYn8hYpBMIWgPHdC8+Eop65JSGLe6AZ7HxWwgKkjH7DFoas6ByXiRERv1Mn38mzVmCBibytdKZvxVWLhmKIBTLRanBBIYEPqjiG3QzdDxw5cuRpy8oc68NYcqmHQ6F/W80hgWcKdP5pcCr0NvVnNaVMKlncwy6++ZzVE3B87bu2XXz1+c8URnt0eYDFJ2O0Fl9ZaVbd4hcDENXI8AqoZnPJyBWM9vkG0618ZGtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI/M1XhsK62JvPYAr6QFmk1ib9sJFHoDd1xQwj8CBMA=;
 b=UTsO+1u7iMV9ISJjFghjAJi3DgnoWlVbzeJxEzsIuam4lpoF4FUw0H9hv1QGHdt5iDl0EhMSlFygSLAtu+ciSZchBOp79jO6gq3xhWAamKDx3PsB2sfzSbO3bddl8bkCDSYmQKLPo79kBRPBGyUwvRJ713Qw/wYVSN11oF0ydTl4w9oN0t++sIwpbL25Qb85arxsMLTmsD67oaAD4lk2iSlHFUQprYdmqTi390035VJBCvs6HEN6Ks6eCsvVN6Xj8kLvyzAam714BeLPDbX1RY3eTI85AukV5V1GMnV5gZlKuOJrvrjlpaOk5wdJqaB1K+btPNYEjNyKxR7dq5ikAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:35 +0900
Subject: [PATCH v5 17/22] gpu: nova-core: vbios: use let-else in Vbios::new
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-17-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0107.jpnprd01.prod.outlook.com
 (2603:1096:405:378::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: ff97baec-5ac4-47eb-def7-08deba65c326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: em6PVOm+XkGo/wMtyHbL0ZW8AmJJo0ShfEKtEFZzmVYpcnIi5cTk0ciZt6CZHdoCVvcuf2SlQKCiLTbPmRjRMevF2zTcBB3KRYXKmtK+zfiJzNjsiLW1uE0OIhBqgcKkrIaNNFIfAvVqil3awvJcq8RI3wKbzDlmmjEYGeNDpQIp612+R8zi0UuHtzOSzaEa0q8K5dn9S2P8ipVP51iDLruDDTTgn66upYiBiBh7YRX+lidcig7jvmP2gOfUvLjgRGUPQ5vwUA+TsKXPbxrVagXIErJAUmXZc73EOaBPF+NdtZKmTgve5PDat3o+GM4l9h4gSPH0E9h8TBbEo8U11FiISegvmRYZWbUMTcm4pMIot9eyHnMix9/rTk1TymBvY5SjqZ2jxB5ScLW3pJ2tY0SEPYrGnxVOZIS9ipXaPYpAqFP1j4JLWYdTUE7f4vVnbISX+WhqlBnFyO1ZbpqhBk0DceksdHwPRiltKJzsWD4B9SxuOm1z6ji+++Z1TMm+pJynICkzI6XdPtHBzxz6epABMXv7zPXgO3l1ykTRkbID8ro3MkHoaw2QCXQNTU8l5PXClOEziq5zA/UrHh5oQMoCuaP0kw0xcka415zmDYMCZe4ptA+OeFajv6aPh3BKlLDAif54XN8o9LzKQ4po9evjhBmXZhYx2mVAPq/NqAFPxBGk5SBMK/k59j3omg4R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRpbGVBV1REVjNHRDVDK052bEhEQTViTVJmdGg0TmdYYUJzWEVBNkIxQi9P?=
 =?utf-8?B?a0hrUEZUclp4bG5LSEhINkJzNVQ5d083dWM5UU9BdFR2WW94c1VJdGJONlQ2?=
 =?utf-8?B?MWc3ek8ybGdTRG9qa1VPa3BQbHZCKy9PU2IrSGRzTmplcjZpUnU0MXJOZi9r?=
 =?utf-8?B?QVpJYWVZMHM2RU1rdWlBK0NuWnVrbmVGWHRpSmMrbDY0VFBuK1gxN0FnVGVS?=
 =?utf-8?B?SUQ4MFFrQm9Nb0lJaGFFMHRoQ0wzVWRWcUh3OVc4UDFmNFNRVmhGWmttT3pT?=
 =?utf-8?B?Um5NTGFCSVg3WXhoOVRwYWRQTEJxcmk1b3QyMVlNUWNCTlBadHVWSWVKV0Jw?=
 =?utf-8?B?SmMvMGl1bEFpc0l0L1FyZnhaM1RWMjF0TWVSSXU3Zlo5blRIZWVuNjZOeEJ6?=
 =?utf-8?B?eVpBQnhGZXJJdUVzYURYSWNVZGIyNjl6ZnZpbTBVMW8zRW9HV0owenJLY2I3?=
 =?utf-8?B?QW1aQnpWTE5YVURsM09KQXk0V21Xek5rcklLcllQcXBxTjdZL0lmWC9lNWVu?=
 =?utf-8?B?TWNoSVJ5YnFDUzhVNllqelhxd0N4bXBmS0RFb05CSXl1M0JXSWVzdjFMT0dp?=
 =?utf-8?B?M0EvMEc4QUdlYlV4b0tFOHh3dFRtcTUyc3JmZkRoYnA1TW1yOEpiSU91Wm9x?=
 =?utf-8?B?ZExGSEYyN3Q2R3RPYm82V1RmR3pGL3E3RElDdEhVUzVNVXhIMnlHYW9yNVVB?=
 =?utf-8?B?Smd4ZzlubkRLcGhYcHZvaWlDOHFjN0dkbEZ1YjlvZkdJZXErQUUzZ1hpSVB5?=
 =?utf-8?B?ZHFEVXBTUloyV0ZBS0RaaHpkV0xzNGlJdTF6dTFlRE1UdE1FbGF4QVY1QWtD?=
 =?utf-8?B?UXBxbWQyN3liYTVNZFhWZExSd0VFSk01Q3pLMDVQVG56cVlxZjk3dkprNmJY?=
 =?utf-8?B?OGpYUThHckdLblFwcjNGMGJPMHVZLytuSysraG1BbkVGb2Q0ZU5tenM4TktK?=
 =?utf-8?B?YmwrUXBrOUV6VE92dENoTTZsSlVLajg4MVQ1T3JUSiszc01sbHpQc3Y5OUtl?=
 =?utf-8?B?QTB3dzRpZjVxZWs0dUdqUCsxaE9ueTlFY3FISHdzMVYzUjJXWi9JNzRGdmhz?=
 =?utf-8?B?T08vOHJ2N1ZKY3JsSkZqSkgwSEdNQ3ZHYk44ZW85WTh4KzJCNmZ3d3V3M2h6?=
 =?utf-8?B?R3h2MWw1bG90b0R3eC9xendoWGVWbW5OeTByM0xZbjE0LzFBdDZGQnhQeThE?=
 =?utf-8?B?aWtQSUdPOXRGMlRFenJ6YktKZmhSRm0rM3NTT1lmMmhVVmRvaTMxdDZ3Tncv?=
 =?utf-8?B?cXdwU3ZFV0RDRVJMcDB2OVFHNnI3UmdQSmRZRWZFZDYrbFIvcEdhUlVZSE1u?=
 =?utf-8?B?bC9DZm9MK3B6QjlVMzU5T05oYWtTZHpYN245VS9qQzBsZFNvUHdQSW9hanNQ?=
 =?utf-8?B?Zks4M0crWjhKVjZiZktkWmlXeEVLVEpMNmdZUjdRSFRRVkJGZHpVUVpMZi9K?=
 =?utf-8?B?ZVU4ZlpJSjlpbzAwOTVzN21SK09qUDB0OE1IOW9VQ2NNd2U1TDRRZzBDc2d2?=
 =?utf-8?B?Z0NjeGduNHh6QVg1Wm03Y1dsbUlGWjJ2d2xEdTk2b1c0Q0drMWttVmhWTWVk?=
 =?utf-8?B?OTJqSUpuMHhvWTdtWjhJMXRPc2h6dFFYYlJyTnlqdlp3NFlrU3BNS0JPRVd5?=
 =?utf-8?B?N2RFUE9CMFhXT0czZVFwNDFrNHpmc21meWFadHFPU1A1NXZNQWhBM2luUEsz?=
 =?utf-8?B?YUd4WGRQdWNpM0tSWDNIWkJUVmpYeWx1MDRyRHRTUk9xMEtkb3lVQXgvalhS?=
 =?utf-8?B?NUtibExDM0pXU1FWZDlzcm9EZ2tlNWtRZjcrQXZrdWx3MWZVcVJXQVAxb0Fq?=
 =?utf-8?B?dVoxdGNTVGk3MldUeThFWGhhWDI3a0dWaENteU51bGRtSnhGTXliM0c2Sm9X?=
 =?utf-8?B?TkhwaWpnMVh1cjVGQTVlcDR6RTlqZ3VzY1VEVElKNWthcjlLNGZxWTg0djNM?=
 =?utf-8?B?MXBUM21hbVNmcWk1QU9GOWJlVExTMGtNQS9XZGdCYkRyMmZzMFpwbkI1OVNv?=
 =?utf-8?B?aklEZDMwZWx3NGpJMjhBTDRZWEdpZE1vdk1wQ2VZS3gxQ3NmQlRzd2tEWWN5?=
 =?utf-8?B?cVo4UVVESk9pQkdZc21CN01VVkcwVkFFOERIZFR1RWJHekNRb252VXc2K0Ex?=
 =?utf-8?B?eEJpUEdMbGU2cGtOS2twQW5HNE85ZngwSW5Odllub0JQRmhPQTNkanpWNWtt?=
 =?utf-8?B?KzJnNm1XRnZuNHpRL2RZemNkSnc4d2NvNmd6R1hkbzU4NlhLeEJwZDQ3RjVM?=
 =?utf-8?B?QWVWeHJ4RU9QVmJwTjB2SUUyRkozVXVkRjRrT0FJcjMweWk2dkgvdGY4eHgz?=
 =?utf-8?B?TnJQUlVoSy92MzRCZytnZ05WbWNqay9YU1k4S2dwMlN4c1ZsUjMzeTBBNzJV?=
 =?utf-8?Q?zMkf9kTLqffbZCrr16o4phDfjktPDU7GSJ5tE7IlmmHf3?=
X-MS-Exchange-AntiSpam-MessageData-1: YeqFB80dBQZUxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff97baec-5ac4-47eb-def7-08deba65c326
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:56.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFXl+a58wK1pAoTfytr9TyCALgaEhl70g2HVql2WeFWZUKZpZKTKZEQD6HJ9OvK2NVFwv7qgVLg+MNEpNeSANg==
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

Improve readability by moving the success path outside of a nested
branch.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5266e15793cf..52e33fdd4f5d 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -352,18 +352,18 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         }
 
         // Using all the images, setup the falcon data pointer in Fwsec.
-        if let (Some(pci_at), Some(fwsec_section)) = (pci_at_image, fwsec_section) {
-            let fwsec_image = FwSecBiosImage::new(dev, pci_at, fwsec_section)
-                .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
-
-            Ok(Vbios { fwsec_image })
-        } else {
+        let (Some(pci_at), Some(fwsec_section)) = (pci_at_image, fwsec_section) else {
             dev_err!(
                 dev,
                 "Missing required images for falcon data setup, skipping\n"
             );
-            Err(EINVAL)
-        }
+            return Err(EINVAL);
+        };
+
+        let fwsec_image = FwSecBiosImage::new(dev, pci_at, fwsec_section)
+            .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
+
+        Ok(Vbios { fwsec_image })
     }
 
     pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {

-- 
2.54.0

