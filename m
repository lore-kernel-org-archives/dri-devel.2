Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B611CA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D0310E27C;
	Sat, 10 Oct 2026 17:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Co9NxxtO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD4F10E278
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:36:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 927B4602CA;
 Sat, 10 Oct 2026 17:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECBB1F000FF;
 Sat, 10 Oct 2026 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791653815;
 bh=F55AD4/ymcuo+n5X14BLdpRsN4JWih05ovGc1znBK9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Co9NxxtOha0mjKFw58QA8yYnem9ZN8BTp81PztiknxOBu6xEePlvNU0tRLIsRBp6B
 4CJZgaetuSaPSBX8XiJ+QxVYvMhAuDnMiLbV8r1DGzgSUksO7waNcXEuGntZYVObm3
 comM986boEIsWzMu7xcpICXQAcovWvq92zl07LIo9wyH5B49hB8hDuiT2Nc3bE+7cG
 Ebdja7SFUtXXFqdZer+aKmFfONZA7WaWX5Dov1J6ShDEb222DIBNbxuHa+NINKQaaD
 /Xavp99006MjmR0RMsfjcAVarGNQVk8Q2pdEa+FbakBexxst92htyTyI5vQ84L1Sc8
 3GSFcQewkcXYQ==
Message-ID: <sashiko-outbox-166782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009173152.2436195-4-zachary.mckevitt@oss.qualcomm.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:36:54 +0000
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
- [High] accel/qaic: NULL pointer dereference of qdev->tele_ch during telem=
etry requests
- [High] accel/qaic: Privilege escalation in qaic_telemetry_pre via mount n=
amespace bypass
- [High] accel/qaic: Missing cleanup in qaic_pci_probe error paths causes U=
AF and leaks
- [High] qaic: UAF of qdev in tele_wq due to mismatched devm and drmm lifec=
ycles
- [Medium] accel/qaic: Memory leak of drm_ras_node in qaic_drm_ras_register=
_node error path
- [Medium] accel/qaic: Misaligned DMA buffer embedded in struct wrapper_msg
- [Low] accel/qaic: Incompatible pointer type warning in qaic_telemetry_rea=
d/write
--

commit bade5a85b4c68c8d3389f9341f8bbf308ca4eee4
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

accel/qaic: Add callbacks for DRM RAS netlink telemetry
   =20
Use the DRM RAS netlink infrastructure to perform device telemetry.
During PCI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
type and add callbacks to telemetry_request for read and write operations.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index c1bb6db78d129..d2aed51052a66 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
[ ... ]
> @@ -443,6 +448,9 @@ static struct qaic_device *create_qdev(struct pci_dev=
 *pdev,
>  	qdev->ssr_wq =3D qaicm_wq_init(drm, "qaic_ssr");
>  	if (IS_ERR(qdev->ssr_wq))
>  		return NULL;
> +	qdev->tele_wq =3D qaicm_wq_init(drm, "qaic_tele");
> +	if (IS_ERR(qdev->tele_wq))
> +		return NULL;

[Severity: High]
Can this mismatched devm and drmm lifecycle lead to a use-after-free?

The qdev structure is allocated via devm_kzalloc() and is tied to the PCI
device lifecycle, getting freed immediately upon unbind. However, tele_wq
is tied to the DRM device lifecycle via drmm_add_action_or_reset().

If userspace holds the DRM file descriptor open during PCI device unbind,
the DRM device will outlive qdev. Any queued resp_worker() items running
on tele_wq will execute after qdev is freed and dereference it.

[ ... ]
> @@ -595,6 +604,10 @@ static int qaic_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D qaic_drm_ras_register_node(qdev);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
If qaic_drm_ras_register_node() fails here, we return an error directly
without calling qaic_destroy_drm_device(). Doesn't this leak the registered
DRM device?

Also, if qaic_mhi_register_controller() fails immediately after this, it
calls qaic_destroy_drm_device() but fails to call
qaic_drm_ras_unregister_node(). Since qdev is managed by devm_kzalloc and
will be freed by the driver core on probe failure, leaving the DRM RAS node
or DRM device registered with dangling pointers to the freed qdev will lead
to Use-After-Free crashes if userspace attempts to interact with them.

[Severity: High]
The telemetry node is exposed to userspace here before the MHI channel
is initialized on the next line.=20

In qaic_pci_remove(), the MHI controller is freed (which asynchronously
clears qdev->tele_ch =3D NULL) before the DRM RAS node is unregistered.

Concurrent netlink requests from userspace during either of these windows
will trigger a NULL pointer dereference in mhi_queue_buf(), causing a
kernel oops, because qdev->tele_ch is accessed unconditionally in
telemetry_request().

>  	qdev->mhi_cntrl =3D qaic_mhi_register_controller(pdev, qdev->bar_mhi, m=
hi_irq,
>  						       qdev->single_msi, config->family);
[ ... ]
> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qai=
c_telemetry.c
> new file mode 100644
> index 0000000000000..dbfb36cf319ce
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
[ ... ]
> +int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_type, s64=
 *val)
> +{
[ ... ]
> +	kref_get(&wrapper->ref_count);
> +	ret =3D mhi_queue_buf(qdev->tele_ch, DMA_TO_DEVICE, req, sizeof(*req), =
MHI_EOT);

[Severity: Medium]
Is it safe to pass this embedded buffer to the DMA engine?

The req buffer is a pointer to wrapper->msg, which is embedded inside
struct wrapper_msg immediately after struct kref ref_count (4 bytes).
This means the req buffer starts at a 4-byte offset from the kzalloc
allocation, sharing its cacheline with the kref.

Passing unaligned buffers to the DMA mapping API violates architecture DMA
requirements and can cause cacheline tearing and memory corruption on
non-cache-coherent architectures.

> +	if (ret) {
[ ... ]
> +static int qaic_telemetry_pre(struct drm_ras_node *ep)
> +{
> +	struct qaic_device *qdev =3D ep->priv;
> +	struct inode *dev_inode;
> +	struct path path;
> +	char devpath[24];
> +	int ret;
> +
> +	snprintf(devpath, sizeof(devpath), "/dev/accel/%s", to_accel_kdev(qdev-=
>qddev)->kobj.name);
> +	ret =3D kern_path(devpath, LOOKUP_FOLLOW, &path);
> +	if (ret)
> +		return -EINVAL;
> +
> +	dev_inode =3D d_inode(path.dentry);
> +	ret =3D inode_permission(&nop_mnt_idmap, dev_inode, MAY_READ | MAY_WRIT=
E);

[Severity: High]
Does this regression introduce a privilege escalation vector by relying on
the caller's mount namespace for security enforcement?

kern_path() resolves paths relative to the caller's root and mount
namespace. An unprivileged attacker could use unshare to create a new
mount namespace, mount a tmpfs over /dev/accel, and create a fake
device node with 0777 permissions.

When the attacker sends a netlink request, kern_path() would resolve to
their fake file, passing the inode_permission() check and granting
unauthorized execution of privileged telemetry commands.

> +	path_put(&path);
> +
> +	return ret;
> +}
> +
> +static int qaic_telemetry_read(struct drm_ras_node *ep, u32 *field, u64 =
*value, s32 *status)
> +{
> +	struct qaic_device *qdev =3D ep->priv;
> +
> +	*status =3D (s32)telemetry_request(qdev, *field, TYPE_READ, value);

[Severity: Low]
Will this implicit cast between signed and unsigned pointer types trigger
-Wincompatible-pointer-types warnings and break builds with -Werror?

qaic_telemetry_read() receives a u64 *value parameter from the DRM RAS
API, but it passes it directly to telemetry_request(), which takes an
s64 *val parameter.

> +
> +	return *status;
> +}
[ ... ]
> +int qaic_drm_ras_register_node(struct qaic_device *qdev)
> +{
> +	struct drm_ras_node *node;
[ ... ]
> +	ret =3D drm_ras_node_register(node);
> +	if (ret) {
> +		kfree(device_name);
> +		kfree(node_name);
> +		kfree(qdev->ras_node);

[Severity: Medium]
Should this be kfree(node) instead?

qdev->ras_node is not assigned until the end of the function, so it is
NULL at this point. kfree(NULL) is a no-op, which means the node
allocation is permanently leaked on this error path.

> +		return ret;
> +	}
> +
> +	qdev->ras_node =3D node;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009173152.2436=
195-1-zachary.mckevitt@oss.qualcomm.com?part=3D3
