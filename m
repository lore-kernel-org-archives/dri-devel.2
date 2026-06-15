Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C949CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BB510E57A;
	Mon, 15 Jun 2026 17:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Epz7AXRV";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FE710E57A
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3DvXZkLE3STWb9H6On8yc0HyL/AWx2ZR1Lj9gd5k/WtuCyIegXSpraQKeMCaJJjjmYFT0zdGiVwuxLevs5rb6p09DaCYY10OTa1vVg2srMFB8XVn3qPyqFQV0zlgfpP5YMoAbyAkDkEFpwPRec6KEiDDWPUVI8NjCbLNN2rwADR2aV4UAurm+pqHB6GOvfuZbiRlJhqCUtqyRZ1IyaWKcih+H8TYhUU9OsJnpyife0xXiGwLIQoXvEk9iAJwstM+nO3whrT3vnqIiaBZYo40NMYq+AR1Ox2quE9k6bURg3GxZfvgGk5rwrEy6jTosncSjJWrzIQKTW8wvhVwwFE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbJHCGDDhwl7AGfjLX7h7IDOMS3dwlbk19rkot+ozFg=;
 b=jLXbOYJTaT6LfhNAUHcoKBpPa6el4QDOzg/whCS+DzSwq8WmcnYWQmvQqrFtigxBrqBbLrndvAb1qR8wdRG7ejfcqPB1gmiQ1+LgrOEiGyb6pvBIOXDjY8DPJYjJD130n1887sn4ZENii0T3asfGrTOglKa+jPKria1tVGwd5MoquLyoGGbENQjLsVRR2Xoqv6l0myuskVm+kuXSEvBIOy3z6NYQ1bvmFL/Gm9g/Fl16jhBxCz05HV/OVclDSk1cCdzz335AH8GUmVTquhg/MckF1n06ol5OoF2GyCWdoNQM7gHkZMpBEpdIcdoH69AAn34TqZYDBhwCVLQQHAy4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbJHCGDDhwl7AGfjLX7h7IDOMS3dwlbk19rkot+ozFg=;
 b=Epz7AXRVFjpemsonIh6c44QRBm7N1kiDAgwUubJQKDTX/zYKcFuXFYvxhLGWBX6I3ZCrreEg+LWQ1EX6yyl1Wt/fM+aPkr5K7Tnc7v6CEMYnuHeYzXl8/vcbK1Ek9Zwu2d0NCLsFeI4YnW9ZCtaeLUjZi1w3XbzQxArl9+rvFhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:161::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:16:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:16:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:16:27 +0100
Message-Id: <DJ9SKDFB5Z63.JPEV0D1Q60L@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 03/13] gpu: nova-core: fsp: try to enforce exclusive
 access to FSP channel
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3168:EE_
X-MS-Office365-Filtering-Correlation-Id: d41ffd82-66d1-4974-1dbf-08decb01d5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|10070799003|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wS+roRaGHyTYJZuN5ZDjaGFQpfruqiIVDQKvQwNQuO6ZCaMHOQTQu1tC6FsIOj0kdgmSnIpHJ1ButJKBFGQab+pcsztFBA8t2DAvq9elOhM2bS+TYJBwbZYuhekafl1i9ugUfiqoJyR8CjjCIpvTAoZaqSh/OWfpwc0QEubQ3+sDs+bhhBc0x9oxL9e0WURgVsyphBnQ8XcYoG7YmHjwumABTaGUxi12715bBs1nGAIpucxB9VxaG3qCJuWJZhUL5E2pRGOm5y8awSk0r58gIubyAdu3Dp/8Qvl3ddPtHBhXr7JZFWdsdw65Jp/ajQazfdHDmbsu1UQSnb9xLBtwU6A8Vm+oDb61tSWhh1QAL+GDieXnlSjE8SDpvpmDO2hi6j2X0fSak/UhqtviX3haaB6DjpZIbRF4+JJ8FGwFpQtWOiPBe5AmaokqbeiS3Il9DMK139V/Rinhtz08XUJuwFhu1qcieGZHzCBfv0GIhKDhZkfdkmQ6lsGM0HqdRavGk23IDJPhwewGuG8odq2uHgsOc6jVqb00t0/QNmNh+RNq/mwjc5nVNWBN1nZtZRXMyRUBuxK526h5DHGv0xy++LpNEXDlT4Ydd3lIR2JnCVDh0rkyQ+LiJMlKsQ0UyO+uzV0bnpQ5Yo4v+j4FJOqKXofWE3/6CvN/8+cSSUKVOfZiDsF4Hx7L3lHeJVG8m+8W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(10070799003)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJLUkQxY1hpY1lGUVZUTFU0c0x3VFl3cHhDQUhkVXVLblRqNkNBTkxJQnNh?=
 =?utf-8?B?R0lzR0dYNmxLcHd3Mmd1S2lmQUNlMzJwbUpiTWptY1JoZlBveUVralNuYUJN?=
 =?utf-8?B?UTRGcjZnMU1EMlR6TWR2ZklIYWFuL2RmejdSUjltRC9Uc1hQNFpvQTNLdEI1?=
 =?utf-8?B?UmtWekNXZlZobTcwRDhVQmYxZlVabW5vbGpMVVNabm1XM3d1SXZYYkRQdG5D?=
 =?utf-8?B?TVYzMjRkSTJaWjZjY1grRTFoWDJ5M2pLckE3eUk2WW84QjNjblZ1WmZ6dUlN?=
 =?utf-8?B?UVVvYmswdWsrakJpT1Y4eGZqOGdub3FMWEE4dmxiT2xkRzRabEg5YU9MSVV0?=
 =?utf-8?B?WkV6Vlg3N29PWjI0M3BUOU9hMkk3SmFNUlZrMUl5SGZPOHVURjAzT3pjclZB?=
 =?utf-8?B?NzFZVysyKzd5aXpBZ3RnVDh1Q0pFOVM5c3FlOGNlZVNsQktMK0d0dGZ3UUF3?=
 =?utf-8?B?Q25YVDVpa1lzYldUWHdkZ0Y3YTdmeUI1TS81Z2VlcHhnd2c5Ym1hbW80QWRD?=
 =?utf-8?B?cEpnRVhqelZzTDNLYzhma3JaYWhPbDdQWkV5OStIQ0h5VUlEc0hURWpSWnQ1?=
 =?utf-8?B?Znh1T1Y5S0VwajNqcThvTElVRXRNV1gySUNPclpQS0NjcWFSZjd3bWtxMDR6?=
 =?utf-8?B?L0RrRUFSaFFPS0NTVFAzSk9UNUtXVGFac2JSWlVKUTdxOUZwUjYvVzdnalVm?=
 =?utf-8?B?MjdCc0ZRTG96M2pzNU0weC95R2pQWFVqUkhBTkhFZjNkRWNOdkxPVmlwbDJ0?=
 =?utf-8?B?ZzFxUVU0SlhCZVR3UWdNVUNaMHFmZ2N1d2JBc0NjT2J0bWZIY1dPQVNLa2hs?=
 =?utf-8?B?MHorYnBpS096QnVFU0tQOXJIQXdLbTFVTlI4OG9GN0JPTUVZb3FLMDlKL0xm?=
 =?utf-8?B?QW1TYkUyc1Zzb05vWW5IUnlBaVgrMUhIWGtYQWM0d2dpRUViVWJXQlpKbU12?=
 =?utf-8?B?a3lKdDA5ODZoZHpEMFdkbHdNc2FVWjJUMkhJeTJ5a3FBejFhYlY0Qnh6YmdT?=
 =?utf-8?B?VkRxMnRBYVVvTjRrS0YzQmJ0YlZhM0RpdGZKQk42WXB3N2dXSHF3YlhkR2VL?=
 =?utf-8?B?TG9Gb1pZczFRTmY1V0l6MFZUTTliamp1cXNmYXlkbThIcFVKaU1OY001YWFv?=
 =?utf-8?B?dkM4c2ZsRVZGVmNlYURHY1ZxLzUvWmtTaXhlc2JCYXpaakN6Nm92d1lST0Rr?=
 =?utf-8?B?VTBJSXU1WnBOVkIxbHZGNzVSeVE1a2YzTnRnWWNreUx0YnU4NW5OVk1RVEdX?=
 =?utf-8?B?OWlQVFBzN0dSbFk1bUdDZHFwZ0VzOHlTbkoyZzN3WXRSNEh4M2tYL0VvQTVX?=
 =?utf-8?B?YTErZ1R4clhkckRsUTFxV3RRalZmZ1NWL0FZOGJhZmpicWxTMmwrZDNwMnVE?=
 =?utf-8?B?VzdKQzBjUnZGMVh0eDVWNzVlWkZTRWQzcStUaUNrMUFoVXpsRXZUZ1RuMHBN?=
 =?utf-8?B?NG1Ia1hDdit6aVI1TzN6SzRnb05aYVdEcGlwd2Jmc3owSEF1TTBQOU5YSEpZ?=
 =?utf-8?B?NzVNbnhvYVZCTzR1VGRoeStBUFkwQ0xRSEE3eEkyT3JhcUNQaVBMeStpQXFo?=
 =?utf-8?B?Z1VaYVVkSUlCLzF2WUhJWm9sTVVBOVhoNFBiSWpDWUtzOVBEbFVqZjhHdy9D?=
 =?utf-8?B?eTNwN2w3TzB4NVdQbHRiL1lOdmF4QXFjcEpvWDNEOXNlMUdCMnVNeHBWU0Jm?=
 =?utf-8?B?MnNnR1M0SDRMdXZVSFVMNGZ1bVVDTEVnanRiNHloUzFsUVdYNjdldFFidGVh?=
 =?utf-8?B?OFpmbGN0UFVCeTVFZzBpQ3JtYUFnZDh5cVRnaDU1RlZRVGJtV1NGSjVITVdU?=
 =?utf-8?B?Tzk2QnVMMHQ2bHZwM3F6ZTlHMStvQTd1Zyt1N0FmUXY0TDFvZ05KQlRxcWQ5?=
 =?utf-8?B?QnR5bFNsT244WWQ3NlNYTytLQVhSL2FkekFEUXd0UElXdjBzTy9ldy9vMzdp?=
 =?utf-8?B?dHZwdElpQlVYeUlCVmZzb1hndEo0NGZoN2dZQmNnd0JiMHNwQWIzMDcvbVNw?=
 =?utf-8?B?N3NOMlo3NTdMdUZ1UExyUEI4S1FoQnRzbGY2Q0x3NVBISDZiS3Y2T2tjdnVm?=
 =?utf-8?B?bEZsZmJQcFJBVm1SUk52WWhEVGwzdXR0bEM5T29qUml0NU9xRmZSMEl6WUtV?=
 =?utf-8?B?YXA0eDQ3ZzI2M3AzOTlzUVlpMFpNUmYxSVJlZlVFSDZ3Sit1RmlYdUhwdi8x?=
 =?utf-8?B?aDZTdjZJdkNZMjVNaGYxSjUrYnY0YStIM2dJbzBMN3ZmZWR6dlNJMTNNTklv?=
 =?utf-8?B?MGoveWw5WWo2Q0RFZjZKc3ArZVdnS04yQW1nL29odkJtcnZtRWhGZ25UalZJ?=
 =?utf-8?B?SXNvRk9McWhtenY1dEJDYlg0SThaZEZPbEh5eUFRUjhEZmZISWVLdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ffd82-66d1-4974-1dbf-08decb01d5fa
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:16:27.9146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iUPfmSguTv0hyn0AzebsZy0mgxI/v8SLnDrf6YUsGoJmBEYtsBHfCVyxCxbneOVSBsIwP326K2hGxR0+VhedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3168
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

On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> Currently, `send_msg` assumes that the channel to FSP is free to write
> into. But, it might not be. Both the kernel driver and GSP communicate
> with FSP. The way they should attempt to keep exclusive access to this
> channel to FSP is by making sure they don't try to start writing if
> there's pending data until the full round trip has finished.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/=
falcon/fsp.rs
> index 21eaa8e261ce..cdb476894e1a 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> @@ -125,6 +125,26 @@ fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
>          }
>      }
> =20
> +    /// Both the kernel driver and GSP talk to FSP. Try to ensure exclus=
ive access to the FSP is
> +    /// enforced by making sure there is not a pending message already s=
ent to FSP, and that there
> +    /// is no pending message from FSP to be read.
> +    fn wait_until_ready(&mut self, bar: Bar0<'_>) -> Result {
> +        read_poll_timeout(
> +            || {
> +                let qhead =3D bar.read(regs::NV_PFSP_QUEUE_HEAD::at(0)).=
address();
> +                let qtail =3D bar.read(regs::NV_PFSP_QUEUE_TAIL::at(0)).=
address();
> +                let mhead =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).v=
al();
> +                let mtail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).v=
al();

How does this prevent race between kernel and GSP when initiating FSP
communcation?

Best,
Gary

> +
> +                Ok(qhead =3D=3D qtail && mhead =3D=3D mtail)
> +            },
> +            |&ready| ready,
> +            Delta::from_millis(10),
> +            Delta::from_millis(FSP_MSG_TIMEOUT_MS),
> +        )?;
> +        Ok(())
> +    }
> +
>      /// Writes `packet` to FSP EMEM and updates the queue pointers to no=
tify FSP.
>      ///
>      /// Returns `EINVAL` if `packet` is empty or its length is not 4-byt=
e aligned.
> @@ -133,6 +153,9 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, pack=
et: &[u8]) -> Result {
>              return Err(EINVAL);
>          }
> =20
> +        // Try to make sure we have exclusive access to the FSP at this =
point.
> +        self.wait_until_ready(bar)?;
> +
>          self.write_emem(bar, packet)?;
> =20
>          // Update queue pointers. TAIL points at the last DWORD written.


