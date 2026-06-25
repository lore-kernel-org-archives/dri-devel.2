Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7593CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8174310F38E;
	Thu, 25 Jun 2026 20:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSKDrYqh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAB510F367;
 Thu, 25 Jun 2026 20:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3eJeF4hPi7mQm22/Kg7o3Ix38ttfFWHaLVhGeuLyXstyQ+ZprE2+CVg2FtodYJw6ixvYdonbPevHic5izIZx8mY5gFh+WQNboACdI13zI78QtnWFku+GHbVNNodw7NZan/7tJfG5n820LpNcfw2S8Kiq/reTvrVti0vyXBK1uGn0quZqeNEj7ik+KUg0zUanOSeQTVYGy8yTK4Y6Es1yn40eVxgBADZRLhWcbQaPasoJHw2pEZBxNHdlveNRd/fKcpqWIyFM+s+dis4bGy0v2bzWYuwoXAkyRkDApHbPV8HqFbNvuuO8NN2j6dKkqAwqeqsXwGseHFhUXask56s3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cqzs9DvY6SsDZywC74/ZHTkG8Sn4CRqlS/dCT/IPsaw=;
 b=UhgZx+cbnjzIxWdwSqSCq50va3IF80sM++7XUFRmgxJgHvMPqTWVUBIePHMgyJk2N7SsqFkb8guHT3180sNznf5Pd2ASOHJaPXmDhOtCWqte9NWKyQZU9PuTYNujSYuZLp7aRBscxE36u7YEq+Fl1QLvIK4B7zBqirW1cOkYf7Ex6oBViUj13Ix11zQOqCHWvsmrtMbcn2prAq6SvI9P+fk78i4idyQ0XtNNfg+csRvk/w8+m9/oJiJ597RyIAKAQTSEAOx+IgX4KbzT2WCPNFaJIi6q0awESmDrIFQBd1XNtJ/vV9TGeRYgtZoiD1fqdNqzJHc9ZNPZVFVgSbZOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cqzs9DvY6SsDZywC74/ZHTkG8Sn4CRqlS/dCT/IPsaw=;
 b=PSKDrYqhI/n2gJDW3J4BBGj/8IoSMB86s13/PypBmC8KB5uvtRdnIPMFmYd1QH/nff5NzY6zaXDdFDgchvVDB8HMh2PRql1dGGAOVZEaaEUaNEAPiT8byQKQY6GQyldyg5RmO/0TsCnT4zW5vApT5Vsi4eHrr2+pORpU8Xfnm3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 20:38:32 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 20:38:31 +0000
Message-ID: <b9256d5f-ac08-46cd-ab84-3fc0e6e52b61@amd.com>
Date: Thu, 25 Jun 2026 16:39:03 -0400
User-Agent: Mozilla Thunderbird
From: George Zhang <george.zhang@amd.com>
Subject: Re: [PATCH RFC 1/3] drm/amd/display: quirk malformed CH7218 PCON
 topology
To: stevester.codes@gmail.com, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
Content-Language: en-US
In-Reply-To: <20260620-ch7218-rfc-v1-b4-v1-1-3412debf44b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::27) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb8c834-095b-4525-7ca4-08ded2f9b86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: OXYOeCqf/HaEbnG2WaRaT0veQinDD2adBF4qvuhjm/+QSKkwMXa47Ftg7aTHlYppnzrltihlxV8skIxfWYf4Y+EkYLSVE9YlVOM2Lv0dwZLOOnqCI4dwXp5JGrFeDi0XC3dxnPapSb/l760WoqTgF8ULioU8i1K3jJ7OTO4dFNi7VdOqBOfuiPMRNFGcM3EvcTJWpZ3UsqJOGF6jLbKja9zngSJO5rPI02Q5rJCHT30re4sbl27agbbkuVBgcVtC9sjEGTbd66Mik8AKgBRIIsFsoIfOSJ5Ras/zEgPKUUIZXSumB+1EdtA4UghpaWbHd9BCz+Ucj4jD1lXVoJ+k9RI/YedDKL0LKxzxpnQZaNbSKzEo8LI1k/fgvOGA59tDqfKxSOdbyThnO8R7OBB+i+g2wgg5s2t9mbqpGVbH4JgVuY4Ybh2Fb0y9/tqDahPSgAL96Zi0XssffacyGWCNN7zP7vB/fePnzelVmkwGeLEY090uvNIjJHoCWVSZt25/UQhJWWWgowd/lSScLwMHCbLijmVtW2PPb9meLkpGNuniycMuFWDSpR6TSM3q6VD0nmCGGFDa07PU0D5lD6gOfKm6+tIdyt1RZyUDxPnB7676gxc43Cnc0tqMDdmUPoiZiGojG70gK64E92ummM4g9L6Crd8ZfZma3Mf5P3aDnak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWx6NWplS2dFQXgxTzZ0WkQ2clFSWUFseW5wK2tnSlcwVUU5Y0RCVVRiMGl4?=
 =?utf-8?B?S0hHN05TbFZzQ3ExQXk2MjQ4QVdJZmRmbGMzLzYxa0dnZzBhcGRFVFovcWln?=
 =?utf-8?B?N01wZW03K3d1bjVqSDVyNHpDekFhT2tpTWRDTWVtMU5PdXNUMDZMY3VxODlU?=
 =?utf-8?B?OUpqQnd0bnVJSHV6cHNrTk9WWHlTWHZYNGlwRHZXV01PelM0S1MrMUx0OFRQ?=
 =?utf-8?B?cEZSRzZRaUxYdmt4OUphM3JhL0xDZ1h5WlJEQjBzUTRSTWtqbENaSDZORkoy?=
 =?utf-8?B?NVpKaXhKZ0xXZjZJQ2xwMXlWbDRZWjdOcEtBQWFSOVVxZVVJY203MGc1YVZG?=
 =?utf-8?B?NUpSbVo4VmZ3dDJncGhsZE9uTnpQQ3JuT2svS0lWUXdKcGl3UVBSK3p2NGNU?=
 =?utf-8?B?ZktXb2IxcGxIUXV0dDZ4VTBzRWhqdFlnU203ZE5Nd0c1NGp2OUVHV1lyZm1S?=
 =?utf-8?B?U3p0QW1CalgrQWRHTUVaa25oM1ZiSXFrWk9lNisyUHNJUWJhL3BKK25UUmF0?=
 =?utf-8?B?OGtsTm5MV1gvTFdLOUFWUE5GNXdtRnBJV0xDbTd3Z29QTkVPQklGUVZLRCs2?=
 =?utf-8?B?d1NOM280WlZxNnVxV3RrckppQngzblNHakgwaGhYYUJ1cUtxRGFUZU00V2VD?=
 =?utf-8?B?cFRkR3NxK0RHL080cHl3N25RazZJU2pCME1XRnc1aEkzZGREdlJLbmhRS3BU?=
 =?utf-8?B?Ymhwa2sydExlRnpobE1pQzJNUEU5NC90MC9WUHFXd2p6MWhSQ2JYOG9yMWpz?=
 =?utf-8?B?M2xrcGxOYUlLOXBXZzYvSEZHd204N2tZSTF5My93b04zM0dBRXI2c1BHV1ZY?=
 =?utf-8?B?ZFdZSDA1dFpuZzd5bG01N0p2OEkvWGNIYUkvYlVNYnlaVURKTTdYL3ZDMlRj?=
 =?utf-8?B?OEdPR0RtcHNpSEFteHY2aTBPSVVGMVJ0UXlTaEJJRDV3YWVTUkZuTmYvK25t?=
 =?utf-8?B?WXROTkxGZ2tsbmZGUXJCUGZSR1lKS05mZFdPbXpoNzhXV3VFOWROTms0OEZI?=
 =?utf-8?B?OXpVNWxFVEFTNTlSZDEyb0hCdWtJMGF3SkMzR09heDZpeWk3cXYxS21MSVds?=
 =?utf-8?B?WUdPcHVETlFPaWNFblh4YVk0cXh5NTVRWEtNaXhNZWFRWUQ1UVZ3WTVwTWxx?=
 =?utf-8?B?SmRPTElZanNuKzM5VVFxUTF3SlpGWUFiTmMvVy9OMXJQdGRWWDdRak9wWjJN?=
 =?utf-8?B?VVNOWDJVNjlwS0J3VUF1cDB1a05Fd1VJZ2c1MGw0Nk1nd2szdUtyL3V5SEJX?=
 =?utf-8?B?WmExejk3dU10a2pBbm1XTmRsMWpFK3JoTUxDQ0w1djFZUkMrdFN6UTVyNjNn?=
 =?utf-8?B?V1l6TXZ2UzUwdXFJVWorWnRpRkpJeWVmdGg3bWZqT04zckEvbHlaUWlDZE9D?=
 =?utf-8?B?aWNQc05qS2xuSVYzZ1VsYUFUYUFUVGNMMjIyYXBiMVA3dWFOS2pydGFNYUc0?=
 =?utf-8?B?U2wyanA0UmZUOWMxUzVidUprV0tYRzQwc2dteVk3TXU1SkU1dkVEeTF2M3Rz?=
 =?utf-8?B?eGJLNy9WMkhxTDZqNWl4elpWckZwdTk0Y0dublF1OGdWQ3VWU3hTMngzOXJm?=
 =?utf-8?B?NXFDU3k3QlI4bmZpK0JrSlJQMWFRUzBsU293UkFiMEd3UEh2Y25hMlJGVUJv?=
 =?utf-8?B?aE02YU1rOFJtSkZvMnkvNFdiRVpYM2N5TzdmNkRwN1hHVjgwTjgyeFptYUVn?=
 =?utf-8?B?cnZJaVc4MXNQdnFoWWxQYytMbXJBY2lUN2xGN3hQTkxLWmFRWlNscEtBbkwz?=
 =?utf-8?B?UDlyd29ZK0c3OTU5VWhjMFp6WWhxVjB2L1BIZGt2VTR4UjlTQVRTUGMvNCsz?=
 =?utf-8?B?ZUM5N3FGbHEyTldmb2F5VkNuSzFNVXJlS0Rib1lUYTNKdFM1Nno3TUFoZ2VC?=
 =?utf-8?B?YVpZOHJpQnJ0UFNoSFZxUEhhM284NWVoVU9iTUtOODhSdEt6RmxnV3g3NkFa?=
 =?utf-8?B?YVYxNE5mbHg2dnZYYk1IZzFNdkFkTW4zZ1FTemQ3L0MzRVZaOXpxOFgreC9U?=
 =?utf-8?B?VE5wUTZiSzlJU1FaM2haN2ZBODJBN3RqWU5VVVNqS0NaMDZUWjIvT1NCWThu?=
 =?utf-8?B?UWhoSzBaNExEN0tva0ExRFJvdmcreWMwTVdsVzZwb1BuVGh6WVZadmpOY1hG?=
 =?utf-8?B?RzJCd1lQYmJIakdwNzI5NzZSTXZFeHhIWU9QQ3g5RW5RZmEvSjl1M0R6T0J5?=
 =?utf-8?B?eks0MklTb2twTWt3S2M1MVFKZis2NS93TnJuNUFETm1VaWNVOHh0endjTDhs?=
 =?utf-8?B?aE9qUEFsZjY0QXVTZjlzZ0tXMlg2S3FIV1k3cXFSY2wvbUdvdXdhaGJVaGFl?=
 =?utf-8?B?d2FsejdlU2VveUxKSGlOOUFFQlZmZlNHSGNVZ3FCOGNxdDJyakdwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb8c834-095b-4525-7ca4-08ded2f9b86a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:38:31.8091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCTc2fQguvnOCKHRMwCG5hVU3EatkRNP1FAV72/b9AnN6eu8q6Hqr7kiFpjDIvIHxf/usZsbZQyhMJDQTX7Nbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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



On 6/20/26 12:06, Stephen via B4 Relay wrote:
> From: Stephen <stevester.codes@gmail.com>
> 
> Some Chrontel CH7218 DP-to-HDMI 2.1 adapters expose a branch
> device ID of 0x2b02f0 and branch name CH7218, but report no
> downstream port at DPCD 0x005 and report the detailed downstream
> port at 0x080 as DP.
> 
> This leaves AMDGPU treating the link as non-HDMI and bypasses the
> PCON capability path.
> 
> When this malformed runtime state is detected, classify the link as a
> DP-HDMI converter and restore the documented converter ceilings needed
> by the existing PCON path: 12 bpc, 48 Gbps FRL, and YCbCr passthrough
> capability. This does not program the PCON or synthesize source-control
> FRL state.
> 
> Signed-off-by: Stephen <stevester.codes@gmail.com>

Hi Stephen, thank you for the patch.

What dongle you are observing this issue on? We are interested in 
reproducing the observed bug.

Thanks,
George

> ---
>   .../display/dc/link/protocols/link_dp_capability.c | 47 ++++++++++++++++++++--
>   .../drm/amd/display/include/ddc_service_types.h    |  1 +
>   2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 47abb4066709..c2b48abfe7e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1158,6 +1158,31 @@ static void read_and_intersect_post_frl_lt_status(
>   	}
>   }
>   
> +static bool is_ch7218_pcon(const struct dc_link *link)
> +{
> +	return link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_2B02F0 &&
> +		!memcmp(link->dpcd_caps.branch_dev_name, "CH7218",
> +			sizeof(link->dpcd_caps.branch_dev_name));
> +}
> +
> +static void apply_ch7218_pcon_caps_quirk(struct dc_link *link)
> +{
> +	if (!link->dc->caps.dp_hdmi21_pcon_support)
> +		return;
> +
> +	/*
> +	 * Some CH7218 firmware reports no downstream port, or reports the
> +	 * detailed downstream port as DP, while the device identity and EDID
> +	 * describe a DP-to-HDMI 2.1 PCON. Restore only the documented converter
> +	 * capability ceilings here; do not touch the PCON link state.
> +	 */
> +	link->dpcd_caps.dongle_caps.dp_hdmi_max_bpc = 12;
> +	link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = 48000000;
> +	link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr422_pass_through = true;
> +	link->dpcd_caps.dongle_caps.is_dp_hdmi_ycbcr420_pass_through = true;
> +	link->dpcd_caps.dongle_caps.extendedCapValid = true;
> +}
> +
>   static void get_active_converter_info(
>   	uint8_t data, struct dc_link *link)
>   {
> @@ -1166,10 +1191,19 @@ static void get_active_converter_info(
>   
>   	/* decode converter info*/
>   	if (!ds_port.fields.PORT_PRESENT) {
> -		link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
> +		if (is_ch7218_pcon(link)) {
> +			link->dpcd_caps.is_branch_dev = true;
> +			link->dpcd_caps.dongle_type =
> +				DISPLAY_DONGLE_DP_HDMI_CONVERTER;
> +			link->dpcd_caps.dongle_caps.dongle_type =
> +				link->dpcd_caps.dongle_type;
> +			apply_ch7218_pcon_caps_quirk(link);
> +		} else {
> +			link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
> +			link->dpcd_caps.is_branch_dev = false;
> +		}
>   		set_dongle_type(link->ddc,
>   				link->dpcd_caps.dongle_type);
> -		link->dpcd_caps.is_branch_dev = false;
>   		return;
>   	}
>   
> @@ -1200,7 +1234,14 @@ static void get_active_converter_info(
>   			switch (port_caps->bits.DWN_STRM_PORTX_TYPE) {
>   			/*Handle DP case as DONGLE_NONE*/
>   			case DOWN_STREAM_DETAILED_DP:
> -				link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
> +				link->dpcd_caps.dongle_type = is_ch7218_pcon(link) ?
> +					DISPLAY_DONGLE_DP_HDMI_CONVERTER :
> +					DISPLAY_DONGLE_NONE;
> +				link->dpcd_caps.dongle_caps.dongle_type =
> +					link->dpcd_caps.dongle_type;
> +				if (link->dpcd_caps.dongle_type ==
> +						DISPLAY_DONGLE_DP_HDMI_CONVERTER)
> +					apply_ch7218_pcon_caps_quirk(link);
>   				break;
>   			case DOWN_STREAM_DETAILED_VGA:
>   				link->dpcd_caps.dongle_type =
> diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> index 53210e3aa0e0..4164f8a5ae56 100644
> --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> @@ -37,6 +37,7 @@
>   #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
>   #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
>   #define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
> +#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0
>   #define DP_BRANCH_HW_REV_10 0x10
>   #define DP_BRANCH_HW_REV_20 0x20
>   
> 

