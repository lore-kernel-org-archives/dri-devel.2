Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A309DF9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134A210E5CD;
	Tue, 14 Apr 2026 11:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="StMF+TpA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7310810E5CD
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSke/enENMk+FOeCvwk9N17B6SzTzDny+e0mVcaR6PDwT7FiL1ghflZbhYNontp5WIex26bE34w8BYc6GA5s3xSMRXrd7uLThVs3EKmUWTiOY8RQyoEBJrVcyV/0gALFIl1/W28lzZmkioV1QRLMflMolAsmCXNzRFgpr+VD/0ZkyqBbgwEWGQzE42q+5oi8S5tY7TZpvHrVoFBWdzDWr0NAl9xdyWIGPQDzG+xMqGRFFnuVcuNT8ZzsofbPKGtJP9UzM6pmuCvSyiPSuWWO6rEem1Fd6UdPHXGGIGu70DOM/J2ksOGqzzdsn1YDE2MVT8NvzmQFrM+yM7/ysVFF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX4c5umw1jWiZsEhDMeZJwB9rX/FCvVJ8lGnq/iRV88=;
 b=UgXA7QtI0o9FOMgf2dgW/BwcCwLjdfnPrMwASs6yhhSqjo8yVHVTjEY21OHPjUcatZij1ylUJQWjUnE/IxMGZNl4JwWPEeNCepngt/pmIJq9SQP1IWS8ZZNWBpkIhiz1MlUAQL9Ej3wdjVS8LUJW0IHsW8rwwP3LajIWIhNX/l/dxSshLV+fpKEctKHwyWTxaj86ksZJrY7/L4Ip3FFuSuzlpNzuJ2nx0oruJmqR/8gCSTaRzctb9fgiTbe2psu/4Eor327VtELUs0LBIoWloCi0yCLoM5gkLwfCYKM1rvW3eF8yq2DPTU32WMP/v5W8bxwLafWi3tCgj2UbH+ZAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX4c5umw1jWiZsEhDMeZJwB9rX/FCvVJ8lGnq/iRV88=;
 b=StMF+TpAwdUVArxKoYDktrUCe0gN3O8pC7olUwHSI0uK6VU3sVDKcJqyqM9Rms9BQ27O6HvNKzsY4w6ZGriltwVntxkZThvm2KL0+WFE6AGUyipyia5R0UEslqMO1IZfhnoUUU2H7+IQuLeeLsMt6D5Z3Uq9s7QuutBSyI7LD9CbO6jn11Mi32OSJ5xfJvDd0OSIMoInBhpLRNP2bL1M8Nog4oGwj/TNekM2SeC1YSf8lvt5jEzTS2lgyCPHbttZtdqgvXY14A8ccdyvu+zKh3DkYO/GLfIDtCoBeut8LniF6oa5eTvGZ/Pj39ioEEJgA1OzALSC1zhNcvoG2JwjUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:09 +0900
Subject: [PATCH v2 06/11] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-6-705d30d16bba@nvidia.com>
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
X-ClientProxiedBy: DM6PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:5:334::32) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e10e90b-aa19-4ba5-14e4-08de9a1c9bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8w3B15xtcTQ5CwX0Soaoe5Dy44r+9evJPl0isnmoCpjtu+WlM7AM9nYqxmV/1JspWh2IZapmS/FzruXro2BChqrAdRbSFbw5kwjV2CNJm0KeiymM3X1afb617If78nPK2sXK8X6w0vh63wcCxkurx5fxAJvErJOHbwIBfYq03DIF1yBv1pdMsuYyEsdId5iG/3DASGTtjlg05xWG2e0T9kjNoz+xov6q4m6G/Ie3Ew1EwjVM2zvpLAvzBSueopnJrRQKlv4w/Fi+AJLPPIAcEodkL06VOHs6US2qD5QF0fzXddyNLBmlnWKIvkOuwt4pjXBSKX+B7B+VCKbo6uev66kqk9oHzuSCpPEosOBNia67GLBsO1QpfZHI1K8TADjSeFr/QSMHOFhg+izp4An/866jqBjkqkxDYymgDUr9hfODtA6B5Q0YMrN2H2DIaD/+s9JhplsEGcfWjaSRGIfRjdHA3b8gEDqiS0r+A8HbRwvovHHido9Knja78X7BIyXBaSsiAXose2Bw0Kkz2W5+fLqQXwFU2B0DEKIa7QheTju3E6junDFSBRQzCSPNG214lEPrTSoKlP61MP0AbBDb3++z72j3BqV8AZzUFMJJDeLW5WC3p0lNJWjMr6WVmmiN5FrPZZRF7zRJjZ9Ep+cOWzl7a3rZ98KzeVYnd3woi/As0fQMaz+BtjhVrUu3/T23Yx7FYXYDVgKtYZwFXsndCXJhOhKwvqj9gw1lEsJRZfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC82WDdrUTFOZWpyeGdVcnNrR3Z5MGFybXpSaXpjelRycGlpcGE5UjFKNzlw?=
 =?utf-8?B?NW0vR0N1TVJlUXlvUURTTk1qYlZlOEhPREtUTVB5aTN6RmRkcXhUNEFscThC?=
 =?utf-8?B?c2hvb3pIRk1GbVJoWWV4bFNQaXFMNW9jMlI5ckdpWlR0ZFY2Z2FIK2ZLaUZy?=
 =?utf-8?B?eFVPMnM1UjBIWkJYN2MxYjROQ1Zac3lSUHlCWVNuSGcrT2Q5aC91WFErUGNJ?=
 =?utf-8?B?MWtuV1FTTzFMczBOQStHbFk5cmovd2tiT053UzIwRDA3NklDdEpRUVpxaHBw?=
 =?utf-8?B?OVdMaXR0VkdoNXRURlc2OTM1OUo1a2t5b1g3YlRWaU5kSndmNVZ4S0JaQUtZ?=
 =?utf-8?B?Vk9teGI1YndPZjJ4cm9lcS8wUDRtTGZlRGRHUUwza1drL21mQkwxKzFjc1A2?=
 =?utf-8?B?c3dJeFNFdERGTWFVUU96a2krN2h2VDZXemtrSW5GbVUyMktFazNPYkVUU0Mv?=
 =?utf-8?B?Q0p2YzZuQTNUWXFSQ2Y1TlRTTmxYZU4rQTd4VnZqMElBNStDSDJMTVVVc1Uw?=
 =?utf-8?B?eDVEZFZNOXlsWVM2Y0hGZmxxSU9VaDFWZ0RKZUR2T3lCeks4dHhERDN1T3dF?=
 =?utf-8?B?eVlDemJRSVVMemdCT0pQWDlzS2h3VjEvSmNBVlJtbG80eWI0WklVa0k3cXp6?=
 =?utf-8?B?Z2QwV2NMZlFUMll2V29qaDhyRHVrMGxHVlBTNWx5bFVjUmtkU0p5UnF3a1NM?=
 =?utf-8?B?OEN3THJjWmdiZ2JvNGI5K0pSZTAvTmRmZ0FPcTFybW9yZWFqNnpGMkdsNnlY?=
 =?utf-8?B?dlRIV1gvS1UxN0JUQXVHSGtGb0xuZ1ZUaGNhZ3J6MXduYmhVd0hWcG9FYWRR?=
 =?utf-8?B?bWUzeTkvRE92aVlIZDNZYzEvdXMvd3NGNzdyekVqaTBKVTZaQmVKcDFoL29p?=
 =?utf-8?B?VjBITUdIOEdxMkNiVEtiQ2dvQ25nZDVwcTRKRnkxZUNmWkI4Rm5FQjUzREZv?=
 =?utf-8?B?eFluZ1RQTjNNdFlhYmJLN1FyMjJQdWJndldZbDBGWnY1UUN4OWZOaUZ0UkYx?=
 =?utf-8?B?Unc4My91Qm9hVnFMakZIY1ozU3lEOVZlb0E2VXVwamdNOGFjcEwvTkVHUlJ0?=
 =?utf-8?B?VlRHU3B4ZU1yMEQ4czExNkw0bFVsNXFyWS9ZNDVxSDFFOEs2RWlpUUZRb0Uy?=
 =?utf-8?B?SUI4S0RPTjUvTkwxZ20rZm5JazEwRTNLRnloMUc0VTVZVnhLcU5QVTJXQmtF?=
 =?utf-8?B?bEs2dlBFdGxndzhuSWtjZ3UyTStrOFZ0dnZUOG9pQ2lhS1VmNFM1SGc2bWZ6?=
 =?utf-8?B?S2tiWVE1OXI2Qi9qb1crZmpoanpma0xqdXlmOWw1WHVWSEVENm1MWjdva2VC?=
 =?utf-8?B?ZlVJa1RrUUdSNWVjVElPd1dDY3YvbnptcmZWZkprRFAydmNBQlFSc0lSWTVC?=
 =?utf-8?B?WXlhMlJVUTdGTDFCKzBiUDBrVFozR1lBTDgyTm9TWm5WQlBZUHFSZGovY3NY?=
 =?utf-8?B?ZE9RMTFwMkVyUDZSbjFLcDU4UlEzWkdGeE1MbVN6Nm13ZUNITTJCWElMckh3?=
 =?utf-8?B?U2NGUHVuZ2p1NjNPSzVOQ2ZleEVIcjVMOGxHQXNqcEQvTndsRjQ1RnM2My9R?=
 =?utf-8?B?MkZkeVd4aGw5SlU0NG5tR2FjTUNVa1Y4WHY5L0QrQVp6UjI0VzZFWmw3dENp?=
 =?utf-8?B?OFRvMFVoUEI4aVUvczQ1M0hHeVBRaTIrcFczU0FmVGVIOXlrR1RlcGdkZmFU?=
 =?utf-8?B?UmNyZEtRcFArS1BHbEowRFFtRHkxVnNlNE4rM0ZFYXNNR0ppUFg0WVlqR3p3?=
 =?utf-8?B?bVU3WjN3SURibUNnTlJMci8rSnNjdFBCMlhXdkdwY0ZMbUg5dWhBZW9va0ZR?=
 =?utf-8?B?RG9rZmRTV2FHbzBmZE1lT2lsZituN2VtRFRiTE5NNUNGOXlvTmFiVEp6NVVK?=
 =?utf-8?B?NC80MENqMjBtUnZOVW1DZjl0SjNsVkpWSGFKWUU4UjBrVHFIVytTY1pUYzJ2?=
 =?utf-8?B?S01wdHJJM3B1ZWlwNFpSR0JZdmxCMXh1MkJNU2NVMDFKbzZKZlNLMVJJWVAv?=
 =?utf-8?B?RUU1ZEUrRXpJS0syamx4YWV0T3VTVnd1eFhUdUZUZG5PNFFCYndjaGVPSzNy?=
 =?utf-8?B?TUJpT1ZQbzYvRmRSN3pmSWk5VHV0T2paL05BWW9adTE2aDMrYy9yRVJmME5v?=
 =?utf-8?B?Y1VWMmczSFRnVFVUakxPcUUvbDlRZWwveXdEZWZkWEVoYWRwTzhKSFFOeTZC?=
 =?utf-8?B?bjU2b052VkorZ0RSV3NCMDFXYlowNW1va1k0ZjM3dHRpNXZlUjg5bVEvSStT?=
 =?utf-8?B?ejM0TDM1VDdwcTlZMlFJK29tVmgwMWFydCtabVBQOTVNTHBHODlFN1JFNzh4?=
 =?utf-8?B?VXhLV0hrY2lEb1JzL3dpV0RSVm93cm5DbzBDQVUvNE9uTW04YVFxY1JzOGh5?=
 =?utf-8?Q?HNDgQdbOmojaunrGYc5q8wYKucX2R5y2oCMj5gVcgMzwl?=
X-MS-Exchange-AntiSpam-MessageData-1: SL8m5S4d8F10VA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e10e90b-aa19-4ba5-14e4-08de9a1c9bdd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:39.9005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzy7MRX+XsrLDJrGo/CjG2we1EY1lBQDWujSTO0rDkz7u2iFQTb4kSFNI1PtR5hOKG/3GB3Y4mIypswgCX1tBQ==
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

This is unused, so we can remove it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d8633e61178b..d63af95eb642 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        falcon_data_offset: None,
                         pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
@@ -631,8 +630,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The offset of the Falcon data from the start of Fwsec image.
-    falcon_data_offset: Option<usize>,
     /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
     pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
@@ -934,8 +931,6 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
-        self.falcon_data_offset = Some(offset);
-
         if pmu_in_first_fwsec {
             self.pmu_lookup_table = Some(PmuLookupTable::new(
                 &self.base.dev,

-- 
2.53.0

