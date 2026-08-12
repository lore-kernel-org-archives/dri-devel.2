Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7ECC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3C110F099;
	Wed, 12 Aug 2026 16:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UcjrUf0i";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA8710F08A;
 Wed, 12 Aug 2026 16:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLHkYsLByWwGAsH2xvJkn7B1xa38haIBUPLC1snsArg0SHE66UDL6MQJhvR68c1yHJvjHErKLcHqvVZjR0I96+j59wCpXP3mKaYKNjyxZrpZslMfq2QA6JsaUUH5otAbSZuR1RMjZM8VjQhjIx7s/Bd9pVMf2jzVLxJR4zCWZihSNU+qpouMU4SGFUo6JJj5N/janKdDsYvDM52cPDe/k2bgMIvx6bkJCJkejj9vdE4fZZZCj5qfzpb9iErBxnJUB1WMoKuTcyAi90Fx1jPGLRZIs4FbjuipYe1LRrLIponEo5NoUzDh53gC2EiGnVE9we32YOjdvXQqaMBIE8zWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoPoK0V0E++Zt/RzjdOWzNGwPEz9JuqjZt7m+MWgjpk=;
 b=qQHV5z2tpd2OtPJSDCGibdKhxYz39i+FRHK8pIjYsQLAc1nzotu+1CgfhwNFetUiSIDu5vyCOPBuNAEJn7Bupk9qMXX97eQ9Ihfhmr8mvybGOca9GgWGtON1eQ05HMIBYCBUrvPAHXH4TWIWt/NtZn3m3Pj/kANICehszp9+Wdw6dPbvsAe7l37EN+iveJoB2LjnoKxEgqbdrAUc8P0Ps/BsMeUi7aFXgwVJSFb/is/TYlM7y4TrgxW49/PPj3B8aL2eTteLtSFfKr/Tv8w8W7apjBiwap0JatKaac2sjyAcNaHa+EVcT1oHSWHA7+Uw5LDVSfL6IJ5/ZSqkrF2izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoPoK0V0E++Zt/RzjdOWzNGwPEz9JuqjZt7m+MWgjpk=;
 b=UcjrUf0iDFTo69MEj3G+Zii7Sn75ox7/DwQLBAdoC9WFLn0teCB/iJczRLFV23lnpw4F/a+e65BclaDQkg8uBlGf2YM2sQvK9GwnRWWf0NmYq3K8gCTXqfou4LqgLqbo0z2v1UxeIXnP4xSBKOT2S5bc/NerZzmM/bXk4rgt4A4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.14; Wed, 12 Aug 2026 16:34:36 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:34:36 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: Melissa Wen <mwen@igalia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "daniels@collabora.com" <daniels@collabora.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "leandro.ribeiro@collabora.com"
 <leandro.ribeiro@collabora.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "pekka.paalanen@collabora.com"
 <pekka.paalanen@collabora.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "siqueira@igalia.com" <siqueira@igalia.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>
CC: "Hung, Alex" <Alex.Hung@amd.com>, "kernel-dev@igalia.com"
 <kernel-dev@igalia.com>, Lyude Paul <lyude@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop
 warning for DCN
Thread-Topic: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop
 warning for DCN
Thread-Index: AQHdJBrCDhxidYJEekaxh1cehjUJW7aap7rQ
Date: Wed, 12 Aug 2026 16:34:35 +0000
Message-ID: <DS0PR12MB65344015A6A94FCD1E449A709CDC2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260804140758.107683-1-mwen@igalia.com>
 <20260804140758.107683-3-mwen@igalia.com>
In-Reply-To: <20260804140758.107683-3-mwen@igalia.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-12T16:32:57.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA1PR12MB6385:EE_
x-ms-office365-filtering-correlation-id: e465c0d5-8f3a-46e1-311f-08def88f98bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|38070700021|921020;
x-microsoft-antispam-message-info: z9E6k4mR8PlLqLwcKD6gtIM7ZVl9GOh8Rsa3wVt3yBKkBGJqX3psfH6K4NIOwFAhzdKh0dLi+zr8YWjg0vEE/itRUGRpD+mNO+kMhR2P7uzN0nNy8w8BsJ86GoAatZVprp73p0/6tvF4lQMAYw2fH1dC1wvNwKNzTQ5h5XPTdUdZ0CQ6kfEAJKcLsscR5gJXVoIkwVk9tVgk7MOWRqdLd02qBB1U6sNyDtJH3G+IAZVtp6Gbq2aDf77V7wSFjl/d2m7whOEjC80TXRGsw7QaLPBkgs4Tri2ib9XV9Eg5IbPKcLDDO5oSVRA5sB1D6QZavjVxEaRvdL30Yv1ZLg0/34W+mjVDAN9xlt5bm4Qw6qNyNWxDD45hEvhvJ2Iwjk32mQtSqpRfamWrPjaPEqZu8tneRxSuBd7I2Xogoi8PVBMXYaHSKBSnkPedmPrVLym4Evx9f/Gb5MdMitYTcG8JOl0MjOVwODW0rifHb7SKL9zH4Dv/E4nxA/QAY3P2pV3Dsd8i/WmsdwJpkpa2NlPKufRVXhcmsggZ80kfaH0O7hk8aENLrPNCUK12umt8Pcvuky6PAhgfMtOlwhZzzZHEAlmel0Kn7W+XjbDP0QT8fCjv39mlGI2I35MoYopkonlnKxzib5Kywo0hTfHJYYlG6MKemH9AIkcWIl8D3TlDjJnFZ5ZZgmrEAZqa8N7qlHDBuatIbs9VyfbaA+yMtw+Xefk9iGo1DaQEtKWQOuf0TUk/Iwb9zO1SLUMbsC4dsbvJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FlGA4pNKvFxM4+RSdTnmWN/jELO7JY8s2RSwBk5+1ZD5bIYbceAKPghP0a?=
 =?iso-8859-1?Q?sby9hHygOwKKYBqpGOz9XoH4vAqc5/RcpT4r104J5AZzMxCtdjiwZ0t5Et?=
 =?iso-8859-1?Q?v+s65CHsYFQxnHWc91+cgnMW0j0m52cPIveyHqkLVejiXoS6jRsEqI1vQ8?=
 =?iso-8859-1?Q?6jRQTbqcrY8AlbFmb4nNFtuXLXWd0RY3hcN4abakBDAVbN5jNywnGVon9T?=
 =?iso-8859-1?Q?zCWuipIze/Li/EBptzmFfCZOxxnmsKv+VqT5oro6j0UHMD2SVOXRCZNNbF?=
 =?iso-8859-1?Q?MhjDJ2sus2qoTlsFWb0FxzVMKdZKiql8xk4CsN01LXIDRaaiX+fx5t7bt5?=
 =?iso-8859-1?Q?5WEZAZfXmN6zdEzU6MEOJlAvF9yrzM3p/bOhPpLuiOoSLHXtIsVM39yfMM?=
 =?iso-8859-1?Q?JxkrsD+8BxYmdgmYlYhN325mtgZgRVCs8ESJ//t4dplBcEguI7HCdC13TY?=
 =?iso-8859-1?Q?/pT9DhdOe8kPG0plz8+3IR/1WR82tPWCAp42OV8/VuWFhev1C+0Ev69ZRL?=
 =?iso-8859-1?Q?nrDBnmHzdefQqJbMQePiVh68PmF97Et+b7CMOvEHdFYZW/TXJvpmmvO9xZ?=
 =?iso-8859-1?Q?nGbMyVTbyZGRWRR4660NzOBh3uAJeBIHvnb6G7NXLxnBEW027tE8O8/KHX?=
 =?iso-8859-1?Q?dWlrfpiXh1LsnTrf/QOjz4jhtQS/8bLpEdahvJzaQ1yQ9SIEoaXZvWa5Jk?=
 =?iso-8859-1?Q?RjfJJoLEDjMAkklE4gkINO+HfyktyaWoCkqYRAGN70uHP/2+G6Ta7xGuxS?=
 =?iso-8859-1?Q?LQsV9bbG/LzcCqfKhVUuxRgz+iNlAo5wFGJ1B/Rdjv1jbaRBMnqKqGLuo8?=
 =?iso-8859-1?Q?ctHOhqXVqhWAcGrTnR7appuv0IYrhkgSuOomoT3XUnwi+fClyaEkA+e7QQ?=
 =?iso-8859-1?Q?3Xfh3bNcwbcN38iyPmG4thki8akwIYn838quOqgUFtM298xcaWT/0QwS8A?=
 =?iso-8859-1?Q?E+lt1G/7Q+7ilNgn1If9csxNeyrM3y830geFRaq4kAfhKMPm9e/G5+bFsJ?=
 =?iso-8859-1?Q?bG/1lDhAyAVcdj73DLNz+8+hkHXmkLHj7q16wIEqRXZD9hA5WbKeZ8KX4g?=
 =?iso-8859-1?Q?SuHP13W+9q/iqOvj2YsN5OrRXp1Av/CwXAsbzQ35RzSgoywoRLuFv7kNOx?=
 =?iso-8859-1?Q?oLKAa18mAbDjfryZZnfHu3Zg/ifRGWPY3IpjGtePwYTLRICPAl4ISaAYLS?=
 =?iso-8859-1?Q?6au9r43/NHuT3zEYifYhLmmilQRc7CdVaUE9Nkkc6EIS7K5eS3AwJ9WX49?=
 =?iso-8859-1?Q?npjczdRmQCjYkd5ahpYC6XQbWqUGYKRI3QTrMQwZMtSQTXkPBJ2FhTiFIe?=
 =?iso-8859-1?Q?bdJR4WxFOUZLzvEgVqcVEALnLTAwvejxo+TeNrk7jLXsoUm063c78AhzJL?=
 =?iso-8859-1?Q?h9ggSI/HXnRskcpI0zlgo2Ljxs9UqlHaguPRJqZv7EY6LIndqkgT1S6VFP?=
 =?iso-8859-1?Q?KM6rEwzFG/U21Huw5fX5F6U3XH9Z4P8tHLMMgIoEz7tKOe7Ns40DVAzx1r?=
 =?iso-8859-1?Q?h99KPXoD+gQHhK3enXor3UlqqhbVsjY7a/iheGRW1VtcnSqb6/XdTwYiRt?=
 =?iso-8859-1?Q?11ngUDdrGhFM/4/bXFJYy9an8SeMNWx/szLvgwlNgnytw6v5aGpgp92VOb?=
 =?iso-8859-1?Q?TRBdRCmoZZ6cNCovCxxoLu8AMS3tuE80wiWhXWRt7zyWV0YPgeWe2h/Ol0?=
 =?iso-8859-1?Q?k4twxzGTd3yWs/HPQRpFz3OFSj6eXMABtn4egyNmJ3Uyv7Sb+MCqiEjwGF?=
 =?iso-8859-1?Q?KCmA7u+ZkgGz2khiiNBJA020CDWuYMO4WGyD7+mnO6FpEy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e465c0d5-8f3a-46e1-311f-08def88f98bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 16:34:35.9248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvwBWhrZYo8A4ojH1RXWLF4G1lrkNnXmvDoECzlS4th7t7IpeiQzmqiI40rL4ak5Q4MYmYgfFo/u3CWYxafhSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

Hey Melissa,

I've found out that this patch causes some IGT failures with the igt@kms_pl=
ane_alpha_blend tests. I noticed it with a RX 7900 XT on a 4k60 HP U27. The=
 tests fail with an assertion failure. I posted a snippet below.


Starting subtest: alpha-basic
Starting dynamic subtest: pipe-A-DP-1
[181.052561] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Test assertion =
failure function do_display_commit, file ../lib/igt_kms.c:4982:
[181.052564] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Failed assertio=
n: ret =3D=3D 0
[181.052568] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: Last errno: 22,=
 Invalid argument
[181.052571] (kms_plane_alpha_blend:9570) igt_kms-CRITICAL: error: -22 !=3D=
 0
Dynamic subtest pipe-A-DP-1 failed.

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Melissa =
Wen
Sent: Tuesday, August 4, 2026 10:01 AM
To: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>; Koen=
ig, Christian <Christian.Koenig@amd.com>; daniels@collabora.com; Wentland, =
Harry <Harry.Wentland@amd.com>; leandro.ribeiro@collabora.com; maarten.lank=
horst@linux.intel.com; mripard@kernel.org; pekka.paalanen@collabora.com; si=
mona@ffwll.ch; siqueira@igalia.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; tzimmermann@suse.de
Cc: Hung, Alex <Alex.Hung@amd.com>; kernel-dev@igalia.com; Lyude Paul <lyud=
e@redhat.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.o=
rg
Subject: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop warnin=
g for DCN

validate_blend_mode_for_alpha_formats() warns when a plane supports formats=
 with alpha but doesn't expose the blend mode property. Fix this by adding =
the same overlay plane blend modes to primary plane, since they are all uni=
versal planes in DCN-generation. Cursor planes support
ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by defaul=
t (other color formats are not implemented), so only expose support to PREM=
ULTI, which is the default blend mode on DRM.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with=
 alpha exposed")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..a276f3730044 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,8 +1923,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manag=
er *dm,
        if (res)
                return res;

-       if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
-           plane_cap && plane_cap->per_pixel_alpha) {
+       /* TODO: Check which blend modes are supported in DCE-generation
+        * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mod=
e
+        * property accordingly.
+        */
+       if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
+            plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
+           plane_cap &&
+           plane_cap->type =3D=3D DC_PLANE_TYPE_DCN_UNIVERSAL &&
+           plane_cap->per_pixel_alpha) {
                unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) =
|
                                          BIT(DRM_MODE_BLEND_PREMULTI) |
                                          BIT(DRM_MODE_BLEND_COVERAGE);
@@ -1933,6 +1940,13 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manag=
er *dm,
                drm_plane_create_blend_mode_property(plane, blend_caps);
        }

+       /* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_A=
LPHA
+        * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode=
 for
+        * this type of plane.
+        */
+       if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
+               drm_plane_create_blend_mode_property(plane,
+BIT(DRM_MODE_BLEND_PREMULTI));
+
        if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
                /*
                 * Allow OVERLAY planes to be used as underlays by assignin=
g an
--
2.53.0

