Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCD9C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8939810E902;
	Mon, 28 Sep 2026 08:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzBM7j+A";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A7E10E8AB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAKbhcUmb3c9LHvkiTcqJaUMDWsVDZfKTCGG6WXJZ1xMp+nOmhMCcXs2MKaBTbunr+a4LHzHNBqN41zySjQm1ulZfcKOqg9LOfpKQYrNd+uCAb7Zc/ERFQ0O3JlJl3cP4aPRH1kI4VVsXUjA9yFMzMlySvhKzeaYEudVgvX0k34P0DNi018OtYl3eTh2SrZBYyK1m+daStA0D9JKar0kmkoVofx4AJyIIESlV7qUmFpxNHzdgwYLgRo1hIudFsWz/MbjBf7FbSPOZL+8DvNXMzEJQa6NwPHBBo2Bo4dELMO5J2HHy/pgMYsbMfNFg4j4TPySgB861JvKNoH1p7b24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtVpn+OiXrI1znyTYB9URgUkP7WgVNIA3CIbMb84E/s=;
 b=jY/HLEy9iyfrmqvf2m8Sb/+0Sukav8T2JHpsoXb0GCZtSdtR+g3r2Cq8CHVjZMYLRctt5P3Gv8HrRJS4ClpVMC7r4fo9O5zgT4IK70GyZI2Hkokxy613zpDyvoo2FHHwWHfZlncu0WuVSWqGkMJDIV4u8+2pvLT3YaZbUZSURzjoWgnxU2CUIUpTDgBUcXbztCkVHg/P8V0tqTA9LpVmvUsqRgQh78iTMz2B5xtrQUFi+5eXIlLiBeVZCSNFOdJNh1msH95HFayXFdOBufsHoHhCEAM0IpQVQ4nGwmdGZs6tlgb3T4IHAMOqQ1gwJhjKFG++jeNEI+9FVyJSXnXURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtVpn+OiXrI1znyTYB9URgUkP7WgVNIA3CIbMb84E/s=;
 b=HzBM7j+AXCMAeNUYZZs624pF54hCurMvHD9qB4prYciq4Y5ZGIcPIoomEChGNIr77izItkKCla11+HcTRhjS3Vy18LKzTs6/g+fRNy0Jx/IR2sBfHmN2brwPKBHO75rDUxPvJSzc41cKiNZsDsjPs8LDkAZtwYFK3WliCvyq5JNSs9aXG769tzW5+AgNKYgrC5IiGG23OQOoqu+9OVwnm2VG72XGuwVhWb+dwb+VPzPBVMik7a2sYoIZmFy1HFbzbUwvgAHY7v4JQaBkY0zXDbyegfHzUUQ437K9pBYHeXcYFDWTlO8BmKpfP3D+dYESAJDmGNO0N+nZRK+MUlUB2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:41 +0900
Subject: [PATCH v3 2/8] rust: alloc: add Vec::push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-2-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ca6b5c-68a4-489f-f418-08df1d3c83d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S2ktxvX2P/VnA0kI2ysLG2TkwjwNwSdVPaoErn/NldNzfn14lXcfhpFknBjKdCdUBtI7LJojkFBDkmVtw2WdS9LAFNpQfFrafPTfOYPVk9O77K11jtwQ6F6616PtrYfD5ZOkZlCcsi9r43xCRRlhmhIT4YzFlaQKKragoXmGHcvGaCa7pCtmgINR2QK2Lcc9fWkINF3I/NUEv7atQIy5rxCo8d3ReXbcvQiHYRFIOnhAGk6gvMzRg0dvxIPQkLzsurKp+FVS7Uc6BPuDB2j4+e/PPf4sboMAO6GNl88miCKOa/xrEcoFn8VBWGzq8pK+IJLvL/a62YvaJyzFoPQW9+zMpzn9boR6HD/WwcViEcrDbKu4yDnlHCujonH49dBJ2+Zdt5eYR/XcaZG1efzN7TCwLxlvCUaRq2FaxVinR81eENDEVnXAymahCSyl7HlDrHon3cT5AQWr0zqGs3xKB6rmWvb33TMo5ihTnK/WsZlzKxHP47Hrvnd/csb9z5MuSm8cU4P3yFnxwEKJgcQVR4sr4wucS+xQ/xFHJ/Opf/veqogeNRI6Ey/wIzt4ytDpQ6mohP7AaoCWpddrGgHNQ4P2aYVqM+kEP7wZXTxaHYI6XOdZ0zj5ZFbYkLkIGZuuFOxPYNSqdLZrlQG+OMmCIhPY3+qPzZxJwtSzwUWB8qZek2eeVZVAUd/DmiIRCW0wa/nQBl9/GMvy+2nQq4eFrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNCekR3MmNIUEtlU1BnZlROZGp2OU5McHowY2kzSlNRMFVKVysrOFE1V2hw?=
 =?utf-8?B?V2lkS3dCTXRtbEhwakcramlsUEI4ZmtFVTI2Qm5MeXRwbzJjbzJyMW9MT1Uw?=
 =?utf-8?B?U1U2Qnlsb21tNm5pY3pBQ1hhWU1PcldkLzh6enBhc1Jac3Y4U0RLMW9PSWI0?=
 =?utf-8?B?R1lhZ3NnSldiWm14MW5hQlNXSTBkTWhDVGpvSmo3V0t2RDJzcFQ2Q2d0YXdk?=
 =?utf-8?B?bFJnZjg5SFAwdWNlVFJXVDJSVC90RXd5djJ1dEhlSHVNRmZXQVk3NjNMN1dV?=
 =?utf-8?B?RGZTQ0NWL0FTMlpXODFkUzZiQ0pZZURrRFVMM095TnhSMUJVeVlOeTVVelVT?=
 =?utf-8?B?RG9HeTBlcDdHSm1uMXQvaFZzSi9EdGNOVEVDMFpSZEl1YWRReEdBdHZMNVNK?=
 =?utf-8?B?dEhTWmVvZkpQelN1eXd3K1JqVlFxWUlmdktGemF6eERtVnhDcnRVNHlpaEJQ?=
 =?utf-8?B?Z0Zab3hKZmtDVjhLVUZhYmpUNUI2UEJHZWx3STRSVGQxWE9EVkpvSFExRWFX?=
 =?utf-8?B?bWxsclhWQmpnWEZKeUlWVlFWRDlSYmlRRVVpeFU4aTAwcGlsQXEzU09OZFhH?=
 =?utf-8?B?M0NNVVo4YS9pc0pMYTNXR0NQREthQmNIelltcFlHZmJQV01xMG5rZW9XZnpr?=
 =?utf-8?B?Z29iUlRHbis2R2lwTGhORGRvVGhNZUw5VzBkNXVDOVI1eXJVV3ZhSkZYMFpT?=
 =?utf-8?B?ZU5EdUhVOWJBSXhEMmh5YkpUVllWeFhjQyt3Q3pGWGgrTGg0andmOWQ1S1Ro?=
 =?utf-8?B?bFIvOTZaRlhzUmI4ak1ObVRYelAzTEdvekxVOUphQ3Nyc1FnaGVwQXUvYnk5?=
 =?utf-8?B?V2hLanZNQVlPYUY3b3FoaVFiSENsNE82YWZnbE9KWU1DQ2Rwa1daaWdXVWFh?=
 =?utf-8?B?Qis0STgwNGdKVGc4RFZCUjZGTW85ajhNQTgwUVN6T0Fwem8rVUtDYWN2b1Vv?=
 =?utf-8?B?dEFhdVh6RHlKS0NUMnlCZ09XWGdKZ2oyK2ZORzZWcW5WcXowWnl6QkdVK0lt?=
 =?utf-8?B?bVhISkxaa042cFhBTE1Zcmt0R0tZNlZhaDJuVStLS3B0SVNRMlFJK0htMWh2?=
 =?utf-8?B?ZENyTlJ1L0VGKzJBTytyY2dFL2VoS2FOeXZlbXpnb2JRdEZIMjhMU24xVDlB?=
 =?utf-8?B?YnY5Wjd0M1hvVS9sNFg0dGZ4UktaMk14dlRrRll2NUNCTDZmZkJXd3lBWXln?=
 =?utf-8?B?MGZrMWZUeDV1bkpxcnVQVGw2K0pSbXJnVWw4b2xFOEg2WVc0Tys5dXhkWjZw?=
 =?utf-8?B?ay9uNHBCM0h0Ni9tbkNQbzRpVFBzWlc3WFhhbGVvc0xmcUxrYTF0aTRPTXFN?=
 =?utf-8?B?YXFESFU2cmhGZHRQQm1sYnZGYlVtQjZiM3NpWGJaUkZ5WHVRTVd5dmR2L25K?=
 =?utf-8?B?MkhRa1cyUElzMzVZUU9rTkFpQjFZS21yTUJacE44N0lYRHJOY0JsVDVQbmd0?=
 =?utf-8?B?TDg1dW1OOEFjUm9jc0Nqa0JUVVFsUkpSRWdaSnd5bHpwNHRWRFJRRFplOUhI?=
 =?utf-8?B?bEZ4dzNSMzVKRnhnUFVJbmZvblo3NkMwSnJWVW9ieEFheGtFenpjd0JoNVh5?=
 =?utf-8?B?VjhESEE1d3AzdDlrTzVrZy9mOFV4RGthd0huSlRtN1RUV3NaMitWL3dRN0NW?=
 =?utf-8?B?VW1QN1prazl4TDgzU3ZXeEk3N0hiZkY2RmlRa0F3aHhmbzVtQndlOE1Lanlx?=
 =?utf-8?B?RDlaSUQxcmgrbnh5Wm5QbS9HanllaWw1ajd4M0tBRUZEZTJNbFA2VkNYYW5S?=
 =?utf-8?B?bDYyUXB0eUo2TGp5UFk1TE1lWUhZMzZCMkRVNSswQTNwVjNUN3krMThlakxO?=
 =?utf-8?B?Y2lCczRzaGJZaDhOTi9CSmhwOVBSMXhVa1NweEQvTk1GWlI2RkJpbTc1a1k4?=
 =?utf-8?B?N2dyemhwN2s2M2F0YlJLOGtRWmpoVWNwSzZyZzVPNEdwYklTNTk4anBpczlR?=
 =?utf-8?B?M0h3ZVM5Y0hld21QRjdLSkRJeFhKUWlMc0FNR29nMEJJUmxYZVZ0aXlDTkFM?=
 =?utf-8?B?bUNnVUlVUHFDSUtobFNnY3ZDMzh0Um1pVWNwaXpibWxEM3hCUHd4bXZKaXNG?=
 =?utf-8?B?Q0R3RjloMWZHb2NIbVU5aEtRUldpVzlMYmw5Q2tjMU9kbllKZWsyR1hKUXJw?=
 =?utf-8?B?MUZudjNMc1h2WU9pUDFBbFJ3OEs1S29jTWtVckJ0N2FRN1E4L3RaWXdVRW1j?=
 =?utf-8?B?WFJqOFNTVFpDZFJQdGw1NDJqMmJ2YWdxM3F5NjUvV3BudUNTVGdwTXZBUzhr?=
 =?utf-8?B?NFhYNHZxZkRuSGN5TTV4VytHUm5wRGtxMjNST1ArSDJZTXJDcHBiclhFTUY5?=
 =?utf-8?B?VTZjWUV6U0tIZWcvcjRmUUtRM3BDbjVJTUxQMHJZRG9KY3pBZTZicDZET0s0?=
 =?utf-8?Q?IHkyM0HVyf57zyqJdP0qRgoGg9u1G+QsrjqRDzG0qRFhk?=
X-MS-Exchange-AntiSpam-MessageData-1: OOHMkSotlnR0dw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca6b5c-68a4-489f-f418-08df1d3c83d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:05.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRhwzxc3daXbmwVyr781M02OyWEe6nGjUXKraGg2Zka8qazsQmL0PDjP1afahCPKZtXG14ocL1K9KVnzOxJ1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Add `Vec::push_init` which is the init-infallible version of
`try_push_init`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index a2b72a7779d9..1b7b3a1ca770 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -369,7 +369,24 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
 
     /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
     ///
-    /// Unlike [`Vec::push`], the initializer may be fallible. If the allocation fails, the
+    /// # Examples
+    ///
+    /// ```
+    /// use pin_init::init_zeroed;
+    ///
+    /// let mut v = KVec::<[u8; 200]>::new();
+    /// v.push_init(init_zeroed(), GFP_KERNEL)?;
+    /// assert_eq!(v[0], [0; 200]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<(), AllocError> {
+        self.try_push_init(init, flags)
+            .map_err(|PushInitError::AllocError(_)| AllocError)
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// Unlike [`Vec::push_init`], the initializer may be fallible. If the allocation fails, the
     /// original initializer `init` is handed back in [`PushInitError::AllocError`]. If the
     /// initializer itself fails, its error is returned in [`PushInitError::InitError`].
     ///

-- 
2.55.0

