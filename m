Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B37606A333
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ftS4y47Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7DE10F49A;
	Tue, 20 Oct 2026 10:09:26 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EED810F49A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIImBk9jb04Q31v9CG34hqsVxoWBeDkMSbSkGtkriqjs2zOS52BEqsRzKzqhaVfpPTulc3AD+oAXyzL9uQ3l+Uz44fkBJvvrJLI9TrsxPd54q/5sA2rYB0Loe1+dxjqK+WrVDOzPYfkzO2f47QYMcJC52deENHgHMx7snm2/IfN6Gvlk7BhcBwWDDlzLPBP6xA9UuvLxMAJ3vDi2DF3LWIBsMFmpr13s4VwRla65u7BUzOxWXHVQU9fg93+8icFvjhUzCxcvWKGZDfSEtjpiVLj2/SUb1s6T5fOpJe7OFrIPHx9q2pO+Of0p2F2OU8HRCLgN0DRiz+V0S4LrYZSAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2FFb9BIoJ4u7NK98VIe55HkGGhWeaDwD+YUKqN2eZg=;
 b=SUODTzE6Hs35dGuKjzd3r2chwHwgmfmfZBpYCpbvajN4O9l4ARnMZjHSElp5X9Ob4Btxqet7yhSDeLB0jiZuV+ZvTII+zxhBvU+i6WnL32QHPnsdKgNYi3cC8RPJMVZTXRgolaRzaCmQWIhG6MJeLozcmOoDBHIN6K60yBkjbSwPzQwIHqyUKh1PlcJ0m0uKjjkNNBhIs/5anrgBywj0PsOFPJAEY4BOvwbgTzHEKLwsaQtxBg0CEH6Lge0gedGi/pAJgUOATlhpbMukoTqn5wxC4/xiE3LF+uu+EiXOHQ3MXQdm2TYGqVUQIfunxwuPL8Xb3O5XQy3F4TSEEE8tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2FFb9BIoJ4u7NK98VIe55HkGGhWeaDwD+YUKqN2eZg=;
 b=ftS4y47YcdwN1Lbrjr0hGPwp2rrUmHUctNlo/N2qjxPAd7V4jEquSF40om/ZEjINz/P/j95pWk7O7o8scYuBSdgXMvi3hkyoKS6orBxLqL0LTaue9wSx1cFyXL2vtFMPczEouV9pPni3L8pACRN5oy6+BhyHoM68QFfWxr27sTUEQapvbriTwd2wz4cZEQG6HlGtPT8RmQS4wg2dMCvxtktNmTHe0TLox5EsUqHFtb2xdn27RsKw9inpptxlh2C2wvG01kbed0HSnQN0iOqVkylDX3b6YoSbq0AbwURkpkGz1upmPrd1H++A8b7V5q1aOel/RGZwmUsNTGrTpUBiVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:09:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:09:00 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:31 +0900
Subject: [PATCH v5 10/14] gpu: nova-core: gsp: cmdq: extract await_msg_with
 from await_msg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-10-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: f37e6c6e-65a5-437d-76ea-08df2e922917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: W6MLoAhvPYPAgvsGJ3gxRXBgGqLdBXF81gnzSXCHnsoyDmivLcGdVGImtACwcXCzboDd0uuBq2EOgDvEyYi5rvy0L+MmoI4cFR065d3nEp4kM64/+17kgvMAO9/2H7gOfrvtFDhS0qyGt8ZJbeg465/p0SJekA5sehevOKMrSeuFIefgOV0KOhR+aSGmqFBs5zuXQt22Q5nBWuP0YuDis1wcvWRHdcUNVCJ1NzGDp7NmCTaykIyWQiHwtnqNCfCPIYwBiovv140k4GHnivowu3b/nCLe3eihlEhbY+0ySm56VYOcFnCPXZt0vuy5v7L6Wj2SmxZCBYXxiOc2tGx6ctQo9TWIfsoOsNFubBPRmC9hRxpNtnNqcTIEfuw90VOTat0g1fvusF0dGD8qSfO/uT3n+Rz9nGaJ6f1jRCgwDuqKvLyldv7n7Nc5dX3+rIEPWvWlvWiFhmOGDopf3O66W2jcdc9mAFQm1qHPPrGtlg/pyNFm7VHGDMlvTbHiqOb3VrpKd0IWrWbB771mep8TMu59RllC1MmYJf9Yl2jN3nYx1iky2+QBqNx8mrC1t980A6fUKK2E/kIGlxCE6o0UdGGu3dtqTc/ue62Fxw5g0UtalDXo5lfLi/QSzY8nU27IFaeY79TL4kxCegyros83yYwD+uip2ppvQE/qAJ9zM4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNFczB0WEplNmhseHFjbGJ3UmptM254dHRaY0xBSHM3TXJVZHFpM1pkUmsw?=
 =?utf-8?B?N2dORUlOWnplNTBBWWFkTS9NWHYzdm56cG5IcGw2djhZQUsvWGYwbUJSc0k3?=
 =?utf-8?B?YTc5VHluUEJ6L1lTdkd5R3VaRzNiMVdta3ZkRzRZM2VoTVdyS3RUdzkzcHN1?=
 =?utf-8?B?TjBaTEV5OXJ1c3FLREt4dmtJd3h3VzIzMDlDdTV6SkFSZ0Z2YTQxdHRhcHhL?=
 =?utf-8?B?VWZTekd1eDBuS0t2OHlDMDBUWU5icXV4d2M5RXVpWG5vbnBjZTdMUm83bDdx?=
 =?utf-8?B?ODdRYXhPWHRRMWxyVGFBZlB1N1l1SWE1bHZvQ2lyZFBRNXJVdUhNUVMya0xX?=
 =?utf-8?B?WjBQc1lxSkM3U24yZnBjUGlzMG56QUUyeUF6YWkvWFMvY3p5ckNHWVArMDZK?=
 =?utf-8?B?ZDBxVXIyUWdWQ25hdm1zd1N3NGhYc3lDNXJOUm5ZSWV6YThJZlFNVWdLQ01q?=
 =?utf-8?B?YlRBVEkyQVl2U0pWZ2txU0k1bitnUm9qWkJhU2Mvc2VIckluWGN4MllvZlc1?=
 =?utf-8?B?UnZoL2U0SHRVVTRBYW5DQjB2Q24rSjNxRnh2dlF5ODNHdVlaZlQ3QkJ3K3Bt?=
 =?utf-8?B?R2lmUmxkdTdNcTdNbXRvZWZPaEpDSldqdjkvWkkxYmhoTlNQWFFOOHFyYi9p?=
 =?utf-8?B?azdpOXE3ZGNERjFQM1dVUndPVnFuelJxTitSY0oxRnNhbkRsTjVQYjRvZHEv?=
 =?utf-8?B?ZUFJaFhvR3ZJVXdsd1NkSm9nUlU1bnAwdnVSa0hXWFUrRzFvYW9jTWh1MW43?=
 =?utf-8?B?UEdDSlg2L2hLZmdDUWpnVEk4U0llK2R3NXZKdDZpd2pSNFpyKzgwSTBuOGdP?=
 =?utf-8?B?RUJNa2xPK2prRnF3R1c4c2JpLzh3YmtKcU1IeWpnMVNXaG1UL2pKaWtsZnlp?=
 =?utf-8?B?R2tTKzhqaWNIMnRCLy9nQndIWFpXN0ljbXZmb1lHd0lxcWZUMG4zRkNhcS9p?=
 =?utf-8?B?SWQ3V0QvU0FXTU5TdGZJd1JNeEV0N3ZTUHdkdS9TMXhvZVhYOEF6b3YzOWdU?=
 =?utf-8?B?ZWpRSFc0d29GaThRVFVSUFNFYzRZOS9kRk85SmNlWWhPdlFBMG94VWVvWVNw?=
 =?utf-8?B?Mk9yNXBvYkd2ZWdEWHBobkpwOWpObC8wMzFTTVhXZHc2bkJUTDJ5aFFoNE5u?=
 =?utf-8?B?STJlZER5UlJvWTNxckJtQmYrQXZ4eW11ZlhNc09oazFuSWxRbFNqMlJiejFJ?=
 =?utf-8?B?d0t5N1puWXJpUkRpU2pMWUh6Rkw1MGVnSnJKQ1FjS0E1ZVU1T1krWU91c0Vo?=
 =?utf-8?B?ZFp0MUErYjZ1aGVvbVYwTTdMN3BneGh3dVcrVG4wYWlZeE5heEJ1RG1BNFRs?=
 =?utf-8?B?RjFYNDgya2pEVHVtNVBQbzNOSXgxSXo4SWhUMW5QWHVEOWE1QmQzQmYxY3Zp?=
 =?utf-8?B?TDBBdG42d0NxZ0NnM2RFOGFJVVVhczhCSC9NakpIUUwrQ2NYVndYZlNZekJX?=
 =?utf-8?B?OU1KT0lXQ1ZvdHVORGY2bDNPOUdtTmRabjZlZlA0VGZ4ZDgxN3BJUXdKSTJi?=
 =?utf-8?B?TVFVUXY1Slh6Nm9KTFhvMHVDTmNKU3BDcWlZaytoYW93S3lRNk1xMDVzYXQw?=
 =?utf-8?B?VGJhTDVkb212ZVZZeGRNV3AvUk9jYVRUUkJJMnorM25SbStBQkVsNWlFemhF?=
 =?utf-8?B?OWJHR0NiZUNlLzhndEpRSnY2bktEQUVNcXhTbFVVaGVZcTJnTEVnOG5penVL?=
 =?utf-8?B?cnlJZjJheHFJS3hRR2pkd2ZMZVg1cXVWdjZ2eTl0enRmYVRlT1BSUktnTEhY?=
 =?utf-8?B?VGVaMFhPLzY0U2VTdm9PVElXbEJHdTk0OG93WkVCbVRwczZkTTlaUENsZHVM?=
 =?utf-8?B?OWdhdHhGanFNQ3drOWV2NE15L2JQK1dMY0VKbThmaitBcXIvS2NiVWwvV29X?=
 =?utf-8?B?dEFEUHV6SnB6SzhVZmlYYk40NHJNaTFaRFcvVDhIeVNkcVcycnM5UStDT1Zj?=
 =?utf-8?B?MGZnRHNjdC9xYTZqd3pLWXAyTTREYjFLV0piM01uSy9GTlpsN3VsVlQ3Q3dI?=
 =?utf-8?B?TWpxNE9abjFyS1Rncy9Fb2xMMmNiOXNqOGFCK3RXUEY5WitBRVlNdUU0Wml2?=
 =?utf-8?B?NTF6cW5vTVZMSlQ0Y0xDbkVzdEhzTjUrazdka1EyL3drWGlHcmxKc2lqbnpB?=
 =?utf-8?B?NHF0QVFQL2c5REhMODJkNWlicmtBb3hoVytYelJMVVRQWThMSGZCQmdlVmRl?=
 =?utf-8?B?TitWRWNQNlRDbWlPQzgwL1NhMXU2UWNFQlgzYnRtaVF3Q3hMazJEeHlaV1d6?=
 =?utf-8?B?dEQ5WjlsU3U4d0NFeEM3VjRhUjUvbzUxWi9JNCtQUW45OXFQWDgvb2pudkFj?=
 =?utf-8?B?YlVHTjZOVlo5UnJIbFEzeGY5cy96VHl1cHlTUU9vcXFOeERPVGFZNUNlUnhu?=
 =?utf-8?Q?bomHbfIAXncnLDdvAHBcoCPsmndmG6sjOKsJpVZEKUTyE?=
X-MS-Exchange-AntiSpam-MessageData-1: fENNjjKEwLGAiw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37e6c6e-65a5-437d-76ea-08df2e922917
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:09:00.0535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwdgvLisZtsoclBOAeB6Zl3oOjj1ZKzVep/Dx25lYDHwABIyHUSvGDeAx18eaIAj7G4CiHcLv16iv1WDltTj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 44 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 58761a5f609f..7db3d28e8902 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -971,6 +971,36 @@ fn consume_element<R>(
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
@@ -1013,18 +1043,8 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
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

