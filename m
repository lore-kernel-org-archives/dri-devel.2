Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0824C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC1910E95A;
	Mon, 29 Jun 2026 14:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9dSKM/B";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6224510E082;
 Mon, 29 Jun 2026 14:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIYzdRfBiq7bUqAI4TdFjQL8vC12MNhoCA3rJEih/oJPA2rRbAXRp/LNeCZDSbZ7Ncg+zM475Vd8H+a499KLOoBHWHsemAbrQb5Hoj2D7Of5lBOAcX7k7SSf33RGVB0lJhY/UM3ZEbfalN6SwXBQCRnqGs4Qld7V38UyjOeD1/t78ab4qDgdeJ8Wni2LJ3/HFPJxonSeAkEzQG517qekQOM3cI3R7gEevmpI3tsLT+PjzVLtAgG3P4QdNhuEJAFo5QV762ws5bQkSiOV9NQahGO35cZsquh6Tfd7eEYAVYbBREdw2TbyEN99mvyaDPZcz95W7YFXmxw876GsQgUfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF0DwsqtVxPmpNcdnJ6pdpW4UrQXT6pFHDyzsPu4CFI=;
 b=gViBn1ZgLAdE5/pHh1xemYfVbd5EqAAcAWBZ8xMsnwT4T6UqRbhKYUKtkWVddjqeqKUZwB22dCa4ghRY70Axoxz9lSBNlISAZMBbrs0vp5TGmuh04U9b2+G3LjJUemPncWA4585CSEI5GhufejTpgIv/7DGcAg+g7ebvaVe017j3swQnN8tz+smfmIf4S3dPme7po9QUKoUzN/cTGtXThs02q54+SOfyCVHBGk3ALYxGdWZANrej9Qn0O3iAMRhucgd3dvo2Mbu6V1Wbohq5DskqL5fEvMZt3mn2mekKOYEYnFvN64gezfMyPULSzXAH732NK3A/EmiFzP6eVyF5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF0DwsqtVxPmpNcdnJ6pdpW4UrQXT6pFHDyzsPu4CFI=;
 b=w9dSKM/BoPq+8iEkIXGU4mOBv/E8cCvuSilfNwvhWUDyRilX4w41CiHyMViCt0KNR2rfLizr/r3eQM2R0qBF0gkrNW3WiYKuZ2Rtb5psWtat55egZNXENCXapREbjy0YR31mX4I/IDXv6vhQR6XS9qiZmMjeGlBMN7UmIvyLLKY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:52:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:52:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Zhang, George" <George.Zhang@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Chen, Chen-Yu"
 <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Drop dm_pp_get_static_clocks KUnit tests
Thread-Topic: [PATCH] drm/amd/display: Drop dm_pp_get_static_clocks KUnit tests
Thread-Index: AQHdB9Yjcn+6y+LU4EilvxP3SVe0lrZVngqQ
Date: Mon, 29 Jun 2026 14:52:37 +0000
Message-ID: <BL1PR12MB5144466C5001B52E0B545343F7E82@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260629144628.1710240-1-alex.hung@amd.com>
In-Reply-To: <20260629144628.1710240-1-alex.hung@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-29T14:52:13.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: e1ad3b34-701d-4528-0b06-08ded5ee0fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|22082099003|18002099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: YGj2oxUMMr9gO7zU85gunMFzT0L7YrxoEKsifvWTxGb6+e7hy/ny6JBtFecKvvXButXK0cEm7KgoG+mEkRNWcHz0joHI0oxZBLry7BVoTL2vuxkUg7VxUTTAj4wG6I5+HUFAEI0CdgACLVTN5IcoNZFow16dBghrTMsrDmJoS682zTJFy21zuoKIWMGloPXRUKsdtjbs0LgCG4hIP+gsV1sl4n1EHrvv5uwndZ4Nu91DJXo6FZgPVudpNvi18wSE9k4cq64OvzbOtr5BBP7YsUBfuyDqKK1NaPwIhjPsSw6TTfs7qSyiv1KxeeecxuitFEuy3PAtsSutWyYOKlZNdjyLHBDu+wSmS+6LViufLkXeiAzFrHVQc9VxLq3ujusW417Yv2YArDrEHxnf3R9pNzAc3OUD+XAh7U46P3gNmfie2zrrApHb3FHKWDAPZ1LK1igKtTpB8eWD648W7bhChLdYGTSx/+7GGc240SzgW40LJRP3B1X5DU+gKdqBIeoMHdy2Xgi92/g6nJe7Wrzp+gKxdUOAwc1LcGV+GOTt55uCDdBejyb0EtPK2pooc3bQQhKHWuoLm7xaAxDmqn+GftEfX9lGEM63hqs739yhRGXwHTsLzGI2h883akjUZcDMT2q/FbyXv+9Wf6bUV0yNmS+XaoL9Xxu5tTAUlo5eTuLCYPAU/jCwKjRf+7hrzg31vs8plJUNnOkJ1OCsmnqhLjZtR7fkJTAPtB3aUiP06k+6kXYgn+8k1o154+ihdCKg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qru9mWjFa8npxdxjBfqqFIiRguIOwrmoM8WhO42UHtXcX8HBMxzy/3CMRasq?=
 =?us-ascii?Q?pTAfTqecquhvomlDeer6NEmmEAzTEy4+wFXX8M0ta4EZY/NKEP3wdZbSzk9v?=
 =?us-ascii?Q?3bku0vC+Y1RW2jSv4il+QnVsJrMW7S0A4clKCE/Cd2rtZeEu8BNb71Aw+P9C?=
 =?us-ascii?Q?n5hVpjv9lPFHDOcB5WSfjTnOIx6ShPUu6vsDwM1rnvAsB/StOtY+oLq4N9OH?=
 =?us-ascii?Q?ZTT/qwrfUHKSbGYi2CmYtsqzVl75SCdYnV2EpVxGjNSc3rplwtG1kFjxDdwO?=
 =?us-ascii?Q?+9FW/pfUW1/GVSx5ioI6PzJxdiuHIhrhR+j8617H5uQbWfEDgV9DJcbPPxs+?=
 =?us-ascii?Q?5TUpvEvBHcciSnRtpvCuyfv+s0UsdAklBe5pg5cOORwJUodRfZxyfnKZl2iQ?=
 =?us-ascii?Q?sbcUGY1QoGUADNcYbz0mDuBohu1yoU0iap2TmeYfC+86bmstrHlCGMRq6gik?=
 =?us-ascii?Q?dfomLCncYwTzlnBCZpV6G1J5Z9JENvYn+eKXfX7qZgXlkAARa6SdWlkAd7Pk?=
 =?us-ascii?Q?ebuV99py6jhnzetiBACr5qYTJlYUAU+X0eY4okcmIYTWWTLiqdBE5n8FAwTm?=
 =?us-ascii?Q?vq4egWky7d2iicwoaGkgF5rqhgUyk76z/TS1jShGjPwLFCcqHmrw2obJ87A2?=
 =?us-ascii?Q?R0YWv+n1O2XSQ+7j/AphqkpGYmVWs8Fnxki2r/nTtcpgmX45O8pSkDr3L4iB?=
 =?us-ascii?Q?65MpOgn+eTS2St1wygzr9aOdG6f0TmEITR7JYVN/zJaHY/CtXtdf6PQx6oOT?=
 =?us-ascii?Q?okBfhaAsy5UwG3HcOTr2N1ERoFz7UUXAXKpNHPrbOqHVFbklP6q6kp7eSmdW?=
 =?us-ascii?Q?wpcVjTnoJZh54PRxMBi6YSKsxsJRZ1nndJVkAFGOnBXAOI7rtezBbLT+pvUn?=
 =?us-ascii?Q?S/euJpU9GJyKjts7SRAZIoHiYg68Qab/fQyumw9+Fir2G4+cPuEonbJB+2Ha?=
 =?us-ascii?Q?youuaI8lhVZ1iXaoHErovGkgIGlipdRvPD722YXg/FqVk/lW2da2C0BnffZX?=
 =?us-ascii?Q?iLigu7PYxYnADd7pg2MIn6ZZljB+NueKwJdpCQxfAzvqfNf61SjvS6uKuP1V?=
 =?us-ascii?Q?1mE2Vu9w1GXHJcBzJJmTIWAUQXAM6ekolAFMN8sQtDxCfX9NBVU62M6orAK+?=
 =?us-ascii?Q?1wFqdYqONX+svKXRJrG5LORBSzygJPseIwVus+p8mz9NIWT8qVSyfN6Zvv/F?=
 =?us-ascii?Q?IS/30f2jlij5Z1GJtEu1ZQrWXUL0JsNEVO5kNtL0aVGSXa58P52esriVkx8f?=
 =?us-ascii?Q?UlfocI86n0DoIPODah9ByH6Ls4fsnfig2EdJJwXyhKwNTaeZnZTAiJ9Ka9ak?=
 =?us-ascii?Q?w+gG4QK2pJnX3zAVrEXhKPiL//FCJw8HfU/igY2v4si01qbMRzgZAiPB12Ay?=
 =?us-ascii?Q?LXzQRsBfn8KFereAHVGXJiz7rUSZ+ktTrJdTGa0/WkOBDbJNh0jN54nxp/1o?=
 =?us-ascii?Q?NYGw3S338RIvJJRa28PfmRSSaP0eEAYWz7RTtsEPPakA0GY6TDyhFQ9P9tum?=
 =?us-ascii?Q?lh51EgJo7OKNGJRsnG8ypHnlC5i/ht14bHo77gt+aDm9xdEFXQXJSCUyycjH?=
 =?us-ascii?Q?GYCVk+ZpQJDnxEgDxKCJK4WnV79O1g3P51CtFsbVr8nWdXG4i+ykBsIV2nMn?=
 =?us-ascii?Q?gsdDDmPWBieA1hzHe+KOiiJ9zbhb8Y6xU7y17qZY0rI5q6m8EoYnw3jDDDbe?=
 =?us-ascii?Q?gvmt6UWgp864Wl+HZ8GkUtz4zioa4wLz2MigertMfuO6u6nm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ad3b34-701d-4528-0b06-08ded5ee0fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 14:52:37.4449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pfANgxRKOcs5g4UPlRpcx7kNM+W50lXjDrdicN4PH/niFqPZRK4yzqWqRm4Gs/ws6BMob1+ZRgH3sYE9fL/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
> From: Hung, Alex <Alex.Hung@amd.com>
> Sent: Monday, June 29, 2026 10:46 AM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; siqueira@igalia.com; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@gmail.com; simona@ffwll.ch; Hung,
> Alex <Alex.Hung@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Zhang, George
> <George.Zhang@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;
> Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org
> Subject: [PATCH] drm/amd/display: Drop dm_pp_get_static_clocks KUnit test=
s
>
> [WHY]
> dm_pp_get_static_clocks() is removed, but the KUnit still referenced it.
>
> [HOW]
> Remove the two dm_pp_get_static_clocks test cases and their entries from
> the test case array so the suite builds again.
>
> Fixes: 897f2ea8a45e1 ("drm/amd/display: Add KUnit tests for
> amdgpu_dm_pp_smu")
> Assisted-by: Copilot:Claude-Opus-4.8
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 54 -------------------
>  1 file changed, 54 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_t
> est.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_t
> est.c
> index e1d5088d8c0f..8d1d26bfcc16 100644
> ---
> a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_t
> est.c
> +++
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_t
> est.
> +++ c
> @@ -1121,57 +1121,6 @@ static void dm_test_nv_clock_id_invalid(struct
> kunit *test)
>
>  /* ---- Tests using stub DPM layer ---- */
>
> -/**
> - * dm_test_get_static_clocks_success - Test successful static clock retr=
ieval
> - * @test: KUnit test context
> - *
> - * Verify that dm_pp_get_static_clocks returns true and correctly scales
> - * the max engine and memory clocks from 10kHz to kHz units.
> - */
> -static void dm_test_get_static_clocks_success(struct kunit *test) -{
> -     struct amdgpu_device *adev =3D kunit_kzalloc(test, sizeof(*adev),
> GFP_KERNEL);
> -     struct dc_context *ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KE=
RNEL);
> -     struct dm_pp_static_clock_info info =3D {};
> -
> -     KUNIT_ASSERT_NOT_NULL(test, adev);
> -     KUNIT_ASSERT_NOT_NULL(test, ctx);
> -
> -     setup_stub_dpm(test, adev);
> -     ctx->driver_context =3D adev;
> -
> -     stub_dpm_ctx->get_current_clocks_info.max_memory_clock =3D 80000;
> -     stub_dpm_ctx->get_current_clocks_info.max_engine_clock =3D 72000;
> -
> -     KUNIT_EXPECT_TRUE(test, dm_pp_get_static_clocks(ctx, &info));
> -     KUNIT_EXPECT_EQ(test, info.max_mclk_khz, 800000U);
> -     KUNIT_EXPECT_EQ(test, info.max_sclk_khz, 720000U);
> -     KUNIT_EXPECT_EQ(test, (int)info.max_clocks_state,
> (int)DM_PP_CLOCKS_STATE_NOMINAL);
> -}
> -
> -/**
> - * dm_test_get_static_clocks_failure - Test DPM error returns false
> - * @test: KUnit test context
> - *
> - * Verify that dm_pp_get_static_clocks returns false when the DPM callba=
ck
> - * returns an error.
> - */
> -static void dm_test_get_static_clocks_failure(struct kunit *test) -{
> -     struct amdgpu_device *adev =3D kunit_kzalloc(test, sizeof(*adev),
> GFP_KERNEL);
> -     struct dc_context *ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KE=
RNEL);
> -     struct dm_pp_static_clock_info info =3D {};
> -
> -     KUNIT_ASSERT_NOT_NULL(test, adev);
> -     KUNIT_ASSERT_NOT_NULL(test, ctx);
> -
> -     setup_stub_dpm(test, adev);
> -     ctx->driver_context =3D adev;
> -     stub_dpm_ctx->ret_val =3D -EINVAL;
> -
> -     KUNIT_EXPECT_FALSE(test, dm_pp_get_static_clocks(ctx, &info));
> -}
> -
>  /**
>   * dm_test_apply_display_requirements_dpm_enabled - Test DPM-enabled
> path
>   * @test: KUnit test context
> @@ -2424,9 +2373,6 @@ static struct kunit_case dm_pp_smu_test_cases[] =3D
> {
>       KUNIT_CASE(dm_test_nv_clock_id_phyclk),
>       KUNIT_CASE(dm_test_nv_clock_id_pixelclk),
>       KUNIT_CASE(dm_test_nv_clock_id_invalid),
> -     /* dm_pp_get_static_clocks (with stub DPM) */
> -     KUNIT_CASE(dm_test_get_static_clocks_success),
> -     KUNIT_CASE(dm_test_get_static_clocks_failure),
>       /* dm_pp_apply_display_requirements (DPM enabled) */
>       KUNIT_CASE(dm_test_apply_display_requirements_dpm_enabled),
>       /* dm_pp_get_clock_levels_by_type */
> --
> 2.43.0

