Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314B4109448A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B39110E261;
	Sat, 21 Mar 2026 16:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Ghz2Wo+L";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020079.outbound.protection.outlook.com [52.101.196.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7180410E261;
 Sat, 21 Mar 2026 16:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHrI3mdSMGOfBhkwt5n9RH8JxnXReMWsTUNuNYX/do7l94zFuvYD/TzO51yaTrQ4JH9HMdPdspVl+V3h81yN9aYoEd5jdlpStaUUysXnXKAqRPKKU24zFDH4FkRI0YyxC3tnHvlM/h/TfpVB8MynZGmlVhUsn+phj/9iqmqx/eGMRRf/QRvSM4n8DPFpKGVqTTA3TEHGgvIPlQjixzsehp9bjY8PlOVP5ajjQTE+TG1EG3x49aEi8aN5yTGc/JUt9Z5XmmZQyXWZEGdXL/GFXaXB9Ypq7WUH6I2WtXUupwvZ3hgFv0xmaZsK3sI36IEOyWWiM70A8/3sS0Q9XVKXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boFIB5MdEm5cQUI9iMiUL1NgdinHGvC5vbMSQMUyv4M=;
 b=myBRqzU1Y0jufq5ZookAPZxK3RamZArbvImHTHFlWsSw6GDhspzVjQr5qyvQj/a9ZmM4xS61KZOtfp1YwbAR/Rl80Cgzt+F8dTK7YjldqG0oXGc86HL3uZdZm7K5RrC8Svu/mzFwSJvuiwWF/c9kHyoaGLDXMplI3pNjl/32+BDAcegSeDMWkGsde+OJUVtqz3DM6T9+Fad4j/fAIrN7MSf7/ejJPnlU148VZOZUWBmcvwQlf+eHMMZot8cbTPjpTzr8WIKF2R8rfmm4gyK2vH8w9JdPpMU45fxSGv1rOps5l5v5VDtXQfJc+nRQ4I+qTDbtGwETyWhWyySfyeNETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boFIB5MdEm5cQUI9iMiUL1NgdinHGvC5vbMSQMUyv4M=;
 b=Ghz2Wo+LI4CgUTMYMze9q2qovQTvYv1ARsuvDG7sq+hsG1g7F9M+6LVsR3s0598ymluGjIIR7Um0uQlkofZGf/IB5S8ZSHVQwlmqsKf0bMehvJVw6P5KmpotvwnrRle5H35e5q4etSLnBkyazRqyHjF1vIhrBID7eefz11+hZFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6131.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:248::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 16:50:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 16:50:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 16:50:38 +0000
Message-Id: <DH8M5QZKZETW.3TA4YS1SBAXDP@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] gpu: nova-core: convert to new dma::Coherent API
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-9-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-9-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: d081c355-dd89-42f0-d18c-08de8769fb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kNrHunnbm947VoqDf34oNh1No13Fg+R8jR2kj2znQChGNX2dYa+b4Tkqebqg5b6uyj/VhJV7ESUVVRkeeCs6VwmjKYGbvY0Usn0YLxgi4l50Kmb2uKkQ3OUoYUv1FDTg0Z52NpAXEOqx8hG9ztsPJ2WhcgkFYPwmyPzSUa8uD9OOL6qBprw8s22U3kNFZ6xVjdBoUb5nUhGV34HlXcQ7+dSg/LPv9h7evRUGnJ21WtL46EMHUpFXEiwU5dHVw2uYuWCkhkQgtOMGRAr20GoKv809JdqlrzoIPBX4hyMyUv6+CBrO+RM6pzpSWZK5pVQOMjp0+PsjYvyqqfwAMebEmcZbrVUAiNNgNLUza7sb1zcTfvVy0A3uS64dsU7XwBXJ29Cxy5PJohxPMdln+qa9WHzBG4MoNFFmZ6vukDLDw4VW1B8JeGt0VgTmnyJkt15eKji5djnbEwr6IwH3UKmQO723WhXwjUN6JTPySbl0cBs5jRXvcrrGAK1AtU04kziGr6DtW/Z7ofeum6+Ck+Bi8lPrBvaX+eAyYx/o3EK3Mj0RLHpMUFhT1pRGExTnqVdbDwOxaeCEI2Meg5PhPRk4qKmjAMijAWGykc++ZdWgsIxdd19+dHVWu5RDPzDj8MKWUtcM8xlnGAsAyitMKnUTA9THUIkU8LofeGB9zxFum8dqs9dNPM5ka1/ew/Fqw1pt037WpEynjeDWUHhch/DVUXEYIC6NBcgdRq1W2LlNqoZKTKDBzwJ25jcYHfwoyPgbRJmdb2kWSEBPW5Nl/3SD8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElkSHUrYVU1VjdZcjBVUnV5c1luUlFzK0NxcitVUU56U2I2Y3I5Tm5ZQ1VR?=
 =?utf-8?B?M2trVytoa0U1b2dLVTBZbzMvZFJ2dHZ2SzBXQTBLcGpMZEl4cTBZQmNaazRx?=
 =?utf-8?B?aHVqVE40L3Zpcm1KRTRUd3lwVmZxYjdudE13elFuUDFDVlJBN0VWZmo5c09J?=
 =?utf-8?B?SHMrc05sbjJGakp1OExMQVhrMnZ5TG15QURueXZVZmViQVpGSEFQUHVVRkMw?=
 =?utf-8?B?cjhHcENhRzhUbzVEOW14ZXRTZVlWOGpOVHJHQk8vMFVHS09sR2F1VkN1eUts?=
 =?utf-8?B?cmNRQWlXazBnS3QyanpmeFNrc3pqZ0h0V2UzTGVneFhFU1FVYmdNV1lxcVB0?=
 =?utf-8?B?RW4wTVFNOVNCa1FhT1ltR2VmdWNrYVFSK0paMFpwdmFaUGl6UHpWcGo3S1BJ?=
 =?utf-8?B?MFU2TGd3QnpsRk1tUlVMVTdFYlk1ZlZDUE5SakFlRVpGQzJhZ1NYUzhDMGZ4?=
 =?utf-8?B?dVZyQ291OUJ6TWkzTHJLbVlNVDJlZjBXN3JvZFBkR25DQjN6VkdZRll1cWVF?=
 =?utf-8?B?TXZWcjh1M2xkdktuWkdBQkN1Qks4WkhFMlQ0aXlBSEt4dW1sbmJPOFJTY3Mx?=
 =?utf-8?B?djZNTkx2eS9KZHh6cVVwMnA2c2pjUzVLZTNiTkQ2Y2RTNVdWZFJBajQyNWRr?=
 =?utf-8?B?bHkxVXBZSk1Sc29XR283dWM4bzlod0QrdEh4WVUvaEFHQjBjZ2krSlBXVU1z?=
 =?utf-8?B?L1ptbXJ5RGRnL3pFUFZ3anNnWHJUQzg0K1JZc1I2RUhLTkVlWTRHWFVUL0V2?=
 =?utf-8?B?UW93dGRic0doNXcxa01JYi9OdVU2dnZRS042VzExN2VkcFczcGh5bENyRXJk?=
 =?utf-8?B?MkVQWjI5UTRFS1Z5K3R6bHhnL2IvbzdDZ09sN2pRRE5vVTRsbzVpalBPNGpl?=
 =?utf-8?B?SXFHMm96VFhNcGNYWEY2TUtOSzhZZVhqaXdBOG9VaHkwd2V4UU9ZZENGWFVK?=
 =?utf-8?B?YTlTbmRnd2xzWmRvYm9GOHZET3gyMWZ5RHFLeTl4cEc0aTduYk1FODRDMWhi?=
 =?utf-8?B?MGxLclhMZHpuYWxpd24zaWwyenIycU95VjljY2MwR2UzTGxaK1k2UWVqblJn?=
 =?utf-8?B?YzRrTFphQ0RFWC9sbGlyc1NhaWFIb0VHRStlMWJweklzQUV4UjVNRC9kZG1j?=
 =?utf-8?B?eUU4aG1MY1pyVEdEZkdTakMxQWJPSkxSeGRvVXlNS0VTTWdJWG5mVWdHUUtP?=
 =?utf-8?B?S1F5K25LYU5JUFNzVnVmTmo4bExDYmw2ajVxTGVlUVlmbFQwUjMrdFZna0xv?=
 =?utf-8?B?VEd0Q09vWmRobXZmM0JNVURySDFlVndVM0J0V21EUWttVG04Yy96alpWV2pH?=
 =?utf-8?B?MmZ3Q2xia1huRDhMQitEZjlaVU16amZLa2ROMG9KV1liL3hLR2VUWEhteG5T?=
 =?utf-8?B?d1pCbWpkaitUeXY0a0l5RG84WlZROEttTG1KV0E5TGhkc2JJWURWSGpsQmZV?=
 =?utf-8?B?bTZDUHNTRjAwckpMK1Fnc3llNm9kWnNMS0FXbWtwN2wvZTVtZUdqN3dRZnBi?=
 =?utf-8?B?UWM4U1h1NWs1ZXduTDd1MWF4NkJBZ2N6aWM4RVVRQTNNUGJkNDFmRDlLY0tJ?=
 =?utf-8?B?VXpRclI3ZGN3OHJYU3lMbXVDSmRUQmEvYUVkN1NPZ3FDL0VlN1J6UHFmU3Fi?=
 =?utf-8?B?cngzV25MOHg5azFsM2l4b2J4Vjg2TUFueHc2UFNBUkV4MjJtV1V0QUhGdW9t?=
 =?utf-8?B?cWxrd0RGZ2swNEp5VDF2QnhOT05nU1hVTjVPbUpERno1bkZmb3hhOU41bkhF?=
 =?utf-8?B?bFkwV2s0aDQrcjIydWFyUXdpWlh2aGs2ekx4YmtEOUlYaEQ2a2NSbXRnQmMr?=
 =?utf-8?B?aS9JRm5RL0daMVI5UFZkRW5jaDF3VXBxZ25rNFp1TUU5VWdhcjRIM29FU0pz?=
 =?utf-8?B?czIrYWFaSGZpdnRRd2ZiMW9lb29KWmRZZEhXbkk3azNXV0htZkpxRmlPMWxq?=
 =?utf-8?B?dXpyR2ozQXd0VTVkL0VaNXdVV2duazVCeWlUbkJJazIwdHlZOXRwbSs5Q3Ew?=
 =?utf-8?B?OGdyZStnRFVlOVNMT1BIYWsrLzZKYnZmaEpQZDVVZFFsMllTbFJGTFJlWjVh?=
 =?utf-8?B?bHd1WjNxOG1wMDAxdm10WWJnUjBxWnZ1eE1mQlU1ZGxlKzFEaHdwVmJBZ090?=
 =?utf-8?B?TFpSQ29LZGJzaEdIWHoxTlVxZndlR2hFejhaVjRIdXcyVWRVUHZZS1FtQi96?=
 =?utf-8?B?ditZaTZDendSNTdzaWdXZ2JmbzB2dXNzMms0VUFRMzgzRUYrQWZBcitHK0Zk?=
 =?utf-8?B?SHR6L2gyMFJUaEYrbmczQVpvSzVrQ2R1NXc4SUU2WjNCbnBiMVU3UDVHQzZx?=
 =?utf-8?B?QjErQmhpUys0MXpWRTZ5R0ZlZXo2QXJPR1dMcE1zbW1SOUNwT08wZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d081c355-dd89-42f0-d18c-08de8769fb06
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:50:38.7147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eOkePaOrkK0oQpHuTZPIkYnSrkt42s92cFSWbzkflUSje6RLvfNaPEIywVzeiY87JkTZDP7Oun56TaCNt46GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6131
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

On Fri Mar 20, 2026 at 7:45 PM GMT, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Remove all usages of dma::CoherentAllocation and use the new
> dma::Coherent type instead.
>
> Note that there are still remainders of the old dma::CoherentAllocation
> API, such as as_slice() and as_slice_mut().

Hi Danilo,

It looks like with Alex's "gpu: nova-core: create falcon firmware DMA objec=
ts
lazily" landed, all others users of the old API are now gone.

So this line could be dropped and `impl CoherentAllocation` and the type al=
ias
can be removed after this patch.

Best,
Gary

>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/dma.rs      | 19 ++++++-------
>  drivers/gpu/nova-core/falcon.rs   |  5 ++--
>  drivers/gpu/nova-core/gsp.rs      | 21 ++++++++------
>  drivers/gpu/nova-core/gsp/cmdq.rs | 21 ++++++--------
>  drivers/gpu/nova-core/gsp/fw.rs   | 46 ++++++++++---------------------
>  5 files changed, 47 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
> index 7215398969da..3c19d5ffcfe8 100644
> --- a/drivers/gpu/nova-core/dma.rs
> +++ b/drivers/gpu/nova-core/dma.rs
> @@ -9,13 +9,13 @@
> =20
>  use kernel::{
>      device,
> -    dma::CoherentAllocation,
> +    dma::Coherent,
>      page::PAGE_SIZE,
>      prelude::*, //
>  };
> =20
>  pub(crate) struct DmaObject {
> -    dma: CoherentAllocation<u8>,
> +    dma: Coherent<[u8]>,
>  }
> =20
>  impl DmaObject {
> @@ -24,23 +24,22 @@ pub(crate) fn new(dev: &device::Device<device::Bound>=
, len: usize) -> Result<Sel
>              .map_err(|_| EINVAL)?
>              .pad_to_align()
>              .size();
> -        let dma =3D CoherentAllocation::alloc_coherent(dev, len, GFP_KER=
NEL | __GFP_ZERO)?;
> +        let dma =3D Coherent::zeroed_slice(dev, len, GFP_KERNEL)?;
> =20
>          Ok(Self { dma })
>      }
> =20
>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &=
[u8]) -> Result<Self> {
> -        Self::new(dev, data.len()).and_then(|mut dma_obj| {
> -            // SAFETY: We have just allocated the DMA memory, we are the=
 only users and
> -            // we haven't made the device aware of the handle yet.
> -            unsafe { dma_obj.write(data, 0)? }
> -            Ok(dma_obj)
> -        })
> +        let dma_obj =3D Self::new(dev, data.len())?;
> +        // SAFETY: We have just allocated the DMA memory, we are the onl=
y users and
> +        // we haven't made the device aware of the handle yet.
> +        unsafe { dma_obj.as_mut()[..data.len()].copy_from_slice(data) };
> +        Ok(dma_obj)
>      }
>  }
> =20
>  impl Deref for DmaObject {
> -    type Target =3D CoherentAllocation<u8>;
> +    type Target =3D Coherent<[u8]>;
> =20
>      fn deref(&self) -> &Self::Target {
>          &self.dma
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 7097a206ec3c..5bf8da8760bf 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -26,8 +26,7 @@
>      gpu::Chipset,
>      num::{
>          self,
> -        FromSafeCast,
> -        IntoSafeCast, //
> +        FromSafeCast, //
>      },
>      regs,
>      regs::macros::RegisterBase, //
> @@ -653,7 +652,7 @@ fn dma_wr(
>              }
>              FalconMem::Dmem =3D> (
>                  0,
> -                dma_obj.dma_handle_with_offset(load_offsets.src_start.in=
to_safe_cast())?,
> +                dma_obj.dma_handle() + DmaAddress::from(load_offsets.src=
_start),
>              ),
>          };
>          if dma_start % DmaAddress::from(DMA_LEN) > 0 {
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index f0a50bdc4c00..a045c4189989 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -6,13 +6,15 @@
>      device,
>      dma::{
>          Coherent,
> -        CoherentAllocation,
>          CoherentBox,
>          DmaAddress, //
>      },
>      pci,
>      prelude::*,
> -    transmute::AsBytes, //
> +    transmute::{
> +        AsBytes,
> +        FromBytes, //
> +    }, //
>  };
> =20
>  pub(crate) mod cmdq;
> @@ -44,6 +46,9 @@
>  #[repr(C)]
>  struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
> =20
> +/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapp=
er around one.
> +unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES=
> {}
> +
>  /// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper=
 around one.
>  unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> =
{}
> =20
> @@ -71,26 +76,24 @@ fn entry(start: DmaAddress, index: usize) -> Result<u=
64> {
>  /// then pp points to index into the buffer where the next logging entry=
 will
>  /// be written. Therefore, the logging data is valid if:
>  ///   1 <=3D pp < sizeof(buffer)/sizeof(u64)
> -struct LogBuffer(CoherentAllocation<u8>);
> +struct LogBuffer(Coherent<[u8]>);
> =20
>  impl LogBuffer {
>      /// Creates a new `LogBuffer` mapped on `dev`.
>      fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>          const NUM_PAGES: usize =3D RM_LOG_BUFFER_NUM_PAGES;
> =20
> -        let mut obj =3D Self(CoherentAllocation::<u8>::alloc_coherent(
> +        let obj =3D Self(Coherent::<u8>::zeroed_slice(
>              dev,
>              NUM_PAGES * GSP_PAGE_SIZE,
> -            GFP_KERNEL | __GFP_ZERO,
> +            GFP_KERNEL,
>          )?);
> =20
>          let start_addr =3D obj.0.dma_handle();
> =20
>          // SAFETY: `obj` has just been created and we are its sole user.
> -        let pte_region =3D unsafe {
> -            obj.0
> -                .as_slice_mut(size_of::<u64>(), NUM_PAGES * size_of::<u6=
4>())?
> -        };
> +        let pte_region =3D
> +            unsafe { &mut obj.0.as_mut()[size_of::<u64>()..][..NUM_PAGES=
 * size_of::<u64>()] };
> =20
>          // Write values one by one to avoid an on-stack instance of `Pte=
Array`.
>          for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).=
enumerate() {
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index d36a62ba1c60..f38790601a0f 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -7,7 +7,7 @@
>  use kernel::{
>      device,
>      dma::{
> -        CoherentAllocation,
> +        Coherent,
>          DmaAddress, //
>      },
>      dma_write,
> @@ -207,7 +207,7 @@ unsafe impl AsBytes for GspMem {}
>  // that is not a problem because they are not used outside the kernel.
>  unsafe impl FromBytes for GspMem {}
> =20
> -/// Wrapper around [`GspMem`] to share it with the GPU using a [`Coheren=
tAllocation`].
> +/// Wrapper around [`GspMem`] to share it with the GPU using a [`Coheren=
t`].
>  ///
>  /// This provides the low-level functionality to communicate with the GS=
P, including allocation of
>  /// queue space to write messages to and management of read/write pointe=
rs.
> @@ -218,7 +218,7 @@ unsafe impl FromBytes for GspMem {}
>  ///   pointer and the GSP read pointer. This region is returned by [`Sel=
f::driver_write_area`].
>  /// * The driver owns (i.e. can read from) the part of the GSP message q=
ueue between the CPU read
>  ///   pointer and the GSP write pointer. This region is returned by [`Se=
lf::driver_read_area`].
> -struct DmaGspMem(CoherentAllocation<GspMem>);
> +struct DmaGspMem(Coherent<GspMem>);
> =20
>  impl DmaGspMem {
>      /// Allocate a new instance and map it for `dev`.
> @@ -226,21 +226,20 @@ fn new(dev: &device::Device<device::Bound>) -> Resu=
lt<Self> {
>          const MSGQ_SIZE: u32 =3D num::usize_into_u32::<{ size_of::<Msgq>=
() }>();
>          const RX_HDR_OFF: u32 =3D num::usize_into_u32::<{ mem::offset_of=
!(Msgq, rx) }>();
> =20
> -        let gsp_mem =3D
> -            CoherentAllocation::<GspMem>::alloc_coherent(dev, 1, GFP_KER=
NEL | __GFP_ZERO)?;
> +        let gsp_mem =3D Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
> =20
>          let start =3D gsp_mem.dma_handle();
>          // Write values one by one to avoid an on-stack instance of `Pte=
Array`.
>          for i in 0..GspMem::PTE_ARRAY_SIZE {
> -            dma_write!(gsp_mem, [0]?.ptes.0[i], PteArray::<0>::entry(sta=
rt, i)?);
> +            dma_write!(gsp_mem, .ptes.0[i], PteArray::<0>::entry(start, =
i)?);
>          }
> =20
>          dma_write!(
>              gsp_mem,
> -            [0]?.cpuq.tx,
> +            .cpuq.tx,
>              MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
>          );
> -        dma_write!(gsp_mem, [0]?.cpuq.rx, MsgqRxHeader::new());
> +        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
> =20
>          Ok(Self(gsp_mem))
>      }
> @@ -255,10 +254,9 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
>          let rx =3D self.gsp_read_ptr() as usize;
> =20
>          // SAFETY:
> -        // - The `CoherentAllocation` contains exactly one object.
>          // - We will only access the driver-owned part of the shared mem=
ory.
>          // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap=
()[0];
> +        let gsp_mem =3D unsafe { &mut *self.0.as_mut() };
>          // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_=
NUM_PAGES`.
>          let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_mu=
t(tx);
> =20
> @@ -309,10 +307,9 @@ fn driver_write_area_size(&self) -> usize {
>          let rx =3D self.cpu_read_ptr() as usize;
> =20
>          // SAFETY:
> -        // - The `CoherentAllocation` contains exactly one object.
>          // - We will only access the driver-owned part of the shared mem=
ory.
>          // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
> +        let gsp_mem =3D unsafe { &*self.0.as_ptr() };
>          let data =3D &gsp_mem.gspq.msgq.data;
> =20
>          // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_=
NUM_PAGES, inclusive,
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 0d8daf6a80b7..847b5eb215d4 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -40,8 +40,7 @@
>      },
>  };
> =20
> -// TODO: Replace with `IoView` projections once available; the `unwrap()=
` calls go away once we
> -// switch to the new `dma::Coherent` API.
> +// TODO: Replace with `IoView` projections once available.
>  pub(super) mod gsp_mem {
>      use core::sync::atomic::{
>          fence,
> @@ -49,10 +48,9 @@ pub(super) mod gsp_mem {
>      };
> =20
>      use kernel::{
> -        dma::CoherentAllocation,
> +        dma::Coherent,
>          dma_read,
> -        dma_write,
> -        prelude::*, //
> +        dma_write, //
>      };
> =20
>      use crate::gsp::cmdq::{
> @@ -60,49 +58,35 @@ pub(super) mod gsp_mem {
>          MSGQ_NUM_PAGES, //
>      };
> =20
> -    pub(in crate::gsp) fn gsp_write_ptr(qs: &CoherentAllocation<GspMem>)=
 -> u32 {
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result<u32> { Ok(dma_read!(qs, [0]?.gspq.tx.0.writePtr) % =
MSGQ_NUM_PAGES) }().unwrap()
> +    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
> +        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
>      }
> =20
> -    pub(in crate::gsp) fn gsp_read_ptr(qs: &CoherentAllocation<GspMem>) =
-> u32 {
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result<u32> { Ok(dma_read!(qs, [0]?.gspq.rx.0.readPtr) % M=
SGQ_NUM_PAGES) }().unwrap()
> +    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
> +        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
>      }
> =20
> -    pub(in crate::gsp) fn cpu_read_ptr(qs: &CoherentAllocation<GspMem>) =
-> u32 {
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result<u32> { Ok(dma_read!(qs, [0]?.cpuq.rx.0.readPtr) % M=
SGQ_NUM_PAGES) }().unwrap()
> +    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
> +        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
>      }
> =20
> -    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &CoherentAllocation<G=
spMem>, count: u32) {
> +    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, co=
unt: u32) {
>          let rptr =3D cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAG=
ES;
> =20
>          // Ensure read pointer is properly ordered.
>          fence(Ordering::SeqCst);
> =20
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result {
> -            dma_write!(qs, [0]?.cpuq.rx.0.readPtr, rptr);
> -            Ok(())
> -        }()
> -        .unwrap()
> +        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
>      }
> =20
> -    pub(in crate::gsp) fn cpu_write_ptr(qs: &CoherentAllocation<GspMem>)=
 -> u32 {
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result<u32> { Ok(dma_read!(qs, [0]?.cpuq.tx.0.writePtr) % =
MSGQ_NUM_PAGES) }().unwrap()
> +    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
> +        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
>      }
> =20
> -    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &CoherentAllocation<=
GspMem>, count: u32) {
> +    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, c=
ount: u32) {
>          let wptr =3D cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PA=
GES;
> =20
> -        // PANIC: A `dma::CoherentAllocation` always contains at least o=
ne element.
> -        || -> Result {
> -            dma_write!(qs, [0]?.cpuq.tx.0.writePtr, wptr);
> -            Ok(())
> -        }()
> -        .unwrap();
> +        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
> =20
>          // Ensure all command data is visible before triggering the GSP =
read.
>          fence(Ordering::SeqCst);

