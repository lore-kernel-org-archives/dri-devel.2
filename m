Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB9606A334
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FfivSWBl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BE110FFDD;
	Thu, 12 Nov 2026 10:29:57 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238DB10FFE6
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiqqO+hkgvWjYR0lq02Hx9f5fYeAk2hzlnnHK5TiUumHnfNb7n+81BdDlkBOa5JTNAXX9b/1guHf+LT2ZeABUiw5w6ZiuHbVsK3F1iyDO8JCe5ckxlHrW2qfUoCYcBp3ugHGSTsUk8m7jbY1x1VxbMyBfsbs9EvNRcoDKE6Pl4JXszg6+Ddc0/xdrUeer9heQPFNO38w9p4xWGnX/hw5KN+LpJ3MQj091huhYCoVIz0RT1dJEjF7OB0h7zL4UlGsLwbja7WUfOqvMhEfFRf9iJJt7VPDKvau12eO4gI7ifs+slr9/e6hCWMohFbevVJcboXmTo3KfGrvcDDfAtygXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOggHnlBBFMcfLYIXa7l3JIQ20sMX9BLlc5Eb2aKLGU=;
 b=uSDx4QeNkYC9UfZJXOPXU82lJu1kScAKqxRCBoHQWW8TB58qVDJvSkEPZLh7Vht2QSM2QwSFTIRIRVpYaH1T1kzwldmBT1JHXF/FwQBHT0xDTSMI8mD4iYv37C5Em6zVA2b0he+y4mCvovj8rVD3DpTInZiu/Wk6rOaszsx+mNMfgoZ62AJQi7btd7+sEels83T9aYxOlSpadMHJA3mVx1iwB9NFshv/okzVIUJqTBC7XF9pbD+t3fJuD4ZfCfQMoDQ2INuHY/dmnU2Vj4yKSAyhTFTpFmIGxvf1+EyxDhnLnenvrD5iSa8NI7oYClxzOQ040MQAQSp/3FdOPf1xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOggHnlBBFMcfLYIXa7l3JIQ20sMX9BLlc5Eb2aKLGU=;
 b=FfivSWBlaYflzSNE2JupJjouxgC5moR3c2hGOszz41PrrS5/YqqaVwfCgLspENiV2TbPXgk2w6G4J6Did46X8oPLN+7xvRmgXJ2wzTCgYSPjpj1rFnWmyrWTdd4ONIEvJfHhVfFfWyqwdiD5/MCKCi9DYPI9xQVWS3xxX0/FG+8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 10:29:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:29:47 +0000
Message-ID: <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
Date: Thu, 12 Nov 2026 11:29:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112101015.528127-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a547cc-dbc4-4cdf-a95b-08df40a7dffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|261021121427099003|261009223027099003|261026121527099003|261021123027099003|261021135927099003|261102123227099003|261026140227099003|261022105027099003|56012099006|261028144727099003|11063799006|6133799003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: qtHUZH8xplgnN4UVWj1imS3ApIcItZidc5jv1LZmOC5nTizQS8Ttr+STIl+W/+68MX1XjBSGOekD/gccLo/IlX9IlNoxIAf+LQW7wcfTUM80zjR0JOiAKktL6x5tr5Bemb4w3gvWzJC/wipcTdp5fzlP9u3XEhwssSF06Y+ApY3mav2LlXW+wxcjpgV2g93BJOnjE7VGHMTFsvAZNEJnNfQ+UO79+mBAxaak8SKMa/CuXxiAL0dzKtsPIfHymvLmcDbdFyjEi+8vhk0ACKRt7SUjrTRS1HOk5SnoXDOGvwimRpIvva5RWzXzrhsl5VoBcPLXWWM2gnm3O3rMknvWycxW4ExdQaiMSwvTBBlnC3sSnMXtPJ0SBVMGd1yHugsXpHvpzvJolrp/cfZUijeLHlzjm/7qkam0u+IQV1aruvqPfu0jVbnaCzF7VVW8E7USfRc7XnBcC4gVUCFivral9IOfvgqFPcXmHf4ATS+3rLWsLUlNIkgnHqzc2gSnHe6mC6p/FmwvKhuADz4Kw2vM13QBxbe0i/nC0l22cX+eHFoA91TqxapSKQ3L2mERLArFLbQr8nsTf5p8jONs7+6BkqQb4Wl9rwla5C2XeMEXavJ6GVazC0gZbFz2WmYLX2ZDxkDHf1Ji95jS1AtQfvX4xUVet2oVpLHw/a5NUbprjZddO2gHbIMnxw2ObmizaY7QZysf5wOvwc8LyGecI5L2lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(261021121427099003)(261009223027099003)(261026121527099003)(261021123027099003)(261021135927099003)(261102123227099003)(261026140227099003)(261022105027099003)(56012099006)(261028144727099003)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZHQkQyK3VXMDNRc1B1UWJSR0l4WDY2MUUwUCs4R3c5ZU1VZHFXU1F0Ukpk?=
 =?utf-8?B?eG93WklMR0dKZkVZUDRocEREd20rc3JycjJyQ3BQVXFhUmlud2I2YzVlQ1Mx?=
 =?utf-8?B?MUhQZmlXTXlIdlZ2bWkzVC9DQWpubmR2MGdPSXdsSFFXdDdyMGVLQVpFYjQ3?=
 =?utf-8?B?UzJTajNBWHpDUnlDbHNwcExMNjNFaC91ZmE5S0N6cjFKWFp2aE9RZXJDamFv?=
 =?utf-8?B?WGtoN3ZVbzQwY1RqL1RaVVdYY2FEVUJCU21STEd3U2tDQ0paanppT0NEYTFm?=
 =?utf-8?B?NktYUjBkakRHNE5KaXVtMXViWTdCREFzQXpIM2s5cTdMNVFMekd1Q1hPL1Fu?=
 =?utf-8?B?K0NmZmhnbVdha014YnRFdEV5L3VjeHFJVGpDVGFhYnExeitIWFgxUGErUWta?=
 =?utf-8?B?b01WV1pGZ1B5WXRjdWJKa0N4enZNcE9jdEdVd2NBYi8wb3lSWDFKQysyL3VF?=
 =?utf-8?B?YXhwdVN5RDVsSGNNU3E1MFc1djJuL3ZyaHJlazFSMWM4cTVSdi9VMndGbU9G?=
 =?utf-8?B?NXNxaFFLc000Mko3dVNxRjRtWDFkVFUvcHE5RW55SStYQUQ1cXhaVkErWjdt?=
 =?utf-8?B?TDl6SlpWVlRCeWhQWEx5WmtLUDhXNk40d21WUUN4Y3hGcmh1REdIWUo2b09t?=
 =?utf-8?B?UFAxSUdsRHRhSzBUR0Y0U0VUeVZLT3I3TkpTUzQ4dFo1MnRNdm5Jd01NQ1o3?=
 =?utf-8?B?c0lLdXZQNXFwcHVOdXVUbTFLY2NMQkdJS3BGNkRaUEhNeFVwNjE4Q29nWnNz?=
 =?utf-8?B?UURwcmhJZkZZT3pYdlp5RDc5RTRWRW95aGJONXozdVh3SHBXdmNWZzhhRENO?=
 =?utf-8?B?alE1YnluMXAyOVpTTTA3U1pMN3dOclE5T1NvSlg1ZmE2VVd4ZGgvYnlkODFX?=
 =?utf-8?B?cmhCK2dHMXc3SEtZMVVTUDBEemJqaVdVVVRCa1JPcFlsc0FUZ1JTaVl5V29F?=
 =?utf-8?B?QjFubXJuV0dpOHdiZWZEa2pTb3FqaUhmWi9oaGtxdFo2Q3ozaFNDNE5ZRmtP?=
 =?utf-8?B?K25idlptRFU0Vit4bldlTUY3TzlRRUVIR3JETmJOcFZvMEFUMGlFdlpIa0NX?=
 =?utf-8?B?c1NyTlFJaVZHcDRkakNlV0NjWjEwaG1CUkNma09ENTNYQ2xSTmVJMnFyUUdn?=
 =?utf-8?B?cC9uU1J3dXducjFoSTlqY0NyNkMrcVVac0NGRmQ3Z1pvNlpaWnBWNU5vYTNj?=
 =?utf-8?B?Y1pSM1dtcjdyTlRvTE5tMGdsNUxCd1FFd1FwaENYN0ROeEczN3NOWFlhamYv?=
 =?utf-8?B?bUlBMzZCWkhxekwrOHVpc1lpaVhGWDVEaGNUM2krd2JMRlpZTzVXMGpEZldh?=
 =?utf-8?B?YkMvNExmNjNFUXJkQUVDRTluc21ZRGJxVGZoaFVrTnNaVEQ5b09DSk5LbXlG?=
 =?utf-8?B?SFZ5YVExQ3lFZ056enVDUmxVVCtVWXZhQjFlNTBhNXB3STM3UjF5T1ljSHhY?=
 =?utf-8?B?dDRzVHE5a3ptd2FubVNHV2dWQzE4dW9KTGVOMjlGaDZ4TitFamh4K25IUUZu?=
 =?utf-8?B?ZkxLclMxaHk4WmprTVVxZWFtSTk2aHBXMGdvTU5MNUtOaVBWcW9YalhwMDcy?=
 =?utf-8?B?OTlLMUMvR2tCdk5sUXp2U2ZtbW5abkNkTHA4Y2pHZlJISS9CRnB4VDUwR0Vs?=
 =?utf-8?B?QjVmcXJHV3dlMmRyNW40L1ZrNGM0ODhOSytWQk9JQ1VBdkl0SEtEYWxaUGNa?=
 =?utf-8?B?VE1VMkpwK3VVWXYzVzFpQjNITnpJUjZ0eGMwYStBVndDNStobDJqSERVOHhP?=
 =?utf-8?B?bXdIOVlvYmdDZWpoU0YvaENGdStVRlBnQ2ZFQzFvQk9uL29LSy95UEk3WExG?=
 =?utf-8?B?UlhvOStaazNxaXZFMXI4Vk54VHhaekhPOTN5VEZvZ0J5eHVKdkF4bDRrNGpp?=
 =?utf-8?B?eDVlNXNSK3l6ZGYyWnFqQzhMdTZaSXQrOWtZMEhYS3l2UUVBTitKd1RFa2Va?=
 =?utf-8?B?UVFIT1ppTEFrN1JRR1lnRVhGVFREcVB3Q0VuNmxpbGdHQU9DWnJ1V2xzbE8v?=
 =?utf-8?B?cHdhMzlMOEIvczBCempKL1pWYi9lV3VLMlFUNzNUL2wyT2QwUE41OFovVUcr?=
 =?utf-8?B?U2dRWVZuUW9xcW9OK0hQbWs1enVUaXMzT1hZR3Y4VisvUEdvaWFPM01kaWZn?=
 =?utf-8?B?WDZaRy9wb051SE9ldzczbjVsQ1lVT3lOSEFzUlNPTjh5WEw0OEVkMHFHeDI2?=
 =?utf-8?B?UjMwVC9NNlpabVVjWDJZL2NTbVdDTnZlUVB0ODBIY056d0lDaDJWT3lMTjgv?=
 =?utf-8?B?Tjdld245dHlKS01CaGdyMnZHU2h1b1RCdkpJd0RIYmZxK1RMcllVVUVTVGdK?=
 =?utf-8?Q?8iF3B6Qfc9U5uN2xaN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a547cc-dbc4-4cdf-a95b-08df40a7dffe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:29:47.3914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1roZnBS+NJiQkpAGnDxW66yzzY91mL1u+wrciofkCwy2pN1kWijBa4UBohA4VDyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 11:10, Philipp Stanner wrote:
> DriverFence::drop() contains a pr_warn!() for when the fence drops
> unsignaled. This warning gets into the way of canonical teardown in
> Rust: when you drop a lock, it unlocks itself, when you drop a KBox, it
> frees itself etc. Congruently, users should be able to tear down fences
> they don't care about anymore with ECANCELED, which is already the
> default error code.

Well a dma_fence should never automatically signal when the last reference drops.

Leaving it unsignaled is the most defensive path we can go. That can lead to deadlocks but it can at least not lead to memory corruption.

Regards,
Christian.

> 
> Remove the warning.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/dma_buf/dma_fence.rs | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
> index a1d851656562..2c8001cb9a59 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -942,7 +942,6 @@ fn drop(&mut self) {
>          // SAFETY: `guard` is valid until the `call_rcu()` below.
>          let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(guard.as_raw()) };
>          if !signaled {
> -            pr_err!("DriverFence drops unsignaled. Danger of memory corruption!\n");
>              // SAFETY: `guard` is valid until the `call_rcu()` below. The fence
>              // must not have been signaled yet, which we check directly above.
>              unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANCELED.to_errno()) };

