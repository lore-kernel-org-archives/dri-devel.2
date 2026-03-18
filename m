Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B4FFCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8F010E6C7;
	Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uT1PeN0u";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4142810E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTHuZ8xCRYzpiIBwW0QJYjet5ZHBk0hp8RE2FiJK3mdFDdMQuztprYLRnYiVj2Urbxted7E/t4UKjnwyj/i9SS1eoBMO8FUr/1Vr9A4UkpiLNQx/GZU/UNyZZvK7FGmr9UUB/RuuKWV6NrM2vFjXMHRyfylkx7u1npxo7wRlmh/y4CnXvKH3K2U3jPD2hC6YJz1ivn4/sjaZ/9GKdh1IZbjsDQN66TG7jVC/OV7vRTFUtLVfsKOE7BbhViffyQklgaMuNNI3AL3Z6XbEMs05NdJ325gupsoHOnhXedP0uX06hHEQxgGiodcGq9XV1c7toIj+7FoTPwShGZE5vc2zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRW1aL/d5DYpWRV5ydij8rbP624UomG4dN2QXf48veA=;
 b=iV5Hew5cHjIFaZ8piY3sjbfAThSlWcOecnqwqJe0FDNSdkxDt+/unXJJkU+XhfBgCRf7W1EAv89tbdDTU+PEvhMVaZrbq54M19tGuP7ba6pzJP7GZ9fAGBn2/98kBRQeCu307RBlym0FccMfVX/sfsJOLqIDLTMOWraNn/kZLiCP/ouuYQaAmwTnSoCAafn3Gy1xzKi/gbE5rojxnVOeuHvRCcbAf3Qo5f2YZaVqPMJ/g96JXxtgQlTYSXa7PdMq6wwR3C7/kgZ7XlJxwL5rccUX/hbmQHBMBVGYQGaPjIIVo8o1p7n4/1l2JFZGAI76TSnJyo93u6DEWyJByhXApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRW1aL/d5DYpWRV5ydij8rbP624UomG4dN2QXf48veA=;
 b=uT1PeN0uSUIXoXwR4bBY40OaxaXzS9zDF7ySTrAo/WNeHLcHBE7E97pGe97rA4ZBkVQxk2NmvIlXiMRcJmCUtT/fkRtrH/wVP17u6FeWsXA4jhnbeDGg2jOsWYJiwnGRPwT0tB8i5FEsnpEnV5IzgKF8pe0d90mbRDLkwWk2xJ3PzvPHaiOxjgWKHpLO2UDuAES7tdSfVhPfj5JlPFPin7HMqqoksANrN11X6ikEigcH/iweo+n6TsBAyu9sQeNFCFcZt4OEz22lEK+0p9KeK3j/UUXBAy3gYY3HpvfeeP2ALeS2pcCNlQhsloSWvwCxD5iugJBrAcTDjXZjxh4uDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:50 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:00 +0900
Subject: [PATCH v2 4/9] gpu: nova-core: gsp: add RM control RPC structure
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-4-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d43334-20e8-40d7-e4d2-08de84be0b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2ViGI9yOl299hI/7fUXF0kwFPqJQDLMofTHC2t8V9yJO//uYWCQLi0HKTjWYr3gWWo890A+t+ZRHvPVjtTInoMBozKVu8Zs+rBsaQ/oHVJz/4m0nNhANaBsPmyJDTeuQR8qbi63CBMn2HmNp/OknWbxwqU/YOL9WOnKyFtAT4x4zUil6wv/cei2FoIiFtgeWrSs1ZNUPsBwC05zAyK4iDMylxLEMiw4O66dgYi3li31FZJq+OTXJoRVg45aq99CeiD9S7KyVvFTWYrC/KWTzzzI270DB8AqinEjlCtYnt8iuoORAjExVrNeQ+1EK6N//gTkekg+fL3Yi3o1L/DE898ofxn2Yt0lqVIHzf0AakdlDIISRGtDvYLBZMLyEnIZv3NLLyfPXuO37kemlufDl0sKYGHvfGVppZQ7X0I4MQRRZRUcRsdi8LuhMoe56mhTCe0wpDwi/uc9pnoqo2apXgoQcDKqjsk2IF5sqaw7SUr3AIfEGzbNfbzLhDvQbdBq9DZMfWD8kFjspacbfzwNtSnKhLmMQcCs+SKEREZp+G5Z2C6K7PiU+kN8Cp6j/7zqv1eTdL21/AJx8YHA5DrSr72aLrVi2HyOXJkNaeXxkHd0oy+ZdIjwvLd97+Igmy5s0WUcr7t1JEWHxOwFYORshLFBShlzkB61ugstnXf6adCLSz6jCT5TuxpIKEiQ9xkOEwpCSyOWzesODdVNnotK5pXQu7y3/wjmcnuY3nOo3OiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3crdEdjQUNHRVNXaXhZVXJHNlVaclVuVXplM0I1YTlyOGVNRW5VOWpUWFdr?=
 =?utf-8?B?MWd4RnJlSFBLdTJYNnJoWFBXUnI5d3dhbGltdW9GU1QvN0ZkcGxQNEVIVEVI?=
 =?utf-8?B?M01nMFp1ZXExVWwrTHIwSExoNXhNRGxsNnNUNVVmbTYvK1FGcFNlTHRJYisv?=
 =?utf-8?B?ampQQklkMHdVdWVmL3lSY0drYkUxcTIzUEhzVi9ISU1nWjVld1RVclhFblZk?=
 =?utf-8?B?cTNRTnQ0dnVuS0JzYTlsOEFRVVZwVWt1Z1FFbEc1NEhjZUVGMW5RbDl0bkFW?=
 =?utf-8?B?VkttWFpIeDVRK0dTMzJ0MEluUDAyaWxJRW13Yzd2c2ZJeVlTV0pndHhQUXVO?=
 =?utf-8?B?cVFJN3duTDNjSFZyeDQvYmpxcE5UM2didW5RMkQrMEhESmlCY2xFR2xVNlJp?=
 =?utf-8?B?RDlRNzkwOElYNHd5VVduTEFzQ1ZTMVVSbU1KY2ZkUWdrNWpha09jUjdLUGdm?=
 =?utf-8?B?cFlSRWM0djNYL04vM2RWYnNzOTM2M0UvYWk1SW9hdWdZTDN4bjdLdjg3QlJB?=
 =?utf-8?B?ZzlxZHc2RjBtakJVOFd0ckNGSmxIN2x6dzRhbTgvbWRDREZiVjBqbVB3MFh3?=
 =?utf-8?B?RzJBUk5zdG5hSEVEL0V1SVlWeEpGUnhONWM3MzVqWGp6UFdhV3M0NUFLZzJG?=
 =?utf-8?B?YlEyS1hWVTNaNnZpRll1bk9YdEsyTC9wSm5SZ3VBV3EvOUZWWTVYSWorY3FB?=
 =?utf-8?B?QlVHV2ZKY2pPR3BzSHZ3bUJ2bVpad2hNNk9IM1EwSjdzZDZhbzVvZkpHdm0r?=
 =?utf-8?B?OXV2S0VtQytOVHZHdkdyUWFHWnRzRFc2TDRQUUkydjhqbXBWVXB5a2h3bkpY?=
 =?utf-8?B?K0JseGJQU0k4UE1HMHR3RUVXV0o3KytSOC9EemI1c3hxSTBmOG56R05mM3dO?=
 =?utf-8?B?dHRSb28xc0hnUlF3dXFuWkR5Y24rdlhDenBEWXNPM0pyM1RTMms3OXdOSlp2?=
 =?utf-8?B?TWJRTmZlM1BOdnVueG1ZcTVpajJydUNleHlZNnBrNEFGSkljNmx2WkNEbHhz?=
 =?utf-8?B?MHBhNm4zc254YlpzZmxQdTU1T0pzS1dRaVhxZEFNR25KSy9ETXA2MjNzeFpz?=
 =?utf-8?B?dEZjZ3Y0TkRFYjc1VkFyam5YS05qcklEaE83aFRiMVh1QzJ5V1BnTHh6T1FG?=
 =?utf-8?B?eElMOVdaelBlcFhZV0w4QXRjZEg3MEx1cVh0OVlZVzVuOVQ2KzdqdlMrUFBp?=
 =?utf-8?B?Smdzeks4NmV1cWxDV0JxcU1hYW5EeU5Ma20rZHlLSHFWN05Malpka3YvdWha?=
 =?utf-8?B?YnVZNm1rdGNnZ0tGanBYaU5KK1l6WWQyNWNYNlNiZC9HRWZXanVUa2h5MzNS?=
 =?utf-8?B?WWxnZTVzeEJMUE5LWmlqK1Z1cjh6TndScSs0WHhWOVBQd25sSHdUNXpDY3Rx?=
 =?utf-8?B?SzlxK2k2emdiQTdtRytibVRSZ3JTcnMxaXhCM05PdlRyb3J1Y3Y1RnlSak9y?=
 =?utf-8?B?SDdlZXJhUDNOeEVXeDdreVg1a3NDa1JHNmJOdDhUejhiNjRJUEtFeWZHalc4?=
 =?utf-8?B?ZWhKeFoyR0tjemRxQ0xnK1d6YkMvTTJSazl1TWYxeTZnSG1ock5WRlBBUW5a?=
 =?utf-8?B?RFhVUVFWa0lnNk1PYmVQTGZQZTA1UE9HOEluYUdsSUh4ZVBLSWJkbXlOUUM4?=
 =?utf-8?B?a0Z0SVg0YTJINFg0eHNzendUS3pwSlBiWHhzQjVnWlM2NTVRb3hRR0h5WUc4?=
 =?utf-8?B?Y0RBTUt4L2ZOUG5uTnBRTkFYK2hTVXorSnNSMmlZMG9SWjdqMndjc1c4Wkd4?=
 =?utf-8?B?N1lvYUh0blJsclBNdTBDRm1pNGdsdmNiSm1HMFFmNEx6ME13bE11bmJlK3l4?=
 =?utf-8?B?TEY3c1UxSStyOUF3L2VOOHhzbmN1SzF6TmxYNS8vdE1HSjR6aW1LbmFKWUhp?=
 =?utf-8?B?WVBIc1ZDbC9xSERReXZrUXVyeUNaUUFsNEFqZ2UzdFRPd21uSWJlNnRXTGI3?=
 =?utf-8?B?UnNRWlBseFh4bnZkMWNnT2tPTlNyUy9qS3FIY2QwY1ZHT1IvWk5NTklpeklj?=
 =?utf-8?B?dEdiY2tRbXJRWW5vaHJ1aXRJZ1JsQ3NoQmFGZ1U0dnFQUkJSR0gyKzJqaGk4?=
 =?utf-8?B?WTZMWXZLZTFSa0dCcTl6b1ZydGlEOGhESzl6K0ErNkt1dWx0bVBwMjNHTGU3?=
 =?utf-8?B?K3JDOFpGdGZGUnB6RThXZnoyTi9ObnZWT2t0QXVCMlpKZkV1QXBOdnJvNzBW?=
 =?utf-8?B?VE5zZWF2d3U0STNmZjlDbks3d2swLytaY2lnYjhRRDRjby9QbEI1bG50ZFZa?=
 =?utf-8?B?cEJheWgzaE5xamhtQk5ndXV5MERNVE56ZG15RFJYamI2YlIvdXRQVnRqcWp3?=
 =?utf-8?B?U0hZb3oyaTRsSHZsamtHSUE1MUpoL2NCbm84UVdpWDFROUhkei9qTEJrRG93?=
 =?utf-8?Q?R9vmoUyUvsvGJtc4wenMaxPAsypSAYdCaL+EkDz6erdQH?=
X-MS-Exchange-AntiSpam-MessageData-1: cBdDWXp9JRdoiw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d43334-20e8-40d7-e4d2-08de84be0b76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:50.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds8rCOgmAyPUNLcoeZ+Hp/x+I90K8i/uncLsrh3XoyebxO496Dp7nDH/0By9QD67TQpSaShBeWtWeGHLRwKdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

