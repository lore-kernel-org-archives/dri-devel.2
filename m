Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D621606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HxFfmcz4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDA910E39D;
	Wed, 18 Nov 2026 04:39:28 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D23B10E39D;
 Wed, 18 Nov 2026 04:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdmFDC+cu6SFbfucLRg0sqlMAPE1+CNQDAty86toA6Hjww3Fqt00gwUqMHCzzeAnig4X3wgnP953kvYeA1dnSMW40Z7+uuA//QYnm22wlW4riY/04z2pIFVQ9J7Nlhb2Wv1Rps+uFbofoe+kQNWlYq+mYsnsUcHvYpIZuHQmUeKeD+udqzLU+s55Nnzf7vjVzuEa+Fkvoh38yeQ33hbX7jXGGwKNN909KoFAtA7DE82zZIgutr7BQFwgKNLffw+GVhHdpGteqmsQlbf630CxLm21RsDh3sbzmlzfGQENSuW9fHuhPhwWOcv82riGkRCDrfWNkyVPq9Mv/R1ouEn5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6+AgOgq2yhPOnHbPxeTUmLusGS4VqkM47hssL6/50Q=;
 b=XCoJB73HR4KQAQ3mevCtPNT2s6jtaWIDJjoaRP4CXr+p4S5skRNTLZewsgcnEulLgDf5etW6Lnoo/G7FGD8pEa2EUC9wSezQ9QZs2+pXWw6pEa/fqot9B1LSYNZ/01x00LhS1FCu4Hbc9ug3QBWOmzkwniuhR13pbK36YYm4jIsWv5U6M9xD6wAMYG3b5OxeS9jvs5ZZ7WTgmAQexVMUX8ECGzVdy10Oqj9n7WUQc5ubYwHOHpADERb0VuIVwbi8t9Q/MlYceTWl10o1tFAr9pldC5Z+KbeYwtZR30zw/pHP5WEd8JoZ7ohBUH78lx4dsINafl9zdJozWgfI9I3B/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6+AgOgq2yhPOnHbPxeTUmLusGS4VqkM47hssL6/50Q=;
 b=HxFfmcz46DIUuYL7wJdJU2UIHAkHsTdpZ2iPBDYH+O9whGr1RtuJZYmGjqadhPo0wCgO5XN9H9fv6Zj6k3OQYxsK8hFys98aeU46LYCpGCQMhHh23hDjTxkEVNbNs40K8n9IAYMGAedWUF3WiyrL0iOs4P2skk9IpXU5ktY5dA6u9BAsOKmPsrd8GE3ZsMCoIOysmkUrXNzzDyjsNCJFceN8MNRiPQC4SQo728sei4ANutoOWjnJ8YjR4PemTAsxAiA0PLNi9kypjtG8C9q3bQb5aktHkKCuooJgLQKcy1sua8GHykROsgLoVM0qAMZq55UMpwf7AyBbJV+OQjFR4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB177419.namprd12.prod.outlook.com (2603:10b6:806:53f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 04:39:19 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 04:39:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 13:39:15 +0900
Message-Id: <DMY25LUR06IN.12TGIJCIFOGIU@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: gsp: cmdq: support GMC replies
 without payload
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
 <20261117-cmdq-timeout-v1-2-4b50d0be335e@nvidia.com>
In-Reply-To: <20261117-cmdq-timeout-v1-2-4b50d0be335e@nvidia.com>
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB177419:EE_
X-MS-Office365-Filtering-Correlation-Id: 28985352-6e0a-45eb-2c74-08df452de8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|261026121527099003|261021121427099003|261102123227099003|32116099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8CAugIH/vULxvMHsobuicG/+r7nMUVE+pNLFNkopJ7y8UCUaUas1uwJIS8NrKPM8k6s1+EbVma13pm37JjDakiHzORZmG74OlQeWxh8JUyTvq03/pRbc3idWoc3zGaArn3xVedz091nW2KkVXAAjurcr2HNI5Qc62VmJvKfEZ+oKxiZ9Hwp1ZYHcfMvcdgrQsK2jRDIjUt5AG2dDiiR5DuzeQXHQLZiU6UcYCRbWXRfIEN2vEcuuVm0AoeXwDxg7L0OFT5vQWEPMRaBlkZn0u2MYxyEo97JOecCxDlL9lyep2NlOB3htYawS+CRrv2fPTRb8+raI6Ueie9IQv7jw72BlcgBI1rottclWLguPIvCboumAbk5ODwy5KPy/xa6kaCAovjyYyQ2XHKHWmTbaqOg/co0skg0UohVNAisK+3bZdl0XhTKOVnbh2pMzhLzcNYZY8wVedWv1QNJn1B+JeCx9X1WA9biJnOnWmzccKwTy4+xnMz1JDlof1QYq2Y7jqaFDRX+iAo2IWod1YGe7pm3w9csJwqhzcrIHA5MglzBhrxGXhjnbK1pO/4Du50vsaBzU6BHyyh96IiygjkmWaxBZJAwM3TR2zgywLPogP7aDgEFsns8XW7we3VYmu+DeRlBQkRfF2RqsiHTDGO/09vbQ6rw69y00rLeciiSf8qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021121427099003)(261102123227099003)(32116099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG94ckNZR3YwRTJnN1NWSjlxUjcrM0kyNDROTnUvRWVxRGs4c1phZWdSbHVG?=
 =?utf-8?B?RnRweVFDeUdHMGpsSEY2b2kzMnZrb3YxdEU4b2FEekR3bmI3bXAwbUZMemQ4?=
 =?utf-8?B?dU1kVjUzWGYzL2l6d1JDMDlHeFF3akh6amhMVzIxYjEwZFh6YjFZOG8vQmt4?=
 =?utf-8?B?ZUM1eWRQdG1ZS1NUVjVZMHdzaTFxaXNSbCsySTRkTHREbXFac2w0cExpV1BQ?=
 =?utf-8?B?RGVQeGtpdmQ0Zmx2VXR0MkNxMXRqZ3VLWUJ0ZTlhekVscmtEdGorcVlWdHhs?=
 =?utf-8?B?Rm1VNnBBdUVha3doK0VFK1U0TDVkdG56TUpYeHVjRlBZdlpWcmxuLzd1Snll?=
 =?utf-8?B?NGJSMzlTeG5HLzEzQTVSM25XME9NazI0UTNVR3B2TFpraVpiTldYQUNXOFd3?=
 =?utf-8?B?YVZ1UTZabHM2VHkveWNzUy9nTFdSNHFlcWg1VThkMFNjWVAzWTN5QkxYTVg5?=
 =?utf-8?B?cE03QnJqWFRMWmd0Zm1sZEVZdDFDS2MzNWVMbVZBVzRTSmZQYU9IS3RhZjlz?=
 =?utf-8?B?citLTktWaVBJYk0xWVd0Y2pHMXEwa3NMSU9xTWdmeWhQcjF3R21sdEhGWTVQ?=
 =?utf-8?B?bndSbHgzUU4vVHhPZ0FoTVRDUHBwR0RMdS9IaDAzOURtcWx1blJzV2FkYWV0?=
 =?utf-8?B?YW5MZ0hhMWgzYlJWUFJLOVlqbGF4dkVuUUJKM1dwS2ZjcSthZE9OczRlM1N5?=
 =?utf-8?B?aXFiV0l2TW91cGNsNFJQb1hnL3VKK3dhKyswdTZ4cm1qSzIzeUNGVytlYnhV?=
 =?utf-8?B?cFdYanl1NENQZnZUcGJ4T2dIRHZVRjl1Uk83ZGdkUWVQTFROUGUrbzRmRlA1?=
 =?utf-8?B?Vnl2MFlWNEFNaWlOWmR6M0VQd3RORVBHd0pxcGlKaHNSVDNGOEJTaWRDZmdQ?=
 =?utf-8?B?bGxNZDM5UG5ZcnBZUlNzRmt0OU5kbk5uaDZudlliUXhXekhFWXlvZDVFaEk2?=
 =?utf-8?B?NXlNMG9yWk1veHpqNVFFRzZsdHVkdGpPTG1KQkVVMHRvKzlKdE5vS05DT0cr?=
 =?utf-8?B?bGNabnU0UTlFc1BwSTgxSlJOd2J2cUJzcEFEQnYvcXBkYnBKSjBIbjFrVjU3?=
 =?utf-8?B?Yi9raVVLUFllNUdFL3ZZQU9KVTh4Sm1zbjdybDF5RHZib2lvR2ptbDJvVEY1?=
 =?utf-8?B?SXFpbXgxT1RYbnNiUnVwTUNBbi9IQllUUHRKN1IrOGordzJCeEFQMzdxanE3?=
 =?utf-8?B?SFFoZDc5UlhqcHoxbjBRNmUwVlFURjNqQnRJMjdEWC81T3NOVml5amRHV2o0?=
 =?utf-8?B?TGpLT1Q4cnAwOXlMblBvL25yNnd0ckcwV3grZklETW1LYi9leEZLVUVMZHBl?=
 =?utf-8?B?WFJIL1k5ZkZRZUtYZGhtUEU5STNwaXBLR1VXODNaQjVWQVNGWHJsU0R1QjI2?=
 =?utf-8?B?VGZnS3NIV25ienBHR1lzL2I2ZHpwVjR2NVRWS21ZMkFhUlZnTmpHVWNaVTdI?=
 =?utf-8?B?Vzg1VmpEZWFXcGVuZWdBbE9GbnJxRHAreVlUUmp0OXErd3ovVnJWdHhyNjJ0?=
 =?utf-8?B?VW8raTIxck8rTVN5SThwb3lCNzRCV3pnNHliMjZpWTVWN0RlZllBY2pYN3dT?=
 =?utf-8?B?U2lrcDJGTUJCdWkxNG05T3BkVjFJeFlBb2JTUXd6Y2xvZkNveHIxR0IwQlNP?=
 =?utf-8?B?QVpPNGVrbEpJT2Vzd00vbWd1UWFjNEJ0N0kyaG1yYlV1elN5TnQ0ZVpEYVJh?=
 =?utf-8?B?eVc2UEY5ZE9QSjRvVVBabEJzeXB0KzNXQjhmK1A3QnpHNkxVak9mVHlLQ3d0?=
 =?utf-8?B?VzVIdEtSUFVwMVJ3VXd2b1lSRUJla2UrczNsK0RON0piVGlNNFRVc3NFUjZv?=
 =?utf-8?B?Wm43SlpGcGpkUXhHV25RaWQyWDVzLzBJZ1Y0MnYyRCsvdy9lZzhSeXZHV2lN?=
 =?utf-8?B?WSs5eG8wOXVrUEU5M2lyUDM4RTdFa3lKWlQ2WElFakJSd3ptR3JlNW1wQjBa?=
 =?utf-8?B?ckdhMGF1cmV4V3MrU3JCODd2YzVpYzFuNHd1a0gybmF4bHZKdWVMUksvZytP?=
 =?utf-8?B?UFRvb3NBb3RTVFNQaG9VYTZIbE5ndFNsUW9TbDFmemx6clVLekpQUEl2dE1i?=
 =?utf-8?B?QzVSR3NrdktGK3J4NElDVE8rczRsUjRSdkZ0d0tRZ1EraFdDdFVSSE5XcnRr?=
 =?utf-8?B?RlpSWjJTSFIyalFJeDNVQ2MzZGwxSWdzcUl5dWphcGg3V0FHaHZucjAxZ1Nk?=
 =?utf-8?B?SDNVOHF3RTA2cmlkMTkyY3VmZ1RCbnQzeDZHK2FZWDRsN0dmOFE3U2ZyWG1I?=
 =?utf-8?B?Tm1JWCtwZnlYVHExbnVsTFJCaFdNSHlhTVpEOFlJZDhaa2ROVVZMaUdMMVNY?=
 =?utf-8?B?aE9WQmR0TDA1a2ozNFBIWE00dWVmYWhCQXVDdnd6K1F2VXRhQUtPL0RnNERz?=
 =?utf-8?Q?mLL2IEuVmzrUkdWgAx2hS6oERJw6c5ZIsvy0Y8QJzyrCs?=
X-MS-Exchange-AntiSpam-MessageData-1: rLhRdLZGapeZWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28985352-6e0a-45eb-2c74-08df452de8eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 04:39:19.5347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISI+z57It74HKqnFzUY1nswv/maJ6q/xRmoXwgdWNWDdlcJAAHcwPLGtVb/hfCOqElLxU4kHTxwgkiPYKv6F+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB177419
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 12:06 AM JST, Alexandre Courbot wrote:
> Some GMC commands are answered with a status and no payload. Their
> reply type cannot be `NoReply`, which marks commands that the GSP does
> not answer at all.
>
> Implement `MessageFromGsp` for `()` so these commands can use it as
> their reply type.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
