Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C990FCCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF11112A1A;
	Fri, 16 Oct 2026 22:22:58 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C3510E06D;
 Fri, 16 Oct 2026 22:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN9KGG4LIuaK7FJD97A1VyCAlfZqi+fmHb2PDt0Edff3WLoPQOlZpB/cCsMmfXWiPI9ifrO+no4YUZHW77QhzW3yKfw/jtbdbosZYnmETkead3MJlHhHBNnH+62EPilTgk++xr3ehWJTPl9PEh+rHRBGv2SS0bC8cZ+euawMmDeH8NYLdwH3bLX1KJqfAJTyyaWoN2ei3BGtc8hctaC24to031lpSqPrfZeBFqSGtimIcGtC1uDdahUwZDVMcjQkAGiJuoULgZCxhkTwlhX7qyzv0bg822G+tU6Qo6USqRwjyakLYTbsbsYmrfvbjnMkEbldczHSv1KoRNkj7cmCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuPsrGYyPDgitny67OH4/4EX74lW9uRDtyOwoVgc/bA=;
 b=YML6viBwQyMjCrxOqCTEf+GoFggGzoSjwkkHO9HeQZUxBYtsk8b1l+FIoWt/ZdQPoRb92lyfig4TTvfRb+XG8+2rtKwzvRccDk3mMwDCN6I7M/kgP7s1X48JzhUKecGVJF70qKe2xIMJdnBvAGI1NhJ4tc+NJGLdDo3rQN0IOiBXxgjhLs98Kr4yUtYKH3jieIg7Qpqq+8G7Kj4Wy3B5TCUfGloARgasjnTO1hLe82Lm+xC5zx58rdJpaX1T+s32L1oYUMJ7YaVpWWyuet+vNZPUuSSlEp7gEXPOIQrTrZ1KTHo34R4TGeu0Xr9utI0YZTICaux3tfoMVd7OuI2Zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuPsrGYyPDgitny67OH4/4EX74lW9uRDtyOwoVgc/bA=;
 b=jGX7W0nq4KdUFG+h0lfM9i6XoTlqP0gjTBX2Ff0BVeGH1ZTONUneBAXUVDRYHJ7cqh8jL9vl509oT86X3YEkekEbrr/7WlNVI5+b5BdXBruiOyUFIU6mdWN0vi/zS6U6gkEf17rSVGARWHa/CT4A50cGranp5MjC6WbzFxHwnRY=
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 22:22:47 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 22:22:46 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Keita Morisaki <kmta1236@gmail.com>, "Zheng, Austin"
 <Austin.Zheng@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: Rodrigo Siqueira <siqueira@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Fix swap in median3() for DSC rate
 control
Thread-Topic: [PATCH] drm/amd/display: Fix swap in median3() for DSC rate
 control
Thread-Index: AQHdSzD9l0gm6vSB7ke8TQ8uIq7iRLcA4Jag
Date: Fri, 16 Oct 2026 22:22:46 +0000
Message-ID: <DSWPR12MB999127DAEC0E7657E3B3134151899B2@DSWPR12MB999127.namprd12.prod.outlook.com>
References: <20260923022451.3346675-1-kmta1236@gmail.com>
In-Reply-To: <20260923022451.3346675-1-kmta1236@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-16T22:13:03.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR12MB999127:EE_|CY5PR12MB6057:EE_
x-ms-office365-filtering-correlation-id: 6669331e-6e45-471d-d6a6-08df2bd40126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261009223027099003|6133799003|22082099003|18002099003|10067099003|921020|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: j9z8FRsab87xjGLAIhlFpcW2AtKXd87tdHfRuY94KTSN2GBbtedhv77X5cbZp29Xc62OSu/F+HtzOBdb+orCxJDsJTGHyDZSWllQhF9VEWFT2iQiVkDyG6fN5qxbH28/fvroPXHmhbHZSQu3mxgeKwGosHx6pEuMw7QvgHmZM0NMoaeNOr/Qy6RuOFbkxgjvnVgazKjAArJpvZnF8PWxbCSYDvw58Ke5RKVNcaA//bzVoX9e14Ou7Z5KlwovNIPkV/XE4kavgguJ2aPPtCHXt6P4g4ZKv5z3wyC5Fh4RqlloPfuTEOlA4p3tZaEGwrSpjttK4T9AmEP0G3EN3U3VuDSNWi4gvRJcM+ZvTS8h9LDdcxEq0iqOGjgs9hO4xMZyZjlgLTsXxTIVbHkyHterFweZGQXZ9/pMBdlnHfdWgZIogLgzYtvSRUcJFCDP2AMNnhKivuNrQP4oZ3Hj446pA5EKj2c7oGGMrWCvqCXgCx4p8iaYMhkhB96oe5Aa/sSXe6MgYQgjmKw0/ML3y3IDDlcfCP1vI4fHtPmSo0m+ShBr+lx1cuQ2vxwpen/IXcuTrBAnWChkb1sBYALcp9H1ks6YpDZ/Y+78Oa7S9G+k0EiNZGdwjfWIfhL3veoOb6Au1m4ENlf+HsHEfY8FKKWVYJkzrDQdkthztN/3wgqmuyY3qV+MUiSPztZKUjKPOuG2tPlZVWGxta3pUjEGHrzUiwcFSBDdCNoQ7ofI8Cdwgnlcn03xZIcDb1Qv8gFv5lqR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSWPR12MB999127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlEEZF+0e2scKVhQCeKYg1P1ZwknxgKeXLvGLye46THcg0mhWgtL31baNHdf?=
 =?us-ascii?Q?tvkDCAoEMdn6CQu2R62In6OOCqDbWGqaOgUAgptPDJxwF4Wyu/kmz9DPOVk1?=
 =?us-ascii?Q?o7Y6NeDvpLNYpgRTGv0EbEz/mEO79aJlOmlp8c1RvP89errT5B7cNF5H0Ejf?=
 =?us-ascii?Q?VXGCLBnnQsgmvzSyhH3m6gQrdyO7HOdSpUVHegyiWFXEeIm95it5ltUVORKg?=
 =?us-ascii?Q?UGsnv8HOuZFjxTIdqsrOc9RfmhNncLzgnz8H7ZbAz3ZNR055gjc8wZP/eviz?=
 =?us-ascii?Q?naiDG7J5czVj8ih9xhq66wW5KCKzFU1Y/ZStneMCBhcczyZYXVH6mk+G/bxI?=
 =?us-ascii?Q?5RiAp5jIZGzO1WX/LwnOcZH4ByKRZmf1kojjmtI/fe10ABss7huqcIep1G2F?=
 =?us-ascii?Q?UffMMyXGAFGpOQ9YxCK1LveAT5g/nJ8gXOhZxxfllddx9eyWVUCHJOvWpbnT?=
 =?us-ascii?Q?jQ9L3JThuPuPUrlfCisKBnHzxkuJNzfpFs90IB36VmOUCyCtpRnDblQ9pgNs?=
 =?us-ascii?Q?EKalgu9FUElMu1UI0PDGLfAqjCdTaM4kRSi1arPHNdH3D3ebhXZnydXBxFd+?=
 =?us-ascii?Q?3aQOLyf14aNTszkXkK2hvP7HW0FviQMLIx8wsDZXbzl/+Zro7KWUiqX1fexe?=
 =?us-ascii?Q?BlqEQ0Dgr+lsiZVzfF8rbRCnpjDRIBsUjtIHd/JpVDHYx8Hf635AT3Fe0tPn?=
 =?us-ascii?Q?Frsk7oG0VDNRJrfwpU+mREWGTLlrXDaO9iK7HTwyGbtTOZHAdBs+RtPRQ0//?=
 =?us-ascii?Q?bW2OYYVzawb034UE529hYc7TUPMsC7lJ0cQZwSjtGoGch59vdn6Pbaiso8df?=
 =?us-ascii?Q?bdvBPXeQ6X5OYrrUoJpyTyMQE3yqlrkmAGxuca8LQxuGiCpDvoe9ewUHQpAT?=
 =?us-ascii?Q?gPRc0Kn/U99KbnfNIgLfaJ1cJY6si+IpC5mbQZv3sCNPBxtavkBKiTbJbP0m?=
 =?us-ascii?Q?AcWYGS1lDW6ebXxt4a/1uIYfHBOasJkAaZ4XOQXCrat7b+r1KJj4g0B6DZXm?=
 =?us-ascii?Q?L5N/abML+WM9a+j/bpS0lfYxbn3lidvu+ZokH8daxCOMOySlTobF7yQ+zGN7?=
 =?us-ascii?Q?OFEDrW1mnEQbv0poSvfGsFlAmRo6WpHiSW4pu/17OUw37rjwPY9lv+i2q5Cs?=
 =?us-ascii?Q?LDybEjntbjEqWcmOkYG6FiSgtn138prbAhVNHJDDQ9u9oQ7LDcaBqN5Jnjao?=
 =?us-ascii?Q?9Y138N18V7pezRvaHalaIevH/idKrmEcxL36PdmA3+csOCCdCozk4MfeRS6b?=
 =?us-ascii?Q?W7w89Y5WFe9Y8/c8KAK8XYiexQpS52Nc9S/5AXt4qfgCSeoH6f5qxetaHVsF?=
 =?us-ascii?Q?k13GKG5Tp8fX6erCKKqsl/c6qjn9CktSmJSosd2dOzrWi9HQ0ru1VGFGtNzp?=
 =?us-ascii?Q?HBwB/dkncBBRWkSEeH9Jfmi9bxG7ECPjumrMVPVpwswIihNErfRmIB92Yj7I?=
 =?us-ascii?Q?VofScOj3T+VQpE77aRO3GIUpO4qfqfK+mlHx+7EVSXDVcAysRVQB5Irxblg7?=
 =?us-ascii?Q?GbXj6I2/xyU1HZNKo2GsPh9UY4ad3+Ef0IBUDOX3XLLChK/zmOc2wOE1TzDR?=
 =?us-ascii?Q?IawwF6CejbYlv5tjsW/PcE6Fhxh5c3ZJINeDFxGVRVmfhn9ebAayJQJvRkIJ?=
 =?us-ascii?Q?Pq3HrLWLEZEEdpvyCWOyvQ4ACJ2oRo777wbOZI8D/h8NYnaAk43it4kAxlFm?=
 =?us-ascii?Q?JPoseI1MGIN4lnzMpQDqLnXTMhHDlrXXZc8aZzLQHT2RGaqI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6669331e-6e45-471d-d6a6-08df2bd40126
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 22:22:46.1907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxGEyKYguARejBaZFOd9G1hGs0RacIRN7SV058nAAu/zPQB6+ZYOhmI6qYwkRpk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Keita
> Morisaki
> Sent: Tuesday, September 22, 2026 10:25 PM
> To: Zheng, Austin <Austin.Zheng@amd.com>; Lei, Jun <Jun.Lei@amd.com>;
> Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vett=
er
> <simona@ffwll.ch>; amd-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Keita Morisaki
> <kmta1236@gmail.com>
> Subject: [PATCH] drm/amd/display: Fix swap in median3() for DSC rate cont=
rol
>
> [Some people who received this message don't often get email from
> kmta1236@gmail.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> median3() is meant to return the median of three values, but its last com=
pare-and-
> swap step swaps b and c instead of a and b. When c is smaller than both a=
 and b, it
> returns max(a, b) instead of min(a, b).
> For example, median3(2, 3, 1) returns 3 instead of 2.
>
> _do_calc_rc_params() always passes 0 as the first argument, and the secon=
d
> argument is never below 12. So whenever the third argument is negative,
> first_line_bpg_offset (and second_line_bpg_offset for 4:2:0) is set to th=
e second
> argument instead of 0.
>
> Fix this by swapping a and b in the last step, as intended.
>
> Note that this change does not affect valid DSC configurations. The third=
 argument
> is negative only when bits per pixel exceeds the uncompressed rate of the=
 colour
> format:
>
>  - 3 * bpc for 4:4:4, 3 * bpc + 2 for RGB
>
>  - 2 * bpc for 4:2:2
>
>  - 1.5 * bpc for 4:2:0
>
> Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> index b8fc27a5361e..657173d8081c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -46,7 +46,7 @@ static int median3(int a, int b, int c)
>         if (b > c)
>                 swap(b, c);
>         if (a > b)
> -               swap(b, c);
> +               swap(a, b);
>
>         return b;
>  }
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
> --
> 2.43.0

