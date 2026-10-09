Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A8BCA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC5510E11C;
	Fri,  9 Oct 2026 11:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DNNSqC0A";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A475C10E11C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1jlLKBaEsgtCb3oXmClv+ue8hY+xREYBmMkbcW983sMtl2CeCgVUliHof7hO1Ouipp7U2INLlIw9MtAQekWDa/JaeJSs57zabictWG2ZXRP/sdhKqiecAU2LjcqngYiJOvEvCFrg17Sef87EzyE4HyrjMty5F958JsX43mnrZyZVpDtgBeMS2ugOErK6oJhkpjU8Mk2JFA3/N2UQTYYYku/nIwcXm7ARFev4HieA6zqY5HEhU2guQCdZCBUdW4cZ7toYkUO+r1FnRDhQDuSJtx2P3+aBzRX6XBnGtFBIWJNlgv6JZYNjxmPYK66hWdyl04ySA81Tc3C9VsMpoFtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv6+q8yTaAQ9lk4L/D/Jvdzu/cK79HvcYv6WGR16pOI=;
 b=R8QXV+/n6OD7XuEB/iOWQ42ryIIWDeBiawHzF2ghjW1h8csWyXin20E4759emoLV9h+177GJPATjMsjhDPg/tQ1jJb1G3jKe307UM0S1H7P851OR4nD3AWLjZAvIYl/X+detbyKiyc5z+9V4c5ngc8zX/7686ZY5M2CFH0TfKE6WBr4MU4OLP8GV3NRlc+wy44RUcQdtBexSiPi7S7jr975LXUB9SPoBwGAT96RwN2jGQCtWTTj9rdGLd2VRVCwx46ujHU5Ihc6i/lT3HmM6XxQmQtwhC2lrTd3bxJD8qFzgfsFj3fNwiX+6141122SGWNV/vaYAuOysC4FbkAwZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv6+q8yTaAQ9lk4L/D/Jvdzu/cK79HvcYv6WGR16pOI=;
 b=DNNSqC0AGtKij/OqHiEREUh403ldhRMlrjOGZB3P9Gc6mdXTUVxcXLb7KuIzIDW91uqIkRzOn+Z4OrtF0uaFSXPz6C0UoPOK+5ZKCrB14Csh4rEcf3ZvFGgfUzDIRdZN5bI7dfPg/7fKKpFu0cJ/zNpR0Gmd2ucDNG+mzxs6m3saqHculNcRc4v7JHlhyOYRx19CvIbdMqZBOXqZ9S4m/vA1cMur5XGADUip9UrVBUMheqgFNJMP2Q4gQK0hxQzHRr8e4M65tKiubMm8bjxxGg6SppzkUhtf7PgqsNEyFgVbCUOtLR5K2lb7xJMskD7B3Rmueqi5hDqInuPQ/EZ5vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:53:57 +0900
Subject: [PATCH v4 01/10] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-1-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d5d9e0-2ee1-475e-ed80-08df25fc0b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|11062099010|22082099003|7136999003;
X-Microsoft-Antispam-Message-Info: N/wv7xRPf1pvlyhugmVPaix32+5xnsvQxx5TgxJPRZc5REzqJM8spH3xAWz99fl9SUYjjDns2KFghNONgWWPI0IHILW3LgXnjCn8Nnx7g0xVVAo1VgkVLmbCo+eO76AKaxcIbt/Kfu/Bc46Xwa4B0sBwpuUpyFroSINCg+VL9ADlHrPtIhXdta3CO67AEG0UpyclSMopV0ksWvrRd4NneQnt+dD2fFQ5z89nnIHfLFKFVIGmvtR4G1EKLz9OBGuqgWB5tCqQkT16rzIYQSGrInPYfe+aDieC1KRLCcrw21MQt7WXCxyF2Ul5plH+4+uXf2bpLfJgPrppyxpTi6BSgi6jPtqgxWVYY4kTkh339OPb5zJ4Oz4MrLck3t/05uiNv5lHAskf7JnXZ325G/Zi4F+tgnG/BapfebeaHiJ3cLzstWGzX1+riAL6yCGpxHku9ZwAOtY4eEiQ6gLpR/cIKI0F3tJy2GpDEMN/a3pYiT3zaDvGyQU8EmP1XqojnNYua/m6NtjsvzfnSSKqZwsfNrrGbJYIEG4V2vDn/hpK00cEbvFrARPlwJY8EB0Vgb2dr9Vmokz6xZrqK4SfrK1U5mHWkz39Lrddvr3lTuZ5NhgOkxLHZ5YJ8BePfL9C8PrXrYupPF37aXwdeteS+H4gGDPkoVqiC07GfeblB0p0umg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(11062099010)(22082099003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBnMDZWbmE4RDJnaW9HN2xxZkdKZ3B4c0ZtY2wrYWpVZjhESWZTbFFRajIr?=
 =?utf-8?B?V1pRUGppYWVKb1hkT2hRYzdzVVhEaUk3VG9WNkdoN3dtTTRBaXc4WkF4U2px?=
 =?utf-8?B?QTI3RGtyTVpqRkdMdWprL2hZUEVGRmtNQUtpTE9raEh2YUVmcWJHZlZodnM3?=
 =?utf-8?B?QmdEYXFZRFViakhHazEwKzFmd3JFRkErMHl4WUhCTjRRRXJtWFVEUU5DaXFH?=
 =?utf-8?B?ZXRSaytkWjBQRzgyTXlDTHk5MXYyTGdyTHlJK0VzdWJCMWlsYUlydDFpRGs0?=
 =?utf-8?B?T1Ftb3djNFBtMVMwbFM5SSs1ZXNCSUNSNmdGNGx3RjN0UitmSndRMDlOaUo2?=
 =?utf-8?B?RjFJRzB5TEYzTG9WVXNqWGZ2Z201TndQSFZHcFNlRTNlblZuSjFHeFRLK2hZ?=
 =?utf-8?B?K085WDhEbzV3Q0x2dWxzQlByS08xY2Nzd3FhYXNlSmR5MER6QkhWLzdic0pk?=
 =?utf-8?B?cy8rSXpFdlZDa2dleHJYUkRKS0MrdVJXV2FNbG1zRm5uMk9seWRHdE1GdEZD?=
 =?utf-8?B?ak5ONW44VmlhR0ZJS2loQlJ0SmFIVjcwNCtZdytLTU11elBPampDUDV3VmE1?=
 =?utf-8?B?MG9QZGxXYkJhb3F0Sm5tbUpTdVFhbTVLRUZ6cjVlZnRJeVVleTZ5SFdqUGc1?=
 =?utf-8?B?RmhRNlcySFdsc1ZWYWtjM2ovZWtVVmxhcEUrL3FJZUMrM3IycUVJQ2RyWHVh?=
 =?utf-8?B?ZzFhUG02emRVKzZUS085OEh1NGRYVkhrWVA0TC9BekFYb2xlNW8vWjlPQmh5?=
 =?utf-8?B?Qm0zalN1MzJsaEt3TWNMRUNVUDk1NHZGSkFuVjhFaSt5MTVqai9tUXQzLzh3?=
 =?utf-8?B?eStVZlYzb0tLZlk0TFAzeHhqNW55U1hhVEJEdU54dU4vVGRrR1gyYWZ0WUhJ?=
 =?utf-8?B?cVUyUXpSS1ZWQm5FRUxDRGp6K1F3dGVucXNaMnJtQmpQb28vdXVzMVplODNT?=
 =?utf-8?B?S1VHQWVIVjJwZEJSUCtvTURIbkszUHR4dFpWMlVISjE2RHRjQVFmZzgyVk1H?=
 =?utf-8?B?Z2FRTzQ2Rzh0RUtnV21JVU5MdjFUejhVM2Zld3dYR2VMY1FqLzFoZGcvOS9a?=
 =?utf-8?B?b0ZSbWo4d3BBa2Zpa0JxUTI5aE9KSlZyVTRwRk0zcVBBZzVya296UldGU2Jy?=
 =?utf-8?B?TjBkem9teGZHaWtQTzQxRDdwUG5OVDBweDhaQnRvT3JFQnVaTGVZcjlnQXov?=
 =?utf-8?B?Wm9YM1FlM1hRRVYzbmlQMS9EL2VIWkFzTEg0S1ZyY1E5NlY4OGtpaXNkUXMw?=
 =?utf-8?B?YndnVTMrWGIxbS9hc0NVRVdndmp5dEdrcWl0ck85QTI2aXBBMktYRmNnYkJB?=
 =?utf-8?B?eTloOVB4cGcrYm1ZZXhRZFFiVVQva0xxLzUvY0pCVWJoVWhEQnVibjZVc3Nw?=
 =?utf-8?B?SlR1ZXQ5aktDQmd2NE9nakdDeWhvQjdxakVTSnhDVFJESm8va1lrcXcxWCtR?=
 =?utf-8?B?MzY3OW1YdERzQUVvVjZXQlJ1N2ZCb1hXc3hHVEJNdU01RE1SeURFeUVScHZO?=
 =?utf-8?B?amhZcmxDSEdGa0hOU2I1ckdxVCtTc2I0YVhLa0M5Tk1ONVpjRFlBOTExa21L?=
 =?utf-8?B?YnEyajFKeHowR0Jrcjl1cWhBRW5IUU5wSDRxZFdsdTVrbzErT1JMb2Y2aDBz?=
 =?utf-8?B?NkJ3UENYbERDTWVuYVVvOVhOYkY4S2M5V3pLNW1id1F0dWZpWno4UHY0ZDIw?=
 =?utf-8?B?c0t4U2Q3QU1ZdVZsT1lHTXFubHJRUUs5dVJsamxWbFMxYldDN2FaSXB3N2E4?=
 =?utf-8?B?YmZzWHBmT290Q0paQ0UxZnB1Kyt2bHNaZFBBY1c3dS9tSWtnZlFLd3dPdEF5?=
 =?utf-8?B?QWdid3pZaUJucFFZVW5OZnhnbzg0WjQ4RllXOHN5NXQ4c0xGUnlQa3c2dVY3?=
 =?utf-8?B?dU5jcTdHRlE0QWoyZTgzWEtoMFFKWkVRM0IveEJiMnNsNW53VFNIODFQMDZM?=
 =?utf-8?B?NVIxN05iWHNCZHNjN3JBUE5jOGUvWFI3Yml1ZEg0dkdHQTJ6N3c2K21OUytu?=
 =?utf-8?B?NE5QNENGOWVIVUkyeGx2RjVEbEtEaldCTFVsWUxJN1JxK3Y1UjZhU3UzcHNL?=
 =?utf-8?B?SXNNa29HQjRXVUtxbWNDQUNwb2VvY0ZvRm5iV2lOUmVuYlZpUkdLb0g0cks4?=
 =?utf-8?B?U09vSUxUZ3duenhYVnp1YjZ6cEF5a3hYc0l3UWthNGY4RG1jR0V0MFQ4a0dP?=
 =?utf-8?B?NzMyMTM0Uml5Y004aTFGTklMR2JqRlRPcXFUV2VhUU1VMHUvMVJBdERTdkh4?=
 =?utf-8?B?ZFFRT0ozZU5mWEFXdWhrZ0FDSUEzUFdYSE1INWluTEZsZ1NRWXVkZW0zTFZi?=
 =?utf-8?B?aHhEN1VKVFVHR1d3cGJvekM3UWM5YzFLUDVxMlNtU1RpM2V1Z0xwVGRmY2Nk?=
 =?utf-8?Q?16qCoGcqbcScltXF1WvdR4d7VxsZLmiqIWKhcAe1kWpBJ?=
X-MS-Exchange-AntiSpam-MessageData-1: sC43FxS9F9lcjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d5d9e0-2ee1-475e-ed80-08df25fc0b2c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:16.0484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koMt/DYSBFSxngbJvhpPfAX7XLzTGI9N2AUQnNMCWKAn9apLMVU2/uYGs4e3YnbZIBUBMY0fpNxpV6MWJsQC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522
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

The checksum validation error message of `wait_for_msg` prints the
message's sequence number before validating the checksum.

But the checksum is part of the transport layer, and it not validating
indicates a corruption that could very well be in the RPC message
header, meaning the value of this field cannot be trusted.

Furthermore, the transport layer is not supposed to know the kind of
message it transports, and it accessing the RPC header is a layering
violation.

Thus, move the checksum validation before we start looking at the
message header, and drop that information from the error message.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1b2f346a237f..b1d46d6d4d4a 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -792,6 +792,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
+        // Validate checksum after truncating the message to its exact length.
+        if Cmdq::calculate_checksum(
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+        ) != 0
+        {
+            dev_err!(&self.dev, "GSP receive: bad checksum\n");
+            return Err(EIO);
+        }
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
@@ -820,21 +829,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             )
         };
 
-        // Validate checksum.
-        if Cmdq::calculate_checksum(SBufferIter::new_reader([
-            header.as_bytes(),
-            slice_1,
-            slice_2,
-        ])) != 0
-        {
-            dev_err!(
-                &self.dev,
-                "GSP RPC: receive: Call {} - bad checksum\n",
-                header.sequence()
-            );
-            return Err(EIO);
-        }
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),

-- 
2.56.0

