Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5CDCCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DD710E32A;
	Fri, 16 Oct 2026 15:50:56 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DC010E30A;
 Fri, 16 Oct 2026 15:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYgmGTyK3bN4SX3HfmU8vwz+WdxaXMLeDt7hnGmKXi8x3LuK1DTAjTykWhapsXW8ilucVBJU82pZwF4Hst4b0t9AnbTFcObid+D02VIv7gzIt2jKA0cN7l3IU2xV+WU6KZaERjAiu0fPD7/dgK5b4izggatsqWdmT6N5c0shQTN8I5O+/IFtoa+M5CEemdMlg5UopFL87cwyPPsp4el07FnDgBFMh58Cn2hTaLgRm5MJm7iqClIVs+bGJFRy5cQIwQchlElX9BHv65txLZSsgZOv4VkCfOppL3FnxXU9G51lDsFaEIuF1WYkrNQ2g4MMki1CfamIQfTgvu9xImB9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Go7PBfe2IP7mVDxKWo3ia16BRD/Qkb/51aga624YI=;
 b=SQD7puGVzQkJJZaU4rIBFTADb0QbTyzcwt8wWVBFG9boZEUS3GK/1UvdgKyo+4Nga9yhdCmNSz6tXQ8f8FYfIn/tnxLCP3HRslfpXRz26GkD/JkDOlC/317O3VbeMLMEenQqpsyMuf+rMDDIqH/nynpCZbjO/kiM3kUL0mENvedD/4GWeYVUGD3F4qmlWL8GwgrojgR6OHJUXi6aie17HRGgxmF14wZgUPjmJJlx3RE45PCd0gtYzj8e3AHKRcnOjMa6fH55CEw+09lRhmig3natlwWC+pAyIQlBZOsw9Fa1JN+kMzBOSfnaQMmogDYC5I7xQJU+Bv94bAidGhcpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Go7PBfe2IP7mVDxKWo3ia16BRD/Qkb/51aga624YI=;
 b=aTsNYcUFqpw3CfT+FZ4hcTZvZ4DacSE+39fPgtYduHmzxRFHltBykPoct5y24TG1tqIMo9p339FWqB0TbalHz1zPNMf/H8bxAz5+U3vpJfVT8vVR/qHEzSeA+H/RIYM8ntLiGilhAM1s8HYqt8I5gicf4YcjE8gFrW+FH+AWoy0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:50:46 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:50:45 +0000
Message-ID: <f4dcee55-8cc6-4287-a25a-1ace385f092b@amd.com>
Date: Fri, 16 Oct 2026 09:50:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use separate iterator for preferred mode
 lookup
To: Yibiao Li <biaobiao2233@gmail.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e89447-7272-4c44-16ac-08df2b9d3dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ikLJhdSdfjTKGFKw/TV2cZ5fGuqZRNASphhFnHHS3zkIU6zhNzG6DJVQH6ntYFdfk4xfA/8k4UL9Q7zHx1sd5vduYuaLvu1YNm14z/bmoyg4MzEy86/DBlU8mwbTPROHW3eOEXSypIfpxUjosCRq5zh5Cr7pnWLd4TsJzgFpZy2V+pcFv+V6nFzrZlwBdqQqKUyslt6Tzv6FXZaEEonmAVUbiBE+uCIrXpb+EnLZYEpktNSsXq0P8aS5+D/1ldB6iTjH+jqQoTmD6n9gS6VfmiUjo6J+oWuASjGJFSoDUpm05AARyyfIuBa/DPk195rHCUw6lOa4qgOv1sxwOpd/ic6syIy3YXN6WBS+ZjEExMOLqpR02f0KTC/WKQzT3/BcuHpRlk4BFHFRb8u6KNKSSLmRjDNTZNdhpXbjObRsvywrSPmmPTWrHhtyzBRSylwMzPxl5vwYJF0h4FFDlQXbHz3FgFJwBcK/U24Vj3oDVlxqp8MVoC8+r6REtoweXYU86IQNdFiBjF3KUeUAjPv+1RW+Nq+9qc8Z866OUD4kfIE3BL24xII7UnX/6GrdID72zYnCC8CN+F12B7utneazKY3/1mEf2JQa3UoMdqScYpY5N3pEDgO94oYq007wUtpL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdWNmw2SnZiK2wrMXNwR0NzR0svcTZmbVdtTW9RSjZPdDJ3TWZKaFBUUSti?=
 =?utf-8?B?YWt3SGtmbkpleG5XWmFvTURaSWx6bnlxaDZ3RVIrYW0vMXJhYXdCY0hQSlZz?=
 =?utf-8?B?NERnVlRTQkUyZGFFTFdqc3VMQ3FXeExRUXdTaGlNSlU2YWtZNUNIbHF3a1Uv?=
 =?utf-8?B?ckQ5YjArYWh0VEk5UVVtejZqNHYzcG40YlU0ZUVvQTJENVhQdERFVzZtN0N5?=
 =?utf-8?B?RUpMTnUwZk82SytnWlUvT2pxS2hlYkEyTThMODBnTU96RjJXUVBVSS9NbkZS?=
 =?utf-8?B?RGJjWTRTTG56bUtxdkxST0lRZ05CczNwNEQ0RkpVWC9UcmdybjFpT3MzMWND?=
 =?utf-8?B?TlVFTFNWRmIyc2VHQnpKbm1qYWNkZWZIZXVTalVjNHdGUjYyR3VMb3ZaY2tU?=
 =?utf-8?B?SVRyOVAreWloOHBEZTF0T0ZJMWJPMTBBNDJnOHJUaFU5Ty9Ib0twRkx3ZjhF?=
 =?utf-8?B?azlyTEZsRGRKRUhkR2dKRHZCakJXcjhoelhFNFZidlhPYkpleUttVTBnM1kz?=
 =?utf-8?B?bmR6TUYxT2s2Z2dIK05EK1VKMDVLbjJ2SnVjc1B1N3RvbFlxM2Y4L1pURmxU?=
 =?utf-8?B?SUwyUEpLaHBRcmFpWGNJOUNETktBVGVzSWlacTBIc3YxdDM3YTR5aXdZK3BU?=
 =?utf-8?B?WUdCRHYxa3BSd1NUK2g2bXkrTFRLajF0a0V3Y1RzcTNaMUxaYTZMbFRFVU9M?=
 =?utf-8?B?WnlWSFhBV2JZc2FSR2ZxMGxhREVxb1c1TWl6VHZGQWdSUVQ4bk1rVGt4Ykhj?=
 =?utf-8?B?b0thanlobVdJdER2c01xem5DTCtaZkpxQlpSdnljZFZTUFB4UUoySFZ6dGZD?=
 =?utf-8?B?b0YxN1J1NVorRkxjNk1iYndNSkRuQldvZzVETWNnbFRNdWE4QXcrclJ1elRw?=
 =?utf-8?B?WHdVZER2dHRzRFlwZDBadjZ0djJad2MrRUMvdlhlZ1YrM0lzbjlZaGtCTHJq?=
 =?utf-8?B?RGE2MEdsVHJUcFdTSXVxUjA5T0lBYWxGNXZSZ1hJUWgwaHBVMnJ0WWtaZDVQ?=
 =?utf-8?B?dEM3dnZPcHBEUU0zSXRoR0V0MHJ5OFZ5dWFOTmJBNml5KzdxbnZFam40MERU?=
 =?utf-8?B?SDJhWUJZMFd1WE1qdkFuaTgzSmkyamZYRFY2THBlRkQwbFZGdTBGUUZDYVpQ?=
 =?utf-8?B?UnZtbVF4UklRVHhob1NaSjIvOVQvcDZkbks5NE5GR1RITXZhWitLbklXempj?=
 =?utf-8?B?Tk8xS3NoY2poYnpWbkhOTEcvbXgvWWFkNC9mNkM5b1VablNnckFrZ0V2eVpt?=
 =?utf-8?B?TnZ0blk0OUduK1VyR3dFWEVQaU5HanRiVHZyUWV4ZUwrRVpETnhTbUpvZWxE?=
 =?utf-8?B?MXBtRmxrNHl6ZGZnVXg5L205V0dLaW5ZZ1RkcU1GRng0MVY1bm1CU0hQT0Zj?=
 =?utf-8?B?cFRpYlVvdk5SVGRNbVBWK043b0FCWUIyNEZ4VTRhWnB5SjNVTDV5bzNWSWNH?=
 =?utf-8?B?RVZDdVVhZ3VMQWlqUVlndHVHalo4NDhZUGxuaFFqcmNDSEw2WWFkMW4xRkxt?=
 =?utf-8?B?eThIOXVLbm9qcFlBTVdtcG90Zm5KcVI3aFovNEpEalhGaEdwVWtoWGxSSENV?=
 =?utf-8?B?MWgxaXNyOVdDbDJjVXhWTWVheWZyQlZ1aERmSkVDWHpTek43aTZ2TVVRN3Fv?=
 =?utf-8?B?K3BXdmZGUnNVSithbi84T3dlYk0zN3dKeDlwT0RXYkY0R3ozMTVvd2QwZWFR?=
 =?utf-8?B?SDFCNVp4bTY0amhoZnF2VEJMZUxkRC9JSFhuTXU3N0ExS1hjM2VjQUdHakJp?=
 =?utf-8?B?cDRiaDM3YXlrUjQzQVkwMW8zd0E1UWZCazQ0SkxKK1VFbGFaSUtGdDI5c1g1?=
 =?utf-8?B?QTNtUGtxQzZTUDJ0NFJZa3dpQjlVbC96cEs0aUhkMkNVTDA2ZUxJbldnUnZU?=
 =?utf-8?B?T2ZhVXRZTG5lYXZpdi9Kem93Z1JjbjlscWgrUTNoc2o0TEpwaFlnZ2ZrdlZz?=
 =?utf-8?B?cXFuK2o3WUszZWYxVEl4Sjh2WUxOeWs0aEFUb2hieVZ6MjBJTVpqK2x2aUpl?=
 =?utf-8?B?UlZVa2xvbjR3dlpMSVRDUXNqekFzcDNHbnJYRjRSWFg5R0w2ZFY0UUR5T01P?=
 =?utf-8?B?OXJrOHc1aE83aWtHZkIxRmdpajRhTHBnRU05b09UaWRxd3FHUDM3cmVuL3BC?=
 =?utf-8?B?TVp0L0x1MHZLUTgzaGpncy84VlBldDliNDZOQzhiMmlrc256WEZ5bzZnUXR2?=
 =?utf-8?B?dFZDTEEwbStWNG92eVdYOHI3bElhaFZ5SlNOMVBIdUZRWmtmZE5JbXRlS1NV?=
 =?utf-8?B?djI2WDFPdjgxR0ZUdGI4QXFtVXdIczNjQ0xobGhJM2liRG1tdFBFdjZuRFph?=
 =?utf-8?Q?00an9bbHqIWD+0mtMX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e89447-7272-4c44-16ac-08df2b9d3dc9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:50:45.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN6XHtTYJ9An+I1Z1j42v9Cm6B0YnMpw5CcbLAUx9sLSU07HIAu6T6yqDfnaM4rqg/JPAFO2Ak092Y3Ih8B4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/7/26 23:17, Yibiao Li wrote:
> [Some people who received this message don't often get email from biaobiao2233@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Yibiao Li <biaobiao2233@gmail.com>
> 
> create_stream_for_sink() uses preferred_mode both as the list iterator
> and as the selected mode. This triggers a false positive from
> scripts/coccinelle/iterators/use_after_iter.cocci: native_mode_found
> already ensures that an exhausted iterator is replaced before use.
> 
> Use a separate iterator and assign preferred_mode only when a preferred
> entry is found. This keeps the selected mode separate from the iterator
> state and makes native_mode_found unnecessary. Preserve the fallback to
> the first entry, or NULL when the list is empty.
> 
> No functional change intended.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202609190901.yKTzhsGz-lkp@intel.com/
> Assisted-by: LLM coccinelle
> Signed-off-by: Yibiao Li <biaobiao2233@gmail.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index d386bb1475..ceea8fe481 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1453,12 +1453,12 @@ create_stream_for_sink(struct drm_connector *connector,
>          struct drm_device *dev = connector->dev;
>          struct amdgpu_dm_connector *aconnector = NULL;
>          struct drm_display_mode *preferred_mode = NULL;
> +       struct drm_display_mode *connector_mode;
>          const struct drm_connector_state *con_state = &dm_state->base;
>          struct dc_stream_state *stream = NULL;
>          struct drm_display_mode mode;
>          struct drm_display_mode saved_mode;
>          struct drm_display_mode *freesync_mode = NULL;
> -       bool native_mode_found = false;
>          bool recalculate_timing = false;
>          bool scale = dm_state->scaling != RMX_OFF;
>          int mode_refresh;
> @@ -1509,14 +1509,14 @@ create_stream_for_sink(struct drm_connector *connector,
>          stream->timing.flags.LTE_340MCSC_SCRAMBLE =
>                  connector->display_info.hdmi.scdc.scrambling.low_rates;
> 
> -       list_for_each_entry(preferred_mode, &connector->modes, head) {
> +       list_for_each_entry(connector_mode, &connector->modes, head) {
>                  /* Search for preferred mode */
> -               if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
> -                       native_mode_found = true;
> +               if (connector_mode->type & DRM_MODE_TYPE_PREFERRED) {
> +                       preferred_mode = connector_mode;
>                          break;
>                  }
>          }
> -       if (!native_mode_found)
> +       if (!preferred_mode)
>                  preferred_mode = list_first_entry_or_null(
>                                  &connector->modes,
>                                  struct drm_display_mode,
> --
> 2.43.0

