Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99234C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84D310E262;
	Thu, 10 Sep 2026 10:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OO4tVS2A";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6709E10E262;
 Thu, 10 Sep 2026 10:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XChIr5U+eoPhbxFSS/jpaQ9gqdC5Dw3VptPWc4sajziPK4184/hgxmDoKGlGFyHhTLFsUz+WWLDHynuzDEKCKMbe3EgXAyA1m33uDA29QvcaR4aVQprelyPNC1mwe2tjJX93ywJXRpCR/yC/hh1NYWUqWb6dshlLl8biC9EisErSZCEqZX0pRNW6wX13SpNXCESMAIgc/3Mos32GBju5VbrNGoxvdfAoSzy0+hh2XADhiCDwJy4dhDKUSd71HcGkTIPD1FTeYrwZyRwE4X+1Wt7/N9xY6K6xSV/28O/U+BNuh9pKVyoRJBaIW42QamuS3OKlV4ZcLhfCYjNsD/sLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP6F6Pd4VtpD8GCG1OpEFG3xC7ZwWprvhggx0IE2tuQ=;
 b=UQ3oQqONyWy23XY/1nC5VwiEi+YRUIEsYn3wQ3VgB3NMF/M37EjZORG5t4ObVxNXNUAJZXr1G7XNBapwtSnUc50RN5AHk7mN62e7RqAaXVA1NKfGbvExGSoKlpUUrbgZQgOh0WaaJxOOnnJidT2CvruQlpP1GfXCFQjbJa1XgPLNWIBGLAH7USUWuIO9BXNx/czx5BuzN9CvPoJsnms+ktFUbBQ9eZr0kdPe934jVqesnkkWoQkFtEsykAYzdOY114OhtJMR9d0Rvq+utCk7gRtGDxfXH8eB4qVUZITgOX0s01CgbduxYACp2OI6cmGVnMJO6fzOIfCaJF8FZOqpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP6F6Pd4VtpD8GCG1OpEFG3xC7ZwWprvhggx0IE2tuQ=;
 b=OO4tVS2ALDdoy2yhtKeoEqf1xxq+atJ5fIKyZQhnO3BSmfEWZMS9WvJsZrVpAuzkkF7C/oPwlHWNpJa3nTmiHtjaeOeT+ivWcCG1FQu0X7xu011G28J51d3RrjAgk1PyvNOE1s2r9+WK+jLRC6BNqAOw+hoYVa0O6sv+kLbdltY=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 10:31:39 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 10:31:38 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Ed Schofield <ed@aicharmers.com>
CC: "atharvatiwarilinuxdev@gmail.com" <atharvatiwarilinuxdev@gmail.com>,
 "062bel313@gmail.com" <062bel313@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Thread-Topic: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Thread-Index: AQHdQFe5SjwIreibnk67bm4xdPhAZrbHnibQ
Date: Thu, 10 Sep 2026 10:31:38 +0000
Message-ID: <MW4PR12MB6803AED9EAA4A98576CC3F428EBF2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
 <20260909123443.88228-1-ed@aicharmers.com>
In-Reply-To: <20260909123443.88228-1-ed@aicharmers.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T10:30:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|MN0PR12MB6004:EE_
x-ms-office365-filtering-correlation-id: a4867a0a-f6e8-4f77-76cb-08df0f26b28b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: NK82oh/dQXWhsPoEeJa+5cG9dl1/w8LDlJJFL0mxym3FiCTlDNCFldZrR29JD3UeE2eTxhfMv/KNwwO0u0jnfw10tl06sm8ppQ3OXHegrCD1B05r2frzu6YwnJ1e58vGSz5gaeHSpbJjkLHp5qo0ls4gkUHPt1PwjcNviiPLZo6NK6yxJHxPNcq8EyYYwE1FXA+sXATMnrk5AtPGAUeJNtPF859J8V6rOYKCP38JoyiPOJTBrs1jBPaUH+Pjsa+IT8MAdt7PMmGbf7rz1Q/pvLnoQ/DiXnyKf6y7J9/9BkP0lLnk9JKSadc0hnLA/NkjO8UWXRhukBec8kuV4p7gWf8NueqHMqFFWdTmpVoFYPWaI4mjVlIjmx0yCkUqb7jscI2sHmqUbTXcXk6Irh3w0g+OsltI0W3KaeyXubEeRlsTUiXzsxtfe9V2Yn2dMk70mSO4EimqSk99NoFjBblR1+UruD0YVWAGZw6MuSvE+xopuPjzlqxp7VPXEKjBqbWLKPQhJFsVgsPSr3HsyImwOOyytnJRLGo9J5HORMM/nk5U2YRME3E8+z84Ih1fxoqKtv9X8colMos8TeyIy/j2GUu0Sh05iSsEy4aj9dGvgTPzj5eY+t3iJ8PDclzur3/m7vPs0h5skw0rcjoEFKNL4YPA2iEEZmq6WBHSZB0igKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vncv4bIgfk1UdWV/W5n6KBRimrbOW1pSG+0C6p5D0lbzSt0FNqp17NYzDKGT?=
 =?us-ascii?Q?yy3e1us9JrQqcAZUtmjIGw7lrPkbdTLJVJ5IXTZp6jBzC2PpgIu+lYZUxb+E?=
 =?us-ascii?Q?xwcuxQe6V6UGi5Au0Qpaz8CjKvSFRL4jhwqooZfk2LyWb8WCg252GVNRlSN3?=
 =?us-ascii?Q?j+v537WLhgwcG/8x4MAlWSIX5KCVqykMr/ySQkIHJckoxuZEFKrpktEqrcXv?=
 =?us-ascii?Q?8TghRF3dvTAenUZXgVFdj7PHpdB5H9r/B1tkY86DZuphhASaPb5Gw55IXL2K?=
 =?us-ascii?Q?/34DKCMJtScaz3xQk5IhZ2WR01pKcWnZ/9axyysyd9X2uhQRLQ1+6PLBoBhj?=
 =?us-ascii?Q?RTjdt1MrXF831numhKMvUNXlFJis56ohIygYDv9whTN3L8WnDTp3n2yjWeWo?=
 =?us-ascii?Q?mo3Wi08TedTJBQmECs3cuiweUFIKaBp2fSrReReqiQZ4zsmeJ5lutdaxMCbJ?=
 =?us-ascii?Q?evBuD51OkLSEhRtWra43Lu3MAQQJl7lO2yTu2zE9VmaB83IXuwqvCoZxc3XU?=
 =?us-ascii?Q?0K+/WAPF1ql7ugQynqIkX0XJeRqmieTKxmciDBDSJjYs9+a+eBttf49iHfh9?=
 =?us-ascii?Q?gtzw0HM5ZPADG7LjU9iHBWJK/o+GTfNGYGXTnSqut2vucqlVGfpjaTMqBNfE?=
 =?us-ascii?Q?S7HZmQy1h73NCd0gjwZeoJLUVA09IWneal0XvRYWkySrHXtvmYztVqEE9BBe?=
 =?us-ascii?Q?82BTW1vRF2N8ZuxJOUslEP3qEEiUi3jNSgkrARC0Z2szvGY9LRga19EL5DPc?=
 =?us-ascii?Q?Y/jljhq6jXSsnMlZ5Q5joyb3eigrq4leXMNIu1mUPbSesdbG0Tp/AND7An6s?=
 =?us-ascii?Q?I3Bx5lIhQbEvsLBh6ERNS7LqQRyTlbniJuKIZEdHJdLymj8TSLoYaOMW7Oyn?=
 =?us-ascii?Q?kV5NsyhXQUZAnOFCRzjkF8EM4Z29Fdb1eGSerMFfGb8Or+Yap33e0cLZuXp2?=
 =?us-ascii?Q?bnu9g959BPveF0AGYabbxAWre6ZlAa7hRdyeKIrMg5im6OlKLmoCUuvBah0H?=
 =?us-ascii?Q?MEPn7PfuTXlEw1k3nSbxcrNDNd35t+2Rg9TqQg6Ecl8DE/0ueMSJEDqqyXnC?=
 =?us-ascii?Q?u2B61AquIz9i7yal1U4Ns9EBsdJviUGyjsSj8cJFH8py0MADHjWxEcLrI1e9?=
 =?us-ascii?Q?EjWjuUn+zKMXBZLLLZQzJI/RHEDxuko10PDmXcQGM0g03qGPW7/OpUpg1e/T?=
 =?us-ascii?Q?zFFG56c0F4Dxl+qNY4zS2nCt0pxZ9KUWsQmij39nqg6rBYwKa1bt4D4B3s5W?=
 =?us-ascii?Q?Zgk/HzpmuapLaQeW/K0HGqLTMlBmml9Xu14pSN+WdM3J6jx5+aGQkmqiOMnI?=
 =?us-ascii?Q?lLrg9xx43zpM3j4oKymfEqkIUflUnJOrzkT9dAqIg1qP67klGp6aNlb380Yz?=
 =?us-ascii?Q?mCPGOpamSKZmnFHmUjXI7+9KW0qf0DzcSotxvgjx/YFscZhb+LHmOnee2OIt?=
 =?us-ascii?Q?w2nijrLCjK+h4/cResfl4AkFYJV3avRiVK/6P4dsrz769qNx5x0ytoOslq/N?=
 =?us-ascii?Q?r65xD6WHk3r5615uI46xITD6tOecEkfx7XimOQYeRnsAg7haYJYAQbYId9Bf?=
 =?us-ascii?Q?Mib2l4piu7EwkNtO3QlnNgAuOKJ6UinMr7uBtnEjQ50fPkQtgcL4JYVzqLvN?=
 =?us-ascii?Q?w5Usavyz4yKIktNUwWAb9OuLCtyEuMTVwBI2BVlfbLmcAI93oZpQ3sI9qxBU?=
 =?us-ascii?Q?M0MHhufzsnYGAtcG3Th47AJRG6Wpqzi71LCeGgUpYHcROqBH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4867a0a-f6e8-4f77-76cb-08df0f26b28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 10:31:38.7796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixHdxV8qo8nq42nGVLPIn+vcy9RiB3UHuBfNfwCtPoWy3uFIBwaV13KB9IgdiNyx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Ed Schofield <ed@aicharmers.com>
Sent: Wednesday, September 9, 2026 8:35 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: atharvatiwarilinuxdev@gmail.com; 062bel313@gmail.com; amd-gfx@lists.fre=
edesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com>; airlied@gmail.com; simona@ffwll.ch; dri-de=
vel@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14

Apple Navi 14 boards 1002:7340/106b:0218 (revision 0x41) and
1002:7340/106b:0219 can time out when EnableAllSmuFeatures includes UCLK DP=
M, leaving amdgpu without a DRM device.

Exclude only UCLK DPM from the initial allowed features and enable it separ=
ately in the Navi post-init callback. On 0218, enabling UCLK just after Ena=
bleAllSmuFeatures or at the start of default DPM table setup still timed ou=
t. The earlier 0218-only patch passed ten warm boots with UCLK enabled in p=
ost-init. The earliest safe point remains unknown.

Check the enabled firmware bit, update the supported-feature bit and rebuil=
d the memory DPM table and sustainable clock limits before the UMC workarou=
nd and UMD clock setup. Validate the PPT memory states that
DCN20 consumes before post-init. Preserve both memory-voltage features and =
honor PP_MCLK_DPM_MASK.

Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi post-=
init implementation for 0218. Retain the revision restriction for
0218 and the revision-independent 0219 match from Atharva's proposal.

The combined patch passed ten warm boots on 0218, with rendering and
H.264 video decoding checks on every boot. Testing on 0219 is still pending=
.

Link: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.=
html
Link: https://github.com/t2linux/kernel/issues/19#issuecomment-5537823876
Assisted-by: Codex:GPT-6
Signed-off-by: Ed Schofield <ed@aicharmers.com>
---
Changes since the 0218-only RFC:
- Add the 0219 board match from Atharva's proposal, without a revision
  restriction. Keep the 0218 match limited to revision 0x41.
- Keep the Navi post-init implementation and clock-state updates from
  the RFC. Atharva's proposal enabled UCLK at the end of smu_late_init().
- Record the failed tests at the start of default DPM table setup and
  ten successful warm boots of the combined patch on 0218.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9a..d7cc41a5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,19 @@

 static int navi10_init_ppt_limits(struct smu_context *smu);

+static bool navi14_needs_late_uclk(struct amdgpu_device *adev) {
+       struct pci_dev *pdev =3D adev->pdev;
+
+       return pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
+               pdev->device =3D=3D 0x7340 &&
+               pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
+               ((pdev->subsystem_device =3D=3D 0x0218 &&
+                 pdev->revision =3D=3D 0x41) ||
+                pdev->subsystem_device =3D=3D 0x0219) &&
+               (adev->pm.pp_feature & PP_MCLK_DPM_MASK); }
+
 static const struct smu_feature_bits navi10_dpm_features =3D {
        .bits =3D {
                SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +369,11 @@ navi10_init_allowed_features(struct smu_context *smu)
                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEA=
TURE_MEM_MVDD_SCALING_BIT);
        }

+       /* These boards time out if EnableAllSmuFeatures includes UCLK DPM.=
 */
+       if (navi14_needs_late_uclk(adev))
+               smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+                                          FEATURE_DPM_UCLK_BIT);
+
        if (is_asic_secure(smu) &&
            (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, =
0)) &&
            (adev->rev_id =3D=3D 0))
@@ -470,6 +488,25 @@ static int navi10_store_powerplay_table(struct smu_con=
text *smu)
        return 0;
 }

+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi14_imac_check_uclk_states(struct smu_context *smu) {
+       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
+       unsigned int count, i;
+
+       if (!navi14_needs_late_uclk(smu->adev))
+               return 0;
+
+       count =3D ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
+       if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
+               return -EINVAL;
+       for (i =3D 0; i < count; i++) {
+               if (!ppt->FreqTableUclk[i])
+                       return -EINVAL;
+       }
+       return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)  {
        int ret =3D 0;
@@ -490,6 +527,10 @@ static int navi10_setup_pptable(struct smu_context *sm=
u)
        if (ret)
                return ret;

+       ret =3D navi14_imac_check_uclk_states(smu);
+       if (ret)
+               return ret;
+
        return navi10_init_ppt_limits(smu);
 }

@@ -3219,6 +3260,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_c=
ontext *smu)
                                               NULL);
 }

+/* Rebuild memory clocks before the UMC workaround and UMD clock setup.
+*/ static int navi14_imac_late_uclk_enable(struct smu_context *smu) {
+       struct smu_11_0_dpm_context *dpm =3D smu->smu_dpm.dpm_context;
+       struct smu_dpm_table *table =3D &dpm->dpm_tables.uclk_table;
+       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
+       struct smu_feature_bits enabled;
+       int ret;
+
+       if (!navi14_needs_late_uclk(smu->adev))
+               return 0;
+
+       ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT, =
true);
+       if (ret)
+               return ret;
+       ret =3D smu_cmn_get_enabled_mask(smu, &enabled);
+       if (ret)
+               return ret;
+       if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
+               return -EIO;
+
+       smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
+                                FEATURE_DPM_UCLK_BIT);
+       table->clk_type =3D SMU_UCLK;
+       ret =3D smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
+       if (ret)
+               return ret;
+       if (!table->count)
+               return -EINVAL;
+       if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+               table->flags |=3D SMU_DPM_TABLE_FINE_GRAINED;
+
+       return smu_v11_0_init_max_sustainable_clocks(smu);
+}
+
 static int navi10_post_smu_init(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev; @@ -3227,6 +3303,12 @@ st=
atic int navi10_post_smu_init(struct smu_context *smu)
        if (amdgpu_sriov_vf(adev))
                return 0;

+       ret =3D navi14_imac_late_uclk_enable(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", =
ret);
+               return ret;
+       }
+
        ret =3D navi10_run_umc_cdr_workaround(smu);
        if (ret)
                dev_err(adev->dev, "Failed to apply umc cdr workaround!\n")=
;

base-commit: c22f9a61e288580824edbbc3ae5a29c9a338594f
--
2.55.0
