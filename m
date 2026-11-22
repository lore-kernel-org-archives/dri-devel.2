Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD9606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYm6DYK0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732F710E183;
	Sun, 22 Nov 2026 03:44:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67EF10E183
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:43:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A218944DBA;
 Sun, 22 Nov 2026 03:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6131F000CA;
 Sun, 22 Nov 2026 03:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795319036;
 bh=pqdZbhxTgUmCe/G0ZqipMN/PIJFJiELSj7E/x1RB16Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CYm6DYK0+4PHGe8XCggriYwA65bi8bIOibvbuToVAQmP1dVz9+TXeXDuzEDK5nfyu
 Z6QV5gORDidxNueLzgVUBYzYkeDbJG2HsYGMBoQgl6x04d3MYgw/dbU3zz1jK5Ok/8
 x+7gSRbpvMgKNeZj4LY1TJ9oBZNjNtHCxaB8Y9E7xxuUCH0mtIek6Ww+oYtJQ9KVu0
 8hjEys4lQc+on4txjoRCkdyOxqhGiXYDDG0nYZ5zBDPwkvf92sW6I+LmNCeBmXEVx4
 W9GVTvJkD8VxvpIWCQ0iUBSoSocNaSjvbl2i3o0rrHQp4tYssFq7G2dF/KxC5p6bjK
 E4SITLtJl/b0Q==
Message-ID: <sashiko-outbox-227681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
To: vishnu.saini@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261122-lt9611usc_edid34_misc_next-v5-1-00b562fe4a24@oss.qualcomm.com>
References: <20261122-lt9611usc_edid34_misc_next-v5-1-00b562fe4a24@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:43:55 +0000
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
- [High] drm/bridge: lt9611uxc: race in lt9611uxc_get_edid_block() SRAM
  polling
- [Medium] drm/bridge: lt9611uxc: 0xb028 not reset in
  lt9611uxc_get_edid_block()
- [Medium] drm/bridge: lt9611uxc: missed edid_read reset in
  lt9611uxc_hpd_work()
- [Medium] drm/bridge: lt9611uxc: concurrent EDID race in
  lt9611uxc_get_edid_block()
--

commit 8673240c50c833c65a09b1b2cab593e96281a4c4
Author: Ravi Agola <raviagol@qti.qualcomm.com>

drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks

This commit extends EDID reading on the LT9611UXC bridge to support up to
4 blocks by triggering paired block fetches via register 0xb028 and
polling the shared two-block SRAM buffer, resets edid_read on HPD
disconnect, and increases the EDID wait timeout to 1000 ms.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> index b3bb7f2cebb3b..d5924a8df1f94 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c

[ ... ]

> @@ -167,6 +167,8 @@ static void lt9611uxc_hpd_work(struct work_struct *wo=
rk)
> =20
>  	mutex_lock(&lt9611uxc->ocm_lock);
>  	connected =3D lt9611uxc->hdmi_connected;
> +	if (!connected)
> +		lt9611uxc->edid_read =3D false;
>  	mutex_unlock(&lt9611uxc->ocm_lock);
> =20
>  	drm_bridge_hpd_notify(&lt9611uxc->bridge,

[Severity: Medium]
Can an HPD disconnect followed by a reconnect before lt9611uxc_hpd_work()
acquires ocm_lock leave lt9611uxc->edid_read stale?

IRQ thread                        kworker
lt9611uxc_irq_thread_handler()
  lt9611uxc_lock()
  /* HPD disconnect */
  lt9611uxc->hdmi_connected =3D false;
  schedule_work(&lt9611uxc->work)
  lt9611uxc_unlock()
    msleep(50)
                                  lt9611uxc_hpd_work()
                                    mutex_lock(&lt9611uxc->ocm_lock)
lt9611uxc_irq_thread_handler()
  lt9611uxc_lock()
  /* HPD reconnect */
  lt9611uxc->hdmi_connected =3D true;
  schedule_work(&lt9611uxc->work)
  lt9611uxc_unlock()
                                    connected =3D lt9611uxc->hdmi_connected;
                                    if (!connected)  <-- skipped
                                      lt9611uxc->edid_read =3D false;

When an HPD pulse or quick replug happens while ocm_lock is held across
msleep(50) in lt9611uxc_unlock() (or while an earlier work run is still
inside drm_bridge_hpd_notify()), lt9611uxc_hpd_work() only observes
hdmi_connected =3D=3D true and never clears edid_read.  The subsequent
lt9611uxc_wait_for_edid() then returns immediately instead of waiting for
the new EDID interrupt.  lt9611uxc_bridge_detect() also updates
hdmi_connected without clearing edid_read on disconnect.

Clearing lt9611uxc->edid_read directly where disconnection is observed in
lt9611uxc_irq_thread_handler() and lt9611uxc_bridge_detect() would avoid
missing the transition.

[ ... ]

> @@ -394,20 +422,55 @@ static int lt9611uxc_get_edid_block(void *data, u8 =
*buf, unsigned int block, siz
>  	if (block >=3D EDID_NUM_BLOCKS)
>  		return -EINVAL;
> =20
> -	lt9611uxc_lock(lt9611uxc);
> -
> -	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
> -
> -	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
> -
> -	ret =3D regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> -	if (ret)
> -		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
> +	if (block =3D=3D 0 || block =3D=3D 2) {
> +
> +		lt9611uxc_lock(lt9611uxc);
> +
> +		edid_ready_flag =3D (block =3D=3D 0) ? BIT(0) : BIT(1);
> +
> +		/*
> +		 * The bridge only buffers 2 EDID blocks at a time. Writing
> +		 * 0xb028 re-triggers it to fetch a fresh pair of blocks
> +		 * (0+1, or 2+3) from the sink over DDC into that buffer, an
> +		 * asynchronous operation with no separate "fetch done" flag
> +		 * to wait on.
> +		 */
> +		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
> +
> +		lt9611uxc_unlock(lt9611uxc);
> +
> +		do {
> +			msleep(100);
> +			ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +			if (ret)
> +				break;
> +			/*
> +			 * Poll for the fetch to complete: block 0 is only
> +			 * valid once it carries the EDID header magic, and
> +			 * block 2 (an extension block) is only valid once it
> +			 * no longer carries that same magic left over from
> +			 * the previous fetch at this buffer offset.
> +			 */
> +			header_matched =3D (memcmp(edid_header, buf, 8) =3D=3D 0);
> +			edid_valid =3D (block =3D=3D 0 && header_matched) ||
> +				     (block =3D=3D 2 && !header_matched);
> +			if (edid_valid)
> +				break;
> +
> +		} while (retry_cnt-- > 0);

[Severity: High]
Can this loop return a partially written EDID block if lt9611uxc_lock()
halts the on-chip MCU after the first 8 bytes of the 256-byte SRAM buffer
have been updated, but before the rest of the block pair has been fetched
over DDC?

Each poll iteration halts the MCU via 0x80ee =3D 0x01 and reads 128 bytes
from offset 0.  For block 2 in particular, !header_matched becomes true as
soon as the MCU overwrites byte 0 of offset 0, even if bytes 8..127 of
block 2 and bytes 128..255 of companion block 1 or 3 have not been written
to SRAM yet.  The subsequent call for block 1 or block 3 then immediately
reads offset 128 in the else branch with no completion check and clears
0xb028, returning torn or stale EDID data.

> +
> +		if (!ret && !edid_valid)
> +			ret =3D -ETIMEDOUT;
> +	} else {
> +		ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> =20
> -	lt9611uxc_unlock(lt9611uxc);
> +		lt9611uxc_lock(lt9611uxc);
> +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> +		lt9611uxc_unlock(lt9611uxc);
> +	}
> =20
> -	return 0;
> -};
> +	return ret;
> +}

[Severity: Medium]
Does register 0xb028 stay set to BIT(0) or BIT(1) when a display has 1 or
3 EDID blocks, or when reading block 0 or block 2 fails or is retried?

0xb028 is only reset to 0x00 in the else branch for odd blocks (1 and 3),
but _drm_do_get_edid() stops after block 0 when there are no extensions
and after block 2 when there are 2 extensions:

drivers/gpu/drm/drm_edid.c:_drm_do_get_edid() {
	...
	if (!edid_extension_block_count(edid))
		goto ok;
	...
	num_blocks =3D edid_block_count(edid);
	for (i =3D 1; i < num_blocks; i++) {
		void *block =3D (void *)edid_block_data(edid, i);

		status =3D edid_block_read(block, i, read_block, context);
	...
}

In addition, if edid_block_check() fails on block 2, edid_block_read()
retries block 2 directly without reading block 3 in between.  Because
0xb028 was not cleared and offset 0 already holds non-header bytes from
the failed attempt rather than block 0's magic header,
(block =3D=3D 2 && !header_matched) matches immediately on the first poll
iteration without waiting for a fresh fetch.

[Severity: Medium]
What prevents two concurrent EDID reads from clobbering register 0xb028
and the shared two-block hardware buffer across the unlocked polling loop
and between paired block reads?

kworker (HPD notify)              userspace (GETCONNECTOR)
lt9611uxc_bridge_hpd_notify()     drm_bridge_connector_get_modes_edid()
  lt9611uxc_bridge_edid_read()      ...
    lt9611uxc_get_edid_block(blk 2)   lt9611uxc_bridge_edid_read()
      write 0xb028 =3D BIT(1)             lt9611uxc_get_edid_block(blk 0)
      lt9611uxc_unlock()                  write 0xb028 =3D BIT(0)
      msleep(100)                         ...
      /* buffer now holds blk 0+1 */
      read_edid_block(blk 2)  <-- sees block 0 header, times out

lt9611uxc_hpd_work() invokes lt9611uxc_bridge_hpd_notify() under
bridge->hpd_mutex without dev->mode_config.mutex, while connector probing
invokes drm_bridge_edid_read() under dev->mode_config.mutex without
bridge->hpd_mutex.  Because ocm_lock is dropped across msleep(100) and
between blocks 0/1 and 2/3, a concurrent reader starting at block 0 can
switch 0xb028 back to BIT(0) (or finish block 1 and write 0x00) while the
first reader is polling block 2 or about to read block 3 from offset 128,
causing spurious -ETIMEDOUT failures or returning block 1 data in place of
block 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-lt9611usc_=
edid34_misc_next-v5-1-00b562fe4a24@oss.qualcomm.com?part=3D1
