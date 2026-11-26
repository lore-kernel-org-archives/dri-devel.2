Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD978606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJAOSkIE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEB21120AC;
	Thu, 26 Nov 2026 06:50:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7F31120AC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EB5A628C2;
 Thu, 26 Nov 2026 06:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E921F000CF;
 Thu, 26 Nov 2026 06:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675811;
 bh=V7/BnOtz1CjPBGCy0b0TS0Wbkzog+/oKDhyve1F/foo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MJAOSkIE5+2tYUB/iRGL7wPEL/h9YGkc4JaSFfMjzCCaVMs2mbr5WI2n7OTDIPONK
 otT5WeatbUJwUfkCPyPYWipRwzZ45st+nJrrrljSCSiGw6x3rVca8XQetv+K07Su03
 ZqWt4IdWcl65ObwsYIrcW5baWjRYrA7HMGi23E2CUBEwX8gDNFz5G28RnDgZXzbbF1
 VicYeXuMpT+/BLInEOFfFykT6La2Cx8TaMep9g9GEcGWBwfIlPauCSfobKRAKy2nfF
 54XYBDY06X+EdgC+QEQf2eGpDDqjoo/kJn5sAkYdFqcCEEbz/JeVEIxx7rE8+2MSNc
 VMiXwWnqAF68A==
Message-ID: <sashiko-outbox-234906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/21] drm/msm/dcp: Route HFI display events
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-12-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-12-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:50:10 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/msm/dcp: unsynchronized frame done state in
  dcp_crtc_hfi_frame_done_cb()
- [Medium] drm/msm/dcp: missing payload validation in
  dcp_hfi_dispatch_frame_done()
- [Medium] drm/msm/dcp: broken vblank count on HFI VSYNC in
  dcp_hfi_dispatch_event()
--

commit 7a2a7eb3a151eeca0e80702b0d7a264c2c4003db
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Route HFI display events

This commit routes asynchronous HFI VSYNC and frame-scan completion events
from DCP firmware to the corresponding DRM CRTC callbacks.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> index 1a1addd33877c..3d0e15cae038f 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
[ ... ]
> @@ -260,12 +261,41 @@ static void dcp_hfi_store_caps_payload(struct dcp_h=
fi *hfi,
>  	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
>  }
> =20
> +static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
> +					const struct hfi_packet_info *pkt_info)
> +{
> +	const struct hfi_display_frame_event_data *frame =3D NULL;
> +	u32 sequence_id =3D 0;
> +	u64 timestamp_ns =3D 0;
> +
> +	if (pkt_info->payload_ptr &&
> +	    pkt_info->payload_size >=3D sizeof(*frame)) {
> +		frame =3D pkt_info->payload_ptr;
> +		sequence_id =3D frame->bufferflip_index;
> +		timestamp_ns =3D ((u64)frame->timestamp_hi << 32) |
> +			       frame->timestamp_lo;
> +	}
> +	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
> +				   sequence_id, timestamp_ns);
> +}

[Severity: Medium]
Should dcp_hfi_dispatch_frame_done() and the HFI_COMMAND_DISPLAY_EVENT_VSYNC
handler below drop packets whose payload is missing or smaller than the
expected event struct instead of still invoking the CRTC callback with zero=
ed
fields?

In dcp_crtc_hfi_frame_done_cb(), sequence_id is compared directly against
dcp_crtc->pending_seq_id:

drivers/gpu/drm/msm/dcp/dcp_crtc.c:dcp_crtc_hfi_frame_done_cb() {
    ...
	if (sequence_id !=3D dcp_crtc->pending_seq_id) {
		drm_warn(crtc->dev,
			 "CRTC%u: ignoring stale FRAME_SCAN_COMPLETE seq=3D%u expected=3D%u\n",
			 dcp_crtc->display_id, sequence_id,
			 dcp_crtc->pending_seq_id);
		return;
	}
    ...
	atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0);
	wake_up(&dcp_crtc->frame_done_wq);
}

When pending_seq_id is 0 (before the first commit or when commit_seq_id wra=
ps
around to 0), a truncated packet with sequence_id =3D 0 matches pending_seq=
_id
and wakes frame_done_wq prematurely; otherwise it triggers an unratelimited
drm_warn().  Similarly, passing timestamp_ns =3D 0 to dcp_crtc_hfi_vblank_c=
b()
leaves dcp_crtc->hw_vblank_timestamp_ns at the previous frame's timestamp.

[Severity: High]
Does routing asynchronous FRAME_SCAN_COMPLETE events into
dcp_crtc_hfi_frame_done_cb() race with dcp_crtc_atomic_flush() and
dcp_crtc_commit_kickoff() over dcp_crtc->pending_seq_id and
dcp_crtc->pending_kickoff_cnt?

Because pending_seq_id and pending_kickoff_cnt are updated without locks ac=
ross
the commit path, several interleavings can occur:

CPU0 (atomic commit)              CPU1 (VirtIO resp callback)
dcp_crtc_commit_kickoff()
  /* prior commit N timed out,
   * leaving pending_seq_id =3D=3D N
   */
  atomic_cmpxchg(&pending_kickoff_cnt,
                 0, 1)
                                  dcp_hfi_dispatch_frame_done()
                                    dcp_crtc_hfi_frame_done_cb()
                                      /* late seq N matches
                                       * pending_seq_id =3D=3D N
                                       */
                                      atomic_add_unless(&pending_kickoff_cn=
t,
                                                        -1, 0)
  pending_seq_id =3D commit_seq_id;
  ...
dcp_crtc_wait_for_commit_done()
  /* returns immediately without
   * waiting for commit N+1
   */

In addition, dcp_crtc_atomic_flush() sends ++dcp_crtc->commit_seq_id to
firmware via dcp_hfi_crtc_set_scan_sequence_id() and enables autorefresh be=
fore
dcp_crtc_commit_kickoff() updates pending_seq_id, so a completion arriving =
in
that window is dropped as stale and stalls the commit until the 500 ms frame
timeout.  And if dcp_hfi_display_commit() fails in dcp_crtc_commit_kickoff()
after dcp_crtc_hfi_frame_done_cb() has already decremented pending_kickoff_=
cnt
to 0, the error path's unconditional atomic_dec(&dcp_crtc->pending_kickoff_=
cnt)
underflows pending_kickoff_cnt to -1, breaking subsequent commits.

>  /* Route asynchronous events and capability packets before flag handling=
. */
>  static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
>  				   const struct hfi_packet_info *pkt_info)
>  {
>  	switch (pkt_info->cmd) {
>  	case HFI_COMMAND_DISPLAY_EVENT_VSYNC: {
> +		const struct hfi_display_vsync_data *vsync =3D NULL;
> +		u64 timestamp_ns =3D 0;
> +
> +		if (pkt_info->payload_ptr &&
> +		    pkt_info->payload_size >=3D sizeof(*vsync)) {
> +			vsync =3D pkt_info->payload_ptr;
> +			timestamp_ns =3D ((u64)vsync->timestamp_hi << 32) |
> +				       vsync->timestamp_lo;
> +		}
> +		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF,
> +				       timestamp_ns);
>  		return true;
>  	}

[Severity: Medium]
Should HFI_COMMAND_DISPLAY_EVENT_VSYNC also propagate vsync->vsync_index so=
 the
CRTC can report a hardware frame counter instead of returning
drm_crtc_vblank_count(crtc) from dcp_crtc_get_vblank_counter()?

drivers/gpu/drm/msm/dcp/dcp_crtc.c:dcp_crtc_get_vblank_counter() {
	return drm_crtc_vblank_count(crtc);
}

In drm_vblank.c, store_vblank() records vblank->last =3D cur_vblank before =
adding
the increment to vblank->count.  Because dcp_crtc_get_vblank_counter() retu=
rns
the software vblank->count, subsequent non-IRQ calls to
drm_update_vblank_count() see cur_vblank !=3D vblank->last even when no fra=
me has
elapsed.  With max_vblank_count =3D 0xffffffff and vblank_disable_immediate=
 =3D
true (set in commit "drm/msm/dcp: Register DCP display pipeline"), every vb=
lank
enable/disable transition spuriously increments vblank->count by 1 while lo=
sing
frames that elapsed while vblank was disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D12
