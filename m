Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47612CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 11:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3CB10E57D;
	Wed, 27 May 2026 11:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyIOu6Iq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E47410E41A
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 11:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM5bxXca3l3JQ3rbctAZI88IW0pyBj48xFk2dnImKyhojO1CX30GRgNNTs2qHExZ3wyRxfF8U+wQS42evGR5jmHTjdLLcTOK2WBxAY1NlJ5cpstlntY4kn8eiYxUVz44Erk4PnwkV49oMXztV3faGO9Qi70LrfbDQ+0eJhpjZtjpHfhwCHDpxiPIt2y3APDVFMu5m5CNmzOvxNpEPNYs4d3u8O2z5012i2koJjULPuI4HlhpNRgtM2+RuHLJlUtLFiYYeqfY/alTlwGTiHsWo+AxBdEyOW5iZwAQF4zDNmjFZrITrk3gsCCNNJ/tGk7/XOMPH+Ynmnrx5eACDkcErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRHAu5mL4yzTajgjmGg0XduUuTrS4h+vYIstHqVyYIw=;
 b=O7+7rf66MV0Pfcr247ysNiOQFjuHeKpTqn6m71ANbBjIDh7paPNS1a0Cf7dlT/IF5KU1e9/lxENQSGq8jopTy+wKxQv/2ewY4530qFJWDp8DeM42JqyQkSrhyNlLNVtHyj1mcsTV4Z34ohJeCPLPt+aUENUhn8K9SzReAmLNXt0LRLi4erSstIxexi3GhdSdSi87sDaiZr7cqsEj1iHOgZ3Qg6kxsRu/U+AwJMVqYNax7Z/dkxdvvK6XxaPD6M0D8/xJNtS6z3CfxDeKTWWTDOVCVxqvKZzuSgyKAjV7t9wfXE55Drjkutq94YL219GBBMEB6xts8nD3cIxN7ek7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRHAu5mL4yzTajgjmGg0XduUuTrS4h+vYIstHqVyYIw=;
 b=WyIOu6IqlLCkU7qZgjOmZiD61ZCCAlsuR5UzoZdPvh88b1aLhlbbRyX8chLsUvUbLyibQCJLx3mLcue+UeQswFZtbbg3ggmQhOZK1HhloWV6c9bMB+pzBXapUAFXQIYIAezTdVz8u2GmV4SbHB9sEqG0hy6OwvY0tSepFH05DKNjd6TKGoAyW5vfEdofWJTYPc1hyjyWv1A0l8/L4mV5d8qf4vE037L0PKKKV2YaoWEZu4PWOo/Bf44PY16wLqfsztWL86F1nhmGAANGsU8AmoXvQ7eB9K2JMq3E0yX5UotsFfAqd9VNqDG9rQ1y5YCRJtO0j809KxovNxW3JW2Irg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 11:52:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 11:52:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 27 May 2026 20:52:17 +0900
Subject: [PATCH v2 1/7] scripts: modpost: detect and report truncated
 buf_printf() output
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-nova-exports-v2-1-06de4c556d55@nvidia.com>
References: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
In-Reply-To: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbd173e-f11b-4471-2b8e-08debbe67053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|22082099003|921020|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 3+M/vy11mD8WRKbuZAeC4LHnyuUZgQffGrSWEGMxDm09cUEuje96FhmCmS4+NfeT6QLHsbrFkxjKyWxIW3ygjSi208AgameDK7GbsjNAtLnH4Kx62TDLBpPY/gQKlQ5Jj4+tJk4bH/FbnJqqSjdaKp+ZLRWgwtYrBhwYzPJQDO9sW1J7ND4K4Z2K28pHof8N/J3LFhiIaeLp3+z/d+tvte5aECix6XCqSgCqLCcvCrXYHQI05iVs/o5Og1bKCggxSBjm5W8/lK03ATCYVDP8GkZooVnCoLN6Ks4cx7dZYfF/x7T/yB5lQFs3CvR0/qi5wFYd1E5FuG0ztK3hU8fDk7NhMT5A3X5Wme+fs1bPckNYgs9+qg29JFOSzrvkeVdsU8MsO4iNQ2jgOgOstq00AYwCn28TqRDr0cYcdcbONnB9QliF2UoPagP6AdAH2FWo0sEnCxib/QQWk+GIaN4iS0O0fYVkuDrEWfQJ1cRBVibMA2CVsxAVlyccDAZ7iff54EHbzFCRsk0ya7xIs0qpjt7KfjbRY8gNObqZ+9jUFMoJXs1nFHjnIfleZMdtokz+afH6uhRf4S82jeTpUhtx6HjYCvNcCAEyhjXFcWQqF8NLwyXORfojiB4jcAerPoFFoyD49ih9TzY+XIJqZNVtYY+zW7EHdl7adIBAa8IAzLxHL+tCnT6uWp+8XnorekDphrHCZF8qy+fCBXtg9TKuULXn8I8P6b4INFEFH8ncAyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(921020)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9kb1RadGxSb1VSRS9IRHowUCthZHROZTd6TTI0MkkvalU3VkU1S2JCdEhU?=
 =?utf-8?B?R3c3T3EyZTRtak1oZ3VOeklVQXkyQzZFU2hmQmc4ZFhIYUVsNklNL0xVcDg5?=
 =?utf-8?B?aUtRc0p5N3hJbnlaU1FQVU9MMjkvdENubHNjQjFFOVNiRFFPV21QSzFCeDc2?=
 =?utf-8?B?aUdPMC94MUZaNnM3d1JwUzBKelgvdk1Uc2dHK0ZvbGt4eTI5d1EvOUlaUW5x?=
 =?utf-8?B?L296WWdmelJ4RUxFMWtScGZjWTZheUNlR3RXbnN6NklkTXNIeVpQOVBVVmk2?=
 =?utf-8?B?TUxzUm9nWTNvRDRuM3RuZUxjRVJHbm1xakQ4aEIySVNjSHJaRklTeHl4bUJ4?=
 =?utf-8?B?SW80UFYrdUEzMlBMOGp2YW10WVExSnA1WFJZR1MzTHJGRnB1UkVJNExHQURU?=
 =?utf-8?B?QTErYkpQZzY4LzBLOCt3aUVwRFN1WGExYTJGaStYZmJoemdUUU5hdnprMTR6?=
 =?utf-8?B?VGZ3d2tBOS9wRG9qODVONDlMV1NhZTZ0R2hsNUpRbU5ZTm5UalBuQ3pqeklQ?=
 =?utf-8?B?b2djeTllYXQ0UEpUQXhhcjJMN2dvV1RlQytiUnpneDQ0ZTNhN2pJRkhJcFNJ?=
 =?utf-8?B?d3paQzFJL3VEVndPOXE0VlFjSW5uT1NEWTltMzQ2MW5YNVpEWnVmZVZSd0JJ?=
 =?utf-8?B?azRsOCs0UkhGM09Kbmt3VnZRekZ4Wm44ZnlvSFQwWDVTWXdpU2ZTMmZFWWVT?=
 =?utf-8?B?QmVteE9vb1I0ZHZxSUhuUTZ3dlYySEtja0pBSTRLb2M2WkdtK2tFTHZhTXZH?=
 =?utf-8?B?VVgwRFI2MXlTaEhiVkN4Z1JyZU0yakZxK2RuWlNLdHB2OHAyL2M0QWliSGlG?=
 =?utf-8?B?YVQrSWZHREI3TWZhR3JuakVVeDNHVElqNDUzVEFVZnZua3dzVk1ySnFJTm9L?=
 =?utf-8?B?dXhUcjBUM1VvSGwyUmZBcmNMcjhUanRQSFNybFhvR3NkdDVSUm5nT1hBR3Zs?=
 =?utf-8?B?STNqdFpNYUVrMTd1Tk1rQklGQ0RKNkc1NTdnSjJBS0xicTJlZUtzRTNQRmN2?=
 =?utf-8?B?WDFHcS9RL3JIUEdadEYvMkp4MTFOZ2x6TTAzNlJDQkw4djgyMmJHWWZ2VzBR?=
 =?utf-8?B?cXEydFNjK2pQRmJtMmFpRlBLZS9hbUlyNXVXeldTUVFKM0o0UVBubURoQkhG?=
 =?utf-8?B?N1RpbTExUmZzd2wrSGRYRFMvamREZkd0dGovLzJJeTBSUHo0SXhkQW96ZGQ2?=
 =?utf-8?B?QkJtMlpnczRuS1NHQVNDOHBWRGFDM1pYWTA1bllIaFhaQ0szclcrRnZmQUZp?=
 =?utf-8?B?NGM3cjZXbjVmclEzSzRoR2lBRVZFQzJMRlY2TGltZDZ1dy9tMjlVb1UxTE94?=
 =?utf-8?B?NnR3Y2YxeUYvNVNZWmIyL24yQUVkTnVjMXdMREM4dnduM0xNUWpxZ1FKRlkz?=
 =?utf-8?B?NW8zbUd4Q0dYVGZCM2l1MW5YeWtRWkZ2L1F5R2hQdm5wT28vUnhJdTFRM1hl?=
 =?utf-8?B?bHlvRWZFS29UMG01Wk5VWEtkSWg4L3luTjNEMTQzTEd0NEN3Ulo2eFYxZHBm?=
 =?utf-8?B?MUR1SG5vMzYvbGxYeFJZdE55d0xEZU9HOC9mM09nRFdnTVZNeWlQcmd0Z2Fi?=
 =?utf-8?B?dGRRMXFDTjFIRGFwM0M1NVZuTy8vdUxoOW4ySHBkREJRQ0lwZHduaGQ1NEV5?=
 =?utf-8?B?Mkc3R0NlSUhaYUdZMndSTTI5OEVGc3VleFNseVNSTnkwREVqa3MzSWZoZElP?=
 =?utf-8?B?NkdGQmtiQ0VET2h4Z3U2d2lnc0g2YjJjN1JUUkZXc3dHTEhhVHpmZWRLdFF3?=
 =?utf-8?B?K2hjWjBEcERFcGsvQzZNUEFRUVRDbENRM0pSRE9hVmV4eUJPblJlSzNtekF1?=
 =?utf-8?B?UHpCcTdRL3N2MGgvWGUwc2tSeE5HQzNSVUdRUHBJWlQrYVV4WEExaWZhSFBL?=
 =?utf-8?B?ckxHZDdQVWZTVEpkYjQ0end5SUExdDNxclc2SDBidXEvY2VmUG1mSDZZRXVr?=
 =?utf-8?B?Sml3Q1JjeVV6U2ErKzlyTzZXSVRmekdFd0hHMnlKVG5iR0d0bnRJUVR4VXBR?=
 =?utf-8?B?Z25oQUY2czFPZ3lzOC9vd2pXNElZNElnR1VLZnZvTzErUEcxaG9kL05la3kr?=
 =?utf-8?B?bjZxR25DR1kvcEZWcURyV041UWlGMEtDT1F1a2V2ckt6dWRPbUQ2bHJWMTlm?=
 =?utf-8?B?OFQwY1p6UlNjemVESjZJTTFtbkV2aEE2bmNJb2N2ell1WEJtRysva3dOemxt?=
 =?utf-8?B?dHhNL0hieG9YbzlkQjBCZldiVHBDd0xzTUxHeTJKMHFWRmpUbGx0bXZ5VHdk?=
 =?utf-8?B?T3FoN3Z2bWJBSEtMeTZNYUYzRnk5d0kzbkdMeG1Hbk94enBLS1N2eU03VjZo?=
 =?utf-8?B?OE5LN2ZEcUpEdnZlenBDUHRReGNYMmhsZmw1QW1xdVNiNWI2TnQ0ZHBoVmU0?=
 =?utf-8?Q?CqJU8R4A9XyAwzKBXZaITsfZiGuXg0HafmrZApRwh6Z3t?=
X-MS-Exchange-AntiSpam-MessageData-1: wGqsqmH7K3ULMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbd173e-f11b-4471-2b8e-08debbe67053
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:52:33.6101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqjdzdB08zN0Hh268EZePlwfxUr/8mrIk67e9zFWH1/UecAxM1MQIzpHMTzVvp3y/fRHdC4nsvvjbVk402eQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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

buf_printf() uses a fixed-size stack buffer. vsnprintf() returns the
number of bytes that *would* have been written to that buffer, which can
be larger than the size of said buffer if the formatted string is too
long.

The problem is that whenever this happens buf_printf() currently passes
this length, unchecked, to buf_write(), which silently reads past the
stack buffer and copies invalid data into the output buffer.

Fix this by detecting vsnprintf() failures and truncations before
appending to the output buffer, and report a fatal error instead of
producing corrupt symbol names.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 scripts/mod/modpost.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index abbcd3fc1394..0d2f1f09019b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1689,8 +1689,17 @@ void __attribute__((format(printf, 2, 3))) buf_printf(struct buffer *buf,
 
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
-	buf_write(buf, tmp, len);
 	va_end(ap);
+
+	if (len < 0) {
+		perror("vsnprintf failed");
+		exit(1);
+	}
+	if (len >= SZ)
+		fatal("buf_printf output truncated for string %s: %d bytes needed, %d available\n",
+		      tmp, len + 1, SZ);
+
+	buf_write(buf, tmp, len);
 }
 
 void buf_write(struct buffer *buf, const char *s, int len)

-- 
2.54.0

