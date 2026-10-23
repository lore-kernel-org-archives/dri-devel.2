Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C54606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BZknUaE9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5F310E6D0;
	Fri, 23 Oct 2026 18:26:45 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E44110E50A;
 Fri, 23 Oct 2026 18:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsykA2iR6eSDRK0+PBa7v2m5WXyVm3UL9sdfT0JfLXBuhL61Mg+hFYDzbQi7aXDJhu8F6NHzkMrXNRGtmcagzXeNNxwlu4YFrYhSKd+2Nt4CcVBwMsUGL1yFL4lFopSQc6VboqvJDhZ+LyWo4Gl7Qt2Gq8bE1rxvtG3H/JCM6x+ACpYixgpVh1BwrZHAYrcAjVyPeJ6JiVCKz7MQhIu6DO8IxoBz1kmClYgIEtDkC+4VTobUlHzjjGi65oIx+mwrLgB2cJF3BOvk9ubKY6xP78ifD705MErrYAvhL4CNR0hv8mLbGds+FYwDJtGsupUy4Vye0/31BHbO3ha3aJP5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq0Q6xx4U3IJnSIsof3zoEc10hR/y9i3Dq6P/zbAl4s=;
 b=JExjSa32zMvY4GiKnAhDeSgLFuMUtdLWhUvzGJV4poXwT21NCvoL3+/IELrGZch4JLu+EO2BhgAFnvr0VIc6Px8FU3oDCOP9BNqNP00/23NIWq+S0Cv0soZ78SRDjhbrcxQLkttOCI1iOPX2JFWooh+Au8Goxo8XqOYSJSAUfcvetQcTCtNbtwKJAsczL/PsT/Ll/tk2EgYMlvL/VBbJ2snDpkF+P0i9yZCgyvhu82t+gzcJZnLD5bx4WM32KZgQiIYhxgB1hDu19P1+VWKkeEdvwWejXtdGB9BGuug7s2aoOhXmZKorvgSZdf0pKNQQeDi8Szw02xXoM/b7O7aNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq0Q6xx4U3IJnSIsof3zoEc10hR/y9i3Dq6P/zbAl4s=;
 b=BZknUaE9Ag9nUOTkNZG6TAwwHG8XeDo1pVnwWmI8TM+RFCeGyAKO7FXN0NLy8asGVYI/4lpONVX9kc2I1pIJo8HiZcs6ZIHYnHpIL48BV7J+z6UqAylyo5JkFJe6EIzUjnT91ktSkLyioPPzwLOsmzJa0vAYTAcbkPDfnutbXP4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.17; Fri, 23 Oct
 2026 18:26:32 +0000
Received: from SJ2PR12MB9189.namprd12.prod.outlook.com
 ([fe80::7923:8cd0:a2d8:ac7e]) by SJ2PR12MB9189.namprd12.prod.outlook.com
 ([fe80::7923:8cd0:a2d8:ac7e%5]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 18:26:31 +0000
Message-ID: <74c73b6f-a6b3-4652-8da1-b5c46ae58809@amd.com>
Date: Sat, 24 Oct 2026 02:26:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Fall back to the native mode, not
 the first, on eDP/LVDS
To: Hugo Sales <hugo@hsal.es>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com
References: <20261014223041.171317-1-hugo@hsal.es>
 <20261014223041.171317-2-hugo@hsal.es>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261014223041.171317-2-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9189:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cd7054-b856-4c70-d8b4-08df31332959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021135927099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: Ar4tGYBOuh6/Uc/3HRM0aZxo9QUtS+QOVFkS1oSoZcIsJwLnp2a61DMjVmyqiOmAjp9umxMeEQqx44mjQVThbbXxfOO6ZfyCuV9qCcYHCv6MpM4rbW0baXWNH8aoIIZJYdlK38VD7xNHXJ7u0dAE6D/iJcFWwCtqf6y4GbOg6MtXoZf5eaZHchkjH295dd72DRK9Fh+tgNBQhCgO4rEVhBS7b7o3Vjoea1RdPNvD60IdwjxRSaJshevPv7ch1teJC7PQrlCGZjMHmCd2i/4WM1Q3AmKLTrQTtIkISk8Mbt5hKFWSK3lOO9jTcjSZycFB13Kv13CPYQwnJCibGS2Hs/TB1OMi4cDEyfSMK0qwckAGOi4H3S/BfQvjKV1gGH6XKWF6E0B9rdZBFHB/Y641Ui7Exz+nc9yAJxPaxP71E4X+i2jA1kbKRnX3tw6KEOEG8Cu3YVsdLbcjPJSl8wkuHjbuzZF89B7w7VuyHJVFApG7lVofrgC3Tzmcnazuan4WdUtBxEki6yNouN0MwSeep3UfGxv1o36VYE8hw1SASzyfe/dN1cyH5f+U7uDkumkgKewEic6YcT1zj8+rnauJUrdLq5pdHUw0W19pCYgVLn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJEYTFoZG9obnFQRVgveSt5NE4vUHNrSUlJY0x0ZjRFc1IzUFBoMzI3VUVn?=
 =?utf-8?B?WlZYSUhVNFFhU0NNSFRWYjFpU1djV1F3YktrV3ZUWDFDSnA1YnllRVdScGlT?=
 =?utf-8?B?T0JySEJxQ09FVURRRmpjd1g4aVBzaEIwNFQwMkV4M3JWZDJycHFpa29nR29Q?=
 =?utf-8?B?UmFFSlBHN1AyeXFSYnNpcDdvNjdTUWJqMG5YYWJMdHI2SVkxNXI4YXFlcUdx?=
 =?utf-8?B?ZHhHYndYUXNYekc0c2Q5TjdBcytyWFVjUklJcHNmbVdyMzE5YXFtUDl0aXpO?=
 =?utf-8?B?OFMyZ0hCMHd4VVBVWlJOUFliS00yODdkOFE0alNubFRTaGk3amNFNitHbDVv?=
 =?utf-8?B?ZGsweFZSNkR1SGx3Ukt4amlYa0ZmSXZjRi80QXF2bFBobVh6UlpxYWRpVWo0?=
 =?utf-8?B?dTlhSzlBQUVaZ2xxT2JSYnVWSEpiZ0REZjd0VzVEODJGOFR5NjBHZ2ZqMk5z?=
 =?utf-8?B?NGZrMFFPUzFLblQ3T3J3dFFNNURiaXQ3RWFrVVlhUitqd0ZLSUMzSnEyNUhZ?=
 =?utf-8?B?dlpkNzl2SjlreHhlVEtYSjRIcVVLbjh6dDVqYWJkSjBiK2FYWmhGSGtvcUtP?=
 =?utf-8?B?eFZ6RXVxZER1cEZVallBK25XSTNNQlZYbHRUbnk5VTNQWjNGQ0IyRGtBMjhn?=
 =?utf-8?B?T2VXUnVvdHhZNUU5aWpFeEkyZjkzWWhkelMrajZaOGlRMW1BZSt0MEs0WlZr?=
 =?utf-8?B?bVg0V2tLeWc2b2V6a0YvL2tXb1pkY1c4bE1JVC9POGZ0OFhIc3QydEp4aEpy?=
 =?utf-8?B?K2YyVkh0TzN6SmIwWVZ2S0dQN2ZoaXhpQVg3YVFNVkN0VjhVOSs5ZENVditu?=
 =?utf-8?B?ME80U2pTVHlsdEVQN3RZSmdiUWtzakxFQ3hwVm1zWlQvRkFaOXVJMnV5eUgr?=
 =?utf-8?B?enhrSk5qUmNYM3U2TndKWXJkZHVpMDVORkFlMXJZSmw0QksyTDdYMmZsbXU4?=
 =?utf-8?B?TmRPNE0rU1hRVjRMajBWSHFxR09KRngyVFY4enhuQlNuV2JSbVduZ3p5bnlv?=
 =?utf-8?B?VEo4NTZHUWpDeFFRNnpKK21tT3hGSjBvdGZhMCtzRkdQZzNYeEF2VnhZeUMy?=
 =?utf-8?B?YzBlOUJFY3IxSnlFeURjZGpSL2FEeTRxaEZLYjJkQ3VMY2IrRkI4SktpbGxh?=
 =?utf-8?B?MkJkZVdobG0rcmw4OWhUY0U4emNmV1JNZ0xPT0sxRDRXNDRiOEdPangrVExy?=
 =?utf-8?B?SzdvWHFnVzhjMXptK2VMSkM3RGd1dXkvUEI3R3paRmVoMHRUcmh1eWxRa3Zk?=
 =?utf-8?B?bVlKbmRLNEhVcklNc0dEUWJVa1c4dTlhRWZqRjlTZTFwTDVPNnVMS2xnZnBv?=
 =?utf-8?B?Q2x3QzRPMFVaUG9GS3J3Q0NzSTFOcFlNMm96UFVlWE1PQXZnZjFGcjJMQWlV?=
 =?utf-8?B?SVd5Tm9MUlVBcXByc0wrRFVadmN4UEwrVjZmN0c1N0xKT3oyZEFic0xpdURk?=
 =?utf-8?B?MmV4UHBycW5td3AyVE9QRkVHRVBnRGVlNzE5bGF0S1BDMFNlb0RSS0N3UnJ0?=
 =?utf-8?B?eTlpcmVxZmR1empjM0hkVHVYWDBybWVUWkpJM1NJbFBMeW1BenpPbkZOejZF?=
 =?utf-8?B?TVdqSTJ3UWxLZnNoSzRWNEdmQnBVS3JrMnkzS0JHMU9kMW95dFZ1VWREVmFO?=
 =?utf-8?B?OW5qWHNrWWNUS0xHaDN4c0ZJMEFCSXJBNjQ0R0JCbTNUQmNINGp5VDQ4dVhN?=
 =?utf-8?B?WXBtdWZTQ0UxS25yVUphcVNYWXpybE9VMXRGaHBiVjNmMUVkWHVsNlpyanhS?=
 =?utf-8?B?Y1RQR3pIZTNrcEh4WStwQ250eERpWnZ2SEhYa2dxR0JBS3dTUHcya3VLSWpD?=
 =?utf-8?B?amRJZ2VUQjVKeDJMVVhDeU96VWZKQk1veUhjRHcrTjdiaTlQR3pqbzFaa2lJ?=
 =?utf-8?B?Wkp3NVFGZWdLVDhmR2ttSVZrLzRwWWJvRlRZTzhENU9uK3VuaHBCQnBDV215?=
 =?utf-8?B?WnZPZTc4UnRiUDRJVHdrc2RGaDhwZnpjenJGbmJhdndBNXRpVSs5M3RMbUsw?=
 =?utf-8?B?MVFjRlZVTXV0ZFl2TUdxVTYwbVpFZXhBTDNud3hJenJEdm1KM2RNT2J0bm9D?=
 =?utf-8?B?MkJhNTFTQTBOdmgvSFZZWmlQZEVZU0lYUHRsQU56NmVzVmlMTERvUVNHWkli?=
 =?utf-8?B?NDRyb2Z2R3NJMjhxTm04U1FyblUySnBBQW5WalhQejQyZ2t3Y0lrc2g1akla?=
 =?utf-8?B?S3ZXMnk4RFdrYTRNOExFdlRNN1dueWxJZ0VmWUhzLzJESHNiK2wzd2xhTmRH?=
 =?utf-8?B?ZTlpK0xPbmhJaHUyclZweXUzRFpqRVppeFdFb0drMVpMdS9ma2UxNW10c1hT?=
 =?utf-8?Q?s25mxoTHUUyd/vApd/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd7054-b856-4c70-d8b4-08df31332959
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 18:26:31.8084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMgTSg7PeMAhX/TW4f3OXIkhKX1CEHbz8mWA2B6MXGvvmmycgAAME3pCkBlAmwa/NWrvKgiM5fBAxCwomqoSAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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


On 10/15/2026 6:30 AM, Hugo Sales wrote:
> Currently, create_stream_for_sink() takes the native timing for a scaled
> mode from the preferred mode in connector->modes. After fbdev emulation
> probes with size limits below the native resolution, as it does when
> video= sets a smaller mode, that mode is no longer in the list
>
> If that probe is the last one before a suspend, for example after an
> HDMI hotplug, the resume finds no preferred mode, and the panel is
> driven with the scaled mode's timing instead of its own
>
> amdgpu_dm_get_native_mode() copies the preferred mode to the encoder on
> every probe, before the size limits apply. Fall back to that copy when
> connector->modes has no preferred mode. Limit this to eDP and LVDS,
> where amdgpu turns scaling on by itself. On other connectors mode_valid
> can also leave the preferred mode out, and then the first valid mode is
> the right fallback
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5983
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Hugo Sales <hugo@hsal.es>

Hi Hugo,

Thanks for the patch and the detailed analysis.
This no longer applies to the current amd-staging-drm-next. It
conflicts with commit 3299935e65c0 ("drm/amd/display: Use separate
iterator for preferred mode lookup"), which landed after the tree you
based this on. That commit removed native_mode_found from
create_stream_for_sink() and now checks preferred_mode directly:

     if (!preferred_mode)
         preferred_mode = list_first_entry_or_null(...);

Could you rebase the series onto the latest amd-staging-drm-next and
send a v2? The change should be mechanical: test !preferred_mode
instead of !native_mode_found, and drop the native_mode_found = true
assignment. The logic stays the same. Patch 2/2 still applies cleanly.
Also, the dm_test_fs_caps_hdmi_vsdb and dm_test_fs_caps_pcon_whitelist
failures you mentioned in the cover letter were fixed by commit
5ac0b4dd2a1f ("drm/amd/display: Fix FreeSync caps tests after common
EDID VSDB switch"). With the series rebased that way, the whole
amdgpu_dm_connector KUnit suite passes on our side, including your new
tests.


Thanks,
Tom

> ---
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 428a5f937..a1dc3e287 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -257,6 +257,8 @@ STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
>   EXPORT_IF_KUNIT(update_subconnector_property);
>
>   STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
> +STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(
> +       struct drm_connector *connector);
>
>   STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
>   {
> @@ -1470,6 +1472,7 @@ create_stream_for_sink(struct drm_connector *connector,
>          struct dc_stream_state *stream = NULL;
>          struct drm_display_mode mode;
>          struct drm_display_mode saved_mode;
> +       struct drm_display_mode native_mode;
>          struct drm_display_mode *freesync_mode = NULL;
>          bool native_mode_found = false;
>          bool recalculate_timing = false;
> @@ -1529,6 +1532,31 @@ create_stream_for_sink(struct drm_connector *connector,
>                          break;
>                  }
>          }
> +
> +       /*
> +        * After a probe with size limits smaller than the preferred mode,
> +        * connector->modes no longer has that mode, and the first mode left
> +        * would become the stream timing. fbdev emulation probes with limits
> +        * that video= can set below the native size. The encoder has a copy of
> +        * the preferred mode from amdgpu_dm_get_native_mode(), made on every
> +        * probe before the limits apply, so use that copy. Only do this for eDP
> +        * and LVDS panels, which take only their native timing. On other
> +        * connectors mode_valid can also reject the preferred mode, and then
> +        * the first valid mode is the right one
> +        */
> +       if (!native_mode_found && aconnector && !aconnector->mst_root && aconnector->drm_edid &&
> +           (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
> +            connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
> +               struct drm_encoder *encoder = amdgpu_dm_connector_to_encoder(connector);
> +
> +               if (encoder && to_amdgpu_encoder(encoder)->native_mode.clock) {
> +                       drm_mode_copy(&native_mode, &to_amdgpu_encoder(encoder)->native_mode);
> +                       drm_mode_set_crtcinfo(&native_mode, CRTC_INTERLACE_HALVE_V);
> +                       preferred_mode = &native_mode;
> +                       native_mode_found = true;
> +               }
> +       }
> +
>          if (!native_mode_found)
>                  preferred_mode = list_first_entry_or_null(
>                                  &connector->modes,
> --
> 2.55.0
>
