Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD69C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9170E10E1CE;
	Tue, 30 Jun 2026 09:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UmftQUbQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8464610E1CE
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:36:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B14E439FB;
 Tue, 30 Jun 2026 09:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049001F000E9;
 Tue, 30 Jun 2026 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782812216;
 bh=v3C0SwiZaUiR/NApuHG42b3IyvAJ/RsWPP+dPxE0lqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UmftQUbQ6CnBXVF9pRXLap2t85ocyhfSG8LmsZciHSqHRtw8sYvbFPpm/r0F2NmgF
 vZr68wt20zUVbf1AO1D020HQXLoq3RPUHWqWbeUYLuOC1Qqx9q1uaJn3AX3aT/RiRs
 WpIXhkXPVcNwy+BzWeZngEogpFHI7ng6C2DW9zPEkmtKShti7KAzePGB9qA6CwXbub
 yPi7W1k8C1I1LvdkvpIyy41sLXmPA8aX05Ik3UTbJHSEdBWL2R/ha0z8wDUVdF8Z71
 S8zVUNYT5rkJoKaNS+qYSEa3DKK5ZFLj2XZL9qC+q7LXyAKFMlW9jbXTSeereQGx7T
 QVuDLVhwTXD7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com>
References: <20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:36:55 +0000
Message-Id: <20260630093656.049001F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Flawed driver teardown order allows work items (including the newl=
y added `hotplug_work`) to be re-queued and executed after the device struc=
ture and virtqueues are freed.
--

commit 81a0fe4ee345c5c5f16f0048bb1284a83aa82e58
Author: Ryosuke Yasuoka <ryasuoka@redhat.com>

drm/virtio: defer hotplug event from dequeue worker to avoid deadlock
   =20
A probe-time deadlock can occur between the dequeue worker and
drm_client_register(). This patch defers the hotplug notification from
virtio_gpu_cmd_get_display_info_cb() to a separate work item to prevent
this deadlock.

Link: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45c1c6e=
549453f224
Link: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7baf376=
cc873a922e

> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virti=
o/virtgpu_kms.c
> index cfde9f573df6e..cfb532ba43a47 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
[ ... ]
> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	flush_work(&vgdev->obj_free_work);
>  	flush_work(&vgdev->ctrlq.dequeue_work);
>  	flush_work(&vgdev->cursorq.dequeue_work);
> +	flush_work(&vgdev->hotplug_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);

[Severity: High]
This is a pre-existing issue, but does this teardown sequence allow work it=
ems
to be re-queued after they are flushed?

Here in virtio_gpu_deinit(), the work items are flushed before the device is
reset via virtio_reset_device() and the virtqueues are deleted via del_vqs(=
).

Because the device is still active during the flush, if responses arrive for
shutdown commands (like those queued by drm_atomic_helper_shutdown()), the
interrupt handler can re-queue the work:

virtio_gpu_ctrl_ack()
  schedule_work(&vgdev->ctrlq.dequeue_work);

This re-queued dequeue_work can then execute after del_vqs() has freed the
virtqueues, leading to a use-after-free. Furthermore, it could schedule the
newly added hotplug_work:

virtio_gpu_cmd_get_display_info_cb()
  schedule_work(&vgdev->hotplug_work);

This would cause further use-after-free access on the freed vgdev structure.
Should the flush_work() calls be moved after virtio_reset_device() to ensure
no new interrupts can re-queue these work items?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-virtiogpu_=
syzbot-v1-1-0aa06630750e@redhat.com?part=3D1
