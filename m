Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1E60A3824
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z/klc9vg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB9410F2B2;
	Tue, 27 Oct 2026 07:36:43 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C1C10F2B2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+qWJ67udRQ8elkSHRRqWfMCO/uEtJkdbDnhbQKptJktvvlMl8+Fvh6o1vmNLkTK+izg4HDO0L1+vriZvsnlU79NLNNzOyG0SPCirkIgkgPQfjzb1jLblAGNEiUr1E7pOl+jWHupww5Ly+4urqevhtrdo2eQT2VkpvXY33FeAIgvLxKl7gtiby4yNqA2dTL//VH3jhk3g40Oyy4ruDK0tbN9vkkMDvXf/NkaCdG2gyfDz6BC+ynFGm7/WdTJ/KiVw5IkGInJInzi0BRCnIHctz4QzJG7hFvh0ej9NZlfE2FMvMSk6z9L+7c2hHlNom2JjedRL+ncHJl7o2h2+YOPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4RZIIOmuxL8f+C53eDlJcIo2qjJpACPX3brADuZDsg=;
 b=kMFbn0+iLa2ObvSK2gfMg5wbhkt9S6OlpU/fo8Beh2cPEqRJS1HBCxwloGBoZIZkKYBDeGuij6WCY8M1LvMu9H8i3zf37v7eJYWRC2ks4UmD8/UIVTgfxnIeTS7Wbggxnv82826R7huUAPdwwj825k2zTT3rnpFohivbsO3D8MuwCPu0XHUglutQc5To5VMGkfUaZXRJjDlzNBj8o/roLEc3xQ0FVId583f22VeKHb7hXyQxm8ECxBjeRA/eG1h0XYsDQ0e8TmZTNKqyuy+5avx2wMuX4Dm7Y6UYALASq0mc/qCcp0ozVgTNt/J0MbD5rmjNbfCWtESEmZL5OXMtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4RZIIOmuxL8f+C53eDlJcIo2qjJpACPX3brADuZDsg=;
 b=Z/klc9vg8QmtudV/cxJmT28KWtmMGvPEiSVgN5En5joxjzdHLQ0/biEJkfVqCYIzh1CP5PKkMMj8ncz5fo2FsWLe0we0ho9av1hXbzJBa0ZahorYJ5F/L1eUZZ0rgGweTUIzw2NzQ2kGzcYhzi/iPeQFB1tRvhoDKKcK/TXTxBMv3r3kKmWc3AZVWc5qb2FVvrjrVKHFzH/gk9Tu0lF9/3i0Z2aO+yP8E+9BxMbItDKtpRbzjV5hee+BPLfdmGENAqkVzvDRtdWg2dy75nsCoUUYzTsZlB7oMfbZHwJaopFN7tvO3wxQgQLGyhPMHVtJ0JfzSPbf3QEKWnoQ2WcbXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:21 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:53 +0900
Subject: [PATCH v6 10/15] gpu: nova-core: gsp: cmdq: extract await_msg_with
 from await_msg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-10-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: f11db9c6-877a-47e9-5a6a-08df33fcfef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|260925021311599003|260925022911599003|261021123027099003|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261021121427099003|10067099003|260925021911599003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: ckIL/TlnLq6oEXDOL6ZGnNmT6+TxJqI/dnEkOo30EivQtH9w9GLlSS+MgcRicjmBpyBr3bd++qEbvHuxOU2+7JkgUpfj12o8HBOBoaikHHzJhxJqlIY4CKkfJhp+izX05BIe0u+ZJINoQiLKBvhLAVee51CLhCFQq0h4101Xst8149LVhH3rUGIQJNNv6WHHJ4Hlca6wz1q8T9ogkAjD8MRS9vkS3EniZT/uKJZwwcHzTg7nSjzjE+IyoRlgjYv4q1pFiQ6nLwkVl8j00Qhf8JWuDlBCE/cjZ56gRgrWbkBYtkCwsRUXq8X5NKfLfP3Mmw2BV6DIFCHnE/JCBuzvPbaK/LglS5PQSaa5j5d7rE4QwEPCw3pg+MEU7ylEXmE9fSBSJSlN2t0TE+W8tTyOfMAMAmamKa8rs+/oINq3KpbmlY03sr6pSaVlwBoLQWalLSI7VUr1VPE79EcroepW4kWqFAMJ2pSDU1t1YCuoaDSr/IteBKDRxpMoSdc72Mn1Eyd+4DCHGY7hTupa6MEIWGYYrZySGRnVF3RGRBp/t6lp63Aa11Tc2+/x2wPCDzZGFcjJLI8mBA7qUKe0uq5ZEL5rDuIIxa0YqmPWrTOmOwonfpmLFQLMDn8EulQHFz4+20MV94AkrcGXVf6qKFsrghwz8T7JYBU41dwWNgPPP0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(260925021311599003)(260925022911599003)(261021123027099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(260925021911599003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5GYmx6WjFPYnVGajl0cm1SSmlMK3RLYjRNVEIwZjk3Yk1lNWd0ZXRpakRk?=
 =?utf-8?B?REF3YU1vSWZrS1Zob1o1bGVLWUExRE5ZaTdGbC9qOEhRZE5ObGV6SFkxZE82?=
 =?utf-8?B?NXRIYUZaNExwWWVBMTA3Q1ZuYmhDWmdlRHgzK3lmb1hiaHNtSmJQQkNLOXll?=
 =?utf-8?B?YlNibGszQ3I1eWZucmNlWGZnZUhrUVlpcDZDRW9PT080aVFMRjJMMFRhdFo1?=
 =?utf-8?B?SDBmcEl0NDlKZXZLenMwWWFYQ21tSWZOQ0ZRNk5rVjROKzRrenk3QUxVcGFq?=
 =?utf-8?B?V25MSEVLbjU1WEFEb0wvMnpwUktzL2xZRUc3QlNCdUhlcTVDeDJEYXk1OHpq?=
 =?utf-8?B?d0h2MTQ5NGJTcFJtOHBBaUlaK29lMHA0bFZ2Q2t4STVOVHhRN0pyemhuTG53?=
 =?utf-8?B?K1JRdWZ3UW0xT2E4TkYxZ2VxSlI2R0FnVGI2bFVlVDZ4MlBJOWxwYlIvclRM?=
 =?utf-8?B?b3FxUkYvb0tiVGY1TGNOSVJYWW5zazVmU2IvVDlLOXY2Zm9Da2M0RzdPNlNt?=
 =?utf-8?B?ZHhtMXpQRXNQdHUrVFFVQmY3OFJvcjcxeVVGOFZZT3VucEs3dlBXaWg5VHZG?=
 =?utf-8?B?L3o4dzU5bW53TzhZbW53NXhTRVJSQnhLWWZOeXp1RFk5Rkh0ODl5KzE4OElU?=
 =?utf-8?B?MVpGUUpEOUxHU1JZdmtqQ0VteHF5dGw5NThhOWZXS2hLK1BnYUd6dU02NFVZ?=
 =?utf-8?B?aitJLzZRMjdhQlhrL01wbS9kWlVnMWhyMjFicFRnaHFxak9FUE9ocTF3OWxX?=
 =?utf-8?B?ZHJMejYreXhHNnl0ZW4wam15NHQvTG1OOTVKbkFIVkxRendsSHE0UUNBRW50?=
 =?utf-8?B?dERaQm04RVQ5RFZWcmd2RnpXRHdXVFoxTWNGR2Zkd0ZMazErczlydDd1NmlZ?=
 =?utf-8?B?NXBxbHFXdjRsVEp0NFlJQVFXelR3dGFidXlTdVZuazgzcURWWjJZWmtpeGFP?=
 =?utf-8?B?UmVOdGROZ3E0d1FHSEVvSUVSNVlDS1lMQWU5MzVPZkNocDVZMXd4dUhxZ051?=
 =?utf-8?B?WXExeWVXVXR1NW8rc21MOUxGWkI4UkI5cVJyUk94aEFraFNKRHZ3OGNUSEVp?=
 =?utf-8?B?YUYrRWd6ZUFGQkdJYmNLVGRiRzIwOWE0N1BwbngxZ21XRGIyQWdNTXo4QWhh?=
 =?utf-8?B?amd5ejd6bk9zcHo2Q1RvY2ZDUmhrUE9sSmpqWi9JeWwvN1JaUXJ6b0FOWFcr?=
 =?utf-8?B?UHd5VTYrR1plSzdnWDNtTzFDazJXeHVUUFFxdzV3SkcvNDJ0MTZvQkd0RytY?=
 =?utf-8?B?MWZHMlVLUjNLMFZKaWJMOTFLenlFb2pmU0NnejFqVzJBMkxVb3hxMWkvRXR4?=
 =?utf-8?B?YVRTck9McVBEd3N5bXlpYWk5SDJnZVdWNmx5ZnQzWUZkVlAxdUljWnVsN3Yx?=
 =?utf-8?B?RllsUGJpUEJ2U0hHeDFVMFVhWkJ1ekJ6R0lxOStFaEk0TktvZVF6ZmwyckNO?=
 =?utf-8?B?MWg3UXNRL3VaVUdVdjZnemNVQVFnSHRJczdkWFltRjZiWERCRFB0WEtCSFRO?=
 =?utf-8?B?bzcyakpZNVRKcmdualhMck5qbFl6L01HR1RpMmdscGFZSTV5clBBUU4rQlZq?=
 =?utf-8?B?aldBN0FLYTNTbXpjNElpK1NVUTdGUndyK0hQdjFWVFpyOEtud3FvVmNxeVVL?=
 =?utf-8?B?TnppVDN2bTFkMFpGMWIzN3pwUElvWlEycDFYczJhSlZiK3A4ZFdQRWg5T2FS?=
 =?utf-8?B?bzBpYWYvMGxJeUtaMFZZWExQR1k0TDJ5K3dtbGRBMllCc09FWlAydDRUUzJq?=
 =?utf-8?B?MCtrUDBPM2lHVnFLclhlQStxTlNWc3VCT0RIQ0ZRUkJDenJuVzdLWWcyUkl2?=
 =?utf-8?B?cTZtSEtacUlUNmtSaEtzU2xMMEJYZWJhaHprdFl6U0VVSnk5bWx4THFPeXl0?=
 =?utf-8?B?K0ZyM1dzYUttN2poZ2xFcXZPZEVGNGVrTlBuUXVQUVJxYnR4Q0pzV01DYUdO?=
 =?utf-8?B?OGliNWJ5WnBDUkR1RWhtOXhjYkhYSFl5MUtzWEdRVDZLc0FVcDVzQzJFd1Fk?=
 =?utf-8?B?NjFVa2NjeUVYd0xOMS85T1doZ2lTS3VBcmxqc3N3TGpuVXcwMmtnL244L1NS?=
 =?utf-8?B?Nk1aRGNHTEg5RUk3T3kvalRXZzl6SkJ0dXVnQlBRY2VUOWphQXpPUVJzeW00?=
 =?utf-8?B?SnlNR290NWN6U3F0K0d5UFF4aDl4VUxZaUxENUd2K0VQbnUrbTVPcENidHRz?=
 =?utf-8?B?Kzc2N0c2K2w5aVNpWk9BbCs4V2pVK2g2cnlqRU9BcFE1UFZYOCtNKzhGTnVn?=
 =?utf-8?B?NTVqcmNySGl4eXVoT0FuTWJiUElpcTZaZHFNbEZzUnhCb0l1dGRUYXkvUzFp?=
 =?utf-8?B?Qm1MTjNPRUF0SnE3V0RVTDdPTUR1azVFTFplUjVoWDFpeUlLaFdwZFErbktV?=
 =?utf-8?Q?N1Tq/kbVhTohJPtFV+sfBkJ/9AGK5WJMjJB4m27Qi/I1s?=
X-MS-Exchange-AntiSpam-MessageData-1: BL37dNyhW8Voxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11db9c6-877a-47e9-5a6a-08df33fcfef6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:21.3494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8TQM0Cq5XukBqRRka3XLJlM0yoT7IoX+XexT2pnDDLsflDYZqbhp5KJ+IrGp2StQ3F7UgqogJUDSBwk7EigAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The logic of `await_msg` is also usable for other kinds of messages that
are not RPC; it will be used to wait for GMC messages as well. Extract
that logic into a new `await_msg_with` method that uses a closure to
decide whether a given message is the one we wait for, and use it in
`await_msg`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 44 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6075868638ec..9e678715c624 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -974,6 +974,36 @@ fn consume_element<R>(
         Ok(res)
     }
 
+    /// Consumes messages from the queue until a message that satisfies `f` is encountered, and
+    /// returns the result of `f`.
+    ///
+    /// The message is waited for up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
+    ///
+    /// `f` is expected to return `Ok` with the result to return to the caller, and `Err(ENOMSG)` to
+    /// signal that the received message was not the one expected (such messages are dropped). Any
+    /// other error returned by `f` is propagated to the caller.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if no message satisfying `f` arrives before the deadline, however many other
+    ///   messages arrive while waiting.
+    /// - `EIO` if a message fails framing or checksum validation.
+    /// - Any error returned by `f` with the exception of `ENOMSG`.
+    fn await_msg_with<R>(&mut self, f: impl Fn(GspParsedMessage<'_>) -> Result<R>) -> Result<R> {
+        let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
+        loop {
+            let remaining = deadline - Instant::<Monotonic>::now();
+            if remaining.is_negative() {
+                break Err(ETIMEDOUT);
+            }
+            match self.consume_element(remaining, &f)? {
+                Ok(m) => break Ok(m),
+                Err(ENOMSG) => continue,
+                Err(e) => break Err(e),
+            }
+        }
+    }
+
     /// Receives a message of type `M`, waiting up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
     ///
     /// Any other message that arrives first is logged as an event and does not extend the
@@ -1016,18 +1046,8 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
                 Err(ENOMSG)
             }
         };
-        let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
-        loop {
-            let remaining = deadline - Instant::<Monotonic>::now();
-            if remaining.is_negative() {
-                break Err(ETIMEDOUT);
-            }
-            match self.consume_element(remaining, f)? {
-                Ok(m) => break Ok(m),
-                Err(ENOMSG) => continue,
-                Err(e) => break Err(e),
-            }
-        }
+
+        self.await_msg_with(f)
     }
 
     /// Logs and consumes every message the queue holds.

-- 
2.56.0

