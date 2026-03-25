Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29040106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A48910E895;
	Wed, 25 Mar 2026 12:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bT1riV7C";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD0610E895
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CshuciMg9WmBtE17KpFM48nnlZkKz6MTFPjHPxsZfdKiHvHgxQY+/IAFf0h5XDFvUrUJO1vgA+5rzyM6eurZ20HyS3Bge+A92qEU1Ae45S9oU7pyHOm7UwruvG2KT578wEbQnN09bwuO9jzHml8Cug0qOMgNAYKgqZKhrRi9OVa+foAWX13AqSCQ9a2ECGQCt17DXzBZvuApitWuU1mp/fQPVwtaQ483SCkuBBdXmLNpPYlksRaPcaQBSCmhlbLZ8YVuBfoDOLDM/s7bC0VkTJWe4OQDUl67tDzbCmS6P+bYXrT1QgTmMPKMGtgbpM+EwTF/NhCpMCcjr07gYI1j1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRW1aL/d5DYpWRV5ydij8rbP624UomG4dN2QXf48veA=;
 b=dw8jWLXem1/yXsd19AtM9iexYWj/lhyIiUwStzANHU6vzper4TGsYY6UeNYnlUusmnm1SuyNh1cUmGyzgsgOmiGC2n3rOJSb8eauheRFsbb4GeiL22evOfc+w3yK5YbrW1IGavFRlouBpAgEy3huiEeGbXpSiWVPEz6AKIYIf+1xBnAZCAp8xlFL5pF/O+8s48CA0maA4KdXbVsHDTxl6XVDeNgso+9EU+WzavwQuqQjjXfC+PGXTb0ZwW0OQW2xxcu22UgbVnIsxmTj6k384dLK8h9yTjPeW+E2VwMx9xWsRMoTxMMS8/GJJqlNzB8wBIT8VlNs6hYjY3XqDTsYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRW1aL/d5DYpWRV5ydij8rbP624UomG4dN2QXf48veA=;
 b=bT1riV7C3JJQN5sYcs/7sziuC6jT5yljvcpQ/BH/R/aphOPdlXG5dX9HYOQj2WiAdOB2MMkaIFZ+bOKVFUM6tCBPTM6HQ7gpXzlolQ+ffNN3eJZZf1A1x2Wk4mWjrIoyguQOzY+qyp4xAQBqTR0/MehPwZs85tdAlakj4OTOs92el2qWVUGwaH69XzS/7GK661oaXExAQ+zz81z59YC636qt8n1C9SnkISugpp3HeSTwcSPH3u802bwitP62EFLvuklTf7rgqsg0pkWl7NBQCTbYHERsuScJDtGmy2F4S3MvnMisAjS2zPBSOQBKQ3XRUCtN0n3/a/1OvxJd+DaNXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:42 +0900
Subject: [PATCH v3 4/9] gpu: nova-core: gsp: add RM control RPC structure
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-4-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e13dd0-18bf-44c5-a3c4-08de8a680138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: awm/QbroKniheV1cZYlxmlSKA8C6HiRoy0jw7/qHN4MDmHZpioo16t6qEF4suz5/lxknjQH3PbtfqETMh/jFKHZ3e1SNMDgJm3CKjsju1C+qBa9rUQ0K8zaxydlpPbzCmHLaEm9cSeWK14pulN3n+W8Feha9WBgKhroXQbeowEHZIfTPRZ1divcydVm06xyxznwSu+M7EovfTQ0uOPD9C+E7yHbqWSAaA8LvObUuETW6HBD73IYt/SH1+/Na/uKhRxHHeSGO/1rEMZL3s7dVI8NXXOm3Hw0fCS4CBX2Dtc3/pc+V4WlloUDm3x6U3QPTq3eT2HA4pg9QhKrb8O2AnFmLCycEn4ZGha1PFvA1cunReVIyZxZxbOUit745VK+VwD3Wu1vF8aulGgX0OJMCT+5oy1V4OnV3NOwjIYErSzNqVGRbfk+TNcaO5UOp8HdIRmL6d32s7clvcjmJAEgeAqa5Bd14L11nMwjenxe+OQl4cY5pia37UcTPwhAzxuUTtqZS/1FVVAtn77RJ4P0bps+QgQC8/Fi4WLCaaEIJwV/l7IdQIDeGtPo19XwsfaLyjpiYTVbUO4ygNaNBTpAEvR3SVM4WX5lyGEykhSAJS4sYNalDZOCR4dJ+dAi4r6XKR8YDhxU+2WVm32YgwiF4ZBhFFKvBqzE+JeH0dgbRB8ey3ggLAHVZfEpyLKg/n4eY6PYwy6rzRQVU4oAzImmRmPzmgZq7K9BBOI4Kmh8CsvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZCd2JURGYzQ1crSmY2MWN6aUdrWFRmeXAvWG9hcnpsMHlDRXJQdjFvTUxV?=
 =?utf-8?B?ekx2Yzc1aGtEQngzbnZoYURlekFpUHZ5L0xIanNqek82UlhubHBaVi9iTG1o?=
 =?utf-8?B?ZXdwUTFLLzRFVlRFWW5tZUNMd2NJMThteUNXREpjeHhOMGRVcUVMUzB0S1FB?=
 =?utf-8?B?dFlCTldEaEYrNHJtL0hSdWxGSU9EQzFpMDBXMnhNWlU5VW5vdTNGUXU4b2Jw?=
 =?utf-8?B?eGtsQUcrSXZ2VWhaa3Vya3NOb1FjL0JYcmsvOTkwdXhQbllzK0hBL0JKRmF6?=
 =?utf-8?B?ZkRKK1pEM2YrVG9xamlKZmtaMi85VUIybzB1R3p2a2Y4TFMrOThVdTBBMGNV?=
 =?utf-8?B?QzAxcGl5N2ErVHRjaldJc1B3THNhTXF6V3JDeUFEM1Z4ZVB6VnFMZjU5VndM?=
 =?utf-8?B?L1hVTWpIdGtXT002R2d4c3BBQlZGYWVKUDJTTG1pU0FqN3hrcWNqTGs4VFFo?=
 =?utf-8?B?Rm8xOGRGUTBWcVdMLzRmZjJ2L25sSGVaaXJIMklPZTlxUW1HVEJzMUlEdWs4?=
 =?utf-8?B?UjhzTGRQTExOUjgrS1lsc3FzaHhNUW9hR3p6aFErNlYyZHNUcGlmeWxMVUk2?=
 =?utf-8?B?cU1uSGRRNlZVT3JHM0w5aklCcDdhWmU5bnRjODJBUlgvcDAyVUVaTzU5TmJ0?=
 =?utf-8?B?UWVaczZqMWNSRWFzVnhQc09wK2VSblh6VUZuVDViVXJIZFVjcm5GT3MzWDBu?=
 =?utf-8?B?dThxRHEyMmowRXFUY25icENkYjFMd2xyWFcwcjdhR3AyejhWSWhKdDVJdEh4?=
 =?utf-8?B?MnhFSGZEajFvdEx5anlnTExhTDBBOU9PZGZ6cmYwK1h6N1RIZ2ZJNWo1TDFn?=
 =?utf-8?B?clJxeFlVSUFGQ2k1NTJVT1BWekl3VXBMd3Y4b09VUjdFTE1YTmpVSWEzSHRD?=
 =?utf-8?B?UDByOWpGdml1VE5BMW9wVWpJRmhMOEk5SFZreS9IcXU1dWgrTW51aEJjcW16?=
 =?utf-8?B?YzhyUFFhTE5uVnlZMmF1djZHTTk3ejNodWhQM3FLc3BWT3pEc2daSWk5NWdW?=
 =?utf-8?B?UzNMQnRFOFE0WmVaeTZlUDhvNlRDanVCZXpnQlFxOGJnUkNSY0didkdwNURZ?=
 =?utf-8?B?OVRHa1p6Uml2OVFFWmQ4bzNWTFpGdmFtM3A2VTlQbTNIYTFTNkU0NTBPVTNO?=
 =?utf-8?B?ZENlM1NYbXdaUnpQWHhjZC8zaUZjSXhBMVN5NEFCejdOdUdkTGF4VkF1SVNM?=
 =?utf-8?B?UFAxUWdxTURQRzIyMTYraVE3eG0raHJyUjdlaXhLS0VaQTAxMHFaUTlRTTdH?=
 =?utf-8?B?M0hpRFFqWlIzZTJSc3Nqc2Z0UEFHc1NMMW9VRHVhL3MwUlNsODBaejZTdzNv?=
 =?utf-8?B?c1VJQmFrOW5Nd0lGVWUxU0RTWHFoSzhKZmo2dm9RWGZRdXkzRWRsZ25QMTR5?=
 =?utf-8?B?TnJ5TGtqUnZ2Wko5THdlVzhETlNBRHhuU2tXT29IVjF5QVJEY1hKNVAxYTRr?=
 =?utf-8?B?a1F0R0JnWCtXcnNySC8zUUx1UVlmdlVTQmZHRGJBQjcrK1QwRERHZ0FyOEJr?=
 =?utf-8?B?SXRVWXJSekEwVHhTWXVWbUJjbkZSVHZ0QXNnWWVwUHprM3ZIWm8weHNzb0Z2?=
 =?utf-8?B?a2cwNGNPTlJ4OHk3SzM0NjdQU2pIK0kwdDR1UnZ6eThFWllmcFpFZFh1L2hH?=
 =?utf-8?B?Q2lqMkgzTSs3L1RPRmR0SW40MGRuMzB1VzdpMUJHOTMyRkRBenFHZXFINHUx?=
 =?utf-8?B?VUg1WDZ3aE1QZzRUT3pYU2FYSCsxY1UwU2FYUGo0OXVBZzdHSFNEbU1yckIy?=
 =?utf-8?B?c3pxVjJVZWtOSUIxMG9ULzBSazFDU0VJZTIxT0RVcXVUcXJoeEhiNVpwWEFi?=
 =?utf-8?B?U1gvdU5BTDhmYlZPVVlzNnY1aWdqZVFJMlBKWmg3ZGVNQTZrSXgwZUVGTno0?=
 =?utf-8?B?dFZ2ZFRTakdpWUpxRDg0aFBLNEZjeWtXUE5ncmc3anNIMGsrY0dYVktCT25Z?=
 =?utf-8?B?TjRqcE56RG91QkhYbDhoZnJmemtpR0ZEa3JzOFNRL2h3TGFReUxmNHNhUkpU?=
 =?utf-8?B?SXVMTEtxc1hmVWRFVHZmNW5zbGZOM2drdFJmc1Vmc2J4ajByN0lkWHpjSnFO?=
 =?utf-8?B?Umw4dk9JQjNBRHRWSW0xMXN5YmxFWUtvaDMzM3BPbkZDdXB1bTZybE40QzQ5?=
 =?utf-8?B?dmhEQS9wSkl2L1NWdXZMSXA1UGtOYzFEMlNNczJJcmlFeC9ueWJIS01qSWNn?=
 =?utf-8?B?L1FtVE9hV2dRaTVSa1lXdjhBSCsxSVVzY3pGS282ay8zSjhYU2R1VlRzUmpI?=
 =?utf-8?B?czdyQlpsNFE1TnMzd2h1aFZwalFwZUJaMnZMaHZKdzVTK2tnN2lMcmc5U1pH?=
 =?utf-8?B?aUZkMmxPdU1Zc1orV3NWN1VUSWcwT25iV1E3anVmOW45ZlZyeFRpVEdpZm5y?=
 =?utf-8?Q?RsmTFGDThh9saBT5SnchKERyogHrVjcT6fOB1RhhBNLk7?=
X-MS-Exchange-AntiSpam-MessageData-1: uzMf+xa7YQz17Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e13dd0-18bf-44c5-a3c4-08de8a680138
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:03.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6sb3ZPq0jGkzxNVE63bnYJ4NNlZtxeAu99FCGN9QXTZt5OlANkSg2i7SReSlPFvaKLDIvlxxxirDAKkCZ1QFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Add the bindgen rpc_gsp_rm_control_v03_00 structure. This is the
structure for sending RM control commands.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index dd37a7fd58c6..05e205e6dc58 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -1025,6 +1025,17 @@ fn default() -> Self {
 }
 #[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
+pub struct rpc_gsp_rm_control_v03_00 {
+    pub hClient: u32_,
+    pub hObject: u32_,
+    pub cmd: u32_,
+    pub status: u32_,
+    pub paramsSize: u32_,
+    pub flags: u32_,
+    pub params: __IncompleteArrayField<u8_>,
+}
+#[repr(C)]
+#[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,
     pub cmdIndex: u32_,

-- 
2.53.0

