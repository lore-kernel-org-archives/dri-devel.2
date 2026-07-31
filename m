Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9845AC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBCF10F25C;
	Fri, 31 Jul 2026 13:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B4U4gIrt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29FF10F25C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:51:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D19B8600AD;
 Fri, 31 Jul 2026 13:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6129F1F000E9;
 Fri, 31 Jul 2026 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785505859;
 bh=syydMGCf1B6SBDfFUejGoi2rBFQO77I4rafUGJUBJbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B4U4gIrtAPg1wN1vwAVwCKWUrfRNy+B0s00gossQHwXrajTHls6LixOO/NsoXpCuE
 1ycmrbn/rosDtK+M4MNDYrqDLSw/yzUZWFdKPbJN30FHKh2GwGZ0VteBZt4EmubEvA
 V6obCwsYA6bbN3BcxGGoFjVGzAUUl50IyLKbBNfCcVVsMzyGSed8qHBU5zpHoI2rqJ
 5U/q5MtFA2qsCaRL25VEKTeOaorLrsPY/aePv5c2CT8Va8jmbO/gL5dtBkdFJQ7MXA
 Brovj8VWC7jGCWfD4KM/DIEmSqdLWpVN+rPYWIfcq6HOD5j/zbqrHa+IXEX5TF0M6T
 PoOnirba8RhhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:50:59 +0000
Message-Id: <20260731135059.6129F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check after `pwrseq_unit_enable()` in `pwrseq_enable=
()`.
- [High] The return value of `pwrseq_enable()` is ignored in `slot_pwrctrl_=
power_on()`.
- [High] Missing cleanup of previously enabled regulators in `slot_pwrctrl_=
power_on()` if clock enable fails.
- [High] `pwrseq_put()` frees the descriptor without decrementing `enable_c=
ount` if `pwrseq_disable()` fails.
--

--- Patch [1]: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() t=
o pwrseq_enable/disable() ---
commit 72b956d7bab750ba1857c47c880220b1aa1f9e10
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()

This commit renames the power sequencing functions pwrseq_power_on() and
pwrseq_power_off() to pwrseq_enable() and pwrseq_disable() to better reflect
their semantics. It updates consumers across various subsystems to use the =
new
names.

Link: https://lore.kernel.org/all/CAMRc=3DMefxn81d0VUwmQgwFtffkL1=3DEr_1VQZ=
CbC1Sa-Qph4t1w@mail.gmail.com/
Link: https://patch.msgid.link/20260731-pwrseq-vote-rename-v2-1-480357946e0=
0@oss.qualcomm.com

> diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
> index a7e599d841e62..d56171e0ee244 100644
> --- a/drivers/pci/pwrctrl/generic.c
> +++ b/drivers/pci/pwrctrl/generic.c
> @@ -29,7 +29,7 @@ static int slot_pwrctrl_power_on(struct pci_pwrctrl *pw=
rctrl)
>  	int ret;
> =20
>  	if (slot->pwrseq) {
> -		pwrseq_power_on(slot->pwrseq);
> +		pwrseq_enable(slot->pwrseq);
>  		return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but the negative error code from pwrseq_enabl=
e()
is ignored here, and 0 is incorrectly returned on failure.

If pwrseq_enable() fails, the PCIe subsystem will proceed assuming the slot=
 is
powered on. When it tries to probe or interact with the slot, it will access
unpowered hardware, potentially leading to bus faults or system hangs.

Should this code return the error code from pwrseq_enable() instead?

[Severity: High]
This is another pre-existing issue, but if slot->pwrseq is not present, this
function continues with regulator_bulk_enable() and clk_prepare_enable():

	ret =3D regulator_bulk_enable(slot->num_supplies, slot->supplies);
	if (ret < 0) {
		...
		return ret;
	}

	return clk_prepare_enable(slot->clk);

If clk_prepare_enable() fails, the function returns an error without disabl=
ing
the regulators that were just enabled, resulting in a resource leak.

Should clk_prepare_enable() failure be checked, and regulator_bulk_disable()
called if it fails?

[ ... ]

> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 02f42da915985..721e888b658d1 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -708,7 +708,7 @@ void pwrseq_put(struct pwrseq_desc *desc)
>  	pwrseq =3D desc->pwrseq;
> =20
>  	if (desc->powered_on)
> -		pwrseq_power_off(desc);
> +		pwrseq_disable(desc);
> =20
>  	kfree(desc);
>  	module_put(pwrseq->owner);

[Severity: High]
This isn't a bug introduced by this patch, but pwrseq_put() frees the descr=
iptor
without decrementing the enable_count if pwrseq_disable() fails.

If the underlying hardware disable fails, pwrseq_unit_disable() returns an =
error
and does not decrement the enable_count. However, pwrseq_put() ignores this
error and unconditionally calls kfree(desc), stranding the enable_count ins=
ide
the pwrseq_unit and causing a permanent logical leak.

Is it intentional that the descriptor is freed even if disabling fails?

[ ... ]

> @@ -874,7 +874,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *=
pwrseq,
>  }
> =20
>  /**
> - * pwrseq_power_on() - Issue a power-on request on behalf of the consumer
> + * pwrseq_enable() - Issue a power-on request on behalf of the consumer
>   *                     device.
>   * @desc: Descriptor referencing the power sequencer.
>   *
> @@ -887,7 +887,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *=
pwrseq,
>   * Returns:
>   * 0 on success, negative error number on failure.
>   */
> -int pwrseq_power_on(struct pwrseq_desc *desc)
> +int pwrseq_enable(struct pwrseq_desc *desc)
>  {
>  	struct pwrseq_device *pwrseq;
>  	struct pwrseq_target *target;

[Severity: High]
This is a pre-existing issue, but there is a missing error check after
pwrseq_unit_enable() in pwrseq_enable().

Later in this function, we do:

	scoped_guard(mutex, &pwrseq->state_lock) {
		ret =3D pwrseq_unit_enable(pwrseq, unit);
		if (!ret)
			desc->powered_on =3D true;
	}

	if (target->post_enable) {
		ret =3D target->post_enable(pwrseq);
		...

If pwrseq_unit_enable() fails, the code ignores the error and proceeds to c=
all
target->post_enable(). If post_enable() succeeds, it overwrites the error c=
ode
and returns 0 (success) to the caller, while desc->powered_on remains false
and the hardware is unpowered.

If post_enable() fails, it attempts to call pwrseq_unit_disable() on an
unpowered unit, causing an unbalanced enable count and a kernel WARN.

Should we return early if pwrseq_unit_enable() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-pwrseq-vot=
e-rename-v3-1-44e60b8be053@oss.qualcomm.com?part=3D1
