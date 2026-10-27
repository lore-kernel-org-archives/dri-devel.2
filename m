Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF270606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XRyFDpjB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8743B10F82D;
	Tue, 27 Oct 2026 20:49:47 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2663010F828;
 Tue, 27 Oct 2026 20:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McWiJAbfqvkdbLyArR7CPl+mDBhymgbqB6cSuX7L3exxbHuaJqMMWBmpebJPEeCG7WYagPQMjCtkk9gEEbwY63uJzsyQzxRSGhpV174cag9w+qGB1o2GLI8lKXlNQ7zppGLQNcausdvqna+46df3io5pQq9cZDFQqWglgKrRXuqDvpM/fmr78qzKFpOrARbcnjawTX5H+OWUUcN5nqYuG48WcoYC8SRNvMLInnaVdfVsBlSHhSa4eAk5P0qM9nASRUZCse0RH5Bx1NCFpHCPX+fdrXLjG9xjF2vzbPlStyYz8JR1zlCKapFUTLv4e2X6TWChattxHXYRNKBEKnWtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCo8HUdANfVGNVbqKc2K0NJZvDGI6bAa7jDaVUlrzlw=;
 b=dSctHqV9cJkEp399/XZhnGngV1oqBfJi0xgDR/NGRPQ8hQDaYfRV5+O8eKunzlPfzMw4MSZisaJb4bd49lYCG6jMUDeljr9N6AIApua7qHUy1H8BJtkvTTRG5PF64S+v53TD2udAyIhgr6MyIgUPcl8hQiDYTXPiqBJ9O0Iz1mQff/62XKMTiyUHE66Z4reOeMjThMX+4jNxiSdvT1Vlkw9iBHtvF7sbJ9AU57mEit9FAqJRqio7ujKkJZ8bHFi0d0dlNiv/VhtrKFtAzCRTiN85S6jTe4k+9/PniJ52MqdVpfwTR7xpd7ruY3Eq39JsBEw/K6TWtAFH1b3CrVodrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCo8HUdANfVGNVbqKc2K0NJZvDGI6bAa7jDaVUlrzlw=;
 b=XRyFDpjB9TZ0mxQMPQgoe+Pmn0XaZEUHILAh208/8uq8lX1LscXyUCvM1m5jXTlZ+PPBi62KehDcw2SwLaut5ztNdT0kTzbWM1+gM+wfO6evLKPxXdlj9bJA+muX79x0dW7irsPwkxGsiwTwb4gdh63K5pe0llgH5XS1WiHqBq0=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 20:49:37 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:49:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Wentao Liang <vulab@iscas.ac.cn>, "Hung, Alex"
 <Alex.Hung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
Thread-Topic: [PATCH] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
Thread-Index: AQHdZkSaay7NIqmdhkSTqo5HX3WdxLcR3Jtw
Date: Tue, 27 Oct 2026 20:49:37 +0000
Message-ID: <BN9PR12MB5146C1B694B96CDFDE3E3101F7602@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261027185414.162183-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20261027185414.162183-1-pmenzel@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-27T20:49:02.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 96aa0ad5-9f3a-4cac-6a78-08df346bd057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|921020|38070700021|261026121527099003|5023799004|56012099006|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
x-microsoft-antispam-message-info: P5/8zkMqV5eoTXAWWlRUaW0HrfH5tBNsyFcw8IiFd3qQU2yqDrtngV9ZhccAbyThN3XNc6zOBqRhGQxzSVcVZhaNErS8BS1mb6x1ECldZE87dVm1Yz33TiWIrlLMYtVMPs+gcPJ7T63GK1uVo/RD1VyjFacg/kt86RfYE//8IVyfAmocxn/Y8UNVAM7WAVKj0GEwO3GqmeVhuPORnY3WRnBalahSBTO3WnIcer4Lz/EpvGkMdB8aBF+FLbzbcQOXtCSpgH/Q+96hce5CG6Fu/+Aw/jQuQrc6VXDdQKl2LUweTD74JAyTYBU7J8tDDzd2E+3Ylek3wMaJJmWgyIggXpwq/VM2C3/bE4CLUqUQB0czt/ygGSj7xlU2D53VJi3LT2FoAJmX3CS/g1TkjFYJnXNzbo3bKjRjxtlqa7+STNhyRCmuuLhx4BtM6Y0ozNNOJEK0onGA5rfzGr9h6vLRwvujdDLVX8+oCVrEaKvWcXF8mNUHeoqIjY0P5NWI3MoGMOulCDuykDZBDvfu+F9Umf8Cllhdeh6+LtVwKgx+Wua9uYbaR5616NoCKPcG1h11J8t6nZemTXqb1DKIeztAhm0ZuoFSyfPlzyRIgVSlf7bBfJObspVj8v0jZ5f3TW/FJZ42lS4CUwBuefVTo0x8jWWTFyCR70nTkXUfWNMEacvls9FyZm6mjpIvXFZFFDnS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(921020)(38070700021)(261026121527099003)(5023799004)(56012099006)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jPm05eV7JIsanggce23oL2BtipjmNHVsJMl6jL8i7XTJNClWaHVhoMZb60X5?=
 =?us-ascii?Q?d4dhhsLWNaGSAgkmR5p2iFimfSsnWnj0aGhrDL6IinvaS+cg1MAi+sa3DhRN?=
 =?us-ascii?Q?uMYcCxbFRhzJMs/f2Jfp8u15FsMlxm8wMkJ69iLzQu2Vw4HFf/k7HyuljlRh?=
 =?us-ascii?Q?/sb52x82rI+ng8bEpTKxdi4i1R0K/+9Jji9fDiQ4OHvB78lcBmG2hP4kW+qR?=
 =?us-ascii?Q?4LB9XIPdoJN1mms4jDTiI7N3lO7Y81ABGxtWxfw7IGfz/uITrjQ6ph6NO4yf?=
 =?us-ascii?Q?Efe5Gnk+vg+c2f2B6OZJXPHSuOGZ8xaqVAkPrjDpIk34K2pRr42VcVoNq8Lf?=
 =?us-ascii?Q?ihTTwQuWN6eq/udN0n8JpbcImQ4wDgwVrdWHP4mLgqZOUK925PlnDu1xV7AL?=
 =?us-ascii?Q?CXJ8u23dn3njktyYOSWR1zz9T+axoKiiy9cp8WHd76bhqKk9PFAZBv2mBotB?=
 =?us-ascii?Q?ukD96a3lU/YWD441z+50Iy9irKe41lyqX0kM1/lQ9hvbMevTVYoFk/D9OQx7?=
 =?us-ascii?Q?Z02Tq0qVDSeWswEUWIcfc8psnS2bBD4Czvsj9WXepslkO0PlWy2B9D+t8VGk?=
 =?us-ascii?Q?kSvlqdI3SdYElHaBka2a05LYW7+TPU2kLEqJxPxxKbWZRLFCtKToStSM7zsj?=
 =?us-ascii?Q?sIeIRlbRiKgmGmPu2cGJG8p14pIwZHWdZMezFzH+6pqVxHRFFLJFyvyrU/lW?=
 =?us-ascii?Q?9rkNUBGYIYouTuDPuLHTVAb3/lOSpkL/C803YU6LrsEuaV0Q2yLNKCMI5OBe?=
 =?us-ascii?Q?I2ltJkGC/aSyl95j0UyeA1UZCOY7cuQKmQid0a8qQwz6PzL4UVcS2bBV2KZw?=
 =?us-ascii?Q?O9oZjLqQ+DOw4xFHUlBH0JlPlRiE55B/TVkrNC8xa11KXEW5FdebS8PNRC/A?=
 =?us-ascii?Q?q5ge8y1iboWFo9+3eTRRMGneZ6auVDYXdTtgcXXFuRUURq2QJugxbriXcPT2?=
 =?us-ascii?Q?OWDFGm3H5YIyh7srBI7dxtHORxN2Mkxxytc1U3P3jOKt3Cjz3tbnCiSMdQ1T?=
 =?us-ascii?Q?W6HA6vK35hVoRYKEH3p/Jq7cxRh0RwyfANor+53jZUlpNiy2wuXfQ/Ad3L9C?=
 =?us-ascii?Q?c4nx7v62eH9UZj0kW36i4DPqDwIcU6vFeFV/4FBljmddbsNoP1EuJPjSPXuI?=
 =?us-ascii?Q?TiNxHdqObOLKbjZRvUtDQuAGPQjqfX1hsjoYIigZQs3qqPrammx1WGj6I75C?=
 =?us-ascii?Q?hamOjiYXjztxuECGp5xsmzGEeZojL11OkoDtixzJV/RhoRNKbSY5UlcLQ5lG?=
 =?us-ascii?Q?8bxQ7tGiHPpvb6/oJVk1WhS79rJ4FOHLPkK1ELnHG20NfG1Jpa5lTAJAWRqj?=
 =?us-ascii?Q?EkvkL6zbqGUevJtHvRZ3w8xryhe4YGVzJWdQVIbFZt+Zk6aTtrIYyip/fpTu?=
 =?us-ascii?Q?zlA10Ot6dj4wLQTkDmCC2aSxTFVd6fMIg+UexMDXZjt9lrrDV5mRlOm/iUsX?=
 =?us-ascii?Q?6I5DSUoCSUs1T8oqis6BzVWTfwh7GYByKv8EWaoviHU5TLtRJlV+IWR+lljI?=
 =?us-ascii?Q?3BuNsIGgA3EdisG+qfOPEXHe/WwsHR9uKnf0e9BjbiHsh9rrCbrbkvktqm10?=
 =?us-ascii?Q?RC4AnHdJMXhaObEo0Xf/+iC4AEw5Sxy0qknS1Ll0V5NwvN80q7+fZbgE/jtq?=
 =?us-ascii?Q?w3VbVq01WeKETBL74h6MNMV3sYBJknSxj3uXs9UlljNvF2zKqTP+L514bDZp?=
 =?us-ascii?Q?DeR0jB2v2O0B9g1UNpZUf4SItsSdIaWFYbFqgDBnacKuL+On?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa0ad5-9f3a-4cac-6a78-08df346bd057
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 20:49:37.1343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZnut6XHpSJYvf2d4pcGvAFR9mjJCaLtEEBhmBWEg0oq6t31OGcieh98gtcD75f00r8bTqZ4VVZlSIJQDSLJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Tuesday, October 27, 2026 2:54 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
> Vetter <simona@ffwll.ch>; Wentao Liang <vulab@iscas.ac.cn>; Hung, Alex
> <Alex.Hung@amd.com>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; amd-gfx@lists.freedesktop.org;
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amd/display: Don't warn about vendor infoframe for n=
on-
> infoframe sinks
>
> With an EIZO EV2781 connected over HDMI to an AMD Ryzen 3 2200G (Raven)
> on an MSI B350M MORTAR (MS-7A37), Linux logs at every boot since v6.16:
>
>     amdgpu 0000:30:00.0: [drm] Failed to setup vendor infoframe on connec=
tor
> HDMI-A-1: -22
>
> Commit 6027cbee1900 ("drm/amd/display: Add error check for avi and vendor
> infoframe setup function") started to log the return value of
> drm_hdmi_vendor_infoframe_from_display_mode(). With `frame` and `mode`
> being non-NULL, the helper only fails with -EINVAL, if the sink does not =
support
> HDMI infoframes, that means, if `connector->display_info.has_hdmi_infofra=
me`
> is false, and its kernel-doc says, that this error can be safely ignored.
> drm_parse_hdmi_vsdb_video() only sets `has_hdmi_infoframe`, if the HDMI
> VSDB has HDMI_Video_present set, and drm_parse_hdmi_forum_scds() sets it
> for sinks with an HF-SCDB. So an HDMI sink, whose VSDB lacks
> HDMI_Video_present, triggers the warning, although nothing failed.
>
> The EIZO EV2781 is such a sink. Its HDMI VSDB has a payload of only seven
> bytes (source physical address, Supports_AI, and a maximum TMDS clock of =
250
> MHz), so the byte with HDMI_Video_present is absent, and the EDID has no =
HF-
> SCDB:
>
>     67 03 0c 00 10 00 80 32
>
> Only warn, if the sink supports HDMI infoframes. The infoframe setup itse=
lf is
> unchanged.
>
> Fixes: 6027cbee1900 ("drm/amd/display: Add error check for avi and vendor
> infoframe setup function")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5025

Missing your S-o-b.

Alex


> ---
>
> Notes:
>
> claude-opus-5-5 (Claude Code) assisted in analysis, code change and commi=
t
> message.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ded8e21897f1c..636dd2dedd73d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -941,7 +941,8 @@ STATIC_IFN_KUNIT void
> fill_stream_properties_from_drm_display_mode(
>               err =3D
> drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
>                                                                 (struct
> drm_connector *)connector,
>                                                                 mode_in);
> -             if (err < 0)
> +             /* Sinks without HDMI infoframe support make it fail with -
> EINVAL. */
> +             if (err < 0 && info->has_hdmi_infoframe)
>                       drm_warn_once(connector->dev, "Failed to setup
> vendor infoframe on connector %s: %zd\n",
>                                     connector->name, err);
>               timing_out->hdmi_vic =3D hv_frame.vic;
>
> base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> --
> 2.54.0

