Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE87C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B97510F02F;
	Wed, 23 Sep 2026 13:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LPM8FXeu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95A710F002;
 Wed, 23 Sep 2026 13:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbnHkB2H+D1c+6ulpga6m7LDcKZtjseeZ2De0J0s6RD81iB1ZXO6/OeqNqb9jX3GGY1Wj9a9qlhJuUHl7riRRP7iXlaXDJGPC9I9KEG00eRKaDjCdWEJ7Dg2VY038nKAHNqLtkWDvJZ2iI1V7z1U194KWENpbNaKXx0Vwc1I7fiY/v1OiMpAmVo5IrRCPHir5Mic/mVnTjLkKB/VPLhO3J1vF0nLqVQ66NvKJ3S1JGf9B8wd2+dt3Db2K4ZsJCJb37KvB3fXuqoZxdFF/LeMt61g9HT+j5VwnpFGbaDsexDFZzUeNo6LFAH86E42Bs4K43IolN7z2VSW+IhOAVZq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06VbYZm2c2dgaMlmuXOAPIhraea7b4AXiREe1cU/gaM=;
 b=sSIp0KRki89XjoWuc6UErFSwfmRHoNaIwn3Usni7iZjbUKbgDGSkGzCZ0bswmJyDOqJ59FHbpxhF5EnwmFQtIzQ7rfKNVVEfav+tcaIlhwZ6QelVLFFtOmrRW8HUA7883BvbZkDbP/6dWAMdKD5nK/oTlxm8U36nQkXkZgYdaRrhQEHcuR8QZ534S0RdWHuYsz+M30Qv9OvnsvZdMCVTcH1VPhM1nW2B+R1n/SklGOhasmifwkauqwdF5DujWjnBSgMbaGF4pzD1WSblpIM3/X1aFmboU6Vo1giSTywrQRDgSDfDYL31Qze10UMX2jjLqU1qvDlthRK46InVcRXXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06VbYZm2c2dgaMlmuXOAPIhraea7b4AXiREe1cU/gaM=;
 b=LPM8FXeuUXhu0WLRiF2PtaGppBn/GdMC790zHfgmvC2tyLt6fGwCzXZMhZIN6+dr3PuhP6VcrvRSoIhHr0C9eYAUeaN6xstgkpIC7gijsoMrazBLq1Dtg9+o9bSYQquxjaz5xRxM1PjDYfmoaB5c/3a3Gn1aPmxhGAErIufzI8E=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 13:03:21 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:03:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "jfalempe@redhat.com"
 <jfalempe@redhat.com>, "javierm@redhat.com" <javierm@redhat.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, "sashiko-reviews@lists.linux.dev"
 <sashiko-reviews@lists.linux.dev>
Subject: RE: [PATCH 0/2] drm/fbdev: Move helpers to clients/ subdirectory
Thread-Topic: [PATCH 0/2] drm/fbdev: Move helpers to clients/ subdirectory
Thread-Index: AQHdS0uH+iQ747HqqkGBKqmkqQ+jWbbcIRKw
Date: Wed, 23 Sep 2026 13:03:20 +0000
Message-ID: <BN9PR12MB5146DC3299C804856C42C79AF7822@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260923110537.451614-1-tzimmermann@suse.de>
In-Reply-To: <20260923110537.451614-1-tzimmermann@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-23T13:02:52.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: 5f6c4c56-fc47-4320-2b03-08df19730b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: HCt9EvYhTcDqPNVBM8vsGBR/zSYhqc2J7okknJlntDsfWfMM8PQW74SLVU4PslyV2WXGO4V7zZoshLts9ViZgpcz2xL3iQQmyGweyXZl7g7rVnQ+JGE/PDXf3kE/RXCPXmNsfSVqqMVjenFPdv9cKC3t5+ps42KXdSdHcStW5q0K36QFDQOA1CYmccp/6dorf6MeecMdIFkCWsdvrJ46UjSvLujpK+hncRArDWFg6w7e6hWatGlntjWz/Q1D3xV9DMuQhQBLEBus2+L52DRH1oqLm0TJMcsFwV8jK57Et/RHEsxXMd00Dmr2AKN1FjaRipg30Jzifl8fXdv0+eP6UIoQb9BHbOR5LPkTLZIKVVx99rPomXTfDPB/NKp0ej7Xg8bI3WCLbdaghBJsCB4yJmf6p5AsKoyobgLNCutWvtQOWZh2NECe7QkTSM1gJFDZDLq5QhwYF5mlXL+vhMg8M2R+TsNWG0WNXh+gRQN6iyG9gzM5jru6AUEakwf6JcEdla4VoXWy/d/A9Ka3bSYi2lOJDuTew/qjrke0k9947SvMoXMZhsQ5ZrmMItDvBD/4G4XgIeZDs/C5njYTSD++C0yABjYv6xBAp2ugTjtjZ46/Dqi4LEMByDvif5p0Frp0DKotmxsDIpELE2a/D+op74DaYSRnIGa62Z/ZKe3V/h+bmy7Um9Ov2ZpHvEXJZqtLNwGnWHrbhtn/6snj6esP7BkCSdMXUHF5Tex/ydvJZAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j56/wEpydSEHQlPMgpCx+C5AUn3KkNUT44saIQHFK8LEsr+AHoX55WPzSMeR?=
 =?us-ascii?Q?1us20JfSyUlOp3qkGwL6DTJDP6sEsmmps8XnrGahcz8m4HUC0d6qDIebJBQ8?=
 =?us-ascii?Q?x5jVXCndMrSsB5pfkW3L6QdQFMXcGJHTn4xyYSMpMQIDpriXAvc7GGgE9brF?=
 =?us-ascii?Q?NdnM+X/FbwCDlg9Af55/P5mRI9pfJjtRx2o6nhxRWUsGAwPEMAB7WhEeSIc+?=
 =?us-ascii?Q?Tj06gmj2yyRnKEwXm9BCMRIDjEZX86ePHuUJ8prKQnVZE1C1o5kvXekIzpnA?=
 =?us-ascii?Q?kTwoLlpyB1J7sCTROm0tLKD96fQmulAsttBt/bkHnFrsL2RG17JUel+aKXgC?=
 =?us-ascii?Q?T2aE3qFvPj3CxDgUEU+VstKbeuuG0dyxa3/9VPywx564sRLsnnU5iqnphhAs?=
 =?us-ascii?Q?UnhZgpPNbDKDUAxQ2EZT+SUDs2AD4JODUzAB0WGAQJsZXHgtsjO4DYkPfyuC?=
 =?us-ascii?Q?Zfb8c0Ts0NY2Af7B3CIUx0EIjTRlNkv8GnziXmYyot1HykHPiGaCzj7i0zYm?=
 =?us-ascii?Q?+D1EHpqDz2oQ3H9v/zjZ3v1ajJI6mbRx1CVOnoGQbRjKLhRQf3bc2biTVLlO?=
 =?us-ascii?Q?Qz26MG2IywCFMQYW+KoTBkq69ikteeOeGRISdUWrOPPBm+kcxuHR/+5/44H5?=
 =?us-ascii?Q?ttKoogVqotewe90LNC6H0+rY3LbnNGtmhxmQ/4LI41x0JSOkyhaLT5aRf7yJ?=
 =?us-ascii?Q?i50k4dNurx2BOydLtnsPcACgCSisc5frin8fyX+fMK1YpN3VauniMGFmkvqY?=
 =?us-ascii?Q?Hls06Js5EZQYccsCTRgtkMn2M+FQ2HRcZtFnsQdFSHZCf9OPZHYjEaQ/ma4w?=
 =?us-ascii?Q?iSDQ4lVmvZw857ODOBUNi+Obey/RwTQAXV1qBkhRj2obAlPXWQSdngFQ5u6I?=
 =?us-ascii?Q?fFW3h1uqxtn+YDUGH33uHDOu1/72wyPLfyfZm8r5beB2wf/67nXbBqKrPfqa?=
 =?us-ascii?Q?UJF5i0BjoElLotO0w2d43lrrUBsmHYu3yf85JAgqYxE/PmG1hsWPVambCvqe?=
 =?us-ascii?Q?IPLgK4zDuNt900TC3BW13hoorcAV/b3/B2wxt6JMg6lfRv87x9D0e6uIoO6k?=
 =?us-ascii?Q?zn3i7SA/Gb2H9jRivYB3LuCG5S6+QJkZQqVxaRi576db4L+2nM5PF9MS9M2S?=
 =?us-ascii?Q?6J/0HoGR+QU6MLsqkhbPJwqmJMVE3Z21qeizNl+E5Qx6ODkw19xEuMAltIr8?=
 =?us-ascii?Q?+zuk1O2+181UFWhNUPhP3dLBbS3xLw7MKafyZRzorvQt9Ex9aP5p49ixvnaJ?=
 =?us-ascii?Q?UUYpkWm4zNORKOW7HMFv/qpDWrWzZ8XGL76i/ynqj5Z+4pSHOqKrdgr5WY6a?=
 =?us-ascii?Q?QNpPk8mKPvGt+UnfM7I/PV91wjb/houUzSkFuAaghMnG0hLNKGyBrJgBCjSQ?=
 =?us-ascii?Q?JuW8CQShe82G977ei+go1/SATrYNoCBv1LUQdv2pAT7slQsaW0b3CWmaSXLJ?=
 =?us-ascii?Q?RHo0rlfM+bljb2NejydR3/DxeqQIizXIOAIvY2XXWpPyI+It0dqaXlQik94n?=
 =?us-ascii?Q?yZOvwZ+RD2u0LyChyWHBFf65edsXnoFi1qQYgXia25dalUmbfdf0qA/W6Xk8?=
 =?us-ascii?Q?GWGWgRAc7gzsWkwHQHzPh0OF7btgyPpfe39+xqHbAdRM5y9pxIKrc9f0Otij?=
 =?us-ascii?Q?zXS7kPmHHDvlezRJ63PR/Q1e4e64lYw7xO2QyqWl7Own+B2zYeYESwX+A7Au?=
 =?us-ascii?Q?CpKEKT3asbn2jaG+qAJ6CKB92YOJnOUvctXa7FV7ke6wgRrM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6c4c56-fc47-4320-2b03-08df19730b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 13:03:20.7255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbLTPpYio30FP5JxNnc9EZw2f8tgThqsY6rkwNtE/VnLPsusWfX3hbhFFymiCdkg9rM44XO0vzcoEnVMOu+hSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Thomas Zimmermann
> Sent: Wednesday, September 23, 2026 6:59 AM
> To: jfalempe@redhat.com; javierm@redhat.com;
> maarten.lankhorst@linux.intel.com; mripard@kernel.org; airlied@gmail.com;
> simona@ffwll.ch
> Cc: dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; linux=
-
> arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; intel-
> gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; linux-arm-
> msm@vger.kernel.org; freedreno@lists.freedesktop.org;
> nouveau@lists.freedesktop.org; linux-rockchip@lists.infradead.org; linux-
> tegra@vger.kernel.org; sashiko-reviews@lists.linux.dev; Thomas Zimmermann
> <tzimmermann@suse.de>
> Subject: [PATCH 0/2] drm/fbdev: Move helpers to clients/ subdirectory
>
> Helpers for fbdev emulation are still linked into drm_kms_helper.ko, whic=
h is
> for mode setting. Move the source and header files to the clients/ subdir=
ectory
> and link them into drm_client_lib.ko. This has some fallout throughout dr=
ivers,
> but it's all trivial.
>
> There are 3 module parameters to drm_kms_helper.ko that control fbdev
> emulation. For compatibility with existing installations, leave them in t=
his
> module.
>
> Thomas Zimmermann (2):
>   drm/fbdev: Move fbdev module parameters next to module init
>   drm/fbdev: Move fbdev helpers into client library

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  drivers/gpu/drm/Makefile                      |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
>  drivers/gpu/drm/clients/Makefile              |  3 +-
>  drivers/gpu/drm/clients/drm_fbdev_client.c    |  2 +-
>  .../drm_fbdev_helper.c}                       | 34 +---------------
>  drivers/gpu/drm/drm_crtc_helper_internal.h    |  9 +++++
>  drivers/gpu/drm/drm_fbdev_dma.c               |  2 +-
>  drivers/gpu/drm/drm_fbdev_shmem.c             |  2 +-
>  drivers/gpu/drm/drm_fbdev_ttm.c               |  2 +-
>  drivers/gpu/drm/drm_kms_helper_common.c       | 39
> +++++++++++++++++++
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
>  drivers/gpu/drm/gma500/fbdev.c                |  2 +-
>  drivers/gpu/drm/i915/display/intel_fbdev.c    |  2 +-
>  drivers/gpu/drm/msm/msm_debugfs.c             |  2 +-
>  drivers/gpu/drm/msm/msm_fbdev.c               |  2 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |  1 -
>  drivers/gpu/drm/omapdrm/omap_debugfs.c        |  2 +-
>  drivers/gpu/drm/omapdrm/omap_fbdev.c          |  2 +-
>  drivers/gpu/drm/radeon/radeon_device.c        |  2 +-
>  drivers/gpu/drm/radeon/radeon_fbdev.c         |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |  2 +-
>  drivers/gpu/drm/sitronix/st7571.c             |  1 -
>  drivers/gpu/drm/tegra/fbdev.c                 |  2 +-
>  drivers/gpu/drm/vboxvideo/vbox_mode.c         |  2 +-
>  .../drm_fbdev_helper.h}                       |  4 +-
>  26 files changed, 72 insertions(+), 56 deletions(-)  rename
> drivers/gpu/drm/{drm_fb_helper.c =3D> clients/drm_fbdev_helper.c} (97%)
> rename include/drm/{drm_fb_helper.h =3D> clients/drm_fbdev_helper.h} (99%=
)
>
> --
> 2.55.0

