Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE2606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OYHKC5T0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9D910EC3E;
	Tue, 20 Oct 2026 19:14:42 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC5610E215;
 Tue, 20 Oct 2026 19:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvLTDaYaEqJe1iaEic9vUaYon5aGQHnsFA2kVN0HI+V0+hdikW44pa0SzIDgWyDC2ynCrEr0IZ+HfGr8+AsFi2w1hcDoh9/4r2XhAp40l2OKbgy4g/9d6LGPkQNlevMnHPNKcV6lILES1issACD9QekDuFtyAYoKVfqAa1zYf1L7fmZvFqFPtu3aT2KNOcD4Qb64ybLQa4hUPhteUyuAo9erxL/xGHpc+Nc1w+Q7nmsE3T8YxJuNvcH7l3iVxUxAhaqcrs0StPgEMkilhOIDTe+JR1gnuidbnnkZOjaS68Db62ey4bWk8TBP0MCA5KGgPBq4+d+goDTXHW6vXfXNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d4IG9S29wybTx7Exeo1TsHIVy7PUvMX3ckP1t5w5VM=;
 b=hIc8c2FPR7TZYdb3x29G3DqOrQazilurY+YE6PJ/azsNMdREOzZvwUwfoOA/avkegdaTDEvPb3uqJ4HJLpB2vFOeCve/W9ducPlXzyzshMXZATd+r8ozpL52paPbBs44H5uMTpYVkUWcO9kbtICEVlV3sgC5Tfi40sFj121XTHHebqfPpIkfYOiyEHyUlrg+DaQBXz7RUXSZ08jNzKpAopRn8069e87JSaxBcGZBLl9vqFcbDMleaUMgRmsO88TkUTUIVixDcPJvduD+YfTLvkBmZsfp+o/5TTYp3DD8ePqIE/Oi0QPed2bCgYFKGspkIATL98sMo45sKCY+C+O+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d4IG9S29wybTx7Exeo1TsHIVy7PUvMX3ckP1t5w5VM=;
 b=OYHKC5T05Ov/sW0JLpJ9XMnG3UM9cwQZ9pdCs8PkxCVj4H0JJPUFYciq4jxPSSbd3W1SYhtuL+zwR1HHCez51ruijVfXOEGDP94t7qznNwJBwlZlD/5PZ2WXV5g3jw8Kez5KOXJhlBKWBR4RYFBOYAiXWFZq7SjWnd/s+uC9wyA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by DS0PR12MB8293.namprd12.prod.outlook.com
 (2603:10b6:8:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:14:33 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 19:14:33 +0000
Message-ID: <e39ddfb1-7a42-449d-86c6-92086fec5ae0@amd.com>
Date: Tue, 20 Oct 2026 15:14:30 -0400
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v7 1/9] drm/amd/display: embed the writeback encoder in
 amdgpu_dm_wb_connector
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <20261019-wb-drop-encoder-v7-1-d4288a26eb54@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019-wb-drop-encoder-v7-1-d4288a26eb54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::23) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 746eb3d8-cbce-4d77-7a2e-08df2ede5f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5yHoSKhoS9fsP4cwEPmA+c1VHyK8Vg3jyUG83BWkT0xV+e9c3Kk1LdV5eahoCy3RHz6u/eoneOgO6E0wxQy0gxxAkRlFoWZoWn112AxyHMIZK/Bmrgf3Mcvh0x6b+6zyu4Dfw5pOBo5DhIlIExPzrAOJCY/Q7Pr2u/IVUBVBOQ6soQyR5+HaiEaknPCrzLxbZa7wr02J2wPAKyoavzr4Y1OuQE7jzpfL+x1Vb3t9dRxsaKPo80jb4g80aZ4+6j5XKHYjrZYepFyz7ytsUCp7DMYGYKXqxX6BWRuG9xvgS4Mfqn5pGIqaomnHXDoq5K6otAZ5ivzzWr+EMm7EZVBc17JVej1apDYMuYjP+uWSn9Vpi7Mnp2mX+s7auUhG5EFUDcUZQg+aAjQxqUedjnE54gQ8s/bwmkIwKVCwuCjzgzT8UjhA6kCXQfMJMde7bXO/TuSXu1+JODdH2usX0lTFNILcFGGQ94OIKtOlyzBI4ixxdhEZ3OclSAtCsOlWvfSjq2FQ7ONV/KIfmSlQahnJadJuW4k/AiC+nzeS/5adRJRnX5FiSDyhyqGCRbigsXM7WqV9dTUjGOr1Y7r0YuoEt1KNQHhDCORRVkfyQoD+zwmcLyStv7EXPKb2C5HD7f5zVQg1Zuso6W5ABfQOUbR+om6MuaPMyMA6EOoCLBOT4Fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJ6NXkrYUJYQm01bjdtS2VqMmRJRXJGU2hwelhHb3VOSDFaVkl2V0V2K0U4?=
 =?utf-8?B?WENGR0ZGVC85bUxpd0ZGK3J1Ykx1Z2lVUmZBajBkc2E4c25qMUV3WENldFBK?=
 =?utf-8?B?SmlrTGgvcHpSeThiTUpNQnNMck1jenlRaENydS90Wi9lUkJPcFlvcFdpbS81?=
 =?utf-8?B?OFJaSzhzS0UwSVJmaEtnOHI2elMzcTVZWEpJOXBIRmNTVFZ5cnptWlJEZHp1?=
 =?utf-8?B?T3paNVc4QUc3Q3F5czg0MEdDTWw1TGV1MWE2dlZmMVJUYTVUdXgwcHNnS3hZ?=
 =?utf-8?B?YnU4aXQycWJFTG1WV1U5K2xYVER5ZUZRdXo0QmdTalAzTE9LdzErRmpwV3g4?=
 =?utf-8?B?Wk8rMmNWNDR3dUYyemhBQjQwbUtvaDNzUXM3NEU4dW5UT2I5YjQwN3U5QTRK?=
 =?utf-8?B?M0x6NlpNbFhiUXlTYXBsdnFRNUEvSGhOZGtrV0FNNnB6OU95RlR0VWUvZ1hs?=
 =?utf-8?B?ZEZpSkhmQVl6WFdBNzEwZWhoY29vNFN1QVdhZmk1dWh5eWp6YkpTZFU4QmNs?=
 =?utf-8?B?b05wZ1FCZ0MvU09CdzgrSlpZQ3pMeDNZMDEvb3dGSWZXcFVIalJIaWw4dnF3?=
 =?utf-8?B?YnlpTTkrd0JxbHEvZHlXUDBXM1VkUUNKYkRzTndGRXVTUncxeXI3TnZ0OTdC?=
 =?utf-8?B?QmxRTFl2dlFJK2p6S2xjYUgyZndWQ25nVXl4MXBTS2JEOThvaEowUlE1Q1Fm?=
 =?utf-8?B?NWJHYWlGamxkQzM1L3Z2UXNOSEVZcnFDRGJodWFVNTBLTlFWT3dmUzlTbWhU?=
 =?utf-8?B?OVJ4bzdnVC9hWnRIa0pKdlE5TVVUZUdlYWp0SDcwNUVCZ0tHZXo3R21lUDRu?=
 =?utf-8?B?TEx6SUNveWRidDhmTHZzemUrTkRpdlc3OVJUT3ZDa2J5Uk1Ha25YcFNWNlB0?=
 =?utf-8?B?dVZacGVkWCs2RkFqUEczd08wWDB2VFRLQ1RrdVFhQjZoby9rb0x4Znp2dHdQ?=
 =?utf-8?B?QlYyYnlPVmZhRmowVzNUN21XeDZsU3hoUGVoM2lML1k0K2VrOEh4UkROMVRX?=
 =?utf-8?B?SHRuck1wdkdZeDFxWWFVU1BvSXV5N1lqbWY4dkk2TFl0OVR6d3B1V2w2dGZK?=
 =?utf-8?B?QWlWVUdHL3luRnpPSHROcE5laWM3dVpMZHgrS3NoNXpnMkgwUlE3YXJoNWtZ?=
 =?utf-8?B?MzRad3FlL053dHNjcVZGZFY1YmNoTW9oYjZtNTRmWXFOMzFJYzZhdGp5d0lD?=
 =?utf-8?B?U1dCa1NMYkpEQjhNKzlyK3ExS3VZOGVaTzg1dE5OK3p2ZmpHWUlSQXdIMGho?=
 =?utf-8?B?MTcya3FWaGxxTlVKaDNSOTdUMmo0a2huTWFVMjlIeVhwU01uVHBJNHpFMkRi?=
 =?utf-8?B?amNjb0hCN2g4ZU9uN2luYnluSUZqZWpFd1N2Z0QxN3dhaUxuVURqVEpEMnR0?=
 =?utf-8?B?bzhXV3NpZU5KazhXUFVnby9qUzJaS0tQckRQaEp1cHhoRTNpR0NOZkpNVVZq?=
 =?utf-8?B?QitQZTV0cUlmQlpTWGN4L3RMRE5lRkpkUkIvWFhYTUpLUm1vOWJ6Uit5YWh5?=
 =?utf-8?B?RS9HT2VTVVVTa09RTXEvc2FpK3FMSmJRSHVsM2FlZFRTZlZLUUVWZzRHQlJp?=
 =?utf-8?B?cTE0TzUrWUU3WXlxbkgvS291Qmh2YUY5L3FhZGx6MytQMDFsck1sQ29oQzFu?=
 =?utf-8?B?bExzN2tncWNDcmErSEk1RUt2Nnd4MU1YaUZGcUNWR3ptN256dG96eVlTTFlo?=
 =?utf-8?B?Mm9rdXJZWGZxVlJTbkErTGFjNnJLeDRqVnhrd04yaDlqVWRpaW1CWjN1eEph?=
 =?utf-8?B?eDM2Zjh3cDFVTEYvaWQ1MnlPRThiamtkT2hZakZDWUpRUnJmUVYrRm54ZlNX?=
 =?utf-8?B?bCsvajIyWTJTVUg0a1J3dU1CKytRbVlWYWhFTG5aOGMwZjhYeXVQSnBhU3RB?=
 =?utf-8?B?RThXRnlrODl3REVKODJTa0J5SmNiMks3M2M4NGU0V2VxZWd0QXVyYk9USzF6?=
 =?utf-8?B?ZXRCTzBndVBWN0h6YnN6ZjFvcTBHTVFiNWM2cUg2anR2VUtKUm82WDRISGxL?=
 =?utf-8?B?OHB1cWNJSWRpQ1ZtZVZycy9MdmM1R3pKaXgyeDZicDdxbE5NL0ltYVJ6eVcr?=
 =?utf-8?B?dWMrKzNRZXowb0JES1VhSXlhbDZ6SlMxQnUwRWVkQ0ZqS0Y5N2MzK2ZuKzVk?=
 =?utf-8?B?WUk2eE01UXNiNGtrVEU0eXlKK1pqbVA3d0N4REkwZDNiaDMwMitwZDVQL090?=
 =?utf-8?B?M3ZBYUFDU09DQ1BjSjloNHBGNVJQQS8vYThQeURDNkJ4U080UTRjN2RjdG9H?=
 =?utf-8?B?NEp1b3QvdGlvMnI2NnVNVSthalZvTVFqamtRczkzZVh2SzlHRUdJaGRYK1pO?=
 =?utf-8?B?ZllEbFEveEM1M1RtL2J1bVh0QzZCdk9XTnNGU21Mak1lcTRCdnNQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746eb3d8-cbce-4d77-7a2e-08df2ede5f6a
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:14:32.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwI3NswoR+OSrNhDCWmYueYMMx/1eTBzcpS7bYSgvsbtHjsGTUeXYPrLU6ulMgN1626tf0+WRjVxJYI4c6qekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

On 10/19/26 09:12, Dmitry Baryshkov wrote:
> drm_writeback_connector_init() hides the encoder inside struct
> drm_writeback_connector, which is the only reason that structure carries
> an encoder at all. Every other writeback user already owns its encoder.
>
> Embed the encoder in the driver's own structure and register the
> connector with drm_writeback_connector_init_with_encoder(), so that the
> encoder can be dropped from drm_writeback_connector.
>
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 29 ++++++++++++++++------
>  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  4 +--
>  .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |  4 +--
>  5 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5e106b65034d..07dd69b42e83 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4805,7 +4805,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
>  		goto cleanup;
>  	}
>  
> -	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
> +	acrtc = to_amdgpu_crtc(to_amdgpu_dm_wb_connector(wb_conn)->encoder.crtc);
>  	if (!acrtc) {
>  		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>  		goto cleanup;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 1d256dce0e4b..d365370d9958 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -930,6 +930,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
>  
>  struct amdgpu_dm_wb_connector {
>  	struct drm_writeback_connector base;
> +	struct drm_encoder encoder;
>  	struct dc_link *link;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 6f91a992d43f..b5b186e4f81c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -218,6 +218,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *c
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
>  
> +static const struct drm_encoder_funcs amdgpu_dm_wb_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>  static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
>  	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
>  };
> @@ -246,17 +250,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>  
>  	wbcon->link = link;
>  
> -	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
> -
> -	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> -					    &amdgpu_dm_wb_connector_funcs,
> -					    &amdgpu_dm_wb_encoder_helper_funcs,
> -					    amdgpu_dm_wb_formats,
> -					    ARRAY_SIZE(amdgpu_dm_wb_formats),
> -					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
> +	drm_encoder_helper_add(&wbcon->encoder, &amdgpu_dm_wb_encoder_helper_funcs);
> +	wbcon->encoder.possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
>  
> +	res = drm_encoder_init(&dm->adev->ddev, &wbcon->encoder,
> +			       &amdgpu_dm_wb_encoder_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (res)
>  		return res;
> +
> +	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
> +
> +	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
> +							&wbcon->encoder,
> +							&amdgpu_dm_wb_connector_funcs,
> +							amdgpu_dm_wb_formats,
> +							ARRAY_SIZE(amdgpu_dm_wb_formats));
> +	if (res) {
> +		drm_encoder_cleanup(&wbcon->encoder);
> +		return res;
> +	}
>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> index e27f6e504395..9d237f2db95c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> @@ -4535,7 +4535,7 @@ static void dm_test_clear_writeback_removes_stream(struct kunit *test)
>  static void dm_test_set_writeback_no_pipe(struct kunit *test)
>  {
>  	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
> -	struct drm_writeback_connector *wb_conn;
> +	struct amdgpu_dm_wb_connector *wb_conn;
>  	struct drm_connector_state *conn_state;
>  	struct drm_writeback_job *job;
>  	struct amdgpu_framebuffer *afb;
> @@ -4565,7 +4565,7 @@ static void dm_test_set_writeback_no_pipe(struct kunit *test)
>  	conn_state->writeback_job = job;
>  	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
>  
> -	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base, conn_state);
> +	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base.base, conn_state);
>  
>  	KUNIT_EXPECT_NULL(test, acrtc->wb_conn);
>  	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> index 03036f906385..2711696f6b9c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> @@ -506,8 +506,8 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, wbcon->base.base.funcs != NULL);
>  	KUNIT_EXPECT_TRUE(test, wbcon->base.base.helper_private != NULL);
>  	KUNIT_EXPECT_TRUE(test, wbcon->base.base.state != NULL);
> -	KUNIT_EXPECT_TRUE(test, wbcon->base.encoder.funcs != NULL);
> -	KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
> +	KUNIT_EXPECT_TRUE(test, wbcon->encoder.funcs != NULL);
> +	KUNIT_EXPECT_EQ(test, wbcon->encoder.possible_crtcs, 0x1);
>  }
>  
>  /* Tests for amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */

