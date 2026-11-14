Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F140606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDpaBPk/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0307710E12A;
	Sat, 14 Nov 2026 16:53:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A5C10E12A;
 Sat, 14 Nov 2026 16:53:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E14ED4121E;
 Sat, 14 Nov 2026 16:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899241F000C5;
 Sat, 14 Nov 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794675213;
 bh=1qitJJh20paV7ise+zjJctmNJxxZwOUXPqe1Kw+xCRE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iDpaBPk/KoHHXVJwsXEI12vAqhGqj4gmyq8juMAW4PYspM5S5ue6uLTAfV2gXP7AC
 R7wy8wM/zagFuuaactbYQCDeBZjhsQOSMnKV+jfqmeplebo3T2ywbWGQffuhWCVpEl
 CfmH6hXWY73JOfV8EDxuPbEKYR1RavOpI4e1Du7ejR7YlsvjmCVEehH3TJJjgEs6H8
 OA8PLTViihCC94tm9ZXUd2BqMLShX6rOmi1JbhKElcj3NAwnZrbVHwVcdvX1JTkXV+
 YUWVinBrbJfbilH68bpcSDPCFJ5ilCA0F9YP+n8frXBumDHy/N4gTC70ELaPaODOeN
 HiowdpLZLND+Q==
Message-ID: <sashiko-outbox-214789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] drm/amdgpu: Skip AC/DC notification while the
 GPU is runtime suspended
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-12-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-12-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:53:33 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/amdgpu: missed AC/DC SMU update in
  amdgpu_pm_acpi_event_handler() race
- [Medium] drm/amd/pm: negative pm_runtime_get_if_active() treated as
  suspended
- [Medium] drm/amdgpu: missing SMU7 AC notification on resume in
  hwmgr_resume()
--

commit 2d835db57775c3299d3a931908d4d082aae8da4d
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended

This commit acquires a runtime PM reference with pm_runtime_get_if_active()=
 in
amdgpu_pm_acpi_event_handler() and skips notifying the SMU of AC/DC changes
when the device is not runtime active.

> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 808be6c425bff..3c6dde3868006 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c

[ ... ]

> @@ -498,19 +499,27 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_dev=
ice *adev,
> =20
>  void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>  {
> +	int active =3D 0;
> +
>  	if (adev->pm.dpm_enabled) {
>  		mutex_lock(&adev->pm.mutex);
> +		active =3D pm_runtime_get_if_active(adev->dev);
> +
>  		if (power_supply_is_system_supplied() > 0)
>  			adev->pm.ac_power =3D true;
>  		else
>  			adev->pm.ac_power =3D false;
> =20
> -		if (adev->powerplay.pp_funcs &&
> -		    adev->powerplay.pp_funcs->notify_ac_dc)
> -			amdgpu_dpm_notify_ac_dc(adev);
> +		if (active > 0) {

[Severity: Medium]
Can an AC/DC event racing with runtime resume or an aborted runtime suspend
drop the SMU power-source update?

During rpm_resume(), dev->power.runtime_status stays RPM_RESUMING until
amdgpu_pmops_runtime_resume() returns, so pm_runtime_get_if_active() returns
0 (or -EINVAL while hotplug probing increments disable_depth):

CPU0                                  CPU1
rpm_resume()
  dev->power.runtime_status =3D RPM_RESUMING
  amdgpu_pmops_runtime_resume()
    amdgpu_device_resume()
      amdgpu_device_ip_late_init()
        smu_late_init()
          smu_set_ac_dc()
                                      amdgpu_pm_acpi_event_handler()
                                        pm_runtime_get_if_active() -> 0
                                        adev->pm.ac_power =3D ...
                                        /* skips smu_set_ac_dc() */
      flush_delayed_work()
  dev->power.runtime_status =3D RPM_ACTIVE
                                        <-- GPU runs with stale AC/DC state

The same drop occurs if the event arrives during rpm_suspend() while
runtime_status is RPM_SUSPENDING and amdgpu_pmops_runtime_suspend() later
aborts with -EBUSY, which reverts runtime_status to RPM_ACTIVE without
running resume.  In addition, hwmgr_resume() and hwmgr_suspend() invoke
smu7_apply_state_adjust_rules() and vega10_apply_state_adjust_rules()
without holding adev->pm.mutex, reading adev->pm.ac_power twice while
amdgpu_pm_acpi_event_handler() can update it concurrently.

[Severity: Medium]
Does checking active > 0 also skip AC/DC notifications when runtime PM or
CONFIG_PM is disabled?

pm_runtime_get_if_active() returns -EINVAL when CONFIG_PM is disabled or
when runtime PM is disabled on adev->dev (disable_depth > 0).  With
active > 0, amdgpu_pm_acpi_event_handler() treats -EINVAL as suspended and
never notifies the SMU or DPM even though the GPU is active and no runtime
resume will follow.  Other callers in this subsystem such as
amdgpu_pm_get_access_if_active() check active !=3D 0 to allow hardware acce=
ss
and only call pm_runtime_put() when active > 0.

> +			if (adev->powerplay.pp_funcs &&
> +			    adev->powerplay.pp_funcs->notify_ac_dc)
> +				amdgpu_dpm_notify_ac_dc(adev);

[Severity: Medium]
If AC power is connected while an SMU7 GPU is runtime suspended, will the
resume path ever send PPSMC_MSG_RunningOnAC to the SMU?

On SMU7 GPUs with PHM_PlatformCaps_AutomaticDCTransition, smu7_notify_ac_dc=
()
is the only place that sends PPSMC_MSG_RunningOnAC when adev->pm.ac_power is
true:

drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c:smu7_notify_ac_dc() {
	...
	if (adev->pm.ac_power &&
	    phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
			    PHM_PlatformCaps_AutomaticDCTransition))
		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunningOnAC, NULL);
	...
}

Unlike swSMU, which calls smu_set_ac_dc() in smu_late_init(), neither
hwmgr_resume() nor pp_late_init() invokes notify_ac_dc() or sends
PPSMC_MSG_RunningOnAC.  When SMU firmware stays running across BACO runtime
suspend, skipping amdgpu_dpm_notify_ac_dc() here leaves the SMU in DC mode
after resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D11
