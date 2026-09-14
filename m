Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B875DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BEF10EEB4;
	Mon, 14 Sep 2026 13:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JlNHValb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FE410EEAE;
 Mon, 14 Sep 2026 13:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woaxDdKy8tqba0L8B5xxKw/hO+e77+cQLixHH1me747AKhLtg7wdSpZj6YXmlau89KevEbb2s6YGhBV88ra5FR8UA+jNh11mCcalJ7OoyQmP3wxBo2c7s1jK71SgKojWk/AnfD4d7ouhTEoHQCm1lFIHr1RZxYL9Rq5y33tnQqwaf4KHkufZvn7M015yay/03V83rG5ATy0trKm4ffG5DIddy7pdN5gBdsbWBvk0mlknSfBrUMc5nvIfDk38r+oVjeYAzM7XtYa2wML0a+lccPheglBkWHbsDAX4GgjrRy945IlkJUgRRCH5HVfT7v3H/AK2P5Cw7mq58H6OIctpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdEcU7x8nlYoWxZc47vD5X4FKnBKWR7qjKZGqATAjbE=;
 b=iEkANwLwEBjTnJvSxDXap7Nf8sHrbiBFF5xpBSnzkSTAXQXwwvjucsFMJ6iRK+dIAVdOAcJdVpfnL0ZW89X7hiubYtUbiDsKsU0WLj6InM1BZNPBnTbXyephIPkre6XXGBCKuWPxx3ZFTY6WwSbLCTltuQfGuQUOtmU81u0V6Vy2pSfiqQQAxC7+69Wax1ddLb9ni0A89DQIcARI3ApJesjeHMKqgAuGUebq3iKa5nUjIW+2aIjP57eyFQ4P/EuykCWO9g8V5t5Y3NgIGqhixN7BzYko8AHsSLmQA1k/8GiPK7w3B2wQb8DLZZl0+zmbwmlNI+DPy8n53O0yAEZKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdEcU7x8nlYoWxZc47vD5X4FKnBKWR7qjKZGqATAjbE=;
 b=JlNHValbgs+aLtxNvXkMTTKiVYQR3VH7cpgBQYUEmHwPLc/kNS5ydFkDyJCMmqB3dSpWj55+q2GDbqXclcGRLNQS7P2mWPmura+GLovtdz7a/EVFOCWFKjwUWR4TizrPR7ucGVsRpiqk0dlhT+HaFHJBHbyuYrlqXFHTX1cRNeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:55:23 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:55:23 +0000
Message-ID: <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
Date: Mon, 14 Sep 2026 07:55:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: invalidate DP CEC state on s3 suspend
To: Dan Himebauch <danielhimebauch@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, bhawanpreet.lakha@amd.com, wayne.lin@amd.com,
 george.zhang@amd.com, jerry.zuo@amd.com, chen-yu.chen@amd.com,
 ivan.lipski@amd.com, evg28bur@yandex.ru, Kun.Liu2@amd.com,
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 733bdb9c-0dc3-4ac4-8afe-08df1267d22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Skk2ENUQ9Trkutn/WRnXXthEviX55V/3n4ASC6pcYC7cVu/NPol/7luwasXWVt6XgBu4q3Wg7v3XxMtD0mbGwj7TZP12kOnKAwwZJDP64AzlyiwT8rjxtisWMNmcAeumCW1VQXNCpxyBBPXMhakCooPYzxoqWbor/2/lhibwKr2xP9cTLFPcLJ+MpuqsXXkleoRhcgiCAvflKyf/nHw3iF5T9aJ18X4I/8PmG1o5QVcWz7dMqyVMfrzFHuFrsEqibpXy8RhQ46RFkeF+I8MBgRc2zuImsZijyoj1TXCNwD4jy4W2UHGRtXQRopZ+AHzLy/AfU3+50p0QFTVSGOSUR3rlo0o25NFa+3C5APry9asdNNyquYzeX7wg8zRRjkcJcSSYHQHI54JgTZJ/4quTKnmohOcKHXxzQJPR86H7yDbwjeRJMwvAIYyGpznmztlZYNAwtWwLNS4u2UsduCOWhMvt+z5SURW2D3G6yOgoY9rfVQhFUsh1Q37LJkZXEYoB136x6vrwm3bSdqP5q4DJ7Cv2EpWVBakpkl+gws5Mm/IAmQwR0tGFN7TDuOxSXSu8K8iS6+z95xFpE4wfxJUD2TUrdKmOJYm1hIL+OEFSS2GREI5MNLfNO5oXq5Deu8HVzM7YPwIfiVgXL7oiO7ueHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajV3bXNBam44Q0xNdDRQZ0dTdGcwNEZrbkViMStvWGhGYzRlM1N4RzhoTG5V?=
 =?utf-8?B?T2NkWTJWMEdqclArU3JQSmM0bTFIK0xIVzVpN2VNTTdxY1QyTlpYZzZhSHlE?=
 =?utf-8?B?WW52TnBtLzJyZjM5MXZnSElmRFBnM095RW1kSnRpOUFEb2pxU0x5b0pheFQ1?=
 =?utf-8?B?UlQxcVVIRkl3b2cwTkcwajQrb280LzZYaVUxRy9DZnN3Zmo2MTBsYk5RZnUr?=
 =?utf-8?B?OG8xeFRvbDd3ck1rMGdlcHhVTHJDT0d0RHFKUlE3ZjBUbkQ3OW9NZ0lMLzJl?=
 =?utf-8?B?bzFZREpnUWJNcnppRkFFTFpENWE5WU85ZVpveGw0UnJYSFZHaWlBVG53UWFy?=
 =?utf-8?B?Ym5MclBGeXNvSlptL1pmK3NHK0RlUDRzNFVtb0s2bng4eUZmekxrL0ZDc2s5?=
 =?utf-8?B?NnQvNGE3QUY2ZTBaMld2eWhXaDNBRFdGMDBLemZXM1NFZGpBTkltbDBYUG9H?=
 =?utf-8?B?azBBVGhRY0FYZUJSS2Z3YUdGalM0SWJmbjJwQUNReE9QQXJ0aGRkc3FaYjBF?=
 =?utf-8?B?NEFUdlhwV04rdWVybjgzUHlKcFgxc0xLNG9CSWxXQlUzeGZ3ZUt0WFNpYXd0?=
 =?utf-8?B?YitES0I2d1JYY2NOUEtLQjZDRjhMSWVFY1ZpR0Y4VWNqdjhaMHkxU2FZWHNn?=
 =?utf-8?B?VG1hTXcxcmZvTDVrNnRhUXk1U0dOR1lHY2V1Y3lkK05CZWpFbXQyUnVZcEpU?=
 =?utf-8?B?VXgyOHNKcXpkNXdCNUdIa3FqclR0bDZUYm5pK1JYaGpQYm5RQWZmc2FZNmIx?=
 =?utf-8?B?dDBFZnljcDltMFNSVk0xNk1RSGcwVS8wdHFIM1p1Tm9pZ0Fjam1wOWgxdzh5?=
 =?utf-8?B?UVZsRXNvdlRhRXFUYi9ORktJN0U2WHhJTm92bUM2T3NDTnEzeS9zQllpQUlG?=
 =?utf-8?B?b0k2ZUprb05RRC9zYkhCR3hFTGt2MWtiSUN0eWZid1duYjFoekNwNGFYSEFW?=
 =?utf-8?B?MHBNSlBVM3liZ0V4YXB2Q3NidElGVm1reXVEaG5QUkhBMWQxcTV3SUovZXV1?=
 =?utf-8?B?MGJqWTdNOE5IS3lkUTBZd08xKzVNVmsvQldEQlAzaDBIUXVlcStVWHFRMWVR?=
 =?utf-8?B?TjY3T0VRa0I0NjF3RkgyTk80WkR6OElZajUveXRDZ2dMbFIyWW1sSHk4VjJn?=
 =?utf-8?B?OU1zaTBVQXBGeWk3eUtvL3VsdE9KZUpqWUZYWlJBM0FHNGpGSmdPU1BwSUt2?=
 =?utf-8?B?WjhSVWFLbS9uUzJRcE1LSExxNnVmU2dVYzFOeGJlMWQ3RS9PWDVSNzJVeTJo?=
 =?utf-8?B?Tkk4YnpJdXQralErdEx2THNmVTBiTnVzNlg5SGhIYnd6WWRob3NnOFJoMXdU?=
 =?utf-8?B?RVJRWklITGdFdnBsSWZrZ0ZTSTNqNjVWaHIvMm00UVV0OXJsZ0Yvdk9UOEtF?=
 =?utf-8?B?WUFYUGU4QklpWS92Y3E1Z1Zid0NiU2IxUTZObk44S3dHMkNsSFRFUnVvR21L?=
 =?utf-8?B?S1ZNQ1lmUGdITkNwZnhsSy9YNGJVRVlOV2dwWE1Pc2xtQVFVSVZFVm4xak5j?=
 =?utf-8?B?T0hGSC8rNVkvV2NJRkdaWnFRdVJoMUM2MWhNc0NBTXFtQU9mOTZZU0lWclZQ?=
 =?utf-8?B?cDNOemRnN3kxTUxOY0E1bjA5dlRjcnN3czNMNzdMUFFyZjZPTVhDL3BEWmxB?=
 =?utf-8?B?cFdPTExPNndpMHJNanlSOWxGMDNjNlNqR2h2V2N3TkFuNjdyUU1CSExpYnFw?=
 =?utf-8?B?WlhZWXFOcFk5QzRMM0Y4T1RNSFhQMVQ3V3NXRTNTVFJHWThENXMrQTcraEtC?=
 =?utf-8?B?TnIxcHI2eTlFZXFwa2xMbTRYSzZDOXdHKzQ0eUdnaDJzdnp1ZlpOZ1hMZzdV?=
 =?utf-8?B?d0ZaTFIzaEYwOUFvdmt6cVFnbVhGUWlhTytYcVJ6cE5xeEc1MUdZSTdWRjM3?=
 =?utf-8?B?L3RZdmNzbnBYdkYxL1RMdjVpaW5Qc1VXU3lwRU9lWS9tMzlhVE9FeDJUNkZh?=
 =?utf-8?B?S0dkZzVsOVlYVVI5K0lHNnVaV0tZbzZpdXpPMW1XMUxZaVdpWnBaRFRxMnRD?=
 =?utf-8?B?RHBQQWQxSXVDSFRiaE14OU5yZjM4RnFBKzFmYjF2WVBESjB5Z3FLWmsxUDh5?=
 =?utf-8?B?ZkU1Q3FuMG5mZlZud1lWUzB2Rld0MHRsM0V4dDdWTi93OFVBcFg2Nk5NelNo?=
 =?utf-8?B?aitSbFd5Qkllbk40bzVXYkRDc1FMTkNNRVhhczNtbU5DSmZTSTZsMkZtYWxT?=
 =?utf-8?B?cjIrZ2czbC9nRDl3bmlRWisrcmZuUHY4RlQ3Y3U3WFpHTmxQK2Q4dHZpd2RU?=
 =?utf-8?B?WERTZ1AwYUtjcWhNMGMwbE5WQWc5WXBKL05pdXpPb0ZQY3RjWGErN0tUUW9E?=
 =?utf-8?Q?jD/JVqsHCzA5qmmPnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bdb9c-0dc3-4ac4-8afe-08df1267d22f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:55:22.9677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZ2QAuXf4/6cJrHznxc2KZM8R4sx84OIF9iTq4jXPKdwYakTxbDZrmtoVfh6ZOl5sb5YEcrOyjHspp9agvpG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
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

Please run ./scripts/checkpatch.pl patch_file and fix reported errors 
and warnings. Thanks.

On 9/11/26 20:30, Dan Himebauch wrote:
> [You don't often get email from danielhimebauch@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> HTPC setups on Linux with discrete GPUs can opt to use an active DP to
> HDMI adaptor in order to carry CEC over DP AUX, as most GPUs do not
> wire up CEC pin 13.
> 
> Currently under s3 suspend, amdgpu invalidates native HDMI CEC state
> but leaves DP AUX CEC physical address valid, which can leave these
> adapter's CEC states stale across suspend and make wake transmissions
> to fail before adapter is reconfigured.
> 
> This patch allows invalidating the DP AUX CEC physical address during
> suspend for AUX mode connectors. Normal connector detection reattaches
> adaptor using the physical address from EDID.
> 
> Tested on a 9070xt HTPC on steamOS and UGREEN DP to HDMI adapter on
> amd-staging-drm-next at d8ab7636160e20bf6a2ad69cd975f4d63319f1d4 where
> unmodified tree reproduced resume NACK, with this patch, multiple
> cycles succeeded with ImageViewOn and ActiveSource transmission, and
> intended behavior on wake was observed with cecd.
> 
> Assisted-by: LLM
> Signed-off-by: xXJSONDeruloXx <danielhimebauch@gmail.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0b446133edd8..919394778a25 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -372,10 +372,13 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct
> drm_device *ddev, bool suspend)
>    continue;
> 
>    aconnector = to_amdgpu_dm_connector(connector);
> - if (suspend)
> + if (suspend) {
>    hdmi_cec_unset_edid(aconnector);
> - else
> + if (aconnector->dc_link && aconnector->dc_link->aux_mode)
> + drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
> + } else {
>    amdgpu_dm_hdmi_cec_set_edid(aconnector);
> + }
>    }
>    drm_connector_list_iter_end(&conn_iter);
>   }
> --
> 2.50.1 (Apple Git-155)

