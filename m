Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D72C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF00C10E1F8;
	Tue,  1 Sep 2026 20:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Gwv/dvHt";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022079.outbound.protection.outlook.com [52.101.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDB710E1F8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ/qrxTuIM6tHyQpPGma9w5I6XD+MwOCY6MZ3Ol+IViRsuH4FIJ6CvgcnVRWxfymor8SD20LCZyhdWr3NadjJYWC2BFgvsTqYxhxXMBGxgrEo31kcJy0bUdzQADDAt1/XM6NRXReh4h1xRnqmgwo4lkOaXUpGnl0JAhZ34vXVQThTLVvrkKs5uxP7BR3OCkPhz71TfpPldQJPeFIlr3kMR2rixOi9cLBuGIOp9bARTwf8ao0td9+pu6uNxlmvwqJXmknEWiNx9v4trGp30CyWwSlYpl7QZocDQQBAesHhdUQelEiQQv1G4NP1bdtGx9fjuyEWXU9MIZQ5lT6SI9xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsvlVDFUdJYwvMgMfdTdIdxFrUrLrMHmdQZtAPaxbHw=;
 b=JpVHqegtL6ic8f2F+UxyGhR9XngLS+Wb6AukoyWqjAtVrxQ3MMstmZ2aMxHtYVJjvR+wg0/XLflZkdCHgOUQL68UkjSa3LiCthdUrWw6UTtRHJ3/50Qy+4sk4Ahd4oV1N2ke1QHopHkEUiXwH345fI6TaBvyFGBb18mPALcnaJEDRMGp8g09m40QGqsgItjY2rdMSuWhwp1gFAk59fWrWAzuzaZ2oqRdNN1pXTgbKsOC31GGCWuWp8MTFCTLoG+oOWRHy01gkLucBb3ThLnxGIqyfwr95o5ALUQUAmZlqmJQCWklWPam196Wgo0pQbroHEqEGthnoE9eMtHbdz4e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsvlVDFUdJYwvMgMfdTdIdxFrUrLrMHmdQZtAPaxbHw=;
 b=Gwv/dvHtpKyaep5YiQN9zhePT6vczCo1SQf3Apbxmilewn20vNM6YS5t6FhGBnU+gYSEld6HxHA2KNbko1F57ld6TkKjAj9bGU5/+ju7QehMCQPKkf60YBn4Pta3fx8LhJVq4ZeoTVLfWckyvq+qMp/vlTDJpCj/Q73Gw1Aep5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB2624.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:146::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:59:42 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:59:42 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v4 0/2] gpu: nova: fix incorrect GSP barrier usage
Date: Tue, 01 Sep 2026 21:59:31 +0100
Message-Id: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALM8l2oC/2WOy26DMBBFfyXyukP9wpCu8h9VF7aZgNvEVGODi
 CL+vTgsorbLO7rn3LmzhBQwsbfDnRHOIYUxbkG/HJgfbOwRQrdlJrk03PAj0JQyOEsbRWAUb1q
 0jZHCsA35JjyH5aF7/9hzmtwn+lwcpeFsQnBkox/K6RLitEDEJb9ebcpIpTOElEe6PX6aRXHt8
 5pLUUutVSV4fTRKg4Te0u30hRTxUo3Us7I6yyfz7+VZAgfFz97rFoXv+Kko+mmsIuYdV0+8FX9
 xteFd7RrXNWiM1L/xdV1/AGLWCZhTAQAA
X-Change-ID: 20260609-rust-barrier-63078ea76216
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788296382; l=2084;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=io0ZKK+rnZdyI/30pLtmX3v8r1ge2YBcKOM6o/CP9Yo=;
 b=cyPfpf/9Uzj9HDOALiI39DuW3VH8No7/42tbDhjqUdb5mFnR+HMnj1vxXdVUENiqCYU/hnj8u
 LRerm7qGUWnA2TwCS2X228VZFh9n0/SNjWhlEfLxQC8MLzmsWerTtkq
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB2624:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b9e96d-adbd-4ffd-2c1d-08df086bf20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: fm75aIXnlWOvsdSrFxuSzEQTIRZHuusH3AjPkpyb6cZ1vOta9NpP7cNlS6nxFBchXPdYd3MCwbDLC3B7t3lZz6E3Cu6sHDqJCfHFLiIQxgt2zicqXjEVtJGZDqMeAIwjlgPeedTwV1F/lv0dzBLCKSDuRVgRAcrk2kBamjF0/6Pg0kQe9hXYs9P7ztRjenOakM8bqYKap9OUb5CBHfEJrgPn2V15cAO+qoK16rWaie9EkjB5qYuOxHm/glCKSVZz/fGeM4HX6GQiay1I1U+4+OMDuNnlNS15/s9luerPOvUA0TaGlXZw4kDCrn2sLxRi09aiG23d8vjdOmuJaQyEHQAJB0LtPYKAj7IqU9esFQC7oWeYjEH+U7clG6cknahXU5jwftM04dkfdg4AVi+bmMXGrlh0Dj+GIHby9pJOFSeRtH/ZWjNl/5hFrZhqF3CGwv/iBcrq4LiqBhhT6Evl+GmBaBmy2vS+YnOpS99UADqP5hV6Glls0NEu2n+eXTz7JnPk/o3VIc65kdiKm7DuIFKkKb8mhBtPLKxJ+W8QB7a39FQPlR56Et9VzfnpzZbt1tLwN3S0W/NAOo0jPy5ClYlj7lxj4JI6Nn0GD79XETlvlFTf3K8XUodgDmq4LFBh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BSRElQYjdBRWxZeXJ5WGdsRElNTUZLSW1wWC90QUFiVncwcHNaRjc1ZzJm?=
 =?utf-8?B?UzRkTnVUUkplOW5GdFY4dmF5blZQU1l3a3VtRjlaMXRLcHZxcU82UXdIRjZZ?=
 =?utf-8?B?dUJHMUY5MlpKdkpPck8yeVJadlpKcCtzVTVWMVdrdkx0VXNtOVl4cTRqU2hH?=
 =?utf-8?B?V0I0blVBeU10dUQ4WUlBTjdSanN5YlFYMVpFRXdTSEpHOU0za1NyMHMyZUwx?=
 =?utf-8?B?YndoZFdEQWRnOUNyZzBHTGVkMEdTUTVrVVEwZXpjeGp4WmxuZmp0U3lpWU5o?=
 =?utf-8?B?ZHF5WWlGQlIyZ0hseVlCYTJBMi93RUdQN2lzR0pQUG1sM1dmaWRvQi9KQVgx?=
 =?utf-8?B?SzBOWjhPcWd4ZFRrYm51b2o4S3pXMGdKdkpubXZuK0JJWmFCVnd1Z2Y0RXFU?=
 =?utf-8?B?Skt3MTlHTmhHM242Z1BBNENMQTRBY2F0SHNqWFArUS8vSDNNN0UvM2xWTmxW?=
 =?utf-8?B?SjRGY2FYQk83MGVmbXFZSlU4aVpWWCtrdFJjdVBRTEVzaTEyMFNucmk1V3Y5?=
 =?utf-8?B?MGtJelNqWnFYNmI4RkZmTWNiZndpUm1tQmtvYWF4YzdLUnNmODdlYVRKb1Bu?=
 =?utf-8?B?OU9ack9KNjZkK1kzWTkzZnQ4eGJqNS94UmQ5VWROVy9UalhuMXlUbHlBT29w?=
 =?utf-8?B?VzQvUTJlNnpLUk5hN0tqbm03eUFSU3U3Q0Y2U01hdWZLNTF0OFhpd1JFRVFE?=
 =?utf-8?B?SmJzSDNXV1NwRTdFWUQrTnhNanRmbFF5MXRWN1VELzlEdW1nV21vTTVHWFVQ?=
 =?utf-8?B?ck05MjRzMHYxQXN6aDJTSExmZEhObWphcjdNNDNBcTVTSDZ3U1FtTHRiZnJ1?=
 =?utf-8?B?bS9zNVdHYnlORkpPNHZEbnhXU09qcUFGaEFacGt2OWQzN2NDR2tTMG50UTFR?=
 =?utf-8?B?UE9XbFUzL2pXa0hLZ0Z2a2k2UFUxK0VvSkxiMUhHb1pxclc2L2ZiN3BjekpB?=
 =?utf-8?B?ZXRndWNTNXNYTUZRbkRrUGM5cm5Ka2dFN0tvNDJTa2ROQWFQZWNjNHp3dHdU?=
 =?utf-8?B?TTVNOUlTTVhwcmFhTmhWK1VveFdudHpJYlFLZzY0TW1mWnAxR3lNYS9RNEpO?=
 =?utf-8?B?SWx3RkVaL25rT2dVUDR1TmQ2d1NFMDdHRUhtV1pwMlJnUmVYaHVJM1VHVTFQ?=
 =?utf-8?B?OWhvbVNoZnI1czQ2UHNaYlZSTFAvUVZKT2swelRmTnZEWG1ZNW5XcHpxVFFC?=
 =?utf-8?B?dDk3dUVtdVBnVGdBUnJkNkN5TXprNXRZTi9JRnRobm1lKytyYnV0WnFMQ1hx?=
 =?utf-8?B?OWhzZ3VVSEcyanpYa2MybnlQMDVCUzA2aUNabmRuclBUNk5CZGdFV2ptUE82?=
 =?utf-8?B?dnQxR3dIWU4zeGNwcGQ5cGw3ZEtmUkNQOWR5OWlIM2hVcmRCVEU1VnlTQS91?=
 =?utf-8?B?OTBPSEVCdHlqdS9IYXFMamJNYXdmRTNWRTlaUTlTNFlGamhGVkhieUxiN2VY?=
 =?utf-8?B?RTMwNXVtNlRWbGhiT0JSQzNSTmIxZ1RTUFBoM1ROc2NBdG5tZngwNkV1K3ZG?=
 =?utf-8?B?MWNaYUdkc2M2WE54NDlLMmJYR2dzMmI5M3dDSFlJb2p6SWJkNjJLVXNQU2Ry?=
 =?utf-8?B?UGxNKzh0cExNS3lDYWhhQk1kT0NxRnAzdXB2RXh0WHE0R1hGcFZTNXRoeW9F?=
 =?utf-8?B?Q0JpZjhVdG1Hb1ZBOTY4VWZ6V3hCZklFU0hodFN6Z1ZXSWVXYUdVOS91Q1NL?=
 =?utf-8?B?cjFLcDhuNGY4WmhPMWhTZ2NyOWZMSmZZYUI3WWtpRDh2VWREbFE2SDByd3RR?=
 =?utf-8?B?Tlp6ZGEvMjA4TWhVTFE0Mmh4YnFFcEluZE5Tb0tBTEJYN2EycXNmeFZ2NHVt?=
 =?utf-8?B?ZUNNSW9EM3Jqbm5Fb0pGZEtQMVRlSVFOMzk3b2N6OGw0L29CekpRLzdmZE1l?=
 =?utf-8?B?MEgrZ0IvbGlOdkxGL0NwUWk1cjNOQnBxTkNCRFF6N2hDQkkzUVZKU0pXbjJ6?=
 =?utf-8?B?QVIvRmFMOHdlalZyR3RVUEtVKzkra0JRc21iaFlJa0pYaVhYMUsxblpLZm9u?=
 =?utf-8?B?SHhJSUVWYTJQWnF2TjV5b2k2aDd4bUUwUTlrYkNLMmNoaFdpYXFOK3hqTmF6?=
 =?utf-8?B?YWRKbG1ZVWtwT1F6SjdPL0pCTzJ4YjNucFhHOUc0eU01NU9QRzh1eFdFL0V5?=
 =?utf-8?B?RHRQRnROK3NmbFEram1nNU12UGRTQlI0SjN3TkIzWGRJc0tJT0RHcXRXOUxs?=
 =?utf-8?B?VmpHYVdrNldwZTFCNDFBWXFxRXQweWZ2QXd1a3NkRjVxckJkYXYwcmRLMGR5?=
 =?utf-8?B?V0s2ZjdKa2kxVXBZQUxMS2xiUm5CNUZLblgvWnN6bjZkaGxXWmRqdVltNGFQ?=
 =?utf-8?B?V3dGNnhVd2RLQVh1Wm5KODU3cEVYcTAyaXhRRzV0MnZvSHo2aG54dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b9e96d-adbd-4ffd-2c1d-08df086bf20b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:59:42.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpFlDM9ygammHR6nagn/pLBFwNsGaaT9AmJIHTSOCJBvudJuKsDCzJUz3vqaKkiVxCEZvHFpgBc9JzUwqRFD7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2624
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

Currently Nova GSP code uses Rust barriers, which equivalent to LKMM SMP
barriers. This does not provide sufficient ordering for DMA operations on
AArch64. Fix this to be using the newly introduced `dma_mb(Ordering)` API.

Also, there is an incorrect placement of barrier, which is also fixed.

---
Changes in v4:
- Moved barriers to pointer accessor/updater. This does mean unnecessary
  barrier in failed polling path but the code path is not critical.
  I mentioned about providing full acq/rel semantics, but ended up not
  doing it because LOAD->LOAD barrier is sufficient for the GSP->CPU
  messaging path, so it's best to still mention about the actually needed
  ordering only.
- Link to v3: https://patch.msgid.link/20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net

Changes in v3:
- Drop abstraction changes which are already picked.
- Improve ordering comment messages.
- Replace control dependency reliance with explicit barrier.
- Link to v2: https://patch.msgid.link/20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net

Changes in v2:
- Dropped `Acquire` and `Release` aliases of `Full` (Joel)
- Use macros to implement most `MemoryBarrier`
- Split Nova change to GSP->CPU commit and CPU->GSP commit (Joel)
- Link to v1: https://patch.msgid.link/20260402152443.1059634-2-gary@kernel.org

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Gary Guo (2):
      gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      gpu: nova-core: fix barrier usage in GSP->CPU messaging path

 drivers/gpu/nova-core/gsp/cmdq.rs | 41 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)
---
base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
change-id: 20260609-rust-barrier-63078ea76216

Best regards,
--  
Gary Guo <gary@garyguo.net>

