Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F9C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62E10F012;
	Wed, 12 Aug 2026 14:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W5TThx0f";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1CB10F012;
 Wed, 12 Aug 2026 14:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st3gJhlsTeEYMvAWdQqvpbeTQUGv9bDy/92vknPuhozks9B5ghIF0Xy+zfGMmf1icb39o86gR44hiukr/Dka655hsdBkJuhjNV7nsinmFvnFAeBE7pFdLLUk7upvwO4z96ArqGB10njHYuoWalPPM5cR3Bex3+VjWGDj+CmWYDEzLousU12hLIuz8FP4cpPbDJIKqWCy5vkCkYh293KAvlGmSsMAnhw8tiEJsf0cL8xRX13ssXkML8L9rKIPo41JYxZTa4DdS5S9axsqqvBDcwjqhlEnwPG0N0pdyC0d7bYFFwJHQfKChcXCTKFfOXi/n/3cRKLTXopBoIcf1FgOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWTrx1XveTwPMGC+dPO6uSDMEuIBGZFzB7kiEB9HQuI=;
 b=RRE9iBIotfvDbHUNDJHYPKfjs0ECg4Q0vVtDEUgYYvXEtmKbaNLrNNMIroF+fEl+33I0WgklgNCHFjh/yJxFk6aDCn8+fpOnGk5vVegX1wfIQVAtbhcQa7lkPJ+BCS2qs/OSO6HuyimswAvym40SGGDNqRD9PAtVDzwdA81gdvJSLr8sZJDPIFAVe8kINwbZSyP3j99Je3jy1Ly9c/GGRu8kM1cT5qE9BuFg3+Lmmzqb1L+USg54ZJKhoTK4rP7T6XOWDjUw33TvKEBtIhK/voC8qbuhsoByC75mzOSg7SdlXf4HeW3x2BrLV9sirnSu3Sv9MzFcUERcJ+uJJBnMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWTrx1XveTwPMGC+dPO6uSDMEuIBGZFzB7kiEB9HQuI=;
 b=W5TThx0f45EcHsHTxZIXkoo/LcsyA+G4lslwnpQ5lL8T9TIGSU6w7P5k3noSGrKWaKKQIy/deajF//WWYlUPvkPA2TdqRlI07ZUN492LtYfertfoR0t/CNKjO23RRTFgoj23Pgcl2b/gYAD2MtS8GdP0Fs+ERXOFNJwxYv4koOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 14:04:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 14:04:43 +0000
Message-ID: <531dda40-5d7a-40f7-9c07-fafc84b57a4d@amd.com>
Date: Wed, 12 Aug 2026 16:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ALSA: hda: allow direct complete with a powered-off
 GPU
To: Andre Eikmeyer <dev@deq.rocks>, platform-driver-x86@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-sound@vger.kernel.org
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-4-dev@deq.rocks>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260812122206.193680-4-dev@deq.rocks>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 218ada3e-63a9-420a-4dd8-08def87aa8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: BaKa+ijeCZEeHdLEgABMZDH9HpBgCXSE/Im4fUaIsKRiKTBxpb5nZYGLMUNQyNzUwlhNIUsLXI7MQC9dZxRAmQCTB37hUAlTuxjvwjQWszVEZ+POs5okUJaELPw8b7h9XgBakg/9+VP/6OIsvGSoKEcqraKso9ayojola7o6rKkqfXNty2FgEpo+s3+TJdGF66CBuZdmgAPUi4UDrEf6PeIFwMj1pnn7Cupcky913mLGnbrUJNkJmQ5HtRUniJ69AKAe/3aoH0HoRcIsm8NNK+2OcZr2fzBBGQnl50GVmJ+xwxlNosTkliXtai2W35gEMFxYruBCys5UqhYCOXrYi3pUBHDQnsGMGmNVwjMSKlYWb1YJWj1KuFWKKDGxGADEeKYx7ZBLMHbayreWi7nQUgRrcbqd9fL3AFOZsQcig7/lTUOXl7lQ4oFZnoR/m0qZZQreOrvnw9WMFnXF80rBvM8bx98UY29DweVjgSQV7hTlINg5aXEwFj5HKb6MXxrMNniYwED3+yc+xZ+AzN9gO0tlKyHC9pMv0F5O/ULZA3KkEtWsMusTIUMzz6vQSmIM3AtpDdfFSRZ9HEF7BUrcyTPz/nsXinhLqTK9BPFYHlTCiV58Y5dfL4PrORhPBmhu2o2Qt8hP5ZHWArscaDETsit5FjBkYnRku4gRKDj8/fQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJnQ1ZaelpsaHlOZlNvM1l0QlF1K0tvNEVRREx0RzU4amdkemJFdnMxY2hG?=
 =?utf-8?B?R0k5alVHOHR3eXVuRFhnSlBDSndsa3pHL0dpMTNjR2lvUWp3endSczhGaHZI?=
 =?utf-8?B?Uzd6T3VGV3FodG1rc1E0YXRYWmtTVW9OeVFRTDFTTEFnaGpSOTR6TmRLSmhq?=
 =?utf-8?B?NW5jUUJwUkcvR3h1em9sallJR3p2Zko2RExSZ3B5NzdlRDVSVmtXQXlxeEZk?=
 =?utf-8?B?OFhBV3lWd1BJTHNNbnQ2VWRSWFRyRExpalVCYlVrYW0zaFNCdlRCUlFvWjFw?=
 =?utf-8?B?WmRDYXczU3ZxU3lPKytyOTU3SU10cWZub0UrdWRKMGhWZ00weGRmdzNMSlJy?=
 =?utf-8?B?U2Joc052RzhxTXQ1eEZOL2JHNUZpOU5aeTBYTlgrT2NFSlh0QzAvM1draWVG?=
 =?utf-8?B?THRoYnBYN1QxQU53NzluaUN0M25QRGN4U3d1d29GT1FHNEVSclZtWlZUaG81?=
 =?utf-8?B?c09vZlVNL1pveHNGSWpxRCtzYlpNa0VnL0NjZVc4OHpWOVlqb0orRmtLK2Nt?=
 =?utf-8?B?aVRTeDcybHJTeEp3VFhxajd0b2FSSUdUdm5RYjZ4OFBSNnltalEva1oyTW5m?=
 =?utf-8?B?eFk3ZmFNam9hWVNrZFFxVllqWlVtWStJWG14bkxLZnR6MUdyTSsxYkR5OUY4?=
 =?utf-8?B?OFgwK2VVbzNqRFdFVFdRMjdNOFZjUjZHV1AvL0h6aGh1b1BxZ2pMcTJKVHFC?=
 =?utf-8?B?UUdyaDNaazFNc3NuRnlzcTRvTzRoZ3NxYUllS1k3UHQ1blJsWjc5RHFhVmdY?=
 =?utf-8?B?d3RQSVdvTTBScDl2bVRUT3ovcG5Uc0xWdzZvTlpPendieDdZWitwYWQ5dzVG?=
 =?utf-8?B?ZCtoUDRUWEFjcEtBVXR2S0U0RkFHZ3RJV29yNm1oSXBCcUsyS2tydWxlMFlL?=
 =?utf-8?B?NzRFYmFEWkpCWW1oUzF1eGZHLzNTank1cGhOeXdwOWJYTTN5Rzl1VGlHbHA0?=
 =?utf-8?B?blh0WHNCVENENUV0MGhWSFNzTUxManpzanNuZzlHSWx1ODdMVXRzME1ySkNZ?=
 =?utf-8?B?NnNwN1p6ME9pSXBvU1JNY09FWnV1Z3VFamRuT082am9KQk5UTHp5YkVPVHE3?=
 =?utf-8?B?WlVjUjRuaG0xYTBrR1BYbHBndXd4dmVUUVJyQnVTajloM204VnBrOE5UWC9Q?=
 =?utf-8?B?NXFYeWxSYVA4ZGxzZkRWZE5kYkFrMGV2YnlvcElESitIczd5TTdCYnpoNGFJ?=
 =?utf-8?B?NURDckJHUzQxVnBsQS94a2NyVXhCR0NRUlJRaEJXck9QRnAxWGt2MzJEM3M5?=
 =?utf-8?B?VFBoNjRzaUJnZm5GQndvZ1VwU1FINmFKa0k5aHIwazJXR3BMYzEzRHVPNXcw?=
 =?utf-8?B?ME1Rd1RVTnF5VTJ1bnVhcndtdEtqeTREaVFYZ0JidUwwWjhhSEMyZzJ2aXVk?=
 =?utf-8?B?a2VWeFhJQzZvY2pTTEVXZHlKTVIwYnRkYVoyR2NWVW4vMGp0bXFYWDdFNStq?=
 =?utf-8?B?K1JXdkZHNGJFUlk5Q2RLVXQrUUtwbnluNXdNVEY0Ymk1N29NZ1lNSFJIdFRs?=
 =?utf-8?B?MDRocHppT3B2R21GMVBwQVZRNElBYVhNYnZvbk8zU25xOFViZGFGS1JzdUNF?=
 =?utf-8?B?aU5xZzFHOExHMGg4Y0dzUE5QTlhaRFVTZ2J0NzFJTW0wS0dqU2N4aXVlNEFL?=
 =?utf-8?B?ZkI2cXVoNkhlU3JqK0p4ZklrMnVBME5UVmkwZkR3M3hNN3dqbTFoZmlJTGFN?=
 =?utf-8?B?QjhBTmJJZW1pdzJVeUo1L1pMMVhINFRkVzhnZHUzMVpCWjJWZGNERjFhRXl6?=
 =?utf-8?B?dVQ2cXJiNWFKeTFVMDNoMWJiWnQrU2Z5TDM4N1FRYU9mZ2g2Vm1kY0FFakZr?=
 =?utf-8?B?NnEydGpLYkhjMmVrR1AwSENSMUI2Zk1UU0pvbm5oSXJFTmNQaUI2Y3paOWZM?=
 =?utf-8?B?SGVXa2RRVXJaamEwZGhuM0Zyem5oZjdLYzY3OWZXOU5wdXNqVllqeG5xdXNW?=
 =?utf-8?B?WXJuamp5US8vWjVhWTNMWGJqb3lQR25WWVlvVWI2T3BWZWMyTWFrWWE1U0gv?=
 =?utf-8?B?Wi9FS3BTQXpCcGVycnArSWRtblR0T3Y0ZUIreGcxWktCYmRCU21LWWRWRGc5?=
 =?utf-8?B?M1JTelNhdGlNTUNJSWpaVnlWekt0RXdXeng5U01qeFRsU0g1bHV2VTlOdzFX?=
 =?utf-8?B?WTkwc1JraEl5U3hsNDlOV1JzbWFMenlxQ1QxWlF0Q3RmUlREUVB3WUg3UVZi?=
 =?utf-8?B?MkdlNlUvZVc1L1JQb3NHaHM4Vy9nYlNWYzFCdU03K1JqYjA5OGxxazFsVzFK?=
 =?utf-8?B?bXlYSUIwcWVUS09LSTBqOEVPd0tHRVVMQUt3Q01qb1B0TkMzdUVrclNmNjRV?=
 =?utf-8?Q?AACoRTPzSAkAMWFXHN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218ada3e-63a9-420a-4dd8-08def87aa8a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:04:43.4044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehUWWqvtMpZ+aPhVJnX0tV+Q9/oe7xeS1Ew6ZqM3qQQcnzhlXhhlwQSKmBWdEjMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

On 8/12/26 14:22, Andre Eikmeyer wrote:
> Hello everyone,
> 
> The HDA controller normally needs different WAKEEN settings for runtime and
> system suspend, so azx_prepare() prevents direct complete. For a switcheroo
> audio client whose bound GPU is already runtime suspended and switched off,
> however, the controller is physically inaccessible and cannot signal wake
> events.
> 
> Resuming the HDA function during system suspend also acquires its runtime
> PM supplier. This powers the discrete GPU back on only to suspend it again
> and can expose failures while restoring an otherwise unused GPU.
> 
> Direct complete is now allowed when the bound VGA device is both runtime
> suspended and reported off by vga_switcheroo. Active GPUs and HDA
> controllers without a switcheroo binding retain the existing WAKEEN
> transition.
> 
> This was tested as part of the MacBookPro15,1 hybrid graphics series on
> both the 2018 and 2019 revisions. The discrete GPU remains powered off
> across system suspend when it is unused, and suspend and resume complete
> successfully.
> 
> Thank you for your time and consideration.

That sounds reasonable to me, but I'm definitely not an expert for that kind of stuff.

Adding Harry and Leo from our display team on CC as well since that HDA audio stuff falls into their responsibilities as well, please make sure to CC them on future revisions of this patch set.

I'm not sure that even applies to AMD GPUs but if I strongly suggest to run this patch through our display CI, just to make sure that there is no regression on suspend/resume.

Thanks,
Christian.

> 
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  sound/hda/controllers/intel.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 28c55c5..20ddcc5 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -334,6 +334,7 @@ enum {
>  #ifdef SUPPORT_VGA_SWITCHEROO
>  #define use_vga_switcheroo(chip)	((chip)->use_vga_switcheroo)
>  #define needs_eld_notify_link(chip)	((chip)->bus.keep_power)
> +static struct pci_dev *get_bound_vga(struct pci_dev *pci);
>  #else
>  #define use_vga_switcheroo(chip)	0
>  #define needs_eld_notify_link(chip)	false
> @@ -1016,6 +1017,28 @@ static void __azx_runtime_resume(struct azx *chip)
>  		display_power(chip, false);
>  }
>  
> +static bool azx_vga_is_powered_off(struct azx *chip)
> +{
> +#ifdef SUPPORT_VGA_SWITCHEROO
> +	struct pci_dev *pci;
> +	bool powered_off = false;
> +
> +	if (!use_vga_switcheroo(container_of(chip, struct hda_intel, chip)))
> +		return false;
> +
> +	pci = get_bound_vga(chip->pci);
> +	if (pci) {
> +		powered_off = pm_runtime_suspended(&pci->dev) &&
> +			vga_switcheroo_get_client_state(pci) == VGA_SWITCHEROO_OFF;
> +		pci_dev_put(pci);
> +	}
> +
> +	return powered_off;
> +#else
> +	return false;
> +#endif
> +}
> +
>  static int azx_prepare(struct device *dev)
>  {
>  	struct snd_card *card = dev_get_drvdata(dev);
> @@ -1025,6 +1048,10 @@ static int azx_prepare(struct device *dev)
>  		return 0;
>  
>  	chip = card->private_data;
> +	/* A powered-off dGPU cannot signal HDA wake events. */
> +	if (azx_vga_is_powered_off(chip))
> +		return 1;
> +
>  	chip->pm_prepared = 1;
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
>  
> @@ -1183,8 +1210,6 @@ static const struct dev_pm_ops azx_pm = {
>  static int azx_probe_continue(struct azx *chip);
>  
>  #ifdef SUPPORT_VGA_SWITCHEROO
> -static struct pci_dev *get_bound_vga(struct pci_dev *pci);
> -
>  static void azx_vs_set_state(struct pci_dev *pci,
>  			     enum vga_switcheroo_state state)
>  {

