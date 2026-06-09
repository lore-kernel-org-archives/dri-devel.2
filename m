Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6074CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8DC10E415;
	Tue,  9 Jun 2026 15:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="uEbHrJAz";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021138.outbound.protection.outlook.com [52.101.95.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC0710E3F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t51RIwcSmoUyYid77iHAAfp/aUlReE7TLtLPg5TGZ9dYE1xAlRSbb4p+OocoDGkljhtd5zQyLOLqMCRsSGEuD9sOh15yjhqRZhfGRl0GHw72N3Y1hLYlqT8IFggBrbgan+FRggKVw6Jga5FIuwyYZ9GKonJFC9CZu2N8xZFLJfyMLb+eKIUxnLa3F21A+rhF9aeU1xrBKCiBDhtPpHy/7wmorgBWUMUdwZgdmKZleqUc246E7pYg7Q2BpGaGNDGc8sEw0GXJ3TWAJQnLEiI3A20xiyf3gDoFu2pvsx+N5QQ22JNec/ZncIiJ/lHwvde+akc/Rlde6rwNXbs7rVFDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs11+9v20TCLsH9iPRgwrmDC7+Bsj4F642mYa4OEs1Y=;
 b=sWAvG+uuN6H1tZcpg0aMuQkt36/A/eneCggidn1AB+RXV7i9+cQj2YHQ9/0hcsxkSGi9HWboNIJjaX1ORj65AsIxZgZVBGKVhCL/M8RoHu5cL1jnh6DUD6MC1JI1eeOyu3i1HcQ75F3vSGJe5eftbem11MqISEZaVxjFL7kVUrW2tUhW9sYx+XzHvN1a75h4QOAR72oWVatJNdtSE1mj41CRY4kf8PGsk+RVrVj+Z+0sBgvY1xcCrXmsqn8PeWWDEt/znUw51ISXoP94lNz0mQ+7MtP3DLUm9vlr5eeHVj/B/NNPbSx5ocWxvbs6AijaH0sf79yWMzzmOufQarlUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs11+9v20TCLsH9iPRgwrmDC7+Bsj4F642mYa4OEs1Y=;
 b=uEbHrJAzC/R/mnLdWN+yP6kaI5HODIgxevB5RYNj2KgkmVHILIT3mmZZGqfz/qJCgTS0C5u6/Nt8uhswJado+lqo6SgkNTRRFEVK+SEI/p40VYAzIyVZjF299Fx06Ycl3yQTOfU+P3jQ6btWG47vaN5u2oh2mQi/U9txysyfpgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:38:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:38:58 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 09 Jun 2026 16:38:37 +0100
Subject: [PATCH v2 1/4] rust: sync: add helpers for mb, dma_mb and friends
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rust-barrier-v2-1-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
In-Reply-To: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, Alan Stern <stern@rowland.harvard.edu>, 
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
 Luc Maranget <luc.maranget@inria.fr>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 lkmm@lists.linux.dev, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781019537; l=956;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=hxkwhVK5ToqxSCTusoVQ3qd9f1d4OmS/kjHIq5ZEPwU=;
 b=/vdsgPDVUL2v7ElWLurH28PEOGcuSP3l+PO2A9HIlW9mW5n5GmdKMdwW0V3A6kJGi/769oIP8
 3pljt/8rDGCDkYbAiNBdR45w2Cmgc/WxjZK2r85zng4yOeNXzY1M6/+
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eecfc0-3077-4be0-58b4-08dec63d3902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fwTgSu9in0NCj6gPUmTfHam5VQNce9YQ+vlFQS2lbNm387VkkoPvSP4ctrRDOp5iKCd12rj7hOqjXX0imV+jfvC7E98KYj7t9J3/Y9tO6CBv/4Sfayd+bQfTMNGj9Vm50gY0HhvxvFRRGY9P9noiGHSFcxE1i+n61P+D8Li4YEqjQ+YOiDhVhw3HyGrfo8zJuUuMd3FXeAFbSPevLtTviM7BoCmLRSTFgLbshoFeZ1UjqX3bKs7rY77UtdRFbwPvDJtZyvnfFXy9sLu6sNTwfYXpzLGJefeymK71pQRXU8k11WoTc/ixhrLehqWh+wLkK+8lnkmFU3t5u5U9+5b/x3lp/5jckRi5B5oBaf+4ZoSzcIWBRCB4JxC0WH3gknpL4mQePoNyZ7vMT3R21fbWynN5VCSbCrSsK7wcGctIjeJQttoT7xT+QMqIRPeFRF+h8IHBb+4UhS2hb3vRl8oWg5IXw77/gNmrZith5hQEctH5hxAyNaphXs53nAb84VRJFKgszV6JLZNSVNqPj2CToYVP/PUkwHklwEEKruPTtoNjJ6nNyzPDWzjeujZMj7LN9lX5SP0n43/L0wwKQwXnCSR5BRlWQO6tDEG1E2yUV/cKhUrBCHZHu8NbCI5ROJVtCYUngs3dHH8u9LJcXQZrkIztPWppCz030ZTMQ+zhdGu1gGF9O+XecMkerwJfNBbAadDtl6kqlPzEu0DJl2MxYynkOiv36Gk2HNpq9bsLrgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZNL3ZvMklDSG9xNWtwMVNrdmVvZGtQR3FNazlzUGhQN0VKYWp4dG5hbHpj?=
 =?utf-8?B?YUZ0WEJUR21PeVVxcE8vRVhKdEpMM2Jna1UxdEdyVGhsQTVBTzFLenVIVU5j?=
 =?utf-8?B?TTljbExOMTVpQnBXMzlHVDhiQmpkS3dqS3VlaDNsbnNDMWpOZENzUk8vTHFK?=
 =?utf-8?B?ckNkWTM4V2V1WSt3Zlc2SDZydjZqRXgvKzVZT3VGdUErY01FbXk4Yjczc1Fk?=
 =?utf-8?B?UVM0My9Eamd0cmg4R01IVFEvaDdvdEsxTUkreHhwNjM3V2x2RGgrNnFhWU5l?=
 =?utf-8?B?Q2ZvZEVhZHhxU05STzRpQ2RMSWdsUXRuRW12ckVEcStZUHp6clhrUlVpNUhD?=
 =?utf-8?B?Q2h3Zm1qQy9NUnRYVkpaamRoQjBnZEhEUTRMaTN1VVZlY3hBSHZISXdvNTIx?=
 =?utf-8?B?dWV4ZC9VR0xpRk1iZXZSU04zblE2R1d1VCs3YnBUNml3aHA1ellHWDhRUlNL?=
 =?utf-8?B?cUpCY2hNVlkwdGlTOVlaNzI1SlVaQ3dMU0hDbG9aZ1RBdVhHdTFGTS9ycitz?=
 =?utf-8?B?amlaWStpWWtTNkNwamhNbUhkWWZYYkdxYU05eGRTV0JuTmdORkVObkFzZ0Rl?=
 =?utf-8?B?L1BiU0w0a0hnMml5cXpCdWF4TGhFeTlTU3M1aFNEejI1S0YrQkZQZEZ2VXQz?=
 =?utf-8?B?bWVuQkIwWjBZcm9BWTZKaG1aaUlHRythYTN3SmUxL21lMkxzSFJodWdLRzlu?=
 =?utf-8?B?L2xPNllPUjhCS1RjQWpJWDRmNWdLVjVmMGNMYjhNbHdLUTh2MVJkUnUzYlNp?=
 =?utf-8?B?VDNrZStqTUhpamlwcGdENzArS3lKZ3BvMDl6cmpMMGF1eTZ3NDY0RXZEQlJE?=
 =?utf-8?B?WVprL25HWDNWdjdTMG5xaVQ5V2NpNW4xWDR3THYwcDRPT0ZyTzYrNDN0Yjls?=
 =?utf-8?B?WGxNQnYrS09XQTdaTDRiSGNYU2V6azhwcHM5RXkwL1ppYVRBb1YwclFBVXc5?=
 =?utf-8?B?VnR2YjlRNUVMTEc0bmVvcVhqeU9iZy9wV1QzNzhWY1NiWDB1S29lUVRZeDNn?=
 =?utf-8?B?Qy9UMktiQnFCYk1CaW51eXhNWEN6cHNBTGxOLzhOU3ZwWXFNL1BPVENUOVVu?=
 =?utf-8?B?Q0JHWnhpaGlydGhEUFJOUlM3MCt1aTk5VHVscldka0d5WWNtc0RLaEUxVjRH?=
 =?utf-8?B?UDQ0Q2d5Z1RiemRUMU9rK2xrM0lQd3R3Y0JOY2dUb0FKcHNqbWRYSWtqNnk4?=
 =?utf-8?B?Q1NlYnNESVU4Qjh2cjRXM25jZGY2aHhTbStmelB3M1ZSMGxyTnI5RDAwbm16?=
 =?utf-8?B?RnlQbVJXL1NrR1BTUzZhQUJBOXA5UjBNSDczWU1mVWZHQUNxenEvaHozQ2U0?=
 =?utf-8?B?cmJnVkRJak90SDltcDZCN09JcjhFRTA3ZHhxaFJqOFR4SWtjdnRib3F0U0U0?=
 =?utf-8?B?dElSS3VlOVNKeHFvcWQwY0FvRE16d3g4ejg4TXlPM3p0bGxqVVRZOHBManhE?=
 =?utf-8?B?dzIxakhhT3J6QjFzV3VyZUNXa3hMOURUZHgyRmZzTGJWZEl6TWdnMnJGbjU4?=
 =?utf-8?B?Qll1U2xsWncxQ3ZTYzV0bkhpSE5TNEIxc1BRak9IcmhHM0RaNzJ5dlRrcjNH?=
 =?utf-8?B?WFNBU0grUFFhQ0pWZWMwTHYvMVRmbytuV1BwREFkWE1XakV0aXpPdmtHeE95?=
 =?utf-8?B?S2FHa1pPUWc2OVFoMGZxRzliODJjNG1rZWhScGxXTDkwVFNmWnlkWUgyekF4?=
 =?utf-8?B?RU1WMTJYRHo5c0RmcUpKRlB3QklidkhVZmVkR3FPMDZpeXEyV2kvSVFqTmtM?=
 =?utf-8?B?RDV5SU13V1hiMzYzNFFYS3dxK040aHpjWHh0VTVCTGNHdmlJUHNRemp6TFpi?=
 =?utf-8?B?c2FkLzZKcTVtK05rWEFyRlg1cjd3RmpkMklnVFQxQjhFMk94ZTB3TDlVN2VN?=
 =?utf-8?B?Y3FwL1plSTlQZzV5U2docEN5dXZnaEJIVDZkaE5SUDU5QzRCaWZ3d2k1NFlR?=
 =?utf-8?B?U1Btc0xValFnVjdjOUUyRlhGL0FlVHFYT043U3JicHdyY09HYVR2REJrd1ZH?=
 =?utf-8?B?eU95K2JYQ0F2OTlUTDFlbXRTZytJbHpiZzJLbnBmS2FpRDZhYjllbGFWa2xU?=
 =?utf-8?B?VmtLNllzQ1dxdDBIRFZONy9kczhBL2xxdWJka3p3QWxvaythLzVmbDlhSkR5?=
 =?utf-8?B?MTZQQ1FiWDJZbWV2NGNSai8vcEVsbzdpV1hrY2FEb1BaWThDUlorbHRvL2w2?=
 =?utf-8?B?M3dOdjlIdFl2UU9CUzNBZVlEOVFGaEFJY2FiWTlTK0NjSmJkVGpWWXB4bm1h?=
 =?utf-8?B?RWtjKzV2V0xQZW8zZHZWTG5aVDJZalBPN01kMlVTRGYyTmJpdEdiZ1B3VDhI?=
 =?utf-8?B?YTkwVGw0K3Q0eDIyRi96N0J3TVZ4WlBVYy81LzBwcHpYS2tlUWQvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eecfc0-3077-4be0-58b4-08dec63d3902
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:38:58.5604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nBd3EaAq+zjZFc90Ohzhqssv1ooa6rqiAk0n8GiLN5nLQyM2B34kGXOpaNTmjtletQH/nN5KUlht+RDmrkltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6167
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

They supplement the existing smp_mb, smp_rmb and smp_wmb.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/barrier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
index fed8853745c8..dbc7a3017c78 100644
--- a/rust/helpers/barrier.c
+++ b/rust/helpers/barrier.c
@@ -2,6 +2,36 @@
 
 #include <asm/barrier.h>
 
+__rust_helper void rust_helper_mb(void)
+{
+	mb();
+}
+
+__rust_helper void rust_helper_rmb(void)
+{
+	rmb();
+}
+
+__rust_helper void rust_helper_wmb(void)
+{
+	wmb();
+}
+
+__rust_helper void rust_helper_dma_mb(void)
+{
+	dma_mb();
+}
+
+__rust_helper void rust_helper_dma_rmb(void)
+{
+	dma_rmb();
+}
+
+__rust_helper void rust_helper_dma_wmb(void)
+{
+	dma_wmb();
+}
+
 __rust_helper void rust_helper_smp_mb(void)
 {
 	smp_mb();

-- 
2.54.0

