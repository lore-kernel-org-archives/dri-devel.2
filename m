Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70057606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OM9WgFPE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C834110E2BB;
	Fri, 20 Nov 2026 08:03:33 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F304710E2BB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msg6CJ5a4TCNkicYllDEPRYnQZmHZdW97tJsixniBLr5BRDSDdrBDmsdk0D/AcG0J/jWzbTompHn4s6UX/pTeu3U6OFd8LrofPvmorD5RSBHNOnEMsKDoEpFdhB2tlPcidePiAxnR7NzkFfAXRou2bqTfOSBXYpiHubVksFTOf2w2ZLqnz3pzoag12JHDA9fx3vpYjmKWnzSYNHua3Fk+4N42YgLul1/3ekODHJSmshuPJbxOf+IQ1rnfzQXuSu7fNuAa7qMU6acol4vZWhDbY6glcFjFgib+YWN2wYliwfXHjrFAr+hkGGR9vW/tmUxMEgvnrd6nZmx8MoYavIRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS0Yf75JJoXcD2Q1sG4S02/tDyuXkWoxaVaBuCMQ/pM=;
 b=emHfAodRWV36hs+4BXbj+RAj59n65F4CK+Mstkn3U+9ZUJ/uNYfp4MgS8sOrvqinUy1PM8UWLUZMGJ36XnwfhqywMm6e3xR0YUOC61IOJpZn21Nw57QK/MtrHNB7m+ZyxYzo0KRBKP9u2xxsXTglPbtZ+jZ75YnZ/Go4JK/w8R93jAWqgFAdpng+XvcRcnC9w/EJdzLkXyvp8Pj+qDdl9C0SSek3OB6ovsryCOn8Kv9+5gkZ3SR7NZ/fNQrhWEi+qjYoxSpF5l/IlbK4QVk2lo8MWR69Atu391Loffe8Zs2xbJbtElZECm0E+VSKgUPnWN1iiirFbj7OhQjn2qO1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS0Yf75JJoXcD2Q1sG4S02/tDyuXkWoxaVaBuCMQ/pM=;
 b=OM9WgFPEJCKwBQCEB8wRx9/9gvM6BbUh4NFWDS/JoYAXf2l4FvlCQ7vOdlWJazm6C03Z9GFQ36PFCeEUVc3qLscj7j5cErnAZpaXqfybyfxJFPuDHwCFPrXleOB6tyxQIv0RsDhs47Qvj23pYVpbcnYh+1d0px0q3DN3ZEHbJAs0FSMw/Fl6rM2usF6fh+5UNYHJqN0RgqHaKEQ7NEq8Fh6bq6Y9k1qXSIFteZ7VFh3FxWohP56a3RjIax6bcNot5f4wNijbMiGUrdSzIIhguBwJmefdwBM+aE87GDGaNc+zsjAtlK0DBOmvOA1inHE7ix6MN95H544NJkMATfHPkQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:03:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Fri, 20 Nov 2026
 08:03:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
References: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
Subject: Re: [PATCH 0/2] gpu: nova-core: gsp: cmdq: preparatory patches for
 r000 and vGPU
Message-Id: <179516171573.1647833.148942505914533954.b4-ty@b4>
Date: Fri, 20 Nov 2026 17:01:55 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OSTP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f515e8-7233-466a-9f34-08df46dcbf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|3023799007|56012099006|11063799006|10067099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: s1XySQJTGWZABrkaw2/jnpSlORAFfUqIzxHyFp3N6sUMun/ELbQzDLl6uWNj5BknNs+0IcKxnZCmHU7vB9njG2kGHAQ8RX7wO/NDk3NcdEu2YyirDjhuL+zq8c9rIH30KeyI9OAh2n5YJWxoGkbRyfdK46N5dqNwjRQvb8ggJUrVZCemuYhXu4hebo51apULORO8mbwhH1zqf/Mqs10dALNH7n66kiediKfYps2H6n2qytTncxDW3ZVl4/QeWKxfvo6/EP8LR6i7i3dmIUrwWSmv2j7JVTj8L9muHst9T3yIZ4K1mKi0JGk/FfS2Cg68vA95NBkhWuRCR0X8hU1AHk84H4ATrgJzW8YeAL/TVIXglmOe8M78rQsQVYhCKSiseCrosmREdtPXtY7A2AqJE2OLRZF/whBzVodkMMJXrRSgJvPYCxXjjcirrktVeu95SCpSVcZlx4TV6BQdi3fycln7wk08g0uwZog6nNHJerUf4AZzdwJhET/h5cOf1I6UsX+2QOK6Nh1erCc+9pbpp5O9V6md//H3feOuvaAoCsT2s3yJFx5rW6EIN9syreI1fH9RMhm4wznlmmX3YR/hh8FDPJvmqE7P4aQS21ExlV46RayX8Qj+9lSIQqB/c3cSejJgmFHyU64MMpYWsmEkLpoVz6MBG+PiBQjmo9vazZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(10067099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZNRUd0N0VsN09oRDNNdnVHZ3JFQXA4ZXpKL0FJdEMyVHkyQ3orSWdSZmZy?=
 =?utf-8?B?cldGU1F0SHRPQjlSRHRLQUFQWHkwRlRKcmEwV0lzUU9hT2RFbm9MdjM1SjBy?=
 =?utf-8?B?WkNJTFpnMEdSZm5BQ05LbGwyN2p0YTF5T2F5cTR5QXg3WGppQ2tYRHdValFs?=
 =?utf-8?B?azJGalF5YTcveUJ2Ym56bjNFenZYbTFCV25tQi91c3pWTTJCbWRPdGNOZVRX?=
 =?utf-8?B?a1p4MW9UMGxoc3BGODI0WUo5bVBZODRiVDlSYVlsVk0vTkhXemNjUmoxbXV4?=
 =?utf-8?B?b0lsaDMrZzlzd3F6c0trcjUvRFBYYTBBV3NIRFJkaXYyQlJQZ1dBUHIrUWFD?=
 =?utf-8?B?RTBtVnc1dWRFc0RLUHBwbTdGVnNPQ0RPekdxSEtyNHgyMWJzNTRhd0FWQlE3?=
 =?utf-8?B?ZUxDNWJtNmxVaytxMjBYYW5hK211czZ2eUlyWkhGVmo2TGFSanBvTE5Bbkgv?=
 =?utf-8?B?OTBMR3RUZDEvdGNYSml5S0drVVRiSGh4UE1GZjQ0NDB5VFlsckhrYzJyb3V1?=
 =?utf-8?B?R1BXMEhjWndoRXdrMXczc2xwUXhKRGpDQTNIdkc3R2JBbzdLUWppdDNTQjdR?=
 =?utf-8?B?TnllaHYzMGpYa3ZCc0ozVHhwUTFodHVSRW1kTkFNb01SUW02VitWZVd1bWt3?=
 =?utf-8?B?WGU5Q2dzWWp3dW0xdjJLWUNTclpPS20zUk1Cc1BjRUtxL2xIbyt3MjhGWEUw?=
 =?utf-8?B?SFlQeHFESjZuOStFK3M4NktmTThrZ0Z4eXNaaXNKT2lRMmx4VDhUVU1QOVdy?=
 =?utf-8?B?ajFsZzlMTHE1dUxjSG1OditYa1cwbGcrWXg2aENiVFBxbnFMWDEzSlMraHVn?=
 =?utf-8?B?Y2hrZXN6NjNaMEd2MGZaWGVOVGR0bEQxaGVmYkF2SEh1YU1peUNxY2srT2k5?=
 =?utf-8?B?RmpxWDEvZFZVZE1Ka1JPY1FNdml4QnRuYTk5RWs3UFdjSHhxN3FxaStnVHJX?=
 =?utf-8?B?S1BnKzdhRFhZaTRNSUtwVk9kYUZpWDI1YUxXTGtLVmdLQTFCVVpzVDI1eDE3?=
 =?utf-8?B?WGpaWkpMaGlyT3hyYWx6cTBVb2VXaFFXaCthd2pxcTlxWXRwWVhwVzRHdmpS?=
 =?utf-8?B?Yi8rNUNZN25RWUtIMzZxVDB6MXJybXJONWZ4dnNvcGVFQU8xN1Y0YzRGM2ZM?=
 =?utf-8?B?UXJPMWFjeXJjaW5iNmxyYkgrYTRyelpIWFA2b1hxWTExK0Q1d3NacHBRWTBj?=
 =?utf-8?B?K1g5ZUJJVVBPaUVsOGsrd2lHalFhbmZNZHZJaDRiMG5IV3VvU0MzTzVjbCtl?=
 =?utf-8?B?eGNrR1hPdlI0Si9Eekg0VzNSL1pKRldheTlyUThJWVFmR0hmd3FSSWhLQ1FU?=
 =?utf-8?B?Y0Q3KzJIUlBlbGwvZmR2ay91VGVnb3VRQ3h6YjM2ZC90Q3VIekRHdTUvMEZz?=
 =?utf-8?B?eGM0aWdYVE0zbEg2Y3o4ZWVnd2lNWVg2NVpESGc2bEk5OUFSTkIxMFpXZm1t?=
 =?utf-8?B?cDBKYWVMKzRYM09Nc1dsVEtFNjZXL1VIblp6cytuUnA1MWZ3Wi84UnRIYzdT?=
 =?utf-8?B?aVVsWnFyNFBWYlRNaURyblVGZ1RuQXpxT2grWXRjV2pTV3VOVlhUM2pJYUFw?=
 =?utf-8?B?MjZmYjhxQkFIUEVtWitsbUVzOGlibnJGS0I4T0FGVmZFY0MvSGw1ajdtKzJH?=
 =?utf-8?B?QW1ZSXlEY2YwVWRTMXI3OWg4MFNzeHpaRVVQdHNoUGY4dGVZcHUrV2ZJdGJu?=
 =?utf-8?B?V29aa0hURlNWWE4wR3hJeEVtdDFQWVpyZ0N2SUhYWkR0NDBCS2syWTlkZDlh?=
 =?utf-8?B?ejJCZm8vTmFyRUdxSEUzdnJBZXRlZFN0Kzdvb0JZS1ZLVzdMZ1hrdHI0Y1NM?=
 =?utf-8?B?VUVQUmpjbTVHZzZaOERxZmkyblJ5NDNGL1hla2Nob3lZY1ZrcGdJUHNRdVlX?=
 =?utf-8?B?RHJ3Mjd4OTVuZjBkSUFqSmhPSlpoNlJPM2QrT3VqWUNwait0UFZTYUYrR2VE?=
 =?utf-8?B?L3dGRm96MTYxUVhuamRncTZUSUtmZ1o2ZEp0TG5PU2srVUFib1NBSDZuZkRz?=
 =?utf-8?B?OElWV2xMNzFjUDlqSzd3LzFEZGxTd3F2RG5lNCtwMTVFQkxvbDhJbGplaFJK?=
 =?utf-8?B?bHRJd3FkTHQxQWx4WElwWVVia1lQUm52Y1JiWEgyYXhzakEzbGVYOTJ6NUdH?=
 =?utf-8?B?VzlZRXFidm8zWTFGOVVxSXBTUDQyeW91VGkvZFJLVUdSdnVMR3ZPSHJldVNQ?=
 =?utf-8?B?YUo0UUxsV0ZHWmlLc0dXclN6UytDTFlaM3BUai9TT1FDZ3AwUGI5bW5SSmQx?=
 =?utf-8?B?UWd5c21WRlp6VDlYTDMrTFlNMnBiRUthL0RDNnQ5SXFhRU5sMXQ4UVgvYWdX?=
 =?utf-8?B?VG94NnVPTU9McjF6aUYrZy9nVVhOaTA1bVNoLzFjMW9yMG5idVFpWEsxUExT?=
 =?utf-8?Q?3RVIRjIuuXGREiA/clCVlNsuG5hyNyq4y9fomxvsxHPF4?=
X-MS-Exchange-AntiSpam-MessageData-1: 4z6X27qjvfzFAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f515e8-7233-466a-9f34-08df46dcbf98
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:03:23.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMXWJm9Ohslj6OD95ZoDHLHlbGv61gjoO4dbMuh/nVp8uCvJG5/NAGIecjz4+b6XSf1PgsNHcq4MI5I5v6qelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 00:06:44 +0900, Alexandre Courbot wrote:
> A couple more command queue patches for the r000 and vGPU work. Patch 1
> allows commands to specify a custom timeout, as some commands can take
> longer than the default 5 seconds on occasion.
> 
> Patch 2 adds support for GMC commands that expect a return status, but
> no returned payload.
> 
> [...]

Applied to drm-rust-next, thanks!

[1/2] gpu: nova-core: gsp: cmdq: let GMC commands set their completion timeout
      commit: 43041191152d2e8a1371ca28b4f4fcd507f422c2
[2/2] gpu: nova-core: gsp: cmdq: support GMC replies without payload
      commit: 3b63cb016422199f1bda9abdb6503451d3ba9f1e
