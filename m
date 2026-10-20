Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD36606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y+sinKDk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4E310F61B;
	Tue, 20 Oct 2026 14:45:15 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C7B10F61F;
 Tue, 20 Oct 2026 14:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsiEamC7QXWiMiKtZcvOj4IY8CHGC2bgZZ/MDeuXjeCdrAY4na4rCZej2cs1276gO++VZyDDLi7sv3CkmEANfhDWOojXfKbxsaRP0cPzYtptO3pA99CznCqlIhYR0Zj0JIdnIySxFQV62k4NLhtvPzJhOj9R+1ZyXPO0ZigTbe9J37kSvkYkMTgIxPEHinBaR/0PHxgdJTPxye9tytjqE5M1DMbpNAUD1hgf0QKBpiYUY6BT+/+1c67gOjSR2RBEv4mxRo2AKfeX6jDzaakrllClX4JiqBJxUW3rulW7ZrkyNvudB4uWPLYcGgQFI76JHKgndBUt7CxPro15qMN+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fACDY/0L8yTB9c7QJqt/uxQ+rPlo1wpjlfYMExqpJWU=;
 b=S7n3m2k6mJJhyGjK6dUi5H1ORbmz0ZyS9UGbjQWh9AQkw3X0CruOHbo98q1NyQ20bCNOIOALXTt+/gbuI2hYcBTQXU0Gz4tBQ6jUQ58a3uWBXa3EHYFkep4usdzERRjqJYImai3pyWgmKEmqvrLvqj8NolRMJBLSoan1QdgCKlNVXHXIXpW9AfIS07Ps1m3Cz05L8bizpCKD9O6LDGSIazimgMnu7IfA8bNifjw8mMJJlWMTvc2QnhUj3eT5BS0rKxREDo5rHdhe0GH2Pj0l5dYZ+jBavJ/W0i3Llx2G+Uro7mxHfyLZMGFdxofOR9XBJ+YQtjhkgTW7kP6BJBxk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fACDY/0L8yTB9c7QJqt/uxQ+rPlo1wpjlfYMExqpJWU=;
 b=y+sinKDkekTwpMr33LhKDVhVFqdEL0O6G+4EujcY1cZ2Pg2c1MHwa32gyoQt106QfdbJzS9IULHRq8p2FpsEhfdib4fD59aNaioGVOV6qesWNpqU3Qer5uu5q+PQVrmLrk/4+IibAX61G8DmcL1PpJxsJ/k+Im98vTDbtxeh1Ns=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by DS7PR12MB5814.namprd12.prod.outlook.com
 (2603:10b6:8:76::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:45:00 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:45:00 +0000
Message-ID: <11ad129a-3e7f-4a77-9c4e-58f6681e1359@amd.com>
Date: Tue, 20 Oct 2026 10:44:58 -0400
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Don't ignore dc_commit_streams() failures
To: 2564278112@qq.com
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ray Wu <ray.wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wang Jiang <jiangwang@kylinos.cn>
References: <20261008071700.552056-1-2564278112@qq.com>
 <tencent_34284E790157CA20C27C9260A7A32C08C10A@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_34284E790157CA20C27C9260A7A32C08C10A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9582ecbd-de84-4f5c-9dfa-08df2eb8b7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: gHnx07z4TbvE/wb0qFmtJUC7/6d4/S1tpEh700c6navmmHv5stgR9pNhMdmgvUuKW3EZE03hnCHJ/Ph0hBdWhPEUqp1RlkUYMNoHsZYxc9ljfxMr/tYxNZMyecX2JCf4QKcscxaK0ZzqNUwaPj3DPDdJ59n8dOVuxYTfeAIO/T9PG4Jw9GM2fUZUh533Da03IIOnrouF+8qFHFKaCJ6T8aYPkiLRB7IcJ46FtRRo3W950HHlrOcuRPee3QFqBJ+QA9O3ufA+2prsZMPAOdLJL0YK2clvWP4S++L6uxYV3NFRzJzR8MpBaLtAh3ciTcF7H6KNkHOiJtpkB6jGuOxvt3WE7yq3pTx4lpDp/1hvaFLG3sQICGmRLKjtO5Z+aPKBmukqSwe93ErjnP740qcm2mGFBgHaEkMAHFOQEYH1HvbS90D7oI/8Z2R4P01qsOcpLFWw/rgzWoda8r02Lv5PcoQ/sQyjKtqXQD7ylE/agQ0iD/sp9f8hWdS+4QyEh/O60Hf0Q0TGsi9/YXX4JhmawM0myj80zKweCDAFCNryPuLlA/fZ+bqgJYwTKakqzGWtGufRyAF3dxzjkRckYGKvKLp7Ux9Vjad1yMHYvlX8KF2NGj/yFKDlL9Yw3r8A1tm4F2KquSWYK5dNQR88OuFBOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmV3MTkvVmo0V1RGbnVwR1pnTGR2a3NDMzJaMmxRdW1yR2Z2VnRIenV1dkxI?=
 =?utf-8?B?R0ZPRVhIdW44WE1reUN3NFg4SUpzNkpmMVIxN0hYY25HbHRZbjJzQytGckxi?=
 =?utf-8?B?SnhEb1lmOTh6cklOUk1RWjFKTGR5OHVGdDhQOGV6a1pBL2ZneklMV3UzRHgx?=
 =?utf-8?B?akZDOTh6bENjVm53b3VWRHJHQXAwREZsU0htM1NpdEhTWHFYT2VIUWxVSy9q?=
 =?utf-8?B?ZnNDZ1RwZkUwaXFYcGdtWk04TWlOQldFd09paDNpVHRHeVJPOUFpT2RSVnRC?=
 =?utf-8?B?NElJZ3RyV1J6ZFcyamU2aTFYTjMvdEtZVGErbWxPQmdrL3ZrUzIvWGRQWGdX?=
 =?utf-8?B?eS9yOEsrMWdUWnp4cUVLNXZtcllVRkV5M2pBUjBuTlYySlZFTkRJRFRCaHdD?=
 =?utf-8?B?eFVmWm55VHUvTXVUcm9rR0U2c0k0dS9TVUJoY0pOK0p5b3RCTUNXai9ibnlD?=
 =?utf-8?B?OXdUaDFpdEcrczd5K3lsN0RiVDdWL3dSYVd6bWVhamlqcDRUbTR1dmZPOGNv?=
 =?utf-8?B?cW9STFcxMm5wS1BCR1BDNGV5WXN1b2Z0eC94b1FqUkVIVHk2SjJhMnNXcUFm?=
 =?utf-8?B?MTJCaU9hUzZGZ1M0b2R4NTNJU3Uzd2dxRkFjRXI0MVVub2VDZWR0dzVFQm4w?=
 =?utf-8?B?L0JJdGxVSTkyYm0vVVJxbEMvbTBZbGNLc2hLSFNTclBaWnFQMXd3M3kvTGh2?=
 =?utf-8?B?QjlrRGd4WkxOYzJkdlBUdnZtd0xBS3VoWVFJU0c3VS9wWHhVenRrMUJHWm5J?=
 =?utf-8?B?TXRkdEVzZVl0L2xpZ0k2a2FBYnpZRU9UUTVDSlJQdzdiV3A5MkpvQVlJMG16?=
 =?utf-8?B?SVEzSVpXMW9qdTE4WEQ5WDN0RGZ2TlBuOS9VQVMyTUhJVFFjSm03WEpzaGtx?=
 =?utf-8?B?S0MvRysxRHFGVEs2SE5Yb0ZSNE5YbHhEeGRUWm5CR21wajI4andSSnk0dno5?=
 =?utf-8?B?OXVIbll2RkRPdksyV2pyM09LSUtSeWpZK3oreG5Xb1pPdjI4S3ZaWFAzbkpN?=
 =?utf-8?B?Z3RDN1IxMmpGNm1Ub3loQUgrVXFyRW81dkhmWmVIS0M4bUV4T2x3TGNQZ0Jx?=
 =?utf-8?B?WDAySUw5Q2pTQ1lFWmVTalUxamNzcitDU0VIbEduZ1Q0NnBiekRSdUQ0UHJz?=
 =?utf-8?B?UTkxOWhzS3Bxb2kwQXFKZkFUU2RvNC9LS3dCS2Y2cE12TUV4YzcyOTY0WEJm?=
 =?utf-8?B?ZzJ6aFZFM1FESFk5UFhJNFBXVDNmclZKRzRSaFozVXlpeUw4OHpzN1VzWXU3?=
 =?utf-8?B?QXF5V1BESE9mdlZVcTlLSFFzSytYT3AwRlpXZUNvRXloUExaQjVTSUtSaFF5?=
 =?utf-8?B?akhucW84c0FoZzZ6bTZYa1FhVnVWejN5RlI2cy9wNWVmKytkdzh4TzNLQXh3?=
 =?utf-8?B?TUcxZUlkYURHOURoYmNuUTJCemZqU21PZnpyb2NvOEd5QjFIRmdwZU8zWisr?=
 =?utf-8?B?bGZ4aEVyNjFmSkROaU9kWGVIbEtjZFc2UjF5Z09uMXZSVUxRbVdKTFh5dER5?=
 =?utf-8?B?a3hRK2JSWGNkNWtVd205eTIvRDNvVmdGb0twOGJRUk1EdmVkSWdPeWpqN3hn?=
 =?utf-8?B?T0YwMjNqeHJIRjRocCtpNkU4alFaQ2xWaHFsaFltalFsYndaMnNaWjdnMkVv?=
 =?utf-8?B?dkIxQmFuMkdPeCtWV1F5c25TQ1Zlc040N3h1SDZYZ3p4YURrYWtoT1J6NFVJ?=
 =?utf-8?B?M3lsSlBDenViMEQ3SnRBZ2VvSnUzdE9pQ0c2RGdGNGZ5YVhGTlpONGorbDhk?=
 =?utf-8?B?ejNPYXZQNUNXaGExdUFzbk1rOERCQjdjLzNFU2FiUzZVY2JHRnozRXVmbXpV?=
 =?utf-8?B?Q2I1RUxJZk56czY3Z2oxT1ZqTzAzWXl1RkVrQjdBVE4zbi82WHVGM1VhK0Jt?=
 =?utf-8?B?MDFGcFN1NUd6Qm1oTkx4MlJGcW82UWRLZTV2SnBuSW4ydENnZUlvU1hkY2pU?=
 =?utf-8?B?S1M2K3loZUxYVktraFIzalNtNFN0M1Z6RkRBbzhldS9yODY4TjJRUDBxQ2o3?=
 =?utf-8?B?SWdYRlJlNlJGZDJCaXVHZWRVTUYwVk5pdWlDdFRoMnNON2RDeGFhNjdyRFky?=
 =?utf-8?B?TXpxVnlrbmhnTzNLZEQ3S3J2eVlXMGtXUHZBQ1FDS3JVZXVOeEJpQmtoaTF4?=
 =?utf-8?B?SEFnNmtXRVRVL0pCTTZZSnFuMXNSYjJOTmlPNnY1SzNvSURKNWZrTVR3Vng0?=
 =?utf-8?B?Q0hGbXllNVppN3lVK091cWtleW5haTY2UFFBblN2Yi9DbEZwNGxFdjhEcVV2?=
 =?utf-8?B?T0NKaDA3VzhjNFRFVDQ0N0pvUjBjNXNwNllEQ21zRXkwRWlWUUlDOVVvUXQ2?=
 =?utf-8?B?UWRKVGhnbXkrSjNlMDhlWUpSNXRjdHNzc0Y1eHllT24rdUxmT0J6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9582ecbd-de84-4f5c-9dfa-08df2eb8b7ac
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:45:00.1450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvmKnH6QdnLDU2xsC8bLzy5TA3Is0YE1VU/++YINWQylekpkmYrj+9PLfPeod8dtbYN0ZdyUs4gRaIxJ2uTuHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/8/26 03:17, 2564278112@qq.com wrote:
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> dc_commit_streams() can fail and leave the streams half committed, but
> amdgpu_dm_commit_streams() and the reset recovery path in dm_resume()
> only emitted a WARN_ON() and continued.  The planes are then programmed
> against a stream list that the hardware never took, which turns a
> recoverable commit failure into a crash.
>
> Log the failure and stop programming further stream/plane state in
> amdgpu_dm_commit_streams().  In dm_resume(), keep the WARN_ON_ONCE() for
> the stack trace, but continue the reset recovery as before.
>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>

Please look at and respond to the sashiko comments. They highlight
some of the problems with an early return without additional cleanup.

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c4c8904fea42..d88bd89da840 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1916,7 +1916,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>  		commit_params.streams = dc_state->streams;
>  		commit_params.stream_count = dc_state->stream_count;
>  		dc_exit_ips_for_hw_access(dm->dc);
> -		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
> +		if (dc_commit_streams(dm->dc, &commit_params) != DC_OK) {
> +			drm_err(adev_to_drm(adev),
> +				"DC failed to commit %u stream(s) during reset recovery\n",
> +				(unsigned int)commit_params.stream_count);
> +			WARN_ON_ONCE(1);
> +		}
>  
>  		dm_gpureset_commit_state(dm->cached_dc_state, dm);
>  
> @@ -4619,7 +4624,18 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>  	dm_enable_per_frame_crtc_master_sync(dc_state);
>  	mutex_lock(&dm->dc_lock);
>  	dc_exit_ips_for_hw_access(dm->dc);
> -	WARN_ON(!dc_commit_streams(dm->dc, &params));
> +	if (dc_commit_streams(dm->dc, &params) != DC_OK) {
> +		mutex_unlock(&dm->dc_lock);
> +		/*
> +		 * DC refused the stream list, so the hardware and the DC state
> +		 * no longer agree. Bail out instead of programming more
> +		 * stream/plane state for a half committed stream list (this
> +		 * used to be a silently ignored WARN_ON()).
> +		 */
> +		drm_err(dev, "DC failed to commit %u stream(s)\n",
> +			(unsigned int)params.stream_count);
> +		return;
> +	}
>  
>  	bool frl_stream_found = false;

