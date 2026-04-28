Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9946FF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3436510E29C;
	Tue, 28 Apr 2026 05:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SwlqrSDP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126E110E29C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUY5V8If44dypbmOSQjtMlul8+ukMQi2Nv6ngYisUDDJKFfDUfyVa/Mxn4llh0XI5nnqBQT8/xqjXGgCK0T/gYHylVkt0tz79NhgnL4sN8xRdI9oDKYRYTyijYevQnPYIQS77fQauCSMsN++VnSkrvplZnq3wZLYQn4TSR3SYt12mDTDSOXjhMF7puUBNim5tGpcm+fPuGli1Cv9zqijM1DqM72a/xM7BHJUV2E/13UFi3YH1j3JIdIm32XeaRgjRLEfpzTJWnWr1zlW9EJUXxK2jWb2YZtNsHSoxwv8MJjLurCbzYp7cFljBHHkxYCVV7WM3hekrAk/4Xng8aZRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTGNw6KbC4yxVbeAlfqODstSlrr/VcIIvEWhB8KwXAU=;
 b=iDzFcbOuYdmRcjBeumhd1XhDE6a2uxQtGTWH+k/RtWlX1wh/HZBi51kqHpx7Ak5SPC7sYDcaSOSMTjmlK5uez8Z198aBP7Df6lH7zPThKrwn+eQh0DuYMjzdCIvq5JCgffng1wLGHUtHhBgNwt3tZf44E2cKQWxm9vajXItQB/OtN+o1KrqnkwoCwaY77BrQDm59fNFqOHKpu+JZpryiBR8I11MwKD4FCWoK4LVPeBDbIf3M0ntPzL6AJn4HZT0O9KK/BSVaE1b1RuY/wZapGyjBXtv+Pnw2KvSUiyQ4rImLMMxcIJ1adFVUo3SLZohAUVquParFHoWloB/o5MZDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTGNw6KbC4yxVbeAlfqODstSlrr/VcIIvEWhB8KwXAU=;
 b=SwlqrSDPjsIFge59NVP3If6KmVc6EKEBbQFJUD5Td1841+Hs7ee+96IYRowzkF1OnBlgQ19UBkkYElPV71fJeporiO28tqw80kMW4sZODuitnYgBGm+TWe4EL07ru0trOlTMBeVEdg3NamdhGvPN8pcNnT1x9cz/pjOMGrNq+UKeppc343LW8O3UwWYXyuyvffL8lfBRINwaWYGEB+KBEgxx9X5FYnqXwrT5231oS8geawE791WwEjL01rFhLuwZDWNA+a6IMC+SCy6aKQ6Jbfa0gxBO4aNrZm6zC0ES4spgqh6xcomkrPqbVSfkN6xKtQJ69FE+fvZEMi5v4MNxSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:06:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 05:06:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 14:06:12 +0900
Message-Id: <DI4IZ3IM5NXO.2DL2P7WE5EUV9@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 3/8] gpu: nova-core: split BAR acquisition in unbind()
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
 <20260427-nova-unload-v4-3-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-3-e145ccddae66@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: be0a9cca-d572-4e2b-2178-08dea4e3e02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tmp9KwfghGPhyoXLb5iWce7iB38MbDhMhTs/n1/2QzvWzOCCA5gZ3mSwsmm5vCF93860YKOrXYZ/UgRdBBzayVleh9Td+MVTbekRG1Usp98w5P3vMORodyL4vLU+2u1Xz0HQDuN1tx62+uxFdh/QWBt/S7mpFVyK78tq/c7ZMs6rfEOar5ATwxBgXzdtQS/sygW1mzf3Uz70P+DYa8gpcD79ZSGqrZhNO/8x9bt6ybCg8k5Xg7jbRg6AQ3253eK3lEaVySySDFLulfxCeurhz1vM9uZqR4EdSOh8oW+JgJQ61agrLAJZtbdWGt02pNFgNu+Php6wAadMpRfX9d0cH50BG9AqJp4CdHSrReEhPKCvFEiU/vIh4DIBuFlzn4YCdCb/EpCFBcwuusNXV5u4fuI/CKpXNYwJplSkF22RaIYTJVPyg4/C3x/QLUyzrJzrkZs+BaAsZd/A4tJfmCxb4xWeHtsPNYXrnFGUvfwAyxbbrHTO0PPpQhH5detXI/Yy9PL64Cj2Cqj4qh0vahCMp64rbOojlEKnGnJgEcaLkLult8KSPGryMzxVCau4zx4fkTR6OtjeMREeigfqn+s28Wi2k3Uk6gJqDXWFKQVNLIbgrNlYSSULxzs7G5nIYbfV05XPiFPH/E5dcrAa7146aC1yFHjhVogU0fp+pV5tteKw3G5D0K8pBU6pQF3GU/a4oWzYkSyArmvqtbg67bp6bbW530aUxn43IIAaCqP+jCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVxUk5TdENSUzRMczZXd3VCbWFFTWtucE9DV1BCSWpFVDVuVkVDZVVQTVpm?=
 =?utf-8?B?L1V3M2Q4cFdoZWlndk9LdFVzZG9sTkNXdlJSZXJSRmVORDQ1cW02eTEyQ1pY?=
 =?utf-8?B?UjcvN3BuQ1hBQ2lSaXh5Ry9jMzZLeVgxWVZlMnFDMlBrV1dPSTdaVlRieWsv?=
 =?utf-8?B?anZONExVaFVXcXlpOUtBRnFSTFI2Y0FyaGZkYVB3WW9pdUEzU2pXV2dWNWRU?=
 =?utf-8?B?RHJJaHpPZ1lTZlZUTHUvKzBrc256NUpXK0Z1aGVBZzVMc3VlZ0pOOHhXYk5w?=
 =?utf-8?B?bUlxd2NVOFhKRXVrcWZaS2ZRbGpFTHNJcHVCdEsxd2x6VldKQ0dhV291TENy?=
 =?utf-8?B?a3Ryc2hJZnRua2RKVEJCQ25XelNQME0zdk5YMVVVUEhLMk5LMERqbENYUW14?=
 =?utf-8?B?OVNjVDg0cnlGSlJvaG5UMkpvWko1bytwRmpqUzIyZk1sd3hjZmhDalg1N1F4?=
 =?utf-8?B?Q2FXVm9YZmthTHhSU1Rkek8wNzVHWVYzUXlPa0x6ZXFCTHpmWmxYYkFlNDg2?=
 =?utf-8?B?TlpBMUY4QXBSL0h5VnpkS25QMGlvMU1tZk04T1Z0Q2xQcnJZYkhIMHJtSEFM?=
 =?utf-8?B?MEJxYzB4L081aVR3dXBBU0dtanQxVWR0R1JtcnNzbHhSZGF1VlVFNjhSQWVH?=
 =?utf-8?B?Q0R5S25Wb1ZBL3I1aU44TjZYeGhIeFBISTRVdUQweEZxN29yMngxSXIvYnhv?=
 =?utf-8?B?bG1xUFFlandQNFl4OVRaY2g3YkYxbzZCbGF6TUdPWk45NGNMQUNQTVdDaVdX?=
 =?utf-8?B?aDF6ZWFoa3BNSFMyMnJlOStKMWYzdmVOL3ZrVmRKbDV0d0V4UzROeXRlUnZy?=
 =?utf-8?B?MzNmR0plaThReDc2RFpVaHF3SWNqOVhFWXNsbk5zNXR1ZmRic3RpMlNVajFk?=
 =?utf-8?B?N3lBbm9HUDI1K3dlUHBKazc4OVdiQU9nNG5oVExqOC9ZZWsyamFRTTN3YU5v?=
 =?utf-8?B?OVFaTkYzRUYwYzEwdndFYThrQlpnb2NtakV6Ynh3MmYwdDBVbnUwbDJ0SENx?=
 =?utf-8?B?Y2UxdTdhOFU4ZENJZnFUNTJxV1F6d3NEQmwwK2NseEFNQTU3RzU5VW5YdmpS?=
 =?utf-8?B?amNEZUF2ZHd1amIxZUswc3Q3VTMvZFFTTGk3aVlpM3poc1dnT2JtWVZaMVkw?=
 =?utf-8?B?SjEwZTJ4ZlRaKzdVYkVhdHJDWEVZS3N5cHIrc3E4WHdGQWtEL2ZjMEp5ODZq?=
 =?utf-8?B?cXQzUmd4T1VNR3hNMzlVNWF1bmIwVjJSYkgxMk55TVVhQlBpVUxid0V3MC93?=
 =?utf-8?B?MUFGaUorR2VmTy9zeEdYSmVaRkNmbmswazBUK1NSQkVoM2lubThkVnRhYUxm?=
 =?utf-8?B?NUFVcTMva3N5QXdGOGtaaWFYVE1nWWFITVppSVBqeWJMMlFlZzdzczFpdG4w?=
 =?utf-8?B?M2pwTVVTZHQ2U3UxMUdWRzMxM3pwQjNsTHdUSDE0WEswbEhwOWFxcTRCNmFG?=
 =?utf-8?B?VGo1aldWTkhEL3c2TEZVOVJhcmM3VHVMYVJCSVFYTkZQZ0p1Ui9xaGp4ekdl?=
 =?utf-8?B?OWY0R0ZtTzI1L1MybDZiWG1TKzVtcTcxTkp4bnUrTjlOaFlyd09LKzJTdzI0?=
 =?utf-8?B?c3NDRDZhcm1XWTJFRktPTjN0dWJrSzgxZTBLRitwL2lMOTNHNFFTTkk5VndI?=
 =?utf-8?B?Tll6R29lb05mN3BQM1JGRFh0U1BJTW4vUHROeXRWZExJb2dRbkRyOWw5MFlz?=
 =?utf-8?B?MTRxUjBzN0FOL0JLaW9CeWRSWnA0RXhydTJnRU1vR2hPR0lFS2F0UmdyK2FW?=
 =?utf-8?B?TnlXaEdEd0xleW5uOE84NkFjM29sVSt0OTdzc0ZmU0k3TFRtSXF0dnlEZDNO?=
 =?utf-8?B?M3pPYzNIRUZTV2MvOS8rb29vMHduS3lPck9JWHpEdldyVjRMTkZyRXpWV1Zu?=
 =?utf-8?B?cFVhK3BUMHVmczRDNnZzb0J4ajhvNjBGc1h6QXRHZUgybWtqTGNYZjJCSXBB?=
 =?utf-8?B?MWNUZGNGcjlRclhzaGVnWVBwT21TbGNkNXlrbmhLbUlFK1pvUHMwcExDM1hw?=
 =?utf-8?B?UXY5L01rOTN2NWUra0tRMlNyQUhzQzNRRFRKd2huRUl0VWxLUldGcnNsK3Nj?=
 =?utf-8?B?ZHM2ZG1TMFB0Z3g0RVJDZkRERE01MUZodzJxZTdXWjJ2aWk2QVl2SU1MTXhK?=
 =?utf-8?B?MXlWTFB3K3FhMmpqMFIrdXlGUWpFdVVVU1FRT01ZZVc3cDF5UWNyck54cHpS?=
 =?utf-8?B?eEVhY1RNU0Y1YzZlU3pOeThpNVZhZk8zdWplaXorb3E0V1k1UzFLTUpUTWcw?=
 =?utf-8?B?RGhtTGZHdWpYSkxGeUx3S29Tb1p3aW1QdGVEajlEZm0vaFA2WWZEZi9NbTQ3?=
 =?utf-8?B?QWpLN1VobncyamtzWnMrTWFuT0VBMTFqTkFXQ2ZuSU1WQkdHdy9DYVhCZGdH?=
 =?utf-8?Q?iH4gMDZ4YeFc24M1EP2D5rA8vlhkTRMdlOyR84GsWm+aX?=
X-MS-Exchange-AntiSpam-MessageData-1: 3dhAVJg6qGYVFA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a9cca-d572-4e2b-2178-08dea4e3e02c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:06:16.0290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVGh3z1eGnShsEAJ6AcEyqOo7IbpDAUHRJnYFIqQfKgyxbhsDld/ts4nbqYGKL3JkdOiB1QMqzMTN/7tmJB/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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

On Mon Apr 27, 2026 at 3:57 PM JST, Alexandre Courbot wrote:
> We are going to use the BAR to perform other teardown tasks, so move its
> acquisition into a dedicated code block with a more meaningful error
> message.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 233a4bcec9fc..920783362251 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -319,10 +319,11 @@ pub(crate) fn new<'a>(
>      ///
>      /// Note: This method must only be called from `Driver::unbind`.
>      pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
> -        kernel::warn_on!(self
> -            .bar
> -            .access(dev)
> -            .inspect(|bar| self.sysmem_flush.unregister(bar))
> -            .is_err());
> +        let Ok(bar) =3D self.bar.access(dev) else {
> +            dev_err!(dev, "failed to acquire bar for driver unbinding\n"=
);
> +            return;
> +        };
> +
> +        self.sysmem_flush.unregister(bar);
>      }
>  }

I expect you saw but with the higher-rank lifetime changes from Danilo +
Gary we probably won't need this soon.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

