Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8DBC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A0010E2C4;
	Fri, 21 Aug 2026 13:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NmmBBHT/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359EC10E2C0;
 Fri, 21 Aug 2026 13:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4ZDKF4IId/xSxUsz3S/SvpNLbrpmuQmKg/FbIC1XZirKodoziIrHnUD3+uVKrYfIUg79xZTbcv0cYhg+pJX8gKGnH31PcmGi7m6CY0xiTMMPRrB2WaZrWo3MmwUJJZhXEMNHz3inNhrD2SsulBC79TBvVDgGEEhB2gtz2ETJOPRIVIGm1rWVn0MB/XI1AcqlicQKP1uqtyokqcDwQ37O0OFaUZaX+IehuQwfF5AA1kJOcNHYcmGT0yJfsq9FSeseXtDb+Y0Wk0msSTkQJ6UxLnJEu/08M2HznO8u/SRn6TLJ/2l4V4+HJG0Uskb1UNyrFFDM+N7v9ac3g5f3u1EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE3UIWqleJWu654rut87Ew1E0aQ7Q1vgsKxROqYPxjQ=;
 b=NnpjmalSObZNdvgXl11YIgLkKbZjp4SMyEoF60jZowP9l0pgy/au2jjN7TLBtkFVly/Fes6tVEWCzjCELLcGjXn9u3+NSMKivAJ9cZTYCSW7UeyawfsylR7OP7s1Uf+NkPpla3aEo2GMm9Eef4MpSOxM5wFWuo1nh0h8p3FkcQBC75HbXFLhdfjcOlsRp6M4JCtwgccb+Zj8gJ18IZB3IDXU66FtIiIaCiJhWX3NPjcqk07YkNyawdX8HffVDRK66wiW3H4i6pgeJvSabWvUT680hFR0Yz2XMUqs8mor0LOxCqOSTAO1UV72/6G4h3iwWMTe6Xjha3LRgPBheon9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE3UIWqleJWu654rut87Ew1E0aQ7Q1vgsKxROqYPxjQ=;
 b=NmmBBHT/4y3snQQHtnxuVAGMGKZm0dX/crBzOTQO7XeQmwrZOd++N5h2V6gV4nmpnR5n9pcUlw/5s6/0Ko3jfhfm1W5zoBLhxikFZL36+XrIyFP1yVtN8X34QRIoBzdr81IYFr4HvQ6T/Hzie/QFcSx/NScRlovH6jbiTD+WFJE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:49:10 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 13:49:10 +0000
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
Thread-Index: AQHdKzEqbzG4Q7vesUKMS+novRdU2baokNfg
Date: Fri, 21 Aug 2026 13:49:09 +0000
Message-ID: <DS0PR12MB65342AEDED0D035DFA92E4189CA32@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260813143605.106104-1-mwen@igalia.com>
In-Reply-To: <20260813143605.106104-1-mwen@igalia.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-21T13:48:54.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ1PR12MB6338:EE_
x-ms-office365-filtering-correlation-id: b1e914e3-2be5-4e02-9cdc-08deff8af9f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info: /mOqgWBk2QNWnaAD04l1Y7r7tOKXnFi9TH6yAM4YX//7+wFq63mxj3IC5yJKNQghbqcegQLpsls5MqqUEVvJ2pv89Sc/AoUm2HTIVlGWDjKpL8mPFnUDfgLAx49OFXMNm6OWt3OioJK4ddpjfQ91tl4Yd8CbSYbyN3JcMmTEZKyufGpmrdMcXOEtUct/H1Q+i5fmquxEwtrYv+4ZYYRfqSVpkFEF2SZToPG8m2H9t8B6DXo3TqPZsx7FJLQmCIRlcPfw4ynEIZVMjC9jkO4l7hBoDKucW5GqaTJ8e1MyNXYjDlOJLzEzOh2rbTYATGwFUBEx/Nw9k3csB+SqqtcBm2FTE+nINURSve0dfSlYiGkLSYyJg8bsSNPqhhIIJPJ/hbukskaGM+JcxXtZdNYtRqDeA4irEC4+x5Z4qaNq45/SAVYDEb352ZkMPB0kVqDrYXxIfDOa+exZLkAVN3EfwnuPCZhv9mWWFQ3qNQTdK8eABTXs3P8RRDD6Wa41fA9k/BqkE6MvacRW/qVzvRd1zLXS7K5YyNj3yClRvjnYGj/gOaiPjqIdrkxjexYmJ5SYTO3IROFhazTH0s2iPzyi1DGUucA8yHWsK2z0091cNmntrR4Kv4JVle4SjBqJceDo0Iworo0T41TuWb+RixAhEPOWWyvlS7u+eZz0ZaK0OE3j9kY2195/sqiQpFjDBsMigjXq+xSkxbc+49lUgPWqjhiBOsIg6p0PaVW5B8Fi96EES35DnE+Tv7ZEH4/9KTGk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hzu3BMdqpd+jzih6MahXDyilq0nD2/rKqD+ab1XbZkLEbwcEy4riF4jdNA?=
 =?iso-8859-1?Q?tEk77NdmD0lm5U2Zxhc0cZYho6QyG+DXD3DUV/bsm7NmLBMyxzwUe4VF4U?=
 =?iso-8859-1?Q?8eje0gpqnUNuV9LRh0dzrmeXwLeHXkBQhKUUwTr34rw3UEZE2NbyqYkWsv?=
 =?iso-8859-1?Q?axKg5qHXAR7veWv9IyIg8v3GtDjzhaba8vEnrvF4yZqE7tAupQ/0sx71Oy?=
 =?iso-8859-1?Q?7vF2ALfd2IuO4d2EFyeAAsyZF6HtTwryYwvPy5R97TCmk/T9251MLVdwUC?=
 =?iso-8859-1?Q?xelM6H7jB8bPyCXu4IPFnD67/xRXx6axYwEEMd9ya64Tkl0efzyRiJSdZo?=
 =?iso-8859-1?Q?SuiIfp/F+bVRiBLb4wSVdp58eJURdd+ZQjmBvMtxAPtqxzzii06G+kVDxX?=
 =?iso-8859-1?Q?Lg0RG1G5snPCQHTayWlVTXNWBIdmZBtxeU1eMDWJhk4obTtm92SEGtkhSY?=
 =?iso-8859-1?Q?qcjCMFPMbqd28ViDfeG9XNGuOFi8poo0pa/A8LIIbiWE9j8tpKLpdXh4dD?=
 =?iso-8859-1?Q?GYvoG7rpKH691rCJzEIKWPwrTb2QQdRBulZqmcys9NVunui4JrrRQP1Joc?=
 =?iso-8859-1?Q?hjfjR1lkcZBfSImoqxRVN5J+0IL69x8AXu3nWrExgOAnmxwna3vQoDvmFx?=
 =?iso-8859-1?Q?xwi+iIh7Im6IK3fA5+gYFHtBGlB0Hl3w2yWxT9UiSk2OIhOP8J9gh6dt1C?=
 =?iso-8859-1?Q?XySpXg8+gaci93lpT3A48C8fQj0YANusir8Sd09dcs/VINFYPtw5pA9EqE?=
 =?iso-8859-1?Q?8G+KiFjkUbIgijw05BOStH5fwuPXfTg1/TgLAGDdE58WfKdNwuk02ukYzy?=
 =?iso-8859-1?Q?yyoQ4sz3cdlM/GI9YbT9HyopLJbqK314CfExnUOB+rLP0fHK1G9l4hwZHv?=
 =?iso-8859-1?Q?f3NTRoTDCRvHL3R3RDKa/0VaXLBl5YaQA6zbWuI+Jne1rQ3tT3Em8bgIfF?=
 =?iso-8859-1?Q?Egoo3E4OBnkvzPZuEd+ZTyBqPE2t828KNUn0MyqtVV/eEBRu8rormL8Zro?=
 =?iso-8859-1?Q?hjQVsqLDjqltLyWBsL2NrRrTLAiPm3JIdzz3TdsrsZJZzbStCLE2K9QpwP?=
 =?iso-8859-1?Q?J/eP6DVS1j82e/XrDplYSckoiqG1DFx7BAadbGwYch8kMrwvF2xEVGFidI?=
 =?iso-8859-1?Q?1sjFWni4vKghVQhTunfd8goU2QHOzrwRnyWaWBITsLIx2EWtnvC3p1YIaa?=
 =?iso-8859-1?Q?qpsJqo7PwroRGwyQ7t9KswBNPlVX7psO+6wDquM/uyDQPhEiWHKqzEAzdO?=
 =?iso-8859-1?Q?2A6rcr8gSaTDytnLUxwSK+iRgRFW5jm5IGiSdVJ+jDbKmqoQhzg8ZcLcV1?=
 =?iso-8859-1?Q?zu/uXUhqOASaRi0oDRfCZLgPzN38vHZ1qQ9sX0ra+/JQpphBePsNLmOq5i?=
 =?iso-8859-1?Q?kR+bQAjschNgSS9C+vE9k1iwDh9QWL901EGJjFDoaqfjF6borJB0Pd5LKn?=
 =?iso-8859-1?Q?1jgZsGAfy0Umu7Qvv/J+/jMKKaRC+PN/wpNiSfyBTqYmTSDoI9krQJbW7k?=
 =?iso-8859-1?Q?XYeVzjTnbXcjD5UQd0x92/Hdq3zLC7beTtNC9p0ozE6BrqhZe8i/nfMvEQ?=
 =?iso-8859-1?Q?ValVoW+L2m1dVtcMdSXhigmL0+YWGXVbgyqf6a8XzESG8D1aoceKcplkNW?=
 =?iso-8859-1?Q?znIdFiICLK8MZMRwmOs3q1eNR8EhCV1GJZF0qiv9xhJL8GfhOo/omH2Yte?=
 =?iso-8859-1?Q?B3zxhflkOKDEWxpBvRMXt81gHrfCKgPOHSktausbX3PbsXpIXJKgip6qaC?=
 =?iso-8859-1?Q?dfdisI96WlXHNu7QqJiNvT9M1LwrghMuhIZioCbQOzeXSl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e914e3-2be5-4e02-9cdc-08deff8af9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 13:49:09.6983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMJs+rXKU4470egFO6+dqp0GAtyzXaI5owOELJoFSCr5Q8jbpRe/B2cRqFrpkijqgwAZjN2QqThKjUMZz8x6NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

Hi Melissa,

The updated patches passed all my testing this week, so the tested-by can b=
e added if you'd like.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

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

