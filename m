Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB1DCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F066113A55;
	Tue,  2 Jun 2026 14:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="iuleAIyk";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88ED4113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4gCoZ/GMSTg4oLJtVxXFZ7SE5Rg2XgeVxOhuT1mbspilmoXmbwtuAhwZXZ1qRV9VP77WZI+UrSSlp6Bq6m6XAyWQOMVxLEwE5ZH3jqDl1b+ajDJgGJ4/q9HCLHwgVz3KiByXYy1E1Ij78iW90jXlRKgXe49LRqjtTCR6wUtQw+IYJgzCFhW5qf/Y96J7ZZii4rvcUgu/K+S8mPv/5iSAwKlhaD67GOhDeXOE4rvmU+OHg8qfqMPthupjydg4Pd0Ps9DBtfDcG5q39AkMqI2UxEMFhJ9+0TgX3kcwbp99kfpW5+5PjdiwJ0Joyio7JcoKWx4wFDNOw3XJ78nlQ/iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRjeqqHooDCH68bix3cdDq29gatIgrx6TCCbpQUpqCs=;
 b=MhpdMTp8FLxdLKPYaBKui9PXfGXruX/eb4E3ZUmaRPtRKsSwMpTnP9fXfcDkifSCrPjgAQV/r7H1D1qW6NvBK+/uCDPYiCfG0PHahsbzir+/l+sXUz85TsiB2ioJ6TvQLBWoBv2NTFF8itqBFqI3hG/EcNc6hM4uctnQvPs7WJ67eEhurMJwalS1waMWkVL5jtrjabvdbkvXRTMx6iCQk6S+awFWKYn6J3hlRMlK+r8ajqrVucDigKMR2Hb7FdR7JAYRJfeuQwONINkq1Ojz3xaOgUPLoudhGHex0hK4PxK9DS22UpFI3h+V8MF7xsGs9lVhmMWa2EkNhXfUz62Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRjeqqHooDCH68bix3cdDq29gatIgrx6TCCbpQUpqCs=;
 b=iuleAIyk6IWO2gOq0zjP4lhOtAlzLhhw/yHSgIHvku4aWNaR31wB9iz0h3y6vwq+vNmArauDfwXtE7evjEyghkttcdweuWgPZJ3ODey6yRKla/6HgM4bu39OG599Tpky1D2uVUxg7nRO+FpGQwqf3cdbpCd9QGUNc+0AeQA3YVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:01 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 0/6] Rework index projection syntax
Date: Tue, 02 Jun 2026 15:17:51 +0100
Message-Id: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA/mHmoC/42NQQ7CIBBFr2JYO4bSItGV9zBdAI4tmkAz0Nqm6
 d2FegGXL3n//ZVFJIeRXQ8rI5xcdMFnEMcDs732HYJ7ZGaCizNvKgkDhRfalDWIi096BsJPoDc
 YdeG65tJYKVieD4RPN+/pe/vjOJqyLb1i9C6mQMv+PVXF++NmqoBDI7kStTW1EurWaVq6MZw8J
 tZu2/YF9nyuXtQAAAA=
X-Change-ID: 20260415-projection-syntax-rework-b790a305bc52
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=3121;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=W9/8Jz0PfElOc2/CmWBDkIX2sx9kQlcPe5ctnIwRHTQ=;
 b=VNNfbZ3RRQcMT7+IMtA+GN8cjMO31EMRxPHMssDOKQSRfYszjpjgoHNiRrKaIi4KfwCsUWWAu
 eSrW5pDlk05Dnak4CVWz9p+IhgvrmZDmhBl26XQ4PiNwOU/4EkfmmMU
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 2988478e-bce6-4799-5aff-08dec0b1c138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|18002099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uZUKaC0/6defvsR40LaOjnA0P0bDdRE23r+GJDTloELBcKjFCZJAt+fqrhv6/wgYIZyL6r2Fq6lBZEleHvJM5Z6zct56Cl0/KpY77xMgljZnCKHsyajlPmzLIX+afDFsKfZyh3ehtfOwB5hhcwV4xu2tyoiCnRu9zTdC/ThpbMsVG7zY82+Qv5J5ar5peMDtt4M8cePIuglDbsCQZ+uJ5/M033i/qH0DRkPXY46gHE1S5CJgeAjLjLNN4y3FgEYranR7ntUOK9y51oqlHBYO2PpkTFzdZBikUt+I7djFIKwQ/P+ouPC3u6+5xk6TyNAptncjY4bkBiNkYvpHyjdywgJkc5nDgCnT59GeD6LFRxRI9xCsPJK6VMjmkApcGrPbZa5/EBgvZ9rkef8uMnWhiCfHpDFvbtNmZxFREDtxLhTihkbGPhh4d64mroY7UEIDiWLVSX/UuZgf+lVj9AY7IREhDzD6hDToJsmf3ecyqIyw3l5aHtmaKWUQkNcpEo2TQGyDTiOnLrudHtR9bH4208Q/diczB6EyzOUcRv1KiQJnTd4G1l/TJ1/jCU8nDfIVAxzlbgkmtChaGftzOE/MpNTu6ar+q5Lokm8hTd82DDv45IyzcnIWh4mcRO3Y4FZFaapYxweFfz/YFmOyCpZ+D1g5ZZZihCQ7qpM9YjlPawVDNX6/+Os6thssCnastvAI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(18002099003)(921020)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHVSU1dSUjZqYnJLNXRHNkFuOEVJclVST0FIbWFqRGRNWGJDR25jeHhVUFRB?=
 =?utf-8?B?dlhtYTNZaUk0T3RpSzlmSTBjcTdlTjErTTJ5S2VjbzdHS1kvNTk5WjR4b08y?=
 =?utf-8?B?NEswaEhGdFNaQ2FRT0g2Ty9ySTdIbGZjY2daV1l3Ry95ajlESzNpOWxuVHNI?=
 =?utf-8?B?bWZxWDZ6MHd4N1Y1aHVnd2sxd1kwNm0xU0JlZnlWYm5yU0NndHdHdkR0TU96?=
 =?utf-8?B?UlRxbDJwZzVRMUlpU25ETHA1TElEek1ESjlhR0FGM0dITHJXVmNhcWJFdXl4?=
 =?utf-8?B?WmI5bU1wZlNpRHFMRFUvMjhjbG1aenY0VjZIZzR4Q2hPUkJndGRoTlRHY2NJ?=
 =?utf-8?B?WkFLdVYzRndmYTgwTUI0aGpCSTY5SnNFUnBsc1BteWU3SGZKUUh6NzdWaWE5?=
 =?utf-8?B?QThxOVRCd1BVby9NRGlMOGdFdTdnWFZtQVJwTWxOSnhMekdwS0NRdG9YR1gy?=
 =?utf-8?B?MmpzdEdUZW4wYmxVc0xpVm94NW80bkRlZEovMWZCanUvQjZobk5GazB3ODJq?=
 =?utf-8?B?YVFOR0loTnV3dnc5TG9leEJXRy9LZHBKaEMrdGpFdUJvdTZPMDZYNkw0U3JZ?=
 =?utf-8?B?WnlQbTVBTU83R0NieUZPM0VIZ1RaZ1RzU0dORmswWHFFdktWTVgwNGhPRFRI?=
 =?utf-8?B?ZVhXNDlUQ3hEdUdZdWZxWlBKVEJZaVhhYzBOelJyT1M3aFVRREpHYytOL2FT?=
 =?utf-8?B?TXJGS0RoODlnbHZRU1lvZjhIRE9iYjVOMkhrWkpuRHN3WWgzL2dhL2E2WXh3?=
 =?utf-8?B?K3ordzRhZEFSWmZnZXFmZVdUNFV0UEQ2Sk16aFllRVV5ekYzWkp0ZlNwME5z?=
 =?utf-8?B?Ky9QMDNGQVpzZm9ycTJGcnFvZlBGSVBKS0orRS85c0lWMDgyM2p5UEtzVTFU?=
 =?utf-8?B?cTdVTzA2ZHZLbm9lMEh6b05RWUl0NTFnTzN3LzFRVWNxTUROUURDSXVMRlRT?=
 =?utf-8?B?RHBhVHA0VkpGRG90MHZqOUZaY01RU25YbGt2YzBRdkJCLzZwVkFPcGNyYWEz?=
 =?utf-8?B?Z0NqNTlZOHJBOXpXcjBOaDZUKzVuYWs2OXVBNlZJU1kzNlVDbStIZW5ZMmhw?=
 =?utf-8?B?M0lMRDh3WHdRZnlhUDVJNWUyU21tWU1MeEdQa3BRMXpUMnVjUzkzeWtQQTY4?=
 =?utf-8?B?QWw2ak11WEdvdklFZS8yaXlTeW80TFJBeVZHSHVEbnJQRUhESG5WNmJac0lG?=
 =?utf-8?B?U2hHU0ROOVhUVHhXVDJQbmFGNmpmUWJncFdBYzE4ZTVPaVRqK3NyQjRac3ZK?=
 =?utf-8?B?ZzBab25BRk4xZzhOZ1RoakJxSkJhNE0wdHFOREpmOWV5RUVCMVZvcG1sQTFS?=
 =?utf-8?B?aXB0Z1hpMjdjZkpCYW9xMTBMUmZXVDNibXl6eTBnaXVoSExoeHVIeEVYNEZ6?=
 =?utf-8?B?UGlhYTExbEk1UnBYbTJDREhMNGpmWkVuejVUSkxvR3pyVnJpTTd4TU11WDhp?=
 =?utf-8?B?djVlMnVUZ0xNREFQM0VYZHpMaUxvMWNoQ05hcW9FNU5RMzlrekJ5dHppUVI2?=
 =?utf-8?B?V0pNS3NEL05WYTd0emgrczVkMkZtZ1k2dUNNajc4VTlqc045QlE1cWU4UHhR?=
 =?utf-8?B?Z2tMa1lWWEpQM3ZoVys1OWg4Y0hKYTgycWtGa3NjOG15QXg0dk91TlNxaHZO?=
 =?utf-8?B?U3UxRDVWUkNQcGJKcUYydHNvQWtWZDFObDVyZit3bHRaRmlYM1hQb1BEOXkx?=
 =?utf-8?B?T1h1cDlrb1RHUG10MCs1dFBnbUkrVmZoM0pZazNLRnpxZzc2Y0o1QUsrblRF?=
 =?utf-8?B?L2lXNFZ5cmdzc1dRMU5PUk5qRnpqaml2SHBEOVhsc3FKOC9KRXhHUjFlOUpF?=
 =?utf-8?B?KzVVU0pSQVdlcE0vTy9pdTliNDBMRjFkbXExNm5XN3YyTkxTMTNENzlCKzQ2?=
 =?utf-8?B?bjRDYmk3RHdWV0sxOXhmS1gzdmQxNFRVWE5wVmNEeU5GWVR5OFpSQ2xSdU95?=
 =?utf-8?B?MHg4Nk5RVVBrcWMvV0pBU0lKUmlpVDNGRndVVXpaUTRUVXNPeDl4REhhazF5?=
 =?utf-8?B?YUtNUnczZ0FEYXFQVXBScEszZFc1bFl6T3d6cEdiNTFldDdlWkFoZ01qU1Yz?=
 =?utf-8?B?R25iRFVBL2xBUW5UVHJwcGprdXRIaXoxclBRTDZCY1JwOEZuR29lREtXaFBk?=
 =?utf-8?B?aGZQU2FuT3B2R01DY0tkUG1ScUFtcUI0Kys4bFQ5U3RrMFMvWWVBUVZTaVd5?=
 =?utf-8?B?a3RrL0Y4akdUWUZUd0cyQVBrWDF4WDJwK29aT0p0N3dncXN2VlRtaXpuRHNC?=
 =?utf-8?B?cGM3OFpUeis5K1M4cUl2SUw3NlM3UjB2TFQxNnlaRWwvZ21BMDg1d1U3dVZK?=
 =?utf-8?B?MHdJVEhWcWlydzF4R0JRczdpL3RoNXJvQmlEckFmSHpCQ1pOYnFiZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2988478e-bce6-4799-5aff-08dec0b1c138
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:01.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjCjk8uDKmfoqazz7uz5R6T/tjFBur8tleNj4vCun0VOarcIKpxsMLEDP7Ks8VcSJ3XQCZx1AOhXW0nqU4TfDg==
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

This series reworks the index projection syntax in the pointer
projection infrastructure to use the keyworded syntax to be more explicit.

Doing this allows adding a new panicking variant of index projection,
just like the normal index operator. This is useful for cases where
compiler cannot prove (or cannot reliably prove) access is inbounds.

The new syntax looks like this:
- `[try: index]`: Fallible indexing (replaces `[index]?`).
- `[build: index]`: Build-time checked indexing (replaces `[index]`).
- `[panic: index]`: Runtime panicking indexing (newly added).

DMA sample driver and nova core is updated.

Danilo, we previously discussed merging this series with I/O projection for
patch logistics. However, I'll need more time for next version of I/O
projection (implementing view types that have original container type
erased) which won't make it this cycle. This new version for projection
syntax rework is minor changes only comparde to v1, so I think it's worth
sending out so it can still land this cycle and get out of the way.

---
Changes in v2:
- Fix missing colon in documentation (Alice)
- Reworded safety comment (Andreas)
- Convert `unwrap_or_else` to match (Alice)
- Split rename of `index` to `build_index` to a separate patch (Alex)
- Dropped nova cmdq refactor as this will be better served in the I/O
  projection series.
- Link to v1: https://patch.msgid.link/20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net

To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org

---
Gary Guo (6):
      rust: ptr: rename `ProjectIndex::index` to `build_index`
      rust: ptr: use `match` instead of `unwrap_or_else` for `build_index`
      rust: ptr: add panicking index projection variant
      rust: dma: update to keyworded index projection syntax
      gpu: nova-core: convert to keyworded projection syntax
      rust: ptr: remove implicit index projection syntax

 drivers/gpu/nova-core/gsp/cmdq.rs |  6 +--
 rust/kernel/dma.rs                | 15 +++---
 rust/kernel/ptr/projection.rs     | 97 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs          | 12 ++---
 4 files changed, 93 insertions(+), 37 deletions(-)
---
base-commit: 46def663dd34da36464ba059f7cfeacf29d98e5e
change-id: 20260415-projection-syntax-rework-b790a305bc52

Best regards,
--  
Gary Guo <gary@garyguo.net>

