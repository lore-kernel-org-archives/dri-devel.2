Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADE1F8DFCC
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C0610E92A;
	Thu, 16 Apr 2026 21:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDMgfbEr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E8310E277
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWt5IGGAmh9XF5uyXFvP3bgJ819vADVfZDfK7LK6dF0g2OIcrbYWVnIPII/+LlP0ixSCRxBpn1nfLsgze2OVvyiXOWiYcKY7GqEyWr25SVTmiBKJgQ3ejXe5TrGMldHVBIVjJFTIrMztuC3P1Nw9AKXug57oZYPqIglzvf/AOevMfFIqLWTkXlWDZCDnI3RaFGVrqkmeGEdW8JZngSsDP5/e0ofRB948MhLSOO47uU3djUQOpP3hsb3OEK7BHtZ3G3YuElnxI+avlPQvIR2qZ1PoX6kwDPStQQLfJ7XGMAwynO5xvO2oNuHTxnr0RdZc0UDl9zf1FY5tDLdRQtublg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2/tyvanjkoYD11pPRzrArlHt8gIDLCpz0W7vqiwKx8=;
 b=UJqN+g4TKZKRCKD/AjjBKeLgqg0qK+Irtt8l6P4nfl7WOn7Hy9TMLEOaPUSmzxelPYwA3T9/cbErqJy82f8w9VJ0hrr5cBtqqDZmf+rkrNcDR4dxOlEtlS1PrSdXXlVRQvgPvHyHXYw1pc73xQKdXZgsWWgI7qN4V9ED7l9uWbrbfpBuPENLz87gwptzDmODA4+fttPckNTAQKm9Kkj0cod/lj65etNMZN5B2slEIwvk++LdcDJIQULzZgNE4rCBYO0PrHPtzuPBm+a3N57XzikTrAi4RpP6uGn3dWIkP3/h+8M6octH0AK6rJOFfDNnUFQEiu4ea0AwHNvAoF3biQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2/tyvanjkoYD11pPRzrArlHt8gIDLCpz0W7vqiwKx8=;
 b=CDMgfbErsCBtewudTuIU9D0rarwgmkgG9bZKpZEjyXPV0LhvpKAc/5dW/PQCmjx5OJdzxrMAoJRsdQChz6k77OY/Wcd6iKNBbVPT/EaNKafBKr0ke6wqDB7ByJ2HninQkHOkOiHo3jWsy6ks9DFCoptFv/kjcnrIy9w492vpwEOtYHodwkwo53hatkc2pKRlhKBG8suHlAOgJNQYie1XisMilhDnr8WBczYKcQR9Mseh8d/MxcomsreLzdeuHC6lgqxTfPbdxLDGExF6NgEyfEYK6NlrsrzMDOziLA7lqUrR6Id3fpWlj/R5o0LGjaGjjIsqxzOOyRC1QTA9gR6YOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 21:30:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 21:30:11 +0000
Message-ID: <fdd6e890-f6b0-4ea0-b5a2-e97f880eb472@nvidia.com>
Date: Thu, 16 Apr 2026 17:30:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] gpu: nova-core: gsp: add RM control command
 infrastructure
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:208:32f::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 617ff8e8-75c4-4f15-fc81-08de9bff56dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Hd5aFUTNiwVkvpZYlk/3xfRWK7IrnmsVImtOU3sk/FQuli4svlVT39+kP0wjO5jjlPspP7ulL5geF37crAilYUesLc7FKlY0YFBIqXkMuhbw78KKZHbK/ODk4ouKVzTRXCtP+RyGpfQlqX+a/NZL/uOHXQJy2GALkNM94AX3xakzFyE3+4Hj0W25qRUSnSjZv64w+gHQJzNLaX4zmTpIf2oejuaE+DK2cVD660HSEkumS5a2pRcjqA3TrUMtct2cDeIAm25IJR7e5+tq+SZYm+7t2zbppm86hZmzrJev+NpDVVZZzXSL0YdNMQz5SmY9JHNigcV9h4gC8dEUDZYBqrWnHy8ofC70LBYqePvXk9agf9WVqIaK/3ZXZaDq1sZJzSlwdSMpl23Clkd2rf/8tKM6f30oFcOd2dTuzakrgr2PUi+p2NzqUOnoD8cd3pTimA6vg8ezhzDUSb5RCP3ULdApGzRLrMsFATuYmv6hk+wOgj4bT0FHnbf2vkmQLqqArEBGVf+g6XOkAS8MU2MMJj/jzPC8MdO+rf02x1gnK53j0qfOdBgKPat/wEv2EjyHkxIzf0iVUoDRnDruEAIjgbYofUNdLG8qeIHlSbN+SVDZfJ8iKPuERh+iAA2mkdzKQ/9LaMRapW1c1ktW8qr/uE+5vxE9KYpg0gpTqtVIZAt8YwZu+F820OG9MV8xIiTjaZHZs8o90JDFx49zt82Xb4Cr/LtL/x6TaG2oFTNhfBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDI1ckhjNGRmcVhCSzV6NU9sZFhyWkYxQnB2YTd3V1Fzb3dQcjg4ZUo5a2J5?=
 =?utf-8?B?MDQzQWNjUEZsZUlIQW5SdUZaUXdxSXhwY1JVY1A4cGkvN3dCZDlSWGNOejZ6?=
 =?utf-8?B?TEorclVhRmEzSHdLQkxVeUVqTmRnZXdIRjVvc0tJWVZMdzNVNVI0RHVjSW1r?=
 =?utf-8?B?QzRhRVdlL040d25XdXR6YkRiWGgyMWxvKy8yNVhlUEw4Q1BKY2p3NlovUndp?=
 =?utf-8?B?VjhyMzhKdlNaM1p5V2tENkI4K0dvbHlUZzdSTzlWZDlvam1VaCtMb21sMWpS?=
 =?utf-8?B?Nkd6bVdvUUptcGtsSkdRRGtQZWRXdmFacDJFb3hYRjV6UnNkcEh1a0hzSXR6?=
 =?utf-8?B?Q0FLL1VkYmRaQXI2a0pXRm00bHV1RjBkYnpULy9HZ2ZqMTduTjZYVjd3aXd1?=
 =?utf-8?B?UmtvcnZiNzFNQ3JGaE45NW0rWFFGRUVFSmgxZUhjV0lLS0NkaWFDZ05rRU1i?=
 =?utf-8?B?Q2FHUnNKZ0t1aTQ1d2pQZy9NajJTS3dmd3I2T2dUM3orOTF0QkJWZHNmSVI3?=
 =?utf-8?B?LzRVNmgyL1lYRzB3TlNQVHN5NHJCMVgwSVl3S3J1Unh6c04vMnRGVnpacVJF?=
 =?utf-8?B?WHNjc3hYZ29pR0F2b0ZnclVIUmYreGRGdlFtMjNGczRubkVrTWtEcWRXNWRV?=
 =?utf-8?B?Y1RQQ2F3OWM1dGhRU1p4RTNWM3BvTkJIc1NsV3pmRXI0TGJ2U05GbnlvbHYz?=
 =?utf-8?B?QU1QYmxNbUc2YjFGUEc2cmlQTFB5ckpvSnQ0aWdKc3Y4d0JFV3k0WWpCei8x?=
 =?utf-8?B?QnNUV2NzRWNXYmYwdkd5MXI4MkNBTGFEQ1BTcExxSnowYWJLaUxDQnR5cTRX?=
 =?utf-8?B?L0xWUXZqUytwU0FHNkpqd1lNVUk1bHVkQlF4dWRNY3FZRTJNM3JCN09ZSldP?=
 =?utf-8?B?ZEs1Ukh5RVZxQW1pZitSVXNjY3JiQWZmcTlpdU1EM1RlTDNDZEZYU1VWVFRj?=
 =?utf-8?B?NFIwbWNZNEV4WlZPQnJOWUZzaUZwV0ZvOTFMVDA3dml0OUcvcVlFQldQZUF3?=
 =?utf-8?B?RHFaenlvdVhMRWk5M3hVRzNRSjRva0RCd09LelpnNldMUWVmanBQb0k5elRj?=
 =?utf-8?B?SGdDU1hldmFIaFZoRU1Wd003L2VaYU8veWRhQ09QaEZzNFhNeUhSNTA0dmJj?=
 =?utf-8?B?MTVyem9UQVJWSndFbFdqeEFZVCt5d1Y3LzdsU2ozNW0zY2w0NFFrRkZqbU40?=
 =?utf-8?B?bjRic3RXR2ZqT0x2YVQybmJub3BJckNiYkszVTRDSWk1Qm8xSFdtbVU3WDAy?=
 =?utf-8?B?R0RSWGQ1RzZiMDZPdGF6eVJNNi9sRjRCcWpENU4rb0tSNW1NUUZWbmJDMXly?=
 =?utf-8?B?ejhTS3dsQmhNVzRrUGhFSGNxSjV6cXdlTkFSSXhzZFRvQkdHeTNnUjhkMUJO?=
 =?utf-8?B?ZjJ6NWMyWDdEQUlwbzYyWkdrTlBkanRnQlk2RUdjclo0OWtCMlRyUVkxbTAx?=
 =?utf-8?B?SjR0eVF1U0NCcTZtbGp6TzBOR1hmUmdjdTYyK3M5by91RWIxQnBOTDk2QlJL?=
 =?utf-8?B?NmVmWkdxZXlWdXJsai9kR0QvZG00OHpScFNSTWdGN2kvQk4wbjVYQ050L2hZ?=
 =?utf-8?B?VEVGUW1SSnBWU1dyeStDaVYwV1UxRmpKOGJOUUQ3dHpPcW03S0huZjdPUS8y?=
 =?utf-8?B?elpIU3I3S1hXNmZNTURmN0UrTE1yYzVmREFQVnNUYjl2QVplQzE0Qmt0M0hq?=
 =?utf-8?B?YkdTRWd6cGt0d3gzK1crbDA3dVVibklkSFRML20zY2dlZHF2a2x5Sm92eFZX?=
 =?utf-8?B?K1NtN2pwanJvdkNFQTV3TGdlRVpQN0t0VHZyNkwzOXhGREhwSFgrMTdKNUZQ?=
 =?utf-8?B?SExLTEk0RFErSGZCNHBjSTVDZTlmdHdTbFhSUk5BRm9HZktiRm5DVHF3c2hM?=
 =?utf-8?B?RHdjZm1BalpvVE53YStYSThUZUh0ay9ubzEyWnRFZ1hRY2d2N3JOa2M3b052?=
 =?utf-8?B?a3ZXNjJ5WmdKaUFmR2FDUWJmNFZTNFNQTithendHM2RxNk9XRk9PdHdYTHA0?=
 =?utf-8?B?ZktsdUVqMEdGaTgxQzlvdkJndGJUbDdWeXFodFdVeWcyYVo0WDdRMS9DbGJL?=
 =?utf-8?B?eWpkK0creEVGS0dPQ0hRNERqV2FVQ1JlUmtUL3dKVDlhMFRQZjlkTHpUaTJ4?=
 =?utf-8?B?eGx3UjlsYWw3dnorT1BKdFdHWUtKMnZwdVhjRVpYRlZIcGkvM3lPczVCZUk1?=
 =?utf-8?B?OUErUm9jdlErZUNFcTVvUVl2RTVQckdUVVlqTndsTlVySjNzMHROV0FnVnFr?=
 =?utf-8?B?YklzelVlU2ZiaHNKMnpnZEFFSjZEQk4xZURjdUVieHNVSm9YVnQ4K0kwZE5v?=
 =?utf-8?B?dUxTYkFEd2V4UWJTTE5RQktvVjVGcGhvRFhIcnAvbXVIcFlGYzBZUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617ff8e8-75c4-4f15-fc81-08de9bff56dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 21:30:11.1333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTXLMhO/qUh3xlUkw1OE7Dl2YP0D+OB196zKjEW6P8Bi53FJJQHfA3aFmqha89aNh9H+pvQxzZzcR3IrZalD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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



On 3/25/2026 8:13 AM, Eliot Courtney wrote:
> Add the infrastructure for sending RM control RPCs. This is needed e.g.
> for channel allocation.
> 
> This series adds:
> - `NV_STATUS` bindings and wrapping `NvStatus` enum (used by RM control
>   RPCs)
> - The necessary bindings for the RM control RPCs.
> - `RmControlMsgFunction` to identify individual control commands, like
>   `MsgFunction` for GSP commands.
> - `SBufferIter::read_to_vec` (using KVVec) for reading large RPC payloads
> - A typed `RmControl` command that can send RM control commands.
> - One usage of `RmControl`: the `FaultMethodBufferSize`
>   RPC. This is useful for channel allocation later.
> 
> Each new RM control command can be added by extending
> `RmControlMsgFunction`, adding the bindings and wrappers for their
> parameters, and writing a type-safe wrapper to send and receive the
> reply for the RM control rpc, using `RmControl`.
> 
> This series applies on latest drm-rust-next with the listed
> pre-requisites.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

For all except patch #2,

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

For patch #2, I have the same concerns as John mentioned.

Thanks.


> ---
> Changes in v3:
> - Remove `send_rm_control` in favour of a typed `RmControl`
> - Print out fault method buffer size at gsp boot
> - Remove Reviewed-by and Tested-by on some patches that have changed
>   substantively.
> - Link to v2: https://lore.kernel.org/r/20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com
> 
> Changes in v2:
> - Introduce typed Handle<T> for RM objects.
> - Improve naming
> - Improve doc comments
> - Change SBufferIter to always use KVVec
> - flush_into_kvec -> read_to_vec
> - Rebased on latest cmdq locking
> - Link to v1: https://lore.kernel.org/r/20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com
> 
> ---
> Eliot Courtney (9):
>       gpu: nova-core: gsp: add NV_STATUS error code bindings
>       gpu: nova-core: gsp: add NvStatus enum for RM control errors
>       gpu: nova-core: gsp: expose GSP-RM internal client and subdevice handles
>       gpu: nova-core: gsp: add RM control RPC structure binding
>       gpu: nova-core: gsp: add types for RM control RPCs
>       gpu: nova-core: use KVVec for SBufferIter flush
>       gpu: nova-core: gsp: add RM control command infrastructure
>       gpu: nova-core: gsp: add CE fault method buffer size bindings
>       gpu: nova-core: gsp: add FaultMethodBufferSize RM control command
> 
>  drivers/gpu/nova-core/gsp.rs                      |   1 +
>  drivers/gpu/nova-core/gsp/boot.rs                 |  11 +
>  drivers/gpu/nova-core/gsp/commands.rs             |  62 ++++
>  drivers/gpu/nova-core/gsp/fw.rs                   | 402 ++++++++++++++++++++++
>  drivers/gpu/nova-core/gsp/fw/commands.rs          |  19 +-
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 161 +++++++++
>  drivers/gpu/nova-core/gsp/fw/rm.rs                | 106 ++++++
>  drivers/gpu/nova-core/gsp/rm.rs                   |   3 +
>  drivers/gpu/nova-core/gsp/rm/commands.rs          | 167 +++++++++
>  drivers/gpu/nova-core/gsp/sequencer.rs            |   4 +-
>  drivers/gpu/nova-core/sbuffer.rs                  |   6 +-
>  11 files changed, 936 insertions(+), 6 deletions(-)
> ---
> base-commit: dff8302ca1d0e773c90dbeeb05e759f995c95482
> change-id: 20260225-rmcontrol-bd8a06fc3a0d
> 
> Best regards,
> --  
> Eliot Courtney <ecourtney@nvidia.com>
> 

