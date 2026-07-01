Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA53C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4033910EDB0;
	Wed,  1 Jul 2026 06:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YEYMZFBl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A8B10EDF7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:35:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A765E600AB;
 Wed,  1 Jul 2026 06:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3443C1F00A3A;
 Wed,  1 Jul 2026 06:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782887750;
 bh=o0nnv3V+bzQKonUmJvSn9+f38La8rj/XYHnqsxmaZ+k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YEYMZFBl2v9MaGWbQL4d5HGXzcJqy+iWaCCxW/fqYQdBM7oqPM36JYGKHcSZ8M3VS
 b3xCoUjjwY9viIC3IP4ycr1/VceyDXXjeFWzVunIuITCINudfftBZp5U5bqKnI1b6A
 aTjqbqs3sNu0JAZiqYrf1/Z117Vss+UgVYglhk7QP6QlCZnrVFfaFbTO5Lolh2Xx79
 tlH8obrTHua5GsLxaxdj1T8o2StqTK8WdpMo/EF4YzBDyAwpmoZ9QhJ0FYfv6UUkSe
 P2sYHMD6/SS6icomYzej0TyfJPg0eR0yKiASQPB7yLS+ihuybuCaVM8Cmr7kn9KUng
 F+MIN9iRnz1GQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] accel/npac: Add NPAC client driver
To: "Jaspinder Budhal" <j-budhal@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701062505.1091840-3-j-budhal@ti.com>
References: <20260701062505.1091840-1-j-budhal@ti.com>
 <20260701062505.1091840-3-j-budhal@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:35:49 +0000
Message-Id: <20260701063550.3443C1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing DRM device removal protection (drm_dev_enter/exit) in IOCT=
L handlers leads to a Use-After-Free of the RPMsg endpoint.
- [High] A shared completion mechanism without transaction IDs causes delay=
ed hardware ACKs to falsely complete subsequent IOCTL requests.
- [High] Spurious or early RPMsg messages cause a NULL pointer dereference =
in `npac_cb` before `probe` completes.
- [High] The ADD and DELETE rule IOCTLs send identical payloads over RPMsg =
without any command identifier.
- [Medium] Implicit padding in the `npac_acl_offload_rule` UAPI structure l=
eaks uninitialized userspace memory to the remote processor and breaks ABI.
- [Medium] Driver ignores the remote processor's response content, incorrec=
tly assuming all ACKs indicate success.
- [Low] UAPI structs and IOCTL definitions are placed in the driver C file =
instead of a dedicated UAPI header.
--

commit f09e8a02272732ea035f9ef6c3a3f177ff86129a
Author: Jaspinder Budhal <j-budhal@ti.com>

accel/npac: Add NPAC client driver

This commit adds the Linux client driver for the Network Packet ACcelerator
(NPAC). The driver communicates with the NPAC host driver via RPMsg to
offload ethernet-related packet processing tasks, providing an IOCTL
interface for userspace ACL rule management.

> diff --git a/drivers/accel/npac/npac_drv.c b/drivers/accel/npac/npac_drv.c
> new file mode 100644
> index 0000000000000..7516382ba74b6
> --- /dev/null
> +++ b/drivers/accel/npac/npac_drv.c
[ ... ]
> +struct npac_acl_offload_rule {
> +	__u32 match_type;
> +	__u32 verdict;
> +	__u8  match_value[NPAC_ACL_MATCH_VALUE_MAX];
> +};

[Severity: Medium]
Does this structure have an implicit 2-byte padding at the end due to the
__u32 alignment?

If so, the DRM IOCTL copy_from_user() path could copy uninitialized memory
from userspace, leaking it to the remote processor. Should explicit padding
(e.g., __u8 reserved[2]) be added to stabilize the ABI?

[Severity: High]
How does the hardware differentiate between ADD and DELETE commands?

Since both IOCTLs send this exact same payload, the remote processor receiv=
es
an identical byte sequence without an opcode or command identifier.

> +#define DRM_IOCTL_NPAC_ACL_ADD_RULE \
> +	DRM_IOWR(DRM_COMMAND_BASE + NPAC_ACL_ADD_RULE, struct npac_acl_offload_=
rule)
> +
> +#define DRM_IOCTL_NPAC_ACL_DELETE_RULE \
> +	DRM_IOWR(DRM_COMMAND_BASE + NPAC_ACL_DELETE_RULE, struct npac_acl_offlo=
ad_rule)

[Severity: Low]
Should these UAPI structures and IOCTL definitions be placed in a dedicated
UAPI header (e.g., include/uapi/drm/npac_drm.h) instead of being hidden in
the driver source?

[ ... ]
> +static int npac_add_rule_ioctl(struct drm_device *dev, void *data,
> +			       struct drm_file *file)
> +{
> +	struct npac_device *npac =3D drm_to_npac_device(dev);
> +	struct npac_acl_offload_rule *rule =3D data;
> +	int ret;
> +
> +	dev_dbg(dev->dev, "add rule ioctl received\n");
> +
> +	mutex_lock(&npac->req_lock);
> +	reinit_completion(&npac->ack);
> +	ret =3D rpmsg_send(npac->rpdev->ept, rule, sizeof(*rule));

[Severity: High]
Can this result in a use-after-free if the RPMsg device is unbound while
the IOCTL is executing?

Since the execution isn't protected by drm_dev_enter() and drm_dev_exit(),
drm_dev_unplug() can return immediately and the RPMsg endpoint could be
destroyed while rpmsg_send() is still accessing it.

> +	if (ret) {
> +		dev_err(dev->dev, "rpmsg_send failed: %d\n", ret);
> +		mutex_unlock(&npac->req_lock);
> +		return ret;
> +	}
> +	if (!wait_for_completion_timeout(&npac->ack,
> +					 msecs_to_jiffies(NPAC_ACK_TIMEOUT_MS))) {

[Severity: High]
If this wait times out, the firmware might still be processing the command
and send an ACK later.

If a subsequent IOCTL acquires req_lock and calls reinit_completion(),
could a delayed ACK from the first request cause the second IOCTL to falsely
return success before its actual request is processed? Should there be a
transaction ID to match ACKs to specific requests?

[ ... ]
> +static int npac_cb(struct rpmsg_device *rpdev, void *data, int len,
> +		   void *priv, u32 src)
> +{
> +	struct npac_device *npac =3D dev_get_drvdata(&rpdev->dev);
> +
> +	dev_dbg(&rpdev->dev, "ack received\n");
> +	complete(&npac->ack);

[Severity: High]
Is it possible for dev_get_drvdata() to return NULL here?

If a message arrives on the RPMsg bus before dev_set_drvdata() is called
during npac_probe(), this will result in a NULL pointer dereference.

[Severity: Medium]
Does the remote processor ever send status or error codes in the payload if
a rule is rejected (e.g., if the hardware rule table is full)?

The data and len parameters are completely ignored here, which might cause
userspace to believe a rule was successfully offloaded when the hardware
actually rejected it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701062505.1091=
840-1-j-budhal@ti.com?part=3D2
