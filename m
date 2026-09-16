Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B92C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3786810EB74;
	Wed, 16 Sep 2026 14:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xznV+6l2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF97710EB71;
 Wed, 16 Sep 2026 14:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn2rYb6QoTRpdtLLiPMsvoLJZBZ2ueNdYZ3m8+mX05hvNImLR4v4A8/MgJA36MQH3Ge71D4TDlVOUhlhJCg8PIxGe6fLOup3B/FJyXLU6djugqpQ0SmTg/iKmpx7lhVL02xvkytDSXv7OOlDslkhCiRJETjvvpOeNAO19+tzBHhtsqZeiGpNWy7vhIqce06YiaW4A0trHX+syLZNutAhdE49mEatTL9PsA52WImTkPBhcsyO5eigtJOvhZ5ZgAvT3kHZB/VBRzKT4IODmj2ZpmWGA13832+KvG1t+5pSdTmYU8chTfxlofW3TWoh5kgTpPRc9Z8V6kUO3HqxHkIpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT3DBg0VKI0AM70xe2XwNwRSPVnoD03zSvio/vlEq2Y=;
 b=SCge8U5iVxfrSb6X2xQDyydl+7PzBg9eOxKaW15EsleiYgI/oGuRWHGBM3NRP+zJRxuafmws9/KPm/b3iWNVIL5N8hFxtvvSErEXC0x77dwZQyX5EzKeSgiMhIo7RLDvUbQTufdNU33b2CEKkIACtn2CJdUmpXU1MoBvFp2vqdU3X63Q6+gUrYe0iEhqxqFIsUZfxatamAAp3xnKFdCA0VUlrfcM0LjbyQzjQMkef6SIOwKhFU4Ekz5ctQgwEB5vzfVa5JFQ3pi/92y/KPsJh/J/VZ8yOG4sf6r0c7pbMVyQKvNceXVUKH9iTEsBCSFBRj4sQbvTkaxFTPcAhjJV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT3DBg0VKI0AM70xe2XwNwRSPVnoD03zSvio/vlEq2Y=;
 b=xznV+6l21eavmM1gSzzeAg4CEg7wKQOdfqOesX6/Slnf5ew5G2Ciup8ypNM//ZK8ZhF2zfdHFtfezC8UOergJ5y1by+/ZVH6dX2n8RpWVIC5MUJBCGTbJmttU0saM5oQzgjv5aX4uY+3qHKr4YeBzz9+u5euNKjN5/TpgobnCJY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:31:07 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:31:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Ma, Jun" <Jun.Ma2@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_securedisplay_debugfs_write()
Thread-Topic: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_securedisplay_debugfs_write()
Thread-Index: AQHdRcIbM/eFAZAegkWKQOst5kNqCbbRRGrQ
Date: Wed, 16 Sep 2026 14:31:07 +0000
Message-ID: <BN9PR12MB514643E27306496A92D40603F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916095910.2011628-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916095910.2011628-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T14:30:53.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN0PR12MB5739:EE_
x-ms-office365-filtering-correlation-id: 22718f94-32a6-4711-f2bb-08df13ff257c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: MVgMHhWAo4XKJ1fvRwuj2fD00hqGhR8A6rNp+5tdm2+U/iJuZeDTli3oQH6eulqS7T6H+ioXv4jkH4L31dsZiNM4p8JR7cQ0+nI1mvm7+hXhQPjWQ7KDZMEXWvaFfzKtF+0x6id6VNIm8AS/s36RKOdDBoHo3sTJ//xFFHmDxPcxac9JkKZyCpNN57bLWjAFiXNiZj34ujsNTGR9jpp7P4eAwEZIUh2UpISYdWe8o5c6e+DUeXgASEWiJTpFIqPC5811kRhK4NYyyatamoslDOGlIm9grU0ZZAfXgqWIIop2IMgkL60LgeoQhUf28Yuh49ZuCRfqQBJqTLA8zNN9jLB1ZQxAeFdlR1QvUngl0WdiAj8sMLAAYiZC5wwbfcFObRzayFvM3NCb0pJ5pldhzCwHXi06JbNw3HtBpMkqJcCj6oqVd5eQ2Zo30ZKQ4P2HRva2Qalox4eZy9U3eevfaJQmO2//sk4VXOCjnXZNDvDCmI3rg08xr/FriyKbeBmqTO80yTNnCrumqr94voap7cJdgEax6cHn9xiJ95SjzViSNw5x9icS2yruzyCx+RGvG4r456zIiO3vw1ptcytRNbL4Jek5T8u5Wsq85euVQD60vKSM5g3de4V9XTibZD9MjiWKRFwO9ScJfGiGj1ZbhtaNFnnrwxixMclTfhh5U0aqXBd2aYUPwK8QWgT1juZy5+OKFNgZuNOCAW4scBxuTEsgTDpiGM/4pKsKuI3PWmM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRIbTffkwHqcezOHgpAtUaOLfHHG76jjg/NycvDCteVWGEQj869ZjryKtvqy?=
 =?us-ascii?Q?L12zh8QRny7J6SiTbyzLOXqzW+V1bdyn0FGWDl1IwfiA7lKrtJEe2Ba3Sasg?=
 =?us-ascii?Q?yaYr2fPjTCXnudpuP3SLLSmFpmHlAKBLBIdWLRO5l29u8nPULPxGLnDQa/E5?=
 =?us-ascii?Q?CIrqdhv2ie4JCXY7mYp19ZkMdgyuj0049e0oGE4jforWhTcat6Z/B5CRT1bJ?=
 =?us-ascii?Q?RpQbI4UDOqgxWbnUPIRXhx/Qm1zzwTyLE4Np9wnuqnKap854HA4rMM1bDcJg?=
 =?us-ascii?Q?8An7INNf85JJOqdbJD+AOobxh8tJ3vI69ZKQCfyeDhXBNzRsFmkGvL2boDIL?=
 =?us-ascii?Q?Yb/TUCZkomClnwu4Q3WwTWMWQSV7JkxjJL3AeppwiIfgnAaOmFGc9OlFcZB9?=
 =?us-ascii?Q?eoy6ZrVl4w0kWATfl2o5LrfKKyclQX2QZVI8sX7EYfqynVzri90ciEzpvzLe?=
 =?us-ascii?Q?3PB3JboJUyPksGiRTuA3Q9dVVZldQSpi1euFJ+pR/mctIyGjf33Eejm4P6Zf?=
 =?us-ascii?Q?Q9h7m62vEHp75aRXmC1pY/lgalkrwiiNUOsekRdO7qmwvKiEdqzZuDFE4WEu?=
 =?us-ascii?Q?Ba2n0Yr1ewV7+aqYHqeJ9+Y3rha90Qdk1kc0YKVnHWr30EX0sDaatop4D3tm?=
 =?us-ascii?Q?VXLHCLvLieRQFX1lFst8e2UtNvXlz3zvf+RM2tGhxhakbSLdACWcxYrZ/PJb?=
 =?us-ascii?Q?Opw7Opr4Zamh3RnfAonmVmmb/pQJ9CAHAJrdFt6hNB99ifWuJ7ajfvUa6ihg?=
 =?us-ascii?Q?bH9l57R2gd3E0WpM7htt+SmQvsVIpDZ0HSyAmHbEuSy9KNKBcr9wACvzTslU?=
 =?us-ascii?Q?qEFSHLCXbQ2hZRvgPzdIqA/AzfVLjOgqbJSKs7iartgVVZnMQYDEafoArHbj?=
 =?us-ascii?Q?u07SFX5IykvCoSQhlcr9cSSHWWKNv7yckDPA/uGgLMM8jneQ4XnRkKjQWV/6?=
 =?us-ascii?Q?pfEfmdpuolHTQ07/9bEXzX6f8Xd4QAA0HM8g1BIRaOZhb7w06fPIfQMoguXp?=
 =?us-ascii?Q?2ZUICoRJ52bFsFKOtYmGFYCwblqgf9AJ+6EgiWxr38Bz2k968MhPJLZdYuou?=
 =?us-ascii?Q?p54/Dvg5/MLQzuU0+aGrwCHbsZdf27QxH0HnTmnd9gMbOpGi+eOLadf9spz6?=
 =?us-ascii?Q?qe2LRAi9iMVWXmGEDnsHgVmCk0kovy/PoTU51lZqbl8FIZTsdm/cK0e/5N8v?=
 =?us-ascii?Q?OCQ0cWK6nvKAm5A1+Fv/O3r+I/nNF969YAWgidk+eVSce8HV+MAY5wJrsHtp?=
 =?us-ascii?Q?bmd5dAtQXsAEPWrb8QnIEi+pjf6E1Z/glbfMR4wwt6/ygs/OEB0ihc+EKDAF?=
 =?us-ascii?Q?vKFFh2Dv6JP/UBw8iYeEoJLmA+VOZjrXVcabw1QstZTos2jsmMDMwfoNopsd?=
 =?us-ascii?Q?aEYRVts33l1jJGWAJaSZlM7I8zb2lqpNwNSxefW4rewal9Nsud1ZD6UAmAua?=
 =?us-ascii?Q?PRj3vcqcfmIDpVL2S58JQxgzPbOZApPpwfFQqmbdig4qmO0xwNQ5nI/z4W20?=
 =?us-ascii?Q?7IFNuR9Yg9rCOjU8xyy46gGJEClZypTCoigqW/nvRcOfrg4KCSEtEgTZ/4eI?=
 =?us-ascii?Q?JwsKSWEoWkyrONSUuIwpRh50S0L4rW6hYKh9gSzRrZEgZbanvAafW30Rq0mX?=
 =?us-ascii?Q?x49uQEcJM8Z/EsjtnAmUt/X87LMNzdzAtVqmfvg4AVvzSNu62VdRmsb0jftW?=
 =?us-ascii?Q?jmTSAI/603xd7mKLK7RAdHQgBNVhSXUQwdpucyLu9uoBT3ux?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22718f94-32a6-4711-f2bb-08df13ff257c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:31:07.6342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 277fdTOB0PYSDDfodUu4uYb7iv93HjAMTVa+QJujYQckSp0K9HNanA61orQ38nJK1omgWrspPYOzoIDnQkUtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:59 AM
> To: Ma, Jun <Jun.Ma2@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; simona@ffwll.ch; Wentao Liang <vulab@iscas.ac.cn>=
;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in
> amdgpu_securedisplay_debugfs_write()
>
> amdgpu_securedisplay_debugfs_write() resumes the device with
> pm_runtime_get_sync() before parsing the debugfs input.  In the
> SECUREDISPLAY send ROI CRC case, an invalid user input, i.e. a missing or=
 out
> of range phy_id, makes the function return -EINVAL without calling
> pm_runtime_put_autosuspend(), leaking the runtime PM reference and
> keeping the GPU awake.
>
> Drop the runtime PM reference on the invalid input error path before
> returning.
>
> Fixes: 7e39d7ec3588 ("drm/amdgpu: Fix the uninitialized variable warning"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This was already fixed.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 3739be1b71e0..fdb05f5857d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -137,6 +137,7 @@ static ssize_t
> amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>       case 2:
>               if (size < 3 || phy_id >=3D TA_SECUREDISPLAY_MAX_PHY) {
>                       dev_err(adev->dev, "Invalid input: %s\n", str);
> +                     pm_runtime_put_autosuspend(dev->dev);
>                       return -EINVAL;
>               }
>               mutex_lock(&psp->securedisplay_context.mutex);
> --
> 2.34.1

