Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E5606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tsziDafB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EFDE10FC71;
	Wed, 11 Nov 2026 17:10:28 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6D710FC71;
 Wed, 11 Nov 2026 17:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD0hWWhO9C1DpJ/FrSA9/MIfGbc943JIxWUwN/fsS3xKXPqZMV674F7B/NfXKfkh0unh7EcYv87qe7MhiO4yDxBmbKv8uxgGqf8tWmCyquUkRmTtFs3Dg7XGGB6m/JwahJQ+sTQlT2gizPLk4MlS08dGadJDlr1SXVjcuA2VDP6Zju+GfjM3mC+0sHDJfrOR2iptf+kWraILuI8jqexMGatkXIZsMZfVTXMBaWsPrMoSIZJajA4n3MH5xVKMfh0xJRaYLnZDk1+FZfGVJJDWDouTmte0JEJfuu549wi7qhcSHOhVs+zVPr2L/jTyKrWYNTkvWMivVLIW2GESsyNruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9uyzYOsKSWL8nda0trx7hUSH0pbxRL3k184tQVm6Go=;
 b=EzRnq/9lbPhSJ9nmzAowaNAGjePS79sIOYUhlltS8nYUJ0aTqqicudnStO1A+qOt0EEfoH6F7aycs5fdAGgSQPQ4IH3N7p9+ciwsD/y+S1R7IVbYXqI5vicDd+Bp/QuumCg92yNYE4O8ripvnC857pR5uK3DzJ6/mfvWPacLpqsV/Qvn1JJmuUEqZM2hsOkeZDLqk873NZ4ZpV0DaHFz2ASevm/eZyCOt7ta+sAwCC7g/9If0Ru7rmXGxmA+fW45xfrJmQgoXSFciAWwPTDsJILseO6Z8p+PQFMs9iOGGQdfZ3qvoLW1CZq/+TOE+WZZZ0iXRy8TkLvsopnIvKvPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9uyzYOsKSWL8nda0trx7hUSH0pbxRL3k184tQVm6Go=;
 b=tsziDafB/NFo6mrhoEL5pUrXGwwOfBYrvtO28yPq+1ugjNOs99E8rmJUMwbNFIxbXsuL01QoSgP/Z/nAYYU662M3T7s/dvRJJBn8Ql/BbD4pZ/vHVm2cshogsTZDmUWCQozfocs31q8ZjYD604LxSm605bqQkJMERS81Y0vsr98=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by CH9PR12MB987669.namprd12.prod.outlook.com (2603:10b6:610:312::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 17:10:18 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 17:10:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "jiangwang@kylinos.cn" <jiangwang@kylinos.cn>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso
 318F
Thread-Topic: [PATCH] drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso
 318F
Thread-Index: AQHdcO5qImP/P7aB6Ueq8Af3p5CPT7cpHRfw
Date: Wed, 11 Nov 2026 17:10:17 +0000
Message-ID: <PH7PR12MB68127DC58AC94207ED76ACB6F7712@PH7PR12MB6812.namprd12.prod.outlook.com>
References: <20261110083453.1008827-1-jiangwang@kylinos.cn>
In-Reply-To: <20261110083453.1008827-1-jiangwang@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-11T17:10:02.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|CH9PR12MB987669:EE_
x-ms-office365-filtering-correlation-id: 4b73a3a2-455b-4100-93b8-08df4016a8ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|260925021311599003|260925021911599003|260925022911599003|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: v6hLZxYqEq1LPDP4KGtknDdlDA8vqRCBOKIYazLbqSyEKz2VdYHQHzXiGvcMBQ3YM+l0IbVHU8pUREmZYk2PmdLITshOykRS8NaiXVNlUBloKYEdPj85F/A5Ff5kO63w6KTTberUetLb3JFIEOgQ6ZMpiHjLZIo2RObPzckS7f58fNT/pE2dp5jncABV/qqlwnhrz2cf3gQaXbbsHU+4iw4QDaSy0iTGQs/GiOyryEyu/sXkQj660qfKBsa/rNbQwtVr45+bN1T/mHzkDSH8vrG3fvCoWfVwE6fMTukyQ9kuSlRF0j6tKIzIf8RCz81xZ5/6f21GDYZNVboGubrN8hH+Fca8J/kTqsXav0c4QuSx+C1H1GVS752efRQwBMu8QmGDJi7uQmw/zl+coNLrj+jxG8MR9EKyYX9CdcMgq1rHCIbQ0OK33ob9vXtspBm9VizQyweDH2BIFO+f7r5Vxxd4Jk457NfH7NCyvirU5K4Bne9wTOKQ870s/jcNi6tsdg5GnqtVrqwhX/mnY3bz4BJbvpC4zBhXnMyZZtP2667wiKL0UZKuOgzeOYHH5HNGCmqNaRQPGFkN5HNMN+SFMpGM8f4U9ShFxareKz3iVI/gAv567QUvhOinLW6xq+TGcp0r6iq9KcrBfiS14SmSLxFQmdfQu/kByEHlLP0DKeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u5/ZdspY5hsPGpPflxlUVkmCqRSRi8T/DeyG5UkX5JYqIWUiP4I6/i02Ar/a?=
 =?us-ascii?Q?MUeSoSlsvu8zijKUTicemi/H5dALnxbo0PDod5ai6tvuqQ1hwxAkz/SlDc0S?=
 =?us-ascii?Q?twFiIM8x2FVhluoEGKhFf7VZGoP5Y+zPWnT24K2FCCyGcnaIUidbNdfV/GIO?=
 =?us-ascii?Q?AFjkVQbxgKBZYl7FLqpadooCou0QKjKSf1wKrSIj0aarQSSXpA3GhGdt5bPN?=
 =?us-ascii?Q?AnHXg3nzgO0rkBU8PARvPpFlUC6xjG0fNMUX/FDDUvCga6NYMX23chBBggJl?=
 =?us-ascii?Q?ulVXGKaggMrNh7QCApop7vYniGvE0aktS6QdVIKrWrjPbf5eHQv1l3cHIut1?=
 =?us-ascii?Q?Dq/v9bn+NzbTG2Ka4Z8RYk23W1dB4B6Xoq4yXUqtFHu6fpQFldBFUqqUfDDL?=
 =?us-ascii?Q?IIcqAOP/qys4EQdglkr7yWL4xaPtRL7UDIPBxEXpgL3HF25HcvYGNwPpc2Uv?=
 =?us-ascii?Q?LFd15n+BlHBm+Htn8KZdj1J362hleBDdiWodSAO9IWF1UpaXk0m9oAU8+mA6?=
 =?us-ascii?Q?PFQMjnCqByFGGMvSyeWxVggsFIeal1Xx2ZRVG7pv5Ykzv0HaXdm0vx6wuJlQ?=
 =?us-ascii?Q?/g6S39hS9WOByWqnXY5vDEv70nMpFxui5f8rIKH6jYDv3fHgcSjuR3Y0uPLM?=
 =?us-ascii?Q?AronAqyrPXSh+Ja6w+2rF5flgw3hW7YiNLFIoMp6Fbk0jttbg6RryZJF2Kog?=
 =?us-ascii?Q?nFC1+3Qibf67gBWWFZgqIhwci1bCMNkVwH83a8GxSD6EAyiHhytjwepRKI/4?=
 =?us-ascii?Q?MZHfggNjb1CDCMWUCC90OLKuKqz0CoRCXHoxawYba4vxWgLpkMzxt0G9Wv/l?=
 =?us-ascii?Q?2v16JFTzzvdjR1jGYKYwDazIJ9dHs5bUyI79UNJQmS5PuUNBRq6KBaZohd89?=
 =?us-ascii?Q?EJrAV5pxIKBh9t3theQJrsfmubVy/t0FrO0TOuuv5KX8woDD+bjsxID216jP?=
 =?us-ascii?Q?8LC4YBDqbYQvWf1AhMy+6h5w+wY4fsIKniK2ln+JeaIo+xJ3Tpa/7PMLpQv0?=
 =?us-ascii?Q?BvS2LOLXTn4qmxsPVZ1/xj6nI4pXtr4rxsR1uWcYfPia/hpsIKUU8zV9G0zx?=
 =?us-ascii?Q?lp9gK70WiSto5clZdhT4t8uXYSyd2pkwg1gVNgoxZlosez8D2wup69frnZoA?=
 =?us-ascii?Q?5eJuiQwdTCY0zt9wNhjKbkve5BSgUW/on7OKmrTdTR979papF8YvDvngjyEm?=
 =?us-ascii?Q?cr3l9yzgbAfLO6T4aC45kviRzx9A7rxCz7Fnha82UqqhSPdgxbNaKoWIf3zq?=
 =?us-ascii?Q?sq5vRRACWGU1Gem5zxtlLiNTaWA9t8FSh2LvlgzAfH9Dg48GzsC1tIPNP/o2?=
 =?us-ascii?Q?2Au3kVxj2cvLGt2DJ/GzTYnBekdmTjW7n9TyMdlDQuOICf3jcS5sCnfjcN+g?=
 =?us-ascii?Q?IfCy08SmBKC392aVdOKLqgqYuz+ZhqJlU8DCTedl/UAxwv9qaDd25WmYA5wi?=
 =?us-ascii?Q?R7Q45OetncLO/YWbHXLN04RaScw2kyexI0E1lyWwesGjwgBJ/LPY8FuP+XRI?=
 =?us-ascii?Q?uyqUMOFIfSqIj7XcrSMOS67E/JjRFo0Fgh2MVRTFQ9lzHO0KlH0bUxdCrYm1?=
 =?us-ascii?Q?zE8uap25WyzDHRUiNQnKlY6qjrzbFKhMHQLZi11JodSUn+ppba7m/fTZkIOi?=
 =?us-ascii?Q?MdIY/AWxwQgp8XQYDirsK6SSWKU3cre1JkgJR97jY8mz0vbJnu537y5lL4Ji?=
 =?us-ascii?Q?iBwJ472nO1EVBlSaUj1Ew3L/Dltlo5q4UObzgZTMYBtinNAQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b73a3a2-455b-4100-93b8-08df4016a8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 17:10:17.8308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auGR3ys3dwuXVbqwWsmuQ9K9ikHjowEXoXToiy6hPqdJwg1DEBKX/dGinFVQCG3o95axsl8DTR3I3F+/MkIO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB987669
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: jiangwang@kylinos.cn <jiangwang@kylinos.cn>
> Sent: Tuesday, November 10, 2026 3:35 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: airlied@gmail.com; simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dr=
i-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Wang Jiang
> <jiangwang@kylinos.cn>
> Subject: [PATCH] drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso
> 318F
>
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> GFXOFF causes gfx ring timeout and desktop freeze on Lenovo 90NYA05DCD
> (Ryzen 5 3400G, Picasso). Add a quirk entry with ANY_REV marker to disabl=
e
> gfxoff for subsystem 17aa:318f regardless of chip revision.
>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>

Reviewed and applied.

Thanks,

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index c3322058720f..0cec645710b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1365,6 +1365,9 @@ struct amdgpu_gfxoff_quirk {
>       u8 revision;
>  };
>
> +/* Match any chip revision in amdgpu_gfxoff_quirk.revision */
> +#define AMDGPU_GFXOFF_QUIRK_ANY_REV  0xff
> +
>  static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] =3D {
>       /* https://bugzilla.kernel.org/show_bug.cgi?id=3D204689 */
>       { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 }, @@ -1374,6 +1377,7 @@
> static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] =3D {
>       { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
>       /* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
>       { 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
> +     { 0x1002, 0x15d8, 0x17aa, 0x318f, AMDGPU_GFXOFF_QUIRK_ANY_REV
> },
>       /* https://bbs.openkylin.top/t/topic/171497 */
>       { 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
>       /* HP 705G4 DM with R5 2400G */
> @@ -1390,7 +1394,8 @@ static bool gfx_v9_0_should_disable_gfxoff(struct
> pci_dev *pdev)
>                   pdev->device =3D=3D p->chip_device &&
>                   pdev->subsystem_vendor =3D=3D p->subsys_vendor &&
>                   pdev->subsystem_device =3D=3D p->subsys_device &&
> -                 pdev->revision =3D=3D p->revision) {
> +                 (p->revision =3D=3D AMDGPU_GFXOFF_QUIRK_ANY_REV ||
> +                  pdev->revision =3D=3D p->revision)) {
>                       return true;
>               }
>               ++p;
> --
> 2.25.1

