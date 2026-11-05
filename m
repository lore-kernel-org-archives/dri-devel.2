Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A606071F85
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Nc0ErA0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ACD10E162;
	Thu,  5 Nov 2026 19:49:20 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B921910E162
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgOiPmzHnuq+WlWa6B6aOpwTN4Irp/8Xix0EE3pQ7zzhCBpXD39btfgBkiJ4TIkW3vThbnZHWVvMVr9TQxWmsJo/brFZtkAFsdlRdTIPHSXJivj8PbxTuYR4oIsyb7lmo7Xk/zGYeyRO0Qtub58qLQ5X5q49BF380hb4y20lvSm1jnEuHE6j47sEGvCBmexqeWBdvGC2QkAQ4pw3JmKOAEgKtaExjlVV2jCJeJkSI3QNX6GIFQ5Eg6fIvsVCJpZkwnEzTqLT3VDa9yk80bKvBeZPLC5DAQ1yn23JeiiVHvFjDxvYRdRlwGmhFQfCYFqdgeSl81CZiGywe+7FZ6nDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmTY10+cDLzPxqhsc7dWV1nt042XSBu4V78R1DYmcBI=;
 b=Hn1SB7PpdqzKjg2Fr5qXV6juchZKARtqkHBetS37hIJxaeZFd4cne2XPMi+6eWyaawM8KJUq7ziM41AVNRbsT66NJL/ItM4uoDKyiz1PqyApxMKXdvR/nxoH/iOOzfl0830LXV3uvoK8FatIUcOXfsYNN5YnNUtF5SmyUIKUwOeJbeSOqAtE8FCpkILpw1CdS9qq+ilFzatPsDusrE478KKWL5qfMJ74fHHqEYNKgSheWbKjFWeVYub8vjc263OxTpp8lloi2pnIrscC+1AmS5dX9tPbvLprk/xnOCSQsNDzOpc3HarWXr6gf+8E0Ewf0dv9MFTQtheKahWJzyxgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmTY10+cDLzPxqhsc7dWV1nt042XSBu4V78R1DYmcBI=;
 b=Nc0ErA0uPyQ+drMQhH1oqgpOP7+f26wF9LC10Z+sdxyvrJL+GgP95ee8LbkTsFvFcUHhQAmAwnXQ+yFBr1qt960v2yEoa7iX+vDZlAgwSeJhUZor3i0x81jWFftefNEkpmvSFdzlngIlLjnFxrdH1X+MMPBDv6+a8WUven8mlcY=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by IA4PR12MB901606.namprd12.prod.outlook.com
 (2603:10b6:207:12a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:49:11 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 19:49:11 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Topic: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Index: AQHda6ubaDmCLQE7Nk6ic8o597M3OLcfVaOAgACLBWI=
Date: Thu, 5 Nov 2026 19:49:10 +0000
Message-ID: <CHAPR12MB999247EFCE060F1DA5575E0381EF772@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261103155411.3305376-1-David.Francis@amd.com>
 <ab5eeb46-f119-4430-9f91-e530a74f036c@igalia.com>
In-Reply-To: <ab5eeb46-f119-4430-9f91-e530a74f036c@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-05T19:49:10.270Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|IA4PR12MB901606:EE_
x-ms-office365-filtering-correlation-id: 48591786-c3b7-4ea1-0841-08df3b75dca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|38070700021|261021123027099003|11063799006|4143699003|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261026140227099003|261009221227099003|56012099006|261021121427099003|261009223027099003|261102130727099003;
x-microsoft-antispam-message-info: vq8nzn/ip/ujZsZFkVQAwoeWe6JqdUi0ZpqlY25a2HWXW4V7e+9VB3rFcXm+RMLxn+hSFFsUpmQoPjEF+k5I8hD+i0JYn/TSUODeKhTkxpOniDVcgYY3mId297N5q53ugQhwkopXAgR7EKypEhzFmy0dSD4B1bWlp6CTJ8rUAAsK8lpKtFpdMDOYcdYyzuuLDllpE4GhMRghA9RYhZBY1Tp89F8knYvEpj+18Nmon9binhHnd934jWU9lpOL29B1nXmbzCRtI5a5+Rg69QttQQd1YKWBGC7S0hlki17EFK+EFhrfJjLsOtmWKfLeYJf0lYjnZemk97xkFHB19tvARl+OKEC5hI1Yuu7pGbrQQD5jGjijXZclYY+H7YoaGXULh6Eb+BLJeysTByw68l9NvbRYrydYscr222oC+1r4sy4TBogS+jTMhqDEKGWUH4C3WgF2DCzYh2RRiyWKgwzaJPYTstfduAablfiB7vGqvTJF55q1+iifVbZHnfWVGQmMr9beA+Yl8WZAmzBJT79MDUZxzjRMMtW3KOgoslqTZYHnTwhES3qMICKkBhIwF7nc7VZiH0sIrszBUdTgLAjJR41whXP9isSRHrY/E34MO6lzqCTw16r8RrT1xWGifE5TXaiZjwuJac9H6D+/9QKljMd0c1plparO7VvOold06IBxoynqKc3QwwDjNcF/28tu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(261021123027099003)(11063799006)(4143699003)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261026140227099003)(261009221227099003)(56012099006)(261021121427099003)(261009223027099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PnV6M1Dv79H/pUmYzuKT8+WXAfQOQ0BvZSPxIwingXmA31GkNnrLJtjaZ6uE?=
 =?us-ascii?Q?Wj9dR9cCvptOU7uvxPw6RTlaN8oTaK/hldnA9/LUSU8Tu4xdhncRLVS3OBPL?=
 =?us-ascii?Q?aVLMVaTCdcaO21IK02JrOrSSADpN+Hzj1msz2bDb0MH9nHgHgKLDh1xvDLx/?=
 =?us-ascii?Q?Kx9qyLbJOddX1XFodrOJtWDvbvYEDODDvRbkQ0Ahaq7G/eGcPsDMqNgZf5iG?=
 =?us-ascii?Q?83G2HIeTr/443IOsWIVEjQx6JqOqvqwKXLZ/mLMMe40+byaOuOybs267qOpS?=
 =?us-ascii?Q?YBkyDE24LABVmRwp3WXe5M9eP/vOtqxxRvfMRdvqVNBPXBQ4fRjh7+aVC+Zz?=
 =?us-ascii?Q?lWQKTTjrMW0jX6GWw0Dqfhl+fjXxRRyoIa7WGadHwub0vv2RFZYCnkRmpwtr?=
 =?us-ascii?Q?VS9LkMoFQoPKhteHbagyFMcDcneK+CVbqjH+xAATQzYj/pvWzTVjjpiDQ3h8?=
 =?us-ascii?Q?trIc5qFgJOYdIwgcpxGOASWSFbvsaLldDcqgNqXdv+h6168lUt/W4hqAXQSm?=
 =?us-ascii?Q?0aBtDliJRTx4r5rf6JeUfBw7T8VfE46exO3yX5ALQVfmV9DHCVpSRCrZ1Z3k?=
 =?us-ascii?Q?c0/mzzkYIzabHsCtqJEN+vsAYR7VsrEJllKWVV3HiZHK9TbNzC4Y9enfW51q?=
 =?us-ascii?Q?JCSdrwzHVZ54eWjUYxLAEXA8KRui9fkrHNC3o/p+BZkho/5WPikwbAooqpZy?=
 =?us-ascii?Q?2vff7ey1/0iES8YHEx90wA89FloYIWbB6qDx3d16B5FM+zz6ywg3lqNTX+ag?=
 =?us-ascii?Q?RHptaxg/I0+93CKpL1h+L5KYWx8EM1d/UrbU4YEKJSiqSvdoWhzVZt5TtWjn?=
 =?us-ascii?Q?d7cy8GaD0vT6MrBo/aJ/YJaeKCz811vf5X7Fr1spgSyd9ts+miqEo2EUSdXF?=
 =?us-ascii?Q?wMkGScOELmwuuEr4ET+/s5Z34gxpxgSQrhXKNmRhB7t3BKkBe8rTVyaJOUXS?=
 =?us-ascii?Q?2ORkEoS3vbtVpUWKHqLg+RHqkFR50RuaIS+X6CJtdoquyScbn9ep5PA3mTNw?=
 =?us-ascii?Q?VEwPqVtF83PERkntoH25DeQLCprje0SYQSRvD7t49iAkN4NVSwK7weWSGaso?=
 =?us-ascii?Q?ZRDxqS/WgaA5QbM6/VhtfQnIPvmIq+yJmV3MqYe6hFDKRU9Vi9G21jHlNcTS?=
 =?us-ascii?Q?TMhaHwAFedyxh9Vhc0pH6mi2VBV/pw4Unh5Zl9PiVihwiZxViJ7+Dy9Nc6zp?=
 =?us-ascii?Q?wdTivgDeV1fMlPpMsgl1mOFAI8f3ysbvWUYyZs53x00zCkEgO2WNI2Fc+rvm?=
 =?us-ascii?Q?tSknN+p/a/aQXxH5dH841jmDwoSV82J2+WjhDpFai425h7zNDhnDQHBonn5C?=
 =?us-ascii?Q?nV9fEgaFANm28R9K/YiWZTvaOTZDp2QV/Cn1V5BUI7NyFhpuDLZcFDgIckQs?=
 =?us-ascii?Q?unPPSowwORrfjmPkvi7jTYX3aqyWETGHnm3eXg0ERVXRnij2ivcn4OxuiWsH?=
 =?us-ascii?Q?3J2Ca831KB1E+bh1PKVtUtxYPCAN4eCvdDP4YV77YvRzapy8RJzHovvwc8uW?=
 =?us-ascii?Q?xsCrnQJ5Le4P7KzE6NDUS3+vk14tlCW572bjsnxrQH6L2EYx+Im0AtfuH/K6?=
 =?us-ascii?Q?Sau4prEbsCNaBZ3clBF4SEzG3Kxmvi8zzBbNPxvtKDHnOko2pjPLDyThwImh?=
 =?us-ascii?Q?t49DBqTWFjqNdCcMIH/vs9ltfLr8rOskrsOiQWzktfd5QVVSh2Dgy8K1XXfQ?=
 =?us-ascii?Q?uoitg1QMQzCOEiDA4a1Wjd6/bGnFfL7NAE96HLH4MFofEgQi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48591786-c3b7-4ea1-0841-08df3b75dca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 19:49:10.8517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjY5SoX/tdT+kSUax1bf/xkJo2lp27x2h0g6jB4ZEjPHAmThvGewZEAQtpBeSpLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB901606
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>> +     if (new_handle =3D=3D 0 || new_handle > INT_MAX ||
>> +         args->handle =3D=3D new_handle)
>> +             return -EINVAL;
>
>I'd like to open the same discussion point that I opened in the
>corresponding IGT. Should we or should we not check for INT_MAX here.
>There I wrote this:
>
>"""
>About this one I am not sure. Is it not implementation details as long
>as the uapi for handle is u32? Let say someone converts to XArray one
>day and then we have to artificially limit that to s32 just so
>gem_change_handle can keep working.
>"""

uapi is u32 but idr only does handles from 0 to INT_MAX. I think it's
correct for this to be an error now; if the interface one day changes
such that INT_MAX < handle < UINT_MAX is now valid, I think we're okay to h=
ave
some cases that were once errors now work (that's what happens whenever an
ioctl adds new flags / replaces padding with new inputs).

>> +     ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle,
>> +                     new_handle + 1, GFP_NOWAIT);
>
>And here I opened a point about what happens when target handle is taken
>(again in IGT review):
>
>"""
>Hmm.. this is actually leaking the wrong implementation detail of
>idr_alloc to ABI. ENOSPC is "no free handles". It feels it would be
>better if gem_change_handle returned EBUSY or EEXIST for this case so it
>is not conflated. Thoughts?
>""'
On balance EBUSY is probably a more accurate error code for this than
ENOSPC, I can make that change. Neither is perfect? "Busy" to me implies
a temporary use of a resource, but this is about a handle which is persiste=
ntly
being used. EEXIST has the error message "File exists"; I don't know whethe=
r it's
used for cases like this is practice.

The definition of these error codes seems pretty loose, as long as it's dis=
tinct from
the other error codes this can return

David Francis

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Thursday, November 5, 2026 6:12 AM
To: Francis, David; dri-devel@lists.freedesktop.org
Cc: Koenig, Christian; Simona Vetter
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE


On 03/11/2026 15:54, David Francis wrote:
> Make the following changes to CHANGE_HANDLE
> - reject new_handle =3D old_handle with -EINVAL
> - idr_preload before idr_alloc
> - reject new_handle =3D 0 with -EINVAL
> and re-enable it.
>
> These changes are prerequisities for the enabling of this ioctl, which wa=
s
> disabled over security concerns and the lack of IGT tests.
>
> For a summary of the saga so far, see
> https://lists.freedesktop.org/archives/dri-devel/2026-June/571890.html
>
> I hope these changes leave the ioctl in a spot where it is safe to
> re-enable. There are now igt tests covering all corner case behaviour
> and race conditions between change_handle and itself, create, free,
> import, and export.
>
> The new_handle =3D 0 and new_handle =3D old_handle corner cases
> are now -EINVAL as recommended; these are covered in the igt tests.
>
> idr_preload is now correctly called before idr_alloc.
>
> With these changes the TODO can be removed and the ioctl can be
> re-enabled.
>
> Accompanying IGT patch on igt-dev is
> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
>
> v2: new_handle =3D old_handle is EINVAL
> v3: More detailed commit message and some cleanup
>
> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> cc: Christian Koenig <christian.koenig@amd.com>
> cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/drm_gem.c   | 30 ++++++++++--------------------
>   drivers/gpu/drm/drm_ioctl.c |  3 +--
>   2 files changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a86bd2a0343e..bb55715e8d170 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1018,19 +1018,6 @@ drm_gem_open_ioctl(struct drm_device *dev, void *d=
ata,
>       return ret;
>   }
>
> -/*
> - * This ioctl is disabled for security reasons but also it failed
> - * to follow process in terms of adding testing in igt and verifying
> - * all the corner cases which made fixing security bugs in it even
> - * harder than necessary.
> - *
> - * To re-enable this ioctl
> - * 1. land working IGT tests in igt-gpu-tools that cover
> - *    all corner cases and race conditions.
> - * 2. handle idr_preload
> - * 3. handle =3D=3D 0
> - * 4. handle =3D=3D new_handle semantics definition.
> - */
>   int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>                               struct drm_file *file_priv)
>   {
> @@ -1041,21 +1028,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>       if (!drm_core_check_feature(dev, DRIVER_GEM))
>               return -EOPNOTSUPP;
>
> -     /* idr_alloc() limitation. */
> -     if (args->new_handle > INT_MAX)
> -             return -EINVAL;
>       new_handle =3D args->new_handle;
>
> -     if (args->handle =3D=3D new_handle)
> -             return 0;
> +     /* idr_alloc() limitations. */

Nit- it's now more than idr_alloc limitations.

> +     if (new_handle =3D=3D 0 || new_handle > INT_MAX ||
> +         args->handle =3D=3D new_handle)
> +             return -EINVAL;

I'd like to open the same discussion point that I opened in the
corresponding IGT. Should we or should we not check for INT_MAX here.
There I wrote this:

"""
About this one I am not sure. Is it not implementation details as long
as the uapi for handle is u32? Let say someone converts to XArray one
day and then we have to artificially limit that to s32 just so
gem_change_handle can keep working.
"""

>
>       mutex_lock(&file_priv->prime.lock);
> +     idr_preload(GFP_KERNEL);
>       spin_lock(&file_priv->table_lock);
> -     ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,
> -                     GFP_NOWAIT);
> +     ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle,
> +                     new_handle + 1, GFP_NOWAIT);

And here I opened a point about what happens when target handle is taken
(again in IGT review):

"""
Hmm.. this is actually leaking the wrong implementation detail of
idr_alloc to ABI. ENOSPC is "no free handles". It feels it would be
better if gem_change_handle returned EBUSY or EEXIST for this case so it
is not conflated. Thoughts?
""'

>
>       if (ret < 0) {
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
>               goto out_unlock;
>       }
>
> @@ -1063,10 +1051,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>       if (IS_ERR_OR_NULL(obj)) {
>               idr_remove(&file_priv->object_idr, new_handle);
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
>               ret =3D -ENOENT;
>               goto out_unlock;
>       }
>       spin_unlock(&file_priv->table_lock);
> +     idr_preload_end();
>
>       if (obj->dma_buf) {
>               ret =3D drm_prime_add_buf_handle(&file_priv->prime, obj->dm=
a_buf,
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce629..ff193155129e7 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -660,8 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_=
ALLOW),
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> -     /* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invali=
d */
> -     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_REND=
ER_ALLOW),
> +     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_io=
ctl, DRM_RENDER_ALLOW),
>
>       DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0=
),
>

The rest looks good to me.

Regards,

Tvrtko

