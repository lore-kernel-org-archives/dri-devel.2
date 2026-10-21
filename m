Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB0606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PdCXj3Ns
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740DA10F851;
	Wed, 21 Oct 2026 02:00:35 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFEA10F851;
 Wed, 21 Oct 2026 02:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noagW5JVKQ61dn77Htv9olffoGetrVy7w9z7g+H3fiQrbRHkkeAsKrVnfGXIUZT4dhizKYVNnwdQyzNYjuHAHXcyj32X1WD3RB5Ro8wXdSlkcRTEBiu0VjkRhP+CKnPOGrcBHISDViA8zV+T5oBEYHFsnRxHxCAFp/DMiqnuHVD5azkdxnUiqI7IsTPGODeJkxs9jWnXY9d1ayfwsxjT8kyZPEbEZbmJ/q9qqfGpUrPrWdLXNArangzkMAEJAO9dM1HZetKyV6DqOPIpvjBlAsmB0EslvXPQV+8TVva9I6B+1JJHLT2qmDCTgRVatUo7MI33/ctbLdsplleNZqL+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzBm5Tux/TCE8CqVbQkqMXg4y5/9VlZ4Sm0d2w/80Cw=;
 b=v3bYyRKyyYB25QcgJkOre0tE8xo1YR77XJO3ZyfIikN8oq11YbsL2G4WReLOjb/vh7OjHWCh8Ip3CuLOH7ONQ+H2g3ZiSonieYkCRIjAgQuLIqFRZHDFA3dNTQEx7wHhXVewIS86wVP5wKu+u6pb/gdB4q7KAg4eTpc+2Uyn3Vsv0YV3Imssvc2A7tA0GqPUmuacCdQpyeZ7EOM8X/FyPUnHpWoic7QoyW+lYDFtz6IH7CndFlwzDulqsMpmUcoJyqWx49VeV8c7k4YiSXUWsuw6UVWJPjTNMb63OPEZHxWosDtQ4H4gejFdyKSeDWX3Lb8VFmsYOiSSZ1Q/F+Jdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzBm5Tux/TCE8CqVbQkqMXg4y5/9VlZ4Sm0d2w/80Cw=;
 b=PdCXj3NsGCHtQJKnssIa2Ux0xxjWoetrZtpS2BFv4xnomeJsP/3GTsCoXpy4jnWFnKBoEP1m5Slt3LlYGTzB5oOWpXy//Y/PLogDx4mkNeYXEpMTfU/YS2jlaK6anyNwaHJrOfC17dt3181gO6WVzzDRSU1uvVZtaSCrVLeljE4hclDrBjN374re5+9bdZReVbQkcHLpBQRPhEjtiZU0KCeiiCFxhLgsf+FB2nvwfCM491CVZnhPAnxo11CSYT1U/OJSyAfRsDm4VRP4qjPl7a9m85HuCyVaSy9Sloq6U+vdJCvm4X5idACSwIHVo8MwEnmaymHBNCZ7KT0wPgfJ6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:00:25 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 02:00:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 11:00:22 +0900
Message-Id: <DMA58OZJI90T.1TLPRRNK01E2Z@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 10/14] gpu: nova-core: gsp: cmdq: extract
 await_msg_with from await_msg
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-10-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-10-dceeb8f360ec@nvidia.com>
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dde4a2-41f0-4b53-4662-08df2f17128d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZIKbZlgB5wazRCH2fRvpTYTmMndj35TGbwIfj1pXlqJqAi6MSrfmiHSN8kXDsUkG94I4GwSTC0iOJ6z2NF8MqFOBQwiNjwwYHJNgh28KujKQlOKFET6pkGWvrVj6tHOmqtfde3BZiOMVX0YXtSEGNH+22fF221O5lVtHfbWv2TJcdnEc3z1XIgsvp5lJDaGSaPVRqvW2J1rUij71HS8L/3PJazeODbOWFW6qRwf2z40spmsBnKhUf7bTQDpR/3KsnHMLF4Hs8n373eCGjkaYrVgF7dBdnjYbrEhE3n/FIQwDpPavEsBNJpXTZiEil8Ls6qQRY77+kn8qiyFNKLfRBavh2xS6uuNN0NWbtan3tXhSCiJi3JY7rDDIbJC0kdbzt9mWT9UeG1wiXUko8bmmnoqEF7emtgWG7Rms+v3cZwRz5capGSbnkMLWzq+RwQIsIh+QYehonhAG2QqyXr0Ww9lE8xhU0jzcMBEsEhRdQc/l/rKKWZ/A31pJY6nqzvoSUsXBt/LBAmvlNEIBULciHGFQwDzXbynNl2ayvsCIGmXT8v5oAxpicgcphAEAlS/1seIxBky0Ep1FzeJwJufdIcdF9cz/p/Cutz39uockJ7ZUpsRy07vHWT9McaDkx2IHr6QhpSrItURKrr+xKsuGWj+jfGENusLDXRfa1kwOIQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxUZGpKS0xJRG84T2dkYlRCUW8rQ2JLeUxVeFpVV2dwcmhac0hoRGxKLzZQ?=
 =?utf-8?B?ZVJBQ1hubFBRWjM0WmhEdnVRU0lYbXI4a1VrVHljZ1RTajlsL21PWjNkcjNw?=
 =?utf-8?B?SSs0RDlrMTg1dE15dGhXOENIQjBPcnpnUVI1MHdhU2lyQTdiNHQ2Y1l6T3d2?=
 =?utf-8?B?N2FpbmcrM1pMZEJYSTNWdzdHbTlaQ202K1ZOQ0pBK3FNeUE4NHMycitDT3Ni?=
 =?utf-8?B?TXdXRms5VGtqUlNKeG9DdTB4WnN6YnRSQnJrbWViTVA0Nm4vdFh2NmZwTW0x?=
 =?utf-8?B?RHFZNTcwcFkzdlNYQ0gyMkkvZFg4V2d6NHh2SG5OZlRueUNBYTVvbGkxQThG?=
 =?utf-8?B?MTN6REZZY0lOUVJaUWt2Z1RqSXNMRTZzS2c4QnU2dUdKQlV3WUduVXh1R3VG?=
 =?utf-8?B?NVkwVzNDUnhYRmplYzlWTUY4eE9zSGJJMDFqdFd0dWdsZnJEdmNQU0JSM1dQ?=
 =?utf-8?B?S1JaNkFEb3VZR01aZGlyUklNZnBWcHZUcmgyNUZVRXRsNWpROUVJUGcrMFBI?=
 =?utf-8?B?RzRjdnp0S3dYMWE5SGt4K1Q0SVBINHhURXpKdEpBbmJsS2VPYktlbU1CamVH?=
 =?utf-8?B?UTAyQ3ZzZTBublZVS3RWeDJlTEFNdEVTaVFKRXlaYjV1L3Jid3JDemFrTmhW?=
 =?utf-8?B?NDFSWDlXVWFlNDFXLzlFTUkrWE84R3p1S0k4cVBKQ01HUEtLL2RBYUx4WkIr?=
 =?utf-8?B?VUQ4SUFEK2hjRWFqZWxsT3duRDFLUFNjSWlmOUlvaURzUHhsdHZaY05FTWQ3?=
 =?utf-8?B?M1BJSU0rcVZUTG9IU0p2eFBEaGQvZ08xbVZFanlsZUY3WWptSG90OTRaUXBo?=
 =?utf-8?B?c0ZBOFE1L0NBK3I5UzVDekFnaVlwdTcycGt1Yys5Sy80M3F5OFM4bVludlB3?=
 =?utf-8?B?bm9waWdvQmZXOFJjUUpUb2RsbGxQSXZZQ1N2ZjQwa1VmcSs0bjdTaG5EenJz?=
 =?utf-8?B?bHh0SGNmQkNaN3lJMWRIaVpHM2Q4NjNCdnorSDhPTnM0ckY3TkhKZGV5dWRx?=
 =?utf-8?B?WUdCeDBkWVVrMmFZT1puczFKckdUTTcrRWlFYjdwcml1UnkvOHg3S0hCUkQ1?=
 =?utf-8?B?MWt4R2VObWl6QTcreFZWMElPSVZUTkJCejlFZGk2eEZCM3pIRmQrSjlnbXNK?=
 =?utf-8?B?NnExemxybGNnNHVUY3FpUEdyUkFqcytKV0xPTWZsSHl0bUR5VHdNOFRWWkdH?=
 =?utf-8?B?bVQ5bklBbG5OOHhRV1JNSE4zRXF3NXhMR0h2M24zUVMwa29MUFp1N0VxUnVN?=
 =?utf-8?B?U3VTdHExaHBidmQ4ZEFaMHV0UnFtd1VXT3hLc281UHVRSVBLRFE1K1BqalN3?=
 =?utf-8?B?cXhabFZmcFhYaCtSUlRGaGlzaUZZS0piUkFvWm1uUjJuVTVINWQ1dWkzZm9C?=
 =?utf-8?B?Ykl2Vng3em9GV2o0K0U4Z3F1RytQUkIwOXhJeU1GUDltYW9GRXYwM2w1NTdK?=
 =?utf-8?B?MmJEM3B6T0NabWFHQWQ2T3FRTjgxZFplRmowckY0REh1MHhTQ2txeWRsSkt1?=
 =?utf-8?B?QytCUTBuM0dwUVVnYzkrNzY5M05RcGtkQkRtN1lNbTZBVnNROFpadnBBUk5Z?=
 =?utf-8?B?bzZhVU5mT1c1RTlKcHd1QlRCbFp5TmJyY3hJa2tZZHd1eHlOZVBDMzVHSXBm?=
 =?utf-8?B?dkUxcFduOVcxaHNBLzFLdFI2d3IzMlNNK1RrdlhudnBhSlFscllWYStyNnJZ?=
 =?utf-8?B?KzBtT1I2c1BIb2ZVeDd3NFZOeVQzeE4rdlF2NDNPYkxmc0lwQXlQencxMVh0?=
 =?utf-8?B?aHBGN3pOZDF3bWVqSE9CLzlIQ2s5OWZkN1ZacG1TcWpRSGtVQzlwQlEzUFBx?=
 =?utf-8?B?anczNHMySk9XUEtuRUZaYWpnQmhPWFRRWnY4SURtc3gyNVJiVUhTcU9iZ2NW?=
 =?utf-8?B?QjJEWmxVWVU1S0VXYkNRSG11WXZRbFBJM3pGOWVCUkxDUUc4WkVKcFExOE1S?=
 =?utf-8?B?cFd5V3JQZTZsRnBOMzBPbWcwcXRYUFRJNzJUVGNYSXRHVGRVcHcxRjdLRGRi?=
 =?utf-8?B?OER3ZzE4WlVDUW1uSzZwVFM2bXlHUUFZazZjYnVQUlFuMlRidUJKODgzNVI2?=
 =?utf-8?B?dmVlb1ZCQTgzZ051eVB1dktBL3BXYkJPMWV6TXFWZitGcE1zV2pKdzRPWjYz?=
 =?utf-8?B?enRkdWI4OXRqb1AyTGg0K2JYVDJMUklKaXcrSS9KeHVxTHZuQWQ3TDcvY21m?=
 =?utf-8?B?RklJZUxRdzk4WWFrQXR1RnJ5c01wVmFWODRSTWlHc2krL2hkUDRwZVhNdmU5?=
 =?utf-8?B?Z1cvblZFb3F3QWF2VnNna0JVcWtsbnJpaEZocnhuV0QrMDE4MDJ2RldXN1Rl?=
 =?utf-8?B?WDYyaFZJaUdpSHdWTmQxVlZXK01heGl1WVRMRnhwQzE0VHNKUU9yKzVLL1Zq?=
 =?utf-8?Q?Qmc1kZh6p8xbnMXplZlgbux/JZFdpx3zjxGei6lh9BHIG?=
X-MS-Exchange-AntiSpam-MessageData-1: +WPXe5Asiv8z9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dde4a2-41f0-4b53-4662-08df2f17128d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:00:25.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7p5WFSb9amUlsNbJeC8s+yVJ0A8MBSMY7fNHoGJ2orB1tT/tl5q1GxnVGHDXC+LTwwC0wr7H995KYkPa68bOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 7:08 PM JST, Alexandre Courbot wrote:
> The logic of `await_msg` is also usable for other kinds of messages that
> are not RPC; it will be used to wait for GMC messages as well. Extract
> that logic into a new `await_msg_with` method that uses a closure to
> decide whether a given message is the one we wait for, and use it in
> `await_msg`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
