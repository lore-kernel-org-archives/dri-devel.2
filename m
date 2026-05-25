Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D8CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA30F10E135;
	Mon, 25 May 2026 13:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQYPjFHq";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4254210E135
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDK5B5/vgZ0X3nS01g5PCzi7FmmmRR+fa5TlnNq9fH5sy9Tc2jvPD6fkQ7H4eormwxPpxF7PFwkuZ16nZ9p7ZLOqGwk5zD4ZJ3bk1jvHAE3fgCDw3QQ+tcW89MJGGxxuxLNwm/T0E0Q278nIsuYAnlhQGAlNiv4unpXpi2tzqJ1SMOZ/1NxAL0lO4xpTjfYfrSggyRnCLYeCk3GKwXPoa+5cbWoJxjt44KWK3jZfc5EDDlF/lfIT31mgafMEBJBQncp5pERnRh+a0JAJH6cOAOlYpNpl13J73zlLTjSjHsCM2/ewuCeroEDQMeopqe/5fFHaA/s8Cu92LNKQcVxyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aya5SSUspW33cSt/mUi+BYmEFlX1Nx5xPW/ipmlmzAo=;
 b=VviTUS36eZ/w97uZglJwUBglpshNCh+Lta5nON+c5g5XE4JAf0PNLz9rbJllb5KZUArprLlr1QNGxomOgEDl4+LiRKY+Nc7THNowa0j+yXJep8dtbmj/UD1f0n8bRdK+5R//nSSSTLku+u/GPyzJR2BIvc7mniTs/fIk7IrMZShN1IapvxKP20wuXoVYtwxyLz8YFa59MGPXwWoVF1InWUY3SZzgQHOWxB832d0DTD0cdQ9wnzrDkhNbfLrnF9z+57fkeg+miC7q9geDVFOWfdHDiwZSVTeHtOHN9QhrRFec+8+I76uf03m+OnJIl5O0fWsx9F0R4XB3Lxg5zwQj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aya5SSUspW33cSt/mUi+BYmEFlX1Nx5xPW/ipmlmzAo=;
 b=IQYPjFHqlWSVk2UG1KSGoY6lj0ZwlWyZu9A2k1LenvZJJ6JNY79zmIWx2Kg35JGPDla4KSMttHB/GBWmbayDGkcGBSjav9RQr9stKv1YzDbpFlyhvDNOGcrSy7pPte/y50W4D/6E5Dab3RG+VyaUMgt/H4sMc7CNE0fCXZSHotycvx17s252FwIEJa+O0PiOfYU9H6UjreVj+dKyQ5YX/6TY58Q0pbpLEqQm/jUUrqFD3A4ac9NH7FZeuAm1Hjmouhp1lOUiRmSaFJ3zXnGCn6XrMKxyUDwOGGlEeclCR/ZxfAuBP2/9DWnKtgXmGgo5cP1Ld6AVtd/FydgGzukjDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:03 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:23 +0900
Subject: [PATCH v5 05/22] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-5-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0226.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 2451d579-cf51-40fe-c014-08deba65a399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: kncDmUjACT5ZM7FdOO9fj2qFhUOfKDxy/0D0I2nfIx9VKPyDvUADKN5XJqCnjUrTa8/QxR4YAZP34NPNm7dbNYyXoRW15VClmrWcCA/IZLmy22iMBJ4TobIRIvqUs/L9Q/V0kIU1/wsMIIX7Kb+Vw93NuvteKfmdLqlcUFU6skiRL7aqYVd45y3+x3W29eq+SzNTbzYpP3tEl7VLg1ZvGrk4NlK0xfRIvursPLlQa6Mn0u0k7+U1Q3mkgIBQPrbkvvQE+wAkthwRxDYbd1hlInT+kNlUg6LXEHvon+I5zBHQ08YWtv+HlRW2HFaVjYhYUaIy0Xfa8UvnH3zw50ktMGJ0Qb2qeDBQNcRO8sT7UEU8e8kqlR3yAfBOU45f/myOC7CMYGhzIcCb7oPmvsCewhNoXHcnF6k5rLeEvUarZsN1Io/KAUCVpBAL9DGf1i9NPbR4qHzmeVVHT//oidgBJDhjlYHmCTQPUxrw0h389fim2rQqNcD5WiQHPLtJ/3zQ+2hCay7ThBkAvZef0PVp4RbwGmlgs4BExPC5XqdGYLVRvj9PpbTXXo57E6pdQU5pXxaE1Tx0VsQTt93g8B7efP7tL5/DO0vbUUT5FU8MsLRWYVf5tlHp62SIsQFY5hZASPgQwHgTmuLObGvBCib4O15UnYO2O4zhgPmLRWHT/S7DY70izz7AzAdn8qJabS9a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3JjeWRXYkdTejBLU3U2STZCaThUdm9haFJmVSs0andlYldTTTZzaGI5VG9n?=
 =?utf-8?B?YXgrTkU1YzJqU052OXlrNXFTWXRDdDFHRjVuM0h0bTBkWElqRk1oQkZRYVV3?=
 =?utf-8?B?M2FUVzRtV1ZwWVpHMUxobVpJeGQzM0xSZkFMWGtWcnloZ24zajRUMExyaUUr?=
 =?utf-8?B?ejlpK1paTDlJL1RqamJoTHdCeTVmbUhBaWV6bDdPT3VJajlrQmFNdnpSeWFv?=
 =?utf-8?B?R3VBN3hVZXl2aGhyMXB4TjRCMThDUjd4RVJmTm8vMm1CQ0c5UlBYaXV4MTht?=
 =?utf-8?B?bmFrTjhTclRRNFR4TGd3U1ZlelZTdlkvN2o1NGkvSkxpTE52OUl0dWNRYURi?=
 =?utf-8?B?UlJDanZiNnByTzBGUW90UFNKblRkWnhZdmE3NjFPTEk1UFE5OG5nZzhlOXo0?=
 =?utf-8?B?dnBmMWxCYk1mcXVxdkczWFNVL0c3eDhrZGxuZTJvQk1UdmNoaVArM1g2Wmhv?=
 =?utf-8?B?aGVpY0tyWWE0SlFuc3lYUklncnlDSWFVNFFqTWNrdVcwRTgwcUdWS3o3WUF2?=
 =?utf-8?B?aHdZM2I3YWZBaWhtNHlJUVdsclQxL0Q4M2tBR1VjeTBhMzd1MTdTQVJVa0pN?=
 =?utf-8?B?Q1ZWbHB3WDlQS1NRejVUblRUS1ByRmhmdVFXSnMyeUZ3UHBBd0toN0xMVEZH?=
 =?utf-8?B?RmluT1JnN0VXd29EanZacm1PMkJWZWhDQ0pKOHd0VGZpK3VaMEhMdkM0azFy?=
 =?utf-8?B?VVFkaExGS1ZUaTB1UGxMM3g4WWtzY3VZWnl5VTBtcTJOS3NtSUZKSGRWbGlr?=
 =?utf-8?B?SlE2THlhMFJIa1hrL3JuQTNvM25FNFhLV1FrU2g4Yk1UYUVsOVpWUTdrejNC?=
 =?utf-8?B?QzFhcUpOOHJTTG5PaEQxcTc4Y1BXdTJlTDBXY3F2aExhY2NXc0g5MmsxR00z?=
 =?utf-8?B?WGNQZmp5N3ZoSTNiUWdiQTdhRlVNaHVjMjZTWmdIOC82OC9CSnBmdCtkWnJ0?=
 =?utf-8?B?VkRnYzhueTE1dTJMSjF1YWlSbDl0b0Q0VnJsMUNDekNFbXFBTEZ3VXh2VWpV?=
 =?utf-8?B?NDJpUEM2VU4xa1dwNmd3dGNQSjdldFpQSkJxNVU3Vks3RndMdlVDUFJrUDVP?=
 =?utf-8?B?Sk8wdnVHalp4bmtNVEdlODBtdkJRM3ZUQTFjeXpzbkdHWGUwNmUvQVZJaW14?=
 =?utf-8?B?d1FnaFErZFo1YkRURmdaTlVXNmw3YmJEL01tRWRDV0VUdzJpbEx2Vm9UZ2tw?=
 =?utf-8?B?c0xkbGs5ZWxDdjluOEVBNG1IUzRMNEpPWXdlNHdCTnMxVlNGMm9FTDNXSHJ1?=
 =?utf-8?B?aFR4SXlKTzdpV25zdWhoNVBSUk9QaWE3QmFJYWd0RjZaVTNza1l1UUJRQjkz?=
 =?utf-8?B?Z0NVZTNIU3lDTkxPakpmd1c0dkREMzJPU2JHVkVKWG44SEFoODQvRENScjBr?=
 =?utf-8?B?Ymg4cWxodWQzMFhNblUzNExzM3pqdnNqUFdCRTVhc2hhVlVEUkh1VFBMU0hQ?=
 =?utf-8?B?aU1LdkpWUUk2OGhxMC9IVWQyajZFNXdyOGZHZFpMRGk0eFlBTjJZUlkzMXJk?=
 =?utf-8?B?Y1l0UUZ5WUl1K2NobjZNNnZ2bWpYZGxNL1BPWHRadU5UUXQxM0JWLytLM3FK?=
 =?utf-8?B?K1ZYNUNpMDZIVk0wVUV1VnlKdU1wZVAwNDc1ZWNSM0o1REs3clhCZWxYbWhZ?=
 =?utf-8?B?Q29WeE1GRnNEb2pZSkQ4d3pIU2FpRGVXMWw4MlMydE1wWUpIOGg0d2lGR0x2?=
 =?utf-8?B?aDd6aStvSU92b29jQ0lodi9nUjV3NVQ3ckxuM0FXT3RDYW9RVWRoQTVwNkov?=
 =?utf-8?B?Y1J6UnMwcDV6Rnl5elVLUUhNWkdlOVNaVFhLT2lDRFczZ0kxUGY5US9rSmFO?=
 =?utf-8?B?N2dTV2t0WU1jWVJtMXBNU2RxNWs4R2lZMG9HQTZ5UlVvQWlPUHdNZExaVjBw?=
 =?utf-8?B?bisvWkRwemJWT3VGaDIrb0szTkU0QXdZYXo0MVNZK0xOczBibUJ4RVhmakto?=
 =?utf-8?B?enMwVzBqdG5qcWhna0pGZTdVTGNIakVsY01PRENmYXltTDR5NnZrcFRJLzZ3?=
 =?utf-8?B?T0Z4MUlEODdpVjR0dHA3OXNoaldoc2FjbE1xQnlUN21mazRCVEJ3c1V6SFM3?=
 =?utf-8?B?OHJuTG92T3VFT0IveVJGNVFjZmxHakxHQTQ5MUpoUXNDSFc5M1UrKytSTjM3?=
 =?utf-8?B?NlZhZndyKzc5RHZtQ3ZHK3IyYWgzVStBaGVoNTg3Z3c3a3RsbVQ0bzJQVVRP?=
 =?utf-8?B?d3kzUDVVVnhMVEpic0FhY1kwL3liVjNIZjB4bWUvZHBsSU51U3ZEWXdrNmx3?=
 =?utf-8?B?N2tua2NkUFAxV2k0bExmRHg4SmN6bzBMUm53c0QzYjVWRU5iR0pObVdQRlpO?=
 =?utf-8?B?U0FMZmg3emc3cm1Sb2pBYUo3MXA3VXR3a3FrcUlHMlBpd3FsZ2txV3NFWXRs?=
 =?utf-8?Q?dk7dgxZ42E8ECOgCLFu6X/udfGmprHqxtu5aJPFKpw3p3?=
X-MS-Exchange-AntiSpam-MessageData-1: Gek0O6tEpSolHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2451d579-cf51-40fe-c014-08deba65a399
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:03.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhEQCUL1IZvIAreJNWawfslfEHlH/aA9t2vIemlkY/eXnc8WBVVpTfT3R14a2Cv9qPKk532iN/CcSgxWUYp0Kg==
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

Use checked arithmetic and access for extracting the microcode since the
offsets are firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 2ff67273fdff..c62d918a3041 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1110,16 +1110,18 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
 
     /// Get the ucode data as a byte slice
     pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let size = usize::from_safe_cast(
+            desc.imem_load_size()
+                .checked_add(desc.dmem_load_size())
+                .ok_or(ERANGE)?,
+        );
 
         // The ucode data follows the descriptor.
-        let ucode_data_offset = falcon_ucode_offset + desc.size();
-        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
-
-        // Get the data slice, checking bounds in a single operation.
         self.base
             .data
-            .get(ucode_data_offset..ucode_data_offset + size)
+            .get(self.falcon_ucode_offset..)
+            .and_then(|data| data.get(desc.size()..))
+            .and_then(|data| data.get(..size))
             .ok_or(ERANGE)
             .inspect_err(|_| {
                 dev_err!(

-- 
2.54.0

