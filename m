Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DC606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsWEU2Il
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C9810F2FB;
	Mon,  9 Nov 2026 14:35:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC65210F2FB;
 Mon,  9 Nov 2026 14:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4BEE63366;
 Mon,  9 Nov 2026 14:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0DC1F008A1;
 Mon,  9 Nov 2026 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234932;
 bh=YOOe7Kh928MF/9g/e+ebiKeOOvxwkJVdEZAugjwpAZs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lsWEU2IlJ1ALU1vGcQYcSWNE7p0l9q78fBtNerMYRKriy6W2U//bLK3Nt+NEj8N6H
 vYJSKMWAkBA+D7JMsWxsHFrTfozabc+wMHBNEsf/ZJm7FNn4xWVQEHXV4USOvn5nZa
 pA+P7IpqLMwyf844OdtJVhAgGzOhLpEZwHN5dOmKuuL+xPI7I94/m5sOdmlTHj+ICm
 2V0gzSBrn7f/ljLzjPdrTEnfJiPmkYYvT5Y4YQG+qmP9+WW6+gb7tStHmXT+QQB7/Z
 qWXcFy1epGPnZPLnFQjkUWbOA4OITrWwohHKYn+XDIMPKpvcXh2t8onLthnlUsgAhM
 +p4nnx2GXemEg==
Message-ID: <sashiko-outbox-205119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/20] drm/xe/eudebug: Introduce EU control interface
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-18-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-18-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:35:31 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/xe/eudebug: missing wedged and unplug guards in
  do_eu_control()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/xe/oa: unbalanced de-whitelisting in
  xe_oa_stream_open_ioctl_locked() [1]
--

commit c12aefb410d72e1670863e0bab5fd107ad1622e4
Author: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

drm/xe/eudebug: Introduce EU control interface

This commit adds the DRM_XE_EUDEBUG_IOCTL_EU_CONTROL ioctl to let an EU
debugger interrupt, query, and resume EU threads on debuggable execution
queues, and makes eudebug and OA streams mutually exclusive.

> diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.c b/drivers/gpu/drm/xe/xe_e=
udebug_hw.c
> index 7388facfe0a5d..3c025f279488f 100644
> --- a/drivers/gpu/drm/xe/xe_eudebug_hw.c
> +++ b/drivers/gpu/drm/xe/xe_eudebug_hw.c
[ ... ]
> +static int do_eu_control(struct xe_eudebug *d,
> +			 const struct drm_xe_eudebug_eu_control * const arg,
> +			 struct drm_xe_eudebug_eu_control __user * const user_ptr)
> +{
[ ... ]
> +	lrc =3D xe_eudebug_find_lrc(d, arg->lrc_handle);
> +	if (XE_IOCTL_DBG(xe, !lrc)) {
> +		ret =3D -EINVAL;
> +		goto queue_put;
> +	}
> +
> +	if (!xe_pm_runtime_get_if_active(xe)) {
> +		ret =3D -EIO;
> +		goto queue_put;
> +	}
> +
> +	active =3D xe_gt_runalone_active_queue_get(q->gt, &active_hwe, &lrc_idx=
);
> +	if (XE_IOCTL_DBG(xe, IS_ERR(active))) {
> +		ret =3D PTR_ERR(active);
> +		goto out_pm;
> +	}

[Severity: Medium]
Can do_eu_control() race with PCI device unbind or run on a wedged device
to dereference a NULL hwe->gt or access unmapped MMIO registers?

Unlike DRM character device ioctls, DRM_XE_EUDEBUG_IOCTL_EU_CONTROL is
dispatched directly on the anonymous [xe_eudebug] file, which holds a
drm_dev_get() reference that keeps struct xe_device alive after PCI
unbind.  xe_pm_runtime_get_if_active(xe) does not stop callers during or
after unbind because xe_pm_runtime_fini() calls pm_runtime_get_sync() and
pm_runtime_forbid(), leaving runtime PM active while devres tears down
the device:

CPU0                                  CPU1
do_eu_control()
  xe_pm_runtime_get_if_active(xe)
  ...
  memdup_user() / usleep_range()
                                      xe_pci_remove()
                                        drm_dev_unplug(&xe->drm)
                                        ...
                                        devres_release_all()
                                          hw_engine_fini()
                                            hwe->gt =3D NULL
                                          pcim_iomap_release()
  check_lrc_active(active_hwe, lrc)
    read_hw_lrca(hwe, &lrc_hw)
      gt_to_fw(hwe->gt)  <-- NULL pointer dereference

If hwe->gt is instead cleared during get_runalone_active_hw_engine(),
engine_status() dereferences hwe->gt as well, and after mmio_fini() clears
xe->mmio.regs, MMIO accesses trigger device warnings.  Sibling anonymous
fd callbacks in drivers/gpu/drm/xe/xe_eudebug_vm.c guard against both
cases via vm_file_enter(), which checks xe_wedged(xe) and wraps hardware
accesses in drm_dev_enter() / drm_dev_exit().

> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index fe91abaccb14a..52b3f342344a3 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
[ ... ]
> @@ -1880,6 +1914,21 @@ static int xe_oa_stream_open_ioctl_locked(struct x=
e_oa *oa,
>  		goto exit;
>  	}
> =20
> +	/*
> +	 * eudebug and OA both change EU and engine state that the other
> +	 * relies on, such as the debug registers and workarounds eudebug
> +	 * keeps in hwe->reg_sr and the settings OA changes and restores
> +	 * around a stream. They do not have to run at the same time, so
> +	 * refuse rather than interleave. xe_eudebug_enable() checks the
> +	 * other direction with xe_oa_stream_active(), under the same
> +	 * gt_lock held here.
> +	 */
> +	if (xe_eudebug_is_enabled_oa(param->hwe->gt)) {
> +		drm_dbg(&oa->xe->drm, "OA not available while eudebug is enabled\n");
> +		ret =3D -EBUSY;
> +		goto exit;
> +	}

[Severity: High]
This problem wasn't introduced by this patch, but can
xe_oa_stream_open_ioctl_locked() cause an unbalanced
xe_reg_dewhitelist_oa_regs() call [1] when opening a stream with
DRM_XE_OA_PROPERTY_SAMPLE_OA fails?

xe_oa_stream_init() sets stream->sample =3D param->sample, but
xe_reg_whitelist_oa_regs() is only called after xe_oa_enable_locked() and
anon_inode_getfd() both succeed:

drivers/gpu/drm/xe/xe_oa.c:xe_oa_stream_open_ioctl_locked() {
    ...
	if (!param->disabled) {
		ret =3D xe_oa_enable_locked(stream);
		if (ret)
			goto err_destroy;
	}

	stream_fd =3D anon_inode_getfd("[xe_oa]", &xe_oa_fops, stream, 0);
	if (stream_fd < 0) {
		ret =3D stream_fd;
		goto err_disable;
	}

	if (stream->sample)
		xe_reg_whitelist_oa_regs(stream->gt);
    ...
err_disable:
	if (!param->disabled)
		xe_oa_disable_locked(stream);
err_destroy:
	xe_oa_stream_destroy(stream);
    ...
}

If anon_inode_getfd() fails (for example with -EMFILE) or
xe_oa_enable_locked() fails, xe_oa_stream_destroy() sees stream->sample
set and calls xe_reg_dewhitelist_oa_regs(stream->gt) without a matching
xe_reg_whitelist_oa_regs().  That triggers xe_assert() and underflows
gt->oa.whitelist_count from 0 to U32_MAX (or drops another active OA
unit's whitelist reference on the same GT).

[1] https://sashiko.dev/#/bug/linux-44e618e3-ff9f-4811-9ea1-86af519616cc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D17
