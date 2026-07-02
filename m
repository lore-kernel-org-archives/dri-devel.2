Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B627C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607A210E2F5;
	Thu,  2 Jul 2026 16:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XoeGF/hj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306310E2F5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD26D601EF;
 Thu,  2 Jul 2026 16:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383E71F00A3A;
 Thu,  2 Jul 2026 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783011415;
 bh=bxmyuq/wQSm8BvBBL8dHHPj0pPi/cWZOj2F4sACIgOw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XoeGF/hjHSNWB2iU4gh7Tk+QIBy81Lgi5eA/zlVLYdPvH/zkkRE6zXUff+EH2Ku/a
 MawK4U9MDcRsFiOQ+W+L10fasdd4O/chuDF8yRWb419EuMuc0gDKZ62weolhUEpvWu
 o4RMuSE57isV/54mAplEeKJFeMLx+yOsQQXr06MJjrWrTs5bHtStIdoEChK78gnU81
 s7M+w+FTZ6BITCwBqO0vZqEMiMYtuO5/J25O/CQZOT+3vVccwLJ4Kw45lWGoabqx4S
 449XgnGo+rlddNHhuovgYqALr1PMFFOcgE9M6aMy8G1JOIXVfKGt19AYr+tecEguCL
 p59O8iYCG/JDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/amd/pm/smu7: return error on message send failure
To: =?utf-8?b?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b284acc0dd71b46fbb402ed60f1da23604259e0a.1783009338.git.mirq-linux@rere.qmqm.pl>
References: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
 <b284acc0dd71b46fbb402ed60f1da23604259e0a.1783009338.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:56:53 +0000
Message-Id: <20260702165655.383E71F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Changing `smu7_send_msg_to_smc` to return error codes (like `-EOPN=
OTSUPP`) breaks caller contracts across the powerplay subsystem, leading to=
 severe initialization failures and incomplete hardware teardowns.
--

commit 69f2b8c2068f5f9f311a575e997b86049cf9f826
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Subject: drm/amd/pm/smu7: return error on message send failure

This commit changes smu7_send_msg_to_smc() to return standard error codes
like -EOPNOTSUPP and -EIO when the SMU message fails or is unsupported.
Previously, the function always returned 0 regardless of the SMU response.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index ffe3ce87d9073..2e6dfe864306c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -141,12 +141,16 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, ui=
nt16_t msg)
> =20
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
> =20
> -	if (ret =3D=3D 0xFE)
> +	switch (ret) {
> +	case 1:
> +		return 0;
> +	case 0xFE:
>  		dev_dbg(adev->dev, "SMU message %#x was not supported\n", msg);
> -	else if (ret !=3D 1)
> +		return -EOPNOTSUPP;

[Severity: High]
Does returning -EOPNOTSUPP here break caller contracts across the powerplay
subsystem?

Many callers appear to rely on the previous behavior where unsupported
messages (0xFE) still returned 0. For example, in smu7_stop_dpm():

drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c:smu7_stop_dpm() {
        ...
        PP_ASSERT_WITH_CODE(
                (smum_send_msg_to_smc(hwmgr,
                                      PPSMC_MSG_PCIeDPM_Disable,
                                      NULL) =3D=3D 0),
                "Failed to disable pcie DPM during DPM Stop Function!",
                return -EINVAL);
        ...
}

If the hardware doesn't support PPSMC_MSG_PCIeDPM_Disable, the function now
returns -EOPNOTSUPP. Will this cause smu7_stop_dpm() to abort early and
skip critical teardown steps like smu7_disable_sclk_mclk_dpm()?

Similarly, in fiji_thermal_setup_fan_table(), an unsupported
PPSMC_MSG_SetFanMinPwm message will cause the return value to be non-zero,
which might mistakenly disable microcode fan control entirely.

> +	default:
>  		dev_info(adev->dev, "SMU message %#x failed: response is %d\n", msg, r=
et);
> -
> -	return 0;
> +		return ret !=3D 0xFFFF ? -EIO : -ENXIO;
> +	}
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783009338.gi=
t.mirq-linux@rere.qmqm.pl?part=3D3
