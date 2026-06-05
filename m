Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA18CD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DA510E4BF;
	Fri,  5 Jun 2026 08:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xomg1oEn";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B8210E4BF
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzcAEPAJgv5XDYIQcOx6nqxBo1vYYYvuT0rLmwwNUieTVyEHyjooODYSP1IEp9XWNIJ1hoFNJcs2nwd9L8V4P8R/TlZzp1LIwbzpVkcoe7YJJiamThsuIHZJ3hVU5GvGJjpJzRe41OxEw5zjE/f0oA5vWETTp19pxJaP5BLeeNY0T97NBK5CDh5Kk8gFPYaQsn0SB/9/oG/vDM/JQycdOJDspML+5KOWdOzQfDstfnMwljALBIl92PmtWPNtng1AIux8GijwYp1mDW+Th3R60tg/6CpxU/p0QQA2iXSX+tOyr3L9i6h6+/eqxA7IAxpnk8Q8/HB7ZedTlloAciNQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGXPDaZZDkJgkJFubr5PT+GLXdr9xBLB6v4MeKTmpkc=;
 b=cHBWuqmkFJFmVTTnHeFlaKSwH6Kdmzs0gVmzV2P2PThL1UXTxldR/WFBj7wlVJchTNVN9lep4I5CNRGm50BOe+GHs2BI7yEd5a+LNewULdIlLCvW3rdfaBXVdsMbWkE4YB++3OKTJ+szTHooWPJ2FCATyW+wWF5uPvOWNBJiy4+RnUZg194Jl8BHBiHoTju9Q7cK0FvybEA0HWUPb0urH7YsaqNP4CUF6nkjC3yz+Ur5BCb4ICLngeIZJTXfaJ+aN0ycZbBubQkHarxbMaB554otsybzgDO3ZEDMFjaMBTWd0fnv2AVAtJzX18lwZIoCvPCUXkTQi54zxWOYvIW12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXPDaZZDkJgkJFubr5PT+GLXdr9xBLB6v4MeKTmpkc=;
 b=Xomg1oEnC44oRYLTfHD1Q9JsbBvDBA72gibg4G0paZQNe+9VrnadCIgM/IwsQitk9TiAHXhyrZzD/OtYR0+AqJqXZLBRDblDyPoUWwbxC3Bj1kaIr1WUkTG+KRgLFiHz4LiKzRltyic82NxMKjabRbG43DrR9El72AzAnkW/PoVoEazig/idym3hjcYRu0wVU9U3C4cLkN5xiO14EBTaQbr4KIHyfzUH1upw5552ZdOzBbUyfEwWAX5QXhhWvomyWn7PIFdRPKhwpeoV49ZJLogqzMqE6gcJm/usDZ/39mXCZ5ROWDsh9sD22MS2VY6TvFerT20AHvmiKYS+v6gcwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:32:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:32:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 05 Jun 2026 17:31:55 +0900
Subject: [PATCH v4 5/6] gpu: drm: nova: build after nova-core and use its
 symbols
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-nova-exports-v4-5-e948c287407c@nvidia.com>
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OSAPR01CA0281.jpnprd01.prod.outlook.com
 (2603:1096:604:2b::29) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cc65cb-66c2-4306-c217-08dec2dcfa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|376014|6133799003|921020|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S8+Tc9UlgY1nfuTH/bgtYkEHR4YHhFsLtpa/3T7GT8JKZdK1qQG6VFTJs/RhnurZFzV6wi4xppV/xIlSzQP8RYqwSufJrRxhdi52VH9OEqDAnbgVfk10qFwiFWhoL9xMkqLE/1ltr4V2YAUQ9oYXkTsl3DP2OcJ+uemmr4zoE02+Pk7EPutIaX8Xt1nQXptiRDNF3jTg02qiGGyQ7PkB538dQEtFhYJmF3f2tpwRvDTf54twilTI7+Tyy6Bv0lbjsdUNmfuFJhjoshfJ6rpKSG6J/0NLzHjHHSp3nnSUMwMZHaNc1GBWZn7QwEIf7cMjHf9HZYtCMpotHdGqe6jwtnmaecKxu7JTj3SAb/X0tY9UIx5nCS1tK0RN7F3F6xqccxAb8jDDykgP6oLwKnl4g73MAZPahFr7cTEkjE7OXtCzAKVVDYHj0t5oSyThi+fiUsY1ADQtebsvnPiYAO54FH3Sr/EkXz7kejdh8bx6IJqiyLeQGeVxOXi18lRQjp6+WmUkCoNm0LPulgSTTfrPzP3IYxYOQOBqmweuY44ko8RLsbxeVyhNRU+yaWEWynnuCQQm/zP2TKS4EbpdXXAirR1UYiXaFw/pOszCsKIBhh/QJAqr5M9BmC6RhD9SrLJeT2+DXd0uwlcMGTwXwOJGzp6g6quKLX1LhpKwNyYr8LhPrn6ZbH+sY5VD8TnSNLcPPkeUfJ8Nx6r5BSF612JVwt2DAQVxmThn9Rzt3Lxo40M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014)(6133799003)(921020)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFHRk1PUHJsbjkxSkVSa1J2Nk9mNklObnJTNFk0akhDT01RN0d1bUF3R0hQ?=
 =?utf-8?B?UDVrL2hWTmdTS3lWUjQxc0JyQTVMSXQvMUdDV1dqdklmWmFxRHc5SnJlc2V3?=
 =?utf-8?B?aGc2VlBOWEZTV3VtMDdVYW5YOUFxUGVjR2V1VVd0RjkyOTR6d1RpNlpsMlpO?=
 =?utf-8?B?a2EvQW1QOW81cE0yMmxTSFZaM1cxM2hwM3JENVNIMEN4dzl6WXp4Z29HcldP?=
 =?utf-8?B?cmtHMmtibnZKV250WGNXYW9kV1NHb0xiYzFQb0lQdUYwaWpYUXdKdDJiREZQ?=
 =?utf-8?B?LzhIb09HWTB3TXV6cTE1UDRxbEJqejdYMFZqUUIwaHdFbDRsWjZ3NDc0QWp2?=
 =?utf-8?B?cCttK1JselNXbTNOSFlZMkJxM3B6VVBwKzlFMHhxS0t0eUh3NjJzSGMxelRt?=
 =?utf-8?B?S0hKV2JKc0drSk1GMUpjenVMUmE2OVY4elhHdnBTTllReGl5UDNPSXhOWWdm?=
 =?utf-8?B?ZW50ZVJkRktmOW9HZjJqcnJZbFJoc2FlTEpHTmRvWHlReDU3TEozZkxIMHdI?=
 =?utf-8?B?aDZaUTd0Mlp5Qjgrand5RDRPK1ZDRm4yb2hjWFJvUFh2NW5FU1kwNXZCZmFR?=
 =?utf-8?B?TE1mVXphTTdtaW8vWGF0MUlQS2RpM1ZTcHppdkpHeU51UExPWTBrb2F1dUU0?=
 =?utf-8?B?b1RERVJ0S2ZjYmFOamV5OUFVT2s1bnBSRnlMa1M0VzJTRGh3Vytnc0VTTjg0?=
 =?utf-8?B?YTU0Y3o0OS9QOXNPaVlhcmRTN3NlWnlReXdJam02ckxIenJ0a1hUeW10UUU0?=
 =?utf-8?B?R1hjL2ZSTGdweDZBWWdaWkMzbDAxZWxCb002eWF1dlh3OXM0dXVEbExNYlVr?=
 =?utf-8?B?aFZzVUhoME9Obkhkbm5XeFdlN0VoZis0TUtzbTNnL1M4djlOSDFrRXJpaFJp?=
 =?utf-8?B?QW8xNXFXTmV2OWZIdXhwN09DTGRwQlE0Umd0ejJVOGpqckVBbUVIN2psOWxW?=
 =?utf-8?B?M1dNZVhPTHZZUUtVTmROV1ZTS3VIZElQakJFOUhLeWI0MXV1L2RlSEtLbjFK?=
 =?utf-8?B?VnJ1cEVSQ3ptUElwWEQyZmVSMUgzNjhYck55ZjZITTVTbjJ1RUJUVGkyb3Nu?=
 =?utf-8?B?NnkvcDJvM1lRYUxTYWt0VEdkdG0vM21RRlpzcHVEZVFzUlM0ak9BdnR3NHJx?=
 =?utf-8?B?TkovZklyeXl3anlOTENPTlZZQ1JoQTFEN1RvWmZ0cSsvM1J1LzJOL0hYUFJ5?=
 =?utf-8?B?bGpoM1pNREdYRUFaTkVTUnROZXBseWx2aU4za3daeTh0bStqYlVKdUpucWxn?=
 =?utf-8?B?RG15TnRNb1FPVVczdG5sWFE0WEh5K2oxL3EyMEREeFljSmVEUmJkUy94Z3ds?=
 =?utf-8?B?TXczTE9uNk95WDd0cFdOMDh1WVArU3llNnR5SlExMW9Zc0NkNi9za3RlYkF3?=
 =?utf-8?B?SmlJQnN6djRpeDVuNkxCTG1rdkxkMkhES0ZMUzlCcXRHQ0xQeGZuUmNNWHY5?=
 =?utf-8?B?Snh5d3BlSzVkcEh5eHExMnRjOG5XTW9ia2xKakJmYSt0RTYrSWNkWm1MMWIy?=
 =?utf-8?B?K2crY0M3RlhzTVJSQkFPYmxXMmwyYkVSbVZuK2d6Y1ppQ3VsbXFXQ2ZGM3pB?=
 =?utf-8?B?NlpyZHdhbVpqK0crZmoxb0ErWUZaMS9FcDBGMVZvL2lEMWFaY0JPcExRTDJo?=
 =?utf-8?B?eEdnZStkTCtpZnJEb0FtLytUZGdubVdsMEtzR2crbW9mNnpWLzl4UmpjbTl5?=
 =?utf-8?B?cHVlMWZXYW9GSnk0a3BXWlYyMDJlQkZ5ZFdmN0JVb2RYMGZLaGcraGlqbTM4?=
 =?utf-8?B?Q0M2Z0hSeXR2T1dhcmx2ZDlqTjc3dmNrYVE4K0RYaW82VUFCOGhTVUdRR0J6?=
 =?utf-8?B?VzdpbmJaN2QvVkVEVW5wYyt4dWpvMGVWRFNHYXY0Q2Iyckp3Y3dPRDB2cFJS?=
 =?utf-8?B?U056dzNtd0lINmZyanUwUVR2by9jbkpxcUc4NUthWUJsMW5TUk43c3IwdGpv?=
 =?utf-8?B?TkN2Y1JZRHdyVE1hcG9ERUZ4bzdPWUE0a25sVzJDd25tVENjblVxQ3pqTlF0?=
 =?utf-8?B?bCtReTRpRU01R2tweVAzaWVZY2dQMGVTWVlNcDUyaFZXelRVZlVORHloNXI3?=
 =?utf-8?B?bmxhWkZRNE9oWkNwNll6d1dtS25neGQ4dXlZYjhWQ290U05WcXJuUlFjV1dP?=
 =?utf-8?B?YTltSk1lbTNvem1JazUvN1Z1Z0g0a1ZOYlA1MUlraHBjd0p3OENOZEdRUHJG?=
 =?utf-8?B?ZGc1emNaeFF4ckx5dk5vTmlNSjVqbFhMKzJCOTlERHlvVEgxUkFTZWNidmZ1?=
 =?utf-8?B?UUMyZGhuYi9sWEgraXkrRzcyNm9INVMyYWVXdEZrUXlsWTlqbUFUREJ0WTkz?=
 =?utf-8?B?NFZ0cFM4U2ozTjNVdS81bWV4Vy9hUVd0MEx1cDlQUVJKRi9aUmp1c1lhMkZ6?=
 =?utf-8?Q?ESI2UWm7tCtiAVJYQ2P00j0cmGwlXAOMT/Cgc0kUrajs8?=
X-MS-Exchange-AntiSpam-MessageData-1: UgFK+BKfe8csyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cc65cb-66c2-4306-c217-08dec2dcfa2f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:32:28.0580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IsrIUl0KK8jADdcTjl0NhzcxAOC+KGNK8AIz8gV7XjbNN3AaH1YrGvnBWb4q+MQZz380q0xJEtaZ3qUz4077A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

Make nova-core a build dependency of nova-drm, so its crate metadata is
available and up-to-date when the latter is built.

This is intended to be a workaround until the build system supports Rust
cross-crate dependencies natively.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 164e704bc741..a996047be69a 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -38,3 +38,7 @@ CFLAGS_nova-core/nova_core_exports.o := -I $(objtree)/$(obj)/nova-core
 # Output nova-core's crate metadata for use by nova-drm at compile time.
 RUSTFLAGS_nova-core/nova_core.o += \
 	--emit=metadata=$(objtree)/$(obj)/nova-core/libnova_core.rmeta
+
+# Allow nova-drm to import nova-core's types.
+$(obj)/drm/nova/nova.o: $(obj)/nova-core/nova_core.o
+RUSTFLAGS_drm/nova/nova.o := -L $(objtree)/$(obj)/nova-core --extern nova_core

-- 
2.54.0

