Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E988BFED9E3
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE9B10E6CB;
	Tue, 17 Mar 2026 15:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4uK3UDnG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0C310E6B5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1AvBKgVWMbQWdJYjE98Ne81PpOaKfvJPQl+FkeLvFYIblNEh8o8CoTuzlAwvLg2LWnEByl6/0GVWVQo8HVeXaCCRR6UO/8/o3/TYWodcvWcO9y+Ib4FhUvkpASqNbg46Hvk0bejR93mYKPUIwS7mwLVfyk8YXuiiqtgNnlrMm3Cr3uAPdMcwHQ1waJSGDHd8B9GiWBVfjGPjefOEStSCxhRoMAp3grI63E5/2nVgVK7Zv3QkUSM3RWoQkrJq8JUGah9MUzMTWabW1QJOGdJA7cbiddQRsRSwqFqdP7z5hL6eD/f8OpGa0FNQK6BMOUExFP8Hv3Xlv9fifDgcGpG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH2E1o6TsEeibyetBNQIq9oI4A261EAtrQD7wqV2U6k=;
 b=o6GuKecoSx1FbwpWmDtFxGvrsNhFbfRLJBIzsFcEaf97lfZbIfA8l5jdzdne1eM/GKPoDOQFpyXR1emmnDYaGr2E7UG4e3dRCV6G5Fyyx2nBdu9jQdtNdJbm9nrg7ZVLlvCryWGbYC0We7TgvCxvOqPw5uddKJIF5lJ3THQohNYtG73e1KMazpgCtEb58c8Oikm41VGu0xrPnXuoO4+y7ADbIjAYyI8qNN+qqMHVNrijBFXr4+50cIE87DNWOj/l7yk3SO9PVBHxD7j99Noedhm2/hkaraKUW+gvbcoCyYLvU+I8ZQKJQnV0rXug1EN5iAXod67meFPZg3mE49/4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH2E1o6TsEeibyetBNQIq9oI4A261EAtrQD7wqV2U6k=;
 b=4uK3UDnGMx+93gyVtouvjq6zxm4NyiHeKhr53XIHVqktk580RdBXsiGuyWZkPqa/eu8096agvmdFClep/Cw0sppQwil1DOwU6qujBqOfFITWXGXoq2CDGZCgDnwlBtxoL0vPLa6VjS81+okX1m3vUCMfgJtasty3AfuY0sUWYkk=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:18:38 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c1d5:bb14:abc3:7fd1%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:18:37 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB parsing
Thread-Topic: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB parsing
Thread-Index: AQHctYZgSoiwyIJRVkel0D+HmQGS/LWyabEAgABtowo=
Date: Tue, 17 Mar 2026 15:18:37 +0000
Message-ID: <CH0PR12MB5284F20EFAB2391B38A01E328B41A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20260316204907.3852592-1-aurabindo.pillai@amd.com>
 <e5b8b6f910578d33220476045899f4199286add8@intel.com>
In-Reply-To: <e5b8b6f910578d33220476045899f4199286add8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T15:18:36.232Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|PH8PR12MB7232:EE_
x-ms-office365-filtering-correlation-id: 4ad7f61f-4376-4bf4-9305-08de84387681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|7053199007|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Yq3zRdVNhGwXCTGH5ue+U6EX4d82U57HIKLS1t2MOZRPnZg6oOmUyYt66UrZgCAJrygt+SmcleCDP++JtSaAs5rVgcO7HKfkf8QOEgIoZHq7KjBXJJrHmNzNApe7GMbzCvBrVo85lnc/ix6yOGS7uNUh2902E9kzLTvs8T43kv/T58OQ3FI9hVZl0m/L8UIK115I0QSv1cy5GXNwanQca/9iBRjDnSDVohoREReKKb6YcHNFAj0MdimiBQem5tWCQlHOK4C6PpEozwcOcixPIJawLrUQvlCQsUeeVA0kajogWpxkzGdRpFzA798sJzxS/wg8QUSZtwf1pvXCOC03EG1QNMC4v/l0YnyIer+zLd8bBApHn4+Ega1dIhQtwz1/Li6lEDiBZHgCPMGBXZRfumnnehFIZqQ9ssJF+Ls8aoGhGsX6LqvyzWtLoDzHBt7HAijWO9HVSSUzlf6+N5VwmVlgNYRebMB3tkCKWEO8xu/nmHMGk6mfN4LH492aOx+gPt2Vv3z6U+P1FfJMkP7blXObmxQQSlkmduo3ivOWr3A2crVnzIA5Ukw/3sWNuHXheJn3LomXyK4MRb9DfsM2bOMxN6VJQDY9fUSjujGlGUQalbM4C+xHT4Me4+2xhdSldKfw2po9gsDkWwtO1ziqDP9JqZCr/z5ae3BUtrJWtz5OdS+Hu7kNdG3W+77hDblp5hjQ6NzJ7ZRMMwfY8uWiJh7s14fHV1ehPkgiBtnBxDFXJoeW8cHtHn9OLAq8iO9iiQnf0ufAWB2p+ndteH8LoQbocIbuyTueWQ+acj6GR0Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6VNSILH7IjfSga+JZmlUULf9IrIA4vN0O4y8th+Tc4M345kd4X4DYRrBBxu1?=
 =?us-ascii?Q?wW9FKkQ43O/K6e6X00Dj2hhJ350HdkI5pEJz0lqfwIEWaNwMZccpwahizD5d?=
 =?us-ascii?Q?jE6r8gsdALyQ5zds+/XZI1ZMEc8KBAv+BkjcQCnsihdfpSA5/gRH3bX/bsQT?=
 =?us-ascii?Q?PJDE4Q2Nd01rXz4+oMFa49/NEIHf8HNXyWH6mnN1Fz2mU8z/qydhccd1DQLU?=
 =?us-ascii?Q?yvPEOpdBNplemAljvf9O6uvItbLmKkfg2pGLv76wNmn1VbpX+W7xTCu+t5uh?=
 =?us-ascii?Q?snVKYQwnJvTOkjPBUbienstq7TuX8k3MY0vDgVrMkzL/8teJf44cMVugTSPE?=
 =?us-ascii?Q?HvbMmOaFktyKnsyjNYjpjBZ4RM3LD3DsKDT7GMpFmbAu3GYGC2emkSbZ/tmu?=
 =?us-ascii?Q?m2Jf9PmIk7FdzbtUsFWUFdITPAy3pzDCG+uPYkB6NWZ6gfYR4GQvGwVT/dGA?=
 =?us-ascii?Q?OqmdYh6d5MHEbkDbHf/gl2tw8HTrWnExX/6cRZPymSrDm+8jsDdFtxwcH1o1?=
 =?us-ascii?Q?6MveX6m1aChZB/v2Yo5isiT3RegVi4mKv93tc6T0WIHkNY7eearYAzG7kbdF?=
 =?us-ascii?Q?pq0/hDQjzMajfhZ2IF5pcdcRQpNm9LelPVNwoksCnl/9D4rR2Qm+6SFeItpV?=
 =?us-ascii?Q?vH78EymzFD3U1MxJwgmfqX4kv9L0F606apgem/aguhI/jMz0DDZtgN8aIEEs?=
 =?us-ascii?Q?jqeixCtpXGJ8GmOwDszCT79VY4jgXVWFj4kuKgUb2wvZ+Uu3ckEnheQAGz4o?=
 =?us-ascii?Q?2HF6Bnfd8LNogtKeXoXsuiB6G1QZZjRap6Ya1X9RZIQrI8heogRWdsDdPq2U?=
 =?us-ascii?Q?IlztS4g/pqv1guGYle0LJvgxKJKlmc5kA+T2/1saa/5X1fc1fAHV2k4kmGtQ?=
 =?us-ascii?Q?YMUN2fp3pTNEga1BFCfk0L2g6BfHGGk/J1Mx4lnItfHo/MQEtX77pvh9l4vN?=
 =?us-ascii?Q?U95FHnGm1SX39APEpEmXvMnYgSloHo7qEcRZYHEUshczxMY4dUWB0HSbaDU8?=
 =?us-ascii?Q?GQn7DDZ8TwJXgkHl7CE2K8P5NJVI9X3vdzNCs1wW+9608BiGEKZcPhSJb9p+?=
 =?us-ascii?Q?ZJd0tJY272fHu2xbwt8h+J+SjP4ZtduxL1jv0spWXXE9Cl+lqHpuaBH4oivw?=
 =?us-ascii?Q?eXkm0vwqi/NBjotT24sHhUUAnLRfHIflN1hTwkJ/mlduxMge8rcGj3pyICSz?=
 =?us-ascii?Q?6Q4xlj/o5E/53dr3Mjtxrf7lQk6vjpXuQdiAqulQOEodQXSFACSYyVID/9Fd?=
 =?us-ascii?Q?b0GaCjaHCdTcO0aKoON54WoD5/Qle8wlXek1ocKItWFcP1rGOeqgC4hpFhrV?=
 =?us-ascii?Q?NENEPkw6mUpmDLDbgehCluMStln8SOJC5OspTZdCrcaMaFiG1H5dJkeHIdd+?=
 =?us-ascii?Q?ZOhrHEHwmWBncAiXbzuYMecLjENy2nHXhUNfeb/6DUYF59qQJHPPf/7FQoZj?=
 =?us-ascii?Q?hxHmsDMbLwsh226u2vc9QulKvnC2l50C7f5jm6MEh0PC4wG9v1PuzZbdgpnT?=
 =?us-ascii?Q?1+geNgauFLadL7zaa7xntO3DNc/Q/vGft2Cmx+fMIQ/KjiGJNQ9Gdp43FctX?=
 =?us-ascii?Q?7oV/OQl/o5ySCwm6HspYO43SAAuJjTIx6+fqn/nmsgSVP2dSy5Cmlhw6FIrv?=
 =?us-ascii?Q?9MgIt9U+Fe/cQXXxeJAzHgGiUwnWB0GOgUaFK6lzbAWaRAZhzmPf1qVmb2XP?=
 =?us-ascii?Q?4CrF0iXpuvoX7njDUHj1gUUKlH4H/QBhELBckhsyx/u2pE2c?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284F20EFAB2391B38A01E328B41ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad7f61f-4376-4bf4-9305-08de84387681
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 15:18:37.4387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caTLLXbCjLZniZDUAsi79nuV6/BNMCEcXCmgP46ESAM2azbUtJGrZ3GtOmnkP3xqGcrjiwJFyzIMkTXLP8BORQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

--_000_CH0PR12MB5284F20EFAB2391B38A01E328B41ACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

You're right - I missed the reserved bytes in the spec. Please discard the =
patch.

--

Regards,
Jay
________________________________
From: Jani Nikula <jani.nikula@linux.intel.com>
Sent: Tuesday, March 17, 2026 4:45 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; dri-devel@lists.freedeskt=
op.org <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>; David Airlie <airlied@gmail.com>; Thom=
as Zimmermann <tzimmermann@suse.de>; Maxime Ripard <mripard@kernel.org>; Ma=
arten Lankhorst <maarten.lankhorst@linux.intel.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>
Subject: Re: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB parsing

On Mon, 16 Mar 2026, Aurabindo Pillai <aurabindo.pillai@amd.com> wrote:
> drm_parse_hdmi_forum_scds() used HF-VSDB byte offsets for both HF-VSDB
> and HF-SCDB block types. HF-VSDB has a 4-byte header (1 tag_len +
> 3 OUI) while HF-SCDB has a 2-byte header (1 tag_len + 1 ext_tag), so
> all field accesses were off by 2 for the SCDB case.

HF-SCDB has tag + ext tag + 2 reserved bytes, making the SCDS start at
offset 4 in both cases.

BR,
Jani.


>
> This caused SCDC support, max TMDS clock, scrambling, FRL rate,
> YCbCr420 deep color, and DSC capabilities to be read from wrong byte
> positions when parsed from an HF-SCDB block.
>
> Fix by passing a pointer to the Version byte (first field after
> block-specific headers) and an explicit length to the parsing
> functions, so both block types use the same normalized layout:
>  - HF-VSDB: data + 4, payload_len - 3 (skip tag_len + 3-byte OUI)
>  - HF-SCDB: data + 2, payload_len - 1 (skip tag_len + 1-byte ext_tag)
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 59 +++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 26bb7710a462..13174876b04c 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6143,45 +6143,45 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *m=
ax_lanes, u8 *max_rate_per_lane
>  }
>
>  static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *con=
nector,
> -                                            const u8 *db)
> +                                            const u8 *hf_scds)
>  {
>        u8 dc_mask;
>        struct drm_hdmi_info *hdmi =3D &connector->display_info.hdmi;
>
> -     dc_mask =3D db[7] & DRM_EDID_YCBCR420_DC_MASK;
> +     dc_mask =3D hf_scds[3] & DRM_EDID_YCBCR420_DC_MASK;
>        hdmi->y420_dc_modes =3D dc_mask;
>  }
>
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
> -                            const u8 *hf_scds)
> +                            const u8 *hf_scds, int hf_scds_len)
>  {
> -     hdmi_dsc->v_1p2 =3D hf_scds[11] & DRM_EDID_DSC_1P2;
> +     hdmi_dsc->v_1p2 =3D hf_scds[7] & DRM_EDID_DSC_1P2;
>
>        if (!hdmi_dsc->v_1p2)
>                return;
>
> -     hdmi_dsc->native_420 =3D hf_scds[11] & DRM_EDID_DSC_NATIVE_420;
> -     hdmi_dsc->all_bpp =3D hf_scds[11] & DRM_EDID_DSC_ALL_BPP;
> +     hdmi_dsc->native_420 =3D hf_scds[7] & DRM_EDID_DSC_NATIVE_420;
> +     hdmi_dsc->all_bpp =3D hf_scds[7] & DRM_EDID_DSC_ALL_BPP;
>
> -     if (hf_scds[11] & DRM_EDID_DSC_16BPC)
> +     if (hf_scds[7] & DRM_EDID_DSC_16BPC)
>                hdmi_dsc->bpc_supported =3D 16;
> -     else if (hf_scds[11] & DRM_EDID_DSC_12BPC)
> +     else if (hf_scds[7] & DRM_EDID_DSC_12BPC)
>                hdmi_dsc->bpc_supported =3D 12;
> -     else if (hf_scds[11] & DRM_EDID_DSC_10BPC)
> +     else if (hf_scds[7] & DRM_EDID_DSC_10BPC)
>                hdmi_dsc->bpc_supported =3D 10;
>        else
>                /* Supports min 8 BPC if DSC 1.2 is supported*/
>                hdmi_dsc->bpc_supported =3D 8;
>
> -     if (cea_db_payload_len(hf_scds) >=3D 12 && hf_scds[12]) {
> +     if (hf_scds_len >=3D 9 && hf_scds[8]) {
>                u8 dsc_max_slices;
>                u8 dsc_max_frl_rate;
>
> -             dsc_max_frl_rate =3D (hf_scds[12] & DRM_EDID_DSC_MAX_FRL_RA=
TE_MASK) >> 4;
> +             dsc_max_frl_rate =3D (hf_scds[8] & DRM_EDID_DSC_MAX_FRL_RAT=
E_MASK) >> 4;
>                drm_get_max_frl_rate(dsc_max_frl_rate, &hdmi_dsc->max_lane=
s,
>                                     &hdmi_dsc->max_frl_rate_per_lane);
>
> -             dsc_max_slices =3D hf_scds[12] & DRM_EDID_DSC_MAX_SLICES;
> +             dsc_max_slices =3D hf_scds[8] & DRM_EDID_DSC_MAX_SLICES;
>
>                switch (dsc_max_slices) {
>                case 1:
> @@ -6219,13 +6219,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_ds=
c_cap *hdmi_dsc,
>                }
>        }
>
> -     if (cea_db_payload_len(hf_scds) >=3D 13 && hf_scds[13])
> -             hdmi_dsc->total_chunk_kbytes =3D hf_scds[13] & DRM_EDID_DSC=
_TOTAL_CHUNK_KBYTES;
> +     if (hf_scds_len >=3D 10 && hf_scds[9])
> +             hdmi_dsc->total_chunk_kbytes =3D hf_scds[9] & DRM_EDID_DSC_=
TOTAL_CHUNK_KBYTES;
>  }
>
>  /* Sink Capability Data Structure */
>  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> -                                   const u8 *hf_scds)
> +                                   const u8 *hf_scds, int hf_scds_len)
>  {
>        struct drm_display_info *info =3D &connector->display_info;
>        struct drm_hdmi_info *hdmi =3D &info->hdmi;
> @@ -6236,9 +6236,9 @@ static void drm_parse_hdmi_forum_scds(struct drm_co=
nnector *connector,
>
>        info->has_hdmi_infoframe =3D true;
>
> -     if (hf_scds[6] & 0x80) {
> +     if (hf_scds[2] & 0x80) {
>                hdmi->scdc.supported =3D true;
> -             if (hf_scds[6] & 0x40)
> +             if (hf_scds[2] & 0x40)
>                        hdmi->scdc.read_request =3D true;
>        }
>
> @@ -6251,11 +6251,11 @@ static void drm_parse_hdmi_forum_scds(struct drm_=
connector *connector,
>         * Lets check it out.
>         */
>
> -     if (hf_scds[5]) {
> +     if (hf_scds[1]) {
>                struct drm_scdc *scdc =3D &hdmi->scdc;
>
>                /* max clock is 5000 KHz times block value */
> -             max_tmds_clock =3D hf_scds[5] * 5000;
> +             max_tmds_clock =3D hf_scds[1] * 5000;
>
>                if (max_tmds_clock > 340000) {
>                        info->max_tmds_clock =3D max_tmds_clock;
> @@ -6265,21 +6265,21 @@ static void drm_parse_hdmi_forum_scds(struct drm_=
connector *connector,
>                        scdc->scrambling.supported =3D true;
>
>                        /* Few sinks support scrambling for clocks < 340M =
*/
> -                     if ((hf_scds[6] & 0x8))
> +                     if ((hf_scds[2] & 0x8))
>                                scdc->scrambling.low_rates =3D true;
>                }
>        }
>
> -     if (hf_scds[7]) {
> -             max_frl_rate =3D (hf_scds[7] & DRM_EDID_MAX_FRL_RATE_MASK) =
>> 4;
> +     if (hf_scds[3]) {
> +             max_frl_rate =3D (hf_scds[3] & DRM_EDID_MAX_FRL_RATE_MASK) =
>> 4;
>                drm_get_max_frl_rate(max_frl_rate, &hdmi->max_lanes,
>                                     &hdmi->max_frl_rate_per_lane);
>        }
>
>        drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>
> -     if (cea_db_payload_len(hf_scds) >=3D 11 && hf_scds[11]) {
> -             drm_parse_dsc_info(hdmi_dsc, hf_scds);
> +     if (hf_scds_len >=3D 8 && hf_scds[7]) {
> +             drm_parse_dsc_info(hdmi_dsc, hf_scds, hf_scds_len);
>                dsc_support =3D true;
>        }
>
> @@ -6444,9 +6444,14 @@ static void drm_parse_cea_ext(struct drm_connector=
 *connector,
>
>                if (cea_db_is_hdmi_vsdb(db))
>                        drm_parse_hdmi_vsdb_video(connector, data);
> -             else if (cea_db_is_hdmi_forum_vsdb(db) ||
> -                      cea_db_is_hdmi_forum_scdb(db))
> -                     drm_parse_hdmi_forum_scds(connector, data);
> +             else if (cea_db_is_hdmi_forum_vsdb(db))
> +                     drm_parse_hdmi_forum_scds(connector,
> +                                               data + 4,
> +                                               cea_db_payload_len(db) - =
3);
> +             else if (cea_db_is_hdmi_forum_scdb(db))
> +                     drm_parse_hdmi_forum_scds(connector,
> +                                               data + 2,
> +                                               cea_db_payload_len(db) - =
1);
>                else if (cea_db_is_microsoft_vsdb(db))
>                        drm_parse_microsoft_vsdb(connector, data);
>                else if (cea_db_is_y420cmdb(db))

--
Jani Nikula, Intel

--_000_CH0PR12MB5284F20EFAB2391B38A01E328B41ACH0PR12MB5284namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
You're right - I missed the reserved bytes in the spec. Please discard the =
patch.</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jani Nikula &lt;jani.=
nikula@linux.intel.com&gt;<br>
<b>Sent:</b> Tuesday, March 17, 2026 4:45 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; dri-devel@li=
sts.freedesktop.org &lt;dri-devel@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Simona Vetter &lt;simona@ffwll.ch&gt;; David Airlie &lt;airlied@=
gmail.com&gt;; Thomas Zimmermann &lt;tzimmermann@suse.de&gt;; Maxime Ripard=
 &lt;mripard@kernel.org&gt;; Maarten Lankhorst &lt;maarten.lankhorst@linux.=
intel.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB =
parsing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, 16 Mar 2026, Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt; wrote:<br>
&gt; drm_parse_hdmi_forum_scds() used HF-VSDB byte offsets for both HF-VSDB=
<br>
&gt; and HF-SCDB block types. HF-VSDB has a 4-byte header (1 tag_len +<br>
&gt; 3 OUI) while HF-SCDB has a 2-byte header (1 tag_len + 1 ext_tag), so<b=
r>
&gt; all field accesses were off by 2 for the SCDB case.<br>
<br>
HF-SCDB has tag + ext tag + 2 reserved bytes, making the SCDS start at<br>
offset 4 in both cases.<br>
<br>
BR,<br>
Jani.<br>
<br>
<br>
&gt;<br>
&gt; This caused SCDC support, max TMDS clock, scrambling, FRL rate,<br>
&gt; YCbCr420 deep color, and DSC capabilities to be read from wrong byte<b=
r>
&gt; positions when parsed from an HF-SCDB block.<br>
&gt;<br>
&gt; Fix by passing a pointer to the Version byte (first field after<br>
&gt; block-specific headers) and an explicit length to the parsing<br>
&gt; functions, so both block types use the same normalized layout:<br>
&gt;&nbsp; - HF-VSDB: data + 4, payload_len - 3 (skip tag_len + 3-byte OUI)=
<br>
&gt;&nbsp; - HF-SCDB: data + 2, payload_len - 1 (skip tag_len + 1-byte ext_=
tag)<br>
&gt;<br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/drm_edid.c | 59 +++++++++++++++++++++-----------=
------<br>
&gt;&nbsp; 1 file changed, 32 insertions(+), 27 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c<b=
r>
&gt; index 26bb7710a462..13174876b04c 100644<br>
&gt; --- a/drivers/gpu/drm/drm_edid.c<br>
&gt; +++ b/drivers/gpu/drm/drm_edid.c<br>
&gt; @@ -6143,45 +6143,45 @@ void drm_get_max_frl_rate(int max_frl_rate, u8=
 *max_lanes, u8 *max_rate_per_lane<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void drm_parse_ycbcr420_deep_color_info(struct drm_connec=
tor *connector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *db)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *hf_scds)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 dc_mask;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_hdmi_info *hdmi =
=3D &amp;connector-&gt;display_info.hdmi;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dc_mask =3D db[7] &amp; DRM_EDID_YCBCR420_DC=
_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_mask =3D hf_scds[3] &amp; DRM_EDID_YCBCR4=
20_DC_MASK;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdmi-&gt;y420_dc_modes =3D d=
c_mask;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const u8 *hf_scds)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const u8 *hf_scds, int hf_scds_len)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;v_1p2 =3D hf_scds[11] &amp; DRM=
_EDID_DSC_1P2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;v_1p2 =3D hf_scds[7] &amp; DRM_=
EDID_DSC_1P2;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hdmi_dsc-&gt;v_1p2)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;native_420 =3D hf_scds[11] &amp=
; DRM_EDID_DSC_NATIVE_420;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;all_bpp =3D hf_scds[11] &amp; D=
RM_EDID_DSC_ALL_BPP;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;native_420 =3D hf_scds[7] &amp;=
 DRM_EDID_DSC_NATIVE_420;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;all_bpp =3D hf_scds[7] &amp; DR=
M_EDID_DSC_ALL_BPP;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[11] &amp; DRM_EDID_DSC_16BPC)<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[7] &amp; DRM_EDID_DSC_16BPC)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;bpc_supported =3D 16;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (hf_scds[11] &amp; DRM_EDID_DSC_12BP=
C)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (hf_scds[7] &amp; DRM_EDID_DSC_12BPC=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;bpc_supported =3D 12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (hf_scds[11] &amp; DRM_EDID_DSC_10BP=
C)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (hf_scds[7] &amp; DRM_EDID_DSC_10BPC=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;bpc_supported =3D 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Supports min 8 BPC if DSC 1.2 is supported*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdmi_dsc-&gt;bpc_supported =3D 8;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cea_db_payload_len(hf_scds) &gt;=3D 12 &=
amp;&amp; hf_scds[12]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds_len &gt;=3D 9 &amp;&amp; hf_scds=
[8]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; u8 dsc_max_slices;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; u8 dsc_max_frl_rate;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dsc_max_frl_rate =3D (hf_scds[12] &amp; DRM_EDID_DSC_MAX_FRL_RATE_MASK)=
 &gt;&gt; 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dsc_max_frl_rate =3D (hf_scds[8] &amp; DRM_EDID_DSC_MAX_FRL_RATE_MASK) =
&gt;&gt; 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_get_max_frl_rate(dsc_max_frl_rate, &amp;hdmi_dsc-&g=
t;max_lanes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;hdmi_dsc-&gt;max_frl_rate_per_lane);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dsc_max_slices =3D hf_scds[12] &amp; DRM_EDID_DSC_MAX_SLICES;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dsc_max_slices =3D hf_scds[8] &amp; DRM_EDID_DSC_MAX_SLICES;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (dsc_max_slices) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; @@ -6219,13 +6219,13 @@ static void drm_parse_dsc_info(struct drm_hdmi=
_dsc_cap *hdmi_dsc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cea_db_payload_len(hf_scds) &gt;=3D 13 &=
amp;&amp; hf_scds[13])<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hdmi_dsc-&gt;total_chunk_kbytes =3D hf_scds[13] &amp; DRM_EDID_DSC_TOTA=
L_CHUNK_KBYTES;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds_len &gt;=3D 10 &amp;&amp; hf_scd=
s[9])<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hdmi_dsc-&gt;total_chunk_kbytes =3D hf_scds[9] &amp; DRM_EDID_DSC_TOTAL=
_CHUNK_KBYTES;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; /* Sink Capability Data Structure */<br>
&gt;&nbsp; static void drm_parse_hdmi_forum_scds(struct drm_connector *conn=
ector,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *hf_s=
cds)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u8 *hf_s=
cds, int hf_scds_len)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_display_info *inf=
o =3D &amp;connector-&gt;display_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_hdmi_info *hdmi =
=3D &amp;info-&gt;hdmi;<br>
&gt; @@ -6236,9 +6236,9 @@ static void drm_parse_hdmi_forum_scds(struct drm=
_connector *connector,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;has_hdmi_infoframe =
=3D true;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[6] &amp; 0x80) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[2] &amp; 0x80) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdmi-&gt;scdc.supported =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (hf_scds[6] &amp; 0x40)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (hf_scds[2] &amp; 0x40)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdmi-&g=
t;scdc.read_request =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -6251,11 +6251,11 @@ static void drm_parse_hdmi_forum_scds(struct d=
rm_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Lets check it out.<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[5]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[1]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct drm_scdc *scdc =3D &amp;hdmi-&gt;scdc;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* max clock is 5000 KHz times block value */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_tmds_clock =3D hf_scds[5] * 5000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_tmds_clock =3D hf_scds[1] * 5000;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (max_tmds_clock &gt; 340000) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&g=
t;max_tmds_clock =3D max_tmds_clock;<br>
&gt; @@ -6265,21 +6265,21 @@ static void drm_parse_hdmi_forum_scds(struct d=
rm_connector *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scdc-&g=
t;scrambling.supported =3D true;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Few =
sinks support scrambling for clocks &lt; 340M */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hf_scds[6] &amp; 0=
x8))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hf_scds[2] &amp; 0=
x8))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scdc-&gt;scrambling.low_rates =3D =
true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[7]) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_frl_rate =3D (hf_scds[7] &amp; DRM_EDID_MAX_FRL_RATE_MASK) &gt;&gt;=
 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds[3]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_frl_rate =3D (hf_scds[3] &amp; DRM_EDID_MAX_FRL_RATE_MASK) &gt;&gt;=
 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_get_max_frl_rate(max_frl_rate, &amp;hdmi-&gt;max_la=
nes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;hdmi-&gt;max_frl_rate_per_lane);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_parse_ycbcr420_deep_colo=
r_info(connector, hf_scds);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cea_db_payload_len(hf_scds) &gt;=3D 11 &=
amp;&amp; hf_scds[11]) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_parse_dsc_info(hdmi_dsc, hf_scds);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (hf_scds_len &gt;=3D 8 &amp;&amp; hf_scds=
[7]) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_parse_dsc_info(hdmi_dsc, hf_scds, hf_scds_len);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dsc_support =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -6444,9 +6444,14 @@ static void drm_parse_cea_ext(struct drm_connec=
tor *connector,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (cea_db_is_hdmi_vsdb(db))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_par=
se_hdmi_vsdb_video(connector, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (cea_db_is_hdmi_forum_vsdb(db) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cea_db_is_hdmi_fo=
rum_scdb(db))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_parse_hdmi_forum_sc=
ds(connector, data);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (cea_db_is_hdmi_forum_vsdb(db))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_parse_hdmi_forum_sc=
ds(connector,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data + 4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cea_db_payload_le=
n(db) - 3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (cea_db_is_hdmi_forum_scdb(db))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_parse_hdmi_forum_sc=
ds(connector,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data + 2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cea_db_payload_le=
n(db) - 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (cea_db_is_microsoft_vsdb(db))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_par=
se_microsoft_vsdb(connector, data);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (cea_db_is_y420cmdb(db))<br>
<br>
-- <br>
Jani Nikula, Intel<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB5284F20EFAB2391B38A01E328B41ACH0PR12MB5284namp_--
