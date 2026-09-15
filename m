Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E56C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C4210F2FF;
	Tue, 15 Sep 2026 06:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBKzOMUd";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAABC10F2FF
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmwBiMEWaVuQjkmUoHEgephM3tXgGT97atZ4uoV5bEtsfCT7JhYfI3U/cqh70hWgFB0raNopU/8w4rRTOhCEamaa5wQ9eJrP7misYIe0q5bIpfHPZkSHzJs8rUNIks6Ld9Obx3tt3Hr/QANo4nKiUzjoZIN0vLEnymaY+/SoaKfZvmfcnD6JAMe0bNnYOcnOtbJBjw7WCEphCjGJ9P3fckcEcuxeIZZj7euK5ugC1Stpm+cpjs+LlBnpmfsSWg0QF2V5p45UpsGsb0P8GwVRp1iC1uMpumPvREnVWUbdk0/R+jt1AQN17Y9ZVJPLBHDncNxwjRpKKp5gVLThX+NVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrcoQUIIIbiia8R7zMV9Gio2Ij5oV0olyLZh23EgCF8=;
 b=eJtCRZRaCL8u592q3Qc+dDy7MVq6CIcaUrvl+dmUP7fj4B6qLIFQSuCE5pFIeK8J2fwc3cG0M7JQ5Li9VSyhx36irQPlAoD6zLsKys6drt3PkXVKJdOxagIph3W4FwL5H4Dev+xQw+1YXGUU8Hq76Rqi1pXc7FZXVFe1FvOVj1yzsvIpdZDOEYfaqUhc7FpzrfvNXDs6vw/mJ1JvyCuWS+UbHdSMGjchN0ibgWEuUaOD2m2+s6eRQAAbKNNl9XgmvrS0COlCRgpEP3vryoGCEEzRqgaWait5pIz3UNnCvHlZjJqhkFwiMI1gcROOIrHaK/qN6TEf1canSZZMGqHhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrcoQUIIIbiia8R7zMV9Gio2Ij5oV0olyLZh23EgCF8=;
 b=GBKzOMUdAWwLdzz2j8NvwBPjYcr843fVcMOrtCKCc9An+fy7tkBBSgxIkw1LcjFjXQTtU9QLOqJmiIsNEiT/KTcI9oYDnvjIle2HqKnFF/ac9KAi9jpRHfOb/StxpA/VDNltVnu3lkmvOtZjPH/qhqEc7AMTmU3V3F5KWuUyqKRN89BGYK6+vGsGiioVjU15l3HUSNQbzlywYeOHTHkFJbjtQUtPrpMHg9vc4gWEbEgFd7gQPbYs1bIYHo3StRTdqpBBcsrzxxXMIel333tvzGFiI0J+QdLdz4ytqyOZTH//6P/SUmjQ87i325absxCgWYJitrGxTU6R+1rcBSjFJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:02:08 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 06:02:08 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 08/11] iommu/tegra-smmu: Defer display client translation
 to driver handover
Date: Tue, 15 Sep 2026 15:02:04 +0900
Message-ID: <-oA14QdsQIqZ-_tQLk7vdw@nvidia.com>
In-Reply-To: <20260915023209.B70BD1F000FF@smtp.kernel.org>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
 <20260915-b4-arm32-iommu-dma-cookie-v1-8-ba4f9d33a2b8@nvidia.com>
 <20260915023209.B70BD1F000FF@smtp.kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PSBPR02CA0011.apcprd02.prod.outlook.com (2603:1096:301::21)
 To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f55398-4fa2-455f-c2a1-08df12eedfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: L8h1Oj6q7wdRF9efWryQQvyArmC6e2J5VtbqDHsBcu5ZE9XY9MnUDb8G5OuXf1IOZwpKCIc03A959k2d61nXZluQPlQU9JSK6pa2AmkUcnYyQFW5Ie+OCHmiKShvw92folXnW4/71uxd8IoWKfxAfeQjbvYHCpISomTCjJpiGPk+a73xRPqVZ6TIzzr/d6lfOPbC/3WxOqu2UMQ5YiGHiTG2QK0oMKyDDTYtYxk+OfyhBD7f9SET4fIz9oQOj7Ydw4BoNLtSUI/MqIwhK0X31kpB69cXJ/FYFUNjKgmkDkimQQlvJDP+/DCBCe9wmLVzNSAd75hzC7D13WSiUyV+24utyE2DObpANSWiCy9/hR1AROy5bwwbsiCWmuzfAsJeMIDO0OgzFOH7Twyg+28XQjyZS5dsgUI6koL+PIDOvgglNmugj9rZmkAkxJThOungpeUm6N2MwmgtKtm7GC3r0d43VVNnDvtfkTDjHc+eJdc/4EXI8FJ8hhEAH9tO0XxoLpfUBLaEwe3b/d80TBhJVAovf+KuyCiiRs1Q4bCd+VnBHabGV9o36fhetRhqzqJ6q0mPRHytmGtnHRjalfratSw68ds+Ha5iG/F2MTw/Fml/kd7kMxqb2F11mRLob2IwrPk9rEK1Qs0Eo99V0BEAVzRdYH/hWNcHnxzlj5Kuy4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW42dTkrUVBtV0lhdDMrdWJNTzFrOXZFMEpjUVJ3dzRja2RlTmRlSHFBRHFW?=
 =?utf-8?B?QlFURWxiWWE2c0hUUEFwRnZyTkhvT3VkYjh3bE9CWnViVDVsTHNENW9MK1dK?=
 =?utf-8?B?RzN4b0p6dmpHK2orRi96T3pnU0Yyc3E0QkM5L3NHZFB1SU5iTWZnb1JDZFFs?=
 =?utf-8?B?VFQzNE02Vm9vQVRQZ2F3NTVFTjNIT0VGM1ptai90TGlhR213RWJ1cFM3enRU?=
 =?utf-8?B?aHVMQytBQUpzRXBRUk5QbE9WWC9ERTdES0gwcnhsSTIyOW8wK2MvdXNCZE9m?=
 =?utf-8?B?WVgwRXVjcm1RaE11bVd6SzRhc0VMdVJ6dFZrUk5xK2pBVkw1OUZkcFZPYzFZ?=
 =?utf-8?B?YlMzT3Y5Z3JpRVFUUWdhb2FOVUdhRWppbHA5YWZyMUZRelZXdUlvWEw4WWJS?=
 =?utf-8?B?cFMwTmNCOG1yRk8wY1hBaWRPNTgrS2ZnaDdtMXEyNmI1RjdwRVY0Z2grOGpZ?=
 =?utf-8?B?TEdqbEo5MFhOZkwxTnhoWkJRMEJjQWt4a0s2T0pqL2NSckxZSXhxT1ptdXZr?=
 =?utf-8?B?VEhRWnBTd1FhS3JLQXpXUFloYkpZTW9MeHF6QXAxWW0xc0svSmxkam4zM1Vy?=
 =?utf-8?B?cjFPNk1GdGQ3UDZ4THU2YUFiUHNYemsvby9rY3BCUkw4QmVaNWFhRVhUVzcv?=
 =?utf-8?B?NWJaMFE1Z1FPOTlPOW1XdTdaTFdVM05TWWlLT01JM1VSeXJScW54dm92YTR4?=
 =?utf-8?B?a1lCVElpYnpIU1MvTWZxV1J3TmZuQXZDVHVqd2t2S25BdGdTbHh6bWw0azlt?=
 =?utf-8?B?YTEzUXp3d1I0ZkwvWlFnWUVydXB3Q251RGR2OE9iZnpXQ2VtUkY2RjREbFo5?=
 =?utf-8?B?THVlaHg5NW1hRWExWVZZMlFNTEl3dHBMcExRU25nak5PS0toZHpzazdxOGVT?=
 =?utf-8?B?eFFBVUxsQUtnODJJT0hwb2lwWE81cndqZE1JZXlhSTVNcWdaVldOVmxacnNM?=
 =?utf-8?B?RHpvTWFzYXFtQ1ZzcnBXcjV3OFo2K1NDNFZUWGEveURKdmVTWDBUNG9CWC9t?=
 =?utf-8?B?ZlBLWkR6T3NQWmFGMmw4blFWamtaaHBHYlB3VUFjYnIyOXpTZzF2L3hvWVlO?=
 =?utf-8?B?STFoWE1KUzloQ2FOV2R2dzhMSEhqSkUvTEMydlNpZDl0Q0Q1b0dvVDRzUzkr?=
 =?utf-8?B?MVkyeWpaTGFtdnBpMDdDUmRRWlB4eU1tdFBadmJUZ3ZxY2N2dXJpZHJQdzIy?=
 =?utf-8?B?UlQ4WXJTZC9xWHNPNk8yUU1vdU9QbWlYWHc5MHAwMkwyemxRTW94WVJ5R0JG?=
 =?utf-8?B?NTgzSU92RE8xOHM0Snd0Y3pOQ0JIeG5kNkJvRE1EcWpQNDFURUJHTWJ6UDdU?=
 =?utf-8?B?MzF0WFF6NFVDM3hTa1MyQjk4RnpFeTgzZHdPOHMvL1VkQ2d6ZnV5NWpLNXpp?=
 =?utf-8?B?YjFHTzhHcWU2THpYZTBwU2dxRVkzL1FSMGllZ0ZFU2E1OTRJb3A1ZENGdUxs?=
 =?utf-8?B?Q2Q2TzdrYWRTWlV0bHJwT3VEc2pTQmd5VHVpRERkdXRaeHpoWER0RFIxZElI?=
 =?utf-8?B?TXdCR0dBOVQ0TXcyODBib2ZoQmxZN0M5VzZpZ0J0YjNLbEpPR1B4dGg2WkJa?=
 =?utf-8?B?aVlZMkdpUzNhaXRIQkVsQ3RFcE5sZEs3QS8xUkwxdmdzTFhvQ1dEMWlpRXBh?=
 =?utf-8?B?R3NkcEQ3VFUva1FjN3diMVFCQ2xCWDgvZzIwWE52TmxDcFBIOEdMTC91NEls?=
 =?utf-8?B?NUpMQWJBeFJGNVhxTlE3YzhTWkxQR0tDeThJd1VWcFJjOXVlSjNDdzRHbnda?=
 =?utf-8?B?WHNKQi9tS1F0QXNuYW1WR0Fjb0lSdVl0ZFg2Y0xiYkR4MzlQTzhaUGRQK1BQ?=
 =?utf-8?B?eFNnc0tGbUhReTUvbVVIbEZoSk9XZHFkV1VrRC9vOVd6OU1aOC8yaWFUWVYz?=
 =?utf-8?B?cFdwZXZ3RHU2VmZuUlJIb25LN1VkRnIyVW9oRzNMSlRMM20raExsS2dpazRZ?=
 =?utf-8?B?ek9SNjY2R3VEYVVrY0ZhQjJ4R29wQXNoNlVYSTdUOVZlalFXK05NYXNTK2w1?=
 =?utf-8?B?TFlGbWdIanAyeHJxTFplUVc1UlBiRlZuUmNUb2tQd0RGZTRibzBEZW0vYWVP?=
 =?utf-8?B?RHgxUW1rZURzMHhKbDdRWTN1aWtTYnJEajk4R001TWI5MkY5WmRpWU9CV2ZF?=
 =?utf-8?B?NkJGdnBlanhGOFR1SCs4dTRRcGgrZG9QR3RYT1puWTk5VW5OTHMwdkJLbys4?=
 =?utf-8?B?WFdYKzNLWVpYcVpaR285SkFZOHhJL2Zya0libk9LcXF5RlpFVVNkYXBJUlJL?=
 =?utf-8?B?eFNGTWpHUDBVMHJySS9WYkVxdUdYMXEvRHF0dUNRWGdrbmtxbEE5aXRyVUxs?=
 =?utf-8?B?bmVVMUFyalo0VGgzVUwzSjA4SG9FWWxaN2VzZFNaRFdmR3ZYZWdhZTRhNVhB?=
 =?utf-8?Q?PPvIt24TJ7SmvBk0Owg1DvIrTg78Z2Ew/Ux44uZlnP0ni?=
X-MS-Exchange-AntiSpam-MessageData-1: dGuYMMAoxm/wRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f55398-4fa2-455f-c2a1-08df12eedfe8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:02:08.0377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRUztwwEkDhS1FU7PXDn8BhbjGgwTsvmT8VpDkLlpUZBo6bsN4I0C5+MblOU+MDH62Ma92epTeClbjoTmfNexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

On Tuesday, September 15, 2026 11:32=E2=80=AFAM sashiko-bot@kernel.org wrot=
e:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] iommu/tegra-smmu: type confusion in tegra_smmu_enable_transl=
ation() on ARM SMMU
> --
>=20
> commit 35f909bd1b8b88cf1f8f29602efafacdd3b66778
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> iommu/tegra-smmu: Defer display client translation to driver handover
>=20
> Bootloaders may leave display controllers scanning out a boot splash
> while the kernel boots. Enabling translation for them without special
> care during that time would cause translation faults. This patch
> defers enabling translation until the display controller is reset.
>=20
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index 0b3fcc7011b35..2ae4da07bbc99 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> [ ... ]
> > @@ -2751,6 +2752,13 @@ static int tegra_dc_init(struct host1x_client *c=
lient)
> >  		return err;
> >  	}
> > =20
> > +	/*
> > +	 * Enable translation now that the final domain is attached.
> > +	 * The hardware was reset at probe and has not been programmed
> > +	 * since.
> > +	 */
> > +	tegra_smmu_enable_translation(client->dev);
>=20
> [Severity: Critical]
> Does this code call the Tegra SMMU API unconditionally on all Tegra displ=
ay
> controllers? Newer SoC generations (Tegra186 and later) use the ARM SMMU
> instead of the Tegra SMMU, which means this could pass a device managed b=
y
> the ARM SMMU driver into a Tegra SMMU specific function.

Thanks, will fix.

Mikko

>=20
> [ ... ]
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 67e7a7b925f0c..6636a044905f6 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> [ ... ]
> > @@ -417,6 +423,49 @@ static void tegra_smmu_disable(struct tegra_smmu *=
smmu, unsigned int swgroup,
> >  	}
> >  }
> > =20
> > +/**
> > + * tegra_smmu_enable_translation - Release a client's swgroups to tran=
slation
> > + * @dev: memory client device, already quiesced by its driver
> > + *
> > + * Enables translation for swgroups which were left in bypass at attac=
h time
> > + * because the client could still have been running from a pre-kernel
> > + * configuration. Must be called after @dev has been attached to the d=
omain it
> > + * will use. Safe to call for any device; clients which were not defer=
red are
> > + * unaffected.
> > + */
> > +void tegra_smmu_enable_translation(struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +	struct tegra_smmu *smmu =3D dev_iommu_priv_get(dev);
>=20
> [Severity: Critical]
> Is it safe to blindly retrieve the IOMMU private data via
> dev_iommu_priv_get() and cast it to a struct tegra_smmu pointer without
> validating that the device is actually managed by the Tegra SMMU driver?
>=20
> On ARM SMMU systems, this private data actually points to a completely
> different structure (like struct arm_smmu_master_cfg or
> struct arm_smmu_master) that is significantly smaller.
>=20
> > +	struct iommu_domain *domain;
> > +	unsigned int i;
> > +
> > +	if (!fwspec || !smmu)
> > +		return;
> > +
> > +	domain =3D iommu_get_domain_for_dev(dev);
> > +	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> > +		return;
> > +
> > +	mutex_lock(&smmu->lock);
>=20
> [Severity: Critical]
> Because lock is at a large offset in struct tegra_smmu, could dereferenci=
ng
> this type-confused pointer to acquire the mutex access memory out of boun=
ds
> of the ARM SMMU configuration structure? This looks like it would lead to
> heap corruption and a kernel oops during the display controller probe pat=
h.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-b4-arm32=
-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com?part=3D8




