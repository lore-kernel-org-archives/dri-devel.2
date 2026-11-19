Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E2606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ggfkpnNB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A50E10EFE3;
	Thu, 19 Nov 2026 07:13:21 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB5010EF77
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySuS0ucWY26/g3k0DOhQKuc5xfJqrb8V4BUikEiC/x3DRsM5C56iACw8mHXa5vtiMRNuALz7b5haGc6Omri3dVJXiYuXAOvKn1Fc74HVzXMo1YEIArNhD8E2aP8b5OFBvsc09RAKjFwepZfLgIZ9CGZ8jJpJL1tYaY6nHZQi2fKRQVZQq1FoX8p3Iv41zV3FWzlBnLp3YMuHCWhmQGcxI5f7ShK6u7ucsOPMKb9UEB8KI9PibNjC0EjciuIz7meOa2ClXO+O2WWDdDz4D8vH/PjZiiQY5HyR7926M8VVOz3quzxJOgB2HUIEr2IX+uTMmxQTsWWA0D7Gf4Xp0mG06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dL4re9DEqSnqw99TLcitQybmEBP2IIlgYQs3U1O+7M=;
 b=dB099lMUyNPXzDSC25w82ofKnwlaH8ev6zEJImmHdaw41R1cLyN3EY8+8cDSGOp+uquRJ9b1yKvqNpHcn/7EPoSzLqa8OwsoULyp6HxrMr1BLJw9Sd4evdDO6QRW6w5kjQ0PcbalKhPGvgAGJUM9JUNL3X5NMRB0Wv3cJJ9zp1BWzYlNpowtZNMRZiyJ7p0mir2F3fYeRwIZmORZUSTRgTXUS6iGQilTWP0gwQOZXWRQEjOyBt+gVBQF3UhI8c108/cOwwx1kKwnsGXzLsErcKsSZFL+OwXywRpEBrCgG+rlmMbfasmN/4PzqBIKHPWfs1XJjxFHobiTX8kzekvOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dL4re9DEqSnqw99TLcitQybmEBP2IIlgYQs3U1O+7M=;
 b=ggfkpnNBQDagi/2RZVFUhjceIJJskxzt7tR6n4tmDCqlopNwc2ItZoTFH2sU083anyY0YuGMVLUmWUHbR+jEo0SfBXGeHV0B6SGI85RoUQSVlpnUeVTgTnsG5laRdc7UPJFeh6rLMnzHWtnR0pNzED21/gbSjirxzm1DgvcKVEkQ/Av1ReTfXeANqrAdoqpSLzXcyFjh3rVn6C0kzdf9JtLgCCWiRqBBZjk4z5TKq6e/QOeBg7OTV2700BVbxmSVrCJUzKEFGOwI+53jv2AhaO1siPDG4sOO6Ln77LRRtrxyZu9Ft7dpsDfETkJ9tIt24FW3eMIPKTbt3ljmr9ivOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:13:11 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 07:13:11 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>,
 Joshua Crofts <crofts@kernel.org>
Subject: Re: [PATCH] drm/tegra: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Date: Thu, 19 Nov 2026 16:13:07 +0900
Message-ID: <GqcGePzkRVaM7zcZlGfZHQ@nvidia.com>
In-Reply-To: <20261110-tegra-remove-dont-use-autosuspend-v1-1-f37453d0e441@kernel.org>
References: <20261110-tegra-remove-dont-use-autosuspend-v1-1-f37453d0e441@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0304.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 3818c397-5733-469a-1ba9-08df460c91cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|18002099003|22082099003|261009221227099003|261009223027099003|56012099006|11063799006|261026121527099003|261021135927099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: QZQHQ2ymCBUYkeFgf9lVYML2TRIhKW0V8jsZpnOlEA17oLjKVDSXRakqHZcLp8CqBrHGOC1IGR8XZE66yd+R6EYdRePnq19D8g4nS75WyWCWr8BY/rKghFulv0/n8igEdIWnYfP7LXDopSKtD2yWznPYAVB33FQUzUACEKKK7S4HqS5w1iKQ1N7ybX93yGcSObFpiwQWZH/ER7RKz3CNnpyVsjiXT0C3/kZfTz24gMa3Vl7K1dRQoXatt5Df15e8cncT3g7R3UJQ73oiQ/vnDhtpUspNGj6TRr7hVOJz8cL4JPFlcO00MecguSrzfHuTQ18D961L/3i6TRmo7hJeIF3GMpbqEmW3BtNdof/1CLJqYOTcaBTpE5Fx9aTRFsGtNQ1Wol3FWJ9QEm0n5TEWIRyBvYVI83u52Mya00Vv9fI1+ZUCujzaZR/GZRrA5SxxJ3TxXwlAbLL8hMJbj7//PI/Uyn27PlArf368hARuHBIVJWKzSLfkcojUn3/juy9Q0yMU4njG+gpdFycqxNgmlhtG6cHq+OYJsyF4lCIn8J2/32XTBSrlc0ALG5at2nk8HTMvuuwMSq4fP0abjxf8B3IJTZVwnjisD8Ov1dRxkwpEHhURkTO/b45p3LOXyDErCl9i/Z6kMrIiQ5V3VXoa/jq3T1hSe6XXIrctzHjJK4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009221227099003)(261009223027099003)(56012099006)(11063799006)(261026121527099003)(261021135927099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS80OTBHZW5kSDFZazdZWWlQdEpUYzBpRnRxVjlpVHREdGUxVmlqMzFWMHBy?=
 =?utf-8?B?RER5YkhGYWpnazJUSUdpcUhQTFRZZFN1QlNkZ21IaENuMFhKaFpNZ1ZRakFm?=
 =?utf-8?B?RUVRNWQrV3JOeUZObzgvaTVXNnVwMzU5eXJxQ3F3NlhZbW56U0x5NjZ1ZlU5?=
 =?utf-8?B?VU1vOGo3bkpZK2J3WE94SVBCWndEQmtQOWdQQlNRMEZITzUySkdQa2J1c2cw?=
 =?utf-8?B?N290N3JzTDFjTERzUkFQYmRQYmpuaytaUHorZXBadGhNTk9IY0Q3STFWSnhZ?=
 =?utf-8?B?UU5LKzNSNHBzYjcyd1RoMnJFZE1TZng4dEhFOG5uTFduckpjTndDWlYzVW1o?=
 =?utf-8?B?c0l3OURCWS9FWEpOM1BkR25zaEFOeWhiWFlDWlV2aCtSeUhQbWFzYUFocTkz?=
 =?utf-8?B?aW9PNGpuRUU2VUNsNkMxRTh4bWs3SWtVUjYyaU1mbXc5SVBuQzg1SHZTeVpn?=
 =?utf-8?B?VVV4OXU1elB2LzhuT1BleWFWMEVXS29rWm5XK0lJZlhnMWJlQWUyZ2JMUHJl?=
 =?utf-8?B?Vmk0VjdlcWpFaUJJWmRLKytMZ3Z5a0tlWHhRcms5MFQ0by9FajRTaU9KSmR1?=
 =?utf-8?B?OFJWbDlTYkdGcGw3ZUNoVm5TL3FFYjV5NGtCYVdYWjZrRXlTNWdLK0xtcFJ4?=
 =?utf-8?B?WjFGRjlRUWFYcTdVRWNGV0hFY24wQTZrd1VIY2hJSDQzOEVDSWE2SW5wQ2xM?=
 =?utf-8?B?THRJRFBXQXVNVVJ0Y1dvcERyNmFmV29wd1oyQ0FEVm4rNzd3cmdVK0lCOUZD?=
 =?utf-8?B?bXFOSkdrQnVTdXRmd3pwL2N4MVY5Q3hPU0xCeEZQeWh3QUJDNFVRQWpoOFNY?=
 =?utf-8?B?aDR0aW13MHUxL1pQelpYc3hnaG1FMk9TV0JoZFNUMFpmZFZWVllyN0UveUZa?=
 =?utf-8?B?YzAvQkpsUzFUSjdCeHVtS2pXbWN1bTltUStobnRLb2tZK2FMSXZHOWFybW5h?=
 =?utf-8?B?MlZjTGIramhOR1lmSmZZVStVb1dzUjMzQUQ5VTgwRjJNRFd0QXF5MUNnQW1K?=
 =?utf-8?B?SDZKYjZLdkgwR0daMU0vclB2eS94TS9IUUFMaG9GOUc5Y0lPdlUvczdER1Fo?=
 =?utf-8?B?WmhhWFVhcXVoSWp4UWVrZXFhaEI1ckNWNkVOWXNwVEZYVmFOQnNxUDhkOHhF?=
 =?utf-8?B?Z3E0WmZlZVJOL1Ava0xSZktMTWV4UlkyaURDMlA0dWdTRXVHRGJkSXFmRHZW?=
 =?utf-8?B?aVAyQXN6TVJ0ODEwY3ZBYzZTY21qSFVlZjRldG9MTU9SK1NDeVVrSFEvOGVy?=
 =?utf-8?B?cnhrbFEyc3F4WFNGSE1jNnlQb1UySG00SDh1aHFQdW9laUZ3bkJwMFdhd3du?=
 =?utf-8?B?M3J0MXpEL0RsSXhKSHZIV1RETGcxSEVRRVEwMXoxZjZ1RDRJazhoOHpkSnZy?=
 =?utf-8?B?eGxYOGtsSVZZaVFPTVprc0JvMjVSUTFhdWsxbnlNL3cyRTY4d2hKVU5mYkRT?=
 =?utf-8?B?TW1YMC83VVNrcnppZUdQc09sbzcxMGxLVzcyYnRSTkV4U2JVbVd0L0ZhN21N?=
 =?utf-8?B?S0RocmdCYW8wU0NxN0Z6WjBMcTdMY2ozZDMzTTRwdFUvOVVWdFBORGtSeHdQ?=
 =?utf-8?B?Q044QlFlT0FyZVFCcXVrYkRNZi9JRG1KdysydUwvM3dveW9BK2lSam1uOVZq?=
 =?utf-8?B?QzFCdkRpcGhLZE1vS2lDem9PUTBieWdWMlgzT2Vub1BDVDY5UU93TkN2Mm5Z?=
 =?utf-8?B?d1Z4T0ljTGlTbGRJY3BvYitwZzNYMUZXempOdlJHMi8wZkh5VlV2TWFXcnUv?=
 =?utf-8?B?MEllWmhBRFRxN1ZkQUZjMDVCdnhnaElXc1VXQjhsaUpzR0FUNjJ2aWFCd0dB?=
 =?utf-8?B?OUpZQ0NMVlUvdDZuTyt0blBKei9QV2RpdnI5VVFkQUI3ZEFQaCsrR0krcXU4?=
 =?utf-8?B?TDRlSi9wUHkvSnc0ZmUrVHRZV3pxYW9DNXpUM2MybDhjR0c3SUl0WG1PVkZR?=
 =?utf-8?B?MHRQc09Ta1FUckI5dGxBR3FNMTRiZEw0Z1VyKzJhQ1JGcm5BRjRNVklvcytK?=
 =?utf-8?B?NGVtY2VpVDhuL3BKUU5kclg0SExpR1dSUXlJZnFDT3JmWWJhRG9xTU5VRW5P?=
 =?utf-8?B?ZnFlMjdqQ3p2SjdQS1JCVFQwLzNZSU52ZEhFL05NZEFTQXZhSDVINzBmTS9E?=
 =?utf-8?B?ZERWbFdBVWxpL2FMcXNjb0FSU1R6MzFHRndvS0c3YXJBS3F4WFVmVktaNUZP?=
 =?utf-8?B?bzFnK1NucDBobGdRSDRCY2VnMUYxSlZNV0JmVUFiMUVadnVkZWtNWEZjam5Y?=
 =?utf-8?B?YWxwbFA0bW5UQytqUHIybU9PQklDL0IvdjdtcjhBdUhPMXZTWW1UTGYxakxG?=
 =?utf-8?B?OVkzWHdDVDJMTEVsV1lCT01QVGxTTjhYc0FsT1lzNWxTKzFBU2RqQUk3a3VV?=
 =?utf-8?Q?L8uTpgpt3gb2WfQZ1+C3/Nk0xUY138dRQVkAT5kWDlyDY?=
X-MS-Exchange-AntiSpam-MessageData-1: J5MgCywsTnd//w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3818c397-5733-469a-1ba9-08df460c91cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:13:11.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QROUOl226OrLp6tpQdPIY6RXsgD5OV4Snbg0aOATTUR3TJAq42zuL7OwVm81tTnV18A8jKBtvdM6UHBWjtkveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wednesday, November 11, 2026 12:19=E2=80=AFAM Joshua Crofts wrote:
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function calls.
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/gpu/drm/tegra/nvdec.c | 1 -
>  drivers/gpu/drm/tegra/nvjpg.c | 1 -
>  drivers/gpu/drm/tegra/vic.c   | 1 -
>  3 files changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.=
c
> index 18a8f6e4ced083ee94cf1611223b7ef507e0b7f6..98a94423b0e2099b9f8330f73=
dee8f534564078f 100644
> --- a/drivers/gpu/drm/tegra/nvdec.c
> +++ b/drivers/gpu/drm/tegra/nvdec.c
> @@ -212,7 +212,6 @@ static int nvdec_exit(struct host1x_client *client)
>  	if (err < 0)
>  		return err;
> =20
> -	pm_runtime_dont_use_autosuspend(client->dev);
>  	pm_runtime_force_suspend(client->dev);
> =20
>  	host1x_syncpt_put(client->syncpts[0]);
> diff --git a/drivers/gpu/drm/tegra/nvjpg.c b/drivers/gpu/drm/tegra/nvjpg.=
c
> index e302a8d1f6e7fdbcd7f14881525b4a2e1a422361..09679bb0c75767ff1471134a4=
78b5985b2c0ee5c 100644
> --- a/drivers/gpu/drm/tegra/nvjpg.c
> +++ b/drivers/gpu/drm/tegra/nvjpg.c
> @@ -82,7 +82,6 @@ static int nvjpg_exit(struct host1x_client *client)
>  	if (err < 0)
>  		return err;
> =20
> -	pm_runtime_dont_use_autosuspend(client->dev);
>  	pm_runtime_force_suspend(client->dev);
> =20
>  	host1x_client_iommu_detach(client);
> diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
> index 3c2b1ff55deb7f407d2a5995a5dff302cf37f7d5..9648c3d0176bbfd9efbb3c49c=
8bd9c74e3df9d0e 100644
> --- a/drivers/gpu/drm/tegra/vic.c
> +++ b/drivers/gpu/drm/tegra/vic.c
> @@ -205,7 +205,6 @@ static int vic_exit(struct host1x_client *client)
>  	if (err < 0)
>  		return err;
> =20
> -	pm_runtime_dont_use_autosuspend(client->dev);
>  	pm_runtime_force_suspend(client->dev);
> =20
>  	host1x_syncpt_put(client->syncpts[0]);
>=20
> ---
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> change-id: 20261110-tegra-remove-dont-use-autosuspend-caaf082f8c2f
>=20
> Best regards,
> --=20
> Joshua Crofts <crofts@kernel.org>
>=20
>=20

Nice cleanup, thank you!

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



