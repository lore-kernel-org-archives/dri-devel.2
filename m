Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3579CC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F4D10E563;
	Sun, 27 Sep 2026 11:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvKWEd0l";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900F010E0E1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrr/bE9p+5X8enjRypwlV0aTsHFODdFE837Kagac+YE2shmqldMvSqw+9GvEZ5y4iXrvHLtxmRirOs26ObSj+vkVshtoHUhSSH/JlblXoatuY83mxibIwG5OwDyPSUqPIYFvbZfEnBJaaXfH7bglppLR20HGMY5tVx61Meqop/cOXecT/naYHhgi8Y9K0sjBPqZ3hguD5t/L3+P+v/upytyuv0H9ApFypxAiO99azv+M/ayjJhC4LiE3kpMBDFtmDKfovjCvq1wP8DAziZckxEjs4yqYAgYJE7enLmiSgbTRyerSVWt0RA3EFV9NqJ8jJQY3i4SxQrdZ+n7DbJpjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZPTGqnsjeZ1ymZtpCMAZhgS9Nxdy3FQOZbVcUb95GQ=;
 b=i8qiMuJ8mgcCenmyGpeEPbQcWGzqxr3cqeljKkihtV6N5QG8TwjT3bdLmM4vixCzI/woxjA7FJFmk7FCCZuywV3ZNVUGFrnoDmfd+rWa8a0UVkZfzYN4rRcSdeFxB+HsOLCU03kBOKnGESjuTOrTcyDoTRbRnIKxJCv3KP1DCXLdX/ZvtRhdZcAh+7lJBG21/B70G4KE7fnwE+KA/dVqWF4SEy7n0m1d1GQIoiV/U+5E18cyL+YU++0elWoNgJS5zynYubo7WuNCnd/icUc2YhiJxlM/zFaRmdksP2+l+C9RbcUWe65CwC5vtC3fp2KBBMsepNQDpeZ19G4SqvFfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZPTGqnsjeZ1ymZtpCMAZhgS9Nxdy3FQOZbVcUb95GQ=;
 b=SvKWEd0ls5NR3yeguyOlr0+d3uQSRVLKraii4XtOzOw8/M5sMe+5Yx9HH9YUCinPI+9PT14ZuW6fQ+ww7JZyqCzk7u/O9NGuyG3jcuBLR1pbjI9BBlbeEBA+BD/zcYm5bJyOvOh9FXZpyGDel9hWXAEt+b2w0TfDTh441CZvFroTzliiTBBYOvbwdkBgCfPX5XjqOJhYfYq4Fw4RN9Mmz3MnoqP+VNbPCyJ+ojawaViEXbzZj0IPyA34w2dv+0Mhti+/rkH56pAyb9qZfFjGex+PyGFoACAODZmLs6dyCzWtYtv64Au9bc+XjCqQjzTDFBE6utLVrBpaSaw1gjFFDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:30 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:23 +0900
Subject: [PATCH 01/10] gpu: nova-core: gsp: cmdq: use element_count to
 advance queue pointer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-1-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0304.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 06abf73b-8272-4b5d-5e50-08df1c888048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: m+xZ34oNhVCu2/c8IhbNEZyHXQYMtOQaWIZIxBfQKGH9NtddQ+xOCIOcDv5IautzJA6AHiwHPd+3QKDn8f6pQqBW12jbwB+1N3jIKA3DapUMCInqAbMQVd8Qq3Ds/OWoYFnGkatF7alIRv1s6ZXoUtusq5qCKYQzziC1vYLPFDgO/qq6ePmocS31PwowCsrUYjtBtLJPi5347z+vQbb+9bzR0+A4xINRznY70nx4PT6LphaT5PSapbbx/JjRNb9cmEqq3c/nyaOYzR88GADfjg71MBLMYKB2y3OAtRgyFC1t73HZYQkLTQ6nb3Ori73CYvBFP7z32eS4eHPURJ0a28pn6SH6b/8F2zY3c1SBSb/tcwsT1CVoBPCxwMkMlhApuTkt8cR5q+JnEb66z/TFCi10hfrI87UUibXr1WIpwOjeddeC3Yrcw7JdpB8ogOI7q9zkgfnBj9qh3Z1Bsavp51s9RuUhk28MkhCyHuShhmpcY+GTFeFmW/oasrPtG5DVgQUjIptWwAGGroZvoQRVI9aYU6OoMUG/ddeE9lnWz4S1IWt530fP66MChrOvcquQlJaRI70YDThaQtfO27hbzhNb8A6i8ZhFrEjU5K653gPa28Q4KncPMFdxO8OqAhiB75r2Kp0FhTiqYiIPqInlhjpW1YTfwPMMst+C9A4Qt9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JwUVdmemxJc2REemRSL3M5VUhJWFdMNjBaeE9TZTloT3JSb0JRY2JDeGVP?=
 =?utf-8?B?ZjduVGIxcXB1OTdSeEs5MTZXQTlZNnpPWHliRlRiMnZQajJzOGNaQmVPeDFN?=
 =?utf-8?B?TjZBSjdLa25sWThjRlBLdDNQTmsxRnhNd3JZRXpBWHhzeE5mZ3gzSFVoZkdY?=
 =?utf-8?B?U0h3NUttam9uMWR4dXNkMUhNbk5ReHppK1pOdHVNRHZUbmZNUVNVcHllbXNW?=
 =?utf-8?B?RFBOTmY4YTlkUmpqZUh3UGhzU25sd0I4NWF5ZGJab2ZiOUUvKzJaR3hKV0ZE?=
 =?utf-8?B?b0hmWjc3TzhzT2lUY2RuL1JicEtWd09BdGk3V21oRk54d3dVajNJc0lIN0tE?=
 =?utf-8?B?N0JOb3RTWnRuRVE5T3pYVzRvdk9PdVc4NDdxaThWZE9HVlhZaERGYUhGZjhI?=
 =?utf-8?B?ZjhnaEpWdDhrRHg0Q3JiSzNaZkp0c2ZMV2QxaEhxcGdsYzRzbk9ZNnE3VmtI?=
 =?utf-8?B?TlhjT0FyYWlmY1l4RzFCeTMva0NzVzdncHRkWlQrbE5kUkF6SVJNY1RGZlN2?=
 =?utf-8?B?a3BNMTNYdVJNaFY5Z1ZPRTBDRjVyNUlMM3VLVThFd1haY1dqVms2RG9wTkdm?=
 =?utf-8?B?MEpNSVY3OEJyRDFYcHBUUWRLejRHL2V2ZWx4ZThtUU84TlFKclptK0JTZnl3?=
 =?utf-8?B?VEpKb0dDa3B5MmhSNjhMSzZsYUg4TkNaMUNvVmdIYnVybkxXRHQ4UE00T1dh?=
 =?utf-8?B?dDNoeENKYlFmTmlUS3BnSm1ZMDllSmNRc21ENTVIZ2h0dWZ1bHIwME5iLzEz?=
 =?utf-8?B?Z0NOYnJYT0pJYmExd2tlYkhSbjlSd1R0b0czMEtLNVdUZ3UxR29PeUxDdTg1?=
 =?utf-8?B?RlRXelUrRG5nM1Q2Yy9DdGpFbG10ejJCNkpCeWJMZXA4QmF1SFdmVTFEM1Uw?=
 =?utf-8?B?dXZUd3FGNG9xMU1IL290eHQrRDdwblgxdlEyRzVZanlqZzNOendxcHRwdThy?=
 =?utf-8?B?bEcrbEJLSHBWMmZzbWdGOFJHMW5vV2ZXOGJQVHIzbDNESlB5d05Bd0VKb2JG?=
 =?utf-8?B?N2JUeVpjdi9VczFlWWltd3dNbU5NOVJTdzJYTFFhVEpUWk91UGhaZnV2M2Jm?=
 =?utf-8?B?cE5mQm45UzE4KzMrQVhwN0FJZlFvWUdSUzJiL0l0NFZhT0M5ZGNzcG5odGNC?=
 =?utf-8?B?bW9hM2k2WUExTnNnN0dYMWpZdjB6Q0x3eU8yMXlROWRuQ2Fma3pTdW9xOVJh?=
 =?utf-8?B?dktSdW14bDhyNEFPdXZLRER4MHNLajRVb0RrNXNSMlpab045bzJXVTZuMlk4?=
 =?utf-8?B?M1JpR0xzL05Kam1oZDJWZVRneTY4bkF4U1d5Q2cvUzFMcVZUcHFXTHVGaTlN?=
 =?utf-8?B?d0laT1U0MmFIQmdKM0JNSGh2WVdWZkdnd3p2Q1RQNzdGTnhJWnZqcjZuaytz?=
 =?utf-8?B?MnVWTUNGamJSVVFkdlNLTzJRY1RUUDJSVnlCdUsrOTFyQ01vVHlOY1duZmZ4?=
 =?utf-8?B?QUFqOW43Q00xQW1WZ2pvTkZBWGhMY3o0SEh3OFFBQ3AzY0ZEdW5kK3l5Y2pS?=
 =?utf-8?B?MitNbTNoS2RjczAzcjdnb05RaHduU29mSEJHYkxXR2hmVWY2NnNwQ1dRdmJo?=
 =?utf-8?B?SGhSSlIrRGFtNys4YUE3K3MyTnNYUlNhRWNCR0JwbG9CL1k3NDZvSnQ0VGZE?=
 =?utf-8?B?L3NnRzVzN1lXeEx3emswM2cwMVRoQjZoRlovZ3I4TmQ5Mll5TitWejNpYmtw?=
 =?utf-8?B?VzRUaytib29rbFZMM0tUNWJGdWttVlk2azd0OVJMRk5UZ0J4T2EvRE5wWXlF?=
 =?utf-8?B?MnEvUlZOVTZKVlFCa3B4aXJKT2VqK1ZONlRxZFJYb3Z6dlZZOS9hd1cvaFlK?=
 =?utf-8?B?S3JYWXhDakE1TGtWWit1NVk0ZTRjMVVBbGp1MUhnRHQyWmpJUk0vTDQ3dWZm?=
 =?utf-8?B?SXB2TkxDSTBtWjRnNGRIN3hvc2JRQmVPanhKMzFzb1FDMXgyR2ZEWVRZd0dZ?=
 =?utf-8?B?OVBCdytZWjk2ZFY3NmpFVGhWdWc0K1JENE9TaC84MFZyMjNjSU95REhldGFq?=
 =?utf-8?B?MkhrTnB4N2dabjNLOStFSFAwQjdOb3hieWNJaHNwUWhFbng1RExpTkU1MHIw?=
 =?utf-8?B?QU9Hb1BNUER0QWhkRE5rYUZGem9vd3RWclQxVklvN3l5TzlnM0lCc25WbEZG?=
 =?utf-8?B?VklwOGZ1VnI4RFZxZjNzbjJONkRIa0dRM0VQN0MwWFVlRVRLUXUwcEEzRkp1?=
 =?utf-8?B?UWJRSCtOVEVwUyt4bkJLcGFWTzBEejRIb3FBakVrcWxxWjAzdXRNdkRBRTVC?=
 =?utf-8?B?aHJic3JkbURDcVhEVm5OV293YVJqTFFuRHNLVzJBamFpTllxMC9QcFVqYi82?=
 =?utf-8?B?aEZzeUJqUkcrU05hK0xNRlhYUVFVUXRqNG4yL1IxeVFqR1JNNmdZcnZHZWVa?=
 =?utf-8?Q?pLtPja7/glAeg/nkKOCt+4kxOQYQN5FmcAvERECL9/JKY?=
X-MS-Exchange-AntiSpam-MessageData-1: zR5RlANhDbj5dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06abf73b-8272-4b5d-5e50-08df1c888048
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:30.4650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6VTZj6Frzfcyr1gqJTPuOODIfddvWKrNJ3kqRytx9qUgC2F4RKmJP0XPL0eoH1MB5jC+85tLA/S5KNj+mSV8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

The transport layer of the command queue works in whole page units (aka.
slots) - the size in bytes of the message is only relevant to the
message layer.

After queueing a message, we computed the number of slots to advance the
queue's write pointer by from the message size in bytes, borrowing
information from a layer we are not supposed to access while also
re-computing a number we already have since the number of slots of the
message is in the transport-level header.

Therefore, use the correct information from our layer. This is necessary
in order to extract the message layer code into its own module.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index a5595da23407..9285fd796f9d 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -863,9 +863,8 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         };
 
         // Advance the read pointer past this message.
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
-        )?);
+        self.gsp_mem
+            .advance_cpu_read_ptr(message.header.element_count());
 
         result
     }

-- 
2.55.0

