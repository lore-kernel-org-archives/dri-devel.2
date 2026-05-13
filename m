Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F28CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADD510E343;
	Wed, 13 May 2026 20:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oVC4hm4g";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA16210E343
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evmZoH+2vx0mR9heduOIAoDC4aOTfxm3KCEyC3o8e2HoICVKdoUeH01mHc1Xlv5jXaGRcw+hzyHfyls7tlNZQu344D9+IyMPWS5w61QxtmPJqjkUZQC19oJXwbnkJqSdk+68Efa+6uij679uo7765UKsau1f1rmgEnjEYo+K2FJysaYWR95yX9U9bqkOV8TVjX2KQ1A0FlU55+j3G47r5vLzN/zGOH4sfERDzlUDz3/9ZyshqDQE5M0LMBtz993jP9zrjPDhbB1fuIcJRLK01siyRm/wy1A9ahYIGUG7xNXewCpQklO3qX4t5eSvrK0PDiqjWA6VlY1r7Mx2FqKGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkcB6PUtx+eymFhHADSd2CdJgqhDUBgBojstAjS9ADs=;
 b=jKBX6Y4K8OvSF1UhHKVow4pQSeE5PbZwTyQoAv72y8+Oi9wzNvojYqkdDOSS8/J964PS82f1VNiTYMZ/lwbTwTNsn/hTr40jOqlX0N9yuzmam6qXDX67fLTZNr2zQRY74beNsy+/hXbCxvElkmVDsnIrICSLgymJxWs/9MNj52YeS9ZQ81BQ3seH/QYHPQf7lvX6Jnbh1qmqjRYur5f5ctWK2mIJckj1raCEM9Ss+stR+rPjLGayqthXuRzKdZd7b1rpR5X0Wxk5TN5K5XRxLtjlECjLWzH4cs9A0q/vSClVeqa3vIyQ3wxmLFT8yL6GAzKF/ovuRmZMFjq0A4BPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkcB6PUtx+eymFhHADSd2CdJgqhDUBgBojstAjS9ADs=;
 b=oVC4hm4g7xL6xRuUeDofviY7BaLScliGDOfHaDrfuREfDZ0v8hYNh2so7bTcM+X8jr1R5MEClU8HrmF05ImmIqVey8B3IJSP5gxbO3qahb5ISIm8TJyuVyOrgT9iXx6Lgh7IaGoJf43HjU+R4nGwpY5Z0CjQeQUitcyzzwER7uqF8u3hZjjE8CnacQe0pFsuZVNsCRGYEg7xhdP12vQ7B08425/NFxrgQ6cnpqazj3x2s24gAmNLfYkA2srGa4k55wYQ10k2JhckBGkTNfJuu/rOKd545sj8qdRm7v/W16U+inxHpgis9GgFSx+54pcm0FpnvyWd7ehXGI9SPtAJGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:59:44 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 20:59:43 +0000
Message-ID: <72641f20-a15d-4ac8-ac1d-26c88f52ee25@nvidia.com>
Date: Wed, 13 May 2026 13:59:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] gpu: nova-core: run unload sequence upon unbinding
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: e76a5840-1ced-4f78-c0a7-08deb1328ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|921020|18002099003|22082099003|11063799003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: DEN43iQ6e2oZajmc+lDI7l2/076MI/QiJ3KtRS0lrU6Reb7skwT0BmyT9158JD42gMDp4NH1TrHGnTB3gszT0ZD2u2/Uj29dUMVX1dBsdu+uJGDAYMJq3TMk1nGKP9ClH2YFSe8xyoA77gKH62926gofY2Xl0Qjyy68vqNvokJNhERC6Glbom8MoJ192mD0SenvzeHJbeLLOnAJRVy7b8TmXvrgUbG/CGYG0KrUq3M2YIgmMZxMcfoVdQxHmlQ5LkPxhO7P2R8f8wjPTBfjab+5Ift8ors153qB6Dezzw8NoThQW5+RFTB8uy4s7vnIVMf7WZJfDmxMewLr4LrneSVUhTdrR7m+oQn5ZGp3IQE9rGlDe8PWc1iYZeNY0pNp08alyKx2EFz/RGAGqMQyuscwXjkWYBCe6tHn7yA/gGpY3iLSz4PFcDV07UL1hldBIxrn+O+0TKsUaS+Uslm4CIW8AGiM4EajgPODDz7YYil7xmma/RqYYmBtShV5T+HI/1GBX/LYTqgTaVLWdt6uqgZ+FCkx+y/vHvnYLLsvSnbGXEvfOAclVPoYb90/qRerH0FvSAce7UIbd9WvjS3OCaUkIZ+2lgbEzMX5xmRwDDEhkzJ6ba0CSPcGXCK56V845OQM0p9Ntz4wFbRJ4ksdhjvjqHYM03xP8USAuP9SHlIiknEgnH8loU59iA792MezcCLhmELuXR8dS/rM/QYkSkbRVMFplM00tPsl6Gad/hsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(18002099003)(22082099003)(11063799003)(3023799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJ0K1R0cHZyYzVzVUd1elYzQmd4TUF2QmdIeHM0M216SWMvOGZndUcySzFQ?=
 =?utf-8?B?MHNRWmh6L01SOC83WEJkSkFqVFVKOTdBYWpyTW1EdDZNRmsxKy9UNmtmRUow?=
 =?utf-8?B?UC9OdzJWNERuS0ZueXZEUFlrQXpqVUZvSXAwUGhCdCs2bkkrcFQvb2JIL2Ja?=
 =?utf-8?B?K3J5WG85MHJBR2Z2YUtlc2M4SC96cTYxR1k0N3A2dkxSdEVqVGx2TzF3KzJh?=
 =?utf-8?B?eTBqNUJiMjJUZHQ3TGJwNHdPU2NwVWoxR3ZHRTNkbUNlRUFoWVZUYmltUE4x?=
 =?utf-8?B?b3pKMXFhUWlTbHEwbFNpT0FkUXZpYnNVNjF4NkhOdXpvZDhoVldqbnN4OGFP?=
 =?utf-8?B?aDNZMUREQ0NoMm1mN1lFT0Y2eXQzMGYzOXlmeFVSR2NSemNEOXZ2VTY3QTZP?=
 =?utf-8?B?SEFTRXlhMTA4eCtENDBMaUZwbUErRDRPMkgrUHArUUI0dytYekVzYXIrVG96?=
 =?utf-8?B?MFJNUFpjM245eUdYU0xtTkxaR1NTRmcyd3NySmRSYnBVcGRoQ2hlOXNSYjY4?=
 =?utf-8?B?K3QxU1hIbjlzbDdEK2xUSDNhRmxxU2Yzbk10SUVtTVNUNGpnU2RtdTcxZ1A1?=
 =?utf-8?B?UDc4WEJSd2FmVklpdzVRczM3NGJQNTBNRTVRYU4zZWd3TFVRamdSaWtiSnV2?=
 =?utf-8?B?V2ZlbEZDcVQ2WjRmSE95ZGZmWEVhMXorbXFHdU9YVnZTQ3M5cFhtUXZza2VM?=
 =?utf-8?B?bTdvbTFaUDNidkswVXVtcHdZOGdmR3hvS08xY2J3SkhyQXFYMU54N1NpU1Zk?=
 =?utf-8?B?RzZ1N3B1ajlxVTJUcWQrREljMCtHQWxOemNqL2FNdUhwREtPUUFtTThqNlhC?=
 =?utf-8?B?K3BXa3JNS2EvQi9vWWgrQklwODdkNVg3MWtQb2hlTmlkVFlIb05tWkVpYzVS?=
 =?utf-8?B?TnNxekdHN3Y2cmh0dHZWNnVoTTluQlhIUytITFNVdE1Vamx2eG9wWExYc25H?=
 =?utf-8?B?eUZIa1dMLzRkQVpLOEZBUlBXeWhKdTZ4M2xpNUhIbVR2VFRjYjZpa1RyM241?=
 =?utf-8?B?QVFGQlBOSXJFcnl0VUtXU0tBaFNKMU5vY0lva21QUE0yMTJGLzVEdEZCRHgv?=
 =?utf-8?B?Y29DSHdLYm5ERXZJWHpHSjNPKzhEeEJaWjk1TUZGVkZuKytNTEtObU5uREda?=
 =?utf-8?B?amR6U045dkFRQVRVcWd6WDdxQ1llbFRncGQ5bld1dmViSllxTzJka0U5bUha?=
 =?utf-8?B?ODdCK2FqYkEzQ3NLYjIwazNrMi9na1FtbjgxQXVQamMxNnRsRmhoY25tMHNx?=
 =?utf-8?B?YXVJRkNnZGcrOFQ1S3l5NllaMnA3N3hNeUFJZ054dU1QbEt6Y0t6RFFQSk92?=
 =?utf-8?B?SHZJTWVCbnV3dlhqU2lRUjZMU0ZtR2hKc0ZSRGdxT2JvSUF2MW1tQWdhd0pY?=
 =?utf-8?B?UjBiemljeXJRcnNaTEJhRXMxaWJZbC9GUVdLbHhYSFFtS1c2T1lUQWExREQx?=
 =?utf-8?B?blNMdWUyZzZDWWNHbkd6RjlJRzc0TitnN2NlcTBpZ3p0bXBrQjYrcTRIb0Fu?=
 =?utf-8?B?NitVeFRBTVUrWmQ3c3QzLzNBOXlNMlN5a0tFWk5UY3pPWjZGZ3FneGNZRkE0?=
 =?utf-8?B?TzBIWEFabXJFSlpwam1iYWJGSWxPMXlpSnRCUlptdFRaUEVuSGp4Q0ZUNDlN?=
 =?utf-8?B?YTBUZ1pEelMzYnV4bnBJSXFiUHpDREFrNnhnNnUraE9hVW12UUpuK3Z6d0JO?=
 =?utf-8?B?eHJnZ21YZlFJamJtUEVCVjhLZkVDWjcxVVlQRWEyd1l4cGxRdHEwU3R5MHZY?=
 =?utf-8?B?OE0wSlVlMXlaWE5FRS9CRG9XNXVGV0VQM0gzbHlVRWtYaGZPdEVzaUs2WCt3?=
 =?utf-8?B?NTJVM01mRFVvSXZCUGZ2SkdCbk5nckVrN3Bsa3B5RDBycHY0cEhlNEo0cUVJ?=
 =?utf-8?B?ZG5UK2dGWFFTL28rWkE0dnpKRVpDb2tlN0wzNE9hOEdUbC9CSjZsN2tmdTlY?=
 =?utf-8?B?alBuWDM5dkJHTzgvUHB6b0dwbGExbmQxeVFielYzZVZGWFQzSjRpbGZRSzBx?=
 =?utf-8?B?Um9ZN2pJT1BpS3ZqV3BSSDBidzF0OXRrY2w2S3FoVFRzK01jUlc3MktidFdr?=
 =?utf-8?B?VjdhNHVCbXZmZ25uVWd6L2NGSlN5Ry9pRXpzc1Q2cDBZRjBLWjhJNEoxK3hk?=
 =?utf-8?B?ZzdrMUpqRDVscHp5TFZXTHMxOWtWcm5aZnRqTWxtWmlRTXdXR0dIKzc2WTlo?=
 =?utf-8?B?bGhQcXhHaUFUWnNIbXJ6QS92V3NWM2c3d2F2YUk5ZVlKaktuL2xMaTlSb2tm?=
 =?utf-8?B?em5OVWdPVElrazJVQ0NnbURGazR0T211NTcwbjcxa0szaGF4ZUNFWk5GZTVQ?=
 =?utf-8?B?elIwellvTjd4QW4wZnAvdi8rcThhZFNWeEVaTXl3YmRuNitWdjVZUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a5840-1ced-4f78-c0a7-08deb1328ed9
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:59:43.8387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZHdN0JUTZ7FFic7OzSAQrBOJeUxYVUmImK3APZ1BvrEKiPTS92mGMEr1y/WXzDCOhOx7909SLccFmdIcmuoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
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

On 4/22/26 6:40 AM, Alexandre Courbot wrote:
> Currently the GSP is left running and the WPR2 memory region untouched
> when the driver is unbound. This is obviously not ideal for at least two
> reasons:

Hi,

Is this ready to merge, or are you looking for more reviews?

thanks,
-- 
John Hubbard

> 
> - Probing requires setting up the WPR2 region, which cannot be done if
>   there is already one in place. Hence the current requirement to reset
>   the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
>   the driver can be probed again after removal.
> - The running GSP may still attempt to access shared memory regions
>   which the kernel might recycle.
> 
> On top of that, there is a nasty bug in the Blackwell VBIOS that
> sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
> on the PCI reset to unload/reload Nova is really not practical here.
> 
> This series does what is needed to leave the GPU in a clean state after
> unbind, for all currently supported GPUs. Blackwell support is trivial
> and will be added alongside the Blackwell series [1] if this can be
> merged first.
> 
> The first patch adds a `warn_on_err` utility macro to the kernel crate
> as it is useful to warn on failures in the driver unbind path, but I can
> remove it if it is not deemed useful.
> 
> This series applies cleanly on `master` as of today.
> 
> [1] https://lore.kernel.org/all/20260411024953.473149-1-jhubbard@nvidia.com/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v3:
> - Disambiguate doccomment for `warn_on_err`.
> - Test the correct bit instead of the whole register value to determine
>   that the GSP has stopped.
> - Use an enum instead of a boolean to encode the power level when
>   shutting down the GSP.
> - Add missing newline to `dev_err`.
> - Add missing doccomments for new types.
> - Use values from bindings instead of magic numbers.
> - Remove the redundant `get_gsp_info` function.
> - Better document Booter Unloader mailbox sentinel value, and check the
>   value of mbox0 upon return.
> - Link to v2: https://patch.msgid.link/20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com
> 
> Changes in v2:
> - Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
> - Tidy up the imports of commands from the `fw` module in the `gsp` module.
> - Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com
> 
> ---
> Alexandre Courbot (6):
>       rust: add warn_on_err macro
>       gpu: nova-core: use warn_on_err macro
>       gpu: nova-core: remove unneeded get_gsp_info proxy function
>       gpu: nova-core: do not import firmware commands into GSP command module
>       gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
>       gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
> 
>  drivers/gpu/nova-core/firmware/booter.rs          |   1 -
>  drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
>  drivers/gpu/nova-core/gpu.rs                      |  21 +++--
>  drivers/gpu/nova-core/gsp/boot.rs                 | 100 +++++++++++++++++++++-
>  drivers/gpu/nova-core/gsp/commands.rs             |  69 +++++++++++----
>  drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
>  drivers/gpu/nova-core/gsp/fw/commands.rs          |  44 ++++++++++
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +++
>  drivers/gpu/nova-core/regs.rs                     |   5 ++
>  rust/kernel/bug.rs                                |  10 +++
>  10 files changed, 241 insertions(+), 25 deletions(-)
> ---
> base-commit: b4e07588e743c989499ca24d49e752c074924a9a
> change-id: 20251216-nova-unload-4029b3b76950
> 
> Best regards,
> --  
> Alexandre Courbot <acourbot@nvidia.com>
> 


