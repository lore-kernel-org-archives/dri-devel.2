Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E6EC61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 04:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF1E10E090;
	Sat, 29 Aug 2026 04:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i8xjMkID";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF54C10E090
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 04:31:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68E48438EF;
 Sat, 29 Aug 2026 04:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162CB1F000E9;
 Sat, 29 Aug 2026 04:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787977914;
 bh=yJT5pb4s4gTbng6dFlo/BBcdJi4Fb3eZJvr6JL3JaY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i8xjMkID/Yws5/jmh5Pv1KQVqIfZppfcVFIKYrEx9bx7lpD9NQkENTlJDw2MqYPVu
 W70StjYr4A++yC7R0Xkey/u4h/cQvMoBM08zIztxj4wk+iwjG3irxB/3+Ly3SBzpzB
 jfBqaMzvhISyh00kWhJHHn5fJDeiugd8z5I8yZSM11ErZ0PQa9WuhZzomuKtkK9lkl
 YjxRaa+MptH1ugDqf7JNb4Gj6+5Kxqiaa7WfS9Tpj8enFoQbpuKC/TR0zCa33Hqbqf
 1zbOeABFL6H3ai4NSveXzV7Vi/OlsmwkEpoOz36QEiQHR5oVhqe2aDBv0kXWNf+G4h
 0FcrzvuZr7hdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: dc: Propagate powergate failures on suspend
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829042030.21346-1-pengpeng@iscas.ac.cn>
References: <20260829042030.21346-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 04:31:53 +0000
Message-Id: <20260829043154.162CB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning an error from the suspend callback causes a permanent us=
ecount desynchronization in host1x and leaks runtime PM and clock resources.
- [High] Returning early on suspend failure leaves the clock running, but t=
he caller unconditionally drops the performance state, violating DVFS const=
raints.
--

commit c243459159c6fcb1671762433a70d770456532d9
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/tegra: dc: Propagate powergate failures on suspend

A lifecycle transition can continue after a required state restore
operation fails, leaving software state inconsistent with hardware.

Propagate the failure and unwind state acquired by the transition so
callers cannot observe a false success.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 0b3fcc7011b35..bac78b57dcffb 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -2878,8 +2878,14 @@ static int tegra_dc_runtime_suspend(struct host1x_=
client *client)
>  		return err;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning an error from the suspend
callback cause a permanent usecount desynchronization in host1x?

If tegra_dc_runtime_suspend() fails during reset_control_assert() or
tegra_pmc_powergate_power_off(), it returns an error.

host1x_client_suspend() intercepts this error and skips decrementing
client->usecount, leaving it at 1.

The caller tegra_crtc_atomic_disable() (which returns void) cannot abort the
disable process and ignores the error.

Upon the next atomic enable, host1x_client_resume() skips calling the resume
callback because usecount is 1 (not 0), and increments it to 2.

The subsequent disable drops it to 1, skipping suspend. This permanently
disables callbacks, leaking clocks, power domains, and runtime PM reference=
s.

> =20
> -	if (dc->soc->has_powergate)
> -		tegra_pmc_powergate_power_off(dc->pmc, dc->powergate);
> +	if (dc->soc->has_powergate) {
> +		err =3D tegra_pmc_powergate_power_off(dc->pmc, dc->powergate);
> +		if (err < 0) {
> +			dev_err(dev, "failed to powergate partition: %d\n", err);
> +			reset_control_deassert(dc->rst);
> +			return err;

[Severity: High]
This isn't a bug introduced by this patch, but does returning early on susp=
end
failure leave the clock running, while the caller unconditionally drops the
performance state?

If tegra_dc_runtime_suspend() returns early on failure, it skips
clk_disable_unprepare(dc->clk). The hardware clock remains enabled.

However, the caller tegra_crtc_atomic_disable() proceeds to drop the voltag=
e:

drivers/gpu/drm/tegra/dc.c:tegra_crtc_atomic_disable() {
    ...
	err =3D host1x_client_suspend(&dc->client);
	if (err < 0)
		dev_err(dc->dev, "failed to suspend: %d\n", err);

	if (dc->has_opp_table) {
		err =3D dev_pm_genpd_set_performance_state(dc->dev, 0);
    ...
}

Operating the hardware at an active frequency with zero voltage violates DV=
FS
constraints and can cause hardware brownouts, potentially locking up the
system bus or hanging the SoC.

> +		}
> +	}
> =20
>  	clk_disable_unprepare(dc->clk);
>  	pm_runtime_put_sync(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829042030.2134=
6-1-pengpeng@iscas.ac.cn?part=3D1
