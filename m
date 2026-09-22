Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80BAC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2244310EE9E;
	Tue, 22 Sep 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdCWvOVZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6F110EE9F;
 Tue, 22 Sep 2026 22:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey85LsqZaGFqDWD03Anufwkm5u2TpxzU+AVgCiIXNeMX+XadRqklOP2iN5Mz1rhc7gYsLYZ4hWvuEySLfnD73rzoGaxl2CXregY+4ClkfmafWONMsJbJrvYSc3Q5VGeb5iY+DXU286tSomwHGudxUc3WoC10DxUFF2ImwwmxCHQiQREXk/IgPF/u6x9hnk2DnFEwa78vIMtUyQD5e/61XSNp7PMUMaOmNUKtPCxX8h5RuT9A61IUXhoQ+6huxgnyCE+Q4mr/PHjkRCXUaduq3SkVpAsiF6HDFmWX3PySY42WtoSLh4vc/OaeIfpIAAUJ1oE1yDnIG0uHahx8pljsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KBR8TkDnRJHwhHj4Q+cVvmSI6KJBBvUoA2EmU305QE=;
 b=HZf+Z6w7Mndzx1I9FC2AOEPUit5yRX80KcPkVT9OWILgUeKrYqCelro4yfKoCjcPVvcd4PYFpCsnnl7OXhr4OhRRn0EhtNbaJao9HaDMmo0XJT2n8jn3K+JwDwPaOeEC/HXgdOQhk8nwqhCYWptS92I7ctKpmkLqJyGF0HU6RpBy+TUg5JrePzmUDyiEiMuh/xDIgUtlGH+VuJrfmG7aramVZ2xFIieq4++zeNcAIjALDNtb0Xwa35jIc2i6f0HGVqdZu1vgQe3vLm6RUCIz23DbzWdNcHyWKpJ44bLyfe5SYBZGZYXxHWohXhZZ2g78EK9WwFhEdpewvw5G/TYEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KBR8TkDnRJHwhHj4Q+cVvmSI6KJBBvUoA2EmU305QE=;
 b=HdCWvOVZvdcOMkoZhZZRltE3hX35CgFiSnGPGy8vKSLk91dTQM/DNl2NhewJPpqQSNYOZtJ5F73AFhfnS+tXNEr1j0q9suT71w23Sjfl6rx1saXOdRDcnuEHFHGH4PkHI5PHQKESW2YNk6UtW9R0qBpyQ+so68Q2xjExEfaQcruWDx73gQGlrgNj5QX6Fl9kF1TiNqH4feRRiwq3x0CrYLifO2DJbco5/uStP5ShdiphJrbD4/AzEih96I43TbTI8x6sEZ4D1thv8VW3yfEIVC/zk6HwgQ/3mNDVog8QZSEKVqaAlur6b/nHV31QNIfxSi1JSdvSGK7wDyyyH3ze7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 22:27:34 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 22:27:34 +0000
Message-ID: <c2b28c18-3717-43d1-acba-05eaf9b1b9cf@nvidia.com>
Date: Wed, 23 Sep 2026 08:27:25 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/12] mm/Kconfig: changes for migrate on fault for
 device pages
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-2-mpenttil@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260922053421.4092027-2-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEVPR01CA0058.ausprd01.prod.outlook.com
 (2603:10c6:220:1fd::14) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: b03aa359-d7e8-43e3-127d-08df18f8b322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|11063799006|10067099003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: dmWWs2iQnALm94QnNqm4doXwuHYUhjbGi1jTzUVDP3XVPo3l0bzEumpxsDpZd/utw0NjzllUinMG8LnjPFwqxPFJ4sgXX24FC5VRu2LblAF+LENKppe6+ohUuwChgWWdoKn2EnHn5qH3vd8fAOw42WVx8QWrODmzMxg+ojpSUxpxNe3NKnoXfgSpWkLGwU8Eu+TPhwfUNDvLcReDmprrQ4NK0gSEnWd8iFJ5cOUfi31KN3pUVNzmMDYC8kM2wE1w4URGxRrKTUhYChbIsfoiKHLfruBVCaDpfgtoyjnxajzoZ+QJXevEwOAz6WsMR1zmWG2Pjf7LjXiLGcj9e6gZkmrQQUnEJOwShg1P7WdSRKOLbiImIfWYSJnZx+pDtVpASmYac+tEtp0jDLAictgCSzS1DMGjw+Zj1AfShlfqnbehJSmJCapk5KO2Zc9hmfSOnBn62I8sANhu1SNZE69pXW2sZvA1yfwIT0Eowxnqwwi5AQE7p+54HjmmQU0JtaadZhWmBKHx5D2mBJdTb4vMXIbPYp/SU0wbbOCsLrEhcBWW6x5nbLFtUK0eb9oVfKaErKzYzyDwd+NO/7Xjwi2bweLSQRJnvlVm/NUhIsUZtr2YhfuM3UMJLykJYJb7IUCAiEqbfghAY4jvVNR5JHBzhIXz4CXfmGLIHPExxo/Ta54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9730.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0lMMDFybGtxN2FzMnJUb2I2M1lUeWxSbVRrRW5CcWJvYzQ2RmtlN1c4YjBs?=
 =?utf-8?B?amU4N1I4NzBQbk1tV2lYaXZvSTcvdnQwVmt2Q1hnQzhmclNERnhQTEZxc0F4?=
 =?utf-8?B?bGRVVjJTWXE4WU1WYU0vNTFCdHhWWkFvajJvbkQ0dHhXd1lpbXJmemJKelU1?=
 =?utf-8?B?MDdURDdPNVp5VTVDbDVYSDB6cjZrQlIrcjBrdDFXUUJ5YnJpMnNMNTlaNDJW?=
 =?utf-8?B?R0luN05yTzFHaHFYelNsU0E3MlNOcXFWbVgreUphZFdLVUdaL3hnN3crZ2tN?=
 =?utf-8?B?ekVIa3BEMDlkQ2pQMXI5QklqUTRKTDRuUXhwdDI5RjlxbmpJcFJ1bjFiY3lv?=
 =?utf-8?B?QVBrZ1lzM0hFM0JmSzZycm5kV3FyZmpzcS9QSVN6RGpEaWp1ZGFuTEJGNVo4?=
 =?utf-8?B?cEUyTStyUWRaYjZxQ3pFeUIzRkRmdVpENk9VMVZFdlN3M0tHQXZoMEs5dGtl?=
 =?utf-8?B?S1YyOVdWU1AvUTY4eTdSc05Pa1YxZ1RXa2M0QWRQV1N4dlpybjNOQzZ2enZr?=
 =?utf-8?B?aXdBM0d1MzNEQlJDL1R5amVRYlZiMEVtaUV3TFB4NHFFYi9rMzRrU2lZaE1G?=
 =?utf-8?B?V0wyVzk2MWhUKy96bjVlUkhwUHlpeURjcU84NGh6WTlEMHBnQXNhZXVWakxS?=
 =?utf-8?B?bERqQ2QyLzFza3MzQXVpbUFGbnk3b3F4UDRFL2lKN2xZV1N6VjlLeU9iUmYy?=
 =?utf-8?B?K2o2S1lrZzlES0lYajVGZ3k2OVBrRzllRUl1ZDFKVjNtZE5xUzloYzRPUWkr?=
 =?utf-8?B?MWh5S3A5VG15eGh3WEU1VG9MNXg4eWt2MWpJcjhNdUZ1NWtBcnkxeHdTUE1o?=
 =?utf-8?B?VG4wVjlOMEc1S2ZVYWtmL1VWNjhDWW1IbXdwdHlmelFPMDFtU3o4Z0Y1Y01F?=
 =?utf-8?B?a0JjMnBXUkd1MmJEQUV0elNqVEpUSllTdWFzL3h3TmY3L3Y2NG1hOVluaEU0?=
 =?utf-8?B?NS80Ty9JQnVLQlM5OVk3QlkwczlEUC9PblZyUDFKWnlKZUsvTWwya3RacGhC?=
 =?utf-8?B?UXNYUXFGSTIva1dYdFBCR29pOENkWmFMVFEvNU5CSXUyZCs5S0FpQk1lZ3JV?=
 =?utf-8?B?VFpBb2g5bGdSa0x2OFFDZklUdUFibnpiamc5WEhmeHZGcEpEN2JPNTdRS1Nu?=
 =?utf-8?B?dmF6czVZbDhjemV4R3dvOWd1M2x5NmN4VDBLRy91VUxDSGFyUTUyWUM1NHcz?=
 =?utf-8?B?M3dkdU5LR1RVNEJoRjlqMXBRempwS3hHQytUQTJhWGc4R0x3L3g1VlBTUUZL?=
 =?utf-8?B?Z2ttK2VFYTNiQUFHUEJ4SEI4VXlOTXczTmdVRnhqTU9tN2VzY1hIWCthY2J1?=
 =?utf-8?B?eXRZMHNnZUhiMldFVUhDeXJVdzlESFhzVFg4WHZDdGhmM1lwRHZmbWhwWVdH?=
 =?utf-8?B?QVc4V1NFRjE0RXdGV0hyWVRjQXd2dWFwSkxncGlvV0tHaEtqU0RqM0tBc0dY?=
 =?utf-8?B?NGFnTWx2TEZrZDg3ZFBhS3dmQmZNMjFjRjE4emd3SnRFM0FMODM4MHo1Ym93?=
 =?utf-8?B?cm1VV3EzMEZQZ05EMzczbFJGOHJKcWtiVVY0amhuZEhtQTA0UE9MZERIeFRl?=
 =?utf-8?B?UjN6Si8yUDlMRE03Mmd4dlVwbmsyMENYckMvdFlMV0JLNysvU3FtdW8ySDJn?=
 =?utf-8?B?SDVsNUdsZEUzcFE1c0Q2U2MvY2xsRkJuVGtuRkpMcVJSajlYWEZvR2l5OW5I?=
 =?utf-8?B?SDlkYXdLT1JNYmtnMkZyVkw5Z2NSWEkrUk5EQllCSXhVcjlYcGFrdndBQ3FT?=
 =?utf-8?B?MkVXTlBzdEJ3U2RHL1pzQlFyRXR6TlJJRWhNUUoxaG04cDB1c2xteDNpbUF4?=
 =?utf-8?B?OG9GbFh6SzNVd2NjT1dJZ2VGblBWVnZLeU1UTjdyYi9MNzRzUVRoOFpCWEVk?=
 =?utf-8?B?Qk90YWIxYzZDUjl5WlA2a0ZRUFBNcThIUWVpM1lzZkhOZkNOZUhuWlNXcHNt?=
 =?utf-8?B?RWFVdk5kWDlLTGNEM2lzNVo5NVdoalZCdFFVMVpxaW1CbngvZE1MUm5HcXFR?=
 =?utf-8?B?TTBBSVorM3kxWkNTOXVhZTlkaVBRNnlrL3llaXJIZjRZaHdlaC9NSk5wRmZh?=
 =?utf-8?B?c0F4bksvbEVKbVA5WkFZWVQ2a1VQcWVaelVRM2xraXdZclgrVTcrTHJuRytI?=
 =?utf-8?B?NGExZzY3QmdBN08ybjl3L0wvMjBqd2tLQUQ5N01CUG9qei9wVC9FaGlzRy95?=
 =?utf-8?B?WCtJM0pySnNLVkszT1RhdUs5SXpFYm5ObTZibDZaclAvVlVLVy9HaGVwRnBM?=
 =?utf-8?B?VFJzMDF2TWlXRElWTm1uNWVoQlhEN0c2UGFKYlZQMEFDczRlWEE3bnZmYkZZ?=
 =?utf-8?B?b3ZHZmRSK3U4Rk1HRm5hSXhwRVc5YVQ2S2JUWSsxUVRlY0JBdmpZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03aa359-d7e8-43e3-127d-08df18f8b322
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:27:34.7185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9cLUv30rl70FcE7bha9XKhDGvoXVCk1QHv4O0mDhvOe4tqLPpdZi8CjLuVrZAUn4kK41VK0psAHpVxuDCm1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795
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

On 9/22/26 3:34 PM, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM depends on MMU notifiers. With the unified HMM/migrate_device
> page table walk migrate_device needs HMM enabled.
> Enable them explicitly to avoid breaking random configs.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 604c58199acb..b7a485beb9a7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -687,6 +687,7 @@ config MIGRATION
>  
>  config DEVICE_MIGRATION
>  	def_bool MIGRATION && ZONE_DEVICE
> +	select HMM_MIRROR
>  
>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool


Acked-by: Balbir Singh <balbirs@nvidia.com>
