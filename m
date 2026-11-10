Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445466072503
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CnfB2O2H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B027610E95F;
	Tue, 10 Nov 2026 20:30:18 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D62C10E95F;
 Tue, 10 Nov 2026 20:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqRmXOLJY7wBQDw5R48UZ8D1AH/w+BUjRILkHqJfE5gn7E92dt7J9njuAJDXFLiHUc9+PR4S1Oax/yxTVf5Uk1fmaWfRVGGycNyUG8lr2XPq1jQmKBnqr2B47lxldB3uSyWlwCS4WJKB0dxMVCUaB+vRh5czIxi17BI5p/YRe8Q+Ibkk5Ont3DSU0Bnpbda3DFKt7cEuTsvZyQC6LLaMyf7pxaOPUFMFf8CHc1k/Hhk05rF0byn9mKM5xu8C4ubWHr1wGjZZSq9ZOlaDoXL5zapIDxYtsX9JvNzsZQEQtFxjJPDwlgRAx+5Q+XK9q+f3KbccdI4PLcC5qz2KWzupgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOqaqa9PXQA46GWqJ1SccK59ICLnwr4PYHytDXW3pGw=;
 b=nL8FpYAmImQW0is91YmAO0DFWa7yl7nt2m+40z7zPjARLf67wSq2lMLe5sZlxQ2cMYsJHZdxxpS9CQOG34ndegs6+EWfNtQuE83V+VXNxGjoNQMaZ0Ezye/SGsTJFFCPu1V84UOUDlqQSEtX91nkZ4p4dl+oPywyFMu+ScKRwSeX53Pf6xjgK7R0iBXmkTqEJN/4bMAE0zcw/yx3RXhgJB6MZx5LCYBdCEc8F91+Oj0zm3gbDDKllRSDxCgpRI4fTH8JKKlZq9nBHrBWzt3ZigQSfVjaLwcROxBNWDGwvJFTxSS9Et4Z/f4QAu0NyCotkyRJGBt65IJgvftvlAXV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOqaqa9PXQA46GWqJ1SccK59ICLnwr4PYHytDXW3pGw=;
 b=CnfB2O2HvIM939UUczXK1uhhPd8KkWcqAnVAFUFQpoxqooGaOsWZOWRupN/zwjx1Ju+0jhMjBAtyv1VBZXHGZIUs28qo2JNf06R4Gzn+4mGlUnM5F4Zy1vxap6MiyBRDHEz8Yav9q1HrTojYs1I4N8YTSRiV0kxHqPAGADJhpJU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DS6PR12MB586850.namprd12.prod.outlook.com (2603:10b6:8:410::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:30:09 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:30:09 +0000
Message-ID: <e925978e-7b1a-4780-9e0c-616b9455058b@amd.com>
Date: Tue, 10 Nov 2026 14:30:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: use atomic commit for panel power
 savings
Content-Language: en-US
To: shivamkalra98@zohomail.in, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Weber <weber.aulendorf@gmail.com>,
 Alex Hung <alex.hung@amd.com>
References: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261111-abm-sysfs-atomic-v2-1-6dfb19c51ebe@zohomail.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DS6PR12MB586850:EE_
X-MS-Office365-Filtering-Correlation-Id: 391ff393-0c8f-4b03-d475-08df3f69699a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|5023799004|22082099003|18002099003|11063799006|6133799003|10067099003|261009223027099003|261009221227099003|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261022075727099003|261021121427099003|261022105027099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: qC9MNj+VKQsnKsppd4+GhDSeir2oKhvC8vdQ8JSXnLe/N+GkNZx+Fs2B2pxso4K/eIBb9S7QZeoZRI/S7CqXTrOjm+DTW/Hjr/nQUf9hR6pRKcNI6LbGhwCS7QG385EwLKX8KGV7xg022vrZLywlZ0kFqZy9Fd6zm/Nwm3qW3p7KBP5Hi7zknmgnYEIgWbDDuYXzX3l4JJZP/VMsxnNK1ue8bdkl19qrKAPny4mLjvBJnfzMqeIcG+g3QOGBsPJc5/kgyI9VpElgTg+cDeEG6utRc/jQhG2PIsse/PbAtW8y12iArxRsK9K4wtjMorj+X2DivL1bzTNUxyx4QogGG4Z/EddmWMEROC+W2yQLthUbMsL9NhmczeytKSX4Ob15uy6naJP7eHxg0vnHjBhrUgziVKEvR1GsNQn/DwZEJOtlvuzwQpegy+DCSTuvdSXbEQFzXNsLTZkciozdlTXoTGtcRhhEP8OxZ72Lw/Tw/JCCjwFQxqEtrzUlG1jCAETE5yQSU0syav0lp4i4PZon4kpeBDuwbe6uh5Uvno2oA5xWqYuX0a6H2wRO2ScBzUgpPKwLKSbDjLer+K84GRjIn69nmpANbXGF3vQlzE4oYct9qe4dnfXTE7LOfLX7U4fg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(261009223027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXp3QnRYQkkreit2bzROZUFNdkFEMU0zUEt2SEVSdXVJMWs4UytSMjNvSC9k?=
 =?utf-8?B?Y0FMWncyMU0yZXlZU2srcm14Sjc3elJ5bWdUVjd2SjN3a2Y4ZC9WSHk2RjNB?=
 =?utf-8?B?N0x4SDFHSU40V0pZL0UzRSsyR2c3VjFYMkxnekhheWpUQzQzTE40WUxWaXhs?=
 =?utf-8?B?UkFqa2ExSC92c0g0QXJVNXd3V3BhVlNSMk1raDBXZzJvSzJHNXZUTERZZmli?=
 =?utf-8?B?Z00rKzBpaXYyL2xZNnVVSHRZVXozRmlQWDFoZVJOb0x0a2pmakI3VVRyRk9s?=
 =?utf-8?B?eEZlUHl5OUdCbUgxd0RZMmpucmZ6RXdaTWo2ZStQbWZwaTQyOCtHK3RaZlFr?=
 =?utf-8?B?TDVUY2c1Smt0ZWNYTzkwYWRZVzVLcCtOQ2lKdnJyK04vUTZLK1FZMXEwbzdK?=
 =?utf-8?B?UmJMUkJZSWtEZ3dDbDFkaWNkVXpMeVA4KzNRZkJ2bFovcGNmNElQd3BYOUNO?=
 =?utf-8?B?Qk40S1JGaWs0Nk1tN0lGblordW5Xay9YZGlUOGJCZnlXdU1zNjJoVHZFeDdr?=
 =?utf-8?B?dDB1UkQ3a25Vc1ZwS1ljdnpCT1BLYmdLcWdpZFRNRnZkcHltZHF3aSswamlH?=
 =?utf-8?B?UnN5VlBlK3JkOEhES01hLzZLUEZKU3RNQjZHYzd3SDNXWnFRRnJBdEUzQkJU?=
 =?utf-8?B?cWFIdXI1aHhMYkZWME1BYmp3L05LT3lmaGhaam5jNHdZV0hWdEd0NXQrbHB0?=
 =?utf-8?B?aUJ0NHZsMXI1SzN5b1RYZ3FvNGVGMy80NzRXdGZVUi9pbVQyaFJ6dk00MVVu?=
 =?utf-8?B?a0RDNUVMYnBheGFlUFZvR1E3M3Fpa3MzckQ1VDhRRzNaM2RnaGlkaDlrMUt2?=
 =?utf-8?B?dm8vYXA4MHNWNXJjaCs0Qk9Jc2ZERHgxM0VsS3J0OTBwaDhiOFlNYlNLTG5N?=
 =?utf-8?B?c1dod29naUloeHNaOHhsT0ZIZ0V5VFE5VlJPOWxjaEw2MFp2RS9PbnJMTkY0?=
 =?utf-8?B?TFVCbjl3VTFkK1BWSlhydXY0M003L3JoWDdwM1FubnRWYVVUWmJTM1Q0dVp5?=
 =?utf-8?B?N0xnTmluYnRYQ25GYXVEdTF6d3N6U1B4Y0VjanFUdUFCbWRwNExLaHJXek9R?=
 =?utf-8?B?MzhKbnJpT1ZVZVVCWUVHNGZ0b0xaT0NqQmdjZkhRYzRVUlhUdGRTR3YydzBS?=
 =?utf-8?B?K285dFNiSlVGOHVrU3ZsTEd5QXZiWVBOWnBHTkNaZFRJN1AxTDhwS05GQnhy?=
 =?utf-8?B?RTNUbVJMWk0zbkh6QXhqclhlLzI4WnNMR1g2QlRtUDdtcitvZElIdXh5NDV4?=
 =?utf-8?B?N1dieWFGdlRJWmJNR1NuR214RU16cFFDVzNFOFBueDBQa2lSK1A1SUFLWklI?=
 =?utf-8?B?R2VCMjRMTzVZRVp0VVY5T2RySW1ueG1BR21Ha3UxTXVYR3A2STM5aW1ETHNK?=
 =?utf-8?B?Uy9EaU5kUVZDWkpmTHpzMUgxSVFoUnZ0TldOT0ZXdk1vZC8rUmhrYkFVdGFi?=
 =?utf-8?B?SXc4ZTUwNmxZcHhTUHZlZVNlNFdPUWl4dFlNb3VqLzN6SHdsenVoaWJQRnpp?=
 =?utf-8?B?VVJsaW9JUEJta2F6S2NZVHpkTHloL0xZNVIyNVl2dnBGWC9XRE1GZm5HTkhS?=
 =?utf-8?B?WmtoWVVlNFBLNnB6SENOa3MxQWtINVlTNktCTTh1WE1XWUdndWxtdmxDeUs5?=
 =?utf-8?B?NDZaU1RES1BJUXl3SitKVkZ0aW5aN0VxbHJKYjBwTTlvelNQZzdqeFkxQWxK?=
 =?utf-8?B?ZXpjTGtWUzZRRmdodDBIUGNLU2pwRHROREt5VjVXbkZibGFWMHVzWWFRcjVt?=
 =?utf-8?B?dUFMNWFqcEtUUGk5TlJDa05DcmYrSXpKVzBYSldwanJVMG0vOFovTGZkY3I0?=
 =?utf-8?B?MlVoZXBvd1ZSckVMbUhtUnUyT0pwR1J5eG9BOWtIbG9KcFpLamFXVjJxMHAz?=
 =?utf-8?B?MitCQnBDOGQxeEFFb0F5bVZPN04vUkN5Z3hQNDhTeFdxZ0ZZMWc2amY3WjI3?=
 =?utf-8?B?WHhuVzFTQThjV01xTDZ2ZDQweG5xcHdnTDZuTUlGeHpMeVJpRTFjTlZ1SlpG?=
 =?utf-8?B?a2lkY2pwRkhvbDRKOTZLQ3lqZythcW5SWmsyUmRzWXRuVmNEcTBlUVdiaGE2?=
 =?utf-8?B?YjJFL0E3VDNqRGtFUnNkdTdBQnJoc1RvY2dWc0FSRC9jeTZHWUtUOG9WOFht?=
 =?utf-8?B?ck9CVFJiaisraHJiMTdkYnNrdG5hM1BXWHBGT2x4ZlV3TlRPOFdTdGl4TFFq?=
 =?utf-8?B?aC9lanpmRk0vUzJQUXNEY2liTFEwdDRiQk9FckxVZ2tONVpqSDRobW9LL1d4?=
 =?utf-8?B?WTJ0NU9Lb2l6RlRrdCtqWU1QZ0lMUUhRMit1VUpPU005NDhBcmFkb081ZU9o?=
 =?utf-8?Q?dmfxipVUaSdCzgAtL8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ff393-0c8f-4b03-d475-08df3f69699a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:30:09.1828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5B6Nbk4ZGJwOdht+iBkhcrggy7HMTkllTsQ/ywtMoW9bcZq7/GQ+DaYKCeeFzrBYMFi6WEVMiJqARbgr0RltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB586850
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



On 11/10/26 13:24, Shivam Kalra via B4 Relay wrote:
> From: Shivam Kalra <shivamkalra98@zohomail.in>
> 
> panel_power_savings_store() mutates connector->state directly and sends a
> hotplug event. This bypasses atomic commit handling, so the new ABM level
> is only applied when userspace happens to perform another modeset, and it
> races with concurrent commits.
> 
> Build an atomic state, set the level on the connector state and commit it.
> If the connector is not attached to a CRTC, keep the level in the current
> state so the next modeset picks it up, as before.
> 
> In amdgpu_dm_atomic_check(), drm_atomic_get_crtc_state() already adds the
> CRTC to the atomic state so dm_update_crtc_state() can propagate abm_level
> to the CRTC state. Stop setting new_crtc_state->connectors_changed for ABM
> changes and keep it only for scaling changes, allowing ABM updates to go
> through the existing non-modeset stream update path without blanking the
> panel.
> 
> A previous attempt to avoid the modeset by calling into DMUB directly was
> reverted because it broke the abm_gradual IGT test (8d20a066fa9b,
> 95aaa207e9ef). This version instead uses the normal atomic stream update
> path.
> 
> Extend the backlight KUnit tests to cover the atomic commit and inactive
> connector sysfs paths.
> 
> Fixes: 63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs entry to eDP connectors")
> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Others should comment before merging though too.
> ---
> Changes in v2:
> - Avoid forcing a modeset for ABM-only changes, matching David Weber's
>    patch [1] (Alex Hung; issue also noted by Sashiko).
> - Make modeset-lock acquisition interruptible (Alex Hung).
> - Inline the state update and remove the redundant connector-state
>    lookup (Alex Hung).
> - Reuse existing connector-state helpers in KUnit (Sashiko).
> - Add a KUnit test for the sysfs commit branch with an attached CRTC.
> - Run the amd_abm IGT suite, including abm_gradual.
> - Link to v1: https://lore.kernel.org/r/20261031-abm-sysfs-atomic-v1-1-a99068f3b49c@zohomail.in
> 
> [1] https://lore.kernel.org/amd-gfx/20260813112634.11455-3-weber.aulendorf@gmail.com/
> 
> Testing:
> - KUnit: amdgpu_dm_backlight, 74/74 tests passed.
> 
> - Hardware: v2 backported to 7.1.13-stable-manual on Rembrandt
>    (DCN 3.1.2, eDP-1). All five amd_abm IGT subtests passed, including
>    abm_gradual. No HOTPLUG=1 events were captured.
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 64 +++++++++++++++---
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 79 +++++++++++++++++++++-
>   3 files changed, 132 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfbc384fbbdb..256699cdd0b5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   		}
>   
> -		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
> -		    dm_old_con_state->scaling != dm_new_con_state->scaling)
> +		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
>   			new_crtc_state->connectors_changed = true;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d..97684a58cd3d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -719,31 +719,73 @@ ssize_t panel_power_savings_store(struct device *device,
>   {
>   	struct drm_connector *connector = dev_get_drvdata(device);
>   	struct drm_device *dev = connector->dev;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_connector_state *conn_state;
> +	struct dm_connector_state *dm_conn_state;
> +	struct drm_atomic_commit *state;
> +	u8 abm_level;
>   	long val;
>   	int ret;
>   
>   	ret = kstrtol(buf, 0, &val);
> -
>   	if (ret)
>   		return ret;
>   
>   	if (val < 0 || val > 4)
>   		return -EINVAL;
>   
> -	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
> +	abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
> +
> +	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> +	state = drm_atomic_commit_alloc(dev);
> +	if (!state) {
> +		ret = -ENOMEM;
> +		goto out_ctx;
> +	}
> +	state->acquire_ctx = &ctx;
> +
> +retry:
> +	conn_state = drm_atomic_get_connector_state(state, connector);
> +	if (IS_ERR(conn_state)) {
> +		ret = PTR_ERR(conn_state);
> +		goto out_backoff;
> +	}
> +
> +	dm_conn_state = to_dm_connector_state(conn_state);
> +	if (dm_conn_state->abm_sysfs_forbidden) {
>   		ret = -EBUSY;
> -	else
> -		to_dm_connector_state(connector->state)->abm_level = val ?:
> -			ABM_LEVEL_IMMEDIATE_DISABLE;
> -	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +		goto out_state;
> +	}
>   
> -	if (ret)
> -		return ret;
> +	dm_conn_state->abm_level = abm_level;
> +
> +	/*
> +	 * Without a CRTC there is no stream to update and nothing to commit.
> +	 * Keep the level in the current state so the next modeset picks it
> +	 * up, matching the behavior of the sysfs interface.
> +	 */
> +	if (!conn_state->crtc) {
> +		to_dm_connector_state(connector->state)->abm_level = abm_level;
> +		goto out_state;
> +	}
> +
> +	ret = drm_atomic_commit(state);
> +
> +out_backoff:
> +	if (ret == -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret = drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry;
> +	}
>   
> -	drm_kms_helper_hotplug_event(dev);
> +out_state:
> +	drm_atomic_commit_put(state);
> +out_ctx:
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
>   
> -	return count;
> +	return ret ? ret : count;
>   }
>   EXPORT_IF_KUNIT(panel_power_savings_store);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index c6d15fb8ad98..586e838a8f63 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -20,6 +20,7 @@
>   #include "amdgpu_mode.h"
>   #include "amdgpu_dm.h"
>   #include "amdgpu_dm_backlight.h"
> +#include "amdgpu_dm_connector.h"
>   #include "amdgpu_dm_kunit_test_helpers.h"
>   #include "amd_shared.h"
>   #include "link_service.h"
> @@ -514,6 +515,43 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
>   			adev->dm.backlight_dev[0]), 0);
>   }
>   
> +static int
> +dm_test_panel_power_savings_atomic_commit(struct drm_device *dev,
> +					  struct drm_atomic_commit *state,
> +					  bool nonblock)
> +{
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_connector *connector;
> +	int i;
> +
> +	for_each_new_connector_in_state(state, connector, new_conn_state, i)
> +		to_dm_connector_state(connector->state)->abm_level =
> +			to_dm_connector_state(new_conn_state)->abm_level;
> +
> +	return 0;
> +}
> +
> +static const struct drm_connector_funcs dm_test_panel_power_savings_connector_funcs = {
> +	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_mode_config_funcs dm_test_panel_power_savings_mode_funcs = {
> +	.atomic_commit = dm_test_panel_power_savings_atomic_commit,
> +};
> +
> +static void
> +dm_test_panel_power_savings_crtc_destroy(struct drm_crtc *crtc)
> +{
> +	drm_crtc_cleanup(crtc);
> +}
> +
> +static const struct drm_crtc_funcs dm_test_panel_power_savings_crtc_funcs = {
> +	.destroy = dm_test_panel_power_savings_crtc_destroy,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +};
> +
>   static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
>   							 struct device **device_out,
>   							 struct dm_connector_state **state_out)
> @@ -527,6 +565,7 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>   	adev = dm_kunit_alloc_adev(test);
>   	ret = drmm_mode_config_init(&adev->ddev);
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> +	adev->ddev.mode_config.funcs = &dm_test_panel_power_savings_mode_funcs;
>   
>   	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
>   	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
> @@ -536,7 +575,11 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
>   	KUNIT_ASSERT_NOT_NULL(test, state);
>   
>   	connector->dev = &adev->ddev;
> +	connector->funcs = &dm_test_panel_power_savings_connector_funcs;
> +	connector->index = 0;
> +	kref_init(&connector->base.refcount);
>   	connector->state = &state->base;
> +	state->base.connector = connector;
>   	dev_set_drvdata(device, connector);
>   	*device_out = device;
>   	*state_out = state;
> @@ -614,10 +657,43 @@ static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
>   	setup_panel_power_savings_connector(test, &device, &state);
>   
>   	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
> -			 (ssize_t)count);
> +			(ssize_t)count);
>   	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
>   }
>   
> +/**
> + * dm_test_panel_power_savings_store_commits_with_crtc - Test store with CRTC
> + * @test: The KUnit test context
> + */
> +static void dm_test_panel_power_savings_store_commits_with_crtc(struct kunit *test)
> +{
> +	struct dm_connector_state *state;
> +	struct drm_connector *connector;
> +	struct drm_crtc *crtc;
> +	struct device *device;
> +	size_t count = strlen("3");
> +	int ret;
> +
> +	connector = setup_panel_power_savings_connector(test, &device, &state);
> +
> +	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> +	ret = drm_crtc_init_with_planes(connector->dev, crtc, NULL, NULL,
> +					&dm_test_panel_power_savings_crtc_funcs,
> +					NULL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	drm_atomic_helper_crtc_reset(crtc);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc->state);
> +	state->base.crtc = crtc;
> +
> +	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "3", count),
> +			(ssize_t)count);
> +	KUNIT_EXPECT_EQ(test, state->abm_level, 3);
> +
> +	state->base.crtc = NULL;
> +	drm_crtc_cleanup(crtc);
> +}
> +
>   /**
>    * dm_test_panel_power_savings_store_forbidden - Test forbidden update
>    * @test: The KUnit test context
> @@ -1939,6 +2015,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
>   	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
>   	KUNIT_CASE(dm_test_panel_power_savings_store_sets_disable),
>   	KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
> +	KUNIT_CASE(dm_test_panel_power_savings_store_commits_with_crtc),
>   	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
>   	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
>   	/* amdgpu_dm_backlight_get_device_index */
> 
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261031-abm-sysfs-atomic-c79505f63a2e
> 
> Best regards,
> --
> Shivam Kalra <shivamkalra98@zohomail.in>

