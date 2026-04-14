Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CAAF9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0392010E5CB;
	Tue, 14 Apr 2026 11:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFzxnmvv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85DE10E59A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWZapIlK7HxRS4+xeYECO/3zqqh3jNngloAkclle4iKpHk1Jz6SSngUiYVcu3ebjKyiefc92t9AdHIW8pQfso4n9jgnwwrlCnMupsTstJG/R0WIZfT2KoZU2sO6JTwdxDOkSrK84sC0aQvNNKWmJ9jGZ8Nv9Xfz7evcoh+AROge0pfAqFWKnZ948ASpcmA0mGtBBPFD/TJiCSkJOYq1e40qKvgMEQmfDNNLcGlMcgSJ/7JPa25HketwVfsBQ9uoxHpeRO8JrY+wCBhJ+giKP1YxJx9N80wRJ2cbSi3BKySPYB6DPrhMbJpdmQqcTmEkDZ4hZYDY5LANEUT+Zk6sQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dolz7HNMwtmbh33dqChZLSkd9tWJon2voQ8rSsLXKoI=;
 b=bVgIDHfZtOkjMfe6aXcTJ7kvf+pfgLlurEoV5/SJQ+uw9LxLL5zuRFB3lJJTuT6TOrQjxm/QHPeMWwc7weSrwrAg71RKK2bAuBJ7u4QQmCJUrjpzjpgmxil/TwcTvbGXFFgZ03vLZ1/mPBBJIoy3nrUsKwnUgT0Gh+DsWJJzp/+qllQyIp85PMXdmeshS7rBcN6lZmo3iuxXg/DeK+rmZWR3QLj9oD760dlCRrVVmnjCtoWfjOwf749dl0lVCYFwYLhcLebqSZfs0+W23R9AuySvNuSzIzty3X6mOdakJ8d6rm4TRiVHv9nF+xugGYbLfH/fsXpYgdEjLE0FneDA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dolz7HNMwtmbh33dqChZLSkd9tWJon2voQ8rSsLXKoI=;
 b=XFzxnmvv0BkHv4CfLnQ368pfUaEPdjOrS0ZWWVScgfoMdC13PM275yr6Vzb7QRCuoZ1Bbt2jSNRBYaI4apaaEr2g1qdFVr9FD6rfYYuNK7ZCfnNBG114aPa+qtlX+/ByTEtX+uj7rybR1HXCiEmhCVerRphLakh0ICIOGmUXE1Mgr+/mhUIc/0icALpw1OtBYGNo5FaND1eDpHCaxLzs5rPQj8Baj10lc3M4j1uG47VKYICh9279d/IVJ6fKEfiR6IqqK6S7zkDu70a9fe2PG6MNCFiHF9/+5LMQXKg6T9XCuOlQ32WGTWpCuIBdHXnDAkiMw7V4SJ3qzSRkqW2SkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:33 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:33 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:07 +0900
Subject: [PATCH v2 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-4-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e32c611-8264-40d5-0653-08de9a1c981d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ecJKHlVU1naAiCa7noFRPBq0+9YsSgERv4oXZyOHGoJcZOXs23rgw1EipgkL+tn9Uw2TVgSWYj1+I7E7TBmti/EIf9kaFU+VFHw+SQwDYQYZr30KzCb9uusnnN7nXdkQw0g17snxWuIpbDLgt38ylZeHbVBp5ZQP019HDVKB1BEzSdLKrWBdg5x6yk8ePskqmtYo2+VdOR8XiTqx2dakLZNGUolBVYQrC4tlJtkg5ux1m0vwhInniz3IvYQKXkA03bm8gE+572ocjpnoXa9OZVcBn8snmEIP8GPnl6rN2HoVC+Cw3qmuo+y2RqoYMsDADp4MGXphLf3jb38lfCc6p+bA3Bgk8L9y3kspoOf7P0yBiQ4aHwI4TuqgHDLFaP5kAXTu5d0H0JYWdPleCk2LKr1ySAS2arqbWnQYfcxjBgcohs1w3AQsynoyzOdi2hghXbkSwvHgSFbezxFbY99bsPsSAcAX4J2fFqGJ5hr6n5PR1yNlmA3GLgIfr9SaqVbYGfmdkbbvap4BhJgSXn5lJwBK6cUnQHFwR9018+WZix/0UAjgqGOH5rJ6AZ53VGi04Xl4Lfr05ODesbGmXVUGshc3LlXmups2ZSZl0SZopInTD+tqXyzwAKkp2EaG/HLvcnYTIs0f9EhXcexU23mfOxBJobNBWeUY9NWE2kKValgdOrN81w3393oLZHTb3LV0j4ZqaMQUJXx0oqxPait5706Z4rh+hddu4BT/8N4HyNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGlERnZSdFJsREhzTmZ0SVh4RXV6SUMrWU5LVUhWRW5vSGU2bnRLQ0tic2Mz?=
 =?utf-8?B?eWdFc3UzV1ZqTWdmMFpmOThLY0svcGp0aDJGSDlzMUQ1STZQdUFIRFU4MmZp?=
 =?utf-8?B?d0dhZGxOKzBiaTVqSUxkS0NaK1JtcjEvTHNRVFA4TVAvSFZMQUNneWJORFk0?=
 =?utf-8?B?SVV0WWNIWmh5aEEvUGwyazdqeEdqVHdLeEJZU0ZRSWdoU0dFSU51UEpSTis3?=
 =?utf-8?B?cGJwRFV2YWtIZFhtS1NkRGp5dlR1a3lXWnRFcFA2M1lUdmVZOGJQbGQySWRs?=
 =?utf-8?B?QVE5ZFo3aTZ4NGNHbXErTjdDZ1BNQ0t2NW5ERGh4SXNTa0p6bUxSU0RzZkNx?=
 =?utf-8?B?cDBzLy9EYXFGYnhhY3l1Nkx3cG8vT1lyTGFZcEJUOTY2cVRCUXhjMWV1RG56?=
 =?utf-8?B?SGFCb2tPVklWZmhmbVhKZ1JYalFHOU43dUNxT0F3aTdUZHpmeW91WnU5Wm96?=
 =?utf-8?B?LzNlTUM5RGFFNXNIdmpKQ0dVK0ZUTWpGbGhLazlEdEd3cXVaOHNBSGNPenA2?=
 =?utf-8?B?QkxjQ2x5VXNuYkxDQkREK3MyMm1TQ05aWWluTnhzN0txNXJCc1RhYzlLOEJk?=
 =?utf-8?B?NUtGdWZJd2ZLdFRpSGhZb1IwemdJR2FoTDJDTFhBcDF5UW5US3dWSC9WY3B4?=
 =?utf-8?B?OUJpMGtweEJQMlBVN1FEbWVMVmhTRXYvbnYwakdLYTd5U3JKOHEyVm9qeHdw?=
 =?utf-8?B?TUhZZXR3bE5SeDlkZ0ZmTlpmZFkwZkt6ZFU3YVNENlNSRUJBUldXMW9BUkJE?=
 =?utf-8?B?bU1aQjhwam5uQ1B3WjNtMXBWWndwMkUrTEJqWWwvRjVlaGh5aTBlc2xTUmhj?=
 =?utf-8?B?Rm9LcXRxK2xSUzRZSG5pQlNydWRsb3ZIRVQrUTB6Q3ZsUWFPd1IzMG1vQmsr?=
 =?utf-8?B?bGZadkxteWhvbUdDc3pYb2Fadnd2RlpGWENIR3RJZERGbGRleUE2RzZ6Vzdi?=
 =?utf-8?B?d1Ywc3UyTVh2bE5UVHJ4bEdqQml0NXpHRHhPY084cjFYRnpJdk5zcWVZbjcw?=
 =?utf-8?B?dytSdFhxMXF3cDNGak9kbFRUREJKcjFvQ1BscldOa1VmTXk5cWJhWDdTRDc2?=
 =?utf-8?B?RnQ2Y2JFT1BXa0tETjdFY0dtMFozOU1NckFMd3IxL1Q0eks2L0wrZFRaem5t?=
 =?utf-8?B?YVlxQW1GM1RwTmwvUkFPL3JrSkc4dm5haVdNL3hQeFlKOWxEa2hkU3k3NEpy?=
 =?utf-8?B?a3JRS3hBNlh0cTZMY0Z5TldnMUgxeStzTGR4N3ovVHVnUnZiVGxFTnpJalJx?=
 =?utf-8?B?aVpJSWhaZzBoM3hlYmtPUGtRdVJLeTFWV0RPb3IzVXVSSUhtL043MmJhaUlo?=
 =?utf-8?B?Y2pJUVdkWUdZYlhjek9jUmY2Z0tMeTY4Q1lYclRUdytiSjBFaVByV3JldVNP?=
 =?utf-8?B?amFLUEZFZGRqVnNKTDJqaG55UUl4R0dJc1N6Nm9WOU1YWGUxcXcyaFFicW9C?=
 =?utf-8?B?S3RGVXVYMXlzbkJZTDlpckxJcGxBdDhBLzhvZDFLQVVkcVNSemVHbEd4SElJ?=
 =?utf-8?B?M2ZnMlRlcGVOTCtZL0xrYjlvQ1g3UFZZa0tOSzcxdGxaVmcyTFE3U3hKKzJG?=
 =?utf-8?B?K2NhbXQwWlhSeHVFTnB6SVdLMzJCSDhOd1hlYTNsNlp1Rk9yY1NiVk1CRlpG?=
 =?utf-8?B?N1lNNzZwdjNqMGNWNm9vZmhuRXVVUEUzaVdUVDE5Qy92QVp0aTRSVjJlMmEv?=
 =?utf-8?B?Z3pHNTVNTzBRd0RSNFFSVE5vaUkzRCtISlpWVWtHRlp6dHdPODhlMTdWVVly?=
 =?utf-8?B?ZmMvTEtiRVd2M25KYnhRS29FR0pjdnlqc1N1WE5DMi9Ta1FiQWJBNnYxdkRP?=
 =?utf-8?B?NGE5M0Z6ZGQ3d2NsOWh2bitIS2NvcVVnbS9LZm9haTVXQWVyb3plUHBVcmcy?=
 =?utf-8?B?M2J5NStXQnl4ZlFiaW5yazlBTkFvTHhFN3pDR01IaWpMSEIvNStqanYxVmZZ?=
 =?utf-8?B?ak1qSXFSZGxtSU9GcjZCLzRPMkxtM2cvN3FYRmloM1RJSFJ0b25iZ2o4RGNI?=
 =?utf-8?B?Rk5NdXRxaWNGaXVPMDdUT0JuMGtNRTJZdFMzdG9PdldhUjlFMlo1d0xqTjZi?=
 =?utf-8?B?aHY2UUhLRVNSTnRuWkZKZW1pV0YvdDdHcERSU3JpNVNJMkVjbFdpOVppd3lm?=
 =?utf-8?B?NVpBdUpJT3AxeVhNR2FiaktuOWI0aFNMZ2ExK0NZcWM4YUF5eWo0ZTlsZmUx?=
 =?utf-8?B?UE5UekRCa1o4ak1VMTZLWWJSaVBOcmZiaFQveEE0WVVzQnJZeGx2U1lSS2V4?=
 =?utf-8?B?QjcwR3pmVGtFSS9uY0pwU1hrR01GMWpsZnZEVHZnU2Q0eE0wQ2NaMHpLZEF4?=
 =?utf-8?B?L2VzeStXWGpRQWF6OElwUjZIQThZTTBJYmtJQnoxTnk2K2plNUUxbzB3V0Mv?=
 =?utf-8?Q?SPeQkqR9FZE/DE8SwvyY1ywbN/cQPI/wjIWu5RCzLg/MS?=
X-MS-Exchange-AntiSpam-MessageData-1: bPgDuDuSS5+xBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e32c611-8264-40d5-0653-08de9a1c981d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:33.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQYNEqO4lGsJ5BlN86Fj912inHn1gteauYH6k0pQNuPOJT7Ltwuu5ln8CmMcWXqzkDy0zkbdZk8bsOh3fsv/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

Use checked access in `FwSecBiosImage::header` for getting the header
version since the value is firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 632c8a90ea76..bc752d135cbf 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -996,17 +996,14 @@ fn build(self) -> Result<FwSecBiosImage> {
 impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
-        // Get the falcon ucode offset that was found in setup_falcon_data.
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(EINVAL)?;
 
-        // Read the first 4 bytes to get the version.
-        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
-            .try_into()
-            .map_err(|_| EINVAL)?;
-        let hdr = u32::from_le_bytes(hdr_bytes);
-        let ver = (hdr & 0xff00) >> 8;
-
-        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
+        // Read the version byte from the header.
+        let ver = data.get(1).copied().ok_or(EINVAL)?;
         match ver {
             2 => {
                 let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

-- 
2.53.0

