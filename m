Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C960A2633
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=srRqMCSN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964B710EECD;
	Tue, 10 Nov 2026 08:58:45 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090D710E209;
 Tue, 10 Nov 2026 08:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjetczZCR2LuSCTPhc6DAn6BdkAYHLPxxrWqz65GUQn6eIlPwczqcjHZvQf0KQlxNbLpQKaWn84cJaLK0Be/8IZRt2iMKkv3ieiNF/+HDCkd75/8jvhHCL3fXLK69FYZ1bOhmpznStf/qG87eiGWwDf/fT6JdGmzBR3PoXRTBr4ajWBB6XhIea2okHUBXLe4ty3bZqOM8xtmjRZFnfUvdgYgqnWtgARfgW24F9p318EZeK0mHYIAFyOeZuNFjj6iDPc75tbpYIEExH3B/hVV3elTriU1moj4gcy7CWAjXA6Tbeaeak6LLgW661Mfqp7Zg0bU3gZypehPxYiGa323SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyhw9F+rYdwsMy4FzXD0Z2KPqp9LEkxDZ0WIEMmISc4=;
 b=qRe1Z3P7j7MJGSSNMG+wkirshyNMiK1kqJv2t30G5ZQ9l0LtwgBMxSwPNdk0g/3nUiOEms8JloIwQn8kVIemmucn9HtcUhHVomI4/+g0tvXKFqG+PUhKgzPn7DKL5o8EI2LIhw/1vrK7WEV8GvbJMGbnTvd71l2RjeIjMEbZVcEQViwQ5yUICBs/RqupqUHMsZZP9dZvVUF4BB2ZfjpKqOW7StgrjChcpOsaBB427849iD7kfIulde7engGTnL6b8QUcrHQ8zXC4dssWe2fvXW+lBej/+JUSIHcSCZG9C7H+pby1L64CW2vnuf/Ss9JN7YsxPEi7TWRDPO2SLAHyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyhw9F+rYdwsMy4FzXD0Z2KPqp9LEkxDZ0WIEMmISc4=;
 b=srRqMCSN2tgUSD8p/sxQ4Y+twP4pKe8SR9vm3qVQIq04aZ6JGJsSIe88XhD6FwyNZoSuzu2rLFDBoywtFMJmBXOGhPXdIQh5kEw6Bes/uEowDM3m+Aa8w0dlH7Tk3X+q68/uwr/5T6tn4a2543t4Iq0DCyE0gHVVlRARRnE31ac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:58:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 08:58:34 +0000
Message-ID: <aaa316ae-3fd5-42ad-b1b9-287a8628f246@amd.com>
Date: Tue, 10 Nov 2026 09:58:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] drm/amdgpu: use pci_set_master in
 amdgpu_device_mode1_reset
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Sashiko-bot <sashiko-bot@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109171333.4329-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f0bb26-c375-40b5-2d78-08df3f08ccfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|11063799006|4143699003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|261009223027099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info: lvXOtKrUlh1ocwhAA2Lg1PseJf4r4HTQiZhBEEuVRzKti2GDD50b+ju/pThWvuhZgfU+yGjPX2iklhTbcFY19T3ebLde/gXTiLer7pKuqeUCuO50YOrzRmPR783gRqIwujdJFaB6xqwqxnP47DO6TfFp7g572gs95EBuZJAidreQP4mH9kf0kmX96fwCYPIIqvio5uXsJ7qi4KCtiCHioHsMpYdqb6LMCK7d2Aw1T5YEsd4wIBFjDJfiDDvmDnK/Urh5I+obksSYB/dgHlov59j0qBcfIwoerEai6tc3fZ2xpsHRuEEzOiBmYdPaoubzKLAa9TlUTn3/5SpFjFuyJSoyk7zacIZIRBv3rO+kkrobTAo67D2R/cti6tf8oQwLAjJaALXurXldEObqqWeB7eX4bbt5cI3IiSQ0Hyoiyh547CiGLqNjFPOT8a6KwdTdgspCJlSeTUZPQ3stlhrEwr9GSE1AVZcAydoyri0eBF2HffesdlV4TxtV7VDAXL1txA/D55vH5rtW8F0IBwqgI6KR2KBkiBP/hhU/L6XYKzv6ADCCa+gAvD+DVAT9PebQr0vyd0Z33DkIMe7EdCmURuRwDiko9bobXTquMSxy96U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(261009223027099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWlVK1JrYWZEYW40ckYvQndySmwyZzlEZ3ZRek5sb2xLaW80NGQwb2FtMU8y?=
 =?utf-8?B?ZkpvREovZmFGRWVoZzBPeXkwVllGUkxHN29neWZXMUtsZXY2NmhXdDZScVFT?=
 =?utf-8?B?U1pNRlpScE9mRGhqd0h3NkRDM0dHdk1USFJIV24rU2kxR2ZwdWJTMU9abFo0?=
 =?utf-8?B?bGUzRUYyUnlCNzFUQ2FCMTk0RTBhN3VQWTBFcExaWE1tT0dRT3ljSmZWNmtU?=
 =?utf-8?B?S2E4enM1ZHhrWXpoUkhseG1QU3FVRFNZUDFBYnlLdE1JcWpzU1FRS2RqQUw5?=
 =?utf-8?B?SGlDWUlVK0dHYysvK0lONVlPSE1yNVhhUmtPV1hsbDJtMzcyMVRaNzVQZW84?=
 =?utf-8?B?MCt4WWpMSTMrcW4xeS90QTJrRUJYM0k5V2cvVnJSRm5IVEFlSnh6OFZETFVM?=
 =?utf-8?B?U1VIVkdYNExRWVVES2kzRlpUU1cybHdOb2JlREdsVThmVzlPbmdOLzVUYm5m?=
 =?utf-8?B?TmxVcEV5WmFwa21hc3hrTmpMU010UTY2N0pMcm11bWpSWFNsNGlSQ3dLRzBu?=
 =?utf-8?B?OWxlT3dKMUhabytaMXRydDIxeXplWnNpSnpGM3dDcm9wMEV1ZlRZSFF0cjJn?=
 =?utf-8?B?eTFVQytuUWtjMit4Nnh1Z0o0QWl3eEhYUlh6M0QyM2pIM1NpRzJEMFJHZDBh?=
 =?utf-8?B?akkrVkFJQmVkMUoydElkZ3EvR1A0UWRtMCtOWmV5UVA5cVNZaDlRbHZDTkZw?=
 =?utf-8?B?Z0Z2SGE5WmpMQWVhYUdhaFNvUG4yN0YwSGJrUjFQUVZLR0xxUnFiUkVsdDdC?=
 =?utf-8?B?ZmtqejN4R0ZLOWZoZFF6M3pxYTdTQmRqRFJJUE1heDJ0dkdCS25qOWRZcFps?=
 =?utf-8?B?MEsyYVF0VFdWTHpsMlREWVcycWM4TWlKZFFORVFZMFNMRlRZY0JwS09hVy9y?=
 =?utf-8?B?R1U3dzZPenJUQ0M0bW9MTTBkLzN0MDBPclFKcFJHelFXU3QvMVgwWU5pakJS?=
 =?utf-8?B?UFB3b1hFcTRORlFsWnR1SCswcTl6WmxmcHJOcjh4eFVXZzlHK3A5a3ZFbWE4?=
 =?utf-8?B?eFV1K1FZcHV4dE9rUDczY1lYQ21GNXJ4Q1ZtUTNPUHNXSmppcWpQT1k1THRV?=
 =?utf-8?B?UUhPWVg0V0daZTJMNS9EbWlzbG9SbE9RVml3OWJBTWhMaldnenFEWmNEVEUy?=
 =?utf-8?B?ZjZVMGhRNlZzVFMwdkZldUdyeFJ6SStVT2hnMXpreWllcWRaVDFjZjR3OWh4?=
 =?utf-8?B?d1BGZE90SUVnajVCOUxQR080V1BNRFdFbmlMYUFVa2RHVGlXdGJvVFJndVlD?=
 =?utf-8?B?ejhpQUhqbVF1SjI5b0ZsWFJUMXJpZURsY3FmYTUwWDJrK0dmQlJjenIya0s0?=
 =?utf-8?B?S1JkTFJuSHRiWTA4TktBZzdGOHU3S1JRbUFFbW0xUkg0M2V5ZnI3YTM4MWd6?=
 =?utf-8?B?NHJ4V0l3b2I4N01sL2lWL0I0N05JSkNScllldkpvb1BzeHNqRGJQOTVFTVFr?=
 =?utf-8?B?Y3V6bG03M1U4aWxLTmViVEs0M0lBTUttLzFiL1ZVQk5YTklGS29oZ2x5TGky?=
 =?utf-8?B?Q0ZCRUpkMmFBbjZuYVFBOTVrSTNCMFRMOXdVdGR2V3BpN0FrMW1OMElySnA5?=
 =?utf-8?B?UXRYb1VxQkg0VVhFOGdEczdxK2cyaUw0UGNlQlVqRWxGQWQvOVRubGlVRkZE?=
 =?utf-8?B?Q3NydE50dUdJRnNpa3h6R3B2WEI0M2YvV2g2d3ZTV1NzK3lWQ2xFVXZ2RWMx?=
 =?utf-8?B?ZWlscU54Y3RlYjdEL2lvdSsrYjlyOTh6OGN3dlJWaktKS3l3NE1CUjEyQnAy?=
 =?utf-8?B?akR1TVBOSHhyRkY3QWJyWlk2RDZzck9vVzRjR2hmU0NUTDF2dC81b29hc0l0?=
 =?utf-8?B?akFxMm5tbEdVWERpWHVpZmk2ZUd6bHhwTjRmcXBmcVVONlQ2MTNJd3Nlc2VB?=
 =?utf-8?B?MWRFRGNicm5rbDJvbWlWVldabUtYTEN6K2k2TkdvcjRuOHFkVGhEUVlaREFU?=
 =?utf-8?B?NE1kT0J6bHMzK09vbHNQSkltQWNZV0xya3pVK3FEMC9PNFVmdkhXMEhMZmd6?=
 =?utf-8?B?Z0lUVVpGZDhLOElsbzZFellEb0RnTk5wY0d0MmhQaHdIdkRTTnRKWmkxckFY?=
 =?utf-8?B?czVhRTAxaDdQeVdGUThTY2MvYlh2QjczVWVyUTlEc2ptZzdZQWtMNlFZaUk0?=
 =?utf-8?B?aXR0eUMzOTBybTlVNTBVUzhpRjBXQXh2dVl4SXBVZXo2TVhOVkFpd20vdlpF?=
 =?utf-8?B?TkltYU9VZTd3YkcrWkRDRkJWZG9KNnNKdlF3L1lOVnJLWFZCYkl6QWpkMDln?=
 =?utf-8?B?ZWh0MWV6UkFxMkRtU3ZvRlF6di90UTFYWSsrODBSR2tmYTIvQ0pueHI5NWVl?=
 =?utf-8?Q?xwsNzrX20QvQWU7rCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f0bb26-c375-40b5-2d78-08df3f08ccfd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:58:34.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbcEW5LwBScIxLpG0VmJ7WE+tzW62riZ9L0MODPKAt3JXGIjlIMhsjNuYtiKc5pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 18:13, Pierre-Eric Pelloux-Prayer wrote:
> It's explicitly disabled above but never re-enabled, assuming
> that amdgpu_device_load_pci_state would restore it. But if
> pci_clear_master was called before entering amdgpu_device_mode1_reset
> the saved state won't have the master status.
> 
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=4
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..730e9e93d078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4981,6 +4981,10 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>  	smp_mb();
>  
>  	amdgpu_device_load_pci_state(adev->pdev);
> +
> +	/* enable BM back */
> +	pci_set_master(adev->pdev);
> +
>  	ret = amdgpu_psp_wait_for_bootloader(adev);
>  	if (ret)
>  		goto mode1_reset_failed;

