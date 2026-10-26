Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53107606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3VfAF+x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0C610EDB8;
	Mon, 26 Oct 2026 10:36:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAD810EDB8
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 893C66024D;
 Mon, 26 Oct 2026 10:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E71F01825;
 Mon, 26 Oct 2026 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793010972;
 bh=STJFY5uepGGU4EuEuJ76i8LoEoAmDq7Qk1SNuvMOdrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z3VfAF+xBy8zTAFynFFuaeyR7ZhrZ0LaBmgldgTMNjkRvAss0zzAu8AnF1A3oOYT6
 MFiK6D+8RDHUtPSWzvFRmAdKP5M6TP5U/K68wfgpMDnF+cmBtvYL7ijVWTPPexHbFK
 0oeRj4c2/i+VOfw5C9iaNMfmYiqmAksLs65UhLlCoCcK+suJ03GRvWD8FkKCsrRhI5
 L0WD2t69xv2gk2HlD3+3UeHx6zG5ELwfRcUan27b7AdGzSpzyLAkREfYlPwAHevmjV
 2h/7DXottY6cAr6WCykeyQAp8J4HXxExAoZ3vHkBMla9BbL9bF8VPaa15gx3EXbuPq
 3Jd3PQzP2/lOg==
Message-ID: <sashiko-outbox-184968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/23] drm/msm/dcp: Add IPCC power notifications
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-8-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-8-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:36:11 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm/dcp: unsynchronized resp_vq kick in dcp_ipcc_handle_rx()
- [Medium] drm/msm/dcp: dcp_ipcc_send_power_notify() misuses mbox_client_tx=
done()
- [Low] drm/msm/dcp: missing MAILBOX dependency in Kconfig causes link fail=
ure
--

commit 847d1e1e504619e829df644d8cb1af09e3cef49c
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add IPCC power notifications

This commit adds an inter-processor communication controller mailbox client
to wake and acknowledge display coprocessor firmware during power transitio=
ns.
It implements serialized notifications, bounded acknowledgment waits, wake
interrupt handling, and callback lifetime management.

> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56c48fe2e2c5f..9c698c4f49495 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -73,6 +73,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) +=3D \
> =20
>  msm-display-$(CONFIG_DRM_MSM_DCP) +=3D \
>  	dcp/dcp_hfi_core.o \
> +	dcp/dcp_ipcc.o \

[Severity: Low]
Will this cause a link failure when the mailbox framework is disabled?

In drivers/gpu/drm/msm/Makefile, dcp/dcp_ipcc.o is built unconditionally
whenever the display coprocessor option is enabled, and dcp_ipcc_init(),
dcp_ipcc_free_channel(), and dcp_ipcc_send_power_notify() call
mbox_request_channel(), mbox_free_channel(), mbox_send_message(), and
mbox_client_txdone().

However, include/linux/mailbox_client.h does not provide inline stubs when
mailbox support is disabled, and drivers/gpu/drm/msm/Kconfig only lists:

config DRM_MSM_DCP
	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
	depends on DRM_MSM
	depends on VIRTIO

Should the Kconfig entry also depend on or select the mailbox subsystem?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.c b/drivers/gpu/drm/msm/dcp=
/dcp_ipcc.c
> new file mode 100644
> index 0000000000000..e161939dddc1e
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
> @@ -0,0 +1,173 @@

[ ... ]

> +static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		return;
> +	}
> +
> +	complete(&ipcc->power_notify_done);
> +	if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
> +		virtqueue_notify(ipcc->resp_vq);
> +
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}

[Severity: High]
Can calling virtqueue_kick_prepare(ipcc->resp_vq) here under only
ipcc->state_lock race with concurrent response virtqueue operations?

In drivers/gpu/drm/msm/dcp/dcp_hfi_core.c, operations on the same response
virtqueue in dcp_hfi_resp_callback(), dcp_hfi_resp_repost_work(), and
dcp_hfi_quiesce_queues() are serialized under hfi->resp_drain_lock:

drivers/gpu/drm/msm/dcp/dcp_hfi_core.c:dcp_hfi_resp_callback() {
    ...
repost:
			spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
			dcp_hfi_buf_init_sg(buf, DCP_HFI_BUF_SIZE);
			if (virtqueue_add_inbuf_premapped(vq, &buf->sg, 1, buf,
							  NULL, GFP_ATOMIC)) {
				list_add_tail(&buf->node, &hfi->resp_repost_list);
				schedule_delayed_work(&hfi->resp_repost_work,
						      msecs_to_jiffies(20));
			}
		}

		if (virtqueue_kick_prepare(vq))
			virtqueue_notify(vq);
}

Because virtqueue_kick_prepare() requires external serialization with other
operations on the same virtqueue and updates vq->num_added and vq->in_use,
running dcp_ipcc_handle_rx() from dcp_ipcc_rx_callback() or
dcp_ipcc_power_notify_irq() without holding hfi->resp_drain_lock can corrupt
vq->num_added kick tracking or trigger a virtio ring in_use check failure.

In addition, complete(&ipcc->power_notify_done) runs before
virtqueue_notify(ipcc->resp_vq), waking waiters in
dcp_ipcc_send_power_notify() before the response virtqueue notification has
been sent.

[ ... ]

> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long timeout;
> +	int ret;
> +
> +	mutex_lock(&ipcc->power_notify_lock);
> +
> +	reinit_completion(&ipcc->power_notify_done);
> +
> +	ret =3D mbox_send_message(ipcc->power_chan, NULL);
> +	mbox_client_txdone(ipcc->power_chan, ret);
> +	if (ret < 0) {
> +		dev_err(ipcc->client.dev,
> +			"IPCC TX: power notify failed: %d\n", ret);
> +		goto out_unlock;
> +	}

[Severity: Medium]
Should mbox_client_txdone() only be called with 0 after verifying that
mbox_send_message() succeeded?

When mbox_send_message() fails (ret < 0), no message was queued for this
request, yet calling mbox_client_txdone(ipcc->power_chan, ret) before the
error check still invokes tx_tick(chan, ret) on the mailbox channel (and wo=
uld
dereference a null pointer if ipcc->power_chan were null).

Furthermore, when mbox_send_message() succeeds in non-blocking mode
(ipcc->client.tx_block =3D false), it returns the non-negative ring buffer =
slot
index from add_to_rbuf(), whereas mbox_client_txdone() expects 0 on success=
 or
a negative errno on failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D8
