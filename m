Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E7FC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E731F10E64C;
	Mon, 28 Sep 2026 01:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bag3Cbfo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839B310E64C
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blhuOkAW088ENKYFDKjDR8Te2Vg3QH5bSpS6XuVHoLIlaZoB/aT2efUgAqcs11Q0rmRcX8DOmCrSdGtynbxVPMKHa5Vi6JTJzMyFhwHggqNtjWctbswitZY5tmkGydjLGiSPecijdYuAFx8Tzwp6hyCtPYbWoHHi84RqUAFaYfg/MiJboSw7HPgT2TGjUdNj3s1j64Hl94eQqnu0MMgI2rxOlbBQC5NRRs/3BbOWmTBYma7V9IaUfLX8a3Jqds6U/oeefclRUdsuMA5D/PdilSHlQGNG5pwLGkzXFuKWrZVpd6W/Pe9bK2nidruB/9zZ1sxH6rblzAHmk8V1zc2nPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MKFKf8KAnvgNET2+Fb2aKK5A68zUwalOlhPiJfsz94=;
 b=vkVYpP2pJ6bqjZmuHBQ4ho9DqfQAjxqSqAspBS1pzmiVa4+Bkb0lFHtihP6Xb0f7y05wAYm2HsFPT6AB47v5a2oZgZf7uS/P2BRSkYsVgfT8Y4DiOlTPuPwYUNazeH2fQ36GETVHDNXA5i4M6RgD5h5dKd4VX3aLITYWY9MTXBFIPtB3gupMt9bwPKlEm5H5iRyjz5JvwRxYGQe0PfwupM1qgDDHH1P/LqZywFD9DagtntaEFdNUk2R1rm0PIYNAWB0oabl6LBCTbzQUIllb+CnOpd47ItgThpSQPIZqfOxyqq4YEoqRrvTKjOY9J/Xzv9JEEKNEsPTmQ+Do+7Cggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MKFKf8KAnvgNET2+Fb2aKK5A68zUwalOlhPiJfsz94=;
 b=bag3CbfoSsqbGthlF9kuDB52EywzkHMrz68UENHd+o6vSlXW4o3VGnvXUqoH6nOyLNrbFxNE4UyV9MNTDymra2DfXfD7Uot+PoWW2r9SChIStWlQpa6LmX29wXCaFazAkMGI3Jp5LcN10k/th+xlWvIviX6MU4DH/sCDv9wlmyQGDdBWpOoCGEMiYNYoA9jhnVdIbCQrtU7Ca5oNZ2O1YjWmY/cVO3kUPtdwMdhuMaJ+6ncSaVFEmhgywzdAtr71RVvP1oYLp0H9jdDCg+URArJUP8FY625TTOOMWeB47vPrYBZlKBZU5lOPyMwf38jbLSUwVT/QanrqVaad2XjRSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 01:56:06 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 01:56:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 10:56:03 +0900
Message-Id: <DLQKQV4L6ZKS.XLOG9AXB3XC8@nvidia.com>
Cc: <airlied@gmail.com>, <gary@garyguo.net>, <apopple@nvidia.com>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: nova: Move VRAM BAR size query to GPU info
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260927142258.1260711-1-dakr@kernel.org>
In-Reply-To: <20260927142258.1260711-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 2800dab9-a89f-4e27-963c-08df1d03a8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|10070799003|366016|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5I99ZZZmXwo+N06lY09YB/Cj/HM+W47Ogm+E+GCyv/fLTQLLreR2YFlPH+W0V06sfEOLFfsH/+HkLqN55xywJ9hHD8VEZ+yS9axGjntnDmsj1t5V0zGToLyrP8vythEexoeeVts6317KocApQgZ8EiamPZ1+rM29skd3ZbhbTbOQotHqXqGSKyXvtOSsDa4wjnh1097g8XehXy1LsUJQTe1trgjXZa7XZGFsV8ZF0c4AwLsD5geH+vAL0DGkl2N+ExfRw8bq8HxIHzTuyAgAhikTlgmLTUTa3yyYHMj3buuaxETJ4WZ9FSmy/Nz/MZTC72tj8gDV4tPX+KZJ5G5Lhj0BBY8SsXdsL5jXFqACqcJ0NiBn/leOuxC9isFds7tcpibbH39ceIuZvrrSSfcx+ud58zy5gXjQ0aTgL5eyUZ96QxKTmnyNNvXDX1WcZgrEJLOL3EDipNTHCibkq7rnXNcQF4DRNOBRFjbbBKVCtzEnAqxEp5u+lwbn4MyFYK3M1FeSBTMwOdb1cP/00TCRFdC5sueWLnDLqm888wHh0ST3fwrAoJJ2XaVwfWLECMxs74S8EPhfneOVisNDg3Y+raUBdSlqEv/hyEC9m7vDSgTHiKrIVESrrpECFDK/UI+TU8GvPV0gWN3ZcTryYZ49dFrvu4yDuLGp3Gtz7Jazwhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHdJNkZudnlCVzhXVkVFcFArWTAvN3huU1FPMzMzbUpKTzdwdTJzT3FuWlY3?=
 =?utf-8?B?a3laeFRiUWh6NW0xTTB1QkZQVTNhUDIwT3dpUjhnUDFCeFl3RE5uYWhlM3dL?=
 =?utf-8?B?dlZjVjMzSFRpQUQ3WHJJZHRpWWhvbXB5THFxb3NLdTdBTHBvS3gvendORVVB?=
 =?utf-8?B?bWxOSm9YdElTcis0ZGhldmFZM213ekFFckZKWUY1Ny9ERHdOMCtvU3dKbWJT?=
 =?utf-8?B?ckNMYjRnMWpGVE9qUEVkZTB6R0VKN2NhN1F6K2QyaU0xWjh6aEpIVDlIZGIy?=
 =?utf-8?B?S3A5bWVtdG9YeWJReG9kcW51NlM5Zk9qM2FKOWVoZ0djSU1jd0wxNUFQUnk0?=
 =?utf-8?B?aTVTZSt4cXJXcTBXQkl6QWZIa0xTbE5zV0pKTFZOdVRPallaQkhiZXU0bkhw?=
 =?utf-8?B?Nnh5Rk1XbDMxdlpnZlRLZVljMm02S0VENlJ0THcyTzhNdVlXSkNuSDAyUnZM?=
 =?utf-8?B?K1AxY2tEMk1hSW5VWC9WeEhjOFpOZndFQjRlWmtnY3dsMTdoZE8zUHJvSUtW?=
 =?utf-8?B?cHRSRzhSNmFxV3dsVk5nY1UvdXF3UFpkV3ZUdjlQL3pFdVNhMWRuVjUrRzJh?=
 =?utf-8?B?TUtaUUZaL3pZSVRPVUdPMXN5c1Rwc3JndVM3TklQSGQyaVJZZmtHMzMzZjY0?=
 =?utf-8?B?WVNwUVNpbXJkbitQL3FVeXBUTURERFkwdHNwNlltclFLcGxib0dSV0pjUXBh?=
 =?utf-8?B?NVlVenZyYy9IY3NKWm5nby8vS3V2WWk3SVRZMGJid2l5MWZaOW9qNTY3Y0Z0?=
 =?utf-8?B?ZjlpS2pUTmM5UTVjT3JkWDNPOFlZNWtLRXJYQml2azRReFR5OHZOWnRWello?=
 =?utf-8?B?U01zdTlUOW9rd3c2S0xxbWtoclJ1aVRzWmtmQlRyLzVqWDZGYlRmeE96a2pV?=
 =?utf-8?B?WVdhczdsek92YXJ0bG5qV1ZZdkFNcWZCajQwaW9zcDFaK0FOeHZCeFRNLzN2?=
 =?utf-8?B?M1NJUWQ5L2cvUVhzb3BSOXk5a0xoNG52YUZ4UEx0WThiUEZ0S0tsVk44cW9P?=
 =?utf-8?B?M2lUeDBNZWZBcWNOZXpoZVl5Q0ZYRnROZXhrWWpoU3hYRVhYVVZ3UE94bEY4?=
 =?utf-8?B?NG1reWI2VjFVai80dWlTTU9JcjNtbngvSDB6L2xNUmRVUjNzc2ZzOGZzTldT?=
 =?utf-8?B?WUhrOUVhVlB3M1NuZEI3RnY1TGpqOTFpMDJ0MHFoY0NsN3lXNTk2ZFlMakU2?=
 =?utf-8?B?NXhGQUh4dUlNbE91OTNxSVk4aVFCaHVsZFdHN3Z3UTYwZUJBQndSSHZnUDhJ?=
 =?utf-8?B?TnU5dGdqSjJ5RkIwc2FXVjZRaXo1WFdHMzZPUzZTRW1adEpZVlBKQ2lMU3lL?=
 =?utf-8?B?d1FXZ2VuQzJDMHBMbWx5TEtxa1FpOUlyOEUxY0dvaStNazEwdGU4ZkV3YUVY?=
 =?utf-8?B?aHZIOFpOdUhieVU1Mjg4VkhPaDdLN0tvc1dmSkpzQ2VjTTlZWHZHSk1qNWVQ?=
 =?utf-8?B?TFFhcEt0UUVEWE5DdkZGWXc2ZmR5VFUwNG5PT2ZEMlJxWmFCc1NxRWkwWlNX?=
 =?utf-8?B?dVcxNkJOTTkxeXJRYkpVajhQSEZIZ0VsN04vNGJBQ3A4eUtkN1NPMHpURlRC?=
 =?utf-8?B?dnczdXZ5N3d5WTh1UGxwZ1M3SUM5VWlyUTB6bWJOQTNKejFCS0p6Tlp1WnlN?=
 =?utf-8?B?K3hQeGNYZFRiM1NkN0ZoT1RFVUdRZ0UvdUhKYnFSRW4yd3owc0h5ZTI3KzRK?=
 =?utf-8?B?OTdhWCs0V3IwMGZEWWs1OW5BZkpQWnZLTFE4ZWJCZEdpR3l2cC9qR1Y1dTNq?=
 =?utf-8?B?dG4wOXdKakV2Q1Z3eDRXTVJWNVQ4RjhaWngyalBra3AyR3hmTDI5WXplbGJu?=
 =?utf-8?B?N05DRzBDdlNzY1NzVTd6NWdydVdTdGR1UFV5M29vVHRONHRoZTlpRHNEelkv?=
 =?utf-8?B?czF2aTBnUjRnczBiNnJadzlUWnprYXlVb3FNb0FyR1dDWnc1MVYwak9zNDRi?=
 =?utf-8?B?NldJUVdBTXFIYW9tU1FKdmI0NVBqcmYvVDY0MVE1d2pqK0pIUzJneU9tRUhR?=
 =?utf-8?B?a2ZJTkZZMC91MC9zTU9Pd3UwS3N2YnJ1aURDdm91UkNtVXpzUS9KV0lYY2xT?=
 =?utf-8?B?bWl1M2F6cEVORmFXTXBqSmhzb2l2bjFsNk9UQmdERkUzVnZLOUs1TzFvWVk0?=
 =?utf-8?B?ZnFCbkVnUkVCUTBZTmZlYWRLK0RnYUlpWEc3RnFwV0h4bldlRXd1dmh6dmpP?=
 =?utf-8?B?UXVtdUJNbk9qL0U3N3VZbE5FTEUvSDVnSDIzT0ZBWUgrNU1KbThwblgwdG5h?=
 =?utf-8?B?Tjg5TU9PTWZsK3JnYitZVjEraEF3TDhzakIxRFdGWHNuOWhIeVpiMGhYMGQ0?=
 =?utf-8?B?MzFFOXFWRFRoODNFbW5FZVM0UE4xb1hDRTYyZW5oaVZYVzBFakFOU3RWSlV1?=
 =?utf-8?Q?QrjrjLa8vcbNOqOYai62Zu+hJN8LKxDp+sCfRW1w1aHec?=
X-MS-Exchange-AntiSpam-MessageData-1: FIss6AxNXtikwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2800dab9-a89f-4e27-963c-08df1d03a8c6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 01:56:06.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+7uPZkRKZjKR3a9ojPPO8QocGVtMehKClBtvVM3T3Simm+GNxYAXttVpfWHaH+d1pE32EkzRxqKyWi9BcFdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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

On Sun Sep 27, 2026 at 11:22 PM JST, Danilo Krummrich wrote:
> Nova exposes static information via its DRM_IOCTL_NOVA_INFO ioctl, thus
> add vram_bar_size to struct drm_nova_info_gpu and remove
> DRM_IOCTL_NOVA_GETPARAM and its uAPI definitions.
>
> This breaks the uAPI, which is still fine at this point. It requires the
> corresponding drm-test change in [1].
>
> Link: https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/2 [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
