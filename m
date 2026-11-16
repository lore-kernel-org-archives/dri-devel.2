Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E3606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=htP+VvOw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E8A10E23D;
	Mon, 16 Nov 2026 15:07:07 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F402589D60
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsxJm5Go+uCgI7+l0fP9lkIoim04RONjzrfijkg67rT98pGNrCKpcUEBFGEY9O8cEDZTKCCD3R23VzpT78N0HARKdpK8wPjmubGt3szpQ7T5GsPYsGWAgqKnO38fP7lYxFtGL9DiGmZJcy5CH3UVcjSIJ8k0wVKatuS3ln+ZtG5DHB0OwowIUv7Mb6SohLitcQ85Ogpx4/vT4P6GpDYU9qVlsDtscXPD+/nEN0KvUWCUqB5zlASswnGqJIMkt/Gu/zAsfUsHqc3SMeJTr6km4m1yiUuK1P7zcegj3dk8/Eais9uE55WxD9hFgSMU6aacVZoT+r1rwdOPcFpNbvTMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dg/x8fykmMe07l3u4ffvwg8m8pxk7t32y6wCyDLmmY=;
 b=U+xaXe7hDCRjSVhzUfXyAapQMB9sgIhGUeWXbm+u8BgA7M4gZmqJarPNmFYsxvqrLUvm2eP/Q+8CqbgK3zD7YGfLFWVLQuNd+q6zPOklDJBMuVjyloW0rUkEhlSoOH21npdHhdvoM+tCvxB5NAIQNFFulWLYhgspjhyqL4W2fimyObUXDoQdJAXqGkxjmQy0TWlPLswB3klzELYc6UqA7Wgh/SkwtGmjnPdashsO0+RAN5MTh7an2u2BeqfW4BDEJ773UTdtvPrjh7KyIOd5uIAD8NpRS8TK/740oj7G+lB0iQ7wL4ZfziVwQO1eIdiyl4NgOPO7WHcfeEbffS8T6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dg/x8fykmMe07l3u4ffvwg8m8pxk7t32y6wCyDLmmY=;
 b=htP+VvOwhu+ag9WdT4eg8U3F5Q79bo0KfWZzWtvTSi+lo7IivMxNXG8DTcAcdU6jUrQzB9SyqeGLGC9SGxPrupt0OJEWzmWlfzDgtiLSjOqJelEql5WD04a+dHGCD0H29KnDX575A7/LHi5b9aqBSBd/G8SWA1PGKTOaqV8hbkgM3iRDik7fGsJcwqGOZvC9YREndaj5tLiq+yEl7pzQewg89GiaYgwEMRfspHSmwcTYmJvOLYKVOEIXNjQxSkkJCvrmyGqgKUtAo8ZRzRnoVwBi5bMCOsMdg//hdXIKxBx6h2X751CFpr6Nabf6VTlI2titOShSIV2RuZphxbaCmQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:06:50 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 15:06:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: gsp: cmdq: preparatory patches for
 r000 and vGPU
Date: Tue, 17 Nov 2026 00:06:44 +0900
Message-Id: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqAIBBA4avErBM0wkVXiRY2jTWB/ahFIN09q
 +W3eC9BIM8UoCkSeDo58LpkqLIAnMwykuAhGypZaaWUFuiGXUR2tB5RaLS1RG2ssQg52TxZvr5
 d2/0ORz8TxvcB9/0AfsnwDHAAAAA=
X-Change-ID: 20261116-cmdq-timeout-6cf40c6afafc
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OSTP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4befb0cf-1572-44a9-8bf9-08df43f33de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261009223027099003|18002099003|3023799007|261021121427099003|261021123027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: fhb/6VdILvrWETwar9G34rqjxYNwLJTtRy4cUr9EE0baTQ5q2F2KfpVbYXGVPt/gS+tEcudlSIKdy/usRwu4rQ43grKglgaek9pwxzTL+1kBfOp5ePpEOxIy66cnyKxecy+eY1wc4d820k3FaksdZd/r14Y6GpLLFQptb3cYuOQJOGhXHt2bV/tbFa6pq2aOy2XmJF/AbOjiQf0lc4KOK2rOlssCT1tllLYYuSMmrubzYhj2mX5bN5q06hzWWg0tWl+FGuj+2E4blr15AcLx6iKqRbaeH8Y2/MqTU0IHR6GFfvrjo1fU54ZXBU3UqhEy7fZ9dTSZ6t6hxr2KJKaYHHzdgiA2Q9Qjcy42iQrKIxBn2iRAcxdQpJWsoC6m220RofQM413dq6xGUVGMfQgJGViigfQtJ2pxYETT67K/oE232g4D4OBPrSRSeeljoeX4V2+5Zd9WtSi5fkKZc1jUzapaOnvSVxFjhS+B1LmdEbn8ENfN1HWPDKn9pmJm+j7V5hx6kYlOglaPJ7prmOZxMGC5J3vnLbaBPhODCS+HLzPDYossZ9O6hFMoSj8cPTqRaI9HoGOTonHlY9qEp22F1IIJZ9DaFdKBqx4/GlntEBJBPtgYxXXXSPHvSSxH4RCXZUmTtJ2i6olhdZYirR+J2eYNTwVzRpsaudtC5QCZB1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261009223027099003)(18002099003)(3023799007)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWdGOGZCNjN5alYxdkNIRDdxRXQxdTFzd2RTOHR2bEc5RTFRSGNBbmVQSk9V?=
 =?utf-8?B?SXhDcDBuTW84dzVyZktYbExwajlxSkVWdzVwZ3poOWFLNjA1dzNSTVBLV1R3?=
 =?utf-8?B?VXkrYVZyVkxBT1RKVHdpdHo4cmdHVmY2Qm1BeHk4ZFZDQ2ZMaXF3SWEwS2xX?=
 =?utf-8?B?MkNPNHFENXVHSTlFUUwrbU9FMit3SDdUaGRqODRsTkFuazZKaVdKWStMbHBo?=
 =?utf-8?B?WVhWVVMwQkVHdmVMQ25jMy85U3cvL0puUDZyL0JWaGVPVitLQzhGVThoK0k3?=
 =?utf-8?B?c1lvMDZkZ3JBZG55UjJlNzdxQVUyclZ2NHZaaTRVcDBLQ2hVNXVvMHBqSzFT?=
 =?utf-8?B?N0MxVitHb0xOcEFnOU44VmV0YTlPcVJoSVhsWUd6b0M5K2VNOSs0NjErYkg5?=
 =?utf-8?B?NzBRaCtSdDAyT0lYbzRaemE5MEsvWUdsSS81NE9mWW1LYjNzdUtYZXZhOThN?=
 =?utf-8?B?TzdiOHJSbUVDV2lNZCtWSWFBTkpadDBNTWVZOWtnclMvOFpkRTB4U3UzdGlx?=
 =?utf-8?B?TmMyc0FHS29pVk1XTHZHMGdvc1YzdFN2WTRCTTk0M0YxbENQemluM2RLNlE2?=
 =?utf-8?B?UkV0ZmZib0U2dTBYWGdMYVQxQjlwQ3pnYitTaWs4ZVMwRzhmeGE0WnlJd21n?=
 =?utf-8?B?T0NwV0tBUit3bWRRQ0xsc0dCeVJvZGYrM2ROSEMyN0g0aUZZVmVXS01ib2Uz?=
 =?utf-8?B?NHBreGhXQS9xWXhzL3B3eEY5cnVrODMxZUNsczNIck1TNXo4N1kvSENzUHp5?=
 =?utf-8?B?cTZ1QStlVS9sZWxLdnJ5ZGFxdGRGWmkzUDRqTU1qaERKaytXZFY2ZFZUVHNo?=
 =?utf-8?B?WkJLczNWamFhR09nZmhDK3dPSUVUazBCdnpyTUp3MW1BY3JuQzNucytuR25i?=
 =?utf-8?B?ajBUOUdZcmlBSEhLd1BhbHlSeUJZREwvcUtaa0NFN2czaHBBa08rd0FveWw4?=
 =?utf-8?B?T1J0bFNqTTBQTk5UU0N6SXNsN2gzU2xGQlBvaGl1b0ROdGpiTEpSQUcxaWxt?=
 =?utf-8?B?RDVOR2Y0YUt3ZHl6WStKdG1uUUJEejN6cXJYOEk1MlYzcFk3NEVRaXhDNWRz?=
 =?utf-8?B?VFl0Wlh3OTl3MUJnN2NQNzdSbXFlcmlPWEM1bHhadFA2NVYwcm5wUmtCUVR4?=
 =?utf-8?B?Tlc1YnEwK2dsNnZLN3FDMWZ1TGRtNlB1REMyVEo5R3EyblR0bDd3T0xjV2lM?=
 =?utf-8?B?RUhJZnVXNWF3UXZoN2dsOHFjTkFXcjdHcHJUeVpNUUZIaVg5cks1MDNlb0R4?=
 =?utf-8?B?MmhkWGtGREt0OUozMk9SMDFLRlh2bDdvSEx6R1VOcmRUdThVZUFOK3Z5VWtZ?=
 =?utf-8?B?LzlVZGZmUHhMcFJPeGdxRmZ2blVnZmF3cGJnLzMzTlhmUjJBZXJnOHlzcG5I?=
 =?utf-8?B?RHVqWFVKVDR2QnJwWU5RZWlVcTM2K0ZxOWZZcDFQRXlhL1lUY0dRNUhKRi9v?=
 =?utf-8?B?dmd1azNyd0lQbXYzQlNmZm9EYTNpYlFmQU1mRUtCWERMRjQ5NVFWRUJCV0lt?=
 =?utf-8?B?TTUxWStjTjRtUmlCbmQvNFhIMDc5VzdmVTlJM2RsRWpaMU8zaGtIQTV5U3dF?=
 =?utf-8?B?WHNvdjNaem9XNDhSaTcwaHBCOEczWnFqTmdHZytlcHVLWWV3MkVaUTVMZnBa?=
 =?utf-8?B?eEozcnpkYzNhYjZjbU9DZVVjQWFvUG5QbmZBWU5nYWxkL1VWQXVrZ0VHeWcv?=
 =?utf-8?B?NTBvSi9GR1U2UmhUU2hUa2Q3UGk3dmJXS1M3QmNGNCtQWmNJZHpVMHN4M0RY?=
 =?utf-8?B?eER5Zzl0RHpCN1BVb2ovcEx5QXl2dmN0MEpBcklhdXQxWmJBOWhOM29hUytB?=
 =?utf-8?B?NkpIL0ptUGFQdGJOTDI0a2VMN1JmSnd1OFN5K0p1OU5xdSsxdE1tRDloZndh?=
 =?utf-8?B?aEZxS21KQ1NScjNVczA0aUZkbGNLNTNrWHdvQ2czN0dhNFhBeVBBSHV0N2g4?=
 =?utf-8?B?c1Y4SG1IQ0Z3VHZCQm5vQUc5TzQxYW5ORk5ZK01BVFFJY1ZHY1V4QlBTdkpn?=
 =?utf-8?B?NEwxSDdCeWVTYm0yR01KRXNtZm4yNUZNMVhGYllPODUzZGhZb3VHT2U0WWww?=
 =?utf-8?B?aERzZlNMWTNTQklHaFNCZUMrelN4U1pHb2RxY2huZmtWTnUrS3d4NWluZXpW?=
 =?utf-8?B?R29xUzIwYS9YTEZjaDU0UjlidGJzMmZTd29JQWhneFNiYmhETklrYmtuQ0FX?=
 =?utf-8?B?ODdaQmtWYlNpak5HUHg3bDlETnJjR3pXUDBCbTBBS3dIRmpVZndLMmN5TTV3?=
 =?utf-8?B?cHBPcTRaMklHTDkzenN4Q2FsR2dldkR3bVh0Qk8wbEI4YnltSkZPMlVVOS8v?=
 =?utf-8?B?ZmZJZS9tNW9GSUJNcytHVjdjcTVXSGRaTEd6aGZtSEIwbnI5bWIwSll4aWxD?=
 =?utf-8?Q?4aloT6AdRKclI/ozLXlQEw2ZHoCzjJu3frFXGKCOlarRA?=
X-MS-Exchange-AntiSpam-MessageData-1: 2YOOqYHHf/M2Cg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4befb0cf-1572-44a9-8bf9-08df43f33de4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:06:50.6468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdSRUI6okr5gowaiUfmeSWu7Dx4Q36U+rGLOFu+7QPXv2jFKFt/D+w64/rzzlI/7yq7LTE/KsDo5lxlP/M7PPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

A couple more command queue patches for the r000 and vGPU work. Patch 1
allows commands to specify a custom timeout, as some commands can take
longer than the default 5 seconds on occasion.

Patch 2 adds support for GMC commands that expect a return status, but
no returned payload.

Based on drm-rust-next.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      gpu: nova-core: gsp: cmdq: let GMC commands set their completion timeout
      gpu: nova-core: gsp: cmdq: support GMC replies without payload

 drivers/gpu/nova-core/gsp/cmdq.rs     |  5 +++--
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs | 31 ++++++++++++++++++++++++-------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs |  2 +-
 3 files changed, 28 insertions(+), 10 deletions(-)
---
base-commit: 8045d0e7d208ad389a387f1407ce0db9070805af
change-id: 20261116-cmdq-timeout-6cf40c6afafc

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

