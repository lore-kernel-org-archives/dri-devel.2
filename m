Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8B606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M1BWjdPr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195E310F898;
	Wed, 11 Nov 2026 01:38:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0609910F898
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLXsO/1HBXE/E+UQsPGa6C22p0Y9J1LAe84NIa9fJP0Ns+mszkCWOjiEV6IgR7xErH6tw7yelQ/aRwa/TI65tNqrBZ15y3zpK0PrfdX+81PCDr5G9qELCmFt7Liny2SMKAI6XTx7y8TZl3YO1sTV50PZZX/9SK5NVlAd1H7RwPx58XEnHJPS/HW8CbgEo/zM9dcqOkHT8CsK5/3dWc+++9MwKqtvO9NG/K3nMnIu/IAitQhGnYKdYYHWOAFAXMFClwqKbmwr8lLp1RLxkVhyfrGxHt1DmTbMca1g1dmagNf7dXGnEP5lVHqxjXsCrnms44D9nbPyek8/AtaCnL/VLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e9hXW2UtubXChUSRP9Vnc2+Cewt1iEOlQYldu3YNPA=;
 b=P2s3Pehw65w6yGZsYT1tWSwSv8g1YuIHSO77VQRVc4mHqfAvUxpeiICK1Tnj8fEOpBVoimVpZu6Ct77fIBkUOqj/50GymojcYu25kKMpmZYLhp0MqYXw9O0haKqX3A/8Ol+KzkzUat9K3mxg/G5P15WS+OnAClkg6yuUXOnhVUyDzPPU2v6vRzQ+gtD/ICdPM/Br/LIsNL3KrRPeI6uxCbNOYnO1LxgpRkmEIQHpp0F+2Kc4ntX3op0nQwN+lnUxcpGNnr4bQiflnE5hcUUpzcjMvayIDXWUD9wmSpaq044lfqypNfvBIVGu3Ezm8ELVaEWGevr/U+vJhbMzRGqgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e9hXW2UtubXChUSRP9Vnc2+Cewt1iEOlQYldu3YNPA=;
 b=M1BWjdPr9Brc3MXXNyZ+0mgGqpeAMkWYIPO54FWK15+2V3btAammZgxEX6NXc3ugQ+Ni4eqxRZCzvyh4kB47C1N28L74/uAWRE9AVgdYpB4/RCAkLyqSSMd1v63z0vNLXRReOWMNS2iA1u8diHKNYnsLp4Q8z5vGvOe1n2uH9ANhf8KRcB1AOqlwjWrAtYutLueqW9IG4qEKI5K/wC4HL49hd2KzqZ2H1A3X2gaQjMs4YFi5k0IP6vHhWMUIcpGWQCBW4+dcE3p9G0THXSgeQ/x1+4h4UjxzMoHDfnlcq8NsielYsJZTWaNInNy7Gqkl1rCn8BN+AVfMjaNqxY3Fvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA3PR12MB243666.namprd12.prod.outlook.com (2603:10b6:208:712::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:38:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 01:38:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 11 Nov 2026 10:37:34 +0900
Subject: [PATCH 1/2] gpu: nova-core: gsp: cmdq: wrap the sequence number on
 overflow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-msgq-64-pages-v1-1-d8c56b6fdd6c@nvidia.com>
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
In-Reply-To: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA3PR12MB243666:EE_
X-MS-Office365-Filtering-Correlation-Id: d601c795-36aa-4017-9d5a-08df3f9473db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: LkqYqfuE2SIz5tAzfluf2uC1O/4VjmUhaCmWUawb7IffKOvBhXagWXsfT7g2P1Iolh7Ipxfr5xi5yA6Vg9oW4NPcEp/J7DxVckk/0ca9rDEyLg75v1/11et8LGDeSA+4UCVpRn1eo+up6BXQq2kzFSTqoBK8PJ4zUAReMvdg4a+IoLiMXbkIMjBM9Raj2QYFYe9jHoazQsF5jeXFeGeF6tLJuygUyjm4MOlM3+TkRdBMSP//vYCkjifAG2bBs4DKHemJ4PVfV3+WGNJ34qSMf3YoftogdyTdI+Ssr7Lc/yWaf9HqqP2IVON4zz46gMUOsXDAnyetLWMtKZdj4Mpvq2VuOMShgAjt7R54FCWDK/iaZ6oHagfgni/IPgZtFo/WDlTxI7/RtmjyaQL4+x7NKtzUhJbwok0KTQqzVyX82c0aQ8rcVSf0Lp9rF6b/Ty7T2xaLlLrPb8cOuw4mrhw4TsRiQCH9+Jdjjsi/Y6xwLKFf8ZxMGpBh1Fwz0Fg9kcMMK0Qa6A1wqIAaI0l1Nqg759kXa4tnVyH9w03y/TRM+dqgwKp8l9l1h2AwO6tMb2clYaBDJZ2jPWoC1IWKKPJzmSi/ADk15KWQk7ne8IvvlZtdfjGZKEWYQ15x/wYuXxr3ayEuj+LROSZlFDLWK/TbjLlkyyZBIiVz8rpvUXwKui8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStGM3ZxYUIvamZBZGRyckJEUEUwckN1SXoxeHVKcURwNlVaYUUwTWEvYUYw?=
 =?utf-8?B?dCtLcHgvUTlzWXNiRDk2TTdiSlJQSXNkVmM5VldRbUV5MG9NSzJzMzNvUUw4?=
 =?utf-8?B?WUNkL2ZEbjExcWZZa2xoTjF4a2NWTVI5Wk1kaHkwQlVJbjZTQ2xIcGd0TVVY?=
 =?utf-8?B?Q1R3S0VBNDdHT1NvTktick9KeWhzemtBb0x6V0trb3JMSkJ1WVZMUXRFNEt5?=
 =?utf-8?B?NE5WRTJZZHFxWmtKeUdoUWo0aitHVHRRQlM2djhRTzFjQi9rS2RJNEIwUXZ2?=
 =?utf-8?B?M0l3aC9IWnRTRCt4TzhNL0VVaGhvcEhnK0RZM2dsdHRWTnpSQTRZMm9iYXdh?=
 =?utf-8?B?b0xNMUNzTVVkWVIvRyt6MGFGSno5cGpuZDEzdVd0TjVnS0RON3ZYMHJPU2VT?=
 =?utf-8?B?Y3o1Qjl3WkdvZG40bzRCQjV0QnFKRW9aTlR3L08rNmpiNjVVQ29UYzBvTXJk?=
 =?utf-8?B?ekRlWkIzL00zNFR2ZU5BNDR2N05vdWxXNkJ5cytrUzZzU0lzV0d0VTVpOEtq?=
 =?utf-8?B?UjEwMFJhUzMrWG1SSGlwd1Z1MnU5RHVmVUErK3ZwU3FMeHB4djVPUW1MREVq?=
 =?utf-8?B?cjJMN1BFUTBwRjQxTnc5TE01bURyQUlmQjYrdnVhQXFpR215SXJVeTA2R0hJ?=
 =?utf-8?B?Mk1qeEFkOWFRVWFKekdleWNyejZMdDlZR2VDc0Z4UW00Q21ESC9LcmQvUVZH?=
 =?utf-8?B?OGJRb2d4cXErUXY5UDlqNEo0ZmNsOTlvcnRPbEFvNVE2UUlZN0xFZUFTMU55?=
 =?utf-8?B?aVNYdy9Semo0c014NDIyMkxOanlZL1dCMFdESmJMVi9reTJzTDVVdTV2RHQ3?=
 =?utf-8?B?OUpJT0s4dFVNeDgxRVBheUU1WjUzRi9yV1ljR2NpNm9BSW8yWkNKbXVKNXBP?=
 =?utf-8?B?OEd1a1hvYTJCLzIzT1h1OG9qV25sSkxRNFR5bE9lSVpkRTdSTDFUTnU4TkFq?=
 =?utf-8?B?RVlSV1k0cVNPb1VkWnJmYnkwMVZrWXJlemFvYzV4NDBVczg1dGdMK2V0bHFx?=
 =?utf-8?B?MkRlVUN2SGlQZ1lTQ0ZEL2ZESlBUNmpwSjN2bGcycHVLWTdYanByeUx0TDhI?=
 =?utf-8?B?clhURG56RXhaNFJTNkhuYkN6cG1IMU1ZdFBUYVpOZktNS0dCbFp4bkxvbHdY?=
 =?utf-8?B?cW8xVVpvR3JaVXBSUDRKR1RtajRSZVNJbGhmY3hidE5na1EzUnArVDd1L0VQ?=
 =?utf-8?B?R2ZIOWZ4N1VWS1pTTlhReFkxWi9EMzRXL3lLRW1FRDJnZm04VG93bEVubk00?=
 =?utf-8?B?bVVMSGduUTNiNUU1WkQvT2luaW1yOHF5a3oxOXlWTks0UzNwemphZk5odHhL?=
 =?utf-8?B?UkVORnhYbThCZlkzRDVFczdldGcvb0pNWFZYSnlVdVdzZjF3ci9mUGZMTWt4?=
 =?utf-8?B?bWF5Qk9yUnFkUDZ1MHdneis5NmEzL2diVEQwcmNoN1hzZDJJQ1BtelJlbGdF?=
 =?utf-8?B?U1E2YUxSTW5jWFV5RVY3REl2YVUwWHNSTXh5YmxaMGt5TDkxNnFkelZNK2xO?=
 =?utf-8?B?UG1BK3htSGJ1RFI3a3RjREJPOTlZMFJERHFicXI1cGpTTUNrUzhOdFhRS0U4?=
 =?utf-8?B?MEllRzd0Tmd5VXVodW5NME5LNWJEVitGQU5QNzgwOWgvRkdhOG96VlFCcEZO?=
 =?utf-8?B?dExUdVdlc09yc3kyRVN1dFd2dmFZbWxjSzAweUJEYWkvWFY3Zi9FVkhpVXZq?=
 =?utf-8?B?andDalJrQWc2emE0M1J5aUdiQVVhUFVmNHBIT2w4bXJvT1dHNTl5Nll0bUFo?=
 =?utf-8?B?UXozdnhuUmZKL2U0T2pnaTgvZEJSOWdWT0NySXhTRmE0TEdvd04yUWdiakxo?=
 =?utf-8?B?SXEya0RZeGJGRnJWRnEyYzhlc0JDdEtNYVBJdFM2ZndCdHh3WjlJWWJPS1Nl?=
 =?utf-8?B?MGoyMEkwZ0tkZFNSOXA0K0pZbEN4NVkvSVNzWjVJbm1USUcvZjNkMjdlVEVt?=
 =?utf-8?B?TlFqUlliNVFHcG5VQ0MyUnRzeW9TMUl3SFBYSi9ZRnVhbGJMQ1Vmdkp3cHJn?=
 =?utf-8?B?ZDdWYUowaEtzeFFuelRaclE5UXQreXZHU21pclE0akl5WEdDSzNpWlA0ck9Z?=
 =?utf-8?B?ejM2VkM0SUhXME5kZ2ZtV1dmdE10RHNUbCthRWJ2aDBBc0kxM3k0K2trSzRX?=
 =?utf-8?B?T0E3UXRZSlVtdXpJSm9adzJMK2xqMVNmUkkrUXB5V2l3VmNWMGNicjVoT2hK?=
 =?utf-8?B?UFRING5EZ09rdHhWNkJCUlJ1RlNGeWFXZDRrWkE1V1UzcklSS081bHdudC9z?=
 =?utf-8?B?cWVaN0xrckxTdzFveURtamdaaXJJR256Ylpwb0FxUDg4YnFlTUx6TTNTT2E0?=
 =?utf-8?B?eUIycVBoOWtURTBnQisxdUM4eWdmbTVtOUhGTTltWVBlbC9xQzR1eS9BV0ZH?=
 =?utf-8?Q?XbJSIXkoKIfRpjE6Y+c8AMeapttzSk/yvLAguJ0yu/RvV?=
X-MS-Exchange-AntiSpam-MessageData-1: kh4/Hd56vNYNUA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d601c795-36aa-4017-9d5a-08df3f9473db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:38:14.2979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tv17FVichfufr+UlWNMygDvzxzc4IkQaFGo5MH3tAgNdxRFvoyP4MjBOkTCZWdrtK7Q4fxqKo/0fGtQoqB6anA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB243666
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sequence number can (eventually) overflow, in which case we should
just wrap it around.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 5f3de456042e..33074bb53e8c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -578,7 +578,7 @@ fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result<u32>
 
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
-        self.seq += 1;
+        self.seq = self.seq.wrapping_add(1);
         self.gsp_mem.advance_cpu_write_ptr(elem_count);
 
         Ok(seq)

-- 
2.56.0

