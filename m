Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38D0C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4332910E39F;
	Tue, 15 Sep 2026 21:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GOcUHjdE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7CE10E399;
 Tue, 15 Sep 2026 21:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIfG5NB5DeNFS9MB71DoslR65r8WQ/c/twc9zvJD26OT0R7HUe+8SXHcPBeApUaynxihQFuqFNqxgN6MJp9jIbCWdie/pR8I4Oqfr0e4sYg6KPfGCqXUoc7uGbXRFJCrF0NLtZWsNqeeqaJiAwccEzWy53/8wC0AOWJP2gUK1eVrV0GVU8Tn6Wgy6bUFJnrt8+RfLqDG1NI5bIxOBt9qCZhhza6kRkZ6X5coqGvdD/NEvQu8SKsStlKr5Rfj1a2A5Re+7gD7+WReQBa+VYqLcMq1PI5vQlZIqMuLxqmZpPC51KfLkRfSW2A1DonYyZrHo1DTD7nc9oNqqROq0O1lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DHNRhKwaV+qVoPNL2Gtre2H8dGZGhvalJBlRwJQ6M0=;
 b=LS2G+1y8bgfVT8eWkxJASKmR1AwXdFY30yH3cQZk1d8onnV5hZn5OuMXwY884Ouq4KvbnJ8UfG4UUeNSdMQRm8F1I3iPeb9i+2U56NKPeXAiXklGlI26dE1A3wP19fAobopSSqNpky/aZdc3AwVXZc7bbOz7E2HcJXXH8vFO1qtHH6/ca4kjbd+Q2ZGghVu55AuPpuYgmVOLKi9LoV4AijRmJnuhHlFwedjcTVxmpgPeVCMj4/F+SK0KhuPEIi57qbnEJ0fk3UeyHkRzCOP7b1dZgq+pzC3ai8GtDkDJCl3EX2EAS1HD08yycmAra8bNmolKnEcZgppAbrECgYwyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DHNRhKwaV+qVoPNL2Gtre2H8dGZGhvalJBlRwJQ6M0=;
 b=GOcUHjdEBMs2q40D2Xg8m5iJIdmEfFOipa12QJPw2aFxIPu8auJASwN4PatVuwVdfCH/86sArWx3owBsElLJtGnG0m1P/Z8f8ikjKDNSCAlAW4Jr16C0taWI0lrsE+NFVj2YPW37Vv6Z4qwnOJxB4at+gQqSk2iOCGJnEDG0mw0=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 21:31:02 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 21:31:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Hari Mishal <harimishal1@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Jiawei.Gu@amd.com"
 <Jiawei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drm/amdgpu/atom: bound the VBIOS date, part number,
 version and build getters
Thread-Topic: [PATCH] drm/amdgpu/atom: bound the VBIOS date, part number,
 version and build getters
Thread-Index: AQHdRRRX5M9USUK5+0O0nchBSuBZq7bQJckv
Date: Tue, 15 Sep 2026 21:31:01 +0000
Message-ID: <BN9PR12MB514604988D937F189E3F772AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260915131548.28292-1-harimishal1@gmail.com>
In-Reply-To: <20260915131548.28292-1-harimishal1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T21:31:01.214Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS7PR12MB5718:EE_
x-ms-office365-filtering-correlation-id: e3ee10dd-1b29-406f-a60e-08df1370a435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|8096899003|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: W14uOGx8El7JfC8yeiRL8nNk+MGOmjSie8fzMZoQ4tXvWuORgr0fppLvbqOopWGAhsXgCWjPPTtCtvnoYPKmD+GlC4dyrL0kU0YFoWDmx1DN1q9xCzj06yd3npuxcH5bSYyRMlyYZM1E04YZlYgq9UgvsbrOHSQ2koAJ4svJOxU5xNIb0Kl4pex9LsgeAHQFwB9cBoNVfeLImCS4FsmwlrRYR3mxIE7EPjh8RRYCVVaW5ydIfWoGn1Y+9TqdElef8EKSG+mD7+OAs+A6eRw1Lh1Owdoa9kHwH38r3PxCZMKRAmiiw9PrzawV40/UfbmOvPS3OvyB2lSiUpTZQzqRqPOVEfploM4JIac5vCaAqsLTAjN9BEAeG0CBVH/7hk8YsKLaPXbxFAvu9m0MCC+bcqMDRbg7D9+xRRMV7Supm0+AVgx7zTckQyX3xx1xCK0nafH3/bKQ1Gz/xAgOVKbLPe+HQgHI18Q4IAERm0/QUzLPynIxcDe/b+SngRJ3lbjSjOYf/Nsjes1r8l+c+BmQKJTu8z1Thy/fzTOuNPotUGZvevEoDv5CAbJmGE9Jw+EAP86h9ubnsUHJ1H2hWOfeIYO/HquJv1Bvi2nz7Id8ZnLq5cTab6wCU2Oivm+dMdA3xTYRbAHpa6QnMJeuTkEnqbIW41zYIamYRdeEQnhvqJ8d6PjgENKlJ/cMgPJi55l6ei0rCD/5VsyNjTQ84hA8uhFlHw7T4Np5g4NaNaCbUIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(8096899003)(38070700021)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kK22dQ6HqlLI8dcTMG+jDx7Za7WS4og2jTFT+ivB0toEGoZJEMSKffWy3u18?=
 =?us-ascii?Q?5Zt2G9KIhFb7zIlv4Xs2PeHEZcCNbmx27DIt4hYmxb5WxJk01/7rqk6BMhEd?=
 =?us-ascii?Q?8XNj1oBYp0hflKH7TG69zYDYEk4J6qqLXO743fEvdoAknzwZ9MVYMCEticu9?=
 =?us-ascii?Q?pK/uVdVm5Rs/jzX3OvZGQ+TSTXBoA8JLL0aNkzqxPw2NpwCSEVW8MdUwSiYH?=
 =?us-ascii?Q?30x/t47ctVwG446503fo2LQGPVaL6JIasSnjz0eYQg9fwCWvrATsAi9Q8oS+?=
 =?us-ascii?Q?0uw3LOniWtBbcTCI/xVsaRxP0gHV0ZdBoxW40iv5Jme+JXTuEa4wslm3QzU4?=
 =?us-ascii?Q?6i1TR4AuGTuL99NMA0bRFBabm7/Uw6C8OmduPnaiZtya3JXUmheUWuUloTZj?=
 =?us-ascii?Q?rn003/oqySmWK+NyjBYQZ50ZFB4HgsVtXJu3pSly8eIwGr5z2+endfpzK6wu?=
 =?us-ascii?Q?1X2i8GIDwATAtZI8ogAxAfHIrnvp9HmsCXTfilQOv+MAEwG0LBAuFSF6gSJZ?=
 =?us-ascii?Q?42pxwLQ2oscKMzqqE6M4Pxu5ZVPTA/SxcnbQ4aq65BlANZBMm0pMsGCf4kw3?=
 =?us-ascii?Q?eNELSMGsFAO7MgP00JdvUsLpyxUnDCSvOd+ZUg95vr+IPuZXziuu4HiZG9HU?=
 =?us-ascii?Q?BT4ECtA1IBLsou+GWf6lgIDWOdbYsEb8FSbAwg8qS92GnuXVyXBUuiokf8MI?=
 =?us-ascii?Q?pL6cSnnYdjmDjgcPDlZdAM9GgatOz+edw4Q+lvqC+WzJ8JOwgNKKqnyjvT8Q?=
 =?us-ascii?Q?z9pjhTjhgXgJYXawG3frBn8HIcbvwf5xSn85+3P7R6ppjEzvwFEGE9XKOmex?=
 =?us-ascii?Q?1S7+ehbSa/Ac6uenXpeKEN4KIUHIwPI7NSyij/D485UpiAHIOjZpcK3Za2uD?=
 =?us-ascii?Q?2AgM/en76MGnZuSQipjcT4whQCztCOP0wobzjFPrEceYuQFGtOEFJ62mmi0i?=
 =?us-ascii?Q?07vK6wTxNRwks2u99sMr1NwiQAIRuT2KZobe13KWrDs/TCVqinQlelxiAOQP?=
 =?us-ascii?Q?l/vNkA8Po7mRe9dQZVt2RI2ac9nBlynVw0R4MK7o2mAFMCqrX6Giu/ar6UUH?=
 =?us-ascii?Q?IhDmXrsPFa46WGa06Jpsrk7oR+5XNmNem8PJkh+UbgMfOM+HVzZqFSP7QIL6?=
 =?us-ascii?Q?zGf/fnxkbCXtecvZvjcS6NmDpCA6DK+8qgGNOJnIu4FrINbpyuPpoIp4YYJ2?=
 =?us-ascii?Q?htoZnAn7WFf1NHgEasWXIa4X6avaARRBwBbXzeQQrmhK0aGUsQWXPX6PcMNB?=
 =?us-ascii?Q?M6i/wnHbWG+t9DNQ1Bh2xbXwljQuRYZ8ZE5JDcFFX5aaNT1xfPdOJ22F33Q5?=
 =?us-ascii?Q?NyYavCl9XAQFrnvyDtWYZto5qIjp0KhegX7qAP8ccnqXU8rOveSSHbmRXk6I?=
 =?us-ascii?Q?WfD92wSwciAdcxbBvICgORWt2jn+Sx40CpJeiKMIu37HxRLXtOpebnBLDHC0?=
 =?us-ascii?Q?RuRtTeNbBAsuTD1aX4PXnerEIHqj02ITok3tYMVw5Xt6hH5E/vpwIXYRxzYQ?=
 =?us-ascii?Q?5+MmLoyvuV1SE/BIZg4TMc2mJlrnAcfkVLzS2CzOUlwTQi4yjv5HlS7EvSST?=
 =?us-ascii?Q?vcXnwEyNoVRB1XVpafiT5O0pAKk2L+pBAA75oSASk9T7fYMa3arnOW47PPo7?=
 =?us-ascii?Q?zCBcjtqsoFQFb4IdTlFgfUrbx5BIHwtA4V0qn2iynfRyPptz0Lu+MPHA000r?=
 =?us-ascii?Q?hXLhd8+GpcQN/FlGftlSNXpzgp7mY5Uel6X79gVAr5vP4+Bl?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB514604988D937F189E3F772AF7BA2BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ee10dd-1b29-406f-a60e-08df1370a435
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 21:31:01.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyZx904obS9aE/wTzhX+8RCvk4F8j7J7sa82KtNVO06eBCYv99NpsAWNlYbshfUHXV3UvGNxQpGZKSlntRyqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

--_000_BN9PR12MB514604988D937F189E3F772AF7BA2BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Applied.  Thanks!

Alex

________________________________
From: Hari Mishal <harimishal1@gmail.com>
Sent: Tuesday, September 15, 2026 9:15 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: airlied@gmail.com <airlied@gmail.com>; simona@ffwll.ch <simona@ffwll.ch=
>; Lazar, Lijo <Lijo.Lazar@amd.com>; Jiawei.Gu@amd.com <Jiawei.Gu@amd.com>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@l=
ists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; gregkh@linuxfoundation.org <gregk=
h@linuxfoundation.org>; Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdgpu/atom: bound the VBIOS date, part number, versio=
n and build getters

atom_get_vbios_date(), atom_get_vbios_pn(), atom_get_vbios_version()
and atom_get_vbios_build() all walk the BIOS image using offsets and
counts taken from the image itself, checked only against each other
and never against ctx->bios_size:

 - atom_get_vbios_date() reads 14 bytes at a fixed offset that
   check_atom_bios()'s minimum size (0x49) does not cover.
 - atom_get_vbios_pn() dereferences an image-supplied u16 string
   offset unchecked, then walks and copies from it with only a length
   cap, not an image cap.
 - atom_get_vbios_version() takes its search bounds from image u16s;
   atom_find_str_in_rom() already clamps the search itself, but the
   match is then advanced by a fixed 18 bytes and STRLEN_NORMAL bytes
   are copied from there with no check that this still lands inside
   the image.
 - atom_get_vbios_build() walks from an image-supplied config-string
   offset toward the ROM header; a config offset at or past the
   header makes the pointer difference negative, wrapping through the
   u16 'len' and passing strscpy() a bound far larger than the
   32-byte destination.

Bound each getter's reads, walks and copies to ctx->bios_size, falling
back to an empty string on a malformed image.

Fixes: 29b4c589b43d ("drm/amdgpu: Add vbios info ioctl interface")
Fixes: d6fa80266178 ("drm/amdgpu: Add vbios build number interface")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index e74253682929..fe9af26ccc11 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1445,6 +1445,11 @@ static void atom_get_vbios_date(struct atom_context =
*ctx)

         p_rom =3D ctx->bios;

+       if (ctx->bios_size < OFFSET_TO_VBIOS_DATE + 14) {
+               ctx->date[0] =3D '\0';
+               return;
+       }
+
         date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;

         ctx->date[0] =3D '2';
@@ -1513,17 +1518,24 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
                 vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
         }

-       if (*vbios_str =3D=3D 0) {
+       if (vbios_str >=3D p_rom + ctx->bios_size)
+               vbios_str =3D NULL;
+
+       if (vbios_str =3D=3D NULL || *vbios_str =3D=3D 0) {
                 vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, =
3, 1024, 64);
                 if (vbios_str)
                         vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
+               if (vbios_str >=3D p_rom + ctx->bios_size)
+                       vbios_str =3D NULL;
         }
         if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
                 vbios_str++;

         if (vbios_str !=3D NULL) {
                 count =3D 0;
-               while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=
=3D ' ' &&
+               while ((count < BIOS_STRING_LENGTH) &&
+                      vbios_str + count < p_rom + ctx->bios_size &&
+                      vbios_str[count] >=3D ' ' &&
                        vbios_str[count] <=3D 'z') {
                         ctx->vbios_pn[count] =3D vbios_str[count];
                         count++;
@@ -1556,9 +1568,10 @@ static void atom_get_vbios_version(struct atom_conte=
xt *ctx)
         /* find anchor ATOMBIOSBK-AMD */
         vbios_ver =3D
                 atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start, end,=
 64);
-       if (vbios_ver !=3D NULL) {
-               /* skip ATOMBIOSBK-AMD VER */
-               vbios_ver +=3D 18;
+       if (vbios_ver !=3D NULL)
+               vbios_ver +=3D 18; /* skip ATOMBIOSBK-AMD VER */
+
+       if (vbios_ver !=3D NULL && vbios_ver + STRLEN_NORMAL <=3D p_rom + c=
tx->bios_size) {
                 memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
         } else {
                 ctx->vbios_ver_str[0] =3D '\0';
@@ -1574,7 +1587,13 @@ static void atom_get_vbios_build(struct atom_context=
 *ctx)
         base =3D CU16(ATOM_ROM_TABLE_PTR);
         atom_rom_hdr =3D CSTR(base);

+       if ((uint32_t)base + ATOM_ROM_CFG_PTR + sizeof(uint16_t) > ctx->bio=
s_size)
+               return;
+
         str =3D CSTR(CU16(base + ATOM_ROM_CFG_PTR));
+       if (str >=3D atom_rom_hdr)
+               return;
+
         /* Skip config string */
         while (str < atom_rom_hdr && *str++)
                 ;
--
2.43.0


--_000_BN9PR12MB514604988D937F189E3F772AF7BA2BN9PR12MB5146namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Applied.&nbsp; Thanks!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hari Mishal &lt;harim=
ishal1@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, September 15, 2026 9:15 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> airlied@gmail.com &lt;airlied@gmail.com&gt;; simona@ffwll.ch &lt=
;simona@ffwll.ch&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Jiawei.Gu@amd=
.com &lt;Jiawei.Gu@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@l=
ists.freedesktop.org&gt;; dri-devel@lists.freedesktop.org &lt;dri-devel@lis=
ts.freedesktop.org&gt;;
 linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.org&gt;; gregkh@=
linuxfoundation.org &lt;gregkh@linuxfoundation.org&gt;; Hari Mishal &lt;har=
imishal1@gmail.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/atom: bound the VBIOS date, part number,=
 version and build getters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">atom_get_vbios_date(), atom_get_vbios_pn(), atom_g=
et_vbios_version()<br>
and atom_get_vbios_build() all walk the BIOS image using offsets and<br>
counts taken from the image itself, checked only against each other<br>
and never against ctx-&gt;bios_size:<br>
<br>
&nbsp;- atom_get_vbios_date() reads 14 bytes at a fixed offset that<br>
&nbsp;&nbsp; check_atom_bios()'s minimum size (0x49) does not cover.<br>
&nbsp;- atom_get_vbios_pn() dereferences an image-supplied u16 string<br>
&nbsp;&nbsp; offset unchecked, then walks and copies from it with only a le=
ngth<br>
&nbsp;&nbsp; cap, not an image cap.<br>
&nbsp;- atom_get_vbios_version() takes its search bounds from image u16s;<b=
r>
&nbsp;&nbsp; atom_find_str_in_rom() already clamps the search itself, but t=
he<br>
&nbsp;&nbsp; match is then advanced by a fixed 18 bytes and STRLEN_NORMAL b=
ytes<br>
&nbsp;&nbsp; are copied from there with no check that this still lands insi=
de<br>
&nbsp;&nbsp; the image.<br>
&nbsp;- atom_get_vbios_build() walks from an image-supplied config-string<b=
r>
&nbsp;&nbsp; offset toward the ROM header; a config offset at or past the<b=
r>
&nbsp;&nbsp; header makes the pointer difference negative, wrapping through=
 the<br>
&nbsp;&nbsp; u16 'len' and passing strscpy() a bound far larger than the<br=
>
&nbsp;&nbsp; 32-byte destination.<br>
<br>
Bound each getter's reads, walks and copies to ctx-&gt;bios_size, falling<b=
r>
back to an empty string on a malformed image.<br>
<br>
Fixes: 29b4c589b43d (&quot;drm/amdgpu: Add vbios info ioctl interface&quot;=
)<br>
Fixes: d6fa80266178 (&quot;drm/amdgpu: Add vbios build number interface&quo=
t;)<br>
Assisted-by: gkh_clanker_t1000<br>
Signed-off-by: Hari Mishal &lt;harimishal1@gmail.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/atom.c | 29 ++++++++++++++++++++++++-----<=
br>
&nbsp;1 file changed, 24 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c<br>
index e74253682929..fe9af26ccc11 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
@@ -1445,6 +1445,11 @@ static void atom_get_vbios_date(struct atom_context =
*ctx)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_rom =3D ctx-&gt;bios;<br=
>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;bios_size &lt; OFFSET_TO_=
VBIOS_DATE + 14) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;date[0] =3D '\0';<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; date_in_rom =3D p_rom + OF=
FSET_TO_VBIOS_DATE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;date[0] =3D '2';<b=
r>
@@ -1513,17 +1518,24 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*vbios_str =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str &gt;=3D p_rom + ctx-&gt=
;bios_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbios_str =3D NULL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str =3D=3D NULL || *vbios_s=
tr =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PRE=
FIX, 3, 1024, 64);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (vbios_str)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vbios_str &gt;=3D p_rom + ctx-&gt;bios_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str =3D NU=
LL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL &a=
mp;&amp; *vbios_str =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vbios_str++;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_str !=3D NULL) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; count =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while ((count &lt; BIOS_STRING_LENGTH) &amp;&amp; vbios_str[coun=
t] &gt;=3D ' ' &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while ((count &lt; BIOS_STRING_LENGTH) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str + count &lt;=
 p_rom + ctx-&gt;bios_size &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str[count] &gt;=
=3D ' ' &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_str[c=
ount] &lt;=3D 'z') {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&=
gt;vbios_pn[count] =3D vbios_str[count];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=
++;<br>
@@ -1556,9 +1568,10 @@ static void atom_get_vbios_version(struct atom_conte=
xt *ctx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* find anchor ATOMBIOSBK-=
AMD */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_ver =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start,=
 end, 64);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_ver !=3D NULL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* skip ATOMBIOSBK-AMD VER */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbios_ver +=3D 18;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_ver !=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbios_ver +=3D 18; /* skip ATOMBIOSBK-AMD VER */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vbios_ver !=3D NULL &amp;&amp; vb=
ios_ver + STRLEN_NORMAL &lt;=3D p_rom + ctx-&gt;bios_size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(ctx-&gt;vbios_ver_str, vbios_ver, STRLEN_NORMA=
L);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx-&gt;vbios_ver_str[0] =3D '\0';<br>
@@ -1574,7 +1587,13 @@ static void atom_get_vbios_build(struct atom_context=
 *ctx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base =3D CU16(ATOM_ROM_TAB=
LE_PTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_rom_hdr =3D CSTR(base=
);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((uint32_t)base + ATOM_ROM_CFG_PTR=
 + sizeof(uint16_t) &gt; ctx-&gt;bios_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str =3D CSTR(CU16(base + A=
TOM_ROM_CFG_PTR));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (str &gt;=3D atom_rom_hdr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip config string */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (str &lt; atom_rom_h=
dr &amp;&amp; *str++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB514604988D937F189E3F772AF7BA2BN9PR12MB5146namp_--
