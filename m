Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F98CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B97610EDD7;
	Mon,  5 Oct 2026 15:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vz2PI+wH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C73310EA19;
 Mon,  5 Oct 2026 15:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHQm9g3k3CBLkmx+waaVxNBvX9BZbu4Zyn1EZdx7E4O6EPOt1yQay4S8v4kB3oDEsAGb5ODlnxxV2MWaXxQj3u8iY7+CHn1S03s726rXh3h6uOuEj+7Gw7cmZfGa/4tDwiZHxEKLlGZYNnpAjr0SpEvnR0v0BFzQuwOpUy/HYsuMWG3L2cvXPLLGf8BOXgZ8UcaMDcThPFTZ6w4Dou1HZ6ACD0DZFGwTg7HIcpvIfGZhd3OQ6JrQv3pu3R+7Ogkrb1qTMUFdkYtdynBG8REXlHcTJQSm9Ef6hybmpHVULr6Z86tQnBSpNKlXT7MjlY9wZNcTjGFu1hfMlcSskT8vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIerh1ks4VSxj7ztC+tRpaOAzKcuiY9PlKyij5SROX8=;
 b=U7T2YWEjZR1xTYg5l1DDRPOJF88pcmdEIFG8/m4Vl1u2stunSPaPwbnVjm+Z5VtvSy9LkPO/tun3rI51TK8heJGNyofaTxwPMfORg0W060ad+CaAUgsHHnz+p2KoTDirjuVJg3lCPbdAtbzvsHCZathO2CdGEphaIqpzYfG9QUJH6Y0DnRjlSXewtENW97L87KK8sJrW6doIyFqJPnIjB/TfYWXUm52E8P3ECjy0b3z9dzh/pMfDZxb9DsIDNhPnV+coytieWX988H7BiiyvzMlIvDRtRU1wbsjs1kpzD0JbEJPgHtSqdDk9JhAoZy+ca4YJahJ+xkkGbXK3z1kzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIerh1ks4VSxj7ztC+tRpaOAzKcuiY9PlKyij5SROX8=;
 b=Vz2PI+wHosYN4Ru544kcUf59m5NfdXyuvSd0qPhirOooF1JqHUsRGrY6vn32/F6zo8RjZ6qmlbcUoxJ6NmUjSvGxf4shYwGx56MwwwlIHfzsgc5bfLdR2MZUnJF9pPrOswWBjha2KTHS33AMpz+Ri4jA5LdSNlz32unm1M0d95c=
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 15:53:54 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 15:53:54 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Adrian Betschart <adrian.betschart@cinemaone.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Don't replace a sink mode that shares
 the native totals
Thread-Topic: [PATCH] drm/amd/display: Don't replace a sink mode that shares
 the native totals
Thread-Index: AQHdTO0nixdP7a5xwkWsp/w6k5FgQLbvKQ8g
Date: Mon, 5 Oct 2026 15:53:54 +0000
Message-ID: <DSWPR12MB999127197E635763213D5D3FF089962@DSWPR12MB999127.namprd12.prod.outlook.com>
References: <20260925074829.92079-1-adrian.betschart@cinemaone.ch>
In-Reply-To: <20260925074829.92079-1-adrian.betschart@cinemaone.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-05T15:52:06.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR12MB999127:EE_|SN7PR12MB6743:EE_
x-ms-office365-filtering-correlation-id: 3fee4441-638d-47ef-dca4-08df22f8dba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Qa+l3b43p7oRbA/pUl7EQcbEPvUuAb+n9lFcRcm84XXolw6RsbahWqBk8Ew7AIpQgTmHT9qp5H+q17QZ3Xk8EAjYbIY+xM/dYxRe9XllREKyKEOXQRz0I3RKFuyEB3eNh5qBztZAs0+Ho1Y+cZWLIVGO37KPsaiUCUV1PZMIyKPNTqeWk/owFHazOQl3Y1iIFzKz9Hf/wMuiuXODjWrwzNMkHSDeaur+IjTeX5ohyPyjz2FeuqHDyfiJbGEvE+9Bp+qnvk/kLm4ukPFbtvLCp5GSmuzvyr2uJFjOy26YeAVePQKuK89pvbHullb1xmkdFsR7giEL8fgqylW9Zh6eRt4z4rNqDuNXwcAeDXER0DOdOG0o3Y5pMO5adSHgTCLeYOwIvkketsmLSuoYvoBeipOmb1/HVHHZVMbiiW9DsZLAfGlmW2XtPjI05YJTYasjPTMp93bsSHmKVf+WNV3PGv7ljuvmFSTulP+WFFxydyBZrohIGSybvtDREG8Fp40J62UbDdtamxavAEMHNJE+UBgNr9+RH3V6NICVZ1+2QDUWU2oOzRwpwJfiGDUk0VWjZ/c5uWolZ8iC5D/tRDM9YDZNhA6i8DtHp9ppLqvIn1+SSknqwhAnCiAkVIoT+39zT4ve3uafXFMz7MMDP0JEx/22zfVD8L527Mg5wrtofoYt69t3GJMmtNRWK6UXR+SXwkNZfysAvgiA+iOgRh0v7+81Z27obkkRRW9/yq0L7VA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSWPR12MB999127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJrnGI1IE3aRc6A+tPRzWQKVYIuGrYbjwiRsigOu2MvxRXu5rwQNktHau4Oq?=
 =?us-ascii?Q?PpZpZ+Z5oAyHhwpNs/9Mtw1MmgQjob84dtdwDq2J7QUzHzkk4BDBCuqGoPph?=
 =?us-ascii?Q?rlpy1xbI1qSwEbue0sYO6RKfHSmM3iagvX1TQyPeCIRPgvT9Ap8i/YWEo6r6?=
 =?us-ascii?Q?SqhVG5WobOZ/dBIBS5Ctz/UlvBU65KxCIyHhAAJIfpYZ/WN2I3ulY6p1zKJj?=
 =?us-ascii?Q?vkR7nD/blwmr4WotlFLxqVzbtgLIZDpbGfpmveroSz4JwS2wzsk9O//65kkJ?=
 =?us-ascii?Q?GRkbuIowqL0RRVEHFdvq1qIhXILWYwsrKuO+mgwBNrJvHPev3xPX/Bdh8Hky?=
 =?us-ascii?Q?Yb8Yj6yIHqc3jYAPkVBTEsaVPHkEGD38GLprEXOuk25S5CGvFbfJ1AQfkyDr?=
 =?us-ascii?Q?TdPHwPhDtCuHRiUriDUlFv9qQQpet5oWdFx9EhjfbXmJeo44HGvJGbbo+GTX?=
 =?us-ascii?Q?3TtbWy6nIVNOc+LCXXXFXMC96e5oUizveNFlOf1RnYom5hXbi8JGbVyZVj1u?=
 =?us-ascii?Q?jpV3s6MDSBt+hxXpogLFpjKhfnLjFJP/M8njHsdoO3tKGD19BPT8C7NKe426?=
 =?us-ascii?Q?zrHc9hcRJf7TeXY3o6Qv+wuyruQDYnroRVzG/B4bDihyREyXVqRVVEy3eD6h?=
 =?us-ascii?Q?gQcyXkrMlif69MJhg9SWuGBy1Q41Hpsj2ORko6iIHzVJNPKU6R8QMkodpBO+?=
 =?us-ascii?Q?D3IBfSlo5CprDC/AhQ59Jw9C901JcJULixKKGI8GAtmoUgawgToaT7JFjI4g?=
 =?us-ascii?Q?4wMgbmfxY/Xt805ugyuF55Qupgm8DaEYcRyyYo/nj1y3XwulDlwPkhwYHdKO?=
 =?us-ascii?Q?Tu6Ngl0LgB6eXH+8iqFxT0SDN5edrh04Ycpz5bZ6Tk7MZqyK24FHdNRoqgnk?=
 =?us-ascii?Q?09bjXh73Gk2bmdLaG4B5iOa/dYlgvGoC8i+wzDwebsMgQ0U5PDayPFMBGkcQ?=
 =?us-ascii?Q?QVmYPSDiI3Q6jekKske31gRi8Nnr5k1AY2xh2yyCPG8VF7YulZgg80pBiUxc?=
 =?us-ascii?Q?rRVAcJ6epgQ+erU8/1XQC70Vp8tk/IJyEMoFnBWFadeaOZuCe7iHYojI6nh2?=
 =?us-ascii?Q?+/InzP1KkhHg0Z7fvXaGrtKz8VLwyEdZ7dm9XzmRj9/XA3MM+Po/dynMl1aW?=
 =?us-ascii?Q?yKFdG4mwuCyQ/YQsCjkqbTQlSUNiRMpFTzudpaUctxsTjradT1v2PWXH9Lfk?=
 =?us-ascii?Q?IBsaEtZM1cc4Ljhdn7Pf52txx3X738tAYt+CKQ5G7NBcKE8PFesZQDK3cbBs?=
 =?us-ascii?Q?nK+vBmCo3XmVw5PYBREaTACuy5mdiVW6hXEK92KYts1lYbs22qp7fOOGeUFJ?=
 =?us-ascii?Q?Doa3kEaMuhGIXyKHXUKZWhvz/BjLYdbFtgzyU6xRVTRz3d0eHvo2gb/rGq+U?=
 =?us-ascii?Q?2y3ZiDeshZggRTKuf9/WsvPwWzYFEnLB8Trt0cXIuRZfWvfGJmvAvAdYddBV?=
 =?us-ascii?Q?SidhX4PcgKl1IoqJFajrGHoADa6l9c3xNMziNwuEzoCsHSoVepaZaURuLbuA?=
 =?us-ascii?Q?/K6p7qYPfdL6fPuiEBgl0wRWXWIdxY+9JBWXk54xOpgdNgmVTK3WHjJ7mXlT?=
 =?us-ascii?Q?IW55HEWmFuS3fskQlPm0YI9JNPIhgVjoPy1fbgzxtHAHBpkoAQlD4B6fxvzT?=
 =?us-ascii?Q?z1GDfTrDEXmyX4x6XoLko+wbPPmdGf8S7GVmgmwoum5blvdZtlGXCKCIQqgY?=
 =?us-ascii?Q?tNJWi7lygg/saVuX9EQRaRgk77mZ2UWHlmWeINwBtcwfDXAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fee4441-638d-47ef-dca4-08df22f8dba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:53:54.1706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiWfdWREwT4FvjLYhSl0rtBVhJzYiCxZCKjKbxsX4bol/9cZTjU6wv4LjGnhezR0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

Public

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Adrian
> Betschart
> Sent: Friday, September 25, 2026 3:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vett=
er
> <simona@ffwll.ch>; dri-devel@lists.freedesktop.org; linux-kernel@vger.ker=
nel.org
> Subject: [PATCH] drm/amd/display: Don't replace a sink mode that shares t=
he
> native totals
>
> decide_crtc_timing_for_drm_display_mode() copies the native mode's CRTC t=
iming
> into the requested mode when clock, htotal and vtotal match.
> That is meant for the modes amdgpu inserts itself:
> amdgpu_dm_create_common_mode() duplicates the native mode and changes onl=
y
> hdisplay and vdisplay, so those are sent with the native timing and scale=
d.
>
> A sink can also offer a real mode with the same clock and totals as its n=
ative mode.
> CTA-861 VIC 102 (4096x2160@60) and VIC 97
> (3840x2160@60) both use 594 MHz and 4400x2250. With 3840x2160@60 as the
> preferred mode, a 4096x2160@60 request goes out with the 3840x2160 timing=
 and
> the framebuffer scaled into it (dst 3840x2025 at y=3D67), while the AVI I=
nfoFrame still
> carries VIC 102. A JVC projector then reports 3840x2160 and shows a corru=
pted
> right edge. 4096x2160@24, whose totals differ, is sent and displayed corr=
ectly.
>
> Inserted modes keep the native sync positions; a real mode with its own a=
ctive
> width does not. Compare those too, so only inserted modes are patched.
>
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
> Assisted-by: Claude Code:claude-opus-5-5
> ---
> Tested on an RX 7600 (7.2.4 backport) with a JVC projector behind an HDFu=
ry
> VRROOM: 4096x2160@60 now arrives as 4096x2160 with a clean right edge;
> 3840x2160@60 and 7680x4320@60 are unchanged. KUnit
> amdgpu_dm_connector*: 360/360.
>
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |  7 +++-
>  .../tests/amdgpu_dm_connector_test.c          | 42 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 7ebf7216b499..7db85bcebecd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -996,10 +996,15 @@ decide_crtc_timing_for_drm_display_mode(struct
> drm_display_mode *drm_mode,
>                                       const struct drm_display_mode *nati=
ve_mode,
>                                       bool scale_enabled)
>  {
> +     /* Inserted modes copy the native sync; a sink mode with equal tota=
ls
> +may not */
>       if (scale_enabled || (
>           native_mode->clock =3D=3D drm_mode->clock &&
>           native_mode->htotal =3D=3D drm_mode->htotal &&
> -         native_mode->vtotal =3D=3D drm_mode->vtotal)) {
> +         native_mode->vtotal =3D=3D drm_mode->vtotal &&
> +         native_mode->hsync_start =3D=3D drm_mode->hsync_start &&
> +         native_mode->hsync_end =3D=3D drm_mode->hsync_end &&
> +         native_mode->vsync_start =3D=3D drm_mode->vsync_start &&
> +         native_mode->vsync_end =3D=3D drm_mode->vsync_end)) {
>               if (native_mode->crtc_clock)
>                       copy_crtc_timing_for_drm_display_mode(native_mode,
> drm_mode);
>       } else {
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index bd55d943e4e5..04e0afd7aa71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_te
> +++ st.c
> @@ -1468,6 +1468,46 @@ static void
> dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
>       KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);  }
>
> +static void dm_test_decide_crtc_timing_sink_mode_same_totals(struct
> +kunit *test) {
> +     struct drm_display_mode native_mode =3D {
> +             DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000,
> 3840, 4016, 4104,
> +                      4400, 0, 2160, 2168, 2178, 2250, 0,
> +                      DRM_MODE_FLAG_PHSYNC |
> DRM_MODE_FLAG_PVSYNC) };
> +     struct drm_display_mode drm_mode =3D {
> +             DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 594000,
> 4096, 4184, 4272,
> +                      4400, 0, 2160, 2168, 2178, 2250, 0,
> +                      DRM_MODE_FLAG_PHSYNC |
> DRM_MODE_FLAG_PVSYNC) };
> +
> +     drm_mode_set_crtcinfo(&native_mode, 0);
> +     drm_mode_set_crtcinfo(&drm_mode, 0);
> +
> +     decide_crtc_timing_for_drm_display_mode(&drm_mode, &native_mode,
> +false);
> +
> +     KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 4096);
> +     KUNIT_EXPECT_EQ(test, drm_mode.crtc_hsync_start, 4184); }
> +
> +static void dm_test_decide_crtc_timing_inserted_mode(struct kunit
> +*test) {
> +     struct drm_display_mode native_mode =3D {
> +             DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000,
> 3840, 4016, 4104,
> +                      4400, 0, 2160, 2168, 2178, 2250, 0,
> +                      DRM_MODE_FLAG_PHSYNC |
> DRM_MODE_FLAG_PVSYNC) };
> +     struct drm_display_mode drm_mode;
> +
> +     drm_mode_set_crtcinfo(&native_mode, 0);
> +     drm_mode =3D native_mode;
> +     drm_mode.hdisplay =3D 1920;
> +     drm_mode.vdisplay =3D 1080;
> +     drm_mode_set_crtcinfo(&drm_mode, 0);
> +
> +     decide_crtc_timing_for_drm_display_mode(&drm_mode, &native_mode,
> +false);
> +
> +     KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 3840);
> +     KUNIT_EXPECT_EQ(test, drm_mode.crtc_vdisplay, 2160); }
> +
>  /* Tests for amdgpu_dm_connector_funcs_reset() */
>
>  static const struct drm_connector_funcs dm_test_connector_funcs =3D { @@=
 -
> 10342,6 +10382,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] =
=3D {
>       KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
>       KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
>       KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
> +     KUNIT_CASE(dm_test_decide_crtc_timing_sink_mode_same_totals),
> +     KUNIT_CASE(dm_test_decide_crtc_timing_inserted_mode),
>       /* amdgpu_dm_connector_funcs_reset */
>       KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
>       KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),
> --
> 2.55.0

