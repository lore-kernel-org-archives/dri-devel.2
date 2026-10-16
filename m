Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA17CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A3C11254B;
	Fri, 16 Oct 2026 01:55:03 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E919B11255D
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB3/29QD0Ye6KQ2JuyELtgT4ndZZqdC89Mv8K3Pkjsp3c2dQvTgHHzcGBA5y8VkAn1BU1pQ1xTPPoZHebBMe4rj3Gp5GllxNxO2EWdFmesUhSeKQ0xClaf/Ovv9HJM3gGqV9YX6W25x8Uj4LKPVeuW/ts2Ukv07bLehgzPxrB4lhGi2W/3z4mVaGb5YyGD5BYn13H3v+MeUje7/qBEEocE02Y4xQhL6kYjYs/9vR95v+iPJBeCo2IN8ca5qxG3IJtV9l9FYTntr2Pzn17xEP4MDvrXUeNoMs9hnkPkCX7Cp6rxFghYj2Cw11i8+97WsRuTQlWnLah/527HeL8M1Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp6B6rnvIRg1DlKZJk5M6/N5+Ag9lcAJdKsFDpNkOSc=;
 b=Sb77wXR2IIS+cssB8xtoyrpCUQvTzC3t+EeIc+F+pRDwriVWXRkI4VPhqLxlndOdxy6WqX76PwK51aSNnqcuAkZu08s/L6CKxQSIgKzkTK9lxHn382XhBTlvoTkKuHc/qoq2y2En1oGGJArfYsn1RNG2kDmkEJNzou6udv4B5KmMxv+VdmuBKFD/Tep/smG9InpL7tayyC5S5ShjH4tgVKgkv2JR2PFu3UEPWmzEFwDNuNclKOu1JYu03Nre6A2TDR6x8H5qZsA4Pnw4MTdSFta+3PZOVQTW6DrL5jMcNSiUq+3uQ3O7gSi201hsDWvrBVvHASTQ4NGWclSoxSXS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp6B6rnvIRg1DlKZJk5M6/N5+Ag9lcAJdKsFDpNkOSc=;
 b=GF2Da8ForTrJLk8bD0TWKnP6cmL1DyezeOgmEdYWs2PYQapG8gEA82bgG+P7/J1gk8iidJmCR+quNZ0poXAB90A6gfCseXxtaeoKxmVOREiNJBjHqyUGo9S/1vAdhPsoFcmIAD3VMIBsGEJp/QEIx0QT0Vg7EmOvFqCp3cvxDqVrO+hNYSmBVXZcMRNCIidj9I7ZQYIfnMr2+ZW6LzTKH1DXaZ+d2Z1uUHx/IzWp12E5hwkmlqW+v9XZUIpUGJqhV6s+IPoSzQWT6UmYZSC+vF3qwC0ufqbbZvtV1ovMspE00ry1jBwMZhMakcEpIbpPplucweyB0D+uMYKFFCI0Ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:41 +0900
Subject: [PATCH v4 5/7] gpu: nova-core: add NVKV typed encoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-5-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: ed86c62d-854d-4e74-d15e-08df2b28674b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|18002099003|10067099003|22082099003|3023799007|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mozDVof5RIu3LFFLqaSRywwAg2vbJ4uoLlb06ir5QSAoiI1SfPaAQ4tby7r/ERooQySgf68HjgayC4mCP8tZXu3VlkduUVJ0RfX+iCSCuwAZ6DKb5uDUURTxkPW19ZFjTxdWHXQO2EtDir/6Euggq/Mh4mLKJCKrOSIZaFhkzcEVvXCDCnAfQKwM2h561C6HrESJx27ZCGwJfiSkWoHdy1lBPedqhkwqYbX3pUQetCjtmOpsJ70LQNsheib5xTfIIk29Ic2lCNIXprfQvLZ+0XsrUPIvo1Bb7D2emGqSybm+/caO1BRNY5JolHEfr91Jhfe+AuSnpajmVUrklisXRZ7+YKz9wUH7hhgDQFuOlcBmAfSeIk9l+qlJghY2m/Ei1RDUXXa4jcIhitzBG3mrGFnO5fxr9QccXeHAwxCXb6AZmmU+fJQnh3CQUeC1a09zzE1yxD+N4yaTg14qq4lE+nARd2GXfjQlzOh3qVQ/IhTqYHL5SwzWGuVl0W1EcWay5RaVxEiKoWwHMLdF4AUrqBrnZupCqhMy+AZcDYXzVTnn7RC9ndj/RE+V0LyTZFZz7OS5XLjEEYV0RU9uHUAqOYTaAb3D+WYw33c1dTV+S/0/d3IRMY2Aej6DAvmzbJkR5jXngL1FPtkhdhhCfWvEOc28eBU0dnTpZbS8Tu8WiIrZrijF4bKnNzswBls1c5rHWk1opMLPRue9YOL/5b63Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(18002099003)(10067099003)(22082099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1GNEFXN2poOUZ5MWZMVlRwdjBCMU1LMjE1WXVLVHZQYUVtRHhpZXBpSHZz?=
 =?utf-8?B?WnROWDZKcGtYME9iZ3YvZ3Bad1FjejZidEtEc051VEdPSjN1aVFkM2dja1Vr?=
 =?utf-8?B?SEZCeXNFNUg4RU1jWXA0Ymk3eVUzdzY1czRXZ1RTWllyMDRHMzZXZ0FYN0RQ?=
 =?utf-8?B?U0Z6MEFPY2c1dVF5RDBZUmFmbDYvRkxvR0hUQUt3RFBIUGFMUG96VnJ6RzFy?=
 =?utf-8?B?cnFDeVI2cG9DYVJZbTdMbVZEOHVKZ0dOenRIenJLSWZTRUxYdlZkVG0reHU5?=
 =?utf-8?B?cWh6RkJWb0JFdThZQUFrZlgrT0hRK2srNFEvQVBCU1VVVkhtMnRKdXVYbDQ0?=
 =?utf-8?B?a0Z0REdkVmRDVXliWG5HVzArVS81UHB5L3ltK09SSThybnFtNURGY2pLQmtR?=
 =?utf-8?B?MENZOEtlZm9mWXAwaDlsdDRaMmRxQmI3b21KQjY0WEZTWUdlaEVIajlhUGJj?=
 =?utf-8?B?UDRqNlphY3hDVjY3VDFJS1AwUnFFWmtGTjdBLzhQcnFKNzZjMEZnZFB3ZGhz?=
 =?utf-8?B?VjIwZnlXMXpqaVFhemFpaDBMWUUxaEdGbWJWK09wRCtPWXFvRE5QNFlsYTR0?=
 =?utf-8?B?THBqSU4rangreStVcnoyZXpRaFVVdFpRTEdLRTNqeStqeDZBRTRuMlNOdHdE?=
 =?utf-8?B?SFFKQ09odGdaVFozMHRWWjZMVW1OY3FnMzV4UDFya3N3d0pPaW5iVkdtc1dH?=
 =?utf-8?B?MlQxbnVmUEJTNlNMSTZrMllsV2JiWkEyNURUenpnQzVGdzdnVWZpSktLS3NI?=
 =?utf-8?B?Q2Vhay9iTDNyOG4xWlg2QVBpKzNpbllFeDdJejhwZm00cG0weU9XM0hhSVpX?=
 =?utf-8?B?b3VGdW4zWnpEU1JKWThTRzNHUlR2NzZzUGZFVGlKOWw5eVZJNkZCL1pDOW5n?=
 =?utf-8?B?U0lTYVhBRDhCa2dmTUdwZ2xPeGhjL2F4QUNMYkozY2t3ekIvc1Avb09pRlhk?=
 =?utf-8?B?ZUV3YWt6eWxYcVQrM2xHb0x4WFBKUi9mTGVFNUJYMENXLzdkWkM0SW9McHFZ?=
 =?utf-8?B?VmdFejZZQ0pIVElvZlB2cHdwVG5MSCt4RnEvMUFqenl5NlB3NWpNTDFlcnA1?=
 =?utf-8?B?di9xMmw3WWM3bE5QRVdTMGhhSXVWT1E2OUFSTWk2RUFMQXRLZzZjZDhGQ3BU?=
 =?utf-8?B?YmRETzFTOU80UW1tU0kxbG1oeENxaEt5NGM4b3YwMGNTb1hFVHBGSzExZ3VV?=
 =?utf-8?B?MEJVMTQyZUsyM2x4Znd3VGJxUS9JdUxsdEo4ckhNdTNZM1RsTUQxZCt6QXhZ?=
 =?utf-8?B?NmRrOHp5QVFhR1VpU2NWQUtiKy9XbkhQaDBnVFJvNEswME5SZS83c29TK0l0?=
 =?utf-8?B?TEp5UVAvZWdERkE1TU5qSmFmYlJhaDRkNXo1REMxU2NXeFl5SXNseWM5dDNi?=
 =?utf-8?B?QUZnRWFSNE5ZTkVjaWVJL0FMeXVadmpaVWlOUEJmUS8zaGYzQmJoUWdzcmE5?=
 =?utf-8?B?S2MzZTY4MlZUa0Z5Wk85Z1hzeVJFeW5naC92TWhKa0U1S1pCSTlucG9ENTRs?=
 =?utf-8?B?T1ErT29HdTk4THN5OGFJSEVnandyZGtlSEdCR1ZqM1dRUEozeVNFL0pvVFdJ?=
 =?utf-8?B?eEdWVmFGZ3lTSnNNczhySmR5RmZzamNEbVZycVVSdFlWY1JWTVlGL3FBV0Nj?=
 =?utf-8?B?SXYzR3RiSzdNNGZaU3hBK3FaNTdVV3dFcWZmMHJVRUM0bDd5dGxaaDhrTHhO?=
 =?utf-8?B?Wk1OTXhMSTBJNGdtclY1Y211Tm9QWlZIOHYwNkFoV2RNcFJleG80N0lkSG9Y?=
 =?utf-8?B?SXBJWHpCMDladVo5UTJybG9mS3pFendBWkw4V2JsM3AvSkQ5amE2QUg1TkV3?=
 =?utf-8?B?akdwMlFYR1EwRk82aXFxdEtRRDhySlZLQXBYU2ZVck9ZclB0VWdlTCs5TnU2?=
 =?utf-8?B?TjhtMytBRmlxM0RaSmIvVHYvTXV1L2JaMnpMV2dGcUdkam8wbHd2dXVORjRa?=
 =?utf-8?B?QkZvSjV3Mk9JMDBxQWQ3QmZ2TllVUHNmL3libFhCTzRncm90L3JqTjIwS3Nr?=
 =?utf-8?B?KzVxZXg5SnlMa0d2Nyt4T1FOdVI0bFNNTTFGT1F0anFRajVNR1dzRjZ6WmZZ?=
 =?utf-8?B?RzFGSHAwZDlPT1lwYlgvRndYNGlhbUVYUllBOFNIaEtobVpkRllRYjhzSm5Z?=
 =?utf-8?B?Yit5WG5DRmdUb0JadTM1bXcxcWE4M2lFczhPZGNSQmNMVmx5ODVhdkV1WWt0?=
 =?utf-8?B?ZjBmVlZjNURVQ2cranNhMGpzNGV4T2ZkSm8rZytRTDZSUlI1T2tJOVRRTG1q?=
 =?utf-8?B?NUUyWmhnTDloSk9OVDFlUUxlR2laZnB6cUlkc3luYmUxc2JUTlc1YXF6dTZm?=
 =?utf-8?B?dkhvZVF1UEx5RlJPVmpZWVFqY1VEU3pEY25HUHBNbGdhNlpNVjdIOGwzNTFr?=
 =?utf-8?Q?W6PJaeXyyzC0Jg2A2MCpE+g7mu4lFkoWXyAyj++cnMy3c?=
X-MS-Exchange-AntiSpam-MessageData-1: RlHfcnYH940vkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed86c62d-854d-4e74-d15e-08df2b28674b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:24.3059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJeqhlXWBmEjs55g/IsAMwZF3PQK50Sz8xz1V1Pv9EhkLDMRWiUUarxx2Jd4s/IkBjsXdq4mnEP6qeEfeNSOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

For struct-like GMCAPI messages encoding field by field manually is
noisy. Add some type machinery and a macro to automate encoding of
struct-like messages. The `Encodable` trait can be implemented by any
type to say that it can be encoded into an NVKV `Encoder`. Add a simple
`nvkv_encode!` macro that works on structs and encodes each field in
order. Provide some base types, such as `Key` which statically
associates an NVKV key with some value, to avoid having to make a lot of
newtypes and implement `Encodable` on them.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  62 ++++++-
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 273 +++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index ac4b399fb05c..153aeb8d08d0 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -11,7 +11,13 @@
 
 #![expect(unused_imports)]
 
-use core::ops::Deref;
+use core::{
+    marker::PhantomData,
+    ops::{
+        Deref,
+        DerefMut, //
+    }, //
+};
 
 use kernel::{
     alloc::{
@@ -94,6 +100,60 @@ fn deref(&self) -> &Self::Target {
 /// The index of an NVKV value.
 pub(crate) type Index = Bounded<u64, 12>;
 
+/// A static association between an NVKV key `KEY_ID` and the storage of its value.
+///
+/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_decode!` to let them know how to
+/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevity, `As` inserts an additional
+/// conversion ([`From`]) to avoid having to implement [`Encodable`] for many types. For example,
+/// enums that are easily convertible to a u32 can have `As = u32` and rely on the existing encoding
+/// for u32.
+pub(crate) struct Key<T, const KEY_ID: KeyId, As = T>(T, PhantomData<As>);
+
+impl<T, const KEY_ID: KeyId, As> From<T> for Key<T, KEY_ID, As> {
+    fn from(value: T) -> Self {
+        Self(value, PhantomData)
+    }
+}
+
+impl<'a, T, const KEY_ID: KeyId, As, const N: usize> From<&'a [T; N]> for Key<&'a [T], KEY_ID, As> {
+    fn from(value: &'a [T; N]) -> Self {
+        Self(&value[..], PhantomData)
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> Deref for Key<T, KEY_ID, As> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> DerefMut for Key<T, KEY_ID, As> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.0
+    }
+}
+
+impl<T: Default, const KEY_ID: KeyId, As> Default for Key<T, KEY_ID, As> {
+    fn default() -> Self {
+        Self(T::default(), PhantomData)
+    }
+}
+
+/// A value with a specific index that encodes under the NVKV key `KEY_ID`.
+pub(crate) struct IndexedKey<T, const KEY_ID: KeyId> {
+    index: Index,
+    value: T,
+}
+
+impl<T, const KEY_ID: KeyId> IndexedKey<T, KEY_ID> {
+    /// Creates a key with the given index and value.
+    pub(crate) fn new(index: Index, value: T) -> Self {
+        Self { index, value }
+    }
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index 4585e4d5bcd5..64b4ea46d59c 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -8,11 +8,137 @@
 use super::{
     EncodedStream,
     Index,
+    IndexedKey,
+    Key,
     KeyId,
     Op,
     Opcode, //
 };
 
+/// A type that can encode itself into an [`Encoder`].
+pub(crate) trait Encodable {
+    /// Encodes `self` into `encoder`.
+    fn encode(&self, encoder: &mut Encoder) -> Result;
+}
+
+/// Defines a struct together with its [`Encodable`] implementation.
+///
+/// The implementation encodes each field in declaration order. Each field type must implement
+/// [`Encodable`], which is done already for types like `Key<T, KEY_ID>`.
+///
+/// Use a lifetime on the struct if its fields borrow data, for example, `Key<&'a [u8], KEY>`.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_encode! {
+///     struct Request {
+///         id: Key<u32, 0x0001>,
+///         name: Key<&'static [u8], 0x0002>,
+///     }
+/// }
+/// ```
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
+macro_rules! nvkv_encode {
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident $(<$lt:lifetime>)? {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name $(<$lt>)? {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $(<$lt>)? $crate::gsp::nvkv::Encodable for $name $(<$lt>)? {
+            fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::Result {
+                $( $crate::gsp::nvkv::Encodable::encode(&self.$field, encoder)?; )*
+                Ok(())
+            }
+        }
+    };
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u64, KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u8], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u32], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u64], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u8; N], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u32; N], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u64; N], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> Encodable for Key<T, KEY_ID, As>
+where
+    IndexedKey<As, KEY_ID>: Encodable,
+    As: From<T>,
+    T: Copy,
+{
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        const_assert!(
+            size_of::<T>() <= 32 && size_of::<As>() <= 32,
+            "`Key` here would materialize too large a value on the stack"
+        );
+
+        IndexedKey::new(Index::new::<0>(), As::from(self.0)).encode(encoder)
+    }
+}
+
+impl<T: Encodable> Encodable for Option<T> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        if let Some(value) = self {
+            value.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
 /// An encoder for an NVKV stream.
 pub(crate) struct Encoder {
     stream: EncodedStream,
@@ -201,4 +327,151 @@ fn encode_all_value_kinds() -> Result {
 
         Ok(())
     }
+
+    // Tests that encoding via the `nvkv_encode!` macro works correctly.
+    #[test]
+    fn encode_typed_struct() -> Result {
+        const U32_KEY: KeyId = 0x0001;
+        const U64_KEY: KeyId = 0x0002;
+        const NAME_KEY: KeyId = 0x0003;
+        const FIXED_KEY: KeyId = 0x0004;
+        const OPT_KEY: KeyId = 0x0005;
+        const INDEXED_KEY: KeyId = 0x0006;
+        const CONVERTED_KEY: KeyId = 0x0007;
+        const INNER_KEY: KeyId = 0x0008;
+
+        // A value that is encoded as the `u32` it converts to.
+        #[derive(Clone, Copy)]
+        enum TestEnum {
+            Value = 3,
+        }
+
+        impl From<TestEnum> for u32 {
+            fn from(value: TestEnum) -> Self {
+                value as u32
+            }
+        }
+
+        nvkv_encode! {
+            struct Inner {
+                x: Key<u32, INNER_KEY>,
+            }
+        }
+
+        nvkv_encode! {
+            struct TypedRequest<'a> {
+                a: Key<u32, U32_KEY>,
+                b: Key<u64, U64_KEY>,
+                name: Key<&'a [u8], NAME_KEY>,
+                fixed: Key<[u8; 4], FIXED_KEY>,
+                opt: Option<Key<u32, OPT_KEY>>,
+                indexed: IndexedKey<u32, INDEXED_KEY>,
+                converted: Key<TestEnum, CONVERTED_KEY, u32>,
+                nested: Option<Inner>,
+            }
+        }
+
+        const U32_VALUE: u32 = 0x89ab_cdef;
+        const U64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const INDEXED_VALUE: u32 = 0x1234_5678;
+        const INNER_VALUE: u32 = 0x0bad_f00d;
+
+        let index5 = Index::new::<5>();
+        let request = TypedRequest {
+            a: U32_VALUE.into(),
+            b: U64_VALUE.into(),
+            name: b"name\0".into(),
+            fixed: [1u8, 2, 3, 4].into(),
+            opt: None,
+            indexed: IndexedKey::new(index5, INDEXED_VALUE),
+            converted: TestEnum::Value.into(),
+            nested: Some(Inner {
+                x: INNER_VALUE.into(),
+            }),
+        };
+
+        let mut encoder = Encoder::new();
+        request.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+
+        // `opt` is `None` and is not encoded.
+        assert_eq!(encoded.len(), 10);
+
+        let index0 = Index::new::<0>();
+        // `a`: IMM32 with the value in the `Op`.
+        assert_eq!(
+            encoded[0],
+            Op::zeroed()
+                .with_key(U32_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(U32_VALUE)
+                .into_raw()
+        );
+        // `b`: a single-key SEQ64 followed by the value.
+        assert_eq!(
+            encoded[1],
+            Op::zeroed()
+                .with_key(U64_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Seq64)
+                .with_value(1)
+                .into_raw()
+        );
+        assert_eq!(encoded[2], U64_VALUE);
+        // `name`: ARRAY8 of 5 bytes, zero-padded to one `u64`.
+        assert_eq!(
+            encoded[3],
+            Op::zeroed()
+                .with_key(NAME_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Array8)
+                .with_value(5)
+                .into_raw()
+        );
+        assert_eq!(encoded[4], u64::from_le_bytes(*b"name\0\0\0\0"));
+        // `fixed`: ARRAY8 of 4 bytes, zero-padded to one `u64`.
+        assert_eq!(
+            encoded[5],
+            Op::zeroed()
+                .with_key(FIXED_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Array8)
+                .with_value(4)
+                .into_raw()
+        );
+        assert_eq!(encoded[6], u64::from_le_bytes([1, 2, 3, 4, 0, 0, 0, 0]));
+        // `indexed`: IMM32 with a non-zero index in the `Op`.
+        assert_eq!(
+            encoded[7],
+            Op::zeroed()
+                .with_key(INDEXED_KEY)
+                .with_index(index5)
+                .with_opcode(Opcode::Imm32)
+                .with_value(INDEXED_VALUE)
+                .into_raw()
+        );
+        // `converted`: IMM32 with the `u32` that `TestEnum::Value` converts to.
+        assert_eq!(
+            encoded[8],
+            Op::zeroed()
+                .with_key(CONVERTED_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(3)
+                .into_raw()
+        );
+        // `nested`: IMM32 with the single `u32` it contains.
+        assert_eq!(
+            encoded[9],
+            Op::zeroed()
+                .with_key(INNER_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(INNER_VALUE)
+                .into_raw()
+        );
+
+        Ok(())
+    }
 }

-- 
2.56.0

