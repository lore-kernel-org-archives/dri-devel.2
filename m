Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AE7CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816E8113A5C;
	Tue,  2 Jun 2026 14:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="NKU5C3aO";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C297113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp7LvyEuiuz0Jb7JWwCKJ+D1tJWapEudepeuUkWjXsH8ceapjfNA0tLYBVZs4bvjUjZylbndJXkZdGvxaRdZ1gK1Cl/TFhWXiDjNmtrtagrziiepQPn614jM+QhNVOSOASOLpmjlxvrLoBm4JsP5tpVAo7eMS5pRfFMx6ult8A02XZfXrKPQU/c5Hq/p/s5AIj5v0kmY9dKVe8mWq3ID4n//BcXfhZgjzvV0wo72vQdTY/8rxHAog4cUm4SeKtFk+8oLvOO+9xcr8YNXt+mQlabBnMaaPLkHB8Ahk3ZJNzvesQuIvd9yf19Tp2jBg2F2hTpYkTxod3Ssmah2t16scQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCgVTp6ziaB07DuFA6ZyqGvR5MD2tBPLZOrUaIyMTFs=;
 b=EUwg1BY1Z6RygN5vFABtIvnZdTKzrCJo4LoBkyqTtYX6xRaVn+loVTpyer+YOj4nLRHMY0m7ZvBfZunHh6aPQGh3hYGXaAlNgA/vPaejgUqzxAzCo4+1huzzYtLEKwg8OXjeNaJhQr/gKPiExcNofEpr6et6oIJ4nPspRIwK6MrepADGL0w3SnSgJXSHRqn24+1zFn9Z4AqwL/PWlJ3jINL9Su8ogGAWE8vo49FnsApWpurcLB+XdHtPtqtAZXaJIndnIFcqyNRllItsJ9vyKaMVs4DocvjMf4mX5lMvJvppQv9N8CJOMB9iNp4ZRNQ+GoGV2FMmQnpouQ3Te1W0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCgVTp6ziaB07DuFA6ZyqGvR5MD2tBPLZOrUaIyMTFs=;
 b=NKU5C3aOHmm8heOFXppRRHNU5ers00u7Vsa6Z8lDq8bQDDbYeQKcwu8hRhWXYG82LoaZRa0Yhnfkh14oP3fXzmrMuKu1xrgZEPns75rbptOEWOjg+RsUOA3YyV8/aGjm2Ah3w2jsaKC24zxK0tEXRabx+kZlzgL72LTFL6wvpEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:03 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:03 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 02 Jun 2026 15:17:57 +0100
Subject: [PATCH v2 6/6] rust: ptr: remove implicit index projection syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-6-6989470f5440@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=2040;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=CV6fecl3K//iogdhcwiyQ4Gnw7+4d47B/J7XKNvOqN4=;
 b=uoQmTZpLvUGUcNHpmqat0UOAjCY66+VsIO71REUi+OjZd5BT7tC0MtTcXKC6gHIV5IIw1V9NQ
 WOFXeaoPV59ApMq37L7hWoqLyz47qk/W3aJJ4OpsMWkmm8C2BFHkSNJ
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: fc85f598-9d2c-4ba8-2de7-08dec0b1c27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: IHKyooawQtGgO4t/xEafp9JR/mPtVJ7gqHlz5OVPb+qtnSFHFrPwQGEQpsv51i+e62CiPzYi7hsJk44JthAF/PqDh3zFj5++VwSx1GCxU6ASt2JQ/1lgDT0u+fp39yYLiumpWP7F+PP9atkrjZkjcOiMbPtT+3ppufrzq7W5+Y5rY//zwBxWZ7PvVt19UhUyK1sO2jy8Eur0H5Xfk6WNLTviQUx9+BHiSN/OifOA3sDyzolMFkwAcgPGkvwcj3A0ghGTGs25i/3mtEmcLSjxcbj8UqVqnoNn9nxwiLBX8nysdC9HNzRwc1ivS15QGYIWgtwHqZE9DEwx+GhurroLuXJXc2rI5eZECKzrx0ULzSMsr0CFM+tFROIJa6BXFcm3fc/SfcWk24Ntvsbr3LjdOF0KTxURc7EIJ+DmSNzXXsc/0mveP5g0fv6wHa1qrFZ/zCz1pinmoZbroZ+Vbw7NPDDdS6xvG2N9O2NUMX9BEnfsYakxCe3mNHGeqNTN+8VtM/lRtWXwjztUvYvXZmQez8qioM3dUIwKnlMS8pjoFnZpxo15zXuSKEZEOiYQZy8A3c/7iM7rRSsvF9+m4lPuM5X604diqKJzYDIZ6lOD5l/KOukFff/WuibuubdQj4njqIdW1sIC1/cXDff+9FxenSOVIb5+n3e26UM7JR0bCuMdmrGPLvAMpgS2EUmOf+K7GH+7U+XSVAjJnH9NTBq04+iC8uark+WGG4OaLu9g3Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtaR3RFZVRWMEw5R3dPTlZUTHpxZzJuUExBMmZFU0pFaFZFUldXOXBhK1FV?=
 =?utf-8?B?U2pVTTNTeTBINlRGTzh5WnlsK2lXYVd5RXErLzkveXFjNXpJTkNTZTZMSjlG?=
 =?utf-8?B?Rk0zdGdQbGdqVkVCM3JEbjd5aHA0eHh6c2x2TmU0c0pYK2FZUk4xTDF6THpy?=
 =?utf-8?B?SytLZjVCYmYzNnNOWkhCQUlOQTgzSHRXNUljV01KSzB0YTM1cytWd0UwaXlt?=
 =?utf-8?B?YTY0QVhKOW5PTDk3alRZeVpXbDlyOUZiOThhbmVnLzd0NzhucjBPZ3lTQUtJ?=
 =?utf-8?B?UU5qcGp2eUJDdTFMUzdTRkMyM2ZscW1LZExvYVE3dm5Sd1hPQnc2NWNKV3Zn?=
 =?utf-8?B?Y0pueDRFdUVOTmxGajRXbGtxeDZSYldyMVFtQ3NKejFOdVpZVWp5cFpNbHJI?=
 =?utf-8?B?aTA3aTVJeGdrZHRGeStvYXJvVklVeHlRb0tIdnRMOEsyUFRXTWFFaExrWnFK?=
 =?utf-8?B?MzVpU3JEWFhJeGNWaTMwdkhIZ1Facm1raHVWTW1iUS9QbXdibDlpK0tIZXJn?=
 =?utf-8?B?ekYwRENrWGZQT1RJdGhZQStKTU8rN08vemhCN3BsbnMwMnhLbjg4bTRTK1Bl?=
 =?utf-8?B?K1hPcXdBQURFNEVsMFpNWjliTHFIelFFWm1GSnI0TnRwZzRWQnBsQlhSZDk3?=
 =?utf-8?B?ajhVRU12VE9QUnhzQ1pLbDhRS2pRZzNaTEhOQ1Q4MU1XWDhtc0J5VjdCL2Vl?=
 =?utf-8?B?RkpNMlM3MVBsSjFMVnl5a3VxOGJZTjBNa0dNZkVTekZiclRlZW5QY3VUMjF5?=
 =?utf-8?B?a29BSmV0T3ROc3NoK0xPbmdzZEdpalZ2cDVTWlNTbTNnNk1CLzhVdmN5MXky?=
 =?utf-8?B?QnhZeVVRMGRoblQrOXlJditJN2RrZm8vYVRmM1dLZFUyNzhJZzl3cUF1Tk1F?=
 =?utf-8?B?RW1kL08yR3pKYmJ2SCtEaWVPOFIrTDJIVjNRRTlHcmxWZDB5RE5IV1lKV21S?=
 =?utf-8?B?eXA0L3YrQjJyNm91STJUQ1R5eDQ1d3dGQXZPdjdqd2wyak44ZzB5VzhBa3pR?=
 =?utf-8?B?dDJUNVZlbDQ3YkNMU0NreFExRVJQN3ExcFFFb09Ld1ZHR2JuR2JrR0RMa21t?=
 =?utf-8?B?dVdpQVltWmJUZTRNaG9ZcGFuY2RWNElrbzZUcWRZWGpDNWZIOXZVYzM0b3V2?=
 =?utf-8?B?Q20wU0I2MUFsUEtDQmpRZ1Q2dTFxVEtad1hDNkJRN2FPdmdEMmFSUlNJUWVS?=
 =?utf-8?B?eG8xV29EbElQYnJ4b0dXNENQKy9kR0NUMVpTRC9EdmlGMjR3QnUxU2tORGdZ?=
 =?utf-8?B?SVRrcnhnNS9CQmJsY0xLUWVFckN0UlZYakp5a0RBbFRPMEJlTnhFd0IzbFd1?=
 =?utf-8?B?ZUd2bGN4eG1wd1pQWkFpRkF6SENpd0lYOTdsSEZQeWwwOEVUSXJIUDlXOG44?=
 =?utf-8?B?NkMvWXJ2UU15TThrMUthRGJ1UlBUOFp3ZjhlSVFxaE03QzZPdFVNY3VZVTRN?=
 =?utf-8?B?NmJiY3JLcDBIUlduOGUyWThsbVRJTGw5czBDVk9yQ1FLSFl1cnFzbWV4WW1z?=
 =?utf-8?B?ZllQMHVyU1JzQ3huQkZmWDdNY0YzbVdtTHpnR2hiTEY4emNqcVJ5cFprNG9p?=
 =?utf-8?B?WTBVNHJhRUZUSkhudlJCRm9MeWhZdVhsVzhsZ0NzQUNsa050VzZiZHh0WlZ6?=
 =?utf-8?B?Vzc2T3krejFURS9mV01CRUluTkZTVE5JSWJneXh5VTlXelora1hUaHZrZXR4?=
 =?utf-8?B?VlR4VENvTTI0dm9GM3ZlOVhTK2RwVG5UcjdEVTZnWnlUN2FMbDl4MWkrWmcy?=
 =?utf-8?B?KzZuUkE0cUYwTzJVR3BVeHlTWWFKS3NKZ3dOZGVKZXhqbHhyNk14V1BzZCtQ?=
 =?utf-8?B?ZWp3OXMrN0RiZ1VxRUpCclhxRFdMbEZzY2c5Z0VjYUx2djVwYmJ4UXRKNDJ6?=
 =?utf-8?B?RnpaWHplSUhBdVVuYWZIY0k5Rnl4bWNWdFVOSTJuZGx2VEwzbnZPVTJPT2N3?=
 =?utf-8?B?L3NoNmVKaEFxYmVvdnFScUFqZmxzNWVKdnpZbVFnbCt4TkhQaVpIWG1nMkpM?=
 =?utf-8?B?Vk85ZittTlQ3SmVZQjNOQmZpOUx6d0tYZVpnYkdiei9CdU4rRGlMWGdXRHhB?=
 =?utf-8?B?ZU5ENzIxcFZvQzhtWURwSXFpRDhOYVorMnc4NGtKR1N3T2tiNzZBQkxFSzll?=
 =?utf-8?B?M3owOXRTczM3N0Z3cjJnSzloQ0loNjhpNDVRRGp0bVdndzE5THR6ZTRaWnpk?=
 =?utf-8?B?MWl5RXNVaERHYlVFMnZET2JvTmc2RHVBemUyTXMrYnpRcXQ2ZzZjelUydG53?=
 =?utf-8?B?QS8rMi8xQ09PT2MyV1VIZ2FRandJbktobXA1R1RiQUdxRDc2YTZnTEkxUDBj?=
 =?utf-8?B?T2FEcXMwWkpjOEVobFVUdUJzYXNyTWRLeUNWeVBXd1pCaWM4RktmQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc85f598-9d2c-4ba8-2de7-08dec0b1c27f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:03.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxuq9sgo5aoL0oc37r8LZoSmmPGUKU2e3mwXOdLiqnKuGVMURw2qjBJIp3CrduDa70MO9WP5j5apWMZxnsS49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3626
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

All users have been converted to use keyworded index projection syntax to
explicitly state their intention when doing index projection.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs            | 6 ------
 rust/kernel/ptr/projection.rs | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 79125ee012a9..200def84fb69 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -1210,12 +1210,6 @@ macro_rules! dma_write {
     (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
         $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
     };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)*])
-    };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr] $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$index]] [$($rest)*])
-    };
     ($dma:expr, $($rest:tt)*) => {
         $crate::dma_write!(@parse [$dma] [] [$($rest)*])
     };
diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
index e46877a208d9..c6e9dfbc4f9a 100644
--- a/rust/kernel/ptr/projection.rs
+++ b/rust/kernel/ptr/projection.rs
@@ -351,14 +351,6 @@ macro_rules! project_pointer {
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
 
-    // For compatibility
-    (@gen $ptr:ident, [$index:expr]? $($rest:tt)*) => {
-        $crate::ptr::project!(@gen $ptr, [try: $index] $($rest)*)
-    };
-    (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
-        $crate::ptr::project!(@gen $ptr, [build: $index] $($rest)*)
-    };
-
     (mut $ptr:expr, $($proj:tt)*) => {{
         let ptr: *mut _ = $ptr;
         $crate::ptr::project!(@gen ptr, $($proj)*);

-- 
2.54.0

