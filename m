Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6131ACA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAE410F448;
	Wed, 30 Sep 2026 14:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="a8p3Y/iy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B2910F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6AM6AdedJk3nH71pLfn3Wim0u4keqhNNWSEur77zV0hGYzRRxAMp+XRaCXxtvaUjZGKBF5vhYhMZHuBJqAzYCjDbtj5VM+xhHJNx+J0bzbdmkBSiWKTvf5luW7whdzyh4pGbWdDKIVxBowA4QpNWP3QqNcSaTirKYNexhv6zHpGyJ+WxamEyM5XcpAEEskTInftyiKpkuP/ZdeZgK5kQwZFlLb7AMGpH5zUnMLw9ZGdlDN+/SiH0xsVZL9rfZfVb61PsbcuG7a5ija9bD/S7oHSP4ie4yLWCgfzB9dct+70o8sjNXiV/th4iOqAW/OKeeofSTcdau7i9shaTbGe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB6KmAw75hP46LT+dKlbUuEDPZNhkMQ6LJZCO5mZtHI=;
 b=FaJ92KF4uOedrVTKabzJ7AJ2zdPpN1pA9kN4Bocujt3QYnFE3Dsp8v2il3Om/ju6SrTiuQ13IlgF2Q+XDlXVOorhvT13jjuMbk8mHxEW6G3QkncU/hfs5J8fEl+NsT3eWPwh3wQwgpINjjbFaA7dgMTCFJjeknybEtXzwQPMG+sBzX0PLNfn+JWrzpIIu6KXvcAzs9BPCfjqG1RPwXlv9RhSizTfv9LQosEH+eaf3h/3JWJgsfAXMCPYHVLKLTRHX2dZ2K3JaCTUvKb55Q4rpdqq3EXuYabUMlbvYuU5O8jnBuM3BNffY0M/4dPhSv3yi6ygbdpKyD8WIDddssfUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB6KmAw75hP46LT+dKlbUuEDPZNhkMQ6LJZCO5mZtHI=;
 b=a8p3Y/iy2SP2odvBUcWleo/Dk/jqZ9JpypRaSpZFoxqpNP8vGM2wKz+EhkDybQBLGJS3wGf3RSWujOJJi3uKKoy6sEsEHiSkKkqciREPbRzeORJN2yOiHbsKWjFgCX3aHh7Hhi0RnxE1rQzJOg88qheRQFutRho5lqmfV1YtC3klhHCGDxOFdmuBmm1P2wSGAvhu4GWCflHXvZnPxSHnZWFZMxl4gWirNc5xhZS6cdOQrcHzmsDS9qST1T1al8P6paO+7yTJC0/s8+UBg2CzF5D8EAScJbK+h++1v4gI0P9Bqrph9iat65wwoMosq95uyeJsbpLW95OzwKNlPZCIgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:56:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:56:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:40 +0900
Subject: [PATCH v3 1/9] gpu: nova-core: gsp: cmdq: validate checksum
 earlier on receive
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-1-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 918c5af5-5088-4d56-a486-08df1f03136f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|56012099006|7136999003|11062099010|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V6zMpXkEAVJPuS/1AiHhg+j3dXbnXhD+Atro7q3XHbjwE20zU7mjJthsDDox1cF9BrTixXmDqVVyNN01WM1l81yPMsQr7c7mZCXeH/tnxgJVK8Diq2N5AZz2A4AX/SeRgoK/zff5Z5qjEw71pn/5v3302wxW3aa8i2IwQXI8zu/VV7WHbpjK7aHZJH4rb4wG5zpWfzGiaQN2E1vDXSe9wQHfwajl1G3TNDDBKeCjXXCZaIUfTPfN5hNtIbMYqSi7BS8ro+Wmi6X7c5yIKKuZe90jv2b/JK6KaTDXRiapyBXKgCvBLnyhN7UJYAAkp0xjZvA/nPXmZ88xW/dDoXajJT1T9KLj6kqmPNJ0Pinv9k9kJrAtGNWUOPLBcnQDLF0yRF9VvASNkELRDWSel0oDOITwu0xX9eZs31upwcH7z3HmBTVA0DgkcB73GHjhuhDO9Vf4iBgQ8dtp1lfkirODHGDvH/ZjScxl50pppMnDc3uGsc5WKdDS2JvppVq/ZzWvsisiUO/yNnGRFh4z7b/5wprAuuD1sMAuNndASmty1r67H516acxpIV/BfdkL8T1j9QUCdd+wjokK9sJBGVAeMWogGQwREGaboI15elAW+BS5E5BDfaGQ+tHWzH02SlVWh7dMa4zYZJpD4VXDIQ4ptNk4psaSUGDCiMzxMh+h2DA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(7136999003)(11062099010)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZ3aW10bklob0I3YlJNRGh1Q2RQZktwUDcvNnYzR0VhRlVMVkZhY3IzV2Fn?=
 =?utf-8?B?TTlyMkZzeHZXT055ZUxEVGdoUFZtSTBIYUZYek9xeWZLWUVNSjlaVnBualJt?=
 =?utf-8?B?YTNkc2t2RG5GL0J1cWxMS2hrZjV2MGlLSTVJY0ZoUHM1c0FoNjAvcFNRa1BZ?=
 =?utf-8?B?VENFNkxaWGYxUktYTXhBU0ZGVU5CcWI5Z2ErUmpGbHZFTW9ROVFLVWlJWkFi?=
 =?utf-8?B?c3FZT0VuQWM3amVpRzNYSWY5dDl3M2Vqb1RVc2tCTk1MbE85anNOM1JUdFhS?=
 =?utf-8?B?M2xXRkRsdDhGeW1IQksweHBvekRZbkx3Z1JURDJpblQwNnJuSlFhNzBtTjZT?=
 =?utf-8?B?VllwRUtjSDB0WHF3UStLL1dXS0NmdEYzNVJyRGlqUytEcDZKMHRIVy9kd1ls?=
 =?utf-8?B?ZzB4RzZNOXhzQzMwaU9GNXFFZTNnTFhjcFhjbW5nMFRYQWx0VnlRS1huVzh4?=
 =?utf-8?B?S3ZNT3hRSWFZWkZ1dE9KZk9uaDlhUFM4eHo0cGlwbG03ZU50T2RyVy85TEVR?=
 =?utf-8?B?dVlVRFF0NmJ0ZWZFZmdyVDZHNzQwRjJwRzNEOHVQeVFTY0RPeWZUK2FabW9z?=
 =?utf-8?B?alk2WU5XTmhidWJSTnZNOS9VS013WlUyc2lsbjhRay9oNlJUMTNJb245dGlG?=
 =?utf-8?B?aEJlaFlSSVh2TWt6NlFMczd4VFpEQXd4TU9QbWxvQldCMVpNQ29DOWNhS1gx?=
 =?utf-8?B?cVFpMDZUQjNmWGxINm1GSVdmYjhPNXU2MlFDdVFCVEUwQW5zWjh6VHQ3RDQ3?=
 =?utf-8?B?d01VSzlmOXlnK1BkTnprWUNEWmIzQlYxMjhGL1VKSEdCMVkyM1dDMVpGVHUx?=
 =?utf-8?B?aEVtY2N3c25lekJCckJ2NUg5dlBpekhLazZCL0xIWFJ0WW1ockNPdWs5Nlk3?=
 =?utf-8?B?ckpqdXZ0Tmt6TVJqc1lEN0xraHRleFhLaWloNzltTSt6RjVKK1NWRFhVaFBl?=
 =?utf-8?B?WWJnNXRiRElOWndRdnNkNzRkMDlSMlppNG5wcUtmZkRpZnBKQXpjZE5TM2hK?=
 =?utf-8?B?VUk0S2xHUm41ellwa1VMMmNGc1dmQzlrcUZSL3JZbU9PcktzN3hibk9oRDNt?=
 =?utf-8?B?RFpKQ0ozSjhwUmRLZElrVmpHVkFGZU9leEJYL202dkFQQnZZbDVQbzh6TFdY?=
 =?utf-8?B?aERqRmxOVmF3cGVHd3A2K0Q5ZllUQ24yVmc0T2JHYXFwL2U4VmNETXBUVmVM?=
 =?utf-8?B?ckh2N2tkRHJHcmFWZ3ZaN1AxSTd5bG9IS241TmNhK2w5dzlucExaajA0N1NK?=
 =?utf-8?B?U3RZZGNFT2k2dHFmUFRRZi91OXRUQW1GbkRIVnExZi80OFZyYzcrRjdTUjNC?=
 =?utf-8?B?cXBTSHlTY0I2d0FFOEYxeGpUeWUra3ZlL0dVL2FkNG9QYVpsS2JGNVU5TVhZ?=
 =?utf-8?B?K1c0VzNoV3liWkwxMGlZMGZyUURKSGkvK1AzRnowWHZjZEJaRUpyRlVkRzR3?=
 =?utf-8?B?Y0lzMEVxWS9kZWZmL0RpWDE0NzE1enFZSXptcGtuNmFGQ21na0swSGE2d29W?=
 =?utf-8?B?RGN0elBRNDZ0bk80RWF4N3dablVyQk9qanhMZ3RIZmdrTmdkSVBnWGNqdkV3?=
 =?utf-8?B?cTBxS3E2akZqNVF1N0tiNmViWjRNdk9VdHZXWGVsR2lMaGRaTFpNaDlOMlNM?=
 =?utf-8?B?cmwyZkNDaVBxYkZNMkZVNDBKcGRQYXJXM0ZXZ2hjcWpOcVJ4VUdDMjQxT2ZG?=
 =?utf-8?B?SXJuR0k5NDdXUFFNTnVLL3NZZ0pZQTdRRXRySU1CYjA5MFpSTHpVUnNwSzRD?=
 =?utf-8?B?VzZOaWxCNFN0NlFJeG1wWWVjOE43U1ZHVXozdzF4YXpxYXBXTXg1RktlUVZK?=
 =?utf-8?B?a1NaREJMblE3SEZNcGxGd1ROb0QvTTRtRWJPanl4OGI4ZldhczN3TGpBRUVL?=
 =?utf-8?B?ZzRodE12V3FmOEE4TTE3N21VRFRjZDdLRUtqNXgyN1MyRlYzMjNWbUVWeG1p?=
 =?utf-8?B?TWJCa2l6Nmo3OWh3dUo3RGFNT01NeEdsK21waUlnL0JvMjR5VnhPM2ZMbG5W?=
 =?utf-8?B?c0VGL2lKa2Z3RlQxajBiNGk5c2VvUzhHdjJKaGZNYUZtcHpTQWNmdTgzc1JN?=
 =?utf-8?B?TGZoSEpQNDkwMzg3MHhYUU5uZVpUa1VQNG1KL2N5WlUxRnJqWE5WeGN3NVZp?=
 =?utf-8?B?UDZmWTB1NzRNMUl2MnM3cldHTHZGRitHR2RNdkFmY295UGd6Q3BFY1NaY0d0?=
 =?utf-8?B?Q3FnRWlSbldYM21GVW5VWHVUSXprNFRhUS9VTjRvMVdrMEVpQjZLaDJjRk9k?=
 =?utf-8?B?ck1mR2dQQ1BPeTdLVFVDNkxtK0V5eFhjRGw2UTdKeGhaQVpNQklLYVZvQ3RY?=
 =?utf-8?B?Tm5MdEl5dm9FbkQ5ejhQRE9NZjNyWDRITjNhYU5LYzNwenRRWXFocEdpeWVY?=
 =?utf-8?Q?A59zXMo3TE+kOzfwSCidYISuQnwcwOMOmx+NmpLUKnYBY?=
X-MS-Exchange-AntiSpam-MessageData-1: gDygL4qJtALV1g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918c5af5-5088-4d56-a486-08df1f03136f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:56:58.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uwaLfwu+w59vNDEwRjBlxrHTwYATGO078BxGidGW7DXt23Sb0u0oAUi9NTGrBAz5NkpjSZ9WDJF664ArsH60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
index a5595da23407..d293d28b0967 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -768,6 +768,15 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
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
@@ -796,21 +805,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
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
2.55.0

