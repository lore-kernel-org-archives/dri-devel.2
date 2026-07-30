Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB2C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2877A10EDBC;
	Thu, 30 Jul 2026 06:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="orf56wRU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B674B10EDBC
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4HtUj9+cwrONIcD3S5ugkyo9vV5z/7PAOKgtSQD29tIOubRc1RO/Rk7vMPua770/siw/L+q1NozfvRmoRPeSh8HTobmOVY8LD/OXP17Ftg74Q0wY1RTN/qF+GYUVktnL1nqZmwiYoqTn4UVlYsMcqLE+qS133DpMblczqHvZL1UQeG4OiJAXNtXBZvJD9XjJrtLUksClfDS3eV6Cl7tNUkzFUFhYbvXk/HVIiBHJeGXmYauvLc+Pnhy0iiZRUMI4taMcH+6H3gpD2Lx8hjRQejVpzz12x5tjjIz0jTjvjJBkIZuK9O07K2n8eVe4weGn2xNjJSCdEKS400gOla1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm8lZ0RnL5QXe/WyQts1ib5uLE7/avIXGAx3K5g0aOQ=;
 b=GdhcKqRRdIDzd0zLL/1Yw7gpnQqdrE9uO6sD+7UCtUV2z0hotRaz2zP8124mgFu58dgI8n9QurkfkGT+A583p6/AmhhymQLJF7WI2uwovwX7MFyvzmRj8mRBKWOSQc+BNXEgEM4VHWrRCHFceeLYNp4CtvvBPm4w8cP7SRfkRG7Jze2B3xAAtbaxBsmZE3LbiMtq5x8V1DjnIjl+G9FbxgGu5Ze5BcK73n8y6k1uVuaxuDh0X5Ft0oEM/nX4EOVUCycTYnpCrMBzpZphFmxf7dzzchwqFPcZx2nFJy/FS+JGs4pPVwWoJpxadC0X8yJ8HQ8Jnc3bByCk9Wky7Q3XtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm8lZ0RnL5QXe/WyQts1ib5uLE7/avIXGAx3K5g0aOQ=;
 b=orf56wRUUqfLgbbElTSp8NeLTFGyAyJGRxXFCjKf+nKDcXLAPDtyQ/z6SmqovFQ4H4KsXYct9l/ObZJAerUSp+dTdJiPGQqArSV1qLbGw1U57aN86LvD5qVo6xpeZ4ygqAp+eSOwgNUzGlGoC9y01PH76FSxOcuG0RyzJ8t3xDeGU9zD8N6NZ/TgweHX7yspObsZgYH8lqevpa1B7l+w13l9FJ6s9vJf7u1Etn0JQP0sS/Fi2kB8tJ6xfuRBQIjbA9AKAK+ltOVmiKPKQK1h5Y59UIoo9X6XpA6TesChbgqf9vZdw8N5X8fCtVqCNemaJE+BWYunqkzVOdwIFTZGKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 06:37:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 06:37:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 3/6] drm/tegra: Drop reference on postfence
Date: Thu, 30 Jul 2026 15:37:47 +0900
Message-ID: <0QSykfhmTr2j8q7yoYRQeg@nvidia.com>
In-Reply-To: <20260730045720.DF32A1F000E9@smtp.kernel.org>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
 <20260730-b4-host1x-syncobj-wait-v1-3-afa730410392@nvidia.com>
 <20260730045720.DF32A1F000E9@smtp.kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: a67e47e6-764b-49f1-ac17-08deee0513bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fjfm8c9E3THoZ1kU+lYGh/4ZAGfO6TjzyfnQqVY1zRelPJW97fpZP0KVsUBeOzdlz1ECas4G6lxV9+bak8qX/0hT3KU1nvskpypJ7SarYKJnLiPZ0cJAiRygxp7w8O9LFEoR6fknpj2hz6832PV7Hv0eDC+2VlXz1dU6a/QQH1UCrIq7yVOU6RiW8aGh27EGY0FdNTX3CJQgrZ71YtRXnskscyUT8BzztSgiXFKGnr6z0pigc88eexaXeuZLHOqkh2Xj5EhvfrwR2qaKp8Vn5kUqK8UDLfvac9y/DiZ7nUQO31+wGUR8iKS210zYyewKcLsu3zw59T99B4DAzg8HQb5nWBGXul8B2gdO2WMJ+zDtzeqBhW1d79Wb85sqTu3ATHXzZ/IxEiXyrpRPZLkiHPRPlc2J9KtSxeUg3bbmDxCgvczEB8ZFVwOsBti948SOlLHyCF8C4WxxII1B8+gBkzLDpPqZibhzIQDvmMvqxUOgOFuKj1RPEuiFaWUBte+fNjiXy3EwNa5hLsVDLT52ISOjUECIBGJo+4eXm9druBcG61NnXnSyZaZmCdLoIEJZAZ1LseZz9GrMQZHu6+VFZeUafUn6b3mmVB8Wvsr04dGsU3m9/XkbEgrPDLdVnEwsWdgXRC8XtY5s1QMWX5jrf67uUU37lFWsFK6enWgVgXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZNdk5IQVRJc3NvYlM0NGtNMWZObjZOSDc3NGpTZUZKc2pMaUF3eGhleXBS?=
 =?utf-8?B?TGVkK3RFTDNKSmI5ZXJMcVZubnpNN1d2MndQK3BmcHprSHRMNFplRk0yZ3Ez?=
 =?utf-8?B?OEgyMlhOYThNWWdSejlZQmVubGhldGIyVlhjQ2YxckovaHY4ZGVCdm9hQ3Vk?=
 =?utf-8?B?SUx3bHk4S29xWVJkakxkb1VxS3ZnRFpLcWQ4SGJ2UnFuamlQaWVrelRtbERj?=
 =?utf-8?B?Sk5iYkl2ZCsxTS93SytCQ2tmdWZPcmxReEdBcjR3M25GbzRwMkRqVllFZzk5?=
 =?utf-8?B?YVphZ09sMnN1a1FaZytkekRLWTFCWGxRblorSGxnQ1NpVmtyYWxkSXQ2aEhm?=
 =?utf-8?B?WGFaS3F5cmY5VGdJQVJYM0RrKzVvN0V4S0lmaExKVXJsM0tvd29DdFhaL3ZO?=
 =?utf-8?B?dnlwbWhuSkNUUUt6U3FtWVJlS2F1ai9STytWV2MvRFFWQWRtWmozN1ljNVA4?=
 =?utf-8?B?K3VwQ29oenFtcXNObUltcm5rb0Rldzc4Y09nWEhIQ1NRNEhEMG1OeG1QZUZu?=
 =?utf-8?B?QWIvVGxRMnRVdGRWVlJoZkdyZnVGQ1BGWVFlcUVLY3Qvb1V3Zy83Q25wTTRB?=
 =?utf-8?B?bDRLaTR3S3l0UUpBTVhQM1dsWFpRZHBEL0tTenNlaU5iQ3lyb3U3Rm51a2ZX?=
 =?utf-8?B?VGtRWkxuZ2pPWWtFZnFLNXkzUEQwYjNEL0NKck9WSXV5VmxWL3FuZGVDa0Zj?=
 =?utf-8?B?cHI0RHZpT3R0dnh3Y21lZXBMN0dpRVNvYkpKWGpyMlFoamdEaytWbHIyN3Rq?=
 =?utf-8?B?Rkt1bzNuOG15c08vUVVQL1UyWGZMU0hZeXg5YmFjWHFzN3UwcFdLK0RjNk5Z?=
 =?utf-8?B?b2wzUERIWnkvVy9VVWpiNytvOVFCdGlHcE01MmtUbXlJM1lXajA2ZjNqd1pG?=
 =?utf-8?B?QTZYMFJWNVhuL3FLbVpWNklPTncxait3SGdscGZYOW9mQmxaaElXQlVZWTBC?=
 =?utf-8?B?eDhCdGV4UFdEYnNBaGJUeUxPSEJGL2Z1RmxkdjFGYUdDMkRiODlKSkJUbXRS?=
 =?utf-8?B?QUltcXNFWDdoOU1LMmIyZlNqVS9JZzJEQ3RXR05NUkQycDFHOGZiQktGck1a?=
 =?utf-8?B?akhDMTZXRmZVQ3kreDU3VUxva29PUUFyU3ltekRhSE0xQ2RwTmxrWkVtMTZP?=
 =?utf-8?B?T1RNbDdJSEUrQ0VQQTUxVG9ZSHF4T3JkKytlMXVoK0FhQXAyUWF4Um5sb0lI?=
 =?utf-8?B?SWNENUtSeHcvNnQrTkQxNklIVG1jaGc2MkZ0V1J3Rzkwcm5iKzdTeDVYQmhy?=
 =?utf-8?B?ZHJ1dVAzUEtqLytnQnFrVmdubndObVd6ZmpqTEtTNjF1akQ4YndoUW9rZ0V3?=
 =?utf-8?B?N2ZuWDBLbkgrS0V6UnN5M1daUUtxV3pZK0I4cXNVY1JoRC9ndDg0blBrQ0VE?=
 =?utf-8?B?bFcwcE13ckRuL3ROcXAwV1FCQ3FIYkhxeW9udktUVExHV0JpVi8vanorNFFW?=
 =?utf-8?B?SHk5dXYxa2R4U2RneFVGUEFyTWZEUXNNeU1yK1dheXBOMlhiRFNNaGNxaUpJ?=
 =?utf-8?B?c2h5VEFXVkFLMnNVa1hKTEU4VlVLZVhOMW5PMzQzTFpuN0dvbTNNR01KZVBx?=
 =?utf-8?B?K0d6NzRRQmNVb1dQRVVQczJWaUZJbkhDUSt0d1pwMjlDZm9sK3VSVWNlYjdH?=
 =?utf-8?B?ODFpekswaUZtbGw0VVh5NVZCcENjSnNUUm9FWitXQVVkQ3NRMEFmRTVFRm13?=
 =?utf-8?B?OHhoamN3Vjg5NGNpNmtZNDNqYTBYVWREOWtzQlZFMXNsLzhGNVV6SVAxcVZz?=
 =?utf-8?B?OFB5a1JtcXdiQkkzbDlYUDMyTWprVGlIcEdpVDJTWDJidnlkZWwrRy8vVU9i?=
 =?utf-8?B?KzBCV1k4Mmp0NGJhaXFQY0E3OHM1a01wRWJmVVRxaXNxb3RUcGlNWGRIdkdn?=
 =?utf-8?B?cU5zR1J6QkRjRHBKWnJBZThJbEJQaTBudkM3dVdhb3g0Q3dyUVNHeE5OdmF1?=
 =?utf-8?B?Q2dKRk9rTDdMa3pRZmJOMnZXQkx5NDdJenlTZWFOdFViK29MU1g1QVFBQmlh?=
 =?utf-8?B?Q240TUlxVEd6RDNPOVBQREY3c3BKd0dFWjE0VVFyMk5vNk1ySmJaWHNIUWRD?=
 =?utf-8?B?by93OVc0NWx5dUZjemw2dWdVOHpjN0l2OGF4SEZ0eEVyNnFYZnByV1E5cmdq?=
 =?utf-8?B?d1VLelhyUCtWOGVIcndqdlZmaHo1czU3eGVmbjNUUWVZTlhOZ3JMNm5ER2cw?=
 =?utf-8?B?c2ZJaXVVNVZmS0o2N2ttTE1NK2RTaHF5T0htR3JIQVl6UWphaW9LbkpKTUI0?=
 =?utf-8?B?SDN5MmF4ZGVSVXZQQ2NzMUZwWWhwV0FVRHJaNFE0TDF0NnRBSDRqL1NGVitj?=
 =?utf-8?B?Q1pkb1V6bERGVUlTMGZoT2tHSnBtVVJKVENtTkpFTGFlbS9uMm43ekMySXFi?=
 =?utf-8?Q?flClag3Oq1MwNVpeCHPzuc63lLt3qOLVKimA6ZDgOLcpY?=
X-MS-Exchange-AntiSpam-MessageData-1: O9gCksygvHoMSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67e47e6-764b-49f1-ac17-08deee0513bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:37:50.9006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xochu7Q6W9dRDeaAU38b/8rX/K//UxYQEiee/q66j6ugiqGKdO2Eriszsr75sDlQD9KG7MqKy1HjSFcsYF1oZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
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

On Thursday, July 30, 2026 1:57=E2=80=AFPM sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] The job submission ioctl can return an error to user-space after=
 the job has already been successfully committed to hardware, violating the=
 'point of no return' principle.
> --

Either way (return an error, return success) causes problems. The proper=20
way to fix this will be to make the fence allocatable pre-submit, but=20
it's not high priority.

Cheers
Mikko

>=20
> --- Patch [3]: [PATCH 3/6] drm/tegra: Drop reference on postfence ---
> commit 3dc23eb6eb77ce1c25e7c0e305986ed6dd337897
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> drm/tegra: Drop reference on postfence
>=20
> This commit drops the extra fence reference by calling dma_fence_put()
> after drm_syncobj_replace_fence() is used in the job submission path.
>=20
> > diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/sub=
mit.c
> > index 3f20b5a244476..658396f2e9549 100644
> > --- a/drivers/gpu/drm/tegra/submit.c
> > +++ b/drivers/gpu/drm/tegra/submit.c
> [ ... ]
> > @@ -645,21 +645,22 @@ int tegra_drm_ioctl_channel_submit(struct drm_dev=
ice *drm, void *data,
> > =20
> >  	/* Submit job to hardware. */
> >  	err =3D host1x_job_submit(job);
> >  	if (err) {
> >  		SUBMIT_ERR(context, "host1x job submission failed: %d", err);
> >  		goto unpin_job;
> >  	}
> > =20
> >  	/* Return postfences to userspace and add fences to DMA reservations.=
 */
> >  	args->syncpt.value =3D job->syncpt_end;
> > =20
> >  	if (syncobj) {
> >  		struct dma_fence *fence =3D host1x_fence_create(job->syncpt, job->sy=
ncpt_end, true);
> >  		if (IS_ERR(fence)) {
> >  			err =3D PTR_ERR(fence);
> >  			SUBMIT_ERR(context, "failed to create postfence: %d", err);
> >  			goto put_job;
> >  		}
>=20
> [Severity: High]
> This is a pre-existing issue, but returning an error to user-space here
> after host1x_job_submit() has already succeeded seems problematic.
>=20
> If host1x_fence_create() fails, the error path (goto put_job) drops the l=
ocal
> job reference and returns the error to userspace. Because userspace recei=
ves
> an error from the ioctl, it might incorrectly assume the job was not
> submitted and could free or reuse the command and data buffers.=20
>=20
> Since the GPU is already asynchronously executing the job, could this lea=
d to
> the hardware accessing freed memory and causing IOMMU faults or memory
> corruption?
>=20
> > =20
> >  		drm_syncobj_replace_fence(syncobj, fence);
> > +		dma_fence_put(fence);
> >  	}
> > =20
> >  	goto put_job;
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-b4-host1=
x-syncobj-wait-v1-0-afa730410392@nvidia.com?part=3D3




