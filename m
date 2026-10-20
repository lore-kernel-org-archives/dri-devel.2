Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E248606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a8vB4P9A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB98F10F48D;
	Tue, 20 Oct 2026 10:08:50 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBEE10F48D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xynKF01qUO5eWnLS8gB3ZeiruySmP/Kx0LW0a3+HUwAC8ucVSCnZGXuFwAoXZBScYoA5a0e4GhftxaCxdFqD97vPB9WCfZ+xrcGipAZmcB2EibbJ8jZh4f4/08DEvHx1TbXzpOIuzNv9i5lnNh9DHMStjXVBmBC+M2JFHfwGK1PA8V14uyoF24Gq3bkdONrK+g2EE9q1Lncf7eC9W+dRsGdM2tdJUsDkkDvAzQ8dzzRI18pKdt5o6jtybUbkYuRyXVm/nJmc7zHNMaN3QKsKRw0KDpE5ld8dKZbL1jb1GMJh0E4VhAODphZmDeFjPyEFoGbv/Z+DtBq2ZZ30Z4tPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7/mRQQovAdIKYrgfvmhw5lS6pqQWBWqSP56Gu6ypy4=;
 b=Nyh2WovcNwt9jjV2vS5ZK8heApZdPzeYjAk971EHH2FarQv5FazJhnA4Aul9bcTB14Gxn4IFT8OjDqUT/21kJpaPokZYyU4WgvlnNIcWUMd6ZLQ/77zvyIrBDM9N48z5aV6HIueIL1V/Wvkf0s06D1KDcPSYurV5MNkGe/Ie3S6bnt7rVXHo32T9nujx74rYzUkSl5pWQxluOUbxkGXtGk4eASpwjFJPESifhcZbbWHZgushyGrPdPeW5pUrk13QHOa1blL/2WWuYXnyiC/uUngo5g+9sf4iwVU9Y1Y+JTxubCftpY8yxXz6CXf5+2e7a06OkuYWnUqAtpyLwbDndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7/mRQQovAdIKYrgfvmhw5lS6pqQWBWqSP56Gu6ypy4=;
 b=a8vB4P9A7AujyinQhZPqrBzt9Gi8J9V0X/8uV7RK5JP/QBI9blwjNFciU1R6J9gEyG48wTbRmGd2K4LW2B8v8EWYt4VOptz4M09Obp5IxxiXyxRiCjJ8xs1h4LLxQgiboFffuBq2TFqGtZwEkP9bZDEk0NVldAl04ypHU81wWpBckOyzvnnOYeuzUpFz5x3pC+2ea5qSLUfhITeJRsrQPA5YQ+JqGWAJwfCsGGXyjC695AJ+3iCe0SRrNJSnbkDq6E+6kDa1v+0Q4GhBL0XNS37EZ72oV0imvPbyJ5XspPlvmTlxG6GHkH68/JataR/OKvpJwMQKMd7xkjJ9dE6XJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:35 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:34 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:23 +0900
Subject: [PATCH v5 02/14] gpu: nova-core: gsp: cmdq: simplify framing error
 description
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-2-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b2fff3-9509-4e0f-2361-08df2e921a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +2hBlsHFImhLiObVastQbpCE3OLQS7jrGEI7pTgGqA2+PxPAowveAXVtTN80vhxcj+W3Rv6hku2ONRTU6Ug2i7RI9B3fs5rXZ/SAxMnEC84peJ81Hbjbrhw5dBKqTQLuJ2UvrFyLaVw1yx+O3316e1n1RHszmNP6AXEcKQdxlsYxQ7W6gN9Xc8j48LEM9oFeLwV584UqiKAlEJ3GvGy+jYgSHrFgqzC+IMSDknp8+g+iMsNwYuvh086c95aFKF+R980yTPcQacE4pkPKGdVGHHoVO5MKcijyGBWZ5/7tr0Yzl4G6Xqg3ZOIFNj2UMDOUdEbrTLtiJ2v6ECI0viKxUE4GHHSdVm9yooP7YkOBZH7IyhnaLulOt3IEND7ahaE1mHS4u/YjVWGxmIh0+TJpgw9TpmOZ6ZvS44lpXMdXeb+EFV79LBcnpOxhRnbVBv0E9woK4ZMEB5NVBGsEnZOBHVkH4ByktfVrZoiX+Eps86pnp11UI+qHWvhqhMWOYc114Nyoe1pSEy5F8C1kRBGvBJD7hLC7hsclTiiEFpqqXLIrpeYScZyhsfwePwGCXIt/rpNxEekZwoC91kW7H/yqP6cqCPpbdMEflmrHSO7Bw6O28O19wsTnjMLOxR55vmMKH10UhhzBY7pN51F8f7tSEwxURmjoI92gIO/609Qn4Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpoWkowSHQ2T25SWWlseVcwLy9ONGMvcmFsSVEzN2pXdGFyd3U4aXd2QUEw?=
 =?utf-8?B?QVU3QjVGbkYrY1ZBUWRJNDZub0h3S0xNYS9LOGdxRnY5dkhqbzY5N2cxa3oz?=
 =?utf-8?B?NzgrSXBabzM5SnZuK1cwelp0TkcrOHJLc2h5MDZUNkJ3aFQzTE8wb1V3UG9Y?=
 =?utf-8?B?MjBpVUxUSjJMdk1ZRlpMSmZieHhZd3l3TWJ4L1pzS1I1OE9iZ3l6NWxGc3dv?=
 =?utf-8?B?ZmVMZlJCWE5WRDBzR0lsUHR4eXU4akFNaERVZkRseEVwckNHNTdRL0pVOU52?=
 =?utf-8?B?STY1NTdFUDNRb01weVhNbnNoTXY1SjA4VHNjNkxQV2RkbmxXT05zdWt6MDFa?=
 =?utf-8?B?dEtqSS9ycVZBc2JvZHRQcXdna0UxSzdZbFloUE9YRzQvZHZyVVYzTmIzVWNE?=
 =?utf-8?B?S1RrdmJrNVZKdmZrRDUvT1JURWJmTm5Jd2Y5N1YwYW51YnRoUU5pSFhLRlZT?=
 =?utf-8?B?QjgxMVNzendmR0o5d1VPTWJjWWd2VVlXU0JZVytmN1BtakFaWGtwUEpKMUdG?=
 =?utf-8?B?M1RKUWtqQ1J6VEF2ZElYbk50ZmJZTEhud05SLzM1SnB4N0NTU0RLd2NPVkox?=
 =?utf-8?B?R0xIZmF4bVNTVlpwY01CczBJdmRzWk9iRUcveXVRV1ZVZDhrVmhJRjIvemc1?=
 =?utf-8?B?SGVraEErYUtWQW1hSmlOZ2pETFMzQTgraHVpcGU2dC9YRVRRTnB3S241VVFJ?=
 =?utf-8?B?S1pmZGNHZW5IcDJyd2xlYy9rSG5DQWJJeUIyZG16akUwc3djNnF3c3V4dkFZ?=
 =?utf-8?B?NnJrakZEMS9iMnVLNjdlVGtnaTF1OE5Nd3dWZzY2UTNGa01uUUNDWitSNlpH?=
 =?utf-8?B?M2drOUpITTNPVHlpYUcwZzFnQnRmTmR3amVzWFlEMEFqUUZybXlNVE1ka1dQ?=
 =?utf-8?B?dE1uQWVMU09kWFFlKzFtQkJteUJRaXpIcmV3Vm5SQXY0RDBjTFd5K2loTzlK?=
 =?utf-8?B?VjQxL0h0TmprMmdQditiUTlqeVVxc0w5Y0JjVTd2c1RZaDNTS3E2SWpHTUls?=
 =?utf-8?B?cmw1K0NiSDU5b1VzdnRjaDhxYWFLQjVWa1VOZGhDc3BZMElGbmNxZ1NLUmN6?=
 =?utf-8?B?Y29IZGJhSzhHWGkyNlN3NHpCM3VFcmZDVkZicWg5aXpRMDhSV1d4TktLbStD?=
 =?utf-8?B?Q21TQ3NuREt3bndVQ2FxMElueHBtUHRUdk9rY3JvRWNlT0tyTXpxeWU4bFZr?=
 =?utf-8?B?M256dlFQZWt5cHRXbHZxaUV0NjlvYUhUTUJ0QnZiRjN0c3Q5WEt6dmVQSWtL?=
 =?utf-8?B?OHlQVVhEa0ZuQzRuMlc5VVBXM2d4ZVM3WlBSK0syT3o4WEpKc1I1TTRmcnNo?=
 =?utf-8?B?YUJjY2lMUGh0VW9MRGNPdGJNSDBWd3ZzMjFPSDJReGRsajMyVWdKb2NmWmhR?=
 =?utf-8?B?d1FjakU5VDByTUNGeVZNYlJERUJ5VTZHeFhRWDYweDhFS3VpOXBnbFc2VmIv?=
 =?utf-8?B?SkRUajZtM3pGN1hVUGN3c2ZvLzA4djV0RTY1ZDVEMkE3SDJZV0VTWmFvTE9K?=
 =?utf-8?B?dVpEcU1CdjNVMjRUR1dQNi92OHJoVXdMbE04WHp5OHZjUVZvbEIxYzA1NmZy?=
 =?utf-8?B?S3ladkJIMTBlWmVsZWk3N3pXa3RjUW9DdS9GUTdvU3pQdWhBSVY0Q2R4ajJz?=
 =?utf-8?B?T0NTNjAxUGtKOWlBcGd4ZDdFMVh6SGVFZ3Y3NHZpVW8xaTcrMzd2RDVIMlpG?=
 =?utf-8?B?RVlDZnpDb1d3dHlwRVJVYjluMDdoZnJLY1JxTklmeHo3RjJKSk95NlNOdGRV?=
 =?utf-8?B?dGdqVkxhMTRtM2xUQzRWSnA2TU9MU09lMGw0U1FsYnlVZlM1VFVscTlMN2hl?=
 =?utf-8?B?c2U2MThyWS9mUis0QlpmSzRPWE5ROUh4NDlGVDQ2OFpFdEhzUU83bm1yaVVi?=
 =?utf-8?B?djZBTVREVEdnMUROL3Axby9hK1hQVi9OdDJxanBFTkFtMlRmb2ZXby9QZmd0?=
 =?utf-8?B?NEVnRUVtdjlFYk9UbjR5MXJlRldlMDhOb3Q5bkVLOGsxZjdxRTRTT0xmSVpB?=
 =?utf-8?B?V1l1b1pVakxsK0Jpc3hubEJ2YUtlV2ltSTFYbG9LT0FOOEFFTDVPUkdGc0t5?=
 =?utf-8?B?NjhINHF5TVk5eGlDb0E3VmlYaEd4YXBMS09yRlM2czVrN0dMRlh5eTR3K2po?=
 =?utf-8?B?NkJmRmU3UXJSZ0QwL3JVU0lVVklidTcrTExMTTlRWG5Fb3J6SVlVZkZiQkJY?=
 =?utf-8?B?VTdhd04wMHlHbjI2cjlienRESmQ1TlRadGtTS2JDZmJrZGg1Qzl1a1NNdGZK?=
 =?utf-8?B?bm84S3dUbWNPOE5rTk05Y3drWlpIeHoyTXE4ZmRqWlpsVmJlNnpuN2FXWEx6?=
 =?utf-8?B?RHRINlZRK2pBWnJtOTNMeGlFOEx1YVkyNVBHa2hTL0lOV203di93dzZQK2lT?=
 =?utf-8?Q?Aj4C35rhP+erY4VlXC5J226e6UVMrhQoPUWfFD71ifvrL?=
X-MS-Exchange-AntiSpam-MessageData-1: GsSQxkIwWoXpuA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b2fff3-9509-4e0f-2361-08df2e921a10
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:34.8284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+Dgx1zCQOEF549tJCgS67SrMW+1RiuURyharLIkeJ1dEa0EmhwMolIKjjrDv+YF2BS3KG0JuQCkrnYoVwMuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
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

Use simpler and more precise language to explain the conditions in which
`EIO` is returned.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index accfc1d20d28..1bd15fc0aef2 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -775,8 +775,7 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// # Errors
     ///
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
-    ///   message queue.
+    /// - `EIO` if a message fails framing or checksum validation.
     fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(
@@ -849,8 +848,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
     /// # Errors
     ///
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
-    ///   message queue.
+    /// - `EIO` if a message fails framing or checksum validation.
     /// - `ENOMSG` if the message was not the awaited reply.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
@@ -902,7 +900,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
     ///
     /// - `ETIMEDOUT` if no message of type `M` arrives before the deadline, however many other
     ///   messages arrive while waiting.
-    /// - `EIO` if a message fails framing or checksum validation (see [`Self::wait_for_msg`]).
+    /// - `EIO` if a message fails framing or checksum validation.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
     fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>

-- 
2.56.0

