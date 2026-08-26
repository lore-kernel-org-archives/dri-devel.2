Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9690C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3FD10E318;
	Wed, 26 Aug 2026 16:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+6suJtY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B7C10E31B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:58:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 039216136E;
 Wed, 26 Aug 2026 16:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A721F000E9;
 Wed, 26 Aug 2026 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763479;
 bh=P2wJgQRTp3nlWBgT0lFvkswr2Kww7RtpfJCm0kRRQvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O+6suJtYxJBC+W3w9sfsZnhB4U9Wa20IzhVwk8WKqG5f0Co02Zzhkiijdft6znmDr
 Dh50k9GqmCZysFMcuqi368XBtkhOxQCZuHYQxHq6P4PtZem/V55REv9UDMnk5ND7WS
 Svdpxwk0HXdA2V1Wjsp4dxYxCeS0nUDHJciV49mnCM7VUr9HYb2RxHzPIkjqsnJPG+
 4IGSxzgYErrDpHIjCcx8rACVqFC6g6EFHJv28z810ZtPl2i68GfeSACT/a/wLFQy/+
 vaY5XQeIXb+ckueW5m1sRDsvyIXcAqzisGKmi6OvZnGt60PYEK6PJEAK5RbMIkbcDR
 uRRStANN7iOzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/13] drm/vino: add control-session bring-up
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826163913.7052-8-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-8-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:57:59 +0000
Message-Id: <20260826165759.81A721F000E9@smtp.kernel.org>
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
- [High] The driver encrypts `stream_open` messages for unoccupied connecto=
rs using a randomly generated video key that is never transmitted to the do=
ck, permanently breaking hotplug for those connectors.
- [High] EDID crosstalk in Navarro discovery due to missing wait loop for a=
synchronous replies, causing one connector to claim another's EDID.
- [High] AES-CTR keystream reuse and control protocol desynchronization whe=
n an EDID transmission times out.
--

commit fa0367d27511540d9b322089cdf1062994527dcc
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add control-session bring-up

Bringing a dock up runs once per bind, in order: a plaintext initialisation
preamble, the link AKE, then the sealed setup burst that authenticates each
downstream connector, transitions the video engine and reads back what the
dock will answer.

> diff --git a/drivers/gpu/drm/vino/session/setup.rs b/drivers/gpu/drm/vino=
/session/setup.rs
> new file mode 100644
> index 0000000000000..b278ebcf4b4e5
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/session/setup.rs

[ ... ]

> +                if i >=3D 3 && !rrx_applied {
> +                    let Some(rrx_h) =3D fresh_rrx else {
> +                        // No `rrx` means this connector never began a d=
ownstream authentication,
[ ... ]
> +                        vino_debug!(
> +                            "vino: socket {socket} has no downstream sin=
k (no AKE_Send_Rrx); skipping its authentication\n"
> +                        );
> +                        Self::announce_stream(link, &mut out_q, profile,=
 connector)?;
> +                        continue 'per_head;
> +                    };

[ ... ]

> +            for connector in 0..connector_count {
> +                settle_polls!(profile.protocol.setup_polls.before_open(c=
onnector as u8));
> +                let stream_id =3D profile.geometry().stream_id(connector=
 as u8);
> +                let mut vkey =3D kernel::crypto::Secret::<16>::zeroed();
> +                vkey.copy_from_slice(&video_keys[connector][..16]);
> +                let mut vnonce =3D [0u8; 8];
> +                vnonce.copy_from_slice(&video_keys[connector][16..24]);
> +                let content =3D cp::stream_open(profile.protocol.stream_=
marker_kind);
> +                let open =3D cp::seal_video_arm(&vkey, &vnonce, stream_i=
d, 0x000a, 0, &content)?;
> +                link.ctrl_send(&open, timeout(), GFP_KERNEL)?;

[Severity: High]
Will this break hotplug functionality for unoccupied connectors on DL-3x00
docks?

When initializing a dock with an unplugged connector (where video_on_ctrl_p=
ipe
is true), the per_head loop aborts early via continue 'per_head. This means
SKE_Send_Eks is skipped and the generated video key is never sent to the do=
ck.

Later in send_cp_setup(), the driver attempts to open the stream using this
same unsent, randomly generated key to encrypt the stream_open message. The
dock won't be able to decrypt this message, causing the stream to fail to
open, which leads to permanent black screens if a monitor is subsequently
plugged in.

[ ... ]

> +            for connector in 0..connector_count {
[ ... ]
> +                let fetch =3D cp::get_edid_req(cp_ctr, hu8)?;
> +                navarro_send!(0x15, fetch);
> +                // The fetch drain carries the asynchronous EDID in the =
working DLM cadence.
> +                edid_connectors[connector] =3D edid_out.take();
> +                discovery_deferred[connector] =3D edid_connectors[connec=
tor].is_none();
> +            }

[Severity: High]
Is there a risk of EDID crosstalk here if the downstream panel's DDC read
takes longer than the 10ms timeout used in the navarro_send! macro?

During Navarro EDID discovery, if the fetch times out (yielding no EDID), t=
he
loop advances to the next connector and issues a readiness kick. While
draining responses for the new connector's commands, the delayed EDID reply
from the previous connector could arrive.

Because drain_ep84() unconditionally assigns any parsed EDID to edid_out
without checking the connector ID, the current connector might mistakenly
claim the delayed EDID from the previous one, causing monitors to be
identified incorrectly.

[ ... ]

> +            for connector in 0..connector_count {
[ ... ]
> +                'discovery: {
> +                    macro_rules! edid_send {
> +                        ($ep:expr, $body:expr, $tag:expr) =3D> {{
> +                            match Self::send_live_cp(
> +                                link,
> +                                session,
> +                                ep84_q.as_mut(),
> +                                &mut resp,
> +                                edid_out,
> +                                $ep,
> +                                wseq,
> +                                &$body,
> +                            ) {
> +                                Ok(e) =3D> {
[ ... ]
> +                                }
> +                                Err(e) =3D> {
> +                                    transport_error =3D Some(e);
> +                                    break 'discovery;
> +                                }
> +                            }
> +                        }};
> +                    }

[Severity: High]
Does this error path lead to AES-CTR keystream reuse and control protocol
desynchronization?

If send_live_cp() fails (e.g., due to a USB timeout) during Ridge EDID
discovery, the edid_send! macro sets transport_error and breaks out of the
'discovery block. This skips the increments for both the AES-CTR block
counter (wseq) and the message counter (cp_ctr).

When the outer loop advances to the next connector, it encrypts the new
request using the exact same wseq and cp_ctr.

This reuse breaks cryptographic confidentiality. Additionally, if the dock
successfully received the initial message but the host timed out waiting for
the ACK, the dock will reject the next message due to the reused sequence
numbers, permanently breaking the session.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D7
