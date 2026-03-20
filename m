Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9051098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E0910EAD4;
	Fri, 20 Mar 2026 14:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GtCcfqT+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8628510EB0A;
 Fri, 20 Mar 2026 14:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSufMCa3ekN/JuTZiyQCvQO3mz+cnvCopo5s8CIv6K0MYBwPrvAjacumvANettQPzfEWRzbQ5ofG3WE3I6SCDzRofDjLxxFBTKfsMACM7DdWfSbkKaZ9SKK4LTaFiZ45OsAtkrnWBw1ieXoO/wSiouaFulRYDJxBR8SO1FH3vcTih6iqcWa6xxzGmMKYCUUvD450HYjZvbsM6f1HU9C3FsMOt0D04cgTV5rzBcAIr9gVheK1k4UBhsCZ5x/qiN26lu2zHV8j/U90IAbGWu9gaEsAPPZOh2SKAULGPh4FT8uaUlT2zrSwXXJmSd9bh7Y8y5MuiOTdtqu57GJujmu+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gkdTdOH48MGlaB1AzD4BjdGFi6F2u4CN2UO59pY4mM=;
 b=gx7lLBK7LVxT7yPUPQ1c/rQjjoCJHL/QMi8FRv9sywGjTAuuYCZ2DBooGQXuIUeH1ax90KwtI5olpX3WFZgcNdimz/ebi/xjGouMygOqNTmGVrBpH7Uvx+78s6yg5Hx5a3Fgr+/ynUXLoPiyeOwkoDzV11G1t6FlmC715U2RGfJ7kIdx/O+exDcoFVwbKm5tQrhTxiwnVw0RAERVS5ciLqvDVt1w+m59C8lPQvktPwninSFo1ZLTF5m3L1nEjt571wEauxKnLCi5aPALx8uGIKfHqwF2HKhwPpJmItVlM5XuWY5LFSQnS1MIqhBsho3DC6r+/uSFpZUCFe2/T4ICRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gkdTdOH48MGlaB1AzD4BjdGFi6F2u4CN2UO59pY4mM=;
 b=GtCcfqT+bSakhukEIABRgzkh0m5dT2jny/EAQyoAS/LGLIGRWDNCTdPUMNnEsfyFjUp3RfnCdniYR2/NJYCZD6QplvLhDHiCq+KJJnEhmmHXUh6aKNNfC9Plk914LPH8az9wbl4uLm8DXbnjScPv5PlkdEH12ht8iOWQrxRxCAmRmEsCPEX4QSCd2mCHXGfMbnSIbYxT7P6E1uS9uBOY4cX0xCgr0BMdKk5fB0n/aarVO6gaUXhfAXy7ftAyv//Dbc5ZzmMokEcOZY6/i9mABFpZDTjIy/1Xd36EWS75Fvt4IrQC39HGGZe56ZC5hEJwPUG+BBH6mLm7KV3kmgBzyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:36:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:36:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:36:07 +0900
Message-Id: <DH7OO7VFKS76.2RI3YYJ7MEVXP@nvidia.com>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] gpu: nova-core: use Coherent::init to initialize
 GspFwWprMeta
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-7-dakr@kernel.org>
In-Reply-To: <20260303162314.94363-7-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cc914c-0df8-498c-4dad-08de868e07ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CyFsyF8Pmleni2VDWnIIn2zYY7E2x5nRl+jXkokYJEC3VQY8Xw+sFn2vx6z71JM7ttVUC7/TM6NJcCQQFbnO22U3AJk4U1gdzQMti+6OU6aWbc2pZxfwGgcV8mAXHec/3C6PKwFJskkV3j8oddfzi2WJ+HJAjQm5B8kBseHbLtaHswhEJ1CROJlEk/np1Lqkq5fuYW4hF+BmKr1WphshmF/n0th+ANH+HqwYqpbIIZDEi5Gl4fC3OgZhDw+08o9Jj5nfEQ453BqEH6mAJFII/9nNWeC0BGijPoXHTPI6f05q5T6jvKyUXAkEoHYui4Jx77gA4MUP68vsdP+EAtXD3GrGjbrqreZT2hIr9b/4Ni5hfH8qofJznL7WYf+lBZj9APvDkTNvJ8b0BiJOWvXmg2TuP5wk/SIgSgprC/bgcSjGhJqF9EHCQWwN3O3yV/4aADCdmemppaGfaajymPJ20F9ZsuXvDx7GTonqk+ki/nXDY30Coegev/beQc/veD/gEIF3XTb3HQZ1wJFLmyqnSTUe5e2dO8+IdICkXbb48pMc/9KKx9sEctDzG616hpD2Ujf8r3F1QoD+ux9O3W9l1k/6ciePNgKtk7fulvPrmf9BXEARK9Mi/h1xkqLydo8NNYwwMreLEdzs5yYjVB7LlrnJFZpe1Ty7xR7SMsHz4uhqmhrcXmm+9WJTNG5fQJjxFdH80Glp/C8idlFL1vyltlU2oKlC6V1EA1nd13veXaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdBQ1B0VHQ4RWxHZTBEVElIdWk3MXNhbHdaVHpadHdHemNHby95ZkVjMWpu?=
 =?utf-8?B?c1R3aDBSNGVnL1E5SWpiVkFhQm56T1lBZ2cvUWxLWGhLaC9FMWR1OXJUZ2hw?=
 =?utf-8?B?bHovSW14Z3RHT3lDYm15VWgwcUR4VHc1dDlxeThnUnhTN3lDajBWaDdvamtD?=
 =?utf-8?B?SDBrWWpUTmZ4V0E3Vmt3Q1FHVlVkdDMrUzFuMDdIT25hVVhLSFB1Tlp2WDBk?=
 =?utf-8?B?RXRJVStBRVErcmlrN0F5OUI2WEhDbUQzdm9MVm9rTUVhN1NpRnVteXFEcFl1?=
 =?utf-8?B?N01ZZHpLSEFXOHlramNBRVlhRmNMUzluTCs5Y2ZmaEdwOFBZQTlRR1d1YjVX?=
 =?utf-8?B?bmg0S2JGVlVlZ204YnkvSTB4ZnFkUHAzUEh6WDhXSEZ6cTh6UUF2WmdiYUIz?=
 =?utf-8?B?SEptb3RSRGpSV1RZUVNvNzdpWERBT2lWWHFDemVlb0hNaTRFbmNyWVFPK1Iz?=
 =?utf-8?B?S1hoYU9COHpzejBoR0xLcjk0bHlyTWVPREN4d0dpbzRLODNGNTFWUTg5d0p0?=
 =?utf-8?B?QTBSQ1dnQU1QQ1VJZHIzSk9HV0J0UEg0N0hZQ3ZGREhjL21nNXVLQkFLR0sz?=
 =?utf-8?B?UW9wQ3FQazFvS0ovTFNRNW10MEZ4eGZiWFpkZDhvNWhISnRRdGFIRjNoS0lm?=
 =?utf-8?B?NXNNQ2N2SjNENWVUQ2RqUWdOTTY3Y0JIM0RLQ29IbzRtUEdKMHpaNmwveWtM?=
 =?utf-8?B?Q2F0ZEdkb1ZtRWQvNEI5QUxJcitBUHBVZGtMREU4aS8rK3c4SDJMVWFDbTIz?=
 =?utf-8?B?M25JZmp2bm5paFY5MDJ6ODFFN0wrUlNSSWl5ZGxGbEJoYndZT3NrZWZwZTlY?=
 =?utf-8?B?cFptQncvbVhUUzlaTzlTTTZtMTl0SC9xNmREdklSTFB2bTBuOU4wNDk0eFlD?=
 =?utf-8?B?ZHdyR0xITEJFQlhSekxFNklSVXl6OUVvdmxpaGx4UVdPOVpvMVhuYXVJQlFC?=
 =?utf-8?B?QVJEZTh1WnZyUVZzVi9hUkZQcUJKSWZKTVFhMEhLbEowcjVtWk9veForNWJz?=
 =?utf-8?B?eVkrUDZ5WWhrcDhRU3lyL3BIUXRTRkxmZitCbllLQnFBSnFLNko0Kzlqbklp?=
 =?utf-8?B?SysrbEJZei9OdVhUZW1HakV5bStGTlkxajF5YmFHUm9LWHpzaUdCTTZQams1?=
 =?utf-8?B?OUdHSm9vaUF5cUR2VWUrQ0RpVUM4Zk5qeGJyVTNzVFhXZkh3bnBjcFN6VG1P?=
 =?utf-8?B?MGhKNW5iRktSb1hCYTV3MTVyWk44WXRabG05Q0ljdHlUUDBUemdha2Rnak9Q?=
 =?utf-8?B?L0FsUUN6S1U0MW1HYit5TEVhaHc4M3lNV0hyTGdtb1pTc3crY1FlQVg0RTNk?=
 =?utf-8?B?b3V0c2cyMW5rcGdRT2hReitvOVlPclBxZlRIMzFrQ3BhYjNPOWorTW5GK2hB?=
 =?utf-8?B?U25tUmlzMC9mcGpjanhWWFAxMTJSNGJDbU9taWV0bnJwR01qQWZOWkQ5Nmt2?=
 =?utf-8?B?VnVWSm94M3pXMHNZWjY3aDdwQkUwaDBna1RLbTM3U2RjWVlYWTBZUmhhditt?=
 =?utf-8?B?UHVVQ3RzZGZLUWFEMlpYK3h5Sjd2ZzhFbEh2b2xKRXdPTm13SHZHMSttZG4r?=
 =?utf-8?B?TktHUGF3MkNBWTc3c0hza0UxWVlERlcvU2dzRVh0K1hYYjV2b25abHY1aE92?=
 =?utf-8?B?bWxFUWNmc283Z01CKzNiZEJEWkYzNExSckFvWVg3cytaUURGRkwvZHRkN3gx?=
 =?utf-8?B?cWhlQlZQN1Vna29ZY2pFYjNSM1hXS0c3TU9kK3BVQVg5eDE0Q2cwaXRhQ2Ew?=
 =?utf-8?B?VEs5ZkpReituTUlrSGNSNjJJeU8zYWRZWFludFJDbVV1RUZqRE9FNlNKaklF?=
 =?utf-8?B?MFdYN25oSFJkclZGdzhHSXF0NmRINWZ0aFVIaU9xT0I5ZTFWT1owT0JhZjZX?=
 =?utf-8?B?T3NjZHNkeGI0bXRPUXZKK25qeThNRlZYSEhLeU9TWndKQktOTHVOZ0ZibXN3?=
 =?utf-8?B?Y0dWaU5NR3JmQUtZanhFZ2phb1FONk1SWXZDb2ZQSDdPWm94L0IwbW5ydnZp?=
 =?utf-8?B?WkJKelpiNHhEVGFmOHcyQk4zbDYwUUtPOHEvd2FxNzVuaUpmd0s5MlE4N0FV?=
 =?utf-8?B?eUhIbWtVMXd2U1lBM3JGQ1VLd3NCcVh2MXEvcStlTzViRTNUaVJIKzNRVjdB?=
 =?utf-8?B?YUF6QkdTOGIxUlB5Y3NLQ0JNTHhyNjArTUZGK1QvMGI3bG11cjJmMHBJbnZz?=
 =?utf-8?B?aWw5TDRldVhBQ3huaFozcmwzNlUxVG5oMHZGZ2lVeGNiRU1jbDV5T1g4Y1lR?=
 =?utf-8?B?ckVlKzFRVkdPS3g5WkI2Tm1PN3FFWTk4OGE5WG9YL0pmdmZHc1Qwc0dobEF5?=
 =?utf-8?B?MlUzdUhybnkrWU01azVuTjh1eDMzR2JVN1IrWFdnUkNJV1F1MkxCOFEwUWF1?=
 =?utf-8?Q?W4YU6w1QK/T2S8pkTp8vnGX1e+Ws11luhiPOiiHIGB3pG?=
X-MS-Exchange-AntiSpam-MessageData-1: wpyiYiCGk7AH+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cc914c-0df8-498c-4dad-08de868e07ec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:36:12.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Enig59FKt9PcWv4HJ16b+Fj0rc/EBIzX5ayKKJP996/+D8GSXISSWiL+uBlffXPpF7nsKGPGRnF09pxQIrS/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198
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

On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
> Convert wpr_meta to use Coherent::init() and simplify the
> initialization.  It also avoids a separate initialization of
> GspFwWprMeta on the stack.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

