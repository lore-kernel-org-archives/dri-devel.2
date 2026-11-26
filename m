Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46569606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrAdwa7y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88307112095;
	Thu, 26 Nov 2026 06:50:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B05C112095
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:50:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D82F462847;
 Thu, 26 Nov 2026 06:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D140F1F000C4;
 Thu, 26 Nov 2026 06:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675800;
 bh=QCDkAT6+hHJvwSqTU6cjZl+MQruQ2g6rjvNoYJnk/f4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrAdwa7yE7lb4UWh9j0DVhoK3V6A6jr6mDNw9RxSGnAqxUiEUx01v1fgod3KQjiW0
 5v2Kv+9N6RzEcRd/jwySGIIhIyWTLZtEdqfgrqoXbVoBP10sZKWDc3KfdqkxXIsIzw
 NdR80wcSmCEYzapHK2uZG0byo+lNEH6TnJtDPSOv45T4eEkbhNFIBCMSB/2TbcHhPq
 AWuUQo0FlRbcrMEwK7z4UokWCq3mT04ebP4g+0YD+xuWjCjdWt0SkiYDmX7wVbWQzR
 BAGVQdiyYgZilZfexesjn9IgPNXIgH3AC2yDbt6gy/h2Zxm6LqkRA/dd0B7rSrlRnD
 opZ5UqVuwP+hg==
Message-ID: <sashiko-outbox-234904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/21] drm/msm/dcp: Handle asynchronous HFI responses
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-7-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-7-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:49:59 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/msm/dcp: uninitialized caps_cache completions in
  dcp_hfi_init() and deinit
- [High] drm/msm/dcp: race scheduling resource_vote_work after
  dcp_hfi_stop()
- [Medium] drm/msm/dcp: malformed RESOURCE_VOTE clobbers pending vote in
  dcp_hfi_dispatch_event()
- [Medium] drm/msm/dcp: unconsumed vote state in
  dcp_hfi_resource_vote_work()
- [Medium] drm/msm/dcp: missing power-control handling in
  dcp_hfi_dispatch_event()
--

commit e810b83b6a7c8b39206eb3014fc0813a600fec0a
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Handle asynchronous HFI responses

This commit dispatches asynchronous HFI display events, caches capability
payloads, and defers resource-vote processing to a work item before
falling back to synchronous command completion handling.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> index 9c46a4560a0de..1a1addd33877c 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
[ ... ]
> @@ -228,6 +233,191 @@ void dcp_hfi_cmd_callback(struct virtqueue *vq)
>  	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
>  }
> =20
> +static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
> +				       struct completion *done,
> +				       u8 *dst, u32 *dst_len,
> +				       const struct hfi_packet_info *pkt_info,
> +				       const char *name)
> +{
> +	u32 n;
> +
> +	if (!pkt_info->payload_ptr || !pkt_info->payload_size) {
> +		dev_dbg(hfi->dev, "%s: empty payload\n", name);
> +		return;
> +	}
> +
> +	if (pkt_info->payload_size > DCP_HFI_CAPS_BUF_SIZE) {
> +		dev_warn(hfi->dev, "%s: payload too large: %u\n",
> +			 name, pkt_info->payload_size);
> +		return;
> +	}
> +
> +	n =3D pkt_info->payload_size;
> +	memcpy(dst, pkt_info->payload_ptr, n);
> +	*dst_len =3D n;
> +	if (done)
> +		complete(done);
> +	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
> +}
> +
> +/* Route asynchronous events and capability packets before flag handling=
. */
> +static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
> +				   const struct hfi_packet_info *pkt_info)
> +{
> +	switch (pkt_info->cmd) {
> +	case HFI_COMMAND_DISPLAY_EVENT_VSYNC: {
> +		return true;
> +	}

[Severity: Medium]
Does dcp_hfi_dispatch_event() omit handling for display power-control
messages?

The commit message states that display power control produces asynchronous
responses and that this patch delivers power-control notifications, but
neither HFI_COMMAND_DISPLAY_POWER_CONTROL nor
HFI_COMMAND_DISPLAY_EVENT_POWER is handled here.  Any asynchronous
power-control response with HFI_RX_FLAGS_SUCCESS or
HFI_RX_FLAGS_INFORMATION will fall through in dcp_hfi_resp_callback() to
dcp_hfi_complete_pending().

[ ... ]

> +	case HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE: {
> +		unsigned long vote_flags;
> +		u32 payload_size =3D pkt_info->payload_size;
> +		bool valid =3D pkt_info->payload_ptr && payload_size &&
> +			payload_size <=3D DCP_HFI_RESOURCE_VOTE_BUF_SIZE &&
> +			payload_size % sizeof(struct dcp_resource_vote_wire) =3D=3D 0;
> +
> +		if (!valid) {
> +			dev_warn_ratelimited(hfi->dev,
> +					     "dropping malformed RESOURCE_VOTE payload size=3D%u max=3D%u\n=
",
> +					     payload_size, DCP_HFI_RESOURCE_VOTE_BUF_SIZE);
> +			payload_size =3D 0;
> +		}
> +
> +		spin_lock_irqsave(&hfi->resource_vote_lock, vote_flags);
> +		if (payload_size)
> +			memcpy(hfi->resource_vote_buf, pkt_info->payload_ptr,
> +			       payload_size);
> +		hfi->resource_vote_len =3D payload_size;
> +		hfi->resource_vote_generation++;
> +		spin_unlock_irqrestore(&hfi->resource_vote_lock, vote_flags);
> +
> +		if (payload_size)
> +			schedule_work(&hfi->resource_vote_work);
> +		return true;
> +	}

[Severity: Medium]
When a malformed HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE packet arrives,
does setting payload_size =3D 0 and continuing discard a previously buffered
valid resource vote?

Instead of returning early on !valid, this overwrites
hfi->resource_vote_len =3D 0 and increments hfi->resource_vote_generation,
so dcp_hfi_resource_vote_work() sees len =3D=3D 0 and returns without
delivering the earlier unconsumed vote.

[ ... ]

> @@ -642,6 +834,47 @@ int dcp_hfi_send_no_wait(struct dcp_hfi *hfi,
>  			payload_type, payload, payload_size, HFI_TX_FLAGS_NONE);
>  }
> =20
> +static void dcp_hfi_resource_vote_work(struct work_struct *work)
> +{
> +	struct dcp_hfi *hfi =3D container_of(work, struct dcp_hfi,
> +					     resource_vote_work);
> +	u8 buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
> +	struct dcp_resource_vote_pair pairs[DCP_HFI_RESOURCE_VOTE_BUF_SIZE /
> +							 sizeof(struct dcp_resource_vote_wire)];
> +	const struct dcp_resource_vote_wire *wire;
> +	u32 len, generation, count, i;
> +	bool dirty;
> +	unsigned long flags;
> +
> +	do {
> +		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
> +		len =3D hfi->resource_vote_len;
> +		generation =3D hfi->resource_vote_generation;
> +		if (len)
> +			memcpy(buf, hfi->resource_vote_buf, len);
> +		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
> +
> +		if (!len || !hfi->resource_vote_cb)
> +			return;
> +		if (len % sizeof(struct dcp_resource_vote_wire)) {
> +			dev_warn_ratelimited(hfi->dev,
> +					     "dropping malformed RESOURCE_VOTE size=3D%u\n", len);
> +			return;
> +		}
> +		count =3D len / sizeof(struct dcp_resource_vote_wire);
> +		wire =3D (const struct dcp_resource_vote_wire *)buf;
> +		for (i =3D 0; i < count; i++) {
> +			pairs[i].key =3D le32_to_cpu(wire[i].key);
> +			pairs[i].value =3D get_unaligned_le64(&wire[i].value);
> +		}
> +
> +		hfi->resource_vote_cb(hfi->drv, pairs, count);
> +		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
> +		dirty =3D generation !=3D hfi->resource_vote_generation;
> +		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
> +	} while (dirty);
> +}

[Severity: Medium]
Does dcp_hfi_resource_vote_work() invoke hfi->resource_vote_cb() twice
with the same vote when a new vote arrives while the worker is already
running?

Because the workqueue core clears WORK_STRUCT_PENDING_BIT before running
dcp_hfi_resource_vote_work(), an HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE
event arriving while the worker is in hfi->resource_vote_cb() both causes
the do-while(dirty) loop to consume the new generation and causes
schedule_work(&hfi->resource_vote_work) to queue a second run.  Since
hfi->resource_vote_len is never cleared when snapshotting
hfi->resource_vote_buf, the queued second run sees the same non-zero
hfi->resource_vote_len and delivers the stale vote again.  Clearing
hfi->resource_vote_len =3D 0 under hfi->resource_vote_lock when copying
hfi->resource_vote_buf (and looping while hfi->resource_vote_len !=3D 0)
would avoid duplicate callbacks.

[ ... ]

> @@ -807,6 +1047,7 @@ void dcp_hfi_stop(struct dcp_hfi *hfi)
>  	atomic_set(&hfi->shutdown_in_progress, 1);
>  	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
> =20
> +	cancel_work_sync(&hfi->resource_vote_work);
>  	cancel_delayed_work_sync(&hfi->resp_repost_work);
>  	dcp_hfi_cancel_pending(hfi, -ENODEV);
>  }

[Severity: High]
Can dcp_hfi_resp_callback() re-schedule hfi->resource_vote_work after
cancel_work_sync() in dcp_hfi_stop() returns?

dcp_hfi_resp_callback() checks hfi->shutdown_in_progress only once on
entry and drops hfi->resp_drain_lock while unpacking packets and calling
dcp_hfi_dispatch_event():

CPU0                                  CPU1
dcp_hfi_resp_callback()
  !atomic_read(&shutdown_in_progress)
  spin_unlock(&hfi->resp_drain_lock)
                                      dcp_hfi_stop()
                                        atomic_set(&shutdown_in_progress, 1)
                                        cancel_work_sync(&resource_vote_wor=
k)
  dcp_hfi_dispatch_event()
    schedule_work(&resource_vote_work)
                                      dcp_hfi_deinit()
                                      /* hfi / drv torn down */
                                      dcp_hfi_resource_vote_work()
                                        <-- runs after stop / use-after-free

Neither HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE in
dcp_hfi_dispatch_event() nor dcp_hfi_resource_vote_work() checks
hfi->shutdown_in_progress, and resource_vote_work is not cancelled again
after virtqueue callbacks are synchronized.

> @@ -864,6 +1105,10 @@ int dcp_hfi_restore_queues(struct dcp_hfi *hfi, str=
uct virtqueue *cmd_vq,
> =20
>  void dcp_hfi_deinit(struct dcp_hfi *hfi)
>  {
> +	mutex_lock(&hfi->caps_cache_lock);
> +	memset(&hfi->caps_cache, 0, sizeof(hfi->caps_cache));
> +	mutex_unlock(&hfi->caps_cache_lock);
> +
>  	xa_destroy(&hfi->pending_xa);

[Severity: High]
Are hfi->caps_cache.device_done and hfi->caps_cache.display_done left
uninitialized in dcp_hfi_init() and wiped by memset() in dcp_hfi_deinit()?

dcp_hfi_init() allocates struct dcp_hfi with devm_kzalloc() and pre-posts
response buffers to resp_vq without calling init_completion() on
device_done or display_done, and dcp_hfi_deinit() zeroes the entire
caps_cache structure with memset() without holding hfi->caps_lock.  A
zeroed struct completion has wait.task_list.next =3D=3D NULL, so when
HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS or
HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS arrives and
dcp_hfi_store_caps_payload() calls complete(done), swake_up_locked() sees
!list_empty(&q->task_list) and dereferences a NULL pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D7
