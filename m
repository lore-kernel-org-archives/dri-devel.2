Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C07606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=av79QFhS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535CD10E05F;
	Thu, 26 Nov 2026 06:51:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F17889A5C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:51:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 373BE410A8;
 Thu, 26 Nov 2026 06:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A577B1F000F2;
 Thu, 26 Nov 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675905;
 bh=SHVnbB74xJyXXA7f9X6sfXdRoPDgXwPu5VdxfRqvkY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=av79QFhSsGvZIYSyrnjTuWGlqk3SecJ/Vz+6TqbL9U5d+aIXsYJJuhNYhV28ZkDU6
 y0acMeKq+27PQR7fLan9CsdTxLcMJKpo9VYg/sGVWOg0MF4y5xhXhfA3yiDKGlh8cq
 rpnCSbBE8/b2QN/WA4Fbid3ogcV2jCK69tKGnwe7uilde8j7x3RpTWJmtgVFR3KeMt
 jwsXaRkL8FlSQ1G3V3u22gtGQ0v/ImWwYFo72EAnxakss++MuZrlNyKO9wAUqCC3SP
 dNsomMLbjOvagtUOQN9Kf1ADvEB00oG7RUtjNFsyZTKzCwi5Q91PcEbDdwkmoyQJb/
 7GTG+vh/Nb/6g==
Message-ID: <sashiko-outbox-234910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/21] drm/msm/dcp: Add HFI VirtIO transport
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-6-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-6-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:51:45 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Critical] drm/msm/dcp: stack use-after-free on timeout in
  dcp_hfi_send_sync_on_vq()
- [High] drm/msm/dcp: unsynchronized callbacks and work re-arming in
  dcp_hfi_stop()
- [Medium] drm/msm/dcp: double-fetch from shared DMA buffer in
  dcp_hfi_resp_callback()
- [Low] drm/msm/dcp: open-coded 30-40ms sleep polling in
  _dcp_hfi_buf_alloc()
--

commit 340f49f4f52ebdf1a0f2de7503d38dbf0160ca10
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI VirtIO transport

This commit implements the VirtIO transport layer for communicating HFI
commands and responses between the Linux display driver and DCP firmware.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> new file mode 100644
> index 0000000000000..9c46a4560a0de
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c

[ ... ]

> +static struct dcp_hfi_buf *_dcp_hfi_buf_alloc(struct dcp_hfi *hfi,
> +					      struct list_head *free_list,
> +					      spinlock_t *lock,
> +					      const char *pool_name)
> +{
> +	struct dcp_hfi_buf *buf =3D NULL;
> +	unsigned long flags;
> +	int retry;
> +
> +	if (atomic_read(&hfi->shutdown_in_progress)) {
> +		dev_dbg(hfi->dev,
> +			"HFI shutdown in progress =E2=80=94 refusing %s buffer allocation\n",
> +			pool_name);
> +		return NULL;
> +	}
> +
> +	for (retry =3D 0; retry <=3D DCP_HFI_BUF_ALLOC_RETRIES; retry++) {
> +		if (atomic_read(&hfi->shutdown_in_progress))
> +			return NULL;
> +
> +		spin_lock_irqsave(lock, flags);
> +		if (!list_empty(free_list)) {
> +			buf =3D list_first_entry(free_list,
> +					       struct dcp_hfi_buf, node);
> +			list_del(&buf->node);
> +		}
> +		spin_unlock_irqrestore(lock, flags);
> +
> +		if (buf)
> +			return buf;
> +
> +		if (retry < DCP_HFI_BUF_ALLOC_RETRIES)
> +			usleep_range(DCP_HFI_BUF_ALLOC_SLEEP_US_MIN,
> +				     DCP_HFI_BUF_ALLOC_SLEEP_US_MAX);
> +	}

[Severity: Low]
Can _dcp_hfi_buf_alloc() wait on a waitqueue signaled when buffers are
returned to cmd_free_list instead of polling with usleep_range()?  When all
64 command buffers are in flight, sleeping 30-40ms per retry stalls display
commits for multiple frames even if dcp_hfi_cmd_callback() reclaims a
buffer right away.

[ ... ]

> +void dcp_hfi_resp_callback(struct virtqueue *vq)
> +{
> +	struct dcp_drv *drv =3D vq->vdev->priv;
> +	struct dcp_hfi *hfi =3D drv ? drv->hfi : NULL;
> +	struct dcp_hfi_buf *buf;
> +	unsigned int len;
> +	unsigned long drain_flags;
> +
> +	if (!hfi || atomic_read(&hfi->shutdown_in_progress))
> +		return;
> +
> +	spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
> +	virtqueue_disable_cb(vq);
> +	for (;;) {
> +		while ((buf =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> +			struct hfi_cmd_buff_hdl hdl;
> +			struct hfi_header_info hdr_info;
> +			struct hfi_packet_info pkt_info;
> +			u32 pkt_num;
> +			int rc;
> +
> +			spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
> +
> +			if (unlikely(len < sizeof(struct hfi_header) ||
> +				     len > DCP_HFI_BUF_SIZE)) {
> +				dev_warn_ratelimited(hfi->dev,
> +						     "HFI resp: short buffer len=3D%u (min=3D%zu) =E2=80=94 skippi=
ng\n",
> +						     len, sizeof(struct hfi_header));
> +				goto repost;
> +			}
> +
> +			hdl.cmd_buffer =3D buf->data;
> +			hdl.size =3D (u32)len;
> +			rc =3D hfi_unpacker_get_header_info(&hdl, &hdr_info);
> +			if (rc) {
> +				dev_warn_ratelimited(hfi->dev,
> +						     "HFI resp: invalid header (rc=3D%d) len=3D%u\n",
> +					     rc, len);
> +				print_hex_dump(KERN_WARNING, "HFI resp raw: ",
> +					       DUMP_PREFIX_OFFSET, 16, 4,
> +					       buf->data, min_t(u32, len, 64), false);
> +				goto repost;
> +			}
> +
> +			for (pkt_num =3D 1; pkt_num <=3D hdr_info.num_packets; pkt_num++) {
> +				memset(&pkt_info, 0, sizeof(pkt_info));
> +				rc =3D hfi_unpacker_get_packet_info(&hdl, pkt_num,
> +								  &pkt_info);

[Severity: Medium]
Can unpacking directly from the coherent DMA buffer buf->data cause a
double-fetch out-of-bounds read?

buf->data remains mapped and writable by the DCP firmware.
hfi_unpacker_get_packet_info() validates header and packet sizes in
hfi_sanitize_cmd_buff(hdr), then re-reads packet->payload_info from
buf->data:

drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c:hfi_unpacker_get_packet_info() {
    ...
	if (GET_HEADER_SIZE(hdr->cmd_buff_info) > cmd_buf_hdl->size ||
	    packet_num > hdr->num_packets || hfi_sanitize_cmd_buff(hdr))
		return -EINVAL;

	packet =3D hfi_packet_at(hdr, packet_num);
	packet_size =3D GET_PACKET_SIZE(packet->payload_info);
    ...
	packet_info->payload_size =3D packet_size - sizeof(*packet);
}

If the firmware mutates hdr->cmd_buff_info or packet->payload_info in shared
memory after hfi_sanitize_cmd_buff(), hfi_packet_at() can walk past the
buffer or packet_size can underflow packet_info->payload_size, leading to
an out-of-bounds read when dcp_hfi_complete_pending() copies from
pkt_info->payload_ptr.  Copying the received len bytes into a private
buffer before unpacking avoids the double fetch.

[ ... ]

> +static int dcp_hfi_send_sync_on_vq(struct dcp_hfi *hfi,
> +				   struct virtqueue *vq __maybe_unused,
> +				   u32 cmd,
> +				   enum hfi_cmd_buff_type cmd_type,
> +				   u32 object_id,
> +				   enum hfi_packet_payload_type payload_type,
> +				   void *payload,
> +				   u32 payload_size,
> +				   u32 tx_flags,
> +				   void *resp_data,
> +				   size_t resp_len,
> +				   unsigned int timeout_ms)
> +{
> +	struct dcp_hfi_buf *buf;
> +	struct dcp_hfi_completion comp;

[ ... ]

> +	ret =3D dcp_hfi_send_cmd_async(hfi, buf,
> +				     hfi_get_header_size(&hdl), &comp);
> +	if (ret)
> +		return ret;
> +
> +	if (!wait_for_completion_timeout(&comp.done, msecs_to_jiffies(timeout_m=
s))) {
> +		dev_err(hfi->dev,
> +			"HFI cmd=3D0x%x buf_type=3D%s object_id=3D%u timed out after %ums (pk=
t_id=3D%u)\n",
> +			cmd, dcp_hfi_cmd_buff_type_name(cmd_type), object_id,
> +			timeout_ms, packet_id);
> +		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +		dcp_hfi_pending_find(hfi, packet_id);
> +		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +		return -ETIMEDOUT;
> +	}

[Severity: Critical]
Can a timeout in dcp_hfi_send_sync_on_vq() race with
dcp_hfi_complete_pending() and corrupt the stack?

comp lives on the stack of dcp_hfi_send_sync_on_vq().  In
dcp_hfi_resp_callback(), hfi->resp_drain_lock is dropped before calling
dcp_hfi_complete_pending(), and dcp_hfi_pending_find() drops
hfi->pending_lock after erasing comp from hfi->pending_xa:

CPU0                                  CPU1
dcp_hfi_send_sync_on_vq()
  wait_for_completion_timeout(&comp.done)
                                      dcp_hfi_resp_callback()
                                        unlock(&hfi->resp_drain_lock)
                                        dcp_hfi_complete_pending()
                                          comp =3D dcp_hfi_pending_find(...)
                                            /* erased from pending_xa */
  /* times out */
  lock(&hfi->resp_drain_lock)
  dcp_hfi_pending_find(...) -> NULL
  unlock(&hfi->resp_drain_lock)
  return -ETIMEDOUT;
  /* stack frame unwound */
                                          memcpy(comp->resp_data, ...)
                                          comp->status =3D status;
                                          complete(&comp->done);
                                            <-- stack use-after-free

If dcp_hfi_pending_find() on the timeout path returns NULL (because
dcp_hfi_complete_pending() or dcp_hfi_cancel_pending() already claimed
comp), waiting for comp.done with wait_for_completion(&comp.done) before
returning or completing under pending_lock prevents unwinding the stack
while the completion callback is still using comp.

[ ... ]

> +void dcp_hfi_stop(struct dcp_hfi *hfi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hfi->cmd_lock, flags);
> +	atomic_set(&hfi->shutdown_in_progress, 1);
> +	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
> +
> +	cancel_delayed_work_sync(&hfi->resp_repost_work);
> +	dcp_hfi_cancel_pending(hfi, -ENODEV);
> +}
> +
> +void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi)
> +{
> +	struct dcp_hfi_buf *buf;
> +	unsigned int len;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +	if (hfi->cmd_vq)
> +		virtqueue_disable_cb(hfi->cmd_vq);
> +	if (hfi->resp_vq)
> +		virtqueue_disable_cb(hfi->resp_vq);
> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +
> +	if (hfi->cmd_vq) {
> +		while ((buf =3D virtqueue_get_buf(hfi->cmd_vq, &len)) !=3D NULL)
> +			dcp_hfi_buf_free(hfi, buf);
> +		while ((buf =3D virtqueue_detach_unused_buf(hfi->cmd_vq)) !=3D NULL)
> +			dcp_hfi_buf_free(hfi, buf);
> +	}
> +	if (hfi->resp_vq) {
> +		while (virtqueue_get_buf(hfi->resp_vq, &len))
> +			;
> +		while (virtqueue_detach_unused_buf(hfi->resp_vq))
> +			;
> +	}
> +}

[Severity: High]
Can an in-flight dcp_hfi_resp_callback() re-arm resp_repost_work and
repost buffers after dcp_hfi_stop() and during dcp_hfi_quiesce_queues()?

dcp_hfi_resp_callback() only checks shutdown_in_progress at entry, then
drops resp_drain_lock while unpacking packets, and does not re-check
shutdown_in_progress at the repost label:

CPU0                                  CPU1
                                      dcp_hfi_resp_callback()
                                        /* shutdown_in_progress =3D=3D 0 */
                                        lock(&hfi->resp_drain_lock)
                                        buf =3D virtqueue_get_buf(...)
                                        unlock(&hfi->resp_drain_lock)
dcp_hfi_stop()
  atomic_set(&shutdown_in_progress, 1)
  cancel_delayed_work_sync(&resp_repost_work)
                                        goto repost;
                                        lock(&hfi->resp_drain_lock)
                                        virtqueue_add_inbuf_premapped(...)
                                        schedule_delayed_work(&resp_repost_=
work)
                                          <-- re-armed after cancel
                                        virtqueue_enable_cb(vq)
                                        unlock(&hfi->resp_drain_lock)

In addition, dcp_hfi_cmd_callback() checks shutdown_in_progress outside
cmd_lock without re-checking under cmd_lock, and dcp_hfi_quiesce_queues()
disables cmd_vq callbacks under resp_drain_lock and then calls
virtqueue_get_buf() and virtqueue_detach_unused_buf() on both queues
without holding cmd_lock or resp_drain_lock.  Concurrent callback execution
can corrupt the virtqueue state, double-free command buffers onto
cmd_free_list, or run resp_repost_work after teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D6
