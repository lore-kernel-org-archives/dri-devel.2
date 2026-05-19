Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB767CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B14510EA24;
	Tue, 19 May 2026 02:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxZSkoLi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEEF10EA24
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6FIux4WdrUJOVkxroVdC4sXd/DBfPkNhyu+S7mdJpf1NqtkkjoGTBmq0QJjN4T+XDOKSnbjbQ7WBYCxEdMeYUMweHD8HQP18pK8IruiGErK6MEIPm7E0n1prihbGVRabcOVdCXFPGZTJMc2wfEp86udjhmk9jFt9lLIP3sHeJq3qu8jJLS2C4/y0NHj7cxUUycE6q0orbLEwHOMoSdqLNwEixz4+JNUuyQMWQQU7N+mnWvwN6vW/XMgVpFslKzkscgBOsIvIQ0/MkLBbh59tm934ewFd1Psa2oq9lkFYL27ZTsdiVvCKesRfqizq5+KWCvkPmcf2B6edaNb/t5+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvjv6tNssKQAeTOWmUfxcCe4GCfeMSwX1vT6S/xlEzQ=;
 b=oYyQApAPj/EHqXXOc9OyShJ1Kqs7QZeWVc8FdMOhF5lNVZryIrVjgOktpypQbhOz8UEGoK1caPoTHejVOrRRxF5fChuZSPNpXMZkL9IwkLA92h1MaMzYs2mkO14+VuiL1vM+h62tY4mCoyO0f8hGk+8eI1zZIY3qLqN5DuReqRnl8ciup8aVBkhZkVF1+MAIS6NfU3vzSPgrZPsRwEZ9NsuiXxCn2dH0oj+5GllEUfAyfN3nLJtVGkMrYf+ykML2ZEGz4sItEGIplQAkcd2IziYNUoNiI1Tb2VSBDmP0pQ5UwBtPeKNUN3bGbnjbt1/5e3hIQPYnn36uLi/rxfIMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvjv6tNssKQAeTOWmUfxcCe4GCfeMSwX1vT6S/xlEzQ=;
 b=qxZSkoLirzKQ8xejxOXjGaErDQOBugSy5n0YmJy9NHJ+2Us0quvZhfjs3FTPtkDSkEhKuZDNikD9C7LP4XK7TPOrCnezt5p7WadJycEFZsoFmI22SVQ49SFTqgb+4KD4ciGA3E8fyMzYpfITneUaCzzrv/uDsFY52KXh98YPLtR6EWOqKz11oE6BkyzyhQd7p9UmxBMqk/683vMQ1xyjPnm5GGO+g52mRMNxrGGnMyLkd+ckz65cty6WOAT1POk8tw3BtryAS06wKvXAMtUcxcCmNVNqPgdq9mQ0+tjeQFvF/+ZKS0XmEu1zKWMH8L01ZRXipbHBevWUK1a7Zauj+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:23 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:23 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:02 +0900
Subject: [PATCH v4 08/20] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-8-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: DU2PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:10:232::26) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6486ba-fcb7-41b2-fd30-08deb5523626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: E8rQ7NmvceiQkXIkzYy/+GUreyv0oSC36QZGA6N6Zzy2rrT+YsEH9K90hMX+ZC9lqz7m0QakNf3EkXoUjV47zfWDwbavXWJ/Pg+df7l2xlpm9D65jxvjQbwRUAFjlsHbe1LCg5Dm7Z4Cdp4zU2woq37+JlJIUPpm5opLZWQa1U2pvt+5O7/SYhsCekvrrg5JfPPOcIo1K9J9Knn31Y9JKN/kJNNtOStDT8ehSF/JrOh6nL2XXJuXW/xjIZb9lGQdl2Ejvhqtt1hX80f83MbnrZaqDVJM6HqBU5SRVndUXoxspk1hDvnPjnYjcewskdgeg/Cxc2aa7jccNuWf6BWD4Cq95KGR1YLtWaPAP6964hw8oobYzDLPqgbJBOR8PwZmoXRpcLL7QYiJisOzQiAcNvdUJe8m8ASgPJlZStadbFJGxg9uHdB/dW/teFPwkJT74bSAQ+Z8/HHWEClG3cLgAoqb4GaJvGuAcM43tkf27IeRaNlv0VJys2h8Kni4c8GHS3ASZ0oxiaWB4Y6/KeTvR5BMyax0qu/2r1X/RR4R4tGQv60TK/LJiCzbqsxYjrn4LNBQZd+zag6w/7uf2wjoun1MuyaqGpY8Dt2LWA8AIo1L65gMy8nEBHtTQNrLQb5FoRholMBC7hD/LKkeoqhw/h0bqRATl+1DHDCkk4lmD6ylaKcicgmlAf+xxBR/ePP0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXV3cVlPeWMxc3FFSzdRWnd5T2U1bVNoK1BOVTBPZ2ZLUDlSbFllZkcrM1J4?=
 =?utf-8?B?NVVHdWhMdjlRWnovSWJIN1g3NEtZUU8rbHdaSEQxVGlRT1J6NG9lbEQxUEZq?=
 =?utf-8?B?M2tmb0xnSCtOd2ZLTEhOWkxiOG0wcGltZG9FOHY2YjduTVExMnNhYWlEQm4y?=
 =?utf-8?B?Qml2V1lCS0kzK3hlcGdKMDltUm56Ylpoem9WMHoxenZjTllUaTRPbkk3VnBq?=
 =?utf-8?B?WkN4TzdwQUNFeFBSd0N3Q2svVWh6MFJqVGlibkJHaTlmL3lHT1l0UThrdDhx?=
 =?utf-8?B?U1BzM3Rqdkd6dUxDZE5zRzJTV0Z4dGhGVXVDK0F5ejg5WXNPb2dMNU5GM1V0?=
 =?utf-8?B?UE4rb01FU0l3d01vVlA4amlZSko4cHFYSDhuUUdjWDhyMnBOZ3l5MERwZDhS?=
 =?utf-8?B?K0ZvQXZwRlUxT2NPNThicy9PRXRnS1AxUXVWQUR6NlBNS3ZTdGt1VVdkcGNS?=
 =?utf-8?B?SkJYT1I0RUhKN2lOWE9VKyttK044NjlKU0c4L2Z4cnAzcEVDaUorTVduc3Fo?=
 =?utf-8?B?ZVhFQ1NlcUhCM0wxNDlzWjR6VFlPWm12aUJML2ZNTG1ZWEdabm4xcmdJdVFZ?=
 =?utf-8?B?Rm5xOGh6UHdsNW1ROXd6RGNqc3MxUHJvSHp3Z2VSU0FDellKWmtUVjFOcHFh?=
 =?utf-8?B?MW02U1I0TDBQZzI4Y2huc2JVUFlFSnU5MUNhU0NpSForVW05NjRkZlB4aGRN?=
 =?utf-8?B?Yi85N3BSeUFUZFFad211eHdkaUhKMnRCOGdPQnVIK2tNQkRMOHlyd2prZCtq?=
 =?utf-8?B?SlROV2JONngyRXM1RzY5ampuWWhCZVN0SVArRCtZMzBBRytDRmJxTWIzbmg2?=
 =?utf-8?B?c1gxdy9mTVEwUGphUUhSdGtRTmJ1U3dsZ2JXb0x0MzVKdzY0T0tHQk00TVdo?=
 =?utf-8?B?WHhsd01lS21qSjNmcFZSTzRzQWkvMlRNaXlmWVQyZ2NNb0FxS0JrbVV2ZTlw?=
 =?utf-8?B?U1lIa1pUbW9aZ0dXQ0dRejd2QkdTTHhKMXo1ejVTZ3dxRmhqYzBVWENpU3lu?=
 =?utf-8?B?TXlFQ1RVdXkxK21tVU5OSVdOaTNKdnI5MFhUV3hHMzBJWW9wc1JRV3hxVEdU?=
 =?utf-8?B?aHVSZGIrcG5GN1ZSUnh0ZURQMGFHZkxaRVorM0hvUVN4QXNXWTUwUHBSemRB?=
 =?utf-8?B?UllLSXY4cmdlNFN3bkRLMjd5VVZ1SEFPME9GT2ZBSkI4S0pGRTJFOVdCZzNT?=
 =?utf-8?B?Y0Y3QWloTGJIby95Z1BvMld1TnlQakN1QXpPbFRRckNTeUtEYkR5Wnh2dTVW?=
 =?utf-8?B?ZU5jampRZTRrQkU3Mm5WcDBGYmJiWTRGVFh0YW54VUR6M0hXT0szVGczVHE4?=
 =?utf-8?B?TGlNYUsxRUsvczFxSXJtVEorMTY1VzFtb0JpeExPNjQ2aWw2TU4rZmZycUM1?=
 =?utf-8?B?QURrTW4vL01hendiMm1GYk5EK3QvSkJ3dlNhM3hvQVFhakJ3UHNuWCtnZ25G?=
 =?utf-8?B?M3V6eDdBWjVNcWovRTNNYVJDaUV1cG9iYXlad1MzekxqUGlCZWY2ZVNQaDNJ?=
 =?utf-8?B?RmZpTnVoMlZGWmxBQll3dmtUb1RwZTZDbmNQemZPcURMbUxTK29BOHZKNGRo?=
 =?utf-8?B?NDg3SXJIRFpXays2WVBtTGVqK1BwRFJqVWxCVU0zVkZ0MGtXZlZHZDBWV3BK?=
 =?utf-8?B?OTcyeGlkNHk3SVNGT1JPaXZNVVZiY2J2WFo2Sjk1M2hRUlJRTDE1aVpKMEl5?=
 =?utf-8?B?OVRjOHJVVmlaZzZhVGpBSlFWWkNDMHNPZkRQcjR1NXBERlZoTDRxRkVacXhh?=
 =?utf-8?B?TkxTbmZTZlBHYVhpUzl2Wm16azcrQi9QTUtNNVZZeEpXZXNtMUE0RFE1SDFR?=
 =?utf-8?B?T1NEV0tRcG40QlBpRTI1Q3hEV3dvSWNBTnVSYWZWMk5SM3RJcW95QUNlTHBR?=
 =?utf-8?B?a2MzQSs5NG4rWDFLWlpyZzBxcGJtNkM3bWllWHR4RmVPd29tc2FNVklUR3Zp?=
 =?utf-8?B?ekxlVWNGZjJ0blUrT3gwRjNpT0h4MlVZdVo2Q0pMMW95RjhEODdtWGN1N0gz?=
 =?utf-8?B?SXc3bHVqTmpKcmhob0hZaUNHRUs3UEhaL3lrR05sb3FvOTRzTVBuZUR4Y0Zh?=
 =?utf-8?B?UlUyUU1VUDZOcldFdjlHWGF2cUo1VUxOSzJhaHVyMGRFeE4zNDQ0ZmRrQTNu?=
 =?utf-8?B?WHRaUUl6Y0tqcGIya0xEdlE4eFN3NDVGRTV1cjdRRHdsZk5LLzlSL3ZMZjIy?=
 =?utf-8?B?Nks1OTFreHF1Tnd6U2lZbHJIVEQ0RHJJaUh4c29lTnlodForSzloeWpOajNK?=
 =?utf-8?B?SlM0VlpMSHZrZ3NkNE0vdmFUVGc0VjBMMUN4VXFuWmIxczFvQ3plOFhQRXJy?=
 =?utf-8?B?R0xGcUJGVFhIRkIxUE1NbTNhV3JvNFg0dWFIQUZZM0VPaTNJRHI2dCtYcUts?=
 =?utf-8?Q?rhJciLX0B1/RcD9WS4zHQ8lDNhf3gqpVRTe0LQQsSbYYs?=
X-MS-Exchange-AntiSpam-MessageData-1: sNW1fjE1vaCR9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6486ba-fcb7-41b2-fd30-08deb5523626
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:23.4784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mRd4H6OO2s149hAlHuxSRv4M2jV0TExrgpwUlYUYZokVQWgC1uH7fkXp3l7c9i9rdNsOQWumverrEqyeaNVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 871f455bb720..8a0e16e6c9e8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -338,7 +338,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        falcon_data_offset: None,
                         pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
@@ -712,8 +711,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The offset of the Falcon data from the start of Fwsec image.
-    falcon_data_offset: Option<usize>,
     /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
     pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
@@ -1015,8 +1012,6 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
-        self.falcon_data_offset = Some(offset);
-
         if pmu_in_first_fwsec {
             self.pmu_lookup_table = Some(PmuLookupTable::new(
                 &self.base.dev,

-- 
2.54.0

