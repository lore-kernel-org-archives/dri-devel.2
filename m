Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95CC1099B30
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5FB10EB56;
	Fri, 20 Mar 2026 21:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="YBZTEr2P";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022087.outbound.protection.outlook.com [52.101.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997BC10EB56;
 Fri, 20 Mar 2026 21:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PChICM7A52mfL/DNCydXOiOgl2zC1Wo9cBQGFOP7rs/MAk4uOg4OA7L1tD0HeLdUKjtwuGo87pFcos71V5sg4dBJDq7M7b23PWuSt36vDOJcKJZsfttehQc/4KdPk065HqEVhHkweQsDx2/lTQnw46QbWlN8n5ueDKY6u8TxTASno4C6m5cUYtN3C0bYWV8v7qKLhv8HXlYcmS4JHBw3DGD8604OA3IWxzMETD/ijf/Jp8JYL90DguFwsQs30ILv+ENBAWgPzi+gb3jyzuKY+oRSjmKZDoG2Nca5bne7ZHKQPy4wcSh4gq8y/mznxCVX+hesvbEQgK2ghfssBKP/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ5CH0IKGwCcY9ci8yS5esZy3dQ/t0Mje4J3uHT99UA=;
 b=KWLyxLIJ+1YZy2NidvHAwpBwXwW+XlrpGdDWZe2acJ5LROeNPfF7H02Aa/WtN2hhw3LempVzj2urCgDQ7eRjxYe0Ugp3SIsy3gUjNGFXDijuf1cUNMU3PE1TUOi7DM4A701QAh2NfcHBFFDGRHAU8oYqHfOM62bjYQbinw0Nj1EuSB6mOYlsmvTxMPluCldymSwA/+8zmNcn7cHS/O48L00IHSVTmPHj0kIZvr+m7KHWTQc/DHV615JLJ1+C7DJkTbcdYyIdRadoA486npFCoYTtHD/2rz7ZM7xeEhW/M77dlr6pleOx681zkIK3VwpHQXwqhyKAJfrwKRhkGpJxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ5CH0IKGwCcY9ci8yS5esZy3dQ/t0Mje4J3uHT99UA=;
 b=YBZTEr2PlnKmOmcoyppLOdPd0LWSjAByORHPCrfP3OilIWWUqpabuV2HpNQd/16BDLiBM6Oc+VJzSK5d2ycEp/dgDSTtP2NPkZIBvL/W2MXyfINHcs2fRizDIt+96B/U44D3zFjwxPS2skR/onloSzSB2z45KL2cKhpTk1rP6qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB1997.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:111::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:06:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:06:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 21:06:42 +0000
Message-Id: <DH7WZ9R4J243.3LVQTQ0EI3ZKA@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: convert Gsp::new() to use
 CoherentBox
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-8-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-8-dakr@kernel.org>
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c6045-0305-4207-9e3c-08de86c49716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 6+jPdRgVdZIHOW5mlA/uTg53ZlOQiPazi2TyyVQtA0B87OMzRNiFnxFpt0OYIzJcSuSS9xHSJzXtdf/ghjNIjcAuc2icQYHDsDfW8/k7SBZizaewc8xYydMKLytQLQOZvriOObTcsGqebr9HsJ5d82BlgTnTTT7w8TuqWEZbrP7MZmvbwV7w0E16kpglOIQe2ebNhCzFkIsUX0N86/Ixoii3SCPRCHAln7ICPnnIrq+K87WaYA4f3o/hrlXQXD9AAQouQwxqx+20NyaRKoPDhluicNDrlpZO01MwHGovKP2QzZBll4IbnY8QY5dlnmeR8Oo6M+70QGoXi4KkcmLR/NPUoNTILxuCgC+1FRrZOZp0KbAcG+Zx71yCQ6etDqtYyGq6lqd0ga/4a7e+7DmyaRUxSrCQeNWVU3QYUk3HwMF12MfT1RmWQJI2a7TzwbdcpVG1e34z/NBNiHotosfWYTtUV/yXpSbkxWDnvXbWwaD50vPS8sEzq3t+e+IeoIfwYeiG5sBWmAVmlI4HMw5uPMzKFCLlxELz11igLV1ppn+y5dZdJPxonPwTetzDj5j5IltsaRUVm4N093CLvG7tz5QTBG83yDzsWU1/yM1Jiha+uuB95A8acHCYiMnhTn43VRdO/+dpMwsJFz6nLmJa5H8nGUq46iqG88vI4v9M2bDyfNKxUYy/fL5zlD0sKixqMaxenBZ3/nu2DCvLP/Sq4V7d3TLg5y+O4W9+SPqw5AByjmtnAYJqb7Vfo+GLmQ7CWhlt4Mgnaw+8cgsemJlHqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVoclAxK05EZnBmNXNDYkYvQlRkMnJDU2FuVW0rYWVtbjVPcTdyNlphdDZw?=
 =?utf-8?B?dVZCeHVCckFqL2hodGR0Qlp3Q1NPSFhBelF2bVB0UjI5YTI2WVdadzhlN3Va?=
 =?utf-8?B?dGlRS2RtczFpSkJ6TEd1RWZERFI2NEgxU1pEZEs3ZEl0eEFKQlNuS2FUV012?=
 =?utf-8?B?VmtNV1NBc0J3Nkt3TTlnbGd5MUh3QThCZVh2UXlrekF1STVzT2NFZ3YxR1VP?=
 =?utf-8?B?VVFuNHRGWEJJaFV6MGxFa3dsY05oU0dFcSs1eHdsQ0ZpMUlLTVcvblpLMFlq?=
 =?utf-8?B?SWxlL2hCOHJxSHVCS0YzUmhZOWsxOEgrL0NhTUtSSHdWUGJjNlpPUlJhY1Fj?=
 =?utf-8?B?YjRvYmxPV3diZFhKVVhkbVBzdXZLN2xJZmJ0L1V3QXJNK1drYVhzeW1wU3Y1?=
 =?utf-8?B?QUxialI3MkJRa0Z1Ry9ubkRCbnljZmhHR1lKK0pXUEszeExzTkZNYWZlRlFJ?=
 =?utf-8?B?Y0NOS3MxS1hqM1RLZkdtaWhlWkduVk9JKzJud1BMSUF6QS9QUUp1Vjh1QlR4?=
 =?utf-8?B?bXhUeHozaW4xbWtHL3FtYU9Kb1hRN0pEUHJTeU96RWZpZ1VTY2VNdVhjd2g3?=
 =?utf-8?B?d0M2UUJ4TVVVVHE5RkJudHhNMHhqLzRDUElhNWJhQmJ5eTZqWEsrUkZFNzRn?=
 =?utf-8?B?UXo4TFBsTEpDeE9acWx1WEYyU0d0U0h6SzVQN0hxMWVQdkZQcWJENXRyMG9z?=
 =?utf-8?B?N0NzSHhiVGRyTnovdVZkTjAvZVAxWTdaaHFWMVhpdXBETlk3TzNRYzRLU2Fx?=
 =?utf-8?B?enhQWVp6bWtucytsOVJBUWJXL3FiWjcyL3Q0bHk1OG9pQThXU1Z3ODg2cmlp?=
 =?utf-8?B?YUdlOWVSUmhqbm5nUmt5UGZHVjhIRWJ0bFFkUHgxVFdEUHFVc2NSWmhiYWZ5?=
 =?utf-8?B?S3pEK3FMMW9EYU1wMEZUeG52ZDZ6YkltUDZmMWpEQU5OUlRCWVN3Vmtwb2JF?=
 =?utf-8?B?a2hSTG5wZm5ZTmtpZ2E3ZzNFN3pVV0JPU2lyY3UyRUxFSlpUYkNwbldud0NQ?=
 =?utf-8?B?ZEQyemU5WjNLWXp2VGh3aEJ4Yi90TnZJMjM1Z2QwSGZGK2wvYnBGWm5yWktn?=
 =?utf-8?B?WnFpWWRHSmZ6VUsyVUs4dFpFQjZLRCtrck41ZUJvWDRZem50andkbms1NStG?=
 =?utf-8?B?b3lmSDFRYldNekFVaXNyT3pySWdqcUkrelpPUXlBa3JMNFdPcWVibjhMZ3kx?=
 =?utf-8?B?UFhiK1c2cGNXeVdkdGc2NDJrRWx1VEU4VFhNU3FmZVZQZUcxVUVNWEE2dEla?=
 =?utf-8?B?dFpyOEMxSU90MjlxcFMzalh4akw0Z1grMHAvSDQyeG94Q2pvbm1kd29QeG9K?=
 =?utf-8?B?SHZxcHBsanJ1dThNdFJkRFZGNkliWmZINmxyZ0dCb3VoTFdMbXo5VzRNbWNU?=
 =?utf-8?B?V0FBVWZkMTZpRENOanUzNUxJVjYxblRRbDVLQitNYlB2UTh6SXVlT203ZWd0?=
 =?utf-8?B?Z1h1eWk2K3luQWFlZ2YxSW1oVVhmaXMyQTVqSVJMMWtjc2FLTTI5bUF5NEFl?=
 =?utf-8?B?emY0SUpJVllWR2prMnlPalhESEFPTU15bnNaaGhLSmpWaWFxUGczRTd5VU1l?=
 =?utf-8?B?NkhNK3ptekdEeDRocCtWc1NVbEVDSkUxSFhCUlhobFNIYldwa29mY084R3hL?=
 =?utf-8?B?OENiOWRWLzY5dUIzZEpPeXVXTnE0YW5URlN1TDBtMys0NmNudWRsU2JHQmlS?=
 =?utf-8?B?aUFIUnlpQ2xLZmRnT1k5U1ErUHM5WDFsN1A1aSszM1VOVmdiazNCTURNUXRm?=
 =?utf-8?B?bS9NWUlWbmdWS0NueVI4MjdjY3ZnQXcxTXhkUjJDVmsxQ2dLeGYrcyt1SDVY?=
 =?utf-8?B?Zk9MM2dlRFNTU0RQb3JseklaUmFySWprRlJFRFo5NXBsSHhBSjNGeHdXQVA5?=
 =?utf-8?B?S1Z5ZHBBTmtvNmJGQU92TVdvYzJwQ1BISGRheHZvMVlrOTVjbTVkMVNSZGFn?=
 =?utf-8?B?QUUybkZRVUh1bnFNdCtFRzgyOXZxTFYxMVVrQjZud2FCSVdWYjhwNkxqZGEv?=
 =?utf-8?B?OWkwb2NSajRBb1NXZGF6YkFESDhNaC9HOGpONTRrN3lEZ2c4MGF3SGl2RnI0?=
 =?utf-8?B?UjZEQTBlOWtZTTdWb3prWk11NGVoS0FNS2NRMzJYZnlHNXlUdldYR2RKMGJs?=
 =?utf-8?B?UHhLcjRlc0EyVnhyclU4TEdaWEhUZS95SFovNXZ0clB3R2dHWVpYVGpqbkVv?=
 =?utf-8?B?ZXN5N2s5R2ZWYk9qSHp6b0NHRnVaVExvNDNGMnp6MG55SUVweEoyQzVUTThl?=
 =?utf-8?B?R2tRZ1c0Ulh5VGJTSWpUd1hVZjh3VkRpYzlBcGNSVGhrSUtsUVRIcnYzNFRN?=
 =?utf-8?B?UFlGZS8vRS91NVlJMUhyaUhOL0Nqa0FsYmxuM3UxQ3Z3M2d1eDNUUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c6045-0305-4207-9e3c-08de86c49716
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:06:44.0416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOdEZclzf22gEbgA16x8XSi188xPTWSKhAhhdq+4W3gv9InmMqaYKvQ8an7kMU/0AL1XlGDJHZSkbQKByLydpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1997
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
> Convert libos (LibosMemoryRegionInitArgument) and rmargs
> (GspArgumentsPadded) to use CoherentBox / Coherent::init() and simplify
> the initialization. This also avoids separate initialization on the
> stack.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/gsp.rs    | 47 +++++++++++--------------
>  drivers/gpu/nova-core/gsp/fw.rs | 62 +++++++++++++++++++++++----------
>  2 files changed, 65 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 72f173726f87..f0a50bdc4c00 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -5,10 +5,11 @@
>  use kernel::{
>      device,
>      dma::{
> +        Coherent,
>          CoherentAllocation,
> +        CoherentBox,
>          DmaAddress, //
>      },
> -    dma_write,
>      pci,
>      prelude::*,
>      transmute::AsBytes, //
> @@ -106,7 +107,7 @@ fn new(dev: &device::Device<device::Bound>) -> Result=
<Self> {
>  #[pin_data]
>  pub(crate) struct Gsp {
>      /// Libos arguments.
> -    pub(crate) libos: CoherentAllocation<LibosMemoryRegionInitArgument>,
> +    pub(crate) libos: Coherent<[LibosMemoryRegionInitArgument]>,
>      /// Init log buffer.
>      loginit: LogBuffer,
>      /// Interrupts log buffer.
> @@ -117,7 +118,7 @@ pub(crate) struct Gsp {
>      #[pin]
>      pub(crate) cmdq: Cmdq,
>      /// RM arguments.
> -    rmargs: CoherentAllocation<GspArgumentsPadded>,
> +    rmargs: Coherent<GspArgumentsPadded>,
>  }
> =20
>  impl Gsp {
> @@ -126,34 +127,28 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>=
) -> impl PinInit<Self, Error
>          pin_init::pin_init_scope(move || {
>              let dev =3D pdev.as_ref();
> =20
> +            // Initialise the logging structures. The OpenRM equivalents=
 are in:
> +            // _kgspInitLibosLoggingStructures (allocates memory for buf=
fers)
> +            // kgspSetupLibosInitArgs_IMPL (creates pLibosInitArgs[] arr=
ay)
>              Ok(try_pin_init!(Self {
> -                libos: CoherentAllocation::<LibosMemoryRegionInitArgumen=
t>::alloc_coherent(
> -                    dev,
> -                    GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitArgum=
ent>(),
> -                    GFP_KERNEL | __GFP_ZERO,
> -                )?,
>                  loginit: LogBuffer::new(dev)?,
>                  logintr: LogBuffer::new(dev)?,
>                  logrm: LogBuffer::new(dev)?,
>                  cmdq <- Cmdq::new(dev),
> -                rmargs: CoherentAllocation::<GspArgumentsPadded>::alloc_=
coherent(
> -                    dev,
> -                    1,
> -                    GFP_KERNEL | __GFP_ZERO,
> -                )?,
> -                _: {
> -                    // Initialise the logging structures. The OpenRM equ=
ivalents are in:
> -                    // _kgspInitLibosLoggingStructures (allocates memory=
 for buffers)
> -                    // kgspSetupLibosInitArgs_IMPL (creates pLibosInitAr=
gs[] array)
> -                    dma_write!(
> -                        libos, [0]?, LibosMemoryRegionInitArgument::new(=
"LOGINIT", &loginit.0)
> -                    );
> -                    dma_write!(
> -                        libos, [1]?, LibosMemoryRegionInitArgument::new(=
"LOGINTR", &logintr.0)
> -                    );
> -                    dma_write!(libos, [2]?, LibosMemoryRegionInitArgumen=
t::new("LOGRM", &logrm.0));
> -                    dma_write!(rmargs, [0]?.inner, fw::GspArgumentsCache=
d::new(&cmdq));
> -                    dma_write!(libos, [3]?, LibosMemoryRegionInitArgumen=
t::new("RMARGS", rmargs));
> +                rmargs: Coherent::init(dev, GFP_KERNEL, GspArgumentsPadd=
ed::new(&cmdq))?,
> +                libos: {
> +                    let mut libos =3D CoherentBox::zeroed_slice(
> +                        dev,
> +                        GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitA=
rgument>(),
> +                        GFP_KERNEL,
> +                    )?;
> +
> +                    libos.init_at(0, LibosMemoryRegionInitArgument::new(=
"LOGINIT", &loginit.0))?;
> +                    libos.init_at(1, LibosMemoryRegionInitArgument::new(=
"LOGINTR", &logintr.0))?;
> +                    libos.init_at(2, LibosMemoryRegionInitArgument::new(=
"LOGRM", &logrm.0))?;
> +                    libos.init_at(3, LibosMemoryRegionInitArgument::new(=
"RMARGS", rmargs))?;
> +
> +                    libos.into()
>                  },
>              }))
>          })
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 4e3bfc6c4c47..0d8daf6a80b7 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -9,11 +9,12 @@
>  use core::ops::Range;
> =20
>  use kernel::{
> -    dma::CoherentAllocation,
> +    dma::Coherent,
>      prelude::*,
>      ptr::{
>          Alignable,
> -        Alignment, //
> +        Alignment,
> +        KnownSize, //
>      },
>      sizes::{
>          SZ_128K,
> @@ -648,7 +649,9 @@ unsafe impl AsBytes for RunCpuSequencer {}
>  /// The memory allocated for the arguments must remain until the GSP sen=
ds the
>  /// init_done RPC.
>  #[repr(transparent)]
> -pub(crate) struct LibosMemoryRegionInitArgument(bindings::LibosMemoryReg=
ionInitArgument);
> +pub(crate) struct LibosMemoryRegionInitArgument {
> +    inner: bindings::LibosMemoryRegionInitArgument,
> +}
> =20
>  // SAFETY: Padding is explicit and does not contain uninitialized data.
>  unsafe impl AsBytes for LibosMemoryRegionInitArgument {}
> @@ -658,10 +661,10 @@ unsafe impl AsBytes for LibosMemoryRegionInitArgume=
nt {}
>  unsafe impl FromBytes for LibosMemoryRegionInitArgument {}
> =20
>  impl LibosMemoryRegionInitArgument {
> -    pub(crate) fn new<A: AsBytes + FromBytes>(
> +    pub(crate) fn new<'a, A: AsBytes + FromBytes + KnownSize + ?Sized>(
>          name: &'static str,
> -        obj: &CoherentAllocation<A>,
> -    ) -> Self {
> +        obj: &'a Coherent<A>,
> +    ) -> impl Init<Self> + 'a {
>          /// Generates the `ID8` identifier required for some GSP objects=
.
>          fn id8(name: &str) -> u64 {
>              let mut bytes =3D [0u8; core::mem::size_of::<u64>()];
> @@ -673,7 +676,8 @@ fn id8(name: &str) -> u64 {
>              u64::from_ne_bytes(bytes)
>          }
> =20
> -        Self(bindings::LibosMemoryRegionInitArgument {
> +        #[allow(non_snake_case)]
> +        let init_inner =3D init!(bindings::LibosMemoryRegionInitArgument=
 {
>              id8: id8(name),
>              pa: obj.dma_handle(),
>              size: num::usize_as_u64(obj.size()),
> @@ -683,7 +687,11 @@ fn id8(name: &str) -> u64 {
>              loc: num::u32_into_u8::<
>                  { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC=
_SYSMEM },
>              >(),
> -            ..Default::default()
> +            ..Zeroable::init_zeroed()
> +        });
> +
> +        init!(LibosMemoryRegionInitArgument {
> +            inner <- init_inner,
>          })
>      }
>  }
> @@ -862,15 +870,23 @@ unsafe impl FromBytes for GspMsgElement {}
> =20
>  /// Arguments for GSP startup.
>  #[repr(transparent)]
> -pub(crate) struct GspArgumentsCached(bindings::GSP_ARGUMENTS_CACHED);
> +#[derive(Zeroable)]
> +pub(crate) struct GspArgumentsCached {
> +    inner: bindings::GSP_ARGUMENTS_CACHED,
> +}
> =20
>  impl GspArgumentsCached {
>      /// Creates the arguments for starting the GSP up using `cmdq` as it=
s command queue.
> -    pub(crate) fn new(cmdq: &Cmdq) -> Self {
> -        Self(bindings::GSP_ARGUMENTS_CACHED {
> -            messageQueueInitArguments: MessageQueueInitArguments::new(cm=
dq).0,
> +    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
> +        #[allow(non_snake_case)]
> +        let init_inner =3D init!(bindings::GSP_ARGUMENTS_CACHED {
> +            messageQueueInitArguments <- MessageQueueInitArguments::new(=
cmdq),
>              bDmemStack: 1,
> -            ..Default::default()
> +            ..Zeroable::init_zeroed()
> +        });
> +
> +        init!(GspArgumentsCached {
> +            inner <- init_inner,
>          })
>      }
>  }
> @@ -882,11 +898,21 @@ unsafe impl AsBytes for GspArgumentsCached {}
>  /// must all be a multiple of GSP_PAGE_SIZE in size, so add padding to f=
orce it
>  /// to that size.
>  #[repr(C)]
> +#[derive(Zeroable)]
>  pub(crate) struct GspArgumentsPadded {
>      pub(crate) inner: GspArgumentsCached,
>      _padding: [u8; GSP_PAGE_SIZE - core::mem::size_of::<bindings::GSP_AR=
GUMENTS_CACHED>()],
>  }
> =20
> +impl GspArgumentsPadded {
> +    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
> +        init!(GspArgumentsPadded {
> +            inner <- GspArgumentsCached::new(cmdq),
> +            ..Zeroable::init_zeroed()
> +        })
> +    }
> +}
> +
>  // SAFETY: Padding is explicit and will not contain uninitialized data.
>  unsafe impl AsBytes for GspArgumentsPadded {}
> =20
> @@ -895,18 +921,18 @@ unsafe impl AsBytes for GspArgumentsPadded {}
>  unsafe impl FromBytes for GspArgumentsPadded {}
> =20
>  /// Init arguments for the message queue.
> -#[repr(transparent)]
> -struct MessageQueueInitArguments(bindings::MESSAGE_QUEUE_INIT_ARGUMENTS)=
;
> +type MessageQueueInitArguments =3D bindings::MESSAGE_QUEUE_INIT_ARGUMENT=
S;

Why is this typedef while the others new type? Because this one is not
`pub(crate)`?

Anyway, just a question.

Reviewed-by: Gary Guo <gary@garyguo.net>

> =20
>  impl MessageQueueInitArguments {
>      /// Creates a new init arguments structure for `cmdq`.
> -    fn new(cmdq: &Cmdq) -> Self {
> -        Self(bindings::MESSAGE_QUEUE_INIT_ARGUMENTS {
> +    #[allow(non_snake_case)]
> +    fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
> +        init!(MessageQueueInitArguments {
>              sharedMemPhysAddr: cmdq.dma_handle(),
>              pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES =
}>(),
>              cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
>              statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
> -            ..Default::default()
> +            ..Zeroable::init_zeroed()
>          })
>      }
>  }

