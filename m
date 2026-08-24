Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6415FC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD07710E76E;
	Mon, 24 Aug 2026 12:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z53XOW3M";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8B810E76E;
 Mon, 24 Aug 2026 12:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMo16MmriamvvgJDx3XvoQkVKxLEnXGDcv8n/Zs9t92aBpW3GGXJQOdKzDBb+OX7xTbiPh44jVCZmEIjac9DsFgascx6JPG2HMHwNs3MitJowqI3oZxiZ/3Vtd9Mq8QIyET6+vaf7sOQ45WSOFiUCJZFRBSnyMmneGYVmz00ZnGtuUFqFd2U0UW38cz+DMILUhI2cxzX4QTKQQCOq5WYM6VVsVh58+VdmQqKyPBCfoOYmmnw2KZdHub5sL1GOT1ZCjKZCg7Jy9y3PmriJ4WrLmnhRhyS4dZRyvzJstXi9EZ3P8XK5sOIoY3g9e5chiR1ZWI06nY8izoMHSOhQ2BBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHj/wqgdXg4IL9hr64h+pR0G3U4xqoz5RNmjik+T4wI=;
 b=s+NjPUBgVlopuxbCZe1hmBAdrVe6YRU/2xBgY7T1TRnC5qmYY841KH3EC7gChtCnqOEaLSiFN5jXPd3ubAk5GJ1bGz4zwiLqfSGJFWN48CaPtqK1Mf6gl95HqirJo5M70m2yq23QbJY8MEGgJ5/VjPtO/i4HAcBdqVfgjzx+qioqMxBMyeuwQ2rB1ujoE2uxY56QrjZ1cK+1ICd4aKPE585vdTH6SC++VC+WaXvXdE31DC8b/by4qUi248aZamd8ISqghM48+NIno9kbbepnaQMDchH5XIQ2vuvRiAXaqRgCfgYqLMMyCmbyhQX/lY9lh2j8is/Wc6vLtjXdC6obSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHj/wqgdXg4IL9hr64h+pR0G3U4xqoz5RNmjik+T4wI=;
 b=Z53XOW3MpNCqdkuouMVvVg724Yb+Rc5IcfB3PdIXvNIQWDlStdPZ38aNcwtkY+f0XwwG+AFe6sCoIa3lVrWcIXWzSHB45Dn7lAp4kGhln8ZoODefW2fMvE7XAO8shPLPBUqq982d/NLfte65OubxlKQ2ISjhoNicnL0lVbR3ZheMRa5Xa2JUT2t3+4XTY7IPi0E3P8sK3RBh0ZN93rVx8yfvOofAm8G4h0KgZlIbLJz5mqlYoyb5TY/et4AiYtI/HNEL6yaB4Ow3FPGg44axPOrVrg7gewYeuAMqSlpIWD8GSiU+jA38DAYZWXxgEv5AumPt7p+H8xFlB2dZ+tj/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 12:51:21 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:51:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:51:17 +0900
Message-Id: <DKX6RHAHBFGB.1M6PDD9BC2ILR@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/2] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-2-d5b7bd7e6624@garyguo.net>
In-Reply-To: <20260819-rust-barrier-v3-2-d5b7bd7e6624@garyguo.net>
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: faee0016-c106-4243-ffd8-08df01de6592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10070799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6kk2OBrj/QR+VuE92GMJbOfseycKbHN2TAc4J8hVyH04UVuFQZRjZvQ/IPdmG1lbUTu8KTHgZjaceuHGLmLaElNERpfSkY8WahjdcgFBsBKc+/PAHhpRUVAdM5ywajYGdTHl7EkqhZcCbwKqXMIGRrxgU4KelcAvVjPbbeXBWXzS0uq9oS9EUtdNBzRJCArey06sMkEu97DINZry//K8nE2Himy4NkMVHOdN8KWzu8BuvzdKZSdiPxPfrz/KZmu5tmtivGs9xGXaCKvYvuRoqww6GiyxmyQABpiJRpvA/B5NRr/oecpEEQdq8bZk5GehkWRGudExFF5DIs1qLIgNLy/XnrIB5jUc+lAtfTC4WUGFJ/QyUNPei5+0y3kAUc5Rzv9fxUQRMNbt08kt9DckA8FItOjvmLXHvSN8OwN6A/wIvfH8KghChSmlXbYaFftlBLlxFqBy4hOMWsLhTPuUUURBJSe9fYoOg5fcIUYoITEkWRmmqQEzXpO7aw8bWh0pvJahiUSqtNgGn8QxI7fgkPgTu3JOuYaUafBPMzh3yN2ZnlnICiKp2J/x4IaJDectTO4oyvGeOPtofFN72NX89S+hBSQ4An8jnYG35Vrs9w+tJsdVL2kAHrDA+GD1soz902e/tfDI0e9IsESrT/fE2b2BnrvxqpBMAZ4XDB5ipow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWUyNEROejNhM3FtM05zT09EQWo4KzNoL0N0My9UdU90dGxnOGNTbStjYXJJ?=
 =?utf-8?B?NEhkU0RHS25ZMXh1RFFUTWFZTXFVNThLZWFoUFlONjJ6REx4VXFhZ05TTHRO?=
 =?utf-8?B?MEtHME5Vd0Ntc2lkbEM3OC9zSCtNZHAxNW9sbHppUUw1TytBUERoR3FkRDRv?=
 =?utf-8?B?Vy9VWitQTWVxUGtPZzYzNnNiaFJrRWNrL0NPcEU1ZmNQS0ZENTVMbzdaeXpR?=
 =?utf-8?B?S2xRNUM0Slk2MS9vaGxhMFoxUUlONXVLaklhUlBiWXBBVjJBZW9QV2Z4dGRC?=
 =?utf-8?B?TUNMRFhiTUR1eW1mOWV6K2pDRnJJa3YzRjcvaXYrL2RyOU1scDUwWkdMdjA3?=
 =?utf-8?B?QklYTHdtV1NGdTNFaGJrZU9MdFk2cW50NkdxN3VVbHphcjI2WE9neFp3L1pt?=
 =?utf-8?B?UzN6VndVWWovd1BUd1FyWCtCTGMxZ3EwODYyanl4dXo0ZXV3Tm1TL2pZd2F3?=
 =?utf-8?B?MkZxMXhTcTFTRWJhYWNYOVplVEV1QTlaaWwzTStUQko2dzMwRDBZcklmaHlS?=
 =?utf-8?B?dmlIQWhwUWdCUEVQdCtuMDl4Y2NEdnc0YS9yUnM1aXUwbkNvdWlEOXdhRTV4?=
 =?utf-8?B?Y3k0R0VJQm41dnJqSGZGZ1FZQXREdTZKMCtkZXVudmFFUGVZbCtkYXBuM2tj?=
 =?utf-8?B?NytXQTAxTmtQWjlxMXlscGFvZm1ZbEVDeTVPaVFwbTJxQkZnWnlQQlRZL3hr?=
 =?utf-8?B?ZkI4N1owL1ZZNnpjKytGQjdEeGNMQnNnNTg5dGFJUWlzak5YNTE4aE9QNTdz?=
 =?utf-8?B?Y0poWUdZSi9wczV0NWt6L0ExUERWR2pzaW91RFdHTzhxR3BQVkIvN2FzenQv?=
 =?utf-8?B?ZEVZTXNnZGlueGQ3bllMdSswaFhxazYrOWtkSlh5Rm4wYk5YV1U0N29kTS9q?=
 =?utf-8?B?eDNYeDFqcmcvcjYvMkpzZ1lHaEdOVFp3Sm94WWUxeHNjVEZ2emhNVExaNklm?=
 =?utf-8?B?ZHZmTTUzRlNZZnp0a1dFTGM5M1RsYTdtQlp0aGt0dVhWcmRzd3NOcnZvcmRs?=
 =?utf-8?B?cmV6Uk0yTWRqSnZvYW15a2FGYkxxcmpWZ0NNdHNoVUdEVE45QzIzdy9ReHFw?=
 =?utf-8?B?V1NSeCtZNDdNSmdxdTlKcjhzV05WakJZQ0RaUmhiSFVRWERiYlZYU1FsTGgy?=
 =?utf-8?B?a2krVzNzRUJ6Mi9ZZi9nS2pIQVh5dWtSSUtlOURBRDBOYUVTeUtXUHBWQTdi?=
 =?utf-8?B?TG1CM0JsakRKekVxWElJUmxkRnk0SzJKM0w2eHUvOFV4NzV1elZVbW1CRWxZ?=
 =?utf-8?B?TnlVMnhLVDZsdW5DeVFRNVRHcnZyUGw5d0Q4cWNCOTJkQm5VamNwcVJwZTQ0?=
 =?utf-8?B?YUNRK1Z4TE04N1RHT0U5a2hOMGNBOHlGVHd6NzE0N0I1RmhMT0VDejJvR3N6?=
 =?utf-8?B?RVJYUVJOb3hzdjllSkxBeGkwZW9pR2FTV0VZVWJvWTJCNm9zY0lodUJXQS9l?=
 =?utf-8?B?eTc2dmVyZCtya2R1RHdBTThzMlBMUzdSbVZBY09wd2RubHg4S1dZOHFKQUVU?=
 =?utf-8?B?SzhJeW5MTWI5QXBMM2VYaTV5YUxFaHFGSmhKTVhOVmlDVnNwR3NBS0VKdllR?=
 =?utf-8?B?elVBZ2JkTm5DN1ROQW95OGVzK0Z0aEdxREZUQXo3cGJwK1FNNklweHJKUTZB?=
 =?utf-8?B?OWZOdFd1NE41YWFMTVBWM2MrRGswRDdyWEp0cVZGZWtpdHRndkVxNEhxMDB2?=
 =?utf-8?B?OUJIdDhsM2NveHFLYXhFWHhVOGljN2pUeVNneHR5emNXN2NSV2RMNmJXVWVm?=
 =?utf-8?B?RVFGNkJ4cVFkczlFV0xRcGJZeVFwMGRhb01WOFc5STV3QTBjQ2FrN09NQVBS?=
 =?utf-8?B?aFg4QVJpVHZESjMwRm9oeUNsbEdRTndTT2swZzZ3ZkF1SWhNYXVWSlF3K2J6?=
 =?utf-8?B?V1A3V1RiYXE1UWd2Z0VRMjJKUEVUMGVZQzJ1Z2lDZmdDUEYzR3J0bjZjZURJ?=
 =?utf-8?B?dC9VM0ZhYWdvRHpQeVp5VUs2UEpRZDhOQzRvcC8xdFgxOFVodnl6SlRvMWNI?=
 =?utf-8?B?bEEzWmFlVEc5cGthdWdSNExTVGRDeWhxV0NpcFFhcFdDZlJPZXFpeXkvZVEy?=
 =?utf-8?B?cHZWcW5EclQ2aVlldm5zV0ViTldGNE5CL3ZnTzI5R0ZxVmthM3UwTFFSeU9E?=
 =?utf-8?B?ZUk3YlVoTHdvZVVFcTVVYm9aOXZtbVgyZDFkUTFNaGxMRzhCUXhqb0pBZG9T?=
 =?utf-8?B?UXkySlc1R0ZqNStJMlVpbFJhSmM5TWpPZlMweUpBRHM5OE5tRlR2emxwdG5C?=
 =?utf-8?B?K2c0NmMyRDQwRVhpeFE5MHZWdEovNTRNdWg0dSs5WnYvdmdMM0ZwaUFCNFRQ?=
 =?utf-8?B?Vk13cFo3elRxaHAyb2wvN1YwaXpQa0dndHJlUTVLR0VmMk9ZMEVMK010bWpw?=
 =?utf-8?Q?Ud9HQBeCszNGIz9zJKVlZEmRWVw7R9Hyxw3oI+CrIM/UH?=
X-MS-Exchange-AntiSpam-MessageData-1: nf+dtOvPBrrDmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faee0016-c106-4243-ffd8-08df01de6592
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:51:21.1312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhXNwH8VWJoIOMu9yCN+jJ1K3M+5MBzBFzBmtrndV4UJAl1rz970na8AeYyD8VED+9TC2JEgGlEGta/GRXP8Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
> In the GSP->CPU messaging path, the code reads the write pointer from GSP=
,
> reads the response and advances the read pointer.
>
> A LOAD->LOAD ordering is required after the write pointer read and the da=
ta
> read. Add it as this is currently missing.
>
> A LOAD->STORE ordering is required after the data read and the advance of
> read pointer. Currently a Rust `SeqCst` barrier is used, which roughly ma=
ps
> to `smp_mb(Full)`; this however does not order DMA operations (notably on
> ARM, the generate barrier orders inner shareable and not outer shareable,
> which is ordered by `dma_mb`). This ordering does not need to be in betwe=
en
> read pointer read and write, because it's for ordering between the ring
> buffer data and the pointer; the RMW operation does not internally need a
> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only=
),
> so move it to before the RMW sequence for clarity.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
