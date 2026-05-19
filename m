Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9811BCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 01:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DAE010E031;
	Tue, 19 May 2026 01:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AACKBTWO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF2A10E031
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkcw/zBtAIA+7ixcImhl9ESwJvjPGDh2HKXlQmuN7r0gUEtSUMLCdHfdbgwdz8NnbGDx2DuByQCTLIio27cA1tocGIQHiIgahpLch9iPtNqv+0efO4zx+O5yJhAOu5adJsOdg+d9/7u/sq1UXYJFovEX+55RazcdlquSssm6ZhjNMUP8o/WD9r8XFXZlueL0UpZLr7ufgTC7J/zfQ1OkDm1QCaQvIEAS4HJpwi9MWHlS1cxz2OUt6lI/pHc6u1fFrYuSrxIpLC3S6VVE8deDWdTthe1LoGYJ06v0mlqH/prkRUpWovbH4+UJn6DjVFMnNyfbjw5nYireXX21PcQHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DLysU/73U0C/xpaIaQ8BWjopUfg8hSuJv9yyhhRoF4=;
 b=WP+m2H/ArKdukuBwWzswmohnaZwTUstWy/XQ+7HixTR2dxmMqUB3hd0HYk9IZDNiJPazLnw1ipD+spMs3gvrz+YWOGYvEFvJubowDp5TpTaSGDwyA0GFRJ1fUp6vEKcrTzS0xhxPO75X6mwLDUUsJMd/wN0I8HyqlMDpDizjV/6DbQ3A/IQoPO7muHwlf6z0lHdDf2rDeMogl7GBuymuk5Cvva/cuTjBfKHHTV7qyCN61Q2bNUQIYqh8EYsWUxHKsC6gB9+jKxAwrfp0z72T7qrvX7yldBMUYC9V6VZK99QnMI9dTknitUzdENCaBj5BTPLULvntOETCJMyqfm3YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DLysU/73U0C/xpaIaQ8BWjopUfg8hSuJv9yyhhRoF4=;
 b=AACKBTWO0eZiGegAsdOfsCVi9st1x52oITfxX8FrVqxDNv/zTC49uaPokXB5imDzeoIji0VowE4C0dNo+ALlm5n7x56HUoFw7l85IDhGibmcXLYARH6096nCCVWdQEAmyFJfMHETy28iaar9Nt9qFDABLvU7ifUlKG//xHcCFev/VawZLK6TtggtDWVASpzFr/GA6EPg7ieRcSnWQ2Qp67nktNU/i3P4Yt9ulXKlOiweeZPqb1WyYTiKykA5Lmc7MkAqmSdzsQOlilOTSEEMmVmAUD+ZCX+7brFAMW5gzziT8IItseuaWJ+ghhkq/JmOnjHI+pN5IPLV+zyl4blYyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 01:32:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 01:32:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 10:32:16 +0900
Message-Id: <DIM9KQPZS039.26VD4KQI0TZZN@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] gpu: nova-core: gsp: move chipset-specific parts
 of the boot process into a HAL
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
 <20260515-nova-unload-v5-6-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-6-c4d6250ad160@nvidia.com>
X-ClientProxiedBy: TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::8) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b04208-08f1-499a-23b8-08deb54677e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|11063799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0ft4h3B/GIr1WLG6HHYzQIDjaA5yKncVgnfXqkw6K6bvFV7AtBYOwhyuJ4tSRZl4+vOPHejjRUIeSikLvOfHnyIIXfeV7QTg6ck6SEXbi1Cf3ICNszR6gYTjUbKml876NUVjz9joJL6Nnfwhg2i8ft228WjFK09r7TErNy5l6xP30X2GRV1v85yZueZ7TAV64//U2VpVFUkMuJb7G7sDN06F4psTR5tlPNJ9XAcycnHQx4d1oD/ZNH/UTjUCt5selJ+0zzDcpDgBhG6y+jHmuVt7yJSOqW6+c3RveDCr57qT8zgf9FTch3hDgQlktL5EeYM7Gv0zZZHncv4pAYSdlx6D0DTUszt6DKBty6gHPr4s8+j5Ry8t9dSkkdVF0ADKSb2DaChlL5O/rkcCpWhq7wMVIMhqApIMV3+wuokt3+40FXnlN3gYvPfegh/4MUecmxEvmMJLZb+qkLaGgKJya59uSO41W+WEjrrfJiyRxwmEkdJ2njrDxeGl0jROHMcV9jJFaydtSyn6cuC3Gm3AhOvugCfTZ4g4KDyjwto1zhKjdxOM1U9z6S1gEeWtR7YrxCUsdpceMrChVMWEGkedhsFkYQD0W8V+FCkSxJUmVIBBO3VGOuYUEgTpLsr+FotnvoFYmRvEuSyEkH8az1qte7xJxH9iVS7BWNCVp+AV72DCq9EdNSLV5Rk3bzWwL4D4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2tKRmFkYldxYUFiN20yZzg5R1ZDcTlmYU11MFhORmxRZFR5U0FkaUVNTUZh?=
 =?utf-8?B?SjNvcFZqSS9Pa1JpVE5jL3FKTVpxWlpLcjQrQnpNWnd1NFBnVTFkTEVIK0FG?=
 =?utf-8?B?R1kveGNHaTg3UUVXNDQzcytOWTlkZU5oWXpBckl5YWVDQVZCdDJ0R1dISjAv?=
 =?utf-8?B?SzB5bzNNOStQRmxPd0xjSDljbXhOMEJiYkJROTRDeURvMFhpeTNhTkpWVjZ4?=
 =?utf-8?B?YXUveUNJcEZLQmYxMGZuZzZPSDIvdStXdG9ia0Z6VzVGc1B4cHdnOGU5Z0lT?=
 =?utf-8?B?cXhhYkF1OUhCeEtMRnFqYXVSM1lLd1J1alVLZzJpdmxxZGU0SjZrMFpCb2dV?=
 =?utf-8?B?ODNtL1VzU0o0QUZaUGYyelUyck1pTzlrQVhoZU9JVS9hT25NRksrbnpPWjY3?=
 =?utf-8?B?ek5VSFFUY3c1S21GY2EwRlgvYThza3I2ZXkwZnVVRlBvQWhpRlEzTVUzSGdj?=
 =?utf-8?B?d3lsMElUeUtwSS9GKzFWbG9YczR2SWxBL0NnYXoxMVJjYjNhOFBHdmlPNjZm?=
 =?utf-8?B?SnBXd1Mya0k4eE0rZlFMS2Y2NTI4WXJ4WTVEZUU0Vncrb3BsUVloS2JvRVVW?=
 =?utf-8?B?bmRLVzcxdk54czl4OTYraDNaZlQvUlU2YXB0cDFQZnA0VU12clE3bU9tR29Q?=
 =?utf-8?B?UnJVS0V4R0Jyc0haMWNKZWQ0OUZqVjVXVzRrTHlrNlIvVWlqTTBkRzhaaENS?=
 =?utf-8?B?ZExHM1RZTENXMkx2aXVOMXVJQVVTWHJUVER2WXpLaE5iK1NjZ3FPaE1aNWRN?=
 =?utf-8?B?WUxGc0hiM3NUUzJrSHJld2xqSHU1U3c5ejUvWmRQeFBxQ0dMYnFtVnBhWHNv?=
 =?utf-8?B?ckZ6c2JMOE4xMHJGRDVycHRyR0Fua1JDbW5hcnEyVWY2YkZreFZrTkJocVIw?=
 =?utf-8?B?eEgycmlmNThoMDFqMkFRc2FmeFp6Y0ozdmg0OUpxZzM5Nk9DbThMcFNCQU42?=
 =?utf-8?B?OWtwdXBNRWN6TG8rRC8rWXpQdVd2b0QreEgrZHBnTDA5ZkRWSmE3THZIQ3hr?=
 =?utf-8?B?UFR1RjN2OHFPcStUTzRqWlA1bnloMmttUEFkZjhJOExXOFp2bnNhaktlNkFn?=
 =?utf-8?B?dGZQR1FMaVQ1SEpNZkVaOVF6TVBEcW54YlI1Y1RKdURNVHp0RDVMRWl3d0t3?=
 =?utf-8?B?MHNEenZnNnB6V1pRUlliSzNZb0x1Ky9LQjVJVG5nd1lIMFFJcHpVRmFmZytr?=
 =?utf-8?B?cWxRaVpiQjdNQTk0V3VOYWw1bnFkVExwazJWNThvS0lYSGRrRitCbmRpTlR5?=
 =?utf-8?B?dDZpQ3NOR2RIcmd2UjRPTndKb3VBekdaTzlweEtCS0ZMYWswblhCRFN5cXh2?=
 =?utf-8?B?WXd0YUVOL0RQcE9mb0l5cVYvbGdKT29OY2JQdGs5VGpGLzRocitLVUc0WTNi?=
 =?utf-8?B?Q3NDYUtqN0d2ZXRmSUpEVFZFOUtWb3hyZGlFZmVNTkR5WlNtby9odlBaYUoz?=
 =?utf-8?B?b1hmelRETkNBVEhPWlNQeU1RVk44RlhVYjF4MkR2dXdNR3ZaT3pWWHF2Mmlk?=
 =?utf-8?B?TWtyU0tjcnFtY3BwbklTRzFyRldheXRvdUFWT1NKb3hIbUF4KzlvOE91c202?=
 =?utf-8?B?cGtNaGVjSDdsR0JiZVZ0bERQU1pKV0R5dHhTTGp5QVVJK3NobUs2WHZlakdu?=
 =?utf-8?B?VlNaclMyNk8yMGdId0xNOFV1RmRHVnhrVXpZME40YlBHdzVDUGZqSEowUUpT?=
 =?utf-8?B?ZG1tYm91TVFsZC90dzVOWlMvZTBQYUpXUVNYMktyRXMzbk1GZDVHR2Fkd0VQ?=
 =?utf-8?B?RDVwakFPV1ZRdGI3UTAzeVQ4ZWVPT0djOXpsazdSMXNzVmhmOWovbEw1cmli?=
 =?utf-8?B?a2dLaWxIWitEVjZ4WXZvVXNNTjZaaUd5cXhQUUxNalVqN0pEcEppQmZXSDJo?=
 =?utf-8?B?Y3d4RVBOT1hxcm9UY1U3ZFZvSlNvclNSdUVucmh5ZTRQK3R1UGxsTjc3YVVU?=
 =?utf-8?B?NVdkdzVIMVkxcy9qOG4yOGQ0Rm5DOWtNbXdlNFF3bHcxeU5jS1ZlSkV1TVhG?=
 =?utf-8?B?UUVWOHByQkI3R3kxcTlEd1E5d3Yvcjh4SnNxYU90M2hTaCt6cmVySk02Ulkr?=
 =?utf-8?B?ZnR0OWxiZXkzZ21uSUtuMzhoWnlQcDBRRjFXdS9BWGlrakVWdWhwZ2ZsbnRU?=
 =?utf-8?B?Nk14N1VtOWQybmt2OXh1WGNXWmNUUkYvU1JodFhGcSt4V0lOZ0xObWthbWU5?=
 =?utf-8?B?SGxZcWlyMmsyK3dzeFNlSStPaWdpMmo2ZVhXT2xGRlkySGpVUzFZYTZHTjNi?=
 =?utf-8?B?TVV5am9KY005Mks2cllNeGVUNjlSNkk0QzZ2ZDRvWlFxdk1SUFRyV2RKQUVR?=
 =?utf-8?B?UFFlNzltV1A4UWpSSnpHV1RzV2I1bzF3dkYwd29ua2VTYVBxaTZHRGoyV3Rl?=
 =?utf-8?Q?DOMwCEvJI12y31R9zTFPy55aqTlHZOaHjT/PiAPaW23C4?=
X-MS-Exchange-AntiSpam-MessageData-1: UsFYg8NdIBBxQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b04208-08f1-499a-23b8-08deb54677e5
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 01:32:20.7916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FqYcu3ASPjgfdTiZ5pnoXWUKOD+AQIlms+LFlCFWDHTp6RNTioxS24p34h3lN9HOrer5Ij5h6CMj5YAVNnxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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

On Fri May 15, 2026 at 3:12 PM JST, Alexandre Courbot wrote:
> Booting the GSP is done differently depending on the architecture. Move
> the parts that are chipset-specific under a HAL.
>
> This does not change much at the moment, since the differences between
> Turing and Ampere are rather benign, but will become critical to
> properly support the FSP boot process used by Hopper and Blackwell.
>
> The Hopper/Blackwell support is not merged yet, so their HAL is a stub
> for now.
>
> This patch is intended to be a mechanical code extraction with no
> behavioral changes.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---


> +/// Load and run the booter firmware.
> +fn run_booter(
> +    dev: &device::Device<device::Bound>,
> +    bar: &Bar0,
> +    chipset: Chipset,
> +    sec2_falcon: &Falcon<Sec2>,
> +    wpr_meta: &Coherent<GspFwWprMeta>,
> +) -> Result {
> +    BooterFirmware::new(
> +        dev,
> +        BooterKind::Loader,
> +        chipset,
> +        FIRMWARE_VERSION,
> +        sec2_falcon,
> +        bar,
> +    )?
> +    .run(dev, bar, sec2_falcon, wpr_meta)
> +}

nit: This method mostly just forwards arguments, it feels a bit odd to
split this, but not e.g. GspSequencer::run() below. IMO you can just do
this inline. I see you are just moving code though, so no worries.

> +
> +struct Tu102;
> +
> +impl GspHal for Tu102 {
> +    fn boot(
> +        &self,
> +        gsp: Pin<&mut Gsp>,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        chipset: Chipset,
> +        fb_layout: &FbLayout,
> +        wpr_meta: &Coherent<GspFwWprMeta>,
> +        gsp_falcon: &Falcon<GspEngine>,
> +        sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result {
> +        let bios =3D Vbios::new(dev, bar)?;
> +
> +        // FWSEC-FRTS is not executed on chips where the FRTS region siz=
e is 0 (e.g. GA100).
> +        if !fb_layout.frts.is_empty() {
> +            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layo=
ut)?;
> +        }
> +
> +        gsp_falcon.reset(bar)?;
> +        let libos_handle =3D gsp.libos.dma_handle();
> +        let (mbox0, mbox1) =3D gsp_falcon.boot(
> +            bar,
> +            Some(libos_handle as u32),
> +            Some((libos_handle >> 32) as u32),
> +        )?;
> +        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
> +
> +        dev_dbg!(
> +            dev,
> +            "Using SEC2 to load and run the booter_load firmware...\n"
> +        );
> +
> +        run_booter(dev, bar, chipset, sec2_falcon, wpr_meta)?;
> +
> +        Ok(())
> +    }
> +
> +    fn post_boot(
> +        &self,
> +        gsp: Pin<&mut Gsp>,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        gsp_fw: &GspFirmware,
> +        gsp_falcon: &Falcon<GspEngine>,
> +        sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result {
> +        // Create and run the GSP sequencer.
> +        let seq_params =3D GspSequencerParams {
> +            bootloader_app_version: gsp_fw.bootloader.app_version,
> +            libos_dma_handle: gsp.libos.dma_handle(),
> +            gsp_falcon,
> +            sec2_falcon,
> +            dev: dev.into(),
> +            bar,
> +        };
> +        GspSequencer::run(&gsp.cmdq, seq_params)?;
> +
> +        Ok(())
> +    }
> +}
> +
> +const TU102: Tu102 =3D Tu102;
> +pub(super) const TU102_HAL: &dyn GspHal =3D &TU102;

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

