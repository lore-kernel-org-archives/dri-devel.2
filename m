Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AC2C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 04:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636BF10E650;
	Sat, 25 Jul 2026 04:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VddE21w+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D95210E101
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 04:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKSZdLZMsP/U9sEDKESZO62D9TuN9LuQGjZ3I1XYYScp79K0GadmqHteeBVL7/LZOOO/KSKGAf6PX5pN9jcZijOBLxTkRfzo0oYO8Hqa9P0NORmm1TIzJFRR506gZRggHz+wthmz1V4PKTCIYoPTTTatqRPrhyiKPe16aJ3IoGoD/Z4ICx5ulB5lwChns7AUKa1Iru7jfuft8Ep//6qi0jC75ZssIDccf+0rMlrVU0m6fWPaon89Jt8x6zqmpoeMGgYmmFAw1wzNcSH68JkIlzRe9y0ymg2ZcXQW/qUt9NdNsgoQ+PgU9OmSLd5oLaiw5iD/XpA8MKLfLwwYeRoGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iULOspyYEG/JZA/XyH5+pcgFR7F1VJFIZHMGxkDij5s=;
 b=DsjG2cqwV/DmEJ3yT0jG0OkriB+x2Q4DrZF9hwytOGgwtrdinoVueuzDsUAimFubCDcF6MZBMtZ2l/HtEoIFGHk/4SNusYYzNtI5aXpbw+qJAegyC7095Lq/jRKi+B9F1HamPsSfm2n4iw1G98uB0PPh5q/ZkvFLbBzyeMgNB04ubRwHIAcT9PQjyFk2EnjeBTFlQEnR3VDvfOuE3s78q7wI6PWmxkU9x0VCuB3UZKLHSnJUtbjWzODeuxuINXCxnWNsG8N4VQByeFLs20T3mEKlT7a4S415hT70WOGZ0cZpWOO44UQrY6YmmJPyDsMPbyAb7U/9GbV/uFcbLz4muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iULOspyYEG/JZA/XyH5+pcgFR7F1VJFIZHMGxkDij5s=;
 b=VddE21w+Nwg7PxahBXBo3IMfxb2udPcLqXEOoUCJ8HsZ/EFx+VVSimvin1aKBz2RNbW9OtUUDTVdimjAqUaW1Al8sNgxLIKoZqcAaGmhR2bxlAY4Rh4F9nMU1eaGl5l/xwrAfWR68rqy0l7k8T8aMWWz/qkYIBWW+jYYUCmQhZIhICrwl9kosUgdsy8nr9kHB8WbQfRDiihwc9SRUnI0IR25Wc9XZONyaI9dEyeiV5BCKmO2q4IuBatd7oI8iE2ErCiIPFLXAEhIUAcZMwGj5oImiNAqmfPWgiWfZpYq4Nz1u1u0zgvTxyj/TAx9YWw43gCGG5tH/yWhyzSaD0gnTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 04:42:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 04:42:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jul 2026 13:42:00 +0900
Message-Id: <DK7DKIDW14CO.1PJO3G4OGD4LN@nvidia.com>
Subject: Re: [PATCH 2/2] gpu: nova-core: falcon: use I/O projection to check
 transfer bounds
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
 <20260724-falcon-dma-projections-v1-2-957028a7c0a7@nvidia.com>
 <e7ba2c90-6d4f-487e-bd25-56d568ba1f26@nvidia.com>
 <DK75LUA4NLGI.3P29AIZQE20V2@kernel.org>
In-Reply-To: <DK75LUA4NLGI.3P29AIZQE20V2@kernel.org>
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: cc02c9dc-bacc-49a3-7d31-08deea0713b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: H/ykBj6W0MavvQzihbuTPO9l8GFTkATj59FOB3pLJD/Lw1w1qMNxBfqT2o95JGo+f6slDDG4wTAF7NOJeZ0fRCmElPzMsqBpCV+2KqFuJU/YR+0QdUczY0kVwfpbsVtk/feTFWiKkyeJiKWWokT5n9mrCoLUlLDzf92eZ0DIM8j6SwpT1AxrGJoImfmVtT2f0wycZk592siVIuEy1/49LFhcxx2skLA5knpcwgaxlZhbQPY0ViUd9qXdcn0ILDCvJv2vNq1d/lRTKjhtwcMtfAcpphrg3CWtewtvdzDPkskFK1dD3g7czKOOS50Akw4Sgle6PshlLSqC0zqOW5F+3Qy7OuGtwaV6Ll4F1xwgLsMPFvdTPwqM15tbZBNXYvhbmCi0C12hTbwi9COsd/rqWkiNaKnDEVXeLrpxhqbF/jECa2gaZ/Q2xTKFZH4ggMKp9bkx3YF1Q+AI7H87MA1ZMd0wKdVFgIzLF3/zreoPr3rGjB3ydsLbZv85VxK5IT6dAj1C/uKdaCbo2v9oWiX8HubgNjxHWXwuxzsg/znSyoGZ4kSUQmvFEVY5GpEvHkO9jOkK8NiyssLEJbcHxZvcaGk7TNUDcfmrpiqVlKfJt/2qREV1U5yp0U6/48tif3zwMNG7/K95IrhIjYCut51T6Hu/oawvPydFQP87ITSQfN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhIR1B1ZncxcEJYUUZ2WmdBZUhSMzhOMEo2VE9MNTU3TFJReHVlc2lWMWsx?=
 =?utf-8?B?eU1ncVVDY1hBTTc5bG9jOVhKeFBPN2VnZkZrdHdsQTU0V1YzSFliTVJ0WTRN?=
 =?utf-8?B?NHBrSnBRQkpud1B4MTYzaGhTVmdLQW9pc0svZmZSY2wxdThBc0JhZHRTQThi?=
 =?utf-8?B?dWRjdVY5MEhZWWpkczhmeHBSdmNBdWRhYVJsbFRrc1Bhb05uRE1BNTBZSXhQ?=
 =?utf-8?B?N1loT0tMN2pYRzZpY2xPWG5NVUYxNHgyNE95Tkcwam5sak1GUjMxdmRyclU3?=
 =?utf-8?B?RXlrQjFHQnUzcTJRenFFU3hjRHp3K2dIakM4VHUxVDRaVHFieVEzRlZ5SXZz?=
 =?utf-8?B?bTdCREdlcko1cjBmOEVuZjg0b3JUSUYvZU5Vazg5QWZJa3RBQ1VuOFlkamNH?=
 =?utf-8?B?eGtPcHZPWlVKLzA0RTBwS3gzd0JDVUtJRGR2bXY0Qk8rTjBhSVp4aTlUb2xw?=
 =?utf-8?B?bFVzMTIvSy9zeUVuVU1KeWtsTloxenFTbDRtT3I3VHIySzdNZzFTeVVsOE9I?=
 =?utf-8?B?cGpYeUZ6cHhIajh4Q0dkMDN0R3M0QnR1TDl3QkY4Wm42RVZGMmlQYTVtWHFk?=
 =?utf-8?B?KytVR1d4QmtNRTE5VmpCbHFoRFBLUjRFaExhY1d3amhPQzVJbVNIdlRPWnBB?=
 =?utf-8?B?S3Q1SnludCtEZ3RpRnpvbUVkZVhDNk5adzZoYnlaTGRLVjREblFoaFdFWC9L?=
 =?utf-8?B?dVlhaURMK203TGF5SDNpQ0VKUlkvcVlzaXN2Y2JoNDcrM0dzM3BmUXBvOGpv?=
 =?utf-8?B?UzFJeEk5OG0wRVgvbjljNVVuakdkQVUrNHpsYjN4YmRXaFN2dGZmUG5uMjAz?=
 =?utf-8?B?d2VISmgwcXJ4SUlPbDFZbVROTHBSQnNSeUNrRDFyVW9sZi9ra25CU0ozWmdY?=
 =?utf-8?B?Rk1FL25TRWxBQS83bHF3bXI0bnpyU1pJajVMc1RoVDBwWktLY1BTS3Ewd1Ux?=
 =?utf-8?B?ZGY3VHhXcSs3QUczM1JvKzRHL3hKZ2ZjWmhra3AwOWZqV2VRVTNmaVJXWUhR?=
 =?utf-8?B?bnBpUkt6WWpORXo0RlgwWFVYbm90M2hDeWxQK0JKeHNsclhwT0dFWVhYbFh1?=
 =?utf-8?B?RGxhbFdvN3VXOVMyVjQzUXlOcHpsYjMzaVQ5MFJmQVdKcWJGQmgvNVVHQU85?=
 =?utf-8?B?UGhER2RCUC9lMHNac1dDamg0WGxqL2EveExiOFFTOVAzdXVIMVFRVXM1RVZG?=
 =?utf-8?B?YzJFRDNiSTVoOHhrZFdxeFZtb0kvTytoQmF3a3VTRXRFVEJHYVdKODU0ZGlN?=
 =?utf-8?B?MEYxeDliVUR6eEF6NTZ3UzRTNkNGR0FWYzJjT3BTQU5lMFlhOTRydEYvaXBF?=
 =?utf-8?B?bnVXeFNkS1E2MzYrc0JTR1RUUThHU3RRdmhVK3gybWRLMXYvc3hMZGFkbkdz?=
 =?utf-8?B?cGhwR1FIWDMxMStTNmlMa3IyMFJUZHhmYkdVZUhqRWlMZ0hzK2YzUy9WT1VM?=
 =?utf-8?B?L0x2V1dqdElRSnBTbDRjUmhxUUc2YVpTcHFzSXBBSUp0VC83VlIrcXFPS1Zz?=
 =?utf-8?B?eGpJU0xXdkl1bkFiMHZSVS9FSFJJQStYdzdxb2V5YmwrTVUyMHBvb3NrLy8y?=
 =?utf-8?B?SmxJdVRHTWZPUkJJcjBjR1dFcTMwM2JUOUhnako5bFRpbFhvcm50YjhtN3Jt?=
 =?utf-8?B?cVNNWSswU0l1UHMyV3BpaklocFFqUWFkSW5lVmlWYm5KbjJXOENtc2dYSDVD?=
 =?utf-8?B?TXYzUXB2OTdzY0pnSEJMRitRcXBPVzhXM2x1blY1Y2RpSy9OSlpFNkoyTzBV?=
 =?utf-8?B?RHdGbE11TXNiWFRjSCs3NEFneTYwRXZNMXg3L2J4VTMvaVdJK2FjTi9SM3do?=
 =?utf-8?B?RDU1ajNVTUdES0ZxUzBiTC92UDBUbzZhZDlxSWFTdmdnOWdPSUZwcHVML1Vp?=
 =?utf-8?B?M2t4RWpXRGQ1RmpzTUpadVYzeGsvZm5Na0I3OEJqVEJqOWhzNEtkdVhtcDZx?=
 =?utf-8?B?bDZzTkFTVEI4QVlPM0lNM2ZtQjRCczF5UVM0NTYybExIZ1VmTEtHdjM2VjFa?=
 =?utf-8?B?ZXQ0N2JyL3Njcy9NdDRQMVFnSnRENC9sSm5jZm1oY3JvVTAzUElDQTlyTEg0?=
 =?utf-8?B?cElsdk9vM0Zra3dwdEgrdmNyR2VEaWt1N3lEN1VIalFlUC9lZ0VwZTgyU1hG?=
 =?utf-8?B?dUl1RERaeGs5VUtpMDZ2Rkl3WTVzRG13MmNuV3JVRzliTkNuSEtTNEVkMEw4?=
 =?utf-8?B?T3pvTytkSVcvVFlWczVialRGM0pXNTZRL3hvRG9GUWpBSzVZQkN0ZVVmZDNm?=
 =?utf-8?B?UHZWeXpHWkxpTmV1K2gydGtKZnRYOS9hUUVzUS9QNjlQeWJPMVpGRDFvUTBn?=
 =?utf-8?B?MFFjd3RYaU9pSHNybFkzYXQyTXdBZkE3VWtlSHdaeWpnU29mY1RhWUV5amRG?=
 =?utf-8?Q?+cxOpJ2jzxEQgXDyEEXzOAVNrrZRa3XuZyRYP5UXWuIES?=
X-MS-Exchange-AntiSpam-MessageData-1: ZhcdWBgcdyXl9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc02c9dc-bacc-49a3-7d31-08deea0713b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 04:42:05.2460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0m/gDbWv6YosqwEfoOqjajg+STHvBu42EU7a4X51DYLcfBtPhq3iARLMdSGnyThSB2vPewt8OZXepLzQQaoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

On Sat Jul 25, 2026 at 7:27 AM JST, Danilo Krummrich wrote:
> On Fri Jul 24, 2026 at 8:10 PM CEST, John Hubbard wrote:
>> Sort of "conceptually pre-existing" problem, but "handle" doesn't
>> quite work as a name, because handles are supposed to be opaque
>> items that one just uses to find and refer to things.
>
> This is inherited from the C API where from its perspective the returned =
base
> DMA address of the allocation actually serves as a handle.
>
> In Rust the actual handle is represented by different types with differen=
t
> invariants and hence capabilties.
>
> (For instance, dma::CoherentBox does not expose the DMA address at all, a=
nd
> hence provides access to its contents through a direct mutable reference,
> whereas dma::CoherentHandle only provides access to the DMA address and d=
oes not
> have a CPU virtual mapping; dma::Coherent provides access to both.)
>
> Both dma::Coherent and dma::CoherentHandle have a dma_handle() method whi=
ch
> provides access to the DMA address; this naming was taken over from the C=
 API.
>
> Given that the base DMA address serving as a handle from the perspective =
of the
> C API is just an implementation detail, we should probably just rename th=
is
> method to dma_address().

I was also thinking about using `dma_address`, so let's do that!

I guess the pieces required to support a proper DMA range type are also
starting to fall together.
