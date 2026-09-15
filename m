Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF2C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 03:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0AE10F8B7;
	Tue, 15 Sep 2026 03:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMQNRz7r";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE85810F8B7;
 Tue, 15 Sep 2026 03:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbMWCR6JDBQJjjjwAogFTh8nq3ddZyWpQXdqMAei4dnUSonZqD8tk0FIl9WcAF7m3mNbMnmkAeuwiZrDnf47JmtgHnGEl/NlRrcl7PFrWUNNVSIFXpIQpWGSJIGD9GKISuUaOzIGLvDZ6DiifduTJzTazCrHaj8Npl5YGDuUyfc0MJ/r6DPAxiZ2fqJuBR85oIWWY1FRaCsVUu/w1RaU8/zcUYVke7xN4HRXKyagqit2i6zJ1DiemXTwGoFC2ufEAwysgj7nwqIiTTChzA7XLjihgVbY/zNnEW32VVb2qF9iBQF3FlQ39be1QwnoxW5k9vwK43P4+2csFPE0so8s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlATQlF7uF+FqQUAAr/QrvHWOhv4xld3KSABwxjFrn8=;
 b=XXthugZa4ky832nCz4ru7DId3jLz3GPRam+T2HWXer69Xwzkja8oHa4Mh9vJ4ozz0JIowHUv1960aU4FV6jsvZf2mQ9X5s3nO57mvFjMoHgpNLBXPwsAaJI5uwnAbff2U+vXxooGVLQsUxIw3fWJVhi4s2+yoNDcI9jQq526tXmcxTtrSYKMQkaqmy09J+y1W7MZrCD2+zxCxsGMjNk8bXhmPNaphVgfvEK2W65+qdRJwZLjf1IE3gRh8sO0tSCUD5EgchnLcn1Qj06QNxcLw1vFrGaRBZFIZBb5bt+eWSkP5bGEEC5ZkmO1CLnC6d3xViPqkC9nQQzVvwRVQy4KEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlATQlF7uF+FqQUAAr/QrvHWOhv4xld3KSABwxjFrn8=;
 b=eMQNRz7rjIQlw9SGLB3dTpFq41fHGXCy8P843NlyoOQC3VETVLBXVVhPeJklFRdiF8fEAdh1Xaw+7mLvEz+XIyOUzgv40T8TcegvbNUiGGuuQwakac+PwgZo6CLf+ivX3El7ehCiz5Ak4EMbFtNThlJxIMkHWlkvteQfM/1Cymk=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:14:56 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 03:14:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] drm/amdgpu: check ras and obj before dereference
Thread-Topic: [PATCH] drm/amdgpu: check ras and obj before dereference
Thread-Index: AQHdRFYFtZn8geEUOkmlar+g2ZfQLbbO+A1w
Date: Tue, 15 Sep 2026 03:14:55 +0000
Message-ID: <CYYPR12MB8729B5365277A22CAF0E3481B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
In-Reply-To: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T03:14:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|BL4PR12MB9508:EE_
x-ms-office365-filtering-correlation-id: ff78a8e1-1cfd-4be6-5b25-08df12d7848d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Ybh4ZFXLJ8MwZpED1ygBZdmHkv15OAOV2KBIE7nNPL2/MNa+qf4LvJhi1zs9Snd6S48AwUi6egx52ubNjm7XX7zfgFmOLDkjsBqmih/bk+TZ2uKD2UKo6F9lPuCj0P4F3hpVyKQsyeivvNu/FoOgNdlxaE7VyGRtfsZE9xtOPd76nbmaKBT/lkGBGuS0jLfTzYWwdQ55i9v/d9mWAVrc/6kjsQeTOnf3oC19xXDqUXv+pY55s6Uu635YinLfmG6wCkglenGrKM9rKMpxO5uWe7VgVTATzIbJ61sXealF0t57rLjtWgxF+sXAmII53xpU99ciHy40s5CV5/B94M6d9vjX0qVt4e+UEjLiBeTi9PTjNsaw4HM3sqqeUTDNP646Bvo2GV2OzP4iNkr8UwRduZYVeLCmW5zbDpb9DVBL8Dd2Ct/Al7jN3XhvaEly7qHFC2bdfukvvM2Q54rBnduVP8fhMyNA3Z6JiDJHeiIpuKXH5Ig7Z/okCrYglSUVwjPSdj5yIibig5WpVLoAcm8eTYdkKgWDzzATmtLqwCwN0xo7aw1KoyfgR1R42Nfrj5Gc77sY4jsF5Ne6LPX+zPPYntFpEsuu1SLk/DrEua/ViFBoV74UGGXjXqXB627szk912mBOb8vUnu/mLl86P1laOyCJhyVmSZQ8Bky2D8qQv1PkvPeJwSfQkOv9Qg8Xda3EhEb60IKT3CHrFBZs3YCRr4ewQal/Ujyy/sVME3RAIaw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cVfTgwTfRx43k6jD0lY+bz0r4W8JxhZcn7OQs0n/NajNFJy1+O0PqNur0dbH?=
 =?us-ascii?Q?Otp5/Qk02jlqYNxfmc9lHRIDzZuF6zAGwF8phoMwshnFwvtkzbqhdei2+5z6?=
 =?us-ascii?Q?qFHbKWJxQ7vP1hjYUhN5VqEl2p2MIu3HcsGU8ltYlfmkXhJGdGw4Jzm6z/sx?=
 =?us-ascii?Q?ILGCDPfDlPY7H3jIXqOuxiCPhSO+w2WHuOANEMzwkWoyDLz/8wy+r+S2xjnO?=
 =?us-ascii?Q?ktVCVEJ21/dVPzlETgNoRLITQkd/UYPniFrwghw1fNPkq+d5vPUaELkeVxVA?=
 =?us-ascii?Q?xeRx85yWff+Y+JSydJNbHb9LQSdTV/At0id8ZRmd3XbrgxjA39nkRzFeij/z?=
 =?us-ascii?Q?WZ+YSzAWF2123BshpO8Ux4U0L7M3DA7LOSb7jyzSowj3UW0DoMdpevoeRR0P?=
 =?us-ascii?Q?7aITFARENm5HhH5cWvxEezgq3HkdoWIAtfESkZGUvRABCHIzzAfIz/y5PxFz?=
 =?us-ascii?Q?NBEP5zyWa6urMYa3XBgOK3z8E4kBUTSGttNanJMAiDogfDKxXQnpowZu+8ih?=
 =?us-ascii?Q?mwGcRtd2zjclFuemKKmZ5WusgKlXYp242vdT/V34jna6fK/L05VKVk8kT9ER?=
 =?us-ascii?Q?g1CrG5MFcG8+Lh/6f8dlRzQG1ptBa70v0F/81OqkcNYvBY8ZTRVjG2UhWm+9?=
 =?us-ascii?Q?Y3Y+1GdbXaXiUCohiIinYG6nS2Z12WhHLdbom6XxD9HmTK2BhAat9b1FxqvM?=
 =?us-ascii?Q?4lJlw8y88KsEeL+WhzP4ile/zV1kvk8vcY9FKCEKUk+3odiT7jvvNmtqaK6w?=
 =?us-ascii?Q?CFPTlhEPSl7Ahojb27hOxK4aM1/6TAa3Sn90kRUWhmqi7ccJczV8JTf/chVV?=
 =?us-ascii?Q?08vL2dGpv5TbfDZXdtbDsB6BmoVehQP3wwj7hcZqlBX/wcr9868h3jnX9grW?=
 =?us-ascii?Q?oDuoN5sVgKMFVWU+Zc6TEhn6ZRjek8j9FZ5IC8ziXskhKME++2ZIbub/JY+M?=
 =?us-ascii?Q?P7b03Yz5zcEAk9o7zK+wB1UaewVFvHwMLci7Cin8gaDUiJDxuFvPnc/tbFvc?=
 =?us-ascii?Q?n8rBcSQxciYiFdq4d6HJpBLV8NFDQNg6i2VyMI1Bi0Cq1gwlleUahQIfxUGk?=
 =?us-ascii?Q?6k4iNwrPjEU52THwIpNN3QF2wsp/JdnRv79JtpvCANhScC1A0q597RTNXDSG?=
 =?us-ascii?Q?OQewwPo5/ra8BQQtt3xb/EbqOReFUj0Q8Uj9vLKmfVCJhQ1pVOD+Jno6AXNG?=
 =?us-ascii?Q?wtz572mq7eIhRG0oSW8nS1+UTe1JLVpgPkfTBymVaLE1i04S+Ge0zs6Laa5m?=
 =?us-ascii?Q?p71VhTjo/DmiI6LNxMHieZB5r6jStIq0t7zbWIQfPNC5/V6BMjnpn2MlNTuK?=
 =?us-ascii?Q?UsYg20OWMf2q9v9IJ8dqX3jDYbwxhI1ZtPrQqM6iiQwV3j6Qa6OLRuVM5MnL?=
 =?us-ascii?Q?VxnenjGO2UWCAdgsgdo+TB9UA1dCoDqqDBI328Uo91Im/hTbWJFQYFfyWar/?=
 =?us-ascii?Q?6M6M4RFTjzcQ67BtHp3+X2ogPw3d+aiaAZ9wv+nwaW1PFgEevHTlupR1aGKY?=
 =?us-ascii?Q?ziVD/x16fivoUcP/BmfNYCPVtnplxofoqwvlu7CF4lrIi8YPSTaxGwviFq6G?=
 =?us-ascii?Q?dD6RUqtJDSdVeX+iNfVWuDHPE1j2kHt+Ie49zwu4nbo/8VV9m1y/MljIrXR/?=
 =?us-ascii?Q?qyIVI6zVo17RFHhACXahYq3j2yFCEteedzFRGPdq8r6X7dMv40rdrK0aK3mq?=
 =?us-ascii?Q?5ZorclLC9mr/fnxfvkLN6vAIs5y3RNZoe4q2jYwFKTTO8R28?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78a8e1-1cfd-4be6-5b25-08df12d7848d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 03:14:56.0743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwJEf0IJGOOnoY5QaXWOitQNr5F1D9VkbG2uYwN4pZnC0B60ROj2ZYRL38pLZzNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> Sent: Monday, September 14, 2026 10:33 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@l=
inux.ie>;
> Daniel Vetter <daniel@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; lvc-
> project@linuxtesting.org; Dmitriy Chumachenko
> <Dmitry.Chumachenko@cyberprotect.ru>
> Subject: [PATCH] drm/amdgpu: check ras and obj before dereference
>
> [Some people who received this message don't often get email from
> dmitry.chumachenko@cyberprotect.ru. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> nbio_v7_9_handle_ras_controller_intr_no_bifring() dereferences ras and ob=
j without
> checking either for NULL. Both amdgpu_ras_get_context() and
> amdgpu_ras_find_obj() can return NULL, e.g. during the window between
> adev->nbio.ras being set (early in amdgpu_ras_init(), by design, to
> enable the fatal-error interrupt as soon as possible) and the PCIE_BIF ra=
s object
> actually being created in RAS late_init. Any interrupt in that window cra=
shes in hard-
> IRQ context.
>
> This is analogous to commit d190b459b2a4 ("drm/amdgpu: the warning
> dereferencing obj for nbio_v7_4"), which fixed the same issue in the
> nbio_v7_4 handler.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 7692e1ee2446 ("drm/amdgpu: add RAS fatal error handler for NBIO v7=
.9")
> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> index 8e401f8b2a05..2b3a1b9f8efc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -518,7 +518,7 @@ static void
> nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>                                                 RAS_CNTLR_INTERRUPT_CLEAR=
, 1);
>                 WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
> bif_doorbell_intr_cntl);
>
> -               if (!ras->disable_ras_err_cnt_harvest) {
> +               if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
>                         /*
>                          * clear error status after ras_controller_intr
>                          * according to hw team and count ue number
> --
> 2.49.0

