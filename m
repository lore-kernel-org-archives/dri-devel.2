Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C18ECD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C37010E36A;
	Mon, 25 May 2026 13:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lMr7sDSX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AB410E352
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m78JVcms7t/XuY+xygOnGQFTQnEUFFTyXhJwUAtSpQq1nnWjsfXOItnClPzo70SduCut1fJdZBjLXGz2KA6u+ymmIa1e0sCo8zepOK7HPmsGbNoaq3YpJsMy3vMVyr1bNePfxtkLE1PWtMKypZqqLN76jYc122ap4QyeLYJJvge7Z6hHG9P5ymtOu7pnKx+uUF3aJwlj/JlFWte9kg/PdfHV+YD4kEU7miSXgweRVVWmVel8ouXgnzb77Tk/yHctfBOBUGBfkpUwm+bc0fAhvs56/gAeCRocbYEInkXKh1+a1yvem/WxEK+lFI2jCYAWlT9uZPQxCzWFmS8muqdnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz2frmdQCV8KbxwY2sX54Zp2paWfnuU46V5smLr4E0g=;
 b=IyavOQkmJ+I/AOTjpQePsUkINDQnxNt3pR4wTGpUUaxxk7moo7EpypXuyjI1+6JjQlhPGhxexBm5WsT/mRoeK78OP95GBTBpuMRmFD9963jhxeWMLRDTphO8lmKSV8sdiCFPTATSEJgc/9i2COlLZM20nTj/YjFWsXP8iYC4ncvzMEkcpPbDvzOBEgaFKCTa7BnSydXNJdvnRmMv7pCfx4lctCO4DRIvZBKEBcD74p0BSp29A2JOAWFbwV8h2M2+Obt1OuL0SQKwxZcBwlxhttdmPlaLOTQO22TdGSJNKpp4Xsy8ivMgGe1UE5nppu2UhiOWu8Xg5gndy0TwqWnwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz2frmdQCV8KbxwY2sX54Zp2paWfnuU46V5smLr4E0g=;
 b=lMr7sDSXo/nJcp1gwcYM5vZQyKHmVwZTtwdLaTyko+5H0pnnJmCIwXRSv5kEcDCSiE/Z2Mhh1hZ0B2PlTl+I4ZY0Wyw/56tL8Gz1pMj2ACpzvvdvsy5uP/jJd0XXxh3UiPSsKqE+fIj3DOaUe5eA5+vCzgcQv0YStsZWn+F+w+0oLBr1hPH5GZ3VSIinXSXV/3idTpBTTBGGdfjxwK3nhQP5yimXrQHjXozeaD58XrlIf/DORdKQz716XpS80zUOPyFRautBmCPuW+gUk9mcKi3I+Qv4npRMSpR9ZSW3bzlnBOgGIld9AqGfPJNR98V/CNSNO/vFhL010P0slg8cMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:57:46 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:57:46 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:19 +0900
Subject: [PATCH v5 01/22] gpu: nova-core: vbios: stop scanning at
 BIOS_MAX_SCAN_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-1-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: da137d70-8589-491f-b535-08deba659961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e575AZI6+ktEM8PcaJ66G44WFWquM+hfzi8HO9p2Y2LCMe+huI5EJaSUl3lLfqrl2mrZq06eZSmdNOVseOv+QeiJruhYpCs4bxp7Ft4kCMQeergMnOwXNXWcd3fMhmhVMCgx5AXZJTHpycczmlKysjfMnepgvLhjPbi7vnG8F6naTUQpdxJ6UeeG1IzoqYYzd3VHCuAjm7OyICe1O5s+qKEiruFEbg85nYwJdqpgChD+MEJt4HYXTGHKP+Z0jGVpBPNanpRGVI9X//tUrpC87HOoT1AokY6cV1uFEymAap2a+iIpgwICDhGMbkoW7SJedg/kcVWOklJubdRj37UnqwSenXmjDJLI6n6+DSzROodTC4rStuB0lXGQjwGdIzdra5pxbyJEdFdtgYM2R+lbAI2cLpGeWwKsIyZFL6cnXh+5Pl4fwwS612ZZtzZT+HMKFP9eNVVRdX41zfTOP+QWyuSDrD6kk3qkoqtpgLr9PgvfKy+qmu3DKbosTiHK2Y26ujWSp/3HJHy5nfE9WyOZbVTNwy4fG19YkUph6TYT7yIT1Cjrnbd0i9OXMw63pdoD58C55KjsCv2FzLTjQLQusFuvGN7lv9KSFvbVFScqOnrZRdm8YCI9FVVN6ANiPsV5UZG6psAFtcAiacCoq1rOrrkvYSymqyFDXmiS5faZeFfB5hj4slue8gUcKdFTnjZ8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVprcGJLbmxyUnd6Z0RNQnBydEs3YjQyVzV1VnVKcnhscithVDhTaWFvV2tu?=
 =?utf-8?B?MkhTZENITWdITmd6amsrdmQ1UWl6MzZSMVZvVVp2UXQ5VjlyUjFTcE4yL295?=
 =?utf-8?B?NnVUS3pPNWxoSVFuRlNsQ0w4Qkx2TW9TNlh6WlRrR0pHVzY0SjNRWXo3bE4r?=
 =?utf-8?B?UVF2RytGZ0JCY1hWeFpYSkNCdmhIUUJHbURReWpLVW1LVTR3Y0xYRTRDc0dH?=
 =?utf-8?B?Rm85ODM2UjF3eU9Oc0R4YktoM3RwYmoyc1dzcnV1Ti94SVBUUVlTaStFN1l3?=
 =?utf-8?B?ckY4R1BLdUpHN1FEeFVEdnFOUGUzVVl6OGZGK0V0Z2s5dmhBUGVnUlEvdHhq?=
 =?utf-8?B?ZENzbzhHVGwvSVlEWHAySjhxekRVRWd4blJHbysva2RvRDhLWkY1SnczRTV3?=
 =?utf-8?B?NitrWEJtRzYwQTl5YXNLS1pLeWJKUi83cTBHYy9IaEd2TXVRYmYyTmlCdjl6?=
 =?utf-8?B?UkNjNExXV2UyRytpUnp6djZUZzFOcTM0SDhybmlMVmVoSEYyTDcyRFcvVkZ3?=
 =?utf-8?B?TmRmQWh2Q256L1I1UXhmRGMwWUxvNFRGckFkUktGUFdUOHRNeHI5VHVXVVdF?=
 =?utf-8?B?SFlqY1JtN2J0S2s2TVNLcklvNWN2Y2c1NEd6OGNPdmxkb2lUaE5Vc0F1NW9v?=
 =?utf-8?B?akNMZWptUnNzYnNqWHF1bTE3RWhCZGg5UXA1ckxieTU3Q2ZLVmkwUmtGbXhQ?=
 =?utf-8?B?NWRwSzVscjd2Q3puU2xpdkMxQ2tMT2xZdUZXcjFTeWNDblJrbVRwYVRjdUpD?=
 =?utf-8?B?WUlzV3FaTTZnelRGbXhjb0xnK2xkVjRHYUovc0pUMHp3azhGOE95VWtYOHJi?=
 =?utf-8?B?dVppbVJBOXg5c0tiUTg5RG9aVzdFRi93ZDZWZW9rdFlTczZKd2pRZXZBYXk0?=
 =?utf-8?B?dlhOcUNCNlRoTGhKQlNYWDlsSXh2VW5jaHZzZEovYjR4RnltTjNhcmZaTFlz?=
 =?utf-8?B?L3l1RHpGbWZXT1R1a2hvU3VCMEJyU3Q1b3VkZVBGNXBkRjhkVnhHQkxOdmVm?=
 =?utf-8?B?M29ZLzM0eUJtaitqaDIvZTY5YnNDM0ZWN0YxRjZyNkR5SXlOSkozRSt6Ukx4?=
 =?utf-8?B?WlVoYWVLVXZpNGM0bG1rUm95UUdqTnpWcnlNSXExcmMvQ0ZiKzRUVjhQRDlU?=
 =?utf-8?B?SGRaUTR0U0lWTm15Y2U1aFpNaVFZbTVVWlQzUkt1N2VsNEl2WVdjUm1JVWhG?=
 =?utf-8?B?MExYWWxjYlNXT1BRSURDNkExQ3B5OTRCWnBhekNjcEVaU25iSDQ5R2lobVFM?=
 =?utf-8?B?M3BRQjNPMGV0UDlxRENZZkFnbmVZV3hsS1JraE44TUFjcFEyL3JCVEhxdzJP?=
 =?utf-8?B?QUx4eHhXSXljZFhSTUpPendFTHo4WDdMS1ZZbnlFcDVQWDhTMFdsN05qcjBw?=
 =?utf-8?B?NTBGVWhNYWFIL2ZpcGtsbElVYTdpR3RoWDBiVDJZMi9lUmNid2VwNEpGWmhU?=
 =?utf-8?B?ZHJqNE9wSzdBRDJVQ0p3cmdSb2NVYTJBR0RKcUhXbWZJUmI4SS9TdTJIUnRU?=
 =?utf-8?B?TUNQSkxqQTNqQjJrQmlqZTJBTzAxc09yN0dpb0xiOEMxYWhUeGxBdUhoUzFP?=
 =?utf-8?B?SWxFVnZpUUlDNWp3bzhBV1Z5RTh0UTZzSnVZSWdKYjVCSGVBeFZFc2hnajQy?=
 =?utf-8?B?N2NSNmIzb2NDWmxJMWx4bFJHL1pqQ01nZ1Uycm01dmN0cGFmbWNhd0FHZ0dj?=
 =?utf-8?B?MzFjQWhBM2V4b3JGZExLS1E3V1lYZG5SRjlaOHZJbVgyL2Njc2I2TlFGUFZx?=
 =?utf-8?B?dUdpaFBaa25haHN0RzRNOTZiLzV3eGs1aEhLTGtlVmp2OW5QT0ZUdUtmcGxa?=
 =?utf-8?B?VG9JeTlKNk1MbVFwMU95NkhIQk1wdWtiMHQvU2Q5U1hNQVNXL0U0bnJ3ekVu?=
 =?utf-8?B?RUl4cTBscHdkeU9HUHJkRW1NWTh3TFZjbUxqTEIyMVREZ3ZjakJ0bGloY1Jj?=
 =?utf-8?B?YUVrUVRNU0FsQnVaUWRITjdEVEtzT2JXNk5ENUluZ2dOeFltU0xEOVVHYnhB?=
 =?utf-8?B?VDJ2ejJ2MkovUUw5ZEo1emU1bUFCQ0liVFdxYlI0eHJ4bmxVQkh1UEVXSmdK?=
 =?utf-8?B?aHdvb0plc3BYWTFnWGVITWdGN2xzbHpuTGpabnorQ2pzVXliQ2hjaW5DNTg0?=
 =?utf-8?B?OVdtYnUxRXBPQUFsNFJUdU1DVS9FZkVqTURwcVg5RS9lRE5iZVRiaWlkVG9x?=
 =?utf-8?B?aVNQUEFMVzh0dXFnM1pBOUZTT0ptelk3QWM2dmxrRmJqdkpoMytYeG5GQVh0?=
 =?utf-8?B?aUkrMmhXUTFFOXZ6dzhZaU5Eb1FIczlmWmhLNjhWdkh4YnBnN3Y5cEM3YktV?=
 =?utf-8?B?c0xYZk11ZEJVNE9udmpCTDhRazZVT1d6Sm9pVDZoU29udk5MN1FsdnRzdmRO?=
 =?utf-8?Q?cq0Mp0ZBYSesbmIGbYJ2sH4he+AKeMkF8bHiIyJ/WGgnC?=
X-MS-Exchange-AntiSpam-MessageData-1: BnZ8w4oIZBB01w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da137d70-8589-491f-b535-08deba659961
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:57:46.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yDZzG3XqEharYkK2g1+OTtupX4ZtiiKVzRKb96MnBDOp9xelUjBzWXvheIi56QaWeuyCdt2GrSM9r1yCQq/cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500
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

Current code lets `current_offset` go to `BIOS_MAX_SCAN_LEN` which is
one byte too far.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 6bcfb6c5cf44..7bec81a37340 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -272,7 +272,7 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        if self.current_offset > BIOS_MAX_SCAN_LEN {
+        if self.current_offset >= BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
             return None;
         }

-- 
2.54.0

