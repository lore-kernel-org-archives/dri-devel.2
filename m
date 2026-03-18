Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6113103E199
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7F810E710;
	Wed, 18 Mar 2026 15:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOfEOSgL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1E010E710
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM6RZ4KkY+c0zIRwaxjCgmf2741U4zaaJqlgoD/NQ0PkFqj5bv1Nu5haYe0dwvMCv6wPnIRFjEk33izJfmE7shRX7XDEF+jJelDPi4mF48FDDD0qF3SJ6r8S/4hpF/5vRCxHCC17cTw1bgAOrFyvCY4N44i6OYdAs0jyn/Un3Vh17SMz3lQs2J2/KPM1aGcVmXLuKV+m3kJCrSOnwIXSZzDIjSrVaqtOGFEaFC5O8o3aP92TMA7Y3cKK2Smwri/wU82cDJgDYq+sYIL9hKTvCS4Qpx4MqlH9xR27Ddc5D8DCZ80eOuUJC/IxBzZZZNnhVyyzoImzeJ/OdGFxep1C+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yL03oRVDg078y/+F+vNp9rWvp4Ft/5bDDTu1eETYXc=;
 b=YjAgv8Xy56jNIEvRaLDDlVlsoosluqXw2WDKt6L98DC6y/YRNNZ9pQstdYlXFTc/8TrcS10pV+DRH2H8QyiH/B65U5hiQILRDmbE17YeMKGh6IQWmTZmkH2bsKkbaiKO97plSgmgqqA44ar655R3byrzzezNAiQv5h6NQYA/wwuwIIwq7jmWaFXIZoPOGAv+EHH+Cipxl/1lZ4S0yuN7V0UIMKQ/kCAzow3VBbs6pOEakEG112QVuG1e7lRt55/h5fNpGweTuLHx1mM1xDLfy1YAeQEl+d8+vBjLMIY4G7oJxSQ207AbS156DThbd2gtTRsmdamFLMDa4XRqqBgOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yL03oRVDg078y/+F+vNp9rWvp4Ft/5bDDTu1eETYXc=;
 b=OOfEOSgLbsPJ8OOGRhkYtJiYF4+9faWB1aZUJBsuldx+JqdGh9rH9dYKBIzCYqn+tPPd71rqarEamhvROG3BWKDLGVPrZNZ6gnU/fuC+orz7ykreGeet1zv/mJJ33Zf/H/8en6SvZSmJuPKsZnyIoqJotTGsZ39ucvpbgUcb+P0hR6I/lGuIp/1goz1L5AT4fKKk04erbcDHnzUosudgvGHkSFnzkCiK6463GBqJKlw7mpKn2iF3wq9lh3XS3OVdmwwgi8FekKxac3HUAIixfMSkha1/gF48BoxBh2GFOE4B4nwORMfT7jAd5vmXU70elHS0DjIzpitQBQqFzCtKYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:27:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 15:27:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 00:27:43 +0900
Message-Id: <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
In-Reply-To: <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
X-ClientProxiedBy: TY4P286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f62ad4-8f80-4a76-9d2a-08de8502e9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bw1yuCaPziq39XONGQYBkoWQx/2lvyxQpc+hL8Hp3aoD2ix30U2jWUsP6JdTzO0ZbDauwLq1FEB+FMNYztKWaSGHyi4OkH2wLKISf5fyhQcebIwG/I4NbGtSjwz/UIaY0JoC/axAby2K1YkD8pF7ENSA3ncmZht289vIBEwOtbev8LjVn75klepbaw8bB8KiJ+wj4limw6haDrDsBTJOjVVJ9LyV45SXlVZB+56wBuMw+6jF6GEOb37zb4mqh4pURWEmHvDTFTwBFRrPqp0ij1wgRYz6ZFhUm7WEY9tTghkTDbBSEWjYIL94bDCP92iV5U+hVdxLfMKiCRgQcACXo+U9Elm3LY+7thjOv3yus3NxTJhbW0CCi2xkippRio+LQ4kqXgOfUz786uJLp5eCvatCphj0kfQe7T/1ev8vzMnb6sFLAiol80gPJ7coPVPLGq6NwspQ2qjHS/qlbsQK2A+69HvuZqalscWwYb0xk5ehpW0faXmxfaJgrfRIHTRMfJguZPTgvdBsyB2d+Y5udG4CDl1D58a/jyybNmnS/6yJS2GVpTGSsc48Sj9ppXK3KqTyyKcX9Y+IYmi9ITEffd+Jo2Rx+XVB8wP2DsTmLcr5nbYHQGs8Pqc0UxcxFzNJ3oKjPuUY94Xh4hKYNYI7kk/WIje9cL4F/rIxzm2OSbhgXZRxkcbGrgir2q7X0fN76Yf7uPDloxMO544z6CL05hcrgDznguTSnGy9BV+HWhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNVNGdLTnRYY0w3WlFRUTBpem5scWJaaDZxYjNsT2pZbW42ak4vM1FXY3FX?=
 =?utf-8?B?UTJMU0tHU3g0SlZhZjNNbDRYZjlKSHVEdDFmaGR6eEQ5eHM3cVREN1BaOXZO?=
 =?utf-8?B?dDlQQXM3empWK0FGT3hMaHN2WThTSDNSUkpnQWpmWWVhb0MxOGtoR3FGZGFj?=
 =?utf-8?B?eGJMTUNoQlRyR2pFV2I4TEw5L09BS1p4SEhmc3VoYmFJemZqemE1S0FwN0U2?=
 =?utf-8?B?eDBoK2orVEJ2aDMrOHo1SlR0eituRkZORGE2Yk9LMEdpQlozMUd4M2V4Q2pr?=
 =?utf-8?B?T0IvT0RXakhINHJyeWNVbmZld3lnZkdtVmVKVm4wVktHUFdrZkw1eXZTem1l?=
 =?utf-8?B?Wm5CdmtQZEhWR0JlWDN0U3BaUytzU3l6S1hKWm5PdDdBM29CSDBHUU1wSnJV?=
 =?utf-8?B?dENYejh2UHdXWmZhaVVncU40dXBaQ28rNnhiaEFpWFQ2YlFtT21kNlQ1dVZX?=
 =?utf-8?B?TGxTT25UQWUzL1JzREtPaFBRN0l6bFhWWDhkNGtOY05XZGxOT04zQS9Dcms2?=
 =?utf-8?B?dHBBRFlQU3U3NWM5dVNlVFdMVEIzdEF3V3BEODZOV2x6djZDeEhuMVpkMjZ1?=
 =?utf-8?B?Ty84NWl4alN5T0ozeGUrTDJkenVmek02RFNlWnpqSjhQMk42a0tHaHJlaEd3?=
 =?utf-8?B?aURtd1ora0FNNmVDZ2tpWTFVOHVTOEhqdktwd1BYcllad2JldVlqaDhmN0o0?=
 =?utf-8?B?OGptZU5LUUpCc2p5RCttMUtnRVVSK3RjSVhZdG00UmdIMk1pRGdJeVR0NUV6?=
 =?utf-8?B?Rjk2YVJaYitTS1NMTTRTWU95dlJPSVA5UWJCTnAzbzRRdlgwVGdBakFyaExO?=
 =?utf-8?B?WVFGWDVKeUwydS9xWmZrZnZiMm1tRWJFNXFTaWFTUndsVU9LTnJ6MnFHc3J3?=
 =?utf-8?B?ZWNPdmM3bTEwa05PRzRYOXYwN3ZyZlh1aWV1TUczQ0dkWlVnUjFydlVlTmZ2?=
 =?utf-8?B?eEFiN005aDZhWWh0dGhKQ1RQMnhzK0lacVhQYWVQbXQrK2cwVzhjME9BRDNi?=
 =?utf-8?B?M1pYOTQwUlZ4ZkpWZGZTVmFUWXozdDdrZXZxZm9zNVVMQjRPS3pLYVYwNE9U?=
 =?utf-8?B?WHVqU0xKci9FaGVVSlAyekFJYllqQkJHYjhBUWJsdEs5dW04NnhSMzNsWWlq?=
 =?utf-8?B?L2tON1NSSEUxZ0M2Q2syUkViWURqcmxvRGZ3Z1FaclprKzFWUEtxM043YkZE?=
 =?utf-8?B?VXVqRUJWbm5pU003a0FFQTBSNlNkMmRJSWRyVVAvTUVPaVJaSThsOW00YU5G?=
 =?utf-8?B?NWxSOGRKMzN4WWRpMG5TUFA3aisxYkNEazdUTDlOTUxPNnNyZVdDY091N3Bm?=
 =?utf-8?B?M1gvb25uZEd0MitNL0lhU2h0VTZaWVRDaEIycXh5cU9hbDhKM3RQeDJ3eW5x?=
 =?utf-8?B?ekVxa2poVC83RVJLbytRNkxHNi9MQUdBQVE2bGYzTUVDTUJIckZKVzVnT0pT?=
 =?utf-8?B?QklzVmZjQ1ljallxSStwSkVTRnB5aXc5SWNKTzdyTTUzYlpleGNiVllLNWUy?=
 =?utf-8?B?MmZQMS85czFnRVNreHJGYmozNDdEVEhtR1ZHZmFRQ3RjQWREM3NYTFl0UHJ0?=
 =?utf-8?B?ZkpuRFdEblFXVU9SMVl4MHJpRnkxR1BuSW9FcEZZaUl6dzRkYzRJWC9UZTJM?=
 =?utf-8?B?OFlTUWpicmlYT09wMWtJcjd0dWhSMWtEcVZYNmo1SENyN3h2cHJGNVFJbktq?=
 =?utf-8?B?UFdQMmhyMURBbmFUT1d2cWJsZWFsdytSNXpCSDk0cExldUFnQUMzZUdYWjJu?=
 =?utf-8?B?bG9sOUVDZmVZMFhlWjNGY0ZHRGdtRExtMXFyUjU5RFhJQnR2R3l5LzQ2d3hP?=
 =?utf-8?B?RGZkUlI1QUlwa2FFWHp5K3RvbHRTWk9JWDZHbGkwRGtIejZUWFdtUkJ2Zy9u?=
 =?utf-8?B?dkd0Qkxuc0NXL1JZNG1iNDFzRDFMZ3ltT1g5V3h1ZmNWeUdtckUyZjdqWEx5?=
 =?utf-8?B?aWQwU3REOU1zR3hJVDZRNmpJU3VoaEhoRy91UW9LeWh5ajRVdjl0VEhnRTJh?=
 =?utf-8?B?T29TQkRML3ZRUnpyaldUeXlFUm5MTVNZYmRLbzV4Q2tFb1JLWm1JbGxGZlNv?=
 =?utf-8?B?SHNQK2phNyt3VGp6ang3bGJVZEdkTEk1ejhoejJZcWFVUy9MdjM3V2FBVzRi?=
 =?utf-8?B?WDZ3ekFTbVdUMlBtcjIyUnQ5WTltdUtiejlXL3lMVi9ZTmR3NWZaK29nRmlj?=
 =?utf-8?B?eWt5c1JzK1dpNmtBK0hFQ2o5OEJLM1NEUXFpS0ZBaVBjZ3A4TEdxdlZrWVBr?=
 =?utf-8?B?R2RkSitQMnkvaTJrZGVhd2dSc3JjWTNOdU14aG05TmdCdnJhM25RQTEwQTNx?=
 =?utf-8?B?MksvZHhpTkhQOGprQlVtQlNsWUJXWnBsMTJwRllNQWlQS2t4eHI2Q2RlYWpZ?=
 =?utf-8?Q?t9slpgDNZH/O11+ru8RXhLZc1btdja74S2CQPEbs5KC0+?=
X-MS-Exchange-AntiSpam-MessageData-1: 9GxtQTw2RVJ1Tg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f62ad4-8f80-4a76-9d2a-08de8502e9f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:27:49.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N31PBTFkyQNQttCyH0Llc5M1VGXNcU9eRv472TGqcPS0k+1H7i1pGw1DdogNneIyZwHRZPZ33ui3/SkwxNn+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
<snip>
> +    /// Returns the DMA handle of the command queue's shared memory regi=
on.
> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
> +        self.inner.lock().gsp_mem.0.dma_handle()
> +    }

Just noticed that we now need to lock to get the DMA handle. It's
inconsequential in practice but a bit inelegant.

Since the DMA handle never changes, and is only ever needed during
initialization, I think I will just insert a patch before this one that
adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
to obtain the handle at construction time and can get rid of this
method, which keeps the public API focused on message handling.

No need to resend, I will apply this patch on top of mine and merge.
