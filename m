Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53673606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2927q2R9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9C210E670;
	Fri, 23 Oct 2026 15:50:41 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC67510E670;
 Fri, 23 Oct 2026 15:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnqW+4iHXG7XUyjmjDSkiX50UYqG0hSvLcW9kG8axM53FA/B+L1m2tXkG4Z38MA/Rce1nxzGECH7A0WwUofVJmYdFfHeZ36vAOksL7iy6uYFTorfuSO/408LZ2NuYmNOUGmi5Ks2FFEQO5ov5VSV/z2wHn4C3S3MKp5LH9I+pAmevXE2a6gq/SfYGhr6bN9/Q7MKrh9k/aqlJRZy0Q5/EiFZH8SxHtVPWOB3oOBXDS6gYDjg0+BpgzMWxXhSw2s/bzKUAN3YiXzXrV81fiAZMZ1Mb1ZRKfMO+ltn2Bb753EUU92vo2No3pauKBE9sCaYHZ98R68iXeRnprmtycxhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyrtEASTWWkJMoOgPftYj6eZo7pCFs4A3fSH2PGrkcw=;
 b=uhjjNUnJyBgCF85fVRvxqfwH7Ol2onk4KUFOeSEvyjsIVz8hmCMr2TNvFX1aO6VJFyRSubk1LPyZi0nDDUpmtP/ugqH7yJurQjuTjKvsacCCwt5uqi2yiewF/yNLMjVJrYJNuL9g/fT0nDtWc5/16AP0/lHea/UWL7cOhXn/OP5Dx9jW53luZA7K502qJ0I2CxJklaNj8gRo0oMC3Njx9UheOXsNrBdXuE5zeTUVckXKQOFeFbufXHr5giYcRwCdOSBEgD6+YMxBxozfku9jHWJ9+exBQBfEPr3w05dfo8xy/7bIuKaJmqbZP5fP5hffVCvISSHHfkred1ePYIu4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyrtEASTWWkJMoOgPftYj6eZo7pCFs4A3fSH2PGrkcw=;
 b=2927q2R9q6kTKn3UICnbS7OhmaS7eLuaPFT5WsHgjmqAuWJNcbgxenib4mHJAW+zTOtlH0FzsTBPOXTOI0QgjbCDY0vLc8GH37o1X6PydwM+M1C8k0yZYeQPGpuULfZUdX9Fsu9XSOAK4cgGxB6GVESK52a9DW6V4WK7C3NhR9s=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by MN2PR12MB4359.namprd12.prod.outlook.com
 (2603:10b6:208:265::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:50:13 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:50:12 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: David Janice <djanice1980@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training
 at every rate
Thread-Topic: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training
 at every rate
Thread-Index: AQHdSJ+3gktfw8rd2ESLnJsPZ/OvCLcLdfcw
Date: Fri, 23 Oct 2026 15:50:12 +0000
Message-ID: <CHXPR12MB999220096CBA8DA25F23E138A0E5642@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260920013050.21259-1-djanice1980@gmail.com>
In-Reply-To: <20260920013050.21259-1-djanice1980@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T15:31:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|MN2PR12MB4359:EE_
x-ms-office365-filtering-correlation-id: 989218ac-e8b3-4a1e-624a-08df311d5312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|56012099006|261009223027099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: Xy0sektSIRHKKElsXecka9K8NlnKOAICEU/WPNTlWVH0wy/Xe/SHMSrLzwGhGHKfDQvqaHsa4NZE4c0VcoxjLN0cu2Q3cnPjNc+4YmbqswXWnB/qIANB9ulQRIVrMrE7TGRyPrJHKuXO4Xu0+KBawdK15N0kcwWdMTMRTMbIsigKPSdDZffEDfln8noUeobkVHk4tbr+JtILJTN0LMTQYrffcoe/WefVd69/yjxq4rOe/WxpXUPSBOAIm9SFUggalIva+fDtVSOqqtVtNPu3vPr0byr6AHZrABw6JgXrDdDFm6ggV6N8k0gTQw3TXFNeKbwsO8qnkF3BMbkq9xJWZ4oAE+TM2xlnXrGAMO29N4BRetMzUaLbzgxTp4bISMsCU59uiA4e/pm80ZfPXKfivFrsduqCgOJn7bMvoin4Aok0DorNQVCZ52HkS98HXMBF5e99kyJxOMn/KCDte1JuWMobbhCvlFl0Tv8xExErw9XBearR0OIDXSicfHFjnBBEHpyCcMgejywVTeDFRTf+KbQEs9g1yOGHywO63qS8vyyrCIClSTz9MGfCX2NNRDYre78EIHr3VCOFTym+K5tUoK1w9c8IQHNgcmGCEjhV8rCN0pJTVM49BAhOGHT4Watyg71tU5qw4Zc9fkyZscZ2x1OGZhnqqNXg/fGgn3udoRCuVTcJ/vvjrNoeJzWpft7c5/NTMgpcLQnVLHXfGytJG3XMib0wIWqxEjzBpg7tZDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(261009223027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZvnceYnGf4yDVaegWBWnDKLeUMVqq8/37aAWnkoGWSXcsvEkPvxs/xW8B2hp?=
 =?us-ascii?Q?zDOKYjk815F712b72bzHjtqieixUYqNjP2dgzoTKE6jTZtXRtL0oxmEZEZ6o?=
 =?us-ascii?Q?qaXmvE/HtC4kqivTAiRfE/Ox4AsALYpXM53skiRss5yCRvbgaerWMdjSjYOT?=
 =?us-ascii?Q?UMlyfOZGq9cgj7QtpGRQ819p73v6t5a1ruwjTJSfPh6KIZV0DpXVQHUFbimv?=
 =?us-ascii?Q?f/dkh9BYci5Stk6FTtNWNctSqknm9i18/Gq88Q/U02uLT07586pNKB/Hmidx?=
 =?us-ascii?Q?ypC8gSzVwb13czufywvHc22Z+tWyXK/Xl+2Kid4PFbNROPHo7A4dH1Sx4A8u?=
 =?us-ascii?Q?OM+Kwe7SDoVp7YSrgY0eMQOxj7d9VQ5B2wd+Pajx2qEvs8kVAKrMZcHRbMKQ?=
 =?us-ascii?Q?5i68GOFrbboQUvfJt4b+s85N7Usdlf7Sly6TJwV1wxDIdqy7oShVzrknXUTk?=
 =?us-ascii?Q?DGA8WGEwF/y7WSLSTHB8S8mpM0pheJElJwjKCxewIlziGfYCzYOaRpn0oh8/?=
 =?us-ascii?Q?tyCTNCKBEAL0zlD1K3PHqtMFc+17WVB9ijTjLMBiZuvFJPmdYLu2kPkRjulf?=
 =?us-ascii?Q?wYjwS1IENo/0m3eRl/5yLvFLfwc0PYhijN7kclTwsDyQjP6Uu4f1+NBr7mkz?=
 =?us-ascii?Q?UNPx0wEF0T7Vd8QMRko29jJTnicZ0IQuHfcuLms9F3ovBYyCiEg//A+QNeu2?=
 =?us-ascii?Q?vMpnbxFsT9B6dRDe6PTe+u0ET6727mO/tiT9FrWve0InMkx24JEJVFhAntc7?=
 =?us-ascii?Q?jefurdHAeREK7tbzZplB4ul1G13CQOLDJ3R2SYrtca0WxU93AjBh2HB+PRkU?=
 =?us-ascii?Q?zAvfgfkfpvOrru01tHhDeSfHCPREwKtf4fJ+988OwyCGcT+JPB4hX99fsN9a?=
 =?us-ascii?Q?xXyCDkqlvnDMaGVGYerXfilJB2aULy548aq1rizQtLg+17Wc9pzVSanz2fHz?=
 =?us-ascii?Q?V9Cqxc0Y61XI9BLsNk1FQhkmIWXTYWUoi5JJP8xuHyObNXZe1pcRLXPompc4?=
 =?us-ascii?Q?jYkmIbRmZ+Ek9OCxMSdIAsDg2m/c5/l3J8jHRHu6bI8vSiSmxexqcS662etx?=
 =?us-ascii?Q?bBT0XRmJ4CyPfdUBlHQhphASAdjOzfPUOgl5p7Qh0lyrVz7/KGQDXofKPtyv?=
 =?us-ascii?Q?UhWrzrPCJu0YvyXWdwVURJRynwCCc7ool3rcsCNn3ePBqo7u5zKI+wF+mRm9?=
 =?us-ascii?Q?UfElQ8wNIWF2GvA6VqgM60bdrWXV3eKLvmZLL/uLWpMKR5IChPQUdlUswWMM?=
 =?us-ascii?Q?mRt0mmz2JVztnG/aGjNAuPmOU4uyu/TW+2N8O7E5fvBLdVnv+N7prPAu5xwQ?=
 =?us-ascii?Q?h0MXBFUyM0vdbNG1YxQyMDohNVbSlKcyKppTKa9VGllxf5rv/mpgzrPeCdR5?=
 =?us-ascii?Q?HSO4DTr9tTTlTgLCywukNNVSzsXluRPaC6c85O1p+0ImX/ROk2VhNRH5gGk2?=
 =?us-ascii?Q?A6cCWNU1esLRVHncO+Rh+QgHTfnyhMlSk29l0fMWWmtb/5qo4BurpOdD/gZn?=
 =?us-ascii?Q?DkYGsY/NNJCu4iOTLMB/R9jkyfVlLP4XOGEHYAA2Egkks8dsmL0JlunVIIDQ?=
 =?us-ascii?Q?BzgjjNRMsfn49tbawtpQRhQ44JypDDp/r72nBj7OhrrgeuCvs1GNeFxuqqwR?=
 =?us-ascii?Q?Wq/b4rXTLzVAzliuicl5Y0ffWO03c/aReIGFrQqBABwtLVkJIqlrLbZaVYzu?=
 =?us-ascii?Q?tS604AzroEygsT4Wd9U2OQ+qfxLk3T6xHzP4HejCNO8GO4cb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989218ac-e8b3-4a1e-624a-08df311d5312
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 15:50:12.6460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPliVeG5kVGzjGy1yXuEUtsHGFvjM7W7nL9t8XwGVEvZqhyh6OIF9uSDb9johcPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Your change already being considered in below two changes. Please kindly ch=
eck below two changes:
https://gerrit.core.linux.amd.com/plugins/gitiles/upstream/github.com/torva=
lds/linux/+/ae5df7bc72d919c669301e
https://gerrit.core.linux.amd.com/plugins/gitiles/upstream/github.com/torva=
lds/linux/+/d6751306a6e0fbb09

Regards,
Jerry

> -----Original Message-----
> From: David Janice <djanice1980@gmail.com>
> Sent: Saturday, September 19, 2026 21:31
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Zuo, Jerry
> <Jerry.Zuo@amd.com>; dri-devel@lists.freedesktop.org; David Janice
> <djanice1980@gmail.com>
> Subject: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training=
 at
> every rate
>
> [You don't often get email from djanice1980@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
> hdmi_frl_perform_link_training() gives LTS:3 a single budget of 105 polls=
 at 2
> ms (~210 ms) that starts at the FRL_Rate write and is not restarted when =
the
> sink raises its first FLT_update with the LTP request. A sink that needs =
close to
> 200 ms after the LTP request to report lock therefore fails whenever its =
LTP
> request itself takes more than a few tens of ms.
>
> Measured on an LG C2 (GSM 49352, 2022) driven by a Strix Halo DP-HDMI FRL
> PCON, DPMS off/on with drm.debug=3D0x2, kernel 7.2.6:
>
>   6G x4  (3840x2160@60 10bpc):  LTP request at poll 11 (~21 ms),
>          lock at poll 100 (~179 ms later): PASSED first try.
>   10G x4 (3840x2160@120 10bpc): LTP request at poll 22 (~44 ms),
>          no lock by poll 105: "FAILED - Timeout waiting for FLT_UPDATE".
>          Retry 200 ms later: LTP request at poll 11, lock at poll 101:
>          PASSED.
>
> The sink answers FLT_READY on the first poll every time and locks in a st=
eady
> ~180 ms at both rates, so it is neither slow to wake nor marginal; the to=
tal just
> does not fit 210 ms once the LTP request is late, which happens far more =
often
> at 10G. On this system that is the difference between reliable DPMS wakes=
 at
> 4K60 and mostly dark ones at
> 4K120: hdmi_frl_perform_link_training_with_retries() retrains at the same
> rate up to four times 200 ms apart and the output is then left dark.
>
> "drm/amd/display: Update and revert FRL LT Timeout behaviour" already
> allows 155 polls (~300 ms) for 16 Gbps and above. Use that budget at ever=
y
> rate. With the change applied to 7.2.6, five consecutive DPMS wakes at 10=
G
> x4 trained on the first attempt; three of them locked at poll 104-105, i.=
e.
> inside the last 1-2 polls of the old budget.
>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: David Janice <djanice1980@gmail.com>
> ---
>  .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.=
c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> index 7f93009..005feb9 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> @@ -528,10 +528,18 @@ static enum link_result
> hdmi_frl_perform_link_training(struct ddc_service *ddc_s
>
>                 FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
>                 /*LTS:3: Start Link Training*/
> -               /*Start FLT Timer =3D 200 ms, or 300ms if link rate >=3D =
16Gbps*/
> +               /*
> +                * Start FLT Timer =3D 300 ms. HDMI 2.1 specifies FLT_TIM=
EOUT =3D 200
> ms,
> +                * but this budget runs from the FRL_Rate write to the fi=
nal
> +                * FLT_update and some sinks need more than that in total=
: an LG C2
> +                * (2022) at 10G x4 raises its first FLT_update (the LTP =
request)
> +                * ~45 ms after the rate write and reports lock a further=
 ~180 ms
> +                * later, ~225 ms in all, so it failed the 105-poll (~210=
 ms) budget on
> +                * most DPMS wakes at 4K120 while at 6G x4 (~20 ms + ~180=
 ms) it
> just
> +                * fit. Use the 300 ms already allowed for >=3D 16 Gbps a=
t every rate.
> +                */
>                 num_polls =3D 0;
> -               if (link_settings->frl_link_rate >=3D HDMI_FRL_LINK_RATE_=
16GBPS)
> -                       max_polls =3D 155;
> +               max_polls =3D 155;
>
>                 while (num_polls < max_polls) {
>                         flt_poll_cur_time =3D dm_get_timestamp(ddc_servic=
e->ctx);
> --
> 2.55.0

