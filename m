Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A616C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9D610EF78;
	Wed,  9 Sep 2026 07:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7DZiH3T";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD0510EF77;
 Wed,  9 Sep 2026 07:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0DzyUbfTncMAfrlO3bZtotd/Qv4Tytg6608hp2YrRw8oaMKhGBMzgZHtjbiyVJxOp0b3qIGDaOoq570grVUaK/GDJB7L8M3EHBiInMCyu+5Vvds+HgO1XmMrxhegIepfUJxsttlinTZwNpqOtxyC+h59dBBMKnKYhDne6TtaejuNOIIQcLRQGPg7BIt5AugN33hVg406duP8cuDhpY5jJF65D2GTK+u5l28Wu2NtijL7MTORo7xW2YbrCDxcwd2CzG0/PoJJO4NLEe++6WTGyhhdbFAeK4kIjYJMU73q33DR+tAAPjhzFeY3a494MwAH6UHB0Az5nEfQZk0+R8y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ceg6YiE1E5WaDiw64jHGUklgCOYbHYyWU2Zr1b+ClgQ=;
 b=SghVLmJmM+B6OjJwLszVmTvxoPRJ6glIp3vITTDAp8GDBioB3ZKIx7XyvDFRUXhH+nFkyGHf+AADVHHv4E7J8686AFPyAiAN6wmw/4l/cmZI2l4ORLEs8rTN/kt9rNLuLAtqbVkqVRPtQ3zgaqsLHgi0bO/7IqKJNLTTD0Y0VIpurWWe6varizRIGyCD/IKYKZGYTHKxHEhKnrX70z/gPjUJ/GbC2H6LXRECYcsj81m8kmme/8NrK+APs/2wWk5UZwA+02UFR9Ba8JnhUg7pnFa6JmRsRrA76hhHiV6oii7MnJuu+AzmgNstLgGNoBiKI6McXu4HcvpAGMo25KgBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ceg6YiE1E5WaDiw64jHGUklgCOYbHYyWU2Zr1b+ClgQ=;
 b=b7DZiH3T7aKBxAXm1tcKjMY/MC8zBEElAJensUjK5khMuTh2odXzpwDx1ikgUzlYdr/lLb30JoQVyhYzs+vcUiePFOk/91FFvB3hP3hFirJktPLqW5dM1n4heWScOjdCbQY1i6a9fYlFSShkq678J8AXSApYPaY+TB47xFCt+kA=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 07:05:51 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:05:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, Ed Schofield
 <ed@aicharmers.com>
CC: "Guna R . Bharati" <062bel313@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Thread-Topic: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Thread-Index: AQHdM/uLjqzkZB8+v0CfrEH3NFaxZLbF5zkQ
Date: Wed, 9 Sep 2026 07:05:51 +0000
Message-ID: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T06:51:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS0PR12MB9345:EE_
x-ms-office365-filtering-correlation-id: 64b59fc1-ef0e-4b34-6eb3-08df0e40c858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: aSbEtr5UJu9YIy4JmO/qiSLPLuTIfjChSnAw35p0gch8YU5fW+zuppb+pAOSNbGF0bnHTsW2ZlDt/8gopzV7mETWcj4agdEvvxL61BYxqKl0NO0upJzqQN5RovGJxcyr+60yRQBXJ4IOYkb0tplu8rED5nEGCN4HgTwDuBltWgWxQKvEwPzxxK3yiCZfDUTtg+3x9RDCu4fM5ZdU/k67+DAM7Vl7D2fgeoL+m07AX9PWyGtGQYrjDtMopGppLdnmHxoY1VqmQul/576Tjut0gfnetxFksyaRnXy4dRuh2inkSLRB8SC1yV/Q5hVXXqavO8fw6HeayY5LgG1OKtGGoK2ELi6UxW/rnnZoXbIdXjKFzWXX+4okRquRVJSlAyYAKaXCQ8RnscUnv+BT33HStyDyI2ZsP9e2Yc3qXx4tetmAr9RMv/u9OMT99R0Fhl+/VivT6VNQ4pcwe3JJmU6Whh7FJOGJu1E6STOS2GVdZPMBJ/HcssZi18/Cu4Bnia0reY3bonbRreWirv1D0KU2pvasXlAcOhjqJ5L+suBKcgPK/Kw1k/fBJrbDj8L41B1TZPlWLUATauA79MGH+HZa2qoh67s8P6NZ/ZfugQk/OflaNJPrXJEBAzoHxMVGWI/cnoynS9ZbIGFgD7K8PGFzF82y8f+sdKCyB7N8ACctzvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rImCTL7CtrF92USAB6jimoUtgTKdQo25GS1Pd+ulj1d5Vc9hmy/jgfleSD9x?=
 =?us-ascii?Q?CN/SiVfyC+VIsLXIw0DdWwNT+OijaM9+RYhwclVwL0LwAG0CsrD966TY8mwb?=
 =?us-ascii?Q?7BV2WFjZAwH+6gRP+hYy7wswcIPH/yZ78EIgSKwzcwcj+xFCa6x4MkPD/+qd?=
 =?us-ascii?Q?NyKpRd905ppH/nhK6mKKm6d9aGcLoKgfJtzhSsWJn6vbWM3wQaAtLxrLpcOC?=
 =?us-ascii?Q?xoz1Jlt9aKYrVAnQW4GUeiNYhIA5vQo7s+55b/IE7/19ZTdhja8sTKjIbCDw?=
 =?us-ascii?Q?7inl/fzx/9Xf9P6cxGmD/kSShQVhBCJqEmd7TiYJF1dkJvPonLW/saH6aCNr?=
 =?us-ascii?Q?Nzkib5r8AHwVBu/XnTlz+Nw/lzYy5vBop8/Jr1P/Xj/UFprI74Ur/EDY9TNB?=
 =?us-ascii?Q?CGUPasdlFZoGY7chdQWvkgnsXIhVWH1w8ntcuWrU48C1dvCp4xMCKsRT5m7j?=
 =?us-ascii?Q?FvYx5pwBvFnW28pKX94hsjLImM1iIAc9MOuKnjfphvUIT/iXHiCIQnrRlydH?=
 =?us-ascii?Q?J7T10CU7ZAsaTjvHDPvU2sE0yWZvp9t8+VqHlGNSh9Inmz4Nf3BVgwIaiCIk?=
 =?us-ascii?Q?ZS3PoU7BEgBPbRrw/LAvIvHwtYf1OtwQ7ys4pcp56cs1BWZOhQnu3p58p5QB?=
 =?us-ascii?Q?2Ov5/9tcZ/31mGR1uJvsDbbEn2J4CQg+3vxVIuLXrUWsaRtwMZGD3LKAoRsi?=
 =?us-ascii?Q?ycoHk41HhlPcknq6P7M0ZpjKtDa4rzip62y81jma1x6x5rS9tDUHWwVIov74?=
 =?us-ascii?Q?fOtvoTBnnwyAhlBsCF533M6zb/E8gESLf7mF/61LjLhyD1ZxS88CzF/VAdBj?=
 =?us-ascii?Q?kzbhMmSxe6mzWEg7OCTvenn71dQrXgK1XmQ7lLV2yOkbEyvYick/o2KHvjlU?=
 =?us-ascii?Q?pkCBoIpGc6JSTixOaXthIpER06zIHRUm7Peg6sJhoLFNSNJWoq2xitW1DIh3?=
 =?us-ascii?Q?M8SwJpsMfIBThSzPRa8RNO2d8C/2MmiLp2qwAOeVvkPNYTnb+fFev0WhYlvD?=
 =?us-ascii?Q?z9GnIJI963Z/xATNKnz8MYfDO6ACXAfMbF6xT1dfiZkGaWb18eFTE5XFCLqm?=
 =?us-ascii?Q?9gMacOoFNS/4hxpJ9pUYI9wpd09DIhaBo0iQDuW0xKn3vn8rSkFCkLt857oG?=
 =?us-ascii?Q?0U4Qd9rIIun4KXXcZHmHNH8yM/yy0uUC1lZpoAJOAlhEdM15EyY82dBdvpLD?=
 =?us-ascii?Q?vaytRVuo2xNq0EDeZX40hVZF8GROpaM3bh4eABGvwo2xFvuztM9U9FgKUXZC?=
 =?us-ascii?Q?/y8bnFxio1PRDvysrWDwIDAVH1iKkg4StYMBhbz+5h4jrHWTGOctO4T4Pljk?=
 =?us-ascii?Q?YYtt1IlyGXIY3hlwhH/9zVlW049NqHNU6JVHBqrtQTUt8jIJhLwWHRncgyGM?=
 =?us-ascii?Q?MLc8OgycW6Z3qEBG225AekE1Q30oOw/ps4a4waQvKyFHxQtq5A20xBa+rUow?=
 =?us-ascii?Q?uRIRDVBMwCw4xcwOjl/w0qKtWSBtSgWvYlNeRGvCI9I6QwTZmCT8+cYanw8v?=
 =?us-ascii?Q?7MK8cWJJsePsoFl4uj/m+VqP5Jokbz93GAejXfxKPCdlQo+PFZ6F9L0/kYy2?=
 =?us-ascii?Q?CIaUPgpCCLBKIrj5MynL9xzKOMf283AUZDwYpL7twWPX5RWKU3Q9GajZtwV0?=
 =?us-ascii?Q?rzsPN6iA0V38gu9JY+GnqyHYtEp72XG7JQ7tIyXqwXtfy3Pb7+n4U4uSz6Im?=
 =?us-ascii?Q?6Jh3tsjrPWP+/VZxRYsxa6aI8B32Rej+HqaW+Wf7RXluiCoK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b59fc1-ef0e-4b34-6eb3-08df0e40c858
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 07:05:51.1724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kU+/4A7g5GHVnAx7YK9gc6p9qCCP5sY2YiOAnToQBj6dZF2Q1+ACgXhn7dLBDS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345
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

This issue is also addressed in the thread: [RFC PATCH] drm/amd/pm: defer U=
CLK DPM enablement on Apple Navi 14 0218.
I think the workaround can be merged for Apple specifically between this pa=
tch and that patch from Ed Schofield.
The same questions:
1. can this workaround setting be put right after the SMU_MSG_EnableAllSmuF=
eatures is acked?
2. Does Apple accept this workaround instead of a root cause on how SMU_MSG=
_EnableAllSmuFeatures is not acked back?
Thanks.


-----Original Message-----
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Sent: Tuesday, August 25, 2026 3:04 AM
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>; Guna R . Bharati <062=
bel313@gmail.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;=
 David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; amd-gfx=
@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.=
kernel.org
Subject: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro 5=
300

[You don't often get email from atharvatiwarilinuxdev@gmail.com. Learn why =
this is important at https://aka.ms/LearnAboutSenderIdentification ]

On the AMD Radeon PRO 5300, enabling UCLK_BIT in navi10_init_allowed_featur=
es causes errors such as:

SMU: No response msg_reg: 6 resp_reg: 0

or:

SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000006 SMN_=
C2PMSG_82:0x00000000

To work around this issue, we use smu_set_pp_feature_mask() to enable UCLK_=
BIT instead.

Fixes:
https://gitlab.freedesktop.org/drm/amd/-/work_items/4895

Tested-by: Guna R. Bharati <062bel313@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  7 +++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 3969a7670..c05ceb0be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -905,6 +905,33 @@ static int smu_apply_default_config_table_settings(str=
uct smu_context *smu)
        return smu_set_config_table(smu, &adev->pm.config_table);  }

+static int smu_apply_late_quirks(struct smu_context *smu) {
+       struct pci_dev *pdev =3D smu->adev->pdev;
+       int ret =3D 0;
+       uint32_t features[2];
+       struct smu_feature_bits feature_mask;
+       uint64_t mask;
+
+       if (pdev->device =3D=3D 0x7340 &&
+                       pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &=
&
+                       pdev->subsystem_device =3D=3D 0x0219) {
+               ret =3D smu_feature_get_enabled_mask(smu, &feature_mask);
+               if (ret)
+                       return ret;
+
+               smu_feature_bits_to_arr32(&feature_mask, features, 64);
+               features[0] |=3D BIT(3);
+               mask =3D ((uint64_t)features[1] << 32) | features[0];
+
+               ret =3D smu_set_pp_feature_mask(smu, mask);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
 static int smu_late_init(struct amdgpu_ip_block *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev; @@ -977,6 +1004,12 @=
@ static int smu_late_init(struct amdgpu_ip_block *ip_block)

        smu_restore_dpm_user_profile(smu);

+       ret =3D smu_apply_late_quirks(smu);
+       if (ret) {
+               dev_err(adev->dev, "Unable to apply late quirks\n");
+               return ret;
+       }
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6dfc3b585..ed67e4bfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -349,7 +349,12 @@ navi10_init_allowed_features(struct smu_context *smu)
              (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 0)) &&
              (adev->rev_id =3D=3D 0)) &&
            (adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
-               smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEA=
TURE_DPM_UCLK_BIT);
+               if (!(adev->pdev->device =3D=3D 0x7340 &&
+                               adev->pdev->subsystem_vendor =3D=3D PCI_VEN=
DOR_ID_APPLE &&
+                               adev->pdev->subsystem_device =3D=3D 0x0219)=
)
+                       smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLO=
WED,
+                                       FEATURE_DPM_UCLK_BIT);
+
                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEA=
TURE_MEM_VDDCI_SCALING_BIT);
                smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEA=
TURE_MEM_MVDD_SCALING_BIT);
        }
--
2.43.0

