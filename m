Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C3CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B331410E0BA;
	Tue, 19 May 2026 14:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRFjLi3p";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA0010E0BA;
 Tue, 19 May 2026 14:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhuD0tAOonzSEGHsNlhoxGwsMOHh3bqschOZkOwBo29dOWMeLadAcQ4XSFz3DvgKoaXvSo+FnEp/zKMuqSNSHU1QY0YHn4H83JKEaqhLn9ajn4OgVAq62KwzxiqjpYwJ+diMPBVTSQ93yC6Sy5gwtd1PGmQrYJ6uz45CuX4fD+GrPqkHGkGXMIg+EfFF4syt5oTj6RtyI4rbFmRt+McLWZn7ffNSjz8rYkXlGXMH5zTvVASYwoGRKtSSKYtmYS/WDv5GLl9uWOPw2iia9Hr/09wTPFzWkpnSg/myCrlDI5b3qUv7EUj5M/J8Zcc68wwYxajdtlLu75WBbS7cqE7TOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T51S6/baTjm3QrJWUj9GPEboqjxB+/09WQup7aBLWkQ=;
 b=F/yEz/cmVA2JfV1wLsNrT2GOeBW7fCc5cJ6BP9aMu87XXuy3Ob9QMfEsTygvYop0tnloeBpIJn62uIq+mzPCp6GxgEaTj2gU+r3rfHwof6/oYqGSfwJZbL9ykAF/YjGTHpXZ+8RrNSQrEMuVUw/ETM9g4SMNFcHPk0CpxdLp/apRCSo+hU1PzvLBze/Q+pDJvxf1ml0QPTlfCpPo1eb4pRurP+8u34r2VvxOpQLUO3WnX0KXnyKPuum4AEt/Wd3S+jBVAK4WB+LVbxu/BH/Pl8/bwO19xy4DvjkgK+yd0MvrNjCWDOZJkgGBUFDCsro8bs4bgUZ2SfUJML2MdkcyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T51S6/baTjm3QrJWUj9GPEboqjxB+/09WQup7aBLWkQ=;
 b=dRFjLi3pucYnPDMoeXOdVV8Zz/CBQGg5HA9U9CbIL06BJxoFhBrLS+j83bOslboO5JBrfkWt844PKMWNFZqhxZTtqsCDhwLa017DT/SoNIZfww3JPJl/euW1UIS4UxVvGTDJXe1ulJF5Nr+tN/6k5sCRx8O5CG3Q8n3jlfPC/YE=
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:07:21 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 14:07:21 +0000
From: "Hung, Alex" <Alex.Hung@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "timur.kristof@gmail.com"
 <timur.kristof@gmail.com>, "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
Thread-Topic: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
Thread-Index: AQHc3KsoaJiBLi+Si06FuivPs7v5jLYTinuAgAHtX08=
Date: Tue, 19 May 2026 14:07:21 +0000
Message-ID: <DM4PR12MB8476DC78F8A78F099FCF348BF7002@DM4PR12MB8476.namprd12.prod.outlook.com>
References: <20260505162018.1755740-1-alex.hung@amd.com>
 <94187a8c-45d9-4751-9fbf-ac6ecfc990a4@amd.com>
In-Reply-To: <94187a8c-45d9-4751-9fbf-ac6ecfc990a4@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T14:07:20.767Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8476:EE_|SJ0PR12MB7459:EE_
x-ms-office365-filtering-correlation-id: e196a6be-b38f-4948-d388-08deb5aff1cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|13003099007|4143699003|11063799006|38070700021|921020|8096899003;
x-microsoft-antispam-message-info: 7mpHxRiHwK54iqA4ZpFA/V/g+A5oNENxLXLCnwvPgsdPplGLZ8pcxfZ7ZpQoq5XZrP2goRylxcLpshir/Cc+IQgyt0hCbHxOS+9AgS+wYUrfN1AApNPimxtwHQyFkR1e6hWJAwPT4QEO049qfbjX4HMAC9MqDMIOBg/tJOzRkFEr9VAVu1ISVQIKOMDp99W0XBykSC9N0P4NJCOnltHnamw7SoQH2ariD+LvjTlwlWx+obXrw1hAuBri3vveuNipG5P5gY+JZ/BstlFJGDqbdNqrbV41k8xwqkyzH22mPfHBklXHxye8RrVL6MepZNgRCy6HxYTK2QJx0mrSFVpKDlAbmAhsrEPRCAoPMD5hmt70g4TrIKuTvg7cj9s0EWFyViFc5FqwHpkybl0Ra0BOvE4VSrC5uWDjysu6VhqOmCMzf7ll+HaFnjDQTCn0pVA/wjOmhNAZfsw5ArVCi+4KxZzpxedsaV1Pd3qhW5fhF96tXXcLb+ubNZEMFNdYEAyhcuc03XrosPPW577Zcrj2o58oTvAHK4XbQR1AhzT0KAEi50zRYtPUwZU078fnxFEP0un9ktra5U1HtCVkzyoAaO12rW19zsQPtqyHGdjOM1nN3Bg9doYc7kFg+DpybeAfQFUF+nXvCPbzpYu4kVzOy/hsOA419s1pow/ubmEZsUjIfQjJJ9qvSEuD+RlRhX6nuJqikrgDHTglrcSZWC12hbr/pYV9kebpRDSROzlsyzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007)(4143699003)(11063799006)(38070700021)(921020)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hGYiKWWAq2Hn8WDXxIzJWVSUOmfJuf8dELdYSAsF46csi0MkcoNgpwo07k?=
 =?iso-8859-1?Q?e491kwVUdyzuBoJ0W/tlfZsYPcO6wWlEWxVEpV/X9BTgtmU+2DTR+GhQwI?=
 =?iso-8859-1?Q?iWm/dOzx6eXSAw3ZeA2CsjG2VeMkA142AHsgbp8ljdFMWa9LounBYRVGob?=
 =?iso-8859-1?Q?dwoJggbZgkj/yOfMGsIhQMfoNwyIAfD2PYe2jS4EJ6T8UQyfnaskR8VqjH?=
 =?iso-8859-1?Q?on1d3+2bXf0QpPINDKMBR0aCneSmv+AMAJkNzYhMMdojRY0caaYo4N9wPs?=
 =?iso-8859-1?Q?+aHWVlddK9ba+MzqlLrKtUcBWbNPRACGX4LkuvRZhDlURauB3I8X4624a8?=
 =?iso-8859-1?Q?uX9iY0qyaJUUzsI8b2HjSe3FmSWDP6mVMQ0DUElKkPlh+hosfhU27DcYxY?=
 =?iso-8859-1?Q?BRVszZVyB80O1uVrKiiVxUEbPsLcGOLhvW4Zj3oFyuKOuaFKAHBYmcnCLR?=
 =?iso-8859-1?Q?7wpAvhNsRDy6I0w8Ecuu/Lx9/rXRc+zHz88tWk9QGVVdtdggcVN6C2TKlA?=
 =?iso-8859-1?Q?RTjwjLxW3DFuu/fxT2ZZT/PqXN8p/87O4/XFg+U1KJsWl0xgHUTRbSZ/9y?=
 =?iso-8859-1?Q?LCfaijizLqmEy40lu8XmFIpwPySzff3Cpns8jhvxCz5gmtd/ost5/RkTN5?=
 =?iso-8859-1?Q?PFCQl1Xmk7NHgYe8rmsex0155Nl547e4GG23ofiG88KCrjb8IOjD8upN6z?=
 =?iso-8859-1?Q?mjEiuOFB42xNVwGhkWe6lUii0sJJ/qFG4nYcomb6bqHQbKp4mwr8fneEBW?=
 =?iso-8859-1?Q?MaTiYr3l0vKVsZIPm/hFl/rsSkyAj/dVDcyThzsxc6OuigXx9GyJLV8pKn?=
 =?iso-8859-1?Q?BHUvZYpDLayp1FTmJZ4aA6gevLzTm8KSHno3RzONX+PtCXjURYmHrvb60U?=
 =?iso-8859-1?Q?9XsXn0lz8QtxmXZ/MXmtdZ5vhrQUfgknhwud694uPUQTDQm7nDEcHLFjsP?=
 =?iso-8859-1?Q?SZLiYbdpxE1pyOtWPaEIZvcbZQyB/quGFK+x2EIqFI/wmezOW27UBvBh5Y?=
 =?iso-8859-1?Q?BXiQEhu3a01cVVdzi+twbwOKpamxvc9O+QfEVpEj+12Hp6DRu1e11BousZ?=
 =?iso-8859-1?Q?O/LmtMz+INHAw+7cnXf8SKbNaJfPQg7Qo5sBaUKcsr0++jDgwo+ygOqprn?=
 =?iso-8859-1?Q?a2k0fhn2DZjDBLmOr0AyPPJ0Bq+8bZB5U47IBfseLQrIuBem2G2RckTdxO?=
 =?iso-8859-1?Q?NnvaV3hBjL3SP4DIXaiJTZ7jWf5QKL80/IdfC4SRjko+J/AMx3zj48VkZM?=
 =?iso-8859-1?Q?+QTYwCVyLQrOlsZzfM/dcHVTYAyfxwuTnQnAlthE+0c4ESKjBoWu/RQfiw?=
 =?iso-8859-1?Q?kxgin+O4g1u9X6GSGf4HJj+gNtxGMg6wEtSu1Y3IrZ6kB+NVOdWQ2M4BKC?=
 =?iso-8859-1?Q?Fe7woy2Irnq9B1JNvbSZBj35jcjXcrEupcj4JEDvxRIG+mvzsy+ZH4LnvZ?=
 =?iso-8859-1?Q?N7mflEZb+vpbCocpiaqxhWkkHl4dOHzDc1mR/ZmgWXtWFkFr1HcjLI7NAy?=
 =?iso-8859-1?Q?HYOhWcsja7NU68cbGa/omk6zuPvjGsANSssE4rW8v7/W5a/zrg4On6Y6Pw?=
 =?iso-8859-1?Q?avWVHWl0QS+Xs95ahzesyVzHk76TYVpNvsMnrdwSyqnTI7or4aXh4lSFkc?=
 =?iso-8859-1?Q?5hGOfc24oNIldY+fPwxZVQMHox0zZym36PEiTi1NDQ4mhJMKWjITByHDqp?=
 =?iso-8859-1?Q?X9LADhsTZpAwu3wcAgyySODIPejj/WP4UAkm3BrGYBkX7lPFIOJZfBveaO?=
 =?iso-8859-1?Q?XaIC7L0+6bqNcxCIQDRIbSOfDVvYY2KOkLOlN+fg+s1RjT?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB8476DC78F8A78F099FCF348BF7002DM4PR12MB8476namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e196a6be-b38f-4948-d388-08deb5aff1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 14:07:21.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3H9YkylwKJxdDahZTZL1KhCohSSYjnV6oejhemzYZRrTjZbf33ZV9CT4H50/DB37GMFLq5HVuNJs+RXW6XJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

--_000_DM4PR12MB8476DC78F8A78F099FCF348BF7002DM4PR12MB8476namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi,

Thanks. I sent a patch to fix it: https://patchwork.freedesktop.org/patch/7=
25171/?series=3D166586&rev=3D1, and no errors when I built locally.
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: 18 May 2026 02:39
To: Hung, Alex <Alex.Hung@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; airlied@gmail.com <airlied@gmail.com>; simona@ffwll.ch <simona@ffw=
ll.ch>; timur.kristof@gmail.com <timur.kristof@gmail.com>; Nirujogi, Pratap=
 <Pratap.Nirujogi@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Wentl=
and, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx=
@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.f=
reedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig



On 5/5/26 18:20, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
>
> The depends on !UML was added in commit dffe68131707 ("amdgpu: Avoid
> building on UML") to work around build failures with allyesconfig on
> UML. The original errors were:
>
>  - smu7_hwmgr.c: incompatible pointer type 'struct cpuinfo_um *' vs
>    'struct cpuinfo_x86 *' in intel_core_rkl_chk()
>  - kfd_topology.c: 'struct cpuinfo_um' has no member named 'apicid'
>
> Both issues have since been resolved independently:
>  - intel_core_rkl_chk() has been removed entirely.
>  - kfd_topology.c now uses a proper #ifdef CONFIG_X86_64 guard.
>  - All other cpuinfo_x86/cpu_data() references in the driver are
>    guarded by #if IS_ENABLED(CONFIG_X86) or #ifdef CONFIG_X86_64.
>
> Removing this exclusion allows CONFIG_DRM_AMDGPU to be selected on UML,
> which in turn enables running KUnit tests (such as amdgpu_dm_crc_test)
> under UML without needing a full hardware-capable kernel build.

Looks like a good idea but there are 5 automated reports from kernel test r=
obots that the patch causes issues.

It could be that the robots apply the patch to the wrong tree, but please d=
ouble check.

With that done the patch is Reviewed-by: Christian K=F6nig <christian.koeni=
g@amd.com>

Regards,
Christian.

>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 0d4ce2ef9da6..49a7360f45ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -3,7 +3,6 @@
>  config DRM_AMDGPU
>        tristate "AMD GPU"
>        depends on DRM && PCI
> -     depends on !UML
>        select FW_LOADER
>        select DRM_CLIENT
>        select DRM_CLIENT_SELECTION
> --
> 2.43.0
>


--_000_DM4PR12MB8476DC78F8A78F099FCF348BF7002DM4PR12MB8476namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks. I sent a patch to fix it: <a href=3D"https://patchwork.freedesktop.=
org/patch/725171/?series=3D166586&amp;rev=3D1">
https://patchwork.freedesktop.org/patch/725171/?series=3D166586&amp;rev=3D1=
</a>, and no errors when I built locally.&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> 18 May 2026 02:39<br>
<b>To:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; airlied@gmail.com &lt;airlied@gmail.com&gt;; si=
mona@ffwll.ch &lt;simona@ffwll.ch&gt;; timur.kristof@gmail.com &lt;timur.kr=
istof@gmail.com&gt;; Nirujogi, Pratap &lt;Pratap.Nirujogi@amd.com&gt;;
 Prosyak, Vitaly &lt;Vitaly.Prosyak@amd.com&gt;; Wentland, Harry &lt;Harry.=
Wentland@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freed=
esktop.org&gt;; dri-devel@lists.freedesktop.org &lt;dri-devel@lists.freedes=
ktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Remove UML build exclusion from Kco=
nfig</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 5/5/26 18:20, Alex Hung wrote:<br>
&gt; From: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
&gt; <br>
&gt; The depends on !UML was added in commit dffe68131707 (&quot;amdgpu: Av=
oid<br>
&gt; building on UML&quot;) to work around build failures with allyesconfig=
 on<br>
&gt; UML. The original errors were:<br>
&gt; <br>
&gt;&nbsp; - smu7_hwmgr.c: incompatible pointer type 'struct cpuinfo_um *' =
vs<br>
&gt;&nbsp;&nbsp;&nbsp; 'struct cpuinfo_x86 *' in intel_core_rkl_chk()<br>
&gt;&nbsp; - kfd_topology.c: 'struct cpuinfo_um' has no member named 'apici=
d'<br>
&gt; <br>
&gt; Both issues have since been resolved independently:<br>
&gt;&nbsp; - intel_core_rkl_chk() has been removed entirely.<br>
&gt;&nbsp; - kfd_topology.c now uses a proper #ifdef CONFIG_X86_64 guard.<b=
r>
&gt;&nbsp; - All other cpuinfo_x86/cpu_data() references in the driver are<=
br>
&gt;&nbsp;&nbsp;&nbsp; guarded by #if IS_ENABLED(CONFIG_X86) or #ifdef CONF=
IG_X86_64.<br>
&gt; <br>
&gt; Removing this exclusion allows CONFIG_DRM_AMDGPU to be selected on UML=
,<br>
&gt; which in turn enables running KUnit tests (such as amdgpu_dm_crc_test)=
<br>
&gt; under UML without needing a full hardware-capable kernel build.<br>
<br>
Looks like a good idea but there are 5 automated reports from kernel test r=
obots that the patch causes issues.<br>
<br>
It could be that the robots apply the patch to the wrong tree, but please d=
ouble check.<br>
<br>
With that done the patch is Reviewed-by: Christian K=F6nig &lt;christian.ko=
enig@amd.com&gt;<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; <br>
&gt; Reviewed-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
&gt; Assisted-by: Claude:claude-opus-4.6<br>
&gt; Signed-off-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -<br>
&gt;&nbsp; 1 file changed, 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/=
amdgpu/Kconfig<br>
&gt; index 0d4ce2ef9da6..49a7360f45ce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/Kconfig<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig<br>
&gt; @@ -3,7 +3,6 @@<br>
&gt;&nbsp; config DRM_AMDGPU<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;AMD GPU&quot;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM &amp;&amp; PC=
I<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; depends on !UML<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select FW_LOADER<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select DRM_CLIENT<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select DRM_CLIENT_SELECTION<=
br>
&gt; --<br>
&gt; 2.43.0<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM4PR12MB8476DC78F8A78F099FCF348BF7002DM4PR12MB8476namp_--
