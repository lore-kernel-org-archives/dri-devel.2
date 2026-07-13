Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35965C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653DA10EABF;
	Mon, 13 Jul 2026 18:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zj/3jH0F";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606C310EABF;
 Mon, 13 Jul 2026 18:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqDYX0dzYwcS8dCJte2aqhWQgISqiNTORfh3b8ph5yPqhJpKS9WRBP66PDNj/8d7/5aPd4M0ga5VEuecymj6DCriG1Wnbodhc1Kw6iq8ntamPpaaM4TYCmIIQ8OdUKH3Z8VcNbqf7iwZpWVSCTZN+Soh7UwDRPvG5fcn93ykj5FjASLqCFoZ/s7NQcDSJ6B90vq+F4Tuxn2FJ4O2j5vOZwkVnW2pScMJF7/miigpl6DhQutnAfgxu/gXQEyMCtrMtjIwedDqDaXOE/vEaMs6MkJmfa0hsq680+Ua5gieZmfW00oj6pySyBBD4M2n4jxLIebNcXzygppMyDCt/7Lreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAmEhJl6XNyP2iepTYanrGKPdPdpMsDsKIuTDS7xp8E=;
 b=MMtFp47JULAkZTKHcIDh251zN2MIrXAXz7JMVXYAXHzgrjVUwmkFSdFy2GKPPDhnJJVvaC3LxKIf9CPd1xJdH6PfGXY3De3J3sxLiLgtALlsQXFwHa9lT/jlFnhKo302mqOYpP0jtP+dM3ErdQdGjNmIU8awXtR/SbSyTHFRN0t7AKih5eXADINxVqc4yDZer5vRBVMk3zPmGTbQZ6NfQNkfp0z7cxiNNauyhFcU0vArI6l73OO8T02wfxXf5hUEvpOe0oO1jD7ceTxUdzKN/Vg2ioYgFd4iaoZesLgGOXwu+OELyymBPgdvdn5lFpS/1fzlC3Ja50ANcRFfvwufkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAmEhJl6XNyP2iepTYanrGKPdPdpMsDsKIuTDS7xp8E=;
 b=Zj/3jH0FfdxW3YkCs7Fmx5W8reebP7eeG4T8553/qPWXSvpMFaLniycRznrLhQb7BRWaE2CtBEXytGm4Y5nyAODQUnMkBWR3RUHu6qJvecePUdwyZ584cCRiqB5BqnLWCT14vl/cIKcx1zU5FZJXuEvTBtVnibNqJfn+LiWTzoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Mon, 13 Jul
 2026 18:43:08 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:43:08 +0000
Message-ID: <4a73d1f6-cd84-43fe-b10e-288921f501be@amd.com>
Date: Mon, 13 Jul 2026 14:42:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/display: unify HDMI/DVI/DP SST HPD debounce
 delay
To: Ivan Lipski <ivlipski@amd.com>, Nick Haghiri <nick@haghiri.net>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Xaver Hugl <xaver.hugl@kde.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
 <20260709-hpd-debounce-unify-v3-1-d7584920a242@haghiri.net>
 <0a341678-062e-46d4-affc-d56cb7c95ba0@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <0a341678-062e-46d4-affc-d56cb7c95ba0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 074cb90d-f1ee-4095-858a-08dee10e94f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|6133799003|3023799007|22082099003|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fBHB/oLfIBw7AINqmCnUUCR7hxTwYoookeR/Rf7sCbLjsQRDN0zZyMeLp4ZvBWNZ8T9lG+4ltcsy/wotSXSop9afOOkZWyWtzAw618IRA3quVd8aqHBKavB9vslXefpICKv0L9ZD4e3zx0a3DQ8FrCa1rWxI7bkmw24JmdDCGunNQGxVSMawc7nVQ4HTop6VDisKofri56tawUAXIt13vr5cJjTYPb+kYeEhOrGCMz5wQt7DJFknoSzlD+aoYO3630oReuiFx7/K7JaqAyDLEU/UXyBxwqQKJlzuZZkxqnRP0n9Q6KVxbhKaLby8bnJ3X9TPxXu+JvfvwsIcfg43jk+zvjiBZH/rZBc5Ka4PzchoJBaSX6lL6OUsxFG1Li86R9YhBlCRpH6clFIG7FqAAfHYIV72ordxO61MIzAw1CtS0C7hLn85/nt2dehCPxbpf85ehGajqp5o2+BRm9FxUAojDtG9z+B7fZuLNAOdZqDE4mqzToHOoTU/nxQlSGSvLfBPZPsO/bqONgChosfZ6kHzmOEXNnRNWufzxKNswt1kIwCp+02jwqvCI1X9Fd1UItvVTFSqG99Yff+O+0jiuuo8TcaSTOwmBhPsAYXiz0+BIcB7dMYyQRjg1FdY0TZq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(6133799003)(3023799007)(22082099003)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGEyanVPanhEREVPY3IzakMyaExma2hHeTZ0UWJEMHV3TkYyMG9icis4ckU5?=
 =?utf-8?B?OWpYQWNhYlJ0b2l0TzEya0FaQUFJK3BLNVJxc1VlbkdwQ1lxamxkMElSNmJH?=
 =?utf-8?B?akgyOHQ5VFI5aEFsSUxTKzJRd3lDWXhabkE1SUVGTXNyYkhWbGYrWlpqc1Y3?=
 =?utf-8?B?Tzc5N2NZMDlrSzFvS1luT3pnbUI3ckdqK2Y0VnJJV3NveDgya1lwaGVKTkZ0?=
 =?utf-8?B?VWdFVE5yNHhrNjFBWnVOK2QyTm9pd092NlRyZmdlUldUQ2VMYkxFdTN2MFFY?=
 =?utf-8?B?bEpORkY0NjduWjZYVCtrVW4vSVNXbnVuSm51ckZGVnQ5VnBaYnVVbHJ1S21n?=
 =?utf-8?B?SEhkMWsxM250K3hsL2gyZnY4U2ZHeGNSSW94SVRKS0dPR0V6d09QN2UraSta?=
 =?utf-8?B?MTdVeDBlaHlJZXRCYytCOUxyS0tBandFczBvMjVoS0tuK0hXaEZWQ294L3hX?=
 =?utf-8?B?anNQRzgzVnBCTGlxYTBMQUpmTWVkSEZUL05QZTJURHQ3YW42REpRSTE0YUxO?=
 =?utf-8?B?cnNBOWRQTG9uYXdOczhLN0NiWURyaXIrd1liVTFtRWJHMEp6Zyt1TkY1dkx2?=
 =?utf-8?B?U09kOWcrM2xaR05EcDlEbjZVdXU4K1VTemNWbEpESzg0cENOZjVHTFpsV1p1?=
 =?utf-8?B?dFFxR290Q215RVc4VjVNbjVMVTB0eGEwRnpuVWRyalJBWWEvTHRDUXA0QTE4?=
 =?utf-8?B?UW9PUGcwRVlhVlJEdGVkTW5oaVljVnFlSkJ4OHU1OFJoVWozbUd2VG5MU0hl?=
 =?utf-8?B?bU9KREh4TElSc2pMR2QzUjJ6a0dJUTA3c01wR0psc1lBYmQvWHo3M1lqTmhq?=
 =?utf-8?B?Mm05N3RWNk82cy9WRnJpRVJ1ZkV6UE4wR3BRTS9KUjhOZ05ydm5XcDBRTXRU?=
 =?utf-8?B?a1RnQVZIR1dGcW5LcUdnMy9GTGlvb2VHeXRIK1Zhc2NwTlFoT2JpZmVpclZP?=
 =?utf-8?B?OUpMZVNGRldXNW5qbTFOaGdWOTB4clRrR3piMk1KOHo2VnBUcFp5TzE0WGc2?=
 =?utf-8?B?VTE0d0o1N2FnV3JkRGFTRktUamcwbEw5c1owSUFVUzNGOFdhcTM1ZWpSRWVu?=
 =?utf-8?B?akp4SFovUCtZbU9MY1lwQkJXelpVNTcrRDNES0UrOEp5bmxldk82Y3B0UGxp?=
 =?utf-8?B?ZUJTU3RSRXVoZUtlZzluc3VUSk5CU0IwRjQ0UVhmZlVmRVpQRFA0UllLWlZH?=
 =?utf-8?B?cGNkSjVIQjRuWjYyWllRYlExblVWMnQyZWhsdWhsVnVUcjFiTGl4cE1RNytE?=
 =?utf-8?B?WFpzWElIOXVJc2pqZzZjTkV4NkhCN3RkdVdrK1l6SnZaa2NUSmozYmU5S2Yw?=
 =?utf-8?B?b0lZV2VWYTdJT0VlcE9vQWZWeEtic1FEYkk5R3l1N3MzU1hHRHlkZko4SDFL?=
 =?utf-8?B?Y2o2VExoKzM5czUwMTVrZUZxNFFhb1ZRNXlDdmRxRVN5MERwVVhJN2tYaE4x?=
 =?utf-8?B?UnVWN0grMFQyODBEU09jYndIL1dGTlBjdDRUVEZFQnBOY2FFenR2eHY0TlZk?=
 =?utf-8?B?VXZSSUlLOEppN0tSa1NyS09EWnVrcUJVa3F1UU9Nc1F2d1dUcXUzTENsNERt?=
 =?utf-8?B?dEhKQW5uWi82Y3VmanVqRHVCUWVCelprV05xSjFBbzRhckNadDdid05UY0s0?=
 =?utf-8?B?TW1BSjFpV2pSZngzS3dibUk2RkxaUEtrZDgxYUtucFh0R2FLN2FNbmNBWldC?=
 =?utf-8?B?U1VWWFlWQWd5UmFYVXRLaFFnVyt0OWZQT1h0MlJQRFJoQk5XR2dTSngzckRu?=
 =?utf-8?B?UzBEelVsUTRGM1hDdGUwV094bndPV0dwbGwyT2ZmemN2MW8va1J2L0wxZkk3?=
 =?utf-8?B?M29UbU43djBHalNSNTFLVXl3R0ErS2VLT1kvUGlMaGhIRGxoa1pOYitQUkd0?=
 =?utf-8?B?UGY5S3lleEppNEFwY01HQVFqMkhSem5MWUw0Qk9XNVoxcTBGbXhEM1l6Z0pV?=
 =?utf-8?B?dmZzVDhhcU9IRnNXNnZka245UXFob3lMa0ZvKzVtMUR2bTBOdlNia3dMRjBF?=
 =?utf-8?B?aTdrTGhpd3VWRHQ0Y1RWWFRiSnVjRVJKeWxWMWVXd3FqcGlPRGhMdUp4Mm1u?=
 =?utf-8?B?Q2ViYk9xbFczUUVLbzRNSkRSV2oxSWZVdUZkUVl3ZjJYWURhaG1qNzg3VXdy?=
 =?utf-8?B?NUQxUXVlZG9Ucm1WMytBTmhrK3gyWjBBSnNDUkVVNSt2TGVhN3hIeGRDZmVQ?=
 =?utf-8?B?VFYrNWJickFUMVgrVWpJSHBsTGJkWXdWYzdtWkgycWdGV0dkQTFDN1R6R25Q?=
 =?utf-8?B?Y1lWcmVzWVNJN3ZtR2M2N2JtV0h0d2pJN09DcnNoTE9UdmVBa2xrQUQ2UTk2?=
 =?utf-8?B?WlBuRGVyQzc0K0ExTEpXa2pUdklSMWVwWWtmWUE3K29Pa0diSVQvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074cb90d-f1ee-4095-858a-08dee10e94f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:43:08.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 614GAbmmSHYN//DpbsE7IZUZJTgJgKcjTPcmVQ8RCwSL9vqhvzQG5BXU85GFkGa4/GtaJflEmGVD+15z1laFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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



On 2026-07-09 13:30, Ivan Lipski wrote:
> 
> On 7/9/26 10:15, Nick Haghiri wrote:
>> Per review feedback on the DP SST debounce extension, fold
>> hdmi_hpd_debounce_delay_ms and dp_hpd_debounce_delay_ms into a single
>> hpd_debounce_delay_ms module parameter (eDP and MST still excluded),
>> and rename the shared connector fields, work, and cached sink from
>> hdmi_* to generic hpd_*. Also extend eligibility to DVI, which shares
>> the same HPD toggle behavior and has no MST/eDP variants to exclude.
>>
>> Also add an apply_edid_quirks() case for the MSI MPG 274U
>> (drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0)) that enables a
>> 1500ms default debounce delay for that panel, overridable by the
>> module parameter.
>>
>> Signed-off-by: Nick Haghiri <nick@haghiri.net>
>> ---
>> Ivan, generalized to a single hpd_debounce_delay_ms for both HDMI and
>> DP SST as suggested, and added the apply_edid_quirks() case for the
>> MSI MPG 274U (1500ms default, module param still overrides it).
>>
>> Went with replacing hdmi_hpd_debounce_delay_ms rather than keeping a
>> back-compat alias, since it's only a couple cycles old. Shout if you'd
>> rather I keep the alias.
>>
>> Alex, done. debounce_eligible now also checks dc_is_dvi_signal(),
>> reusing the same hpd_debounce_delay_ms param. Updated text and
>> comments to reflect scope now being HDMI, DVI, and DP.
>> ---
>> Changes in v3:
>> - Extend HPD debounce eligibility to DVI (dc_is_dvi_signal()), per Alex
>> - Update comments/docs to reflect HDMI/DVI/DP SST scope
>> - Link to v2: https://patch.msgid.link/20260708-hpd-debounce-unify-v2-1-d214832551b3@haghiri.net
> 
> Hey Nick,
> 
> Thank you very much for this patch.
> 
> My only concern is that a monitor that requires HPD debounce delay on HDMI may not need it when connected via DP, a vice-versa, so I think we should differentiate them.
> 
> I think a proper approach for this would be adding two new integer fields to the dc_panel_patch struct for DP and HDMI each, so a delay in ms could be explicitly set for a specific monitor and specific connector type.
> 
> So in the apply_edid_quirks, we could have something like this in apply_edid_quirk
> 
> /* Workaround for monitors that toggle HPD on entering deep sleep */
>     case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
>         if (!aconnector->hpd_debounce_delay_ms) {
>             drm_dbg_driver(dev, "Enabling HPD debounce on panel id %X\n", panel_id);
>             edid_caps.panel_patch.dp_hpd_debounce_delay_ms =
>                 min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
>         }
>         break;
> 
> That would also require changing logic of determining the `debounce_eligible` as we'd need to check for initialized dp_hpd_debounce_delay_ms && SIGNAL_TYPE_DISPLAY_PORT or (hdmi_hpd_debounce_delay_ms && (HDMI || DVI)).
> 
> sunpeng.li@amd.com, alexander.deucher@amd.com, what do you think?

IMO any EDID quirk for this should apply to a combo of display type + EDID product & manufacturer ID. But I don't think we need separate module parameters for different display types. The module param is global anyways, currently, and would apply to all displays (if I understand this correctly after skimming this work), so it's mostly useful to single-display scenarios and (likely) won't harm multi-display scenarios, other than adding some delays to unplug detection.

Harry

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 26 ++-------
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 18 ++----
>>   .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 29 +++-------
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  8 +++
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 65 +++++++++++-----------
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  2 +-
>>   7 files changed, 64 insertions(+), 87 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index c085a6cc1..af1748984 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -270,8 +270,7 @@ extern int amdgpu_wbrf;
>>   extern int amdgpu_user_queue;
>>   extern int amdgpu_ptl;
>>   -extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
>> -extern uint amdgpu_dp_hpd_debounce_delay_ms;
>> +extern uint amdgpu_hpd_debounce_delay_ms;
>>     #define AMDGPU_SG_THRESHOLD            (256*1024*1024)
>>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS            3000
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 78df53b8c..a82d807f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -245,8 +245,7 @@ int amdgpu_damage_clips = -1; /* auto */
>>   int amdgpu_umsch_mm_fwlog;
>>   int amdgpu_rebar = -1; /* auto */
>>   int amdgpu_user_queue = -1;
>> -uint amdgpu_hdmi_hpd_debounce_delay_ms;
>> -uint amdgpu_dp_hpd_debounce_delay_ms;
>> +uint amdgpu_hpd_debounce_delay_ms;
>>   int amdgpu_ptl = -1; /* auto */
>>     DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>> @@ -1105,25 +1104,12 @@ MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disab
>>   module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>>     /*
>> - * DOC: hdmi_hpd_debounce_delay_ms (uint)
>> - * HDMI HPD disconnect debounce delay in milliseconds.
>> - *
>> - * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
>> - * generate while entering/leaving power save. Set to 0 to disable by default.
>> - */
>> -MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
>> -module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
>> -
>> -/*
>> - * DOC: dp_hpd_debounce_delay_ms (uint)
>> - * DisplayPort SST HPD disconnect debounce delay in milliseconds.
>> - *
>> - * Used to filter short disconnect->reconnect HPD toggles some DisplayPort SST
>> - * sinks generate while entering/leaving power save. Set to 0 to disable by
>> - * default. eDP and MST are not affected.
>> + * DOC: hpd_debounce_delay_ms (uint)
>> + * HDMI/DVI/DP SST HPD disconnect debounce delay in milliseconds. eDP and MST
>> + * are not affected. Overrides any per-panel default set via EDID quirks.
>>    */
>> -MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
>> -module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_delay_ms, uint, 0644);
>> +MODULE_PARM_DESC(hpd_debounce_delay_ms, "HDMI/DVI/DP SST HPD disconnect debounce delay in milliseconds (0 to disable (by default) or use the EDID quirk default, 1500 is common)");
>> +module_param_named(hpd_debounce_delay_ms, amdgpu_hpd_debounce_delay_ms, uint, 0644);
>>     /**
>>    * DOC: ptl (int)
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index abc17f547..5235a5ef6 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -61,14 +61,9 @@ enum amd_vsdb_panel_type {
>>   #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
>>     /*
>> - * Maximum HDMI HPD debounce delay in milliseconds
>> + * Maximum HDMI/DVI/DP SST HPD debounce delay in milliseconds
>>    */
>> -#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
>> -
>> -/*
>> - * Maximum DisplayPort SST HPD debounce delay in milliseconds
>> - */
>> -#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
>> +#define AMDGPU_DM_MAX_HPD_DEBOUNCE_MS 5000
>>   /*
>>   #include "include/amdgpu_dal_power_if.h"
>>   #include "amdgpu_dm_irq.h"
>> @@ -878,11 +873,10 @@ struct amdgpu_dm_connector {
>>       enum adaptive_sync_type as_type;
>>       struct amdgpu_hdmi_vsdb_info vsdb_info;
>>   -    /* HDMI HPD debounce support */
>> -    unsigned int hdmi_hpd_debounce_delay_ms;
>> -    unsigned int dp_hpd_debounce_delay_ms;
>> -    struct delayed_work hdmi_hpd_debounce_work;
>> -    struct dc_sink *hdmi_prev_sink;
>> +    /* HDMI/DVI/DP SST HPD debounce support */
>> +    unsigned int hpd_debounce_delay_ms;
>> +    struct delayed_work hpd_debounce_work;
>> +    struct dc_sink *hpd_prev_sink;
>>         /* HDMI compliance automation */
>>       bool hdmi_comp_auto;
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> index c79a8ada8..798825ec1 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> @@ -1748,12 +1748,10 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>>           drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>>         /* Cancel and flush any pending HPD debounce work */
>> -    if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
>> -        cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
>> -        if (aconnector->hdmi_prev_sink) {
>> -            dc_sink_release(aconnector->hdmi_prev_sink);
>> -            aconnector->hdmi_prev_sink = NULL;
>> -        }
>> +    cancel_delayed_work_sync(&aconnector->hpd_debounce_work);
>> +    if (aconnector->hpd_prev_sink) {
>> +        dc_sink_release(aconnector->hpd_prev_sink);
>> +        aconnector->hpd_prev_sink = NULL;
>>       }
>>         if (aconnector->bl_idx != -1) {
>> @@ -2828,20 +2826,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>       mutex_init(&aconnector->hpd_lock);
>>       mutex_init(&aconnector->handle_mst_msg_ready);
>>   -    /*
>> -     * If an HPD debounce delay is set, clamp each signal's delay to its
>> -     * maximum. The debounce work and cached sink are shared by both the
>> -     * HDMI and DisplayPort SST paths.
>> -     */
>> -    aconnector->hdmi_hpd_debounce_delay_ms = amdgpu_hdmi_hpd_debounce_delay_ms ?
>> -        min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS) : 0;
>> -    aconnector->dp_hpd_debounce_delay_ms = amdgpu_dp_hpd_debounce_delay_ms ?
>> -        min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS) : 0;
>> -
>> -    if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
>> -        INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
>> -        aconnector->hdmi_prev_sink = NULL;
>> -    }
>> +    /* May be overridden later by an EDID quirk in apply_edid_quirks() */
>> +    aconnector->hpd_debounce_delay_ms = amdgpu_hpd_debounce_delay_ms ?
>> +        min(amdgpu_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS) : 0;
>> +    aconnector->hpd_prev_sink = NULL;
>> +    INIT_DELAYED_WORK(&aconnector->hpd_debounce_work, amdgpu_dm_hpd_debounce_work);
>>         dm->hdmi_frl_status_polling_delay_ms = 200;
>>       INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index 9c4e0a4e2..71c897416 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -137,6 +137,14 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>>           drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
>>           link->wa_flags.skip_phy_ssc_reduction = true;
>>           break;
>> +    /* Workaround for monitors that toggle HPD on entering deep sleep */
>> +    case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
>> +        if (!aconnector->hpd_debounce_delay_ms) {
>> +            drm_dbg_driver(dev, "Enabling HPD debounce on panel id %X\n", panel_id);
>> +            aconnector->hpd_debounce_delay_ms =
>> +                min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
>> +        }
>> +        break;
>>       default:
>>           return;
>>       }
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> index 2a732d19b..151db9893 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>> @@ -1217,13 +1217,13 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>>       /**
>> - * DOC: amdgpu_dm_hdmi_hpd_debounce_work
>> + * DOC: amdgpu_dm_hpd_debounce_work
>>    *
>> - * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
>> + * HDMI/DVI/DP SST HPD debounce delay in milliseconds. When a display toggles HPD
>>    * (such as during power save transitions), this delay determines how long to
>>    * wait before processing the HPD event. This allows distinguishing between a
>> - * physical unplug (>hdmi_hpd_debounce_delay)
>> - * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
>> + * physical unplug (>hpd_debounce_delay)
>> + * and a spontaneous RX HPD toggle (<hpd_debounce_delay).
>>    *
>>    * If the toggle is less than this delay, the driver compares sink capabilities
>>    * and permits a hotplug event if they changed.
>> @@ -1231,11 +1231,11 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>>    * The default value of 1500ms was chosen based on experimental testing with
>>    * various monitors that exhibit spontaneous HPD toggling behavior.
>>    */
>> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
>> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work)
>>   {
>>       struct amdgpu_dm_connector *aconnector =
>>           container_of(to_delayed_work(work), struct amdgpu_dm_connector,
>> -                 hdmi_hpd_debounce_work);
>> +                 hpd_debounce_work);
>>       struct drm_connector *connector = &aconnector->base;
>>       struct drm_device *dev = connector->dev;
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>> @@ -1259,11 +1259,12 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
>>           /* Apply workaround delay for certain panels */
>>           amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
>>           /* Compare sinks to determine if this was a spontaneous HPD toggle */
>> -        if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
>> +        if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hpd_prev_sink)) {
>>               /*
>> -             * Sinks match - this was a spontaneous HDMI HPD toggle.
>> +             * Sinks match - this was a spontaneous HPD toggle.
>>                */
>> -            drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
>> +            drm_dbg_kms(dev,
>> +                    "HPD: Sink unchanged after debounce, internal re-enable\n");
>>               fake_reconnect = true;
>>           }
>>   @@ -1280,9 +1281,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
>>       }
>>         /* Release the cached sink reference */
>> -    if (aconnector->hdmi_prev_sink) {
>> -        dc_sink_release(aconnector->hdmi_prev_sink);
>> -        aconnector->hdmi_prev_sink = NULL;
>> +    if (aconnector->hpd_prev_sink) {
>> +        dc_sink_release(aconnector->hpd_prev_sink);
>> +        aconnector->hpd_prev_sink = NULL;
>>       }
>>         scoped_guard(mutex, &adev->dm.dc_lock) {
>> @@ -1302,7 +1303,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>>       struct dc *dc = aconnector->dc_link->ctx->dc;
>>       bool ret = false;
>>       bool debounce_required = false;
>> -    unsigned int debounce_delay_ms = 0;
>> +    bool debounce_eligible;
>>         if (adev->dm.disable_hpd_irq)
>>           return;
>> @@ -1326,16 +1327,16 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>>           drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
>>         /*
>> -     * Check for an HDMI or DisplayPort SST disconnect with debounce
>> -     * enabled. eDP and MST are intentionally excluded.
>> +     * Check for an HDMI, DVI, or DisplayPort SST disconnect with
>> +     * debounce enabled. eDP and MST are intentionally excluded.
>>        */
>> -    if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
>> -        debounce_delay_ms = aconnector->hdmi_hpd_debounce_delay_ms;
>> -    else if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
>> -         aconnector->dc_link->type != dc_connection_mst_branch)
>> -        debounce_delay_ms = aconnector->dp_hpd_debounce_delay_ms;
>> +    debounce_eligible = dc_is_hdmi_signal(aconnector->dc_link->connector_signal) ||
>> +                 dc_is_dvi_signal(aconnector->dc_link->connector_signal) ||
>> +                 (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
>> +                  aconnector->dc_link->type != dc_connection_mst_branch);
>>   -    debounce_required = (debounce_delay_ms > 0 &&
>> +    debounce_required = (debounce_eligible &&
>> +                  aconnector->hpd_debounce_delay_ms > 0 &&
>>                     new_connection_type == dc_connection_none &&
>>                     aconnector->dc_link->local_sink != NULL);
>>   @@ -1353,28 +1354,28 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>>           /*
>>            * Disconnect detected - schedule delayed work instead of
>>            * processing immediately. This allows us to coalesce spurious
>> -         * HDMI/DP HPD signals from physical unplugs.
>> +         * HDMI/DVI/DP HPD signals from physical unplugs.
>>            */
>>           drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
>> -                debounce_delay_ms);
>> +                aconnector->hpd_debounce_delay_ms);
>>             /* Cache the current sink for later comparison */
>> -        if (aconnector->hdmi_prev_sink)
>> -            dc_sink_release(aconnector->hdmi_prev_sink);
>> -        aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
>> -        if (aconnector->hdmi_prev_sink)
>> -            dc_sink_retain(aconnector->hdmi_prev_sink);
>> +        if (aconnector->hpd_prev_sink)
>> +            dc_sink_release(aconnector->hpd_prev_sink);
>> +        aconnector->hpd_prev_sink = aconnector->dc_link->local_sink;
>> +        if (aconnector->hpd_prev_sink)
>> +            dc_sink_retain(aconnector->hpd_prev_sink);
>>             /* Schedule delayed detection. */
>>           if (mod_delayed_work(system_percpu_wq,
>> -                 &aconnector->hdmi_hpd_debounce_work,
>> -                 msecs_to_jiffies(debounce_delay_ms)))
>> +                 &aconnector->hpd_debounce_work,
>> +                 msecs_to_jiffies(aconnector->hpd_debounce_delay_ms)))
>>               drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
>>         } else {
>>   -        /* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
>> -        if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
>> +        /* If the aconnector->hpd_debounce_work is scheduled, exit early */
>> +        if (delayed_work_pending(&aconnector->hpd_debounce_work))
>>               return;
>>             scoped_guard(mutex, &adev->dm.dc_lock) {
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
>> index bccb5d354..66fb82961 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
>> @@ -113,7 +113,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
>>   struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev);
>>   void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
>>   int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
>> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
>> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work);
>>     /* IRQ handlers */
>>   struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
>>
>> ---
>> base-commit: c92b5b607c1c8ab786fccf03d62352b82f6539ae
>> change-id: 20260708-hpd-debounce-unify-896ad367bf02
>>
>> Best regards,
>> -- 
>> Nick Haghiri <nick@haghiri.net>
>>

