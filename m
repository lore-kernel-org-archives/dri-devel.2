Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B0FE9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357EB10E1F9;
	Sun,  5 Apr 2026 20:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="o6NAQXCO";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BE510E1F9
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 20:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyyWf8a9pX9sQ8xO1Uzq7kmr6FkVH1T+j1wYtlCKgQ2pqOsnwHoGN6/yQviJ/Nx7gHqGbAEWhZcifsOCuFaa4Thr9ulHVaTCcBhzlK+FiIppTFgMZkEpQ8XSOo8pjz1TqMe5OgRUCg/UyMU052Ksx2qapmhw9WNUH7XSh4Ts3eIW2WS5gwh1sJE2JoLh8fMeZGrAhnlFFPGnwKcUInWr4B22EB8TY/Og/zWAHRsWdKCXdePxvJLldz5LckoAwXhTM+7qwRAvjLJyHi07ZCoFOQy6rID2Nwd+EeGzNlTCVaEZKUCI3hAN/yi7lZiVVZIZSdZWSuL1SMxY7g8MvF4q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHnkgfulC5bEq35bHJHQbYVA1Ip30kfBdHfPQiHqn+Y=;
 b=w71wYo2tGM4BdPMMBEkptEUbASQ4bG/6jTJGeEjLnCkkgJtpUVHGjopdiVSGRBCGO7/GJG3KwykQx/Jzm5hxEcwUxBS8ZQ9rffftfRby5SimMMcP3AH4M8FDQzqoR5qH0iHcuUFtK71s3IGuiEZuTYMaSSoofs4KGRUpUjIUbG70DHBsxKhCJUdXJM5FeIoY9R+55WUFmQzbfZV8N8manebZvWIuH1h4wJLaJdpQLDZnykuw5WVjRwX+7xFf630dWwsY+czCNZVe28NmKFYTQxQ9J6xf8nMwpwYuIfAkJf/KrJvW2Ze/XxX1DGyz7Y0Lg2iitIpl3YuHFXOgMc9/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHnkgfulC5bEq35bHJHQbYVA1Ip30kfBdHfPQiHqn+Y=;
 b=o6NAQXCOIKscPo0CoA0uszK/bKS0j8vPda+Jy5Srn7NsAKK4Q99s2+60bssRLjL019ByTcFUAl5FNgFrFqbr5qXKZYS8sPuvP77urflNO73A/Ac5023frw8AGcsDiZnAmgKlI9Gt8uJHedLZAyToXJXLzwgIl3ebeBpdxMVQtijBXyDFVgulmd8grMs02eDp0FP/IzphxnHyWil/ltE0Nad4ZiWG7sMSvpl7txLq6YqsVVo77ntFWnV/kdsGe3lEGy4Ms5kmnXCN7QSLgfOlIH5GGfIGL2IVAqHSA8utuKZNSfKs9XY982OMPfNMQ76Rk60GSvCvdWYcZhHHIC2zhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sun, 5 Apr
 2026 20:05:15 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:05:15 +0000
Message-ID: <f53185ed-5385-4335-af33-ceb347228176@nvidia.com>
Date: Sun, 5 Apr 2026 13:05:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] gpu: nova-core: gsp: add NvStatus enum for RM
 control errors
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-2-f3101093484e@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-2-f3101093484e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0508.namprd03.prod.outlook.com
 (2603:10b6:408:130::33) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a99564-8163-4b01-f31b-08de934ea73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: K3UnZEYqKhNfrE1jy43T0oWPLy0C6rdEbOwaNwGLZ2mOpsbQ6eG4oU5e2KcNQjNopDHhQxr5kbJgDPj4cMRMnXIXwI/o8K9skwDScjHj40/z9zvVRDUz+FEsnfJX2oUMtk+MgTBsDeHIEIJkigU+dhIF5te/aosQjtQhn9mJSaE3bWanITSFGg67f9U0NdQBDa67VilAwg4uM9/Onz9SqMaTfSE8jO0z+iI1cFlzT7zSwzXe+d9BbtpEfcxsKUuOa0C3uqqQO1caK7JvxoG6bfWdKEbtYWZ8BdsABv5Pan0N5LcALKh1w6RoA5rFgnlYz8jnzOiihSiZghVe/OtZ8FX+293FaXCBowhWNKvkzgCJZyo8drruaiszvFJH3OczpY4YC+WITIje4txOM/Edq4YKiyGPTcALpQ/ZMljwNjtVGJKuE8Ef71XIqp/BgkiwiJU/+AgjKMuEbNWq5u3UoGQu/GPqlErrIKqZGv8HqOm0ZCgGwjrnL7IXZlGHzrgF6a82QcoBU06pM8cbvj3zeSJYbKd65yNBTaIjroXQDqbLPZVMj07s7YwkgThYHAiOnpi3CTu4/drcoqJ31cUIuccAstEEtUYhQljnj/XtWqWGprPwwaHoDQWqqlQUeb+uEwzeNfachqeDto2tT3KjeC9kMHUSoLhVW6W2Vx5P3gM8QrNku6uJsvMnqS1CMJ6ndzAcS+Q7gZ6D8aK1QknXyXWLrJJ4os/7nySh/ZxlY/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlrbW5UR0cvcWxTa00vRE4zWEtHRzBlYVRxcHZBMzZ5Q3hlSVpzaUpVSTlI?=
 =?utf-8?B?d0N3RmY1QytUSXI5ajA0VVRQSUtxUzJFZTg3NjZqQWJLVzdCYUxsTW1XbFpC?=
 =?utf-8?B?WEd5NDdiTThwQmZSOU9oOWdUbk5Fc283dDZWQ1NsMWUwR1dsaWF5MkNWQ0Jr?=
 =?utf-8?B?Nmg2dzlxRExncTN0djBIN3pMZzgxSXQ4QTNHNmQ1SHFSbTdTYWxYKy9HSE16?=
 =?utf-8?B?NzVpSmFONEFaTkQvaWI3b1NCNG1peithRXl0Q0hYTDFtSVEzNmlMV002WnJ4?=
 =?utf-8?B?ZkpyT0pVcU5tY0NZU1BGSkNNNU94WUhpdVlGVlZudEF6MG5rNWlVOFQ0VG05?=
 =?utf-8?B?aVBOUHZDazhpL21uVWJDWnY0VjBjNHRzSUhiR3pBaGo3V1E1QTVsS2EvanlE?=
 =?utf-8?B?RTdZUnVNaTdsMi96UEtrQ1Fzbk1WdWZlZmtSUGszWjRHQ3FtM3BKYmNmSGtn?=
 =?utf-8?B?S2QvZ0dIMENJZTRRaVpPS01DWmZQNVRsL2xROURhZDBuOXVQNjRELzduTkd1?=
 =?utf-8?B?RjYyNXgyU0tMQndsOUV6ckMzV0phNE1wVWgzT1FJMllZMzY5UENrRE50eVVL?=
 =?utf-8?B?cE04dFkyZ3E3TEQrYWhlOWVoRC9mOWt1OWx0NVh1T3B0QkNhTG1kckthSlFw?=
 =?utf-8?B?YlBPN2NlLzM2bmt1Zy9HVWRYUTNEYTJ0aU91RWUyM1dpL3F6d0Q2UUJyZ1My?=
 =?utf-8?B?MkI4a1BUR0U5dnJtTkIrQXN0ZG1RZHAyNFdxY1pOSlVPM3JpekhrU2h4OUJJ?=
 =?utf-8?B?Q3JWQjBLS0NDSyt3a2FQYXFqbzhOb1RmVU03OXhqcWRJd0NWYXNkQUtuOVk5?=
 =?utf-8?B?ejBhZW1xcmdjRFoyTUJVWVRVM0MwQkRzUXhnSzBGQ2N2ODhsYTBIRmZqdDlK?=
 =?utf-8?B?TmZyam1zRTdSQUJZWmROYmE3RlpUR25RY3JuZ0t6eW0yelllcnlaMFBMUmlO?=
 =?utf-8?B?aTRhWS8wd1BiSTNuZkt2Zm94dTJEWkhDYVh2RS9Qak5iYURLV1dna3Z2TWVT?=
 =?utf-8?B?ekxmSlpLRkwrUnZIZ2lEZHloWnNNMVFSN3dSR1h4WEMzb2FtNCtuSFhZKzlC?=
 =?utf-8?B?RTdENDJhamdyMUxyR3pPVVQyM3ppb3E4NS9Sb0xabmIrWGRFemZkbjRuWGQ4?=
 =?utf-8?B?U0F0bEdhZzQyMC9kUkc5Rm5MTlVMTzZnRHpNQlFPUVVZYXhZeEVwcTZWbDMw?=
 =?utf-8?B?UjlYQktOcnVkVlNxaGxQRWcvRXRPRFZBK3JUdyt5eGdsRHJ6QzJYSC9BMk1F?=
 =?utf-8?B?QUZCTUxkYWpvTm4weDlYWEM0K2ZRSmtMMFBkVWk4WW9jN1gvQTRNc2NReDNQ?=
 =?utf-8?B?a1RJdGZjRUNCTW1vU2JCbllha0lGRkpvclBudjRtVTNyQ0doM1Z2elFjWnhl?=
 =?utf-8?B?SnhxZFladjhwYVdYVEpUd2kyNWttYkoxa2VhQjV6MUxkVzZqcEN4VW90S0V6?=
 =?utf-8?B?a0VLOEE5NmtudEg3Si9lSnZIdm00NnF2YkpWcEJTeFUrOTFqMnpKSW9tUVJj?=
 =?utf-8?B?elEzMmsxR2pmNkxzVWU2QkJaSnJSbERJRjNMK1VlYnpMRit1bHdSdGgvZTR5?=
 =?utf-8?B?UkNmMlczblZhdU1kOWJYaUZuanBWMXRMVmFoRmNiMldkTk4vQjVnb2FqV09D?=
 =?utf-8?B?cG9MTG5wM2RVV21iUlAxS0VKVWkwWjhabkRIZDBtaGU4bUI3Mmw2dmUweHMy?=
 =?utf-8?B?aGJQZFNpSlRDT29IY2tEcG5GZS9QaXlqYXRxRjZKQnU3dG16S0RVcmJBZlFH?=
 =?utf-8?B?RWZPRnFESjVnRTEzOUxsalgwOXdPYTBGQm5EUDJDTWQwdFVSTVY4dGZHSVJE?=
 =?utf-8?B?WHBFRmlvOVpmZnoyblhRdG5QS3FQYWVDWHdnSVNIdndESE9NTFpJVUY0L3Ji?=
 =?utf-8?B?WFo1VXFzYmp1RkhYRXVNYnF1NmgxM2JReWlhOUJaREtqTEpqNG5HcWs2T3VM?=
 =?utf-8?B?eVZPNTBpb053UmljWVJKenBiSGJFZXU5cWM5Nlh1ak4vMUJpV1dsdGErN0d2?=
 =?utf-8?B?SmtJWHA1Yk9aZVZPd2ZOVGVUQURPSXZxdUQrV3dmdlNEcFVhc3BDWjFSZGZT?=
 =?utf-8?B?L2NHMG9NOTJOTi9XOHEzb1pweTgxb0M5bEVyMlk0Y0g2ZVBDelo1L2tyWUdH?=
 =?utf-8?B?YnVVcWdPVFlWQ3NSRFJWZmlXd1FIbTl3QkhUdStuckdUQU5LR3dlSmR1SkEw?=
 =?utf-8?B?QTZoNHM5NThENEwxV01XVmJBSDRMWDNXTUh5dUxBMC9FdzFuUkJ0V0xxZ3VX?=
 =?utf-8?B?T2E1ZG4zamFIZjAwcE44UTNxTzRFb0FidTRHSUQrOUQ5enUwaEVpOTdhTnVJ?=
 =?utf-8?B?SlpYQ2orOEZ4alJhY2xuS0oxNElBaVBVZjVZbUZXUzlWQXRtSC95VEVDbmFi?=
 =?utf-8?Q?023NhrdFhibOKmcU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a99564-8163-4b01-f31b-08de934ea73f
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:05:15.7360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sX4CyoYfjcSMnKIZ0fcTFg9uH1mPFe6XSgawl6Fu/W34Dub/rMC/CBem9MFrnK2Z1c0Ra/FqZKlX73Tju4kbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

On 3/25/26 5:13 AM, Eliot Courtney wrote:
> Add NvStatus enum that wraps the raw NV_STATUS u32 codes returned by RM
> control RPCs.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>   drivers/gpu/nova-core/gsp/fw.rs | 401 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 401 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
> index 0c8a74f0e8ac..cb4bda253193 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -97,6 +97,407 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
>   pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
>       num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
>   
> +/// Status code returned by GSP-RM RPCs.
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +pub(crate) enum NvStatus {
> +    Ok,

As mentioned in my respose to patch 1, these are hand-written and won't
automatically pick up anything new from bindgen(1).

If for some reason we don't go directly to generating Rust bindings from
GSP-RM builds, then we could somewhat mitigate the problem with a
declarative macro that generates the enum, the From<u32> impl, and the
From<NvStatus> for Result impl from a single table.

That would at least prevent internal drift between the three, but it
still would not detect new binding constants.

It would also add yet another macro, sigh.

> +    AlreadySignalled,
> +    BrokenFb,
...
> +    Unknown(u32),
> +}
> +
> +impl From<NvStatus> for Result {
> +    fn from(status: NvStatus) -> Self {

This discards the NvStatus variant. The caller sees only a kernel errno.
We need to retain the rich RM error codes for debugging. For example,
a caller that gets Err(ENODEV) cannot tell whether RM returned
CardNotPresent, InvalidDevice, FabricManagerNotPresent, or
ReductionManagerNotAvailable. Something like:

     fn send(self, ...) -> Result<T::Reply, NvStatus>

would let the caller log or match on the original status, and convert
to errno only when propagating upward.

> +        match status {
> +            NvStatus::Ok => Ok(()),
...
> +
> +            NvStatus::Timeout => Err(ETIMEDOUT),
> +
> +            _ => Err(EIO),

This will cause failures for NV_WARN_* items, which is a problem.
RM warnings should not be converted into errors.

thanks,
-- 
John Hubbard
