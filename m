Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1516C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6BC10F4AB;
	Thu, 13 Aug 2026 17:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WoeISB5a";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3501010F48F;
 Thu, 13 Aug 2026 17:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDZK7E32MdDqEds0/cVDQbEreI5yf8rKGHzDA9kuulKuWrIx8cEmt4Tmio7svJOIKZOUmD/8375cwO0zEVx4Hal+Ex2qeIHyDPMJDwJSJzojwEHDyVQdXdEBDU2T0fuzHk+KW0i2f+JpOzne0j2rbVHMnheW5MXT9YUaNCjCn4XfqFflwp+cjd2ddHCAJSw6p66UP2AdFBXbBpxHzszjh+wSZMvaDqOeuLqW1w390tu+SH0gxgLwG8VEF+fJEkxYz5f9vIuIns2XAHV1xJ4blk30lG0VpTp7PVC/tOQZirQJDtgw6fDIYfwstry6nRschpbN/9CffUXKp+zQ3o4qKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC4jINqteAU/nDt+NtOXoishI7hDW/vZHkTXnJv5C4o=;
 b=i7LggZkTbI2boyUTTu7+71auMgoTJX9Pyrk1MsHEt3vSIWy9SWKz/O6jRFt0jHGWsYUpzrZYYj9M1Qx1RSgI9d8vdVDMudC346WKEYJ6aj0jeGDr+iLZMaDU6rG+kHTcVKgj2/XymCbFOyWahi9nmtvNvk1iqugr/c/6KFcrMByoLrZgALqRNKBJA6ozQ8A1UqZNvaLFiLbL0XHuD1L7kfXx0kyWZNT3CEl7MZLhu8CbMFgAYdu3QRdUwF62UWCKJFITrvE2Z7kYtJ9tDiVilHYO5KcSa3MzNLhXuMt0LhG1EjSalobYQiXEhlp/dhTMkFqdOhNt3XDbVJ2NxzBQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC4jINqteAU/nDt+NtOXoishI7hDW/vZHkTXnJv5C4o=;
 b=WoeISB5arwi/IncWBwqaMZ5dTXDZb5ruyc9Yyw8CGdqLEuKegCduYl/XGX83m1k58K7cpRSV/YSF+CZCmgoGLuTKbXhq0uVpcOKyCmomnIaXQxEuUz2TFRc/IjjzFd+Sd6WY1to7q/s6ePJMs7oIYrIYqVFAMGw7y02kQ2UQoms=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Thu, 13 Aug 2026 17:58:05 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:58:05 +0000
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
Subject: RE: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
Thread-Topic: [PATCH v3 0/3] drm/atomic-state-helper: fixes for
 blend-mode-prop warning
Thread-Index: AQHdKzEqbzG4Q7vesUKMS+novRdU2bacQ+eQ
Date: Thu, 13 Aug 2026 17:58:05 +0000
Message-ID: <DS0PR12MB65342A796015C57DCD287AB99CDB2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260813143605.106104-1-mwen@igalia.com>
In-Reply-To: <20260813143605.106104-1-mwen@igalia.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-13T17:57:45.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB6207:EE_
x-ms-office365-filtering-correlation-id: 6e49eab4-f2a0-41df-b42d-08def9646ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|22082099003|18002099003|11063799006|56012099006|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: YITzajqxiKDO7IGZ8vFHSuZowzcr4EVLbDkgoU0pbFI8Oh6w9MG1S0Ti0nEvg9uYPoiPsq5y5LWCkKT1fyf9ZffZOzzrbBpblX3JJZjUwcSrugRwIu0q26szuPkUFI2calTJ+aP00FRXHcPgW1knlTmNNRzZX+C5y+bFJiOyL6JwMLSt1ZG5kZXnpmiknm1iAe+FF9GlAu1yIM2yekAqfcPGIKkfGWhnYBPbkzpgfkVy8gv8/j/pCf7aHCmiv+LXC9JV2HFkj43QInYW6mutCEKjfkmiKlHA/4KgSRYZZBQVhpaeh5g0PlVS4DETcHQqqInVN03CvhgAXmZRUscxyebTsHehmBuBPN8VVrpI+/LI1HMjnUlCErvwvhiCvHNA4Z0IgBf/TlQGtiCjVNy3mvpIanZ+Dk/Xs16BAdjwLPbUW1Vij0msyESXc0fsvELhP1xdSYe4ImFC5SOKSaM2bHI7gelp0ENtIV8HbdYEWMDeDkWtADMqXGp3CxrofQ4q+e0KTBcg1Ug5tajDyceMv9U9GfTYV0QyhNW/Eu17P+Mr7ecOiMN+Zxl4DNbdlGDrJaSIqfXaEO16+htlamtAUwPwXk/q840v6dwDyKUG/OHzs7TxGE3CMAzbcVoWqsbLWYrQ0UkRKPAm7om9yA7X+3NWfaaEy+jVXT5ve8Iaeeh73hXPdQUGmadW5rq6j8RdbtlWB28ClGrbsZ80EWgkBMadUvPCETqdFTbKqyUqssDO7PDR0nyKjBBcC948uW7C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9t7y4xwT9eix2xtUE40mSpafYbJuwOHQ1oQl4rD6r/7YiP4P380ju8+yes?=
 =?iso-8859-1?Q?DEmQmd/kCy2qG0N7oIijHwOXEVZoyuVHy3YIJ7OyiZxmWfzyLWp3N7ee+0?=
 =?iso-8859-1?Q?pjDPjZWoEgp3Dw85OudptmvkVQGsx/FaKPQPrUeIf5JZoOJlhUpe9RfCBS?=
 =?iso-8859-1?Q?0NpOXg1T/dj+WIQE7qrNH5xKU0kJBHPDl6xiTp5ZMnqDz3U+GCxq+4epDS?=
 =?iso-8859-1?Q?aI9n4MpI/mYjMQy32MuIQtTKMR/drvaHtmZxd8w4EFNVStNojvwb08xw5D?=
 =?iso-8859-1?Q?i//s30QNOeVxqxXi7m2+rpBiubyIb/2vbCIOKhlnCM8l+qP7KjdqZ2/oJT?=
 =?iso-8859-1?Q?IMqon4GEHD4CyYOCfry6EVWGyzFHtl2oTIF3pOErMQWGQhIbm3SY3g86yd?=
 =?iso-8859-1?Q?TEbaTKVk2nCF3I5GDK2nCQ0CgwVCUDnlQW4BK0YGkoNattJF8z4a7bpJ5x?=
 =?iso-8859-1?Q?xUt2GC+XcO4YfxIHecLg/V05PfP5TeDMTzqDM94FyrlvSQvToSL5TR99fQ?=
 =?iso-8859-1?Q?aeQbGNqV/CXCq/7YyMMoWC27xgAx1rQH6mImZqsLRtzq3WnqSbwmCak+2R?=
 =?iso-8859-1?Q?T6JwMef5ZFtYorGz/YGsdg6Ooy48jMQnS3BViHrzX5NlyP5JfntnnZ9TvU?=
 =?iso-8859-1?Q?rTfG202O2ejCoAgdJrqdCBWqKjbEcOH/24peY1Jq/7ooikv/UcWfsjLayW?=
 =?iso-8859-1?Q?pIm3/cF4ZgFIyq2n3iV/1OA5HwmXOMxasvDsBD4JcVhpyU4xweEoUHz3FZ?=
 =?iso-8859-1?Q?qsodSreac8hSkmVcwfR+5IikZhaAaaeVLGDP3SwFxzsbnFhaDaztp59eox?=
 =?iso-8859-1?Q?wH+h/87caN451vf0mBzE4LDPQrY9J8GuSt1+LCoX3Lq3efDKf/PKhrhaU9?=
 =?iso-8859-1?Q?IFjfK91jt/PLdmtfp95OJxuhBjnwQ4SKh6R+K+HjjzQAU05tfsZMX+GNvI?=
 =?iso-8859-1?Q?61hlrxTKAOdzZBDSg7yjdgoqloy2RiYv1t89jdm78QuSMYNmCpNSeH+RJU?=
 =?iso-8859-1?Q?zonOuj3nSZbkKdV2CXe0I5aKOAHXOLESzFOhfMSUCMSZnHfd1pl8Oc+xT+?=
 =?iso-8859-1?Q?70ZYRgRCj39VfJ5M/jtU6bNjr2x8SveNvWEzxHxlgfJHBpwiGeUHSAXps+?=
 =?iso-8859-1?Q?M6pPpiw1jqrofgeFy92fZ3bA4M2E1CQN82ozdGIYxWWcK7HIpSnR9DdL3j?=
 =?iso-8859-1?Q?+ZXCpxIyQ9guWxIN/F8VKcmDykdIfXcs2J3LCotf4KogA9uZAj9T/9anw9?=
 =?iso-8859-1?Q?ONyy2rOcKM1ZtLjNs2njWgjKeVRiJ8M3TCBbMiF8BLkzLsK2poQSzNvNmQ?=
 =?iso-8859-1?Q?u3pW0LdHCPOzYUZPobnFfxJb8GAsCsN34UHvtpd+gRfcvjoc4DWbGKDJGV?=
 =?iso-8859-1?Q?8nPDOcpDt26OgJexw+soHlf0TGi6o8ilj8Yd+fSe73pjvyiW+lYCCVK2qC?=
 =?iso-8859-1?Q?YbakXQ88UsNQqPcuIEIjoCvRI4y1ADhhM2LzGlbqQU+ugelbRE5tGe46BF?=
 =?iso-8859-1?Q?82WYhhNrFc6AIaT//h7UidRUAM63pzIeLvoUe2800kYAUCuzyD7df2mDbx?=
 =?iso-8859-1?Q?S8nGM8KtqOq0vElV20uzym3+DdxI0OMivqrjQ0hl8eyVJX6E5A4VOUpHqW?=
 =?iso-8859-1?Q?0u/WTbt5WYePUSzypwqHD03pP+jxfSUtwokteInPAyWfLKK3EhqgGAsjdK?=
 =?iso-8859-1?Q?g9Hcy6izgCYN2HoEKaVFLJqu2/VfBnHe0U/nrIqK9V/QRI3Nx5GHfHOzXe?=
 =?iso-8859-1?Q?U08nTm8VMizL5msq5TvW8IZl0gja8PkWzAXgjtrh0eIjJO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e49eab4-f2a0-41df-b42d-08def9646ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 17:58:05.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGeAzt5y3gQuSqGoAR/yzW7+WH6Ir8AzYMGzqFaWBFUM+9/gXy3t1yCQBCxn3HHK2sU6C7U5qXSx0mBn7bwINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

Thanks for the fixes Melissa, we'll re-add them to next week's promotion an=
d re-test.

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Melissa Wen <mwen@igalia.com>
Sent: Thursday, August 13, 2026 10:30 AM
To: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>; Koen=
ig, Christian <Christian.Koenig@amd.com>; daniels@collabora.com; Wentland, =
Harry <Harry.Wentland@amd.com>; leandro.ribeiro@collabora.com; maarten.lank=
horst@linux.intel.com; mripard@kernel.org; pekka.paalanen@collabora.com; si=
mona@ffwll.ch; siqueira@igalia.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; tzimmermann@suse.de
Cc: Hung, Alex <Alex.Hung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com=
>; kernel-dev@igalia.com; Lyude Paul <lyude@redhat.com>; amd-gfx@lists.free=
desktop.org; dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] drm/atomic-state-helper: fixes for blend-mode-prop =
warning

PREMULTI was the default DRM blend mode until 9813e158d13d
("drm/drm_blend: allow blend mode property without PREMULTI") introduced th=
e possibility of exposing the blend mode property without PREMULTI being su=
pported. However, __drm_atomic_helper_plane_state_init() still resets pixel=
_blend_mode to PREMULTI (hardcoded), ignoring the supported mode in this pr=
operty. In the same series, 860e748bddcc ("drm: ensure blend mode supported=
 if pixel format with alpha exposed") starts warning drivers that supports =
alpha formats in a given planes but doesn't support blend mode property, wh=
ich includes AMD primary and cursor planes.

For AMD DCN families, overlay and primary planes support the three blend mo=
des, and therefore PREMULTI is still the default mode. So the warning can b=
e fixed by just creating blend mode properties for primary planes too. PREM=
ULTI is the default/unique mode for cursor planes in DCN and DCE driver. Ho=
wever, looks like PIXEL_NONE is the unique blend mode supported by DCE-gene=
ration driver. I don't have the hardware to check it out, but looking at th=
e code I understand that, even if the hardware can do PREMULTI or COVERAGE,=
 the way it programs registers doesn't make these other blend modes actuall=
y available.

Bearing this in mind, this series is organized as follow:

- Patch 1 fixes the pixel_blend_mode reset when the blend mode property
  is advertised without PREMULTI support. It's needed for AMD
  DCE-generation (patch 3) and I think with this we can also remove a
  workaround in nouveau nv50_wndw_default_state() caused by the
  hardcoded PREMULTI default value [1].

- Patch 2 fixes the missing-blend-mode-property warning for DCN primary
  plane and for DCN+DCE cursor plane. The alpha property keeps only on
  overlay planes because looks like this is not supported by AMD primary
  planes and it doesn't affect the blend mode warning we are targetting.
  Enabling alpha properties to primary was also causing -EINVAL on IGT
  alpha tests because it started testing primary planes and disabling it
  (which is not allowed by the AMD display driver).

- Patch 3 fixes the warning for DCE primary plane, but I detached this
  solution from the previous patch because I don't have hardware to
  validate if my assumption about PIXEL_NONE-only is correct.

[1] https://lore.kernel.org/dri-devel/20260720215058.398210-3-lyude@redhat.=
com/

[v1]: https://lore.kernel.org/dri-devel/20260722183240.626522-1-mwen@igalia=
.com/
Changes:
- new patch for pixel_blend_mode default value other than PREMULTI.
- remove DCE11 which supports per_pixel_alpha but doesn't support DCN_UNIVE=
RSAL_PLANE.
- new patch for the primary plane blend mode on DCE-generations

[v2]: https://lore.kernel.org/dri-devel/20260804140758.107683-1-mwen@igalia=
.com/
Changes:
- keep alpha property only for overlay planes (looks like primary plane
  doesn't actually support it) - alpha prop in primary planes causes IGT
  test failures with RX 7900 XT on a 4k60 HP U27 as reported by Daniel
  Wheeler.
- improve readability of if conditions (Alex H)
- add Leandro's r-b tags.

Best Regards,

Melissa

Melissa Wen (3):
  drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
  drm/amd/display: fix missing blend-mode-prop warning for DCN
  drm/amd/display: advertise PIXEL_NONE as blend mode for DCE generations

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 25 ++++++++++++++++---
 drivers/gpu/drm/drm_atomic_state_helper.c     |  7 ++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

--
2.53.0

