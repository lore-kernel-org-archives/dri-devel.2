Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1F1CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE42910EA5A;
	Wed, 14 Oct 2026 01:36:12 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33CB10EA5A;
 Wed, 14 Oct 2026 01:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdDV5Zx5N0JSQoZ2DAZ6lLU0qwNk2Z5MVAhWdVp39bii10meAeL8hOhkHl5P8qWGxIRiGcWGAzx+RdLx7x9G34Ve9VrTcg9RH+oZgKbzLVBOkFPHOSUFoe4mAGVax8fCDewJZ7zaZ1UfRpar2RZtq2EhOMdyiiPaWZuQPkIYHaLHVX0dzzH/YRQTNgaCalfpXsSpyYrqnDQFvKtasUnTnsBKo0JWwboNkAIPyfG/jR+xfiHOv3tmEoyq2qcB4OjWyHkq5B5HCKTyN3V1z0PSISLHNi14cuuD3U48KHfOyndfRbzfLx69tQ3KVNmSLI4zI1lKKLiYzPJMIRpvA/lQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP1mkOkqA15WNcwXLZ1+cOEsXcGICrk9R3GHBh0oDMk=;
 b=D0rhbujrx2ogTP445WEz+u54ha/6rm/pOd+VSdcE8hMzXoOPuAOZOKd7EgObgcTqj6u+mHz/Ch9LjzL+m9RXBDZgI4UwQ63r72CqjAS6Wvwh83NHhdDH832V4hWavXobb/msz6TO5wvwDmgmqcLiSG1TofnMzsytahDE1+n2TjCV0SxtAXhmVWLQ3p7yZigbfMkjjmz7dPZYqECGxZ2+6jxMyl4ibgcEUEKitSy+x1I7DN8nufpay1MUYJFCamaclILA2JijiIcUyQQwkReoKcMp3t9BbBt8Cs/j328fjIsEz+ebXpdHkOhrxXcNdBovRDZ+95K3kqIA+pF1OVRyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP1mkOkqA15WNcwXLZ1+cOEsXcGICrk9R3GHBh0oDMk=;
 b=est4QzaXsxHAOvNzqa6DhEvxWnJ1ro+xQBCHuoPF0LQjEIJdZ2HOlKPEoFNwaxdAPiA7BMlguw//8a8u9274dYl1R/DRm7dhIov4qCXk/1KChcDPAAs91yC3qQH53o482WE4vejFfpfQYpqEfCcDxfMyMJfay2b2St1MQYcOzluWBCHAeBe7+C6p7tgYkC76aQ7DYgkjDcTIQSeiLYqR4PX8q3Ux7QM3buNL8dlLCOVRAyOeKPR8wR1Pt21AfjWe9Kg/F3zykPCya3BPoYWD946rUGcLFCxt1EjVXr+jtPn/WORyOVgaaR5xmFlv4YnxN+KQyu4KX8LCs4dAmhjNfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.24; Wed, 14 Oct 2026 01:36:01 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:36:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 10:35:57 +0900
Message-Id: <DM46C72WC4G9.FRMU9QSIS1SE@nvidia.com>
Subject: Re: [PATCH v4 06/10] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 59979952-dcc2-44f9-df3a-08df299380ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|7416014|376014|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8g6BJiSSrNAWQZOachs5+aCMx8x/+0x0qo1mNn8C7VIopdED3LGtZwcXjgjKLOxNzmmG9BnGnoO4QYQjY81xPC3LKksqUSx5gDPgtO6/cy21yuL8h2Vykz9eFneKXNRReBSgUpMNh24ljwmsoLdKQRtQyTl7IbYjysLJXtBywYlnFqPbadEJi6FVbiTMYxOnaqaef7yB+ekwM+LipOXrTovuO7dhbfY/umrIpjpFXMTkkcKUPJNapvbz+kkr9Dl24K+pNJVFzye+ST1lueW8I+sHLjmt1kwATK9KNM6BhY3lV5njL4oMQe3t2bbPIlUJwBgjDKH2BFwpM7rtsx9PXermX2WCZl6suf4kn8iCA/MooFMPlxhwAfK31R0sTZG9yVOpjq6+hmSEmDGLPGp/47LRLeE/8c2nxBkehFlsxYl2qE7ZXho++4wk6sYq6JXMVLVJwQgZOiPSLhdLnK/mWjqVXxrXptFj1y320SM+qLsB8fZWHICqSCjS+f1o7hrhhsTH3cm4QKkmFudHykhYBs8wIu7btAOKsMOzx6L/aD0Wz3JgHFMjJCripqHXWqsLowpaJkXVQ8j1TnUONOnvZH8H9lLoeJuK/twO2T+3ZKdFAyPBw1Xyx+78SGKgfzCXBzSkG0F9pw3SnFFbQWw/MMPW3kxZwCEBIar6wqZysyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFyQWhMZkxYVER1VVIzdU9rMXA3TWRRNzVwRURLV2VWWDY1ekIydGZoWUlI?=
 =?utf-8?B?ZnNFYjBlSStOM2d0T0lxQjhXQ1VOZUhoYXRFcTdmN3JqOGlXUi8rUG1Wb1hD?=
 =?utf-8?B?VjFVajcvU0tsNzBDU2N4YVVTZVVDNEdIbm9lYk9iK2lyVFJuZUl2dkROQ0FO?=
 =?utf-8?B?UkFicW5pNHpUSVdMYWJuSXRLZ2E3T3hxaW1JNHdOK1E2MmV1aW9WVFFiT0pp?=
 =?utf-8?B?aW9wakRTTkxsUlBYc2xka3JhaVhvSS9vNys2VU1ZNEIrbUd2ZCtURmN5endl?=
 =?utf-8?B?ZzdBbW5tQ1JHSE5wYmFuaWxjbU5lR2o2VzQxNUluS0NWc21IYnNHQ2lpMmhD?=
 =?utf-8?B?dUpzV2ZTR0tpdExJR2tjVzAzcGVJa3BwVmZLWFhRRWpSU3J4VVJRR0U4cXlw?=
 =?utf-8?B?ayszeWEwOTFzVmZJWXdOem4rcDFFM0dXWXhtSENpR3gzY2RvUjVxdTg2RGV5?=
 =?utf-8?B?dThxcDdYa2I3TDd3YlRVaWtnbTY5TmRLTFltTW9aSGZnQjZIQStHbTJwUG5J?=
 =?utf-8?B?aldOeUhwZlQrbnBCRlJWL2FETy9IcC9IZ1A1UDZtNnY3QjZlcDltdXhWaTJo?=
 =?utf-8?B?V0lKT0wrRnI0aThhU1JFdW9WTmRSWTgwMlBHSUdsNlp0WXZ6Tk5kTkVoOXow?=
 =?utf-8?B?QnRoWFJQSTlaZ2RQWi8zVTRWRDRDRjdIQ3NkMkJVY1pHd0RrbHFGbzRkVWtq?=
 =?utf-8?B?UTQzVXJoWW5HVWkvNjdtL2xDTFM4c3VPSU02eFh3R2docGcxK0FiSldGdmk0?=
 =?utf-8?B?bHRVZ3RNOFUwd2FKY1YvcE9hUlJRNjZxTVdlQjRkcDBiUEYwb3MrQjhjNmY5?=
 =?utf-8?B?YVNvTllDTHY2Y05FNkZudU5Lc1ozUGNURGlpT1B1OU1ZUWhwNVJSKzdTczVX?=
 =?utf-8?B?dmZuNkM4L0Q4WERMdjBGSDJuckFpd1VzTE1YckFaaElNZ1dtL2VmWmZvVldi?=
 =?utf-8?B?eTNDdVNEcVByREJOazFiR1JpbzNXeDg4MS9HMWJkSDlSUnFHdzNDeHNwbzV2?=
 =?utf-8?B?TXYwWnBvak9rdG9OTUhBWVlUYS9sMXYzOGdTaFpEUEh1ZnNCaTFnMWZrUDlo?=
 =?utf-8?B?MEdqNERTQmhtQjZJVngwR0dRSGV1WGxWRzBMS1FRZGV5N2cza2NQOGtja1g1?=
 =?utf-8?B?dy9URE41V0U2MVN3OFdleGpuQzJOWWt6dUk5cW15elFRRDlZU2NXL2J0QWJ6?=
 =?utf-8?B?amZuZ0Q4enYzZzcvNkhkdGx3U3lFUmM0MGM0YnA5TmF0MFdPSzN1RlFMVEoz?=
 =?utf-8?B?cFZwb0d1WUFpTm1UZUR0eXVjVGhzK2Y5MGJ0MlZlbGxVakxyM1pnb3VXMGZD?=
 =?utf-8?B?ZHlJUzFzUXdFRUg0WnFUMnN0dkVha29xbU80bG9sekttc3FOZjd3UzFuNU5E?=
 =?utf-8?B?YVVBZzNDTHA5UkNzdjZRdmJSVFdDbmtqMk91WlhQNEgrUUVxL0tRU1dUUTRT?=
 =?utf-8?B?Vk0wVmNpZ3liSjlFWVhGSktsd2E5emR4bkx4ODMzdFRRQXozcXBYbGZkdlpE?=
 =?utf-8?B?NzJRYXhweXJhZHAzM3JUTUR2TDF4cXIwcDF3Vk5NRURBQlZBQ01oTHNJS2tC?=
 =?utf-8?B?UG5ESmFWZWwyQUxpYWhPRktyTnZjbi91VmM1aDJXSlVwTnU1R1FnQVR4Z3py?=
 =?utf-8?B?R1dndUhpaUJiMHJNK29NS2ZyWTZiaG5mNzFiSi9XSFhmUlBtR1MxZTZqWXhm?=
 =?utf-8?B?QnFXTTdndXJDZ0NobGRpd2doZFUvWXZtNU9YL0RjRnN0azk0NEFYWTdaV01I?=
 =?utf-8?B?M1l4UmtVL25Qbit5R0x6d0F6V3I4bGFoTnhoSVNSM2Y0WTVTSEpOYVpuQkZT?=
 =?utf-8?B?NXdXK0dGNHV0clVHUk1aWW95WUIySXZuMm5majBqYkNGdk1pTGsrTFdqVU1l?=
 =?utf-8?B?UU9neE9XbmF0VTExZDZzenBHOWJXNklUb0ZRTGx6SkxyN3pBR0hBSy81V0g4?=
 =?utf-8?B?TWZNZ0gzalQrVVYxUUJPV1NxMFZxOHpxck11bnBDaVdkMEx0YmF6NzdwNWxy?=
 =?utf-8?B?MmJ3bWVUOTV4MFQrcStDU2lvcW9UMjZYWVVzZnc1QmIwYzhVbThvRTJtMUE2?=
 =?utf-8?B?b2dnV1lEWjg3bnZUNmI2ajJSQVYvRUswbW9XWnpkNmZ4R2pBMHhiQnBBQkVv?=
 =?utf-8?B?MjlzaVZCak4zeXhENlB2cHNhRkpZbFlCTnFpa09xQnVnY0h3WVlLRWdIbitm?=
 =?utf-8?B?TFJvNjhQSUUwYm5zVVdDQk1Qa0F5d1dGUWV5TkNwY3VxeUtPclRUMGdEVVJs?=
 =?utf-8?B?MEZoT0pjS1UrU09yVWxTQnAyTXBZNFpBV0pBOWl0bnJKRmEvT1ZiTjhCOUNh?=
 =?utf-8?B?TitkOHJXK21XZGJCMGtVY3cvRlNLWXVDakVDTUFtYnB3NG5BUng4OHlqTUl4?=
 =?utf-8?Q?6TdkWiPm1fTxwCbmiUUI0QosPiRkNdds+3yqqzyUagCbg?=
X-MS-Exchange-AntiSpam-MessageData-1: 6w8GT+vHclWp6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59979952-dcc2-44f9-df3a-08df299380ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:36:01.2677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zOvNGUzNlpHLxWCnl1rjZ4YQRb4blZgFy/RDllN+k/oBKcL5dLTaiAJ6lW1CJt+tW1jcG7JM+GfDOV0jpxx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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

On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
> The `RpcMessage` type is the right container for the `log_event` method,
> since it contains all the data we passed to it. Move it there so callers
> don't need to extract the required data themselves.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
[...]
> -            let function =3D rpc_msg.header.function();
> -            let seq =3D rpc_msg.header.sequence();
> +
> +            RpcMessage::parse(self.dev, msg)?.log(self.dev);

nit: in core/interrupts.rst we say:

``` A drain fails when a message's framing or checksum is bad (see
"Draining the GSP-to-CPU queue"). The message stays at the queue head,
so every later drain would fail the same way, and the IRQ thread
disables vector 155 and logs the failure, which leaves the queue
unserviced until the device is reset. ```

So `parse()?` returning early on failure here is intentional, but I
reckon it is worth a comment, especially since the behaviour is
different to the semantics for consuming elements regularly (still
consumes and progresses for failed elements). Especially since you
wouldn't expect this behaviour to differ for a method which explicitly
"consumes every message the queue holds".

It looks like this is acting as some kind of implicit poisoning.

>              self.gsp_mem.advance_cpu_read_ptr(pages);
> -            self.log_event(function, seq);
>          }
> =20
>          Ok(())


