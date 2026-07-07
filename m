Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B546C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2426510ECF8;
	Tue,  7 Jul 2026 13:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a0paQOEt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A361D10ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04E4760018;
 Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326531F00A3A;
 Tue,  7 Jul 2026 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430701;
 bh=VScE8+lksLF74beM7uhLPsbzmHWf8o/zFQnHwmEj9CY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a0paQOEt4XsrxoKTwzs+HdRqRpq9+MmrmI+i+whSbudaMqZ+E3nJVr8SE1Rc4eOMR
 qH4AXAtcYqm2EruoDXsbgU696rSbXvsM/lo04yBT7zk+GAsSivP+XYCnkAxLvV+j6w
 x2TQiifMe6PZUzMpR9HSCVO7earyMdRqpLJhpXSSr9xbDFFxJPbQB7r6d7Ktsixn0V
 EEkSYR35k84VjclvTd8ZmBd/WpDaQUzBU0jwgkpJJeQjRb1g25CixX30Ijgl1FAoIV
 DbY5kCXOhZJAfpqtQt0Hr0kRq61wb/zrrcseUDbMm4WkhB3x8apQx9OjehwJoYvXlu
 zUF2IhJoKE95g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/20] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: lee@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org,
 imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-13-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-13-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:00 +0000
Message-Id: <20260707132501.326531F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dynamically allocated platform device and its associated OF no=
de reference are leaked during device unregistration.
- [High] Unconditional dereference of `of_match_node()` return value leads =
to a NULL pointer dereference.
- [High] Missing cancellation of asynchronous work `ngd_up_work` causes a U=
se-After-Free of the `ctrl` structure on module removal.
--

commit 4a2753767e946e9e44740066e0bb9147c741d781
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

slimbus: qcom-ngd-ctrl: use platform_device_set_of_node()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-c=
trl.c
> index 3071e46d03bea..6e89415712ce1 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but can this code cause a NULL
pointer dereference?

Looking at the beginning of of_qcom_slim_ngd_register():

drivers/slimbus/qcom-ngd-ctrl.c:of_qcom_slim_ngd_register() {
    ...
    match =3D of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
    data =3D match->data;

If the driver is bound via sysfs to a platform device that lacks a device
tree node, of_match_node() will return NULL. Should this use
of_device_get_match_data() or validate the match pointer before accessing
data?

> @@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device =
*parent,
>  			kfree(ngd);
>  			return ret;
>  		}
> -		ngd->pdev->dev.of_node =3D of_node_get(node);
> +		platform_device_set_of_node(ngd->pdev, node);
>  		ctrl->ngd =3D ngd;
> =20
>  		ret =3D platform_device_add(ngd->pdev);

[Severity: High]
This is a pre-existing issue, but does this dynamically allocated device
get leaked when unregistered?

Looking at qcom_slim_ngd_unregister() in drivers/slimbus/qcom-ngd-ctrl.c:

qcom_slim_ngd_unregister() {
    ...
    platform_device_del(ngd->pdev);
    ...
}

Since of_qcom_slim_ngd_register() allocates the device with
platform_device_alloc(), shouldn't platform_device_put() be called to drop
the initial reference count? Without it, both the device structure and the
device tree node reference acquired above are never freed during unbind.

[Severity: High]
This is a pre-existing issue, but is there a risk of a use-after-free
during module removal?

Looking at the driver teardown in qcom_slim_ngd_ctrl_remove():

drivers/slimbus/qcom-ngd-ctrl.c:qcom_slim_ngd_ctrl_remove() {
    ...
    qcom_slim_ngd_unregister(ctrl);

    destroy_workqueue(ctrl->mwq);
}

If qcom_slim_ngd_ssr_pdr_notify() has scheduled ctrl->ngd_up_work on the
system workqueue, can it execute after the devres-managed ctrl structure
is freed? Would adding cancel_work_sync(&ctrl->ngd_up_work) here ensure
the background task completes before the memory is released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D13
