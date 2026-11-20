Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1260A3803
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sOMIc4ti
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E42D11240F;
	Fri, 20 Nov 2026 05:58:10 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372FF112266;
 Fri, 20 Nov 2026 05:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0DsyJihvLwMAKI2layb/0tK72/mFGpwJXRQMQhOVwU1ED8MJmfUngAjJkNYUK2T/KN8vWMx2m31A0rpD+YwczQ9nu7JOMyrWNyJtEFpe61PVYqQu1YzLNMWo9ZkY0Fi+X7UvvrgSGVYI9DSR59K+KmYjXJ5iYtM7rrn21pXAuuYXjuQbBfRW83bxfCFcxejhOzdC4VNguHBsKbQex3ks5LNOjQcEk9U7jukhMMHcYQzTAg9rp7L9WcSZpzyHIn+Z13oC+JSlpRSQbBsmL9daCPN4YJ4RlMc2scrEXMSP2BaBBNT7o8Us6DFGAEiVdDJeQZWA92CbVE1eCC9PRi5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miasQfyuF2vT5ft+SaFgUytyG9txbYZytPvtlQXA18M=;
 b=RyvLh0nj5TuV5gfbP1nzaJsNuNOuOkdB/WXc0o4rem1ZkAL1vfjOgKQTn8mipTVdXYxykQkhhDKTZIoDLXeXk+CEnaFh9GsBlul3W597wUviyXJ8fE9iPgZwpVg2AY5kgv1UaeuISsoR9Q91nDoNl6332OYa8wqvgnfIqD5AN1AVH4QWV2XKtB7tg15m2LxFTaDSS5BNlHsHYHbmMMxxGldZBJuCxIwHxszLWJVwx7SRMBUtzq+mxJoghRwWvuKTQa0hcEyVwNFjQ8rC+6sV1Sr1z3u2cDdycYA0EfsLIyZRnRqY5I+94hxVOl+VPPict+S5hY0VUlZCWaAZJfmevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miasQfyuF2vT5ft+SaFgUytyG9txbYZytPvtlQXA18M=;
 b=sOMIc4tipRsQaS7keKSkUfUQNU72KuflcfCUc5OoIiuGdo6xlViVJ0RQrN9J0QiFfWtPShXDqwAe/jdRt/Y4Zt+8FOrxYp4J4VZi/zsr7AqbF5+gLi3HOZ46aRTcnryPM3F/WdCbs4sIvR14OC/jv6qqI0lW8A2f/K2qmvCes46Y/KAPGvoxzNbx4Gdf9duMvXihbiTgaNL3skE49czra1Fz2jWKGo92iSPH0f6vSCwV8E3E8uuzd9e0bBjvJvolW0Zlny8nngFhoZSGjWU8HV+rWgApuj8JHEzy7B7/4RGZeYNTYJt3WielOmvccqP02Rk+Z2X+7xyZxxu272zWug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA0PR12MB7675.namprd12.prod.outlook.com
 (2603:10b6:208:433::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 05:57:48 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:57:48 +0000
From: Alistair Popple <apopple@nvidia.com>
Date: Fri, 20 Nov 2026 16:55:53 +1100
Subject: [PATCH v3 15/24] accel/ivpu: Convert the userptr exporter to the
 SGT mapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dma_mapping_type_v4-v3-15-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
In-Reply-To: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
 chaitanyak@nvidia.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795154186; l=3340;
 i=apopple@nvidia.com; s=20261105; h=from:subject:message-id;
 bh=o11b5hDr+2m1dVlSlcjvCsYnPYvCeKqnMuhmMgf12aU=;
 b=p8s1hN5hjrBdRHDkYFWEIgkLExTkMPeCWRF3Oo07DHbf3KL28LXafecAgND2eybJT4sKF2w/L
 +PhuwhCwqpQDehRME9GkAU4tEPCNvY+amWi0UePkCdQAHC/Gman4RwD
X-Developer-Key: i=apopple@nvidia.com; a=ed25519;
 pk=WdWPT9rAq3YNfXldbGv1NSGVLGxzQGFGJvRUiShhNqs=
X-ClientProxiedBy: SY5PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:10:207::12) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: db585d38-3fad-4b78-c419-08df46cb3449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|921020|10067099003|11063799006|56012099006|261021123027099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pbv8+dxn/gIVfYlpBVzrMSSX/IgGuOaGVU1HLpGTkqU+3nMPP0f2JI4VCnY05c0shLFKC/2pA9oYHp1dAHV7iJp9qyP8lOnHXQp65z5VMCQpjwBpg+G9C/j6KodRGQiWPJgbWLBnF3moqiVmlS+kzrVvM4b3LSeP41yiQQG1YBOLU7ECvF0UGFMse8cpmQlXrQzwcfADXgGHc4evVbaxdvxVBgA2hbJbWrTxy/Vbmmchci27BXo96tKDqKJcyuFNYHxKTqxfq+goowlviu0or5HuCuYHEsMN2jmYOreqWKvda41CDtUySV87AdgNgjAxyMsB+mFhd2Fp9gX/X0zQXFruEn1mfByLEh2HXnr/FIz8p70ctKgU6HeEltGdSO157ZoxyQPPzMhQN3lA/MbnrJWVRl6fV/4H+KCrXbkdYqH4l8zZgGXJ8zDWq0AH8C3lmvpXpX9UPAPoNQUNdFqoIl64JJ8PgpHQZkk84Y1IWlsM0BpalL3/ksyb3oPUabmXzOlfeok5Iu9kNwAPfFrhPjnpScHrEYQgzMFTroBfeQVhfDneJ37j743sSlFfI83iEcIJFRN7r0IpjG+ECLG1uC1IB3kKi0gIvkZwMzZ8BloilNnwCWR+xWkatzhMO7DK9hrsUJXpewDDHieHJVFVqaJ+Gcmw4DuNwP4WEhqw2p0c6m0xfBcj/1AJHJsQrpu8QJo0SEXCAH6fjsOxZwZJKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRBOXk0ckFqbGxFRENDbGY1OFpKckplbkxvdGRNQXBhS2pUNkZ4VTIyL1J5?=
 =?utf-8?B?eGprUU05dFRhOStZcDZibGJwSDdjSm5tWnJ1U0hkeHdQeG1QWHArbmZPbGRM?=
 =?utf-8?B?ZzNYNjFKNUp2ZDdDTzd5QmFJQWs5aUdtVWhRWmV3cVN6UW5ZdEtDSXdzYkls?=
 =?utf-8?B?THlQU3NlWXNmUndGY0dYUTFrYkZwSW1EN3FCV3RKaXo5VXd3eG9vZjByK0Vi?=
 =?utf-8?B?K2tBWkx3NWtkSTJkUEZFSXRNMnh6T0R1RktDOVZKTTB5ZG85K2E4cEJjOVk0?=
 =?utf-8?B?SGt1VkRrMWFxZ2sxQldXa0JBYitFNERwYWNzRFJ4YWx2S0RoOTBDVnhFN0dU?=
 =?utf-8?B?a3VWQnlKTjdIY3J2eWJTcU5IZ3AzNytLdHFkZWlLUmRBVmg3WTRHZi93NEIv?=
 =?utf-8?B?eko2dUNpMVZmS1dkNVV5YXdFTGpvNUZHNVZsc0R3Y3NKMS9qeVNjSnZuSWRa?=
 =?utf-8?B?VTBrZWgxaFBReUFoRDM2bmpDTERWY1YxRjltOGQ5allYSisrQ09wemtEZHE1?=
 =?utf-8?B?a3pTekZVQW1ucmZpbDFqSjF2dzRhWTBpMzNSK1B1b3gwU0x4S2YrVzdKSFE3?=
 =?utf-8?B?UktoZ2M5V2JESGxna1M3aEdwZHhhUGNVc3lhWnBoQys1VklidndrNmFRMWoz?=
 =?utf-8?B?Zm0xaFdYS1htZzF4b0lZMGNDNERZN2VaYTBMekcvZWpMd3lpY0wzc01WL2xG?=
 =?utf-8?B?TWVXT2ROVm92MjJxMkIyT3JNZ1lHMU1IeHlJUnFqVVFnVXVRMXYrc052bHEy?=
 =?utf-8?B?eWNTMnVLL0ZIOHlMTWFRSmkvVHE2elMrRkxmdmQ0MjA1VmdOMm10VmJVOEYx?=
 =?utf-8?B?Z1VZZ2J4a01OZzJGZCtsdmYxbC85bEo0Y2R2aDZMOHRxK2QzTnZrM0VxQnRC?=
 =?utf-8?B?VGVwWExhZW1XaVNXdGxDQnFuYUF3UXcwSnREdCtXYUoxY3VKSDZPRGU0UnU4?=
 =?utf-8?B?OWJ6QXZ4QUZaa3JtbkJoZEdpOXJBNUwwZEpQSHJJWVBtVEhtWlBaZ09TYVJN?=
 =?utf-8?B?MngzVW9zTmdpU0diOVN4ZHg3T24wSTl4QjZpVCszazlvTk1NR0lCTTZnREh5?=
 =?utf-8?B?S09EK05GQ3FHaGxYMmhGalBkS1FJTFhkbzJTTmx6TUh2dFVqMHRIT0RrRVd1?=
 =?utf-8?B?bC9icm9XcE9YdFBlN3NRMjZFbHNzWnM3ZlArWW5rSWlwelU0NVZtODlWa0dq?=
 =?utf-8?B?YjM2Sy9FdEN2NVRZQkpXMjRkMWxOVWhMQWlUL0RsNGxwVUZaZFdXNG1NNXNT?=
 =?utf-8?B?UXpQaXMzMVNCUEN1ZVpLYk9FYndseUpNS1hvNUtCNkljcHpLOE1DWnRjVFBI?=
 =?utf-8?B?VWk2QWFKYWFaWjIrVG12R0oxQWtubm11ZkxGRUVvRmRwWnRrRGVScUFrcEJZ?=
 =?utf-8?B?Z2tCcm85ek90SDlUY2dKNE1KZFcwcnN5ZzRhajFQVEl0MmQxd2pDRDIyeGNo?=
 =?utf-8?B?UkQxNlE0SmNrUk52OG5ibnZDaGlhWmczNkwzUUZPVFV5VzBoWlMwYzlZSlIw?=
 =?utf-8?B?YVFBTHFRWjFWdHZiSzlUZVBvK2xTdVBUMUJGeWgvMVdRMW04QThhREFGMVNw?=
 =?utf-8?B?c0cybXI0RVMzSU1sRS9rVmRqZm5BclZyWnZZR0VjcmRTbmhaTUhEcHdkbnJJ?=
 =?utf-8?B?dXJSNE9JdUhzY1paSkh4MmRUN2IrSmg3akVNUzdDY29IOU9rRU9ZWWlRTlhE?=
 =?utf-8?B?K3VOUWZMcjZuSmJES0JBRjhvT3hRVzFTTDVRaU9BOUxIN3FyVCtacTVBWEFa?=
 =?utf-8?B?YUxoWnRheWc2SWdhMXZQeTJoVFF3ckVrc2FyMHVVV21OZlA5Vzh0aHprckNs?=
 =?utf-8?B?cERUMTUwaExBSHp3QlJpeGJGbktQYUU1bFhIa0pnSkJ4aGxQeVV3YzcvY3hq?=
 =?utf-8?B?RlErS0d4S3RoVG5yZWhvVmVIT0RMYmRnY0RrWFk0dnZwK2ZlQ1V0VUpoQWlC?=
 =?utf-8?B?N1N6MlFMZjI1cjVGanNRVjlXVmd3N21qenFtRDVhU1p1NmF5SWw5TVhCbnMv?=
 =?utf-8?B?NE9tN2w5N3JqYmplMFg0bnUrUW9ZWGo2YmlLOTFFclFuUkplSE96bXB2NHVI?=
 =?utf-8?B?VHlNOURyTVdhZ25XWmovQnZ1R2JYdFFVYVJrR3NmeTFVK3NvakpTbjRrU1N4?=
 =?utf-8?B?a0U2Vy91eWpjWnNjOXhEbTBZdkU2ZVhrU05EQ2x4RVArMkt4WlhndjFwa0Ns?=
 =?utf-8?B?ME9YT2hGZXJxTXN1ZHplaHM3a0tEUURkWHkvdXFrbUFZWnlXeVJHZW5zQTJW?=
 =?utf-8?B?Z29qUlV4S3VaaXkyQ0NpYnlKQUdHNWlzWjMvdE5JS0Z6WGYyYmFJYzkxdkFT?=
 =?utf-8?B?K05yL2Uyd2hhaEZNaU5wQnJZTk9tcjlrUnU4WG1hc0k4NmV0QitKdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db585d38-3fad-4b78-c419-08df46cb3449
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:57:48.1845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4OpcxaUT4y0RsU6MEsIFeQGA17fFtD3tyhauEErPv/NVDmS7lMxDDAKMc4N+AtUPRgUJBwZr9mTIfUToKHFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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

The userptr dma-buf keeps one struct sg_table for its lifetime in
dma_buf->priv and map_dma_buf() DMA maps and returns that same table
for every attachment. A mapping is per attachment and per map, so each
map_dma_buf() must allocate a struct dma_buf_sgt_mapping holding a copy
of the table header and DMA map through it. The entries remain shared
as before. unmap_dma_buf() DMA unmaps through the copy and frees the
mapping. The table itself is still freed in release.

Note that sharing one scatterlist between mappings is already broken.
dma_map_sgtable() writes the DMA addresses, lengths and nents into the
shared entries, so a second attachment mapping the buffer overwrites the
first importer's addresses. Unmap would tear down whichever mapping the
entries hold at the time.

This is a pre-existing issue though which needs to be addressed by a
separate fix - this patch doesn't change any behaviour.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/accel/ivpu/ivpu_gem_userptr.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
index 7cbf3a4cdc73..35e66b84a64b 100644
--- a/drivers/accel/ivpu/ivpu_gem_userptr.c
+++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <linux/dma-buf-mapping.h>
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
@@ -19,25 +20,37 @@
 #include "ivpu_drv.h"
 #include "ivpu_gem.h"
 
-static struct sg_table *
+static struct dma_buf_sgt_mapping *
 ivpu_gem_userptr_dmabuf_map(struct dma_buf_attachment *attachment,
 			    enum dma_data_direction direction)
 {
 	struct sg_table *sgt = attachment->dmabuf->priv;
+	struct dma_buf_sgt_mapping *mapping;
 	int ret;
 
-	ret = dma_map_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
-	if (ret)
+	mapping = kzalloc_obj(*mapping);
+	if (!mapping)
+		return ERR_PTR(-ENOMEM);
+
+	/* Header copy only; the table and its entries belong to the dma_buf */
+	mapping->sgt = *sgt;
+	ret = dma_map_sgtable(dma_buf_sgt_dma_device(attachment), &mapping->sgt,
+			      direction, DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret) {
+		kfree(mapping);
 		return ERR_PTR(ret);
+	}
 
-	return sgt;
+	return mapping;
 }
 
 static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
-					  struct sg_table *sgt,
+					  struct dma_buf_sgt_mapping *mapping,
 					  enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
+	dma_unmap_sgtable(dma_buf_sgt_mapping_dma_device(mapping),
+			  &mapping->sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
+	kfree(mapping);
 }
 
 static void ivpu_gem_userptr_dmabuf_release(struct dma_buf *dma_buf)
@@ -56,9 +69,9 @@ static void ivpu_gem_userptr_dmabuf_release(struct dma_buf *dma_buf)
 }
 
 static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
-	.map_dma_buf = ivpu_gem_userptr_dmabuf_map,
-	.unmap_dma_buf = ivpu_gem_userptr_dmabuf_unmap,
 	.release = ivpu_gem_userptr_dmabuf_release,
+	DMA_BUF_SIMPLE_SGT_EXP_MATCH(ivpu_gem_userptr_dmabuf_map,
+				     ivpu_gem_userptr_dmabuf_unmap),
 };
 
 static struct dma_buf *

-- 
2.54.0

