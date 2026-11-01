Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B2606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxUpu1vz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5D510EAE6;
	Sun,  1 Nov 2026 23:01:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D388810EAD8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:00:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A30EB423E3;
 Sun,  1 Nov 2026 23:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E05C1F000C1;
 Sun,  1 Nov 2026 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574053;
 bh=u128ibxXssPCcaU9QjuSC4lZcHuE4j9UdtyH2g3r7OY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IxUpu1vzwz+pWe56xRB/gHrv9ezAlNmQz4+IElzZM3mel680uRkMDl5xAaNQsQx1f
 xPXFBoXJAvgkgIiT0rwS0w7vSJEY3UYGTO/u6RK1wkWFuLpj6VFqEIy71Zb/pt3ocf
 hhy1n7L2abzgaNm3NvhwVXAFEyK77C7xF5wBuIjXNvst8ZruPYb0ST0vo7QD1SZXNW
 Yf0zn8vMygbOCWaUfJTaQZKiqKpR3YDkWyvARXdd6/uG/RqN4kx7pbDdre8n9Xst2l
 iuuXJsIlXrugqhboUeXR78Ys4BZwHapMNmzHbP6UuKJuuI5Omqn9alx+j9zJ6ND7mz
 6rmbegZIBaiwg==
Message-ID: <sashiko-outbox-192748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/25] accel/qda: Add Audio protection domain attach
 and its remote heap
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-21-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-21-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:00:52 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] accel/qda: race between qda_attach_audio_pd() and qda_rpmsg_remove=
()
- [High] accel/qda: unallocated CMA memory hyp-assigned in qda_init_remote_=
heap()
- [Medium] accel/qda: signal in qda_attach_audio_pd() desyncs audio_init_me=
m state
- [Medium] accel/qda: 32-bit BIT() overflow and unvalidated VMIDs in remote=
 heap setup
- [Low] accel/qda: qda_attach_audio_pd() mixes goto cleanup with scoped_gua=
rd()
- [Low] accel/qda: missing mutex_destroy() for remote_heap_lock on device t=
eardown
--

commit cd6c4ef6e7fc95f52a56e49a2e18e2d259cf294c
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add Audio protection domain attach and its remote heap

This commit adds support for attaching to the static Audio protection domain
by name via QDA_ATTACH_AUDIO_PD and hands the DSP its reserved remote heap
memory region on the first attach. At probe time, it parses the qcom,vmids
property and reserved-memory region and uses qcom_scm_assign_mem() to share
the heap with the DSP VMs until the rpmsg device is removed.

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 9b8cccfea1e3a..41234fc576a9a 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c

[ ... ]

> @@ -176,6 +177,54 @@ int qda_release_dsp_process(struct qda_dev *qdev, st=
ruct qda_session *session)
>  	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_RELEASE, NULL, session);
>  }
> =20
> +/*
> + * The Audio PD keeps the remote heap across daemon restarts, so only th=
e first
> + * attach on a device hands it to the DSP. The lock is held across the a=
ttach
> + * so that a concurrent one cannot skip the heap while the first is stil=
l in
> + * flight, and the flag is set only once the DSP has accepted it.
> + */
> +static int qda_attach_audio_pd(struct qda_session *session, struct drm_q=
da_remote_attach *args)
> +{
> +	struct qda_dev *qdev =3D session->qda_dev;
> +	struct qda_static_pd_args sargs =3D {};
> +	char *name;
> +	int err;
> +
> +	if (strcmp(qdev->dsp_name, "adsp") || !qdev->remote_heap_size)
> +		return -ENODEV;
> +
> +	if (!args->namelen || args->namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
> +		return -EINVAL;
> +
> +	name =3D memdup_user(u64_to_user_ptr(args->name), args->namelen);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +
> +	if (name[args->namelen - 1]) {
> +		err =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	sargs.name =3D name;
> +	sargs.namelen =3D args->namelen;
> +
> +	scoped_guard(mutex, &qdev->remote_heap_lock) {
> +		if (!qdev->audio_init_mem) {
> +			sargs.heap.addr =3D qdev->remote_heap_addr;
> +			sargs.heap.size =3D qdev->remote_heap_size;
> +		}
> +
> +		err =3D qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE_STATIC, &sargs=
, session);
> +		if (!err && sargs.heap.size)
> +			qdev->audio_init_mem =3D true;
> +	}

[Severity: Medium]
What happens if the calling task receives a signal while waiting for the DSP
response in qda_attach_audio_pd()?

The call chain:

  qda_attach_audio_pd()
    qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE_STATIC, &sargs, session)
      qda_fastrpc_invoke_common()
        qda_rpmsg_send_msg()
        qda_rpmsg_wait_for_rsp()
          wait_for_completion_interruptible(&ctx->work)

waits interruptibly after the QDA_FASTRPC_RMID_INIT_CREATE_STATIC message
carrying sargs.heap has already been transmitted to the DSP.

If a signal arrives before the DSP replies, qda_fastrpc_invoke() returns
-ERESTARTSYS while the DSP continues processing the remote heap
initialization. Because err is non-zero, qdev->audio_init_mem remains false
and qdev->remote_heap_lock is released, allowing a restarted syscall or a
concurrent caller to observe !qdev->audio_init_mem and hand the remote heap
to the DSP a second time while the first attach is still in flight or after
the DSP has already accepted it.

> +
> +out_free:
> +	kfree(name);
> +
> +	return err;
> +}

[Severity: Low]
This isn't a bug, but qda_attach_audio_pd() mixes goto out_free error
handling for name with scoped_guard(mutex, &qdev->remote_heap_lock) in the
same function.

Could name be declared with __free(kfree) so that the NUL-termination check
can return -EINVAL directly without mixing goto cleanup and scope-based
cleanup helpers?

> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 7e58df3eb2e17..b93e906b57930 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c

[ ... ]

> @@ -145,6 +147,81 @@ static int qda_rpmsg_cb(struct rpmsg_device *rpdev, =
void *data, int len,
>  	return ret;
>  }
> =20
> +static int qda_init_vmperms(struct qda_dev *qdev)
> +{
> +	u32 vmids[QDA_MAX_VMIDS];
> +	int vmcount, i;
> +
> +	vmcount =3D of_property_read_variable_u32_array(qdev->dev->of_node, "qc=
om,vmids",
> +						      vmids, 0, QDA_MAX_VMIDS);
> +	if (vmcount =3D=3D -EINVAL || vmcount =3D=3D -ENODATA)
> +		return 0;
> +	if (vmcount < 0)
> +		return vmcount;
> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
> +	for (i =3D 0; i < vmcount; i++) {
> +		qdev->vmperms[i].vmid =3D vmids[i];
> +		qdev->vmperms[i].perm =3D QCOM_SCM_PERM_RWX;
> +	}
> +	qdev->vmcount =3D vmcount;
> +
> +	return 0;
> +}
> +
> +/*
> + * The region is optional: without it an Audio PD attach is refused. It =
is
> + * recorded only once it has been assigned, so teardown hands back exact=
ly
> + * what was handed over.
> + */
> +static int qda_init_remote_heap(struct qda_dev *qdev)
> +{
> +	u64 src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> +	struct resource res;
> +	int ret;
> +
> +	if (strcmp(qdev->dsp_name, "adsp") && strcmp(qdev->dsp_name, "sdsp"))
> +		return 0;
> +
> +	if (of_reserved_mem_region_to_resource(qdev->dev->of_node, 0, &res))
> +		return 0;
> +
> +	if (qdev->vmcount) {
> +		ret =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> +					  qdev->vmperms, qdev->vmcount);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	qdev->remote_heap_addr =3D res.start;
> +	qdev->remote_heap_size =3D resource_size(&res);
> +
> +	return 0;
> +}

[Severity: High]
Can qda_init_remote_heap() hyp-assign memory away from HLOS without first
allocating it from CMA?

In the Qualcomm FastRPC device tree bindings and upstream SoC device trees,
the ADSP remote heap memory-region (adsp_rpc_remote_heap_mem) is defined as=
 a
reusable shared-dma-pool without no-map. For a reusable CMA region, those
pages remain in the Linux page allocator for movable HLOS allocations until
allocated via CMA or DMA APIs.

Taking the raw physical range from of_reserved_mem_region_to_resource() in
qda_init_remote_heap() and revoking QCOM_SCM_VMID_HLOS access via
qcom_scm_assign_mem() without allocating the pages first leaves active or
future movable HLOS pages inside that range, which will trigger stage-2
permission faults when accessed by the CPU and corrupt memory when used by
the ADSP.

> +
> +static void qda_deinit_remote_heap(struct qda_dev *qdev)
> +{
> +	struct qcom_scm_vmperm dst_perms =3D {
> +		.vmid =3D QCOM_SCM_VMID_HLOS,
> +		.perm =3D QCOM_SCM_PERM_RWX,
> +	};
> +	u64 src_perms =3D 0;
> +	int ret, i;
> +
> +	if (!qdev->remote_heap_size || !qdev->vmcount)
> +		return;
> +
> +	for (i =3D 0; i < qdev->vmcount; i++)
> +		src_perms |=3D BIT(qdev->vmperms[i].vmid);

[Severity: Medium]
Could BIT(qdev->vmperms[i].vmid) overflow a 32-bit unsigned long or shift p=
ast
63?

In qda_deinit_remote_heap() (and in qda_init_remote_heap() when initializing
src_perms), BIT() uses 1UL << nr, whereas src_perms is a u64 and ADSP remote
heap VMIDs such as QCOM_SCM_VMID_ADSP_HEAP (0x25) or
QCOM_SCM_VMID_CP_ADSP_SHARED (0x33) exceed 31. On 32-bit builds (allowed via
ARCH_QCOM || COMPILE_TEST), shifting 1UL by 37 or 51 is undefined behavior =
and
fails to populate the upper 32 bits of src_perms.

In addition, qda_init_vmperms() copies u32 values from the qcom,vmids prope=
rty
without checking that each vmid is less than BITS_PER_TYPE(u64). Should
qda_init_remote_heap() and qda_deinit_remote_heap() use BIT_ULL(), and shou=
ld
qda_init_vmperms() reject VMIDs >=3D BITS_PER_TYPE(u64)?

> +
> +	ret =3D qcom_scm_assign_mem(qdev->remote_heap_addr, qdev->remote_heap_s=
ize,
> +				  &src_perms, &dst_perms, 1);
> +	if (ret)
> +		dev_err(qdev->dev, "Failed to assign remote heap back to HLOS: %d\n", =
ret);
> +}
> +
>  static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct qda_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
> @@ -163,6 +240,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpd=
ev)
>  	qda_fastrpc_flush_pending(qdev);
>  	qda_cb_unpopulate(qdev);
>  	qda_deinit_device(qdev);
> +	qda_deinit_remote_heap(qdev);
>  }

[Severity: High]
Can qda_attach_audio_pd() race with qda_rpmsg_remove() and access destroyed
device state after teardown?

If thread A is inside qda_attach_audio_pd() holding qdev->remote_heap_lock
while waiting for the DSP response, a concurrent thread B calling
qda_ioctl_attach() -> qda_attach_audio_pd() can already be blocked waiting =
to
acquire qdev->remote_heap_lock before allocating an invoke context in
qdev->ctx_xa.

When qda_rpmsg_remove() runs:

  qda_rpmsg_remove()
    drm_dev_unplug(&qdev->drm_dev)
    qdev->rpdev =3D NULL
    qda_fastrpc_flush_pending(qdev)
    qda_cb_unpopulate(qdev)
    qda_deinit_device(qdev)
    qda_deinit_remote_heap(qdev)

drm_dev_unplug() does not wait for threads already inside drm_ioctl(), and
qda_fastrpc_flush_pending() only wakes thread A. While thread A releases
qdev->remote_heap_lock and thread B acquires it, qda_rpmsg_remove() proceeds
to destroy the context bank platform devices in qda_cb_unpopulate() and free
qdev->iommu_mgr and destroy qdev->ctx_xa in qda_deinit_device().

Thread B then calls qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE_STATIC,
...) without checking whether the device was unplugged, executing
qda_fastrpc_context_alloc() on the destroyed qdev->ctx_xa and
qda_fastrpc_prepare_args_create_static() -> alloc_kernel_gem() ->
qda_gem_create_object() -> qda_memory_manager_alloc() on the destroyed
iommu_mgr and freed context bank device before reaching the drm_dev_enter()
check in qda_rpmsg_send_msg().

> @@ -195,10 +273,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpd=
ev)
>  		return ret;
>  	}
> =20
> -	ret =3D qda_init_device(qdev, qda_count_cb_nodes(rpdev->dev.of_node));
> +	mutex_init(&qdev->remote_heap_lock);

[Severity: Low]
Unlike qdev->import_lock, which is initialized in qda_alloc_device() and
destroyed in qda_deinit_device(), qdev->remote_heap_lock is initialized here
in qda_rpmsg_probe() and never passed to mutex_destroy() on probe failure or
in qda_deinit_device(). Should remote_heap_lock be initialized and destroyed
alongside import_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D21
