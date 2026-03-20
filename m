Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6600F1099B28
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA74210EA70;
	Fri, 20 Mar 2026 17:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEURZlOB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E07910EA70
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGTIgAxtvZKB+bZqKQ3dxRkm/JUFn9mxSQuwoJH+BhFn18NXUXg6O/5QTtD9egO4zZJbefe7nbji38ERvwsCdQ3PDs541xRcUSg4QAkjPsJJ/f1Kv1hYDq203SKphcIPLscF13gT60WkrMaRqDs1iPCQ1rLZYCMBbzo58GK4j+OrDD6CDqtIT7Y2OVu5kzpeNIE72DYU43JnNXhoAKr6rPkXc2Mk9HNM2JeIK5F/9wCHgyz28uqU5aiQkwC3/w1ePrU7aHB+NEtzY95XzpKH6hp3elSFXqoj3nRdy22KAIuD3q1KY7DTlGX2ILP5iqdLDYsIG4z1emaIRr0gKGQ+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2EuNQJwE9QEAfSS+s30m6BxPiID3JHF9NC3YEGA4UM=;
 b=obqcCcHRljifzDGGXAxY6sB408JmQa+XmjJNeRfNnh3HIkEzdZDol1NV5+hFTUkn0YLKJcZ4k3Z547LUlVW/2PzBTq/mK+GYD72yrd4f9ktrvoPm1/BKTfI/jys7plGD8Ju6zbJBlct3DxXR1PSQjQQexle8gtlTPLWNCxTwq27jatQ70OOtLruEfvRsh/KerekJD9xvi9aPP8M8NX/WfAUJKuDXfL93Bt/mZ0wiE2nzTBgIUsiVuAqRuuLea7vCIgvuV/KPMKA7DLFUBhTmHAtTGWnpCNw5yhuw05U7kVuvPwnxTIecFilps7fvxtwfnt7d6a6x8kmUqrw8xjGlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2EuNQJwE9QEAfSS+s30m6BxPiID3JHF9NC3YEGA4UM=;
 b=hEURZlOBdYo37lfYIphaCQCPbAihkAsVJbW4X51s/lha5AwtOCuwkMkS5yly78AKhB/0yZlejChprzBgWGJpmZjdhbx2tR6F8XpFVDV5FwTOUYbahqzIpOy7Axe6+FIsBpKdp4h4txQPQwi/ZLgJl7lBDN1xP6yJPULsD0WwdaFO8mBm0YG7HGp/n4vdXVnHC7AtMlJOPPqgPDy4qkn1OPhk0aM48Q64qFUFhvGRqpeAme0sAwQAnfoW05CX9KDcnUZurZ/X4l2P5At8kwVm38ccbxGmyqZWOkq8LYWGOtUGUV9/sI1WSwRJzRtrSTuzRXMvVHOmIXF75haQLuuRlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 17:38:28 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:38:27 +0000
Message-ID: <8f9da1e2-fb86-4653-b702-333fc920af58@nvidia.com>
Date: Fri, 20 Mar 2026 13:38:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 088b6f62-364c-49b6-6219-08de86a77eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ek/wpmKGui8rynEDY3pEekLfPNqQNTRfPedijBk2lsOvqF1WNAua9k42T//V02uz3J3NMhlKIP+jiYfXFsX9DSPmdXJcf+fX9xDWl5I4u8LLVlONQ8r23/Es7CwndFguGV4pzORlTRFag0iwqWXw4YWBNkehxB1R9l7ZZkHbp7JauPCTp56pCPAxzf8dI/gxG14s+AkXfrtX4PuYJQ/tD+L7TfxaJsR4cbLLsA35qCfVKWR9t59wsxDnynXbFqZCxL3KITh/oQRjD9e0DsGBBBD2kJhLApN9JYjQAw7M/VaM4bSbr/CXflTb6Dnma8iyrfSn/O65rYtiCqxp/kPKEXerzKeQ9iIkhpK7VkpS4UHcnjlLYDuJTNjfM51fyFdcDpEJzjpr02hwEWJlvO0kNDk6xurrJMQhhXjrnccm1MtSZVRENd/8zvfIZ0g6scHqxEpaRE9K5NlVPbTkC5/fFpm8N8v8qlnXQTB/YITuCFi60uKx/u5Fc/M0ODJmfiBN+TjDwvWJZjTsHHcwWvgzTXwHxA7CI8Ny0plTkUo8WnisZSN3IMixjkkU1Mld9ud0MfiuoF9IIx2BuDZb+4dajEWAkHRyFBNk4pxQZK87J9CdBQ4KOw8AEVKS+dTBNuoVyz0lrcqTwnGFE4KxORIRBOBnFj+f1jhyCAy0uD1m2rgTkzM0oY2hdd7RB2BuzPDbJ3rrIAljyK+pM1Hxndsbj1OnqKxQdaVbJ/DO/CvN9UHvFK52d1VUOOpu4+CbOL2OhpH/HiIkvlAiq0Q0deg53w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9XUUcxUmpkZmV2NDNNc1lLMDQyTzVWK2l4SDRtSDBjZURRMlhtUlBrMXVM?=
 =?utf-8?B?SEd5MzdYOUZHNHBDNWZScHFKSGVST2RnRlE1TUxZQW9iYkoxa1lFNlZNR0Ev?=
 =?utf-8?B?ejVLdEhYaTVES3N6YTFvWlBTOUsvU01Ud3FwcnhJVkJ4eFZIdUJRRWVaalpF?=
 =?utf-8?B?ZkVmRHArcXRFaWFVK3NkWjBTR2ZvMEN5R2FiK2R6SUJzNXJQdmo3Z05OMXlj?=
 =?utf-8?B?NjB5TEI1SmwrcHRhVDJJRTd1TE10MmRUbGpJdGdwZjA4ODFvdmxVcmQ4ZEl3?=
 =?utf-8?B?SGpMWTk4UGhoK1VaOW1EczNqMDdjRFFwdWVDdmh5cGlxQWZCdExhRldDRldN?=
 =?utf-8?B?V1dobW4vcWNlb3V3Rzc3WUt2MEFPQUFOSDQ0T3AzbklGMDcwaWZ5QTFtUzRP?=
 =?utf-8?B?M0pNbkx4YzlETjJIUFVRN3FOOTVaYll4VEdRdlJ4bUZXTXI0Wm55Z0drWTFx?=
 =?utf-8?B?OU50Rk1lSkFhZXFCQi9OZmx0c2JIMnd3Sy9uOFJpYlZsMVFUakZpOHdiSm5r?=
 =?utf-8?B?alVjTnFNeWdRQXl0dEkyd1cxY1ZtclBFTVpsTW5mMU1SZzdVWWo0QkllV2pt?=
 =?utf-8?B?ZzVWUTI2U0U3ejRKVW5teEdiMENlNVE1MTIyVitMcUJHOCtUS3cxaVdpc2pX?=
 =?utf-8?B?K3ZBZytOWGpJY3N3VnJFRlYzNmVLd2NlOVgwRnU5UUVhRDNsaVYyWlRFVHFU?=
 =?utf-8?B?NGdYWkJzZTlWY1pvRjJzK1o4VWpTQTlxTHU0MFJVR1hVQUFxaE5aSHF2ank1?=
 =?utf-8?B?MzlCaS9XdkN1cUtqSXR6cjlTamEycU1xdmYxTDlwNXZMdmZrWU4rcVFheGFo?=
 =?utf-8?B?eFdsTHA2bmNrMkpXVkVyRjhNSDRjdGtQZXJQMDdCM2RWd2RldUtqOGdlNjRR?=
 =?utf-8?B?b2l3U2lyaHVKakZpMi9SK2NFcHlwWVdGNGJjQlNZWkdvUzhOcnhsaCtmb3dH?=
 =?utf-8?B?OUV1Qzhua0p1SGluUzArNXZCWndqdGZ5ZUFQenBiS0Z1Q1FqbE1aRW5pWlFU?=
 =?utf-8?B?eFdYekdmVERxdjh4S0pCOWo5eituc2wvTVZjQVhBK1FSdGVBc2haUkpqdnlI?=
 =?utf-8?B?WCt0eHlpbmQ5bmttckN0V2ZiMys2WGdNQ29KS2VnYTZwS3B5TGdoK2hWdDRR?=
 =?utf-8?B?WlpWR3pOTGxiUEJsOFQ3Z05WcU1WMWRjYkR3SlU4QXpQQWM5QUF5cGFZaEZK?=
 =?utf-8?B?MitRRGgwWUl5cTE1YkpwSEZEQlNzVUJVaW9rZkNCZmJ2TWIyUC9xTERtSWFn?=
 =?utf-8?B?N3YrM1pua2d0K2cvZktYVmRQRzZpVWp2ZEM4ei9sUW82QmllRjl2eHBnQnZr?=
 =?utf-8?B?L2ZlNXdHMjkwc2ZtT2NoWWhWeFFISTU5Tks1WXJ0YjF0bkg5b1lISFVyU3p4?=
 =?utf-8?B?WHRtb2hIWHZmM1NjamVRa0NNRWFsY0lSaFVFeXRRUUN1SnRjU3BnaXcyUEc5?=
 =?utf-8?B?TG5Pc1JLUDhRYitXVjZUQmNQMlZpNGF4dHlGU0h3ck9JYndUbHhpTkxBS1Rt?=
 =?utf-8?B?eExFYXBLN1NhbDk5VExkZjFuYWdjRGxiMmhKaEJVTENYU2VmNXNlV01QVXJv?=
 =?utf-8?B?ek91YlR6clJKQ0xYSnlDckgzdG8zdDc2NURyS295cVNLZk1OSVUwR3RpM0tn?=
 =?utf-8?B?SDY2ZjA3Ujg3WW1HZHdodndnYzhLc2R6OGpGU3RReFd6SW5hczJjWDBCY2ZR?=
 =?utf-8?B?R0o2cEtYdHFMVFhEMExzenJDREVrbHA1czZ4L291ZUZTbFhVWGdhdTVkbEJX?=
 =?utf-8?B?Z0tqQ0dxNUkzZUlVZzl2MHhucHZJMnJQZkxVTmFIUFY3bGJCTUUrS3Q1MXMw?=
 =?utf-8?B?eDFpWS9JdjVyM2l0NFZWVFY3YTFsbVpEbnpkRE9aTHBobmFQNTZGUWV3eFJC?=
 =?utf-8?B?R1ZnRFVibWJmSGRWSG1YbzJQVVUxblVaU3NEQzhZSjdKcGI4cEdVVXIrS2xC?=
 =?utf-8?B?U3JWVE93QXIzQXkzSi9jUXdidTNKbkxoSng2eDBOWlR3Uld1MlVic1MxVDJZ?=
 =?utf-8?B?Tzc1ZWVWdm5OekEySGQwQ0s4USttc2oyT2cvNHhHcGc5aXVXVzRhaVRqTnBX?=
 =?utf-8?B?VllFM20rbHlrWjRRdlVVV3hYSXRNZXdJNUZuVHJseWlyTi9meExlczFnbk1E?=
 =?utf-8?B?LytnN2pzQlVkVGtoL3hDaHdhR2dpMUVveFZKSk8wYVR0MGpUNnhoSFpyNGpD?=
 =?utf-8?B?Zm9ydFdoZmZRUk9PS2tnS1ZSdmdkZ3ZXU0hCeWdEL1RiREw5eHN5RFM1TElJ?=
 =?utf-8?B?RGNBRTJmL3EzUTBRL29Ha2paSXZtUlBJbEhTNERyYVB6ekxUYzBoVVBsZElV?=
 =?utf-8?B?TW9veUlUSDg4dXhBTFZ3dS8xWjlyc2l2U0NTbTJXNTJhQTBRRGNIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088b6f62-364c-49b6-6219-08de86a77eab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 17:38:27.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V84cKV2axvsybhaut8lmbNshpXdQPxKDEKt5wWLeEQKg3wwn/4e4n7/Jdbc5ZA0clSKQUb4Vzs+s03IPcmq/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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

Hi Alex,

On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
>      /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
> @@ -616,9 +462,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>          self.hal.select_core(self, bar)?;
>          self.hal.reset_wait_mem_scrubbing(bar)?;
>  
> -        regs::NV_PFALCON_FALCON_RM::default()
> -            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
> -            .write(bar, &E::ID);
> +        bar.write(
> +            WithBase::of::<E>(),
> +            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOOT_0).into_raw()),
> +        );
>  

Overall, I think the series is good improvement but I still feel this part is a
step back in readability, and we should come up with something better. I don't
think there's any chance anyone can memorize this syntax.

What about using a macro to hide the boilerplate?

>          Ok(())
>      }
> @@ -636,25 +483,27 @@ fn pio_wr_imem_slice(&self, bar: &Bar0, load_offsets: FalconPioImemLoadTarget<'_
>              return Err(EINVAL);
>          }
>  
> -        regs::NV_PFALCON_FALCON_IMEMC::default()
> -            .set_secure(load_offsets.secure)
> -            .set_aincw(true)
> -            .set_offs(load_offsets.dst_start)
> -            .write(bar, &E::ID, Self::PIO_PORT);
> +        bar.write(
> +            WithBase::of::<E>().at(Self::PIO_PORT),
> +            regs::NV_PFALCON_FALCON_IMEMC::zeroed()
> +                .with_secure(load_offsets.secure)
> +                .with_aincw(true)
> +                .with_offs(load_offsets.dst_start),
> +        );
And bare minimum, probably the inner:
> +            regs::NV_PFALCON_FALCON_IMEMC::zeroed()
> +                .with_secure(load_offsets.secure)
> +                .with_aincw(true)
> +                .with_offs(load_offsets.dst_start),

Should be assigned to a separate variable for readability. I think otherwise it
is quite unbeatable.

thanks,

-- 
Joel Fernandes

