Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6EF5A8BC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B301A10EB47;
	Mon, 20 Apr 2026 20:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lw623vbh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDEA10E743;
 Mon, 20 Apr 2026 20:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY0dhdnTrFf24P85nU+/5dy3XpqGKkWmd7zS7lGThDrCMiRz3V31z8hPrcjHzYi1XCKgAiFNURPtrjzEcMxw8QenyVaoxC+wl486GOSyBMjFRHSOHu7T1969AauIUCZ5hm2V7o0jg4wDNlTIymQ3UKKiOaMCYZVDP5nZaEV5kNIAPt1F0ZEPj1179S9gAsO7PJBdCxLaKsvo0vlNCXp1fXE06K4gOBq5bbWGA+20PAdtmAzBA2KExEBDrXGpcrbjDh0xastGINs+ZxRAGG/owRhRvNtC1rznOKiChmxkBT/L7xhD5fUgKc+VByXkDRmtCidhY/avsdyBAXKYWpXONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAdIqfr/7Am2BO8vQ5MDeHkeuVpGUvJ+wAQUs2+wH7o=;
 b=o4QSsxQbi+uc2QKKaAhDo/BAcSyDdjRODu5vvAf7aIkiwriZJMC5lxQnlJsdQi60VoFGZrUp/I5IbEVbNWj5CmGWGpPEvy7o8C51lwoHp6vIIyzNAP688PT9fmjEqquXF02SJlrre8VLWS9wD3o99VtYCMiQVIksiEVanLyqbiD4tf4hoe5Jsxw8FeMwxSPWUmzP/gk6znoO3JMcskOV8jPnzEk5i2OKPOx/pzcz3Xm0GH5vgTwya+DjGkaD4Ap7dJwiDWhZ352pQhRTxEsM1pFrKQyCtdDF/voASeLA427Yvi69XR5O9McgDRCPPMzczfXIhzCElkYTSdJZRcFAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAdIqfr/7Am2BO8vQ5MDeHkeuVpGUvJ+wAQUs2+wH7o=;
 b=Lw623vbhlW6r6rwbwH3HW1SIvSFBY5rA7Dkr+TDXMYJ6YWXyrP1FkUl4Kxb4qXMt6AvTwkmTSD393UL/UHCOOzPG6I4dM4Mw4DH3fxMZxY3ur6mZmwpxmE6Zeeo1VCFiADu2Il5qvUx3svTyuD4FE/QUrWgGKhMOIMHVkqKRpZRmR3Z2ZDqchzulrfAGHFoqrZvbs1cfI2D8EugQANzMNiY2QUG3VRqIs4JDlnIMln3SbvHCOyXgEF9Po9lo49vg6Xgb9MJVu/j3HkzYQAyNE2WxetYRSOgM+2ySLecg8c8R2UmrufAcP5Y4Y3rFCEOhCVQQp+UWXxvf/PEoThu/bA==
Received: from DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 20:26:47 +0000
Received: from DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e]) by DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 20:26:47 +0000
From: Vidith Madhu <vmadhu@nvidia.com>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
 Simon Ser <contact@emersion.fr>, "xorg-devel@lists.x.org"
 <xorg-devel@lists.x.org>
Subject: Re: Native DisplayID support in core DRM
Thread-Topic: Native DisplayID support in core DRM
Thread-Index: AQHc0P8PmiPN2H8b7kWTLgwF4bCJVbXoYxsAgAAB2o8=
Date: Mon, 20 Apr 2026 20:26:46 +0000
Message-ID: <DM6PR12MB40286F71A9B723681F2D62EEAB2F2@DM6PR12MB4028.namprd12.prod.outlook.com>
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
 <aeaJlED2e1ZXsLlt@intel.com>
In-Reply-To: <aeaJlED2e1ZXsLlt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4028:EE_|CH1PR12MB9575:EE_
x-ms-office365-filtering-correlation-id: b1895102-fe53-4126-7536-08de9f1b252b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: OBshKSD9RcmMtfmSjIUej5OjtPcQu/UlbwUe9vmg1eTuvosH3BBD4rLvOV6rnkrixFfb/UZeevdaw/QQ/kAdSY9oAGKpeq8G5OLM60g/nMGOSms7301gs72P6aKc2YjndE0KNy9LLK2YS3hYE4N27Z1LAFbsPHy8J7iJbJ3q/S+1l45NcBwJDUGH5AqBkaju7rKYB4tj7bbxWtRsXlEZVm0Z0hBuKtjIPbbHD+YJ6xMA75M7kDxzA934EDMZV+y7IXXT2lCYkcV0POrRKaJhO1tiNsWH9l4Ip5kk0mrgvx4VNPH7zsPxmhsghl5vKPT/+IvTTQFPbrJDcbLTf8ddzleMSn9bnIpeqC41K8xXyicINqAYQi+0eIiFqy5hUqxNBZ+NJadPwG9C48MxA+TudGCyMMbJ+bIR2fBmEi8bztCgb4WLlqZds6xDX/6Gd33cMTC8QJhhttfQ3IfxFNZVeOoqkcP4VCb8QoaqxqDIb1pCSOQvdyOEQABcx2lGXOzwelppkYYao3btqh5zVozTSQEsZQv/PLuZPY7Nndxs8mCbdK+hj5PrLuqYUjB1xs11WHNbRVqvzXcwwjqN5MVqnZjQwTP49e267H+irL8ARVLYMtYf6gMv6VvWseVxF6k71DOU4d+Zdhr84C1GZSSHGmHracbD8zb9Gt+4hAOVLxme7QqxGXw119nvBw8JsGPKeDL/irXdH67iU8B6HZGBdZUli6wzXR4GOAORv3PZIz+cEQOA7S1CdJhUuw5GyIUsg+gshnB+ZbXFycBcidvpoDd+7HirINLIBYmWqV/dOHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4028.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2G0D7ceZW3VzyEGj92sW6dzVjkADuLcuXGXpyH0EUfmoPoYcO+V9TsexPB?=
 =?iso-8859-1?Q?V9go+bbuM7NZ9ZI8FXXaiGmr+K1KlYzR8fIGqWt+oenLioHWaVe2d+jJC1?=
 =?iso-8859-1?Q?ZuPIgjijjNTdr92flZsgJB5GGgISvvGLm1CqM8lleJDmlpbjcTRYFY6Jj3?=
 =?iso-8859-1?Q?dsN9Oh6lwo2TSKENOb+exnnWkGjmV177eyVUQbNJ5dIjCi2uxxSjz+CQyN?=
 =?iso-8859-1?Q?cDdCfGM+ra9MH6i831/eogrqrF/fg1f5No9hs1CJVSwaRXtC+TKWLzoMdp?=
 =?iso-8859-1?Q?Z4aaPZyNWaPwy5um60KrlVBVtswdal6K6YIUg3BoxVuFLO+ehO4Y8Wy13Y?=
 =?iso-8859-1?Q?Gx+9+bqQy9JKMDwI+33lrNH4SZhor0PrXbsK17cSWq86Af0P/j9eJO4Gq2?=
 =?iso-8859-1?Q?IDqhn8jDYnp1hKqvMfe+BiUH2XT50YkFsw39uKg6yAFXZ4TAycdLgZSb/J?=
 =?iso-8859-1?Q?v3/NdIlrAAoBzP5BYuVnnQLJD1LLl/i5hcy04pOKNsl5s0J+EbIZ8tEYe3?=
 =?iso-8859-1?Q?KEkSWpRXHr9rtzrL9HbUFYnWiQFFMT8E9RM+S1Eqqd51tNctlb/s8WIQjm?=
 =?iso-8859-1?Q?O8leyzpSw8cfzO+VYtbUXUr7lg99/1fXwkfiI+vr/KkikS9hCdjhuvJRH5?=
 =?iso-8859-1?Q?GQJIcNaPB7Lo5lrPxHBO+PWp1z6A/kWqvZy2WqfasdefeOpEjFWi8iLotZ?=
 =?iso-8859-1?Q?ckuZ3EGOwsY3kfuNWRdkaqdowa1rUm3+gJgvaWQKicv4frZvICHRJ4uPjA?=
 =?iso-8859-1?Q?7FkmRhn686/IzdfS1K+15ywe0O026iA2V36lxXDS4rjtw8SvvZwQK137EU?=
 =?iso-8859-1?Q?+b1oEs6WGTujZC8he7Rr5N9/MESIu3c12NgOkBmeleSZc5VXOfuzFFdDma?=
 =?iso-8859-1?Q?js5iRHEyjMRwYjPCcd7yKDtS7Yip4nlIcY3kEBAEa5whlBuRXy9vcixcBU?=
 =?iso-8859-1?Q?/MrZaIgMkJPFABDkTLkThsqlWHw9U0r5MPKXc7g7+wLSdvLQQESJY9WrWG?=
 =?iso-8859-1?Q?3Q1oBTWQlSviKN2Ov5oVscitFP4UjCJVC37JwKEk1WXO0yyL3Ul/fOB2UA?=
 =?iso-8859-1?Q?Wq9F5uNK3XnkSx45E/P5+mySnU1pZUCi5pjNc2n3ykm7DRgAbVO2arPUc1?=
 =?iso-8859-1?Q?0pzR7TDw+KOs4unMPe8JxpMDArOu1DRDX1ZRu9cr/xAFZWkmno5hF1VG8f?=
 =?iso-8859-1?Q?yGH+NT8zvRBtnbTLi76cH+oXM7pA4TRxGU/xECWSDrbr/GPnRY0yNztk/y?=
 =?iso-8859-1?Q?SzKT0ZisnRTuAUGOjbUtTrpgnQBVwGeWOoCrcYWef886ruIyOPGalDztVs?=
 =?iso-8859-1?Q?5P30Cz/yZ6lSm5phBNjoqmqlbJ78xcIUihRqWWsvUR5CS2TNhwj+mmhDo2?=
 =?iso-8859-1?Q?d2yWoQ/FWsTpTTkGjQg2Dle4wuNjMrCoX3FrM2XhqrbE9EZXsH2SnsH7qJ?=
 =?iso-8859-1?Q?p4MUglv1NHO6dqNYzErCdeMblxEbl1JliRgQorVXu7GilxU4S0rAuZlcRo?=
 =?iso-8859-1?Q?xv96oT5DRAH4K/0lP8nSwXIsa2rTYNVPjVzbQn7FshMk8/CoAHSZEe0Yke?=
 =?iso-8859-1?Q?qrz5LYZZe8dslvORNsEAspD6QBd39BPjLdHQNnDIqc2cSaVJAIIx7rHG7g?=
 =?iso-8859-1?Q?0aOd8LXSm/e4ps4hPTH0mybrU/JnVvbt8EANrijxFVv3slrx0bn76Od/U6?=
 =?iso-8859-1?Q?khTyrMPTERXsvNIqOCZD6Dq66td1TIEPaj8THnetlWL+o6J8MTpes5lSVt?=
 =?iso-8859-1?Q?KkunG+NxoaHJmLBeATl7zlpW5C/jqvxiJ1U5dF4tD3ppCu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4028.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1895102-fe53-4126-7536-08de9f1b252b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 20:26:46.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arK+s2JYZe6Cb5HM2uaNaf9dv/nOqlNwkZqoFEJGjVZ1fjXpFdqeJbdXuM+u3HiScZGBA8AVmbk8fQQKoAl2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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

Thanks,
I agree with sample blobs being required for testing. DP2.1 CTS display ana=
lyzers provide this (what we used for our testing), but I understand that m=
ay not be a
feasible option especially for userspace developers. It might be possible t=
o hack together some samples by harvesting DisplayID2.0 EDID extensions and=
 adding any
necessary data based on the spec requirements.
Thanks,
Vidith

________________________________________
From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
Sent: Monday, April 20, 2026 3:16 PM
To: Vidith Madhu
Cc: dri-devel@lists.freedesktop.org; wayland-devel@lists.freedesktop.org; S=
imon Ser; xorg-devel@lists.x.org
Subject: Re: Native DisplayID support in core DRM

External email: Use caution opening links or attachments


On Mon, Apr 20, 2026 at 02:51:18PM -0500, Vidith Madhu wrote:
> Hi all,

Exposing the native DisplayID blob will need userspace support as well.
CCing some folks...

I think if people want to implement this before actual displays are
available then what would be needed are some reasonable sample
DisplayIDs so that the code can actually be tested.

> I would like to inquire about adding native DisplayID support to core DRM=
.
> Native DisplayID is the anticipated successor to EDID for display metadat=
a reporting.
> DisplayID is already available as an EDID extension block and is widely
> used by newer monitors and eDP notebook panels. Native DisplayID was
> officially introduced rather recently in DisplayID 2.1 (Nov 2021) and
> requires reading the DisplayID structure directly over i2c/DDC in a
> similar fashion to EDID. Overall, the native DisplayID structure/data
> blocks are the same as the DisplayID2.1 EDID extension, but there are som=
e
> specific requirements for what sinks must populate in the native
> structure, due to the lack of an EDID base block.
>
> While no consumer displays currently utilize native DisplayID, beginning
> this year VESA has mandated it be supported for new DP2.1 source device
> certification submissions. Therefore, display certification
> on Linux is the most pressing motivation for native DisplayID support.
> Beyond that, ensuring this support is present by the time consumer
> displays start adopting it will provide a seamless consumer experience fo=
r all Linux
> display driver vendors, including NVIDIA.
>
> Here are some issues I have identified in core DRM that need to be
> considered for native DisplayID support:
>     1. A mechanism for reading and validating native DisplayID needs to b=
e
>        added. EDID reads in amdgpu and i915 appear to leverage
>        drm_edid_read_ddc() -> drm_do_probe_ddc_edid(), and _drm_do_get_ed=
id() for
>        validation. These utilities are all supplied through core DRM. Sim=
ilar
>        functions should exist for native DisplayID.
>
>     2. drm_edid_info needs to be updated to support a native DisplayID 2.=
1
>        structure (i.e. have a drm_edid_info::displayid in addition to
>        drm_edid_info::edid, perhaps in a union). To do this, I think we
>        first need to maintain the full layout of a DID2.1 structure.
>        Currently, in drm_displayid_internal.h, there are a few block stru=
cts
>        present (e.g. displayid_tiled_block,  displayid_formula_ timing_bl=
ock,
>        displayid_detailed_timing_block), but there are several more data
>        block types in DID2.1 that may be relevant if no EDID base block i=
s
>        present (e.g. Product Identification Data Block for name, manuf. d=
ata,
>        serial number, etc).
>        Also, drm_connector should have some way to indicate that its edid=
_blob_ptr
>        contains DisplayID data.
>
>     3. update_display_info() needs to handle the case where native Displa=
yID is
>        being used. All of the fields of drm_display_info that are being
>        populated from the EDID will need to be accordingly updated.
>        This includes the EDID extension work in drm_parse_cea_ext() and d=
rm_edid_to_eld().
>        In addition, _drm_edid_connector_add_modes() will need to just par=
se the
>        displayid timing blocks (already being done today from the EDID
>        extension).
>
>     4. There is also the question of how the user interfaces for overridi=
ng and reading
>        EDID will need to change (/sys/class/drm/cardX/edid and /lib/firmw=
are). Should there
>        be separate nodes for native DisplayID, or should they just deal w=
ith an opaque blob
>        of bytes, and leave it up to the user/DRM to interpret whether it =
is EDID or native
>        DisplayID?
>
> We are rolling out native DisplayID support in the NVIDIA Linux drivers i=
n an upcoming
> release; we have implemented our own reading/parsing and are able to popu=
late
> drm_connector::probed_modes with native DisplayID supplied modes. However=
,
> due to the current gaps, we are unable to populate drm_connector::edid_bl=
ob_ptr if
> native DisplayID is being used, which leads to inconsistent state.
>
>
> Would like to hear any thoughts on this topic, or if there is a roadmap f=
rom any in-tree
> vendors to add this support.
>
> Thanks,
> Vidith

--
Ville Syrj=E4l=E4
Intel
